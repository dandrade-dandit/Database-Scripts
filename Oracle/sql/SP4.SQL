select S.USERNAME, 'kill -9 ' || p.spid CMD_KILL_UNIX
from v$session s, v$process p
where p.addr = s.paddr
and s.username not in ('DBSNMP', 'SYSMAN', 'SYS')
and s.sid in (select sid from v$session
              where to_date(logon_time, 'dd/mm/yy') <> to_date(sysdate, 'dd/mm/yy')
              and username is not null)
ORDER BY
	1
/
