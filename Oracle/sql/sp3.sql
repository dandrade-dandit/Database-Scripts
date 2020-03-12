select     s.SID
,          s.USERNAME
,          'alter system DISCONNECT session '''||s.SID||','||s.SERIAL#||''' IMMEDIATE;' CMD_KILL_ORACLE
,          'kill -9 ' || p.spid CMD_KILL_UNIX
,          s.OSUSER
,          s.terminal
from v$session s, v$process p
where p.addr = s.paddr
and (UPPER(s.PROGRAM) like 'SQLN%' or UPPER(s.PROGRAM) like '%ACCESS%' or UPPER(s.PROGRAM) like '%QUERY%')
and UPPER(s.OSUSER) not like 'PRSI%'
/
