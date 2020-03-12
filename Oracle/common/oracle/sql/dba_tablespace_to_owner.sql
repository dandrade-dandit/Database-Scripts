-- +----------------------------------------------------------------------------+
-- |                          Jeffrey M. Hunter                                 |
-- |                      jhunter@idevelopment.info                             |
-- |                         www.idevelopment.info                              |
-- |----------------------------------------------------------------------------|
-- |      Copyright (c) 1998-2009 Jeffrey M. Hunter. All rights reserved.       |
-- |----------------------------------------------------------------------------|
-- | DATABASE : Oracle                                                          |
-- | FILE     : dba_tablespace_to_owner.sql                                     |
-- | CLASS    : Database Administration                                         |
-- | PURPOSE  : Provide a summary report of tablespace to owner for all         |
-- |            segments in the database.                                       |
-- | NOTE     : As with any code, ensure to test this script in a development   |
-- |            environment before attempting to run it in production.          |
-- +----------------------------------------------------------------------------+

SET LINESIZE 145
SET PAGESIZE 9999

COLUMN tablespace_name FORMAT a30                  HEADING "Tablespace Name"
COLUMN owner           FORMAT A15                  HEADING "Owner"
COLUMN segment_type    FORMAT A18                  HEADING "Segment Type"
COLUMN bytes           FORMAT 9,999,999,999,999    HEADING "Size (in Bytes)"
COLUMN seg_count       FORMAT 9,999,999,999        HEADING "Segment Count"

break on report on tablespace_name skip 2
compute sum label ""                of seg_count bytes on tablespace_name
compute sum label "Grand Total: "   of seg_count bytes on report

SELECT
    tablespace_name
  , owner
  , segment_type
  , sum(bytes)  bytes
  , count(*)    seg_count
FROM
    dba_segments
GROUP BY
    tablespace_name
  , owner
  , segment_type
ORDER BY
    tablespace_name
  , owner
  , segment_type
/
