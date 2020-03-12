-- +----------------------------------------------------------------------------+
-- |                          Jeffrey M. Hunter                                 |
-- |                      jhunter@idevelopment.info                             |
-- |                         www.idevelopment.info                              |
-- |----------------------------------------------------------------------------|
-- |      Copyright (c) 1998-2009 Jeffrey M. Hunter. All rights reserved.       |
-- |----------------------------------------------------------------------------|
-- | DATABASE : Oracle                                                          |
-- | FILE     : dba_tables_all.sql                                              |
-- | CLASS    : Database Administration                                         |
-- | PURPOSE  : Query all tables (and owners) within the database.              |
-- | NOTE     : As with any code, ensure to test this script in a development   |
-- |            environment before attempting to run it in production.          |
-- +----------------------------------------------------------------------------+

SET LINESIZE 135
SET PAGESIZE 9999

COLUMN owner            FORMAT A15          HEADING "Owner"
COLUMN table_name       FORMAT A30          HEADING "Table Name"
COLUMN tablespace_name  FORMAT A28          HEADING "Tablespace"
COLUMN last_analyzed    FORMAT A20          HEADING "Last Analyzed"
COLUMN num_rows         FORMAT 999,999,999  HEADING "# of Rows"

SELECT
    owner
  , table_name
  , tablespace_name
  , TO_CHAR(last_analyzed, 'DD-MON-YYYY HH24:MI:SS') last_analyzed
  , num_rows
FROM dba_tables
ORDER BY owner, table_name
/

