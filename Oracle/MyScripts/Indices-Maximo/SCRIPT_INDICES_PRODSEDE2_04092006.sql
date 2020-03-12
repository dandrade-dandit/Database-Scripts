--------------------------------------------------------------------------------------------------------------------
-- CRIAÇÃO DO ÍNDICE: IFRBDE.ACM_PK
--------------------------------------------------------------------------------------------------------------------
CREATE UNIQUE INDEX IFRBDE.ACM_PK ON IFRBDE.AUX_CRONOGRAMA_MEDICAO (
SEQ_CARENCIA ASC,
SEQ_CONTRATO ASC,
ANO_CRONOGRAMA ASC,
TIP_CRONOGRAMA ASC,
COD_RECURSO ASC)
PCTFREE    10
INITRANS   2
MAXTRANS   255
TABLESPACE SYSTEM
STORAGE   (
            INITIAL    65536
            MINEXTENTS 1
            MAXEXTENTS 2147483645
           )
/

--------------------------------------------------------------------------------------------------------------------
-- CRIAÇÃO DO ÍNDICE: IFRBDE.CAD_ACESSO_DEPENDENCIA_PK
--------------------------------------------------------------------------------------------------------------------
CREATE UNIQUE INDEX IFRBDE.CAD_ACESSO_DEPENDENCIA_PK ON IFRBDE.CAD_ACESSO_DEPENDENCIA (
NOM_USERNAME ASC,
COD_DEPENDENCIA_ACESSO ASC)
PCTFREE    10
INITRANS   2
MAXTRANS   255
TABLESPACE TSD_MAXIMO
STORAGE   (
            INITIAL    65536
            MINEXTENTS 1
            MAXEXTENTS 2147483645
           )
/

--------------------------------------------------------------------------------------------------------------------
-- CRIAÇÃO DO ÍNDICE: IFRBDE.CAD_ACESSO_PK
--------------------------------------------------------------------------------------------------------------------
CREATE UNIQUE INDEX IFRBDE.CAD_ACESSO_PK ON IFRBDE.CAD_ACESSO (
NOM_USERNAME ASC)
PCTFREE    10
INITRANS   2
MAXTRANS   255
TABLESPACE TSD_MAXIMO
STORAGE   (
            INITIAL    65536
            MINEXTENTS 1
            MAXEXTENTS 2147483645
           )
/

--------------------------------------------------------------------------------------------------------------------
-- CRIAÇÃO DO ÍNDICE: IFRBDE.CAD_EVENTOS_LICITACAO_PK
--------------------------------------------------------------------------------------------------------------------
CREATE UNIQUE INDEX IFRBDE.CAD_EVENTOS_LICITACAO_PK ON IFRBDE.CAD_EVENTOS_LICITACAO (
NUM_SEQ_EVENTO_LICITACAO ASC)
PCTFREE    10
INITRANS   2
MAXTRANS   255
TABLESPACE TSD_MAXIMO
STORAGE   (
            INITIAL    65536
            MINEXTENTS 1
            MAXEXTENTS 2147483645
           )
/

--------------------------------------------------------------------------------------------------------------------
-- CRIAÇÃO DO ÍNDICE: IFRBDE.CAD_FISCAIS_CONTRATO_PK
--------------------------------------------------------------------------------------------------------------------
CREATE UNIQUE INDEX IFRBDE.CAD_FISCAIS_CONTRATO_PK ON IFRBDE.CAD_FISCAIS_CONTRATO (
NUM_SEQ_PESSOAL_FIS ASC,
NUM_SEQ_CONTRATO_FIS ASC)
PCTFREE    10
INITRANS   2
MAXTRANS   255
TABLESPACE TSD_MAXIMO
STORAGE   (
            INITIAL    65536
            MINEXTENTS 1
            MAXEXTENTS 2147483645
           )
/

--------------------------------------------------------------------------------------------------------------------
-- CRIAÇÃO DO ÍNDICE: IFRBDE.CAD_LICITACAO_CARENCIA_PK
--------------------------------------------------------------------------------------------------------------------
CREATE UNIQUE INDEX IFRBDE.CAD_LICITACAO_CARENCIA_PK ON IFRBDE.CAD_LICITACAO_CARENCIA (
NUM_SEQ_LICITACAO ASC)
PCTFREE    10
INITRANS   2
MAXTRANS   255
TABLESPACE TSD_MAXIMO
STORAGE   (
            INITIAL    65536
            MINEXTENTS 1
            MAXEXTENTS 2147483645
           )
/

--------------------------------------------------------------------------------------------------------------------
-- CRIAÇÃO DO ÍNDICE: IFRBDE.CAD_LICITACAO_CARENCIA_01_IX
--------------------------------------------------------------------------------------------------------------------
CREATE  INDEX IFRBDE.CAD_LICITACAO_CARENCIA_01_IX ON IFRBDE.CAD_LICITACAO_CARENCIA (
NUM_PROCESSO_LICITACAO ASC,
DAT_DOCUMENTO ASC)
PCTFREE    10
INITRANS   2
MAXTRANS   255
TABLESPACE TSD_MAXIMO
STORAGE   (
            INITIAL    65536
            MINEXTENTS 1
            MAXEXTENTS 2147483645
           )
/

--------------------------------------------------------------------------------------------------------------------
-- CRIAÇÃO DO ÍNDICE: IFRBDE.CAD_PAGAMENTO_CONTRATO_PK
--------------------------------------------------------------------------------------------------------------------
CREATE UNIQUE INDEX IFRBDE.CAD_PAGAMENTO_CONTRATO_PK ON IFRBDE.CAD_PAGAMENTO_CONTRATO (
NUM_SEQ_PAG_CONTRATO ASC)
PCTFREE    10
INITRANS   2
MAXTRANS   255
TABLESPACE TSD_MAXIMO
STORAGE   (
            INITIAL    65536
            MINEXTENTS 1
            MAXEXTENTS 2147483645
           )
/

--------------------------------------------------------------------------------------------------------------------
-- CRIAÇÃO DO ÍNDICE: IFRBDE.CAD_PARTICIPANTES_CONTRATO_PK
--------------------------------------------------------------------------------------------------------------------
CREATE UNIQUE INDEX IFRBDE.CAD_PARTICIPANTES_CONTRATO_PK ON IFRBDE.CAD_PARTICIPANTES_CONTRATO (
NUM_SEQ_CONTRATO_PART ASC,
NUM_FIR_COD ASC)
PCTFREE    10
INITRANS   2
MAXTRANS   255
TABLESPACE TSD_MAXIMO
STORAGE   (
            INITIAL    65536
            MINEXTENTS 1
            MAXEXTENTS 2147483645
           )
/

--------------------------------------------------------------------------------------------------------------------
-- CRIAÇÃO DO ÍNDICE: IFRBDE.CAD_RECURSOS_SOLIC_PK
--------------------------------------------------------------------------------------------------------------------
CREATE UNIQUE INDEX IFRBDE.CAD_RECURSOS_SOLIC_PK ON IFRBDE.CAD_RECURSOS_SOLICITADOS (
NUM_SEQ_CARENCIA ASC,
NUM_ANO ASC)
PCTFREE    10
INITRANS   2
MAXTRANS   255
TABLESPACE TSD_MAXIMO
STORAGE   (
            INITIAL    65536
            MINEXTENTS 1
            MAXEXTENTS 2147483645
           )
/

--------------------------------------------------------------------------------------------------------------------
-- CRIAÇÃO DO ÍNDICE: IFRBDE.CAD_RESPONSAVEIS_PK
--------------------------------------------------------------------------------------------------------------------
CREATE UNIQUE INDEX IFRBDE.CAD_RESPONSAVEIS_PK ON IFRBDE.CAD_RESPONSAVEIS (
NUM_SEQ_PESSOAL ASC)
PCTFREE    10
INITRANS   2
MAXTRANS   255
TABLESPACE TSD_MAXIMO
STORAGE   (
            INITIAL    65536
            MINEXTENTS 1
            MAXEXTENTS 2147483645
           )
/

--------------------------------------------------------------------------------------------------------------------
-- CRIAÇÃO DO ÍNDICE: IFRBDE.CAD_RESPONSAVEIS_01_IX
--------------------------------------------------------------------------------------------------------------------
CREATE  INDEX IFRBDE.CAD_RESPONSAVEIS_01_IX ON IFRBDE.CAD_RESPONSAVEIS (
NUM_CPF ASC)
PCTFREE    10
INITRANS   2
MAXTRANS   255
TABLESPACE TSD_MAXIMO
STORAGE   (
            INITIAL    65536
            MINEXTENTS 1
            MAXEXTENTS 2147483645
           )
/

--------------------------------------------------------------------------------------------------------------------
-- CRIAÇÃO DO ÍNDICE: IFRBDE.CAD_RESUMO_CRONOGRAMA_PK
--------------------------------------------------------------------------------------------------------------------
CREATE UNIQUE INDEX IFRBDE.CAD_RESUMO_CRONOGRAMA_PK ON IFRBDE.CAD_RESUMO_CRONOGRAMA (
NUM_SEQ_RESUMO_CRONO ASC)
PCTFREE    10
INITRANS   2
MAXTRANS   255
TABLESPACE TSI_MAXIMO
STORAGE   (
            INITIAL    65536
            MINEXTENTS 1
            MAXEXTENTS 2147483645
           )
/

--------------------------------------------------------------------------------------------------------------------
-- CRIAÇÃO DO ÍNDICE: IFRBDE.CAD_RESUMO_PAGAMENTO_PK
--------------------------------------------------------------------------------------------------------------------
CREATE UNIQUE INDEX IFRBDE.CAD_RESUMO_PAGAMENTO_PK ON IFRBDE.CAD_RESUMO_PAGAMENTO (
NUM_SEQ_RESUMO_PAG ASC)
PCTFREE    10
INITRANS   2
MAXTRANS   255
TABLESPACE TSD_MAXIMO
STORAGE   (
            INITIAL    65536
            MINEXTENTS 1
            MAXEXTENTS 2147483645
           )
/

--------------------------------------------------------------------------------------------------------------------
-- CRIAÇÃO DO ÍNDICE: IFRBDE.CAD_RESUMO_VALORES_PK
--------------------------------------------------------------------------------------------------------------------
CREATE UNIQUE INDEX IFRBDE.CAD_RESUMO_VALORES_PK ON IFRBDE.CAD_RESUMO_VALORES (
NUM_SEQ_RESUMO ASC)
PCTFREE    10
INITRANS   2
MAXTRANS   255
TABLESPACE TSD_MAXIMO
STORAGE   (
            INITIAL    65536
            MINEXTENTS 1
            MAXEXTENTS 2147483645
           )
/

--------------------------------------------------------------------------------------------------------------------
-- CRIAÇÃO DO ÍNDICE: IFRBDE.CAD_TERMO_ADIT_CONTRATO_PK
--------------------------------------------------------------------------------------------------------------------
CREATE UNIQUE INDEX IFRBDE.CAD_TERMO_ADIT_CONTRATO_PK ON IFRBDE.CAD_TERMO_ADITIVO_CONTRATO (
NUM_SEQ_TERMO_ADITIVO ASC)
PCTFREE    10
INITRANS   2
MAXTRANS   255
TABLESPACE TSD_MAXIMO
STORAGE   (
            INITIAL    65536
            MINEXTENTS 1
            MAXEXTENTS 2147483645
           )
/

--------------------------------------------------------------------------------------------------------------------
-- CRIAÇÃO DO ÍNDICE: IFRBDE.CAD_TERMO_ADIT_CONT_01_IX
--------------------------------------------------------------------------------------------------------------------
CREATE UNIQUE INDEX IFRBDE.CAD_TERMO_ADIT_CONT_01_IX ON IFRBDE.CAD_TERMO_ADITIVO_CONTRATO (
NUM_SEQ_CONTRATO_ORIGEM ASC,
NUM_TERMO_ADITIVO ASC)
PCTFREE    10
INITRANS   2
MAXTRANS   255
TABLESPACE TSD_MAXIMO
STORAGE   (
            INITIAL    65536
            MINEXTENTS 1
            MAXEXTENTS 2147483645
           )
/

--------------------------------------------------------------------------------------------------------------------
-- CRIAÇÃO DO ÍNDICE: IFRBDE.CLI_PK
--------------------------------------------------------------------------------------------------------------------
CREATE UNIQUE INDEX IFRBDE.CLI_PK ON IFRBDE.CAD_CLIENTE_ENGENHARIA (
SEQ_CLIENTE ASC)
PCTFREE    10
INITRANS   2
MAXTRANS   255
TABLESPACE TSD_MAXIMO
STORAGE   (
            INITIAL    65536
            MINEXTENTS 1
            MAXEXTENTS 2147483645
           )
/

--------------------------------------------------------------------------------------------------------------------
-- CRIAÇÃO DO ÍNDICE: IFRBDE.CLR_PK
--------------------------------------------------------------------------------------------------------------------
CREATE UNIQUE INDEX IFRBDE.CLR_PK ON IFRBDE.CAD_LIBERACAO_SP_RECURSO (
SEQ_AUX_LIBERACAO ASC,
COD_DETALHAMENTO_RECURSO ASC)
PCTFREE    10
INITRANS   2
MAXTRANS   255
TABLESPACE SYSTEM
STORAGE   (
            INITIAL    65536
            MINEXTENTS 1
            MAXEXTENTS 2147483645
           )
/

--------------------------------------------------------------------------------------------------------------------
-- CRIAÇÃO DO ÍNDICE: IFRBDE.CSU_PK
--------------------------------------------------------------------------------------------------------------------
CREATE UNIQUE INDEX IFRBDE.CSU_PK ON IFRBDE.TAB_CONTRATO_SUBTIPO (
TIP_CONTRATO ASC,
TIP_SUB_CONTRATO ASC)
PCTFREE    10
INITRANS   2
MAXTRANS   255
TABLESPACE TSD_MAXIMO
STORAGE   (
            INITIAL    65536
            MINEXTENTS 1
            MAXEXTENTS 2147483645
           )
/

--------------------------------------------------------------------------------------------------------------------
-- CRIAÇÃO DO ÍNDICE: IFRBDE.DCL_PK
--------------------------------------------------------------------------------------------------------------------
CREATE UNIQUE INDEX IFRBDE.DCL_PK ON IFRBDE.CAD_DETALHE_CLIENTE (
SEQ_DETALHE ASC)
PCTFREE    10
INITRANS   2
MAXTRANS   255
TABLESPACE TSD_MAXIMO
STORAGE   (
            INITIAL    65536
            MINEXTENTS 1
            MAXEXTENTS 2147483645
           )
/

--------------------------------------------------------------------------------------------------------------------
-- CRIAÇÃO DO ÍNDICE: IFRBDE.DEPENDENCIA_PAI_PK
--------------------------------------------------------------------------------------------------------------------
CREATE UNIQUE INDEX IFRBDE.DEPENDENCIA_PAI_PK ON IFRBDE.TAB_DEPENDENCIA_PAI (
DPP_COD ASC)
PCTFREE    10
INITRANS   2
MAXTRANS   255
TABLESPACE TSD_MAXIMO
STORAGE   (
            INITIAL    65536
            MINEXTENTS 1
            MAXEXTENTS 2147483645
           )
/

--------------------------------------------------------------------------------------------------------------------
-- CRIAÇÃO DO ÍNDICE: IFRBDE.DESPACHOS_PK
--------------------------------------------------------------------------------------------------------------------
CREATE UNIQUE INDEX IFRBDE.DESPACHOS_PK ON IFRBDE.DESPACHOS (
DES_OBR_SEQUENCIAL ASC,
DES_CODIGO ASC)
PCTFREE    10
INITRANS   2
MAXTRANS   255
TABLESPACE TSD_MAXIMO
STORAGE   (
            INITIAL    65536
            MINEXTENTS 1
            MAXEXTENTS 2147483645
           )
/

--------------------------------------------------------------------------------------------------------------------
-- CRIAÇÃO DO ÍNDICE: IFRBDE.DOTACAO_PK
--------------------------------------------------------------------------------------------------------------------
CREATE UNIQUE INDEX IFRBDE.DOTACAO_PK ON IFRBDE.TAB_DOTACAO (
DOT_ANO ASC,
DOT_RTI_COD ASC)
PCTFREE    10
INITRANS   2
MAXTRANS   255
TABLESPACE TSD_MAXIMO
STORAGE   (
            INITIAL    65536
            MINEXTENTS 1
            MAXEXTENTS 2147483645
           )
/

--------------------------------------------------------------------------------------------------------------------
-- CRIAÇÃO DO ÍNDICE: IFRBDE.EIXO_PK
--------------------------------------------------------------------------------------------------------------------
CREATE UNIQUE INDEX IFRBDE.EIXO_PK ON IFRBDE.TAB_EIXO (
EIX_COD ASC)
PCTFREE    10
INITRANS   2
MAXTRANS   255
TABLESPACE TSD_MAXIMO
STORAGE   (
            INITIAL    65536
            MINEXTENTS 1
            MAXEXTENTS 2147483645
           )
/

--------------------------------------------------------------------------------------------------------------------
-- CRIAÇÃO DO ÍNDICE: IFRBDE.ETAPA_PK
--------------------------------------------------------------------------------------------------------------------
CREATE UNIQUE INDEX IFRBDE.ETAPA_PK ON IFRBDE.TAB_ETAPA_OBRA (
ETO_COD ASC)
PCTFREE    10
INITRANS   2
MAXTRANS   255
TABLESPACE TSD_MAXIMO
STORAGE   (
            INITIAL    65536
            MINEXTENTS 1
            MAXEXTENTS 2147483645
           )
/

--------------------------------------------------------------------------------------------------------------------
-- CRIAÇÃO DO ÍNDICE: IFRBDE.FOTOS_PK
--------------------------------------------------------------------------------------------------------------------
CREATE UNIQUE INDEX IFRBDE.FOTOS_PK ON IFRBDE.FOTOS (
FOTO_OBR_SEQUENCIAL ASC,
FOTO_NUMERO ASC)
PCTFREE    10
INITRANS   2
MAXTRANS   255
TABLESPACE TSD_MAXIMO
STORAGE   (
            INITIAL    65536
            MINEXTENTS 1
            MAXEXTENTS 2147483645
           )
/

--------------------------------------------------------------------------------------------------------------------
-- CRIAÇÃO DO ÍNDICE: IFRBDE.HST_JUSTIFICATIVA_SP_PK
--------------------------------------------------------------------------------------------------------------------
CREATE UNIQUE INDEX IFRBDE.HST_JUSTIFICATIVA_SP_PK ON IFRBDE.HST_JUSTIFICATIVA_SP (
NUM_SEQ_JUSTIFICATIVA ASC)
PCTFREE    10
INITRANS   2
MAXTRANS   255
TABLESPACE TSD_MAXIMO
STORAGE   (
            INITIAL    65536
            MINEXTENTS 1
            MAXEXTENTS 2147483645
           )
/

--------------------------------------------------------------------------------------------------------------------
-- CRIAÇÃO DO ÍNDICE: IFRBDE.HST_PAG_CRONOGRAMA_PK
--------------------------------------------------------------------------------------------------------------------
CREATE UNIQUE INDEX IFRBDE.HST_PAG_CRONOGRAMA_PK ON IFRBDE.HST_PAGAMENTO_CRONOGRAMA (
NUM_SEQ_CRONOGRAMA_HST ASC,
NUM_SEQ_PAG_CONTRATO_HST ASC,
TIP_HISTORICO_PAGAMENTO ASC)
PCTFREE    10
INITRANS   2
MAXTRANS   255
TABLESPACE TSD_MAXIMO
STORAGE   (
            INITIAL    65536
            MINEXTENTS 1
            MAXEXTENTS 2147483645
           )
/

--------------------------------------------------------------------------------------------------------------------
-- CRIAÇÃO DO ÍNDICE: IFRBDE.HST_PAG_CRONOGRAMA_01_IX
--------------------------------------------------------------------------------------------------------------------
CREATE  INDEX IFRBDE.HST_PAG_CRONOGRAMA_01_IX ON IFRBDE.HST_PAGAMENTO_CRONOGRAMA (
NUM_SEQ_PAG_CONTRATO_HST ASC,
COD_RECURSO_HST ASC,
DAT_EXECUCAO_HST ASC)
PCTFREE    10
INITRANS   2
MAXTRANS   255
TABLESPACE TSD_MAXIMO
STORAGE   (
            INITIAL    65536
            MINEXTENTS 1
            MAXEXTENTS 2147483645
           )
/

--------------------------------------------------------------------------------------------------------------------
-- CRIAÇÃO DO ÍNDICE: IFRBDE.LRA_PK
--------------------------------------------------------------------------------------------------------------------
CREATE UNIQUE INDEX IFRBDE.LRA_PK ON IFRBDE.CAD_LIMITE_RECURSO_ANO (
ANO_RECURSO ASC,
MES_RECURSO ASC,
COD_RECURSO ASC)
PCTFREE    10
INITRANS   2
MAXTRANS   255
TABLESPACE TSD_MAXIMO
STORAGE   (
            INITIAL    65536
            MINEXTENTS 1
            MAXEXTENTS 2147483645
           )
/

--------------------------------------------------------------------------------------------------------------------
-- CRIAÇÃO DO ÍNDICE: IFRBDE.OBRAS_USUARIOS_PK
--------------------------------------------------------------------------------------------------------------------
CREATE UNIQUE INDEX IFRBDE.OBRAS_USUARIOS_PK ON IFRBDE.OBRAS_USUARIOS (
OBUS_USU_CPF ASC,
OBUS_OBR_SEQUENCIAL ASC)
PCTFREE    10
INITRANS   2
MAXTRANS   255
TABLESPACE TSD_MAXIMO
STORAGE   (
            INITIAL    65536
            MINEXTENTS 1
            MAXEXTENTS 2147483645
           )
/

--------------------------------------------------------------------------------------------------------------------
-- CRIAÇÃO DO ÍNDICE: IFRBDE.PK_TAB_MESES_ANO
--------------------------------------------------------------------------------------------------------------------
CREATE UNIQUE INDEX IFRBDE.PK_TAB_MESES_ANO ON IFRBDE.TAB_MESES_ANO (
NUM_ANO ASC,
NUM_MES ASC)
PCTFREE    10
INITRANS   2
MAXTRANS   255
TABLESPACE TSD_MAXIMO
STORAGE   (
            INITIAL    65536
            MINEXTENTS 1
            MAXEXTENTS 2147483645
           )
/

--------------------------------------------------------------------------------------------------------------------
-- CRIAÇÃO DO ÍNDICE: IFRBDE.PRC_PK
--------------------------------------------------------------------------------------------------------------------
CREATE UNIQUE INDEX IFRBDE.PRC_PK ON IFRBDE.CAD_PRE_COMPROMISSO (
SEQ_PRE_COMPROMISSO ASC)
PCTFREE    10
INITRANS   2
MAXTRANS   255
TABLESPACE TSD_MAXIMO
STORAGE   (
            INITIAL    65536
            MINEXTENTS 1
            MAXEXTENTS 2147483645
           )
/

--------------------------------------------------------------------------------------------------------------------
-- CRIAÇÃO DO ÍNDICE: IFRBDE.RECURSO_ITEM_PK
--------------------------------------------------------------------------------------------------------------------
CREATE UNIQUE INDEX IFRBDE.RECURSO_ITEM_PK ON IFRBDE.TAB_TIPO_RECURSO_ITEM (
RTI_COD ASC)
PCTFREE    10
INITRANS   2
MAXTRANS   255
TABLESPACE TSD_MAXIMO
STORAGE   (
            INITIAL    65536
            MINEXTENTS 1
            MAXEXTENTS 2147483645
           )
/

--------------------------------------------------------------------------------------------------------------------
-- CRIAÇÃO DO ÍNDICE: IFRBDE.TAB_ACESSO_01_IX
--------------------------------------------------------------------------------------------------------------------
CREATE  INDEX IFRBDE.TAB_ACESSO_01_IX ON IFRBDE.TAB_ACESSO (
ACS_SESSIONID ASC)
PCTFREE    10
INITRANS   2
MAXTRANS   255
TABLESPACE TSD_MAXIMO
STORAGE   (
            INITIAL    65536
            MINEXTENTS 1
            MAXEXTENTS 2147483645
           )
/

--------------------------------------------------------------------------------------------------------------------
-- CRIAÇÃO DO ÍNDICE: IFRBDE.TAB_ACESSO_02_IX
--------------------------------------------------------------------------------------------------------------------
CREATE UNIQUE INDEX IFRBDE.TAB_ACESSO_02_IX ON IFRBDE.TAB_ACESSO (
ACS_COD ASC)
PCTFREE    10
INITRANS   2
MAXTRANS   255
TABLESPACE TSD_MAXIMO
STORAGE   (
            INITIAL    65536
            MINEXTENTS 1
            MAXEXTENTS 2147483645
           )
/

--------------------------------------------------------------------------------------------------------------------
-- CRIAÇÃO DO ÍNDICE: IFRBDE.TAB_AREA_ENVOLVIDA_PK
--------------------------------------------------------------------------------------------------------------------
CREATE UNIQUE INDEX IFRBDE.TAB_AREA_ENVOLVIDA_PK ON IFRBDE.TAB_AREA_ENVOLVIDA (
AEN_SUBCOD ASC)
PCTFREE    10
INITRANS   2
MAXTRANS   255
TABLESPACE TSD_MAXIMO
STORAGE   (
            INITIAL    65536
            MINEXTENTS 1
            MAXEXTENTS 2147483645
           )
/

--------------------------------------------------------------------------------------------------------------------
-- CRIAÇÃO DO ÍNDICE: IFRBDE.TAB_AREA_ENVOLVIDA_01_IX
--------------------------------------------------------------------------------------------------------------------
CREATE  INDEX IFRBDE.TAB_AREA_ENVOLVIDA_01_IX ON IFRBDE.TAB_AREA_ENVOLVIDA (
AEN_COD ASC)
PCTFREE    10
INITRANS   2
MAXTRANS   255
TABLESPACE TSD_MAXIMO
STORAGE   (
            INITIAL    65536
            MINEXTENTS 1
            MAXEXTENTS 2147483645
           )
/

--------------------------------------------------------------------------------------------------------------------
-- CRIAÇÃO DO ÍNDICE: IFRBDE.TAB_AREA_PK
--------------------------------------------------------------------------------------------------------------------
CREATE UNIQUE INDEX IFRBDE.TAB_AREA_PK ON IFRBDE.TAB_AREA (
ARE_COD ASC)
PCTFREE    10
INITRANS   2
MAXTRANS   255
TABLESPACE TSD_MAXIMO
STORAGE   (
            INITIAL    65536
            MINEXTENTS 1
            MAXEXTENTS 2147483645
           )
/

--------------------------------------------------------------------------------------------------------------------
-- CRIAÇÃO DO ÍNDICE: IFRBDE.TAB_CARENCIA_PK
--------------------------------------------------------------------------------------------------------------------
CREATE UNIQUE INDEX IFRBDE.TAB_CARENCIA_PK ON IFRBDE.TAB_CARENCIA (
CRE_COD ASC)
PCTFREE    10
INITRANS   2
MAXTRANS   255
TABLESPACE TSD_MAXIMO
STORAGE   (
            INITIAL    65536
            MINEXTENTS 1
            MAXEXTENTS 2147483645
           )
/

--------------------------------------------------------------------------------------------------------------------
-- CRIAÇÃO DO ÍNDICE: IFRBDE.TAB_CARENCIA_02_IX
--------------------------------------------------------------------------------------------------------------------
CREATE  INDEX IFRBDE.TAB_CARENCIA_02_IX ON IFRBDE.TAB_CARENCIA (
CRE_DEP_COD ASC)
PCTFREE    10
INITRANS   2
MAXTRANS   255
TABLESPACE TSD_MAXIMO
STORAGE   (
            INITIAL    65536
            MINEXTENTS 1
            MAXEXTENTS 2147483645
           )
/

--------------------------------------------------------------------------------------------------------------------
-- CRIAÇÃO DO ÍNDICE: IFRBDE.TAB_CONTA_BANCARIA_PK
--------------------------------------------------------------------------------------------------------------------
CREATE UNIQUE INDEX IFRBDE.TAB_CONTA_BANCARIA_PK ON IFRBDE.TAB_CONTA_BANCARIA (
NUM_SEQ_CONTA_BANCARIA ASC)
PCTFREE    10
INITRANS   2
MAXTRANS   255
TABLESPACE TSD_MAXIMO
STORAGE   (
            INITIAL    65536
            MINEXTENTS 1
            MAXEXTENTS 2147483645
           )
/

--------------------------------------------------------------------------------------------------------------------
-- CRIAÇÃO DO ÍNDICE: IFRBDE.TAB_CONT_CRONO_PAGAMENTO_PK
--------------------------------------------------------------------------------------------------------------------
CREATE UNIQUE INDEX IFRBDE.TAB_CONT_CRONO_PAGAMENTO_PK ON IFRBDE.TAB_CONT_CRONO_PAGAMENTO (
NUM_SEQ_CRONOGRAMA ASC)
PCTFREE    10
INITRANS   2
MAXTRANS   255
TABLESPACE TSD_MAXIMO
STORAGE   (
            INITIAL    65536
            MINEXTENTS 1
            MAXEXTENTS 2147483645
           )
/

--------------------------------------------------------------------------------------------------------------------
-- CRIAÇÃO DO ÍNDICE: IFRBDE.TAB_CONTRATO_PK
--------------------------------------------------------------------------------------------------------------------
CREATE UNIQUE INDEX IFRBDE.TAB_CONTRATO_PK ON IFRBDE.TAB_CONTRATO (
NUM_SEQ_CONTRATO ASC)
PCTFREE    10
INITRANS   2
MAXTRANS   255
TABLESPACE TSD_MAXIMO
STORAGE   (
            INITIAL    65536
            MINEXTENTS 1
            MAXEXTENTS 2147483645
           )
/

--------------------------------------------------------------------------------------------------------------------
-- CRIAÇÃO DO ÍNDICE: IFRBDE.TAB_CONTRATO_REAJUSTE_PK
--------------------------------------------------------------------------------------------------------------------
CREATE UNIQUE INDEX IFRBDE.TAB_CONTRATO_REAJUSTE_PK ON IFRBDE.TAB_CONTRATO_REAJUSTE (
CRJ_CNT_CRE_COD ASC,
CRJ_CNT_COD ASC,
CRJ_PGOSE ASC,
CRJ_PERIODO ASC)
PCTFREE    10
INITRANS   2
MAXTRANS   255
TABLESPACE TSD_MAXIMO
STORAGE   (
            INITIAL    65536
            MINEXTENTS 1
            MAXEXTENTS 2147483645
           )
/

--------------------------------------------------------------------------------------------------------------------
-- CRIAÇÃO DO ÍNDICE: IFRBDE.TAB_CONTRATO_REAJUSTE_01_IX
--------------------------------------------------------------------------------------------------------------------
CREATE  INDEX IFRBDE.TAB_CONTRATO_REAJUSTE_01_IX ON IFRBDE.TAB_CONTRATO_REAJUSTE (
CRJ_CNT_CRE_COD ASC,
CRJ_CNT_COD ASC)
PCTFREE    10
INITRANS   2
MAXTRANS   255
TABLESPACE TSD_MAXIMO
STORAGE   (
            INITIAL    65536
            MINEXTENTS 1
            MAXEXTENTS 2147483645
           )
/

--------------------------------------------------------------------------------------------------------------------
-- CRIAÇÃO DO ÍNDICE: IFRBDE.TAB_CONTRATO_01_IX
--------------------------------------------------------------------------------------------------------------------
CREATE UNIQUE INDEX IFRBDE.TAB_CONTRATO_01_IX ON IFRBDE.TAB_CONTRATO (
CNT_COD ASC)
PCTFREE    10
INITRANS   2
MAXTRANS   255
TABLESPACE TSD_MAXIMO
STORAGE   (
            INITIAL    65536
            MINEXTENTS 1
            MAXEXTENTS 2147483645
           )
/

--------------------------------------------------------------------------------------------------------------------
-- CRIAÇÃO DO ÍNDICE: IFRBDE.TAB_CONTRATO_02_IX
--------------------------------------------------------------------------------------------------------------------
CREATE UNIQUE INDEX IFRBDE.TAB_CONTRATO_02_IX ON IFRBDE.TAB_CONTRATO (
CNT_CRE_COD ASC,
CNT_COD ASC)
PCTFREE    10
INITRANS   2
MAXTRANS   255
TABLESPACE TSD_MAXIMO
STORAGE   (
            INITIAL    65536
            MINEXTENTS 1
            MAXEXTENTS 2147483645
           )
/

--------------------------------------------------------------------------------------------------------------------
-- CRIAÇÃO DO ÍNDICE: IFRBDE.TAB_CONT_TERMO_ADITIVO_PK
--------------------------------------------------------------------------------------------------------------------
CREATE UNIQUE INDEX IFRBDE.TAB_CONT_TERMO_ADITIVO_PK ON IFRBDE.TAB_CONT_TERMO_ADITIVO (
NUM_SEQ_RESUMO_TA ASC,
CTA_CNT_CRE_COD ASC,
CTA_CNT_COD ASC,
CTA_PERIODO ASC,
CTA_NUM ASC)
PCTFREE    10
INITRANS   2
MAXTRANS   255
TABLESPACE TSD_MAXIMO
STORAGE   (
            INITIAL    65536
            MINEXTENTS 1
            MAXEXTENTS 2147483645
           )
/

--------------------------------------------------------------------------------------------------------------------
-- CRIAÇÃO DO ÍNDICE: IFRBDE.TAB_DEPENDENCIA_PAI_01_UK
--------------------------------------------------------------------------------------------------------------------
CREATE UNIQUE INDEX IFRBDE.TAB_DEPENDENCIA_PAI_01_UK ON IFRBDE.TAB_DEPENDENCIA_PAI (
DPP_SIGLA ASC)
PCTFREE    10
INITRANS   2
MAXTRANS   255
TABLESPACE TSD_MAXIMO
STORAGE   (
            INITIAL    65536
            MINEXTENTS 1
            MAXEXTENTS 2147483645
           )
/

--------------------------------------------------------------------------------------------------------------------
-- CRIAÇÃO DO ÍNDICE: IFRBDE.TAB_DEPENDENCIA_PK
--------------------------------------------------------------------------------------------------------------------
CREATE UNIQUE INDEX IFRBDE.TAB_DEPENDENCIA_PK ON IFRBDE.TAB_DEPENDENCIA (
DEP_COD ASC)
PCTFREE    10
INITRANS   2
MAXTRANS   255
TABLESPACE TSD_MAXIMO
STORAGE   (
            INITIAL    65536
            MINEXTENTS 1
            MAXEXTENTS 2147483645
           )
/

--------------------------------------------------------------------------------------------------------------------
-- CRIAÇÃO DO ÍNDICE: IFRBDE.TAB_DEPENDENCIA_01_IX
--------------------------------------------------------------------------------------------------------------------
CREATE  INDEX IFRBDE.TAB_DEPENDENCIA_01_IX ON IFRBDE.TAB_DEPENDENCIA (
DEP_SIGLA ASC)
PCTFREE    10
INITRANS   2
MAXTRANS   255
TABLESPACE TSD_MAXIMO
STORAGE   (
            INITIAL    65536
            MINEXTENTS 1
            MAXEXTENTS 2147483645
           )
/

--------------------------------------------------------------------------------------------------------------------
-- CRIAÇÃO DO ÍNDICE: IFRBDE.TAB_DEPENDENCIA_02_IX
--------------------------------------------------------------------------------------------------------------------
CREATE  INDEX IFRBDE.TAB_DEPENDENCIA_02_IX ON IFRBDE.TAB_DEPENDENCIA (
DEP_DPP_COD ASC)
PCTFREE    10
INITRANS   2
MAXTRANS   255
TABLESPACE TSD_MAXIMO
STORAGE   (
            INITIAL    65536
            MINEXTENTS 1
            MAXEXTENTS 2147483645
           )
/

--------------------------------------------------------------------------------------------------------------------
-- CRIAÇÃO DO ÍNDICE: IFRBDE.TAB_FIRMA_PK
--------------------------------------------------------------------------------------------------------------------
CREATE UNIQUE INDEX IFRBDE.TAB_FIRMA_PK ON IFRBDE.TAB_FIRMA (
FIR_COD ASC)
PCTFREE    10
INITRANS   2
MAXTRANS   255
TABLESPACE TSD_MAXIMO
STORAGE   (
            INITIAL    65536
            MINEXTENTS 1
            MAXEXTENTS 2147483645
           )
/

--------------------------------------------------------------------------------------------------------------------
-- CRIAÇÃO DO ÍNDICE: IFRBDE.TAB_FIRMA_UK
--------------------------------------------------------------------------------------------------------------------
CREATE UNIQUE INDEX IFRBDE.TAB_FIRMA_UK ON IFRBDE.TAB_FIRMA (
TIP_CNPJ_CPF ASC,
FIR_CNPJ ASC)
PCTFREE    10
INITRANS   2
MAXTRANS   255
TABLESPACE TSD_MAXIMO
STORAGE   (
            INITIAL    65536
            MINEXTENTS 1
            MAXEXTENTS 2147483645
           )
/

--------------------------------------------------------------------------------------------------------------------
-- CRIAÇÃO DO ÍNDICE: IFRBDE.TAB_INDICE_FIL_PK
--------------------------------------------------------------------------------------------------------------------
CREATE UNIQUE INDEX IFRBDE.TAB_INDICE_FIL_PK ON IFRBDE.TAB_INDICE_FIL (
ICI_ICE_COD ASC,
ICI_PERIODO ASC)
PCTFREE    10
INITRANS   2
MAXTRANS   255
TABLESPACE TSD_MAXIMO
STORAGE   (
            INITIAL    65536
            MINEXTENTS 1
            MAXEXTENTS 2147483645
           )
/

--------------------------------------------------------------------------------------------------------------------
-- CRIAÇÃO DO ÍNDICE: IFRBDE.TAB_INDICE_PK
--------------------------------------------------------------------------------------------------------------------
CREATE UNIQUE INDEX IFRBDE.TAB_INDICE_PK ON IFRBDE.TAB_INDICE (
ICE_COD ASC)
PCTFREE    10
INITRANS   2
MAXTRANS   255
TABLESPACE TSD_MAXIMO
STORAGE   (
            INITIAL    65536
            MINEXTENTS 1
            MAXEXTENTS 2147483645
           )
/

--------------------------------------------------------------------------------------------------------------------
-- CRIAÇÃO DO ÍNDICE: IFRBDE.TAB_INDICES_PAI_01_IX
--------------------------------------------------------------------------------------------------------------------
CREATE  INDEX IFRBDE.TAB_INDICES_PAI_01_IX ON IFRBDE.TAB_INDICE_FIL (
ICI_PERIODO ASC)
PCTFREE    10
INITRANS   2
MAXTRANS   255
TABLESPACE TSD_MAXIMO
STORAGE   (
            INITIAL    65536
            MINEXTENTS 1
            MAXEXTENTS 2147483645
           )
/

--------------------------------------------------------------------------------------------------------------------
-- CRIAÇÃO DO ÍNDICE: IFRBDE.TAB_INDICES_PAI_02_IX
--------------------------------------------------------------------------------------------------------------------
CREATE  INDEX IFRBDE.TAB_INDICES_PAI_02_IX ON IFRBDE.TAB_INDICE_FIL (
ICI_ICE_COD ASC)
PCTFREE    10
INITRANS   2
MAXTRANS   255
TABLESPACE TSD_MAXIMO
STORAGE   (
            INITIAL    65536
            MINEXTENTS 1
            MAXEXTENTS 2147483645
           )
/

--------------------------------------------------------------------------------------------------------------------
-- CRIAÇÃO DO ÍNDICE: IFRBDE.TAB_ITEM_DOTACAO_PK
--------------------------------------------------------------------------------------------------------------------
CREATE UNIQUE INDEX IFRBDE.TAB_ITEM_DOTACAO_PK ON IFRBDE.TAB_ITEM_DOTACAO (
DTI_DOT_ANO ASC,
DTI_DOT_RTI_COD ASC,
DTI_DPP_COD ASC)
PCTFREE    10
INITRANS   2
MAXTRANS   255
TABLESPACE TSD_MAXIMO
STORAGE   (
            INITIAL    65536
            MINEXTENTS 1
            MAXEXTENTS 2147483645
           )
/

--------------------------------------------------------------------------------------------------------------------
-- CRIAÇÃO DO ÍNDICE: IFRBDE.TAB_ITEM_DOTACAO_01_IX
--------------------------------------------------------------------------------------------------------------------
CREATE UNIQUE INDEX IFRBDE.TAB_ITEM_DOTACAO_01_IX ON IFRBDE.TAB_ITEM_DOTACAO (
DTI_DOT_ANO ASC,
DTI_DPP_COD ASC,
DTI_DOT_RTI_COD ASC)
PCTFREE    10
INITRANS   2
MAXTRANS   255
TABLESPACE TSD_MAXIMO
STORAGE   (
            INITIAL    65536
            MINEXTENTS 1
            MAXEXTENTS 2147483645
           )
/

--------------------------------------------------------------------------------------------------------------------
-- CRIAÇÃO DO ÍNDICE: IFRBDE.TAB_ITEM_DOTACAO_02_IX
--------------------------------------------------------------------------------------------------------------------
CREATE  INDEX IFRBDE.TAB_ITEM_DOTACAO_02_IX ON IFRBDE.TAB_ITEM_DOTACAO (
DTI_DPP_COD ASC)
PCTFREE    10
INITRANS   2
MAXTRANS   255
TABLESPACE TSD_MAXIMO
STORAGE   (
            INITIAL    65536
            MINEXTENTS 1
            MAXEXTENTS 2147483645
           )
/

--------------------------------------------------------------------------------------------------------------------
-- CRIAÇÃO DO ÍNDICE: IFRBDE.TAB_LOG_01_IX
--------------------------------------------------------------------------------------------------------------------
CREATE UNIQUE INDEX IFRBDE.TAB_LOG_01_IX ON IFRBDE.TAB_LOG (
LOG_COD ASC)
PCTFREE    10
INITRANS   2
MAXTRANS   255
TABLESPACE TSD_MAXIMO
STORAGE   (
            INITIAL    65536
            MINEXTENTS 1
            MAXEXTENTS 2147483645
           )
/

--------------------------------------------------------------------------------------------------------------------
-- CRIAÇÃO DO ÍNDICE: IFRBDE.TAB_MOV_DOTACAO_PK
--------------------------------------------------------------------------------------------------------------------
CREATE UNIQUE INDEX IFRBDE.TAB_MOV_DOTACAO_PK ON IFRBDE.TAB_MOV_DOTACAO (
MDT_ANO ASC,
MDT_DOC ASC,
MDT_DATA ASC,
MDT_TIPO_DOC ASC,
MDT_DPP_ORIG ASC,
MDT_RTI_COD_ORIG ASC)
PCTFREE    10
INITRANS   2
MAXTRANS   255
TABLESPACE TSD_MAXIMO
STORAGE   (
            INITIAL    65536
            MINEXTENTS 1
            MAXEXTENTS 2147483645
           )
/

--------------------------------------------------------------------------------------------------------------------
-- CRIAÇÃO DO ÍNDICE: IFRBDE.TAB_MOV_DOTACAO_01_IX
--------------------------------------------------------------------------------------------------------------------
CREATE  INDEX IFRBDE.TAB_MOV_DOTACAO_01_IX ON IFRBDE.TAB_MOV_DOTACAO (
MDT_ANO ASC,
MDT_DOC ASC,
MDT_DATA ASC,
MDT_TIPO_DOC ASC)
PCTFREE    10
INITRANS   2
MAXTRANS   255
TABLESPACE TSD_MAXIMO
STORAGE   (
            INITIAL    65536
            MINEXTENTS 1
            MAXEXTENTS 2147483645
           )
/

--------------------------------------------------------------------------------------------------------------------
-- CRIAÇÃO DO ÍNDICE: IFRBDE.TAB_NATUREZA_OBRA_FIL_PK
--------------------------------------------------------------------------------------------------------------------
CREATE UNIQUE INDEX IFRBDE.TAB_NATUREZA_OBRA_FIL_PK ON IFRBDE.TAB_NATUREZA_OBRA_FIL (
NTF_COD ASC)
PCTFREE    10
INITRANS   2
MAXTRANS   255
TABLESPACE TSD_MAXIMO
STORAGE   (
            INITIAL    65536
            MINEXTENTS 1
            MAXEXTENTS 2147483645
           )
/

--------------------------------------------------------------------------------------------------------------------
-- CRIAÇÃO DO ÍNDICE: IFRBDE.TAB_NATUREZA_OBRA_PK
--------------------------------------------------------------------------------------------------------------------
CREATE UNIQUE INDEX IFRBDE.TAB_NATUREZA_OBRA_PK ON IFRBDE.TAB_NATUREZA_OBRA (
NTO_COD ASC)
PCTFREE    10
INITRANS   2
MAXTRANS   255
TABLESPACE TSD_MAXIMO
STORAGE   (
            INITIAL    65536
            MINEXTENTS 1
            MAXEXTENTS 2147483645
           )
/

--------------------------------------------------------------------------------------------------------------------
-- CRIAÇÃO DO ÍNDICE: IFRBDE.TAB_OBRAS_TIPOS_PK
--------------------------------------------------------------------------------------------------------------------
CREATE UNIQUE INDEX IFRBDE.TAB_OBRAS_TIPOS_PK ON IFRBDE.TAB_OBRAS_TIPOS (
OBT_COD ASC)
PCTFREE    10
INITRANS   2
MAXTRANS   255
TABLESPACE TSD_MAXIMO
STORAGE   (
            INITIAL    65536
            MINEXTENTS 1
            MAXEXTENTS 2147483645
           )
/

--------------------------------------------------------------------------------------------------------------------
-- CRIAÇÃO DO ÍNDICE: IFRBDE.TAB_PRIORIDADE_PK
--------------------------------------------------------------------------------------------------------------------
CREATE UNIQUE INDEX IFRBDE.TAB_PRIORIDADE_PK ON IFRBDE.TAB_PRIORIDADE (
COD_PRIORIDADE ASC)
PCTFREE    10
INITRANS   2
MAXTRANS   255
TABLESPACE TSD_MAXIMO
STORAGE   (
            INITIAL    65536
            MINEXTENTS 1
            MAXEXTENTS 2147483645
           )
/

--------------------------------------------------------------------------------------------------------------------
-- CRIAÇÃO DO ÍNDICE: IFRBDE.TAB_REC_APROVADO_PK
--------------------------------------------------------------------------------------------------------------------
CREATE UNIQUE INDEX IFRBDE.TAB_REC_APROVADO_PK ON IFRBDE.TAB_REC_APROVADO (
RAP_CRE_COD ASC,
RAP_RTI_COD ASC,
RAP_PGOSE ASC)
PCTFREE    10
INITRANS   2
MAXTRANS   255
TABLESPACE TSD_MAXIMO
STORAGE   (
            INITIAL    65536
            MINEXTENTS 1
            MAXEXTENTS 2147483645
           )
/

--------------------------------------------------------------------------------------------------------------------
-- CRIAÇÃO DO ÍNDICE: IFRBDE.TAB_REC_APROVADO_01_IX
--------------------------------------------------------------------------------------------------------------------
CREATE  INDEX IFRBDE.TAB_REC_APROVADO_01_IX ON IFRBDE.TAB_REC_APROVADO (
RAP_CRE_COD ASC)
PCTFREE    10
INITRANS   2
MAXTRANS   255
TABLESPACE TSD_MAXIMO
STORAGE   (
            INITIAL    65536
            MINEXTENTS 1
            MAXEXTENTS 2147483645
           )
/

--------------------------------------------------------------------------------------------------------------------
-- CRIAÇÃO DO ÍNDICE: IFRBDE.TAB_REC_PRECOMPROVADO_PK
--------------------------------------------------------------------------------------------------------------------
CREATE UNIQUE INDEX IFRBDE.TAB_REC_PRECOMPROVADO_PK ON IFRBDE.TAB_REC_PRECOMPROVADO (
RPR_CRE_COD ASC,
RPR_PGOSE ASC,
RPR_RTI_COD ASC,
RPR_NUM ASC)
PCTFREE    10
INITRANS   2
MAXTRANS   255
TABLESPACE TSD_MAXIMO
STORAGE   (
            INITIAL    65536
            MINEXTENTS 1
            MAXEXTENTS 2147483645
           )
/

--------------------------------------------------------------------------------------------------------------------
-- CRIAÇÃO DO ÍNDICE: IFRBDE.TAB_REC_PRECOMPROVADO_01_IX
--------------------------------------------------------------------------------------------------------------------
CREATE  INDEX IFRBDE.TAB_REC_PRECOMPROVADO_01_IX ON IFRBDE.TAB_REC_PRECOMPROVADO (
RPR_CRE_COD ASC)
PCTFREE    10
INITRANS   2
MAXTRANS   255
TABLESPACE TSD_MAXIMO
STORAGE   (
            INITIAL    65536
            MINEXTENTS 1
            MAXEXTENTS 2147483645
           )
/

--------------------------------------------------------------------------------------------------------------------
-- CRIAÇÃO DO ÍNDICE: IFRBDE.TAB_REC_PRECOMPROVADO_02_IX
--------------------------------------------------------------------------------------------------------------------
CREATE  INDEX IFRBDE.TAB_REC_PRECOMPROVADO_02_IX ON IFRBDE.TAB_REC_PRECOMPROVADO (
RPR_RTI_COD ASC)
PCTFREE    10
INITRANS   2
MAXTRANS   255
TABLESPACE TSD_MAXIMO
STORAGE   (
            INITIAL    65536
            MINEXTENTS 1
            MAXEXTENTS 2147483645
           )
/

--------------------------------------------------------------------------------------------------------------------
-- CRIAÇÃO DO ÍNDICE: IFRBDE.TAB_REMANEJAMENTO_PK
--------------------------------------------------------------------------------------------------------------------
CREATE UNIQUE INDEX IFRBDE.TAB_REMANEJAMENTO_PK ON IFRBDE.TAB_REMANEJAMENTO (
RMJ_COD ASC)
PCTFREE    10
INITRANS   2
MAXTRANS   255
TABLESPACE TSD_MAXIMO
STORAGE   (
            INITIAL    65536
            MINEXTENTS 1
            MAXEXTENTS 2147483645
           )
/

--------------------------------------------------------------------------------------------------------------------
-- CRIAÇÃO DO ÍNDICE: IFRBDE.TAB_REMANEJAMENTO_01_IX
--------------------------------------------------------------------------------------------------------------------
CREATE  INDEX IFRBDE.TAB_REMANEJAMENTO_01_IX ON IFRBDE.TAB_REMANEJAMENTO (
RMJ_ANO ASC,
RMJ_SEQ_ORIG ASC,
RMJ_SEQ_DEST ASC)
PCTFREE    10
INITRANS   2
MAXTRANS   255
TABLESPACE TSD_MAXIMO
STORAGE   (
            INITIAL    65536
            MINEXTENTS 1
            MAXEXTENTS 2147483645
           )
/

--------------------------------------------------------------------------------------------------------------------
-- CRIAÇÃO DO ÍNDICE: IFRBDE.TAB_TIPO_EVENTO_LICITACAO_PK
--------------------------------------------------------------------------------------------------------------------
CREATE UNIQUE INDEX IFRBDE.TAB_TIPO_EVENTO_LICITACAO_PK ON IFRBDE.TAB_TIPO_EVENTO_LICITACAO (
COD_TIPO_EVENTO ASC)
PCTFREE    10
INITRANS   2
MAXTRANS   255
TABLESPACE TSD_MAXIMO
STORAGE   (
            INITIAL    65536
            MINEXTENTS 1
            MAXEXTENTS 2147483645
           )
/

--------------------------------------------------------------------------------------------------------------------
-- CRIAÇÃO DO ÍNDICE: IFRBDE.TAB_TIPO_EVENTO_LICIT_01_IX
--------------------------------------------------------------------------------------------------------------------
CREATE  INDEX IFRBDE.TAB_TIPO_EVENTO_LICIT_01_IX ON IFRBDE.TAB_TIPO_EVENTO_LICITACAO (
DSC_TIPO_EVENTO ASC)
PCTFREE    10
INITRANS   2
MAXTRANS   255
TABLESPACE TSD_MAXIMO
STORAGE   (
            INITIAL    65536
            MINEXTENTS 1
            MAXEXTENTS 2147483645
           )
/

--------------------------------------------------------------------------------------------------------------------
-- CRIAÇÃO DO ÍNDICE: IFRBDE.TAB_TIPO_LICITACAO_PK
--------------------------------------------------------------------------------------------------------------------
CREATE UNIQUE INDEX IFRBDE.TAB_TIPO_LICITACAO_PK ON IFRBDE.TAB_TIPO_LICITACAO (
COD_TIPO_LICITACAO ASC)
PCTFREE    10
INITRANS   2
MAXTRANS   255
TABLESPACE TSD_MAXIMO
STORAGE   (
            INITIAL    65536
            MINEXTENTS 1
            MAXEXTENTS 2147483645
           )
/

--------------------------------------------------------------------------------------------------------------------
-- CRIAÇÃO DO ÍNDICE: IFRBDE.TAB_TIPO_RECURSO_ITEM_01_IX
--------------------------------------------------------------------------------------------------------------------
CREATE  INDEX IFRBDE.TAB_TIPO_RECURSO_ITEM_01_IX ON IFRBDE.TAB_TIPO_RECURSO_ITEM (
RTI_RCT_COD ASC)
PCTFREE    10
INITRANS   2
MAXTRANS   255
TABLESPACE TSD_MAXIMO
STORAGE   (
            INITIAL    65536
            MINEXTENTS 1
            MAXEXTENTS 2147483645
           )
/

--------------------------------------------------------------------------------------------------------------------
-- CRIAÇÃO DO ÍNDICE: IFRBDE.TIPO_RECURSO_PK
--------------------------------------------------------------------------------------------------------------------
CREATE UNIQUE INDEX IFRBDE.TIPO_RECURSO_PK ON IFRBDE.TAB_TIPO_RECURSO (
RCT_COD ASC)
PCTFREE    10
INITRANS   2
MAXTRANS   255
TABLESPACE TSD_MAXIMO
STORAGE   (
            INITIAL    65536
            MINEXTENTS 1
            MAXEXTENTS 2147483645
           )
/

----------------- TOTAL DE REGISTROS ----------------- 
Quantidade de Índices: 82
------------------------------------------------------ 

-- GERAÇÃO: 4/10/2006 do Banco: PRODSEDE2
--------------------------------------------------------------------------------------------------------------------
-- CRIAÇÃO DO ÍNDICE: IFRMAXIMO.ACCTDFLT_NDX1
--------------------------------------------------------------------------------------------------------------------
CREATE UNIQUE INDEX IFRMAXIMO.ACCTDFLT_NDX1 ON IFRMAXIMO.ACCOUNTDEFAULTS (
ORGID ASC,
DFLTGROUP ASC,
GROUPVALUE ASC)
PCTFREE    10
INITRANS   2
MAXTRANS   255
TABLESPACE TSI_MAXIMO
STORAGE   (
            INITIAL    65536
            MINEXTENTS 1
            MAXEXTENTS 2147483645
           )
/

--------------------------------------------------------------------------------------------------------------------
-- CRIAÇÃO DO ÍNDICE: IFRMAXIMO.ADDRESS_NDX1
--------------------------------------------------------------------------------------------------------------------
CREATE UNIQUE INDEX IFRMAXIMO.ADDRESS_NDX1 ON IFRMAXIMO.ADDRESS (
ORGID ASC,
ADDRESSCODE ASC)
PCTFREE    10
INITRANS   2
MAXTRANS   255
TABLESPACE TSI_MAXIMO
STORAGE   (
            INITIAL    65536
            MINEXTENTS 1
            MAXEXTENTS 2147483645
           )
/

--------------------------------------------------------------------------------------------------------------------
-- CRIAÇÃO DO ÍNDICE: IFRMAXIMO.ALNDOMAINVAL_NDX1
--------------------------------------------------------------------------------------------------------------------
CREATE UNIQUE INDEX IFRMAXIMO.ALNDOMAINVAL_NDX1 ON IFRMAXIMO.ALNDOMAINVALUE (
DOMAINID ASC,
ALNVALUE ASC)
PCTFREE    10
INITRANS   2
MAXTRANS   255
TABLESPACE TSI_MAXIMO
STORAGE   (
            INITIAL    40960
            MINEXTENTS 1
            MAXEXTENTS 2147483645
           )
/

--------------------------------------------------------------------------------------------------------------------
-- CRIAÇÃO DO ÍNDICE: IFRMAXIMO.ALTITEM_NDX1
--------------------------------------------------------------------------------------------------------------------
CREATE UNIQUE INDEX IFRMAXIMO.ALTITEM_NDX1 ON IFRMAXIMO.ALTITEM (
ORGID ASC,
ITEMNUM ASC,
ALTITEMNUM ASC)
PCTFREE    10
INITRANS   2
MAXTRANS   255
TABLESPACE TSI_MAXIMO
STORAGE   (
            INITIAL    65536
            MINEXTENTS 1
            MAXEXTENTS 2147483645
           )
/

--------------------------------------------------------------------------------------------------------------------
-- CRIAÇÃO DO ÍNDICE: IFRMAXIMO.ANALYZEINDEX_NDX
--------------------------------------------------------------------------------------------------------------------
CREATE UNIQUE INDEX IFRMAXIMO.ANALYZEINDEX_NDX ON IFRMAXIMO.MAXANALYZEINDEXES (
TBNAME ASC,
UNIQUERULE ASC,
CLUSTERRULE ASC,
CHANGED ASC,
KEY1 ASC,
KEY2 ASC,
KEY3 ASC,
KEY4 ASC,
KEY5 ASC,
KEY6 ASC,
KEY7 ASC)
PCTFREE    10
INITRANS   2
MAXTRANS   255
TABLESPACE TSI_MAXIMO
STORAGE   (
            INITIAL    65536
            MINEXTENTS 1
            MAXEXTENTS 2147483645
           )
/

--------------------------------------------------------------------------------------------------------------------
-- CRIAÇÃO DO ÍNDICE: IFRMAXIMO.APPDOCTYPE_NDX1
--------------------------------------------------------------------------------------------------------------------
CREATE UNIQUE INDEX IFRMAXIMO.APPDOCTYPE_NDX1 ON IFRMAXIMO.APPDOCTYPE (
SITEID ASC,
APP ASC,
DOCTYPE ASC)
PCTFREE    10
INITRANS   2
MAXTRANS   255
TABLESPACE TSI_MAXIMO
STORAGE   (
            INITIAL    65536
            MINEXTENTS 1
            MAXEXTENTS 2147483645
           )
/

--------------------------------------------------------------------------------------------------------------------
-- CRIAÇÃO DO ÍNDICE: IFRMAXIMO.APPFIELDDEF_NDX1
--------------------------------------------------------------------------------------------------------------------
CREATE UNIQUE INDEX IFRMAXIMO.APPFIELDDEF_NDX1 ON IFRMAXIMO.APPFIELDDEFAULTS (
APP ASC,
TBNAME ASC,
COLNAME ASC,
SITEID ASC,
GRPNAME ASC,
USERNAME ASC)
PCTFREE    10
INITRANS   2
MAXTRANS   255
TABLESPACE TSI_MAXIMO
STORAGE   (
            INITIAL    65536
            MINEXTENTS 1
            MAXEXTENTS 2147483645
           )
/

--------------------------------------------------------------------------------------------------------------------
-- CRIAÇÃO DO ÍNDICE: IFRMAXIMO.APPFIELDDEF_NDX2
--------------------------------------------------------------------------------------------------------------------
CREATE UNIQUE INDEX IFRMAXIMO.APPFIELDDEF_NDX2 ON IFRMAXIMO.APPFIELDDEFAULTS (
APP ASC,
TBNAME ASC,
COLNAME ASC,
SITEID ASC,
USERNAME ASC,
GRPNAME ASC)
PCTFREE    10
INITRANS   2
MAXTRANS   255
TABLESPACE TSI_MAXIMO
STORAGE   (
            INITIAL    65536
            MINEXTENTS 1
            MAXEXTENTS 2147483645
           )
/

--------------------------------------------------------------------------------------------------------------------
-- CRIAÇÃO DO ÍNDICE: IFRMAXIMO.APPLAUNCH_NDX1
--------------------------------------------------------------------------------------------------------------------
CREATE UNIQUE INDEX IFRMAXIMO.APPLAUNCH_NDX1 ON IFRMAXIMO.APPLAUNCH (
LAUNCHINGAPP ASC,
LAUNCHINGPARENT ASC,
LAUNCHINGITEM ASC)
PCTFREE    10
INITRANS   2
MAXTRANS   255
TABLESPACE TSI_MAXIMO
STORAGE   (
            INITIAL    65536
            MINEXTENTS 1
            MAXEXTENTS 2147483645
           )
/

--------------------------------------------------------------------------------------------------------------------
-- CRIAÇÃO DO ÍNDICE: IFRMAXIMO.APPROVALLIMIT_NDX1
--------------------------------------------------------------------------------------------------------------------
CREATE UNIQUE INDEX IFRMAXIMO.APPROVALLIMIT_NDX1 ON IFRMAXIMO.APPROVALLIMIT (
ORGID ASC,
GRPNAME ASC)
PCTFREE    10
INITRANS   2
MAXTRANS   255
TABLESPACE TSI_MAXIMO
STORAGE   (
            INITIAL    65536
            MINEXTENTS 1
            MAXEXTENTS 2147483645
           )
/

--------------------------------------------------------------------------------------------------------------------
-- CRIAÇÃO DO ÍNDICE: IFRMAXIMO.ARCHIVE_NDX1
--------------------------------------------------------------------------------------------------------------------
CREATE UNIQUE INDEX IFRMAXIMO.ARCHIVE_NDX1 ON IFRMAXIMO.ARCHIVE (
ARCHIVEDATE ASC,
MODULE ASC)
PCTFREE    10
INITRANS   2
MAXTRANS   255
TABLESPACE TSI_MAXIMO
STORAGE   (
            INITIAL    65536
            MINEXTENTS 1
            MAXEXTENTS 2147483645
           )
/

--------------------------------------------------------------------------------------------------------------------
-- CRIAÇÃO DO ÍNDICE: IFRMAXIMO.ASSETATTR_NDX1
--------------------------------------------------------------------------------------------------------------------
CREATE UNIQUE INDEX IFRMAXIMO.ASSETATTR_NDX1 ON IFRMAXIMO.ASSETATTRIBUTE (
ORGID ASC,
ASSETATTRID ASC)
PCTFREE    10
INITRANS   2
MAXTRANS   255
TABLESPACE TSI_MAXIMO
STORAGE   (
            INITIAL    65536
            MINEXTENTS 1
            MAXEXTENTS 2147483645
           )
/

--------------------------------------------------------------------------------------------------------------------
-- CRIAÇÃO DO ÍNDICE: IFRMAXIMO.ASSETCLASS_NDX1
--------------------------------------------------------------------------------------------------------------------
CREATE UNIQUE INDEX IFRMAXIMO.ASSETCLASS_NDX1 ON IFRMAXIMO.ASSETCLASS (
ORGID ASC,
CLASSIFICATIONID ASC)
PCTFREE    10
INITRANS   2
MAXTRANS   255
TABLESPACE TSI_MAXIMO
STORAGE   (
            INITIAL    65536
            MINEXTENTS 1
            MAXEXTENTS 2147483645
           )
/

--------------------------------------------------------------------------------------------------------------------
-- CRIAÇÃO DO ÍNDICE: IFRMAXIMO.ASSIGNMNT_NDX
--------------------------------------------------------------------------------------------------------------------
CREATE  INDEX IFRMAXIMO.ASSIGNMNT_NDX ON IFRMAXIMO.ASSIGNMENT (
ORGID ASC,
WONUM ASC,
WPLABORID ASC)
PCTFREE    10
INITRANS   2
MAXTRANS   255
TABLESPACE TSI_MAXIMO
STORAGE   (
            INITIAL    65536
            MINEXTENTS 1
            MAXEXTENTS 2147483645
           )
/

--------------------------------------------------------------------------------------------------------------------
-- CRIAÇÃO DO ÍNDICE: IFRMAXIMO.ATTEND_NDX1
--------------------------------------------------------------------------------------------------------------------
CREATE  INDEX IFRMAXIMO.ATTEND_NDX1 ON IFRMAXIMO.ATTENDANCE (
ORGID ASC,
LABORCODE ASC,
TRANSDATE ASC)
PCTFREE    10
INITRANS   2
MAXTRANS   255
TABLESPACE TSI_MAXIMO
STORAGE   (
            INITIAL    65536
            MINEXTENTS 1
            MAXEXTENTS 2147483645
           )
/

--------------------------------------------------------------------------------------------------------------------
-- CRIAÇÃO DO ÍNDICE: IFRMAXIMO.AUTOKEY_NDX1
--------------------------------------------------------------------------------------------------------------------
CREATE UNIQUE INDEX IFRMAXIMO.AUTOKEY_NDX1 ON IFRMAXIMO.AUTOKEY (
TBNAME ASC,
NAME ASC,
ORGID ASC,
SITEID ASC)
PCTFREE    10
INITRANS   2
MAXTRANS   255
TABLESPACE TSI_MAXIMO
STORAGE   (
            INITIAL    65536
            MINEXTENTS 1
            MAXEXTENTS 2147483645
           )
/

--------------------------------------------------------------------------------------------------------------------
-- CRIAÇÃO DO ÍNDICE: IFRMAXIMO.BOOKMARK_NDX1
--------------------------------------------------------------------------------------------------------------------
CREATE UNIQUE INDEX IFRMAXIMO.BOOKMARK_NDX1 ON IFRMAXIMO.BOOKMARK (
SITEID ASC,
USERNAME ASC,
APP ASC,
KEYVALUE ASC)
PCTFREE    10
INITRANS   2
MAXTRANS   255
TABLESPACE TSI_MAXIMO
STORAGE   (
            INITIAL    65536
            MINEXTENTS 1
            MAXEXTENTS 2147483645
           )
/

--------------------------------------------------------------------------------------------------------------------
-- CRIAÇÃO DO ÍNDICE: IFRMAXIMO.CAL
--------------------------------------------------------------------------------------------------------------------
CREATE UNIQUE INDEX IFRMAXIMO.CAL ON IFRMAXIMO.ITEM (
ITEMNUM ASC)
PCTFREE    10
INITRANS   2
MAXTRANS   255
TABLESPACE TSI_MAXIMO
STORAGE   (
            INITIAL    65536
            MINEXTENTS 1
            MAXEXTENTS 2147483645
           )
/

--------------------------------------------------------------------------------------------------------------------
-- CRIAÇÃO DO ÍNDICE: IFRMAXIMO.CALENDAR_NDX
--------------------------------------------------------------------------------------------------------------------
CREATE UNIQUE INDEX IFRMAXIMO.CALENDAR_NDX ON IFRMAXIMO.CALENDAR (
ORGID ASC,
CALNUM ASC)
PCTFREE    10
INITRANS   2
MAXTRANS   255
TABLESPACE TSI_MAXIMO
STORAGE   (
            INITIAL    65536
            MINEXTENTS 1
            MAXEXTENTS 2147483645
           )
/

--------------------------------------------------------------------------------------------------------------------
-- CRIAÇÃO DO ÍNDICE: IFRMAXIMO.CLASSSPEC_NDX1
--------------------------------------------------------------------------------------------------------------------
CREATE UNIQUE INDEX IFRMAXIMO.CLASSSPEC_NDX1 ON IFRMAXIMO.CLASSSPEC (
ORGID ASC,
CLASSSTRUCTUREID ASC,
ASSETATTRID ASC)
PCTFREE    10
INITRANS   2
MAXTRANS   255
TABLESPACE TSI_MAXIMO
STORAGE   (
            INITIAL    65536
            MINEXTENTS 1
            MAXEXTENTS 2147483645
           )
/

--------------------------------------------------------------------------------------------------------------------
-- CRIAÇÃO DO ÍNDICE: IFRMAXIMO.CLASSSTRUCTLNK_NDX
--------------------------------------------------------------------------------------------------------------------
CREATE UNIQUE INDEX IFRMAXIMO.CLASSSTRUCTLNK_NDX ON IFRMAXIMO.CLASSSTRUCTLINK (
ORGID ASC,
CLASSIFICATIONID ASC,
CLASSSTRUCTUREID ASC)
PCTFREE    10
INITRANS   2
MAXTRANS   255
TABLESPACE TSI_MAXIMO
STORAGE   (
            INITIAL    65536
            MINEXTENTS 1
            MAXEXTENTS 2147483645
           )
/

--------------------------------------------------------------------------------------------------------------------
-- CRIAÇÃO DO ÍNDICE: IFRMAXIMO.CLASSSTRUCT_NDX1
--------------------------------------------------------------------------------------------------------------------
CREATE UNIQUE INDEX IFRMAXIMO.CLASSSTRUCT_NDX1 ON IFRMAXIMO.CLASSSTRUCTURE (
ORGID ASC,
CLASSSTRUCTUREID ASC)
PCTFREE    10
INITRANS   2
MAXTRANS   255
TABLESPACE TSI_MAXIMO
STORAGE   (
            INITIAL    65536
            MINEXTENTS 1
            MAXEXTENTS 2147483645
           )
/

--------------------------------------------------------------------------------------------------------------------
-- CRIAÇÃO DO ÍNDICE: IFRMAXIMO.CLASSSTRUCT_NDX2
--------------------------------------------------------------------------------------------------------------------
CREATE UNIQUE INDEX IFRMAXIMO.CLASSSTRUCT_NDX2 ON IFRMAXIMO.CLASSSTRUCTURE (
ORGID ASC,
L1CLASSIFICATIONID ASC,
L2CLASSIFICATIONID ASC,
L3CLASSIFICATIONID ASC,
L4CLASSIFICATIONID ASC,
L5CLASSIFICATIONID ASC)
PCTFREE    10
INITRANS   2
MAXTRANS   255
TABLESPACE TSI_MAXIMO
STORAGE   (
            INITIAL    65536
            MINEXTENTS 1
            MAXEXTENTS 2147483645
           )
/

--------------------------------------------------------------------------------------------------------------------
-- CRIAÇÃO DO ÍNDICE: IFRMAXIMO.COA_NDX1
--------------------------------------------------------------------------------------------------------------------
CREATE UNIQUE INDEX IFRMAXIMO.COA_NDX1 ON IFRMAXIMO.CHARTOFACCOUNTS (
ORGID ASC,
GLACCOUNT ASC)
PCTFREE    10
INITRANS   2
MAXTRANS   255
TABLESPACE TSI_MAXIMO
STORAGE   (
            INITIAL    65536
            MINEXTENTS 1
            MAXEXTENTS 2147483645
           )
/

--------------------------------------------------------------------------------------------------------------------
-- CRIAÇÃO DO ÍNDICE: IFRMAXIMO.COA_NDX2
--------------------------------------------------------------------------------------------------------------------
CREATE  INDEX IFRMAXIMO.COA_NDX2 ON IFRMAXIMO.CHARTOFACCOUNTS (
ORGID ASC,
GLACCTYPE ASC)
PCTFREE    10
INITRANS   2
MAXTRANS   255
TABLESPACE TSI_MAXIMO
STORAGE   (
            INITIAL    65536
            MINEXTENTS 1
            MAXEXTENTS 2147483645
           )
/

--------------------------------------------------------------------------------------------------------------------
-- CRIAÇÃO DO ÍNDICE: IFRMAXIMO.COA_NDX3
--------------------------------------------------------------------------------------------------------------------
CREATE  INDEX IFRMAXIMO.COA_NDX3 ON IFRMAXIMO.CHARTOFACCOUNTS (
ORGID ASC,
GLCOMP01 ASC)
PCTFREE    10
INITRANS   2
MAXTRANS   255
TABLESPACE TSI_MAXIMO
STORAGE   (
            INITIAL    65536
            MINEXTENTS 1
            MAXEXTENTS 2147483645
           )
/

--------------------------------------------------------------------------------------------------------------------
-- CRIAÇÃO DO ÍNDICE: IFRMAXIMO.COA_NDX4
--------------------------------------------------------------------------------------------------------------------
CREATE  INDEX IFRMAXIMO.COA_NDX4 ON IFRMAXIMO.CHARTOFACCOUNTS (
ORGID ASC,
INTERID ASC)
PCTFREE    10
INITRANS   2
MAXTRANS   255
TABLESPACE TSI_MAXIMO
STORAGE   (
            INITIAL    65536
            MINEXTENTS 1
            MAXEXTENTS 2147483645
           )
/

--------------------------------------------------------------------------------------------------------------------
-- CRIAÇÃO DO ÍNDICE: IFRMAXIMO.COMMODITYAUTH_NDX1
--------------------------------------------------------------------------------------------------------------------
CREATE UNIQUE INDEX IFRMAXIMO.COMMODITYAUTH_NDX1 ON IFRMAXIMO.COMMODITYAUTH (
ORGID ASC,
GRPNAME ASC,
CLASSSTRUCTUREID ASC)
PCTFREE    10
INITRANS   2
MAXTRANS   255
TABLESPACE TSI_MAXIMO
STORAGE   (
            INITIAL    65536
            MINEXTENTS 1
            MAXEXTENTS 2147483645
           )
/

--------------------------------------------------------------------------------------------------------------------
-- CRIAÇÃO DO ÍNDICE: IFRMAXIMO.COMPANIES_NDX2
--------------------------------------------------------------------------------------------------------------------
CREATE  INDEX IFRMAXIMO.COMPANIES_NDX2 ON IFRMAXIMO.COMPANIES (
ORGID ASC,
TYPE ASC)
PCTFREE    10
INITRANS   2
MAXTRANS   255
TABLESPACE TSI_MAXIMO
STORAGE   (
            INITIAL    65536
            MINEXTENTS 1
            MAXEXTENTS 2147483645
           )
/

--------------------------------------------------------------------------------------------------------------------
-- CRIAÇÃO DO ÍNDICE: IFRMAXIMO.COMPANIES_NDX3
--------------------------------------------------------------------------------------------------------------------
CREATE  INDEX IFRMAXIMO.COMPANIES_NDX3 ON IFRMAXIMO.COMPANIES (
ORGID ASC,
INTERID ASC)
PCTFREE    10
INITRANS   2
MAXTRANS   255
TABLESPACE TSI_MAXIMO
STORAGE   (
            INITIAL    65536
            MINEXTENTS 1
            MAXEXTENTS 2147483645
           )
/

--------------------------------------------------------------------------------------------------------------------
-- CRIAÇÃO DO ÍNDICE: IFRMAXIMO.COMPANY_NDX
--------------------------------------------------------------------------------------------------------------------
CREATE UNIQUE INDEX IFRMAXIMO.COMPANY_NDX ON IFRMAXIMO.COMPANIES (
ORGID ASC,
COMPANY ASC)
PCTFREE    10
INITRANS   2
MAXTRANS   255
TABLESPACE TSI_MAXIMO
STORAGE   (
            INITIAL    65536
            MINEXTENTS 1
            MAXEXTENTS 2147483645
           )
/

--------------------------------------------------------------------------------------------------------------------
-- CRIAÇÃO DO ÍNDICE: IFRMAXIMO.COMPCONTACT_NDX1
--------------------------------------------------------------------------------------------------------------------
CREATE UNIQUE INDEX IFRMAXIMO.COMPCONTACT_NDX1 ON IFRMAXIMO.COMPCONTACT (
ORGID ASC,
COMPANY ASC,
CONTACT ASC)
PCTFREE    10
INITRANS   2
MAXTRANS   255
TABLESPACE TSI_MAXIMO
STORAGE   (
            INITIAL    65536
            MINEXTENTS 1
            MAXEXTENTS 2147483645
           )
/

--------------------------------------------------------------------------------------------------------------------
-- CRIAÇÃO DO ÍNDICE: IFRMAXIMO.CPNYACCTDFLT_NDX1
--------------------------------------------------------------------------------------------------------------------
CREATE UNIQUE INDEX IFRMAXIMO.CPNYACCTDFLT_NDX1 ON IFRMAXIMO.COMPANYACCDEF (
ORGID ASC,
TYPE ASC)
PCTFREE    10
INITRANS   2
MAXTRANS   255
TABLESPACE TSI_MAXIMO
STORAGE   (
            INITIAL    65536
            MINEXTENTS 1
            MAXEXTENTS 2147483645
           )
/

--------------------------------------------------------------------------------------------------------------------
-- CRIAÇÃO DO ÍNDICE: IFRMAXIMO.CROSSOVER_NDX1
--------------------------------------------------------------------------------------------------------------------
CREATE UNIQUE INDEX IFRMAXIMO.CROSSOVER_NDX1 ON IFRMAXIMO.CROSSOVERDOMAIN (
DOMAINID ASC,
SOURCEFIELD ASC,
DESTFIELD ASC)
PCTFREE    10
INITRANS   2
MAXTRANS   255
TABLESPACE TSI_MAXIMO
STORAGE   (
            INITIAL    65536
            MINEXTENTS 1
            MAXEXTENTS 2147483645
           )
/

--------------------------------------------------------------------------------------------------------------------
-- CRIAÇÃO DO ÍNDICE: IFRMAXIMO.CURRENCY_NDX
--------------------------------------------------------------------------------------------------------------------
CREATE UNIQUE INDEX IFRMAXIMO.CURRENCY_NDX ON IFRMAXIMO.CURRENCY (
CURRENCYCODE ASC)
PCTFREE    10
INITRANS   2
MAXTRANS   255
TABLESPACE TSI_MAXIMO
STORAGE   (
            INITIAL    65536
            MINEXTENTS 1
            MAXEXTENTS 2147483645
           )
/

--------------------------------------------------------------------------------------------------------------------
-- CRIAÇÃO DO ÍNDICE: IFRMAXIMO.DEFAULTQUERY_NDX1
--------------------------------------------------------------------------------------------------------------------
CREATE UNIQUE INDEX IFRMAXIMO.DEFAULTQUERY_NDX1 ON IFRMAXIMO.DEFAULTQUERY (
SITEID ASC,
USERNAME ASC,
APP ASC)
PCTFREE    10
INITRANS   2
MAXTRANS   255
TABLESPACE TSI_MAXIMO
STORAGE   (
            INITIAL    65536
            MINEXTENTS 1
            MAXEXTENTS 2147483645
           )
/

--------------------------------------------------------------------------------------------------------------------
-- CRIAÇÃO DO ÍNDICE: IFRMAXIMO.DESKTOPDFLTS_NDX
--------------------------------------------------------------------------------------------------------------------
CREATE UNIQUE INDEX IFRMAXIMO.DESKTOPDFLTS_NDX ON IFRMAXIMO.DESKTOPDFLTS (
USERNAME ASC,
APP ASC,
SCREEN ASC)
PCTFREE    10
INITRANS   2
MAXTRANS   255
TABLESPACE TSI_MAXIMO
STORAGE   (
            INITIAL    65536
            MINEXTENTS 1
            MAXEXTENTS 2147483645
           )
/

--------------------------------------------------------------------------------------------------------------------
-- CRIAÇÃO DO ÍNDICE: IFRMAXIMO.DMSAPISETTING_NDX1
--------------------------------------------------------------------------------------------------------------------
CREATE UNIQUE INDEX IFRMAXIMO.DMSAPISETTING_NDX1 ON IFRMAXIMO.DMSAPISETTING (
DMSNAME ASC)
PCTFREE    10
INITRANS   2
MAXTRANS   255
TABLESPACE TSI_MAXIMO
STORAGE   (
            INITIAL    65536
            MINEXTENTS 1
            MAXEXTENTS 2147483645
           )
/

--------------------------------------------------------------------------------------------------------------------
-- CRIAÇÃO DO ÍNDICE: IFRMAXIMO.DOCINFO_NDX1
--------------------------------------------------------------------------------------------------------------------
CREATE UNIQUE INDEX IFRMAXIMO.DOCINFO_NDX1 ON IFRMAXIMO.DOCINFO (
SITEID ASC,
DOCUMENT ASC)
PCTFREE    10
INITRANS   2
MAXTRANS   255
TABLESPACE TSI_MAXIMO
STORAGE   (
            INITIAL    65536
            MINEXTENTS 1
            MAXEXTENTS 2147483645
           )
/

--------------------------------------------------------------------------------------------------------------------
-- CRIAÇÃO DO ÍNDICE: IFRMAXIMO.DOCLINKS_NDX1
--------------------------------------------------------------------------------------------------------------------
CREATE UNIQUE INDEX IFRMAXIMO.DOCLINKS_NDX1 ON IFRMAXIMO.DOCLINKS (
SITEID ASC,
DOCUMENT ASC,
KEYTABLE ASC,
KEYCOLUMN ASC,
KEYVALUE ASC,
DOCTYPE ASC)
PCTFREE    10
INITRANS   2
MAXTRANS   255
TABLESPACE TSI_MAXIMO
STORAGE   (
            INITIAL    65536
            MINEXTENTS 1
            MAXEXTENTS 2147483645
           )
/

--------------------------------------------------------------------------------------------------------------------
-- CRIAÇÃO DO ÍNDICE: IFRMAXIMO.DOCLINKS_NDX2
--------------------------------------------------------------------------------------------------------------------
CREATE  INDEX IFRMAXIMO.DOCLINKS_NDX2 ON IFRMAXIMO.DOCLINKS (
SITEID ASC,
DOCUMENT ASC,
REFERENCE ASC,
KEYVALUE ASC)
PCTFREE    10
INITRANS   2
MAXTRANS   255
TABLESPACE TSI_MAXIMO
STORAGE   (
            INITIAL    65536
            MINEXTENTS 1
            MAXEXTENTS 2147483645
           )
/

--------------------------------------------------------------------------------------------------------------------
-- CRIAÇÃO DO ÍNDICE: IFRMAXIMO.DOCLINKS_NDX3
--------------------------------------------------------------------------------------------------------------------
CREATE  INDEX IFRMAXIMO.DOCLINKS_NDX3 ON IFRMAXIMO.DOCLINKS (
SITEID ASC,
KEYTABLE ASC,
KEYCOLUMN ASC,
KEYVALUE ASC)
PCTFREE    10
INITRANS   2
MAXTRANS   255
TABLESPACE TSI_MAXIMO
STORAGE   (
            INITIAL    65536
            MINEXTENTS 1
            MAXEXTENTS 2147483645
           )
/

--------------------------------------------------------------------------------------------------------------------
-- CRIAÇÃO DO ÍNDICE: IFRMAXIMO.DOCTYPES_NDX1
--------------------------------------------------------------------------------------------------------------------
CREATE UNIQUE INDEX IFRMAXIMO.DOCTYPES_NDX1 ON IFRMAXIMO.DOCTYPES (
SITEID ASC,
DOCTYPE ASC)
PCTFREE    10
INITRANS   2
MAXTRANS   255
TABLESPACE TSI_MAXIMO
STORAGE   (
            INITIAL    65536
            MINEXTENTS 1
            MAXEXTENTS 2147483645
           )
/

--------------------------------------------------------------------------------------------------------------------
-- CRIAÇÃO DO ÍNDICE: IFRMAXIMO.DUMMY_TABLE_NDX1
--------------------------------------------------------------------------------------------------------------------
CREATE UNIQUE INDEX IFRMAXIMO.DUMMY_TABLE_NDX1 ON IFRMAXIMO.DUMMY_TABLE (
DUMMY_ALN ASC)
PCTFREE    10
INITRANS   2
MAXTRANS   255
TABLESPACE TSI_MAXIMO
STORAGE   (
            INITIAL    65536
            MINEXTENTS 1
            MAXEXTENTS 2147483645
           )
/

--------------------------------------------------------------------------------------------------------------------
-- CRIAÇÃO DO ÍNDICE: IFRMAXIMO.EQHIER_NDX
--------------------------------------------------------------------------------------------------------------------
CREATE UNIQUE INDEX IFRMAXIMO.EQHIER_NDX ON IFRMAXIMO.EQHIERARCHY (
SITEID ASC,
WONUM ASC,
EQNUM ASC)
PCTFREE    10
INITRANS   2
MAXTRANS   255
TABLESPACE TSI_MAXIMO
STORAGE   (
            INITIAL    65536
            MINEXTENTS 1
            MAXEXTENTS 2147483645
           )
/

--------------------------------------------------------------------------------------------------------------------
-- CRIAÇÃO DO ÍNDICE: IFRMAXIMO.EQHIST_NDX1
--------------------------------------------------------------------------------------------------------------------
CREATE  INDEX IFRMAXIMO.EQHIST_NDX1 ON IFRMAXIMO.EQHISTORY (
SITEID ASC,
WONUM ASC,
EQNUM ASC)
PCTFREE    10
INITRANS   2
MAXTRANS   255
TABLESPACE TSI_MAXIMO
STORAGE   (
            INITIAL    65536
            MINEXTENTS 1
            MAXEXTENTS 2147483645
           )
/

--------------------------------------------------------------------------------------------------------------------
-- CRIAÇÃO DO ÍNDICE: IFRMAXIMO.EQHIST_NDX2
--------------------------------------------------------------------------------------------------------------------
CREATE  INDEX IFRMAXIMO.EQHIST_NDX2 ON IFRMAXIMO.EQHISTORY (
EQNUM ASC)
PCTFREE    10
INITRANS   2
MAXTRANS   255
TABLESPACE TSI_MAXIMO
STORAGE   (
            INITIAL    65536
            MINEXTENTS 1
            MAXEXTENTS 2147483645
           )
/

--------------------------------------------------------------------------------------------------------------------
-- CRIAÇÃO DO ÍNDICE: IFRMAXIMO.EQSPEC_NDX1
--------------------------------------------------------------------------------------------------------------------
CREATE UNIQUE INDEX IFRMAXIMO.EQSPEC_NDX1 ON IFRMAXIMO.EQUIPMENTSPEC (
SITEID ASC,
EQNUM ASC,
ASSETATTRID ASC)
PCTFREE    10
INITRANS   2
MAXTRANS   255
TABLESPACE TSI_MAXIMO
STORAGE   (
            INITIAL    65536
            MINEXTENTS 1
            MAXEXTENTS 2147483645
           )
/

--------------------------------------------------------------------------------------------------------------------
-- CRIAÇÃO DO ÍNDICE: IFRMAXIMO.EQSPEC_NDX2
--------------------------------------------------------------------------------------------------------------------
CREATE  INDEX IFRMAXIMO.EQSPEC_NDX2 ON IFRMAXIMO.EQUIPMENTSPEC (
SITEID ASC,
CLASSSTRUCTUREID ASC,
ASSETATTRID ASC)
PCTFREE    10
INITRANS   2
MAXTRANS   255
TABLESPACE TSI_MAXIMO
STORAGE   (
            INITIAL    65536
            MINEXTENTS 1
            MAXEXTENTS 2147483645
           )
/

--------------------------------------------------------------------------------------------------------------------
-- CRIAÇÃO DO ÍNDICE: IFRMAXIMO.EQSPEC_NDX3
--------------------------------------------------------------------------------------------------------------------
CREATE  INDEX IFRMAXIMO.EQSPEC_NDX3 ON IFRMAXIMO.EQUIPMENTSPEC (
SITEID ASC,
ASSETATTRID ASC)
PCTFREE    10
INITRANS   2
MAXTRANS   255
TABLESPACE TSI_MAXIMO
STORAGE   (
            INITIAL    65536
            MINEXTENTS 1
            MAXEXTENTS 2147483645
           )
/

--------------------------------------------------------------------------------------------------------------------
-- CRIAÇÃO DO ÍNDICE: IFRMAXIMO.EQSTATUS_NDX1
--------------------------------------------------------------------------------------------------------------------
CREATE  INDEX IFRMAXIMO.EQSTATUS_NDX1 ON IFRMAXIMO.EQSTATUS (
SITEID ASC,
CHANGEDATE ASC)
PCTFREE    10
INITRANS   2
MAXTRANS   255
TABLESPACE TSI_MAXIMO
STORAGE   (
            INITIAL    65536
            MINEXTENTS 1
            MAXEXTENTS 2147483645
           )
/

--------------------------------------------------------------------------------------------------------------------
-- CRIAÇÃO DO ÍNDICE: IFRMAXIMO.EQSTATUS_NDX2
--------------------------------------------------------------------------------------------------------------------
CREATE  INDEX IFRMAXIMO.EQSTATUS_NDX2 ON IFRMAXIMO.EQSTATUS (
SITEID ASC,
EQNUM ASC)
PCTFREE    10
INITRANS   2
MAXTRANS   255
TABLESPACE TSI_MAXIMO
STORAGE   (
            INITIAL    65536
            MINEXTENTS 1
            MAXEXTENTS 2147483645
           )
/

--------------------------------------------------------------------------------------------------------------------
-- CRIAÇÃO DO ÍNDICE: IFRMAXIMO.EQSTATUS_NDX3
--------------------------------------------------------------------------------------------------------------------
CREATE  INDEX IFRMAXIMO.EQSTATUS_NDX3 ON IFRMAXIMO.EQSTATUS (
SITEID ASC,
ISRUNNING ASC)
PCTFREE    10
INITRANS   2
MAXTRANS   255
TABLESPACE TSI_MAXIMO
STORAGE   (
            INITIAL    65536
            MINEXTENTS 1
            MAXEXTENTS 2147483645
           )
/

--------------------------------------------------------------------------------------------------------------------
-- CRIAÇÃO DO ÍNDICE: IFRMAXIMO.EQSTATUS_NDX4
--------------------------------------------------------------------------------------------------------------------
CREATE  INDEX IFRMAXIMO.EQSTATUS_NDX4 ON IFRMAXIMO.EQSTATUS (
SITEID ASC,
WONUM ASC)
PCTFREE    10
INITRANS   2
MAXTRANS   255
TABLESPACE TSI_MAXIMO
STORAGE   (
            INITIAL    65536
            MINEXTENTS 1
            MAXEXTENTS 2147483645
           )
/

--------------------------------------------------------------------------------------------------------------------
-- CRIAÇÃO DO ÍNDICE: IFRMAXIMO.EQTRANS_NDX1
--------------------------------------------------------------------------------------------------------------------
CREATE  INDEX IFRMAXIMO.EQTRANS_NDX1 ON IFRMAXIMO.EQTRANS (
SITEID ASC,
TRANSDATE ASC)
PCTFREE    10
INITRANS   2
MAXTRANS   255
TABLESPACE TSI_MAXIMO
STORAGE   (
            INITIAL    65536
            MINEXTENTS 1
            MAXEXTENTS 2147483645
           )
/

--------------------------------------------------------------------------------------------------------------------
-- CRIAÇÃO DO ÍNDICE: IFRMAXIMO.EQTRANS_NDX2
--------------------------------------------------------------------------------------------------------------------
CREATE  INDEX IFRMAXIMO.EQTRANS_NDX2 ON IFRMAXIMO.EQTRANS (
SITEID ASC,
EQNUM ASC)
PCTFREE    10
INITRANS   2
MAXTRANS   255
TABLESPACE TSI_MAXIMO
STORAGE   (
            INITIAL    65536
            MINEXTENTS 1
            MAXEXTENTS 2147483645
           )
/

--------------------------------------------------------------------------------------------------------------------
-- CRIAÇÃO DO ÍNDICE: IFRMAXIMO.EQUIPMENT_NDX1
--------------------------------------------------------------------------------------------------------------------
CREATE UNIQUE INDEX IFRMAXIMO.EQUIPMENT_NDX1 ON IFRMAXIMO.EQUIPMENT (
SITEID ASC,
EQNUM ASC)
PCTFREE    10
INITRANS   2
MAXTRANS   255
TABLESPACE TSI_MAXIMO
STORAGE   (
            INITIAL    65536
            MINEXTENTS 1
            MAXEXTENTS 2147483645
           )
/

--------------------------------------------------------------------------------------------------------------------
-- CRIAÇÃO DO ÍNDICE: IFRMAXIMO.EQUIPMENT_NDX2
--------------------------------------------------------------------------------------------------------------------
CREATE  INDEX IFRMAXIMO.EQUIPMENT_NDX2 ON IFRMAXIMO.EQUIPMENT (
SITEID ASC,
PARENT ASC)
PCTFREE    10
INITRANS   2
MAXTRANS   255
TABLESPACE TSI_MAXIMO
STORAGE   (
            INITIAL    65536
            MINEXTENTS 1
            MAXEXTENTS 2147483645
           )
/

--------------------------------------------------------------------------------------------------------------------
-- CRIAÇÃO DO ÍNDICE: IFRMAXIMO.EQUIPMENT_NDX3
--------------------------------------------------------------------------------------------------------------------
CREATE  INDEX IFRMAXIMO.EQUIPMENT_NDX3 ON IFRMAXIMO.EQUIPMENT (
SITEID ASC,
VENDOR ASC)
PCTFREE    10
INITRANS   2
MAXTRANS   255
TABLESPACE TSI_MAXIMO
STORAGE   (
            INITIAL    65536
            MINEXTENTS 1
            MAXEXTENTS 2147483645
           )
/

--------------------------------------------------------------------------------------------------------------------
-- CRIAÇÃO DO ÍNDICE: IFRMAXIMO.EQUIPMENT_NDX4
--------------------------------------------------------------------------------------------------------------------
CREATE  INDEX IFRMAXIMO.EQUIPMENT_NDX4 ON IFRMAXIMO.EQUIPMENT (
SITEID ASC,
CALNUM ASC)
PCTFREE    10
INITRANS   2
MAXTRANS   255
TABLESPACE TSI_MAXIMO
STORAGE   (
            INITIAL    65536
            MINEXTENTS 1
            MAXEXTENTS 2147483645
           )
/

--------------------------------------------------------------------------------------------------------------------
-- CRIAÇÃO DO ÍNDICE: IFRMAXIMO.EQUIPMENT_NDX5
--------------------------------------------------------------------------------------------------------------------
CREATE  INDEX IFRMAXIMO.EQUIPMENT_NDX5 ON IFRMAXIMO.EQUIPMENT (
SITEID ASC,
ITEMNUM ASC)
PCTFREE    10
INITRANS   2
MAXTRANS   255
TABLESPACE TSI_MAXIMO
STORAGE   (
            INITIAL    65536
            MINEXTENTS 1
            MAXEXTENTS 2147483645
           )
/

--------------------------------------------------------------------------------------------------------------------
-- CRIAÇÃO DO ÍNDICE: IFRMAXIMO.EQUIPMENT_NDX6
--------------------------------------------------------------------------------------------------------------------
CREATE  INDEX IFRMAXIMO.EQUIPMENT_NDX6 ON IFRMAXIMO.EQUIPMENT (
SITEID ASC,
LOCATION ASC)
PCTFREE    10
INITRANS   2
MAXTRANS   255
TABLESPACE TSI_MAXIMO
STORAGE   (
            INITIAL    65536
            MINEXTENTS 1
            MAXEXTENTS 2147483645
           )
/

--------------------------------------------------------------------------------------------------------------------
-- CRIAÇÃO DO ÍNDICE: IFRMAXIMO.EXCHANGE_NDX
--------------------------------------------------------------------------------------------------------------------
CREATE UNIQUE INDEX IFRMAXIMO.EXCHANGE_NDX ON IFRMAXIMO.EXCHANGE (
ORGID ASC,
CURRENCYCODE ASC,
CURRENCYCODETO ASC,
EXPIREDATE ASC)
PCTFREE    10
INITRANS   2
MAXTRANS   255
TABLESPACE TSI_MAXIMO
STORAGE   (
            INITIAL    65536
            MINEXTENTS 1
            MAXEXTENTS 2147483645
           )
/

--------------------------------------------------------------------------------------------------------------------
-- CRIAÇÃO DO ÍNDICE: IFRMAXIMO.FAILLIST_NDX
--------------------------------------------------------------------------------------------------------------------
CREATE UNIQUE INDEX IFRMAXIMO.FAILLIST_NDX ON IFRMAXIMO.FAILURELIST (
ORGID ASC,
FAILURELIST ASC)
PCTFREE    10
INITRANS   2
MAXTRANS   255
TABLESPACE TSI_MAXIMO
STORAGE   (
            INITIAL    65536
            MINEXTENTS 1
            MAXEXTENTS 2147483645
           )
/

--------------------------------------------------------------------------------------------------------------------
-- CRIAÇÃO DO ÍNDICE: IFRMAXIMO.FAILLIST_NDX2
--------------------------------------------------------------------------------------------------------------------
CREATE  INDEX IFRMAXIMO.FAILLIST_NDX2 ON IFRMAXIMO.FAILURELIST (
ORGID ASC,
FAILURECODE ASC)
PCTFREE    10
INITRANS   2
MAXTRANS   255
TABLESPACE TSI_MAXIMO
STORAGE   (
            INITIAL    65536
            MINEXTENTS 1
            MAXEXTENTS 2147483645
           )
/

--------------------------------------------------------------------------------------------------------------------
-- CRIAÇÃO DO ÍNDICE: IFRMAXIMO.FAILLIST_NDX3
--------------------------------------------------------------------------------------------------------------------
CREATE  INDEX IFRMAXIMO.FAILLIST_NDX3 ON IFRMAXIMO.FAILURELIST (
ORGID ASC,
PARENT ASC)
PCTFREE    10
INITRANS   2
MAXTRANS   255
TABLESPACE TSI_MAXIMO
STORAGE   (
            INITIAL    65536
            MINEXTENTS 1
            MAXEXTENTS 2147483645
           )
/

--------------------------------------------------------------------------------------------------------------------
-- CRIAÇÃO DO ÍNDICE: IFRMAXIMO.FAILREMARK_NDX
--------------------------------------------------------------------------------------------------------------------
CREATE UNIQUE INDEX IFRMAXIMO.FAILREMARK_NDX ON IFRMAXIMO.FAILUREREMARK (
SITEID ASC,
WONUM ASC)
PCTFREE    10
INITRANS   2
MAXTRANS   255
TABLESPACE TSI_MAXIMO
STORAGE   (
            INITIAL    65536
            MINEXTENTS 1
            MAXEXTENTS 2147483645
           )
/

--------------------------------------------------------------------------------------------------------------------
-- CRIAÇÃO DO ÍNDICE: IFRMAXIMO.FAILREPORT_NDX1
--------------------------------------------------------------------------------------------------------------------
CREATE  INDEX IFRMAXIMO.FAILREPORT_NDX1 ON IFRMAXIMO.FAILUREREPORT (
SITEID ASC,
WONUM ASC)
PCTFREE    10
INITRANS   2
MAXTRANS   255
TABLESPACE TSI_MAXIMO
STORAGE   (
            INITIAL    65536
            MINEXTENTS 1
            MAXEXTENTS 2147483645
           )
/

--------------------------------------------------------------------------------------------------------------------
-- CRIAÇÃO DO ÍNDICE: IFRMAXIMO.FAILREPORT_NDX2
--------------------------------------------------------------------------------------------------------------------
CREATE  INDEX IFRMAXIMO.FAILREPORT_NDX2 ON IFRMAXIMO.FAILUREREPORT (
SITEID ASC,
LINENUM ASC)
PCTFREE    10
INITRANS   2
MAXTRANS   255
TABLESPACE TSI_MAXIMO
STORAGE   (
            INITIAL    65536
            MINEXTENTS 1
            MAXEXTENTS 2147483645
           )
/

--------------------------------------------------------------------------------------------------------------------
-- CRIAÇÃO DO ÍNDICE: IFRMAXIMO.FAILURECODE_NDX
--------------------------------------------------------------------------------------------------------------------
CREATE UNIQUE INDEX IFRMAXIMO.FAILURECODE_NDX ON IFRMAXIMO.FAILURECODE (
ORGID ASC,
FAILURECODE ASC)
PCTFREE    10
INITRANS   2
MAXTRANS   255
TABLESPACE TSI_MAXIMO
STORAGE   (
            INITIAL    65536
            MINEXTENTS 1
            MAXEXTENTS 2147483645
           )
/

--------------------------------------------------------------------------------------------------------------------
-- CRIAÇÃO DO ÍNDICE: IFRMAXIMO.FIELDDEFAULTS_NDX
--------------------------------------------------------------------------------------------------------------------
CREATE UNIQUE INDEX IFRMAXIMO.FIELDDEFAULTS_NDX ON IFRMAXIMO.FIELDDEFAULTS (
GRPNAME ASC,
APP ASC,
SCREEN ASC,
FIELD ASC)
PCTFREE    10
INITRANS   2
MAXTRANS   255
TABLESPACE TSI_MAXIMO
STORAGE   (
            INITIAL    65536
            MINEXTENTS 1
            MAXEXTENTS 2147483645
           )
/

--------------------------------------------------------------------------------------------------------------------
-- CRIAÇÃO DO ÍNDICE: IFRMAXIMO.FINCNTRL_NDX1
--------------------------------------------------------------------------------------------------------------------
CREATE UNIQUE INDEX IFRMAXIMO.FINCNTRL_NDX1 ON IFRMAXIMO.FINCNTRL (
ORGID ASC,
FINCNTRLID ASC)
PCTFREE    10
INITRANS   2
MAXTRANS   255
TABLESPACE TSI_MAXIMO
STORAGE   (
            INITIAL    65536
            MINEXTENTS 1
            MAXEXTENTS 2147483645
           )
/

--------------------------------------------------------------------------------------------------------------------
-- CRIAÇÃO DO ÍNDICE: IFRMAXIMO.FINCNTRL_NDX2
--------------------------------------------------------------------------------------------------------------------
CREATE  INDEX IFRMAXIMO.FINCNTRL_NDX2 ON IFRMAXIMO.FINCNTRL (
ORGID ASC,
BUDGETID ASC,
BUDGETLINEID ASC,
PROJECTID ASC,
TASKID ASC)
PCTFREE    10
INITRANS   2
MAXTRANS   255
TABLESPACE TSI_MAXIMO
STORAGE   (
            INITIAL    65536
            MINEXTENTS 1
            MAXEXTENTS 2147483645
           )
/

--------------------------------------------------------------------------------------------------------------------
-- CRIAÇÃO DO ÍNDICE: IFRMAXIMO.FPERIOD_NDX1
--------------------------------------------------------------------------------------------------------------------
CREATE UNIQUE INDEX IFRMAXIMO.FPERIOD_NDX1 ON IFRMAXIMO.FINANCIALPERIODS (
ORGID ASC,
FINANCIALPERIOD ASC)
PCTFREE    10
INITRANS   2
MAXTRANS   255
TABLESPACE TSI_MAXIMO
STORAGE   (
            INITIAL    65536
            MINEXTENTS 1
            MAXEXTENTS 2147483645
           )
/

--------------------------------------------------------------------------------------------------------------------
-- CRIAÇÃO DO ÍNDICE: IFRMAXIMO.FPERIOD_NDX2
--------------------------------------------------------------------------------------------------------------------
CREATE  INDEX IFRMAXIMO.FPERIOD_NDX2 ON IFRMAXIMO.FINANCIALPERIODS (
ORGID ASC,
PERIODSTART ASC,
PERIODEND ASC,
PERIODCLOSEDATE ASC)
PCTFREE    10
INITRANS   2
MAXTRANS   255
TABLESPACE TSI_MAXIMO
STORAGE   (
            INITIAL    65536
            MINEXTENTS 1
            MAXEXTENTS 2147483645
           )
/

--------------------------------------------------------------------------------------------------------------------
-- CRIAÇÃO DO ÍNDICE: IFRMAXIMO.GLCFG_NDX1
--------------------------------------------------------------------------------------------------------------------
CREATE UNIQUE INDEX IFRMAXIMO.GLCFG_NDX1 ON IFRMAXIMO.GLCONFIGURE (
GLORDER ASC)
PCTFREE    10
INITRANS   2
MAXTRANS   255
TABLESPACE TSI_MAXIMO
STORAGE   (
            INITIAL    40960
            MINEXTENTS 1
            MAXEXTENTS 2147483645
           )
/

--------------------------------------------------------------------------------------------------------------------
-- CRIAÇÃO DO ÍNDICE: IFRMAXIMO.GLCOMP_NDX1
--------------------------------------------------------------------------------------------------------------------
CREATE UNIQUE INDEX IFRMAXIMO.GLCOMP_NDX1 ON IFRMAXIMO.GLCOMPONENTS (
ORGID ASC,
GLORDER ASC,
COMPVALUE ASC)
PCTFREE    10
INITRANS   2
MAXTRANS   255
TABLESPACE TSI_MAXIMO
STORAGE   (
            INITIAL    65536
            MINEXTENTS 1
            MAXEXTENTS 2147483645
           )
/

--------------------------------------------------------------------------------------------------------------------
-- CRIAÇÃO DO ÍNDICE: IFRMAXIMO.GLCOMP_NDX2
--------------------------------------------------------------------------------------------------------------------
CREATE  INDEX IFRMAXIMO.GLCOMP_NDX2 ON IFRMAXIMO.GLCOMPONENTS (
ORGID ASC,
INTERID ASC)
PCTFREE    10
INITRANS   2
MAXTRANS   255
TABLESPACE TSI_MAXIMO
STORAGE   (
            INITIAL    65536
            MINEXTENTS 1
            MAXEXTENTS 2147483645
           )
/

--------------------------------------------------------------------------------------------------------------------
-- CRIAÇÃO DO ÍNDICE: IFRMAXIMO.GROUPRESTR_NDX1
--------------------------------------------------------------------------------------------------------------------
CREATE UNIQUE INDEX IFRMAXIMO.GROUPRESTR_NDX1 ON IFRMAXIMO.GROUPRESTRICTION (
ORGID ASC,
GRPNAME ASC,
TBNAME ASC)
PCTFREE    10
INITRANS   2
MAXTRANS   255
TABLESPACE TSI_MAXIMO
STORAGE   (
            INITIAL    65536
            MINEXTENTS 1
            MAXEXTENTS 2147483645
           )
/

--------------------------------------------------------------------------------------------------------------------
-- CRIAÇÃO DO ÍNDICE: IFRMAXIMO.HAZARD_NDX1
--------------------------------------------------------------------------------------------------------------------
CREATE UNIQUE INDEX IFRMAXIMO.HAZARD_NDX1 ON IFRMAXIMO.HAZARD (
ORGID ASC,
HAZARDID ASC)
PCTFREE    10
INITRANS   2
MAXTRANS   255
TABLESPACE TSI_MAXIMO
STORAGE   (
            INITIAL    65536
            MINEXTENTS 1
            MAXEXTENTS 2147483645
           )
/

--------------------------------------------------------------------------------------------------------------------
-- CRIAÇÃO DO ÍNDICE: IFRMAXIMO.HAZARDPREC_NDX1
--------------------------------------------------------------------------------------------------------------------
CREATE UNIQUE INDEX IFRMAXIMO.HAZARDPREC_NDX1 ON IFRMAXIMO.HAZARDPREC (
SITEID ASC,
HAZARDID ASC,
PRECAUTIONID ASC)
PCTFREE    10
INITRANS   2
MAXTRANS   255
TABLESPACE TSI_MAXIMO
STORAGE   (
            INITIAL    65536
            MINEXTENTS 1
            MAXEXTENTS 2147483645
           )
/

--------------------------------------------------------------------------------------------------------------------
-- CRIAÇÃO DO ÍNDICE: IFRMAXIMO.HH_MES_CAR_OCUP_UK
--------------------------------------------------------------------------------------------------------------------
CREATE UNIQUE INDEX IFRMAXIMO.HH_MES_CAR_OCUP_UK ON IFRMAXIMO.HOMEM_HORA (
MES_ANO ASC,
CARGO ASC,
OCUPACAO ASC)
PCTFREE    10
INITRANS   2
MAXTRANS   255
TABLESPACE TSI_MAXIMO
STORAGE   (
            INITIAL    81920
            MINEXTENTS 1
            MAXEXTENTS 2147483645
           )
/

--------------------------------------------------------------------------------------------------------------------
-- CRIAÇÃO DO ÍNDICE: IFRMAXIMO.HOLIDAY_NDX1
--------------------------------------------------------------------------------------------------------------------
CREATE  INDEX IFRMAXIMO.HOLIDAY_NDX1 ON IFRMAXIMO.HOLIDAY (
ORGID ASC,
HOLIDAYDATE ASC)
PCTFREE    10
INITRANS   2
MAXTRANS   255
TABLESPACE TSI_MAXIMO
STORAGE   (
            INITIAL    65536
            MINEXTENTS 1
            MAXEXTENTS 2147483645
           )
/

--------------------------------------------------------------------------------------------------------------------
-- CRIAÇÃO DO ÍNDICE: IFRMAXIMO.IDX_TEMP
--------------------------------------------------------------------------------------------------------------------
CREATE  INDEX IFRMAXIMO.IDX_TEMP ON IFRMAXIMO.MATUSETRANS (
REFWO ASC,
ITEMNUM ASC,
STORELOC ASC,
TRANSDATE ASC)
PCTFREE    10
INITRANS   2
MAXTRANS   255
TABLESPACE TSI_MAXIMO
STORAGE   (
            INITIAL    65536
            MINEXTENTS 1
            MAXEXTENTS 2147483645
           )
/

--------------------------------------------------------------------------------------------------------------------
-- CRIAÇÃO DO ÍNDICE: IFRMAXIMO.INVBAL_NDX1
--------------------------------------------------------------------------------------------------------------------
CREATE UNIQUE INDEX IFRMAXIMO.INVBAL_NDX1 ON IFRMAXIMO.INVBALANCES (
SITEID ASC,
ITEMNUM ASC,
LOCATION ASC,
BINNUM ASC,
LOTNUM ASC)
PCTFREE    10
INITRANS   2
MAXTRANS   255
TABLESPACE TSI_MAXIMO
STORAGE   (
            INITIAL    65536
            MINEXTENTS 1
            MAXEXTENTS 2147483645
           )
/

--------------------------------------------------------------------------------------------------------------------
-- CRIAÇÃO DO ÍNDICE: IFRMAXIMO.INVBAL_NDX2
--------------------------------------------------------------------------------------------------------------------
CREATE  INDEX IFRMAXIMO.INVBAL_NDX2 ON IFRMAXIMO.INVBALANCES (
SITEID ASC,
INTERID ASC)
PCTFREE    10
INITRANS   2
MAXTRANS   255
TABLESPACE TSI_MAXIMO
STORAGE   (
            INITIAL    65536
            MINEXTENTS 1
            MAXEXTENTS 2147483645
           )
/

--------------------------------------------------------------------------------------------------------------------
-- CRIAÇÃO DO ÍNDICE: IFRMAXIMO.INVENTORY_NDX1
--------------------------------------------------------------------------------------------------------------------
CREATE UNIQUE INDEX IFRMAXIMO.INVENTORY_NDX1 ON IFRMAXIMO.INVENTORY (
SITEID ASC,
ITEMNUM ASC,
LOCATION ASC)
PCTFREE    10
INITRANS   2
MAXTRANS   255
TABLESPACE TSI_MAXIMO
STORAGE   (
            INITIAL    65536
            MINEXTENTS 1
            MAXEXTENTS 2147483645
           )
/

--------------------------------------------------------------------------------------------------------------------
-- CRIAÇÃO DO ÍNDICE: IFRMAXIMO.INVENTORY_NDX2
--------------------------------------------------------------------------------------------------------------------
CREATE  INDEX IFRMAXIMO.INVENTORY_NDX2 ON IFRMAXIMO.INVENTORY (
SITEID ASC,
LOCATION ASC)
PCTFREE    10
INITRANS   2
MAXTRANS   255
TABLESPACE TSI_MAXIMO
STORAGE   (
            INITIAL    65536
            MINEXTENTS 1
            MAXEXTENTS 2147483645
           )
/

--------------------------------------------------------------------------------------------------------------------
-- CRIAÇÃO DO ÍNDICE: IFRMAXIMO.INVENTORY_NDX3
--------------------------------------------------------------------------------------------------------------------
CREATE  INDEX IFRMAXIMO.INVENTORY_NDX3 ON IFRMAXIMO.INVENTORY (
SITEID ASC,
INTERID ASC)
PCTFREE    10
INITRANS   2
MAXTRANS   255
TABLESPACE TSI_MAXIMO
STORAGE   (
            INITIAL    65536
            MINEXTENTS 1
            MAXEXTENTS 2147483645
           )
/

--------------------------------------------------------------------------------------------------------------------
-- CRIAÇÃO DO ÍNDICE: IFRMAXIMO.INVLOT_NDX1
--------------------------------------------------------------------------------------------------------------------
CREATE UNIQUE INDEX IFRMAXIMO.INVLOT_NDX1 ON IFRMAXIMO.INVLOT (
SITEID ASC,
LOTNUM ASC)
PCTFREE    10
INITRANS   2
MAXTRANS   255
TABLESPACE TSI_MAXIMO
STORAGE   (
            INITIAL    65536
            MINEXTENTS 1
            MAXEXTENTS 2147483645
           )
/

--------------------------------------------------------------------------------------------------------------------
-- CRIAÇÃO DO ÍNDICE: IFRMAXIMO.INVOICECOST_NDX1
--------------------------------------------------------------------------------------------------------------------
CREATE UNIQUE INDEX IFRMAXIMO.INVOICECOST_NDX1 ON IFRMAXIMO.INVOICECOST (
SITEID ASC,
INVOICENUM ASC,
INVOICELINENUM ASC,
COSTLINENUM ASC)
PCTFREE    10
INITRANS   2
MAXTRANS   255
TABLESPACE TSI_MAXIMO
STORAGE   (
            INITIAL    65536
            MINEXTENTS 1
            MAXEXTENTS 2147483645
           )
/

--------------------------------------------------------------------------------------------------------------------
-- CRIAÇÃO DO ÍNDICE: IFRMAXIMO.INVOICELINE_NDX1
--------------------------------------------------------------------------------------------------------------------
CREATE UNIQUE INDEX IFRMAXIMO.INVOICELINE_NDX1 ON IFRMAXIMO.INVOICELINE (
SITEID ASC,
INVOICENUM ASC,
INVOICELINENUM ASC)
PCTFREE    10
INITRANS   2
MAXTRANS   255
TABLESPACE TSI_MAXIMO
STORAGE   (
            INITIAL    65536
            MINEXTENTS 1
            MAXEXTENTS 2147483645
           )
/

--------------------------------------------------------------------------------------------------------------------
-- CRIAÇÃO DO ÍNDICE: IFRMAXIMO.INVOICELINE_NDX2
--------------------------------------------------------------------------------------------------------------------
CREATE  INDEX IFRMAXIMO.INVOICELINE_NDX2 ON IFRMAXIMO.INVOICELINE (
SERVICE ASC,
INVOICENUM ASC,
ITEMNUM ASC)
PCTFREE    10
INITRANS   2
MAXTRANS   255
TABLESPACE TSI_MAXIMO
STORAGE   (
            INITIAL    65536
            MINEXTENTS 1
            MAXEXTENTS 2147483645
           )
/

--------------------------------------------------------------------------------------------------------------------
-- CRIAÇÃO DO ÍNDICE: IFRMAXIMO.INVOICELINE_NDX3
--------------------------------------------------------------------------------------------------------------------
CREATE  INDEX IFRMAXIMO.INVOICELINE_NDX3 ON IFRMAXIMO.INVOICELINE (
SITEID ASC,
INVOICENUM ASC,
PONUM ASC)
PCTFREE    10
INITRANS   2
MAXTRANS   255
TABLESPACE TSI_MAXIMO
STORAGE   (
            INITIAL    65536
            MINEXTENTS 1
            MAXEXTENTS 2147483645
           )
/

--------------------------------------------------------------------------------------------------------------------
-- CRIAÇÃO DO ÍNDICE: IFRMAXIMO.INVOICELINE_NDX4
--------------------------------------------------------------------------------------------------------------------
CREATE  INDEX IFRMAXIMO.INVOICELINE_NDX4 ON IFRMAXIMO.INVOICELINE (
SITEID ASC,
PONUM ASC,
ITEMNUM ASC)
PCTFREE    10
INITRANS   2
MAXTRANS   255
TABLESPACE TSI_MAXIMO
STORAGE   (
            INITIAL    65536
            MINEXTENTS 1
            MAXEXTENTS 2147483645
           )
/

--------------------------------------------------------------------------------------------------------------------
-- CRIAÇÃO DO ÍNDICE: IFRMAXIMO.INVOICELINE_NDX6
--------------------------------------------------------------------------------------------------------------------
CREATE  INDEX IFRMAXIMO.INVOICELINE_NDX6 ON IFRMAXIMO.INVOICELINE (
INVOICENUM ASC,
ITEMNUM ASC)
PCTFREE    10
INITRANS   2
MAXTRANS   255
TABLESPACE TSI_MAXIMO
STORAGE   (
            INITIAL    65536
            MINEXTENTS 1
            MAXEXTENTS 2147483645
           )
/

--------------------------------------------------------------------------------------------------------------------
-- CRIAÇÃO DO ÍNDICE: IFRMAXIMO.INVOICELINE_NDX7
--------------------------------------------------------------------------------------------------------------------
CREATE  INDEX IFRMAXIMO.INVOICELINE_NDX7 ON IFRMAXIMO.INVOICELINE (
INVOICENUM ASC,
PONUM ASC)
PCTFREE    10
INITRANS   2
MAXTRANS   255
TABLESPACE TSI_MAXIMO
STORAGE   (
            INITIAL    65536
            MINEXTENTS 1
            MAXEXTENTS 2147483645
           )
/

--------------------------------------------------------------------------------------------------------------------
-- CRIAÇÃO DO ÍNDICE: IFRMAXIMO.INVOICELINE_NDX8
--------------------------------------------------------------------------------------------------------------------
CREATE  INDEX IFRMAXIMO.INVOICELINE_NDX8 ON IFRMAXIMO.INVOICELINE (
PONUM ASC,
ITEMNUM ASC)
PCTFREE    10
INITRANS   2
MAXTRANS   255
TABLESPACE TSI_MAXIMO
STORAGE   (
            INITIAL    65536
            MINEXTENTS 1
            MAXEXTENTS 2147483645
           )
/

--------------------------------------------------------------------------------------------------------------------
-- CRIAÇÃO DO ÍNDICE: IFRMAXIMO.INVOICEMTCH_NDX1
--------------------------------------------------------------------------------------------------------------------
CREATE  INDEX IFRMAXIMO.INVOICEMTCH_NDX1 ON IFRMAXIMO.INVOICEMATCH (
SITEID ASC,
INVOICENUM ASC,
INVOICELINENUM ASC)
PCTFREE    10
INITRANS   2
MAXTRANS   255
TABLESPACE TSI_MAXIMO
STORAGE   (
            INITIAL    65536
            MINEXTENTS 1
            MAXEXTENTS 2147483645
           )
/

--------------------------------------------------------------------------------------------------------------------
-- CRIAÇÃO DO ÍNDICE: IFRMAXIMO.INVOICEMTCH_NDX2
--------------------------------------------------------------------------------------------------------------------
CREATE  INDEX IFRMAXIMO.INVOICEMTCH_NDX2 ON IFRMAXIMO.INVOICEMATCH (
SITEID ASC,
PONUM ASC,
POLINENUM ASC)
PCTFREE    10
INITRANS   2
MAXTRANS   255
TABLESPACE TSI_MAXIMO
STORAGE   (
            INITIAL    65536
            MINEXTENTS 1
            MAXEXTENTS 2147483645
           )
/

--------------------------------------------------------------------------------------------------------------------
-- CRIAÇÃO DO ÍNDICE: IFRMAXIMO.INVOICE_NDX1
--------------------------------------------------------------------------------------------------------------------
CREATE UNIQUE INDEX IFRMAXIMO.INVOICE_NDX1 ON IFRMAXIMO.INVOICE (
SITEID ASC,
INVOICENUM ASC)
PCTFREE    10
INITRANS   2
MAXTRANS   255
TABLESPACE TSI_MAXIMO
STORAGE   (
            INITIAL    65536
            MINEXTENTS 1
            MAXEXTENTS 2147483645
           )
/

--------------------------------------------------------------------------------------------------------------------
-- CRIAÇÃO DO ÍNDICE: IFRMAXIMO.INVOICE_NDX2
--------------------------------------------------------------------------------------------------------------------
CREATE  INDEX IFRMAXIMO.INVOICE_NDX2 ON IFRMAXIMO.INVOICE (
SITEID ASC,
VENDOR ASC)
PCTFREE    10
INITRANS   2
MAXTRANS   255
TABLESPACE TSI_MAXIMO
STORAGE   (
            INITIAL    65536
            MINEXTENTS 1
            MAXEXTENTS 2147483645
           )
/

--------------------------------------------------------------------------------------------------------------------
-- CRIAÇÃO DO ÍNDICE: IFRMAXIMO.INVOICE_NDX3
--------------------------------------------------------------------------------------------------------------------
CREATE  INDEX IFRMAXIMO.INVOICE_NDX3 ON IFRMAXIMO.INVOICE (
SITEID ASC,
PONUM ASC)
PCTFREE    10
INITRANS   2
MAXTRANS   255
TABLESPACE TSI_MAXIMO
STORAGE   (
            INITIAL    65536
            MINEXTENTS 1
            MAXEXTENTS 2147483645
           )
/

--------------------------------------------------------------------------------------------------------------------
-- CRIAÇÃO DO ÍNDICE: IFRMAXIMO.INVOICE_NDX4
--------------------------------------------------------------------------------------------------------------------
CREATE  INDEX IFRMAXIMO.INVOICE_NDX4 ON IFRMAXIMO.INVOICE (
SITEID ASC,
APPROVALNUM ASC)
PCTFREE    10
INITRANS   2
MAXTRANS   255
TABLESPACE TSI_MAXIMO
STORAGE   (
            INITIAL    65536
            MINEXTENTS 1
            MAXEXTENTS 2147483645
           )
/

--------------------------------------------------------------------------------------------------------------------
-- CRIAÇÃO DO ÍNDICE: IFRMAXIMO.INVOICE_NDX5
--------------------------------------------------------------------------------------------------------------------
CREATE  INDEX IFRMAXIMO.INVOICE_NDX5 ON IFRMAXIMO.INVOICE (
SITEID ASC,
VENDORINVOICENUM ASC,
VENDOR ASC)
PCTFREE    10
INITRANS   2
MAXTRANS   255
TABLESPACE TSI_MAXIMO
STORAGE   (
            INITIAL    65536
            MINEXTENTS 1
            MAXEXTENTS 2147483645
           )
/

--------------------------------------------------------------------------------------------------------------------
-- CRIAÇÃO DO ÍNDICE: IFRMAXIMO.INVOICE_NDX6
--------------------------------------------------------------------------------------------------------------------
CREATE  INDEX IFRMAXIMO.INVOICE_NDX6 ON IFRMAXIMO.INVOICE (
SITEID ASC,
INTERID ASC)
PCTFREE    10
INITRANS   2
MAXTRANS   255
TABLESPACE TSI_MAXIMO
STORAGE   (
            INITIAL    65536
            MINEXTENTS 1
            MAXEXTENTS 2147483645
           )
/

--------------------------------------------------------------------------------------------------------------------
-- CRIAÇÃO DO ÍNDICE: IFRMAXIMO.INVOICE_NDX7
--------------------------------------------------------------------------------------------------------------------
CREATE  INDEX IFRMAXIMO.INVOICE_NDX7 ON IFRMAXIMO.INVOICE (
SITEID ASC,
WFID ASC)
PCTFREE    10
INITRANS   2
MAXTRANS   255
TABLESPACE TSI_MAXIMO
STORAGE   (
            INITIAL    65536
            MINEXTENTS 1
            MAXEXTENTS 2147483645
           )
/

--------------------------------------------------------------------------------------------------------------------
-- CRIAÇÃO DO ÍNDICE: IFRMAXIMO.INVOICESTATUS_NDX1
--------------------------------------------------------------------------------------------------------------------
CREATE  INDEX IFRMAXIMO.INVOICESTATUS_NDX1 ON IFRMAXIMO.INVOICESTATUS (
SITEID ASC,
INVOICENUM ASC,
VENDOR ASC)
PCTFREE    10
INITRANS   2
MAXTRANS   255
TABLESPACE TSI_MAXIMO
STORAGE   (
            INITIAL    65536
            MINEXTENTS 1
            MAXEXTENTS 2147483645
           )
/

--------------------------------------------------------------------------------------------------------------------
-- CRIAÇÃO DO ÍNDICE: IFRMAXIMO.INVOICESTATUS_NDX2
--------------------------------------------------------------------------------------------------------------------
CREATE  INDEX IFRMAXIMO.INVOICESTATUS_NDX2 ON IFRMAXIMO.INVOICESTATUS (
SITEID ASC,
CHANGEDATE ASC)
PCTFREE    10
INITRANS   2
MAXTRANS   255
TABLESPACE TSI_MAXIMO
STORAGE   (
            INITIAL    65536
            MINEXTENTS 1
            MAXEXTENTS 2147483645
           )
/

--------------------------------------------------------------------------------------------------------------------
-- CRIAÇÃO DO ÍNDICE: IFRMAXIMO.INVOICETRANS_NDX1
--------------------------------------------------------------------------------------------------------------------
CREATE  INDEX IFRMAXIMO.INVOICETRANS_NDX1 ON IFRMAXIMO.INVOICETRANS (
SITEID ASC,
TRANSDATE ASC)
PCTFREE    10
INITRANS   2
MAXTRANS   255
TABLESPACE TSI_MAXIMO
STORAGE   (
            INITIAL    65536
            MINEXTENTS 1
            MAXEXTENTS 2147483645
           )
/

--------------------------------------------------------------------------------------------------------------------
-- CRIAÇÃO DO ÍNDICE: IFRMAXIMO.INVOICETRANS_NDX2
--------------------------------------------------------------------------------------------------------------------
CREATE  INDEX IFRMAXIMO.INVOICETRANS_NDX2 ON IFRMAXIMO.INVOICETRANS (
SITEID ASC,
INTERID ASC)
PCTFREE    10
INITRANS   2
MAXTRANS   255
TABLESPACE TSI_MAXIMO
STORAGE   (
            INITIAL    65536
            MINEXTENTS 1
            MAXEXTENTS 2147483645
           )
/

--------------------------------------------------------------------------------------------------------------------
-- CRIAÇÃO DO ÍNDICE: IFRMAXIMO.INVRESERVE_NDX1
--------------------------------------------------------------------------------------------------------------------
CREATE UNIQUE INDEX IFRMAXIMO.INVRESERVE_NDX1 ON IFRMAXIMO.INVRESERVE (
SITEID ASC,
REQUESTNUM ASC)
PCTFREE    10
INITRANS   2
MAXTRANS   255
TABLESPACE TSI_MAXIMO
STORAGE   (
            INITIAL    65536
            MINEXTENTS 1
            MAXEXTENTS 2147483645
           )
/

--------------------------------------------------------------------------------------------------------------------
-- CRIAÇÃO DO ÍNDICE: IFRMAXIMO.INVRESERVE_NDX2
--------------------------------------------------------------------------------------------------------------------
CREATE  INDEX IFRMAXIMO.INVRESERVE_NDX2 ON IFRMAXIMO.INVRESERVE (
SITEID ASC,
ITEMNUM ASC,
LOCATION ASC)
PCTFREE    10
INITRANS   2
MAXTRANS   255
TABLESPACE TSI_MAXIMO
STORAGE   (
            INITIAL    65536
            MINEXTENTS 1
            MAXEXTENTS 2147483645
           )
/

--------------------------------------------------------------------------------------------------------------------
-- CRIAÇÃO DO ÍNDICE: IFRMAXIMO.INVRESERVE_NDX3
--------------------------------------------------------------------------------------------------------------------
CREATE  INDEX IFRMAXIMO.INVRESERVE_NDX3 ON IFRMAXIMO.INVRESERVE (
SITEID ASC,
WONUM ASC)
PCTFREE    10
INITRANS   2
MAXTRANS   255
TABLESPACE TSI_MAXIMO
STORAGE   (
            INITIAL    65536
            MINEXTENTS 1
            MAXEXTENTS 2147483645
           )
/

--------------------------------------------------------------------------------------------------------------------
-- CRIAÇÃO DO ÍNDICE: IFRMAXIMO.INVRESERVE_NDX4
--------------------------------------------------------------------------------------------------------------------
CREATE  INDEX IFRMAXIMO.INVRESERVE_NDX4 ON IFRMAXIMO.INVRESERVE (
SITEID ASC,
POLINEID ASC)
PCTFREE    10
INITRANS   2
MAXTRANS   255
TABLESPACE TSI_MAXIMO
STORAGE   (
            INITIAL    65536
            MINEXTENTS 1
            MAXEXTENTS 2147483645
           )
/

--------------------------------------------------------------------------------------------------------------------
-- CRIAÇÃO DO ÍNDICE: IFRMAXIMO.INVRESERVE_NDX5
--------------------------------------------------------------------------------------------------------------------
CREATE  INDEX IFRMAXIMO.INVRESERVE_NDX5 ON IFRMAXIMO.INVRESERVE (
SITEID ASC,
INTERID ASC)
PCTFREE    10
INITRANS   2
MAXTRANS   255
TABLESPACE TSI_MAXIMO
STORAGE   (
            INITIAL    65536
            MINEXTENTS 1
            MAXEXTENTS 2147483645
           )
/

--------------------------------------------------------------------------------------------------------------------
-- CRIAÇÃO DO ÍNDICE: IFRMAXIMO.INVTRANS_NDX1
--------------------------------------------------------------------------------------------------------------------
CREATE UNIQUE INDEX IFRMAXIMO.INVTRANS_NDX1 ON IFRMAXIMO.INVTRANS (
SITEID ASC,
INVTRANSID ASC)
PCTFREE    10
INITRANS   2
MAXTRANS   255
TABLESPACE TSI_MAXIMO
STORAGE   (
            INITIAL    65536
            MINEXTENTS 1
            MAXEXTENTS 2147483645
           )
/

--------------------------------------------------------------------------------------------------------------------
-- CRIAÇÃO DO ÍNDICE: IFRMAXIMO.INVTRANS_NDX2
--------------------------------------------------------------------------------------------------------------------
CREATE  INDEX IFRMAXIMO.INVTRANS_NDX2 ON IFRMAXIMO.INVTRANS (
SITEID ASC,
ITEMNUM ASC,
STORELOC ASC,
TRANSDATE ASC)
PCTFREE    10
INITRANS   2
MAXTRANS   255
TABLESPACE TSI_MAXIMO
STORAGE   (
            INITIAL    65536
            MINEXTENTS 1
            MAXEXTENTS 2147483645
           )
/

--------------------------------------------------------------------------------------------------------------------
-- CRIAÇÃO DO ÍNDICE: IFRMAXIMO.INVTRANS_NDX3
--------------------------------------------------------------------------------------------------------------------
CREATE  INDEX IFRMAXIMO.INVTRANS_NDX3 ON IFRMAXIMO.INVTRANS (
SITEID ASC,
INTERID ASC)
PCTFREE    10
INITRANS   2
MAXTRANS   255
TABLESPACE TSI_MAXIMO
STORAGE   (
            INITIAL    65536
            MINEXTENTS 1
            MAXEXTENTS 2147483645
           )
/

--------------------------------------------------------------------------------------------------------------------
-- CRIAÇÃO DO ÍNDICE: IFRMAXIMO.INVVEND_NDX1
--------------------------------------------------------------------------------------------------------------------
CREATE UNIQUE INDEX IFRMAXIMO.INVVEND_NDX1 ON IFRMAXIMO.INVVENDOR (
SITEID ASC,
ITEMNUM ASC,
VENDOR ASC,
MANUFACTURER ASC,
MODELNUM ASC)
PCTFREE    10
INITRANS   2
MAXTRANS   255
TABLESPACE TSI_MAXIMO
STORAGE   (
            INITIAL    65536
            MINEXTENTS 1
            MAXEXTENTS 2147483645
           )
/

--------------------------------------------------------------------------------------------------------------------
-- CRIAÇÃO DO ÍNDICE: IFRMAXIMO.INVVEND_NDX2
--------------------------------------------------------------------------------------------------------------------
CREATE  INDEX IFRMAXIMO.INVVEND_NDX2 ON IFRMAXIMO.INVVENDOR (
SITEID ASC,
INTERID ASC)
PCTFREE    10
INITRANS   2
MAXTRANS   255
TABLESPACE TSI_MAXIMO
STORAGE   (
            INITIAL    65536
            MINEXTENTS 1
            MAXEXTENTS 2147483645
           )
/

--------------------------------------------------------------------------------------------------------------------
-- CRIAÇÃO DO ÍNDICE: IFRMAXIMO.INVVEND_NDX3
--------------------------------------------------------------------------------------------------------------------
CREATE  INDEX IFRMAXIMO.INVVEND_NDX3 ON IFRMAXIMO.INVVENDOR (
SITEID ASC,
VENDOR ASC,
CATALOGCODE ASC)
PCTFREE    10
INITRANS   2
MAXTRANS   255
TABLESPACE TSI_MAXIMO
STORAGE   (
            INITIAL    65536
            MINEXTENTS 1
            MAXEXTENTS 2147483645
           )
/

--------------------------------------------------------------------------------------------------------------------
-- CRIAÇÃO DO ÍNDICE: IFRMAXIMO.ITEM_NDX1
--------------------------------------------------------------------------------------------------------------------
CREATE UNIQUE INDEX IFRMAXIMO.ITEM_NDX1 ON IFRMAXIMO.ITEM (
ORGID ASC,
ITEMNUM ASC)
PCTFREE    10
INITRANS   2
MAXTRANS   255
TABLESPACE TSI_MAXIMO
STORAGE   (
            INITIAL    65536
            MINEXTENTS 1
            MAXEXTENTS 2147483645
           )
/

--------------------------------------------------------------------------------------------------------------------
-- CRIAÇÃO DO ÍNDICE: IFRMAXIMO.ITEM_NDX2
--------------------------------------------------------------------------------------------------------------------
CREATE  INDEX IFRMAXIMO.ITEM_NDX2 ON IFRMAXIMO.ITEM (
ORGID ASC,
INTERID ASC)
PCTFREE    10
INITRANS   2
MAXTRANS   255
TABLESPACE TSI_MAXIMO
STORAGE   (
            INITIAL    65536
            MINEXTENTS 1
            MAXEXTENTS 2147483645
           )
/

--------------------------------------------------------------------------------------------------------------------
-- CRIAÇÃO DO ÍNDICE: IFRMAXIMO.ITEMSPEC_NDX1
--------------------------------------------------------------------------------------------------------------------
CREATE UNIQUE INDEX IFRMAXIMO.ITEMSPEC_NDX1 ON IFRMAXIMO.ITEMSPEC (
ORGID ASC,
ITEMNUM ASC,
ASSETATTRID ASC)
PCTFREE    10
INITRANS   2
MAXTRANS   255
TABLESPACE TSI_MAXIMO
STORAGE   (
            INITIAL    65536
            MINEXTENTS 1
            MAXEXTENTS 2147483645
           )
/

--------------------------------------------------------------------------------------------------------------------
-- CRIAÇÃO DO ÍNDICE: IFRMAXIMO.ITEMSPEC_NDX2
--------------------------------------------------------------------------------------------------------------------
CREATE  INDEX IFRMAXIMO.ITEMSPEC_NDX2 ON IFRMAXIMO.ITEMSPEC (
ORGID ASC,
CLASSSTRUCTUREID ASC,
ASSETATTRID ASC)
PCTFREE    10
INITRANS   2
MAXTRANS   255
TABLESPACE TSI_MAXIMO
STORAGE   (
            INITIAL    65536
            MINEXTENTS 1
            MAXEXTENTS 2147483645
           )
/

--------------------------------------------------------------------------------------------------------------------
-- CRIAÇÃO DO ÍNDICE: IFRMAXIMO.ITEMSPEC_NDX3
--------------------------------------------------------------------------------------------------------------------
CREATE  INDEX IFRMAXIMO.ITEMSPEC_NDX3 ON IFRMAXIMO.ITEMSPEC (
ORGID ASC,
ASSETATTRID ASC)
PCTFREE    10
INITRANS   2
MAXTRANS   255
TABLESPACE TSI_MAXIMO
STORAGE   (
            INITIAL    65536
            MINEXTENTS 1
            MAXEXTENTS 2147483645
           )
/

--------------------------------------------------------------------------------------------------------------------
-- CRIAÇÃO DO ÍNDICE: IFRMAXIMO.ITEMSTRUCT_NDX1
--------------------------------------------------------------------------------------------------------------------
CREATE UNIQUE INDEX IFRMAXIMO.ITEMSTRUCT_NDX1 ON IFRMAXIMO.ITEMSTRUCT (
ORGID ASC,
ITEMID ASC,
ITEMNUM ASC,
INSTANCE ASC)
PCTFREE    10
INITRANS   2
MAXTRANS   255
TABLESPACE TSI_MAXIMO
STORAGE   (
            INITIAL    65536
            MINEXTENTS 1
            MAXEXTENTS 2147483645
           )
/

--------------------------------------------------------------------------------------------------------------------
-- CRIAÇÃO DO ÍNDICE: IFRMAXIMO.JOBLABOR_NDX1
--------------------------------------------------------------------------------------------------------------------
CREATE  INDEX IFRMAXIMO.JOBLABOR_NDX1 ON IFRMAXIMO.JOBLABOR (
SITEID ASC,
JPNUM ASC,
JPTASK ASC,
LABORCODE ASC)
PCTFREE    10
INITRANS   2
MAXTRANS   255
TABLESPACE TSI_MAXIMO
STORAGE   (
            INITIAL    65536
            MINEXTENTS 1
            MAXEXTENTS 2147483645
           )
/

--------------------------------------------------------------------------------------------------------------------
-- CRIAÇÃO DO ÍNDICE: IFRMAXIMO.JOBMATERIAL_NDX1
--------------------------------------------------------------------------------------------------------------------
CREATE  INDEX IFRMAXIMO.JOBMATERIAL_NDX1 ON IFRMAXIMO.JOBMATERIAL (
SITEID ASC,
JPNUM ASC,
JPTASK ASC,
ITEMNUM ASC)
PCTFREE    10
INITRANS   2
MAXTRANS   255
TABLESPACE TSI_MAXIMO
STORAGE   (
            INITIAL    65536
            MINEXTENTS 1
            MAXEXTENTS 2147483645
           )
/

--------------------------------------------------------------------------------------------------------------------
-- CRIAÇÃO DO ÍNDICE: IFRMAXIMO.JOBPLAN_NDX1
--------------------------------------------------------------------------------------------------------------------
CREATE UNIQUE INDEX IFRMAXIMO.JOBPLAN_NDX1 ON IFRMAXIMO.JOBPLAN (
SITEID ASC,
JPNUM ASC)
PCTFREE    10
INITRANS   2
MAXTRANS   255
TABLESPACE TSI_MAXIMO
STORAGE   (
            INITIAL    65536
            MINEXTENTS 1
            MAXEXTENTS 2147483645
           )
/

--------------------------------------------------------------------------------------------------------------------
-- CRIAÇÃO DO ÍNDICE: IFRMAXIMO.JOBTASK_NDX1
--------------------------------------------------------------------------------------------------------------------
CREATE UNIQUE INDEX IFRMAXIMO.JOBTASK_NDX1 ON IFRMAXIMO.JOBTASK (
SITEID ASC,
JPNUM ASC,
JPTASK ASC)
PCTFREE    10
INITRANS   2
MAXTRANS   255
TABLESPACE TSI_MAXIMO
STORAGE   (
            INITIAL    65536
            MINEXTENTS 1
            MAXEXTENTS 2147483645
           )
/

--------------------------------------------------------------------------------------------------------------------
-- CRIAÇÃO DO ÍNDICE: IFRMAXIMO.JOBTOOL_NDX1
--------------------------------------------------------------------------------------------------------------------
CREATE  INDEX IFRMAXIMO.JOBTOOL_NDX1 ON IFRMAXIMO.JOBTOOL (
SITEID ASC,
JPNUM ASC,
JPTASK ASC,
TOOLNUM ASC)
PCTFREE    10
INITRANS   2
MAXTRANS   255
TABLESPACE TSI_MAXIMO
STORAGE   (
            INITIAL    65536
            MINEXTENTS 1
            MAXEXTENTS 2147483645
           )
/

--------------------------------------------------------------------------------------------------------------------
-- CRIAÇÃO DO ÍNDICE: IFRMAXIMO.JPASSETSPLINK_NDX1
--------------------------------------------------------------------------------------------------------------------
CREATE UNIQUE INDEX IFRMAXIMO.JPASSETSPLINK_NDX1 ON IFRMAXIMO.JPASSETSPLINK (
SITEID ASC,
JPASSETSPLINKID ASC)
PCTFREE    10
INITRANS   2
MAXTRANS   255
TABLESPACE TSI_MAXIMO
STORAGE   (
            INITIAL    65536
            MINEXTENTS 1
            MAXEXTENTS 2147483645
           )
/

--------------------------------------------------------------------------------------------------------------------
-- CRIAÇÃO DO ÍNDICE: IFRMAXIMO.KPI_NDX1
--------------------------------------------------------------------------------------------------------------------
CREATE UNIQUE INDEX IFRMAXIMO.KPI_NDX1 ON IFRMAXIMO.KPI (
SITEID ASC,
KPINAME ASC)
PCTFREE    10
INITRANS   2
MAXTRANS   255
TABLESPACE TSI_MAXIMO
STORAGE   (
            INITIAL    65536
            MINEXTENTS 1
            MAXEXTENTS 2147483645
           )
/

--------------------------------------------------------------------------------------------------------------------
-- CRIAÇÃO DO ÍNDICE: IFRMAXIMO.LABAVAIL_NDX1
--------------------------------------------------------------------------------------------------------------------
CREATE UNIQUE INDEX IFRMAXIMO.LABAVAIL_NDX1 ON IFRMAXIMO.LABAVAIL (
ORGID ASC,
WORKDATE ASC,
SHIFTNUM ASC,
LABORCODE ASC)
PCTFREE    10
INITRANS   2
MAXTRANS   255
TABLESPACE TSI_MAXIMO
STORAGE   (
            INITIAL    65536
            MINEXTENTS 1
            MAXEXTENTS 2147483645
           )
/

--------------------------------------------------------------------------------------------------------------------
-- CRIAÇÃO DO ÍNDICE: IFRMAXIMO.LABORAUTH_NDX1
--------------------------------------------------------------------------------------------------------------------
CREATE UNIQUE INDEX IFRMAXIMO.LABORAUTH_NDX1 ON IFRMAXIMO.LABORAUTH (
SITEID ASC,
NAME ASC,
LABORCODE ASC)
PCTFREE    10
INITRANS   2
MAXTRANS   255
TABLESPACE TSI_MAXIMO
STORAGE   (
            INITIAL    65536
            MINEXTENTS 1
            MAXEXTENTS 2147483645
           )
/

--------------------------------------------------------------------------------------------------------------------
-- CRIAÇÃO DO ÍNDICE: IFRMAXIMO.LABOR_NDX1
--------------------------------------------------------------------------------------------------------------------
CREATE UNIQUE INDEX IFRMAXIMO.LABOR_NDX1 ON IFRMAXIMO.LABOR (
ORGID ASC,
LABORCODE ASC)
PCTFREE    10
INITRANS   2
MAXTRANS   255
TABLESPACE TSI_MAXIMO
STORAGE   (
            INITIAL    65536
            MINEXTENTS 1
            MAXEXTENTS 2147483645
           )
/

--------------------------------------------------------------------------------------------------------------------
-- CRIAÇÃO DO ÍNDICE: IFRMAXIMO.LABOR_NDX2
--------------------------------------------------------------------------------------------------------------------
CREATE  INDEX IFRMAXIMO.LABOR_NDX2 ON IFRMAXIMO.LABOR (
ORGID ASC,
CRAFT ASC)
PCTFREE    10
INITRANS   2
MAXTRANS   255
TABLESPACE TSI_MAXIMO
STORAGE   (
            INITIAL    65536
            MINEXTENTS 1
            MAXEXTENTS 2147483645
           )
/

--------------------------------------------------------------------------------------------------------------------
-- CRIAÇÃO DO ÍNDICE: IFRMAXIMO.LABOR_NDX3
--------------------------------------------------------------------------------------------------------------------
CREATE  INDEX IFRMAXIMO.LABOR_NDX3 ON IFRMAXIMO.LABOR (
ORGID ASC,
CALNUM ASC)
PCTFREE    10
INITRANS   2
MAXTRANS   255
TABLESPACE TSI_MAXIMO
STORAGE   (
            INITIAL    65536
            MINEXTENTS 1
            MAXEXTENTS 2147483645
           )
/

--------------------------------------------------------------------------------------------------------------------
-- CRIAÇÃO DO ÍNDICE: IFRMAXIMO.LABOR_NDX4
--------------------------------------------------------------------------------------------------------------------
CREATE  INDEX IFRMAXIMO.LABOR_NDX4 ON IFRMAXIMO.LABOR (
ORGID ASC,
INTERID ASC)
PCTFREE    10
INITRANS   2
MAXTRANS   255
TABLESPACE TSI_MAXIMO
STORAGE   (
            INITIAL    65536
            MINEXTENTS 1
            MAXEXTENTS 2147483645
           )
/

--------------------------------------------------------------------------------------------------------------------
-- CRIAÇÃO DO ÍNDICE: IFRMAXIMO.LABTRANS_NDX1
--------------------------------------------------------------------------------------------------------------------
CREATE UNIQUE INDEX IFRMAXIMO.LABTRANS_NDX1 ON IFRMAXIMO.LABTRANS (
SITEID ASC,
LABTRANSID ASC)
PCTFREE    10
INITRANS   2
MAXTRANS   255
TABLESPACE TSI_MAXIMO
STORAGE   (
            INITIAL    65536
            MINEXTENTS 1
            MAXEXTENTS 2147483645
           )
/

--------------------------------------------------------------------------------------------------------------------
-- CRIAÇÃO DO ÍNDICE: IFRMAXIMO.LABTRANS_NDX2
--------------------------------------------------------------------------------------------------------------------
CREATE  INDEX IFRMAXIMO.LABTRANS_NDX2 ON IFRMAXIMO.LABTRANS (
SITEID ASC,
LABORCODE ASC,
TRANSDATE ASC)
PCTFREE    10
INITRANS   2
MAXTRANS   255
TABLESPACE TSI_MAXIMO
STORAGE   (
            INITIAL    65536
            MINEXTENTS 1
            MAXEXTENTS 2147483645
           )
/

--------------------------------------------------------------------------------------------------------------------
-- CRIAÇÃO DO ÍNDICE: IFRMAXIMO.LABTRANS_NDX3
--------------------------------------------------------------------------------------------------------------------
CREATE  INDEX IFRMAXIMO.LABTRANS_NDX3 ON IFRMAXIMO.LABTRANS (
SITEID ASC,
EQNUM ASC)
PCTFREE    10
INITRANS   2
MAXTRANS   255
TABLESPACE TSI_MAXIMO
STORAGE   (
            INITIAL    65536
            MINEXTENTS 1
            MAXEXTENTS 2147483645
           )
/

--------------------------------------------------------------------------------------------------------------------
-- CRIAÇÃO DO ÍNDICE: IFRMAXIMO.LABTRANS_NDX4
--------------------------------------------------------------------------------------------------------------------
CREATE  INDEX IFRMAXIMO.LABTRANS_NDX4 ON IFRMAXIMO.LABTRANS (
SITEID ASC,
REFWO ASC)
PCTFREE    10
INITRANS   2
MAXTRANS   255
TABLESPACE TSI_MAXIMO
STORAGE   (
            INITIAL    65536
            MINEXTENTS 1
            MAXEXTENTS 2147483645
           )
/

--------------------------------------------------------------------------------------------------------------------
-- CRIAÇÃO DO ÍNDICE: IFRMAXIMO.LABTRANS_NDX5
--------------------------------------------------------------------------------------------------------------------
CREATE  INDEX IFRMAXIMO.LABTRANS_NDX5 ON IFRMAXIMO.LABTRANS (
SITEID ASC,
INTERID ASC)
PCTFREE    10
INITRANS   2
MAXTRANS   255
TABLESPACE TSI_MAXIMO
STORAGE   (
            INITIAL    65536
            MINEXTENTS 1
            MAXEXTENTS 2147483645
           )
/

--------------------------------------------------------------------------------------------------------------------
-- CRIAÇÃO DO ÍNDICE: IFRMAXIMO.LANG_NDX1
--------------------------------------------------------------------------------------------------------------------
CREATE UNIQUE INDEX IFRMAXIMO.LANG_NDX1 ON IFRMAXIMO.LANGUAGE (
LANGCODE ASC)
PCTFREE    10
INITRANS   2
MAXTRANS   255
TABLESPACE TSI_MAXIMO
STORAGE   (
            INITIAL    65536
            MINEXTENTS 1
            MAXEXTENTS 2147483645
           )
/

--------------------------------------------------------------------------------------------------------------------
-- CRIAÇÃO DO ÍNDICE: IFRMAXIMO.LISTTRANS_NDX1
--------------------------------------------------------------------------------------------------------------------
CREATE UNIQUE INDEX IFRMAXIMO.LISTTRANS_NDX1 ON IFRMAXIMO.LISTTRANSLATION (
LISTNAME ASC,
LANGCODE ASC,
TRANSLATEDVALUE ASC)
PCTFREE    10
INITRANS   2
MAXTRANS   255
TABLESPACE TSI_MAXIMO
STORAGE   (
            INITIAL    65536
            MINEXTENTS 1
            MAXEXTENTS 2147483645
           )
/

--------------------------------------------------------------------------------------------------------------------
-- CRIAÇÃO DO ÍNDICE: IFRMAXIMO.LOCANCESTOR_NDX1
--------------------------------------------------------------------------------------------------------------------
CREATE UNIQUE INDEX IFRMAXIMO.LOCANCESTOR_NDX1 ON IFRMAXIMO.LOCANCESTOR (
SITEID ASC,
LOCATION ASC,
SYSTEMID ASC,
ANCESTOR ASC)
PCTFREE    10
INITRANS   2
MAXTRANS   255
TABLESPACE TSI_MAXIMO
STORAGE   (
            INITIAL    65536
            MINEXTENTS 1
            MAXEXTENTS 2147483645
           )
/

--------------------------------------------------------------------------------------------------------------------
-- CRIAÇÃO DO ÍNDICE: IFRMAXIMO.LOCANCESTOR_NDX2
--------------------------------------------------------------------------------------------------------------------
CREATE  INDEX IFRMAXIMO.LOCANCESTOR_NDX2 ON IFRMAXIMO.LOCANCESTOR (
SITEID ASC,
ANCESTOR ASC,
SYSTEMID ASC)
PCTFREE    10
INITRANS   2
MAXTRANS   255
TABLESPACE TSI_MAXIMO
STORAGE   (
            INITIAL    65536
            MINEXTENTS 1
            MAXEXTENTS 2147483645
           )
/

--------------------------------------------------------------------------------------------------------------------
-- CRIAÇÃO DO ÍNDICE: IFRMAXIMO.LOCATIONS_NDX1
--------------------------------------------------------------------------------------------------------------------
CREATE UNIQUE INDEX IFRMAXIMO.LOCATIONS_NDX1 ON IFRMAXIMO.LOCATIONS (
SITEID ASC,
LOCATION ASC)
PCTFREE    10
INITRANS   2
MAXTRANS   255
TABLESPACE TSI_MAXIMO
STORAGE   (
            INITIAL    65536
            MINEXTENTS 1
            MAXEXTENTS 2147483645
           )
/

--------------------------------------------------------------------------------------------------------------------
-- CRIAÇÃO DO ÍNDICE: IFRMAXIMO.LOCATIONS_NDX2
--------------------------------------------------------------------------------------------------------------------
CREATE  INDEX IFRMAXIMO.LOCATIONS_NDX2 ON IFRMAXIMO.LOCATIONS (
SITEID ASC,
TYPE ASC)
PCTFREE    10
INITRANS   2
MAXTRANS   255
TABLESPACE TSI_MAXIMO
STORAGE   (
            INITIAL    65536
            MINEXTENTS 1
            MAXEXTENTS 2147483645
           )
/

--------------------------------------------------------------------------------------------------------------------
-- CRIAÇÃO DO ÍNDICE: IFRMAXIMO.LOCATIONS_NDX3
--------------------------------------------------------------------------------------------------------------------
CREATE  INDEX IFRMAXIMO.LOCATIONS_NDX3 ON IFRMAXIMO.LOCATIONS (
SITEID ASC,
INTERID ASC)
PCTFREE    10
INITRANS   2
MAXTRANS   255
TABLESPACE TSI_MAXIMO
STORAGE   (
            INITIAL    65536
            MINEXTENTS 1
            MAXEXTENTS 2147483645
           )
/

--------------------------------------------------------------------------------------------------------------------
-- CRIAÇÃO DO ÍNDICE: IFRMAXIMO.LOCATIONSPEC_NDX1
--------------------------------------------------------------------------------------------------------------------
CREATE UNIQUE INDEX IFRMAXIMO.LOCATIONSPEC_NDX1 ON IFRMAXIMO.LOCATIONSPEC (
SITEID ASC,
LOCATION ASC,
ASSETATTRID ASC)
PCTFREE    10
INITRANS   2
MAXTRANS   255
TABLESPACE TSI_MAXIMO
STORAGE   (
            INITIAL    65536
            MINEXTENTS 1
            MAXEXTENTS 2147483645
           )
/

--------------------------------------------------------------------------------------------------------------------
-- CRIAÇÃO DO ÍNDICE: IFRMAXIMO.LOCATIONSPEC_NDX2
--------------------------------------------------------------------------------------------------------------------
CREATE  INDEX IFRMAXIMO.LOCATIONSPEC_NDX2 ON IFRMAXIMO.LOCATIONSPEC (
SITEID ASC,
CLASSSTRUCTUREID ASC,
ASSETATTRID ASC)
PCTFREE    10
INITRANS   2
MAXTRANS   255
TABLESPACE TSI_MAXIMO
STORAGE   (
            INITIAL    65536
            MINEXTENTS 1
            MAXEXTENTS 2147483645
           )
/

--------------------------------------------------------------------------------------------------------------------
-- CRIAÇÃO DO ÍNDICE: IFRMAXIMO.LOCATIONSPEC_NDX3
--------------------------------------------------------------------------------------------------------------------
CREATE  INDEX IFRMAXIMO.LOCATIONSPEC_NDX3 ON IFRMAXIMO.LOCATIONSPEC (
SITEID ASC,
ASSETATTRID ASC)
PCTFREE    10
INITRANS   2
MAXTRANS   255
TABLESPACE TSI_MAXIMO
STORAGE   (
            INITIAL    65536
            MINEXTENTS 1
            MAXEXTENTS 2147483645
           )
/

--------------------------------------------------------------------------------------------------------------------
-- CRIAÇÃO DO ÍNDICE: IFRMAXIMO.LOCAUTH_NDX1
--------------------------------------------------------------------------------------------------------------------
CREATE UNIQUE INDEX IFRMAXIMO.LOCAUTH_NDX1 ON IFRMAXIMO.LOCAUTH (
SITEID ASC,
USERNAME ASC,
LOCATION ASC)
PCTFREE    10
INITRANS   2
MAXTRANS   255
TABLESPACE TSI_MAXIMO
STORAGE   (
            INITIAL    65536
            MINEXTENTS 1
            MAXEXTENTS 2147483645
           )
/

--------------------------------------------------------------------------------------------------------------------
-- CRIAÇÃO DO ÍNDICE: IFRMAXIMO.LOCHIERARCHY_NDX1
--------------------------------------------------------------------------------------------------------------------
CREATE UNIQUE INDEX IFRMAXIMO.LOCHIERARCHY_NDX1 ON IFRMAXIMO.LOCHIERARCHY (
SITEID ASC,
LOCATION ASC,
SYSTEMID ASC,
PARENT ASC)
PCTFREE    10
INITRANS   2
MAXTRANS   255
TABLESPACE TSI_MAXIMO
STORAGE   (
            INITIAL    65536
            MINEXTENTS 1
            MAXEXTENTS 2147483645
           )
/

--------------------------------------------------------------------------------------------------------------------
-- CRIAÇÃO DO ÍNDICE: IFRMAXIMO.LOCHIERARCHY_NDX2
--------------------------------------------------------------------------------------------------------------------
CREATE  INDEX IFRMAXIMO.LOCHIERARCHY_NDX2 ON IFRMAXIMO.LOCHIERARCHY (
SITEID ASC,
PARENT ASC,
SYSTEMID ASC)
PCTFREE    10
INITRANS   2
MAXTRANS   255
TABLESPACE TSI_MAXIMO
STORAGE   (
            INITIAL    65536
            MINEXTENTS 1
            MAXEXTENTS 2147483645
           )
/

--------------------------------------------------------------------------------------------------------------------
-- CRIAÇÃO DO ÍNDICE: IFRMAXIMO.LOCKOUT_NDX1
--------------------------------------------------------------------------------------------------------------------
CREATE UNIQUE INDEX IFRMAXIMO.LOCKOUT_NDX1 ON IFRMAXIMO.LOCKOUT (
SITEID ASC,
LOCKOUTID ASC)
PCTFREE    10
INITRANS   2
MAXTRANS   255
TABLESPACE TSI_MAXIMO
STORAGE   (
            INITIAL    65536
            MINEXTENTS 1
            MAXEXTENTS 2147483645
           )
/

--------------------------------------------------------------------------------------------------------------------
-- CRIAÇÃO DO ÍNDICE: IFRMAXIMO.LOCLEADTIME_NDX1
--------------------------------------------------------------------------------------------------------------------
CREATE UNIQUE INDEX IFRMAXIMO.LOCLEADTIME_NDX1 ON IFRMAXIMO.LOCLEADTIME (
SITEID ASC,
LOCATION ASC)
PCTFREE    10
INITRANS   2
MAXTRANS   255
TABLESPACE TSI_MAXIMO
STORAGE   (
            INITIAL    65536
            MINEXTENTS 1
            MAXEXTENTS 2147483645
           )
/

--------------------------------------------------------------------------------------------------------------------
-- CRIAÇÃO DO ÍNDICE: IFRMAXIMO.LOCOPER_NDX1
--------------------------------------------------------------------------------------------------------------------
CREATE UNIQUE INDEX IFRMAXIMO.LOCOPER_NDX1 ON IFRMAXIMO.LOCOPER (
SITEID ASC,
LOCATION ASC)
PCTFREE    10
INITRANS   2
MAXTRANS   255
TABLESPACE TSI_MAXIMO
STORAGE   (
            INITIAL    65536
            MINEXTENTS 1
            MAXEXTENTS 2147483645
           )
/

--------------------------------------------------------------------------------------------------------------------
-- CRIAÇÃO DO ÍNDICE: IFRMAXIMO.LOCSTATUS_NDX1
--------------------------------------------------------------------------------------------------------------------
CREATE  INDEX IFRMAXIMO.LOCSTATUS_NDX1 ON IFRMAXIMO.LOCSTATUS (
SITEID ASC,
LOCATION ASC)
PCTFREE    10
INITRANS   2
MAXTRANS   255
TABLESPACE TSI_MAXIMO
STORAGE   (
            INITIAL    65536
            MINEXTENTS 1
            MAXEXTENTS 2147483645
           )
/

--------------------------------------------------------------------------------------------------------------------
-- CRIAÇÃO DO ÍNDICE: IFRMAXIMO.LOCSTATUS_NDX2
--------------------------------------------------------------------------------------------------------------------
CREATE  INDEX IFRMAXIMO.LOCSTATUS_NDX2 ON IFRMAXIMO.LOCSTATUS (
SITEID ASC,
CHANGEDATE ASC)
PCTFREE    10
INITRANS   2
MAXTRANS   255
TABLESPACE TSI_MAXIMO
STORAGE   (
            INITIAL    65536
            MINEXTENTS 1
            MAXEXTENTS 2147483645
           )
/

--------------------------------------------------------------------------------------------------------------------
-- CRIAÇÃO DO ÍNDICE: IFRMAXIMO.LOCSYSTEM_NDX1
--------------------------------------------------------------------------------------------------------------------
CREATE UNIQUE INDEX IFRMAXIMO.LOCSYSTEM_NDX1 ON IFRMAXIMO.LOCSYSTEM (
SITEID ASC,
SYSTEMID ASC)
PCTFREE    10
INITRANS   2
MAXTRANS   255
TABLESPACE TSI_MAXIMO
STORAGE   (
            INITIAL    65536
            MINEXTENTS 1
            MAXEXTENTS 2147483645
           )
/

--------------------------------------------------------------------------------------------------------------------
-- CRIAÇÃO DO ÍNDICE: IFRMAXIMO.LOGINTRACKING_NDX1
--------------------------------------------------------------------------------------------------------------------
CREATE  INDEX IFRMAXIMO.LOGINTRACKING_NDX1 ON IFRMAXIMO.LOGINTRACKING (
USERNAME ASC,
ATTEMPTDATE ASC)
PCTFREE    10
INITRANS   2
MAXTRANS   255
TABLESPACE TSI_MAXIMO
STORAGE   (
            INITIAL    65536
            MINEXTENTS 1
            MAXEXTENTS 2147483645
           )
/

--------------------------------------------------------------------------------------------------------------------
-- CRIAÇÃO DO ÍNDICE: IFRMAXIMO.LOGINTRACKING_NDX2
--------------------------------------------------------------------------------------------------------------------
CREATE  INDEX IFRMAXIMO.LOGINTRACKING_NDX2 ON IFRMAXIMO.LOGINTRACKING (
ATTEMPTDATE ASC,
USERNAME ASC)
PCTFREE    10
INITRANS   2
MAXTRANS   255
TABLESPACE TSI_MAXIMO
STORAGE   (
            INITIAL    65536
            MINEXTENTS 1
            MAXEXTENTS 2147483645
           )
/

--------------------------------------------------------------------------------------------------------------------
-- CRIAÇÃO DO ÍNDICE: IFRMAXIMO.LONGDSCRPTN_NDX1
--------------------------------------------------------------------------------------------------------------------
CREATE UNIQUE INDEX IFRMAXIMO.LONGDSCRPTN_NDX1 ON IFRMAXIMO.LONGDESCRIPTION (
LDOWNERTABLE ASC,
LDOWNERCOL ASC,
LDKEY ASC)
PCTFREE    10
INITRANS   2
MAXTRANS   255
TABLESPACE TSI_MAXIMO
STORAGE   (
            INITIAL    4669440
            MINEXTENTS 1
            MAXEXTENTS 2147483645
           )
/

--------------------------------------------------------------------------------------------------------------------
-- CRIAÇÃO DO ÍNDICE: IFRMAXIMO.LONGDSCRPTN_NDX2
--------------------------------------------------------------------------------------------------------------------
CREATE  INDEX IFRMAXIMO.LONGDSCRPTN_NDX2 ON IFRMAXIMO.LONGDESCRIPTION (
LDKEY ASC)
PCTFREE    10
INITRANS   2
MAXTRANS   255
TABLESPACE TSI_MAXIMO
STORAGE   (
            INITIAL    2129920
            MINEXTENTS 1
            MAXEXTENTS 2147483645
           )
/

--------------------------------------------------------------------------------------------------------------------
-- CRIAÇÃO DO ÍNDICE: IFRMAXIMO.MATRECTRANS_NDX1
--------------------------------------------------------------------------------------------------------------------
CREATE UNIQUE INDEX IFRMAXIMO.MATRECTRANS_NDX1 ON IFRMAXIMO.MATRECTRANS (
SITEID ASC,
MATRECTRANSID ASC)
PCTFREE    10
INITRANS   2
MAXTRANS   255
TABLESPACE TSI_MAXIMO
STORAGE   (
            INITIAL    65536
            MINEXTENTS 1
            MAXEXTENTS 2147483645
           )
/

--------------------------------------------------------------------------------------------------------------------
-- CRIAÇÃO DO ÍNDICE: IFRMAXIMO.MATRECTRANS_NDX2
--------------------------------------------------------------------------------------------------------------------
CREATE  INDEX IFRMAXIMO.MATRECTRANS_NDX2 ON IFRMAXIMO.MATRECTRANS (
SITEID ASC,
ITEMNUM ASC,
TOSTORELOC ASC)
PCTFREE    10
INITRANS   2
MAXTRANS   255
TABLESPACE TSI_MAXIMO
STORAGE   (
            INITIAL    65536
            MINEXTENTS 1
            MAXEXTENTS 2147483645
           )
/

--------------------------------------------------------------------------------------------------------------------
-- CRIAÇÃO DO ÍNDICE: IFRMAXIMO.MATRECTRANS_NDX3
--------------------------------------------------------------------------------------------------------------------
CREATE  INDEX IFRMAXIMO.MATRECTRANS_NDX3 ON IFRMAXIMO.MATRECTRANS (
SITEID ASC,
PONUM ASC,
POLINENUM ASC,
TRANSDATE ASC)
PCTFREE    10
INITRANS   2
MAXTRANS   255
TABLESPACE TSI_MAXIMO
STORAGE   (
            INITIAL    65536
            MINEXTENTS 1
            MAXEXTENTS 2147483645
           )
/

--------------------------------------------------------------------------------------------------------------------
-- CRIAÇÃO DO ÍNDICE: IFRMAXIMO.MATRECTRANS_NDX4
--------------------------------------------------------------------------------------------------------------------
CREATE  INDEX IFRMAXIMO.MATRECTRANS_NDX4 ON IFRMAXIMO.MATRECTRANS (
SITEID ASC,
INTERID ASC)
PCTFREE    10
INITRANS   2
MAXTRANS   255
TABLESPACE TSI_MAXIMO
STORAGE   (
            INITIAL    65536
            MINEXTENTS 1
            MAXEXTENTS 2147483645
           )
/

--------------------------------------------------------------------------------------------------------------------
-- CRIAÇÃO DO ÍNDICE: IFRMAXIMO.MATUSETRANS_NDX1
--------------------------------------------------------------------------------------------------------------------
CREATE UNIQUE INDEX IFRMAXIMO.MATUSETRANS_NDX1 ON IFRMAXIMO.MATUSETRANS (
MATUSETRANSID ASC,
SITEID ASC)
PCTFREE    10
INITRANS   2
MAXTRANS   255
TABLESPACE TSI_MAXIMO
STORAGE   (
            INITIAL    65536
            MINEXTENTS 1
            MAXEXTENTS 2147483645
           )
/

--------------------------------------------------------------------------------------------------------------------
-- CRIAÇÃO DO ÍNDICE: IFRMAXIMO.MATUSETRANS_NDX2
--------------------------------------------------------------------------------------------------------------------
CREATE  INDEX IFRMAXIMO.MATUSETRANS_NDX2 ON IFRMAXIMO.MATUSETRANS (
SITEID ASC,
REFWO ASC,
TRANSDATE ASC)
PCTFREE    10
INITRANS   2
MAXTRANS   255
TABLESPACE TSI_MAXIMO
STORAGE   (
            INITIAL    65536
            MINEXTENTS 1
            MAXEXTENTS 2147483645
           )
/

--------------------------------------------------------------------------------------------------------------------
-- CRIAÇÃO DO ÍNDICE: IFRMAXIMO.MATUSETRANS_NDX3
--------------------------------------------------------------------------------------------------------------------
CREATE  INDEX IFRMAXIMO.MATUSETRANS_NDX3 ON IFRMAXIMO.MATUSETRANS (
SITEID ASC,
ITEMNUM ASC,
STORELOC ASC,
TRANSDATE ASC)
PCTFREE    10
INITRANS   2
MAXTRANS   255
TABLESPACE TSI_MAXIMO
STORAGE   (
            INITIAL    65536
            MINEXTENTS 1
            MAXEXTENTS 2147483645
           )
/

--------------------------------------------------------------------------------------------------------------------
-- CRIAÇÃO DO ÍNDICE: IFRMAXIMO.MATUSETRANS_NDX4
--------------------------------------------------------------------------------------------------------------------
CREATE  INDEX IFRMAXIMO.MATUSETRANS_NDX4 ON IFRMAXIMO.MATUSETRANS (
SITEID ASC,
EQNUM ASC)
PCTFREE    10
INITRANS   2
MAXTRANS   255
TABLESPACE TSI_MAXIMO
STORAGE   (
            INITIAL    65536
            MINEXTENTS 1
            MAXEXTENTS 2147483645
           )
/

--------------------------------------------------------------------------------------------------------------------
-- CRIAÇÃO DO ÍNDICE: IFRMAXIMO.MATUSETRANS_NDX5
--------------------------------------------------------------------------------------------------------------------
CREATE  INDEX IFRMAXIMO.MATUSETRANS_NDX5 ON IFRMAXIMO.MATUSETRANS (
SITEID ASC,
INTERID ASC)
PCTFREE    10
INITRANS   2
MAXTRANS   255
TABLESPACE TSI_MAXIMO
STORAGE   (
            INITIAL    65536
            MINEXTENTS 1
            MAXEXTENTS 2147483645
           )
/

--------------------------------------------------------------------------------------------------------------------
-- CRIAÇÃO DO ÍNDICE: IFRMAXIMO.MAXAPPS_NDX
--------------------------------------------------------------------------------------------------------------------
CREATE UNIQUE INDEX IFRMAXIMO.MAXAPPS_NDX ON IFRMAXIMO.MAXAPPS (
MODULE ASC,
APP ASC)
PCTFREE    10
INITRANS   2
MAXTRANS   255
TABLESPACE TSI_MAXIMO
STORAGE   (
            INITIAL    65536
            MINEXTENTS 1
            MAXEXTENTS 2147483645
           )
/

--------------------------------------------------------------------------------------------------------------------
-- CRIAÇÃO DO ÍNDICE: IFRMAXIMO.MAXAPPS_NDX1
--------------------------------------------------------------------------------------------------------------------
CREATE  INDEX IFRMAXIMO.MAXAPPS_NDX1 ON IFRMAXIMO.MAXAPPS (
APP ASC)
PCTFREE    10
INITRANS   2
MAXTRANS   255
TABLESPACE TSI_MAXIMO
STORAGE   (
            INITIAL    65536
            MINEXTENTS 1
            MAXEXTENTS 2147483645
           )
/

--------------------------------------------------------------------------------------------------------------------
-- CRIAÇÃO DO ÍNDICE: IFRMAXIMO.MAXDOMAIN_NDX1
--------------------------------------------------------------------------------------------------------------------
CREATE UNIQUE INDEX IFRMAXIMO.MAXDOMAIN_NDX1 ON IFRMAXIMO.MAXDOMAIN (
DOMAINID ASC)
PCTFREE    10
INITRANS   2
MAXTRANS   255
TABLESPACE TSI_MAXIMO
STORAGE   (
            INITIAL    65536
            MINEXTENTS 1
            MAXEXTENTS 2147483645
           )
/

--------------------------------------------------------------------------------------------------------------------
-- CRIAÇÃO DO ÍNDICE: IFRMAXIMO.MAXDOMAIN_NDX2
--------------------------------------------------------------------------------------------------------------------
CREATE  INDEX IFRMAXIMO.MAXDOMAIN_NDX2 ON IFRMAXIMO.MAXDOMAIN (
DOMAINTYPE ASC,
DOMAINID ASC)
PCTFREE    10
INITRANS   2
MAXTRANS   255
TABLESPACE TSI_MAXIMO
STORAGE   (
            INITIAL    65536
            MINEXTENTS 1
            MAXEXTENTS 2147483645
           )
/

--------------------------------------------------------------------------------------------------------------------
-- CRIAÇÃO DO ÍNDICE: IFRMAXIMO.MAXGROUPS_NDX
--------------------------------------------------------------------------------------------------------------------
CREATE UNIQUE INDEX IFRMAXIMO.MAXGROUPS_NDX ON IFRMAXIMO.MAXGROUPS (
GRPNAME ASC)
PCTFREE    10
INITRANS   2
MAXTRANS   255
TABLESPACE TSI_MAXIMO
STORAGE   (
            INITIAL    65536
            MINEXTENTS 1
            MAXEXTENTS 2147483645
           )
/

--------------------------------------------------------------------------------------------------------------------
-- CRIAÇÃO DO ÍNDICE: IFRMAXIMO.MAXHLP_NDX
--------------------------------------------------------------------------------------------------------------------
CREATE UNIQUE INDEX IFRMAXIMO.MAXHLP_NDX ON IFRMAXIMO.MAXHLP (
APP ASC,
WINDOW ASC,
TWNAME ASC,
CONTROL ASC)
PCTFREE    10
INITRANS   2
MAXTRANS   255
TABLESPACE TSI_MAXIMO
STORAGE   (
            INITIAL    65536
            MINEXTENTS 1
            MAXEXTENTS 2147483645
           )
/

--------------------------------------------------------------------------------------------------------------------
-- CRIAÇÃO DO ÍNDICE: IFRMAXIMO.MAXMODULES_NDX
--------------------------------------------------------------------------------------------------------------------
CREATE UNIQUE INDEX IFRMAXIMO.MAXMODULES_NDX ON IFRMAXIMO.MAXMODULES (
MODULE ASC)
PCTFREE    10
INITRANS   2
MAXTRANS   255
TABLESPACE TSI_MAXIMO
STORAGE   (
            INITIAL    40960
            MINEXTENTS 1
            MAXEXTENTS 2147483645
           )
/

--------------------------------------------------------------------------------------------------------------------
-- CRIAÇÃO DO ÍNDICE: IFRMAXIMO.MAXRELATIONS_NDX1
--------------------------------------------------------------------------------------------------------------------
CREATE UNIQUE INDEX IFRMAXIMO.MAXRELATIONS_NDX1 ON IFRMAXIMO.MAXRELATIONSHIP (
PARENT ASC,
NAME ASC)
PCTFREE    10
INITRANS   2
MAXTRANS   255
TABLESPACE TSI_MAXIMO
STORAGE   (
            INITIAL    40960
            MINEXTENTS 1
            MAXEXTENTS 2147483645
           )
/

--------------------------------------------------------------------------------------------------------------------
-- CRIAÇÃO DO ÍNDICE: IFRMAXIMO.MAXREPORTDATE_IDX
--------------------------------------------------------------------------------------------------------------------
CREATE UNIQUE INDEX IFRMAXIMO.MAXREPORTDATE_IDX ON IFRMAXIMO.WORKORDER (
WONUM ASC,
CREWID ASC,
STATUS ASC,
ISTASK ASC,
SITEID ASC,
ORGID ASC,
REPORTDATE ASC,
ACTFINISH ASC)
PCTFREE    10
INITRANS   2
MAXTRANS   255
TABLESPACE TSI_MAXIMO
STORAGE   (
            INITIAL    65536
            MINEXTENTS 1
            MAXEXTENTS 2147483645
           )
/

--------------------------------------------------------------------------------------------------------------------
-- CRIAÇÃO DO ÍNDICE: IFRMAXIMO.MAXSCREENS_NDX2
--------------------------------------------------------------------------------------------------------------------
CREATE UNIQUE INDEX IFRMAXIMO.MAXSCREENS_NDX2 ON IFRMAXIMO.MAXSCREENS (
APP ASC,
ID ASC)
PCTFREE    10
INITRANS   2
MAXTRANS   255
TABLESPACE TSI_MAXIMO
STORAGE   (
            INITIAL    40960
            MINEXTENTS 1
            MAXEXTENTS 2147483645
           )
/

--------------------------------------------------------------------------------------------------------------------
-- CRIAÇÃO DO ÍNDICE: IFRMAXIMO.MAXSCRN_NDX1
--------------------------------------------------------------------------------------------------------------------
CREATE UNIQUE INDEX IFRMAXIMO.MAXSCRN_NDX1 ON IFRMAXIMO.MAXSCREENS (
APP ASC,
SCREEN ASC)
PCTFREE    10
INITRANS   2
MAXTRANS   255
TABLESPACE TSI_MAXIMO
STORAGE   (
            INITIAL    81920
            MINEXTENTS 1
            MAXEXTENTS 2147483645
           )
/

--------------------------------------------------------------------------------------------------------------------
-- CRIAÇÃO DO ÍNDICE: IFRMAXIMO.MAXSERVICE_NDX1
--------------------------------------------------------------------------------------------------------------------
CREATE UNIQUE INDEX IFRMAXIMO.MAXSERVICE_NDX1 ON IFRMAXIMO.MAXSERVICE (
SERVICENAME ASC)
PCTFREE    10
INITRANS   2
MAXTRANS   255
TABLESPACE TSI_MAXIMO
STORAGE   (
            INITIAL    65536
            MINEXTENTS 1
            MAXEXTENTS 2147483645
           )
/

--------------------------------------------------------------------------------------------------------------------
-- CRIAÇÃO DO ÍNDICE: IFRMAXIMO.MAXSYSCFG_NDX1
--------------------------------------------------------------------------------------------------------------------
CREATE UNIQUE INDEX IFRMAXIMO.MAXSYSCFG_NDX1 ON IFRMAXIMO.MAXSYSCOLSCFG (
TBNAME ASC,
NAME ASC)
PCTFREE    10
INITRANS   2
MAXTRANS   255
TABLESPACE TSI_MAXIMO
STORAGE   (
            INITIAL    65536
            MINEXTENTS 1
            MAXEXTENTS 2147483645
           )
/

--------------------------------------------------------------------------------------------------------------------
-- CRIAÇÃO DO ÍNDICE: IFRMAXIMO.MAXSYSCFG_NDX2
--------------------------------------------------------------------------------------------------------------------
CREATE UNIQUE INDEX IFRMAXIMO.MAXSYSCFG_NDX2 ON IFRMAXIMO.MAXSYSCOLSCFG (
TBNAME ASC,
COLALIAS ASC)
PCTFREE    10
INITRANS   2
MAXTRANS   255
TABLESPACE TSI_MAXIMO
STORAGE   (
            INITIAL    65536
            MINEXTENTS 1
            MAXEXTENTS 2147483645
           )
/

--------------------------------------------------------------------------------------------------------------------
-- CRIAÇÃO DO ÍNDICE: IFRMAXIMO.MAXSYSCOLS_NDX1
--------------------------------------------------------------------------------------------------------------------
CREATE UNIQUE INDEX IFRMAXIMO.MAXSYSCOLS_NDX1 ON IFRMAXIMO.MAXSYSCOLUMNS (
TBNAME ASC,
NAME ASC)
PCTFREE    10
INITRANS   2
MAXTRANS   255
TABLESPACE TSI_MAXIMO
STORAGE   (
            INITIAL    65536
            MINEXTENTS 1
            MAXEXTENTS 2147483645
           )
/

--------------------------------------------------------------------------------------------------------------------
-- CRIAÇÃO DO ÍNDICE: IFRMAXIMO.MAXSYSCOLS_NDX2
--------------------------------------------------------------------------------------------------------------------
CREATE UNIQUE INDEX IFRMAXIMO.MAXSYSCOLS_NDX2 ON IFRMAXIMO.MAXSYSCOLUMNS (
TBNAME ASC,
COLALIAS ASC)
PCTFREE    10
INITRANS   2
MAXTRANS   255
TABLESPACE TSI_MAXIMO
STORAGE   (
            INITIAL    65536
            MINEXTENTS 1
            MAXEXTENTS 2147483645
           )
/

--------------------------------------------------------------------------------------------------------------------
-- CRIAÇÃO DO ÍNDICE: IFRMAXIMO.MAXSYSCOLS2_NDX1
--------------------------------------------------------------------------------------------------------------------
CREATE UNIQUE INDEX IFRMAXIMO.MAXSYSCOLS2_NDX1 ON IFRMAXIMO.MAXSYSCOLUMNS2 (
TBNAME ASC,
NAME ASC)
PCTFREE    10
INITRANS   2
MAXTRANS   255
TABLESPACE TSI_MAXIMO
STORAGE   (
            INITIAL    65536
            MINEXTENTS 1
            MAXEXTENTS 2147483645
           )
/

--------------------------------------------------------------------------------------------------------------------
-- CRIAÇÃO DO ÍNDICE: IFRMAXIMO.MAXSYSCOLUMN_NDX3
--------------------------------------------------------------------------------------------------------------------
CREATE  INDEX IFRMAXIMO.MAXSYSCOLUMN_NDX3 ON IFRMAXIMO.MAXSYSCOLUMNS (
TBNAME ASC,
DLFILTERLISTORDER ASC)
PCTFREE    10
INITRANS   2
MAXTRANS   255
TABLESPACE TSI_MAXIMO
STORAGE   (
            INITIAL    65536
            MINEXTENTS 1
            MAXEXTENTS 2147483645
           )
/

--------------------------------------------------------------------------------------------------------------------
-- CRIAÇÃO DO ÍNDICE: IFRMAXIMO.MAXSYSCOLUMN_NDX4
--------------------------------------------------------------------------------------------------------------------
CREATE UNIQUE INDEX IFRMAXIMO.MAXSYSCOLUMN_NDX4 ON IFRMAXIMO.MAXSYSCOLUMNS (
TBNAME ASC,
COLNO ASC)
PCTFREE    10
INITRANS   2
MAXTRANS   255
TABLESPACE TSI_MAXIMO
STORAGE   (
            INITIAL    65536
            MINEXTENTS 1
            MAXEXTENTS 2147483645
           )
/

--------------------------------------------------------------------------------------------------------------------
-- CRIAÇÃO DO ÍNDICE: IFRMAXIMO.MAXSYSKEYS_NDX
--------------------------------------------------------------------------------------------------------------------
CREATE UNIQUE INDEX IFRMAXIMO.MAXSYSKEYS_NDX ON IFRMAXIMO.MAXSYSKEYS (
IXNAME ASC,
COLNAME ASC)
PCTFREE    10
INITRANS   2
MAXTRANS   255
TABLESPACE TSI_MAXIMO
STORAGE   (
            INITIAL    81920
            MINEXTENTS 1
            MAXEXTENTS 2147483645
           )
/

--------------------------------------------------------------------------------------------------------------------
-- CRIAÇÃO DO ÍNDICE: IFRMAXIMO.MAXSYSKEYS_NDX2
--------------------------------------------------------------------------------------------------------------------
CREATE UNIQUE INDEX IFRMAXIMO.MAXSYSKEYS_NDX2 ON IFRMAXIMO.MAXSYSKEYS (
IXNAME ASC,
COLSEQ ASC)
PCTFREE    10
INITRANS   2
MAXTRANS   255
TABLESPACE TSI_MAXIMO
STORAGE   (
            INITIAL    40960
            MINEXTENTS 1
            MAXEXTENTS 2147483645
           )
/

--------------------------------------------------------------------------------------------------------------------
-- CRIAÇÃO DO ÍNDICE: IFRMAXIMO.MAXSYSNDX_NDX
--------------------------------------------------------------------------------------------------------------------
CREATE UNIQUE INDEX IFRMAXIMO.MAXSYSNDX_NDX ON IFRMAXIMO.MAXSYSINDEXES (
NAME ASC)
PCTFREE    10
INITRANS   2
MAXTRANS   255
TABLESPACE TSI_MAXIMO
STORAGE   (
            INITIAL    65536
            MINEXTENTS 1
            MAXEXTENTS 2147483645
           )
/

--------------------------------------------------------------------------------------------------------------------
-- CRIAÇÃO DO ÍNDICE: IFRMAXIMO.MAXSYSNDX_NDX2
--------------------------------------------------------------------------------------------------------------------
CREATE  INDEX IFRMAXIMO.MAXSYSNDX_NDX2 ON IFRMAXIMO.MAXSYSINDEXES (
TBNAME ASC)
PCTFREE    10
INITRANS   2
MAXTRANS   255
TABLESPACE TSI_MAXIMO
STORAGE   (
            INITIAL    65536
            MINEXTENTS 1
            MAXEXTENTS 2147483645
           )
/

--------------------------------------------------------------------------------------------------------------------
-- CRIAÇÃO DO ÍNDICE: IFRMAXIMO.MAXTABLEDOM_NDX1
--------------------------------------------------------------------------------------------------------------------
CREATE UNIQUE INDEX IFRMAXIMO.MAXTABLEDOM_NDX1 ON IFRMAXIMO.MAXTABLEDOMAIN (
DOMAINID ASC)
PCTFREE    10
INITRANS   2
MAXTRANS   255
TABLESPACE TSI_MAXIMO
STORAGE   (
            INITIAL    40960
            MINEXTENTS 1
            MAXEXTENTS 2147483645
           )
/

--------------------------------------------------------------------------------------------------------------------
-- CRIAÇÃO DO ÍNDICE: IFRMAXIMO.MAXTABLESCFG_NDX1
--------------------------------------------------------------------------------------------------------------------
CREATE UNIQUE INDEX IFRMAXIMO.MAXTABLESCFG_NDX1 ON IFRMAXIMO.MAXTABLESCFG (
TBNAME ASC)
PCTFREE    10
INITRANS   2
MAXTRANS   255
TABLESPACE TSI_MAXIMO
STORAGE   (
            INITIAL    65536
            MINEXTENTS 1
            MAXEXTENTS 2147483645
           )
/

--------------------------------------------------------------------------------------------------------------------
-- CRIAÇÃO DO ÍNDICE: IFRMAXIMO.MAXTABLESCFG_NDX2
--------------------------------------------------------------------------------------------------------------------
CREATE  INDEX IFRMAXIMO.MAXTABLESCFG_NDX2 ON IFRMAXIMO.MAXTABLESCFG (
APP ASC)
PCTFREE    10
INITRANS   2
MAXTRANS   255
TABLESPACE TSI_MAXIMO
STORAGE   (
            INITIAL    65536
            MINEXTENTS 1
            MAXEXTENTS 2147483645
           )
/

--------------------------------------------------------------------------------------------------------------------
-- CRIAÇÃO DO ÍNDICE: IFRMAXIMO.MAXTABLES_NDX
--------------------------------------------------------------------------------------------------------------------
CREATE UNIQUE INDEX IFRMAXIMO.MAXTABLES_NDX ON IFRMAXIMO.MAXTABLES (
TBNAME ASC)
PCTFREE    10
INITRANS   2
MAXTRANS   255
TABLESPACE TSI_MAXIMO
STORAGE   (
            INITIAL    65536
            MINEXTENTS 1
            MAXEXTENTS 2147483645
           )
/

--------------------------------------------------------------------------------------------------------------------
-- CRIAÇÃO DO ÍNDICE: IFRMAXIMO.MAXTABLES_NDX2
--------------------------------------------------------------------------------------------------------------------
CREATE  INDEX IFRMAXIMO.MAXTABLES_NDX2 ON IFRMAXIMO.MAXTABLES (
APP ASC)
PCTFREE    10
INITRANS   2
MAXTRANS   255
TABLESPACE TSI_MAXIMO
STORAGE   (
            INITIAL    65536
            MINEXTENTS 1
            MAXEXTENTS 2147483645
           )
/

--------------------------------------------------------------------------------------------------------------------
-- CRIAÇÃO DO ÍNDICE: IFRMAXIMO.MAXTABLES2_NDX1
--------------------------------------------------------------------------------------------------------------------
CREATE UNIQUE INDEX IFRMAXIMO.MAXTABLES2_NDX1 ON IFRMAXIMO.MAXTABLES2 (
TBNAME ASC)
PCTFREE    10
INITRANS   2
MAXTRANS   255
TABLESPACE TSI_MAXIMO
STORAGE   (
            INITIAL    65536
            MINEXTENTS 1
            MAXEXTENTS 2147483645
           )
/

--------------------------------------------------------------------------------------------------------------------
-- CRIAÇÃO DO ÍNDICE: IFRMAXIMO.MAXTABLES2_NDX2
--------------------------------------------------------------------------------------------------------------------
CREATE  INDEX IFRMAXIMO.MAXTABLES2_NDX2 ON IFRMAXIMO.MAXTABLES2 (
SERVICENAME ASC)
PCTFREE    10
INITRANS   2
MAXTRANS   255
TABLESPACE TSI_MAXIMO
STORAGE   (
            INITIAL    65536
            MINEXTENTS 1
            MAXEXTENTS 2147483645
           )
/

--------------------------------------------------------------------------------------------------------------------
-- CRIAÇÃO DO ÍNDICE: IFRMAXIMO.MAXTRIGGERS_NDX1
--------------------------------------------------------------------------------------------------------------------
CREATE UNIQUE INDEX IFRMAXIMO.MAXTRIGGERS_NDX1 ON IFRMAXIMO.MAXTRIGGERS (
TRIGGERNAME ASC)
PCTFREE    10
INITRANS   2
MAXTRANS   255
TABLESPACE TSI_MAXIMO
STORAGE   (
            INITIAL    65536
            MINEXTENTS 1
            MAXEXTENTS 2147483645
           )
/

--------------------------------------------------------------------------------------------------------------------
-- CRIAÇÃO DO ÍNDICE: IFRMAXIMO.MAXTRIGGERS_NDX2
--------------------------------------------------------------------------------------------------------------------
CREATE  INDEX IFRMAXIMO.MAXTRIGGERS_NDX2 ON IFRMAXIMO.MAXTRIGGERS (
TBNAME ASC)
PCTFREE    10
INITRANS   2
MAXTRANS   255
TABLESPACE TSI_MAXIMO
STORAGE   (
            INITIAL    65536
            MINEXTENTS 1
            MAXEXTENTS 2147483645
           )
/

--------------------------------------------------------------------------------------------------------------------
-- CRIAÇÃO DO ÍNDICE: IFRMAXIMO.MAXUSERAUTH_NDX2
--------------------------------------------------------------------------------------------------------------------
CREATE  INDEX IFRMAXIMO.MAXUSERAUTH_NDX2 ON IFRMAXIMO.MAXUSERAUTH (
NAME ASC)
PCTFREE    10
INITRANS   2
MAXTRANS   255
TABLESPACE TSI_MAXIMO
STORAGE   (
            INITIAL    65536
            MINEXTENTS 1
            MAXEXTENTS 2147483645
           )
/

--------------------------------------------------------------------------------------------------------------------
-- CRIAÇÃO DO ÍNDICE: IFRMAXIMO.MAXUSERGROUPS_NDX
--------------------------------------------------------------------------------------------------------------------
CREATE UNIQUE INDEX IFRMAXIMO.MAXUSERGROUPS_NDX ON IFRMAXIMO.MAXUSERGROUPS (
USRNAME ASC)
PCTFREE    10
INITRANS   2
MAXTRANS   255
TABLESPACE TSI_MAXIMO
STORAGE   (
            INITIAL    65536
            MINEXTENTS 1
            MAXEXTENTS 2147483645
           )
/

--------------------------------------------------------------------------------------------------------------------
-- CRIAÇÃO DO ÍNDICE: IFRMAXIMO.MAXUSERGROUPS_NDX2
--------------------------------------------------------------------------------------------------------------------
CREATE  INDEX IFRMAXIMO.MAXUSERGROUPS_NDX2 ON IFRMAXIMO.MAXUSERGROUPS (
WFID ASC)
PCTFREE    10
INITRANS   2
MAXTRANS   255
TABLESPACE TSI_MAXIMO
STORAGE   (
            INITIAL    65536
            MINEXTENTS 1
            MAXEXTENTS 2147483645
           )
/

--------------------------------------------------------------------------------------------------------------------
-- CRIAÇÃO DO ÍNDICE: IFRMAXIMO.MAXUSERSTATUS_NDX1
--------------------------------------------------------------------------------------------------------------------
CREATE  INDEX IFRMAXIMO.MAXUSERSTATUS_NDX1 ON IFRMAXIMO.MAXUSERSTATUS (
USERNAME ASC,
CHANGEDATE ASC)
PCTFREE    10
INITRANS   2
MAXTRANS   255
TABLESPACE TSI_MAXIMO
STORAGE   (
            INITIAL    65536
            MINEXTENTS 1
            MAXEXTENTS 2147483645
           )
/

--------------------------------------------------------------------------------------------------------------------
-- CRIAÇÃO DO ÍNDICE: IFRMAXIMO.MAXUSRAUTH_NDX
--------------------------------------------------------------------------------------------------------------------
CREATE UNIQUE INDEX IFRMAXIMO.MAXUSRAUTH_NDX ON IFRMAXIMO.MAXUSERAUTH (
APP ASC,
OPTIONNAME ASC,
NAME ASC)
PCTFREE    10
INITRANS   2
MAXTRANS   255
TABLESPACE TSI_MAXIMO
STORAGE   (
            INITIAL    65536
            MINEXTENTS 1
            MAXEXTENTS 2147483645
           )
/

--------------------------------------------------------------------------------------------------------------------
-- CRIAÇÃO DO ÍNDICE: IFRMAXIMO.MAXVARS_NDX1
--------------------------------------------------------------------------------------------------------------------
CREATE UNIQUE INDEX IFRMAXIMO.MAXVARS_NDX1 ON IFRMAXIMO.MAXVARS (
VARNAME ASC,
ORGID ASC,
SITEID ASC)
PCTFREE    10
INITRANS   2
MAXTRANS   255
TABLESPACE TSI_MAXIMO
STORAGE   (
            INITIAL    65536
            MINEXTENTS 1
            MAXEXTENTS 2147483645
           )
/

--------------------------------------------------------------------------------------------------------------------
-- CRIAÇÃO DO ÍNDICE: IFRMAXIMO.MAXVARS_NDX2
--------------------------------------------------------------------------------------------------------------------
CREATE UNIQUE INDEX IFRMAXIMO.MAXVARS_NDX2 ON IFRMAXIMO.MAXVARS (
VARNAME ASC,
SITEID ASC,
ORGID ASC)
PCTFREE    10
INITRANS   2
MAXTRANS   255
TABLESPACE TSI_MAXIMO
STORAGE   (
            INITIAL    65536
            MINEXTENTS 1
            MAXEXTENTS 2147483645
           )
/

--------------------------------------------------------------------------------------------------------------------
-- CRIAÇÃO DO ÍNDICE: IFRMAXIMO.MAXVARTYPE_NDX1
--------------------------------------------------------------------------------------------------------------------
CREATE UNIQUE INDEX IFRMAXIMO.MAXVARTYPE_NDX1 ON IFRMAXIMO.MAXVARTYPE (
VARNAME ASC)
PCTFREE    10
INITRANS   2
MAXTRANS   255
TABLESPACE TSI_MAXIMO
STORAGE   (
            INITIAL    65536
            MINEXTENTS 1
            MAXEXTENTS 2147483645
           )
/

--------------------------------------------------------------------------------------------------------------------
-- CRIAÇÃO DO ÍNDICE: IFRMAXIMO.MEASUREMENT_NDX1
--------------------------------------------------------------------------------------------------------------------
CREATE  INDEX IFRMAXIMO.MEASUREMENT_NDX1 ON IFRMAXIMO.MEASUREMENT (
SITEID ASC,
POINTNUM ASC,
MEASUREDATE ASC)
PCTFREE    10
INITRANS   2
MAXTRANS   255
TABLESPACE TSI_MAXIMO
STORAGE   (
            INITIAL    65536
            MINEXTENTS 1
            MAXEXTENTS 2147483645
           )
/

--------------------------------------------------------------------------------------------------------------------
-- CRIAÇÃO DO ÍNDICE: IFRMAXIMO.MEASUREPOINT_NDX1
--------------------------------------------------------------------------------------------------------------------
CREATE UNIQUE INDEX IFRMAXIMO.MEASUREPOINT_NDX1 ON IFRMAXIMO.MEASUREPOINT (
SITEID ASC,
POINTNUM ASC)
PCTFREE    10
INITRANS   2
MAXTRANS   255
TABLESPACE TSI_MAXIMO
STORAGE   (
            INITIAL    65536
            MINEXTENTS 1
            MAXEXTENTS 2147483645
           )
/

--------------------------------------------------------------------------------------------------------------------
-- CRIAÇÃO DO ÍNDICE: IFRMAXIMO.MEASUREPOINT_NDX2
--------------------------------------------------------------------------------------------------------------------
CREATE UNIQUE INDEX IFRMAXIMO.MEASUREPOINT_NDX2 ON IFRMAXIMO.MEASUREPOINT (
SITEID ASC,
EQNUM ASC,
POINTNUM ASC,
POINTNAME ASC)
PCTFREE    10
INITRANS   2
MAXTRANS   255
TABLESPACE TSI_MAXIMO
STORAGE   (
            INITIAL    65536
            MINEXTENTS 1
            MAXEXTENTS 2147483645
           )
/

--------------------------------------------------------------------------------------------------------------------
-- CRIAÇÃO DO ÍNDICE: IFRMAXIMO.MEASUREUNIT_NDX1
--------------------------------------------------------------------------------------------------------------------
CREATE UNIQUE INDEX IFRMAXIMO.MEASUREUNIT_NDX1 ON IFRMAXIMO.MEASUREUNIT (
ORGID ASC,
MEASUREUNITID ASC)
PCTFREE    10
INITRANS   2
MAXTRANS   255
TABLESPACE TSI_MAXIMO
STORAGE   (
            INITIAL    65536
            MINEXTENTS 1
            MAXEXTENTS 2147483645
           )
/

--------------------------------------------------------------------------------------------------------------------
-- CRIAÇÃO DO ÍNDICE: IFRMAXIMO.MRCOST_NDX1
--------------------------------------------------------------------------------------------------------------------
CREATE UNIQUE INDEX IFRMAXIMO.MRCOST_NDX1 ON IFRMAXIMO.MRCOST (
SITEID ASC,
MRCOSTLINEID ASC)
PCTFREE    10
INITRANS   2
MAXTRANS   255
TABLESPACE TSI_MAXIMO
STORAGE   (
            INITIAL    65536
            MINEXTENTS 1
            MAXEXTENTS 2147483645
           )
/

--------------------------------------------------------------------------------------------------------------------
-- CRIAÇÃO DO ÍNDICE: IFRMAXIMO.MRLINE_NDX1
--------------------------------------------------------------------------------------------------------------------
CREATE UNIQUE INDEX IFRMAXIMO.MRLINE_NDX1 ON IFRMAXIMO.MRLINE (
SITEID ASC,
MRLINEID ASC)
PCTFREE    10
INITRANS   2
MAXTRANS   255
TABLESPACE TSI_MAXIMO
STORAGE   (
            INITIAL    65536
            MINEXTENTS 1
            MAXEXTENTS 2147483645
           )
/

--------------------------------------------------------------------------------------------------------------------
-- CRIAÇÃO DO ÍNDICE: IFRMAXIMO.MRLINE_NDX2
--------------------------------------------------------------------------------------------------------------------
CREATE UNIQUE INDEX IFRMAXIMO.MRLINE_NDX2 ON IFRMAXIMO.MRLINE (
SITEID ASC,
MRNUM ASC,
MRLINENUM ASC)
PCTFREE    10
INITRANS   2
MAXTRANS   255
TABLESPACE TSI_MAXIMO
STORAGE   (
            INITIAL    65536
            MINEXTENTS 1
            MAXEXTENTS 2147483645
           )
/

--------------------------------------------------------------------------------------------------------------------
-- CRIAÇÃO DO ÍNDICE: IFRMAXIMO.MRLINE_NDX3
--------------------------------------------------------------------------------------------------------------------
CREATE  INDEX IFRMAXIMO.MRLINE_NDX3 ON IFRMAXIMO.MRLINE (
SITEID ASC,
PRNUM ASC)
PCTFREE    10
INITRANS   2
MAXTRANS   255
TABLESPACE TSI_MAXIMO
STORAGE   (
            INITIAL    65536
            MINEXTENTS 1
            MAXEXTENTS 2147483645
           )
/

--------------------------------------------------------------------------------------------------------------------
-- CRIAÇÃO DO ÍNDICE: IFRMAXIMO.MR_NDX1
--------------------------------------------------------------------------------------------------------------------
CREATE UNIQUE INDEX IFRMAXIMO.MR_NDX1 ON IFRMAXIMO.MR (
SITEID ASC,
MRNUM ASC)
PCTFREE    10
INITRANS   2
MAXTRANS   255
TABLESPACE TSI_MAXIMO
STORAGE   (
            INITIAL    65536
            MINEXTENTS 1
            MAXEXTENTS 2147483645
           )
/

--------------------------------------------------------------------------------------------------------------------
-- CRIAÇÃO DO ÍNDICE: IFRMAXIMO.MR_NDX2
--------------------------------------------------------------------------------------------------------------------
CREATE  INDEX IFRMAXIMO.MR_NDX2 ON IFRMAXIMO.MR (
SITEID ASC,
WFID ASC)
PCTFREE    10
INITRANS   2
MAXTRANS   255
TABLESPACE TSI_MAXIMO
STORAGE   (
            INITIAL    65536
            MINEXTENTS 1
            MAXEXTENTS 2147483645
           )
/

--------------------------------------------------------------------------------------------------------------------
-- CRIAÇÃO DO ÍNDICE: IFRMAXIMO.MRSTATUS_NDX1
--------------------------------------------------------------------------------------------------------------------
CREATE UNIQUE INDEX IFRMAXIMO.MRSTATUS_NDX1 ON IFRMAXIMO.MRSTATUS (
SITEID ASC,
MRSTATUSSEQ ASC)
PCTFREE    10
INITRANS   2
MAXTRANS   255
TABLESPACE TSI_MAXIMO
STORAGE   (
            INITIAL    65536
            MINEXTENTS 1
            MAXEXTENTS 2147483645
           )
/

--------------------------------------------------------------------------------------------------------------------
-- CRIAÇÃO DO ÍNDICE: IFRMAXIMO.MRSTATUS_NDX2
--------------------------------------------------------------------------------------------------------------------
CREATE  INDEX IFRMAXIMO.MRSTATUS_NDX2 ON IFRMAXIMO.MRSTATUS (
SITEID ASC,
MRNUM ASC)
PCTFREE    10
INITRANS   2
MAXTRANS   255
TABLESPACE TSI_MAXIMO
STORAGE   (
            INITIAL    65536
            MINEXTENTS 1
            MAXEXTENTS 2147483645
           )
/

--------------------------------------------------------------------------------------------------------------------
-- CRIAÇÃO DO ÍNDICE: IFRMAXIMO.MXCOLLAB_NDX2
--------------------------------------------------------------------------------------------------------------------
CREATE UNIQUE INDEX IFRMAXIMO.MXCOLLAB_NDX2 ON IFRMAXIMO.MXCOLLAB (
OWNER1SYSID ASC,
OWNER2SYSID ASC,
PCID ASC)
PCTFREE    10
INITRANS   2
MAXTRANS   255
TABLESPACE TSI_MAXIMO
STORAGE   (
            INITIAL    65536
            MINEXTENTS 1
            MAXEXTENTS 2147483645
           )
/

--------------------------------------------------------------------------------------------------------------------
-- CRIAÇÃO DO ÍNDICE: IFRMAXIMO.MXCOLLABREF_NDX
--------------------------------------------------------------------------------------------------------------------
CREATE UNIQUE INDEX IFRMAXIMO.MXCOLLABREF_NDX ON IFRMAXIMO.MXCOLLABREF (
PCID ASC)
PCTFREE    10
INITRANS   2
MAXTRANS   255
TABLESPACE TSI_MAXIMO
STORAGE   (
            INITIAL    65536
            MINEXTENTS 1
            MAXEXTENTS 2147483645
           )
/

--------------------------------------------------------------------------------------------------------------------
-- CRIAÇÃO DO ÍNDICE: IFRMAXIMO.NUMDOMAINVAL_NDX1
--------------------------------------------------------------------------------------------------------------------
CREATE UNIQUE INDEX IFRMAXIMO.NUMDOMAINVAL_NDX1 ON IFRMAXIMO.NUMDOMAINVALUE (
DOMAINID ASC,
NUMVALUE ASC)
PCTFREE    10
INITRANS   2
MAXTRANS   255
TABLESPACE TSI_MAXIMO
STORAGE   (
            INITIAL    40960
            MINEXTENTS 1
            MAXEXTENTS 2147483645
           )
/

--------------------------------------------------------------------------------------------------------------------
-- CRIAÇÃO DO ÍNDICE: IFRMAXIMO.ORDERUNIT_NDX1
--------------------------------------------------------------------------------------------------------------------
CREATE UNIQUE INDEX IFRMAXIMO.ORDERUNIT_NDX1 ON IFRMAXIMO.ORDERUNIT (
ORGID ASC,
ORDERUNIT ASC)
PCTFREE    10
INITRANS   2
MAXTRANS   255
TABLESPACE TSI_MAXIMO
STORAGE   (
            INITIAL    65536
            MINEXTENTS 1
            MAXEXTENTS 2147483645
           )
/

--------------------------------------------------------------------------------------------------------------------
-- CRIAÇÃO DO ÍNDICE: IFRMAXIMO.ORGANIZATION_NDX
--------------------------------------------------------------------------------------------------------------------
CREATE UNIQUE INDEX IFRMAXIMO.ORGANIZATION_NDX ON IFRMAXIMO.ORGANIZATION (
ORGID ASC)
PCTFREE    10
INITRANS   2
MAXTRANS   255
TABLESPACE TSI_MAXIMO
STORAGE   (
            INITIAL    65536
            MINEXTENTS 1
            MAXEXTENTS 2147483645
           )
/

--------------------------------------------------------------------------------------------------------------------
-- CRIAÇÃO DO ÍNDICE: IFRMAXIMO.PMANCESTOR_NDX1
--------------------------------------------------------------------------------------------------------------------
CREATE UNIQUE INDEX IFRMAXIMO.PMANCESTOR_NDX1 ON IFRMAXIMO.PMANCESTOR (
SITEID ASC,
PMNUM ASC,
ANCESTOR ASC)
PCTFREE    10
INITRANS   2
MAXTRANS   255
TABLESPACE TSI_MAXIMO
STORAGE   (
            INITIAL    65536
            MINEXTENTS 1
            MAXEXTENTS 2147483645
           )
/

--------------------------------------------------------------------------------------------------------------------
-- CRIAÇÃO DO ÍNDICE: IFRMAXIMO.PM_NDX1
--------------------------------------------------------------------------------------------------------------------
CREATE UNIQUE INDEX IFRMAXIMO.PM_NDX1 ON IFRMAXIMO.PM (
SITEID ASC,
PMNUM ASC)
PCTFREE    10
INITRANS   2
MAXTRANS   255
TABLESPACE TSI_MAXIMO
STORAGE   (
            INITIAL    65536
            MINEXTENTS 1
            MAXEXTENTS 2147483645
           )
/

--------------------------------------------------------------------------------------------------------------------
-- CRIAÇÃO DO ÍNDICE: IFRMAXIMO.PM_NDX2
--------------------------------------------------------------------------------------------------------------------
CREATE  INDEX IFRMAXIMO.PM_NDX2 ON IFRMAXIMO.PM (
SITEID ASC,
EQNUM ASC)
PCTFREE    10
INITRANS   2
MAXTRANS   255
TABLESPACE TSI_MAXIMO
STORAGE   (
            INITIAL    65536
            MINEXTENTS 1
            MAXEXTENTS 2147483645
           )
/

--------------------------------------------------------------------------------------------------------------------
-- CRIAÇÃO DO ÍNDICE: IFRMAXIMO.PM_NDX3
--------------------------------------------------------------------------------------------------------------------
CREATE  INDEX IFRMAXIMO.PM_NDX3 ON IFRMAXIMO.PM (
SITEID ASC,
LOCATION ASC)
PCTFREE    10
INITRANS   2
MAXTRANS   255
TABLESPACE TSI_MAXIMO
STORAGE   (
            INITIAL    65536
            MINEXTENTS 1
            MAXEXTENTS 2147483645
           )
/

--------------------------------------------------------------------------------------------------------------------
-- CRIAÇÃO DO ÍNDICE: IFRMAXIMO.PM_NDX4
--------------------------------------------------------------------------------------------------------------------
CREATE  INDEX IFRMAXIMO.PM_NDX4 ON IFRMAXIMO.PM (
SITEID ASC,
PARENT ASC)
PCTFREE    10
INITRANS   2
MAXTRANS   255
TABLESPACE TSI_MAXIMO
STORAGE   (
            INITIAL    65536
            MINEXTENTS 1
            MAXEXTENTS 2147483645
           )
/

--------------------------------------------------------------------------------------------------------------------
-- CRIAÇÃO DO ÍNDICE: IFRMAXIMO.PM_NDX5
--------------------------------------------------------------------------------------------------------------------
CREATE  INDEX IFRMAXIMO.PM_NDX5 ON IFRMAXIMO.PM (
PM18 ASC,
SITEID ASC)
PCTFREE    10
INITRANS   2
MAXTRANS   255
TABLESPACE TSI_MAXIMO
STORAGE   (
            INITIAL    65536
            MINEXTENTS 1
            MAXEXTENTS 2147483645
           )
/

--------------------------------------------------------------------------------------------------------------------
-- CRIAÇÃO DO ÍNDICE: IFRMAXIMO.PMSCHEDACT_NDX1
--------------------------------------------------------------------------------------------------------------------
CREATE UNIQUE INDEX IFRMAXIMO.PMSCHEDACT_NDX1 ON IFRMAXIMO.PMSCHEDACTIVITY (
SITEID ASC,
PROJECTNAME ASC,
PMSCHEDACTIVITYID ASC)
PCTFREE    10
INITRANS   2
MAXTRANS   255
TABLESPACE TSI_MAXIMO
STORAGE   (
            INITIAL    65536
            MINEXTENTS 1
            MAXEXTENTS 2147483645
           )
/

--------------------------------------------------------------------------------------------------------------------
-- CRIAÇÃO DO ÍNDICE: IFRMAXIMO.PMSEQUENCE_NDX1
--------------------------------------------------------------------------------------------------------------------
CREATE UNIQUE INDEX IFRMAXIMO.PMSEQUENCE_NDX1 ON IFRMAXIMO.PMSEQUENCE (
SITEID ASC,
PMNUM ASC,
INTERVAL ASC)
PCTFREE    10
INITRANS   2
MAXTRANS   255
TABLESPACE TSI_MAXIMO
STORAGE   (
            INITIAL    65536
            MINEXTENTS 1
            MAXEXTENTS 2147483645
           )
/

--------------------------------------------------------------------------------------------------------------------
-- CRIAÇÃO DO ÍNDICE: IFRMAXIMO.POCOST_NDX1
--------------------------------------------------------------------------------------------------------------------
CREATE UNIQUE INDEX IFRMAXIMO.POCOST_NDX1 ON IFRMAXIMO.POCOST (
ORGID ASC,
POCOSTLINEID ASC)
PCTFREE    10
INITRANS   2
MAXTRANS   255
TABLESPACE TSI_MAXIMO
STORAGE   (
            INITIAL    65536
            MINEXTENTS 1
            MAXEXTENTS 2147483645
           )
/

--------------------------------------------------------------------------------------------------------------------
-- CRIAÇÃO DO ÍNDICE: IFRMAXIMO.POECOMSTATUS_NDX1
--------------------------------------------------------------------------------------------------------------------
CREATE  INDEX IFRMAXIMO.POECOMSTATUS_NDX1 ON IFRMAXIMO.POECOMSTATUS (
ORGID ASC,
PONUM ASC)
PCTFREE    10
INITRANS   2
MAXTRANS   255
TABLESPACE TSI_MAXIMO
STORAGE   (
            INITIAL    65536
            MINEXTENTS 1
            MAXEXTENTS 2147483645
           )
/

--------------------------------------------------------------------------------------------------------------------
-- CRIAÇÃO DO ÍNDICE: IFRMAXIMO.POECOMSTATUS_NDX2
--------------------------------------------------------------------------------------------------------------------
CREATE  INDEX IFRMAXIMO.POECOMSTATUS_NDX2 ON IFRMAXIMO.POECOMSTATUS (
ORGID ASC,
CHANGEDATE ASC,
PONUM ASC)
PCTFREE    10
INITRANS   2
MAXTRANS   255
TABLESPACE TSI_MAXIMO
STORAGE   (
            INITIAL    65536
            MINEXTENTS 1
            MAXEXTENTS 2147483645
           )
/

--------------------------------------------------------------------------------------------------------------------
-- CRIAÇÃO DO ÍNDICE: IFRMAXIMO.POINTWO_NDX1
--------------------------------------------------------------------------------------------------------------------
CREATE UNIQUE INDEX IFRMAXIMO.POINTWO_NDX1 ON IFRMAXIMO.POINTWO (
SITEID ASC,
WONUM ASC,
POINTNUM ASC)
PCTFREE    10
INITRANS   2
MAXTRANS   255
TABLESPACE TSI_MAXIMO
STORAGE   (
            INITIAL    65536
            MINEXTENTS 1
            MAXEXTENTS 2147483645
           )
/

--------------------------------------------------------------------------------------------------------------------
-- CRIAÇÃO DO ÍNDICE: IFRMAXIMO.POINTWO_NDX2
--------------------------------------------------------------------------------------------------------------------
CREATE  INDEX IFRMAXIMO.POINTWO_NDX2 ON IFRMAXIMO.POINTWO (
SITEID ASC,
POINTNUM ASC)
PCTFREE    10
INITRANS   2
MAXTRANS   255
TABLESPACE TSI_MAXIMO
STORAGE   (
            INITIAL    65536
            MINEXTENTS 1
            MAXEXTENTS 2147483645
           )
/

--------------------------------------------------------------------------------------------------------------------
-- CRIAÇÃO DO ÍNDICE: IFRMAXIMO.POLINE_NDX1
--------------------------------------------------------------------------------------------------------------------
CREATE UNIQUE INDEX IFRMAXIMO.POLINE_NDX1 ON IFRMAXIMO.POLINE (
ORGID ASC,
POLINEID ASC)
PCTFREE    10
INITRANS   2
MAXTRANS   255
TABLESPACE TSI_MAXIMO
STORAGE   (
            INITIAL    65536
            MINEXTENTS 1
            MAXEXTENTS 2147483645
           )
/

--------------------------------------------------------------------------------------------------------------------
-- CRIAÇÃO DO ÍNDICE: IFRMAXIMO.POLINE_NDX2
--------------------------------------------------------------------------------------------------------------------
CREATE  INDEX IFRMAXIMO.POLINE_NDX2 ON IFRMAXIMO.POLINE (
ORGID ASC,
PONUM ASC,
POLINENUM ASC)
PCTFREE    10
INITRANS   2
MAXTRANS   255
TABLESPACE TSI_MAXIMO
STORAGE   (
            INITIAL    65536
            MINEXTENTS 1
            MAXEXTENTS 2147483645
           )
/

--------------------------------------------------------------------------------------------------------------------
-- CRIAÇÃO DO ÍNDICE: IFRMAXIMO.POLINE_NDX3
--------------------------------------------------------------------------------------------------------------------
CREATE  INDEX IFRMAXIMO.POLINE_NDX3 ON IFRMAXIMO.POLINE (
ORGID ASC,
ITEMNUM ASC)
PCTFREE    10
INITRANS   2
MAXTRANS   255
TABLESPACE TSI_MAXIMO
STORAGE   (
            INITIAL    65536
            MINEXTENTS 1
            MAXEXTENTS 2147483645
           )
/

--------------------------------------------------------------------------------------------------------------------
-- CRIAÇÃO DO ÍNDICE: IFRMAXIMO.POLINE_NDX4
--------------------------------------------------------------------------------------------------------------------
CREATE  INDEX IFRMAXIMO.POLINE_NDX4 ON IFRMAXIMO.POLINE (
ORGID ASC,
CATALOGCODE ASC)
PCTFREE    10
INITRANS   2
MAXTRANS   255
TABLESPACE TSI_MAXIMO
STORAGE   (
            INITIAL    65536
            MINEXTENTS 1
            MAXEXTENTS 2147483645
           )
/

--------------------------------------------------------------------------------------------------------------------
-- CRIAÇÃO DO ÍNDICE: IFRMAXIMO.POLINE_NDX5
--------------------------------------------------------------------------------------------------------------------
CREATE  INDEX IFRMAXIMO.POLINE_NDX5 ON IFRMAXIMO.POLINE (
ORGID ASC,
ITEMNUM ASC,
CATALOGCODE ASC,
PONUM ASC,
POLINENUM ASC)
PCTFREE    10
INITRANS   2
MAXTRANS   255
TABLESPACE TSI_MAXIMO
STORAGE   (
            INITIAL    65536
            MINEXTENTS 1
            MAXEXTENTS 2147483645
           )
/

--------------------------------------------------------------------------------------------------------------------
-- CRIAÇÃO DO ÍNDICE: IFRMAXIMO.POLINE_NDX6
--------------------------------------------------------------------------------------------------------------------
CREATE  INDEX IFRMAXIMO.POLINE_NDX6 ON IFRMAXIMO.POLINE (
ORDERUNIT ASC,
MRNUM ASC,
MRLINENUM ASC)
PCTFREE    10
INITRANS   2
MAXTRANS   255
TABLESPACE TSI_MAXIMO
STORAGE   (
            INITIAL    65536
            MINEXTENTS 1
            MAXEXTENTS 2147483645
           )
/

--------------------------------------------------------------------------------------------------------------------
-- CRIAÇÃO DO ÍNDICE: IFRMAXIMO.PO_NDX1
--------------------------------------------------------------------------------------------------------------------
CREATE UNIQUE INDEX IFRMAXIMO.PO_NDX1 ON IFRMAXIMO.PO (
ORGID ASC,
PONUM ASC)
PCTFREE    10
INITRANS   2
MAXTRANS   255
TABLESPACE TSI_MAXIMO
STORAGE   (
            INITIAL    65536
            MINEXTENTS 1
            MAXEXTENTS 2147483645
           )
/

--------------------------------------------------------------------------------------------------------------------
-- CRIAÇÃO DO ÍNDICE: IFRMAXIMO.PO_NDX2
--------------------------------------------------------------------------------------------------------------------
CREATE  INDEX IFRMAXIMO.PO_NDX2 ON IFRMAXIMO.PO (
ORGID ASC,
VENDOR ASC,
POTYPE ASC)
PCTFREE    10
INITRANS   2
MAXTRANS   255
TABLESPACE TSI_MAXIMO
STORAGE   (
            INITIAL    65536
            MINEXTENTS 1
            MAXEXTENTS 2147483645
           )
/

--------------------------------------------------------------------------------------------------------------------
-- CRIAÇÃO DO ÍNDICE: IFRMAXIMO.PO_NDX3
--------------------------------------------------------------------------------------------------------------------
CREATE  INDEX IFRMAXIMO.PO_NDX3 ON IFRMAXIMO.PO (
ORGID ASC,
ORIGINALPONUM ASC)
PCTFREE    10
INITRANS   2
MAXTRANS   255
TABLESPACE TSI_MAXIMO
STORAGE   (
            INITIAL    65536
            MINEXTENTS 1
            MAXEXTENTS 2147483645
           )
/

--------------------------------------------------------------------------------------------------------------------
-- CRIAÇÃO DO ÍNDICE: IFRMAXIMO.PO_NDX4
--------------------------------------------------------------------------------------------------------------------
CREATE  INDEX IFRMAXIMO.PO_NDX4 ON IFRMAXIMO.PO (
ORGID ASC,
INTERID ASC)
PCTFREE    10
INITRANS   2
MAXTRANS   255
TABLESPACE TSI_MAXIMO
STORAGE   (
            INITIAL    65536
            MINEXTENTS 1
            MAXEXTENTS 2147483645
           )
/

--------------------------------------------------------------------------------------------------------------------
-- CRIAÇÃO DO ÍNDICE: IFRMAXIMO.PO_NDX5
--------------------------------------------------------------------------------------------------------------------
CREATE  INDEX IFRMAXIMO.PO_NDX5 ON IFRMAXIMO.PO (
ORGID ASC,
WFID ASC)
PCTFREE    10
INITRANS   2
MAXTRANS   255
TABLESPACE TSI_MAXIMO
STORAGE   (
            INITIAL    65536
            MINEXTENTS 1
            MAXEXTENTS 2147483645
           )
/

--------------------------------------------------------------------------------------------------------------------
-- CRIAÇÃO DO ÍNDICE: IFRMAXIMO.POSTATUS_NDX1
--------------------------------------------------------------------------------------------------------------------
CREATE  INDEX IFRMAXIMO.POSTATUS_NDX1 ON IFRMAXIMO.POSTATUS (
ORGID ASC,
PONUM ASC)
PCTFREE    10
INITRANS   2
MAXTRANS   255
TABLESPACE TSI_MAXIMO
STORAGE   (
            INITIAL    65536
            MINEXTENTS 1
            MAXEXTENTS 2147483645
           )
/

--------------------------------------------------------------------------------------------------------------------
-- CRIAÇÃO DO ÍNDICE: IFRMAXIMO.POSTATUS_NDX2
--------------------------------------------------------------------------------------------------------------------
CREATE  INDEX IFRMAXIMO.POSTATUS_NDX2 ON IFRMAXIMO.POSTATUS (
ORGID ASC,
CHANGEDATE ASC,
PONUM ASC)
PCTFREE    10
INITRANS   2
MAXTRANS   255
TABLESPACE TSI_MAXIMO
STORAGE   (
            INITIAL    65536
            MINEXTENTS 1
            MAXEXTENTS 2147483645
           )
/

--------------------------------------------------------------------------------------------------------------------
-- CRIAÇÃO DO ÍNDICE: IFRMAXIMO.PRCOST_NDX1
--------------------------------------------------------------------------------------------------------------------
CREATE UNIQUE INDEX IFRMAXIMO.PRCOST_NDX1 ON IFRMAXIMO.PRCOST (
SITEID ASC,
PRCOSTLINEID ASC)
PCTFREE    10
INITRANS   2
MAXTRANS   255
TABLESPACE TSI_MAXIMO
STORAGE   (
            INITIAL    65536
            MINEXTENTS 1
            MAXEXTENTS 2147483645
           )
/

--------------------------------------------------------------------------------------------------------------------
-- CRIAÇÃO DO ÍNDICE: IFRMAXIMO.PRECAUTION_NDX1
--------------------------------------------------------------------------------------------------------------------
CREATE UNIQUE INDEX IFRMAXIMO.PRECAUTION_NDX1 ON IFRMAXIMO.PRECAUTION (
SITEID ASC,
PRECAUTIONID ASC)
PCTFREE    10
INITRANS   2
MAXTRANS   255
TABLESPACE TSI_MAXIMO
STORAGE   (
            INITIAL    65536
            MINEXTENTS 1
            MAXEXTENTS 2147483645
           )
/

--------------------------------------------------------------------------------------------------------------------
-- CRIAÇÃO DO ÍNDICE: IFRMAXIMO.PRICALC_NDX1
--------------------------------------------------------------------------------------------------------------------
CREATE UNIQUE INDEX IFRMAXIMO.PRICALC_NDX1 ON IFRMAXIMO.PRICALC (
SITEID ASC,
FINDEX ASC)
PCTFREE    10
INITRANS   2
MAXTRANS   255
TABLESPACE TSI_MAXIMO
STORAGE   (
            INITIAL    65536
            MINEXTENTS 1
            MAXEXTENTS 2147483645
           )
/

--------------------------------------------------------------------------------------------------------------------
-- CRIAÇÃO DO ÍNDICE: IFRMAXIMO.PRINTER_NDX1
--------------------------------------------------------------------------------------------------------------------
CREATE UNIQUE INDEX IFRMAXIMO.PRINTER_NDX1 ON IFRMAXIMO.PRINTER (
TBNAME ASC,
COLNAME ASC,
VALUE ASC)
PCTFREE    10
INITRANS   2
MAXTRANS   255
TABLESPACE TSI_MAXIMO
STORAGE   (
            INITIAL    65536
            MINEXTENTS 1
            MAXEXTENTS 2147483645
           )
/

--------------------------------------------------------------------------------------------------------------------
-- CRIAÇÃO DO ÍNDICE: IFRMAXIMO.PRLINE_NDX1
--------------------------------------------------------------------------------------------------------------------
CREATE UNIQUE INDEX IFRMAXIMO.PRLINE_NDX1 ON IFRMAXIMO.PRLINE (
SITEID ASC,
PRLINEID ASC)
PCTFREE    10
INITRANS   2
MAXTRANS   255
TABLESPACE TSI_MAXIMO
STORAGE   (
            INITIAL    65536
            MINEXTENTS 1
            MAXEXTENTS 2147483645
           )
/

--------------------------------------------------------------------------------------------------------------------
-- CRIAÇÃO DO ÍNDICE: IFRMAXIMO.PRLINE_NDX2
--------------------------------------------------------------------------------------------------------------------
CREATE  INDEX IFRMAXIMO.PRLINE_NDX2 ON IFRMAXIMO.PRLINE (
SITEID ASC,
POLINEID ASC)
PCTFREE    10
INITRANS   2
MAXTRANS   255
TABLESPACE TSI_MAXIMO
STORAGE   (
            INITIAL    65536
            MINEXTENTS 1
            MAXEXTENTS 2147483645
           )
/

--------------------------------------------------------------------------------------------------------------------
-- CRIAÇÃO DO ÍNDICE: IFRMAXIMO.PRLINE_NDX3
--------------------------------------------------------------------------------------------------------------------
CREATE  INDEX IFRMAXIMO.PRLINE_NDX3 ON IFRMAXIMO.PRLINE (
SITEID ASC,
PONUM ASC,
POLINENUM ASC)
PCTFREE    10
INITRANS   2
MAXTRANS   255
TABLESPACE TSI_MAXIMO
STORAGE   (
            INITIAL    65536
            MINEXTENTS 1
            MAXEXTENTS 2147483645
           )
/

--------------------------------------------------------------------------------------------------------------------
-- CRIAÇÃO DO ÍNDICE: IFRMAXIMO.PRLINE_NDX4
--------------------------------------------------------------------------------------------------------------------
CREATE  INDEX IFRMAXIMO.PRLINE_NDX4 ON IFRMAXIMO.PRLINE (
SITEID ASC,
MRNUM ASC,
MRLINENUM ASC)
PCTFREE    10
INITRANS   2
MAXTRANS   255
TABLESPACE TSI_MAXIMO
STORAGE   (
            INITIAL    65536
            MINEXTENTS 1
            MAXEXTENTS 2147483645
           )
/

--------------------------------------------------------------------------------------------------------------------
-- CRIAÇÃO DO ÍNDICE: IFRMAXIMO.PRLINE_NDX5
--------------------------------------------------------------------------------------------------------------------
CREATE  INDEX IFRMAXIMO.PRLINE_NDX5 ON IFRMAXIMO.PRLINE (
SITEID ASC,
ITEMNUM ASC)
PCTFREE    10
INITRANS   2
MAXTRANS   255
TABLESPACE TSI_MAXIMO
STORAGE   (
            INITIAL    65536
            MINEXTENTS 1
            MAXEXTENTS 2147483645
           )
/

--------------------------------------------------------------------------------------------------------------------
-- CRIAÇÃO DO ÍNDICE: IFRMAXIMO.PRLINE_NDX6
--------------------------------------------------------------------------------------------------------------------
CREATE  INDEX IFRMAXIMO.PRLINE_NDX6 ON IFRMAXIMO.PRLINE (
SITEID ASC,
RFQLINEID ASC)
PCTFREE    10
INITRANS   2
MAXTRANS   255
TABLESPACE TSI_MAXIMO
STORAGE   (
            INITIAL    65536
            MINEXTENTS 1
            MAXEXTENTS 2147483645
           )
/

--------------------------------------------------------------------------------------------------------------------
-- CRIAÇÃO DO ÍNDICE: IFRMAXIMO.PRLINE_NDX7
--------------------------------------------------------------------------------------------------------------------
CREATE  INDEX IFRMAXIMO.PRLINE_NDX7 ON IFRMAXIMO.PRLINE (
SITEID ASC,
RFQNUM ASC,
RFQLINENUM ASC)
PCTFREE    10
INITRANS   2
MAXTRANS   255
TABLESPACE TSI_MAXIMO
STORAGE   (
            INITIAL    65536
            MINEXTENTS 1
            MAXEXTENTS 2147483645
           )
/

--------------------------------------------------------------------------------------------------------------------
-- CRIAÇÃO DO ÍNDICE: IFRMAXIMO.PRLINE_NDX8
--------------------------------------------------------------------------------------------------------------------
CREATE  INDEX IFRMAXIMO.PRLINE_NDX8 ON IFRMAXIMO.PRLINE (
SITEID ASC,
PRNUM ASC,
PRLINENUM ASC)
PCTFREE    10
INITRANS   2
MAXTRANS   255
TABLESPACE TSI_MAXIMO
STORAGE   (
            INITIAL    65536
            MINEXTENTS 1
            MAXEXTENTS 2147483645
           )
/

--------------------------------------------------------------------------------------------------------------------
-- CRIAÇÃO DO ÍNDICE: IFRMAXIMO.PR_NDX1
--------------------------------------------------------------------------------------------------------------------
CREATE UNIQUE INDEX IFRMAXIMO.PR_NDX1 ON IFRMAXIMO.PR (
SITEID ASC,
PRNUM ASC)
PCTFREE    10
INITRANS   2
MAXTRANS   255
TABLESPACE TSI_MAXIMO
STORAGE   (
            INITIAL    65536
            MINEXTENTS 1
            MAXEXTENTS 2147483645
           )
/

--------------------------------------------------------------------------------------------------------------------
-- CRIAÇÃO DO ÍNDICE: IFRMAXIMO.PR_NDX2
--------------------------------------------------------------------------------------------------------------------
CREATE  INDEX IFRMAXIMO.PR_NDX2 ON IFRMAXIMO.PR (
SITEID ASC,
VENDOR ASC)
PCTFREE    10
INITRANS   2
MAXTRANS   255
TABLESPACE TSI_MAXIMO
STORAGE   (
            INITIAL    65536
            MINEXTENTS 1
            MAXEXTENTS 2147483645
           )
/

--------------------------------------------------------------------------------------------------------------------
-- CRIAÇÃO DO ÍNDICE: IFRMAXIMO.PR_NDX3
--------------------------------------------------------------------------------------------------------------------
CREATE  INDEX IFRMAXIMO.PR_NDX3 ON IFRMAXIMO.PR (
SITEID ASC,
INTERID ASC)
PCTFREE    10
INITRANS   2
MAXTRANS   255
TABLESPACE TSI_MAXIMO
STORAGE   (
            INITIAL    65536
            MINEXTENTS 1
            MAXEXTENTS 2147483645
           )
/

--------------------------------------------------------------------------------------------------------------------
-- CRIAÇÃO DO ÍNDICE: IFRMAXIMO.PR_NDX4
--------------------------------------------------------------------------------------------------------------------
CREATE  INDEX IFRMAXIMO.PR_NDX4 ON IFRMAXIMO.PR (
SITEID ASC,
WFID ASC)
PCTFREE    10
INITRANS   2
MAXTRANS   255
TABLESPACE TSI_MAXIMO
STORAGE   (
            INITIAL    65536
            MINEXTENTS 1
            MAXEXTENTS 2147483645
           )
/

--------------------------------------------------------------------------------------------------------------------
-- CRIAÇÃO DO ÍNDICE: IFRMAXIMO.PRSTATUS_NDX1
--------------------------------------------------------------------------------------------------------------------
CREATE  INDEX IFRMAXIMO.PRSTATUS_NDX1 ON IFRMAXIMO.PRSTATUS (
SITEID ASC,
PRNUM ASC)
PCTFREE    10
INITRANS   2
MAXTRANS   255
TABLESPACE TSI_MAXIMO
STORAGE   (
            INITIAL    65536
            MINEXTENTS 1
            MAXEXTENTS 2147483645
           )
/

--------------------------------------------------------------------------------------------------------------------
-- CRIAÇÃO DO ÍNDICE: IFRMAXIMO.PRSTATUS_NDX2
--------------------------------------------------------------------------------------------------------------------
CREATE  INDEX IFRMAXIMO.PRSTATUS_NDX2 ON IFRMAXIMO.PRSTATUS (
SITEID ASC,
CHANGEDATE ASC,
PRNUM ASC)
PCTFREE    10
INITRANS   2
MAXTRANS   255
TABLESPACE TSI_MAXIMO
STORAGE   (
            INITIAL    65536
            MINEXTENTS 1
            MAXEXTENTS 2147483645
           )
/

--------------------------------------------------------------------------------------------------------------------
-- CRIAÇÃO DO ÍNDICE: IFRMAXIMO.QUERY_NDX1
--------------------------------------------------------------------------------------------------------------------
CREATE UNIQUE INDEX IFRMAXIMO.QUERY_NDX1 ON IFRMAXIMO.QUERY (
SITEID ASC,
APP ASC,
CLAUSENAME ASC)
PCTFREE    10
INITRANS   2
MAXTRANS   255
TABLESPACE TSI_MAXIMO
STORAGE   (
            INITIAL    65536
            MINEXTENTS 1
            MAXEXTENTS 2147483645
           )
/

--------------------------------------------------------------------------------------------------------------------
-- CRIAÇÃO DO ÍNDICE: IFRMAXIMO.QUERY_NDX2
--------------------------------------------------------------------------------------------------------------------
CREATE  INDEX IFRMAXIMO.QUERY_NDX2 ON IFRMAXIMO.QUERY (
SITEID ASC,
APP ASC)
PCTFREE    10
INITRANS   2
MAXTRANS   255
TABLESPACE TSI_MAXIMO
STORAGE   (
            INITIAL    65536
            MINEXTENTS 1
            MAXEXTENTS 2147483645
           )
/

--------------------------------------------------------------------------------------------------------------------
-- CRIAÇÃO DO ÍNDICE: IFRMAXIMO.QUOTATIONLINE_NDX1
--------------------------------------------------------------------------------------------------------------------
CREATE UNIQUE INDEX IFRMAXIMO.QUOTATIONLINE_NDX1 ON IFRMAXIMO.QUOTATIONLINE (
SITEID ASC,
RFQNUM ASC,
RFQLINENUM ASC,
VENDOR ASC,
QUOTATIONLINEID ASC)
PCTFREE    10
INITRANS   2
MAXTRANS   255
TABLESPACE TSI_MAXIMO
STORAGE   (
            INITIAL    65536
            MINEXTENTS 1
            MAXEXTENTS 2147483645
           )
/

--------------------------------------------------------------------------------------------------------------------
-- CRIAÇÃO DO ÍNDICE: IFRMAXIMO.RANGEDOMSEG_NDX1
--------------------------------------------------------------------------------------------------------------------
CREATE UNIQUE INDEX IFRMAXIMO.RANGEDOMSEG_NDX1 ON IFRMAXIMO.RANGEDOMSEGMENT (
DOMAINID ASC,
RANGESEGMENT ASC)
PCTFREE    10
INITRANS   2
MAXTRANS   255
TABLESPACE TSI_MAXIMO
STORAGE   (
            INITIAL    40960
            MINEXTENTS 1
            MAXEXTENTS 2147483645
           )
/

--------------------------------------------------------------------------------------------------------------------
-- CRIAÇÃO DO ÍNDICE: IFRMAXIMO.REORDERMUTEX_NDX1
--------------------------------------------------------------------------------------------------------------------
CREATE UNIQUE INDEX IFRMAXIMO.REORDERMUTEX_NDX1 ON IFRMAXIMO.REORDERMUTEX (
SITEID ASC,
LOCATION ASC,
MRNUM ASC,
TYPE ASC)
PCTFREE    10
INITRANS   2
MAXTRANS   255
TABLESPACE TSI_MAXIMO
STORAGE   (
            INITIAL    65536
            MINEXTENTS 1
            MAXEXTENTS 2147483645
           )
/

--------------------------------------------------------------------------------------------------------------------
-- CRIAÇÃO DO ÍNDICE: IFRMAXIMO.REORDERPAD_NDX1
--------------------------------------------------------------------------------------------------------------------
CREATE  INDEX IFRMAXIMO.REORDERPAD_NDX1 ON IFRMAXIMO.REORDERPAD (
SITEID ASC,
USRNAME ASC)
PCTFREE    10
INITRANS   2
MAXTRANS   255
TABLESPACE TSI_MAXIMO
STORAGE   (
            INITIAL    65536
            MINEXTENTS 1
            MAXEXTENTS 2147483645
           )
/

--------------------------------------------------------------------------------------------------------------------
-- CRIAÇÃO DO ÍNDICE: IFRMAXIMO.RESTRICTIONS_NDX
--------------------------------------------------------------------------------------------------------------------
CREATE UNIQUE INDEX IFRMAXIMO.RESTRICTIONS_NDX ON IFRMAXIMO.USERRESTRICTIONS (
USERNAME ASC,
APP ASC,
MODULE ASC)
PCTFREE    10
INITRANS   2
MAXTRANS   255
TABLESPACE TSI_MAXIMO
STORAGE   (
            INITIAL    65536
            MINEXTENTS 1
            MAXEXTENTS 2147483645
           )
/

--------------------------------------------------------------------------------------------------------------------
-- CRIAÇÃO DO ÍNDICE: IFRMAXIMO.RFQLINE_NDX1
--------------------------------------------------------------------------------------------------------------------
CREATE UNIQUE INDEX IFRMAXIMO.RFQLINE_NDX1 ON IFRMAXIMO.RFQLINE (
SITEID ASC,
RFQLINEID ASC)
PCTFREE    10
INITRANS   2
MAXTRANS   255
TABLESPACE TSI_MAXIMO
STORAGE   (
            INITIAL    65536
            MINEXTENTS 1
            MAXEXTENTS 2147483645
           )
/

--------------------------------------------------------------------------------------------------------------------
-- CRIAÇÃO DO ÍNDICE: IFRMAXIMO.RFQLINE_NDX2
--------------------------------------------------------------------------------------------------------------------
CREATE  INDEX IFRMAXIMO.RFQLINE_NDX2 ON IFRMAXIMO.RFQLINE (
SITEID ASC,
RFQNUM ASC,
RFQLINENUM ASC)
PCTFREE    10
INITRANS   2
MAXTRANS   255
TABLESPACE TSI_MAXIMO
STORAGE   (
            INITIAL    65536
            MINEXTENTS 1
            MAXEXTENTS 2147483645
           )
/

--------------------------------------------------------------------------------------------------------------------
-- CRIAÇÃO DO ÍNDICE: IFRMAXIMO.RFQLINE_NDX3
--------------------------------------------------------------------------------------------------------------------
CREATE  INDEX IFRMAXIMO.RFQLINE_NDX3 ON IFRMAXIMO.RFQLINE (
SITEID ASC,
POLINEID ASC)
PCTFREE    10
INITRANS   2
MAXTRANS   255
TABLESPACE TSI_MAXIMO
STORAGE   (
            INITIAL    65536
            MINEXTENTS 1
            MAXEXTENTS 2147483645
           )
/

--------------------------------------------------------------------------------------------------------------------
-- CRIAÇÃO DO ÍNDICE: IFRMAXIMO.RFQLINE_NDX4
--------------------------------------------------------------------------------------------------------------------
CREATE  INDEX IFRMAXIMO.RFQLINE_NDX4 ON IFRMAXIMO.RFQLINE (
SITEID ASC,
PONUM ASC,
POLINENUM ASC)
PCTFREE    10
INITRANS   2
MAXTRANS   255
TABLESPACE TSI_MAXIMO
STORAGE   (
            INITIAL    65536
            MINEXTENTS 1
            MAXEXTENTS 2147483645
           )
/

--------------------------------------------------------------------------------------------------------------------
-- CRIAÇÃO DO ÍNDICE: IFRMAXIMO.RFQ_NDX1
--------------------------------------------------------------------------------------------------------------------
CREATE UNIQUE INDEX IFRMAXIMO.RFQ_NDX1 ON IFRMAXIMO.RFQ (
SITEID ASC,
RFQNUM ASC)
PCTFREE    10
INITRANS   2
MAXTRANS   255
TABLESPACE TSI_MAXIMO
STORAGE   (
            INITIAL    65536
            MINEXTENTS 1
            MAXEXTENTS 2147483645
           )
/

--------------------------------------------------------------------------------------------------------------------
-- CRIAÇÃO DO ÍNDICE: IFRMAXIMO.RFQSTATUS_NDX1
--------------------------------------------------------------------------------------------------------------------
CREATE UNIQUE INDEX IFRMAXIMO.RFQSTATUS_NDX1 ON IFRMAXIMO.RFQSTATUS (
SITEID ASC,
RFQNUM ASC,
RFQSTATUSSEQ ASC)
PCTFREE    10
INITRANS   2
MAXTRANS   255
TABLESPACE TSI_MAXIMO
STORAGE   (
            INITIAL    65536
            MINEXTENTS 1
            MAXEXTENTS 2147483645
           )
/

--------------------------------------------------------------------------------------------------------------------
-- CRIAÇÃO DO ÍNDICE: IFRMAXIMO.RFQVENDOR_NDX1
--------------------------------------------------------------------------------------------------------------------
CREATE UNIQUE INDEX IFRMAXIMO.RFQVENDOR_NDX1 ON IFRMAXIMO.RFQVENDOR (
SITEID ASC,
RFQNUM ASC,
VENDOR ASC)
PCTFREE    10
INITRANS   2
MAXTRANS   255
TABLESPACE TSI_MAXIMO
STORAGE   (
            INITIAL    65536
            MINEXTENTS 1
            MAXEXTENTS 2147483645
           )
/

--------------------------------------------------------------------------------------------------------------------
-- CRIAÇÃO DO ÍNDICE: IFRMAXIMO.ROUTES_NDX1
--------------------------------------------------------------------------------------------------------------------
CREATE UNIQUE INDEX IFRMAXIMO.ROUTES_NDX1 ON IFRMAXIMO.ROUTES (
SITEID ASC,
ROUTE ASC)
PCTFREE    10
INITRANS   2
MAXTRANS   255
TABLESPACE TSI_MAXIMO
STORAGE   (
            INITIAL    65536
            MINEXTENTS 1
            MAXEXTENTS 2147483645
           )
/

--------------------------------------------------------------------------------------------------------------------
-- CRIAÇÃO DO ÍNDICE: IFRMAXIMO.ROUTE_STOP_NDX1
--------------------------------------------------------------------------------------------------------------------
CREATE UNIQUE INDEX IFRMAXIMO.ROUTE_STOP_NDX1 ON IFRMAXIMO.ROUTE_STOP (
SITEID ASC,
ROUTE ASC,
ROUTESTOPID ASC)
PCTFREE    10
INITRANS   2
MAXTRANS   255
TABLESPACE TSI_MAXIMO
STORAGE   (
            INITIAL    65536
            MINEXTENTS 1
            MAXEXTENTS 2147483645
           )
/

--------------------------------------------------------------------------------------------------------------------
-- CRIAÇÃO DO ÍNDICE: IFRMAXIMO.ROUTE_STOP_NDX2
--------------------------------------------------------------------------------------------------------------------
CREATE  INDEX IFRMAXIMO.ROUTE_STOP_NDX2 ON IFRMAXIMO.ROUTE_STOP (
SITEID ASC,
ROUTE ASC,
STOPSEQUENCE ASC,
EQNUM ASC,
LOCATION ASC)
PCTFREE    10
INITRANS   2
MAXTRANS   255
TABLESPACE TSI_MAXIMO
STORAGE   (
            INITIAL    65536
            MINEXTENTS 1
            MAXEXTENTS 2147483645
           )
/

--------------------------------------------------------------------------------------------------------------------
-- CRIAÇÃO DO ÍNDICE: IFRMAXIMO.ROUTE_STOP_NDX3
--------------------------------------------------------------------------------------------------------------------
CREATE  INDEX IFRMAXIMO.ROUTE_STOP_NDX3 ON IFRMAXIMO.ROUTE_STOP (
SITEID ASC,
EQNUM ASC)
PCTFREE    10
INITRANS   2
MAXTRANS   255
TABLESPACE TSI_MAXIMO
STORAGE   (
            INITIAL    65536
            MINEXTENTS 1
            MAXEXTENTS 2147483645
           )
/

--------------------------------------------------------------------------------------------------------------------
-- CRIAÇÃO DO ÍNDICE: IFRMAXIMO.ROUTE_STOP_NDX4
--------------------------------------------------------------------------------------------------------------------
CREATE  INDEX IFRMAXIMO.ROUTE_STOP_NDX4 ON IFRMAXIMO.ROUTE_STOP (
SITEID ASC,
LOCATION ASC)
PCTFREE    10
INITRANS   2
MAXTRANS   255
TABLESPACE TSI_MAXIMO
STORAGE   (
            INITIAL    65536
            MINEXTENTS 1
            MAXEXTENTS 2147483645
           )
/

--------------------------------------------------------------------------------------------------------------------
-- CRIAÇÃO DO ÍNDICE: IFRMAXIMO.SAFETYLEXICON_NDX1
--------------------------------------------------------------------------------------------------------------------
CREATE UNIQUE INDEX IFRMAXIMO.SAFETYLEXICON_NDX1 ON IFRMAXIMO.SAFETYLEXICON (
SITEID ASC,
SAFETYLEXICONID ASC)
PCTFREE    10
INITRANS   2
MAXTRANS   255
TABLESPACE TSI_MAXIMO
STORAGE   (
            INITIAL    65536
            MINEXTENTS 1
            MAXEXTENTS 2147483645
           )
/

--------------------------------------------------------------------------------------------------------------------
-- CRIAÇÃO DO ÍNDICE: IFRMAXIMO.SAFETYLEXICON_NDX2
--------------------------------------------------------------------------------------------------------------------
CREATE  INDEX IFRMAXIMO.SAFETYLEXICON_NDX2 ON IFRMAXIMO.SAFETYLEXICON (
SITEID ASC,
LOCATION ASC)
PCTFREE    10
INITRANS   2
MAXTRANS   255
TABLESPACE TSI_MAXIMO
STORAGE   (
            INITIAL    65536
            MINEXTENTS 1
            MAXEXTENTS 2147483645
           )
/

--------------------------------------------------------------------------------------------------------------------
-- CRIAÇÃO DO ÍNDICE: IFRMAXIMO.SAFETYLEXICON_NDX3
--------------------------------------------------------------------------------------------------------------------
CREATE  INDEX IFRMAXIMO.SAFETYLEXICON_NDX3 ON IFRMAXIMO.SAFETYLEXICON (
SITEID ASC,
EQNUM ASC)
PCTFREE    10
INITRANS   2
MAXTRANS   255
TABLESPACE TSI_MAXIMO
STORAGE   (
            INITIAL    65536
            MINEXTENTS 1
            MAXEXTENTS 2147483645
           )
/

--------------------------------------------------------------------------------------------------------------------
-- CRIAÇÃO DO ÍNDICE: IFRMAXIMO.SAFETYLEXICON_NDX4
--------------------------------------------------------------------------------------------------------------------
CREATE  INDEX IFRMAXIMO.SAFETYLEXICON_NDX4 ON IFRMAXIMO.SAFETYLEXICON (
SITEID ASC,
HAZARDID ASC)
PCTFREE    10
INITRANS   2
MAXTRANS   255
TABLESPACE TSI_MAXIMO
STORAGE   (
            INITIAL    65536
            MINEXTENTS 1
            MAXEXTENTS 2147483645
           )
/

--------------------------------------------------------------------------------------------------------------------
-- CRIAÇÃO DO ÍNDICE: IFRMAXIMO.SAFETYLEXICON_NDX5
--------------------------------------------------------------------------------------------------------------------
CREATE  INDEX IFRMAXIMO.SAFETYLEXICON_NDX5 ON IFRMAXIMO.SAFETYLEXICON (
SITEID ASC,
TAGOUTID ASC)
PCTFREE    10
INITRANS   2
MAXTRANS   255
TABLESPACE TSI_MAXIMO
STORAGE   (
            INITIAL    65536
            MINEXTENTS 1
            MAXEXTENTS 2147483645
           )
/

--------------------------------------------------------------------------------------------------------------------
-- CRIAÇÃO DO ÍNDICE: IFRMAXIMO.SAFETYPLAN_NDX1
--------------------------------------------------------------------------------------------------------------------
CREATE UNIQUE INDEX IFRMAXIMO.SAFETYPLAN_NDX1 ON IFRMAXIMO.SAFETYPLAN (
SITEID ASC,
SAFETYPLANID ASC)
PCTFREE    10
INITRANS   2
MAXTRANS   255
TABLESPACE TSI_MAXIMO
STORAGE   (
            INITIAL    65536
            MINEXTENTS 1
            MAXEXTENTS 2147483645
           )
/

--------------------------------------------------------------------------------------------------------------------
-- CRIAÇÃO DO ÍNDICE: IFRMAXIMO.SCHARGES_NDX1
--------------------------------------------------------------------------------------------------------------------
CREATE UNIQUE INDEX IFRMAXIMO.SCHARGES_NDX1 ON IFRMAXIMO.SCHARGES (
ORGID ASC,
SCHARGECODE ASC)
PCTFREE    10
INITRANS   2
MAXTRANS   255
TABLESPACE TSI_MAXIMO
STORAGE   (
            INITIAL    65536
            MINEXTENTS 1
            MAXEXTENTS 2147483645
           )
/

--------------------------------------------------------------------------------------------------------------------
-- CRIAÇÃO DO ÍNDICE: IFRMAXIMO.SERVCONT_NDX1
--------------------------------------------------------------------------------------------------------------------
CREATE UNIQUE INDEX IFRMAXIMO.SERVCONT_NDX1 ON IFRMAXIMO.SERVICECONTRACT (
SITEID ASC,
CONTRACT ASC)
PCTFREE    10
INITRANS   2
MAXTRANS   255
TABLESPACE TSI_MAXIMO
STORAGE   (
            INITIAL    65536
            MINEXTENTS 1
            MAXEXTENTS 2147483645
           )
/

--------------------------------------------------------------------------------------------------------------------
-- CRIAÇÃO DO ÍNDICE: IFRMAXIMO.SERVCONT_NDX2
--------------------------------------------------------------------------------------------------------------------
CREATE  INDEX IFRMAXIMO.SERVCONT_NDX2 ON IFRMAXIMO.SERVICECONTRACT (
SITEID ASC,
VENDOR ASC)
PCTFREE    10
INITRANS   2
MAXTRANS   255
TABLESPACE TSI_MAXIMO
STORAGE   (
            INITIAL    65536
            MINEXTENTS 1
            MAXEXTENTS 2147483645
           )
/

--------------------------------------------------------------------------------------------------------------------
-- CRIAÇÃO DO ÍNDICE: IFRMAXIMO.SERVCONT_NDX3
--------------------------------------------------------------------------------------------------------------------
CREATE  INDEX IFRMAXIMO.SERVCONT_NDX3 ON IFRMAXIMO.SERVICECONTRACT (
SITEID ASC,
VENDORSCONTRACTNUM ASC)
PCTFREE    10
INITRANS   2
MAXTRANS   255
TABLESPACE TSI_MAXIMO
STORAGE   (
            INITIAL    65536
            MINEXTENTS 1
            MAXEXTENTS 2147483645
           )
/

--------------------------------------------------------------------------------------------------------------------
-- CRIAÇÃO DO ÍNDICE: IFRMAXIMO.SERVCONT_NDX4
--------------------------------------------------------------------------------------------------------------------
CREATE  INDEX IFRMAXIMO.SERVCONT_NDX4 ON IFRMAXIMO.SERVICECONTRACT (
SITEID ASC,
EQNUM ASC)
PCTFREE    10
INITRANS   2
MAXTRANS   255
TABLESPACE TSI_MAXIMO
STORAGE   (
            INITIAL    65536
            MINEXTENTS 1
            MAXEXTENTS 2147483645
           )
/

--------------------------------------------------------------------------------------------------------------------
-- CRIAÇÃO DO ÍNDICE: IFRMAXIMO.SERVRECTRANS_NDX1
--------------------------------------------------------------------------------------------------------------------
CREATE UNIQUE INDEX IFRMAXIMO.SERVRECTRANS_NDX1 ON IFRMAXIMO.SERVRECTRANS (
SITEID ASC,
SERVRECTRANSID ASC)
PCTFREE    10
INITRANS   2
MAXTRANS   255
TABLESPACE TSI_MAXIMO
STORAGE   (
            INITIAL    65536
            MINEXTENTS 1
            MAXEXTENTS 2147483645
           )
/

--------------------------------------------------------------------------------------------------------------------
-- CRIAÇÃO DO ÍNDICE: IFRMAXIMO.SERVRECTRANS_NDX2
--------------------------------------------------------------------------------------------------------------------
CREATE  INDEX IFRMAXIMO.SERVRECTRANS_NDX2 ON IFRMAXIMO.SERVRECTRANS (
SITEID ASC,
PONUM ASC,
POLINENUM ASC,
TRANSDATE ASC)
PCTFREE    10
INITRANS   2
MAXTRANS   255
TABLESPACE TSI_MAXIMO
STORAGE   (
            INITIAL    65536
            MINEXTENTS 1
            MAXEXTENTS 2147483645
           )
/

--------------------------------------------------------------------------------------------------------------------
-- CRIAÇÃO DO ÍNDICE: IFRMAXIMO.SERVRECTRANS_NDX3
--------------------------------------------------------------------------------------------------------------------
CREATE  INDEX IFRMAXIMO.SERVRECTRANS_NDX3 ON IFRMAXIMO.SERVRECTRANS (
SITEID ASC,
INTERID ASC)
PCTFREE    10
INITRANS   2
MAXTRANS   255
TABLESPACE TSI_MAXIMO
STORAGE   (
            INITIAL    65536
            MINEXTENTS 1
            MAXEXTENTS 2147483645
           )
/

--------------------------------------------------------------------------------------------------------------------
-- CRIAÇÃO DO ÍNDICE: IFRMAXIMO.SHIFT_NDX1
--------------------------------------------------------------------------------------------------------------------
CREATE UNIQUE INDEX IFRMAXIMO.SHIFT_NDX1 ON IFRMAXIMO.SHIFT (
ORGID ASC,
SHIFTNUM ASC)
PCTFREE    10
INITRANS   2
MAXTRANS   255
TABLESPACE TSI_MAXIMO
STORAGE   (
            INITIAL    65536
            MINEXTENTS 1
            MAXEXTENTS 2147483645
           )
/

--------------------------------------------------------------------------------------------------------------------
-- CRIAÇÃO DO ÍNDICE: IFRMAXIMO.SHIFTPATDAY_NDX1
--------------------------------------------------------------------------------------------------------------------
CREATE UNIQUE INDEX IFRMAXIMO.SHIFTPATDAY_NDX1 ON IFRMAXIMO.SHIFTPATTERNDAY (
ORGID ASC,
SHIFTNUM ASC,
PATTERNDAYSEQ ASC)
PCTFREE    10
INITRANS   2
MAXTRANS   255
TABLESPACE TSI_MAXIMO
STORAGE   (
            INITIAL    65536
            MINEXTENTS 1
            MAXEXTENTS 2147483645
           )
/

--------------------------------------------------------------------------------------------------------------------
-- CRIAÇÃO DO ÍNDICE: IFRMAXIMO.SHIPMENTLINE_NDX1
--------------------------------------------------------------------------------------------------------------------
CREATE UNIQUE INDEX IFRMAXIMO.SHIPMENTLINE_NDX1 ON IFRMAXIMO.SHIPMENTLINE (
SITEID ASC,
SHIPMENTID ASC,
SHIPMENTLINEID ASC)
PCTFREE    10
INITRANS   2
MAXTRANS   255
TABLESPACE TSI_MAXIMO
STORAGE   (
            INITIAL    65536
            MINEXTENTS 1
            MAXEXTENTS 2147483645
           )
/

--------------------------------------------------------------------------------------------------------------------
-- CRIAÇÃO DO ÍNDICE: IFRMAXIMO.SHIPMENT_NDX1
--------------------------------------------------------------------------------------------------------------------
CREATE UNIQUE INDEX IFRMAXIMO.SHIPMENT_NDX1 ON IFRMAXIMO.SHIPMENT (
SITEID ASC,
SHIPMENTID ASC)
PCTFREE    10
INITRANS   2
MAXTRANS   255
TABLESPACE TSI_MAXIMO
STORAGE   (
            INITIAL    65536
            MINEXTENTS 1
            MAXEXTENTS 2147483645
           )
/

--------------------------------------------------------------------------------------------------------------------
-- CRIAÇÃO DO ÍNDICE: IFRMAXIMO.SIGOPTION_NDX
--------------------------------------------------------------------------------------------------------------------
CREATE UNIQUE INDEX IFRMAXIMO.SIGOPTION_NDX ON IFRMAXIMO.SIGOPTION (
APP ASC,
OPTIONNAME ASC)
PCTFREE    10
INITRANS   2
MAXTRANS   255
TABLESPACE TSI_MAXIMO
STORAGE   (
            INITIAL    65536
            MINEXTENTS 1
            MAXEXTENTS 2147483645
           )
/

--------------------------------------------------------------------------------------------------------------------
-- CRIAÇÃO DO ÍNDICE: IFRMAXIMO.SITEECOM_NDX1
--------------------------------------------------------------------------------------------------------------------
CREATE UNIQUE INDEX IFRMAXIMO.SITEECOM_NDX1 ON IFRMAXIMO.SITEECOM (
SITEID ASC,
ORGID ASC,
VENDOR ASC)
PCTFREE    10
INITRANS   2
MAXTRANS   255
TABLESPACE TSI_MAXIMO
STORAGE   (
            INITIAL    65536
            MINEXTENTS 1
            MAXEXTENTS 2147483645
           )
/

--------------------------------------------------------------------------------------------------------------------
-- CRIAÇÃO DO ÍNDICE: IFRMAXIMO.SITE_NDX1
--------------------------------------------------------------------------------------------------------------------
CREATE UNIQUE INDEX IFRMAXIMO.SITE_NDX1 ON IFRMAXIMO.SITE (
SITEID ASC)
PCTFREE    10
INITRANS   2
MAXTRANS   255
TABLESPACE TSI_MAXIMO
STORAGE   (
            INITIAL    65536
            MINEXTENTS 1
            MAXEXTENTS 2147483645
           )
/

--------------------------------------------------------------------------------------------------------------------
-- CRIAÇÃO DO ÍNDICE: IFRMAXIMO.SITERESTR_NDX1
--------------------------------------------------------------------------------------------------------------------
CREATE UNIQUE INDEX IFRMAXIMO.SITERESTR_NDX1 ON IFRMAXIMO.SITERESTRICTION (
SITEID ASC,
TBNAME ASC)
PCTFREE    10
INITRANS   2
MAXTRANS   255
TABLESPACE TSI_MAXIMO
STORAGE   (
            INITIAL    65536
            MINEXTENTS 1
            MAXEXTENTS 2147483645
           )
/

--------------------------------------------------------------------------------------------------------------------
-- CRIAÇÃO DO ÍNDICE: IFRMAXIMO.SITEUSER_NDX1
--------------------------------------------------------------------------------------------------------------------
CREATE UNIQUE INDEX IFRMAXIMO.SITEUSER_NDX1 ON IFRMAXIMO.SITEUSER (
SITEID ASC,
USERNAME ASC)
PCTFREE    10
INITRANS   2
MAXTRANS   255
TABLESPACE TSI_MAXIMO
STORAGE   (
            INITIAL    65536
            MINEXTENTS 1
            MAXEXTENTS 2147483645
           )
/

--------------------------------------------------------------------------------------------------------------------
-- CRIAÇÃO DO ÍNDICE: IFRMAXIMO.SITEUSER_NDX2
--------------------------------------------------------------------------------------------------------------------
CREATE  INDEX IFRMAXIMO.SITEUSER_NDX2 ON IFRMAXIMO.SITEUSER (
USERNAME ASC)
PCTFREE    10
INITRANS   2
MAXTRANS   255
TABLESPACE TSI_MAXIMO
STORAGE   (
            INITIAL    65536
            MINEXTENTS 1
            MAXEXTENTS 2147483645
           )
/

--------------------------------------------------------------------------------------------------------------------
-- CRIAÇÃO DO ÍNDICE: IFRMAXIMO.SPAREPART_NDX1
--------------------------------------------------------------------------------------------------------------------
CREATE  INDEX IFRMAXIMO.SPAREPART_NDX1 ON IFRMAXIMO.SPAREPART (
SITEID ASC,
EQNUM ASC)
PCTFREE    10
INITRANS   2
MAXTRANS   255
TABLESPACE TSI_MAXIMO
STORAGE   (
            INITIAL    65536
            MINEXTENTS 1
            MAXEXTENTS 2147483645
           )
/

--------------------------------------------------------------------------------------------------------------------
-- CRIAÇÃO DO ÍNDICE: IFRMAXIMO.SPAREPART_NDX2
--------------------------------------------------------------------------------------------------------------------
CREATE  INDEX IFRMAXIMO.SPAREPART_NDX2 ON IFRMAXIMO.SPAREPART (
SITEID ASC,
ITEMNUM ASC)
PCTFREE    10
INITRANS   2
MAXTRANS   255
TABLESPACE TSI_MAXIMO
STORAGE   (
            INITIAL    65536
            MINEXTENTS 1
            MAXEXTENTS 2147483645
           )
/

--------------------------------------------------------------------------------------------------------------------
-- CRIAÇÃO DO ÍNDICE: IFRMAXIMO.SPLEXICONLINK_NDX1
--------------------------------------------------------------------------------------------------------------------
CREATE UNIQUE INDEX IFRMAXIMO.SPLEXICONLINK_NDX1 ON IFRMAXIMO.SPLEXICONLINK (
SITEID ASC,
SPWORKASSETID ASC,
SAFETYLEXICONID ASC)
PCTFREE    10
INITRANS   2
MAXTRANS   255
TABLESPACE TSI_MAXIMO
STORAGE   (
            INITIAL    65536
            MINEXTENTS 1
            MAXEXTENTS 2147483645
           )
/

--------------------------------------------------------------------------------------------------------------------
-- CRIAÇÃO DO ÍNDICE: IFRMAXIMO.SPLEXICONLINK_NDX2
--------------------------------------------------------------------------------------------------------------------
CREATE  INDEX IFRMAXIMO.SPLEXICONLINK_NDX2 ON IFRMAXIMO.SPLEXICONLINK (
SITEID ASC,
SPWORKASSETID ASC,
APPLYSEQ ASC)
PCTFREE    10
INITRANS   2
MAXTRANS   255
TABLESPACE TSI_MAXIMO
STORAGE   (
            INITIAL    65536
            MINEXTENTS 1
            MAXEXTENTS 2147483645
           )
/

--------------------------------------------------------------------------------------------------------------------
-- CRIAÇÃO DO ÍNDICE: IFRMAXIMO.SPWORKASSET_NDX1
--------------------------------------------------------------------------------------------------------------------
CREATE UNIQUE INDEX IFRMAXIMO.SPWORKASSET_NDX1 ON IFRMAXIMO.SPWORKASSET (
SITEID ASC,
SPWORKASSETID ASC)
PCTFREE    10
INITRANS   2
MAXTRANS   255
TABLESPACE TSI_MAXIMO
STORAGE   (
            INITIAL    65536
            MINEXTENTS 1
            MAXEXTENTS 2147483645
           )
/

--------------------------------------------------------------------------------------------------------------------
-- CRIAÇÃO DO ÍNDICE: IFRMAXIMO.SPWORKASSET_NDX2
--------------------------------------------------------------------------------------------------------------------
CREATE  INDEX IFRMAXIMO.SPWORKASSET_NDX2 ON IFRMAXIMO.SPWORKASSET (
SITEID ASC,
WORKLOCATION ASC)
PCTFREE    10
INITRANS   2
MAXTRANS   255
TABLESPACE TSI_MAXIMO
STORAGE   (
            INITIAL    65536
            MINEXTENTS 1
            MAXEXTENTS 2147483645
           )
/

--------------------------------------------------------------------------------------------------------------------
-- CRIAÇÃO DO ÍNDICE: IFRMAXIMO.SPWORKASSET_NDX3
--------------------------------------------------------------------------------------------------------------------
CREATE  INDEX IFRMAXIMO.SPWORKASSET_NDX3 ON IFRMAXIMO.SPWORKASSET (
SITEID ASC,
WORKEQUIPMENT ASC)
PCTFREE    10
INITRANS   2
MAXTRANS   255
TABLESPACE TSI_MAXIMO
STORAGE   (
            INITIAL    65536
            MINEXTENTS 1
            MAXEXTENTS 2147483645
           )
/

--------------------------------------------------------------------------------------------------------------------
-- CRIAÇÃO DO ÍNDICE: IFRMAXIMO.SPWORKASSET_NDX4
--------------------------------------------------------------------------------------------------------------------
CREATE  INDEX IFRMAXIMO.SPWORKASSET_NDX4 ON IFRMAXIMO.SPWORKASSET (
SITEID ASC,
SAFETYPLANID ASC)
PCTFREE    10
INITRANS   2
MAXTRANS   255
TABLESPACE TSI_MAXIMO
STORAGE   (
            INITIAL    65536
            MINEXTENTS 1
            MAXEXTENTS 2147483645
           )
/

--------------------------------------------------------------------------------------------------------------------
-- CRIAÇÃO DO ÍNDICE: IFRMAXIMO.SRELATEDASSET_NDX1
--------------------------------------------------------------------------------------------------------------------
CREATE UNIQUE INDEX IFRMAXIMO.SRELATEDASSET_NDX1 ON IFRMAXIMO.SPRELATEDASSET (
SITEID ASC,
SPRELATEDASSETID ASC)
PCTFREE    10
INITRANS   2
MAXTRANS   255
TABLESPACE TSI_MAXIMO
STORAGE   (
            INITIAL    65536
            MINEXTENTS 1
            MAXEXTENTS 2147483645
           )
/

--------------------------------------------------------------------------------------------------------------------
-- CRIAÇÃO DO ÍNDICE: IFRMAXIMO.SRELATEDASSET_NDX2
--------------------------------------------------------------------------------------------------------------------
CREATE  INDEX IFRMAXIMO.SRELATEDASSET_NDX2 ON IFRMAXIMO.SPRELATEDASSET (
SITEID ASC,
LOCATION ASC)
PCTFREE    10
INITRANS   2
MAXTRANS   255
TABLESPACE TSI_MAXIMO
STORAGE   (
            INITIAL    65536
            MINEXTENTS 1
            MAXEXTENTS 2147483645
           )
/

--------------------------------------------------------------------------------------------------------------------
-- CRIAÇÃO DO ÍNDICE: IFRMAXIMO.SRELATEDASSET_NDX3
--------------------------------------------------------------------------------------------------------------------
CREATE  INDEX IFRMAXIMO.SRELATEDASSET_NDX3 ON IFRMAXIMO.SPRELATEDASSET (
SITEID ASC,
EQNUM ASC)
PCTFREE    10
INITRANS   2
MAXTRANS   255
TABLESPACE TSI_MAXIMO
STORAGE   (
            INITIAL    65536
            MINEXTENTS 1
            MAXEXTENTS 2147483645
           )
/

--------------------------------------------------------------------------------------------------------------------
-- CRIAÇÃO DO ÍNDICE: IFRMAXIMO.STARTCENTER_NDX1
--------------------------------------------------------------------------------------------------------------------
CREATE UNIQUE INDEX IFRMAXIMO.STARTCENTER_NDX1 ON IFRMAXIMO.STARTCENTER (
STARTCENTERID ASC)
PCTFREE    10
INITRANS   2
MAXTRANS   255
TABLESPACE TSI_MAXIMO
STORAGE   (
            INITIAL    65536
            MINEXTENTS 1
            MAXEXTENTS 2147483645
           )
/

--------------------------------------------------------------------------------------------------------------------
-- CRIAÇÃO DO ÍNDICE: IFRMAXIMO.SYS_C0013249
--------------------------------------------------------------------------------------------------------------------
CREATE UNIQUE INDEX IFRMAXIMO.SYS_C0013249 ON IFRMAXIMO.DEPENDENCIA (
AEROPORTO ASC)
PCTFREE    10
INITRANS   2
MAXTRANS   255
TABLESPACE TSI_MAXIMO
STORAGE   (
            INITIAL    40960
            MINEXTENTS 1
            MAXEXTENTS 2147483645
           )
/

--------------------------------------------------------------------------------------------------------------------
-- CRIAÇÃO DO ÍNDICE: IFRMAXIMO.SYS_C0014500
--------------------------------------------------------------------------------------------------------------------
CREATE UNIQUE INDEX IFRMAXIMO.SYS_C0014500 ON IFRMAXIMO.USUARIO (
USERNUM ASC)
PCTFREE    10
INITRANS   2
MAXTRANS   255
TABLESPACE TSI_MAXIMO
STORAGE   (
            INITIAL    40960
            MINEXTENTS 1
            MAXEXTENTS 2147483645
           )
/

--------------------------------------------------------------------------------------------------------------------
-- CRIAÇÃO DO ÍNDICE: IFRMAXIMO.TAB_INDISPONIBILIDADE_NDX1
--------------------------------------------------------------------------------------------------------------------
CREATE  INDEX IFRMAXIMO.TAB_INDISPONIBILIDADE_NDX1 ON IFRMAXIMO.TAB_INDISPONIBILIDADE (
WO_WONUM ASC)
PCTFREE    10
INITRANS   2
MAXTRANS   255
TABLESPACE TSI_MAXIMO
STORAGE   (
            INITIAL    65536
            MINEXTENTS 1
            MAXEXTENTS 2147483645
           )
/

--------------------------------------------------------------------------------------------------------------------
-- CRIAÇÃO DO ÍNDICE: IFRMAXIMO.TAB_WORATEIO_NDX1
--------------------------------------------------------------------------------------------------------------------
CREATE UNIQUE INDEX IFRMAXIMO.TAB_WORATEIO_NDX1 ON IFRMAXIMO.TAB_WORATEIO (
RATNUM ASC)
PCTFREE    10
INITRANS   2
MAXTRANS   255
TABLESPACE TSI_MAXIMO
STORAGE   (
            INITIAL    65536
            MINEXTENTS 1
            MAXEXTENTS 2147483645
           )
/

--------------------------------------------------------------------------------------------------------------------
-- CRIAÇÃO DO ÍNDICE: IFRMAXIMO.TAGLOCK_NDX1
--------------------------------------------------------------------------------------------------------------------
CREATE UNIQUE INDEX IFRMAXIMO.TAGLOCK_NDX1 ON IFRMAXIMO.TAGLOCK (
SITEID ASC,
TAGLOCKID ASC)
PCTFREE    10
INITRANS   2
MAXTRANS   255
TABLESPACE TSI_MAXIMO
STORAGE   (
            INITIAL    65536
            MINEXTENTS 1
            MAXEXTENTS 2147483645
           )
/

--------------------------------------------------------------------------------------------------------------------
-- CRIAÇÃO DO ÍNDICE: IFRMAXIMO.TAGLOCK_NDX2
--------------------------------------------------------------------------------------------------------------------
CREATE  INDEX IFRMAXIMO.TAGLOCK_NDX2 ON IFRMAXIMO.TAGLOCK (
SITEID ASC,
TAGOUTID ASC,
LOCKOUTID ASC)
PCTFREE    10
INITRANS   2
MAXTRANS   255
TABLESPACE TSI_MAXIMO
STORAGE   (
            INITIAL    65536
            MINEXTENTS 1
            MAXEXTENTS 2147483645
           )
/

--------------------------------------------------------------------------------------------------------------------
-- CRIAÇÃO DO ÍNDICE: IFRMAXIMO.TAGLOCK_NDX3
--------------------------------------------------------------------------------------------------------------------
CREATE  INDEX IFRMAXIMO.TAGLOCK_NDX3 ON IFRMAXIMO.TAGLOCK (
SITEID ASC,
TAGOUTID ASC,
APPLYSEQ ASC)
PCTFREE    10
INITRANS   2
MAXTRANS   255
TABLESPACE TSI_MAXIMO
STORAGE   (
            INITIAL    65536
            MINEXTENTS 1
            MAXEXTENTS 2147483645
           )
/

--------------------------------------------------------------------------------------------------------------------
-- CRIAÇÃO DO ÍNDICE: IFRMAXIMO.TAGOUT_NDX1
--------------------------------------------------------------------------------------------------------------------
CREATE UNIQUE INDEX IFRMAXIMO.TAGOUT_NDX1 ON IFRMAXIMO.TAGOUT (
SITEID ASC,
TAGOUTID ASC)
PCTFREE    10
INITRANS   2
MAXTRANS   255
TABLESPACE TSI_MAXIMO
STORAGE   (
            INITIAL    65536
            MINEXTENTS 1
            MAXEXTENTS 2147483645
           )
/

--------------------------------------------------------------------------------------------------------------------
-- CRIAÇÃO DO ÍNDICE: IFRMAXIMO.TAX_NDX1
--------------------------------------------------------------------------------------------------------------------
CREATE UNIQUE INDEX IFRMAXIMO.TAX_NDX1 ON IFRMAXIMO.TAX (
ORGID ASC,
TYPECODE ASC,
TAXCODE ASC,
EFFECTIVE ASC)
PCTFREE    10
INITRANS   2
MAXTRANS   255
TABLESPACE TSI_MAXIMO
STORAGE   (
            INITIAL    65536
            MINEXTENTS 1
            MAXEXTENTS 2147483645
           )
/

--------------------------------------------------------------------------------------------------------------------
-- CRIAÇÃO DO ÍNDICE: IFRMAXIMO.TAX_NDX2
--------------------------------------------------------------------------------------------------------------------
CREATE  INDEX IFRMAXIMO.TAX_NDX2 ON IFRMAXIMO.TAX (
ORGID ASC,
TAXCODE ASC)
PCTFREE    10
INITRANS   2
MAXTRANS   255
TABLESPACE TSI_MAXIMO
STORAGE   (
            INITIAL    65536
            MINEXTENTS 1
            MAXEXTENTS 2147483645
           )
/

--------------------------------------------------------------------------------------------------------------------
-- CRIAÇÃO DO ÍNDICE: IFRMAXIMO.TAXTYPE_NDX
--------------------------------------------------------------------------------------------------------------------
CREATE UNIQUE INDEX IFRMAXIMO.TAXTYPE_NDX ON IFRMAXIMO.TAXTYPE (
ORGID ASC,
TYPECODE ASC)
PCTFREE    10
INITRANS   2
MAXTRANS   255
TABLESPACE TSI_MAXIMO
STORAGE   (
            INITIAL    65536
            MINEXTENTS 1
            MAXEXTENTS 2147483645
           )
/

--------------------------------------------------------------------------------------------------------------------
-- CRIAÇÃO DO ÍNDICE: IFRMAXIMO.TOLERANCE_NDX1
--------------------------------------------------------------------------------------------------------------------
CREATE UNIQUE INDEX IFRMAXIMO.TOLERANCE_NDX1 ON IFRMAXIMO.TOLERANCE (
ORGID ASC,
GRPNAME ASC)
PCTFREE    10
INITRANS   2
MAXTRANS   255
TABLESPACE TSI_MAXIMO
STORAGE   (
            INITIAL    65536
            MINEXTENTS 1
            MAXEXTENTS 2147483645
           )
/

--------------------------------------------------------------------------------------------------------------------
-- CRIAÇÃO DO ÍNDICE: IFRMAXIMO.TOOL_NDX1
--------------------------------------------------------------------------------------------------------------------
CREATE UNIQUE INDEX IFRMAXIMO.TOOL_NDX1 ON IFRMAXIMO.TOOL (
ORGID ASC,
TOOLNUM ASC)
PCTFREE    10
INITRANS   2
MAXTRANS   255
TABLESPACE TSI_MAXIMO
STORAGE   (
            INITIAL    65536
            MINEXTENTS 1
            MAXEXTENTS 2147483645
           )
/

--------------------------------------------------------------------------------------------------------------------
-- CRIAÇÃO DO ÍNDICE: IFRMAXIMO.TOOL_NDX2
--------------------------------------------------------------------------------------------------------------------
CREATE  INDEX IFRMAXIMO.TOOL_NDX2 ON IFRMAXIMO.TOOL (
ORGID ASC,
VENDOR ASC)
PCTFREE    10
INITRANS   2
MAXTRANS   255
TABLESPACE TSI_MAXIMO
STORAGE   (
            INITIAL    65536
            MINEXTENTS 1
            MAXEXTENTS 2147483645
           )
/

--------------------------------------------------------------------------------------------------------------------
-- CRIAÇÃO DO ÍNDICE: IFRMAXIMO.TOOLTRANS_NDX1
--------------------------------------------------------------------------------------------------------------------
CREATE  INDEX IFRMAXIMO.TOOLTRANS_NDX1 ON IFRMAXIMO.TOOLTRANS (
ORGID ASC,
TOOLNUM ASC,
TRANSDATE ASC)
PCTFREE    10
INITRANS   2
MAXTRANS   255
TABLESPACE TSI_MAXIMO
STORAGE   (
            INITIAL    65536
            MINEXTENTS 1
            MAXEXTENTS 2147483645
           )
/

--------------------------------------------------------------------------------------------------------------------
-- CRIAÇÃO DO ÍNDICE: IFRMAXIMO.TOOLTRANS_NDX2
--------------------------------------------------------------------------------------------------------------------
CREATE  INDEX IFRMAXIMO.TOOLTRANS_NDX2 ON IFRMAXIMO.TOOLTRANS (
ORGID ASC,
REFWO ASC)
PCTFREE    10
INITRANS   2
MAXTRANS   255
TABLESPACE TSI_MAXIMO
STORAGE   (
            INITIAL    65536
            MINEXTENTS 1
            MAXEXTENTS 2147483645
           )
/

--------------------------------------------------------------------------------------------------------------------
-- CRIAÇÃO DO ÍNDICE: IFRMAXIMO.TOOLTRANS_NDX3
--------------------------------------------------------------------------------------------------------------------
CREATE  INDEX IFRMAXIMO.TOOLTRANS_NDX3 ON IFRMAXIMO.TOOLTRANS (
ORGID ASC,
EQNUM ASC)
PCTFREE    10
INITRANS   2
MAXTRANS   255
TABLESPACE TSI_MAXIMO
STORAGE   (
            INITIAL    65536
            MINEXTENTS 1
            MAXEXTENTS 2147483645
           )
/

--------------------------------------------------------------------------------------------------------------------
-- CRIAÇÃO DO ÍNDICE: IFRMAXIMO.TOOLTRANS_NDX4
--------------------------------------------------------------------------------------------------------------------
CREATE  INDEX IFRMAXIMO.TOOLTRANS_NDX4 ON IFRMAXIMO.TOOLTRANS (
ORGID ASC,
ENTERDATE ASC)
PCTFREE    10
INITRANS   2
MAXTRANS   255
TABLESPACE TSI_MAXIMO
STORAGE   (
            INITIAL    65536
            MINEXTENTS 1
            MAXEXTENTS 2147483645
           )
/

--------------------------------------------------------------------------------------------------------------------
-- CRIAÇÃO DO ÍNDICE: IFRMAXIMO.TOOLTRANS_NDX5
--------------------------------------------------------------------------------------------------------------------
CREATE  INDEX IFRMAXIMO.TOOLTRANS_NDX5 ON IFRMAXIMO.TOOLTRANS (
ORGID ASC,
INTERID ASC)
PCTFREE    10
INITRANS   2
MAXTRANS   255
TABLESPACE TSI_MAXIMO
STORAGE   (
            INITIAL    65536
            MINEXTENTS 1
            MAXEXTENTS 2147483645
           )
/

--------------------------------------------------------------------------------------------------------------------
-- CRIAÇÃO DO ÍNDICE: IFRMAXIMO.TRANS_NDX1
--------------------------------------------------------------------------------------------------------------------
CREATE UNIQUE INDEX IFRMAXIMO.TRANS_NDX1 ON IFRMAXIMO.TRANSLATION (
TBNAME ASC,
NAME ASC,
LANGCODE ASC,
LDKEY ASC)
PCTFREE    10
INITRANS   2
MAXTRANS   255
TABLESPACE TSI_MAXIMO
STORAGE   (
            INITIAL    65536
            MINEXTENTS 1
            MAXEXTENTS 2147483645
           )
/

--------------------------------------------------------------------------------------------------------------------
-- CRIAÇÃO DO ÍNDICE: IFRMAXIMO.TWA_PK
--------------------------------------------------------------------------------------------------------------------
CREATE  INDEX IFRMAXIMO.TWA_PK ON IFRMAXIMO.TAB_WO_AMATL (
NUM_WO_AMATL ASC)
PCTFREE    10
INITRANS   2
MAXTRANS   255
TABLESPACE TSI_MAXIMO
STORAGE   (
            INITIAL    65536
            MINEXTENTS 1
            MAXEXTENTS 2147483645
           )
/

--------------------------------------------------------------------------------------------------------------------
-- CRIAÇÃO DO ÍNDICE: IFRMAXIMO.USERGROUPAUTH_NDX1
--------------------------------------------------------------------------------------------------------------------
CREATE UNIQUE INDEX IFRMAXIMO.USERGROUPAUTH_NDX1 ON IFRMAXIMO.USERGROUPAUTH (
USERNAME ASC,
GRPNAME ASC)
PCTFREE    10
INITRANS   2
MAXTRANS   255
TABLESPACE TSI_MAXIMO
STORAGE   (
            INITIAL    65536
            MINEXTENTS 1
            MAXEXTENTS 2147483645
           )
/

--------------------------------------------------------------------------------------------------------------------
-- CRIAÇÃO DO ÍNDICE: IFRMAXIMO.USERPREF_NDX
--------------------------------------------------------------------------------------------------------------------
CREATE UNIQUE INDEX IFRMAXIMO.USERPREF_NDX ON IFRMAXIMO.USERPREF (
USERNAME ASC,
VARNAME ASC)
PCTFREE    10
INITRANS   2
MAXTRANS   255
TABLESPACE TSI_MAXIMO
STORAGE   (
            INITIAL    65536
            MINEXTENTS 1
            MAXEXTENTS 2147483645
           )
/

--------------------------------------------------------------------------------------------------------------------
-- CRIAÇÃO DO ÍNDICE: IFRMAXIMO.USERRESTRCT_NDX2
--------------------------------------------------------------------------------------------------------------------
CREATE  INDEX IFRMAXIMO.USERRESTRCT_NDX2 ON IFRMAXIMO.USERRESTRICTIONS (
APP ASC)
PCTFREE    10
INITRANS   2
MAXTRANS   255
TABLESPACE TSI_MAXIMO
STORAGE   (
            INITIAL    65536
            MINEXTENTS 1
            MAXEXTENTS 2147483645
           )
/

--------------------------------------------------------------------------------------------------------------------
-- CRIAÇÃO DO ÍNDICE: IFRMAXIMO.VALUELIST_NDX1
--------------------------------------------------------------------------------------------------------------------
CREATE UNIQUE INDEX IFRMAXIMO.VALUELIST_NDX1 ON IFRMAXIMO.VALUELIST (
LISTNAME ASC,
VALUE ASC,
MAXVALUE ASC)
PCTFREE    10
INITRANS   2
MAXTRANS   255
TABLESPACE TSI_MAXIMO
STORAGE   (
            INITIAL    65536
            MINEXTENTS 1
            MAXEXTENTS 2147483645
           )
/

--------------------------------------------------------------------------------------------------------------------
-- CRIAÇÃO DO ÍNDICE: IFRMAXIMO.VALUELIST_NDX3
--------------------------------------------------------------------------------------------------------------------
CREATE  INDEX IFRMAXIMO.VALUELIST_NDX3 ON IFRMAXIMO.VALUELIST (
MAXVALUE ASC)
PCTFREE    10
INITRANS   2
MAXTRANS   255
TABLESPACE TSI_MAXIMO
STORAGE   (
            INITIAL    65536
            MINEXTENTS 1
            MAXEXTENTS 2147483645
           )
/

--------------------------------------------------------------------------------------------------------------------
-- CRIAÇÃO DO ÍNDICE: IFRMAXIMO.VENDORSTATUS_NDX1
--------------------------------------------------------------------------------------------------------------------
CREATE  INDEX IFRMAXIMO.VENDORSTATUS_NDX1 ON IFRMAXIMO.VENDORSTATUS (
ORGID ASC,
STATUSDATE ASC)
PCTFREE    10
INITRANS   2
MAXTRANS   255
TABLESPACE TSI_MAXIMO
STORAGE   (
            INITIAL    65536
            MINEXTENTS 1
            MAXEXTENTS 2147483645
           )
/

--------------------------------------------------------------------------------------------------------------------
-- CRIAÇÃO DO ÍNDICE: IFRMAXIMO.VERITYACTION_NDX1
--------------------------------------------------------------------------------------------------------------------
CREATE UNIQUE INDEX IFRMAXIMO.VERITYACTION_NDX1 ON IFRMAXIMO.VERITYACTION (
ORGID ASC,
TRANSID ASC,
ITEMNUM ASC,
ACTION ASC)
PCTFREE    10
INITRANS   2
MAXTRANS   255
TABLESPACE TSI_MAXIMO
STORAGE   (
            INITIAL    65536
            MINEXTENTS 1
            MAXEXTENTS 2147483645
           )
/

--------------------------------------------------------------------------------------------------------------------
-- CRIAÇÃO DO ÍNDICE: IFRMAXIMO.VLDOMAIN_NDX1
--------------------------------------------------------------------------------------------------------------------
CREATE UNIQUE INDEX IFRMAXIMO.VLDOMAIN_NDX1 ON IFRMAXIMO.VALUELISTDOMAIN (
DOMAINID ASC)
PCTFREE    10
INITRANS   2
MAXTRANS   255
TABLESPACE TSI_MAXIMO
STORAGE   (
            INITIAL    65536
            MINEXTENTS 1
            MAXEXTENTS 2147483645
           )
/

--------------------------------------------------------------------------------------------------------------------
-- CRIAÇÃO DO ÍNDICE: IFRMAXIMO.WFACTIONLIST_NDX1
--------------------------------------------------------------------------------------------------------------------
CREATE UNIQUE INDEX IFRMAXIMO.WFACTIONLIST_NDX1 ON IFRMAXIMO.WFACTIONLIST (
ACTION ASC)
PCTFREE    10
INITRANS   2
MAXTRANS   255
TABLESPACE TSI_MAXIMO
STORAGE   (
            INITIAL    40960
            MINEXTENTS 1
            MAXEXTENTS 2147483645
           )
/

--------------------------------------------------------------------------------------------------------------------
-- CRIAÇÃO DO ÍNDICE: IFRMAXIMO.WFACTION_NDX1
--------------------------------------------------------------------------------------------------------------------
CREATE UNIQUE INDEX IFRMAXIMO.WFACTION_NDX1 ON IFRMAXIMO.WFACTION (
PROCESSID ASC,
ACTIONID ASC,
PROCESSREV ASC)
PCTFREE    10
INITRANS   2
MAXTRANS   255
TABLESPACE TSI_MAXIMO
STORAGE   (
            INITIAL    65536
            MINEXTENTS 1
            MAXEXTENTS 2147483645
           )
/

--------------------------------------------------------------------------------------------------------------------
-- CRIAÇÃO DO ÍNDICE: IFRMAXIMO.WFACTION_NDX2
--------------------------------------------------------------------------------------------------------------------
CREATE  INDEX IFRMAXIMO.WFACTION_NDX2 ON IFRMAXIMO.WFACTION (
PROCESSID ASC,
OWNERNODEID ASC,
PROCESSREV ASC)
PCTFREE    10
INITRANS   2
MAXTRANS   255
TABLESPACE TSI_MAXIMO
STORAGE   (
            INITIAL    65536
            MINEXTENTS 1
            MAXEXTENTS 2147483645
           )
/

--------------------------------------------------------------------------------------------------------------------
-- CRIAÇÃO DO ÍNDICE: IFRMAXIMO.WFACTION_NDX3
--------------------------------------------------------------------------------------------------------------------
CREATE  INDEX IFRMAXIMO.WFACTION_NDX3 ON IFRMAXIMO.WFACTION (
PROCESSID ASC,
PROCESSREV ASC,
MEMBERNODEID ASC)
PCTFREE    10
INITRANS   2
MAXTRANS   255
TABLESPACE TSI_MAXIMO
STORAGE   (
            INITIAL    65536
            MINEXTENTS 1
            MAXEXTENTS 2147483645
           )
/

--------------------------------------------------------------------------------------------------------------------
-- CRIAÇÃO DO ÍNDICE: IFRMAXIMO.WFASSIGN_NDX1
--------------------------------------------------------------------------------------------------------------------
CREATE UNIQUE INDEX IFRMAXIMO.WFASSIGN_NDX1 ON IFRMAXIMO.WFASSIGNMENT (
ASSIGNID ASC,
PROCESSID ASC,
PROCESSREV ASC,
WFID ASC,
NODEID ASC)
PCTFREE    10
INITRANS   2
MAXTRANS   255
TABLESPACE TSI_MAXIMO
STORAGE   (
            INITIAL    65536
            MINEXTENTS 1
            MAXEXTENTS 2147483645
           )
/

--------------------------------------------------------------------------------------------------------------------
-- CRIAÇÃO DO ÍNDICE: IFRMAXIMO.WFASSIGN_NDX2
--------------------------------------------------------------------------------------------------------------------
CREATE  INDEX IFRMAXIMO.WFASSIGN_NDX2 ON IFRMAXIMO.WFASSIGNMENT (
ASSIGNCODE ASC,
ASSIGNSTATUS ASC)
PCTFREE    10
INITRANS   2
MAXTRANS   255
TABLESPACE TSI_MAXIMO
STORAGE   (
            INITIAL    65536
            MINEXTENTS 1
            MAXEXTENTS 2147483645
           )
/

--------------------------------------------------------------------------------------------------------------------
-- CRIAÇÃO DO ÍNDICE: IFRMAXIMO.WFASSIGN_NDX3
--------------------------------------------------------------------------------------------------------------------
CREATE  INDEX IFRMAXIMO.WFASSIGN_NDX3 ON IFRMAXIMO.WFASSIGNMENT (
WFID ASC,
PROCESSID ASC,
PROCESSREV ASC,
NODEID ASC)
PCTFREE    10
INITRANS   2
MAXTRANS   255
TABLESPACE TSI_MAXIMO
STORAGE   (
            INITIAL    65536
            MINEXTENTS 1
            MAXEXTENTS 2147483645
           )
/

--------------------------------------------------------------------------------------------------------------------
-- CRIAÇÃO DO ÍNDICE: IFRMAXIMO.WFASSIGN_NDX4
--------------------------------------------------------------------------------------------------------------------
CREATE  INDEX IFRMAXIMO.WFASSIGN_NDX4 ON IFRMAXIMO.WFASSIGNMENT (
ASSIGNSTATUS ASC)
PCTFREE    10
INITRANS   2
MAXTRANS   255
TABLESPACE TSI_MAXIMO
STORAGE   (
            INITIAL    65536
            MINEXTENTS 1
            MAXEXTENTS 2147483645
           )
/

--------------------------------------------------------------------------------------------------------------------
-- CRIAÇÃO DO ÍNDICE: IFRMAXIMO.WFCALLSTACK_NDX1
--------------------------------------------------------------------------------------------------------------------
CREATE  INDEX IFRMAXIMO.WFCALLSTACK_NDX1 ON IFRMAXIMO.WFCALLSTACK (
WFID ASC,
PROCESSID ASC,
ACTIVE ASC,
PROCESSREV ASC)
PCTFREE    10
INITRANS   2
MAXTRANS   255
TABLESPACE TSI_MAXIMO
STORAGE   (
            INITIAL    65536
            MINEXTENTS 1
            MAXEXTENTS 2147483645
           )
/

--------------------------------------------------------------------------------------------------------------------
-- CRIAÇÃO DO ÍNDICE: IFRMAXIMO.WFCALLSTACK_NDX2
--------------------------------------------------------------------------------------------------------------------
CREATE  INDEX IFRMAXIMO.WFCALLSTACK_NDX2 ON IFRMAXIMO.WFCALLSTACK (
WFID ASC)
PCTFREE    10
INITRANS   2
MAXTRANS   255
TABLESPACE TSI_MAXIMO
STORAGE   (
            INITIAL    65536
            MINEXTENTS 1
            MAXEXTENTS 2147483645
           )
/

--------------------------------------------------------------------------------------------------------------------
-- CRIAÇÃO DO ÍNDICE: IFRMAXIMO.WFCALLSTACK_NDX3
--------------------------------------------------------------------------------------------------------------------
CREATE UNIQUE INDEX IFRMAXIMO.WFCALLSTACK_NDX3 ON IFRMAXIMO.WFCALLSTACK (
WFID ASC,
CALLSEQ ASC)
PCTFREE    10
INITRANS   2
MAXTRANS   255
TABLESPACE TSI_MAXIMO
STORAGE   (
            INITIAL    65536
            MINEXTENTS 1
            MAXEXTENTS 2147483645
           )
/

--------------------------------------------------------------------------------------------------------------------
-- CRIAÇÃO DO ÍNDICE: IFRMAXIMO.WFCONDITION_NDX1
--------------------------------------------------------------------------------------------------------------------
CREATE UNIQUE INDEX IFRMAXIMO.WFCONDITION_NDX1 ON IFRMAXIMO.WFCONDITION (
PROCESSID ASC,
NODEID ASC,
PROCESSREV ASC,
ASSIGNID ASC)
PCTFREE    10
INITRANS   2
MAXTRANS   255
TABLESPACE TSI_MAXIMO
STORAGE   (
            INITIAL    65536
            MINEXTENTS 1
            MAXEXTENTS 2147483645
           )
/

--------------------------------------------------------------------------------------------------------------------
-- CRIAÇÃO DO ÍNDICE: IFRMAXIMO.WFINPUT_NDX1
--------------------------------------------------------------------------------------------------------------------
CREATE UNIQUE INDEX IFRMAXIMO.WFINPUT_NDX1 ON IFRMAXIMO.WFINPUT (
PROCESSID ASC,
NODEID ASC,
PROCESSREV ASC)
PCTFREE    10
INITRANS   2
MAXTRANS   255
TABLESPACE TSI_MAXIMO
STORAGE   (
            INITIAL    65536
            MINEXTENTS 1
            MAXEXTENTS 2147483645
           )
/

--------------------------------------------------------------------------------------------------------------------
-- CRIAÇÃO DO ÍNDICE: IFRMAXIMO.WFINSTANCE_NDX1
--------------------------------------------------------------------------------------------------------------------
CREATE UNIQUE INDEX IFRMAXIMO.WFINSTANCE_NDX1 ON IFRMAXIMO.WFINSTANCE (
WFID ASC)
PCTFREE    10
INITRANS   2
MAXTRANS   255
TABLESPACE TSI_MAXIMO
STORAGE   (
            INITIAL    65536
            MINEXTENTS 1
            MAXEXTENTS 2147483645
           )
/

--------------------------------------------------------------------------------------------------------------------
-- CRIAÇÃO DO ÍNDICE: IFRMAXIMO.WFNODE_NDX1
--------------------------------------------------------------------------------------------------------------------
CREATE UNIQUE INDEX IFRMAXIMO.WFNODE_NDX1 ON IFRMAXIMO.WFNODE (
PROCESSID ASC,
NODEID ASC,
PROCESSREV ASC)
PCTFREE    10
INITRANS   2
MAXTRANS   255
TABLESPACE TSI_MAXIMO
STORAGE   (
            INITIAL    65536
            MINEXTENTS 1
            MAXEXTENTS 2147483645
           )
/

--------------------------------------------------------------------------------------------------------------------
-- CRIAÇÃO DO ÍNDICE: IFRMAXIMO.WFNODE_NDX2
--------------------------------------------------------------------------------------------------------------------
CREATE  INDEX IFRMAXIMO.WFNODE_NDX2 ON IFRMAXIMO.WFNODE (
PROCESSID ASC,
PROCESSREV ASC)
PCTFREE    10
INITRANS   2
MAXTRANS   255
TABLESPACE TSI_MAXIMO
STORAGE   (
            INITIAL    65536
            MINEXTENTS 1
            MAXEXTENTS 2147483645
           )
/

--------------------------------------------------------------------------------------------------------------------
-- CRIAÇÃO DO ÍNDICE: IFRMAXIMO.WFNODE_NDX3
--------------------------------------------------------------------------------------------------------------------
CREATE  INDEX IFRMAXIMO.WFNODE_NDX3 ON IFRMAXIMO.WFNODE (
PROCESSID ASC,
PROCESSREV ASC,
NODETYPE ASC)
PCTFREE    10
INITRANS   2
MAXTRANS   255
TABLESPACE TSI_MAXIMO
STORAGE   (
            INITIAL    65536
            MINEXTENTS 1
            MAXEXTENTS 2147483645
           )
/

--------------------------------------------------------------------------------------------------------------------
-- CRIAÇÃO DO ÍNDICE: IFRMAXIMO.WFNOTIFY_NDX1
--------------------------------------------------------------------------------------------------------------------
CREATE UNIQUE INDEX IFRMAXIMO.WFNOTIFY_NDX1 ON IFRMAXIMO.WFNOTIFICATION (
NOTIFICATIONID ASC,
PROCESSID ASC,
PROCESSREV ASC,
WFID ASC)
PCTFREE    10
INITRANS   2
MAXTRANS   255
TABLESPACE TSI_MAXIMO
STORAGE   (
            INITIAL    65536
            MINEXTENTS 1
            MAXEXTENTS 2147483645
           )
/

--------------------------------------------------------------------------------------------------------------------
-- CRIAÇÃO DO ÍNDICE: IFRMAXIMO.WFNOTIFY_NDX2
--------------------------------------------------------------------------------------------------------------------
CREATE  INDEX IFRMAXIMO.WFNOTIFY_NDX2 ON IFRMAXIMO.WFNOTIFICATION (
WFID ASC,
PROCESSID ASC,
PROCESSREV ASC,
NODEID ASC)
PCTFREE    10
INITRANS   2
MAXTRANS   255
TABLESPACE TSI_MAXIMO
STORAGE   (
            INITIAL    65536
            MINEXTENTS 1
            MAXEXTENTS 2147483645
           )
/

--------------------------------------------------------------------------------------------------------------------
-- CRIAÇÃO DO ÍNDICE: IFRMAXIMO.WFNOTIFY_NDX3
--------------------------------------------------------------------------------------------------------------------
CREATE  INDEX IFRMAXIMO.WFNOTIFY_NDX3 ON IFRMAXIMO.WFNOTIFICATION (
NOTIFYSTATUS ASC)
PCTFREE    10
INITRANS   2
MAXTRANS   255
TABLESPACE TSI_MAXIMO
STORAGE   (
            INITIAL    65536
            MINEXTENTS 1
            MAXEXTENTS 2147483645
           )
/

--------------------------------------------------------------------------------------------------------------------
-- CRIAÇÃO DO ÍNDICE: IFRMAXIMO.WFPROCESS_NDX1
--------------------------------------------------------------------------------------------------------------------
CREATE UNIQUE INDEX IFRMAXIMO.WFPROCESS_NDX1 ON IFRMAXIMO.WFPROCESS (
PROCESSID ASC,
PROCESSREV ASC)
PCTFREE    10
INITRANS   2
MAXTRANS   255
TABLESPACE TSI_MAXIMO
STORAGE   (
            INITIAL    65536
            MINEXTENTS 1
            MAXEXTENTS 2147483645
           )
/

--------------------------------------------------------------------------------------------------------------------
-- CRIAÇÃO DO ÍNDICE: IFRMAXIMO.WFPROCESS_NDX2
--------------------------------------------------------------------------------------------------------------------
CREATE  INDEX IFRMAXIMO.WFPROCESS_NDX2 ON IFRMAXIMO.WFPROCESS (
PROCESSTYPE ASC,
ENABLED ASC)
PCTFREE    10
INITRANS   2
MAXTRANS   255
TABLESPACE TSI_MAXIMO
STORAGE   (
            INITIAL    65536
            MINEXTENTS 1
            MAXEXTENTS 2147483645
           )
/

--------------------------------------------------------------------------------------------------------------------
-- CRIAÇÃO DO ÍNDICE: IFRMAXIMO.WFPROCESS_NDX3
--------------------------------------------------------------------------------------------------------------------
CREATE  INDEX IFRMAXIMO.WFPROCESS_NDX3 ON IFRMAXIMO.WFPROCESS (
MIGRATED ASC)
PCTFREE    10
INITRANS   2
MAXTRANS   255
TABLESPACE TSI_MAXIMO
STORAGE   (
            INITIAL    65536
            MINEXTENTS 1
            MAXEXTENTS 2147483645
           )
/

--------------------------------------------------------------------------------------------------------------------
-- CRIAÇÃO DO ÍNDICE: IFRMAXIMO.WFREVISION_NDX1
--------------------------------------------------------------------------------------------------------------------
CREATE UNIQUE INDEX IFRMAXIMO.WFREVISION_NDX1 ON IFRMAXIMO.WFREVISION (
PROCESSTYPE ASC,
REVISION ASC,
PROCESSID ASC)
PCTFREE    10
INITRANS   2
MAXTRANS   255
TABLESPACE TSI_MAXIMO
STORAGE   (
            INITIAL    65536
            MINEXTENTS 1
            MAXEXTENTS 2147483645
           )
/

--------------------------------------------------------------------------------------------------------------------
-- CRIAÇÃO DO ÍNDICE: IFRMAXIMO.WFREVISION_NDX2
--------------------------------------------------------------------------------------------------------------------
CREATE  INDEX IFRMAXIMO.WFREVISION_NDX2 ON IFRMAXIMO.WFREVISION (
MAINTBNAME ASC)
PCTFREE    10
INITRANS   2
MAXTRANS   255
TABLESPACE TSI_MAXIMO
STORAGE   (
            INITIAL    65536
            MINEXTENTS 1
            MAXEXTENTS 2147483645
           )
/

--------------------------------------------------------------------------------------------------------------------
-- CRIAÇÃO DO ÍNDICE: IFRMAXIMO.WFREVISION_NDX3
--------------------------------------------------------------------------------------------------------------------
CREATE  INDEX IFRMAXIMO.WFREVISION_NDX3 ON IFRMAXIMO.WFREVISION (
REVISION ASC)
PCTFREE    10
INITRANS   2
MAXTRANS   255
TABLESPACE TSI_MAXIMO
STORAGE   (
            INITIAL    65536
            MINEXTENTS 1
            MAXEXTENTS 2147483645
           )
/

--------------------------------------------------------------------------------------------------------------------
-- CRIAÇÃO DO ÍNDICE: IFRMAXIMO.WFROLE_NDX1
--------------------------------------------------------------------------------------------------------------------
CREATE UNIQUE INDEX IFRMAXIMO.WFROLE_NDX1 ON IFRMAXIMO.WFROLE (
ROLEID ASC)
PCTFREE    10
INITRANS   2
MAXTRANS   255
TABLESPACE TSI_MAXIMO
STORAGE   (
            INITIAL    65536
            MINEXTENTS 1
            MAXEXTENTS 2147483645
           )
/

--------------------------------------------------------------------------------------------------------------------
-- CRIAÇÃO DO ÍNDICE: IFRMAXIMO.WFSTART_NDX1
--------------------------------------------------------------------------------------------------------------------
CREATE UNIQUE INDEX IFRMAXIMO.WFSTART_NDX1 ON IFRMAXIMO.WFSTART (
PROCESSID ASC,
NODEID ASC,
PROCESSREV ASC)
PCTFREE    10
INITRANS   2
MAXTRANS   255
TABLESPACE TSI_MAXIMO
STORAGE   (
            INITIAL    65536
            MINEXTENTS 1
            MAXEXTENTS 2147483645
           )
/

--------------------------------------------------------------------------------------------------------------------
-- CRIAÇÃO DO ÍNDICE: IFRMAXIMO.WFSTOP_NDX1
--------------------------------------------------------------------------------------------------------------------
CREATE UNIQUE INDEX IFRMAXIMO.WFSTOP_NDX1 ON IFRMAXIMO.WFSTOP (
PROCESSID ASC,
NODEID ASC,
PROCESSREV ASC)
PCTFREE    10
INITRANS   2
MAXTRANS   255
TABLESPACE TSI_MAXIMO
STORAGE   (
            INITIAL    65536
            MINEXTENTS 1
            MAXEXTENTS 2147483645
           )
/

--------------------------------------------------------------------------------------------------------------------
-- CRIAÇÃO DO ÍNDICE: IFRMAXIMO.WFSUBPROC_NDX1
--------------------------------------------------------------------------------------------------------------------
CREATE UNIQUE INDEX IFRMAXIMO.WFSUBPROC_NDX1 ON IFRMAXIMO.WFSUBPROCESS (
PROCESSID ASC,
NODEID ASC,
PROCESSREV ASC)
PCTFREE    10
INITRANS   2
MAXTRANS   255
TABLESPACE TSI_MAXIMO
STORAGE   (
            INITIAL    65536
            MINEXTENTS 1
            MAXEXTENTS 2147483645
           )
/

--------------------------------------------------------------------------------------------------------------------
-- CRIAÇÃO DO ÍNDICE: IFRMAXIMO.WFTASK_NDX1
--------------------------------------------------------------------------------------------------------------------
CREATE UNIQUE INDEX IFRMAXIMO.WFTASK_NDX1 ON IFRMAXIMO.WFTASK (
PROCESSID ASC,
NODEID ASC,
PROCESSREV ASC)
PCTFREE    10
INITRANS   2
MAXTRANS   255
TABLESPACE TSI_MAXIMO
STORAGE   (
            INITIAL    65536
            MINEXTENTS 1
            MAXEXTENTS 2147483645
           )
/

--------------------------------------------------------------------------------------------------------------------
-- CRIAÇÃO DO ÍNDICE: IFRMAXIMO.WFTRANSACTION_NDX1
--------------------------------------------------------------------------------------------------------------------
CREATE  INDEX IFRMAXIMO.WFTRANSACTION_NDX1 ON IFRMAXIMO.WFTRANSACTION (
NODEID ASC,
PROCESSID ASC,
WFID ASC,
TRANSDATE ASC)
PCTFREE    10
INITRANS   2
MAXTRANS   255
TABLESPACE TSI_MAXIMO
STORAGE   (
            INITIAL    65536
            MINEXTENTS 1
            MAXEXTENTS 2147483645
           )
/

--------------------------------------------------------------------------------------------------------------------
-- CRIAÇÃO DO ÍNDICE: IFRMAXIMO.WFTRANSACTION_NDX2
--------------------------------------------------------------------------------------------------------------------
CREATE UNIQUE INDEX IFRMAXIMO.WFTRANSACTION_NDX2 ON IFRMAXIMO.WFTRANSACTION (
TRANSID ASC,
NODEID ASC,
PROCESSID ASC,
WFID ASC)
PCTFREE    10
INITRANS   2
MAXTRANS   255
TABLESPACE TSI_MAXIMO
STORAGE   (
            INITIAL    65536
            MINEXTENTS 1
            MAXEXTENTS 2147483645
           )
/

--------------------------------------------------------------------------------------------------------------------
-- CRIAÇÃO DO ÍNDICE: IFRMAXIMO.WOANCESTOR_NDX1
--------------------------------------------------------------------------------------------------------------------
CREATE UNIQUE INDEX IFRMAXIMO.WOANCESTOR_NDX1 ON IFRMAXIMO.WOANCESTOR (
SITEID ASC,
WONUM ASC,
ANCESTOR ASC)
PCTFREE    10
INITRANS   2
MAXTRANS   255
TABLESPACE TSI_MAXIMO
STORAGE   (
            INITIAL    65536
            MINEXTENTS 1
            MAXEXTENTS 2147483645
           )
/

--------------------------------------------------------------------------------------------------------------------
-- CRIAÇÃO DO ÍNDICE: IFRMAXIMO.WOANCESTOR_NDX2
--------------------------------------------------------------------------------------------------------------------
CREATE  INDEX IFRMAXIMO.WOANCESTOR_NDX2 ON IFRMAXIMO.WOANCESTOR (
SITEID ASC,
ANCESTOR ASC)
PCTFREE    10
INITRANS   2
MAXTRANS   255
TABLESPACE TSI_MAXIMO
STORAGE   (
            INITIAL    65536
            MINEXTENTS 1
            MAXEXTENTS 2147483645
           )
/

--------------------------------------------------------------------------------------------------------------------
-- CRIAÇÃO DO ÍNDICE: IFRMAXIMO.WOANCESTOR_NDX4
--------------------------------------------------------------------------------------------------------------------
CREATE  INDEX IFRMAXIMO.WOANCESTOR_NDX4 ON IFRMAXIMO.WOANCESTOR (
WONUM ASC)
PCTFREE    10
INITRANS   2
MAXTRANS   255
TABLESPACE TSI_MAXIMO
STORAGE   (
            INITIAL    65536
            MINEXTENTS 1
            MAXEXTENTS 2147483645
           )
/

--------------------------------------------------------------------------------------------------------------------
-- CRIAÇÃO DO ÍNDICE: IFRMAXIMO.WOASSIGNPARTY_NDX1
--------------------------------------------------------------------------------------------------------------------
CREATE UNIQUE INDEX IFRMAXIMO.WOASSIGNPARTY_NDX1 ON IFRMAXIMO.WOASSIGNMNTPARTY (
SITEID ASC,
WOASSIGNMNTQUEUEID ASC,
RESPPARTYGROUP ASC,
RESPPARTY ASC)
PCTFREE    10
INITRANS   2
MAXTRANS   255
TABLESPACE TSI_MAXIMO
STORAGE   (
            INITIAL    65536
            MINEXTENTS 1
            MAXEXTENTS 2147483645
           )
/

--------------------------------------------------------------------------------------------------------------------
-- CRIAÇÃO DO ÍNDICE: IFRMAXIMO.WOASSIGNPARTY_NDX2
--------------------------------------------------------------------------------------------------------------------
CREATE  INDEX IFRMAXIMO.WOASSIGNPARTY_NDX2 ON IFRMAXIMO.WOASSIGNMNTPARTY (
SITEID ASC,
WOASSIGNMNTQUEUEID ASC,
RESPPARTYGROUPSEQ ASC,
RESPPARTYSEQ ASC)
PCTFREE    10
INITRANS   2
MAXTRANS   255
TABLESPACE TSI_MAXIMO
STORAGE   (
            INITIAL    65536
            MINEXTENTS 1
            MAXEXTENTS 2147483645
           )
/

--------------------------------------------------------------------------------------------------------------------
-- CRIAÇÃO DO ÍNDICE: IFRMAXIMO.WOASSIGNQUEUE_NDX1
--------------------------------------------------------------------------------------------------------------------
CREATE UNIQUE INDEX IFRMAXIMO.WOASSIGNQUEUE_NDX1 ON IFRMAXIMO.WOASSIGNMNTQUEUE (
SITEID ASC,
WOASSIGNMNTQUEUEID ASC)
PCTFREE    10
INITRANS   2
MAXTRANS   255
TABLESPACE TSI_MAXIMO
STORAGE   (
            INITIAL    65536
            MINEXTENTS 1
            MAXEXTENTS 2147483645
           )
/

--------------------------------------------------------------------------------------------------------------------
-- CRIAÇÃO DO ÍNDICE: IFRMAXIMO.WOGEN_NDX1
--------------------------------------------------------------------------------------------------------------------
CREATE UNIQUE INDEX IFRMAXIMO.WOGEN_NDX1 ON IFRMAXIMO.WOGEN (
SITEID ASC,
RUNID ASC,
RUNORDER ASC)
PCTFREE    10
INITRANS   2
MAXTRANS   255
TABLESPACE TSI_MAXIMO
STORAGE   (
            INITIAL    65536
            MINEXTENTS 1
            MAXEXTENTS 2147483645
           )
/

--------------------------------------------------------------------------------------------------------------------
-- CRIAÇÃO DO ÍNDICE: IFRMAXIMO.WOHAZARD_NDX1
--------------------------------------------------------------------------------------------------------------------
CREATE UNIQUE INDEX IFRMAXIMO.WOHAZARD_NDX1 ON IFRMAXIMO.WOHAZARD (
SITEID ASC,
WONUM ASC,
HAZARDID ASC,
WOSAFETYDATASOURCE ASC)
PCTFREE    10
INITRANS   2
MAXTRANS   255
TABLESPACE TSI_MAXIMO
STORAGE   (
            INITIAL    65536
            MINEXTENTS 1
            MAXEXTENTS 2147483645
           )
/

--------------------------------------------------------------------------------------------------------------------
-- CRIAÇÃO DO ÍNDICE: IFRMAXIMO.WOHAZARDPREC_NDX1
--------------------------------------------------------------------------------------------------------------------
CREATE UNIQUE INDEX IFRMAXIMO.WOHAZARDPREC_NDX1 ON IFRMAXIMO.WOHAZARDPREC (
SITEID ASC,
WONUM ASC,
HAZARDID ASC,
PRECAUTIONID ASC,
WOSAFETYDATASOURCE ASC)
PCTFREE    10
INITRANS   2
MAXTRANS   255
TABLESPACE TSI_MAXIMO
STORAGE   (
            INITIAL    65536
            MINEXTENTS 1
            MAXEXTENTS 2147483645
           )
/

--------------------------------------------------------------------------------------------------------------------
-- CRIAÇÃO DO ÍNDICE: IFRMAXIMO.WOHISTORICO_NDX1
--------------------------------------------------------------------------------------------------------------------
CREATE UNIQUE INDEX IFRMAXIMO.WOHISTORICO_NDX1 ON IFRMAXIMO.WOHISTORICO (
SITEID ASC,
WONUM ASC)
PCTFREE    0
INITRANS   2
MAXTRANS   255
TABLESPACE TSI_MAXIMO
STORAGE   (
            INITIAL    65536
            MINEXTENTS 1
            MAXEXTENTS 2147483645
           )
/

--------------------------------------------------------------------------------------------------------------------
-- CRIAÇÃO DO ÍNDICE: IFRMAXIMO.WOHISTORICO_NDX10
--------------------------------------------------------------------------------------------------------------------
CREATE  INDEX IFRMAXIMO.WOHISTORICO_NDX10 ON IFRMAXIMO.WOHISTORICO (
PARENT ASC,
SITEID ASC)
PCTFREE    0
INITRANS   2
MAXTRANS   255
TABLESPACE TSI_MAXIMO
STORAGE   (
            INITIAL    65536
            MINEXTENTS 1
            MAXEXTENTS 2147483645
           )
/

--------------------------------------------------------------------------------------------------------------------
-- CRIAÇÃO DO ÍNDICE: IFRMAXIMO.WOHISTORICO_NDX11
--------------------------------------------------------------------------------------------------------------------
CREATE  INDEX IFRMAXIMO.WOHISTORICO_NDX11 ON IFRMAXIMO.WOHISTORICO (
WOPM7 ASC,
SITEID ASC)
PCTFREE    0
INITRANS   2
MAXTRANS   255
TABLESPACE TSI_MAXIMO
STORAGE   (
            INITIAL    65536
            MINEXTENTS 1
            MAXEXTENTS 2147483645
           )
/

--------------------------------------------------------------------------------------------------------------------
-- CRIAÇÃO DO ÍNDICE: IFRMAXIMO.WOHISTORICO_NDX12
--------------------------------------------------------------------------------------------------------------------
CREATE UNIQUE INDEX IFRMAXIMO.WOHISTORICO_NDX12 ON IFRMAXIMO.WOHISTORICO (
WONUM ASC,
ISTASK ASC,
HISTORYFLAG ASC)
PCTFREE    0
INITRANS   2
MAXTRANS   255
TABLESPACE TSI_MAXIMO
STORAGE   (
            INITIAL    65536
            MINEXTENTS 1
            MAXEXTENTS 2147483645
           )
/

--------------------------------------------------------------------------------------------------------------------
-- CRIAÇÃO DO ÍNDICE: IFRMAXIMO.WOHISTORICO_NDX13
--------------------------------------------------------------------------------------------------------------------
CREATE  INDEX IFRMAXIMO.WOHISTORICO_NDX13 ON IFRMAXIMO.WOHISTORICO (
SITEID ASC,
ISTASK ASC,
HISTORYFLAG ASC)
PCTFREE    0
INITRANS   2
MAXTRANS   255
TABLESPACE TSI_MAXIMO
STORAGE   (
            INITIAL    65536
            MINEXTENTS 1
            MAXEXTENTS 2147483645
           )
/

--------------------------------------------------------------------------------------------------------------------
-- CRIAÇÃO DO ÍNDICE: IFRMAXIMO.WOHISTORICO_NDX14
--------------------------------------------------------------------------------------------------------------------
CREATE  INDEX IFRMAXIMO.WOHISTORICO_NDX14 ON IFRMAXIMO.WOHISTORICO (
HISTORYFLAG ASC,
ISTASK ASC,
WOPM7 ASC,
SITEID ASC)
PCTFREE    0
INITRANS   2
MAXTRANS   255
TABLESPACE TSI_MAXIMO
STORAGE   (
            INITIAL    65536
            MINEXTENTS 1
            MAXEXTENTS 2147483645
           )
/

--------------------------------------------------------------------------------------------------------------------
-- CRIAÇÃO DO ÍNDICE: IFRMAXIMO.WOHISTORICO_NDX15
--------------------------------------------------------------------------------------------------------------------
CREATE  INDEX IFRMAXIMO.WOHISTORICO_NDX15 ON IFRMAXIMO.WOHISTORICO (
WOPM6 ASC,
SITEID ASC)
PCTFREE    0
INITRANS   2
MAXTRANS   255
TABLESPACE TSI_MAXIMO
STORAGE   (
            INITIAL    65536
            MINEXTENTS 1
            MAXEXTENTS 2147483645
           )
/

--------------------------------------------------------------------------------------------------------------------
-- CRIAÇÃO DO ÍNDICE: IFRMAXIMO.WOHISTORICO_NDX16
--------------------------------------------------------------------------------------------------------------------
CREATE  INDEX IFRMAXIMO.WOHISTORICO_NDX16 ON IFRMAXIMO.WOHISTORICO (
SITEID ASC,
CREWID ASC)
PCTFREE    0
INITRANS   2
MAXTRANS   255
TABLESPACE TSI_MAXIMO
STORAGE   (
            INITIAL    65536
            MINEXTENTS 1
            MAXEXTENTS 2147483645
           )
/

--------------------------------------------------------------------------------------------------------------------
-- CRIAÇÃO DO ÍNDICE: IFRMAXIMO.WOHISTORICO_NDX17
--------------------------------------------------------------------------------------------------------------------
CREATE  INDEX IFRMAXIMO.WOHISTORICO_NDX17 ON IFRMAXIMO.WOHISTORICO (
LDKEY ASC)
PCTFREE    0
INITRANS   2
MAXTRANS   255
TABLESPACE TSI_MAXIMO
STORAGE   (
            INITIAL    65536
            MINEXTENTS 1
            MAXEXTENTS 2147483645
           )
/

--------------------------------------------------------------------------------------------------------------------
-- CRIAÇÃO DO ÍNDICE: IFRMAXIMO.WOHISTORICO_NDX18
--------------------------------------------------------------------------------------------------------------------
CREATE  INDEX IFRMAXIMO.WOHISTORICO_NDX18 ON IFRMAXIMO.WOHISTORICO (
SITEID ASC,
CREWID ASC,
STATUS ASC)
PCTFREE    0
INITRANS   2
MAXTRANS   255
TABLESPACE TSI_MAXIMO
STORAGE   (
            INITIAL    65536
            MINEXTENTS 1
            MAXEXTENTS 2147483645
           )
/

--------------------------------------------------------------------------------------------------------------------
-- CRIAÇÃO DO ÍNDICE: IFRMAXIMO.WOHISTORICO_NDX2
--------------------------------------------------------------------------------------------------------------------
CREATE  INDEX IFRMAXIMO.WOHISTORICO_NDX2 ON IFRMAXIMO.WOHISTORICO (
SITEID ASC,
STATUS ASC)
PCTFREE    0
INITRANS   2
MAXTRANS   255
TABLESPACE TSI_MAXIMO
STORAGE   (
            INITIAL    65536
            MINEXTENTS 1
            MAXEXTENTS 2147483645
           )
/

--------------------------------------------------------------------------------------------------------------------
-- CRIAÇÃO DO ÍNDICE: IFRMAXIMO.WOHISTORICO_NDX3
--------------------------------------------------------------------------------------------------------------------
CREATE  INDEX IFRMAXIMO.WOHISTORICO_NDX3 ON IFRMAXIMO.WOHISTORICO (
SITEID ASC,
HISTORYFLAG ASC)
PCTFREE    0
INITRANS   2
MAXTRANS   255
TABLESPACE TSI_MAXIMO
STORAGE   (
            INITIAL    65536
            MINEXTENTS 1
            MAXEXTENTS 2147483645
           )
/

--------------------------------------------------------------------------------------------------------------------
-- CRIAÇÃO DO ÍNDICE: IFRMAXIMO.WOHISTORICO_NDX4
--------------------------------------------------------------------------------------------------------------------
CREATE  INDEX IFRMAXIMO.WOHISTORICO_NDX4 ON IFRMAXIMO.WOHISTORICO (
SITEID ASC,
INTERID ASC)
PCTFREE    0
INITRANS   2
MAXTRANS   255
TABLESPACE TSI_MAXIMO
STORAGE   (
            INITIAL    65536
            MINEXTENTS 1
            MAXEXTENTS 2147483645
           )
/

--------------------------------------------------------------------------------------------------------------------
-- CRIAÇÃO DO ÍNDICE: IFRMAXIMO.WOHISTORICO_NDX5
--------------------------------------------------------------------------------------------------------------------
CREATE  INDEX IFRMAXIMO.WOHISTORICO_NDX5 ON IFRMAXIMO.WOHISTORICO (
SITEID ASC,
WFID ASC)
PCTFREE    0
INITRANS   2
MAXTRANS   255
TABLESPACE TSI_MAXIMO
STORAGE   (
            INITIAL    65536
            MINEXTENTS 1
            MAXEXTENTS 2147483645
           )
/

--------------------------------------------------------------------------------------------------------------------
-- CRIAÇÃO DO ÍNDICE: IFRMAXIMO.WOHISTORICO_NDX6
--------------------------------------------------------------------------------------------------------------------
CREATE  INDEX IFRMAXIMO.WOHISTORICO_NDX6 ON IFRMAXIMO.WOHISTORICO (
SITEID ASC,
RESPONDBY ASC)
PCTFREE    0
INITRANS   2
MAXTRANS   255
TABLESPACE TSI_MAXIMO
STORAGE   (
            INITIAL    65536
            MINEXTENTS 1
            MAXEXTENTS 2147483645
           )
/

--------------------------------------------------------------------------------------------------------------------
-- CRIAÇÃO DO ÍNDICE: IFRMAXIMO.WOHISTORICO_NDX7
--------------------------------------------------------------------------------------------------------------------
CREATE  INDEX IFRMAXIMO.WOHISTORICO_NDX7 ON IFRMAXIMO.WOHISTORICO (
SITEID ASC,
EQNUM ASC,
PROBLEMCODE ASC,
STATUS ASC)
PCTFREE    0
INITRANS   2
MAXTRANS   255
TABLESPACE TSI_MAXIMO
STORAGE   (
            INITIAL    65536
            MINEXTENTS 1
            MAXEXTENTS 2147483645
           )
/

--------------------------------------------------------------------------------------------------------------------
-- CRIAÇÃO DO ÍNDICE: IFRMAXIMO.WOHISTORICO_NDX8
--------------------------------------------------------------------------------------------------------------------
CREATE  INDEX IFRMAXIMO.WOHISTORICO_NDX8 ON IFRMAXIMO.WOHISTORICO (
SITEID ASC,
JPNUM ASC)
PCTFREE    0
INITRANS   2
MAXTRANS   255
TABLESPACE TSI_MAXIMO
STORAGE   (
            INITIAL    65536
            MINEXTENTS 1
            MAXEXTENTS 2147483645
           )
/

--------------------------------------------------------------------------------------------------------------------
-- CRIAÇÃO DO ÍNDICE: IFRMAXIMO.WOHISTORICO_NDX9
--------------------------------------------------------------------------------------------------------------------
CREATE  INDEX IFRMAXIMO.WOHISTORICO_NDX9 ON IFRMAXIMO.WOHISTORICO (
SITEID ASC,
LOCATION ASC,
PROBLEMCODE ASC,
STATUS ASC)
PCTFREE    0
INITRANS   2
MAXTRANS   255
TABLESPACE TSI_MAXIMO
STORAGE   (
            INITIAL    65536
            MINEXTENTS 1
            MAXEXTENTS 2147483645
           )
/

--------------------------------------------------------------------------------------------------------------------
-- CRIAÇÃO DO ÍNDICE: IFRMAXIMO.WOLOCKOUT_NDX1
--------------------------------------------------------------------------------------------------------------------
CREATE UNIQUE INDEX IFRMAXIMO.WOLOCKOUT_NDX1 ON IFRMAXIMO.WOLOCKOUT (
SITEID ASC,
WONUM ASC,
LOCKOUTID ASC,
WOSAFETYDATASOURCE ASC)
PCTFREE    10
INITRANS   2
MAXTRANS   255
TABLESPACE TSI_MAXIMO
STORAGE   (
            INITIAL    65536
            MINEXTENTS 1
            MAXEXTENTS 2147483645
           )
/

--------------------------------------------------------------------------------------------------------------------
-- CRIAÇÃO DO ÍNDICE: IFRMAXIMO.WOPRECAUTION_NDX1
--------------------------------------------------------------------------------------------------------------------
CREATE UNIQUE INDEX IFRMAXIMO.WOPRECAUTION_NDX1 ON IFRMAXIMO.WOPRECAUTION (
SITEID ASC,
WONUM ASC,
PRECAUTIONID ASC,
WOSAFETYDATASOURCE ASC)
PCTFREE    10
INITRANS   2
MAXTRANS   255
TABLESPACE TSI_MAXIMO
STORAGE   (
            INITIAL    65536
            MINEXTENTS 1
            MAXEXTENTS 2147483645
           )
/

--------------------------------------------------------------------------------------------------------------------
-- CRIAÇÃO DO ÍNDICE: IFRMAXIMO.WORKORDER_BKP_NDX1
--------------------------------------------------------------------------------------------------------------------
CREATE UNIQUE INDEX IFRMAXIMO.WORKORDER_BKP_NDX1 ON IFRMAXIMO.WORKORDER_BKP (
SITEID ASC,
WONUM ASC)
PCTFREE    10
INITRANS   2
MAXTRANS   255
TABLESPACE TSD_MAXIMO
STORAGE   (
            INITIAL    65536
            MINEXTENTS 1
            MAXEXTENTS 2147483645
           )
/

--------------------------------------------------------------------------------------------------------------------
-- CRIAÇÃO DO ÍNDICE: IFRMAXIMO.WORKORDER_IDX_TEMP
--------------------------------------------------------------------------------------------------------------------
CREATE  INDEX IFRMAXIMO.WORKORDER_IDX_TEMP ON IFRMAXIMO.WORKORDER (
SITEID ASC,
STATUS ASC,
STATUSDATE ASC)
PCTFREE    10
INITRANS   2
MAXTRANS   255
TABLESPACE TSI_MAXIMO
STORAGE   (
            INITIAL    65536
            MINEXTENTS 1
            MAXEXTENTS 2147483645
           )
/

--------------------------------------------------------------------------------------------------------------------
-- CRIAÇÃO DO ÍNDICE: IFRMAXIMO.WORKORDER_NDX1
--------------------------------------------------------------------------------------------------------------------
CREATE UNIQUE INDEX IFRMAXIMO.WORKORDER_NDX1 ON IFRMAXIMO.WORKORDER (
SITEID ASC,
WONUM ASC)
PCTFREE    10
INITRANS   2
MAXTRANS   255
TABLESPACE TSI_MAXIMO
STORAGE   (
            INITIAL    65536
            MINEXTENTS 1
            MAXEXTENTS 2147483645
           )
/

--------------------------------------------------------------------------------------------------------------------
-- CRIAÇÃO DO ÍNDICE: IFRMAXIMO.WORKORDER_NDX10
--------------------------------------------------------------------------------------------------------------------
CREATE  INDEX IFRMAXIMO.WORKORDER_NDX10 ON IFRMAXIMO.WORKORDER (
PARENT ASC,
SITEID ASC)
PCTFREE    10
INITRANS   2
MAXTRANS   255
TABLESPACE TSI_MAXIMO
STORAGE   (
            INITIAL    65536
            MINEXTENTS 1
            MAXEXTENTS 2147483645
           )
/

--------------------------------------------------------------------------------------------------------------------
-- CRIAÇÃO DO ÍNDICE: IFRMAXIMO.WORKORDER_NDX11
--------------------------------------------------------------------------------------------------------------------
CREATE  INDEX IFRMAXIMO.WORKORDER_NDX11 ON IFRMAXIMO.WORKORDER (
WOPM7 ASC,
SITEID ASC)
PCTFREE    10
INITRANS   2
MAXTRANS   255
TABLESPACE TSI_MAXIMO
STORAGE   (
            INITIAL    65536
            MINEXTENTS 1
            MAXEXTENTS 2147483645
           )
/

--------------------------------------------------------------------------------------------------------------------
-- CRIAÇÃO DO ÍNDICE: IFRMAXIMO.WORKORDER_NDX12
--------------------------------------------------------------------------------------------------------------------
CREATE UNIQUE INDEX IFRMAXIMO.WORKORDER_NDX12 ON IFRMAXIMO.WORKORDER (
WONUM ASC,
ISTASK ASC,
HISTORYFLAG ASC)
PCTFREE    10
INITRANS   2
MAXTRANS   255
TABLESPACE TSI_MAXIMO
STORAGE   (
            INITIAL    65536
            MINEXTENTS 1
            MAXEXTENTS 2147483645
           )
/

--------------------------------------------------------------------------------------------------------------------
-- CRIAÇÃO DO ÍNDICE: IFRMAXIMO.WORKORDER_NDX13
--------------------------------------------------------------------------------------------------------------------
CREATE  INDEX IFRMAXIMO.WORKORDER_NDX13 ON IFRMAXIMO.WORKORDER (
SITEID ASC,
ISTASK ASC,
HISTORYFLAG ASC)
PCTFREE    10
INITRANS   2
MAXTRANS   255
TABLESPACE TSI_MAXIMO
STORAGE   (
            INITIAL    65536
            MINEXTENTS 1
            MAXEXTENTS 2147483645
           )
/

--------------------------------------------------------------------------------------------------------------------
-- CRIAÇÃO DO ÍNDICE: IFRMAXIMO.WORKORDER_NDX14
--------------------------------------------------------------------------------------------------------------------
CREATE  INDEX IFRMAXIMO.WORKORDER_NDX14 ON IFRMAXIMO.WORKORDER (
HISTORYFLAG ASC,
ISTASK ASC,
WOPM7 ASC,
SITEID ASC)
PCTFREE    10
INITRANS   2
MAXTRANS   255
TABLESPACE TSI_MAXIMO
STORAGE   (
            INITIAL    65536
            MINEXTENTS 1
            MAXEXTENTS 2147483645
           )
/

--------------------------------------------------------------------------------------------------------------------
-- CRIAÇÃO DO ÍNDICE: IFRMAXIMO.WORKORDER_NDX15
--------------------------------------------------------------------------------------------------------------------
CREATE  INDEX IFRMAXIMO.WORKORDER_NDX15 ON IFRMAXIMO.WORKORDER (
HISTORYFLAG ASC,
ISTASK ASC,
WOPM6 ASC,
SITEID ASC)
PCTFREE    10
INITRANS   2
MAXTRANS   255
TABLESPACE TSI_MAXIMO
STORAGE   (
            INITIAL    65536
            MINEXTENTS 1
            MAXEXTENTS 2147483645
           )
/

--------------------------------------------------------------------------------------------------------------------
-- CRIAÇÃO DO ÍNDICE: IFRMAXIMO.WORKORDER_NDX16
--------------------------------------------------------------------------------------------------------------------
CREATE  INDEX IFRMAXIMO.WORKORDER_NDX16 ON IFRMAXIMO.WORKORDER (
SITEID ASC,
CREWID ASC)
PCTFREE    10
INITRANS   2
MAXTRANS   255
TABLESPACE TSI_MAXIMO
STORAGE   (
            INITIAL    65536
            MINEXTENTS 1
            MAXEXTENTS 2147483645
           )
/

--------------------------------------------------------------------------------------------------------------------
-- CRIAÇÃO DO ÍNDICE: IFRMAXIMO.WORKORDER_NDX17
--------------------------------------------------------------------------------------------------------------------
CREATE  INDEX IFRMAXIMO.WORKORDER_NDX17 ON IFRMAXIMO.WORKORDER (
LDKEY ASC)
PCTFREE    10
INITRANS   2
MAXTRANS   255
TABLESPACE TSI_MAXIMO
STORAGE   (
            INITIAL    65536
            MINEXTENTS 1
            MAXEXTENTS 2147483645
           )
/

--------------------------------------------------------------------------------------------------------------------
-- CRIAÇÃO DO ÍNDICE: IFRMAXIMO.WORKORDER_NDX18
--------------------------------------------------------------------------------------------------------------------
CREATE  INDEX IFRMAXIMO.WORKORDER_NDX18 ON IFRMAXIMO.WORKORDER (
SITEID ASC,
CREWID ASC,
STATUS ASC)
PCTFREE    10
INITRANS   2
MAXTRANS   255
TABLESPACE TSI_MAXIMO
STORAGE   (
            INITIAL    65536
            MINEXTENTS 1
            MAXEXTENTS 2147483645
           )
/

--------------------------------------------------------------------------------------------------------------------
-- CRIAÇÃO DO ÍNDICE: IFRMAXIMO.WORKORDER_NDX19
--------------------------------------------------------------------------------------------------------------------
CREATE  INDEX IFRMAXIMO.WORKORDER_NDX19 ON IFRMAXIMO.WORKORDER (
WOPM6 ASC,
SITEID ASC)
PCTFREE    10
INITRANS   2
MAXTRANS   255
TABLESPACE TSI_MAXIMO
STORAGE   (
            INITIAL    65536
            MINEXTENTS 1
            MAXEXTENTS 2147483645
           )
/

--------------------------------------------------------------------------------------------------------------------
-- CRIAÇÃO DO ÍNDICE: IFRMAXIMO.WORKORDER_NDX2
--------------------------------------------------------------------------------------------------------------------
CREATE  INDEX IFRMAXIMO.WORKORDER_NDX2 ON IFRMAXIMO.WORKORDER (
SITEID ASC,
STATUS ASC)
PCTFREE    10
INITRANS   2
MAXTRANS   255
TABLESPACE TSI_MAXIMO
STORAGE   (
            INITIAL    65536
            MINEXTENTS 1
            MAXEXTENTS 2147483645
           )
/

--------------------------------------------------------------------------------------------------------------------
-- CRIAÇÃO DO ÍNDICE: IFRMAXIMO.WORKORDER_NDX3
--------------------------------------------------------------------------------------------------------------------
CREATE  INDEX IFRMAXIMO.WORKORDER_NDX3 ON IFRMAXIMO.WORKORDER (
SITEID ASC,
HISTORYFLAG ASC)
PCTFREE    10
INITRANS   2
MAXTRANS   255
TABLESPACE TSI_MAXIMO
STORAGE   (
            INITIAL    65536
            MINEXTENTS 1
            MAXEXTENTS 2147483645
           )
/

--------------------------------------------------------------------------------------------------------------------
-- CRIAÇÃO DO ÍNDICE: IFRMAXIMO.WORKORDER_NDX4
--------------------------------------------------------------------------------------------------------------------
CREATE  INDEX IFRMAXIMO.WORKORDER_NDX4 ON IFRMAXIMO.WORKORDER (
SITEID ASC,
INTERID ASC)
PCTFREE    10
INITRANS   2
MAXTRANS   255
TABLESPACE TSI_MAXIMO
STORAGE   (
            INITIAL    65536
            MINEXTENTS 1
            MAXEXTENTS 2147483645
           )
/

--------------------------------------------------------------------------------------------------------------------
-- CRIAÇÃO DO ÍNDICE: IFRMAXIMO.WORKORDER_NDX5
--------------------------------------------------------------------------------------------------------------------
CREATE  INDEX IFRMAXIMO.WORKORDER_NDX5 ON IFRMAXIMO.WORKORDER (
SITEID ASC,
WFID ASC)
PCTFREE    10
INITRANS   2
MAXTRANS   255
TABLESPACE TSI_MAXIMO
STORAGE   (
            INITIAL    65536
            MINEXTENTS 1
            MAXEXTENTS 2147483645
           )
/

--------------------------------------------------------------------------------------------------------------------
-- CRIAÇÃO DO ÍNDICE: IFRMAXIMO.WORKORDER_NDX6
--------------------------------------------------------------------------------------------------------------------
CREATE  INDEX IFRMAXIMO.WORKORDER_NDX6 ON IFRMAXIMO.WORKORDER (
SITEID ASC,
RESPONDBY ASC)
PCTFREE    10
INITRANS   2
MAXTRANS   255
TABLESPACE TSI_MAXIMO
STORAGE   (
            INITIAL    65536
            MINEXTENTS 1
            MAXEXTENTS 2147483645
           )
/

--------------------------------------------------------------------------------------------------------------------
-- CRIAÇÃO DO ÍNDICE: IFRMAXIMO.WORKORDER_NDX7
--------------------------------------------------------------------------------------------------------------------
CREATE  INDEX IFRMAXIMO.WORKORDER_NDX7 ON IFRMAXIMO.WORKORDER (
SITEID ASC,
EQNUM ASC,
PROBLEMCODE ASC,
STATUS ASC)
PCTFREE    10
INITRANS   2
MAXTRANS   255
TABLESPACE TSI_MAXIMO
STORAGE   (
            INITIAL    65536
            MINEXTENTS 1
            MAXEXTENTS 2147483645
           )
/

--------------------------------------------------------------------------------------------------------------------
-- CRIAÇÃO DO ÍNDICE: IFRMAXIMO.WORKORDER_NDX8
--------------------------------------------------------------------------------------------------------------------
CREATE  INDEX IFRMAXIMO.WORKORDER_NDX8 ON IFRMAXIMO.WORKORDER (
SITEID ASC,
JPNUM ASC)
PCTFREE    10
INITRANS   2
MAXTRANS   255
TABLESPACE TSI_MAXIMO
STORAGE   (
            INITIAL    65536
            MINEXTENTS 1
            MAXEXTENTS 2147483645
           )
/

--------------------------------------------------------------------------------------------------------------------
-- CRIAÇÃO DO ÍNDICE: IFRMAXIMO.WORKORDER_NDX9
--------------------------------------------------------------------------------------------------------------------
CREATE  INDEX IFRMAXIMO.WORKORDER_NDX9 ON IFRMAXIMO.WORKORDER (
SITEID ASC,
LOCATION ASC,
PROBLEMCODE ASC,
STATUS ASC)
PCTFREE    10
INITRANS   2
MAXTRANS   255
TABLESPACE TSI_MAXIMO
STORAGE   (
            INITIAL    65536
            MINEXTENTS 1
            MAXEXTENTS 2147483645
           )
/

--------------------------------------------------------------------------------------------------------------------
-- CRIAÇÃO DO ÍNDICE: IFRMAXIMO.WORKORDER_TEMP
--------------------------------------------------------------------------------------------------------------------
CREATE  INDEX IFRMAXIMO.WORKORDER_TEMP ON IFRMAXIMO.WORKORDER_BKP (
SITEID ASC,
STATUS ASC,
STATUSDATE ASC)
PCTFREE    10
INITRANS   2
MAXTRANS   255
TABLESPACE TSI_MAXIMO
STORAGE   (
            INITIAL    65536
            MINEXTENTS 1
            MAXEXTENTS 2147483645
           )
/

--------------------------------------------------------------------------------------------------------------------
-- CRIAÇÃO DO ÍNDICE: IFRMAXIMO.WORKPERIOD_NDX1
--------------------------------------------------------------------------------------------------------------------
CREATE UNIQUE INDEX IFRMAXIMO.WORKPERIOD_NDX1 ON IFRMAXIMO.WORKPERIOD (
SITEID ASC,
CALNUM ASC,
WORKDATE ASC,
SHIFTNUM ASC)
PCTFREE    10
INITRANS   2
MAXTRANS   255
TABLESPACE TSI_MAXIMO
STORAGE   (
            INITIAL    65536
            MINEXTENTS 1
            MAXEXTENTS 2147483645
           )
/

--------------------------------------------------------------------------------------------------------------------
-- CRIAÇÃO DO ÍNDICE: IFRMAXIMO.WORKPERIOD_NDX2
--------------------------------------------------------------------------------------------------------------------
CREATE  INDEX IFRMAXIMO.WORKPERIOD_NDX2 ON IFRMAXIMO.WORKPERIOD (
SITEID ASC,
WORKDATE ASC)
PCTFREE    10
INITRANS   2
MAXTRANS   255
TABLESPACE TSI_MAXIMO
STORAGE   (
            INITIAL    65536
            MINEXTENTS 1
            MAXEXTENTS 2147483645
           )
/

--------------------------------------------------------------------------------------------------------------------
-- CRIAÇÃO DO ÍNDICE: IFRMAXIMO.WORKPERIOD_NDX3
--------------------------------------------------------------------------------------------------------------------
CREATE  INDEX IFRMAXIMO.WORKPERIOD_NDX3 ON IFRMAXIMO.WORKPERIOD (
SITEID ASC,
SHIFTNUM ASC,
WORKDATE ASC)
PCTFREE    10
INITRANS   2
MAXTRANS   255
TABLESPACE TSI_MAXIMO
STORAGE   (
            INITIAL    65536
            MINEXTENTS 1
            MAXEXTENTS 2147483645
           )
/

--------------------------------------------------------------------------------------------------------------------
-- CRIAÇÃO DO ÍNDICE: IFRMAXIMO.WORKPRIORITY_NDX1
--------------------------------------------------------------------------------------------------------------------
CREATE UNIQUE INDEX IFRMAXIMO.WORKPRIORITY_NDX1 ON IFRMAXIMO.WORKPRIORITY (
SITEID ASC,
PRIORITY ASC)
PCTFREE    10
INITRANS   2
MAXTRANS   255
TABLESPACE TSI_MAXIMO
STORAGE   (
            INITIAL    65536
            MINEXTENTS 1
            MAXEXTENTS 2147483645
           )
/

--------------------------------------------------------------------------------------------------------------------
-- CRIAÇÃO DO ÍNDICE: IFRMAXIMO.WORKTYPE_NDX1
--------------------------------------------------------------------------------------------------------------------
CREATE UNIQUE INDEX IFRMAXIMO.WORKTYPE_NDX1 ON IFRMAXIMO.WORKTYPE (
ORGID ASC,
WORKTYPE ASC)
PCTFREE    10
INITRANS   2
MAXTRANS   255
TABLESPACE TSI_MAXIMO
STORAGE   (
            INITIAL    65536
            MINEXTENTS 1
            MAXEXTENTS 2147483645
           )
/

--------------------------------------------------------------------------------------------------------------------
-- CRIAÇÃO DO ÍNDICE: IFRMAXIMO.WOSAFETYLINK_NDX1
--------------------------------------------------------------------------------------------------------------------
CREATE UNIQUE INDEX IFRMAXIMO.WOSAFETYLINK_NDX1 ON IFRMAXIMO.WOSAFETYLINK (
SITEID ASC,
WOSAFETYLINKID ASC)
PCTFREE    10
INITRANS   2
MAXTRANS   255
TABLESPACE TSI_MAXIMO
STORAGE   (
            INITIAL    65536
            MINEXTENTS 1
            MAXEXTENTS 2147483645
           )
/

--------------------------------------------------------------------------------------------------------------------
-- CRIAÇÃO DO ÍNDICE: IFRMAXIMO.WOSAFETYLINK_NDX2
--------------------------------------------------------------------------------------------------------------------
CREATE  INDEX IFRMAXIMO.WOSAFETYLINK_NDX2 ON IFRMAXIMO.WOSAFETYLINK (
SITEID ASC,
WONUM ASC,
APPLYSEQ ASC)
PCTFREE    10
INITRANS   2
MAXTRANS   255
TABLESPACE TSI_MAXIMO
STORAGE   (
            INITIAL    65536
            MINEXTENTS 1
            MAXEXTENTS 2147483645
           )
/

--------------------------------------------------------------------------------------------------------------------
-- CRIAÇÃO DO ÍNDICE: IFRMAXIMO.WOSAFETYPLAN_NDX1
--------------------------------------------------------------------------------------------------------------------
CREATE UNIQUE INDEX IFRMAXIMO.WOSAFETYPLAN_NDX1 ON IFRMAXIMO.WOSAFETYPLAN (
SITEID ASC,
WONUM ASC)
PCTFREE    10
INITRANS   2
MAXTRANS   255
TABLESPACE TSI_MAXIMO
STORAGE   (
            INITIAL    65536
            MINEXTENTS 1
            MAXEXTENTS 2147483645
           )
/

--------------------------------------------------------------------------------------------------------------------
-- CRIAÇÃO DO ÍNDICE: IFRMAXIMO.WOSCHEDACT_NDX1
--------------------------------------------------------------------------------------------------------------------
CREATE UNIQUE INDEX IFRMAXIMO.WOSCHEDACT_NDX1 ON IFRMAXIMO.WOSCHEDACTIVITY (
SITEID ASC,
PROJECTNAME ASC,
WOSCHEDACTIVITYID ASC)
PCTFREE    10
INITRANS   2
MAXTRANS   255
TABLESPACE TSI_MAXIMO
STORAGE   (
            INITIAL    65536
            MINEXTENTS 1
            MAXEXTENTS 2147483645
           )
/

--------------------------------------------------------------------------------------------------------------------
-- CRIAÇÃO DO ÍNDICE: IFRMAXIMO.WOSTATUS_NDX1
--------------------------------------------------------------------------------------------------------------------
CREATE  INDEX IFRMAXIMO.WOSTATUS_NDX1 ON IFRMAXIMO.WOSTATUS (
SITEID ASC,
CHANGEDATE ASC,
WONUM ASC)
PCTFREE    10
INITRANS   2
MAXTRANS   255
TABLESPACE TSI_MAXIMO
STORAGE   (
            INITIAL    65536
            MINEXTENTS 1
            MAXEXTENTS 2147483645
           )
/

--------------------------------------------------------------------------------------------------------------------
-- CRIAÇÃO DO ÍNDICE: IFRMAXIMO.WOSTATUS_NDX2
--------------------------------------------------------------------------------------------------------------------
CREATE  INDEX IFRMAXIMO.WOSTATUS_NDX2 ON IFRMAXIMO.WOSTATUS (
SITEID ASC,
WONUM ASC)
PCTFREE    10
INITRANS   2
MAXTRANS   255
TABLESPACE TSI_MAXIMO
STORAGE   (
            INITIAL    65536
            MINEXTENTS 1
            MAXEXTENTS 2147483645
           )
/

--------------------------------------------------------------------------------------------------------------------
-- CRIAÇÃO DO ÍNDICE: IFRMAXIMO.WOSTATUS_NDX3
--------------------------------------------------------------------------------------------------------------------
CREATE  INDEX IFRMAXIMO.WOSTATUS_NDX3 ON IFRMAXIMO.WOSTATUS (
SITEID ASC,
STATUS ASC)
PCTFREE    10
INITRANS   2
MAXTRANS   255
TABLESPACE TSI_MAXIMO
STORAGE   (
            INITIAL    65536
            MINEXTENTS 1
            MAXEXTENTS 2147483645
           )
/

--------------------------------------------------------------------------------------------------------------------
-- CRIAÇÃO DO ÍNDICE: IFRMAXIMO.WOTAGLOCK_NDX1
--------------------------------------------------------------------------------------------------------------------
CREATE UNIQUE INDEX IFRMAXIMO.WOTAGLOCK_NDX1 ON IFRMAXIMO.WOTAGLOCK (
SITEID ASC,
TAGLOCKID ASC)
PCTFREE    10
INITRANS   2
MAXTRANS   255
TABLESPACE TSI_MAXIMO
STORAGE   (
            INITIAL    65536
            MINEXTENTS 1
            MAXEXTENTS 2147483645
           )
/

--------------------------------------------------------------------------------------------------------------------
-- CRIAÇÃO DO ÍNDICE: IFRMAXIMO.WOTAGLOCK_NDX2
--------------------------------------------------------------------------------------------------------------------
CREATE  INDEX IFRMAXIMO.WOTAGLOCK_NDX2 ON IFRMAXIMO.WOTAGLOCK (
SITEID ASC,
WONUM ASC,
TAGOUTID ASC,
LOCKOUTID ASC,
WOSAFETYDATASOURCE ASC)
PCTFREE    10
INITRANS   2
MAXTRANS   255
TABLESPACE TSI_MAXIMO
STORAGE   (
            INITIAL    65536
            MINEXTENTS 1
            MAXEXTENTS 2147483645
           )
/

--------------------------------------------------------------------------------------------------------------------
-- CRIAÇÃO DO ÍNDICE: IFRMAXIMO.WOTAGLOCK_NDX3
--------------------------------------------------------------------------------------------------------------------
CREATE  INDEX IFRMAXIMO.WOTAGLOCK_NDX3 ON IFRMAXIMO.WOTAGLOCK (
SITEID ASC,
WONUM ASC,
TAGOUTID ASC,
APPLYSEQ ASC)
PCTFREE    10
INITRANS   2
MAXTRANS   255
TABLESPACE TSI_MAXIMO
STORAGE   (
            INITIAL    65536
            MINEXTENTS 1
            MAXEXTENTS 2147483645
           )
/

--------------------------------------------------------------------------------------------------------------------
-- CRIAÇÃO DO ÍNDICE: IFRMAXIMO.WOTAGOUT_NDX1
--------------------------------------------------------------------------------------------------------------------
CREATE UNIQUE INDEX IFRMAXIMO.WOTAGOUT_NDX1 ON IFRMAXIMO.WOTAGOUT (
SITEID ASC,
WONUM ASC,
TAGOUTID ASC,
WOSAFETYDATASOURCE ASC)
PCTFREE    10
INITRANS   2
MAXTRANS   255
TABLESPACE TSI_MAXIMO
STORAGE   (
            INITIAL    65536
            MINEXTENTS 1
            MAXEXTENTS 2147483645
           )
/

--------------------------------------------------------------------------------------------------------------------
-- CRIAÇÃO DO ÍNDICE: IFRMAXIMO.WPEDITSETTING_NDX1
--------------------------------------------------------------------------------------------------------------------
CREATE UNIQUE INDEX IFRMAXIMO.WPEDITSETTING_NDX1 ON IFRMAXIMO.WPEDITSETTING (
ORGID ASC,
STATUS ASC)
PCTFREE    10
INITRANS   2
MAXTRANS   255
TABLESPACE TSI_MAXIMO
STORAGE   (
            INITIAL    65536
            MINEXTENTS 1
            MAXEXTENTS 2147483645
           )
/

--------------------------------------------------------------------------------------------------------------------
-- CRIAÇÃO DO ÍNDICE: IFRMAXIMO.WPLABOR_NDX1
--------------------------------------------------------------------------------------------------------------------
CREATE UNIQUE INDEX IFRMAXIMO.WPLABOR_NDX1 ON IFRMAXIMO.WPLABOR (
SITEID ASC,
WONUM ASC,
WPLABORID ASC)
PCTFREE    10
INITRANS   2
MAXTRANS   255
TABLESPACE TSI_MAXIMO
STORAGE   (
            INITIAL    65536
            MINEXTENTS 1
            MAXEXTENTS 2147483645
           )
/

--------------------------------------------------------------------------------------------------------------------
-- CRIAÇÃO DO ÍNDICE: IFRMAXIMO.WPLABOR_NDX2
--------------------------------------------------------------------------------------------------------------------
CREATE  INDEX IFRMAXIMO.WPLABOR_NDX2 ON IFRMAXIMO.WPLABOR (
SITEID ASC,
WONUM ASC,
LABORCODE ASC)
PCTFREE    10
INITRANS   2
MAXTRANS   255
TABLESPACE TSI_MAXIMO
STORAGE   (
            INITIAL    65536
            MINEXTENTS 1
            MAXEXTENTS 2147483645
           )
/

--------------------------------------------------------------------------------------------------------------------
-- CRIAÇÃO DO ÍNDICE: IFRMAXIMO.WPMATERIAL_NDX1
--------------------------------------------------------------------------------------------------------------------
CREATE  INDEX IFRMAXIMO.WPMATERIAL_NDX1 ON IFRMAXIMO.WPMATERIAL (
SITEID ASC,
WONUM ASC,
ITEMNUM ASC)
PCTFREE    10
INITRANS   2
MAXTRANS   255
TABLESPACE TSI_MAXIMO
STORAGE   (
            INITIAL    65536
            MINEXTENTS 1
            MAXEXTENTS 2147483645
           )
/

--------------------------------------------------------------------------------------------------------------------
-- CRIAÇÃO DO ÍNDICE: IFRMAXIMO.WPTOOL_NDX1
--------------------------------------------------------------------------------------------------------------------
CREATE  INDEX IFRMAXIMO.WPTOOL_NDX1 ON IFRMAXIMO.WPTOOL (
SITEID ASC,
WONUM ASC,
TOOLNUM ASC)
PCTFREE    10
INITRANS   2
MAXTRANS   255
TABLESPACE TSI_MAXIMO
STORAGE   (
            INITIAL    65536
            MINEXTENTS 1
            MAXEXTENTS 2147483645
           )
/

----------------- TOTAL DE REGISTROS ----------------- 
Quantidade de Índices: 468
------------------------------------------------------ 

-- GERAÇÃO: 4/10/2006 do Banco: PRODSEDE2
--------------------------------------------------------------------------------------------------------------------
-- CRIAÇÃO DO ÍNDICE: IFRSEG.CAD_ACESSO_OBJETO_PK
--------------------------------------------------------------------------------------------------------------------
CREATE UNIQUE INDEX IFRSEG.CAD_ACESSO_OBJETO_PK ON IFRSEG.CAD_ACESSO_OBJETO (
NUM_SEQ_OBJETO ASC,
NUM_COD_GRUPO_ACESSO_OBJ ASC)
PCTFREE    10
INITRANS   2
MAXTRANS   255
TABLESPACE TSI_MAXIMO
STORAGE   (
            INITIAL    65536
            MINEXTENTS 1
            MAXEXTENTS 2147483645
           )
/

--------------------------------------------------------------------------------------------------------------------
-- CRIAÇÃO DO ÍNDICE: IFRSEG.CAD_ACESSO_PK
--------------------------------------------------------------------------------------------------------------------
CREATE UNIQUE INDEX IFRSEG.CAD_ACESSO_PK ON IFRSEG.CAD_ACESSO (
COD_GRUPO_ACESSO ASC,
COD_USUARIO_ACESSO ASC,
COD_SISTEMA_ACESSO ASC)
PCTFREE    10
INITRANS   2
MAXTRANS   255
TABLESPACE TSI_MAXIMO
STORAGE   (
            INITIAL    204800
            MINEXTENTS 1
            MAXEXTENTS 2147483645
           )
/

--------------------------------------------------------------------------------------------------------------------
-- CRIAÇÃO DO ÍNDICE: IFRSEG.CAD_CAMPO_PK
--------------------------------------------------------------------------------------------------------------------
CREATE UNIQUE INDEX IFRSEG.CAD_CAMPO_PK ON IFRSEG.CAD_CAMPO (
NUM_SEQ_CAMPO ASC)
PCTFREE    10
INITRANS   2
MAXTRANS   255
TABLESPACE TSI_MAXIMO
STORAGE   (
            INITIAL    204800
            MINEXTENTS 1
            MAXEXTENTS 2147483645
           )
/

--------------------------------------------------------------------------------------------------------------------
-- CRIAÇÃO DO ÍNDICE: IFRSEG.CAD_DIRETORIA_PK
--------------------------------------------------------------------------------------------------------------------
CREATE UNIQUE INDEX IFRSEG.CAD_DIRETORIA_PK ON IFRSEG.CAD_DIRETORIA (
NU_SEQ_DIRETORIA ASC)
PCTFREE    10
INITRANS   2
MAXTRANS   255
TABLESPACE TSI_MAXIMO
STORAGE   (
            INITIAL    204800
            MINEXTENTS 1
            MAXEXTENTS 2147483645
           )
/

--------------------------------------------------------------------------------------------------------------------
-- CRIAÇÃO DO ÍNDICE: IFRSEG.CAD_DIRETORIA_01_IX
--------------------------------------------------------------------------------------------------------------------
CREATE  INDEX IFRSEG.CAD_DIRETORIA_01_IX ON IFRSEG.CAD_DIRETORIA (
DSC_DIRETORIA ASC)
PCTFREE    10
INITRANS   2
MAXTRANS   255
TABLESPACE TSI_MAXIMO
STORAGE   (
            INITIAL    204800
            MINEXTENTS 1
            MAXEXTENTS 2147483645
           )
/

--------------------------------------------------------------------------------------------------------------------
-- CRIAÇÃO DO ÍNDICE: IFRSEG.CAD_ESQUEMA_01_IX
--------------------------------------------------------------------------------------------------------------------
CREATE UNIQUE INDEX IFRSEG.CAD_ESQUEMA_01_IX ON IFRSEG.CAD_ESQUEMA (
NOM_ESQUEMA ASC)
PCTFREE    10
INITRANS   2
MAXTRANS   255
TABLESPACE TSI_MAXIMO
STORAGE   (
            INITIAL    204800
            MINEXTENTS 1
            MAXEXTENTS 2147483645
           )
/

--------------------------------------------------------------------------------------------------------------------
-- CRIAÇÃO DO ÍNDICE: IFRSEG.CAD_ESQUEMA_01_PK
--------------------------------------------------------------------------------------------------------------------
CREATE UNIQUE INDEX IFRSEG.CAD_ESQUEMA_01_PK ON IFRSEG.CAD_ESQUEMA (
NUM_SEQ_ESQUEMA ASC)
PCTFREE    10
INITRANS   2
MAXTRANS   255
TABLESPACE TSI_MAXIMO
STORAGE   (
            INITIAL    204800
            MINEXTENTS 1
            MAXEXTENTS 2147483645
           )
/

--------------------------------------------------------------------------------------------------------------------
-- CRIAÇÃO DO ÍNDICE: IFRSEG.CAD_FORMULARIO_PK
--------------------------------------------------------------------------------------------------------------------
CREATE UNIQUE INDEX IFRSEG.CAD_FORMULARIO_PK ON IFRSEG.CAD_FORMULARIO (
NUM_SEQ_FORMULARIO ASC)
PCTFREE    10
INITRANS   2
MAXTRANS   255
TABLESPACE TSI_MAXIMO
STORAGE   (
            INITIAL    204800
            MINEXTENTS 1
            MAXEXTENTS 2147483645
           )
/

--------------------------------------------------------------------------------------------------------------------
-- CRIAÇÃO DO ÍNDICE: IFRSEG.CAD_FORMULARIO_02_IX
--------------------------------------------------------------------------------------------------------------------
CREATE UNIQUE INDEX IFRSEG.CAD_FORMULARIO_02_IX ON IFRSEG.CAD_FORMULARIO (
NOM_FORMULARIO_FRM ASC)
PCTFREE    10
INITRANS   2
MAXTRANS   255
TABLESPACE TSI_MAXIMO
STORAGE   (
            INITIAL    204800
            MINEXTENTS 1
            MAXEXTENTS 2147483645
           )
/

--------------------------------------------------------------------------------------------------------------------
-- CRIAÇÃO DO ÍNDICE: IFRSEG.CAD_GESTORES_USUARIOS_PK
--------------------------------------------------------------------------------------------------------------------
CREATE UNIQUE INDEX IFRSEG.CAD_GESTORES_USUARIOS_PK ON IFRSEG.CAD_GESTORES_USUARIOS (
NUM_SEQ_GESTOR_USUARIO ASC)
PCTFREE    10
INITRANS   2
MAXTRANS   255
TABLESPACE TSI_MAXIMO
STORAGE   (
            INITIAL    204800
            MINEXTENTS 1
            MAXEXTENTS 2147483645
           )
/

--------------------------------------------------------------------------------------------------------------------
-- CRIAÇÃO DO ÍNDICE: IFRSEG.CAD_GESTOR_USR_DEP_PK
--------------------------------------------------------------------------------------------------------------------
CREATE UNIQUE INDEX IFRSEG.CAD_GESTOR_USR_DEP_PK ON IFRSEG.CAD_GESTOR_USR_DEPENDENCIA (
NUM_SEQ_GEST_USR_DEPENDENCIA ASC,
COD_DEPEND_USR_DEPENDENCIA ASC)
PCTFREE    10
INITRANS   2
MAXTRANS   255
TABLESPACE TSI_MAXIMO
STORAGE   (
            INITIAL    204800
            MINEXTENTS 1
            MAXEXTENTS 2147483645
           )
/

--------------------------------------------------------------------------------------------------------------------
-- CRIAÇÃO DO ÍNDICE: IFRSEG.CAD_GRUPO_MENU_PK
--------------------------------------------------------------------------------------------------------------------
CREATE UNIQUE INDEX IFRSEG.CAD_GRUPO_MENU_PK ON IFRSEG.CAD_GRUPO_MENU (
COD_GRUPO_GRUPO_MENU ASC,
COD_SISTEMA_GRUPO_MENU ASC,
NUM_FUNCAO_GRUPO_MENU ASC)
PCTFREE    10
INITRANS   2
MAXTRANS   255
TABLESPACE TSI_MAXIMO
STORAGE   (
            INITIAL    204800
            MINEXTENTS 1
            MAXEXTENTS 2147483645
           )
/

--------------------------------------------------------------------------------------------------------------------
-- CRIAÇÃO DO ÍNDICE: IFRSEG.CAD_GRUPO_PK
--------------------------------------------------------------------------------------------------------------------
CREATE UNIQUE INDEX IFRSEG.CAD_GRUPO_PK ON IFRSEG.CAD_GRUPO (
COD_GRUPO ASC,
COD_SISTEMA_GRUPO ASC)
PCTFREE    10
INITRANS   2
MAXTRANS   255
TABLESPACE TSI_MAXIMO
STORAGE   (
            INITIAL    204800
            MINEXTENTS 1
            MAXEXTENTS 2147483645
           )
/

--------------------------------------------------------------------------------------------------------------------
-- CRIAÇÃO DO ÍNDICE: IFRSEG.CAD_MENU_SISTEMA_PK
--------------------------------------------------------------------------------------------------------------------
CREATE UNIQUE INDEX IFRSEG.CAD_MENU_SISTEMA_PK ON IFRSEG.CAD_MENU_SISTEMA (
NUM_FUNCAO_MENU ASC)
PCTFREE    10
INITRANS   2
MAXTRANS   255
TABLESPACE TSI_MAXIMO
STORAGE   (
            INITIAL    204800
            MINEXTENTS 1
            MAXEXTENTS 2147483645
           )
/

--------------------------------------------------------------------------------------------------------------------
-- CRIAÇÃO DO ÍNDICE: IFRSEG.CAD_ROLE_02_IX
--------------------------------------------------------------------------------------------------------------------
CREATE  INDEX IFRSEG.CAD_ROLE_02_IX ON IFRSEG.CAD_ROLE (
NOM_ROLE ASC)
PCTFREE    10
INITRANS   2
MAXTRANS   255
TABLESPACE TSI_MAXIMO
STORAGE   (
            INITIAL    16384
            MINEXTENTS 1
            MAXEXTENTS 2147483645
           )
/

--------------------------------------------------------------------------------------------------------------------
-- CRIAÇÃO DO ÍNDICE: IFRSEG.CAD_SISTEMA_ESQUEMA_PK
--------------------------------------------------------------------------------------------------------------------
CREATE UNIQUE INDEX IFRSEG.CAD_SISTEMA_ESQUEMA_PK ON IFRSEG.CAD_SISTEMA_ESQUEMA (
COD_SISTEMA_ESQUEMA ASC,
NUM_SEQ_ESQUEMA_SIST ASC)
PCTFREE    10
INITRANS   2
MAXTRANS   255
TABLESPACE TSI_MAXIMO
STORAGE   (
            INITIAL    204800
            MINEXTENTS 1
            MAXEXTENTS 2147483645
           )
/

--------------------------------------------------------------------------------------------------------------------
-- CRIAÇÃO DO ÍNDICE: IFRSEG.CAD_SISTEMA_PK
--------------------------------------------------------------------------------------------------------------------
CREATE UNIQUE INDEX IFRSEG.CAD_SISTEMA_PK ON IFRSEG.CAD_SISTEMA (
COD_SISTEMA ASC)
PCTFREE    10
INITRANS   2
MAXTRANS   255
TABLESPACE TSI_MAXIMO
STORAGE   (
            INITIAL    204800
            MINEXTENTS 1
            MAXEXTENTS 2147483645
           )
/

--------------------------------------------------------------------------------------------------------------------
-- CRIAÇÃO DO ÍNDICE: IFRSEG.CAD_SOLICITACAO_USUARIO_PK
--------------------------------------------------------------------------------------------------------------------
CREATE UNIQUE INDEX IFRSEG.CAD_SOLICITACAO_USUARIO_PK ON IFRSEG.CAD_SOLICITACAO_USUARIO (
NUM_SEQ_SOLICITACAO ASC)
PCTFREE    10
INITRANS   2
MAXTRANS   255
TABLESPACE TSI_MAXIMO
STORAGE   (
            INITIAL    204800
            MINEXTENTS 1
            MAXEXTENTS 2147483645
           )
/

--------------------------------------------------------------------------------------------------------------------
-- CRIAÇÃO DO ÍNDICE: IFRSEG.CAD_SOLIC_SISTEMA_USUARIO_PK
--------------------------------------------------------------------------------------------------------------------
CREATE UNIQUE INDEX IFRSEG.CAD_SOLIC_SISTEMA_USUARIO_PK ON IFRSEG.CAD_SOLIC_SISTEMA_USUARIO (
NUM_SEQ_SOLIC_SIST_USR ASC,
COD_SISTEMA_SOLIC_SIST_USR ASC)
PCTFREE    10
INITRANS   2
MAXTRANS   255
TABLESPACE TSI_MAXIMO
STORAGE   (
            INITIAL    204800
            MINEXTENTS 1
            MAXEXTENTS 2147483645
           )
/

--------------------------------------------------------------------------------------------------------------------
-- CRIAÇÃO DO ÍNDICE: IFRSEG.CAD_TABELA_PK
--------------------------------------------------------------------------------------------------------------------
CREATE UNIQUE INDEX IFRSEG.CAD_TABELA_PK ON IFRSEG.CAD_TABELA (
NUM_SEQ_TABELA ASC)
PCTFREE    10
INITRANS   2
MAXTRANS   255
TABLESPACE TSI_MAXIMO
STORAGE   (
            INITIAL    204800
            MINEXTENTS 1
            MAXEXTENTS 2147483645
           )
/

--------------------------------------------------------------------------------------------------------------------
-- CRIAÇÃO DO ÍNDICE: IFRSEG.CAD_TABELA_02_IX
--------------------------------------------------------------------------------------------------------------------
CREATE UNIQUE INDEX IFRSEG.CAD_TABELA_02_IX ON IFRSEG.CAD_TABELA (
NOM_TABELA_TABELA ASC)
PCTFREE    10
INITRANS   2
MAXTRANS   255
TABLESPACE TSI_MAXIMO
STORAGE   (
            INITIAL    204800
            MINEXTENTS 1
            MAXEXTENTS 2147483645
           )
/

--------------------------------------------------------------------------------------------------------------------
-- CRIAÇÃO DO ÍNDICE: IFRSEG.CAD_USR_GESTOR_SISTEMA_PK
--------------------------------------------------------------------------------------------------------------------
CREATE UNIQUE INDEX IFRSEG.CAD_USR_GESTOR_SISTEMA_PK ON IFRSEG.CAD_USR_GESTOR_SISTEMA (
NUM_SEQ_GESTOR_SISTEMA ASC)
PCTFREE    10
INITRANS   2
MAXTRANS   255
TABLESPACE TSI_MAXIMO
STORAGE   (
            INITIAL    204800
            MINEXTENTS 1
            MAXEXTENTS 2147483645
           )
/

--------------------------------------------------------------------------------------------------------------------
-- CRIAÇÃO DO ÍNDICE: IFRSEG.CAD_USUARIO_PK
--------------------------------------------------------------------------------------------------------------------
CREATE UNIQUE INDEX IFRSEG.CAD_USUARIO_PK ON IFRSEG.CAD_USUARIO (
COD_USUARIO ASC)
PCTFREE    10
INITRANS   2
MAXTRANS   255
TABLESPACE TSI_MAXIMO
STORAGE   (
            INITIAL    204800
            MINEXTENTS 1
            MAXEXTENTS 2147483645
           )
/

--------------------------------------------------------------------------------------------------------------------
-- CRIAÇÃO DO ÍNDICE: IFRSEG.CAD_USUARIO_SISTEMA_PK
--------------------------------------------------------------------------------------------------------------------
CREATE UNIQUE INDEX IFRSEG.CAD_USUARIO_SISTEMA_PK ON IFRSEG.CAD_USUARIO_SISTEMA (
COD_USUARIO_USR_SISTEMA ASC,
COD_GRUPO_USR_SISTEMA ASC,
COD_SISTEMA_USR_SISTEMA ASC)
PCTFREE    10
INITRANS   2
MAXTRANS   255
TABLESPACE TSI_MAXIMO
STORAGE   (
            INITIAL    204800
            MINEXTENTS 1
            MAXEXTENTS 2147483645
           )
/

--------------------------------------------------------------------------------------------------------------------
-- CRIAÇÃO DO ÍNDICE: IFRSEG.CAD_USUARIO_03_IX
--------------------------------------------------------------------------------------------------------------------
CREATE UNIQUE INDEX IFRSEG.CAD_USUARIO_03_IX ON IFRSEG.CAD_USUARIO (
NOM_USERNAME ASC)
PCTFREE    10
INITRANS   2
MAXTRANS   255
TABLESPACE TSI_MAXIMO
STORAGE   (
            INITIAL    204800
            MINEXTENTS 1
            MAXEXTENTS 2147483645
           )
/

--------------------------------------------------------------------------------------------------------------------
-- CRIAÇÃO DO ÍNDICE: IFRSEG.MICROSOFT_PK_DTPROPERTIES
--------------------------------------------------------------------------------------------------------------------
CREATE UNIQUE INDEX IFRSEG.MICROSOFT_PK_DTPROPERTIES ON IFRSEG.MICROSOFTDTPROPERTIES (
ID ASC,
PROPERTY ASC)
PCTFREE    10
INITRANS   2
MAXTRANS   255
TABLESPACE TSI_MAXIMO
STORAGE   (
            INITIAL    65536
            MINEXTENTS 1
            MAXEXTENTS 2147483645
           )
/

--------------------------------------------------------------------------------------------------------------------
-- CRIAÇÃO DO ÍNDICE: IFRSEG.PK_CAD_ROLE
--------------------------------------------------------------------------------------------------------------------
CREATE UNIQUE INDEX IFRSEG.PK_CAD_ROLE ON IFRSEG.CAD_ROLE (
NUM_SEQ_ROLE ASC)
PCTFREE    10
INITRANS   2
MAXTRANS   255
TABLESPACE TSI_MAXIMO
STORAGE   (
            INITIAL    204800
            MINEXTENTS 1
            MAXEXTENTS 2147483645
           )
/

--------------------------------------------------------------------------------------------------------------------
-- CRIAÇÃO DO ÍNDICE: IFRSEG.PK_CAD_ROLE_SISTEMA
--------------------------------------------------------------------------------------------------------------------
CREATE UNIQUE INDEX IFRSEG.PK_CAD_ROLE_SISTEMA ON IFRSEG.CAD_ROLE_SISTEMA (
NUM_SEQ_ROLE ASC,
COD_SISTEMA ASC)
PCTFREE    10
INITRANS   2
MAXTRANS   255
TABLESPACE TSI_MAXIMO
STORAGE   (
            INITIAL    204800
            MINEXTENTS 1
            MAXEXTENTS 2147483645
           )
/

--------------------------------------------------------------------------------------------------------------------
-- CRIAÇÃO DO ÍNDICE: IFRSEG.PK_CAD_SISTEMA_GESTOR_USUARIO
--------------------------------------------------------------------------------------------------------------------
CREATE UNIQUE INDEX IFRSEG.PK_CAD_SISTEMA_GESTOR_USUARIO ON IFRSEG.CAD_SISTEMA_GESTOR_USUARIO (
NUM_SEQ_GEST_USR_SIST ASC,
COD_SIST_GEST_USR ASC)
PCTFREE    10
INITRANS   2
MAXTRANS   255
TABLESPACE TSI_MAXIMO
STORAGE   (
            INITIAL    65536
            MINEXTENTS 1
            MAXEXTENTS 2147483645
           )
/

--------------------------------------------------------------------------------------------------------------------
-- CRIAÇÃO DO ÍNDICE: IFRSEG.PK_CAD_SOLICITACAO_SISTEMA
--------------------------------------------------------------------------------------------------------------------
CREATE UNIQUE INDEX IFRSEG.PK_CAD_SOLICITACAO_SISTEMA ON IFRSEG.CAD_SOLICITACAO_SISTEMA (
NUM_SEQ_SOLIC_SISTEMA ASC)
PCTFREE    10
INITRANS   2
MAXTRANS   255
TABLESPACE TSI_MAXIMO
STORAGE   (
            INITIAL    204800
            MINEXTENTS 1
            MAXEXTENTS 2147483645
           )
/

--------------------------------------------------------------------------------------------------------------------
-- CRIAÇÃO DO ÍNDICE: IFRSEG.TAB_ACESSO_PK
--------------------------------------------------------------------------------------------------------------------
CREATE UNIQUE INDEX IFRSEG.TAB_ACESSO_PK ON IFRSEG.TAB_ACESSO (
NUM_SEQ_SESSIONID ASC)
PCTFREE    10
INITRANS   2
MAXTRANS   255
TABLESPACE TSI_MAXIMO
STORAGE   (
            INITIAL    65536
            MINEXTENTS 1
            MAXEXTENTS 2147483645
           )
/

--------------------------------------------------------------------------------------------------------------------
-- CRIAÇÃO DO ÍNDICE: IFRSEG.TAB_LOG_PK
--------------------------------------------------------------------------------------------------------------------
CREATE UNIQUE INDEX IFRSEG.TAB_LOG_PK ON IFRSEG.TAB_LOG (
NUM_SESSIONID_LOG ASC,
NUM_SEQ_TABELA_LOG ASC,
DAT_LOG ASC)
PCTFREE    10
INITRANS   2
MAXTRANS   255
TABLESPACE TSI_MAXIMO
STORAGE   (
            INITIAL    65536
            MINEXTENTS 1
            MAXEXTENTS 2147483645
           )
/

----------------- TOTAL DE REGISTROS ----------------- 
Quantidade de Índices: 32
------------------------------------------------------ 

-- GERAÇÃO: 4/10/2006 do Banco: PRODSEDE2
--------------------------------------------------------------------------------------------------------------------
-- CRIAÇÃO DO ÍNDICE: INTEGRACAO.CDAU_PK
--------------------------------------------------------------------------------------------------------------------
CREATE UNIQUE INDEX INTEGRACAO.CDAU_PK ON INTEGRACAO.CONF_DATAS_U (
PAYABLE_ENTITY_ID ASC,
CONTRACT_ID ASC,
CONTRACT_VERSAO ASC)
PCTFREE    10
INITRANS   2
MAXTRANS   255
TABLESPACE TSI_MAXIMO
STORAGE   (
            INITIAL    65536
            MINEXTENTS 1
            MAXEXTENTS 2147483645
           )
/

--------------------------------------------------------------------------------------------------------------------
-- CRIAÇÃO DO ÍNDICE: INTEGRACAO.CIADU_PK
--------------------------------------------------------------------------------------------------------------------
CREATE UNIQUE INDEX INTEGRACAO.CIADU_PK ON INTEGRACAO.CONF_ITEM_ACCT_DISTIN_U (
PAYABLE_ENTITY_ID ASC,
CONTRACT_ID ASC,
CONTRACT_VERSAO ASC,
SEQ_ITEM ASC,
TYPE_ACCOUNT_DIST ASC,
JRNL_LINE_NBR_CHAR ASC)
PCTFREE    10
INITRANS   2
MAXTRANS   255
TABLESPACE TSI_MAXIMO
STORAGE   (
            INITIAL    65536
            MINEXTENTS 1
            MAXEXTENTS 2147483645
           )
/

--------------------------------------------------------------------------------------------------------------------
-- CRIAÇÃO DO ÍNDICE: INTEGRACAO.CIR_U
--------------------------------------------------------------------------------------------------------------------
CREATE UNIQUE INDEX INTEGRACAO.CIR_U ON INTEGRACAO.CONF_ITEM_REQUISITADOS_U (
PAYABLE_ENTITY_ID ASC,
CONTRACT_ID ASC,
CONTRACT_VERSAO ASC,
SITE_ID ASC,
REQ_ID ASC,
REQ_LINE_NBR ASC)
PCTFREE    10
INITRANS   2
MAXTRANS   255
TABLESPACE TSI_MAXIMO
STORAGE   (
            INITIAL    65536
            MINEXTENTS 1
            MAXEXTENTS 2147483645
           )
/

--------------------------------------------------------------------------------------------------------------------
-- CRIAÇÃO DO ÍNDICE: INTEGRACAO.CONF_DATAS_U_01_IX
--------------------------------------------------------------------------------------------------------------------
CREATE  INDEX INTEGRACAO.CONF_DATAS_U_01_IX ON INTEGRACAO.CONF_DATAS_U (
PAYABLE_ENTITY_ID ASC,
CONTRACT_ID ASC)
PCTFREE    10
INITRANS   2
MAXTRANS   255
TABLESPACE TSI_MAXIMO
STORAGE   (
            INITIAL    65536
            MINEXTENTS 1
            MAXEXTENTS 2147483645
           )
/

--------------------------------------------------------------------------------------------------------------------
-- CRIAÇÃO DO ÍNDICE: INTEGRACAO.CONF_IDENTIFICACAO_U_01_IX
--------------------------------------------------------------------------------------------------------------------
CREATE  INDEX INTEGRACAO.CONF_IDENTIFICACAO_U_01_IX ON INTEGRACAO.CONF_IDENTIFICACAO_U (
PAYABLE_ENTITY_ID ASC,
CONTRACT_ID ASC)
PCTFREE    10
INITRANS   2
MAXTRANS   255
TABLESPACE TSI_MAXIMO
STORAGE   (
            INITIAL    65536
            MINEXTENTS 1
            MAXEXTENTS 2147483645
           )
/

--------------------------------------------------------------------------------------------------------------------
-- CRIAÇÃO DO ÍNDICE: INTEGRACAO.CONF_ITEM_CRONOGRAMA_U_01_IX
--------------------------------------------------------------------------------------------------------------------
CREATE  INDEX INTEGRACAO.CONF_ITEM_CRONOGRAMA_U_01_IX ON INTEGRACAO.CONF_ITEM_CRONOGRAMA_U (
PAYABLE_ENTITY_ID ASC,
CONTRACT_ID ASC)
PCTFREE    10
INITRANS   2
MAXTRANS   255
TABLESPACE TSI_MAXIMO
STORAGE   (
            INITIAL    65536
            MINEXTENTS 1
            MAXEXTENTS 2147483645
           )
/

--------------------------------------------------------------------------------------------------------------------
-- CRIAÇÃO DO ÍNDICE: INTEGRACAO.CONF_ITEM_IDENT_U_01_IX
--------------------------------------------------------------------------------------------------------------------
CREATE  INDEX INTEGRACAO.CONF_ITEM_IDENT_U_01_IX ON INTEGRACAO.CONF_ITEM_IDENT_U (
PAYABLE_ENTITY_ID ASC,
CONTRACT_ID ASC)
PCTFREE    10
INITRANS   2
MAXTRANS   255
TABLESPACE TSI_MAXIMO
STORAGE   (
            INITIAL    65536
            MINEXTENTS 1
            MAXEXTENTS 2147483645
           )
/

--------------------------------------------------------------------------------------------------------------------
-- CRIAÇÃO DO ÍNDICE: INTEGRACAO.CONF_ITEM_PROJETO_U_01_IX
--------------------------------------------------------------------------------------------------------------------
CREATE  INDEX INTEGRACAO.CONF_ITEM_PROJETO_U_01_IX ON INTEGRACAO.CONF_ITEM_PROJETO_U (
PAYABLE_ENTITY_ID ASC,
CONTRACT_ID ASC)
PCTFREE    10
INITRANS   2
MAXTRANS   255
TABLESPACE TSI_MAXIMO
STORAGE   (
            INITIAL    65536
            MINEXTENTS 1
            MAXEXTENTS 2147483645
           )
/

--------------------------------------------------------------------------------------------------------------------
-- CRIAÇÃO DO ÍNDICE: INTEGRACAO.CONF_ITEM_REQUISITADOS_U_01_IX
--------------------------------------------------------------------------------------------------------------------
CREATE  INDEX INTEGRACAO.CONF_ITEM_REQUISITADOS_U_01_IX ON INTEGRACAO.CONF_ITEM_REQUISITADOS_U (
PAYABLE_ENTITY_ID ASC,
CONTRACT_ID ASC)
PCTFREE    10
INITRANS   2
MAXTRANS   255
TABLESPACE TSI_MAXIMO
STORAGE   (
            INITIAL    65536
            MINEXTENTS 1
            MAXEXTENTS 2147483645
           )
/

--------------------------------------------------------------------------------------------------------------------
-- CRIAÇÃO DO ÍNDICE: INTEGRACAO.CONF_ITEM_RESUMO_U_01_IX
--------------------------------------------------------------------------------------------------------------------
CREATE  INDEX INTEGRACAO.CONF_ITEM_RESUMO_U_01_IX ON INTEGRACAO.CONF_ITEM_RESUMO_U (
PAYABLE_ENTITY_ID ASC,
CONTRACT_ID ASC)
PCTFREE    10
INITRANS   2
MAXTRANS   255
TABLESPACE TSI_MAXIMO
STORAGE   (
            INITIAL    65536
            MINEXTENTS 1
            MAXEXTENTS 2147483645
           )
/

--------------------------------------------------------------------------------------------------------------------
-- CRIAÇÃO DO ÍNDICE: INTEGRACAO.CONF_OBJETO_U_01_IX
--------------------------------------------------------------------------------------------------------------------
CREATE  INDEX INTEGRACAO.CONF_OBJETO_U_01_IX ON INTEGRACAO.CONF_OBJETO_U (
PAYABLE_ENTITY_ID ASC,
CONTRACT_ID ASC)
PCTFREE    10
INITRANS   2
MAXTRANS   255
TABLESPACE TSI_MAXIMO
STORAGE   (
            INITIAL    65536
            MINEXTENTS 1
            MAXEXTENTS 2147483645
           )
/

--------------------------------------------------------------------------------------------------------------------
-- CRIAÇÃO DO ÍNDICE: INTEGRACAO.CONF_PARTICIPANTES_U_01_IX
--------------------------------------------------------------------------------------------------------------------
CREATE  INDEX INTEGRACAO.CONF_PARTICIPANTES_U_01_IX ON INTEGRACAO.CONF_PARTICIPANTES_U (
PAYABLE_ENTITY_ID ASC,
CONTRACT_ID ASC)
PCTFREE    10
INITRANS   2
MAXTRANS   255
TABLESPACE TSI_MAXIMO
STORAGE   (
            INITIAL    65536
            MINEXTENTS 1
            MAXEXTENTS 2147483645
           )
/

--------------------------------------------------------------------------------------------------------------------
-- CRIAÇÃO DO ÍNDICE: INTEGRACAO.CONF_REPRESENTANTES_U_01_IX
--------------------------------------------------------------------------------------------------------------------
CREATE  INDEX INTEGRACAO.CONF_REPRESENTANTES_U_01_IX ON INTEGRACAO.CONF_REPRESENTANTES_U (
PAYABLE_ENTITY_ID ASC,
CONTRACT_ID ASC)
PCTFREE    10
INITRANS   2
MAXTRANS   255
TABLESPACE TSI_MAXIMO
STORAGE   (
            INITIAL    65536
            MINEXTENTS 1
            MAXEXTENTS 2147483645
           )
/

--------------------------------------------------------------------------------------------------------------------
-- CRIAÇÃO DO ÍNDICE: INTEGRACAO.CONF_SECURITY_U_01_IX
--------------------------------------------------------------------------------------------------------------------
CREATE  INDEX INTEGRACAO.CONF_SECURITY_U_01_IX ON INTEGRACAO.CONF_SECURITY_U (
PAYABLE_ENTITY_ID ASC,
CONTRACT_ID ASC)
PCTFREE    10
INITRANS   2
MAXTRANS   255
TABLESPACE TSI_MAXIMO
STORAGE   (
            INITIAL    65536
            MINEXTENTS 1
            MAXEXTENTS 2147483645
           )
/

--------------------------------------------------------------------------------------------------------------------
-- CRIAÇÃO DO ÍNDICE: INTEGRACAO.CONF_SOL_PAG_ACR_RET_U_01_IX
--------------------------------------------------------------------------------------------------------------------
CREATE  INDEX INTEGRACAO.CONF_SOL_PAG_ACR_RET_U_01_IX ON INTEGRACAO.CONF_SOL_PAG_ACR_RET_U (
PAYABLE_ENTITY_ID ASC,
CONTRACT_ID ASC)
PCTFREE    10
INITRANS   2
MAXTRANS   255
TABLESPACE TSI_MAXIMO
STORAGE   (
            INITIAL    65536
            MINEXTENTS 1
            MAXEXTENTS 2147483645
           )
/

--------------------------------------------------------------------------------------------------------------------
-- CRIAÇÃO DO ÍNDICE: INTEGRACAO.CONF_SOL_PAG_HEAD_U_01_IX
--------------------------------------------------------------------------------------------------------------------
CREATE  INDEX INTEGRACAO.CONF_SOL_PAG_HEAD_U_01_IX ON INTEGRACAO.CONF_SOL_PAG_HEAD_U (
PAYABLE_ENTITY_ID ASC,
CONTRACT_ID ASC)
PCTFREE    10
INITRANS   2
MAXTRANS   255
TABLESPACE TSI_MAXIMO
STORAGE   (
            INITIAL    65536
            MINEXTENTS 1
            MAXEXTENTS 2147483645
           )
/

--------------------------------------------------------------------------------------------------------------------
-- CRIAÇÃO DO ÍNDICE: INTEGRACAO.CONF_SOL_PAG_OUTROS_U_01_IX
--------------------------------------------------------------------------------------------------------------------
CREATE  INDEX INTEGRACAO.CONF_SOL_PAG_OUTROS_U_01_IX ON INTEGRACAO.CONF_SOL_PAG_OUTROS_U (
PAYABLE_ENTITY_ID ASC,
CONTRACT_ID ASC)
PCTFREE    10
INITRANS   2
MAXTRANS   255
TABLESPACE TSI_MAXIMO
STORAGE   (
            INITIAL    65536
            MINEXTENTS 1
            MAXEXTENTS 2147483645
           )
/

--------------------------------------------------------------------------------------------------------------------
-- CRIAÇÃO DO ÍNDICE: INTEGRACAO.CONF_SOL_PAG_RA_RATEIO_U_01_IX
--------------------------------------------------------------------------------------------------------------------
CREATE  INDEX INTEGRACAO.CONF_SOL_PAG_RA_RATEIO_U_01_IX ON INTEGRACAO.CONF_SOL_PAG_RA_RATEIO_U (
PAYABLE_ENTITY_ID ASC,
CONTRACT_ID ASC)
PCTFREE    10
INITRANS   2
MAXTRANS   255
TABLESPACE TSI_MAXIMO
STORAGE   (
            INITIAL    65536
            MINEXTENTS 1
            MAXEXTENTS 2147483645
           )
/

--------------------------------------------------------------------------------------------------------------------
-- CRIAÇÃO DO ÍNDICE: INTEGRACAO.CONF_SOL_PAG_RATEIO_U_01_IX
--------------------------------------------------------------------------------------------------------------------
CREATE  INDEX INTEGRACAO.CONF_SOL_PAG_RATEIO_U_01_IX ON INTEGRACAO.CONF_SOL_PAG_RATEIO_U (
PAYABLE_ENTITY_ID ASC,
CONTRACT_ID ASC)
PCTFREE    10
INITRANS   2
MAXTRANS   255
TABLESPACE TSI_MAXIMO
STORAGE   (
            INITIAL    65536
            MINEXTENTS 1
            MAXEXTENTS 2147483645
           )
/

--------------------------------------------------------------------------------------------------------------------
-- CRIAÇÃO DO ÍNDICE: INTEGRACAO.CONF_SOL_PAG_VAL_U_01_IX
--------------------------------------------------------------------------------------------------------------------
CREATE  INDEX INTEGRACAO.CONF_SOL_PAG_VAL_U_01_IX ON INTEGRACAO.CONF_SOL_PAG_VAL_U (
PAYABLE_ENTITY_ID ASC,
CONTRACT_ID ASC)
PCTFREE    10
INITRANS   2
MAXTRANS   255
TABLESPACE TSI_MAXIMO
STORAGE   (
            INITIAL    65536
            MINEXTENTS 1
            MAXEXTENTS 2147483645
           )
/

--------------------------------------------------------------------------------------------------------------------
-- CRIAÇÃO DO ÍNDICE: INTEGRACAO.CONF_TERMO_U_01_IX
--------------------------------------------------------------------------------------------------------------------
CREATE  INDEX INTEGRACAO.CONF_TERMO_U_01_IX ON INTEGRACAO.CONF_TERMO_U (
PAYABLE_ENTITY_ID ASC,
CONTRACT_ID ASC)
PCTFREE    10
INITRANS   2
MAXTRANS   255
TABLESPACE TSI_MAXIMO
STORAGE   (
            INITIAL    65536
            MINEXTENTS 1
            MAXEXTENTS 2147483645
           )
/

--------------------------------------------------------------------------------------------------------------------
-- CRIAÇÃO DO ÍNDICE: INTEGRACAO.CSPARU_PK
--------------------------------------------------------------------------------------------------------------------
CREATE UNIQUE INDEX INTEGRACAO.CSPARU_PK ON INTEGRACAO.CONF_SOL_PAG_ACR_RET_U (
PAYABLE_ENTITY_ID ASC,
CONTRACT_ID ASC,
CONTRACT_VERSAO ASC,
VENDOR_ID ASC,
VENDOR_LOC_CODE ASC,
PMT_RQST_NBR ASC,
PMT_RQST_DATE ASC,
SCHLD_PMT_NBR ASC,
CODIGO_RED_ACRES ASC)
PCTFREE    10
INITRANS   2
MAXTRANS   255
TABLESPACE TSI_MAXIMO
STORAGE   (
            INITIAL    65536
            MINEXTENTS 1
            MAXEXTENTS 2147483645
           )
/

--------------------------------------------------------------------------------------------------------------------
-- CRIAÇÃO DO ÍNDICE: INTEGRACAO.CSPHU_PK
--------------------------------------------------------------------------------------------------------------------
CREATE UNIQUE INDEX INTEGRACAO.CSPHU_PK ON INTEGRACAO.CONF_SOL_PAG_HEAD_U (
PAYABLE_ENTITY_ID ASC,
CONTRACT_ID ASC,
CONTRACT_VERSAO ASC,
VENDOR_ID ASC,
VENDOR_LOC_CODE ASC,
PMT_RQST_NBR ASC,
PMT_RQST_DATE ASC,
SCHLD_PMT_NBR ASC)
PCTFREE    10
INITRANS   2
MAXTRANS   255
TABLESPACE TSI_MAXIMO
STORAGE   (
            INITIAL    65536
            MINEXTENTS 1
            MAXEXTENTS 2147483645
           )
/

--------------------------------------------------------------------------------------------------------------------
-- CRIAÇÃO DO ÍNDICE: INTEGRACAO.CSPOU_PK
--------------------------------------------------------------------------------------------------------------------
CREATE UNIQUE INDEX INTEGRACAO.CSPOU_PK ON INTEGRACAO.CONF_SOL_PAG_OUTROS_U (
PAYABLE_ENTITY_ID ASC,
CONTRACT_ID ASC,
CONTRACT_VERSAO ASC,
VENDOR_ID ASC,
VENDOR_LOC_CODE ASC,
PMT_RQST_NBR ASC,
PMT_RQST_DATE ASC,
SCHLD_PMT_NBR ASC)
PCTFREE    10
INITRANS   2
MAXTRANS   255
TABLESPACE TSI_MAXIMO
STORAGE   (
            INITIAL    65536
            MINEXTENTS 1
            MAXEXTENTS 2147483645
           )
/

--------------------------------------------------------------------------------------------------------------------
-- CRIAÇÃO DO ÍNDICE: INTEGRACAO.CSPRU_PK
--------------------------------------------------------------------------------------------------------------------
CREATE UNIQUE INDEX INTEGRACAO.CSPRU_PK ON INTEGRACAO.CONF_SOL_PAG_RATEIO_U (
PAYABLE_ENTITY_ID ASC,
CONTRACT_ID ASC,
CONTRACT_VERSAO ASC,
VENDOR_ID ASC,
VENDOR_LOC_CODE ASC,
PMT_RQST_NBR ASC,
PMT_RQST_DATE ASC,
SCHLD_PMT_NBR ASC,
SEQ_ITEM ASC,
CODIGO_RESUMO_VALOR ASC,
TIPO_CRONOGRAMA ASC,
NUMERO_PARCELA ASC,
JRNL_LINE_NBR_CHAR ASC)
PCTFREE    10
INITRANS   2
MAXTRANS   255
TABLESPACE TSI_MAXIMO
STORAGE   (
            INITIAL    65536
            MINEXTENTS 1
            MAXEXTENTS 2147483645
           )
/

--------------------------------------------------------------------------------------------------------------------
-- CRIAÇÃO DO ÍNDICE: INTEGRACAO.CSPVU_PK
--------------------------------------------------------------------------------------------------------------------
CREATE UNIQUE INDEX INTEGRACAO.CSPVU_PK ON INTEGRACAO.CONF_SOL_PAG_VAL_U (
PAYABLE_ENTITY_ID ASC,
CONTRACT_ID ASC,
CONTRACT_VERSAO ASC,
VENDOR_ID ASC,
VENDOR_LOC_CODE ASC,
PMT_RQST_NBR ASC,
PMT_RQST_DATE ASC,
SCHLD_PMT_NBR ASC,
SEQ_ITEM ASC,
CODIGO_RESUMO_VALOR ASC,
TIPO_CRONOGRAMA ASC,
NUMERO_PARCELA ASC)
PCTFREE    10
INITRANS   2
MAXTRANS   255
TABLESPACE TSI_MAXIMO
STORAGE   (
            INITIAL    65536
            MINEXTENTS 1
            MAXEXTENTS 2147483645
           )
/

--------------------------------------------------------------------------------------------------------------------
-- CRIAÇÃO DO ÍNDICE: INTEGRACAO.CSU_PK
--------------------------------------------------------------------------------------------------------------------
CREATE UNIQUE INDEX INTEGRACAO.CSU_PK ON INTEGRACAO.CONF_SECURITY_U (
PAYABLE_ENTITY_ID ASC,
CONTRACT_ID ASC,
COD_MOMENTO_APROVACAO ASC,
SEQ_SEG ASC)
PCTFREE    10
INITRANS   2
MAXTRANS   255
TABLESPACE TSI_MAXIMO
STORAGE   (
            INITIAL    65536
            MINEXTENTS 1
            MAXEXTENTS 2147483645
           )
/

--------------------------------------------------------------------------------------------------------------------
-- CRIAÇÃO DO ÍNDICE: INTEGRACAO.DPCR_PK
--------------------------------------------------------------------------------------------------------------------
CREATE UNIQUE INDEX INTEGRACAO.DPCR_PK ON INTEGRACAO.GTB_DE_PARA_CCUSTO_REQ_U (
CUSTO ASC)
PCTFREE    10
INITRANS   2
MAXTRANS   255
TABLESPACE TSD_MAXIMO
STORAGE   (
            INITIAL    65536
            MINEXTENTS 1
            MAXEXTENTS 2147483645
           )
/

--------------------------------------------------------------------------------------------------------------------
-- CRIAÇÃO DO ÍNDICE: INTEGRACAO.P_CONF_IDENTIFICACAO_U
--------------------------------------------------------------------------------------------------------------------
CREATE UNIQUE INDEX INTEGRACAO.P_CONF_IDENTIFICACAO_U ON INTEGRACAO.CONF_IDENTIFICACAO_U (
PAYABLE_ENTITY_ID ASC,
CONTRACT_ID ASC,
CONTRACT_VERSAO ASC)
PCTFREE    10
INITRANS   2
MAXTRANS   255
TABLESPACE TSI_MAXIMO
STORAGE   (
            INITIAL    65536
            MINEXTENTS 1
            MAXEXTENTS 2147483645
           )
/

--------------------------------------------------------------------------------------------------------------------
-- CRIAÇÃO DO ÍNDICE: INTEGRACAO.P_CONF_ITEM_ACCT_DISTIN_U
--------------------------------------------------------------------------------------------------------------------
CREATE UNIQUE INDEX INTEGRACAO.P_CONF_ITEM_ACCT_DISTIN_U ON INTEGRACAO.CONF_ITEM_ACCT_DISTIN_U (
PAYABLE_ENTITY_ID ASC,
CONTRACT_ID ASC,
CONTRACT_VERSAO ASC,
SEQ_ITEM ASC,
LDR_ENTITY_ID ASC,
DEPENDENCIA ASC,
CONTA ASC,
PROGRAMA ASC,
PROJETO ASC,
CUSTO ASC)
PCTFREE    10
INITRANS   2
MAXTRANS   255
TABLESPACE TSI_MAXIMO
STORAGE   (
            INITIAL    65536
            MINEXTENTS 1
            MAXEXTENTS 2147483645
           )
/

--------------------------------------------------------------------------------------------------------------------
-- CRIAÇÃO DO ÍNDICE: INTEGRACAO.P_CONF_ITEM_CRONOGRAMA_U
--------------------------------------------------------------------------------------------------------------------
CREATE UNIQUE INDEX INTEGRACAO.P_CONF_ITEM_CRONOGRAMA_U ON INTEGRACAO.CONF_ITEM_CRONOGRAMA_U (
PAYABLE_ENTITY_ID ASC,
CONTRACT_ID ASC,
CONTRACT_VERSAO ASC,
SEQ_ITEM ASC,
CODIGO_RESUMO_VALOR ASC,
TIPO_CRONOGRAMA ASC,
NUMERO_PARCELA ASC)
PCTFREE    10
INITRANS   2
MAXTRANS   255
TABLESPACE TSI_MAXIMO
STORAGE   (
            INITIAL    65536
            MINEXTENTS 1
            MAXEXTENTS 2147483645
           )
/

--------------------------------------------------------------------------------------------------------------------
-- CRIAÇÃO DO ÍNDICE: INTEGRACAO.P_CONF_ITEM_IDENT_U
--------------------------------------------------------------------------------------------------------------------
CREATE UNIQUE INDEX INTEGRACAO.P_CONF_ITEM_IDENT_U ON INTEGRACAO.CONF_ITEM_IDENT_U (
PAYABLE_ENTITY_ID ASC,
CONTRACT_ID ASC,
CONTRACT_VERSAO ASC,
SEQ_ITEM ASC)
PCTFREE    10
INITRANS   2
MAXTRANS   255
TABLESPACE TSI_MAXIMO
STORAGE   (
            INITIAL    65536
            MINEXTENTS 1
            MAXEXTENTS 2147483645
           )
/

--------------------------------------------------------------------------------------------------------------------
-- CRIAÇÃO DO ÍNDICE: INTEGRACAO.P_CONF_ITEM_PROJETO_U
--------------------------------------------------------------------------------------------------------------------
CREATE UNIQUE INDEX INTEGRACAO.P_CONF_ITEM_PROJETO_U ON INTEGRACAO.CONF_ITEM_PROJETO_U (
PAYABLE_ENTITY_ID ASC,
CONTRACT_ID ASC,
CONTRACT_VERSAO ASC,
SEQ_ITEM ASC)
PCTFREE    10
INITRANS   2
MAXTRANS   255
TABLESPACE TSI_MAXIMO
STORAGE   (
            INITIAL    65536
            MINEXTENTS 1
            MAXEXTENTS 2147483645
           )
/

--------------------------------------------------------------------------------------------------------------------
-- CRIAÇÃO DO ÍNDICE: INTEGRACAO.P_CONF_ITEM_REAJUSTE_U
--------------------------------------------------------------------------------------------------------------------
CREATE UNIQUE INDEX INTEGRACAO.P_CONF_ITEM_REAJUSTE_U ON INTEGRACAO.CONF_ITEM_REAJUSTE_U (
PAYABLE_ENTITY_ID ASC,
CONTRACT_ID ASC,
CONTRACT_VERSAO ASC,
SEQ_ITEM ASC,
CODIGO_RESUMO_VALOR ASC,
BEGIN_DATE ASC)
PCTFREE    10
INITRANS   2
MAXTRANS   255
TABLESPACE TSI_MAXIMO
STORAGE   (
            INITIAL    65536
            MINEXTENTS 1
            MAXEXTENTS 2147483645
           )
/

--------------------------------------------------------------------------------------------------------------------
-- CRIAÇÃO DO ÍNDICE: INTEGRACAO.P_CONF_ITEM_RESUMO_U
--------------------------------------------------------------------------------------------------------------------
CREATE UNIQUE INDEX INTEGRACAO.P_CONF_ITEM_RESUMO_U ON INTEGRACAO.CONF_ITEM_RESUMO_U (
PAYABLE_ENTITY_ID ASC,
CONTRACT_ID ASC,
CONTRACT_VERSAO ASC,
SEQ_ITEM ASC,
CODIGO_RESUMO_VALOR ASC)
PCTFREE    10
INITRANS   2
MAXTRANS   255
TABLESPACE TSI_MAXIMO
STORAGE   (
            INITIAL    65536
            MINEXTENTS 1
            MAXEXTENTS 2147483645
           )
/

--------------------------------------------------------------------------------------------------------------------
-- CRIAÇÃO DO ÍNDICE: INTEGRACAO.P_CONF_OBJETO_U
--------------------------------------------------------------------------------------------------------------------
CREATE UNIQUE INDEX INTEGRACAO.P_CONF_OBJETO_U ON INTEGRACAO.CONF_OBJETO_U (
PAYABLE_ENTITY_ID ASC,
CONTRACT_ID ASC,
CONTRACT_VERSAO ASC)
PCTFREE    10
INITRANS   2
MAXTRANS   255
TABLESPACE TSI_MAXIMO
STORAGE   (
            INITIAL    65536
            MINEXTENTS 1
            MAXEXTENTS 2147483645
           )
/

--------------------------------------------------------------------------------------------------------------------
-- CRIAÇÃO DO ÍNDICE: INTEGRACAO.P_CONF_PARTICIPANTES_U
--------------------------------------------------------------------------------------------------------------------
CREATE UNIQUE INDEX INTEGRACAO.P_CONF_PARTICIPANTES_U ON INTEGRACAO.CONF_PARTICIPANTES_U (
PAYABLE_ENTITY_ID ASC,
CONTRACT_ID ASC,
CONTRACT_VERSAO ASC,
VENDOR_ID ASC,
VENDOR_LOC_CODE ASC)
PCTFREE    10
INITRANS   2
MAXTRANS   255
TABLESPACE TSI_MAXIMO
STORAGE   (
            INITIAL    65536
            MINEXTENTS 1
            MAXEXTENTS 2147483645
           )
/

--------------------------------------------------------------------------------------------------------------------
-- CRIAÇÃO DO ÍNDICE: INTEGRACAO.P_CONF_REPRESENTANTES_U
--------------------------------------------------------------------------------------------------------------------
CREATE UNIQUE INDEX INTEGRACAO.P_CONF_REPRESENTANTES_U ON INTEGRACAO.CONF_REPRESENTANTES_U (
PAYABLE_ENTITY_ID ASC,
CONTRACT_ID ASC,
CONTRACT_VERSAO ASC,
CPF_REPRES ASC)
PCTFREE    10
INITRANS   2
MAXTRANS   255
TABLESPACE TSI_MAXIMO
STORAGE   (
            INITIAL    65536
            MINEXTENTS 1
            MAXEXTENTS 2147483645
           )
/

--------------------------------------------------------------------------------------------------------------------
-- CRIAÇÃO DO ÍNDICE: INTEGRACAO.P_CONF_SOL_PAG_RA_RATEIO_U
--------------------------------------------------------------------------------------------------------------------
CREATE UNIQUE INDEX INTEGRACAO.P_CONF_SOL_PAG_RA_RATEIO_U ON INTEGRACAO.CONF_SOL_PAG_RA_RATEIO_U (
PAYABLE_ENTITY_ID ASC,
CONTRACT_ID ASC,
CONTRACT_VERSAO ASC,
VENDOR_ID ASC,
VENDOR_LOC_CODE ASC,
PMT_RQST_NBR ASC,
PMT_RQST_DATE ASC,
SCHLD_PMT_NBR ASC,
SEQ_RED_ACRES ASC,
JRNL_LINE_NBR_CHAR ASC)
PCTFREE    10
INITRANS   2
MAXTRANS   255
TABLESPACE TSI_MAXIMO
STORAGE   (
            INITIAL    65536
            MINEXTENTS 1
            MAXEXTENTS 2147483645
           )
/

--------------------------------------------------------------------------------------------------------------------
-- CRIAÇÃO DO ÍNDICE: INTEGRACAO.P_CONF_TERMO_U
--------------------------------------------------------------------------------------------------------------------
CREATE UNIQUE INDEX INTEGRACAO.P_CONF_TERMO_U ON INTEGRACAO.CONF_TERMO_U (
PAYABLE_ENTITY_ID ASC,
CONTRACT_ID ASC,
CONTRACT_VERSAO ASC,
CONTRACT_NUMERO_TERMO ASC)
PCTFREE    10
INITRANS   2
MAXTRANS   255
TABLESPACE TSI_MAXIMO
STORAGE   (
            INITIAL    65536
            MINEXTENTS 1
            MAXEXTENTS 2147483645
           )
/

--------------------------------------------------------------------------------------------------------------------
-- CRIAÇÃO DO ÍNDICE: INTEGRACAO.VLA_PK
--------------------------------------------------------------------------------------------------------------------
CREATE UNIQUE INDEX INTEGRACAO.VLA_PK ON INTEGRACAO.VENDOR_LOC_ADDR (
VENDOR_ID ASC,
VENDOR_LOC_CODE ASC,
ADDR_TYPE ASC)
PCTFREE    10
INITRANS   2
MAXTRANS   255
TABLESPACE TSD_MAXIMO
STORAGE   (
            INITIAL    65536
            MINEXTENTS 1
            MAXEXTENTS 2147483645
           )
/

--------------------------------------------------------------------------------------------------------------------
-- CRIAÇÃO DO ÍNDICE: INTEGRACAO.VLBAU_IX_01
--------------------------------------------------------------------------------------------------------------------
CREATE  INDEX INTEGRACAO.VLBAU_IX_01 ON INTEGRACAO.VENDOR_LOC_BANK_ACCT_U (
BANK_ACCT_NBR ASC,
BANK_NBR ASC,
BRANCH_NAME ASC)
PCTFREE    10
INITRANS   2
MAXTRANS   255
TABLESPACE TSI_MAXIMO
STORAGE   (
            INITIAL    65536
            MINEXTENTS 1
            MAXEXTENTS 2147483645
           )
/

--------------------------------------------------------------------------------------------------------------------
-- CRIAÇÃO DO ÍNDICE: INTEGRACAO.VLBAU_PK
--------------------------------------------------------------------------------------------------------------------
CREATE UNIQUE INDEX INTEGRACAO.VLBAU_PK ON INTEGRACAO.VENDOR_LOC_BANK_ACCT_U (
VENDOR_ID ASC,
VENDOR_LOC_CODE ASC,
TYPE_OF_PMT ASC,
SEQ_NBR ASC)
PCTFREE    10
INITRANS   2
MAXTRANS   255
TABLESPACE TSI_MAXIMO
STORAGE   (
            INITIAL    65536
            MINEXTENTS 1
            MAXEXTENTS 2147483645
           )
/

----------------- TOTAL DE REGISTROS ----------------- 
Quantidade de Índices: 43
------------------------------------------------------ 

