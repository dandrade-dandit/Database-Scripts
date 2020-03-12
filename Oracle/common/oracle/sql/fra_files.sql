-- +----------------------------------------------------------------------------+
-- |                          Jeffrey M. Hunter                                 |
-- |                      jhunter@idevelopment.info                             |
-- |                         www.idevelopment.info                              |
-- |----------------------------------------------------------------------------|
-- |      Copyright (c) 1998-2009 Jeffrey M. Hunter. All rights reserved.       |
-- |----------------------------------------------------------------------------|
-- | DATABASE : Oracle                                                          |
-- | FILE     : fra_files.sql                                                   |
-- | CLASS    : Flash Recovery Area                                             |
-- | PURPOSE  : Provide a list of all files in the Flash Recovery Area.         |
-- | NOTE     : As with any code, ensure to test this script in a development   |
-- |            environment before attempting to run it in production.          |
-- +----------------------------------------------------------------------------+

SET LINESIZE 145
SET PAGESIZE 9999

COLUMN name               FORMAT a75                  HEADING 'File Name'
COLUMN member      FORMAT a75 HEADING 'File Name'
COLUMN handle      FORMAT a75 HEADING 'File Name'



SELECT    name, (blocks*block_size)
FROM      v$datafile_copy
WHERE     is_recovery_dest_file = 'YES'
UNION
SELECT    name, null
FROM      v$controlfile
WHERE     is_recovery_dest_file = 'YES'
UNION
SELECT    member, null
FROM      v$logfile
WHERE     is_recovery_dest_file = 'YES'
UNION
SELECT    handle, bytes
FROM      v$backup_piece
WHERE     is_recovery_dest_file = 'YES'
UNION
SELECT    name, (blocks*block_size)
FROM      v$archived_log
WHERE     is_recovery_dest_file = 'YES'
/


$backup_piece_details        is_recovery_dest_file
$backup_copy_details         is_recovery_dest_file
