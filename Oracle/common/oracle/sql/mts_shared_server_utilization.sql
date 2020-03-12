-- +----------------------------------------------------------------------------+
-- |                          Jeffrey M. Hunter                                 |
-- |                      jhunter@idevelopment.info                             |
-- |                         www.idevelopment.info                              |
-- |----------------------------------------------------------------------------|
-- |      Copyright (c) 1998-2009 Jeffrey M. Hunter. All rights reserved.       |
-- |----------------------------------------------------------------------------|
-- | DATABASE : Oracle                                                          |
-- | FILE     : mts_shared_server_utilization.sql                               |
-- | CLASS    : Multi Threaded Server                                           |
-- | PURPOSE  : Display status and metrics related to MTS shared server         |
-- |            utilization.                                                    |
-- | NOTE     : As with any code, ensure to test this script in a development   |
-- |            environment before attempting to run it in production.          |
-- +----------------------------------------------------------------------------+

SET LINESIZE  145
SET PAGESIZE  9999
SET VERIFY    off

COLUMN s_name   FORMAT a25    HEAD 'Server Name'
COLUMN s_busy                 HEAD '% Busy'

SELECT
    name                                 s_name
  , ROUND(busy / (busy + idle) * 100, 2) s_busy
FROM v$shared_server
ORDER BY name;
