-- +----------------------------------------------------------------------------+
-- |                          Jeffrey M. Hunter                                 |
-- |                      jhunter@idevelopment.info                             |
-- |                         www.idevelopment.info                              |
-- |----------------------------------------------------------------------------|
-- |      Copyright (c) 1998-2009 Jeffrey M. Hunter. All rights reserved.       |
-- |----------------------------------------------------------------------------|
-- | DATABASE : Oracle                                                          |
-- | FILE     : dba_plsql_package_size.sql                                      |
-- | CLASS    : Database Administration                                         |
-- | PURPOSE  : Internal size of PL/SQL Packages.                               |
-- | NOTE     : As with any code, ensure to test this script in a development   |
-- |            environment before attempting to run it in production.          |
-- +----------------------------------------------------------------------------+

SET LINESIZE 130
SET PAGESIZE 9999

COLUMN owner       FORMAT a10            HEAD "Owner"
COLUMN name        FORMAT a30            HEAD "Name"
COLUMN type        FORMAT a13            HEAD "Type"
COLUMN total_bytes FORMAT 999,999,999    HEAD "Total bytes"

SELECT
    owner
  , name
  , type
  , source_size+code_size+parsed_size+error_size total_bytes
FROM
  dba_object_size
WHERE
      type = 'PACKAGE BODY'
  AND owner NOT IN ('SYS')
ORDER BY
  4 DESC;
