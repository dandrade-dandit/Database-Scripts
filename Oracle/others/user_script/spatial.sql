REM     ORACLE - Licence Management Services
REM              Database Option Detection - Spatial
REM
REM     Change History
REM     Date:     Rev:   Author:                Description:
REM     3/14/02   1.0    John.Mielke            Original script 
REM
REM     REPORT_5.SQL
REM       This script verifies if spatial is installed and being used.
REM
REM

clear screen
prompt
prompt <<<Enter the SYS password below>>>
prompt
connect SYS
PROMPT
ACCEPT 1 prompt 'Enter the path and filename for the output log (c:\spatial.log) : '
SPOOL &1
set termout off
set heading off
SELECT 'Database Name: '||name from v$database;
set heading on
set pages 1000
col object_name format a31
col object_type format a20

PROMPT  Get total count of Objects
PROMPT This should be 187 Objects
select count(*)
from dba_objects where owner='MDSYS';

PROMPT Get a summary count
select object_type, count(*)
from dba_objects where owner='MDSYS' 
group by object_type;

PROMPT Any invalid objects ?
select object_name, object_type, status
from dba_objects 
where owner='MDSYS' 
and status <> 'VALID'
order by object_name;

PROMPT List all spatial objects
select object_name, object_type, status 
from dba_objects where owner='MDSYS' 
order by object_name;

PROMPT List the privileges on all spatial objects
col grantor for a10
col grantee for a10
col privilege for a10
select grantor, grantee, table_name, privilege, grantable 
from all_tab_privs 
where table_schema = 'MDSYS'
order by table_name, privilege; 

PROMPT List the system privileges owned by MDSYS
col privilege for a30
select privilege, admin_option
from user_sys_privs
order by privilege;  

spool off
set termout on


