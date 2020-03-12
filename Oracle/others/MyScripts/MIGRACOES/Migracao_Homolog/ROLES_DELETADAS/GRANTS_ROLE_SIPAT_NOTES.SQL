SQL> 
SQL> SELECT 'GRANT ' || PRIVILEGE || ' ON ' || TABLE_NAME || ' TO SIPAT_NOTES;'
  2  FROM  DBA_TAB_PRIVS
  3  WHERE   GRANTEE = 'SIPAT_NOTES'
  4  /

'GRANT'||PRIVILEGE||'ON'||TABLE_NAME||'TOSIPAT_NOTES;'                                                                  
------------------------------------------------------------------------------------------------                        
GRANT SELECT ON SEG_SISTEMA TO SIPAT_NOTES;                                                                             

1 linha selecionada.

SQL> 
SQL> SPO OFF
