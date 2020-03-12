-- +----------------------------------------------------------------------------+
-- |                          Jeffrey M. Hunter                                 |
-- |                      jhunter@idevelopment.info                             |
-- |                         www.idevelopment.info                              |
-- |----------------------------------------------------------------------------|
-- |      Copyright (c) 1998-2009 Jeffrey M. Hunter. All rights reserved.       |
-- |----------------------------------------------------------------------------|
-- | DATABASE : Oracle                                                          |
-- | FILE     : dba_column_constraints.sql                                      |
-- | CLASS    : Database Administration                                         |
-- | PURPOSE  : Reports on all Column Constraints in the database.              |
-- | NOTE     : As with any code, ensure to test this script in a development   |
-- |            environment before attempting to run it in production.          |
-- +----------------------------------------------------------------------------+

ttitle left 'Company Name' -
       right 'COLUMN_CONSTRAINTS.SQL' -
       center 'Column Constraints'

SET PAGESIZE 9999

column constraint_name format a20 heading 'Constraint Name'
column table_name      format a20 heading 'Table Name'
column column_name     format a25 heading 'Column Name'

break on Report on table_name skip 1

SELECT
    table_name
  , constraint_name
  , column_name
  , position
FROM
  all_cons_columns
WHERE
  table_name = upper('&TABLE_NAME')
ORDER BY
  table_name, constraint_name, position
/
