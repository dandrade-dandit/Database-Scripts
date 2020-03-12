SET LINESIZE 180
set verify off
COL CMD_KILL_ORACLE FORMAT A60
COL CMD_KILL_UNIX FORMAT A15
COL USERNAME FORMAT A15
COL OSUSER FORMAT A15

ACCEPT USERNAME CHAR PROMPT 'ENTRE COM O US�RIO: '

select 	s.USERNAME
, 	'alter system DISCONNECT session '''||s.SID||','||s.SERIAL#||''' IMMEDIATE;' CMD_KILL_ORACLE
, 	'kill -9 ' || p.spid CMD_KILL_UNIX
, 	to_char(s.logon_time, 'dd/mm/yy hh24:mi:ss') datahora
,	s.OSUSER
, 	p.SPID
from v$session s, v$process p
where p.addr = s.paddr
and s.username = '&USERNAME'
order by 4
/

set verify oN