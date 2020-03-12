
SET ECHO ON                                                                                                                         

SET FEEDBACK ON                                                                                                                     

SPOOL C:\Sistemas\Sql\Infraero\Oracle\Scripts\script_ronei\CHK_FK_MOVIMENTACAO.lst                                                  
SELECT      A.MOV_ANO_REFERENCIA,    A.MOV_MES_REFERENCIA,    A.MOV_VERSAO_PAGAMENTO,    A.MOV_EMP_NUMERO_MATRICULA,                
A.MOV_RUB_CODIGO,    A.MOV_TIP_RUBRICA,    A.MOV_SEQUENCIAL                                                                         
FROM DBA_INFRAERO.MOVIMENTACAO@ORACLE.WORLD A WHERE NOT EXISTS                                                                      
(SELECT * FROM IFRSRH.CADASTROS B WHERE                                                                                             
B.EMP_NUMERO_MATRICULA=A.MOV_EMP_NUMERO_MATRICULA                                                                                   
)                                                                                                                                   
ORDER BY      A.MOV_ANO_REFERENCIA,    A.MOV_MES_REFERENCIA,    A.MOV_VERSAO_PAGAMENTO,    A.MOV_EMP_NUMERO_MATRICULA,              
A.MOV_RUB_CODIGO,    A.MOV_TIP_RUBRICA,    A.MOV_SEQUENCIAL;                                                                        
SELECT      A.MOV_ANO_REFERENCIA,    A.MOV_MES_REFERENCIA,    A.MOV_VERSAO_PAGAMENTO,    A.MOV_EMP_NUMERO_MATRICULA,                
A.MOV_RUB_CODIGO,    A.MOV_TIP_RUBRICA,    A.MOV_SEQUENCIAL                                                                         
FROM DBA_INFRAERO.MOVIMENTACAO@ORACLE.WORLD A WHERE NOT EXISTS                                                                      
(SELECT * FROM IFRSRH.FORMULAS B WHERE                                                                                              
B.FOR_CODIGO=A.MOV_FOR_CODIGO                                                                                                       
)                                                                                                                                   
ORDER BY      A.MOV_ANO_REFERENCIA,    A.MOV_MES_REFERENCIA,    A.MOV_VERSAO_PAGAMENTO,    A.MOV_EMP_NUMERO_MATRICULA,              
A.MOV_RUB_CODIGO,    A.MOV_TIP_RUBRICA,    A.MOV_SEQUENCIAL;                                                                        
SELECT      A.MOV_ANO_REFERENCIA,    A.MOV_MES_REFERENCIA,    A.MOV_VERSAO_PAGAMENTO,    A.MOV_EMP_NUMERO_MATRICULA,                
A.MOV_RUB_CODIGO,    A.MOV_TIP_RUBRICA,    A.MOV_SEQUENCIAL                                                                         
FROM DBA_INFRAERO.MOVIMENTACAO@ORACLE.WORLD A WHERE NOT EXISTS                                                                      
(SELECT * FROM IFRSRH.OCORRENCIAS_EMPREGADOS B WHERE                                                                                
B.OEM_EMP_NUMERO_MATRICULA=A.MOV_OEM_EMP_NUMERO_MATRICULA                                                                           
and B.OEM_OFU_CODIGO=A.MOV_OEM_OFU_CODIGO                                                                                           
and B.OEM_DATA_INICIO=A.MOV_OEM_DATA_INICIO                                                                                         
)                                                                                                                                   
ORDER BY      A.MOV_ANO_REFERENCIA,    A.MOV_MES_REFERENCIA,    A.MOV_VERSAO_PAGAMENTO,    A.MOV_EMP_NUMERO_MATRICULA,              
A.MOV_RUB_CODIGO,    A.MOV_TIP_RUBRICA,    A.MOV_SEQUENCIAL;                                                                        
SELECT      A.MOV_ANO_REFERENCIA,    A.MOV_MES_REFERENCIA,    A.MOV_VERSAO_PAGAMENTO,    A.MOV_EMP_NUMERO_MATRICULA,                
A.MOV_RUB_CODIGO,    A.MOV_TIP_RUBRICA,    A.MOV_SEQUENCIAL                                                                         
FROM DBA_INFRAERO.MOVIMENTACAO@ORACLE.WORLD A WHERE NOT EXISTS                                                                      
(SELECT * FROM IFRSRH.PENSIONISTAS B WHERE                                                                                          
B.PEN_EMP_NUMERO_MATRICULA=A.MOV_EMP_NUMERO_MATRICULA                                                                               
and B.PEN_CODIGO=A.MOV_PEN_CODIGO                                                                                                   
)                                                                                                                                   
ORDER BY      A.MOV_ANO_REFERENCIA,    A.MOV_MES_REFERENCIA,    A.MOV_VERSAO_PAGAMENTO,    A.MOV_EMP_NUMERO_MATRICULA,              
A.MOV_RUB_CODIGO,    A.MOV_TIP_RUBRICA,    A.MOV_SEQUENCIAL;                                                                        
SELECT      A.MOV_ANO_REFERENCIA,    A.MOV_MES_REFERENCIA,    A.MOV_VERSAO_PAGAMENTO,    A.MOV_EMP_NUMERO_MATRICULA,                
A.MOV_RUB_CODIGO,    A.MOV_TIP_RUBRICA,    A.MOV_SEQUENCIAL                                                                         
FROM DBA_INFRAERO.MOVIMENTACAO@ORACLE.WORLD A WHERE NOT EXISTS                                                                      
(SELECT * FROM IFRSRH.RUBRICAS B WHERE                                                                                              
B.RUB_CODIGO=A.MOV_RUB_CODIGO                                                                                                       
)                                                                                                                                   
ORDER BY      A.MOV_ANO_REFERENCIA,    A.MOV_MES_REFERENCIA,    A.MOV_VERSAO_PAGAMENTO,    A.MOV_EMP_NUMERO_MATRICULA,              
A.MOV_RUB_CODIGO,    A.MOV_TIP_RUBRICA,    A.MOV_SEQUENCIAL;                                                                        

SPOOL OFF                                                                                                                           
