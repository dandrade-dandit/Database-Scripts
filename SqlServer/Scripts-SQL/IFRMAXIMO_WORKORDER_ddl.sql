-- Start of DDL Script for Table IFRMAXIMO.WORKORDER
-- Generated 25-mar-2010 17:07:13 from IFRMAXIMO@PRODSEDE2
/*
CREATE TABLE workorder_temp
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
    wolo1                          VARCHAR2(16),
    wolo2                          VARCHAR2(16),
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
    wo31                           DATE,
    wo32                           VARCHAR2(15),
    wo33                           VARCHAR2(10),
    wo34                           VARCHAR2(40),
    wo35                           DATE,
    wo36                           VARCHAR2(40),
    wo37                           VARCHAR2(30),
    wo38                           VARCHAR2(30),
    wo39                           DATE,
    wo40                           VARCHAR2(10),
    wo41                           VARCHAR2(20),
    wo42                           VARCHAR2(10),
    wo43                           VARCHAR2(30),
    wo44                           VARCHAR2(30),
    wo45                           VARCHAR2(30),
    wo46                           VARCHAR2(20),
    wo47                           VARCHAR2(80),
    wo48                           VARCHAR2(25),
    wo49                           VARCHAR2(20),
    wo50                           VARCHAR2(20),
    wo51                           VARCHAR2(80),
    wo52                           VARCHAR2(20),
    wo53                           VARCHAR2(40),
    wo54                           VARCHAR2(25),
    wo55                           DATE,
    wo56                           VARCHAR2(20),
    wo57                           VARCHAR2(80),
    wo58                           VARCHAR2(25),
    wo59                           VARCHAR2(25),
    wo60                           VARCHAR2(254),
    wo61                           VARCHAR2(250),
    wo62                           VARCHAR2(1) DEFAULT 'N',
    wo63                           VARCHAR2(1) DEFAULT 'N',
    wo64                           NUMBER(*,0),
    wo65                           NUMBER(15,2),
    wo66                           NUMBER(10,2),
    wo67                           NUMBER(10,2),
    wo68                           NUMBER(10,2),
    wo69                           NUMBER(10,2),
    wo70                           VARCHAR2(50),
    woeq72                         NUMBER(15,2),
    totalrateio                    FLOAT(126),
    wo71                           NUMBER(10,2),
    wo72                           VARCHAR2(30),
    wo73                           VARCHAR2(25),
    wo74                           VARCHAR2(25),
    check_01                       VARCHAR2(1),
    check_02                       VARCHAR2(1),
    wo75                           FLOAT(126) DEFAULT 0,
    wo76                           VARCHAR2(20),
    wo77                           VARCHAR2(20))
  PCTFREE     10
  PCTUSED     40
  INITRANS    2
  MAXTRANS    255
  TABLESPACE  tsd_maximo
/

*/

-- Grants for Table
GRANT INSERT ON workorder TO integracao
/
GRANT SELECT ON workorder TO integracao
/
GRANT SELECT ON workorder TO c0001305
/
GRANT SELECT ON workorder TO c000479
/
GRANT SELECT ON workorder TO c000514
/
GRANT SELECT ON workorder TO c0005907
/
GRANT SELECT ON workorder TO c002
/
GRANT SELECT ON workorder TO c003
/
GRANT SELECT ON workorder TO c004
/
GRANT SELECT ON workorder TO c0041901
/
GRANT SELECT ON workorder TO c005
/
GRANT SELECT ON workorder TO c00602
/
GRANT SELECT ON workorder TO c00613
/
GRANT SELECT ON workorder TO c0091207
/
GRANT SELECT ON workorder TO c0182105
/
GRANT SELECT ON workorder TO c0197405
/
GRANT SELECT ON workorder TO c0212806
/
GRANT SELECT ON workorder TO c0346606
/
GRANT SELECT ON workorder TO c04148858728
/
GRANT SELECT ON workorder TO c050235174
/
GRANT SELECT ON workorder TO c0579202
/
GRANT SELECT ON workorder TO c0653216939
/
GRANT SELECT ON workorder TO c0728384000
/
GRANT SELECT ON workorder TO c07512824726
/
GRANT SELECT ON workorder TO c0799300
/
GRANT SELECT ON workorder TO c0830677364
/
GRANT SELECT ON workorder TO c0852640080
/
GRANT SELECT ON workorder TO c0872254763
/
GRANT SELECT ON workorder TO c0883404060
/
GRANT SELECT ON workorder TO c090306
/
GRANT SELECT ON workorder TO c0907511759
/
GRANT SELECT ON workorder TO c0927272555
/
GRANT SELECT ON workorder TO c0958105529
/
GRANT SELECT ON workorder TO c1019201
/
GRANT DELETE ON workorder TO c103409090
/
GRANT SELECT ON workorder TO c103409090
/
GRANT UPDATE ON workorder TO c103409090
/
GRANT SELECT ON workorder TO c1144966094
/
GRANT SELECT ON workorder TO c12345
/
GRANT SELECT ON workorder TO c12345678
/
GRANT SELECT ON workorder TO c12346
/
GRANT SELECT ON workorder TO c12347
/
GRANT SELECT ON workorder TO c12348
/
GRANT SELECT ON workorder TO c12349
/
GRANT SELECT ON workorder TO c12350
/
GRANT SELECT ON workorder TO c12352
/
GRANT SELECT ON workorder TO c12353
/
GRANT SELECT ON workorder TO c12354
/
GRANT SELECT ON workorder TO c12355
/
GRANT SELECT ON workorder TO c12356
/
GRANT SELECT ON workorder TO c12357
/
GRANT SELECT ON workorder TO c12358
/
GRANT SELECT ON workorder TO c12359
/
GRANT SELECT ON workorder TO c12360
/
GRANT SELECT ON workorder TO c12361
/
GRANT SELECT ON workorder TO c12362
/
GRANT SELECT ON workorder TO c12363
/
GRANT SELECT ON workorder TO c12364
/
GRANT SELECT ON workorder TO c12365
/
GRANT SELECT ON workorder TO c12366
/
GRANT SELECT ON workorder TO c12367
/
GRANT SELECT ON workorder TO c12368
/
GRANT SELECT ON workorder TO c140725034
/
GRANT SELECT ON workorder TO c1524961
/
GRANT SELECT ON workorder TO c1530104
/
GRANT SELECT ON workorder TO c1666499
/
GRANT SELECT ON workorder TO c1754504
/
GRANT SELECT ON workorder TO c1807405
/
GRANT SELECT ON workorder TO c1854005
/
GRANT SELECT ON workorder TO c1876005
/
GRANT SELECT ON workorder TO c194944968
/
GRANT SELECT ON workorder TO c1961123
/
GRANT SELECT ON workorder TO c1972
/
GRANT SELECT ON workorder TO c2006197
/
GRANT SELECT ON workorder TO c2033024
/
GRANT SELECT ON workorder TO c2045768
/
GRANT SELECT ON workorder TO c2068
/
GRANT SELECT ON workorder TO c2354241
/
GRANT SELECT ON workorder TO c2515844
/
GRANT SELECT ON workorder TO c2532686
/
GRANT SELECT ON workorder TO c2624549
/
GRANT SELECT ON workorder TO c2657983
/
GRANT SELECT ON workorder TO c2667787
/
GRANT SELECT ON workorder TO c2781181
/
GRANT SELECT ON workorder TO c2844322
/
GRANT SELECT ON workorder TO c288161
/
GRANT DELETE ON workorder TO c3000143
/
GRANT SELECT ON workorder TO c3000143
/
GRANT UPDATE ON workorder TO c3000143
/
GRANT SELECT ON workorder TO c3238785
/
GRANT SELECT ON workorder TO c43719092
/
GRANT SELECT ON workorder TO c4814516
/
GRANT SELECT ON workorder TO c4883274
/
GRANT SELECT ON workorder TO c4945101
/
GRANT SELECT ON workorder TO c514314960
/
GRANT SELECT ON workorder TO c5209102
/
GRANT SELECT ON workorder TO c5303089
/
GRANT SELECT ON workorder TO c5388553
/
GRANT SELECT ON workorder TO c5420202
/
GRANT SELECT ON workorder TO c5603336
/
GRANT SELECT ON workorder TO c5897204
/
GRANT SELECT ON workorder TO c5905746
/
GRANT SELECT ON workorder TO c5940702
/
GRANT SELECT ON workorder TO c5973844
/
GRANT SELECT ON workorder TO c6082141
/
GRANT SELECT ON workorder TO c6350288
/
GRANT SELECT ON workorder TO c64731
/
GRANT SELECT ON workorder TO c65032
/
GRANT SELECT ON workorder TO c679098843
/
GRANT SELECT ON workorder TO c6881328
/
GRANT SELECT ON workorder TO c6910435
/
GRANT SELECT ON workorder TO c710467203
/
GRANT SELECT ON workorder TO c968150276
/
GRANT SELECT ON workorder TO cacomarcf
/
GRANT SELECT ON workorder TO caraujoabbe
/
GRANT SELECT ON workorder TO caraujobe
/
GRANT SELECT ON workorder TO carclimarf
/
GRANT SELECT ON workorder TO cartmultiplapa
/
GRANT SELECT ON workorder TO catlasgr
/
GRANT SELECT ON workorder TO catlassp
/
GRANT SELECT ON workorder TO cato015kp
/
GRANT SELECT ON workorder TO ccascardigr
/
GRANT SELECT ON workorder TO cchaoverdebe
/
GRANT SELECT ON workorder TO ccorpuskp
/
GRANT SELECT ON workorder TO cctestbe
/
GRANT SELECT ON workorder TO cctmfz
/
GRANT DELETE ON workorder TO cdba143
/
GRANT SELECT ON workorder TO cdba143
/
GRANT UPDATE ON workorder TO cdba143
/
GRANT DELETE ON workorder TO cdba3000143
/
GRANT SELECT ON workorder TO cdba3000143
/
GRANT UPDATE ON workorder TO cdba3000143
/
GRANT DELETE ON workorder TO cdba3143
/
GRANT SELECT ON workorder TO cdba3143
/
GRANT UPDATE ON workorder TO cdba3143
/
GRANT SELECT ON workorder TO cebcmct
/
GRANT SELECT ON workorder TO cejrpa
/
GRANT SELECT ON workorder TO celshadayct
/
GRANT SELECT ON workorder TO cema01
/
GRANT SELECT ON workorder TO cema02
/
GRANT SELECT ON workorder TO cema03
/
GRANT SELECT ON workorder TO cema04
/
GRANT SELECT ON workorder TO cempressgr
/
GRANT SELECT ON workorder TO ceng004kp
/
GRANT SELECT ON workorder TO ceng012kp
/
GRANT SELECT ON workorder TO ceng018kp
/
GRANT SELECT ON workorder TO cenge047kp
/
GRANT SELECT ON workorder TO cengeletgr
/
GRANT SELECT ON workorder TO cengeletricacr
/
GRANT SELECT ON workorder TO cengeletricafz
/
GRANT SELECT ON workorder TO cengeletricagr
/
GRANT SELECT ON workorder TO cengeletricakp
/
GRANT SELECT ON workorder TO cengeletricasp
/
GRANT SELECT ON workorder TO cgebetz
/
GRANT SELECT ON workorder TO cgebetzgr
/
GRANT SELECT ON workorder TO cgicf01
/
GRANT SELECT ON workorder TO cgicf02
/
GRANT SELECT ON workorder TO cgicf03
/
GRANT SELECT ON workorder TO cgicf04
/
GRANT SELECT ON workorder TO cgicf06
/
GRANT SELECT ON workorder TO cgut013kp
/
GRANT SELECT ON workorder TO ciacitgr
/
GRANT SELECT ON workorder TO cicsupplygl
/
GRANT SELECT ON workorder TO cicsupplyrj
/
GRANT SELECT ON workorder TO cinterwaycg
/
GRANT SELECT ON workorder TO cinterwayfz
/
GRANT SELECT ON workorder TO cinterwaygr
/
GRANT SELECT ON workorder TO cjlhsp
/
GRANT SELECT ON workorder TO cmpe005kp
/
GRANT SELECT ON workorder TO cmpe01
/
GRANT SELECT ON workorder TO cmpe011kp
/
GRANT SELECT ON workorder TO cmpe014gr
/
GRANT SELECT ON workorder TO cmpe01sp
/
GRANT SELECT ON workorder TO cmpe02
/
GRANT SELECT ON workorder TO cmpe02sp
/
GRANT SELECT ON workorder TO cmpecr
/
GRANT SELECT ON workorder TO cmperf
/
GRANT SELECT ON workorder TO cmpesp
/
GRANT SELECT ON workorder TO cntkkp
/
GRANT SELECT ON workorder TO conegr
/
GRANT SELECT ON workorder TO cotispa
/
GRANT SELECT ON workorder TO cprnredect
/
GRANT SELECT ON workorder TO cproenvt
/
GRANT SELECT ON workorder TO cprologocf
/
GRANT SELECT ON workorder TO cschefferkp
/
GRANT SELECT ON workorder TO csge003kp
/
GRANT SELECT ON workorder TO csge020kp
/
GRANT SELECT ON workorder TO csgekp
/
GRANT SELECT ON workorder TO csheffergr
/
GRANT SELECT ON workorder TO csipecgr
/
GRANT SELECT ON workorder TO csistemagr
/
GRANT SELECT ON workorder TO csm21gl
/
GRANT SELECT ON workorder TO csuperservmo
/
GRANT SELECT ON workorder TO csuperservrf
/
GRANT SELECT ON workorder TO csupplygr
/
GRANT SELECT ON workorder TO cteamgl
/
GRANT SELECT ON workorder TO ctecnengegl
/
GRANT SELECT ON workorder TO ctecnytcf
/
GRANT SELECT ON workorder TO ctecnytfz
/
GRANT SELECT ON workorder TO ctecnytmecpa
/
GRANT SELECT ON workorder TO ctecnytpa
/
GRANT SELECT ON workorder TO ctecnytsv
/
GRANT SELECT ON workorder TO cthermarbe
/
GRANT DELETE ON workorder TO ctis306
/
GRANT SELECT ON workorder TO ctis306
/
GRANT UPDATE ON workorder TO ctis306
/
GRANT DELETE ON workorder TO ctis620
/
GRANT SELECT ON workorder TO ctis620
/
GRANT UPDATE ON workorder TO ctis620
/
GRANT DELETE ON workorder TO ctis837
/
GRANT SELECT ON workorder TO ctis837
/
GRANT UPDATE ON workorder TO ctis837
/
GRANT SELECT ON workorder TO ctopservice2pa
/
GRANT SELECT ON workorder TO ctopservicecivpa
/
GRANT SELECT ON workorder TO ctopservicepa
/
GRANT SELECT ON workorder TO ctranspolixgr
/
GRANT SELECT ON workorder TO ctrennasv
/
GRANT SELECT ON workorder TO cultratecgr
/
GRANT SELECT ON workorder TO cuniaofz
/
GRANT SELECT ON workorder TO cviatecgr
/
GRANT SELECT ON workorder TO cviateckp
/
GRANT SELECT ON workorder TO cviatecmo
/
GRANT SELECT ON workorder TO cviatecsv
/
GRANT SELECT ON workorder TO daag01
/
GRANT SELECT ON workorder TO daag02
/
GRANT SELECT ON workorder TO daag03
/
GRANT SELECT ON workorder TO daag04
/
GRANT SELECT ON workorder TO daag06
/
GRANT DELETE ON workorder TO daag07
/
GRANT SELECT ON workorder TO daag07
/
GRANT UPDATE ON workorder TO daag07
/
GRANT SELECT ON workorder TO daagcafe
/
GRANT SELECT ON workorder TO daagchaveiro
/
GRANT SELECT ON workorder TO daagchavrepro
/
GRANT SELECT ON workorder TO daaglimpeza
/
GRANT SELECT ON workorder TO daagmanutencao
/
GRANT SELECT ON workorder TO daagmaquinacafe
/
GRANT SELECT ON workorder TO daagreprografia
/
GRANT SELECT ON workorder TO daagtransporte04
/
GRANT SELECT ON workorder TO daagvigilancia
/
GRANT SELECT ON workorder TO damanut03
/
GRANT DELETE ON workorder TO deflt
/
GRANT SELECT ON workorder TO deflt
/
GRANT UPDATE ON workorder TO deflt
/
GRANT SELECT ON workorder TO dema01
/
GRANT SELECT ON workorder TO dema02
/
GRANT SELECT ON workorder TO dema03
/
GRANT SELECT ON workorder TO dema04
/
GRANT DELETE ON workorder TO dema07
/
GRANT SELECT ON workorder TO dema07
/
GRANT UPDATE ON workorder TO dema07
/
GRANT SELECT ON workorder TO i0000000
/
GRANT SELECT ON workorder TO i0001978
/
GRANT SELECT ON workorder TO i0101091
/
GRANT SELECT ON workorder TO i0116268
/
GRANT SELECT ON workorder TO i0137551
/
GRANT SELECT ON workorder TO i0154356
/
GRANT DELETE ON workorder TO i0160658
/
GRANT SELECT ON workorder TO i0160658
/
GRANT UPDATE ON workorder TO i0160658
/
GRANT SELECT ON workorder TO i0163845
/
GRANT SELECT ON workorder TO i0169141
/
GRANT SELECT ON workorder TO i0173155
/
GRANT SELECT ON workorder TO i0174152
/
GRANT SELECT ON workorder TO i0176538
/
GRANT SELECT ON workorder TO i0186436
/
GRANT SELECT ON workorder TO i0189133
/
GRANT SELECT ON workorder TO i0193539
/
GRANT SELECT ON workorder TO i0193931
/
GRANT SELECT ON workorder TO i0196922
/
GRANT SELECT ON workorder TO i0198426
/
GRANT SELECT ON workorder TO i0201478
/
GRANT SELECT ON workorder TO i0205368
/
GRANT SELECT ON workorder TO i0208947
/
GRANT SELECT ON workorder TO i0209650
/
GRANT SELECT ON workorder TO i0215756
/
GRANT SELECT ON workorder TO i0220277
/
GRANT SELECT ON workorder TO i0220669
/
GRANT SELECT ON workorder TO i0240661
/
GRANT SELECT ON workorder TO i0515643
/
GRANT SELECT ON workorder TO i0534638
/
GRANT SELECT ON workorder TO i0539917
/
GRANT SELECT ON workorder TO i0545729
/
GRANT SELECT ON workorder TO i0554238
/
GRANT SELECT ON workorder TO i0566914
/
GRANT SELECT ON workorder TO i0577613
/
GRANT SELECT ON workorder TO i0580042
/
GRANT SELECT ON workorder TO i0583523
/
GRANT SELECT ON workorder TO i0590332
/
GRANT SELECT ON workorder TO i0596020
/
GRANT SELECT ON workorder TO i0598602
/
GRANT SELECT ON workorder TO i0600853
/
GRANT SELECT ON workorder TO i0602357
/
GRANT SELECT ON workorder TO i0603648
/
GRANT SELECT ON workorder TO i0605740
/
GRANT SELECT ON workorder TO i0607440
/
GRANT SELECT ON workorder TO i0608045
/
GRANT SELECT ON workorder TO i0608241
/
GRANT SELECT ON workorder TO i0608339
/
GRANT SELECT ON workorder TO i0608535
/
GRANT SELECT ON workorder TO i0608927
/
GRANT SELECT ON workorder TO i0609140
/
GRANT SELECT ON workorder TO i0609336
/
GRANT SELECT ON workorder TO i0610065
/
GRANT SELECT ON workorder TO i0613448
/
GRANT SELECT ON workorder TO i0618727
/
GRANT SELECT ON workorder TO i0619626
/
GRANT SELECT ON workorder TO i0619822
/
GRANT SELECT ON workorder TO i0622643
/
GRANT SELECT ON workorder TO i0623346
/
GRANT SELECT ON workorder TO i0623444
/
GRANT SELECT ON workorder TO i0624147
/
GRANT SELECT ON workorder TO i0624441
/
GRANT SELECT ON workorder TO i0625438
/
GRANT SELECT ON workorder TO i0627138
/
GRANT SELECT ON workorder TO i0627726
/
GRANT SELECT ON workorder TO i0632835
/
GRANT SELECT ON workorder TO i0643730
/
GRANT SELECT ON workorder TO i0644041
/
GRANT SELECT ON workorder TO i0645136
/
GRANT SELECT ON workorder TO i0646329
/
GRANT SELECT ON workorder TO i0647620
/
GRANT SELECT ON workorder TO i0652533
/
GRANT SELECT ON workorder TO i0655034
/
GRANT SELECT ON workorder TO i0661826
/
GRANT SELECT ON workorder TO i0661924
/
GRANT SELECT ON workorder TO i0662431
/
GRANT SELECT ON workorder TO i0668609
/
GRANT SELECT ON workorder TO i0669018
/
GRANT SELECT ON workorder TO i0670629
/
GRANT SELECT ON workorder TO i0672133
/
GRANT SELECT ON workorder TO i0677118
/
GRANT SELECT ON workorder TO i0677216
/
GRANT SELECT ON workorder TO i0681524
/
GRANT SELECT ON workorder TO i0687408
/
GRANT SELECT ON workorder TO i0687997
/
GRANT SELECT ON workorder TO i0698598
/
GRANT SELECT ON workorder TO i0700358
/
GRANT SELECT ON workorder TO i0707925
/
GRANT SELECT ON workorder TO i0708138
/
GRANT SELECT ON workorder TO i0713835
/
GRANT SELECT ON workorder TO i0718428
/
GRANT SELECT ON workorder TO i0721249
/
GRANT SELECT ON workorder TO i0721347
/
GRANT SELECT ON workorder TO i0727427
/
GRANT SELECT ON workorder TO i0748024
/
GRANT SELECT ON workorder TO i0748808
/
GRANT SELECT ON workorder TO i0751237
/
GRANT SELECT ON workorder TO i0751629
/
GRANT SELECT ON workorder TO i0753525
/
GRANT SELECT ON workorder TO i0757513
/
GRANT SELECT ON workorder TO i0759801
/
GRANT SELECT ON workorder TO i0765123
/
GRANT SELECT ON workorder TO i0765417
/
GRANT SELECT ON workorder TO i0788695
/
GRANT SELECT ON workorder TO i0795896
/
GRANT SELECT ON workorder TO i0796108
/
GRANT SELECT ON workorder TO i0797890
/
GRANT SELECT ON workorder TO i0799492
/
GRANT SELECT ON workorder TO i0805044
/
GRANT SELECT ON workorder TO i0805240
/
GRANT SELECT ON workorder TO i0805436
/
GRANT SELECT ON workorder TO i0806139
/
GRANT SELECT ON workorder TO i0808819
/
GRANT SELECT ON workorder TO i0808917
/
GRANT SELECT ON workorder TO i0809130
/
GRANT SELECT ON workorder TO i0809228
/
GRANT SELECT ON workorder TO i0809326
/
GRANT SELECT ON workorder TO i0809522
/
GRANT SELECT ON workorder TO i0809816
/
GRANT SELECT ON workorder TO i0811836
/
GRANT SELECT ON workorder TO i0814239
/
GRANT SELECT ON workorder TO i0814337
/
GRANT SELECT ON workorder TO i0839020
/
GRANT SELECT ON workorder TO i1004081
/
GRANT SELECT ON workorder TO i1005568
/
GRANT SELECT ON workorder TO i1007268
/
GRANT SELECT ON workorder TO i1007464
/
GRANT SELECT ON workorder TO i1014371
/
GRANT SELECT ON workorder TO i1015074
/
GRANT SELECT ON workorder TO i1016071
/
GRANT SELECT ON workorder TO i1019356
/
GRANT SELECT ON workorder TO i1019454
/
GRANT SELECT ON workorder TO i1019650
/
GRANT SELECT ON workorder TO i1019944
/
GRANT SELECT ON workorder TO i1021082
/
GRANT SELECT ON workorder TO i1022961
/
GRANT SELECT ON workorder TO i1023370
/
GRANT SELECT ON workorder TO i1024465
/
GRANT SELECT ON workorder TO i1024955
/
GRANT SELECT ON workorder TO i1025756
/
GRANT SELECT ON workorder TO i1030277
/
GRANT SELECT ON workorder TO i1030767
/
GRANT SELECT ON workorder TO i1032075
/
GRANT SELECT ON workorder TO i1036063
/
GRANT SELECT ON workorder TO i1036455
/
GRANT SELECT ON workorder TO i1036553
/
GRANT SELECT ON workorder TO i1037060
/
GRANT SELECT ON workorder TO i1038645
/
GRANT SELECT ON workorder TO i1038743
/
GRANT SELECT ON workorder TO i1039446
/
GRANT SELECT ON workorder TO i1041466
/
GRANT SELECT ON workorder TO i1043264
/
GRANT SELECT ON workorder TO i1045356
/
GRANT SELECT ON workorder TO i1047546
/
GRANT DELETE ON workorder TO i1048837
/
GRANT SELECT ON workorder TO i1048837
/
GRANT UPDATE ON workorder TO i1048837
/
GRANT SELECT ON workorder TO i1049834
/
GRANT SELECT ON workorder TO i1050171
/
GRANT SELECT ON workorder TO i1053162
/
GRANT SELECT ON workorder TO i1053260
/
GRANT SELECT ON workorder TO i1054061
/
GRANT SELECT ON workorder TO i1059634
/
GRANT SELECT ON workorder TO i1061066
/
GRANT SELECT ON workorder TO i1062357
/
GRANT SELECT ON workorder TO i1066541
/
GRANT SELECT ON workorder TO i1067930
/
GRANT SELECT ON workorder TO i1069434
/
GRANT SELECT ON workorder TO i1070163
/
GRANT SELECT ON workorder TO i1071356
/
GRANT SELECT ON workorder TO i1071748
/
GRANT SELECT ON workorder TO i1072353
/
GRANT SELECT ON workorder TO i1073840
/
GRANT SELECT ON workorder TO i1073938
/
GRANT SELECT ON workorder TO i1077044
/
GRANT SELECT ON workorder TO i107857
/
GRANT SELECT ON workorder TO i1083836
/
GRANT SELECT ON workorder TO i1086729
/
GRANT SELECT ON workorder TO i1087138
/
GRANT SELECT ON workorder TO i1088429
/
GRANT SELECT ON workorder TO i1089720
/
GRANT SELECT ON workorder TO i1091544
/
GRANT SELECT ON workorder TO i1091740
/
GRANT SELECT ON workorder TO i1092639
/
GRANT SELECT ON workorder TO i1092737
/
GRANT SELECT ON workorder TO i1120374
/
GRANT SELECT ON workorder TO i1142948
/
GRANT SELECT ON workorder TO i1143259
/
GRANT SELECT ON workorder TO i1161159
/
GRANT SELECT ON workorder TO i1164836
/
GRANT SELECT ON workorder TO i1169331
/
GRANT SELECT ON workorder TO i1173051
/
GRANT SELECT ON workorder TO i1177823
/
GRANT SELECT ON workorder TO i1178526
/
GRANT SELECT ON workorder TO i1179425
/
GRANT SELECT ON workorder TO i1183635
/
GRANT SELECT ON workorder TO i1184044
/
GRANT DELETE ON workorder TO i1184436
/
GRANT SELECT ON workorder TO i1184436
/
GRANT UPDATE ON workorder TO i1184436
/
GRANT SELECT ON workorder TO i1185335
/
GRANT SELECT ON workorder TO i1187525
/
GRANT SELECT ON workorder TO i1205950
/
GRANT SELECT ON workorder TO i1220761
/
GRANT SELECT ON workorder TO i1252841
/
GRANT SELECT ON workorder TO i1414939
/
GRANT SELECT ON workorder TO i1460637
/
GRANT SELECT ON workorder TO i1460833
/
GRANT SELECT ON workorder TO i1472921
/
GRANT SELECT ON workorder TO i1478217
/
GRANT SELECT ON workorder TO i1479999
/
GRANT SELECT ON workorder TO i1523443
/
GRANT SELECT ON workorder TO i1527137
/
GRANT SELECT ON workorder TO i1529915
/
GRANT SELECT ON workorder TO i1537231
/
GRANT SELECT ON workorder TO i1553823
/
GRANT SELECT ON workorder TO i1554232
/
GRANT SELECT ON workorder TO i1555719
/
GRANT SELECT ON workorder TO i1555817
/
GRANT SELECT ON workorder TO i1556422
/
GRANT SELECT ON workorder TO i1558416
/
GRANT SELECT ON workorder TO i1702640
/
GRANT SELECT ON workorder TO i1702836
/
GRANT SELECT ON workorder TO i1750528
/
GRANT SELECT ON workorder TO i1803240
/
GRANT SELECT ON workorder TO i1852027
/
GRANT SELECT ON workorder TO i1853416
/
GRANT SELECT ON workorder TO i1902140
/
GRANT SELECT ON workorder TO i1929209
/
GRANT SELECT ON workorder TO i1930330
/
GRANT SELECT ON workorder TO i1936410
/
GRANT SELECT ON workorder TO i1937603
/
GRANT SELECT ON workorder TO i1940032
/
GRANT SELECT ON workorder TO i1940816
/
GRANT SELECT ON workorder TO i1941519
/
GRANT SELECT ON workorder TO i1942712
/
GRANT SELECT ON workorder TO i1943121
/
GRANT SELECT ON workorder TO i1943611
/
GRANT SELECT ON workorder TO i1944118
/
GRANT SELECT ON workorder TO i1944902
/
GRANT SELECT ON workorder TO i1946897
/
GRANT SELECT ON workorder TO i1947698
/
GRANT SELECT ON workorder TO i1947992
/
GRANT SELECT ON workorder TO i1948008
/
GRANT SELECT ON workorder TO i1948695
/
GRANT SELECT ON workorder TO i1949005
/
GRANT SELECT ON workorder TO i1950420
/
GRANT SELECT ON workorder TO i1950518
/
GRANT SELECT ON workorder TO i1951123
/
GRANT SELECT ON workorder TO i198426
/
GRANT SELECT ON workorder TO i220669
/
GRANT DELETE ON workorder TO i2227636
/
GRANT SELECT ON workorder TO i2227636
/
GRANT UPDATE ON workorder TO i2227636
/
GRANT SELECT ON workorder TO i2316736
/
GRANT SELECT ON workorder TO i2319237
/
GRANT SELECT ON workorder TO i2320456
/
GRANT SELECT ON workorder TO i2320750
/
GRANT SELECT ON workorder TO i2323251
/
GRANT SELECT ON workorder TO i2336336
/
GRANT SELECT ON workorder TO i2349225
/
GRANT SELECT ON workorder TO i2356622
/
GRANT SELECT ON workorder TO i2358910
/
GRANT SELECT ON workorder TO i2369707
/
GRANT SELECT ON workorder TO i2371237
/
GRANT SELECT ON workorder TO i2371825
/
GRANT SELECT ON workorder TO i2398404
/
GRANT SELECT ON workorder TO i2402061
/
GRANT SELECT ON workorder TO i2403735
/
GRANT SELECT ON workorder TO i2406735
/
GRANT SELECT ON workorder TO i2517821
/
GRANT SELECT ON workorder TO i2604535
/
GRANT SELECT ON workorder TO i2614335
/
GRANT SELECT ON workorder TO i2621242
/
GRANT SELECT ON workorder TO i2627028
/
GRANT SELECT ON workorder TO i2627126
/
GRANT SELECT ON workorder TO i2633722
/
GRANT SELECT ON workorder TO i2905125
/
GRANT SELECT ON workorder TO i2908508
/
GRANT SELECT ON workorder TO i3023554
/
GRANT SELECT ON workorder TO i3025058
/
GRANT SELECT ON workorder TO i3027248
/
GRANT SELECT ON workorder TO i3027444
/
GRANT SELECT ON workorder TO i3028637
/
GRANT SELECT ON workorder TO i3235436
/
GRANT SELECT ON workorder TO i3236727
/
GRANT SELECT ON workorder TO i3243046
/
GRANT SELECT ON workorder TO i3243830
/
GRANT SELECT ON workorder TO i3246037
/
GRANT SELECT ON workorder TO i3249910
/
GRANT SELECT ON workorder TO i3251440
/
GRANT SELECT ON workorder TO i3261044
/
GRANT SELECT ON workorder TO i3264035
/
GRANT SELECT ON workorder TO i3265228
/
GRANT SELECT ON workorder TO i3269020
/
GRANT SELECT ON workorder TO i3272037
/
GRANT SELECT ON workorder TO i3276025
/
GRANT SELECT ON workorder TO i3277904
/
GRANT SELECT ON workorder TO i3289208
/
GRANT SELECT ON workorder TO i3294317
/
GRANT SELECT ON workorder TO i3294807
/
GRANT SELECT ON workorder TO i3297504
/
GRANT SELECT ON workorder TO i3297995
/
GRANT SELECT ON workorder TO i3298109
/
GRANT SELECT ON workorder TO i3299499
/
GRANT SELECT ON workorder TO i3317041
/
GRANT SELECT ON workorder TO i3326824
/
GRANT SELECT ON workorder TO i3327429
/
GRANT SELECT ON workorder TO i3330446
/
GRANT SELECT ON workorder TO i3331443
/
GRANT SELECT ON workorder TO i3405928
/
GRANT SELECT ON workorder TO i3412639
/
GRANT SELECT ON workorder TO i3412737
/
GRANT SELECT ON workorder TO i3617026
/
GRANT SELECT ON workorder TO i3618611
/
GRANT SELECT ON workorder TO i3624227
/
GRANT SELECT ON workorder TO i3625616
/
GRANT SELECT ON workorder TO i3628803
/
GRANT SELECT ON workorder TO i3804323
/
GRANT SELECT ON workorder TO i3930906
/
GRANT SELECT ON workorder TO i3932018
/
GRANT SELECT ON workorder TO i3932999
/
GRANT SELECT ON workorder TO i3940314
/
GRANT SELECT ON workorder TO i3941115
/
GRANT SELECT ON workorder TO i3941703
/
GRANT SELECT ON workorder TO i3942112
/
GRANT SELECT ON workorder TO i3943109
/
GRANT SELECT ON workorder TO i3943403
/
GRANT SELECT ON workorder TO i3943698
/
GRANT SELECT ON workorder TO i3946787
/
GRANT SELECT ON workorder TO i3947686
/
GRANT SELECT ON workorder TO i4102554
/
GRANT SELECT ON workorder TO i4103551
/
GRANT SELECT ON workorder TO i4104254
/
GRANT SELECT ON workorder TO i4104450
/
GRANT SELECT ON workorder TO i4105545
/
GRANT SELECT ON workorder TO i4108046
/
GRANT SELECT ON workorder TO i4110654
/
GRANT SELECT ON workorder TO i4113057
/
GRANT SELECT ON workorder TO i4115051
/
GRANT SELECT ON workorder TO i4117437
/
GRANT SELECT ON workorder TO i4118924
/
GRANT SELECT ON workorder TO i4121941
/
GRANT SELECT ON workorder TO i4123543
/
GRANT SELECT ON workorder TO i4123837
/
GRANT SELECT ON workorder TO i4124050
/
GRANT SELECT ON workorder TO i4125929
/
GRANT SELECT ON workorder TO i4126044
/
GRANT SELECT ON workorder TO i4128038
/
GRANT SELECT ON workorder TO i4128626
/
GRANT SELECT ON workorder TO i4129035
/
GRANT SELECT ON workorder TO i4129525
/
GRANT SELECT ON workorder TO i4134732
/
GRANT SELECT ON workorder TO i4141639
/
GRANT SELECT ON workorder TO i4141737
/
GRANT SELECT ON workorder TO i4145823
/
GRANT SELECT ON workorder TO i4146428
/
GRANT SELECT ON workorder TO i4148128
/
GRANT SELECT ON workorder TO i4149811
/
GRANT SELECT ON workorder TO i4153237
/
GRANT SELECT ON workorder TO i4155231
/
GRANT SELECT ON workorder TO i4155721
/
GRANT SELECT ON workorder TO i4157715
/
GRANT SELECT ON workorder TO i4158810
/
GRANT SELECT ON workorder TO i4161435
/
GRANT SELECT ON workorder TO i4161533
/
GRANT SELECT ON workorder TO i4163723
/
GRANT SELECT ON workorder TO i4166420
/
GRANT SELECT ON workorder TO i4166714
/
GRANT SELECT ON workorder TO i4166812
/
GRANT SELECT ON workorder TO i4167123
/
GRANT SELECT ON workorder TO i4172036
/
GRANT SELECT ON workorder TO i4178116
/
GRANT SELECT ON workorder TO i4182031
/
GRANT SELECT ON workorder TO i4182032
/
GRANT SELECT ON workorder TO i4185121
/
GRANT SELECT ON workorder TO i4186412
/
GRANT SELECT ON workorder TO i4187998
/
GRANT SELECT ON workorder TO i4189305
/
GRANT SELECT ON workorder TO i4191129
/
GRANT SELECT ON workorder TO i4193319
/
GRANT SELECT ON workorder TO i4194120
/
GRANT SELECT ON workorder TO i4194414
/
GRANT SELECT ON workorder TO i4197601
/
GRANT SELECT ON workorder TO i4199498
/
GRANT SELECT ON workorder TO i4221446
/
GRANT SELECT ON workorder TO i4223440
/
GRANT SELECT ON workorder TO i4231736
/
GRANT SELECT ON workorder TO i4253722
/
GRANT SELECT ON workorder TO i4256223
/
GRANT SELECT ON workorder TO i4256321
/
GRANT SELECT ON workorder TO i4256811
/
GRANT SELECT ON workorder TO i4258413
/
GRANT SELECT ON workorder TO i4259116
/
GRANT SELECT ON workorder TO i4259704
/
GRANT SELECT ON workorder TO i4508320
/
GRANT SELECT ON workorder TO i4526220
/
GRANT SELECT ON workorder TO i4535219
/
GRANT SELECT ON workorder TO i4536314
/
GRANT SELECT ON workorder TO i4538014
/
GRANT SELECT ON workorder TO i4538995
/
GRANT SELECT ON workorder TO i4540230
/
GRANT SELECT ON workorder TO i4543123
/
GRANT SELECT ON workorder TO i4543221
/
GRANT SELECT ON workorder TO i4545411
/
GRANT SELECT ON workorder TO i4547209
/
GRANT SELECT ON workorder TO i4548304
/
GRANT SELECT ON workorder TO i4548697
/
GRANT SELECT ON workorder TO i4549988
/
GRANT SELECT ON workorder TO i4701331
/
GRANT SELECT ON workorder TO i4711229
/
GRANT SELECT ON workorder TO i4717701
/
GRANT SELECT ON workorder TO i4718306
/
GRANT SELECT ON workorder TO i4719303
/
GRANT SELECT ON workorder TO i4719598
/
GRANT SELECT ON workorder TO i4720816
/
GRANT SELECT ON workorder TO i4722026
/
GRANT SELECT ON workorder TO i4726406
/
GRANT SELECT ON workorder TO i4727109
/
GRANT SELECT ON workorder TO i4728204
/
GRANT SELECT ON workorder TO i4733411
/
GRANT SELECT ON workorder TO i4734310
/
GRANT SELECT ON workorder TO i4734506
/
GRANT SELECT ON workorder TO i4734702
/
GRANT SELECT ON workorder TO i4735798
/
GRANT SELECT ON workorder TO i4735896
/
GRANT SELECT ON workorder TO i4735994
/
GRANT SELECT ON workorder TO i4736991
/
GRANT SELECT ON workorder TO i4737596
/
GRANT SELECT ON workorder TO i4738397
/
GRANT SELECT ON workorder TO i4741217
/
GRANT SELECT ON workorder TO i4744306
/
GRANT SELECT ON workorder TO i4746399
/
GRANT SELECT ON workorder TO i4747494
/
GRANT SELECT ON workorder TO i4750314
/
GRANT SELECT ON workorder TO i4750804
/
GRANT SELECT ON workorder TO i4751115
/
GRANT SELECT ON workorder TO i4912216
/
GRANT SELECT ON workorder TO i4914112
/
GRANT SELECT ON workorder TO i5218227
/
GRANT SELECT ON workorder TO i5303143
/
GRANT SELECT ON workorder TO i5304630
/
GRANT SELECT ON workorder TO i5308814
/
GRANT SELECT ON workorder TO i5309517
/
GRANT SELECT ON workorder TO i5415912
/
GRANT SELECT ON workorder TO i559419
/
GRANT SELECT ON workorder TO i5600725
/
GRANT SELECT ON workorder TO i5607312
/
GRANT SELECT ON workorder TO i5608113
/
GRANT SELECT ON workorder TO i5611032
/
GRANT SELECT ON workorder TO i5611326
/
GRANT SELECT ON workorder TO i5611522
/
GRANT SELECT ON workorder TO i5611620
/
GRANT SELECT ON workorder TO i5803510
/
GRANT SELECT ON workorder TO i5811512
/
GRANT SELECT ON workorder TO i6001256
/
GRANT SELECT ON workorder TO i6002939
/
GRANT SELECT ON workorder TO i6003250
/
GRANT DELETE ON workorder TO i6007336
/
GRANT SELECT ON workorder TO i6007336
/
GRANT UPDATE ON workorder TO i6007336
/
GRANT DELETE ON workorder TO i6009526
/
GRANT SELECT ON workorder TO i6009526
/
GRANT UPDATE ON workorder TO i6009526
/
GRANT DELETE ON workorder TO i6011252
/
GRANT SELECT ON workorder TO i6011252
/
GRANT UPDATE ON workorder TO i6011252
/
GRANT DELETE ON workorder TO i6011840
/
GRANT SELECT ON workorder TO i6011840
/
GRANT UPDATE ON workorder TO i6011840
/
GRANT DELETE ON workorder TO i6012151
/
GRANT SELECT ON workorder TO i6012151
/
GRANT UPDATE ON workorder TO i6012151
/
GRANT SELECT ON workorder TO i6013932
/
GRANT SELECT ON workorder TO i6016825
/
GRANT DELETE ON workorder TO i6018721
/
GRANT SELECT ON workorder TO i6018721
/
GRANT UPDATE ON workorder TO i6018721
/
GRANT SELECT ON workorder TO i6018819
/
GRANT DELETE ON workorder TO i6019326
/
GRANT SELECT ON workorder TO i6019326
/
GRANT UPDATE ON workorder TO i6019326
/
GRANT DELETE ON workorder TO i6020447
/
GRANT SELECT ON workorder TO i6020447
/
GRANT UPDATE ON workorder TO i6020447
/
GRANT DELETE ON workorder TO i6021640
/
GRANT SELECT ON workorder TO i6021640
/
GRANT UPDATE ON workorder TO i6021640
/
GRANT DELETE ON workorder TO i6023732
/
GRANT SELECT ON workorder TO i6023732
/
GRANT UPDATE ON workorder TO i6023732
/
GRANT SELECT ON workorder TO i6024043
/
GRANT DELETE ON workorder TO i6026527
/
GRANT SELECT ON workorder TO i6026527
/
GRANT UPDATE ON workorder TO i6026527
/
GRANT SELECT ON workorder TO i6027524
/
GRANT DELETE ON workorder TO i6029714
/
GRANT SELECT ON workorder TO i6029714
/
GRANT UPDATE ON workorder TO i6029714
/
GRANT SELECT ON workorder TO i6031538
/
GRANT SELECT ON workorder TO i6032535
/
GRANT DELETE ON workorder TO i6032633
/
GRANT SELECT ON workorder TO i6032633
/
GRANT UPDATE ON workorder TO i6032633
/
GRANT DELETE ON workorder TO i6034921
/
GRANT SELECT ON workorder TO i6034921
/
GRANT UPDATE ON workorder TO i6034921
/
GRANT DELETE ON workorder TO i6035722
/
GRANT SELECT ON workorder TO i6035722
/
GRANT UPDATE ON workorder TO i6035722
/
GRANT DELETE ON workorder TO i6037814
/
GRANT SELECT ON workorder TO i6037814
/
GRANT UPDATE ON workorder TO i6037814
/
GRANT SELECT ON workorder TO i6040145
/
GRANT DELETE ON workorder TO i6040439
/
GRANT SELECT ON workorder TO i6040439
/
GRANT UPDATE ON workorder TO i6040439
/
GRANT DELETE ON workorder TO i6040635
/
GRANT SELECT ON workorder TO i6040635
/
GRANT UPDATE ON workorder TO i6040635
/
GRANT SELECT ON workorder TO i6041142
/
GRANT SELECT ON workorder TO i6041338
/
GRANT SELECT ON workorder TO i6041828
/
GRANT SELECT ON workorder TO i6042139
/
GRANT DELETE ON workorder TO i6042923
/
GRANT SELECT ON workorder TO i6042923
/
GRANT UPDATE ON workorder TO i6042923
/
GRANT SELECT ON workorder TO i6045130
/
GRANT SELECT ON workorder TO i6046519
/
GRANT SELECT ON workorder TO i6048709
/
GRANT SELECT ON workorder TO i6048807
/
GRANT SELECT ON workorder TO i6049412
/
GRANT SELECT ON workorder TO i6049510
/
GRANT SELECT ON workorder TO i6049608
/
GRANT SELECT ON workorder TO i6049706
/
GRANT SELECT ON workorder TO i6050043
/
GRANT DELETE ON workorder TO i6050435
/
GRANT SELECT ON workorder TO i6050435
/
GRANT UPDATE ON workorder TO i6050435
/
GRANT SELECT ON workorder TO i6051432
/
GRANT SELECT ON workorder TO i6051922
/
GRANT DELETE ON workorder TO i6052135
/
GRANT SELECT ON workorder TO i6052135
/
GRANT UPDATE ON workorder TO i6052135
/
GRANT DELETE ON workorder TO i6052429
/
GRANT SELECT ON workorder TO i6052429
/
GRANT UPDATE ON workorder TO i6052429
/
GRANT SELECT ON workorder TO i6052527
/
GRANT DELETE ON workorder TO i6052625
/
GRANT SELECT ON workorder TO i6052625
/
GRANT UPDATE ON workorder TO i6052625
/
GRANT SELECT ON workorder TO i6052723
/
GRANT SELECT ON workorder TO i614837
/
GRANT SELECT ON workorder TO i625340
/
GRANT SELECT ON workorder TO i6329503
/
GRANT SELECT ON workorder TO i6342418
/
GRANT SELECT ON workorder TO i6361413
/
GRANT SELECT ON workorder TO i6368883
/
GRANT SELECT ON workorder TO i6379190
/
GRANT SELECT ON workorder TO i6385001
/
GRANT SELECT ON workorder TO i6385982
/
GRANT SELECT ON workorder TO i6634205
/
GRANT SELECT ON workorder TO i6637491
/
GRANT SELECT ON workorder TO i6660107
/
GRANT SELECT ON workorder TO i6671983
/
GRANT SELECT ON workorder TO i6673487
/
GRANT SELECT ON workorder TO i6697957
/
GRANT SELECT ON workorder TO i6705896
/
GRANT SELECT ON workorder TO i6711315
/
GRANT SELECT ON workorder TO i6715401
/
GRANT SELECT ON workorder TO i6722112
/
GRANT SELECT ON workorder TO i6752689
/
GRANT SELECT ON workorder TO i6767474
/
GRANT SELECT ON workorder TO i6768079
/
GRANT SELECT ON workorder TO i6768961
/
GRANT SELECT ON workorder TO i6774479
/
GRANT SELECT ON workorder TO i6779170
/
GRANT SELECT ON workorder TO i6780585
/
GRANT SELECT ON workorder TO i6782579
/
GRANT SELECT ON workorder TO i6784083
/
GRANT SELECT ON workorder TO i6811997
/
GRANT SELECT ON workorder TO i6812307
/
GRANT SELECT ON workorder TO i7000449
/
GRANT SELECT ON workorder TO i7001152
/
GRANT SELECT ON workorder TO i7204525
/
GRANT SELECT ON workorder TO i7408209
/
GRANT SELECT ON workorder TO i7804594
/
GRANT SELECT ON workorder TO i7806294
/
GRANT SELECT ON workorder TO i7806490
/
GRANT SELECT ON workorder TO i8102236
/
GRANT SELECT ON workorder TO i8103135
/
GRANT SELECT ON workorder TO i8104720
/
GRANT SELECT ON workorder TO i8105325
/
GRANT SELECT ON workorder TO i8306410
/
GRANT SELECT ON workorder TO i8407697
/
GRANT SELECT ON workorder TO i8504897
/
GRANT SELECT ON workorder TO i8600609
/
GRANT SELECT ON workorder TO i8701601
/
GRANT SELECT ON workorder TO i8803885
/
GRANT SELECT ON workorder TO i8806288
/
GRANT SELECT ON workorder TO i8809279
/
GRANT SELECT ON workorder TO i9003820
/
GRANT SELECT ON workorder TO i9004621
/
GRANT SELECT ON workorder TO i9006027
/
GRANT SELECT ON workorder TO i9006615
/
GRANT SELECT ON workorder TO i9006713
/
GRANT DELETE ON workorder TO i9008021
/
GRANT SELECT ON workorder TO i9008021
/
GRANT UPDATE ON workorder TO i9008021
/
GRANT SELECT ON workorder TO i9008217
/
GRANT DELETE ON workorder TO i9008511
/
GRANT SELECT ON workorder TO i9008511
/
GRANT UPDATE ON workorder TO i9008511
/
GRANT DELETE ON workorder TO i9008805
/
GRANT SELECT ON workorder TO i9008805
/
GRANT UPDATE ON workorder TO i9008805
/
GRANT SELECT ON workorder TO i9010923
/
GRANT SELECT ON workorder TO i9011038
/
GRANT SELECT ON workorder TO i9011920
/
GRANT SELECT ON workorder TO i9023910
/
GRANT SELECT ON workorder TO i9024809
/
GRANT SELECT ON workorder TO i9025414
/
GRANT SELECT ON workorder TO i9025512
/
GRANT SELECT ON workorder TO i9026215
/
GRANT SELECT ON workorder TO i9026509
/
GRANT SELECT ON workorder TO i9027016
/
GRANT SELECT ON workorder TO i9027506
/
GRANT SELECT ON workorder TO i9028896
/
GRANT SELECT ON workorder TO i9028994
/
GRANT SELECT ON workorder TO i9029599
/
GRANT SELECT ON workorder TO i9029991
/
GRANT SELECT ON workorder TO i9033416
/
GRANT SELECT ON workorder TO i9033514
/
GRANT SELECT ON workorder TO i9034021
/
GRANT SELECT ON workorder TO i9034707
/
GRANT SELECT ON workorder TO i9034805
/
GRANT SELECT ON workorder TO i9035508
/
GRANT SELECT ON workorder TO i9035606
/
GRANT SELECT ON workorder TO i9036113
/
GRANT SELECT ON workorder TO i9037012
/
GRANT SELECT ON workorder TO i9037306
/
GRANT SELECT ON workorder TO i9038794
/
GRANT SELECT ON workorder TO i9038892
/
GRANT SELECT ON workorder TO i9039399
/
GRANT SELECT ON workorder TO i9039889
/
GRANT SELECT ON workorder TO i9040323
/
GRANT SELECT ON workorder TO i9040421
/
GRANT SELECT ON workorder TO i9040715
/
GRANT SELECT ON workorder TO i9042415
/
GRANT SELECT ON workorder TO i9042709
/
GRANT SELECT ON workorder TO i9042807
/
GRANT SELECT ON workorder TO i9046305
/
GRANT SELECT ON workorder TO i9046698
/
GRANT SELECT ON workorder TO i9047106
/
GRANT SELECT ON workorder TO i9049199
/
GRANT SELECT ON workorder TO i9051708
/
GRANT SELECT ON workorder TO i9052803
/
GRANT SELECT ON workorder TO i9053899
/
GRANT SELECT ON workorder TO i9055206
/
GRANT SELECT ON workorder TO i9055304
/
GRANT SELECT ON workorder TO i9055991
/
GRANT SELECT ON workorder TO i9056105
/
GRANT SELECT ON workorder TO i9062603
/
GRANT SELECT ON workorder TO i9068586
/
GRANT SELECT ON workorder TO i9070507
/
GRANT SELECT ON workorder TO i9072207
/
GRANT SELECT ON workorder TO i9079285
/
GRANT SELECT ON workorder TO i9083102
/
GRANT SELECT ON workorder TO i9083691
/
GRANT SELECT ON workorder TO i9085391
/
GRANT SELECT ON workorder TO i9085685
/
GRANT SELECT ON workorder TO i9086094
/
GRANT SELECT ON workorder TO i9087973
/
GRANT SELECT ON workorder TO i9089085
/
GRANT SELECT ON workorder TO i9094684
/
GRANT SELECT ON workorder TO i9098966
/
GRANT SELECT ON workorder TO i9102818
/
GRANT SELECT ON workorder TO i9201816
/
GRANT SELECT ON workorder TO i9202519
/
GRANT SELECT ON workorder TO i9202813
/
GRANT SELECT ON workorder TO i9203320
/
GRANT SELECT ON workorder TO i9400221
/
GRANT SELECT ON workorder TO i9400319
/
GRANT SELECT ON workorder TO i9400711
/
GRANT SELECT ON workorder TO i9402803
/
GRANT SELECT ON workorder TO i9402901
/
GRANT SELECT ON workorder TO i9403506
/
GRANT SELECT ON workorder TO i9408296
/
GRANT SELECT ON workorder TO i9409097
/
GRANT SELECT ON workorder TO i9410903
/
GRANT SELECT ON workorder TO i9412211
/
GRANT SELECT ON workorder TO i9412407
/
GRANT SELECT ON workorder TO i9412505
/
GRANT SELECT ON workorder TO i9412701
/
GRANT SELECT ON workorder TO i9412898
/
GRANT SELECT ON workorder TO i9413012
/
GRANT SELECT ON workorder TO i9413993
/
GRANT SELECT ON workorder TO i9415595
/
GRANT SELECT ON workorder TO i9415693
/
GRANT SELECT ON workorder TO i9415889
/
GRANT SELECT ON workorder TO i9415987
/
GRANT SELECT ON workorder TO i9416101
/
GRANT SELECT ON workorder TO i9418488
/
GRANT SELECT ON workorder TO i9419583
/
GRANT SELECT ON workorder TO i9419681
/
GRANT SELECT ON workorder TO i9420017
/
GRANT DELETE ON workorder TO i9420115
/
GRANT SELECT ON workorder TO i9420115
/
GRANT UPDATE ON workorder TO i9420115
/
GRANT DELETE ON workorder TO i9420213
/
GRANT SELECT ON workorder TO i9420213
/
GRANT UPDATE ON workorder TO i9420213
/
GRANT SELECT ON workorder TO i9420311
/
GRANT SELECT ON workorder TO i9420409
/
GRANT SELECT ON workorder TO i9420703
/
GRANT SELECT ON workorder TO i9422894
/
GRANT SELECT ON workorder TO i9426686
/
GRANT DELETE ON workorder TO i9426980
/
GRANT SELECT ON workorder TO i9426980
/
GRANT UPDATE ON workorder TO i9426980
/
GRANT SELECT ON workorder TO i9427095
/
GRANT SELECT ON workorder TO i9428974
/
GRANT SELECT ON workorder TO i9429285
/
GRANT SELECT ON workorder TO i9431206
/
GRANT SELECT ON workorder TO i9434688
/
GRANT SELECT ON workorder TO i9436094
/
GRANT SELECT ON workorder TO i9442101
/
GRANT SELECT ON workorder TO i9445965
/
GRANT SELECT ON workorder TO i9446580
/
GRANT SELECT ON workorder TO i9446972
/
GRANT SELECT ON workorder TO i9447577
/
GRANT SELECT ON workorder TO i9447871
/
GRANT SELECT ON workorder TO i9448378
/
GRANT SELECT ON workorder TO i9453487
/
GRANT SELECT ON workorder TO i9455187
/
GRANT SELECT ON workorder TO i9455775
/
GRANT SELECT ON workorder TO i9457573
/
GRANT SELECT ON workorder TO i9457671
/
GRANT SELECT ON workorder TO i9460394
/
GRANT SELECT ON workorder TO i9462682
/
GRANT SELECT ON workorder TO i9464480
/
GRANT SELECT ON workorder TO i9472874
/
GRANT SELECT ON workorder TO i9474574
/
GRANT SELECT ON workorder TO i9475767
/
GRANT SELECT ON workorder TO i9481383
/
GRANT SELECT ON workorder TO i9484570
/
GRANT SELECT ON workorder TO i9484766
/
GRANT SELECT ON workorder TO i9495661
/
GRANT SELECT ON workorder TO i9497459
/
GRANT SELECT ON workorder TO i9507294
/
GRANT SELECT ON workorder TO i9508585
/
GRANT SELECT ON workorder TO i9512795
/
GRANT SELECT ON workorder TO i9513596
/
GRANT SELECT ON workorder TO i9514004
/
GRANT SELECT ON workorder TO i9516783
/
GRANT SELECT ON workorder TO i9520404
/
GRANT SELECT ON workorder TO i9520993
/
GRANT SELECT ON workorder TO i9521009
/
GRANT SELECT ON workorder TO i9521107
/
GRANT SELECT ON workorder TO i9522987
/
GRANT SELECT ON workorder TO i9524295
/
GRANT SELECT ON workorder TO i9525880
/
GRANT SELECT ON workorder TO i9525978
/
GRANT SELECT ON workorder TO i9526681
/
GRANT SELECT ON workorder TO i9526779
/
GRANT SELECT ON workorder TO i9526975
/
GRANT SELECT ON workorder TO i9527090
/
GRANT SELECT ON workorder TO i9527188
/
GRANT SELECT ON workorder TO i9527286
/
GRANT SELECT ON workorder TO i9527678
/
GRANT SELECT ON workorder TO i9528283
/
GRANT SELECT ON workorder TO i9529182
/
GRANT SELECT ON workorder TO i9529966
/
GRANT SELECT ON workorder TO i9530891
/
GRANT SELECT ON workorder TO i9531496
/
GRANT SELECT ON workorder TO i9532395
/
GRANT SELECT ON workorder TO i9535582
/
GRANT SELECT ON workorder TO i9538279
/
GRANT SELECT ON workorder TO i9539668
/
GRANT SELECT ON workorder TO i9541001
/
GRANT SELECT ON workorder TO i9543780
/
GRANT SELECT ON workorder TO i9544581
/
GRANT SELECT ON workorder TO i9544875
/
GRANT DELETE ON workorder TO i9547866
/
GRANT SELECT ON workorder TO i9547866
/
GRANT UPDATE ON workorder TO i9547866
/
GRANT SELECT ON workorder TO i9551194
/
GRANT SELECT ON workorder TO i9552289
/
GRANT SELECT ON workorder TO i9552583
/
GRANT SELECT ON workorder TO i9554479
/
GRANT SELECT ON workorder TO i9556277
/
GRANT SELECT ON workorder TO i9556865
/
GRANT SELECT ON workorder TO i9557568
/
GRANT SELECT ON workorder TO i9557764
/
GRANT SELECT ON workorder TO i9560977
/
GRANT SELECT ON workorder TO i9561484
/
GRANT SELECT ON workorder TO i9564671
/
GRANT SELECT ON workorder TO i9565962
/
GRANT SELECT ON workorder TO i9566175
/
GRANT SELECT ON workorder TO i9566273
/
GRANT SELECT ON workorder TO i9566763
/
GRANT SELECT ON workorder TO i9567172
/
GRANT SELECT ON workorder TO i9567270
/
GRANT SELECT ON workorder TO i9567368
/
GRANT SELECT ON workorder TO i9567760
/
GRANT SELECT ON workorder TO i9569362
/
GRANT SELECT ON workorder TO i9569558
/
GRANT SELECT ON workorder TO i9569754
/
GRANT SELECT ON workorder TO i9570581
/
GRANT SELECT ON workorder TO i9570777
/
GRANT SELECT ON workorder TO i9573082
/
GRANT SELECT ON workorder TO i9573376
/
GRANT SELECT ON workorder TO i9573474
/
GRANT SELECT ON workorder TO i9577266
/
GRANT SELECT ON workorder TO i9577560
/
GRANT SELECT ON workorder TO i9577570
/
GRANT SELECT ON workorder TO i9577854
/
GRANT SELECT ON workorder TO i9579848
/
GRANT SELECT ON workorder TO i9581476
/
GRANT SELECT ON workorder TO i9581574
/
GRANT DELETE ON workorder TO i9585562
/
GRANT SELECT ON workorder TO i9585562
/
GRANT UPDATE ON workorder TO i9585562
/
GRANT SELECT ON workorder TO i9585856
/
GRANT SELECT ON workorder TO i9586167
/
GRANT SELECT ON workorder TO i9586265
/
GRANT SELECT ON workorder TO i9588455
/
GRANT SELECT ON workorder TO i9589452
/
GRANT SELECT ON workorder TO i9595558
/
GRANT SELECT ON workorder TO i9598843
/
GRANT SELECT ON workorder TO i9599154
/
GRANT SELECT ON workorder TO i9599350
/
GRANT SELECT ON workorder TO i9601797
/
GRANT SELECT ON workorder TO i9601895
/
GRANT SELECT ON workorder TO i9602009
/
GRANT SELECT ON workorder TO i9602598
/
GRANT SELECT ON workorder TO i9602794
/
GRANT SELECT ON workorder TO i9604494
/
GRANT SELECT ON workorder TO i9605589
/
GRANT SELECT ON workorder TO i9605981
/
GRANT SELECT ON workorder TO i9606194
/
GRANT SELECT ON workorder TO i9606292
/
GRANT SELECT ON workorder TO i9606586
/
GRANT SELECT ON workorder TO i9607093
/
GRANT SELECT ON workorder TO i9607877
/
GRANT SELECT ON workorder TO i9608188
/
GRANT SELECT ON workorder TO i9608384
/
GRANT SELECT ON workorder TO i9609087
/
GRANT SELECT ON workorder TO i9609675
/
GRANT SELECT ON workorder TO i9611499
/
GRANT SELECT ON workorder TO i9612201
/
GRANT SELECT ON workorder TO i9612692
/
GRANT SELECT ON workorder TO i9618968
/
GRANT SELECT ON workorder TO i9619083
/
GRANT SELECT ON workorder TO i9622884
/
GRANT SELECT ON workorder TO i9623097
/
GRANT SELECT ON workorder TO i9623195
/
GRANT SELECT ON workorder TO i9624094
/
GRANT SELECT ON workorder TO i9624192
/
GRANT SELECT ON workorder TO i9624584
/
GRANT SELECT ON workorder TO i9626382
/
GRANT SELECT ON workorder TO i9626676
/
GRANT SELECT ON workorder TO i9631785
/
GRANT SELECT ON workorder TO i9632978
/
GRANT SELECT ON workorder TO i9633093
/
GRANT SELECT ON workorder TO i9634776
/
GRANT SELECT ON workorder TO i9635283
/
GRANT SELECT ON workorder TO i9636770
/
GRANT SELECT ON workorder TO i9637277
/
GRANT SELECT ON workorder TO i9637865
/
GRANT SELECT ON workorder TO i9638372
/
GRANT SELECT ON workorder TO i9642092
/
GRANT SELECT ON workorder TO i9642974
/
GRANT SELECT ON workorder TO i9643383
/
GRANT SELECT ON workorder TO i9643481
/
GRANT SELECT ON workorder TO i9643677
/
GRANT SELECT ON workorder TO i9645965
/
GRANT SELECT ON workorder TO i9646864
/
GRANT SELECT ON workorder TO i9647371
/
GRANT SELECT ON workorder TO i9647665
/
GRANT SELECT ON workorder TO i9649365
/
GRANT SELECT ON workorder TO i9649463
/
GRANT SELECT ON workorder TO i9650192
/
GRANT SELECT ON workorder TO i9650388
/
GRANT SELECT ON workorder TO i9651091
/
GRANT SELECT ON workorder TO i9652872
/
GRANT SELECT ON workorder TO i9655667
/
GRANT SELECT ON workorder TO i9655765
/
GRANT SELECT ON workorder TO i9655863
/
GRANT SELECT ON workorder TO i9657563
/
GRANT SELECT ON workorder TO i9659949
/
GRANT SELECT ON workorder TO i9660776
/
GRANT SELECT ON workorder TO i9661087
/
GRANT SELECT ON workorder TO i9662280
/
GRANT SELECT ON workorder TO i9663865
/
GRANT SELECT ON workorder TO i9664568
/
GRANT SELECT ON workorder TO i9666464
/
GRANT SELECT ON workorder TO i9667853
/
GRANT SELECT ON workorder TO i9669651
/
GRANT SELECT ON workorder TO i9669847
/
GRANT SELECT ON workorder TO i9671671
/
GRANT SELECT ON workorder TO i9671769
/
GRANT SELECT ON workorder TO i9671867
/
GRANT SELECT ON workorder TO i9672178
/
GRANT SELECT ON workorder TO i9672276
/
GRANT SELECT ON workorder TO i9672668
/
GRANT SELECT ON workorder TO i9673175
/
GRANT SELECT ON workorder TO i9679255
/
GRANT SELECT ON workorder TO i9679549
/
GRANT SELECT ON workorder TO i9681471
/
GRANT SELECT ON workorder TO i9682468
/
GRANT SELECT ON workorder TO i9683759
/
GRANT SELECT ON workorder TO i9685557
/
GRANT SELECT ON workorder TO i9689153
/
GRANT SELECT ON workorder TO i9693363
/
GRANT SELECT ON workorder TO i9693951
/
GRANT SELECT ON workorder TO i9694066
/
GRANT SELECT ON workorder TO i9696256
/
GRANT SELECT ON workorder TO i9696550
/
GRANT SELECT ON workorder TO i9697743
/
GRANT SELECT ON workorder TO i9700697
/
GRANT SELECT ON workorder TO i9700991
/
GRANT SELECT ON workorder TO i9706189
/
GRANT SELECT ON workorder TO i9712197
/
GRANT SELECT ON workorder TO i9714289
/
GRANT SELECT ON workorder TO i9718669
/
GRANT SELECT ON workorder TO i9719960
/
GRANT SELECT ON workorder TO i9721490
/
GRANT SELECT ON workorder TO i9736765
/
GRANT SELECT ON workorder TO i9740681
/
GRANT SELECT ON workorder TO i9741776
/
GRANT SELECT ON workorder TO i9742773
/
GRANT SELECT ON workorder TO i9743084
/
GRANT SELECT ON workorder TO i9743182
/
GRANT SELECT ON workorder TO i9743280
/
GRANT SELECT ON workorder TO i9743378
/
GRANT SELECT ON workorder TO i9743476
/
GRANT SELECT ON workorder TO i9743672
/
GRANT SELECT ON workorder TO i9743770
/
GRANT SELECT ON workorder TO i9743966
/
GRANT SELECT ON workorder TO i9745862
/
GRANT SELECT ON workorder TO i9746369
/
GRANT SELECT ON workorder TO i9746859
/
GRANT SELECT ON workorder TO i9747660
/
GRANT SELECT ON workorder TO i9747758
/
GRANT SELECT ON workorder TO i9747856
/
GRANT SELECT ON workorder TO i9747954
/
GRANT SELECT ON workorder TO i9748265
/
GRANT SELECT ON workorder TO i9748461
/
GRANT SELECT ON workorder TO i9748755
/
GRANT SELECT ON workorder TO i9748853
/
GRANT SELECT ON workorder TO i9748951
/
GRANT SELECT ON workorder TO i9749164
/
GRANT SELECT ON workorder TO i9750285
/
GRANT SELECT ON workorder TO i9751576
/
GRANT SELECT ON workorder TO i9753668
/
GRANT SELECT ON workorder TO i9753766
/
GRANT SELECT ON workorder TO i9756953
/
GRANT SELECT ON workorder TO i9757950
/
GRANT SELECT ON workorder TO i9758261
/
GRANT SELECT ON workorder TO i9759552
/
GRANT SELECT ON workorder TO i9761964
/
GRANT SELECT ON workorder TO i9762275
/
GRANT SELECT ON workorder TO i9762373
/
GRANT SELECT ON workorder TO i9762471
/
GRANT SELECT ON workorder TO i9766067
/
GRANT SELECT ON workorder TO i9767064
/
GRANT SELECT ON workorder TO i9767456
/
GRANT SELECT ON workorder TO i9767750
/
GRANT SELECT ON workorder TO i9768551
/
GRANT SELECT ON workorder TO i9768649
/
GRANT SELECT ON workorder TO i9768747
/
GRANT SELECT ON workorder TO i9769156
/
GRANT SELECT ON workorder TO i9769254
/
GRANT SELECT ON workorder TO i9769352
/
GRANT SELECT ON workorder TO i9769450
/
GRANT SELECT ON workorder TO i9769548
/
GRANT SELECT ON workorder TO i9769646
/
GRANT SELECT ON workorder TO i9770277
/
GRANT SELECT ON workorder TO i9771764
/
GRANT SELECT ON workorder TO i9771862
/
GRANT SELECT ON workorder TO i9772761
/
GRANT SELECT ON workorder TO i9773072
/
GRANT SELECT ON workorder TO i9773268
/
GRANT SELECT ON workorder TO i9773954
/
GRANT SELECT ON workorder TO i9774167
/
GRANT SELECT ON workorder TO i9775164
/
GRANT SELECT ON workorder TO i9775850
/
GRANT SELECT ON workorder TO i9775948
/
GRANT SELECT ON workorder TO i9776749
/
GRANT SELECT ON workorder TO i9776847
/
GRANT SELECT ON workorder TO i9777060
/
GRANT SELECT ON workorder TO i9777256
/
GRANT SELECT ON workorder TO i9778547
/
GRANT SELECT ON workorder TO i9778743
/
GRANT SELECT ON workorder TO i9779446
/
GRANT SELECT ON workorder TO i9780665
/
GRANT SELECT ON workorder TO i9781270
/
GRANT SELECT ON workorder TO i9781858
/
GRANT SELECT ON workorder TO i9782757
/
GRANT SELECT ON workorder TO i9785944
/
GRANT SELECT ON workorder TO i9786647
/
GRANT SELECT ON workorder TO i9788739
/
GRANT SELECT ON workorder TO i9789736
/
GRANT SELECT ON workorder TO i9790171
/
GRANT SELECT ON workorder TO i9793260
/
GRANT SELECT ON workorder TO i9794257
/
GRANT SELECT ON workorder TO i9794355
/
GRANT SELECT ON workorder TO i9794453
/
GRANT SELECT ON workorder TO i9794845
/
GRANT SELECT ON workorder TO i9794943
/
GRANT SELECT ON workorder TO i9795842
/
GRANT SELECT ON workorder TO i9796055
/
GRANT SELECT ON workorder TO i9796741
/
GRANT SELECT ON workorder TO i9796839
/
GRANT SELECT ON workorder TO i9796937
/
GRANT SELECT ON workorder TO i9797444
/
GRANT SELECT ON workorder TO i9797640
/
GRANT SELECT ON workorder TO i9804484
/
GRANT SELECT ON workorder TO i9804974
/
GRANT SELECT ON workorder TO i9805187
/
GRANT SELECT ON workorder TO i9805383
/
GRANT SELECT ON workorder TO i9806576
/
GRANT SELECT ON workorder TO i9807181
/
GRANT SELECT ON workorder TO i9807475
/
GRANT SELECT ON workorder TO i9808178
/
GRANT SELECT ON workorder TO i9809175
/
GRANT SELECT ON workorder TO i9809371
/
GRANT SELECT ON workorder TO i9813385
/
GRANT SELECT ON workorder TO i9813973
/
GRANT SELECT ON workorder TO i9814186
/
GRANT SELECT ON workorder TO i9815967
/
GRANT SELECT ON workorder TO i9818566
/
GRANT SELECT ON workorder TO i9819857
/
GRANT SELECT ON workorder TO i9819955
/
GRANT SELECT ON workorder TO i9822972
/
GRANT SELECT ON workorder TO i9823479
/
GRANT SELECT ON workorder TO i9824182
/
GRANT SELECT ON workorder TO i9824476
/
GRANT SELECT ON workorder TO i9826568
/
GRANT SELECT ON workorder TO i9829167
/
GRANT SELECT ON workorder TO i9829657
/
GRANT SELECT ON workorder TO i9830386
/
GRANT SELECT ON workorder TO i9830484
/
GRANT DELETE ON workorder TO i9830582
/
GRANT SELECT ON workorder TO i9830582
/
GRANT UPDATE ON workorder TO i9830582
/
GRANT SELECT ON workorder TO i9830974
/
GRANT SELECT ON workorder TO i9832086
/
GRANT SELECT ON workorder TO i9832282
/
GRANT SELECT ON workorder TO i9834178
/
GRANT SELECT ON workorder TO i9834570
/
GRANT SELECT ON workorder TO i9834668
/
GRANT SELECT ON workorder TO i9836270
/
GRANT SELECT ON workorder TO i9836368
/
GRANT SELECT ON workorder TO i9836662
/
GRANT SELECT ON workorder TO i9839751
/
GRANT SELECT ON workorder TO i9840382
/
GRANT SELECT ON workorder TO i9843079
/
GRANT SELECT ON workorder TO i9847557
/
GRANT SELECT ON workorder TO i9848946
/
GRANT SELECT ON workorder TO i9850280
/
GRANT SELECT ON workorder TO i9851473
/
GRANT SELECT ON workorder TO i9852274
/
GRANT SELECT ON workorder TO i9852862
/
GRANT SELECT ON workorder TO i9854464
/
GRANT SELECT ON workorder TO i9855167
/
GRANT SELECT ON workorder TO i9855363
/
GRANT SELECT ON workorder TO i9855755
/
GRANT SELECT ON workorder TO i9856164
/
GRANT SELECT ON workorder TO i9858158
/
GRANT SELECT ON workorder TO i9859743
/
GRANT SELECT ON workorder TO i9860668
/
GRANT SELECT ON workorder TO i9861175
/
GRANT SELECT ON workorder TO i9861273
/
GRANT SELECT ON workorder TO i9862368
/
GRANT SELECT ON workorder TO i9862760
/
GRANT SELECT ON workorder TO i9863463
/
GRANT SELECT ON workorder TO i9864460
/
GRANT SELECT ON workorder TO i9864852
/
GRANT SELECT ON workorder TO i9865065
/
GRANT SELECT ON workorder TO i9866062
/
GRANT SELECT ON workorder TO i9866454
/
GRANT SELECT ON workorder TO i9868252
/
GRANT SELECT ON workorder TO i9870468
/
GRANT SELECT ON workorder TO i9871171
/
GRANT SELECT ON workorder TO i9878346
/
GRANT SELECT ON workorder TO i9879441
/
GRANT SELECT ON workorder TO i9881657
/
GRANT SELECT ON workorder TO i9883058
/
GRANT SELECT ON workorder TO i9883259
/
GRANT SELECT ON workorder TO i9883945
/
GRANT SELECT ON workorder TO i9888146
/
GRANT SELECT ON workorder TO i9891555
/
GRANT SELECT ON workorder TO i9892356
/
GRANT SELECT ON workorder TO i9893647
/
GRANT SELECT ON workorder TO i9896540
/
GRANT SELECT ON workorder TO i9897047
/
GRANT SELECT ON workorder TO i9898142
/
GRANT SELECT ON workorder TO i9900687
/
GRANT SELECT ON workorder TO i9900785
/
GRANT DELETE ON workorder TO i9901194
/
GRANT SELECT ON workorder TO i9901194
/
GRANT UPDATE ON workorder TO i9901194
/
GRANT SELECT ON workorder TO i9903482
/
GRANT SELECT ON workorder TO i9911190
/
GRANT SELECT ON workorder TO i9913772
/
GRANT SELECT ON workorder TO i9915472
/
GRANT SELECT ON workorder TO i9915570
/
GRANT SELECT ON workorder TO i9917172
/
GRANT SELECT ON workorder TO i9917270
/
GRANT SELECT ON workorder TO i9918169
/
GRANT SELECT ON workorder TO i9923082
/
GRANT SELECT ON workorder TO i9928851
/
GRANT SELECT ON workorder TO i9928949
/
GRANT SELECT ON workorder TO i9929554
/
GRANT SELECT ON workorder TO i9929652
/
GRANT SELECT ON workorder TO i9930479
/
GRANT SELECT ON workorder TO i9930969
/
GRANT SELECT ON workorder TO i9931084
/
GRANT SELECT ON workorder TO i9933470
/
GRANT SELECT ON workorder TO i9934075
/
GRANT SELECT ON workorder TO i9934761
/
GRANT SELECT ON workorder TO i9936951
/
GRANT SELECT ON workorder TO i9937262
/
GRANT SELECT ON workorder TO i9937360
/
GRANT SELECT ON workorder TO i9937948
/
GRANT SELECT ON workorder TO i9944855
/
GRANT SELECT ON workorder TO i9945068
/
GRANT SELECT ON workorder TO i9945558
/
GRANT SELECT ON workorder TO i9945754
/
GRANT SELECT ON workorder TO i9946947
/
GRANT SELECT ON workorder TO i9947650
/
GRANT SELECT ON workorder TO i9948451
/
GRANT SELECT ON workorder TO i9948549
/
GRANT SELECT ON workorder TO i9948745
/
GRANT SELECT ON workorder TO i9949350
/
GRANT SELECT ON workorder TO i9954263
/
GRANT SELECT ON workorder TO i9957940
/
GRANT SELECT ON workorder TO i9958055
/
GRANT SELECT ON workorder TO i9961464
/
GRANT SELECT ON workorder TO i9965354
/
GRANT SELECT ON workorder TO i9966351
/
GRANT SELECT ON workorder TO i9966841
/
GRANT SELECT ON workorder TO i9969636
/
GRANT SELECT ON workorder TO i9971460
/
GRANT SELECT ON workorder TO i9973258
/
GRANT SELECT ON workorder TO i9975350
/
GRANT SELECT ON workorder TO i9975448
/
GRANT SELECT ON workorder TO i9976151
/
GRANT SELECT ON workorder TO i9981750
/
GRANT SELECT ON workorder TO i9982943
/
GRANT SELECT ON workorder TO i9983058
/
GRANT SELECT ON workorder TO i9983548
/
GRANT SELECT ON workorder TO i9983744
/
GRANT SELECT ON workorder TO i9983940
/
GRANT SELECT ON workorder TO i9985346
/
GRANT SELECT ON workorder TO i9986245
/
GRANT SELECT ON workorder TO i9986343
/
GRANT SELECT ON workorder TO i9986441
/
GRANT SELECT ON workorder TO i9986539
/
GRANT SELECT ON workorder TO i9986631
/
GRANT SELECT ON workorder TO i9986637
/
GRANT SELECT ON workorder TO i9988337
/
GRANT SELECT ON workorder TO i9988435
/
GRANT SELECT ON workorder TO i9988631
/
GRANT SELECT ON workorder TO i9988729
/
GRANT SELECT ON workorder TO i9992253
/
GRANT SELECT ON workorder TO i9993446
/
GRANT SELECT ON workorder TO i9994835
/
GRANT SELECT ON workorder TO i9994933
/
GRANT SELECT ON workorder TO i9995538
/
GRANT SELECT ON workorder TO ifrad
/
GRANT SELECT ON workorder TO mams04
/
GRANT SELECT ON workorder TO maxconsulta
/
GRANT SELECT ON workorder TO maxdema
/
GRANT SELECT ON workorder TO maxgrp04
/
GRANT SELECT ON workorder TO maxgrp06
/
GRANT SELECT ON workorder TO maxgrp07
/
GRANT SELECT ON workorder TO maxgrp08
/
GRANT INSERT ON workorder TO maxsapiospa
/
GRANT SELECT ON workorder TO operacao
/
GRANT SELECT ON workorder TO prti04
/
GRANT DELETE ON workorder TO psdipub
/
GRANT INSERT ON workorder TO psdipub
/
GRANT SELECT ON workorder TO psdipub
/
GRANT UPDATE ON workorder TO psdipub
/
GRANT SELECT ON workorder TO sbar03
/
GRANT SELECT ON workorder TO sbar04
/
GRANT SELECT ON workorder TO sbbe01
/
GRANT SELECT ON workorder TO sbbe02
/
GRANT SELECT ON workorder TO sbbe03
/
GRANT SELECT ON workorder TO sbbe04
/
GRANT SELECT ON workorder TO sbbe06
/
GRANT SELECT ON workorder TO sbbearaujo
/
GRANT SELECT ON workorder TO sbbecetest
/
GRANT SELECT ON workorder TO sbbechaoverde
/
GRANT SELECT ON workorder TO sbbepontual
/
GRANT SELECT ON workorder TO sbbethermar
/
GRANT SELECT ON workorder TO sbbg04
/
GRANT SELECT ON workorder TO sbbi04
/
GRANT SELECT ON workorder TO sbbr01
/
GRANT SELECT ON workorder TO sbbr02
/
GRANT SELECT ON workorder TO sbbr03
/
GRANT SELECT ON workorder TO sbbr04
/
GRANT SELECT ON workorder TO sbbr06
/
GRANT SELECT ON workorder TO sbbv02
/
GRANT SELECT ON workorder TO sbbv03
/
GRANT SELECT ON workorder TO sbbv04
/
GRANT SELECT ON workorder TO sbcf01
/
GRANT SELECT ON workorder TO sbcf02
/
GRANT DELETE ON workorder TO sbcf03
/
GRANT SELECT ON workorder TO sbcf03
/
GRANT UPDATE ON workorder TO sbcf03
/
GRANT SELECT ON workorder TO sbcf04
/
GRANT SELECT ON workorder TO sbcfacomar
/
GRANT SELECT ON workorder TO sbcfcetest
/
GRANT SELECT ON workorder TO sbcfgp
/
GRANT SELECT ON workorder TO sbcfmoa
/
GRANT SELECT ON workorder TO sbcfprologo
/
GRANT SELECT ON workorder TO sbcfsalgado
/
GRANT SELECT ON workorder TO sbcfscheffer
/
GRANT SELECT ON workorder TO sbcftecnyt
/
GRANT SELECT ON workorder TO sbcfviatec
/
GRANT SELECT ON workorder TO sbcg02
/
GRANT SELECT ON workorder TO sbcg03
/
GRANT SELECT ON workorder TO sbcg04
/
GRANT SELECT ON workorder TO sbcginterway
/
GRANT SELECT ON workorder TO sbcm
/
GRANT SELECT ON workorder TO sbcm04
/
GRANT SELECT ON workorder TO sbcr02
/
GRANT SELECT ON workorder TO sbcr03
/
GRANT SELECT ON workorder TO sbcr04
/
GRANT SELECT ON workorder TO sbcrengeletrica
/
GRANT SELECT ON workorder TO sbcrmpe
/
GRANT SELECT ON workorder TO sbct01
/
GRANT SELECT ON workorder TO sbct02
/
GRANT SELECT ON workorder TO sbct03
/
GRANT SELECT ON workorder TO sbct04
/
GRANT SELECT ON workorder TO sbct06
/
GRANT SELECT ON workorder TO sbctebcm
/
GRANT SELECT ON workorder TO sbctellshaday
/
GRANT SELECT ON workorder TO sbctelschadday
/
GRANT SELECT ON workorder TO sbctelshaday
/
GRANT SELECT ON workorder TO sbctengeletrica
/
GRANT SELECT ON workorder TO sbctparana
/
GRANT SELECT ON workorder TO sbctparanarede
/
GRANT SELECT ON workorder TO sbctscheffer
/
GRANT SELECT ON workorder TO sbctsociplan
/
GRANT SELECT ON workorder TO sbctteldata
/
GRANT SELECT ON workorder TO sbcy04
/
GRANT SELECT ON workorder TO sbcz04
/
GRANT SELECT ON workorder TO sbeg01
/
GRANT SELECT ON workorder TO sbeg02
/
GRANT SELECT ON workorder TO sbeg03
/
GRANT SELECT ON workorder TO sbeg04
/
GRANT SELECT ON workorder TO sbegmarins
/
GRANT SELECT ON workorder TO sbegmpe
/
GRANT SELECT ON workorder TO sbegthermar
/
GRANT SELECT ON workorder TO sbfi04
/
GRANT SELECT ON workorder TO sbfl03
/
GRANT SELECT ON workorder TO sbfl04
/
GRANT SELECT ON workorder TO sbfz
/
GRANT SELECT ON workorder TO sbfz01
/
GRANT SELECT ON workorder TO sbfz02
/
GRANT SELECT ON workorder TO sbfz03
/
GRANT SELECT ON workorder TO sbfz04
/
GRANT SELECT ON workorder TO sbfz06
/
GRANT SELECT ON workorder TO sbfzctm
/
GRANT SELECT ON workorder TO sbfzengeletrica
/
GRANT SELECT ON workorder TO sbfzinterway
/
GRANT SELECT ON workorder TO sbfzpontual
/
GRANT SELECT ON workorder TO sbfzservtec
/
GRANT SELECT ON workorder TO sbfztecnyt
/
GRANT SELECT ON workorder TO sbfzuniao
/
GRANT SELECT ON workorder TO sbgl01
/
GRANT SELECT ON workorder TO sbgl02
/
GRANT SELECT ON workorder TO sbgl03
/
GRANT SELECT ON workorder TO sbgl04
/
GRANT SELECT ON workorder TO sbglccr
/
GRANT SELECT ON workorder TO sbgleterc
/
GRANT SELECT ON workorder TO sbglexcel
/
GRANT SELECT ON workorder TO sbglicsupply
/
GRANT SELECT ON workorder TO sbglmpe
/
GRANT SELECT ON workorder TO sbglsm21
/
GRANT SELECT ON workorder TO sbglteam
/
GRANT SELECT ON workorder TO sbgltecnenge
/
GRANT SELECT ON workorder TO sbgo02
/
GRANT SELECT ON workorder TO sbgo03
/
GRANT SELECT ON workorder TO sbgo04
/
GRANT SELECT ON workorder TO sbgr01
/
GRANT SELECT ON workorder TO sbgr02
/
GRANT SELECT ON workorder TO sbgr03
/
GRANT SELECT ON workorder TO sbgr04
/
GRANT SELECT ON workorder TO sbgr05
/
GRANT SELECT ON workorder TO sbgr06
/
GRANT SELECT ON workorder TO sbgratlas
/
GRANT SELECT ON workorder TO sbgrcascardi
/
GRANT SELECT ON workorder TO sbgrcsistema
/
GRANT SELECT ON workorder TO sbgrempress
/
GRANT SELECT ON workorder TO sbgrengeletrica
/
GRANT SELECT ON workorder TO sbgrgebetz
/
GRANT SELECT ON workorder TO sbgrgegr
/
GRANT SELECT ON workorder TO sbgriacit
/
GRANT SELECT ON workorder TO sbgrinterway
/
GRANT SELECT ON workorder TO sbgrmpe
/
GRANT SELECT ON workorder TO sbgrmpe014
/
GRANT SELECT ON workorder TO sbgrmpe033
/
GRANT SELECT ON workorder TO sbgrmpe041
/
GRANT SELECT ON workorder TO sbgrmpe071
/
GRANT SELECT ON workorder TO sbgrmpe071f
/
GRANT SELECT ON workorder TO sbgrmpe072
/
GRANT SELECT ON workorder TO sbgrntk
/
GRANT SELECT ON workorder TO sbgrotis
/
GRANT SELECT ON workorder TO sbgrserviceone
/
GRANT SELECT ON workorder TO sbgrsheffer
/
GRANT SELECT ON workorder TO sbgrsipec
/
GRANT SELECT ON workorder TO sbgrspread
/
GRANT SELECT ON workorder TO sbgrsupply
/
GRANT SELECT ON workorder TO sbgrtranspolix
/
GRANT SELECT ON workorder TO sbgrultratec
/
GRANT SELECT ON workorder TO sbgrviatec
/
GRANT SELECT ON workorder TO sbiz03
/
GRANT SELECT ON workorder TO sbiz04
/
GRANT SELECT ON workorder TO sbjp03
/
GRANT SELECT ON workorder TO sbjp04
/
GRANT SELECT ON workorder TO sbjv04
/
GRANT SELECT ON workorder TO sbkp
/
GRANT SELECT ON workorder TO sbkp01
/
GRANT SELECT ON workorder TO sbkp02
/
GRANT SELECT ON workorder TO sbkp03
/
GRANT SELECT ON workorder TO sbkp04
/
GRANT SELECT ON workorder TO sbkp06
/
GRANT SELECT ON workorder TO sbkpatonanni
/
GRANT SELECT ON workorder TO sbkpcorpus
/
GRANT SELECT ON workorder TO sbkpengeletrica
/
GRANT SELECT ON workorder TO sbkpengeletrica004
/
GRANT SELECT ON workorder TO sbkpengeletrica012
/
GRANT SELECT ON workorder TO sbkpengeletrica018
/
GRANT SELECT ON workorder TO sbkpengeletrica047
/
GRANT SELECT ON workorder TO sbkpgutierrez
/
GRANT SELECT ON workorder TO sbkpmpe
/
GRANT SELECT ON workorder TO sbkpmpe005
/
GRANT SELECT ON workorder TO sbkpmpe011
/
GRANT SELECT ON workorder TO sbkpntk
/
GRANT SELECT ON workorder TO sbkpscheffer
/
GRANT SELECT ON workorder TO sbkpservtec
/
GRANT SELECT ON workorder TO sbkpsge
/
GRANT SELECT ON workorder TO sbkpsge003
/
GRANT SELECT ON workorder TO sbkpsge020
/
GRANT SELECT ON workorder TO sbkpviatec
/
GRANT SELECT ON workorder TO sblo02
/
GRANT SELECT ON workorder TO sblo04
/
GRANT SELECT ON workorder TO sbloartemultipla
/
GRANT SELECT ON workorder TO sbloartemultipla06
/
GRANT SELECT ON workorder TO sbma04
/
GRANT SELECT ON workorder TO sbmo01
/
GRANT SELECT ON workorder TO sbmo02
/
GRANT SELECT ON workorder TO sbmo03
/
GRANT SELECT ON workorder TO sbmo04
/
GRANT SELECT ON workorder TO sbmosuperserv
/
GRANT SELECT ON workorder TO sbmoviatec
/
GRANT SELECT ON workorder TO sbmq04
/
GRANT SELECT ON workorder TO sbnf04
/
GRANT SELECT ON workorder TO sbnt01
/
GRANT SELECT ON workorder TO sbnt02
/
GRANT SELECT ON workorder TO sbnt03
/
GRANT SELECT ON workorder TO sbnt04
/
GRANT SELECT ON workorder TO sbpa01
/
GRANT SELECT ON workorder TO sbpa02
/
GRANT SELECT ON workorder TO sbpa03
/
GRANT SELECT ON workorder TO sbpa04
/
GRANT SELECT ON workorder TO sbpa06
/
GRANT SELECT ON workorder TO sbpaartmultipla
/
GRANT SELECT ON workorder TO sbpaconbras
/
GRANT SELECT ON workorder TO sbpaejr
/
GRANT SELECT ON workorder TO sbpaemant
/
GRANT SELECT ON workorder TO sbpaengeletrica
/
GRANT SELECT ON workorder TO sbpaheacoo
/
GRANT SELECT ON workorder TO sbpampe
/
GRANT SELECT ON workorder TO sbpaotis
/
GRANT SELECT ON workorder TO sbpasait
/
GRANT SELECT ON workorder TO sbpatecnyt
/
GRANT SELECT ON workorder TO sbpatecnytmec
/
GRANT SELECT ON workorder TO sbpatopservice
/
GRANT SELECT ON workorder TO sbpatopserviceciv
/
GRANT SELECT ON workorder TO sbpj
/
GRANT SELECT ON workorder TO sbpj03
/
GRANT SELECT ON workorder TO sbpj04
/
GRANT SELECT ON workorder TO sbpk04
/
GRANT SELECT ON workorder TO sbpl03
/
GRANT SELECT ON workorder TO sbpl04
/
GRANT SELECT ON workorder TO sbpv02
/
GRANT SELECT ON workorder TO sbpv03
/
GRANT SELECT ON workorder TO sbpv04
/
GRANT SELECT ON workorder TO sbpv06
/
GRANT SELECT ON workorder TO sbrb02
/
GRANT SELECT ON workorder TO sbrb03
/
GRANT SELECT ON workorder TO sbrb04
/
GRANT SELECT ON workorder TO sbrb06
/
GRANT SELECT ON workorder TO sbrf01
/
GRANT SELECT ON workorder TO sbrf02
/
GRANT SELECT ON workorder TO sbrf03
/
GRANT SELECT ON workorder TO sbrf04
/
GRANT SELECT ON workorder TO sbrf06
/
GRANT SELECT ON workorder TO sbrfarclima
/
GRANT SELECT ON workorder TO sbrfhidelma
/
GRANT SELECT ON workorder TO sbrfmpe
/
GRANT SELECT ON workorder TO sbrfsuperserv
/
GRANT SELECT ON workorder TO sbrfviatec
/
GRANT SELECT ON workorder TO sbrj01
/
GRANT SELECT ON workorder TO sbrj02
/
GRANT SELECT ON workorder TO sbrj03
/
GRANT SELECT ON workorder TO sbrj04
/
GRANT SELECT ON workorder TO sbrjmpe
/
GRANT SELECT ON workorder TO sbrp04
/
GRANT SELECT ON workorder TO sbsj03
/
GRANT SELECT ON workorder TO sbsl01
/
GRANT SELECT ON workorder TO sbsl02
/
GRANT SELECT ON workorder TO sbsl03
/
GRANT SELECT ON workorder TO sbsl04
/
GRANT SELECT ON workorder TO sbsl06
/
GRANT SELECT ON workorder TO sbsn04
/
GRANT SELECT ON workorder TO sbsp01
/
GRANT SELECT ON workorder TO sbsp02
/
GRANT SELECT ON workorder TO sbsp03
/
GRANT SELECT ON workorder TO sbsp04
/
GRANT SELECT ON workorder TO sbspatlas
/
GRANT SELECT ON workorder TO sbspecolabor
/
GRANT SELECT ON workorder TO sbspengeletrica
/
GRANT SELECT ON workorder TO sbspjlh
/
GRANT SELECT ON workorder TO sbspmpe
/
GRANT SELECT ON workorder TO sbspmpe01
/
GRANT SELECT ON workorder TO sbspmpe02
/
GRANT SELECT ON workorder TO sbspmpe024
/
GRANT SELECT ON workorder TO sbspmpe069
/
GRANT SELECT ON workorder TO sbspntk
/
GRANT SELECT ON workorder TO sbspservtec
/
GRANT SELECT ON workorder TO sbspviatec
/
GRANT SELECT ON workorder TO sbsv01
/
GRANT SELECT ON workorder TO sbsv02
/
GRANT SELECT ON workorder TO sbsv03
/
GRANT SELECT ON workorder TO sbsv04
/
GRANT SELECT ON workorder TO sbsv06
/
GRANT SELECT ON workorder TO sbsvjohnson
/
GRANT SELECT ON workorder TO sbsvproclima
/
GRANT SELECT ON workorder TO sbsvtecnyt
/
GRANT SELECT ON workorder TO sbsvviatec
/
GRANT SELECT ON workorder TO sbte02
/
GRANT SELECT ON workorder TO sbte03
/
GRANT SELECT ON workorder TO sbte04
/
GRANT SELECT ON workorder TO sbte06
/
GRANT SELECT ON workorder TO sbtf02
/
GRANT SELECT ON workorder TO sbtf03
/
GRANT SELECT ON workorder TO sbtf04
/
GRANT SELECT ON workorder TO sbtt04
/
GRANT SELECT ON workorder TO sbul03
/
GRANT SELECT ON workorder TO sbul04
/
GRANT SELECT ON workorder TO sbur04
/
GRANT SELECT ON workorder TO sbvt03
/
GRANT SELECT ON workorder TO sbvt04
/
GRANT SELECT ON workorder TO sbvt06
/
GRANT SELECT ON workorder TO sbvtproen
/
GRANT SELECT ON workorder TO t512804691
/
GRANT SELECT ON workorder TO i9816768
/
GRANT SELECT ON workorder TO c2840324
/
GRANT SELECT ON workorder TO c02016414103
/
GRANT SELECT ON workorder TO i1224063
/
GRANT SELECT ON workorder TO i1224357
/
GRANT SELECT ON workorder TO c2650692
/
GRANT SELECT ON workorder TO c1677282
/
GRANT SELECT ON workorder TO c1841877
/
GRANT SELECT ON workorder TO c1778140
/
GRANT SELECT ON workorder TO i0607636
/
GRANT SELECT ON workorder TO i1191343
/
GRANT SELECT ON workorder TO i4548795
/
GRANT SELECT ON workorder TO c0046508
/
GRANT SELECT ON workorder TO i1193925
/
GRANT SELECT ON workorder TO sbfl06
/
GRANT SELECT ON workorder TO i9803977
/
GRANT SELECT ON workorder TO c4549417
/
GRANT SELECT ON workorder TO cmpe002sp
/
GRANT SELECT ON workorder TO sbspmpe002
/
GRANT SELECT ON workorder TO i3103263
/
GRANT SELECT ON workorder TO i9793162
/
GRANT SELECT ON workorder TO i5609993
/
GRANT SELECT ON workorder TO i5609699
/
GRANT SELECT ON workorder TO i5602621
/
GRANT SELECT ON workorder TO i9781956
/
GRANT SELECT ON workorder TO i5610917
/
GRANT SELECT ON workorder TO i1242061
/
GRANT SELECT ON workorder TO sbcgmpe
/
GRANT SELECT ON workorder TO cmpecg
/
GRANT SELECT ON workorder TO sbctelshadday
/
GRANT SELECT ON workorder TO celshadday
/
GRANT SELECT ON workorder TO c002203420
/
GRANT SELECT ON workorder TO i2393125
/
GRANT SELECT ON workorder TO i8407893
/
GRANT SELECT ON workorder TO i1224847
/
GRANT SELECT ON workorder TO i1230561
/
GRANT SELECT ON workorder TO i1223850
/
GRANT SELECT ON workorder TO sbegtecnyt
/
GRANT SELECT ON workorder TO ctecnyteg
/
GRANT SELECT ON workorder TO i6018525
/
GRANT SELECT ON workorder TO sbkpmpe0001
/
GRANT SELECT ON workorder TO sbkpmpe0003
/
GRANT SELECT ON workorder TO sbkpmpe0010
/
GRANT SELECT ON workorder TO sbkpmpe0012
/
GRANT SELECT ON workorder TO i9942175
/
GRANT SELECT ON workorder TO cmpe0001kp
/
GRANT SELECT ON workorder TO cmpe0003kp
/
GRANT SELECT ON workorder TO cmpe0010kp
/
GRANT SELECT ON workorder TO cmpe0012kp
/
GRANT SELECT ON workorder TO sbkptecnyt0009
/
GRANT SELECT ON workorder TO ctecnyt0009kp
/
GRANT DELETE ON workorder TO i1274141
/
GRANT SELECT ON workorder TO i1274141
/
GRANT UPDATE ON workorder TO i1274141
/
GRANT SELECT ON workorder TO i1263344
/
GRANT SELECT ON workorder TO sbmq03
/
GRANT SELECT ON workorder TO i9798147
/
GRANT SELECT ON workorder TO i9504106
/
GRANT SELECT ON workorder TO sbloartmultipla
/
GRANT SELECT ON workorder TO cartmultiplalo
/
GRANT SELECT ON workorder TO i1184240
/
GRANT SELECT ON workorder TO i4755790
/
GRANT SELECT ON workorder TO i1028747
/
GRANT SELECT ON workorder TO i1277916
/
GRANT SELECT ON workorder TO i1298611
/
GRANT SELECT ON workorder TO i1263932
/
GRANT SELECT ON workorder TO i1289416
/
GRANT SELECT ON workorder TO i1248043
/
GRANT SELECT ON workorder TO i1278129
/
GRANT SELECT ON workorder TO i1282829
/
GRANT SELECT ON workorder TO i1299216
/
GRANT SELECT ON workorder TO i1298415
/
GRANT SELECT ON workorder TO c0170008
/
GRANT SELECT ON workorder TO i1280639
/
GRANT SELECT ON workorder TO i1272539
/
GRANT SELECT ON workorder TO i1298709
/
GRANT SELECT ON workorder TO i1305847
/
GRANT SELECT ON workorder TO i1316056
/
GRANT SELECT ON workorder TO i1276625
/
GRANT SELECT ON workorder TO i1299902
/
GRANT SELECT ON workorder TO i1276723
/
GRANT SELECT ON workorder TO sbsvrenovar
/
GRANT SELECT ON workorder TO c1930325
/
GRANT SELECT ON workorder TO c4777302
/
GRANT SELECT ON workorder TO sbsbrenovar
/
GRANT SELECT ON workorder TO sbrf05
/
GRANT SELECT ON workorder TO t041488587
/
GRANT SELECT ON workorder TO c999555
/
GRANT SELECT ON workorder TO i1311365
/
GRANT SELECT ON workorder TO i1293920
/
GRANT SELECT ON workorder TO sbnt06
/
GRANT SELECT ON workorder TO c13018
/
GRANT SELECT ON workorder TO c13036
/
GRANT SELECT ON workorder TO i1245640
/
GRANT SELECT ON workorder TO prti01
/
GRANT SELECT ON workorder TO prti02
/
GRANT SELECT ON workorder TO prti03
/
GRANT SELECT ON workorder TO prti06
/
GRANT SELECT ON workorder TO prti10
/
GRANT SELECT ON workorder TO i0215757
/
GRANT SELECT ON workorder TO i0221176
/
GRANT SELECT ON workorder TO i1021866
/
GRANT SELECT ON workorder TO i1241064
/
GRANT SELECT ON workorder TO i1249040
/
GRANT SELECT ON workorder TO i1262445
/
GRANT SELECT ON workorder TO i1262641
/
GRANT SELECT ON workorder TO i1262837
/
GRANT SELECT ON workorder TO i1274337
/
GRANT SELECT ON workorder TO i1274435
/
GRANT SELECT ON workorder TO i9843765
/
GRANT SELECT ON workorder TO i9887051
/
GRANT SELECT ON workorder TO i9980851
/
GRANT SELECT ON workorder TO t004048181
/
GRANT SELECT ON workorder TO t008449945
/
GRANT SELECT ON workorder TO t016614681
/
GRANT SELECT ON workorder TO t021752031
/
GRANT SELECT ON workorder TO t035210786
/
GRANT SELECT ON workorder TO t059098886
/
GRANT SELECT ON workorder TO t182168541
/
GRANT SELECT ON workorder TO t261921951
/
GRANT SELECT ON workorder TO t339521081
/
GRANT SELECT ON workorder TO t398434161
/
GRANT SELECT ON workorder TO t400063871
/
GRANT SELECT ON workorder TO t461743701
/
GRANT SELECT ON workorder TO t512405641
/
GRANT SELECT ON workorder TO t516141111
/
GRANT SELECT ON workorder TO t570918626
/
GRANT SELECT ON workorder TO t658463891
/
GRANT SELECT ON workorder TO t666425741
/
GRANT SELECT ON workorder TO t673715402
/
GRANT SELECT ON workorder TO t693173301
/
GRANT SELECT ON workorder TO t693683091
/
GRANT SELECT ON workorder TO t694087771
/
GRANT SELECT ON workorder TO t697488021
/
GRANT SELECT ON workorder TO t703981861
/
GRANT SELECT ON workorder TO t710869511
/
GRANT SELECT ON workorder TO t723070801
/
GRANT SELECT ON workorder TO t733301321
/
GRANT SELECT ON workorder TO t781484991
/
GRANT SELECT ON workorder TO t799981861
/
GRANT SELECT ON workorder TO t802225011
/
GRANT SELECT ON workorder TO t807681801
/
GRANT SELECT ON workorder TO t832533861
/
GRANT SELECT ON workorder TO t834307251
/
GRANT SELECT ON workorder TO t865387211
/
GRANT SELECT ON workorder TO t954959081
/
GRANT SELECT ON workorder TO t973532300
/
GRANT SELECT ON workorder TO t833957331
/
GRANT SELECT ON workorder TO infraero
/
GRANT SELECT ON workorder TO adsede
/
GRANT SELECT ON workorder TO i1190738
/
GRANT SELECT ON workorder TO i1190836
/
GRANT SELECT ON workorder TO i1190934
/
GRANT SELECT ON workorder TO i1235546
/
GRANT SELECT ON workorder TO i1248827
/
GRANT SELECT ON workorder TO i1248925
/
GRANT SELECT ON workorder TO i1262739
/
GRANT SELECT ON workorder TO i1264145
/
GRANT SELECT ON workorder TO i1309443
/
GRANT SELECT ON workorder TO i9463679
/
GRANT SELECT ON workorder TO i9857749
/
GRANT SELECT ON workorder TO t033075157
/
GRANT SELECT ON workorder TO t057126701
/
GRANT SELECT ON workorder TO t071092908
/
GRANT SELECT ON workorder TO t071299698
/
GRANT SELECT ON workorder TO t077581927
/
GRANT SELECT ON workorder TO t509884414
/
GRANT SELECT ON workorder TO t563233871
/
GRANT SELECT ON workorder TO t610878581
/
GRANT SELECT ON workorder TO t645543411
/
GRANT SELECT ON workorder TO t666171891
/
GRANT SELECT ON workorder TO t691904961
/
GRANT SELECT ON workorder TO t828642411
/
GRANT SELECT ON workorder TO t995139271
/
GRANT SELECT ON workorder TO t638251397
/
GRANT SELECT ON workorder TO t183102731
/
GRANT SELECT ON workorder TO t725761381
/
GRANT SELECT ON workorder TO t710801551
/
GRANT SELECT ON workorder TO i0626435
/
GRANT SELECT ON workorder TO i1318148
/
GRANT SELECT ON workorder TO i1320266
/
GRANT SELECT ON workorder TO i9080994
/
GRANT SELECT ON workorder TO sbpp04
/
GRANT SELECT ON workorder TO i1752718
/
GRANT SELECT ON workorder TO i5109625
/
GRANT SELECT ON workorder TO i1278815
/
GRANT SELECT ON workorder TO i1257238
/
GRANT SELECT ON workorder TO i1100186
/
GRANT SELECT ON workorder TO i1316644
/
GRANT SELECT ON workorder TO i1297418
/
GRANT SELECT ON workorder TO i1225354
/
GRANT SELECT ON workorder TO i1800739
/
GRANT SELECT ON workorder TO i1297810
/
GRANT SELECT ON workorder TO sbcgtecma
/
GRANT SELECT ON workorder TO sbgrinterway070
/
GRANT SELECT ON workorder TO sbgrtenenge
/
GRANT SELECT ON workorder TO sbgrfinancial
/
GRANT SELECT ON workorder TO cinterway070gr
/
GRANT SELECT ON workorder TO ctecmancg
/
GRANT SELECT ON workorder TO sbcgtecman
/
GRANT SELECT ON workorder TO sbgrtecnenge
/
GRANT SELECT ON workorder TO cfinancialgr
/
GRANT SELECT ON workorder TO ctecnengegr
/
GRANT SELECT ON workorder TO i1160848
/
GRANT SELECT ON workorder TO i1152944
/
GRANT SELECT ON workorder TO i1062749
/
GRANT SELECT ON workorder TO i9675169
/
GRANT SELECT ON workorder TO i1222559
/
GRANT SELECT ON workorder TO i3027640
/
GRANT DELETE ON workorder TO i6030345
/
GRANT SELECT ON workorder TO i6030345
/
GRANT UPDATE ON workorder TO i6030345
/
GRANT SELECT ON workorder TO i4541717
/
GRANT SELECT ON workorder TO i9630592
/
GRANT SELECT ON workorder TO i4517809
/
GRANT SELECT ON workorder TO i9777942
/
GRANT SELECT ON workorder TO i9778253
/
GRANT SELECT ON workorder TO i1264439
/
GRANT SELECT ON workorder TO i1280541
/
GRANT SELECT ON workorder TO i1264537
/
GRANT SELECT ON workorder TO i1280345
/
GRANT SELECT ON workorder TO i1305749
/
GRANT SELECT ON workorder TO i1280737
/
GRANT SELECT ON workorder TO i1280835
/
GRANT SELECT ON workorder TO i1272441
/
GRANT SELECT ON workorder TO i1272343
/
GRANT SELECT ON workorder TO i1272147
/
GRANT SELECT ON workorder TO i1299020
/
GRANT SELECT ON workorder TO i1086239
/
GRANT SELECT ON workorder TO i8307015
/
GRANT SELECT ON workorder TO i1308544
/
GRANT SELECT ON workorder TO c1010791176
/
GRANT SELECT ON workorder TO c124
/
GRANT SELECT ON workorder TO c125
/
GRANT SELECT ON workorder TO i1282927
/
GRANT SELECT ON workorder TO i1314160
/
GRANT SELECT ON workorder TO i1298905
/
GRANT SELECT ON workorder TO i1290047
/
GRANT SELECT ON workorder TO i1300176
/
GRANT SELECT ON workorder TO i1301075
/
GRANT SELECT ON workorder TO i1189225
/
GRANT SELECT ON workorder TO i1188326
/
GRANT SELECT ON workorder TO i1036847
/
GRANT SELECT ON workorder TO cjohnsonmo
/
GRANT SELECT ON workorder TO i5307425
/
GRANT SELECT ON workorder TO i9883553
/
GRANT SELECT ON workorder TO i9829559
/
GRANT SELECT ON workorder TO i1093146
/
GRANT SELECT ON workorder TO i9850574
/
GRANT SELECT ON workorder TO i1237638
/
GRANT SELECT ON workorder TO i1276821
/
GRANT SELECT ON workorder TO i1240949
/
GRANT SELECT ON workorder TO i1316252
/
GRANT SELECT ON workorder TO sbvtcep
/
GRANT SELECT ON workorder TO ccepvt
/
GRANT SELECT ON workorder TO i0616831
/
GRANT SELECT ON workorder TO crenovarsv
/
GRANT SELECT ON workorder TO sbmojohnson
/
GRANT SELECT ON workorder TO sbmocm
/
GRANT SELECT ON workorder TO ccmmo
/
GRANT SELECT ON workorder TO i1317249
/
GRANT SELECT ON workorder TO sbsvengeforma
/
GRANT SELECT ON workorder TO cengeformasv
/
GRANT SELECT ON workorder TO i1312460
/
GRANT SELECT ON workorder TO sbgrmpe143
/
GRANT SELECT ON workorder TO cmpe143gr
/
GRANT SELECT ON workorder TO i1272931
/
GRANT SELECT ON workorder TO sbgrone020
/
GRANT SELECT ON workorder TO cone020gr
/
GRANT SELECT ON workorder TO i4106150
/
GRANT SELECT ON workorder TO i4749488
/
GRANT SELECT ON workorder TO i9949056
/
GRANT SELECT ON workorder TO c1796105
/
GRANT SELECT ON workorder TO i1173541
/
GRANT SELECT ON workorder TO c1880505
/
GRANT SELECT ON workorder TO c0048908
/
GRANT SELECT ON workorder TO i9993642
/
GRANT SELECT ON workorder TO sbnf02
/
GRANT SELECT ON workorder TO i9474280
/
GRANT SELECT ON workorder TO i4708114
/
GRANT SELECT ON workorder TO i9846168
/
GRANT SELECT ON workorder TO i4185023
/
GRANT SELECT ON workorder TO c0005509
/
GRANT SELECT ON workorder TO i0554630
/
GRANT SELECT ON workorder TO i4192224
/
GRANT SELECT ON workorder TO i9033220
/
GRANT SELECT ON workorder TO i9078778
/
GRANT SELECT ON workorder TO i4133931
/
GRANT SELECT ON workorder TO sbgrconsbem
/
GRANT SELECT ON workorder TO cconsbemgl
/
GRANT SELECT ON workorder TO sbglccvfgl
/
GRANT SELECT ON workorder TO ccvfgl
/
GRANT SELECT ON workorder TO sbglscheffer
/
GRANT SELECT ON workorder TO cscheffergl
/
GRANT SELECT ON workorder TO i9660090
/
GRANT SELECT ON workorder TO i0779009
/
GRANT SELECT ON workorder TO i6052919
/
GRANT SELECT ON workorder TO i9626186
/
GRANT SELECT ON workorder TO i199227
/
GRANT SELECT ON workorder TO sbglcvf
/
GRANT SELECT ON workorder TO i4727305
/
GRANT SELECT ON workorder TO i4727894
/
GRANT SELECT ON workorder TO sbme04
/
GRANT SELECT ON workorder TO i1287128
/
GRANT SELECT ON workorder TO i1287226
/
GRANT SELECT ON workorder TO i1233160
/
GRANT SELECT ON workorder TO c1066018
/
GRANT SELECT ON workorder TO c5746880
/
GRANT SELECT ON workorder TO c0203908
/
GRANT SELECT ON workorder TO i1311267
/
GRANT SELECT ON workorder TO i1315255
/
GRANT SELECT ON workorder TO i4157519
/
GRANT SELECT ON workorder TO i1318344
/
GRANT SELECT ON workorder TO i1315353
/
GRANT SELECT ON workorder TO c000222
/
GRANT SELECT ON workorder TO sbmk04
/
GRANT SELECT ON workorder TO i3281526
/
GRANT SELECT ON workorder TO i2354530
/
GRANT SELECT ON workorder TO i1300078
/
GRANT SELECT ON workorder TO i1225452
/
GRANT SELECT ON workorder TO i1293626
/
GRANT SELECT ON workorder TO i579313
/
GRANT SELECT ON workorder TO i0510854
/
GRANT SELECT ON workorder TO i6051530
/
GRANT SELECT ON workorder TO i6047614
/
GRANT SELECT ON workorder TO i1319733
/
GRANT SELECT ON workorder TO i3022067
/
GRANT SELECT ON workorder TO sbficlimasul
/
GRANT SELECT ON workorder TO cclimasulfi
/
GRANT SELECT ON workorder TO sbfigold
/
GRANT SELECT ON workorder TO sbfimetrosul
/
GRANT SELECT ON workorder TO cgold
/
GRANT SELECT ON workorder TO cmetrosul
/
GRANT SELECT ON workorder TO c6617885
/
GRANT SELECT ON workorder TO c6300278
/
GRANT SELECT ON workorder TO c6500
/
GRANT SELECT ON workorder TO i9923278
/
GRANT SELECT ON workorder TO sbcttecman
/
GRANT SELECT ON workorder TO ctecmanct
/
GRANT SELECT ON workorder TO sbmt04
/
GRANT SELECT ON workorder TO i9954165
/
GRANT SELECT ON workorder TO c0084309
/
GRANT SELECT ON workorder TO i1293822
/
GRANT SELECT ON workorder TO sbglcep
/
GRANT SELECT ON workorder TO ccepgl
/
GRANT SELECT ON workorder TO daag05
/
GRANT SELECT ON workorder TO i3249322
/
GRANT SELECT ON workorder TO c0245308
/
GRANT SELECT ON workorder TO c0008907
/
GRANT SELECT ON workorder TO i1295424
/
GRANT SELECT ON workorder TO i1224749
/
GRANT SELECT ON workorder TO i9680964
/
GRANT DELETE ON workorder TO t004790501
/
GRANT SELECT ON workorder TO t004790501
/
GRANT UPDATE ON workorder TO t004790501
/
GRANT SELECT ON workorder TO sbrjtecnenge01
/
GRANT SELECT ON workorder TO ctecnenge01rj
/
GRANT SELECT ON workorder TO ctecge01rj
/
GRANT SELECT ON workorder TO ctecge02rj
/
GRANT SELECT ON workorder TO cmpe02rj
/
GRANT SELECT ON workorder TO sbrjmpe01
/
GRANT SELECT ON workorder TO cmpe01rj
/
GRANT SELECT ON workorder TO chidrolabrj
/
GRANT SELECT ON workorder TO sbrjhidrolab01
/
GRANT SELECT ON workorder TO csupply01rj
/
GRANT SELECT ON workorder TO sbrjtecman01
/
GRANT SELECT ON workorder TO ctecman01rj
/
GRANT SELECT ON workorder TO sbrjtecman02
/
GRANT SELECT ON workorder TO ctecman02rj
/
GRANT SELECT ON workorder TO sbrjtekno
/
GRANT SELECT ON workorder TO cteknorj
/
GRANT SELECT ON workorder TO sbrjotis
/
GRANT SELECT ON workorder TO cotisrj
/
GRANT SELECT ON workorder TO sbpalobeck
/
GRANT SELECT ON workorder TO sblocomatic
/
GRANT SELECT ON workorder TO ccomaticlo
/
GRANT SELECT ON workorder TO i1279812
/
GRANT SELECT ON workorder TO clobeckpa
/
GRANT SELECT ON workorder TO sbgrmpe015
/
GRANT SELECT ON workorder TO cmpe015gr
/
GRANT SELECT ON workorder TO sbmotecman
/
GRANT SELECT ON workorder TO ctecmanmo
/
GRANT DELETE ON workorder TO sbmobitcom
/
GRANT SELECT ON workorder TO sbmobitcom
/
GRANT UPDATE ON workorder TO sbmobitcom
/
GRANT DELETE ON workorder TO cbitcommo
/
GRANT SELECT ON workorder TO cbitcommo
/
GRANT UPDATE ON workorder TO cbitcommo
/
GRANT SELECT ON workorder TO sbpatecman
/
GRANT SELECT ON workorder TO ctecmanpa
/
GRANT SELECT ON workorder TO sbctajardini
/
GRANT SELECT ON workorder TO cajardinict
/
GRANT SELECT ON workorder TO cmpe1kp
/
GRANT SELECT ON workorder TO cmpe2kp
/
GRANT SELECT ON workorder TO cmpe3kp
/
GRANT SELECT ON workorder TO cmpe4kp
/
GRANT SELECT ON workorder TO i9579260
/
GRANT SELECT ON workorder TO i9443393
/
GRANT SELECT ON workorder TO i9041418
/
GRANT SELECT ON workorder TO i1196230
/
GRANT SELECT ON workorder TO i9038696
/
GRANT SELECT ON workorder TO i4749586
/
GRANT SELECT ON workorder TO i9535288
/
GRANT SELECT ON workorder TO i9777158
/
GRANT SELECT ON workorder TO i4724314
/
GRANT SELECT ON workorder TO i1254737
/
GRANT SELECT ON workorder TO i1254345
/
GRANT SELECT ON workorder TO i0620649
/
GRANT SELECT ON workorder TO i5309321
/
GRANT SELECT ON workorder TO i1033954
/
GRANT SELECT ON workorder TO sbrftecman
/
GRANT SELECT ON workorder TO ctecmanrf
/
GRANT SELECT ON workorder TO i1139833
/
GRANT SELECT ON workorder TO i9649267
/
GRANT SELECT ON workorder TO c12369
/
GRANT SELECT ON workorder TO c12370
/
GRANT SELECT ON workorder TO c12371
/
GRANT SELECT ON workorder TO c12372
/
GRANT SELECT ON workorder TO c12373
/
GRANT SELECT ON workorder TO c12374
/
GRANT SELECT ON workorder TO c12375
/
GRANT SELECT ON workorder TO c12376
/
GRANT SELECT ON workorder TO c12377
/
GRANT SELECT ON workorder TO i1285820
/
GRANT SELECT ON workorder TO i1246637
/
GRANT SELECT ON workorder TO sbfztecman
/
GRANT SELECT ON workorder TO ctecmanfz
/
GRANT SELECT ON workorder TO srne01
/
GRANT SELECT ON workorder TO sbkpinterway
/
GRANT SELECT ON workorder TO cinterway01kp
/
GRANT SELECT ON workorder TO cinterway02kp
/
GRANT SELECT ON workorder TO cinterway03kp
/
GRANT SELECT ON workorder TO cinterway04kp
/
GRANT SELECT ON workorder TO cinterway05kp
/
GRANT SELECT ON workorder TO i0186496
/
GRANT DELETE ON workorder TO t707738071
/
GRANT SELECT ON workorder TO t707738071
/
GRANT UPDATE ON workorder TO t707738071
/
GRANT SELECT ON workorder TO cmpe015sp
/
GRANT SELECT ON workorder TO i9896442
/
GRANT SELECT ON workorder TO sbil04
/
GRANT SELECT ON workorder TO i9094782
/
GRANT SELECT ON workorder TO i1314846
/
GRANT SELECT ON workorder TO i1264047
/
GRANT SELECT ON workorder TO i9891947
/
GRANT SELECT ON workorder TO i1010873
/
GRANT SELECT ON workorder TO i1556128
/
GRANT SELECT ON workorder TO srsu01
/
GRANT SELECT ON workorder TO sbfu04
/
GRANT SELECT ON workorder TO sbuf04
/
GRANT SELECT ON workorder TO sbspmpe0006
/
GRANT SELECT ON workorder TO cmpe0006sp
/
GRANT SELECT ON workorder TO teste
/
GRANT SELECT ON workorder TO sbspmpe015
/
GRANT SELECT ON workorder TO cteste
/
GRANT SELECT ON workorder TO i9042219
/
GRANT SELECT ON workorder TO c8442915
/
GRANT SELECT ON workorder TO i9585072
/
GRANT SELECT ON workorder TO sbglvillarta
/
GRANT SELECT ON workorder TO cvillartagl
/
GRANT SELECT ON workorder TO srne04
/
GRANT SELECT ON workorder TO i0550544
/
GRANT SELECT ON workorder TO i0796893
/
GRANT SELECT ON workorder TO c4124429
/
GRANT SELECT ON workorder TO c4916000
/
GRANT SELECT ON workorder TO c6787878
/
GRANT SELECT ON workorder TO c5630005
/
GRANT SELECT ON workorder TO sbctlobeck
/
GRANT SELECT ON workorder TO clobeckct
/
GRANT SELECT ON workorder TO tecnico
/
GRANT SELECT ON workorder TO t794966445
/
GRANT SELECT ON workorder TO t715047881
/
GRANT SELECT ON workorder TO i1271444
/
GRANT SELECT ON workorder TO i1200769
/
GRANT SELECT ON workorder TO i9833769
/
GRANT SELECT ON workorder TO i1301859
/
GRANT SELECT ON workorder TO c0240409
/
GRANT SELECT ON workorder TO i1281342
/
GRANT SELECT ON workorder TO i1304850
/
GRANT SELECT ON workorder TO sblo03
/
GRANT SELECT ON workorder TO sbsvlobeck
/
GRANT SELECT ON workorder TO clobecksv
/
GRANT SELECT ON workorder TO c0034209
/
GRANT SELECT ON workorder TO i4104548
/
GRANT SELECT ON workorder TO sbcrchafic
/
GRANT SELECT ON workorder TO cchaficcr
/
GRANT SELECT ON workorder TO sbcttechservice
/
GRANT SELECT ON workorder TO sbjplcconst
/
GRANT SELECT ON workorder TO clcconstjp
/
GRANT SELECT ON workorder TO sbrjsuplly
/
GRANT SELECT ON workorder TO i9688156
/
GRANT SELECT ON workorder TO i7206617
/
GRANT SELECT ON workorder TO i4736402
/
GRANT SELECT ON workorder TO tmp01
/
GRANT SELECT ON workorder TO i4252725
/
GRANT SELECT ON workorder TO i9456184
/
GRANT SELECT ON workorder TO sbmomanut
/
GRANT SELECT ON workorder TO cmanutmo
/
GRANT SELECT ON workorder TO i1238439
/
GRANT SELECT ON workorder TO c8088270731
/
GRANT SELECT ON workorder TO i1853906
/
GRANT SELECT ON workorder TO i9080798
/
GRANT SELECT ON workorder TO sbegeletrocon
/
GRANT SELECT ON workorder TO celetroconge
/
GRANT SELECT ON workorder TO sbil01
/
GRANT SELECT ON workorder TO srno04
/
GRANT SELECT ON workorder TO sbkg04
/
GRANT SELECT ON workorder TO sbkg01
/
GRANT SELECT ON workorder TO i9633191
/
GRANT SELECT ON workorder TO i4114054
/
GRANT SELECT ON workorder TO sbsj04
/
GRANT SELECT ON workorder TO teste2
/
GRANT SELECT ON workorder TO sbsj004
/
GRANT SELECT ON workorder TO sbsj40
/
GRANT SELECT ON workorder TO i9989236
/
GRANT SELECT ON workorder TO sbpatecmanciv
/
GRANT SELECT ON workorder TO i0793901
/
GRANT SELECT ON workorder TO ctecman2pa
/
GRANT SELECT ON workorder TO i1233748
/
GRANT SELECT ON workorder TO ctechservct
/
GRANT SELECT ON workorder TO i9969930
/
GRANT DELETE ON workorder TO sbcf03a
/
GRANT SELECT ON workorder TO sbcf03a
/
GRANT UPDATE ON workorder TO sbcf03a
/
GRANT SELECT ON workorder TO sbmointercon
/
GRANT SELECT ON workorder TO cinterconmo
/
GRANT SELECT ON workorder TO ctechservfz
/
GRANT SELECT ON workorder TO cestmnse
/
GRANT SELECT ON workorder TO sbnflobeck
/
GRANT SELECT ON workorder TO clobecknf
/
GRANT DELETE ON workorder TO domn04
/
GRANT SELECT ON workorder TO domn04
/
GRANT UPDATE ON workorder TO domn04
/
GRANT SELECT ON workorder TO i1220075
/
GRANT SELECT ON workorder TO c00060
/
GRANT SELECT ON workorder TO i1347531
/
GRANT SELECT ON workorder TO sbbh04
/
GRANT SELECT ON workorder TO i9482086
/
GRANT SELECT ON workorder TO t715677711
/
GRANT SELECT ON workorder TO i1352934
/
GRANT SELECT ON workorder TO i1286131
/
GRANT SELECT ON workorder TO i1244349
/
GRANT SELECT ON workorder TO i1359717
/
GRANT SELECT ON workorder TO i1361443
/
GRANT SELECT ON workorder TO i1280149
/
GRANT SELECT ON workorder TO i0650441
/
GRANT SELECT ON workorder TO i1367915
/
GRANT SELECT ON workorder TO c72403
/
GRANT SELECT ON workorder TO c7305286087
/
GRANT SELECT ON workorder TO sbrflobeck
/
GRANT SELECT ON workorder TO i1361345
/
GRANT SELECT ON workorder TO c045175881
/
GRANT SELECT ON workorder TO c337442
/
GRANT SELECT ON workorder TO i1366820
/
GRANT SELECT ON workorder TO sbcfengeforma
/
GRANT SELECT ON workorder TO c00251509
/
GRANT SELECT ON workorder TO c0259809
/
GRANT SELECT ON workorder TO i1380928
/
GRANT SELECT ON workorder TO sbfztechservice
/
GRANT SELECT ON workorder TO c2384645
/
GRANT SELECT ON workorder TO c6028010
/
GRANT SELECT ON workorder TO c4544070
/
GRANT SELECT ON workorder TO c6379461
/
GRANT SELECT ON workorder TO i1366918
/



-- Triggers for WORKORDER

CREATE OR REPLACE TRIGGER tr_workorder_scom_ver_usuario
 BEFORE
  INSERT
 ON workorder
REFERENCING NEW AS NEW OLD AS OLD
 FOR EACH ROW
BEGIN
   :NEW.wopm7 := NULL;
   :NEW.wopm6 := NULL;

   IF :NEW.changeby <> 'IFRMAXIMO'
   THEN
      IF SUBSTR (:NEW.changeby, 1, 1) = 'I'
      THEN
         SELECT SUBSTR (user01, 1, 4), NULL
           INTO :NEW.wopm7, :NEW.wopm6
           FROM ifrmaximo.usuario
          WHERE usernum = :NEW.changeby;
      END IF;

      IF SUBSTR (:NEW.changeby, 1, 1) = 'T' AND :NEW.siteid = 'PRTI'
      THEN
         SELECT user01, 'PRTI'
           INTO :NEW.wopm7, :NEW.wopm6
           FROM ifrmaximo.usuario
          WHERE usernum = :NEW.changeby;
      END IF;

      IF SUBSTR (:NEW.changeby, 1, 1) = 'C'
      THEN
         SELECT SUBSTR (user01, 1, 4), user01
           INTO :NEW.wopm7, :NEW.wopm6
           FROM ifrmaximo.usuario
          WHERE usernum = :NEW.changeby;
      END IF;

      IF SUBSTR (:NEW.changeby, 1, 1) = 'T'
      THEN
         SELECT SUBSTR (user01, 1, 4), user01
           INTO :NEW.wopm7, :NEW.wopm6
           FROM ifrmaximo.usuario
          WHERE usernum = :NEW.changeby;
      END IF;

      IF (TRIM (:NEW.wopm7) IS NULL)
      THEN                                           -- DEPENDENCIA DO USUARIO
         raise_application_error
            (-20670,
                CHR (13)
             || ' -------------------------------'
             || CHR (13)
             || 'FAVOR ENTRAR EM CONTATO COM SUPORTE MAXIMO - USUÁRIO SEM DEPENDÊNCIA DE ORIGEM.'
             || CHR (13)
             || ' -------------------------------'
            );
      END IF;
   END IF;
END;
/

CREATE OR REPLACE TRIGGER tr_work_indisponibilidade
 BEFORE
   UPDATE OF status
 ON workorder
REFERENCING NEW AS NEW OLD AS OLD
 FOR EACH ROW
WHEN ( (NEW.siteid = 'INFRAERO')
)
DECLARE
BEGIN
   --

   IF (:NEW.status IN ('COMP', 'FECHADA'))
      AND:NEW.changeby IN ('I9830582', 'CTIS620')
   THEN
      :new.wo75   := (:new.actfinish - :new.actstart);
   END IF;
END;
/* Formatted on 4/6/2009 10:37:40 (QP5 v5.120.811.25008) */
/

CREATE OR REPLACE TRIGGER tr_workorder_indisponibilidade
 BEFORE
   UPDATE OF status
 ON workorder
REFERENCING NEW AS NEW OLD AS OLD
 FOR EACH ROW
WHEN ((NEW.siteid = 'INFRAERO')
)
DECLARE
   v_count    NUMBER (10);
   v_count2   NUMBER (10);
   v_msg      VARCHAR2 (800);
   v_erro     NUMBER (1);
   v_ativo    ifrmaximo.equipment.eq22%TYPE   := '';
BEGIN
--
   v_msg := CHR (13) || ' -------------------------------' || CHR (13);
   v_erro := 0;

   IF     (:NEW.status IN ('COMP', 'FECHADA'))
      AND :NEW.changeby IN ('I9830582', 'CTIS620')
   THEN
      --  OR TO_CHAR ((:NEW.wo19), '00,00') = '99,99'
      IF (TRIM (:NEW.wo19) = 99.99)
      THEN
         raise_application_error
                    (-20900,
                     fun_formatar_msg ('Digite o TEMPO DE INDISPONIBILIDADE.')
                    );
      END IF;

      IF TRIM (:NEW.wo19) IS NULL
      THEN
         raise_application_error
            (-20901,
             fun_formatar_msg
                          ('Digite TEMPO DE INDISPONIBILIDADE do equipamento.')
            );
      END IF;

      IF LENGTH (TRIM (:NEW.wo19)) = 0
      THEN
         raise_application_error
            (-20902,
             fun_formatar_msg
                          ('Digite TEMPO DE INDISPONIBILIDADE do equipamento.')
            );
      END IF;

      IF     (:NEW.status = 'FECHADA')
         AND :NEW.changeby IN ('I9830582', 'CTIS620')
      THEN
         IF :NEW.glaccount IS NULL
         THEN
            v_msg :=
                  v_msg
               || '-'
               || ' FAVOR INSIRA O CENTRO DE CUSTO BENEFICIÁRIO.'
               || SQLERRM
               || CHR (13);
            v_erro := 1;
         END IF;
      END IF;

      IF v_erro = 1
      THEN
         raise_application_error (-20669,
                                     v_msg
                                  || ' ------------------------------- '
                                  || CHR (13)
                                 );
      END IF;
   END IF;
END;
/

CREATE OR REPLACE TRIGGER tr_workorder_scom_mao_de_obra
 BEFORE
   UPDATE OF status
 ON workorder
REFERENCING NEW AS NEW OLD AS OLD
 FOR EACH ROW
WHEN ((NEW.siteid = 'INFRAERO')
)
DECLARE
   contador   NUMBER                             := 0;
   v_rows     ifrmaximo.labtrans.rowstamp%TYPE   := '';
BEGIN
   IF (:NEW.status IN ('COMP', 'FECHADA')) AND :NEW.changeby IN ('I9830582')
   THEN
      BEGIN
         IF LENGTH (TRIM (:NEW.actlabhrs)) = 1
         THEN
            raise_application_error
               (-20910,
                fun_formatar_msg
                          ('OBRIGATORIAMENTE DEVE SER INCLUÍDA A MÃO DE OBRA.')
               );
         END IF;
      END;
   END IF;
END;
/

CREATE OR REPLACE TRIGGER workorder_campos_obrigatorios
 BEFORE
  INSERT
 ON workorder
REFERENCING NEW AS NEW OLD AS OLD
 FOR EACH ROW
DECLARE
BEGIN
   IF :NEW.changeby IN ('I9830582', 'CTIS620')
   THEN
      :NEW.wo19 := 99.99;
   END IF;
END;
/

CREATE OR REPLACE TRIGGER workorder_t
 BEFORE
  INSERT
 ON workorder
REFERENCING NEW AS NEW OLD AS OLD
 FOR EACH ROW
DECLARE NEXTVAL INTEGER; BEGIN SELECT MAXSEQ.NEXTVAL INTO NEXTVAL FROM DUAL; :NEW.ROWSTAMP := NEXTVAL; END;
/

CREATE OR REPLACE TRIGGER tr_workorder_scom_verificacao
 BEFORE
  UPDATE
 ON workorder
REFERENCING NEW AS NEW OLD AS OLD
 FOR EACH ROW
WHEN ((NEW.status IN ('COMP', 'FECHADA') AND (NEW.siteid = 'INFRAERO'))
)
DECLARE
    --
    v_count      NUMBER (10);
/*ADVICE(3): This item should be defined in a deeper scope [558] */
    v_count2     NUMBER (10);
/*ADVICE(5): This item should be defined in a deeper scope [558] */
    v_count3     NUMBER (10);
/*ADVICE(7): Unreferenced variable [553] */
    v_msg        VARCHAR2 (800);
/*ADVICE(9): VARCHAR2 declaration with length greater than 500
                  characters [307] */
    v_erro       NUMBER (1);
    v_eq_ativo   ifrmaximo.equipment.eq22%TYPE := '';
/*ADVICE(13): This item has not been declared, or it refers to a label [131] */
/*ADVICE(14): In Oracle 8 strings of zero length assigned to CHAR
                  variables will blank-pad these rather than making them NULL [111] */
    TEMPO        IFRMAXIMO.WORKORDER.WO75%TYPE := '';
/*ADVICE(17): This item has not been declared, or it refers to a label [131] */
/*ADVICE(18): In Oracle 8 strings of zero length assigned to CHAR
                  variables will blank-pad these rather than making them NULL [111] */
    V_LOCATION   IFRMAXIMO.WORKORDER.LOCATION%TYPE := '';
/*ADVICE(21): Unreferenced variable [553] */
/*ADVICE(22): This item has not been declared, or it refers to a label [131] */
/*ADVICE(23): In Oracle 8 strings of zero length assigned to CHAR
                  variables will blank-pad these rather than making them NULL [111] */
BEGIN
    --
    v_msg := CHR (13) || ' -------------------------------' || CHR (13);
    v_erro := 0;

    --
    -- testar os campos
    --
    /* ifrmaximo.prc_verifica_campos (:NEW.STATUS,
     :NEW.eqnum,
     :NEW.worktype,
     :NEW.wo20,
     :NEW.wo1,
     :NEW.glaccount,
     :NEW.LOCATION,
     v_erro,
     v_msg
     );
    */
    --
    -- MATERIAL APLICADO
    --
    BEGIN
/*ADVICE(48): Nested blocks should all be labeled [407] */
        SELECT  COUNT (itemnum)
/*ADVICE(50): SELECT COUNT used to obtain number of rows for specified
                  WHERE clause [309] */
          INTO  v_count
          FROM  invreserve
         WHERE  wonum = :NEW.wonum;

        IF v_count <> 0
        THEN
            SELECT  COUNT (itemnum)
/*ADVICE(59): SELECT COUNT used to obtain number of rows for specified
                  WHERE clause [309] */
              INTO  v_count2
              FROM  matusetrans
             WHERE  refwo = :NEW.wonum;

            IF v_count2 = 0
            THEN
                v_msg :=
                    v_msg || '-'
                    || ' O MATERIAL SOLICITADO NÃO FOI APLICADO. VERIFICAR ITENS RESERVADOS'
                    || CHR (13);
                v_erro := 1;
            END IF;
        END IF;
    EXCEPTION
        WHEN OTHERS
/*ADVICE(76): A WHEN OTHERS clause is used in the exception section
                  without any other specific handlers [201] */
        THEN
            v_msg :=
                    v_msg
                || '-'
                || ' Problema ao verificar material solicitado'
                || SQLERRM
                || CHR (13);
            v_erro := 1;
    --  raise_application_error (-20669, SQLERRM);
    END;



    IF :NEW.changeby IN ('CTIS620', 'I9830582')
/*ADVICE(92): This item has not been declared, or it refers to a label [131] */
    THEN
        IF :NEW.eqnum IS NOT NULL
/*ADVICE(95): This item has not been declared, or it refers to a label [131] */
        THEN
            SELECT  eq22
              INTO  v_eq_ativo
              FROM  equipment
             WHERE       eqnum = :NEW.eqnum
                        AND siteid = 'INFRAERO'
                        AND orgid = 'INFRAERO';

            IF v_eq_ativo = 'N'
            THEN
                v_msg :=
                        v_msg
                    || '-'
                    || ' EQUIPAMENTO INATIVO NÃO PODE SER SELECIONADO.'
                    || SQLERRM
                    || CHR (13);
                v_erro := 1;
            END IF;
        END IF;
    END IF;



    IF :NEW.STATUS = 'FECHADA'
/*ADVICE(120): This item has not been declared, or it refers to a label [131] */
    THEN
        TEMPO :=
            ROUND ( (1440
/*ADVICE(124): This point cannot be reached (dead code) [123] */
/*ADVICE(125): This point cannot be reached (dead code) [123] */
/*ADVICE(126): This point cannot be reached (dead code) [123] */
                        + ( (TO_NUMBER (:NEW.ACTFINISH - :NEW.ACTSTART) * 1440)
/*ADVICE(128): This point cannot be reached (dead code) [123] */
/*ADVICE(129): This point cannot be reached (dead code) [123] */
/*ADVICE(130): This point cannot be reached (dead code) [123] */
/*ADVICE(131): This item has not been declared, or it refers to a label [131] */
/*ADVICE(132): This item has not been declared, or it refers to a label [131] */
                            - 1440))
                     / 60, 2);
/*ADVICE(135): This point cannot be reached (dead code) [123] */
        :NEW.WO75 := TEMPO;
/*ADVICE(137): This item has not been declared, or it refers to a label [131] */
/*ADVICE(138): This point cannot be reached (dead code) [123] */
    END IF;

    IF v_erro = 1
    THEN
        raise_application_error (-20669,
/*ADVICE(144): This item has not been declared, or it refers to a label [131] */
/*ADVICE(145): Use of RAISE_APPLICATION_ERROR built-in with a hard-coded
                  -20,NNN error number or hard-coded message [207] */
        v_msg || ' ------------------------------- ' || CHR (13));
    END IF;
END;
/* Formatted on 22/09/2009 08:51:32 (QP5 v5.120.811.25008) */
/

CREATE OR REPLACE TRIGGER tr_workorder_prti_criterios
 BEFORE
   INSERT OR UPDATE OF wo53
 ON workorder
REFERENCING NEW AS NEW OLD AS OLD
 FOR EACH ROW
WHEN ((NEW.siteid = 'PRTI'))
DECLARE
   v_destinatario     viw_age_empregados.email%TYPE            := '0';
   v_assunto          viw_age_empregados.nome%TYPE             := '0';
   v_cod_emp          ifrmaximo.workorder.wo61%TYPE            := '0';
   v_conf_matricula   ifrmaximo.workorder.wo48%TYPE            := '0';
   v_nome_gestor      ifrmaximo.equipment.nome_gestor%TYPE     := '0';
   v_email_gestor     ifrmaximo.equipment.e_mail_gestor%TYPE   := '0';
   v_nome_lider       ifrmaximo.equipment.nome_lider%TYPE      := '0';
   v_email_lider      ifrmaximo.equipment.e_mail_lider%TYPE    := '0';
   v_assunto_gestor   VARCHAR2 (100)                           := '0';
   v_assunto_lider    VARCHAR2 (100)                           := '0';
   v_cod_matricula    NUMBER (7)                               := 0;
   v_cont             NUMBER (1)                               := 0;

   CURSOR x (v_sistema VARCHAR2, v_cod_gestor VARCHAR2)
   IS
      SELECT a.nome_gestor, a.e_mail_gestor, a.nome_lider, a.e_mail_lider
        FROM equipment a
       WHERE a.eqnum = v_sistema
         AND a.siteid = 'PRTI'
         AND a.orgid = 'INFRAERO'
         AND a.cod_gestor = v_cod_gestor;
BEGIN
   v_cont := 0;

   FOR c IN x (:NEW.eqnum, :NEW.changeby)
   LOOP
      v_cont := 1;

      IF :NEW.wo53 IS NOT NULL
      THEN                                                         -- PARECER
         IF :NEW.wo52 IS NULL
         THEN                                                -- CLASSIFICAÇÃO
            raise_application_error
                      (-20902,
                       'FAVOR AGUARDAR A CLASSIFICAÇÃO DO GESTOR DO SISTEMA.'
                      );
         ELSE
            IF :NEW.wo53 = 'DISCORDO'
            THEN
               :NEW.status := 'AAPRV';
               :NEW.wo74 := 'AGUARDANDO APROVAÇÃO';

               INSERT INTO wostatus
                           (wonum, status, changedate,
                            changeby, glaccount, orgid, siteid
                           )
                    VALUES (:NEW.wonum, :NEW.status, :NEW.changedate,
                            :NEW.changeby, :NEW.glaccount, :NEW.orgid, 'PRTI'
                           );

               v_nome_gestor := c.nome_gestor;
               v_email_gestor := c.e_mail_gestor;
               v_assunto_gestor :=
                     'SAC-TISI: Ordem de Serviço Nº '
                  || :NEW.wonum
                  || ' / '
                  || :NEW.eqnum
                  || ' - Gestor.';
               v_nome_lider := c.nome_lider;
               v_email_lider := c.e_mail_lider;
               v_assunto_lider :=
                     'SAC-TISI: Ordem de Serviço Nº '
                  || :NEW.wonum
                  || ' / '
                  || :NEW.eqnum
                  || ' - DEVOLVIDA.';

               BEGIN
                  prc_envia_email
                     ('suporte_tisi@infraero.gov.br',
                      v_email_gestor,
                      v_assunto_gestor,
                         'Prezado Gestor '
                      || v_nome_gestor
                      || ', a Ordem de Serviço: '
                      || :NEW.wonum
                      || ' / '
                      || :NEW.description
                      || '" voltou para status AAPRV(Aguardando Aprovacao). Favor entrar em contato com o Lider do Projeto.
                Esta e uma mensagem automatica, favor nao responder.
                Atenciosamente,
                Gerencia de Sistemas.'
                     );
                  :NEW.wo61 :=
                        'Foi enviado um e-mail de confirmação para o usuário: '
                     || v_cod_emp
                     || ' / '
                     || v_destinatario
                     || '. E para o Gestor '
                     || v_nome_gestor
                     || ' no endereço '
                     || v_email_gestor
                     || '.';
               EXCEPTION
                  WHEN OTHERS
                  THEN
                     :NEW.wo61 :=
                              'Não foi possível enviar e-mail para o Gestor.';
               END;
            END IF;
         END IF;
      ELSE
         IF :NEW.wo60 IS NOT NULL
         THEN
            raise_application_error
                                  (-20903,
                                   'FAVOR PREENCHER PRIMEIRAMENTE O PARECER.'
                                  );
         END IF;
      END IF;
   END LOOP;
END;
/

CREATE OR REPLACE TRIGGER tr_workorder_prti_status_lider
 BEFORE
   UPDATE OF wo60, wo53, wo74
 ON workorder
REFERENCING NEW AS NEW OLD AS OLD
 FOR EACH ROW
WHEN ((NEW.siteid = 'PRTI'))
DECLARE
   v_nome_gestor      ifrmaximo.equipment.nome_gestor%TYPE     := '0';
   v_email_gestor     ifrmaximo.equipment.e_mail_gestor%TYPE   := '0';
   v_assunto_gestor   VARCHAR2 (100)                           := '0';
   v_count_mo         INTEGER (2)                              := 0;

   CURSOR x (v_sistema VARCHAR2)
   IS
      SELECT a.nome_gestor, a.e_mail_gestor, a.nome_lider, a.e_mail_lider
        FROM equipment a
       WHERE a.siteid = 'PRTI' AND a.orgid = 'INFRAERO'
             AND a.eqnum = v_sistema;
BEGIN
   IF :NEW.siteid = 'PRTI'
   THEN
      IF :NEW.wo74 = 'EM ANDAMENTO'
      THEN
         :NEW.status := 'EMAND';
         :NEW.wo74 := 'EM ANDAMENTO';

         INSERT INTO wostatus
                     (wonum, status, changedate,
                      changeby, glaccount, orgid, siteid
                     )
              VALUES (:NEW.wonum, :NEW.status, :NEW.changedate,
                      :NEW.changeby, :NEW.glaccount, :NEW.orgid, 'PRTI'
                     );

         :NEW.wo61 :=
            'Este chamado foi aceito pelo Líder de Projeto, e será repassado à Equipe Técnica Responsável.';
      END IF;

      IF :NEW.wo74 = 'AGUARDANDO APROVAÇÃO'
      THEN
         :NEW.status := 'AAPRV';
         :NEW.wo74 := 'AGUARDANDO APROVAÇÃO';

         INSERT INTO wostatus
                     (wonum, status, changedate,
                      changeby, glaccount, orgid, siteid
                     )
              VALUES (:NEW.wonum, :NEW.status, :NEW.changedate,
                      :NEW.changeby, :NEW.glaccount, :NEW.orgid, 'PRTI'
                     );

         :NEW.wo61 := 'Ordem de Serviço em análise.';
      END IF;

      IF :NEW.wo74 = 'APROVADA'
      THEN
         :NEW.status := 'EMAND';
         :NEW.wo74 := 'EM ANDAMENTO';

         --:NEW.status := 'APRV';
         --:NEW.wo74 := 'APROVADA';
         INSERT INTO wostatus
                     (wonum, status, changedate,
                      changeby, glaccount, orgid, siteid
                     )
              VALUES (:NEW.wonum, :NEW.status, :NEW.changedate,
                      :NEW.changeby, :NEW.glaccount, :NEW.orgid, 'PRTI'
                     );

         :NEW.wo61 := 'Ordem de Serviço Aprovada pelo Líder de Projeto';
      END IF;

      IF (:NEW.wo73 IS NULL) OR (LENGTH (TRIM (:NEW.wo73)) = 0)
      THEN
         :NEW.wo53 := NULL;
         :NEW.wo60 := NULL;
       --  :NEW.wo74 := '';
      --   raise_application_error (-20699,
      --                             'AGUARDE A APROVAÇÃO DO GESTOR DO SISTEMA.'
      --                            );
      END IF;

      IF (:NEW.wo53 = 'DISCORDO') AND (:NEW.status = 'EMAND')
      THEN
         /*   SELECT COUNT (*)
              INTO v_count_mo
              FROM labtrans
             WHERE refwo = :NEW.wonum AND siteid = 'PRTI' AND orgid = 'INFRAERO';

            IF v_count_mo <> 0
            THEN*/
         raise_application_error
            (-20699,
             'SR(A). LÍDER DE PROJETO. ESTE CHAMADO NÃO PODE SER "DISCORDADO", POIS ENCONTRA-SE "EM ANDAMENTO".'
            );
      END IF;

      IF :NEW.wo74 = 'APROVADA'
      THEN
         IF     (:NEW.wo53 IS NULL)
            AND ((:NEW.wo60 IS NOT NULL) OR (LENGTH (TRIM (:NEW.wo60)) <> 0))
         THEN
            raise_application_error
               (-20699,
                'SR(A). LÍDER DE PROJETO, POR FAVOR, PREENCHA O CAMPO  TIPO DO PARECER.'
               );
         END IF;

         IF     (:NEW.wo53 = 'DISCORDO')
            AND ((:NEW.wo60 IS NULL) OR (LENGTH (TRIM (:NEW.wo60)) = 0))
         THEN
            raise_application_error
                        (-20699,
                         'SR(A). LÍDER DE PROJETO. JUSTIFIQUE O SEU PARECER.'
                        );
         END IF;

         IF (:NEW.wo53 = 'CONCORDO')
         THEN
            :NEW.status := 'EMAND';
            :NEW.wo74 := 'EM ANDAMENTO';

            INSERT INTO wostatus
                        (wonum, status, changedate,
                         changeby, glaccount, orgid, siteid
                        )
                 VALUES (:NEW.wonum, :NEW.status, :NEW.changedate,
                         :NEW.changeby, :NEW.glaccount, :NEW.orgid, 'PRTI'
                        );

            :NEW.wo61 :=
               'Este chamado foi aceito pelo Líder de Projeto, e será repassado à Equipe Técnica Responsável.';
         END IF;

         IF (:NEW.wo53 = 'DISCORDO')
         THEN
            :NEW.status := 'AAPRV';
            :NEW.wo74 := 'AGUARDANDO APROVAÇÃO';

            INSERT INTO wostatus
                        (wonum, status, changedate,
                         changeby, glaccount, orgid, siteid,
                         memo
                        )
                 VALUES (:NEW.wonum, :NEW.status, :NEW.changedate,
                         :NEW.changeby, :NEW.glaccount, :NEW.orgid, 'PRTI',
                         :NEW.wo60
                        );

            --   :NEW.wo53 := TRIM ('');
            :NEW.wo73 := TRIM ('');
            :NEW.wo52 := TRIM ('');
            :NEW.wo61 :=
               'Este chamado não foi aceito pelo Lider de Projeto, sendo assim repassado ao Gestor do Sistema para nova "APROVAÇÃO".';
         END IF;                    --  ALTERÇÃO DO STATUS DA ORDEM DE SERVIÇO
      END IF;
   END IF;

   IF (:OLD.wo74 <> 'APROVADA') AND :NEW.wo74 = 'AGUARDANDO APROVAÇÃO'
   THEN
      :NEW.status := 'AAPRV';

      INSERT INTO wostatus
                  (wonum, status, changedate, changeby,
                   glaccount, orgid, siteid, memo
                  )
           VALUES (:NEW.wonum, :NEW.status, :NEW.changedate, :NEW.changeby,
                   :NEW.glaccount, :NEW.orgid, 'PRTI', :NEW.wo60
                  );

      :NEW.wo73 := NULL;
      :NEW.wo52 := NULL;

      --   :NEW.wo53 := NULL;
      FOR aprov IN x (:NEW.eqnum)
      LOOP
            /*     v_nome_gestor := aprov.nome_gestor;
                 v_email_gestor := aprov.e_mail_gestor;
                 v_assunto_gestor :=
                       'SAC TISI: Ordem de Serviço Nº '
                    || :NEW.wonum
                    || ' - "CANCELADA" pelo Líder de Projeto.';
                 prc_envia_email
                    ('suporte_tisi@infraero.gov.br',
                     v_email_gestor,
                     v_assunto_gestor,
                        'Prezado '
                     || v_nome_gestor
                     || '.
                        O chamado aberto sob o Nº '
                     || :NEW.wonum
                     || ' com a descrição: "'
                     || :NEW.description
                     || '"'
                     || ' foi "CANCELADO" pelo Líder de Projeto.

                    Atenciosamente,
                    Gerência de Sistemas.'
                    );
                 :NEW.wo61 :=
                    'Este chamado foi "CANCELADO" pelo Líder de Projeto e devolvido ao Gestor do Sistema.'; */
         --   :NEW.wo61 := 'Este chamado foi "CANCELADO" pelo Líder de Projeto.';
         NULL;
      END LOOP;
   END IF;

   IF :NEW.wo74 = 'EM ANDAMENTO'
   THEN
      :NEW.status := 'EMAND';

      INSERT INTO wostatus
                  (wonum, status, changedate, changeby,
                   glaccount, orgid, siteid
                  )
           VALUES (:NEW.wonum, :NEW.status, :NEW.changedate, :NEW.changeby,
                   :NEW.glaccount, :NEW.orgid, 'PRTI'
                  );

      :NEW.wo61 :=
         'Este chamado foi aceito pelo Líder de Projeto, e será repassado à Equipe Técnica Responsável.';
   END IF;

   IF :NEW.wo74 = 'CANCELADA'
   THEN
      :NEW.status := 'CAN';
      :NEW.historyflag := 'S';

      INSERT INTO wostatus
                  (wonum, status, changedate, changeby,
                   glaccount, orgid, siteid, memo
                  )
           VALUES (:NEW.wonum, :NEW.status, :NEW.changedate, :NEW.changeby,
                   :NEW.glaccount, :NEW.orgid, 'PRTI', :NEW.wo60
                  );

      :NEW.wo61 :=
                'Esta Ordem de Serviço foi "CANCELADA" pelo Líder de Projeto.';
   END IF;

   IF :NEW.wo74 = 'FECHADA'
   THEN
      :NEW.status := 'FECHADA';
      :NEW.historyflag := 'S';

      INSERT INTO wostatus
                  (wonum, status, changedate, changeby,
                   glaccount, orgid, siteid
                  )
           VALUES (:NEW.wonum, :NEW.status, :NEW.changedate, :NEW.changeby,
                   :NEW.glaccount, :NEW.orgid, 'PRTI'
                  );
   END IF;
END;
/

CREATE OR REPLACE TRIGGER tr_workorder_prti_fechamento
 BEFORE
   UPDATE OF wo74
 ON workorder
REFERENCING NEW AS NEW OLD AS OLD
 FOR EACH ROW
WHEN ((NEW.siteid = 'PRTI') AND (NEW.wo74 IN ('FECHADA', 'CANCELADA'))
)
DECLARE
   v_destinatario     viw_age_empregados.email%TYPE   := '0';
   v_assunto          VARCHAR2 (200)                  := '0';
   v_cont             NUMBER (1)                      := 0;
   v_contx            NUMBER (1)                      := 0;
   v_cod_matricula    NUMBER (7)                      := 0;
   v_cod_emp          ifrmaximo.workorder.wo61%TYPE   := '0';
   v_conf_matricula   ifrmaximo.workorder.wo48%TYPE   := '0';
   v_msg              VARCHAR2 (400)                  := '';
   crlf               VARCHAR2 (2)                    := CHR (13) || CHR (10);

   CURSOR x (v_sistema VARCHAR2)
   IS
      SELECT a.nome_gestor, a.e_mail_gestor, a.nome_lider, a.e_mail_lider,
             eq20
        FROM equipment a
       WHERE a.eqnum = v_sistema AND a.siteid = 'PRTI'
             AND a.orgid = 'INFRAERO';

   CURSOR y (v_cpf VARCHAR2)
   IS
      SELECT y.nome, y.dependencia, y.lotacao, y.voip, y.email
        FROM viw_age_empregados y
       WHERE TRIM (SUBSTR (y.cpf, 1, LENGTH (TRIM (y.cpf)) - 2)) LIKE v_cpf;

   CURSOR z (v_mat NUMBER)
   IS
      SELECT z.nome, z.dependencia, z.lotacao, z.voip, z.email
        FROM viw_age_empregados z
       WHERE z.matricula = v_mat;

   CURSOR lab (v_wonum VARCHAR2)
   IS
      SELECT *
        FROM labtrans
       WHERE refwo = v_wonum AND siteid = 'PRTI' AND orgid = 'INFRAERO';
BEGIN
   IF :NEW.status = 'FECHADAA' AND :NEW.wo74 <> 'FECHADA'
   THEN
      :NEW.wo74 := 'FECHADA';
   END IF;

   IF (LENGTH (TRIM (:NEW.wo46)) = 0 OR (:NEW.wo46 IS NULL))
   THEN
      raise_application_error (-20901,
                                  'O CAMPO '
                               || '"'
                               || 'LOGIN'
                               || '"'
                               || ' ESTÁ EM BRANCO.'
                              );
   ELSE
      IF     LENGTH (TRIM (:NEW.wo46)) = 8
         AND SUBSTR (TRIM (UPPER (:NEW.wo46)), 1, 1) = 'I'
      THEN
         v_cont := 0;
         v_cod_matricula := TO_NUMBER (SUBSTR (TRIM (:NEW.wo46), 2, 7));

         FOR a IN z (v_cod_matricula)
         LOOP
            v_cont := 1;
            :NEW.wo47 := a.nome;
            :NEW.wo49 := a.dependencia;
            :NEW.wo50 := a.lotacao;
            :NEW.wo51 := a.voip;
            v_destinatario := TRIM (a.email);
         END LOOP;
      END IF;

      IF     LENGTH (TRIM (:NEW.wo46)) = 10
         AND SUBSTR (TRIM (UPPER (:NEW.wo46)), 1, 1) = 'T'
      THEN
         v_cont := 0;
         v_cod_emp :=
                 TRIM (TO_CHAR (TO_NUMBER (SUBSTR (TRIM (:NEW.wo46), 2, 9))));

         FOR b IN y (v_cod_emp)
         LOOP
            v_cont := 1;
            :NEW.wo47 := b.nome;
            :NEW.wo49 := b.dependencia;
            :NEW.wo50 := b.lotacao;
            :NEW.wo51 := b.voip;
            v_destinatario := TRIM (b.email);
         END LOOP;
      END IF;

      IF :NEW.wo74 = 'FECHADA'
      THEN
         v_contx := 0;

         FOR execucao IN lab (:NEW.wonum)
         LOOP
            v_contx := 1;

            IF    execucao.dt_inicio IS NULL
               OR execucao.hr_inicio IS NULL
               OR execucao.dt_termino IS NULL
               OR execucao.hr_termino IS NULL
            THEN
               raise_application_error
                  (-20699,
                   fun_formatar_msg
                      ('Foi Detectado no fechamento da OS, um erro do preenchimento de informação da Tarefa.Para corrigir é necessario que informe data e hora de inicio e termino efetiva da tarefa.'
                      )
                  );
            END IF;
         END LOOP;

--
         IF v_contx = 0
         THEN
            v_msg :=
                  crlf
               || crlf
               || '<<< ERRO DO SISTEMA >>>'
               || crlf
               || ' Foi Detectado no fechamento da OS, que não existe tarefa executada.'
               || crlf
               || ' Solicito que execute o CANCELAMENTO da OS.'
               || crlf
               || '>>> FIM DA MENSAGEM <<< '
               || crlf
               || crlf;
            raise_application_error
               (-20699,
                fun_formatar_msg
                   (' Foi Detectado no fechamento da OS, que não existe tarefa executada. Solicito que execute o CANCELAMENTO da OS.'
                   )
               );
         END IF;

--
         IF (v_destinatario) IS NULL
         THEN
            FOR lider IN x (:NEW.eqnum)
            LOOP
               :NEW.wo61 :=
                     'OS - FECHADA. Não foi enviado E-mail de Fechamento para o Solicitante: '
                  || :NEW.wo46
                  || ' - VERIFICAR OS DADOS DE SOLICITANTE NO CATÁLOGO DA INFRAERO.';
            END LOOP;
         ELSE
            v_assunto :=
                  'SAC-TISI: '
               || :NEW.wonum
               || ' / '
               || :NEW.eqnum
               || ' - FECHAMENTO.';
            prc_envia_email
               ('suporte_tisi@infraero.gov.br',
                v_destinatario,
                v_assunto,
                   'Prezado Solicitante,
                 O chamado registrado com o Numero '
                || :NEW.wonum
                || ',com a descricao '
                || :NEW.description
                || ', foi atendido e a Ordem de Servico está FECHADA.
            Esta e uma mensagem automatica, favor nao responder.
             http://sactisi.infranet.gov.br:81/jsp/common/system/login.jsp?username=infraero&password=infraero
            Atenciosamente,
            Gerencia de Sistemas.'
               );
            :NEW.wo61 :=
               'Ordem de Serviço está "FECHADA" e foi enviado E-mail de confirmação de Atendimento para Solicitante.';
         END IF;
      ELSE
         v_assunto :=
               'SAC-TISI: '
            || :NEW.wonum
            || ' / '
            || :NEW.eqnum
            || ' - Cancelamento de Chamado.';
         prc_envia_email
            ('suporte_tisi@infraero.gov.br',
             v_destinatario,
             v_assunto,
                'Prezado Solicitante,

                 Seu chamado registrado com o Numero '
             || :NEW.wonum
             || ' para o Sistema '
             || :NEW.eqnum
             || ' ,com a descricao '
             || :NEW.description
             || ', foi CANCELADO.

            Esta e uma mensagem automatica, favor nao responder.

             http://sactisi.infranet.gov.br:81/jsp/common/system/login.jsp?username=infraero&password=infraero

            Atenciosamente,
            Gerencia de Sistemas.'
            );
      END IF;
   END IF;
END;
/

CREATE OR REPLACE TRIGGER tr_workorder_prti_sac
 BEFORE
  INSERT
 ON workorder
REFERENCING NEW AS NEW OLD AS OLD
 FOR EACH ROW
WHEN ((NEW.siteid = 'PRTI')
)
DECLARE
   v_destinatario     viw_age_empregados.email%TYPE            := '0';
   v_assunto          viw_age_empregados.nome%TYPE             := '0';
   v_cod_emp          ifrmaximo.workorder.wo61%TYPE            := '0';
   v_conf_matricula   ifrmaximo.workorder.wo48%TYPE            := '0';
   v_nome_gestor      ifrmaximo.equipment.nome_gestor%TYPE     := '0';
   v_email_gestor     ifrmaximo.equipment.e_mail_gestor%TYPE   := '0';
   v_nome_lider       ifrmaximo.equipment.nome_lider%TYPE      := '0';
   v_email_lider      ifrmaximo.equipment.e_mail_lider%TYPE    := '0';
   v_assunto_gestor   VARCHAR2 (100)                           := '0';
   v_assunto_lider    VARCHAR2 (100)                           := '0';
   v_cod_matricula    NUMBER (7)                               := 0;
   v_cont             NUMBER (1)                               := 0;
   sequencial         ifrmaximo.labtrans.labtransid%TYPE       := '';

   CURSOR x (v_sistema VARCHAR2)
   IS
      SELECT a.nome_gestor, a.e_mail_gestor, a.nome_lider, a.e_mail_lider,
             eq20
        FROM equipment a
       WHERE a.eqnum = v_sistema AND a.siteid = 'PRTI'
             AND a.orgid = 'INFRAERO';

   CURSOR cpf (v_cpf VARCHAR2)
   IS
      SELECT y.nome, y.dependencia, y.lotacao, y.voip, y.email
        FROM viw_age_empregados y
       WHERE TRIM (SUBSTR (y.cpf, 1, LENGTH (TRIM (y.cpf)) - 2)) LIKE v_cpf;

   CURSOR mat (v_mat NUMBER)
   IS
      SELECT z.nome, z.dependencia, z.lotacao, z.voip, z.email
        FROM viw_age_empregados z
       WHERE z.matricula = v_mat;

   CURSOR cur_lab (p_executor labtrans.laborcode%TYPE)
   IS
      SELECT *
        FROM labtrans lt
       WHERE lt.siteid = 'PRTI'
         AND lt.orgid = 'INFRAERO'
         AND lt.laborcode = p_executor
         AND lt.dt_inicio IS NOT NULL
         AND lt.hr_inicio IS NOT NULL
         AND lt.dt_termino IS NULL
         AND lt.hr_termino IS NULL;
BEGIN
   IF (LENGTH (TRIM (:NEW.wo48)) = 0 OR (:NEW.wo48 IS NULL))
   THEN
      raise_application_error
         (-20900,
          fun_formatar_msg
             ('O preenchimento do campo TIPO da Ordem de serviço é obrigatório.'
             )
         );
   END IF;

   IF (LENGTH (TRIM (:NEW.wo46)) = 0 OR (:NEW.wo46 IS NULL))
   THEN
      raise_application_error
         (-20900,
          fun_formatar_msg
             ('O preenchimento do campo SOLICITANTE da Ordem de serviço é obrigatório.'
             )
         );
   ELSE
      IF     LENGTH (TRIM (:NEW.wo46)) = 8
         AND SUBSTR (TRIM (UPPER (:NEW.wo46)), 1, 1) = 'I'
      THEN
         v_cont := 0;
         v_cod_matricula := TO_NUMBER (SUBSTR (TRIM (:NEW.wo46), 2, 7));

         FOR a IN mat (v_cod_matricula)
         LOOP
            v_cont := 1;
            :NEW.wo47 := a.nome;
            :NEW.wo49 := a.dependencia;
            :NEW.wo50 := a.lotacao;
            :NEW.wo51 := a.voip;
            v_destinatario := TRIM (a.email);
            v_assunto :=
                  'SAC-TISI: Ordem de Serviço '
               || :NEW.wonum
               || ' / '
               || :NEW.eqnum
               || ' - "AGUARDANDO APROVACAO".';
         END LOOP;

         IF v_cont = 0
         THEN
            raise_application_error
               (-20902,
                fun_formatar_msg
                   (   'A MATRICULA informada no SOLICITANTE da ordem de serviço '
                    || 'não foi encontrada no cadastro da INFRAERO '
                    || '(Catalogo telefonico) - Verificar Matricula. '
                    || TO_CHAR (v_cod_matricula, '0000000')
                   )
               );
         END IF;
      ELSE
         IF     LENGTH (TRIM (:NEW.wo46)) = 10
            AND SUBSTR (TRIM (UPPER (:NEW.wo46)), 1, 1) = 'T'
         THEN
            v_cont := 0;
            v_cod_emp :=
                        -- TRIM (TO_CHAR (TO_NUMBER (SUBSTR (TRIM (:NEW.wo46), 2, 9)))); HOMOLOG
                        TRIM (TO_CHAR (SUBSTR (TRIM (:NEW.wo46), 2, 10)));

            FOR b IN cpf (v_cod_emp)
            LOOP
               v_cont := 1;
               :NEW.wo47 := b.nome;
               :NEW.wo49 := b.dependencia;
               :NEW.wo50 := b.lotacao;
               :NEW.wo51 := b.voip;
               v_destinatario := TRIM (b.email);
               v_assunto :=
                     'SAC-TISI: '
                  || :NEW.wonum
                  || ' / '
                  || :NEW.eqnum
                  || ' - Abertura de Chamado.';
            END LOOP;

            IF v_cont = 0
            THEN
               raise_application_error
                  (-20903,
                   fun_formatar_msg
                      (   'O CPF informada no SOLICITANTE da ordem de serviço '
                       || ' não encontrado no cadastro da INFRAERO '
                       || '(Catalogo telefonico) - Verificar CPF.'
                       || v_cod_emp
                      )
                  );
            END IF;
         ELSE
            raise_application_error
               (-20904,
                fun_formatar_msg
                   ('O campo SOLICITANTE não está no formato adequado. Ex.: I9999999 ou T999999999.'
                   )
               );
         END IF;
      END IF;
   END IF;

   IF LENGTH (TRIM (:NEW.eqnum)) = 0 OR (:NEW.eqnum IS NULL)
   THEN
      raise_application_error
         (-20905,
          fun_formatar_msg
              ('O preenchimento do SISTEMA na Ordem de serviço é obrigatorio.')
         );
   END IF;

   IF LENGTH (TRIM (:NEW.description)) = 0 OR (:NEW.description IS NULL)
   THEN
      raise_application_error
         (-20905,
          fun_formatar_msg
             ('O preenchimento da DESCRIÇÃO DO CHAMADO é obrigatório na Ordem de Serviço'
             )
         );
   END IF;

   FOR c IN x (:NEW.eqnum)
   LOOP
      :NEW.wo74 := 'AGUARDANDO APROVAÇÃO';
      v_nome_gestor := c.nome_gestor;
      v_email_gestor := c.e_mail_gestor;
      v_assunto_gestor :=
              'SAC-TISI: ' || :NEW.wonum || ' / ' || :NEW.eqnum
              || ' - GESTOR.';
      v_nome_lider := c.nome_lider;
      v_email_lider := c.e_mail_lider;
      v_assunto_lider :=
               'SAC-TISI: ' || :NEW.wonum || ' / ' || :NEW.eqnum
               || ' - LIDER.';

      IF     TRIM (:NEW.wo48) NOT IN ('Manutenção Preventiva', 'Help Desk')
         AND (   LENGTH (TRIM (v_destinatario)) <> 0
              OR (v_destinatario IS NOT NULL)
             )
      THEN
    /*     IF     TRIM (:NEW.wo48) <> 'Manutenção Preventiva'
            AND TRIM (:NEW.wo48) <> ('Help Desk')
            AND (   LENGTH (TRIM (v_destinatario)) <> 0
                 OR (v_destinatario IS NOT NULL)
                )
         THEN */
/*********************** E-MAIL PARA USUÁRIO ******************************************/
         BEGIN
            prc_envia_email
               ('suporte_tisi@infraero.gov.br',
                v_destinatario,
                v_assunto,
                   'Prezado Solicitante,

                 Seu chamado foi registrado com o Numero '
                || :NEW.wonum
                || ' para o Sistema '
                || :NEW.eqnum
                || ' ,com a descricao '
                || :NEW.description
                || ', e sera atendido o mais breve possível.

            Esta e uma mensagem automatica, favor nao responder.

             http://sactisi.infranet.gov.br:81/jsp/common/system/SOLICITANTE.jsp?username=infraero&password=infraero

            Atenciosamente,
            Gerencia de Sistemas.'
               );
         EXCEPTION
            WHEN OTHERS
            THEN
               :NEW.wo61 :=
                         'Não foi possível enviar e-mail para o Solicitante.';
         END;

/************************** E-MAIL PARA APROVAÇÃO DO GESTOR *********************************************/
         IF c.eq20 = 'S'
         THEN
            BEGIN
               prc_envia_email
                  ('suporte_tisi@infraero.gov.br',
                   v_email_gestor,
                   v_assunto_gestor,
                      'Prezado Gestor '
                   || v_nome_gestor
                   || ', foi aberto um chamado no SAC com o Numero '
                   || :NEW.wonum
                   || ' para o Sistema '
                   || :NEW.eqnum
                   || ' ,com a descricao '
                   || :NEW.description
                   || '. Este chamado aguarda seu PARECER.

                Esta e uma mensagem automatica, favor nao responder.

                http://sactisi.infranet.gov.br:81/jsp/common/system/SOLICITANTE.jsp

                Atenciosamente,
                Gerencia de Sistemas.'
                  );
               :NEW.wo61 :=
                     'Foi enviado e-mail de confirmação para o usuário: '
                  || v_cod_emp
                  || '/'
                  || v_destinatario
                  || '. E para o Gestor '
                  || v_nome_gestor
                  || ' no e-mail '
                  || v_email_gestor
                  || '.';
            EXCEPTION
               WHEN OTHERS
               THEN
                  :NEW.wo61 :=
                              'Não foi possível enviar e-mail para o Gestor.';
            END;
         ELSE
            /****** E-MAIL PARA APROVAÇÃO DO LIDER CASO O GESTOR NÃO ESTEJA HABILITADO PARA RECEBER E-MAIL ******/
            BEGIN
               prc_envia_email
                  ('suporte_tisi@infraero.gov.br',
                   v_email_lider,
                   v_assunto_lider,
                      'Prezado Lider de Projeto '
                   || v_nome_lider
                   || ', foi aberto um chamado no SAC com o Numero '
                   || :NEW.wonum
                   || ' para o Sistema '
                   || :NEW.eqnum
                   || ' ,com a descricao '
                   || :NEW.description
                   || '. Este chamado aguarda seu PARECER.

                Esta e uma mensagem automática, favor nao responder.

                http://sactisi.infranet.gov.br:81/jsp/common/system/SOLICITANTE.jsp

                Atenciosamente,
                Gerência de Sistemas.'
                  );
               :NEW.wo61 :=
                     'Foi enviado e-mail de confirmação para o solicitante: '
                  || :NEW.wo46
                  || ', e para o Líder do Projeto: '
                  || v_nome_lider
                  || '.';
            EXCEPTION
               WHEN OTHERS
               THEN
                  :NEW.wo61 := 'Não foi possível enviar e-mail para o Líder.';
            END;
         END IF;
      ELSE
         /************************* T R A T A M E N T O   M A N U T E N Ç Ã O    P R E V E N T I V A ********************************/
         IF     (LENGTH (TRIM (v_destinatario)) = 0
                 OR (v_destinatario IS NULL)
                )
            AND TRIM (:NEW.wo48) NOT IN
                                       ('Manutenção Preventiva', 'Help Desk')
         THEN
            BEGIN
               prc_envia_email
                  ('suporte_tisi@infraero.gov.br',
                   v_email_lider,
                   v_assunto,
                      'Prezado '
                   || v_nome_lider
                   || ',
            O chamado aberto e registrado sob o Numero '
                   || :NEW.wonum
                   || ' para o Sistema '
                   || :NEW.eqnum
                   || ' ,com a descricao '
                   || :NEW.description
                   || ' nao foi comunicado ao solicitante, pois o mesmo nao possui e-mail cadastrado.
            Esta e uma mensagem automatica, favor nao responder.

           http://sactisi.infranet.gov.br:81/jsp/common/system/SOLICITANTE.jsp

            Atenciosamente,
            Gerência de Sistemas.'
                  );
               :NEW.wo61 :=
                  ' O chamado aberto não foi comunicado ao solicitante, pois o mesmo não possui e-mail cadastrado.';
            EXCEPTION
               WHEN OTHERS
               THEN
                  :NEW.wo61 := 'Não foi possível enviar e-mail para o Líder.';
            END;
         ELSE
            IF :NEW.status IN ('AAPRV', 'APRV')
            THEN
               :NEW.wo74 := 'EM ANDAMENTO';

               IF TRIM (:NEW.wo48) = 'Manutenção Preventiva'
               THEN
                  v_assunto_lider :=
                        'SAC-TISI: Ordem de Serviço '
                     || :NEW.wonum
                     || ' / '
                     || :NEW.eqnum
                     || ' - Manutencao Preventiva - EM ANDAMENTO.';
               END IF;

               IF TRIM (:NEW.wo48) = 'Help Desk'
               THEN
                  v_assunto_lider :=
                        'SAC-TISI: Ordem de Serviço '
                     || :NEW.wonum
                     || ' / '
                     || :NEW.eqnum
                     || ' - HELP DESK - EM ANDAMENTO.';
               END IF;

               /****** E-MAIL PARA LÍDER DE PROJETO ******/
               IF v_email_lider IS NULL
               THEN
                  raise_application_error (-20905, 'E-MAIL LIDER EM BRANCO.');
               END IF;

               IF v_assunto_lider IS NULL
               THEN
                  raise_application_error (-20905,
                                           'ASSUNTO LIDER EM BRANCO.');
               END IF;

               IF v_nome_lider IS NULL
               THEN
                  raise_application_error (-20905, 'NOME LIDER EM BRANCO.');
               END IF;

               BEGIN
                  prc_envia_email
                     ('suporte_tisi@infraero.gov.br',
                      v_email_lider,
                      v_assunto_lider,
                         'Prezado Lider de Projeto '
                      || v_nome_lider
                      || ', foi aberta Ordem de Servico de '
                      || UPPER (:NEW.wo48)
                      || ', numero '
                      || :NEW.wonum
                      || ' para o Sistema '
                      || :NEW.eqnum
                      || ' ,com a descricao '
                      || UPPER (:NEW.description)
                      || '. Informamos que esta Ordem de Servico ja esta em EXECUCAO.

                                   Esta e uma mensagem automatica, favor nao responder.


                          Atenciosamente,
                          Gerencia de Sistemas.'
                     );
                  :NEW.wo61 :=
                        'Foi enviado um e-mail de confirmação para o Líder de Projeto: '
                     || v_nome_lider
                     || ' / '
                     || v_email_lider
                     || '.';
                  :NEW.status := 'EMAND';
                  :NEW.wo74 := 'EM ANDAMENTO';
               EXCEPTION
                  WHEN OTHERS
                  THEN
                     :NEW.wo61 :=
                               'Não foi possível enviar e-mail para o Líder.';
               END;

               INSERT INTO wostatus
                           (wonum, status,
                            changedate,
                            changeby, glaccount, orgid, siteid
                           )
                    VALUES (:NEW.wonum, 'EMAND',
                            TO_DATE (TO_CHAR (SYSDATE, 'DD/MM/YYYY'),
                                     'DD/MM/YYYY'
                                    ),
                            :NEW.changeby, :NEW.glaccount, :NEW.orgid, 'PRTI'
                           );

               IF TRIM (:NEW.wo48) = 'Help Desk'
               THEN
                  :NEW.woeq8 := 'SIM';

                  FOR carga_lt IN cur_lab (:NEW.changeby)
                  LOOP
                     UPDATE labtrans
                        SET dt_termino =
                               TO_DATE (TO_CHAR (SYSDATE, 'DD/MM/YYYY'),
                                        'DD/MM/YYYY'
                                       ),
                            hr_termino =
                                    TO_DATE (SYSDATE, 'DD/MM/YYYY HH24:MI:SS')
                      WHERE refwo = carga_lt.refwo
                        AND rowstamp = carga_lt.rowstamp
                        AND laborcode = :NEW.reportedby
                        AND siteid = carga_lt.siteid
                        AND orgid = carga_lt.orgid
                        AND dt_termino IS NULL
                        AND hr_termino IS NULL;

                     SELECT labtransseq.NEXTVAL
                       INTO sequencial
                       FROM DUAL;

                     INSERT INTO labtrans
                                 (transdate,
                                  laborcode, payrate,
                                  otscale, eqnum,
                                  enterby,
                                  enterdate,
                                  transtype, outside,
                                  ltl1,
                                  ltl2,
                                  ROLLUP, glcreditacct,
                                  genapprservreceipt,
                                  orgid, siteid,
                                  refwo, enteredastask,
                                  dt_inicio_prev,
                                  hr_inicio_prev,
                                  dt_termino_prev,
                                  hr_termino_prev, labtransid,
                                  lab3
                                 )
                          VALUES (TO_DATE (TO_CHAR (SYSDATE,
                                                    'DD/MM/YYYY HH24:MI:SS'
                                                   ),
                                           'DD/MM/YYYY HH24:MI:SS'
                                          ),
                                  carga_lt.laborcode, carga_lt.payrate,
                                  carga_lt.otscale, carga_lt.eqnum,
                                  :NEW.reportedby,
                                  TO_DATE (TO_CHAR (SYSDATE,
                                                    'DD/MM/YYYY  HH24:MI:SS'
                                                   ),
                                           'DD/MM/YYYY  HH24:MI:SS'
                                          ),
                                  carga_lt.transtype, carga_lt.outside,
                                  carga_lt.ltl1,
                                  TO_DATE (TO_CHAR (SYSDATE,
                                                    'DD/MM/YYYY HH24:MI:SS'
                                                   ),
                                           'DD/MM/YYYY HH24:MI:SS'
                                          ),
                                  carga_lt.ROLLUP, carga_lt.glcreditacct,
                                  carga_lt.genapprservreceipt,
                                  carga_lt.orgid, carga_lt.siteid,
                                  carga_lt.refwo, carga_lt.enteredastask,
                                  TO_DATE (TO_CHAR (SYSDATE, 'DD/MM/YYYY'),
                                           'DD/MM/YYYY'
                                          ),
                                  TO_DATE (SYSDATE, 'DD/MM/YYYY HH24:MI:SS'),
                                  carga_lt.dt_termino_prev,
                                  carga_lt.hr_termino_prev, sequencial,
                                  carga_lt.lab3
                                 );
                  END LOOP;

                  SELECT labtransseq.NEXTVAL
                    INTO sequencial
                    FROM DUAL;

--                     ifrmaximo.pck_variaveis_prti.v_pck_verificacao := '1';
                  INSERT INTO labtrans
                              (transdate,
                               laborcode, payrate, otscale, eqnum,
                               enterby,
                               enterdate,
                               transtype, outside, ltl1,
                               ltl2,
                               ROLLUP, glcreditacct, genapprservreceipt,
                               orgid, siteid, refwo, enteredastask,
                               dt_inicio_prev,
                               hr_inicio_prev,
                               dt_termino_prev,
                               hr_termino_prev, labtransid, lab3,
                               dt_inicio,
                               hr_inicio,
                               REGULARHRS,OTHRS,STARTDATE, LINECOST
                              )
                       VALUES (TO_DATE (TO_CHAR (SYSDATE,
                                                 'DD/MM/YYYY HH24:MI:SS'
                                                ),
                                        'DD/MM/YYYY  HH24:MI:SS'
                                       ),
                               :NEW.reportedby, '10', '1', :NEW.eqnum,
                               :NEW.reportedby,
                               TO_DATE (TO_CHAR (SYSDATE,
                                                 'DD/MM/YYYY  HH24:MI:SS'
                                                ),
                                        'DD/MM/YYYY  HH24:MI:SS'
                                       ),
                               'SERVIÇO', 'S', :NEW.wopm7,
                               TO_DATE (SYSDATE, 'DD/MM/YYYY HH24:MI:SS'),
                               'N', '001201183', 'S',
                               'INFRAERO', 'PRTI', :NEW.wonum, 'N',
                               TO_DATE (TO_CHAR (SYSDATE, 'DD/MM/YYYY'),
                                        'DD/MM/YYYY'
                                       ),
                               SYSDATE,
                                 TO_DATE (TO_CHAR (SYSDATE, 'DD/MM/YYYY'),
                                          'DD/MM/YYYY'
                                         )
                               + 1,
                               SYSDATE, sequencial, :NEW.description,
                               TO_DATE (TO_CHAR (SYSDATE, 'DD/MM/YYYY'),
                                        'DD/MM/YYYY'
                                       ),
                               SYSDATE,'10','10',TO_DATE ('01/01/1900', 'DD/MM/YYYY HH24:MI:SS'),'10'
                              );

                  :NEW.PARENT := :NEW.reportedby;
               END IF;
            END IF;
         END IF;
      END IF;
   END LOOP;

   IF TRIM (:NEW.wo48) = ('Help Desk')
   THEN
      :NEW.woeq8 := 'SIM';
   END IF;

   IF TRIM (:NEW.wo48) <> ('Help Desk')
   THEN
      :NEW.woeq8 := 'NÃO';
   END IF;
END;
/

CREATE OR REPLACE TRIGGER tr_workorder_scom_calc_valores
 BEFORE
  INSERT OR UPDATE
 ON workorder
REFERENCING NEW AS NEW OLD AS OLD
 FOR EACH ROW
WHEN ((NEW.SITEID ='INFRAERO')
)
DECLARE
-- variaveis para funcionamento do rateio ----
   v_percentual     ifrmaximo.workorder.wo66%TYPE   := '0';
   v_custo_fe       ifrmaximo.workorder.wo6%TYPE    := '0';
   v_custo_mo       ifrmaximo.workorder.wo4%TYPE    := '0';
   v_custo_rateio   ifrmaximo.workorder.wo65%TYPE   := '0';
   v_pt             ifrmaximo.workorder.wo69%TYPE   := '0';
---
BEGIN
--Copiando valores ja contabilizados pelo MAXIMO
   SELECT SUM (linecost)
     INTO :NEW.wo5
     FROM matusetrans
    WHERE refwo = :NEW.wonum AND siteid = 'INFRAERO';

--Copiando Centro de Custo Executante da Mao de Obra
   IF TRIM (:NEW.wo1) IS NULL
   THEN
      BEGIN
         SELECT DISTINCT SUBSTR (glcreditacct, 4, 6)
                    INTO :NEW.wo1
                    FROM labtrans
                   WHERE refwo = :NEW.wonum
                     AND siteid = 'INFRAERO'
                     AND ROWNUM = 1;
      EXCEPTION
         WHEN OTHERS
         THEN
            :NEW.wo1 := NULL;
      END;
   END IF;

   :NEW.wo3 := :NEW.actlabhrs;
   :NEW.wo4 := :NEW.actlabcost;
   --  :new.actmatcost:=:new.wo5;
   :NEW.wo6 := :NEW.acttoolcost;
   :NEW.wo7 := :NEW.actservcost;

-- Tratando valores extras nulos
   IF :NEW.wo5 IS NULL
   THEN
      :NEW.wo5 := 0;
   END IF;

   IF :NEW.wo10 IS NULL
   THEN
      :NEW.wo10 := 0;
   END IF;

   IF :NEW.wo11 IS NULL
   THEN
      :NEW.wo11 := 0;
   END IF;

   IF :NEW.wo12 IS NULL
   THEN
      :NEW.wo12 := 0;
   END IF;

   IF :NEW.wo15 IS NULL
   THEN
      :NEW.wo15 := 0;
   END IF;

   IF :NEW.wo16 IS NULL
   THEN
      :NEW.wo16 := 0;
   END IF;

-- Calculando total geral (WO8)
   :NEW.wo8 :=
        :NEW.wo4
      + :NEW.wo5
      + :NEW.wo6
      + :NEW.wo7
      + :NEW.wo10
      + :NEW.wo11
      + :NEW.wo12
      + :NEW.wo15
      + :NEW.wo16;
   -- calculos do rateio ---
   -- CUSTO TOTAL A SER RATEADO
   :NEW.wo65 := (:NEW.wo4 + :NEW.wo6);

   SELECT SUM (porcentagem), SUM (custo_fe), SUM (custo_mo), SUM (pt)
     INTO :NEW.wo66, :NEW.wo67, :NEW.wo68, :NEW.wo69
     FROM tab_worateio
    WHERE wonum = :NEW.wonum;

   IF :NEW.wo66 > 100
   THEN
      raise_application_error (-20866,
                               'PERCENTUAL INFORMADO ULTRAPASSA 100%.'
                              );
   END IF;
END;
/

CREATE OR REPLACE TRIGGER tr_workorder_scom_equipamento
 BEFORE
   UPDATE OF status
 ON workorder
REFERENCING NEW AS NEW OLD AS OLD
 FOR EACH ROW
WHEN ((NEW.siteid = 'INFRAERO')
)
DECLARE
   v_tempo   workorder.wo19%TYPE   := '';
   x         NUMBER                := 0;
   y         NUMBER                := 0;
   a         REAL                  := 0;
   n         REAL                  := 0;
BEGIN
   y := (LENGTH (TRIM (:NEW.wo19)));
   x := 1;

   IF (:NEW.status IN ('CAN'))
   THEN
      WHILE x <= y
      LOOP
         BEGIN
            IF x = 1
            THEN
               BEGIN
--                  a := NULL;
--                  n := NULL;
--                  n := TRIM (SUBSTR (TO_CHAR (:NEW.wo19, '000.000'), 1, 7));
--                  a := TRIM (SUBSTR (TO_CHAR (:NEW.wo19, '000.000'), 1, 7));
                  n := TRIM (SUBSTR (:NEW.wo19, 1, 1));
                  a := TRIM (:NEW.wo19);
               EXCEPTION
                  WHEN OTHERS
                  THEN
                     raise_application_error
                        (-20900,
                         fun_formatar_msg
                            (   'Digite TEMPO DE INDISPONIBILIDADE, valor negativo incorreto.'
                             || n
                             || ' / '
                             || a
                             || '.'
                            )
                        );
               END;
            END IF;

            x := x + 1;
         END;
      END LOOP;
   END IF;
END;
/

CREATE OR REPLACE TRIGGER tr_workorder_prti_tipo
 BEFORE
   UPDATE OF wo48
 ON workorder
REFERENCING NEW AS NEW OLD AS OLD
 FOR EACH ROW
WHEN ((NEW.siteid = 'PRTI'))
DECLARE
BEGIN
   IF :OLD.wo48 = 'Help Desk'
   THEN
      raise_application_error (-20699, 'TIPO NÃO PODE SER ALTERADO.');
   END IF;
END;
/

CREATE OR REPLACE TRIGGER tr_workorder_scom_projeto
 BEFORE
  UPDATE
 ON workorder
REFERENCING NEW AS NEW OLD AS OLD
 FOR EACH ROW
WHEN ((NEW.status IN ('COMP', 'FECHADA') AND (NEW.siteid = 'INFRAERO'))
)
DECLARE
--
   v_msg      VARCHAR2 (800);
   v_erro     NUMBER (1);
BEGIN
--
   v_msg := CHR (13) || ' -------------------------------' || CHR (13);
   v_erro := 0;

--
-- testar o campo
--
--
   IF (:NEW.wo20 IS NULL OR TRIM (NVL (:NEW.wo20, ' ')) = ''
      )                                         
   THEN
      :NEW.wo20:= '0000';
/*      v_msg :=
            v_msg
         || ' O PROJETO NÃO ESTÁ PREENCHIDO.'
         || CHR (13);
      v_erro := 1; */
   END IF;

--
   IF v_erro = 1
   THEN
      raise_application_error (-20669,
                                  v_msg
                               || ' ------------------------------- '
                               || CHR (13)
                              );
   END IF;
END;
/

CREATE OR REPLACE TRIGGER tr_workorder_scom_tarefas
 BEFORE
  INSERT
 ON workorder
REFERENCING NEW AS NEW OLD AS OLD
 FOR EACH ROW
WHEN ((new.siteid = 'INFRAERO')
)
BEGIN
  IF :NEW.ISTASK='S' THEN
    :NEW.STATUS:='APRV';
  END IF;
END;
/

CREATE OR REPLACE TRIGGER tr_workorder_scom_glaccount
 BEFORE
  UPDATE
 ON workorder
REFERENCING NEW AS NEW OLD AS OLD
 FOR EACH ROW
WHEN ((NEW.status IN ('COMP', 'FECHADA') AND (NEW.siteid = 'INFRAERO'))
)
DECLARE
--
   v_msg      VARCHAR2 (800);
   v_erro     NUMBER (1);
BEGIN
--
   v_msg := CHR (13) || ' -------------------------------' || CHR (13);
   v_erro := 0;

--
-- testar o campo
--
--
   IF (:NEW.glaccount IS NULL OR TRIM (NVL (:NEW.glaccount, ' ')) = ''
      )                                         -- CENTRO DE CUSTO BENEFICIADO
   THEN
      v_msg :=
            v_msg
         || ' CENTRO DE CUSTO DO ÓRGÃO BENEFICIADO NÃO ESTA PREENCHIDO.'
         || CHR (13);
      v_erro := 1;
   END IF;

--
   IF v_erro = 1
   THEN
      raise_application_error (-20669,
                                  v_msg
                               || ' ------------------------------- '
                               || CHR (13)
                              );
   END IF;
END;
/

CREATE OR REPLACE TRIGGER tr_workorder_daag_fechamento
 BEFORE
   UPDATE OF status
 ON workorder
REFERENCING NEW AS NEW OLD AS OLD
 FOR EACH ROW
DECLARE
BEGIN
   IF(:NEW.SITEID = 'DAAG') THEN
      
      IF :NEW.status IN ('FECHADA','COMP') THEN
         
         IF (:NEW.WO32 = 'TRANSPORTE') THEN
            IF ((:NEW.WO41 is null) OR (:NEW.WO42 is null) OR (:NEW.WO43 is null))THEN
               raise_application_error (-20871,'PREENCHA OS CAMPOS: VIATURA, PLACA, E MOTORISTA - ESTES 03(TRÊS) CAMPOS OBRIGATÓRIOS PARA A EXECUÇÃO DO SERVIÇO.');
            END IF;
         END IF;
      
         IF (:NEW.WO36 is null) OR (:NEW.WO33 is null)OR (:NEW.WO35 is null) THEN
            raise_application_error (-20871,'PREENCHA O CAMPO ASSINATURA/NOME, DATA E GRAU DE SATISFAÇÃO - ESTES CAMPOS OBRIGATÓRIOS.');
         END IF;
         
         IF (:NEW.WO35) > (SYSDATE) THEN
            raise_application_error (-20872,'A DATA DE EXECUÇÃO NÃO PODE SER MAIOR DO QUE A DATA ATUAL');
         END IF;
         
         IF (:NEW.WO35) < (:NEW.REPORTDATE) THEN
            raise_application_error (-20873,'A DATA DE EXECUÇÃO NÃO PODE SER INFERIOR DO QUE A DATA DE ABERTURA DESTA ORDEM DE SERVIÇO');
         END IF;
         
      END IF;
      
      IF (:NEW.WO32 IS null) THEN
            raise_application_error (-20873,'CAMPO ÁREA EXECUTANTE EM BRANCO - CAMPO OBRIGATÓRIO.');
         END IF;
     
   END IF;
   
      
   
END;
/

CREATE OR REPLACE TRIGGER tr_workorder_daag
 BEFORE
   INSERT OR UPDATE OF wolo5, wolo4
 ON workorder
REFERENCING NEW AS NEW OLD AS OLD
 FOR EACH ROW
DECLARE

BEGIN
   IF (:NEW.SITEID = 'DAAG') THEN
   
      IF (:NEW.WO32 <> 'TRANSPORTE')THEN
         IF (:NEW.WOLO4 IS NULL) or (:NEW.WOLO5 IS NULL) THEN  -- EDIFÍCIO
            raise_application_error(-20770,'Selecione o EDIFÍCIO e o ANDAR. CAMPO NÃO PODE ESTAR EM BRANCO');
         END IF;
      END IF;

     IF :NEW.WOLO4 = 'ED. ARAGUAIA' THEN
        IF :NEW.WOLO5 NOT IN ('TÉRREO', '1º ANDAR', '2º ANDAR','3º ANDAR','4º ANDAR','5º ANDAR','6º ANDAR') THEN
           raise_application_error(-20772,'ESTE ANDAR NÃO É VÁLIDO PARA O EDIFÍCIO SELECIONADO.');
        END IF;
     END IF;

     IF :NEW.WOLO4 = 'ED. FACEB' THEN
        IF :NEW.WOLO5 NOT IN ('1º ANDAR', '2º ANDAR','3º ANDAR') THEN
           raise_application_error(-20773,'ESTE ANDAR NÃO É VÁLIDO PARA O EDIFÍCIO SELECIONADO.');
        END IF;
     END IF;
            
     IF :NEW.WOLO4 = 'ED. INFRAERO' THEN
        IF :NEW.WOLO5 NOT IN ('1º SUBSOLO','TÉRREO', '1º ANDAR', '2º ANDAR','3º ANDAR','4º ANDAR','5º ANDAR','6º ANDAR') THEN
           raise_application_error(-20774,'ESTE ANDAR NÃO É VÁLIDO PARA O EDIFÍCIO SELECIONADO.');
        END IF;
     END IF;
           
     IF :NEW.WOLO4 = 'ED. OSCAR ALVARENGA' THEN
        IF :NEW.WOLO5 NOT IN ('1º SUBSOLO','2º SUBSOLO','TÉRREO', '1º ANDAR', '2º ANDAR','3º ANDAR','COBERTURA') THEN
           raise_application_error(-20775,'ESTE ANDAR NÃO É VÁLIDO PARA O EDIFÍCIO SELECIONADO.');
       END IF;
     END IF;
         
     IF :NEW.WOLO4 = 'ED. ZARIFE' THEN
        IF :NEW.WOLO5 NOT IN ('3º ANDAR','4º ANDAR') THEN
           raise_application_error(-20776,'ESTE ANDAR NÃO É VÁLIDO PARA O EDIFÍCIO SELECIONADO.');
        END IF;
     END IF;
        
   END IF;
END;
/

CREATE OR REPLACE TRIGGER tr_workorder_scom_ferramentas
 AFTER
  INSERT OR UPDATE
 ON workorder
REFERENCING NEW AS NEW OLD AS OLD
 FOR EACH ROW
WHEN ((new.siteid ='INFRAERO')
)
DECLARE

CURSOR SOMATORIO (PWONUM VARCHAR2) IS
 SELECT SUM(VAL_CRC), SUM(VAL_CUE), SUM(LINECOST)
   FROM TOOLTRANS
  WHERE REFWO = PWONUM;

V_VAL_CRC NUMBER(15,2);
V_VAL_CUE NUMBER(15,2);
V_VAL_RAT NUMBER(15,2);

BEGIN
  SELECT SUM(VAL_CRC)  , SUM(VAL_CUE) , SUM(LINECOST)
    INTO V_VAL_CRC,V_VAL_CUE,V_VAL_RAT
    FROM TOOLTRANS
   WHERE REFWO = :NEW.WONUM;
  
  UPDATE TOOLTRANS
     SET SOMA_CRC    = V_VAL_CRC,
         SOMA_CUE    = V_VAL_CUE,
         SOMA_RATEIO = V_VAL_RAT
   WHERE REFWO = :NEW.WONUM;

END;
/

CREATE OR REPLACE TRIGGER tr_workorder_prti_stat_gestor
 BEFORE
   UPDATE OF wo52, wo73
 ON workorder
REFERENCING NEW AS NEW OLD AS OLD
 FOR EACH ROW
WHEN ((NEW.siteid = 'PRTI'))
DECLARE
   v_nome_lider            ifrmaximo.equipment.nome_lider%TYPE     := '0';
   v_email_lider           ifrmaximo.equipment.e_mail_lider%TYPE   := '0';
   v_assunto_lider         VARCHAR2 (100)                          := '0';
   v_cod_emp               ifrmaximo.workorder.wo61%TYPE           := '0';
   v_cod_matricula         NUMBER (7)                              := 0;
   v_destinatario          viw_age_empregados.email%TYPE           := '0';
   v_assunto_solicitante   viw_age_empregados.nome%TYPE            := '0';
   v_nome_solicitante      viw_age_empregados.nome%TYPE            := '';

   CURSOR x (v_sistema VARCHAR2)
   IS
      SELECT a.nome_gestor, a.e_mail_gestor, a.nome_lider, a.e_mail_lider
        FROM equipment a
       WHERE a.siteid = 'PRTI' AND a.orgid = 'INFRAERO'
             AND a.eqnum = v_sistema;

   CURSOR y (v_cpf VARCHAR2)
   IS
      SELECT y.nome, y.dependencia, y.lotacao, y.voip, y.email
        FROM viw_age_empregados y
       WHERE TRIM (SUBSTR (y.cpf, 1, LENGTH (TRIM (y.cpf)) - 2)) LIKE v_cpf;

   CURSOR z (v_mat NUMBER)
   IS
      SELECT z.nome, z.dependencia, z.lotacao, z.voip, z.email
        FROM viw_age_empregados z
       WHERE z.matricula = v_mat;
BEGIN
   IF :NEW.siteid = 'PRTI'
   THEN
      IF (:OLD.wo53 IS NOT NULL) AND (:NEW.wo73 <> :OLD.wo73)
      THEN
         raise_application_error
                        (-20699,
                         'SR(A). GESTOR(A), O PARECER NÃO PODE SER ALTERADO.'
                        );
      END IF;

      IF (:NEW.wo73 IS NOT NULL) AND (LENGTH (TRIM (:NEW.wo73)) <> 0)
      THEN
         IF (:NEW.wo73 <> 'REJEITADO')
         THEN
            IF ((:NEW.wo52 IS NULL) OR (LENGTH (TRIM (:NEW.wo52)) = 0))
            THEN
               raise_application_error
                        (-20699,
                         'SR(A). GESTOR(A), PREECHA O CAMPO "CLASSIFICAÇÃO".'
                        );
            END IF;                       -- VERFICAÇÃO DO CAMPO CLASSIFICAÇÃO
         END IF;

         IF (:NEW.wo73 = 'APROVADO')
         THEN
            :NEW.status := 'APRV';
            :NEW.wo74 := 'APROVADA';
            :NEW.wo53 := NULL;
            :NEW.wo60 := NULL;

            INSERT INTO wostatus
                        (wonum, status, changedate,
                         changeby, glaccount, orgid, siteid
                        )
                 VALUES (:NEW.wonum, :NEW.status, :NEW.changedate,
                         :NEW.changeby, :NEW.glaccount, :NEW.orgid, 'PRTI'
                        );

            FOR aprov IN x (:NEW.eqnum)
            LOOP
               v_nome_lider := aprov.nome_lider;
               v_email_lider := aprov.e_mail_lider;
               v_assunto_lider :=
                     'SAC-TISI: Ordem de Serviço N '
                  || :NEW.wonum
                  || ' / '
                  || :NEW.eqnum
                  || '-  " APROVACAO GESTOR.';

               BEGIN
                  prc_envia_email
                     ('suporte_tisi@infraero.gov.br',
                      v_email_lider,
                      v_assunto_lider,
                         'Prezado '
                      || v_nome_lider
                      || '.
                A ordem de serviço aberta e registrada sob o numero '
                      || :NEW.wonum
                      || ' com a descricao: "'
                      || :NEW.description
                      || '"'
                      || ' foi "APROVADA" pelo Gestor do Sistema e está aguardando seu parecer.
            Atenciosamente,
            Gerência de Sistemas.'
                     );
                  :NEW.wo61 :=
                     ' O chamado foi encaminhando para o Lider de Projeto e aguarda o PARECER do mesmo.';
               EXCEPTION
                  WHEN OTHERS
                  THEN
                     :NEW.wo61 :=
                        'Não foi possível enviar e-mail para o Líder de Projeto.';
               END;
            END LOOP;
         ELSE
            :NEW.status := 'CAN';
            :NEW.wo74 := 'CANCELADA';
            :NEW.historyflag := 'S';

            INSERT INTO wostatus
                        (wonum, status, changedate,
                         changeby, glaccount, orgid, siteid
                        )
                 VALUES (:NEW.wonum, :NEW.status, :NEW.changedate,
                         :NEW.changeby, :NEW.glaccount, :NEW.orgid, 'PRTI'
                        );

            :NEW.wo52 := NULL;

            IF     LENGTH (TRIM (:NEW.wo46)) = 8
               AND SUBSTR (TRIM (:NEW.wo46), 1, 1) = 'I'
            THEN
               v_cod_matricula := TO_NUMBER (SUBSTR (TRIM (:NEW.wo46), 2, 7));

               FOR a IN z (v_cod_matricula)
               LOOP
                  v_nome_solicitante := a.nome;
                  v_destinatario := TRIM (a.email);
                  v_assunto_solicitante :=
                        'SAC-TISI: Ordem de Serviço '
                     || :NEW.wonum
                     || ' / '
                     || :NEW.eqnum
                     || ' -  "CANCELADA" pelo Gestor do Sistema';
               END LOOP;

               FOR aprov IN x (:NEW.eqnum)
               LOOP
                  v_nome_lider := aprov.nome_lider;
                  v_email_lider := aprov.e_mail_lider;
               END LOOP;

               IF (   LENGTH (TRIM (v_destinatario)) <> 0
                   OR (v_destinatario IS NOT NULL)
                  )
               THEN
                  BEGIN
                     prc_envia_email
                        ('suporte_tisi@infraero.gov.br',
                         v_destinatario,
                         v_assunto_solicitante,
                            'Prezado '
                         || v_nome_solicitante
                         || '.
                O chamado aberto e registrado sob o Numero '
                         || :NEW.wonum
                         || ' com a seguinte descricao "'
                         || :NEW.description
                         || '" foi cancelado pelo Gestor do Sistema, e nao sera atendido.
                   Para maiores informacoes entre em contato com o Sr(a) '
                         || v_nome_lider
                         || ', atraves do e-mail '
                         || v_email_lider
                         || '.
            Atenciosamente,
            Gerência de Sistemas.'
                        );
                     :NEW.wo61 :=
                           ' E-mail de cancelamento enviado para '
                        || v_destinatario
                        || '.';
                  EXCEPTION
                     WHEN OTHERS
                     THEN
                        :NEW.wo61 :=
                           'Não foi possível enviar e-mail para o Solicitante.';
                  END;
               ELSE
                  :NEW.wo61 :=
                     ' E-mail de confirmação de cancelamento não pôde ser enviado, pois o solicitante não possui e-mail cadastrado.';
               END IF;
            END IF;

            IF     LENGTH (TRIM (:NEW.wo46)) = 10
               AND SUBSTR (TRIM (:NEW.wo46), 1, 1) = 'T'
            THEN
               v_cod_emp :=
                  TRIM (TO_CHAR (TO_NUMBER (SUBSTR (TRIM (:NEW.wo46), 2, 9))));

               FOR b IN y (v_cod_emp)
               LOOP
                  v_nome_solicitante := b.nome;
                  v_destinatario := TRIM (b.email);
                  v_assunto_solicitante :=
                        'SAC-TISI: Ordem de Servico '
                     || :NEW.wonum
                     || ' / '
                     || :NEW.eqnum
                     || ' - CANCELADA.';
               END LOOP;

               FOR aprov IN x (:NEW.eqnum)
               LOOP
                  v_nome_lider := aprov.nome_lider;
                  v_email_lider := aprov.e_mail_lider;
               END LOOP;

               IF (   LENGTH (TRIM (v_destinatario)) <> 0
                   OR (v_destinatario IS NOT NULL)
                  )
               THEN
                  BEGIN
                     prc_envia_email
                        ('suporte_tisi@infraero.gov.br',
                         v_destinatario,
                         v_assunto_solicitante,
                            'Prezado '
                         || v_nome_solicitante
                         || '.
                O chamado aberto e registrado sob o Numero '
                         || :NEW.wonum
                         || ' com a seguinte descricao "'
                         || :NEW.description
                         || '" foi cancelado pelo Gestor do Sistema, e nao sera atendido.
                   Para maiores informações entre em contato com o Sr(a) '
                         || v_nome_lider
                         || ', através do e-mail '
                         || v_email_lider
                         || '.
            Atenciosamente,
            Gerência de Sistemas.'
                        );
                     :NEW.wo61 :=
                           ' E-mail de cancelamento enviado para '
                        || v_destinatario
                        || '.';
                  EXCEPTION
                     WHEN OTHERS
                     THEN
                        :NEW.wo61 :=
                           'Não foi possível enviar e-mail para o Solicitante.';
                  END;
               ELSE
                  :NEW.wo61 :=
                     ' E-mail de cancelamento não pôde ser enviado pois o solicitante terceirizado não possui e-mail cadastrado';
               END IF;
            END IF;
         END IF;                    --  ALTERÇÃO DO STATUS DA ORDEM DE SERVIÇO
      ELSE
         raise_application_error
                              (-20699,
                               'SR(A). GESTOR(A), PREECHA O CAMPO "PARECER".'
                              );
      END IF;    -- VERIFICA SE O CAMPO PARECER DO GESTOR ESTA PREENCHIDO WO73
   END IF;                  -- VERIFICA SE É UMA ORDEM DE SERVIÇO DO SITE PRTI
END;
/

CREATE OR REPLACE TRIGGER tr_workorder_prti_time_sheet
 BEFORE
   UPDATE OF wo70
 ON workorder
REFERENCING NEW AS NEW OLD AS OLD
 FOR EACH ROW
WHEN ((NEW.siteid = 'PRTI')
)
DECLARE
   v_cont          VARCHAR2 (1)                         := '0';
   v_check         VARCHAR2 (1)                         := 'S';
   v_fechada       VARCHAR2 (1)                         := 'N';
   v_colaborador   VARCHAR2 (1)                         := 'N';
   v_num           NUMBER                               := 0;
   sequencial      ifrmaximo.labtrans.labtransid%TYPE   := '';

   CURSOR x (v_laborcode VARCHAR2, v_os VARCHAR2)
   IS
      SELECT     a.rowstamp, a.dt_inicio, a.hr_inicio, a.dt_termino,
                 a.hr_termino, a.transdate, a.laborcode, a.payrate,
                 a.otscale, a.eqnum, a.enterby, a.enterdate, a.transtype,
                 a.outside, a.ltl1, a.ltl2, a.ROLLUP, a.glcreditacct,
                 a.genapprservreceipt, a.labtransid, a.orgid, a.siteid,
                 a.refwo, a.enteredastask, a.dt_inicio_prev,
                 a.hr_inicio_prev, a.dt_termino_prev, a.hr_termino_prev,
                 a.lab3
            FROM labtrans a
           WHERE a.siteid = 'PRTI'
             AND a.orgid = 'INFRAERO'
             AND a.laborcode = v_laborcode
             AND a.refwo = v_os
             AND a.dt_inicio_prev IS NOT NULL
             AND a.hr_termino_prev IS NOT NULL
      FOR UPDATE;

   CURSOR cur_lab (p_executor labtrans.laborcode%TYPE)
   IS
      SELECT *
        FROM labtrans lt
       WHERE lt.siteid = 'PRTI'
         AND lt.orgid = 'INFRAERO'
         AND lt.laborcode = p_executor
         AND lt.dt_inicio IS NOT NULL
         AND lt.hr_inicio IS NOT NULL
         AND lt.dt_termino IS NULL
         AND lt.hr_termino IS NULL;

   CURSOR cur_fechamento (p_os labtrans.refwo%TYPE)
   IS
      SELECT *
        FROM labtrans lt
       WHERE lt.siteid = 'PRTI' AND lt.orgid = 'INFRAERO' AND lt.refwo = p_os;
BEGIN
   v_cont := '0';

   FOR verifica IN x (:NEW.changeby, :NEW.wonum)
   LOOP
      IF verifica.hr_termino IS NULL
      THEN
         v_cont := '1';

         IF :NEW.wo70 = 'SUSPENDER'
         THEN
            IF (    verifica.dt_inicio IS NULL
                AND verifica.hr_termino IS NULL
                AND verifica.dt_termino IS NULL
                AND verifica.hr_termino IS NULL
               )
            THEN
               UPDATE labtrans
                  SET dt_inicio =
                         TO_DATE (TO_CHAR (SYSDATE, 'DD/MM/YYYY'),
                                  'DD/MM/YYYY'
                                 ),
                      hr_inicio = SYSDATE,
                      dt_termino =
                         TO_DATE (TO_CHAR (SYSDATE, 'DD/MM/YYYY'),
                                  'DD/MM/YYYY'
                                 ),
                      hr_termino = SYSDATE
                WHERE CURRENT OF x;
            END IF;

            -- PREENCHE TODAS AS DATAS E HORÁRIOS SE OS MESMOS ESTIVEREM EM BRANCO
            IF (verifica.dt_termino IS NULL AND verifica.hr_termino IS NULL)
            THEN
               UPDATE labtrans
                  SET dt_termino =
                         TO_DATE (TO_CHAR (SYSDATE, 'DD/MM/YYYY'),
                                  'DD/MM/YYYY'
                                 ),
                      hr_termino = SYSDATE
                WHERE CURRENT OF x;
            END IF;

            SELECT labtransseq.NEXTVAL
              INTO sequencial
              FROM DUAL;

            IF TO_DATE (TO_CHAR (verifica.dt_termino_prev, 'DD/MM/YYYY'),
                        'DD/MM/YYYY'
                       ) >=
                       TO_DATE (TO_CHAR (SYSDATE, 'DD/MM/YYYY'), 'DD/MM/YYYY')
            THEN
               ifrmaximo.pck_variaveis_prti.v_pck_verificacao := '1';

               INSERT INTO labtrans
                           (transdate,
                            laborcode, payrate,
                            otscale, eqnum, enterby,
                            enterdate,
                            transtype, outside,
                            ltl1, ltl2, ROLLUP,
                            glcreditacct,
                            genapprservreceipt, orgid,
                            siteid, refwo,
                            enteredastask,
                            dt_inicio_prev,
                            hr_inicio_prev, dt_termino_prev,
                            hr_termino_prev, labtransid,
                            lab3, regularhrs, othrs,
                                  startdate,
                                  linecost
                           )
                    VALUES (TO_DATE (TO_CHAR (SYSDATE, 'DD/MM/YYYY'),
                                     'DD/MM/YYYY'
                                    ),
                            verifica.laborcode, verifica.payrate,
                            verifica.otscale, verifica.eqnum, :NEW.changeby,
                            TO_DATE (TO_CHAR (SYSDATE, 'DD/MM/YYYY'),
                                     'DD/MM/YYYY'
                                    ),
                            verifica.transtype, verifica.outside,
                            verifica.ltl1, verifica.ltl2, verifica.ROLLUP,
                            verifica.glcreditacct,
                            verifica.genapprservreceipt, verifica.orgid,
                            verifica.siteid, verifica.refwo,
                            verifica.enteredastask,
                            TO_DATE (TO_CHAR (SYSDATE, 'DD/MM/YYYY'),
                                     'DD/MM/YYYY'
                                    ),
                            SYSDATE, verifica.dt_termino_prev,
                            verifica.hr_termino_prev, sequencial,
                            verifica.lab3, '10', '10',
                                  TO_DATE ('01/01/1900',
                                           'DD/MM/YYYY HH24:MI:SS'
                                          ),
                                  '10'
                           );

               :NEW.wo70 := NULL;
            END IF;

            :NEW.wo70 := NULL;
         END IF;

         IF :NEW.wo70 = 'INICIAR'
         THEN
            IF     :NEW.wo70 = 'INICIAR'
               AND verifica.dt_inicio IS NOT NULL
               AND verifica.hr_inicio IS NOT NULL
            THEN
               raise_application_error (-20699,
                                        'ESTA TAREFA JÁ FOI INICIADA.'
                                       );
            END IF;

            IF     verifica.dt_inicio IS NULL
               AND verifica.hr_inicio IS NULL
               AND verifica.dt_inicio_prev IS NOT NULL
            THEN
               FOR carga_lt IN cur_lab (:NEW.changeby)
               LOOP
                  v_check := 'S';

                  UPDATE labtrans
                     SET dt_termino =
                            TO_DATE (TO_CHAR (SYSDATE, 'DD/MM/YYYY'),
                                     'DD/MM/YYYY'
                                    ),
                         hr_termino = SYSDATE
                   WHERE refwo = carga_lt.refwo
                     AND laborcode = :NEW.changeby
                     AND siteid = carga_lt.siteid
                     AND orgid = carga_lt.orgid
                     AND dt_termino IS NULL
                     AND hr_termino IS NULL;

                  SELECT labtransseq.NEXTVAL
                    INTO sequencial
                    FROM DUAL;

                  IF TO_DATE (TO_CHAR (carga_lt.dt_termino_prev, 'DD/MM/YYYY'),
                              'DD/MM/YYYY'
                             ) >=
                        TO_DATE (TO_CHAR (SYSDATE, 'DD/MM/YYYY'),
                                 'DD/MM/YYYY')
                  THEN
                     ifrmaximo.pck_variaveis_prti.v_pck_verificacao := '1';

                     IF     TO_DATE (TO_CHAR (carga_lt.dt_termino_prev,
                                              'DD/MM/YYYY'
                                             ),
                                     'DD/MM/YYYY'
                                    ) =
                               TO_DATE (TO_CHAR (SYSDATE, 'DD/MM/YYYY'),
                                        'DD/MM/YYYY'
                                       )
                        AND TO_DATE (TO_CHAR (carga_lt.hr_termino_prev,
                                              'HH24:MI:SS'
                                             ),
                                     'HH24:MI:SS'
                                    ) <=
                               TO_DATE (TO_CHAR (SYSDATE, 'HH24:MI:SS'),
                                        'HH24:MI:SS'
                                       )
                     THEN
                        v_check := 'N';
                     END IF;

                     --                  IF v_check = 'S'    THEN
                     INSERT INTO labtrans
                                 (transdate,
                                  laborcode, payrate,
                                  otscale, eqnum,
                                  enterby,
                                  enterdate,
                                  transtype, outside,
                                  ltl1, ltl2,
                                  ROLLUP, glcreditacct,
                                  genapprservreceipt,
                                  orgid, siteid,
                                  refwo, enteredastask,
                                  dt_inicio_prev,
                                  hr_inicio_prev, dt_termino_prev,
                                  hr_termino_prev, labtransid,
                                  lab3, regularhrs, othrs,
                                  startdate,
                                  linecost
                                 )
                          VALUES (TO_DATE (TO_CHAR (SYSDATE, 'DD/MM/YYYY'),
                                           'DD/MM/YYYY'
                                          ),
                                  carga_lt.laborcode, carga_lt.payrate,
                                  carga_lt.otscale, carga_lt.eqnum,
                                  carga_lt.enterby,
                                  TO_DATE (TO_CHAR (SYSDATE, 'DD/MM/YYYY'),
                                           'DD/MM/YYYY'
                                          ),
                                  carga_lt.transtype, carga_lt.outside,
                                  carga_lt.ltl1, carga_lt.ltl2,
                                  carga_lt.ROLLUP, carga_lt.glcreditacct,
                                  carga_lt.genapprservreceipt,
                                  carga_lt.orgid, carga_lt.siteid,
                                  carga_lt.refwo, carga_lt.enteredastask,
                                  TO_DATE (TO_CHAR (SYSDATE, 'DD/MM/YYYY'),
                                           'DD/MM/YYYY'
                                          ),
                                  SYSDATE, carga_lt.dt_termino_prev,
                                  carga_lt.hr_termino_prev, sequencial,
                                  carga_lt.lab3, '10', '10',
                                  TO_DATE ('01/01/1900',
                                           'DD/MM/YYYY HH24:MI:SS'
                                          ),
                                  '10'
                                 );

                     --     END IF;
                     :NEW.wo70 := NULL;
                  END IF;
               END LOOP;

               UPDATE labtrans
                  SET dt_inicio =
                         TO_DATE (TO_CHAR (SYSDATE, 'DD/MM/YYYY'),
                                  'DD/MM/YYYY'
                                 ),
                      hr_inicio = SYSDATE
                WHERE refwo = :NEW.wonum
                  AND laborcode = :NEW.changeby
                  AND siteid = :NEW.siteid
                  AND orgid = :NEW.orgid
                  AND dt_inicio IS NULL
                  AND hr_inicio IS NULL
                  AND dt_termino IS NULL
                  AND hr_termino IS NULL;
            END IF;

            :NEW.PARENT := :NEW.changeby;
            :NEW.wo70 := NULL;
         END IF;

         IF :NEW.wo70 = 'TERMINAR'
         THEN
            IF     :NEW.wo70 = 'TERMINAR'
               AND verifica.dt_termino IS NOT NULL
               AND verifica.hr_termino IS NOT NULL
            THEN
               raise_application_error (-20699, 'TAREFA JÁ CONCLUÍDA.');
            END IF;

            IF (verifica.dt_termino IS NULL AND verifica.hr_termino IS NULL)
            THEN
               :NEW.PARENT := NULL;

               UPDATE labtrans
                  SET dt_termino =
                         TO_DATE (TO_CHAR (SYSDATE, 'DD/MM/YYYY'),
                                  'DD/MM/YYYY'
                                 ),
                      hr_termino = SYSDATE
                WHERE refwo = :NEW.wonum
                  AND laborcode = :NEW.changeby
                  AND siteid = :NEW.siteid
                  AND orgid = :NEW.orgid
                  AND dt_inicio IS NOT NULL
                  AND hr_inicio IS NOT NULL
                  AND hr_termino IS NULL;

               :NEW.wo70 := NULL;
            END IF;

            :NEW.wo70 := NULL;
         END IF;

         IF :NEW.wo70 = 'EXCLUIR PREVISÃO'
         THEN
            IF     :NEW.wo70 = 'EXCLUIR PREVISÃO'
               AND verifica.dt_inicio IS NOT NULL
               AND verifica.hr_inicio IS NOT NULL
               AND verifica.dt_termino IS NOT NULL
               AND verifica.hr_termino IS NOT NULL
            THEN
               raise_application_error (-20699, 'TAREFA JÁ CONCLUÍDA.');
            END IF;

            IF (    verifica.dt_inicio IS NULL
                AND verifica.hr_inicio IS NULL
                AND verifica.dt_termino IS NULL
                AND verifica.hr_termino IS NULL
               )
            THEN
               :NEW.PARENT := NULL;

               DELETE      labtrans
                     WHERE refwo = :NEW.wonum
                       AND laborcode = :NEW.changeby
                       AND rowstamp = verifica.rowstamp
                       AND siteid = :NEW.siteid
                       AND orgid = :NEW.orgid
                       AND dt_inicio IS NULL
                       AND hr_inicio IS NULL
                       AND dt_termino IS NULL
                       AND hr_termino IS NULL;
            END IF;

            :NEW.wo70 := NULL;
         END IF;

         :NEW.wo70 := NULL;
      END IF;

      IF TRIM (:NEW.wo70) = 'FECHAR OS'
      THEN
         IF :NEW.woeq8 = 'SIM'
         THEN
            v_colaborador := '0';
            v_fechada := 'N';

            IF     (    verifica.dt_inicio IS NOT NULL
                    AND verifica.hr_inicio IS NOT NULL
                    AND verifica.dt_termino IS NULL
                    AND verifica.hr_termino IS NULL
                   )
               AND verifica.laborcode = :NEW.changeby
            THEN
               UPDATE labtrans
                  SET dt_termino =
                         TO_DATE (TO_CHAR (SYSDATE, 'DD/MM/YYYY'),
                                  'DD/MM/YYYY'
                                 ),
                      hr_termino = SYSDATE
                WHERE refwo = :NEW.wonum
                  AND rowstamp = verifica.rowstamp
                  AND laborcode = :NEW.changeby
                  AND siteid = verifica.siteid
                  AND orgid = verifica.orgid
                  AND dt_inicio IS NOT NULL
                  AND hr_inicio IS NOT NULL
                  AND hr_termino IS NULL
                  AND dt_termino IS NULL;
            END IF;

            FOR verifica2 IN cur_fechamento (:NEW.wonum)
            LOOP
               IF v_colaborador = '0'
               THEN
                  IF (:NEW.changeby) = verifica2.laborcode
                  THEN
                     v_colaborador := '1';
                  END IF;
               END IF;

               IF (    verifica2.dt_inicio IS NOT NULL
                   AND verifica2.hr_inicio IS NOT NULL
                   AND verifica2.dt_termino IS NOT NULL
                   AND verifica2.hr_termino IS NOT NULL
                  )
               THEN
                  v_fechada := 'S';
               END IF;

               IF (   verifica2.dt_inicio IS NULL
                   OR verifica2.hr_inicio IS NULL
                   OR verifica2.dt_termino IS NULL
                   OR verifica2.hr_termino IS NULL
                  )
               THEN
                  raise_application_error
                               (-20699,
                                'FAVOR CONCLUIR A TAREFA QUE ESTÁ EM ABERTO.'
                               );
               END IF;
            END LOOP;

            IF v_colaborador = 'N'
            THEN
               :NEW.wo70 := NULL;
               raise_application_error
                  (-20699,
                   'USUÁRIO NÃO POSSUI AUTORIZAÇÃO PARA FECHAR ESTA ORDEM DE SERVIÇO.'
                  );
            END IF;

            IF v_fechada = 'S' AND v_colaborador = '1'
            THEN
               :NEW.PARENT := '';
               :NEW.status := 'FECHADA';
               :NEW.wo74 := 'FECHADA';
               :NEW.historyflag := 'S';
               :NEW.statusdate := TO_DATE (SYSDATE, 'DD/MM/YYYY HH24:MI:SS');
               :NEW.changedate := TO_DATE (SYSDATE, 'DD/MM/YYYY HH24:MI:SS');
               v_fechada := 'N';
               v_colaborador := 'N';

               INSERT INTO wostatus
                           (wonum, status,
                            changedate,
                            changeby, glaccount, orgid, siteid
                           )
                    VALUES (:NEW.wonum, 'FECHADA',
                            TO_DATE (SYSDATE, 'DD/MM/YYYY HH24:MI:SS'),
                            :NEW.changeby, :NEW.glaccount, :NEW.orgid, 'PRTI'
                           );

               :NEW.wo70 := NULL;
            END IF;

            :NEW.wo70 := NULL;
         END IF;                                 -- CAMPO WOEQ8 { FECHAMENTO }

         IF :NEW.woeq8 = 'NÃO'
         THEN
            raise_application_error
               (-20699,
                'OS BLOQUEADA PARA FECHAMENTO - ENTRE EM CONTATO COM O LÍDER DO SISTEMA.'
               );
         END IF;
      END IF;
   END LOOP;

   IF v_cont = '0'
   THEN
      :NEW.wo70 := NULL;
   END IF;

   :NEW.wo70 := NULL;
END;
/


CREATE OR REPLACE TRIGGER tr_workorder_indisponibilidade
 BEFORE
   UPDATE OF status
 ON workorder
REFERENCING NEW AS NEW OLD AS OLD
 FOR EACH ROW
WHEN ((NEW.siteid = 'INFRAERO')
)
DECLARE
   v_count    NUMBER (10);
   v_count2   NUMBER (10);
   v_msg      VARCHAR2 (800);
   v_erro     NUMBER (1);
   v_ativo    ifrmaximo.equipment.eq22%TYPE   := '';
BEGIN
--
   v_msg := CHR (13) || ' -------------------------------' || CHR (13);
   v_erro := 0;

   IF     (:NEW.status IN ('COMP', 'FECHADA'))
      AND :NEW.changeby IN ('I9830582', 'CTIS620')
   THEN
      --  OR TO_CHAR ((:NEW.wo19), '00,00') = '99,99'
      IF (TRIM (:NEW.wo19) = 99.99)
      THEN
         raise_application_error
                    (-20900,
                     fun_formatar_msg ('Digite o TEMPO DE INDISPONIBILIDADE.')
                    );
      END IF;

      IF TRIM (:NEW.wo19) IS NULL
      THEN
         raise_application_error
            (-20901,
             fun_formatar_msg
                          ('Digite TEMPO DE INDISPONIBILIDADE do equipamento.')
            );
      END IF;

      IF LENGTH (TRIM (:NEW.wo19)) = 0
      THEN
         raise_application_error
            (-20902,
             fun_formatar_msg
                          ('Digite TEMPO DE INDISPONIBILIDADE do equipamento.')
            );
      END IF;

      IF     (:NEW.status = 'FECHADA')
         AND :NEW.changeby IN ('I9830582', 'CTIS620')
      THEN
         IF :NEW.glaccount IS NULL
         THEN
            v_msg :=
                  v_msg
               || '-'
               || ' FAVOR INSIRA O CENTRO DE CUSTO BENEFICIÁRIO.'
               || SQLERRM
               || CHR (13);
            v_erro := 1;
         END IF;
      END IF;

      IF v_erro = 1
      THEN
         raise_application_error (-20669,
                                     v_msg
                                  || ' ------------------------------- '
                                  || CHR (13)
                                 );
      END IF;
   END IF;
END;
/


-- End of DDL Script for Trigger IFRMAXIMO.TR_WORKORDER_INDISPONIBILIDADE




-- Indexes for WORKORDER

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
  TABLESPACE  tsi_maximo
  STORAGE   (
    INITIAL     65536
    MINEXTENTS  1
    MAXEXTENTS  2147483645
  )
NOPARALLEL
LOGGING
/

CREATE INDEX workorder_ndx10 ON workorder
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
NOPARALLEL
LOGGING
/

CREATE INDEX workorder_ndx11 ON workorder
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
NOPARALLEL
LOGGING
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
  TABLESPACE  tsi_maximo
  STORAGE   (
    INITIAL     65536
    MINEXTENTS  1
    MAXEXTENTS  2147483645
  )
NOPARALLEL
LOGGING
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
  TABLESPACE  tsi_maximo
  STORAGE   (
    INITIAL     65536
    MINEXTENTS  1
    MAXEXTENTS  2147483645
  )
NOPARALLEL
LOGGING
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
  TABLESPACE  tsi_maximo
  STORAGE   (
    INITIAL     65536
    MINEXTENTS  1
    MAXEXTENTS  2147483645
  )
NOPARALLEL
LOGGING
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
  TABLESPACE  tsi_maximo
  STORAGE   (
    INITIAL     65536
    MINEXTENTS  1
    MAXEXTENTS  2147483645
  )
NOPARALLEL
LOGGING
/

CREATE INDEX workorder_ndx16 ON workorder
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
NOPARALLEL
LOGGING
/

CREATE INDEX workorder_ndx17 ON workorder
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
NOPARALLEL
LOGGING
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
  TABLESPACE  tsi_maximo
  STORAGE   (
    INITIAL     65536
    MINEXTENTS  1
    MAXEXTENTS  2147483645
  )
NOPARALLEL
LOGGING
/

CREATE INDEX workorder_ndx19 ON workorder
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
NOPARALLEL
LOGGING
/

/*
CREATE INDEX workorder_idx_temp ON workorder
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
NOPARALLEL
LOGGING
/

CREATE UNIQUE INDEX maxreportdate_idx ON workorder
  (
    wonum                           ASC,
    crewid                          ASC,
    status                          ASC,
    istask                          ASC,
    siteid                          ASC,
    orgid                           ASC,
    reportdate                      ASC,
    actstart                        ASC,
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
NOPARALLEL
LOGGING
/
*/

CREATE UNIQUE INDEX workorder_ndx1 ON workorder
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
NOPARALLEL
LOGGING
/

CREATE INDEX workorder_ndx2 ON workorder
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
NOPARALLEL
LOGGING
/

CREATE INDEX workorder_ndx3 ON workorder
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
NOPARALLEL
LOGGING
/

CREATE INDEX workorder_ndx4 ON workorder
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
NOPARALLEL
LOGGING
/

CREATE INDEX workorder_ndx5 ON workorder
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
NOPARALLEL
LOGGING
/

CREATE INDEX workorder_ndx6 ON workorder
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
NOPARALLEL
LOGGING
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
  TABLESPACE  tsi_maximo
  STORAGE   (
    INITIAL     65536
    MINEXTENTS  1
    MAXEXTENTS  2147483645
  )
NOPARALLEL
LOGGING
/

CREATE INDEX workorder_temp ON workorder
  (
  	siteid 													ASC,
  	status													ASC,
    wo8                             ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
  TABLESPACE  tsi_maximo
  STORAGE   (
    INITIAL     65536
    MINEXTENTS  1
    MAXEXTENTS  2147483645
  )
NOPARALLEL
LOGGING
/


