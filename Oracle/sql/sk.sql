set echo off
ACCEPT sid NUMBER PROMPT 'Informe o SID:> '
select s.PADDR,s.SID,s.SERIAL#,s.USERNAME,s.OSUSER,s.PROGRAM, p.SPID 
from v$session s, v$process p 
where p.addr = s.paddr 
and s.sid = &sid
/ 
