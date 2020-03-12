select a.username, a.osuser, b.spid, 'orakill sebn07 ' || b.spid
from v$session a, v$process b
where a.paddr = b.addr
and a.username is not null;
/
