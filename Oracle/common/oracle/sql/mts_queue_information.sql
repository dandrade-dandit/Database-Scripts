-- +----------------------------------------------------------------------------+
-- |                          Jeffrey M. Hunter                                 |
-- |                      jhunter@idevelopment.info                             |
-- |                         www.idevelopment.info                              |
-- |----------------------------------------------------------------------------|
-- |      Copyright (c) 1998-2009 Jeffrey M. Hunter. All rights reserved.       |
-- |----------------------------------------------------------------------------|
-- | DATABASE : Oracle                                                          |
-- | FILE     : mts_queue_information.sql                                       |
-- | CLASS    : Multi Threaded Server                                           |
-- | PURPOSE  : Display status and metrics related to MTS queue information.    |
-- |            You can get an idea of how well work is flowing through the     |
-- |            request and response queues by using v$queue. The DECODE in the |
-- |            query handles the case where the TOTALQ column, which is the    |
-- |            divisor, happens to be zero.                                    |
-- |                                                                            |
-- |            The average wait time is reported in hundreths of a second.     |
-- |            (i.e. If the average wait time of a dispatcher is 37, works out |
-- |                  to 0.37 seconds.)                                         |
-- |                                                                            |
-- |            The COMMON queue is where requests are placed so that they can  |
-- |            be picked up and executed by a shared server process. If you    |
-- |            average wait time is high, you might be able to lower it by     |
-- |            creating more shared server processes.                          |
-- | NOTE     : As with any code, ensure to test this script in a development   |
-- |            environment before attempting to run it in production.          |
-- +----------------------------------------------------------------------------+

SET LINESIZE  145
SET PAGESIZE  9999
SET VERIFY    off

COLUMN paddr           FORMAT a15     HEAD 'PADDR'
COLUMN queue_type      FORMAT a13     HEAD 'Queue Type'
COLUMN queued                         HEAD 'Queued'
COLUMN awt             FORMAT 999.99  HEAD 'Average_Wait_Time'

SELECT
    paddr                           paddr
  , type                            queue_type
  , queued                          queued
  , DECODE(totalq,0,0,wait/totalq)  awt
FROM v$queue;

