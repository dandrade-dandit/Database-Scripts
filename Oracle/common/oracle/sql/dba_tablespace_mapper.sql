-- +----------------------------------------------------------------------------+
-- |                          Jeffrey M. Hunter                                 |
-- |                      jhunter@idevelopment.info                             |
-- |                         www.idevelopment.info                              |
-- |----------------------------------------------------------------------------|
-- |      Copyright (c) 1998-2009 Jeffrey M. Hunter. All rights reserved.       |
-- |----------------------------------------------------------------------------|
-- | DATABASE : Oracle                                                          |
-- | FILE     : dba_tablespace_mapper.sql                                       |
-- | CLASS    : Database Administration                                         |
-- | PURPOSE  : Report on all USED and FREE SPACE within a tablespace. This is  |
-- |            a good script to report on tablespace fragmentation.            |
-- | NOTE     : As with any code, ensure to test this script in a development   |
-- |            environment before attempting to run it in production.          |
-- +----------------------------------------------------------------------------+

SET LINESIZE 135
SET PAGESIZE 9999
SET VER      off

COLUMN owner       FORMAT a15         HEADING "Owner"
COLUMN object      FORMAT a20         HEADING "Object"
COLUMN file_id                        HEADING "File ID"
COLUMN block_id                       HEADING "Block ID"
COLUMN bytes       FORMAT 999,999,999 HEADING "Bytes"

SPOOL tablespace_mapper.lst

ACCEPT tbs prompt 'Enter Tablespace Name : '

SELECT
    'FREE SPACE' owner
  , ' '          object
  , file_id
  , block_id
  , bytes
FROM
  dba_free_space
WHERE
  tablespace_name = UPPER('&tbs')
UNION
SELECT
    SUBSTR(owner, 1, 20)
  , SUBSTR(segment_name, 1, 32)
  , file_id
  , block_id
  , bytes
FROM
  dba_extents
WHERE
  tablespace_name = UPPER('&tbs')
ORDER BY
    3
  , 4
/

SPOOL off
