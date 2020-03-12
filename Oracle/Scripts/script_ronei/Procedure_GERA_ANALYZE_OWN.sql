--   to_date('2002/03/24-00:01', 'YYYY/MM/DD-HH24:MI')
--   /*7:Days*/ sysdate + 7
create or replace procedure SYS.PR_GERA_ANALYZE_OWN
IS
 my_ow       	all_tables.owner%type;
 my_tab      	all_tables.table_name%type;
 cursor_name 	INTEGER;
 ret 		INTEGER;
 script		varchar2(100);
 cursor c1 is
   select distinct(A.owner)
   from  sys.dba_tables A
   where 'IFR' = substr(A.owner,1,3) or A.owner = 'SST';
 CURSOR C2 IS
      SELECT owner,table_name,num_rows,avg_row_len
      FROM sys.dba_tables 
      WHERE (num_rows > 0 and num_rows is not null)
      ORDER BY 1,2;
BEGIN
  cursor_name := sys.DBMS_SQL.OPEN_CURSOR;
  script := 'ALTER USER SYS TEMPORARY TABLESPACE TEMP';
  sys.DBMS_SQL.PARSE(cursor_name, script, sys.DBMS_SQL.NATIVE);
  ret := sys.DBMS_SQL.EXECUTE(cursor_name);
  OPEN C1;
  LOOP
    FETCH C1 inTO my_ow;
      EXIT WHEN C1%NOTFOUND;
      dbms_stats.gather_schema_stats (ownname=>''||my_ow||'',estimate_percent=>25,cascade=>true);
  end loop;
  script := 'ALTER USER SYS TEMPORARY TABLESPACE SYSTEM';
  sys.DBMS_SQL.PARSE(cursor_name, script, sys.DBMS_SQL.NATIVE);
  ret := sys.DBMS_SQL.EXECUTE(cursor_name);
  sys.DBMS_SQL.CLOSE_CURSOR(cursor_name);
  close c1;
  FOR C3 IN C2 LOOP
         BEGIN
            insert into ifrbanco.analyz_tabelas
	    values
	    (C3.owner,C3.table_name,SYSDATE,C3.num_rows,C3.avg_row_len);
         END;
  END LOOP;
  COMMIT;
END;
/

