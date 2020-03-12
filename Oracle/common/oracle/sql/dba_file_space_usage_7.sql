-- +----------------------------------------------------------------------------+
-- |                          Jeffrey M. Hunter                                 |
-- |                      jhunter@idevelopment.info                             |
-- |                         www.idevelopment.info                              |
-- |----------------------------------------------------------------------------|
-- |      Copyright (c) 1998-2009 Jeffrey M. Hunter. All rights reserved.       |
-- |----------------------------------------------------------------------------|
-- | DATABASE : Oracle                                                          |
-- | FILE     : dba_file_space_usage_7.sql                                      |
-- | CLASS    : Database Administration                                         |
-- | PURPOSE  : Reports on all data file usage. This script was designed to     |
-- |            work with Oracle7 and Oracle8. This script can be run against   |
-- |            higher database versions (i.e. Oracle8i) but will not return    |
-- |            information about true TEMPORARY tablespaces. (i.e. use of      |
-- |            "tempfiles")                                                    |
-- | NOTE     : As with any code, ensure to test this script in a development   |
-- |            environment before attempting to run it in production.          |
-- +----------------------------------------------------------------------------+

SET LINESIZE 145
SET PAGESIZE 9999
SET VERIFY   OFF

COLUMN bs NEW_VALUE xbs NOPRINT FORMAT a1

COLUMN tablespace  FORMAT a18              HEADING 'Tablespace Name'
COLUMN filename    FORMAT a50              HEADING 'Filename'
COLUMN filesize    FORMAT 99,999,999,999   HEADING 'File Size'
COLUMN used        FORMAT 99,999,999,999   HEADING 'Used (in bytes)'
COLUMN free        FORMAT 99,999,999,999   HEADING 'Free (in bytes)'
COLUMN pct_used    FORMAT 999              HEADING 'Pct. Used'

SELECT value bs FROM v$parameter WHERE name = 'db_block_size';

BREAK ON report
COMPUTE AVG OF pct_used  ON report
COMPUTE SUM OF filesize  ON report
COMPUTE SUM OF used      ON report
COMPUTE SUM OF free      ON report

SELECT
    DECODE(x.online$,
           1,x.name,
           65537, substr(rpad(x.name,9),1,9)||' (TEMP)',
           substr(rpad(x.name,9),1,9)||' (OFF)')                      tablespace
  , a.file_name                                                        filename
  , ROUND(f.blocks*&xbs)                                               filesize
  , NVL(ROUND(SUM(s.length*&xbs),1),0)                                 used
  , ROUND(((f.blocks*&xbs)) - nvl(sum(s.length*&xbs),0), 1)            free
  , NVL(TRUNC(ROUND(SUM(s.length*&xbs) / (f.blocks*&xbs) * 100, 1)),0) pct_used
FROM
    sys.dba_data_files A
  , sys.uet$ s
  , sys.file$ f
  , sys.ts$ x
WHERE
      x.ts#      = f.ts#
  AND x.online$ IN (1,2,65537)
  AND f.status$ = 2
  AND f.ts#      = s.ts# (+)
  AND f.file#    = s.file# (+)
  AND f.file#    = a.file_id
GROUP BY
    x.name
  , x.online$
  , f.blocks
  , A.file_name
  , a.file_id
/

