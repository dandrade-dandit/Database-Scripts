
connect internal/oracle

define ORACLE_HOME = &1
define ORACLE_SID  = &2

set echo on

spool CreateDBFiles.log


CREATE TABLESPACE DRSYS
  LOGGING
  DATAFILE 'C:\oracle\oradata\&ORACLE_SID\drsys01.dbf' SIZE 50M
  REUSE
  AUTOEXTEND ON
  NEXT       10M
  MAXSIZE    250M
  EXTENT MANAGEMENT LOCAL AUTOALLOCATE
/


CREATE TABLESPACE USERS
  LOGGING
  DATAFILE 'C:\oracle\oradata\&ORACLE_SID\users01.dbf' SIZE 25M
  REUSE
  AUTOEXTEND ON
  NEXT       10M
  MAXSIZE    250M
  EXTENT MANAGEMENT LOCAL AUTOALLOCATE
/

spool off

exit;