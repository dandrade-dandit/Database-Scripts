alter table TMP_DOCUMENTOS_COBRANCA
add TMP_DOC_NUMERO_INFRAERO number(11)
/

alter table TMP_DOCUMENTOS_COBRANCA
add TMP_DOC_GUIAS_EMP_TOTAL number(08)
/

alter table TMP_DOCUMENTOS_COBRANCA
add TMP_GPR_VALOR_TOTAL     number(12,2)
/

alter table INTERFACE_ERROS_PLANO_SAUDE
add IEP_VALOR number(12,2)
/
