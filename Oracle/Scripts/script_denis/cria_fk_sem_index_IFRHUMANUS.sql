set feedback on                                                                                                                     
set verify on                                                                                                                       
set echo on                                                                                                                         
--*******************************************************                                                                           
-- TAB(TRN_EVENTO_PARTICIP): 956208  TAB REF(CENTRO_CUSTO): 16416                                                                   
create index FK_EVP_CT_CUSTO on IFRHUMANUS.TRN_EVENTO_PARTICIP                                                                      
(EVPCD_CENTRO_CUSTO)                                                                                                                
Tablespace TSD_INDICE;                                                                                                              
--*******************************************************                                                                           
-- TAB(TRN_EVENTO_PARTICIP): 956208  TAB REF(TRN_TP_PESSOA): 104                                                                    
create index SYS_C0019105 on IFRHUMANUS.TRN_EVENTO_PARTICIP                                                                         
(EVPTPPCODTIPOPESSOA)                                                                                                               
Tablespace TSD_INDICE;                                                                                                              
--*******************************************************                                                                           
-- TAB(TRN_EVENTO_PARTICIP): 956208  TAB REF(TRN_SITUACAO): 65                                                                      
create index SYS_C0019106 on IFRHUMANUS.TRN_EVENTO_PARTICIP                                                                         
(EVPSITCODSITUACAO)                                                                                                                 
Tablespace TSD_INDICE;                                                                                                              
--*******************************************************                                                                           
-- TAB(TRN_EVENTO_PARTICIP): 956208  TAB REF(TRN_CONCEITO): 190                                                                     
create index SYS_C0019107 on IFRHUMANUS.TRN_EVENTO_PARTICIP                                                                         
(EVPCONCODCONCEITO,EVPCONESCCODIGO)                                                                                                 
Tablespace TSD_INDICE;                                                                                                              
--*******************************************************                                                                           
-- TAB(TRN_EVENTO_PARTICIP): 956208  TAB REF(TRN_PESSOA): 65888                                                                     
create index SYS_C0020101 on IFRHUMANUS.TRN_EVENTO_PARTICIP                                                                         
(EVPTPPCODTIPOPESSOA,EVPPESCODPESSOA)                                                                                               
Tablespace TSD_INDICE;                                                                                                              
