set feedback on                                                                                                                     
set verify on                                                                                                                       
set echo on                                                                                                                         
--*******************************************************                                                                           
-- TAB(OCORRENCIA_SGS): 204920  TAB REF(ACAO_IMEDIATA_SGS): 0                                                                       
create index ACIMDT_OCRRNC on IFRVGA.OCORRENCIA_SGS                                                                                 
(COD_ACIMDT)                                                                                                                        
Tablespace TSD_INDICE;                                                                                                              
--*******************************************************                                                                           
-- TAB(OCORRENCIA_SGS): 204920  TAB REF(CAUSAS_SGS): 255                                                                            
create index CAUSAS_OCRRNC on IFRVGA.OCORRENCIA_SGS                                                                                 
(COD_CAUSA)                                                                                                                         
Tablespace TSD_INDICE;                                                                                                              
--*******************************************************                                                                           
-- TAB(OCORRENCIA_SGS): 204920  TAB REF(ESTABELECIMENTO): 0                                                                         
create index ESTBLC_OCRRNC on IFRVGA.OCORRENCIA_SGS                                                                                 
(NUM_EMPRESA,NUM_ESTABELEC)                                                                                                         
Tablespace TSD_INDICE;                                                                                                              
--*******************************************************                                                                           
-- TAB(OCORRENCIA_SGS): 204920  TAB REF(ESTRUTURA_FISICA_SGS): 1265                                                                 
create index ESTFIS_OCRRNC on IFRVGA.OCORRENCIA_SGS                                                                                 
(NUM_SQNCIA_ESTFIS)                                                                                                                 
Tablespace TSD_INDICE;                                                                                                              
--*******************************************************                                                                           
-- TAB(OCORRENCIA_SGS): 204920  TAB REF(LOCAL_RISCO_SGS): 2800                                                                      
create index LCRRSA_OCRRNC on IFRVGA.OCORRENCIA_SGS                                                                                 
(NUM_SQNLCR_RSANOC)                                                                                                                 
Tablespace TSD_INDICE;                                                                                                              
--*******************************************************                                                                           
-- TAB(OCORRENCIA_SGS): 204920  TAB REF(LOCAL_RISCO_SGS): 2800                                                                      
create index LOCRSC_OCRRNC on IFRVGA.OCORRENCIA_SGS                                                                                 
(NUM_SQNCIA_LOCRSC)                                                                                                                 
Tablespace TSD_INDICE;                                                                                                              
--*******************************************************                                                                           
-- TAB(OCORRENCIA_SGS): 204920  TAB REF(LISTA_DOC_EXTERNO_SGS): 36                                                                  
create index LSTDOC_OCRRNC on IFRVGA.OCORRENCIA_SGS                                                                                 
(NUM_LSTDOC)                                                                                                                        
Tablespace TSD_INDICE;                                                                                                              
--*******************************************************                                                                           
-- TAB(OCORRENCIA_SGS): 204920  TAB REF(MELHORIAS_SGS): 91                                                                          
create index MLHRIA_OCRRNC on IFRVGA.OCORRENCIA_SGS                                                                                 
(COD_MLHRIA)                                                                                                                        
Tablespace TSD_INDICE;                                                                                                              
--*******************************************************                                                                           
-- TAB(OCORRENCIA_SGS): 204920  TAB REF(PESO_GRAVIDADE_SGS): 55                                                                     
create index PESGRV_OCRRNC on IFRVGA.OCORRENCIA_SGS                                                                                 
(VLR_PESGRV)                                                                                                                        
Tablespace TSD_INDICE;                                                                                                              
--*******************************************************                                                                           
-- TAB(OCORRENCIA_SGS): 204920  TAB REF(PROBABILIDADE_REPETICAO_SGS): 0                                                             
create index PRBRPT_OCRRNC on IFRVGA.OCORRENCIA_SGS                                                                                 
(COD_PRBRPT)                                                                                                                        
Tablespace TSD_INDICE;                                                                                                              
--*******************************************************                                                                           
-- TAB(OCORRENCIA_SGS): 204920  TAB REF(RESPONSAVEL_SGS): 672                                                                       
create index RSANOC_OCRRNC on IFRVGA.OCORRENCIA_SGS                                                                                 
(NOM_CHAVE_RSANOC)                                                                                                                  
Tablespace TSD_INDICE;                                                                                                              
--*******************************************************                                                                           
-- TAB(OCORRENCIA_SGS): 204920  TAB REF(RESPONSAVEL_SGS): 672                                                                       
create index RSPNSV_OCRRNC on IFRVGA.OCORRENCIA_SGS                                                                                 
(NOM_CHAVE_RSPNSV)                                                                                                                  
Tablespace TSD_INDICE;                                                                                                              
--*******************************************************                                                                           
-- TAB(OCORRENCIA_SGS): 204920  TAB REF(RESPONSAVEL_SGS): 672                                                                       
create index RSPREG_OCRRNC on IFRVGA.OCORRENCIA_SGS                                                                                 
(NOM_CHAVE_RSPREG)                                                                                                                  
Tablespace TSD_INDICE;                                                                                                              
--*******************************************************                                                                           
-- TAB(OCORRENCIA_SGS): 204920  TAB REF(EMPRESA_GRUPO): 0                                                                           
create index R_544 on IFRVGA.OCORRENCIA_SGS                                                                                         
(NUM_EMPRESA)                                                                                                                       
Tablespace TSD_INDICE;                                                                                                              
--*******************************************************                                                                           
-- TAB(OCORRENCIA_SGS): 204920  TAB REF(UNIDADE_FUNCIONAL): 0                                                                       
create index R_545 on IFRVGA.OCORRENCIA_SGS                                                                                         
(NUM_UNIDADE)                                                                                                                       
Tablespace TSD_INDICE;                                                                                                              
--*******************************************************                                                                           
-- TAB(OCORRENCIA_SGS): 204920  TAB REF(CELULA_SAP): 0                                                                              
create index R_546 on IFRVGA.OCORRENCIA_SGS                                                                                         
(NUM_CELULA)                                                                                                                        
Tablespace TSD_INDICE;                                                                                                              
--*******************************************************                                                                           
-- TAB(OCORRENCIA_SGS): 204920  TAB REF(TIPO_SEGURO_SGS): 39                                                                        
create index TIPSEG_OCRRNC on IFRVGA.OCORRENCIA_SGS                                                                                 
(COD_TIPSEG)                                                                                                                        
Tablespace TSD_INDICE;                                                                                                              
--*******************************************************                                                                           
-- TAB(OCORRENCIA_SGS): 204920  TAB REF(TIPO_OCORRENCIA_SGS): 36                                                                    
create index TPOCRR_OCRRNC on IFRVGA.OCORRENCIA_SGS                                                                                 
(COD_TPOCRR)                                                                                                                        
Tablespace TSD_INDICE;                                                                                                              
--*******************************************************                                                                           
-- TAB(OCORRENCIA_SGS): 204920  TAB REF(UNIDADE_MONETARIA_SGS): 60                                                                  
create index UM_OCRRNC on IFRVGA.OCORRENCIA_SGS                                                                                     
(COD_UM)                                                                                                                            
Tablespace TSD_INDICE;                                                                                                              
--*******************************************************                                                                           
-- TAB(OCORRENCIA_SGS): 204920  TAB REF(USUARIO_UNIDADE_SGS): 0                                                                     
create index USRUND_REGOCR on IFRVGA.OCORRENCIA_SGS                                                                                 
(NUM_SQNCIA_REGOCR)                                                                                                                 
Tablespace TSD_INDICE;                                                                                                              
--*******************************************************                                                                           
-- TAB(OCORRENCIA_SGS): 204920  TAB REF(USUARIO_UNIDADE_SGS): 0                                                                     
create index USRUND_RSPOCR on IFRVGA.OCORRENCIA_SGS                                                                                 
(NUM_SQNCIA_RSPOCR)                                                                                                                 
Tablespace TSD_INDICE;                                                                                                              
--*******************************************************                                                                           
-- TAB(SEGURADO_SGS): 151536  TAB REF(LOCAL_RISCO_SGS): 2800                                                                        
create index LOCRSC_SEGRDO on IFRVGA.SEGURADO_SGS                                                                                   
(NUM_SQNCIA_LOCRSC)                                                                                                                 
Tablespace TSD_INDICE;                                                                                                              
