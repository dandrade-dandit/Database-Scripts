-- +----------------------------------------------------------------------------+
-- |                          Jeffrey M. Hunter                                 |
-- |                      jhunter@idevelopment.info                             |
-- |                         www.idevelopment.info                              |
-- |----------------------------------------------------------------------------|
-- |      Copyright (c) 1998-2009 Jeffrey M. Hunter. All rights reserved.       |
-- |----------------------------------------------------------------------------|
-- | DATABASE : Oracle                                                          |
-- | FILE     : dba_recompile_invalid_objects.sql                               |
-- | CLASS    : Database Administration                                         |
-- | PURPOSE  : Dynamically create a SQL script to recompile all INVALID        |
-- |            objects.                                                        |
-- | NOTE     : As with any code, ensure to test this script in a development   |
-- |            environment before attempting to run it in production.          |
-- +----------------------------------------------------------------------------+

set feedback off
set verify off
set echo off
set pagesize 0
set heading off

spool compile.sql
select  'alter ' ||
       decode(object_type, 'PACKAGE BODY', 'package', object_type) ||
       ' ' ||
       object_name||
       ' compile' ||
       decode(object_type, 'PACKAGE BODY', ' body;', ';')
from   dba_objects
where  status = 'INVALID'
/
spool off
set feedback on
set verify on
set heading on
set pagesize 40
@compile

