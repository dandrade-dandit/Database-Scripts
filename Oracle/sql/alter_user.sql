rem
rem Become user
rem Biju Thomas
rem 
set pages 0 lines 200 trims on feedback off verify off echo off 
spool /tmp/tmp.sql
select 'ALTER USER &&1 IDENTIFIED BY VALUES '
 ||''''||Password||''''||';'
  from DBA_USERS where Username = UPPER('&&1');
spool off
alter user &&1 identified by sneaking;
connect &&1/sneaking
@/tmp/tmp.sql
host rm /tmp/tmp.sql 
set pages 24 lines 80 feedback on

