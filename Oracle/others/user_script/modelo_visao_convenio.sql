CREATE OR REPLACE VIEW VIW_CONVENIO (
   NUM_SEQ_CONTRATO,
   CNT_CRE_COD,
   CNT_COD,
   CNT_JUSTIFICATIVA_CRE,
   CNT_FIR_COD,
   CNT_ICE_COD,
   CNT_DATA_PROPOSTA,
   CNT_DATA,
   CNT_DATA_INICIO,
   CNT_UTIL,
   CNT_PRAZO_EXEC,
   CNT_PRAZO_ADIT,
   CNT_VALOR,
   CNT_VALOR_COMPROMISSO,
   CNT_VALOR_TERMO,
   CNT_VALOR_REAJ,
   CNT_VALOR_PAGO,
   CNT_VALOR_REAJ_PAGO,
   CNT_VAL_IND_PAGO,
   CNT_USUARIO,
   CNT_CEI,
   CNT_CREA,
   NUM_SEQ_GESTOR,
   NUM_SEQ_FISCAL,
   NUM_SEQ_ASSINATURA_1,
   NUM_SEQ_ASSINATURA_2,
   NUM_ATO_ADMINISTRATIVO,
   DAT_TERMINO_CONTRATO,
   NUM_PRAZO_EXEC_MESES,
   TIP_SITUACAO_CONTRATO,
   COD_DEP_CONTRATO,
   TIP_CONTRATO )
AS
SELECT 
"NUM_SEQ_CONTRATO", "CNT_CRE_COD","CNT_COD","CNT_JUSTIFICATIVA_CRE","CNT_FIR_COD",
"CNT_ICE_COD","CNT_DATA_PROPOSTA","CNT_DATA","CNT_DATA_INICIO","CNT_UTIL",
"CNT_PRAZO_EXEC","CNT_PRAZO_ADIT","CNT_VALOR","CNT_VALOR_COMPROMISSO",
"CNT_VALOR_TERMO","CNT_VALOR_REAJ","CNT_VALOR_PAGO","CNT_VALOR_REAJ_PAGO",
"CNT_VAL_IND_PAGO","CNT_USUARIO","CNT_CEI","CNT_CREA",
"NUM_SEQ_GESTOR","NUM_SEQ_FISCAL", "NUM_SEQ_ASSINATURA_1", "NUM_SEQ_ASSINATURA_2",
"NUM_ATO_ADMINISTRATIVO","DAT_TERMINO_CONTRATO","NUM_PRAZO_EXEC_MESES",
"TIP_SITUACAO_CONTRATO", "COD_DEP_CONTRATO", "TIP_CONTRATO"
FROM SIPRECO.TAB_CONTRATO
WHERE TIP_CONTRATO = 2
/

GRANT DELETE,INSERT,SELECT,UPDATE ON VIW_CONVENIO TO ROLE_SIPRECO
/
GRANT DELETE,INSERT,SELECT,UPDATE ON VIW_CONVENIO TO ROLE_SIPRECO_VIEWS
/
GRANT ALTER,DELETE,INSERT,SELECT,UPDATE ON VIW_CONVENIO TO SIPRECO_VIEWS
WITH GRANT OPTION
/

