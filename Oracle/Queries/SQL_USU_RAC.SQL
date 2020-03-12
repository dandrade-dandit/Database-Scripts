ACCEPT tusu CHAR PROMPT 'ENTRE COM O USUARIO: '

SELECT a.inst_id, a.sid, a.serial#, a.status, osuser, username, sql_text
from gv$session a, gv$sqltext b
where a.sql_address =b.address
and upper(username) = upper('&tusu')
order by a.inst_id, a.sid, a.serial#, address, piece
/