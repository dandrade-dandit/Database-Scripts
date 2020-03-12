CREATE SEQUENCE SEQ_NUM_SEQ_LICITACAO
INCREMENT BY 1
START WITH 1
MAXVALUE 999999999999999
MINVALUE 1
NOCYCLE
CACHE 30
ORDER
/

CREATE SEQUENCE SEQ_NUM_SEQ_PAG_CONTRATO
INCREMENT BY 1
START WITH 1
MAXVALUE 999999999999999
MINVALUE 1
NOCYCLE
CACHE 30
ORDER
/
/*==============================================================*/
/* Table: TAB_TIPO_EVENTO_LICITACAO                             */
/*==============================================================*/


CREATE TABLE TAB_TIPO_LICITACAO  (
   COD_TIPO_LICITACAO      NUMBER(5)                        NOT NULL,
   DSC_TIPO_LICITACAO      VARCHAR2(50)                     NOT NULL,
   CONSTRAINT TAB_TIPO_LICITACAO_PK PRIMARY KEY (COD_TIPO_LICITACAO)
)
/

GRANT SELECT,INSERT,DELETE,UPDATE ON TAB_TIPO_LICITACAO TO ROLE_SIPRECO_VIEWS
/
GRANT SELECT,INSERT,DELETE,UPDATE ON TAB_TIPO_LICITACAO TO ROLE_SIPRECO
/
GRANT ALTER,SELECT,INSERT,DELETE,UPDATE ON TAB_TIPO_LICITACAO TO SIPRECO_VIEWS
/

/*==============================================================*/
/* Table: CAD_LICITACAO_CARENCIA                                */
/*==============================================================*/


CREATE TABLE CAD_LICITACAO_CARENCIA  (
   NUM_SEQ_LICITACAO    NUMBER(15)                       NOT NULL,
   NUM_SEQ_CARENCIA     NUMBER(10)                       NOT NULL,
   CRO_SEQUENCIAL       NUMBER(15),
   COD_TIPO_LICITACAO    NUMBER(5),
   NUM_PROCESSO_LICITACAO VARCHAR2(50),
   DAT_DOCUMENTO        DATE,
   NOM_DOCUMENTO_REFERENCIA  VARCHAR2(50),
   VAL_ORCADO_LICITACAO   NUMBER(18,2),
   VAL_VENCEDOR_LICITACAO NUMBER(18,2),
   DSC_OBSERVACAO       VARCHAR2(100),
   CONSTRAINT CAD_LICITACAO_CARENCIA_PK PRIMARY KEY (NUM_SEQ_LICITACAO),
   CONSTRAINT CAD_LICITACAO_CARENCIA_02_FK FOREIGN KEY (COD_TIPO_LICITACAO)
         REFERENCES TAB_TIPO_LICITACAO (COD_TIPO_LICITACAO)         
)
/


COMMENT ON TABLE CAD_LICITACAO_CARENCIA IS
'Cadastro principal do acompanhamento de Licitacao'
/


/*==============================================================*/
/* Index: CAD_LICITACAO_CARENCIA_01_IX                          */
/*==============================================================*/
CREATE INDEX CAD_LICITACAO_CARENCIA_01_IX ON CAD_LICITACAO_CARENCIA (
   NUM_PROCESSO_LICITACAO ASC,
   DAT_DOCUMENTO ASC
)
/

GRANT SELECT,INSERT,DELETE,UPDATE ON CAD_LICITACAO_CARENCIA TO ROLE_SIPRECO_VIEWS
/
GRANT SELECT,INSERT,DELETE,UPDATE ON CAD_LICITACAO_CARENCIA TO ROLE_SIPRECO
/
GRANT ALTER,SELECT,INSERT,DELETE,UPDATE ON CAD_LICITACAO_CARENCIA TO SIPRECO_VIEWS
/


/*==============================================================*/
/* Table: CAD_PAGAMENTO_CONTRATO                                */
/*==============================================================*/


CREATE TABLE CAD_PAGAMENTO_CONTRATO  (
   NUM_SEQ_PAG_CONTRATO NUMBER(15)                       NOT NULL,
   NUM_SEQ_CARENCIA     NUMBER(10)                       NOT NULL,
   NUM_CONTRATO         VARCHAR2(30)                     NOT NULL,
   NUM_ANO_PGOSE        VARCHAR2(4)                      NOT NULL,
   COD_RECURSO          VARCHAR2(5)                      NOT NULL,
   COD_TIPO_PAG         VARCHAR2(1)                      NOT NULL,
   DAT_PAGAMENTO        DATE                             NOT NULL,
   VAL_PAGAMENTO        NUMBER(12,2)                     NOT NULL,
   NUM_FATURA_PAGAMENTO VARCHAR2(30)                     NOT NULL,
   VAL_GLOSA            NUMBER(12,2),
   VAL_RETENCAO         NUMBER(12,2),
   NUM_SEQ_ENTIDADE     NUMBER(15),
   CONSTRAINT CAD_PAGAMENTO_CONTRATO_PK PRIMARY KEY (NUM_SEQ_PAG_CONTRATO),
   CONSTRAINT CAD_PAGAMENTO_CONTRATO_01_FK FOREIGN KEY (NUM_SEQ_CARENCIA, NUM_CONTRATO)
         REFERENCES TAB_CONTRATO (CNT_CRE_COD, CNT_COD),
   CONSTRAINT CAD_PAGAMENTO_CONTRATO_02_FK FOREIGN KEY (COD_RECURSO)
         REFERENCES TAB_TIPO_RECURSO_ITEM (RTI_COD),
   CONSTRAINT FK_CAD_PAGA_REFERENCE_TAB_FIRM FOREIGN KEY (NUM_SEQ_ENTIDADE)
         REFERENCES TAB_FIRMA (FIR_COD)
)
/


COMMENT ON COLUMN CAD_PAGAMENTO_CONTRATO.NUM_SEQ_PAG_CONTRATO IS
'Numero sequencial geral de pagamento de contrato'
/


COMMENT ON COLUMN CAD_PAGAMENTO_CONTRATO.NUM_SEQ_CARENCIA IS
'Codigo da Carencia proveniente do contrato'
/


COMMENT ON COLUMN CAD_PAGAMENTO_CONTRATO.NUM_CONTRATO IS
'Numero do Contrato do Pagamento'
/


COMMENT ON COLUMN CAD_PAGAMENTO_CONTRATO.NUM_ANO_PGOSE IS
'Ano do Pgose do Pagamento'
/


COMMENT ON COLUMN CAD_PAGAMENTO_CONTRATO.COD_RECURSO IS
'Codigo do Recurso da Carencia onde se efetua o pagamento'
/


COMMENT ON COLUMN CAD_PAGAMENTO_CONTRATO.COD_TIPO_PAG IS
'Tipo de Pagamento ( Pagamento, Reajuste )'
/


COMMENT ON COLUMN CAD_PAGAMENTO_CONTRATO.DAT_PAGAMENTO IS
'Data em que foi efetuado o pagamento'
/


COMMENT ON COLUMN CAD_PAGAMENTO_CONTRATO.VAL_PAGAMENTO IS
'Valor do Pagamento ou do Reajuste'
/


COMMENT ON COLUMN CAD_PAGAMENTO_CONTRATO.NUM_FATURA_PAGAMENTO IS
'Numero da fatura do Pagamento'
/


COMMENT ON COLUMN CAD_PAGAMENTO_CONTRATO.VAL_GLOSA IS
'Valor glosado no pagamento'
/


COMMENT ON COLUMN CAD_PAGAMENTO_CONTRATO.VAL_RETENCAO IS
'Valor da Retencao do Pagamento'
/


COMMENT ON COLUMN CAD_PAGAMENTO_CONTRATO.NUM_SEQ_ENTIDADE IS
'Codigo da Entidade para onde foi a retencao'
/


/*==============================================================*/
/* Index: CAD_PAGAMENTO_CONTRATO_01_IX                          */
/*==============================================================*/
CREATE UNIQUE INDEX CAD_PAGAMENTO_CONTRATO_01_IX ON CAD_PAGAMENTO_CONTRATO (
   NUM_SEQ_CARENCIA ASC,
   NUM_CONTRATO ASC,
   NUM_ANO_PGOSE ASC,
   COD_RECURSO ASC,
   COD_TIPO_PAG ASC,
   DAT_PAGAMENTO ASC
)
/

GRANT SELECT,INSERT,DELETE,UPDATE ON CAD_PAGAMENTO_CONTRATO TO ROLE_SIPRECO_VIEWS
/
GRANT SELECT,INSERT,DELETE,UPDATE ON CAD_PAGAMENTO_CONTRATO TO ROLE_SIPRECO
/
GRANT ALTER,SELECT,INSERT,DELETE,UPDATE ON CAD_PAGAMENTO_CONTRATO TO SIPRECO_VIEWS
/
/*==============================================================*/
/* Table: TAB_MESES_ANO                                         */
/*==============================================================*/


CREATE TABLE TAB_MESES_ANO  (
   NUM_ANO              NUMBER(4)                        NOT NULL,
   NUM_MES              NUMBER(2)                        NOT NULL,
   CONSTRAINT PK_TAB_MESES_ANO PRIMARY KEY (NUM_ANO, NUM_MES)
)
/

GRANT SELECT,INSERT,DELETE,UPDATE ON TAB_MESES_ANO TO ROLE_SIPRECO_VIEWS
/
GRANT SELECT,INSERT,DELETE,UPDATE ON TAB_MESES_ANO TO ROLE_SIPRECO
/
GRANT ALTER,SELECT,INSERT,DELETE,UPDATE ON TAB_MESES_ANO TO SIPRECO_VIEWS
/

/*==============================================================*/
/* Table: TAB_PRIORIDADE                                        */
/*==============================================================*/


CREATE TABLE TAB_PRIORIDADE  (
   COD_PRIORIDADE       NUMBER(4)                        NOT NULL,
   DSC_PRIORIDADE       VARCHAR2(20)                     NOT NULL,
   CONSTRAINT PK_TAB_PRIORIDADE PRIMARY KEY (COD_PRIORIDADE)
)
/

GRANT SELECT,INSERT,DELETE,UPDATE ON TAB_PRIORIDADE TO ROLE_SIPRECO_VIEWS
/
GRANT SELECT,INSERT,DELETE,UPDATE ON TAB_PRIORIDADE TO ROLE_SIPRECO
/
GRANT ALTER,SELECT,INSERT,DELETE,UPDATE ON TAB_PRIORIDADE TO SIPRECO_VIEWS
/


/*==============================================================*/
/* Table: TAB_TIPO_EVENTO_LICITACAO                             */
/*==============================================================*/


CREATE TABLE TAB_TIPO_EVENTO_LICITACAO  (
   COD_TIPO_EVENTO      NUMBER(3)                        NOT NULL,
   DSC_TIPO_EVENTO      VARCHAR2(50)                     NOT NULL,
   CONSTRAINT TAB_TIPO_EVENTO_LICITACAO_PK PRIMARY KEY (COD_TIPO_EVENTO)
)
/


COMMENT ON TABLE TAB_TIPO_EVENTO_LICITACAO IS
'Sao os diferentes tipos de situacoes onde a licitacao pode passar'
/


/*==============================================================*/
/* Index: TAB_TIPO_EVENTO_LICIT_01_IX                           */
/*==============================================================*/
CREATE INDEX TAB_TIPO_EVENTO_LICIT_01_IX ON TAB_TIPO_EVENTO_LICITACAO (
   DSC_TIPO_EVENTO ASC
)
/

GRANT SELECT,INSERT,DELETE,UPDATE ON TAB_TIPO_EVENTO_LICITACAO TO ROLE_SIPRECO_VIEWS
/
GRANT SELECT,INSERT,DELETE,UPDATE ON TAB_TIPO_EVENTO_LICITACAO TO ROLE_SIPRECO
/
GRANT ALTER,SELECT,INSERT,DELETE,UPDATE ON TAB_TIPO_EVENTO_LICITACAO TO SIPRECO_VIEWS
/

/*==============================================================*/
/* Table: CAD_EVENTOS_LICITACAO                                 */
/*==============================================================*/


CREATE TABLE CAD_EVENTOS_LICITACAO  (
   NUM_SEQ_EVENTO_LICITACAO NUMBER(15)                       NOT NULL,
   NUM_SEQ_GERAL_LICITACAO NUMBER(15)                       NOT NULL,
   DAT_EVENTO           DATE                         NOT NULL,
   COD_TIPO_EVENTO      NUMBER(3)                        NOT NULL,
   FLG_EVENTO_ATUAL     VARCHAR2(1)                      NOT NULL,
   CONSTRAINT EVENTOS_LICITACAO_PK PRIMARY KEY (NUM_SEQ_EVENTO_LICITACAO),
   CONSTRAINT CAD_EVENTOS_LICITACAO_02_FK FOREIGN KEY (COD_TIPO_EVENTO)
         REFERENCES TAB_TIPO_EVENTO_LICITACAO (COD_TIPO_EVENTO),
   CONSTRAINT CAD_EVENTOS_LICITACAO_01_FK FOREIGN KEY (NUM_SEQ_GERAL_LICITACAO)
         REFERENCES CAD_LICITACAO_CARENCIA (NUM_SEQ_LICITACAO)
)
/


COMMENT ON TABLE CAD_EVENTOS_LICITACAO IS
'Cadastro das diferentes situacoes da Licitacao'
/


/*==============================================================*/
/* Index: CAD_EVENTOS_LICITACAO_01_IX                           */
/*==============================================================*/
CREATE UNIQUE INDEX CAD_EVENTOS_LICITACAO_01_IX ON CAD_EVENTOS_LICITACAO (
   NUM_SEQ_GERAL_LICITACAO ASC,
   DAT_EVENTO ASC,
   COD_TIPO_EVENTO ASC
)
/

GRANT SELECT,INSERT,DELETE,UPDATE ON CAD_EVENTOS_LICITACAO TO ROLE_SIPRECO_VIEWS
/
GRANT SELECT,INSERT,DELETE,UPDATE ON CAD_EVENTOS_LICITACAO TO ROLE_SIPRECO
/
GRANT ALTER,SELECT,INSERT,DELETE,UPDATE ON CAD_EVENTOS_LICITACAO TO SIPRECO_VIEWS
/

