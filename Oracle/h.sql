select to_char(sysdate, 'dd/mm/yyyy hh24:mi:ss') from dual
/


select a.username, a.osuser, b.spid, 'orakill sebn07 ' || b.spid
from v$session a, v$process b
where a.paddr = b.addr
and a.username is not null
and a.username = 'TRACKIT60'
/
