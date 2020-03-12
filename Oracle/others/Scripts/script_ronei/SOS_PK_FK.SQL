SPOOL C:\Sistemas\Sql\Infraero\Oracle\Scripts\script_ronei\SOS_PK_FK_PROD.LOG
--
ALTER TABLE IFRSRH.TAB_DESPESA_MEDICAMENTOS                                                                                         
drop constraint TDM_GUI_FK;                                                                                                         
--
ALTER TABLE IFRSRH.PEDIDOS_COBRANCAS                                                                                                
drop constraint PCO_FK;                                                                                                             
--
ALTER TABLE IFRSRH.HONORARIOS_MEDICOS                                                                                               
drop constraint HNM_GPR_FK;                                                                                                         
--
ALTER TABLE IFRSRH.GUIAS                                                                                                            
drop constraint GUI_DOC_FK;                                                                                                         
--
ALTER TABLE IFRSRH.DIVERSOS_MEDICAS_HOSPIT                                                                                          
drop constraint DMO_GUI_FK;                                                                                                         
--
ALTER TABLE IFRSRH.DESPESAS_MEDICAS_HOSPITALARES                                                                                    
drop constraint DMP_GUI_FK;                                                                                                         
--
ALTER TABLE IFRSRH.GUIAS_PROCEDIMENTOS                                                                                              
drop constraint GPR_GUI_FK;                                                                                                         

                                                                                                                                    

--### gera comando para criação da constraint primary key                                                                           
--ALTER TABLE IFRSRH.DIVERSOS_MEDICAS_HOSPIT                                                                                          
--drop constraint DMO_PK;                                                                                                             
--ALTER TABLE IFRSRH.DIVERSOS_MEDICAS_HOSPIT                                                                                          
--add constraint DMO_PK primary key                                                                                                   
--( DMO_SEQUENCIAL);                                                                                                                  
--ALTER TABLE IFRSRH.DESPESAS_MEDICAS_HOSPITALARES                                                                                    
--drop constraint DMP_PK;                                                                                                             
--ALTER TABLE IFRSRH.DESPESAS_MEDICAS_HOSPITALARES                                                                                    
--add constraint DMP_PK primary key                                                                                                   
--( DMP_SEQUENCIAL);
--                                                                                                                  
ALTER TABLE IFRSRH.DOCUMENTOS_COBRANCA                                                                                              
drop constraint DOC2_PK;
--                                                                                                            
ALTER TABLE IFRSRH.DOCUMENTOS_COBRANCA                                                                                              
add constraint DOC2_PK primary key                                                                                                  
( DOC_NUMERO,DOC_CBE_BEN_SIGLA,DOC_CBE_CRE_SEQUENCIAL,DOC_DEP_CODIGO);                                                                             
--
ALTER TABLE IFRSRH.GUIAS_PROCEDIMENTOS                                                                                              
drop constraint GPR_PK;                                                                                                             
--
ALTER TABLE IFRSRH.GUIAS_PROCEDIMENTOS                                                                                              
add constraint GPR_PK primary key                                                                                                   
( GPR_GUI_NUMERO,GPR_GUI_DOC_NUMERO,GPR_GUI_DOC_CBE_BEN_SIGLA,
  GPR_GUI_DOC_CBE_CRE_SEQUENCIAL,GPR_GUI_DOC_DEP_CODIGO,GPR_SEQUENCIAL);                       
--
ALTER TABLE IFRSRH.GUIAS                                                                                                            
drop constraint GUI_PK;                                                                                                             
--
ALTER TABLE IFRSRH.GUIAS                                                                                                            
add constraint GUI_PK primary key                                                                                                   
( GUI_NUMERO,GUI_DOC_NUMERO,GUI_DOC_CBE_BEN_SIGLA,GUI_DOC_CBE_CRE_SEQUENCIAL,
  GUI_DOC_DEP_CODIGO);                                                      
--
--ALTER TABLE IFRSRH.HONORARIOS_MEDICOS                                                                                               
--drop constraint HNM_PK;                                                                                                             
--ALTER TABLE IFRSRH.HONORARIOS_MEDICOS                                                                                               
--add constraint HNM_PK primary key                                                                                                   
--( HNM_SEQUENCIAL);                                                                                                                  
--
ALTER TABLE IFRSRH.PEDIDOS_COBRANCAS                                                                                                
drop constraint PCO_PK;                                                                                                             
--
ALTER TABLE IFRSRH.PEDIDOS_COBRANCAS                                                                                                
add constraint PCO_PK primary key                                                                                                   
( PCO_DOC_NUMERO,PCO_DOC_CBE_BEN_SIGLA,PCO_DOC_CBE_CRE_SEQUENCIAL,
  PCO_NUMERO_PEDIDO,PCO_DOC_DEP_CODIGO);                                               
--
--ALTER TABLE IFRSRH.TAB_DESPESA_MEDICAMENTOS                                                                                         
--drop constraint TDM_PK;                                                                                                             
--ALTER TABLE IFRSRH.TAB_DESPESA_MEDICAMENTOS                                                                                         
--add constraint TDM_PK primary key                                                                                                   
--( TDM_SEQUENCIAL);                                                                                                                  

                                                                                                                                    

--### gera comando para criação das constraints foreign key                                                                         
--ok
ALTER TABLE IFRSRH.DIVERSOS_MEDICAS_HOSPIT                                                                                          
add constraint DMO_GUI_FK foreign key                                                                                               
( DMO_GUI_NUMERO,DMO_GUI_DOC_NUMERO,DMO_GUI_DOC_CBE_BEN_SIGLA,
  DMO_GUI_DOC_CBE_CRE_SEQUENCIAL,DMO_GUI_DOC_DEP_CODIGO)                                       
references IFRSRH.GUIAS                                                                                                             
( GUI_NUMERO,GUI_DOC_NUMERO,GUI_DOC_CBE_BEN_SIGLA,
  GUI_DOC_CBE_CRE_SEQUENCIAL,GUI_DOC_DEP_CODIGO)  ;                                                    
--ok
ALTER TABLE IFRSRH.DESPESAS_MEDICAS_HOSPITALARES                                                                                    
add constraint DMP_GUI_FK foreign key                                                                                               
( DMP_GUI_NUMERO,DMP_GUI_DOC_NUMERO,DMP_GUI_DOC_CBE_BEN_SIGLA,
  DMP_GUI_DOC_CBE_CRE_SEQUENCIAL,DMP_GUI_DOC_DEP_CODIGO)                                       
references IFRSRH.GUIAS                                                                                                             
( GUI_NUMERO,GUI_DOC_NUMERO,GUI_DOC_CBE_BEN_SIGLA,
  GUI_DOC_CBE_CRE_SEQUENCIAL,GUI_DOC_DEP_CODIGO)  ;                                                    
--ok
ALTER TABLE IFRSRH.GUIAS_PROCEDIMENTOS                                                                                              
add constraint GPR_GUI_FK foreign key                                                                                               
( GPR_GUI_NUMERO,GPR_GUI_DOC_NUMERO,GPR_GUI_DOC_CBE_BEN_SIGLA,
  GPR_GUI_DOC_CBE_CRE_SEQUENCIAL,GPR_GUI_DOC_DEP_CODIGO)                                       
references IFRSRH.GUIAS                                                                                                             
( GUI_NUMERO,GUI_DOC_NUMERO,GUI_DOC_CBE_BEN_SIGLA,
  GUI_DOC_CBE_CRE_SEQUENCIAL,GUI_DOC_DEP_CODIGO)  ;                                                    
--ok
ALTER TABLE IFRSRH.GUIAS                                                                                                            
add constraint GUI_DOC_FK foreign key                                                                                               
( GUI_DOC_NUMERO,GUI_DOC_CBE_BEN_SIGLA,GUI_DOC_CBE_CRE_SEQUENCIAL,
  GUI_DOC_DEP_CODIGO)                                                                  
references IFRSRH.DOCUMENTOS_COBRANCA                                                                                               
( DOC_NUMERO,DOC_CBE_BEN_SIGLA,DOC_CBE_CRE_SEQUENCIAL,
  DOC_DEP_CODIGO)  ;                                                                           
--ok
ALTER TABLE IFRSRH.HONORARIOS_MEDICOS                                                                                               
add constraint HNM_GPR_FK foreign key                                                                                               
( HNM_GPR_GUI_NUMERO,HNM_GPR_GUI_DOC_NUMERO,HNM_GPR_GUI_DOC_CBE_BEN_SIGLA,
  HNM_GPR_GUI_DOC_CBE_CRE_SEQ,HNM_GPR_GUI_DOC_DEP_CODIGO,HNM_GPR_SEQUENCIAL)           
references IFRSRH.GUIAS_PROCEDIMENTOS                                                                                               
( GPR_GUI_NUMERO,GPR_GUI_DOC_NUMERO,GPR_GUI_DOC_CBE_BEN_SIGLA,
  GPR_GUI_DOC_CBE_CRE_SEQUENCIAL,GPR_GUI_DOC_DEP_CODIGO,GPR_SEQUENCIAL)  ;                     
--ok
ALTER TABLE IFRSRH.PEDIDOS_COBRANCAS                                                                                                
add constraint PCO_DOC_FK foreign key                                                                                                   
( PCO_DOC_NUMERO,PCO_DOC_CBE_BEN_SIGLA,PCO_DOC_CBE_CRE_SEQUENCIAL,
  PCO_DOC_DEP_CODIGO)                                                                  
references IFRSRH.DOCUMENTOS_COBRANCA                                                                                               
( DOC_NUMERO,DOC_CBE_BEN_SIGLA,DOC_CBE_CRE_SEQUENCIAL,
  DOC_DEP_CODIGO)  ;                                                                           
--ok
ALTER TABLE IFRSRH.TAB_DESPESA_MEDICAMENTOS                                                                                         
add constraint TDM_GUI_FK foreign key                                                                                               
( TDM_GUI_NUMERO,TDM_GUI_DOC_NUMERO,TDM_GUI_DOC_CBE_BEN_SIGLA,
  TDM_GUI_DOC_CBE_CRE_SEQUENCIAL,TDM_GUI_DOC_DEP_CODIGO)                                       
references IFRSRH.GUIAS                                                                                                             
( GUI_NUMERO,GUI_DOC_NUMERO,GUI_DOC_CBE_BEN_SIGLA,
  GUI_DOC_CBE_CRE_SEQUENCIAL,GUI_DOC_DEP_CODIGO)  ;                                                    
