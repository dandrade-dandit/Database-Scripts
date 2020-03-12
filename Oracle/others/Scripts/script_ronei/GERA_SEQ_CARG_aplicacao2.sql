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

drop table tab_constraint;
commit;

create table tab_constraint
(owner varchar2(30),
constraint_name varchar2(30),
constraint_type varchar2(1),
table_name varchar2(30),
r_owner varchar2(30),
r_constraint_name varchar2(30)) tablespace system;

insert into tab_constraint
(owner,constraint_name,constraint_type,table_name,r_owner,r_constraint_name)
select owner,constraint_name,constraint_type,table_name,r_owner,r_constraint_name
from all_constraints where constraint_type in ('P','R');
commit;

create index ind_tab_constraint on tab_constraint
(owner,table_name,constraint_type,r_owner,r_constraint_name) tablespace system;


 ACCEPT dono PROMPT 'DIGITE O NOME DA APLICAÇÃO: '
 set echo on
 ACCEPT OK
 set echo off
 ACCEPT dblink PROMPT 'DIGITE O NOME DO DB-LINK (C/ @): '
 set echo on
 ACCEPT OK
 set echo off
 
 SET SERVEROUTPUT ON SIZE 100000


 spool d:\script\&dono._seq_carg.sql
-- gera comando para criação das constraints foreign key

DECLARE
 virg       varchar2(1);
 my_ow      all_cons_columns.owner%type;
 my_tab     all_cons_columns.table_name%type;
 my_fk      all_cons_columns.constraint_name%type;
 my_ow_ref1  all_cons_columns.owner%type;
 my_tab_ref1 all_cons_columns.table_name%type;
 my_pk_ref1  all_cons_columns.constraint_name%type;
 my_ow_ref2  all_cons_columns.owner%type;
 my_tab_ref2 all_cons_columns.table_name%type;
 my_pk_ref2  all_cons_columns.constraint_name%type;
 my_ow_ref3  all_cons_columns.owner%type;
 my_tab_ref3 all_cons_columns.table_name%type;
 my_pk_ref3  all_cons_columns.constraint_name%type;
 my_ow_ref4  all_cons_columns.owner%type;
 my_tab_ref4 all_cons_columns.table_name%type;
 my_pk_ref4  all_cons_columns.constraint_name%type;
 my_ow_ref5  all_cons_columns.owner%type;
 my_tab_ref5 all_cons_columns.table_name%type;
 my_pk_ref5  all_cons_columns.constraint_name%type;
 my_ow_ref6  all_cons_columns.owner%type;
 my_tab_ref6 all_cons_columns.table_name%type;
 my_pk_ref6  all_cons_columns.constraint_name%type;
 my_ow_ref7  all_cons_columns.owner%type;
 my_tab_ref7 all_cons_columns.table_name%type;
 my_pk_ref7  all_cons_columns.constraint_name%type;
 my_ow_ref8  all_cons_columns.owner%type;
 my_tab_ref8 all_cons_columns.table_name%type;
 my_pk_ref8  all_cons_columns.constraint_name%type;
 my_ow_ref9  all_cons_columns.owner%type;
 my_tab_ref9 all_cons_columns.table_name%type;
 my_pk_ref9  all_cons_columns.constraint_name%type;
 my_ow_ref10  all_cons_columns.owner%type;
 my_tab_ref10 all_cons_columns.table_name%type;
 my_pk_ref10  all_cons_columns.constraint_name%type;
 my_col     all_cons_columns.column_name%type;

 cursor c1 is
   select B.owner,B.table_name,B.constraint_name
   from tabelas&dblink C, tab_constraint B
   where C.aplicacao='&dono' and C.tipo='TABELA' and
         B.owner = C.owner and B.table_name = C.tabela and B.constraint_type='P' and
         C.tabela not in (select a.table_name 
                 from tab_constraint a
                 where a.table_name=C.tabela and a.constraint_type='R')
   order by B.table_name;

 cursor c2 is
   select B.owner,B.table_name,C.constraint_name
   from tab_constraint B, tab_constraint C, tabelas&dblink A
   where C.owner=B.owner and C.table_name=B.table_name and C.constraint_type='P' and
         B.r_owner = my_ow_ref1 and B.r_constraint_name = my_pk_ref1 and
         A.aplicacao='&dono' and A.tabela=B.table_name;
--   order by B.table_name;

 cursor c3 is
   select B.owner,B.table_name,C.constraint_name
   from tab_constraint B, tab_constraint C, tabelas&dblink A
   where C.owner=B.owner and C.table_name=B.table_name and C.constraint_type='P' and
         B.r_owner = my_ow_ref2 and B.r_constraint_name = my_pk_ref2 and
         B.table_name<>my_tab_ref1 and
         A.aplicacao='&dono' and A.tabela=B.table_name;
--   order by B.table_name;

 cursor c4 is
   select B.owner,B.table_name,C.constraint_name
   from tab_constraint B, tab_constraint C, tabelas&dblink A
   where C.owner=B.owner and C.table_name=B.table_name and C.constraint_type='P' and
         B.r_owner = my_ow_ref3 and B.r_constraint_name = my_pk_ref3 and
         B.table_name<>my_tab_ref2 and
         A.aplicacao='&dono' and A.tabela=B.table_name;
--   order by B.table_name;

 cursor c5 is
   select B.owner,B.table_name,C.constraint_name
   from tab_constraint B, tab_constraint C, tabelas&dblink A
   where C.owner=B.owner and C.table_name=B.table_name and C.constraint_type='P' and
         B.r_owner = my_ow_ref4 and B.r_constraint_name = my_pk_ref4 and
         B.table_name<>my_tab_ref3 and
         A.aplicacao='&dono' and A.tabela=B.table_name;
--   order by B.table_name;

 cursor c6 is
   select B.owner,B.table_name,C.constraint_name
   from tab_constraint B, tab_constraint C, tabelas&dblink A
   where C.owner=B.owner and C.table_name=B.table_name and C.constraint_type='P' and
         B.r_owner = my_ow_ref5 and B.r_constraint_name = my_pk_ref5 and
         B.table_name<>my_tab_ref4 and
         A.aplicacao='&dono' and A.tabela=B.table_name;
--   order by B.table_name;

 cursor c7 is
   select B.owner,B.table_name,C.constraint_name
   from tab_constraint B, tab_constraint C, tabelas&dblink A
   where C.owner=B.owner and C.table_name=B.table_name and C.constraint_type='P' and
         B.r_owner = my_ow_ref6 and B.r_constraint_name = my_pk_ref6 and
         B.table_name<>my_tab_ref5 and
         A.aplicacao='&dono' and A.tabela=B.table_name;
--   order by B.table_name;

 cursor c8 is
   select B.owner,B.table_name,C.constraint_name
   from tab_constraint B, tab_constraint C, tabelas&dblink A
   where C.owner=B.owner and C.table_name=B.table_name and C.constraint_type='P' and
         B.r_owner = my_ow_ref7 and B.r_constraint_name = my_pk_ref7 and
         B.table_name<>my_tab_ref6 and
         A.aplicacao='&dono' and A.tabela=B.table_name;
--   order by B.table_name;

 cursor c9 is
   select B.owner,B.table_name,C.constraint_name
   from tab_constraint B, tab_constraint C, tabelas&dblink A
   where C.owner=B.owner and C.table_name=B.table_name and C.constraint_type='P' and
         B.r_owner = my_ow_ref8 and B.r_constraint_name = my_pk_ref8 and
         B.table_name<>my_tab_ref7 and
         A.aplicacao='&dono' and A.tabela=B.table_name;
--   order by B.table_name;

 cursor c10 is
   select B.owner,B.table_name,C.constraint_name
   from tab_constraint B, tab_constraint C, tabelas&dblink A
   where C.owner=B.owner and C.table_name=B.table_name and C.constraint_type='P' and
         B.r_owner = my_ow_ref9 and B.r_constraint_name = my_pk_ref9 and
         B.table_name<>my_tab_ref8 and
         A.aplicacao='&dono' and A.tabela=B.table_name;
--   order by B.table_name;

BEGIN 
 OPEN C1;
 LOOP
    FETCH C1 inTO my_ow_ref1, my_tab_ref1, my_pk_ref1;
       EXIT WHEN C1%NOTFOUND;
        dbms_output.put ('.01 ');
        dbms_output.put_line (my_tab_ref1);
        begin
          open c2;
          loop
             fetch c2 into my_ow_ref2, my_tab_ref2, my_pk_ref2;
             exit when c2%notfound;
             dbms_output.put ('.02 '); 
             dbms_output.put_line (my_tab_ref2);
             begin
               open c3;
               loop
                 fetch c3 into my_ow_ref3, my_tab_ref3, my_pk_ref3;
                 exit when c3%notfound;
                 dbms_output.put ('.03 '); 
                 dbms_output.put_line (my_tab_ref3);
                 begin
                   open c4;
                   loop
                     fetch c4 into my_ow_ref4, my_tab_ref4, my_pk_ref4;
                     exit when c4%notfound;
                     dbms_output.put ('.04 '); 
                     dbms_output.put_line (my_tab_ref4);
                     begin
                       open c5;
                       loop
                         fetch c5 into my_ow_ref5, my_tab_ref5, my_pk_ref5;
                         exit when c5%notfound;
                         dbms_output.put ('.05 '); 
                         dbms_output.put_line (my_tab_ref5);
                         begin
                           open c6;
                           loop
                             fetch c6 into my_ow_ref6, my_tab_ref6, my_pk_ref6;
                             exit when c6%notfound;
                             dbms_output.put ('.06 '); 
                             dbms_output.put_line (my_tab_ref6);
                             begin
                               open c7;
                               loop
                                 fetch c7 into my_ow_ref7, my_tab_ref7, my_pk_ref7;
                                 exit when c7%notfound;
                                 dbms_output.put ('.07 '); 
                                 dbms_output.put_line (my_tab_ref7);
                                 begin
                                   open c8;
                                   loop
                                     fetch c8 into my_ow_ref8, my_tab_ref8, my_pk_ref8;
                                     exit when c8%notfound;
                                     dbms_output.put ('.08 '); 
                                     dbms_output.put_line (my_tab_ref8);
                                     begin
                                       open c9;
                                       loop
                                         fetch c9 into my_ow_ref9, my_tab_ref9, my_pk_ref9;
                                         exit when c9%notfound;
                                         dbms_output.put ('.09 '); 
                                         dbms_output.put_line (my_tab_ref9);
                                         begin
                                           open c10;
                                           loop
                                             fetch c10 into my_ow_ref10, my_tab_ref10, my_pk_ref10;
                                             exit when c10%notfound;
                                             dbms_output.put ('.10 '); 
                                             dbms_output.put_line (my_tab_ref10);
                                           end loop;
                                           close c10;
                                         end;
                                       end loop;
                                       close c9;
                                     end; 
                                   end loop;
                                   close c8;
                                 end; 
                               end loop;
                               close c7;
                             end;
                           end loop;
                           close c6;
                         end;
                       end loop;
                       close c5;
                     end;
                   end loop;
                   close c4;
                 end;
               end loop;
               close c3;
             end;
          end loop;
          close c2;
        end;
 END LOOP;
 CLOSE C1;
 END;
/
 spool off

