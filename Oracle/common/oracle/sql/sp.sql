SET LINESIZE 180
COL CMD_KILL_ORACLE FORMAT A60
COL CMD_KILL_UNIX FORMAT A15
COL USERNAME FORMAT A15
COL OSUSER FORMAT A15
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
and s.sid in (select sid from v$session
              where to_date(logon_time, 'dd/mm/yy') <> to_date(sysdate, 'dd/mm/yy')
              and username is not null)
and s.username not in ('SYSMAN','DBSNMP','SYS')
order by  6
/ 
