-- +----------------------------------------------------------------------------+
-- |                          Jeffrey M. Hunter                                 |
-- |                      jhunter@idevelopment.info                             |
-- |                         www.idevelopment.info                              |
-- |----------------------------------------------------------------------------|
-- |      Copyright (c) 1998-2009 Jeffrey M. Hunter. All rights reserved.       |
-- |----------------------------------------------------------------------------|
-- | DATABASE : Oracle                                                          |
-- | FILE     : dba_rebuild_indexes.sql                                         |
-- | CLASS    : Database Administration                                         |
-- | PURPOSE  : This script generates another script that will include all of   |
-- |            the ALTER INDEX REBUILD ....  commands needed to rebuild a      |
-- |            tablespaces indexes. This script will prompt the user for the   |
-- |            tablespace name. This script must be run be a user with the DBA |
-- |            role under Oracle7.                                             |
-- | NOTE     : As with any code, ensure to test this script in a development   |
-- |            environment before attempting to run it in production.          |
-- +----------------------------------------------------------------------------+

SET ECHO      OFF
SET FEEDBACK  OFF
SET VERIFY    OFF
SET PAGESIZE  0
SET TERMOUT   ON
SET HEADING   OFF

ACCEPT TS_NAME CHAR PROMPT 'Enter the index tablespace name: ' 
PROMPT Thanks... Creating Rebuild Index Script for Tablespace: &TS_NAME

SET TERMOUT   OFF

spool rebuild_&TS_NAME._indexes.sql

SELECT 'REM FILE : rebuild_&TS_NAME._indexes.sql' FROM dual;
SELECT ' ' FROM dual;
SELECT 'REM' FROM dual;
SELECT 'REM ***** ALTER INDEX REBUILD commands for tablespace: &TS_NAME' FROM dual;
SELECT 'REM' FROM dual;
SELECT ' ' FROM dual;

SELECT 
  'REM +-----------------------------------------------+' || chr(10) ||
  'REM | INDEX NAME : ' || owner   || '.' || segment_name 
         || lpad('|', 33 - (length(owner) + length(segment_name)) )
         || chr(10) ||
  'REM | BYTES      : ' || bytes   
         || lpad ('|', 34-(length(bytes)) ) || chr(10) ||
  'REM | EXTENTS    : ' || extents 
         || lpad ('|', 34-(length(extents)) ) || chr(10) ||
  'REM +-----------------------------------------------+' || chr(10) ||
  'ALTER INDEX ' || owner || '.' || segment_name || chr(10) ||
  'REBUILD ' || chr(10) ||
  'TABLESPACE ' || tablespace_name || chr(10) ||
  'STORAGE ( ' || chr(10) ||
  '  INITIAL     ' || initial_extent || chr(10) ||
  '  NEXT        ' || next_extent || chr(10) ||
  '  MINEXTENTS  ' || min_extents || chr(10) ||
  '  MAXEXTENTS  ' || max_extents || chr(10) ||
  '  PCTINCREASE ' || pct_increase || chr(10) ||
  ');' || chr(10) || chr(10)
FROM   dba_segments
WHERE  segment_type = 'INDEX'
  AND  owner NOT IN ('SYS')
  AND  tablespace_name = UPPER('&TS_NAME')
ORDER BY owner, bytes DESC
/


spool off
SET TERMOUT ON
prompt Done... Built the script rebuild_&TS_NAME._indexes.sql
SET TERMOUT OFF
exit

