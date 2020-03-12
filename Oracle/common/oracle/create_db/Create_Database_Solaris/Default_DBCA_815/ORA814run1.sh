#!/bin/sh
ORACLE_SID=ORA814
export ORACLE_SID

/u01/app/oracle/product/8.1.5/bin/svrmgrl << EOF
spool /u01/app/oracle/product/8.1.5/install/crdb2.log
connect internal
@/u01/app/oracle/product/8.1.5/rdbms/admin/catalog.sql;
CREATE ROLLBACK SEGMENT r0 TABLESPACE SYSTEM
STORAGE (INITIAL 16K NEXT 16K MINEXTENTS 2 MAXEXTENTS 20);
ALTER ROLLBACK SEGMENT r0 ONLINE;

REM ************ TABLESPACE FOR OEM_REPOSITORY ***************
CREATE TABLESPACE OEM_REPOSITORY DATAFILE '/u10/oradata/ORA814/oemrep01.dbf' SIZE 5M REUSE 
AUTOEXTEND ON NEXT 25M MAXSIZE 80M
MINIMUM EXTENT 128K
DEFAULT STORAGE ( INITIAL 128K NEXT 128K MINEXTENTS 1
 MAXEXTENTS UNLIMITED PCTINCREASE 0);

REM ************** TABLESPACE FOR ROLLBACK *****************
CREATE TABLESPACE RBS DATAFILE '/u10/oradata/ORA814/rbs01.dbf' SIZE 12M REUSE 
DEFAULT STORAGE ( INITIAL 128K NEXT 128K MINEXTENTS 2 MAXEXTENTS UNLIMITED  PCTINCREASE 0);
ALTER DATABASE DATAFILE '/u10/oradata/ORA814/rbs01.dbf' AUTOEXTEND ON;

REM ************** TABLESPACE FOR TEMPORARY *****************
CREATE TABLESPACE TEMP DATAFILE '/u10/oradata/ORA814/temp01.dbf' SIZE 10M REUSE 
DEFAULT STORAGE ( INITIAL 256K NEXT 256K MINEXTENTS 1 MAXEXTENTS UNLIMITED PCTINCREASE 0) TEMPORARY;
ALTER DATABASE DATAFILE '/u10/oradata/ORA814/temp01.dbf' AUTOEXTEND ON;

REM ************** TABLESPACE FOR USER *********************
CREATE TABLESPACE USERS DATAFILE '/u10/oradata/ORA814/users01.dbf' SIZE 10M REUSE 
DEFAULT STORAGE ( INITIAL 50K NEXT 50K MINEXTENTS 1 MAXEXTENTS UNLIMITED PCTINCREASE 0);
ALTER DATABASE DATAFILE '/u10/oradata/ORA814/users01.dbf' AUTOEXTEND ON;

REM ************** TABLESPACE FOR INDEX *********************
CREATE TABLESPACE INDX DATAFILE '/u10/oradata/ORA814/indx01.dbf' SIZE 10M REUSE 
DEFAULT STORAGE ( INITIAL 50K NEXT 50K MINEXTENTS 1 MAXEXTENTS UNLIMITED PCTINCREASE 0);
ALTER DATABASE DATAFILE '/u10/oradata/ORA814/indx01.dbf' AUTOEXTEND ON;

REM **** Creating four rollback segments ****************
CREATE ROLLBACK SEGMENT r01 TABLESPACE RBS;
CREATE ROLLBACK SEGMENT r02 TABLESPACE RBS;
CREATE ROLLBACK SEGMENT r03 TABLESPACE RBS;
CREATE ROLLBACK SEGMENT r04 TABLESPACE RBS;
ALTER ROLLBACK SEGMENT r01 ONLINE;
ALTER ROLLBACK SEGMENT r02 ONLINE;
ALTER ROLLBACK SEGMENT r03 ONLINE;
ALTER ROLLBACK SEGMENT r04 ONLINE;
ALTER ROLLBACK SEGMENT r0 OFFLINE;
DROP ROLLBACK SEGMENT r0;

REM **** SYS and SYSTEM users ****************
alter user sys temporary tablespace TEMP;
alter user system temporary tablespace TEMP;
disconnect
spool off
exit


EOF