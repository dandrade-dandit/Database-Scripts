--Connectar com a conta CORRENTISTA e criar os objetos abaixo:
--

-- CAD_CRRNTA  (Table) 
--

conn CORRENTISTA/vpttrmyodys@sebn07

spo d:/teca/03_SEDE_correntista_tab.log

CREATE TABLE CORRENTISTA.CAD_CRRNTA
(
  COD_CRRNTA       NUMBER                       NOT NULL,
  NUM_CNPJ_EMPR    VARCHAR2(14)                NULL,
  NOM_RAZAO_SCIAL  VARCHAR2(50)                NULL,
  DSC_END_EMPR     VARCHAR2(50)                NULL,
  DSC_END_COMPL    VARCHAR2(50)                NULL,
  DSC_BAIRRO_EMPR  VARCHAR2(50)                NULL,
  DSC_CDADE_EMPR   VARCHAR2(50)                NULL,
  COD_SIGLA_UF     VARCHAR2(2)                 NULL,
  NUM_CEP_EMPR     NUMBER                           NULL,
  VAL_MOVTO_FNCRO  NUMBER(15,2)                     NULL,
  FLG_DEBTO_SRASA  VARCHAR2(1)                 NULL,
  FLG_DEBTO_CADIN  VARCHAR2(1)                 NULL,
  DAT_CAD_CRRNTA   DATE                         NOT NULL,
  FLG_DEBTO        VARCHAR2(1)                 NULL
)
TABLESPACE &&TSD_CORRENTISTA
STORAGE (initial 128k next 128k pctincrease 0)
/


--
-- MOVTC_FNCRO_TERMO  (Table) 
--
CREATE TABLE CORRENTISTA.MOVTC_FNCRO_TERMO
(
  TIP_MOVTC_FNCRO_TERMO  NUMBER                 NOT NULL,
  DSC_MOVTC_FNCRO_TERMO  VARCHAR2(50)          NULL,
  TIP_REGISTRO           NUMBER(1)              DEFAULT 1                         NULL
)
TABLESPACE &&TSD_CORRENTISTA
STORAGE (initial 128k next 128k pctincrease 0)
/






--
-- TRG_CAD_CRRNTA_I  (Trigger) 
--
CREATE OR REPLACE TRIGGER CORRENTISTA.TRG_CAD_CRRNTA_I
BEFORE INSERT
ON CORRENTISTA.CAD_CRRNTA 
REFERENCING NEW AS NEW OLD AS OLD
FOR EACH ROW

/******************************************************************************
   NAME:    TRG_CAD_CRRNTA_I 
   PURPOSE: Atualizar cad_crrnta.COD_CRRNTA 

   REVISIONS:
   Ver        Date        Author           Description
   ---------  ----------  ---------------  ------------------------------------
   1.0        06/01/2005  Simone           Criação da trigger 

   NOTES:

   Automatically available Auto Replace Keywords:
      Object Name:     
      Sysdate:         06/01/2005
      Date and Time:   06/01/2005, 14:02:07, and 06/01/2005 14:02:07
      Username:         (set in TOAD Options, Proc Templates)
      Table Name:       (set in the "New PL/SQL Object" dialog)
      Trigger Options:  (set in the "New PL/SQL Object" dialog)
******************************************************************************/
BEGIN

   SELECT SEQ_CAD_CRRNTA.NEXTVAL INTO :NEW.COD_CRRNTA FROM DUAL;
  
END ;
/
SHOW ERRORS;

--
-- CAD_TERMO_CRRNTA  (Table)
--
CREATE TABLE CORRENTISTA.CAD_TERMO_CRRNTA
(
  COD_TERMO_CRRNTA       NUMBER                 NOT NULL,
  NUM_ADCNL_TERMO        NUMBER                 NOT NULL,
  COD_CRRNTA             NUMBER                 NOT NULL,
  NUM_CF_ENVIO           VARCHAR2(20)          NULL,
  NUM_CF_RETORNO         VARCHAR2(20)          NULL,
  DAT_CAD_TERMO          DATE                   NOT NULL,
  TIP_MOVTC_FNCRO_TERMO  NUMBER                 NOT NULL,
  AER_COD                CHAR(3)               NULL,
  FLG_CLI_ESP            VARCHAR2(1)           NULL
)
TABLESPACE &&TSD_CORRENTISTA
STORAGE (initial 128k next 128k pctincrease 0)
/


--
-- HIS_MOVTC_TERMO  (Table)
--
CREATE TABLE CORRENTISTA.HIS_MOVTC_TERMO
(
  COD_TERMO_CRRNTA       NUMBER                 NOT NULL,
  NUM_ADCNL_TERMO        NUMBER                 NOT NULL,
  DAT_CAD_MOVTC_TERMO    DATE                   NOT NULL,
  TIP_MOVTC_FNCRO_TERMO  NUMBER                 NOT NULL,
  US_CODIGO              CHAR(10)              NULL,
  DSC_OBSERVACAO         VARCHAR2(100)         NULL
)
TABLESPACE &&TSD_CORRENTISTA
STORAGE (initial 1m next 1m pctincrease 0)
/


--
-- SOLTC_TERMO  (Table)
--
CREATE TABLE CORRENTISTA.SOLTC_TERMO
(
  COD_TERMO_CRRNTA  NUMBER                      NOT NULL,
  COD_REG           CHAR(2)                NOT NULL,
  NUM_ADCNL_TERMO   NUMBER                      NOT NULL,
  DSC_SOLTC_TERMO   CLOB                            NULL,
  US_CODIGO         CHAR(10)                   NULL
)
TABLESPACE &&TSD_CORRENTISTA
LOGGING
  LOB (DSC_SOLTC_TERMO) STORE AS
      ( TABLESPACE  &&TSD_LOB_CORRENTISTA
        ENABLE      STORAGE IN ROW
        CHUNK       4096
        PCTVERSION  10
        NOCACHE
      )
STORAGE (initial 512k next 512k pctincrease 0)
/


--
-- TAB_MOTVO_APRV  (Table)
--
CREATE TABLE CORRENTISTA.TAB_MOTVO_APRV
(
  COD_TERMO_CRRNTA  NUMBER                      NOT NULL,
  NUM_ADCNL_TERMO   NUMBER                      NOT NULL,
  DSC_MOTVO_APRV    CLOB                            NULL,
  US_CODIGO         CHAR(10)                   NULL
)
TABLESPACE &&TSD_CORRENTISTA
LOGGING
  LOB (DSC_MOTVO_APRV) STORE AS
      ( TABLESPACE  &&TSD_LOB_CORRENTISTA
        ENABLE      STORAGE IN ROW
        CHUNK       4096
        PCTVERSION  10
        NOCACHE
      )
STORAGE (initial 256k next 256k pctincrease 0)
/


--
-- TERMO_AER  (Table)
--
CREATE TABLE CORRENTISTA.TERMO_AER
(
  AER_COD             CHAR(3)              NOT NULL,
  COD_TERMO_CRRNTA    NUMBER                    NOT NULL,
  NUM_ADCNL_TERMO     NUMBER                    NOT NULL,
  FLG_APRVDO_CLIE     VARCHAR2(1)              NULL,
  FLG_ATULZ_TECAPLUS  VARCHAR2(1)              NULL,
  DSC_SUSPE_TERMO     CLOB                          NULL,
  DSC_CANCE_TERMO     CLOB                          NULL
)
TABLESPACE &&TSD_CORRENTISTA
LOGGING
  LOB (DSC_SUSPE_TERMO) STORE AS
      ( TABLESPACE  &&TSD_LOB_CORRENTISTA
        ENABLE      STORAGE IN ROW
        CHUNK       4096
        PCTVERSION  10
        NOCACHE
      )
  LOB (DSC_CANCE_TERMO) STORE AS
      ( TABLESPACE  &&TSD_LOB_CORRENTISTA
        ENABLE      STORAGE IN ROW
        CHUNK       4096
        PCTVERSION  10
        NOCACHE
      )
STORAGE (initial 10m next 5m pctincrease 0)
/


--
-- TERMO_MODLDE  (Table)
--
CREATE TABLE CORRENTISTA.TERMO_MODLDE
(
  COD_MODLDE          VARCHAR2(1)          NOT NULL,
  COD_TERMO_CRRNTA    NUMBER                    NOT NULL,
  NUM_ADCNL_TERMO     NUMBER                    NOT NULL,
  FLG_APRVDO_CLIE     VARCHAR2(1)              NULL,
  FLG_ATULZ_TECAPLUS  VARCHAR2(1)              NULL,
  DSC_MODLDE          VARCHAR2(30)             NULL
)
TABLESPACE &&TSD_CORRENTISTA
STORAGE (initial 512k next 512k pctincrease 0)
/

--
-- CAD_DPCHTE  (Table)
--
CREATE TABLE CORRENTISTA.CAD_DPCHTE
(
  COD_DPCHTE         NUMBER                     NOT NULL,
  NUM_RG_DPCHTE      VARCHAR2(9)           NOT NULL,
  NUM_CPF_DPCHTE     VARCHAR2(14)              NULL,
  NOM_DPCHTE         VARCHAR2(50)              NULL,
  DSC_END_DPCHTE     VARCHAR2(50)              NULL,
  DSC_END_COMPL      VARCHAR2(50)              NULL,
  DSC_BAIRRO_DPCHTE  VARCHAR2(50)              NULL,
  DSC_CDADE_DPCHTE   VARCHAR2(50)              NULL,
  COD_SIGLA_UF       VARCHAR2(2)               NULL,
  NUM_CEP_DPCHTE     NUMBER                         NULL,
  DAT_CAD_DPCHTE     DATE                       NOT NULL,
  COD_TERMO_CRRNTA   NUMBER                         NULL,
  NUM_ADCNL_TERMO    NUMBER                         NULL,
  DSC_ORG_EMI_RG     VARCHAR2(6)               NULL
)
TABLESPACE &&TSD_CORRENTISTA
STORAGE (initial 1m next 1m pctincrease 0)
/


--
-- CAD_REPRE  (Table)
--
CREATE TABLE CORRENTISTA.CAD_REPRE
(
  COD_REPRE         NUMBER                      NOT NULL,
  NUM_RG_REPRE      VARCHAR2(9)                NULL,
  NUM_CPF_REPRE     VARCHAR2(14)               NULL,
  NOM_REPRE         VARCHAR2(50)               NULL,
  DSC_NATU          VARCHAR2(50)               NULL,
  TIP_ESTDO_CIIVL   NUMBER                          NULL,
  DSC_ESTDO_CIVIL   VARCHAR2(30)               NULL,
  DSC_PRFSAO_REPRE  VARCHAR2(50)               NULL,
  DSC_END_REPRE     VARCHAR2(50)               NULL,
  DSC_END_COMPL     VARCHAR2(50)               NULL,
  DSC_BAIRO_REPRE   VARCHAR2(50)               NULL,
  DSC_CDADE_REPRE   VARCHAR2(50)               NULL,
  COD_SIGLA_UF      VARCHAR2(2)                NULL,
  NUM_CEP_REPRE     NUMBER                          NULL,
  DAT_CAD_REPRE     DATE                        NOT NULL,
  COD_TERMO_CRRNTA  NUMBER                          NULL,
  NUM_ADCNL_TERMO   NUMBER                          NULL,
  DSC_ORG_EMI_RG    VARCHAR2(6)                NULL,
  TIP_SEXO          VARCHAR2(1)            DEFAULT 'M'                   NOT NULL
)
TABLESPACE &&TSD_CORRENTISTA
STORAGE (initial 1M next 1M pctincrease 0)
/






--
-- TRG_CAD_DPCHTE_I  (Trigger)
--
CREATE OR REPLACE TRIGGER CORRENTISTA.TRG_CAD_DPCHTE_I
BEFORE INSERT
ON CORRENTISTA.CAD_DPCHTE
REFERENCING NEW AS NEW OLD AS OLD
FOR EACH ROW
/******************************************************************************
   NAME:      TRG_CAD_DPCHTE_I
   PURPOSE:    Inserir cod_dpchte

   REVISIONS:
   Ver        Date        Author           Description
   ---------  ----------  ---------------  ------------------------------------
   1.0        18/01/2005   Simone          1. Created this trigger.

   NOTES:

   Automatically available Auto Replace Keywords:
      Object Name:
      Sysdate:         18/01/2005
      Date and Time:   18/01/2005, 16:09:16, and 18/01/2005 16:09:16
      Username:         (set in TOAD Options, Proc Templates)
      Table Name:       (set in the "New PL/SQL Object" dialog)
      Trigger Options:  (set in the "New PL/SQL Object" dialog)
******************************************************************************/
BEGIN

	 SELECT SEQ_CAD_DPCHTE.NEXTVAL INTO :NEW.COD_DPCHTE FROM DUAL;

END ;
/
SHOW ERRORS;



--
-- TRG_CAD_REPRE_I  (Trigger)
--
CREATE OR REPLACE TRIGGER CORRENTISTA.TRG_CAD_REPRE_I
BEFORE INSERT
ON CORRENTISTA.CAD_REPRE
REFERENCING NEW AS NEW OLD AS OLD
FOR EACH ROW
/******************************************************************************
   NAME:      TRG_CAD_REPRE_I
   PURPOSE:    Inserir cod_repre

   REVISIONS:
   Ver        Date        Author           Description
   ---------  ----------  ---------------  ------------------------------------
   1.0        18/01/2005   Simone          1. Created this trigger.

   NOTES:

   Automatically available Auto Replace Keywords:
      Object Name:
      Sysdate:         18/01/2005
      Date and Time:   18/01/2005, 16:09:16, and 18/01/2005 16:09:16
      Username:         (set in TOAD Options, Proc Templates)
      Table Name:       (set in the "New PL/SQL Object" dialog)
      Trigger Options:  (set in the "New PL/SQL Object" dialog)
******************************************************************************/
BEGIN

	 SELECT SEQ_CAD_REPRE.NEXTVAL INTO :NEW.COD_REPRE FROM DUAL;

END ;
/
SHOW ERRORS;


CREATE INDEX CORRENTISTA.HIS_MOVTC_TERMO_01_IX ON HIS_MOVTC_TERMO
    (COD_TERMO_CRRNTA, NUM_ADCNL_TERMO) 
    TABLESPACE &&TSI_CORRENTISTA
    STORAGE (initial 1M next 1M pctincrease 0)
/



--
-- Non Foreign Key Constraints for Table CAD_CRRNTA
--
ALTER TABLE CORRENTISTA.CAD_CRRNTA ADD (
  CONSTRAINT CAD_CRRNTA_PK PRIMARY KEY (COD_CRRNTA)
    USING INDEX
    TABLESPACE &&TSI_CORRENTISTA
    STORAGE (initial 128k next 128k pctincrease 0))
/


--
-- Non Foreign Key Constraints for Table MOVTC_FNCRO_TERMO
--
ALTER TABLE CORRENTISTA.MOVTC_FNCRO_TERMO ADD (
  CONSTRAINT MOVTC_FNCRO_TERMO_PK PRIMARY KEY (TIP_MOVTC_FNCRO_TERMO)
    USING INDEX
    TABLESPACE &&TSI_CORRENTISTA
    STORAGE (initial 64k next 64k pctincrease 0))
/


--
-- Non Foreign Key Constraints for Table CAD_TERMO_CRRNTA
--
ALTER TABLE CORRENTISTA.CAD_TERMO_CRRNTA ADD (
  CONSTRAINT CAD_TERMO_CRRNTA_PK PRIMARY KEY (COD_TERMO_CRRNTA, NUM_ADCNL_TERMO)
    USING INDEX
    TABLESPACE &&TSI_CORRENTISTA
    STORAGE (initial 128k next 128k pctincrease 0))
/


--
-- Non Foreign Key Constraints for Table SOLTC_TERMO
--
ALTER TABLE CORRENTISTA.SOLTC_TERMO ADD (
  CONSTRAINT SOLTC_TERMO_PK PRIMARY KEY (COD_TERMO_CRRNTA, COD_REG, NUM_ADCNL_TERMO)
    USING INDEX
    TABLESPACE &&TSI_CORRENTISTA
    STORAGE (initial 512k next 512k pctincrease 0))
/


--
-- Non Foreign Key Constraints for Table TAB_MOTVO_APRV
--
ALTER TABLE CORRENTISTA.TAB_MOTVO_APRV ADD (
  CONSTRAINT TAB_MOVTO_APRV_PK PRIMARY KEY (COD_TERMO_CRRNTA, NUM_ADCNL_TERMO)
    USING INDEX
    TABLESPACE &&TSI_CORRENTISTA
    STORAGE (initial 128k next 128k pctincrease 0))
/


--
-- Non Foreign Key Constraints for Table TERMO_AER
--
ALTER TABLE CORRENTISTA.TERMO_AER ADD (
  CONSTRAINT TERMO_AER_PK PRIMARY KEY (AER_COD, COD_TERMO_CRRNTA, NUM_ADCNL_TERMO)
    USING INDEX
    TABLESPACE &&TSI_CORRENTISTA
    STORAGE (initial 5M next 1M pctincrease 0))
/


--
-- Non Foreign Key Constraints for Table TERMO_MODLDE
--
ALTER TABLE CORRENTISTA.TERMO_MODLDE ADD (
  CONSTRAINT TERMO_MODLDE_PK PRIMARY KEY (COD_MODLDE, COD_TERMO_CRRNTA, NUM_ADCNL_TERMO)
    USING INDEX
    TABLESPACE &&TSI_CORRENTISTA
    STORAGE (initial 512k next 512k pctincrease 0))
/


--
-- Non Foreign Key Constraints for Table CAD_DPCHTE
--
ALTER TABLE CORRENTISTA.CAD_DPCHTE ADD (
  CONSTRAINT CAD_DPCHTE_PK PRIMARY KEY (COD_DPCHTE)
    USING INDEX
    TABLESPACE &&TSI_CORRENTISTA
    STORAGE (initial 512k next 512k pctincrease 0))
/


--
-- Non Foreign Key Constraints for Table CAD_REPRE
--
ALTER TABLE CORRENTISTA.CAD_REPRE ADD (
  CONSTRAINT CAD_REPRE_PK PRIMARY KEY (COD_REPRE)
    USING INDEX
    TABLESPACE &&TSI_CORRENTISTA
    STORAGE (initial 512k next 512k pctincrease 0))
/


--
-- Foreign Key Constraints for Table CAD_TERMO_CRRNTA
--
ALTER TABLE CORRENTISTA.CAD_TERMO_CRRNTA ADD (
  CONSTRAINT CAD_TERMO_CRRNTA_FK_01 FOREIGN KEY (AER_COD)
    REFERENCES IFRTECA.TKP_TECAS (AER_COD))
/

ALTER TABLE CORRENTISTA.CAD_TERMO_CRRNTA ADD (
  CONSTRAINT CAD_TERMO_CRRNTA_FK_02 FOREIGN KEY (TIP_MOVTC_FNCRO_TERMO)
    REFERENCES CORRENTISTA.MOVTC_FNCRO_TERMO (TIP_MOVTC_FNCRO_TERMO))
/

ALTER TABLE CORRENTISTA.CAD_TERMO_CRRNTA ADD (
  CONSTRAINT CAD_TERMO_CRRNTA_FK_03 FOREIGN KEY (COD_CRRNTA)
    REFERENCES CORRENTISTA.CAD_CRRNTA (COD_CRRNTA))
/


--
-- Foreign Key Constraints for Table HIS_MOVTC_TERMO
--
ALTER TABLE CORRENTISTA.HIS_MOVTC_TERMO ADD (
  CONSTRAINT HIS_MOVTC_TERMO_FK_02 FOREIGN KEY (TIP_MOVTC_FNCRO_TERMO)
    REFERENCES CORRENTISTA.MOVTC_FNCRO_TERMO (TIP_MOVTC_FNCRO_TERMO))
/

ALTER TABLE CORRENTISTA.HIS_MOVTC_TERMO ADD (
  CONSTRAINT HIS_MOVTC_TERMO_FK_03 FOREIGN KEY (COD_TERMO_CRRNTA, NUM_ADCNL_TERMO)
    REFERENCES CORRENTISTA.CAD_TERMO_CRRNTA (COD_TERMO_CRRNTA,NUM_ADCNL_TERMO))
/


--
-- Foreign Key Constraints for Table SOLTC_TERMO
--
ALTER TABLE CORRENTISTA.SOLTC_TERMO ADD (
  CONSTRAINT SOLTC_TERMO_FK FOREIGN KEY (COD_TERMO_CRRNTA, NUM_ADCNL_TERMO)
    REFERENCES CORRENTISTA.CAD_TERMO_CRRNTA (COD_TERMO_CRRNTA,NUM_ADCNL_TERMO))
/


--
-- Foreign Key Constraints for Table TAB_MOTVO_APRV
--
ALTER TABLE CORRENTISTA.TAB_MOTVO_APRV ADD (
  CONSTRAINT TAB_MOVTO_APRV_FK FOREIGN KEY (COD_TERMO_CRRNTA, NUM_ADCNL_TERMO)
    REFERENCES CORRENTISTA.CAD_TERMO_CRRNTA (COD_TERMO_CRRNTA,NUM_ADCNL_TERMO))
/


--
-- Foreign Key Constraints for Table TERMO_AER
--
ALTER TABLE CORRENTISTA.TERMO_AER ADD (
  CONSTRAINT TERMO_AER_FK_01 FOREIGN KEY (AER_COD)
    REFERENCES IFRTECA.TKP_TECAS (AER_COD))
/

ALTER TABLE CORRENTISTA.TERMO_AER ADD (
  CONSTRAINT TERMO_AER_FK_02 FOREIGN KEY (COD_TERMO_CRRNTA, NUM_ADCNL_TERMO)
    REFERENCES CORRENTISTA.CAD_TERMO_CRRNTA (COD_TERMO_CRRNTA,NUM_ADCNL_TERMO))
/


--
-- Foreign Key Constraints for Table TERMO_MODLDE
--
ALTER TABLE CORRENTISTA.TERMO_MODLDE ADD (
  CONSTRAINT TERMO_MODLDE_FK FOREIGN KEY (COD_TERMO_CRRNTA, NUM_ADCNL_TERMO)
    REFERENCES CORRENTISTA.CAD_TERMO_CRRNTA (COD_TERMO_CRRNTA,NUM_ADCNL_TERMO))
/


--
-- Foreign Key Constraints for Table CAD_DPCHTE
--
ALTER TABLE CORRENTISTA.CAD_DPCHTE ADD (
  CONSTRAINT CAD_DPCHTE_FK FOREIGN KEY (COD_TERMO_CRRNTA, NUM_ADCNL_TERMO)
    REFERENCES CORRENTISTA.CAD_TERMO_CRRNTA (COD_TERMO_CRRNTA,NUM_ADCNL_TERMO))
/


--
-- Foreign Key Constraints for Table CAD_REPRE
--
ALTER TABLE CORRENTISTA.CAD_REPRE ADD (
  CONSTRAINT CAD_REPRE_FK FOREIGN KEY (COD_TERMO_CRRNTA, NUM_ADCNL_TERMO)
    REFERENCES CORRENTISTA.CAD_TERMO_CRRNTA (COD_TERMO_CRRNTA,NUM_ADCNL_TERMO))
/


spo off
