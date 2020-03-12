-- +----------------------------------------------------------------------------+
-- |                          Jeffrey M. Hunter                                 |
-- |                      jhunter@idevelopment.info                             |
-- |                         www.idevelopment.info                              |
-- |----------------------------------------------------------------------------|
-- |      Copyright (c) 1998-2009 Jeffrey M. Hunter. All rights reserved.       |
-- |----------------------------------------------------------------------------|
-- | DATABASE : Oracle                                                          |
-- | FILE     : sec_roles.sql                                                   |
-- | CLASS    : Security                                                        |
-- | PURPOSE  : Report on all roles defined in the database and which users     |
-- |            are assigned to that role.                                      |
-- | NOTE     : As with any code, ensure to test this script in a development   |
-- |            environment before attempting to run it in production.          |
-- +----------------------------------------------------------------------------+

SET LINESIZE  145
SET PAGESIZE  9999
SET VERIFY    off

COLUMN role             FORMAT a30    HEAD 'Role Name'
COLUMN grantee          FORMAT a30    HEAD 'Grantee'
COLUMN admin_option     FORMAT a15    HEAD 'Admin Option?'
COLUMN default_role     FORMAT a15    HEAD 'Default Role?'

break on role skip 2

SELECT
    b.role
  , a.grantee
  , a.admin_option
  , a.default_role
FROM
    dba_role_privs  a
  , dba_roles       b
WHERE
    granted_role(+) = b.role
ORDER BY
    b.role
  , a.grantee
/

