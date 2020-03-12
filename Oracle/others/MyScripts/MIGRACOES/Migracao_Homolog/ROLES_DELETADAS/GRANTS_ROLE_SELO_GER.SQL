SQL> 
SQL> SELECT 'GRANT ' || PRIVILEGE || ' ON ' || TABLE_NAME || ' TO SELO_GER;'
  2  FROM  DBA_TAB_PRIVS
  3  WHERE   GRANTEE = 'SELO_GER'
  4  /

'GRANT'||PRIVILEGE||'ON'||TABLE_NAME||'TOSELO_GER;'                                                                     
---------------------------------------------------------------------------------------------                           
GRANT SELECT ON DEPENDENCIAS TO SELO_GER;                                                                               
GRANT SELECT ON SEG_GRUPO_USUARIO TO SELO_GER;                                                                          
GRANT SELECT ON SEG_SISTEMA TO SELO_GER;                                                                                
GRANT SELECT ON SEG_USUARIO TO SELO_GER;                                                                                
GRANT SELECT ON SEG_USUARIO_SISTEMA TO SELO_GER;                                                                        
GRANT DELETE ON CADASTRA_SELOS TO SELO_GER;                                                                             
GRANT INSERT ON CADASTRA_SELOS TO SELO_GER;                                                                             
GRANT SELECT ON CADASTRA_SELOS TO SELO_GER;                                                                             
GRANT UPDATE ON CADASTRA_SELOS TO SELO_GER;                                                                             
GRANT DELETE ON CIA_AEREA TO SELO_GER;                                                                                  
GRANT INSERT ON CIA_AEREA TO SELO_GER;                                                                                  
GRANT UPDATE ON CIA_AEREA TO SELO_GER;                                                                                  
GRANT SELECT ON CIA_AEREA TO SELO_GER;                                                                                  
GRANT DELETE ON DEVOLUCAO_SELOS TO SELO_GER;                                                                            
GRANT INSERT ON DEVOLUCAO_SELOS TO SELO_GER;                                                                            
GRANT SELECT ON DEVOLUCAO_SELOS TO SELO_GER;                                                                            
GRANT UPDATE ON DEVOLUCAO_SELOS TO SELO_GER;                                                                            
GRANT DELETE ON DISCREPANCIAS_SELOS TO SELO_GER;                                                                        
GRANT INSERT ON DISCREPANCIAS_SELOS TO SELO_GER;                                                                        
GRANT SELECT ON DISCREPANCIAS_SELOS TO SELO_GER;                                                                        
GRANT UPDATE ON DISCREPANCIAS_SELOS TO SELO_GER;                                                                        
GRANT DELETE ON ESTOQUE_SELOS TO SELO_GER;                                                                              
GRANT INSERT ON ESTOQUE_SELOS TO SELO_GER;                                                                              
GRANT SELECT ON ESTOQUE_SELOS TO SELO_GER;                                                                              
GRANT UPDATE ON ESTOQUE_SELOS TO SELO_GER;                                                                              
GRANT DELETE ON HST_LEITURA_SELOS TO SELO_GER;                                                                          
GRANT INSERT ON HST_LEITURA_SELOS TO SELO_GER;                                                                          
GRANT SELECT ON HST_LEITURA_SELOS TO SELO_GER;                                                                          
GRANT UPDATE ON HST_LEITURA_SELOS TO SELO_GER;                                                                          
GRANT DELETE ON HST_LEITURA_SELOS_OLD TO SELO_GER;                                                                      
GRANT INSERT ON HST_LEITURA_SELOS_OLD TO SELO_GER;                                                                      
GRANT SELECT ON HST_LEITURA_SELOS_OLD TO SELO_GER;                                                                      
GRANT UPDATE ON HST_LEITURA_SELOS_OLD TO SELO_GER;                                                                      
GRANT DELETE ON LEITURA_SELOS TO SELO_GER;                                                                              
GRANT INSERT ON LEITURA_SELOS TO SELO_GER;                                                                              
GRANT SELECT ON LEITURA_SELOS TO SELO_GER;                                                                              
GRANT UPDATE ON LEITURA_SELOS TO SELO_GER;                                                                              
GRANT DELETE ON MOTIVOS_INCLUSAO_SELOS TO SELO_GER;                                                                     
GRANT INSERT ON MOTIVOS_INCLUSAO_SELOS TO SELO_GER;                                                                     
GRANT SELECT ON MOTIVOS_INCLUSAO_SELOS TO SELO_GER;                                                                     
GRANT UPDATE ON MOTIVOS_INCLUSAO_SELOS TO SELO_GER;                                                                     
GRANT DELETE ON RECIBO_TARIFAS_EMBARQUE TO SELO_GER;                                                                    
GRANT INSERT ON RECIBO_TARIFAS_EMBARQUE TO SELO_GER;                                                                    
GRANT SELECT ON RECIBO_TARIFAS_EMBARQUE TO SELO_GER;                                                                    
GRANT UPDATE ON RECIBO_TARIFAS_EMBARQUE TO SELO_GER;                                                                    
GRANT DELETE ON RECIBO_TARIFAS_EMBARQUE_OLD TO SELO_GER;                                                                
GRANT INSERT ON RECIBO_TARIFAS_EMBARQUE_OLD TO SELO_GER;                                                                
GRANT SELECT ON RECIBO_TARIFAS_EMBARQUE_OLD TO SELO_GER;                                                                
GRANT UPDATE ON RECIBO_TARIFAS_EMBARQUE_OLD TO SELO_GER;                                                                
GRANT DELETE ON RSTE_TARIFAS_EMBARQUE TO SELO_GER;                                                                      
GRANT INSERT ON RSTE_TARIFAS_EMBARQUE TO SELO_GER;                                                                      
GRANT SELECT ON RSTE_TARIFAS_EMBARQUE TO SELO_GER;                                                                      
GRANT UPDATE ON RSTE_TARIFAS_EMBARQUE TO SELO_GER;                                                                      
GRANT DELETE ON SELOS_DEVOLVIDOS TO SELO_GER;                                                                           
GRANT INSERT ON SELOS_DEVOLVIDOS TO SELO_GER;                                                                           
GRANT SELECT ON SELOS_DEVOLVIDOS TO SELO_GER;                                                                           
GRANT UPDATE ON SELOS_DEVOLVIDOS TO SELO_GER;                                                                           
GRANT DELETE ON SEQ_RSTE_SELOS TO SELO_GER;                                                                             
GRANT INSERT ON SEQ_RSTE_SELOS TO SELO_GER;                                                                             
GRANT SELECT ON SEQ_RSTE_SELOS TO SELO_GER;                                                                             
GRANT UPDATE ON SEQ_RSTE_SELOS TO SELO_GER;                                                                             
GRANT DELETE ON TIPO_PAGAMENTO_CIAS_AEREAS TO SELO_GER;                                                                 
GRANT INSERT ON TIPO_PAGAMENTO_CIAS_AEREAS TO SELO_GER;                                                                 
GRANT SELECT ON TIPO_PAGAMENTO_CIAS_AEREAS TO SELO_GER;                                                                 
GRANT UPDATE ON TIPO_PAGAMENTO_CIAS_AEREAS TO SELO_GER;                                                                 
GRANT DELETE ON TIPO_PAGAMENTO_TARIFAS_EMBARQU TO SELO_GER;                                                             
GRANT INSERT ON TIPO_PAGAMENTO_TARIFAS_EMBARQU TO SELO_GER;                                                             
GRANT SELECT ON TIPO_PAGAMENTO_TARIFAS_EMBARQU TO SELO_GER;                                                             
GRANT UPDATE ON TIPO_PAGAMENTO_TARIFAS_EMBARQU TO SELO_GER;                                                             
GRANT SELECT ON USUARIO_DEPENDENCIA TO SELO_GER;                                                                        
GRANT SELECT ON USUARIO_CENTRO_CUSTO TO SELO_GER;                                                                       
GRANT EXECUTE ON VERIFICA_DISTRIBUICAO_SELOS TO SELO_GER;                                                               
GRANT EXECUTE ON VERIFICA_SEQUENCIA_SELOS TO SELO_GER;                                                                  
GRANT EXECUTE ON INSERE_DISTRIBUICAO_SELOS TO SELO_GER;                                                                 
GRANT EXECUTE ON PROCESSA_SELO TO SELO_GER;                                                                             
GRANT EXECUTE ON TRATA_SELO TO SELO_GER;                                                                                
GRANT EXECUTE ON STATS_LEITURA_SELOS TO SELO_GER;                                                                       
GRANT SELECT ON DEP_CONTROLE_ARQ_FREQ TO SELO_GER;                                                                      

78 linhas selecionadas.

SQL> 
SQL> SPO OFF
