-- +----------------------------------------------------------------------------+
-- |                          Jeffrey M. Hunter                                 |
-- |                      jhunter@idevelopment.info                             |
-- |                         www.idevelopment.info                              |
-- |----------------------------------------------------------------------------|
-- |      Copyright (c) 1998-2009 Jeffrey M. Hunter. All rights reserved.       |
-- |----------------------------------------------------------------------------|
-- | DATABASE : Oracle                                                          |
-- | FILE     : mts_dispatcher_utilization.sql                                  |
-- | CLASS    : Multi Threaded Server                                           |
-- | PURPOSE  : Display MTS dispatcher utilization.                             |
-- | NOTE     : As with any code, ensure to test this script in a development   |
-- |            environment before attempting to run it in production.          |
-- +----------------------------------------------------------------------------+

SET LINESIZE  145
SET PAGESIZE  9999
SET VERIFY    off

COLUMN name      FORMAT a11      HEAD 'Server Name'
COLUMN busy      FORMAT 999.99   HEAD '% Busy'


SELECT
    name                                  name
  , ROUND(busy / (busy + idle) * 100, 2)  busy
FROM v$dispatcher
ORDER BY name;

