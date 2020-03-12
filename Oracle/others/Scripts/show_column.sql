 rem |   Gera relatório (sos_cria_&aplic.sql) com as informações de uma
 rem |       aplicacao informado
 rem |
 rem | parametros: nome da aplicacao
 rem |

-- parametrização necessaria
 set line 132
 set pause "click <enter>....."
 set pause off
 set heading off
 set echo off
 set verify off
 SET FEEDBACK OFF
 SET PAGESIZE 1000

 ACCEPT dono PROMPT 'DIGITE O NOME DA APLICAÇÃO: '
 set echo on
 ACCEPT OK
 set echo off
 ACCEPT dblink PROMPT 'DIGITE O NOME DO DB-LINK (S/ @): '
 set echo on
 ACCEPT OK
 set echo off
 ACCEPT tsind PROMPT 'DIGITE O NOME DA TABLESPACE DE INDICES: '
 set echo on
 ACCEPT OK
 set echo off
 
 SET SERVEROUTPUT ON SIZE 100000

 spool c:\ronei\scripts\tab_not_found_&dono..sql
-- confere existência das tabelas 
 select ' ' from dual;
 select '--### confere existência das tabelas 'from dual;
 select ' NAO ENCONTRADA => '||tabela
 from tabelas@&dblink
 where aplicacao = '&dono' and
       tabela not in (select table_name from all_tables where table_name=tabela);
 spool off

 spool c:\ronei\scripts\cria_refer_&dono..sql
-- gera comando para habilitar grant references  
 select ' ' from dual;
 select '--### gera comando para habilitar grant references' from dual;
 select DISTINCT 'grant references on '||A.table_name||' to XXXXX;'
 from all_constraints A, all_constraints B, tabelas@&dblink C
 where C.aplicacao='&dono' and
       B.owner <> C.owner and B.table_name = C.tabela and B.constraint_type='R' and
       A.owner=B.r_owner and A.constraint_name=B.r_constraint_name
 group by A.table_name;
 spool off

 spool c:\ronei\scripts\cria_tab_&dono..sql
-- gera comando para criação e inserção dos dados em uma tabela auxiliar 
 select ' ' from dual;
 select '--### gera comando para criação e inserção dos dados em uma tabela auxiliar' from dual;
 select 'create table XXXXX.'||tabela||' as select * from '||owner||'.'||tabela||'@oracle.world;'
 from tabelas@&dblink
 where aplicacao = '&dono';
 spool off

 spool c:\ronei\scripts\cria_trun_&dono..sql
-- gera comando para deletar os dados das tabelas 
 select ' ' from dual;
 select '--### gera comando para deletar os dados das tabelas' from dual;
 select 'truncate table XXXXX.'||tabela||';'
 from tabelas@&dblink
 where aplicacao = '&dono';
 spool off

 spool c:\ronei\scripts\cria_pk_&dono..sql
-- gera comando para criação da constraint primary key
 select ' ' from dual;
 select '--### gera comando para criação da constraint primary key' from dual;

DECLARE
 virg       varchar2(1);
 my_ow      all_cons_columns.owner%type;
 my_tab     all_cons_columns.table_name%type;
 my_pk      all_cons_columns.constraint_name%type;
 my_col     all_cons_columns.column_name%type;

 cursor c1 is
   select B.owner,B.table_name,B.constraint_name
   from all_constraints B, tabelas@&dblink A
   where A.aplicacao='&dono' and
         B.owner = A.owner and B.table_name = A.tabela and B.constraint_type='P';
 cursor c2 is
          select column_name 
          from all_cons_columns
          where owner=my_ow and constraint_name=my_pk
          order by position;
BEGIN 
 OPEN C1;
 LOOP
    FETCH C1 inTO my_ow, my_tab, my_pk ;
       EXIT WHEN C1%NOTFOUND;
        dbms_output.put ('ALTER TABLE XXXXX.');
        dbms_output.put_line (my_tab);
        dbms_output.put_line ('add constraint '||my_pk||' primary key');
        dbms_output.put ('(');
        begin
          open c2;
          virg := ' '; 
          loop
             fetch c2 into my_col;
             exit when c2%notfound;
             dbms_output.put (virg); 
             dbms_output.put (my_col);
             virg := ','; 
          end loop;
          close c2;
        end;
        dbms_output.put_line (');');
 END LOOP;
 CLOSE C1;
 END;
/
 spool off

 spool c:\ronei\scripts\cria_fk_&dono..sql
-- gera comando para criação das constraints foreign key
 select ' ' from dual;
 select '--### gera comando para criação das constraints foreign key' from dual;
DECLARE
 virg       varchar2(1);
 my_ow      all_cons_columns.owner%type;
 my_tab     all_cons_columns.table_name%type;
 my_fk      all_cons_columns.constraint_name%type;
 my_ow_ref  all_cons_columns.owner%type;
 my_tab_ref all_cons_columns.table_name%type;
 my_pk_ref  all_cons_columns.constraint_name%type;
 my_col     all_cons_columns.column_name%type;

 cursor c1 is
   select B.owner,B.table_name,B.constraint_name,
          A.owner,A.table_name,A.constraint_name
   from all_constraints A, all_constraints B, tabelas@&dblink C
   where C.aplicacao='&dono' and
         B.owner = C.owner and B.table_name = C.tabela and B.constraint_type='R' and
       A.owner=B.r_owner and A.constraint_name=B.r_constraint_name
   order by B.constraint_name;
 cursor c2 is
          select column_name 
          from all_cons_columns
          where owner=my_ow and constraint_name=my_fk
          order by position;
 cursor c3 is
          select column_name 
          from all_cons_columns
          where owner=my_ow_ref and constraint_name=my_pk_ref
          order by position;

BEGIN 
 OPEN C1;
 LOOP
    FETCH C1 inTO my_ow, my_tab, my_fk, 
                  my_ow_ref, my_tab_ref, my_pk_ref;
       EXIT WHEN C1%NOTFOUND;
        dbms_output.put ('ALTER TABLE XXXXX.');
        dbms_output.put_line (my_tab);
        dbms_output.put_line ('add constraint '||my_fk||' foreign key');
        dbms_output.put ('(');
        begin
          open c2;
          virg := ' '; 
          loop
             fetch c2 into my_col;
             exit when c2%notfound;
             dbms_output.put (virg); 
             dbms_output.put (my_col);
             virg := ','; 
          end loop;
          close c2;
        end;
        dbms_output.put_line (')');
        dbms_output.put ('references '||my_ow_ref||'.');
        dbms_output.put_line (my_tab_ref);
        dbms_output.put ('(');
        begin
          open c3;
          virg := ' '; 
          loop
             fetch c3 into my_col;
             exit when c3%notfound;
             dbms_output.put (virg); 
             dbms_output.put (my_col);
             virg := ','; 
          end loop;
          close c3;
        end;
        dbms_output.put_line (');');
 END LOOP;
 CLOSE C1;
 END;
/
 spool off

 spool c:\ronei\scripts\cria_uk_&dono..sql
-- gera comando para criação das constraints unique
 select ' ' from dual;
 select '--### gera comando para criação das constraints unique' from dual;
DECLARE
 virg       varchar2(1);
 my_ow      all_cons_columns.owner%type;
 my_tab     all_cons_columns.table_name%type;
 my_uk      all_cons_columns.constraint_name%type;
 my_col     all_cons_columns.column_name%type;

 cursor c1 is
   select B.owner,B.table_name,B.constraint_name
   from all_constraints B, tabelas@&dblink A
   where A.aplicacao='&dono' and
         B.owner = A.owner and B.table_name = A.tabela and B.constraint_type='U';
 cursor c2 is
          select column_name 
          from all_cons_columns
          where owner=my_ow and constraint_name=my_uk
          order by position;
BEGIN 
 OPEN C1;
 LOOP
    FETCH C1 inTO my_ow, my_tab, my_uk ;
       EXIT WHEN C1%NOTFOUND;
        dbms_output.put ('ALTER TABLE XXXXX.');
        dbms_output.put_line (my_tab);
        dbms_output.put_line ('add constraint '||my_uk||' unique ');
        dbms_output.put ('(');
        begin
          open c2;
          virg := ' '; 
          loop
             fetch c2 into my_col;
             exit when c2%notfound;
             dbms_output.put (virg); 
             dbms_output.put (my_col);
             virg := ','; 
          end loop;
          close c2;
        end;
        dbms_output.put_line (');');
 END LOOP;
 CLOSE C1;
 END;
/
 spool off

 spool c:\ronei\scripts\cria_ck_&dono..sql
-- gera comando para criação das constraints check
 select ' ' from dual;
 select '--### gera comando para criação das constraints check' from dual;
 select 'ALTER TABLE XXXXX.'||B.table_name,
 'add constraint '||B.constraint_name,
 'check (',
 B.search_condition,');'
 from all_constraints B, tabelas@&dblink A
 where A.aplicacao='&dono' and
       B.owner = A.owner and B.table_name = A.tabela and B.constraint_type='C'
 order by B.constraint_name;
 spool off

 spool c:\ronei\scripts\cria_role_&dono..sql
-- gera comando para criação das roles
 select ' ' from dual;
 select '--### gera comando para criação das roles' from dual;
 select DISTINCT 'create role '||B.grantee||' not identified;'
 from dba_tab_privs B, tabelas@&dblink A
 where A.aplicacao='&dono' and 
       B.owner <> A.owner and B.table_name = A.tabela
 GROUP by B.grantee;
 spool off

 spool c:\ronei\scripts\cria_priv_&dono..sql
-- gera comando para atribuição dos privilegios de acesso
 select ' ' from dual;
 select '--### gera comando para atribuição dos privilegios de acesso' from dual;
 select 'GRANT '||B.privilege||' on XXXXX.'||B.table_name,
 ' to '||B.grantee||';'
 from dba_tab_privs B, tabelas@&dblink A
 where A.aplicacao='&dono' and 
       B.owner = A.owner and B.table_name = A.tabela
 order by B.table_name,B.grantee,B.privilege;
 spool off

 spool c:\ronei\scripts\alter_ind_&dono..sql
-- gera comando para realocação dos indices
 select ' ' from dual;
 select '--### gera comando para realocação dos indices' from dual;
 select 'ALTER INDEX '||B.index_name||' REBUILD tablespace &tsind;'
 from all_indexes B, tabelas@&dblink A
 where A.aplicacao='&dono' and 
       B.owner = A.owner and B.table_name = A.tabela
 order by B.table_name;
 spool off

 spool c:\ronei\scripts\cria_ind_&dono..sql
-- gera comando para criação dos indices
 select ' ' from dual;
 select '--### gera comando para criação dos indices' from dual;
DECLARE
 virg       varchar2(1);
 my_ow      all_indexes.table_owner%type;
 my_tab     all_indexes.table_name%type;
 my_tbsp    all_indexes.tablespace_name%type;
 my_ind     all_indexes.index_name%type;
 my_uniq    all_indexes.uniqueness%type;
 my_col     all_ind_columns.column_name%type;

 cursor c1 is
   select A.owner,A.table_name,A.tablespace_name,A.index_name,A.uniqueness
   from all_indexes A, tabelas@&dblink B
   where B.aplicacao='&dono' and
         A.table_owner = B.owner and A.table_name = B.tabela;
 cursor c2 is
          select column_name 
          from all_ind_columns
          where table_owner=my_ow and table_name=my_tab and index_name=my_ind
          order by column_position;

BEGIN 
 OPEN C1;
 LOOP
    FETCH C1 inTO my_ow, my_tab, my_tbsp, my_ind, my_uniq; 
       EXIT WHEN C1%NOTFOUND;
        dbms_output.put ('CREATE '||my_uniq);
        dbms_output.put_line (' INDEX '||my_ind);
        dbms_output.put_line ('ON XXXXX.'||my_tab);
        dbms_output.put ('(');
        begin
          open c2;
          virg := ' '; 
          loop
             fetch c2 into my_col;
             exit when c2%notfound;
             dbms_output.put (virg); 
             dbms_output.put (my_col);
             virg := ','; 
          end loop;
          close c2;
        end;
        dbms_output.put_line (')');
        dbms_output.put_line ('TABLESPACE &tsind;');
 END LOOP;
 CLOSE C1;
 END;
/
 spool off

 spool c:\ronei\scripts\cria_syn_&dono..sql
-- gera comando para criação do sinonimo
 select ' ' from dual;
 select '--### gera comando para criação do sinonimo' from dual;
 select 'CREATE '||A.owner||' synonym '||A.synonym_name,
 ' for XXXXX.'||A.table_name||';'
 from all_synonyms A, tabelas@&dblink B
 where B.aplicacao='&dono' and
      A.table_owner = B.owner and A.table_name = B.tabela;
 spool off