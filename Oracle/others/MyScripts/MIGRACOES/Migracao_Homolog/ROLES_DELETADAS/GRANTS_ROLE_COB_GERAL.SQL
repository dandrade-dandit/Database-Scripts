SQL> 
SQL> SELECT 'GRANT ' || PRIVILEGE || ' ON ' || TABLE_NAME || ' TO COB_GERAL;'
  2  FROM  DBA_TAB_PRIVS
  3  WHERE   GRANTEE = 'COB_GERAL'
  4  /

'GRANT'||PRIVILEGE||'ON'||TABLE_NAME||'TOCOB_GERAL;'                                                                    
----------------------------------------------------------------------------------------------                          
GRANT SELECT ON SEG_SISTEMA TO COB_GERAL;                                                                               

1 linha selecionada.

SQL> 
SQL> SPO OFF
