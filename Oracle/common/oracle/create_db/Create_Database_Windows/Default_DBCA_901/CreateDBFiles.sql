connect SYS/change_on_install as SYSDBA
set echo on
spool C:\oracle\RDBMS901\assistants\dbca\logs\CreateDBFiles.log
CREATE TABLESPACE "CWMLITE" LOGGING DATAFILE 'C:\oracle\RDBMS901\ALEXDB\cwmlite01.dbf' SIZE 20480K REUSE AUTOEXTEND ON NEXT  640K MAXSIZE UNLIMITED EXTENT MANAGEMENT LOCAL;
CREATE TABLESPACE "DRSYS" LOGGING DATAFILE 'C:\oracle\RDBMS901\ALEXDB\drsys01.dbf' SIZE 20480K REUSE AUTOEXTEND ON NEXT  640K MAXSIZE UNLIMITED EXTENT MANAGEMENT LOCAL;
CREATE TABLESPACE "EXAMPLE" LOGGING DATAFILE 'C:\oracle\RDBMS901\ALEXDB\example01.dbf' SIZE 10240K REUSE AUTOEXTEND ON NEXT  640K MAXSIZE UNLIMITED EXTENT MANAGEMENT LOCAL;
CREATE TABLESPACE "INDX" LOGGING DATAFILE 'C:\oracle\RDBMS901\ALEXDB\indx01.dbf' SIZE 25M REUSE AUTOEXTEND ON NEXT  1280K MAXSIZE UNLIMITED EXTENT MANAGEMENT LOCAL;
CREATE TEMPORARY TABLESPACE "TEMP" TEMPFILE 'C:\oracle\RDBMS901\ALEXDB\temp01.dbf' SIZE 40M REUSE AUTOEXTEND ON NEXT  640K MAXSIZE UNLIMITED EXTENT MANAGEMENT LOCAL;
ALTER DATABASE DEFAULT TEMPORARY TABLESPACE "TEMP";
CREATE TABLESPACE "TOOLS" LOGGING DATAFILE 'C:\oracle\RDBMS901\ALEXDB\tools01.dbf' SIZE 10M REUSE AUTOEXTEND ON NEXT  320K MAXSIZE UNLIMITED EXTENT MANAGEMENT LOCAL;
CREATE TABLESPACE "USERS" LOGGING DATAFILE 'C:\oracle\RDBMS901\ALEXDB\users01.dbf' SIZE 25M REUSE AUTOEXTEND ON NEXT  1280K MAXSIZE UNLIMITED EXTENT MANAGEMENT LOCAL;
spool off
exit;