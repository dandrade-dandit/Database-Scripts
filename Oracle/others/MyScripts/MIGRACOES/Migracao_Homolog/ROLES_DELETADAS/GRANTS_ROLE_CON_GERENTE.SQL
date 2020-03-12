SQL> 
SQL> SELECT 'GRANT ' || PRIVILEGE || ' ON ' || TABLE_NAME || ' TO CON_GERENTE;'
  2  FROM  DBA_TAB_PRIVS
  3  WHERE   GRANTEE = 'CON_GERENTE'
  4  /

'GRANT'||PRIVILEGE||'ON'||TABLE_NAME||'TOCON_GERENTE;'                                                                  
------------------------------------------------------------------------------------------------                        
GRANT SELECT ON CONTA_CONTABIL TO CON_GERENTE;                                                                          
GRANT SELECT ON DEPENDENCIAS TO CON_GERENTE;                                                                            
GRANT SELECT ON DEPENDENCIAS TO CON_GERENTE;                                                                            
GRANT SELECT ON INDICES_FINANCEIROS TO CON_GERENTE;                                                                     
GRANT SELECT ON INDICES_FIN_VALORES TO CON_GERENTE;                                                                     
GRANT SELECT ON MOEDA TO CON_GERENTE;                                                                                   
GRANT SELECT ON SEG_GRUPO_USUARIO TO CON_GERENTE;                                                                       
GRANT SELECT ON SEG_SISTEMA TO CON_GERENTE;                                                                             
GRANT SELECT ON SEG_USUARIO TO CON_GERENTE;                                                                             
GRANT SELECT ON SEG_USUARIO_SISTEMA TO CON_GERENTE;                                                                     
GRANT SELECT ON CADASTROS TO CON_GERENTE;                                                                               
GRANT SELECT ON CADASTROS TO CON_GERENTE;                                                                               
GRANT SELECT ON USUARIO_DEPENDENCIA TO CON_GERENTE;                                                                     
GRANT SELECT ON USUARIO_CENTRO_CUSTO TO CON_GERENTE;                                                                    
GRANT SELECT ON DEP_CONTROLE_ARQ_FREQ TO CON_GERENTE;                                                                   

15 linhas selecionadas.

SQL> 
SQL> SPO OFF
