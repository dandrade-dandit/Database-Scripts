SQL> 
SQL> SELECT 'GRANT ' || PRIVILEGE || ' ON ' || TABLE_NAME || ' TO CON_USR2;'
  2  FROM  DBA_TAB_PRIVS
  3  WHERE   GRANTEE = 'CON_USR2'
  4  /

'GRANT'||PRIVILEGE||'ON'||TABLE_NAME||'TOCON_USR2;'                                                                     
---------------------------------------------------------------------------------------------                           
GRANT SELECT ON CONTA_CONTABIL TO CON_USR2;                                                                             
GRANT SELECT ON DEPENDENCIAS TO CON_USR2;                                                                               
GRANT SELECT ON DEPENDENCIAS TO CON_USR2;                                                                               
GRANT SELECT ON INDICES_FINANCEIROS TO CON_USR2;                                                                        
GRANT SELECT ON INDICES_FIN_VALORES TO CON_USR2;                                                                        
GRANT SELECT ON MOEDA TO CON_USR2;                                                                                      
GRANT SELECT ON SEG_GRUPO_USUARIO TO CON_USR2;                                                                          
GRANT SELECT ON SEG_SISTEMA TO CON_USR2;                                                                                
GRANT SELECT ON SEG_USUARIO TO CON_USR2;                                                                                
GRANT SELECT ON SEG_USUARIO_SISTEMA TO CON_USR2;                                                                        
GRANT SELECT ON CADASTROS TO CON_USR2;                                                                                  
GRANT SELECT ON CADASTROS TO CON_USR2;                                                                                  
GRANT SELECT ON USUARIO_DEPENDENCIA TO CON_USR2;                                                                        
GRANT SELECT ON USUARIO_CENTRO_CUSTO TO CON_USR2;                                                                       
GRANT SELECT ON DEP_CONTROLE_ARQ_FREQ TO CON_USR2;                                                                      

15 linhas selecionadas.

SQL> 
SQL> SPO OFF
