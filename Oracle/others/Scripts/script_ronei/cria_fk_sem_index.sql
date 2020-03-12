 rem |   Gera relatório (SHOW_&aplic.sql) com as informações de uma
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
set arraysize 1;
set maxdata 60000;
set long 32767;

 ACCEPT dono PROMPT 'DIGITE O NOME DA APLICAÇÃO: '
 set echo on
 ACCEPT OK
 set echo off
 
 SET SERVEROUTPUT ON SIZE 1000000

 spool C:\Sistemas\Sql\Infraero\Oracle\Scripts\script_ronei\cria_fk_sem_index_&dono..sql

set echo off;

DECLARE
 my_ow       all_tables.owner%type;
 my_apl      varchar2(20);
 my_rows     number;
 my_tab      all_tables.table_name%type;
 my_tab_aux  all_tables.table_name%type;
 my_pk       all_cons_columns.constraint_name%type;
 my_col      all_cons_columns.column_name%type;
 my_fk       all_cons_columns.constraint_name%type;
 my_fk_ref   all_cons_columns.constraint_name%type;
 my_ow_ref   all_cons_columns.owner%type;
 my_tab_ref  all_cons_columns.table_name%type;
 my_pk_ref   all_cons_columns.constraint_name%type;
 virg        varchar2(1);

cursor c1 is
 select A.constraint_name,A.table_name,A.column_name
 from all_cons_columns A, all_constraints B
 where B.owner = '&dono' and A.owner = '&dono' and 
       B.table_name = A.table_name and 
       A.constraint_name = B.constraint_name and
       B.constraint_type = 'R' and
       not exists   (select *
            from all_ind_columns C
            where C.table_owner = A.owner and
                  C.table_name = A.table_name and
                  C.column_position = A.position and
                  C.column_name = A.column_name)
 order by A.table_name,A.constraint_name,A.position;

 cursor c2 is
          select A.column_name
          from all_cons_columns A
          where A.owner='&dono' and A.table_name=my_tab and A.constraint_name=my_fk
          order by A.position;

BEGIN 
 OPEN C1;
 LOOP
    dbms_output.put_line ('*****************************************************************************************');
    FETCH C1 inTO my_fk, my_tab, my_col ;
       EXIT WHEN C1%NOTFOUND;
       dbms_output.put_line ('create index '||my_fk||' on '||my_tab);

--      Pesquisa as colunas
        begin
          open c2;
          virg := '('; 
          loop
             fetch c2 into my_col;
             exit when c2%notfound;
             dbms_output.put (virg||my_col);
             virg := ','; 
          end loop;
          close c2;
          dbms_output.put_line (')');
          dbms_output.put_line ('Tablespace TSD_INDICE;');
        end;
 END LOOP;
 CLOSE C1;
 END;
/
spool off
