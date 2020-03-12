SQL> 
SQL> SELECT 'GRANT ' || PRIVILEGE || ' ON ' || TABLE_NAME || ' TO ORC_AUDITOR;'
  2  FROM  DBA_TAB_PRIVS
  3  WHERE   GRANTEE = 'ORC_AUDITOR'
  4  /

'GRANT'||PRIVILEGE||'ON'||TABLE_NAME||'TOORC_AUDITOR;'                                                                  
------------------------------------------------------------------------------------------------                        
GRANT SELECT ON FRM45_ENABLED_ROLES TO ORC_AUDITOR;                                                                     
GRANT SELECT ON AGENCIAINF TO ORC_AUDITOR;                                                                              
GRANT SELECT ON AGRUPAMENTO_CONTABIL TO ORC_AUDITOR;                                                                    
GRANT SELECT ON AGRUPAMENTO_RECEITA TO ORC_AUDITOR;                                                                     
GRANT SELECT ON BANCOINF TO ORC_AUDITOR;                                                                                
GRANT SELECT ON COTACAO_MOEDA TO ORC_AUDITOR;                                                                           
GRANT SELECT ON CUSTODIA TO ORC_AUDITOR;                                                                                
GRANT SELECT ON ESPECIE_TITULO TO ORC_AUDITOR;                                                                          
GRANT SELECT ON ESTRUTURA_MARGEM_OPERACIONAL TO ORC_AUDITOR;                                                            
GRANT SELECT ON ESTRUTURA_RECEITA TO ORC_AUDITOR;                                                                       
GRANT SELECT ON EVENTO_CONTABIL TO ORC_AUDITOR;                                                                         
GRANT SELECT ON FERIADO TO ORC_AUDITOR;                                                                                 
GRANT SELECT ON INDICES_FINANCEIROS TO ORC_AUDITOR;                                                                     
GRANT SELECT ON INDICES_FIN_VALORES TO ORC_AUDITOR;                                                                     
GRANT SELECT ON MOEDA TO ORC_AUDITOR;                                                                                   
GRANT SELECT ON ORIGEM_CAUCAO TO ORC_AUDITOR;                                                                           
GRANT SELECT ON PARAMETRO_TESOURARIA_DEP TO ORC_AUDITOR;                                                                
GRANT SELECT ON SEGURADORA TO ORC_AUDITOR;                                                                              
GRANT SELECT ON SEG_SISTEMA TO ORC_AUDITOR;                                                                             
GRANT SELECT ON SEG_USUARIO TO ORC_AUDITOR;                                                                             
GRANT SELECT ON SEG_USUARIO_CENTRO_CUSTO TO ORC_AUDITOR;                                                                
GRANT SELECT ON TAB_CORRETORA_VALORES TO ORC_AUDITOR;                                                                   
GRANT SELECT ON TELEF_UNIDADE_ORGANIZACIONAL TO ORC_AUDITOR;                                                            
GRANT SELECT ON TIPO_GARANTIA TO ORC_AUDITOR;                                                                           
GRANT SELECT ON UNIDADES_ORGANIZACIONAIS TO ORC_AUDITOR;                                                                
GRANT SELECT ON CONTROLE_USUARIO_DEPENDENCIA TO ORC_AUDITOR;                                                            
GRANT SELECT ON EMAIL_EMPREGADO TO ORC_AUDITOR;                                                                         
GRANT SELECT ON DEPENDENCIA TO ORC_AUDITOR;                                                                             
GRANT SELECT ON EMPREGADOS_SICOF TO ORC_AUDITOR;                                                                        
GRANT SELECT ON USUARIO_DEPENDENCIA TO ORC_AUDITOR;                                                                     
GRANT SELECT ON PROPOSTA_ORCAMENTARIA TO ORC_AUDITOR;                                                                   
GRANT SELECT ON USUARIO_CENTRO_CUSTO TO ORC_AUDITOR;                                                                    

32 linhas selecionadas.

SQL> 
SQL> SPO OFF
