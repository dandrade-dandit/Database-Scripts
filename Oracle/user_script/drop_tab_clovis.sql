DROP PUBLIC SYNONYM SS_LOTE_PORTADOR
/                                     
                                      
DROP PUBLIC SYNONYM SS_PORTADOR 
/       

DELETE FROM TABELAS
WHERE TABELA = 'SS_LOTE_PORTADOR'
/

DELETE FROM TABELAS
WHERE TABELA = 'SS_PORTADOR'
/    

DROP TABLE SS_LOTE_PORTADOR                      
/

DROP TABLE SS_PORTADOR
/