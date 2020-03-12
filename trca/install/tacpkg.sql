SET ECHO ON TERM OFF FEED OFF VER OFF;
SPOOL 04_tacpkg.log;
REM $Header: 224270.1 tacpkg.sql 11.4.5.2 2012/12/12 carlos.sierra $
REM
REM Copyright (c) 2000-2013, Oracle Corporation. All rights reserved.
REM
REM AUTHOR
REM   carlos.sierra@oracle.com
REM
REM SCRIPT
REM   tacpkg.sql
REM
REM DESCRIPTION
REM   This script creates the packages owned by schema TRCADMIN
REM
REM PRE-REQUISITES
REM   1. This script must be executed connected INTERNAL (SYS) as
REM      SYSDBA
REM
REM PARAMETERS
REM   1. None
REM
REM EXECUTION
REM   1. Navigate to trca/install directory
REM   2. Start SQL*Plus connecting as SYS
REM   3. Execute script tacpkg.sql
REM
REM EXAMPLE
REM   # cd trca/install
REM   # sqlplus / as sysdba
REM   SQL> start tacpkg.sql
REM
REM NOTES
REM   1. This script is executed automatically by tacreate.sql
REM   2. For possible errors see tacpkg.log file
REM
WHENEVER SQLERROR CONTINUE;
ALTER SESSION SET PLSQL_CODE_TYPE = INTERPRETED;
WHENEVER SQLERROR EXIT SQL.SQLCODE;
SET ECHO OFF TERM ON;
ALTER SESSION SET NLS_NUMERIC_CHARACTERS = ".,";
ALTER SESSION SET NLS_LENGTH_SEMANTICS = CHAR;
DECLARE
  rdbms_release NUMBER;
BEGIN
  IF USER <> 'SYS' THEN
    RAISE_APPLICATION_ERROR(-20100, 'Install failed - objects should be created connected as SYS, not as '||USER);
  END IF;
  SELECT TO_NUMBER(SUBSTR(version, 1, INSTR(version, '.', 1, 2) - 1))
    INTO rdbms_release
    FROM v$instance;
  IF rdbms_release < 9.2 THEN
    RAISE_APPLICATION_ERROR(-20200, 'Install failed - should be installed in 9i(9.2) or higher, not in '||rdbms_release);
  END IF;
END;
/

SET TERM ON;
PRO tool_repository_schema: "&&tool_repository_schema."
PRO tool_administer_schema: "&&tool_administer_schema."
PRO role_name: "&&role_name."
--
SET TERM ON;
PRO Creating Package Specs TRCA$G
SET TERM OFF;
@@tacpkgg.pks
--
SET TERM ON;
PRO Creating Package Specs TRCA$P
SET TERM OFF;
@@tacpkgp.pks
--
SET TERM ON;
PRO Creating Package Specs TRCA$T
SET TERM OFF;
@@tacpkgt.pks
--
SET TERM ON;
PRO Creating Package Specs TRCA$I
SET TERM OFF;
@@tacpkgi.pks
--
SET TERM ON;
PRO Creating Package Specs TRCA$E
SET TERM OFF;
@@tacpkge.pks
--
SET TERM ON;
PRO Creating Package Specs TRCA$R
SET TERM OFF;
@@tacpkgr.pks
--
SET TERM ON;
PRO Creating Package Specs TRCA$X
SET TERM OFF;
@@tacpkgx.pks
--
SET TERM ON;
PRO Creating Views
SET TERM OFF;
WHENEVER SQLERROR CONTINUE;
@@tacvw.sql
WHENEVER SQLERROR EXIT SQL.SQLCODE;
--
SET TERM ON;
PRO Creating Package Body TRCA$G
SET TERM OFF;
@@tacpkgg.pkb
--
SET TERM ON;
PRO Creating Package Body TRCA$P
SET TERM OFF;
@@tacpkgp.pkb
--
SET TERM ON;
PRO Creating Package Body TRCA$T
SET TERM OFF;
@@tacpkgt.pkb
--
SET TERM ON;
PRO Creating Package Body TRCA$I
SET TERM OFF;
@@tacpkgi.pkb
--
SET TERM ON;
PRO Creating Package Body TRCA$E
SET TERM OFF;
@@tacpkge.pkb
--
SET TERM ON;
PRO Creating Package Body TRCA$R
SET TERM OFF;
@@tacpkgr.pkb
--
SET TERM ON;
PRO Creating Package Body TRCA$X
SET TERM OFF;
@@tacpkgx.pkb
--
SET TERM ON;
PRO Creating Grants on Packages
SET TERM OFF;
--
GRANT EXECUTE ON &&tool_administer_schema..trca$e TO &&role_name.;
GRANT EXECUTE ON &&tool_administer_schema..trca$g TO &&role_name.;
GRANT EXECUTE ON &&tool_administer_schema..trca$i TO &&role_name.;
GRANT EXECUTE ON &&tool_administer_schema..trca$p TO &&role_name.;
GRANT EXECUTE ON &&tool_administer_schema..trca$r TO &&role_name.;
GRANT EXECUTE ON &&tool_administer_schema..trca$t TO &&role_name.;
GRANT EXECUTE ON &&tool_administer_schema..trca$x TO &&role_name.;
--
-- needed to allow call of apis as legacy trcanlzr.trca$% as well as new syntax trcadmin.trca$%
CREATE OR REPLACE SYNONYM &&tool_repository_schema..trca$e FOR &&tool_administer_schema..trca$e;
CREATE OR REPLACE SYNONYM &&tool_repository_schema..trca$g FOR &&tool_administer_schema..trca$g;
CREATE OR REPLACE SYNONYM &&tool_repository_schema..trca$i FOR &&tool_administer_schema..trca$i;
CREATE OR REPLACE SYNONYM &&tool_repository_schema..trca$p FOR &&tool_administer_schema..trca$p;
CREATE OR REPLACE SYNONYM &&tool_repository_schema..trca$r FOR &&tool_administer_schema..trca$r;
CREATE OR REPLACE SYNONYM &&tool_repository_schema..trca$t FOR &&tool_administer_schema..trca$t;
CREATE OR REPLACE SYNONYM &&tool_repository_schema..trca$x FOR &&tool_administer_schema..trca$x;
--
SET HEA ON LIN 2000 PAGES 1000 TRIMS ON TIM OFF SERVEROUT ON SIZE 1000000;
SHOW PARAMETERS NLS;
EXEC &&tool_administer_schema..trca$p.set_nls;
EXEC &&tool_administer_schema..trca$g.general_initialization;

SET TERM ON;
COL tool_version FOR A16 HEA 'Tool Version';
SELECT &&tool_administer_schema..trca$g.get_param('tool_version', 'I') tool_version FROM DUAL;
COL install_date FOR A16 HEA 'Install Date';
SELECT &&tool_administer_schema..trca$g.get_param('install_date', 'I') install_date FROM DUAL;
COL column_value FOR A128 HEA 'Directories';
SELECT column_value FROM TABLE(&&tool_administer_schema..trca$g.directories);
COL column_value FOR A128 HEA 'Libraries';
SELECT column_value FROM TABLE(&&tool_administer_schema..trca$g.packages);
WHENEVER SQLERROR CONTINUE;
SET FEED 6;
PRO TACPKG completed.
--SPOOL OFF;
