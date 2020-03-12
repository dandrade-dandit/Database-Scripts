SQL> 
SQL> SELECT 'GRANT ' || PRIVILEGE || ' ON ' || TABLE_NAME || ' TO COB_USR2;'
  2  FROM  DBA_TAB_PRIVS
  3  WHERE   GRANTEE = 'COB_USR2'
  4  /

'GRANT'||PRIVILEGE||'ON'||TABLE_NAME||'TOCOB_USR2;'                                                                     
---------------------------------------------------------------------------------------------                           
GRANT SELECT ON DEPENDENCIAS TO COB_USR2;                                                                               
GRANT SELECT ON INDICES_FINANCEIROS TO COB_USR2;                                                                        
GRANT SELECT ON INDICES_FIN_VALORES TO COB_USR2;                                                                        
GRANT SELECT ON MOEDA TO COB_USR2;                                                                                      
GRANT SELECT ON SEG_SISTEMA TO COB_USR2;                                                                                
GRANT SELECT ON CADASTROS TO COB_USR2;                                                                                  
GRANT SELECT ON USUARIO_DEPENDENCIA TO COB_USR2;                                                                        
GRANT SELECT ON USUARIO_CENTRO_CUSTO TO COB_USR2;                                                                       
GRANT SELECT ON DEP_CONTROLE_ARQ_FREQ TO COB_USR2;                                                                      

9 linhas selecionadas.

SQL> 
SQL> SPO OFF
