-- +----------------------------------------------------------------------------+
-- |                          Jeffrey M. Hunter                                 |
-- |                      jhunter@idevelopment.info                             |
-- |                         www.idevelopment.info                              |
-- |----------------------------------------------------------------------------|
-- |      Copyright (c) 1998-2009 Jeffrey M. Hunter. All rights reserved.       |
-- |----------------------------------------------------------------------------|
-- | DATABASE : Oracle                                                          |
-- | FILE     : wm_disable_versioning.sql                                       |
-- | CLASS    : Workspace Manager                                               |
-- | PURPOSE  : Prompt the user for a table name. This table will be disabled   |
-- |            of any versioning used with Workspace Manager.                  |
-- |            (Oracle9i or higher)                                            |
-- | NOTE     : As with any code, ensure to test this script in a development   |
-- |            environment before attempting to run it in production.          |
-- +----------------------------------------------------------------------------+

SET LINESIZE 145
SET PAGESIZE 9999

COLUMN object_name      FORMAT A30          HEADING "Object Name"
COLUMN object_type      FORMAT A18          HEADING "Object Type"

PROMPT 
ACCEPT wm_dv_table prompt 'Enter Table to Disable Versioning (i.e. EMP) : '
PROMPT 

BEGIN
    dbms_wm.disableversioning('&wm_dv_table');
END;
/

SELECT object_name, object_type
FROM   user_objects
WHERE  object_name like '&wm_ev_table%';
