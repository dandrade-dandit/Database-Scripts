-- +----------------------------------------------------------------------------+
-- |                          Jeffrey M. Hunter                                 |
-- |                      jhunter@idevelopment.info                             |
-- |                         www.idevelopment.info                              |
-- |----------------------------------------------------------------------------|
-- |      Copyright (c) 1998-2009 Jeffrey M. Hunter. All rights reserved.       |
-- |----------------------------------------------------------------------------|
-- | DATABASE : Oracle                                                          |
-- | FILE     : dba_db_growth.sql                                               |
-- | CLASS    : Database Administration                                         |
-- | PURPOSE  : Provides a report on physical database growth with respect to   |
-- |            the date that data files have been added.                       |
-- | NOTE     : As with any code, ensure to test this script in a development   |
-- |            environment before attempting to run it in production.          |
-- +----------------------------------------------------------------------------+

SET LINESIZE 145
SET PAGESIZE 9999
SET VERIFY   OFF

COLUMN month        FORMAT a7                   HEADING 'Month'
COLUMN growth       FORMAT 999,999,999,999,999  HEADING 'Growth (Bytes)'

BREAK ON report
COMPUTE SUM OF growth ON report

SELECT
    TO_CHAR(creation_time, 'RRRR-MM') month
  , SUM(bytes)                        growth
FROM     sys.v_$datafile
GROUP BY TO_CHAR(creation_time, 'RRRR-MM')
ORDER BY TO_CHAR(creation_time, 'RRRR-MM');

