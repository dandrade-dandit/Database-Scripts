@echo off
REM +--------------------------------------------------------------------------+
REM |                          Jeffrey M. Hunter                               |
REM |                      jhunter@idevelopment.info                           |
REM |                         www.idevelopment.info                            |
REM |--------------------------------------------------------------------------|
REM |    Copyright (c) 1998-2010 Jeffrey M. Hunter. All rights reserved.       |
REM |--------------------------------------------------------------------------|
REM | FILE       : dpump_backup_online_full.bat                                |
REM | CLASS      : WINDOWS Shell Scripts                                       |
REM | PURPOSE    : Used to perform a logical backup of an Oracle database      |
REM |              using the Data Pump utility. Note that Data Pump was first  |
REM |              introduced in Oracle 10g which means this script will only  |
REM |              work with Oracle Database 10g or higher. By default, this   |
REM |              script performs a full and consistent backup of the         |
REM |              database using a dynamically created parameter file that    |
REM |              gets written to a temporary directory and run through       |
REM |              Oracle Data Pump using the "parfile" parameter.             |
REM |                                                                          |
REM |              -------------                                               |
REM |              IMPORTANT !!!                                               |
REM |              -------------                                               |
REM |              Please note that this script makes use of the command       |
REM |              utility "forfiles.exe" to list and remove obsolete Oracle   |
REM |              Data Pump export dump files and log files. Some Microsoft   |
REM |              operating system environments do not include this utility   |
REM |              by default (i.e. Windows XP). A copy of "forfiles.exe" can  |
REM |              be downloaded from:                                         |
REM |                                                                          |
REM |         http://www.idevelopment.info/data/Supporting_Tools/forfiles.exe  |
REM |                                                                          |
REM |              ------------------                                          |
REM |              EMAIL CAPABILITIES                                          |
REM |              ------------------                                          |
REM |              This script makes use of the BLAT command line utility to   |
REM |              send the resulting log file to administrators. For more     |
REM |              information on configuring BLAT to send email from scripts  |
REM |              in Windows, see the following article:                      |
REM |                                                                          |
REM |         http://www.idevelopment.info/data/Oracle/DBA_tips/Microsoft_Windows/WINDOWS_5.shtml
REM |                                                                          |
REM |              --------------------------------------------                |
REM |              NEW DATA PUMP UTILITY IN ORACLE DATABASE 10g                |
REM |              --------------------------------------------                |
REM |              Oracle Database 10g users (and higher) should consider      |
REM |              using the new Data Pump utility in place of the original    |
REM |              Oracle import/export. The original export utility was       |
REM |              deprecated in Oracle Database 10g Release 2, and is no      |
REM |              longer supported for general use as of Oracle Database 11g. |
REM |              Going forward, Data Pump export (expdp) will be the sole    |
REM |              supported means of exporting data from the database. The    |
REM |              original import utility (imp) still ships with Oracle       |
REM |              Database 10g and Oracle Database 11g in order to support    |
REM |              import of legacy dump files. The original import utility    |
REM |              will be supported forever and will provide the means to     |
REM |              import dump files from earlier releases (release 5.0 and    |
REM |              later) that were created with the original export (exp).    |
REM |              Please note that the original export dump files and the new |
REM |              Data Pump dump files are "not" compatible. You cannot read  |
REM |              an original Oracle export dump file with Data Pump and vice |
REM |              versa. Neither client can read dump files created by the    |
REM |              other.                                                      |
REM |                                                                          |
REM |              --------------------------------------------                |
REM |              KNOWN ISSUES                                                |
REM |              --------------------------------------------                |
REM |              -> Oracle Database 10g users (version 10.1.0.0 to 10.2.0.4) |
REM |                 may experience the following error when attempting to    |
REM |                 export XML Schemas or XML Schema-based columns:          |
REM |                                                                          |
REM |                 ORA-39139: Data Pump does not support XMLSchema objects  |
REM |                                                                          |
REM |                 As documented in Oracle Note: 443373.1, Data Pump does   |
REM |                 not support exporting XML Schemas or XML Schema-based    |
REM |                 columns. The only workaround documented for this issue   |
REM |                 is to use the original export and import utilities for   |
REM |                 the XML objects.                                         |
REM |                                                                          |
REM |              -> Export fails with the following                          |
REM |                 "insufficient privileges" errors:                        |
REM |                                                                          |
REM |                 Processing object type DATABASE_EXPORT/SCHEMA/TABLE/STATISTICS/TABLE_STATISTICS
REM |                 ORA-39127: unexpected error from call to local_str := <...>
REM |                 ORA-01031: insufficient privileges                       |
REM |                 ORA-06512: at "SYS.DBMS_EXPORT_EXTENSION", line 257      |
REM |                 ORA-06512: at line 1                                     |
REM |                 ORA-06512: at "SYS.DBMS_METADATA", line 4770             |
REM |                 ORA-39127: unexpected error from call to local_str := <...>
REM |                 ORA-01031: insufficient privileges                       |
REM |                 ORA-06512: at "SYS.DBMS_EXPORT_EXTENSION", line 257      |
REM |                 ORA-06512: at line 1                                     |
REM |                 ORA-06512: at "SYS.DBMS_METADATA", line 4770             |
REM |                 Processing object type DATABASE_EXPORT/SCHEMA/TABLE/INDEX/DOMAIN_INDEX/INDEX
REM |                                                                          |
REM |                 This occurs because the user account performing the      |
REM |                 export lacks the "SELECT ANY TABLE" privilege. Grant the |
REM |                 "SELECT ANY TABLE" privilege to the user performing the  |
REM |                 export.                                                  |
REM |                                                                          |
REM | PARAMETERS : DBA_USERNAME       Database username Data Pump will use to  |
REM |                                 login to the database. This user must be |
REM |                                 a DBA, or must have the                  |
REM |                                 EXP_FULL_DATABASE or IMP_FULL_DATABASE   |
REM |                                 roles in order to attach and control     |
REM |                                 Data Pump jobs of other users. The user  |
REM |                                 running Data Pump must have sufficient   |
REM |                                 tablespace quota to create the master    |
REM |                                 table. A common username for performing  |
REM |                                 Oracle backups is BACKUP_ADMIN.          |
REM |                                                                          |
REM |              DBA_PASSWORD       Database password Data Pump will use to  |
REM |                                 login to the database.                   |
REM |                                                                          |
REM |              TNS_ALIAS          TNS connect string to the target         |
REM |                                 database.                                |
REM |                                                                          |
REM |              DPUMP_DUMP_DIR     Oracle "Directory Name" used by Data     |
REM |                                 Pump to write the dump file(s) to on the |
REM |                                 database server. Note that this          |
REM |                                 parameter should not be set to the       |
REM |                                 "absolute file path" on the database     |
REM |                                 server but however an Oracle Directory   |
REM |                                 Name. Directory names are actual named   |
REM |                                 objects in Oracle that Data Pump uses to |
REM |                                 map to a specific operating system       |
REM |                                 directory. For example:                  |
REM |                                                                          |
REM |                                   CREATE OR REPLACE DIRECTORY            |
REM |                                   dpump_dump_dir AS                      |
REM |                                   'C:\oracle\oradpump\orcl';             |
REM |                                                                          |
REM |                                 Creating an Oracle directory object      |
REM |                                 requires that the user have the DBA role |
REM |                                 or have the CREATE ANY DIRECTORY system  |
REM |                                 privilege. Also verify that the Oracle   |
REM |                                 user performing the logical backup       |
REM |                                 (DBA_USERNAME) has write privileges to   |
REM |                                 the directory object:                    |
REM |                                                                          |
REM |                                   GRANT read, write ON DIRECTORY         |
REM |                                   dpump_dump_dir TO BACKUP_ADMIN;        |
REM |                                                                          |
REM |              DPUMP_LOG_DIR      Oracle "Directory Name" used by Data     |
REM |                                 Pump to write the log file to on the     |
REM |                                 database server. As with the             |
REM |                                 DPUMP_DUMP_DIR parameter (above), this   |
REM |                                 parameter should not be set to the       |
REM |                                 "absolute file path" on the database     |
REM |                                 server but however an Oracle Directory   |
REM |                                 Name. For example:                       |
REM |                                                                          |
REM |                                   CREATE OR REPLACE DIRECTORY            |
REM |                                   dpump_log_dir AS                       |
REM |                                   'C:\oracle\custom\oracle\log';         |
REM |                                                                          |
REM |                                 Verify that the Oracle user performing   |
REM |                                 the logical backup (DBA_USERNAME) has    |
REM |                                 write privileges to the directory        |
REM |                                 object:                                  |
REM |                                                                          |
REM |                                   GRANT read, write ON DIRECTORY         |
REM |                                   dpump_log_dir TO BACKUP_ADMIN;         |
REM |                                                                          |
REM |              NUM_DAYS_TO_KEEP   Number of days worth of Data Pump dump   |
REM |                                 files to retain on the file system.      |
REM |                                                                          |
REM | EXAMPLE RUN:                                                             |
REM |     dpump_backup_online_full.ksh backup_admin backup_admin orcl dpump_dump_dir dpump_log_dir 2
REM |                                                                          |
REM | NOTE       : As with any code, ensure to test this script in a           |
REM |              development environment before attempting to run it in      |
REM |              production.                                                 |
REM +--------------------------------------------------------------------------+

REM +--------------------------------------------------------------------------+
REM | SCRIPT NAME VARIABLES                                                    |
REM +--------------------------------------------------------------------------+

set SCRIPT_NAME_NOEXT=dpump_backup_online_full
set SCRIPT_NAME_FULL=%SCRIPT_NAME_NOEXT%.bat
set SCRIPT_VERSION=1.3

REM +--------------------------------------------------------------------------+
REM | EMAIL VARIABLES                                                          |
REM +--------------------------------------------------------------------------+

set SMTP_SERVER=localhost
set SMTP_PORT=25
set SMTP_EMAIL_TO=jhunter@idevelopment.info
set SMTP_EMAIL_FROM=dba@idevelopment.info

REM +--------------------------------------------------------------------------+
REM | SET START DATE AND TIME ENVIRONMENT VARIABLES                            |
REM +--------------------------------------------------------------------------+

set START_DATE=%DATE%
set START_TIME=%TIME%

REM +--------------------------------------------------------------------------+
REM | SHOW SIGNON BANNER                                                       |
REM +--------------------------------------------------------------------------+

echo.
echo %SCRIPT_NAME_FULL% - Version %SCRIPT_VERSION%
echo Copyright (c) 1998-2010 Jeffrey M. Hunter. All rights reserved.
echo.

REM +--------------------------------------------------------------------------+
REM | VALIDATE COMMAND-LINE PARAMETERS                                         |
REM +--------------------------------------------------------------------------+

if (%1)==() goto USAGE
if (%2)==() goto USAGE
if (%3)==() goto USAGE
if (%4)==() goto USAGE
if (%5)==() goto USAGE
if (%6)==() goto USAGE

REM +--------------------------------------------------------------------------+
REM | SET DATE AND TIME ENVIRONMENT VARIABLES FOR FILES                        |
REM +--------------------------------------------------------------------------+

SETLOCAL

FOR /f "tokens=2-4 skip=1 delims=(-)" %%G IN ('echo.^|date') DO (
    FOR /f "tokens=2 delims= " %%A IN ('date /t') DO (
        SET v_first=%%G
        SET v_second=%%H
        SET v_third=%%I
        SET v_all=%%A
    )
)

SET %v_first%=%v_all:~0,2%
SET %v_second%=%v_all:~3,2%
SET %v_third%=%v_all:~6,4%

ENDLOCAL & SET v_year=%yy%& SET v_month=%mm%& SET v_day=%dd%

SET FILEDATE=%v_year%%v_month%%v_day%

SETLOCAL
FOR /f "tokens=*" %%G IN ('time /t') DO set v_time=%%G
    SET v_time=%v_time:~0,2%%v_time:~3,2%%v_time:~6,2%
ENDLOCAL & SET v_time=%v_time%
   
SET v

SET FILETIME=%v_time%

REM +--------------------------------------------------------------------------+
REM | CUSTOM DIRECTORIES                                                       |
REM +--------------------------------------------------------------------------+

set CUSTOM_ORACLE_DIR=C:\oracle\custom\oracle
set CUSTOM_ORACLE_BIN_DIR=%CUSTOM_ORACLE_DIR%\bin
set CUSTOM_ORACLE_LIB_DIR=%CUSTOM_ORACLE_DIR%\lib
set CUSTOM_ORACLE_LOG_DIR=%CUSTOM_ORACLE_DIR%\log
set CUSTOM_ORACLE_OUT_DIR=%CUSTOM_ORACLE_DIR%\out
set CUSTOM_ORACLE_SQL_DIR=%CUSTOM_ORACLE_DIR%\sql
set CUSTOM_ORACLE_TEMP_DIR=%CUSTOM_ORACLE_DIR%\temp

REM +--------------------------------------------------------------------------+
REM | DECLARE GLOBAL VARIABLES                                                 |
REM +--------------------------------------------------------------------------+

set DBA_USERNAME=%1%
set DBA_PASSWORD=%2%
set TNS_ALIAS=%3%
set DPUMP_DUMP_DIR=%4%
set DPUMP_LOG_DIR=%5%
set NUM_DAYS_TO_KEEP=%6%

set ERRORS="NO"

set LOGDIR=%CUSTOM_ORACLE_LOG_DIR%
set LOGFILE=%LOGDIR%\%SCRIPT_NAME_NOEXT%_%TNS_ALIAS%_%FILEDATE%_%FILETIME%.log
set LOGFILE_COPY=%LOGDIR%\%SCRIPT_NAME_NOEXT%_%TNS_ALIAS%.log

set TEMPSQLFILE=%CUSTOM_ORACLE_TEMP_DIR%\%SCRIPT_NAME_NOEXT%_%TNS_ALIAS%.sql
set TEMPBATFILE=%CUSTOM_ORACLE_TEMP_DIR%\%SCRIPT_NAME_NOEXT%_%TNS_ALIAS%.bat

REM +--------------------------------------------------------------------------+
REM | HOSTNAME VARIABLES                                                       |
REM +--------------------------------------------------------------------------+

set HOSTNAME=%COMPUTERNAME%

REM +--------------------------------------------------------------------------+
REM | ORACLE ENVIRONMENT VARIABLES                                             |
REM +--------------------------------------------------------------------------+

set ORACLE_BASE=C:\oracle
set ORACLE_HOME=%ORACLE_BASE%\product\10.2.0\db_1
set ORACLE_SID=%TNS_ALIAS%
set ORACLE_ADMIN_DIR=%ORACLE_BASE%\admin


echo ======================================================
echo   - START TIME : %START_DATE% %START_TIME%
echo ======================================================


echo ====================================================== > "%LOGFILE%"
echo   - START TIME : %START_DATE% %START_TIME% >> "%LOGFILE%"
echo ====================================================== >> "%LOGFILE%"


echo. >> "%LOGFILE%"
echo ====================================================== >> "%LOGFILE%"
echo   -  VERIFY "DUMP" DIRECTORY OBJECT: %DPUMP_DUMP_DIR% >> "%LOGFILE%"
echo ====================================================== >> "%LOGFILE%"

echo set pagesize 0 feedback off verify off heading off trimspool on echo off > %TEMPSQLFILE%
echo SPOOL %TEMPBATFILE%  >> %TEMPSQLFILE%
echo SELECT 'SET DPUMP_DUMP_DIR_PATH='^|^| directory_path FROM dba_directories >> %TEMPSQLFILE%
echo WHERE UPPER(directory_name) = UPPER('%DPUMP_DUMP_DIR%'); >> %TEMPSQLFILE%
echo spool off  >> %TEMPSQLFILE%
echo exit; >> %TEMPSQLFILE%

%ORACLE_HOME%\bin\sqlplus -S "%DBA_USERNAME%/%DBA_PASSWORD%@%TNS_ALIAS% as sysdba" @%TEMPSQLFILE%

findstr /i "SET DPUMP_DUMP_DIR_PATH" "%TEMPBATFILE%" >> "%LOGFILE%"
IF errorlevel 1 (set FOUND="NO") ELSE (set FOUND="YES")

IF %FOUND%=="YES" (
    call %TEMPBATFILE%
) ELSE (
    goto ERROR_DPUMP_DUMP_DIR
)

echo. >> "%LOGFILE%"
echo Oracle Directory "%DPUMP_DUMP_DIR%" maps to "%DPUMP_DUMP_DIR_PATH%" >> "%LOGFILE%"


echo. >> "%LOGFILE%"
echo ====================================================== >> "%LOGFILE%"
echo   -  VERIFY "LOG" DIRECTORY OBJECT: %DPUMP_LOG_DIR% >> "%LOGFILE%"
echo ====================================================== >> "%LOGFILE%"

echo set pagesize 0 feedback off verify off heading off trimspool on echo off > %TEMPSQLFILE%
echo SPOOL %TEMPBATFILE%  >> %TEMPSQLFILE%
echo SELECT 'SET DPUMP_LOG_DIR_PATH='^|^| directory_path FROM dba_directories >> %TEMPSQLFILE%
echo WHERE UPPER(directory_name) = UPPER('%DPUMP_LOG_DIR%'); >> %TEMPSQLFILE%
echo spool off  >> %TEMPSQLFILE%
echo exit; >> %TEMPSQLFILE%

%ORACLE_HOME%\bin\sqlplus -S "%DBA_USERNAME%/%DBA_PASSWORD%@%TNS_ALIAS% as sysdba" @%TEMPSQLFILE%

findstr /i "SET DPUMP_LOG_DIR_PATH" "%TEMPBATFILE%" >> "%LOGFILE%"
IF errorlevel 1 (set FOUND="NO") ELSE (set FOUND="YES")

IF %FOUND%=="YES" (
    call %TEMPBATFILE%
) ELSE (
    goto ERROR_DPUMP_LOG_DIR
)

echo. >> "%LOGFILE%"
echo Oracle Directory "%DPUMP_LOG_DIR%" maps to "%DPUMP_LOG_DIR_PATH%" >> "%LOGFILE%"


echo. >> "%LOGFILE%"
echo ====================================================== >> "%LOGFILE%"
echo   -  SET DPUMP_FLASHBACK_TIME >> "%LOGFILE%"
echo ====================================================== >> "%LOGFILE%"

echo set pagesize 0 feedback off verify off heading off trimspool on echo off > %TEMPSQLFILE%
echo SPOOL %TEMPBATFILE%  >> %TEMPSQLFILE%
echo SELECT 'SET DPUMP_FLASHBACK_TIME='^|^| TO_CHAR(sysdate,'DD-MON-YYYY HH24:MM:SS') FROM dual; >> %TEMPSQLFILE%
echo SELECT 'SET DPUMP_FLASHBACK_SCN='^|^| DBMS_FLASHBACK.GET_SYSTEM_CHANGE_NUMBER FROM dual; >> %TEMPSQLFILE%
echo spool off  >> %TEMPSQLFILE%
echo exit; >> %TEMPSQLFILE%

%ORACLE_HOME%\bin\sqlplus -S "%DBA_USERNAME%/%DBA_PASSWORD%@%TNS_ALIAS% as sysdba" @%TEMPSQLFILE%

call %TEMPBATFILE%

echo. >> "%LOGFILE%"
echo Oracle Data Pump Flashback Time is "%DPUMP_FLASHBACK_TIME%" >> "%LOGFILE%"
echo Oracle Data Pump Flashback SCN is "%DPUMP_FLASHBACK_SCN%" >> "%LOGFILE%"


echo. >> "%LOGFILE%"
echo ====================================================== >> "%LOGFILE%"
echo   -  SET FURTHER ENVIRONMENT VARIABLES. >> "%LOGFILE%"
echo ====================================================== >> "%LOGFILE%"

set DPUMP_DATE_LOG=%FILEDATE%_%FILETIME%
set DPUMP_DUMP_FILE_NAME=%DPUMP_DUMP_DIR%:%SCRIPT_NAME_NOEXT%_%TNS_ALIAS%_%DPUMP_DATE_LOG%.dmp
set DPUMP_LOG_FILE_NAME=%DPUMP_LOG_DIR%:%SCRIPT_NAME_NOEXT%_%TNS_ALIAS%_%DPUMP_DATE_LOG%_DPUMPLOG.log
set DPUMP_LOG_FILE_LOCATION=%DPUMP_LOG_DIR_PATH%\%SCRIPT_NAME_NOEXT%_%TNS_ALIAS%_%DPUMP_DATE_LOG%_DPUMPLOG.log
set DPUMP_PARFILE_FILE_NAME=%CUSTOM_ORACLE_TEMP_DIR%\%SCRIPT_NAME_NOEXT%_%TNS_ALIAS%_%DPUMP_DATE_LOG%.parfile

echo. >> "%LOGFILE%"
echo Done. >> "%LOGFILE%"


REM +--------------------------------------------------------------------------+
REM | WRITE HEADER INFORMATION TO CONSOLE AND LOG FILE.                        |
REM +--------------------------------------------------------------------------+

echo.
echo ===================================================================================
echo                              COMMON SCRIPT VARIABLES
echo ===================================================================================
echo Script Name                        : %SCRIPT_NAME_FULL%
echo Script Version                     : %SCRIPT_VERSION%
echo Begin Date                         : %START_DATE%
echo Begin Time                         : %START_TIME%
echo Host Name                          : %HOSTNAME%
echo Log File Name                      : %LOGFILE%
echo Log File Name (Copy)               : %LOGFILE_COPY%
echo ===================================================================================
echo                              CUSTOM SCRIPT VARIABLES
echo ===================================================================================
echo DBA_USERNAME      (P1)             : %DBA_USERNAME%
echo DBA_PASSWORD      (P2)             : xxxxxxxxxxxxx
echo TNS_ALIAS         (P3)             : %TNS_ALIAS%
echo DPUMP_DUMP_DIR    (P4)             : %DPUMP_DUMP_DIR%
echo DPUMP_LOG_DIR     (P5)             : %DPUMP_LOG_DIR%
echo NUM_DAYS_TO_KEEP  (P6)             : %NUM_DAYS_TO_KEEP%
echo DPUMP_DUMP_FILE_NAME               : %DPUMP_DUMP_FILE_NAME%
echo DPUMP_DUMP_DIR_PATH                : %DPUMP_DUMP_DIR_PATH%
echo DPUMP_LOG_FILE_NAME                : %DPUMP_LOG_FILE_NAME%
echo DPUMP_LOG_DIR_PATH                 : %DPUMP_LOG_DIR_PATH%
echo DPUMP_LOG_FILE_LOCATION            : %DPUMP_LOG_FILE_LOCATION%
echo DPUMP_PARFILE_FILE_NAME            : %DPUMP_PARFILE_FILE_NAME%
echo DPUMP_FLASHBACK_TIME               : %DPUMP_FLASHBACK_TIME% - (Consistent Export)
echo DPUMP_FLASHBACK_SCN                : %DPUMP_FLASHBACK_SCN% - (Consistent Export)
echo.


echo. >> "%LOGFILE%"
echo =================================================================================== >> "%LOGFILE%"
echo                              COMMON SCRIPT VARIABLES >> "%LOGFILE%"
echo =================================================================================== >> "%LOGFILE%"
echo Script Name                        : %SCRIPT_NAME_FULL% >> "%LOGFILE%"
echo Script Version                     : %SCRIPT_VERSION% >> "%LOGFILE%"
echo Begin Date                         : %START_DATE% >> "%LOGFILE%"
echo Begin Time                         : %START_TIME% >> "%LOGFILE%"
echo Host Name                          : %HOSTNAME% >> "%LOGFILE%"
echo Log File Name                      : %LOGFILE% >> "%LOGFILE%"
echo Log File Name (Copy)               : %LOGFILE_COPY% >> "%LOGFILE%"
echo =================================================================================== >> "%LOGFILE%"
echo                              CUSTOM SCRIPT VARIABLES >> "%LOGFILE%"
echo =================================================================================== >> "%LOGFILE%"
echo DBA_USERNAME      (P1)             : %DBA_USERNAME% >> "%LOGFILE%"
echo DBA_PASSWORD      (P2)             : xxxxxxxxxxxxx >> "%LOGFILE%"
echo TNS_ALIAS         (P3)             : %TNS_ALIAS% >> "%LOGFILE%"
echo DPUMP_DUMP_DIR    (P4)             : %DPUMP_DUMP_DIR% >> "%LOGFILE%"
echo DPUMP_LOG_DIR     (P5)             : %DPUMP_LOG_DIR% >> "%LOGFILE%"
echo NUM_DAYS_TO_KEEP  (P6)             : %NUM_DAYS_TO_KEEP% >> "%LOGFILE%"
echo DPUMP_DUMP_FILE_NAME               : %DPUMP_DUMP_FILE_NAME% >> "%LOGFILE%"
echo DPUMP_DUMP_DIR_PATH                : %DPUMP_DUMP_DIR_PATH% >> "%LOGFILE%"
echo DPUMP_LOG_FILE_NAME                : %DPUMP_LOG_FILE_NAME% >> "%LOGFILE%"
echo DPUMP_LOG_DIR_PATH                 : %DPUMP_LOG_DIR_PATH% >> "%LOGFILE%"
echo DPUMP_LOG_FILE_LOCATION            : %DPUMP_LOG_FILE_LOCATION% >> "%LOGFILE%"
echo DPUMP_PARFILE_FILE_NAME            : %DPUMP_PARFILE_FILE_NAME% >> "%LOGFILE%"
echo DPUMP_FLASHBACK_TIME               : %DPUMP_FLASHBACK_TIME% - (Consistent Export) >> "%LOGFILE%"
echo DPUMP_FLASHBACK_SCN                : %DPUMP_FLASHBACK_SCN% - (Consistent Export) >> "%LOGFILE%"


echo. >> "%LOGFILE%"
echo ============================================================== >> "%LOGFILE%"
echo   - WRITE EXPORT PARAMETER FILE. >> "%LOGFILE%"
echo ============================================================== >> "%LOGFILE%"

echo USERID=%DBA_USERNAME%/%DBA_PASSWORD%@%TNS_ALIAS% > %DPUMP_PARFILE_FILE_NAME%
echo DUMPFILE=%DPUMP_DUMP_FILE_NAME% >> %DPUMP_PARFILE_FILE_NAME%
echo LOGFILE=%DPUMP_LOG_FILE_NAME% >> %DPUMP_PARFILE_FILE_NAME%
echo CONTENT=all >> %DPUMP_PARFILE_FILE_NAME%
echo EXCLUDE=TABLE:"IN ('SCHEDULER$_JOB_ARG')" >> %DPUMP_PARFILE_FILE_NAME%
REM echo FLASHBACK_TIME="TO_TIMESTAMP('%DPUMP_FLASHBACK_TIME%', 'DD-MON-YYYY HH24:MI:SS')" >> %DPUMP_PARFILE_FILE_NAME%
echo FLASHBACK_SCN=%DPUMP_FLASHBACK_SCN% >> %DPUMP_PARFILE_FILE_NAME%
echo FULL=y >> %DPUMP_PARFILE_FILE_NAME%

echo. >> "%LOGFILE%"
echo Done. >> "%LOGFILE%"


echo. >> "%LOGFILE%"
echo ============================================================== >> "%LOGFILE%"
echo   - PERFORM EXPORT. >> "%LOGFILE%"
echo ============================================================== >> "%LOGFILE%"

%ORACLE_HOME%\bin\expdp parfile=%DPUMP_PARFILE_FILE_NAME%

echo. >> "%LOGFILE%"
echo Done. >> "%LOGFILE%"


echo. >> "%LOGFILE%"
echo ============================================================== >> "%LOGFILE%"
echo   - DISPLAY EXPORT LOG FILE. >> "%LOGFILE%"
echo ============================================================== >> "%LOGFILE%"

type %DPUMP_LOG_FILE_LOCATION%  >> "%LOGFILE%"


echo. >> "%LOGFILE%"
echo ============================================================== >> "%LOGFILE%"
echo   - SCAN LOG FILE FOR ERRORS >> "%LOGFILE%"
echo     IGNORE 'ORA 39139: Data Pump does not support XMLSchema objects' ERRORS >> "%LOGFILE%"
echo   - APPLY RETENTION POLICY FOR OBSOLETE EXPORT (DUMP) FILES. >> "%LOGFILE%"
echo ============================================================== >> "%LOGFILE%"

findstr /i "ORA-" "%LOGFILE%" | findstr /v "ORA-39139: Data Pump does not support XMLSchema objects"  >> "%LOGFILE%"
IF errorlevel 1 (set ERRORS="NO") ELSE (set ERRORS="YES")


IF %ERRORS%=="YES" (
    echo. >> "%LOGFILE%"
    echo SETTING ERRORS TO %ERRORS% >> "%LOGFILE%"
    echo. >> "%LOGFILE%"
    echo -----------------------------------------------  >> "%LOGFILE%"
    echo Detected known exceptions in the export log >> "%LOGFILE%"
    echo file. Retention policy will NOT be enforced. >> "%LOGFILE%"
    echo -----------------------------------------------  >> "%LOGFILE%"
) ELSE (
    echo. >> "%LOGFILE%"
    echo SETTING ERRORS TO %ERRORS% >> "%LOGFILE%"
    echo. >> "%LOGFILE%"
    echo -----------------------------------------------  >> "%LOGFILE%"
    echo Did not detect any known exceptions in the >> "%LOGFILE%"
    echo export log file. Applying retention policy. >> "%LOGFILE%"
    echo -----------------------------------------------  >> "%LOGFILE%"


    echo. >> "%LOGFILE%"
    echo ============================================================== >> "%LOGFILE%"
    echo   - REMOVING OBSOLETE DATA PUMP LOG FILES >> "%LOGFILE%"
    echo       %DPUMP_LOG_DIR_PATH%\%SCRIPT_NAME_NOEXT%_%TNS_ALIAS%_*_DPUMPLOG.log >> "%LOGFILE%"
    echo ============================================================== >> "%LOGFILE%"

    echo. >> "%LOGFILE%"
    echo List of log files in %LOGDIR% older than %NUM_DAYS_TO_KEEP% days... >> "%LOGFILE%"
    forfiles /P %DPUMP_LOG_DIR_PATH% /S /D -%NUM_DAYS_TO_KEEP% /M %SCRIPT_NAME_NOEXT%_%TNS_ALIAS%_*_DPUMPLOG.log /C "CMD /C Echo @FILE will be deleted!" >> "%LOGFILE%"

    echo. >> "%LOGFILE%"
    echo Deleting log files in %LOGDIR% older than %NUM_DAYS_TO_KEEP% days... >> "%LOGFILE%"
    forfiles /P %DPUMP_LOG_DIR_PATH% /S /D -%NUM_DAYS_TO_KEEP% /M %SCRIPT_NAME_NOEXT%_%TNS_ALIAS%_*_DPUMPLOG.log /C "CMD /C del /Q /F @FILE" >> "%LOGFILE%"


    echo. >> "%LOGFILE%"
    echo ============================================================== >> "%LOGFILE%"
    echo   - REMOVING OBSOLETE CUSTOM ARCHIVE LOG FILES >> "%LOGFILE%"
    echo       %LOGDIR%\%SCRIPT_NAME_NOEXT%_%TNS_ALIAS%_*.log >> "%LOGFILE%"
    echo ============================================================== >> "%LOGFILE%"

    echo. >> "%LOGFILE%"
    echo List of log files in %LOGDIR% older than %NUM_DAYS_TO_KEEP% days... >> "%LOGFILE%"
    forfiles /P %LOGDIR% /S /D -%NUM_DAYS_TO_KEEP% /M %SCRIPT_NAME_NOEXT%_%TNS_ALIAS%_*.log /C "CMD /C Echo @FILE will be deleted!" >> "%LOGFILE%"

    echo. >> "%LOGFILE%"
    echo Deleting log files in %LOGDIR% older than %NUM_DAYS_TO_KEEP% days... >> "%LOGFILE%"
    forfiles /P %LOGDIR% /S /D -%NUM_DAYS_TO_KEEP% /M %SCRIPT_NAME_NOEXT%_%TNS_ALIAS%_*.log /C "CMD /C del /Q /F @FILE" >> "%LOGFILE%"


    echo. >> "%LOGFILE%"
    echo ============================================================== >> "%LOGFILE%"
    echo   - REMOVE OBSOLETE DATA PUMP EXPORT DUMP FILES. >> "%LOGFILE%"
    echo       %DPUMP_DUMP_DIR_PATH%\%SCRIPT_NAME_NOEXT%_%TNS_ALIAS%_*.dmp >> "%LOGFILE%"
    echo ============================================================== >> "%LOGFILE%"

    echo. >> "%LOGFILE%"
    echo List of dump files in %DPUMP_DUMP_DIR_PATH% older than %NUM_DAYS_TO_KEEP% days... >> "%LOGFILE%"
    forfiles /P %DPUMP_DUMP_DIR_PATH% /S /D -%NUM_DAYS_TO_KEEP% /M %SCRIPT_NAME_NOEXT%_%TNS_ALIAS%_*.dmp /C "CMD /C Echo @FILE will be deleted!" >> "%LOGFILE%"

    echo. >> "%LOGFILE%"
    echo Deleting dump files in %DPUMP_DUMP_DIR_PATH% older than %NUM_DAYS_TO_KEEP% days... >> "%LOGFILE%"
    forfiles /P %DPUMP_DUMP_DIR_PATH% /S /D -%NUM_DAYS_TO_KEEP% /M %SCRIPT_NAME_NOEXT%_%TNS_ALIAS%_*.dmp /C "CMD /C del /Q /F @FILE" >> "%LOGFILE%"
)


echo. >> "%LOGFILE%"
echo ============================================================== >> "%LOGFILE%"
echo   - REMOVE ANY TEMPORARY FILES. >> "%LOGFILE%"
echo ============================================================== >> "%LOGFILE%"

del /q %DPUMP_PARFILE_FILE_NAME% >> "%LOGFILE%"
del /q %TEMPSQLFILE% >> "%LOGFILE%"
del /q %TEMPBATFILE% >> "%LOGFILE%"

echo. >> "%LOGFILE%"
echo Done. >> "%LOGFILE%"


REM +--------------------------------------------------------------------------+
REM | SET END DATE AND TIME ENVIRONMENT VARIABLES                              |
REM +--------------------------------------------------------------------------+

set END_DATE=%DATE%
set END_TIME=%TIME%

echo.
echo ======================================================
echo   - FINISH TIME : %END_DATE% %END_TIME%
echo ======================================================


echo. >> "%LOGFILE%"
echo ====================================================== >> "%LOGFILE%"
echo   - FINISH TIME : %END_DATE% %END_TIME% >> "%LOGFILE%"
echo ====================================================== >> "%LOGFILE%"


echo. >> "%LOGFILE%"
echo ====================================================== >> "%LOGFILE%"
echo   - SEND EMAIL TO ADMINISTRATORS >> "%LOGFILE%"
echo ====================================================== >> "%LOGFILE%"

IF %ERRORS%=="YES" (
    set EMAIL_STATUS=[%HOSTNAME%] - FAILED: %SCRIPT_NAME_FULL%
) ELSE (
    set EMAIL_STATUS=[%HOSTNAME%] - SUCCESSFUL: %SCRIPT_NAME_FULL%
)

blat "%LOGFILE%" -subject "%EMAIL_STATUS%" -to %SMTP_EMAIL_TO% -server %SMTP_SERVER% -f %SMTP_EMAIL_FROM%


echo. >> "%LOGFILE%"
echo ====================================================== >> "%LOGFILE%"
echo   - EXITING SCRIPT >> "%LOGFILE%"
echo ====================================================== >> "%LOGFILE%"

echo Making copy of log file [%LOGFILE%] to [%LOGFILE_COPY%] >> "%LOGFILE%"
copy /Y /V %LOGFILE% %LOGFILE_COPY% >> "%LOGFILE%"


REM +--------------------------------------------------------------------------+
REM | END THIS SCRIPT                                                          |
REM +--------------------------------------------------------------------------+

goto END


REM +==========================================================================+
REM |                    ***   END OF SCRIPT   ***                             |
REM +==========================================================================+

REM +--------------------------------------------------------------------------+
REM | LABEL DECLARATION SECTION                                                |
REM +--------------------------------------------------------------------------+

:USAGE
echo Usage:    %SCRIPT_NAME_FULL%  "DBA_USERNAME"  "DBA_PASSWORD"  "TNS_ALIAS"  "DPUMP_DUMP_DIR"  "DPUMP_LOG_DIR"  "NUM_DAYS_TO_KEEP"
echo.
echo           DBA_USERNAME     = Oracle DBA Username - (Requires DBA Role)
echo           DBA_PASSWORD     = Oracle DBA Password
echo           TNS_ALIAS        = Connect String to connect to the database (ex. ORCL)
echo           DPUMP_DUMP_DIR   = Oracle "Directory Name" used by Data Pump to 
echo                              write the dump file(s) to on the database server.
echo           DPUMP_LOG_DIR    = Oracle "Directory Name" used by Data Pump to 
echo                              write the log file to on the database server.
echo           NUM_DAYS_TO_KEEP = Number of days worth of Oracle Data Pump exports 
echo                              to retain on the file system
goto END


:ERROR_DPUMP_DUMP_DIR
echo. >> "%LOGFILE%"
echo CRITICAL ERROR: Could not find %DPUMP_DUMP_DIR% (DPUMP_DUMP_DIR) in DBA_DIRECTORIES >> "%LOGFILE%"
echo. >> "%LOGFILE%"
echo USAGE: >> "%LOGFILE%"
echo %SCRIPT_NAME_FULL%  "DBA_USERNAME"  "DBA_PASSWORD"  "TNS_ALIAS"  "DPUMP_DUMP_DIR"  "DPUMP_LOG_DIR"  "NUM_DAYS_TO_KEEP" >> "%LOGFILE%"
set END_DATE=%DATE%
set END_TIME=%TIME%
echo. >> "%LOGFILE%"
echo ====================================================== >> "%LOGFILE%"
echo   - FINISH TIME : %END_DATE% %END_TIME% >> "%LOGFILE%"
echo ====================================================== >> "%LOGFILE%"
set EMAIL_STATUS=[%HOSTNAME%] - FAILED: %SCRIPT_NAME_FULL%
blat "%LOGFILE%" -subject "%EMAIL_STATUS%" -to %SMTP_EMAIL_TO% -server %SMTP_SERVER% -f %SMTP_EMAIL_FROM%
goto END


:ERROR_DPUMP_LOG_DIR
echo. >> "%LOGFILE%"
echo CRITICAL ERROR: Could not find %DPUMP_LOG_DIR% (DPUMP_LOG_DIR) in DBA_DIRECTORIES >> "%LOGFILE%"
echo. >> "%LOGFILE%"
echo USAGE: >> "%LOGFILE%"
echo %SCRIPT_NAME_FULL%  "DBA_USERNAME"  "DBA_PASSWORD"  "TNS_ALIAS"  "DPUMP_DUMP_DIR"  "DPUMP_LOG_DIR"  "NUM_DAYS_TO_KEEP" >> "%LOGFILE%"
set END_DATE=%DATE%
set END_TIME=%TIME%
echo. >> "%LOGFILE%"
echo ====================================================== >> "%LOGFILE%"
echo   - FINISH TIME : %END_DATE% %END_TIME% >> "%LOGFILE%"
echo ====================================================== >> "%LOGFILE%"
set EMAIL_STATUS=[%HOSTNAME%] - FAILED: %SCRIPT_NAME_FULL%
blat "%LOGFILE%" -subject "%EMAIL_STATUS%" -to %SMTP_EMAIL_TO% -server %SMTP_SERVER% -f %SMTP_EMAIL_FROM%
goto END


:END
@echo on
