CREATE TABLE SS_LOTE_PORTADOR (
   SG_SISTEMA              	VARCHAR2(20)     NOT NULL
,   DT_GERACAO            	DATE             NOT NULL
,   NR_LOTE                     NUMBER(8)        NOT NULL
,   QT_REGISTROS          	NUMBER(8)        NULL
,   FL_CARREGADO       		VARCHAR2(1)      NULL
)
/

CREATE TABLE SS_PORTADOR (
     COD_PORTADOR              VARCHAR2(17)                NOT NULL
,    DESCR_PORTADOR            VARCHAR2(35)                NULL
,    COD_INATIV                VARCHAR2(1)                 NULL  
,    TIPO_ENDERECO             VARCHAR2(6)                 NULL
,    CONTATO                   VARCHAR2(35)                NULL
,    ENDERECO_1                VARCHAR2(35)                NULL
,    BRANCO_1                  VARCHAR2(35)                NULL
,    BRANCO_2                  VARCHAR2(35)                NULL
,    BRANCO_3                  VARCHAR2(35)                NULL
,    ENDERECO_2                VARCHAR2(35)                NULL
,    BAIRRO                    VARCHAR2(35)                NULL
,    BRANCO_4                  VARCHAR2(35)                NULL
,    CIDADE                    VARCHAR2(35)                NULL
,    ESTADO                    VARCHAR2(9)                 NULL
,    CEP                       VARCHAR2(9)                 NULL
,    PAIS                      VARCHAR2(2)                 NULL
,    FORMATO_TELEFONE          VARCHAR2(6)                 NULL
,    COD_INTER_TELEFONE        VARCHAR2(4)                 NULL
,    COD_PAIS                  VARCHAR2(4)                 NULL
,    COD_CIDADE                VARCHAR2(5)                 NULL
,    NUM_TELEFONE              VARCHAR2(12)                NULL 
,    RAMAL                     VARCHAR2(5)                 NULL
,    FORMATO_FAX               VARCHAR2(4)                 NULL
,    COD_PAIS_FAX              VARCHAR2(4)                 NULL
,    COD_CIDADE_FAX            VARCHAR2(3)                 NULL
,    NUMERO_FAX                VARCHAR2(8)                 NULL
,    COD_INTERNO_SIS           VARCHAR2(1)                 NULL
,    SG_SISTEMA                VARCHAR2(20)                NOT NULL
,    DT_GERACAO                DATE                        NOT NULL
,    NR_LOTE                   NUMBER(8)                   NOT NULL
)
/

ALTER TABLE CLIENTES_INFRAERO
ADD FLG_PASSAR_SMART VARCHAR(1) DEFAULT 'N' NOT NULL
/


INSERT INTO TABELAS VALUES  ('SUCC', 'SS_LOTE_PORTADOR', 'INTEGRACAO', 'TABELA')
/

INSERT INTO TABELAS VALUES  ('SUCC', 'SS_PORTADOR', 'INTEGRACAO', 'TABELA')
/

CREATE PUBLIC SYNONYM SS_LOTE_PORTADOR FOR INTEGRACAO.SS_LOTE_PORTADOR
/

CREATE PUBLIC SYNONYM SS_PORTADOR FOR INTEGRACAO.SS_PORTADOR
/

GRANT SELECT, INSERT, UPDATE ON SS_LOTE_PORTADOR TO SISCOB_DES
/

GRANT SELECT, INSERT, UPDATE ON SS_PORTADOR TO SISCOB_DES
/
