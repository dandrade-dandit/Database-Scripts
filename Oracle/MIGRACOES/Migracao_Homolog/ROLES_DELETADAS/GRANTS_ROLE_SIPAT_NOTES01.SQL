SQL> 
SQL> SELECT 'GRANT ' || PRIVILEGE || ' ON ' || TABLE_NAME || ' TO SIPAT_NOTES01;'
  2  FROM  DBA_TAB_PRIVS
  3  WHERE   GRANTEE = 'SIPAT_NOTES01'
  4  /

'GRANT'||PRIVILEGE||'ON'||TABLE_NAME||'TOSIPAT_NOTES01;'                                                                
--------------------------------------------------------------------------------------------------                      
GRANT SELECT ON AREA_ATENDIDA TO SIPAT_NOTES01;                                                                         
GRANT SELECT ON BEM_PATRIMONIAL TO SIPAT_NOTES01;                                                                       
GRANT UPDATE ON BEM_PATRIMONIAL TO SIPAT_NOTES01;                                                                       
GRANT SELECT ON CARACTERISTICA_PATRIMONIAL TO SIPAT_NOTES01;                                                            
GRANT SELECT ON CARAC_GRUPO_PATRIMONIAL TO SIPAT_NOTES01;                                                               
GRANT SELECT ON CENTRO_CUSTO TO SIPAT_NOTES01;                                                                          
GRANT SELECT ON GRUPO_PATRIMONIAL TO SIPAT_NOTES01;                                                                     
GRANT INSERT ON INCIDENCIA_CENTRO_CUSTO TO SIPAT_NOTES01;                                                               
GRANT DELETE ON INCIDENCIA_CENTRO_CUSTO TO SIPAT_NOTES01;                                                               
GRANT SELECT ON INCIDENCIA_CENTRO_CUSTO_DEP TO SIPAT_NOTES01;                                                           
GRANT SELECT ON PATRIM_CONTROLE TO SIPAT_NOTES01;                                                                       
GRANT SELECT ON SEG_SISTEMA TO SIPAT_NOTES01;                                                                           
GRANT SELECT ON SIPAT_EMPREGADOS TO SIPAT_NOTES01;                                                                      
GRANT INSERT ON TRANSFER_BEM_PATRIMONIAL TO SIPAT_NOTES01;                                                              
GRANT SELECT ON TRANSFER_BEM_PATRIMONIAL TO SIPAT_NOTES01;                                                              
GRANT SELECT ON VALOR_CARAC_BEM_PATRIMONIAL TO SIPAT_NOTES01;                                                           
GRANT SELECT ON UNIDADE_ORGANIZACIONAL TO SIPAT_NOTES01;                                                                

17 linhas selecionadas.

SQL> 
SQL> SPO OFF
