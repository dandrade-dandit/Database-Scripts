select 	s.SID
, 	s.SERIAL#
,      	s.USERNAME
, 	'alter system DISCONNECT session '''||s.SID||','||s.SERIAL#||''' IMMEDIATE;' CMD_KILL_ORACLE
, 	'kill -9 ' || p.spid CMD_KILL_UNIX
, 	to_char(s.logon_time, 'dd/mm/yy hh24:mi:ss') datahora
,	s.OSUSER
, 	p.SPID
from v$session s, v$process p
where p.addr = s.paddr
and s.username = 'IFRMAXIMO'
/
