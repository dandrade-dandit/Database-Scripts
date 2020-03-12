SET LINESIZE 180
set verify off

ACCEPT USERNAME CHAR PROMPT 'ENTRE COM O USÁRIO: '

SELECT .sid, a.serial#, a.status, a.osuser, a.username, a.sql_text
from v$session a, v$sqltext b
where a.sql_address =b.address
and a.username = '&USERNAME'
order by address, piece
/

set verify oN