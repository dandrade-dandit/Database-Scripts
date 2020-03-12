SQL> 
SQL> SELECT 'GRANT ' || PRIVILEGE || ' ON ' || TABLE_NAME || ' TO SRH_CAD_15;'
  2  FROM  DBA_TAB_PRIVS
  3  WHERE   GRANTEE = 'SRH_CAD_15'
  4  /

'GRANT'||PRIVILEGE||'ON'||TABLE_NAME||'TOSRH_CAD_15;'                                                                   
-----------------------------------------------------------------------------------------------                         
GRANT SELECT ON FRM45_ENABLED_ROLES TO SRH_CAD_15;                                                                      
GRANT SELECT ON CENTRO_CUSTO TO SRH_CAD_15;                                                                             
GRANT SELECT ON DEPENDENCIAS TO SRH_CAD_15;                                                                             
GRANT SELECT ON HISTORICO_CENTRO_CUSTOS TO SRH_CAD_15;                                                                  
GRANT DELETE ON INCIDENCIA_CENTRO_CUSTO_DEP TO SRH_CAD_15;                                                              
GRANT INSERT ON INCIDENCIA_CENTRO_CUSTO_DEP TO SRH_CAD_15;                                                              
GRANT SELECT ON INCIDENCIA_CENTRO_CUSTO_DEP TO SRH_CAD_15;                                                              
GRANT UPDATE ON INCIDENCIA_CENTRO_CUSTO_DEP TO SRH_CAD_15;                                                              
GRANT SELECT ON MENSAGENS_USUARIO TO SRH_CAD_15;                                                                        
GRANT SELECT ON SEG_SISTEMA TO SRH_CAD_15;                                                                              
GRANT SELECT ON SEG_USUARIO TO SRH_CAD_15;                                                                              
GRANT SELECT ON SEG_USUARIO_SISTEMA TO SRH_CAD_15;                                                                      
GRANT SELECT ON UNIDADES_FEDERACAO TO SRH_CAD_15;                                                                       
GRANT SELECT ON UNIDADES_ORGANIZACIONAIS TO SRH_CAD_15;                                                                 
GRANT SELECT ON CADASTROS TO SRH_CAD_15;                                                                                
GRANT SELECT ON CBO TO SRH_CAD_15;                                                                                      
GRANT INSERT ON EFETIVO_INFRAERO TO SRH_CAD_15;                                                                         
GRANT UPDATE ON EFETIVO_INFRAERO TO SRH_CAD_15;                                                                         
GRANT INSERT ON INDICE_ABSENTEISMO TO SRH_CAD_15;                                                                       
GRANT UPDATE ON INDICE_ABSENTEISMO TO SRH_CAD_15;                                                                       
GRANT SELECT ON SRH_REF_CODES TO SRH_CAD_15;                                                                            
GRANT ALTER ON TMP_ABSENTEISMO TO SRH_CAD_15;                                                                           
GRANT SELECT ON VALORES_DIARIA TO SRH_CAD_15;                                                                           
GRANT SELECT ON VERSAO_OBJETOS TO SRH_CAD_15;                                                                           
GRANT DELETE ON CENTRO_CUSTO_DEP TO SRH_CAD_15;                                                                         
GRANT INSERT ON CENTRO_CUSTO_DEP TO SRH_CAD_15;                                                                         
GRANT SELECT ON CENTRO_CUSTO_DEP TO SRH_CAD_15;                                                                         
GRANT UPDATE ON CENTRO_CUSTO_DEP TO SRH_CAD_15;                                                                         
GRANT DELETE ON CENTRO_CUSTOS TO SRH_CAD_15;                                                                            
GRANT INSERT ON CENTRO_CUSTOS TO SRH_CAD_15;                                                                            
GRANT SELECT ON CENTRO_CUSTOS TO SRH_CAD_15;                                                                            
GRANT UPDATE ON CENTRO_CUSTOS TO SRH_CAD_15;                                                                            
GRANT SELECT ON EMPREGADOS TO SRH_CAD_15;                                                                               
GRANT SELECT ON USUARIO_DEPENDENCIA TO SRH_CAD_15;                                                                      
GRANT SELECT ON USUARIO_CENTRO_CUSTO TO SRH_CAD_15;                                                                     
GRANT EXECUTE ON ATUALIZA_HST_DEPENDENCIA_EMP TO SRH_CAD_15;                                                            
GRANT EXECUTE ON SRH_CAD_PROCEDIMENTOS_DIARIOS TO SRH_CAD_15;                                                           
GRANT EXECUTE ON CALCULA_DATAS_GOZO_FERIAS TO SRH_CAD_15;                                                               
GRANT EXECUTE ON CHECA_INTERVALO TO SRH_CAD_15;                                                                         
GRANT SELECT ON LOG_PROGRAMACOES_FERIAS TO SRH_CAD_15;                                                                  
GRANT DELETE ON EMISSAO_PROGRAMACOES_FERIAS TO SRH_CAD_15;                                                              
GRANT INSERT ON EMISSAO_PROGRAMACOES_FERIAS TO SRH_CAD_15;                                                              
GRANT SELECT ON EMISSAO_PROGRAMACOES_FERIAS TO SRH_CAD_15;                                                              
GRANT UPDATE ON EMISSAO_PROGRAMACOES_FERIAS TO SRH_CAD_15;                                                              
GRANT SELECT ON DEP_CONTROLE_ARQ_FREQ TO SRH_CAD_15;                                                                    
GRANT DELETE ON EMPREGADOS_CAD TO SRH_CAD_15;                                                                           
GRANT INSERT ON EMPREGADOS_CAD TO SRH_CAD_15;                                                                           
GRANT SELECT ON EMPREGADOS_CAD TO SRH_CAD_15;                                                                           
GRANT UPDATE ON EMPREGADOS_CAD TO SRH_CAD_15;                                                                           

49 linhas selecionadas.

SQL> 
SQL> spo MIGRACOES\Migracao_Homolog\ROLES_DELETADAS\GRANTS_ROLE_SRH_CAD_16.SQL
