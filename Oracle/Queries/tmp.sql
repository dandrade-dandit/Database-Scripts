CREATE INDEX temp_workorder ON workorder
  (
    ldkey                           ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
  TABLESPACE  tsd_indice
  STORAGE   (
    INITIAL     65536
    MINEXTENTS  1
    MAXEXTENTS  2147483645
  )
  local (partition temp_workorder_1 tablespace tsd_indice
,  	partition temp_workorder_2 tablespace tsd_indice
,  	partition temp_workorder_3 tablespace tsd_indice
,  	partition temp_workorder_4 tablespace tsd_indice
,  	partition temp_workorder_5 tablespace tsd_indice)
/

CREATE INDEX workorder_ndx11 ON workorder
  (
    wopm7                           ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
  TABLESPACE  tsd_indice
  STORAGE   (
    INITIAL     65536
    MINEXTENTS  1
    MAXEXTENTS  2147483645
  )
PARALLEL (DEGREE DEFAULT)
  local (partition workorder_ndx11_1 tablespace tsd_indice
,  	partition workorder_ndx11_2 tablespace tsd_indice
,  	partition workorder_ndx11_3 tablespace tsd_indice
,  	partition workorder_ndx11_4 tablespace tsd_indice
,  	partition workorder_ndx11_5 tablespace tsd_indice)
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
  TABLESPACE  tsd_indice
  STORAGE   (
    INITIAL     65536
    MINEXTENTS  1
    MAXEXTENTS  2147483645
  )
PARALLEL (DEGREE DEFAULT)
  local (partition workorder_ndx12_1 tablespace tsd_indice
,  	partition workorder_ndx12_2 tablespace tsd_indice
,  	partition workorder_ndx12_3 tablespace tsd_indice
,  	partition workorder_ndx12_4 tablespace tsd_indice
,  	partition workorder_ndx12_5 tablespace tsd_indice)
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
  TABLESPACE  tsd_indice
  STORAGE   (
    INITIAL     65536
    MINEXTENTS  1
    MAXEXTENTS  2147483645
  )
PARALLEL (DEGREE DEFAULT)
  local (partition workorder_ndx13_1 tablespace tsd_indice
,  	partition workorder_ndx13_2 tablespace tsd_indice
,  	partition workorder_ndx13_3 tablespace tsd_indice
,  	partition workorder_ndx13_4 tablespace tsd_indice
,  	partition workorder_ndx13_5 tablespace tsd_indice)
/

CREATE INDEX workorder_ndx10 ON workorder
  (
    parent                          ASC,
    siteid                          ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
  TABLESPACE  tsd_indice
  STORAGE   (
    INITIAL     65536
    MINEXTENTS  1
    MAXEXTENTS  2147483645
  )
  local (partition workorder_ndx10_1 tablespace tsd_indice
,  	partition workorder_ndx10_2 tablespace tsd_indice
,  	partition workorder_ndx10_3 tablespace tsd_indice
,  	partition workorder_ndx10_4 tablespace tsd_indice
,  	partition workorder_ndx10_5 tablespace tsd_indice)
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
  TABLESPACE  tsd_indice
  STORAGE   (
    INITIAL     65536
    MINEXTENTS  1
    MAXEXTENTS  2147483645
  )
PARALLEL (DEGREE DEFAULT)
  local (partition workorder_ndx14_1 tablespace tsd_indice
,  	partition workorder_ndx14_2 tablespace tsd_indice
,  	partition workorder_ndx14_3 tablespace tsd_indice
,  	partition workorder_ndx14_4 tablespace tsd_indice
,  	partition workorder_ndx14_5 tablespace tsd_indice)
/

CREATE INDEX workorder_ndx15 ON workorder
  (
    wopm6                           ASC,
    siteid                          ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
  TABLESPACE  tsd_indice
  STORAGE   (
    INITIAL     65536
    MINEXTENTS  1
    MAXEXTENTS  2147483645
  )
  local (partition workorder_ndx15_1 tablespace tsd_indice
,  	partition workorder_ndx15_2 tablespace tsd_indice
,  	partition workorder_ndx15_3 tablespace tsd_indice
,  	partition workorder_ndx15_4 tablespace tsd_indice
,  	partition workorder_ndx15_5 tablespace tsd_indice)
/

CREATE UNIQUE INDEX workorder_ndx1 ON workorder
  (
    siteid                          ASC,
    wonum                           ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
  TABLESPACE  tsd_indice
  STORAGE   (
    INITIAL     65536
    MINEXTENTS  1
    MAXEXTENTS  2147483645
  )
  local (partition workorder_ndx1_1 tablespace tsd_indice
,  	partition workorder_ndx1_2 tablespace tsd_indice
,  	partition workorder_ndx1_3 tablespace tsd_indice
,  	partition workorder_ndx1_4 tablespace tsd_indice
,  	partition workorder_ndx1_5 tablespace tsd_indice)
/

CREATE INDEX workorder_ndx2 ON workorder
  (
    siteid                          ASC,
    status                          ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
  TABLESPACE  tsd_indice
  STORAGE   (
    INITIAL     65536
    MINEXTENTS  1
    MAXEXTENTS  2147483645
  )
  local (partition workorder_ndx2_1 tablespace tsd_indice
,  	partition workorder_ndx2_2 tablespace tsd_indice
,  	partition workorder_ndx2_3 tablespace tsd_indice
,  	partition workorder_ndx2_4 tablespace tsd_indice
,  	partition workorder_ndx2_5 tablespace tsd_indice)
/

CREATE INDEX workorder_ndx3 ON workorder
  (
    siteid                          ASC,
    historyflag                     ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
  TABLESPACE  tsd_indice
  STORAGE   (
    INITIAL     65536
    MINEXTENTS  1
    MAXEXTENTS  2147483645
  )
  local (partition workorder_ndx3_1 tablespace tsd_indice
,  	partition workorder_ndx3_2 tablespace tsd_indice
,  	partition workorder_ndx3_3 tablespace tsd_indice
,  	partition workorder_ndx3_4 tablespace tsd_indice
,  	partition workorder_ndx3_5 tablespace tsd_indice)
/

CREATE INDEX workorder_ndx4 ON workorder
  (
    siteid                          ASC,
    interid                         ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
  TABLESPACE  tsd_indice
  STORAGE   (
    INITIAL     65536
    MINEXTENTS  1
    MAXEXTENTS  2147483645
  )
  local (partition workorder_ndx4_1 tablespace tsd_indice
,  	partition workorder_ndx4_2 tablespace tsd_indice
,  	partition workorder_ndx4_3 tablespace tsd_indice
,  	partition workorder_ndx4_4 tablespace tsd_indice
,  	partition workorder_ndx4_5 tablespace tsd_indice)
/

CREATE INDEX workorder_ndx5 ON workorder
  (
    siteid                          ASC,
    wfid                            ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
  TABLESPACE  tsd_indice
  STORAGE   (
    INITIAL     65536
    MINEXTENTS  1
    MAXEXTENTS  2147483645
  )
 local (partition workorder_ndx5_1 tablespace tsd_indice
,  	partition workorder_ndx5_2 tablespace tsd_indice
,  	partition workorder_ndx5_3 tablespace tsd_indice
,  	partition workorder_ndx5_4 tablespace tsd_indice
,  	partition workorder_ndx5_5 tablespace tsd_indice)
/

CREATE INDEX workorder_ndx6 ON workorder
  (
    siteid                          ASC,
    respondby                       ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
  TABLESPACE  tsd_indice
  STORAGE   (
    INITIAL     65536
    MINEXTENTS  1
    MAXEXTENTS  2147483645
  )
  local (partition workorder_ndx6_1 tablespace tsd_indice
,  	partition workorder_ndx6_2 tablespace tsd_indice
,  	partition workorder_ndx6_3 tablespace tsd_indice
,  	partition workorder_ndx6_4 tablespace tsd_indice
,  	partition workorder_ndx6_5 tablespace tsd_indice)
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
  TABLESPACE  tsd_indice
  STORAGE   (
    INITIAL     65536
    MINEXTENTS  1
    MAXEXTENTS  2147483645
  )
  local (partition workorder_ndx7_1 tablespace tsd_indice
,  	partition workorder_ndx7_2 tablespace tsd_indice
,  	partition workorder_ndx7_3 tablespace tsd_indice
,  	partition workorder_ndx7_4 tablespace tsd_indice
,  	partition workorder_ndx7_5 tablespace tsd_indice)
/

/*CREATE INDEX workorder_ndx8 ON workorder
  (
    siteid                          ASC,
    jpnum                           ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
  TABLESPACE  tsd_indice
  STORAGE   (
    INITIAL     65536
    MINEXTENTS  1
    MAXEXTENTS  2147483645
  )
  local (partition workorder_ndx8_1 tablespace tsd_indice
,  	partition workorder_ndx8_2 tablespace tsd_indice
,  	partition workorder_ndx8_3 tablespace tsd_indice
,  	partition workorder_ndx8_4 tablespace tsd_indice
,  	partition workorder_ndx8_5 tablespace tsd_indice)
*/

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
  TABLESPACE  tsd_indice
  STORAGE   (
    INITIAL     65536
    MINEXTENTS  1
    MAXEXTENTS  2147483645
  )
    local (partition workorder_ndx9_1 tablespace tsd_indice
,  	partition workorder_ndx9_2 tablespace tsd_indice
,  	partition workorder_ndx9_3 tablespace tsd_indice
,  	partition workorder_ndx9_4 tablespace tsd_indice
,  	partition workorder_ndx9_5 tablespace tsd_indice)
/
