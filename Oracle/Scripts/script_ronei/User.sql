CREATE USER &1 IDENTIFIED BY INFRAERO
DEFAULT TABLESPACE TS_PESSOAL
TEMPORARY TABLESPACE TEMP
/
select * from  dba_role_privs where grantee = '&1'
/
alter user &1 identified by infraero
/
