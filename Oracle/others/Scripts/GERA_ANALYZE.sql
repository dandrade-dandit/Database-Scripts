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

 SET SERVEROUTPUT ON SIZE 1000000

 spool c:\ronei\scripts\Analyze.tmp

DECLARE
 my_ow       all_tables.owner%type;
 my_tab      all_tables.table_name%type;

 cursor c1 is
   select owner,table_name
   from  dba_tables A
   where A.owner not in ('SYS','SYSMAN','SYSTEM','DONOREP','DISCOVERER')
   order by A.owner,A.table_name;

BEGIN 
  OPEN C1;
  dbms_output.put_line ('set echo on;');
  LOOP
    FETCH C1 inTO my_ow, my_tab;
       EXIT WHEN C1%NOTFOUND;
        dbms_output.put_line ('--');
        dbms_output.put_line ('Analyze table '||my_ow||'.'||my_tab||' compute statistics;');
  end loop;
  close c1;
end;
/
spool off;

@c:\ronei\scripts\Analyze.tmp
host delete c:\ronei\scripts\Analyze.tmp

DECLARE

 CURSOR C2 IS
      SELECT owner,table_name,num_rows,avg_row_len
      FROM dba_tables 
      WHERE (num_rows > 0 and num_rows is not null)
      ORDER BY 1,2;

BEGIN
   FOR C3 IN C2 LOOP
         BEGIN
            insert into sysman.analyz_tabelas
	    values
	    (C3.owner,C3.table_name,SYSDATE,C3.num_rows,C3.avg_row_len);
         END;
   END LOOP;
   COMMIT;
END;
/
EXIT;
