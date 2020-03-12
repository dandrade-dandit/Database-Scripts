DROP INDEX workorder_ndx9 
/

DROP INDEX maxreportdate_idx 
/

DROP INDEX workorder_ndx1
/

DROP INDEX workorder_ndx10
/

DROP INDEX workorder_ndx11
/

DROP INDEX workorder_ndx12
/

DROP INDEX workorder_ndx13
/

DROP INDEX workorder_ndx14
/

DROP INDEX workorder_ndx15
/

DROP INDEX workorder_ndx16
/

DROP INDEX workorder_ndx17
/

DROP INDEX workorder_ndx18
/

DROP INDEX workorder_ndx19
/

DROP INDEX workorder_ndx2
/

DROP INDEX workorder_ndx3
/

DROP INDEX workorder_ndx4
/

DROP INDEX workorder_ndx5
/

DROP INDEX workorder_ndx6
/

DROP INDEX workorder_ndx7
/

DROP INDEX workorder_ndx8
/


DROP TRIGGER tr_aux_os_estatistica
/

DROP TRIGGER tr_calc_os1
/

DROP TRIGGER tr_depe_workorder
/

DROP TRIGGER workorder_t
/

DROP TRIGGER tr_sapios
/

DROP TRIGGER tr_status1
/

DROP TRIGGER tr_sismat1
/

DROP TRIGGER tr_tarefas
/

DROP TRIGGER tr_is_eq_wo
/

DROP TRIGGER tr_comp
/

DROP TRIGGER trg_indisptotal_after
/

DROP TRIGGER trg_linha_indisponibilidade
/

RENAME workorder TO workorder_bkp
/

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
    wopriority                     NUMBER(*,0),
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
    woeq7                          VARCHAR2(16),
    woeq8                          VARCHAR2(3),
    woeq9                          VARCHAR2(25),
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
    ldkey                          NUMBER(*,0),
    reportedby                     VARCHAR2(18),
    reportdate                     DATE,
    phone                          VARCHAR2(20),
    problemcode                    VARCHAR2(9),
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
    eqlocpriority                  NUMBER(*,0),
    calcpriority                   NUMBER(*,0),
    chargestore                    VARCHAR2(1) NOT NULL,
    failurecode                    VARCHAR2(9),
    wolo1                          VARCHAR2(10),
    wolo2                          VARCHAR2(10),
    wolo3                          VARCHAR2(10),
    wolo4                          VARCHAR2(25),
    wolo5                          VARCHAR2(25),
    wolo6                          NUMBER(10,2),
    wolo7                          DATE,
    wolo8                          NUMBER(15,2),
    wolo9                          VARCHAR2(10),
    wolo10                         NUMBER(*,0),
    glaccount                      VARCHAR2(20),
    estservcost                    NUMBER(10,2) NOT NULL,
    actservcost                    NUMBER(10,2) NOT NULL,
    disabled                       VARCHAR2(1) NOT NULL,
    estatapprlabhrs                FLOAT(126) NOT NULL,
    estatapprlabcost               NUMBER(10,2) NOT NULL,
    estatapprmatcost               NUMBER(10,2) NOT NULL,
    estatapprtoolcost              NUMBER(10,2) NOT NULL,
    estatapprservcost              NUMBER(10,2) NOT NULL,
    wosequence                     NUMBER(*,0),
    hasfollowupwork                VARCHAR2(1) NOT NULL,
    worts1                         VARCHAR2(10),
    worts2                         VARCHAR2(10),
    worts3                         VARCHAR2(10),
    worts4                         DATE,
    worts5                         NUMBER(15,2),
    wfid                           NUMBER(*,0),
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
    wo13                           DATE,
    wo14                           DATE,
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
    genforpolineid                 NUMBER(*,0),
    orgid                          VARCHAR2(8) NOT NULL,
    siteid                         VARCHAR2(8) NOT NULL,
    taskid                         NUMBER(*,0),
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
    istask                         VARCHAR2(1) NOT NULL,
    wo30                           DATE,
    wo31                           DATE)
/


