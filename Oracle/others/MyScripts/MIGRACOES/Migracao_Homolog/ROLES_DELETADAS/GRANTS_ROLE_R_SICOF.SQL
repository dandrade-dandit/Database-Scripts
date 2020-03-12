SQL> 
SQL> SELECT 'GRANT ' || PRIVILEGE || ' ON ' || TABLE_NAME || ' TO R_SICOF;'
  2  FROM  DBA_TAB_PRIVS
  3  WHERE   GRANTEE = 'R_SICOF'
  4  /

'GRANT'||PRIVILEGE||'ON'||TABLE_NAME||'TOR_SICOF;'                                                                      
--------------------------------------------------------------------------------------------                            
GRANT DELETE ON ITEM_MENSAL_COMPROMISSO_ORC TO R_SICOF;                                                                 
GRANT INSERT ON ITEM_MENSAL_COMPROMISSO_ORC TO R_SICOF;                                                                 
GRANT SELECT ON ITEM_MENSAL_COMPROMISSO_ORC TO R_SICOF;                                                                 
GRANT UPDATE ON ITEM_MENSAL_COMPROMISSO_ORC TO R_SICOF;                                                                 
GRANT DELETE ON ITEM_MENSAL_PRE_COMP_ORC TO R_SICOF;                                                                    
GRANT INSERT ON ITEM_MENSAL_PRE_COMP_ORC TO R_SICOF;                                                                    
GRANT SELECT ON ITEM_MENSAL_PRE_COMP_ORC TO R_SICOF;                                                                    
GRANT UPDATE ON ITEM_MENSAL_PRE_COMP_ORC TO R_SICOF;                                                                    
GRANT DELETE ON ITEM_MOVIMENTACAO_CREDITO TO R_SICOF;                                                                   
GRANT INSERT ON ITEM_MOVIMENTACAO_CREDITO TO R_SICOF;                                                                   
GRANT SELECT ON ITEM_MOVIMENTACAO_CREDITO TO R_SICOF;                                                                   
GRANT UPDATE ON ITEM_MOVIMENTACAO_CREDITO TO R_SICOF;                                                                   
GRANT DELETE ON SALDO_QUANT_COMP TO R_SICOF;                                                                            
GRANT INSERT ON SALDO_QUANT_COMP TO R_SICOF;                                                                            
GRANT SELECT ON SALDO_QUANT_COMP TO R_SICOF;                                                                            
GRANT UPDATE ON SALDO_QUANT_COMP TO R_SICOF;                                                                            
GRANT DELETE ON SALDO_QUANT_PCOMP TO R_SICOF;                                                                           
GRANT INSERT ON SALDO_QUANT_PCOMP TO R_SICOF;                                                                           
GRANT SELECT ON SALDO_QUANT_PCOMP TO R_SICOF;                                                                           
GRANT UPDATE ON SALDO_QUANT_PCOMP TO R_SICOF;                                                                           
GRANT SELECT ON SEG_SISTEMA TO R_SICOF;                                                                                 
GRANT SELECT ON VW_ITEM_PROPOSTA_ORC_MENSAL TO R_SICOF;                                                                 

22 linhas selecionadas.

SQL> 
SQL> SPO OFF
