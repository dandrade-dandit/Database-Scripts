-- Start of DDL Script for Table IFRMAXIMO.wohistorico
-- Generated 8-dez-2003 14:32:17 from IFRMAXIMO@MAQUINA4.WORLD

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
  TABLESPACE  tsd_maximo
  STORAGE   (
    INITIAL     65536
    MINEXTENTS  1
    MAXEXTENTS  2147483645
  )
/

-- Grants for Table
GRANT SELECT ON wohistorico TO max_rel_01
/
GRANT SELECT ON wohistorico TO i4123837
/
GRANT SELECT ON wohistorico TO i3940314
/
GRANT SELECT ON wohistorico TO i9419583
/
GRANT UPDATE ON wohistorico TO i9419583
/
GRANT SELECT ON wohistorico TO i9434688
/
GRANT SELECT ON wohistorico TO i3944989
/
GRANT SELECT ON wohistorico TO i1414939
/
GRANT SELECT ON wohistorico TO i9543780
/
GRANT SELECT ON wohistorico TO i9530106
/
GRANT SELECT ON wohistorico TO i4221446
/
GRANT SELECT ON wohistorico TO i9602009
/
GRANT SELECT ON wohistorico TO i4157715
/
GRANT SELECT ON wohistorico TO i4258413
/
GRANT SELECT ON wohistorico TO i4259704
/
GRANT SELECT ON wohistorico TO i9402803
/
GRANT SELECT ON wohistorico TO i9085685
/
GRANT SELECT ON wohistorico TO i1556324
/
GRANT SELECT ON wohistorico TO i1523443
/
GRANT SELECT ON wohistorico TO i9507294
/
GRANT SELECT ON wohistorico TO i1556422
/
GRANT SELECT ON wohistorico TO i1460833
/
GRANT SELECT ON wohistorico TO i1558416
/
GRANT SELECT ON wohistorico TO i9651287
/
GRANT SELECT ON wohistorico TO i9567760
/
GRANT SELECT ON wohistorico TO i4719696
/
GRANT SELECT ON wohistorico TO i4104450
/
GRANT SELECT ON wohistorico TO i1472921
/
GRANT SELECT ON wohistorico TO i1073938
/
GRANT SELECT ON wohistorico TO i1702640
/
GRANT SELECT ON wohistorico TO i6711315
/
GRANT SELECT ON wohistorico TO i6660107
/
GRANT SELECT ON wohistorico TO i9561484
/
GRANT SELECT ON wohistorico TO i4172036
/
GRANT SELECT ON wohistorico TO i9700991
/
GRANT SELECT ON wohistorico TO i0174152
/
GRANT SELECT ON wohistorico TO i6035722
/
GRANT SELECT ON wohistorico TO i0208947
/
GRANT SELECT ON wohistorico TO i4187998
/
GRANT SELECT ON wohistorico TO i0805436
/
GRANT SELECT ON wohistorico TO i9472874
/
GRANT SELECT ON wohistorico TO i9457671
/
GRANT SELECT ON wohistorico TO i9457573
/
GRANT SELECT ON wohistorico TO i9102818
/
GRANT SELECT ON wohistorico TO i1940032
/
GRANT SELECT ON wohistorico TO i1949496
/
GRANT SELECT ON wohistorico TO i1943121
/
GRANT SELECT ON wohistorico TO i1937603
/
GRANT SELECT ON wohistorico TO i9548569
/
GRANT SELECT ON wohistorico TO i1939892
/
GRANT SELECT ON wohistorico TO i1936410
/
GRANT SELECT ON wohistorico TO i4187115
/
GRANT SELECT ON wohistorico TO i1951123
/
GRANT SELECT ON wohistorico TO i1929209
/
GRANT SELECT ON wohistorico TO i9567270
/
GRANT SELECT ON wohistorico TO i4182032
/
GRANT SELECT ON wohistorico TO i4121941
/
GRANT SELECT ON wohistorico TO i4141737
/
GRANT SELECT ON wohistorico TO i4110654
/
GRANT SELECT ON wohistorico TO i9595558
/
GRANT SELECT ON wohistorico TO i1455724
/
GRANT SELECT ON wohistorico TO i3943403
/
GRANT SELECT ON wohistorico TO i9513596
/
GRANT SELECT ON wohistorico TO i9535582
/
GRANT SELECT ON wohistorico TO i9512795
/
GRANT SELECT ON wohistorico TO i9410903
/
GRANT SELECT ON wohistorico TO i9400221
/
GRANT SELECT ON wohistorico TO i9400711
/
GRANT SELECT ON wohistorico TO i9202519
/
GRANT SELECT ON wohistorico TO i9401708
/
GRANT SELECT ON wohistorico TO i3943698
/
GRANT SELECT ON wohistorico TO i9557764
/
GRANT SELECT ON wohistorico TO i3932018
/
GRANT SELECT ON wohistorico TO i3930906
/
GRANT SELECT ON wohistorico TO i3937788
/
GRANT SELECT ON wohistorico TO i4128626
/
GRANT SELECT ON wohistorico TO i4199498
/
GRANT SELECT ON wohistorico TO i4733411
/
GRANT SELECT ON wohistorico TO i9402901
/
GRANT SELECT ON wohistorico TO i9400319
/
GRANT SELECT ON wohistorico TO i9429285
/
GRANT SELECT ON wohistorico TO i9566763
/
GRANT SELECT ON wohistorico TO i3947686
/
GRANT SELECT ON wohistorico TO i9527286
/
GRANT SELECT ON wohistorico TO i9609675
/
GRANT SELECT ON wohistorico TO i9402509
/
GRANT SELECT ON wohistorico TO i9514004
/
GRANT SELECT ON wohistorico TO i9544875
/
GRANT SELECT ON wohistorico TO i3317041
/
GRANT SELECT ON wohistorico TO i9526779
/
GRANT SELECT ON wohistorico TO i9520404
/
GRANT SELECT ON wohistorico TO i9527188
/
GRANT SELECT ON wohistorico TO i9602303
/
GRANT SELECT ON wohistorico TO i9529182
/
GRANT SELECT ON wohistorico TO i9553972
/
GRANT SELECT ON wohistorico TO i9554479
/
GRANT SELECT ON wohistorico TO i9612692
/
GRANT SELECT ON wohistorico TO i9706189
/
GRANT SELECT ON wohistorico TO i6637491
/
GRANT SELECT ON wohistorico TO i2323251
/
GRANT SELECT ON wohistorico TO i0169141
/
GRANT SELECT ON wohistorico TO i9719960
/
GRANT SELECT ON wohistorico TO i2316736
/
GRANT SELECT ON wohistorico TO i3294807
/
GRANT SELECT ON wohistorico TO i3297995
/
GRANT SELECT ON wohistorico TO i3412639
/
GRANT UPDATE ON wohistorico TO i3412639
/
GRANT SELECT ON wohistorico TO i2627028
/
GRANT SELECT ON wohistorico TO i9578557
/
GRANT SELECT ON wohistorico TO i3265228
/
GRANT SELECT ON wohistorico TO i9618968
/
GRANT SELECT ON wohistorico TO i9619083
/
GRANT SELECT ON wohistorico TO i4104254
/
GRANT SELECT ON wohistorico TO i0727427
/
GRANT SELECT ON wohistorico TO i9431206
/
GRANT SELECT ON wohistorico TO i2349225
/
GRANT SELECT ON wohistorico TO i0137551
/
GRANT SELECT ON wohistorico TO i3299499
/
GRANT SELECT ON wohistorico TO i3294317
/
GRANT SELECT ON wohistorico TO i3243830
/
GRANT SELECT ON wohistorico TO i0173155
/
GRANT SELECT ON wohistorico TO i2369707
/
GRANT SELECT ON wohistorico TO i3261044
/
GRANT SELECT ON wohistorico TO i9532395
/
GRANT SELECT ON wohistorico TO i1941519
/
GRANT SELECT ON wohistorico TO i4123543
/
GRANT SELECT ON wohistorico TO i4261332
/
GRANT SELECT ON wohistorico TO i9055304
/
GRANT SELECT ON wohistorico TO i0632835
/
GRANT SELECT ON wohistorico TO i9607877
/
GRANT SELECT ON wohistorico TO i3932999
/
GRANT SELECT ON wohistorico TO i9530204
/
GRANT SELECT ON wohistorico TO i9637865
/
GRANT SELECT ON wohistorico TO i4183029
/
GRANT SELECT ON wohistorico TO i3949386
/
GRANT SELECT ON wohistorico TO i9661087
/
GRANT SELECT ON wohistorico TO i9609087
/
GRANT SELECT ON wohistorico TO i6811997
/
GRANT SELECT ON wohistorico TO i6634205
/
GRANT UPDATE ON wohistorico TO i6634205
/
GRANT SELECT ON wohistorico TO i9524295
/
GRANT UPDATE ON wohistorico TO i9524295
/
GRANT SELECT ON wohistorico TO i9647371
/
GRANT SELECT ON wohistorico TO i4193515
/
GRANT SELECT ON wohistorico TO i4231736
/
GRANT SELECT ON wohistorico TO i4223440
/
GRANT SELECT ON wohistorico TO i4124050
/
GRANT SELECT ON wohistorico TO i9086094
/
GRANT SELECT ON wohistorico TO i9447871
/
GRANT SELECT ON wohistorico TO i9652872
/
GRANT SELECT ON wohistorico TO i9577266
/
GRANT SELECT ON wohistorico TO i9544581
/
GRANT SELECT ON wohistorico TO i3236727
/
GRANT SELECT ON wohistorico TO i1071748
/
GRANT SELECT ON wohistorico TO i3273720
/
GRANT SELECT ON wohistorico TO i9606292
/
GRANT SELECT ON wohistorico TO i9660776
/
GRANT SELECT ON wohistorico TO i3264035
/
GRANT SELECT ON wohistorico TO i9686946
/
GRANT SELECT ON wohistorico TO i0598602
/
GRANT SELECT ON wohistorico TO i4256223
/
GRANT SELECT ON wohistorico TO i4256321
/
GRANT SELECT ON wohistorico TO i4256811
/
GRANT SELECT ON wohistorico TO i4259116
/
GRANT SELECT ON wohistorico TO i4735994
/
GRANT SELECT ON wohistorico TO i4145823
/
GRANT SELECT ON wohistorico TO i0669018
/
GRANT SELECT ON wohistorico TO i0209650
/
GRANT SELECT ON wohistorico TO i0624441
/
GRANT SELECT ON wohistorico TO i0608045
/
GRANT SELECT ON wohistorico TO i0596020
/
GRANT SELECT ON wohistorico TO i0608339
/
GRANT SELECT ON wohistorico TO i9025414
/
GRANT SELECT ON wohistorico TO i9003820
/
GRANT SELECT ON wohistorico TO i9028896
/
GRANT SELECT ON wohistorico TO i9028994
/
GRANT SELECT ON wohistorico TO i9034707
/
GRANT SELECT ON wohistorico TO i9743770
/
GRANT SELECT ON wohistorico TO i1553823
/
GRANT SELECT ON wohistorico TO i0116268
/
GRANT SELECT ON wohistorico TO i1083836
/
GRANT SELECT ON wohistorico TO i2356622
/
GRANT SELECT ON wohistorico TO i2604535
/
GRANT SELECT ON wohistorico TO i2611050
/
GRANT SELECT ON wohistorico TO i2617718
/
GRANT SELECT ON wohistorico TO i2633722
/
GRANT SELECT ON wohistorico TO i2635128
/
GRANT SELECT ON wohistorico TO i3412737
/
GRANT SELECT ON wohistorico TO i3624227
/
GRANT SELECT ON wohistorico TO i4536314
/
GRANT SELECT ON wohistorico TO i4543123
/
GRANT SELECT ON wohistorico TO i6042139
/
GRANT SELECT ON wohistorico TO i6021640
/
GRANT SELECT ON wohistorico TO i6024043
/
GRANT SELECT ON wohistorico TO i6048807
/
GRANT SELECT ON wohistorico TO i6049510
/
GRANT SELECT ON wohistorico TO i6051922
/
GRANT SELECT ON wohistorico TO i6342418
/
GRANT SELECT ON wohistorico TO i6361413
/
GRANT SELECT ON wohistorico TO i6705896
/
GRANT SELECT ON wohistorico TO i6722112
/
GRANT SELECT ON wohistorico TO i6752689
/
GRANT SELECT ON wohistorico TO i6768079
/
GRANT SELECT ON wohistorico TO i9412701
/
GRANT SELECT ON wohistorico TO i9412898
/
GRANT SELECT ON wohistorico TO i9413012
/
GRANT SELECT ON wohistorico TO i9413993
/
GRANT SELECT ON wohistorico TO i9419681
/
GRANT SELECT ON wohistorico TO i9455775
/
GRANT SELECT ON wohistorico TO i9565962
/
GRANT SELECT ON wohistorico TO i4701331
/
GRANT SELECT ON wohistorico TO i9758261
/
GRANT SELECT ON wohistorico TO i9602794
/
GRANT SELECT ON wohistorico TO i9033514
/
GRANT SELECT ON wohistorico TO i9425199
/
GRANT SELECT ON wohistorico TO i9861273
/
GRANT SELECT ON wohistorico TO i9618674
/
GRANT SELECT ON wohistorico TO i9006615
/
GRANT SELECT ON wohistorico TO i6011546
/
GRANT SELECT ON wohistorico TO i9645965
/
GRANT SELECT ON wohistorico TO i9453487
/
GRANT SELECT ON wohistorico TO i0835522
/
GRANT SELECT ON wohistorico TO deflt
/
GRANT SELECT ON wohistorico TO i1944118
/
GRANT SELECT ON wohistorico TO i9413404
/
GRANT SELECT ON wohistorico TO i9665957
/
GRANT SELECT ON wohistorico TO i0839020
/
GRANT UPDATE ON wohistorico TO i0839020
/
GRANT SELECT ON wohistorico TO i9654866
/
GRANT SELECT ON wohistorico TO i9528283
/
GRANT SELECT ON wohistorico TO i9407102
/
GRANT SELECT ON wohistorico TO i9650192
/
GRANT SELECT ON wohistorico TO i9415987
/
GRANT SELECT ON wohistorico TO i9569362
/
GRANT SELECT ON wohistorico TO i9413699
/
GRANT SELECT ON wohistorico TO i9414205
/
GRANT SELECT ON wohistorico TO i2614335
/
GRANT SELECT ON wohistorico TO i9403506
/
GRANT SELECT ON wohistorico TO i9676852
/
GRANT SELECT ON wohistorico TO i9766067
/
GRANT SELECT ON wohistorico TO i9465379
/
GRANT SELECT ON wohistorico TO i9689643
/
GRANT SELECT ON wohistorico TO i9420409
/
GRANT SELECT ON wohistorico TO maxgrp01
/
GRANT SELECT ON wohistorico TO maxgrp02
/
GRANT SELECT ON wohistorico TO i9789736
/
GRANT SELECT ON wohistorico TO i3939782
/
GRANT SELECT ON wohistorico TO i9854464
/
GRANT SELECT ON wohistorico TO i0539917
/
GRANT SELECT ON wohistorico TO maxdema
/
GRANT SELECT ON wohistorico TO i9819857
/
GRANT SELECT ON wohistorico TO i3943109
/
GRANT SELECT ON wohistorico TO i9072207
/
GRANT SELECT ON wohistorico TO i9586265
/
GRANT SELECT ON wohistorico TO i9052803
/
GRANT SELECT ON wohistorico TO i9029991
/
GRANT SELECT ON wohistorico TO i9034021
/
GRANT SELECT ON wohistorico TO i9034805
/
GRANT SELECT ON wohistorico TO i9036113
/
GRANT SELECT ON wohistorico TO i9039399
/
GRANT SELECT ON wohistorico TO i9040323
/
GRANT SELECT ON wohistorico TO i9041026
/
GRANT SELECT ON wohistorico TO i9442101
/
GRANT SELECT ON wohistorico TO i6671983
/
GRANT SELECT ON wohistorico TO i6697957
/
GRANT SELECT ON wohistorico TO i6784083
/
GRANT SELECT ON wohistorico TO i9428974
/
GRANT SELECT ON wohistorico TO i9605981
/
GRANT SELECT ON wohistorico TO i9751576
/
GRANT SELECT ON wohistorico TO i9772761
/
GRANT SELECT ON wohistorico TO i9759552
/
GRANT SELECT ON wohistorico TO i9694066
/
GRANT SELECT ON wohistorico TO i9721490
/
GRANT SELECT ON wohistorico TO i6368883
/
GRANT SELECT ON wohistorico TO i9762373
/
GRANT SELECT ON wohistorico TO i9778743
/
GRANT SELECT ON wohistorico TO i4158810
/
GRANT SELECT ON wohistorico TO i4161533
/
GRANT SELECT ON wohistorico TO i4155231
/
GRANT SELECT ON wohistorico TO i3298109
/
GRANT SELECT ON wohistorico TO i9011920
/
GRANT SELECT ON wohistorico TO i2628417
/
GRANT SELECT ON wohistorico TO i2632725
/
GRANT SELECT ON wohistorico TO i9412407
/
GRANT SELECT ON wohistorico TO i9415693
/
GRANT SELECT ON wohistorico TO i9531496
/
GRANT SELECT ON wohistorico TO i9418488
/
GRANT SELECT ON wohistorico TO i9526681
/
GRANT SELECT ON wohistorico TO i9765952
/
GRANT SELECT ON wohistorico TO i9643481
/
GRANT SELECT ON wohistorico TO i9757950
/
GRANT SELECT ON wohistorico TO i9415889
/
GRANT SELECT ON wohistorico TO i1554232
/
GRANT SELECT ON wohistorico TO i1555719
/
GRANT SELECT ON wohistorico TO i9569754
/
GRANT SELECT ON wohistorico TO i9643677
/
GRANT SELECT ON wohistorico TO i9526975
/
GRANT SELECT ON wohistorico TO i9746859
/
GRANT SELECT ON wohistorico TO i4129525
/
GRANT UPDATE ON wohistorico TO i4129525
/
GRANT SELECT ON wohistorico TO i0745229
/
GRANT SELECT ON wohistorico TO i0718428
/
GRANT SELECT ON wohistorico TO i0515643
/
GRANT SELECT ON wohistorico TO i0622643
/
GRANT SELECT ON wohistorico TO i9626480
/
GRANT SELECT ON wohistorico TO i0619626
/
GRANT SELECT ON wohistorico TO i0644041
/
GRANT SELECT ON wohistorico TO i0627726
/
GRANT SELECT ON wohistorico TO i9655863
/
GRANT SELECT ON wohistorico TO i9027506
/
GRANT SELECT ON wohistorico TO i9646864
/
GRANT SELECT ON wohistorico TO i9624486
/
GRANT SELECT ON wohistorico TO i0748024
/
GRANT SELECT ON wohistorico TO i0670629
/
GRANT SELECT ON wohistorico TO i0809130
/
GRANT SELECT ON wohistorico TO i0609336
/
GRANT SELECT ON wohistorico TO i0809326
/
GRANT SELECT ON wohistorico TO i0643730
/
GRANT SELECT ON wohistorico TO i0689893
/
GRANT SELECT ON wohistorico TO i0613448
/
GRANT SELECT ON wohistorico TO i0808917
/
GRANT SELECT ON wohistorico TO i0668609
/
GRANT SELECT ON wohistorico TO i0721347
/
GRANT SELECT ON wohistorico TO i9624094
/
GRANT SELECT ON wohistorico TO i9649463
/
GRANT SELECT ON wohistorico TO i9650486
/
GRANT SELECT ON wohistorico TO i9650388
/
GRANT SELECT ON wohistorico TO i0602357
/
GRANT SELECT ON wohistorico TO i0713835
/
GRANT SELECT ON wohistorico TO i0580042
/
GRANT SELECT ON wohistorico TO i0814239
/
GRANT SELECT ON wohistorico TO i9655765
/
GRANT SELECT ON wohistorico TO i0805240
/
GRANT SELECT ON wohistorico TO i4118924
/
GRANT SELECT ON wohistorico TO i9039889
/
GRANT SELECT ON wohistorico TO i9495661
/
GRANT SELECT ON wohistorico TO i9056105
/
GRANT SELECT ON wohistorico TO i9083102
/
GRANT SELECT ON wohistorico TO i9581476
/
GRANT SELECT ON wohistorico TO i9677947
/
GRANT SELECT ON wohistorico TO i3941703
/
GRANT SELECT ON wohistorico TO i3942112
/
GRANT SELECT ON wohistorico TO i9539276
/
GRANT SELECT ON wohistorico TO i9553874
/
GRANT SELECT ON wohistorico TO i9557568
/
GRANT SELECT ON wohistorico TO i9585856
/
GRANT SELECT ON wohistorico TO i9743182
/
GRANT SELECT ON wohistorico TO i9743280
/
GRANT SELECT ON wohistorico TO i9743966
/
GRANT SELECT ON wohistorico TO i9746369
/
GRANT SELECT ON wohistorico TO i9756953
/
GRANT SELECT ON wohistorico TO i9771862
/
GRANT SELECT ON wohistorico TO i1086729
/
GRANT SELECT ON wohistorico TO i9698054
/
GRANT SELECT ON wohistorico TO i9743378
/
GRANT SELECT ON wohistorico TO i6385982
/
GRANT SELECT ON wohistorico TO i9751772
/
GRANT SELECT ON wohistorico TO i9771764
/
GRANT SELECT ON wohistorico TO i9769254
/
GRANT SELECT ON wohistorico TO i9771666
/
GRANT SELECT ON wohistorico TO i9767456
/
GRANT SELECT ON wohistorico TO i4540230
/
GRANT SELECT ON wohistorico TO i4540328
/
GRANT SELECT ON wohistorico TO i4522624
/
GRANT SELECT ON wohistorico TO i4549988
/
GRANT SELECT ON wohistorico TO i2371237
/
GRANT SELECT ON wohistorico TO i4549890
/
GRANT SELECT ON wohistorico TO i4539109
/
GRANT SELECT ON wohistorico TO i4526710
/
GRANT SELECT ON wohistorico TO i4526612
/
GRANT SELECT ON wohistorico TO i9672178
/
GRANT SELECT ON wohistorico TO i9776847
/
GRANT SELECT ON wohistorico TO i9781858
/
GRANT SELECT ON wohistorico TO i9769156
/
GRANT SELECT ON wohistorico TO i9010923
/
GRANT SELECT ON wohistorico TO i9011038
/
GRANT SELECT ON wohistorico TO i9642974
/
GRANT SELECT ON wohistorico TO i4540524
/
GRANT UPDATE ON wohistorico TO i4540524
/
GRANT SELECT ON wohistorico TO i9775752
/
GRANT SELECT ON wohistorico TO i9775164
/
GRANT SELECT ON wohistorico TO i9748755
/
GRANT SELECT ON wohistorico TO i9775850
/
GRANT SELECT ON wohistorico TO i9775948
/
GRANT SELECT ON wohistorico TO i9775066
/
GRANT SELECT ON wohistorico TO i9776749
/
GRANT SELECT ON wohistorico TO i9777060
/
GRANT SELECT ON wohistorico TO i9748951
/
GRANT SELECT ON wohistorico TO i9773954
/
GRANT SELECT ON wohistorico TO i4543221
/
GRANT SELECT ON wohistorico TO i4547013
/
GRANT SELECT ON wohistorico TO i9769646
/
GRANT SELECT ON wohistorico TO i4537213
/
GRANT SELECT ON wohistorico TO i4545607
/
GRANT SELECT ON wohistorico TO i9768649
/
GRANT SELECT ON wohistorico TO i9769450
/
GRANT SELECT ON wohistorico TO i9768747
/
GRANT SELECT ON wohistorico TO i4538995
/
GRANT SELECT ON wohistorico TO i4530332
/
GRANT SELECT ON wohistorico TO i4543907
/
GRANT SELECT ON wohistorico TO i9774167
/
GRANT SELECT ON wohistorico TO i4506326
/
GRANT SELECT ON wohistorico TO i4538897
/
GRANT SELECT ON wohistorico TO i9679255
/
GRANT SELECT ON wohistorico TO i9769548
/
GRANT SELECT ON wohistorico TO i4543711
/
GRANT SELECT ON wohistorico TO i9769352
/
GRANT SELECT ON wohistorico TO i4538014
/
GRANT SELECT ON wohistorico TO i9748853
/
GRANT SELECT ON wohistorico TO i4548697
/
GRANT SELECT ON wohistorico TO i9770473
/
GRANT SELECT ON wohistorico TO i9770277
/
GRANT SELECT ON wohistorico TO i4508320
/
GRANT SELECT ON wohistorico TO i9522104
/
GRANT SELECT ON wohistorico TO i6386685
/
GRANT SELECT ON wohistorico TO i6385001
/
GRANT SELECT ON wohistorico TO i9693951
/
GRANT SELECT ON wohistorico TO i9516783
/
GRANT SELECT ON wohistorico TO i4738397
/
GRANT SELECT ON wohistorico TO i9622884
/
GRANT SELECT ON wohistorico TO i4727109
/
GRANT SELECT ON wohistorico TO i4717701
/
GRANT SELECT ON wohistorico TO i2620833
/
GRANT SELECT ON wohistorico TO i9547866
/
GRANT SELECT ON wohistorico TO i9762471
/
GRANT SELECT ON wohistorico TO i0611846
/
GRANT SELECT ON wohistorico TO i9008511
/
GRANT SELECT ON wohistorico TO i6037030
/
GRANT SELECT ON wohistorico TO i9515001
/
GRANT SELECT ON wohistorico TO i6041338
/
GRANT SELECT ON wohistorico TO i6052135
/
GRANT SELECT ON wohistorico TO i6040635
/
GRANT SELECT ON wohistorico TO i6052429
/
GRANT SELECT ON wohistorico TO i6050435
/
GRANT SELECT ON wohistorico TO i6052625
/
GRANT SELECT ON wohistorico TO i6034921
/
GRANT SELECT ON wohistorico TO i6042923
/
GRANT SELECT ON wohistorico TO i9420017
/
GRANT SELECT ON wohistorico TO i2227636
/
GRANT SELECT ON wohistorico TO i9669651
/
GRANT SELECT ON wohistorico TO i6009526
/
GRANT SELECT ON wohistorico TO i6041142
/
GRANT SELECT ON wohistorico TO i6013442
/
GRANT SELECT ON wohistorico TO i9008021
/
GRANT SELECT ON wohistorico TO i6052527
/
GRANT SELECT ON wohistorico TO i9416101
/
GRANT SELECT ON wohistorico TO i9008805
/
GRANT SELECT ON wohistorico TO i6033336
/
GRANT SELECT ON wohistorico TO i6003250
/
GRANT SELECT ON wohistorico TO i6032633
/
GRANT SELECT ON wohistorico TO i6040439
/
GRANT SELECT ON wohistorico TO i6012151
/
GRANT SELECT ON wohistorico TO i9573572
/
GRANT SELECT ON wohistorico TO i9420311
/
GRANT SELECT ON wohistorico TO i6020839
/
GRANT SELECT ON wohistorico TO i6018721
/
GRANT SELECT ON wohistorico TO i6020447
/
GRANT SELECT ON wohistorico TO i0160658
/
GRANT SELECT ON wohistorico TO i9426980
/
GRANT SELECT ON wohistorico TO i6033532
/
GRANT SELECT ON wohistorico TO i6011840
/
GRANT SELECT ON wohistorico TO i9420213
/
GRANT SELECT ON wohistorico TO i6007336
/
GRANT SELECT ON wohistorico TO i6011154
/
GRANT SELECT ON wohistorico TO i6011252
/
GRANT SELECT ON wohistorico TO i6026527
/
GRANT SELECT ON wohistorico TO i6029714
/
GRANT SELECT ON wohistorico TO i6049706
/
GRANT SELECT ON wohistorico TO i6049412
/
GRANT SELECT ON wohistorico TO i6050043
/
GRANT SELECT ON wohistorico TO i9420115
/
GRANT SELECT ON wohistorico TO i6049608
/
GRANT SELECT ON wohistorico TO cviatecsp
/
GRANT SELECT ON wohistorico TO cecolaborsp
/
GRANT SELECT ON wohistorico TO cmpesp
/
GRANT SELECT ON wohistorico TO cntksp
/
GRANT SELECT ON wohistorico TO cmpeeg
/
GRANT SELECT ON wohistorico TO cmarinseg
/
GRANT SELECT ON wohistorico TO cteldatact
/
GRANT SELECT ON wohistorico TO cparanact
/
GRANT SELECT ON wohistorico TO i9826568
/
GRANT SELECT ON wohistorico TO i9446580
/
GRANT SELECT ON wohistorico TO i9563674
/
GRANT SELECT ON wohistorico TO i9663865
/
GRANT SELECT ON wohistorico TO i9672276
/
GRANT SELECT ON wohistorico TO i1930330
/
GRANT SELECT ON wohistorico TO i1929013
/
GRANT SELECT ON wohistorico TO i1930232
/
GRANT SELECT ON wohistorico TO i1940816
/
GRANT SELECT ON wohistorico TO i1942712
/
GRANT SELECT ON wohistorico TO i1943611
/
GRANT SELECT ON wohistorico TO i1944902
/
GRANT SELECT ON wohistorico TO i1946897
/
GRANT SELECT ON wohistorico TO i1947698
/
GRANT SELECT ON wohistorico TO i1947992
/
GRANT SELECT ON wohistorico TO i1948008
/
GRANT SELECT ON wohistorico TO i1948695
/
GRANT SELECT ON wohistorico TO i1949005
/
GRANT SELECT ON wohistorico TO i4181917
/
GRANT SELECT ON wohistorico TO i1950518
/
GRANT SELECT ON wohistorico TO i4105545
/
GRANT SELECT ON wohistorico TO i4125929
/
GRANT SELECT ON wohistorico TO i4126044
/
GRANT SELECT ON wohistorico TO i4128038
/
GRANT SELECT ON wohistorico TO i4166420
/
GRANT SELECT ON wohistorico TO i4166714
/
GRANT SELECT ON wohistorico TO i4166812
/
GRANT SELECT ON wohistorico TO i4167123
/
GRANT SELECT ON wohistorico TO i4186412
/
GRANT SELECT ON wohistorico TO i4191129
/
GRANT SELECT ON wohistorico TO i4194120
/
GRANT SELECT ON wohistorico TO i4194414
/
GRANT SELECT ON wohistorico TO i4711229
/
GRANT SELECT ON wohistorico TO i9070507
/
GRANT SELECT ON wohistorico TO i9083691
/
GRANT SELECT ON wohistorico TO i9085391
/
GRANT SELECT ON wohistorico TO i9436094
/
GRANT SELECT ON wohistorico TO i9462682
/
GRANT SELECT ON wohistorico TO i9520993
/
GRANT SELECT ON wohistorico TO i9530891
/
GRANT SELECT ON wohistorico TO i9637179
/
GRANT SELECT ON wohistorico TO i9611499
/
GRANT SELECT ON wohistorico TO i9632978
/
GRANT SELECT ON wohistorico TO i9633093
/
GRANT SELECT ON wohistorico TO i9635283
/
GRANT SELECT ON wohistorico TO i9637277
/
GRANT SELECT ON wohistorico TO i9679549
/
GRANT SELECT ON wohistorico TO i9682468
/
GRANT SELECT ON wohistorico TO i9685557
/
GRANT SELECT ON wohistorico TO cpontualfz
/
GRANT SELECT ON wohistorico TO cviateccf
/
GRANT SELECT ON wohistorico TO i0154356
/
GRANT SELECT ON wohistorico TO i0201478
/
GRANT SELECT ON wohistorico TO cviatecrf
/
GRANT SELECT ON wohistorico TO i1038743
/
GRANT SELECT ON wohistorico TO i1039446
/
GRANT SELECT ON wohistorico TO i1041466
/
GRANT SELECT ON wohistorico TO i1043264
/
GRANT SELECT ON wohistorico TO i1045356
/
GRANT SELECT ON wohistorico TO i1052655
/
GRANT SELECT ON wohistorico TO i1053260
/
GRANT SELECT ON wohistorico TO i1061066
/
GRANT SELECT ON wohistorico TO i1066541
/
GRANT SELECT ON wohistorico TO i1067930
/
GRANT SELECT ON wohistorico TO i1069434
/
GRANT SELECT ON wohistorico TO i1070163
/
GRANT SELECT ON wohistorico TO i1071356
/
GRANT SELECT ON wohistorico TO i1072353
/
GRANT SELECT ON wohistorico TO i1073840
/
GRANT SELECT ON wohistorico TO i1077044
/
GRANT SELECT ON wohistorico TO i1079822
/
GRANT SELECT ON wohistorico TO i1088429
/
GRANT SELECT ON wohistorico TO i4128332
/
GRANT SELECT ON wohistorico TO i4189305
/
GRANT SELECT ON wohistorico TO i9425591
/
GRANT SELECT ON wohistorico TO i9447577
/
GRANT SELECT ON wohistorico TO i9539668
/
GRANT SELECT ON wohistorico TO i9566175
/
GRANT SELECT ON wohistorico TO i9566273
/
GRANT SELECT ON wohistorico TO i9567074
/
GRANT SELECT ON wohistorico TO i9573082
/
GRANT SELECT ON wohistorico TO i9573376
/
GRANT SELECT ON wohistorico TO i9573474
/
GRANT SELECT ON wohistorico TO i9577854
/
GRANT SELECT ON wohistorico TO i9740681
/
GRANT SELECT ON wohistorico TO i9773268
/
GRANT SELECT ON wohistorico TO i9599154
/
GRANT SELECT ON wohistorico TO childemarf
/
GRANT SELECT ON wohistorico TO i1460637
/
GRANT SELECT ON wohistorico TO i1478217
/
GRANT SELECT ON wohistorico TO i1479999
/
GRANT SELECT ON wohistorico TO i1523345
/
GRANT SELECT ON wohistorico TO i1527137
/
GRANT SELECT ON wohistorico TO i1529915
/
GRANT SELECT ON wohistorico TO i1532050
/
GRANT SELECT ON wohistorico TO i1537231
/
GRANT SELECT ON wohistorico TO i1555817
/
GRANT SELECT ON wohistorico TO i4726406
/
GRANT SELECT ON wohistorico TO i4734506
/
GRANT SELECT ON wohistorico TO i9556865
/
GRANT SELECT ON wohistorico TO i9697743
/
GRANT SELECT ON wohistorico TO i4750804
/
GRANT SELECT ON wohistorico TO i9570777
/
GRANT SELECT ON wohistorico TO i9426686
/
GRANT SELECT ON wohistorico TO i9631393
/
GRANT SELECT ON wohistorico TO i9743476
/
GRANT SELECT ON wohistorico TO i2621242
/
GRANT SELECT ON wohistorico TO i2627126
/
GRANT SELECT ON wohistorico TO i2627616
/
GRANT SELECT ON wohistorico TO i2629806
/
GRANT SELECT ON wohistorico TO i2630731
/
GRANT SELECT ON wohistorico TO i2631238
/
GRANT SELECT ON wohistorico TO i2633330
/
GRANT SELECT ON wohistorico TO i2633820
/
GRANT SELECT ON wohistorico TO i9408296
/
GRANT SELECT ON wohistorico TO i9412211
/
GRANT SELECT ON wohistorico TO i9412505
/
GRANT SELECT ON wohistorico TO i9415497
/
GRANT SELECT ON wohistorico TO i9415595
/
GRANT SELECT ON wohistorico TO i9418684
/
GRANT SELECT ON wohistorico TO i9422894
/
GRANT SELECT ON wohistorico TO i9427095
/
GRANT SELECT ON wohistorico TO i9430111
/
GRANT SELECT ON wohistorico TO i9689153
/
GRANT SELECT ON wohistorico TO i9498358
/
GRANT SELECT ON wohistorico TO i9558663
/
GRANT SELECT ON wohistorico TO i9558761
/
GRANT SELECT ON wohistorico TO i9558859
/
GRANT SELECT ON wohistorico TO i9781270
/
GRANT SELECT ON wohistorico TO i9781368
/
GRANT SELECT ON wohistorico TO i9796741
/
GRANT SELECT ON wohistorico TO i4253722
/
GRANT SELECT ON wohistorico TO i0608535
/
GRANT SELECT ON wohistorico TO i3327429
/
GRANT SELECT ON wohistorico TO i3330446
/
GRANT SELECT ON wohistorico TO i9569558
/
GRANT SELECT ON wohistorico TO i9527678
/
GRANT SELECT ON wohistorico TO i9588455
/
GRANT SELECT ON wohistorico TO i9602598
/
GRANT SELECT ON wohistorico TO i4113057
/
GRANT SELECT ON wohistorico TO i9676754
/
GRANT SELECT ON wohistorico TO i9696256
/
GRANT SELECT ON wohistorico TO i9794453
/
GRANT SELECT ON wohistorico TO i9683759
/
GRANT SELECT ON wohistorico TO i9847361
/
GRANT SELECT ON wohistorico TO i9753668
/
GRANT SELECT ON wohistorico TO i9741776
/
GRANT SELECT ON wohistorico TO i9747660
/
GRANT SELECT ON wohistorico TO i9747758
/
GRANT SELECT ON wohistorico TO i9747856
/
GRANT SELECT ON wohistorico TO i9747954
/
GRANT SELECT ON wohistorico TO i9748265
/
GRANT SELECT ON wohistorico TO i9748559
/
GRANT SELECT ON wohistorico TO i9749164
/
GRANT SELECT ON wohistorico TO i9753766
/
GRANT SELECT ON wohistorico TO i9767750
/
GRANT SELECT ON wohistorico TO i9795842
/
GRANT SELECT ON wohistorico TO i9662280
/
GRANT SELECT ON wohistorico TO i0534638
/
GRANT SELECT ON wohistorico TO i9808178
/
GRANT UPDATE ON wohistorico TO i9808178
/
GRANT SELECT ON wohistorico TO i0566914
/
GRANT SELECT ON wohistorico TO i9856164
/
GRANT SELECT ON wohistorico TO i0577613
/
GRANT SELECT ON wohistorico TO i0583523
/
GRANT SELECT ON wohistorico TO i0590332
/
GRANT SELECT ON wohistorico TO i0603648
/
GRANT SELECT ON wohistorico TO i0605740
/
GRANT SELECT ON wohistorico TO i0607440
/
GRANT SELECT ON wohistorico TO i0608241
/
GRANT SELECT ON wohistorico TO i0608927
/
GRANT SELECT ON wohistorico TO i0609140
/
GRANT SELECT ON wohistorico TO i0610065
/
GRANT SELECT ON wohistorico TO i0618727
/
GRANT SELECT ON wohistorico TO i0619822
/
GRANT SELECT ON wohistorico TO i0623346
/
GRANT SELECT ON wohistorico TO i0623444
/
GRANT SELECT ON wohistorico TO i0624147
/
GRANT SELECT ON wohistorico TO i0627138
/
GRANT SELECT ON wohistorico TO i0645136
/
GRANT SELECT ON wohistorico TO i0646329
/
GRANT SELECT ON wohistorico TO i0647620
/
GRANT SELECT ON wohistorico TO i0655034
/
GRANT SELECT ON wohistorico TO i0661826
/
GRANT SELECT ON wohistorico TO i0661924
/
GRANT SELECT ON wohistorico TO i0677216
/
GRANT SELECT ON wohistorico TO i0677118
/
GRANT SELECT ON wohistorico TO i0681524
/
GRANT SELECT ON wohistorico TO i0687997
/
GRANT SELECT ON wohistorico TO i0700358
/
GRANT SELECT ON wohistorico TO i0707925
/
GRANT SELECT ON wohistorico TO i0720252
/
GRANT SELECT ON wohistorico TO i0721249
/
GRANT SELECT ON wohistorico TO i0748808
/
GRANT SELECT ON wohistorico TO i0751237
/
GRANT SELECT ON wohistorico TO i0751629
/
GRANT SELECT ON wohistorico TO i0753525
/
GRANT SELECT ON wohistorico TO i0757513
/
GRANT SELECT ON wohistorico TO i0759801
/
GRANT SELECT ON wohistorico TO i0765123
/
GRANT SELECT ON wohistorico TO i0797890
/
GRANT SELECT ON wohistorico TO i0795896
/
GRANT SELECT ON wohistorico TO i0796108
/
GRANT SELECT ON wohistorico TO i0799492
/
GRANT SELECT ON wohistorico TO i0806139
/
GRANT SELECT ON wohistorico TO i0808819
/
GRANT SELECT ON wohistorico TO i0809522
/
GRANT SELECT ON wohistorico TO i0809816
/
GRANT SELECT ON wohistorico TO i0814337
/
GRANT SELECT ON wohistorico TO i1558514
/
GRANT SELECT ON wohistorico TO i4102554
/
GRANT SELECT ON wohistorico TO i4193319
/
GRANT SELECT ON wohistorico TO i9006027
/
GRANT SELECT ON wohistorico TO i9023910
/
GRANT SELECT ON wohistorico TO i9024809
/
GRANT SELECT ON wohistorico TO i9025512
/
GRANT SELECT ON wohistorico TO i9026215
/
GRANT SELECT ON wohistorico TO i9026509
/
GRANT SELECT ON wohistorico TO i9794257
/
GRANT SELECT ON wohistorico TO i9029599
/
GRANT SELECT ON wohistorico TO i9037012
/
GRANT SELECT ON wohistorico TO i9035508
/
GRANT SELECT ON wohistorico TO i9035606
/
GRANT SELECT ON wohistorico TO i9037306
/
GRANT SELECT ON wohistorico TO i9038794
/
GRANT SELECT ON wohistorico TO i9038892
/
GRANT SELECT ON wohistorico TO i9040421
/
GRANT SELECT ON wohistorico TO i9040715
/
GRANT SELECT ON wohistorico TO i9042415
/
GRANT SELECT ON wohistorico TO i9042709
/
GRANT SELECT ON wohistorico TO i9042807
/
GRANT SELECT ON wohistorico TO i9047106
/
GRANT SELECT ON wohistorico TO i9053899
/
GRANT SELECT ON wohistorico TO i9055206
/
GRANT SELECT ON wohistorico TO i9068586
/
GRANT SELECT ON wohistorico TO i9624192
/
GRANT SELECT ON wohistorico TO i9624584
/
GRANT SELECT ON wohistorico TO i9626382
/
GRANT SELECT ON wohistorico TO i9626676
/
GRANT SELECT ON wohistorico TO i9649365
/
GRANT SELECT ON wohistorico TO i9677751
/
GRANT SELECT ON wohistorico TO i9681471
/
GRANT SELECT ON wohistorico TO i9421504
/
GRANT SELECT ON wohistorico TO maxgrp06
/
GRANT SELECT ON wohistorico TO i4734702
/
GRANT SELECT ON wohistorico TO i9051708
/
GRANT SELECT ON wohistorico TO i9055991
/
GRANT SELECT ON wohistorico TO i9033416
/
GRANT SELECT ON wohistorico TO i4149811
/
GRANT SELECT ON wohistorico TO i4155721
/
GRANT SELECT ON wohistorico TO i6715401
/
GRANT SELECT ON wohistorico TO i9525880
/
GRANT SELECT ON wohistorico TO i9607093
/
GRANT SELECT ON wohistorico TO i9657563
/
GRANT UPDATE ON wohistorico TO i9657563
/
GRANT SELECT ON wohistorico TO i9778547
/
GRANT SELECT ON wohistorico TO i9861175
/
GRANT SELECT ON wohistorico TO cexcelgl
/
GRANT SELECT ON wohistorico TO csm21gl
/
GRANT SELECT ON wohistorico TO cteamgl
/
GRANT SELECT ON wohistorico TO cviatecgl
/
GRANT SELECT ON wohistorico TO cthermarbe
/
GRANT SELECT ON wohistorico TO i6329503
/
GRANT SELECT ON wohistorico TO i6368589
/
GRANT SELECT ON wohistorico TO i6379190
/
GRANT SELECT ON wohistorico TO i9521107
/
GRANT SELECT ON wohistorico TO i9522987
/
GRANT SELECT ON wohistorico TO i9525978
/
GRANT SELECT ON wohistorico TO i6767474
/
GRANT SELECT ON wohistorico TO i6779170
/
GRANT SELECT ON wohistorico TO i6768961
/
GRANT SELECT ON wohistorico TO i6774479
/
GRANT SELECT ON wohistorico TO i6780585
/
GRANT SELECT ON wohistorico TO i6782579
/
GRANT SELECT ON wohistorico TO i9623195
/
GRANT SELECT ON wohistorico TO ctis304
/
GRANT SELECT ON wohistorico TO ctis620
/
GRANT SELECT ON wohistorico TO i9779446
/
GRANT SELECT ON wohistorico TO i0000000
/
GRANT UPDATE ON wohistorico TO i0000000
/
GRANT SELECT ON wohistorico TO cemantpa
/
GRANT SELECT ON wohistorico TO cengeletricapa
/
GRANT SELECT ON wohistorico TO cconbraspa
/
GRANT SELECT ON wohistorico TO i9805187
/
GRANT SELECT ON wohistorico TO i9819955
/
GRANT SELECT ON wohistorico TO i9794845
/
GRANT SELECT ON wohistorico TO i9794943
/
GRANT SELECT ON wohistorico TO i9792361
/
GRANT SELECT ON wohistorico TO i9796937
/
GRANT SELECT ON wohistorico TO i9828268
/
GRANT SELECT ON wohistorico TO i9830386
/
GRANT SELECT ON wohistorico TO i9830582
/
GRANT SELECT ON wohistorico TO i9829167
/
GRANT SELECT ON wohistorico TO i9824280
/
GRANT SELECT ON wohistorico TO cmpegl
/
GRANT SELECT ON wohistorico TO cicsupplygl
/
GRANT SELECT ON wohistorico TO i9796839
/
GRANT SELECT ON wohistorico TO ctecnengegl
/
GRANT SELECT ON wohistorico TO i9804974
/
GRANT SELECT ON wohistorico TO i9837267
/
GRANT SELECT ON wohistorico TO i9832282
/
GRANT SELECT ON wohistorico TO i9788739
/
GRANT SELECT ON wohistorico TO celshadayct
/
GRANT SELECT ON wohistorico TO i9581574
/
GRANT SELECT ON wohistorico TO cengeletricact
/
GRANT SELECT ON wohistorico TO csociplanct
/
GRANT SELECT ON wohistorico TO i9834178
/
GRANT SELECT ON wohistorico TO i9834080
/
GRANT SELECT ON wohistorico TO cgpcf
/
GRANT SELECT ON wohistorico TO cthermareg
/
GRANT SELECT ON wohistorico TO maxgrp03
/
GRANT SELECT ON wohistorico TO i9797444
/
GRANT SELECT ON wohistorico TO cviatecmo
/
GRANT SELECT ON wohistorico TO i9743084
/
GRANT SELECT ON wohistorico TO i9836368
/
GRANT SELECT ON wohistorico TO cviatecsv
/
GRANT SELECT ON wohistorico TO maxgrp07
/
GRANT UPDATE ON wohistorico TO maxgrp07
/
GRANT SELECT ON wohistorico TO maxgrp05
/
GRANT UPDATE ON wohistorico TO maxgrp05
/
GRANT SELECT ON wohistorico TO maxgrp04
/
GRANT SELECT ON wohistorico TO i9794355
/
GRANT SELECT ON wohistorico TO i0765417
/
GRANT SELECT ON wohistorico TO i9805383
/
GRANT SELECT ON wohistorico TO i9833965
/
GRANT SELECT ON wohistorico TO i9834668
/
GRANT SELECT ON wohistorico TO i9834570
/
GRANT SELECT ON wohistorico TO i9836662
/
GRANT SELECT ON wohistorico TO i9806576
/
GRANT SELECT ON wohistorico TO i9560977
/
GRANT SELECT ON wohistorico TO i9830484
/
GRANT SELECT ON wohistorico TO i9809175
/
GRANT SELECT ON wohistorico TO i9796055
/
GRANT SELECT ON wohistorico TO i9797640
/
GRANT SELECT ON wohistorico TO cctmfz
/
GRANT SELECT ON wohistorico TO i9851473
/
GRANT SELECT ON wohistorico TO i9847557
/
GRANT SELECT ON wohistorico TO i9850280
/
GRANT SELECT ON wohistorico TO c0579202
/
GRANT SELECT ON wohistorico TO cengeletricafz
/
GRANT SELECT ON wohistorico TO cproclimasv
/
GRANT SELECT ON wohistorico TO i9852862
/
GRANT SELECT ON wohistorico TO i9445965
/
GRANT SELECT ON wohistorico TO i9793260
/
GRANT SELECT ON wohistorico TO i9679070
/
GRANT SELECT ON wohistorico TO i9840382
/
GRANT SELECT ON wohistorico TO cmperj
/
GRANT SELECT ON wohistorico TO i9865261
/
GRANT SELECT ON wohistorico TO i9853173
/
GRANT SELECT ON wohistorico TO i9859743
/
GRANT SELECT ON wohistorico TO cmpekp
/
GRANT SELECT ON wohistorico TO csgekp
/
GRANT SELECT ON wohistorico TO cviateckp
/
GRANT SELECT ON wohistorico TO cengeletricakp
/
GRANT SELECT ON wohistorico TO cgutierrezkp
/
GRANT SELECT ON wohistorico TO cservteckp
/
GRANT SELECT ON wohistorico TO cicsupplyrj
/
GRANT SELECT ON wohistorico TO c768357313
/
GRANT SELECT ON wohistorico TO c710467203
/
GRANT SELECT ON wohistorico TO c679098843
/
GRANT SELECT ON wohistorico TO i4182031
/
GRANT SELECT ON wohistorico TO c1586799
/
GRANT SELECT ON wohistorico TO c1666499
/
GRANT SELECT ON wohistorico TO c5420202
/
GRANT SELECT ON wohistorico TO c5940702
/
GRANT SELECT ON wohistorico TO i9864950
/
GRANT SELECT ON wohistorico TO i9864852
/
GRANT SELECT ON wohistorico TO i9865065
/
GRANT SELECT ON wohistorico TO i9864460
/
GRANT SELECT ON wohistorico TO i9830974
/
GRANT SELECT ON wohistorico TO i9807475
/
GRANT SELECT ON wohistorico TO i9855755
/
GRANT SELECT ON wohistorico TO i9860668
/
GRANT SELECT ON wohistorico TO i9863463
/
GRANT SELECT ON wohistorico TO i9873753
/
GRANT SELECT ON wohistorico TO i0106235
/
GRANT SELECT ON wohistorico TO i9870468
/
GRANT SELECT ON wohistorico TO c0303700
/
GRANT UPDATE ON wohistorico TO c0303700
/
GRANT SELECT ON wohistorico TO ctranspolixgr
/
GRANT SELECT ON wohistorico TO i9855363
/
GRANT SELECT ON wohistorico TO i9879441
/
GRANT SELECT ON wohistorico TO c43719092
/
GRANT SELECT ON wohistorico TO cmpegr
/
GRANT SELECT ON wohistorico TO cntkgr
/
GRANT SELECT ON wohistorico TO ccascardigr
/
GRANT SELECT ON wohistorico TO csupplygr
/
GRANT SELECT ON wohistorico TO cinterwaygr
/
GRANT SELECT ON wohistorico TO cviatecgr
/
GRANT SELECT ON wohistorico TO cspreadgr
/
GRANT SELECT ON wohistorico TO csheffergr
/
GRANT SELECT ON wohistorico TO cultratecgr
/
GRANT SELECT ON wohistorico TO ciacitgr
/
GRANT SELECT ON wohistorico TO csistemagr
/
GRANT SELECT ON wohistorico TO cempressgr
/
GRANT SELECT ON wohistorico TO i9881657
/
GRANT SELECT ON wohistorico TO i9785944
/
GRANT SELECT ON wohistorico TO i9888146
/
GRANT SELECT ON wohistorico TO i9862760
/
GRANT SELECT ON wohistorico TO i9862368
/
GRANT SELECT ON wohistorico TO cotisgr
/
GRANT SELECT ON wohistorico TO catlasgr
/
GRANT SELECT ON wohistorico TO cmpepa
/
GRANT SELECT ON wohistorico TO i9891555
/
GRANT SELECT ON wohistorico TO i9900785
/
GRANT SELECT ON wohistorico TO i9893647
/
GRANT SELECT ON wohistorico TO i9896540
/
GRANT SELECT ON wohistorico TO maxgrp08
/
GRANT INSERT ON wohistorico TO maxsapiospa
/
GRANT SELECT ON wohistorico TO i9897047
/
GRANT SELECT ON wohistorico TO i9854954
/
GRANT SELECT ON wohistorico TO i9883945
/
GRANT SELECT ON wohistorico TO i9914181
/
GRANT SELECT ON wohistorico TO c514314960
/
GRANT SELECT ON wohistorico TO i9928949
/
GRANT SELECT ON wohistorico TO cjohnsonsv
/
GRANT SELECT ON wohistorico TO ctecnytsv
/
GRANT SELECT ON wohistorico TO i9541001
/
GRANT SELECT ON wohistorico TO i9933470
/
GRANT SELECT ON wohistorico TO i9900687
/
GRANT SELECT ON wohistorico TO i9818566
/
GRANT SELECT ON wohistorico TO i9920875
/
GRANT SELECT ON wohistorico TO i9823479
/
GRANT SELECT ON wohistorico TO i9866062
/
GRANT SELECT ON wohistorico TO i9929554
/
GRANT SELECT ON wohistorico TO i9923474
/
GRANT SELECT ON wohistorico TO i9923572
/
GRANT SELECT ON wohistorico TO i9903482
/
GRANT SELECT ON wohistorico TO i9934859
/
GRANT SELECT ON wohistorico TO i9936951
/
GRANT SELECT ON wohistorico TO sbbe01
/
GRANT SELECT ON wohistorico TO sbbr01
/
GRANT SELECT ON wohistorico TO sbcf01
/
GRANT SELECT ON wohistorico TO sbct01
/
GRANT SELECT ON wohistorico TO sbeg01
/
GRANT SELECT ON wohistorico TO sbfz01
/
GRANT SELECT ON wohistorico TO sbgl01
/
GRANT SELECT ON wohistorico TO sbgr01
/
GRANT SELECT ON wohistorico TO sbkp01
/
GRANT SELECT ON wohistorico TO sbmo01
/
GRANT SELECT ON wohistorico TO sbnt01
/
GRANT SELECT ON wohistorico TO sbpa01
/
GRANT SELECT ON wohistorico TO sbrf01
/
GRANT SELECT ON wohistorico TO sbrj01
/
GRANT SELECT ON wohistorico TO sbsp01
/
GRANT SELECT ON wohistorico TO sbsv01
/
GRANT SELECT ON wohistorico TO sbbe02
/
GRANT SELECT ON wohistorico TO sbbr02
/
GRANT SELECT ON wohistorico TO sbcf02
/
GRANT SELECT ON wohistorico TO sbct02
/
GRANT SELECT ON wohistorico TO sbeg02
/
GRANT SELECT ON wohistorico TO sbfz02
/
GRANT SELECT ON wohistorico TO sbgl02
/
GRANT SELECT ON wohistorico TO sbgr02
/
GRANT SELECT ON wohistorico TO sbkp02
/
GRANT SELECT ON wohistorico TO sbmo02
/
GRANT SELECT ON wohistorico TO sbnt02
/
GRANT SELECT ON wohistorico TO sbpa02
/
GRANT SELECT ON wohistorico TO sbrf02
/
GRANT SELECT ON wohistorico TO sbrj02
/
GRANT SELECT ON wohistorico TO sbsp02
/
GRANT SELECT ON wohistorico TO sbsv02
/
GRANT SELECT ON wohistorico TO sbbe03
/
GRANT SELECT ON wohistorico TO sbbr03
/
GRANT SELECT ON wohistorico TO sbcf03
/
GRANT SELECT ON wohistorico TO sbct03
/
GRANT SELECT ON wohistorico TO sbeg03
/
GRANT SELECT ON wohistorico TO sbfz03
/
GRANT SELECT ON wohistorico TO sbgl03
/
GRANT SELECT ON wohistorico TO sbgr03
/
GRANT SELECT ON wohistorico TO sbkp03
/
GRANT SELECT ON wohistorico TO sbmo03
/
GRANT SELECT ON wohistorico TO sbnt03
/
GRANT SELECT ON wohistorico TO sbpa03
/
GRANT SELECT ON wohistorico TO sbrf03
/
GRANT SELECT ON wohistorico TO sbrj03
/
GRANT SELECT ON wohistorico TO sbsp03
/
GRANT SELECT ON wohistorico TO sbsv03
/
GRANT SELECT ON wohistorico TO sbbe04
/
GRANT SELECT ON wohistorico TO sbbr04
/
GRANT SELECT ON wohistorico TO sbcf04
/
GRANT SELECT ON wohistorico TO sbct04
/
GRANT SELECT ON wohistorico TO sbeg04
/
GRANT SELECT ON wohistorico TO sbfz04
/
GRANT SELECT ON wohistorico TO sbgl04
/
GRANT SELECT ON wohistorico TO sbgr04
/
GRANT SELECT ON wohistorico TO sbkp04
/
GRANT SELECT ON wohistorico TO sbmo04
/
GRANT SELECT ON wohistorico TO sbnt04
/
GRANT SELECT ON wohistorico TO sbpa04
/
GRANT SELECT ON wohistorico TO sbrf04
/
GRANT SELECT ON wohistorico TO sbrj04
/
GRANT SELECT ON wohistorico TO sbsp04
/
GRANT SELECT ON wohistorico TO sbsv04
/
GRANT SELECT ON wohistorico TO dema02
/
GRANT SELECT ON wohistorico TO maxconsulta
/
GRANT SELECT ON wohistorico TO sbgratlas
/
GRANT SELECT ON wohistorico TO sbgrcascardi
/
GRANT SELECT ON wohistorico TO sbpaconbras
/
GRANT SELECT ON wohistorico TO sbfzctm
/
GRANT SELECT ON wohistorico TO sbspecolabor
/
GRANT SELECT ON wohistorico TO sbctelshaday
/
GRANT SELECT ON wohistorico TO sbpaemant
/
GRANT SELECT ON wohistorico TO sbgrempress
/
GRANT SELECT ON wohistorico TO sbctengeletrica
/
GRANT SELECT ON wohistorico TO sbfzengeletrica
/
GRANT SELECT ON wohistorico TO sbkpengeletrica
/
GRANT SELECT ON wohistorico TO sbpacengeletrica
/
GRANT SELECT ON wohistorico TO sbglexcel
/
GRANT SELECT ON wohistorico TO sbcfgp
/
GRANT SELECT ON wohistorico TO sbkpgutierrez
/
GRANT SELECT ON wohistorico TO sbrfhildema
/
GRANT SELECT ON wohistorico TO sbgriacit
/
GRANT SELECT ON wohistorico TO sbglicsupply
/
GRANT SELECT ON wohistorico TO sbrjicsupply
/
GRANT SELECT ON wohistorico TO sbgrinterway
/
GRANT SELECT ON wohistorico TO sbsvjohnson
/
GRANT SELECT ON wohistorico TO sbegmarins
/
GRANT SELECT ON wohistorico TO sbegmpe
/
GRANT SELECT ON wohistorico TO sbglmpe
/
GRANT SELECT ON wohistorico TO sbgrmpe
/
GRANT SELECT ON wohistorico TO sbkpmpe
/
GRANT SELECT ON wohistorico TO sbpampe
/
GRANT SELECT ON wohistorico TO sbrjmpe
/
GRANT SELECT ON wohistorico TO sbspmpe
/
GRANT SELECT ON wohistorico TO sbgrntk
/
GRANT SELECT ON wohistorico TO sbspntk
/
GRANT SELECT ON wohistorico TO sbgrotis
/
GRANT SELECT ON wohistorico TO sbctparana
/
GRANT SELECT ON wohistorico TO sbbepontual
/
GRANT SELECT ON wohistorico TO sbfzpontual
/
GRANT SELECT ON wohistorico TO sbsvproclima
/
GRANT SELECT ON wohistorico TO sbkpservtec
/
GRANT SELECT ON wohistorico TO sbkpsge
/
GRANT SELECT ON wohistorico TO sbgrcsistema
/
GRANT SELECT ON wohistorico TO sbglsm21
/
GRANT SELECT ON wohistorico TO sbctsociplan
/
GRANT SELECT ON wohistorico TO sbgrspread
/
GRANT SELECT ON wohistorico TO sbgrsupply
/
GRANT SELECT ON wohistorico TO sbglteam
/
GRANT SELECT ON wohistorico TO sbgltecnenge
/
GRANT SELECT ON wohistorico TO sbsvtecnyt
/
GRANT SELECT ON wohistorico TO sbctteldata
/
GRANT SELECT ON wohistorico TO sbbethermar
/
GRANT SELECT ON wohistorico TO sbegthermar
/
GRANT SELECT ON wohistorico TO sbgrtranspolix
/
GRANT SELECT ON wohistorico TO sbgrultratec
/
GRANT SELECT ON wohistorico TO sbcfviatec
/
GRANT SELECT ON wohistorico TO sbglviatec
/
GRANT SELECT ON wohistorico TO sbgrviatec
/
GRANT SELECT ON wohistorico TO sbkpviatec
/
GRANT SELECT ON wohistorico TO sbmoviatec
/
GRANT SELECT ON wohistorico TO sbrfviatec
/
GRANT SELECT ON wohistorico TO sbspviatec
/
GRANT SELECT ON wohistorico TO sbsvviatec
/
GRANT SELECT ON wohistorico TO dema01
/
GRANT SELECT ON wohistorico TO dema03
/
GRANT SELECT ON wohistorico TO dema04
/
GRANT SELECT ON wohistorico TO cema01
/
GRANT SELECT ON wohistorico TO cema02
/
GRANT SELECT ON wohistorico TO cema03
/
GRANT SELECT ON wohistorico TO cema04
/

-- Indexes for wohistorico

CREATE INDEX wohistorico_ndx17 ON wohistorico
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
/
CREATE INDEX wohistorico_ndx11 ON wohistorico
  (
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
/
CREATE UNIQUE INDEX wohistorico_ndx12 ON wohistorico
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
/
CREATE INDEX wohistorico_ndx13 ON wohistorico
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
/
CREATE INDEX wohistorico_ndx10 ON wohistorico
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
/
CREATE INDEX wohistorico_ndx14 ON wohistorico
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
/
CREATE INDEX wohistorico_ndx15 ON wohistorico
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
/
CREATE INDEX wohistorico_ndx16 ON wohistorico
  (
    siteid                          ASC,
    crewid                          ASC
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
/
CREATE INDEX wohistorico_ndx18 ON wohistorico
  (
    siteid                          ASC,
    crewid                          ASC,
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
PARALLEL (DEGREE DEFAULT)
/
CREATE UNIQUE INDEX wohistorico_ndx1 ON wohistorico
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
/
CREATE INDEX wohistorico_ndx2 ON wohistorico
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
/
CREATE INDEX wohistorico_ndx18 ON wohistorico
  (
    siteid                          ASC,
    crewid                          ASC,
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
PARALLEL (DEGREE DEFAULT)
/
CREATE INDEX wohistorico_ndx3 ON wohistorico
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
/
CREATE INDEX wohistorico_ndx4 ON wohistorico
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
/
CREATE INDEX wohistorico_ndx5 ON wohistorico
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
/
CREATE INDEX wohistorico_ndx6 ON wohistorico
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
/
CREATE INDEX wohistorico_ndx7 ON wohistorico
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
/
CREATE INDEX wohistorico_ndx8 ON wohistorico
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
/
CREATE INDEX wohistorico_ndx9 ON wohistorico
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
/
