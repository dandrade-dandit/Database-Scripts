
CREATE INDEX wohistorico_ndx17 ON wohistorico
  (
    ldkey                           ASC
  )
  PCTFREE     0
  INITRANS    2
  MAXTRANS    255
  TABLESPACE  tsd_indice
  STORAGE   (
    INITIAL     65536
    MINEXTENTS  1
    MAXEXTENTS  2147483645
  )
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
  TABLESPACE  tsd_indice
  STORAGE   (
    INITIAL     65536
    MINEXTENTS  1
    MAXEXTENTS  2147483645
  )
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
  TABLESPACE  tsd_indice
  STORAGE   (
    INITIAL     65536
    MINEXTENTS  1
    MAXEXTENTS  2147483645
  )
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
  TABLESPACE  tsd_indice
  STORAGE   (
    INITIAL     65536
    MINEXTENTS  1
    MAXEXTENTS  2147483645
  )
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
  TABLESPACE  tsd_indice
  STORAGE   (
    INITIAL     65536
    MINEXTENTS  1
    MAXEXTENTS  2147483645
  )
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
  TABLESPACE  tsd_indice
  STORAGE   (
    INITIAL     65536
    MINEXTENTS  1
    MAXEXTENTS  2147483645
  )
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
  TABLESPACE  tsd_indice
  STORAGE   (
    INITIAL     65536
    MINEXTENTS  1
    MAXEXTENTS  2147483645
  )
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
  TABLESPACE  tsd_indice
  STORAGE   (
    INITIAL     65536
    MINEXTENTS  1
    MAXEXTENTS  2147483645
  )
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
  TABLESPACE  tsd_indice
  STORAGE   (
    INITIAL     65536
    MINEXTENTS  1
    MAXEXTENTS  2147483645
  )
PARALLEL (DEGREE DEFAULT)
/
CREATE INDEX wohistorico_ndx2 ON wohistorico
  (
    siteid                          ASC,
    status                          ASC
  )
  PCTFREE     0
  INITRANS    2
  MAXTRANS    255
  TABLESPACE  tsd_indice
  STORAGE   (
    INITIAL     65536
    MINEXTENTS  1
    MAXEXTENTS  2147483645
  )
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
  TABLESPACE  tsd_indice
  STORAGE   (
    INITIAL     65536
    MINEXTENTS  1
    MAXEXTENTS  2147483645
  )
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
  TABLESPACE  tsd_indice
  STORAGE   (
    INITIAL     65536
    MINEXTENTS  1
    MAXEXTENTS  2147483645
  )
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
  TABLESPACE  tsd_indice
  STORAGE   (
    INITIAL     65536
    MINEXTENTS  1
    MAXEXTENTS  2147483645
  )
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
  TABLESPACE  tsd_indice
  STORAGE   (
    INITIAL     65536
    MINEXTENTS  1
    MAXEXTENTS  2147483645
  )
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
  TABLESPACE  tsd_indice
  STORAGE   (
    INITIAL     65536
    MINEXTENTS  1
    MAXEXTENTS  2147483645
  )
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
  TABLESPACE  tsd_indice
  STORAGE   (
    INITIAL     65536
    MINEXTENTS  1
    MAXEXTENTS  2147483645
  )
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
  TABLESPACE  tsd_indice
  STORAGE   (
    INITIAL     65536
    MINEXTENTS  1
    MAXEXTENTS  2147483645
  )
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
  TABLESPACE  tsd_indice
  STORAGE   (
    INITIAL     65536
    MINEXTENTS  1
    MAXEXTENTS  2147483645
  )
PARALLEL (DEGREE DEFAULT)
/
