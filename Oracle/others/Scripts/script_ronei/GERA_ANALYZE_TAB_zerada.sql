-- parametrização necessaria
 set line 132
 set pause "click <enter>....."
 set pause off
 set heading on
 set echo off
 set verify off
 SET FEEDBACK Off
 SET PAGESIZE 1000
 set serveroutput on size 100000
 spool C:\Sistemas\Sql\Infraero\Oracle\Scripts\script_ronei\analyz_tabs_zeradas.sql
DECLARE
 my_ow       	all_tables.owner%type;
 my_tab      	all_tables.table_name%type;
 cursor_name 	INTEGER;
 ret 		INTEGER;
 script		varchar2(100);
 cursor c1 is
   select a.owner,a.table_name
   from   sys.dba_tables A
   where A.owner not in ('SYS','SYSMAN','SYSTEM','DONOREP','DISCOVERER','WEBSYS',
         'OUTLN','PERFSTAT','OSE$HTTP$ADMIN','AURORA$JIS$UTILITY$') and
         'LOG_' <> substr(A.table_name,1,4) and
         'TMP_' <> substr(A.table_name,1,4) and
         'EMP_' <> substr(A.table_name,1,4) and
         'TEMP_' <> substr(A.table_name,1,5) and
         'PLAN_' <> substr(A.table_name,1,5) and
	   a.num_rows is null
   order by A.owner,A.table_name;
 CURSOR C2 IS
      SELECT owner,table_name,num_rows,avg_row_len
      FROM sys.dba_tables 
      WHERE (num_rows > 0 and num_rows is not null)
      ORDER BY 1,2;
BEGIN
  dbms_output.put_line ('ALTER USER SYS TEMPORARY TABLESPACE TEMP;');
  OPEN C1;
  LOOP
    FETCH C1 inTO my_ow, my_tab;
      EXIT WHEN C1%NOTFOUND;
      dbms_output.put_line ('exec dbms_stats.gather_table_stats (ownname=>'''||my_ow||''',tabname=>'''||my_tab||''',estimate_percent=>25,cascade=>true);');
  end loop;
  dbms_output.put_line ('ALTER USER SYS TEMPORARY TABLESPACE SYSTEM;');
  close c1;
--  FOR C3 IN C2 LOOP
--         BEGIN
--            insert into ifrbanco.analyz_tabelas
--	    values
--	    (C3.owner,C3.table_name,SYSDATE,C3.num_rows,C3.avg_row_len);
--         END;
--  END LOOP;
--  COMMIT;
END;
/
spool off
