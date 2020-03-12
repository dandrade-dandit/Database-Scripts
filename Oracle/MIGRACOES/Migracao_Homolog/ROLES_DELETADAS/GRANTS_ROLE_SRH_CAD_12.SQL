SQL> 
SQL> SELECT 'GRANT ' || PRIVILEGE || ' ON ' || OWNER || '.' || TABLE_NAME || ' TO SRH_CAD_12;'
  2  FROM  DBA_TAB_PRIVS
  3  WHERE   GRANTEE = 'SRH_CAD_12'
  4  ORDER BY
  5   OWNER
  6  /

'GRANT'||PRIVILEGE||'ON'||OWNER||'.'||TABLE_NAME||'TOSRH_CAD_12;'                                                       
------------------------------------------------------------------------------------------------------------------------
GRANT SELECT ON IFRDBA2.DEPENDENCIAS TO SRH_CAD_12;                                                                     
GRANT SELECT ON IFRDBA2.MENSAGENS_USUARIO TO SRH_CAD_12;                                                                
GRANT SELECT ON IFRDBA2.SEG_SISTEMA TO SRH_CAD_12;                                                                      
GRANT SELECT ON IFRDBA2.SEG_USUARIO_SISTEMA TO SRH_CAD_12;                                                              
GRANT SELECT ON IFRDBA2.UNIDADES_ORGANIZACIONAIS TO SRH_CAD_12;                                                         
GRANT SELECT ON IFRDBA2.USUARIO_CENTRO_CUSTO TO SRH_CAD_12;                                                             
GRANT SELECT ON IFRDBA2.USUARIO_DEPENDENCIA TO SRH_CAD_12;                                                              
GRANT SELECT ON IFRDBA2.UNIDADES_FEDERACAO TO SRH_CAD_12;                                                               
GRANT SELECT ON IFRDBA2.SEG_USUARIO TO SRH_CAD_12;                                                                      
GRANT SELECT ON IFRSRH.CADASTROS TO SRH_CAD_12;                                                                         
GRANT SELECT ON IFRSRH.SRH_REF_CODES TO SRH_CAD_12;                                                                     
GRANT EXECUTE ON IFRSRH.CHECA_INTERVALO TO SRH_CAD_12;                                                                  
GRANT EXECUTE ON IFRSRH.CALCULA_DATAS_GOZO_FERIAS TO SRH_CAD_12;                                                        
GRANT EXECUTE ON IFRSRH.CONFIGURA_EMPREGADO TO SRH_CAD_12;                                                              
GRANT EXECUTE ON IFRSRH.SRH_CAD_PROCEDIMENTOS_DIARIOS TO SRH_CAD_12;                                                    
GRANT EXECUTE ON IFRSRH.ATUALIZA_HST_DEPENDENCIA_EMP TO SRH_CAD_12;                                                     
GRANT SELECT ON IFRSRH.EMPREGADOS TO SRH_CAD_12;                                                                        
GRANT SELECT ON IFRSRH.VERSAO_OBJETOS TO SRH_CAD_12;                                                                    
GRANT SELECT ON IFRSRH.VALORES_DIARIA TO SRH_CAD_12;                                                                    
GRANT ALTER ON IFRSRH.TMP_ABSENTEISMO TO SRH_CAD_12;                                                                    
GRANT UPDATE ON IFRSRH.EMPREGADOS_CAD TO SRH_CAD_12;                                                                    
GRANT SELECT ON IFRSRH.EMPREGADOS_CAD TO SRH_CAD_12;                                                                    
GRANT INSERT ON IFRSRH.EMPREGADOS_CAD TO SRH_CAD_12;                                                                    
GRANT DELETE ON IFRSRH.EMPREGADOS_CAD TO SRH_CAD_12;                                                                    
GRANT SELECT ON IFRSRH.DEP_CONTROLE_ARQ_FREQ TO SRH_CAD_12;                                                             
GRANT UPDATE ON IFRSRH.EMISSAO_PROGRAMACOES_FERIAS TO SRH_CAD_12;                                                       
GRANT SELECT ON IFRSRH.EMISSAO_PROGRAMACOES_FERIAS TO SRH_CAD_12;                                                       
GRANT INSERT ON IFRSRH.EMISSAO_PROGRAMACOES_FERIAS TO SRH_CAD_12;                                                       
GRANT DELETE ON IFRSRH.EMISSAO_PROGRAMACOES_FERIAS TO SRH_CAD_12;                                                       
GRANT SELECT ON IFRSRH.LOG_PROGRAMACOES_FERIAS TO SRH_CAD_12;                                                           
GRANT SELECT ON IFRSRH.OCORRENCIAS_EMPREGADOS TO SRH_CAD_12;                                                            
GRANT SELECT ON IFRSRH.CBO TO SRH_CAD_12;                                                                               
GRANT UPDATE ON IFRSRH.EFETIVO_INFRAERO TO SRH_CAD_12;                                                                  
GRANT INSERT ON IFRSRH.INDICE_ABSENTEISMO TO SRH_CAD_12;                                                                
GRANT UPDATE ON IFRSRH.INDICE_ABSENTEISMO TO SRH_CAD_12;                                                                
GRANT INSERT ON IFRSRH.EFETIVO_INFRAERO TO SRH_CAD_12;                                                                  
GRANT SELECT ON SYSTEM.FRM45_ENABLED_ROLES TO SRH_CAD_12;                                                               

37 linhas selecionadas.

SQL> 
SQL> SPO OFF
