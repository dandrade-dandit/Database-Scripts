-- +----------------------------------------------------------------------------+
-- |                          Jeffrey M. Hunter                                 |
-- |                      jhunter@idevelopment.info                             |
-- |                         www.idevelopment.info                              |
-- |----------------------------------------------------------------------------|
-- |      Copyright (c) 1998-2009 Jeffrey M. Hunter. All rights reserved.       |
-- |----------------------------------------------------------------------------|
-- | DATABASE : Oracle                                                          |
-- | FILE     : erp_conc_manager_user_query.sql                                 |
-- | CLASS    : Oracle Applications                                             |
-- | PURPOSE  : Reports on concurrent manager processes.                        |
-- | NOTE     : As with any code, ensure to test this script in a development   |
-- |            environment before attempting to run it in production.          |
-- +----------------------------------------------------------------------------+

SET LINESIZE 135
SET PAGESIZE 9999
SET VERIFY   OFF

COLUMN oracle_process_id FORMAT    9999999 HEADING 'PID';
COLUMN session_id        FORMAT    9999999 HEADING 'Session ID';
COLUMN oracle_id         FORMAT    9999999 HEADING 'Oracle ID';
COLUMN os_process_id     FORMAT        a10 HEADING 'OS PID';
COLUMN request_id        FORMAT    9999999 HEADING 'Request ID';
COLUMN requested_by      FORMAT    9999999 HEADING 'Requested By';
COLUMN status_code       FORMAT         a6 HEADING 'Status';
COLUMN completion_text   FORMAT        a15 HEADING 'Text';
COLUMN user_id           FORMAT    9999999 HEADING 'User ID';
COLUMN user_name         FORMAT        a10 HEADING 'User Name';

SELECT
    c.os_process_id
  , a.oracle_id
  , a.request_id
  , a.requested_by
  , b.user_name
  , a.phase_code
  , a.completion_text
FROM
    applsys.fnd_concurrent_requests a
  , applsys.fnd_user b
  , applsys.fnd_concurrent_processes c
WHERE
      a.requested_by = b.user_id
  AND c.concurrent_process_id = a.controlling_manager
  AND a.phase_code in ('R', 'T')
ORDER BY
  c.os_process_id
/


