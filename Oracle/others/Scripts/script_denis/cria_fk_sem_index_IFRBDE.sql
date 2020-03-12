set feedback on                                                                                                                     
set verify on                                                                                                                       
set echo on                                                                                                                         
--*******************************************************                                                                           
-- TAB(CAD_PAGAMENTO_CONTRATO): 851200  TAB REF(TAB_TIPO_RECURSO_ITEM): 4704                                                        
create index CAD_PAGAMENTO_CONTRATO_02_FK on IFRBDE.CAD_PAGAMENTO_CONTRATO                                                          
(COD_RECURSO)                                                                                                                       
Tablespace TSD_INDICE;                                                                                                              
--*******************************************************                                                                           
-- TAB(CAD_RESUMO_VALORES): 234576  TAB REF(TAB_CONTRATO): 993452                                                                   
create index CAD_RESUMO_VALORES_01_FK on IFRBDE.CAD_RESUMO_VALORES                                                                  
(NUM_SEQ_CONTRATO_RES)                                                                                                              
Tablespace TSD_INDICE;                                                                                                              
--*******************************************************                                                                           
-- TAB(TAB_CARENCIA): 1638520  TAB REF(TAB_ETAPA_OBRA): 551                                                                         
create index TAB_CARENCIA_01_FK on IFRBDE.TAB_CARENCIA                                                                              
(CRE_ETP_COD)                                                                                                                       
Tablespace TSD_INDICE;                                                                                                              
--*******************************************************                                                                           
-- TAB(TAB_CARENCIA): 1638520  TAB REF(TAB_NATUREZA_OBRA_FIL): 180                                                                  
create index TAB_CARENCIA_02_FK on IFRBDE.TAB_CARENCIA                                                                              
(CRE_NTF_COD)                                                                                                                       
Tablespace TSD_INDICE;                                                                                                              
--*******************************************************                                                                           
-- TAB(TAB_CARENCIA): 1638520  TAB REF(TAB_OBRAS_TIPOS): 126                                                                        
create index TAB_CARENCIA_03_FK on IFRBDE.TAB_CARENCIA                                                                              
(CRE_TIPO_OBRA_COD)                                                                                                                 
Tablespace TSD_INDICE;                                                                                                              
--*******************************************************                                                                           
-- TAB(TAB_CARENCIA): 1638520  TAB REF(CAD_RESPONSAVEIS): 33512                                                                     
create index TAB_CARENCIA_04_FK on IFRBDE.TAB_CARENCIA                                                                              
(NUM_SEQ_PESSOAL_CARENCIA)                                                                                                          
Tablespace TSD_INDICE;                                                                                                              
--*******************************************************                                                                           
-- TAB(TAB_CONT_CRONO_PAGAMENTO): 651508  TAB REF(TAB_TIPO_RECURSO_ITEM): 4704                                                      
create index TAB_CONT_CRONO_PAG_01_FK on IFRBDE.TAB_CONT_CRONO_PAGAMENTO                                                            
(CCP_RTI_COD)                                                                                                                       
Tablespace TSD_INDICE;                                                                                                              
--*******************************************************                                                                           
-- TAB(TAB_CONT_CRONO_PAGAMENTO): 651508  TAB REF(CAD_RESUMO_VALORES): 234576                                                       
create index TAB_CONT_CRONO_PAG_02_FK on IFRBDE.TAB_CONT_CRONO_PAGAMENTO                                                            
(NUM_SEQ_CONTRATO_CRON)                                                                                                             
Tablespace TSD_INDICE;                                                                                                              
--*******************************************************                                                                           
-- TAB(TAB_CONTRATO): 993452  TAB REF(CAD_RESPONSAVEIS): 33512                                                                      
create index TAB_CONTRATO_01_FK on IFRBDE.TAB_CONTRATO                                                                              
(NUM_SEQ_GESTOR)                                                                                                                    
Tablespace TSD_INDICE;                                                                                                              
--*******************************************************                                                                           
-- TAB(TAB_CONTRATO): 993452  TAB REF(CAD_RESPONSAVEIS): 33512                                                                      
create index TAB_CONTRATO_02_FK on IFRBDE.TAB_CONTRATO                                                                              
(NUM_SEQ_ASSINATURA_1)                                                                                                              
Tablespace TSD_INDICE;                                                                                                              
--*******************************************************                                                                           
-- TAB(TAB_CONTRATO): 993452  TAB REF(CAD_RESPONSAVEIS): 33512                                                                      
create index TAB_CONTRATO_03_FK on IFRBDE.TAB_CONTRATO                                                                              
(NUM_SEQ_ASSINATURA_2)                                                                                                              
Tablespace TSD_INDICE;                                                                                                              
--*******************************************************                                                                           
-- TAB(TAB_MOV_DOTACAO): 136488  TAB REF(TAB_DEPENDENCIA_PAI): 405                                                                  
create index TAB_MOV_DOTACAO_01_FK on IFRBDE.TAB_MOV_DOTACAO                                                                        
(MDT_DPP_DEST)                                                                                                                      
Tablespace TSD_INDICE;                                                                                                              
--*******************************************************                                                                           
-- TAB(TAB_MOV_DOTACAO): 136488  TAB REF(TAB_DEPENDENCIA_PAI): 405                                                                  
create index TAB_MOV_DOTACAO_02_FK on IFRBDE.TAB_MOV_DOTACAO                                                                        
(MDT_DPP_ORIG)                                                                                                                      
Tablespace TSD_INDICE;                                                                                                              
--*******************************************************                                                                           
-- TAB(TAB_MOV_DOTACAO): 136488  TAB REF(TAB_TIPO_RECURSO_ITEM): 4704                                                               
create index TAB_MOV_DOTACAO_03_FK on IFRBDE.TAB_MOV_DOTACAO                                                                        
(MDT_RTI_COD_DEST)                                                                                                                  
Tablespace TSD_INDICE;                                                                                                              
--*******************************************************                                                                           
-- TAB(TAB_REC_APROVADO): 362112  TAB REF(TAB_TIPO_RECURSO_ITEM): 4704                                                              
create index TAB_REC_APROVADO_02_FK on IFRBDE.TAB_REC_APROVADO                                                                      
(RAP_RTI_COD)                                                                                                                       
Tablespace TSD_INDICE;                                                                                                              
--*******************************************************                                                                           
-- TAB(TAB_REMANEJAMENTO): 320544  TAB REF(TAB_CARENCIA): 1638520                                                                   
create index TAB_REMANEJAMENTO_01_FK on IFRBDE.TAB_REMANEJAMENTO                                                                    
(RMJ_SEQ_DEST)                                                                                                                      
Tablespace TSD_INDICE;                                                                                                              
--*******************************************************                                                                           
-- TAB(TAB_REMANEJAMENTO): 320544  TAB REF(TAB_CARENCIA): 1638520                                                                   
create index TAB_REMANEJAMENTO_02_FK on IFRBDE.TAB_REMANEJAMENTO                                                                    
(RMJ_SEQ_ORIG)                                                                                                                      
Tablespace TSD_INDICE;                                                                                                              
--*******************************************************                                                                           
-- TAB(TAB_REMANEJAMENTO): 320544  TAB REF(TAB_TIPO_RECURSO_ITEM): 4704                                                             
create index TAB_REMANEJAMENTO_03_FK on IFRBDE.TAB_REMANEJAMENTO                                                                    
(RMJ_RTI_COD_DEST)                                                                                                                  
Tablespace TSD_INDICE;                                                                                                              
--*******************************************************                                                                           
-- TAB(TAB_REMANEJAMENTO): 320544  TAB REF(TAB_TIPO_RECURSO_ITEM): 4704                                                             
create index TAB_REMANEJAMENTO_04_FK on IFRBDE.TAB_REMANEJAMENTO                                                                    
(RMJ_RTI_COD_ORIG)                                                                                                                  
Tablespace TSD_INDICE;                                                                                                              
