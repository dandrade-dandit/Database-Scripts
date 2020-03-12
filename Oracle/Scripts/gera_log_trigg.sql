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
 
 spool c:\ronei\scripts\cria_LOG_&tabe..sql
 SET SERVEROUTPUT ON SIZE 100000

 select ' set echo oN' from dual;
 select ' set HEADING ON' from dual;
 select ' set verify oN' from dual;
 select ' SET FEEDBACK ON' from dual;

 select 'CONNECT &dono@PRODSEDE;'
 from dual;
 select ' set echo oFF' from dual;
 select 'create table &dono..LOG_&tabe as select * from &dono..&tabe where rowid is null;'
 from dual;
 select 'alter table &dono..LOG_&tabe add dt_geracao date default SYSDATE;'
 from dual;
 select 'alter table &dono..LOG_&tabe add tp_geracao varchar2(1);'
 from dual;
 select 'alter table &dono..LOG_&tabe add quem_gerou varchar2(20);'
 from dual;
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
 dbms_output.put_line ('CREATE OR REPLACE TRIGGER AFT_IDU_'||my_tab);
 dbms_output.put_line ('AFTER INSERT  OR DELETE  OR UPDATE');
 dbms_output.put ('ON '||my_ow);
 dbms_output.put_line ('.'||my_tab);
 dbms_output.put_line ('REFERENCING NEW AS NEW OLD AS OLD');
 dbms_output.put_line ('FOR EACH ROW');
 dbms_output.put_line ('BEGIN');
 dbms_output.put_line ('  IF INSERTING THEN');
 dbms_output.put_line ('     INSERT INTO LOG_'||my_tab||' (');
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
 dbms_output.put_line (',tp_geracao'); 
 dbms_output.put_line (',quem_gerou'); 
 dbms_output.put_line (')');
 dbms_output.put_line ('values (');
 CLOSE C1;
 OPEN C1;
 virg := ' '; 
 LOOP
    FETCH C1 inTO my_ow,my_tab,my_col;
       EXIT WHEN C1%NOTFOUND;
             dbms_output.put (virg); 
             dbms_output.put_line (':new.'||my_col);
             virg := ','; 
 END LOOP;
 dbms_output.put_line (',''I'''); 
 dbms_output.put_line (',user'); 
 dbms_output.put_line (');');
 dbms_output.put_line ('end if;');
 CLOSE C1;
--
 dbms_output.put_line ('  IF DELETING THEN');
 dbms_output.put_line ('     INSERT INTO LOG_'||my_tab||' (');
 OPEN C1;
 virg := ' '; 
 LOOP
    FETCH C1 inTO my_ow,my_tab,my_col;
       EXIT WHEN C1%NOTFOUND;
             dbms_output.put (virg); 
             dbms_output.put_line (my_col);
             virg := ','; 
 END LOOP;
 dbms_output.put_line (',tp_geracao'); 
 dbms_output.put_line (',quem_gerou'); 
 dbms_output.put_line (')');
 dbms_output.put_line ('values (');
 CLOSE C1;
 OPEN C1;
 virg := ' '; 
 LOOP
    FETCH C1 inTO my_ow,my_tab,my_col;
       EXIT WHEN C1%NOTFOUND;
             dbms_output.put (virg); 
             dbms_output.put_line (':old.'||my_col);
             virg := ','; 
 END LOOP;
 dbms_output.put_line (',''D'''); 
 dbms_output.put_line (',user'); 
 dbms_output.put_line (');');
 dbms_output.put_line ('end if;');
 CLOSE C1;
--
 dbms_output.put_line ('  IF UPDATING THEN');
 dbms_output.put_line ('     INSERT INTO LOG_'||my_tab||' (');
 OPEN C1;
 virg := ' '; 
 LOOP
    FETCH C1 inTO my_ow,my_tab,my_col;
       EXIT WHEN C1%NOTFOUND;
             dbms_output.put (virg); 
             dbms_output.put_line (my_col);
             virg := ','; 
 END LOOP;
 dbms_output.put_line (',tp_geracao'); 
 dbms_output.put_line (',quem_gerou'); 
 dbms_output.put_line (')');
 dbms_output.put_line ('values (');
 CLOSE C1;
 OPEN C1;
 virg := ' '; 
 LOOP
    FETCH C1 inTO my_ow,my_tab,my_col;
       EXIT WHEN C1%NOTFOUND;
             dbms_output.put (virg); 
             dbms_output.put_line (':old.'||my_col);
             virg := ','; 
 END LOOP;
 dbms_output.put_line (',''U'''); 
 dbms_output.put_line (',user'); 
 dbms_output.put_line (');');
 dbms_output.put_line ('end if;');
 dbms_output.put_line ('END;');
 dbms_output.put_line ('/');
 CLOSE C1;
 END;
/
spool off

