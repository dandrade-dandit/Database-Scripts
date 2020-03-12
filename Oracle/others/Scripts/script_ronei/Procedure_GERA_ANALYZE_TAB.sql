
--   to_date('3002/03/28-23:00', 'YYYY/MM/DD-HH24:MI')
--   /*7:Days*/ sysdate + 7
create or replace procedure SYS.PR_GERA_ANALYZE_TAB
IS
 my_ow       	all_tables.owner%type;
 my_tab      	all_tables.table_name%type;
 cursor_name 	INTEGER;
 ret 		INTEGER;
 script		varchar2(100);
 cursor c1 is
   select a.owner,a.table_name
   from   ifrbanco.analyz_tabelas b, sys.dba_tables A
   where A.owner not in ('SYS','SYSMAN','SYSTEM','DONOREP','DISCOVERER','WEBSYS',
         'OUTLN','PERFSTAT','OSE$HTTP$ADMIN','AURORA$JIS$UTILITY$') and
         'LOG_' <> substr(A.table_name,1,4) and
         'TMP_' <> substr(A.table_name,1,4) and
         'EMP_' <> substr(A.table_name,1,4) and
         'TEMP_' <> substr(A.table_name,1,5) and
         'PLAN_' <> substr(A.table_name,1,5) and
	   A.table_name not in ('LEITURA_SELOS','HST_LEITURA_SELOS_OLD',
					'RECIBO_TARIFAS_EMBARQUE_OLD','PAGAMENTO_CALCULADO_2110',
					'PAGAMENTO_CALCULADO_FINAL','REMUNERACAO_2110',
					'REMUNERACAO_FINAL','PROJECAO_MOVIMENTO_PAGAMENTO',
					'POSICAO_MOVIMENTO_PAGAMENTO') and
	   a.num_rows * a.avg_row_len > 131000 and
	   to_char(b.data_analyz,'yyyy/mm/dd')='2002/11/28' and
         a.owner=b.owner and a.table_name=b.tabela and a.num_rows <> b.num_regs;
--   order by A.owner,A.table_name;
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
    FETCH C1 inTO my_ow, my_tab;
      EXIT WHEN C1%NOTFOUND;
      dbms_stats.gather_table_stats (ownname=>''||my_ow||'',tabname=>''||my_tab||'',estimate_percent=>25,cascade=>true);
   	sys.DBMS_SQL.PARSE(cursor_name, script, sys.DBMS_SQL.NATIVE);
   	ret := sys.DBMS_SQL.EXECUTE(cursor_name);
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

