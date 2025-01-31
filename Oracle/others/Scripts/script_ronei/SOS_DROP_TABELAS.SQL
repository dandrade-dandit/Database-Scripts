
*** SEQUENCIA DE COMANDOS A SEREM OBSERVADOS/EXECUTADOS *** QUANDO DO DROP DE UMA TABELA. ***                                       
*** ==> alguns comandos precisam ser completados (senhas) ***                                                                       
                                                                                                                                    

                                                                                                                                    

--### gera comando para o export                                                                                                    

HOST exp73 userid=SYSMAN/xxxxx tables=TABELAS file=q:\scripts\SYSMAN_TABELAS.dmp log=q:\scripts\exp_TABELAS.log                     

                                                                                                                                    

--### gera comando para o import                                                                                                    

HOST imp73 userid=SYSMAN/xxxxx ignore=y commit=y file=q:\scripts\SYSMAN_TABELAS.dmp log=q:\scripts\imp_TABELAS.log                  

                                                                                                                                    

--### gera comando para cria��o e inser��o dos dados em uma tabela auxiliar                                                         

create table SYSMAN.AUX_TABELAS as select * from SYSMAN.TABELAS;                                                                    

                                                                                                                                    

--### gera comando de carga, a partir da tabela auxiliar (coluna x coluna)                                                          
INSERT INTO SYSMAN.TABELAS                                                                                                          
( APLICACAO                                                                                                                         
,TABELA                                                                                                                             
,OWNER                                                                                                                              
,TIPO                                                                                                                               
)                                                                                                                                   
select                                                                                                                              
APLICACAO                                                                                                                           
,TABELA                                                                                                                             
,OWNER                                                                                                                              
,TIPO                                                                                                                               
from SYSMAN.AUX_TABELAS;                                                                                                            

                                                                                                                                    

--### gera comando para dele��o das constraints que se referenciam                                                                  

                                                                                                                                    

--### gera comando para cria��o da tabela                                                                                           
CREATE TABLE SYSMAN.TABELAS (                                                                                                       
APLICACAO VARCHAR2(10)                                                                                                              
,TABELA VARCHAR2(30)                                                                                                                
,OWNER VARCHAR2(30)                                                                                                                 
,TIPO VARCHAR2(15)                                                                                                                  
);                                                                                                                                  

                                                                                                                                    

--### gera comando para cria��o da constraint primary key                                                                           
ALTER TABLE SYSMAN.TABELAS                                                                                                          
add constraint TABELAS_PK primary key                                                                                               
( APLICACAO,TIPO,TABELA,OWNER);                                                                                                     

                                                                                                                                    

--### gera comando para cria��o das constraints foreign key                                                                         

                                                                                                                                    

--### gera comando para cria��o das constraints DEFAULT                                                                             

                                                                                                                                    

--### gera comando para cria��o das constraints unique                                                                              

                                                                                                                                    

--### gera comando para cria��o das constraints check                                                                               

ALTER TABLE SYSMAN.TABELAS                                                add constraint CHK_OWNER                      check (     
OWNER IS NOT NULL                                                                );                                                 
                                                                                                                                    

                                                                                                                                    

--### gera comando para atribui��o dos privilegios de acesso                                                                        

GRANT SELECT on SYSMAN.TABELAS                                                                                                      
 to IFR_DESENV;                                                                                                                     
                                                                                                                                    
GRANT DELETE on SYSMAN.TABELAS                                                                                                      
 to SYS;                                                                                                                            
                                                                                                                                    
GRANT INSERT on SYSMAN.TABELAS                                                                                                      
 to SYS;                                                                                                                            
                                                                                                                                    
GRANT SELECT on SYSMAN.TABELAS                                                                                                      
 to SYS;                                                                                                                            
                                                                                                                                    
GRANT UPDATE on SYSMAN.TABELAS                                                                                                      
 to SYS;                                                                                                                            
                                                                                                                                    

                                                                                                                                    

--### gera comando para cria��o dos indices                                                                                         
CREATE UNIQUE INDEX TABELAS_PK                                                                                                      
ON SYSMAN.TABELAS                                                                                                                   
( APLICACAO,TIPO,TABELA,OWNER)                                                                                                      
TABLESPACE TOOLS;                                                                                                                   

                                                                                                                                    

--### gera comando para cria��o das constraints que se referenciam                                                                  
DECLARE
*
ERROR at line 1: 
ORA-00000: normal, successful completion 



                                                                                                                                    

--### gera comando para cria��o do sinonimo                                                                                         

                                                                                                                                    

--### gera comando para cria��o das triggers                                                                                        
