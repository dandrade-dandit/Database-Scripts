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
   from all_indexes A
   where A.table_owner = '&dono' 
   order by A.table_name;

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
        dbms_output.put_line ('TABLESPACE yyyyy;');
        dbms_output.put_line (' ');
 END LOOP;
 CLOSE C1;
 END;
/
 spool off



