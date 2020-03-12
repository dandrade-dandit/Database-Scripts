set feedback on                                                                                                                     
set verify on                                                                                                                       
set echo on                                                                                                                         
--*******************************************************                                                                           
-- TAB(ITEM_PROPOSTA_ORC_SIMULADA): 897367644  TAB REF(CENTRO_CUSTO): 19936                                                         
create index IDX_IPOS_CC_FK on IFRSICOF.ITEM_PROPOSTA_ORC_SIMULADA                                                                  
(CC2_CD_CENTRO_CUSTO_GEST)                                                                                                          
Tablespace TSD_INDICE;                                                                                                              
--*******************************************************                                                                           
-- TAB(ITEM_PROPOSTA_ORC_SIMULADA): 897367644  TAB REF(DEPENDENCIAS): 50128                                                         
create index IDX_IPOS_DEP_FK on IFRSICOF.ITEM_PROPOSTA_ORC_SIMULADA                                                                 
(DEP_CD_DEPENDENCIA_GEST)                                                                                                           
Tablespace TSD_INDICE;                                                                                                              
--*******************************************************                                                                           
-- TAB(ITEM_PROPOSTA_ORC_SIMULADA): 897367644  TAB REF(CENTRO_CUSTO): 19936                                                         
create index IDX_IPS_CC2_FK on IFRSICOF.ITEM_PROPOSTA_ORC_SIMULADA                                                                  
(CC2_CD_CENTRO_CUSTO)                                                                                                               
Tablespace TSD_INDICE;                                                                                                              
--*******************************************************                                                                           
-- TAB(ITEM_PROPOSTA_ORC_SIMULADA): 897367644  TAB REF(CENTRO_CUSTO): 19936                                                         
create index IDX_IPS_CC2_GERD_FK on IFRSICOF.ITEM_PROPOSTA_ORC_SIMULADA                                                             
(CC2_CD_CENTRO_CUSTO_GERD)                                                                                                          
Tablespace TSD_INDICE;                                                                                                              
--*******************************************************                                                                           
-- TAB(ITEM_PROPOSTA_ORC_SIMULADA): 897367644  TAB REF(DEPENDENCIAS): 50128                                                         
create index IDX_IPS_DEP_FK on IFRSICOF.ITEM_PROPOSTA_ORC_SIMULADA                                                                  
(DEP_CD_DEPENDENCIA)                                                                                                                
Tablespace TSD_INDICE;                                                                                                              
--*******************************************************                                                                           
-- TAB(ITEM_PROPOSTA_ORC_SIMULADA): 897367644  TAB REF(DEPENDENCIAS): 50128                                                         
create index IDX_IPS_DEP_GERD_FK on IFRSICOF.ITEM_PROPOSTA_ORC_SIMULADA                                                             
(DEP_CD_DEPENDENCIA_GERD)                                                                                                           
Tablespace TSD_INDICE;                                                                                                              
--*******************************************************                                                                           
-- TAB(ITEM_PROPOSTA_ORC_SIMULADA): 897367644  TAB REF(FORNECEDOR): 7752600                                                         
create index IDX_IPS_FOR_FK on IFRSICOF.ITEM_PROPOSTA_ORC_SIMULADA                                                                  
(FF_NR_CGC_CPF)                                                                                                                     
Tablespace TSD_INDICE;                                                                                                              
--*******************************************************                                                                           
-- TAB(ITEM_PROPOSTA_ORC_SIMULADA): 897367644  TAB REF(GRUPO_PATRIMONIAL): 69036                                                    
create index IDX_IPS_GP_FK on IFRSICOF.ITEM_PROPOSTA_ORC_SIMULADA                                                                   
(GP_CD_GRUPO)                                                                                                                       
Tablespace TSD_INDICE;                                                                                                              
--*******************************************************                                                                           
-- TAB(ITEM_PROPOSTA_ORC_SIMULADA): 897367644  TAB REF(PROGRAMA_ORCAMENTARIO): 216                                                  
create index IDX_IPS_PO_FK on IFRSICOF.ITEM_PROPOSTA_ORC_SIMULADA                                                                   
(PO_CD_PROGRAMA)                                                                                                                    
Tablespace TSD_INDICE;                                                                                                              
--*******************************************************                                                                           
-- TAB(ITEM_PROPOSTA_ORC_SIMULADA): 897367644  TAB REF(PROJETO): 600                                                                
create index IDX_IPS_PRJ_FK on IFRSICOF.ITEM_PROPOSTA_ORC_SIMULADA                                                                  
(PRJ_CD_PROJETO)                                                                                                                    
Tablespace TSD_INDICE;                                                                                                              
--*******************************************************                                                                           
-- TAB(MOVIMENTO_OPERACIONAL): 317184  TAB REF(CONTA_CONTABIL): 485100                                                              
create index IDX_MOP_CC1_FK on IFRSICOF.MOVIMENTO_OPERACIONAL                                                                       
(CC1_NR_CONTA)                                                                                                                      
Tablespace TSD_INDICE;                                                                                                              
--*******************************************************                                                                           
-- TAB(ORC_CONSOL_ANA_CONTA): 146640  TAB REF(CONTA_CONTABIL): 485100                                                               
create index IDX_OCAC_CC1_FK on IFRSICOF.ORC_CONSOL_ANA_CONTA                                                                       
(CC1_NR_CONTA)                                                                                                                      
Tablespace TSD_INDICE;                                                                                                              
--*******************************************************                                                                           
-- TAB(PROJECAO_RECEITA_SIMULADA): 5902352  TAB REF(CONTA_CONTABIL): 485100                                                         
create index IDX_PRS_CC1_FK on IFRSICOF.PROJECAO_RECEITA_SIMULADA                                                                   
(CC1_NR_CONTA)                                                                                                                      
Tablespace TSD_INDICE;                                                                                                              
--*******************************************************                                                                           
-- TAB(PROJECAO_RECEITA_SIMULADA): 5902352  TAB REF(DEPENDENCIAS): 50128                                                            
create index IDX_PRS_DEP_FK on IFRSICOF.PROJECAO_RECEITA_SIMULADA                                                                   
(DEP_CD_DEPENDENCIA)                                                                                                                
Tablespace TSD_INDICE;                                                                                                              
--*******************************************************                                                                           
-- TAB(PROJECAO_RECEITA_SIMULADA): 5902352  TAB REF(TIPO_AJUSTE_REGIME_CAIXA): 936                                                  
create index IDX_PRS_TAR_FK on IFRSICOF.PROJECAO_RECEITA_SIMULADA                                                                   
(TAR_CD_REGIME)                                                                                                                     
Tablespace TSD_INDICE;                                                                                                              
