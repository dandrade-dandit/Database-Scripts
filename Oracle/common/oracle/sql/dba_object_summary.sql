-- +----------------------------------------------------------------------------+
-- |                          Jeffrey M. Hunter                                 |
-- |                      jhunter@idevelopment.info                             |
-- |                         www.idevelopment.info                              |
-- |----------------------------------------------------------------------------|
-- |      Copyright (c) 1998-2009 Jeffrey M. Hunter. All rights reserved.       |
-- |----------------------------------------------------------------------------|
-- | DATABASE : Oracle                                                          |
-- | FILE     : dba_object_summary.sql                                          |
-- | CLASS    : Database Administration                                         |
-- | PURPOSE  : Provide a summary report of all objects in the database.        |
-- | NOTE     : As with any code, ensure to test this script in a development   |
-- |            environment before attempting to run it in production.          |
-- +----------------------------------------------------------------------------+

SET LINESIZE 135
SET PAGESIZE 9999

COLUMN owner           FORMAT A15          HEADING "Owner"
COLUMN object_type     FORMAT A18          HEADING "Object Type"
COLUMN obj_count       FORMAT 999,999,999  HEADING "Object Count"

break on report on owner skip 2
compute sum label ""               of obj_count on owner
compute sum label "Grand Total: "  of obj_count on report

SELECT
    owner
  , object_type
  , count(*)    obj_count
FROM
    dba_objects
GROUP BY
    owner
  , object_type
/
