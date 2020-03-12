BEGIN
        DBMS_SQLTUNE.EXECUTE_TUNING_TASK (task_name => :SQLTUNINGTASK_NAME);
END; 


DECLARE
        job BINARY_INTEGER := :job;
        next_date TIMESTAMP
WITH TIME ZONE := :mydate;
broken      BOOLEAN      := FALSE;
job_name    VARCHAR2(30) := :job_name;
job_subname VARCHAR2(30) := :job_subname;
job_owner   VARCHAR2(30) := :job_owner;
job_start TIMESTAMP
WITH TIME ZONE := :job_start;
job_scheduled_start TIMESTAMP
WITH TIME ZONE := :job_scheduled_start;
window_start TIMESTAMP
WITH TIME ZONE := :window_start;
window_end TIMESTAMP
WITH TIME ZONE := :window_end;
chain_id          VARCHAR2(14) := :chainid;
credential_owner  VARCHAR2(30) := :credown;
credential_name   VARCHAR2(30) := :crednam;
destination_owner VARCHAR2(30) := :destown;
destination_name  VARCHAR2(30) := :destnam;
job_dest_id       VARCHAR2(14) := :jdestid;
BEGIN
        BEGIN
                dbms_sqltune.execute_tuning_task('SQL_TUNING_1341924186499');
        END;
        :mydate := next_date;
        IF broken THEN
                :b := 1;
        ELSE
                :b := 0;
        END IF;
END; 

---IMPORTA O SQLTUNE
--CRIA A TABELA (NOS 2 BANCOS)
EXEC DBMS_SQLTUNE.CREATE_STGTAB_SQLSET(table_name => 'STGTAB_SQLSET');

--IMPORTA OS OBJETOS
EXEC DBMS_SQLTUNE.PACK_STGTAB_SQLSET(sqlset_name        => 'WORKORDER', -
                                     sqlset_owner       => 'IFRMAXIMO', -
                                     staging_table_name => 'STGTAB_SQLSET', -
                                     staging_schema_owner => 'IFRDBA');
                                     

--IMPORTA O SQLPROFEILE   
--CRIA A TABELA (NOS 2 BANCOS)                                 
EXEC DBMS_SQLTUNE.CREATE_STGTAB_SQLPROF (table_name => 'PROFILE_STGTAB');

--IMPORTA OS OBJETOS
EXEC DBMS_SQLTUNE.PACK_STGTAB_SQLPROF (profile_category => '%', -
                                      staging_table_name => 'PROFILE_STGTAB');

--EXPORT
exp  ifrdba tables=PROFILE_STGTAB file=exp_PROFILE_STGTAB.dmp log=exp_PROFILE_STGTAB.log

--COPIA
scp exp_PROFILE_STGTAB.dmp oracle@10.0.17.131:exp_PROFILE_STGTAB.dmp

--IMPORTA
imp ifrdba full=y file=/home/oracle/exp_PROFILE_STGTAB.dmp log=impPROFILE_STGTAB.log ignore=y


--IMPORTA OS PROFILES
EXEC DBMS_SQLTUNE.UNPACK_STGTAB_SQLPROF(replace            => TRUE, -
                                        staging_table_name => 'PROFILE_STGTAB');
--CHECK
select NAME, CATEGORY, SIGNATURE, CREATED from dba_sql_profiles;

--SQL
select h.attr_val as outline_hints
  from dba_sql_profiles p
      ,sys.sqlprof$attr h
 where p.signature = h.signature
       and p.category = h.category
       and p.name like ('MY_SQL_PROFILE')
 order by h.attr#;
 
 

--SITE

http://davidalejomarcos.wordpress.com/2010/10/21/how-to-copy-sql-profile-from-one-database-to-another-one/


http://oracletechtips.com/2012/sql-profile-creation-and-migration-using-sqlt/

http://www.emarcel.com/oracledba/162-copy-sql-profiles-to-another-database

http://books.google.com.br/books?id=1ryN1kK8PMoC&pg=PA426&lpg=PA426&dq=UNPACK_STGTAB_SQLPROF&source=bl&ots=rzo-7IYmze&sig=CqLcSiXjrIAByGUlcuf-nP724XI&hl=pt-BR&sa=X&ei=djj8T_7oAsal6wGmq7X0Bg&ved=0CEwQ6AEwADgK#v=onepage&q=UNPACK_STGTAB_SQLPROF&f=false

http://my-ora-tuning.blogspot.com.br/2010/09/sql-profile-export.html

http://my-ora-tuning.blogspot.com.br/2010_09_01_archive.html

http://ba6.us/book/export/html/117