 rem |   Mata usuario
 rem |
 rem | parametros: bd e senha
 rem |

connect sysman@&bd
DECLARE
 my_sid     v$session.sid%type;
 my_serial  v$session.serial#%type;
 my_user    v$session.username%type;
 my_osuser  v$session.osuser%type;
 my_machine v$session.machine%type;
 my_progr   v$session.program%type;
 my_date    varchar2(25);
 cursor_id  integer;
 ret_code   integer;
 mata       varchar2(200);
 
 cursor c1 is
       SELECT  SID, SERIAL#, USERNAME, OSUSER, MACHINE, PROGRAM, to_char(SYSDATE, 'YYYY-MM-DD HH24:MI:SS')
       FROM V$SESSION
       WHERE  STATUS <> 'KILLED' 
--       AND UPPER(SUBSTR(OSUSER,1,4)) = 'PRSI' 
--       AND UPPER(SUBSTR(MACHINE,1,4)) = 'PRSI' 
       AND UPPER(SUBSTR(USERNAME,1,1)) = 'I'
       AND UPPER(SUBSTR(PROGRAM,1,3)) <> 'R25'
       AND UPPER(SUBSTR(PROGRAM,1,3)) <> 'F45'
       AND UPPER(SUBSTR(PROGRAM,1,3)) <> 'ORA';
	
BEGIN 
 OPEN C1;
 loop
    FETCH C1 inTO my_sid, my_serial, my_user, my_osuser, my_machine, my_progr, my_date;
       EXIT WHEN C1%NOTFOUND;
    mata := 'INSERT INTO LOG_V$SESSION (USERNAME,OSUSER,MACHINE,PROGRAM,DATA) VALUES 
    ('||''''||my_user||''','''||my_osuser||''','''||my_machine||''','''||my_progr||''','''||my_date||''')';

    cursor_id := dbms_sql.open_cursor;
    dbms_sql.parse(cursor_id,LTRIM(RTRIM(mata)),dbms_sql.native);
    ret_code := dbms_sql.execute(cursor_id);
    dbms_sql.close_cursor(cursor_id);

    mata := 'ALTER SYSTEM KILL SESSION ' || '''' || my_sid || ', ' || my_serial || '''';
    cursor_id := dbms_sql.open_cursor;
    dbms_sql.parse(cursor_id,LTRIM(RTRIM(mata)),dbms_sql.native);
    ret_code := dbms_sql.execute(cursor_id);
    dbms_sql.close_cursor(cursor_id);
 end loop;
 CLOSE C1;
 END;
/
select * from log_v$session;