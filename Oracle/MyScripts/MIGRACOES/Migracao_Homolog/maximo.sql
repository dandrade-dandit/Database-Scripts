-- Start of DDL Script for Table IFRMAXIMO.A_LONGDESCRIPTION
-- Generated 9-mar-2004 19:57:10 from SYSMAN@MAQUINA4

CREATE TABLE a_longdescription
    (ldkey                          NUMBER,
    ldownertable                   VARCHAR2(18),
    ldownercol                     VARCHAR2(18),
    ldtext                         LONG,
    eauditusername                 VARCHAR2(18) NOT NULL,
    eaudittimestamp                DATE NOT NULL,
    eaudittype                     VARCHAR2(1) NOT NULL,
    eaudittransid                  VARCHAR2(40) NOT NULL,
    esigtransid                    VARCHAR2(40),
    rowstamp                       VARCHAR2(40) NOT NULL)
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Triggers for A_LONGDESCRIPTION

CREATE TRIGGER a_longdescription_t
BEFORE INSERT  OR UPDATE 
ON a_longdescription
REFERENCING NEW AS NEW OLD AS OLD
FOR EACH ROW
DECLARE NEXTVAL INTEGER; BEGIN SELECT MAXSEQ.NEXTVAL INTO NEXTVAL FROM DUAL; :NEW.ROWSTAMP := NEXTVAL; END;
/

-- End of DDL Script for Table IFRMAXIMO.A_LONGDESCRIPTION

-- Start of DDL Script for Table IFRMAXIMO.ACCOUNTDEFAULTS
-- Generated 9-mar-2004 19:57:13 from SYSMAN@MAQUINA4

CREATE TABLE accountdefaults
    (rowstamp                       VARCHAR2(40) NOT NULL,
    dfltgroup                      VARCHAR2(20) NOT NULL,
    groupvalue                     VARCHAR2(50) NOT NULL,
    gldefault                      VARCHAR2(20),
    oldgldefault                   VARCHAR2(20),
    orgid                          VARCHAR2(8) NOT NULL)
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Indexes for ACCOUNTDEFAULTS

CREATE UNIQUE INDEX acctdflt_ndx1 ON accountdefaults
  (
    orgid                           ASC,
    dfltgroup                       ASC,
    groupvalue                      ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/


-- Triggers for ACCOUNTDEFAULTS

CREATE TRIGGER accountdefaults_t
BEFORE INSERT  OR UPDATE 
ON accountdefaults
REFERENCING NEW AS NEW OLD AS OLD
FOR EACH ROW
DECLARE 
NEXTVAL INTEGER; BEGIN SELECT MAXSEQ.NEXTVAL INTO NEXTVAL FROM DUAL; 
:NEW.ROWSTAMP := NEXTVAL; END;
/

-- End of DDL Script for Table IFRMAXIMO.ACCOUNTDEFAULTS

-- Start of DDL Script for Table IFRMAXIMO.ADDRESS
-- Generated 9-mar-2004 19:57:20 from SYSMAN@MAQUINA4

CREATE TABLE address
    (rowstamp                       VARCHAR2(40) NOT NULL,
    orgid                          VARCHAR2(8) NOT NULL,
    addresscode                    VARCHAR2(50) NOT NULL,
    description                    VARCHAR2(150),
    address1                       VARCHAR2(50),
    address2                       VARCHAR2(50),
    address3                       VARCHAR2(50),
    address4                       VARCHAR2(50),
    address5                       VARCHAR2(50),
    ldkey                          NUMBER,
    changeby                       VARCHAR2(18),
    changedate                     DATE NOT NULL)
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Indexes for ADDRESS

CREATE UNIQUE INDEX address_ndx1 ON address
  (
    orgid                           ASC,
    addresscode                     ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/


-- Triggers for ADDRESS

CREATE TRIGGER address_t
BEFORE INSERT  OR UPDATE 
ON address
REFERENCING NEW AS NEW OLD AS OLD
FOR EACH ROW
DECLARE 
NEXTVAL INTEGER; BEGIN SELECT MAXSEQ.NEXTVAL INTO NEXTVAL FROM DUAL; 
:NEW.ROWSTAMP := NEXTVAL; END;
/

-- End of DDL Script for Table IFRMAXIMO.ADDRESS

-- Start of DDL Script for Table IFRMAXIMO.ALNDOMAINVALUE
-- Generated 9-mar-2004 19:57:26 from SYSMAN@MAQUINA4

CREATE TABLE alndomainvalue
    (domainid                       VARCHAR2(18) NOT NULL,
    alnvalue                       VARCHAR2(16),
    description                    VARCHAR2(30),
    rowstamp                       VARCHAR2(40) NOT NULL)
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Indexes for ALNDOMAINVALUE

CREATE UNIQUE INDEX alndomainval_ndx1 ON alndomainvalue
  (
    domainid                        ASC,
    alnvalue                        ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/


-- Triggers for ALNDOMAINVALUE

CREATE TRIGGER alndomainvalue_t
BEFORE INSERT  OR UPDATE 
ON alndomainvalue
REFERENCING NEW AS NEW OLD AS OLD
FOR EACH ROW
DECLARE NEXTVAL INTEGER; BEGIN SELECT MAXSEQ.NEXTVAL INTO NEXTVAL FROM DUAL; :NEW.ROWSTAMP := NEXTVAL; END;
/

-- End of DDL Script for Table IFRMAXIMO.ALNDOMAINVALUE

-- Start of DDL Script for Table IFRMAXIMO.ALTITEM
-- Generated 9-mar-2004 19:57:32 from SYSMAN@MAQUINA4

CREATE TABLE altitem
    (rowstamp                       VARCHAR2(40) NOT NULL,
    itemnum                        VARCHAR2(30) NOT NULL,
    altitemnum                     VARCHAR2(30) NOT NULL,
    orgid                          VARCHAR2(8) NOT NULL)
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Indexes for ALTITEM

CREATE UNIQUE INDEX altitem_ndx1 ON altitem
  (
    orgid                           ASC,
    itemnum                         ASC,
    altitemnum                      ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/


-- Triggers for ALTITEM

CREATE TRIGGER altitem_t
BEFORE INSERT  OR UPDATE 
ON altitem
REFERENCING NEW AS NEW OLD AS OLD
FOR EACH ROW
DECLARE 
NEXTVAL INTEGER; BEGIN SELECT MAXSEQ.NEXTVAL INTO NEXTVAL FROM DUAL; 
:NEW.ROWSTAMP := NEXTVAL; END;
/

-- End of DDL Script for Table IFRMAXIMO.ALTITEM

-- Start of DDL Script for Table IFRMAXIMO.APPDOCTYPE
-- Generated 9-mar-2004 19:57:39 from SYSMAN@MAQUINA4

CREATE TABLE appdoctype
    (rowstamp                       VARCHAR2(40) NOT NULL,
    app                            VARCHAR2(10) NOT NULL,
    doctype                        VARCHAR2(8) NOT NULL,
    siteid                         VARCHAR2(8) NOT NULL,
    orgid                          VARCHAR2(8) NOT NULL)
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Indexes for APPDOCTYPE

CREATE UNIQUE INDEX appdoctype_ndx1 ON appdoctype
  (
    siteid                          ASC,
    app                             ASC,
    doctype                         ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/


-- Triggers for APPDOCTYPE

CREATE TRIGGER appdoctype_t
BEFORE INSERT  OR UPDATE 
ON appdoctype
REFERENCING NEW AS NEW OLD AS OLD
FOR EACH ROW
DECLARE 
NEXTVAL INTEGER; BEGIN SELECT MAXSEQ.NEXTVAL INTO NEXTVAL FROM DUAL; 
:NEW.ROWSTAMP := NEXTVAL; END;
/

-- End of DDL Script for Table IFRMAXIMO.APPDOCTYPE

-- Start of DDL Script for Table IFRMAXIMO.APPFIELDDEFAULTS
-- Generated 9-mar-2004 19:57:45 from SYSMAN@MAQUINA4

CREATE TABLE appfielddefaults
    (rowstamp                       VARCHAR2(40) NOT NULL,
    app                            VARCHAR2(10) NOT NULL,
    tbname                         VARCHAR2(18) NOT NULL,
    colname                        VARCHAR2(18) NOT NULL,
    siteid                         VARCHAR2(8) NOT NULL,
    grpname                        VARCHAR2(18),
    username                       VARCHAR2(18),
    defaultvalue                   VARCHAR2(50))
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Indexes for APPFIELDDEFAULTS

CREATE UNIQUE INDEX appfielddef_ndx1 ON appfielddefaults
  (
    app                             ASC,
    tbname                          ASC,
    colname                         ASC,
    siteid                          ASC,
    grpname                         ASC,
    username                        ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/
CREATE UNIQUE INDEX appfielddef_ndx2 ON appfielddefaults
  (
    app                             ASC,
    tbname                          ASC,
    colname                         ASC,
    siteid                          ASC,
    username                        ASC,
    grpname                         ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/


-- Triggers for APPFIELDDEFAULTS

CREATE TRIGGER appfielddefaults_t
BEFORE INSERT  OR UPDATE 
ON appfielddefaults
REFERENCING NEW AS NEW OLD AS OLD
FOR EACH ROW
DECLARE 
NEXTVAL INTEGER; BEGIN SELECT MAXSEQ.NEXTVAL INTO NEXTVAL FROM DUAL; 
:NEW.ROWSTAMP := NEXTVAL; END;
/

-- End of DDL Script for Table IFRMAXIMO.APPFIELDDEFAULTS

-- Start of DDL Script for Table IFRMAXIMO.APPLAUNCH
-- Generated 9-mar-2004 19:57:55 from SYSMAN@MAQUINA4

CREATE TABLE applaunch
    (rowstamp                       VARCHAR2(40) NOT NULL,
    launchingapp                   VARCHAR2(10) NOT NULL,
    launchingitem                  VARCHAR2(32) NOT NULL,
    launchingdatafield             VARCHAR2(32),
    launchingtype                  VARCHAR2(1) NOT NULL,
    launchedapp                    VARCHAR2(128) NOT NULL,
    launcheddatafield              VARCHAR2(32),
    launchedtype                   VARCHAR2(1) NOT NULL,
    launchparameters               VARCHAR2(124),
    launchingparent                VARCHAR2(10) NOT NULL,
    ldkey                          NUMBER)
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Indexes for APPLAUNCH

CREATE UNIQUE INDEX applaunch_ndx1 ON applaunch
  (
    launchingapp                    ASC,
    launchingparent                 ASC,
    launchingitem                   ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/


-- Triggers for APPLAUNCH

CREATE TRIGGER applaunch_t
BEFORE INSERT  OR UPDATE 
ON applaunch
REFERENCING NEW AS NEW OLD AS OLD
FOR EACH ROW
DECLARE 
NEXTVAL INTEGER; BEGIN SELECT MAXSEQ.NEXTVAL INTO NEXTVAL FROM DUAL; 
:NEW.ROWSTAMP := NEXTVAL; END;
/

-- End of DDL Script for Table IFRMAXIMO.APPLAUNCH

-- Start of DDL Script for Table IFRMAXIMO.APPROVALLIMIT
-- Generated 9-mar-2004 19:58:01 from SYSMAN@MAQUINA4

CREATE TABLE approvallimit
    (rowstamp                       VARCHAR2(40) NOT NULL,
    orgid                          VARCHAR2(8) NOT NULL,
    grpname                        VARCHAR2(18) NOT NULL,
    polimit                        NUMBER(8),
    prlimit                        NUMBER(8),
    invoicelimit                   NUMBER(8))
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Indexes for APPROVALLIMIT

CREATE UNIQUE INDEX approvallimit_ndx1 ON approvallimit
  (
    orgid                           ASC,
    grpname                         ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/


-- Triggers for APPROVALLIMIT

CREATE TRIGGER approvallimit_t
BEFORE INSERT  OR UPDATE 
ON approvallimit
REFERENCING NEW AS NEW OLD AS OLD
FOR EACH ROW
DECLARE 
NEXTVAL INTEGER; BEGIN SELECT MAXSEQ.NEXTVAL INTO NEXTVAL FROM DUAL; 
:NEW.ROWSTAMP := NEXTVAL; END;
/

-- End of DDL Script for Table IFRMAXIMO.APPROVALLIMIT

-- Start of DDL Script for Table IFRMAXIMO.ARCHIVE
-- Generated 9-mar-2004 19:58:08 from SYSMAN@MAQUINA4

CREATE TABLE archive
    (rowstamp                       VARCHAR2(40) NOT NULL,
    archivedate                    DATE NOT NULL,
    module                         VARCHAR2(30) NOT NULL,
    type                           VARCHAR2(8),
    path                           VARCHAR2(63),
    archscript                     VARCHAR2(12),
    restscript                     VARCHAR2(12),
    viewsql                        VARCHAR2(254),
    siteid                         VARCHAR2(8),
    orgid                          VARCHAR2(8))
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Indexes for ARCHIVE

CREATE UNIQUE INDEX archive_ndx1 ON archive
  (
    archivedate                     ASC,
    module                          ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/


-- Triggers for ARCHIVE

CREATE TRIGGER archive_t
BEFORE INSERT  OR UPDATE 
ON archive
REFERENCING NEW AS NEW OLD AS OLD
FOR EACH ROW
DECLARE 
NEXTVAL INTEGER; BEGIN SELECT MAXSEQ.NEXTVAL INTO NEXTVAL FROM DUAL; 
:NEW.ROWSTAMP := NEXTVAL; END;
/

-- End of DDL Script for Table IFRMAXIMO.ARCHIVE

-- Start of DDL Script for Table IFRMAXIMO.ASSETATTRIBUTE
-- Generated 9-mar-2004 19:58:16 from SYSMAN@MAQUINA4

CREATE TABLE assetattribute
    (rowstamp                       VARCHAR2(40) NOT NULL,
    assetattrid                    VARCHAR2(8) NOT NULL,
    description                    VARCHAR2(30),
    datatype                       VARCHAR2(10) NOT NULL,
    measureunitid                  VARCHAR2(8),
    domainid                       VARCHAR2(18),
    attrdescprefix                 VARCHAR2(8),
    aa01                           VARCHAR2(10),
    aa02                           VARCHAR2(10),
    aa03                           VARCHAR2(10),
    aa04                           DATE,
    aa05                           NUMBER(15,2),
    orgid                          VARCHAR2(8) NOT NULL)
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Indexes for ASSETATTRIBUTE

CREATE UNIQUE INDEX assetattr_ndx1 ON assetattribute
  (
    orgid                           ASC,
    assetattrid                     ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/


-- Triggers for ASSETATTRIBUTE

CREATE TRIGGER assetattribute_t
BEFORE INSERT  OR UPDATE 
ON assetattribute
REFERENCING NEW AS NEW OLD AS OLD
FOR EACH ROW
DECLARE 
NEXTVAL INTEGER; BEGIN SELECT MAXSEQ.NEXTVAL INTO NEXTVAL FROM DUAL; 
:NEW.ROWSTAMP := NEXTVAL; END;
/

-- End of DDL Script for Table IFRMAXIMO.ASSETATTRIBUTE

-- Start of DDL Script for Table IFRMAXIMO.ASSETCLASS
-- Generated 9-mar-2004 19:58:23 from SYSMAN@MAQUINA4

CREATE TABLE assetclass
    (rowstamp                       VARCHAR2(40) NOT NULL,
    classificationid               VARCHAR2(18) NOT NULL,
    description                    VARCHAR2(30),
    ldkey                          NUMBER,
    ac01                           VARCHAR2(10),
    ac02                           VARCHAR2(10),
    ac03                           VARCHAR2(10),
    ac04                           DATE,
    ac05                           NUMBER(15,2),
    orgid                          VARCHAR2(8) NOT NULL)
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Indexes for ASSETCLASS

CREATE UNIQUE INDEX assetclass_ndx1 ON assetclass
  (
    orgid                           ASC,
    classificationid                ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/


-- Triggers for ASSETCLASS

CREATE TRIGGER assetclass_t
BEFORE INSERT  OR UPDATE 
ON assetclass
REFERENCING NEW AS NEW OLD AS OLD
FOR EACH ROW
DECLARE 
NEXTVAL INTEGER; BEGIN SELECT MAXSEQ.NEXTVAL INTO NEXTVAL FROM DUAL; 
:NEW.ROWSTAMP := NEXTVAL; END;
/

-- End of DDL Script for Table IFRMAXIMO.ASSETCLASS

-- Start of DDL Script for Table IFRMAXIMO.ASSIGNMENT
-- Generated 9-mar-2004 19:58:29 from SYSMAN@MAQUINA4

CREATE TABLE assignment
    (rowstamp                       VARCHAR2(40) NOT NULL,
    wplaborid                      VARCHAR2(20) NOT NULL,
    wonum                          VARCHAR2(18) NOT NULL,
    craft                          VARCHAR2(12) NOT NULL,
    laborhrs                       FLOAT(126) NOT NULL,
    status                         VARCHAR2(10) NOT NULL,
    scheduledate                   DATE,
    laborcode                      VARCHAR2(12),
    startdate                      DATE,
    finishdate                     DATE,
    as01                           VARCHAR2(1),
    as02                           VARCHAR2(1),
    as03                           VARCHAR2(1),
    as04                           VARCHAR2(1),
    as05                           VARCHAR2(1),
    orgid                          VARCHAR2(8),
    siteid                         VARCHAR2(8))
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Indexes for ASSIGNMENT

CREATE INDEX assignmnt_ndx ON assignment
  (
    orgid                           ASC,
    wonum                           ASC,
    wplaborid                       ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/


-- Triggers for ASSIGNMENT

CREATE TRIGGER assignment_t
BEFORE INSERT  OR UPDATE 
ON assignment
REFERENCING NEW AS NEW OLD AS OLD
FOR EACH ROW
DECLARE 
NEXTVAL INTEGER; BEGIN SELECT MAXSEQ.NEXTVAL INTO NEXTVAL FROM DUAL; 
:NEW.ROWSTAMP := NEXTVAL; END;
/

-- End of DDL Script for Table IFRMAXIMO.ASSIGNMENT

-- Start of DDL Script for Table IFRMAXIMO.ATTENDANCE
-- Generated 9-mar-2004 19:58:36 from SYSMAN@MAQUINA4

CREATE TABLE attendance
    (rowstamp                       VARCHAR2(40) NOT NULL,
    laborcode                      VARCHAR2(12) NOT NULL,
    startdate                      DATE NOT NULL,
    starttime                      DATE,
    finishdate                     DATE,
    finishtime                     DATE,
    laborhours                     FLOAT(126) NOT NULL,
    enterdate                      DATE NOT NULL,
    transdate                      DATE NOT NULL,
    enterby                        VARCHAR2(18) NOT NULL,
    at1                            VARCHAR2(10),
    at2                            VARCHAR2(10),
    at3                            VARCHAR2(10),
    at4                            DATE,
    at5                            NUMBER(15,2),
    orgid                          VARCHAR2(8))
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Indexes for ATTENDANCE

CREATE INDEX attend_ndx1 ON attendance
  (
    orgid                           ASC,
    laborcode                       ASC,
    transdate                       ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/


-- Triggers for ATTENDANCE

CREATE TRIGGER attendance_t
BEFORE INSERT  OR UPDATE 
ON attendance
REFERENCING NEW AS NEW OLD AS OLD
FOR EACH ROW
DECLARE 
NEXTVAL INTEGER; BEGIN SELECT MAXSEQ.NEXTVAL INTO NEXTVAL FROM DUAL; 
:NEW.ROWSTAMP := NEXTVAL; END;
/

-- End of DDL Script for Table IFRMAXIMO.ATTENDANCE

-- Start of DDL Script for Table IFRMAXIMO.AUTOKEY
-- Generated 9-mar-2004 19:58:44 from SYSMAN@MAQUINA4

CREATE TABLE autokey
    (rowstamp                       VARCHAR2(40) NOT NULL,
    tbname                         VARCHAR2(18) NOT NULL,
    prefix                         VARCHAR2(8),
    seed                           NUMBER NOT NULL,
    name                           VARCHAR2(18) NOT NULL,
    orgid                          VARCHAR2(8),
    siteid                         VARCHAR2(8))
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Indexes for AUTOKEY

CREATE UNIQUE INDEX autokey_ndx1 ON autokey
  (
    tbname                          ASC,
    name                            ASC,
    orgid                           ASC,
    siteid                          ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/


-- Triggers for AUTOKEY

CREATE TRIGGER autokey_t
BEFORE INSERT  OR UPDATE 
ON autokey
REFERENCING NEW AS NEW OLD AS OLD
FOR EACH ROW
DECLARE 
NEXTVAL INTEGER; BEGIN SELECT MAXSEQ.NEXTVAL INTO NEXTVAL FROM DUAL; 
:NEW.ROWSTAMP := NEXTVAL; END;
/

-- End of DDL Script for Table IFRMAXIMO.AUTOKEY

-- Start of DDL Script for Table IFRMAXIMO.BOOKMARK
-- Generated 9-mar-2004 19:58:52 from SYSMAN@MAQUINA4

CREATE TABLE bookmark
    (rowstamp                       VARCHAR2(40) NOT NULL,
    username                       VARCHAR2(18) NOT NULL,
    app                            VARCHAR2(10) NOT NULL,
    keyvalue                       VARCHAR2(50) NOT NULL,
    enterdate                      DATE NOT NULL,
    siteid                         VARCHAR2(8) NOT NULL,
    orgid                          VARCHAR2(8))
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Indexes for BOOKMARK

CREATE UNIQUE INDEX bookmark_ndx1 ON bookmark
  (
    siteid                          ASC,
    username                        ASC,
    app                             ASC,
    keyvalue                        ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/


-- Triggers for BOOKMARK

CREATE TRIGGER bookmark_t
BEFORE INSERT  OR UPDATE 
ON bookmark
REFERENCING NEW AS NEW OLD AS OLD
FOR EACH ROW
DECLARE 
NEXTVAL INTEGER; BEGIN SELECT MAXSEQ.NEXTVAL INTO NEXTVAL FROM DUAL; 
:NEW.ROWSTAMP := NEXTVAL; END;
/

-- End of DDL Script for Table IFRMAXIMO.BOOKMARK

-- Start of DDL Script for Table IFRMAXIMO.CALENDAR
-- Generated 9-mar-2004 19:58:59 from SYSMAN@MAQUINA4

CREATE TABLE calendar
    (rowstamp                       VARCHAR2(40) NOT NULL,
    calnum                         VARCHAR2(8) NOT NULL,
    description                    VARCHAR2(50),
    startdate                      DATE NOT NULL,
    enddate                        DATE NOT NULL,
    ca1                            VARCHAR2(10),
    ca2                            VARCHAR2(10),
    ca3                            VARCHAR2(10),
    ca4                            DATE,
    ca5                            VARCHAR2(10),
    ldkey                          NUMBER,
    orgid                          VARCHAR2(8) NOT NULL)
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Indexes for CALENDAR

CREATE UNIQUE INDEX calendar_ndx ON calendar
  (
    orgid                           ASC,
    calnum                          ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/


-- Triggers for CALENDAR

CREATE TRIGGER calendar_t
BEFORE INSERT  OR UPDATE 
ON calendar
REFERENCING NEW AS NEW OLD AS OLD
FOR EACH ROW
DECLARE 
NEXTVAL INTEGER; BEGIN SELECT MAXSEQ.NEXTVAL INTO NEXTVAL FROM DUAL; 
:NEW.ROWSTAMP := NEXTVAL; END;
/

-- End of DDL Script for Table IFRMAXIMO.CALENDAR

-- Start of DDL Script for Table IFRMAXIMO.CHARTOFACCOUNTS
-- Generated 9-mar-2004 19:59:07 from SYSMAN@MAQUINA4

CREATE TABLE chartofaccounts
    (rowstamp                       VARCHAR2(40) NOT NULL,
    glaccount                      VARCHAR2(20) NOT NULL,
    glcomp01                       VARCHAR2(3),
    glcomp02                       VARCHAR2(2),
    glcomp03                       VARCHAR2(2),
    glcomp04                       VARCHAR2(2),
    glcomp05                       VARCHAR2(2),
    glcomp06                       VARCHAR2(1),
    glcomp07                       VARCHAR2(20),
    glcomp08                       VARCHAR2(20),
    glcomp09                       VARCHAR2(20),
    glcomp10                       VARCHAR2(20),
    glcomp11                       VARCHAR2(20),
    glcomp12                       VARCHAR2(20),
    glcomp13                       VARCHAR2(20),
    glcomp14                       VARCHAR2(20),
    glcomp15                       VARCHAR2(20),
    glcomp16                       VARCHAR2(20),
    glcomp17                       VARCHAR2(20),
    glcomp18                       VARCHAR2(20),
    glcomp19                       VARCHAR2(20),
    glcomp20                       VARCHAR2(20),
    accountname                    VARCHAR2(75),
    glacctype                      VARCHAR2(3),
    ch1                            VARCHAR2(10),
    ch2                            VARCHAR2(10),
    ch3                            VARCHAR2(10),
    ch4                            NUMBER(15,2),
    ch5                            NUMBER,
    disabled                       VARCHAR2(1) NOT NULL,
    ldkey                          NUMBER,
    sourcesysid                    VARCHAR2(10),
    ownersysid                     VARCHAR2(10),
    externalrefid                  VARCHAR2(10),
    apiseq                         VARCHAR2(50),
    interid                        VARCHAR2(50),
    migchangeid                    VARCHAR2(50),
    sendersysid                    VARCHAR2(50),
    orgid                          VARCHAR2(8) NOT NULL)
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Indexes for CHARTOFACCOUNTS

CREATE UNIQUE INDEX coa_ndx1 ON chartofaccounts
  (
    orgid                           ASC,
    glaccount                       ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/
CREATE INDEX coa_ndx2 ON chartofaccounts
  (
    orgid                           ASC,
    glacctype                       ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/
CREATE INDEX coa_ndx3 ON chartofaccounts
  (
    orgid                           ASC,
    glcomp01                        ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/
CREATE INDEX coa_ndx4 ON chartofaccounts
  (
    orgid                           ASC,
    interid                         ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/


-- Triggers for CHARTOFACCOUNTS

CREATE TRIGGER chartofaccounts_t
BEFORE INSERT  OR UPDATE 
ON chartofaccounts
REFERENCING NEW AS NEW OLD AS OLD
FOR EACH ROW
DECLARE 
NEXTVAL INTEGER; BEGIN SELECT MAXSEQ.NEXTVAL INTO NEXTVAL FROM DUAL; 
:NEW.ROWSTAMP := NEXTVAL; END;
/

-- End of DDL Script for Table IFRMAXIMO.CHARTOFACCOUNTS

-- Start of DDL Script for Table IFRMAXIMO.CLASSSPEC
-- Generated 9-mar-2004 19:59:26 from SYSMAN@MAQUINA4

CREATE TABLE classspec
    (rowstamp                       VARCHAR2(40) NOT NULL,
    classstructureid               VARCHAR2(20) NOT NULL,
    assetattrid                    VARCHAR2(8) NOT NULL,
    measureunitid                  VARCHAR2(8),
    domainid                       VARCHAR2(18),
    defaultnumvalue                NUMBER(10,2),
    defaultalnvalue                VARCHAR2(16),
    attrdescprefix                 VARCHAR2(8),
    useinitemspec                  VARCHAR2(1) NOT NULL,
    itemsequence                   NUMBER NOT NULL,
    itemrequirevalue               VARCHAR2(1) NOT NULL,
    useinitemdesc                  VARCHAR2(1) NOT NULL,
    useineqspec                    VARCHAR2(1) NOT NULL,
    eqsequence                     NUMBER NOT NULL,
    eqrequirevalue                 VARCHAR2(1) NOT NULL,
    useineqdesc                    VARCHAR2(1) NOT NULL,
    useinlocspec                   VARCHAR2(1) NOT NULL,
    locsequence                    NUMBER NOT NULL,
    locrequirevalue                VARCHAR2(1) NOT NULL,
    useinlocdesc                   VARCHAR2(1) NOT NULL,
    cs01                           VARCHAR2(10),
    cs02                           VARCHAR2(10),
    cs03                           VARCHAR2(10),
    cs04                           DATE,
    cs05                           NUMBER(15,2),
    orgid                          VARCHAR2(8) NOT NULL)
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Indexes for CLASSSPEC

CREATE UNIQUE INDEX classspec_ndx1 ON classspec
  (
    orgid                           ASC,
    classstructureid                ASC,
    assetattrid                     ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/


-- Triggers for CLASSSPEC

CREATE TRIGGER classspec_t
BEFORE INSERT  OR UPDATE 
ON classspec
REFERENCING NEW AS NEW OLD AS OLD
FOR EACH ROW
DECLARE 
NEXTVAL INTEGER; BEGIN SELECT MAXSEQ.NEXTVAL INTO NEXTVAL FROM DUAL; 
:NEW.ROWSTAMP := NEXTVAL; END;
/
CREATE TRIGGER classspec_verity_t
AFTER INSERT  OR UPDATE  OR  DELETE 
ON classspec
REFERENCING NEW AS NEW OLD AS OLD
FOR EACH ROW
Declare	 	ClassStructIdFlag varchar2(20); 	OrgIdFlag varchar2(8); 	Cursor C_Item (ClassStructIdFlag varchar,OrgIdFlag varchar) Is 		Select itemnum,orgid 		From   item 		Where  classstructureid = ClassStructIdFlag 		And    orgid = OrgIdFlag;   	AutoPreFixSeed 	Varchar2(20); 	RecordCount	Number; 	ItemFlag	Varchar2(30); Begin     Select  ltrim(rtrim(prefix))||seed     Into    AutoPreFixSeed     From    autokey     Where   tbname ='VERITYACTION';      If 	   Inserting Then 	  ClassStructIdFlag   := :new.classstructureid; 	  OrgIdFlag := :new.orgid;     Elsif Updating  Then 	  ClassStructIdFlag   := :new.classstructureid; 	  OrgIdFlag := :new.orgid;     Elsif Deleting  Then 	  ClassStructIdFlag   := :old.classstructureid; 	  OrgIdFlag := :old.orgid;     End If;       For C0 in C_Item(ClassStructIdFlag,orgIdFlag)     loop 	Select  Count(*)  	Into    RecordCount 	From    verityaction 	Where   itemnum = c0.itemnum 	And     orgid = c0.orgid 	And     action = 'U' 	And     transid = AutoPreFixSeed;    	If      RecordCount = 0 	Then    Insert Into verityaction(itemnum,action,transid,orgid) 	Values 	( 	    	c0.ItemNum, 	     	'U', 	     	AutoPreFixSeed, 		c0.orgid 	);    	End If;    end loop; Exception 	When Others then 	   raise_application_error(-20001,'Failure Encountered in executing Trigger CLASSSPEC_VERITY_T'); End;
/

-- End of DDL Script for Table IFRMAXIMO.CLASSSPEC

-- Start of DDL Script for Table IFRMAXIMO.CLASSSTRUCTLINK
-- Generated 9-mar-2004 19:59:33 from SYSMAN@MAQUINA4

CREATE TABLE classstructlink
    (rowstamp                       VARCHAR2(40) NOT NULL,
    classificationid               VARCHAR2(18) NOT NULL,
    classstructureid               VARCHAR2(20) NOT NULL,
    orgid                          VARCHAR2(8) NOT NULL)
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Indexes for CLASSSTRUCTLINK

CREATE UNIQUE INDEX classstructlnk_ndx ON classstructlink
  (
    orgid                           ASC,
    classificationid                ASC,
    classstructureid                ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/


-- Triggers for CLASSSTRUCTLINK

CREATE TRIGGER classstructlink_t
BEFORE INSERT  OR UPDATE 
ON classstructlink
REFERENCING NEW AS NEW OLD AS OLD
FOR EACH ROW
DECLARE 
NEXTVAL INTEGER; BEGIN SELECT MAXSEQ.NEXTVAL INTO NEXTVAL FROM DUAL; 
:NEW.ROWSTAMP := NEXTVAL; END;
/

-- End of DDL Script for Table IFRMAXIMO.CLASSSTRUCTLINK

-- Start of DDL Script for Table IFRMAXIMO.CLASSSTRUCTURE
-- Generated 9-mar-2004 19:59:40 from SYSMAN@MAQUINA4

CREATE TABLE classstructure
    (rowstamp                       VARCHAR2(40) NOT NULL,
    classstructureid               VARCHAR2(20) NOT NULL,
    l1classificationid             VARCHAR2(18) NOT NULL,
    l2classificationid             VARCHAR2(18),
    l3classificationid             VARCHAR2(18),
    l4classificationid             VARCHAR2(18),
    l5classificationid             VARCHAR2(18),
    description                    VARCHAR2(50),
    genassetdesc                   VARCHAR2(1) NOT NULL,
    usel1classindesc               VARCHAR2(1) NOT NULL,
    usel2classindesc               VARCHAR2(1) NOT NULL,
    usel3classindesc               VARCHAR2(1) NOT NULL,
    usel4classindesc               VARCHAR2(1) NOT NULL,
    usel5classindesc               VARCHAR2(1) NOT NULL,
    ldkey                          NUMBER,
    acs01                          VARCHAR2(1),
    acs02                          VARCHAR2(1),
    acs03                          VARCHAR2(1),
    acs04                          VARCHAR2(1),
    acs05                          VARCHAR2(1),
    orgid                          VARCHAR2(8) NOT NULL)
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Indexes for CLASSSTRUCTURE

CREATE UNIQUE INDEX classstruct_ndx1 ON classstructure
  (
    orgid                           ASC,
    classstructureid                ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/
CREATE UNIQUE INDEX classstruct_ndx2 ON classstructure
  (
    orgid                           ASC,
    l1classificationid              ASC,
    l2classificationid              ASC,
    l3classificationid              ASC,
    l4classificationid              ASC,
    l5classificationid              ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/


-- Triggers for CLASSSTRUCTURE

CREATE TRIGGER classstructure_t
BEFORE INSERT  OR UPDATE 
ON classstructure
REFERENCING NEW AS NEW OLD AS OLD
FOR EACH ROW
DECLARE 
NEXTVAL INTEGER; BEGIN SELECT MAXSEQ.NEXTVAL INTO NEXTVAL FROM DUAL; 
:NEW.ROWSTAMP := NEXTVAL; END;
/
CREATE TRIGGER classstructure_verity_t
AFTER UPDATE 
ON classstructure
REFERENCING NEW AS NEW OLD AS OLD
FOR EACH ROW
Declare	 	Cursor C_Item Is 		Select itemnum,orgid 		From   item 		Where  classstructureid = :new.classstructureid 		And    orgid = :new.orgid;  	AutoPreFixSeed 	Varchar2(20); 	RecordCount	Number; 	ActionFlag	Varchar2(1); 	ItemFlag	Varchar2(30); Begin     Select  ltrim(rtrim(prefix))||seed    Into    AutoPreFixSeed    From    autokey    Where   tbname ='VERITYACTION';     For C0 in C_Item    loop 	Select  Count(*)     	Into    RecordCount    	From    verityaction    	Where   itemnum = c0.itemnum    	And 	action 	= 'U'    	And 	transid = AutoPreFixSeed 	And     orgid = c0.orgid;      	If      RecordCount = 0    	Then    Insert Into verityaction(itemnum,action,transid,orgid) 		Values 	   	( 	     	 c0.ItemNum, 	     	 'U', 	     	 AutoPreFixSeed, 		 c0.orgid  	   	);    	End If;    end loop; Exception 	When Others then 	   raise_application_error(-20001,'Failure Encountered in executing Trigger CLASSSTRUCTURE_VERITY_T'); End;
/

-- End of DDL Script for Table IFRMAXIMO.CLASSSTRUCTURE

-- Start of DDL Script for Table IFRMAXIMO.COMMODITYAUTH
-- Generated 9-mar-2004 19:59:51 from SYSMAN@MAQUINA4

CREATE TABLE commodityauth
    (rowstamp                       VARCHAR2(40) NOT NULL,
    grpname                        VARCHAR2(18) NOT NULL,
    classstructureid               VARCHAR2(20) NOT NULL,
    orgid                          VARCHAR2(8) NOT NULL)
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Indexes for COMMODITYAUTH

CREATE UNIQUE INDEX commodityauth_ndx1 ON commodityauth
  (
    orgid                           ASC,
    grpname                         ASC,
    classstructureid                ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/


-- Triggers for COMMODITYAUTH

CREATE TRIGGER commodityauth_t
BEFORE INSERT  OR UPDATE 
ON commodityauth
REFERENCING NEW AS NEW OLD AS OLD
FOR EACH ROW
DECLARE 
NEXTVAL INTEGER; BEGIN SELECT MAXSEQ.NEXTVAL INTO NEXTVAL FROM DUAL; 
:NEW.ROWSTAMP := NEXTVAL; END;
/

-- End of DDL Script for Table IFRMAXIMO.COMMODITYAUTH

-- Start of DDL Script for Table IFRMAXIMO.COMPANIES
-- Generated 9-mar-2004 19:59:59 from SYSMAN@MAQUINA4

CREATE TABLE companies
    (rowstamp                       VARCHAR2(40) NOT NULL,
    company                        VARCHAR2(18) NOT NULL,
    type                           VARCHAR2(1),
    name                           VARCHAR2(120),
    address1                       VARCHAR2(36),
    address2                       VARCHAR2(36),
    address3                       VARCHAR2(36),
    address4                       VARCHAR2(36),
    contact                        VARCHAR2(50),
    phone                          VARCHAR2(20),
    fob                            VARCHAR2(20),
    freightterms                   VARCHAR2(50),
    shipvia                        VARCHAR2(20),
    paymentterms                   VARCHAR2(20),
    customernum                    VARCHAR2(16),
    co1                            VARCHAR2(10),
    co2                            VARCHAR2(4),
    co3                            VARCHAR2(10),
    co4                            VARCHAR2(12),
    co5                            VARCHAR2(10),
    co6                            VARCHAR2(10),
    co7                            NUMBER(10,2),
    co8                            DATE,
    co9                            NUMBER,
    co10                           VARCHAR2(1),
    ldkey                          NUMBER,
    fax                            VARCHAR2(20),
    co11                           VARCHAR2(10),
    co12                           DATE,
    co13                           NUMBER(15,2),
    changeby                       VARCHAR2(18),
    changedate                     DATE,
    inclusive1                     VARCHAR2(1) NOT NULL,
    inclusive2                     VARCHAR2(1) NOT NULL,
    inclusive3                     VARCHAR2(1) NOT NULL,
    tax1code                       VARCHAR2(8),
    tax2code                       VARCHAR2(8),
    tax3code                       VARCHAR2(8),
    currencycode                   VARCHAR2(8) NOT NULL,
    location                       VARCHAR2(18),
    registration1                  VARCHAR2(20),
    registration2                  VARCHAR2(20),
    registration3                  VARCHAR2(20),
    apcontrolacc                   VARCHAR2(20),
    apsuspenseacc                  VARCHAR2(20),
    rbniacc                        VARCHAR2(20),
    payvendor                      VARCHAR2(18),
    bankaccount                    VARCHAR2(20),
    inclusive4                     VARCHAR2(1) NOT NULL,
    inclusive5                     VARCHAR2(1) NOT NULL,
    registration4                  VARCHAR2(20),
    registration5                  VARCHAR2(20),
    tax4code                       VARCHAR2(8),
    tax5code                       VARCHAR2(8),
    disabled                       VARCHAR2(1) NOT NULL,
    remitaddress1                  VARCHAR2(36),
    remitaddress2                  VARCHAR2(36),
    remitaddress3                  VARCHAR2(36),
    remitaddress4                  VARCHAR2(36),
    remitcontact                   VARCHAR2(50),
    payonreceipt                   VARCHAR2(1) NOT NULL,
    homepage                       VARCHAR2(124),
    banknum                        VARCHAR2(16),
    dunsnum                        VARCHAR2(16),
    taxexemptcode                  VARCHAR2(1),
    taxexemptnum                   VARCHAR2(20),
    ecommerceenabled               VARCHAR2(1) NOT NULL,
    mnetcompanyid                  VARCHAR2(50),
    co14                           VARCHAR2(10),
    co15                           VARCHAR2(10),
    co16                           VARCHAR2(10),
    co17                           VARCHAR2(10),
    co18                           VARCHAR2(10),
    sourcesysid                    VARCHAR2(10),
    ownersysid                     VARCHAR2(10),
    externalrefid                  VARCHAR2(10),
    apiseq                         VARCHAR2(50),
    interid                        VARCHAR2(50),
    migchangeid                    VARCHAR2(50),
    sendersysid                    VARCHAR2(50),
    autoreceiveonasn               VARCHAR2(1) NOT NULL,
    vendorsendsasn                 VARCHAR2(1) NOT NULL,
    vendorsendsinv                 VARCHAR2(1) NOT NULL,
    ecominterface                  VARCHAR2(30),
    mnetecomnum1                   VARCHAR2(30),
    mnetecomnum2                   VARCHAR2(1),
    mnetecomnum3                   VARCHAR2(1),
    mnetecomnum4                   VARCHAR2(1),
    vendorsendsstatus              VARCHAR2(1) NOT NULL,
    autoapproveinv                 VARCHAR2(1) NOT NULL,
    autosendpocancel               VARCHAR2(1) NOT NULL,
    defaultwarehouse               VARCHAR2(12),
    orgid                          VARCHAR2(8) NOT NULL,
    parentcompany                  VARCHAR2(18),
    useparentremitto               VARCHAR2(1) NOT NULL,
    address5                       VARCHAR2(50),
    remitaddress5                  VARCHAR2(50),
    catalogname                    VARCHAR2(50),
    punchoutenabled                VARCHAR2(1) NOT NULL)
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Indexes for COMPANIES

CREATE INDEX companies_ndx2 ON companies
  (
    orgid                           ASC,
    type                            ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/
CREATE INDEX companies_ndx3 ON companies
  (
    orgid                           ASC,
    interid                         ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/
CREATE UNIQUE INDEX company_ndx ON companies
  (
    orgid                           ASC,
    company                         ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/


-- Triggers for COMPANIES

CREATE TRIGGER companies_t
BEFORE INSERT  OR UPDATE 
ON companies
REFERENCING NEW AS NEW OLD AS OLD
FOR EACH ROW
DECLARE 
NEXTVAL INTEGER; BEGIN SELECT MAXSEQ.NEXTVAL INTO NEXTVAL FROM DUAL; 
:NEW.ROWSTAMP := NEXTVAL; END;
/
CREATE TRIGGER tr_cgc
BEFORE INSERT  OR UPDATE 
ON companies
REFERENCING NEW AS NEW OLD AS OLD
FOR EACH ROW
DECLARE
   erro1 exception;
   V_ERRO  BOOLEAN := FALSE;
BEGIN
   IF INSERTING THEN
      BEGIN
         Begin
            P_CGC(:NEW.COMPANY,V_ERRO);
            IF V_ERRO = FALSE THEN
               RAISE ERRO1;
            END IF;
         exception
            when erro1 then
               RAISE_APPLICATION_ERROR(-20655,'Inserção - Código de CGC Inválido.');
         end;
      END;
   ELSE
      BEGIN
         IF (:OLD.COMPANY) <> (:NEW.COMPANY) THEN
            Begin
               Begin
                   P_CGC(:NEW.COMPANY,V_ERRO);
                   IF V_ERRO = FALSE THEN
                      RAISE ERRO1;
                   END IF;
                exception
                   when erro1 then
                      RAISE_APPLICATION_ERROR(-20656,'Alteração - Código de CGC Inválido.');
                end;
             End;    
          END IF;
       END; 
   END IF; 
END;
/

-- End of DDL Script for Table IFRMAXIMO.COMPANIES

-- Start of DDL Script for Table IFRMAXIMO.COMPANYACCDEF
-- Generated 9-mar-2004 20:00:17 from SYSMAN@MAQUINA4

CREATE TABLE companyaccdef
    (rowstamp                       VARCHAR2(40) NOT NULL,
    type                           VARCHAR2(16) NOT NULL,
    rbniacc                        VARCHAR2(20),
    apcontrolacc                   VARCHAR2(20),
    apsuspenseacc                  VARCHAR2(20),
    oldrbniacc                     VARCHAR2(20),
    oldapcontrolacc                VARCHAR2(20),
    oldapsuspenseacc               VARCHAR2(20),
    orgid                          VARCHAR2(8) NOT NULL)
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Indexes for COMPANYACCDEF

CREATE UNIQUE INDEX cpnyacctdflt_ndx1 ON companyaccdef
  (
    orgid                           ASC,
    type                            ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/


-- Triggers for COMPANYACCDEF

CREATE TRIGGER companyaccdef_t
BEFORE INSERT  OR UPDATE 
ON companyaccdef
REFERENCING NEW AS NEW OLD AS OLD
FOR EACH ROW
DECLARE 
NEXTVAL INTEGER; BEGIN SELECT MAXSEQ.NEXTVAL INTO NEXTVAL FROM DUAL; 
:NEW.ROWSTAMP := NEXTVAL; END;
/

-- End of DDL Script for Table IFRMAXIMO.COMPANYACCDEF

-- Start of DDL Script for Table IFRMAXIMO.COMPCONTACT
-- Generated 9-mar-2004 20:00:23 from SYSMAN@MAQUINA4

CREATE TABLE compcontact
    (rowstamp                       VARCHAR2(40) NOT NULL,
    company                        VARCHAR2(18) NOT NULL,
    contact                        VARCHAR2(50) NOT NULL,
    position                       VARCHAR2(24),
    voicephone                     VARCHAR2(20),
    faxphone                       VARCHAR2(20),
    email                          VARCHAR2(60),
    homephone                      VARCHAR2(20),
    pagerphone                     VARCHAR2(30),
    cnt1                           VARCHAR2(10),
    cnt2                           VARCHAR2(10),
    cnt3                           VARCHAR2(10),
    cnt4                           NUMBER(15,2),
    cnt5                           NUMBER,
    procurementcardnum             VARCHAR2(30),
    proccardexpiredate             DATE,
    mnetuserid                     VARCHAR2(50),
    orgid                          VARCHAR2(8) NOT NULL)
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Indexes for COMPCONTACT

CREATE UNIQUE INDEX compcontact_ndx1 ON compcontact
  (
    orgid                           ASC,
    company                         ASC,
    contact                         ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/


-- Triggers for COMPCONTACT

CREATE TRIGGER compcontact_t
BEFORE INSERT  OR UPDATE 
ON compcontact
REFERENCING NEW AS NEW OLD AS OLD
FOR EACH ROW
DECLARE 
NEXTVAL INTEGER; BEGIN SELECT MAXSEQ.NEXTVAL INTO NEXTVAL FROM DUAL; 
:NEW.ROWSTAMP := NEXTVAL; END;
/

-- End of DDL Script for Table IFRMAXIMO.COMPCONTACT

-- Start of DDL Script for Table IFRMAXIMO.CONTADOR
-- Generated 9-mar-2004 20:00:30 from SYSMAN@MAQUINA4

CREATE TABLE contador
    (total                          NUMBER)
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- End of DDL Script for Table IFRMAXIMO.CONTADOR

-- Start of DDL Script for Table IFRMAXIMO.CROSSOVERDOMAIN
-- Generated 9-mar-2004 20:00:32 from SYSMAN@MAQUINA4

CREATE TABLE crossoverdomain
    (rowstamp                       VARCHAR2(40) NOT NULL,
    domainid                       VARCHAR2(18) NOT NULL,
    sourcefield                    VARCHAR2(30) NOT NULL,
    destfield                      VARCHAR2(30) NOT NULL,
    copyifnull                     VARCHAR2(1) NOT NULL)
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Indexes for CROSSOVERDOMAIN

CREATE UNIQUE INDEX crossover_ndx1 ON crossoverdomain
  (
    domainid                        ASC,
    sourcefield                     ASC,
    destfield                       ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/


-- Triggers for CROSSOVERDOMAIN

CREATE TRIGGER crossoverdomain_t
BEFORE INSERT  OR UPDATE 
ON crossoverdomain
REFERENCING NEW AS NEW OLD AS OLD
FOR EACH ROW
DECLARE 
NEXTVAL INTEGER; BEGIN SELECT MAXSEQ.NEXTVAL INTO NEXTVAL FROM DUAL; 
:NEW.ROWSTAMP := NEXTVAL; END;
/

-- End of DDL Script for Table IFRMAXIMO.CROSSOVERDOMAIN

-- Start of DDL Script for Table IFRMAXIMO.CURRENCY
-- Generated 9-mar-2004 20:00:37 from SYSMAN@MAQUINA4

CREATE TABLE currency
    (rowstamp                       VARCHAR2(40) NOT NULL,
    currencycode                   VARCHAR2(8) NOT NULL,
    description                    VARCHAR2(40),
    active                         VARCHAR2(1) NOT NULL,
    lastused                       DATE,
    changedate                     DATE NOT NULL,
    changeby                       VARCHAR2(18) NOT NULL,
    ldkey                          NUMBER,
    currency1                      VARCHAR2(1),
    currency2                      VARCHAR2(1),
    currency3                      VARCHAR2(1),
    currency4                      VARCHAR2(1))
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Indexes for CURRENCY

CREATE UNIQUE INDEX currency_ndx ON currency
  (
    currencycode                    ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/


-- Triggers for CURRENCY

CREATE TRIGGER currency_t
BEFORE INSERT  OR UPDATE 
ON currency
REFERENCING NEW AS NEW OLD AS OLD
FOR EACH ROW
DECLARE 
NEXTVAL INTEGER; BEGIN SELECT MAXSEQ.NEXTVAL INTO NEXTVAL FROM DUAL; 
:NEW.ROWSTAMP := NEXTVAL; END;
/

-- End of DDL Script for Table IFRMAXIMO.CURRENCY

-- Start of DDL Script for Table IFRMAXIMO.DEFAULTQUERY
-- Generated 9-mar-2004 20:00:43 from SYSMAN@MAQUINA4

CREATE TABLE defaultquery
    (rowstamp                       VARCHAR2(40) NOT NULL,
    username                       VARCHAR2(18) NOT NULL,
    app                            VARCHAR2(10) NOT NULL,
    clausename                     VARCHAR2(15) NOT NULL,
    siteid                         VARCHAR2(8) NOT NULL,
    orgid                          VARCHAR2(8) NOT NULL)
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Indexes for DEFAULTQUERY

CREATE UNIQUE INDEX defaultquery_ndx1 ON defaultquery
  (
    siteid                          ASC,
    username                        ASC,
    app                             ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/


-- Triggers for DEFAULTQUERY

CREATE TRIGGER defaultquery_t
BEFORE INSERT  OR UPDATE 
ON defaultquery
REFERENCING NEW AS NEW OLD AS OLD
FOR EACH ROW
DECLARE 
NEXTVAL INTEGER; BEGIN SELECT MAXSEQ.NEXTVAL INTO NEXTVAL FROM DUAL; 
:NEW.ROWSTAMP := NEXTVAL; END;
/

-- End of DDL Script for Table IFRMAXIMO.DEFAULTQUERY

-- Start of DDL Script for Table IFRMAXIMO.DEPENDENCIA
-- Generated 9-mar-2004 20:00:51 from SYSMAN@MAQUINA4

CREATE TABLE dependencia
    (superintendencia               VARCHAR2(4) NOT NULL,
    supdescription                 VARCHAR2(100) NOT NULL,
    aeroporto                      VARCHAR2(18) NOT NULL,
    aerodescription                VARCHAR2(100) NOT NULL,
    hsfunciona                     NUMBER(2),
    dep1                           VARCHAR2(10),
    dep2                           NUMBER(4),
    dep3                           VARCHAR2(10),
    dep4                           VARCHAR2(10),
    dep5                           VARCHAR2(10))
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Constraints for DEPENDENCIA

ALTER TABLE dependencia
ADD PRIMARY KEY (aeroporto)
USING INDEX
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/

-- End of DDL Script for Table IFRMAXIMO.DEPENDENCIA

-- Start of DDL Script for Table IFRMAXIMO.DESKTOPDFLTS
-- Generated 9-mar-2004 20:00:57 from SYSMAN@MAQUINA4

CREATE TABLE desktopdflts
    (rowstamp                       VARCHAR2(40) NOT NULL,
    username                       VARCHAR2(18) NOT NULL,
    app                            VARCHAR2(10) NOT NULL,
    screen                         VARCHAR2(10),
    initstate                      NUMBER,
    isopen                         NUMBER,
    alwaysontop                    NUMBER,
    saveonexit                     NUMBER,
    toppos                         NUMBER,
    leftpos                        NUMBER,
    bottompos                      NUMBER,
    rightpos                       NUMBER)
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Indexes for DESKTOPDFLTS

CREATE UNIQUE INDEX desktopdflts_ndx ON desktopdflts
  (
    username                        ASC,
    app                             ASC,
    screen                          ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/


-- Triggers for DESKTOPDFLTS

CREATE TRIGGER desktopdflts_t
BEFORE INSERT  OR UPDATE 
ON desktopdflts
REFERENCING NEW AS NEW OLD AS OLD
FOR EACH ROW
DECLARE 
NEXTVAL INTEGER; BEGIN SELECT MAXSEQ.NEXTVAL INTO NEXTVAL FROM DUAL; 
:NEW.ROWSTAMP := NEXTVAL; END;
/

-- End of DDL Script for Table IFRMAXIMO.DESKTOPDFLTS

-- Start of DDL Script for Table IFRMAXIMO.DMSAPISETTING
-- Generated 9-mar-2004 20:01:02 from SYSMAN@MAQUINA4

CREATE TABLE dmsapisetting
    (rowstamp                       VARCHAR2(40) NOT NULL,
    dmsname                        VARCHAR2(30) NOT NULL,
    useparameter1                  VARCHAR2(1) NOT NULL,
    useparameter2                  VARCHAR2(1) NOT NULL,
    useparameter3                  VARCHAR2(1) NOT NULL,
    useparameter4                  VARCHAR2(1) NOT NULL,
    useparameter5                  VARCHAR2(1) NOT NULL)
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Indexes for DMSAPISETTING

CREATE UNIQUE INDEX dmsapisetting_ndx1 ON dmsapisetting
  (
    dmsname                         ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/


-- Triggers for DMSAPISETTING

CREATE TRIGGER dmsapisetting_t
BEFORE INSERT  OR UPDATE 
ON dmsapisetting
REFERENCING NEW AS NEW OLD AS OLD
FOR EACH ROW
DECLARE 
NEXTVAL INTEGER; BEGIN SELECT MAXSEQ.NEXTVAL INTO NEXTVAL FROM DUAL; 
:NEW.ROWSTAMP := NEXTVAL; END;
/

-- End of DDL Script for Table IFRMAXIMO.DMSAPISETTING

-- Start of DDL Script for Table IFRMAXIMO.DOCINFO
-- Generated 9-mar-2004 20:01:09 from SYSMAN@MAQUINA4

CREATE TABLE docinfo
    (rowstamp                       VARCHAR2(40) NOT NULL,
    document                       VARCHAR2(8) NOT NULL,
    description                    VARCHAR2(254),
    application                    VARCHAR2(8),
    status                         VARCHAR2(8),
    statusdate                     DATE,
    createdate                     DATE,
    revision                       NUMBER,
    extra1                         VARCHAR2(1),
    extra2                         VARCHAR2(1),
    extra3                         VARCHAR2(1),
    extra4                         VARCHAR2(1),
    extra5                         VARCHAR2(1),
    ldkey                          NUMBER,
    changeby                       VARCHAR2(18),
    changedate                     DATE,
    doclocation                    VARCHAR2(10),
    doctype                        VARCHAR2(8) NOT NULL,
    createby                       VARCHAR2(18),
    urltype                        VARCHAR2(8) NOT NULL,
    dmsname                        VARCHAR2(30),
    urlname                        VARCHAR2(124) NOT NULL,
    urlparam1                      VARCHAR2(32),
    urlparam2                      VARCHAR2(32),
    urlparam3                      VARCHAR2(8),
    urlparam4                      VARCHAR2(8),
    urlparam5                      VARCHAR2(8),
    printthrulinkdflt              VARCHAR2(1) NOT NULL,
    usedefaultfilepath             VARCHAR2(1) NOT NULL,
    siteid                         VARCHAR2(8) NOT NULL,
    orgid                          VARCHAR2(8) NOT NULL)
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Indexes for DOCINFO

CREATE UNIQUE INDEX docinfo_ndx1 ON docinfo
  (
    siteid                          ASC,
    document                        ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/


-- Triggers for DOCINFO

CREATE TRIGGER docinfo_t
BEFORE INSERT  OR UPDATE 
ON docinfo
REFERENCING NEW AS NEW OLD AS OLD
FOR EACH ROW
DECLARE 
NEXTVAL INTEGER; BEGIN SELECT MAXSEQ.NEXTVAL INTO NEXTVAL FROM DUAL; 
:NEW.ROWSTAMP := NEXTVAL; END;
/

-- End of DDL Script for Table IFRMAXIMO.DOCINFO

-- Start of DDL Script for Table IFRMAXIMO.DOCLINKS
-- Generated 9-mar-2004 20:01:16 from SYSMAN@MAQUINA4

CREATE TABLE doclinks
    (rowstamp                       VARCHAR2(40) NOT NULL,
    document                       VARCHAR2(8) NOT NULL,
    keytable                       VARCHAR2(18) NOT NULL,
    keycolumn                      VARCHAR2(18) NOT NULL,
    keyvalue                       VARCHAR2(50) NOT NULL,
    reference                      VARCHAR2(8),
    doctype                        VARCHAR2(8) NOT NULL,
    docversion                     VARCHAR2(20),
    getlatestversion               VARCHAR2(1) NOT NULL,
    createby                       VARCHAR2(18),
    createdate                     DATE,
    changeby                       VARCHAR2(18),
    changedate                     DATE,
    printthrulink                  VARCHAR2(1) NOT NULL,
    dl1                            VARCHAR2(10),
    dl2                            VARCHAR2(10),
    dl3                            VARCHAR2(10),
    dl4                            DATE,
    dl5                            NUMBER,
    copylinktowo                   VARCHAR2(1) NOT NULL,
    siteid                         VARCHAR2(8) NOT NULL,
    orgid                          VARCHAR2(8) NOT NULL)
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Indexes for DOCLINKS

CREATE UNIQUE INDEX doclinks_ndx1 ON doclinks
  (
    siteid                          ASC,
    document                        ASC,
    keytable                        ASC,
    keycolumn                       ASC,
    keyvalue                        ASC,
    doctype                         ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/
CREATE INDEX doclinks_ndx2 ON doclinks
  (
    siteid                          ASC,
    document                        ASC,
    reference                       ASC,
    keyvalue                        ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/
CREATE INDEX doclinks_ndx3 ON doclinks
  (
    siteid                          ASC,
    keytable                        ASC,
    keycolumn                       ASC,
    keyvalue                        ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/


-- Triggers for DOCLINKS

CREATE TRIGGER doclinks_t
BEFORE INSERT  OR UPDATE 
ON doclinks
REFERENCING NEW AS NEW OLD AS OLD
FOR EACH ROW
DECLARE 
NEXTVAL INTEGER; BEGIN SELECT MAXSEQ.NEXTVAL INTO NEXTVAL FROM DUAL; 
:NEW.ROWSTAMP := NEXTVAL; END;
/

-- End of DDL Script for Table IFRMAXIMO.DOCLINKS

-- Start of DDL Script for Table IFRMAXIMO.DOCTYPES
-- Generated 9-mar-2004 20:01:30 from SYSMAN@MAQUINA4

CREATE TABLE doctypes
    (rowstamp                       VARCHAR2(40) NOT NULL,
    doctype                        VARCHAR2(8) NOT NULL,
    description                    VARCHAR2(50),
    defaultfilepath                VARCHAR2(50),
    dt1                            VARCHAR2(10),
    dt2                            VARCHAR2(10),
    dt3                            VARCHAR2(10),
    dt4                            NUMBER(15,2),
    dt5                            NUMBER,
    siteid                         VARCHAR2(8) NOT NULL,
    orgid                          VARCHAR2(8) NOT NULL)
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Indexes for DOCTYPES

CREATE UNIQUE INDEX doctypes_ndx1 ON doctypes
  (
    siteid                          ASC,
    doctype                         ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/


-- Triggers for DOCTYPES

CREATE TRIGGER doctypes_t
BEFORE INSERT  OR UPDATE 
ON doctypes
REFERENCING NEW AS NEW OLD AS OLD
FOR EACH ROW
DECLARE 
NEXTVAL INTEGER; BEGIN SELECT MAXSEQ.NEXTVAL INTO NEXTVAL FROM DUAL; 
:NEW.ROWSTAMP := NEXTVAL; END;
/

-- End of DDL Script for Table IFRMAXIMO.DOCTYPES

-- Start of DDL Script for Table IFRMAXIMO.DUMMY_TABLE
-- Generated 9-mar-2004 20:01:38 from SYSMAN@MAQUINA4

CREATE TABLE dummy_table
    (rowstamp                       VARCHAR2(40) NOT NULL,
    dummy_aln                      VARCHAR2(50),
    dummy_integer                  NUMBER,
    dummy_smallint                 NUMBER,
    dummy_decimal                  NUMBER(15,2),
    dummy_amount                   NUMBER(10,2),
    dummy_float                    FLOAT(126),
    dummy_yorn                     VARCHAR2(1) NOT NULL,
    dummy_upper                    VARCHAR2(50),
    dummy_lower                    VARCHAR2(50),
    dummy_date                     DATE,
    dummy_time                     DATE,
    dummy_datetime                 DATE,
    dummy_duration                 FLOAT(126))
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Indexes for DUMMY_TABLE

CREATE UNIQUE INDEX dummy_table_ndx1 ON dummy_table
  (
    dummy_aln                       ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/


-- Triggers for DUMMY_TABLE

CREATE TRIGGER dummy_table_t
BEFORE INSERT  OR UPDATE 
ON dummy_table
REFERENCING NEW AS NEW OLD AS OLD
FOR EACH ROW
DECLARE 
NEXTVAL INTEGER; BEGIN SELECT MAXSEQ.NEXTVAL INTO NEXTVAL FROM DUAL; 
:NEW.ROWSTAMP := NEXTVAL; END;
/

-- End of DDL Script for Table IFRMAXIMO.DUMMY_TABLE

-- Start of DDL Script for Table IFRMAXIMO.EQHIERARCHY
-- Generated 9-mar-2004 20:01:45 from SYSMAN@MAQUINA4

CREATE TABLE eqhierarchy
    (rowstamp                       VARCHAR2(40) NOT NULL,
    eqnum                          VARCHAR2(12) NOT NULL,
    parent                         VARCHAR2(12),
    wonum                          VARCHAR2(18) NOT NULL,
    location                       VARCHAR2(18),
    siteid                         VARCHAR2(8) NOT NULL,
    orgid                          VARCHAR2(8) NOT NULL)
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Indexes for EQHIERARCHY

CREATE UNIQUE INDEX eqhier_ndx ON eqhierarchy
  (
    siteid                          ASC,
    wonum                           ASC,
    eqnum                           ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/


-- Triggers for EQHIERARCHY

CREATE TRIGGER eqhierarchy_t
BEFORE INSERT  OR UPDATE 
ON eqhierarchy
REFERENCING NEW AS NEW OLD AS OLD
FOR EACH ROW
DECLARE 
NEXTVAL INTEGER; BEGIN SELECT MAXSEQ.NEXTVAL INTO NEXTVAL FROM DUAL; 
:NEW.ROWSTAMP := NEXTVAL; END;
/

-- End of DDL Script for Table IFRMAXIMO.EQHIERARCHY

-- Start of DDL Script for Table IFRMAXIMO.EQHISTORY
-- Generated 9-mar-2004 20:01:51 from SYSMAN@MAQUINA4

CREATE TABLE eqhistory
    (rowstamp                       VARCHAR2(40) NOT NULL,
    eqnum                          VARCHAR2(12) NOT NULL,
    wonum                          VARCHAR2(18) NOT NULL,
    meterreading                   NUMBER(15,2) NOT NULL,
    readingdate                    DATE,
    totalcost                      NUMBER(10,2),
    ytdcost                        NUMBER(10,2),
    totunchargedcost               NUMBER(10,2),
    budgetcost                     NUMBER(10,2),
    ldkey                          NUMBER,
    meterreading2                  NUMBER(15,2) NOT NULL,
    readingdate2                   DATE,
    siteid                         VARCHAR2(8) NOT NULL,
    orgid                          VARCHAR2(8) NOT NULL)
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Indexes for EQHISTORY

CREATE INDEX eqhist_ndx1 ON eqhistory
  (
    siteid                          ASC,
    wonum                           ASC,
    eqnum                           ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/
CREATE INDEX eqhist_ndx2 ON eqhistory
  (
    eqnum                           ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/


-- Triggers for EQHISTORY

CREATE TRIGGER eqhistory_t
BEFORE INSERT  OR UPDATE 
ON eqhistory
REFERENCING NEW AS NEW OLD AS OLD
FOR EACH ROW
DECLARE 
NEXTVAL INTEGER; BEGIN SELECT MAXSEQ.NEXTVAL INTO NEXTVAL FROM DUAL; 
:NEW.ROWSTAMP := NEXTVAL; END;
/

-- End of DDL Script for Table IFRMAXIMO.EQHISTORY

-- Start of DDL Script for Table IFRMAXIMO.EQSTATUS
-- Generated 9-mar-2004 20:02:03 from SYSMAN@MAQUINA4

CREATE TABLE eqstatus
    (rowstamp                       VARCHAR2(40) NOT NULL,
    eqnum                          VARCHAR2(12) NOT NULL,
    wonum                          VARCHAR2(18) NOT NULL,
    isrunning                      VARCHAR2(1) NOT NULL,
    changedate                     DATE NOT NULL,
    changeby                       VARCHAR2(18) NOT NULL,
    downtime                       FLOAT(126) NOT NULL,
    calnum                         VARCHAR2(8),
    ldkey                          NUMBER,
    code                           VARCHAR2(10),
    operational                    VARCHAR2(1) NOT NULL,
    location                       VARCHAR2(18),
    siteid                         VARCHAR2(8) NOT NULL,
    orgid                          VARCHAR2(8) NOT NULL)
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Indexes for EQSTATUS

CREATE INDEX eqstatus_ndx1 ON eqstatus
  (
    siteid                          ASC,
    changedate                      ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/
CREATE INDEX eqstatus_ndx2 ON eqstatus
  (
    siteid                          ASC,
    eqnum                           ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/
CREATE INDEX eqstatus_ndx3 ON eqstatus
  (
    siteid                          ASC,
    isrunning                       ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/
CREATE INDEX eqstatus_ndx4 ON eqstatus
  (
    siteid                          ASC,
    wonum                           ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/


-- Triggers for EQSTATUS

CREATE TRIGGER eqstatus_t
BEFORE INSERT  OR UPDATE 
ON eqstatus
REFERENCING NEW AS NEW OLD AS OLD
FOR EACH ROW
DECLARE 
NEXTVAL INTEGER; BEGIN SELECT MAXSEQ.NEXTVAL INTO NEXTVAL FROM DUAL; 
:NEW.ROWSTAMP := NEXTVAL; END;
/

-- End of DDL Script for Table IFRMAXIMO.EQSTATUS

-- Start of DDL Script for Table IFRMAXIMO.EQTRANS
-- Generated 9-mar-2004 20:02:22 from SYSMAN@MAQUINA4

CREATE TABLE eqtrans
    (rowstamp                       VARCHAR2(40) NOT NULL,
    eqnum                          VARCHAR2(12) NOT NULL,
    datemoved                      DATE NOT NULL,
    fromparent                     VARCHAR2(12),
    toparent                       VARCHAR2(12),
    fromloc                        VARCHAR2(18),
    toloc                          VARCHAR2(18),
    glcreditacct                   VARCHAR2(20),
    gldebitacct                    VARCHAR2(20),
    transdate                      DATE NOT NULL,
    enterby                        VARCHAR2(18) NOT NULL,
    memo                           VARCHAR2(254),
    wonum                          VARCHAR2(18),
    ponum                          VARCHAR2(8),
    eqt1                           VARCHAR2(10),
    eqt2                           VARCHAR2(10),
    eqt3                           VARCHAR2(10),
    eqt4                           VARCHAR2(10),
    eqt5                           VARCHAR2(10),
    eqt6                           NUMBER(10,2),
    eqt7                           DATE,
    eqt8                           NUMBER(15,2),
    eqt9                           VARCHAR2(10),
    eqt10                          NUMBER,
    meterreading                   NUMBER(15,2),
    meterreading2                  NUMBER(15,2),
    readingdate                    DATE,
    readingdate2                   DATE,
    eqtransid                      NUMBER NOT NULL,
    matrectransid                  NUMBER,
    matusetransid                  NUMBER,
    sourcesysid                    VARCHAR2(10),
    ownersysid                     VARCHAR2(10),
    externalrefid                  VARCHAR2(10),
    siteid                         VARCHAR2(8) NOT NULL,
    orgid                          VARCHAR2(8) NOT NULL,
    tositeid                       VARCHAR2(8) NOT NULL)
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Indexes for EQTRANS

CREATE INDEX eqtrans_ndx1 ON eqtrans
  (
    siteid                          ASC,
    transdate                       ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/
CREATE INDEX eqtrans_ndx2 ON eqtrans
  (
    siteid                          ASC,
    eqnum                           ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/


-- Triggers for EQTRANS

CREATE TRIGGER eqtrans_t
BEFORE INSERT  OR UPDATE 
ON eqtrans
REFERENCING NEW AS NEW OLD AS OLD
FOR EACH ROW
DECLARE 
NEXTVAL INTEGER; BEGIN SELECT MAXSEQ.NEXTVAL INTO NEXTVAL FROM DUAL; 
:NEW.ROWSTAMP := NEXTVAL; END;
/

-- End of DDL Script for Table IFRMAXIMO.EQTRANS

-- Start of DDL Script for Table IFRMAXIMO.EQUIPAMENTO
-- Generated 9-mar-2004 20:02:33 from SYSMAN@MAQUINA4

CREATE TABLE equipamento
    (eqnum                          VARCHAR2(4),
    description                    VARCHAR2(100),
    sistema                        VARCHAR2(10),
    descsistema                    VARCHAR2(100),
    subsistema                     VARCHAR2(10),
    descsubsistema                 VARCHAR2(200),
    equip01                        VARCHAR2(10),
    equip02                        VARCHAR2(10),
    equip03                        VARCHAR2(10),
    equip04                        VARCHAR2(10),
    equip05                        VARCHAR2(10))
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- End of DDL Script for Table IFRMAXIMO.EQUIPAMENTO

-- Start of DDL Script for Table IFRMAXIMO.EQUIPMENT
-- Generated 9-mar-2004 20:02:34 from SYSMAN@MAQUINA4

CREATE TABLE equipment
    (rowstamp                       VARCHAR2(40) NOT NULL,
    eqnum                          VARCHAR2(12) NOT NULL,
    parent                         VARCHAR2(12),
    serialnum                      VARCHAR2(15),
    assetnum                       VARCHAR2(15) NOT NULL,
    location                       VARCHAR2(18),
    description                    VARCHAR2(120),
    vendor                         VARCHAR2(18),
    failurecode                    VARCHAR2(8),
    manufacturer                   VARCHAR2(18),
    purchaseprice                  NUMBER(10,2) NOT NULL,
    replacecost                    NUMBER(10,2) NOT NULL,
    installdate                    DATE,
    warrantyexpdate                DATE,
    meterreading                   NUMBER(15,2) NOT NULL,
    avgmeterunit                   NUMBER(15,2) NOT NULL,
    totalcost                      NUMBER(10,2) NOT NULL,
    ytdcost                        NUMBER(10,2) NOT NULL,
    budgetcost                     NUMBER(10,2) NOT NULL,
    classification                 VARCHAR2(10),
    calnum                         VARCHAR2(8),
    isrunning                      VARCHAR2(1) NOT NULL,
    itemnum                        VARCHAR2(30),
    readingdate                    DATE,
    unchargedcost                  NUMBER(10,2) NOT NULL,
    totunchargedcost               NUMBER(10,2) NOT NULL,
    totdowntime                    FLOAT(126) NOT NULL,
    statusdate                     DATE,
    changedate                     DATE NOT NULL,
    changeby                       VARCHAR2(18) NOT NULL,
    eq1                            VARCHAR2(1),
    eq2                            VARCHAR2(50),
    eq3                            VARCHAR2(1),
    eq4                            VARCHAR2(1),
    eq5                            VARCHAR2(1),
    eq6                            VARCHAR2(1),
    eq7                            NUMBER(15,2),
    eq8                            VARCHAR2(3),
    eq9                            VARCHAR2(10),
    eq10                           VARCHAR2(3),
    eq11                           VARCHAR2(3),
    eq12                           VARCHAR2(3),
    eq13                           VARCHAR2(10),
    eq14                           VARCHAR2(10),
    eq15                           VARCHAR2(10),
    eq16                           VARCHAR2(10),
    eq17                           VARCHAR2(10),
    eq18                           NUMBER(10,2),
    eq19                           DATE,
    eq20                           NUMBER(15,2),
    eq21                           VARCHAR2(10),
    eq22                           VARCHAR2(1),
    ldkey                          NUMBER,
    meterreading2                  NUMBER(15,2) NOT NULL,
    avgmeterunit2                  NUMBER(15,2) NOT NULL,
    meterlabel1                    VARCHAR2(10),
    meterlabel2                    VARCHAR2(10),
    meterunit1                     VARCHAR2(10),
    meterunit2                     VARCHAR2(10),
    readingdate2                   DATE,
    eq23                           DATE,
    eq24                           NUMBER(15,2),
    priority                       NUMBER,
    invcost                        NUMBER(10,2) NOT NULL,
    glaccount                      VARCHAR2(20),
    rotsuspacct                    VARCHAR2(20),
    children                       VARCHAR2(1) NOT NULL,
    binnum                         VARCHAR2(8),
    disabled                       VARCHAR2(1) NOT NULL,
    classstructureid               VARCHAR2(20),
    inheritmeter1chang             VARCHAR2(1) NOT NULL,
    inheritmeter2chang             VARCHAR2(1) NOT NULL,
    meter1weightprcnt              NUMBER(5,2) NOT NULL,
    meter2weightprcnt              NUMBER(5,2) NOT NULL,
    importdeltameter1              VARCHAR2(1) NOT NULL,
    importdeltameter2              VARCHAR2(1) NOT NULL,
    sourcesysid                    VARCHAR2(10),
    ownersysid                     VARCHAR2(10),
    externalrefid                  VARCHAR2(10),
    siteid                         VARCHAR2(8) NOT NULL,
    orgid                          VARCHAR2(8) NOT NULL,
    rollover1                      NUMBER(15,2),
    rollover2                      NUMBER(15,2))
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Indexes for EQUIPMENT

CREATE UNIQUE INDEX equipment_ndx1 ON equipment
  (
    siteid                          ASC,
    eqnum                           ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/
CREATE INDEX equipment_ndx2 ON equipment
  (
    siteid                          ASC,
    parent                          ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/
CREATE INDEX equipment_ndx3 ON equipment
  (
    siteid                          ASC,
    vendor                          ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/
CREATE INDEX equipment_ndx4 ON equipment
  (
    siteid                          ASC,
    calnum                          ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/
CREATE INDEX equipment_ndx5 ON equipment
  (
    siteid                          ASC,
    itemnum                         ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/
CREATE INDEX equipment_ndx6 ON equipment
  (
    siteid                          ASC,
    location                        ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/


-- Triggers for EQUIPMENT

CREATE TRIGGER equipment_t
BEFORE INSERT  OR UPDATE 
ON equipment
REFERENCING NEW AS NEW OLD AS OLD
FOR EACH ROW
DECLARE 
NEXTVAL INTEGER; BEGIN SELECT MAXSEQ.NEXTVAL INTO NEXTVAL FROM DUAL; 
:NEW.ROWSTAMP := NEXTVAL; END;
/
CREATE TRIGGER tr_eqnum
BEFORE INSERT 
ON equipment
REFERENCING NEW AS NEW OLD AS OLD
FOR EACH ROW
DECLARE
  V_COUNT   NUMBER(5)  :=0;
  V_NUMERO  VARCHAR2(6):='';
  V_SIGLA   IFRMAXIMO.DEPENDENCIA.AEROPORTO%TYPE :='';
  DEP       IFRMAXIMO.EQUIPMENT.EQNUM%TYPE :='';
  VERIFICACAO VARCHAR2(2):= '0';
BEGIN
      SELECT COUNT(EQNUM)
      INTO   V_COUNT
      FROM   IFRMAXIMO.EQUIPAMENTO
      WHERE EQNUM = SUBSTR(:NEW.EQNUM,1,4);
      IF V_COUNT = 0 THEN
         RAISE_APPLICATION_ERROR(-20645,'CÓDIGO INVÁLIDO - QUATRO PRIMEIRAS POSIÇÕES SÃO INVÁLIDAS.');
      END IF;
   IF V_COUNT <> 0 THEN
      BEGIN
  SELECT A.NUMERO
  INTO V_NUMERO
  FROM IFRMAXIMO.NUMERO A
  WHERE A.NUMERO = SUBSTR(:NEW.EQNUM,5,4);
      EXCEPTION
     WHEN NO_DATA_FOUND THEN
     RAISE_APPLICATION_ERROR(-20646,'CÓDIGO INVÁLIDO - VERIFIQUE SEQUENCIAL NUMÉRICO.');
      END;
   END IF;
   BEGIN
      SELECT DISTINCT B.AEROPORTO
      INTO V_SIGLA
      FROM IFRMAXIMO.DEPENDENCIA B
      WHERE SUBSTR(B.AEROPORTO,3,2) = SUBSTR(:NEW.EQNUM,9,2);
   EXCEPTION
      WHEN NO_DATA_FOUND THEN
         BEGIN
            SELECT DISTINCT B.AEROPORTO
            INTO V_SIGLA
            FROM IFRMAXIMO.DEPENDENCIA B
            WHERE B.DEP1 = SUBSTR(:NEW.EQNUM,9,3);
         EXCEPTION
            WHEN NO_DATA_FOUND THEN
               RAISE_APPLICATION_ERROR(-20647,'SIGLA DA DEPENDÊNCIA INVÁLIDA.');
         END;
   END;
   BEGIN
      SELECT DISTINCT E.DESCRIPTION
      INTO :NEW.DESCRIPTION
      FROM EQUIPAMENTO E
      WHERE E.EQNUM    = SUBSTR(:NEW.EQNUM,1,4);
   EXCEPTION
      WHEN OTHERS THEN
         RAISE_APPLICATION_ERROR(-20648,'ERRO :',TRUE);
   END;
END;
/

-- End of DDL Script for Table IFRMAXIMO.EQUIPMENT

-- Start of DDL Script for Table IFRMAXIMO.EQUIPMENTSPEC
-- Generated 9-mar-2004 20:03:03 from SYSMAN@MAQUINA4

CREATE TABLE equipmentspec
    (rowstamp                       VARCHAR2(40) NOT NULL,
    eqnum                          VARCHAR2(12) NOT NULL,
    assetattrid                    VARCHAR2(8) NOT NULL,
    classstructureid               VARCHAR2(20) NOT NULL,
    inheritedfromitem              VARCHAR2(1) NOT NULL,
    itemspecvalchanged             VARCHAR2(1) NOT NULL,
    displaysequence                NUMBER NOT NULL,
    numvalue                       NUMBER(10,2),
    measureunitid                  VARCHAR2(8),
    alnvalue                       VARCHAR2(16),
    changedate                     DATE NOT NULL,
    changeby                       VARCHAR2(18) NOT NULL,
    es01                           VARCHAR2(10),
    es02                           VARCHAR2(10),
    es03                           VARCHAR2(10),
    es04                           DATE,
    es05                           NUMBER(15,2),
    siteid                         VARCHAR2(8) NOT NULL,
    orgid                          VARCHAR2(8) NOT NULL)
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Indexes for EQUIPMENTSPEC

CREATE UNIQUE INDEX eqspec_ndx1 ON equipmentspec
  (
    siteid                          ASC,
    eqnum                           ASC,
    assetattrid                     ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/
CREATE INDEX eqspec_ndx2 ON equipmentspec
  (
    siteid                          ASC,
    classstructureid                ASC,
    assetattrid                     ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/
CREATE INDEX eqspec_ndx3 ON equipmentspec
  (
    siteid                          ASC,
    assetattrid                     ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/


-- Triggers for EQUIPMENTSPEC

CREATE TRIGGER equipmentspec_t
BEFORE INSERT  OR UPDATE 
ON equipmentspec
REFERENCING NEW AS NEW OLD AS OLD
FOR EACH ROW
DECLARE 
NEXTVAL INTEGER; BEGIN SELECT MAXSEQ.NEXTVAL INTO NEXTVAL FROM DUAL; 
:NEW.ROWSTAMP := NEXTVAL; END;
/

-- End of DDL Script for Table IFRMAXIMO.EQUIPMENTSPEC

-- Start of DDL Script for Table IFRMAXIMO.EXCHANGE
-- Generated 9-mar-2004 20:03:19 from SYSMAN@MAQUINA4

CREATE TABLE exchange
    (rowstamp                       VARCHAR2(40) NOT NULL,
    currencycode                   VARCHAR2(8) NOT NULL,
    exchangerate                   NUMBER(14,7) NOT NULL,
    activedate                     DATE NOT NULL,
    expiredate                     DATE NOT NULL,
    memo                           VARCHAR2(25),
    enterdate                      DATE NOT NULL,
    enterby                        VARCHAR2(18) NOT NULL,
    exchange1                      VARCHAR2(1),
    exchange2                      VARCHAR2(1),
    exchange3                      VARCHAR2(1),
    exchange4                      VARCHAR2(1),
    currencycodeto                 VARCHAR2(8) NOT NULL,
    orgid                          VARCHAR2(8) NOT NULL,
    changeby                       VARCHAR2(18),
    changedate                     DATE)
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Indexes for EXCHANGE

CREATE UNIQUE INDEX exchange_ndx ON exchange
  (
    orgid                           ASC,
    currencycode                    ASC,
    currencycodeto                  ASC,
    expiredate                      ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/


-- Triggers for EXCHANGE

CREATE TRIGGER exchange_t
BEFORE INSERT  OR UPDATE 
ON exchange
REFERENCING NEW AS NEW OLD AS OLD
FOR EACH ROW
DECLARE 
NEXTVAL INTEGER; BEGIN SELECT MAXSEQ.NEXTVAL INTO NEXTVAL FROM DUAL; 
:NEW.ROWSTAMP := NEXTVAL; END;
/

-- End of DDL Script for Table IFRMAXIMO.EXCHANGE

-- Start of DDL Script for Table IFRMAXIMO.FAILURECODE
-- Generated 9-mar-2004 20:03:26 from SYSMAN@MAQUINA4

CREATE TABLE failurecode
    (rowstamp                       VARCHAR2(40) NOT NULL,
    failurecode                    VARCHAR2(8) NOT NULL,
    description                    VARCHAR2(50),
    ldkey                          NUMBER,
    orgid                          VARCHAR2(8) NOT NULL)
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Indexes for FAILURECODE

CREATE UNIQUE INDEX failurecode_ndx ON failurecode
  (
    orgid                           ASC,
    failurecode                     ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/


-- Triggers for FAILURECODE

CREATE TRIGGER failurecode_t
BEFORE INSERT  OR UPDATE 
ON failurecode
REFERENCING NEW AS NEW OLD AS OLD
FOR EACH ROW
DECLARE 
NEXTVAL INTEGER; BEGIN SELECT MAXSEQ.NEXTVAL INTO NEXTVAL FROM DUAL; 
:NEW.ROWSTAMP := NEXTVAL; END;
/

-- End of DDL Script for Table IFRMAXIMO.FAILURECODE

-- Start of DDL Script for Table IFRMAXIMO.FAILUREDELETE
-- Generated 9-mar-2004 20:03:33 from SYSMAN@MAQUINA4

CREATE TABLE failuredelete
    (rowstamp                       VARCHAR2(40) NOT NULL,
    failurelist                    NUMBER NOT NULL,
    treelevel                      NUMBER NOT NULL,
    username                       VARCHAR2(18) NOT NULL,
    transactionid                  DATE NOT NULL,
    parent                         NUMBER,
    orgid                          VARCHAR2(8))
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Triggers for FAILUREDELETE

CREATE TRIGGER failuredelete_t
BEFORE INSERT  OR UPDATE 
ON failuredelete
REFERENCING NEW AS NEW OLD AS OLD
FOR EACH ROW
DECLARE 
NEXTVAL INTEGER; BEGIN SELECT MAXSEQ.NEXTVAL INTO NEXTVAL FROM DUAL; 
:NEW.ROWSTAMP := NEXTVAL; END;
/

-- End of DDL Script for Table IFRMAXIMO.FAILUREDELETE

-- Start of DDL Script for Table IFRMAXIMO.FAILURELIST
-- Generated 9-mar-2004 20:03:35 from SYSMAN@MAQUINA4

CREATE TABLE failurelist
    (rowstamp                       VARCHAR2(40) NOT NULL,
    failurelist                    NUMBER NOT NULL,
    failurecode                    VARCHAR2(8) NOT NULL,
    parent                         NUMBER,
    type                           VARCHAR2(8),
    orgid                          VARCHAR2(8) NOT NULL)
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Indexes for FAILURELIST

CREATE UNIQUE INDEX faillist_ndx ON failurelist
  (
    orgid                           ASC,
    failurelist                     ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/
CREATE INDEX faillist_ndx2 ON failurelist
  (
    orgid                           ASC,
    failurecode                     ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/
CREATE INDEX faillist_ndx3 ON failurelist
  (
    orgid                           ASC,
    parent                          ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/


-- Triggers for FAILURELIST

CREATE TRIGGER failurelist_t
BEFORE INSERT  OR UPDATE 
ON failurelist
REFERENCING NEW AS NEW OLD AS OLD
FOR EACH ROW
DECLARE 
NEXTVAL INTEGER; BEGIN SELECT MAXSEQ.NEXTVAL INTO NEXTVAL FROM DUAL; 
:NEW.ROWSTAMP := NEXTVAL; END;
/

-- End of DDL Script for Table IFRMAXIMO.FAILURELIST

-- Start of DDL Script for Table IFRMAXIMO.FAILUREREMARK
-- Generated 9-mar-2004 20:03:50 from SYSMAN@MAQUINA4

CREATE TABLE failureremark
    (rowstamp                       VARCHAR2(40) NOT NULL,
    wonum                          VARCHAR2(18) NOT NULL,
    description                    VARCHAR2(50),
    enterdate                      DATE,
    ldkey                          NUMBER,
    orgid                          VARCHAR2(8) NOT NULL,
    siteid                         VARCHAR2(8) NOT NULL)
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Indexes for FAILUREREMARK

CREATE UNIQUE INDEX failremark_ndx ON failureremark
  (
    siteid                          ASC,
    wonum                           ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/


-- Triggers for FAILUREREMARK

CREATE TRIGGER failureremark_t
BEFORE INSERT  OR UPDATE 
ON failureremark
REFERENCING NEW AS NEW OLD AS OLD
FOR EACH ROW
DECLARE 
NEXTVAL INTEGER; BEGIN SELECT MAXSEQ.NEXTVAL INTO NEXTVAL FROM DUAL; 
:NEW.ROWSTAMP := NEXTVAL; END;
/

-- End of DDL Script for Table IFRMAXIMO.FAILUREREMARK

-- Start of DDL Script for Table IFRMAXIMO.FAILUREREPORT
-- Generated 9-mar-2004 20:03:56 from SYSMAN@MAQUINA4

CREATE TABLE failurereport
    (rowstamp                       VARCHAR2(40) NOT NULL,
    wonum                          VARCHAR2(18) NOT NULL,
    failurecode                    VARCHAR2(8) NOT NULL,
    eqnum                          VARCHAR2(12),
    linenum                        NUMBER NOT NULL,
    type                           VARCHAR2(8),
    orgid                          VARCHAR2(8) NOT NULL,
    siteid                         VARCHAR2(8) NOT NULL)
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Indexes for FAILUREREPORT

CREATE INDEX failreport_ndx1 ON failurereport
  (
    siteid                          ASC,
    wonum                           ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/
CREATE INDEX failreport_ndx2 ON failurereport
  (
    siteid                          ASC,
    linenum                         ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/


-- Triggers for FAILUREREPORT

CREATE TRIGGER failurereport_t
BEFORE INSERT  OR UPDATE 
ON failurereport
REFERENCING NEW AS NEW OLD AS OLD
FOR EACH ROW
DECLARE 
NEXTVAL INTEGER; BEGIN SELECT MAXSEQ.NEXTVAL INTO NEXTVAL FROM DUAL; 
:NEW.ROWSTAMP := NEXTVAL; END;
/

-- End of DDL Script for Table IFRMAXIMO.FAILUREREPORT

-- Start of DDL Script for Table IFRMAXIMO.FIELDDEFAULTS
-- Generated 9-mar-2004 20:04:06 from SYSMAN@MAQUINA4

CREATE TABLE fielddefaults
    (rowstamp                       VARCHAR2(40) NOT NULL,
    grpname                        VARCHAR2(18) NOT NULL,
    app                            VARCHAR2(10) NOT NULL,
    screen                         VARCHAR2(10) NOT NULL,
    twname                         VARCHAR2(32),
    field                          VARCHAR2(32) NOT NULL,
    defvalue                       VARCHAR2(254))
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Indexes for FIELDDEFAULTS

CREATE UNIQUE INDEX fielddefaults_ndx ON fielddefaults
  (
    grpname                         ASC,
    app                             ASC,
    screen                          ASC,
    field                           ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/


-- Triggers for FIELDDEFAULTS

CREATE TRIGGER fielddefaults_t
BEFORE INSERT  OR UPDATE 
ON fielddefaults
REFERENCING NEW AS NEW OLD AS OLD
FOR EACH ROW
DECLARE 
NEXTVAL INTEGER; BEGIN SELECT MAXSEQ.NEXTVAL INTO NEXTVAL FROM DUAL; 
:NEW.ROWSTAMP := NEXTVAL; END;
/

-- End of DDL Script for Table IFRMAXIMO.FIELDDEFAULTS

-- Start of DDL Script for Table IFRMAXIMO.FINANCIALPERIODS
-- Generated 9-mar-2004 20:04:14 from SYSMAN@MAQUINA4

CREATE TABLE financialperiods
    (rowstamp                       VARCHAR2(40) NOT NULL,
    financialperiod                VARCHAR2(6) NOT NULL,
    periodstart                    DATE NOT NULL,
    periodend                      DATE NOT NULL,
    periodclosedate                DATE,
    closedby                       VARCHAR2(18),
    closedate                      DATE,
    fp1                            VARCHAR2(1),
    fp2                            VARCHAR2(1),
    fp3                            VARCHAR2(1),
    fp4                            VARCHAR2(1),
    fp5                            VARCHAR2(1),
    orgid                          VARCHAR2(8) NOT NULL)
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Indexes for FINANCIALPERIODS

CREATE UNIQUE INDEX fperiod_ndx1 ON financialperiods
  (
    orgid                           ASC,
    financialperiod                 ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/
CREATE INDEX fperiod_ndx2 ON financialperiods
  (
    orgid                           ASC,
    periodstart                     ASC,
    periodend                       ASC,
    periodclosedate                 ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/


-- Triggers for FINANCIALPERIODS

CREATE TRIGGER financialperiods_t
BEFORE INSERT  OR UPDATE 
ON financialperiods
REFERENCING NEW AS NEW OLD AS OLD
FOR EACH ROW
DECLARE 
NEXTVAL INTEGER; BEGIN SELECT MAXSEQ.NEXTVAL INTO NEXTVAL FROM DUAL; 
:NEW.ROWSTAMP := NEXTVAL; END;
/

-- End of DDL Script for Table IFRMAXIMO.FINANCIALPERIODS

-- Start of DDL Script for Table IFRMAXIMO.FINCNTRL
-- Generated 9-mar-2004 20:04:25 from SYSMAN@MAQUINA4

CREATE TABLE fincntrl
    (fincntrlid                     VARCHAR2(8) NOT NULL,
    description                    VARCHAR2(50),
    ldkey                          NUMBER,
    budgetid                       VARCHAR2(25),
    budgetlineid                   VARCHAR2(25),
    projectid                      VARCHAR2(25),
    taskid                         VARCHAR2(25),
    budgettype                     VARCHAR2(30),
    budgetlinetype                 VARCHAR2(30),
    projecttype                    VARCHAR2(30),
    tasktype                       VARCHAR2(30),
    parentfincntrlid               VARCHAR2(8),
    tasklevel                      NUMBER,
    budgetcost                     NUMBER(10,2),
    actualcost                     NUMBER(10,2),
    burdenedcost                   NUMBER(10,2),
    allocatedcost                  NUMBER(10,2),
    committedcost                  NUMBER(10,2),
    remainingcost                  NUMBER(10,2),
    asofdate                       DATE,
    startdate                      DATE,
    enddate                        DATE,
    fctype                         VARCHAR2(8),
    disabled                       VARCHAR2(1) NOT NULL,
    issummary                      VARCHAR2(1) NOT NULL,
    ischargeable                   VARCHAR2(1) NOT NULL,
    templateid                     VARCHAR2(25),
    sourcesysid                    VARCHAR2(10),
    ownersysid                     VARCHAR2(10),
    changedate                     DATE NOT NULL,
    changeby                       VARCHAR2(18) NOT NULL,
    fc01                           VARCHAR2(1),
    fc02                           VARCHAR2(1),
    fc03                           VARCHAR2(1),
    fc04                           VARCHAR2(1),
    fc05                           VARCHAR2(1),
    fc06                           VARCHAR2(1),
    fc07                           VARCHAR2(1),
    fc08                           VARCHAR2(1),
    fc09                           VARCHAR2(1),
    fc10                           VARCHAR2(1),
    fc11                           VARCHAR2(1),
    fc12                           VARCHAR2(1),
    fc13                           VARCHAR2(1),
    fc14                           VARCHAR2(1),
    fc15                           VARCHAR2(1),
    sourceid                       VARCHAR2(25),
    apiseq                         VARCHAR2(50),
    siteid                         VARCHAR2(8) NOT NULL,
    orgid                          VARCHAR2(8) NOT NULL,
    rowstamp                       VARCHAR2(40) NOT NULL,
    fcstatus                       VARCHAR2(8),
    externalrefid                  VARCHAR2(10),
    sendersysid                    VARCHAR2(50))
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Indexes for FINCNTRL

CREATE INDEX fincntrl_ndx2 ON fincntrl
  (
    orgid                           ASC,
    budgetid                        ASC,
    budgetlineid                    ASC,
    projectid                       ASC,
    taskid                          ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/
CREATE UNIQUE INDEX fincntrl_ndx1 ON fincntrl
  (
    orgid                           ASC,
    fincntrlid                      ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/


-- Triggers for FINCNTRL

CREATE TRIGGER fincntrl_t
BEFORE INSERT  OR UPDATE 
ON fincntrl
REFERENCING NEW AS NEW OLD AS OLD
FOR EACH ROW
DECLARE NEXTVAL INTEGER; BEGIN SELECT MAXSEQ.NEXTVAL INTO NEXTVAL FROM DUAL; :NEW.ROWSTAMP := NEXTVAL; END;
/

-- End of DDL Script for Table IFRMAXIMO.FINCNTRL

-- Start of DDL Script for Table IFRMAXIMO.GLCOMPONENTS
-- Generated 9-mar-2004 20:04:37 from SYSMAN@MAQUINA4

CREATE TABLE glcomponents
    (rowstamp                       VARCHAR2(40) NOT NULL,
    glorder                        NUMBER NOT NULL,
    compvalue                      VARCHAR2(20) NOT NULL,
    comptext                       VARCHAR2(75) NOT NULL,
    username                       VARCHAR2(18),
    disabled                       VARCHAR2(1) NOT NULL,
    sourcesysid                    VARCHAR2(10),
    ownersysid                     VARCHAR2(10),
    externalrefid                  VARCHAR2(10),
    apiseq                         VARCHAR2(50),
    interid                        VARCHAR2(50),
    migchangeid                    VARCHAR2(50),
    sendersysid                    VARCHAR2(50),
    orgid                          VARCHAR2(8) NOT NULL)
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Indexes for GLCOMPONENTS

CREATE UNIQUE INDEX glcomp_ndx1 ON glcomponents
  (
    orgid                           ASC,
    glorder                         ASC,
    compvalue                       ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/
CREATE INDEX glcomp_ndx2 ON glcomponents
  (
    orgid                           ASC,
    interid                         ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/


-- Triggers for GLCOMPONENTS

CREATE TRIGGER glcomponents_t
BEFORE INSERT  OR UPDATE 
ON glcomponents
REFERENCING NEW AS NEW OLD AS OLD
FOR EACH ROW
DECLARE 
NEXTVAL INTEGER; BEGIN SELECT MAXSEQ.NEXTVAL INTO NEXTVAL FROM DUAL; 
:NEW.ROWSTAMP := NEXTVAL; END;
/

-- End of DDL Script for Table IFRMAXIMO.GLCOMPONENTS

-- Start of DDL Script for Table IFRMAXIMO.GLCONFIGURE
-- Generated 9-mar-2004 20:04:47 from SYSMAN@MAQUINA4

CREATE TABLE glconfigure
    (rowstamp                       VARCHAR2(40) NOT NULL,
    glaccountfield                 VARCHAR2(18) NOT NULL,
    glorder                        NUMBER NOT NULL,
    mandatory                      VARCHAR2(1) NOT NULL,
    delimiter                      VARCHAR2(1),
    delimtodb                      VARCHAR2(1) NOT NULL,
    gltype                         VARCHAR2(8) NOT NULL,
    gllength                       NUMBER NOT NULL,
    fillchar                       VARCHAR2(1),
    editstate                      VARCHAR2(1),
    changeauth                     VARCHAR2(254))
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Indexes for GLCONFIGURE

CREATE UNIQUE INDEX glcfg_ndx1 ON glconfigure
  (
    glorder                         ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/


-- Triggers for GLCONFIGURE

CREATE TRIGGER glconfigure_t
BEFORE INSERT  OR UPDATE 
ON glconfigure
REFERENCING NEW AS NEW OLD AS OLD
FOR EACH ROW
DECLARE 
NEXTVAL INTEGER; BEGIN SELECT MAXSEQ.NEXTVAL INTO NEXTVAL FROM DUAL; 
:NEW.ROWSTAMP := NEXTVAL; END;
/

-- End of DDL Script for Table IFRMAXIMO.GLCONFIGURE

-- Start of DDL Script for Table IFRMAXIMO.GROUPRESTRICTION
-- Generated 9-mar-2004 20:04:54 from SYSMAN@MAQUINA4

CREATE TABLE grouprestriction
    (rowstamp                       VARCHAR2(40) NOT NULL,
    grpname                        VARCHAR2(18) NOT NULL,
    restrictions                   VARCHAR2(254),
    tbname                         VARCHAR2(18) NOT NULL,
    orgid                          VARCHAR2(8) NOT NULL)
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Indexes for GROUPRESTRICTION

CREATE UNIQUE INDEX grouprestr_ndx1 ON grouprestriction
  (
    orgid                           ASC,
    grpname                         ASC,
    tbname                          ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/


-- Triggers for GROUPRESTRICTION

CREATE TRIGGER grouprestriction_t
BEFORE INSERT  OR UPDATE 
ON grouprestriction
REFERENCING NEW AS NEW OLD AS OLD
FOR EACH ROW
DECLARE 
NEXTVAL INTEGER; BEGIN SELECT MAXSEQ.NEXTVAL INTO NEXTVAL FROM DUAL; 
:NEW.ROWSTAMP := NEXTVAL; END;
/

-- End of DDL Script for Table IFRMAXIMO.GROUPRESTRICTION

-- Start of DDL Script for Table IFRMAXIMO.HAZARD
-- Generated 9-mar-2004 20:05:00 from SYSMAN@MAQUINA4

CREATE TABLE hazard
    (rowstamp                       VARCHAR2(40) NOT NULL,
    hazardid                       VARCHAR2(8) NOT NULL,
    description                    VARCHAR2(50),
    ldkey                          NUMBER,
    precautionenabled              VARCHAR2(1) NOT NULL,
    hazmatenabled                  VARCHAR2(1) NOT NULL,
    tagoutenabled                  VARCHAR2(1) NOT NULL,
    hazardtype                     VARCHAR2(16),
    msdsnum                        VARCHAR2(10),
    healthrating                   NUMBER,
    flammabilityrating             NUMBER,
    reactivityrating               NUMBER,
    contactrating                  NUMBER,
    haz01                          VARCHAR2(10),
    haz02                          VARCHAR2(10),
    haz03                          VARCHAR2(10),
    haz04                          VARCHAR2(10),
    haz05                          VARCHAR2(10),
    haz06                          VARCHAR2(10),
    haz07                          VARCHAR2(10),
    haz08                          VARCHAR2(10),
    haz09                          VARCHAR2(10),
    haz10                          VARCHAR2(10),
    haz11                          NUMBER(10,2),
    haz12                          NUMBER(10,2),
    haz13                          DATE,
    haz14                          DATE,
    haz15                          NUMBER(15,2),
    haz16                          NUMBER(15,2),
    haz17                          VARCHAR2(10),
    haz18                          VARCHAR2(10),
    haz19                          NUMBER,
    haz20                          VARCHAR2(1),
    orgid                          VARCHAR2(8) NOT NULL)
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Indexes for HAZARD

CREATE UNIQUE INDEX hazard_ndx1 ON hazard
  (
    orgid                           ASC,
    hazardid                        ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/


-- Triggers for HAZARD

CREATE TRIGGER hazard_t
BEFORE INSERT  OR UPDATE 
ON hazard
REFERENCING NEW AS NEW OLD AS OLD
FOR EACH ROW
DECLARE 
NEXTVAL INTEGER; BEGIN SELECT MAXSEQ.NEXTVAL INTO NEXTVAL FROM DUAL; 
:NEW.ROWSTAMP := NEXTVAL; END;
/

-- End of DDL Script for Table IFRMAXIMO.HAZARD

-- Start of DDL Script for Table IFRMAXIMO.HAZARD_BK
-- Generated 9-mar-2004 20:05:08 from SYSMAN@MAQUINA4

CREATE TABLE hazard_bk
    (hazardid                       VARCHAR2(8) NOT NULL,
    description                    VARCHAR2(50),
    ldkey                          NUMBER,
    precautionenabled              VARCHAR2(1) NOT NULL,
    hazmatenabled                  VARCHAR2(1) NOT NULL,
    tagoutenabled                  VARCHAR2(1) NOT NULL,
    hazardtype                     VARCHAR2(16),
    msdsnum                        VARCHAR2(10),
    healthrating                   NUMBER,
    flammabilityrating             NUMBER,
    reactivityrating               NUMBER,
    contactrating                  NUMBER,
    haz01                          VARCHAR2(10),
    haz02                          VARCHAR2(10),
    haz03                          VARCHAR2(10),
    haz04                          VARCHAR2(10),
    haz05                          VARCHAR2(10),
    haz06                          VARCHAR2(10),
    haz07                          VARCHAR2(10),
    haz08                          VARCHAR2(10),
    haz09                          VARCHAR2(10),
    haz10                          VARCHAR2(10),
    haz11                          NUMBER(10,2),
    haz12                          NUMBER(10,2),
    haz13                          DATE,
    haz14                          DATE,
    haz15                          NUMBER(15,2),
    haz16                          NUMBER(15,2),
    haz17                          VARCHAR2(10),
    haz18                          VARCHAR2(10),
    haz19                          NUMBER,
    haz20                          VARCHAR2(1),
    rowstamp                       VARCHAR2(40) NOT NULL)
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- End of DDL Script for Table IFRMAXIMO.HAZARD_BK

-- Start of DDL Script for Table IFRMAXIMO.HAZARDPREC
-- Generated 9-mar-2004 20:05:10 from SYSMAN@MAQUINA4

CREATE TABLE hazardprec
    (rowstamp                       VARCHAR2(40) NOT NULL,
    hazardid                       VARCHAR2(8) NOT NULL,
    precautionid                   VARCHAR2(10) NOT NULL,
    orgid                          VARCHAR2(8) NOT NULL,
    siteid                         VARCHAR2(8) NOT NULL)
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Indexes for HAZARDPREC

CREATE UNIQUE INDEX hazardprec_ndx1 ON hazardprec
  (
    siteid                          ASC,
    hazardid                        ASC,
    precautionid                    ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/


-- Triggers for HAZARDPREC

CREATE TRIGGER hazardprec_t
BEFORE INSERT  OR UPDATE 
ON hazardprec
REFERENCING NEW AS NEW OLD AS OLD
FOR EACH ROW
DECLARE NEXTVAL INTEGER; BEGIN SELECT MAXSEQ.NEXTVAL INTO NEXTVAL FROM DUAL; :NEW.ROWSTAMP := NEXTVAL; END;
/

-- End of DDL Script for Table IFRMAXIMO.HAZARDPREC

-- Start of DDL Script for Table IFRMAXIMO.HOLIDAY
-- Generated 9-mar-2004 20:05:17 from SYSMAN@MAQUINA4

CREATE TABLE holiday
    (rowstamp                       VARCHAR2(40) NOT NULL,
    holidaydate                    DATE NOT NULL,
    description                    VARCHAR2(50) NOT NULL,
    orgid                          VARCHAR2(8) NOT NULL)
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Indexes for HOLIDAY

CREATE INDEX holiday_ndx1 ON holiday
  (
    orgid                           ASC,
    holidaydate                     ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/


-- Triggers for HOLIDAY

CREATE TRIGGER holiday_t
BEFORE INSERT  OR UPDATE 
ON holiday
REFERENCING NEW AS NEW OLD AS OLD
FOR EACH ROW
DECLARE 
NEXTVAL INTEGER; BEGIN SELECT MAXSEQ.NEXTVAL INTO NEXTVAL FROM DUAL; 
:NEW.ROWSTAMP := NEXTVAL; END;
/

-- End of DDL Script for Table IFRMAXIMO.HOLIDAY

-- Start of DDL Script for Table IFRMAXIMO.HOMEM_HORA
-- Generated 9-mar-2004 20:05:24 from SYSMAN@MAQUINA4

CREATE TABLE homem_hora
    (mes_ano                        VARCHAR2(7),
    cargo                          VARCHAR2(20),
    ocupacao                       VARCHAR2(50),
    qtd                            NUMBER(5),
    media                          NUMBER(18,2),
    vl_hh                          NUMBER(18,2),
    erro                           VARCHAR2(100),
    desc_erro                      VARCHAR2(20))
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Constraints for HOMEM_HORA

ALTER TABLE homem_hora
ADD CONSTRAINT hh_mes_car_ocup_uk UNIQUE (mes_ano, cargo, ocupacao)
USING INDEX
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/

-- End of DDL Script for Table IFRMAXIMO.HOMEM_HORA

-- Start of DDL Script for Table IFRMAXIMO.INVBALANCES
-- Generated 9-mar-2004 20:05:29 from SYSMAN@MAQUINA4

CREATE TABLE invbalances
    (rowstamp                       VARCHAR2(40) NOT NULL,
    itemnum                        VARCHAR2(30) NOT NULL,
    location                       VARCHAR2(18) NOT NULL,
    binnum                         VARCHAR2(8),
    lotnum                         VARCHAR2(8),
    curbal                         NUMBER(15,2) NOT NULL,
    physcnt                        NUMBER(15,2) NOT NULL,
    physcntdate                    DATE,
    ldkey                          NUMBER,
    ib1                            VARCHAR2(10),
    ib2                            VARCHAR2(10),
    ib3                            VARCHAR2(10),
    ib4                            DATE,
    ib5                            NUMBER,
    reconciled                     VARCHAR2(1) NOT NULL,
    sourcesysid                    VARCHAR2(10),
    ownersysid                     VARCHAR2(10),
    externalrefid                  VARCHAR2(10),
    apiseq                         VARCHAR2(50),
    interid                        VARCHAR2(50),
    migchangeid                    VARCHAR2(50),
    sendersysid                    VARCHAR2(50),
    orgid                          VARCHAR2(8) NOT NULL,
    siteid                         VARCHAR2(8) NOT NULL)
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Indexes for INVBALANCES

CREATE UNIQUE INDEX invbal_ndx1 ON invbalances
  (
    siteid                          ASC,
    itemnum                         ASC,
    location                        ASC,
    binnum                          ASC,
    lotnum                          ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/
CREATE INDEX invbal_ndx2 ON invbalances
  (
    siteid                          ASC,
    interid                         ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/


-- Triggers for INVBALANCES

CREATE TRIGGER invbalances_t
BEFORE INSERT  OR UPDATE 
ON invbalances
REFERENCING NEW AS NEW OLD AS OLD
FOR EACH ROW
DECLARE 
NEXTVAL INTEGER; BEGIN SELECT MAXSEQ.NEXTVAL INTO NEXTVAL FROM DUAL; 
:NEW.ROWSTAMP := NEXTVAL; END;
/

-- End of DDL Script for Table IFRMAXIMO.INVBALANCES

-- Start of DDL Script for Table IFRMAXIMO.INVENTORY
-- Generated 9-mar-2004 20:05:39 from SYSMAN@MAQUINA4

CREATE TABLE inventory
    (rowstamp                       VARCHAR2(40) NOT NULL,
    itemnum                        VARCHAR2(30) NOT NULL,
    location                       VARCHAR2(18) NOT NULL,
    binnum                         VARCHAR2(8),
    vendor                         VARCHAR2(18),
    manufacturer                   VARCHAR2(18),
    modelnum                       VARCHAR2(8),
    catalogcode                    VARCHAR2(30),
    minlevel                       NUMBER(15,2) NOT NULL,
    maxlevel                       NUMBER(15,2) NOT NULL,
    category                       VARCHAR2(4) NOT NULL,
    orderunit                      VARCHAR2(8),
    issueunit                      VARCHAR2(8),
    conversion                     NUMBER(15,2) NOT NULL,
    orderqty                       NUMBER(15,2) NOT NULL,
    stdcost                        NUMBER(17,2) NOT NULL,
    avgcost                        NUMBER(17,2) NOT NULL,
    lastcost                       NUMBER(17,2) NOT NULL,
    lastissuedate                  DATE,
    issueytd                       NUMBER(15,2) NOT NULL,
    issue1yrago                    NUMBER(15,2) NOT NULL,
    issue2yrago                    NUMBER(15,2) NOT NULL,
    issue3yrago                    NUMBER(15,2) NOT NULL,
    abctype                        VARCHAR2(6),
    ccf                            NUMBER NOT NULL,
    sstock                         NUMBER(15,2),
    deliverytime                   NUMBER NOT NULL,
    ldkey                          NUMBER,
    il1                            VARCHAR2(10),
    il2                            VARCHAR2(10),
    il3                            VARCHAR2(10),
    il4                            DATE,
    il5                            NUMBER(15,2),
    il6                            VARCHAR2(1),
    il7                            VARCHAR2(1),
    il8                            VARCHAR2(1),
    il9                            VARCHAR2(1),
    il10                           VARCHAR2(1),
    glaccount                      VARCHAR2(20),
    controlacc                     VARCHAR2(20),
    shrinkageacc                   VARCHAR2(20),
    invcostadjacc                  VARCHAR2(20),
    sourcesysid                    VARCHAR2(10),
    ownersysid                     VARCHAR2(10),
    externalrefid                  VARCHAR2(10),
    apiseq                         VARCHAR2(50),
    interid                        VARCHAR2(50),
    migchangeid                    VARCHAR2(50),
    sendersysid                    VARCHAR2(50),
    orgid                          VARCHAR2(8) NOT NULL,
    siteid                         VARCHAR2(8) NOT NULL)
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Indexes for INVENTORY

CREATE UNIQUE INDEX inventory_ndx1 ON inventory
  (
    siteid                          ASC,
    itemnum                         ASC,
    location                        ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/
CREATE INDEX inventory_ndx2 ON inventory
  (
    siteid                          ASC,
    location                        ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/
CREATE INDEX inventory_ndx3 ON inventory
  (
    siteid                          ASC,
    interid                         ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/


-- Triggers for INVENTORY

CREATE TRIGGER inventory_t
BEFORE INSERT  OR UPDATE 
ON inventory
REFERENCING NEW AS NEW OLD AS OLD
FOR EACH ROW
DECLARE 
NEXTVAL INTEGER; BEGIN SELECT MAXSEQ.NEXTVAL INTO NEXTVAL FROM DUAL; 
:NEW.ROWSTAMP := NEXTVAL; END;
/

-- End of DDL Script for Table IFRMAXIMO.INVENTORY

-- Start of DDL Script for Table IFRMAXIMO.INVLOT
-- Generated 9-mar-2004 20:05:53 from SYSMAN@MAQUINA4

CREATE TABLE invlot
    (rowstamp                       VARCHAR2(40) NOT NULL,
    lotnum                         VARCHAR2(8),
    shelflife                      FLOAT(126),
    useby                          DATE,
    mfglotnum                      VARCHAR2(8),
    vendor                         VARCHAR2(18),
    manufacturer                   VARCHAR2(18),
    ldkey                          NUMBER,
    il1                            VARCHAR2(1),
    il2                            VARCHAR2(1),
    il3                            VARCHAR2(1),
    il4                            VARCHAR2(1),
    il5                            VARCHAR2(1),
    orgid                          VARCHAR2(8) NOT NULL,
    siteid                         VARCHAR2(8) NOT NULL)
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Indexes for INVLOT

CREATE UNIQUE INDEX invlot_ndx1 ON invlot
  (
    siteid                          ASC,
    lotnum                          ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/


-- Triggers for INVLOT

CREATE TRIGGER invlot_t
BEFORE INSERT  OR UPDATE 
ON invlot
REFERENCING NEW AS NEW OLD AS OLD
FOR EACH ROW
DECLARE 
NEXTVAL INTEGER; BEGIN SELECT MAXSEQ.NEXTVAL INTO NEXTVAL FROM DUAL; 
:NEW.ROWSTAMP := NEXTVAL; END;
/

-- End of DDL Script for Table IFRMAXIMO.INVLOT

-- Start of DDL Script for Table IFRMAXIMO.INVOICE
-- Generated 9-mar-2004 20:05:59 from SYSMAN@MAQUINA4

CREATE TABLE invoice
    (rowstamp                       VARCHAR2(40) NOT NULL,
    invoicenum                     VARCHAR2(8) NOT NULL,
    description                    VARCHAR2(50),
    ponum                          VARCHAR2(8),
    vendor                         VARCHAR2(18) NOT NULL,
    contact                        VARCHAR2(50),
    paymentterms                   VARCHAR2(20),
    checkcode                      VARCHAR2(8),
    checknum                       VARCHAR2(8),
    currencycode                   VARCHAR2(8) NOT NULL,
    exchangerate                   NUMBER(14,7),
    exchangedate                   DATE,
    documenttype                   VARCHAR2(8) NOT NULL,
    originvoicenum                 VARCHAR2(8),
    status                         VARCHAR2(10) NOT NULL,
    statusdate                     DATE NOT NULL,
    approvalnum                    VARCHAR2(20),
    invoicedate                    DATE,
    discountdate                   DATE,
    duedate                        DATE,
    paiddate                       DATE,
    paid                           NUMBER(10,2),
    enterdate                      DATE NOT NULL,
    enterby                        VARCHAR2(18) NOT NULL,
    changedate                     DATE NOT NULL,
    changeby                       VARCHAR2(18) NOT NULL,
    historyflag                    VARCHAR2(1) NOT NULL,
    totaltax1                      NUMBER(10,2) NOT NULL,
    tax1gl                         VARCHAR2(20),
    totaltax2                      NUMBER(10,2) NOT NULL,
    tax2gl                         VARCHAR2(20),
    totaltax3                      NUMBER(10,2) NOT NULL,
    tax3gl                         VARCHAR2(20),
    totaltax4                      NUMBER(10,2) NOT NULL,
    tax4gl                         VARCHAR2(20),
    inclusive1                     VARCHAR2(1) NOT NULL,
    inclusive2                     VARCHAR2(1) NOT NULL,
    inclusive3                     VARCHAR2(1) NOT NULL,
    discount                       NUMBER(10,2),
    totalcost                      NUMBER(10,2) NOT NULL,
    invoice1                       VARCHAR2(10),
    invoice2                       VARCHAR2(10),
    invoice3                       VARCHAR2(10),
    invoice4                       NUMBER(10,2),
    invoice5                       DATE,
    syscode                        NUMBER,
    ldkey                          NUMBER,
    totaltax5                      NUMBER(10,2) NOT NULL,
    tax5gl                         VARCHAR2(20),
    inclusive4                     VARCHAR2(1) NOT NULL,
    inclusive5                     VARCHAR2(1) NOT NULL,
    vendorinvoicenum               VARCHAR2(12),
    basetotalcost                  NUMBER(10,2),
    apsuspenseacct                 VARCHAR2(20),
    apcontrolacct                  VARCHAR2(20),
    financialperiod                VARCHAR2(6),
    exchangerate2                  NUMBER(14,7),
    bankaccount                    VARCHAR2(20),
    banknum                        VARCHAR2(16),
    invoice6                       VARCHAR2(10),
    invoice7                       VARCHAR2(10),
    invoice8                       VARCHAR2(10),
    invoice9                       VARCHAR2(10),
    invoice10                      VARCHAR2(10),
    sourcesysid                    VARCHAR2(10),
    ownersysid                     VARCHAR2(10),
    externalrefid                  VARCHAR2(10),
    wfid                           NUMBER,
    wfactive                       VARCHAR2(1) NOT NULL,
    apiseq                         VARCHAR2(50),
    interid                        VARCHAR2(50),
    migchangeid                    VARCHAR2(50),
    sendersysid                    VARCHAR2(50),
    expdone                        VARCHAR2(25),
    einvoice                       VARCHAR2(1) NOT NULL,
    siteid                         VARCHAR2(8) NOT NULL,
    orgid                          VARCHAR2(8) NOT NULL)
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Indexes for INVOICE

CREATE UNIQUE INDEX invoice_ndx1 ON invoice
  (
    siteid                          ASC,
    invoicenum                      ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/
CREATE INDEX invoice_ndx2 ON invoice
  (
    siteid                          ASC,
    vendor                          ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/
CREATE INDEX invoice_ndx3 ON invoice
  (
    siteid                          ASC,
    ponum                           ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/
CREATE INDEX invoice_ndx4 ON invoice
  (
    siteid                          ASC,
    approvalnum                     ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/
CREATE INDEX invoice_ndx5 ON invoice
  (
    siteid                          ASC,
    vendorinvoicenum                ASC,
    vendor                          ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/
CREATE INDEX invoice_ndx6 ON invoice
  (
    siteid                          ASC,
    interid                         ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/
CREATE INDEX invoice_ndx7 ON invoice
  (
    siteid                          ASC,
    wfid                            ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/


-- Triggers for INVOICE

CREATE TRIGGER invoice_t
BEFORE INSERT  OR UPDATE 
ON invoice
REFERENCING NEW AS NEW OLD AS OLD
FOR EACH ROW
DECLARE 
NEXTVAL INTEGER; BEGIN SELECT MAXSEQ.NEXTVAL INTO NEXTVAL FROM DUAL; 
:NEW.ROWSTAMP := NEXTVAL; END;
/

-- End of DDL Script for Table IFRMAXIMO.INVOICE

-- Start of DDL Script for Table IFRMAXIMO.INVOICECOST
-- Generated 9-mar-2004 20:06:31 from SYSMAN@MAQUINA4

CREATE TABLE invoicecost
    (rowstamp                       VARCHAR2(40) NOT NULL,
    invoicenum                     VARCHAR2(8) NOT NULL,
    vendor                         VARCHAR2(18) NOT NULL,
    invoicelinenum                 NUMBER NOT NULL,
    gldebitacct                    VARCHAR2(20),
    glcreditacct                   VARCHAR2(20),
    eqnum                          VARCHAR2(12),
    unitcost                       NUMBER(10,2),
    linecost                       NUMBER(10,2) NOT NULL,
    percentage                     NUMBER(5,2) NOT NULL,
    memo                           VARCHAR2(25),
    costlinenum                    NUMBER NOT NULL,
    chargestore                    VARCHAR2(1) NOT NULL,
    ict1                           NUMBER(10,2),
    ict2                           VARCHAR2(10),
    ict3                           VARCHAR2(10),
    quantity                       NUMBER(10,2),
    location                       VARCHAR2(18),
    fincntrlid                     VARCHAR2(8),
    siteid                         VARCHAR2(8) NOT NULL,
    orgid                          VARCHAR2(8) NOT NULL,
    refwo                          VARCHAR2(18),
    enteredastask                  VARCHAR2(1) NOT NULL)
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Indexes for INVOICECOST

CREATE UNIQUE INDEX invoicecost_ndx1 ON invoicecost
  (
    siteid                          ASC,
    invoicenum                      ASC,
    invoicelinenum                  ASC,
    costlinenum                     ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/


-- Triggers for INVOICECOST

CREATE TRIGGER invoicecost_t
BEFORE INSERT  OR UPDATE 
ON invoicecost
REFERENCING NEW AS NEW OLD AS OLD
FOR EACH ROW
DECLARE NEXTVAL INTEGER; BEGIN SELECT MAXSEQ.NEXTVAL INTO NEXTVAL FROM DUAL; :NEW.ROWSTAMP := NEXTVAL; END;
/

-- End of DDL Script for Table IFRMAXIMO.INVOICECOST

-- Start of DDL Script for Table IFRMAXIMO.INVOICELINE
-- Generated 9-mar-2004 20:06:38 from SYSMAN@MAQUINA4

CREATE TABLE invoiceline
    (rowstamp                       VARCHAR2(40) NOT NULL,
    invoicenum                     VARCHAR2(8) NOT NULL,
    vendor                         VARCHAR2(18) NOT NULL,
    ponum                          VARCHAR2(8),
    invoicelinenum                 NUMBER NOT NULL,
    polinenum                      NUMBER,
    itemnum                        VARCHAR2(30),
    description                    VARCHAR2(120),
    schargecode                    VARCHAR2(8),
    invoiceqty                     NUMBER(10,2),
    invoiceunit                    VARCHAR2(8),
    unitcost                       NUMBER(10,2),
    linecost                       NUMBER(10,2) NOT NULL,
    conversion                     NUMBER(15,2),
    receiptreqd                    VARCHAR2(1) NOT NULL,
    tax1code                       VARCHAR2(8),
    tax1                           NUMBER(10,2) NOT NULL,
    tax2code                       VARCHAR2(8),
    tax2                           NUMBER(10,2) NOT NULL,
    tax3code                       VARCHAR2(8),
    tax3                           NUMBER(10,2) NOT NULL,
    invoicelin1                    NUMBER(10,2),
    invoicelin2                    VARCHAR2(10),
    invoicelin3                    VARCHAR2(10),
    invoicelin4                    VARCHAR2(1),
    invoicelin5                    VARCHAR2(1),
    enterby                        VARCHAR2(18) NOT NULL,
    enterdate                      DATE NOT NULL,
    ldkey                          NUMBER,
    tax4code                       VARCHAR2(8),
    tax4                           NUMBER(10,2) NOT NULL,
    tax5code                       VARCHAR2(8),
    tax5                           NUMBER(10,2) NOT NULL,
    service                        VARCHAR2(1) NOT NULL,
    loadedcost                     NUMBER(10,2) NOT NULL,
    prorated                       VARCHAR2(1) NOT NULL,
    proratecost                    NUMBER(10,2),
    prorateservice                 VARCHAR2(1) NOT NULL,
    agreementponum                 VARCHAR2(8),
    agreementpotype                VARCHAR2(6),
    linecost2                      NUMBER(10,2),
    invoicelin6                    VARCHAR2(1),
    invoicelin7                    VARCHAR2(1),
    invoicelin8                    VARCHAR2(1),
    invoicelin9                    VARCHAR2(1),
    siteid                         VARCHAR2(8) NOT NULL,
    orgid                          VARCHAR2(8) NOT NULL)
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Indexes for INVOICELINE

CREATE INDEX invoiceline_ndx6 ON invoiceline
  (
    invoicenum                      ASC,
    itemnum                         ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
PARALLEL (DEGREE DEFAULT)
/
CREATE INDEX invoiceline_ndx7 ON invoiceline
  (
    invoicenum                      ASC,
    ponum                           ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
PARALLEL (DEGREE DEFAULT)
/
CREATE INDEX invoiceline_ndx8 ON invoiceline
  (
    ponum                           ASC,
    itemnum                         ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
PARALLEL (DEGREE DEFAULT)
/
CREATE UNIQUE INDEX invoiceline_ndx1 ON invoiceline
  (
    siteid                          ASC,
    invoicenum                      ASC,
    invoicelinenum                  ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/
CREATE INDEX invoiceline_ndx2 ON invoiceline
  (
    service                         ASC,
    invoicenum                      ASC,
    itemnum                         ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/
CREATE INDEX invoiceline_ndx3 ON invoiceline
  (
    siteid                          ASC,
    invoicenum                      ASC,
    ponum                           ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/
CREATE INDEX invoiceline_ndx4 ON invoiceline
  (
    siteid                          ASC,
    ponum                           ASC,
    itemnum                         ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/


-- Triggers for INVOICELINE

CREATE TRIGGER invoiceline_t
BEFORE INSERT  OR UPDATE 
ON invoiceline
REFERENCING NEW AS NEW OLD AS OLD
FOR EACH ROW
DECLARE NEXTVAL INTEGER; BEGIN SELECT MAXSEQ.NEXTVAL INTO NEXTVAL FROM DUAL; :NEW.ROWSTAMP := NEXTVAL; END;
/

-- End of DDL Script for Table IFRMAXIMO.INVOICELINE

-- Start of DDL Script for Table IFRMAXIMO.INVOICEMATCH
-- Generated 9-mar-2004 20:07:10 from SYSMAN@MAQUINA4

CREATE TABLE invoicematch
    (rowstamp                       VARCHAR2(40) NOT NULL,
    vendor                         VARCHAR2(18) NOT NULL,
    invoicenum                     VARCHAR2(8) NOT NULL,
    invoicelinenum                 NUMBER NOT NULL,
    ponum                          VARCHAR2(8),
    polinenum                      NUMBER,
    transtype                      VARCHAR2(16) NOT NULL,
    transdate                      DATE,
    quantity                       NUMBER(10,2),
    linecost                       NUMBER(10,2) NOT NULL,
    conversion                     NUMBER(15,2),
    costlinenum                    NUMBER NOT NULL,
    matrectransid                  NUMBER,
    servrectransid                 NUMBER,
    siteid                         VARCHAR2(8) NOT NULL,
    orgid                          VARCHAR2(8) NOT NULL)
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Indexes for INVOICEMATCH

CREATE INDEX invoicemtch_ndx1 ON invoicematch
  (
    siteid                          ASC,
    invoicenum                      ASC,
    invoicelinenum                  ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/
CREATE INDEX invoicemtch_ndx2 ON invoicematch
  (
    siteid                          ASC,
    ponum                           ASC,
    polinenum                       ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/


-- Triggers for INVOICEMATCH

CREATE TRIGGER invoicematch_t
BEFORE INSERT  OR UPDATE 
ON invoicematch
REFERENCING NEW AS NEW OLD AS OLD
FOR EACH ROW
DECLARE 
NEXTVAL INTEGER; BEGIN SELECT MAXSEQ.NEXTVAL INTO NEXTVAL FROM DUAL; 
:NEW.ROWSTAMP := NEXTVAL; END;
/

-- End of DDL Script for Table IFRMAXIMO.INVOICEMATCH

-- Start of DDL Script for Table IFRMAXIMO.INVOICESTATUS
-- Generated 9-mar-2004 20:07:20 from SYSMAN@MAQUINA4

CREATE TABLE invoicestatus
    (rowstamp                       VARCHAR2(40) NOT NULL,
    invoicenum                     VARCHAR2(8) NOT NULL,
    vendor                         VARCHAR2(18) NOT NULL,
    status                         VARCHAR2(10) NOT NULL,
    changedate                     DATE NOT NULL,
    changeby                       VARCHAR2(18) NOT NULL,
    memo                           VARCHAR2(100),
    siteid                         VARCHAR2(8) NOT NULL,
    orgid                          VARCHAR2(8) NOT NULL)
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Indexes for INVOICESTATUS

CREATE INDEX invoicestatus_ndx1 ON invoicestatus
  (
    siteid                          ASC,
    invoicenum                      ASC,
    vendor                          ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/
CREATE INDEX invoicestatus_ndx2 ON invoicestatus
  (
    siteid                          ASC,
    changedate                      ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/


-- Triggers for INVOICESTATUS

CREATE TRIGGER invoicestatus_t
BEFORE INSERT  OR UPDATE 
ON invoicestatus
REFERENCING NEW AS NEW OLD AS OLD
FOR EACH ROW
DECLARE 
NEXTVAL INTEGER; BEGIN SELECT MAXSEQ.NEXTVAL INTO NEXTVAL FROM DUAL; 
:NEW.ROWSTAMP := NEXTVAL; END;
/

-- End of DDL Script for Table IFRMAXIMO.INVOICESTATUS

-- Start of DDL Script for Table IFRMAXIMO.INVOICETRANS
-- Generated 9-mar-2004 20:07:30 from SYSMAN@MAQUINA4

CREATE TABLE invoicetrans
    (rowstamp                       VARCHAR2(40) NOT NULL,
    vendor                         VARCHAR2(18) NOT NULL,
    invoicenum                     VARCHAR2(8) NOT NULL,
    invoicelinenum                 NUMBER,
    costlinenum                    NUMBER,
    gldebitacct                    VARCHAR2(20),
    glcreditacct                   VARCHAR2(20),
    currencycode                   VARCHAR2(8) NOT NULL,
    linecost                       NUMBER(10,2) NOT NULL,
    transdate                      DATE NOT NULL,
    enterby                        VARCHAR2(18) NOT NULL,
    transtype                      VARCHAR2(10) NOT NULL,
    currencylinecost               NUMBER(10,2) NOT NULL,
    exchangerate                   NUMBER(14,7) NOT NULL,
    financialperiod                VARCHAR2(6),
    exchangerate2                  NUMBER(14,7),
    linecost2                      NUMBER(10,2),
    apiseq                         VARCHAR2(50),
    interid                        VARCHAR2(50),
    migchangeid                    VARCHAR2(50),
    sendersysid                    VARCHAR2(50),
    sourcesysid                    VARCHAR2(10),
    ownersysid                     VARCHAR2(10),
    externalrefid                  VARCHAR2(10),
    siteid                         VARCHAR2(8) NOT NULL,
    orgid                          VARCHAR2(8) NOT NULL)
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Indexes for INVOICETRANS

CREATE INDEX invoicetrans_ndx1 ON invoicetrans
  (
    siteid                          ASC,
    transdate                       ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/
CREATE INDEX invoicetrans_ndx2 ON invoicetrans
  (
    siteid                          ASC,
    interid                         ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/


-- Triggers for INVOICETRANS

CREATE TRIGGER invoicetrans_t
BEFORE INSERT  OR UPDATE 
ON invoicetrans
REFERENCING NEW AS NEW OLD AS OLD
FOR EACH ROW
DECLARE 
NEXTVAL INTEGER; BEGIN SELECT MAXSEQ.NEXTVAL INTO NEXTVAL FROM DUAL; 
:NEW.ROWSTAMP := NEXTVAL; END;
/

-- End of DDL Script for Table IFRMAXIMO.INVOICETRANS

-- Start of DDL Script for Table IFRMAXIMO.INVRESERVE
-- Generated 9-mar-2004 20:07:41 from SYSMAN@MAQUINA4

CREATE TABLE invreserve
    (rowstamp                       VARCHAR2(40) NOT NULL,
    requestnum                     VARCHAR2(20) NOT NULL,
    itemnum                        VARCHAR2(30),
    location                       VARCHAR2(18),
    wonum                          VARCHAR2(18),
    actualqty                      NUMBER(15,2) NOT NULL,
    reservedqty                    NUMBER(15,2) NOT NULL,
    initflag                       VARCHAR2(1) NOT NULL,
    directreq                      VARCHAR2(1) NOT NULL,
    glaccount                      VARCHAR2(20),
    requestedby                    VARCHAR2(20),
    requesteddate                  DATE,
    requireddate                   DATE,
    ponum                          VARCHAR2(8),
    polinenum                      NUMBER,
    dellocation                    VARCHAR2(18),
    description                    VARCHAR2(120),
    ldkey                          NUMBER,
    ir1                            VARCHAR2(10),
    ir2                            NUMBER,
    ir3                            VARCHAR2(10),
    ir4                            DATE,
    ir5                            NUMBER(15,2),
    polineid                       NUMBER,
    mrnum                          VARCHAR2(8),
    mrlinenum                      NUMBER,
    eqnum                          VARCHAR2(12),
    sourcesysid                    VARCHAR2(10),
    ownersysid                     VARCHAR2(10),
    externalrefid                  VARCHAR2(10),
    issueto                        VARCHAR2(12),
    apiseq                         VARCHAR2(50),
    interid                        VARCHAR2(50),
    migchangeid                    VARCHAR2(50),
    sendersysid                    VARCHAR2(50),
    expdone                        VARCHAR2(25),
    fincntrlid                     VARCHAR2(8),
    orgid                          VARCHAR2(8) NOT NULL,
    siteid                         VARCHAR2(8) NOT NULL)
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Indexes for INVRESERVE

CREATE UNIQUE INDEX invreserve_ndx1 ON invreserve
  (
    siteid                          ASC,
    requestnum                      ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/
CREATE INDEX invreserve_ndx2 ON invreserve
  (
    siteid                          ASC,
    itemnum                         ASC,
    location                        ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/
CREATE INDEX invreserve_ndx3 ON invreserve
  (
    siteid                          ASC,
    wonum                           ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/
CREATE INDEX invreserve_ndx4 ON invreserve
  (
    siteid                          ASC,
    polineid                        ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/
CREATE INDEX invreserve_ndx5 ON invreserve
  (
    siteid                          ASC,
    interid                         ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/


-- Triggers for INVRESERVE

CREATE TRIGGER invreserve_t
BEFORE INSERT  OR UPDATE 
ON invreserve
REFERENCING NEW AS NEW OLD AS OLD
FOR EACH ROW
DECLARE NEXTVAL INTEGER; BEGIN SELECT MAXSEQ.NEXTVAL INTO NEXTVAL FROM DUAL; :NEW.ROWSTAMP := NEXTVAL; END;
/

-- End of DDL Script for Table IFRMAXIMO.INVRESERVE

-- Start of DDL Script for Table IFRMAXIMO.INVRESERVE_BKP
-- Generated 9-mar-2004 20:08:03 from SYSMAN@MAQUINA4

CREATE TABLE invreserve_bkp
    (rowstamp                       VARCHAR2(40) NOT NULL,
    requestnum                     VARCHAR2(20) NOT NULL,
    itemnum                        VARCHAR2(30),
    location                       VARCHAR2(18),
    wonum                          VARCHAR2(18),
    actualqty                      NUMBER(15,2) NOT NULL,
    reservedqty                    NUMBER(15,2) NOT NULL,
    initflag                       VARCHAR2(1) NOT NULL,
    directreq                      VARCHAR2(1) NOT NULL,
    glaccount                      VARCHAR2(20),
    requestedby                    VARCHAR2(20),
    requesteddate                  DATE,
    requireddate                   DATE,
    ponum                          VARCHAR2(8),
    polinenum                      NUMBER,
    dellocation                    VARCHAR2(18),
    description                    VARCHAR2(120),
    ldkey                          NUMBER,
    ir1                            VARCHAR2(10),
    ir2                            NUMBER,
    ir3                            VARCHAR2(10),
    ir4                            DATE,
    ir5                            NUMBER(15,2),
    polineid                       NUMBER,
    mrnum                          VARCHAR2(8),
    mrlinenum                      NUMBER,
    eqnum                          VARCHAR2(12),
    sourcesysid                    VARCHAR2(10),
    ownersysid                     VARCHAR2(10),
    externalrefid                  VARCHAR2(10),
    issueto                        VARCHAR2(12),
    apiseq                         VARCHAR2(50),
    interid                        VARCHAR2(50),
    migchangeid                    VARCHAR2(50),
    sendersysid                    VARCHAR2(50),
    expdone                        VARCHAR2(25),
    fincntrlid                     VARCHAR2(8),
    orgid                          VARCHAR2(8) NOT NULL,
    siteid                         VARCHAR2(8) NOT NULL)
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- End of DDL Script for Table IFRMAXIMO.INVRESERVE_BKP

-- Start of DDL Script for Table IFRMAXIMO.INVTRANS
-- Generated 9-mar-2004 20:08:05 from SYSMAN@MAQUINA4

CREATE TABLE invtrans
    (rowstamp                       VARCHAR2(40) NOT NULL,
    itemnum                        VARCHAR2(30) NOT NULL,
    storeloc                       VARCHAR2(18) NOT NULL,
    transdate                      DATE NOT NULL,
    transtype                      VARCHAR2(16) NOT NULL,
    quantity                       NUMBER(15,2) NOT NULL,
    curbal                         NUMBER(15,2) NOT NULL,
    physcnt                        NUMBER(15,2) NOT NULL,
    oldcost                        NUMBER(10,2) NOT NULL,
    newcost                        NUMBER(10,2) NOT NULL,
    conversion                     NUMBER(15,2) NOT NULL,
    enterby                        VARCHAR2(18) NOT NULL,
    memo                           VARCHAR2(254),
    binnum                         VARCHAR2(8),
    lotnum                         VARCHAR2(8),
    gldebitacct                    VARCHAR2(20),
    glcreditacct                   VARCHAR2(20),
    financialperiod                VARCHAR2(6),
    linecost                       NUMBER(10,2) NOT NULL,
    exchangerate2                  NUMBER(14,7),
    linecost2                      NUMBER(10,2),
    invtransid                     NUMBER NOT NULL,
    matrectransid                  NUMBER,
    apiseq                         VARCHAR2(50),
    interid                        VARCHAR2(50),
    migchangeid                    VARCHAR2(50),
    sendersysid                    VARCHAR2(50),
    sourcesysid                    VARCHAR2(10),
    ownersysid                     VARCHAR2(10),
    externalrefid                  VARCHAR2(10),
    orgid                          VARCHAR2(8) NOT NULL,
    siteid                         VARCHAR2(8) NOT NULL)
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Indexes for INVTRANS

CREATE INDEX invtrans_ndx2 ON invtrans
  (
    siteid                          ASC,
    itemnum                         ASC,
    storeloc                        ASC,
    transdate                       ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/
CREATE INDEX invtrans_ndx3 ON invtrans
  (
    siteid                          ASC,
    interid                         ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/
CREATE UNIQUE INDEX invtrans_ndx1 ON invtrans
  (
    siteid                          ASC,
    invtransid                      ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/


-- Triggers for INVTRANS

CREATE TRIGGER invtrans_t
BEFORE INSERT  OR UPDATE 
ON invtrans
REFERENCING NEW AS NEW OLD AS OLD
FOR EACH ROW
DECLARE 
NEXTVAL INTEGER; BEGIN SELECT MAXSEQ.NEXTVAL INTO NEXTVAL FROM DUAL; 
:NEW.ROWSTAMP := NEXTVAL; END;
/

-- End of DDL Script for Table IFRMAXIMO.INVTRANS

-- Start of DDL Script for Table IFRMAXIMO.INVVENDOR
-- Generated 9-mar-2004 20:08:20 from SYSMAN@MAQUINA4

CREATE TABLE invvendor
    (rowstamp                       VARCHAR2(40) NOT NULL,
    itemnum                        VARCHAR2(30) NOT NULL,
    vendor                         VARCHAR2(18),
    manufacturer                   VARCHAR2(18),
    modelnum                       VARCHAR2(8),
    catalogcode                    VARCHAR2(30),
    ldkey                          NUMBER,
    iv1                            VARCHAR2(10),
    iv2                            VARCHAR2(10),
    iv3                            VARCHAR2(1),
    ivco1                          VARCHAR2(10),
    ivco2                          DATE,
    ivco3                          NUMBER(15,2),
    tax1code                       VARCHAR2(8),
    tax2code                       VARCHAR2(8),
    tax3code                       VARCHAR2(8),
    bidprice                       NUMBER(10,2) NOT NULL,
    biddate                        DATE,
    promdeliverytime               NUMBER NOT NULL,
    tax4code                       VARCHAR2(8),
    tax5code                       VARCHAR2(8),
    lastcost                       NUMBER(10,2),
    lastdate                       DATE,
    catalogwebpage                 VARCHAR2(124),
    sourcesysid                    VARCHAR2(10),
    ownersysid                     VARCHAR2(10),
    externalrefid                  VARCHAR2(10),
    apiseq                         VARCHAR2(50),
    interid                        VARCHAR2(50),
    migchangeid                    VARCHAR2(50),
    sendersysid                    VARCHAR2(50),
    orderunit                      VARCHAR2(8),
    conversion                     NUMBER(15,2),
    isdefault                      VARCHAR2(1) NOT NULL,
    ecompartnum1                   VARCHAR2(30),
    ecompartnum2                   VARCHAR2(30),
    ecompartnum3                   VARCHAR2(1),
    ecompartnum4                   VARCHAR2(1),
    description                    VARCHAR2(80),
    orgid                          VARCHAR2(8) NOT NULL,
    siteid                         VARCHAR2(8) NOT NULL)
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Indexes for INVVENDOR

CREATE UNIQUE INDEX invvend_ndx1 ON invvendor
  (
    siteid                          ASC,
    itemnum                         ASC,
    vendor                          ASC,
    manufacturer                    ASC,
    modelnum                        ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/
CREATE INDEX invvend_ndx2 ON invvendor
  (
    siteid                          ASC,
    interid                         ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/
CREATE INDEX invvend_ndx3 ON invvendor
  (
    siteid                          ASC,
    vendor                          ASC,
    catalogcode                     ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/


-- Triggers for INVVENDOR

CREATE TRIGGER invvendor_t
BEFORE INSERT  OR UPDATE 
ON invvendor
REFERENCING NEW AS NEW OLD AS OLD
FOR EACH ROW
DECLARE 
NEXTVAL INTEGER; BEGIN SELECT MAXSEQ.NEXTVAL INTO NEXTVAL FROM DUAL; 
:NEW.ROWSTAMP := NEXTVAL; END;
/
CREATE TRIGGER invvendor_verity_t
AFTER INSERT  OR UPDATE  OR  DELETE 
ON invvendor
REFERENCING NEW AS NEW OLD AS OLD
FOR EACH ROW
Declare	 	AutoPreFixSeed 	Varchar2(20); 	RecordCount	Number; 	ItemFlag	Varchar2(30); 	OrgId 		Varchar2(8); Begin    If 	   Inserting Then 	   ItemFlag   := :new.itemnum; 	   OrgId      := :new.orgid;    Elsif Updating  Then 	   ItemFlag   := :new.itemnum; 	   OrgId      := :new.orgid;    Elsif Deleting  Then 	   ItemFlag   := :old.itemnum; 	   OrgId      := :old.orgid;    End If;     Select  ltrim(rtrim(prefix))||seed    Into    AutoPreFixSeed    From    autokey    Where   tbname ='VERITYACTION';        Select  Count(*)     Into    RecordCount    From    verityaction    Where   itemnum = ItemFlag    And 	   action = 'U'    And 	   transid = AutoPreFixSeed    And	   orgid = OrgId;      If      RecordCount = 0    Then    Insert Into verityaction(itemnum,action,transid,orgid) 	   Values 	   ( 	     ItemFlag, 	     'U', 	     AutoPreFixSeed, 	     OrgId 	   );    End If; Exception 	When Others then 	   raise_application_error(-20001,'Failure Encountered in executing Trigger INVVENDOR_VERITY_T'); End;
/

-- End of DDL Script for Table IFRMAXIMO.INVVENDOR

-- Start of DDL Script for Table IFRMAXIMO.ITEM
-- Generated 9-mar-2004 20:08:37 from SYSMAN@MAQUINA4

CREATE TABLE item
    (rowstamp                       VARCHAR2(40) NOT NULL,
    itemnum                        VARCHAR2(30) NOT NULL,
    description                    VARCHAR2(120),
    rotating                       VARCHAR2(1) NOT NULL,
    stocktype                      VARCHAR2(10),
    lottype                        VARCHAR2(10) NOT NULL,
    capitalized                    VARCHAR2(1) NOT NULL,
    msdsnum                        VARCHAR2(10),
    outside                        VARCHAR2(1) NOT NULL,
    ldkey                          NUMBER,
    in1                            VARCHAR2(10),
    in2                            VARCHAR2(1),
    in3                            VARCHAR2(1),
    in4                            VARCHAR2(10),
    in5                            VARCHAR2(10),
    in6                            VARCHAR2(10),
    in7                            VARCHAR2(10),
    in8                            VARCHAR2(10),
    in9                            NUMBER(10,2),
    in10                           DATE,
    in11                           NUMBER(15,2),
    in12                           NUMBER(15,2),
    in13                           VARCHAR2(10),
    in14                           NUMBER,
    in15                           VARCHAR2(1),
    in16                           NUMBER(15,2),
    in17                           VARCHAR2(50),
    in18                           VARCHAR2(10),
    in19                           NUMBER(10,2),
    in20                           VARCHAR2(10),
    in21                           VARCHAR2(10),
    in22                           DATE,
    in23                           NUMBER(15,2),
    tax1code                       VARCHAR2(8),
    tax2code                       VARCHAR2(8),
    tax3code                       VARCHAR2(8),
    tax4code                       VARCHAR2(8),
    tax5code                       VARCHAR2(8),
    sparepartautoadd               VARCHAR2(1) NOT NULL,
    hazardid                       VARCHAR2(8),
    classstructureid               VARCHAR2(20),
    inspectionrequired             VARCHAR2(1) NOT NULL,
    sourcesysid                    VARCHAR2(10),
    ownersysid                     VARCHAR2(10),
    externalrefid                  VARCHAR2(10),
    in24                           VARCHAR2(1),
    in25                           VARCHAR2(1),
    in26                           VARCHAR2(1),
    in27                           VARCHAR2(1),
    apiseq                         VARCHAR2(50),
    interid                        VARCHAR2(50),
    migchangeid                    VARCHAR2(50),
    sendersysid                    VARCHAR2(50),
    orgid                          VARCHAR2(8) NOT NULL,
    lifeexp                        NUMBER(10,2))
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Indexes for ITEM

CREATE UNIQUE INDEX cal ON item
  (
    itemnum                         ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/
CREATE UNIQUE INDEX item_ndx1 ON item
  (
    orgid                           ASC,
    itemnum                         ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/
CREATE INDEX item_ndx2 ON item
  (
    orgid                           ASC,
    interid                         ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/


-- Triggers for ITEM

CREATE TRIGGER item_verity_t
AFTER INSERT  OR UPDATE  OR  DELETE 
ON item
REFERENCING NEW AS NEW OLD AS OLD
FOR EACH ROW
Declare	 	AutoPreFixSeed 	Varchar2(20); 	RecordCount	Number; 	ActionFlag	Varchar2(1); 	ItemFlag	Varchar2(30); 	OrgId 		Varchar2(8); Begin    If 	   Inserting Then 	   ActionFlag := 'I'; 	   ItemFlag   := :new.itemnum; 	   OrgId      := :new.orgid;    Elsif Updating  Then 	   ActionFlag := 'U'; 	   ItemFlag   := :new.itemnum; 	   OrgId      := :new.orgid;    Elsif Deleting  Then 	   ActionFlag := 'D'; 	   ItemFlag   := :old.itemnum; 	   OrgId      := :old.orgid;    End If;     Select  ltrim(rtrim(prefix))||seed    Into    AutoPreFixSeed    From    autokey    Where   tbname ='VERITYACTION';     Select  Count(*)     Into    RecordCount    From    verityaction    Where   itemnum = ItemFlag    And 	   action = ActionFlag    And 	   transid = AutoPreFixSeed    And	   orgid = OrgId;     If      RecordCount = 0    Then    Insert Into verityaction(itemnum,action,transid,orgid) 	   Values 	   ( 	     ItemFlag, 	     ActionFlag, 	     AutoPreFixSeed, 	     OrgId 	   );    End If; Exception 	When Others then 	   raise_application_error(-20001,'Failure Encountered in executing Trigger ITEM_VERITY_T'); End;
/
CREATE TRIGGER item_t
BEFORE INSERT  OR UPDATE 
ON item
REFERENCING NEW AS NEW OLD AS OLD
FOR EACH ROW
DECLARE NEXTVAL INTEGER; BEGIN SELECT MAXSEQ.NEXTVAL INTO NEXTVAL FROM DUAL; :NEW.ROWSTAMP := NEXTVAL; END;
/

-- End of DDL Script for Table IFRMAXIMO.ITEM

-- Start of DDL Script for Table IFRMAXIMO.ITEMSPEC
-- Generated 9-mar-2004 20:08:53 from SYSMAN@MAQUINA4

CREATE TABLE itemspec
    (rowstamp                       VARCHAR2(40) NOT NULL,
    itemnum                        VARCHAR2(30) NOT NULL,
    assetattrid                    VARCHAR2(8) NOT NULL,
    rotating                       VARCHAR2(1) NOT NULL,
    classstructureid               VARCHAR2(20) NOT NULL,
    alleqspecusevalue              VARCHAR2(1) NOT NULL,
    alllocspecusevalue             VARCHAR2(1) NOT NULL,
    displaysequence                NUMBER NOT NULL,
    numvalue                       NUMBER(10,2),
    measureunitid                  VARCHAR2(8),
    alnvalue                       VARCHAR2(16),
    changedate                     DATE NOT NULL,
    changeby                       VARCHAR2(18) NOT NULL,
    is01                           VARCHAR2(10),
    is02                           VARCHAR2(10),
    is03                           VARCHAR2(10),
    is04                           DATE,
    is05                           NUMBER(15,2),
    orgid                          VARCHAR2(8) NOT NULL)
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Indexes for ITEMSPEC

CREATE UNIQUE INDEX itemspec_ndx1 ON itemspec
  (
    orgid                           ASC,
    itemnum                         ASC,
    assetattrid                     ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/
CREATE INDEX itemspec_ndx2 ON itemspec
  (
    orgid                           ASC,
    classstructureid                ASC,
    assetattrid                     ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/
CREATE INDEX itemspec_ndx3 ON itemspec
  (
    orgid                           ASC,
    assetattrid                     ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/


-- Triggers for ITEMSPEC

CREATE TRIGGER itemspec_t
BEFORE INSERT  OR UPDATE 
ON itemspec
REFERENCING NEW AS NEW OLD AS OLD
FOR EACH ROW
DECLARE 
NEXTVAL INTEGER; BEGIN SELECT MAXSEQ.NEXTVAL INTO NEXTVAL FROM DUAL; 
:NEW.ROWSTAMP := NEXTVAL; END;
/
CREATE TRIGGER itemspec_verity_t
AFTER INSERT  OR UPDATE  OR  DELETE 
ON itemspec
REFERENCING NEW AS NEW OLD AS OLD
FOR EACH ROW
Declare	 	AutoPreFixSeed 	Varchar2(20); 	RecordCount	Number; 	ItemFlag	Varchar2(30); 	OrgId		Varchar2(8); Begin    If 	   Inserting Then 	   ItemFlag   := :new.itemnum; 	   OrgId      := :new.orgid;    Elsif Updating  Then 	   ItemFlag   := :new.itemnum; 	   OrgId      := :new.orgid;    Elsif Deleting  Then 	   ItemFlag   := :old.itemnum; 	   OrgId      := :old.orgid;    End If;     Select  ltrim(rtrim(prefix))||seed    Into    AutoPreFixSeed    From    autokey    Where   tbname ='VERITYACTION';     Select  Count(*)     Into    RecordCount    From    verityaction    Where   itemnum = ItemFlag    And 	   action = 'U'    And 	   transid = AutoPreFixSeed    And	   orgid = OrgId;     If      RecordCount = 0    Then    Insert Into verityaction(itemnum,action,transid,orgid) 	   Values 	   ( 	     ItemFlag, 	     'U', 	     AutoPreFixSeed, 	     OrgId 	   );    End If; Exception 	When Others then 	   raise_application_error(-20001,'Failure Encountered in executing Trigger ITEMSPEC_VERITY_T'); End;
/

-- End of DDL Script for Table IFRMAXIMO.ITEMSPEC

-- Start of DDL Script for Table IFRMAXIMO.ITEMSTRUCT
-- Generated 9-mar-2004 20:09:09 from SYSMAN@MAQUINA4

CREATE TABLE itemstruct
    (rowstamp                       VARCHAR2(40) NOT NULL,
    itemnum                        VARCHAR2(30) NOT NULL,
    instance                       NUMBER NOT NULL,
    parent                         VARCHAR2(30),
    parinst                        NUMBER,
    itemid                         VARCHAR2(30) NOT NULL,
    quantity                       NUMBER(15,2),
    remark                         VARCHAR2(50),
    ldkey                          NUMBER,
    ias1                           VARCHAR2(10),
    ias2                           VARCHAR2(10),
    ias3                           VARCHAR2(10),
    ias4                           DATE,
    ias5                           NUMBER(15,2),
    orgid                          VARCHAR2(8) NOT NULL)
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Indexes for ITEMSTRUCT

CREATE UNIQUE INDEX itemstruct_ndx1 ON itemstruct
  (
    orgid                           ASC,
    itemid                          ASC,
    itemnum                         ASC,
    instance                        ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/


-- Triggers for ITEMSTRUCT

CREATE TRIGGER itemstruct_t
BEFORE INSERT  OR UPDATE 
ON itemstruct
REFERENCING NEW AS NEW OLD AS OLD
FOR EACH ROW
DECLARE 
NEXTVAL INTEGER; BEGIN SELECT MAXSEQ.NEXTVAL INTO NEXTVAL FROM DUAL; 
:NEW.ROWSTAMP := NEXTVAL; END;
/

-- End of DDL Script for Table IFRMAXIMO.ITEMSTRUCT

-- Start of DDL Script for Table IFRMAXIMO.JOBLABOR
-- Generated 9-mar-2004 20:09:14 from SYSMAN@MAQUINA4

CREATE TABLE joblabor
    (rowstamp                       VARCHAR2(40) NOT NULL,
    jpnum                          VARCHAR2(30) NOT NULL,
    jptask                         NUMBER,
    laborcode                      VARCHAR2(12) NOT NULL,
    craftqty                       NUMBER NOT NULL,
    laborhrs                       FLOAT(126) NOT NULL,
    ldkey                          NUMBER,
    jl1                            VARCHAR2(10),
    jl2                            DATE,
    jl3                            VARCHAR2(10),
    jl4                            VARCHAR2(20),
    jl5                            VARCHAR2(20),
    jl6                            NUMBER(15,2),
    vendor                         VARCHAR2(18),
    jl7                            VARCHAR2(10),
    jl8                            VARCHAR2(10),
    jl9                            VARCHAR2(10),
    orgid                          VARCHAR2(8) NOT NULL,
    siteid                         VARCHAR2(8) NOT NULL)
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Indexes for JOBLABOR

CREATE INDEX joblabor_ndx1 ON joblabor
  (
    siteid                          ASC,
    jpnum                           ASC,
    jptask                          ASC,
    laborcode                       ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/


-- Triggers for JOBLABOR

CREATE TRIGGER joblabor_t
BEFORE INSERT  OR UPDATE 
ON joblabor
REFERENCING NEW AS NEW OLD AS OLD
FOR EACH ROW
DECLARE NEXTVAL INTEGER; BEGIN SELECT MAXSEQ.NEXTVAL INTO NEXTVAL FROM DUAL; :NEW.ROWSTAMP := NEXTVAL; END;
/

-- End of DDL Script for Table IFRMAXIMO.JOBLABOR

-- Start of DDL Script for Table IFRMAXIMO.JOBMATERIAL
-- Generated 9-mar-2004 20:09:21 from SYSMAN@MAQUINA4

CREATE TABLE jobmaterial
    (rowstamp                       VARCHAR2(40) NOT NULL,
    jpnum                          VARCHAR2(30) NOT NULL,
    jptask                         NUMBER,
    itemnum                        VARCHAR2(30) NOT NULL,
    location                       VARCHAR2(18),
    itemqty                        NUMBER(15,2) NOT NULL,
    ldkey                          NUMBER,
    directreq                      VARCHAR2(1) NOT NULL,
    vendor                         VARCHAR2(18),
    jm1                            VARCHAR2(10),
    jm2                            VARCHAR2(10),
    jm3                            NUMBER(15,2),
    jm4                            NUMBER(15,2),
    jm5                            VARCHAR2(50),
    jm6                            VARCHAR2(10),
    orgid                          VARCHAR2(8) NOT NULL,
    siteid                         VARCHAR2(8) NOT NULL)
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Indexes for JOBMATERIAL

CREATE INDEX jobmaterial_ndx1 ON jobmaterial
  (
    siteid                          ASC,
    jpnum                           ASC,
    jptask                          ASC,
    itemnum                         ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/


-- Triggers for JOBMATERIAL

CREATE TRIGGER jobmaterial_t
BEFORE INSERT  OR UPDATE 
ON jobmaterial
REFERENCING NEW AS NEW OLD AS OLD
FOR EACH ROW
DECLARE 
NEXTVAL INTEGER; BEGIN SELECT MAXSEQ.NEXTVAL INTO NEXTVAL FROM DUAL; 
:NEW.ROWSTAMP := NEXTVAL; END;
/

-- End of DDL Script for Table IFRMAXIMO.JOBMATERIAL

-- Start of DDL Script for Table IFRMAXIMO.JOBPLAN
-- Generated 9-mar-2004 20:09:26 from SYSMAN@MAQUINA4

CREATE TABLE jobplan
    (rowstamp                       VARCHAR2(40) NOT NULL,
    jpnum                          VARCHAR2(30) NOT NULL,
    description                    VARCHAR2(120),
    jpduration                     FLOAT(126) NOT NULL,
    laborcode                      VARCHAR2(12),
    jp1                            VARCHAR2(10),
    jp2                            VARCHAR2(10),
    jp3                            NUMBER(10,2),
    jp4                            VARCHAR2(10),
    jp5                            NUMBER,
    ldkey                          NUMBER,
    interruptable                  VARCHAR2(1) NOT NULL,
    downtime                       VARCHAR2(1) NOT NULL,
    supervisor                     VARCHAR2(12),
    calendar                       VARCHAR2(8),
    priority                       NUMBER NOT NULL,
    crewid                         VARCHAR2(12),
    jp6                            VARCHAR2(10),
    jp7                            VARCHAR2(10),
    jp8                            VARCHAR2(10),
    jp9                            NUMBER(10,2),
    jp10                           VARCHAR2(10),
    jp11                           VARCHAR2(10),
    jp12                           VARCHAR2(10),
    jp13                           VARCHAR2(10),
    jp14                           NUMBER(10,2),
    jp15                           DATE,
    jp16                           VARCHAR2(10),
    jp17                           VARCHAR2(10),
    jp18                           VARCHAR2(10),
    jp19                           VARCHAR2(10),
    jp20                           VARCHAR2(10),
    jp21                           VARCHAR2(10),
    jp22                           VARCHAR2(10),
    jp23                           NUMBER(10,2),
    jp24                           DATE,
    jp25                           NUMBER(15,2),
    jp26                           NUMBER(15,2),
    jp27                           VARCHAR2(10),
    jp28                           VARCHAR2(10),
    jp29                           NUMBER,
    jp30                           VARCHAR2(1),
    orgid                          VARCHAR2(8) NOT NULL,
    siteid                         VARCHAR2(8) NOT NULL)
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Indexes for JOBPLAN

CREATE UNIQUE INDEX jobplan_ndx1 ON jobplan
  (
    siteid                          ASC,
    jpnum                           ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/


-- Triggers for JOBPLAN

CREATE TRIGGER jobplan_t
BEFORE INSERT  OR UPDATE 
ON jobplan
REFERENCING NEW AS NEW OLD AS OLD
FOR EACH ROW
DECLARE NEXTVAL INTEGER; BEGIN SELECT MAXSEQ.NEXTVAL INTO NEXTVAL FROM DUAL; :NEW.ROWSTAMP := NEXTVAL; END;
/

-- End of DDL Script for Table IFRMAXIMO.JOBPLAN

-- Start of DDL Script for Table IFRMAXIMO.JOBTASK
-- Generated 9-mar-2004 20:09:31 from SYSMAN@MAQUINA4

CREATE TABLE jobtask
    (rowstamp                       VARCHAR2(40) NOT NULL,
    jpnum                          VARCHAR2(30) NOT NULL,
    jptask                         NUMBER NOT NULL,
    description                    VARCHAR2(200),
    taskduration                   FLOAT(126) NOT NULL,
    ldkey                          NUMBER,
    jo1                            VARCHAR2(10),
    jo2                            VARCHAR2(10),
    jo3                            VARCHAR2(10),
    jo4                            NUMBER(15,2),
    jo5                            VARCHAR2(10),
    pointname                      VARCHAR2(16),
    jo6                            VARCHAR2(10),
    jo7                            VARCHAR2(10),
    jo8                            VARCHAR2(10),
    orgid                          VARCHAR2(8) NOT NULL,
    siteid                         VARCHAR2(8) NOT NULL)
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Indexes for JOBTASK

CREATE UNIQUE INDEX jobtask_ndx1 ON jobtask
  (
    siteid                          ASC,
    jpnum                           ASC,
    jptask                          ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/


-- Triggers for JOBTASK

CREATE TRIGGER jobtask_t
BEFORE INSERT  OR UPDATE 
ON jobtask
REFERENCING NEW AS NEW OLD AS OLD
FOR EACH ROW
DECLARE 
NEXTVAL INTEGER; BEGIN SELECT MAXSEQ.NEXTVAL INTO NEXTVAL FROM DUAL; 
:NEW.ROWSTAMP := NEXTVAL; END;
/

-- End of DDL Script for Table IFRMAXIMO.JOBTASK

-- Start of DDL Script for Table IFRMAXIMO.JOBTOOL
-- Generated 9-mar-2004 20:09:38 from SYSMAN@MAQUINA4

CREATE TABLE jobtool
    (rowstamp                       VARCHAR2(40) NOT NULL,
    jpnum                          VARCHAR2(30) NOT NULL,
    jptask                         NUMBER,
    toolnum                        VARCHAR2(16) NOT NULL,
    toolqty                        NUMBER NOT NULL,
    toolhrs                        FLOAT(126) NOT NULL,
    ldkey                          NUMBER,
    jt1                            VARCHAR2(10),
    jt2                            VARCHAR2(10),
    jt3                            NUMBER,
    jt4                            VARCHAR2(10),
    jt5                            NUMBER(10,2),
    jt6                            NUMBER(15,2),
    orgid                          VARCHAR2(8) NOT NULL,
    siteid                         VARCHAR2(8) NOT NULL)
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Indexes for JOBTOOL

CREATE INDEX jobtool_ndx1 ON jobtool
  (
    siteid                          ASC,
    jpnum                           ASC,
    jptask                          ASC,
    toolnum                         ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/


-- Triggers for JOBTOOL

CREATE TRIGGER jobtool_t
BEFORE INSERT  OR UPDATE 
ON jobtool
REFERENCING NEW AS NEW OLD AS OLD
FOR EACH ROW
DECLARE NEXTVAL INTEGER; BEGIN SELECT MAXSEQ.NEXTVAL INTO NEXTVAL FROM DUAL; :NEW.ROWSTAMP := NEXTVAL; END;
/

-- End of DDL Script for Table IFRMAXIMO.JOBTOOL

-- Start of DDL Script for Table IFRMAXIMO.JOBTOOL_BKP
-- Generated 9-mar-2004 20:09:45 from SYSMAN@MAQUINA4

CREATE TABLE jobtool_bkp
    (rowstamp                       VARCHAR2(40) NOT NULL,
    jpnum                          VARCHAR2(30) NOT NULL,
    jptask                         NUMBER,
    toolnum                        VARCHAR2(16) NOT NULL,
    toolqty                        NUMBER NOT NULL,
    toolhrs                        FLOAT(126) NOT NULL,
    ldkey                          NUMBER,
    jt1                            VARCHAR2(10),
    jt2                            VARCHAR2(10),
    jt3                            NUMBER,
    jt4                            VARCHAR2(10),
    jt5                            NUMBER(10,2),
    jt6                            VARCHAR2(10),
    orgid                          VARCHAR2(8) NOT NULL,
    siteid                         VARCHAR2(8) NOT NULL)
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- End of DDL Script for Table IFRMAXIMO.JOBTOOL_BKP

-- Start of DDL Script for Table IFRMAXIMO.JPASSETSPLINK
-- Generated 9-mar-2004 20:09:46 from SYSMAN@MAQUINA4

CREATE TABLE jpassetsplink
    (rowstamp                       VARCHAR2(40) NOT NULL,
    jpassetsplinkid                NUMBER NOT NULL,
    jpnum                          VARCHAR2(30) NOT NULL,
    safetyplanid                   VARCHAR2(16),
    itemnum                        VARCHAR2(30),
    eqnum                          VARCHAR2(12),
    location                       VARCHAR2(18),
    isdefaultassetsp               VARCHAR2(1) NOT NULL,
    jpsp01                         VARCHAR2(10),
    jpsp02                         VARCHAR2(10),
    jpsp03                         VARCHAR2(10),
    jpsp04                         VARCHAR2(10),
    jpsp05                         NUMBER(10,2),
    jpsp06                         DATE,
    jpsp07                         NUMBER(15,2),
    jpsp08                         VARCHAR2(10),
    woreqwhenpurch                 VARCHAR2(1) NOT NULL,
    wotypewhenpurch                VARCHAR2(7),
    orgid                          VARCHAR2(8) NOT NULL,
    siteid                         VARCHAR2(8) NOT NULL)
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Indexes for JPASSETSPLINK

CREATE UNIQUE INDEX jpassetsplink_ndx1 ON jpassetsplink
  (
    siteid                          ASC,
    jpassetsplinkid                 ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/


-- Triggers for JPASSETSPLINK

CREATE TRIGGER jpassetsplink_t
BEFORE INSERT  OR UPDATE 
ON jpassetsplink
REFERENCING NEW AS NEW OLD AS OLD
FOR EACH ROW
DECLARE 
NEXTVAL INTEGER; BEGIN SELECT MAXSEQ.NEXTVAL INTO NEXTVAL FROM DUAL; 
:NEW.ROWSTAMP := NEXTVAL; END;
/

-- End of DDL Script for Table IFRMAXIMO.JPASSETSPLINK

-- Start of DDL Script for Table IFRMAXIMO.KPI
-- Generated 9-mar-2004 20:09:52 from SYSMAN@MAQUINA4

CREATE TABLE kpi
    (rowstamp                       VARCHAR2(40) NOT NULL,
    siteid                         VARCHAR2(8) NOT NULL,
    kpiname                        VARCHAR2(20) NOT NULL,
    description                    VARCHAR2(254),
    ldkey                          NUMBER,
    kpivalue                       NUMBER(10,2) NOT NULL,
    kpidate                        DATE NOT NULL,
    cautionmin                     NUMBER(10,2) NOT NULL,
    cautionmax                     NUMBER(10,2) NOT NULL,
    orgid                          VARCHAR2(8) NOT NULL)
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Indexes for KPI

CREATE UNIQUE INDEX kpi_ndx1 ON kpi
  (
    siteid                          ASC,
    kpiname                         ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/


-- Triggers for KPI

CREATE TRIGGER kpi_t
BEFORE INSERT  OR UPDATE 
ON kpi
REFERENCING NEW AS NEW OLD AS OLD
FOR EACH ROW
DECLARE 
NEXTVAL INTEGER; BEGIN SELECT MAXSEQ.NEXTVAL INTO NEXTVAL FROM DUAL; 
:NEW.ROWSTAMP := NEXTVAL; END;
/

-- End of DDL Script for Table IFRMAXIMO.KPI

-- Start of DDL Script for Table IFRMAXIMO.LABAVAIL
-- Generated 9-mar-2004 20:09:58 from SYSMAN@MAQUINA4

CREATE TABLE labavail
    (rowstamp                       VARCHAR2(40) NOT NULL,
    laborcode                      VARCHAR2(12) NOT NULL,
    shiftnum                       VARCHAR2(8) NOT NULL,
    lastfinish                     DATE,
    hold                           VARCHAR2(1) NOT NULL,
    workdate                       DATE NOT NULL,
    starttime                      DATE,
    endtime                        DATE,
    workhours                      FLOAT(126),
    changedate                     DATE NOT NULL,
    orgid                          VARCHAR2(8) NOT NULL)
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Indexes for LABAVAIL

CREATE UNIQUE INDEX labavail_ndx1 ON labavail
  (
    orgid                           ASC,
    workdate                        ASC,
    shiftnum                        ASC,
    laborcode                       ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/


-- Triggers for LABAVAIL

CREATE TRIGGER labavail_t
BEFORE INSERT  OR UPDATE 
ON labavail
REFERENCING NEW AS NEW OLD AS OLD
FOR EACH ROW
DECLARE 
NEXTVAL INTEGER; BEGIN SELECT MAXSEQ.NEXTVAL INTO NEXTVAL FROM DUAL; 
:NEW.ROWSTAMP := NEXTVAL; END;
/

-- End of DDL Script for Table IFRMAXIMO.LABAVAIL

-- Start of DDL Script for Table IFRMAXIMO.LABOR
-- Generated 9-mar-2004 20:10:03 from SYSMAN@MAQUINA4

CREATE TABLE labor
    (rowstamp                       VARCHAR2(40) NOT NULL,
    laborcode                      VARCHAR2(12) NOT NULL,
    craft                          VARCHAR2(12),
    calnum                         VARCHAR2(8),
    quantity                       NUMBER,
    name                           VARCHAR2(120),
    address1                       VARCHAR2(80),
    address2                       VARCHAR2(36),
    address3                       VARCHAR2(36),
    phonenum                       VARCHAR2(20),
    payrate                        NUMBER(18,2) NOT NULL,
    otscale                        NUMBER(8,3) NOT NULL,
    birthdate                      DATE,
    reportedhrs                    FLOAT(126) NOT NULL,
    ytdothrs                       FLOAT(126) NOT NULL,
    ytdhrsrefused                  FLOAT(126) NOT NULL,
    lastevaldate                   DATE,
    nextevaldate                   DATE,
    skill                          VARCHAR2(50),
    hiredate                       DATE,
    iscraft                        VARCHAR2(1) NOT NULL,
    la1                            VARCHAR2(50),
    la2                            FLOAT(126),
    la3                            VARCHAR2(50),
    la4                            VARCHAR2(50),
    la5                            VARCHAR2(10),
    la6                            VARCHAR2(10),
    la7                            VARCHAR2(20),
    la8                            VARCHAR2(50),
    la9                            VARCHAR2(150),
    la10                           VARCHAR2(4),
    ldkey                          NUMBER,
    outside                        VARCHAR2(1) NOT NULL,
    availfactor                    NUMBER(15,2) NOT NULL,
    crewid                         VARCHAR2(12),
    address4                       VARCHAR2(36),
    la11                           VARCHAR2(20),
    la12                           VARCHAR2(20),
    la13                           NUMBER(15,2),
    la14                           VARCHAR2(4) NOT NULL,
    la15                           DATE,
    la16                           NUMBER,
    la17                           VARCHAR2(10),
    la18                           VARCHAR2(10),
    la19                           NUMBER(10,2),
    la20                           DATE,
    callid                         VARCHAR2(20),
    type                           VARCHAR2(8),
    worklocation                   VARCHAR2(18),
    storelocation                  VARCHAR2(18),
    glaccount                      VARCHAR2(20),
    controlacc                     VARCHAR2(20) NOT NULL,
    vendor                         VARCHAR2(18),
    disabled                       VARCHAR2(1) NOT NULL,
    serviceprovider                VARCHAR2(18),
    pagepin                        VARCHAR2(50),
    pagemethod                     VARCHAR2(16),
    pagingavailability             VARCHAR2(16),
    wopriority                     NUMBER,
    supervisor                     VARCHAR2(12),
    delegate                       VARCHAR2(12),
    shiptolocation                 VARCHAR2(50),
    favmrnum                       VARCHAR2(8),
    droppoint                      VARCHAR2(12),
    wfmailelection                 VARCHAR2(15),
    acceptingwfmail                VARCHAR2(1) NOT NULL,
    defaultstoreloc                VARCHAR2(18),
    sourcesysid                    VARCHAR2(10),
    ownersysid                     VARCHAR2(10),
    externalrefid                  VARCHAR2(10),
    la21                           VARCHAR2(10),
    la22                           VARCHAR2(10),
    la23                           VARCHAR2(10),
    la24                           VARCHAR2(10),
    la25                           VARCHAR2(10),
    pcardnum                       VARCHAR2(30),
    pcardtype                      VARCHAR2(20),
    pcardexpdate                   VARCHAR2(7),
    pcardverification              VARCHAR2(4),
    transemailelection             VARCHAR2(15) NOT NULL,
    orgid                          VARCHAR2(8) NOT NULL,
    siteid                         VARCHAR2(8),
    interid                        VARCHAR2(50),
    apiseq                         VARCHAR2(50))
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Indexes for LABOR

CREATE UNIQUE INDEX labor_ndx1 ON labor
  (
    orgid                           ASC,
    laborcode                       ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/
CREATE INDEX labor_ndx2 ON labor
  (
    orgid                           ASC,
    craft                           ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/
CREATE INDEX labor_ndx3 ON labor
  (
    orgid                           ASC,
    calnum                          ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/
CREATE INDEX labor_ndx4 ON labor
  (
    orgid                           ASC,
    interid                         ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/


-- Triggers for LABOR

CREATE TRIGGER tr_homem_hora
BEFORE INSERT  OR UPDATE 
ON labor
REFERENCING NEW AS NEW OLD AS OLD
FOR EACH ROW
DECLARE
v_cargo          labor.craft%type :='';
v_cargoI         labor.craft%type :='';
v_car            ifrsrh.cad_maximo.emp_qlp_car_codigo%type :=0;
v_erro           varchar2(150);
v_ocupacao       ifrmaximo.labor.la3%type   :='';
cont             number(15)                 :=0;
v_hh             historico_niveis_salariais.hns_valor_remuneracao%type;
v_tipo           cad_maximo.emp_tipo_remuneracao_funcao%type;
v_rg             cad_maximo.valor_rg%type;
v_fg             cad_maximo.valor_fg%type;
v_salario        cad_maximo.salario%type;
v_carga_horaria  cad_maximo.carga_horaria_funcionario%type;
v_insalubridade  cad_maximo.insalubridade%type;
v_periculosidade cad_maximo.periculosidade%type;
BEGIN
   IF INSERTING THEN
      BEGIN
         If (:new.outside = 'N') And (SUBSTR(:NEW.LABORCODE,1,1) = 'C') Then
            raise_application_error(-20650,'PARA INSERIR UM FUNCIONÁRIO TERCEIRIZADO, UTILIZE A APLICAÇÃO: MÃO DE OBRA - CONTRATADA.');
         End If;
         If (:new.outside = 'S') And (SUBSTR(:NEW.LABORCODE,1,1) = 'I') Then
            raise_application_error(-20651,'PARA INSERIR UM FUNCIONÁRIO ORGÂNICO, UTILIZE A APLICAÇÃO: MÃO DE OBRA - INFRAERO.');
         End If;
         If (SUBSTR(:NEW.LABORCODE,1,1) = 'I') Then
            FOR I IN 1..length(:NEW.LABORCODE)  Loop
               Begin
                  If substr(:new.laborcode,I,1) IN ('I','1','2','3','4','5','6','7','8','9','0') Then
                     cont := cont + 1;
                  Else
                     raise_application_error(-20646,'MATRÍCULA COM FORMATO INCORRETO.');
                  End If;
               End;
            End Loop;
            Begin
               v_erro           := null;
               v_tipo           :='0';
               v_salario        := 0;
               v_hh             := 0;
               v_carga_horaria  := 0;
               v_insalubridade  := 0;
               v_periculosidade := 0;
               SELECT DISTINCT
                  a.car_sigla,  b.occ_descricao,
                  decode(c.emp_qlp_car_codigo, 200,'1',
                                               201,'2',
                                               214,'3',  216,'3',
                                               413,'4',
                                               408,'5',
                                               336,'6',
                                               337,'7',
                                               338,'8',
                                               341,'9',
                                               414,'10',
                                               317,'11',
               			                       415,'12',
                                               300,'13', 301,'13', 304,'13', 308,'13', 309,'13', 402,'13',
                                               310,'14', 403,'14', 407,'14',
                                               335,'15', 405,'15', 406,'15',
                                               324,'16', 327,'16', 330,'16',
                                               323,'17', 325,'17', 326,'17', 333,'17', 404,'17', 417,'17',
                  	                       c.emp_qlp_car_codigo),
                  c.emp_data_admissao,
                  'N',
                  LPAD(emp_dep_codigo_lotacao,3,'0')||'/'||substr(c.emp_ati_ct_custos,1,5)||'-'||substr(c.emp_ati_ct_custos,6,1),
                  d.eso_nome,
                  c.emp_nome,
                  decode(c.emp_status,1,'ATIVO',2,'DESLIGADO',0,'AFASTADO'),
                  decode(TO_CHAR(c.emp_dep_codigo_lotacao),
                             1,'DEMA',                                                                                     
                             2,'SBBR',                                                                                     
                             4,'SBBE',                                                                                     
                             7,'SBCT',                                                                                     
                            10,'SBFZ',
                            11,'SBGO',                                                                                     
                            13,'SBPA',                                                                                     
                            14,'SBRF',                                                                                     
                            15,'SBSV',                                                                                     
                            20,'SBMO',                                                                                     
                            24,'SBSP',                                                                                     
                            25,'SBEG',                                                                                    
                            26,'SBKP',                                                                                     
                            28,'SBNT',                                                                                     
                            55,'SBSP',                                                                                     
                            57,'SBGR',                                                                                     
                            58,'SBCF',                                                                                     
                            61,'SBGL',                                                                                     
                            62,'SBRJ',                                                                                     
                            66,'SBBR',                                                                                    
                            67,'SBPA',                                                                                    
                            68,'SBBE',                                                                                    
                            69,'SBRF',                                                                                    
                            70,'SBEG',                                                                                    
                            TO_CHAR(c.emp_dep_codigo_lotacao)),
                  c.carga_horaria_funcionario,
                  c.emp_tipo_remuneracao_funcao,
                  c.valor_rg,
                  c.valor_fg,
                  c.salario,
                  c.periculosidade,
                  c.insalubridade
               INTO   v_cargo, v_ocupacao, v_car, :new.hiredate,:new.outside,:new.controlacc,:new.la4,:new.name,:new.la6,:new.la14,
                      v_carga_horaria, v_tipo, v_rg, v_fg, v_salario, v_periculosidade, v_insalubridade
               FROM   cargos  a,
                      ocupacoes_cargo b,
                      escolaridades d,
                      cad_maximo c
               WHERE   ((c.emp_numero_matricula     = To_number(substr(:NEW.LABORCODE,2,12)))
                   AND ((c.emp_qlp_car_codigo       = a.car_codigo)
                   AND  (c.emp_qlp_car_occ_codigo   = a.car_occ_codigo))
                   AND  (c.emp_qlp_car_occ_codigo   = b.occ_codigo)
                   AND  (c.emp_eso_codigo           = d.eso_codigo));
            Exception
               when no_data_found then
                  raise_application_error(-20647,'FUNCIONÁRIO NÃO CADASTRADO NO GESTORRH');
            End;
            IF (v_car  = '1') THEN
               v_cargo    := 'AS-II';
               v_ocupacao := 'ADMINISTRADOR';
            END IF;
            IF (v_car = '2') then
               v_cargo    := 'AS-II';
               v_ocupacao := 'ADVOGADO';
            END IF;
            IF (v_car = '3') then
               v_cargo    := 'AS-II';
               v_ocupacao := 'ESPECIALISTA';
            END IF;
            IF (v_car  = '4') THEN
               v_cargo    := 'PANA';
               v_ocupacao := 'OPERADOR DE ESTAÇÃO AERONÁUTICA';
            END IF;
            IF (v_car = '5') THEN
               v_cargo    := 'PEM';
               v_ocupacao := 'MECÂNICO DE GRUPOS ELETRÓGENOS';
            END IF;
            IF (v_car  = '6') THEN
               v_cargo    := 'PEM';
               v_ocupacao := 'TÉCNICO EM EDIFICAÇÕES';
            END IF;
            IF (v_car = '7') THEN
               v_cargo    := 'PEM';
               v_ocupacao := 'TÉCNICO EM ELETRÔNICA';
            END IF;
            IF (v_car  = '8') THEN
               v_cargo    := 'PEM';
               v_ocupacao := 'TÉCNICO EM ELETROTÉCNICA';
            END IF;
            IF (v_car = '9') THEN
               v_cargo    := 'PEM';
               v_ocupacao := 'TOPÓGRAFO';
            END IF;
            IF (v_car = '10') THEN
               v_cargo    := 'PMET';
               v_ocupacao := 'CARGO NÃO EXIGE';
            END IF;
            IF (v_car = '11') THEN
               v_cargo    := 'PST';
               v_ocupacao := 'TÉCNICO EM CONTABILIDADE';
            END IF;
            IF (v_car = '12') THEN
               v_cargo    := 'PTA';
               v_ocupacao := 'CARGO NÃO EXIGE';
            END IF;
            IF (v_car = '13') THEN
               v_cargo    :='PSA';
               v_ocupacao :='ADMINISTRAÇÃO E FINANÇAS';
            END IF;
            IF (v_car ='14') THEN
               v_cargo    :='PSA';
               v_ocupacao :='CARGA AÉREA';
            END IF;
            IF (v_car ='15') THEN
               v_cargo    :='PSA';
               v_ocupacao :='ENGENHARIA E MANUTENÇÃO';
            END IF;
            IF (v_car ='16') THEN
               v_cargo    := 'PSA';
               v_ocupacao := 'SALVAMENTO E COMBATE A INCÊNDIO';
            END IF;
            IF (v_car ='17') THEN
               v_cargo    := 'PSA';
               v_ocupacao := 'TRÁFEGO E SEGURANÇA';
            END IF;
            v_cargoI :='';
            IF (:new.la14 = 'DEMA') Then
               v_cargoI := v_cargo||:new.la14;
            END IF;
            IF (:new.la14 <> 'DEMA') Then
               v_cargoI := v_cargo||substr(:new.la14,3,2);
            END IF;
            --------- Cálculo do Homem Hora ---------
            IF V_CARGA_HORARIA <> 0 THEN
               BEGIN
                  IF v_tipo = 'RG' THEN
                     v_hh := ROUND((((v_rg + v_insalubridade + v_periculosidade) / v_carga_horaria)* 1.7544),2);
                  END IF;
                  IF v_tipo = 'FG' THEN
                     v_hh := ROUND(((( v_salario + v_fg + v_insalubridade + v_periculosidade)/ v_carga_horaria) * 1.7544),2);
                  END IF;
                  IF ((v_tipo) = 'NR') THEN
                     v_hh := ROUND(((( v_salario + v_insalubridade + v_periculosidade)/ v_carga_horaria) * 1.7544),2);
                  END IF;
               END;
            END IF;
            IF V_CARGA_HORARIA = 0 THEN
               BEGIN
                   raise_application_error(-20651,'A CARGA HORÁRIA DO FUNCIONÁRIO ESTÁ INCORRETA. ENTRE EM CONTATO COM O SUPORTE MAXIMO.');  
               END;
            END IF;
            ---------------------------------------
             :NEW.CRAFT   := V_CARGOI;
             :NEW.LA3     := V_OCUPACAO;
             :NEW.PAYRATE := V_HH;
         END IF;  -- (SUBSTR(:NEW.LABORCODE,1,1) = 'I') Then
         IF (SUBSTR(:NEW.LABORCODE,1,1) = 'C') THEN
            FOR I IN 1..length(:NEW.LABORCODE)  Loop
               Begin
                  If substr(:new.laborcode,I,1) IN ('C','1','2','3','4','5','6','7','8','9','0') Then
                     cont := cont + 1;
                   Else
                      raise_application_error(-20646,'CÓDIGO DE IDENTIFICAÇÃO DO FUNCIONÁRIO TERCEIRIZADO INCORRETO.');
                   End If;
               End;
            End Loop;
         END IF;  -- (SUBSTR(:NEW.LABORCODE,1,1) = 'C') Then
         IF ((SUBSTR(:NEW.LABORCODE,1,1) <> 'C') and (SUBSTR(:NEW.LABORCODE,1,1) <> 'I')) THEN
            raise_application_error(-20648,'MATRÍCULA INCORRETA.');
         END IF;
      END;
   END IF;
 IF UPDATING THEN
      BEGIN
         If (SUBSTR(:NEW.LABORCODE,1,1) = 'I') Then
            FOR I IN 1..length(:NEW.LABORCODE)  Loop
               Begin
                  If substr(:new.laborcode,I,1) IN ('I','1','2','3','4','5','6','7','8','9','0') Then
                     cont := cont + 1;
                  Else
                     raise_application_error(-20646,'MATRÍCULA COM FORMATO INCORRETO.');
                  End If;
               End;
            End Loop;
            Begin
               v_erro           := null;
               v_tipo           :='0';
               v_salario        := 0;
               v_carga_horaria  := 0;
               v_insalubridade  := 0;
               v_periculosidade := 0;
               SELECT DISTINCT
                  a.car_sigla,  b.occ_descricao,
                  decode(c.emp_qlp_car_codigo, 200,'1',
                                               201,'2',
                                               214,'3',  216,'3',
                                               413,'4',
                                               408,'5',
                                               336,'6',
                                               337,'7',
                                               338,'8',
                                               341,'9',
                                               414,'10',
                                               317,'11',
        			                           415,'12',
                                               300,'13', 301,'13', 304,'13', 308,'13', 309,'13', 402,'13',
                                               310,'14', 403,'14', 407,'14',
                                               335,'15', 405,'15', 406,'15',
                                               324,'16', 327,'16', 330,'16',
                                               323,'17', 325,'17', 326,'17', 333,'17', 404,'17', 417,'17',
                  	                       c.emp_qlp_car_codigo),
                  c.emp_data_admissao,
                  'N',
                  LPAD(emp_dep_codigo_lotacao,3,'0')||'/'||substr(c.emp_ati_ct_custos,1,5)||'-'||substr(c.emp_ati_ct_custos,6,1),
                  d.eso_nome,
                  c.emp_nome,
                  decode(c.emp_status,1,'ATIVO',2,'DESLIGADO',0,'AFASTADO'),
                  decode(TO_CHAR(c.emp_dep_codigo_lotacao),
                             1,'DEMA',                                                                                     
                             2,'SBBR',                                                                                     
                             4,'SBBE',                                                                                     
                             7,'SBCT',                                                                                     
                            10,'SBFZ',
                            11,'SBGO',                                                                                     
                            13,'SBPA',                                                                                     
                            14,'SBRF',                                                                                     
                            15,'SBSV',                                                                                     
                            20,'SBMO',                                                                                     
                            24,'SBSP',                                                                                     
                            25,'SBEG',                                                                                    
                            26,'SBKP',                                                                                     
                            28,'SBNT',                                                                                     
                            55,'SBSP',                                                                                     
                            57,'SBGR',                                                                                     
                            58,'SBCF',                                                                                     
                            61,'SBGL',                                                                                     
                            62,'SBRJ',                                                                                     
                            66,'SBBR',                                                                                    
                            67,'SBPA',                                                                                    
                            68,'SBBE',                                                                                    
                            69,'SBRF',                                                                                    
                            70,'SBEG',                                                                                    
                            TO_CHAR(c.emp_dep_codigo_lotacao)),
                  c.carga_horaria_funcionario,
                  c.emp_tipo_remuneracao_funcao,
                  c.valor_rg,
                  c.valor_fg,
                  c.salario,
                  c.periculosidade,
                  c.insalubridade
               INTO   v_cargo, v_ocupacao, v_car, :new.hiredate,:new.outside,:new.controlacc,:new.la4,:new.name,:new.la6,:new.la14,
                      v_carga_horaria, v_tipo, v_rg, v_fg, v_salario, v_periculosidade, v_insalubridade
               FROM   cargos  a,
                      ocupacoes_cargo b,
                      escolaridades d,
                      cad_maximo c
               WHERE   ((c.emp_numero_matricula     = To_number(substr(:NEW.LABORCODE,2,12)))
                   AND ((c.emp_qlp_car_codigo       = a.car_codigo)
                   AND  (c.emp_qlp_car_occ_codigo   = a.car_occ_codigo))
                   AND  (c.emp_qlp_car_occ_codigo   = b.occ_codigo)
                   AND  (c.emp_eso_codigo           = d.eso_codigo));
            Exception
               when no_data_found then
                  raise_application_error(-20647,'FUNCIONÁRIO NÃO CADASTRADO NO GESTORRH');
            End;
            IF (v_car  = '1') THEN
               v_cargo    := 'AS-II';
               v_ocupacao := 'ADMINISTRADOR';
            END IF;
            IF (v_car = '2') then
               v_cargo    := 'AS-II';
               v_ocupacao := 'ADVOGADO';
            END IF;
            IF (v_car = '3') then
               v_cargo    := 'AS-II';
               v_ocupacao := 'ESPECIALISTA';
            END IF;
            IF (v_car  = '4') THEN
               v_cargo    := 'PANA';
               v_ocupacao := 'OPERADOR DE ESTAÇÃO AERONÁUTICA';
            END IF;
            IF (v_car = '5') THEN
               v_cargo    := 'PEM';
               v_ocupacao := 'MECÂNICO DE GRUPOS ELETRÓGENOS';
            END IF;
            IF (v_car  = '6') THEN
               v_cargo    := 'PEM';
               v_ocupacao := 'TÉCNICO EM EDIFICAÇÕES';
            END IF;
            IF (v_car = '7') THEN
               v_cargo    := 'PEM';
               v_ocupacao := 'TÉCNICO EM ELETRÔNICA';
            END IF;
            IF (v_car  = '8') THEN
               v_cargo    := 'PEM';
               v_ocupacao := 'TÉCNICO EM ELETROTÉCNICA';
            END IF;
            IF (v_car = '9') THEN
               v_cargo    := 'PEM';
               v_ocupacao := 'TOPÓGRAFO';
            END IF;
            IF (v_car = '10') THEN
               v_cargo    := 'PMET';
               v_ocupacao := 'CARGO NÃO EXIGE';
            END IF;
            IF (v_car = '11') THEN
               v_cargo    := 'PST';
               v_ocupacao := 'TÉCNICO EM CONTABILIDADE';
            END IF;
            IF (v_car = '12') THEN
               v_cargo    := 'PTA';
               v_ocupacao := 'CARGO NÃO EXIGE';
            END IF;
            IF (v_car = '13') THEN
               v_cargo    :='PSA';
               v_ocupacao :='ADMINISTRAÇÃO E FINANÇAS';
            END IF;
            IF (v_car ='14') THEN
               v_cargo    :='PSA';
               v_ocupacao :='CARGA AÉREA';
            END IF;
            IF (v_car ='15') THEN
               v_cargo    :='PSA';
               v_ocupacao :='ENGENHARIA E MANUTENÇÃO';
            END IF;
            IF (v_car ='16') THEN
               v_cargo    := 'PSA';
               v_ocupacao := 'SALVAMENTO E COMBATE A INCÊNDIO';
            END IF;
            IF (v_car ='17') THEN
               v_cargo    := 'PSA';
               v_ocupacao := 'TRÁFEGO E SEGURANÇA';
            END IF;
            v_cargoI :='';
            IF (:new.la14 = 'DEMA') Then
               v_cargoI := v_cargo||:new.la14;
            END IF;
            IF (:new.la14 <> 'DEMA') Then
               v_cargoI := v_cargo||substr(:new.la14,3,2);
            END IF;
            --------- Cálculo do Homem Hora ---------
            IF V_CARGA_HORARIA <> 0 THEN
               BEGIN
                  IF v_tipo = 'RG' THEN
                     v_hh := ROUND((((v_rg + v_insalubridade + v_periculosidade) / v_carga_horaria)* 1.7544),2);
                  END IF;
                  IF v_tipo = 'FG' THEN
                     v_hh := ROUND(((( v_salario + v_fg + v_insalubridade + v_periculosidade)/ v_carga_horaria) * 1.7544),2);
                  END IF;
                  IF ((v_tipo) = 'NR') THEN
                     v_hh := ROUND(((( v_salario + v_insalubridade + v_periculosidade)/ v_carga_horaria) * 1.7544),2);
                  END IF;
               END;
            END IF;
            ---------------------------------------
             :NEW.CRAFT   := V_CARGOI;
             :NEW.LA3     := V_OCUPACAO;
             :NEW.PAYRATE := V_HH;
         END IF;  -- (SUBSTR(:NEW.LABORCODE,1,1) = 'I') Then
      END;
   END IF; -- UPDATING
END;
/
CREATE TRIGGER labor_t
BEFORE INSERT  OR UPDATE 
ON labor
REFERENCING NEW AS NEW OLD AS OLD
FOR EACH ROW
DECLARE NEXTVAL INTEGER; BEGIN SELECT MAXSEQ.NEXTVAL INTO NEXTVAL FROM DUAL; :NEW.ROWSTAMP := NEXTVAL; END;
/

-- End of DDL Script for Table IFRMAXIMO.LABOR

-- Start of DDL Script for Table IFRMAXIMO.LABORAUTH
-- Generated 9-mar-2004 20:10:22 from SYSMAN@MAQUINA4

CREATE TABLE laborauth
    (rowstamp                       VARCHAR2(40) NOT NULL,
    name                           VARCHAR2(18) NOT NULL,
    laborcode                      VARCHAR2(12) NOT NULL,
    orgid                          VARCHAR2(8) NOT NULL,
    siteid                         VARCHAR2(8) NOT NULL)
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Indexes for LABORAUTH

CREATE UNIQUE INDEX laborauth_ndx1 ON laborauth
  (
    siteid                          ASC,
    name                            ASC,
    laborcode                       ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/


-- Triggers for LABORAUTH

CREATE TRIGGER laborauth_t
BEFORE INSERT  OR UPDATE 
ON laborauth
REFERENCING NEW AS NEW OLD AS OLD
FOR EACH ROW
DECLARE 
NEXTVAL INTEGER; BEGIN SELECT MAXSEQ.NEXTVAL INTO NEXTVAL FROM DUAL; 
:NEW.ROWSTAMP := NEXTVAL; END;
/

-- End of DDL Script for Table IFRMAXIMO.LABORAUTH

-- Start of DDL Script for Table IFRMAXIMO.LABTRANS
-- Generated 9-mar-2004 20:10:28 from SYSMAN@MAQUINA4

CREATE TABLE labtrans
    (rowstamp                       VARCHAR2(40) NOT NULL,
    transdate                      DATE NOT NULL,
    laborcode                      VARCHAR2(12) NOT NULL,
    craft                          VARCHAR2(12),
    payrate                        NUMBER(18,2) NOT NULL,
    otscale                        NUMBER(8,3) NOT NULL,
    eqnum                          VARCHAR2(12),
    regularhrs                     FLOAT(126) NOT NULL,
    othrs                          FLOAT(126) NOT NULL,
    enterby                        VARCHAR2(18) NOT NULL,
    enterdate                      DATE NOT NULL,
    ltwo1                          VARCHAR2(3),
    ltwo2                          VARCHAR2(3),
    ltwo3                          VARCHAR2(3),
    lt1                            VARCHAR2(10),
    lt2                            VARCHAR2(10),
    lt3                            VARCHAR2(10),
    lt4                            VARCHAR2(10),
    lt5                            NUMBER(15,2),
    lt6                            VARCHAR2(10),
    lt7                            VARCHAR2(1),
    ldkey                          NUMBER,
    startdate                      DATE NOT NULL,
    starttime                      DATE,
    finishdate                     DATE,
    finishtime                     DATE,
    transtype                      VARCHAR2(16) NOT NULL,
    outside                        VARCHAR2(1) NOT NULL,
    ltl1                           VARCHAR2(4),
    ltl2                           DATE,
    ltl3                           NUMBER,
    memo                           VARCHAR2(25),
    rollup                         VARCHAR2(1) NOT NULL,
    gldebitacct                    VARCHAR2(20),
    linecost                       NUMBER(10,2) NOT NULL,
    glcreditacct                   VARCHAR2(20),
    financialperiod                VARCHAR2(6),
    ponum                          VARCHAR2(8),
    polinenum                      NUMBER,
    location                       VARCHAR2(18),
    genapprservreceipt             VARCHAR2(1) NOT NULL,
    paymenttransdate               DATE,
    exchangerate2                  NUMBER(14,7),
    linecost2                      NUMBER(10,2),
    labtransid                     NUMBER NOT NULL,
    servrectransid                 NUMBER,
    sourcesysid                    VARCHAR2(10),
    ownersysid                     VARCHAR2(10),
    externalrefid                  VARCHAR2(10),
    lt8                            VARCHAR2(10),
    lt9                            VARCHAR2(10),
    apiseq                         VARCHAR2(50),
    interid                        VARCHAR2(50),
    migchangeid                    VARCHAR2(50),
    sendersysid                    VARCHAR2(50),
    expdone                        VARCHAR2(25),
    fincntrlid                     VARCHAR2(8),
    orgid                          VARCHAR2(8) NOT NULL,
    siteid                         VARCHAR2(8) NOT NULL,
    refwo                          VARCHAR2(18),
    enteredastask                  VARCHAR2(1) NOT NULL)
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Indexes for LABTRANS

CREATE UNIQUE INDEX labtrans_ndx1 ON labtrans
  (
    siteid                          ASC,
    labtransid                      ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/
CREATE INDEX labtrans_ndx2 ON labtrans
  (
    siteid                          ASC,
    laborcode                       ASC,
    transdate                       ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/
CREATE INDEX labtrans_ndx3 ON labtrans
  (
    siteid                          ASC,
    eqnum                           ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/
CREATE INDEX labtrans_ndx4 ON labtrans
  (
    siteid                          ASC,
    refwo                           ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/
CREATE INDEX labtrans_ndx5 ON labtrans
  (
    siteid                          ASC,
    interid                         ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/


-- Triggers for LABTRANS

CREATE TRIGGER labtrans_t
BEFORE INSERT  OR UPDATE 
ON labtrans
REFERENCING NEW AS NEW OLD AS OLD
FOR EACH ROW
DECLARE 
NEXTVAL INTEGER; BEGIN SELECT MAXSEQ.NEXTVAL INTO NEXTVAL FROM DUAL; 
:NEW.ROWSTAMP := NEXTVAL; END;
/

-- End of DDL Script for Table IFRMAXIMO.LABTRANS

-- Start of DDL Script for Table IFRMAXIMO.LANGUAGE
-- Generated 9-mar-2004 20:10:51 from SYSMAN@MAQUINA4

CREATE TABLE language
    (rowstamp                       VARCHAR2(40) NOT NULL,
    langcode                       VARCHAR2(3) NOT NULL,
    description                    VARCHAR2(250),
    ldkey                          NUMBER,
    yeschar                        VARCHAR2(1) NOT NULL,
    nochar                         VARCHAR2(1) NOT NULL,
    disabled                       VARCHAR2(1) NOT NULL)
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Indexes for LANGUAGE

CREATE UNIQUE INDEX lang_ndx1 ON language
  (
    langcode                        ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/


-- Triggers for LANGUAGE

CREATE TRIGGER language_t
BEFORE INSERT  OR UPDATE 
ON language
REFERENCING NEW AS NEW OLD AS OLD
FOR EACH ROW
DECLARE 
NEXTVAL INTEGER; BEGIN SELECT MAXSEQ.NEXTVAL INTO NEXTVAL FROM DUAL; 
:NEW.ROWSTAMP := NEXTVAL; END;
/

-- End of DDL Script for Table IFRMAXIMO.LANGUAGE

-- Start of DDL Script for Table IFRMAXIMO.LISTTRANSLATION
-- Generated 9-mar-2004 20:10:58 from SYSMAN@MAQUINA4

CREATE TABLE listtranslation
    (rowstamp                       VARCHAR2(40) NOT NULL,
    listname                       VARCHAR2(18) NOT NULL,
    translatedvalue                VARCHAR2(25) NOT NULL,
    langcode                       VARCHAR2(3) NOT NULL,
    value                          VARCHAR2(25) NOT NULL,
    valdesc                        VARCHAR2(30))
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Indexes for LISTTRANSLATION

CREATE UNIQUE INDEX listtrans_ndx1 ON listtranslation
  (
    listname                        ASC,
    langcode                        ASC,
    translatedvalue                 ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/


-- Triggers for LISTTRANSLATION

CREATE TRIGGER listtranslation_t
BEFORE INSERT  OR UPDATE 
ON listtranslation
REFERENCING NEW AS NEW OLD AS OLD
FOR EACH ROW
DECLARE 
NEXTVAL INTEGER; BEGIN SELECT MAXSEQ.NEXTVAL INTO NEXTVAL FROM DUAL; 
:NEW.ROWSTAMP := NEXTVAL; END;
/

-- End of DDL Script for Table IFRMAXIMO.LISTTRANSLATION

-- Start of DDL Script for Table IFRMAXIMO.LOCANCESTOR
-- Generated 9-mar-2004 20:11:06 from SYSMAN@MAQUINA4

CREATE TABLE locancestor
    (rowstamp                       VARCHAR2(40) NOT NULL,
    location                       VARCHAR2(18) NOT NULL,
    ancestor                       VARCHAR2(18) NOT NULL,
    systemid                       VARCHAR2(8) NOT NULL,
    siteid                         VARCHAR2(8) NOT NULL,
    orgid                          VARCHAR2(8) NOT NULL)
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Indexes for LOCANCESTOR

CREATE UNIQUE INDEX locancestor_ndx1 ON locancestor
  (
    siteid                          ASC,
    location                        ASC,
    systemid                        ASC,
    ancestor                        ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/
CREATE INDEX locancestor_ndx2 ON locancestor
  (
    siteid                          ASC,
    ancestor                        ASC,
    systemid                        ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/


-- Triggers for LOCANCESTOR

CREATE TRIGGER locancestor_t
BEFORE INSERT  OR UPDATE 
ON locancestor
REFERENCING NEW AS NEW OLD AS OLD
FOR EACH ROW
DECLARE 
NEXTVAL INTEGER; BEGIN SELECT MAXSEQ.NEXTVAL INTO NEXTVAL FROM DUAL; 
:NEW.ROWSTAMP := NEXTVAL; END;
/

-- End of DDL Script for Table IFRMAXIMO.LOCANCESTOR

-- Start of DDL Script for Table IFRMAXIMO.LOCATIONS
-- Generated 9-mar-2004 20:11:17 from SYSMAN@MAQUINA4

CREATE TABLE locations
    (rowstamp                       VARCHAR2(40) NOT NULL,
    location                       VARCHAR2(18) NOT NULL,
    description                    VARCHAR2(120),
    ldkey                          NUMBER,
    type                           VARCHAR2(15) NOT NULL,
    controlacc                     VARCHAR2(20),
    glaccount                      VARCHAR2(20),
    purchvaracc                    VARCHAR2(20),
    invoicevaracc                  VARCHAR2(20),
    curvaracc                      VARCHAR2(20),
    shrinkageacc                   VARCHAR2(20),
    invcostadjacc                  VARCHAR2(20),
    receiptvaracc                  VARCHAR2(20),
    changeby                       VARCHAR2(18) NOT NULL,
    changedate                     DATE NOT NULL,
    lo1                            VARCHAR2(10),
    lo2                            VARCHAR2(10),
    lo3                            VARCHAR2(10),
    lo4                            VARCHAR2(10),
    lo5                            VARCHAR2(10),
    disabled                       VARCHAR2(1) NOT NULL,
    oldcontrolacc                  VARCHAR2(20),
    oldshrinkageacc                VARCHAR2(20),
    oldinvcostadjacc               VARCHAR2(20),
    classstructureid               VARCHAR2(20),
    gisparam1                      VARCHAR2(1),
    gisparam2                      VARCHAR2(1),
    gisparam3                      VARCHAR2(1),
    lo6                            VARCHAR2(10),
    lo7                            VARCHAR2(10),
    lo8                            VARCHAR2(10),
    lo9                            NUMBER(10,2),
    lo10                           DATE,
    lo11                           NUMBER(15,2),
    lo12                           NUMBER(15,2),
    lo13                           VARCHAR2(10),
    lo14                           NUMBER,
    lo15                           VARCHAR2(1),
    sourcesysid                    VARCHAR2(10),
    ownersysid                     VARCHAR2(10),
    externalrefid                  VARCHAR2(10),
    apiseq                         VARCHAR2(50),
    interid                        VARCHAR2(50),
    migchangeid                    VARCHAR2(50),
    sendersysid                    VARCHAR2(50),
    siteid                         VARCHAR2(8) NOT NULL,
    orgid                          VARCHAR2(8) NOT NULL,
    intlabrec                      VARCHAR2(20),
    isdefault                      VARCHAR2(1) NOT NULL,
    shiptoaddresscode              VARCHAR2(50),
    shiptolaborcode                VARCHAR2(12),
    billtoaddresscode              VARCHAR2(50),
    billtolaborcode                VARCHAR2(12))
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Indexes for LOCATIONS

CREATE UNIQUE INDEX locations_ndx1 ON locations
  (
    siteid                          ASC,
    location                        ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/
CREATE INDEX locations_ndx2 ON locations
  (
    siteid                          ASC,
    type                            ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/
CREATE INDEX locations_ndx3 ON locations
  (
    siteid                          ASC,
    interid                         ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/


-- Triggers for LOCATIONS

CREATE TRIGGER locations_t
BEFORE INSERT  OR UPDATE 
ON locations
REFERENCING NEW AS NEW OLD AS OLD
FOR EACH ROW
DECLARE 
NEXTVAL INTEGER; BEGIN SELECT MAXSEQ.NEXTVAL INTO NEXTVAL FROM DUAL; 
:NEW.ROWSTAMP := NEXTVAL; END;
/

-- End of DDL Script for Table IFRMAXIMO.LOCATIONS

-- Start of DDL Script for Table IFRMAXIMO.LOCATIONSPEC
-- Generated 9-mar-2004 20:11:31 from SYSMAN@MAQUINA4

CREATE TABLE locationspec
    (rowstamp                       VARCHAR2(40) NOT NULL,
    location                       VARCHAR2(18) NOT NULL,
    assetattrid                    VARCHAR2(8) NOT NULL,
    classstructureid               VARCHAR2(20) NOT NULL,
    inheritedfromitem              VARCHAR2(1) NOT NULL,
    itemspecvalchanged             VARCHAR2(1) NOT NULL,
    displaysequence                NUMBER NOT NULL,
    numvalue                       NUMBER(10,2),
    measureunitid                  VARCHAR2(8),
    alnvalue                       VARCHAR2(16),
    changedate                     DATE NOT NULL,
    changeby                       VARCHAR2(18) NOT NULL,
    ls01                           VARCHAR2(10),
    ls02                           VARCHAR2(10),
    ls03                           VARCHAR2(10),
    ls04                           DATE,
    ls05                           NUMBER(15,2),
    siteid                         VARCHAR2(8) NOT NULL,
    orgid                          VARCHAR2(8) NOT NULL)
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Indexes for LOCATIONSPEC

CREATE UNIQUE INDEX locationspec_ndx1 ON locationspec
  (
    siteid                          ASC,
    location                        ASC,
    assetattrid                     ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/
CREATE INDEX locationspec_ndx2 ON locationspec
  (
    siteid                          ASC,
    classstructureid                ASC,
    assetattrid                     ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/
CREATE INDEX locationspec_ndx3 ON locationspec
  (
    siteid                          ASC,
    assetattrid                     ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/


-- Triggers for LOCATIONSPEC

CREATE TRIGGER locationspec_t
BEFORE INSERT  OR UPDATE 
ON locationspec
REFERENCING NEW AS NEW OLD AS OLD
FOR EACH ROW
DECLARE 
NEXTVAL INTEGER; BEGIN SELECT MAXSEQ.NEXTVAL INTO NEXTVAL FROM DUAL; 
:NEW.ROWSTAMP := NEXTVAL; END;
/

-- End of DDL Script for Table IFRMAXIMO.LOCATIONSPEC

-- Start of DDL Script for Table IFRMAXIMO.LOCAUTH
-- Generated 9-mar-2004 20:11:46 from SYSMAN@MAQUINA4

CREATE TABLE locauth
    (rowstamp                       VARCHAR2(40) NOT NULL,
    username                       VARCHAR2(18) NOT NULL,
    location                       VARCHAR2(18) NOT NULL,
    siteid                         VARCHAR2(8) NOT NULL,
    orgid                          VARCHAR2(8) NOT NULL)
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Indexes for LOCAUTH

CREATE UNIQUE INDEX locauth_ndx1 ON locauth
  (
    siteid                          ASC,
    username                        ASC,
    location                        ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/


-- Triggers for LOCAUTH

CREATE TRIGGER locauth_t
BEFORE INSERT  OR UPDATE 
ON locauth
REFERENCING NEW AS NEW OLD AS OLD
FOR EACH ROW
DECLARE 
NEXTVAL INTEGER; BEGIN SELECT MAXSEQ.NEXTVAL INTO NEXTVAL FROM DUAL; 
:NEW.ROWSTAMP := NEXTVAL; END;
/

-- End of DDL Script for Table IFRMAXIMO.LOCAUTH

-- Start of DDL Script for Table IFRMAXIMO.LOCHIERARCHY
-- Generated 9-mar-2004 20:11:53 from SYSMAN@MAQUINA4

CREATE TABLE lochierarchy
    (rowstamp                       VARCHAR2(40) NOT NULL,
    location                       VARCHAR2(18) NOT NULL,
    parent                         VARCHAR2(18),
    systemid                       VARCHAR2(8) NOT NULL,
    children                       VARCHAR2(1) NOT NULL,
    lh1                            VARCHAR2(10),
    lh2                            VARCHAR2(10),
    lh3                            VARCHAR2(10),
    lh4                            DATE,
    lh5                            NUMBER(15,2),
    gisparam1                      VARCHAR2(1),
    gisparam2                      VARCHAR2(1),
    gisparam3                      VARCHAR2(1),
    siteid                         VARCHAR2(8) NOT NULL,
    orgid                          VARCHAR2(8) NOT NULL)
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Indexes for LOCHIERARCHY

CREATE UNIQUE INDEX lochierarchy_ndx1 ON lochierarchy
  (
    siteid                          ASC,
    location                        ASC,
    systemid                        ASC,
    parent                          ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/
CREATE INDEX lochierarchy_ndx2 ON lochierarchy
  (
    siteid                          ASC,
    parent                          ASC,
    systemid                        ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/


-- Triggers for LOCHIERARCHY

CREATE TRIGGER lochierarchy_t
BEFORE INSERT  OR UPDATE 
ON lochierarchy
REFERENCING NEW AS NEW OLD AS OLD
FOR EACH ROW
DECLARE 
NEXTVAL INTEGER; BEGIN SELECT MAXSEQ.NEXTVAL INTO NEXTVAL FROM DUAL; 
:NEW.ROWSTAMP := NEXTVAL; END;
/

-- End of DDL Script for Table IFRMAXIMO.LOCHIERARCHY

-- Start of DDL Script for Table IFRMAXIMO.LOCKOUT
-- Generated 9-mar-2004 20:12:02 from SYSMAN@MAQUINA4

CREATE TABLE lockout
    (rowstamp                       VARCHAR2(40) NOT NULL,
    lockoutid                      VARCHAR2(20) NOT NULL,
    description                    VARCHAR2(50),
    ldkey                          NUMBER,
    location                       VARCHAR2(18),
    eqnum                          VARCHAR2(12),
    devicedescription              VARCHAR2(50),
    requiredstate                  VARCHAR2(16),
    lck01                          VARCHAR2(10),
    lck02                          VARCHAR2(10),
    lck03                          VARCHAR2(10),
    lck04                          VARCHAR2(10),
    lck05                          VARCHAR2(10),
    lck06                          NUMBER(10,2),
    lck07                          DATE,
    lck08                          NUMBER(15,2),
    lck09                          VARCHAR2(10),
    lck10                          NUMBER,
    orgid                          VARCHAR2(8) NOT NULL,
    siteid                         VARCHAR2(8) NOT NULL)
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Indexes for LOCKOUT

CREATE UNIQUE INDEX lockout_ndx1 ON lockout
  (
    siteid                          ASC,
    lockoutid                       ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/


-- Triggers for LOCKOUT

CREATE TRIGGER lockout_t
BEFORE INSERT  OR UPDATE 
ON lockout
REFERENCING NEW AS NEW OLD AS OLD
FOR EACH ROW
DECLARE 
NEXTVAL INTEGER; BEGIN SELECT MAXSEQ.NEXTVAL INTO NEXTVAL FROM DUAL; 
:NEW.ROWSTAMP := NEXTVAL; END;
/

-- End of DDL Script for Table IFRMAXIMO.LOCKOUT

-- Start of DDL Script for Table IFRMAXIMO.LOCLEADTIME
-- Generated 9-mar-2004 20:12:09 from SYSMAN@MAQUINA4

CREATE TABLE locleadtime
    (rowstamp                       VARCHAR2(40) NOT NULL,
    location                       VARCHAR2(18) NOT NULL,
    newpercent                     NUMBER NOT NULL,
    siteid                         VARCHAR2(8) NOT NULL,
    orgid                          VARCHAR2(8) NOT NULL)
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Indexes for LOCLEADTIME

CREATE UNIQUE INDEX locleadtime_ndx1 ON locleadtime
  (
    siteid                          ASC,
    location                        ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/


-- Triggers for LOCLEADTIME

CREATE TRIGGER locleadtime_t
BEFORE INSERT  OR UPDATE 
ON locleadtime
REFERENCING NEW AS NEW OLD AS OLD
FOR EACH ROW
DECLARE 
NEXTVAL INTEGER; BEGIN SELECT MAXSEQ.NEXTVAL INTO NEXTVAL FROM DUAL; 
:NEW.ROWSTAMP := NEXTVAL; END;
/

-- End of DDL Script for Table IFRMAXIMO.LOCLEADTIME

-- Start of DDL Script for Table IFRMAXIMO.LOCOPER
-- Generated 9-mar-2004 20:12:14 from SYSMAN@MAQUINA4

CREATE TABLE locoper
    (rowstamp                       VARCHAR2(40) NOT NULL,
    location                       VARCHAR2(18) NOT NULL,
    status                         VARCHAR2(14),
    calnum                         VARCHAR2(8),
    locpriority                    NUMBER,
    itemnum                        VARCHAR2(30),
    failurecode                    VARCHAR2(8),
    classification                 VARCHAR2(10),
    flo1                           VARCHAR2(10),
    flo2                           VARCHAR2(10),
    flo3                           VARCHAR2(10),
    flo4                           VARCHAR2(10),
    flo5                           VARCHAR2(10),
    flo6                           NUMBER(10,2),
    flo7                           DATE,
    flo8                           NUMBER(15,2),
    flo9                           VARCHAR2(10),
    flo10                          NUMBER,
    warrantyexpdate                DATE,
    siteid                         VARCHAR2(8) NOT NULL,
    orgid                          VARCHAR2(8) NOT NULL)
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Indexes for LOCOPER

CREATE UNIQUE INDEX locoper_ndx1 ON locoper
  (
    siteid                          ASC,
    location                        ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/


-- Triggers for LOCOPER

CREATE TRIGGER locoper_t
BEFORE INSERT  OR UPDATE 
ON locoper
REFERENCING NEW AS NEW OLD AS OLD
FOR EACH ROW
DECLARE 
NEXTVAL INTEGER; BEGIN SELECT MAXSEQ.NEXTVAL INTO NEXTVAL FROM DUAL; 
:NEW.ROWSTAMP := NEXTVAL; END;
/

-- End of DDL Script for Table IFRMAXIMO.LOCOPER

-- Start of DDL Script for Table IFRMAXIMO.LOCSTATUS
-- Generated 9-mar-2004 20:12:21 from SYSMAN@MAQUINA4

CREATE TABLE locstatus
    (rowstamp                       VARCHAR2(40) NOT NULL,
    location                       VARCHAR2(18) NOT NULL,
    status                         VARCHAR2(14) NOT NULL,
    changeby                       VARCHAR2(18) NOT NULL,
    changedate                     DATE NOT NULL,
    memo                           VARCHAR2(25),
    siteid                         VARCHAR2(8) NOT NULL,
    orgid                          VARCHAR2(8) NOT NULL)
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Indexes for LOCSTATUS

CREATE INDEX locstatus_ndx1 ON locstatus
  (
    siteid                          ASC,
    location                        ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/
CREATE INDEX locstatus_ndx2 ON locstatus
  (
    siteid                          ASC,
    changedate                      ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/


-- Triggers for LOCSTATUS

CREATE TRIGGER locstatus_t
BEFORE INSERT  OR UPDATE 
ON locstatus
REFERENCING NEW AS NEW OLD AS OLD
FOR EACH ROW
DECLARE 
NEXTVAL INTEGER; BEGIN SELECT MAXSEQ.NEXTVAL INTO NEXTVAL FROM DUAL; 
:NEW.ROWSTAMP := NEXTVAL; END;
/

-- End of DDL Script for Table IFRMAXIMO.LOCSTATUS

-- Start of DDL Script for Table IFRMAXIMO.LOCSYSTEM
-- Generated 9-mar-2004 20:12:30 from SYSMAN@MAQUINA4

CREATE TABLE locsystem
    (rowstamp                       VARCHAR2(40) NOT NULL,
    systemid                       VARCHAR2(8) NOT NULL,
    description                    VARCHAR2(150),
    ldkey                          NUMBER,
    sm1                            VARCHAR2(10),
    sm2                            VARCHAR2(10),
    sm3                            VARCHAR2(10),
    sm4                            DATE,
    sm5                            NUMBER(15,2),
    network                        VARCHAR2(1) NOT NULL,
    doctype                        VARCHAR2(8),
    gisparam1                      VARCHAR2(1),
    gisparam2                      VARCHAR2(1),
    gisparam3                      VARCHAR2(1),
    sourcesysid                    VARCHAR2(10),
    ownersysid                     VARCHAR2(10),
    externalrefid                  VARCHAR2(10),
    siteid                         VARCHAR2(8) NOT NULL,
    orgid                          VARCHAR2(8) NOT NULL)
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Indexes for LOCSYSTEM

CREATE UNIQUE INDEX locsystem_ndx1 ON locsystem
  (
    siteid                          ASC,
    systemid                        ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/


-- Triggers for LOCSYSTEM

CREATE TRIGGER locsystem_t
BEFORE INSERT  OR UPDATE 
ON locsystem
REFERENCING NEW AS NEW OLD AS OLD
FOR EACH ROW
DECLARE 
NEXTVAL INTEGER; BEGIN SELECT MAXSEQ.NEXTVAL INTO NEXTVAL FROM DUAL; 
:NEW.ROWSTAMP := NEXTVAL; END;
/

-- End of DDL Script for Table IFRMAXIMO.LOCSYSTEM

-- Start of DDL Script for Table IFRMAXIMO.LOGINTRACKING
-- Generated 9-mar-2004 20:12:37 from SYSMAN@MAQUINA4

CREATE TABLE logintracking
    (rowstamp                       VARCHAR2(40) NOT NULL,
    username                       VARCHAR2(18) NOT NULL,
    attemptdate                    DATE NOT NULL,
    attemptresult                  VARCHAR2(1) NOT NULL,
    name                           VARCHAR2(120),
    app                            VARCHAR2(10),
    reason                         VARCHAR2(50),
    transid                        VARCHAR2(40),
    keyvalue1                      VARCHAR2(50),
    keyvalue2                      VARCHAR2(50),
    keyvalue3                      VARCHAR2(50),
    keyvalue4                      VARCHAR2(50),
    keyvalue5                      VARCHAR2(50),
    keyvalue6                      VARCHAR2(50),
    keyvalue7                      VARCHAR2(50))
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Indexes for LOGINTRACKING

CREATE INDEX logintracking_ndx1 ON logintracking
  (
    username                        ASC,
    attemptdate                     ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/
CREATE INDEX logintracking_ndx2 ON logintracking
  (
    attemptdate                     ASC,
    username                        ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/


-- Triggers for LOGINTRACKING

CREATE TRIGGER logintracking_t
BEFORE INSERT  OR UPDATE 
ON logintracking
REFERENCING NEW AS NEW OLD AS OLD
FOR EACH ROW
DECLARE 
NEXTVAL INTEGER; BEGIN SELECT MAXSEQ.NEXTVAL INTO NEXTVAL FROM DUAL; 
:NEW.ROWSTAMP := NEXTVAL; END;
/

-- End of DDL Script for Table IFRMAXIMO.LOGINTRACKING

-- Start of DDL Script for Table IFRMAXIMO.LONGDESCRIPTION
-- Generated 9-mar-2004 20:12:47 from SYSMAN@MAQUINA4

CREATE TABLE longdescription
    (ldkey                          NUMBER NOT NULL,
    ldownertable                   VARCHAR2(18) NOT NULL,
    ldownercol                     VARCHAR2(18) NOT NULL,
    ldtext                         LONG,
    rowstamp                       VARCHAR2(40) NOT NULL)
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Indexes for LONGDESCRIPTION

CREATE UNIQUE INDEX longdscrptn_ndx1 ON longdescription
  (
    ldownertable                    ASC,
    ldownercol                      ASC,
    ldkey                           ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/
CREATE INDEX longdscrptn_ndx2 ON longdescription
  (
    ldkey                           ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/


-- Triggers for LONGDESCRIPTION

CREATE TRIGGER longdescription_t
BEFORE INSERT  OR UPDATE 
ON longdescription
REFERENCING NEW AS NEW OLD AS OLD
FOR EACH ROW
DECLARE NEXTVAL INTEGER; BEGIN SELECT MAXSEQ.NEXTVAL INTO NEXTVAL FROM DUAL; :NEW.ROWSTAMP := NEXTVAL; END;
/

-- End of DDL Script for Table IFRMAXIMO.LONGDESCRIPTION

-- Start of DDL Script for Table IFRMAXIMO.MATRECTRANS
-- Generated 9-mar-2004 20:12:56 from SYSMAN@MAQUINA4

CREATE TABLE matrectrans
    (rowstamp                       VARCHAR2(40) NOT NULL,
    itemnum                        VARCHAR2(30),
    tostoreloc                     VARCHAR2(18),
    transdate                      DATE NOT NULL,
    actualdate                     DATE NOT NULL,
    quantity                       NUMBER(15,2),
    receivedunit                   VARCHAR2(8),
    issuetype                      VARCHAR2(10),
    unitcost                       NUMBER(10,2) NOT NULL,
    actualcost                     NUMBER(10,2) NOT NULL,
    ponum                          VARCHAR2(8),
    invoicenum                     VARCHAR2(8),
    rejectcode                     VARCHAR2(6),
    rejectqty                      NUMBER(15,2) NOT NULL,
    conversion                     NUMBER(15,2) NOT NULL,
    eqnum                          VARCHAR2(12),
    enterby                        VARCHAR2(18) NOT NULL,
    it1                            VARCHAR2(10),
    it2                            VARCHAR2(10),
    it3                            VARCHAR2(10),
    it4                            NUMBER(15,2),
    it5                            VARCHAR2(10),
    ldkey                          NUMBER,
    outside                        VARCHAR2(1) NOT NULL,
    issueto                        VARCHAR2(12),
    packingslipnum                 VARCHAR2(20),
    polinenum                      NUMBER,
    issue                          VARCHAR2(1) NOT NULL,
    requestedby                    VARCHAR2(20),
    totalcurbal                    NUMBER(15,2),
    oldavgcost                     NUMBER(10,2),
    itin1                          NUMBER(10,2),
    itin2                          VARCHAR2(10),
    itin3                          VARCHAR2(10),
    tobin                          VARCHAR2(8),
    gldebitacct                    VARCHAR2(20),
    glcreditacct                   VARCHAR2(20),
    linecost                       NUMBER(10,2) NOT NULL,
    financialperiod                VARCHAR2(6),
    currencycode                   VARCHAR2(8) NOT NULL,
    exchangerate                   NUMBER(14,7),
    currencyunitcost               NUMBER(10,2),
    manufacturer                   VARCHAR2(18),
    modelnum                       VARCHAR2(8),
    currencylinecost               NUMBER(10,2),
    location                       VARCHAR2(18),
    description                    VARCHAR2(120),
    remark                         VARCHAR2(50),
    fromstoreloc                   VARCHAR2(18),
    frombin                        VARCHAR2(8),
    qtyheld                        NUMBER(15,2),
    fromlot                        VARCHAR2(8),
    tolot                          VARCHAR2(8),
    loadedcost                     NUMBER(10,2) NOT NULL,
    tax1code                       VARCHAR2(8),
    tax1                           NUMBER(10,2),
    tax2code                       VARCHAR2(8),
    tax2                           NUMBER(10,2),
    tax3code                       VARCHAR2(8),
    tax3                           NUMBER(10,2),
    tax4code                       VARCHAR2(8),
    tax4                           NUMBER(10,2),
    tax5code                       VARCHAR2(8),
    tax5                           NUMBER(10,2),
    prorated                       VARCHAR2(1) NOT NULL,
    proratecost                    NUMBER(10,2),
    status                         VARCHAR2(8),
    statusdate                     DATE,
    statuschangeby                 VARCHAR2(18),
    sourcesysid                    VARCHAR2(10),
    qtyrequested                   NUMBER(22,2),
    curbal                         NUMBER(15,2) NOT NULL,
    exchangerate2                  NUMBER(14,7),
    linecost2                      NUMBER(10,2),
    mrnum                          VARCHAR2(8),
    mrlinenum                      NUMBER,
    matrectransid                  NUMBER NOT NULL,
    ownersysid                     VARCHAR2(10),
    externalrefid                  VARCHAR2(10),
    it6                            VARCHAR2(1),
    it7                            VARCHAR2(1),
    it8                            VARCHAR2(1),
    it9                            VARCHAR2(1),
    it10                           VARCHAR2(1),
    itin4                          VARCHAR2(1),
    itin5                          VARCHAR2(1),
    itin6                          VARCHAR2(1),
    itin7                          VARCHAR2(1),
    apiseq                         VARCHAR2(50),
    interid                        VARCHAR2(50),
    migchangeid                    VARCHAR2(50),
    sendersysid                    VARCHAR2(50),
    expdone                        VARCHAR2(25),
    fincntrlid                     VARCHAR2(8),
    orgid                          VARCHAR2(8) NOT NULL,
    siteid                         VARCHAR2(8) NOT NULL,
    costinfo                       VARCHAR2(1) NOT NULL,
    belongsto                      NUMBER,
    refwo                          VARCHAR2(18),
    enteredastask                  VARCHAR2(1) NOT NULL,
    fromsiteid                     VARCHAR2(8) NOT NULL)
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Indexes for MATRECTRANS

CREATE UNIQUE INDEX matrectrans_ndx1 ON matrectrans
  (
    siteid                          ASC,
    matrectransid                   ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/
CREATE INDEX matrectrans_ndx2 ON matrectrans
  (
    siteid                          ASC,
    itemnum                         ASC,
    tostoreloc                      ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/
CREATE INDEX matrectrans_ndx3 ON matrectrans
  (
    siteid                          ASC,
    ponum                           ASC,
    polinenum                       ASC,
    transdate                       ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/
CREATE INDEX matrectrans_ndx4 ON matrectrans
  (
    siteid                          ASC,
    interid                         ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/


-- Triggers for MATRECTRANS

CREATE TRIGGER matrectrans_t
BEFORE INSERT  OR UPDATE 
ON matrectrans
REFERENCING NEW AS NEW OLD AS OLD
FOR EACH ROW
DECLARE NEXTVAL INTEGER; BEGIN SELECT MAXSEQ.NEXTVAL INTO NEXTVAL FROM DUAL; :NEW.ROWSTAMP := NEXTVAL; END;
/

-- End of DDL Script for Table IFRMAXIMO.MATRECTRANS

-- Start of DDL Script for Table IFRMAXIMO.MATUSETRANS
-- Generated 9-mar-2004 20:13:14 from SYSMAN@MAQUINA4

CREATE TABLE matusetrans
    (rowstamp                       VARCHAR2(40) NOT NULL,
    itemnum                        VARCHAR2(30),
    storeloc                       VARCHAR2(18),
    transdate                      DATE NOT NULL,
    actualdate                     DATE NOT NULL,
    quantity                       NUMBER(15,2) NOT NULL,
    curbal                         NUMBER(15,2) NOT NULL,
    physcnt                        NUMBER(15,2) NOT NULL,
    unitcost                       NUMBER(10,2) NOT NULL,
    actualcost                     NUMBER(10,2) NOT NULL,
    ponum                          VARCHAR2(8),
    conversion                     NUMBER(15,2) NOT NULL,
    eqnum                          VARCHAR2(12),
    enterby                        VARCHAR2(18) NOT NULL,
    it1                            VARCHAR2(10),
    it2                            VARCHAR2(10),
    it3                            VARCHAR2(10),
    it4                            NUMBER(15,2),
    it5                            VARCHAR2(10),
    ldkey                          NUMBER,
    meterreading                   NUMBER(15,2),
    meterreading2                  NUMBER(15,2),
    memo                           VARCHAR2(254),
    outside                        VARCHAR2(1) NOT NULL,
    issueto                        VARCHAR2(12),
    packingslipnum                 VARCHAR2(20),
    polinenum                      NUMBER,
    rollup                         VARCHAR2(1) NOT NULL,
    itin1                          NUMBER(10,2),
    itin2                          VARCHAR2(10),
    itin3                          VARCHAR2(10),
    binnum                         VARCHAR2(8),
    lotnum                         VARCHAR2(8),
    issuetype                      VARCHAR2(10) NOT NULL,
    gldebitacct                    VARCHAR2(20),
    glcreditacct                   VARCHAR2(20),
    linecost                       NUMBER(10,2) NOT NULL,
    financialperiod                VARCHAR2(6),
    currencycode                   VARCHAR2(8) NOT NULL,
    currencyunitcost               NUMBER(10,2),
    roteqnum                       VARCHAR2(12),
    currencylinecost               NUMBER(10,2),
    location                       VARCHAR2(18),
    description                    VARCHAR2(120),
    exchangerate                   NUMBER(14,7),
    sparepartadded                 VARCHAR2(1) NOT NULL,
    qtyrequested                   NUMBER(15,2),
    exchangerate2                  NUMBER(14,7),
    linecost2                      NUMBER(10,2),
    mrnum                          VARCHAR2(8),
    mrlinenum                      NUMBER,
    matusetransid                  NUMBER NOT NULL,
    matrectransid                  NUMBER,
    it6                            VARCHAR2(1),
    it7                            VARCHAR2(1),
    it8                            VARCHAR2(1),
    it9                            VARCHAR2(1),
    it10                           VARCHAR2(1),
    it11                           VARCHAR2(1),
    it12                           VARCHAR2(1),
    itin4                          VARCHAR2(1),
    itin5                          VARCHAR2(1),
    itin6                          VARCHAR2(1),
    itin7                          VARCHAR2(1),
    sourcesysid                    VARCHAR2(10),
    ownersysid                     VARCHAR2(10),
    externalrefid                  VARCHAR2(10),
    apiseq                         VARCHAR2(50),
    interid                        VARCHAR2(50),
    migchangeid                    VARCHAR2(50),
    sendersysid                    VARCHAR2(50),
    fincntrlid                     VARCHAR2(8),
    issueid                        NUMBER,
    qtyreturned                    NUMBER(15,2),
    orgid                          VARCHAR2(8) NOT NULL,
    siteid                         VARCHAR2(8) NOT NULL,
    refwo                          VARCHAR2(18),
    enteredastask                  VARCHAR2(1) NOT NULL)
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Indexes for MATUSETRANS

CREATE INDEX matusetrans_ndx2 ON matusetrans
  (
    siteid                          ASC,
    refwo                           ASC,
    transdate                       ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/
CREATE INDEX matusetrans_ndx3 ON matusetrans
  (
    siteid                          ASC,
    itemnum                         ASC,
    storeloc                        ASC,
    transdate                       ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/
CREATE INDEX matusetrans_ndx4 ON matusetrans
  (
    siteid                          ASC,
    eqnum                           ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/
CREATE INDEX matusetrans_ndx5 ON matusetrans
  (
    siteid                          ASC,
    interid                         ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/
CREATE UNIQUE INDEX matusetrans_ndx1 ON matusetrans
  (
    matusetransid                   ASC,
    siteid                          ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
PARALLEL (DEGREE DEFAULT)
/
CREATE INDEX idx_temp ON matusetrans
  (
    refwo                           ASC,
    itemnum                         ASC,
    storeloc                        ASC,
    transdate                       ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/


-- Triggers for MATUSETRANS

CREATE TRIGGER matusetrans_t
BEFORE INSERT  OR UPDATE 
ON matusetrans
REFERENCING NEW AS NEW OLD AS OLD
FOR EACH ROW
DECLARE NEXTVAL INTEGER; BEGIN SELECT MAXSEQ.NEXTVAL INTO NEXTVAL FROM DUAL; :NEW.ROWSTAMP := NEXTVAL; END;
/
CREATE TRIGGER tr_material_insert
BEFORE INSERT 
ON matusetrans
REFERENCING NEW AS NEW OLD AS OLD
FOR EACH ROW
DECLARE
BEGIN
   :NEW.unitcost := NVL (:NEW.itin1, 0);
   :NEW.linecost := ((:NEW.unitcost) * SUBSTR ((:NEW.quantity), 2, 10));

   UPDATE workorder SET wo5 = NVL(wo5,0) + :NEW.linecost WHERE wonum = :NEW.refwo AND siteid = 'INFRAERO';
END;
/

-- End of DDL Script for Table IFRMAXIMO.MATUSETRANS

-- Start of DDL Script for Table IFRMAXIMO.MAXANALYZEINDEXES
-- Generated 9-mar-2004 20:13:41 from SYSMAN@MAQUINA4

CREATE TABLE maxanalyzeindexes
    (name                           VARCHAR2(18) NOT NULL,
    tbname                         VARCHAR2(18) NOT NULL,
    key1                           VARCHAR2(18) NOT NULL,
    order1                         VARCHAR2(1),
    key2                           VARCHAR2(18),
    order2                         VARCHAR2(1),
    key3                           VARCHAR2(18),
    order3                         VARCHAR2(1),
    key4                           VARCHAR2(18),
    order4                         VARCHAR2(1),
    key5                           VARCHAR2(18),
    order5                         VARCHAR2(1),
    key6                           VARCHAR2(18),
    order6                         VARCHAR2(1),
    key7                           VARCHAR2(18),
    order7                         VARCHAR2(1),
    changed                        VARCHAR2(1),
    uniquerule                     VARCHAR2(1),
    clusterrule                    VARCHAR2(1),
    storagepartition               VARCHAR2(30))
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Indexes for MAXANALYZEINDEXES

CREATE UNIQUE INDEX analyzeindex_ndx ON maxanalyzeindexes
  (
    tbname                          ASC,
    uniquerule                      ASC,
    clusterrule                     ASC,
    changed                         ASC,
    key1                            ASC,
    key2                            ASC,
    key3                            ASC,
    key4                            ASC,
    key5                            ASC,
    key6                            ASC,
    key7                            ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/


-- End of DDL Script for Table IFRMAXIMO.MAXANALYZEINDEXES

-- Start of DDL Script for Table IFRMAXIMO.MAXAPPS
-- Generated 9-mar-2004 20:13:47 from SYSMAN@MAQUINA4

CREATE TABLE maxapps
    (rowstamp                       VARCHAR2(40) NOT NULL,
    module                         VARCHAR2(10) NOT NULL,
    app                            VARCHAR2(10) NOT NULL,
    description                    VARCHAR2(30) NOT NULL,
    apptype                        VARCHAR2(5) NOT NULL,
    menupos                        NUMBER NOT NULL,
    restrictions                   VARCHAR2(254),
    orderby                        VARCHAR2(254),
    originalapp                    VARCHAR2(10),
    docenabled                     VARCHAR2(1) NOT NULL,
    custapptype                    VARCHAR2(10),
    maintbname                     VARCHAR2(18),
    keycolumn                      VARCHAR2(18),
    isjava                         VARCHAR2(1) NOT NULL)
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Indexes for MAXAPPS

CREATE INDEX maxapps_ndx1 ON maxapps
  (
    app                             ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/
CREATE UNIQUE INDEX maxapps_ndx ON maxapps
  (
    module                          ASC,
    app                             ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/


-- Triggers for MAXAPPS

CREATE TRIGGER maxapps_t
BEFORE INSERT  OR UPDATE 
ON maxapps
REFERENCING NEW AS NEW OLD AS OLD
FOR EACH ROW
DECLARE 
NEXTVAL INTEGER; BEGIN SELECT MAXSEQ.NEXTVAL INTO NEXTVAL FROM DUAL; 
:NEW.ROWSTAMP := NEXTVAL; END;
/

-- End of DDL Script for Table IFRMAXIMO.MAXAPPS

-- Start of DDL Script for Table IFRMAXIMO.MAXAPPS_BK
-- Generated 9-mar-2004 20:13:59 from SYSMAN@MAQUINA4

CREATE TABLE maxapps_bk
    (rowstamp                       VARCHAR2(40) NOT NULL,
    module                         VARCHAR2(10) NOT NULL,
    app                            VARCHAR2(10) NOT NULL,
    description                    VARCHAR2(30) NOT NULL,
    apptype                        VARCHAR2(5) NOT NULL,
    menupos                        NUMBER NOT NULL,
    restrictions                   VARCHAR2(254),
    orderby                        VARCHAR2(254),
    originalapp                    VARCHAR2(10),
    docenabled                     VARCHAR2(1),
    custapptype                    VARCHAR2(10),
    maintbname                     VARCHAR2(18))
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- End of DDL Script for Table IFRMAXIMO.MAXAPPS_BK

-- Start of DDL Script for Table IFRMAXIMO.MAXDOMAIN
-- Generated 9-mar-2004 20:14:01 from SYSMAN@MAQUINA4

CREATE TABLE maxdomain
    (rowstamp                       VARCHAR2(40) NOT NULL,
    domainid                       VARCHAR2(18) NOT NULL,
    description                    VARCHAR2(30),
    domaintype                     VARCHAR2(10) NOT NULL)
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Indexes for MAXDOMAIN

CREATE INDEX maxdomain_ndx2 ON maxdomain
  (
    domaintype                      ASC,
    domainid                        ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/
CREATE UNIQUE INDEX maxdomain_ndx1 ON maxdomain
  (
    domainid                        ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/


-- Triggers for MAXDOMAIN

CREATE TRIGGER maxdomain_t
BEFORE INSERT  OR UPDATE 
ON maxdomain
REFERENCING NEW AS NEW OLD AS OLD
FOR EACH ROW
DECLARE 
NEXTVAL INTEGER; BEGIN SELECT MAXSEQ.NEXTVAL INTO NEXTVAL FROM DUAL; 
:NEW.ROWSTAMP := NEXTVAL; END;
/

-- End of DDL Script for Table IFRMAXIMO.MAXDOMAIN

-- Start of DDL Script for Table IFRMAXIMO.MAXENCRYPT
-- Generated 9-mar-2004 20:14:12 from SYSMAN@MAQUINA4

CREATE TABLE maxencrypt
    (rowstamp                       VARCHAR2(40) NOT NULL,
    encrypt                        VARCHAR2(37))
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Triggers for MAXENCRYPT

CREATE TRIGGER maxencrypt_t
BEFORE INSERT  OR UPDATE 
ON maxencrypt
REFERENCING NEW AS NEW OLD AS OLD
FOR EACH ROW
DECLARE 
NEXTVAL INTEGER; BEGIN SELECT MAXSEQ.NEXTVAL INTO NEXTVAL FROM DUAL; 
:NEW.ROWSTAMP := NEXTVAL; END;
/

-- End of DDL Script for Table IFRMAXIMO.MAXENCRYPT

-- Start of DDL Script for Table IFRMAXIMO.MAXENCRYPT_BK2
-- Generated 9-mar-2004 20:14:15 from SYSMAN@MAQUINA4

CREATE TABLE maxencrypt_bk2
    (rowstamp                       VARCHAR2(40) NOT NULL,
    encrypt                        VARCHAR2(37))
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- End of DDL Script for Table IFRMAXIMO.MAXENCRYPT_BK2

-- Start of DDL Script for Table IFRMAXIMO.MAXENCRYPT_BKP
-- Generated 9-mar-2004 20:14:16 from SYSMAN@MAQUINA4

CREATE TABLE maxencrypt_bkp
    (rowstamp                       VARCHAR2(40) NOT NULL,
    encrypt                        VARCHAR2(37))
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- End of DDL Script for Table IFRMAXIMO.MAXENCRYPT_BKP

-- Start of DDL Script for Table IFRMAXIMO.MAXGROUPS
-- Generated 9-mar-2004 20:14:18 from SYSMAN@MAQUINA4

CREATE TABLE maxgroups
    (rowstamp                       VARCHAR2(40) NOT NULL,
    grpname                        VARCHAR2(18) NOT NULL,
    cangroupchangepw               VARCHAR2(1) NOT NULL,
    usecommodityauth               VARCHAR2(1) NOT NULL,
    commauthinclude                VARCHAR2(1) NOT NULL,
    actuateinsync                  VARCHAR2(1) NOT NULL,
    description                    VARCHAR2(150))
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Indexes for MAXGROUPS

CREATE UNIQUE INDEX maxgroups_ndx ON maxgroups
  (
    grpname                         ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/


-- Triggers for MAXGROUPS

CREATE TRIGGER maxgroups_t
BEFORE INSERT  OR UPDATE 
ON maxgroups
REFERENCING NEW AS NEW OLD AS OLD
FOR EACH ROW
DECLARE 
NEXTVAL INTEGER; BEGIN SELECT MAXSEQ.NEXTVAL INTO NEXTVAL FROM DUAL; 
:NEW.ROWSTAMP := NEXTVAL; END;
/

-- End of DDL Script for Table IFRMAXIMO.MAXGROUPS

-- Start of DDL Script for Table IFRMAXIMO.MAXHLP
-- Generated 9-mar-2004 20:14:24 from SYSMAN@MAQUINA4

CREATE TABLE maxhlp
    (rowstamp                       VARCHAR2(40) NOT NULL,
    app                            VARCHAR2(10) NOT NULL,
    window                         VARCHAR2(32),
    twname                         VARCHAR2(32),
    control                        VARCHAR2(32),
    helpfile                       VARCHAR2(12),
    topicnum                       NUMBER NOT NULL)
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Indexes for MAXHLP

CREATE UNIQUE INDEX maxhlp_ndx ON maxhlp
  (
    app                             ASC,
    window                          ASC,
    twname                          ASC,
    control                         ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/


-- Triggers for MAXHLP

CREATE TRIGGER maxhlp_t
BEFORE INSERT  OR UPDATE 
ON maxhlp
REFERENCING NEW AS NEW OLD AS OLD
FOR EACH ROW
DECLARE 
NEXTVAL INTEGER; BEGIN SELECT MAXSEQ.NEXTVAL INTO NEXTVAL FROM DUAL; 
:NEW.ROWSTAMP := NEXTVAL; END;
/

-- End of DDL Script for Table IFRMAXIMO.MAXHLP

-- Start of DDL Script for Table IFRMAXIMO.MAXMODULES
-- Generated 9-mar-2004 20:14:31 from SYSMAN@MAQUINA4

CREATE TABLE maxmodules
    (module                         VARCHAR2(10) NOT NULL,
    description                    VARCHAR2(30) NOT NULL,
    rowpos                         NUMBER NOT NULL,
    colpos                         NUMBER NOT NULL,
    rowstamp                       VARCHAR2(40) NOT NULL)
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Indexes for MAXMODULES

CREATE UNIQUE INDEX maxmodules_ndx ON maxmodules
  (
    module                          ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/


-- Triggers for MAXMODULES

CREATE TRIGGER maxmodules_t
BEFORE INSERT  OR UPDATE 
ON maxmodules
REFERENCING NEW AS NEW OLD AS OLD
FOR EACH ROW
DECLARE NEXTVAL INTEGER; BEGIN SELECT MAXSEQ.NEXTVAL INTO NEXTVAL FROM DUAL; :NEW.ROWSTAMP := NEXTVAL; END;
/

-- End of DDL Script for Table IFRMAXIMO.MAXMODULES

-- Start of DDL Script for Table IFRMAXIMO.MAXRELATIONSHIP
-- Generated 9-mar-2004 20:14:38 from SYSMAN@MAQUINA4

CREATE TABLE maxrelationship
    (name                           VARCHAR2(18) NOT NULL,
    parent                         VARCHAR2(18) NOT NULL,
    child                          VARCHAR2(18) NOT NULL,
    whereclause                    VARCHAR2(254) NOT NULL,
    rowstamp                       VARCHAR2(40) NOT NULL)
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Indexes for MAXRELATIONSHIP

CREATE UNIQUE INDEX maxrelations_ndx1 ON maxrelationship
  (
    parent                          ASC,
    name                            ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/


-- Triggers for MAXRELATIONSHIP

CREATE TRIGGER maxrelationship_t
BEFORE INSERT  OR UPDATE 
ON maxrelationship
REFERENCING NEW AS NEW OLD AS OLD
FOR EACH ROW
DECLARE NEXTVAL INTEGER; BEGIN SELECT MAXSEQ.NEXTVAL INTO NEXTVAL FROM DUAL; :NEW.ROWSTAMP := NEXTVAL; END;
/

-- End of DDL Script for Table IFRMAXIMO.MAXRELATIONSHIP

-- Start of DDL Script for Table IFRMAXIMO.MAXSCREENS
-- Generated 9-mar-2004 20:14:44 from SYSMAN@MAQUINA4

CREATE TABLE maxscreens
    (app                            VARCHAR2(10) NOT NULL,
    screen                         VARCHAR2(10) NOT NULL,
    description                    VARCHAR2(30),
    id                             NUMBER NOT NULL,
    rowstamp                       VARCHAR2(40) NOT NULL)
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Indexes for MAXSCREENS

CREATE UNIQUE INDEX maxscreens_ndx2 ON maxscreens
  (
    app                             ASC,
    id                              ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/
CREATE UNIQUE INDEX maxscrn_ndx1 ON maxscreens
  (
    app                             ASC,
    screen                          ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/


-- Triggers for MAXSCREENS

CREATE TRIGGER maxscreens_t
BEFORE INSERT  OR UPDATE 
ON maxscreens
REFERENCING NEW AS NEW OLD AS OLD
FOR EACH ROW
DECLARE NEXTVAL INTEGER; BEGIN SELECT MAXSEQ.NEXTVAL INTO NEXTVAL FROM DUAL; :NEW.ROWSTAMP := NEXTVAL; END;
/

-- End of DDL Script for Table IFRMAXIMO.MAXSCREENS

-- Start of DDL Script for Table IFRMAXIMO.MAXSCREENS_BK
-- Generated 9-mar-2004 20:14:56 from SYSMAN@MAQUINA4

CREATE TABLE maxscreens_bk
    (app                            VARCHAR2(10) NOT NULL,
    screen                         VARCHAR2(10) NOT NULL,
    description                    VARCHAR2(30),
    id                             NUMBER NOT NULL,
    rowstamp                       VARCHAR2(40) NOT NULL)
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- End of DDL Script for Table IFRMAXIMO.MAXSCREENS_BK

-- Start of DDL Script for Table IFRMAXIMO.MAXSERVICE
-- Generated 9-mar-2004 20:14:57 from SYSMAN@MAQUINA4

CREATE TABLE maxservice
    (rowstamp                       VARCHAR2(40) NOT NULL,
    servicename                    VARCHAR2(18) NOT NULL,
    description                    VARCHAR2(50),
    classname                      VARCHAR2(80) NOT NULL)
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Indexes for MAXSERVICE

CREATE UNIQUE INDEX maxservice_ndx1 ON maxservice
  (
    servicename                     ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/


-- Triggers for MAXSERVICE

CREATE TRIGGER maxservice_t
BEFORE INSERT  OR UPDATE 
ON maxservice
REFERENCING NEW AS NEW OLD AS OLD
FOR EACH ROW
DECLARE 
NEXTVAL INTEGER; BEGIN SELECT MAXSEQ.NEXTVAL INTO NEXTVAL FROM DUAL; 
:NEW.ROWSTAMP := NEXTVAL; END;
/

-- End of DDL Script for Table IFRMAXIMO.MAXSERVICE

-- Start of DDL Script for Table IFRMAXIMO.MAXSYSCOLSCFG
-- Generated 9-mar-2004 20:15:04 from SYSMAN@MAQUINA4

CREATE TABLE maxsyscolscfg
    (rowstamp                       VARCHAR2(40) NOT NULL,
    tbname                         VARCHAR2(18) NOT NULL,
    name                           VARCHAR2(18) NOT NULL,
    colalias                       VARCHAR2(18) NOT NULL,
    colno                          NUMBER NOT NULL,
    maxtype                        VARCHAR2(8) NOT NULL,
    length                         NUMBER NOT NULL,
    scale                          NUMBER NOT NULL,
    nulls                          VARCHAR2(1) NOT NULL,
    maxvlname                      VARCHAR2(18),
    maxvltype                      NUMBER,
    isldkey                        VARCHAR2(1) NOT NULL,
    isldowner                      VARCHAR2(1) NOT NULL,
    sameastable                    VARCHAR2(18),
    sameascolumn                   VARCHAR2(18),
    mustbe                         VARCHAR2(1) NOT NULL,
    changed                        VARCHAR2(1) NOT NULL,
    ispositive                     VARCHAR2(1) NOT NULL,
    remarks                        VARCHAR2(254),
    nullwithdefault                VARCHAR2(1) NOT NULL,
    defaultvalue                   VARCHAR2(50),
    columntitle                    VARCHAR2(80) NOT NULL,
    dlfilterlistorder              NUMBER NOT NULL,
    primarykeycolseq               NUMBER,
    userdefined                    VARCHAR2(1) NOT NULL,
    domainid                       VARCHAR2(18),
    objectdefaultvalue             VARCHAR2(50),
    translatable                   VARCHAR2(1) NOT NULL,
    persistent                     VARCHAR2(1) NOT NULL,
    canautonum                     VARCHAR2(1) NOT NULL,
    customclassname                VARCHAR2(80),
    esigenabled                    VARCHAR2(1) NOT NULL,
    eauditenabled                  VARCHAR2(1) NOT NULL)
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Indexes for MAXSYSCOLSCFG

CREATE UNIQUE INDEX maxsyscfg_ndx1 ON maxsyscolscfg
  (
    tbname                          ASC,
    name                            ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/
CREATE UNIQUE INDEX maxsyscfg_ndx2 ON maxsyscolscfg
  (
    tbname                          ASC,
    colalias                        ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/


-- Triggers for MAXSYSCOLSCFG

CREATE TRIGGER maxsyscolscfg_t
BEFORE INSERT  OR UPDATE 
ON maxsyscolscfg
REFERENCING NEW AS NEW OLD AS OLD
FOR EACH ROW
DECLARE 
NEXTVAL INTEGER; BEGIN SELECT MAXSEQ.NEXTVAL INTO NEXTVAL FROM DUAL; 
:NEW.ROWSTAMP := NEXTVAL; END;
/

-- End of DDL Script for Table IFRMAXIMO.MAXSYSCOLSCFG

-- Start of DDL Script for Table IFRMAXIMO.MAXSYSCOLUMNS
-- Generated 9-mar-2004 20:15:14 from SYSMAN@MAQUINA4

CREATE TABLE maxsyscolumns
    (rowstamp                       VARCHAR2(40) NOT NULL,
    tbname                         VARCHAR2(18) NOT NULL,
    name                           VARCHAR2(18) NOT NULL,
    colalias                       VARCHAR2(18) NOT NULL,
    colno                          NUMBER NOT NULL,
    maxtype                        VARCHAR2(8) NOT NULL,
    length                         NUMBER NOT NULL,
    scale                          NUMBER NOT NULL,
    nulls                          VARCHAR2(1) NOT NULL,
    maxvlname                      VARCHAR2(18),
    maxvltype                      NUMBER,
    isldkey                        VARCHAR2(1) NOT NULL,
    isldowner                      VARCHAR2(1) NOT NULL,
    sameastable                    VARCHAR2(18),
    sameascolumn                   VARCHAR2(18),
    mustbe                         VARCHAR2(1) NOT NULL,
    changed                        VARCHAR2(1) NOT NULL,
    ispositive                     VARCHAR2(1) NOT NULL,
    remarks                        VARCHAR2(254),
    nullwithdefault                VARCHAR2(1) NOT NULL,
    defaultvalue                   VARCHAR2(50),
    columntitle                    VARCHAR2(80) NOT NULL,
    dlfilterlistorder              NUMBER NOT NULL,
    primarykeycolseq               NUMBER)
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Indexes for MAXSYSCOLUMNS

CREATE INDEX maxsyscolumn_ndx3 ON maxsyscolumns
  (
    tbname                          ASC,
    dlfilterlistorder               ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/
CREATE UNIQUE INDEX maxsyscols_ndx1 ON maxsyscolumns
  (
    tbname                          ASC,
    name                            ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/
CREATE UNIQUE INDEX maxsyscols_ndx2 ON maxsyscolumns
  (
    tbname                          ASC,
    colalias                        ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/
CREATE UNIQUE INDEX maxsyscolumn_ndx4 ON maxsyscolumns
  (
    tbname                          ASC,
    colno                           ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/


-- Triggers for MAXSYSCOLUMNS

CREATE TRIGGER maxsyscolumns_t
BEFORE INSERT  OR UPDATE 
ON maxsyscolumns
REFERENCING NEW AS NEW OLD AS OLD
FOR EACH ROW
DECLARE 
NEXTVAL INTEGER; BEGIN SELECT MAXSEQ.NEXTVAL INTO NEXTVAL FROM DUAL; 
:NEW.ROWSTAMP := NEXTVAL; END;
/

-- End of DDL Script for Table IFRMAXIMO.MAXSYSCOLUMNS

-- Start of DDL Script for Table IFRMAXIMO.MAXSYSCOLUMNS2
-- Generated 9-mar-2004 20:15:33 from SYSMAN@MAQUINA4

CREATE TABLE maxsyscolumns2
    (rowstamp                       VARCHAR2(40) NOT NULL,
    tbname                         VARCHAR2(18) NOT NULL,
    name                           VARCHAR2(18) NOT NULL,
    objectdefaultvalue             VARCHAR2(50),
    domainid                       VARCHAR2(18),
    userdefined                    VARCHAR2(1) NOT NULL,
    customclassname                VARCHAR2(80),
    translatable                   VARCHAR2(1) DEFAULT 'N'  NOT NULL,
    persistent                     VARCHAR2(1) NOT NULL,
    canautonum                     VARCHAR2(1) NOT NULL,
    esigenabled                    VARCHAR2(1) NOT NULL,
    eauditenabled                  VARCHAR2(1) NOT NULL)
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Indexes for MAXSYSCOLUMNS2

CREATE UNIQUE INDEX maxsyscols2_ndx1 ON maxsyscolumns2
  (
    tbname                          ASC,
    name                            ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/


-- Triggers for MAXSYSCOLUMNS2

CREATE TRIGGER maxsyscolumns2_t
BEFORE INSERT  OR UPDATE 
ON maxsyscolumns2
REFERENCING NEW AS NEW OLD AS OLD
FOR EACH ROW
DECLARE 
NEXTVAL INTEGER; BEGIN SELECT MAXSEQ.NEXTVAL INTO NEXTVAL FROM DUAL; 
:NEW.ROWSTAMP := NEXTVAL; END;
/

-- End of DDL Script for Table IFRMAXIMO.MAXSYSCOLUMNS2

-- Start of DDL Script for Table IFRMAXIMO.MAXSYSINDEXES
-- Generated 9-mar-2004 20:15:40 from SYSMAN@MAQUINA4

CREATE TABLE maxsysindexes
    (rowstamp                       VARCHAR2(40) NOT NULL,
    name                           VARCHAR2(18) NOT NULL,
    tbname                         VARCHAR2(18) NOT NULL,
    uniquerule                     VARCHAR2(1) NOT NULL,
    changed                        VARCHAR2(1),
    clusterrule                    VARCHAR2(1),
    storagepartition               VARCHAR2(30))
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Indexes for MAXSYSINDEXES

CREATE INDEX maxsysndx_ndx2 ON maxsysindexes
  (
    tbname                          ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/
CREATE UNIQUE INDEX maxsysndx_ndx ON maxsysindexes
  (
    name                            ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/


-- Triggers for MAXSYSINDEXES

CREATE TRIGGER maxsysindexes_t
BEFORE INSERT  OR UPDATE 
ON maxsysindexes
REFERENCING NEW AS NEW OLD AS OLD
FOR EACH ROW
DECLARE 
NEXTVAL INTEGER; BEGIN SELECT MAXSEQ.NEXTVAL INTO NEXTVAL FROM DUAL; 
:NEW.ROWSTAMP := NEXTVAL; END;
/

-- End of DDL Script for Table IFRMAXIMO.MAXSYSINDEXES

-- Start of DDL Script for Table IFRMAXIMO.MAXSYSKEYS
-- Generated 9-mar-2004 20:15:49 from SYSMAN@MAQUINA4

CREATE TABLE maxsyskeys
    (ixname                         VARCHAR2(18) NOT NULL,
    colname                        VARCHAR2(18) NOT NULL,
    colseq                         NUMBER NOT NULL,
    ordering                       VARCHAR2(1) NOT NULL,
    changed                        VARCHAR2(1),
    rowstamp                       VARCHAR2(40) NOT NULL)
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Indexes for MAXSYSKEYS

CREATE UNIQUE INDEX maxsyskeys_ndx ON maxsyskeys
  (
    ixname                          ASC,
    colname                         ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/
CREATE UNIQUE INDEX maxsyskeys_ndx2 ON maxsyskeys
  (
    ixname                          ASC,
    colseq                          ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/


-- Triggers for MAXSYSKEYS

CREATE TRIGGER maxsyskeys_t
BEFORE INSERT  OR UPDATE 
ON maxsyskeys
REFERENCING NEW AS NEW OLD AS OLD
FOR EACH ROW
DECLARE NEXTVAL INTEGER; BEGIN SELECT MAXSEQ.NEXTVAL INTO NEXTVAL FROM DUAL; :NEW.ROWSTAMP := NEXTVAL; END;
/

-- End of DDL Script for Table IFRMAXIMO.MAXSYSKEYS

-- Start of DDL Script for Table IFRMAXIMO.MAXTABLEDOMAIN
-- Generated 9-mar-2004 20:16:00 from SYSMAN@MAQUINA4

CREATE TABLE maxtabledomain
    (domainid                       VARCHAR2(18) NOT NULL,
    tbname                         VARCHAR2(18) NOT NULL,
    validtnwhereclause             VARCHAR2(254),
    listwhereclause                VARCHAR2(254),
    errorresourcbundle             VARCHAR2(50),
    erroraccesskey                 VARCHAR2(50),
    rowstamp                       VARCHAR2(40) NOT NULL)
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Indexes for MAXTABLEDOMAIN

CREATE UNIQUE INDEX maxtabledom_ndx1 ON maxtabledomain
  (
    domainid                        ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/


-- Triggers for MAXTABLEDOMAIN

CREATE TRIGGER maxtabledomain_t
BEFORE INSERT  OR UPDATE 
ON maxtabledomain
REFERENCING NEW AS NEW OLD AS OLD
FOR EACH ROW
DECLARE NEXTVAL INTEGER; BEGIN SELECT MAXSEQ.NEXTVAL INTO NEXTVAL FROM DUAL; :NEW.ROWSTAMP := NEXTVAL; END;
/

-- End of DDL Script for Table IFRMAXIMO.MAXTABLEDOMAIN

-- Start of DDL Script for Table IFRMAXIMO.MAXTABLES
-- Generated 9-mar-2004 20:16:05 from SYSMAN@MAQUINA4

CREATE TABLE maxtables
    (rowstamp                       VARCHAR2(40) NOT NULL,
    app                            VARCHAR2(10) NOT NULL,
    tbname                         VARCHAR2(18) NOT NULL,
    description                    VARCHAR2(50),
    tbalias                        VARCHAR2(18),
    curtbalias                     VARCHAR2(18),
    changed                        VARCHAR2(1),
    restoredata                    VARCHAR2(1),
    storagepartition               VARCHAR2(30))
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Indexes for MAXTABLES

CREATE INDEX maxtables_ndx2 ON maxtables
  (
    app                             ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/
CREATE UNIQUE INDEX maxtables_ndx ON maxtables
  (
    tbname                          ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/


-- Triggers for MAXTABLES

CREATE TRIGGER maxtables_t
BEFORE INSERT  OR UPDATE 
ON maxtables
REFERENCING NEW AS NEW OLD AS OLD
FOR EACH ROW
DECLARE 
NEXTVAL INTEGER; BEGIN SELECT MAXSEQ.NEXTVAL INTO NEXTVAL FROM DUAL; 
:NEW.ROWSTAMP := NEXTVAL; END;
/

-- End of DDL Script for Table IFRMAXIMO.MAXTABLES

-- Start of DDL Script for Table IFRMAXIMO.MAXTABLES2
-- Generated 9-mar-2004 20:16:17 from SYSMAN@MAQUINA4

CREATE TABLE maxtables2
    (rowstamp                       VARCHAR2(40) NOT NULL,
    tbname                         VARCHAR2(18) NOT NULL,
    servicename                    VARCHAR2(18) NOT NULL,
    classname                      VARCHAR2(80) NOT NULL,
    persistent                     VARCHAR2(1) NOT NULL,
    userdefined                    VARCHAR2(1) NOT NULL,
    inherited                      VARCHAR2(1) NOT NULL,
    addrowstamp                    VARCHAR2(1) NOT NULL,
    siteorgtype                    VARCHAR2(7) NOT NULL,
    esigfilter                     VARCHAR2(254),
    eauditfilter                   VARCHAR2(254),
    eauditenabled                  VARCHAR2(1) NOT NULL,
    eaudittbname                   VARCHAR2(18))
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Indexes for MAXTABLES2

CREATE INDEX maxtables2_ndx2 ON maxtables2
  (
    servicename                     ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/
CREATE UNIQUE INDEX maxtables2_ndx1 ON maxtables2
  (
    tbname                          ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/


-- Triggers for MAXTABLES2

CREATE TRIGGER maxtables2_t
BEFORE INSERT  OR UPDATE 
ON maxtables2
REFERENCING NEW AS NEW OLD AS OLD
FOR EACH ROW
DECLARE 
NEXTVAL INTEGER; BEGIN SELECT MAXSEQ.NEXTVAL INTO NEXTVAL FROM DUAL; 
:NEW.ROWSTAMP := NEXTVAL; END;
/

-- End of DDL Script for Table IFRMAXIMO.MAXTABLES2

-- Start of DDL Script for Table IFRMAXIMO.MAXTABLESCFG
-- Generated 9-mar-2004 20:16:28 from SYSMAN@MAQUINA4

CREATE TABLE maxtablescfg
    (rowstamp                       VARCHAR2(40) NOT NULL,
    app                            VARCHAR2(10) NOT NULL,
    tbname                         VARCHAR2(18) NOT NULL,
    description                    VARCHAR2(50),
    tbalias                        VARCHAR2(18),
    curtbalias                     VARCHAR2(18),
    restoredata                    VARCHAR2(1),
    storagepartition               VARCHAR2(30),
    servicename                    VARCHAR2(18),
    classname                      VARCHAR2(80),
    persistent                     VARCHAR2(1) NOT NULL,
    userdefined                    VARCHAR2(1) NOT NULL,
    inherited                      VARCHAR2(1) NOT NULL,
    addrowstamp                    VARCHAR2(1) NOT NULL,
    changed                        VARCHAR2(1),
    siteorgtype                    VARCHAR2(7) NOT NULL,
    esigfilter                     VARCHAR2(254),
    eauditfilter                   VARCHAR2(254),
    eauditenabled                  VARCHAR2(1) NOT NULL,
    eaudittbname                   VARCHAR2(18))
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Indexes for MAXTABLESCFG

CREATE UNIQUE INDEX maxtablescfg_ndx1 ON maxtablescfg
  (
    tbname                          ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/
CREATE INDEX maxtablescfg_ndx2 ON maxtablescfg
  (
    app                             ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/


-- Triggers for MAXTABLESCFG

CREATE TRIGGER maxtablescfg_t
BEFORE INSERT  OR UPDATE 
ON maxtablescfg
REFERENCING NEW AS NEW OLD AS OLD
FOR EACH ROW
DECLARE 
NEXTVAL INTEGER; BEGIN SELECT MAXSEQ.NEXTVAL INTO NEXTVAL FROM DUAL; 
:NEW.ROWSTAMP := NEXTVAL; END;
/

-- End of DDL Script for Table IFRMAXIMO.MAXTABLESCFG

-- Start of DDL Script for Table IFRMAXIMO.MAXTRIGGERS
-- Generated 9-mar-2004 20:16:38 from SYSMAN@MAQUINA4

CREATE TABLE maxtriggers
    (rowstamp                       VARCHAR2(40) NOT NULL,
    triggername                    VARCHAR2(30) NOT NULL,
    tbname                         VARCHAR2(18) NOT NULL,
    trigbody                       LONG NOT NULL)
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Indexes for MAXTRIGGERS

CREATE UNIQUE INDEX maxtriggers_ndx1 ON maxtriggers
  (
    triggername                     ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/
CREATE INDEX maxtriggers_ndx2 ON maxtriggers
  (
    tbname                          ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/


-- Triggers for MAXTRIGGERS

CREATE TRIGGER maxtriggers_t
BEFORE INSERT  OR UPDATE 
ON maxtriggers
REFERENCING NEW AS NEW OLD AS OLD
FOR EACH ROW
DECLARE 
NEXTVAL INTEGER; BEGIN SELECT MAXSEQ.NEXTVAL INTO NEXTVAL FROM DUAL; 
:NEW.ROWSTAMP := NEXTVAL; END;
/

-- End of DDL Script for Table IFRMAXIMO.MAXTRIGGERS

-- Start of DDL Script for Table IFRMAXIMO.MAXUPGRECORDCOUNT
-- Generated 9-mar-2004 20:16:48 from SYSMAN@MAQUINA4

CREATE TABLE maxupgrecordcount
    (tbname                         VARCHAR2(18),
    recordprecount                 NUMBER,
    recordpostcount                NUMBER)
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- End of DDL Script for Table IFRMAXIMO.MAXUPGRECORDCOUNT

-- Start of DDL Script for Table IFRMAXIMO.MAXUSERAUTH
-- Generated 9-mar-2004 20:16:50 from SYSMAN@MAQUINA4

CREATE TABLE maxuserauth
    (rowstamp                       VARCHAR2(40) NOT NULL,
    app                            VARCHAR2(10) NOT NULL,
    optionname                     VARCHAR2(10) NOT NULL,
    optionvalue                    NUMBER(15) NOT NULL,
    name                           VARCHAR2(18) NOT NULL)
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Indexes for MAXUSERAUTH

CREATE INDEX maxuserauth_ndx2 ON maxuserauth
  (
    name                            ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/
CREATE UNIQUE INDEX maxusrauth_ndx ON maxuserauth
  (
    app                             ASC,
    optionname                      ASC,
    name                            ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/


-- Triggers for MAXUSERAUTH

CREATE TRIGGER maxuserauth_t
BEFORE INSERT  OR UPDATE 
ON maxuserauth
REFERENCING NEW AS NEW OLD AS OLD
FOR EACH ROW
DECLARE 
NEXTVAL INTEGER; BEGIN SELECT MAXSEQ.NEXTVAL INTO NEXTVAL FROM DUAL; 
:NEW.ROWSTAMP := NEXTVAL; END;
/

-- End of DDL Script for Table IFRMAXIMO.MAXUSERAUTH

-- Start of DDL Script for Table IFRMAXIMO.MAXUSERAUTH_BK
-- Generated 9-mar-2004 20:17:00 from SYSMAN@MAQUINA4

CREATE TABLE maxuserauth_bk
    (app                            VARCHAR2(10) NOT NULL,
    optionname                     VARCHAR2(10) NOT NULL,
    optionvalue                    NUMBER(15) NOT NULL,
    name                           VARCHAR2(18) NOT NULL,
    rowstamp                       VARCHAR2(40) NOT NULL)
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- End of DDL Script for Table IFRMAXIMO.MAXUSERAUTH_BK

-- Start of DDL Script for Table IFRMAXIMO.MAXUSERGROUPS
-- Generated 9-mar-2004 20:17:01 from SYSMAN@MAQUINA4

CREATE TABLE maxusergroups
    (rowstamp                       VARCHAR2(40) NOT NULL,
    usrname                        VARCHAR2(18) NOT NULL,
    grpname                        VARCHAR2(18) NOT NULL,
    expiration                     DATE,
    inherited                      VARCHAR2(1) NOT NULL,
    laborcode                      VARCHAR2(12),
    failedlogins                   NUMBER,
    status                         VARCHAR2(10) NOT NULL,
    wfactive                       VARCHAR2(1) NOT NULL,
    wfid                           NUMBER,
    siteid                         VARCHAR2(8),
    startcenterid                  VARCHAR2(8) NOT NULL,
    showwfinbox                    VARCHAR2(1) NOT NULL)
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Indexes for MAXUSERGROUPS

CREATE INDEX maxusergroups_ndx2 ON maxusergroups
  (
    wfid                            ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/
CREATE UNIQUE INDEX maxusergroups_ndx ON maxusergroups
  (
    usrname                         ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/


-- Triggers for MAXUSERGROUPS

CREATE TRIGGER maxusergroups_t
BEFORE INSERT  OR UPDATE 
ON maxusergroups
REFERENCING NEW AS NEW OLD AS OLD
FOR EACH ROW
DECLARE 
NEXTVAL INTEGER; BEGIN SELECT MAXSEQ.NEXTVAL INTO NEXTVAL FROM DUAL; 
:NEW.ROWSTAMP := NEXTVAL; END;
/

-- End of DDL Script for Table IFRMAXIMO.MAXUSERGROUPS

-- Start of DDL Script for Table IFRMAXIMO.MAXUSERSTATUS
-- Generated 9-mar-2004 20:17:13 from SYSMAN@MAQUINA4

CREATE TABLE maxuserstatus
    (rowstamp                       VARCHAR2(40) NOT NULL,
    username                       VARCHAR2(18) NOT NULL,
    status                         VARCHAR2(10) NOT NULL,
    changedate                     DATE NOT NULL,
    changeby                       VARCHAR2(18) NOT NULL,
    memo                           VARCHAR2(100))
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Indexes for MAXUSERSTATUS

CREATE INDEX maxuserstatus_ndx1 ON maxuserstatus
  (
    username                        ASC,
    changedate                      ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/


-- Triggers for MAXUSERSTATUS

CREATE TRIGGER maxuserstatus_t
BEFORE INSERT  OR UPDATE 
ON maxuserstatus
REFERENCING NEW AS NEW OLD AS OLD
FOR EACH ROW
DECLARE 
NEXTVAL INTEGER; BEGIN SELECT MAXSEQ.NEXTVAL INTO NEXTVAL FROM DUAL; 
:NEW.ROWSTAMP := NEXTVAL; END;
/

-- End of DDL Script for Table IFRMAXIMO.MAXUSERSTATUS

-- Start of DDL Script for Table IFRMAXIMO.MAXVARS
-- Generated 9-mar-2004 20:17:18 from SYSMAN@MAQUINA4

CREATE TABLE maxvars
    (rowstamp                       VARCHAR2(40) NOT NULL,
    varname                        VARCHAR2(18) NOT NULL,
    varvalue                       VARCHAR2(254),
    orgid                          VARCHAR2(8),
    siteid                         VARCHAR2(8))
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Indexes for MAXVARS

CREATE UNIQUE INDEX maxvars_ndx1 ON maxvars
  (
    varname                         ASC,
    orgid                           ASC,
    siteid                          ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/
CREATE UNIQUE INDEX maxvars_ndx2 ON maxvars
  (
    varname                         ASC,
    siteid                          ASC,
    orgid                           ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/


-- Triggers for MAXVARS

CREATE TRIGGER maxvars_t
BEFORE INSERT  OR UPDATE 
ON maxvars
REFERENCING NEW AS NEW OLD AS OLD
FOR EACH ROW
DECLARE 
NEXTVAL INTEGER; BEGIN SELECT MAXSEQ.NEXTVAL INTO NEXTVAL FROM DUAL; 
:NEW.ROWSTAMP := NEXTVAL; END;
/

-- End of DDL Script for Table IFRMAXIMO.MAXVARS

-- Start of DDL Script for Table IFRMAXIMO.MAXVARTYPE
-- Generated 9-mar-2004 20:17:28 from SYSMAN@MAQUINA4

CREATE TABLE maxvartype
    (rowstamp                       VARCHAR2(40) NOT NULL,
    varname                        VARCHAR2(18) NOT NULL,
    vartype                        VARCHAR2(6) NOT NULL,
    defaultvalue                   VARCHAR2(254),
    description                    VARCHAR2(150))
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Indexes for MAXVARTYPE

CREATE UNIQUE INDEX maxvartype_ndx1 ON maxvartype
  (
    varname                         ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/


-- Triggers for MAXVARTYPE

CREATE TRIGGER maxvartype_t
BEFORE INSERT  OR UPDATE 
ON maxvartype
REFERENCING NEW AS NEW OLD AS OLD
FOR EACH ROW
DECLARE 
NEXTVAL INTEGER; BEGIN SELECT MAXSEQ.NEXTVAL INTO NEXTVAL FROM DUAL; 
:NEW.ROWSTAMP := NEXTVAL; END;
/

-- End of DDL Script for Table IFRMAXIMO.MAXVARTYPE

-- Start of DDL Script for Table IFRMAXIMO.MEASUREMENT
-- Generated 9-mar-2004 20:17:35 from SYSMAN@MAQUINA4

CREATE TABLE measurement
    (rowstamp                       VARCHAR2(40) NOT NULL,
    pointnum                       VARCHAR2(16) NOT NULL,
    measuredate                    DATE NOT NULL,
    measurementvalue               NUMBER(15,3) NOT NULL,
    ms1                            VARCHAR2(10),
    ms2                            VARCHAR2(10),
    ms3                            VARCHAR2(10),
    ms4                            VARCHAR2(10),
    ms5                            VARCHAR2(10),
    ms6                            NUMBER(10,2),
    ms7                            DATE,
    ms8                            VARCHAR2(10),
    ms9                            NUMBER,
    ms10                           VARCHAR2(1),
    msmp1                          VARCHAR2(10),
    msmp2                          VARCHAR2(10),
    msmp3                          VARCHAR2(10),
    msmp4                          DATE,
    msmp5                          NUMBER(15,2),
    siteid                         VARCHAR2(8) NOT NULL,
    orgid                          VARCHAR2(8) NOT NULL)
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Indexes for MEASUREMENT

CREATE INDEX measurement_ndx1 ON measurement
  (
    siteid                          ASC,
    pointnum                        ASC,
    measuredate                     ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/


-- Triggers for MEASUREMENT

CREATE TRIGGER measurement_t
BEFORE INSERT  OR UPDATE 
ON measurement
REFERENCING NEW AS NEW OLD AS OLD
FOR EACH ROW
DECLARE 
NEXTVAL INTEGER; BEGIN SELECT MAXSEQ.NEXTVAL INTO NEXTVAL FROM DUAL; 
:NEW.ROWSTAMP := NEXTVAL; END;
/

-- End of DDL Script for Table IFRMAXIMO.MEASUREMENT

-- Start of DDL Script for Table IFRMAXIMO.MEASUREPOINT
-- Generated 9-mar-2004 20:17:41 from SYSMAN@MAQUINA4

CREATE TABLE measurepoint
    (rowstamp                       VARCHAR2(40) NOT NULL,
    pointnum                       VARCHAR2(16) NOT NULL,
    pointname                      VARCHAR2(16) NOT NULL,
    eqnum                          VARCHAR2(12) NOT NULL,
    pmnum                          VARCHAR2(16),
    description                    VARCHAR2(50),
    unitofmeasure                  VARCHAR2(18),
    priority                       NUMBER NOT NULL,
    lowerwarning                   NUMBER(15,3) NOT NULL,
    loweraction                    NUMBER(15,3) NOT NULL,
    upperwarning                   NUMBER(15,3) NOT NULL,
    upperaction                    NUMBER(15,3) NOT NULL,
    mp1                            VARCHAR2(10),
    mp2                            VARCHAR2(10),
    mp3                            NUMBER(10,2),
    mp4                            VARCHAR2(10),
    mp5                            NUMBER,
    ldkey                          NUMBER,
    mp6                            VARCHAR2(10),
    mp7                            VARCHAR2(10),
    mp8                            VARCHAR2(10),
    mp9                            DATE,
    mp10                           NUMBER(15,2),
    siteid                         VARCHAR2(8) NOT NULL,
    orgid                          VARCHAR2(8) NOT NULL)
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Indexes for MEASUREPOINT

CREATE UNIQUE INDEX measurepoint_ndx1 ON measurepoint
  (
    siteid                          ASC,
    pointnum                        ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/
CREATE UNIQUE INDEX measurepoint_ndx2 ON measurepoint
  (
    siteid                          ASC,
    eqnum                           ASC,
    pointnum                        ASC,
    pointname                       ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/


-- Triggers for MEASUREPOINT

CREATE TRIGGER measurepoint_t
BEFORE INSERT  OR UPDATE 
ON measurepoint
REFERENCING NEW AS NEW OLD AS OLD
FOR EACH ROW
DECLARE 
NEXTVAL INTEGER; BEGIN SELECT MAXSEQ.NEXTVAL INTO NEXTVAL FROM DUAL; 
:NEW.ROWSTAMP := NEXTVAL; END;
/

-- End of DDL Script for Table IFRMAXIMO.MEASUREPOINT

-- Start of DDL Script for Table IFRMAXIMO.MEASUREUNIT
-- Generated 9-mar-2004 20:17:50 from SYSMAN@MAQUINA4

CREATE TABLE measureunit
    (rowstamp                       VARCHAR2(40) NOT NULL,
    measureunitid                  VARCHAR2(8) NOT NULL,
    abbreviation                   VARCHAR2(8),
    description                    VARCHAR2(30),
    orgid                          VARCHAR2(8) NOT NULL)
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Indexes for MEASUREUNIT

CREATE UNIQUE INDEX measureunit_ndx1 ON measureunit
  (
    orgid                           ASC,
    measureunitid                   ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/


-- Triggers for MEASUREUNIT

CREATE TRIGGER measureunit_t
BEFORE INSERT  OR UPDATE 
ON measureunit
REFERENCING NEW AS NEW OLD AS OLD
FOR EACH ROW
DECLARE 
NEXTVAL INTEGER; BEGIN SELECT MAXSEQ.NEXTVAL INTO NEXTVAL FROM DUAL; 
:NEW.ROWSTAMP := NEXTVAL; END;
/

-- End of DDL Script for Table IFRMAXIMO.MEASUREUNIT

-- Start of DDL Script for Table IFRMAXIMO.MR
-- Generated 9-mar-2004 20:17:55 from SYSMAN@MAQUINA4

CREATE TABLE mr
    (rowstamp                       VARCHAR2(40) NOT NULL,
    mrnum                          VARCHAR2(8) NOT NULL,
    type                           VARCHAR2(10) NOT NULL,
    description                    VARCHAR2(50),
    status                         VARCHAR2(8) NOT NULL,
    statusdate                     DATE NOT NULL,
    changedate                     DATE NOT NULL,
    changeby                       VARCHAR2(18) NOT NULL,
    priority                       NUMBER NOT NULL,
    requestedby                    VARCHAR2(18),
    phone                          VARCHAR2(20),
    mrdate                         DATE NOT NULL,
    requireddate                   DATE,
    shipto                         VARCHAR2(50),
    droppoint                      VARCHAR2(12),
    totalcost                      NUMBER(10,2) NOT NULL,
    wonum                          VARCHAR2(18),
    eqnum                          VARCHAR2(12),
    location                       VARCHAR2(18),
    gldebitacct                    VARCHAR2(20),
    historyflag                    VARCHAR2(1) NOT NULL,
    enterdate                      DATE NOT NULL,
    enterby                        VARCHAR2(18) NOT NULL,
    wfid                           NUMBER,
    wfactive                       VARCHAR2(1) NOT NULL,
    ldkey                          NUMBER,
    mrstatusseq                    NUMBER,
    mr1                            VARCHAR2(1),
    mr2                            VARCHAR2(1),
    mr3                            VARCHAR2(1),
    mr4                            VARCHAR2(1),
    mr5                            VARCHAR2(1),
    mr6                            VARCHAR2(1),
    mr7                            VARCHAR2(1),
    mr8                            VARCHAR2(1),
    mr9                            VARCHAR2(1),
    mr10                           VARCHAR2(1),
    mrla1                          VARCHAR2(10),
    mrla2                          VARCHAR2(10),
    mrla3                          VARCHAR2(10),
    mrla4                          VARCHAR2(10),
    mrla5                          VARCHAR2(10),
    pcardnum                       VARCHAR2(30),
    pcardtype                      VARCHAR2(20),
    pcardexpdate                   VARCHAR2(7),
    fincntrlid                     VARCHAR2(8),
    pcardverification              VARCHAR2(4),
    basetotalcost                  NUMBER(10,2),
    basetotalcost2                 NUMBER(10,2),
    siteid                         VARCHAR2(8) NOT NULL,
    orgid                          VARCHAR2(8) NOT NULL)
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Indexes for MR

CREATE UNIQUE INDEX mr_ndx1 ON mr
  (
    siteid                          ASC,
    mrnum                           ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/
CREATE INDEX mr_ndx2 ON mr
  (
    siteid                          ASC,
    wfid                            ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/


-- Triggers for MR

CREATE TRIGGER mr_t
BEFORE INSERT  OR UPDATE 
ON mr
REFERENCING NEW AS NEW OLD AS OLD
FOR EACH ROW
DECLARE 
NEXTVAL INTEGER; BEGIN SELECT MAXSEQ.NEXTVAL INTO NEXTVAL FROM DUAL; 
:NEW.ROWSTAMP := NEXTVAL; END;
/

-- End of DDL Script for Table IFRMAXIMO.MR

-- Start of DDL Script for Table IFRMAXIMO.MRCOST
-- Generated 9-mar-2004 20:18:05 from SYSMAN@MAQUINA4

CREATE TABLE mrcost
    (rowstamp                       VARCHAR2(40) NOT NULL,
    mrcostlineid                   NUMBER NOT NULL,
    mrnum                          VARCHAR2(8) NOT NULL,
    percentage                     NUMBER(5,2) NOT NULL,
    gldebitacct                    VARCHAR2(20),
    fincntrlid                     VARCHAR2(8),
    siteid                         VARCHAR2(8) NOT NULL,
    linecost                       NUMBER(10,2) NOT NULL,
    mrlineid                       NUMBER NOT NULL,
    orgid                          VARCHAR2(8) NOT NULL)
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Indexes for MRCOST

CREATE UNIQUE INDEX mrcost_ndx1 ON mrcost
  (
    siteid                          ASC,
    mrcostlineid                    ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/


-- Triggers for MRCOST

CREATE TRIGGER mrcost_t
BEFORE INSERT  OR UPDATE 
ON mrcost
REFERENCING NEW AS NEW OLD AS OLD
FOR EACH ROW
DECLARE 
NEXTVAL INTEGER; BEGIN SELECT MAXSEQ.NEXTVAL INTO NEXTVAL FROM DUAL; 
:NEW.ROWSTAMP := NEXTVAL; END;
/

-- End of DDL Script for Table IFRMAXIMO.MRCOST

-- Start of DDL Script for Table IFRMAXIMO.MRLINE
-- Generated 9-mar-2004 20:18:09 from SYSMAN@MAQUINA4

CREATE TABLE mrline
    (rowstamp                       VARCHAR2(40) NOT NULL,
    mrnum                          VARCHAR2(8) NOT NULL,
    mrlinenum                      NUMBER NOT NULL,
    mrlineid                       NUMBER NOT NULL,
    itemnum                        VARCHAR2(30),
    description                    VARCHAR2(120),
    storeloc                       VARCHAR2(18),
    qty                            NUMBER(15,2),
    unitcost                       NUMBER(10,2),
    linecost                       NUMBER(10,2) NOT NULL,
    directreq                      VARCHAR2(1) NOT NULL,
    eqnum                          VARCHAR2(12),
    location                       VARCHAR2(18),
    gldebitacct                    VARCHAR2(20),
    requireddate                   DATE,
    availdate                      DATE,
    vendor                         VARCHAR2(18),
    manufacturer                   VARCHAR2(18),
    modelnum                       VARCHAR2(8),
    catalogcode                    VARCHAR2(30),
    schargecode                    VARCHAR2(8),
    droppoint                      VARCHAR2(12),
    remarks                        VARCHAR2(50),
    service                        VARCHAR2(1) NOT NULL,
    complete                       VARCHAR2(1) NOT NULL,
    prnum                          VARCHAR2(8),
    partialissue                   VARCHAR2(1) NOT NULL,
    category                       VARCHAR2(4),
    mrlin1                         VARCHAR2(1),
    mrlin2                         VARCHAR2(1),
    mrlin3                         VARCHAR2(1),
    mrlin4                         VARCHAR2(1),
    mrlin5                         VARCHAR2(1),
    orderunit                      VARCHAR2(8),
    mrlin6                         VARCHAR2(10),
    mrlin7                         VARCHAR2(10),
    chargestore                    VARCHAR2(1) NOT NULL,
    ldkey                          NUMBER,
    mrlaln1                        VARCHAR2(10),
    mrlaln2                        VARCHAR2(10),
    mrlaln3                        VARCHAR2(10),
    mrlaln4                        VARCHAR2(10),
    mrlaln5                        VARCHAR2(10),
    pcardnum                       VARCHAR2(30),
    pcardtype                      VARCHAR2(20),
    pcardexpdate                   VARCHAR2(7),
    classificationid               VARCHAR2(18),
    agreementponum                 VARCHAR2(8),
    fincntrlid                     VARCHAR2(8),
    pcardverification              VARCHAR2(4),
    mrlin8                         VARCHAR2(10),
    mrlin9                         VARCHAR2(10),
    mrlin10                        VARCHAR2(10),
    vendorpackcode                 VARCHAR2(12),
    vendorpackquantity             VARCHAR2(12),
    vendorwarehouse                VARCHAR2(12),
    currencycode                   VARCHAR2(8) NOT NULL,
    linecost1                      NUMBER(10,2),
    linecost2                      NUMBER(10,2),
    exchangerate                   NUMBER(14,7),
    exchangerate2                  NUMBER(14,7),
    inspectionrequired             VARCHAR2(1) NOT NULL,
    mktplcitem                     VARCHAR2(1) NOT NULL,
    siteid                         VARCHAR2(8) NOT NULL,
    orgid                          VARCHAR2(8) NOT NULL,
    isdistributed                  VARCHAR2(1) NOT NULL,
    refwo                          VARCHAR2(18),
    enteredastask                  VARCHAR2(1) NOT NULL)
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Indexes for MRLINE

CREATE INDEX mrline_ndx3 ON mrline
  (
    siteid                          ASC,
    prnum                           ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/
CREATE UNIQUE INDEX mrline_ndx1 ON mrline
  (
    siteid                          ASC,
    mrlineid                        ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/
CREATE UNIQUE INDEX mrline_ndx2 ON mrline
  (
    siteid                          ASC,
    mrnum                           ASC,
    mrlinenum                       ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/


-- Triggers for MRLINE

CREATE TRIGGER mrline_t
BEFORE INSERT  OR UPDATE 
ON mrline
REFERENCING NEW AS NEW OLD AS OLD
FOR EACH ROW
DECLARE 
NEXTVAL INTEGER; BEGIN SELECT MAXSEQ.NEXTVAL INTO NEXTVAL FROM DUAL; 
:NEW.ROWSTAMP := NEXTVAL; END;
/

-- End of DDL Script for Table IFRMAXIMO.MRLINE

-- Start of DDL Script for Table IFRMAXIMO.MRSTATUS
-- Generated 9-mar-2004 20:18:21 from SYSMAN@MAQUINA4

CREATE TABLE mrstatus
    (rowstamp                       VARCHAR2(40) NOT NULL,
    mrnum                          VARCHAR2(8) NOT NULL,
    status                         VARCHAR2(8) NOT NULL,
    changedate                     DATE NOT NULL,
    changeby                       VARCHAR2(18) NOT NULL,
    memo                           VARCHAR2(100),
    mrstatusseq                    NUMBER NOT NULL,
    siteid                         VARCHAR2(8) NOT NULL,
    orgid                          VARCHAR2(8) NOT NULL)
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Indexes for MRSTATUS

CREATE UNIQUE INDEX mrstatus_ndx1 ON mrstatus
  (
    siteid                          ASC,
    mrstatusseq                     ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/
CREATE INDEX mrstatus_ndx2 ON mrstatus
  (
    siteid                          ASC,
    mrnum                           ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/


-- Triggers for MRSTATUS

CREATE TRIGGER mrstatus_t
BEFORE INSERT  OR UPDATE 
ON mrstatus
REFERENCING NEW AS NEW OLD AS OLD
FOR EACH ROW
DECLARE 
NEXTVAL INTEGER; BEGIN SELECT MAXSEQ.NEXTVAL INTO NEXTVAL FROM DUAL; 
:NEW.ROWSTAMP := NEXTVAL; END;
/

-- End of DDL Script for Table IFRMAXIMO.MRSTATUS

-- Start of DDL Script for Table IFRMAXIMO.MXCOLLAB
-- Generated 9-mar-2004 20:18:31 from SYSMAN@MAQUINA4

CREATE TABLE mxcollab
    (rowstamp                       VARCHAR2(40) NOT NULL,
    owner1sysid                    VARCHAR2(10) NOT NULL,
    owner2sysid                    VARCHAR2(10) NOT NULL,
    pcid                           VARCHAR2(10) NOT NULL,
    pcvalue                        VARCHAR2(1) NOT NULL)
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Indexes for MXCOLLAB

CREATE UNIQUE INDEX mxcollab_ndx2 ON mxcollab
  (
    owner1sysid                     ASC,
    owner2sysid                     ASC,
    pcid                            ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/


-- Triggers for MXCOLLAB

CREATE TRIGGER mxcollab_t
BEFORE INSERT  OR UPDATE 
ON mxcollab
REFERENCING NEW AS NEW OLD AS OLD
FOR EACH ROW
DECLARE 
NEXTVAL INTEGER; BEGIN SELECT MAXSEQ.NEXTVAL INTO NEXTVAL FROM DUAL; 
:NEW.ROWSTAMP := NEXTVAL; END;
/

-- End of DDL Script for Table IFRMAXIMO.MXCOLLAB

-- Start of DDL Script for Table IFRMAXIMO.MXCOLLABREF
-- Generated 9-mar-2004 20:18:38 from SYSMAN@MAQUINA4

CREATE TABLE mxcollabref
    (rowstamp                       VARCHAR2(40) NOT NULL,
    pcid                           VARCHAR2(10) NOT NULL,
    description                    VARCHAR2(100),
    process                        VARCHAR2(20))
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Indexes for MXCOLLABREF

CREATE UNIQUE INDEX mxcollabref_ndx ON mxcollabref
  (
    pcid                            ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/


-- Triggers for MXCOLLABREF

CREATE TRIGGER mxcollabref_t
BEFORE INSERT  OR UPDATE 
ON mxcollabref
REFERENCING NEW AS NEW OLD AS OLD
FOR EACH ROW
DECLARE 
NEXTVAL INTEGER; BEGIN SELECT MAXSEQ.NEXTVAL INTO NEXTVAL FROM DUAL; 
:NEW.ROWSTAMP := NEXTVAL; END;
/

-- End of DDL Script for Table IFRMAXIMO.MXCOLLABREF

-- Start of DDL Script for Table IFRMAXIMO.NUMDOMAINVALUE
-- Generated 9-mar-2004 20:18:44 from SYSMAN@MAQUINA4

CREATE TABLE numdomainvalue
    (rowstamp                       VARCHAR2(40) NOT NULL,
    domainid                       VARCHAR2(18) NOT NULL,
    numvalue                       NUMBER(10,2))
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Indexes for NUMDOMAINVALUE

CREATE UNIQUE INDEX numdomainval_ndx1 ON numdomainvalue
  (
    domainid                        ASC,
    numvalue                        ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/


-- Triggers for NUMDOMAINVALUE

CREATE TRIGGER numdomainvalue_t
BEFORE INSERT  OR UPDATE 
ON numdomainvalue
REFERENCING NEW AS NEW OLD AS OLD
FOR EACH ROW
DECLARE 
NEXTVAL INTEGER; BEGIN SELECT MAXSEQ.NEXTVAL INTO NEXTVAL FROM DUAL; 
:NEW.ROWSTAMP := NEXTVAL; END;
/

-- End of DDL Script for Table IFRMAXIMO.NUMDOMAINVALUE

-- Start of DDL Script for Table IFRMAXIMO.NUMERO
-- Generated 9-mar-2004 20:18:50 from SYSMAN@MAQUINA4

CREATE TABLE numero
    (numero                         VARCHAR2(4))
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- End of DDL Script for Table IFRMAXIMO.NUMERO

-- Start of DDL Script for Table IFRMAXIMO.ORDERUNIT
-- Generated 9-mar-2004 20:18:52 from SYSMAN@MAQUINA4

CREATE TABLE orderunit
    (rowstamp                       VARCHAR2(40) NOT NULL,
    orderunit                      VARCHAR2(8) NOT NULL,
    conversion                     NUMBER(15,2) NOT NULL,
    uomcode                        VARCHAR2(2),
    orgid                          VARCHAR2(8) NOT NULL)
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Indexes for ORDERUNIT

CREATE UNIQUE INDEX orderunit_ndx1 ON orderunit
  (
    orgid                           ASC,
    orderunit                       ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/


-- Triggers for ORDERUNIT

CREATE TRIGGER orderunit_t
BEFORE INSERT  OR UPDATE 
ON orderunit
REFERENCING NEW AS NEW OLD AS OLD
FOR EACH ROW
DECLARE 
NEXTVAL INTEGER; BEGIN SELECT MAXSEQ.NEXTVAL INTO NEXTVAL FROM DUAL; 
:NEW.ROWSTAMP := NEXTVAL; END;
/

-- End of DDL Script for Table IFRMAXIMO.ORDERUNIT

-- Start of DDL Script for Table IFRMAXIMO.ORGANIZATION
-- Generated 9-mar-2004 20:18:59 from SYSMAN@MAQUINA4

CREATE TABLE organization
    (rowstamp                       VARCHAR2(40) NOT NULL,
    orgid                          VARCHAR2(8) NOT NULL,
    description                    VARCHAR2(150),
    ldkey                          NUMBER,
    disabled                       VARCHAR2(1) NOT NULL,
    basecurrency1                  VARCHAR2(8) NOT NULL,
    basecurrency2                  VARCHAR2(8),
    enterby                        VARCHAR2(18) NOT NULL,
    enterdate                      DATE NOT NULL)
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Indexes for ORGANIZATION

CREATE UNIQUE INDEX organization_ndx ON organization
  (
    orgid                           ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/


-- Triggers for ORGANIZATION

CREATE TRIGGER organization_t
BEFORE INSERT  OR UPDATE 
ON organization
REFERENCING NEW AS NEW OLD AS OLD
FOR EACH ROW
DECLARE 
NEXTVAL INTEGER; BEGIN SELECT MAXSEQ.NEXTVAL INTO NEXTVAL FROM DUAL; 
:NEW.ROWSTAMP := NEXTVAL; END;
/

-- End of DDL Script for Table IFRMAXIMO.ORGANIZATION

-- Start of DDL Script for Table IFRMAXIMO.PM
-- Generated 9-mar-2004 20:19:04 from SYSMAN@MAQUINA4

CREATE TABLE pm
    (rowstamp                       VARCHAR2(40) NOT NULL,
    pmnum                          VARCHAR2(16) NOT NULL,
    description                    VARCHAR2(200),
    eqnum                          VARCHAR2(12),
    firstdate                      DATE,
    lastcompdate                   DATE,
    laststartdate                  DATE,
    usetargetdate                  VARCHAR2(1) NOT NULL,
    lastmeterreading               NUMBER(15,2) NOT NULL,
    lastmeterdate                  DATE,
    frequency                      NUMBER NOT NULL,
    meterfrequency                 NUMBER(15,2) NOT NULL,
    pmcounter                      NUMBER NOT NULL,
    priority                       NUMBER NOT NULL,
    worktype                       VARCHAR2(7) NOT NULL,
    jpnum                          VARCHAR2(30),
    jpseqinuse                     VARCHAR2(1) NOT NULL,
    nextdate                       DATE,
    pm17                           VARCHAR2(25),
    pm18                           VARCHAR2(4),
    changedate                     DATE NOT NULL,
    changeby                       VARCHAR2(18) NOT NULL,
    pmeq1                          VARCHAR2(10),
    pm1                            VARCHAR2(10),
    pm2                            VARCHAR2(10),
    pm3                            VARCHAR2(10),
    pm4                            DATE,
    pm5                            VARCHAR2(50),
    ldkey                          NUMBER,
    supervisor                     VARCHAR2(12),
    calendar                       VARCHAR2(8),
    crewid                         VARCHAR2(12),
    interruptable                  VARCHAR2(1) NOT NULL,
    downtime                       VARCHAR2(1) NOT NULL,
    pm6                            VARCHAR2(10),
    pm7                            VARCHAR2(10),
    pm8                            VARCHAR2(10),
    pm9                            NUMBER(10,2),
    pm10                           VARCHAR2(10),
    pmeq2                          DATE,
    pmeq3                          NUMBER(15,2),
    pmjp1                          VARCHAR2(10),
    pmjp2                          VARCHAR2(10),
    pmjp3                          VARCHAR2(10),
    pmjp4                          NUMBER(10,2),
    pmjp5                          VARCHAR2(10),
    glaccount                      VARCHAR2(20),
    location                       VARCHAR2(18),
    storeloc                       VARCHAR2(18),
    parent                         VARCHAR2(16),
    haschildren                    VARCHAR2(1) NOT NULL,
    wosequence                     NUMBER,
    usefrequency                   VARCHAR2(1) NOT NULL,
    route                          VARCHAR2(16),
    frequnit                       VARCHAR2(8) NOT NULL,
    meterfrequency2                NUMBER(15,2) NOT NULL,
    lastmeterreading2              NUMBER(15,2) NOT NULL,
    lastmeterdate2                 DATE,
    leadtime                       NUMBER,
    extdate                        DATE,
    adjnextdue                     VARCHAR2(1) NOT NULL,
    pm11                           VARCHAR2(10),
    pm12                           VARCHAR2(10),
    pm13                           VARCHAR2(10),
    pm14                           NUMBER(10,2),
    pm15                           NUMBER,
    pm16                           VARCHAR2(1),
    masterpm                       VARCHAR2(16),
    overridemasterupd              VARCHAR2(1) NOT NULL,
    ismasterpm                     VARCHAR2(1) NOT NULL,
    masterpmitemnum                VARCHAR2(30),
    applymasterpmtoeq              VARCHAR2(1) NOT NULL,
    applymasterpmtoloc             VARCHAR2(1) NOT NULL,
    updtimebasedfreq               VARCHAR2(1) NOT NULL,
    updstartdate                   VARCHAR2(1) NOT NULL,
    updmeter1                      VARCHAR2(1) NOT NULL,
    updmeter2                      VARCHAR2(1) NOT NULL,
    updjpsequence                  VARCHAR2(1) NOT NULL,
    updextdate                     VARCHAR2(1) NOT NULL,
    updseasonaldates               VARCHAR2(1) NOT NULL,
    wostatus                       VARCHAR2(8) NOT NULL,
    seasonstartday                 NUMBER,
    seasonstartmonth               VARCHAR2(16),
    seasonendday                   NUMBER,
    seasonendmonth                 VARCHAR2(16),
    pmjp6                          VARCHAR2(10),
    pmjp7                          VARCHAR2(10),
    pmjp8                          VARCHAR2(10),
    pmjp9                          NUMBER(10,2),
    pmjp10                         DATE,
    orgid                          VARCHAR2(8) NOT NULL,
    siteid                         VARCHAR2(8) NOT NULL,
    changechildstatus              VARCHAR2(1) NOT NULL)
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Indexes for PM

CREATE INDEX pm_ndx4 ON pm
  (
    siteid                          ASC,
    parent                          ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/
CREATE INDEX pm_ndx5 ON pm
  (
    pm18                            ASC,
    siteid                          ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
PARALLEL (DEGREE DEFAULT)
/
CREATE UNIQUE INDEX pm_ndx1 ON pm
  (
    siteid                          ASC,
    pmnum                           ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/
CREATE INDEX pm_ndx2 ON pm
  (
    siteid                          ASC,
    eqnum                           ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/
CREATE INDEX pm_ndx3 ON pm
  (
    siteid                          ASC,
    location                        ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/


-- Triggers for PM

CREATE TRIGGER pm_t
BEFORE INSERT  OR UPDATE 
ON pm
REFERENCING NEW AS NEW OLD AS OLD
FOR EACH ROW
DECLARE NEXTVAL INTEGER; BEGIN SELECT MAXSEQ.NEXTVAL INTO NEXTVAL FROM DUAL; :NEW.ROWSTAMP := NEXTVAL; END;
/
CREATE TRIGGER tr_dep_pm
BEFORE INSERT 
ON pm
REFERENCING NEW AS NEW OLD AS OLD
FOR EACH ROW
BEGIN
   IF :NEW.CHANGEBY<>'IFRMAXIMO' THEN
      IF SUBSTR(:NEW.CHANGEBY,1,1) = 'I' THEN
         SELECT SUBSTR(USER01,1,4), NULL
         INTO :NEW.PM18 ,:NEW.PM17
         FROM IFRMAXIMO.USUARIO
         WHERE USERNUM=:NEW.CHANGEBY;
      END IF;
      IF SUBSTR(:NEW.CHANGEBY,1,1) = 'C' THEN
         SELECT SUBSTR(USER01,1,4), USER01
         INTO :NEW.PM18 ,:NEW.PM17
         FROM IFRMAXIMO.USUARIO
         WHERE USERNUM=:NEW.CHANGEBY;
      END IF;
   END IF;
END;
/
CREATE TRIGGER tr_pmnum
BEFORE INSERT 
ON pm
REFERENCING NEW AS NEW OLD AS OLD
FOR EACH ROW
DECLARE
  V_EQNUM  IFRMAXIMO.PM.PMNUM%TYPE :='';
  V_LOCAT  IFRMAXIMO.LOCATIONS.LOCATION%TYPE :='';
  V_CONT   NUMBER :=0;
BEGIN
   SELECT COUNT(1)
   INTO   V_CONT
   FROM IFRMAXIMO.EQUIPAMENTO
   WHERE EQNUM = SUBSTR(:NEW.PMNUM,1,4);
   If v_cont = 0 Then
      BEGIN
         SELECT LOCATION
         INTO   v_locat
         FROM IFRMAXIMO.LOCATIONS
         WHERE LOCATION = :NEW.PMNUM;
      EXCEPTION
         WHEN NO_DATA_FOUND THEN
            RAISE_APPLICATION_ERROR(-20654,'Código do Plano de Manutenção Inválido');
      END;
   End If;
END;
/

-- End of DDL Script for Table IFRMAXIMO.PM

-- Start of DDL Script for Table IFRMAXIMO.PM_RECIFE
-- Generated 9-mar-2004 20:19:27 from SYSMAN@MAQUINA4

CREATE TABLE pm_recife
    (rowstamp                       VARCHAR2(40) NOT NULL,
    pmnum                          VARCHAR2(16) NOT NULL,
    description                    VARCHAR2(120),
    eqnum                          VARCHAR2(12),
    firstdate                      DATE,
    lastcompdate                   DATE,
    laststartdate                  DATE,
    usetargetdate                  VARCHAR2(1) NOT NULL,
    lastmeterreading               NUMBER(15,2) NOT NULL,
    lastmeterdate                  DATE,
    frequency                      NUMBER NOT NULL,
    meterfrequency                 NUMBER(15,2) NOT NULL,
    pmcounter                      NUMBER NOT NULL,
    priority                       NUMBER NOT NULL,
    worktype                       VARCHAR2(7) NOT NULL,
    jpnum                          VARCHAR2(30),
    jpseqinuse                     VARCHAR2(1) NOT NULL,
    nextdate                       DATE,
    pm17                           VARCHAR2(25),
    pm18                           VARCHAR2(4),
    changedate                     DATE NOT NULL,
    changeby                       VARCHAR2(18) NOT NULL,
    pmeq1                          VARCHAR2(10),
    pm1                            VARCHAR2(10),
    pm2                            VARCHAR2(10),
    pm3                            VARCHAR2(10),
    pm4                            DATE,
    pm5                            VARCHAR2(50),
    ldkey                          NUMBER,
    supervisor                     VARCHAR2(12),
    calendar                       VARCHAR2(8),
    crewid                         VARCHAR2(12),
    interruptable                  VARCHAR2(1),
    downtime                       VARCHAR2(1),
    pm6                            VARCHAR2(10),
    pm7                            VARCHAR2(10),
    pm8                            VARCHAR2(10),
    pm9                            NUMBER(10,2),
    pm10                           VARCHAR2(10),
    pmeq2                          DATE,
    pmeq3                          NUMBER(15,2),
    pmjp1                          VARCHAR2(10),
    pmjp2                          VARCHAR2(10),
    pmjp3                          VARCHAR2(10),
    pmjp4                          NUMBER(10,2),
    pmjp5                          VARCHAR2(10),
    glaccount                      VARCHAR2(12),
    location                       VARCHAR2(18),
    storeloc                       VARCHAR2(18),
    parent                         VARCHAR2(16),
    haschildren                    VARCHAR2(1) NOT NULL,
    wosequence                     NUMBER,
    usefrequency                   VARCHAR2(1) NOT NULL,
    route                          VARCHAR2(16),
    frequnit                       VARCHAR2(8) NOT NULL,
    meterfrequency2                NUMBER(15,2) NOT NULL,
    lastmeterreading2              NUMBER(15,2) NOT NULL,
    lastmeterdate2                 DATE,
    leadtime                       NUMBER,
    extdate                        DATE,
    adjnextdue                     VARCHAR2(1),
    pm11                           VARCHAR2(10),
    pm12                           VARCHAR2(10),
    pm13                           VARCHAR2(10),
    pm14                           NUMBER(10,2),
    pm15                           NUMBER,
    pm16                           VARCHAR2(1),
    masterpm                       VARCHAR2(16),
    overridemasterupd              VARCHAR2(1) NOT NULL,
    ismasterpm                     VARCHAR2(1) NOT NULL,
    masterpmitemnum                VARCHAR2(20),
    applymasterpmtoeq              VARCHAR2(1) NOT NULL,
    applymasterpmtoloc             VARCHAR2(1) NOT NULL,
    updtimebasedfreq               VARCHAR2(1) NOT NULL,
    updstartdate                   VARCHAR2(1) NOT NULL,
    updmeter1                      VARCHAR2(1) NOT NULL,
    updmeter2                      VARCHAR2(1) NOT NULL,
    updjpsequence                  VARCHAR2(1) NOT NULL,
    updextdate                     VARCHAR2(1) NOT NULL,
    updseasonaldates               VARCHAR2(1) NOT NULL,
    wostatus                       VARCHAR2(8) NOT NULL,
    seasonstartday                 NUMBER,
    seasonstartmonth               VARCHAR2(16),
    seasonendday                   NUMBER,
    seasonendmonth                 VARCHAR2(16),
    pmjp6                          VARCHAR2(10),
    pmjp7                          VARCHAR2(10),
    pmjp8                          VARCHAR2(10),
    pmjp9                          NUMBER(10,2),
    pmjp10                         DATE)
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- End of DDL Script for Table IFRMAXIMO.PM_RECIFE

-- Start of DDL Script for Table IFRMAXIMO.PMANCESTOR
-- Generated 9-mar-2004 20:19:29 from SYSMAN@MAQUINA4

CREATE TABLE pmancestor
    (rowstamp                       VARCHAR2(40) NOT NULL,
    pmnum                          VARCHAR2(16) NOT NULL,
    ancestor                       VARCHAR2(16) NOT NULL,
    hierarchylevels                NUMBER NOT NULL,
    orgid                          VARCHAR2(8) NOT NULL,
    siteid                         VARCHAR2(8) NOT NULL)
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Indexes for PMANCESTOR

CREATE UNIQUE INDEX pmancestor_ndx1 ON pmancestor
  (
    siteid                          ASC,
    pmnum                           ASC,
    ancestor                        ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/


-- Triggers for PMANCESTOR

CREATE TRIGGER pmancestor_t
BEFORE INSERT  OR UPDATE 
ON pmancestor
REFERENCING NEW AS NEW OLD AS OLD
FOR EACH ROW
DECLARE 
NEXTVAL INTEGER; BEGIN SELECT MAXSEQ.NEXTVAL INTO NEXTVAL FROM DUAL; 
:NEW.ROWSTAMP := NEXTVAL; END;
/

-- End of DDL Script for Table IFRMAXIMO.PMANCESTOR

-- Start of DDL Script for Table IFRMAXIMO.PMSCHEDACTIVITY
-- Generated 9-mar-2004 20:19:35 from SYSMAN@MAQUINA4

CREATE TABLE pmschedactivity
    (rowstamp                       VARCHAR2(40) NOT NULL,
    projectname                    VARCHAR2(16) NOT NULL,
    pmschedactivityid              VARCHAR2(16) NOT NULL,
    toplevelactivityid             VARCHAR2(16),
    adjnextdue                     VARCHAR2(1),
    avgmeterperday1                NUMBER(15,2),
    avgmeterperday2                NUMBER(15,2),
    genrtd_activity_id             NUMBER,
    bds_code                       VARCHAR2(60),
    calendar                       VARCHAR2(8),
    act_code_a                     VARCHAR2(10),
    act_code_b                     VARCHAR2(10),
    act_code_c                     VARCHAR2(10),
    act_code_d                     VARCHAR2(10),
    act_code_e                     VARCHAR2(10),
    act_code_f                     VARCHAR2(10),
    act_code_g                     VARCHAR2(10),
    act_code_h                     VARCHAR2(10),
    act_code_i                     VARCHAR2(10),
    act_code_j                     VARCHAR2(10),
    constrainttype                 VARCHAR2(2),
    description                    VARCHAR2(200),
    downtime                       VARCHAR2(1),
    calcduration                   FLOAT(126),
    eqnum                          VARCHAR2(12),
    extdate                        DATE,
    firstdate                      DATE,
    frequency                      NUMBER,
    frequnit                       VARCHAR2(8),
    haschildren                    VARCHAR2(1),
    interruptable                  VARCHAR2(1),
    ismasterpm                     VARCHAR2(1),
    jpnum                          VARCHAR2(30),
    jpseqinuse                     VARCHAR2(1),
    hierarchylevels                NUMBER,
    lastcompdate                   DATE,
    lastmeterdate1                 DATE,
    lastmeterreading1              NUMBER(15,2),
    lastmeterdate2                 DATE,
    lastmeterreading2              NUMBER(15,2),
    laststartdate                  DATE,
    leadtime                       NUMBER,
    location                       VARCHAR2(18),
    predactivityid                 VARCHAR2(16),
    meterfrequency1                NUMBER(15,2),
    meterfrequency2                NUMBER(15,2),
    nextdate                       DATE,
    nextmeterdate1                 DATE,
    nextmeterdate2                 DATE,
    activity_type                  NUMBER,
    parentactivityid               VARCHAR2(16),
    pmcounter                      NUMBER,
    priority                       NUMBER,
    route                          VARCHAR2(16),
    scheddate                      DATE,
    seasonendday                   NUMBER,
    seasonendmonth                 VARCHAR2(16),
    seasonstartday                 NUMBER,
    seasonstartmonth               VARCHAR2(16),
    usefrequency                   VARCHAR2(1),
    usetargetdate                  VARCHAR2(1),
    worktype                       VARCHAR2(7),
    wosequence                     NUMBER,
    orgid                          VARCHAR2(8) NOT NULL,
    siteid                         VARCHAR2(8) NOT NULL)
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Indexes for PMSCHEDACTIVITY

CREATE UNIQUE INDEX pmschedact_ndx1 ON pmschedactivity
  (
    siteid                          ASC,
    projectname                     ASC,
    pmschedactivityid               ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/


-- Triggers for PMSCHEDACTIVITY

CREATE TRIGGER pmschedactivity_t
BEFORE INSERT  OR UPDATE 
ON pmschedactivity
REFERENCING NEW AS NEW OLD AS OLD
FOR EACH ROW
DECLARE 
NEXTVAL INTEGER; BEGIN SELECT MAXSEQ.NEXTVAL INTO NEXTVAL FROM DUAL; 
:NEW.ROWSTAMP := NEXTVAL; END;
/

-- End of DDL Script for Table IFRMAXIMO.PMSCHEDACTIVITY

-- Start of DDL Script for Table IFRMAXIMO.PMSEQUENCE
-- Generated 9-mar-2004 20:19:41 from SYSMAN@MAQUINA4

CREATE TABLE pmsequence
    (rowstamp                       VARCHAR2(40) NOT NULL,
    pmnum                          VARCHAR2(16) NOT NULL,
    jpnum                          VARCHAR2(30),
    interval                       NUMBER NOT NULL,
    orgid                          VARCHAR2(8) NOT NULL,
    siteid                         VARCHAR2(8) NOT NULL)
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Indexes for PMSEQUENCE

CREATE UNIQUE INDEX pmsequence_ndx1 ON pmsequence
  (
    siteid                          ASC,
    pmnum                           ASC,
    interval                        ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/


-- Triggers for PMSEQUENCE

CREATE TRIGGER pmsequence_t
BEFORE INSERT  OR UPDATE 
ON pmsequence
REFERENCING NEW AS NEW OLD AS OLD
FOR EACH ROW
DECLARE 
NEXTVAL INTEGER; BEGIN SELECT MAXSEQ.NEXTVAL INTO NEXTVAL FROM DUAL; 
:NEW.ROWSTAMP := NEXTVAL; END;
/

-- End of DDL Script for Table IFRMAXIMO.PMSEQUENCE

-- Start of DDL Script for Table IFRMAXIMO.PO
-- Generated 9-mar-2004 20:19:48 from SYSMAN@MAQUINA4

CREATE TABLE po
    (rowstamp                       VARCHAR2(40) NOT NULL,
    ponum                          VARCHAR2(8) NOT NULL,
    description                    VARCHAR2(50),
    purchaseagent                  VARCHAR2(12),
    orderdate                      DATE,
    requireddate                   DATE,
    followupdate                   DATE,
    potype                         VARCHAR2(6),
    originalponum                  VARCHAR2(8),
    status                         VARCHAR2(10) NOT NULL,
    statusdate                     DATE NOT NULL,
    vendor                         VARCHAR2(18),
    contact                        VARCHAR2(50),
    freightterms                   VARCHAR2(50),
    paymentterms                   VARCHAR2(20),
    shipvia                        VARCHAR2(20),
    customernum                    VARCHAR2(16),
    fob                            VARCHAR2(20),
    shipto                         VARCHAR2(50),
    shiptoattn                     VARCHAR2(12),
    billto                         VARCHAR2(50),
    billtoattn                     VARCHAR2(12),
    totalcost                      NUMBER(10,2),
    changeby                       VARCHAR2(18) NOT NULL,
    changedate                     DATE NOT NULL,
    priority                       NUMBER NOT NULL,
    historyflag                    VARCHAR2(1) NOT NULL,
    po1                            VARCHAR2(10),
    po2                            VARCHAR2(10),
    po3                            VARCHAR2(10),
    po4                            VARCHAR2(10),
    po5                            VARCHAR2(10),
    po6                            NUMBER(10,2),
    po7                            DATE,
    po8                            NUMBER(15,2),
    po9                            NUMBER,
    po10                           VARCHAR2(1),
    ldkey                          NUMBER,
    vendeliverydate                DATE,
    receipts                       VARCHAR2(20),
    currencycode                   VARCHAR2(8) NOT NULL,
    exchangerate                   NUMBER(14,7),
    exchangedate                   DATE,
    buyahead                       VARCHAR2(1) NOT NULL,
    totaltax1                      NUMBER(10,2),
    totaltax2                      NUMBER(10,2),
    totaltax3                      NUMBER(10,2),
    inclusive1                     VARCHAR2(1) NOT NULL,
    inclusive2                     VARCHAR2(1) NOT NULL,
    inclusive3                     VARCHAR2(1) NOT NULL,
    internal                       VARCHAR2(1) NOT NULL,
    totaltax4                      NUMBER(10,2),
    totaltax5                      NUMBER(10,2),
    inclusive4                     VARCHAR2(1) NOT NULL,
    inclusive5                     VARCHAR2(1) NOT NULL,
    startdate                      DATE,
    enddate                        DATE,
    payonreceipt                   VARCHAR2(1) NOT NULL,
    wfid                           NUMBER,
    wfactive                       VARCHAR2(1) NOT NULL,
    buyercompany                   VARCHAR2(50),
    exchangerate2                  NUMBER(14,7),
    mnetsent                       VARCHAR2(18),
    ecomstatusdate                 DATE,
    sourcesysid                    VARCHAR2(10),
    ownersysid                     VARCHAR2(10),
    externalrefid                  VARCHAR2(10),
    apiseq                         VARCHAR2(50),
    interid                        VARCHAR2(50),
    migchangeid                    VARCHAR2(50),
    sendersysid                    VARCHAR2(50),
    expdone                        VARCHAR2(25),
    siteid                         VARCHAR2(8) NOT NULL,
    orgid                          VARCHAR2(8) NOT NULL,
    private                        VARCHAR2(1) NOT NULL)
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Indexes for PO

CREATE UNIQUE INDEX po_ndx1 ON po
  (
    orgid                           ASC,
    ponum                           ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/
CREATE INDEX po_ndx2 ON po
  (
    orgid                           ASC,
    vendor                          ASC,
    potype                          ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/
CREATE INDEX po_ndx3 ON po
  (
    orgid                           ASC,
    originalponum                   ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/
CREATE INDEX po_ndx4 ON po
  (
    orgid                           ASC,
    interid                         ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/
CREATE INDEX po_ndx5 ON po
  (
    orgid                           ASC,
    wfid                            ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/


-- Triggers for PO

CREATE TRIGGER po_t
BEFORE INSERT  OR UPDATE 
ON po
REFERENCING NEW AS NEW OLD AS OLD
FOR EACH ROW
DECLARE 
NEXTVAL INTEGER; BEGIN SELECT MAXSEQ.NEXTVAL INTO NEXTVAL FROM DUAL; 
:NEW.ROWSTAMP := NEXTVAL; END;
/

-- End of DDL Script for Table IFRMAXIMO.PO

-- Start of DDL Script for Table IFRMAXIMO.POCOST
-- Generated 9-mar-2004 20:20:08 from SYSMAN@MAQUINA4

CREATE TABLE pocost
    (rowstamp                       VARCHAR2(40) NOT NULL,
    pocostlineid                   NUMBER NOT NULL,
    ponum                          VARCHAR2(8) NOT NULL,
    polineid                       NUMBER NOT NULL,
    gldebitacct                    VARCHAR2(20),
    fincntrlid                     VARCHAR2(8),
    siteid                         VARCHAR2(8) NOT NULL,
    orgid                          VARCHAR2(8) NOT NULL,
    linecost                       NUMBER(10,2) NOT NULL,
    loadedcost                     NUMBER(10,2) NOT NULL,
    percentage                     NUMBER(5,2) NOT NULL,
    glcreditacct                   VARCHAR2(20))
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Indexes for POCOST

CREATE UNIQUE INDEX pocost_ndx1 ON pocost
  (
    orgid                           ASC,
    pocostlineid                    ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/


-- Triggers for POCOST

CREATE TRIGGER pocost_t
BEFORE INSERT  OR UPDATE 
ON pocost
REFERENCING NEW AS NEW OLD AS OLD
FOR EACH ROW
DECLARE 
NEXTVAL INTEGER; BEGIN SELECT MAXSEQ.NEXTVAL INTO NEXTVAL FROM DUAL; 
:NEW.ROWSTAMP := NEXTVAL; END;
/

-- End of DDL Script for Table IFRMAXIMO.POCOST

-- Start of DDL Script for Table IFRMAXIMO.POECOMSTATUS
-- Generated 9-mar-2004 20:20:15 from SYSMAN@MAQUINA4

CREATE TABLE poecomstatus
    (rowstamp                       VARCHAR2(40) NOT NULL,
    ponum                          VARCHAR2(8) NOT NULL,
    status                         VARCHAR2(18) NOT NULL,
    changedate                     DATE NOT NULL,
    memo                           VARCHAR2(254),
    siteid                         VARCHAR2(8) NOT NULL,
    orgid                          VARCHAR2(8) NOT NULL)
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Indexes for POECOMSTATUS

CREATE INDEX poecomstatus_ndx1 ON poecomstatus
  (
    orgid                           ASC,
    ponum                           ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/
CREATE INDEX poecomstatus_ndx2 ON poecomstatus
  (
    orgid                           ASC,
    changedate                      ASC,
    ponum                           ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/


-- Triggers for POECOMSTATUS

CREATE TRIGGER poecomstatus_t
BEFORE INSERT  OR UPDATE 
ON poecomstatus
REFERENCING NEW AS NEW OLD AS OLD
FOR EACH ROW
DECLARE 
NEXTVAL INTEGER; BEGIN SELECT MAXSEQ.NEXTVAL INTO NEXTVAL FROM DUAL; 
:NEW.ROWSTAMP := NEXTVAL; END;
/

-- End of DDL Script for Table IFRMAXIMO.POECOMSTATUS

-- Start of DDL Script for Table IFRMAXIMO.POINTWO
-- Generated 9-mar-2004 20:20:25 from SYSMAN@MAQUINA4

CREATE TABLE pointwo
    (rowstamp                       VARCHAR2(40) NOT NULL,
    wonum                          VARCHAR2(18) NOT NULL,
    pointnum                       VARCHAR2(16) NOT NULL,
    effectivedate                  DATE NOT NULL,
    description                    VARCHAR2(50),
    ldkey                          NUMBER,
    siteid                         VARCHAR2(8) NOT NULL,
    orgid                          VARCHAR2(8) NOT NULL)
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Indexes for POINTWO

CREATE UNIQUE INDEX pointwo_ndx1 ON pointwo
  (
    siteid                          ASC,
    wonum                           ASC,
    pointnum                        ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/
CREATE INDEX pointwo_ndx2 ON pointwo
  (
    siteid                          ASC,
    pointnum                        ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/


-- Triggers for POINTWO

CREATE TRIGGER pointwo_t
BEFORE INSERT  OR UPDATE 
ON pointwo
REFERENCING NEW AS NEW OLD AS OLD
FOR EACH ROW
DECLARE 
NEXTVAL INTEGER; BEGIN SELECT MAXSEQ.NEXTVAL INTO NEXTVAL FROM DUAL; 
:NEW.ROWSTAMP := NEXTVAL; END;
/

-- End of DDL Script for Table IFRMAXIMO.POINTWO

-- Start of DDL Script for Table IFRMAXIMO.POLINE
-- Generated 9-mar-2004 20:20:35 from SYSMAN@MAQUINA4

CREATE TABLE poline
    (rowstamp                       VARCHAR2(40) NOT NULL,
    ponum                          VARCHAR2(8) NOT NULL,
    itemnum                        VARCHAR2(30),
    storeloc                       VARCHAR2(18),
    modelnum                       VARCHAR2(8),
    catalogcode                    VARCHAR2(30),
    orderqty                       NUMBER(15,2),
    orderunit                      VARCHAR2(8),
    unitcost                       NUMBER(10,2),
    conversion                     NUMBER(15,2) NOT NULL,
    receivedqty                    NUMBER(15,2),
    receivedunitcost               NUMBER(10,2),
    receivedtotalcost              NUMBER(10,2) NOT NULL,
    rejectedqty                    NUMBER(15,2) NOT NULL,
    vendeliverydate                DATE,
    supervisor                     VARCHAR2(12),
    enterdate                      DATE NOT NULL,
    enterby                        VARCHAR2(18) NOT NULL,
    description                    VARCHAR2(120),
    pl1                            VARCHAR2(10),
    pl2                            VARCHAR2(10),
    pl3                            VARCHAR2(10),
    pl4                            NUMBER(15,2),
    pl5                            VARCHAR2(10),
    ldkey                          NUMBER,
    requestedby                    VARCHAR2(18),
    reqdeliverydate                DATE,
    issue                          VARCHAR2(1) NOT NULL,
    polinenum                      NUMBER NOT NULL,
    taxed                          VARCHAR2(1) NOT NULL,
    plin1                          NUMBER(10,2),
    plin2                          VARCHAR2(10),
    plin3                          VARCHAR2(10),
    plin4                          DATE,
    plin5                          NUMBER(15,2),
    eqnum                          VARCHAR2(12),
    chargestore                    VARCHAR2(1) NOT NULL,
    gldebitacct                    VARCHAR2(20),
    glcreditacct                   VARCHAR2(20),
    linecost                       NUMBER(10,2) NOT NULL,
    tax1code                       VARCHAR2(8),
    tax1                           NUMBER(10,2) NOT NULL,
    tax2code                       VARCHAR2(8),
    tax2                           NUMBER(10,2) NOT NULL,
    tax3code                       VARCHAR2(8),
    tax3                           NUMBER(10,2) NOT NULL,
    schargecode                    VARCHAR2(8),
    receiptreqd                    VARCHAR2(1) NOT NULL,
    manufacturer                   VARCHAR2(18),
    service                        VARCHAR2(1) NOT NULL,
    tax4code                       VARCHAR2(8),
    tax4                           NUMBER(10,2) NOT NULL,
    tax5code                       VARCHAR2(8),
    tax5                           NUMBER(10,2) NOT NULL,
    category                       VARCHAR2(4),
    remark                         VARCHAR2(50),
    location                       VARCHAR2(18),
    loadedcost                     NUMBER(10,2) NOT NULL,
    prorateservice                 VARCHAR2(1) NOT NULL,
    agreementponum                 VARCHAR2(8),
    agreementpotype                VARCHAR2(6),
    receiptscomplete               VARCHAR2(1) NOT NULL,
    inspectionrequired             VARCHAR2(1) NOT NULL,
    proratecost                    NUMBER(10,2),
    polineid                       NUMBER NOT NULL,
    linecost2                      NUMBER(10,2),
    mrnum                          VARCHAR2(8),
    mrlinenum                      NUMBER,
    pl6                            VARCHAR2(1),
    pl7                            VARCHAR2(1),
    pl8                            VARCHAR2(1),
    pl9                            VARCHAR2(1),
    pl10                           VARCHAR2(1),
    plin6                          VARCHAR2(1),
    plin7                          VARCHAR2(1),
    plin8                          VARCHAR2(1),
    plin9                          VARCHAR2(1),
    polaln1                        VARCHAR2(10),
    polaln2                        VARCHAR2(10),
    polaln3                        VARCHAR2(10),
    polaln4                        VARCHAR2(10),
    polaln5                        VARCHAR2(10),
    pcardnum                       VARCHAR2(30),
    pcardtype                      VARCHAR2(20),
    pcardexpdate                   VARCHAR2(7),
    fincntrlid                     VARCHAR2(8),
    pcardverification              VARCHAR2(4),
    mktplcitem                     VARCHAR2(1) NOT NULL,
    vendorpackcode                 VARCHAR2(12),
    vendorpackquantity             VARCHAR2(12),
    vendorwarehouse                VARCHAR2(12),
    siteid                         VARCHAR2(8) NOT NULL,
    orgid                          VARCHAR2(8) NOT NULL,
    isdistributed                  VARCHAR2(1) NOT NULL,
    refwo                          VARCHAR2(18),
    enteredastask                  VARCHAR2(1) NOT NULL)
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Indexes for POLINE

CREATE UNIQUE INDEX poline_ndx1 ON poline
  (
    orgid                           ASC,
    polineid                        ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/
CREATE INDEX poline_ndx2 ON poline
  (
    orgid                           ASC,
    ponum                           ASC,
    polinenum                       ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/
CREATE INDEX poline_ndx3 ON poline
  (
    orgid                           ASC,
    itemnum                         ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/
CREATE INDEX poline_ndx4 ON poline
  (
    orgid                           ASC,
    catalogcode                     ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/
CREATE INDEX poline_ndx5 ON poline
  (
    orgid                           ASC,
    itemnum                         ASC,
    catalogcode                     ASC,
    ponum                           ASC,
    polinenum                       ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/
CREATE INDEX poline_ndx6 ON poline
  (
    orderunit                       ASC,
    mrnum                           ASC,
    mrlinenum                       ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/


-- Triggers for POLINE

CREATE TRIGGER poline_t
BEFORE INSERT  OR UPDATE 
ON poline
REFERENCING NEW AS NEW OLD AS OLD
FOR EACH ROW
DECLARE NEXTVAL INTEGER; BEGIN SELECT MAXSEQ.NEXTVAL INTO NEXTVAL FROM DUAL; :NEW.ROWSTAMP := NEXTVAL; END;
/

-- End of DDL Script for Table IFRMAXIMO.POLINE

-- Start of DDL Script for Table IFRMAXIMO.POSTATUS
-- Generated 9-mar-2004 20:20:59 from SYSMAN@MAQUINA4

CREATE TABLE postatus
    (rowstamp                       VARCHAR2(40) NOT NULL,
    ponum                          VARCHAR2(8) NOT NULL,
    status                         VARCHAR2(10) NOT NULL,
    changedate                     DATE NOT NULL,
    changeby                       VARCHAR2(18) NOT NULL,
    memo                           VARCHAR2(100),
    siteid                         VARCHAR2(8) NOT NULL,
    orgid                          VARCHAR2(8) NOT NULL)
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Indexes for POSTATUS

CREATE INDEX postatus_ndx1 ON postatus
  (
    orgid                           ASC,
    ponum                           ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/
CREATE INDEX postatus_ndx2 ON postatus
  (
    orgid                           ASC,
    changedate                      ASC,
    ponum                           ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/


-- Triggers for POSTATUS

CREATE TRIGGER postatus_t
BEFORE INSERT  OR UPDATE 
ON postatus
REFERENCING NEW AS NEW OLD AS OLD
FOR EACH ROW
DECLARE 
NEXTVAL INTEGER; BEGIN SELECT MAXSEQ.NEXTVAL INTO NEXTVAL FROM DUAL; 
:NEW.ROWSTAMP := NEXTVAL; END;
/

-- End of DDL Script for Table IFRMAXIMO.POSTATUS

-- Start of DDL Script for Table IFRMAXIMO.PR
-- Generated 9-mar-2004 20:21:09 from SYSMAN@MAQUINA4

CREATE TABLE pr
    (rowstamp                       VARCHAR2(40) NOT NULL,
    prnum                          VARCHAR2(8) NOT NULL,
    issuedate                      DATE,
    requireddate                   DATE,
    requestedby                    VARCHAR2(18),
    vendor                         VARCHAR2(18),
    contact                        VARCHAR2(50),
    customernum                    VARCHAR2(16),
    fob                            VARCHAR2(20),
    freightterms                   VARCHAR2(50),
    shipvia                        VARCHAR2(20),
    paymentterms                   VARCHAR2(20),
    shipto                         VARCHAR2(50),
    shiptoattn                     VARCHAR2(12),
    billto                         VARCHAR2(50),
    billtoattn                     VARCHAR2(12),
    description                    VARCHAR2(50),
    status                         VARCHAR2(10) NOT NULL,
    statusdate                     DATE NOT NULL,
    changedate                     DATE NOT NULL,
    changeby                       VARCHAR2(18) NOT NULL,
    totalcost                      NUMBER(10,2) NOT NULL,
    priority                       NUMBER NOT NULL,
    historyflag                    VARCHAR2(1) NOT NULL,
    pr1                            VARCHAR2(10),
    pr2                            VARCHAR2(10),
    pr3                            VARCHAR2(10),
    pr4                            VARCHAR2(10),
    pr5                            VARCHAR2(10),
    pr6                            NUMBER(10,2),
    pr7                            DATE,
    pr8                            NUMBER(15,2),
    pr9                            NUMBER,
    pr10                           VARCHAR2(1),
    ldkey                          NUMBER,
    supervisor                     VARCHAR2(12),
    currencycode                   VARCHAR2(8) NOT NULL,
    exchangerate                   NUMBER(14,7),
    exchangedate                   DATE,
    buyahead                       VARCHAR2(1) NOT NULL,
    totaltax1                      NUMBER(10,2),
    totaltax2                      NUMBER(10,2),
    totaltax3                      NUMBER(10,2),
    inclusive1                     VARCHAR2(1) NOT NULL,
    inclusive2                     VARCHAR2(1) NOT NULL,
    inclusive3                     VARCHAR2(1) NOT NULL,
    internal                       VARCHAR2(1) NOT NULL,
    totaltax4                      NUMBER(10,2),
    totaltax5                      NUMBER(10,2),
    inclusive4                     VARCHAR2(1) NOT NULL,
    inclusive5                     VARCHAR2(1) NOT NULL,
    payonreceipt                   VARCHAR2(1) NOT NULL,
    wfid                           NUMBER,
    wfactive                       VARCHAR2(1) NOT NULL,
    exchangerate2                  NUMBER(14,7),
    sourcesysid                    VARCHAR2(10),
    ownersysid                     VARCHAR2(10),
    externalrefid                  VARCHAR2(10),
    prla1                          VARCHAR2(10),
    prla2                          VARCHAR2(10),
    prla3                          VARCHAR2(10),
    prla4                          VARCHAR2(10),
    prla5                          VARCHAR2(10),
    pcardnum                       VARCHAR2(30),
    pcardtype                      VARCHAR2(20),
    pcardexpdate                   VARCHAR2(7),
    apiseq                         VARCHAR2(50),
    interid                        VARCHAR2(50),
    migchangeid                    VARCHAR2(50),
    sendersysid                    VARCHAR2(50),
    expdone                        VARCHAR2(25),
    pcardverification              VARCHAR2(4),
    siteid                         VARCHAR2(8) NOT NULL,
    orgid                          VARCHAR2(8) NOT NULL)
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Indexes for PR

CREATE UNIQUE INDEX pr_ndx1 ON pr
  (
    siteid                          ASC,
    prnum                           ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/
CREATE INDEX pr_ndx2 ON pr
  (
    siteid                          ASC,
    vendor                          ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/
CREATE INDEX pr_ndx3 ON pr
  (
    siteid                          ASC,
    interid                         ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/
CREATE INDEX pr_ndx4 ON pr
  (
    siteid                          ASC,
    wfid                            ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/


-- Triggers for PR

CREATE TRIGGER pr_t
BEFORE INSERT  OR UPDATE 
ON pr
REFERENCING NEW AS NEW OLD AS OLD
FOR EACH ROW
DECLARE 
NEXTVAL INTEGER; BEGIN SELECT MAXSEQ.NEXTVAL INTO NEXTVAL FROM DUAL; 
:NEW.ROWSTAMP := NEXTVAL; END;
/

-- End of DDL Script for Table IFRMAXIMO.PR

-- Start of DDL Script for Table IFRMAXIMO.PRCOST
-- Generated 9-mar-2004 20:21:27 from SYSMAN@MAQUINA4

CREATE TABLE prcost
    (rowstamp                       VARCHAR2(40) NOT NULL,
    prcostlineid                   NUMBER NOT NULL,
    prnum                          VARCHAR2(8) NOT NULL,
    percentage                     NUMBER(5,2) NOT NULL,
    gldebitacct                    VARCHAR2(20),
    fincntrlid                     VARCHAR2(8),
    siteid                         VARCHAR2(8) NOT NULL,
    orgid                          VARCHAR2(8) NOT NULL,
    linecost                       NUMBER(10,2) NOT NULL,
    loadedcost                     NUMBER(10,2) NOT NULL,
    prlineid                       NUMBER NOT NULL,
    glcreditacct                   VARCHAR2(20))
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Indexes for PRCOST

CREATE UNIQUE INDEX prcost_ndx1 ON prcost
  (
    siteid                          ASC,
    prcostlineid                    ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/


-- Triggers for PRCOST

CREATE TRIGGER prcost_t
BEFORE INSERT  OR UPDATE 
ON prcost
REFERENCING NEW AS NEW OLD AS OLD
FOR EACH ROW
DECLARE 
NEXTVAL INTEGER; BEGIN SELECT MAXSEQ.NEXTVAL INTO NEXTVAL FROM DUAL; 
:NEW.ROWSTAMP := NEXTVAL; END;
/

-- End of DDL Script for Table IFRMAXIMO.PRCOST

-- Start of DDL Script for Table IFRMAXIMO.PRECAUTION
-- Generated 9-mar-2004 20:21:33 from SYSMAN@MAQUINA4

CREATE TABLE precaution
    (rowstamp                       VARCHAR2(40) NOT NULL,
    precautionid                   VARCHAR2(10) NOT NULL,
    description                    VARCHAR2(120),
    ldkey                          NUMBER,
    prec01                         VARCHAR2(10),
    prec02                         VARCHAR2(10),
    prec03                         VARCHAR2(10),
    prec04                         VARCHAR2(10),
    prec05                         VARCHAR2(10),
    prec06                         NUMBER(10,2),
    prec07                         DATE,
    prec08                         NUMBER(15,2),
    prec09                         VARCHAR2(10),
    prec10                         VARCHAR2(1),
    orgid                          VARCHAR2(8) NOT NULL,
    siteid                         VARCHAR2(8) NOT NULL)
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Indexes for PRECAUTION

CREATE UNIQUE INDEX precaution_ndx1 ON precaution
  (
    siteid                          ASC,
    precautionid                    ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/


-- Triggers for PRECAUTION

CREATE TRIGGER precaution_t
BEFORE INSERT  OR UPDATE 
ON precaution
REFERENCING NEW AS NEW OLD AS OLD
FOR EACH ROW
DECLARE NEXTVAL INTEGER; BEGIN SELECT MAXSEQ.NEXTVAL INTO NEXTVAL FROM DUAL; :NEW.ROWSTAMP := NEXTVAL; END;
/

-- End of DDL Script for Table IFRMAXIMO.PRECAUTION

-- Start of DDL Script for Table IFRMAXIMO.PRICALC
-- Generated 9-mar-2004 20:21:41 from SYSMAN@MAQUINA4

CREATE TABLE pricalc
    (rowstamp                       VARCHAR2(40) NOT NULL,
    findex                         NUMBER NOT NULL,
    formula                        VARCHAR2(254) NOT NULL,
    selected                       VARCHAR2(1) NOT NULL,
    orgid                          VARCHAR2(8) NOT NULL,
    siteid                         VARCHAR2(8) NOT NULL)
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Indexes for PRICALC

CREATE UNIQUE INDEX pricalc_ndx1 ON pricalc
  (
    siteid                          ASC,
    findex                          ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/


-- Triggers for PRICALC

CREATE TRIGGER pricalc_t
BEFORE INSERT  OR UPDATE 
ON pricalc
REFERENCING NEW AS NEW OLD AS OLD
FOR EACH ROW
DECLARE 
NEXTVAL INTEGER; BEGIN SELECT MAXSEQ.NEXTVAL INTO NEXTVAL FROM DUAL; 
:NEW.ROWSTAMP := NEXTVAL; END;
/

-- End of DDL Script for Table IFRMAXIMO.PRICALC

-- Start of DDL Script for Table IFRMAXIMO.PRINTER
-- Generated 9-mar-2004 20:21:46 from SYSMAN@MAQUINA4

CREATE TABLE printer
    (rowstamp                       VARCHAR2(40) NOT NULL,
    tbname                         VARCHAR2(18),
    colname                        VARCHAR2(18),
    value                          VARCHAR2(50) NOT NULL,
    port                           VARCHAR2(50) NOT NULL,
    device                         VARCHAR2(50) NOT NULL,
    driver                         VARCHAR2(50) NOT NULL)
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Indexes for PRINTER

CREATE UNIQUE INDEX printer_ndx1 ON printer
  (
    tbname                          ASC,
    colname                         ASC,
    value                           ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/


-- Triggers for PRINTER

CREATE TRIGGER printer_t
BEFORE INSERT  OR UPDATE 
ON printer
REFERENCING NEW AS NEW OLD AS OLD
FOR EACH ROW
DECLARE 
NEXTVAL INTEGER; BEGIN SELECT MAXSEQ.NEXTVAL INTO NEXTVAL FROM DUAL; 
:NEW.ROWSTAMP := NEXTVAL; END;
/

-- End of DDL Script for Table IFRMAXIMO.PRINTER

-- Start of DDL Script for Table IFRMAXIMO.PRLINE
-- Generated 9-mar-2004 20:21:51 from SYSMAN@MAQUINA4

CREATE TABLE prline
    (rowstamp                       VARCHAR2(40) NOT NULL,
    prnum                          VARCHAR2(8) NOT NULL,
    itemnum                        VARCHAR2(30),
    storeloc                       VARCHAR2(18),
    orderqty                       NUMBER(15,2),
    orderunit                      VARCHAR2(8),
    unitcost                       NUMBER(10,2),
    conversion                     NUMBER(15,2) NOT NULL,
    ponum                          VARCHAR2(8),
    reqdeliverydate                DATE,
    vendeliverydate                DATE,
    enterdate                      DATE NOT NULL,
    enterby                        VARCHAR2(18) NOT NULL,
    description                    VARCHAR2(120),
    rl1                            VARCHAR2(10),
    rl2                            VARCHAR2(10),
    rl3                            VARCHAR2(10),
    rl4                            NUMBER(15,2),
    rl5                            VARCHAR2(10),
    ldkey                          NUMBER,
    requestedby                    VARCHAR2(18),
    issue                          VARCHAR2(1) NOT NULL,
    rlin1                          NUMBER(10,2),
    rlin2                          VARCHAR2(10),
    rlin3                          VARCHAR2(10),
    rlin4                          DATE,
    rlin5                          NUMBER(15,2),
    eqnum                          VARCHAR2(12),
    chargestore                    VARCHAR2(1) NOT NULL,
    gldebitacct                    VARCHAR2(20),
    glcreditacct                   VARCHAR2(20),
    linecost                       NUMBER(10,2) NOT NULL,
    tax1code                       VARCHAR2(8),
    tax1                           NUMBER(10,2) NOT NULL,
    tax2code                       VARCHAR2(8),
    tax2                           NUMBER(10,2) NOT NULL,
    tax3code                       VARCHAR2(8),
    tax3                           NUMBER(10,2) NOT NULL,
    schargecode                    VARCHAR2(8),
    receiptreqd                    VARCHAR2(1) NOT NULL,
    manufacturer                   VARCHAR2(18),
    modelnum                       VARCHAR2(8),
    catalogcode                    VARCHAR2(30),
    tax4code                       VARCHAR2(8),
    tax4                           NUMBER(10,2) NOT NULL,
    tax5code                       VARCHAR2(8),
    tax5                           NUMBER(10,2) NOT NULL,
    prlinenum                      NUMBER NOT NULL,
    polinenum                      NUMBER,
    category                       VARCHAR2(4),
    remark                         VARCHAR2(50),
    service                        VARCHAR2(1) NOT NULL,
    location                       VARCHAR2(18),
    loadedcost                     NUMBER(10,2) NOT NULL,
    prorateservice                 VARCHAR2(1) NOT NULL,
    agreementponum                 VARCHAR2(8),
    agreementpotype                VARCHAR2(6),
    converttorfq                   VARCHAR2(1) NOT NULL,
    rfqnum                         VARCHAR2(8),
    rfqlinenum                     NUMBER,
    inspectionrequired             VARCHAR2(1) NOT NULL,
    rfqlineid                      NUMBER,
    polineid                       NUMBER,
    linecost2                      NUMBER(10,2),
    mrnum                          VARCHAR2(8),
    mrlinenum                      NUMBER,
    rl6                            VARCHAR2(1),
    rl7                            VARCHAR2(1),
    rl8                            VARCHAR2(1),
    rl9                            VARCHAR2(1),
    rl10                           VARCHAR2(1),
    rlin6                          VARCHAR2(1),
    rlin7                          VARCHAR2(1),
    rlin8                          VARCHAR2(1),
    rlin9                          VARCHAR2(1),
    prlaln1                        VARCHAR2(10),
    prlaln2                        VARCHAR2(10),
    prlaln3                        VARCHAR2(10),
    prlaln4                        VARCHAR2(10),
    prlaln5                        VARCHAR2(10),
    pcardnum                       VARCHAR2(30),
    pcardtype                      VARCHAR2(20),
    pcardexpdate                   VARCHAR2(7),
    fincntrlid                     VARCHAR2(8),
    pcardverification              VARCHAR2(4),
    mktplcitem                     VARCHAR2(1) NOT NULL,
    vendorpackcode                 VARCHAR2(12),
    vendorpackquantity             VARCHAR2(12),
    vendorwarehouse                VARCHAR2(12),
    siteid                         VARCHAR2(8) NOT NULL,
    orgid                          VARCHAR2(8) NOT NULL,
    prlineid                       NUMBER NOT NULL,
    isdistributed                  VARCHAR2(1) NOT NULL,
    refwo                          VARCHAR2(18),
    enteredastask                  VARCHAR2(1) NOT NULL)
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Indexes for PRLINE

CREATE UNIQUE INDEX prline_ndx1 ON prline
  (
    siteid                          ASC,
    prlineid                        ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/
CREATE INDEX prline_ndx2 ON prline
  (
    siteid                          ASC,
    polineid                        ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/
CREATE INDEX prline_ndx3 ON prline
  (
    siteid                          ASC,
    ponum                           ASC,
    polinenum                       ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/
CREATE INDEX prline_ndx4 ON prline
  (
    siteid                          ASC,
    mrnum                           ASC,
    mrlinenum                       ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/
CREATE INDEX prline_ndx5 ON prline
  (
    siteid                          ASC,
    itemnum                         ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/
CREATE INDEX prline_ndx6 ON prline
  (
    siteid                          ASC,
    rfqlineid                       ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/
CREATE INDEX prline_ndx7 ON prline
  (
    siteid                          ASC,
    rfqnum                          ASC,
    rfqlinenum                      ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/
CREATE INDEX prline_ndx8 ON prline
  (
    siteid                          ASC,
    prnum                           ASC,
    prlinenum                       ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/


-- Triggers for PRLINE

CREATE TRIGGER prline_t
BEFORE INSERT  OR UPDATE 
ON prline
REFERENCING NEW AS NEW OLD AS OLD
FOR EACH ROW
DECLARE NEXTVAL INTEGER; BEGIN SELECT MAXSEQ.NEXTVAL INTO NEXTVAL FROM DUAL; :NEW.ROWSTAMP := NEXTVAL; END;
/

-- End of DDL Script for Table IFRMAXIMO.PRLINE

-- Start of DDL Script for Table IFRMAXIMO.PRSTATUS
-- Generated 9-mar-2004 20:22:25 from SYSMAN@MAQUINA4

CREATE TABLE prstatus
    (rowstamp                       VARCHAR2(40) NOT NULL,
    prnum                          VARCHAR2(8) NOT NULL,
    changedate                     DATE NOT NULL,
    status                         VARCHAR2(10) NOT NULL,
    changeby                       VARCHAR2(18) NOT NULL,
    memo                           VARCHAR2(100),
    siteid                         VARCHAR2(8) NOT NULL,
    orgid                          VARCHAR2(8) NOT NULL)
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Indexes for PRSTATUS

CREATE INDEX prstatus_ndx1 ON prstatus
  (
    siteid                          ASC,
    prnum                           ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/
CREATE INDEX prstatus_ndx2 ON prstatus
  (
    siteid                          ASC,
    changedate                      ASC,
    prnum                           ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/


-- Triggers for PRSTATUS

CREATE TRIGGER prstatus_t
BEFORE INSERT  OR UPDATE 
ON prstatus
REFERENCING NEW AS NEW OLD AS OLD
FOR EACH ROW
DECLARE 
NEXTVAL INTEGER; BEGIN SELECT MAXSEQ.NEXTVAL INTO NEXTVAL FROM DUAL; 
:NEW.ROWSTAMP := NEXTVAL; END;
/

-- End of DDL Script for Table IFRMAXIMO.PRSTATUS

-- Start of DDL Script for Table IFRMAXIMO.QUERY
-- Generated 9-mar-2004 20:22:35 from SYSMAN@MAQUINA4

CREATE TABLE query
    (rowstamp                       VARCHAR2(40) NOT NULL,
    app                            VARCHAR2(10) NOT NULL,
    clausename                     VARCHAR2(15) NOT NULL,
    owner                          VARCHAR2(18) NOT NULL,
    description                    VARCHAR2(150),
    clause                         VARCHAR2(254) NOT NULL,
    siteid                         VARCHAR2(8) NOT NULL,
    orgid                          VARCHAR2(8) NOT NULL,
    ispublic                       VARCHAR2(1) NOT NULL)
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Indexes for QUERY

CREATE UNIQUE INDEX query_ndx1 ON query
  (
    siteid                          ASC,
    app                             ASC,
    clausename                      ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/
CREATE INDEX query_ndx2 ON query
  (
    siteid                          ASC,
    app                             ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/


-- Triggers for QUERY

CREATE TRIGGER query_t
BEFORE INSERT  OR UPDATE 
ON query
REFERENCING NEW AS NEW OLD AS OLD
FOR EACH ROW
DECLARE 
NEXTVAL INTEGER; BEGIN SELECT MAXSEQ.NEXTVAL INTO NEXTVAL FROM DUAL; 
:NEW.ROWSTAMP := NEXTVAL; END;
/

-- End of DDL Script for Table IFRMAXIMO.QUERY

-- Start of DDL Script for Table IFRMAXIMO.QUOTATIONLINE
-- Generated 9-mar-2004 20:22:43 from SYSMAN@MAQUINA4

CREATE TABLE quotationline
    (rowstamp                       VARCHAR2(40) NOT NULL,
    rfqnum                         VARCHAR2(8) NOT NULL,
    rfqlinenum                     NUMBER NOT NULL,
    vendor                         VARCHAR2(18) NOT NULL,
    quotationlineid                NUMBER NOT NULL,
    itemnum                        VARCHAR2(30),
    manufacturer                   VARCHAR2(18),
    modelnum                       VARCHAR2(8),
    orderqty                       NUMBER(15,2),
    orderunit                      VARCHAR2(8),
    unitcost                       NUMBER(10,2),
    conversion                     NUMBER(15,2) NOT NULL,
    linecost                       NUMBER(10,2),
    eoq                            NUMBER(15,2) NOT NULL,
    deliverytime                   NUMBER,
    deliverydate                   DATE,
    enterdate                      DATE NOT NULL,
    enterby                        VARCHAR2(18) NOT NULL,
    ql1                            VARCHAR2(10),
    ql2                            VARCHAR2(10),
    ql3                            VARCHAR2(10),
    ql4                            NUMBER(15,2),
    ql5                            VARCHAR2(10),
    isawarded                      VARCHAR2(1) NOT NULL,
    selectedfordisplay             VARCHAR2(1) NOT NULL,
    glcreditacct                   VARCHAR2(20),
    tax1code                       VARCHAR2(8),
    tax1                           NUMBER(10,2) NOT NULL,
    tax2code                       VARCHAR2(8),
    tax2                           NUMBER(10,2) NOT NULL,
    tax3code                       VARCHAR2(8),
    tax3                           NUMBER(10,2) NOT NULL,
    tax4code                       VARCHAR2(8),
    tax4                           NUMBER(10,2) NOT NULL,
    tax5code                       VARCHAR2(8),
    tax5                           NUMBER(10,2) NOT NULL,
    service                        VARCHAR2(1) NOT NULL,
    catalogcode                    VARCHAR2(30),
    memo                           VARCHAR2(30),
    schargecode                    VARCHAR2(8),
    description                    VARCHAR2(120),
    quotestartdate                 DATE,
    quoteenddate                   DATE,
    ldkey                          NUMBER,
    linecost2                      NUMBER(10,2),
    mktplcitem                     VARCHAR2(1) NOT NULL,
    vendorpackcode                 VARCHAR2(12),
    vendorpackquantity             VARCHAR2(12),
    vendorwarehouse                VARCHAR2(12),
    siteid                         VARCHAR2(8) NOT NULL,
    orgid                          VARCHAR2(8) NOT NULL)
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Indexes for QUOTATIONLINE

CREATE UNIQUE INDEX quotationline_ndx1 ON quotationline
  (
    siteid                          ASC,
    rfqnum                          ASC,
    rfqlinenum                      ASC,
    vendor                          ASC,
    quotationlineid                 ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/


-- Triggers for QUOTATIONLINE

CREATE TRIGGER quotationline_t
BEFORE INSERT  OR UPDATE 
ON quotationline
REFERENCING NEW AS NEW OLD AS OLD
FOR EACH ROW
DECLARE 
NEXTVAL INTEGER; BEGIN SELECT MAXSEQ.NEXTVAL INTO NEXTVAL FROM DUAL; 
:NEW.ROWSTAMP := NEXTVAL; END;
/

-- End of DDL Script for Table IFRMAXIMO.QUOTATIONLINE

-- Start of DDL Script for Table IFRMAXIMO.RANGEDOMSEGMENT
-- Generated 9-mar-2004 20:22:50 from SYSMAN@MAQUINA4

CREATE TABLE rangedomsegment
    (rowstamp                       VARCHAR2(40) NOT NULL,
    domainid                       VARCHAR2(18) NOT NULL,
    rangesegment                   NUMBER NOT NULL,
    rangeminimum                   FLOAT(126),
    rangemaximum                   FLOAT(126),
    rangeinterval                  FLOAT(126))
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Indexes for RANGEDOMSEGMENT

CREATE UNIQUE INDEX rangedomseg_ndx1 ON rangedomsegment
  (
    domainid                        ASC,
    rangesegment                    ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/


-- Triggers for RANGEDOMSEGMENT

CREATE TRIGGER rangedomsegment_t
BEFORE INSERT  OR UPDATE 
ON rangedomsegment
REFERENCING NEW AS NEW OLD AS OLD
FOR EACH ROW
DECLARE 
NEXTVAL INTEGER; BEGIN SELECT MAXSEQ.NEXTVAL INTO NEXTVAL FROM DUAL; 
:NEW.ROWSTAMP := NEXTVAL; END;
/

-- End of DDL Script for Table IFRMAXIMO.RANGEDOMSEGMENT

-- Start of DDL Script for Table IFRMAXIMO.REORDERMUTEX
-- Generated 9-mar-2004 20:22:56 from SYSMAN@MAQUINA4

CREATE TABLE reordermutex
    (rowstamp                       VARCHAR2(40) NOT NULL,
    type                           VARCHAR2(20) NOT NULL,
    location                       VARCHAR2(18),
    status                         VARCHAR2(10),
    insertdate                     DATE,
    mrnum                          VARCHAR2(8),
    orgid                          VARCHAR2(8) NOT NULL,
    siteid                         VARCHAR2(8) NOT NULL)
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Indexes for REORDERMUTEX

CREATE UNIQUE INDEX reordermutex_ndx1 ON reordermutex
  (
    siteid                          ASC,
    location                        ASC,
    mrnum                           ASC,
    type                            ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/


-- Triggers for REORDERMUTEX

CREATE TRIGGER reordermutex_t
BEFORE INSERT  OR UPDATE 
ON reordermutex
REFERENCING NEW AS NEW OLD AS OLD
FOR EACH ROW
DECLARE 
NEXTVAL INTEGER; BEGIN SELECT MAXSEQ.NEXTVAL INTO NEXTVAL FROM DUAL; 
:NEW.ROWSTAMP := NEXTVAL; END;
/

-- End of DDL Script for Table IFRMAXIMO.REORDERMUTEX

-- Start of DDL Script for Table IFRMAXIMO.REORDERPAD
-- Generated 9-mar-2004 20:23:04 from SYSMAN@MAQUINA4

CREATE TABLE reorderpad
    (rowstamp                       VARCHAR2(40) NOT NULL,
    usrname                        VARCHAR2(18) NOT NULL,
    prnum                          VARCHAR2(8),
    ponum                          VARCHAR2(8),
    itemnum                        VARCHAR2(30),
    location                       VARCHAR2(18),
    vendor                         VARCHAR2(18),
    minlevel                       NUMBER(15,2),
    maxlevel                       NUMBER(15,2),
    category                       VARCHAR2(4),
    orderqty                       NUMBER(15,2),
    orderunit                      VARCHAR2(8),
    unitcost                       NUMBER(17,2),
    conversion                     NUMBER(15,2),
    in19                           NUMBER(10,2),
    in20                           VARCHAR2(10),
    in21                           VARCHAR2(10),
    in22                           DATE,
    in23                           NUMBER(15,2),
    curbal                         NUMBER(15,2),
    wonum                          VARCHAR2(18),
    requiredate                    DATE,
    requestby                      VARCHAR2(18),
    schedstart                     DATE,
    targstartdate                  DATE,
    glaccount                      VARCHAR2(20),
    glcreditacct                   VARCHAR2(20),
    deliverytime                   NUMBER,
    lottype                        VARCHAR2(10),
    manufacturer                   VARCHAR2(18),
    modelnum                       VARCHAR2(8),
    catalogcode                    VARCHAR2(30),
    gldebitacct                    VARCHAR2(20),
    eqnum                          VARCHAR2(12),
    eqlocation                     VARCHAR2(18),
    reservedqty                    NUMBER(15,2),
    prqty                          NUMBER(15,2),
    poqty                          NUMBER(15,2),
    mrnum                          VARCHAR2(8),
    mrlinenum                      NUMBER,
    service                        VARCHAR2(1) NOT NULL,
    schargecode                    VARCHAR2(8),
    explotqty                      NUMBER(15,2),
    reorderqty                     NUMBER(15,2),
    description                    VARCHAR2(120),
    agreementponum                 VARCHAR2(8),
    agreementpotype                VARCHAR2(6),
    orgid                          VARCHAR2(8) NOT NULL,
    siteid                         VARCHAR2(8) NOT NULL,
    shipto                         VARCHAR2(50),
    vendorpackcode                 VARCHAR2(12),
    vendorwarehouse                VARCHAR2(12),
    vendorpackquantity             VARCHAR2(12),
    mktplcitem                     VARCHAR2(1) NOT NULL,
    agreementpolinenum             NUMBER,
    currencycode                   VARCHAR2(8))
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Indexes for REORDERPAD

CREATE INDEX reorderpad_ndx1 ON reorderpad
  (
    siteid                          ASC,
    usrname                         ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/


-- Triggers for REORDERPAD

CREATE TRIGGER reorderpad_t
BEFORE INSERT  OR UPDATE 
ON reorderpad
REFERENCING NEW AS NEW OLD AS OLD
FOR EACH ROW
DECLARE NEXTVAL INTEGER; BEGIN SELECT MAXSEQ.NEXTVAL INTO NEXTVAL FROM DUAL; :NEW.ROWSTAMP := NEXTVAL; END;
/

-- End of DDL Script for Table IFRMAXIMO.REORDERPAD

-- Start of DDL Script for Table IFRMAXIMO.RFQ
-- Generated 9-mar-2004 20:23:10 from SYSMAN@MAQUINA4

CREATE TABLE rfq
    (rowstamp                       VARCHAR2(40) NOT NULL,
    rfqnum                         VARCHAR2(8) NOT NULL,
    description                    VARCHAR2(50),
    status                         VARCHAR2(10) NOT NULL,
    statusdate                     DATE NOT NULL,
    enterdate                      DATE,
    enterby                        VARCHAR2(18),
    replydate                      DATE,
    closeondate                    DATE,
    purchaseagent                  VARCHAR2(12),
    rfqtype                        VARCHAR2(16),
    requireddate                   DATE,
    requestedby                    VARCHAR2(18),
    shipto                         VARCHAR2(50),
    shiptoattn                     VARCHAR2(12),
    billto                         VARCHAR2(50),
    billtoattn                     VARCHAR2(12),
    replyto                        VARCHAR2(50),
    replytoattn                    VARCHAR2(12),
    fob                            VARCHAR2(20),
    freightterms                   VARCHAR2(50),
    shipvia                        VARCHAR2(20),
    paymentterms                   VARCHAR2(20),
    changeby                       VARCHAR2(18) NOT NULL,
    changedate                     DATE NOT NULL,
    priority                       NUMBER NOT NULL,
    historyflag                    VARCHAR2(1) NOT NULL,
    rfq1                           VARCHAR2(10),
    rfq2                           VARCHAR2(10),
    rfq3                           VARCHAR2(10),
    rfq4                           VARCHAR2(10),
    rfq5                           VARCHAR2(10),
    rfq6                           NUMBER(10,2),
    rfq7                           DATE,
    rfq8                           NUMBER(15,2),
    rfq9                           NUMBER,
    rfq10                          VARCHAR2(1),
    ldkey                          NUMBER,
    printdate                      DATE,
    buyercompany                   VARCHAR2(50),
    orgid                          VARCHAR2(8) NOT NULL,
    siteid                         VARCHAR2(8) NOT NULL,
    wfid                           NUMBER,
    wfactive                       VARCHAR2(1) NOT NULL)
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Indexes for RFQ

CREATE UNIQUE INDEX rfq_ndx1 ON rfq
  (
    siteid                          ASC,
    rfqnum                          ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/


-- Triggers for RFQ

CREATE TRIGGER rfq_t
BEFORE INSERT  OR UPDATE 
ON rfq
REFERENCING NEW AS NEW OLD AS OLD
FOR EACH ROW
DECLARE 
NEXTVAL INTEGER; BEGIN SELECT MAXSEQ.NEXTVAL INTO NEXTVAL FROM DUAL; 
:NEW.ROWSTAMP := NEXTVAL; END;
/

-- End of DDL Script for Table IFRMAXIMO.RFQ

-- Start of DDL Script for Table IFRMAXIMO.RFQLINE
-- Generated 9-mar-2004 20:23:17 from SYSMAN@MAQUINA4

CREATE TABLE rfqline
    (rowstamp                       VARCHAR2(40) NOT NULL,
    rfqnum                         VARCHAR2(8) NOT NULL,
    rfqlinenum                     NUMBER NOT NULL,
    itemnum                        VARCHAR2(30),
    storeloc                       VARCHAR2(18),
    description                    VARCHAR2(120),
    orderqty                       NUMBER(15,2),
    orderunit                      VARCHAR2(8),
    conversion                     NUMBER(15,2) NOT NULL,
    reqdeliverydate                DATE,
    enterdate                      DATE NOT NULL,
    enterby                        VARCHAR2(18) NOT NULL,
    rfql1                          VARCHAR2(10),
    rfql2                          VARCHAR2(10),
    rfql3                          VARCHAR2(10),
    rfql4                          NUMBER(15,2),
    rfql5                          VARCHAR2(10),
    ponum                          VARCHAR2(8),
    polinenum                      NUMBER,
    eqnum                          VARCHAR2(12),
    requestedby                    VARCHAR2(18),
    issue                          VARCHAR2(1) NOT NULL,
    rfqlin1                        NUMBER(10,2),
    rfqlin2                        VARCHAR2(10),
    rfqlin3                        VARCHAR2(10),
    rfqlin4                        DATE,
    rfqlin5                        NUMBER(15,2),
    chargestore                    VARCHAR2(1) NOT NULL,
    gldebitacct                    VARCHAR2(20),
    schargecode                    VARCHAR2(8),
    receiptreqd                    VARCHAR2(1) NOT NULL,
    category                       VARCHAR2(4),
    remark                         VARCHAR2(50),
    service                        VARCHAR2(1) NOT NULL,
    location                       VARCHAR2(18),
    manufacturer                   VARCHAR2(18),
    modelnum                       VARCHAR2(8),
    awarddate                      DATE,
    vendor                         VARCHAR2(18),
    supervisor                     VARCHAR2(12),
    ldkey                          NUMBER,
    prorateservice                 VARCHAR2(1) NOT NULL,
    unitcost                       NUMBER(10,2),
    linecost                       NUMBER(10,2),
    rfqlineid                      NUMBER NOT NULL,
    inspectionrequired             VARCHAR2(1) NOT NULL,
    polineid                       NUMBER,
    mrnum                          VARCHAR2(8),
    mrlinenum                      NUMBER,
    rfql6                          VARCHAR2(1),
    rfql7                          VARCHAR2(1),
    rfql8                          VARCHAR2(1),
    rfql9                          VARCHAR2(1),
    rfql10                         VARCHAR2(1),
    rfqlin6                        VARCHAR2(1),
    rfqlin7                        VARCHAR2(1),
    rfqlin8                        VARCHAR2(1),
    rfqlin9                        VARCHAR2(1),
    fincntrlid                     VARCHAR2(8),
    mktplcitem                     VARCHAR2(1) NOT NULL,
    vendorpackcode                 VARCHAR2(12),
    vendorpackquantity             VARCHAR2(12),
    vendorwarehouse                VARCHAR2(12),
    orgid                          VARCHAR2(8) NOT NULL,
    siteid                         VARCHAR2(8) NOT NULL,
    refwo                          VARCHAR2(18),
    enteredastask                  VARCHAR2(1) NOT NULL)
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Indexes for RFQLINE

CREATE UNIQUE INDEX rfqline_ndx1 ON rfqline
  (
    siteid                          ASC,
    rfqlineid                       ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/
CREATE INDEX rfqline_ndx2 ON rfqline
  (
    siteid                          ASC,
    rfqnum                          ASC,
    rfqlinenum                      ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/
CREATE INDEX rfqline_ndx3 ON rfqline
  (
    siteid                          ASC,
    polineid                        ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/
CREATE INDEX rfqline_ndx4 ON rfqline
  (
    siteid                          ASC,
    ponum                           ASC,
    polinenum                       ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/


-- Triggers for RFQLINE

CREATE TRIGGER rfqline_t
BEFORE INSERT  OR UPDATE 
ON rfqline
REFERENCING NEW AS NEW OLD AS OLD
FOR EACH ROW
DECLARE NEXTVAL INTEGER; BEGIN SELECT MAXSEQ.NEXTVAL INTO NEXTVAL FROM DUAL; :NEW.ROWSTAMP := NEXTVAL; END;
/

-- End of DDL Script for Table IFRMAXIMO.RFQLINE

-- Start of DDL Script for Table IFRMAXIMO.RFQSTATUS
-- Generated 9-mar-2004 20:23:34 from SYSMAN@MAQUINA4

CREATE TABLE rfqstatus
    (rowstamp                       VARCHAR2(40) NOT NULL,
    rfqnum                         VARCHAR2(8) NOT NULL,
    rfqstatusseq                   NUMBER NOT NULL,
    status                         VARCHAR2(10) NOT NULL,
    changedate                     DATE NOT NULL,
    changeby                       VARCHAR2(18) NOT NULL,
    memo                           VARCHAR2(100),
    orgid                          VARCHAR2(8) NOT NULL,
    siteid                         VARCHAR2(8) NOT NULL)
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Indexes for RFQSTATUS

CREATE UNIQUE INDEX rfqstatus_ndx1 ON rfqstatus
  (
    siteid                          ASC,
    rfqnum                          ASC,
    rfqstatusseq                    ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/


-- Triggers for RFQSTATUS

CREATE TRIGGER rfqstatus_t
BEFORE INSERT  OR UPDATE 
ON rfqstatus
REFERENCING NEW AS NEW OLD AS OLD
FOR EACH ROW
DECLARE 
NEXTVAL INTEGER; BEGIN SELECT MAXSEQ.NEXTVAL INTO NEXTVAL FROM DUAL; 
:NEW.ROWSTAMP := NEXTVAL; END;
/

-- End of DDL Script for Table IFRMAXIMO.RFQSTATUS

-- Start of DDL Script for Table IFRMAXIMO.RFQVENDOR
-- Generated 9-mar-2004 20:23:40 from SYSMAN@MAQUINA4

CREATE TABLE rfqvendor
    (rowstamp                       VARCHAR2(40) NOT NULL,
    rfqnum                         VARCHAR2(8) NOT NULL,
    vendor                         VARCHAR2(18) NOT NULL,
    contact                        VARCHAR2(50),
    phone                          VARCHAR2(20),
    faxphone                       VARCHAR2(20),
    email                          VARCHAR2(60),
    customernum                    VARCHAR2(16),
    fob                            VARCHAR2(20),
    freightterms                   VARCHAR2(50),
    shipvia                        VARCHAR2(20),
    paymentterms                   VARCHAR2(20),
    currencycode                   VARCHAR2(8) NOT NULL,
    exchangerate                   NUMBER(14,7),
    exchangedate                   DATE,
    buyahead                       VARCHAR2(1) NOT NULL,
    internal                       VARCHAR2(1) NOT NULL,
    replieddate                    DATE,
    glcreditacct                   VARCHAR2(20),
    rfqv1                          VARCHAR2(10),
    rfqv2                          VARCHAR2(4),
    rfqv3                          VARCHAR2(10),
    rfqv4                          VARCHAR2(12),
    rfqv5                          VARCHAR2(10),
    inclusive1                     VARCHAR2(1) NOT NULL,
    inclusive2                     VARCHAR2(1) NOT NULL,
    inclusive3                     VARCHAR2(1) NOT NULL,
    inclusive4                     VARCHAR2(1) NOT NULL,
    inclusive5                     VARCHAR2(1) NOT NULL,
    vendorquotenum                 VARCHAR2(15),
    ldkey                          NUMBER,
    orgid                          VARCHAR2(8) NOT NULL,
    siteid                         VARCHAR2(8) NOT NULL)
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Indexes for RFQVENDOR

CREATE UNIQUE INDEX rfqvendor_ndx1 ON rfqvendor
  (
    siteid                          ASC,
    rfqnum                          ASC,
    vendor                          ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/


-- Triggers for RFQVENDOR

CREATE TRIGGER rfqvendor_t
BEFORE INSERT  OR UPDATE 
ON rfqvendor
REFERENCING NEW AS NEW OLD AS OLD
FOR EACH ROW
DECLARE 
NEXTVAL INTEGER; BEGIN SELECT MAXSEQ.NEXTVAL INTO NEXTVAL FROM DUAL; 
:NEW.ROWSTAMP := NEXTVAL; END;
/

-- End of DDL Script for Table IFRMAXIMO.RFQVENDOR

-- Start of DDL Script for Table IFRMAXIMO.ROUTE_STOP
-- Generated 9-mar-2004 20:23:45 from SYSMAN@MAQUINA4

CREATE TABLE route_stop
    (rowstamp                       VARCHAR2(40) NOT NULL,
    route                          VARCHAR2(16) NOT NULL,
    eqnum                          VARCHAR2(12),
    location                       VARCHAR2(18),
    jpnum                          VARCHAR2(30),
    stopsequence                   NUMBER,
    routestopid                    NUMBER NOT NULL,
    rts1                           VARCHAR2(10),
    rts2                           VARCHAR2(10),
    rts3                           VARCHAR2(10),
    rts4                           DATE,
    rts5                           NUMBER(15,2),
    orgid                          VARCHAR2(8) NOT NULL,
    siteid                         VARCHAR2(8) NOT NULL,
    description                    VARCHAR2(150))
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Indexes for ROUTE_STOP

CREATE UNIQUE INDEX route_stop_ndx1 ON route_stop
  (
    siteid                          ASC,
    route                           ASC,
    routestopid                     ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/
CREATE INDEX route_stop_ndx2 ON route_stop
  (
    siteid                          ASC,
    route                           ASC,
    stopsequence                    ASC,
    eqnum                           ASC,
    location                        ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/
CREATE INDEX route_stop_ndx3 ON route_stop
  (
    siteid                          ASC,
    eqnum                           ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/
CREATE INDEX route_stop_ndx4 ON route_stop
  (
    siteid                          ASC,
    location                        ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/


-- Triggers for ROUTE_STOP

CREATE TRIGGER route_stop_t
BEFORE INSERT  OR UPDATE 
ON route_stop
REFERENCING NEW AS NEW OLD AS OLD
FOR EACH ROW
DECLARE 
NEXTVAL INTEGER; BEGIN SELECT MAXSEQ.NEXTVAL INTO NEXTVAL FROM DUAL; 
:NEW.ROWSTAMP := NEXTVAL; END;
/

-- End of DDL Script for Table IFRMAXIMO.ROUTE_STOP

-- Start of DDL Script for Table IFRMAXIMO.ROUTES
-- Generated 9-mar-2004 20:24:03 from SYSMAN@MAQUINA4

CREATE TABLE routes
    (rowstamp                       VARCHAR2(40) NOT NULL,
    route                          VARCHAR2(16) NOT NULL,
    description                    VARCHAR2(50),
    ldkey                          NUMBER,
    rt1                            VARCHAR2(1),
    rt2                            VARCHAR2(25),
    rt3                            VARCHAR2(1),
    rt4                            VARCHAR2(1),
    rt5                            VARCHAR2(1),
    orgid                          VARCHAR2(8) NOT NULL,
    siteid                         VARCHAR2(8) NOT NULL,
    changechildstatus              VARCHAR2(1) NOT NULL)
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Indexes for ROUTES

CREATE UNIQUE INDEX routes_ndx1 ON routes
  (
    siteid                          ASC,
    route                           ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/


-- Triggers for ROUTES

CREATE TRIGGER routes_t
BEFORE INSERT  OR UPDATE 
ON routes
REFERENCING NEW AS NEW OLD AS OLD
FOR EACH ROW
DECLARE 
NEXTVAL INTEGER; BEGIN SELECT MAXSEQ.NEXTVAL INTO NEXTVAL FROM DUAL; 
:NEW.ROWSTAMP := NEXTVAL; END;
/

-- End of DDL Script for Table IFRMAXIMO.ROUTES

-- Start of DDL Script for Table IFRMAXIMO.SAFETYLEXICON
-- Generated 9-mar-2004 20:24:10 from SYSMAN@MAQUINA4

CREATE TABLE safetylexicon
    (rowstamp                       VARCHAR2(40) NOT NULL,
    safetylexiconid                NUMBER NOT NULL,
    location                       VARCHAR2(18),
    eqnum                          VARCHAR2(12),
    hazardid                       VARCHAR2(8),
    tagoutid                       VARCHAR2(8),
    sl01                           VARCHAR2(10),
    sl02                           VARCHAR2(10),
    sl03                           DATE,
    sl04                           NUMBER(15,2),
    sl05                           NUMBER,
    applyseq                       NUMBER,
    removeseq                      NUMBER,
    orgid                          VARCHAR2(8) NOT NULL,
    siteid                         VARCHAR2(8) NOT NULL)
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Indexes for SAFETYLEXICON

CREATE UNIQUE INDEX safetylexicon_ndx1 ON safetylexicon
  (
    siteid                          ASC,
    safetylexiconid                 ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/
CREATE INDEX safetylexicon_ndx2 ON safetylexicon
  (
    siteid                          ASC,
    location                        ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/
CREATE INDEX safetylexicon_ndx3 ON safetylexicon
  (
    siteid                          ASC,
    eqnum                           ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/
CREATE INDEX safetylexicon_ndx4 ON safetylexicon
  (
    siteid                          ASC,
    hazardid                        ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/
CREATE INDEX safetylexicon_ndx5 ON safetylexicon
  (
    siteid                          ASC,
    tagoutid                        ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/


-- Triggers for SAFETYLEXICON

CREATE TRIGGER safetylexicon_t
BEFORE INSERT  OR UPDATE 
ON safetylexicon
REFERENCING NEW AS NEW OLD AS OLD
FOR EACH ROW
DECLARE 
NEXTVAL INTEGER; BEGIN SELECT MAXSEQ.NEXTVAL INTO NEXTVAL FROM DUAL; 
:NEW.ROWSTAMP := NEXTVAL; END;
/

-- End of DDL Script for Table IFRMAXIMO.SAFETYLEXICON

-- Start of DDL Script for Table IFRMAXIMO.SAFETYPLAN
-- Generated 9-mar-2004 20:24:32 from SYSMAN@MAQUINA4

CREATE TABLE safetyplan
    (rowstamp                       VARCHAR2(40) NOT NULL,
    safetyplanid                   VARCHAR2(16) NOT NULL,
    description                    VARCHAR2(120),
    changeby                       VARCHAR2(18) NOT NULL,
    changedate                     DATE NOT NULL,
    sp01                           VARCHAR2(10),
    sp02                           VARCHAR2(10),
    sp03                           DATE,
    sp04                           NUMBER(15,2),
    sp05                           NUMBER,
    sp06                           VARCHAR2(10),
    sp07                           VARCHAR2(10),
    sp08                           VARCHAR2(10),
    sp09                           VARCHAR2(10),
    sp10                           VARCHAR2(10),
    sp11                           NUMBER(10,2),
    sp12                           DATE,
    sp13                           NUMBER(15,2),
    sp14                           VARCHAR2(10),
    sp15                           VARCHAR2(1),
    ldkey                          NUMBER,
    orgid                          VARCHAR2(8) NOT NULL,
    siteid                         VARCHAR2(8) NOT NULL)
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Indexes for SAFETYPLAN

CREATE UNIQUE INDEX safetyplan_ndx1 ON safetyplan
  (
    siteid                          ASC,
    safetyplanid                    ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/


-- Triggers for SAFETYPLAN

CREATE TRIGGER safetyplan_t
BEFORE INSERT  OR UPDATE 
ON safetyplan
REFERENCING NEW AS NEW OLD AS OLD
FOR EACH ROW
DECLARE 
NEXTVAL INTEGER; BEGIN SELECT MAXSEQ.NEXTVAL INTO NEXTVAL FROM DUAL; 
:NEW.ROWSTAMP := NEXTVAL; END;
/

-- End of DDL Script for Table IFRMAXIMO.SAFETYPLAN

-- Start of DDL Script for Table IFRMAXIMO.SCHARGES
-- Generated 9-mar-2004 20:24:37 from SYSMAN@MAQUINA4

CREATE TABLE scharges
    (rowstamp                       VARCHAR2(40) NOT NULL,
    schargecode                    VARCHAR2(8) NOT NULL,
    gldebitacct                    VARCHAR2(20),
    description                    VARCHAR2(50),
    tax1code                       VARCHAR2(8),
    tax2code                       VARCHAR2(8),
    tax3code                       VARCHAR2(8),
    tax4code                       VARCHAR2(8),
    tax5code                       VARCHAR2(8),
    prorateservdflt                VARCHAR2(1) NOT NULL,
    orgid                          VARCHAR2(8) NOT NULL)
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Indexes for SCHARGES

CREATE UNIQUE INDEX scharges_ndx1 ON scharges
  (
    orgid                           ASC,
    schargecode                     ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/


-- Triggers for SCHARGES

CREATE TRIGGER scharges_t
BEFORE INSERT  OR UPDATE 
ON scharges
REFERENCING NEW AS NEW OLD AS OLD
FOR EACH ROW
DECLARE 
NEXTVAL INTEGER; BEGIN SELECT MAXSEQ.NEXTVAL INTO NEXTVAL FROM DUAL; 
:NEW.ROWSTAMP := NEXTVAL; END;
/

-- End of DDL Script for Table IFRMAXIMO.SCHARGES

-- Start of DDL Script for Table IFRMAXIMO.SERVICECONTRACT
-- Generated 9-mar-2004 20:24:43 from SYSMAN@MAQUINA4

CREATE TABLE servicecontract
    (rowstamp                       VARCHAR2(40) NOT NULL,
    contract                       VARCHAR2(10) NOT NULL,
    vendor                         VARCHAR2(18) NOT NULL,
    vendorscontractnum             VARCHAR2(50),
    eqnum                          VARCHAR2(12) NOT NULL,
    description                    VARCHAR2(120),
    sc1                            DATE,
    sc2                            DATE,
    sc3                            VARCHAR2(20),
    sc4                            VARCHAR2(20),
    sc5                            NUMBER(10,2),
    ldkey                          NUMBER,
    orgid                          VARCHAR2(8) NOT NULL,
    siteid                         VARCHAR2(8) NOT NULL)
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Indexes for SERVICECONTRACT

CREATE UNIQUE INDEX servcont_ndx1 ON servicecontract
  (
    siteid                          ASC,
    contract                        ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/
CREATE INDEX servcont_ndx2 ON servicecontract
  (
    siteid                          ASC,
    vendor                          ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/
CREATE INDEX servcont_ndx3 ON servicecontract
  (
    siteid                          ASC,
    vendorscontractnum              ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/
CREATE INDEX servcont_ndx4 ON servicecontract
  (
    siteid                          ASC,
    eqnum                           ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/


-- Triggers for SERVICECONTRACT

CREATE TRIGGER servicecontract_t
BEFORE INSERT  OR UPDATE 
ON servicecontract
REFERENCING NEW AS NEW OLD AS OLD
FOR EACH ROW
DECLARE 
NEXTVAL INTEGER; BEGIN SELECT MAXSEQ.NEXTVAL INTO NEXTVAL FROM DUAL; 
:NEW.ROWSTAMP := NEXTVAL; END;
/

-- End of DDL Script for Table IFRMAXIMO.SERVICECONTRACT

-- Start of DDL Script for Table IFRMAXIMO.SERVRECTRANS
-- Generated 9-mar-2004 20:25:00 from SYSMAN@MAQUINA4

CREATE TABLE servrectrans
    (rowstamp                       VARCHAR2(40) NOT NULL,
    ponum                          VARCHAR2(8),
    eqnum                          VARCHAR2(12),
    location                       VARCHAR2(18),
    claimnum                       VARCHAR2(8),
    rejectqty                      NUMBER(15,2),
    quantity                       NUMBER(15,2),
    unitcost                       NUMBER(10,2),
    rejectcost                     NUMBER(15,2),
    linecost                       NUMBER(10,2) NOT NULL,
    gldebitacct                    VARCHAR2(20),
    glcreditacct                   VARCHAR2(20),
    financialperiod                VARCHAR2(6),
    transdate                      DATE NOT NULL,
    enterdate                      DATE NOT NULL,
    enterby                        VARCHAR2(18) NOT NULL,
    ss1                            VARCHAR2(10),
    ss2                            NUMBER(10,2),
    ss3                            DATE,
    ss4                            NUMBER(15,2),
    ss5                            VARCHAR2(10),
    ldkey                          NUMBER,
    description                    VARCHAR2(120),
    currencyunitcost               NUMBER(10,2),
    currencylinecost               NUMBER(10,2) NOT NULL,
    currencycode                   VARCHAR2(8) NOT NULL,
    polinenum                      NUMBER,
    remark                         VARCHAR2(254),
    sspl1                          NUMBER(10,2),
    approved                       VARCHAR2(1) NOT NULL,
    approvedate                    DATE,
    approveby                      VARCHAR2(18),
    rollup                         VARCHAR2(1) NOT NULL,
    sspl2                          VARCHAR2(10),
    sspl3                          VARCHAR2(10),
    invoicenum                     VARCHAR2(8),
    exchangerate                   NUMBER(14,7),
    loadedcost                     NUMBER(10,2) NOT NULL,
    tax1code                       VARCHAR2(8),
    tax1                           NUMBER(10,2),
    tax2code                       VARCHAR2(8),
    tax2                           NUMBER(10,2),
    tax3code                       VARCHAR2(8),
    tax3                           NUMBER(10,2),
    tax4code                       VARCHAR2(8),
    tax4                           NUMBER(10,2),
    tax5code                       VARCHAR2(8),
    tax5                           NUMBER(10,2),
    prorated                       VARCHAR2(1) NOT NULL,
    proratecost                    NUMBER(10,2),
    sourcesysid                    VARCHAR2(10),
    exchangerate2                  NUMBER(14,7),
    linecost2                      NUMBER(10,2),
    mrnum                          VARCHAR2(8),
    mrlinenum                      NUMBER,
    servrectransid                 NUMBER NOT NULL,
    ownersysid                     VARCHAR2(10),
    externalrefid                  VARCHAR2(10),
    sspl4                          VARCHAR2(1),
    sspl5                          VARCHAR2(1),
    sspl6                          VARCHAR2(1),
    sspl7                          VARCHAR2(1),
    apiseq                         VARCHAR2(50),
    interid                        VARCHAR2(50),
    migchangeid                    VARCHAR2(50),
    sendersysid                    VARCHAR2(50),
    expdone                        VARCHAR2(25),
    fincntrlid                     VARCHAR2(8),
    orgid                          VARCHAR2(8) NOT NULL,
    siteid                         VARCHAR2(8) NOT NULL,
    issuetype                      VARCHAR2(10) NOT NULL,
    costinfo                       VARCHAR2(1) NOT NULL,
    belongsto                      NUMBER,
    refwo                          VARCHAR2(18),
    enteredastask                  VARCHAR2(1) NOT NULL)
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Indexes for SERVRECTRANS

CREATE UNIQUE INDEX servrectrans_ndx1 ON servrectrans
  (
    siteid                          ASC,
    servrectransid                  ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/
CREATE INDEX servrectrans_ndx2 ON servrectrans
  (
    siteid                          ASC,
    ponum                           ASC,
    polinenum                       ASC,
    transdate                       ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/
CREATE INDEX servrectrans_ndx3 ON servrectrans
  (
    siteid                          ASC,
    interid                         ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/


-- Triggers for SERVRECTRANS

CREATE TRIGGER servrectrans_t
BEFORE INSERT  OR UPDATE 
ON servrectrans
REFERENCING NEW AS NEW OLD AS OLD
FOR EACH ROW
DECLARE NEXTVAL INTEGER; BEGIN SELECT MAXSEQ.NEXTVAL INTO NEXTVAL FROM DUAL; :NEW.ROWSTAMP := NEXTVAL; END;
/

-- End of DDL Script for Table IFRMAXIMO.SERVRECTRANS

-- Start of DDL Script for Table IFRMAXIMO.SHIFT
-- Generated 9-mar-2004 20:25:13 from SYSMAN@MAQUINA4

CREATE TABLE shift
    (rowstamp                       VARCHAR2(40) NOT NULL,
    shiftnum                       VARCHAR2(8) NOT NULL,
    description                    VARCHAR2(50),
    ldkey                          NUMBER,
    startday                       VARCHAR2(10) NOT NULL,
    orgid                          VARCHAR2(8) NOT NULL)
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Indexes for SHIFT

CREATE UNIQUE INDEX shift_ndx1 ON shift
  (
    orgid                           ASC,
    shiftnum                        ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/


-- Triggers for SHIFT

CREATE TRIGGER shift_t
BEFORE INSERT  OR UPDATE 
ON shift
REFERENCING NEW AS NEW OLD AS OLD
FOR EACH ROW
DECLARE 
NEXTVAL INTEGER; BEGIN SELECT MAXSEQ.NEXTVAL INTO NEXTVAL FROM DUAL; 
:NEW.ROWSTAMP := NEXTVAL; END;
/

-- End of DDL Script for Table IFRMAXIMO.SHIFT

-- Start of DDL Script for Table IFRMAXIMO.SHIFTPATTERNDAY
-- Generated 9-mar-2004 20:25:19 from SYSMAN@MAQUINA4

CREATE TABLE shiftpatternday
    (rowstamp                       VARCHAR2(40) NOT NULL,
    shiftnum                       VARCHAR2(8) NOT NULL,
    patterndayseq                  NUMBER NOT NULL,
    starttime                      DATE,
    endtime                        DATE,
    workhours                      FLOAT(126),
    orgid                          VARCHAR2(8) NOT NULL)
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Indexes for SHIFTPATTERNDAY

CREATE UNIQUE INDEX shiftpatday_ndx1 ON shiftpatternday
  (
    orgid                           ASC,
    shiftnum                        ASC,
    patterndayseq                   ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/


-- Triggers for SHIFTPATTERNDAY

CREATE TRIGGER shiftpatternday_t
BEFORE INSERT  OR UPDATE 
ON shiftpatternday
REFERENCING NEW AS NEW OLD AS OLD
FOR EACH ROW
DECLARE 
NEXTVAL INTEGER; BEGIN SELECT MAXSEQ.NEXTVAL INTO NEXTVAL FROM DUAL; 
:NEW.ROWSTAMP := NEXTVAL; END;
/

-- End of DDL Script for Table IFRMAXIMO.SHIFTPATTERNDAY

-- Start of DDL Script for Table IFRMAXIMO.SHIPMENT
-- Generated 9-mar-2004 20:25:24 from SYSMAN@MAQUINA4

CREATE TABLE shipment
    (rowstamp                       VARCHAR2(40) NOT NULL,
    shipmentid                     NUMBER NOT NULL,
    shipmentnum                    VARCHAR2(50),
    status                         VARCHAR2(8) NOT NULL,
    shipdate                       DATE NOT NULL,
    vendor                         VARCHAR2(18),
    shipto                         VARCHAR2(50),
    billto                         VARCHAR2(50),
    expreceiptdate                 DATE,
    droppoint                      VARCHAR2(50),
    carrier                        VARCHAR2(50),
    carriermethod                  VARCHAR2(50),
    carriervehiclenum              VARCHAR2(50),
    numofpackages                  VARCHAR2(50),
    grossweight                    VARCHAR2(50),
    grossweightuom                 VARCHAR2(50),
    netweight                      VARCHAR2(50),
    netweightuom                   VARCHAR2(50),
    billoflading                   VARCHAR2(50),
    packingslipnum                 VARCHAR2(50),
    specialhandling                VARCHAR2(50),
    freightbillnum                 VARCHAR2(50),
    freightamount                  NUMBER(10,2),
    freightterms                   VARCHAR2(50),
    paymentterms                   VARCHAR2(20),
    waybillnum                     VARCHAR2(50),
    enterby                        VARCHAR2(18),
    enterdate                      DATE,
    fob                            VARCHAR2(20),
    siteid                         VARCHAR2(8) NOT NULL,
    orgid                          VARCHAR2(8) NOT NULL)
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Indexes for SHIPMENT

CREATE UNIQUE INDEX shipment_ndx1 ON shipment
  (
    siteid                          ASC,
    shipmentid                      ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/


-- Triggers for SHIPMENT

CREATE TRIGGER shipment_t
BEFORE INSERT  OR UPDATE 
ON shipment
REFERENCING NEW AS NEW OLD AS OLD
FOR EACH ROW
DECLARE 
NEXTVAL INTEGER; BEGIN SELECT MAXSEQ.NEXTVAL INTO NEXTVAL FROM DUAL; 
:NEW.ROWSTAMP := NEXTVAL; END;
/

-- End of DDL Script for Table IFRMAXIMO.SHIPMENT

-- Start of DDL Script for Table IFRMAXIMO.SHIPMENTLINE
-- Generated 9-mar-2004 20:25:28 from SYSMAN@MAQUINA4

CREATE TABLE shipmentline
    (rowstamp                       VARCHAR2(40) NOT NULL,
    shipmentid                     NUMBER NOT NULL,
    shipmentlineid                 NUMBER NOT NULL,
    shipmentlinenum                VARCHAR2(50),
    vendor                         VARCHAR2(18) NOT NULL,
    itemnum                        VARCHAR2(30),
    itemdescription                VARCHAR2(120),
    catalogcode                    VARCHAR2(50),
    vendorlotnum                   VARCHAR2(50),
    orderunit                      VARCHAR2(50),
    ponum                          VARCHAR2(8) NOT NULL,
    polineid                       NUMBER,
    countryoforigin                VARCHAR2(50),
    hazard                         VARCHAR2(50),
    billoflading                   VARCHAR2(50),
    packingcode                    VARCHAR2(50),
    packingslipnum                 VARCHAR2(50),
    comments                       VARCHAR2(254),
    shippedqty                     NUMBER(15,2) NOT NULL,
    backorderqty                   NUMBER(15,2),
    invoicedqty                    NUMBER(15,2),
    polinenum                      NUMBER,
    rectransid                     NUMBER,
    siteid                         VARCHAR2(8) NOT NULL,
    orgid                          VARCHAR2(8) NOT NULL,
    trackingid                     VARCHAR2(50))
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Indexes for SHIPMENTLINE

CREATE UNIQUE INDEX shipmentline_ndx1 ON shipmentline
  (
    siteid                          ASC,
    shipmentid                      ASC,
    shipmentlineid                  ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/


-- Triggers for SHIPMENTLINE

CREATE TRIGGER shipmentline_t
BEFORE INSERT  OR UPDATE 
ON shipmentline
REFERENCING NEW AS NEW OLD AS OLD
FOR EACH ROW
DECLARE 
NEXTVAL INTEGER; BEGIN SELECT MAXSEQ.NEXTVAL INTO NEXTVAL FROM DUAL; 
:NEW.ROWSTAMP := NEXTVAL; END;
/

-- End of DDL Script for Table IFRMAXIMO.SHIPMENTLINE

-- Start of DDL Script for Table IFRMAXIMO.SIGOPTION
-- Generated 9-mar-2004 20:25:35 from SYSMAN@MAQUINA4

CREATE TABLE sigoption
    (rowstamp                       VARCHAR2(40) NOT NULL,
    app                            VARCHAR2(10) NOT NULL,
    optionname                     VARCHAR2(10) NOT NULL,
    optiontype                     VARCHAR2(10) NOT NULL,
    description                    VARCHAR2(50),
    menugroup                      NUMBER,
    menuposition                   NUMBER,
    toolbargroup                   NUMBER,
    toolbarposition                NUMBER,
    image                          VARCHAR2(50),
    ldkey                          NUMBER,
    accessokwhenappro              VARCHAR2(1) NOT NULL,
    accesskey                      VARCHAR2(30),
    esigenabled                    VARCHAR2(1) NOT NULL)
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Indexes for SIGOPTION

CREATE UNIQUE INDEX sigoption_ndx ON sigoption
  (
    app                             ASC,
    optionname                      ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/


-- Triggers for SIGOPTION

CREATE TRIGGER sigoption_t
BEFORE INSERT  OR UPDATE 
ON sigoption
REFERENCING NEW AS NEW OLD AS OLD
FOR EACH ROW
DECLARE 
NEXTVAL INTEGER; BEGIN SELECT MAXSEQ.NEXTVAL INTO NEXTVAL FROM DUAL; 
:NEW.ROWSTAMP := NEXTVAL; END;
/

-- End of DDL Script for Table IFRMAXIMO.SIGOPTION

-- Start of DDL Script for Table IFRMAXIMO.SITE
-- Generated 9-mar-2004 20:25:40 from SYSMAN@MAQUINA4

CREATE TABLE site
    (rowstamp                       VARCHAR2(40) NOT NULL,
    siteid                         VARCHAR2(8) NOT NULL,
    description                    VARCHAR2(150),
    disabled                       VARCHAR2(1) NOT NULL,
    ldkey                          NUMBER,
    enterby                        VARCHAR2(18),
    enterdate                      DATE,
    changeby                       VARCHAR2(18) NOT NULL,
    changedate                     DATE NOT NULL,
    orgid                          VARCHAR2(8) NOT NULL,
    shiptolaborcode                VARCHAR2(12),
    billtolaborcode                VARCHAR2(12),
    shiptoaddresscode              VARCHAR2(50),
    billtoaddresscode              VARCHAR2(50),
    primarysystem                  VARCHAR2(8))
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Indexes for SITE

CREATE UNIQUE INDEX site_ndx1 ON site
  (
    siteid                          ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/


-- Triggers for SITE

CREATE TRIGGER site_t
BEFORE INSERT  OR UPDATE 
ON site
REFERENCING NEW AS NEW OLD AS OLD
FOR EACH ROW
DECLARE 
NEXTVAL INTEGER; BEGIN SELECT MAXSEQ.NEXTVAL INTO NEXTVAL FROM DUAL; 
:NEW.ROWSTAMP := NEXTVAL; END;
/

-- End of DDL Script for Table IFRMAXIMO.SITE

-- Start of DDL Script for Table IFRMAXIMO.SITEECOM
-- Generated 9-mar-2004 20:25:47 from SYSMAN@MAQUINA4

CREATE TABLE siteecom
    (rowstamp                       VARCHAR2(40) NOT NULL,
    orgid                          VARCHAR2(8) NOT NULL,
    siteid                         VARCHAR2(8) NOT NULL,
    vendor                         VARCHAR2(18) NOT NULL,
    mktplcid                       VARCHAR2(50) NOT NULL,
    mktplciddomain                 VARCHAR2(50),
    custnum                        VARCHAR2(50),
    dunsnum                        VARCHAR2(16))
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Indexes for SITEECOM

CREATE UNIQUE INDEX siteecom_ndx1 ON siteecom
  (
    siteid                          ASC,
    orgid                           ASC,
    vendor                          ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/


-- Triggers for SITEECOM

CREATE TRIGGER siteecom_t
BEFORE INSERT  OR UPDATE 
ON siteecom
REFERENCING NEW AS NEW OLD AS OLD
FOR EACH ROW
DECLARE 
NEXTVAL INTEGER; BEGIN SELECT MAXSEQ.NEXTVAL INTO NEXTVAL FROM DUAL; 
:NEW.ROWSTAMP := NEXTVAL; END;
/

-- End of DDL Script for Table IFRMAXIMO.SITEECOM

-- Start of DDL Script for Table IFRMAXIMO.SITERESTRICTION
-- Generated 9-mar-2004 20:25:54 from SYSMAN@MAQUINA4

CREATE TABLE siterestriction
    (rowstamp                       VARCHAR2(40) NOT NULL,
    siteid                         VARCHAR2(8) NOT NULL,
    tbname                         VARCHAR2(18) NOT NULL,
    restrictions                   VARCHAR2(254))
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Indexes for SITERESTRICTION

CREATE UNIQUE INDEX siterestr_ndx1 ON siterestriction
  (
    siteid                          ASC,
    tbname                          ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/


-- Triggers for SITERESTRICTION

CREATE TRIGGER siterestriction_t
BEFORE INSERT  OR UPDATE 
ON siterestriction
REFERENCING NEW AS NEW OLD AS OLD
FOR EACH ROW
DECLARE 
NEXTVAL INTEGER; BEGIN SELECT MAXSEQ.NEXTVAL INTO NEXTVAL FROM DUAL; 
:NEW.ROWSTAMP := NEXTVAL; END;
/

-- End of DDL Script for Table IFRMAXIMO.SITERESTRICTION

-- Start of DDL Script for Table IFRMAXIMO.SITEUSER
-- Generated 9-mar-2004 20:26:01 from SYSMAN@MAQUINA4

CREATE TABLE siteuser
    (rowstamp                       VARCHAR2(40) NOT NULL,
    siteid                         VARCHAR2(8) NOT NULL,
    username                       VARCHAR2(18) NOT NULL,
    orgid                          VARCHAR2(8) NOT NULL,
    laborcode                      VARCHAR2(12) NOT NULL)
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Indexes for SITEUSER

CREATE UNIQUE INDEX siteuser_ndx1 ON siteuser
  (
    siteid                          ASC,
    username                        ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/
CREATE INDEX siteuser_ndx2 ON siteuser
  (
    username                        ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/


-- Triggers for SITEUSER

CREATE TRIGGER siteuser_t
BEFORE INSERT  OR UPDATE 
ON siteuser
REFERENCING NEW AS NEW OLD AS OLD
FOR EACH ROW
DECLARE 
NEXTVAL INTEGER; BEGIN SELECT MAXSEQ.NEXTVAL INTO NEXTVAL FROM DUAL; 
:NEW.ROWSTAMP := NEXTVAL; END;
/

-- End of DDL Script for Table IFRMAXIMO.SITEUSER

-- Start of DDL Script for Table IFRMAXIMO.SPAREPART
-- Generated 9-mar-2004 20:26:11 from SYSMAN@MAQUINA4

CREATE TABLE sparepart
    (rowstamp                       VARCHAR2(40) NOT NULL,
    eqnum                          VARCHAR2(12) NOT NULL,
    itemnum                        VARCHAR2(30) NOT NULL,
    quantity                       NUMBER(15,2) NOT NULL,
    description                    VARCHAR2(120),
    ldkey                          NUMBER,
    siteid                         VARCHAR2(8) NOT NULL,
    orgid                          VARCHAR2(8) NOT NULL)
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Indexes for SPAREPART

CREATE INDEX sparepart_ndx1 ON sparepart
  (
    siteid                          ASC,
    eqnum                           ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/
CREATE INDEX sparepart_ndx2 ON sparepart
  (
    siteid                          ASC,
    itemnum                         ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/


-- Triggers for SPAREPART

CREATE TRIGGER sparepart_t
BEFORE INSERT  OR UPDATE 
ON sparepart
REFERENCING NEW AS NEW OLD AS OLD
FOR EACH ROW
DECLARE 
NEXTVAL INTEGER; BEGIN SELECT MAXSEQ.NEXTVAL INTO NEXTVAL FROM DUAL; 
:NEW.ROWSTAMP := NEXTVAL; END;
/

-- End of DDL Script for Table IFRMAXIMO.SPAREPART

-- Start of DDL Script for Table IFRMAXIMO.SPLEXICONLINK
-- Generated 9-mar-2004 20:26:21 from SYSMAN@MAQUINA4

CREATE TABLE splexiconlink
    (rowstamp                       VARCHAR2(40) NOT NULL,
    spworkassetid                  NUMBER NOT NULL,
    safetylexiconid                NUMBER NOT NULL,
    applyseq                       NUMBER,
    removeseq                      NUMBER,
    orgid                          VARCHAR2(8) NOT NULL,
    siteid                         VARCHAR2(8) NOT NULL)
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Indexes for SPLEXICONLINK

CREATE UNIQUE INDEX splexiconlink_ndx1 ON splexiconlink
  (
    siteid                          ASC,
    spworkassetid                   ASC,
    safetylexiconid                 ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/
CREATE INDEX splexiconlink_ndx2 ON splexiconlink
  (
    siteid                          ASC,
    spworkassetid                   ASC,
    applyseq                        ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/


-- Triggers for SPLEXICONLINK

CREATE TRIGGER splexiconlink_t
BEFORE INSERT  OR UPDATE 
ON splexiconlink
REFERENCING NEW AS NEW OLD AS OLD
FOR EACH ROW
DECLARE 
NEXTVAL INTEGER; BEGIN SELECT MAXSEQ.NEXTVAL INTO NEXTVAL FROM DUAL; 
:NEW.ROWSTAMP := NEXTVAL; END;
/

-- End of DDL Script for Table IFRMAXIMO.SPLEXICONLINK

-- Start of DDL Script for Table IFRMAXIMO.SPRELATEDASSET
-- Generated 9-mar-2004 20:26:32 from SYSMAN@MAQUINA4

CREATE TABLE sprelatedasset
    (rowstamp                       VARCHAR2(40) NOT NULL,
    sprelatedassetid               NUMBER NOT NULL,
    location                       VARCHAR2(18),
    eqnum                          VARCHAR2(12),
    relatedlocation                VARCHAR2(18),
    relatedequipment               VARCHAR2(12),
    sra01                          VARCHAR2(10),
    sra02                          VARCHAR2(10),
    sra03                          VARCHAR2(10),
    sra04                          NUMBER(15,2),
    sra05                          NUMBER,
    orgid                          VARCHAR2(8) NOT NULL,
    siteid                         VARCHAR2(8) NOT NULL)
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Indexes for SPRELATEDASSET

CREATE UNIQUE INDEX srelatedasset_ndx1 ON sprelatedasset
  (
    siteid                          ASC,
    sprelatedassetid                ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/
CREATE INDEX srelatedasset_ndx2 ON sprelatedasset
  (
    siteid                          ASC,
    location                        ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/
CREATE INDEX srelatedasset_ndx3 ON sprelatedasset
  (
    siteid                          ASC,
    eqnum                           ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/


-- Triggers for SPRELATEDASSET

CREATE TRIGGER sprelatedasset_t
BEFORE INSERT  OR UPDATE 
ON sprelatedasset
REFERENCING NEW AS NEW OLD AS OLD
FOR EACH ROW
DECLARE 
NEXTVAL INTEGER; BEGIN SELECT MAXSEQ.NEXTVAL INTO NEXTVAL FROM DUAL; 
:NEW.ROWSTAMP := NEXTVAL; END;
/

-- End of DDL Script for Table IFRMAXIMO.SPRELATEDASSET

-- Start of DDL Script for Table IFRMAXIMO.SPWORKASSET
-- Generated 9-mar-2004 20:26:49 from SYSMAN@MAQUINA4

CREATE TABLE spworkasset
    (rowstamp                       VARCHAR2(40) NOT NULL,
    spworkassetid                  NUMBER NOT NULL,
    safetyplanid                   VARCHAR2(16) NOT NULL,
    workequipment                  VARCHAR2(12),
    worklocation                   VARCHAR2(18),
    spwa01                         VARCHAR2(10),
    spwa02                         VARCHAR2(10),
    spwa03                         VARCHAR2(10),
    spwa04                         NUMBER(15,2),
    spwa05                         VARCHAR2(10),
    orgid                          VARCHAR2(8) NOT NULL,
    siteid                         VARCHAR2(8) NOT NULL)
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Indexes for SPWORKASSET

CREATE UNIQUE INDEX spworkasset_ndx1 ON spworkasset
  (
    siteid                          ASC,
    spworkassetid                   ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/
CREATE INDEX spworkasset_ndx2 ON spworkasset
  (
    siteid                          ASC,
    worklocation                    ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/
CREATE INDEX spworkasset_ndx3 ON spworkasset
  (
    siteid                          ASC,
    workequipment                   ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/
CREATE INDEX spworkasset_ndx4 ON spworkasset
  (
    siteid                          ASC,
    safetyplanid                    ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/


-- Triggers for SPWORKASSET

CREATE TRIGGER spworkasset_t
BEFORE INSERT  OR UPDATE 
ON spworkasset
REFERENCING NEW AS NEW OLD AS OLD
FOR EACH ROW
DECLARE 
NEXTVAL INTEGER; BEGIN SELECT MAXSEQ.NEXTVAL INTO NEXTVAL FROM DUAL; 
:NEW.ROWSTAMP := NEXTVAL; END;
/

-- End of DDL Script for Table IFRMAXIMO.SPWORKASSET

-- Start of DDL Script for Table IFRMAXIMO.STARTCENTER
-- Generated 9-mar-2004 20:27:08 from SYSMAN@MAQUINA4

CREATE TABLE startcenter
    (rowstamp                       VARCHAR2(40) NOT NULL,
    startcenterid                  VARCHAR2(8) NOT NULL,
    description                    VARCHAR2(150))
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Indexes for STARTCENTER

CREATE UNIQUE INDEX startcenter_ndx1 ON startcenter
  (
    startcenterid                   ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/


-- Triggers for STARTCENTER

CREATE TRIGGER startcenter_t
BEFORE INSERT  OR UPDATE 
ON startcenter
REFERENCING NEW AS NEW OLD AS OLD
FOR EACH ROW
DECLARE 
NEXTVAL INTEGER; BEGIN SELECT MAXSEQ.NEXTVAL INTO NEXTVAL FROM DUAL; 
:NEW.ROWSTAMP := NEXTVAL; END;
/

-- End of DDL Script for Table IFRMAXIMO.STARTCENTER

-- Start of DDL Script for Table IFRMAXIMO.TAGLOCK
-- Generated 9-mar-2004 20:27:15 from SYSMAN@MAQUINA4

CREATE TABLE taglock
    (rowstamp                       VARCHAR2(40) NOT NULL,
    tagoutid                       VARCHAR2(8) NOT NULL,
    lockoutid                      VARCHAR2(20) NOT NULL,
    applyseq                       NUMBER,
    removeseq                      NUMBER,
    tl01                           VARCHAR2(10),
    tl02                           VARCHAR2(10),
    tl03                           VARCHAR2(10),
    tl04                           VARCHAR2(10),
    tl05                           VARCHAR2(10),
    tl06                           NUMBER(10,2),
    tl07                           DATE,
    tl08                           NUMBER(15,2),
    tl09                           VARCHAR2(10),
    tl10                           NUMBER,
    taglockid                      NUMBER NOT NULL,
    orgid                          VARCHAR2(8) NOT NULL,
    siteid                         VARCHAR2(8) NOT NULL)
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Indexes for TAGLOCK

CREATE UNIQUE INDEX taglock_ndx1 ON taglock
  (
    siteid                          ASC,
    taglockid                       ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/
CREATE INDEX taglock_ndx2 ON taglock
  (
    siteid                          ASC,
    tagoutid                        ASC,
    lockoutid                       ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/
CREATE INDEX taglock_ndx3 ON taglock
  (
    siteid                          ASC,
    tagoutid                        ASC,
    applyseq                        ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/


-- Triggers for TAGLOCK

CREATE TRIGGER taglock_t
BEFORE INSERT  OR UPDATE 
ON taglock
REFERENCING NEW AS NEW OLD AS OLD
FOR EACH ROW
DECLARE 
NEXTVAL INTEGER; BEGIN SELECT MAXSEQ.NEXTVAL INTO NEXTVAL FROM DUAL; 
:NEW.ROWSTAMP := NEXTVAL; END;
/

-- End of DDL Script for Table IFRMAXIMO.TAGLOCK

-- Start of DDL Script for Table IFRMAXIMO.TAGOUT
-- Generated 9-mar-2004 20:27:30 from SYSMAN@MAQUINA4

CREATE TABLE tagout
    (rowstamp                       VARCHAR2(40) NOT NULL,
    tagoutid                       VARCHAR2(8) NOT NULL,
    description                    VARCHAR2(50),
    ldkey                          NUMBER,
    location                       VARCHAR2(18),
    eqnum                          VARCHAR2(12),
    requiredstate                  VARCHAR2(16),
    tag01                          VARCHAR2(10),
    tag02                          VARCHAR2(10),
    tag03                          VARCHAR2(10),
    tag04                          VARCHAR2(10),
    tag05                          NUMBER(10,2),
    tag06                          DATE,
    tag07                          NUMBER(15,2),
    tag08                          VARCHAR2(10),
    orgid                          VARCHAR2(8) NOT NULL,
    siteid                         VARCHAR2(8) NOT NULL)
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Indexes for TAGOUT

CREATE UNIQUE INDEX tagout_ndx1 ON tagout
  (
    siteid                          ASC,
    tagoutid                        ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/


-- Triggers for TAGOUT

CREATE TRIGGER tagout_t
BEFORE INSERT  OR UPDATE 
ON tagout
REFERENCING NEW AS NEW OLD AS OLD
FOR EACH ROW
DECLARE 
NEXTVAL INTEGER; BEGIN SELECT MAXSEQ.NEXTVAL INTO NEXTVAL FROM DUAL; 
:NEW.ROWSTAMP := NEXTVAL; END;
/

-- End of DDL Script for Table IFRMAXIMO.TAGOUT

-- Start of DDL Script for Table IFRMAXIMO.TAX
-- Generated 9-mar-2004 20:27:36 from SYSMAN@MAQUINA4

CREATE TABLE tax
    (rowstamp                       VARCHAR2(40) NOT NULL,
    typecode                       VARCHAR2(8) NOT NULL,
    taxcode                        VARCHAR2(8) NOT NULL,
    taxrate                        NUMBER(15,2) NOT NULL,
    effective                      DATE NOT NULL,
    inclusivegl                    VARCHAR2(20),
    exclusivegl                    VARCHAR2(20),
    changeby                       VARCHAR2(18) NOT NULL,
    changedate                     DATE NOT NULL,
    orgid                          VARCHAR2(8) NOT NULL)
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Indexes for TAX

CREATE UNIQUE INDEX tax_ndx1 ON tax
  (
    orgid                           ASC,
    typecode                        ASC,
    taxcode                         ASC,
    effective                       ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/
CREATE INDEX tax_ndx2 ON tax
  (
    orgid                           ASC,
    taxcode                         ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/


-- Triggers for TAX

CREATE TRIGGER tax_t
BEFORE INSERT  OR UPDATE 
ON tax
REFERENCING NEW AS NEW OLD AS OLD
FOR EACH ROW
DECLARE 
NEXTVAL INTEGER; BEGIN SELECT MAXSEQ.NEXTVAL INTO NEXTVAL FROM DUAL; 
:NEW.ROWSTAMP := NEXTVAL; END;
/

-- End of DDL Script for Table IFRMAXIMO.TAX

-- Start of DDL Script for Table IFRMAXIMO.TAXTYPE
-- Generated 9-mar-2004 20:27:46 from SYSMAN@MAQUINA4

CREATE TABLE taxtype
    (rowstamp                       VARCHAR2(40) NOT NULL,
    typecode                       VARCHAR2(8) NOT NULL,
    includetax1                    VARCHAR2(1) NOT NULL,
    includetax2                    VARCHAR2(1) NOT NULL,
    includetax3                    VARCHAR2(1) NOT NULL,
    inclusivegl                    VARCHAR2(20),
    exclusivegl                    VARCHAR2(20),
    changeby                       VARCHAR2(18) NOT NULL,
    changedate                     DATE NOT NULL,
    includetax4                    VARCHAR2(1) NOT NULL,
    includetax5                    VARCHAR2(1) NOT NULL,
    addtaxindcr                    NUMBER NOT NULL,
    orgid                          VARCHAR2(8) NOT NULL)
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Indexes for TAXTYPE

CREATE UNIQUE INDEX taxtype_ndx ON taxtype
  (
    orgid                           ASC,
    typecode                        ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/


-- Triggers for TAXTYPE

CREATE TRIGGER taxtype_t
BEFORE INSERT  OR UPDATE 
ON taxtype
REFERENCING NEW AS NEW OLD AS OLD
FOR EACH ROW
DECLARE 
NEXTVAL INTEGER; BEGIN SELECT MAXSEQ.NEXTVAL INTO NEXTVAL FROM DUAL; 
:NEW.ROWSTAMP := NEXTVAL; END;
/

-- End of DDL Script for Table IFRMAXIMO.TAXTYPE

-- Start of DDL Script for Table IFRMAXIMO.TMP_WOSTATUS
-- Generated 9-mar-2004 20:27:51 from SYSMAN@MAQUINA4

CREATE TABLE tmp_wostatus
    (wonum                          VARCHAR2(18) NOT NULL,
    status                         VARCHAR2(8) NOT NULL,
    changedate                     DATE NOT NULL,
    changeby                       VARCHAR2(18) NOT NULL,
    memo                           VARCHAR2(100),
    glaccount                      VARCHAR2(12),
    rowstamp                       VARCHAR2(40) NOT NULL)
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- End of DDL Script for Table IFRMAXIMO.TMP_WOSTATUS

-- Start of DDL Script for Table IFRMAXIMO.TOLERANCE
-- Generated 9-mar-2004 20:27:52 from SYSMAN@MAQUINA4

CREATE TABLE tolerance
    (rowstamp                       VARCHAR2(40) NOT NULL,
    orgid                          VARCHAR2(8) NOT NULL,
    grpname                        VARCHAR2(18) NOT NULL,
    upperinvoiceamt                NUMBER(10,2),
    lowerinvoiceamt                NUMBER(10,2),
    upperinvoicepct                NUMBER(10,4),
    lowerinvoicepct                NUMBER(10,4),
    uppertaxamt                    NUMBER(10,2),
    lowertaxamt                    NUMBER(10,2),
    uppertaxpct                    NUMBER(10,4),
    lowertaxpct                    NUMBER(10,4),
    upperserviceamt                NUMBER(10,2),
    lowerserviceamt                NUMBER(10,2),
    upperservicepct                NUMBER(10,4),
    lowerservicepct                NUMBER(10,4))
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Indexes for TOLERANCE

CREATE UNIQUE INDEX tolerance_ndx1 ON tolerance
  (
    orgid                           ASC,
    grpname                         ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/


-- Triggers for TOLERANCE

CREATE TRIGGER tolerance_t
BEFORE INSERT  OR UPDATE 
ON tolerance
REFERENCING NEW AS NEW OLD AS OLD
FOR EACH ROW
DECLARE 
NEXTVAL INTEGER; BEGIN SELECT MAXSEQ.NEXTVAL INTO NEXTVAL FROM DUAL; 
:NEW.ROWSTAMP := NEXTVAL; END;
/

-- End of DDL Script for Table IFRMAXIMO.TOLERANCE

-- Start of DDL Script for Table IFRMAXIMO.TOOL
-- Generated 9-mar-2004 20:27:57 from SYSMAN@MAQUINA4

CREATE TABLE tool
    (rowstamp                       VARCHAR2(40) NOT NULL,
    toolnum                        VARCHAR2(16) NOT NULL,
    description                    VARCHAR2(120),
    toolqty                        NUMBER NOT NULL,
    stocked                        VARCHAR2(1) NOT NULL,
    toolrate                       NUMBER(10,2) NOT NULL,
    tl1                            VARCHAR2(10),
    tl2                            VARCHAR2(10),
    tl3                            VARCHAR2(10),
    tl4                            VARCHAR2(1),
    tl5                            VARCHAR2(1),
    ldkey                          NUMBER,
    outside                        VARCHAR2(1) NOT NULL,
    tl6                            VARCHAR2(10),
    tl7                            NUMBER(10,2),
    tl8                            NUMBER(15,2),
    glaccount                      VARCHAR2(20),
    controlacc                     VARCHAR2(20),
    vendor                         VARCHAR2(18),
    disabled                       VARCHAR2(1) NOT NULL,
    sourcesysid                    VARCHAR2(10),
    ownersysid                     VARCHAR2(10),
    externalrefid                  VARCHAR2(10),
    orgid                          VARCHAR2(8) NOT NULL)
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Indexes for TOOL

CREATE UNIQUE INDEX tool_ndx1 ON tool
  (
    orgid                           ASC,
    toolnum                         ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/
CREATE INDEX tool_ndx2 ON tool
  (
    orgid                           ASC,
    vendor                          ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/


-- Triggers for TOOL

CREATE TRIGGER tool_t
BEFORE INSERT  OR UPDATE 
ON tool
REFERENCING NEW AS NEW OLD AS OLD
FOR EACH ROW
DECLARE NEXTVAL INTEGER; BEGIN SELECT MAXSEQ.NEXTVAL INTO NEXTVAL FROM DUAL; :NEW.ROWSTAMP := NEXTVAL; END;
/
CREATE TRIGGER tr_toolnum
BEFORE INSERT 
ON tool
REFERENCING NEW AS NEW OLD AS OLD
FOR EACH ROW
DECLARE
    V_COUNT  NUMBER:=0;
    V_NUMERO  VARCHAR2(6):='';
    V_SIGLA   IFRMAXIMO.DEPENDENCIA.AEROPORTO%TYPE :='';
    DEP       IFRMAXIMO.EQUIPMENT.EQNUM%TYPE :='';
    VERIFICACAO VARCHAR2(2):= '0';
BEGIN
     SELECT COUNT(1)
     INTO V_COUNT
     FROM IFRMAXIMO.EQUIPAMENTO
     WHERE EQNUM = SUBSTR(:NEW.TOOLNUM,1,4);
   If v_count = 0 Then
      RAISE_APPLICATION_ERROR(-20652,'CÓDIGO INVÁLIDA - CONSULTE O PLANO DE GESTÃO.');
   end if;
   IF V_COUNT <> 0 THEN
      BEGIN
  SELECT A.NUMERO
  INTO V_NUMERO
  FROM IFRMAXIMO.NUMERO A
  WHERE A.NUMERO = SUBSTR(:NEW.TOOLNUM,5,4);
      EXCEPTION
     WHEN NO_DATA_FOUND THEN
     RAISE_APPLICATION_ERROR(-20653,'CÓDIGO INVÁLIDO - VERIFIQUE SEQUENCIAL NUMÉRICO.');
      END;
   END IF;
   BEGIN
      SELECT B.AEROPORTO
      INTO V_SIGLA
      FROM IFRMAXIMO.DEPENDENCIA B
      WHERE SUBSTR(B.AEROPORTO,3,2) = SUBSTR(:NEW.TOOLNUM,9,2);
   EXCEPTION
      WHEN NO_DATA_FOUND THEN
         RAISE_APPLICATION_ERROR(-20654,'CÓDIGO DA DEPENDÊNCIA INVÁLIDO.');
   END;
   BEGIN
      SELECT DISTINCT E.DESCRIPTION
      INTO :NEW.DESCRIPTION
      FROM EQUIPAMENTO E
      WHERE E.EQNUM = SUBSTR(:NEW.TOOLNUM,1,4)
       AND  E.SUBSISTEMA = 'INS'
       AND  E.SISTEMA   = 'IFE';
   EXCEPTION
      WHEN OTHERS THEN
         RAISE_APPLICATION_ERROR(-20655,'ERRO :',TRUE);
   END;
END;
/

-- End of DDL Script for Table IFRMAXIMO.TOOL

-- Start of DDL Script for Table IFRMAXIMO.TOOL_BKP
-- Generated 9-mar-2004 20:28:07 from SYSMAN@MAQUINA4

CREATE TABLE tool_bkp
    (rowstamp                       VARCHAR2(40) NOT NULL,
    toolnum                        VARCHAR2(16) NOT NULL,
    description                    VARCHAR2(120),
    toolqty                        NUMBER NOT NULL,
    stocked                        VARCHAR2(1) NOT NULL,
    toolrate                       NUMBER(10,2) NOT NULL,
    tl1                            VARCHAR2(10),
    tl2                            VARCHAR2(10),
    tl3                            VARCHAR2(10),
    tl4                            VARCHAR2(1),
    tl5                            VARCHAR2(1),
    ldkey                          NUMBER,
    outside                        VARCHAR2(1) NOT NULL,
    tl6                            VARCHAR2(10),
    tl7                            NUMBER(10,2),
    tl8                            VARCHAR2(10),
    glaccount                      VARCHAR2(20),
    controlacc                     VARCHAR2(20),
    vendor                         VARCHAR2(18),
    disabled                       VARCHAR2(1) NOT NULL,
    sourcesysid                    VARCHAR2(10),
    ownersysid                     VARCHAR2(10),
    externalrefid                  VARCHAR2(10),
    orgid                          VARCHAR2(8) NOT NULL)
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- End of DDL Script for Table IFRMAXIMO.TOOL_BKP

-- Start of DDL Script for Table IFRMAXIMO.TOOLTRANS
-- Generated 9-mar-2004 20:28:08 from SYSMAN@MAQUINA4

CREATE TABLE tooltrans
    (rowstamp                       VARCHAR2(40) NOT NULL,
    transdate                      DATE NOT NULL,
    toolnum                        VARCHAR2(16) NOT NULL,
    toolrate                       NUMBER(10,2) NOT NULL,
    eqnum                          VARCHAR2(12),
    toolqty                        NUMBER NOT NULL,
    toolhrs                        FLOAT(126) NOT NULL,
    enterdate                      DATE NOT NULL,
    enterby                        VARCHAR2(18) NOT NULL,
    tt1                            VARCHAR2(10),
    tt2                            VARCHAR2(10),
    tt3                            VARCHAR2(10),
    tt4                            NUMBER(10,2),
    tt5                            DATE,
    ldkey                          NUMBER,
    outside                        VARCHAR2(1) NOT NULL,
    rollup                         VARCHAR2(1) NOT NULL,
    gldebitacct                    VARCHAR2(20),
    linecost                       NUMBER(10,2) NOT NULL,
    glcreditacct                   VARCHAR2(20),
    financialperiod                VARCHAR2(6),
    location                       VARCHAR2(18),
    exchangerate2                  NUMBER(14,7),
    linecost2                      NUMBER(10,2),
    sourcesysid                    VARCHAR2(10),
    ownersysid                     VARCHAR2(10),
    externalrefid                  VARCHAR2(10),
    apiseq                         VARCHAR2(50),
    interid                        VARCHAR2(50),
    migchangeid                    VARCHAR2(50),
    sendersysid                    VARCHAR2(50),
    fincntrlid                     VARCHAR2(8),
    orgid                          VARCHAR2(8) NOT NULL,
    siteid                         VARCHAR2(8) NOT NULL,
    refwo                          VARCHAR2(18),
    enteredastask                  VARCHAR2(1) NOT NULL)
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Indexes for TOOLTRANS

CREATE INDEX tooltrans_ndx1 ON tooltrans
  (
    orgid                           ASC,
    toolnum                         ASC,
    transdate                       ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/
CREATE INDEX tooltrans_ndx2 ON tooltrans
  (
    orgid                           ASC,
    refwo                           ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/
CREATE INDEX tooltrans_ndx3 ON tooltrans
  (
    orgid                           ASC,
    eqnum                           ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/
CREATE INDEX tooltrans_ndx4 ON tooltrans
  (
    orgid                           ASC,
    enterdate                       ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/
CREATE INDEX tooltrans_ndx5 ON tooltrans
  (
    orgid                           ASC,
    interid                         ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/


-- Triggers for TOOLTRANS

CREATE TRIGGER tooltrans_t
BEFORE INSERT  OR UPDATE 
ON tooltrans
REFERENCING NEW AS NEW OLD AS OLD
FOR EACH ROW
DECLARE 
NEXTVAL INTEGER; BEGIN SELECT MAXSEQ.NEXTVAL INTO NEXTVAL FROM DUAL; 
:NEW.ROWSTAMP := NEXTVAL; END;
/

-- End of DDL Script for Table IFRMAXIMO.TOOLTRANS

-- Start of DDL Script for Table IFRMAXIMO.TRANSLATION
-- Generated 9-mar-2004 20:28:27 from SYSMAN@MAQUINA4

CREATE TABLE translation
    (rowstamp                       VARCHAR2(40) NOT NULL,
    tbname                         VARCHAR2(18) NOT NULL,
    name                           VARCHAR2(34) NOT NULL,
    langcode                       VARCHAR2(3) NOT NULL,
    ldkey                          NUMBER NOT NULL,
    transtext                      VARCHAR2(250),
    translongtext                  LONG)
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Indexes for TRANSLATION

CREATE UNIQUE INDEX trans_ndx1 ON translation
  (
    tbname                          ASC,
    name                            ASC,
    langcode                        ASC,
    ldkey                           ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/


-- Triggers for TRANSLATION

CREATE TRIGGER translation_t
BEFORE INSERT  OR UPDATE 
ON translation
REFERENCING NEW AS NEW OLD AS OLD
FOR EACH ROW
DECLARE 
NEXTVAL INTEGER; BEGIN SELECT MAXSEQ.NEXTVAL INTO NEXTVAL FROM DUAL; 
:NEW.ROWSTAMP := NEXTVAL; END;
/

-- End of DDL Script for Table IFRMAXIMO.TRANSLATION

-- Start of DDL Script for Table IFRMAXIMO.USERGROUPAUTH
-- Generated 9-mar-2004 20:28:34 from SYSMAN@MAQUINA4

CREATE TABLE usergroupauth
    (rowstamp                       VARCHAR2(40) NOT NULL,
    username                       VARCHAR2(18) NOT NULL,
    grpname                        VARCHAR2(18) NOT NULL)
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Indexes for USERGROUPAUTH

CREATE UNIQUE INDEX usergroupauth_ndx1 ON usergroupauth
  (
    username                        ASC,
    grpname                         ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/


-- Triggers for USERGROUPAUTH

CREATE TRIGGER usergroupauth_t
BEFORE INSERT  OR UPDATE 
ON usergroupauth
REFERENCING NEW AS NEW OLD AS OLD
FOR EACH ROW
DECLARE 
NEXTVAL INTEGER; BEGIN SELECT MAXSEQ.NEXTVAL INTO NEXTVAL FROM DUAL; 
:NEW.ROWSTAMP := NEXTVAL; END;
/

-- End of DDL Script for Table IFRMAXIMO.USERGROUPAUTH

-- Start of DDL Script for Table IFRMAXIMO.USERPREF
-- Generated 9-mar-2004 20:28:39 from SYSMAN@MAQUINA4

CREATE TABLE userpref
    (rowstamp                       VARCHAR2(40) NOT NULL,
    username                       VARCHAR2(18) NOT NULL,
    varname                        VARCHAR2(33) NOT NULL,
    varvalue                       VARCHAR2(254))
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Indexes for USERPREF

CREATE UNIQUE INDEX userpref_ndx ON userpref
  (
    username                        ASC,
    varname                         ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/


-- Triggers for USERPREF

CREATE TRIGGER userpref_t
BEFORE INSERT  OR UPDATE 
ON userpref
REFERENCING NEW AS NEW OLD AS OLD
FOR EACH ROW
DECLARE 
NEXTVAL INTEGER; BEGIN SELECT MAXSEQ.NEXTVAL INTO NEXTVAL FROM DUAL; 
:NEW.ROWSTAMP := NEXTVAL; END;
/

-- End of DDL Script for Table IFRMAXIMO.USERPREF

-- Start of DDL Script for Table IFRMAXIMO.USERRESTRICTIONS
-- Generated 9-mar-2004 20:28:45 from SYSMAN@MAQUINA4

CREATE TABLE userrestrictions
    (rowstamp                       VARCHAR2(40) NOT NULL,
    module                         VARCHAR2(10) NOT NULL,
    app                            VARCHAR2(10) NOT NULL,
    username                       VARCHAR2(18) NOT NULL,
    restrictions                   VARCHAR2(254))
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Indexes for USERRESTRICTIONS

CREATE UNIQUE INDEX restrictions_ndx ON userrestrictions
  (
    username                        ASC,
    app                             ASC,
    module                          ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/
CREATE INDEX userrestrct_ndx2 ON userrestrictions
  (
    app                             ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/


-- Triggers for USERRESTRICTIONS

CREATE TRIGGER userrestrictions_t
BEFORE INSERT  OR UPDATE 
ON userrestrictions
REFERENCING NEW AS NEW OLD AS OLD
FOR EACH ROW
DECLARE 
NEXTVAL INTEGER; BEGIN SELECT MAXSEQ.NEXTVAL INTO NEXTVAL FROM DUAL; 
:NEW.ROWSTAMP := NEXTVAL; END;
/

-- End of DDL Script for Table IFRMAXIMO.USERRESTRICTIONS

-- Start of DDL Script for Table IFRMAXIMO.USUARIO
-- Generated 9-mar-2004 20:28:55 from SYSMAN@MAQUINA4

CREATE TABLE usuario
    (usernum                        VARCHAR2(15) NOT NULL,
    description                    VARCHAR2(50),
    user01                         VARCHAR2(20),
    user02                         VARCHAR2(50),
    user03                         VARCHAR2(1),
    user04                         VARCHAR2(1),
    user05                         VARCHAR2(1))
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Constraints for USUARIO

ALTER TABLE usuario
ADD PRIMARY KEY (usernum)
USING INDEX
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/

-- End of DDL Script for Table IFRMAXIMO.USUARIO

-- Start of DDL Script for Table IFRMAXIMO.VALUELIST
-- Generated 9-mar-2004 20:29:00 from SYSMAN@MAQUINA4

CREATE TABLE valuelist
    (rowstamp                       VARCHAR2(40) NOT NULL,
    listname                       VARCHAR2(18) NOT NULL,
    value                          VARCHAR2(25) NOT NULL,
    maxvalue                       VARCHAR2(25),
    valdesc                        VARCHAR2(30),
    defaults                       VARCHAR2(1) NOT NULL,
    type                           NUMBER NOT NULL)
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Indexes for VALUELIST

CREATE UNIQUE INDEX valuelist_ndx1 ON valuelist
  (
    listname                        ASC,
    value                           ASC,
    maxvalue                        ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/
CREATE INDEX valuelist_ndx3 ON valuelist
  (
    maxvalue                        ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/


-- Triggers for VALUELIST

CREATE TRIGGER valuelist_t
BEFORE INSERT  OR UPDATE 
ON valuelist
REFERENCING NEW AS NEW OLD AS OLD
FOR EACH ROW
DECLARE 
NEXTVAL INTEGER; BEGIN SELECT MAXSEQ.NEXTVAL INTO NEXTVAL FROM DUAL; 
:NEW.ROWSTAMP := NEXTVAL; END;
/

-- End of DDL Script for Table IFRMAXIMO.VALUELIST

-- Start of DDL Script for Table IFRMAXIMO.VALUELISTDOMAIN
-- Generated 9-mar-2004 20:29:11 from SYSMAN@MAQUINA4

CREATE TABLE valuelistdomain
    (rowstamp                       VARCHAR2(40) NOT NULL,
    domainid                       VARCHAR2(18) NOT NULL,
    maxtype                        VARCHAR2(8) NOT NULL,
    length                         NUMBER NOT NULL,
    vltype                         NUMBER NOT NULL,
    changed                        VARCHAR2(1) NOT NULL,
    scale                          NUMBER NOT NULL)
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Indexes for VALUELISTDOMAIN

CREATE UNIQUE INDEX vldomain_ndx1 ON valuelistdomain
  (
    domainid                        ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/


-- Triggers for VALUELISTDOMAIN

CREATE TRIGGER valuelistdomain_t
BEFORE INSERT  OR UPDATE 
ON valuelistdomain
REFERENCING NEW AS NEW OLD AS OLD
FOR EACH ROW
DECLARE 
NEXTVAL INTEGER; BEGIN SELECT MAXSEQ.NEXTVAL INTO NEXTVAL FROM DUAL; 
:NEW.ROWSTAMP := NEXTVAL; END;
/

-- End of DDL Script for Table IFRMAXIMO.VALUELISTDOMAIN

-- Start of DDL Script for Table IFRMAXIMO.VENDORSTATUS
-- Generated 9-mar-2004 20:29:16 from SYSMAN@MAQUINA4

CREATE TABLE vendorstatus
    (rowstamp                       VARCHAR2(40) NOT NULL,
    ponum                          VARCHAR2(8) NOT NULL,
    polinenum                      NUMBER,
    status                         VARCHAR2(254) NOT NULL,
    description                    VARCHAR2(254),
    statusdate                     DATE NOT NULL,
    siteid                         VARCHAR2(8) NOT NULL,
    orgid                          VARCHAR2(8) NOT NULL)
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Indexes for VENDORSTATUS

CREATE INDEX vendorstatus_ndx1 ON vendorstatus
  (
    orgid                           ASC,
    statusdate                      ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/


-- Triggers for VENDORSTATUS

CREATE TRIGGER vendorstatus_t
BEFORE INSERT  OR UPDATE 
ON vendorstatus
REFERENCING NEW AS NEW OLD AS OLD
FOR EACH ROW
DECLARE 
NEXTVAL INTEGER; BEGIN SELECT MAXSEQ.NEXTVAL INTO NEXTVAL FROM DUAL; 
:NEW.ROWSTAMP := NEXTVAL; END;
/

-- End of DDL Script for Table IFRMAXIMO.VENDORSTATUS

-- Start of DDL Script for Table IFRMAXIMO.VERITYACTION
-- Generated 9-mar-2004 20:29:22 from SYSMAN@MAQUINA4

CREATE TABLE verityaction
    (rowstamp                       VARCHAR2(40) NOT NULL,
    itemnum                        VARCHAR2(30) NOT NULL,
    action                         VARCHAR2(2) NOT NULL,
    transid                        VARCHAR2(12) NOT NULL,
    orgid                          VARCHAR2(8) NOT NULL)
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Indexes for VERITYACTION

CREATE UNIQUE INDEX verityaction_ndx1 ON verityaction
  (
    orgid                           ASC,
    transid                         ASC,
    itemnum                         ASC,
    action                          ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/


-- Triggers for VERITYACTION

CREATE TRIGGER verityaction_t
BEFORE INSERT  OR UPDATE 
ON verityaction
REFERENCING NEW AS NEW OLD AS OLD
FOR EACH ROW
DECLARE 
NEXTVAL INTEGER; BEGIN SELECT MAXSEQ.NEXTVAL INTO NEXTVAL FROM DUAL; 
:NEW.ROWSTAMP := NEXTVAL; END;
/

-- End of DDL Script for Table IFRMAXIMO.VERITYACTION

-- Start of DDL Script for Table IFRMAXIMO.WFACTION
-- Generated 9-mar-2004 20:29:26 from SYSMAN@MAQUINA4

CREATE TABLE wfaction
    (rowstamp                       VARCHAR2(40) NOT NULL,
    actionid                       NUMBER NOT NULL,
    ownernodeid                    NUMBER NOT NULL,
    membernodeid                   NUMBER NOT NULL,
    actionvalue                    VARCHAR2(10),
    action                         VARCHAR2(10),
    instruction                    VARCHAR2(254),
    processid                      NUMBER NOT NULL,
    processrev                     NUMBER NOT NULL)
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Indexes for WFACTION

CREATE UNIQUE INDEX wfaction_ndx1 ON wfaction
  (
    processid                       ASC,
    actionid                        ASC,
    processrev                      ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/
CREATE INDEX wfaction_ndx2 ON wfaction
  (
    processid                       ASC,
    ownernodeid                     ASC,
    processrev                      ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/
CREATE INDEX wfaction_ndx3 ON wfaction
  (
    processid                       ASC,
    processrev                      ASC,
    membernodeid                    ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/


-- Triggers for WFACTION

CREATE TRIGGER wfaction_t
BEFORE INSERT  OR UPDATE 
ON wfaction
REFERENCING NEW AS NEW OLD AS OLD
FOR EACH ROW
DECLARE 
NEXTVAL INTEGER; BEGIN SELECT MAXSEQ.NEXTVAL INTO NEXTVAL FROM DUAL; 
:NEW.ROWSTAMP := NEXTVAL; END;
/

-- End of DDL Script for Table IFRMAXIMO.WFACTION

-- Start of DDL Script for Table IFRMAXIMO.WFACTIONLIST
-- Generated 9-mar-2004 20:29:40 from SYSMAN@MAQUINA4

CREATE TABLE wfactionlist
    (rowstamp                       VARCHAR2(40) NOT NULL,
    action                         VARCHAR2(10) NOT NULL,
    description                    VARCHAR2(50),
    actiontype                     VARCHAR2(20) NOT NULL,
    processtype                    VARCHAR2(13),
    actionstring                   VARCHAR2(254) NOT NULL)
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Indexes for WFACTIONLIST

CREATE UNIQUE INDEX wfactionlist_ndx1 ON wfactionlist
  (
    action                          ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/


-- Triggers for WFACTIONLIST

CREATE TRIGGER wfactionlist_t
BEFORE INSERT  OR UPDATE 
ON wfactionlist
REFERENCING NEW AS NEW OLD AS OLD
FOR EACH ROW
DECLARE 
NEXTVAL INTEGER; BEGIN SELECT MAXSEQ.NEXTVAL INTO NEXTVAL FROM DUAL; 
:NEW.ROWSTAMP := NEXTVAL; END;
/

-- End of DDL Script for Table IFRMAXIMO.WFACTIONLIST

-- Start of DDL Script for Table IFRMAXIMO.WFASSIGNMENT
-- Generated 9-mar-2004 20:29:45 from SYSMAN@MAQUINA4

CREATE TABLE wfassignment
    (rowstamp                       VARCHAR2(40) NOT NULL,
    assignid                       NUMBER NOT NULL,
    description                    VARCHAR2(50),
    ldkey                          NUMBER,
    priority                       NUMBER,
    assigntype                     VARCHAR2(14) NOT NULL,
    assigncode                     VARCHAR2(50),
    esctype                        VARCHAR2(14),
    esccode                        VARCHAR2(50),
    escaction                      VARCHAR2(10),
    app                            VARCHAR2(10),
    timelimit                      FLOAT(126),
    startdate                      DATE,
    duedate                        DATE,
    emailnotification              VARCHAR2(1) NOT NULL,
    assignstatus                   VARCHAR2(10),
    processname                    VARCHAR2(10),
    processid                      NUMBER NOT NULL,
    processtype                    VARCHAR2(16) NOT NULL,
    recordkey                      VARCHAR2(50),
    wfid                           NUMBER NOT NULL,
    nodeid                         NUMBER NOT NULL,
    assign_01                      VARCHAR2(1),
    assign_02                      VARCHAR2(1),
    assign_03                      VARCHAR2(1),
    assign_04                      VARCHAR2(1),
    assign_05                      VARCHAR2(1),
    processrev                     NUMBER NOT NULL,
    esclinkid                      NUMBER,
    origlabor                      VARCHAR2(12),
    orgid                          VARCHAR2(8),
    siteid                         VARCHAR2(8))
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Indexes for WFASSIGNMENT

CREATE INDEX wfassign_ndx3 ON wfassignment
  (
    wfid                            ASC,
    processid                       ASC,
    processrev                      ASC,
    nodeid                          ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/
CREATE INDEX wfassign_ndx4 ON wfassignment
  (
    assignstatus                    ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/
CREATE INDEX wfassign_ndx2 ON wfassignment
  (
    assigncode                      ASC,
    assignstatus                    ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/
CREATE UNIQUE INDEX wfassign_ndx1 ON wfassignment
  (
    assignid                        ASC,
    processid                       ASC,
    processrev                      ASC,
    wfid                            ASC,
    nodeid                          ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/


-- Triggers for WFASSIGNMENT

CREATE TRIGGER wfassignment_t
BEFORE INSERT  OR UPDATE 
ON wfassignment
REFERENCING NEW AS NEW OLD AS OLD
FOR EACH ROW
DECLARE 
NEXTVAL INTEGER; BEGIN SELECT MAXSEQ.NEXTVAL INTO NEXTVAL FROM DUAL; 
:NEW.ROWSTAMP := NEXTVAL; END;
/

-- End of DDL Script for Table IFRMAXIMO.WFASSIGNMENT

-- Start of DDL Script for Table IFRMAXIMO.WFCALLSTACK
-- Generated 9-mar-2004 20:30:02 from SYSMAN@MAQUINA4

CREATE TABLE wfcallstack
    (rowstamp                       VARCHAR2(40) NOT NULL,
    wfid                           NUMBER NOT NULL,
    nodeid                         NUMBER NOT NULL,
    processid                      NUMBER NOT NULL,
    callseq                        NUMBER NOT NULL,
    active                         VARCHAR2(1) NOT NULL,
    processrev                     NUMBER)
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Indexes for WFCALLSTACK

CREATE INDEX wfcallstack_ndx1 ON wfcallstack
  (
    wfid                            ASC,
    processid                       ASC,
    active                          ASC,
    processrev                      ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/
CREATE INDEX wfcallstack_ndx2 ON wfcallstack
  (
    wfid                            ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/
CREATE UNIQUE INDEX wfcallstack_ndx3 ON wfcallstack
  (
    wfid                            ASC,
    callseq                         ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/


-- Triggers for WFCALLSTACK

CREATE TRIGGER wfcallstack_t
BEFORE INSERT  OR UPDATE 
ON wfcallstack
REFERENCING NEW AS NEW OLD AS OLD
FOR EACH ROW
DECLARE 
NEXTVAL INTEGER; BEGIN SELECT MAXSEQ.NEXTVAL INTO NEXTVAL FROM DUAL; 
:NEW.ROWSTAMP := NEXTVAL; END;
/

-- End of DDL Script for Table IFRMAXIMO.WFCALLSTACK

-- Start of DDL Script for Table IFRMAXIMO.WFCONDITION
-- Generated 9-mar-2004 20:30:15 from SYSMAN@MAQUINA4

CREATE TABLE wfcondition
    (rowstamp                       VARCHAR2(40) NOT NULL,
    nodeid                         NUMBER NOT NULL,
    processid                      NUMBER NOT NULL,
    customclass                    VARCHAR2(80),
    condition                      VARCHAR2(254),
    processrev                     NUMBER NOT NULL,
    assignid                       NUMBER)
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Indexes for WFCONDITION

CREATE UNIQUE INDEX wfcondition_ndx1 ON wfcondition
  (
    processid                       ASC,
    nodeid                          ASC,
    processrev                      ASC,
    assignid                        ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/


-- Triggers for WFCONDITION

CREATE TRIGGER wfcondition_t
BEFORE INSERT  OR UPDATE 
ON wfcondition
REFERENCING NEW AS NEW OLD AS OLD
FOR EACH ROW
DECLARE 
NEXTVAL INTEGER; BEGIN SELECT MAXSEQ.NEXTVAL INTO NEXTVAL FROM DUAL; 
:NEW.ROWSTAMP := NEXTVAL; END;
/

-- End of DDL Script for Table IFRMAXIMO.WFCONDITION

-- Start of DDL Script for Table IFRMAXIMO.WFINPUT
-- Generated 9-mar-2004 20:30:21 from SYSMAN@MAQUINA4

CREATE TABLE wfinput
    (rowstamp                       VARCHAR2(40) NOT NULL,
    nodeid                         NUMBER NOT NULL,
    processid                      NUMBER NOT NULL,
    processrev                     NUMBER NOT NULL)
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Indexes for WFINPUT

CREATE UNIQUE INDEX wfinput_ndx1 ON wfinput
  (
    processid                       ASC,
    nodeid                          ASC,
    processrev                      ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/


-- Triggers for WFINPUT

CREATE TRIGGER wfinput_t
BEFORE INSERT  OR UPDATE 
ON wfinput
REFERENCING NEW AS NEW OLD AS OLD
FOR EACH ROW
DECLARE 
NEXTVAL INTEGER; BEGIN SELECT MAXSEQ.NEXTVAL INTO NEXTVAL FROM DUAL; 
:NEW.ROWSTAMP := NEXTVAL; END;
/

-- End of DDL Script for Table IFRMAXIMO.WFINPUT

-- Start of DDL Script for Table IFRMAXIMO.WFINSTANCE
-- Generated 9-mar-2004 20:30:27 from SYSMAN@MAQUINA4

CREATE TABLE wfinstance
    (rowstamp                       VARCHAR2(40) NOT NULL,
    active                         VARCHAR2(1) NOT NULL,
    wfid                           NUMBER NOT NULL,
    recordkey                      VARCHAR2(50),
    originator                     VARCHAR2(12) NOT NULL,
    maintbname                     VARCHAR2(18) NOT NULL,
    revision                       NUMBER NOT NULL,
    starttime                      DATE NOT NULL,
    currtaskstarttime              DATE NOT NULL,
    siteid                         VARCHAR2(8),
    orgid                          VARCHAR2(8))
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Indexes for WFINSTANCE

CREATE UNIQUE INDEX wfinstance_ndx1 ON wfinstance
  (
    wfid                            ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/


-- Triggers for WFINSTANCE

CREATE TRIGGER wfinstance_t
BEFORE INSERT  OR UPDATE 
ON wfinstance
REFERENCING NEW AS NEW OLD AS OLD
FOR EACH ROW
DECLARE 
NEXTVAL INTEGER; BEGIN SELECT MAXSEQ.NEXTVAL INTO NEXTVAL FROM DUAL; 
:NEW.ROWSTAMP := NEXTVAL; END;
/

-- End of DDL Script for Table IFRMAXIMO.WFINSTANCE

-- Start of DDL Script for Table IFRMAXIMO.WFNODE
-- Generated 9-mar-2004 20:30:34 from SYSMAN@MAQUINA4

CREATE TABLE wfnode
    (rowstamp                       VARCHAR2(40) NOT NULL,
    nodeid                         NUMBER NOT NULL,
    processid                      NUMBER NOT NULL,
    nodetype                       VARCHAR2(18) NOT NULL,
    xcoordinate                    NUMBER,
    ycoordinate                    NUMBER,
    imagefile                      VARCHAR2(254),
    title                          VARCHAR2(10),
    description                    VARCHAR2(50),
    ldkey                          NUMBER,
    node_01                        VARCHAR2(1),
    node_02                        VARCHAR2(1),
    node_03                        VARCHAR2(1),
    node_04                        VARCHAR2(1),
    node_05                        VARCHAR2(1),
    processrev                     NUMBER NOT NULL)
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Indexes for WFNODE

CREATE INDEX wfnode_ndx2 ON wfnode
  (
    processid                       ASC,
    processrev                      ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/
CREATE INDEX wfnode_ndx3 ON wfnode
  (
    processid                       ASC,
    processrev                      ASC,
    nodetype                        ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/
CREATE UNIQUE INDEX wfnode_ndx1 ON wfnode
  (
    processid                       ASC,
    nodeid                          ASC,
    processrev                      ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/


-- Triggers for WFNODE

CREATE TRIGGER wfnode_t
BEFORE INSERT  OR UPDATE 
ON wfnode
REFERENCING NEW AS NEW OLD AS OLD
FOR EACH ROW
DECLARE 
NEXTVAL INTEGER; BEGIN SELECT MAXSEQ.NEXTVAL INTO NEXTVAL FROM DUAL; 
:NEW.ROWSTAMP := NEXTVAL; END;
/

-- End of DDL Script for Table IFRMAXIMO.WFNODE

-- Start of DDL Script for Table IFRMAXIMO.WFNOTIFICATION
-- Generated 9-mar-2004 20:30:48 from SYSMAN@MAQUINA4

CREATE TABLE wfnotification
    (rowstamp                       VARCHAR2(40) NOT NULL,
    notificationid                 NUMBER NOT NULL,
    notifystatus                   VARCHAR2(10) NOT NULL,
    notifytype                     VARCHAR2(14) NOT NULL,
    notifycode                     VARCHAR2(50),
    nodeid                         NUMBER NOT NULL,
    processid                      NUMBER NOT NULL,
    wfid                           NUMBER NOT NULL,
    assignid                       NUMBER NOT NULL,
    actionid                       NUMBER NOT NULL,
    message                        VARCHAR2(254),
    subject                        VARCHAR2(254),
    notify_01                      VARCHAR2(1),
    notify_02                      VARCHAR2(1),
    notify_03                      VARCHAR2(1),
    notify_04                      VARCHAR2(1),
    notify_05                      VARCHAR2(1),
    processrev                     NUMBER NOT NULL)
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Indexes for WFNOTIFICATION

CREATE INDEX wfnotify_ndx2 ON wfnotification
  (
    wfid                            ASC,
    processid                       ASC,
    processrev                      ASC,
    nodeid                          ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/
CREATE INDEX wfnotify_ndx3 ON wfnotification
  (
    notifystatus                    ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/
CREATE UNIQUE INDEX wfnotify_ndx1 ON wfnotification
  (
    notificationid                  ASC,
    processid                       ASC,
    processrev                      ASC,
    wfid                            ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/


-- Triggers for WFNOTIFICATION

CREATE TRIGGER wfnotification_t
BEFORE INSERT  OR UPDATE 
ON wfnotification
REFERENCING NEW AS NEW OLD AS OLD
FOR EACH ROW
DECLARE 
NEXTVAL INTEGER; BEGIN SELECT MAXSEQ.NEXTVAL INTO NEXTVAL FROM DUAL; 
:NEW.ROWSTAMP := NEXTVAL; END;
/

-- End of DDL Script for Table IFRMAXIMO.WFNOTIFICATION

-- Start of DDL Script for Table IFRMAXIMO.WFPROCESS
-- Generated 9-mar-2004 20:31:00 from SYSMAN@MAQUINA4

CREATE TABLE wfprocess
    (rowstamp                       VARCHAR2(40) NOT NULL,
    processid                      NUMBER NOT NULL,
    processname                    VARCHAR2(10),
    description                    VARCHAR2(50),
    ldkey                          NUMBER,
    processtype                    VARCHAR2(13) NOT NULL,
    maintbname                     VARCHAR2(18) NOT NULL,
    enabled                        VARCHAR2(1) NOT NULL,
    defaultproc                    VARCHAR2(1) NOT NULL,
    processrev                     NUMBER NOT NULL,
    changeby                       VARCHAR2(18),
    changedate                     DATE,
    migrated                       VARCHAR2(1) NOT NULL)
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Indexes for WFPROCESS

CREATE INDEX wfprocess_ndx2 ON wfprocess
  (
    processtype                     ASC,
    enabled                         ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/
CREATE INDEX wfprocess_ndx3 ON wfprocess
  (
    migrated                        ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/
CREATE UNIQUE INDEX wfprocess_ndx1 ON wfprocess
  (
    processid                       ASC,
    processrev                      ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/


-- Triggers for WFPROCESS

CREATE TRIGGER wfprocess_t
BEFORE INSERT  OR UPDATE 
ON wfprocess
REFERENCING NEW AS NEW OLD AS OLD
FOR EACH ROW
DECLARE 
NEXTVAL INTEGER; BEGIN SELECT MAXSEQ.NEXTVAL INTO NEXTVAL FROM DUAL; 
:NEW.ROWSTAMP := NEXTVAL; END;
/

-- End of DDL Script for Table IFRMAXIMO.WFPROCESS

-- Start of DDL Script for Table IFRMAXIMO.WFREVISION
-- Generated 9-mar-2004 20:31:16 from SYSMAN@MAQUINA4

CREATE TABLE wfrevision
    (rowstamp                       VARCHAR2(40) NOT NULL,
    processid                      NUMBER NOT NULL,
    processrev                     NUMBER NOT NULL,
    revision                       NUMBER NOT NULL,
    processtype                    VARCHAR2(13) NOT NULL,
    maintbname                     VARCHAR2(18) NOT NULL,
    synchronizeby                  VARCHAR2(18),
    synchronizedate                DATE)
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Indexes for WFREVISION

CREATE INDEX wfrevision_ndx2 ON wfrevision
  (
    maintbname                      ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/
CREATE INDEX wfrevision_ndx3 ON wfrevision
  (
    revision                        ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/
CREATE UNIQUE INDEX wfrevision_ndx1 ON wfrevision
  (
    processtype                     ASC,
    revision                        ASC,
    processid                       ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/


-- Triggers for WFREVISION

CREATE TRIGGER wfrevision_t
BEFORE INSERT  OR UPDATE 
ON wfrevision
REFERENCING NEW AS NEW OLD AS OLD
FOR EACH ROW
DECLARE 
NEXTVAL INTEGER; BEGIN SELECT MAXSEQ.NEXTVAL INTO NEXTVAL FROM DUAL; 
:NEW.ROWSTAMP := NEXTVAL; END;
/

-- End of DDL Script for Table IFRMAXIMO.WFREVISION

-- Start of DDL Script for Table IFRMAXIMO.WFROLE
-- Generated 9-mar-2004 20:31:29 from SYSMAN@MAQUINA4

CREATE TABLE wfrole
    (rowstamp                       VARCHAR2(40) NOT NULL,
    roleid                         VARCHAR2(10) NOT NULL,
    description                    VARCHAR2(100),
    role_01                        VARCHAR2(1),
    role_02                        VARCHAR2(1),
    role_03                        VARCHAR2(1),
    role_04                        VARCHAR2(1),
    role_05                        VARCHAR2(1),
    roletype                       VARCHAR2(12) NOT NULL,
    value                          VARCHAR2(250) NOT NULL,
    assigntype                     VARCHAR2(14) NOT NULL)
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Indexes for WFROLE

CREATE UNIQUE INDEX wfrole_ndx1 ON wfrole
  (
    roleid                          ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/


-- Triggers for WFROLE

CREATE TRIGGER wfrole_t
BEFORE INSERT  OR UPDATE 
ON wfrole
REFERENCING NEW AS NEW OLD AS OLD
FOR EACH ROW
DECLARE 
NEXTVAL INTEGER; BEGIN SELECT MAXSEQ.NEXTVAL INTO NEXTVAL FROM DUAL; 
:NEW.ROWSTAMP := NEXTVAL; END;
/

-- End of DDL Script for Table IFRMAXIMO.WFROLE

-- Start of DDL Script for Table IFRMAXIMO.WFSTART
-- Generated 9-mar-2004 20:31:36 from SYSMAN@MAQUINA4

CREATE TABLE wfstart
    (rowstamp                       VARCHAR2(40) NOT NULL,
    nodeid                         NUMBER NOT NULL,
    processid                      NUMBER NOT NULL,
    processrev                     NUMBER NOT NULL)
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Indexes for WFSTART

CREATE UNIQUE INDEX wfstart_ndx1 ON wfstart
  (
    processid                       ASC,
    nodeid                          ASC,
    processrev                      ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/


-- Triggers for WFSTART

CREATE TRIGGER wfstart_t
BEFORE INSERT  OR UPDATE 
ON wfstart
REFERENCING NEW AS NEW OLD AS OLD
FOR EACH ROW
DECLARE 
NEXTVAL INTEGER; BEGIN SELECT MAXSEQ.NEXTVAL INTO NEXTVAL FROM DUAL; 
:NEW.ROWSTAMP := NEXTVAL; END;
/

-- End of DDL Script for Table IFRMAXIMO.WFSTART

-- Start of DDL Script for Table IFRMAXIMO.WFSTOP
-- Generated 9-mar-2004 20:31:43 from SYSMAN@MAQUINA4

CREATE TABLE wfstop
    (rowstamp                       VARCHAR2(40) NOT NULL,
    nodeid                         NUMBER NOT NULL,
    processid                      NUMBER NOT NULL,
    processrev                     NUMBER NOT NULL)
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Indexes for WFSTOP

CREATE UNIQUE INDEX wfstop_ndx1 ON wfstop
  (
    processid                       ASC,
    nodeid                          ASC,
    processrev                      ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/


-- Triggers for WFSTOP

CREATE TRIGGER wfstop_t
BEFORE INSERT  OR UPDATE 
ON wfstop
REFERENCING NEW AS NEW OLD AS OLD
FOR EACH ROW
DECLARE 
NEXTVAL INTEGER; BEGIN SELECT MAXSEQ.NEXTVAL INTO NEXTVAL FROM DUAL; 
:NEW.ROWSTAMP := NEXTVAL; END;
/

-- End of DDL Script for Table IFRMAXIMO.WFSTOP

-- Start of DDL Script for Table IFRMAXIMO.WFSUBPROCESS
-- Generated 9-mar-2004 20:31:48 from SYSMAN@MAQUINA4

CREATE TABLE wfsubprocess
    (rowstamp                       VARCHAR2(40) NOT NULL,
    nodeid                         NUMBER NOT NULL,
    processid                      NUMBER NOT NULL,
    subprocid                      NUMBER NOT NULL,
    processrev                     NUMBER NOT NULL)
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Indexes for WFSUBPROCESS

CREATE UNIQUE INDEX wfsubproc_ndx1 ON wfsubprocess
  (
    processid                       ASC,
    nodeid                          ASC,
    processrev                      ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/


-- Triggers for WFSUBPROCESS

CREATE TRIGGER wfsubprocess_t
BEFORE INSERT  OR UPDATE 
ON wfsubprocess
REFERENCING NEW AS NEW OLD AS OLD
FOR EACH ROW
DECLARE 
NEXTVAL INTEGER; BEGIN SELECT MAXSEQ.NEXTVAL INTO NEXTVAL FROM DUAL; 
:NEW.ROWSTAMP := NEXTVAL; END;
/

-- End of DDL Script for Table IFRMAXIMO.WFSUBPROCESS

-- Start of DDL Script for Table IFRMAXIMO.WFTASK
-- Generated 9-mar-2004 20:31:52 from SYSMAN@MAQUINA4

CREATE TABLE wftask
    (rowstamp                       VARCHAR2(40) NOT NULL,
    nodeid                         NUMBER NOT NULL,
    processid                      NUMBER NOT NULL,
    readonly                       VARCHAR2(1) NOT NULL,
    firstcomplete                  VARCHAR2(1) NOT NULL,
    app                            VARCHAR2(10),
    timelimit                      FLOAT(126),
    processrev                     NUMBER NOT NULL)
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Indexes for WFTASK

CREATE UNIQUE INDEX wftask_ndx1 ON wftask
  (
    processid                       ASC,
    nodeid                          ASC,
    processrev                      ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/


-- Triggers for WFTASK

CREATE TRIGGER wftask_t
BEFORE INSERT  OR UPDATE 
ON wftask
REFERENCING NEW AS NEW OLD AS OLD
FOR EACH ROW
DECLARE 
NEXTVAL INTEGER; BEGIN SELECT MAXSEQ.NEXTVAL INTO NEXTVAL FROM DUAL; 
:NEW.ROWSTAMP := NEXTVAL; END;
/

-- End of DDL Script for Table IFRMAXIMO.WFTASK

-- Start of DDL Script for Table IFRMAXIMO.WFTRANSACTION
-- Generated 9-mar-2004 20:31:58 from SYSMAN@MAQUINA4

CREATE TABLE wftransaction
    (rowstamp                       VARCHAR2(40) NOT NULL,
    transid                        NUMBER NOT NULL,
    nodeid                         NUMBER NOT NULL,
    processid                      NUMBER NOT NULL,
    wfid                           NUMBER NOT NULL,
    assignid                       NUMBER NOT NULL,
    transtype                      VARCHAR2(18) NOT NULL,
    transdate                      DATE NOT NULL,
    laborcode                      VARCHAR2(12),
    memo                           VARCHAR2(100),
    maintbname                     VARCHAR2(18) NOT NULL,
    recordkey                      VARCHAR2(50) NOT NULL,
    actionid                       NUMBER NOT NULL,
    nodetype                       VARCHAR2(18) NOT NULL,
    processrev                     NUMBER)
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Indexes for WFTRANSACTION

CREATE INDEX wftransaction_ndx1 ON wftransaction
  (
    nodeid                          ASC,
    processid                       ASC,
    wfid                            ASC,
    transdate                       ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/
CREATE UNIQUE INDEX wftransaction_ndx2 ON wftransaction
  (
    transid                         ASC,
    nodeid                          ASC,
    processid                       ASC,
    wfid                            ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/


-- Triggers for WFTRANSACTION

CREATE TRIGGER wftransaction_t
BEFORE INSERT  OR UPDATE 
ON wftransaction
REFERENCING NEW AS NEW OLD AS OLD
FOR EACH ROW
DECLARE 
NEXTVAL INTEGER; BEGIN SELECT MAXSEQ.NEXTVAL INTO NEXTVAL FROM DUAL; 
:NEW.ROWSTAMP := NEXTVAL; END;
/

-- End of DDL Script for Table IFRMAXIMO.WFTRANSACTION

-- Start of DDL Script for Table IFRMAXIMO.WOANCESTOR
-- Generated 9-mar-2004 20:32:05 from SYSMAN@MAQUINA4

CREATE TABLE woancestor
    (rowstamp                       VARCHAR2(40) NOT NULL,
    wonum                          VARCHAR2(18) NOT NULL,
    ancestor                       VARCHAR2(18) NOT NULL,
    hierarchylevels                NUMBER NOT NULL,
    orgid                          VARCHAR2(8) NOT NULL,
    siteid                         VARCHAR2(8) NOT NULL)
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Indexes for WOANCESTOR

CREATE UNIQUE INDEX woancestor_ndx1 ON woancestor
  (
    siteid                          ASC,
    wonum                           ASC,
    ancestor                        ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/
CREATE INDEX woancestor_ndx2 ON woancestor
  (
    siteid                          ASC,
    ancestor                        ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/
CREATE INDEX woancestor_ndx4 ON woancestor
  (
    wonum                           ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/


-- Triggers for WOANCESTOR

CREATE TRIGGER woancestor_t
BEFORE INSERT  OR UPDATE 
ON woancestor
REFERENCING NEW AS NEW OLD AS OLD
FOR EACH ROW
DECLARE 
NEXTVAL INTEGER; BEGIN SELECT MAXSEQ.NEXTVAL INTO NEXTVAL FROM DUAL; 
:NEW.ROWSTAMP := NEXTVAL; END;
/

-- End of DDL Script for Table IFRMAXIMO.WOANCESTOR

-- Start of DDL Script for Table IFRMAXIMO.WOASSIGNMNTPARTY
-- Generated 9-mar-2004 20:32:20 from SYSMAN@MAQUINA4

CREATE TABLE woassignmntparty
    (rowstamp                       VARCHAR2(40) NOT NULL,
    woassignmntqueueid             VARCHAR2(25) NOT NULL,
    resppartygroup                 VARCHAR2(12) NOT NULL,
    respparty                      VARCHAR2(12) NOT NULL,
    resppartygroupseq              NUMBER NOT NULL,
    resppartyseq                   NUMBER NOT NULL,
    orgid                          VARCHAR2(8) NOT NULL,
    siteid                         VARCHAR2(8) NOT NULL)
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Indexes for WOASSIGNMNTPARTY

CREATE UNIQUE INDEX woassignparty_ndx1 ON woassignmntparty
  (
    siteid                          ASC,
    woassignmntqueueid              ASC,
    resppartygroup                  ASC,
    respparty                       ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/
CREATE INDEX woassignparty_ndx2 ON woassignmntparty
  (
    siteid                          ASC,
    woassignmntqueueid              ASC,
    resppartygroupseq               ASC,
    resppartyseq                    ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/


-- Triggers for WOASSIGNMNTPARTY

CREATE TRIGGER woassignmntparty_t
BEFORE INSERT  OR UPDATE 
ON woassignmntparty
REFERENCING NEW AS NEW OLD AS OLD
FOR EACH ROW
DECLARE 
NEXTVAL INTEGER; BEGIN SELECT MAXSEQ.NEXTVAL INTO NEXTVAL FROM DUAL; 
:NEW.ROWSTAMP := NEXTVAL; END;
/

-- End of DDL Script for Table IFRMAXIMO.WOASSIGNMNTPARTY

-- Start of DDL Script for Table IFRMAXIMO.WOASSIGNMNTQUEUE
-- Generated 9-mar-2004 20:32:31 from SYSMAN@MAQUINA4

CREATE TABLE woassignmntqueue
    (rowstamp                       VARCHAR2(40) NOT NULL,
    woassignmntqueueid             VARCHAR2(25) NOT NULL,
    description                    VARCHAR2(50),
    worklocation                   VARCHAR2(18),
    wq1                            VARCHAR2(1),
    wq2                            VARCHAR2(1),
    wq3                            VARCHAR2(1),
    wq4                            VARCHAR2(1),
    wq5                            VARCHAR2(1),
    ldkey                          NUMBER,
    defaultassignee                VARCHAR2(12),
    orgid                          VARCHAR2(8) NOT NULL,
    siteid                         VARCHAR2(8) NOT NULL)
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Indexes for WOASSIGNMNTQUEUE

CREATE UNIQUE INDEX woassignqueue_ndx1 ON woassignmntqueue
  (
    siteid                          ASC,
    woassignmntqueueid              ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/


-- Triggers for WOASSIGNMNTQUEUE

CREATE TRIGGER woassignmntqueue_t
BEFORE INSERT  OR UPDATE 
ON woassignmntqueue
REFERENCING NEW AS NEW OLD AS OLD
FOR EACH ROW
DECLARE 
NEXTVAL INTEGER; BEGIN SELECT MAXSEQ.NEXTVAL INTO NEXTVAL FROM DUAL; 
:NEW.ROWSTAMP := NEXTVAL; END;
/

-- End of DDL Script for Table IFRMAXIMO.WOASSIGNMNTQUEUE

-- Start of DDL Script for Table IFRMAXIMO.WOGEN
-- Generated 9-mar-2004 20:32:36 from SYSMAN@MAQUINA4

CREATE TABLE wogen
    (rowstamp                       VARCHAR2(40) NOT NULL,
    runid                          NUMBER NOT NULL,
    rundate                        DATE NOT NULL,
    runorder                       NUMBER NOT NULL,
    parent                         VARCHAR2(18),
    status                         VARCHAR2(8) NOT NULL,
    worktype                       VARCHAR2(7),
    description                    VARCHAR2(200),
    eqnum                          VARCHAR2(12),
    location                       VARCHAR2(18),
    jpnum                          VARCHAR2(30),
    pmnum                          VARCHAR2(16),
    wopriority                     NUMBER,
    targstartdate                  DATE,
    ldkey                          NUMBER,
    calendar                       VARCHAR2(8),
    interruptable                  VARCHAR2(1) NOT NULL,
    downtime                       VARCHAR2(1) NOT NULL,
    crewid                         VARCHAR2(12),
    supervisor                     VARCHAR2(12),
    calcpriority                   NUMBER,
    wosequence                     NUMBER,
    pmduedate                      DATE,
    pmextdate                      DATE,
    pmnextduedate                  DATE,
    orgid                          VARCHAR2(8) NOT NULL,
    siteid                         VARCHAR2(8) NOT NULL,
    glaccount                      VARCHAR2(20),
    changechildstatus              VARCHAR2(1) NOT NULL,
    wopm1                          VARCHAR2(10),
    wopm2                          VARCHAR2(10),
    wopm3                          VARCHAR2(10),
    wopm4                          NUMBER(10,2),
    wopm5                          VARCHAR2(10),
    wopm6                          VARCHAR2(25),
    wopm7                          VARCHAR2(4),
    route                          VARCHAR2(16),
    storeloc                       VARCHAR2(18))
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Indexes for WOGEN

CREATE UNIQUE INDEX wogen_ndx1 ON wogen
  (
    siteid                          ASC,
    runid                           ASC,
    runorder                        ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/


-- Triggers for WOGEN

CREATE TRIGGER wogen_t
BEFORE INSERT  OR UPDATE 
ON wogen
REFERENCING NEW AS NEW OLD AS OLD
FOR EACH ROW
DECLARE 
NEXTVAL INTEGER; BEGIN SELECT MAXSEQ.NEXTVAL INTO NEXTVAL FROM DUAL; 
:NEW.ROWSTAMP := NEXTVAL; END;
/

-- End of DDL Script for Table IFRMAXIMO.WOGEN

-- Start of DDL Script for Table IFRMAXIMO.WOHAZARD
-- Generated 9-mar-2004 20:32:42 from SYSMAN@MAQUINA4

CREATE TABLE wohazard
    (rowstamp                       VARCHAR2(40) NOT NULL,
    wonum                          VARCHAR2(18) NOT NULL,
    hazardid                       VARCHAR2(8) NOT NULL,
    description                    VARCHAR2(50),
    ldkey                          NUMBER,
    precautionenabled              VARCHAR2(1) NOT NULL,
    hazmatenabled                  VARCHAR2(1) NOT NULL,
    tagoutenabled                  VARCHAR2(1) NOT NULL,
    hazardtype                     VARCHAR2(16),
    msdsnum                        VARCHAR2(10),
    healthrating                   NUMBER,
    flammabilityrating             NUMBER,
    reactivityrating               NUMBER,
    contactrating                  NUMBER,
    wosafetydatasource             VARCHAR2(2) NOT NULL,
    haz01                          VARCHAR2(10),
    haz02                          VARCHAR2(10),
    haz03                          VARCHAR2(10),
    haz04                          VARCHAR2(10),
    haz05                          VARCHAR2(10),
    haz06                          VARCHAR2(10),
    haz07                          VARCHAR2(10),
    haz08                          VARCHAR2(10),
    haz09                          VARCHAR2(10),
    haz10                          VARCHAR2(10),
    haz11                          NUMBER(10,2),
    haz12                          NUMBER(10,2),
    haz13                          DATE,
    haz14                          DATE,
    haz15                          NUMBER(15,2),
    haz16                          NUMBER(15,2),
    haz17                          VARCHAR2(10),
    haz18                          VARCHAR2(10),
    haz19                          NUMBER,
    haz20                          VARCHAR2(1),
    orgid                          VARCHAR2(8) NOT NULL,
    siteid                         VARCHAR2(8) NOT NULL)
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Indexes for WOHAZARD

CREATE UNIQUE INDEX wohazard_ndx1 ON wohazard
  (
    siteid                          ASC,
    wonum                           ASC,
    hazardid                        ASC,
    wosafetydatasource              ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/


-- Triggers for WOHAZARD

CREATE TRIGGER wohazard_t
BEFORE INSERT  OR UPDATE 
ON wohazard
REFERENCING NEW AS NEW OLD AS OLD
FOR EACH ROW
DECLARE 
NEXTVAL INTEGER; BEGIN SELECT MAXSEQ.NEXTVAL INTO NEXTVAL FROM DUAL; 
:NEW.ROWSTAMP := NEXTVAL; END;
/

-- End of DDL Script for Table IFRMAXIMO.WOHAZARD

-- Start of DDL Script for Table IFRMAXIMO.WOHAZARDPREC
-- Generated 9-mar-2004 20:32:48 from SYSMAN@MAQUINA4

CREATE TABLE wohazardprec
    (rowstamp                       VARCHAR2(40) NOT NULL,
    wonum                          VARCHAR2(18) NOT NULL,
    hazardid                       VARCHAR2(8) NOT NULL,
    precautionid                   VARCHAR2(10) NOT NULL,
    wosafetydatasource             VARCHAR2(2) NOT NULL,
    orgid                          VARCHAR2(8) NOT NULL,
    siteid                         VARCHAR2(8) NOT NULL)
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Indexes for WOHAZARDPREC

CREATE UNIQUE INDEX wohazardprec_ndx1 ON wohazardprec
  (
    siteid                          ASC,
    wonum                           ASC,
    hazardid                        ASC,
    precautionid                    ASC,
    wosafetydatasource              ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/


-- Triggers for WOHAZARDPREC

CREATE TRIGGER wohazardprec_t
BEFORE INSERT  OR UPDATE 
ON wohazardprec
REFERENCING NEW AS NEW OLD AS OLD
FOR EACH ROW
DECLARE NEXTVAL INTEGER; BEGIN SELECT MAXSEQ.NEXTVAL INTO NEXTVAL FROM DUAL; :NEW.ROWSTAMP := NEXTVAL; END;
/

-- End of DDL Script for Table IFRMAXIMO.WOHAZARDPREC

-- Start of DDL Script for Table IFRMAXIMO.WOHISTORICO
-- Generated 9-mar-2004 20:32:54 from SYSMAN@MAQUINA4

CREATE TABLE wohistorico
    (rowstamp                       VARCHAR2(40) NOT NULL,
    wonum                          VARCHAR2(18) NOT NULL,
    parent                         VARCHAR2(18),
    status                         VARCHAR2(8) NOT NULL,
    statusdate                     DATE NOT NULL,
    worktype                       VARCHAR2(7),
    leadcraft                      VARCHAR2(12),
    description                    VARCHAR2(200),
    eqnum                          VARCHAR2(12),
    location                       VARCHAR2(18),
    jpnum                          VARCHAR2(30),
    faildate                       DATE,
    changeby                       VARCHAR2(18),
    changedate                     DATE,
    estdur                         FLOAT(126) NOT NULL,
    estlabhrs                      FLOAT(126) NOT NULL,
    estmatcost                     NUMBER(10,2) NOT NULL,
    estlabcost                     NUMBER(10,2) NOT NULL,
    esttoolcost                    NUMBER(10,2) NOT NULL,
    pmnum                          VARCHAR2(16),
    actlabhrs                      FLOAT(126) NOT NULL,
    actmatcost                     NUMBER(10,2) NOT NULL,
    actlabcost                     NUMBER(10,2) NOT NULL,
    acttoolcost                    NUMBER(10,2) NOT NULL,
    haschildren                    VARCHAR2(1) NOT NULL,
    outlabcost                     NUMBER(10,2) NOT NULL,
    outmatcost                     NUMBER(10,2) NOT NULL,
    outtoolcost                    NUMBER(10,2) NOT NULL,
    historyflag                    VARCHAR2(1) NOT NULL,
    contract                       VARCHAR2(10),
    wopriority                     NUMBER,
    wopm6                          VARCHAR2(25),
    wopm7                          VARCHAR2(4),
    targcompdate                   DATE,
    targstartdate                  DATE,
    woeq1                          VARCHAR2(1),
    woeq2                          VARCHAR2(50),
    woeq3                          VARCHAR2(1),
    woeq4                          VARCHAR2(1),
    woeq5                          VARCHAR2(1),
    woeq6                          VARCHAR2(1),
    woeq7                          NUMBER(15,2),
    woeq8                          VARCHAR2(3),
    woeq9                          VARCHAR2(10),
    woeq10                         VARCHAR2(3),
    woeq11                         VARCHAR2(3),
    woeq12                         VARCHAR2(3),
    wo1                            VARCHAR2(12),
    wo2                            VARCHAR2(120),
    wo3                            FLOAT(126),
    wo4                            NUMBER(10,2),
    wo5                            NUMBER(10,2),
    wo6                            NUMBER(10,2),
    wo7                            NUMBER(10,2),
    wo8                            NUMBER(10,2),
    wo9                            VARCHAR2(4),
    wo10                           NUMBER(10,2),
    ldkey                          NUMBER,
    reportedby                     VARCHAR2(18),
    reportdate                     DATE,
    phone                          VARCHAR2(20),
    problemcode                    VARCHAR2(8),
    calendar                       VARCHAR2(8),
    interruptable                  VARCHAR2(1) NOT NULL,
    downtime                       VARCHAR2(1) NOT NULL,
    actstart                       DATE,
    actfinish                      DATE,
    schedstart                     DATE,
    schedfinish                    DATE,
    remdur                         FLOAT(126),
    crewid                         VARCHAR2(12),
    supervisor                     VARCHAR2(12),
    woeq13                         DATE,
    woeq14                         NUMBER(15,2),
    wopm1                          VARCHAR2(10),
    wopm2                          VARCHAR2(10),
    wopm3                          VARCHAR2(10),
    wopm4                          NUMBER(10,2),
    wopm5                          VARCHAR2(10),
    wojp1                          VARCHAR2(10),
    wojp2                          VARCHAR2(10),
    wojp3                          VARCHAR2(10),
    wojp4                          NUMBER(10,2),
    wojp5                          VARCHAR2(10),
    wol1                           VARCHAR2(10),
    wol2                           VARCHAR2(10),
    wol3                           NUMBER(10,2),
    wol4                           DATE,
    wolablnk                       VARCHAR2(12),
    respondby                      DATE,
    eqlocpriority                  NUMBER,
    calcpriority                   NUMBER,
    chargestore                    VARCHAR2(1) NOT NULL,
    failurecode                    VARCHAR2(8),
    wolo1                          VARCHAR2(10),
    wolo2                          VARCHAR2(10),
    wolo3                          VARCHAR2(10),
    wolo4                          VARCHAR2(10),
    wolo5                          VARCHAR2(10),
    wolo6                          NUMBER(10,2),
    wolo7                          DATE,
    wolo8                          NUMBER(15,2),
    wolo9                          VARCHAR2(10),
    wolo10                         NUMBER,
    glaccount                      VARCHAR2(20),
    estservcost                    NUMBER(10,2) NOT NULL,
    actservcost                    NUMBER(10,2) NOT NULL,
    disabled                       VARCHAR2(1) NOT NULL,
    estatapprlabhrs                FLOAT(126) NOT NULL,
    estatapprlabcost               NUMBER(10,2) NOT NULL,
    estatapprmatcost               NUMBER(10,2) NOT NULL,
    estatapprtoolcost              NUMBER(10,2) NOT NULL,
    estatapprservcost              NUMBER(10,2) NOT NULL,
    wosequence                     NUMBER,
    hasfollowupwork                VARCHAR2(1) NOT NULL,
    worts1                         VARCHAR2(10),
    worts2                         VARCHAR2(10),
    worts3                         VARCHAR2(10),
    worts4                         DATE,
    worts5                         NUMBER(15,2),
    wfid                           NUMBER,
    wfactive                       VARCHAR2(1) NOT NULL,
    followupfromwonum              VARCHAR2(18),
    pmduedate                      DATE,
    pmextdate                      DATE,
    pmnextduedate                  DATE,
    woassignmntqueueid             VARCHAR2(25),
    worklocation                   VARCHAR2(18),
    wowq1                          VARCHAR2(1),
    wowq2                          VARCHAR2(1),
    wowq3                          VARCHAR2(1),
    wojp6                          VARCHAR2(10),
    wojp7                          VARCHAR2(10),
    wojp8                          VARCHAR2(10),
    wojp9                          NUMBER(10,2),
    wojp10                         DATE,
    wo11                           NUMBER(10,2),
    wo12                           NUMBER(10,2),
    wo13                           VARCHAR2(3),
    wo14                           VARCHAR2(3),
    wo15                           NUMBER(10,2),
    wo16                           NUMBER(10,2),
    wo17                           FLOAT(126),
    wo18                           FLOAT(126),
    wo19                           FLOAT(126),
    wo20                           VARCHAR2(4),
    sourcesysid                    VARCHAR2(10),
    ownersysid                     VARCHAR2(10),
    externalrefid                  VARCHAR2(10),
    apiseq                         VARCHAR2(50),
    interid                        VARCHAR2(50),
    migchangeid                    VARCHAR2(50),
    sendersysid                    VARCHAR2(50),
    expdone                        VARCHAR2(25),
    fincntrlid                     VARCHAR2(8),
    generatedforpo                 VARCHAR2(8),
    genforpolineid                 NUMBER,
    orgid                          VARCHAR2(8) NOT NULL,
    siteid                         VARCHAR2(8) NOT NULL,
    taskid                         NUMBER,
    inspector                      VARCHAR2(12),
    measurementvalue               NUMBER(15,3),
    measuredate                    DATE,
    observation                    VARCHAR2(8),
    pointnum                       VARCHAR2(16),
    wojo1                          VARCHAR2(10),
    wojo2                          VARCHAR2(10),
    wojo3                          VARCHAR2(10),
    wojo4                          NUMBER(15,2),
    wojo5                          VARCHAR2(10),
    wojo6                          VARCHAR2(10),
    wojo7                          VARCHAR2(10),
    wojo8                          VARCHAR2(10),
    changechildstatus              VARCHAR2(1) NOT NULL,
    istask                         VARCHAR2(1) NOT NULL)
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Indexes for WOHISTORICO

CREATE INDEX wohistorico_ndx2 ON wohistorico
  (
    siteid                          ASC,
    status                          ASC
  )
  PCTFREE     0
  INITRANS    2
  MAXTRANS    255
PARALLEL (DEGREE DEFAULT)
/
CREATE INDEX wohistorico_ndx3 ON wohistorico
  (
    siteid                          ASC,
    historyflag                     ASC
  )
  PCTFREE     0
  INITRANS    2
  MAXTRANS    255
PARALLEL (DEGREE DEFAULT)
/
CREATE INDEX wohistorico_ndx6 ON wohistorico
  (
    siteid                          ASC,
    respondby                       ASC
  )
  PCTFREE     0
  INITRANS    2
  MAXTRANS    255
PARALLEL (DEGREE DEFAULT)
/
CREATE INDEX wohistorico_ndx9 ON wohistorico
  (
    siteid                          ASC,
    location                        ASC,
    problemcode                     ASC,
    status                          ASC
  )
  PCTFREE     0
  INITRANS    2
  MAXTRANS    255
PARALLEL (DEGREE DEFAULT)
/
CREATE INDEX wohistorico_ndx17 ON wohistorico
  (
    ldkey                           ASC
  )
  PCTFREE     0
  INITRANS    2
  MAXTRANS    255
PARALLEL (DEGREE DEFAULT)
/
CREATE INDEX wohistorico_ndx11 ON wohistorico
  (
    wopm7                           ASC,
    siteid                          ASC
  )
  PCTFREE     0
  INITRANS    2
  MAXTRANS    255
PARALLEL (DEGREE DEFAULT)
/
CREATE UNIQUE INDEX wohistorico_ndx12 ON wohistorico
  (
    wonum                           ASC,
    istask                          ASC,
    historyflag                     ASC
  )
  PCTFREE     0
  INITRANS    2
  MAXTRANS    255
PARALLEL (DEGREE DEFAULT)
/
CREATE INDEX wohistorico_ndx13 ON wohistorico
  (
    siteid                          ASC,
    istask                          ASC,
    historyflag                     ASC
  )
  PCTFREE     0
  INITRANS    2
  MAXTRANS    255
PARALLEL (DEGREE DEFAULT)
/
CREATE INDEX wohistorico_ndx10 ON wohistorico
  (
    parent                          ASC,
    siteid                          ASC
  )
  PCTFREE     0
  INITRANS    2
  MAXTRANS    255
PARALLEL (DEGREE DEFAULT)
/
CREATE INDEX wohistorico_ndx14 ON wohistorico
  (
    historyflag                     ASC,
    istask                          ASC,
    wopm7                           ASC,
    siteid                          ASC
  )
  PCTFREE     0
  INITRANS    2
  MAXTRANS    255
PARALLEL (DEGREE DEFAULT)
/
CREATE INDEX wohistorico_ndx15 ON wohistorico
  (
    wopm6                           ASC,
    siteid                          ASC
  )
  PCTFREE     0
  INITRANS    2
  MAXTRANS    255
PARALLEL (DEGREE DEFAULT)
/
CREATE INDEX wohistorico_ndx16 ON wohistorico
  (
    siteid                          ASC,
    crewid                          ASC
  )
  PCTFREE     0
  INITRANS    2
  MAXTRANS    255
PARALLEL (DEGREE DEFAULT)
/
CREATE UNIQUE INDEX wohistorico_ndx1 ON wohistorico
  (
    siteid                          ASC,
    wonum                           ASC
  )
  PCTFREE     0
  INITRANS    2
  MAXTRANS    255
PARALLEL (DEGREE DEFAULT)
/
CREATE INDEX wohistorico_ndx18 ON wohistorico
  (
    siteid                          ASC,
    crewid                          ASC,
    status                          ASC
  )
  PCTFREE     0
  INITRANS    2
  MAXTRANS    255
PARALLEL (DEGREE DEFAULT)
/
CREATE INDEX wohistorico_ndx4 ON wohistorico
  (
    siteid                          ASC,
    interid                         ASC
  )
  PCTFREE     0
  INITRANS    2
  MAXTRANS    255
PARALLEL (DEGREE DEFAULT)
/
CREATE INDEX wohistorico_ndx5 ON wohistorico
  (
    siteid                          ASC,
    wfid                            ASC
  )
  PCTFREE     0
  INITRANS    2
  MAXTRANS    255
PARALLEL (DEGREE DEFAULT)
/
CREATE INDEX wohistorico_ndx7 ON wohistorico
  (
    siteid                          ASC,
    eqnum                           ASC,
    problemcode                     ASC,
    status                          ASC
  )
  PCTFREE     0
  INITRANS    2
  MAXTRANS    255
PARALLEL (DEGREE DEFAULT)
/
CREATE INDEX wohistorico_ndx8 ON wohistorico
  (
    siteid                          ASC,
    jpnum                           ASC
  )
  PCTFREE     0
  INITRANS    2
  MAXTRANS    255
PARALLEL (DEGREE DEFAULT)
/


-- End of DDL Script for Table IFRMAXIMO.WOHISTORICO

-- Start of DDL Script for Table IFRMAXIMO.WOLOCKOUT
-- Generated 9-mar-2004 20:34:06 from SYSMAN@MAQUINA4

CREATE TABLE wolockout
    (rowstamp                       VARCHAR2(40) NOT NULL,
    wonum                          VARCHAR2(18) NOT NULL,
    lockoutid                      VARCHAR2(20) NOT NULL,
    description                    VARCHAR2(50),
    ldkey                          NUMBER,
    location                       VARCHAR2(18),
    eqnum                          VARCHAR2(12),
    devicedescription              VARCHAR2(50),
    requiredstate                  VARCHAR2(16),
    wosafetydatasource             VARCHAR2(2) NOT NULL,
    lck01                          VARCHAR2(10),
    lck02                          VARCHAR2(10),
    lck03                          VARCHAR2(10),
    lck04                          VARCHAR2(10),
    lck05                          VARCHAR2(10),
    lck06                          NUMBER(10,2),
    lck07                          DATE,
    lck08                          NUMBER(15,2),
    lck09                          VARCHAR2(10),
    lck10                          NUMBER,
    orgid                          VARCHAR2(8) NOT NULL,
    siteid                         VARCHAR2(8) NOT NULL)
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Indexes for WOLOCKOUT

CREATE UNIQUE INDEX wolockout_ndx1 ON wolockout
  (
    siteid                          ASC,
    wonum                           ASC,
    lockoutid                       ASC,
    wosafetydatasource              ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/


-- Triggers for WOLOCKOUT

CREATE TRIGGER wolockout_t
BEFORE INSERT  OR UPDATE 
ON wolockout
REFERENCING NEW AS NEW OLD AS OLD
FOR EACH ROW
DECLARE 
NEXTVAL INTEGER; BEGIN SELECT MAXSEQ.NEXTVAL INTO NEXTVAL FROM DUAL; 
:NEW.ROWSTAMP := NEXTVAL; END;
/

-- End of DDL Script for Table IFRMAXIMO.WOLOCKOUT

-- Start of DDL Script for Table IFRMAXIMO.WOPRECAUTION
-- Generated 9-mar-2004 20:34:14 from SYSMAN@MAQUINA4

CREATE TABLE woprecaution
    (rowstamp                       VARCHAR2(40) NOT NULL,
    wonum                          VARCHAR2(18) NOT NULL,
    precautionid                   VARCHAR2(10) NOT NULL,
    description                    VARCHAR2(120),
    ldkey                          NUMBER,
    wosafetydatasource             VARCHAR2(2) NOT NULL,
    prec01                         VARCHAR2(10),
    prec02                         VARCHAR2(10),
    prec03                         VARCHAR2(10),
    prec04                         VARCHAR2(10),
    prec05                         VARCHAR2(10),
    prec06                         NUMBER(10,2),
    prec07                         DATE,
    prec08                         NUMBER(15,2),
    prec09                         VARCHAR2(10),
    prec10                         VARCHAR2(1),
    orgid                          VARCHAR2(8) NOT NULL,
    siteid                         VARCHAR2(8) NOT NULL)
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Indexes for WOPRECAUTION

CREATE UNIQUE INDEX woprecaution_ndx1 ON woprecaution
  (
    siteid                          ASC,
    wonum                           ASC,
    precautionid                    ASC,
    wosafetydatasource              ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/


-- Triggers for WOPRECAUTION

CREATE TRIGGER woprecaution_t
BEFORE INSERT  OR UPDATE 
ON woprecaution
REFERENCING NEW AS NEW OLD AS OLD
FOR EACH ROW
DECLARE NEXTVAL INTEGER; BEGIN SELECT MAXSEQ.NEXTVAL INTO NEXTVAL FROM DUAL; :NEW.ROWSTAMP := NEXTVAL; END;
/

-- End of DDL Script for Table IFRMAXIMO.WOPRECAUTION

-- Start of DDL Script for Table IFRMAXIMO.WORKORDER
-- Generated 9-mar-2004 20:34:21 from SYSMAN@MAQUINA4

CREATE TABLE workorder
    (rowstamp                       VARCHAR2(40) NOT NULL,
    wonum                          VARCHAR2(18) NOT NULL,
    parent                         VARCHAR2(18),
    status                         VARCHAR2(8) NOT NULL,
    statusdate                     DATE NOT NULL,
    worktype                       VARCHAR2(7),
    leadcraft                      VARCHAR2(12),
    description                    VARCHAR2(200),
    eqnum                          VARCHAR2(12),
    location                       VARCHAR2(18),
    jpnum                          VARCHAR2(30),
    faildate                       DATE,
    changeby                       VARCHAR2(18),
    changedate                     DATE,
    estdur                         FLOAT(126) NOT NULL,
    estlabhrs                      FLOAT(126) NOT NULL,
    estmatcost                     NUMBER(10,2) NOT NULL,
    estlabcost                     NUMBER(10,2) NOT NULL,
    esttoolcost                    NUMBER(10,2) NOT NULL,
    pmnum                          VARCHAR2(16),
    actlabhrs                      FLOAT(126) NOT NULL,
    actmatcost                     NUMBER(10,2) NOT NULL,
    actlabcost                     NUMBER(10,2) NOT NULL,
    acttoolcost                    NUMBER(10,2) NOT NULL,
    haschildren                    VARCHAR2(1) NOT NULL,
    outlabcost                     NUMBER(10,2) NOT NULL,
    outmatcost                     NUMBER(10,2) NOT NULL,
    outtoolcost                    NUMBER(10,2) NOT NULL,
    historyflag                    VARCHAR2(1) NOT NULL,
    contract                       VARCHAR2(10),
    wopriority                     NUMBER,
    wopm6                          VARCHAR2(25),
    wopm7                          VARCHAR2(4),
    targcompdate                   DATE,
    targstartdate                  DATE,
    woeq1                          VARCHAR2(1),
    woeq2                          VARCHAR2(50),
    woeq3                          VARCHAR2(1),
    woeq4                          VARCHAR2(1),
    woeq5                          VARCHAR2(1),
    woeq6                          VARCHAR2(1),
    woeq7                          NUMBER(15,2),
    woeq8                          VARCHAR2(3),
    woeq9                          VARCHAR2(10),
    woeq10                         VARCHAR2(3),
    woeq11                         VARCHAR2(3),
    woeq12                         VARCHAR2(3),
    wo1                            VARCHAR2(12),
    wo2                            VARCHAR2(120),
    wo3                            FLOAT(126),
    wo4                            NUMBER(10,2),
    wo5                            NUMBER(10,2),
    wo6                            NUMBER(10,2),
    wo7                            NUMBER(10,2),
    wo8                            NUMBER(10,2),
    wo9                            VARCHAR2(4),
    wo10                           NUMBER(10,2),
    ldkey                          NUMBER,
    reportedby                     VARCHAR2(18),
    reportdate                     DATE,
    phone                          VARCHAR2(20),
    problemcode                    VARCHAR2(8),
    calendar                       VARCHAR2(8),
    interruptable                  VARCHAR2(1) NOT NULL,
    downtime                       VARCHAR2(1) NOT NULL,
    actstart                       DATE,
    actfinish                      DATE,
    schedstart                     DATE,
    schedfinish                    DATE,
    remdur                         FLOAT(126),
    crewid                         VARCHAR2(12),
    supervisor                     VARCHAR2(12),
    woeq13                         DATE,
    woeq14                         NUMBER(15,2),
    wopm1                          VARCHAR2(10),
    wopm2                          VARCHAR2(10),
    wopm3                          VARCHAR2(10),
    wopm4                          NUMBER(10,2),
    wopm5                          VARCHAR2(10),
    wojp1                          VARCHAR2(10),
    wojp2                          VARCHAR2(10),
    wojp3                          VARCHAR2(10),
    wojp4                          NUMBER(10,2),
    wojp5                          VARCHAR2(10),
    wol1                           VARCHAR2(10),
    wol2                           VARCHAR2(10),
    wol3                           NUMBER(10,2),
    wol4                           DATE,
    wolablnk                       VARCHAR2(12),
    respondby                      DATE,
    eqlocpriority                  NUMBER,
    calcpriority                   NUMBER,
    chargestore                    VARCHAR2(1) NOT NULL,
    failurecode                    VARCHAR2(8),
    wolo1                          VARCHAR2(10),
    wolo2                          VARCHAR2(10),
    wolo3                          VARCHAR2(10),
    wolo4                          VARCHAR2(10),
    wolo5                          VARCHAR2(10),
    wolo6                          NUMBER(10,2),
    wolo7                          DATE,
    wolo8                          NUMBER(15,2),
    wolo9                          VARCHAR2(10),
    wolo10                         NUMBER,
    glaccount                      VARCHAR2(20),
    estservcost                    NUMBER(10,2) NOT NULL,
    actservcost                    NUMBER(10,2) NOT NULL,
    disabled                       VARCHAR2(1) NOT NULL,
    estatapprlabhrs                FLOAT(126) NOT NULL,
    estatapprlabcost               NUMBER(10,2) NOT NULL,
    estatapprmatcost               NUMBER(10,2) NOT NULL,
    estatapprtoolcost              NUMBER(10,2) NOT NULL,
    estatapprservcost              NUMBER(10,2) NOT NULL,
    wosequence                     NUMBER,
    hasfollowupwork                VARCHAR2(1) NOT NULL,
    worts1                         VARCHAR2(10),
    worts2                         VARCHAR2(10),
    worts3                         VARCHAR2(10),
    worts4                         DATE,
    worts5                         NUMBER(15,2),
    wfid                           NUMBER,
    wfactive                       VARCHAR2(1) NOT NULL,
    followupfromwonum              VARCHAR2(18),
    pmduedate                      DATE,
    pmextdate                      DATE,
    pmnextduedate                  DATE,
    woassignmntqueueid             VARCHAR2(25),
    worklocation                   VARCHAR2(18),
    wowq1                          VARCHAR2(1),
    wowq2                          VARCHAR2(1),
    wowq3                          VARCHAR2(1),
    wojp6                          VARCHAR2(10),
    wojp7                          VARCHAR2(10),
    wojp8                          VARCHAR2(10),
    wojp9                          NUMBER(10,2),
    wojp10                         DATE,
    wo11                           NUMBER(10,2),
    wo12                           NUMBER(10,2),
    wo13                           VARCHAR2(3),
    wo14                           VARCHAR2(3),
    wo15                           NUMBER(10,2),
    wo16                           NUMBER(10,2),
    wo17                           FLOAT(126),
    wo18                           FLOAT(126),
    wo19                           FLOAT(126),
    wo20                           VARCHAR2(4),
    sourcesysid                    VARCHAR2(10),
    ownersysid                     VARCHAR2(10),
    externalrefid                  VARCHAR2(10),
    apiseq                         VARCHAR2(50),
    interid                        VARCHAR2(50),
    migchangeid                    VARCHAR2(50),
    sendersysid                    VARCHAR2(50),
    expdone                        VARCHAR2(25),
    fincntrlid                     VARCHAR2(8),
    generatedforpo                 VARCHAR2(8),
    genforpolineid                 NUMBER,
    orgid                          VARCHAR2(8) NOT NULL,
    siteid                         VARCHAR2(8) NOT NULL,
    taskid                         NUMBER,
    inspector                      VARCHAR2(12),
    measurementvalue               NUMBER(15,3),
    measuredate                    DATE,
    observation                    VARCHAR2(8),
    pointnum                       VARCHAR2(16),
    wojo1                          VARCHAR2(10),
    wojo2                          VARCHAR2(10),
    wojo3                          VARCHAR2(10),
    wojo4                          NUMBER(15,2),
    wojo5                          VARCHAR2(10),
    wojo6                          VARCHAR2(10),
    wojo7                          VARCHAR2(10),
    wojo8                          VARCHAR2(10),
    changechildstatus              VARCHAR2(1) NOT NULL,
    istask                         VARCHAR2(1) NOT NULL)
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Indexes for WORKORDER

CREATE INDEX workorder_ndx19 ON workorder
  (
    wopm6                           ASC,
    siteid                          ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
PARALLEL (DEGREE DEFAULT)
/
CREATE INDEX workorder_temp ON workorder
  (
    siteid                          ASC,
    status                          ASC,
    statusdate                      ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
PARALLEL (DEGREE DEFAULT)
/
CREATE INDEX workorder_ndx16 ON workorder
  (
    siteid                          ASC,
    crewid                          ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
PARALLEL (DEGREE DEFAULT)
/
CREATE INDEX workorder_ndx18 ON workorder
  (
    siteid                          ASC,
    crewid                          ASC,
    status                          ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
PARALLEL (DEGREE DEFAULT)
/
CREATE UNIQUE INDEX workorder_ndx1 ON workorder
  (
    siteid                          ASC,
    wonum                           ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/
CREATE INDEX workorder_ndx2 ON workorder
  (
    siteid                          ASC,
    status                          ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/
CREATE INDEX workorder_ndx3 ON workorder
  (
    siteid                          ASC,
    historyflag                     ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/
CREATE INDEX workorder_ndx4 ON workorder
  (
    siteid                          ASC,
    interid                         ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/
CREATE INDEX workorder_ndx5 ON workorder
  (
    siteid                          ASC,
    wfid                            ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/
CREATE INDEX workorder_ndx6 ON workorder
  (
    siteid                          ASC,
    respondby                       ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/
CREATE INDEX workorder_ndx7 ON workorder
  (
    siteid                          ASC,
    eqnum                           ASC,
    problemcode                     ASC,
    status                          ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/
CREATE INDEX workorder_ndx8 ON workorder
  (
    siteid                          ASC,
    jpnum                           ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/
CREATE INDEX workorder_ndx9 ON workorder
  (
    siteid                          ASC,
    location                        ASC,
    problemcode                     ASC,
    status                          ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/
CREATE INDEX workorder_ndx17 ON workorder
  (
    ldkey                           ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/
CREATE INDEX workorder_ndx11 ON workorder
  (
    wopm7                           ASC,
    siteid                          ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
PARALLEL (DEGREE DEFAULT)
/
CREATE UNIQUE INDEX workorder_ndx12 ON workorder
  (
    wonum                           ASC,
    istask                          ASC,
    historyflag                     ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
PARALLEL (DEGREE DEFAULT)
/
CREATE INDEX workorder_ndx13 ON workorder
  (
    siteid                          ASC,
    istask                          ASC,
    historyflag                     ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
PARALLEL (DEGREE DEFAULT)
/
CREATE INDEX workorder_ndx10 ON workorder
  (
    parent                          ASC,
    siteid                          ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/
CREATE INDEX workorder_ndx14 ON workorder
  (
    historyflag                     ASC,
    istask                          ASC,
    wopm7                           ASC,
    siteid                          ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
PARALLEL (DEGREE DEFAULT)
/
CREATE INDEX workorder_ndx15 ON workorder
  (
    historyflag                     ASC,
    istask                          ASC,
    wopm6                           ASC,
    siteid                          ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
PARALLEL (DEGREE DEFAULT)
/


-- Triggers for WORKORDER

CREATE TRIGGER tr_calc_os1
BEFORE INSERT  OR UPDATE 
ON workorder
REFERENCING NEW AS NEW OLD AS OLD
FOR EACH ROW
DECLARE
BEGIN
   
--Copiando valores já contabilizados pelo MAXIMO
--SELECT SUM(LINECOST) INTO :new.wo5 FROM MATUSETRANS WHERE REFWO = :NEW.WONUM;
   :NEW.wo3 := :NEW.actlabhrs;
   :NEW.wo4 := :NEW.actlabcost;
--  :new.wo5:=:new.actmatcost;
   :NEW.wo6 := :NEW.acttoolcost;
   :NEW.wo7 := :NEW.actservcost;

   
-- Tratando valores extras nulos
   IF :NEW.wo10 IS NULL THEN :NEW.wo10 := 0;
   END IF;

   IF :NEW.wo11 IS NULL THEN :NEW.wo11 := 0;
   END IF;

   IF :NEW.wo12 IS NULL THEN :NEW.wo12 := 0;
   END IF;

   IF :NEW.wo15 IS NULL THEN :NEW.wo15 := 0;
   END IF;

   IF :NEW.wo16 IS NULL THEN :NEW.wo16 := 0;
   END IF;

   
-- Calculando total geral (WO8)
   :NEW.wo8 :=   :NEW.wo4 + :NEW.wo5 + :NEW.wo6 + :NEW.wo7 + :NEW.wo10 + :NEW.wo11 + :NEW.wo12 + :NEW.wo15 + :NEW.wo16; 
END;
/
CREATE TRIGGER workorder_t
BEFORE INSERT 
ON workorder
REFERENCING NEW AS NEW OLD AS OLD
FOR EACH ROW
DECLARE
NEXTVAL INTEGER; BEGIN SELECT MAXSEQ.NEXTVAL INTO NEXTVAL FROM DUAL;
:NEW.ROWSTAMP := NEXTVAL; END;
/
CREATE TRIGGER tr_depe_workorder
BEFORE INSERT 
ON workorder
REFERENCING NEW AS NEW OLD AS OLD
FOR EACH ROW
BEGIN
  IF :NEW.CHANGEBY <>'IFRMAXIMO' THEN
     IF SUBSTR(:NEW.CHANGEBY,1,1) = 'I' THEN
        SELECT SUBSTR(USER01,1,4), NULL
        INTO :NEW.WOPM7, :NEW.WOPM6
        FROM IFRMAXIMO.USUARIO
        WHERE USERNUM=:NEW.CHANGEBY;
     END IF;
     IF SUBSTR(:NEW.CHANGEBY,1,1) = 'C' THEN
        SELECT SUBSTR(USER01,1,4), USER01
        INTO :NEW.WOPM7, :NEW.WOPM6
        FROM IFRMAXIMO.USUARIO
        WHERE USERNUM=:NEW.CHANGEBY;
     END IF;
  END IF;
END;
/
CREATE TRIGGER tr_sismat1
BEFORE UPDATE 
ON workorder
REFERENCING NEW AS NEW OLD AS OLD
FOR EACH ROW
DECLARE
   V_STATUS ORDEM_SERVICO.IN_ABERTA%TYPE :='';
   V_COUNT   NUMBER(5)  :=0;
   CURSOR CAN_OS
        (P_WONUM ORDEM_SERVICO.OS_MAXIMO%TYPE) IS
      SELECT NR_ORDEM_SERVICO,AA_ORDEM_SERVICO, IN_ABERTA
      FROM ORDEM_SERVICO
      WHERE OS_MAXIMO = P_WONUM;
BEGIN
   IF :NEW.STATUS = 'CAN' THEN
      BEGIN
      FOR CANCELAMENTO IN CAN_OS (:NEW.WONUM) LOOP
         IF CANCELAMENTO.IN_ABERTA <> 4 THEN
            BEGIN
               RAISE_APPLICATION_ERROR(-20777,'FAVOR FECHAR A RM VINCULADA A ESTA ORDEM DE SERVICO.');
            END;
         END IF;
      END LOOP;
      END;
   END IF;
END;
/
CREATE TRIGGER tr_tarefas
BEFORE INSERT 
ON workorder
REFERENCING NEW AS NEW OLD AS OLD
FOR EACH ROW
BEGIN
  IF :NEW.ISTASK='S' THEN
    :NEW.STATUS:='APRV';
  END IF;
END;
/

-- End of DDL Script for Table IFRMAXIMO.WORKORDER

-- Start of DDL Script for Table IFRMAXIMO.WORKORDER_TEMP
-- Generated 9-mar-2004 20:35:48 from SYSMAN@MAQUINA4

CREATE TABLE workorder_temp
    (wonum                          VARCHAR2(18))
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- End of DDL Script for Table IFRMAXIMO.WORKORDER_TEMP

-- Start of DDL Script for Table IFRMAXIMO.WORKPERIOD
-- Generated 9-mar-2004 20:35:48 from SYSMAN@MAQUINA4

CREATE TABLE workperiod
    (rowstamp                       VARCHAR2(40) NOT NULL,
    calnum                         VARCHAR2(8) NOT NULL,
    workdate                       DATE NOT NULL,
    shiftnum                       VARCHAR2(8) NOT NULL,
    starttime                      DATE NOT NULL,
    endtime                        DATE NOT NULL,
    workhours                      FLOAT(126) NOT NULL,
    orgid                          VARCHAR2(8) NOT NULL,
    siteid                         VARCHAR2(8) NOT NULL)
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Indexes for WORKPERIOD

CREATE UNIQUE INDEX workperiod_ndx1 ON workperiod
  (
    siteid                          ASC,
    calnum                          ASC,
    workdate                        ASC,
    shiftnum                        ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/
CREATE INDEX workperiod_ndx2 ON workperiod
  (
    siteid                          ASC,
    workdate                        ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/
CREATE INDEX workperiod_ndx3 ON workperiod
  (
    siteid                          ASC,
    shiftnum                        ASC,
    workdate                        ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/


-- Triggers for WORKPERIOD

CREATE TRIGGER workperiod_t
BEFORE INSERT  OR UPDATE 
ON workperiod
REFERENCING NEW AS NEW OLD AS OLD
FOR EACH ROW
DECLARE 
NEXTVAL INTEGER; BEGIN SELECT MAXSEQ.NEXTVAL INTO NEXTVAL FROM DUAL; 
:NEW.ROWSTAMP := NEXTVAL; END;
/

-- End of DDL Script for Table IFRMAXIMO.WORKPERIOD

-- Start of DDL Script for Table IFRMAXIMO.WORKPRIORITY
-- Generated 9-mar-2004 20:36:03 from SYSMAN@MAQUINA4

CREATE TABLE workpriority
    (rowstamp                       VARCHAR2(40) NOT NULL,
    priority                       NUMBER NOT NULL,
    responsetime                   NUMBER NOT NULL,
    orgid                          VARCHAR2(8) NOT NULL,
    siteid                         VARCHAR2(8) NOT NULL)
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Indexes for WORKPRIORITY

CREATE UNIQUE INDEX workpriority_ndx1 ON workpriority
  (
    siteid                          ASC,
    priority                        ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/


-- Triggers for WORKPRIORITY

CREATE TRIGGER workpriority_t
BEFORE INSERT  OR UPDATE 
ON workpriority
REFERENCING NEW AS NEW OLD AS OLD
FOR EACH ROW
DECLARE 
NEXTVAL INTEGER; BEGIN SELECT MAXSEQ.NEXTVAL INTO NEXTVAL FROM DUAL; 
:NEW.ROWSTAMP := NEXTVAL; END;
/

-- End of DDL Script for Table IFRMAXIMO.WORKPRIORITY

-- Start of DDL Script for Table IFRMAXIMO.WORKTYPE
-- Generated 9-mar-2004 20:36:09 from SYSMAN@MAQUINA4

CREATE TABLE worktype
    (rowstamp                       VARCHAR2(40) NOT NULL,
    worktype                       VARCHAR2(7) NOT NULL,
    wtypedesc                      VARCHAR2(50),
    promptfail                     VARCHAR2(1) NOT NULL,
    promptdown                     VARCHAR2(1) NOT NULL,
    orgid                          VARCHAR2(8) NOT NULL)
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Indexes for WORKTYPE

CREATE UNIQUE INDEX worktype_ndx1 ON worktype
  (
    orgid                           ASC,
    worktype                        ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/


-- Triggers for WORKTYPE

CREATE TRIGGER worktype_t
BEFORE INSERT  OR UPDATE 
ON worktype
REFERENCING NEW AS NEW OLD AS OLD
FOR EACH ROW
DECLARE 
NEXTVAL INTEGER; BEGIN SELECT MAXSEQ.NEXTVAL INTO NEXTVAL FROM DUAL; 
:NEW.ROWSTAMP := NEXTVAL; END;
/

-- End of DDL Script for Table IFRMAXIMO.WORKTYPE

-- Start of DDL Script for Table IFRMAXIMO.WOSAFETYLINK
-- Generated 9-mar-2004 20:36:15 from SYSMAN@MAQUINA4

CREATE TABLE wosafetylink
    (rowstamp                       VARCHAR2(40) NOT NULL,
    wosafetylinkid                 NUMBER NOT NULL,
    wonum                          VARCHAR2(18) NOT NULL,
    eqnum                          VARCHAR2(12),
    location                       VARCHAR2(18),
    hazardid                       VARCHAR2(8),
    tagoutid                       VARCHAR2(8),
    applyseq                       NUMBER,
    removeseq                      NUMBER,
    wosafetydatasource             VARCHAR2(2) NOT NULL,
    wosl01                         VARCHAR2(10),
    wosl02                         VARCHAR2(10),
    wosl03                         DATE,
    wosl04                         NUMBER(15,2),
    wosl05                         NUMBER,
    orgid                          VARCHAR2(8) NOT NULL,
    siteid                         VARCHAR2(8) NOT NULL)
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Indexes for WOSAFETYLINK

CREATE UNIQUE INDEX wosafetylink_ndx1 ON wosafetylink
  (
    siteid                          ASC,
    wosafetylinkid                  ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/
CREATE INDEX wosafetylink_ndx2 ON wosafetylink
  (
    siteid                          ASC,
    wonum                           ASC,
    applyseq                        ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/


-- Triggers for WOSAFETYLINK

CREATE TRIGGER wosafetylink_t
BEFORE INSERT  OR UPDATE 
ON wosafetylink
REFERENCING NEW AS NEW OLD AS OLD
FOR EACH ROW
DECLARE 
NEXTVAL INTEGER; BEGIN SELECT MAXSEQ.NEXTVAL INTO NEXTVAL FROM DUAL; 
:NEW.ROWSTAMP := NEXTVAL; END;
/

-- End of DDL Script for Table IFRMAXIMO.WOSAFETYLINK

-- Start of DDL Script for Table IFRMAXIMO.WOSAFETYPLAN
-- Generated 9-mar-2004 20:36:22 from SYSMAN@MAQUINA4

CREATE TABLE wosafetyplan
    (rowstamp                       VARCHAR2(40) NOT NULL,
    wonum                          VARCHAR2(18) NOT NULL,
    safetyplanid                   VARCHAR2(16),
    description                    VARCHAR2(120),
    changeby                       VARCHAR2(18) NOT NULL,
    changedate                     DATE NOT NULL,
    sp01                           VARCHAR2(10),
    sp02                           VARCHAR2(10),
    sp03                           DATE,
    sp04                           NUMBER(15,2),
    sp05                           NUMBER,
    sp06                           VARCHAR2(10),
    sp07                           VARCHAR2(10),
    sp08                           VARCHAR2(10),
    sp09                           VARCHAR2(10),
    sp10                           VARCHAR2(10),
    sp11                           NUMBER(10,2),
    sp12                           DATE,
    sp13                           NUMBER(15,2),
    sp14                           VARCHAR2(10),
    sp15                           VARCHAR2(1),
    ldkey                          NUMBER,
    orgid                          VARCHAR2(8) NOT NULL,
    siteid                         VARCHAR2(8) NOT NULL)
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Indexes for WOSAFETYPLAN

CREATE UNIQUE INDEX wosafetyplan_ndx1 ON wosafetyplan
  (
    siteid                          ASC,
    wonum                           ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/


-- Triggers for WOSAFETYPLAN

CREATE TRIGGER wosafetyplan_t
BEFORE INSERT  OR UPDATE 
ON wosafetyplan
REFERENCING NEW AS NEW OLD AS OLD
FOR EACH ROW
DECLARE 
NEXTVAL INTEGER; BEGIN SELECT MAXSEQ.NEXTVAL INTO NEXTVAL FROM DUAL; 
:NEW.ROWSTAMP := NEXTVAL; END;
/

-- End of DDL Script for Table IFRMAXIMO.WOSAFETYPLAN

-- Start of DDL Script for Table IFRMAXIMO.WOSCHEDACTIVITY
-- Generated 9-mar-2004 20:36:28 from SYSMAN@MAQUINA4

CREATE TABLE woschedactivity
    (rowstamp                       VARCHAR2(40) NOT NULL,
    projectname                    VARCHAR2(16) NOT NULL,
    woschedactivityid              VARCHAR2(16) NOT NULL,
    estlabhrs                      FLOAT(126) NOT NULL,
    esttoolhrs                     FLOAT(126),
    estlabcost                     NUMBER(10,2) NOT NULL,
    estmatcost                     NUMBER(10,2) NOT NULL,
    esttoolcost                    NUMBER(10,2) NOT NULL,
    actlabhrs                      FLOAT(126) NOT NULL,
    acttoolhrs                     FLOAT(126),
    actlabcost                     NUMBER(10,2) NOT NULL,
    actmatcost                     NUMBER(10,2) NOT NULL,
    acttoolcost                    NUMBER(10,2) NOT NULL,
    actfinish                      DATE,
    actstart                       DATE,
    bds_code                       VARCHAR2(60),
    calcpriority                   NUMBER,
    act_code_a                     VARCHAR2(10),
    act_code_b                     VARCHAR2(10),
    act_code_c                     VARCHAR2(10),
    act_code_d                     VARCHAR2(10),
    act_code_e                     VARCHAR2(10),
    act_code_f                     VARCHAR2(10),
    act_code_g                     VARCHAR2(10),
    act_code_h                     VARCHAR2(10),
    act_code_i                     VARCHAR2(10),
    act_code_j                     VARCHAR2(10),
    constrainswonum                VARCHAR2(18),
    constrainttype                 VARCHAR2(2),
    description                    VARCHAR2(200),
    downtime                       VARCHAR2(1),
    calcduration                   FLOAT(126),
    estdur                         FLOAT(126) NOT NULL,
    eqnum                          VARCHAR2(12),
    interruptable                  VARCHAR2(1),
    item                           VARCHAR2(30),
    itemdesc                       VARCHAR2(120),
    jpnum                          VARCHAR2(30),
    hierarchylevels                NUMBER,
    leadcraft                      VARCHAR2(12),
    location                       VARCHAR2(18),
    parent                         VARCHAR2(18),
    percentcomp                    NUMBER(8,4),
    schedstart                     DATE,
    schedfinish                    DATE,
    schedbywocal                   VARCHAR2(1),
    wosequence                     NUMBER,
    status                         VARCHAR2(8) NOT NULL,
    targstartdate                  DATE,
    targcompdate                   DATE,
    activity_type                  NUMBER,
    remdur                         FLOAT(126),
    worktype                       VARCHAR2(7),
    wopriority                     NUMBER,
    orgid                          VARCHAR2(8) NOT NULL,
    siteid                         VARCHAR2(8) NOT NULL)
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Indexes for WOSCHEDACTIVITY

CREATE UNIQUE INDEX woschedact_ndx1 ON woschedactivity
  (
    siteid                          ASC,
    projectname                     ASC,
    woschedactivityid               ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/


-- Triggers for WOSCHEDACTIVITY

CREATE TRIGGER woschedactivity_t
BEFORE INSERT  OR UPDATE 
ON woschedactivity
REFERENCING NEW AS NEW OLD AS OLD
FOR EACH ROW
DECLARE 
NEXTVAL INTEGER; BEGIN SELECT MAXSEQ.NEXTVAL INTO NEXTVAL FROM DUAL; 
:NEW.ROWSTAMP := NEXTVAL; END;
/

-- End of DDL Script for Table IFRMAXIMO.WOSCHEDACTIVITY

-- Start of DDL Script for Table IFRMAXIMO.WOSTATUS
-- Generated 9-mar-2004 20:36:34 from SYSMAN@MAQUINA4

CREATE TABLE wostatus
    (rowstamp                       VARCHAR2(40) NOT NULL,
    wonum                          VARCHAR2(18) NOT NULL,
    status                         VARCHAR2(8) NOT NULL,
    changedate                     DATE NOT NULL,
    changeby                       VARCHAR2(18) NOT NULL,
    memo                           VARCHAR2(100),
    glaccount                      VARCHAR2(20),
    fincntrlid                     VARCHAR2(8),
    orgid                          VARCHAR2(8) NOT NULL,
    siteid                         VARCHAR2(8) NOT NULL)
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Indexes for WOSTATUS

CREATE INDEX wostatus_ndx1 ON wostatus
  (
    siteid                          ASC,
    changedate                      ASC,
    wonum                           ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/
CREATE INDEX wostatus_ndx2 ON wostatus
  (
    siteid                          ASC,
    wonum                           ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/
CREATE INDEX wostatus_ndx3 ON wostatus
  (
    siteid                          ASC,
    status                          ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/


-- Triggers for WOSTATUS

CREATE TRIGGER wostatus_t
BEFORE INSERT  OR UPDATE 
ON wostatus
REFERENCING NEW AS NEW OLD AS OLD
FOR EACH ROW
DECLARE 
NEXTVAL INTEGER; BEGIN SELECT MAXSEQ.NEXTVAL INTO NEXTVAL FROM DUAL; 
:NEW.ROWSTAMP := NEXTVAL; END;
/

-- End of DDL Script for Table IFRMAXIMO.WOSTATUS

-- Start of DDL Script for Table IFRMAXIMO.WOTAGLOCK
-- Generated 9-mar-2004 20:36:46 from SYSMAN@MAQUINA4

CREATE TABLE wotaglock
    (rowstamp                       VARCHAR2(40) NOT NULL,
    wonum                          VARCHAR2(18) NOT NULL,
    tagoutid                       VARCHAR2(8) NOT NULL,
    lockoutid                      VARCHAR2(20) NOT NULL,
    applyseq                       NUMBER,
    removeseq                      NUMBER,
    wosafetydatasource             VARCHAR2(2) NOT NULL,
    tl01                           VARCHAR2(10),
    tl02                           VARCHAR2(10),
    tl03                           VARCHAR2(10),
    tl04                           VARCHAR2(10),
    tl05                           VARCHAR2(10),
    tl06                           NUMBER(10,2),
    tl07                           DATE,
    tl08                           NUMBER(15,2),
    tl09                           VARCHAR2(10),
    tl10                           NUMBER,
    taglockid                      NUMBER NOT NULL,
    orgid                          VARCHAR2(8) NOT NULL,
    siteid                         VARCHAR2(8) NOT NULL)
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Indexes for WOTAGLOCK

CREATE UNIQUE INDEX wotaglock_ndx1 ON wotaglock
  (
    siteid                          ASC,
    taglockid                       ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/
CREATE INDEX wotaglock_ndx2 ON wotaglock
  (
    siteid                          ASC,
    wonum                           ASC,
    tagoutid                        ASC,
    lockoutid                       ASC,
    wosafetydatasource              ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/
CREATE INDEX wotaglock_ndx3 ON wotaglock
  (
    siteid                          ASC,
    wonum                           ASC,
    tagoutid                        ASC,
    applyseq                        ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/


-- Triggers for WOTAGLOCK

CREATE TRIGGER wotaglock_t
BEFORE INSERT  OR UPDATE 
ON wotaglock
REFERENCING NEW AS NEW OLD AS OLD
FOR EACH ROW
DECLARE 
NEXTVAL INTEGER; BEGIN SELECT MAXSEQ.NEXTVAL INTO NEXTVAL FROM DUAL; 
:NEW.ROWSTAMP := NEXTVAL; END;
/

-- End of DDL Script for Table IFRMAXIMO.WOTAGLOCK

-- Start of DDL Script for Table IFRMAXIMO.WOTAGOUT
-- Generated 9-mar-2004 20:36:58 from SYSMAN@MAQUINA4

CREATE TABLE wotagout
    (rowstamp                       VARCHAR2(40) NOT NULL,
    wonum                          VARCHAR2(18) NOT NULL,
    tagoutid                       VARCHAR2(8) NOT NULL,
    description                    VARCHAR2(50),
    ldkey                          NUMBER,
    location                       VARCHAR2(18),
    eqnum                          VARCHAR2(12),
    requiredstate                  VARCHAR2(16),
    wosafetydatasource             VARCHAR2(2) NOT NULL,
    tag01                          VARCHAR2(10),
    tag02                          VARCHAR2(10),
    tag03                          VARCHAR2(10),
    tag04                          VARCHAR2(10),
    tag05                          NUMBER(10,2),
    tag06                          DATE,
    tag07                          NUMBER(15,2),
    tag08                          VARCHAR2(10),
    orgid                          VARCHAR2(8) NOT NULL,
    siteid                         VARCHAR2(8) NOT NULL)
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Indexes for WOTAGOUT

CREATE UNIQUE INDEX wotagout_ndx1 ON wotagout
  (
    siteid                          ASC,
    wonum                           ASC,
    tagoutid                        ASC,
    wosafetydatasource              ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/


-- Triggers for WOTAGOUT

CREATE TRIGGER wotagout_t
BEFORE INSERT  OR UPDATE 
ON wotagout
REFERENCING NEW AS NEW OLD AS OLD
FOR EACH ROW
DECLARE 
NEXTVAL INTEGER; BEGIN SELECT MAXSEQ.NEXTVAL INTO NEXTVAL FROM DUAL; 
:NEW.ROWSTAMP := NEXTVAL; END;
/

-- End of DDL Script for Table IFRMAXIMO.WOTAGOUT

-- Start of DDL Script for Table IFRMAXIMO.WPEDITSETTING
-- Generated 9-mar-2004 20:37:04 from SYSMAN@MAQUINA4

CREATE TABLE wpeditsetting
    (rowstamp                       VARCHAR2(40) NOT NULL,
    status                         VARCHAR2(8) NOT NULL,
    editglaccount                  VARCHAR2(1) NOT NULL,
    editeq                         VARCHAR2(1) NOT NULL,
    editloc                        VARCHAR2(1) NOT NULL,
    editwplab                      VARCHAR2(1) NOT NULL,
    editwpmat                      VARCHAR2(1) NOT NULL,
    editwptool                     VARCHAR2(1) NOT NULL,
    editsafety                     VARCHAR2(1) NOT NULL,
    orgid                          VARCHAR2(8) NOT NULL)
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Indexes for WPEDITSETTING

CREATE UNIQUE INDEX wpeditsetting_ndx1 ON wpeditsetting
  (
    orgid                           ASC,
    status                          ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/


-- Triggers for WPEDITSETTING

CREATE TRIGGER wpeditsetting_t
BEFORE INSERT  OR UPDATE 
ON wpeditsetting
REFERENCING NEW AS NEW OLD AS OLD
FOR EACH ROW
DECLARE 
NEXTVAL INTEGER; BEGIN SELECT MAXSEQ.NEXTVAL INTO NEXTVAL FROM DUAL; 
:NEW.ROWSTAMP := NEXTVAL; END;
/

-- End of DDL Script for Table IFRMAXIMO.WPEDITSETTING

-- Start of DDL Script for Table IFRMAXIMO.WPLABOR
-- Generated 9-mar-2004 20:37:09 from SYSMAN@MAQUINA4

CREATE TABLE wplabor
    (rowstamp                       VARCHAR2(40) NOT NULL,
    wonum                          VARCHAR2(18) NOT NULL,
    laborcode                      VARCHAR2(12) NOT NULL,
    craftqty                       NUMBER NOT NULL,
    laborhrs                       FLOAT(126) NOT NULL,
    rate                           NUMBER(10,2) NOT NULL,
    ldkey                          NUMBER,
    wpl1                           VARCHAR2(10),
    wpl2                           DATE,
    wpl3                           VARCHAR2(10),
    wpl4                           VARCHAR2(20),
    wpl5                           VARCHAR2(20),
    wpl6                           NUMBER(15,2),
    wplaborid                      VARCHAR2(20) NOT NULL,
    vendor                         VARCHAR2(18),
    ratehaschanged                 VARCHAR2(1) NOT NULL,
    wpl7                           VARCHAR2(10),
    wpl8                           VARCHAR2(10),
    wpl9                           VARCHAR2(10),
    orgid                          VARCHAR2(8) NOT NULL,
    siteid                         VARCHAR2(8) NOT NULL)
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Indexes for WPLABOR

CREATE UNIQUE INDEX wplabor_ndx1 ON wplabor
  (
    siteid                          ASC,
    wonum                           ASC,
    wplaborid                       ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/
CREATE INDEX wplabor_ndx2 ON wplabor
  (
    siteid                          ASC,
    wonum                           ASC,
    laborcode                       ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/


-- Triggers for WPLABOR

CREATE TRIGGER wplabor_t
BEFORE INSERT  OR UPDATE 
ON wplabor
REFERENCING NEW AS NEW OLD AS OLD
FOR EACH ROW
DECLARE NEXTVAL INTEGER; BEGIN SELECT MAXSEQ.NEXTVAL INTO NEXTVAL FROM DUAL; :NEW.ROWSTAMP := NEXTVAL; END;
/

-- End of DDL Script for Table IFRMAXIMO.WPLABOR

-- Start of DDL Script for Table IFRMAXIMO.WPMATERIAL
-- Generated 9-mar-2004 20:37:19 from SYSMAN@MAQUINA4

CREATE TABLE wpmaterial
    (rowstamp                       VARCHAR2(40) NOT NULL,
    wonum                          VARCHAR2(18) NOT NULL,
    itemnum                        VARCHAR2(30),
    location                       VARCHAR2(18),
    itemqty                        NUMBER(15,2) NOT NULL,
    unitcost                       NUMBER(17,5) NOT NULL,
    ldkey                          NUMBER,
    directreq                      VARCHAR2(1) NOT NULL,
    vendor                         VARCHAR2(18),
    requiredate                    DATE,
    requestby                      VARCHAR2(18),
    pr                             VARCHAR2(8),
    wpm1                           VARCHAR2(10),
    wpm2                           VARCHAR2(10),
    wpm3                           NUMBER(15,2),
    wpm4                           NUMBER(15,2),
    wpm5                           VARCHAR2(50),
    wpm6                           VARCHAR2(10),
    prlinenum                      NUMBER,
    unitcosthaschanged             VARCHAR2(1) NOT NULL,
    issueto                        VARCHAR2(12),
    orgid                          VARCHAR2(8) NOT NULL,
    siteid                         VARCHAR2(8) NOT NULL,
    description                    VARCHAR2(120),
    manufacturer                   VARCHAR2(18),
    modelnum                       VARCHAR2(8),
    catalogcode                    VARCHAR2(30),
    orderunit                      VARCHAR2(8),
    vendorpackcode                 VARCHAR2(12),
    vendorpackquantity             VARCHAR2(12),
    vendorwarehouse                VARCHAR2(12),
    mktplcitem                     VARCHAR2(1) NOT NULL,
    vendorunitcost                 NUMBER(17,5))
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Indexes for WPMATERIAL

CREATE INDEX wpmaterial_ndx1 ON wpmaterial
  (
    siteid                          ASC,
    wonum                           ASC,
    itemnum                         ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/


-- Triggers for WPMATERIAL

CREATE TRIGGER wpmaterial_t
BEFORE INSERT  OR UPDATE 
ON wpmaterial
REFERENCING NEW AS NEW OLD AS OLD
FOR EACH ROW
DECLARE 
NEXTVAL INTEGER; BEGIN SELECT MAXSEQ.NEXTVAL INTO NEXTVAL FROM DUAL; 
:NEW.ROWSTAMP := NEXTVAL; END;
/

-- End of DDL Script for Table IFRMAXIMO.WPMATERIAL

-- Start of DDL Script for Table IFRMAXIMO.WPTOOL
-- Generated 9-mar-2004 20:37:25 from SYSMAN@MAQUINA4

CREATE TABLE wptool
    (rowstamp                       VARCHAR2(40) NOT NULL,
    wonum                          VARCHAR2(18) NOT NULL,
    toolnum                        VARCHAR2(16) NOT NULL,
    toolqty                        NUMBER NOT NULL,
    toolhrs                        FLOAT(126) NOT NULL,
    rate                           NUMBER(10,2) NOT NULL,
    ldkey                          NUMBER,
    wpt1                           VARCHAR2(10),
    wpt2                           VARCHAR2(10),
    wpt3                           NUMBER,
    wpt4                           VARCHAR2(10),
    wpt5                           NUMBER(10,2),
    wpt6                           NUMBER(15,2),
    ratehaschanged                 VARCHAR2(1) NOT NULL,
    orgid                          VARCHAR2(8) NOT NULL,
    siteid                         VARCHAR2(8) NOT NULL)
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Indexes for WPTOOL

CREATE INDEX wptool_ndx1 ON wptool
  (
    siteid                          ASC,
    wonum                           ASC,
    toolnum                         ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/


-- Triggers for WPTOOL

CREATE TRIGGER wptool_t
BEFORE INSERT  OR UPDATE 
ON wptool
REFERENCING NEW AS NEW OLD AS OLD
FOR EACH ROW
DECLARE NEXTVAL INTEGER; BEGIN SELECT MAXSEQ.NEXTVAL INTO NEXTVAL FROM DUAL; :NEW.ROWSTAMP := NEXTVAL; END;
/

-- End of DDL Script for Table IFRMAXIMO.WPTOOL

-- Start of DDL Script for Table IFRMAXIMO.WPTOOL_BKP
-- Generated 9-mar-2004 20:37:29 from SYSMAN@MAQUINA4

CREATE TABLE wptool_bkp
    (rowstamp                       VARCHAR2(40) NOT NULL,
    wonum                          VARCHAR2(18) NOT NULL,
    toolnum                        VARCHAR2(16) NOT NULL,
    toolqty                        NUMBER NOT NULL,
    toolhrs                        FLOAT(126) NOT NULL,
    rate                           NUMBER(10,2) NOT NULL,
    ldkey                          NUMBER,
    wpt1                           VARCHAR2(10),
    wpt2                           VARCHAR2(10),
    wpt3                           NUMBER,
    wpt4                           VARCHAR2(10),
    wpt5                           NUMBER(10,2),
    wpt6                           VARCHAR2(10),
    ratehaschanged                 VARCHAR2(1) NOT NULL,
    orgid                          VARCHAR2(8) NOT NULL,
    siteid                         VARCHAR2(8) NOT NULL)
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- End of DDL Script for Table IFRMAXIMO.WPTOOL_BKP


