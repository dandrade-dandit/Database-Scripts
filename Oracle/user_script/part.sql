REM     ORACLE - Licence Management Services
REM              Partitioning Usage Script
REM
REM     Change History
REM     Date:     Rev:   Author:                Description:
REM	2/25/02   1.0    jmielke                Original Script     
REM
REM     Partition.sql
REM       This script check to see if partitioning is installed and also if it is 
REM       being used.

CLEAR SCREEN
col parameter format a40
col value format a30
prompt
prompt <<<Enter the SYS password below>>>
prompt
connect SYS
PROMPT
ACCEPT 1 prompt 'Enter the path and filename for the output log (c:\part.log) : '
SPOOL &1

SET HEADING OFF
SET FEEDBACK off

SELECT 'Database Name: '||name from v$database;

SELECT 'ORACLE PARTITIONING INSTALLED: '||value from v$option where
parameter='Partitioning';

set feedback on
SET HEADING ON

SELECT OWNER, TABLE_NAME, PARTITIONED
FROM DBA_TABLES
WHERE PARTITIONED='YES';

PROMPT IF NO ROWS ARE RETURNED, THEN PARTITIONING IS NOT BEING USED.
PROMPT
PROMPT IF ROWS ARE RETURNED, THEN PARTITIONING IS BEING USED.
PROMPT

SPOOL OFF
undefine 1



