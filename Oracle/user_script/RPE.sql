/*==============================================================*/
/* Database name:  RPE_TESTE_PDM                                */
/* DBMS name:      ORACLE Version 8                             */
/* Created on:     14/06/2002 11:30:23                          */
/*==============================================================*/


drop index RECIBO_ITEM_FK
/


drop table RPE_ADICIONAL cascade constraints
/


drop table RPE_RECIBO_ITEM cascade constraints
/


drop table RPE_RECIBO cascade constraints
/


drop table RPE_EMBARQUE cascade constraints
/


drop table RPE_DESEMBARQUE cascade constraints
/


drop table RPE_DELETADO cascade constraints
/


drop table RPE_CATEGORIA cascade constraints
/


/*==============================================================*/
/* Table: RPE_CATEGORIA                                         */
/*==============================================================*/


create table RPE_CATEGORIA  (
   CAT_CD_CATEGORIA     CHAR(1)                          not null,
   CAT_DT_INICIO        DATE,
   CAT_DT_TERMINO       DATE,
   CAT_VL_DOM           NUMBER(8,2)                    default 0,
   CAT_VL_INT           NUMBER(8,2)                    default 0,
   constraint PK_RPE_CATEGORIA primary key (CAT_CD_CATEGORIA)
)
/


/*==============================================================*/
/* Table: RPE_DELETADO                                          */
/*==============================================================*/


create table RPE_DELETADO  (
   DEL_RPE_NUM          VARCHAR2(10)                     not null,
   DEL_RPE_DEP          CHAR(4)                          not null,
   DEL_CIA_AEREA        CHAR(3),
   DEL_MAT_AERONAVE     VARCHAR2(10),
   DEL_RPE_NUM_VOO      VARCHAR2(6),
   DEL_DT_VOO           DATE,
   DEL_DES_NUM_VOO      VARCHAR2(6),
   DEL_DES_DT_VOO       DATE,
   DEL_PAS_DOM          SMALLINT                       default 0,
   DEL_PAS_INT          SMALLINT                       default 0,
   DEL_PAS_DOM_ANT      SMALLINT                       default 0,
   DEL_PAS_INT_ANT      SMALLINT                       default 0,
   DEL_PAS_DOM_CHECK    SMALLINT                       default 0,
   DEL_PAS_INT_CHECK    SMALLINT                       default 0,
   constraint PK_RPE_DELETADO primary key (DEL_RPE_NUM, DEL_RPE_DEP)
)
/


/*==============================================================*/
/* Table: RPE_DESEMBARQUE                                       */
/*==============================================================*/


create table RPE_DESEMBARQUE  (
   DES_RPE_DEP          CHAR(1)                          not null,
   DES_RPE_NUM          VARCHAR2(10)                     not null,
   DES_CIA_AEREA        CHAR(3)                          not null,
   DES_MAT_AERONAVE     VARCHAR2(10)                     not null,
   DES_NUM_VOO          VARCHAR2(6),
   DES_DT_VOO           DATE,
   DES_HR_VOO           DATE,
   DES_NAT_VOO          CHAR(1)                          
         constraint CKC_DES_NAT_VOO_RPE_DESE check (DES_NAT_VOO is null or ( DES_NAT_VOO in ('D','I') )),
   DES_ESP_VOO          CHAR(2),
   DES_PAR_VOO          CHAR(2),
   DES_PAS_DOM          SMALLINT                       default 0,
   DES_PAS_INT          SMALLINT                       default 0,
   DES_PAS_DOM_CON      SMALLINT                       default 0,
   DES_PAS_INT_CON      SMALLINT                       default 0,
   DES_BAG_DOM          FLOAT                          default 0,
   DES_BAG_INT          FLOAT                          default 0,
   DES_BAG_DOM_CON      FLOAT                          default 0,
   DES_BAG_INT_CON      FLOAT                          default 0,
   DES_CAR_DOM          FLOAT                          default 0,
   DES_CAR_INT          FLOAT                          default 0,
   DES_CAR_DOM_CON      FLOAT                          default 0,
   DES_CAR_INT_CON      FLOAT                          default 0,
   DES_COR_DOM          FLOAT                          default 0,
   DES_COR_INT          FLOAT                          default 0,
   DES_COR_DOM_CON      FLOAT                          default 0,
   DES_COR_INT_CON      FLOAT                          default 0,
   constraint PK_RPE_DESEMBARQUE primary key (DES_RPE_DEP, DES_RPE_NUM)
)
/


/*==============================================================*/
/* Table: RPE_EMBARQUE                                          */
/*==============================================================*/


create table RPE_EMBARQUE  (
   EMB_RPE_DEP          CHAR(4)                          not null,
   EMB_RPE_NUM          VARCHAR2(10)                     not null,
   EMB_CIA_AEREA        CHAR(3)                          not null,
   EMB_MAT_AERONAVE     VARCHAR2(10)                     not null,
   EMB_NUM_VOO          VARCHAR2(10),
   EMB_DT_VOO           DATE,
   EMB_HR_VOO           DATE,
   EMB_NAT_VOO          CHAR(1),
   EMB_ESP_VOO          CHAR(2),
   EMB_PAR_VOO          CHAR(2),
   EMB_PAS_DOM          SMALLINT                       default 0,
   EMB_PAS_INT          SMALLINT                       default 0,
   EMB_PAS_DOM_ANT      SMALLINT                       default 0,
   EMB_PAS_INT_ANT      SMALLINT                       default 0,
   EMB_PAS_DOM_CHECK    SMALLINT                       default 0,
   EMB_PAS_INT_CHECK    SMALLINT                       default 0,
   EMB_PAS_DOM_CHECK_ANT SMALLINT                       default 0,
   EMB_PAS_INT_CHECK_ANT SMALLINT                       default 0,
   EMB_PAS_COLO         SMALLINT                       default 0,
   EMB_PAS_TR_BORDO     SMALLINT                       default 0,
   EMB_PAS_DOM_CON      SMALLINT                       default 0,
   EMB_PAS_INT_CON      SMALLINT                       default 0,
   EMB_BAG_DOM          FLOAT                          default 0,
   EMB_BAG_INT          FLOAT                          default 0,
   EMB_CAR_DOM          FLOAT                          default 0,
   EMB_CAR_INT          FLOAT                          default 0,
   EMB_PAS_IAC          SMALLINT,
   constraint PK_RPE_EMBARQUE primary key (EMB_RPE_DEP, EMB_RPE_NUM)
)
/


/*==============================================================*/
/* Table: RPE_RECIBO                                            */
/*==============================================================*/


create table RPE_RECIBO  (
   REC_NR_RECIBO        NUMBER(10)                       not null,
   REC_DEPENDENCIA      CHAR(4)                          not null,
   REC_CIA_AEREA        CHAR(3)                          not null,
   REC_DT_RECIBO        DATE                             not null,
   REC_TP_PAGAMENTO     CHAR(1)                          not null,
   REC_NR_DOCUMENTO     VARCHAR2(20),
   REC_VL_TOTAL         NUMBER(8,2)                    default 0,
   REC_VL_RECEBIDO      NUMBER(8,2)                    default 0,
   REC_VL_TROCO         NUMBER(8,2)                    default 0,
   REC_VL_DOLAR         NUMBER(8,2)                    default 0,
   REC_QT_ISE           SMALLINT                       default 0,
   constraint PK_RPE_RECIBO primary key (REC_NR_RECIBO)
)
/


/*==============================================================*/
/* Table: RPE_RECIBO_ITEM                                       */
/*==============================================================*/


create table RPE_RECIBO_ITEM  (
   REC_NR_RECIBO        NUMBER(10)                       not null,
   ITR_NR_VOO           VARCHAR2(10)                     not null,
   ITR_DOM_QTD          SMALLINT                       default 0  not null,
   ITR_INT_QTD          SMALLINT                       default 0  not null,
   ITR_NR_RPE           VARCHAR2(10),
   ITR_SELO_INI         VARCHAR2(10),
   ITR_SELO_FIM         VARCHAR2(10),
   constraint PK_RPE_RECIBO_ITEM primary key (REC_NR_RECIBO, ITR_NR_VOO),
   constraint FK_RPE_RECI_RECIBO_IT_RPE_RECI foreign key (REC_NR_RECIBO)
         references RPE_RECIBO (REC_NR_RECIBO)
)
/


/*==============================================================*/
/* Index: RECIBO_ITEM_FK                                        */
/*==============================================================*/
create  index RECIBO_ITEM_FK on RPE_RECIBO_ITEM (
   REC_NR_RECIBO ASC
)
/


/*==============================================================*/
/* Table: RPE_ADICIONAL                                         */
/*==============================================================*/


create table RPE_ADICIONAL  (
   EMB_RPE_DEP          CHAR(4)                          not null,
   EMB_RPE_NUM          VARCHAR2(10)                     not null,
   ADI_CIA_AEREA        CHAR(3),
   ADI_PAS_DOM          SMALLINT                       default 0,
   ADI_PAS_INT          SMALLINT                       default 0,
   ADI_PAS_DOM_ANT      SMALLINT                       default 0,
   ADI_PAS_INT_ANT      SMALLINT                       default 0,
   constraint PK_RPE_ADICIONAL primary key (EMB_RPE_DEP, EMB_RPE_NUM),
   constraint FK_RPE_ADIC_EMBARQUE__RPE_EMBA foreign key (EMB_RPE_DEP, EMB_RPE_NUM)
         references RPE_EMBARQUE (EMB_RPE_DEP, EMB_RPE_NUM)
)
/


