-- Start of DDL Script for Index IFRMAXIMO.ACCTDFLT_NDX1
-- Generated 3/10/2006 17:21:16 from IFRMAXIMO@prodsede2

CREATE UNIQUE INDEX ifrmaximo.acctdflt_ndx1 ON ifrmaximo.accountdefaults
  (
    orgid                           ASC,
    dfltgroup                       ASC,
    groupvalue                      ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
  TABLESPACE  tsi_maximo
  STORAGE   (
    INITIAL     65536
    MINEXTENTS  1
    MAXEXTENTS  2147483645
  )
/


-- End of DDL Script for Index IFRMAXIMO.ACCTDFLT_NDX1

-- Start of DDL Script for Index IFRMAXIMO.ADDRESS_NDX1
-- Generated 3/10/2006 17:21:16 from IFRMAXIMO@prodsede2

CREATE UNIQUE INDEX ifrmaximo.address_ndx1 ON ifrmaximo.address
  (
    orgid                           ASC,
    addresscode                     ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
  TABLESPACE  tsi_maximo
  STORAGE   (
    INITIAL     65536
    MINEXTENTS  1
    MAXEXTENTS  2147483645
  )
/


-- End of DDL Script for Index IFRMAXIMO.ADDRESS_NDX1

-- Start of DDL Script for Index IFRMAXIMO.ALNDOMAINVAL_NDX1
-- Generated 3/10/2006 17:21:16 from IFRMAXIMO@prodsede2

CREATE UNIQUE INDEX ifrmaximo.alndomainval_ndx1 ON ifrmaximo.alndomainvalue
  (
    domainid                        ASC,
    alnvalue                        ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
  TABLESPACE  tsi_maximo
  STORAGE   (
    INITIAL     40960
    MINEXTENTS  1
    MAXEXTENTS  2147483645
  )
/


-- End of DDL Script for Index IFRMAXIMO.ALNDOMAINVAL_NDX1

-- Start of DDL Script for Index IFRMAXIMO.ALTITEM_NDX1
-- Generated 3/10/2006 17:21:17 from IFRMAXIMO@prodsede2

CREATE UNIQUE INDEX ifrmaximo.altitem_ndx1 ON ifrmaximo.altitem
  (
    orgid                           ASC,
    itemnum                         ASC,
    altitemnum                      ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
  TABLESPACE  tsi_maximo
  STORAGE   (
    INITIAL     65536
    MINEXTENTS  1
    MAXEXTENTS  2147483645
  )
/


-- End of DDL Script for Index IFRMAXIMO.ALTITEM_NDX1

-- Start of DDL Script for Index IFRMAXIMO.ANALYZEINDEX_NDX
-- Generated 3/10/2006 17:21:17 from IFRMAXIMO@prodsede2

CREATE UNIQUE INDEX ifrmaximo.analyzeindex_ndx ON ifrmaximo.maxanalyzeindexes
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
  TABLESPACE  tsi_maximo
  STORAGE   (
    INITIAL     65536
    MINEXTENTS  1
    MAXEXTENTS  2147483645
  )
/


-- End of DDL Script for Index IFRMAXIMO.ANALYZEINDEX_NDX

-- Start of DDL Script for Index IFRMAXIMO.APPDOCTYPE_NDX1
-- Generated 3/10/2006 17:21:17 from IFRMAXIMO@prodsede2

CREATE UNIQUE INDEX ifrmaximo.appdoctype_ndx1 ON ifrmaximo.appdoctype
  (
    siteid                          ASC,
    app                             ASC,
    doctype                         ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
  TABLESPACE  tsi_maximo
  STORAGE   (
    INITIAL     65536
    MINEXTENTS  1
    MAXEXTENTS  2147483645
  )
/


-- End of DDL Script for Index IFRMAXIMO.APPDOCTYPE_NDX1

-- Start of DDL Script for Index IFRMAXIMO.APPFIELDDEF_NDX1
-- Generated 3/10/2006 17:21:17 from IFRMAXIMO@prodsede2

CREATE UNIQUE INDEX ifrmaximo.appfielddef_ndx1 ON ifrmaximo.appfielddefaults
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
  TABLESPACE  tsi_maximo
  STORAGE   (
    INITIAL     65536
    MINEXTENTS  1
    MAXEXTENTS  2147483645
  )
/


-- End of DDL Script for Index IFRMAXIMO.APPFIELDDEF_NDX1

-- Start of DDL Script for Index IFRMAXIMO.APPFIELDDEF_NDX2
-- Generated 3/10/2006 17:21:17 from IFRMAXIMO@prodsede2

CREATE UNIQUE INDEX ifrmaximo.appfielddef_ndx2 ON ifrmaximo.appfielddefaults
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
  TABLESPACE  tsi_maximo
  STORAGE   (
    INITIAL     65536
    MINEXTENTS  1
    MAXEXTENTS  2147483645
  )
/


-- End of DDL Script for Index IFRMAXIMO.APPFIELDDEF_NDX2

-- Start of DDL Script for Index IFRMAXIMO.APPLAUNCH_NDX1
-- Generated 3/10/2006 17:21:18 from IFRMAXIMO@prodsede2

CREATE UNIQUE INDEX ifrmaximo.applaunch_ndx1 ON ifrmaximo.applaunch
  (
    launchingapp                    ASC,
    launchingparent                 ASC,
    launchingitem                   ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
  TABLESPACE  tsi_maximo
  STORAGE   (
    INITIAL     65536
    MINEXTENTS  1
    MAXEXTENTS  2147483645
  )
/


-- End of DDL Script for Index IFRMAXIMO.APPLAUNCH_NDX1

-- Start of DDL Script for Index IFRMAXIMO.APPROVALLIMIT_NDX1
-- Generated 3/10/2006 17:21:18 from IFRMAXIMO@prodsede2

CREATE UNIQUE INDEX ifrmaximo.approvallimit_ndx1 ON ifrmaximo.approvallimit
  (
    orgid                           ASC,
    grpname                         ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
  TABLESPACE  tsi_maximo
  STORAGE   (
    INITIAL     65536
    MINEXTENTS  1
    MAXEXTENTS  2147483645
  )
/


-- End of DDL Script for Index IFRMAXIMO.APPROVALLIMIT_NDX1

-- Start of DDL Script for Index IFRMAXIMO.ARCHIVE_NDX1
-- Generated 3/10/2006 17:21:18 from IFRMAXIMO@prodsede2

CREATE UNIQUE INDEX ifrmaximo.archive_ndx1 ON ifrmaximo.archive
  (
    archivedate                     ASC,
    module                          ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
  TABLESPACE  tsi_maximo
  STORAGE   (
    INITIAL     65536
    MINEXTENTS  1
    MAXEXTENTS  2147483645
  )
/


-- End of DDL Script for Index IFRMAXIMO.ARCHIVE_NDX1

-- Start of DDL Script for Index IFRMAXIMO.ASSETATTR_NDX1
-- Generated 3/10/2006 17:21:18 from IFRMAXIMO@prodsede2

CREATE UNIQUE INDEX ifrmaximo.assetattr_ndx1 ON ifrmaximo.assetattribute
  (
    orgid                           ASC,
    assetattrid                     ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
  TABLESPACE  tsi_maximo
  STORAGE   (
    INITIAL     65536
    MINEXTENTS  1
    MAXEXTENTS  2147483645
  )
/


-- End of DDL Script for Index IFRMAXIMO.ASSETATTR_NDX1

-- Start of DDL Script for Index IFRMAXIMO.ASSETCLASS_NDX1
-- Generated 3/10/2006 17:21:18 from IFRMAXIMO@prodsede2

CREATE UNIQUE INDEX ifrmaximo.assetclass_ndx1 ON ifrmaximo.assetclass
  (
    orgid                           ASC,
    classificationid                ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
  TABLESPACE  tsi_maximo
  STORAGE   (
    INITIAL     65536
    MINEXTENTS  1
    MAXEXTENTS  2147483645
  )
/


-- End of DDL Script for Index IFRMAXIMO.ASSETCLASS_NDX1

-- Start of DDL Script for Index IFRMAXIMO.ASSIGNMNT_NDX
-- Generated 3/10/2006 17:21:18 from IFRMAXIMO@prodsede2

CREATE INDEX ifrmaximo.assignmnt_ndx ON ifrmaximo.assignment
  (
    orgid                           ASC,
    wonum                           ASC,
    wplaborid                       ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
  TABLESPACE  tsi_maximo
  STORAGE   (
    INITIAL     65536
    MINEXTENTS  1
    MAXEXTENTS  2147483645
  )
/


-- End of DDL Script for Index IFRMAXIMO.ASSIGNMNT_NDX

-- Start of DDL Script for Index IFRMAXIMO.ATTEND_NDX1
-- Generated 3/10/2006 17:21:18 from IFRMAXIMO@prodsede2

CREATE INDEX ifrmaximo.attend_ndx1 ON ifrmaximo.attendance
  (
    orgid                           ASC,
    laborcode                       ASC,
    transdate                       ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
  TABLESPACE  tsi_maximo
  STORAGE   (
    INITIAL     65536
    MINEXTENTS  1
    MAXEXTENTS  2147483645
  )
/


-- End of DDL Script for Index IFRMAXIMO.ATTEND_NDX1

-- Start of DDL Script for Index IFRMAXIMO.AUTOKEY_NDX1
-- Generated 3/10/2006 17:21:19 from IFRMAXIMO@prodsede2

CREATE UNIQUE INDEX ifrmaximo.autokey_ndx1 ON ifrmaximo.autokey
  (
    tbname                          ASC,
    name                            ASC,
    orgid                           ASC,
    siteid                          ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
  TABLESPACE  tsi_maximo
  STORAGE   (
    INITIAL     65536
    MINEXTENTS  1
    MAXEXTENTS  2147483645
  )
/


-- End of DDL Script for Index IFRMAXIMO.AUTOKEY_NDX1

-- Start of DDL Script for Index IFRMAXIMO.BOOKMARK_NDX1
-- Generated 3/10/2006 17:21:19 from IFRMAXIMO@prodsede2

CREATE UNIQUE INDEX ifrmaximo.bookmark_ndx1 ON ifrmaximo.bookmark
  (
    siteid                          ASC,
    username                        ASC,
    app                             ASC,
    keyvalue                        ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
  TABLESPACE  tsi_maximo
  STORAGE   (
    INITIAL     65536
    MINEXTENTS  1
    MAXEXTENTS  2147483645
  )
/


-- End of DDL Script for Index IFRMAXIMO.BOOKMARK_NDX1

-- Start of DDL Script for Index IFRMAXIMO.CAL
-- Generated 3/10/2006 17:21:19 from IFRMAXIMO@prodsede2

CREATE UNIQUE INDEX ifrmaximo.cal ON ifrmaximo.item
  (
    itemnum                         ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
  TABLESPACE  tsi_maximo
  STORAGE   (
    INITIAL     65536
    MINEXTENTS  1
    MAXEXTENTS  2147483645
  )
/


-- End of DDL Script for Index IFRMAXIMO.CAL

-- Start of DDL Script for Index IFRMAXIMO.CALENDAR_NDX
-- Generated 3/10/2006 17:21:19 from IFRMAXIMO@prodsede2

CREATE UNIQUE INDEX ifrmaximo.calendar_ndx ON ifrmaximo.calendar
  (
    orgid                           ASC,
    calnum                          ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
  TABLESPACE  tsi_maximo
  STORAGE   (
    INITIAL     65536
    MINEXTENTS  1
    MAXEXTENTS  2147483645
  )
/


-- End of DDL Script for Index IFRMAXIMO.CALENDAR_NDX

-- Start of DDL Script for Index IFRMAXIMO.CLASSSPEC_NDX1
-- Generated 3/10/2006 17:21:19 from IFRMAXIMO@prodsede2

CREATE UNIQUE INDEX ifrmaximo.classspec_ndx1 ON ifrmaximo.classspec
  (
    orgid                           ASC,
    classstructureid                ASC,
    assetattrid                     ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
  TABLESPACE  tsi_maximo
  STORAGE   (
    INITIAL     65536
    MINEXTENTS  1
    MAXEXTENTS  2147483645
  )
/


-- End of DDL Script for Index IFRMAXIMO.CLASSSPEC_NDX1

-- Start of DDL Script for Index IFRMAXIMO.CLASSSTRUCT_NDX1
-- Generated 3/10/2006 17:21:19 from IFRMAXIMO@prodsede2

CREATE UNIQUE INDEX ifrmaximo.classstruct_ndx1 ON ifrmaximo.classstructure
  (
    orgid                           ASC,
    classstructureid                ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
  TABLESPACE  tsi_maximo
  STORAGE   (
    INITIAL     65536
    MINEXTENTS  1
    MAXEXTENTS  2147483645
  )
/


-- End of DDL Script for Index IFRMAXIMO.CLASSSTRUCT_NDX1

-- Start of DDL Script for Index IFRMAXIMO.CLASSSTRUCT_NDX2
-- Generated 3/10/2006 17:21:20 from IFRMAXIMO@prodsede2

CREATE UNIQUE INDEX ifrmaximo.classstruct_ndx2 ON ifrmaximo.classstructure
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
  TABLESPACE  tsi_maximo
  STORAGE   (
    INITIAL     65536
    MINEXTENTS  1
    MAXEXTENTS  2147483645
  )
/


-- End of DDL Script for Index IFRMAXIMO.CLASSSTRUCT_NDX2

-- Start of DDL Script for Index IFRMAXIMO.CLASSSTRUCTLNK_NDX
-- Generated 3/10/2006 17:21:20 from IFRMAXIMO@prodsede2

CREATE UNIQUE INDEX ifrmaximo.classstructlnk_ndx ON ifrmaximo.classstructlink
  (
    orgid                           ASC,
    classificationid                ASC,
    classstructureid                ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
  TABLESPACE  tsi_maximo
  STORAGE   (
    INITIAL     65536
    MINEXTENTS  1
    MAXEXTENTS  2147483645
  )
/


-- End of DDL Script for Index IFRMAXIMO.CLASSSTRUCTLNK_NDX

-- Start of DDL Script for Index IFRMAXIMO.COA_NDX1
-- Generated 3/10/2006 17:21:20 from IFRMAXIMO@prodsede2

CREATE UNIQUE INDEX ifrmaximo.coa_ndx1 ON ifrmaximo.chartofaccounts
  (
    orgid                           ASC,
    glaccount                       ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
  TABLESPACE  tsi_maximo
  STORAGE   (
    INITIAL     65536
    MINEXTENTS  1
    MAXEXTENTS  2147483645
  )
/


-- End of DDL Script for Index IFRMAXIMO.COA_NDX1

-- Start of DDL Script for Index IFRMAXIMO.COA_NDX2
-- Generated 3/10/2006 17:21:20 from IFRMAXIMO@prodsede2

CREATE INDEX ifrmaximo.coa_ndx2 ON ifrmaximo.chartofaccounts
  (
    orgid                           ASC,
    glacctype                       ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
  TABLESPACE  tsi_maximo
  STORAGE   (
    INITIAL     65536
    MINEXTENTS  1
    MAXEXTENTS  2147483645
  )
/


-- End of DDL Script for Index IFRMAXIMO.COA_NDX2

-- Start of DDL Script for Index IFRMAXIMO.COA_NDX3
-- Generated 3/10/2006 17:21:20 from IFRMAXIMO@prodsede2

CREATE INDEX ifrmaximo.coa_ndx3 ON ifrmaximo.chartofaccounts
  (
    orgid                           ASC,
    glcomp01                        ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
  TABLESPACE  tsi_maximo
  STORAGE   (
    INITIAL     65536
    MINEXTENTS  1
    MAXEXTENTS  2147483645
  )
/


-- End of DDL Script for Index IFRMAXIMO.COA_NDX3

-- Start of DDL Script for Index IFRMAXIMO.COA_NDX4
-- Generated 3/10/2006 17:21:20 from IFRMAXIMO@prodsede2

CREATE INDEX ifrmaximo.coa_ndx4 ON ifrmaximo.chartofaccounts
  (
    orgid                           ASC,
    interid                         ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
  TABLESPACE  tsi_maximo
  STORAGE   (
    INITIAL     65536
    MINEXTENTS  1
    MAXEXTENTS  2147483645
  )
/


-- End of DDL Script for Index IFRMAXIMO.COA_NDX4

-- Start of DDL Script for Index IFRMAXIMO.COMMODITYAUTH_NDX1
-- Generated 3/10/2006 17:21:21 from IFRMAXIMO@prodsede2

CREATE UNIQUE INDEX ifrmaximo.commodityauth_ndx1 ON ifrmaximo.commodityauth
  (
    orgid                           ASC,
    grpname                         ASC,
    classstructureid                ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
  TABLESPACE  tsi_maximo
  STORAGE   (
    INITIAL     65536
    MINEXTENTS  1
    MAXEXTENTS  2147483645
  )
/


-- End of DDL Script for Index IFRMAXIMO.COMMODITYAUTH_NDX1

-- Start of DDL Script for Index IFRMAXIMO.COMPANIES_NDX2
-- Generated 3/10/2006 17:21:21 from IFRMAXIMO@prodsede2

CREATE INDEX ifrmaximo.companies_ndx2 ON ifrmaximo.companies
  (
    orgid                           ASC,
    type                            ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
  TABLESPACE  tsi_maximo
  STORAGE   (
    INITIAL     65536
    MINEXTENTS  1
    MAXEXTENTS  2147483645
  )
/


-- End of DDL Script for Index IFRMAXIMO.COMPANIES_NDX2

-- Start of DDL Script for Index IFRMAXIMO.COMPANIES_NDX3
-- Generated 3/10/2006 17:21:21 from IFRMAXIMO@prodsede2

CREATE INDEX ifrmaximo.companies_ndx3 ON ifrmaximo.companies
  (
    orgid                           ASC,
    interid                         ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
  TABLESPACE  tsi_maximo
  STORAGE   (
    INITIAL     65536
    MINEXTENTS  1
    MAXEXTENTS  2147483645
  )
/


-- End of DDL Script for Index IFRMAXIMO.COMPANIES_NDX3

-- Start of DDL Script for Index IFRMAXIMO.COMPANY_NDX
-- Generated 3/10/2006 17:21:21 from IFRMAXIMO@prodsede2

CREATE UNIQUE INDEX ifrmaximo.company_ndx ON ifrmaximo.companies
  (
    orgid                           ASC,
    company                         ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
  TABLESPACE  tsi_maximo
  STORAGE   (
    INITIAL     65536
    MINEXTENTS  1
    MAXEXTENTS  2147483645
  )
/


-- End of DDL Script for Index IFRMAXIMO.COMPANY_NDX

-- Start of DDL Script for Index IFRMAXIMO.COMPCONTACT_NDX1
-- Generated 3/10/2006 17:21:21 from IFRMAXIMO@prodsede2

CREATE UNIQUE INDEX ifrmaximo.compcontact_ndx1 ON ifrmaximo.compcontact
  (
    orgid                           ASC,
    company                         ASC,
    contact                         ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
  TABLESPACE  tsi_maximo
  STORAGE   (
    INITIAL     65536
    MINEXTENTS  1
    MAXEXTENTS  2147483645
  )
/


-- End of DDL Script for Index IFRMAXIMO.COMPCONTACT_NDX1

-- Start of DDL Script for Index IFRMAXIMO.CPNYACCTDFLT_NDX1
-- Generated 3/10/2006 17:21:21 from IFRMAXIMO@prodsede2

CREATE UNIQUE INDEX ifrmaximo.cpnyacctdflt_ndx1 ON ifrmaximo.companyaccdef
  (
    orgid                           ASC,
    type                            ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
  TABLESPACE  tsi_maximo
  STORAGE   (
    INITIAL     65536
    MINEXTENTS  1
    MAXEXTENTS  2147483645
  )
/


-- End of DDL Script for Index IFRMAXIMO.CPNYACCTDFLT_NDX1

-- Start of DDL Script for Index IFRMAXIMO.CROSSOVER_NDX1
-- Generated 3/10/2006 17:21:22 from IFRMAXIMO@prodsede2

CREATE UNIQUE INDEX ifrmaximo.crossover_ndx1 ON ifrmaximo.crossoverdomain
  (
    domainid                        ASC,
    sourcefield                     ASC,
    destfield                       ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
  TABLESPACE  tsi_maximo
  STORAGE   (
    INITIAL     65536
    MINEXTENTS  1
    MAXEXTENTS  2147483645
  )
/


-- End of DDL Script for Index IFRMAXIMO.CROSSOVER_NDX1

-- Start of DDL Script for Index IFRMAXIMO.CURRENCY_NDX
-- Generated 3/10/2006 17:21:22 from IFRMAXIMO@prodsede2

CREATE UNIQUE INDEX ifrmaximo.currency_ndx ON ifrmaximo.currency
  (
    currencycode                    ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
  TABLESPACE  tsi_maximo
  STORAGE   (
    INITIAL     65536
    MINEXTENTS  1
    MAXEXTENTS  2147483645
  )
/


-- End of DDL Script for Index IFRMAXIMO.CURRENCY_NDX

-- Start of DDL Script for Index IFRMAXIMO.DEFAULTQUERY_NDX1
-- Generated 3/10/2006 17:21:22 from IFRMAXIMO@prodsede2

CREATE UNIQUE INDEX ifrmaximo.defaultquery_ndx1 ON ifrmaximo.defaultquery
  (
    siteid                          ASC,
    username                        ASC,
    app                             ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
  TABLESPACE  tsi_maximo
  STORAGE   (
    INITIAL     65536
    MINEXTENTS  1
    MAXEXTENTS  2147483645
  )
/


-- End of DDL Script for Index IFRMAXIMO.DEFAULTQUERY_NDX1

-- Start of DDL Script for Index IFRMAXIMO.DESKTOPDFLTS_NDX
-- Generated 3/10/2006 17:21:22 from IFRMAXIMO@prodsede2

CREATE UNIQUE INDEX ifrmaximo.desktopdflts_ndx ON ifrmaximo.desktopdflts
  (
    username                        ASC,
    app                             ASC,
    screen                          ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
  TABLESPACE  tsi_maximo
  STORAGE   (
    INITIAL     65536
    MINEXTENTS  1
    MAXEXTENTS  2147483645
  )
/


-- End of DDL Script for Index IFRMAXIMO.DESKTOPDFLTS_NDX

-- Start of DDL Script for Index IFRMAXIMO.DMSAPISETTING_NDX1
-- Generated 3/10/2006 17:21:22 from IFRMAXIMO@prodsede2

CREATE UNIQUE INDEX ifrmaximo.dmsapisetting_ndx1 ON ifrmaximo.dmsapisetting
  (
    dmsname                         ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
  TABLESPACE  tsi_maximo
  STORAGE   (
    INITIAL     65536
    MINEXTENTS  1
    MAXEXTENTS  2147483645
  )
/


-- End of DDL Script for Index IFRMAXIMO.DMSAPISETTING_NDX1

-- Start of DDL Script for Index IFRMAXIMO.DOCINFO_NDX1
-- Generated 3/10/2006 17:21:23 from IFRMAXIMO@prodsede2

CREATE UNIQUE INDEX ifrmaximo.docinfo_ndx1 ON ifrmaximo.docinfo
  (
    siteid                          ASC,
    document                        ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
  TABLESPACE  tsi_maximo
  STORAGE   (
    INITIAL     65536
    MINEXTENTS  1
    MAXEXTENTS  2147483645
  )
/


-- End of DDL Script for Index IFRMAXIMO.DOCINFO_NDX1

-- Start of DDL Script for Index IFRMAXIMO.DOCLINKS_NDX1
-- Generated 3/10/2006 17:21:23 from IFRMAXIMO@prodsede2

CREATE UNIQUE INDEX ifrmaximo.doclinks_ndx1 ON ifrmaximo.doclinks
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
  TABLESPACE  tsi_maximo
  STORAGE   (
    INITIAL     65536
    MINEXTENTS  1
    MAXEXTENTS  2147483645
  )
/


-- End of DDL Script for Index IFRMAXIMO.DOCLINKS_NDX1

-- Start of DDL Script for Index IFRMAXIMO.DOCLINKS_NDX2
-- Generated 3/10/2006 17:21:23 from IFRMAXIMO@prodsede2

CREATE INDEX ifrmaximo.doclinks_ndx2 ON ifrmaximo.doclinks
  (
    siteid                          ASC,
    document                        ASC,
    reference                       ASC,
    keyvalue                        ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
  TABLESPACE  tsi_maximo
  STORAGE   (
    INITIAL     65536
    MINEXTENTS  1
    MAXEXTENTS  2147483645
  )
/


-- End of DDL Script for Index IFRMAXIMO.DOCLINKS_NDX2

-- Start of DDL Script for Index IFRMAXIMO.DOCLINKS_NDX3
-- Generated 3/10/2006 17:21:23 from IFRMAXIMO@prodsede2

CREATE INDEX ifrmaximo.doclinks_ndx3 ON ifrmaximo.doclinks
  (
    siteid                          ASC,
    keytable                        ASC,
    keycolumn                       ASC,
    keyvalue                        ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
  TABLESPACE  tsi_maximo
  STORAGE   (
    INITIAL     65536
    MINEXTENTS  1
    MAXEXTENTS  2147483645
  )
/


-- End of DDL Script for Index IFRMAXIMO.DOCLINKS_NDX3

-- Start of DDL Script for Index IFRMAXIMO.DOCTYPES_NDX1
-- Generated 3/10/2006 17:21:23 from IFRMAXIMO@prodsede2

CREATE UNIQUE INDEX ifrmaximo.doctypes_ndx1 ON ifrmaximo.doctypes
  (
    siteid                          ASC,
    doctype                         ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
  TABLESPACE  tsi_maximo
  STORAGE   (
    INITIAL     65536
    MINEXTENTS  1
    MAXEXTENTS  2147483645
  )
/


-- End of DDL Script for Index IFRMAXIMO.DOCTYPES_NDX1

-- Start of DDL Script for Index IFRMAXIMO.DUMMY_TABLE_NDX1
-- Generated 3/10/2006 17:21:23 from IFRMAXIMO@prodsede2

CREATE UNIQUE INDEX ifrmaximo.dummy_table_ndx1 ON ifrmaximo.dummy_table
  (
    dummy_aln                       ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
  TABLESPACE  tsi_maximo
  STORAGE   (
    INITIAL     65536
    MINEXTENTS  1
    MAXEXTENTS  2147483645
  )
/


-- End of DDL Script for Index IFRMAXIMO.DUMMY_TABLE_NDX1

-- Start of DDL Script for Index IFRMAXIMO.EQHIER_NDX
-- Generated 3/10/2006 17:21:24 from IFRMAXIMO@prodsede2

CREATE UNIQUE INDEX ifrmaximo.eqhier_ndx ON ifrmaximo.eqhierarchy
  (
    siteid                          ASC,
    wonum                           ASC,
    eqnum                           ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
  TABLESPACE  tsi_maximo
  STORAGE   (
    INITIAL     65536
    MINEXTENTS  1
    MAXEXTENTS  2147483645
  )
/


-- End of DDL Script for Index IFRMAXIMO.EQHIER_NDX

-- Start of DDL Script for Index IFRMAXIMO.EQHIST_NDX1
-- Generated 3/10/2006 17:21:24 from IFRMAXIMO@prodsede2

CREATE INDEX ifrmaximo.eqhist_ndx1 ON ifrmaximo.eqhistory
  (
    siteid                          ASC,
    wonum                           ASC,
    eqnum                           ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
  TABLESPACE  tsi_maximo
  STORAGE   (
    INITIAL     65536
    MINEXTENTS  1
    MAXEXTENTS  2147483645
  )
/


-- End of DDL Script for Index IFRMAXIMO.EQHIST_NDX1

-- Start of DDL Script for Index IFRMAXIMO.EQHIST_NDX2
-- Generated 3/10/2006 17:21:24 from IFRMAXIMO@prodsede2

CREATE INDEX ifrmaximo.eqhist_ndx2 ON ifrmaximo.eqhistory
  (
    eqnum                           ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
  TABLESPACE  tsi_maximo
  STORAGE   (
    INITIAL     65536
    MINEXTENTS  1
    MAXEXTENTS  2147483645
  )
/


-- End of DDL Script for Index IFRMAXIMO.EQHIST_NDX2

-- Start of DDL Script for Index IFRMAXIMO.EQSPEC_NDX1
-- Generated 3/10/2006 17:21:24 from IFRMAXIMO@prodsede2

CREATE UNIQUE INDEX ifrmaximo.eqspec_ndx1 ON ifrmaximo.equipmentspec
  (
    siteid                          ASC,
    eqnum                           ASC,
    assetattrid                     ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
  TABLESPACE  tsi_maximo
  STORAGE   (
    INITIAL     65536
    MINEXTENTS  1
    MAXEXTENTS  2147483645
  )
/


-- End of DDL Script for Index IFRMAXIMO.EQSPEC_NDX1

-- Start of DDL Script for Index IFRMAXIMO.EQSPEC_NDX2
-- Generated 3/10/2006 17:21:24 from IFRMAXIMO@prodsede2

CREATE INDEX ifrmaximo.eqspec_ndx2 ON ifrmaximo.equipmentspec
  (
    siteid                          ASC,
    classstructureid                ASC,
    assetattrid                     ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
  TABLESPACE  tsi_maximo
  STORAGE   (
    INITIAL     65536
    MINEXTENTS  1
    MAXEXTENTS  2147483645
  )
/


-- End of DDL Script for Index IFRMAXIMO.EQSPEC_NDX2

-- Start of DDL Script for Index IFRMAXIMO.EQSPEC_NDX3
-- Generated 3/10/2006 17:21:24 from IFRMAXIMO@prodsede2

CREATE INDEX ifrmaximo.eqspec_ndx3 ON ifrmaximo.equipmentspec
  (
    siteid                          ASC,
    assetattrid                     ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
  TABLESPACE  tsi_maximo
  STORAGE   (
    INITIAL     65536
    MINEXTENTS  1
    MAXEXTENTS  2147483645
  )
/


-- End of DDL Script for Index IFRMAXIMO.EQSPEC_NDX3

-- Start of DDL Script for Index IFRMAXIMO.EQSTATUS_NDX1
-- Generated 3/10/2006 17:21:24 from IFRMAXIMO@prodsede2

CREATE INDEX ifrmaximo.eqstatus_ndx1 ON ifrmaximo.eqstatus
  (
    siteid                          ASC,
    changedate                      ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
  TABLESPACE  tsi_maximo
  STORAGE   (
    INITIAL     65536
    MINEXTENTS  1
    MAXEXTENTS  2147483645
  )
/


-- End of DDL Script for Index IFRMAXIMO.EQSTATUS_NDX1

-- Start of DDL Script for Index IFRMAXIMO.EQSTATUS_NDX2
-- Generated 3/10/2006 17:21:25 from IFRMAXIMO@prodsede2

CREATE INDEX ifrmaximo.eqstatus_ndx2 ON ifrmaximo.eqstatus
  (
    siteid                          ASC,
    eqnum                           ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
  TABLESPACE  tsi_maximo
  STORAGE   (
    INITIAL     65536
    MINEXTENTS  1
    MAXEXTENTS  2147483645
  )
/


-- End of DDL Script for Index IFRMAXIMO.EQSTATUS_NDX2

-- Start of DDL Script for Index IFRMAXIMO.EQSTATUS_NDX3
-- Generated 3/10/2006 17:21:25 from IFRMAXIMO@prodsede2

CREATE INDEX ifrmaximo.eqstatus_ndx3 ON ifrmaximo.eqstatus
  (
    siteid                          ASC,
    isrunning                       ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
  TABLESPACE  tsi_maximo
  STORAGE   (
    INITIAL     65536
    MINEXTENTS  1
    MAXEXTENTS  2147483645
  )
/


-- End of DDL Script for Index IFRMAXIMO.EQSTATUS_NDX3

-- Start of DDL Script for Index IFRMAXIMO.EQSTATUS_NDX4
-- Generated 3/10/2006 17:21:25 from IFRMAXIMO@prodsede2

CREATE INDEX ifrmaximo.eqstatus_ndx4 ON ifrmaximo.eqstatus
  (
    siteid                          ASC,
    wonum                           ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
  TABLESPACE  tsi_maximo
  STORAGE   (
    INITIAL     65536
    MINEXTENTS  1
    MAXEXTENTS  2147483645
  )
/


-- End of DDL Script for Index IFRMAXIMO.EQSTATUS_NDX4

-- Start of DDL Script for Index IFRMAXIMO.EQTRANS_NDX1
-- Generated 3/10/2006 17:21:25 from IFRMAXIMO@prodsede2

CREATE INDEX ifrmaximo.eqtrans_ndx1 ON ifrmaximo.eqtrans
  (
    siteid                          ASC,
    transdate                       ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
  TABLESPACE  tsi_maximo
  STORAGE   (
    INITIAL     65536
    MINEXTENTS  1
    MAXEXTENTS  2147483645
  )
/


-- End of DDL Script for Index IFRMAXIMO.EQTRANS_NDX1

-- Start of DDL Script for Index IFRMAXIMO.EQTRANS_NDX2
-- Generated 3/10/2006 17:21:25 from IFRMAXIMO@prodsede2

CREATE INDEX ifrmaximo.eqtrans_ndx2 ON ifrmaximo.eqtrans
  (
    siteid                          ASC,
    eqnum                           ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
  TABLESPACE  tsi_maximo
  STORAGE   (
    INITIAL     65536
    MINEXTENTS  1
    MAXEXTENTS  2147483645
  )
/


-- End of DDL Script for Index IFRMAXIMO.EQTRANS_NDX2

-- Start of DDL Script for Index IFRMAXIMO.EQUIPMENT_NDX1
-- Generated 3/10/2006 17:21:25 from IFRMAXIMO@prodsede2

CREATE UNIQUE INDEX ifrmaximo.equipment_ndx1 ON ifrmaximo.equipment
  (
    siteid                          ASC,
    eqnum                           ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
  TABLESPACE  tsi_maximo
  STORAGE   (
    INITIAL     65536
    MINEXTENTS  1
    MAXEXTENTS  2147483645
  )
/


-- End of DDL Script for Index IFRMAXIMO.EQUIPMENT_NDX1

-- Start of DDL Script for Index IFRMAXIMO.EQUIPMENT_NDX2
-- Generated 3/10/2006 17:21:26 from IFRMAXIMO@prodsede2

CREATE INDEX ifrmaximo.equipment_ndx2 ON ifrmaximo.equipment
  (
    siteid                          ASC,
    parent                          ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
  TABLESPACE  tsi_maximo
  STORAGE   (
    INITIAL     65536
    MINEXTENTS  1
    MAXEXTENTS  2147483645
  )
/


-- End of DDL Script for Index IFRMAXIMO.EQUIPMENT_NDX2

-- Start of DDL Script for Index IFRMAXIMO.EQUIPMENT_NDX3
-- Generated 3/10/2006 17:21:26 from IFRMAXIMO@prodsede2

CREATE INDEX ifrmaximo.equipment_ndx3 ON ifrmaximo.equipment
  (
    siteid                          ASC,
    vendor                          ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
  TABLESPACE  tsi_maximo
  STORAGE   (
    INITIAL     65536
    MINEXTENTS  1
    MAXEXTENTS  2147483645
  )
/


-- End of DDL Script for Index IFRMAXIMO.EQUIPMENT_NDX3

-- Start of DDL Script for Index IFRMAXIMO.EQUIPMENT_NDX4
-- Generated 3/10/2006 17:21:26 from IFRMAXIMO@prodsede2

CREATE INDEX ifrmaximo.equipment_ndx4 ON ifrmaximo.equipment
  (
    siteid                          ASC,
    calnum                          ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
  TABLESPACE  tsi_maximo
  STORAGE   (
    INITIAL     65536
    MINEXTENTS  1
    MAXEXTENTS  2147483645
  )
/


-- End of DDL Script for Index IFRMAXIMO.EQUIPMENT_NDX4

-- Start of DDL Script for Index IFRMAXIMO.EQUIPMENT_NDX5
-- Generated 3/10/2006 17:21:26 from IFRMAXIMO@prodsede2

CREATE INDEX ifrmaximo.equipment_ndx5 ON ifrmaximo.equipment
  (
    siteid                          ASC,
    itemnum                         ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
  TABLESPACE  tsi_maximo
  STORAGE   (
    INITIAL     65536
    MINEXTENTS  1
    MAXEXTENTS  2147483645
  )
/


-- End of DDL Script for Index IFRMAXIMO.EQUIPMENT_NDX5

-- Start of DDL Script for Index IFRMAXIMO.EQUIPMENT_NDX6
-- Generated 3/10/2006 17:21:26 from IFRMAXIMO@prodsede2

CREATE INDEX ifrmaximo.equipment_ndx6 ON ifrmaximo.equipment
  (
    siteid                          ASC,
    location                        ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
  TABLESPACE  tsi_maximo
  STORAGE   (
    INITIAL     65536
    MINEXTENTS  1
    MAXEXTENTS  2147483645
  )
/


-- End of DDL Script for Index IFRMAXIMO.EQUIPMENT_NDX6

-- Start of DDL Script for Index IFRMAXIMO.EXCHANGE_NDX
-- Generated 3/10/2006 17:21:26 from IFRMAXIMO@prodsede2

CREATE UNIQUE INDEX ifrmaximo.exchange_ndx ON ifrmaximo.exchange
  (
    orgid                           ASC,
    currencycode                    ASC,
    currencycodeto                  ASC,
    expiredate                      ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
  TABLESPACE  tsi_maximo
  STORAGE   (
    INITIAL     65536
    MINEXTENTS  1
    MAXEXTENTS  2147483645
  )
/


-- End of DDL Script for Index IFRMAXIMO.EXCHANGE_NDX

-- Start of DDL Script for Index IFRMAXIMO.FAILLIST_NDX
-- Generated 3/10/2006 17:21:27 from IFRMAXIMO@prodsede2

CREATE UNIQUE INDEX ifrmaximo.faillist_ndx ON ifrmaximo.failurelist
  (
    orgid                           ASC,
    failurelist                     ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
  TABLESPACE  tsi_maximo
  STORAGE   (
    INITIAL     65536
    MINEXTENTS  1
    MAXEXTENTS  2147483645
  )
/


-- End of DDL Script for Index IFRMAXIMO.FAILLIST_NDX

-- Start of DDL Script for Index IFRMAXIMO.FAILLIST_NDX2
-- Generated 3/10/2006 17:21:27 from IFRMAXIMO@prodsede2

CREATE INDEX ifrmaximo.faillist_ndx2 ON ifrmaximo.failurelist
  (
    orgid                           ASC,
    failurecode                     ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
  TABLESPACE  tsi_maximo
  STORAGE   (
    INITIAL     65536
    MINEXTENTS  1
    MAXEXTENTS  2147483645
  )
/


-- End of DDL Script for Index IFRMAXIMO.FAILLIST_NDX2

-- Start of DDL Script for Index IFRMAXIMO.FAILLIST_NDX3
-- Generated 3/10/2006 17:21:27 from IFRMAXIMO@prodsede2

CREATE INDEX ifrmaximo.faillist_ndx3 ON ifrmaximo.failurelist
  (
    orgid                           ASC,
    parent                          ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
  TABLESPACE  tsi_maximo
  STORAGE   (
    INITIAL     65536
    MINEXTENTS  1
    MAXEXTENTS  2147483645
  )
/


-- End of DDL Script for Index IFRMAXIMO.FAILLIST_NDX3

-- Start of DDL Script for Index IFRMAXIMO.FAILREMARK_NDX
-- Generated 3/10/2006 17:21:27 from IFRMAXIMO@prodsede2

CREATE UNIQUE INDEX ifrmaximo.failremark_ndx ON ifrmaximo.failureremark
  (
    siteid                          ASC,
    wonum                           ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
  TABLESPACE  tsi_maximo
  STORAGE   (
    INITIAL     65536
    MINEXTENTS  1
    MAXEXTENTS  2147483645
  )
/


-- End of DDL Script for Index IFRMAXIMO.FAILREMARK_NDX

-- Start of DDL Script for Index IFRMAXIMO.FAILREPORT_NDX1
-- Generated 3/10/2006 17:21:27 from IFRMAXIMO@prodsede2

CREATE INDEX ifrmaximo.failreport_ndx1 ON ifrmaximo.failurereport
  (
    siteid                          ASC,
    wonum                           ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
  TABLESPACE  tsi_maximo
  STORAGE   (
    INITIAL     65536
    MINEXTENTS  1
    MAXEXTENTS  2147483645
  )
/


-- End of DDL Script for Index IFRMAXIMO.FAILREPORT_NDX1

-- Start of DDL Script for Index IFRMAXIMO.FAILREPORT_NDX2
-- Generated 3/10/2006 17:21:27 from IFRMAXIMO@prodsede2

CREATE INDEX ifrmaximo.failreport_ndx2 ON ifrmaximo.failurereport
  (
    siteid                          ASC,
    linenum                         ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
  TABLESPACE  tsi_maximo
  STORAGE   (
    INITIAL     65536
    MINEXTENTS  1
    MAXEXTENTS  2147483645
  )
/


-- End of DDL Script for Index IFRMAXIMO.FAILREPORT_NDX2

-- Start of DDL Script for Index IFRMAXIMO.FAILURECODE_NDX
-- Generated 3/10/2006 17:21:28 from IFRMAXIMO@prodsede2

CREATE UNIQUE INDEX ifrmaximo.failurecode_ndx ON ifrmaximo.failurecode
  (
    orgid                           ASC,
    failurecode                     ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
  TABLESPACE  tsi_maximo
  STORAGE   (
    INITIAL     65536
    MINEXTENTS  1
    MAXEXTENTS  2147483645
  )
/


-- End of DDL Script for Index IFRMAXIMO.FAILURECODE_NDX

-- Start of DDL Script for Index IFRMAXIMO.FIELDDEFAULTS_NDX
-- Generated 3/10/2006 17:21:28 from IFRMAXIMO@prodsede2

CREATE UNIQUE INDEX ifrmaximo.fielddefaults_ndx ON ifrmaximo.fielddefaults
  (
    grpname                         ASC,
    app                             ASC,
    screen                          ASC,
    field                           ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
  TABLESPACE  tsi_maximo
  STORAGE   (
    INITIAL     65536
    MINEXTENTS  1
    MAXEXTENTS  2147483645
  )
/


-- End of DDL Script for Index IFRMAXIMO.FIELDDEFAULTS_NDX

-- Start of DDL Script for Index IFRMAXIMO.FINCNTRL_NDX1
-- Generated 3/10/2006 17:21:28 from IFRMAXIMO@prodsede2

CREATE UNIQUE INDEX ifrmaximo.fincntrl_ndx1 ON ifrmaximo.fincntrl
  (
    orgid                           ASC,
    fincntrlid                      ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
  TABLESPACE  tsi_maximo
  STORAGE   (
    INITIAL     65536
    MINEXTENTS  1
    MAXEXTENTS  2147483645
  )
/


-- End of DDL Script for Index IFRMAXIMO.FINCNTRL_NDX1

-- Start of DDL Script for Index IFRMAXIMO.FINCNTRL_NDX2
-- Generated 3/10/2006 17:21:28 from IFRMAXIMO@prodsede2

CREATE INDEX ifrmaximo.fincntrl_ndx2 ON ifrmaximo.fincntrl
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
  TABLESPACE  tsi_maximo
  STORAGE   (
    INITIAL     65536
    MINEXTENTS  1
    MAXEXTENTS  2147483645
  )
/


-- End of DDL Script for Index IFRMAXIMO.FINCNTRL_NDX2

-- Start of DDL Script for Index IFRMAXIMO.FPERIOD_NDX1
-- Generated 3/10/2006 17:21:28 from IFRMAXIMO@prodsede2

CREATE UNIQUE INDEX ifrmaximo.fperiod_ndx1 ON ifrmaximo.financialperiods
  (
    orgid                           ASC,
    financialperiod                 ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
  TABLESPACE  tsi_maximo
  STORAGE   (
    INITIAL     65536
    MINEXTENTS  1
    MAXEXTENTS  2147483645
  )
/


-- End of DDL Script for Index IFRMAXIMO.FPERIOD_NDX1

-- Start of DDL Script for Index IFRMAXIMO.FPERIOD_NDX2
-- Generated 3/10/2006 17:21:28 from IFRMAXIMO@prodsede2

CREATE INDEX ifrmaximo.fperiod_ndx2 ON ifrmaximo.financialperiods
  (
    orgid                           ASC,
    periodstart                     ASC,
    periodend                       ASC,
    periodclosedate                 ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
  TABLESPACE  tsi_maximo
  STORAGE   (
    INITIAL     65536
    MINEXTENTS  1
    MAXEXTENTS  2147483645
  )
/


-- End of DDL Script for Index IFRMAXIMO.FPERIOD_NDX2

-- Start of DDL Script for Index IFRMAXIMO.GLCFG_NDX1
-- Generated 3/10/2006 17:21:29 from IFRMAXIMO@prodsede2

CREATE UNIQUE INDEX ifrmaximo.glcfg_ndx1 ON ifrmaximo.glconfigure
  (
    glorder                         ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
  TABLESPACE  tsi_maximo
  STORAGE   (
    INITIAL     40960
    MINEXTENTS  1
    MAXEXTENTS  2147483645
  )
/


-- End of DDL Script for Index IFRMAXIMO.GLCFG_NDX1

-- Start of DDL Script for Index IFRMAXIMO.GLCOMP_NDX1
-- Generated 3/10/2006 17:21:29 from IFRMAXIMO@prodsede2

CREATE UNIQUE INDEX ifrmaximo.glcomp_ndx1 ON ifrmaximo.glcomponents
  (
    orgid                           ASC,
    glorder                         ASC,
    compvalue                       ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
  TABLESPACE  tsi_maximo
  STORAGE   (
    INITIAL     65536
    MINEXTENTS  1
    MAXEXTENTS  2147483645
  )
/


-- End of DDL Script for Index IFRMAXIMO.GLCOMP_NDX1

-- Start of DDL Script for Index IFRMAXIMO.GLCOMP_NDX2
-- Generated 3/10/2006 17:21:29 from IFRMAXIMO@prodsede2

CREATE INDEX ifrmaximo.glcomp_ndx2 ON ifrmaximo.glcomponents
  (
    orgid                           ASC,
    interid                         ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
  TABLESPACE  tsi_maximo
  STORAGE   (
    INITIAL     65536
    MINEXTENTS  1
    MAXEXTENTS  2147483645
  )
/


-- End of DDL Script for Index IFRMAXIMO.GLCOMP_NDX2

-- Start of DDL Script for Index IFRMAXIMO.GROUPRESTR_NDX1
-- Generated 3/10/2006 17:21:29 from IFRMAXIMO@prodsede2

CREATE UNIQUE INDEX ifrmaximo.grouprestr_ndx1 ON ifrmaximo.grouprestriction
  (
    orgid                           ASC,
    grpname                         ASC,
    tbname                          ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
  TABLESPACE  tsi_maximo
  STORAGE   (
    INITIAL     65536
    MINEXTENTS  1
    MAXEXTENTS  2147483645
  )
/


-- End of DDL Script for Index IFRMAXIMO.GROUPRESTR_NDX1

-- Start of DDL Script for Index IFRMAXIMO.HAZARD_NDX1
-- Generated 3/10/2006 17:21:29 from IFRMAXIMO@prodsede2

CREATE UNIQUE INDEX ifrmaximo.hazard_ndx1 ON ifrmaximo.hazard
  (
    orgid                           ASC,
    hazardid                        ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
  TABLESPACE  tsi_maximo
  STORAGE   (
    INITIAL     65536
    MINEXTENTS  1
    MAXEXTENTS  2147483645
  )
/


-- End of DDL Script for Index IFRMAXIMO.HAZARD_NDX1

-- Start of DDL Script for Index IFRMAXIMO.HAZARDPREC_NDX1
-- Generated 3/10/2006 17:21:29 from IFRMAXIMO@prodsede2

CREATE UNIQUE INDEX ifrmaximo.hazardprec_ndx1 ON ifrmaximo.hazardprec
  (
    siteid                          ASC,
    hazardid                        ASC,
    precautionid                    ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
  TABLESPACE  tsi_maximo
  STORAGE   (
    INITIAL     65536
    MINEXTENTS  1
    MAXEXTENTS  2147483645
  )
/


-- End of DDL Script for Index IFRMAXIMO.HAZARDPREC_NDX1

-- Start of DDL Script for Index IFRMAXIMO.HH_MES_CAR_OCUP_UK
-- Generated 3/10/2006 17:21:30 from IFRMAXIMO@prodsede2

CREATE UNIQUE INDEX ifrmaximo.hh_mes_car_ocup_uk ON ifrmaximo.homem_hora
  (
    mes_ano                         ASC,
    cargo                           ASC,
    ocupacao                        ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
  TABLESPACE  tsi_maximo
  STORAGE   (
    INITIAL     81920
    MINEXTENTS  1
    MAXEXTENTS  2147483645
  )
/


-- End of DDL Script for Index IFRMAXIMO.HH_MES_CAR_OCUP_UK

-- Start of DDL Script for Index IFRMAXIMO.HOLIDAY_NDX1
-- Generated 3/10/2006 17:21:30 from IFRMAXIMO@prodsede2

CREATE INDEX ifrmaximo.holiday_ndx1 ON ifrmaximo.holiday
  (
    orgid                           ASC,
    holidaydate                     ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
  TABLESPACE  tsi_maximo
  STORAGE   (
    INITIAL     65536
    MINEXTENTS  1
    MAXEXTENTS  2147483645
  )
/


-- End of DDL Script for Index IFRMAXIMO.HOLIDAY_NDX1

-- Start of DDL Script for Index IFRMAXIMO.IDX_TEMP
-- Generated 3/10/2006 17:21:30 from IFRMAXIMO@prodsede2

CREATE INDEX ifrmaximo.idx_temp ON ifrmaximo.matusetrans
  (
    refwo                           ASC,
    itemnum                         ASC,
    storeloc                        ASC,
    transdate                       ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
  TABLESPACE  tsi_maximo
  STORAGE   (
    INITIAL     65536
    MINEXTENTS  1
    MAXEXTENTS  2147483645
  )
/


-- End of DDL Script for Index IFRMAXIMO.IDX_TEMP

-- Start of DDL Script for Index IFRMAXIMO.INVBAL_NDX1
-- Generated 3/10/2006 17:21:30 from IFRMAXIMO@prodsede2

CREATE UNIQUE INDEX ifrmaximo.invbal_ndx1 ON ifrmaximo.invbalances
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
  TABLESPACE  tsi_maximo
  STORAGE   (
    INITIAL     65536
    MINEXTENTS  1
    MAXEXTENTS  2147483645
  )
/


-- End of DDL Script for Index IFRMAXIMO.INVBAL_NDX1

-- Start of DDL Script for Index IFRMAXIMO.INVBAL_NDX2
-- Generated 3/10/2006 17:21:30 from IFRMAXIMO@prodsede2

CREATE INDEX ifrmaximo.invbal_ndx2 ON ifrmaximo.invbalances
  (
    siteid                          ASC,
    interid                         ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
  TABLESPACE  tsi_maximo
  STORAGE   (
    INITIAL     65536
    MINEXTENTS  1
    MAXEXTENTS  2147483645
  )
/


-- End of DDL Script for Index IFRMAXIMO.INVBAL_NDX2

-- Start of DDL Script for Index IFRMAXIMO.INVENTORY_NDX1
-- Generated 3/10/2006 17:21:30 from IFRMAXIMO@prodsede2

CREATE UNIQUE INDEX ifrmaximo.inventory_ndx1 ON ifrmaximo.inventory
  (
    siteid                          ASC,
    itemnum                         ASC,
    location                        ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
  TABLESPACE  tsi_maximo
  STORAGE   (
    INITIAL     65536
    MINEXTENTS  1
    MAXEXTENTS  2147483645
  )
/


-- End of DDL Script for Index IFRMAXIMO.INVENTORY_NDX1

-- Start of DDL Script for Index IFRMAXIMO.INVENTORY_NDX2
-- Generated 3/10/2006 17:21:31 from IFRMAXIMO@prodsede2

CREATE INDEX ifrmaximo.inventory_ndx2 ON ifrmaximo.inventory
  (
    siteid                          ASC,
    location                        ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
  TABLESPACE  tsi_maximo
  STORAGE   (
    INITIAL     65536
    MINEXTENTS  1
    MAXEXTENTS  2147483645
  )
/


-- End of DDL Script for Index IFRMAXIMO.INVENTORY_NDX2

-- Start of DDL Script for Index IFRMAXIMO.INVENTORY_NDX3
-- Generated 3/10/2006 17:21:31 from IFRMAXIMO@prodsede2

CREATE INDEX ifrmaximo.inventory_ndx3 ON ifrmaximo.inventory
  (
    siteid                          ASC,
    interid                         ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
  TABLESPACE  tsi_maximo
  STORAGE   (
    INITIAL     65536
    MINEXTENTS  1
    MAXEXTENTS  2147483645
  )
/


-- End of DDL Script for Index IFRMAXIMO.INVENTORY_NDX3

-- Start of DDL Script for Index IFRMAXIMO.INVLOT_NDX1
-- Generated 3/10/2006 17:21:31 from IFRMAXIMO@prodsede2

CREATE UNIQUE INDEX ifrmaximo.invlot_ndx1 ON ifrmaximo.invlot
  (
    siteid                          ASC,
    lotnum                          ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
  TABLESPACE  tsi_maximo
  STORAGE   (
    INITIAL     65536
    MINEXTENTS  1
    MAXEXTENTS  2147483645
  )
/


-- End of DDL Script for Index IFRMAXIMO.INVLOT_NDX1

-- Start of DDL Script for Index IFRMAXIMO.INVOICE_NDX1
-- Generated 3/10/2006 17:21:31 from IFRMAXIMO@prodsede2

CREATE UNIQUE INDEX ifrmaximo.invoice_ndx1 ON ifrmaximo.invoice
  (
    siteid                          ASC,
    invoicenum                      ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
  TABLESPACE  tsi_maximo
  STORAGE   (
    INITIAL     65536
    MINEXTENTS  1
    MAXEXTENTS  2147483645
  )
/


-- End of DDL Script for Index IFRMAXIMO.INVOICE_NDX1

-- Start of DDL Script for Index IFRMAXIMO.INVOICE_NDX2
-- Generated 3/10/2006 17:21:31 from IFRMAXIMO@prodsede2

CREATE INDEX ifrmaximo.invoice_ndx2 ON ifrmaximo.invoice
  (
    siteid                          ASC,
    vendor                          ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
  TABLESPACE  tsi_maximo
  STORAGE   (
    INITIAL     65536
    MINEXTENTS  1
    MAXEXTENTS  2147483645
  )
/


-- End of DDL Script for Index IFRMAXIMO.INVOICE_NDX2

-- Start of DDL Script for Index IFRMAXIMO.INVOICE_NDX3
-- Generated 3/10/2006 17:21:31 from IFRMAXIMO@prodsede2

CREATE INDEX ifrmaximo.invoice_ndx3 ON ifrmaximo.invoice
  (
    siteid                          ASC,
    ponum                           ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
  TABLESPACE  tsi_maximo
  STORAGE   (
    INITIAL     65536
    MINEXTENTS  1
    MAXEXTENTS  2147483645
  )
/


-- End of DDL Script for Index IFRMAXIMO.INVOICE_NDX3

-- Start of DDL Script for Index IFRMAXIMO.INVOICE_NDX4
-- Generated 3/10/2006 17:21:31 from IFRMAXIMO@prodsede2

CREATE INDEX ifrmaximo.invoice_ndx4 ON ifrmaximo.invoice
  (
    siteid                          ASC,
    approvalnum                     ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
  TABLESPACE  tsi_maximo
  STORAGE   (
    INITIAL     65536
    MINEXTENTS  1
    MAXEXTENTS  2147483645
  )
/


-- End of DDL Script for Index IFRMAXIMO.INVOICE_NDX4

-- Start of DDL Script for Index IFRMAXIMO.INVOICE_NDX5
-- Generated 3/10/2006 17:21:32 from IFRMAXIMO@prodsede2

CREATE INDEX ifrmaximo.invoice_ndx5 ON ifrmaximo.invoice
  (
    siteid                          ASC,
    vendorinvoicenum                ASC,
    vendor                          ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
  TABLESPACE  tsi_maximo
  STORAGE   (
    INITIAL     65536
    MINEXTENTS  1
    MAXEXTENTS  2147483645
  )
/


-- End of DDL Script for Index IFRMAXIMO.INVOICE_NDX5

-- Start of DDL Script for Index IFRMAXIMO.INVOICE_NDX6
-- Generated 3/10/2006 17:21:32 from IFRMAXIMO@prodsede2

CREATE INDEX ifrmaximo.invoice_ndx6 ON ifrmaximo.invoice
  (
    siteid                          ASC,
    interid                         ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
  TABLESPACE  tsi_maximo
  STORAGE   (
    INITIAL     65536
    MINEXTENTS  1
    MAXEXTENTS  2147483645
  )
/


-- End of DDL Script for Index IFRMAXIMO.INVOICE_NDX6

-- Start of DDL Script for Index IFRMAXIMO.INVOICE_NDX7
-- Generated 3/10/2006 17:21:32 from IFRMAXIMO@prodsede2

CREATE INDEX ifrmaximo.invoice_ndx7 ON ifrmaximo.invoice
  (
    siteid                          ASC,
    wfid                            ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
  TABLESPACE  tsi_maximo
  STORAGE   (
    INITIAL     65536
    MINEXTENTS  1
    MAXEXTENTS  2147483645
  )
/


-- End of DDL Script for Index IFRMAXIMO.INVOICE_NDX7

-- Start of DDL Script for Index IFRMAXIMO.INVOICECOST_NDX1
-- Generated 3/10/2006 17:21:32 from IFRMAXIMO@prodsede2

CREATE UNIQUE INDEX ifrmaximo.invoicecost_ndx1 ON ifrmaximo.invoicecost
  (
    siteid                          ASC,
    invoicenum                      ASC,
    invoicelinenum                  ASC,
    costlinenum                     ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
  TABLESPACE  tsi_maximo
  STORAGE   (
    INITIAL     65536
    MINEXTENTS  1
    MAXEXTENTS  2147483645
  )
/


-- End of DDL Script for Index IFRMAXIMO.INVOICECOST_NDX1

-- Start of DDL Script for Index IFRMAXIMO.INVOICELINE_NDX1
-- Generated 3/10/2006 17:21:32 from IFRMAXIMO@prodsede2

CREATE UNIQUE INDEX ifrmaximo.invoiceline_ndx1 ON ifrmaximo.invoiceline
  (
    siteid                          ASC,
    invoicenum                      ASC,
    invoicelinenum                  ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
  TABLESPACE  tsi_maximo
  STORAGE   (
    INITIAL     65536
    MINEXTENTS  1
    MAXEXTENTS  2147483645
  )
/


-- End of DDL Script for Index IFRMAXIMO.INVOICELINE_NDX1

-- Start of DDL Script for Index IFRMAXIMO.INVOICELINE_NDX2
-- Generated 3/10/2006 17:21:32 from IFRMAXIMO@prodsede2

CREATE INDEX ifrmaximo.invoiceline_ndx2 ON ifrmaximo.invoiceline
  (
    service                         ASC,
    invoicenum                      ASC,
    itemnum                         ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
  TABLESPACE  tsi_maximo
  STORAGE   (
    INITIAL     65536
    MINEXTENTS  1
    MAXEXTENTS  2147483645
  )
/


-- End of DDL Script for Index IFRMAXIMO.INVOICELINE_NDX2

-- Start of DDL Script for Index IFRMAXIMO.INVOICELINE_NDX3
-- Generated 3/10/2006 17:21:33 from IFRMAXIMO@prodsede2

CREATE INDEX ifrmaximo.invoiceline_ndx3 ON ifrmaximo.invoiceline
  (
    siteid                          ASC,
    invoicenum                      ASC,
    ponum                           ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
  TABLESPACE  tsi_maximo
  STORAGE   (
    INITIAL     65536
    MINEXTENTS  1
    MAXEXTENTS  2147483645
  )
/


-- End of DDL Script for Index IFRMAXIMO.INVOICELINE_NDX3

-- Start of DDL Script for Index IFRMAXIMO.INVOICELINE_NDX4
-- Generated 3/10/2006 17:21:33 from IFRMAXIMO@prodsede2

CREATE INDEX ifrmaximo.invoiceline_ndx4 ON ifrmaximo.invoiceline
  (
    siteid                          ASC,
    ponum                           ASC,
    itemnum                         ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
  TABLESPACE  tsi_maximo
  STORAGE   (
    INITIAL     65536
    MINEXTENTS  1
    MAXEXTENTS  2147483645
  )
/


-- End of DDL Script for Index IFRMAXIMO.INVOICELINE_NDX4

-- Start of DDL Script for Index IFRMAXIMO.INVOICELINE_NDX6
-- Generated 3/10/2006 17:21:33 from IFRMAXIMO@prodsede2

CREATE INDEX ifrmaximo.invoiceline_ndx6 ON ifrmaximo.invoiceline
  (
    invoicenum                      ASC,
    itemnum                         ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
  TABLESPACE  tsi_maximo
  STORAGE   (
    INITIAL     65536
    MINEXTENTS  1
    MAXEXTENTS  2147483645
  )
/


-- End of DDL Script for Index IFRMAXIMO.INVOICELINE_NDX6

-- Start of DDL Script for Index IFRMAXIMO.INVOICELINE_NDX7
-- Generated 3/10/2006 17:21:33 from IFRMAXIMO@prodsede2

CREATE INDEX ifrmaximo.invoiceline_ndx7 ON ifrmaximo.invoiceline
  (
    invoicenum                      ASC,
    ponum                           ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
  TABLESPACE  tsi_maximo
  STORAGE   (
    INITIAL     65536
    MINEXTENTS  1
    MAXEXTENTS  2147483645
  )
/


-- End of DDL Script for Index IFRMAXIMO.INVOICELINE_NDX7

-- Start of DDL Script for Index IFRMAXIMO.INVOICELINE_NDX8
-- Generated 3/10/2006 17:21:33 from IFRMAXIMO@prodsede2

CREATE INDEX ifrmaximo.invoiceline_ndx8 ON ifrmaximo.invoiceline
  (
    ponum                           ASC,
    itemnum                         ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
  TABLESPACE  tsi_maximo
  STORAGE   (
    INITIAL     65536
    MINEXTENTS  1
    MAXEXTENTS  2147483645
  )
/


-- End of DDL Script for Index IFRMAXIMO.INVOICELINE_NDX8

-- Start of DDL Script for Index IFRMAXIMO.INVOICEMTCH_NDX1
-- Generated 3/10/2006 17:21:33 from IFRMAXIMO@prodsede2

CREATE INDEX ifrmaximo.invoicemtch_ndx1 ON ifrmaximo.invoicematch
  (
    siteid                          ASC,
    invoicenum                      ASC,
    invoicelinenum                  ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
  TABLESPACE  tsi_maximo
  STORAGE   (
    INITIAL     65536
    MINEXTENTS  1
    MAXEXTENTS  2147483645
  )
/


-- End of DDL Script for Index IFRMAXIMO.INVOICEMTCH_NDX1

-- Start of DDL Script for Index IFRMAXIMO.INVOICEMTCH_NDX2
-- Generated 3/10/2006 17:21:34 from IFRMAXIMO@prodsede2

CREATE INDEX ifrmaximo.invoicemtch_ndx2 ON ifrmaximo.invoicematch
  (
    siteid                          ASC,
    ponum                           ASC,
    polinenum                       ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
  TABLESPACE  tsi_maximo
  STORAGE   (
    INITIAL     65536
    MINEXTENTS  1
    MAXEXTENTS  2147483645
  )
/


-- End of DDL Script for Index IFRMAXIMO.INVOICEMTCH_NDX2

-- Start of DDL Script for Index IFRMAXIMO.INVOICESTATUS_NDX1
-- Generated 3/10/2006 17:21:34 from IFRMAXIMO@prodsede2

CREATE INDEX ifrmaximo.invoicestatus_ndx1 ON ifrmaximo.invoicestatus
  (
    siteid                          ASC,
    invoicenum                      ASC,
    vendor                          ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
  TABLESPACE  tsi_maximo
  STORAGE   (
    INITIAL     65536
    MINEXTENTS  1
    MAXEXTENTS  2147483645
  )
/


-- End of DDL Script for Index IFRMAXIMO.INVOICESTATUS_NDX1

-- Start of DDL Script for Index IFRMAXIMO.INVOICESTATUS_NDX2
-- Generated 3/10/2006 17:21:34 from IFRMAXIMO@prodsede2

CREATE INDEX ifrmaximo.invoicestatus_ndx2 ON ifrmaximo.invoicestatus
  (
    siteid                          ASC,
    changedate                      ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
  TABLESPACE  tsi_maximo
  STORAGE   (
    INITIAL     65536
    MINEXTENTS  1
    MAXEXTENTS  2147483645
  )
/


-- End of DDL Script for Index IFRMAXIMO.INVOICESTATUS_NDX2

-- Start of DDL Script for Index IFRMAXIMO.INVOICETRANS_NDX1
-- Generated 3/10/2006 17:21:34 from IFRMAXIMO@prodsede2

CREATE INDEX ifrmaximo.invoicetrans_ndx1 ON ifrmaximo.invoicetrans
  (
    siteid                          ASC,
    transdate                       ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
  TABLESPACE  tsi_maximo
  STORAGE   (
    INITIAL     65536
    MINEXTENTS  1
    MAXEXTENTS  2147483645
  )
/


-- End of DDL Script for Index IFRMAXIMO.INVOICETRANS_NDX1

-- Start of DDL Script for Index IFRMAXIMO.INVOICETRANS_NDX2
-- Generated 3/10/2006 17:21:34 from IFRMAXIMO@prodsede2

CREATE INDEX ifrmaximo.invoicetrans_ndx2 ON ifrmaximo.invoicetrans
  (
    siteid                          ASC,
    interid                         ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
  TABLESPACE  tsi_maximo
  STORAGE   (
    INITIAL     65536
    MINEXTENTS  1
    MAXEXTENTS  2147483645
  )
/


-- End of DDL Script for Index IFRMAXIMO.INVOICETRANS_NDX2

-- Start of DDL Script for Index IFRMAXIMO.INVRESERVE_NDX1
-- Generated 3/10/2006 17:21:35 from IFRMAXIMO@prodsede2

CREATE UNIQUE INDEX ifrmaximo.invreserve_ndx1 ON ifrmaximo.invreserve
  (
    siteid                          ASC,
    requestnum                      ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
  TABLESPACE  tsi_maximo
  STORAGE   (
    INITIAL     65536
    MINEXTENTS  1
    MAXEXTENTS  2147483645
  )
/


-- End of DDL Script for Index IFRMAXIMO.INVRESERVE_NDX1

-- Start of DDL Script for Index IFRMAXIMO.INVRESERVE_NDX2
-- Generated 3/10/2006 17:21:35 from IFRMAXIMO@prodsede2

CREATE INDEX ifrmaximo.invreserve_ndx2 ON ifrmaximo.invreserve
  (
    siteid                          ASC,
    itemnum                         ASC,
    location                        ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
  TABLESPACE  tsi_maximo
  STORAGE   (
    INITIAL     65536
    MINEXTENTS  1
    MAXEXTENTS  2147483645
  )
/


-- End of DDL Script for Index IFRMAXIMO.INVRESERVE_NDX2

-- Start of DDL Script for Index IFRMAXIMO.INVRESERVE_NDX3
-- Generated 3/10/2006 17:21:35 from IFRMAXIMO@prodsede2

CREATE INDEX ifrmaximo.invreserve_ndx3 ON ifrmaximo.invreserve
  (
    siteid                          ASC,
    wonum                           ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
  TABLESPACE  tsi_maximo
  STORAGE   (
    INITIAL     65536
    MINEXTENTS  1
    MAXEXTENTS  2147483645
  )
/


-- End of DDL Script for Index IFRMAXIMO.INVRESERVE_NDX3

-- Start of DDL Script for Index IFRMAXIMO.INVRESERVE_NDX4
-- Generated 3/10/2006 17:21:35 from IFRMAXIMO@prodsede2

CREATE INDEX ifrmaximo.invreserve_ndx4 ON ifrmaximo.invreserve
  (
    siteid                          ASC,
    polineid                        ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
  TABLESPACE  tsi_maximo
  STORAGE   (
    INITIAL     65536
    MINEXTENTS  1
    MAXEXTENTS  2147483645
  )
/


-- End of DDL Script for Index IFRMAXIMO.INVRESERVE_NDX4

-- Start of DDL Script for Index IFRMAXIMO.INVRESERVE_NDX5
-- Generated 3/10/2006 17:21:35 from IFRMAXIMO@prodsede2

CREATE INDEX ifrmaximo.invreserve_ndx5 ON ifrmaximo.invreserve
  (
    siteid                          ASC,
    interid                         ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
  TABLESPACE  tsi_maximo
  STORAGE   (
    INITIAL     65536
    MINEXTENTS  1
    MAXEXTENTS  2147483645
  )
/


-- End of DDL Script for Index IFRMAXIMO.INVRESERVE_NDX5

-- Start of DDL Script for Index IFRMAXIMO.INVTRANS_NDX1
-- Generated 3/10/2006 17:21:35 from IFRMAXIMO@prodsede2

CREATE UNIQUE INDEX ifrmaximo.invtrans_ndx1 ON ifrmaximo.invtrans
  (
    siteid                          ASC,
    invtransid                      ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
  TABLESPACE  tsi_maximo
  STORAGE   (
    INITIAL     65536
    MINEXTENTS  1
    MAXEXTENTS  2147483645
  )
/


-- End of DDL Script for Index IFRMAXIMO.INVTRANS_NDX1

-- Start of DDL Script for Index IFRMAXIMO.INVTRANS_NDX2
-- Generated 3/10/2006 17:21:36 from IFRMAXIMO@prodsede2

CREATE INDEX ifrmaximo.invtrans_ndx2 ON ifrmaximo.invtrans
  (
    siteid                          ASC,
    itemnum                         ASC,
    storeloc                        ASC,
    transdate                       ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
  TABLESPACE  tsi_maximo
  STORAGE   (
    INITIAL     65536
    MINEXTENTS  1
    MAXEXTENTS  2147483645
  )
/


-- End of DDL Script for Index IFRMAXIMO.INVTRANS_NDX2

-- Start of DDL Script for Index IFRMAXIMO.INVTRANS_NDX3
-- Generated 3/10/2006 17:21:36 from IFRMAXIMO@prodsede2

CREATE INDEX ifrmaximo.invtrans_ndx3 ON ifrmaximo.invtrans
  (
    siteid                          ASC,
    interid                         ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
  TABLESPACE  tsi_maximo
  STORAGE   (
    INITIAL     65536
    MINEXTENTS  1
    MAXEXTENTS  2147483645
  )
/


-- End of DDL Script for Index IFRMAXIMO.INVTRANS_NDX3

-- Start of DDL Script for Index IFRMAXIMO.INVVEND_NDX1
-- Generated 3/10/2006 17:21:36 from IFRMAXIMO@prodsede2

CREATE UNIQUE INDEX ifrmaximo.invvend_ndx1 ON ifrmaximo.invvendor
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
  TABLESPACE  tsi_maximo
  STORAGE   (
    INITIAL     65536
    MINEXTENTS  1
    MAXEXTENTS  2147483645
  )
/


-- End of DDL Script for Index IFRMAXIMO.INVVEND_NDX1

-- Start of DDL Script for Index IFRMAXIMO.INVVEND_NDX2
-- Generated 3/10/2006 17:21:36 from IFRMAXIMO@prodsede2

CREATE INDEX ifrmaximo.invvend_ndx2 ON ifrmaximo.invvendor
  (
    siteid                          ASC,
    interid                         ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
  TABLESPACE  tsi_maximo
  STORAGE   (
    INITIAL     65536
    MINEXTENTS  1
    MAXEXTENTS  2147483645
  )
/


-- End of DDL Script for Index IFRMAXIMO.INVVEND_NDX2

-- Start of DDL Script for Index IFRMAXIMO.INVVEND_NDX3
-- Generated 3/10/2006 17:21:36 from IFRMAXIMO@prodsede2

CREATE INDEX ifrmaximo.invvend_ndx3 ON ifrmaximo.invvendor
  (
    siteid                          ASC,
    vendor                          ASC,
    catalogcode                     ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
  TABLESPACE  tsi_maximo
  STORAGE   (
    INITIAL     65536
    MINEXTENTS  1
    MAXEXTENTS  2147483645
  )
/


-- End of DDL Script for Index IFRMAXIMO.INVVEND_NDX3

-- Start of DDL Script for Index IFRMAXIMO.ITEM_NDX1
-- Generated 3/10/2006 17:21:36 from IFRMAXIMO@prodsede2

CREATE UNIQUE INDEX ifrmaximo.item_ndx1 ON ifrmaximo.item
  (
    orgid                           ASC,
    itemnum                         ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
  TABLESPACE  tsi_maximo
  STORAGE   (
    INITIAL     65536
    MINEXTENTS  1
    MAXEXTENTS  2147483645
  )
/


-- End of DDL Script for Index IFRMAXIMO.ITEM_NDX1

-- Start of DDL Script for Index IFRMAXIMO.ITEM_NDX2
-- Generated 3/10/2006 17:21:36 from IFRMAXIMO@prodsede2

CREATE INDEX ifrmaximo.item_ndx2 ON ifrmaximo.item
  (
    orgid                           ASC,
    interid                         ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
  TABLESPACE  tsi_maximo
  STORAGE   (
    INITIAL     65536
    MINEXTENTS  1
    MAXEXTENTS  2147483645
  )
/


-- End of DDL Script for Index IFRMAXIMO.ITEM_NDX2

-- Start of DDL Script for Index IFRMAXIMO.ITEMSPEC_NDX1
-- Generated 3/10/2006 17:21:37 from IFRMAXIMO@prodsede2

CREATE UNIQUE INDEX ifrmaximo.itemspec_ndx1 ON ifrmaximo.itemspec
  (
    orgid                           ASC,
    itemnum                         ASC,
    assetattrid                     ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
  TABLESPACE  tsi_maximo
  STORAGE   (
    INITIAL     65536
    MINEXTENTS  1
    MAXEXTENTS  2147483645
  )
/


-- End of DDL Script for Index IFRMAXIMO.ITEMSPEC_NDX1

-- Start of DDL Script for Index IFRMAXIMO.ITEMSPEC_NDX2
-- Generated 3/10/2006 17:21:37 from IFRMAXIMO@prodsede2

CREATE INDEX ifrmaximo.itemspec_ndx2 ON ifrmaximo.itemspec
  (
    orgid                           ASC,
    classstructureid                ASC,
    assetattrid                     ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
  TABLESPACE  tsi_maximo
  STORAGE   (
    INITIAL     65536
    MINEXTENTS  1
    MAXEXTENTS  2147483645
  )
/


-- End of DDL Script for Index IFRMAXIMO.ITEMSPEC_NDX2

-- Start of DDL Script for Index IFRMAXIMO.ITEMSPEC_NDX3
-- Generated 3/10/2006 17:21:37 from IFRMAXIMO@prodsede2

CREATE INDEX ifrmaximo.itemspec_ndx3 ON ifrmaximo.itemspec
  (
    orgid                           ASC,
    assetattrid                     ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
  TABLESPACE  tsi_maximo
  STORAGE   (
    INITIAL     65536
    MINEXTENTS  1
    MAXEXTENTS  2147483645
  )
/


-- End of DDL Script for Index IFRMAXIMO.ITEMSPEC_NDX3

-- Start of DDL Script for Index IFRMAXIMO.ITEMSTRUCT_NDX1
-- Generated 3/10/2006 17:21:37 from IFRMAXIMO@prodsede2

CREATE UNIQUE INDEX ifrmaximo.itemstruct_ndx1 ON ifrmaximo.itemstruct
  (
    orgid                           ASC,
    itemid                          ASC,
    itemnum                         ASC,
    instance                        ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
  TABLESPACE  tsi_maximo
  STORAGE   (
    INITIAL     65536
    MINEXTENTS  1
    MAXEXTENTS  2147483645
  )
/


-- End of DDL Script for Index IFRMAXIMO.ITEMSTRUCT_NDX1

-- Start of DDL Script for Index IFRMAXIMO.JOBLABOR_NDX1
-- Generated 3/10/2006 17:21:37 from IFRMAXIMO@prodsede2

CREATE INDEX ifrmaximo.joblabor_ndx1 ON ifrmaximo.joblabor
  (
    siteid                          ASC,
    jpnum                           ASC,
    jptask                          ASC,
    laborcode                       ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
  TABLESPACE  tsi_maximo
  STORAGE   (
    INITIAL     65536
    MINEXTENTS  1
    MAXEXTENTS  2147483645
  )
/


-- End of DDL Script for Index IFRMAXIMO.JOBLABOR_NDX1

-- Start of DDL Script for Index IFRMAXIMO.JOBMATERIAL_NDX1
-- Generated 3/10/2006 17:21:37 from IFRMAXIMO@prodsede2

CREATE INDEX ifrmaximo.jobmaterial_ndx1 ON ifrmaximo.jobmaterial
  (
    siteid                          ASC,
    jpnum                           ASC,
    jptask                          ASC,
    itemnum                         ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
  TABLESPACE  tsi_maximo
  STORAGE   (
    INITIAL     65536
    MINEXTENTS  1
    MAXEXTENTS  2147483645
  )
/


-- End of DDL Script for Index IFRMAXIMO.JOBMATERIAL_NDX1

-- Start of DDL Script for Index IFRMAXIMO.JOBPLAN_NDX1
-- Generated 3/10/2006 17:21:38 from IFRMAXIMO@prodsede2

CREATE UNIQUE INDEX ifrmaximo.jobplan_ndx1 ON ifrmaximo.jobplan
  (
    siteid                          ASC,
    jpnum                           ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
  TABLESPACE  tsi_maximo
  STORAGE   (
    INITIAL     65536
    MINEXTENTS  1
    MAXEXTENTS  2147483645
  )
/


-- End of DDL Script for Index IFRMAXIMO.JOBPLAN_NDX1

-- Start of DDL Script for Index IFRMAXIMO.JOBTASK_NDX1
-- Generated 3/10/2006 17:21:38 from IFRMAXIMO@prodsede2

CREATE UNIQUE INDEX ifrmaximo.jobtask_ndx1 ON ifrmaximo.jobtask
  (
    siteid                          ASC,
    jpnum                           ASC,
    jptask                          ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
  TABLESPACE  tsi_maximo
  STORAGE   (
    INITIAL     65536
    MINEXTENTS  1
    MAXEXTENTS  2147483645
  )
/


-- End of DDL Script for Index IFRMAXIMO.JOBTASK_NDX1

-- Start of DDL Script for Index IFRMAXIMO.JOBTOOL_NDX1
-- Generated 3/10/2006 17:21:38 from IFRMAXIMO@prodsede2

CREATE INDEX ifrmaximo.jobtool_ndx1 ON ifrmaximo.jobtool
  (
    siteid                          ASC,
    jpnum                           ASC,
    jptask                          ASC,
    toolnum                         ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
  TABLESPACE  tsi_maximo
  STORAGE   (
    INITIAL     65536
    MINEXTENTS  1
    MAXEXTENTS  2147483645
  )
/


-- End of DDL Script for Index IFRMAXIMO.JOBTOOL_NDX1

-- Start of DDL Script for Index IFRMAXIMO.JPASSETSPLINK_NDX1
-- Generated 3/10/2006 17:21:38 from IFRMAXIMO@prodsede2

CREATE UNIQUE INDEX ifrmaximo.jpassetsplink_ndx1 ON ifrmaximo.jpassetsplink
  (
    siteid                          ASC,
    jpassetsplinkid                 ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
  TABLESPACE  tsi_maximo
  STORAGE   (
    INITIAL     65536
    MINEXTENTS  1
    MAXEXTENTS  2147483645
  )
/


-- End of DDL Script for Index IFRMAXIMO.JPASSETSPLINK_NDX1

-- Start of DDL Script for Index IFRMAXIMO.KPI_NDX1
-- Generated 3/10/2006 17:21:38 from IFRMAXIMO@prodsede2

CREATE UNIQUE INDEX ifrmaximo.kpi_ndx1 ON ifrmaximo.kpi
  (
    siteid                          ASC,
    kpiname                         ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
  TABLESPACE  tsi_maximo
  STORAGE   (
    INITIAL     65536
    MINEXTENTS  1
    MAXEXTENTS  2147483645
  )
/


-- End of DDL Script for Index IFRMAXIMO.KPI_NDX1

-- Start of DDL Script for Index IFRMAXIMO.LABAVAIL_NDX1
-- Generated 3/10/2006 17:21:38 from IFRMAXIMO@prodsede2

CREATE UNIQUE INDEX ifrmaximo.labavail_ndx1 ON ifrmaximo.labavail
  (
    orgid                           ASC,
    workdate                        ASC,
    shiftnum                        ASC,
    laborcode                       ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
  TABLESPACE  tsi_maximo
  STORAGE   (
    INITIAL     65536
    MINEXTENTS  1
    MAXEXTENTS  2147483645
  )
/


-- End of DDL Script for Index IFRMAXIMO.LABAVAIL_NDX1

-- Start of DDL Script for Index IFRMAXIMO.LABOR_NDX1
-- Generated 3/10/2006 17:21:39 from IFRMAXIMO@prodsede2

CREATE UNIQUE INDEX ifrmaximo.labor_ndx1 ON ifrmaximo.labor
  (
    orgid                           ASC,
    laborcode                       ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
  TABLESPACE  tsi_maximo
  STORAGE   (
    INITIAL     65536
    MINEXTENTS  1
    MAXEXTENTS  2147483645
  )
/


-- End of DDL Script for Index IFRMAXIMO.LABOR_NDX1

-- Start of DDL Script for Index IFRMAXIMO.LABOR_NDX2
-- Generated 3/10/2006 17:21:39 from IFRMAXIMO@prodsede2

CREATE INDEX ifrmaximo.labor_ndx2 ON ifrmaximo.labor
  (
    orgid                           ASC,
    craft                           ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
  TABLESPACE  tsi_maximo
  STORAGE   (
    INITIAL     65536
    MINEXTENTS  1
    MAXEXTENTS  2147483645
  )
/


-- End of DDL Script for Index IFRMAXIMO.LABOR_NDX2

-- Start of DDL Script for Index IFRMAXIMO.LABOR_NDX3
-- Generated 3/10/2006 17:21:39 from IFRMAXIMO@prodsede2

CREATE INDEX ifrmaximo.labor_ndx3 ON ifrmaximo.labor
  (
    orgid                           ASC,
    calnum                          ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
  TABLESPACE  tsi_maximo
  STORAGE   (
    INITIAL     65536
    MINEXTENTS  1
    MAXEXTENTS  2147483645
  )
/


-- End of DDL Script for Index IFRMAXIMO.LABOR_NDX3

-- Start of DDL Script for Index IFRMAXIMO.LABOR_NDX4
-- Generated 3/10/2006 17:21:39 from IFRMAXIMO@prodsede2

CREATE INDEX ifrmaximo.labor_ndx4 ON ifrmaximo.labor
  (
    orgid                           ASC,
    interid                         ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
  TABLESPACE  tsi_maximo
  STORAGE   (
    INITIAL     65536
    MINEXTENTS  1
    MAXEXTENTS  2147483645
  )
/


-- End of DDL Script for Index IFRMAXIMO.LABOR_NDX4

-- Start of DDL Script for Index IFRMAXIMO.LABORAUTH_NDX1
-- Generated 3/10/2006 17:21:39 from IFRMAXIMO@prodsede2

CREATE UNIQUE INDEX ifrmaximo.laborauth_ndx1 ON ifrmaximo.laborauth
  (
    siteid                          ASC,
    name                            ASC,
    laborcode                       ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
  TABLESPACE  tsi_maximo
  STORAGE   (
    INITIAL     65536
    MINEXTENTS  1
    MAXEXTENTS  2147483645
  )
/


-- End of DDL Script for Index IFRMAXIMO.LABORAUTH_NDX1

-- Start of DDL Script for Index IFRMAXIMO.LABTRANS_NDX1
-- Generated 3/10/2006 17:21:39 from IFRMAXIMO@prodsede2

CREATE UNIQUE INDEX ifrmaximo.labtrans_ndx1 ON ifrmaximo.labtrans
  (
    siteid                          ASC,
    labtransid                      ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
  TABLESPACE  tsi_maximo
  STORAGE   (
    INITIAL     65536
    MINEXTENTS  1
    MAXEXTENTS  2147483645
  )
/


-- End of DDL Script for Index IFRMAXIMO.LABTRANS_NDX1

-- Start of DDL Script for Index IFRMAXIMO.LABTRANS_NDX2
-- Generated 3/10/2006 17:21:40 from IFRMAXIMO@prodsede2

CREATE INDEX ifrmaximo.labtrans_ndx2 ON ifrmaximo.labtrans
  (
    siteid                          ASC,
    laborcode                       ASC,
    transdate                       ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
  TABLESPACE  tsi_maximo
  STORAGE   (
    INITIAL     65536
    MINEXTENTS  1
    MAXEXTENTS  2147483645
  )
/


-- End of DDL Script for Index IFRMAXIMO.LABTRANS_NDX2

-- Start of DDL Script for Index IFRMAXIMO.LABTRANS_NDX3
-- Generated 3/10/2006 17:21:40 from IFRMAXIMO@prodsede2

CREATE INDEX ifrmaximo.labtrans_ndx3 ON ifrmaximo.labtrans
  (
    siteid                          ASC,
    eqnum                           ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
  TABLESPACE  tsi_maximo
  STORAGE   (
    INITIAL     65536
    MINEXTENTS  1
    MAXEXTENTS  2147483645
  )
/


-- End of DDL Script for Index IFRMAXIMO.LABTRANS_NDX3

-- Start of DDL Script for Index IFRMAXIMO.LABTRANS_NDX4
-- Generated 3/10/2006 17:21:40 from IFRMAXIMO@prodsede2

CREATE INDEX ifrmaximo.labtrans_ndx4 ON ifrmaximo.labtrans
  (
    siteid                          ASC,
    refwo                           ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
  TABLESPACE  tsi_maximo
  STORAGE   (
    INITIAL     65536
    MINEXTENTS  1
    MAXEXTENTS  2147483645
  )
/


-- End of DDL Script for Index IFRMAXIMO.LABTRANS_NDX4

-- Start of DDL Script for Index IFRMAXIMO.LABTRANS_NDX5
-- Generated 3/10/2006 17:21:40 from IFRMAXIMO@prodsede2

CREATE INDEX ifrmaximo.labtrans_ndx5 ON ifrmaximo.labtrans
  (
    siteid                          ASC,
    interid                         ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
  TABLESPACE  tsi_maximo
  STORAGE   (
    INITIAL     65536
    MINEXTENTS  1
    MAXEXTENTS  2147483645
  )
/


-- End of DDL Script for Index IFRMAXIMO.LABTRANS_NDX5

-- Start of DDL Script for Index IFRMAXIMO.LANG_NDX1
-- Generated 3/10/2006 17:21:40 from IFRMAXIMO@prodsede2

CREATE UNIQUE INDEX ifrmaximo.lang_ndx1 ON ifrmaximo.language
  (
    langcode                        ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
  TABLESPACE  tsi_maximo
  STORAGE   (
    INITIAL     65536
    MINEXTENTS  1
    MAXEXTENTS  2147483645
  )
/


-- End of DDL Script for Index IFRMAXIMO.LANG_NDX1

-- Start of DDL Script for Index IFRMAXIMO.LISTTRANS_NDX1
-- Generated 3/10/2006 17:21:40 from IFRMAXIMO@prodsede2

CREATE UNIQUE INDEX ifrmaximo.listtrans_ndx1 ON ifrmaximo.listtranslation
  (
    listname                        ASC,
    langcode                        ASC,
    translatedvalue                 ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
  TABLESPACE  tsi_maximo
  STORAGE   (
    INITIAL     65536
    MINEXTENTS  1
    MAXEXTENTS  2147483645
  )
/


-- End of DDL Script for Index IFRMAXIMO.LISTTRANS_NDX1

-- Start of DDL Script for Index IFRMAXIMO.LOCANCESTOR_NDX1
-- Generated 3/10/2006 17:21:41 from IFRMAXIMO@prodsede2

CREATE UNIQUE INDEX ifrmaximo.locancestor_ndx1 ON ifrmaximo.locancestor
  (
    siteid                          ASC,
    location                        ASC,
    systemid                        ASC,
    ancestor                        ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
  TABLESPACE  tsi_maximo
  STORAGE   (
    INITIAL     65536
    MINEXTENTS  1
    MAXEXTENTS  2147483645
  )
/


-- End of DDL Script for Index IFRMAXIMO.LOCANCESTOR_NDX1

-- Start of DDL Script for Index IFRMAXIMO.LOCANCESTOR_NDX2
-- Generated 3/10/2006 17:21:41 from IFRMAXIMO@prodsede2

CREATE INDEX ifrmaximo.locancestor_ndx2 ON ifrmaximo.locancestor
  (
    siteid                          ASC,
    ancestor                        ASC,
    systemid                        ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
  TABLESPACE  tsi_maximo
  STORAGE   (
    INITIAL     65536
    MINEXTENTS  1
    MAXEXTENTS  2147483645
  )
/


-- End of DDL Script for Index IFRMAXIMO.LOCANCESTOR_NDX2

-- Start of DDL Script for Index IFRMAXIMO.LOCATIONS_NDX1
-- Generated 3/10/2006 17:21:41 from IFRMAXIMO@prodsede2

CREATE UNIQUE INDEX ifrmaximo.locations_ndx1 ON ifrmaximo.locations
  (
    siteid                          ASC,
    location                        ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
  TABLESPACE  tsi_maximo
  STORAGE   (
    INITIAL     65536
    MINEXTENTS  1
    MAXEXTENTS  2147483645
  )
/


-- End of DDL Script for Index IFRMAXIMO.LOCATIONS_NDX1

-- Start of DDL Script for Index IFRMAXIMO.LOCATIONS_NDX2
-- Generated 3/10/2006 17:21:41 from IFRMAXIMO@prodsede2

CREATE INDEX ifrmaximo.locations_ndx2 ON ifrmaximo.locations
  (
    siteid                          ASC,
    type                            ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
  TABLESPACE  tsi_maximo
  STORAGE   (
    INITIAL     65536
    MINEXTENTS  1
    MAXEXTENTS  2147483645
  )
/


-- End of DDL Script for Index IFRMAXIMO.LOCATIONS_NDX2

-- Start of DDL Script for Index IFRMAXIMO.LOCATIONS_NDX3
-- Generated 3/10/2006 17:21:41 from IFRMAXIMO@prodsede2

CREATE INDEX ifrmaximo.locations_ndx3 ON ifrmaximo.locations
  (
    siteid                          ASC,
    interid                         ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
  TABLESPACE  tsi_maximo
  STORAGE   (
    INITIAL     65536
    MINEXTENTS  1
    MAXEXTENTS  2147483645
  )
/


-- End of DDL Script for Index IFRMAXIMO.LOCATIONS_NDX3

-- Start of DDL Script for Index IFRMAXIMO.LOCATIONSPEC_NDX1
-- Generated 3/10/2006 17:21:41 from IFRMAXIMO@prodsede2

CREATE UNIQUE INDEX ifrmaximo.locationspec_ndx1 ON ifrmaximo.locationspec
  (
    siteid                          ASC,
    location                        ASC,
    assetattrid                     ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
  TABLESPACE  tsi_maximo
  STORAGE   (
    INITIAL     65536
    MINEXTENTS  1
    MAXEXTENTS  2147483645
  )
/


-- End of DDL Script for Index IFRMAXIMO.LOCATIONSPEC_NDX1

-- Start of DDL Script for Index IFRMAXIMO.LOCATIONSPEC_NDX2
-- Generated 3/10/2006 17:21:42 from IFRMAXIMO@prodsede2

CREATE INDEX ifrmaximo.locationspec_ndx2 ON ifrmaximo.locationspec
  (
    siteid                          ASC,
    classstructureid                ASC,
    assetattrid                     ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
  TABLESPACE  tsi_maximo
  STORAGE   (
    INITIAL     65536
    MINEXTENTS  1
    MAXEXTENTS  2147483645
  )
/


-- End of DDL Script for Index IFRMAXIMO.LOCATIONSPEC_NDX2

-- Start of DDL Script for Index IFRMAXIMO.LOCATIONSPEC_NDX3
-- Generated 3/10/2006 17:21:42 from IFRMAXIMO@prodsede2

CREATE INDEX ifrmaximo.locationspec_ndx3 ON ifrmaximo.locationspec
  (
    siteid                          ASC,
    assetattrid                     ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
  TABLESPACE  tsi_maximo
  STORAGE   (
    INITIAL     65536
    MINEXTENTS  1
    MAXEXTENTS  2147483645
  )
/


-- End of DDL Script for Index IFRMAXIMO.LOCATIONSPEC_NDX3

-- Start of DDL Script for Index IFRMAXIMO.LOCAUTH_NDX1
-- Generated 3/10/2006 17:21:42 from IFRMAXIMO@prodsede2

CREATE UNIQUE INDEX ifrmaximo.locauth_ndx1 ON ifrmaximo.locauth
  (
    siteid                          ASC,
    username                        ASC,
    location                        ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
  TABLESPACE  tsi_maximo
  STORAGE   (
    INITIAL     65536
    MINEXTENTS  1
    MAXEXTENTS  2147483645
  )
/


-- End of DDL Script for Index IFRMAXIMO.LOCAUTH_NDX1

-- Start of DDL Script for Index IFRMAXIMO.LOCHIERARCHY_NDX1
-- Generated 3/10/2006 17:21:42 from IFRMAXIMO@prodsede2

CREATE UNIQUE INDEX ifrmaximo.lochierarchy_ndx1 ON ifrmaximo.lochierarchy
  (
    siteid                          ASC,
    location                        ASC,
    systemid                        ASC,
    parent                          ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
  TABLESPACE  tsi_maximo
  STORAGE   (
    INITIAL     65536
    MINEXTENTS  1
    MAXEXTENTS  2147483645
  )
/


-- End of DDL Script for Index IFRMAXIMO.LOCHIERARCHY_NDX1

-- Start of DDL Script for Index IFRMAXIMO.LOCHIERARCHY_NDX2
-- Generated 3/10/2006 17:21:42 from IFRMAXIMO@prodsede2

CREATE INDEX ifrmaximo.lochierarchy_ndx2 ON ifrmaximo.lochierarchy
  (
    siteid                          ASC,
    parent                          ASC,
    systemid                        ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
  TABLESPACE  tsi_maximo
  STORAGE   (
    INITIAL     65536
    MINEXTENTS  1
    MAXEXTENTS  2147483645
  )
/


-- End of DDL Script for Index IFRMAXIMO.LOCHIERARCHY_NDX2

-- Start of DDL Script for Index IFRMAXIMO.LOCKOUT_NDX1
-- Generated 3/10/2006 17:21:42 from IFRMAXIMO@prodsede2

CREATE UNIQUE INDEX ifrmaximo.lockout_ndx1 ON ifrmaximo.lockout
  (
    siteid                          ASC,
    lockoutid                       ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
  TABLESPACE  tsi_maximo
  STORAGE   (
    INITIAL     65536
    MINEXTENTS  1
    MAXEXTENTS  2147483645
  )
/


-- End of DDL Script for Index IFRMAXIMO.LOCKOUT_NDX1

-- Start of DDL Script for Index IFRMAXIMO.LOCLEADTIME_NDX1
-- Generated 3/10/2006 17:21:42 from IFRMAXIMO@prodsede2

CREATE UNIQUE INDEX ifrmaximo.locleadtime_ndx1 ON ifrmaximo.locleadtime
  (
    siteid                          ASC,
    location                        ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
  TABLESPACE  tsi_maximo
  STORAGE   (
    INITIAL     65536
    MINEXTENTS  1
    MAXEXTENTS  2147483645
  )
/


-- End of DDL Script for Index IFRMAXIMO.LOCLEADTIME_NDX1

-- Start of DDL Script for Index IFRMAXIMO.LOCOPER_NDX1
-- Generated 3/10/2006 17:21:43 from IFRMAXIMO@prodsede2

CREATE UNIQUE INDEX ifrmaximo.locoper_ndx1 ON ifrmaximo.locoper
  (
    siteid                          ASC,
    location                        ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
  TABLESPACE  tsi_maximo
  STORAGE   (
    INITIAL     65536
    MINEXTENTS  1
    MAXEXTENTS  2147483645
  )
/


-- End of DDL Script for Index IFRMAXIMO.LOCOPER_NDX1

-- Start of DDL Script for Index IFRMAXIMO.LOCSTATUS_NDX1
-- Generated 3/10/2006 17:21:43 from IFRMAXIMO@prodsede2

CREATE INDEX ifrmaximo.locstatus_ndx1 ON ifrmaximo.locstatus
  (
    siteid                          ASC,
    location                        ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
  TABLESPACE  tsi_maximo
  STORAGE   (
    INITIAL     65536
    MINEXTENTS  1
    MAXEXTENTS  2147483645
  )
/


-- End of DDL Script for Index IFRMAXIMO.LOCSTATUS_NDX1

-- Start of DDL Script for Index IFRMAXIMO.LOCSTATUS_NDX2
-- Generated 3/10/2006 17:21:43 from IFRMAXIMO@prodsede2

CREATE INDEX ifrmaximo.locstatus_ndx2 ON ifrmaximo.locstatus
  (
    siteid                          ASC,
    changedate                      ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
  TABLESPACE  tsi_maximo
  STORAGE   (
    INITIAL     65536
    MINEXTENTS  1
    MAXEXTENTS  2147483645
  )
/


-- End of DDL Script for Index IFRMAXIMO.LOCSTATUS_NDX2

-- Start of DDL Script for Index IFRMAXIMO.LOCSYSTEM_NDX1
-- Generated 3/10/2006 17:21:43 from IFRMAXIMO@prodsede2

CREATE UNIQUE INDEX ifrmaximo.locsystem_ndx1 ON ifrmaximo.locsystem
  (
    siteid                          ASC,
    systemid                        ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
  TABLESPACE  tsi_maximo
  STORAGE   (
    INITIAL     65536
    MINEXTENTS  1
    MAXEXTENTS  2147483645
  )
/


-- End of DDL Script for Index IFRMAXIMO.LOCSYSTEM_NDX1

-- Start of DDL Script for Index IFRMAXIMO.LOGINTRACKING_NDX1
-- Generated 3/10/2006 17:21:43 from IFRMAXIMO@prodsede2

CREATE INDEX ifrmaximo.logintracking_ndx1 ON ifrmaximo.logintracking
  (
    username                        ASC,
    attemptdate                     ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
  TABLESPACE  tsi_maximo
  STORAGE   (
    INITIAL     65536
    MINEXTENTS  1
    MAXEXTENTS  2147483645
  )
/


-- End of DDL Script for Index IFRMAXIMO.LOGINTRACKING_NDX1

-- Start of DDL Script for Index IFRMAXIMO.LOGINTRACKING_NDX2
-- Generated 3/10/2006 17:21:43 from IFRMAXIMO@prodsede2

CREATE INDEX ifrmaximo.logintracking_ndx2 ON ifrmaximo.logintracking
  (
    attemptdate                     ASC,
    username                        ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
  TABLESPACE  tsi_maximo
  STORAGE   (
    INITIAL     65536
    MINEXTENTS  1
    MAXEXTENTS  2147483645
  )
/


-- End of DDL Script for Index IFRMAXIMO.LOGINTRACKING_NDX2

-- Start of DDL Script for Index IFRMAXIMO.LONGDSCRPTN_NDX1
-- Generated 3/10/2006 17:21:44 from IFRMAXIMO@prodsede2

CREATE UNIQUE INDEX ifrmaximo.longdscrptn_ndx1 ON ifrmaximo.longdescription
  (
    ldownertable                    ASC,
    ldownercol                      ASC,
    ldkey                           ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
  TABLESPACE  tsi_maximo
  STORAGE   (
    INITIAL     4669440
    MINEXTENTS  1
    MAXEXTENTS  2147483645
  )
/


-- End of DDL Script for Index IFRMAXIMO.LONGDSCRPTN_NDX1

-- Start of DDL Script for Index IFRMAXIMO.LONGDSCRPTN_NDX2
-- Generated 3/10/2006 17:21:44 from IFRMAXIMO@prodsede2

CREATE INDEX ifrmaximo.longdscrptn_ndx2 ON ifrmaximo.longdescription
  (
    ldkey                           ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
  TABLESPACE  tsi_maximo
  STORAGE   (
    INITIAL     2129920
    MINEXTENTS  1
    MAXEXTENTS  2147483645
  )
/


-- End of DDL Script for Index IFRMAXIMO.LONGDSCRPTN_NDX2

-- Start of DDL Script for Index IFRMAXIMO.MATRECTRANS_NDX1
-- Generated 3/10/2006 17:21:44 from IFRMAXIMO@prodsede2

CREATE UNIQUE INDEX ifrmaximo.matrectrans_ndx1 ON ifrmaximo.matrectrans
  (
    siteid                          ASC,
    matrectransid                   ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
  TABLESPACE  tsi_maximo
  STORAGE   (
    INITIAL     65536
    MINEXTENTS  1
    MAXEXTENTS  2147483645
  )
/


-- End of DDL Script for Index IFRMAXIMO.MATRECTRANS_NDX1

-- Start of DDL Script for Index IFRMAXIMO.MATRECTRANS_NDX2
-- Generated 3/10/2006 17:21:44 from IFRMAXIMO@prodsede2

CREATE INDEX ifrmaximo.matrectrans_ndx2 ON ifrmaximo.matrectrans
  (
    siteid                          ASC,
    itemnum                         ASC,
    tostoreloc                      ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
  TABLESPACE  tsi_maximo
  STORAGE   (
    INITIAL     65536
    MINEXTENTS  1
    MAXEXTENTS  2147483645
  )
/


-- End of DDL Script for Index IFRMAXIMO.MATRECTRANS_NDX2

-- Start of DDL Script for Index IFRMAXIMO.MATRECTRANS_NDX3
-- Generated 3/10/2006 17:21:44 from IFRMAXIMO@prodsede2

CREATE INDEX ifrmaximo.matrectrans_ndx3 ON ifrmaximo.matrectrans
  (
    siteid                          ASC,
    ponum                           ASC,
    polinenum                       ASC,
    transdate                       ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
  TABLESPACE  tsi_maximo
  STORAGE   (
    INITIAL     65536
    MINEXTENTS  1
    MAXEXTENTS  2147483645
  )
/


-- End of DDL Script for Index IFRMAXIMO.MATRECTRANS_NDX3

-- Start of DDL Script for Index IFRMAXIMO.MATRECTRANS_NDX4
-- Generated 3/10/2006 17:21:44 from IFRMAXIMO@prodsede2

CREATE INDEX ifrmaximo.matrectrans_ndx4 ON ifrmaximo.matrectrans
  (
    siteid                          ASC,
    interid                         ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
  TABLESPACE  tsi_maximo
  STORAGE   (
    INITIAL     65536
    MINEXTENTS  1
    MAXEXTENTS  2147483645
  )
/


-- End of DDL Script for Index IFRMAXIMO.MATRECTRANS_NDX4

-- Start of DDL Script for Index IFRMAXIMO.MATUSETRANS_NDX1
-- Generated 3/10/2006 17:21:45 from IFRMAXIMO@prodsede2

CREATE UNIQUE INDEX ifrmaximo.matusetrans_ndx1 ON ifrmaximo.matusetrans
  (
    matusetransid                   ASC,
    siteid                          ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
  TABLESPACE  tsi_maximo
  STORAGE   (
    INITIAL     65536
    MINEXTENTS  1
    MAXEXTENTS  2147483645
  )
/


-- End of DDL Script for Index IFRMAXIMO.MATUSETRANS_NDX1

-- Start of DDL Script for Index IFRMAXIMO.MATUSETRANS_NDX2
-- Generated 3/10/2006 17:21:45 from IFRMAXIMO@prodsede2

CREATE INDEX ifrmaximo.matusetrans_ndx2 ON ifrmaximo.matusetrans
  (
    siteid                          ASC,
    refwo                           ASC,
    transdate                       ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
  TABLESPACE  tsi_maximo
  STORAGE   (
    INITIAL     65536
    MINEXTENTS  1
    MAXEXTENTS  2147483645
  )
/


-- End of DDL Script for Index IFRMAXIMO.MATUSETRANS_NDX2

-- Start of DDL Script for Index IFRMAXIMO.MATUSETRANS_NDX3
-- Generated 3/10/2006 17:21:45 from IFRMAXIMO@prodsede2

CREATE INDEX ifrmaximo.matusetrans_ndx3 ON ifrmaximo.matusetrans
  (
    siteid                          ASC,
    itemnum                         ASC,
    storeloc                        ASC,
    transdate                       ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
  TABLESPACE  tsi_maximo
  STORAGE   (
    INITIAL     65536
    MINEXTENTS  1
    MAXEXTENTS  2147483645
  )
/


-- End of DDL Script for Index IFRMAXIMO.MATUSETRANS_NDX3

-- Start of DDL Script for Index IFRMAXIMO.MATUSETRANS_NDX4
-- Generated 3/10/2006 17:21:45 from IFRMAXIMO@prodsede2

CREATE INDEX ifrmaximo.matusetrans_ndx4 ON ifrmaximo.matusetrans
  (
    siteid                          ASC,
    eqnum                           ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
  TABLESPACE  tsi_maximo
  STORAGE   (
    INITIAL     65536
    MINEXTENTS  1
    MAXEXTENTS  2147483645
  )
/


-- End of DDL Script for Index IFRMAXIMO.MATUSETRANS_NDX4

-- Start of DDL Script for Index IFRMAXIMO.MATUSETRANS_NDX5
-- Generated 3/10/2006 17:21:45 from IFRMAXIMO@prodsede2

CREATE INDEX ifrmaximo.matusetrans_ndx5 ON ifrmaximo.matusetrans
  (
    siteid                          ASC,
    interid                         ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
  TABLESPACE  tsi_maximo
  STORAGE   (
    INITIAL     65536
    MINEXTENTS  1
    MAXEXTENTS  2147483645
  )
/


-- End of DDL Script for Index IFRMAXIMO.MATUSETRANS_NDX5

-- Start of DDL Script for Index IFRMAXIMO.MAXAPPS_NDX
-- Generated 3/10/2006 17:21:45 from IFRMAXIMO@prodsede2

CREATE UNIQUE INDEX ifrmaximo.maxapps_ndx ON ifrmaximo.maxapps
  (
    module                          ASC,
    app                             ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
  TABLESPACE  tsi_maximo
  STORAGE   (
    INITIAL     65536
    MINEXTENTS  1
    MAXEXTENTS  2147483645
  )
/


-- End of DDL Script for Index IFRMAXIMO.MAXAPPS_NDX

-- Start of DDL Script for Index IFRMAXIMO.MAXAPPS_NDX1
-- Generated 3/10/2006 17:21:46 from IFRMAXIMO@prodsede2

CREATE INDEX ifrmaximo.maxapps_ndx1 ON ifrmaximo.maxapps
  (
    app                             ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
  TABLESPACE  tsi_maximo
  STORAGE   (
    INITIAL     65536
    MINEXTENTS  1
    MAXEXTENTS  2147483645
  )
/


-- End of DDL Script for Index IFRMAXIMO.MAXAPPS_NDX1

-- Start of DDL Script for Index IFRMAXIMO.MAXDOMAIN_NDX1
-- Generated 3/10/2006 17:21:46 from IFRMAXIMO@prodsede2

CREATE UNIQUE INDEX ifrmaximo.maxdomain_ndx1 ON ifrmaximo.maxdomain
  (
    domainid                        ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
  TABLESPACE  tsi_maximo
  STORAGE   (
    INITIAL     65536
    MINEXTENTS  1
    MAXEXTENTS  2147483645
  )
/


-- End of DDL Script for Index IFRMAXIMO.MAXDOMAIN_NDX1

-- Start of DDL Script for Index IFRMAXIMO.MAXDOMAIN_NDX2
-- Generated 3/10/2006 17:21:46 from IFRMAXIMO@prodsede2

CREATE INDEX ifrmaximo.maxdomain_ndx2 ON ifrmaximo.maxdomain
  (
    domaintype                      ASC,
    domainid                        ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
  TABLESPACE  tsi_maximo
  STORAGE   (
    INITIAL     65536
    MINEXTENTS  1
    MAXEXTENTS  2147483645
  )
/


-- End of DDL Script for Index IFRMAXIMO.MAXDOMAIN_NDX2

-- Start of DDL Script for Index IFRMAXIMO.MAXGROUPS_NDX
-- Generated 3/10/2006 17:21:46 from IFRMAXIMO@prodsede2

CREATE UNIQUE INDEX ifrmaximo.maxgroups_ndx ON ifrmaximo.maxgroups
  (
    grpname                         ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
  TABLESPACE  tsi_maximo
  STORAGE   (
    INITIAL     65536
    MINEXTENTS  1
    MAXEXTENTS  2147483645
  )
/


-- End of DDL Script for Index IFRMAXIMO.MAXGROUPS_NDX

-- Start of DDL Script for Index IFRMAXIMO.MAXHLP_NDX
-- Generated 3/10/2006 17:21:46 from IFRMAXIMO@prodsede2

CREATE UNIQUE INDEX ifrmaximo.maxhlp_ndx ON ifrmaximo.maxhlp
  (
    app                             ASC,
    window                          ASC,
    twname                          ASC,
    control                         ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
  TABLESPACE  tsi_maximo
  STORAGE   (
    INITIAL     65536
    MINEXTENTS  1
    MAXEXTENTS  2147483645
  )
/


-- End of DDL Script for Index IFRMAXIMO.MAXHLP_NDX

-- Start of DDL Script for Index IFRMAXIMO.MAXMODULES_NDX
-- Generated 3/10/2006 17:21:46 from IFRMAXIMO@prodsede2

CREATE UNIQUE INDEX ifrmaximo.maxmodules_ndx ON ifrmaximo.maxmodules
  (
    module                          ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
  TABLESPACE  tsi_maximo
  STORAGE   (
    INITIAL     40960
    MINEXTENTS  1
    MAXEXTENTS  2147483645
  )
/


-- End of DDL Script for Index IFRMAXIMO.MAXMODULES_NDX

-- Start of DDL Script for Index IFRMAXIMO.MAXRELATIONS_NDX1
-- Generated 3/10/2006 17:21:47 from IFRMAXIMO@prodsede2

CREATE UNIQUE INDEX ifrmaximo.maxrelations_ndx1 ON ifrmaximo.maxrelationship
  (
    parent                          ASC,
    name                            ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
  TABLESPACE  tsi_maximo
  STORAGE   (
    INITIAL     40960
    MINEXTENTS  1
    MAXEXTENTS  2147483645
  )
/


-- End of DDL Script for Index IFRMAXIMO.MAXRELATIONS_NDX1

-- Start of DDL Script for Index IFRMAXIMO.MAXREPORTDATE_IDX
-- Generated 3/10/2006 17:21:47 from IFRMAXIMO@prodsede2

CREATE UNIQUE INDEX ifrmaximo.maxreportdate_idx ON ifrmaximo.workorder
  (
    wonum                           ASC,
    crewid                          ASC,
    status                          ASC,
    istask                          ASC,
    siteid                          ASC,
    orgid                           ASC,
    reportdate                      ASC,
    actfinish                       ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
  TABLESPACE  tsi_maximo
  STORAGE   (
    INITIAL     65536
    MINEXTENTS  1
    MAXEXTENTS  2147483645
  )
/


-- End of DDL Script for Index IFRMAXIMO.MAXREPORTDATE_IDX

-- Start of DDL Script for Index IFRMAXIMO.MAXSCREENS_NDX2
-- Generated 3/10/2006 17:21:47 from IFRMAXIMO@prodsede2

CREATE UNIQUE INDEX ifrmaximo.maxscreens_ndx2 ON ifrmaximo.maxscreens
  (
    app                             ASC,
    id                              ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
  TABLESPACE  tsi_maximo
  STORAGE   (
    INITIAL     40960
    MINEXTENTS  1
    MAXEXTENTS  2147483645
  )
/


-- End of DDL Script for Index IFRMAXIMO.MAXSCREENS_NDX2

-- Start of DDL Script for Index IFRMAXIMO.MAXSCRN_NDX1
-- Generated 3/10/2006 17:21:47 from IFRMAXIMO@prodsede2

CREATE UNIQUE INDEX ifrmaximo.maxscrn_ndx1 ON ifrmaximo.maxscreens
  (
    app                             ASC,
    screen                          ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
  TABLESPACE  tsi_maximo
  STORAGE   (
    INITIAL     81920
    MINEXTENTS  1
    MAXEXTENTS  2147483645
  )
/


-- End of DDL Script for Index IFRMAXIMO.MAXSCRN_NDX1

-- Start of DDL Script for Index IFRMAXIMO.MAXSERVICE_NDX1
-- Generated 3/10/2006 17:21:47 from IFRMAXIMO@prodsede2

CREATE UNIQUE INDEX ifrmaximo.maxservice_ndx1 ON ifrmaximo.maxservice
  (
    servicename                     ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
  TABLESPACE  tsi_maximo
  STORAGE   (
    INITIAL     65536
    MINEXTENTS  1
    MAXEXTENTS  2147483645
  )
/


-- End of DDL Script for Index IFRMAXIMO.MAXSERVICE_NDX1

-- Start of DDL Script for Index IFRMAXIMO.MAXSYSCFG_NDX1
-- Generated 3/10/2006 17:21:47 from IFRMAXIMO@prodsede2

CREATE UNIQUE INDEX ifrmaximo.maxsyscfg_ndx1 ON ifrmaximo.maxsyscolscfg
  (
    tbname                          ASC,
    name                            ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
  TABLESPACE  tsi_maximo
  STORAGE   (
    INITIAL     65536
    MINEXTENTS  1
    MAXEXTENTS  2147483645
  )
/


-- End of DDL Script for Index IFRMAXIMO.MAXSYSCFG_NDX1

-- Start of DDL Script for Index IFRMAXIMO.MAXSYSCFG_NDX2
-- Generated 3/10/2006 17:21:48 from IFRMAXIMO@prodsede2

CREATE UNIQUE INDEX ifrmaximo.maxsyscfg_ndx2 ON ifrmaximo.maxsyscolscfg
  (
    tbname                          ASC,
    colalias                        ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
  TABLESPACE  tsi_maximo
  STORAGE   (
    INITIAL     65536
    MINEXTENTS  1
    MAXEXTENTS  2147483645
  )
/


-- End of DDL Script for Index IFRMAXIMO.MAXSYSCFG_NDX2

-- Start of DDL Script for Index IFRMAXIMO.MAXSYSCOLS_NDX1
-- Generated 3/10/2006 17:21:48 from IFRMAXIMO@prodsede2

CREATE UNIQUE INDEX ifrmaximo.maxsyscols_ndx1 ON ifrmaximo.maxsyscolumns
  (
    tbname                          ASC,
    name                            ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
  TABLESPACE  tsi_maximo
  STORAGE   (
    INITIAL     65536
    MINEXTENTS  1
    MAXEXTENTS  2147483645
  )
/


-- End of DDL Script for Index IFRMAXIMO.MAXSYSCOLS_NDX1

-- Start of DDL Script for Index IFRMAXIMO.MAXSYSCOLS_NDX2
-- Generated 3/10/2006 17:21:48 from IFRMAXIMO@prodsede2

CREATE UNIQUE INDEX ifrmaximo.maxsyscols_ndx2 ON ifrmaximo.maxsyscolumns
  (
    tbname                          ASC,
    colalias                        ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
  TABLESPACE  tsi_maximo
  STORAGE   (
    INITIAL     65536
    MINEXTENTS  1
    MAXEXTENTS  2147483645
  )
/


-- End of DDL Script for Index IFRMAXIMO.MAXSYSCOLS_NDX2

-- Start of DDL Script for Index IFRMAXIMO.MAXSYSCOLS2_NDX1
-- Generated 3/10/2006 17:21:48 from IFRMAXIMO@prodsede2

CREATE UNIQUE INDEX ifrmaximo.maxsyscols2_ndx1 ON ifrmaximo.maxsyscolumns2
  (
    tbname                          ASC,
    name                            ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
  TABLESPACE  tsi_maximo
  STORAGE   (
    INITIAL     65536
    MINEXTENTS  1
    MAXEXTENTS  2147483645
  )
/


-- End of DDL Script for Index IFRMAXIMO.MAXSYSCOLS2_NDX1

-- Start of DDL Script for Index IFRMAXIMO.MAXSYSCOLUMN_NDX3
-- Generated 3/10/2006 17:21:48 from IFRMAXIMO@prodsede2

CREATE INDEX ifrmaximo.maxsyscolumn_ndx3 ON ifrmaximo.maxsyscolumns
  (
    tbname                          ASC,
    dlfilterlistorder               ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
  TABLESPACE  tsi_maximo
  STORAGE   (
    INITIAL     65536
    MINEXTENTS  1
    MAXEXTENTS  2147483645
  )
/


-- End of DDL Script for Index IFRMAXIMO.MAXSYSCOLUMN_NDX3

-- Start of DDL Script for Index IFRMAXIMO.MAXSYSCOLUMN_NDX4
-- Generated 3/10/2006 17:21:48 from IFRMAXIMO@prodsede2

CREATE UNIQUE INDEX ifrmaximo.maxsyscolumn_ndx4 ON ifrmaximo.maxsyscolumns
  (
    tbname                          ASC,
    colno                           ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
  TABLESPACE  tsi_maximo
  STORAGE   (
    INITIAL     65536
    MINEXTENTS  1
    MAXEXTENTS  2147483645
  )
/


-- End of DDL Script for Index IFRMAXIMO.MAXSYSCOLUMN_NDX4

-- Start of DDL Script for Index IFRMAXIMO.MAXSYSKEYS_NDX
-- Generated 3/10/2006 17:21:49 from IFRMAXIMO@prodsede2

CREATE UNIQUE INDEX ifrmaximo.maxsyskeys_ndx ON ifrmaximo.maxsyskeys
  (
    ixname                          ASC,
    colname                         ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
  TABLESPACE  tsi_maximo
  STORAGE   (
    INITIAL     81920
    MINEXTENTS  1
    MAXEXTENTS  2147483645
  )
/


-- End of DDL Script for Index IFRMAXIMO.MAXSYSKEYS_NDX

-- Start of DDL Script for Index IFRMAXIMO.MAXSYSKEYS_NDX2
-- Generated 3/10/2006 17:21:49 from IFRMAXIMO@prodsede2

CREATE UNIQUE INDEX ifrmaximo.maxsyskeys_ndx2 ON ifrmaximo.maxsyskeys
  (
    ixname                          ASC,
    colseq                          ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
  TABLESPACE  tsi_maximo
  STORAGE   (
    INITIAL     40960
    MINEXTENTS  1
    MAXEXTENTS  2147483645
  )
/


-- End of DDL Script for Index IFRMAXIMO.MAXSYSKEYS_NDX2

-- Start of DDL Script for Index IFRMAXIMO.MAXSYSNDX_NDX
-- Generated 3/10/2006 17:21:49 from IFRMAXIMO@prodsede2

CREATE UNIQUE INDEX ifrmaximo.maxsysndx_ndx ON ifrmaximo.maxsysindexes
  (
    name                            ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
  TABLESPACE  tsi_maximo
  STORAGE   (
    INITIAL     65536
    MINEXTENTS  1
    MAXEXTENTS  2147483645
  )
/


-- End of DDL Script for Index IFRMAXIMO.MAXSYSNDX_NDX

-- Start of DDL Script for Index IFRMAXIMO.MAXSYSNDX_NDX2
-- Generated 3/10/2006 17:21:49 from IFRMAXIMO@prodsede2

CREATE INDEX ifrmaximo.maxsysndx_ndx2 ON ifrmaximo.maxsysindexes
  (
    tbname                          ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
  TABLESPACE  tsi_maximo
  STORAGE   (
    INITIAL     65536
    MINEXTENTS  1
    MAXEXTENTS  2147483645
  )
/


-- End of DDL Script for Index IFRMAXIMO.MAXSYSNDX_NDX2

-- Start of DDL Script for Index IFRMAXIMO.MAXTABLEDOM_NDX1
-- Generated 3/10/2006 17:21:49 from IFRMAXIMO@prodsede2

CREATE UNIQUE INDEX ifrmaximo.maxtabledom_ndx1 ON ifrmaximo.maxtabledomain
  (
    domainid                        ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
  TABLESPACE  tsi_maximo
  STORAGE   (
    INITIAL     40960
    MINEXTENTS  1
    MAXEXTENTS  2147483645
  )
/


-- End of DDL Script for Index IFRMAXIMO.MAXTABLEDOM_NDX1

-- Start of DDL Script for Index IFRMAXIMO.MAXTABLES_NDX
-- Generated 3/10/2006 17:21:49 from IFRMAXIMO@prodsede2

CREATE UNIQUE INDEX ifrmaximo.maxtables_ndx ON ifrmaximo.maxtables
  (
    tbname                          ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
  TABLESPACE  tsi_maximo
  STORAGE   (
    INITIAL     65536
    MINEXTENTS  1
    MAXEXTENTS  2147483645
  )
/


-- End of DDL Script for Index IFRMAXIMO.MAXTABLES_NDX

-- Start of DDL Script for Index IFRMAXIMO.MAXTABLES_NDX2
-- Generated 3/10/2006 17:21:50 from IFRMAXIMO@prodsede2

CREATE INDEX ifrmaximo.maxtables_ndx2 ON ifrmaximo.maxtables
  (
    app                             ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
  TABLESPACE  tsi_maximo
  STORAGE   (
    INITIAL     65536
    MINEXTENTS  1
    MAXEXTENTS  2147483645
  )
/


-- End of DDL Script for Index IFRMAXIMO.MAXTABLES_NDX2

-- Start of DDL Script for Index IFRMAXIMO.MAXTABLES2_NDX1
-- Generated 3/10/2006 17:21:50 from IFRMAXIMO@prodsede2

CREATE UNIQUE INDEX ifrmaximo.maxtables2_ndx1 ON ifrmaximo.maxtables2
  (
    tbname                          ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
  TABLESPACE  tsi_maximo
  STORAGE   (
    INITIAL     65536
    MINEXTENTS  1
    MAXEXTENTS  2147483645
  )
/


-- End of DDL Script for Index IFRMAXIMO.MAXTABLES2_NDX1

-- Start of DDL Script for Index IFRMAXIMO.MAXTABLES2_NDX2
-- Generated 3/10/2006 17:21:50 from IFRMAXIMO@prodsede2

CREATE INDEX ifrmaximo.maxtables2_ndx2 ON ifrmaximo.maxtables2
  (
    servicename                     ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
  TABLESPACE  tsi_maximo
  STORAGE   (
    INITIAL     65536
    MINEXTENTS  1
    MAXEXTENTS  2147483645
  )
/


-- End of DDL Script for Index IFRMAXIMO.MAXTABLES2_NDX2

-- Start of DDL Script for Index IFRMAXIMO.MAXTABLESCFG_NDX1
-- Generated 3/10/2006 17:21:50 from IFRMAXIMO@prodsede2

CREATE UNIQUE INDEX ifrmaximo.maxtablescfg_ndx1 ON ifrmaximo.maxtablescfg
  (
    tbname                          ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
  TABLESPACE  tsi_maximo
  STORAGE   (
    INITIAL     65536
    MINEXTENTS  1
    MAXEXTENTS  2147483645
  )
/


-- End of DDL Script for Index IFRMAXIMO.MAXTABLESCFG_NDX1

-- Start of DDL Script for Index IFRMAXIMO.MAXTABLESCFG_NDX2
-- Generated 3/10/2006 17:21:50 from IFRMAXIMO@prodsede2

CREATE INDEX ifrmaximo.maxtablescfg_ndx2 ON ifrmaximo.maxtablescfg
  (
    app                             ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
  TABLESPACE  tsi_maximo
  STORAGE   (
    INITIAL     65536
    MINEXTENTS  1
    MAXEXTENTS  2147483645
  )
/


-- End of DDL Script for Index IFRMAXIMO.MAXTABLESCFG_NDX2

-- Start of DDL Script for Index IFRMAXIMO.MAXTRIGGERS_NDX1
-- Generated 3/10/2006 17:21:50 from IFRMAXIMO@prodsede2

CREATE UNIQUE INDEX ifrmaximo.maxtriggers_ndx1 ON ifrmaximo.maxtriggers
  (
    triggername                     ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
  TABLESPACE  tsi_maximo
  STORAGE   (
    INITIAL     65536
    MINEXTENTS  1
    MAXEXTENTS  2147483645
  )
/


-- End of DDL Script for Index IFRMAXIMO.MAXTRIGGERS_NDX1

-- Start of DDL Script for Index IFRMAXIMO.MAXTRIGGERS_NDX2
-- Generated 3/10/2006 17:21:50 from IFRMAXIMO@prodsede2

CREATE INDEX ifrmaximo.maxtriggers_ndx2 ON ifrmaximo.maxtriggers
  (
    tbname                          ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
  TABLESPACE  tsi_maximo
  STORAGE   (
    INITIAL     65536
    MINEXTENTS  1
    MAXEXTENTS  2147483645
  )
/


-- End of DDL Script for Index IFRMAXIMO.MAXTRIGGERS_NDX2

-- Start of DDL Script for Index IFRMAXIMO.MAXUSERAUTH_NDX2
-- Generated 3/10/2006 17:21:51 from IFRMAXIMO@prodsede2

CREATE INDEX ifrmaximo.maxuserauth_ndx2 ON ifrmaximo.maxuserauth
  (
    name                            ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
  TABLESPACE  tsi_maximo
  STORAGE   (
    INITIAL     65536
    MINEXTENTS  1
    MAXEXTENTS  2147483645
  )
/


-- End of DDL Script for Index IFRMAXIMO.MAXUSERAUTH_NDX2

-- Start of DDL Script for Index IFRMAXIMO.MAXUSERGROUPS_NDX
-- Generated 3/10/2006 17:21:51 from IFRMAXIMO@prodsede2

CREATE UNIQUE INDEX ifrmaximo.maxusergroups_ndx ON ifrmaximo.maxusergroups
  (
    usrname                         ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
  TABLESPACE  tsi_maximo
  STORAGE   (
    INITIAL     65536
    MINEXTENTS  1
    MAXEXTENTS  2147483645
  )
/


-- End of DDL Script for Index IFRMAXIMO.MAXUSERGROUPS_NDX

-- Start of DDL Script for Index IFRMAXIMO.MAXUSERGROUPS_NDX2
-- Generated 3/10/2006 17:21:51 from IFRMAXIMO@prodsede2

CREATE INDEX ifrmaximo.maxusergroups_ndx2 ON ifrmaximo.maxusergroups
  (
    wfid                            ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
  TABLESPACE  tsi_maximo
  STORAGE   (
    INITIAL     65536
    MINEXTENTS  1
    MAXEXTENTS  2147483645
  )
/


-- End of DDL Script for Index IFRMAXIMO.MAXUSERGROUPS_NDX2

-- Start of DDL Script for Index IFRMAXIMO.MAXUSERSTATUS_NDX1
-- Generated 3/10/2006 17:21:51 from IFRMAXIMO@prodsede2

CREATE INDEX ifrmaximo.maxuserstatus_ndx1 ON ifrmaximo.maxuserstatus
  (
    username                        ASC,
    changedate                      ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
  TABLESPACE  tsi_maximo
  STORAGE   (
    INITIAL     65536
    MINEXTENTS  1
    MAXEXTENTS  2147483645
  )
/


-- End of DDL Script for Index IFRMAXIMO.MAXUSERSTATUS_NDX1

-- Start of DDL Script for Index IFRMAXIMO.MAXUSRAUTH_NDX
-- Generated 3/10/2006 17:21:51 from IFRMAXIMO@prodsede2

CREATE UNIQUE INDEX ifrmaximo.maxusrauth_ndx ON ifrmaximo.maxuserauth
  (
    app                             ASC,
    optionname                      ASC,
    name                            ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
  TABLESPACE  tsi_maximo
  STORAGE   (
    INITIAL     65536
    MINEXTENTS  1
    MAXEXTENTS  2147483645
  )
/


-- End of DDL Script for Index IFRMAXIMO.MAXUSRAUTH_NDX

-- Start of DDL Script for Index IFRMAXIMO.MAXVARS_NDX1
-- Generated 3/10/2006 17:21:51 from IFRMAXIMO@prodsede2

CREATE UNIQUE INDEX ifrmaximo.maxvars_ndx1 ON ifrmaximo.maxvars
  (
    varname                         ASC,
    orgid                           ASC,
    siteid                          ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
  TABLESPACE  tsi_maximo
  STORAGE   (
    INITIAL     65536
    MINEXTENTS  1
    MAXEXTENTS  2147483645
  )
/


-- End of DDL Script for Index IFRMAXIMO.MAXVARS_NDX1

-- Start of DDL Script for Index IFRMAXIMO.MAXVARS_NDX2
-- Generated 3/10/2006 17:21:52 from IFRMAXIMO@prodsede2

CREATE UNIQUE INDEX ifrmaximo.maxvars_ndx2 ON ifrmaximo.maxvars
  (
    varname                         ASC,
    siteid                          ASC,
    orgid                           ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
  TABLESPACE  tsi_maximo
  STORAGE   (
    INITIAL     65536
    MINEXTENTS  1
    MAXEXTENTS  2147483645
  )
/


-- End of DDL Script for Index IFRMAXIMO.MAXVARS_NDX2

-- Start of DDL Script for Index IFRMAXIMO.MAXVARTYPE_NDX1
-- Generated 3/10/2006 17:21:52 from IFRMAXIMO@prodsede2

CREATE UNIQUE INDEX ifrmaximo.maxvartype_ndx1 ON ifrmaximo.maxvartype
  (
    varname                         ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
  TABLESPACE  tsi_maximo
  STORAGE   (
    INITIAL     65536
    MINEXTENTS  1
    MAXEXTENTS  2147483645
  )
/


-- End of DDL Script for Index IFRMAXIMO.MAXVARTYPE_NDX1

-- Start of DDL Script for Index IFRMAXIMO.MEASUREMENT_NDX1
-- Generated 3/10/2006 17:21:52 from IFRMAXIMO@prodsede2

CREATE INDEX ifrmaximo.measurement_ndx1 ON ifrmaximo.measurement
  (
    siteid                          ASC,
    pointnum                        ASC,
    measuredate                     ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
  TABLESPACE  tsi_maximo
  STORAGE   (
    INITIAL     65536
    MINEXTENTS  1
    MAXEXTENTS  2147483645
  )
/


-- End of DDL Script for Index IFRMAXIMO.MEASUREMENT_NDX1

-- Start of DDL Script for Index IFRMAXIMO.MEASUREPOINT_NDX1
-- Generated 3/10/2006 17:21:52 from IFRMAXIMO@prodsede2

CREATE UNIQUE INDEX ifrmaximo.measurepoint_ndx1 ON ifrmaximo.measurepoint
  (
    siteid                          ASC,
    pointnum                        ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
  TABLESPACE  tsi_maximo
  STORAGE   (
    INITIAL     65536
    MINEXTENTS  1
    MAXEXTENTS  2147483645
  )
/


-- End of DDL Script for Index IFRMAXIMO.MEASUREPOINT_NDX1

-- Start of DDL Script for Index IFRMAXIMO.MEASUREPOINT_NDX2
-- Generated 3/10/2006 17:21:52 from IFRMAXIMO@prodsede2

CREATE UNIQUE INDEX ifrmaximo.measurepoint_ndx2 ON ifrmaximo.measurepoint
  (
    siteid                          ASC,
    eqnum                           ASC,
    pointnum                        ASC,
    pointname                       ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
  TABLESPACE  tsi_maximo
  STORAGE   (
    INITIAL     65536
    MINEXTENTS  1
    MAXEXTENTS  2147483645
  )
/


-- End of DDL Script for Index IFRMAXIMO.MEASUREPOINT_NDX2

-- Start of DDL Script for Index IFRMAXIMO.MEASUREUNIT_NDX1
-- Generated 3/10/2006 17:21:52 from IFRMAXIMO@prodsede2

CREATE UNIQUE INDEX ifrmaximo.measureunit_ndx1 ON ifrmaximo.measureunit
  (
    orgid                           ASC,
    measureunitid                   ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
  TABLESPACE  tsi_maximo
  STORAGE   (
    INITIAL     65536
    MINEXTENTS  1
    MAXEXTENTS  2147483645
  )
/


-- End of DDL Script for Index IFRMAXIMO.MEASUREUNIT_NDX1

-- Start of DDL Script for Index IFRMAXIMO.MR_NDX1
-- Generated 3/10/2006 17:21:53 from IFRMAXIMO@prodsede2

CREATE UNIQUE INDEX ifrmaximo.mr_ndx1 ON ifrmaximo.mr
  (
    siteid                          ASC,
    mrnum                           ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
  TABLESPACE  tsi_maximo
  STORAGE   (
    INITIAL     65536
    MINEXTENTS  1
    MAXEXTENTS  2147483645
  )
/


-- End of DDL Script for Index IFRMAXIMO.MR_NDX1

-- Start of DDL Script for Index IFRMAXIMO.MR_NDX2
-- Generated 3/10/2006 17:21:53 from IFRMAXIMO@prodsede2

CREATE INDEX ifrmaximo.mr_ndx2 ON ifrmaximo.mr
  (
    siteid                          ASC,
    wfid                            ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
  TABLESPACE  tsi_maximo
  STORAGE   (
    INITIAL     65536
    MINEXTENTS  1
    MAXEXTENTS  2147483645
  )
/


-- End of DDL Script for Index IFRMAXIMO.MR_NDX2

-- Start of DDL Script for Index IFRMAXIMO.MRCOST_NDX1
-- Generated 3/10/2006 17:21:53 from IFRMAXIMO@prodsede2

CREATE UNIQUE INDEX ifrmaximo.mrcost_ndx1 ON ifrmaximo.mrcost
  (
    siteid                          ASC,
    mrcostlineid                    ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
  TABLESPACE  tsi_maximo
  STORAGE   (
    INITIAL     65536
    MINEXTENTS  1
    MAXEXTENTS  2147483645
  )
/


-- End of DDL Script for Index IFRMAXIMO.MRCOST_NDX1

-- Start of DDL Script for Index IFRMAXIMO.MRLINE_NDX1
-- Generated 3/10/2006 17:21:53 from IFRMAXIMO@prodsede2

CREATE UNIQUE INDEX ifrmaximo.mrline_ndx1 ON ifrmaximo.mrline
  (
    siteid                          ASC,
    mrlineid                        ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
  TABLESPACE  tsi_maximo
  STORAGE   (
    INITIAL     65536
    MINEXTENTS  1
    MAXEXTENTS  2147483645
  )
/


-- End of DDL Script for Index IFRMAXIMO.MRLINE_NDX1

-- Start of DDL Script for Index IFRMAXIMO.MRLINE_NDX2
-- Generated 3/10/2006 17:21:53 from IFRMAXIMO@prodsede2

CREATE UNIQUE INDEX ifrmaximo.mrline_ndx2 ON ifrmaximo.mrline
  (
    siteid                          ASC,
    mrnum                           ASC,
    mrlinenum                       ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
  TABLESPACE  tsi_maximo
  STORAGE   (
    INITIAL     65536
    MINEXTENTS  1
    MAXEXTENTS  2147483645
  )
/


-- End of DDL Script for Index IFRMAXIMO.MRLINE_NDX2

-- Start of DDL Script for Index IFRMAXIMO.MRLINE_NDX3
-- Generated 3/10/2006 17:21:53 from IFRMAXIMO@prodsede2

CREATE INDEX ifrmaximo.mrline_ndx3 ON ifrmaximo.mrline
  (
    siteid                          ASC,
    prnum                           ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
  TABLESPACE  tsi_maximo
  STORAGE   (
    INITIAL     65536
    MINEXTENTS  1
    MAXEXTENTS  2147483645
  )
/


-- End of DDL Script for Index IFRMAXIMO.MRLINE_NDX3

-- Start of DDL Script for Index IFRMAXIMO.MRSTATUS_NDX1
-- Generated 3/10/2006 17:21:54 from IFRMAXIMO@prodsede2

CREATE UNIQUE INDEX ifrmaximo.mrstatus_ndx1 ON ifrmaximo.mrstatus
  (
    siteid                          ASC,
    mrstatusseq                     ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
  TABLESPACE  tsi_maximo
  STORAGE   (
    INITIAL     65536
    MINEXTENTS  1
    MAXEXTENTS  2147483645
  )
/


-- End of DDL Script for Index IFRMAXIMO.MRSTATUS_NDX1

-- Start of DDL Script for Index IFRMAXIMO.MRSTATUS_NDX2
-- Generated 3/10/2006 17:21:54 from IFRMAXIMO@prodsede2

CREATE INDEX ifrmaximo.mrstatus_ndx2 ON ifrmaximo.mrstatus
  (
    siteid                          ASC,
    mrnum                           ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
  TABLESPACE  tsi_maximo
  STORAGE   (
    INITIAL     65536
    MINEXTENTS  1
    MAXEXTENTS  2147483645
  )
/


-- End of DDL Script for Index IFRMAXIMO.MRSTATUS_NDX2

-- Start of DDL Script for Index IFRMAXIMO.MXCOLLAB_NDX2
-- Generated 3/10/2006 17:21:54 from IFRMAXIMO@prodsede2

CREATE UNIQUE INDEX ifrmaximo.mxcollab_ndx2 ON ifrmaximo.mxcollab
  (
    owner1sysid                     ASC,
    owner2sysid                     ASC,
    pcid                            ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
  TABLESPACE  tsi_maximo
  STORAGE   (
    INITIAL     65536
    MINEXTENTS  1
    MAXEXTENTS  2147483645
  )
/


-- End of DDL Script for Index IFRMAXIMO.MXCOLLAB_NDX2

-- Start of DDL Script for Index IFRMAXIMO.MXCOLLABREF_NDX
-- Generated 3/10/2006 17:21:54 from IFRMAXIMO@prodsede2

CREATE UNIQUE INDEX ifrmaximo.mxcollabref_ndx ON ifrmaximo.mxcollabref
  (
    pcid                            ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
  TABLESPACE  tsi_maximo
  STORAGE   (
    INITIAL     65536
    MINEXTENTS  1
    MAXEXTENTS  2147483645
  )
/


-- End of DDL Script for Index IFRMAXIMO.MXCOLLABREF_NDX

-- Start of DDL Script for Index IFRMAXIMO.NUMDOMAINVAL_NDX1
-- Generated 3/10/2006 17:21:54 from IFRMAXIMO@prodsede2

CREATE UNIQUE INDEX ifrmaximo.numdomainval_ndx1 ON ifrmaximo.numdomainvalue
  (
    domainid                        ASC,
    numvalue                        ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
  TABLESPACE  tsi_maximo
  STORAGE   (
    INITIAL     40960
    MINEXTENTS  1
    MAXEXTENTS  2147483645
  )
/


-- End of DDL Script for Index IFRMAXIMO.NUMDOMAINVAL_NDX1

-- Start of DDL Script for Index IFRMAXIMO.ORDERUNIT_NDX1
-- Generated 3/10/2006 17:21:54 from IFRMAXIMO@prodsede2

CREATE UNIQUE INDEX ifrmaximo.orderunit_ndx1 ON ifrmaximo.orderunit
  (
    orgid                           ASC,
    orderunit                       ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
  TABLESPACE  tsi_maximo
  STORAGE   (
    INITIAL     65536
    MINEXTENTS  1
    MAXEXTENTS  2147483645
  )
/


-- End of DDL Script for Index IFRMAXIMO.ORDERUNIT_NDX1

-- Start of DDL Script for Index IFRMAXIMO.ORGANIZATION_NDX
-- Generated 3/10/2006 17:21:55 from IFRMAXIMO@prodsede2

CREATE UNIQUE INDEX ifrmaximo.organization_ndx ON ifrmaximo.organization
  (
    orgid                           ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
  TABLESPACE  tsi_maximo
  STORAGE   (
    INITIAL     65536
    MINEXTENTS  1
    MAXEXTENTS  2147483645
  )
/


-- End of DDL Script for Index IFRMAXIMO.ORGANIZATION_NDX

-- Start of DDL Script for Index IFRMAXIMO.PM_NDX1
-- Generated 3/10/2006 17:21:55 from IFRMAXIMO@prodsede2

CREATE UNIQUE INDEX ifrmaximo.pm_ndx1 ON ifrmaximo.pm
  (
    siteid                          ASC,
    pmnum                           ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
  TABLESPACE  tsi_maximo
  STORAGE   (
    INITIAL     65536
    MINEXTENTS  1
    MAXEXTENTS  2147483645
  )
/


-- End of DDL Script for Index IFRMAXIMO.PM_NDX1

-- Start of DDL Script for Index IFRMAXIMO.PM_NDX2
-- Generated 3/10/2006 17:21:55 from IFRMAXIMO@prodsede2

CREATE INDEX ifrmaximo.pm_ndx2 ON ifrmaximo.pm
  (
    siteid                          ASC,
    eqnum                           ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
  TABLESPACE  tsi_maximo
  STORAGE   (
    INITIAL     65536
    MINEXTENTS  1
    MAXEXTENTS  2147483645
  )
/


-- End of DDL Script for Index IFRMAXIMO.PM_NDX2

-- Start of DDL Script for Index IFRMAXIMO.PM_NDX3
-- Generated 3/10/2006 17:21:55 from IFRMAXIMO@prodsede2

CREATE INDEX ifrmaximo.pm_ndx3 ON ifrmaximo.pm
  (
    siteid                          ASC,
    location                        ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
  TABLESPACE  tsi_maximo
  STORAGE   (
    INITIAL     65536
    MINEXTENTS  1
    MAXEXTENTS  2147483645
  )
/


-- End of DDL Script for Index IFRMAXIMO.PM_NDX3

-- Start of DDL Script for Index IFRMAXIMO.PM_NDX4
-- Generated 3/10/2006 17:21:55 from IFRMAXIMO@prodsede2

CREATE INDEX ifrmaximo.pm_ndx4 ON ifrmaximo.pm
  (
    siteid                          ASC,
    parent                          ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
  TABLESPACE  tsi_maximo
  STORAGE   (
    INITIAL     65536
    MINEXTENTS  1
    MAXEXTENTS  2147483645
  )
/


-- End of DDL Script for Index IFRMAXIMO.PM_NDX4

-- Start of DDL Script for Index IFRMAXIMO.PM_NDX5
-- Generated 3/10/2006 17:21:55 from IFRMAXIMO@prodsede2

CREATE INDEX ifrmaximo.pm_ndx5 ON ifrmaximo.pm
  (
    pm18                            ASC,
    siteid                          ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
  TABLESPACE  tsi_maximo
  STORAGE   (
    INITIAL     65536
    MINEXTENTS  1
    MAXEXTENTS  2147483645
  )
/


-- End of DDL Script for Index IFRMAXIMO.PM_NDX5

-- Start of DDL Script for Index IFRMAXIMO.PMANCESTOR_NDX1
-- Generated 3/10/2006 17:21:56 from IFRMAXIMO@prodsede2

CREATE UNIQUE INDEX ifrmaximo.pmancestor_ndx1 ON ifrmaximo.pmancestor
  (
    siteid                          ASC,
    pmnum                           ASC,
    ancestor                        ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
  TABLESPACE  tsi_maximo
  STORAGE   (
    INITIAL     65536
    MINEXTENTS  1
    MAXEXTENTS  2147483645
  )
/


-- End of DDL Script for Index IFRMAXIMO.PMANCESTOR_NDX1

-- Start of DDL Script for Index IFRMAXIMO.PMSCHEDACT_NDX1
-- Generated 3/10/2006 17:21:56 from IFRMAXIMO@prodsede2

CREATE UNIQUE INDEX ifrmaximo.pmschedact_ndx1 ON ifrmaximo.pmschedactivity
  (
    siteid                          ASC,
    projectname                     ASC,
    pmschedactivityid               ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
  TABLESPACE  tsi_maximo
  STORAGE   (
    INITIAL     65536
    MINEXTENTS  1
    MAXEXTENTS  2147483645
  )
/


-- End of DDL Script for Index IFRMAXIMO.PMSCHEDACT_NDX1

-- Start of DDL Script for Index IFRMAXIMO.PMSEQUENCE_NDX1
-- Generated 3/10/2006 17:21:56 from IFRMAXIMO@prodsede2

CREATE UNIQUE INDEX ifrmaximo.pmsequence_ndx1 ON ifrmaximo.pmsequence
  (
    siteid                          ASC,
    pmnum                           ASC,
    interval                        ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
  TABLESPACE  tsi_maximo
  STORAGE   (
    INITIAL     65536
    MINEXTENTS  1
    MAXEXTENTS  2147483645
  )
/


-- End of DDL Script for Index IFRMAXIMO.PMSEQUENCE_NDX1

-- Start of DDL Script for Index IFRMAXIMO.PO_NDX1
-- Generated 3/10/2006 17:21:56 from IFRMAXIMO@prodsede2

CREATE UNIQUE INDEX ifrmaximo.po_ndx1 ON ifrmaximo.po
  (
    orgid                           ASC,
    ponum                           ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
  TABLESPACE  tsi_maximo
  STORAGE   (
    INITIAL     65536
    MINEXTENTS  1
    MAXEXTENTS  2147483645
  )
/


-- End of DDL Script for Index IFRMAXIMO.PO_NDX1

-- Start of DDL Script for Index IFRMAXIMO.PO_NDX2
-- Generated 3/10/2006 17:21:56 from IFRMAXIMO@prodsede2

CREATE INDEX ifrmaximo.po_ndx2 ON ifrmaximo.po
  (
    orgid                           ASC,
    vendor                          ASC,
    potype                          ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
  TABLESPACE  tsi_maximo
  STORAGE   (
    INITIAL     65536
    MINEXTENTS  1
    MAXEXTENTS  2147483645
  )
/


-- End of DDL Script for Index IFRMAXIMO.PO_NDX2

-- Start of DDL Script for Index IFRMAXIMO.PO_NDX3
-- Generated 3/10/2006 17:21:56 from IFRMAXIMO@prodsede2

CREATE INDEX ifrmaximo.po_ndx3 ON ifrmaximo.po
  (
    orgid                           ASC,
    originalponum                   ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
  TABLESPACE  tsi_maximo
  STORAGE   (
    INITIAL     65536
    MINEXTENTS  1
    MAXEXTENTS  2147483645
  )
/


-- End of DDL Script for Index IFRMAXIMO.PO_NDX3

-- Start of DDL Script for Index IFRMAXIMO.PO_NDX4
-- Generated 3/10/2006 17:21:56 from IFRMAXIMO@prodsede2

CREATE INDEX ifrmaximo.po_ndx4 ON ifrmaximo.po
  (
    orgid                           ASC,
    interid                         ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
  TABLESPACE  tsi_maximo
  STORAGE   (
    INITIAL     65536
    MINEXTENTS  1
    MAXEXTENTS  2147483645
  )
/


-- End of DDL Script for Index IFRMAXIMO.PO_NDX4

-- Start of DDL Script for Index IFRMAXIMO.PO_NDX5
-- Generated 3/10/2006 17:21:57 from IFRMAXIMO@prodsede2

CREATE INDEX ifrmaximo.po_ndx5 ON ifrmaximo.po
  (
    orgid                           ASC,
    wfid                            ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
  TABLESPACE  tsi_maximo
  STORAGE   (
    INITIAL     65536
    MINEXTENTS  1
    MAXEXTENTS  2147483645
  )
/


-- End of DDL Script for Index IFRMAXIMO.PO_NDX5

-- Start of DDL Script for Index IFRMAXIMO.POCOST_NDX1
-- Generated 3/10/2006 17:21:57 from IFRMAXIMO@prodsede2

CREATE UNIQUE INDEX ifrmaximo.pocost_ndx1 ON ifrmaximo.pocost
  (
    orgid                           ASC,
    pocostlineid                    ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
  TABLESPACE  tsi_maximo
  STORAGE   (
    INITIAL     65536
    MINEXTENTS  1
    MAXEXTENTS  2147483645
  )
/


-- End of DDL Script for Index IFRMAXIMO.POCOST_NDX1

-- Start of DDL Script for Index IFRMAXIMO.POECOMSTATUS_NDX1
-- Generated 3/10/2006 17:21:57 from IFRMAXIMO@prodsede2

CREATE INDEX ifrmaximo.poecomstatus_ndx1 ON ifrmaximo.poecomstatus
  (
    orgid                           ASC,
    ponum                           ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
  TABLESPACE  tsi_maximo
  STORAGE   (
    INITIAL     65536
    MINEXTENTS  1
    MAXEXTENTS  2147483645
  )
/


-- End of DDL Script for Index IFRMAXIMO.POECOMSTATUS_NDX1

-- Start of DDL Script for Index IFRMAXIMO.POECOMSTATUS_NDX2
-- Generated 3/10/2006 17:21:57 from IFRMAXIMO@prodsede2

CREATE INDEX ifrmaximo.poecomstatus_ndx2 ON ifrmaximo.poecomstatus
  (
    orgid                           ASC,
    changedate                      ASC,
    ponum                           ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
  TABLESPACE  tsi_maximo
  STORAGE   (
    INITIAL     65536
    MINEXTENTS  1
    MAXEXTENTS  2147483645
  )
/


-- End of DDL Script for Index IFRMAXIMO.POECOMSTATUS_NDX2

-- Start of DDL Script for Index IFRMAXIMO.POINTWO_NDX1
-- Generated 3/10/2006 17:21:57 from IFRMAXIMO@prodsede2

CREATE UNIQUE INDEX ifrmaximo.pointwo_ndx1 ON ifrmaximo.pointwo
  (
    siteid                          ASC,
    wonum                           ASC,
    pointnum                        ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
  TABLESPACE  tsi_maximo
  STORAGE   (
    INITIAL     65536
    MINEXTENTS  1
    MAXEXTENTS  2147483645
  )
/


-- End of DDL Script for Index IFRMAXIMO.POINTWO_NDX1

-- Start of DDL Script for Index IFRMAXIMO.POINTWO_NDX2
-- Generated 3/10/2006 17:21:57 from IFRMAXIMO@prodsede2

CREATE INDEX ifrmaximo.pointwo_ndx2 ON ifrmaximo.pointwo
  (
    siteid                          ASC,
    pointnum                        ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
  TABLESPACE  tsi_maximo
  STORAGE   (
    INITIAL     65536
    MINEXTENTS  1
    MAXEXTENTS  2147483645
  )
/


-- End of DDL Script for Index IFRMAXIMO.POINTWO_NDX2

-- Start of DDL Script for Index IFRMAXIMO.POLINE_NDX1
-- Generated 3/10/2006 17:21:58 from IFRMAXIMO@prodsede2

CREATE UNIQUE INDEX ifrmaximo.poline_ndx1 ON ifrmaximo.poline
  (
    orgid                           ASC,
    polineid                        ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
  TABLESPACE  tsi_maximo
  STORAGE   (
    INITIAL     65536
    MINEXTENTS  1
    MAXEXTENTS  2147483645
  )
/


-- End of DDL Script for Index IFRMAXIMO.POLINE_NDX1

-- Start of DDL Script for Index IFRMAXIMO.POLINE_NDX2
-- Generated 3/10/2006 17:21:58 from IFRMAXIMO@prodsede2

CREATE INDEX ifrmaximo.poline_ndx2 ON ifrmaximo.poline
  (
    orgid                           ASC,
    ponum                           ASC,
    polinenum                       ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
  TABLESPACE  tsi_maximo
  STORAGE   (
    INITIAL     65536
    MINEXTENTS  1
    MAXEXTENTS  2147483645
  )
/


-- End of DDL Script for Index IFRMAXIMO.POLINE_NDX2

-- Start of DDL Script for Index IFRMAXIMO.POLINE_NDX3
-- Generated 3/10/2006 17:21:58 from IFRMAXIMO@prodsede2

CREATE INDEX ifrmaximo.poline_ndx3 ON ifrmaximo.poline
  (
    orgid                           ASC,
    itemnum                         ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
  TABLESPACE  tsi_maximo
  STORAGE   (
    INITIAL     65536
    MINEXTENTS  1
    MAXEXTENTS  2147483645
  )
/


-- End of DDL Script for Index IFRMAXIMO.POLINE_NDX3

-- Start of DDL Script for Index IFRMAXIMO.POLINE_NDX4
-- Generated 3/10/2006 17:21:58 from IFRMAXIMO@prodsede2

CREATE INDEX ifrmaximo.poline_ndx4 ON ifrmaximo.poline
  (
    orgid                           ASC,
    catalogcode                     ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
  TABLESPACE  tsi_maximo
  STORAGE   (
    INITIAL     65536
    MINEXTENTS  1
    MAXEXTENTS  2147483645
  )
/


-- End of DDL Script for Index IFRMAXIMO.POLINE_NDX4

-- Start of DDL Script for Index IFRMAXIMO.POLINE_NDX5
-- Generated 3/10/2006 17:21:58 from IFRMAXIMO@prodsede2

CREATE INDEX ifrmaximo.poline_ndx5 ON ifrmaximo.poline
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
  TABLESPACE  tsi_maximo
  STORAGE   (
    INITIAL     65536
    MINEXTENTS  1
    MAXEXTENTS  2147483645
  )
/


-- End of DDL Script for Index IFRMAXIMO.POLINE_NDX5

-- Start of DDL Script for Index IFRMAXIMO.POLINE_NDX6
-- Generated 3/10/2006 17:21:58 from IFRMAXIMO@prodsede2

CREATE INDEX ifrmaximo.poline_ndx6 ON ifrmaximo.poline
  (
    orderunit                       ASC,
    mrnum                           ASC,
    mrlinenum                       ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
  TABLESPACE  tsi_maximo
  STORAGE   (
    INITIAL     65536
    MINEXTENTS  1
    MAXEXTENTS  2147483645
  )
/


-- End of DDL Script for Index IFRMAXIMO.POLINE_NDX6

-- Start of DDL Script for Index IFRMAXIMO.POSTATUS_NDX1
-- Generated 3/10/2006 17:21:59 from IFRMAXIMO@prodsede2

CREATE INDEX ifrmaximo.postatus_ndx1 ON ifrmaximo.postatus
  (
    orgid                           ASC,
    ponum                           ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
  TABLESPACE  tsi_maximo
  STORAGE   (
    INITIAL     65536
    MINEXTENTS  1
    MAXEXTENTS  2147483645
  )
/


-- End of DDL Script for Index IFRMAXIMO.POSTATUS_NDX1

-- Start of DDL Script for Index IFRMAXIMO.POSTATUS_NDX2
-- Generated 3/10/2006 17:21:59 from IFRMAXIMO@prodsede2

CREATE INDEX ifrmaximo.postatus_ndx2 ON ifrmaximo.postatus
  (
    orgid                           ASC,
    changedate                      ASC,
    ponum                           ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
  TABLESPACE  tsi_maximo
  STORAGE   (
    INITIAL     65536
    MINEXTENTS  1
    MAXEXTENTS  2147483645
  )
/


-- End of DDL Script for Index IFRMAXIMO.POSTATUS_NDX2

-- Start of DDL Script for Index IFRMAXIMO.PR_NDX1
-- Generated 3/10/2006 17:21:59 from IFRMAXIMO@prodsede2

CREATE UNIQUE INDEX ifrmaximo.pr_ndx1 ON ifrmaximo.pr
  (
    siteid                          ASC,
    prnum                           ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
  TABLESPACE  tsi_maximo
  STORAGE   (
    INITIAL     65536
    MINEXTENTS  1
    MAXEXTENTS  2147483645
  )
/


-- End of DDL Script for Index IFRMAXIMO.PR_NDX1

-- Start of DDL Script for Index IFRMAXIMO.PR_NDX2
-- Generated 3/10/2006 17:21:59 from IFRMAXIMO@prodsede2

CREATE INDEX ifrmaximo.pr_ndx2 ON ifrmaximo.pr
  (
    siteid                          ASC,
    vendor                          ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
  TABLESPACE  tsi_maximo
  STORAGE   (
    INITIAL     65536
    MINEXTENTS  1
    MAXEXTENTS  2147483645
  )
/


-- End of DDL Script for Index IFRMAXIMO.PR_NDX2

-- Start of DDL Script for Index IFRMAXIMO.PR_NDX3
-- Generated 3/10/2006 17:21:59 from IFRMAXIMO@prodsede2

CREATE INDEX ifrmaximo.pr_ndx3 ON ifrmaximo.pr
  (
    siteid                          ASC,
    interid                         ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
  TABLESPACE  tsi_maximo
  STORAGE   (
    INITIAL     65536
    MINEXTENTS  1
    MAXEXTENTS  2147483645
  )
/


-- End of DDL Script for Index IFRMAXIMO.PR_NDX3

-- Start of DDL Script for Index IFRMAXIMO.PR_NDX4
-- Generated 3/10/2006 17:21:59 from IFRMAXIMO@prodsede2

CREATE INDEX ifrmaximo.pr_ndx4 ON ifrmaximo.pr
  (
    siteid                          ASC,
    wfid                            ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
  TABLESPACE  tsi_maximo
  STORAGE   (
    INITIAL     65536
    MINEXTENTS  1
    MAXEXTENTS  2147483645
  )
/


-- End of DDL Script for Index IFRMAXIMO.PR_NDX4

-- Start of DDL Script for Index IFRMAXIMO.PRCOST_NDX1
-- Generated 3/10/2006 17:22:00 from IFRMAXIMO@prodsede2

CREATE UNIQUE INDEX ifrmaximo.prcost_ndx1 ON ifrmaximo.prcost
  (
    siteid                          ASC,
    prcostlineid                    ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
  TABLESPACE  tsi_maximo
  STORAGE   (
    INITIAL     65536
    MINEXTENTS  1
    MAXEXTENTS  2147483645
  )
/


-- End of DDL Script for Index IFRMAXIMO.PRCOST_NDX1

-- Start of DDL Script for Index IFRMAXIMO.PRECAUTION_NDX1
-- Generated 3/10/2006 17:22:00 from IFRMAXIMO@prodsede2

CREATE UNIQUE INDEX ifrmaximo.precaution_ndx1 ON ifrmaximo.precaution
  (
    siteid                          ASC,
    precautionid                    ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
  TABLESPACE  tsi_maximo
  STORAGE   (
    INITIAL     65536
    MINEXTENTS  1
    MAXEXTENTS  2147483645
  )
/


-- End of DDL Script for Index IFRMAXIMO.PRECAUTION_NDX1

-- Start of DDL Script for Index IFRMAXIMO.PRICALC_NDX1
-- Generated 3/10/2006 17:22:00 from IFRMAXIMO@prodsede2

CREATE UNIQUE INDEX ifrmaximo.pricalc_ndx1 ON ifrmaximo.pricalc
  (
    siteid                          ASC,
    findex                          ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
  TABLESPACE  tsi_maximo
  STORAGE   (
    INITIAL     65536
    MINEXTENTS  1
    MAXEXTENTS  2147483645
  )
/


-- End of DDL Script for Index IFRMAXIMO.PRICALC_NDX1

-- Start of DDL Script for Index IFRMAXIMO.PRINTER_NDX1
-- Generated 3/10/2006 17:22:00 from IFRMAXIMO@prodsede2

CREATE UNIQUE INDEX ifrmaximo.printer_ndx1 ON ifrmaximo.printer
  (
    tbname                          ASC,
    colname                         ASC,
    value                           ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
  TABLESPACE  tsi_maximo
  STORAGE   (
    INITIAL     65536
    MINEXTENTS  1
    MAXEXTENTS  2147483645
  )
/


-- End of DDL Script for Index IFRMAXIMO.PRINTER_NDX1

-- Start of DDL Script for Index IFRMAXIMO.PRLINE_NDX1
-- Generated 3/10/2006 17:22:00 from IFRMAXIMO@prodsede2

CREATE UNIQUE INDEX ifrmaximo.prline_ndx1 ON ifrmaximo.prline
  (
    siteid                          ASC,
    prlineid                        ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
  TABLESPACE  tsi_maximo
  STORAGE   (
    INITIAL     65536
    MINEXTENTS  1
    MAXEXTENTS  2147483645
  )
/


-- End of DDL Script for Index IFRMAXIMO.PRLINE_NDX1

-- Start of DDL Script for Index IFRMAXIMO.PRLINE_NDX2
-- Generated 3/10/2006 17:22:00 from IFRMAXIMO@prodsede2

CREATE INDEX ifrmaximo.prline_ndx2 ON ifrmaximo.prline
  (
    siteid                          ASC,
    polineid                        ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
  TABLESPACE  tsi_maximo
  STORAGE   (
    INITIAL     65536
    MINEXTENTS  1
    MAXEXTENTS  2147483645
  )
/


-- End of DDL Script for Index IFRMAXIMO.PRLINE_NDX2

-- Start of DDL Script for Index IFRMAXIMO.PRLINE_NDX3
-- Generated 3/10/2006 17:22:01 from IFRMAXIMO@prodsede2

CREATE INDEX ifrmaximo.prline_ndx3 ON ifrmaximo.prline
  (
    siteid                          ASC,
    ponum                           ASC,
    polinenum                       ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
  TABLESPACE  tsi_maximo
  STORAGE   (
    INITIAL     65536
    MINEXTENTS  1
    MAXEXTENTS  2147483645
  )
/


-- End of DDL Script for Index IFRMAXIMO.PRLINE_NDX3

-- Start of DDL Script for Index IFRMAXIMO.PRLINE_NDX4
-- Generated 3/10/2006 17:22:01 from IFRMAXIMO@prodsede2

CREATE INDEX ifrmaximo.prline_ndx4 ON ifrmaximo.prline
  (
    siteid                          ASC,
    mrnum                           ASC,
    mrlinenum                       ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
  TABLESPACE  tsi_maximo
  STORAGE   (
    INITIAL     65536
    MINEXTENTS  1
    MAXEXTENTS  2147483645
  )
/


-- End of DDL Script for Index IFRMAXIMO.PRLINE_NDX4

-- Start of DDL Script for Index IFRMAXIMO.PRLINE_NDX5
-- Generated 3/10/2006 17:22:01 from IFRMAXIMO@prodsede2

CREATE INDEX ifrmaximo.prline_ndx5 ON ifrmaximo.prline
  (
    siteid                          ASC,
    itemnum                         ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
  TABLESPACE  tsi_maximo
  STORAGE   (
    INITIAL     65536
    MINEXTENTS  1
    MAXEXTENTS  2147483645
  )
/


-- End of DDL Script for Index IFRMAXIMO.PRLINE_NDX5

-- Start of DDL Script for Index IFRMAXIMO.PRLINE_NDX6
-- Generated 3/10/2006 17:22:01 from IFRMAXIMO@prodsede2

CREATE INDEX ifrmaximo.prline_ndx6 ON ifrmaximo.prline
  (
    siteid                          ASC,
    rfqlineid                       ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
  TABLESPACE  tsi_maximo
  STORAGE   (
    INITIAL     65536
    MINEXTENTS  1
    MAXEXTENTS  2147483645
  )
/


-- End of DDL Script for Index IFRMAXIMO.PRLINE_NDX6

-- Start of DDL Script for Index IFRMAXIMO.PRLINE_NDX7
-- Generated 3/10/2006 17:22:01 from IFRMAXIMO@prodsede2

CREATE INDEX ifrmaximo.prline_ndx7 ON ifrmaximo.prline
  (
    siteid                          ASC,
    rfqnum                          ASC,
    rfqlinenum                      ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
  TABLESPACE  tsi_maximo
  STORAGE   (
    INITIAL     65536
    MINEXTENTS  1
    MAXEXTENTS  2147483645
  )
/


-- End of DDL Script for Index IFRMAXIMO.PRLINE_NDX7

-- Start of DDL Script for Index IFRMAXIMO.PRLINE_NDX8
-- Generated 3/10/2006 17:22:01 from IFRMAXIMO@prodsede2

CREATE INDEX ifrmaximo.prline_ndx8 ON ifrmaximo.prline
  (
    siteid                          ASC,
    prnum                           ASC,
    prlinenum                       ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
  TABLESPACE  tsi_maximo
  STORAGE   (
    INITIAL     65536
    MINEXTENTS  1
    MAXEXTENTS  2147483645
  )
/


-- End of DDL Script for Index IFRMAXIMO.PRLINE_NDX8

-- Start of DDL Script for Index IFRMAXIMO.PRSTATUS_NDX1
-- Generated 3/10/2006 17:22:02 from IFRMAXIMO@prodsede2

CREATE INDEX ifrmaximo.prstatus_ndx1 ON ifrmaximo.prstatus
  (
    siteid                          ASC,
    prnum                           ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
  TABLESPACE  tsi_maximo
  STORAGE   (
    INITIAL     65536
    MINEXTENTS  1
    MAXEXTENTS  2147483645
  )
/


-- End of DDL Script for Index IFRMAXIMO.PRSTATUS_NDX1

-- Start of DDL Script for Index IFRMAXIMO.PRSTATUS_NDX2
-- Generated 3/10/2006 17:22:02 from IFRMAXIMO@prodsede2

CREATE INDEX ifrmaximo.prstatus_ndx2 ON ifrmaximo.prstatus
  (
    siteid                          ASC,
    changedate                      ASC,
    prnum                           ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
  TABLESPACE  tsi_maximo
  STORAGE   (
    INITIAL     65536
    MINEXTENTS  1
    MAXEXTENTS  2147483645
  )
/


-- End of DDL Script for Index IFRMAXIMO.PRSTATUS_NDX2

-- Start of DDL Script for Index IFRMAXIMO.QUERY_NDX1
-- Generated 3/10/2006 17:22:02 from IFRMAXIMO@prodsede2

CREATE UNIQUE INDEX ifrmaximo.query_ndx1 ON ifrmaximo.query
  (
    siteid                          ASC,
    app                             ASC,
    clausename                      ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
  TABLESPACE  tsi_maximo
  STORAGE   (
    INITIAL     65536
    MINEXTENTS  1
    MAXEXTENTS  2147483645
  )
/


-- End of DDL Script for Index IFRMAXIMO.QUERY_NDX1

-- Start of DDL Script for Index IFRMAXIMO.QUERY_NDX2
-- Generated 3/10/2006 17:22:02 from IFRMAXIMO@prodsede2

CREATE INDEX ifrmaximo.query_ndx2 ON ifrmaximo.query
  (
    siteid                          ASC,
    app                             ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
  TABLESPACE  tsi_maximo
  STORAGE   (
    INITIAL     65536
    MINEXTENTS  1
    MAXEXTENTS  2147483645
  )
/


-- End of DDL Script for Index IFRMAXIMO.QUERY_NDX2

-- Start of DDL Script for Index IFRMAXIMO.QUOTATIONLINE_NDX1
-- Generated 3/10/2006 17:22:02 from IFRMAXIMO@prodsede2

CREATE UNIQUE INDEX ifrmaximo.quotationline_ndx1 ON ifrmaximo.quotationline
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
  TABLESPACE  tsi_maximo
  STORAGE   (
    INITIAL     65536
    MINEXTENTS  1
    MAXEXTENTS  2147483645
  )
/


-- End of DDL Script for Index IFRMAXIMO.QUOTATIONLINE_NDX1

-- Start of DDL Script for Index IFRMAXIMO.RANGEDOMSEG_NDX1
-- Generated 3/10/2006 17:22:02 from IFRMAXIMO@prodsede2

CREATE UNIQUE INDEX ifrmaximo.rangedomseg_ndx1 ON ifrmaximo.rangedomsegment
  (
    domainid                        ASC,
    rangesegment                    ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
  TABLESPACE  tsi_maximo
  STORAGE   (
    INITIAL     40960
    MINEXTENTS  1
    MAXEXTENTS  2147483645
  )
/


-- End of DDL Script for Index IFRMAXIMO.RANGEDOMSEG_NDX1

-- Start of DDL Script for Index IFRMAXIMO.REORDERMUTEX_NDX1
-- Generated 3/10/2006 17:22:03 from IFRMAXIMO@prodsede2

CREATE UNIQUE INDEX ifrmaximo.reordermutex_ndx1 ON ifrmaximo.reordermutex
  (
    siteid                          ASC,
    location                        ASC,
    mrnum                           ASC,
    type                            ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
  TABLESPACE  tsi_maximo
  STORAGE   (
    INITIAL     65536
    MINEXTENTS  1
    MAXEXTENTS  2147483645
  )
/


-- End of DDL Script for Index IFRMAXIMO.REORDERMUTEX_NDX1

-- Start of DDL Script for Index IFRMAXIMO.REORDERPAD_NDX1
-- Generated 3/10/2006 17:22:03 from IFRMAXIMO@prodsede2

CREATE INDEX ifrmaximo.reorderpad_ndx1 ON ifrmaximo.reorderpad
  (
    siteid                          ASC,
    usrname                         ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
  TABLESPACE  tsi_maximo
  STORAGE   (
    INITIAL     65536
    MINEXTENTS  1
    MAXEXTENTS  2147483645
  )
/


-- End of DDL Script for Index IFRMAXIMO.REORDERPAD_NDX1

-- Start of DDL Script for Index IFRMAXIMO.RESTRICTIONS_NDX
-- Generated 3/10/2006 17:22:03 from IFRMAXIMO@prodsede2

CREATE UNIQUE INDEX ifrmaximo.restrictions_ndx ON ifrmaximo.userrestrictions
  (
    username                        ASC,
    app                             ASC,
    module                          ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
  TABLESPACE  tsi_maximo
  STORAGE   (
    INITIAL     65536
    MINEXTENTS  1
    MAXEXTENTS  2147483645
  )
/


-- End of DDL Script for Index IFRMAXIMO.RESTRICTIONS_NDX

-- Start of DDL Script for Index IFRMAXIMO.RFQ_NDX1
-- Generated 3/10/2006 17:22:03 from IFRMAXIMO@prodsede2

CREATE UNIQUE INDEX ifrmaximo.rfq_ndx1 ON ifrmaximo.rfq
  (
    siteid                          ASC,
    rfqnum                          ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
  TABLESPACE  tsi_maximo
  STORAGE   (
    INITIAL     65536
    MINEXTENTS  1
    MAXEXTENTS  2147483645
  )
/


-- End of DDL Script for Index IFRMAXIMO.RFQ_NDX1

-- Start of DDL Script for Index IFRMAXIMO.RFQLINE_NDX1
-- Generated 3/10/2006 17:22:03 from IFRMAXIMO@prodsede2

CREATE UNIQUE INDEX ifrmaximo.rfqline_ndx1 ON ifrmaximo.rfqline
  (
    siteid                          ASC,
    rfqlineid                       ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
  TABLESPACE  tsi_maximo
  STORAGE   (
    INITIAL     65536
    MINEXTENTS  1
    MAXEXTENTS  2147483645
  )
/


-- End of DDL Script for Index IFRMAXIMO.RFQLINE_NDX1

-- Start of DDL Script for Index IFRMAXIMO.RFQLINE_NDX2
-- Generated 3/10/2006 17:22:03 from IFRMAXIMO@prodsede2

CREATE INDEX ifrmaximo.rfqline_ndx2 ON ifrmaximo.rfqline
  (
    siteid                          ASC,
    rfqnum                          ASC,
    rfqlinenum                      ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
  TABLESPACE  tsi_maximo
  STORAGE   (
    INITIAL     65536
    MINEXTENTS  1
    MAXEXTENTS  2147483645
  )
/


-- End of DDL Script for Index IFRMAXIMO.RFQLINE_NDX2

-- Start of DDL Script for Index IFRMAXIMO.RFQLINE_NDX3
-- Generated 3/10/2006 17:22:04 from IFRMAXIMO@prodsede2

CREATE INDEX ifrmaximo.rfqline_ndx3 ON ifrmaximo.rfqline
  (
    siteid                          ASC,
    polineid                        ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
  TABLESPACE  tsi_maximo
  STORAGE   (
    INITIAL     65536
    MINEXTENTS  1
    MAXEXTENTS  2147483645
  )
/


-- End of DDL Script for Index IFRMAXIMO.RFQLINE_NDX3

-- Start of DDL Script for Index IFRMAXIMO.RFQLINE_NDX4
-- Generated 3/10/2006 17:22:04 from IFRMAXIMO@prodsede2

CREATE INDEX ifrmaximo.rfqline_ndx4 ON ifrmaximo.rfqline
  (
    siteid                          ASC,
    ponum                           ASC,
    polinenum                       ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
  TABLESPACE  tsi_maximo
  STORAGE   (
    INITIAL     65536
    MINEXTENTS  1
    MAXEXTENTS  2147483645
  )
/


-- End of DDL Script for Index IFRMAXIMO.RFQLINE_NDX4

-- Start of DDL Script for Index IFRMAXIMO.RFQSTATUS_NDX1
-- Generated 3/10/2006 17:22:04 from IFRMAXIMO@prodsede2

CREATE UNIQUE INDEX ifrmaximo.rfqstatus_ndx1 ON ifrmaximo.rfqstatus
  (
    siteid                          ASC,
    rfqnum                          ASC,
    rfqstatusseq                    ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
  TABLESPACE  tsi_maximo
  STORAGE   (
    INITIAL     65536
    MINEXTENTS  1
    MAXEXTENTS  2147483645
  )
/


-- End of DDL Script for Index IFRMAXIMO.RFQSTATUS_NDX1

-- Start of DDL Script for Index IFRMAXIMO.RFQVENDOR_NDX1
-- Generated 3/10/2006 17:22:04 from IFRMAXIMO@prodsede2

CREATE UNIQUE INDEX ifrmaximo.rfqvendor_ndx1 ON ifrmaximo.rfqvendor
  (
    siteid                          ASC,
    rfqnum                          ASC,
    vendor                          ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
  TABLESPACE  tsi_maximo
  STORAGE   (
    INITIAL     65536
    MINEXTENTS  1
    MAXEXTENTS  2147483645
  )
/


-- End of DDL Script for Index IFRMAXIMO.RFQVENDOR_NDX1

-- Start of DDL Script for Index IFRMAXIMO.ROUTE_STOP_NDX1
-- Generated 3/10/2006 17:22:04 from IFRMAXIMO@prodsede2

CREATE UNIQUE INDEX ifrmaximo.route_stop_ndx1 ON ifrmaximo.route_stop
  (
    siteid                          ASC,
    route                           ASC,
    routestopid                     ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
  TABLESPACE  tsi_maximo
  STORAGE   (
    INITIAL     65536
    MINEXTENTS  1
    MAXEXTENTS  2147483645
  )
/


-- End of DDL Script for Index IFRMAXIMO.ROUTE_STOP_NDX1

-- Start of DDL Script for Index IFRMAXIMO.ROUTE_STOP_NDX2
-- Generated 3/10/2006 17:22:04 from IFRMAXIMO@prodsede2

CREATE INDEX ifrmaximo.route_stop_ndx2 ON ifrmaximo.route_stop
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
  TABLESPACE  tsi_maximo
  STORAGE   (
    INITIAL     65536
    MINEXTENTS  1
    MAXEXTENTS  2147483645
  )
/


-- End of DDL Script for Index IFRMAXIMO.ROUTE_STOP_NDX2

-- Start of DDL Script for Index IFRMAXIMO.ROUTE_STOP_NDX3
-- Generated 3/10/2006 17:22:05 from IFRMAXIMO@prodsede2

CREATE INDEX ifrmaximo.route_stop_ndx3 ON ifrmaximo.route_stop
  (
    siteid                          ASC,
    eqnum                           ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
  TABLESPACE  tsi_maximo
  STORAGE   (
    INITIAL     65536
    MINEXTENTS  1
    MAXEXTENTS  2147483645
  )
/


-- End of DDL Script for Index IFRMAXIMO.ROUTE_STOP_NDX3

-- Start of DDL Script for Index IFRMAXIMO.ROUTE_STOP_NDX4
-- Generated 3/10/2006 17:22:05 from IFRMAXIMO@prodsede2

CREATE INDEX ifrmaximo.route_stop_ndx4 ON ifrmaximo.route_stop
  (
    siteid                          ASC,
    location                        ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
  TABLESPACE  tsi_maximo
  STORAGE   (
    INITIAL     65536
    MINEXTENTS  1
    MAXEXTENTS  2147483645
  )
/


-- End of DDL Script for Index IFRMAXIMO.ROUTE_STOP_NDX4

-- Start of DDL Script for Index IFRMAXIMO.ROUTES_NDX1
-- Generated 3/10/2006 17:22:05 from IFRMAXIMO@prodsede2

CREATE UNIQUE INDEX ifrmaximo.routes_ndx1 ON ifrmaximo.routes
  (
    siteid                          ASC,
    route                           ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
  TABLESPACE  tsi_maximo
  STORAGE   (
    INITIAL     65536
    MINEXTENTS  1
    MAXEXTENTS  2147483645
  )
/


-- End of DDL Script for Index IFRMAXIMO.ROUTES_NDX1

-- Start of DDL Script for Index IFRMAXIMO.SAFETYLEXICON_NDX1
-- Generated 3/10/2006 17:22:05 from IFRMAXIMO@prodsede2

CREATE UNIQUE INDEX ifrmaximo.safetylexicon_ndx1 ON ifrmaximo.safetylexicon
  (
    siteid                          ASC,
    safetylexiconid                 ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
  TABLESPACE  tsi_maximo
  STORAGE   (
    INITIAL     65536
    MINEXTENTS  1
    MAXEXTENTS  2147483645
  )
/


-- End of DDL Script for Index IFRMAXIMO.SAFETYLEXICON_NDX1

-- Start of DDL Script for Index IFRMAXIMO.SAFETYLEXICON_NDX2
-- Generated 3/10/2006 17:22:05 from IFRMAXIMO@prodsede2

CREATE INDEX ifrmaximo.safetylexicon_ndx2 ON ifrmaximo.safetylexicon
  (
    siteid                          ASC,
    location                        ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
  TABLESPACE  tsi_maximo
  STORAGE   (
    INITIAL     65536
    MINEXTENTS  1
    MAXEXTENTS  2147483645
  )
/


-- End of DDL Script for Index IFRMAXIMO.SAFETYLEXICON_NDX2

-- Start of DDL Script for Index IFRMAXIMO.SAFETYLEXICON_NDX3
-- Generated 3/10/2006 17:22:05 from IFRMAXIMO@prodsede2

CREATE INDEX ifrmaximo.safetylexicon_ndx3 ON ifrmaximo.safetylexicon
  (
    siteid                          ASC,
    eqnum                           ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
  TABLESPACE  tsi_maximo
  STORAGE   (
    INITIAL     65536
    MINEXTENTS  1
    MAXEXTENTS  2147483645
  )
/


-- End of DDL Script for Index IFRMAXIMO.SAFETYLEXICON_NDX3

-- Start of DDL Script for Index IFRMAXIMO.SAFETYLEXICON_NDX4
-- Generated 3/10/2006 17:22:06 from IFRMAXIMO@prodsede2

CREATE INDEX ifrmaximo.safetylexicon_ndx4 ON ifrmaximo.safetylexicon
  (
    siteid                          ASC,
    hazardid                        ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
  TABLESPACE  tsi_maximo
  STORAGE   (
    INITIAL     65536
    MINEXTENTS  1
    MAXEXTENTS  2147483645
  )
/


-- End of DDL Script for Index IFRMAXIMO.SAFETYLEXICON_NDX4

-- Start of DDL Script for Index IFRMAXIMO.SAFETYLEXICON_NDX5
-- Generated 3/10/2006 17:22:06 from IFRMAXIMO@prodsede2

CREATE INDEX ifrmaximo.safetylexicon_ndx5 ON ifrmaximo.safetylexicon
  (
    siteid                          ASC,
    tagoutid                        ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
  TABLESPACE  tsi_maximo
  STORAGE   (
    INITIAL     65536
    MINEXTENTS  1
    MAXEXTENTS  2147483645
  )
/


-- End of DDL Script for Index IFRMAXIMO.SAFETYLEXICON_NDX5

-- Start of DDL Script for Index IFRMAXIMO.SAFETYPLAN_NDX1
-- Generated 3/10/2006 17:22:06 from IFRMAXIMO@prodsede2

CREATE UNIQUE INDEX ifrmaximo.safetyplan_ndx1 ON ifrmaximo.safetyplan
  (
    siteid                          ASC,
    safetyplanid                    ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
  TABLESPACE  tsi_maximo
  STORAGE   (
    INITIAL     65536
    MINEXTENTS  1
    MAXEXTENTS  2147483645
  )
/


-- End of DDL Script for Index IFRMAXIMO.SAFETYPLAN_NDX1

-- Start of DDL Script for Index IFRMAXIMO.SCHARGES_NDX1
-- Generated 3/10/2006 17:22:06 from IFRMAXIMO@prodsede2

CREATE UNIQUE INDEX ifrmaximo.scharges_ndx1 ON ifrmaximo.scharges
  (
    orgid                           ASC,
    schargecode                     ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
  TABLESPACE  tsi_maximo
  STORAGE   (
    INITIAL     65536
    MINEXTENTS  1
    MAXEXTENTS  2147483645
  )
/


-- End of DDL Script for Index IFRMAXIMO.SCHARGES_NDX1

-- Start of DDL Script for Index IFRMAXIMO.SERVCONT_NDX1
-- Generated 3/10/2006 17:22:06 from IFRMAXIMO@prodsede2

CREATE UNIQUE INDEX ifrmaximo.servcont_ndx1 ON ifrmaximo.servicecontract
  (
    siteid                          ASC,
    contract                        ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
  TABLESPACE  tsi_maximo
  STORAGE   (
    INITIAL     65536
    MINEXTENTS  1
    MAXEXTENTS  2147483645
  )
/


-- End of DDL Script for Index IFRMAXIMO.SERVCONT_NDX1

-- Start of DDL Script for Index IFRMAXIMO.SERVCONT_NDX2
-- Generated 3/10/2006 17:22:06 from IFRMAXIMO@prodsede2

CREATE INDEX ifrmaximo.servcont_ndx2 ON ifrmaximo.servicecontract
  (
    siteid                          ASC,
    vendor                          ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
  TABLESPACE  tsi_maximo
  STORAGE   (
    INITIAL     65536
    MINEXTENTS  1
    MAXEXTENTS  2147483645
  )
/


-- End of DDL Script for Index IFRMAXIMO.SERVCONT_NDX2

-- Start of DDL Script for Index IFRMAXIMO.SERVCONT_NDX3
-- Generated 3/10/2006 17:22:07 from IFRMAXIMO@prodsede2

CREATE INDEX ifrmaximo.servcont_ndx3 ON ifrmaximo.servicecontract
  (
    siteid                          ASC,
    vendorscontractnum              ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
  TABLESPACE  tsi_maximo
  STORAGE   (
    INITIAL     65536
    MINEXTENTS  1
    MAXEXTENTS  2147483645
  )
/


-- End of DDL Script for Index IFRMAXIMO.SERVCONT_NDX3

-- Start of DDL Script for Index IFRMAXIMO.SERVCONT_NDX4
-- Generated 3/10/2006 17:22:07 from IFRMAXIMO@prodsede2

CREATE INDEX ifrmaximo.servcont_ndx4 ON ifrmaximo.servicecontract
  (
    siteid                          ASC,
    eqnum                           ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
  TABLESPACE  tsi_maximo
  STORAGE   (
    INITIAL     65536
    MINEXTENTS  1
    MAXEXTENTS  2147483645
  )
/


-- End of DDL Script for Index IFRMAXIMO.SERVCONT_NDX4

-- Start of DDL Script for Index IFRMAXIMO.SERVRECTRANS_NDX1
-- Generated 3/10/2006 17:22:07 from IFRMAXIMO@prodsede2

CREATE UNIQUE INDEX ifrmaximo.servrectrans_ndx1 ON ifrmaximo.servrectrans
  (
    siteid                          ASC,
    servrectransid                  ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
  TABLESPACE  tsi_maximo
  STORAGE   (
    INITIAL     65536
    MINEXTENTS  1
    MAXEXTENTS  2147483645
  )
/


-- End of DDL Script for Index IFRMAXIMO.SERVRECTRANS_NDX1

-- Start of DDL Script for Index IFRMAXIMO.SERVRECTRANS_NDX2
-- Generated 3/10/2006 17:22:07 from IFRMAXIMO@prodsede2

CREATE INDEX ifrmaximo.servrectrans_ndx2 ON ifrmaximo.servrectrans
  (
    siteid                          ASC,
    ponum                           ASC,
    polinenum                       ASC,
    transdate                       ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
  TABLESPACE  tsi_maximo
  STORAGE   (
    INITIAL     65536
    MINEXTENTS  1
    MAXEXTENTS  2147483645
  )
/


-- End of DDL Script for Index IFRMAXIMO.SERVRECTRANS_NDX2

-- Start of DDL Script for Index IFRMAXIMO.SERVRECTRANS_NDX3
-- Generated 3/10/2006 17:22:07 from IFRMAXIMO@prodsede2

CREATE INDEX ifrmaximo.servrectrans_ndx3 ON ifrmaximo.servrectrans
  (
    siteid                          ASC,
    interid                         ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
  TABLESPACE  tsi_maximo
  STORAGE   (
    INITIAL     65536
    MINEXTENTS  1
    MAXEXTENTS  2147483645
  )
/


-- End of DDL Script for Index IFRMAXIMO.SERVRECTRANS_NDX3

-- Start of DDL Script for Index IFRMAXIMO.SHIFT_NDX1
-- Generated 3/10/2006 17:22:07 from IFRMAXIMO@prodsede2

CREATE UNIQUE INDEX ifrmaximo.shift_ndx1 ON ifrmaximo.shift
  (
    orgid                           ASC,
    shiftnum                        ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
  TABLESPACE  tsi_maximo
  STORAGE   (
    INITIAL     65536
    MINEXTENTS  1
    MAXEXTENTS  2147483645
  )
/


-- End of DDL Script for Index IFRMAXIMO.SHIFT_NDX1

-- Start of DDL Script for Index IFRMAXIMO.SHIFTPATDAY_NDX1
-- Generated 3/10/2006 17:22:08 from IFRMAXIMO@prodsede2

CREATE UNIQUE INDEX ifrmaximo.shiftpatday_ndx1 ON ifrmaximo.shiftpatternday
  (
    orgid                           ASC,
    shiftnum                        ASC,
    patterndayseq                   ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
  TABLESPACE  tsi_maximo
  STORAGE   (
    INITIAL     65536
    MINEXTENTS  1
    MAXEXTENTS  2147483645
  )
/


-- End of DDL Script for Index IFRMAXIMO.SHIFTPATDAY_NDX1

-- Start of DDL Script for Index IFRMAXIMO.SHIPMENT_NDX1
-- Generated 3/10/2006 17:22:08 from IFRMAXIMO@prodsede2

CREATE UNIQUE INDEX ifrmaximo.shipment_ndx1 ON ifrmaximo.shipment
  (
    siteid                          ASC,
    shipmentid                      ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
  TABLESPACE  tsi_maximo
  STORAGE   (
    INITIAL     65536
    MINEXTENTS  1
    MAXEXTENTS  2147483645
  )
/


-- End of DDL Script for Index IFRMAXIMO.SHIPMENT_NDX1

-- Start of DDL Script for Index IFRMAXIMO.SHIPMENTLINE_NDX1
-- Generated 3/10/2006 17:22:08 from IFRMAXIMO@prodsede2

CREATE UNIQUE INDEX ifrmaximo.shipmentline_ndx1 ON ifrmaximo.shipmentline
  (
    siteid                          ASC,
    shipmentid                      ASC,
    shipmentlineid                  ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
  TABLESPACE  tsi_maximo
  STORAGE   (
    INITIAL     65536
    MINEXTENTS  1
    MAXEXTENTS  2147483645
  )
/


-- End of DDL Script for Index IFRMAXIMO.SHIPMENTLINE_NDX1

-- Start of DDL Script for Index IFRMAXIMO.SIGOPTION_NDX
-- Generated 3/10/2006 17:22:08 from IFRMAXIMO@prodsede2

CREATE UNIQUE INDEX ifrmaximo.sigoption_ndx ON ifrmaximo.sigoption
  (
    app                             ASC,
    optionname                      ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
  TABLESPACE  tsi_maximo
  STORAGE   (
    INITIAL     65536
    MINEXTENTS  1
    MAXEXTENTS  2147483645
  )
/


-- End of DDL Script for Index IFRMAXIMO.SIGOPTION_NDX

-- Start of DDL Script for Index IFRMAXIMO.SITE_NDX1
-- Generated 3/10/2006 17:22:08 from IFRMAXIMO@prodsede2

CREATE UNIQUE INDEX ifrmaximo.site_ndx1 ON ifrmaximo.site
  (
    siteid                          ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
  TABLESPACE  tsi_maximo
  STORAGE   (
    INITIAL     65536
    MINEXTENTS  1
    MAXEXTENTS  2147483645
  )
/


-- End of DDL Script for Index IFRMAXIMO.SITE_NDX1

-- Start of DDL Script for Index IFRMAXIMO.SITEECOM_NDX1
-- Generated 3/10/2006 17:22:08 from IFRMAXIMO@prodsede2

CREATE UNIQUE INDEX ifrmaximo.siteecom_ndx1 ON ifrmaximo.siteecom
  (
    siteid                          ASC,
    orgid                           ASC,
    vendor                          ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
  TABLESPACE  tsi_maximo
  STORAGE   (
    INITIAL     65536
    MINEXTENTS  1
    MAXEXTENTS  2147483645
  )
/


-- End of DDL Script for Index IFRMAXIMO.SITEECOM_NDX1

-- Start of DDL Script for Index IFRMAXIMO.SITERESTR_NDX1
-- Generated 3/10/2006 17:22:08 from IFRMAXIMO@prodsede2

CREATE UNIQUE INDEX ifrmaximo.siterestr_ndx1 ON ifrmaximo.siterestriction
  (
    siteid                          ASC,
    tbname                          ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
  TABLESPACE  tsi_maximo
  STORAGE   (
    INITIAL     65536
    MINEXTENTS  1
    MAXEXTENTS  2147483645
  )
/


-- End of DDL Script for Index IFRMAXIMO.SITERESTR_NDX1

-- Start of DDL Script for Index IFRMAXIMO.SITEUSER_NDX1
-- Generated 3/10/2006 17:22:09 from IFRMAXIMO@prodsede2

CREATE UNIQUE INDEX ifrmaximo.siteuser_ndx1 ON ifrmaximo.siteuser
  (
    siteid                          ASC,
    username                        ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
  TABLESPACE  tsi_maximo
  STORAGE   (
    INITIAL     65536
    MINEXTENTS  1
    MAXEXTENTS  2147483645
  )
/


-- End of DDL Script for Index IFRMAXIMO.SITEUSER_NDX1

-- Start of DDL Script for Index IFRMAXIMO.SITEUSER_NDX2
-- Generated 3/10/2006 17:22:09 from IFRMAXIMO@prodsede2

CREATE INDEX ifrmaximo.siteuser_ndx2 ON ifrmaximo.siteuser
  (
    username                        ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
  TABLESPACE  tsi_maximo
  STORAGE   (
    INITIAL     65536
    MINEXTENTS  1
    MAXEXTENTS  2147483645
  )
/


-- End of DDL Script for Index IFRMAXIMO.SITEUSER_NDX2

-- Start of DDL Script for Index IFRMAXIMO.SPAREPART_NDX1
-- Generated 3/10/2006 17:22:09 from IFRMAXIMO@prodsede2

CREATE INDEX ifrmaximo.sparepart_ndx1 ON ifrmaximo.sparepart
  (
    siteid                          ASC,
    eqnum                           ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
  TABLESPACE  tsi_maximo
  STORAGE   (
    INITIAL     65536
    MINEXTENTS  1
    MAXEXTENTS  2147483645
  )
/


-- End of DDL Script for Index IFRMAXIMO.SPAREPART_NDX1

-- Start of DDL Script for Index IFRMAXIMO.SPAREPART_NDX2
-- Generated 3/10/2006 17:22:09 from IFRMAXIMO@prodsede2

CREATE INDEX ifrmaximo.sparepart_ndx2 ON ifrmaximo.sparepart
  (
    siteid                          ASC,
    itemnum                         ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
  TABLESPACE  tsi_maximo
  STORAGE   (
    INITIAL     65536
    MINEXTENTS  1
    MAXEXTENTS  2147483645
  )
/


-- End of DDL Script for Index IFRMAXIMO.SPAREPART_NDX2

-- Start of DDL Script for Index IFRMAXIMO.SPLEXICONLINK_NDX1
-- Generated 3/10/2006 17:22:09 from IFRMAXIMO@prodsede2

CREATE UNIQUE INDEX ifrmaximo.splexiconlink_ndx1 ON ifrmaximo.splexiconlink
  (
    siteid                          ASC,
    spworkassetid                   ASC,
    safetylexiconid                 ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
  TABLESPACE  tsi_maximo
  STORAGE   (
    INITIAL     65536
    MINEXTENTS  1
    MAXEXTENTS  2147483645
  )
/


-- End of DDL Script for Index IFRMAXIMO.SPLEXICONLINK_NDX1

-- Start of DDL Script for Index IFRMAXIMO.SPLEXICONLINK_NDX2
-- Generated 3/10/2006 17:22:09 from IFRMAXIMO@prodsede2

CREATE INDEX ifrmaximo.splexiconlink_ndx2 ON ifrmaximo.splexiconlink
  (
    siteid                          ASC,
    spworkassetid                   ASC,
    applyseq                        ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
  TABLESPACE  tsi_maximo
  STORAGE   (
    INITIAL     65536
    MINEXTENTS  1
    MAXEXTENTS  2147483645
  )
/


-- End of DDL Script for Index IFRMAXIMO.SPLEXICONLINK_NDX2

-- Start of DDL Script for Index IFRMAXIMO.SPWORKASSET_NDX1
-- Generated 3/10/2006 17:22:10 from IFRMAXIMO@prodsede2

CREATE UNIQUE INDEX ifrmaximo.spworkasset_ndx1 ON ifrmaximo.spworkasset
  (
    siteid                          ASC,
    spworkassetid                   ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
  TABLESPACE  tsi_maximo
  STORAGE   (
    INITIAL     65536
    MINEXTENTS  1
    MAXEXTENTS  2147483645
  )
/


-- End of DDL Script for Index IFRMAXIMO.SPWORKASSET_NDX1

-- Start of DDL Script for Index IFRMAXIMO.SPWORKASSET_NDX2
-- Generated 3/10/2006 17:22:10 from IFRMAXIMO@prodsede2

CREATE INDEX ifrmaximo.spworkasset_ndx2 ON ifrmaximo.spworkasset
  (
    siteid                          ASC,
    worklocation                    ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
  TABLESPACE  tsi_maximo
  STORAGE   (
    INITIAL     65536
    MINEXTENTS  1
    MAXEXTENTS  2147483645
  )
/


-- End of DDL Script for Index IFRMAXIMO.SPWORKASSET_NDX2

-- Start of DDL Script for Index IFRMAXIMO.SPWORKASSET_NDX3
-- Generated 3/10/2006 17:22:10 from IFRMAXIMO@prodsede2

CREATE INDEX ifrmaximo.spworkasset_ndx3 ON ifrmaximo.spworkasset
  (
    siteid                          ASC,
    workequipment                   ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
  TABLESPACE  tsi_maximo
  STORAGE   (
    INITIAL     65536
    MINEXTENTS  1
    MAXEXTENTS  2147483645
  )
/


-- End of DDL Script for Index IFRMAXIMO.SPWORKASSET_NDX3

-- Start of DDL Script for Index IFRMAXIMO.SPWORKASSET_NDX4
-- Generated 3/10/2006 17:22:10 from IFRMAXIMO@prodsede2

CREATE INDEX ifrmaximo.spworkasset_ndx4 ON ifrmaximo.spworkasset
  (
    siteid                          ASC,
    safetyplanid                    ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
  TABLESPACE  tsi_maximo
  STORAGE   (
    INITIAL     65536
    MINEXTENTS  1
    MAXEXTENTS  2147483645
  )
/


-- End of DDL Script for Index IFRMAXIMO.SPWORKASSET_NDX4

-- Start of DDL Script for Index IFRMAXIMO.SRELATEDASSET_NDX1
-- Generated 3/10/2006 17:22:10 from IFRMAXIMO@prodsede2

CREATE UNIQUE INDEX ifrmaximo.srelatedasset_ndx1 ON ifrmaximo.sprelatedasset
  (
    siteid                          ASC,
    sprelatedassetid                ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
  TABLESPACE  tsi_maximo
  STORAGE   (
    INITIAL     65536
    MINEXTENTS  1
    MAXEXTENTS  2147483645
  )
/


-- End of DDL Script for Index IFRMAXIMO.SRELATEDASSET_NDX1

-- Start of DDL Script for Index IFRMAXIMO.SRELATEDASSET_NDX2
-- Generated 3/10/2006 17:22:10 from IFRMAXIMO@prodsede2

CREATE INDEX ifrmaximo.srelatedasset_ndx2 ON ifrmaximo.sprelatedasset
  (
    siteid                          ASC,
    location                        ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
  TABLESPACE  tsi_maximo
  STORAGE   (
    INITIAL     65536
    MINEXTENTS  1
    MAXEXTENTS  2147483645
  )
/


-- End of DDL Script for Index IFRMAXIMO.SRELATEDASSET_NDX2

-- Start of DDL Script for Index IFRMAXIMO.SRELATEDASSET_NDX3
-- Generated 3/10/2006 17:22:11 from IFRMAXIMO@prodsede2

CREATE INDEX ifrmaximo.srelatedasset_ndx3 ON ifrmaximo.sprelatedasset
  (
    siteid                          ASC,
    eqnum                           ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
  TABLESPACE  tsi_maximo
  STORAGE   (
    INITIAL     65536
    MINEXTENTS  1
    MAXEXTENTS  2147483645
  )
/


-- End of DDL Script for Index IFRMAXIMO.SRELATEDASSET_NDX3

-- Start of DDL Script for Index IFRMAXIMO.STARTCENTER_NDX1
-- Generated 3/10/2006 17:22:11 from IFRMAXIMO@prodsede2

CREATE UNIQUE INDEX ifrmaximo.startcenter_ndx1 ON ifrmaximo.startcenter
  (
    startcenterid                   ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
  TABLESPACE  tsi_maximo
  STORAGE   (
    INITIAL     65536
    MINEXTENTS  1
    MAXEXTENTS  2147483645
  )
/


-- End of DDL Script for Index IFRMAXIMO.STARTCENTER_NDX1

-- Start of DDL Script for Index IFRMAXIMO.SYS_C0013249
-- Generated 3/10/2006 17:22:11 from IFRMAXIMO@prodsede2

CREATE UNIQUE INDEX ifrmaximo.sys_c0013249 ON ifrmaximo.dependencia
  (
    aeroporto                       ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
  TABLESPACE  tsi_maximo
  STORAGE   (
    INITIAL     40960
    MINEXTENTS  1
    MAXEXTENTS  2147483645
  )
/


-- End of DDL Script for Index IFRMAXIMO.SYS_C0013249

-- Start of DDL Script for Index IFRMAXIMO.SYS_C0014500
-- Generated 3/10/2006 17:22:11 from IFRMAXIMO@prodsede2

CREATE UNIQUE INDEX ifrmaximo.sys_c0014500 ON ifrmaximo.usuario
  (
    usernum                         ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
  TABLESPACE  tsi_maximo
  STORAGE   (
    INITIAL     40960
    MINEXTENTS  1
    MAXEXTENTS  2147483645
  )
/


-- End of DDL Script for Index IFRMAXIMO.SYS_C0014500

-- Start of DDL Script for Index IFRMAXIMO.TAB_INDISPONIBILIDADE_NDX1
-- Generated 3/10/2006 17:22:11 from IFRMAXIMO@prodsede2

CREATE INDEX ifrmaximo.tab_indisponibilidade_ndx1 ON ifrmaximo.tab_indisponibilidade
  (
    wo_wonum                        ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
  TABLESPACE  tsi_maximo
  STORAGE   (
    INITIAL     65536
    MINEXTENTS  1
    MAXEXTENTS  2147483645
  )
/


-- End of DDL Script for Index IFRMAXIMO.TAB_INDISPONIBILIDADE_NDX1

-- Start of DDL Script for Index IFRMAXIMO.TAB_WORATEIO_NDX1
-- Generated 3/10/2006 17:22:11 from IFRMAXIMO@prodsede2

CREATE UNIQUE INDEX ifrmaximo.tab_worateio_ndx1 ON ifrmaximo.tab_worateio
  (
    ratnum                          ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
  TABLESPACE  tsi_maximo
  STORAGE   (
    INITIAL     65536
    MINEXTENTS  1
    MAXEXTENTS  2147483645
  )
/


-- End of DDL Script for Index IFRMAXIMO.TAB_WORATEIO_NDX1

-- Start of DDL Script for Index IFRMAXIMO.TAGLOCK_NDX1
-- Generated 3/10/2006 17:22:12 from IFRMAXIMO@prodsede2

CREATE UNIQUE INDEX ifrmaximo.taglock_ndx1 ON ifrmaximo.taglock
  (
    siteid                          ASC,
    taglockid                       ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
  TABLESPACE  tsi_maximo
  STORAGE   (
    INITIAL     65536
    MINEXTENTS  1
    MAXEXTENTS  2147483645
  )
/


-- End of DDL Script for Index IFRMAXIMO.TAGLOCK_NDX1

-- Start of DDL Script for Index IFRMAXIMO.TAGLOCK_NDX2
-- Generated 3/10/2006 17:22:12 from IFRMAXIMO@prodsede2

CREATE INDEX ifrmaximo.taglock_ndx2 ON ifrmaximo.taglock
  (
    siteid                          ASC,
    tagoutid                        ASC,
    lockoutid                       ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
  TABLESPACE  tsi_maximo
  STORAGE   (
    INITIAL     65536
    MINEXTENTS  1
    MAXEXTENTS  2147483645
  )
/


-- End of DDL Script for Index IFRMAXIMO.TAGLOCK_NDX2

-- Start of DDL Script for Index IFRMAXIMO.TAGLOCK_NDX3
-- Generated 3/10/2006 17:22:12 from IFRMAXIMO@prodsede2

CREATE INDEX ifrmaximo.taglock_ndx3 ON ifrmaximo.taglock
  (
    siteid                          ASC,
    tagoutid                        ASC,
    applyseq                        ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
  TABLESPACE  tsi_maximo
  STORAGE   (
    INITIAL     65536
    MINEXTENTS  1
    MAXEXTENTS  2147483645
  )
/


-- End of DDL Script for Index IFRMAXIMO.TAGLOCK_NDX3

-- Start of DDL Script for Index IFRMAXIMO.TAGOUT_NDX1
-- Generated 3/10/2006 17:22:12 from IFRMAXIMO@prodsede2

CREATE UNIQUE INDEX ifrmaximo.tagout_ndx1 ON ifrmaximo.tagout
  (
    siteid                          ASC,
    tagoutid                        ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
  TABLESPACE  tsi_maximo
  STORAGE   (
    INITIAL     65536
    MINEXTENTS  1
    MAXEXTENTS  2147483645
  )
/


-- End of DDL Script for Index IFRMAXIMO.TAGOUT_NDX1

-- Start of DDL Script for Index IFRMAXIMO.TAX_NDX1
-- Generated 3/10/2006 17:22:12 from IFRMAXIMO@prodsede2

CREATE UNIQUE INDEX ifrmaximo.tax_ndx1 ON ifrmaximo.tax
  (
    orgid                           ASC,
    typecode                        ASC,
    taxcode                         ASC,
    effective                       ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
  TABLESPACE  tsi_maximo
  STORAGE   (
    INITIAL     65536
    MINEXTENTS  1
    MAXEXTENTS  2147483645
  )
/


-- End of DDL Script for Index IFRMAXIMO.TAX_NDX1

-- Start of DDL Script for Index IFRMAXIMO.TAX_NDX2
-- Generated 3/10/2006 17:22:12 from IFRMAXIMO@prodsede2

CREATE INDEX ifrmaximo.tax_ndx2 ON ifrmaximo.tax
  (
    orgid                           ASC,
    taxcode                         ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
  TABLESPACE  tsi_maximo
  STORAGE   (
    INITIAL     65536
    MINEXTENTS  1
    MAXEXTENTS  2147483645
  )
/


-- End of DDL Script for Index IFRMAXIMO.TAX_NDX2

-- Start of DDL Script for Index IFRMAXIMO.TAXTYPE_NDX
-- Generated 3/10/2006 17:22:13 from IFRMAXIMO@prodsede2

CREATE UNIQUE INDEX ifrmaximo.taxtype_ndx ON ifrmaximo.taxtype
  (
    orgid                           ASC,
    typecode                        ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
  TABLESPACE  tsi_maximo
  STORAGE   (
    INITIAL     65536
    MINEXTENTS  1
    MAXEXTENTS  2147483645
  )
/


-- End of DDL Script for Index IFRMAXIMO.TAXTYPE_NDX

-- Start of DDL Script for Index IFRMAXIMO.TOLERANCE_NDX1
-- Generated 3/10/2006 17:22:13 from IFRMAXIMO@prodsede2

CREATE UNIQUE INDEX ifrmaximo.tolerance_ndx1 ON ifrmaximo.tolerance
  (
    orgid                           ASC,
    grpname                         ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
  TABLESPACE  tsi_maximo
  STORAGE   (
    INITIAL     65536
    MINEXTENTS  1
    MAXEXTENTS  2147483645
  )
/


-- End of DDL Script for Index IFRMAXIMO.TOLERANCE_NDX1

-- Start of DDL Script for Index IFRMAXIMO.TOOL_NDX1
-- Generated 3/10/2006 17:22:13 from IFRMAXIMO@prodsede2

CREATE UNIQUE INDEX ifrmaximo.tool_ndx1 ON ifrmaximo.tool
  (
    orgid                           ASC,
    toolnum                         ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
  TABLESPACE  tsi_maximo
  STORAGE   (
    INITIAL     65536
    MINEXTENTS  1
    MAXEXTENTS  2147483645
  )
/


-- End of DDL Script for Index IFRMAXIMO.TOOL_NDX1

-- Start of DDL Script for Index IFRMAXIMO.TOOL_NDX2
-- Generated 3/10/2006 17:22:13 from IFRMAXIMO@prodsede2

CREATE INDEX ifrmaximo.tool_ndx2 ON ifrmaximo.tool
  (
    orgid                           ASC,
    vendor                          ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
  TABLESPACE  tsi_maximo
  STORAGE   (
    INITIAL     65536
    MINEXTENTS  1
    MAXEXTENTS  2147483645
  )
/


-- End of DDL Script for Index IFRMAXIMO.TOOL_NDX2

-- Start of DDL Script for Index IFRMAXIMO.TOOLTRANS_NDX1
-- Generated 3/10/2006 17:22:13 from IFRMAXIMO@prodsede2

CREATE INDEX ifrmaximo.tooltrans_ndx1 ON ifrmaximo.tooltrans
  (
    orgid                           ASC,
    toolnum                         ASC,
    transdate                       ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
  TABLESPACE  tsi_maximo
  STORAGE   (
    INITIAL     65536
    MINEXTENTS  1
    MAXEXTENTS  2147483645
  )
/


-- End of DDL Script for Index IFRMAXIMO.TOOLTRANS_NDX1

-- Start of DDL Script for Index IFRMAXIMO.TOOLTRANS_NDX2
-- Generated 3/10/2006 17:22:13 from IFRMAXIMO@prodsede2

CREATE INDEX ifrmaximo.tooltrans_ndx2 ON ifrmaximo.tooltrans
  (
    orgid                           ASC,
    refwo                           ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
  TABLESPACE  tsi_maximo
  STORAGE   (
    INITIAL     65536
    MINEXTENTS  1
    MAXEXTENTS  2147483645
  )
/


-- End of DDL Script for Index IFRMAXIMO.TOOLTRANS_NDX2

-- Start of DDL Script for Index IFRMAXIMO.TOOLTRANS_NDX3
-- Generated 3/10/2006 17:22:14 from IFRMAXIMO@prodsede2

CREATE INDEX ifrmaximo.tooltrans_ndx3 ON ifrmaximo.tooltrans
  (
    orgid                           ASC,
    eqnum                           ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
  TABLESPACE  tsi_maximo
  STORAGE   (
    INITIAL     65536
    MINEXTENTS  1
    MAXEXTENTS  2147483645
  )
/


-- End of DDL Script for Index IFRMAXIMO.TOOLTRANS_NDX3

-- Start of DDL Script for Index IFRMAXIMO.TOOLTRANS_NDX4
-- Generated 3/10/2006 17:22:14 from IFRMAXIMO@prodsede2

CREATE INDEX ifrmaximo.tooltrans_ndx4 ON ifrmaximo.tooltrans
  (
    orgid                           ASC,
    enterdate                       ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
  TABLESPACE  tsi_maximo
  STORAGE   (
    INITIAL     65536
    MINEXTENTS  1
    MAXEXTENTS  2147483645
  )
/


-- End of DDL Script for Index IFRMAXIMO.TOOLTRANS_NDX4

-- Start of DDL Script for Index IFRMAXIMO.TOOLTRANS_NDX5
-- Generated 3/10/2006 17:22:14 from IFRMAXIMO@prodsede2

CREATE INDEX ifrmaximo.tooltrans_ndx5 ON ifrmaximo.tooltrans
  (
    orgid                           ASC,
    interid                         ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
  TABLESPACE  tsi_maximo
  STORAGE   (
    INITIAL     65536
    MINEXTENTS  1
    MAXEXTENTS  2147483645
  )
/


-- End of DDL Script for Index IFRMAXIMO.TOOLTRANS_NDX5

-- Start of DDL Script for Index IFRMAXIMO.TRANS_NDX1
-- Generated 3/10/2006 17:22:14 from IFRMAXIMO@prodsede2

CREATE UNIQUE INDEX ifrmaximo.trans_ndx1 ON ifrmaximo.translation
  (
    tbname                          ASC,
    name                            ASC,
    langcode                        ASC,
    ldkey                           ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
  TABLESPACE  tsi_maximo
  STORAGE   (
    INITIAL     65536
    MINEXTENTS  1
    MAXEXTENTS  2147483645
  )
/


-- End of DDL Script for Index IFRMAXIMO.TRANS_NDX1

-- Start of DDL Script for Index IFRMAXIMO.TWA_PK
-- Generated 3/10/2006 17:22:14 from IFRMAXIMO@prodsede2

CREATE INDEX ifrmaximo.twa_pk ON ifrmaximo.tab_wo_amatl
  (
    num_wo_amatl                    ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
  TABLESPACE  tsi_maximo
  STORAGE   (
    INITIAL     65536
    MINEXTENTS  1
    MAXEXTENTS  2147483645
  )
/


-- End of DDL Script for Index IFRMAXIMO.TWA_PK

-- Start of DDL Script for Index IFRMAXIMO.USERGROUPAUTH_NDX1
-- Generated 3/10/2006 17:22:14 from IFRMAXIMO@prodsede2

CREATE UNIQUE INDEX ifrmaximo.usergroupauth_ndx1 ON ifrmaximo.usergroupauth
  (
    username                        ASC,
    grpname                         ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
  TABLESPACE  tsi_maximo
  STORAGE   (
    INITIAL     65536
    MINEXTENTS  1
    MAXEXTENTS  2147483645
  )
/


-- End of DDL Script for Index IFRMAXIMO.USERGROUPAUTH_NDX1

-- Start of DDL Script for Index IFRMAXIMO.USERPREF_NDX
-- Generated 3/10/2006 17:22:15 from IFRMAXIMO@prodsede2

CREATE UNIQUE INDEX ifrmaximo.userpref_ndx ON ifrmaximo.userpref
  (
    username                        ASC,
    varname                         ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
  TABLESPACE  tsi_maximo
  STORAGE   (
    INITIAL     65536
    MINEXTENTS  1
    MAXEXTENTS  2147483645
  )
/


-- End of DDL Script for Index IFRMAXIMO.USERPREF_NDX

-- Start of DDL Script for Index IFRMAXIMO.USERRESTRCT_NDX2
-- Generated 3/10/2006 17:22:15 from IFRMAXIMO@prodsede2

CREATE INDEX ifrmaximo.userrestrct_ndx2 ON ifrmaximo.userrestrictions
  (
    app                             ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
  TABLESPACE  tsi_maximo
  STORAGE   (
    INITIAL     65536
    MINEXTENTS  1
    MAXEXTENTS  2147483645
  )
/


-- End of DDL Script for Index IFRMAXIMO.USERRESTRCT_NDX2

-- Start of DDL Script for Index IFRMAXIMO.VALUELIST_NDX1
-- Generated 3/10/2006 17:22:15 from IFRMAXIMO@prodsede2

CREATE UNIQUE INDEX ifrmaximo.valuelist_ndx1 ON ifrmaximo.valuelist
  (
    listname                        ASC,
    value                           ASC,
    maxvalue                        ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
  TABLESPACE  tsi_maximo
  STORAGE   (
    INITIAL     65536
    MINEXTENTS  1
    MAXEXTENTS  2147483645
  )
/


-- End of DDL Script for Index IFRMAXIMO.VALUELIST_NDX1

-- Start of DDL Script for Index IFRMAXIMO.VALUELIST_NDX3
-- Generated 3/10/2006 17:22:15 from IFRMAXIMO@prodsede2

CREATE INDEX ifrmaximo.valuelist_ndx3 ON ifrmaximo.valuelist
  (
    maxvalue                        ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
  TABLESPACE  tsi_maximo
  STORAGE   (
    INITIAL     65536
    MINEXTENTS  1
    MAXEXTENTS  2147483645
  )
/


-- End of DDL Script for Index IFRMAXIMO.VALUELIST_NDX3

-- Start of DDL Script for Index IFRMAXIMO.VENDORSTATUS_NDX1
-- Generated 3/10/2006 17:22:15 from IFRMAXIMO@prodsede2

CREATE INDEX ifrmaximo.vendorstatus_ndx1 ON ifrmaximo.vendorstatus
  (
    orgid                           ASC,
    statusdate                      ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
  TABLESPACE  tsi_maximo
  STORAGE   (
    INITIAL     65536
    MINEXTENTS  1
    MAXEXTENTS  2147483645
  )
/


-- End of DDL Script for Index IFRMAXIMO.VENDORSTATUS_NDX1

-- Start of DDL Script for Index IFRMAXIMO.VERITYACTION_NDX1
-- Generated 3/10/2006 17:22:15 from IFRMAXIMO@prodsede2

CREATE UNIQUE INDEX ifrmaximo.verityaction_ndx1 ON ifrmaximo.verityaction
  (
    orgid                           ASC,
    transid                         ASC,
    itemnum                         ASC,
    action                          ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
  TABLESPACE  tsi_maximo
  STORAGE   (
    INITIAL     65536
    MINEXTENTS  1
    MAXEXTENTS  2147483645
  )
/


-- End of DDL Script for Index IFRMAXIMO.VERITYACTION_NDX1

-- Start of DDL Script for Index IFRMAXIMO.VLDOMAIN_NDX1
-- Generated 3/10/2006 17:22:16 from IFRMAXIMO@prodsede2

CREATE UNIQUE INDEX ifrmaximo.vldomain_ndx1 ON ifrmaximo.valuelistdomain
  (
    domainid                        ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
  TABLESPACE  tsi_maximo
  STORAGE   (
    INITIAL     65536
    MINEXTENTS  1
    MAXEXTENTS  2147483645
  )
/


-- End of DDL Script for Index IFRMAXIMO.VLDOMAIN_NDX1

-- Start of DDL Script for Index IFRMAXIMO.WFACTION_NDX1
-- Generated 3/10/2006 17:22:16 from IFRMAXIMO@prodsede2

CREATE UNIQUE INDEX ifrmaximo.wfaction_ndx1 ON ifrmaximo.wfaction
  (
    processid                       ASC,
    actionid                        ASC,
    processrev                      ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
  TABLESPACE  tsi_maximo
  STORAGE   (
    INITIAL     65536
    MINEXTENTS  1
    MAXEXTENTS  2147483645
  )
/


-- End of DDL Script for Index IFRMAXIMO.WFACTION_NDX1

-- Start of DDL Script for Index IFRMAXIMO.WFACTION_NDX2
-- Generated 3/10/2006 17:22:16 from IFRMAXIMO@prodsede2

CREATE INDEX ifrmaximo.wfaction_ndx2 ON ifrmaximo.wfaction
  (
    processid                       ASC,
    ownernodeid                     ASC,
    processrev                      ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
  TABLESPACE  tsi_maximo
  STORAGE   (
    INITIAL     65536
    MINEXTENTS  1
    MAXEXTENTS  2147483645
  )
/


-- End of DDL Script for Index IFRMAXIMO.WFACTION_NDX2

-- Start of DDL Script for Index IFRMAXIMO.WFACTION_NDX3
-- Generated 3/10/2006 17:22:16 from IFRMAXIMO@prodsede2

CREATE INDEX ifrmaximo.wfaction_ndx3 ON ifrmaximo.wfaction
  (
    processid                       ASC,
    processrev                      ASC,
    membernodeid                    ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
  TABLESPACE  tsi_maximo
  STORAGE   (
    INITIAL     65536
    MINEXTENTS  1
    MAXEXTENTS  2147483645
  )
/


-- End of DDL Script for Index IFRMAXIMO.WFACTION_NDX3

-- Start of DDL Script for Index IFRMAXIMO.WFACTIONLIST_NDX1
-- Generated 3/10/2006 17:22:16 from IFRMAXIMO@prodsede2

CREATE UNIQUE INDEX ifrmaximo.wfactionlist_ndx1 ON ifrmaximo.wfactionlist
  (
    action                          ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
  TABLESPACE  tsi_maximo
  STORAGE   (
    INITIAL     40960
    MINEXTENTS  1
    MAXEXTENTS  2147483645
  )
/


-- End of DDL Script for Index IFRMAXIMO.WFACTIONLIST_NDX1

-- Start of DDL Script for Index IFRMAXIMO.WFASSIGN_NDX1
-- Generated 3/10/2006 17:22:16 from IFRMAXIMO@prodsede2

CREATE UNIQUE INDEX ifrmaximo.wfassign_ndx1 ON ifrmaximo.wfassignment
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
  TABLESPACE  tsi_maximo
  STORAGE   (
    INITIAL     65536
    MINEXTENTS  1
    MAXEXTENTS  2147483645
  )
/


-- End of DDL Script for Index IFRMAXIMO.WFASSIGN_NDX1

-- Start of DDL Script for Index IFRMAXIMO.WFASSIGN_NDX2
-- Generated 3/10/2006 17:22:17 from IFRMAXIMO@prodsede2

CREATE INDEX ifrmaximo.wfassign_ndx2 ON ifrmaximo.wfassignment
  (
    assigncode                      ASC,
    assignstatus                    ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
  TABLESPACE  tsi_maximo
  STORAGE   (
    INITIAL     65536
    MINEXTENTS  1
    MAXEXTENTS  2147483645
  )
/


-- End of DDL Script for Index IFRMAXIMO.WFASSIGN_NDX2

-- Start of DDL Script for Index IFRMAXIMO.WFASSIGN_NDX3
-- Generated 3/10/2006 17:22:17 from IFRMAXIMO@prodsede2

CREATE INDEX ifrmaximo.wfassign_ndx3 ON ifrmaximo.wfassignment
  (
    wfid                            ASC,
    processid                       ASC,
    processrev                      ASC,
    nodeid                          ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
  TABLESPACE  tsi_maximo
  STORAGE   (
    INITIAL     65536
    MINEXTENTS  1
    MAXEXTENTS  2147483645
  )
/


-- End of DDL Script for Index IFRMAXIMO.WFASSIGN_NDX3

-- Start of DDL Script for Index IFRMAXIMO.WFASSIGN_NDX4
-- Generated 3/10/2006 17:22:17 from IFRMAXIMO@prodsede2

CREATE INDEX ifrmaximo.wfassign_ndx4 ON ifrmaximo.wfassignment
  (
    assignstatus                    ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
  TABLESPACE  tsi_maximo
  STORAGE   (
    INITIAL     65536
    MINEXTENTS  1
    MAXEXTENTS  2147483645
  )
/


-- End of DDL Script for Index IFRMAXIMO.WFASSIGN_NDX4

-- Start of DDL Script for Index IFRMAXIMO.WFCALLSTACK_NDX1
-- Generated 3/10/2006 17:22:17 from IFRMAXIMO@prodsede2

CREATE INDEX ifrmaximo.wfcallstack_ndx1 ON ifrmaximo.wfcallstack
  (
    wfid                            ASC,
    processid                       ASC,
    active                          ASC,
    processrev                      ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
  TABLESPACE  tsi_maximo
  STORAGE   (
    INITIAL     65536
    MINEXTENTS  1
    MAXEXTENTS  2147483645
  )
/


-- End of DDL Script for Index IFRMAXIMO.WFCALLSTACK_NDX1

-- Start of DDL Script for Index IFRMAXIMO.WFCALLSTACK_NDX2
-- Generated 3/10/2006 17:22:17 from IFRMAXIMO@prodsede2

CREATE INDEX ifrmaximo.wfcallstack_ndx2 ON ifrmaximo.wfcallstack
  (
    wfid                            ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
  TABLESPACE  tsi_maximo
  STORAGE   (
    INITIAL     65536
    MINEXTENTS  1
    MAXEXTENTS  2147483645
  )
/


-- End of DDL Script for Index IFRMAXIMO.WFCALLSTACK_NDX2

-- Start of DDL Script for Index IFRMAXIMO.WFCALLSTACK_NDX3
-- Generated 3/10/2006 17:22:17 from IFRMAXIMO@prodsede2

CREATE UNIQUE INDEX ifrmaximo.wfcallstack_ndx3 ON ifrmaximo.wfcallstack
  (
    wfid                            ASC,
    callseq                         ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
  TABLESPACE  tsi_maximo
  STORAGE   (
    INITIAL     65536
    MINEXTENTS  1
    MAXEXTENTS  2147483645
  )
/


-- End of DDL Script for Index IFRMAXIMO.WFCALLSTACK_NDX3

-- Start of DDL Script for Index IFRMAXIMO.WFCONDITION_NDX1
-- Generated 3/10/2006 17:22:18 from IFRMAXIMO@prodsede2

CREATE UNIQUE INDEX ifrmaximo.wfcondition_ndx1 ON ifrmaximo.wfcondition
  (
    processid                       ASC,
    nodeid                          ASC,
    processrev                      ASC,
    assignid                        ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
  TABLESPACE  tsi_maximo
  STORAGE   (
    INITIAL     65536
    MINEXTENTS  1
    MAXEXTENTS  2147483645
  )
/


-- End of DDL Script for Index IFRMAXIMO.WFCONDITION_NDX1

-- Start of DDL Script for Index IFRMAXIMO.WFINPUT_NDX1
-- Generated 3/10/2006 17:22:18 from IFRMAXIMO@prodsede2

CREATE UNIQUE INDEX ifrmaximo.wfinput_ndx1 ON ifrmaximo.wfinput
  (
    processid                       ASC,
    nodeid                          ASC,
    processrev                      ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
  TABLESPACE  tsi_maximo
  STORAGE   (
    INITIAL     65536
    MINEXTENTS  1
    MAXEXTENTS  2147483645
  )
/


-- End of DDL Script for Index IFRMAXIMO.WFINPUT_NDX1

-- Start of DDL Script for Index IFRMAXIMO.WFINSTANCE_NDX1
-- Generated 3/10/2006 17:22:18 from IFRMAXIMO@prodsede2

CREATE UNIQUE INDEX ifrmaximo.wfinstance_ndx1 ON ifrmaximo.wfinstance
  (
    wfid                            ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
  TABLESPACE  tsi_maximo
  STORAGE   (
    INITIAL     65536
    MINEXTENTS  1
    MAXEXTENTS  2147483645
  )
/


-- End of DDL Script for Index IFRMAXIMO.WFINSTANCE_NDX1

-- Start of DDL Script for Index IFRMAXIMO.WFNODE_NDX1
-- Generated 3/10/2006 17:22:18 from IFRMAXIMO@prodsede2

CREATE UNIQUE INDEX ifrmaximo.wfnode_ndx1 ON ifrmaximo.wfnode
  (
    processid                       ASC,
    nodeid                          ASC,
    processrev                      ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
  TABLESPACE  tsi_maximo
  STORAGE   (
    INITIAL     65536
    MINEXTENTS  1
    MAXEXTENTS  2147483645
  )
/


-- End of DDL Script for Index IFRMAXIMO.WFNODE_NDX1

-- Start of DDL Script for Index IFRMAXIMO.WFNODE_NDX2
-- Generated 3/10/2006 17:22:18 from IFRMAXIMO@prodsede2

CREATE INDEX ifrmaximo.wfnode_ndx2 ON ifrmaximo.wfnode
  (
    processid                       ASC,
    processrev                      ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
  TABLESPACE  tsi_maximo
  STORAGE   (
    INITIAL     65536
    MINEXTENTS  1
    MAXEXTENTS  2147483645
  )
/


-- End of DDL Script for Index IFRMAXIMO.WFNODE_NDX2

-- Start of DDL Script for Index IFRMAXIMO.WFNODE_NDX3
-- Generated 3/10/2006 17:22:18 from IFRMAXIMO@prodsede2

CREATE INDEX ifrmaximo.wfnode_ndx3 ON ifrmaximo.wfnode
  (
    processid                       ASC,
    processrev                      ASC,
    nodetype                        ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
  TABLESPACE  tsi_maximo
  STORAGE   (
    INITIAL     65536
    MINEXTENTS  1
    MAXEXTENTS  2147483645
  )
/


-- End of DDL Script for Index IFRMAXIMO.WFNODE_NDX3

-- Start of DDL Script for Index IFRMAXIMO.WFNOTIFY_NDX1
-- Generated 3/10/2006 17:22:18 from IFRMAXIMO@prodsede2

CREATE UNIQUE INDEX ifrmaximo.wfnotify_ndx1 ON ifrmaximo.wfnotification
  (
    notificationid                  ASC,
    processid                       ASC,
    processrev                      ASC,
    wfid                            ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
  TABLESPACE  tsi_maximo
  STORAGE   (
    INITIAL     65536
    MINEXTENTS  1
    MAXEXTENTS  2147483645
  )
/


-- End of DDL Script for Index IFRMAXIMO.WFNOTIFY_NDX1

-- Start of DDL Script for Index IFRMAXIMO.WFNOTIFY_NDX2
-- Generated 3/10/2006 17:22:19 from IFRMAXIMO@prodsede2

CREATE INDEX ifrmaximo.wfnotify_ndx2 ON ifrmaximo.wfnotification
  (
    wfid                            ASC,
    processid                       ASC,
    processrev                      ASC,
    nodeid                          ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
  TABLESPACE  tsi_maximo
  STORAGE   (
    INITIAL     65536
    MINEXTENTS  1
    MAXEXTENTS  2147483645
  )
/


-- End of DDL Script for Index IFRMAXIMO.WFNOTIFY_NDX2

-- Start of DDL Script for Index IFRMAXIMO.WFNOTIFY_NDX3
-- Generated 3/10/2006 17:22:19 from IFRMAXIMO@prodsede2

CREATE INDEX ifrmaximo.wfnotify_ndx3 ON ifrmaximo.wfnotification
  (
    notifystatus                    ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
  TABLESPACE  tsi_maximo
  STORAGE   (
    INITIAL     65536
    MINEXTENTS  1
    MAXEXTENTS  2147483645
  )
/


-- End of DDL Script for Index IFRMAXIMO.WFNOTIFY_NDX3

-- Start of DDL Script for Index IFRMAXIMO.WFPROCESS_NDX1
-- Generated 3/10/2006 17:22:19 from IFRMAXIMO@prodsede2

CREATE UNIQUE INDEX ifrmaximo.wfprocess_ndx1 ON ifrmaximo.wfprocess
  (
    processid                       ASC,
    processrev                      ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
  TABLESPACE  tsi_maximo
  STORAGE   (
    INITIAL     65536
    MINEXTENTS  1
    MAXEXTENTS  2147483645
  )
/


-- End of DDL Script for Index IFRMAXIMO.WFPROCESS_NDX1

-- Start of DDL Script for Index IFRMAXIMO.WFPROCESS_NDX2
-- Generated 3/10/2006 17:22:19 from IFRMAXIMO@prodsede2

CREATE INDEX ifrmaximo.wfprocess_ndx2 ON ifrmaximo.wfprocess
  (
    processtype                     ASC,
    enabled                         ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
  TABLESPACE  tsi_maximo
  STORAGE   (
    INITIAL     65536
    MINEXTENTS  1
    MAXEXTENTS  2147483645
  )
/


-- End of DDL Script for Index IFRMAXIMO.WFPROCESS_NDX2

-- Start of DDL Script for Index IFRMAXIMO.WFPROCESS_NDX3
-- Generated 3/10/2006 17:22:19 from IFRMAXIMO@prodsede2

CREATE INDEX ifrmaximo.wfprocess_ndx3 ON ifrmaximo.wfprocess
  (
    migrated                        ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
  TABLESPACE  tsi_maximo
  STORAGE   (
    INITIAL     65536
    MINEXTENTS  1
    MAXEXTENTS  2147483645
  )
/


-- End of DDL Script for Index IFRMAXIMO.WFPROCESS_NDX3

-- Start of DDL Script for Index IFRMAXIMO.WFREVISION_NDX1
-- Generated 3/10/2006 17:22:19 from IFRMAXIMO@prodsede2

CREATE UNIQUE INDEX ifrmaximo.wfrevision_ndx1 ON ifrmaximo.wfrevision
  (
    processtype                     ASC,
    revision                        ASC,
    processid                       ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
  TABLESPACE  tsi_maximo
  STORAGE   (
    INITIAL     65536
    MINEXTENTS  1
    MAXEXTENTS  2147483645
  )
/


-- End of DDL Script for Index IFRMAXIMO.WFREVISION_NDX1

-- Start of DDL Script for Index IFRMAXIMO.WFREVISION_NDX2
-- Generated 3/10/2006 17:22:20 from IFRMAXIMO@prodsede2

CREATE INDEX ifrmaximo.wfrevision_ndx2 ON ifrmaximo.wfrevision
  (
    maintbname                      ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
  TABLESPACE  tsi_maximo
  STORAGE   (
    INITIAL     65536
    MINEXTENTS  1
    MAXEXTENTS  2147483645
  )
/


-- End of DDL Script for Index IFRMAXIMO.WFREVISION_NDX2

-- Start of DDL Script for Index IFRMAXIMO.WFREVISION_NDX3
-- Generated 3/10/2006 17:22:20 from IFRMAXIMO@prodsede2

CREATE INDEX ifrmaximo.wfrevision_ndx3 ON ifrmaximo.wfrevision
  (
    revision                        ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
  TABLESPACE  tsi_maximo
  STORAGE   (
    INITIAL     65536
    MINEXTENTS  1
    MAXEXTENTS  2147483645
  )
/


-- End of DDL Script for Index IFRMAXIMO.WFREVISION_NDX3

-- Start of DDL Script for Index IFRMAXIMO.WFROLE_NDX1
-- Generated 3/10/2006 17:22:20 from IFRMAXIMO@prodsede2

CREATE UNIQUE INDEX ifrmaximo.wfrole_ndx1 ON ifrmaximo.wfrole
  (
    roleid                          ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
  TABLESPACE  tsi_maximo
  STORAGE   (
    INITIAL     65536
    MINEXTENTS  1
    MAXEXTENTS  2147483645
  )
/


-- End of DDL Script for Index IFRMAXIMO.WFROLE_NDX1

-- Start of DDL Script for Index IFRMAXIMO.WFSTART_NDX1
-- Generated 3/10/2006 17:22:20 from IFRMAXIMO@prodsede2

CREATE UNIQUE INDEX ifrmaximo.wfstart_ndx1 ON ifrmaximo.wfstart
  (
    processid                       ASC,
    nodeid                          ASC,
    processrev                      ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
  TABLESPACE  tsi_maximo
  STORAGE   (
    INITIAL     65536
    MINEXTENTS  1
    MAXEXTENTS  2147483645
  )
/


-- End of DDL Script for Index IFRMAXIMO.WFSTART_NDX1

-- Start of DDL Script for Index IFRMAXIMO.WFSTOP_NDX1
-- Generated 3/10/2006 17:22:20 from IFRMAXIMO@prodsede2

CREATE UNIQUE INDEX ifrmaximo.wfstop_ndx1 ON ifrmaximo.wfstop
  (
    processid                       ASC,
    nodeid                          ASC,
    processrev                      ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
  TABLESPACE  tsi_maximo
  STORAGE   (
    INITIAL     65536
    MINEXTENTS  1
    MAXEXTENTS  2147483645
  )
/


-- End of DDL Script for Index IFRMAXIMO.WFSTOP_NDX1

-- Start of DDL Script for Index IFRMAXIMO.WFSUBPROC_NDX1
-- Generated 3/10/2006 17:22:20 from IFRMAXIMO@prodsede2

CREATE UNIQUE INDEX ifrmaximo.wfsubproc_ndx1 ON ifrmaximo.wfsubprocess
  (
    processid                       ASC,
    nodeid                          ASC,
    processrev                      ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
  TABLESPACE  tsi_maximo
  STORAGE   (
    INITIAL     65536
    MINEXTENTS  1
    MAXEXTENTS  2147483645
  )
/


-- End of DDL Script for Index IFRMAXIMO.WFSUBPROC_NDX1

-- Start of DDL Script for Index IFRMAXIMO.WFTASK_NDX1
-- Generated 3/10/2006 17:22:21 from IFRMAXIMO@prodsede2

CREATE UNIQUE INDEX ifrmaximo.wftask_ndx1 ON ifrmaximo.wftask
  (
    processid                       ASC,
    nodeid                          ASC,
    processrev                      ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
  TABLESPACE  tsi_maximo
  STORAGE   (
    INITIAL     65536
    MINEXTENTS  1
    MAXEXTENTS  2147483645
  )
/


-- End of DDL Script for Index IFRMAXIMO.WFTASK_NDX1

-- Start of DDL Script for Index IFRMAXIMO.WFTRANSACTION_NDX1
-- Generated 3/10/2006 17:22:21 from IFRMAXIMO@prodsede2

CREATE INDEX ifrmaximo.wftransaction_ndx1 ON ifrmaximo.wftransaction
  (
    nodeid                          ASC,
    processid                       ASC,
    wfid                            ASC,
    transdate                       ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
  TABLESPACE  tsi_maximo
  STORAGE   (
    INITIAL     65536
    MINEXTENTS  1
    MAXEXTENTS  2147483645
  )
/


-- End of DDL Script for Index IFRMAXIMO.WFTRANSACTION_NDX1

-- Start of DDL Script for Index IFRMAXIMO.WFTRANSACTION_NDX2
-- Generated 3/10/2006 17:22:21 from IFRMAXIMO@prodsede2

CREATE UNIQUE INDEX ifrmaximo.wftransaction_ndx2 ON ifrmaximo.wftransaction
  (
    transid                         ASC,
    nodeid                          ASC,
    processid                       ASC,
    wfid                            ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
  TABLESPACE  tsi_maximo
  STORAGE   (
    INITIAL     65536
    MINEXTENTS  1
    MAXEXTENTS  2147483645
  )
/


-- End of DDL Script for Index IFRMAXIMO.WFTRANSACTION_NDX2

-- Start of DDL Script for Index IFRMAXIMO.WOANCESTOR_NDX1
-- Generated 3/10/2006 17:22:21 from IFRMAXIMO@prodsede2

CREATE UNIQUE INDEX ifrmaximo.woancestor_ndx1 ON ifrmaximo.woancestor
  (
    siteid                          ASC,
    wonum                           ASC,
    ancestor                        ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
  TABLESPACE  tsi_maximo
  STORAGE   (
    INITIAL     65536
    MINEXTENTS  1
    MAXEXTENTS  2147483645
  )
/


-- End of DDL Script for Index IFRMAXIMO.WOANCESTOR_NDX1

-- Start of DDL Script for Index IFRMAXIMO.WOANCESTOR_NDX2
-- Generated 3/10/2006 17:22:21 from IFRMAXIMO@prodsede2

CREATE INDEX ifrmaximo.woancestor_ndx2 ON ifrmaximo.woancestor
  (
    siteid                          ASC,
    ancestor                        ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
  TABLESPACE  tsi_maximo
  STORAGE   (
    INITIAL     65536
    MINEXTENTS  1
    MAXEXTENTS  2147483645
  )
/


-- End of DDL Script for Index IFRMAXIMO.WOANCESTOR_NDX2

-- Start of DDL Script for Index IFRMAXIMO.WOANCESTOR_NDX4
-- Generated 3/10/2006 17:22:22 from IFRMAXIMO@prodsede2

CREATE INDEX ifrmaximo.woancestor_ndx4 ON ifrmaximo.woancestor
  (
    wonum                           ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
  TABLESPACE  tsi_maximo
  STORAGE   (
    INITIAL     65536
    MINEXTENTS  1
    MAXEXTENTS  2147483645
  )
/


-- End of DDL Script for Index IFRMAXIMO.WOANCESTOR_NDX4

-- Start of DDL Script for Index IFRMAXIMO.WOASSIGNPARTY_NDX1
-- Generated 3/10/2006 17:22:22 from IFRMAXIMO@prodsede2

CREATE UNIQUE INDEX ifrmaximo.woassignparty_ndx1 ON ifrmaximo.woassignmntparty
  (
    siteid                          ASC,
    woassignmntqueueid              ASC,
    resppartygroup                  ASC,
    respparty                       ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
  TABLESPACE  tsi_maximo
  STORAGE   (
    INITIAL     65536
    MINEXTENTS  1
    MAXEXTENTS  2147483645
  )
/


-- End of DDL Script for Index IFRMAXIMO.WOASSIGNPARTY_NDX1

-- Start of DDL Script for Index IFRMAXIMO.WOASSIGNPARTY_NDX2
-- Generated 3/10/2006 17:22:22 from IFRMAXIMO@prodsede2

CREATE INDEX ifrmaximo.woassignparty_ndx2 ON ifrmaximo.woassignmntparty
  (
    siteid                          ASC,
    woassignmntqueueid              ASC,
    resppartygroupseq               ASC,
    resppartyseq                    ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
  TABLESPACE  tsi_maximo
  STORAGE   (
    INITIAL     65536
    MINEXTENTS  1
    MAXEXTENTS  2147483645
  )
/


-- End of DDL Script for Index IFRMAXIMO.WOASSIGNPARTY_NDX2

-- Start of DDL Script for Index IFRMAXIMO.WOASSIGNQUEUE_NDX1
-- Generated 3/10/2006 17:22:22 from IFRMAXIMO@prodsede2

CREATE UNIQUE INDEX ifrmaximo.woassignqueue_ndx1 ON ifrmaximo.woassignmntqueue
  (
    siteid                          ASC,
    woassignmntqueueid              ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
  TABLESPACE  tsi_maximo
  STORAGE   (
    INITIAL     65536
    MINEXTENTS  1
    MAXEXTENTS  2147483645
  )
/


-- End of DDL Script for Index IFRMAXIMO.WOASSIGNQUEUE_NDX1

-- Start of DDL Script for Index IFRMAXIMO.WOGEN_NDX1
-- Generated 3/10/2006 17:22:22 from IFRMAXIMO@prodsede2

CREATE UNIQUE INDEX ifrmaximo.wogen_ndx1 ON ifrmaximo.wogen
  (
    siteid                          ASC,
    runid                           ASC,
    runorder                        ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
  TABLESPACE  tsi_maximo
  STORAGE   (
    INITIAL     65536
    MINEXTENTS  1
    MAXEXTENTS  2147483645
  )
/


-- End of DDL Script for Index IFRMAXIMO.WOGEN_NDX1

-- Start of DDL Script for Index IFRMAXIMO.WOHAZARD_NDX1
-- Generated 3/10/2006 17:22:22 from IFRMAXIMO@prodsede2

CREATE UNIQUE INDEX ifrmaximo.wohazard_ndx1 ON ifrmaximo.wohazard
  (
    siteid                          ASC,
    wonum                           ASC,
    hazardid                        ASC,
    wosafetydatasource              ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
  TABLESPACE  tsi_maximo
  STORAGE   (
    INITIAL     65536
    MINEXTENTS  1
    MAXEXTENTS  2147483645
  )
/


-- End of DDL Script for Index IFRMAXIMO.WOHAZARD_NDX1

-- Start of DDL Script for Index IFRMAXIMO.WOHAZARDPREC_NDX1
-- Generated 3/10/2006 17:22:23 from IFRMAXIMO@prodsede2

CREATE UNIQUE INDEX ifrmaximo.wohazardprec_ndx1 ON ifrmaximo.wohazardprec
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
  TABLESPACE  tsi_maximo
  STORAGE   (
    INITIAL     65536
    MINEXTENTS  1
    MAXEXTENTS  2147483645
  )
/


-- End of DDL Script for Index IFRMAXIMO.WOHAZARDPREC_NDX1

-- Start of DDL Script for Index IFRMAXIMO.WOHISTORICO_NDX1
-- Generated 3/10/2006 17:22:23 from IFRMAXIMO@prodsede2

CREATE UNIQUE INDEX ifrmaximo.wohistorico_ndx1 ON ifrmaximo.wohistorico
  (
    siteid                          ASC,
    wonum                           ASC
  )
  PCTFREE     0
  INITRANS    2
  MAXTRANS    255
  TABLESPACE  tsi_maximo
  STORAGE   (
    INITIAL     65536
    MINEXTENTS  1
    MAXEXTENTS  2147483645
  )
/


-- End of DDL Script for Index IFRMAXIMO.WOHISTORICO_NDX1

-- Start of DDL Script for Index IFRMAXIMO.WOHISTORICO_NDX10
-- Generated 3/10/2006 17:22:23 from IFRMAXIMO@prodsede2

CREATE INDEX ifrmaximo.wohistorico_ndx10 ON ifrmaximo.wohistorico
  (
    parent                          ASC,
    siteid                          ASC
  )
  PCTFREE     0
  INITRANS    2
  MAXTRANS    255
  TABLESPACE  tsi_maximo
  STORAGE   (
    INITIAL     65536
    MINEXTENTS  1
    MAXEXTENTS  2147483645
  )
/


-- End of DDL Script for Index IFRMAXIMO.WOHISTORICO_NDX10

-- Start of DDL Script for Index IFRMAXIMO.WOHISTORICO_NDX11
-- Generated 3/10/2006 17:22:23 from IFRMAXIMO@prodsede2

CREATE INDEX ifrmaximo.wohistorico_ndx11 ON ifrmaximo.wohistorico
  (
    wopm7                           ASC,
    siteid                          ASC
  )
  PCTFREE     0
  INITRANS    2
  MAXTRANS    255
  TABLESPACE  tsi_maximo
  STORAGE   (
    INITIAL     65536
    MINEXTENTS  1
    MAXEXTENTS  2147483645
  )
/


-- End of DDL Script for Index IFRMAXIMO.WOHISTORICO_NDX11

-- Start of DDL Script for Index IFRMAXIMO.WOHISTORICO_NDX12
-- Generated 3/10/2006 17:22:23 from IFRMAXIMO@prodsede2

CREATE UNIQUE INDEX ifrmaximo.wohistorico_ndx12 ON ifrmaximo.wohistorico
  (
    wonum                           ASC,
    istask                          ASC,
    historyflag                     ASC
  )
  PCTFREE     0
  INITRANS    2
  MAXTRANS    255
  TABLESPACE  tsi_maximo
  STORAGE   (
    INITIAL     65536
    MINEXTENTS  1
    MAXEXTENTS  2147483645
  )
/


-- End of DDL Script for Index IFRMAXIMO.WOHISTORICO_NDX12

-- Start of DDL Script for Index IFRMAXIMO.WOHISTORICO_NDX13
-- Generated 3/10/2006 17:22:23 from IFRMAXIMO@prodsede2

CREATE INDEX ifrmaximo.wohistorico_ndx13 ON ifrmaximo.wohistorico
  (
    siteid                          ASC,
    istask                          ASC,
    historyflag                     ASC
  )
  PCTFREE     0
  INITRANS    2
  MAXTRANS    255
  TABLESPACE  tsi_maximo
  STORAGE   (
    INITIAL     65536
    MINEXTENTS  1
    MAXEXTENTS  2147483645
  )
/


-- End of DDL Script for Index IFRMAXIMO.WOHISTORICO_NDX13

-- Start of DDL Script for Index IFRMAXIMO.WOHISTORICO_NDX14
-- Generated 3/10/2006 17:22:24 from IFRMAXIMO@prodsede2

CREATE INDEX ifrmaximo.wohistorico_ndx14 ON ifrmaximo.wohistorico
  (
    historyflag                     ASC,
    istask                          ASC,
    wopm7                           ASC,
    siteid                          ASC
  )
  PCTFREE     0
  INITRANS    2
  MAXTRANS    255
  TABLESPACE  tsi_maximo
  STORAGE   (
    INITIAL     65536
    MINEXTENTS  1
    MAXEXTENTS  2147483645
  )
/


-- End of DDL Script for Index IFRMAXIMO.WOHISTORICO_NDX14

-- Start of DDL Script for Index IFRMAXIMO.WOHISTORICO_NDX15
-- Generated 3/10/2006 17:22:24 from IFRMAXIMO@prodsede2

CREATE INDEX ifrmaximo.wohistorico_ndx15 ON ifrmaximo.wohistorico
  (
    wopm6                           ASC,
    siteid                          ASC
  )
  PCTFREE     0
  INITRANS    2
  MAXTRANS    255
  TABLESPACE  tsi_maximo
  STORAGE   (
    INITIAL     65536
    MINEXTENTS  1
    MAXEXTENTS  2147483645
  )
/


-- End of DDL Script for Index IFRMAXIMO.WOHISTORICO_NDX15

-- Start of DDL Script for Index IFRMAXIMO.WOHISTORICO_NDX16
-- Generated 3/10/2006 17:22:24 from IFRMAXIMO@prodsede2

CREATE INDEX ifrmaximo.wohistorico_ndx16 ON ifrmaximo.wohistorico
  (
    siteid                          ASC,
    crewid                          ASC
  )
  PCTFREE     0
  INITRANS    2
  MAXTRANS    255
  TABLESPACE  tsi_maximo
  STORAGE   (
    INITIAL     65536
    MINEXTENTS  1
    MAXEXTENTS  2147483645
  )
/


-- End of DDL Script for Index IFRMAXIMO.WOHISTORICO_NDX16

-- Start of DDL Script for Index IFRMAXIMO.WOHISTORICO_NDX17
-- Generated 3/10/2006 17:22:24 from IFRMAXIMO@prodsede2

CREATE INDEX ifrmaximo.wohistorico_ndx17 ON ifrmaximo.wohistorico
  (
    ldkey                           ASC
  )
  PCTFREE     0
  INITRANS    2
  MAXTRANS    255
  TABLESPACE  tsi_maximo
  STORAGE   (
    INITIAL     65536
    MINEXTENTS  1
    MAXEXTENTS  2147483645
  )
/


-- End of DDL Script for Index IFRMAXIMO.WOHISTORICO_NDX17

-- Start of DDL Script for Index IFRMAXIMO.WOHISTORICO_NDX18
-- Generated 3/10/2006 17:22:24 from IFRMAXIMO@prodsede2

CREATE INDEX ifrmaximo.wohistorico_ndx18 ON ifrmaximo.wohistorico
  (
    siteid                          ASC,
    crewid                          ASC,
    status                          ASC
  )
  PCTFREE     0
  INITRANS    2
  MAXTRANS    255
  TABLESPACE  tsi_maximo
  STORAGE   (
    INITIAL     65536
    MINEXTENTS  1
    MAXEXTENTS  2147483645
  )
/


-- End of DDL Script for Index IFRMAXIMO.WOHISTORICO_NDX18

-- Start of DDL Script for Index IFRMAXIMO.WOHISTORICO_NDX2
-- Generated 3/10/2006 17:22:24 from IFRMAXIMO@prodsede2

CREATE INDEX ifrmaximo.wohistorico_ndx2 ON ifrmaximo.wohistorico
  (
    siteid                          ASC,
    status                          ASC
  )
  PCTFREE     0
  INITRANS    2
  MAXTRANS    255
  TABLESPACE  tsi_maximo
  STORAGE   (
    INITIAL     65536
    MINEXTENTS  1
    MAXEXTENTS  2147483645
  )
/


-- End of DDL Script for Index IFRMAXIMO.WOHISTORICO_NDX2

-- Start of DDL Script for Index IFRMAXIMO.WOHISTORICO_NDX3
-- Generated 3/10/2006 17:22:25 from IFRMAXIMO@prodsede2

CREATE INDEX ifrmaximo.wohistorico_ndx3 ON ifrmaximo.wohistorico
  (
    siteid                          ASC,
    historyflag                     ASC
  )
  PCTFREE     0
  INITRANS    2
  MAXTRANS    255
  TABLESPACE  tsi_maximo
  STORAGE   (
    INITIAL     65536
    MINEXTENTS  1
    MAXEXTENTS  2147483645
  )
/


-- End of DDL Script for Index IFRMAXIMO.WOHISTORICO_NDX3

-- Start of DDL Script for Index IFRMAXIMO.WOHISTORICO_NDX4
-- Generated 3/10/2006 17:22:25 from IFRMAXIMO@prodsede2

CREATE INDEX ifrmaximo.wohistorico_ndx4 ON ifrmaximo.wohistorico
  (
    siteid                          ASC,
    interid                         ASC
  )
  PCTFREE     0
  INITRANS    2
  MAXTRANS    255
  TABLESPACE  tsi_maximo
  STORAGE   (
    INITIAL     65536
    MINEXTENTS  1
    MAXEXTENTS  2147483645
  )
/


-- End of DDL Script for Index IFRMAXIMO.WOHISTORICO_NDX4

-- Start of DDL Script for Index IFRMAXIMO.WOHISTORICO_NDX5
-- Generated 3/10/2006 17:22:25 from IFRMAXIMO@prodsede2

CREATE INDEX ifrmaximo.wohistorico_ndx5 ON ifrmaximo.wohistorico
  (
    siteid                          ASC,
    wfid                            ASC
  )
  PCTFREE     0
  INITRANS    2
  MAXTRANS    255
  TABLESPACE  tsi_maximo
  STORAGE   (
    INITIAL     65536
    MINEXTENTS  1
    MAXEXTENTS  2147483645
  )
/


-- End of DDL Script for Index IFRMAXIMO.WOHISTORICO_NDX5

-- Start of DDL Script for Index IFRMAXIMO.WOHISTORICO_NDX6
-- Generated 3/10/2006 17:22:25 from IFRMAXIMO@prodsede2

CREATE INDEX ifrmaximo.wohistorico_ndx6 ON ifrmaximo.wohistorico
  (
    siteid                          ASC,
    respondby                       ASC
  )
  PCTFREE     0
  INITRANS    2
  MAXTRANS    255
  TABLESPACE  tsi_maximo
  STORAGE   (
    INITIAL     65536
    MINEXTENTS  1
    MAXEXTENTS  2147483645
  )
/


-- End of DDL Script for Index IFRMAXIMO.WOHISTORICO_NDX6

-- Start of DDL Script for Index IFRMAXIMO.WOHISTORICO_NDX7
-- Generated 3/10/2006 17:22:25 from IFRMAXIMO@prodsede2

CREATE INDEX ifrmaximo.wohistorico_ndx7 ON ifrmaximo.wohistorico
  (
    siteid                          ASC,
    eqnum                           ASC,
    problemcode                     ASC,
    status                          ASC
  )
  PCTFREE     0
  INITRANS    2
  MAXTRANS    255
  TABLESPACE  tsi_maximo
  STORAGE   (
    INITIAL     65536
    MINEXTENTS  1
    MAXEXTENTS  2147483645
  )
/


-- End of DDL Script for Index IFRMAXIMO.WOHISTORICO_NDX7

-- Start of DDL Script for Index IFRMAXIMO.WOHISTORICO_NDX8
-- Generated 3/10/2006 17:22:25 from IFRMAXIMO@prodsede2

CREATE INDEX ifrmaximo.wohistorico_ndx8 ON ifrmaximo.wohistorico
  (
    siteid                          ASC,
    jpnum                           ASC
  )
  PCTFREE     0
  INITRANS    2
  MAXTRANS    255
  TABLESPACE  tsi_maximo
  STORAGE   (
    INITIAL     65536
    MINEXTENTS  1
    MAXEXTENTS  2147483645
  )
/


-- End of DDL Script for Index IFRMAXIMO.WOHISTORICO_NDX8

-- Start of DDL Script for Index IFRMAXIMO.WOHISTORICO_NDX9
-- Generated 3/10/2006 17:22:26 from IFRMAXIMO@prodsede2

CREATE INDEX ifrmaximo.wohistorico_ndx9 ON ifrmaximo.wohistorico
  (
    siteid                          ASC,
    location                        ASC,
    problemcode                     ASC,
    status                          ASC
  )
  PCTFREE     0
  INITRANS    2
  MAXTRANS    255
  TABLESPACE  tsi_maximo
  STORAGE   (
    INITIAL     65536
    MINEXTENTS  1
    MAXEXTENTS  2147483645
  )
/


-- End of DDL Script for Index IFRMAXIMO.WOHISTORICO_NDX9

-- Start of DDL Script for Index IFRMAXIMO.WOLOCKOUT_NDX1
-- Generated 3/10/2006 17:22:26 from IFRMAXIMO@prodsede2

CREATE UNIQUE INDEX ifrmaximo.wolockout_ndx1 ON ifrmaximo.wolockout
  (
    siteid                          ASC,
    wonum                           ASC,
    lockoutid                       ASC,
    wosafetydatasource              ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
  TABLESPACE  tsi_maximo
  STORAGE   (
    INITIAL     65536
    MINEXTENTS  1
    MAXEXTENTS  2147483645
  )
/


-- End of DDL Script for Index IFRMAXIMO.WOLOCKOUT_NDX1

-- Start of DDL Script for Index IFRMAXIMO.WOPRECAUTION_NDX1
-- Generated 3/10/2006 17:22:26 from IFRMAXIMO@prodsede2

CREATE UNIQUE INDEX ifrmaximo.woprecaution_ndx1 ON ifrmaximo.woprecaution
  (
    siteid                          ASC,
    wonum                           ASC,
    precautionid                    ASC,
    wosafetydatasource              ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
  TABLESPACE  tsi_maximo
  STORAGE   (
    INITIAL     65536
    MINEXTENTS  1
    MAXEXTENTS  2147483645
  )
/


-- End of DDL Script for Index IFRMAXIMO.WOPRECAUTION_NDX1

-- Start of DDL Script for Index IFRMAXIMO.WORKORDER_BKP_NDX1
-- Generated 3/10/2006 17:22:26 from IFRMAXIMO@prodsede2

CREATE UNIQUE INDEX ifrmaximo.workorder_bkp_ndx1 ON ifrmaximo.workorder_bkp
  (
    siteid                          ASC,
    wonum                           ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
  TABLESPACE  tsd_maximo
  STORAGE   (
    INITIAL     65536
    MINEXTENTS  1
    MAXEXTENTS  2147483645
  )
/


-- End of DDL Script for Index IFRMAXIMO.WORKORDER_BKP_NDX1

-- Start of DDL Script for Index IFRMAXIMO.WORKORDER_IDX_TEMP
-- Generated 3/10/2006 17:22:26 from IFRMAXIMO@prodsede2

CREATE INDEX ifrmaximo.workorder_idx_temp ON ifrmaximo.workorder
  (
    siteid                          ASC,
    status                          ASC,
    statusdate                      ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
  TABLESPACE  tsi_maximo
  STORAGE   (
    INITIAL     65536
    MINEXTENTS  1
    MAXEXTENTS  2147483645
  )
/


-- End of DDL Script for Index IFRMAXIMO.WORKORDER_IDX_TEMP

-- Start of DDL Script for Index IFRMAXIMO.WORKORDER_NDX1
-- Generated 3/10/2006 17:22:26 from IFRMAXIMO@prodsede2

CREATE UNIQUE INDEX ifrmaximo.workorder_ndx1 ON ifrmaximo.workorder
  (
    siteid                          ASC,
    wonum                           ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
  TABLESPACE  tsi_maximo
  STORAGE   (
    INITIAL     65536
    MINEXTENTS  1
    MAXEXTENTS  2147483645
  )
/


-- End of DDL Script for Index IFRMAXIMO.WORKORDER_NDX1

-- Start of DDL Script for Index IFRMAXIMO.WORKORDER_NDX10
-- Generated 3/10/2006 17:22:27 from IFRMAXIMO@prodsede2

CREATE INDEX ifrmaximo.workorder_ndx10 ON ifrmaximo.workorder
  (
    parent                          ASC,
    siteid                          ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
  TABLESPACE  tsi_maximo
  STORAGE   (
    INITIAL     65536
    MINEXTENTS  1
    MAXEXTENTS  2147483645
  )
/


-- End of DDL Script for Index IFRMAXIMO.WORKORDER_NDX10

-- Start of DDL Script for Index IFRMAXIMO.WORKORDER_NDX11
-- Generated 3/10/2006 17:22:27 from IFRMAXIMO@prodsede2

CREATE INDEX ifrmaximo.workorder_ndx11 ON ifrmaximo.workorder
  (
    wopm7                           ASC,
    siteid                          ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
  TABLESPACE  tsi_maximo
  STORAGE   (
    INITIAL     65536
    MINEXTENTS  1
    MAXEXTENTS  2147483645
  )
/


-- End of DDL Script for Index IFRMAXIMO.WORKORDER_NDX11

-- Start of DDL Script for Index IFRMAXIMO.WORKORDER_NDX12
-- Generated 3/10/2006 17:22:27 from IFRMAXIMO@prodsede2

CREATE UNIQUE INDEX ifrmaximo.workorder_ndx12 ON ifrmaximo.workorder
  (
    wonum                           ASC,
    istask                          ASC,
    historyflag                     ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
  TABLESPACE  tsi_maximo
  STORAGE   (
    INITIAL     65536
    MINEXTENTS  1
    MAXEXTENTS  2147483645
  )
/


-- End of DDL Script for Index IFRMAXIMO.WORKORDER_NDX12

-- Start of DDL Script for Index IFRMAXIMO.WORKORDER_NDX13
-- Generated 3/10/2006 17:22:27 from IFRMAXIMO@prodsede2

CREATE INDEX ifrmaximo.workorder_ndx13 ON ifrmaximo.workorder
  (
    siteid                          ASC,
    istask                          ASC,
    historyflag                     ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
  TABLESPACE  tsi_maximo
  STORAGE   (
    INITIAL     65536
    MINEXTENTS  1
    MAXEXTENTS  2147483645
  )
/


-- End of DDL Script for Index IFRMAXIMO.WORKORDER_NDX13

-- Start of DDL Script for Index IFRMAXIMO.WORKORDER_NDX14
-- Generated 3/10/2006 17:22:27 from IFRMAXIMO@prodsede2

CREATE INDEX ifrmaximo.workorder_ndx14 ON ifrmaximo.workorder
  (
    historyflag                     ASC,
    istask                          ASC,
    wopm7                           ASC,
    siteid                          ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
  TABLESPACE  tsi_maximo
  STORAGE   (
    INITIAL     65536
    MINEXTENTS  1
    MAXEXTENTS  2147483645
  )
/


-- End of DDL Script for Index IFRMAXIMO.WORKORDER_NDX14

-- Start of DDL Script for Index IFRMAXIMO.WORKORDER_NDX15
-- Generated 3/10/2006 17:22:28 from IFRMAXIMO@prodsede2

CREATE INDEX ifrmaximo.workorder_ndx15 ON ifrmaximo.workorder
  (
    historyflag                     ASC,
    istask                          ASC,
    wopm6                           ASC,
    siteid                          ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
  TABLESPACE  tsi_maximo
  STORAGE   (
    INITIAL     65536
    MINEXTENTS  1
    MAXEXTENTS  2147483645
  )
/


-- End of DDL Script for Index IFRMAXIMO.WORKORDER_NDX15

-- Start of DDL Script for Index IFRMAXIMO.WORKORDER_NDX16
-- Generated 3/10/2006 17:22:28 from IFRMAXIMO@prodsede2

CREATE INDEX ifrmaximo.workorder_ndx16 ON ifrmaximo.workorder
  (
    siteid                          ASC,
    crewid                          ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
  TABLESPACE  tsi_maximo
  STORAGE   (
    INITIAL     65536
    MINEXTENTS  1
    MAXEXTENTS  2147483645
  )
/


-- End of DDL Script for Index IFRMAXIMO.WORKORDER_NDX16

-- Start of DDL Script for Index IFRMAXIMO.WORKORDER_NDX17
-- Generated 3/10/2006 17:22:28 from IFRMAXIMO@prodsede2

CREATE INDEX ifrmaximo.workorder_ndx17 ON ifrmaximo.workorder
  (
    ldkey                           ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
  TABLESPACE  tsi_maximo
  STORAGE   (
    INITIAL     65536
    MINEXTENTS  1
    MAXEXTENTS  2147483645
  )
/


-- End of DDL Script for Index IFRMAXIMO.WORKORDER_NDX17

-- Start of DDL Script for Index IFRMAXIMO.WORKORDER_NDX18
-- Generated 3/10/2006 17:22:28 from IFRMAXIMO@prodsede2

CREATE INDEX ifrmaximo.workorder_ndx18 ON ifrmaximo.workorder
  (
    siteid                          ASC,
    crewid                          ASC,
    status                          ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
  TABLESPACE  tsi_maximo
  STORAGE   (
    INITIAL     65536
    MINEXTENTS  1
    MAXEXTENTS  2147483645
  )
/


-- End of DDL Script for Index IFRMAXIMO.WORKORDER_NDX18

-- Start of DDL Script for Index IFRMAXIMO.WORKORDER_NDX19
-- Generated 3/10/2006 17:22:28 from IFRMAXIMO@prodsede2

CREATE INDEX ifrmaximo.workorder_ndx19 ON ifrmaximo.workorder
  (
    wopm6                           ASC,
    siteid                          ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
  TABLESPACE  tsi_maximo
  STORAGE   (
    INITIAL     65536
    MINEXTENTS  1
    MAXEXTENTS  2147483645
  )
/


-- End of DDL Script for Index IFRMAXIMO.WORKORDER_NDX19

-- Start of DDL Script for Index IFRMAXIMO.WORKORDER_NDX2
-- Generated 3/10/2006 17:22:28 from IFRMAXIMO@prodsede2

CREATE INDEX ifrmaximo.workorder_ndx2 ON ifrmaximo.workorder
  (
    siteid                          ASC,
    status                          ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
  TABLESPACE  tsi_maximo
  STORAGE   (
    INITIAL     65536
    MINEXTENTS  1
    MAXEXTENTS  2147483645
  )
/


-- End of DDL Script for Index IFRMAXIMO.WORKORDER_NDX2

-- Start of DDL Script for Index IFRMAXIMO.WORKORDER_NDX3
-- Generated 3/10/2006 17:22:29 from IFRMAXIMO@prodsede2

CREATE INDEX ifrmaximo.workorder_ndx3 ON ifrmaximo.workorder
  (
    siteid                          ASC,
    historyflag                     ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
  TABLESPACE  tsi_maximo
  STORAGE   (
    INITIAL     65536
    MINEXTENTS  1
    MAXEXTENTS  2147483645
  )
/


-- End of DDL Script for Index IFRMAXIMO.WORKORDER_NDX3

-- Start of DDL Script for Index IFRMAXIMO.WORKORDER_NDX4
-- Generated 3/10/2006 17:22:29 from IFRMAXIMO@prodsede2

CREATE INDEX ifrmaximo.workorder_ndx4 ON ifrmaximo.workorder
  (
    siteid                          ASC,
    interid                         ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
  TABLESPACE  tsi_maximo
  STORAGE   (
    INITIAL     65536
    MINEXTENTS  1
    MAXEXTENTS  2147483645
  )
/


-- End of DDL Script for Index IFRMAXIMO.WORKORDER_NDX4

-- Start of DDL Script for Index IFRMAXIMO.WORKORDER_NDX5
-- Generated 3/10/2006 17:22:29 from IFRMAXIMO@prodsede2

CREATE INDEX ifrmaximo.workorder_ndx5 ON ifrmaximo.workorder
  (
    siteid                          ASC,
    wfid                            ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
  TABLESPACE  tsi_maximo
  STORAGE   (
    INITIAL     65536
    MINEXTENTS  1
    MAXEXTENTS  2147483645
  )
/


-- End of DDL Script for Index IFRMAXIMO.WORKORDER_NDX5

-- Start of DDL Script for Index IFRMAXIMO.WORKORDER_NDX6
-- Generated 3/10/2006 17:22:29 from IFRMAXIMO@prodsede2

CREATE INDEX ifrmaximo.workorder_ndx6 ON ifrmaximo.workorder
  (
    siteid                          ASC,
    respondby                       ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
  TABLESPACE  tsi_maximo
  STORAGE   (
    INITIAL     65536
    MINEXTENTS  1
    MAXEXTENTS  2147483645
  )
/


-- End of DDL Script for Index IFRMAXIMO.WORKORDER_NDX6

-- Start of DDL Script for Index IFRMAXIMO.WORKORDER_NDX7
-- Generated 3/10/2006 17:22:29 from IFRMAXIMO@prodsede2

CREATE INDEX ifrmaximo.workorder_ndx7 ON ifrmaximo.workorder
  (
    siteid                          ASC,
    eqnum                           ASC,
    problemcode                     ASC,
    status                          ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
  TABLESPACE  tsi_maximo
  STORAGE   (
    INITIAL     65536
    MINEXTENTS  1
    MAXEXTENTS  2147483645
  )
/


-- End of DDL Script for Index IFRMAXIMO.WORKORDER_NDX7

-- Start of DDL Script for Index IFRMAXIMO.WORKORDER_NDX8
-- Generated 3/10/2006 17:22:29 from IFRMAXIMO@prodsede2

CREATE INDEX ifrmaximo.workorder_ndx8 ON ifrmaximo.workorder
  (
    siteid                          ASC,
    jpnum                           ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
  TABLESPACE  tsi_maximo
  STORAGE   (
    INITIAL     65536
    MINEXTENTS  1
    MAXEXTENTS  2147483645
  )
/


-- End of DDL Script for Index IFRMAXIMO.WORKORDER_NDX8

-- Start of DDL Script for Index IFRMAXIMO.WORKORDER_NDX9
-- Generated 3/10/2006 17:22:30 from IFRMAXIMO@prodsede2

CREATE INDEX ifrmaximo.workorder_ndx9 ON ifrmaximo.workorder
  (
    siteid                          ASC,
    location                        ASC,
    problemcode                     ASC,
    status                          ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
  TABLESPACE  tsi_maximo
  STORAGE   (
    INITIAL     65536
    MINEXTENTS  1
    MAXEXTENTS  2147483645
  )
/


-- End of DDL Script for Index IFRMAXIMO.WORKORDER_NDX9

-- Start of DDL Script for Index IFRMAXIMO.WORKORDER_TEMP
-- Generated 3/10/2006 17:22:30 from IFRMAXIMO@prodsede2

CREATE INDEX ifrmaximo.workorder_temp ON ifrmaximo.workorder_bkp
  (
    siteid                          ASC,
    status                          ASC,
    statusdate                      ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
  TABLESPACE  tsi_maximo
  STORAGE   (
    INITIAL     65536
    MINEXTENTS  1
    MAXEXTENTS  2147483645
  )
/


-- End of DDL Script for Index IFRMAXIMO.WORKORDER_TEMP

-- Start of DDL Script for Index IFRMAXIMO.WORKPERIOD_NDX1
-- Generated 3/10/2006 17:22:30 from IFRMAXIMO@prodsede2

CREATE UNIQUE INDEX ifrmaximo.workperiod_ndx1 ON ifrmaximo.workperiod
  (
    siteid                          ASC,
    calnum                          ASC,
    workdate                        ASC,
    shiftnum                        ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
  TABLESPACE  tsi_maximo
  STORAGE   (
    INITIAL     65536
    MINEXTENTS  1
    MAXEXTENTS  2147483645
  )
/


-- End of DDL Script for Index IFRMAXIMO.WORKPERIOD_NDX1

-- Start of DDL Script for Index IFRMAXIMO.WORKPERIOD_NDX2
-- Generated 3/10/2006 17:22:30 from IFRMAXIMO@prodsede2

CREATE INDEX ifrmaximo.workperiod_ndx2 ON ifrmaximo.workperiod
  (
    siteid                          ASC,
    workdate                        ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
  TABLESPACE  tsi_maximo
  STORAGE   (
    INITIAL     65536
    MINEXTENTS  1
    MAXEXTENTS  2147483645
  )
/


-- End of DDL Script for Index IFRMAXIMO.WORKPERIOD_NDX2

-- Start of DDL Script for Index IFRMAXIMO.WORKPERIOD_NDX3
-- Generated 3/10/2006 17:22:30 from IFRMAXIMO@prodsede2

CREATE INDEX ifrmaximo.workperiod_ndx3 ON ifrmaximo.workperiod
  (
    siteid                          ASC,
    shiftnum                        ASC,
    workdate                        ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
  TABLESPACE  tsi_maximo
  STORAGE   (
    INITIAL     65536
    MINEXTENTS  1
    MAXEXTENTS  2147483645
  )
/


-- End of DDL Script for Index IFRMAXIMO.WORKPERIOD_NDX3

-- Start of DDL Script for Index IFRMAXIMO.WORKPRIORITY_NDX1
-- Generated 3/10/2006 17:22:30 from IFRMAXIMO@prodsede2

CREATE UNIQUE INDEX ifrmaximo.workpriority_ndx1 ON ifrmaximo.workpriority
  (
    siteid                          ASC,
    priority                        ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
  TABLESPACE  tsi_maximo
  STORAGE   (
    INITIAL     65536
    MINEXTENTS  1
    MAXEXTENTS  2147483645
  )
/


-- End of DDL Script for Index IFRMAXIMO.WORKPRIORITY_NDX1

-- Start of DDL Script for Index IFRMAXIMO.WORKTYPE_NDX1
-- Generated 3/10/2006 17:22:31 from IFRMAXIMO@prodsede2

CREATE UNIQUE INDEX ifrmaximo.worktype_ndx1 ON ifrmaximo.worktype
  (
    orgid                           ASC,
    worktype                        ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
  TABLESPACE  tsi_maximo
  STORAGE   (
    INITIAL     65536
    MINEXTENTS  1
    MAXEXTENTS  2147483645
  )
/


-- End of DDL Script for Index IFRMAXIMO.WORKTYPE_NDX1

-- Start of DDL Script for Index IFRMAXIMO.WOSAFETYLINK_NDX1
-- Generated 3/10/2006 17:22:31 from IFRMAXIMO@prodsede2

CREATE UNIQUE INDEX ifrmaximo.wosafetylink_ndx1 ON ifrmaximo.wosafetylink
  (
    siteid                          ASC,
    wosafetylinkid                  ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
  TABLESPACE  tsi_maximo
  STORAGE   (
    INITIAL     65536
    MINEXTENTS  1
    MAXEXTENTS  2147483645
  )
/


-- End of DDL Script for Index IFRMAXIMO.WOSAFETYLINK_NDX1

-- Start of DDL Script for Index IFRMAXIMO.WOSAFETYLINK_NDX2
-- Generated 3/10/2006 17:22:31 from IFRMAXIMO@prodsede2

CREATE INDEX ifrmaximo.wosafetylink_ndx2 ON ifrmaximo.wosafetylink
  (
    siteid                          ASC,
    wonum                           ASC,
    applyseq                        ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
  TABLESPACE  tsi_maximo
  STORAGE   (
    INITIAL     65536
    MINEXTENTS  1
    MAXEXTENTS  2147483645
  )
/


-- End of DDL Script for Index IFRMAXIMO.WOSAFETYLINK_NDX2

-- Start of DDL Script for Index IFRMAXIMO.WOSAFETYPLAN_NDX1
-- Generated 3/10/2006 17:22:31 from IFRMAXIMO@prodsede2

CREATE UNIQUE INDEX ifrmaximo.wosafetyplan_ndx1 ON ifrmaximo.wosafetyplan
  (
    siteid                          ASC,
    wonum                           ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
  TABLESPACE  tsi_maximo
  STORAGE   (
    INITIAL     65536
    MINEXTENTS  1
    MAXEXTENTS  2147483645
  )
/


-- End of DDL Script for Index IFRMAXIMO.WOSAFETYPLAN_NDX1

-- Start of DDL Script for Index IFRMAXIMO.WOSCHEDACT_NDX1
-- Generated 3/10/2006 17:22:31 from IFRMAXIMO@prodsede2

CREATE UNIQUE INDEX ifrmaximo.woschedact_ndx1 ON ifrmaximo.woschedactivity
  (
    siteid                          ASC,
    projectname                     ASC,
    woschedactivityid               ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
  TABLESPACE  tsi_maximo
  STORAGE   (
    INITIAL     65536
    MINEXTENTS  1
    MAXEXTENTS  2147483645
  )
/


-- End of DDL Script for Index IFRMAXIMO.WOSCHEDACT_NDX1

-- Start of DDL Script for Index IFRMAXIMO.WOSTATUS_NDX1
-- Generated 3/10/2006 17:22:31 from IFRMAXIMO@prodsede2

CREATE INDEX ifrmaximo.wostatus_ndx1 ON ifrmaximo.wostatus
  (
    siteid                          ASC,
    changedate                      ASC,
    wonum                           ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
  TABLESPACE  tsi_maximo
  STORAGE   (
    INITIAL     65536
    MINEXTENTS  1
    MAXEXTENTS  2147483645
  )
/


-- End of DDL Script for Index IFRMAXIMO.WOSTATUS_NDX1

-- Start of DDL Script for Index IFRMAXIMO.WOSTATUS_NDX2
-- Generated 3/10/2006 17:22:32 from IFRMAXIMO@prodsede2

CREATE INDEX ifrmaximo.wostatus_ndx2 ON ifrmaximo.wostatus
  (
    siteid                          ASC,
    wonum                           ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
  TABLESPACE  tsi_maximo
  STORAGE   (
    INITIAL     65536
    MINEXTENTS  1
    MAXEXTENTS  2147483645
  )
/


-- End of DDL Script for Index IFRMAXIMO.WOSTATUS_NDX2

-- Start of DDL Script for Index IFRMAXIMO.WOSTATUS_NDX3
-- Generated 3/10/2006 17:22:32 from IFRMAXIMO@prodsede2

CREATE INDEX ifrmaximo.wostatus_ndx3 ON ifrmaximo.wostatus
  (
    siteid                          ASC,
    status                          ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
  TABLESPACE  tsi_maximo
  STORAGE   (
    INITIAL     65536
    MINEXTENTS  1
    MAXEXTENTS  2147483645
  )
/


-- End of DDL Script for Index IFRMAXIMO.WOSTATUS_NDX3

-- Start of DDL Script for Index IFRMAXIMO.WOTAGLOCK_NDX1
-- Generated 3/10/2006 17:22:32 from IFRMAXIMO@prodsede2

CREATE UNIQUE INDEX ifrmaximo.wotaglock_ndx1 ON ifrmaximo.wotaglock
  (
    siteid                          ASC,
    taglockid                       ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
  TABLESPACE  tsi_maximo
  STORAGE   (
    INITIAL     65536
    MINEXTENTS  1
    MAXEXTENTS  2147483645
  )
/


-- End of DDL Script for Index IFRMAXIMO.WOTAGLOCK_NDX1

-- Start of DDL Script for Index IFRMAXIMO.WOTAGLOCK_NDX2
-- Generated 3/10/2006 17:22:32 from IFRMAXIMO@prodsede2

CREATE INDEX ifrmaximo.wotaglock_ndx2 ON ifrmaximo.wotaglock
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
  TABLESPACE  tsi_maximo
  STORAGE   (
    INITIAL     65536
    MINEXTENTS  1
    MAXEXTENTS  2147483645
  )
/


-- End of DDL Script for Index IFRMAXIMO.WOTAGLOCK_NDX2

-- Start of DDL Script for Index IFRMAXIMO.WOTAGLOCK_NDX3
-- Generated 3/10/2006 17:22:32 from IFRMAXIMO@prodsede2

CREATE INDEX ifrmaximo.wotaglock_ndx3 ON ifrmaximo.wotaglock
  (
    siteid                          ASC,
    wonum                           ASC,
    tagoutid                        ASC,
    applyseq                        ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
  TABLESPACE  tsi_maximo
  STORAGE   (
    INITIAL     65536
    MINEXTENTS  1
    MAXEXTENTS  2147483645
  )
/


-- End of DDL Script for Index IFRMAXIMO.WOTAGLOCK_NDX3

-- Start of DDL Script for Index IFRMAXIMO.WOTAGOUT_NDX1
-- Generated 3/10/2006 17:22:32 from IFRMAXIMO@prodsede2

CREATE UNIQUE INDEX ifrmaximo.wotagout_ndx1 ON ifrmaximo.wotagout
  (
    siteid                          ASC,
    wonum                           ASC,
    tagoutid                        ASC,
    wosafetydatasource              ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
  TABLESPACE  tsi_maximo
  STORAGE   (
    INITIAL     65536
    MINEXTENTS  1
    MAXEXTENTS  2147483645
  )
/


-- End of DDL Script for Index IFRMAXIMO.WOTAGOUT_NDX1

-- Start of DDL Script for Index IFRMAXIMO.WPEDITSETTING_NDX1
-- Generated 3/10/2006 17:22:33 from IFRMAXIMO@prodsede2

CREATE UNIQUE INDEX ifrmaximo.wpeditsetting_ndx1 ON ifrmaximo.wpeditsetting
  (
    orgid                           ASC,
    status                          ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
  TABLESPACE  tsi_maximo
  STORAGE   (
    INITIAL     65536
    MINEXTENTS  1
    MAXEXTENTS  2147483645
  )
/


-- End of DDL Script for Index IFRMAXIMO.WPEDITSETTING_NDX1

-- Start of DDL Script for Index IFRMAXIMO.WPLABOR_NDX1
-- Generated 3/10/2006 17:22:33 from IFRMAXIMO@prodsede2

CREATE UNIQUE INDEX ifrmaximo.wplabor_ndx1 ON ifrmaximo.wplabor
  (
    siteid                          ASC,
    wonum                           ASC,
    wplaborid                       ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
  TABLESPACE  tsi_maximo
  STORAGE   (
    INITIAL     65536
    MINEXTENTS  1
    MAXEXTENTS  2147483645
  )
/


-- End of DDL Script for Index IFRMAXIMO.WPLABOR_NDX1

-- Start of DDL Script for Index IFRMAXIMO.WPLABOR_NDX2
-- Generated 3/10/2006 17:22:33 from IFRMAXIMO@prodsede2

CREATE INDEX ifrmaximo.wplabor_ndx2 ON ifrmaximo.wplabor
  (
    siteid                          ASC,
    wonum                           ASC,
    laborcode                       ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
  TABLESPACE  tsi_maximo
  STORAGE   (
    INITIAL     65536
    MINEXTENTS  1
    MAXEXTENTS  2147483645
  )
/


-- End of DDL Script for Index IFRMAXIMO.WPLABOR_NDX2

-- Start of DDL Script for Index IFRMAXIMO.WPMATERIAL_NDX1
-- Generated 3/10/2006 17:22:33 from IFRMAXIMO@prodsede2

CREATE INDEX ifrmaximo.wpmaterial_ndx1 ON ifrmaximo.wpmaterial
  (
    siteid                          ASC,
    wonum                           ASC,
    itemnum                         ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
  TABLESPACE  tsi_maximo
  STORAGE   (
    INITIAL     65536
    MINEXTENTS  1
    MAXEXTENTS  2147483645
  )
/


-- End of DDL Script for Index IFRMAXIMO.WPMATERIAL_NDX1

-- Start of DDL Script for Index IFRMAXIMO.WPTOOL_NDX1
-- Generated 3/10/2006 17:22:33 from IFRMAXIMO@prodsede2

CREATE INDEX ifrmaximo.wptool_ndx1 ON ifrmaximo.wptool
  (
    siteid                          ASC,
    wonum                           ASC,
    toolnum                         ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
  TABLESPACE  tsi_maximo
  STORAGE   (
    INITIAL     65536
    MINEXTENTS  1
    MAXEXTENTS  2147483645
  )
/


-- End of DDL Script for Index IFRMAXIMO.WPTOOL_NDX1

