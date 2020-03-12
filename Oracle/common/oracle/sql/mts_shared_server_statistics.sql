-- +----------------------------------------------------------------------------+
-- |                          Jeffrey M. Hunter                                 |
-- |                      jhunter@idevelopment.info                             |
-- |                         www.idevelopment.info                              |
-- |----------------------------------------------------------------------------|
-- |      Copyright (c) 1998-2009 Jeffrey M. Hunter. All rights reserved.       |
-- |----------------------------------------------------------------------------|
-- | DATABASE : Oracle                                                          |
-- | FILE     : mts_shared_server_statistics.sql                                |
-- | CLASS    : Multi Threaded Server                                           |
-- | PURPOSE  : Display status and metrics related to MTS shared server         |
-- |            statistics.                                                     |
-- |                                                                            |
-- |            SERVERS_STARTED    : The number of shared server processes      |
-- |                                 started as the instance adjusts the number |
-- |                                 of shared processes up and down from the   |
-- |                                 initial value specified by the MTS_SERVERS |
-- |                                 parameter. When the instance starts, and   |
-- |                                 after the initial number of shared server  |
-- |                                 processes processes specified by           |
-- |                                 MTS_SERVERS has been started, this value   |
-- |                                 is set to 0. From that point on, this      |
-- |                                 value is incremented whenever a new shared |
-- |                                 server process is started.                 |
-- |            SERVERS_TERMINATED : A count of the total number of shared      |
-- |                                 server processes that have been terminated |
-- |                                 since the instance was started.            |
-- |            SERVERS_HIGHWATER  : The maximum number of shared server        |
-- |                                 processes that have ever been running at   |
-- |                                 one moment in time.                        |
-- |                                                                            |
-- |            NOTES: If the SERVERS_HIGHWATER value matches, the instance's   |
-- |                   MTS_MAX_SERVERS value, then you might realize a          |
-- |                   performance benefit from increasing MTS_MAX_SERVERS. If  |
-- |                   the counts for SERVERS_STARTED and SERVERS_TERMINATED    |
-- |                   keep climbing, then you should consider raising          |
-- |                   MTS_SERVERS. Raising the minimum number of shared server |
-- |                   processes should reduce the number that are deleted only |
-- |                   to be recreated later.                                   |
-- | NOTE     : As with any code, ensure to test this script in a development   |
-- |            environment before attempting to run it in production.          |
-- +----------------------------------------------------------------------------+

SET LINESIZE  145
SET PAGESIZE  9999
SET VERIFY    off

COLUMN servers_started      FORMAT 999,999,999     HEAD 'Servers Started'
COLUMN servers_terminated   FORMAT 999,999,999     HEAD 'Servers Terminated'
COLUMN servers_highwater    FORMAT 999,999,999     HEAD 'Servers Highwater'

SELECT
    servers_started
  , servers_terminated
  , servers_highwater
FROM v$mts;

