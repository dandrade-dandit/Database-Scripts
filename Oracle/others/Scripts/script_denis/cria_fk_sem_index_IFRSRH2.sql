set feedback on                                                                                                                     
set verify on                                                                                                                       
set echo on                                                                                                                         
--*******************************************************                                                                           
-- TAB(AMB): 747000  TAB REF(ESPECIALIDADES): 47360                                                                                 
create index IDX_AMB_ESP_TIPO_FK on IFRSRH2.AMB                                                                                     
(AMB_ESP_TIPO,AMB_ESP_NUMERO)                                                                                                       
Tablespace TSD_INDICE;                                                                                                              
--*******************************************************                                                                           
-- TAB(AMB): 747000  TAB REF(PORTES_ANESTESICOS): 108                                                                               
create index IDX_PORTE_ANESTESICO_FK on IFRSRH2.AMB                                                                                 
(AMB_PORTE)                                                                                                                         
Tablespace TSD_INDICE;                                                                                                              
--*******************************************************                                                                           
-- TAB(ARQUIVO_CREDITO_BANCARIO_PENS): 955000  TAB REF(DEPENDENCIAS): 50128                                                         
create index IDX_ACP_DEP_FK on IFRSRH2.ARQUIVO_CREDITO_BANCARIO_PENS                                                                
(DEP_CODIGO)                                                                                                                        
Tablespace TSD_INDICE;                                                                                                              
--*******************************************************                                                                           
-- TAB(ARQUIVO_CREDITO_BANCARIO_PENS): 955000  TAB REF(PENSIONISTAS): 258336                                                        
create index IDX_ACP_PEN_FK on IFRSRH2.ARQUIVO_CREDITO_BANCARIO_PENS                                                                
(ACP_PEN_EMP_NUMERO_MATRICULA,ACP_PEN_CODIGO)                                                                                       
Tablespace TSD_INDICE;                                                                                                              
--*******************************************************                                                                           
-- TAB(ATIVIDADES): 385920  TAB REF(CENTRO_CUSTO): 19936                                                                            
create index IDX_ATI_CC2_FK on IFRSRH2.ATIVIDADES                                                                                   
(ATI_CT_CUSTOS_CODIGO)                                                                                                              
Tablespace TSD_INDICE;                                                                                                              
--*******************************************************                                                                           
-- TAB(ATIVIDADES_EMPREGADOS): 554936  TAB REF(CARGOS_CONFIANCA): 83472                                                             
create index IDX_AEM_FUN_CODIGO_FK on IFRSRH2.ATIVIDADES_EMPREGADOS                                                                 
(AEM_FUN_CODIGO)                                                                                                                    
Tablespace TSD_INDICE;                                                                                                              
--*******************************************************                                                                           
-- TAB(AUTORIZACOES_SERVICOS_MEDICOS): 150048  TAB REF(CREDENCIADOS): 1159216                                                       
create index IDX_ASM_CRE_FK on IFRSRH2.AUTORIZACOES_SERVICOS_MEDICOS                                                                
(ASM_CRE_SEQUENCIAL)                                                                                                                
Tablespace TSD_INDICE;                                                                                                              
--*******************************************************                                                                           
-- TAB(AUTORIZACOES_SERVICOS_MEDICOS): 150048  TAB REF(DEPENDENCIAS): 50128                                                         
create index IDX_ASM_DEP_FK on IFRSRH2.AUTORIZACOES_SERVICOS_MEDICOS                                                                
(ASM_DEP_CODIGO)                                                                                                                    
Tablespace TSD_INDICE;                                                                                                              
--*******************************************************                                                                           
-- TAB(AUTORIZACOES_TRATAMENTOS_ODONT): 9799528  TAB REF(DEPENDENCIAS): 50128                                                       
create index IDX_ATO_FK_DEP on IFRSRH2.AUTORIZACOES_TRATAMENTOS_ODONT                                                               
(ATO_DEP_RESP_INCL)                                                                                                                 
Tablespace TSD_INDICE;                                                                                                              
--*******************************************************                                                                           
-- TAB(AUTORIZACOES_TRATAMENTOS_ODONT): 9799528  TAB REF(DEPENDENCIAS): 50128                                                       
create index IDX_ATO_LOT_FK on IFRSRH2.AUTORIZACOES_TRATAMENTOS_ODONT                                                               
(ATO_EMP_DEP_CODIGO_LOTACAO)                                                                                                        
Tablespace TSD_INDICE;                                                                                                              
--*******************************************************                                                                           
-- TAB(BENEFICIARIOS_SEGUROS): 659672  TAB REF(PESSOAS_VINCULADAS): 5534256                                                         
create index IDX_BSG_PVI_FK on IFRSRH2.BENEFICIARIOS_SEGUROS                                                                        
(BSG_PVI_EMP_NUMERO_MATRICULA,BSG_PVI_SEQUENCIAL)                                                                                   
Tablespace TSD_INDICE;                                                                                                              
--*******************************************************                                                                           
-- TAB(CADASTROS): 9373152  TAB REF(DEFICIENCIA): 840                                                                               
create index IDX_EMP_DEF_FK on IFRSRH2.CADASTROS                                                                                    
(EMP_DEF_COD_DEFICIENCIA,EMP_DEF_COD_TIPO_DEFICIENCIA)                                                                              
Tablespace TSD_INDICE;                                                                                                              
--*******************************************************                                                                           
-- TAB(CADASTROS): 9373152  TAB REF(ESCOLARIDADES): 290                                                                             
create index IDX_EMP_ESO_FK on IFRSRH2.CADASTROS                                                                                    
(EMP_ESO_CODIGO)                                                                                                                    
Tablespace TSD_INDICE;                                                                                                              
--*******************************************************                                                                           
-- TAB(CADASTROS): 9373152  TAB REF(FORCAS_ARMADAS): 48                                                                             
create index IDX_EMP_FORCA_ARMADA_CODIGO_FK on IFRSRH2.CADASTROS                                                                    
(EMP_FORCA_ARMADA_CODIGO)                                                                                                           
Tablespace TSD_INDICE;                                                                                                              
--*******************************************************                                                                           
-- TAB(CADASTROS): 9373152  TAB REF(HORARIOS_TRABALHO_DEP): 0                                                                       
create index IDX_EMP_HTD_FK on IFRSRH2.CADASTROS                                                                                    
(EMP_HTD_DEP_CODIGO,EMP_HTD_HTR_CODIGO,EMP_HTD_SEQUENCIAL)                                                                          
Tablespace TSD_INDICE;                                                                                                              
--*******************************************************                                                                           
-- TAB(CADASTROS): 9373152  TAB REF(JORNADAS_TRABALHO): 24                                                                          
create index IDX_EMP_JTR_FK on IFRSRH2.CADASTROS                                                                                    
(EMP_JTR_CODIGO)                                                                                                                    
Tablespace TSD_INDICE;                                                                                                              
--*******************************************************                                                                           
-- TAB(CADASTROS): 9373152  TAB REF(MUNICIPIOS): 102448                                                                             
create index IDX_EMP_MUN_NATURAL_FK on IFRSRH2.CADASTROS                                                                            
(EMP_MUN_CODIGO_NATURAL,EMP_UFE_SIGLA_NATURAL)                                                                                      
Tablespace TSD_INDICE;                                                                                                              
--*******************************************************                                                                           
-- TAB(CADASTROS): 9373152  TAB REF(MUNICIPIOS): 102448                                                                             
create index IDX_EMP_MUN_RESIDE_FK on IFRSRH2.CADASTROS                                                                             
(EMP_MUN_CODIGO_RESIDE,EMP_UFE_SIGLA_RESIDENTE)                                                                                     
Tablespace TSD_INDICE;                                                                                                              
--*******************************************************                                                                           
-- TAB(CADASTROS): 9373152  TAB REF(NIVEIS_SALARIAIS): 1656                                                                         
create index IDX_EMP_NSA_FK on IFRSRH2.CADASTROS                                                                                    
(EMP_NSA_CODIGO_NIVEL,EMP_NSA_CODIGO_PADRAO,EMP_NSA_IN_NIVEL_ESCOLARIDADE)                                                          
Tablespace TSD_INDICE;                                                                                                              
--*******************************************************                                                                           
-- TAB(CADASTROS): 9373152  TAB REF(ORGAOS_CLASSES): 629                                                                            
create index IDX_EMP_OCL_FK on IFRSRH2.CADASTROS                                                                                    
(EMP_OCL_SIGLA)                                                                                                                     
Tablespace TSD_INDICE;                                                                                                              
--*******************************************************                                                                           
-- TAB(CADASTROS): 9373152  TAB REF(PAISES): 1189                                                                                   
create index IDX_EMP_PAI_FK on IFRSRH2.CADASTROS                                                                                    
(EMP_PAI_CODIGO)                                                                                                                    
Tablespace TSD_INDICE;                                                                                                              
--*******************************************************                                                                           
-- TAB(CADASTROS): 9373152  TAB REF(POSTO_GRADUACAO): 684                                                                           
create index IDX_EMP_POSTO_GRADUACAO_CODIGO_FK on IFRSRH2.CADASTROS                                                                 
(EMP_POSTO_GRADUACAO_CODIGO)                                                                                                        
Tablespace TSD_INDICE;                                                                                                              
--*******************************************************                                                                           
-- TAB(CADASTROS): 9373152  TAB REF(QUADRO_ARMA_ESPEC): 238                                                                         
create index IDX_EMP_QUADRO_ARMA_ESP_CODIGO_FK on IFRSRH2.CADASTROS                                                                 
(EMP_QUADRO_ARMA_ESP_CODIGO)                                                                                                        
Tablespace TSD_INDICE;                                                                                                              
--*******************************************************                                                                           
-- TAB(CADASTROS): 9373152  TAB REF(TIPO_VISTO_ESTRANGEIRO): 98                                                                     
create index IDX_EMP_TVE_FK on IFRSRH2.CADASTROS                                                                                    
(EMP_TVE_COD_VISTO_ESTRANG)                                                                                                         
Tablespace TSD_INDICE;                                                                                                              
--*******************************************************                                                                           
-- TAB(CADASTROS): 9373152  TAB REF(UNIDADES_FEDERACAO): 448                                                                        
create index IDX_EMP_UFE_CI_FK on IFRSRH2.CADASTROS                                                                                 
(EMP_UFE_SIGLA_CI)                                                                                                                  
Tablespace TSD_INDICE;                                                                                                              
--*******************************************************                                                                           
-- TAB(CADASTROS): 9373152  TAB REF(UNIDADES_FEDERACAO): 448                                                                        
create index IDX_EMP_UFE_CTPS_FK on IFRSRH2.CADASTROS                                                                               
(EMP_UFE_SIGLA_CTPS)                                                                                                                
Tablespace TSD_INDICE;                                                                                                              
--*******************************************************                                                                           
-- TAB(CADASTROS): 9373152  TAB REF(UNIDADES_FEDERACAO): 448                                                                        
create index IDX_EMP_UFE_ESTRANG_REG_FK on IFRSRH2.CADASTROS                                                                        
(EMP_UFE_SIGLA_ESTRANGEIRO)                                                                                                         
Tablespace TSD_INDICE;                                                                                                              
--*******************************************************                                                                           
-- TAB(CADASTROS): 9373152  TAB REF(UNIDADES_FEDERACAO): 448                                                                        
create index IDX_EMP_UFE_PRIMEIRO_EMPREGO_FK on IFRSRH2.CADASTROS                                                                   
(EMP_UFE_SIGLA_PRIMEIRO_EMPREGO)                                                                                                    
Tablespace TSD_INDICE;                                                                                                              
--*******************************************************                                                                           
-- TAB(CADASTROS): 9373152  TAB REF(UNIDADES_FEDERACAO): 448                                                                        
create index IDX_EMP_UFE_REG_PROFIS_FK on IFRSRH2.CADASTROS                                                                         
(EMP_UFE_SIGLA_REG_PROFIS)                                                                                                          
Tablespace TSD_INDICE;                                                                                                              
--*******************************************************                                                                           
-- TAB(CADASTROS): 9373152  TAB REF(UNIDADES_FEDERACAO): 448                                                                        
create index IDX_EMP_UFE_TIT_ELEITORAL_FK on IFRSRH2.CADASTROS                                                                      
(EMP_UFE_SIGLA_TIT_ELEITOR)                                                                                                         
Tablespace TSD_INDICE;                                                                                                              
--*******************************************************                                                                           
-- TAB(CADASTROS): 9373152  TAB REF(UNIDADES_ORGANIZACIONAIS): 861120                                                               
create index IDX_EMP_UOR1_FK on IFRSRH2.CADASTROS                                                                                   
(EMP_UOR_CODIGO_LOTACAO)                                                                                                            
Tablespace TSD_INDICE;                                                                                                              
--*******************************************************                                                                           
-- TAB(CBO): 320060  TAB REF(CBO): 320060                                                                                           
create index IDX_CBO_CBO_FK on IFRSRH2.CBO                                                                                          
(CBO_CBO_CODIGO,CBO_CBO_DTA_INICIO)                                                                                                 
Tablespace TSD_INDICE;                                                                                                              
--*******************************************************                                                                           
-- TAB(CONCURSADOS_APROVADOS): 239316  TAB REF(CADASTROS): 9373152                                                                  
create index IDX_COA_EMP_FK on IFRSRH2.CONCURSADOS_APROVADOS                                                                        
(COA_EMP_NUMERO_MATRICULA)                                                                                                          
Tablespace TSD_INDICE;                                                                                                              
--*******************************************************                                                                           
-- TAB(CONTROLE_USUARIO_DEPENDENCIA): 2098208  TAB REF(DEPENDENCIAS): 50128                                                         
create index IDX_CUD_DEP_FK on IFRSRH2.CONTROLE_USUARIO_DEPENDENCIA                                                                 
(DEP_CD_DEPENDENCIA)                                                                                                                
Tablespace TSD_INDICE;                                                                                                              
--*******************************************************                                                                           
-- TAB(CONTROLE_USUARIO_DEPENDENCIA): 2098208  TAB REF(SEG_SISTEMA): 1034                                                           
create index IDX_CUD_SS_FK on IFRSRH2.CONTROLE_USUARIO_DEPENDENCIA                                                                  
(SSI_CD_SISTEMA)                                                                                                                    
Tablespace TSD_INDICE;                                                                                                              
--*******************************************************                                                                           
-- TAB(CONTROLE_USUARIOS_FUNCOES): 8272920  TAB REF(CARGOS_CONFIANCA): 83472                                                        
create index IDX_CUF_FUN_FK on IFRSRH2.CONTROLE_USUARIOS_FUNCOES                                                                    
(FUN_CODIGO)                                                                                                                        
Tablespace TSD_INDICE;                                                                                                              
--*******************************************************                                                                           
-- TAB(CONTROLE_USUARIOS_FUNCOES): 8272920  TAB REF(SEG_SISTEMA): 1034                                                              
create index IDX_FK_CUF_SS on IFRSRH2.CONTROLE_USUARIOS_FUNCOES                                                                     
(SS_CD_SISTEMA)                                                                                                                     
Tablespace TSD_INDICE;                                                                                                              
--*******************************************************                                                                           
-- TAB(CONTROLE_USUARIOS_OCORRENCIAS): 4219440  TAB REF(TIPOS_OCORRENCIAS): 21824                                                   
create index IDX_CUO_OFU_FK on IFRSRH2.CONTROLE_USUARIOS_OCORRENCIAS                                                                
(OFU_CODIGO)                                                                                                                        
Tablespace TSD_INDICE;                                                                                                              
--*******************************************************                                                                           
-- TAB(CONTROLE_USUARIOS_OCORRENCIAS): 4219440  TAB REF(SEG_SISTEMA): 1034                                                          
create index IDX_FK_CUO_SS on IFRSRH2.CONTROLE_USUARIOS_OCORRENCIAS                                                                 
(SS_CD_SISTEMA)                                                                                                                     
Tablespace TSD_INDICE;                                                                                                              
--*******************************************************                                                                           
-- TAB(CORPO_CLINICO): 611840  TAB REF(CREDENCIADOS_BENEFICIOS): 33600                                                              
create index IDX_CC_CBE_FK on IFRSRH2.CORPO_CLINICO                                                                                 
(CC_CBE_BEN_SIGLA,CC_CRE_COD_SEQUE)                                                                                                 
Tablespace TSD_INDICE;                                                                                                              
--*******************************************************                                                                           
-- TAB(CREDENCIADOS): 1159216  TAB REF(ORGAOS_CLASSES): 629                                                                         
create index IDX_CRE_OCL_FK on IFRSRH2.CREDENCIADOS                                                                                 
(CRE_OCL_SIGLA)                                                                                                                     
Tablespace TSD_INDICE;                                                                                                              
--*******************************************************                                                                           
-- TAB(CREDENC_INSS_OUTROS_RECOLHIM): 235440  TAB REF(DEPENDENCIAS): 50128                                                          
create index IDX_COR_DEP_FK on IFRSRH2.CREDENC_INSS_OUTROS_RECOLHIM                                                                 
(COR_DEP_CODIGO)                                                                                                                    
Tablespace TSD_INDICE;                                                                                                              
--*******************************************************                                                                           
-- TAB(DATAPREV_REEMBOLSO_RUBRICAS): 557984  TAB REF(DATAPREV_REEMBOLSO): 112336                                                    
create index IDX_DRR_DR_FK on IFRSRH2.DATAPREV_REEMBOLSO_RUBRICAS                                                                   
(DRR_ANO_REFERENCIA,DRR_MES_REFERENCIA,DRR_EMP_NUMERO_MATRICULA,DRR_COD_BENEFICIO,DRR_COD_BENEF_SEQUENCIAL)                         
Tablespace TSD_INDICE;                                                                                                              
--*******************************************************                                                                           
-- TAB(DOCUMENTOS_COBRANCA): 9653628  TAB REF(RETENCAO_IMPOSTOS): 468                                                               
create index IDX_DOC_RI_FK on IFRSRH2.DOCUMENTOS_COBRANCA                                                                           
(DOC_RI_COD_RECEITA,DOC_RI_DAT_INICIO)                                                                                              
Tablespace TSD_INDICE;                                                                                                              
--*******************************************************                                                                           
-- TAB(DOCUMENTOS_COBRANCA): 9653628  TAB REF(TAB_DOC_COBRANCA): 1038048                                                            
create index IDX_DOC_TDC_FK on IFRSRH2.DOCUMENTOS_COBRANCA                                                                          
(DOC_TDC_SEQ_COBRANCA)                                                                                                              
Tablespace TSD_INDICE;                                                                                                              
--*******************************************************                                                                           
-- TAB(EFETIVO_INFRAERO): 209104  TAB REF(DEPENDENCIAS): 50128                                                                      
create index IDX_EIN_DEP_FK on IFRSRH2.EFETIVO_INFRAERO                                                                             
(EIN_DEP_CODIGO)                                                                                                                    
Tablespace TSD_INDICE;                                                                                                              
--*******************************************************                                                                           
-- TAB(EMPREGADOS_CATEGORIAS): 672672  TAB REF(CATEGORIAS_TRANSPORTE): 75932                                                        
create index IDX_EMC_CAT_FK on IFRSRH2.EMPREGADOS_CATEGORIAS                                                                        
(EMC_CAT_DEP_CODIGO,EMC_CAT_SIGLA)                                                                                                  
Tablespace TSD_INDICE;                                                                                                              
--*******************************************************                                                                           
-- TAB(EMPREGADOS_CATEGORIAS): 672672  TAB REF(DEPENDENCIAS): 50128                                                                 
create index IDX_EMC_DEP_FK on IFRSRH2.EMPREGADOS_CATEGORIAS                                                                        
(EMC_DEP_RESP_INCL)                                                                                                                 
Tablespace TSD_INDICE;                                                                                                              
--*******************************************************                                                                           
-- TAB(EMPREGADOS_FORMACOES): 135696  TAB REF(FORMACOES_PROFISSIONAIS): 15840                                                       
create index IDX_EMF_FORP_FK on IFRSRH2.EMPREGADOS_FORMACOES                                                                        
(EMF_FOR_CODIGO)                                                                                                                    
Tablespace TSD_INDICE;                                                                                                              
--*******************************************************                                                                           
-- TAB(EMPREGADOS_PAGAMENTOS): 142930980  TAB REF(DEPENDENCIAS): 50128                                                              
create index IDX_EGT_DEP_FK on IFRSRH2.EMPREGADOS_PAGAMENTOS                                                                        
(EGT_DEP_CODIGO)                                                                                                                    
Tablespace TSD_INDICE;                                                                                                              
--*******************************************************                                                                           
-- TAB(EMPREGADOS_PAGAMENTOS): 142930980  TAB REF(UNIDADES_ORGANIZACIONAIS): 861120                                                 
create index IDX_EGT_UOR_FK on IFRSRH2.EMPREGADOS_PAGAMENTOS                                                                        
(EGT_UOR_CODIGO)                                                                                                                    
Tablespace TSD_INDICE;                                                                                                              
--*******************************************************                                                                           
-- TAB(EMPREGADOS_PARTICIPACAO_LUCROS): 9671224  TAB REF(DEPENDENCIAS): 50128                                                       
create index IDX_DEP_FK on IFRSRH2.EMPREGADOS_PARTICIPACAO_LUCROS                                                                   
(EPL_DEP_CODIGO_LOTACAO)                                                                                                            
Tablespace TSD_INDICE;                                                                                                              
--*******************************************************                                                                           
-- TAB(HISTORICO_ANS): 8537568  TAB REF(PESSOAS_VINCULADAS): 5534256                                                                
create index IDX_HAN_PVI_FK on IFRSRH2.HISTORICO_ANS                                                                                
(HAN_EMP_NUMERO_MATRICULA,HAN_PVI_SEQUENCIAL)                                                                                       
Tablespace TSD_INDICE;                                                                                                              
--*******************************************************                                                                           
-- TAB(HISTORICO_ANS): 8537568  TAB REF(SEG_USUARIO): 420288                                                                        
create index IDX_HAN_USU_FK on IFRSRH2.HISTORICO_ANS                                                                                
(HAN_COD_USUARIO_GERACAO)                                                                                                           
Tablespace TSD_INDICE;                                                                                                              
--*******************************************************                                                                           
-- TAB(HISTORICO_CARGOS_LOTACAO): 261144  TAB REF(HISTORICO_CARGOS_DEPENDENCIAS): 20384                                             
create index IDX_ICL_HCD_FK on IFRSRH2.HISTORICO_CARGOS_LOTACAO                                                                     
(ICL_HCD_DEP_CODIGO,ICL_HCD_DATA_VIGENCIA)                                                                                          
Tablespace TSD_INDICE;                                                                                                              
--*******************************************************                                                                           
-- TAB(HISTORICO_MOVIMENTACAO): 400836696  TAB REF(FORMULAS): 18560                                                                 
create index IDX_HST_MOV_FORM_FK on IFRSRH2.HISTORICO_MOVIMENTACAO                                                                  
(MOV_FOR_CODIGO)                                                                                                                    
Tablespace TSD_INDICE;                                                                                                              
--*******************************************************                                                                           
-- TAB(HISTORICO_MOVIMENTACAO): 400836696  TAB REF(RUBRICAS): 31800                                                                 
create index IDX_HST_MOV_RUB_FK on IFRSRH2.HISTORICO_MOVIMENTACAO                                                                   
(MOV_RUB_CODIGO)                                                                                                                    
Tablespace TSD_INDICE;                                                                                                              
--*******************************************************                                                                           
-- TAB(HISTORICOS_FUNCOES_LOTACOES): 228800  TAB REF(HISTORICOS_FUNCOES_DEPENDENCIA): 13616                                         
create index IDX_HFL_HFD_FK on IFRSRH2.HISTORICOS_FUNCOES_LOTACOES                                                                  
(HFL_HFD_DEP_CODIGO,HFL_HFD_DATA_VIGENCIA)                                                                                          
Tablespace TSD_INDICE;                                                                                                              
--*******************************************************                                                                           
-- TAB(INDICE_ABSENTEISMO): 4885936  TAB REF(DEPENDENCIAS): 50128                                                                   
create index IDX_IAB_DEP_FK on IFRSRH2.INDICE_ABSENTEISMO                                                                           
(IAB_DEP_CODIGO)                                                                                                                    
Tablespace TSD_INDICE;                                                                                                              
--*******************************************************                                                                           
-- TAB(INDICE_ABSENTEISMO): 4885936  TAB REF(TIPOS_OCORRENCIAS): 21824                                                              
create index IDX_IAB_OFU_FK on IFRSRH2.INDICE_ABSENTEISMO                                                                           
(IAB_OFU_CODIGO)                                                                                                                    
Tablespace TSD_INDICE;                                                                                                              
--*******************************************************                                                                           
-- TAB(LPM): 356352  TAB REF(ESPECIALIDADES): 47360                                                                                 
create index IDX_LPM_ESP_TIPO_FK on IFRSRH2.LPM                                                                                     
(LPM_ESP_TIPO,LPM_ESP_NUMERO)                                                                                                       
Tablespace TSD_INDICE;                                                                                                              
--*******************************************************                                                                           
-- TAB(MOVIMENTACAO): 1051635588  TAB REF(FORMULAS): 18560                                                                          
create index IDX_MOV_FORM_FK on IFRSRH2.MOVIMENTACAO                                                                                
(MOV_FOR_CODIGO)                                                                                                                    
Tablespace TSD_INDICE;                                                                                                              
--*******************************************************                                                                           
-- TAB(MOVIMENTACAO): 1051635588  TAB REF(RUBRICAS): 31800                                                                          
create index IDX_MOV_RUB_FK on IFRSRH2.MOVIMENTACAO                                                                                 
(MOV_RUB_CODIGO)                                                                                                                    
Tablespace TSD_INDICE;                                                                                                              
--*******************************************************                                                                           
-- TAB(MOVIMENTACAO_AUTONOMO_COOPERAT): 182172  TAB REF(CBO): 320060                                                                
create index IDX_MAC_CBO_FK on IFRSRH2.MOVIMENTACAO_AUTONOMO_COOPERAT                                                               
(MAC_CBO_CODIGO,MAC_CBO_DTA_INICIO)                                                                                                 
Tablespace TSD_INDICE;                                                                                                              
--*******************************************************                                                                           
-- TAB(MOVIMENTACAO_AUTONOMO_COOPERAT): 182172  TAB REF(CREDENCIADOS): 1159216                                                      
create index IDX_MAC_CRE_FK on IFRSRH2.MOVIMENTACAO_AUTONOMO_COOPERAT                                                               
(MAC_CRE_SEQUENCIAL)                                                                                                                
Tablespace TSD_INDICE;                                                                                                              
--*******************************************************                                                                           
-- TAB(MOVIMENTACAO_AUTONOMO_COOPERAT): 182172  TAB REF(DEPENDENCIAS): 50128                                                        
create index IDX_MAC_DEP_FK on IFRSRH2.MOVIMENTACAO_AUTONOMO_COOPERAT                                                               
(MAC_DEP_CODIGO)                                                                                                                    
Tablespace TSD_INDICE;                                                                                                              
--*******************************************************                                                                           
-- TAB(OCORRENCIAS_PIS_PASEP_EMP): 5456808  TAB REF(OCORRENCIAS_PIS_PASEP): 4416                                                    
create index IDX_OPPE_OPP_FK on IFRSRH2.OCORRENCIAS_PIS_PASEP_EMP                                                                   
(OCO_NOME_ARQUIVO,OCO_CODIGO_OCORRENCIA,OCO_TIPO_OCORRENCIA)                                                                        
Tablespace TSD_INDICE;                                                                                                              
--*******************************************************                                                                           
-- TAB(OCORRENCIAS_RECEB_VALES): 59935200  TAB REF(UNIDADES_ORGANIZACIONAIS): 861120                                                
create index IDX_ORV_UOR_FK on IFRSRH2.OCORRENCIAS_RECEB_VALES                                                                      
(ORV_UOR_CODIGO)                                                                                                                    
Tablespace TSD_INDICE;                                                                                                              
--*******************************************************                                                                           
-- TAB(PEDIDOS_TICKETS): 1883868  TAB REF(DEPENDENCIAS): 50128                                                                      
create index IDX_PKT_DEP_FK on IFRSRH2.PEDIDOS_TICKETS                                                                              
(PKT_DEP_RESP_INCL)                                                                                                                 
Tablespace TSD_INDICE;                                                                                                              
--*******************************************************                                                                           
-- TAB(PENSIONISTAS): 258336  TAB REF(FORMULAS): 18560                                                                              
create index IDX_PEN_FOR_FERIAS_FK on IFRSRH2.PENSIONISTAS                                                                          
(PEN_FOR_CODIGO_FERIAS)                                                                                                             
Tablespace TSD_INDICE;                                                                                                              
--*******************************************************                                                                           
-- TAB(PENSIONISTAS): 258336  TAB REF(FORMULAS): 18560                                                                              
create index IDX_PEN_FOR_FK on IFRSRH2.PENSIONISTAS                                                                                 
(PEN_FOR_CODIGO)                                                                                                                    
Tablespace TSD_INDICE;                                                                                                              
--*******************************************************                                                                           
-- TAB(PENSIONISTAS): 258336  TAB REF(FORMULAS): 18560                                                                              
create index IDX_PEN_FOR_13_FK on IFRSRH2.PENSIONISTAS                                                                              
(PEN_FOR_CODIGO_13)                                                                                                                 
Tablespace TSD_INDICE;                                                                                                              
--*******************************************************                                                                           
-- TAB(PESSOAS_VINCULADAS): 5534256  TAB REF(MUNICIPIOS): 102448                                                                    
create index IDX_PVI_MUN_FK on IFRSRH2.PESSOAS_VINCULADAS                                                                           
(PVI_MUN_CODIGO_NATURALIDADE,PVI_UFE_SIGLA_NATURALIDADE)                                                                            
Tablespace TSD_INDICE;                                                                                                              
--*******************************************************                                                                           
-- TAB(PESSOAS_VINCULADAS): 5534256  TAB REF(PAISES): 1189                                                                          
create index IDX_PVI_PAI_CODIGO_FK on IFRSRH2.PESSOAS_VINCULADAS                                                                    
(PVI_PAI_CODIGO)                                                                                                                    
Tablespace TSD_INDICE;                                                                                                              
--*******************************************************                                                                           
-- TAB(PESSOAS_VINCULADAS): 5534256  TAB REF(TIPO_VINCULOS): 775                                                                    
create index IDX_PVI_TPV_FK on IFRSRH2.PESSOAS_VINCULADAS                                                                           
(PVI_TPV_CODIGO)                                                                                                                    
Tablespace TSD_INDICE;                                                                                                              
--*******************************************************                                                                           
-- TAB(PESSOAS_VINCULADAS_BENEF): 3056256  TAB REF(BENEFICIOS): 4384                                                                
create index IDX_PVB_BEN_FK on IFRSRH2.PESSOAS_VINCULADAS_BENEF                                                                     
(EMB_BEN_SIGLA)                                                                                                                     
Tablespace TSD_INDICE;                                                                                                              
--*******************************************************                                                                           
-- TAB(PROCEDIMENTOS_ODONTOLOGICOS): 5208764  TAB REF(DEPENDENCIAS): 50128                                                          
create index IDX_PROCED_ODONT_VAL_DEPENDEN on IFRSRH2.PROCEDIMENTOS_ODONTOLOGICOS                                                   
(POD_DEP_RESP_INCL)                                                                                                                 
Tablespace TSD_INDICE;                                                                                                              
--*******************************************************                                                                           
-- TAB(QUADRO_CARGOS_DEPENDENCIAS): 223080  TAB REF(CARGOS): 84680                                                                  
create index IDX_QCD_CAR_FK on IFRSRH2.QUADRO_CARGOS_DEPENDENCIAS                                                                   
(QCD_CAR_CODIGO,QCD_CAR_CODIGO_NIVEL,QCD_CAR_OCC_CODIGO)                                                                            
Tablespace TSD_INDICE;                                                                                                              
--*******************************************************                                                                           
-- TAB(QUADRO_FUNCOES): 152820  TAB REF(HISTORICOS_FUNCOES_LOTACOES): 228800                                                        
create index IDX_QFU_HFL_FK on IFRSRH2.QUADRO_FUNCOES                                                                               
(QFU_HFL_UOR_CODIGO,QFU_HFL_DATA_VIGENCIA)                                                                                          
Tablespace TSD_INDICE;                                                                                                              
--*******************************************************                                                                           
-- TAB(QUADROS_LOTACAO_PESSOAL): 554580  TAB REF(CARGOS): 84680                                                                     
create index IDX_QLP_CAR_FK on IFRSRH2.QUADROS_LOTACAO_PESSOAL                                                                      
(QLP_CAR_CODIGO,QLP_CAR_CODIGO_NIVEL,QLP_CAR_OCC_CODIGO)                                                                            
Tablespace TSD_INDICE;                                                                                                              
--*******************************************************                                                                           
-- TAB(REEMBOLSOS): 6893216  TAB REF(DEPENDENCIAS): 50128                                                                           
create index IDX_REEMBOLSOS_FK_DEPENDENCIAS on IFRSRH2.REEMBOLSOS                                                                   
(REE_DEP_RESP_INCL)                                                                                                                 
Tablespace TSD_INDICE;                                                                                                              
--*******************************************************                                                                           
-- TAB(RESUMO_ENCARGOS_INSS_AUTONOMO): 967512  TAB REF(CREDENCIADOS): 1159216                                                       
create index IDX_REA_CRE_FK on IFRSRH2.RESUMO_ENCARGOS_INSS_AUTONOMO                                                                
(REA_CRE_SEQUENCIAL)                                                                                                                
Tablespace TSD_INDICE;                                                                                                              
--*******************************************************                                                                           
-- TAB(RESUMO_ENCARGOS_INSS_AUTONOMO): 967512  TAB REF(DEPENDENCIAS): 50128                                                         
create index IDX_REIA_DEP_FK on IFRSRH2.RESUMO_ENCARGOS_INSS_AUTONOMO                                                               
(REA_DEP_CODIGO)                                                                                                                    
Tablespace TSD_INDICE;                                                                                                              
--*******************************************************                                                                           
-- TAB(SIAD_AVALIACAO_FINAL): 529480  TAB REF(SIAD_ESCALA_PONTUACAO): 630                                                           
create index IDX_AV_FINAL_ESCALA_FK on IFRSRH2.SIAD_AVALIACAO_FINAL                                                                 
(ANO_ESCALA,TIPO_ESCALA,CODIGO_CLASSIFICACAO)                                                                                       
Tablespace TSD_INDICE;                                                                                                              
--*******************************************************                                                                           
-- TAB(SPF_EMPREGADO_IND_INSUFICIENCI): 401024  TAB REF(CADASTROS): 9373152                                                         
create index IDX_EII_CADAST_FK on IFRSRH2.SPF_EMPREGADO_IND_INSUFICIENCI                                                            
(MATRICULA_EMP_INDICADO_INS)                                                                                                        
Tablespace TSD_INDICE;                                                                                                              
--*******************************************************                                                                           
-- TAB(SPF_EMPREGADO_IND_PROMOCAO): 436508  TAB REF(CADASTROS): 9373152                                                             
create index IDX_EIP_CADATR_FK on IFRSRH2.SPF_EMPREGADO_IND_PROMOCAO                                                                
(MATRICULA_EMP_INDICADO_PROM)                                                                                                       
Tablespace TSD_INDICE;                                                                                                              
--*******************************************************                                                                           
-- TAB(SPF_EMPREGADO_PROMOVIDO): 2152032  TAB REF(CARGOS): 84680                                                                    
create index IDX_EMP_PROM_CARGOS_FK on IFRSRH2.SPF_EMPREGADO_PROMOVIDO                                                              
(CARGOS_CAR_CODIGO,CARGOS_CAR_CODIGO_NIVEL,CARGOS_OCUCARGO_OCC_CODIGO)                                                              
Tablespace TSD_INDICE;                                                                                                              
--*******************************************************                                                                           
-- TAB(SPF_EMPREGADO_PROMOVIDO): 2152032  TAB REF(SPF_PROMOCAO): 1584                                                               
create index IDX_EMP_PROM_PROMOCAO_FK on IFRSRH2.SPF_EMPREGADO_PROMOVIDO                                                            
(PROMOCAO_TIPOS_OCOR_OFU_CODIGO,PROMOCAO_ANO_PROMOCAO)                                                                              
Tablespace TSD_INDICE;                                                                                                              
--*******************************************************                                                                           
-- TAB(TAB_DOC_COBRANCA): 1038048  TAB REF(DEPENDENCIAS): 50128                                                                     
create index IDX_TDC_DEP_FK on IFRSRH2.TAB_DOC_COBRANCA                                                                             
(TDC_DEP_CODIGO)                                                                                                                    
Tablespace TSD_INDICE;                                                                                                              
--*******************************************************                                                                           
-- TAB(TAB_PARTICIPACAO_BENEFICIO): 9986556  TAB REF(CENTRO_CUSTO): 19936                                                           
create index IDX_TAB_PART_BEN_CC_FK on IFRSRH2.TAB_PARTICIPACAO_BENEFICIO                                                           
(TPB_CCT_CODIGO)                                                                                                                    
Tablespace TSD_INDICE;                                                                                                              
--*******************************************************                                                                           
-- TAB(TAB_PARTICIPACAO_BENEFICIO): 9986556  TAB REF(DEPENDENCIAS): 50128                                                           
create index IDX_TAB_PART_BEN_DEP_FISICA_FK on IFRSRH2.TAB_PARTICIPACAO_BENEFICIO                                                   
(TPB_DEP_CODIGO_FISICO)                                                                                                             
Tablespace TSD_INDICE;                                                                                                              
--*******************************************************                                                                           
-- TAB(TAB_PARTICIPACAO_BENEFICIO): 9986556  TAB REF(DEPENDENCIAS): 50128                                                           
create index IDX_TAB_PART_BEN_DEP_LOTACAO_FK on IFRSRH2.TAB_PARTICIPACAO_BENEFICIO                                                  
(TPB_DEP_CODIGO_LOTACAO)                                                                                                            
Tablespace TSD_INDICE;                                                                                                              
--*******************************************************                                                                           
-- TAB(TAB_PARTICIPACAO_BENEFICIO): 9986556  TAB REF(RUBRICAS): 31800                                                               
create index IDX_TAB_PART_BEN_RUBRICAS_FK on IFRSRH2.TAB_PARTICIPACAO_BENEFICIO                                                     
(TPB_RUB_CODIGO)                                                                                                                    
Tablespace TSD_INDICE;                                                                                                              
--*******************************************************                                                                           
-- TAB(TEMP_MOVIMENTACAO): 1093308  TAB REF(FORMULAS): 18560                                                                        
create index IDX_TEMP_MOV_FORM_FK on IFRSRH2.TEMP_MOVIMENTACAO                                                                      
(MOV_FOR_CODIGO)                                                                                                                    
Tablespace TSD_INDICE;                                                                                                              
--*******************************************************                                                                           
-- TAB(TEMP_MOVIMENTACAO): 1093308  TAB REF(PENSIONISTAS): 258336                                                                   
create index IDX_TEMP_MOV_PEN_FK on IFRSRH2.TEMP_MOVIMENTACAO                                                                       
(MOV_EMP_NUMERO_MATRICULA,MOV_PEN_CODIGO)                                                                                           
Tablespace TSD_INDICE;                                                                                                              
--*******************************************************                                                                           
-- TAB(TEMP_MOVIMENTACAO): 1093308  TAB REF(RUBRICAS): 31800                                                                        
create index IDX_TEMP_MOV_RUB_FK on IFRSRH2.TEMP_MOVIMENTACAO                                                                       
(MOV_RUB_CODIGO)                                                                                                                    
Tablespace TSD_INDICE;                                                                                                              
--*******************************************************                                                                           
-- TAB(USUARIOS_PLANOS_SAUDE): 273312  TAB REF(DEPENDENCIAS): 50128                                                                 
create index IDX_UPS_DEP_FK on IFRSRH2.USUARIOS_PLANOS_SAUDE                                                                        
(UPS_DEP_CODIGO)                                                                                                                    
Tablespace TSD_INDICE;                                                                                                              
--*******************************************************                                                                           
-- TAB(USUARIOS_PLANOS_SAUDE): 273312  TAB REF(CADASTROS): 9373152                                                                  
create index IDX_UPS_EMP_FK on IFRSRH2.USUARIOS_PLANOS_SAUDE                                                                        
(UPS_EMP_NUMERO_MATRICULA)                                                                                                          
Tablespace TSD_INDICE;                                                                                                              
--*******************************************************                                                                           
-- TAB(VINCULADO_UNIVERSITARIOS): 217448  TAB REF(PESSOAS_VINCULADAS): 5534256                                                      
create index IDX_PESSOAS_VINC_MAT_SEQ_FK on IFRSRH2.VINCULADO_UNIVERSITARIOS                                                        
(VIU_PVI_EMP_NUMERO_MATRICULA,VIU_PVI_SEQUENCIAL)                                                                                   
Tablespace TSD_INDICE;                                                                                                              
--*******************************************************                                                                           
-- TAB(VINCULADO_UNIVERSITARIOS): 217448  TAB REF(DEPENDENCIAS): 50128                                                              
create index IDX_VIU_DEP_FK on IFRSRH2.VINCULADO_UNIVERSITARIOS                                                                     
(VIU_DEP_RESP_INCL)                                                                                                                 
Tablespace TSD_INDICE;                                                                                                              
