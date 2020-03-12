REM $Header: tacommon1.sql 11.4.5.0 2012/11/21 carlos.sierra $
-- begin common
SELECT USER FROM DUAL;
SELECT TO_CHAR(SYSDATE, 'YYYY-MM-DD HH24:MI:SS') current_time FROM DUAL;
SELECT * FROM v$version;
SELECT * FROM v$instance;
SELECT name, value FROM v$parameter2 WHERE name LIKE '%dump_dest';
SELECT directory_name||' '||directory_path directories FROM sys.dba_directories WHERE directory_name LIKE 'SQLT$%' OR directory_name LIKE 'TRCA$%' ORDER BY 1;

DEF _SQLPLUS_RELEASE

DEF tool_repository_schema = 'TRCANLZR';
DEF tool_administer_schema = 'TRCADMIN';
DEF role_name              = 'TRCA_USER_ROLE';
-- end common
