select 'alter system kill session '''||SID||','||SERIAL#||''';' SQL
, to_char(logon_time, 'dd/mm/yy hh24:mi:ss') datahora
from v$session
where status = 'ACTIVE'
and to_date(logon_time, 'dd/mm/yy') <> to_date('18/03/03', 'dd/mm/yy')
and username is not null
/


select 'alter system kill session '''||SID||','||SERIAL#||''';' SQL
, to_char(logon_time, 'dd/mm/yy hh24:mi:ss') datahora, status, username
from v$session
where to_date(logon_time, 'dd/mm/yy') <> to_date(sysdate, 'dd/mm/yy')
and username is not null
/


select decode(inst_id, 1, 'Máquina 04', 'Máquina 05') as "Instância"
,      status "Status"
,      count(1) as "Total"
from gv$session
where username is not null
group by inst_id, status;

select 'kill -9 ' || p.spid
,	s.username
from v$process p, v$session s
where p.pid = s.sid
and s.status = 'KILLED'
/


select p.spid, p.pid, p.username, p.serial#, s.sid, s.serial#,	s.username
from v$process p, v$session s
where p.pid = s.sid
and s.username = 'PATROL_IFR1B'
/
