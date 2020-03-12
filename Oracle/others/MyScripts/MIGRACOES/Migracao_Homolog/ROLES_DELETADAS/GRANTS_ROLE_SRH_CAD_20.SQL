SQL> 
SQL> SELECT 'GRANT ' || PRIVILEGE || ' ON ' || TABLE_NAME || ' TO SRH_CAD_20;'
  2  FROM  DBA_TAB_PRIVS
  3  WHERE   GRANTEE = 'SRH_CAD_20'
  4  /

'GRANT'||PRIVILEGE||'ON'||TABLE_NAME||'TOSRH_CAD_20;'                                                                   
-----------------------------------------------------------------------------------------------                         
GRANT SELECT ON SEG_SISTEMA TO SRH_CAD_20;                                                                              
GRANT SELECT ON CBO TO SRH_CAD_20;                                                                                      
GRANT INSERT ON EFETIVO_INFRAERO TO SRH_CAD_20;                                                                         
GRANT UPDATE ON EFETIVO_INFRAERO TO SRH_CAD_20;                                                                         
GRANT DELETE ON HORARIOS_FREQUENCIA TO SRH_CAD_20;                                                                      
GRANT INSERT ON HORARIOS_FREQUENCIA TO SRH_CAD_20;                                                                      
GRANT UPDATE ON HORARIOS_FREQUENCIA TO SRH_CAD_20;                                                                      
GRANT INSERT ON INDICE_ABSENTEISMO TO SRH_CAD_20;                                                                       
GRANT UPDATE ON INDICE_ABSENTEISMO TO SRH_CAD_20;                                                                       
GRANT SELECT ON LOG_OCORRENCIAS_EMPREGADOS TO SRH_CAD_20;                                                               
GRANT DELETE ON MOVIMENTACAO TO SRH_CAD_20;                                                                             
GRANT INSERT ON MOVIMENTACAO TO SRH_CAD_20;                                                                             
GRANT UPDATE ON MOVIMENTACAO TO SRH_CAD_20;                                                                             
GRANT DELETE ON OCORRENCIAS_EMPREGADOS TO SRH_CAD_20;                                                                   
GRANT INSERT ON OCORRENCIAS_EMPREGADOS TO SRH_CAD_20;                                                                   
GRANT UPDATE ON OCORRENCIAS_EMPREGADOS TO SRH_CAD_20;                                                                   
GRANT DELETE ON TIPOS_OCORRENCIAS TO SRH_CAD_20;                                                                        
GRANT INSERT ON TIPOS_OCORRENCIAS TO SRH_CAD_20;                                                                        
GRANT UPDATE ON TIPOS_OCORRENCIAS TO SRH_CAD_20;                                                                        
GRANT DELETE ON TIPOS_OCORRENCIAS_RUBRICAS TO SRH_CAD_20;                                                               
GRANT INSERT ON TIPOS_OCORRENCIAS_RUBRICAS TO SRH_CAD_20;                                                               
GRANT UPDATE ON TIPOS_OCORRENCIAS_RUBRICAS TO SRH_CAD_20;                                                               
GRANT ALTER ON TMP_ABSENTEISMO TO SRH_CAD_20;                                                                           
GRANT DELETE ON TMP_DEMONSTRATIVO_FREQUENCIA TO SRH_CAD_20;                                                             
GRANT INSERT ON TMP_DEMONSTRATIVO_FREQUENCIA TO SRH_CAD_20;                                                             
GRANT UPDATE ON TMP_DEMONSTRATIVO_FREQUENCIA TO SRH_CAD_20;                                                             
GRANT SELECT ON TMP_DEMONSTRATIVO_FREQUENCIA TO SRH_CAD_20;                                                             
GRANT SELECT ON VALORES_DIARIA TO SRH_CAD_20;                                                                           
GRANT SELECT ON VERSAO_OBJETOS TO SRH_CAD_20;                                                                           
GRANT SELECT ON CENTRO_CUSTO_DEP TO SRH_CAD_20;                                                                         
GRANT SELECT ON USUARIO_DEPENDENCIA TO SRH_CAD_20;                                                                      
GRANT SELECT ON USUARIO_CENTRO_CUSTO TO SRH_CAD_20;                                                                     
GRANT EXECUTE ON ATUALIZA_HST_DEPENDENCIA_EMP TO SRH_CAD_20;                                                            
GRANT EXECUTE ON SRH_CAD_PROCEDIMENTOS_DIARIOS TO SRH_CAD_20;                                                           
GRANT EXECUTE ON CALCULA_DATAS_GOZO_FERIAS TO SRH_CAD_20;                                                               
GRANT EXECUTE ON CHECA_INTERVALO TO SRH_CAD_20;                                                                         
GRANT SELECT ON LOG_PROGRAMACOES_FERIAS TO SRH_CAD_20;                                                                  
GRANT DELETE ON EMISSAO_PROGRAMACOES_FERIAS TO SRH_CAD_20;                                                              
GRANT INSERT ON EMISSAO_PROGRAMACOES_FERIAS TO SRH_CAD_20;                                                              
GRANT SELECT ON EMISSAO_PROGRAMACOES_FERIAS TO SRH_CAD_20;                                                              
GRANT UPDATE ON EMISSAO_PROGRAMACOES_FERIAS TO SRH_CAD_20;                                                              
GRANT DELETE ON EMPREGADOS_CAD TO SRH_CAD_20;                                                                           
GRANT INSERT ON EMPREGADOS_CAD TO SRH_CAD_20;                                                                           
GRANT SELECT ON EMPREGADOS_CAD TO SRH_CAD_20;                                                                           
GRANT UPDATE ON EMPREGADOS_CAD TO SRH_CAD_20;                                                                           

45 linhas selecionadas.

SQL> 
SQL> spo off
