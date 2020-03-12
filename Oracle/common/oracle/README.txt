+------------------------------------------------------------------------------+

=======================
    INSTALLATION
=======================

Available from the www.idevelopment.info web site, the Oracle DBA scripts come
archived in two formats: (1) TAR and (2) ZIP format. The installation for 
MS Windows and UNIX can utilize either of the archived files. 

The Oracle DBA scripts are typically installed in the ORACLE_BASE directory, 
although any directory will work. To install, simply download the archived
file to the ORACLE_BASE (i.e. c:\oracle) and run the appropriate 
command to un-archive it:

    -----------------------
    MS WINDOWS
    -----------------------
    cd %ORACLE_BASE%
    unzip common.zip

    -----------------------
    UNIX
    -----------------------
    cd $ORACLE_BASE
    unzip common.zip


=======================
    CONFIGURATION
=======================

Installation is nothing more than setting two environment variables in your 
operating system environment and ensuring that you are logged in as a user 
that has access to the Oracle database through OS roles as SYSDBA.

I typically install and run the scripts as the owner of the Oracle RDBMS
software. (i.e. "oracle). When running any of the O/S scripts, (located
in common/oracle/bin), this ensures that I can login to the database as a
user that has SYSDBA to the database with no password. You can test this as
follows in either MS Windows or UNIX:

    -----------------------
    TEST SYSDBA CONNECTION
    -----------------------
    sqlplus "/ as sysdba"

        SQL*Plus: Release 9.2.0.5.0 - Production on Sun Sep 19 11:24:27 2004

        Copyright (c) 1982, 2002, Oracle Corporation.  All rights reserved.


        Connected to:
        Oracle9i Enterprise Edition Release 9.2.0.5.0 - Production
        With the Partitioning, OLAP and Oracle Data Mining options
        JServer Release 9.2.0.5.0 - Production

        SQL>

After successfully un-archiving the scripts, you should now configure the 
following environment variables:

    -----------------------
    MS WINDOWS
    -----------------------
    PATH=c:\oracle\common\oracle\bin;%PATH%
    SQLPATH=.;c:\oracle\common\oracle\sql

    -----------------------
    UNIX
    -----------------------
    PATH=/u01/app/oracle/common/oracle/bin:$PATH
    ORACLE_PATH=.:/u01/app/oracle/common/oracle/sql:


=======================
  RUNNING SQL SCRIPTS
=======================

You should be able to run any of the SQL scripts in your common/oracle/sql while logged
into SQL*Plus. Here is an example of how to query tablespace information while 
logged into the Oracle database as a DBA user:

    SQL> @tablespaces

    Status    Tablespace Name TS Type      Ext. Mgt.  Seg. Mgt.  Tablespace Size  Used (in bytes) Pct. Used
    --------- --------------- ------------ ---------- --------- ---------------- ---------------- ---------
    ONLINE    CWMLITE         PERMANENT    LOCAL      AUTO            20,971,520       15,532,032        74
    ONLINE    DRSYS           PERMANENT    LOCAL      AUTO            20,971,520       10,158,080        48
    ONLINE    EXAMPLE         PERMANENT    LOCAL      AUTO           367,001,600      155,844,608        42
    ONLINE    INDX            PERMANENT    LOCAL      AUTO            52,428,800           65,536         0
    ONLINE    ODM             PERMANENT    LOCAL      AUTO            20,971,520       10,027,008        48
    ONLINE    OEM_REPOSITORY  PERMANENT    LOCAL      MANUAL          36,708,352       33,759,232        92
    ONLINE    PERFSTAT        PERMANENT    LOCAL      AUTO           157,286,400       96,272,384        61
    ONLINE    SYSTEM          PERMANENT    LOCAL      MANUAL         471,859,200      400,556,032        85
    ONLINE    TOOLS           PERMANENT    LOCAL      AUTO            10,485,760           65,536         1
    ONLINE    UNDOTBS1        UNDO         LOCAL      MANUAL         471,859,200       22,347,776         5
    ONLINE    USERS           PERMANENT    LOCAL      AUTO           262,144,000           65,536         0
    ONLINE    XDB             PERMANENT    LOCAL      AUTO            52,428,800       46,923,776        90
    ONLINE    TEMP            TEMPORARY    LOCAL      MANUAL         471,859,200       40,894,464         9
                                                                ---------------- ---------------- ---------
    avg                                                                                                  43
    sum                                                            2,416,975,872      832,512,000

    13 rows selected.

NOTE: The ORACLE_PATH (in UNIX) and SQLPATH (in Windows) environment variables 
      do not work in Oracle Release 8.1.7.4.0 and 9.2.0.4.0. You will have to 
      either change to the directory containing your SQL scripts and then run 
      SQL*Plus from that directory or you can simply provide the absolute path
      of the location of the SQL scripts. (i.e. @c:\oracle\common\oracle\sql\tablespaces)


=======================
  RUNNING O/S SCRIPTS
=======================

Operating system scripts are located in the common/oracle/bin directory for
both UNIX and MS Windows. These scripts can be used to assist the DBA in 
managing and monitoring databases hosted on that machine. I have attempted
to provide functionality for both UNIX and MS Windows but this is not 
always the case.

UNIX shell scripts can be identified with either a *.sh or *.ksh extension
while command scripts for MS Windows will have *.cmd, *.vbs, or *.bat 
extensions.


=======================
  CUSTOM vs. COMMON
=======================

You may have noticed that along side the common/* set of directories,
there is another directory structure called custom/*. While most of
the scripts contained within the common/* directory structure can
be run without modification, I often find it necessary to customize 
several of the scripts for a particular environment. Instead of 
applying modifications to scripts contained in the common/* directory
structure, I instead make a copy of the script(s) to the 
custom/* directory structure. This allows me to replace (update) the
common/* directory structure without worrying about overriding any 
customizations. If you decide to use this same methodology (and 
directory structure), you should place the custom/* directory 
structure paths ahead of the common/* directory structures in 
all of your PATH variables. For example:

    -----------------------
    MS WINDOWS
    -----------------------
    PATH=c:\oracle\custom\oracle\bin;c:\oracle\common\oracle\bin;%PATH%
    SQLPATH=.;c:\oracle\custom\oracle\sql;c:\oracle\common\oracle\sql

    -----------------------
    UNIX
    -----------------------
    PATH=//u01/app/oracle/custom/oracle/bin:u01/app/oracle/common/oracle/bin:$PATH
    ORACLE_PATH=.:/u01/app/oracle/custom/oracle/sql:/u01/app/oracle/common/oracle/sql

This allows the customized version of the script to be executed before
attempting to access those scripts in the common/* directory structure.
