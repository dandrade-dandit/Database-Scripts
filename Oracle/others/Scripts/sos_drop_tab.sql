 rem |   Gera relatório (sos_drop_&tabe.sql) com as informações de uma
 rem |       tabela/owner informado
 rem |
 rem | parametros: nome da tabela e nome do owner
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
 ACCEPT tabe PROMPT 'DIGITE O NOME DA TABELA: '
 ACCEPT dono PROMPT 'DIGITE O NOME DO OWNER: '
 
 spool C:\Sistemas\Sql\Infraero\Oracle\sos_drop_&tabe..sql
 SET SERVEROUTPUT ON SIZE 100000

 select '*** SEQUENCIA DE COMANDOS A SEREM OBSERVADOS/EXECUTADOS',
        '*** QUANDO DO DROP DE UMA TABELA.',
        '***',
        '*** ==> alguns comandos precisam ser completados (senhas)',
        '***'
 from dual;
-- gera comando para o export
 select ' ' from dual;
 select '--### gera comando para o export' from dual;
 select 'HOST exp73 userid=&dono/xxxxx tables=&tabe file=q:\scripts\&dono._&tabe..dmp log=q:\scripts\exp_&tabe..log'
 from dual;
-- gera comando para o import 
 select ' ' from dual;
 select '--### gera comando para o import' from dual;
 select 'HOST imp73 userid=&dono/xxxxx ignore=y commit=y file=q:\scripts\&dono._&tabe..dmp log=q:\scripts\imp_&tabe..log'
 from dual;
-- gera comando para criação e inserção dos dados em uma tabela auxiliar 
 select ' ' from dual;
 select '--### gera comando para criação e inserção dos dados em uma tabela auxiliar' from dual;
 select 'create table &dono..AUX_&tabe as select * from &dono..&tabe;'
 from dual;
-- gera comando de carga, a partir da tabela auxiliar (coluna x coluna)
 select ' ' from dual;
 select '--### gera comando de carga, a partir da tabela auxiliar (coluna x coluna)' from dual;
DECLARE
 virg       varchar2(1);
 my_col     all_tab_columns.column_name%type;
 my_ow      all_tab_columns.owner%type;
 my_tab     all_tab_columns.table_name%type;

 cursor c1 is
   select owner,table_name,column_name
   from all_tab_columns
   where owner = '&dono' and table_name = '&tabe'
   order by column_id;

BEGIN 
 OPEN C1;
 FETCH C1 inTO my_ow,my_tab,my_col;
 dbms_output.put ('INSERT INTO '||my_ow);
 dbms_output.put_line ('.'||my_tab);
 dbms_output.put ('(');
 CLOSE C1;
 OPEN C1;
 virg := ' '; 
 LOOP
    FETCH C1 inTO my_ow,my_tab,my_col;
       EXIT WHEN C1%NOTFOUND;
             dbms_output.put (virg); 
             dbms_output.put_line (my_col);
             virg := ','; 
 END LOOP;
 dbms_output.put_line (')');
 dbms_output.put_line ('select ');
 CLOSE C1;
 OPEN C1;
 virg := ' '; 
 LOOP
    FETCH C1 inTO my_ow,my_tab,my_col;
       EXIT WHEN C1%NOTFOUND;
             dbms_output.put (virg); 
             dbms_output.put_line (my_col);
             virg := ','; 
 END LOOP;
 dbms_output.put (' from '||my_ow||'.');
 dbms_output.put_line ('AUX_'||my_tab||';');
 CLOSE C1;
 END;
/
-- gera comando para deleção das constraints que se referenciam
 select ' ' from dual;
 select '--### gera comando para deleção das constraints que se referenciam' from dual;
 select 'ALTER TABLE '||A.owner||'.'||A.table_name,
 'drop constraint '||A.constraint_name||';'
 from all_cons_columns C, all_cons_columns D, all_constraints A, all_constraints B 
 where B.owner = '&dono' and B.table_name = '&tabe' and B.constraint_type='P' and
       D.owner = B.owner and D.constraint_name=B.constraint_name and
       A.r_owner=B.owner and A.r_constraint_name=B.constraint_name and
       C.owner=A.owner and C.constraint_name=A.constraint_name
 order by A.table_name;
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
   from all_constraints B 
   where B.owner = '&dono' and B.table_name = '&tabe' and B.constraint_type='P';
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
        dbms_output.put ('ALTER TABLE '||my_ow||'.');
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
   from all_constraints A, all_constraints B 
   where B.owner = '&dono' and B.table_name = '&tabe' and B.constraint_type='R' and
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
        dbms_output.put ('ALTER TABLE '||my_ow||'.');
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
-- gera comando para criação das constraints DEFAULT
 select ' ' from dual;
 select '--### gera comando para criação das constraints DEFAULT' from dual;
DECLARE
 virg       varchar2(1);
 my_ow      all_tab_columns.owner%type;
 my_tab     all_tab_columns.table_name%type;
 my_def      all_tab_columns.data_default%type;
 my_col     all_tab_columns.column_name%type;
 cursor c81 is
    select B.table_name,B.column_name,B.data_default
    from all_tab_columns B
    where B.owner = '&dono' and B.table_name = '&tabe' and 
          B.data_default is not null;
BEGIN 
 OPEN C81;
 LOOP
    FETCH C81 inTO my_tab, my_col, my_def ;
       EXIT WHEN C81%NOTFOUND;
        dbms_output.put ('ALTER TABLE XXXXX.');
        dbms_output.put_line (my_tab);
        dbms_output.put_line ('modify '||my_col||' default '||my_def||';');
 END LOOP;
 CLOSE C81;
 END;
/
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
   from all_constraints B
   where B.owner = '&dono' and B.table_name = '&tabe' and B.constraint_type='U';
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
-- gera comando para criação das constraints check
 select ' ' from dual;
 select '--### gera comando para criação das constraints check' from dual;
 select 'ALTER TABLE '||B.owner||'.'||B.table_name,
 'add constraint '||B.constraint_name,
 'check (',
 B.search_condition,');'
 from all_constraints B
 where B.owner = '&dono' and B.table_name = '&tabe' and B.constraint_type='C'
 order by B.constraint_name;
-- gera comando para atribuição dos privilegios de acesso
 select ' ' from dual;
 select '--### gera comando para atribuição dos privilegios de acesso' from dual;
 select 'GRANT '||privilege||' on '||owner||'.'||table_name,
 ' to '||grantee||';'
 from dba_tab_privs
 where owner = '&dono' and table_name = '&tabe'
 order by grantor,grantee,privilege;
--
 select 'GRANT '||B.privilege||' ('||B.column_name||') on '||B.owner||'.'||B.table_name,
 ' to '||B.grantee||';'
 from dba_col_privs B
 where B.owner = '&dono' and B.table_name = '&tabe'
 order by B.table_name,B.grantee,B.privilege;
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
   from all_indexes A
   where A.table_owner = '&dono' and A.table_name = '&tabe';
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
        dbms_output.put_line ('ON '||my_ow||'.'||my_tab);
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
        dbms_output.put_line ('TABLESPACE '||my_tbsp||';');
 END LOOP;
 CLOSE C1;
 END;
/
-- gera comando para criação das constraints que se referenciam
 select ' ' from dual;
 select '--### gera comando para criação das constraints que se referenciam' from dual;
DECLARE
 virg       varchar2(1);
 my_ow_ref  all_cons_columns.owner%type;
 my_tab_ref all_cons_columns.table_name%type;
 my_fk_ref  all_cons_columns.constraint_name%type;
 my_ow      all_cons_columns.owner%type;
 my_tab     all_cons_columns.table_name%type;
 my_pk      all_cons_columns.constraint_name%type;
 my_col     all_cons_columns.column_name%type;

 cursor c1 is
   select B.owner,B.table_name,B.constraint_name,
          A.owner,A.table_name,A.constraint_name
   from all_constraints A, all_constraints B 
   where B.owner = '&dono' and B.table_name = '&tabe' and B.constraint_type='P' and
       A.r_owner=B.owner and A.r_constraint_name=B.constraint_name
   order by A.constraint_name;

 cursor c2 is
          select column_name 
          from all_cons_columns
          where owner=my_ow_ref and constraint_name=my_fk_ref
          order by position;
 cursor c3 is
          select column_name 
          from all_cons_columns
          where owner=my_ow and constraint_name=my_pk
          order by position;

BEGIN 
 OPEN C1;
 LOOP
    FETCH C1 inTO my_ow, my_tab, my_pk, 
                  my_ow_ref, my_tab_ref, my_fk_ref;
       EXIT WHEN C1%NOTFOUND;
        dbms_output.put ('ALTER TABLE '||my_ow_ref||'.');
        dbms_output.put_line (my_tab_ref);
        dbms_output.put_line ('add constraint '||my_fk_ref||' foreign key');
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
        dbms_output.put ('references '||my_ow||'.');
        dbms_output.put_line (my_tab);
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
-- gera comando para criação do sinonimo
 select ' ' from dual;
 select '--### gera comando para criação do sinonimo' from dual;
 select 'CREATE '||owner||' synonym '||synonym_name,
 ' for '||table_owner||'.'||table_name||';'
 from all_synonyms
 where table_owner = '&dono' and table_name = '&tabe';
-- gera comando para criação das triggers
set arraysize 1;
set maxdata 60000;
set long 32767;

 select ' ' from dual;
 select '--### gera comando para criação das triggers' from dual;
 select 'CREATE OR REPLACE TRIGGER ',trigger_name,
  trigger_body
  from all_triggers
 where table_owner = '&dono' and table_name = '&tabe';
-- restaura parametrização
 spool off
 set feedback on
 set heading on


