-- +----------------------------------------------------------------------------+
-- |                          Jeffrey M. Hunter                                 |
-- |                      jhunter@idevelopment.info                             |
-- |                         www.idevelopment.info                              |
-- |----------------------------------------------------------------------------|
-- |      Copyright (c) 1998-2009 Jeffrey M. Hunter. All rights reserved.       |
-- |----------------------------------------------------------------------------|
-- | DATABASE : Oracle                                                          |
-- | FILE     : wm_workspaces.sql                                               |
-- | CLASS    : Workspace Manager                                               |
-- | PURPOSE  : Identify all defined workspaces.                                |
-- | NOTE     : As with any code, ensure to test this script in a development   |
-- |            environment before attempting to run it in production.          |
-- +----------------------------------------------------------------------------+

SET LINESIZE 145
SET PAGESIZE 9999

COLUMN owner             FORMAT a10        HEADING "Owner"
COLUMN getworkspace      FORMAT a30        HEADING "Workspace|Name"
COLUMN parent_workspace  FORMAT a30        HEADING "Parent|Workspace"
COLUMN createtime        FORMAT a20        HEADING "Create|Time"
COLUMN freeze_status     FORMAT a8         HEADING "Freeze|Status"
COLUMN freeze_mode       FORMAT a20        HEADING "Freeze|Mode"

SELECT
    owner
  , workspace
  , parent_workspace
  , TO_CHAR(createtime, 'DD-MON-YYYY HH24:MI:SS') createtime
  , freeze_status
  , freeze_mode
FROM dba_workspaces
ORDER BY owner, workspace
/

