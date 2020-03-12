-- +----------------------------------------------------------------------------+
-- |                          Jeffrey M. Hunter                                 |
-- |                      jhunter@idevelopment.info                             |
-- |                         www.idevelopment.info                              |
-- |----------------------------------------------------------------------------|
-- |      Copyright (c) 1998-2009 Jeffrey M. Hunter. All rights reserved.       |
-- |----------------------------------------------------------------------------|
-- | DATABASE : Oracle                                                          |
-- | FILE     : sess_users.sql                                                  |
-- | CLASS    : Session Management                                              |
-- | PURPOSE  : List all currently connected users.                             |
-- | NOTE     : As with any code, ensure to test this script in a development   |
-- |            environment before attempting to run it in production.          |
-- +----------------------------------------------------------------------------+

SET LINESIZE 145
SET PAGESIZE 9999

COLUMN sid               FORMAT 99999      HEADING 'SID'
COLUMN serial_id         FORMAT 99999999   HEADING 'Serial ID'
COLUMN session_status    FORMAT a9         HEADING 'Status'          JUSTIFY right
COLUMN oracle_username   FORMAT a14        HEADING 'Oracle User'     JUSTIFY right
COLUMN os_username       FORMAT a12        HEADING 'O/S User'        JUSTIFY right
COLUMN os_pid            FORMAT 9999999    HEADING 'O/S PID'         JUSTIFY right
COLUMN session_program   FORMAT a26        HEADING 'Session Program' TRUNC
COLUMN session_terminal  FORMAT a10        HEADING 'Terminal'        JUSTIFY right
COLUMN session_machine   FORMAT a19        HEADING 'Machine'         JUSTIFY right

prompt 
prompt +----------------------------------------------------+
prompt | User Sessions (All)                                |
prompt +----------------------------------------------------+

SELECT
    s.sid                sid
  , s.serial#            serial_id
  , lpad(s.status,9)     session_status
  , lpad(s.username,14)  oracle_username
  , lpad(s.osuser,12)    os_username
  , lpad(p.spid,7)       os_pid
  , s.program            session_program
  , lpad(s.terminal,10)  session_terminal
  , lpad(s.machine,19)   session_machine
FROM 
    v$process p
  , v$session s
WHERE p.addr (+) = s.paddr
ORDER BY sid
/

