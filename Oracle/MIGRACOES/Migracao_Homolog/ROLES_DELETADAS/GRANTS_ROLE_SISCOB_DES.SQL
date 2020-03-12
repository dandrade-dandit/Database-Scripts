SQL> 
SQL> SELECT 'GRANT ' || PRIVILEGE || ' ON ' || TABLE_NAME || ' TO SISCOB_DES;'
  2  FROM  DBA_TAB_PRIVS
  3  WHERE   GRANTEE = 'SISCOB_DES'
  4  /

'GRANT'||PRIVILEGE||'ON'||TABLE_NAME||'TOSISCOB_DES;'                                                                   
-----------------------------------------------------------------------------------------------                         
GRANT SELECT ON SEG_SISTEMA TO SISCOB_DES;                                                                              

1 linha selecionada.

SQL> 
SQL> SPO OFF
