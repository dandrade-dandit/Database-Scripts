SELECT M.*, R.RUB_DENOMINACAO         
FROM MOVIMENTACAO M, RUBRICAS R
WHERE M.MOV_ANO_REFERENCIA = 2003 AND M.MOV_MES_REFERENCIA = 11
AND M.MOV_EMP_NUMERO_MATRICULA=11111111111111 
AND M.MOV_RUB_CODIGO = R.RUB_CODIGO     
/

