
 set echo oN                                                                                                                        

 set HEADING ON                                                                                                                     

 set verify oN                                                                                                                      

 SET FEEDBACK ON                                                                                                                    

CONNECT ifrselo@PRODSEDE;                                                                                                           

 set echo oFF                                                                                                                       

create table LOG_HST_LEITURA_SELOS as                         
select * from HST_LEITURA_SELOS where rowid is null;  

alter table LOG_HST_LEITURA_SELOS add dt_geracao date default SYSDATE;                                                      

alter table LOG_HST_LEITURA_SELOS add tp_geracao varchar2(1);                                                               

alter table LOG_HST_LEITURA_SELOS add quem_gerou varchar2(20); 

alter table LOG_HST_LEITURA_SELOS add estacao varchar2(30); 

alter table LOG_HST_LEITURA_SELOS add conta_rede varchar2(30); 
                                                            
CREATE OR REPLACE TRIGGER AFT_IU_HST_LEITURA_SELOS                                                                                 
AFTER INSERT  OR UPDATE                                                                                                  
ON HST_LEITURA_SELOS                                                                                                        
REFERENCING NEW AS NEW OLD AS OLD                                                                                                   
FOR EACH ROW
DECLARE
	USER_MACHINE VARCHAR(30); 
	OS_USER VARCHAR(30);                                                                                                                       
BEGIN

SELECT 	SYS_CONTEXT ('USERENV', 'HOST')  USER_MACHINE
,	SYS_CONTEXT ('USERENV', 'OS_USER')  OS_USER
INTO   	USER_MACHINE, OS_USER
FROM 	DUAL;
                                                                                                                               
IF INSERTING AND :new.COD_MOTIVO IN (1,3,4,5,7,9) THEN                                                                                                            
INSERT INTO LOG_HST_LEITURA_SELOS (                                                                                                 
SERIE_SELO                                                                                                                          
,NUM_SELO                                                                                                                           
,COD_MOTIVO                                                                                                                         
,DAT_LEITURA_SELO                                                                                                                   
,DEP_CODIGO_LEITURA                                                                                                                 
,DT_FECHAMENTO                                                                                                                      
,COD_PAGAMENTO                                                                                                                      
,tp_geracao                                                                                                                         
,quem_gerou
,estacao
,conta_rede                                                                                                                        
)                                                                                                                                   
values (                                                                                                                            
:new.SERIE_SELO                                                                                                                     
,:new.NUM_SELO                                                                                                                      
,:new.COD_MOTIVO                                                                                                                    
,:new.DAT_LEITURA_SELO                                                                                                              
,:new.DEP_CODIGO_LEITURA                                                                                                            
,:new.DT_FECHAMENTO                                                                                                                 
,:new.COD_PAGAMENTO                                                                                                                 
,'I'                                                                                                                                
,user             
,USER_MACHINE
,OS_USER                                                                                                             
);                                                                                                                                  
end if;                                                                                                                             
IF UPDATING THEN                                                                                                                    
INSERT INTO LOG_HST_LEITURA_SELOS (                                                                                                 
SERIE_SELO                                                                                                                          
,NUM_SELO                                                                                                                           
,COD_MOTIVO                                                                                                                         
,DAT_LEITURA_SELO                                                                                                                   
,DEP_CODIGO_LEITURA                                                                                                                 
,DT_FECHAMENTO                                                                                                                      
,COD_PAGAMENTO                                                                                                                      
,tp_geracao                                                                                                                         
,quem_gerou  
,estacao
,conta_rede                                                                                                                       
)                                                                                                                                   
values (                                                                                                                            
:old.SERIE_SELO                                                                                                                     
,:old.NUM_SELO                                                                                                                      
,:old.COD_MOTIVO                                                                                                                    
,:old.DAT_LEITURA_SELO                                                                                                              
,:old.DEP_CODIGO_LEITURA                                                                                                            
,:old.DT_FECHAMENTO                                                                                                                 
,:old.COD_PAGAMENTO                                                                                                                 
,'U'                                                                                                                                
,user
,USER_MACHINE                                                                                                                             
,OS_USER
);                                                                                                                                  
end if;                                                                                                                             
END;                                                                                                                                
/                                                                                                                                   
