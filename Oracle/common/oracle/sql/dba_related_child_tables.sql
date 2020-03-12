-- +----------------------------------------------------------------------------+
-- |                          Jeffrey M. Hunter                                 |
-- |                      jhunter@idevelopment.info                             |
-- |                         www.idevelopment.info                              |
-- |----------------------------------------------------------------------------|
-- |      Copyright (c) 1998-2009 Jeffrey M. Hunter. All rights reserved.       |
-- |----------------------------------------------------------------------------|
-- | DATABASE : Oracle                                                          |
-- | FILE     : dba_related_child_tables.sql                                    |
-- | CLASS    : Database Administration                                         |
-- | PURPOSE  : Query all child tables related to a given parent table name.    |
-- | NOTE     : As with any code, ensure to test this script in a development   |
-- |            environment before attempting to run it in production.          |
-- +----------------------------------------------------------------------------+

PROMPT All child tables related to a parent table name.
Accept INTAB prompt 'Enter Parent Table Name : '

SELECT
    p.table_name  PARENT_TABLE_NAME
  , c.table_name  CHILD_TABLE
FROM
    all_constraints  p
  , all_constraints  c
WHERE
    (p.constraint_type = 'P' OR p.constraint_type = 'U')
    AND
    (c.constraint_type = 'R')
    AND
    (p.constraint_name = c.r_constraint_name)
    AND
    (p.table_name = UPPER('&INTAB'))
ORDER BY 2
/
