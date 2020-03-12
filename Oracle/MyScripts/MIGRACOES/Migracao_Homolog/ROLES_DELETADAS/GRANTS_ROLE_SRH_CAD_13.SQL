SQL> 
SQL> SELECT 'GRANT ' || PRIVILEGE || ' ON ' || TABLE_NAME || ' TO SRH_CAD_13;'
  2  FROM  DBA_TAB_PRIVS
  3  WHERE   GRANTEE = 'SRH_CAD_13'
  4  /

'GRANT'||PRIVILEGE||'ON'||TABLE_NAME||'TOSRH_CAD_13;'                                                                   
-----------------------------------------------------------------------------------------------                         
GRANT INSERT ON INDICE_ABSENTEISMO TO SRH_CAD_13;                                                                       
GRANT UPDATE ON INDICE_ABSENTEISMO TO SRH_CAD_13;                                                                       
GRANT SELECT ON SRH_REF_CODES TO SRH_CAD_13;                                                                            
GRANT ALTER ON TMP_ABSENTEISMO TO SRH_CAD_13;                                                                           
GRANT SELECT ON VALORES_DIARIA TO SRH_CAD_13;                                                                           
GRANT SELECT ON VERSAO_OBJETOS TO SRH_CAD_13;                                                                           
GRANT SELECT ON EMPREGADOS TO SRH_CAD_13;                                                                               
GRANT EXECUTE ON ATUALIZA_HST_DEPENDENCIA_EMP TO SRH_CAD_13;                                                            
GRANT EXECUTE ON SRH_CAD_PROCEDIMENTOS_DIARIOS TO SRH_CAD_13;                                                           
GRANT EXECUTE ON CONFIGURA_EMPREGADO TO SRH_CAD_13;                                                                     
GRANT EXECUTE ON CALCULA_DATAS_GOZO_FERIAS TO SRH_CAD_13;                                                               
GRANT EXECUTE ON CHECA_INTERVALO TO SRH_CAD_13;                                                                         
GRANT SELECT ON LOG_PROGRAMACOES_FERIAS TO SRH_CAD_13;                                                                  
GRANT DELETE ON EMISSAO_PROGRAMACOES_FERIAS TO SRH_CAD_13;                                                              
GRANT INSERT ON EMISSAO_PROGRAMACOES_FERIAS TO SRH_CAD_13;                                                              
GRANT SELECT ON EMISSAO_PROGRAMACOES_FERIAS TO SRH_CAD_13;                                                              
GRANT UPDATE ON EMISSAO_PROGRAMACOES_FERIAS TO SRH_CAD_13;                                                              
GRANT DELETE ON EMPREGADOS_CAD TO SRH_CAD_13;                                                                           
GRANT INSERT ON EMPREGADOS_CAD TO SRH_CAD_13;                                                                           
GRANT SELECT ON EMPREGADOS_CAD TO SRH_CAD_13;                                                                           
GRANT UPDATE ON EMPREGADOS_CAD TO SRH_CAD_13;                                                                           

21 linhas selecionadas.

SQL> 
SQL> SPO OFF
