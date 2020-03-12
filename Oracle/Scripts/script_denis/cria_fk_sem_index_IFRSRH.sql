set feedback on                                                                                                                     
set verify on                                                                                                                       
set echo on                                                                                                                         
--*******************************************************                                                                           
-- TAB(AMB): 376812  TAB REF(ESPECIALIDADES): 43136                                                                                 
create index AMB_ESP_TIPO_FK on IFRSRH.AMB                                                                                          
(AMB_ESP_TIPO,AMB_ESP_NUMERO)                                                                                                       
Tablespace TSI_PESSOAL;                                                                                                              
--*******************************************************                                                                           
-- TAB(AMB): 376812  TAB REF(PORTES_ANESTESICOS): 72                                                                                
create index PORTE_ANESTESICO_FK on IFRSRH.AMB                                                                                      
(AMB_PORTE)                                                                                                                         
Tablespace TSI_PESSOAL;                                                                                                              
--*******************************************************                                                                           
-- TAB(ARQUIVO_CREDITO_BANCARIO): 11700008  TAB REF(EMPREGADOS_PAGAMENTOS): 119463792                                               
create index ACB_EGT_FK on IFRSRH.ARQUIVO_CREDITO_BANCARIO                                                                          
(ACB_EGT_CRP_ANO_PAGAMENTO,ACB_EGT_CRP_MES_PAGAMENTO,ACB_EGT_CRP_SEQUENCIAL,ACB_EMP_NUMERO_MATRICULA)                               
Tablespace TSI_PESSOAL;                                                                                                              
--*******************************************************                                                                           
-- TAB(ARQUIVO_CREDITO_BANCARIO_PENS): 758800  TAB REF(DEPENDENCIAS): 42120                                                         
create index ACP_DEP_FK on IFRSRH.ARQUIVO_CREDITO_BANCARIO_PENS                                                                     
(DEP_CODIGO)                                                                                                                        
Tablespace TSI_PESSOAL;                                                                                                              
--*******************************************************                                                                           
-- TAB(ARQUIVO_CREDITO_BANCARIO_PENS): 758800  TAB REF(EMPREGADOS_PAGAMENTOS): 119463792                                            
create index ACP_EGT_FK on IFRSRH.ARQUIVO_CREDITO_BANCARIO_PENS                                                                     
(EGT_CRP_ANO_PAGAMENTO,EGT_CRP_MES_PAGAMENTO,EGT_CRP_SEQUENCIAL,ACP_PEN_EMP_NUMERO_MATRICULA)                                       
Tablespace TSI_PESSOAL;                                                                                                              
--*******************************************************                                                                           
-- TAB(ARQUIVO_CREDITO_BANCARIO_PENS): 758800  TAB REF(PENSIONISTAS): 244760                                                        
create index ACP_PEN_FK on IFRSRH.ARQUIVO_CREDITO_BANCARIO_PENS                                                                     
(ACP_PEN_EMP_NUMERO_MATRICULA,ACP_PEN_CODIGO)                                                                                       
Tablespace TSI_PESSOAL;                                                                                                              
--*******************************************************                                                                           
-- TAB(ATIVIDADES): 396640  TAB REF(CENTRO_CUSTO): 16416                                                                            
create index ATI_CC2_FK on IFRSRH.ATIVIDADES                                                                                        
(ATI_CT_CUSTOS_CODIGO)                                                                                                              
Tablespace TSI_PESSOAL;                                                                                                              
--*******************************************************                                                                           
-- TAB(AUTORIZACOES_TRATAMENTOS_ODONT): 6791400  TAB REF(EMPREGADOS_BENEFICIOS): 3130200                                            
create index ATO_EMB_FK on IFRSRH.AUTORIZACOES_TRATAMENTOS_ODONT                                                                    
(ATO_EMB_EMP_NUMERO_MATRICULA,ATO_EMB_BEN_SIGLA)                                                                                    
Tablespace TSI_PESSOAL;                                                                                                              
--*******************************************************                                                                           
-- TAB(AUTORIZACOES_TRATAMENTOS_ODONT): 6791400  TAB REF(DEPENDENCIAS): 42120                                                       
create index ATO_FK_DEP on IFRSRH.AUTORIZACOES_TRATAMENTOS_ODONT                                                                    
(ATO_DEP_RESP_INCL)                                                                                                                 
Tablespace TSI_PESSOAL;                                                                                                              
--*******************************************************                                                                           
-- TAB(AUTORIZACOES_TRATAMENTOS_ODONT): 6791400  TAB REF(DEPENDENCIAS): 42120                                                       
create index ATO_LOT_FK on IFRSRH.AUTORIZACOES_TRATAMENTOS_ODONT                                                                    
(ATO_EMP_DEP_CODIGO_LOTACAO)                                                                                                        
Tablespace TSI_PESSOAL;                                                                                                              
--*******************************************************                                                                           
-- TAB(AUTORIZACOES_TRATAMENTOS_ODONT): 6791400  TAB REF(PESSOAS_VINCULADAS_BENEF): 2849644                                         
create index ATO_PVB_FK on IFRSRH.AUTORIZACOES_TRATAMENTOS_ODONT                                                                    
(ATO_EMB_EMP_NUMERO_MATRICULA,ATO_PVB_PVI_SEQUENCIAL,ATO_EMB_BEN_SIGLA,ATO_PVB_ADESAO)                                              
Tablespace TSI_PESSOAL;                                                                                                              
--*******************************************************                                                                           
-- TAB(BENEFICIARIOS_SEGUROS): 617656  TAB REF(EMPREGADOS_BENEFICIOS): 3130200                                                      
create index BSG_EMP_BEN_FK on IFRSRH.BENEFICIARIOS_SEGUROS                                                                         
(BSG_EMB_EMP_NUMERO_MATRICULA,BSG_EMB_BEN_SIGLA)                                                                                    
Tablespace TSI_PESSOAL;                                                                                                              
--*******************************************************                                                                           
-- TAB(BENEFICIARIOS_SEGUROS): 617656  TAB REF(PESSOAS_VINCULADAS): 5279128                                                         
create index BSG_PVI_FK on IFRSRH.BENEFICIARIOS_SEGUROS                                                                             
(BSG_PVI_EMP_NUMERO_MATRICULA,BSG_PVI_SEQUENCIAL)                                                                                   
Tablespace TSI_PESSOAL;                                                                                                              
--*******************************************************                                                                           
-- TAB(CADASTROS): 9082368  TAB REF(AGENCIAINF): 269516                                                                             
create index EMP_ABA_CONTA_FGTS_FK on IFRSRH.CADASTROS                                                                              
(EMP_ABA_BAN_CODIGO_FGTS,EMP_ABA_CODIGO_FGTS)                                                                                       
Tablespace TSI_PESSOAL;                                                                                                              
--*******************************************************                                                                           
-- TAB(CADASTROS): 9082368  TAB REF(AGENCIAINF): 269516                                                                             
create index EMP_ABA_CONTA_PGTO_FK on IFRSRH.CADASTROS                                                                              
(EMP_ABA_BAN_CODIGO_CTA_PGTO,EMP_ABA_CODIGO_CONTA_PGTO)                                                                             
Tablespace TSI_PESSOAL;                                                                                                              
--*******************************************************                                                                           
-- TAB(CADASTROS): 9082368  TAB REF(ESCOLARIDADES): 290                                                                             
create index EMP_ESO_FK on IFRSRH.CADASTROS                                                                                         
(EMP_ESO_CODIGO)                                                                                                                    
Tablespace TSI_PESSOAL;                                                                                                              
--*******************************************************                                                                           
-- TAB(CADASTROS): 9082368  TAB REF(FORCAS_ARMADAS): 36                                                                             
create index EMP_FORCA_ARMADA_CODIGO_FK on IFRSRH.CADASTROS                                                                         
(EMP_FORCA_ARMADA_CODIGO)                                                                                                           
Tablespace TSI_PESSOAL;                                                                                                              
--*******************************************************                                                                           
-- TAB(CADASTROS): 9082368  TAB REF(CARGOS_CONFIANCA): 73884                                                                        
create index EMP_FUNCAO_FK on IFRSRH.CADASTROS                                                                                      
(EMP_QFU_FUN_CODIGO)                                                                                                                
Tablespace TSI_PESSOAL;                                                                                                              
--*******************************************************                                                                           
-- TAB(CADASTROS): 9082368  TAB REF(HORARIOS_TRABALHO_DEP): 0                                                                       
create index EMP_HTD_FK on IFRSRH.CADASTROS                                                                                         
(EMP_HTD_DEP_CODIGO,EMP_HTD_HTR_CODIGO,EMP_HTD_SEQUENCIAL)                                                                          
Tablespace TSI_PESSOAL;                                                                                                              
--*******************************************************                                                                           
-- TAB(CADASTROS): 9082368  TAB REF(JORNADAS_TRABALHO): 24                                                                          
create index EMP_JTR_FK on IFRSRH.CADASTROS                                                                                         
(EMP_JTR_CODIGO)                                                                                                                    
Tablespace TSI_PESSOAL;                                                                                                              
--*******************************************************                                                                           
-- TAB(CADASTROS): 9082368  TAB REF(MUNICIPIOS): 101764                                                                             
create index EMP_MUN_NATURAL_FK on IFRSRH.CADASTROS                                                                                 
(EMP_MUN_CODIGO_NATURAL,EMP_UFE_SIGLA_NATURAL)                                                                                      
Tablespace TSI_PESSOAL;                                                                                                              
--*******************************************************                                                                           
-- TAB(CADASTROS): 9082368  TAB REF(MUNICIPIOS): 101764                                                                             
create index EMP_MUN_RESIDE_FK on IFRSRH.CADASTROS                                                                                  
(EMP_MUN_CODIGO_RESIDE,EMP_UFE_SIGLA_RESIDENTE)                                                                                     
Tablespace TSI_PESSOAL;                                                                                                              
--*******************************************************                                                                           
-- TAB(CADASTROS): 9082368  TAB REF(NIVEIS_SALARIAIS): 1980                                                                         
create index EMP_NSA_FK on IFRSRH.CADASTROS                                                                                         
(EMP_NSA_CODIGO_NIVEL,EMP_NSA_CODIGO_PADRAO,EMP_NSA_IN_NIVEL_ESCOLARIDADE)                                                          
Tablespace TSI_PESSOAL;                                                                                                              
--*******************************************************                                                                           
-- TAB(CADASTROS): 9082368  TAB REF(ORGAOS_CLASSES): 629                                                                            
create index EMP_OCL_FK on IFRSRH.CADASTROS                                                                                         
(EMP_OCL_SIGLA)                                                                                                                     
Tablespace TSI_PESSOAL;                                                                                                              
--*******************************************************                                                                           
-- TAB(CADASTROS): 9082368  TAB REF(PAISES): 644                                                                                    
create index EMP_PAI_FK on IFRSRH.CADASTROS                                                                                         
(EMP_PAI_CODIGO)                                                                                                                    
Tablespace TSI_PESSOAL;                                                                                                              
--*******************************************************                                                                           
-- TAB(CADASTROS): 9082368  TAB REF(POSTO_GRADUACAO): 684                                                                           
create index EMP_POSTO_GRADUACAO_CODIGO_FK on IFRSRH.CADASTROS                                                                      
(EMP_POSTO_GRADUACAO_CODIGO)                                                                                                        
Tablespace TSI_PESSOAL;                                                                                                              
--*******************************************************                                                                           
-- TAB(CADASTROS): 9082368  TAB REF(QUADRO_FUNCOES): 156924                                                                         
create index EMP_QFU_ESTAR_SUBSTITUINDO_FK on IFRSRH.CADASTROS                                                                      
(EMP_QFU_FUN_CODIGO_SUBSTITUI,EMP_QFU_HFL_UOR_COD_SUBST,EMP_QFU_HFL_DATA_VIGEN_SUBST)                                               
Tablespace TSI_PESSOAL;                                                                                                              
--*******************************************************                                                                           
-- TAB(CADASTROS): 9082368  TAB REF(QUADRO_FUNCOES): 156924                                                                         
create index EMP_QFU_FK on IFRSRH.CADASTROS                                                                                         
(EMP_QFU_FUN_CODIGO,EMP_QFU_HFL_UOR_CODIGO,EMP_QFU_HFL_DATA_VIGENCIA)                                                               
Tablespace TSI_PESSOAL;                                                                                                              
--*******************************************************                                                                           
-- TAB(CADASTROS): 9082368  TAB REF(QUADROS_LOTACAO_PESSOAL): 546156                                                                
create index EMP_QLP_FK on IFRSRH.CADASTROS                                                                                         
(EMP_QLP_HCL_UOR_CODIGO,EMP_QLP_HCL_DATA_VIGENCIA,EMP_QLP_CAR_CODIGO,EMP_QLP_CAR_CODIGO_NIVEL,EMP_QLP_CAR_OCC_CODIGO)               
Tablespace TSI_PESSOAL;                                                                                                              
--*******************************************************                                                                           
-- TAB(CADASTROS): 9082368  TAB REF(QUADRO_ARMA_ESPEC): 210                                                                         
create index EMP_QUADRO_ARMA_ESP_CODIGO_FK on IFRSRH.CADASTROS                                                                      
(EMP_QUADRO_ARMA_ESP_CODIGO)                                                                                                        
Tablespace TSI_PESSOAL;                                                                                                              
--*******************************************************                                                                           
-- TAB(CADASTROS): 9082368  TAB REF(UNIDADES_FEDERACAO): 448                                                                        
create index EMP_UFE_CI_FK on IFRSRH.CADASTROS                                                                                      
(EMP_UFE_SIGLA_CI)                                                                                                                  
Tablespace TSI_PESSOAL;                                                                                                              
--*******************************************************                                                                           
-- TAB(CADASTROS): 9082368  TAB REF(UNIDADES_FEDERACAO): 448                                                                        
create index EMP_UFE_CTPS_FK on IFRSRH.CADASTROS                                                                                    
(EMP_UFE_SIGLA_CTPS)                                                                                                                
Tablespace TSI_PESSOAL;                                                                                                              
--*******************************************************                                                                           
-- TAB(CADASTROS): 9082368  TAB REF(UNIDADES_FEDERACAO): 448                                                                        
create index EMP_UFE_ESTRANG_REG_FK on IFRSRH.CADASTROS                                                                             
(EMP_UFE_SIGLA_ESTRANGEIRO)                                                                                                         
Tablespace TSI_PESSOAL;                                                                                                              
--*******************************************************                                                                           
-- TAB(CADASTROS): 9082368  TAB REF(UNIDADES_FEDERACAO): 448                                                                        
create index EMP_UFE_PRIMEIRO_EMPREGO_FK on IFRSRH.CADASTROS                                                                        
(EMP_UFE_SIGLA_PRIMEIRO_EMPREGO)                                                                                                    
Tablespace TSI_PESSOAL;                                                                                                              
--*******************************************************                                                                           
-- TAB(CADASTROS): 9082368  TAB REF(UNIDADES_FEDERACAO): 448                                                                        
create index EMP_UFE_REG_PROFIS_FK on IFRSRH.CADASTROS                                                                              
(EMP_UFE_SIGLA_REG_PROFIS)                                                                                                          
Tablespace TSI_PESSOAL;                                                                                                              
--*******************************************************                                                                           
-- TAB(CADASTROS): 9082368  TAB REF(UNIDADES_FEDERACAO): 448                                                                        
create index EMP_UFE_TIT_ELEITORAL_FK on IFRSRH.CADASTROS                                                                           
(EMP_UFE_SIGLA_TIT_ELEITOR)                                                                                                         
Tablespace TSI_PESSOAL;                                                                                                              
--*******************************************************                                                                           
-- TAB(CBO): 130860  TAB REF(CBO): 130860                                                                                           
create index CBO_CBO_FK on IFRSRH.CBO                                                                                               
(CBO_CBO_CODIGO,CBO_CBO_DTA_INICIO)                                                                                                 
Tablespace TSI_PESSOAL;                                                                                                              
--*******************************************************                                                                           
-- TAB(CONTROLE_USUARIO_DEPENDENCIA): 1869372  TAB REF(DEPENDENCIAS): 42120                                                         
create index CUD_DEP_FK on IFRSRH.CONTROLE_USUARIO_DEPENDENCIA                                                                      
(DEP_CD_DEPENDENCIA)                                                                                                                
Tablespace TSI_PESSOAL;                                                                                                              
--*******************************************************                                                                           
-- TAB(CONTROLE_USUARIO_DEPENDENCIA): 1869372  TAB REF(SEG_SISTEMA): 931                                                            
create index CUD_SS_FK on IFRSRH.CONTROLE_USUARIO_DEPENDENCIA                                                                       
(SSI_CD_SISTEMA)                                                                                                                    
Tablespace TSI_PESSOAL;                                                                                                              
--*******************************************************                                                                           
-- TAB(CONTROLE_USUARIOS_FUNCOES): 7291980  TAB REF(CARGOS_CONFIANCA): 73884                                                        
create index CUF_FUN_FK on IFRSRH.CONTROLE_USUARIOS_FUNCOES                                                                         
(FUN_CODIGO)                                                                                                                        
Tablespace TSI_PESSOAL;                                                                                                              
--*******************************************************                                                                           
-- TAB(CONTROLE_USUARIOS_FUNCOES): 7291980  TAB REF(SEG_SISTEMA): 931                                                               
create index FK_CUF_SS on IFRSRH.CONTROLE_USUARIOS_FUNCOES                                                                          
(SS_CD_SISTEMA)                                                                                                                     
Tablespace TSI_PESSOAL;                                                                                                              
--*******************************************************                                                                           
-- TAB(CONTROLE_USUARIOS_OCORRENCIAS): 3827520  TAB REF(TIPOS_OCORRENCIAS): 21760                                                   
create index CUO_OFU_FK on IFRSRH.CONTROLE_USUARIOS_OCORRENCIAS                                                                     
(OFU_CODIGO)                                                                                                                        
Tablespace TSI_PESSOAL;                                                                                                              
--*******************************************************                                                                           
-- TAB(CONTROLE_USUARIOS_OCORRENCIAS): 3827520  TAB REF(SEG_SISTEMA): 931                                                           
create index FK_CUO_SS on IFRSRH.CONTROLE_USUARIOS_OCORRENCIAS                                                                      
(SS_CD_SISTEMA)                                                                                                                     
Tablespace TSI_PESSOAL;                                                                                                              
--*******************************************************                                                                           
-- TAB(CORPO_CLINICO): 612096  TAB REF(CREDENCIADOS_BENEFICIOS): 28960                                                              
create index CC_CBE_FK on IFRSRH.CORPO_CLINICO                                                                                      
(CC_CBE_BEN_SIGLA,CC_CRE_COD_SEQUE)                                                                                                 
Tablespace TSI_PESSOAL;                                                                                                              
--*******************************************************                                                                           
-- TAB(CREDENCIADOS): 1066800  TAB REF(DEPENDENCIAS): 42120                                                                         
create index CRE_DEP_FK on IFRSRH.CREDENCIADOS                                                                                      
(CRE_DEP_RESP_INCL)                                                                                                                 
Tablespace TSI_PESSOAL;                                                                                                              
--*******************************************************                                                                           
-- TAB(CREDENCIADOS): 1066800  TAB REF(ORGAOS_CLASSES): 629                                                                         
create index CRE_OCL_FK on IFRSRH.CREDENCIADOS                                                                                      
(CRE_OCL_SIGLA)                                                                                                                     
Tablespace TSI_PESSOAL;                                                                                                              
--*******************************************************                                                                           
-- TAB(CREDENCIADOS_CONTRATOS): 678224  TAB REF(DEPENDENCIAS): 42120                                                                
create index CC_DEP_FK on IFRSRH.CREDENCIADOS_CONTRATOS                                                                             
(CC_DEP_CODIGO)                                                                                                                     
Tablespace TSI_PESSOAL;                                                                                                              
--*******************************************************                                                                           
-- TAB(CRONOGRAMAS_PAGAMENTOS): 2036452  TAB REF(EVENTOS_PAGAMENTOS): 495                                                           
create index CRP_EPG_FK on IFRSRH.CRONOGRAMAS_PAGAMENTOS                                                                            
(CRP_EPG_CODIGO)                                                                                                                    
Tablespace TSI_PESSOAL;                                                                                                              
--*******************************************************                                                                           
-- TAB(DATAPREV_REEMBOLSO_RUBRICAS): 440324  TAB REF(DATAPREV_REEMBOLSO): 32300                                                     
create index DRR_DR_FK on IFRSRH.DATAPREV_REEMBOLSO_RUBRICAS                                                                        
(DRR_ANO_REFERENCIA,DRR_MES_REFERENCIA,DRR_EMP_NUMERO_MATRICULA,DRR_COD_BENEFICIO,DRR_COD_BENEF_SEQUENCIAL)                         
Tablespace TSI_PESSOAL;                                                                                                              
--*******************************************************                                                                           
-- TAB(DEMONSTRATIVO_CUSTO_BENEFICIO): 1677060  TAB REF(DEPENDENCIAS): 42120                                                        
create index DCB_DEP_FK on IFRSRH.DEMONSTRATIVO_CUSTO_BENEFICIO                                                                     
(DCB_DEP_CODIGO)                                                                                                                    
Tablespace TSI_PESSOAL;                                                                                                              
--*******************************************************                                                                           
-- TAB(DEPENDENTES_USU_PLANO_SAUDE): 876480  TAB REF(CADASTROS): 9082368                                                            
create index DUS_EMP_FK on IFRSRH.DEPENDENTES_USU_PLANO_SAUDE                                                                       
(DUS_EMP_NUMERO_MATRICULA)                                                                                                          
Tablespace TSI_PESSOAL;                                                                                                              
--*******************************************************                                                                           
-- TAB(DEPENDENTES_USU_PLANO_SAUDE): 876480  TAB REF(PESSOAS_VINCULADAS): 5279128                                                   
create index DUS_PVI_FK on IFRSRH.DEPENDENTES_USU_PLANO_SAUDE                                                                       
(DUS_EMP_NUMERO_MATRICULA,DUS_PVI_SEQUENCIAL)                                                                                       
Tablespace TSI_PESSOAL;                                                                                                              
--*******************************************************                                                                           
-- TAB(DOCUMENTOS_COBRANCA): 6704388  TAB REF(RETENCAO_IMPOSTOS): 90                                                                
create index DOC_RI_FK on IFRSRH.DOCUMENTOS_COBRANCA                                                                                
(DOC_RI_COD_RECEITA,DOC_RI_DAT_INICIO)                                                                                              
Tablespace TSI_PESSOAL;                                                                                                              
--*******************************************************                                                                           
-- TAB(EFETIVO_INFRAERO): 196000  TAB REF(DEPENDENCIAS): 42120                                                                      
create index EIN_DEP_FK on IFRSRH.EFETIVO_INFRAERO                                                                                  
(EIN_DEP_CODIGO)                                                                                                                    
Tablespace TSI_PESSOAL;                                                                                                              
--*******************************************************                                                                           
-- TAB(EMPREGADOS_CATEGORIAS): 370368  TAB REF(CATEGORIAS_TRANSPORTE): 57744                                                        
create index EMC_CAT_FK on IFRSRH.EMPREGADOS_CATEGORIAS                                                                             
(EMC_CAT_DEP_CODIGO,EMC_CAT_SIGLA)                                                                                                  
Tablespace TSI_PESSOAL;                                                                                                              
--*******************************************************                                                                           
-- TAB(EMPREGADOS_CATEGORIAS): 370368  TAB REF(DEPENDENCIAS): 42120                                                                 
create index EMC_DEP_FK on IFRSRH.EMPREGADOS_CATEGORIAS                                                                             
(EMC_DEP_RESP_INCL)                                                                                                                 
Tablespace TSI_PESSOAL;                                                                                                              
--*******************************************************                                                                           
-- TAB(EMPREGADOS_PAGAMENTOS): 119463792  TAB REF(DEPENDENCIAS): 42120                                                              
create index EGT_DEP_FK on IFRSRH.EMPREGADOS_PAGAMENTOS                                                                             
(EGT_DEP_CODIGO)                                                                                                                    
Tablespace TSI_PESSOAL;                                                                                                              
--*******************************************************                                                                           
-- TAB(EMPREGADOS_PAGAMENTOS): 119463792  TAB REF(UNIDADES_ORGANIZACIONAIS): 835200                                                 
create index EGT_UOR_FK on IFRSRH.EMPREGADOS_PAGAMENTOS                                                                             
(EGT_UOR_CODIGO)                                                                                                                    
Tablespace TSI_PESSOAL;                                                                                                              
--*******************************************************                                                                           
-- TAB(EMPREGADOS_PARTICIPACAO_LUCROS): 8021112  TAB REF(DEPENDENCIAS): 42120                                                       
create index DEP_FK on IFRSRH.EMPREGADOS_PARTICIPACAO_LUCROS                                                                        
(EPL_DEP_CODIGO_LOTACAO)                                                                                                            
Tablespace TSI_PESSOAL;                                                                                                              
--*******************************************************                                                                           
-- TAB(EMPRESTIMOS_INFRAPREV): 691740  TAB REF(CADASTROS): 9082368                                                                  
create index EMPREST_INFRAP_VAL_CADASTROS on IFRSRH.EMPRESTIMOS_INFRAPREV                                                           
(NUM_MATRICULA_EMPREGADO)                                                                                                           
Tablespace TSI_PESSOAL;                                                                                                              
--*******************************************************                                                                           
-- TAB(GUIAS): 34494460  TAB REF(AUTORIZACOES_SERVICOS_MEDICOS): 31536                                                              
create index FK_GUI_ASM on IFRSRH.GUIAS                                                                                             
(GUI_ASM_SENHA)                                                                                                                     
Tablespace TSI_PESSOAL;                                                                                                              
--*******************************************************                                                                           
-- TAB(GUIAS): 34494460  TAB REF(PESSOAS_VINCULADAS_BENEF): 2849644                                                                 
create index GUI_PVB_FK on IFRSRH.GUIAS                                                                                             
(GUI_EMP_NUMERO_MATRICULA,GUI_PVI_SEQUENCIAL,GUI_DOC_CBE_BEN_SIGLA,GUI_PVB_ADESAO)                                                  
Tablespace TSI_PESSOAL;                                                                                                              
--*******************************************************                                                                           
-- TAB(GUIAS_PROCEDIMENTOS): 62057472  TAB REF(ABO): 35960                                                                          
create index GPR_ABO_FK on IFRSRH.GUIAS_PROCEDIMENTOS                                                                               
(GPR_ABO_CODIGO)                                                                                                                    
Tablespace TSI_PESSOAL;                                                                                                              
--*******************************************************                                                                           
-- TAB(HISTORICO_CARGOS_LOTACAO): 242136  TAB REF(HISTORICO_CARGOS_DEPENDENCIAS): 25200                                             
create index ICL_HCD_FK on IFRSRH.HISTORICO_CARGOS_LOTACAO                                                                          
(ICL_HCD_DEP_CODIGO,ICL_HCD_DATA_VIGENCIA)                                                                                          
Tablespace TSI_PESSOAL;                                                                                                              
--*******************************************************                                                                           
-- TAB(HISTORICOS_FUNCOES_LOTACOES): 231600  TAB REF(HISTORICOS_FUNCOES_DEPENDENCIA): 14112                                         
create index HFL_HFD_FK on IFRSRH.HISTORICOS_FUNCOES_LOTACOES                                                                       
(HFL_HFD_DEP_CODIGO,HFL_HFD_DATA_VIGENCIA)                                                                                          
Tablespace TSI_PESSOAL;                                                                                                              
--*******************************************************                                                                           
-- TAB(HONORARIOS_MEDICOS): 456608  TAB REF(GUIAS_PROCEDIMENTOS): 62057472                                                          
create index HNM_GPR_FK on IFRSRH.HONORARIOS_MEDICOS                                                                                
(HNM_GPR_GUI_DOC_NUMERO,HNM_GPR_GUI_DOC_CBE_BEN_SIGLA,HNM_GPR_GUI_DOC_CBE_CRE_SEQ,HNM_GPR_GUI_DOC_DEP_CODIGO,HNM_GPR_GUI_NUMERO,HNM_
GPR_SEQUENCIAL)                                                                                                                     
Tablespace TSI_PESSOAL;                                                                                                              
--*******************************************************                                                                           
-- TAB(INDICE_ABSENTEISMO): 4382668  TAB REF(DEPENDENCIAS): 42120                                                                   
create index IAB_DEP_FK on IFRSRH.INDICE_ABSENTEISMO                                                                                
(IAB_DEP_CODIGO)                                                                                                                    
Tablespace TSI_PESSOAL;                                                                                                              
--*******************************************************                                                                           
-- TAB(INDICE_ABSENTEISMO): 4382668  TAB REF(TIPOS_OCORRENCIAS): 21760                                                              
create index IAB_OFU_FK on IFRSRH.INDICE_ABSENTEISMO                                                                                
(IAB_OFU_CODIGO)                                                                                                                    
Tablespace TSI_PESSOAL;                                                                                                              
--*******************************************************                                                                           
-- TAB(LPM): 306680  TAB REF(ESPECIALIDADES): 43136                                                                                 
create index LPM_ESP_TIPO_FK on IFRSRH.LPM                                                                                          
(LPM_ESP_TIPO,LPM_ESP_NUMERO)                                                                                                       
Tablespace TSI_PESSOAL;                                                                                                              
--*******************************************************                                                                           
-- TAB(MOVIMENTACAO): 1191279240  TAB REF(FORMULAS): 18876                                                                          
create index MOV_FORM_FK on IFRSRH.MOVIMENTACAO                                                                                     
(MOV_FOR_CODIGO)                                                                                                                    
Tablespace TSI_PESSOAL;                                                                                                              
--*******************************************************                                                                           
-- TAB(MOVIMENTACAO): 1191279240  TAB REF(PENSIONISTAS): 244760                                                                     
create index MOV_PEN_FK on IFRSRH.MOVIMENTACAO                                                                                      
(MOV_EMP_NUMERO_MATRICULA,MOV_PEN_CODIGO)                                                                                           
Tablespace TSI_PESSOAL;                                                                                                              
--*******************************************************                                                                           
-- TAB(MOVIMENTACAO): 1191279240  TAB REF(RUBRICAS): 32076                                                                          
create index MOV_RUB_FK on IFRSRH.MOVIMENTACAO                                                                                      
(MOV_RUB_CODIGO)                                                                                                                    
Tablespace TSI_PESSOAL;                                                                                                              
--*******************************************************                                                                           
-- TAB(OCORRENCIAS_EMPREGADOS): 118848048  TAB REF(DEPENDENCIAS): 42120                                                             
create index OEM_DEP_FK on IFRSRH.OCORRENCIAS_EMPREGADOS                                                                            
(OEM_DEP_CODIGO)                                                                                                                    
Tablespace TSI_PESSOAL;                                                                                                              
--*******************************************************                                                                           
-- TAB(OCORRENCIAS_EMPREGADOS): 118848048  TAB REF(PROGRAMACOES_FERIAS): 16444800                                                   
create index OEM_PFE_CONFIRM1_FK on IFRSRH.OCORRENCIAS_EMPREGADOS                                                                   
(OEM_PFE_EMP_NUM_MATR_CONFIRM1,OEM_PFE_SEQUENCIAL_CONFIRM1)                                                                         
Tablespace TSI_PESSOAL;                                                                                                              
--*******************************************************                                                                           
-- TAB(OCORRENCIAS_EMPREGADOS): 118848048  TAB REF(PROGRAMACOES_FERIAS): 16444800                                                   
create index OEM_PFE_CONFIRM2_FK on IFRSRH.OCORRENCIAS_EMPREGADOS                                                                   
(OEM_PFE_EMP_NUM_MATR_CONFIRM2,OEM_PFE_SEQUENCIAL_CONFIRM2)                                                                         
Tablespace TSI_PESSOAL;                                                                                                              
--*******************************************************                                                                           
-- TAB(OCORRENCIAS_EMPREGADOS): 118848048  TAB REF(PROGRAMACOES_FERIAS): 16444800                                                   
create index OEM_PFE_PROGRAM_FK on IFRSRH.OCORRENCIAS_EMPREGADOS                                                                    
(OEM_PFE_EMP_NUM_MATR_PROGRAM,OEM_PFE_SEQUENCIAL_PROGRAM)                                                                           
Tablespace TSI_PESSOAL;                                                                                                              
--*******************************************************                                                                           
-- TAB(OCORRENCIAS_PIS_PASEP_EMP): 3841344  TAB REF(OCORRENCIAS_PIS_PASEP): 3600                                                    
create index OPPE_OPP_FK on IFRSRH.OCORRENCIAS_PIS_PASEP_EMP                                                                        
(OCO_NOME_ARQUIVO,OCO_CODIGO_OCORRENCIA,OCO_TIPO_OCORRENCIA)                                                                        
Tablespace TSI_PESSOAL;                                                                                                              
--*******************************************************                                                                           
-- TAB(OCORRENCIAS_RECEB_TICKETS): 39325440  TAB REF(DEPENDENCIAS): 42120                                                           
create index ORT_DEP_FK on IFRSRH.OCORRENCIAS_RECEB_TICKETS                                                                         
(ORT_DEP_CODIGO)                                                                                                                    
Tablespace TSI_PESSOAL;                                                                                                              
--*******************************************************                                                                           
-- TAB(OCORRENCIAS_RECEB_TICKETS): 39325440  TAB REF(EMPREGADOS_BENEFICIOS): 3130200                                                
create index ORT_EMB_FK on IFRSRH.OCORRENCIAS_RECEB_TICKETS                                                                         
(ORT_EMB_EMP_NUMERO_MATRICULA,ORT_EMB_BEN_SIGLA)                                                                                    
Tablespace TSI_PESSOAL;                                                                                                              
--*******************************************************                                                                           
-- TAB(OCORRENCIAS_RECEB_TICKETS): 39325440  TAB REF(UNIDADES_ORGANIZACIONAIS): 835200                                              
create index ORT_UOR_FK on IFRSRH.OCORRENCIAS_RECEB_TICKETS                                                                         
(ORT_UOR_CODIGO)                                                                                                                    
Tablespace TSI_PESSOAL;                                                                                                              
--*******************************************************                                                                           
-- TAB(OCORRENCIAS_RECEB_VALES): 43054620  TAB REF(UNIDADES_ORGANIZACIONAIS): 835200                                                
create index ORV_UOR_FK on IFRSRH.OCORRENCIAS_RECEB_VALES                                                                           
(ORV_UOR_CODIGO)                                                                                                                    
Tablespace TSI_PESSOAL;                                                                                                              
--*******************************************************                                                                           
-- TAB(PEDIDOS_TICKETS): 1380552  TAB REF(DEPENDENCIAS): 42120                                                                      
create index PKT_DEP_FK on IFRSRH.PEDIDOS_TICKETS                                                                                   
(PKT_DEP_RESP_INCL)                                                                                                                 
Tablespace TSI_PESSOAL;                                                                                                              
--*******************************************************                                                                           
-- TAB(PENSIONISTAS): 244760  TAB REF(FORMULAS): 18876                                                                              
create index PEN_FOR_FERIAS_FK on IFRSRH.PENSIONISTAS                                                                               
(PEN_FOR_CODIGO_FERIAS)                                                                                                             
Tablespace TSI_PESSOAL;                                                                                                              
--*******************************************************                                                                           
-- TAB(PENSIONISTAS): 244760  TAB REF(FORMULAS): 18876                                                                              
create index PEN_FOR_FK on IFRSRH.PENSIONISTAS                                                                                      
(PEN_FOR_CODIGO)                                                                                                                    
Tablespace TSI_PESSOAL;                                                                                                              
--*******************************************************                                                                           
-- TAB(PENSIONISTAS): 244760  TAB REF(FORMULAS): 18876                                                                              
create index PEN_FOR_13_FK on IFRSRH.PENSIONISTAS                                                                                   
(PEN_FOR_CODIGO_13)                                                                                                                 
Tablespace TSI_PESSOAL;                                                                                                              
--*******************************************************                                                                           
-- TAB(PESSOAS_VINCULADAS): 5279128  TAB REF(MUNICIPIOS): 101764                                                                    
create index PVI_MUN_FK on IFRSRH.PESSOAS_VINCULADAS                                                                                
(PVI_MUN_CODIGO_NATURALIDADE,PVI_UFE_SIGLA_NATURALIDADE)                                                                            
Tablespace TSI_PESSOAL;                                                                                                              
--*******************************************************                                                                           
-- TAB(PESSOAS_VINCULADAS): 5279128  TAB REF(PAISES): 644                                                                           
create index PVI_PAI_CODIGO_FK on IFRSRH.PESSOAS_VINCULADAS                                                                         
(PVI_PAI_CODIGO)                                                                                                                    
Tablespace TSI_PESSOAL;                                                                                                              
--*******************************************************                                                                           
-- TAB(PESSOAS_VINCULADAS): 5279128  TAB REF(TIPO_VINCULOS): 750                                                                    
create index PVI_TPV_FK on IFRSRH.PESSOAS_VINCULADAS                                                                                
(PVI_TPV_CODIGO)                                                                                                                    
Tablespace TSI_PESSOAL;                                                                                                              
--*******************************************************                                                                           
-- TAB(PESSOAS_VINCULADAS_BENEF): 2849644  TAB REF(BENEFICIOS): 4270                                                                
create index PVB_BEN_FK on IFRSRH.PESSOAS_VINCULADAS_BENEF                                                                          
(EMB_BEN_SIGLA)                                                                                                                     
Tablespace TSI_PESSOAL;                                                                                                              
--*******************************************************                                                                           
-- TAB(PROCEDIMENTOS_ODONTOLOGICOS): 4203572  TAB REF(DEPENDENCIAS): 42120                                                          
create index PROCED_ODONT_VAL_DEPENDEN on IFRSRH.PROCEDIMENTOS_ODONTOLOGICOS                                                        
(POD_DEP_RESP_INCL)                                                                                                                 
Tablespace TSI_PESSOAL;                                                                                                              
--*******************************************************                                                                           
-- TAB(PROVISOES_EMPREGADOS): 19769760  TAB REF(CADASTROS): 9082368                                                                 
create index PROV_EMPREG_VAL_CADASTROS on IFRSRH.PROVISOES_EMPREGADOS                                                               
(EMP_NUMERO_MATRICULA)                                                                                                              
Tablespace TSI_PESSOAL;                                                                                                              
--*******************************************************                                                                           
-- TAB(QUADRO_CARGOS_DEPENDENCIAS): 220080  TAB REF(CARGOS): 85408                                                                  
create index QCD_CAR_FK on IFRSRH.QUADRO_CARGOS_DEPENDENCIAS                                                                        
(QCD_CAR_CODIGO,QCD_CAR_CODIGO_NIVEL,QCD_CAR_OCC_CODIGO)                                                                            
Tablespace TSI_PESSOAL;                                                                                                              
--*******************************************************                                                                           
-- TAB(QUADRO_FUNCOES): 156924  TAB REF(HISTORICOS_FUNCOES_LOTACOES): 231600                                                        
create index QFU_HFL_FK on IFRSRH.QUADRO_FUNCOES                                                                                    
(QFU_HFL_UOR_CODIGO,QFU_HFL_DATA_VIGENCIA)                                                                                          
Tablespace TSI_PESSOAL;                                                                                                              
--*******************************************************                                                                           
-- TAB(QUADROS_LOTACAO_PESSOAL): 546156  TAB REF(CARGOS): 85408                                                                     
create index QLP_CAR_FK on IFRSRH.QUADROS_LOTACAO_PESSOAL                                                                           
(QLP_CAR_CODIGO,QLP_CAR_CODIGO_NIVEL,QLP_CAR_OCC_CODIGO)                                                                            
Tablespace TSI_PESSOAL;                                                                                                              
--*******************************************************                                                                           
-- TAB(REEMBOLSOS): 5158616  TAB REF(DEPENDENCIAS): 42120                                                                           
create index REEMBOLSOS_FK_DEPENDENCIAS on IFRSRH.REEMBOLSOS                                                                        
(REE_DEP_RESP_INCL)                                                                                                                 
Tablespace TSI_PESSOAL;                                                                                                              
--*******************************************************                                                                           
-- TAB(RESUMO_ENCARGOS_INFRAPREV): 15606144  TAB REF(CADASTROS): 9082368                                                            
create index RIN_CAD_FK on IFRSRH.RESUMO_ENCARGOS_INFRAPREV                                                                         
(RIN_EMP_NUMERO_MATRICULA)                                                                                                          
Tablespace TSI_PESSOAL;                                                                                                              
--*******************************************************                                                                           
-- TAB(RESUMO_ENCARGOS_INSS): 13022196  TAB REF(CADASTROS): 9082368                                                                 
create index REI_EMP_FK on IFRSRH.RESUMO_ENCARGOS_INSS                                                                              
(REI_EMP_NUMERO_MATRICULA)                                                                                                          
Tablespace TSI_PESSOAL;                                                                                                              
--*******************************************************                                                                           
-- TAB(RESUMO_ENCARGOS_INSS_AUTONOMO): 762684  TAB REF(CREDENCIADOS): 1066800                                                       
create index REA_CRE_FK on IFRSRH.RESUMO_ENCARGOS_INSS_AUTONOMO                                                                     
(REA_CRE_SEQUENCIAL)                                                                                                                
Tablespace TSI_PESSOAL;                                                                                                              
--*******************************************************                                                                           
-- TAB(RESUMO_ENCARGOS_INSS_AUTONOMO): 762684  TAB REF(DEPENDENCIAS): 42120                                                         
create index REIA_DEP_FK on IFRSRH.RESUMO_ENCARGOS_INSS_AUTONOMO                                                                    
(REA_DEP_CODIGO)                                                                                                                    
Tablespace TSI_PESSOAL;                                                                                                              
--*******************************************************                                                                           
-- TAB(RESUMO_ENCARGOS_IRRF): 7545408  TAB REF(CADASTROS): 9082368                                                                  
create index RIR_CAD_FK on IFRSRH.RESUMO_ENCARGOS_IRRF                                                                              
(RIR_EMP_NUMERO_MATRICULA)                                                                                                          
Tablespace TSI_PESSOAL;                                                                                                              
--*******************************************************                                                                           
-- TAB(RESUMO_ENCARGOS_SAL_EDUCACAO): 7602336  TAB REF(CADASTROS): 9082368                                                          
create index RSE_CAD_FK on IFRSRH.RESUMO_ENCARGOS_SAL_EDUCACAO                                                                      
(RSE_EMP_NUMERO_MATRICULA)                                                                                                          
Tablespace TSI_PESSOAL;                                                                                                              
--*******************************************************                                                                           
-- TAB(SIAD_AVALIACAO_FINAL): 544980  TAB REF(SIAD_ESCALA_PONTUACAO): 630                                                           
create index AV_FINAL_ESCALA_FK on IFRSRH.SIAD_AVALIACAO_FINAL                                                                      
(ANO_ESCALA,TIPO_ESCALA,CODIGO_CLASSIFICACAO)                                                                                       
Tablespace TSI_PESSOAL;                                                                                                              
--*******************************************************                                                                           
-- TAB(SPF_EMPREGADO_IND_INSUFICIENCI): 407160  TAB REF(CADASTROS): 9082368                                                         
create index EII_CADAST_FK on IFRSRH.SPF_EMPREGADO_IND_INSUFICIENCI                                                                 
(MATRICULA_EMP_INDICADO_INS)                                                                                                        
Tablespace TSI_PESSOAL;                                                                                                              
--*******************************************************                                                                           
-- TAB(SPF_EMPREGADO_IND_PROMOCAO): 250444  TAB REF(CADASTROS): 9082368                                                             
create index EIP_CADATR_FK on IFRSRH.SPF_EMPREGADO_IND_PROMOCAO                                                                     
(MATRICULA_EMP_INDICADO_PROM)                                                                                                       
Tablespace TSI_PESSOAL;                                                                                                              
--*******************************************************                                                                           
-- TAB(SPF_EMPREGADO_PROMOVIDO): 1214056  TAB REF(CARGOS): 85408                                                                    
create index EMP_PROM_CARGOS_FK on IFRSRH.SPF_EMPREGADO_PROMOVIDO                                                                   
(CARGOS_CAR_CODIGO,CARGOS_CAR_CODIGO_NIVEL,CARGOS_OCUCARGO_OCC_CODIGO)                                                              
Tablespace TSI_PESSOAL;                                                                                                              
--*******************************************************                                                                           
-- TAB(SPF_EMPREGADO_PROMOVIDO): 1214056  TAB REF(SPF_PROMOCAO): 1022                                                               
create index EMP_PROM_PROMOCAO_FK on IFRSRH.SPF_EMPREGADO_PROMOVIDO                                                                 
(PROMOCAO_TIPOS_OCOR_OFU_CODIGO,PROMOCAO_ANO_PROMOCAO)                                                                              
Tablespace TSI_PESSOAL;                                                                                                              
--*******************************************************                                                                           
-- TAB(TAB_DESPESA_MEDICAMENTOS): 5843448  TAB REF(GUIAS): 34494460                                                                 
create index TDM_GUI_FK on IFRSRH.TAB_DESPESA_MEDICAMENTOS                                                                          
(TDM_GUI_DOC_NUMERO,TDM_GUI_DOC_CBE_BEN_SIGLA,TDM_GUI_DOC_CBE_CRE_SEQUENCIAL,TDM_GUI_DOC_DEP_CODIGO,TDM_GUI_NUMERO)                 
Tablespace TSI_PESSOAL;                                                                                                              
--*******************************************************                                                                           
-- TAB(TEMP_MOVIMENTACAO): 1098144  TAB REF(FORMULAS): 18876                                                                        
create index TEMP_MOV_FORM_FK on IFRSRH.TEMP_MOVIMENTACAO                                                                           
(MOV_FOR_CODIGO)                                                                                                                    
Tablespace TSI_PESSOAL;                                                                                                              
--*******************************************************                                                                           
-- TAB(TEMP_MOVIMENTACAO): 1098144  TAB REF(PENSIONISTAS): 244760                                                                   
create index TEMP_MOV_PEN_FK on IFRSRH.TEMP_MOVIMENTACAO                                                                            
(MOV_EMP_NUMERO_MATRICULA,MOV_PEN_CODIGO)                                                                                           
Tablespace TSI_PESSOAL;                                                                                                              
--*******************************************************                                                                           
-- TAB(TEMP_MOVIMENTACAO): 1098144  TAB REF(RUBRICAS): 32076                                                                        
create index TEMP_MOV_RUB_FK on IFRSRH.TEMP_MOVIMENTACAO                                                                            
(MOV_RUB_CODIGO)                                                                                                                    
Tablespace TSI_PESSOAL;                                                                                                              
--*******************************************************                                                                           
-- TAB(USUARIOS_PLANOS_SAUDE): 267904  TAB REF(DEPENDENCIAS): 42120                                                                 
create index UPS_DEP_FK on IFRSRH.USUARIOS_PLANOS_SAUDE                                                                             
(UPS_DEP_CODIGO)                                                                                                                    
Tablespace TSI_PESSOAL;                                                                                                              
--*******************************************************                                                                           
-- TAB(USUARIOS_PLANOS_SAUDE): 267904  TAB REF(CADASTROS): 9082368                                                                  
create index UPS_EMP_FK on IFRSRH.USUARIOS_PLANOS_SAUDE                                                                             
(UPS_EMP_NUMERO_MATRICULA)                                                                                                          
Tablespace TSI_PESSOAL;                                                                                                              
