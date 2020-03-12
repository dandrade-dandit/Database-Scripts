col USERNAME format a10
col TERMINAL format a15
col PROGRAM format a30
select SID, SERIAL#, USERNAME, TERMINAL, PROGRAM
from v$session;