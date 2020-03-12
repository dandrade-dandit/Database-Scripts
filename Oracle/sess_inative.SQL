SET ECHO off
REM NAME:   TFSINSES.SQL
REM USAGE:"@path/tfsinses.sql"
REM ------------------------------------------------------------------------
REM REQUIREMENTS:
REM    SELECT on V$SESSION, V$PROCESS, V$SESSION_WAIT
REM ------------------------------------------------------------------------
REM PURPOSE:
REM    This script lists inactive users in the database.  The wait
REM    sequence can be monitored to check whether this really is an
REM    inactive user or not.  The process id's can assist you to
REM    remove the process
REM ------------------------------------------------------------------------
REM EXAMPLE:
REM                                     Parent      Wait
REM    ORACLE/OS User   Term    SID SERIAL# Process ID Process ID  Sequence
REM    ---------------- ------ ---- ------- ---------- ---------- ---------
REM    SYSTEM usupport  ttype     6      21 26351      26350       28
REM
REM ------------------------------------------------------------------------
REM DISCLAIMER:
REM    This script is provided for educational purposes only. It is NOT
REM    supported by Oracle World Wide Technical Support.
REM    The script has been tested and appears to work as intended.
REM    You should always run new scripts on a test instance initially.
REM ------------------------------------------------------------------------

REM Main text of script follows:
set heading on feedback on pages 66
column userinfo heading "ORACLE/OS User" format a25
column terminal heading "Term" format a15
column sid format 99999990
column serial# format 99999990
column process heading "Parent|Process ID" format a20
column spid heading "Shadow|Process ID" format a20
column seq# heading "Wait|Sequence" format 99999990
select s.username||' '||s.osuser userinfo,s.terminal, s.sid, s.serial#,
p.spid,
s.process , w.seq#
from v$session s, v$process p
,v$session_wait w
where p.addr = s.paddr
and s.sid = w.sid
and w.event = 'SQL*Net message from client'
and s.status = 'INACTIVE'
and s.username = UPPER('&user')
order by s.osuser, s.terminal

/

