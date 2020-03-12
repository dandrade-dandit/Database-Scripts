ORADIM -NEW -SID Ora9i -INTPWD denis -STARTMODE MANUAL -PFILE D:\oracle\admin\Ora9i\pfile\INIT.ORA  


create database ora9i
  maxlogfiles 32
  maxlogmembers 5
  maxdatafiles 100
  maxloghistory 100
CHARACTER SET AL32UTF8
NATIONAL CHARACTER SET AL16UTF16
logfile
   group 1 ('D:\oracle\oradata\Ora9i\redolog1a.rdo', 'D:\oracle\oradata\Ora9i\redolog1b.rdo') size 10m,
   group 2 ('D:\oracle\oradata\Ora9i\redolog2a.rdo', 'D:\oracle\oradata\Ora9i\redolog2b.rdo') size 10m
datafile
   'D:\oracle\oradata\Ora9i\system01.dbf' size 300m
DEFAULT TEMPORARY TABLESPACE temp_ts
UNDO TABLESPACE undo_ts ;


startup nomount pfile=D:\oracle\admin\Ora9i\pfile\INIT.ORA


CREATE DATABASE ora9i
   CONTROLFILE REUSE 
   LOGFILE
      GROUP 1 ('D:\oracle\oradata\Ora9i\redolog1a.rdo', 'D:\oracle\oradata\Ora9i\redolog1b.rdo') size 10m, 
      GROUP 2 ('D:\oracle\oradata\Ora9i\redolog2a.rdo', 'D:\oracle\oradata\Ora9i\redolog2b.rdo') size 10m
   MAXLOGFILES 5 
   MAXLOGHISTORY 100 
   MAXDATAFILES 10 
   MAXINSTANCES 2 
   ARCHIVELOG 
   CHARACTER SET AL32UTF8
   NATIONAL CHARACTER SET AL16UTF16
   DATAFILE  
      'D:\oracle\oradata\Ora9i\system01.dbf' size 300M
   UNDO TABLESPACE UNDOTBS1 DATAFILE 'D:\oracle\oradata\Ora9i\UNDOTBS1.dbf' size 100M;


CREATE TEMPORARY TABLESPACE temp
   TEMPFILE 'D:\oracle\oradata\Ora9i\temp01.dbf' SIZE 10M


@D:\oracle\ora92\rdbms\admin\catalog.sql
@D:\oracle\ora92\rdbms\admin\catproc.sql
