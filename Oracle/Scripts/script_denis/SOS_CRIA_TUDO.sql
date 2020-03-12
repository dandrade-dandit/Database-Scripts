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
 ACCEPT dblink PROMPT 'DIGITE O NOME DO DB-LINK (C/ @): '
 set echo on
 ACCEPT OK
 set echo off
 
 SET SERVEROUTPUT ON SIZE 100000

 spool C:\Sistemas\Sql\Infraero\Oracle\Scripts\script_denis\&dono._01not_found.sql
-- confere existência das tabelas 
 select ' ' from dual;
 select '--### confere existência dos objetos 'from dual;
 select ' TABELA NAO ENCONTRADA => '||tabela
 from ifrbanco.tabelas&dblink
 where aplicacao = '&dono' and
       tabela not in (select table_name from all_tables where table_name=tabela)
    and tipo='TABELA';
 select ' VIEW NAO ENCONTRADA => '||tabela
 from ifrbanco.tabelas&dblink
 where aplicacao = '&dono' and
       tabela not in (select view_name from all_views where view_name=tabela)
    and tipo='VIEW';
 select ' FUNCTION NAO ENCONTRADA => '||tabela
 from ifrbanco.tabelas&dblink
 where aplicacao = '&dono' and
       tabela not in (select name from all_source where name=tabela)
    and tipo='FUNCTION';
 select ' PACKAGE NAO ENCONTRADA => '||tabela
 from ifrbanco.tabelas&dblink
 where aplicacao = '&dono' and
       tabela not in (select name from all_source where name=tabela)
    and tipo='PACKAGE';
 select ' PACKAGE BODY NAO ENCONTRADA => '||tabela
 from ifrbanco.tabelas&dblink
 where aplicacao = '&dono' and
       tabela not in (select name from all_source where name=tabela)
    and tipo='PACKAGE BODY';
 select ' PROCEDURE NAO ENCONTRADA => '||tabela
 from ifrbanco.tabelas&dblink
 where aplicacao = '&dono' and
       tabela not in (select name from all_source where name=tabela)
    and tipo='PROCEDURE';
 select ' SEQUENCE NAO ENCONTRADA => '||tabela
 from ifrbanco.tabelas&dblink
 where aplicacao = '&dono' and
       tabela not in (select sequence_name from all_sequences where sequence_name=tabela)
    and tipo='SEQUENCE';
 spool off
/
 spool C:\Sistemas\Sql\Infraero\Oracle\Scripts\script_denis\&dono._02refer.sql
-- gera comando para habilitar grant references  
 select ' ' from dual;
 select '--### gera comando para habilitar grant references' from dual;
 select DISTINCT 'grant references on '||A.table_name||' to XXXXX;'
 from all_constraints A, all_constraints B, ifrbanco.tabelas&dblink C
 where C.aplicacao='&dono' and C.tipo='TABELA' and
       B.owner <> C.owner and B.table_name = C.tabela and B.constraint_type='R' and
       A.owner=B.r_owner and A.constraint_name=B.r_constraint_name
 group by A.table_name;
 spool off
/
 spool C:\Sistemas\Sql\Infraero\Oracle\Scripts\script_denis\&dono._03tab.sql
-- gera comando para criação e inserção dos dados em uma tabela auxiliar 
 select ' ' from dual;
 select '--### gera comando para criação e inserção dos dados em uma tabela auxiliar' from dual;
 select 'create table XXXXX.'||tabela||' as select * from '||owner||'.'||tabela||'@xxxx.world where rowid is null;',
        '                              '
 from ifrbanco.tabelas&dblink
 where aplicacao = '&dono' and tipo='TABELA'
 order by tabela;
 spool off
/
 spool C:\Sistemas\Sql\Infraero\Oracle\Scripts\script_denis\&dono._04pk.sql
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
   from all_constraints B, ifrbanco.tabelas&dblink A
   where A.aplicacao='&dono' and A.tipo='TABELA' and
         B.owner = A.owner and B.table_name = A.tabela and B.constraint_type='P'
   order by A.tabela;
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
/
 spool C:\Sistemas\Sql\Infraero\Oracle\Scripts\script_denis\&dono._05fk.sql
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
 my_rul     all_constraints.delete_rule%type;

 cursor c1 is
   select B.owner,B.table_name,B.constraint_name,B.delete_rule,
          A.owner,A.table_name,A.constraint_name
   from all_constraints A, all_constraints B, ifrbanco.tabelas&dblink C
   where C.aplicacao='&dono' and C.tipo='TABELA' and
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
    FETCH C1 inTO my_ow, my_tab, my_fk, my_rul,
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
        if my_rul <> 'CASCADE' then
            my_rul := ' ';
        end if;
        dbms_output.put_line (') '||my_rul||';');
 END LOOP;
 CLOSE C1;
 END;
/
 spool off
/
 spool C:\Sistemas\Sql\Infraero\Oracle\Scripts\script_denis\&dono._06uk.sql
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
   from all_constraints B, ifrbanco.tabelas&dblink A
   where A.aplicacao='&dono' and A.tipo='TABELA' and
         B.owner = A.owner and B.table_name = A.tabela and B.constraint_type='U'
   order by A.tabela;
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
/
 spool C:\Sistemas\Sql\Infraero\Oracle\Scripts\script_denis\&dono._07ck.sql
-- gera comando para criação das constraints check
 select ' ' from dual;
 select '--### gera comando para criação das constraints check' from dual;
 select 'ALTER TABLE XXXXX.'||B.table_name,
 'add constraint '||B.constraint_name,
 'check (',
 B.search_condition,');'
 from all_constraints B, ifrbanco.tabelas&dblink A
 where A.aplicacao='&dono' and A.tipo='TABELA' and
       B.owner = A.owner and B.table_name = A.tabela and B.constraint_type='C'
 order by B.constraint_name;
 spool off
/
 spool C:\Sistemas\Sql\Infraero\Oracle\Scripts\script_denis\&dono._08ind.sql
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
   from all_indexes A, ifrbanco.tabelas&dblink B
   where B.aplicacao='&dono' and B.tipo='TABELA' and
         A.table_owner = B.owner and A.table_name = B.tabela
   order by B.tabela;

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
        dbms_output.put_line ('TABLESPACE xxxxx;');
        dbms_output.put_line (' ');
 END LOOP;
 CLOSE C1;
 END;
/
 spool off
/
 spool C:\Sistemas\Sql\Infraero\Oracle\Scripts\script_denis\&dono._09rebu_ind.sql
-- gera comando para realocação dos indices
 select ' ' from dual;
 select '--### gera comando para realocação dos indices' from dual;
 select 'ALTER INDEX '||B.index_name||' REBUILD tablespace xxxxx;'
 from all_indexes B, ifrbanco.tabelas&dblink A
 where A.aplicacao='&dono' and A.tipo='TABELA' and
       B.owner = A.owner and B.table_name = A.tabela
 order by B.table_name;
 spool off
/
 set arraysize 1;
 set maxdata 60000;
 set long 32767;
spool C:\Sistemas\Sql\Infraero\Oracle\Scripts\script_denis\&dono._10viw.sql
 -- gera views
 select ' ' from dual;
 select '--### gera comando para criação das views' from dual;
 select 'CREATE OR REPLACE '||V.view_name,
  V.text
  from all_views V, ifrbanco.tabelas&dblink A
 where V.owner=A.owner and V.view_name=A.tabela and
       A.aplicacao like '&dono' and A.tipo='VIEW'
 order by V.view_name;

 spool off
/
 spool C:\Sistemas\Sql\Infraero\Oracle\Scripts\script_denis\&dono._11fun.sql
 -- gera functions
 select ' ' from dual;
 select '--### gera comando para criação das functions' from dual;
 select S.text
  from all_source S, ifrbanco.tabelas&dblink A
 where S.owner=A.owner and S.name=A.tabela and S.type = 'FUNCTION' and
       A.aplicacao like '&dono' and A.tipo='FUNCTION'
 order by S.name,S.line;
 spool off
/
 spool C:\Sistemas\Sql\Infraero\Oracle\Scripts\script_denis\&dono._12pkg.sql
 -- gera package
 select ' ' from dual;
 select '--### gera comando para criação das packages' from dual;
 select S.text
  from all_source S, ifrbanco.tabelas&dblink A
 where S.type = 'PACKAGE' and
       S.owner=A.owner and S.name=A.tabela and
       A.aplicacao like '&dono' and A.tipo='PACKAGE'
 order by S.name,S.line;
 spool off
/
 spool C:\Sistemas\Sql\Infraero\Oracle\Scripts\script_denis\&dono._13pkb.sql
 -- gera PACKAGE_BODY
 select ' ' from dual;
 select '--### gera comando para criação das packages body' from dual;
 select S.text
 from all_source S, ifrbanco.tabelas&dblink A
 where S.owner=A.owner and S.name=A.tabela and 
       A.aplicacao like '&dono' and A.tipo='PACKAGE BODY' and
       S.type = 'PACKAGE BODY' 
 order by S.name,S.line;
 spool off
/
 spool C:\Sistemas\Sql\Infraero\Oracle\Scripts\script_denis\&dono._14pro.sql
 -- gera Procedure
 select ' ' from dual;
 select '--### gera comando para criação das procedures' from dual;
 select S.text
  from all_source S, ifrbanco.tabelas&dblink A
 where  A.aplicacao like '&dono' and A.tipo='PROCEDURE' and
        S.owner=A.owner and S.name=A.tabela and
        S.type = 'PROCEDURE'
 order by S.name,S.line;
 spool off
/
 spool C:\Sistemas\Sql\Infraero\Oracle\Scripts\script_denis\&dono._15trg.sql
 -- gera triggers
 select ' ' from dual;
 select '--### gera comando para criação das triggers' from dual;
 select 'CREATE OR REPLACE TRIGGER ',
  T.description,
  T.trigger_body
  from all_triggers T, ifrbanco.tabelas&dblink A
 where A.aplicacao like '&dono' and A.tipo='TABELA' and
       T.table_owner=A.owner and T.table_name=A.tabela
 order by T.trigger_name;
 spool off
/
 spool C:\Sistemas\Sql\Infraero\Oracle\Scripts\script_denis\&dono._16seq.sql
 -- gera sequences
 select ' ' from dual;
 select '--### gera comando para criação das sequences' from dual;
 select 'CREATE SEQUENCE '||sequence_name,
  'Minvalue '||min_value,
  'Maxvalue '||max_value,
  'Increment by '||increment_by,
  'Start with '||last_number,
  ';'
  from all_sequences
 where sequence_owner||sequence_name in (select owner||tabela from ifrbanco.tabelas&dblink A
                       where A.aplicacao like '&dono' and
                             A.tipo='SEQUENCE' )
 order by sequence_name;
 spool off
/
 spool C:\Sistemas\Sql\Infraero\Oracle\Scripts\script_denis\&dono._17syn.sql
-- gera comando para criação do sinonimo
 select ' ' from dual;
 select '--### gera comando para criação dos sinonimos' from dual;
 select 'CREATE '||A.owner||' synonym '||A.synonym_name,
 ' for XXXXX.'||A.table_name||';'
 from all_synonyms A, ifrbanco.tabelas&dblink B
 where B.aplicacao='&dono' and
      A.table_owner = B.owner and A.table_name = B.tabela
 order by B.tabela;
 spool off
/
 spool C:\Sistemas\Sql\Infraero\Oracle\Scripts\script_denis\&dono._18role.sql
-- gera comando para criação das roles
 select ' ' from dual;
 select '--### gera comando para criação das roles' from dual;
 select DISTINCT 'create role '||B.grantee||' not identified;'
 from dba_tab_privs B, ifrbanco.tabelas&dblink A
 where A.aplicacao='&dono' and
       B.owner = A.owner and B.table_name = A.tabela
 GROUP by B.grantee;
 spool off
/
 spool C:\Sistemas\Sql\Infraero\Oracle\Scripts\script_denis\&dono._19priv.sql
-- gera comando para atribuição dos privilegios de acesso
 select ' ' from dual;
 select '--### gera comando para atribuição dos privilegios de acesso a tabelas' from dual;
 select 'GRANT '||B.privilege||' on XXXXX.'||B.table_name,
 ' to '||B.grantee||';'
 from dba_tab_privs B, ifrbanco.tabelas&dblink A
 where A.aplicacao='&dono' and
       B.owner = A.owner and B.table_name = A.tabela
 order by B.table_name,B.grantee,B.privilege;
--
 select ' ' from dual;
 select '--### gera comando para atribuição dos privilegios de acesso a colunas de tabelas' from dual;
 select 'GRANT '||B.privilege||' ('||B.column_name||') on XXXXX.'||B.table_name,
 ' to '||B.grantee||';'
 from dba_col_privs B, ifrbanco.tabelas&dblink A
 where A.aplicacao='&dono' and
       B.owner = A.owner and B.table_name = A.tabela
 order by B.table_name,B.grantee,B.privilege;
 spool off
/
 spool C:\Sistemas\Sql\Infraero\Oracle\Scripts\script_denis\&dono._21trunc.sql
-- gera comando para deletar os dados das tabelas 
 select ' ' from dual;
 select '--### gera comando para deletar os dados das tabelas' from dual;
 select 'truncate table XXXXX.'||tabela||';'
 from ifrbanco.tabelas&dblink
 where aplicacao = '&dono' and tipo='TABELA'
 order by tabela;
 spool off
/
 spool C:\Sistemas\Sql\Infraero\Oracle\Scripts\script_denis\&dono._22carga.sql
-- gera comando para posterior carga, apos definicao de parametros
 select ' ' from dual;
 select '--### gera comando para posterior carga, apos definicao de parametros' from dual;

DECLARE
 virg       varchar2(3);
 my_ow      all_cons_columns.owner%type;
 my_tab     all_cons_columns.table_name%type;
 my_pk      all_cons_columns.constraint_name%type;
 my_col     all_cons_columns.column_name%type;

 cursor c1 is
   select B.owner,B.table_name,B.constraint_name
   from all_constraints B, ifrbanco.tabelas&dblink A
   where A.aplicacao='&dono' and A.tipo='TABELA' and
         B.owner = A.owner and B.table_name = A.tabela and B.constraint_type='P'
   order by A.tabela;
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
        dbms_output.put ('INSERT INTO XXXXX.');
        dbms_output.put_line (my_tab);
        dbms_output.put_line ('SELECT * FROM '||my_ow||'.'||my_tab||'@IFR1.WORLD WHERE');
        begin
          open c2;
          virg := '   '; 
          loop
             fetch c2 into my_col;
             exit when c2%notfound;
             dbms_output.put (virg||' '); 
             dbms_output.put_line (my_col||' = ?????');
             virg := 'and'; 
          end loop;
          close c2;
        end;
        dbms_output.put_line (';');
 END LOOP;
 CLOSE C1;
 END;
/
 spool off

