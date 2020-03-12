SQL> 
SQL> SELECT 'GRANT ' || PRIVILEGE || ' ON ' || TABLE_NAME || ' TO COB_GERENTE;'
  2  FROM  DBA_TAB_PRIVS
  3  WHERE   GRANTEE = 'COB_GERENTE'
  4  /

'GRANT'||PRIVILEGE||'ON'||TABLE_NAME||'TOCOB_GERENTE;'                                                                  
------------------------------------------------------------------------------------------------                        
GRANT SELECT ON DEPENDENCIAS TO COB_GERENTE;                                                                            
GRANT SELECT ON INDICES_FINANCEIROS TO COB_GERENTE;                                                                     
GRANT SELECT ON INDICES_FIN_VALORES TO COB_GERENTE;                                                                     
GRANT SELECT ON MOEDA TO COB_GERENTE;                                                                                   
GRANT SELECT ON SEG_SISTEMA TO COB_GERENTE;                                                                             
GRANT SELECT ON CADASTROS TO COB_GERENTE;                                                                               
GRANT SELECT ON USUARIO_DEPENDENCIA TO COB_GERENTE;                                                                     
GRANT SELECT ON USUARIO_CENTRO_CUSTO TO COB_GERENTE;                                                                    
GRANT SELECT ON DEP_CONTROLE_ARQ_FREQ TO COB_GERENTE;                                                                   

9 linhas selecionadas.

SQL> 
SQL> SPO OFF
