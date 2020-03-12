-- +----------------------------------------------------------------------------+
-- |                          Jeffrey M. Hunter                                 |
-- |                      jhunter@idevelopment.info                             |
-- |                         www.idevelopment.info                              |
-- |----------------------------------------------------------------------------|
-- |      Copyright (c) 1998-2009 Jeffrey M. Hunter. All rights reserved.       |
-- |----------------------------------------------------------------------------|
-- | DATABASE : Oracle                                                          |
-- | FILE     : dba_registry.sql                                                |
-- | CLASS    : Database Administration                                         |
-- | PURPOSE  : Provides summary report on all registered components.           |
-- | NOTE     : As with any code, ensure to test this script in a development   |
-- |            environment before attempting to run it in production.          |
-- +----------------------------------------------------------------------------+

SET LINESIZE 145
SET PAGESIZE 9999
SET VERIFY   OFF

COLUMN comp_id    FORMAT a9    HEADING 'Component|ID'
COLUMN comp_name  FORMAT a35   HEADING 'Component|Name'
COLUMN version    FORMAT a13   HEADING 'Version'
COLUMN status     FORMAT a11   HEADING 'Status'
COLUMN modified                HEADING 'Modified'
COLUMN Schema     FORMAT a8    HEADING 'Schema'
COLUMN procedure  FORMAT a41   HEADING 'Procedure'

SELECT
    comp_id
  , comp_name
  , version
  , status
  , modified
  , schema
  , procedure
FROM
    dba_registry;

