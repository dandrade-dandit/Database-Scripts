SET ECHO ON TERM OFF FEED OFF;
SPOOL 01_tacreate.log;
REM $Header: 224270.1 tacreate.sql 11.4.5.2 2012/12/12 carlos.sierra $
REM
REM Copyright (c) 2000-2013, Oracle Corporation. All rights reserved.
REM
REM AUTHOR
REM   carlos.sierra@oracle.com
REM
REM SCRIPT
REM   tacreate.sql
REM
REM DESCRIPTION
REM   This script installs the TRCANLZR tool into its own schema.
REM
REM PRE-REQUISITES
REM   1. To install SQLT you must connect as SYSDBA.
REM
REM PARAMETERS
REM   1. TRCANLZR password - Required and it has no default
REM   2. TRCANLZR default tablespace - You will be presented
REM      with a list, then you will have to enter one tablespace
REM      name from that list
REM   3. TRCANLZR temporary tablespace - Similar as above
REM   4. Main application user of TRCA (optional).
REM      This is the user name that will later execute TRCA.
REM      You can add aditional TRCA users by granting them
REM      role TRCA_USER_ROLE after the tool is installed.
REM   5. Type of object for large staging tables - Enter "T" is
REM      you want large tables to be created as PERMANENT, or
REM      "N" if you prefer GLOBAL TEMPORARY (recommended)
REM
REM EXECUTION
REM   1. Navigate to trca/install directory
REM   2. Start SQL*Plus connect as SYSDBA
REM   3. Execute script tacreate.sql
REM
REM EXAMPLE
REM   # cd trca/install
REM   # sqlplus / as sysdba
REM   SQL> START tacreate.sql
REM
REM NOTES
REM   1. For possible errors see *.log files
REM   2. If you want to make all TRCANLZR staging tables permanent,
REM      answer Y when asked for "large_tables_as_permanent".
REM
@@tacommon1.sql
SET ECHO OFF TERM ON;
WHENEVER SQLERROR EXIT SQL.SQLCODE;
ALTER SESSION SET NLS_NUMERIC_CHARACTERS = ".,";
DECLARE
  rdbms_release NUMBER;
BEGIN
  IF USER <> 'SYS' THEN
    RAISE_APPLICATION_ERROR(-20100, 'Install failed - TRCANLZR should be installed connected as SYS, not as '||USER);
  END IF;
  SELECT TO_NUMBER(SUBSTR(version, 1, INSTR(version, '.', 1, 2) - 1))
    INTO rdbms_release
    FROM v$instance;
  IF rdbms_release < 9.2 THEN
    RAISE_APPLICATION_ERROR(-20200, 'Install failed - TRCANLZR should be installed in 9i(9.2) or higher, not in '||rdbms_release);
  END IF;
END;
/
WHENEVER SQLERROR CONTINUE;

-- drops TRCA objects owned by TRCANLZR
@@tadrop.sql
SPOOL OFF;
-- creates or recreates user TRCANLZR
@@tacusr.sql
-- create SQLT and TRCA directories
@@tasqdirset.sql
-- verifies that TRCANLZR can actually read and write files (1st pass)
@@tautltest.sql
-- creates TRCA schema objects owned by TRCANLZR
@@tacobj.sql
-- creates TRCA set of packages owned by TRCANLZR
@@tacpkg.sql
-- verifies that TRCANLZR can actually read and write files (2nd pass)
@@tautltest.sql
SET TERM ON;
PRO
PRO TRCA users must be granted &&role_name. before using this tool.
UNDEFINE tool_repository_schema tool_administer_schema role_name
PRO
PRO TACREATE completed. Installation completed successfully.
