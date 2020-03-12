SQL> DECLARE
  2   my_ow        all_tables.owner%type;
  3   my_tab       all_tables.table_name%type;
  4   cursor_name  INTEGER;
  5   ret   INTEGER;
  6   script  varchar2(100);
  7   cursor c1 is
  8     select a.owner,a.table_name
  9     from   sys.dba_tables A
 10     where A.owner not in ('SYS','SYSMAN','SYSTEM','DONOREP','DISCOVERER','WEBSYS',
 11           'OUTLN','PERFSTAT','OSE$HTTP$ADMIN','AURORA$JIS$UTILITY$') and
 12           'LOG_' <> substr(A.table_name,1,4) and
 13           'TMP_' <> substr(A.table_name,1,4) and
 14           'EMP_' <> substr(A.table_name,1,4) and
 15           'TEMP_' <> substr(A.table_name,1,5) and
 16           'PLAN_' <> substr(A.table_name,1,5) and
 17      a.num_rows is null
 18     order by A.owner,A.table_name;
 19   CURSOR C2 IS
 20        SELECT owner,table_name,num_rows,avg_row_len
 21        FROM sys.dba_tables
 22        WHERE (num_rows > 0 and num_rows is not null)
 23        ORDER BY 1,2;
 24  BEGIN
 25    dbms_output.put_line ('ALTER USER SYS TEMPORARY TABLESPACE TEMP;');
 26    OPEN C1;
 27    LOOP
 28      FETCH C1 inTO my_ow, my_tab;
 29        EXIT WHEN C1%NOTFOUND;
 30        dbms_output.put_line ('exec dbms_stats.gather_table_stats (ownname=>'''||my_ow||''',tabname=>'''||my_tab||''',estimate_percent=>25,cascade=>true);');
 31    end loop;
 32    dbms_output.put_line ('ALTER USER SYS TEMPORARY TABLESPACE SYSTEM;');
 33    close c1;
 34  --  FOR C3 IN C2 LOOP
 35  --         BEGIN
 36  --            insert into ifrbanco.analyz_tabelas
 37  --     values
 38  --     (C3.owner,C3.table_name,SYSDATE,C3.num_rows,C3.avg_row_len);
 39  --         END;
 40  --  END LOOP;
 41  --  COMMIT;
 42  END;
 43  /
ALTER USER SYS TEMPORARY TABLESPACE TEMP;                                                                                           
ALTER USER SYS TEMPORARY TABLESPACE SYSTEM;                                                                                         
SQL> spool off
