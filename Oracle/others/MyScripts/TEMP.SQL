select
 s.username,u."USER", u.tablespace,u.contents,u.extents,u.blocks
from
 v$session s,
 v$sort_usage u
where
 s.saddr=u.session_addr
AND
 u.contents='TEMPORARY'
order by u.blocks desc
/
