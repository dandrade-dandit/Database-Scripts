CREATE TABLE INTEGRACAO.VENDOR_LOC
  (
  VENDOR_ID CHAR (10) NOT NULL,
  VENDOR_LOC_CODE CHAR (3) NOT NULL,
  ORGANIZATION_OPERATING_NAME CHAR (45) NOT NULL,
  VENDOR_SEARCH CHAR (20) NOT NULL,
  COUNTRY_CODE CHAR (2) NOT NULL,
  TRANS_CURR_CODE CHAR (3) NOT NULL,
  CURR_OPT CHAR (1) NOT NULL,
  LANGUAGE_CODE CHAR (2) NOT NULL,
  CUSTOM_FIELD_6 CHAR (5) NOT NULL,
  CUSTOM_FIELD_7 CHAR (5) NOT NULL,
  CUSTOM_FIELD_9 CHAR (3) NOT NULL,
  CUSTOM_FIELD_10 CHAR (3) NOT NULL,
  CUSTOM_FIELD_12 CHAR (15) NOT NULL,
  CUSTOM_FIELD_13 CHAR (15) NOT NULL,
  CUSTOM_FIELD_16 CHAR (15) NOT NULL,
  CUSTOM_FIELD_17 CHAR (15) NOT NULL,
  CUSTOM_FIELD_18 CHAR (25) NOT NULL,
  CUSTOM_FIELD_19 CHAR (25) NOT NULL,
  CHGSTAMP NUMBER (2) NOT NULL,
  VENDOR_STATUS_CODE CHAR (1) NOT NULL
 )
/
COMMENT ON COLUMN INTEGRACAO.VENDOR_LOC.VENDOR_ID IS 'ID DO FORNECEDOR'
/
COMMENT ON COLUMN INTEGRACAO.VENDOR_LOC.VENDOR_LOC_CODE IS 'LOCALIZACAO DO FORNECEDOR'
/
COMMENT ON COLUMN INTEGRACAO.VENDOR_LOC.ORGANIZATION_OPERATING_NAME IS 'NOME DO FORNECEDOR'
/
COMMENT ON COLUMN INTEGRACAO.VENDOR_LOC.VENDOR_SEARCH IS 'CPF/CNPJ FORMATADO SEM PONTOS'
/
COMMENT ON COLUMN INTEGRACAO.VENDOR_LOC.COUNTRY_CODE IS 'CODIGO CORRENTE DO PAIS'
/
COMMENT ON COLUMN INTEGRACAO.VENDOR_LOC.TRANS_CURR_CODE IS 'MOEDA CORRENTE'
/
COMMENT ON COLUMN INTEGRACAO.VENDOR_LOC.CURR_OPT IS 'OPCAO DE MOEDA'
/
COMMENT ON COLUMN INTEGRACAO.VENDOR_LOC.LANGUAGE_CODE IS 'LINGUAGEM'
/
COMMENT ON COLUMN INTEGRACAO.VENDOR_LOC.CUSTOM_FIELD_6 IS 'MUNICIPIO'
/
COMMENT ON COLUMN INTEGRACAO.VENDOR_LOC.CUSTOM_FIELD_7 IS 'CODIGO DO PAGAMENTO'
/
COMMENT ON COLUMN INTEGRACAO.VENDOR_LOC.CUSTOM_FIELD_9 IS 'FLAG PROTESTO CONTRA INFRAERO'
/
COMMENT ON COLUMN INTEGRACAO.VENDOR_LOC.CUSTOM_FIELD_10 IS 'TIPO DE PESSOA'
/
COMMENT ON COLUMN INTEGRACAO.VENDOR_LOC.CUSTOM_FIELD_12 IS 'E-MAIL (PARTE 1)'
/
COMMENT ON COLUMN INTEGRACAO.VENDOR_LOC.CUSTOM_FIELD_13 IS 'E-MAIL (PARTE 2)'
/
COMMENT ON COLUMN INTEGRACAO.VENDOR_LOC.CUSTOM_FIELD_16 IS 'REGISTRO INSS'
/
COMMENT ON COLUMN INTEGRACAO.VENDOR_LOC.CUSTOM_FIELD_17 IS 'INSCRICAO MUNICIPAL'
/
COMMENT ON COLUMN INTEGRACAO.VENDOR_LOC.CUSTOM_FIELD_18 IS 'CPF/CNPJ FORMATADO'
/
COMMENT ON COLUMN INTEGRACAO.VENDOR_LOC.CUSTOM_FIELD_19 IS 'INSCRICAO ESTADUAL'
/
COMMENT ON COLUMN INTEGRACAO.VENDOR_LOC.CHGSTAMP IS 'CONTROLE DE QTDE DE ALTERACOES DO REGISTRO'
/
COMMENT ON COLUMN INTEGRACAO.VENDOR_LOC.VENDOR_STATUS_CODE IS 'FLAG DE FORNECEDOR ATIVO'
/
