-- +----------------------------------------------------------------------------+
-- |                          Jeffrey M. Hunter                                 |
-- |                      jhunter@idevelopment.info                             |
-- |                         www.idevelopment.info                              |
-- |----------------------------------------------------------------------------|
-- |      Copyright (c) 1998-2009 Jeffrey M. Hunter. All rights reserved.       |
-- |----------------------------------------------------------------------------|
-- | DATABASE : Oracle                                                          |
-- | FILE     : wm_refresh_workspace.sql                                        |
-- | CLASS    : Workspace Manager                                               |
-- | PURPOSE  : This script will first display the current workspace and then   |
-- |            all currently defined workspaces. You are then prompted for the |
-- |            name of a new workspace to refresh. The script then refreshes   |
-- |            the given workspace (the child workspace) from its parent       |
-- |            workspace.                                                      |
-- | NOTE     : As with any code, ensure to test this script in a development   |
-- |            environment before attempting to run it in production.          |
-- +----------------------------------------------------------------------------+

SET LINESIZE 145
SET PAGESIZE 9999

COLUMN getworkspace     FORMAT A35          HEADING "Current Workspace"
COLUMN workspace        FORMAT A35          HEADING "All Available Workspaces"

SELECT dbms_wm.getworkspace FROM dual;

SELECT workspace FROM dba_workspaces ORDER BY 1;

PROMPT 
ACCEPT wm_refresh_workspace_name prompt 'Enter Name of Workspace to Refresh: '
PROMPT 

BEGIN
    dbms_wm.refreshworkspace('&wm_refresh_workspace_name');
END;
/

