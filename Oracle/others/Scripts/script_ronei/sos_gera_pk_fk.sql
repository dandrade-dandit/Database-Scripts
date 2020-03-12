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
 
 spool C:\Sistemas\Sql\Infraero\Oracle\Scripts\script_ronei\sos_pk_fk_&own..sql
 SET SERVEROUTPUT ON SIZE 100000

-- gera comando para deleção das constraints foreign key
 select ' ' from dual;
 select '--### gera comando para deleção das constraints foreign key' from dual;
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
   where B.owner = '&own' and B.table_name in ('&tabe') and 
       B.constraint_type='R' and
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
        dbms_output.put_line ('drop constraint '||my_fk||';');
        dbms_output.put_line ('--');
 END LOOP;
 CLOSE C1;
 END;
/
-- gera comando para deleção e criação da constraint primary key
 select ' ' from dual;
 select '--### gera comando para deleção e criação da constraint primary key' from dual;

DECLARE
 virg       varchar2(1);
 my_ow      all_cons_columns.owner%type;
 my_tab     all_cons_columns.table_name%type;
 my_pk      all_cons_columns.constraint_name%type;
 my_col     all_cons_columns.column_name%type;

 cursor c1 is
   select B.owner,B.table_name,B.constraint_name
   from all_constraints B 
   where B.owner = '&own' and B.table_name in ('&tabe') and 
         B.constraint_type='P';
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
        dbms_output.put_line ('drop constraint '||my_pk||';');
        dbms_output.put_line ('--');
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
        dbms_output.put_line ('--');
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
   where B.owner = '&own' and B.table_name in ('&tabe') and 
       B.constraint_type='R' and
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
        dbms_output.put_line ('--');
 END LOOP;
 CLOSE C1;
 END;
/
-- restaura parametrização
 spool off
 set feedback on
 set heading on


