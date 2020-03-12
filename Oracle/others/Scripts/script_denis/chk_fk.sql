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

 ACCEPT tabe PROMPT 'DIGITE O NOME DA TABELA: '
 set echo on
 ACCEPT OK
 set echo off
 ACCEPT dono PROMPT 'DIGITE O NOME DO OWNER: '
 set echo on
 ACCEPT OK
 set echo off

 SET SERVEROUTPUT ON SIZE 100000

 spool C:\Sistemas\Sql\Infraero\Oracle\Scripts\script_denis\chk_fk_&tabe..sql

 SELECT 'SET ECHO ON' FROM DUAL;
 SELECT 'SET FEEDBACK ON' FROM DUAL;
 SELECT 'SPOOL C:\Sistemas\Sql\Infraero\Oracle\Scripts\script_denis\CHK_FK_&tabe..lst' FROM DUAL;

DECLARE
 virg       varchar2(4);
 my_ow      all_cons_columns.owner%type;
 my_tab     all_cons_columns.table_name%type;
 my_fk      all_cons_columns.constraint_name%type;
 my_ow_ref  all_cons_columns.owner%type;
 my_tab_ref all_cons_columns.table_name%type;
 my_pk_ref  all_cons_columns.constraint_name%type;
 my_col     all_cons_columns.column_name%type;
 my_col_ref all_cons_columns.column_name%type;

 cursor c3 is
   select A.column_name
   from all_constraints B, all_cons_columns A
   where B.owner = my_ow and B.table_name = my_tab and B.constraint_type='P' and
         A.owner = my_ow and A.constraint_name=B.constraint_name
   order by A.position;

 cursor c1 is
   select B.owner,B.table_name,B.constraint_name,
          A.owner,A.table_name,A.constraint_name
   from all_constraints A, all_constraints B
   where B.owner = '&dono' and B.table_name = '&tabe' and B.constraint_type='R' and
       A.owner=B.r_owner and A.constraint_name=B.r_constraint_name
   order by B.constraint_name;
 cursor c2 is
          select B.column_name,A.column_name 
          from all_cons_columns A, all_cons_columns B
          where A.owner=my_ow and A.constraint_name=my_fk and
                B.owner=my_ow_ref and B.constraint_name=my_pk_ref and
                A.position=B.position
          order by A.position;
 cursor c4 is
   select A.column_name
   from all_constraints B, all_cons_columns A
   where B.owner = my_ow and B.table_name = my_tab and B.constraint_type='P' and
         A.owner = my_ow and A.constraint_name=B.constraint_name
   order by A.position;


BEGIN 
 OPEN C1;
 LOOP
    FETCH C1 inTO my_ow, my_tab, my_fk, 
                  my_ow_ref, my_tab_ref, my_pk_ref;
       EXIT WHEN C1%NOTFOUND;
        dbms_output.put ('SELECT ');
        begin
          open c3;
          virg := '    '; 
          loop
             fetch c3 into my_col;
             exit when c3%notfound;
             dbms_output.put (virg);
             dbms_output.put (' A.'||my_col); 
             virg := ',   '; 
          end loop;
          close c3;
        dbms_output.put_line (' ');
        end;
        dbms_output.put ('FROM DBA_INFRAERO.'||my_tab||'@ORACLE.WORLD A');
        dbms_output.put_line (' WHERE NOT EXISTS');
        dbms_output.put_line ('(SELECT * FROM '||my_ow_ref||'.'||my_tab_ref||' B WHERE');
        begin
          open c2;
          virg := '    '; 
          loop
             fetch c2 into my_col_ref,my_col;
             exit when c2%notfound;
             dbms_output.put (virg);
             dbms_output.put (' B.'||my_col_ref||'=A.'); 
             dbms_output.put_line (my_col);
             virg := ' and'; 
          end loop;
          close c2;
        end;
        dbms_output.put_line (')');
        dbms_output.put ('ORDER BY ');
        begin
          open c4;
          virg := '    '; 
          loop
             fetch c4 into my_col;
             exit when c4%notfound;
             dbms_output.put (virg);
             dbms_output.put (' A.'||my_col); 
             virg := ',   '; 
          end loop;
          close c4;
        dbms_output.put_line (';');
        end;

 END LOOP;
 CLOSE C1;
 END;
/
 SELECT 'SPOOL OFF' FROM DUAL;

 spool off
