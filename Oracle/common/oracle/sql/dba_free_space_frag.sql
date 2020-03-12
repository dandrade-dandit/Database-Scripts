-- +----------------------------------------------------------------------------+
-- |                          Jeffrey M. Hunter                                 |
-- |                      jhunter@idevelopment.info                             |
-- |                         www.idevelopment.info                              |
-- |----------------------------------------------------------------------------|
-- |      Copyright (c) 1998-2009 Jeffrey M. Hunter. All rights reserved.       |
-- |----------------------------------------------------------------------------|
-- | DATABASE : Oracle                                                          |
-- | FILE     : dba_free_space_frag.sql                                         |
-- | CLASS    : Database Administration                                         |
-- | PURPOSE  : Report free space fragmentation.                                |
-- |            THIS SCRIPT MUST BE RUN AS THE SYS USER!!!                      |
-- | NOTE     : As with any code, ensure to test this script in a development   |
-- |            environment before attempting to run it in production.          |
-- +----------------------------------------------------------------------------+

connect / as sysdba

CREATE OR REPLACE VIEW free_space (
    tablespace
  , pieces
  , free_bytes
  , free_blocks
  , largest_bytes
  , largest_blks
  , fsfi
  , data_file
  , file_id
  , total_blocks
)
AS
SELECT
    a.tablespace_name
  , COUNT(*)
  , SUM(a.bytes)
  , SUM(a.blocks)
  , MAX(a.bytes)
  , MAX(a.blocks)
  , SQRT(MAX(a.blocks)/SUM(a.blocks))*(100/SQRT(SQRT(count(a.blocks))))
  , UPPER(b.file_name)
  , MAX(a.file_id)
  , MAX(b.blocks)
FROM
    sys.dba_free_space  a
  , sys.dba_data_files  b
WHERE
    a.file_id = b.file_id
GROUP BY
    a.tablespace_name,  b.file_name
/

CLEAR COLUMNS
SET LINESIZE  120
SET PAGESIZE  9999
SET FEEDBACK  off
SET VERIFY    off

BREAK ON tablespace SKIP 2 ON REPORT

COMPUTE SUM OF  total_blocks  ON tablespace
COMPUTE SUM OF  free_blocks   ON tablespace
COMPUTE SUM OF  free_blocks   ON report
COMPUTE SUM OF  total_blocks  ON report

COLUMN tablespace     HEADING "Tablespace"    FORMAT a15
COLUMN file_id        HEADING File#           FORMAT 99999
COLUMN pieces         HEADING Frag            FORMAT 9999
COLUMN free_bytes     HEADING 'Free Byte'
COLUMN free_blocks    HEADING 'Free Blk'      FORMAT 999,999,999
COLUMN largest_bytes  HEADING 'Biggest Bytes'
COLUMN largest_blks   HEADING 'Biggest Blks'  FORMAT 999,999,999
COLUMN data_file      HEADING 'File Name'     FORMAT a45
COLUMN total_blocks   HEADING 'Total Blocks'  FORMAT 999,999,999


SELECT
    tablespace
  , data_file
  , pieces
  , free_blocks
  , largest_blks
  , file_id
  , total_blocks
FROM
    free_space
/


DROP VIEW free_space
/

