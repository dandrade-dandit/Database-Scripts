-- +----------------------------------------------------------------------------+
-- |                          Jeffrey M. Hunter                                 |
-- |                      jhunter@idevelopment.info                             |
-- |                         www.idevelopment.info                              |
-- |----------------------------------------------------------------------------|
-- |      Copyright (c) 1998-2009 Jeffrey M. Hunter. All rights reserved.       |
-- |----------------------------------------------------------------------------|
-- | DATABASE : Oracle                                                          |
-- | FILE     : mts_dispatcher_status.sql                                       |
-- | CLASS    : Multi Threaded Server                                           |
-- | PURPOSE  : Display status and metrics related to the MTS dispatcher. The   |
-- |            following notes provide information on how to read and interpret|
-- |            the results of this query:                                      |
-- |                                                                            |
-- |            NAME       : Returns the dispatcher's name. This forms part of  |
-- |                         the operating system process name.                 |
-- |            STATUS       WAIT       : The dispatcher is idle and waiting    |
-- |                                      for work.                             |
-- |                         SEND       : The dispatcher is sending a message.  |
-- |                         RECEIVE    : The dispatcher is receiving a message.|
-- |                         CONNECT    : The dispatcher is establishing a new  |
-- |                                      connection from a client.             |
-- |                         DISCONNECT : A client is disconnecting from the    |
-- |                                      dispatcher.                           |
-- |                         BREAK      : The dispatcher is handling a break.   |
-- |                         OUTBOUND   : The dispatcher is establishing an     |
-- |                                      outbound connection.                  |
-- |            ACCEPT     : Tells you whether or not the dispatcher is         |
-- |                         accepting new connections. Valid values are YES    |
-- |                         and NO.                                            |
-- |            CREATED    : Returns the number of virtual circuits currently   |
-- |                         associated with this dispatcher.                   |
-- |            CONFIG IDX : Indicates the specific MTS_DISPATCHERS             |
-- |                         initialization parameter on which this dispatcher  |
-- |                         is based. Dispatchers created from the first       |
-- |                         MTS_DISPATCHERS parameter in your instance's       |
-- |                         parameter file will have a CONF_INDX value of 0.   |
-- |                         Dispatcher's created from the second               |
-- |                         MTS_DISPATCHERS parameter will have a value of 1,  |
-- |                         and so on.                                         |
-- |            NETWORK    : Returns the dispatcher's network address.          |
-- | NOTE     : As with any code, ensure to test this script in a development   |
-- |            environment before attempting to run it in production.          |
-- +----------------------------------------------------------------------------+

SET LINESIZE  145
SET PAGESIZE  9999
SET VERIFY    off

COLUMN name          FORMAT a11     HEAD 'Dispatcher|Name'
COLUMN status        FORMAT a8      HEAD 'Status'
COLUMN accept        FORMAT a8      HEAD 'Accept'
COLUMN created                      HEAD 'Created'
COLUMN conf_indx                    HEAD 'Config.|Index'
COLUMN network       FORMAT a55     HEAD 'Network'

SELECT
    name
  , status
  , accept
  , created
  , conf_indx
  , network
FROM v$dispatcher
ORDER BY name;

