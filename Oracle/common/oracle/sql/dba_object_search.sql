-- +----------------------------------------------------------------------------+
-- |                          Jeffrey M. Hunter                                 |
-- |                      jhunter@idevelopment.info                             |
-- |                         www.idevelopment.info                              |
-- |----------------------------------------------------------------------------|
-- |      Copyright (c) 1998-2009 Jeffrey M. Hunter. All rights reserved.       |
-- |----------------------------------------------------------------------------|
-- | DATABASE : Oracle                                                          |
-- | FILE     : dba_object_search.sql                                           |
-- | CLASS    : Database Administration                                         |
-- | PURPOSE  : Prompt the user for a query string and look for any object that |
-- |            contains that string.                                           |
-- | NOTE     : As with any code, ensure to test this script in a development   |
-- |            environment before attempting to run it in production.          |
-- +----------------------------------------------------------------------------+

SET LINESIZE 135
SET PAGESIZE 9999

COLUMN owner           FORMAT A15    HEADING "Owner"
COLUMN object_name     FORMAT A35    HEADING "Object Name"
COLUMN object_type     FORMAT A18    HEADING "Object Type"
COLUMN created                       HEADING "Created"
COLUMN status                        HEADING "Status"


ACCEPT sch prompt 'Enter Search String (i.e. CONTROL) : '

SELECT
    owner
  , object_name
  , object_type
  , TO_CHAR(created, 'DD-MON-YYYY HH24:MI:SS') created
  , LPAD(status, 7) status
FROM all_objects
WHERE object_name like UPPER('%&sch%')
ORDER BY owner, object_name, object_type
/

