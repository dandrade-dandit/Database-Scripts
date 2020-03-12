*****************************************************************************************                                           
select (count(*) * 66) from IFRSRH.AVERBACAO_TSERVICO;                                                                              
select (count(*) * ) from IFRSRH.ABATIMENTO_AVERBACAO;                                                                              
--create index ABT_AVB_FK on IFRSRH.ABATIMENTO_AVERBACAO                                                                            
(ABT_AVB_CODIGO,ABT_AVB_EMP_NUMERO_MATRICULA)                                                                                       
Tablespace TSD_INDICE;                                                                                                              
*****************************************************************************************                                           
select (count(*) * 425) from IFRSRH.ESPECIALIDADES;                                                                                 
select (count(*) * 63) from IFRSRH.ABO;                                                                                             
--create index ABO_ESP_TIPO_FK on IFRSRH.ABO                                                                                        
(ESP_TIPO,ABO_ESP_NUMERO)                                                                                                           
Tablespace TSD_INDICE;                                                                                                              
*****************************************************************************************                                           
select (count(*) * 232) from IFRSRH.CREDENCIADOS;                                                                                   
select (count(*) * 67) from IFRSRH.ABO_LOCAL;                                                                                       
--create index ABL_CRE_SEQUENCIAL_FK on IFRSRH.ABO_LOCAL                                                                            
(ABL_CRE_SEQUENCIAL)                                                                                                                
Tablespace TSD_INDICE;                                                                                                              
*****************************************************************************************                                           
select (count(*) * 244) from IFRDBA2.DEPENDENCIAS;                                                                                  
select (count(*) * 67) from IFRSRH.ABO_LOCAL;                                                                                       
--create index ABL_DEP_CODIGO_FK on IFRSRH.ABO_LOCAL                                                                                
(ABL_DEP_CODIGO)                                                                                                                    
Tablespace TSD_INDICE;                                                                                                              
*****************************************************************************************                                           
select (count(*) * 14) from IFRSRH.CREDENCIADOS_ESPECIALIDADES;                                                                     
select (count(*) * 18) from IFRSRH.AGENDAS_MEDICAS;                                                                                 
--create index AGM_CDE_FK on IFRSRH.AGENDAS_MEDICAS                                                                                 
(AGM_CDE_CRE_SEQUENCIAL,AGM_CDE_ESP_TIPO,AGM_CDE_ESP_NUMERO)                                                                        
Tablespace TSD_INDICE;                                                                                                              
*****************************************************************************************                                           
select (count(*) * 425) from IFRSRH.ESPECIALIDADES;                                                                                 
select (count(*) * 82) from IFRSRH.AMB;                                                                                             
--create index AMB_ESP_TIPO_FK on IFRSRH.AMB                                                                                        
(AMB_ESP_TIPO,AMB_ESP_NUMERO)                                                                                                       
Tablespace TSD_INDICE;                                                                                                              
*****************************************************************************************                                           
select (count(*) * 13) from IFRSRH.PORTES_ANESTESICOS;                                                                              
select (count(*) * 82) from IFRSRH.AMB;                                                                                             
--create index PORTE_ANESTESICO_FK on IFRSRH.AMB                                                                                    
(AMB_PORTE)                                                                                                                         
Tablespace TSD_INDICE;                                                                                                              
*****************************************************************************************                                           
select (count(*) * 232) from IFRSRH.CREDENCIADOS;                                                                                   
select (count(*) * 94) from IFRSRH.AMB_LOCAL;                                                                                       
--create index AML_CRE_SEQUENCIAL_FK on IFRSRH.AMB_LOCAL                                                                            
(AML_CRE_SEQUENCIAL)                                                                                                                
Tablespace TSD_INDICE;                                                                                                              
*****************************************************************************************                                           
select (count(*) * 13) from IFRSRH.PORTES_ANESTESICOS;                                                                              
select (count(*) * 94) from IFRSRH.AMB_LOCAL;                                                                                       
--create index AML_PORTE_FK on IFRSRH.AMB_LOCAL                                                                                     
(AML_PORTE_ANESTESICO)                                                                                                              
Tablespace TSD_INDICE;                                                                                                              
*****************************************************************************************                                           
select (count(*) * 492) from IFRSRH.CADASTROS;                                                                                      
select (count(*) * 63) from IFRSRH.APROVADOR_VIAGEM;                                                                                
--create index SYS_C0019662 on IFRSRH.APROVADOR_VIAGEM                                                                              
(AVI_EMP_NUMERO_MATRICULA_RESP)                                                                                                     
Tablespace TSD_INDICE;                                                                                                              
*****************************************************************************************                                           
select (count(*) * 492) from IFRSRH.CADASTROS;                                                                                      
select (count(*) * 63) from IFRSRH.APROVADOR_VIAGEM;                                                                                
--create index SYS_C0019663 on IFRSRH.APROVADOR_VIAGEM                                                                              
(AVI_EMP_NUMERO_MATRICULA)                                                                                                          
Tablespace TSD_INDICE;                                                                                                              
*****************************************************************************************                                           
select (count(*) * 149) from IFRDBA2.UNIDADES_ORGANIZACIONAIS;                                                                      
select (count(*) * 63) from IFRSRH.APROVADOR_VIAGEM;                                                                                
--create index SYS_C0019664 on IFRSRH.APROVADOR_VIAGEM                                                                              
(AVI_UOR_CODIGO_RESP)                                                                                                               
Tablespace TSD_INDICE;                                                                                                              
*****************************************************************************************                                           
select (count(*) * 63) from IFRSRH.APROVADOR_VIAGEM;                                                                                
select (count(*) * 19) from IFRSRH.APROVADOR_VIAGEM_TIPO;                                                                           
--create index APV_APVT_FK on IFRSRH.APROVADOR_VIAGEM_TIPO                                                                          
(AVI_UOR_CODIGO,AVI_DATA_INICIO,AVI_EMP_NUMERO_MATRICULA)                                                                           
Tablespace TSD_INDICE;                                                                                                              
*****************************************************************************************                                           
select (count(*) * 141) from IFRSRH.CARGOS;                                                                                         
select (count(*) * ) from IFRSRH.AREAS_ATUACAO_CARGO;                                                                               
--create index AAC_CAR_FK on IFRSRH.AREAS_ATUACAO_CARGO                                                                             
(AAC_CAR_CODIGO,AAC_CAR_CODIGO_NIVEL,AAC_CAR_OCC_CODIGO)                                                                            
Tablespace TSD_INDICE;                                                                                                              
*****************************************************************************************                                           
select (count(*) * 149) from IFRDBA2.UNIDADES_ORGANIZACIONAIS;                                                                      
select (count(*) * 11) from IFRSRH.AREAS_ATUACAO_UNID_ORGANIZ;                                                                      
--create index AUO_UOR_FK on IFRSRH.AREAS_ATUACAO_UNID_ORGANIZ                                                                      
(AUO_UOR_CODIGO)                                                                                                                    
Tablespace TSD_INDICE;                                                                                                              
*****************************************************************************************                                           
select (count(*) * 116) from IFRSRH.EMPREGADOS_PAGAMENTOS;                                                                          
select (count(*) * 55) from IFRSRH.ARQUIVO_CREDITO_BANCARIO;                                                                        
--create index ACB_EGT_FK on IFRSRH.ARQUIVO_CREDITO_BANCARIO                                                                        
(ACB_EGT_CRP_ANO_PAGAMENTO,ACB_EGT_CRP_MES_PAGAMENTO,ACB_EGT_CRP_SEQUENCIAL,ACB_EMP_NUMERO_MATRICULA)                               
Tablespace TSD_INDICE;                                                                                                              
*****************************************************************************************                                           
select (count(*) * 244) from IFRDBA2.DEPENDENCIAS;                                                                                  
select (count(*) * 54) from IFRSRH.ARQUIVO_CREDITO_BANCARIO_PENS;                                                                   
--create index ACP_DEP_FK on IFRSRH.ARQUIVO_CREDITO_BANCARIO_PENS                                                                   
(DEP_CODIGO)                                                                                                                        
Tablespace TSD_INDICE;                                                                                                              
*****************************************************************************************                                           
select (count(*) * 116) from IFRSRH.EMPREGADOS_PAGAMENTOS;                                                                          
select (count(*) * 54) from IFRSRH.ARQUIVO_CREDITO_BANCARIO_PENS;                                                                   
--create index ACP_EGT_FK on IFRSRH.ARQUIVO_CREDITO_BANCARIO_PENS                                                                   
(EGT_CRP_ANO_PAGAMENTO,EGT_CRP_MES_PAGAMENTO,EGT_CRP_SEQUENCIAL,ACP_PEN_EMP_NUMERO_MATRICULA)                                       
Tablespace TSD_INDICE;                                                                                                              
*****************************************************************************************                                           
select (count(*) * 207) from IFRSRH.PENSIONISTAS;                                                                                   
select (count(*) * 54) from IFRSRH.ARQUIVO_CREDITO_BANCARIO_PENS;                                                                   
--create index ACP_PEN_FK on IFRSRH.ARQUIVO_CREDITO_BANCARIO_PENS                                                                   
(ACP_PEN_EMP_NUMERO_MATRICULA,ACP_PEN_CODIGO)                                                                                       
Tablespace TSD_INDICE;                                                                                                              
*****************************************************************************************                                           
select (count(*) * 244) from IFRDBA2.DEPENDENCIAS;                                                                                  
select (count(*) * 15) from IFRSRH.ASSINFRA_DEPENDENCIA;                                                                            
--create index ADE_DEP_FK on IFRSRH.ASSINFRA_DEPENDENCIA                                                                            
(ADE_DEP_CODIGO)                                                                                                                    
Tablespace TSD_INDICE;                                                                                                              
*****************************************************************************************                                           
select (count(*) * 15) from IFRSRH.ASSINFRA_DEPENDENCIA;                                                                            
select (count(*) * 30) from IFRSRH.ASSINFRA_MOVIMENTACAO;                                                                           
--create index AMO_ADE_CAS_FK on IFRSRH.ASSINFRA_MOVIMENTACAO                                                                       
(AMO_ADE_CAS_CNPJ,AMO_ADE_DEP_CODIGO)                                                                                               
Tablespace TSD_INDICE;                                                                                                              
*****************************************************************************************                                           
select (count(*) * 61) from IFRDBA2.CENTRO_CUSTO;                                                                                   
select (count(*) * 161) from IFRSRH.ATIVIDADES;                                                                                     
--create index ATI_CC2_FK on IFRSRH.ATIVIDADES                                                                                      
(ATI_CT_CUSTOS_CODIGO)                                                                                                              
Tablespace TSD_INDICE;                                                                                                              
*****************************************************************************************                                           
select (count(*) * 161) from IFRSRH.ATIVIDADES;                                                                                     
select (count(*) * 16) from IFRSRH.ATIVIDADES_CARGOS;                                                                               
--create index ACA_ATI_FK on IFRSRH.ATIVIDADES_CARGOS                                                                               
(ACA_ATI_CODIGO)                                                                                                                    
Tablespace TSD_INDICE;                                                                                                              
*****************************************************************************************                                           
select (count(*) * 161) from IFRSRH.ATIVIDADES;                                                                                     
select (count(*) * ) from IFRSRH.ATIVIDADES_FUNCOES;                                                                                
--create index ATF_ATI_CODIGO_FK on IFRSRH.ATIVIDADES_FUNCOES                                                                       
(ATF_ATI_CODIGO)                                                                                                                    
Tablespace TSD_INDICE;                                                                                                              
*****************************************************************************************                                           
select (count(*) * 244) from IFRDBA2.DEPENDENCIAS;                                                                                  
select (count(*) * 316) from IFRSRH.AUTORIZACOES_ESPECIAIS;                                                                         
--create index AES_DEP_3_FK on IFRSRH.AUTORIZACOES_ESPECIAIS                                                                        
(AES_EMP_DEP_CODIGO_FISICO)                                                                                                         
Tablespace TSD_INDICE;                                                                                                              
*****************************************************************************************                                           
select (count(*) * 244) from IFRDBA2.DEPENDENCIAS;                                                                                  
select (count(*) * 316) from IFRSRH.AUTORIZACOES_ESPECIAIS;                                                                         
--create index AES_DPR_FK on IFRSRH.AUTORIZACOES_ESPECIAIS                                                                          
(AES_DEP_RESP_INCL)                                                                                                                 
Tablespace TSD_INDICE;                                                                                                              
*****************************************************************************************                                           
select (count(*) * 30) from IFRSRH.EMPREGADOS_BENEFICIOS;                                                                           
select (count(*) * 316) from IFRSRH.AUTORIZACOES_ESPECIAIS;                                                                         
--create index AES_EMB_FK on IFRSRH.AUTORIZACOES_ESPECIAIS                                                                          
(AES_EMB_EMP_NUMERO_MATRICULA,AES_EMB_BEN_SIGLA)                                                                                    
Tablespace TSD_INDICE;                                                                                                              
*****************************************************************************************                                           
select (count(*) * 232) from IFRSRH.CREDENCIADOS;                                                                                   
select (count(*) * 39) from IFRSRH.AUTORIZACOES_SERVICOS_MEDICOS;                                                                   
--create index ASM_CRE_FK on IFRSRH.AUTORIZACOES_SERVICOS_MEDICOS                                                                   
(ASM_CRE_SEQUENCIAL)                                                                                                                
Tablespace TSD_INDICE;                                                                                                              
*****************************************************************************************                                           
select (count(*) * 244) from IFRDBA2.DEPENDENCIAS;                                                                                  
select (count(*) * 39) from IFRSRH.AUTORIZACOES_SERVICOS_MEDICOS;                                                                   
--create index ASM_DEP_FK on IFRSRH.AUTORIZACOES_SERVICOS_MEDICOS                                                                   
(ASM_DEP_CODIGO)                                                                                                                    
Tablespace TSD_INDICE;                                                                                                              
*****************************************************************************************                                           
select (count(*) * 492) from IFRSRH.CADASTROS;                                                                                      
select (count(*) * 39) from IFRSRH.AUTORIZACOES_SERVICOS_MEDICOS;                                                                   
--create index ASM_EMP_FK on IFRSRH.AUTORIZACOES_SERVICOS_MEDICOS                                                                   
(ASM_EMP_NUMERO_MATRICULA)                                                                                                          
Tablespace TSD_INDICE;                                                                                                              
*****************************************************************************************                                           
select (count(*) * 492) from IFRSRH.CADASTROS;                                                                                      
select (count(*) * 39) from IFRSRH.AUTORIZACOES_SERVICOS_MEDICOS;                                                                   
--create index ASM_EMP_RESP_FK on IFRSRH.AUTORIZACOES_SERVICOS_MEDICOS                                                              
(ASM_EMP_NUMERO_MATRICULA_RESP)                                                                                                     
Tablespace TSD_INDICE;                                                                                                              
*****************************************************************************************                                           
select (count(*) * 30) from IFRSRH.EMPREGADOS_BENEFICIOS;                                                                           
select (count(*) * 105) from IFRSRH.AUTORIZACOES_TRATAMENTOS_ODONT;                                                                 
--create index ATO_EMB_FK on IFRSRH.AUTORIZACOES_TRATAMENTOS_ODONT                                                                  
(ATO_EMB_EMP_NUMERO_MATRICULA,ATO_EMB_BEN_SIGLA)                                                                                    
Tablespace TSD_INDICE;                                                                                                              
*****************************************************************************************                                           
select (count(*) * 244) from IFRDBA2.DEPENDENCIAS;                                                                                  
select (count(*) * 105) from IFRSRH.AUTORIZACOES_TRATAMENTOS_ODONT;                                                                 
--create index ATO_FK_DEP on IFRSRH.AUTORIZACOES_TRATAMENTOS_ODONT                                                                  
(ATO_DEP_RESP_INCL)                                                                                                                 
Tablespace TSD_INDICE;                                                                                                              
*****************************************************************************************                                           
select (count(*) * 244) from IFRDBA2.DEPENDENCIAS;                                                                                  
select (count(*) * 105) from IFRSRH.AUTORIZACOES_TRATAMENTOS_ODONT;                                                                 
--create index ATO_LOT_FK on IFRSRH.AUTORIZACOES_TRATAMENTOS_ODONT                                                                  
(ATO_EMP_DEP_CODIGO_LOTACAO)                                                                                                        
Tablespace TSD_INDICE;                                                                                                              
*****************************************************************************************                                           
select (count(*) * 36) from IFRSRH.PESSOAS_VINCULADAS_BENEF;                                                                        
select (count(*) * 105) from IFRSRH.AUTORIZACOES_TRATAMENTOS_ODONT;                                                                 
--create index ATO_PVB_FK on IFRSRH.AUTORIZACOES_TRATAMENTOS_ODONT                                                                  
(ATO_EMB_EMP_NUMERO_MATRICULA,ATO_PVB_PVI_SEQUENCIAL,ATO_EMB_BEN_SIGLA,ATO_PVB_ADESAO)                                              
Tablespace TSD_INDICE;                                                                                                              
*****************************************************************************************                                           
select (count(*) * 492) from IFRSRH.CADASTROS;                                                                                      
select (count(*) * 66) from IFRSRH.AVERBACAO_TSERVICO;                                                                              
--create index AVB_EMP_FK on IFRSRH.AVERBACAO_TSERVICO                                                                              
(AVB_EMP_NUMERO_MATRICULA)                                                                                                          
Tablespace TSD_INDICE;                                                                                                              
*****************************************************************************************                                           
select (count(*) * 30) from IFRSRH.EMPREGADOS_BENEFICIOS;                                                                           
select (count(*) * 29) from IFRSRH.BENEFICIARIOS_SEGUROS;                                                                           
--create index BSG_EMP_BEN_FK on IFRSRH.BENEFICIARIOS_SEGUROS                                                                       
(BSG_EMB_EMP_NUMERO_MATRICULA,BSG_EMB_BEN_SIGLA)                                                                                    
Tablespace TSD_INDICE;                                                                                                              
*****************************************************************************************                                           
select (count(*) * 94) from IFRSRH.PESSOAS_VINCULADAS;                                                                              
select (count(*) * 29) from IFRSRH.BENEFICIARIOS_SEGUROS;                                                                           
--create index BSG_PVI_FK on IFRSRH.BENEFICIARIOS_SEGUROS                                                                           
(BSG_PVI_EMP_NUMERO_MATRICULA,BSG_PVI_SEQUENCIAL)                                                                                   
Tablespace TSD_INDICE;                                                                                                              
*****************************************************************************************                                           
select (count(*) * 77) from IFRDBA2.AGENCIAINF;                                                                                     
select (count(*) * 492) from IFRSRH.CADASTROS;                                                                                      
--create index EMP_ABA_CONTA_FGTS_FK on IFRSRH.CADASTROS                                                                            
(EMP_ABA_BAN_CODIGO_FGTS,EMP_ABA_CODIGO_FGTS)                                                                                       
Tablespace TSD_INDICE;                                                                                                              
*****************************************************************************************                                           
select (count(*) * 77) from IFRDBA2.AGENCIAINF;                                                                                     
select (count(*) * 492) from IFRSRH.CADASTROS;                                                                                      
--create index EMP_ABA_CONTA_PGTO_FK on IFRSRH.CADASTROS                                                                            
(EMP_ABA_BAN_CODIGO_CTA_PGTO,EMP_ABA_CODIGO_CONTA_PGTO)                                                                             
Tablespace TSD_INDICE;                                                                                                              
*****************************************************************************************                                           
select (count(*) * 33) from IFRSRH.ESCOLARIDADES;                                                                                   
select (count(*) * 492) from IFRSRH.CADASTROS;                                                                                      
--create index EMP_ESO_FK on IFRSRH.CADASTROS                                                                                       
(EMP_ESO_CODIGO)                                                                                                                    
Tablespace TSD_INDICE;                                                                                                              
*****************************************************************************************                                           
select (count(*) * 16) from IFRSRH.FORCAS_ARMADAS;                                                                                  
select (count(*) * 492) from IFRSRH.CADASTROS;                                                                                      
--create index EMP_FORCA_ARMADA_CODIGO_FK on IFRSRH.CADASTROS                                                                       
(EMP_FORCA_ARMADA_CODIGO)                                                                                                           
Tablespace TSD_INDICE;                                                                                                              
*****************************************************************************************                                           
select (count(*) * 139) from IFRSRH.CARGOS_CONFIANCA;                                                                               
select (count(*) * 492) from IFRSRH.CADASTROS;                                                                                      
--create index EMP_FUNCAO_FK on IFRSRH.CADASTROS                                                                                    
(EMP_QFU_FUN_CODIGO)                                                                                                                
Tablespace TSD_INDICE;                                                                                                              
*****************************************************************************************                                           
select (count(*) * ) from IFRSRH.HORARIOS_TRABALHO_DEP;                                                                             
select (count(*) * 492) from IFRSRH.CADASTROS;                                                                                      
--create index EMP_HTD_FK on IFRSRH.CADASTROS                                                                                       
(EMP_HTD_DEP_CODIGO,EMP_HTD_HTR_CODIGO,EMP_HTD_SEQUENCIAL)                                                                          
Tablespace TSD_INDICE;                                                                                                              
*****************************************************************************************                                           
select (count(*) * 12) from IFRSRH.JORNADAS_TRABALHO;                                                                               
select (count(*) * 492) from IFRSRH.CADASTROS;                                                                                      
--create index EMP_JTR_FK on IFRSRH.CADASTROS                                                                                       
(EMP_JTR_CODIGO)                                                                                                                    
Tablespace TSD_INDICE;                                                                                                              
*****************************************************************************************                                           
select (count(*) * 23) from IFRDBA2.MUNICIPIOS;                                                                                     
select (count(*) * 492) from IFRSRH.CADASTROS;                                                                                      
--create index EMP_MUN_NATURAL_FK on IFRSRH.CADASTROS                                                                               
(EMP_MUN_CODIGO_NATURAL,EMP_UFE_SIGLA_NATURAL)                                                                                      
Tablespace TSD_INDICE;                                                                                                              
*****************************************************************************************                                           
select (count(*) * 23) from IFRDBA2.MUNICIPIOS;                                                                                     
select (count(*) * 492) from IFRSRH.CADASTROS;                                                                                      
--create index EMP_MUN_RESIDE_FK on IFRSRH.CADASTROS                                                                                
(EMP_MUN_CODIGO_RESIDE,EMP_UFE_SIGLA_RESIDENTE)                                                                                     
Tablespace TSD_INDICE;                                                                                                              
*****************************************************************************************                                           
select (count(*) * 12) from IFRSRH.NIVEIS_SALARIAIS;                                                                                
select (count(*) * 492) from IFRSRH.CADASTROS;                                                                                      
--create index EMP_NSA_FK on IFRSRH.CADASTROS                                                                                       
(EMP_NSA_CODIGO_NIVEL,EMP_NSA_CODIGO_PADRAO,EMP_NSA_IN_NIVEL_ESCOLARIDADE)                                                          
Tablespace TSD_INDICE;                                                                                                              
*****************************************************************************************                                           
select (count(*) * 40) from IFRSRH.ORGAOS_CLASSES;                                                                                  
select (count(*) * 492) from IFRSRH.CADASTROS;                                                                                      
--create index EMP_OCL_FK on IFRSRH.CADASTROS                                                                                       
(EMP_OCL_SIGLA)                                                                                                                     
Tablespace TSD_INDICE;                                                                                                              
*****************************************************************************************                                           
select (count(*) * 32) from IFRDBA2.PAISES;                                                                                         
select (count(*) * 492) from IFRSRH.CADASTROS;                                                                                      
--create index EMP_PAI_FK on IFRSRH.CADASTROS                                                                                       
(EMP_PAI_CODIGO)                                                                                                                    
Tablespace TSD_INDICE;                                                                                                              
*****************************************************************************************                                           
select (count(*) * 21) from IFRSRH.POSTO_GRADUACAO;                                                                                 
select (count(*) * 492) from IFRSRH.CADASTROS;                                                                                      
--create index EMP_POSTO_GRADUACAO_CODIGO_FK on IFRSRH.CADASTROS                                                                    
(EMP_POSTO_GRADUACAO_CODIGO)                                                                                                        
Tablespace TSD_INDICE;                                                                                                              
*****************************************************************************************                                           
select (count(*) * 31) from IFRSRH.QUADRO_FUNCOES;                                                                                  
select (count(*) * 492) from IFRSRH.CADASTROS;                                                                                      
--create index EMP_QFU_ESTAR_SUBSTITUINDO_FK on IFRSRH.CADASTROS                                                                    
(EMP_QFU_FUN_CODIGO_SUBSTITUI,EMP_QFU_HFL_UOR_COD_SUBST,EMP_QFU_HFL_DATA_VIGEN_SUBST)                                               
Tablespace TSD_INDICE;                                                                                                              
*****************************************************************************************                                           
select (count(*) * 31) from IFRSRH.QUADRO_FUNCOES;                                                                                  
select (count(*) * 492) from IFRSRH.CADASTROS;                                                                                      
--create index EMP_QFU_FK on IFRSRH.CADASTROS                                                                                       
(EMP_QFU_FUN_CODIGO,EMP_QFU_HFL_UOR_CODIGO,EMP_QFU_HFL_DATA_VIGENCIA)                                                               
Tablespace TSD_INDICE;                                                                                                              
*****************************************************************************************                                           
select (count(*) * 31) from IFRSRH.QUADROS_LOTACAO_PESSOAL;                                                                         
select (count(*) * 492) from IFRSRH.CADASTROS;                                                                                      
--create index EMP_QLP_FK on IFRSRH.CADASTROS                                                                                       
(EMP_QLP_HCL_UOR_CODIGO,EMP_QLP_HCL_DATA_VIGENCIA,EMP_QLP_CAR_CODIGO,EMP_QLP_CAR_CODIGO_NIVEL,EMP_QLP_CAR_OCC_CODIGO)               
Tablespace TSD_INDICE;                                                                                                              
*****************************************************************************************                                           
select (count(*) * 17) from IFRSRH.QUADRO_ARMA_ESPEC;                                                                               
select (count(*) * 492) from IFRSRH.CADASTROS;                                                                                      
--create index EMP_QUADRO_ARMA_ESP_CODIGO_FK on IFRSRH.CADASTROS                                                                    
(EMP_QUADRO_ARMA_ESP_CODIGO)                                                                                                        
Tablespace TSD_INDICE;                                                                                                              
*****************************************************************************************                                           
select (count(*) * 19) from IFRDBA2.UNIDADES_FEDERACAO;                                                                             
select (count(*) * 492) from IFRSRH.CADASTROS;                                                                                      
--create index EMP_UFE_CI_FK on IFRSRH.CADASTROS                                                                                    
(EMP_UFE_SIGLA_CI)                                                                                                                  
Tablespace TSD_INDICE;                                                                                                              
*****************************************************************************************                                           
select (count(*) * 19) from IFRDBA2.UNIDADES_FEDERACAO;                                                                             
select (count(*) * 492) from IFRSRH.CADASTROS;                                                                                      
--create index EMP_UFE_CTPS_FK on IFRSRH.CADASTROS                                                                                  
(EMP_UFE_SIGLA_CTPS)                                                                                                                
Tablespace TSD_INDICE;                                                                                                              
*****************************************************************************************                                           
select (count(*) * 19) from IFRDBA2.UNIDADES_FEDERACAO;                                                                             
select (count(*) * 492) from IFRSRH.CADASTROS;                                                                                      
--create index EMP_UFE_ESTRANG_REG_FK on IFRSRH.CADASTROS                                                                           
(EMP_UFE_SIGLA_ESTRANGEIRO)                                                                                                         
Tablespace TSD_INDICE;                                                                                                              
*****************************************************************************************                                           
select (count(*) * 19) from IFRDBA2.UNIDADES_FEDERACAO;                                                                             
select (count(*) * 492) from IFRSRH.CADASTROS;                                                                                      
--create index EMP_UFE_PRIMEIRO_EMPREGO_FK on IFRSRH.CADASTROS                                                                      
(EMP_UFE_SIGLA_PRIMEIRO_EMPREGO)                                                                                                    
Tablespace TSD_INDICE;                                                                                                              
*****************************************************************************************                                           
select (count(*) * 19) from IFRDBA2.UNIDADES_FEDERACAO;                                                                             
select (count(*) * 492) from IFRSRH.CADASTROS;                                                                                      
--create index EMP_UFE_REG_PROFIS_FK on IFRSRH.CADASTROS                                                                            
(EMP_UFE_SIGLA_REG_PROFIS)                                                                                                          
Tablespace TSD_INDICE;                                                                                                              
*****************************************************************************************                                           
select (count(*) * 19) from IFRDBA2.UNIDADES_FEDERACAO;                                                                             
select (count(*) * 492) from IFRSRH.CADASTROS;                                                                                      
--create index EMP_UFE_TIT_ELEITORAL_FK on IFRSRH.CADASTROS                                                                         
(EMP_UFE_SIGLA_TIT_ELEITOR)                                                                                                         
Tablespace TSD_INDICE;                                                                                                              
*****************************************************************************************                                           
select (count(*) * 33) from IFRSRH.ESCOLARIDADES;                                                                                   
select (count(*) * 141) from IFRSRH.CARGOS;                                                                                         
--create index CAR_ESO_FK on IFRSRH.CARGOS                                                                                          
(CAR_ESO_CODIGO)                                                                                                                    
Tablespace TSD_INDICE;                                                                                                              
*****************************************************************************************                                           
select (count(*) * 12) from IFRSRH.JORNADAS_TRABALHO;                                                                               
select (count(*) * 141) from IFRSRH.CARGOS;                                                                                         
--create index CAR_JTR_FK on IFRSRH.CARGOS                                                                                          
(CAR_JTR_CODIGO)                                                                                                                    
Tablespace TSD_INDICE;                                                                                                              
*****************************************************************************************                                           
select (count(*) * 12) from IFRSRH.NIVEIS_SALARIAIS;                                                                                
select (count(*) * 141) from IFRSRH.CARGOS;                                                                                         
--create index CAR_NSA_FINALIZADO_FK on IFRSRH.CARGOS                                                                               
(CAR_NSA_CODIGO_NIVEL_FINAL,CAR_NSA_CODIGO_PADRAO_FINAL,CAR_NSA_IN_NIVEL_ESCOLA_FINAL)                                              
Tablespace TSD_INDICE;                                                                                                              
*****************************************************************************************                                           
select (count(*) * 12) from IFRSRH.NIVEIS_SALARIAIS;                                                                                
select (count(*) * 141) from IFRSRH.CARGOS;                                                                                         
--create index CAR_NSA_INICIADO_FK on IFRSRH.CARGOS                                                                                 
(CAR_NSA_CODIGO_NIVEL_INICIO,CAR_NSA_CODIGO_PADRAO_INICIO,CAR_NSA_IN_NIVEL_ESCOLA_INICIO)                                           
Tablespace TSD_INDICE;                                                                                                              
*****************************************************************************************                                           
select (count(*) * 62) from IFRSRH.OCUPACOES_CARGO;                                                                                 
select (count(*) * 141) from IFRSRH.CARGOS;                                                                                         
--create index CAR_OCC_FK on IFRSRH.CARGOS                                                                                          
(CAR_OCC_CODIGO)                                                                                                                    
Tablespace TSD_INDICE;                                                                                                              
*****************************************************************************************                                           
select (count(*) * 40) from IFRSRH.ORGAOS_CLASSES;                                                                                  
select (count(*) * 141) from IFRSRH.CARGOS;                                                                                         
--create index CAR_OCL_FK on IFRSRH.CARGOS                                                                                          
(CAR_OCL_SIGLA)                                                                                                                     
Tablespace TSD_INDICE;                                                                                                              
*****************************************************************************************                                           
select (count(*) * 48) from IFRSRH.CBO;                                                                                             
select (count(*) * 139) from IFRSRH.CARGOS_CONFIANCA;                                                                               
--create index FUN_CBO_FK on IFRSRH.CARGOS_CONFIANCA                                                                                
(FUN_CODIGO_CBO)                                                                                                                    
Tablespace TSD_INDICE;                                                                                                              
*****************************************************************************************                                           
select (count(*) * 25) from IFRSRH.CATEGORIAS_FUNCOES;                                                                              
select (count(*) * 139) from IFRSRH.CARGOS_CONFIANCA;                                                                               
--create index FUN_CFU_FK on IFRSRH.CARGOS_CONFIANCA                                                                                
(FUN_CFU_CODIGO)                                                                                                                    
Tablespace TSD_INDICE;                                                                                                              
*****************************************************************************************                                           
select (count(*) * 12) from IFRSRH.JORNADAS_TRABALHO;                                                                               
select (count(*) * 139) from IFRSRH.CARGOS_CONFIANCA;                                                                               
--create index FUN_JTR_FK on IFRSRH.CARGOS_CONFIANCA                                                                                
(FUN_JTR_CODIGO)                                                                                                                    
Tablespace TSD_INDICE;                                                                                                              
*****************************************************************************************                                           
select (count(*) * 141) from IFRSRH.CARGOS;                                                                                         
select (count(*) * ) from IFRSRH.CARGOS_DEPENDENCIAS;                                                                               
--create index CDE_CAR_FK on IFRSRH.CARGOS_DEPENDENCIAS                                                                             
(CDE_CAR_CODIGO,CDE_CAR_CODIGO_NIVEL,CDE_CAR_OCC_CODIGO)                                                                            
Tablespace TSD_INDICE;                                                                                                              
*****************************************************************************************                                           
select (count(*) * 244) from IFRDBA2.DEPENDENCIAS;                                                                                  
select (count(*) * ) from IFRSRH.CARGOS_DEPENDENCIAS;                                                                               
--create index CDE_DEP_FK on IFRSRH.CARGOS_DEPENDENCIAS                                                                             
(CDE_DEP_CODIGO)                                                                                                                    
Tablespace TSD_INDICE;                                                                                                              
*****************************************************************************************                                           
select (count(*) * 244) from IFRDBA2.DEPENDENCIAS;                                                                                  
select (count(*) * 40) from IFRSRH.CATEGORIAS_TRANSPORTE;                                                                           
--create index CAT_RESP_FK on IFRSRH.CATEGORIAS_TRANSPORTE                                                                          
(CAT_DEP_RESP_INCL)                                                                                                                 
Tablespace TSD_INDICE;                                                                                                              
*****************************************************************************************                                           
select (count(*) * 29) from IFRSRH.TIPO_VINCULOS;                                                                                   
select (count(*) * 25) from IFRSRH.COBERTURAS_SEGUROS;                                                                              
--create index CBA_TPV_CODIGO_FK on IFRSRH.COBERTURAS_SEGUROS                                                                       
(CSG_TPV_CODIGO)                                                                                                                    
Tablespace TSD_INDICE;                                                                                                              
*****************************************************************************************                                           
select (count(*) * 232) from IFRSRH.CREDENCIADOS;                                                                                   
select (count(*) * ) from IFRSRH.COBRANCA_PSV;                                                                                      
--create index CSV_CRE_FK on IFRSRH.COBRANCA_PSV                                                                                    
(CSV_CRE_SEQUENCIAL)                                                                                                                
Tablespace TSD_INDICE;                                                                                                              
*****************************************************************************************                                           
select (count(*) * 492) from IFRSRH.CADASTROS;                                                                                      
select (count(*) * 67) from IFRSRH.CONCURSADOS_APROVADOS;                                                                           
--create index COA_EMP_FK on IFRSRH.CONCURSADOS_APROVADOS                                                                           
(COA_EMP_NUMERO_MATRICULA)                                                                                                          
Tablespace TSD_INDICE;                                                                                                              
*****************************************************************************************                                           
select (count(*) * 139) from IFRSRH.CARGOS_CONFIANCA;                                                                               
select (count(*) * 19) from IFRSRH.CONTROLE_USUARIOS_FUNCOES;                                                                       
--create index CUF_FUN_FK on IFRSRH.CONTROLE_USUARIOS_FUNCOES                                                                       
(FUN_CODIGO)                                                                                                                        
Tablespace TSD_INDICE;                                                                                                              
*****************************************************************************************                                           
select (count(*) * 56) from IFRDBA2.SEG_SISTEMA;                                                                                    
select (count(*) * 19) from IFRSRH.CONTROLE_USUARIOS_FUNCOES;                                                                       
--create index FK_CUF_SS on IFRSRH.CONTROLE_USUARIOS_FUNCOES                                                                        
(SS_CD_SISTEMA)                                                                                                                     
Tablespace TSD_INDICE;                                                                                                              
*****************************************************************************************                                           
select (count(*) * 56) from IFRDBA2.SEG_SISTEMA;                                                                                    
select (count(*) * 19) from IFRSRH.CONTROLE_USUARIOS_OCORRENCIAS;                                                                   
--create index FK_CUO_SS on IFRSRH.CONTROLE_USUARIOS_OCORRENCIAS                                                                    
(SS_CD_SISTEMA)                                                                                                                     
Tablespace TSD_INDICE;                                                                                                              
*****************************************************************************************                                           
select (count(*) * 244) from IFRDBA2.DEPENDENCIAS;                                                                                  
select (count(*) * 23) from IFRSRH.CONTROLE_USUARIO_DEPENDENCIA;                                                                    
--create index CUD_DEP_FK on IFRSRH.CONTROLE_USUARIO_DEPENDENCIA                                                                    
(DEP_CD_DEPENDENCIA)                                                                                                                
Tablespace TSD_INDICE;                                                                                                              
*****************************************************************************************                                           
select (count(*) * 56) from IFRDBA2.SEG_SISTEMA;                                                                                    
select (count(*) * 23) from IFRSRH.CONTROLE_USUARIO_DEPENDENCIA;                                                                    
--create index CUD_SS_FK on IFRSRH.CONTROLE_USUARIO_DEPENDENCIA                                                                     
(SSI_CD_SISTEMA)                                                                                                                    
Tablespace TSD_INDICE;                                                                                                              
*****************************************************************************************                                           
select (count(*) * 11) from IFRSRH.CREDENCIADOS_BENEFICIOS;                                                                         
select (count(*) * 73) from IFRSRH.CORPO_CLINICO;                                                                                   
--create index CC_CBE_FK on IFRSRH.CORPO_CLINICO                                                                                    
(CC_CBE_BEN_SIGLA,CC_CRE_COD_SEQUE)                                                                                                 
Tablespace TSD_INDICE;                                                                                                              
*****************************************************************************************                                           
select (count(*) * 73) from IFRSRH.CORPO_CLINICO;                                                                                   
select (count(*) * 18) from IFRSRH.CORPO_CLINICO_ESPECIALIDADES;                                                                    
--create index CCE_CCLI_FK on IFRSRH.CORPO_CLINICO_ESPECIALIDADES                                                                   
(CCE_CC_CRE_COD_SEQUE,CCE_CC_SEQUENCIAL)                                                                                            
Tablespace TSD_INDICE;                                                                                                              
*****************************************************************************************                                           
select (count(*) * 425) from IFRSRH.ESPECIALIDADES;                                                                                 
select (count(*) * 18) from IFRSRH.CORPO_CLINICO_ESPECIALIDADES;                                                                    
--create index CCE_COD_SEQUE_FK on IFRSRH.CORPO_CLINICO_ESPECIALIDADES                                                              
(CCE_ESP_TIPO,CCE_ESP_NUMERO)                                                                                                       
Tablespace TSD_INDICE;                                                                                                              
*****************************************************************************************                                           
select (count(*) * 244) from IFRDBA2.DEPENDENCIAS;                                                                                  
select (count(*) * 232) from IFRSRH.CREDENCIADOS;                                                                                   
--create index CRE_DEP_FK on IFRSRH.CREDENCIADOS                                                                                    
(CRE_DEP_RESP_INCL)                                                                                                                 
Tablespace TSD_INDICE;                                                                                                              
*****************************************************************************************                                           
select (count(*) * 40) from IFRSRH.ORGAOS_CLASSES;                                                                                  
select (count(*) * 232) from IFRSRH.CREDENCIADOS;                                                                                   
--create index CRE_OCL_FK on IFRSRH.CREDENCIADOS                                                                                    
(CRE_OCL_SIGLA)                                                                                                                     
Tablespace TSD_INDICE;                                                                                                              
*****************************************************************************************                                           
select (count(*) * 232) from IFRSRH.CREDENCIADOS;                                                                                   
select (count(*) * 11) from IFRSRH.CREDENCIADOS_BENEFICIOS;                                                                         
--create index CBE_CRE_SEQUENCIAL_FK on IFRSRH.CREDENCIADOS_BENEFICIOS                                                              
(CBE_CRE_SEQUENCIAL)                                                                                                                
Tablespace TSD_INDICE;                                                                                                              
*****************************************************************************************                                           
select (count(*) * 244) from IFRDBA2.DEPENDENCIAS;                                                                                  
select (count(*) * 72) from IFRSRH.CREDENCIADOS_CONTRATOS;                                                                          
--create index SYS_C0019766 on IFRSRH.CREDENCIADOS_CONTRATOS                                                                        
(CC_DEP_CODIGO)                                                                                                                     
Tablespace TSD_INDICE;                                                                                                              
*****************************************************************************************                                           
select (count(*) * 11) from IFRSRH.CREDENCIADOS_BENEFICIOS;                                                                         
select (count(*) * 14) from IFRSRH.CREDENCIADOS_DEPENDENCIAS;                                                                       
--create index CD_CBE_FK on IFRSRH.CREDENCIADOS_DEPENDENCIAS                                                                        
(CD_CBE_BEN_SIGLA,CD_CRE_SEQUENCIAL)                                                                                                
Tablespace TSD_INDICE;                                                                                                              
*****************************************************************************************                                           
select (count(*) * 50) from IFRSRH.EVENTOS_PAGAMENTOS;                                                                              
select (count(*) * 37) from IFRSRH.CRONOGRAMAS_PAGAMENTOS;                                                                          
--create index CRP_EPG_FK on IFRSRH.CRONOGRAMAS_PAGAMENTOS                                                                          
(CRP_EPG_CODIGO)                                                                                                                    
Tablespace TSD_INDICE;                                                                                                              
*****************************************************************************************                                           
select (count(*) * 492) from IFRSRH.CADASTROS;                                                                                      
select (count(*) * 29) from IFRSRH.DATAPREV_REEMBOLSO;                                                                              
--create index DREE_CAD_FK on IFRSRH.DATAPREV_REEMBOLSO                                                                             
(DAR_EMP_NUMERO_MATRICULA)                                                                                                          
Tablespace TSD_INDICE;                                                                                                              
*****************************************************************************************                                           
select (count(*) * 244) from IFRDBA2.DEPENDENCIAS;                                                                                  
select (count(*) * 29) from IFRSRH.DATAPREV_REEMBOLSO;                                                                              
--create index DREE_DEP_FK on IFRSRH.DATAPREV_REEMBOLSO                                                                             
(DAR_DEP_CODIGO)                                                                                                                    
Tablespace TSD_INDICE;                                                                                                              
*****************************************************************************************                                           
select (count(*) * 40) from IFRSRH.DATAPREV_ESPECIE;                                                                                
select (count(*) * 29) from IFRSRH.DATAPREV_REEMBOLSO;                                                                              
--create index DREE_DE_FK on IFRSRH.DATAPREV_REEMBOLSO                                                                              
(DAR_DES_COD_ESPECIE)                                                                                                               
Tablespace TSD_INDICE;                                                                                                              
*****************************************************************************************                                           
select (count(*) * 29) from IFRSRH.DATAPREV_REEMBOLSO;                                                                              
select (count(*) * 46) from IFRSRH.DATAPREV_REEMBOLSO_RUBRICAS;                                                                     
--create index DRR_DR_FK on IFRSRH.DATAPREV_REEMBOLSO_RUBRICAS                                                                      
(DRR_ANO_REFERENCIA,DRR_MES_REFERENCIA,DRR_EMP_NUMERO_MATRICULA,DRR_COD_BENEFICIO,DRR_COD_BENEF_SEQUENCIAL)                         
Tablespace TSD_INDICE;                                                                                                              
*****************************************************************************************                                           
select (count(*) * 244) from IFRDBA2.DEPENDENCIAS;                                                                                  
select (count(*) * ) from IFRSRH.DEMONSTRATIVO_CUSTO_BENEFICIO;                                                                     
--create index DCB_DEP_FK on IFRSRH.DEMONSTRATIVO_CUSTO_BENEFICIO                                                                   
(DCB_DEP_CODIGO)                                                                                                                    
Tablespace TSD_INDICE;                                                                                                              
*****************************************************************************************                                           
select (count(*) * 492) from IFRSRH.CADASTROS;                                                                                      
select (count(*) * 50) from IFRSRH.DEPENDENTES_USU_PLANO_SAUDE;                                                                     
--create index DUS_EMP_FK on IFRSRH.DEPENDENTES_USU_PLANO_SAUDE                                                                     
(DUS_EMP_NUMERO_MATRICULA)                                                                                                          
Tablespace TSD_INDICE;                                                                                                              
*****************************************************************************************                                           
select (count(*) * 94) from IFRSRH.PESSOAS_VINCULADAS;                                                                              
select (count(*) * 50) from IFRSRH.DEPENDENTES_USU_PLANO_SAUDE;                                                                     
--create index DUS_PVI_FK on IFRSRH.DEPENDENTES_USU_PLANO_SAUDE                                                                     
(DUS_EMP_NUMERO_MATRICULA,DUS_PVI_SEQUENCIAL)                                                                                       
Tablespace TSD_INDICE;                                                                                                              
*****************************************************************************************                                           
select (count(*) * 77) from IFRSRH.GUIAS;                                                                                           
select (count(*) * 99) from IFRSRH.DESPESAS_MEDICAS_HOSPITALARES;                                                                   
--create index DMP_GUI_FK on IFRSRH.DESPESAS_MEDICAS_HOSPITALARES                                                                   
(DMP_GUI_DOC_NUMERO,DMP_GUI_DOC_CBE_BEN_SIGLA,DMP_GUI_DOC_CBE_CRE_SEQUENCIAL,DMP_GUI_DOC_DEP_CODIGO,DMP_GUI_NUMERO)                 
Tablespace TSD_INDICE;                                                                                                              
*****************************************************************************************                                           
select (count(*) * 77) from IFRSRH.GUIAS;                                                                                           
select (count(*) * 84) from IFRSRH.DIVERSOS_MEDICAS_HOSPIT;                                                                         
--create index DMO_GUI_FK on IFRSRH.DIVERSOS_MEDICAS_HOSPIT                                                                         
(DMO_GUI_DOC_NUMERO,DMO_GUI_DOC_CBE_BEN_SIGLA,DMO_GUI_DOC_CBE_CRE_SEQUENCIAL,DMO_GUI_DOC_DEP_CODIGO,DMO_GUI_NUMERO)                 
Tablespace TSD_INDICE;                                                                                                              
*****************************************************************************************                                           
select (count(*) * 11) from IFRSRH.CREDENCIADOS_BENEFICIOS;                                                                         
select (count(*) * 170) from IFRSRH.DOCUMENTOS_COBRANCA;                                                                            
--create index DOC_CBE_FK on IFRSRH.DOCUMENTOS_COBRANCA                                                                             
(DOC_CBE_BEN_SIGLA,DOC_CBE_CRE_SEQUENCIAL)                                                                                          
Tablespace TSD_INDICE;                                                                                                              
*****************************************************************************************                                           
select (count(*) * 30) from IFRSRH.EMPREGADOS_BENEFICIOS;                                                                           
select (count(*) * 170) from IFRSRH.DOCUMENTOS_COBRANCA;                                                                            
--create index DOC_EMB_FK on IFRSRH.DOCUMENTOS_COBRANCA                                                                             
(DOC_EMB_EMP_NUMERO_MATRICULA,DOC_CBE_BEN_SIGLA)                                                                                    
Tablespace TSD_INDICE;                                                                                                              
*****************************************************************************************                                           
select (count(*) * 94) from IFRSRH.PESSOAS_VINCULADAS;                                                                              
select (count(*) * 170) from IFRSRH.DOCUMENTOS_COBRANCA;                                                                            
--create index DOC_PVB_FK on IFRSRH.DOCUMENTOS_COBRANCA                                                                             
(DOC_PVI_EMP_NUMERO_MATRICULA,DOC_PVI_SEQUENCIAL)                                                                                   
Tablespace TSD_INDICE;                                                                                                              
*****************************************************************************************                                           
select (count(*) * 244) from IFRDBA2.DEPENDENCIAS;                                                                                  
select (count(*) * 31) from IFRSRH.EFETIVO_INFRAERO;                                                                                
--create index EIN_DEP_FK on IFRSRH.EFETIVO_INFRAERO                                                                                
(EIN_DEP_CODIGO)                                                                                                                    
Tablespace TSD_INDICE;                                                                                                              
*****************************************************************************************                                           
select (count(*) * ) from IFRSRH.AREAS_ATUACAO_CARGO;                                                                               
select (count(*) * ) from IFRSRH.EMPREGADOS_ATUACAO_CARGO;                                                                          
--create index EAC_AAC_FK on IFRSRH.EMPREGADOS_ATUACAO_CARGO                                                                        
(EAC_AAC_ATU_CODIGO,EAC_AAC_CAR_CODIGO,EAC_AAC_CAR_CODIGO_NIVEL,EAC_AAC_CAR_OCC_CODIGO)                                             
Tablespace TSD_INDICE;                                                                                                              
*****************************************************************************************                                           
select (count(*) * 244) from IFRDBA2.DEPENDENCIAS;                                                                                  
select (count(*) * 30) from IFRSRH.EMPREGADOS_BENEFICIOS;                                                                           
--create index EMB_DEP_FK on IFRSRH.EMPREGADOS_BENEFICIOS                                                                           
(EMB_DEP_RESP_INCL)                                                                                                                 
Tablespace TSD_INDICE;                                                                                                              
*****************************************************************************************                                           
select (count(*) * 492) from IFRSRH.CADASTROS;                                                                                      
select (count(*) * 30) from IFRSRH.EMPREGADOS_BENEFICIOS;                                                                           
--create index EMB_EMP_FK on IFRSRH.EMPREGADOS_BENEFICIOS                                                                           
(EMB_EMP_NUMERO_MATRICULA)                                                                                                          
Tablespace TSD_INDICE;                                                                                                              
*****************************************************************************************                                           
select (count(*) * 244) from IFRDBA2.DEPENDENCIAS;                                                                                  
select (count(*) * 24) from IFRSRH.EMPREGADOS_CATEGORIAS;                                                                           
--create index EMC_DEP_FK on IFRSRH.EMPREGADOS_CATEGORIAS                                                                           
(EMC_DEP_RESP_INCL)                                                                                                                 
Tablespace TSD_INDICE;                                                                                                              
*****************************************************************************************                                           
select (count(*) * 36) from IFRSRH.FORMACOES_PROFISSIONAIS;                                                                         
select (count(*) * 15) from IFRSRH.EMPREGADOS_FORMACOES;                                                                            
--create index EMF_FORP_FK on IFRSRH.EMPREGADOS_FORMACOES                                                                           
(EMF_FOR_CODIGO)                                                                                                                    
Tablespace TSD_INDICE;                                                                                                              
*****************************************************************************************                                           
select (count(*) * 244) from IFRDBA2.DEPENDENCIAS;                                                                                  
select (count(*) * 116) from IFRSRH.EMPREGADOS_PAGAMENTOS;                                                                          
--create index EGT_DEP_FK on IFRSRH.EMPREGADOS_PAGAMENTOS                                                                           
(EGT_DEP_CODIGO)                                                                                                                    
Tablespace TSD_INDICE;                                                                                                              
*****************************************************************************************                                           
select (count(*) * 149) from IFRDBA2.UNIDADES_ORGANIZACIONAIS;                                                                      
select (count(*) * 116) from IFRSRH.EMPREGADOS_PAGAMENTOS;                                                                          
--create index EGT_UOR_FK on IFRSRH.EMPREGADOS_PAGAMENTOS                                                                           
(EGT_UOR_CODIGO)                                                                                                                    
Tablespace TSD_INDICE;                                                                                                              
*****************************************************************************************                                           
select (count(*) * 244) from IFRDBA2.DEPENDENCIAS;                                                                                  
select (count(*) * 50) from IFRSRH.EMPREGADOS_PARTICIPACAO_LUCROS;                                                                  
--create index DEP_FK on IFRSRH.EMPREGADOS_PARTICIPACAO_LUCROS                                                                      
(EPL_DEP_CODIGO_LOTACAO)                                                                                                            
Tablespace TSD_INDICE;                                                                                                              
*****************************************************************************************                                           
select (count(*) * ) from IFRSRH.PESSOAL_SEM_VINCULO;                                                                               
select (count(*) * ) from IFRSRH.EMPREGADOS_PESSOAL_SEM_VINCULO;                                                                    
--create index EPV_PSV_FK on IFRSRH.EMPREGADOS_PESSOAL_SEM_VINCULO                                                                  
(EPV_PSV_SEQUENCIAL)                                                                                                                
Tablespace TSD_INDICE;                                                                                                              
*****************************************************************************************                                           
select (count(*) * 9) from IFRSRH.OCORRENCIAS_INSS_AGNOCIVOS;                                                                       
select (count(*) * 76) from IFRSRH.EMPREGADO_OCORRENCIA_INSS;                                                                       
--create index EOI_OIA_FK on IFRSRH.EMPREGADO_OCORRENCIA_INSS                                                                       
(EOI_OIA_AGN_CODIGO,EOI_OIA_OIN_CODIGO_PADRAO_NAC)                                                                                  
Tablespace TSD_INDICE;                                                                                                              
*****************************************************************************************                                           
select (count(*) * 492) from IFRSRH.CADASTROS;                                                                                      
select (count(*) * 64) from IFRSRH.EMPRESTIMOS_INFRAPREV;                                                                           
--create index EMPREST_INFRAP_VAL_CADASTROS on IFRSRH.EMPRESTIMOS_INFRAPREV                                                         
(NUM_MATRICULA_EMPREGADO)                                                                                                           
Tablespace TSD_INDICE;                                                                                                              
*****************************************************************************************                                           
select (count(*) * 38) from IFRSRH.TAB_QUALIFICACAO_ACADEMICA;                                                                      
select (count(*) * 79) from IFRSRH.EMP_QUALIFICACAO_ACADEMICA;                                                                      
--create index EQA_QUA_FK on IFRSRH.EMP_QUALIFICACAO_ACADEMICA                                                                      
(EQA_QUA_COD_QUALIF_ACADEMICA)                                                                                                      
Tablespace TSD_INDICE;                                                                                                              
*****************************************************************************************                                           
select (count(*) * 232) from IFRSRH.CREDENCIADOS;                                                                                   
select (count(*) * ) from IFRSRH.EXAMES_COMPLEMENTARES;                                                                             
--create index EXC_CRE_FK on IFRSRH.EXAMES_COMPLEMENTARES                                                                           
(EXC_CRE_SEQUENCIAL)                                                                                                                
Tablespace TSD_INDICE;                                                                                                              
*****************************************************************************************                                           
select (count(*) * 244) from IFRDBA2.DEPENDENCIAS;                                                                                  
select (count(*) * 29) from IFRSRH.FALTAS_USUARIOS_LINHAS;                                                                          
--create index FAL_USU_LIN_VAL_DEPENDEN on IFRSRH.FALTAS_USUARIOS_LINHAS                                                            
(FUL_DEP_RESP_INCL)                                                                                                                 
Tablespace TSD_INDICE;                                                                                                              
*****************************************************************************************                                           
select (count(*) * 61) from IFRDBA2.CENTRO_CUSTO;                                                                                   
select (count(*) * 54) from IFRSRH.FINASA;                                                                                          
--create index FINASA_VAL_CENTRO_CUSTO on IFRSRH.FINASA                                                                             
(FIN_CENTRO_CUSTOS)                                                                                                                 
Tablespace TSD_INDICE;                                                                                                              
*****************************************************************************************                                           
select (count(*) * 244) from IFRDBA2.DEPENDENCIAS;                                                                                  
select (count(*) * 54) from IFRSRH.FINASA;                                                                                          
--create index FINASA_VAL_DEPENDENCIAS on IFRSRH.FINASA                                                                             
(FIN_EMP_DEP_CODIGO_LOTACAO)                                                                                                        
Tablespace TSD_INDICE;                                                                                                              
*****************************************************************************************                                           
select (count(*) * 244) from IFRDBA2.DEPENDENCIAS;                                                                                  
select (count(*) * 45) from IFRSRH.FISCAIS_LINHAS_TRANSPORTES;                                                                      
--create index FISC_LIN_TRAN_VAL_DEPENDEN on IFRSRH.FISCAIS_LINHAS_TRANSPORTES                                                      
(FLT_DEP_RESP_INCL)                                                                                                                 
Tablespace TSD_INDICE;                                                                                                              
*****************************************************************************************                                           
select (count(*) * 244) from IFRDBA2.DEPENDENCIAS;                                                                                  
select (count(*) * 25) from IFRSRH.FISCALIZACOES_LINHAS_EMPREG;                                                                     
--create index FISC_LIN_EMPR_VAL_DEPENDEN on IFRSRH.FISCALIZACOES_LINHAS_EMPREG                                                     
(FLE_DEP_RESP_INCL)                                                                                                                 
Tablespace TSD_INDICE;                                                                                                              
*****************************************************************************************                                           
select (count(*) * 492) from IFRSRH.CADASTROS;                                                                                      
select (count(*) * 25) from IFRSRH.FISCALIZACOES_LINHAS_EMPREG;                                                                     
--create index FLE_EMP_FK on IFRSRH.FISCALIZACOES_LINHAS_EMPREG                                                                     
(FLE_EMP_NUMERO_MATRICULA)                                                                                                          
Tablespace TSD_INDICE;                                                                                                              
*****************************************************************************************                                           
select (count(*) * 244) from IFRDBA2.DEPENDENCIAS;                                                                                  
select (count(*) * 161) from IFRSRH.FISCALIZACOES_LINHAS_TRANSP;                                                                    
--create index FISC_LIN_TRANS_VAL_DEPENDEN on IFRSRH.FISCALIZACOES_LINHAS_TRANSP                                                    
(FLR_DEP_RESP_INCL)                                                                                                                 
Tablespace TSD_INDICE;                                                                                                              
*****************************************************************************************                                           
select (count(*) * 93) from IFRSRH.LINHAS_TRANSPORTES_FRETADOS;                                                                     
select (count(*) * 161) from IFRSRH.FISCALIZACOES_LINHAS_TRANSP;                                                                    
--create index FLR_LTF_FK on IFRSRH.FISCALIZACOES_LINHAS_TRANSP                                                                     
(FLR_LTF_NUMERO,FLR_LTF_DEP_CODIGO)                                                                                                 
Tablespace TSD_INDICE;                                                                                                              
*****************************************************************************************                                           
select (count(*) * 64) from IFRSRH.FORMACOES_ESPECIALIZADAS;                                                                        
select (count(*) * 16) from IFRSRH.FORMACOES_ESPEC_CARGO;                                                                           
--create index FEC_FES_FK on IFRSRH.FORMACOES_ESPEC_CARGO                                                                           
(FEC_FES_CODIGO)                                                                                                                    
Tablespace TSD_INDICE;                                                                                                              
*****************************************************************************************                                           
select (count(*) * 492) from IFRSRH.CADASTROS;                                                                                      
select (count(*) * 12) from IFRSRH.FORMACOES_ESPEC_EMPREGADO;                                                                       
--create index FEE_EMP_FK on IFRSRH.FORMACOES_ESPEC_EMPREGADO                                                                       
(FEE_EMP_NUMERO_MATRICULA)                                                                                                          
Tablespace TSD_INDICE;                                                                                                              
*****************************************************************************************                                           
select (count(*) * 141) from IFRSRH.CARGOS;                                                                                         
select (count(*) * 16) from IFRSRH.FORMACOES_PROF_CARGO;                                                                            
--create index FPC_CAR_FK on IFRSRH.FORMACOES_PROF_CARGO                                                                            
(FPC_CAR_CODIGO,FPC_CAR_CODIGO_NIVEL,FPC_CAR_OCC_CODIGO)                                                                            
Tablespace TSD_INDICE;                                                                                                              
*****************************************************************************************                                           
select (count(*) * 36) from IFRSRH.FORMACOES_PROFISSIONAIS;                                                                         
select (count(*) * 16) from IFRSRH.FORMACOES_PROF_CARGO;                                                                            
--create index FPC_FOR_FK on IFRSRH.FORMACOES_PROF_CARGO                                                                            
(FPC_FOR_CODIGO)                                                                                                                    
Tablespace TSD_INDICE;                                                                                                              
*****************************************************************************************                                           
select (count(*) * 131) from IFRSRH.FORMULAS;                                                                                       
select (count(*) * 19) from IFRSRH.FORMULAS_RUBRICAS;                                                                               
--create index FRU_FORM_FK on IFRSRH.FORMULAS_RUBRICAS                                                                              
(FRU_FOR_CODIGO)                                                                                                                    
Tablespace TSD_INDICE;                                                                                                              
*****************************************************************************************                                           
select (count(*) * 30) from IFRSRH.EMPREGADOS_BENEFICIOS;                                                                           
select (count(*) * 77) from IFRSRH.GUIAS;                                                                                           
--create index GUI_EMB_FK on IFRSRH.GUIAS                                                                                           
(GUI_EMP_NUMERO_MATRICULA,GUI_DOC_CBE_BEN_SIGLA)                                                                                    
Tablespace TSD_INDICE;                                                                                                              
*****************************************************************************************                                           
select (count(*) * 244) from IFRDBA2.DEPENDENCIAS;                                                                                  
select (count(*) * 77) from IFRSRH.GUIAS;                                                                                           
--create index GUI_LOT_FK on IFRSRH.GUIAS                                                                                           
(GUI_EMP_DEP_CODIGO_LOTACAO)                                                                                                        
Tablespace TSD_INDICE;                                                                                                              
*****************************************************************************************                                           
select (count(*) * 36) from IFRSRH.PESSOAS_VINCULADAS_BENEF;                                                                        
select (count(*) * 77) from IFRSRH.GUIAS;                                                                                           
--create index GUI_PVB_FK on IFRSRH.GUIAS                                                                                           
(GUI_EMP_NUMERO_MATRICULA,GUI_PVI_SEQUENCIAL,GUI_DOC_CBE_BEN_SIGLA,GUI_PVB_ADESAO)                                                  
Tablespace TSD_INDICE;                                                                                                              
*****************************************************************************************                                           
select (count(*) * 63) from IFRSRH.ABO;                                                                                             
select (count(*) * 70) from IFRSRH.GUIAS_PROCEDIMENTOS;                                                                             
--create index GPR_ABO_FK on IFRSRH.GUIAS_PROCEDIMENTOS                                                                             
(GPR_ABO_CODIGO)                                                                                                                    
Tablespace TSD_INDICE;                                                                                                              
*****************************************************************************************                                           
select (count(*) * 39) from IFRSRH.HISTORICOS_FUNCOES_DEPENDENCIA;                                                                  
select (count(*) * 54) from IFRSRH.HISTORICOS_FUNCOES_LOTACOES;                                                                     
--create index HFL_HFD_FK on IFRSRH.HISTORICOS_FUNCOES_LOTACOES                                                                     
(HFL_HFD_DEP_CODIGO,HFL_HFD_DATA_VIGENCIA)                                                                                          
Tablespace TSD_INDICE;                                                                                                              
*****************************************************************************************                                           
select (count(*) * 29) from IFRSRH.BENEFICIARIOS_SEGUROS;                                                                           
select (count(*) * 61) from IFRSRH.HISTORICOS_PROCESSOS_SINISTROS;                                                                  
--create index HPS_BSG_FK on IFRSRH.HISTORICOS_PROCESSOS_SINISTROS                                                                  
(HPS_BSG_SEQUENCIAL)                                                                                                                
Tablespace TSD_INDICE;                                                                                                              
*****************************************************************************************                                           
select (count(*) * 244) from IFRDBA2.DEPENDENCIAS;                                                                                  
select (count(*) * 61) from IFRSRH.HISTORICOS_PROCESSOS_SINISTROS;                                                                  
--create index HPS_DEP_RESP_FK on IFRSRH.HISTORICOS_PROCESSOS_SINISTROS                                                             
(HPS_DEP_RESP_INCL)                                                                                                                 
Tablespace TSD_INDICE;                                                                                                              
*****************************************************************************************                                           
select (count(*) * 30) from IFRSRH.EMPREGADOS_BENEFICIOS;                                                                           
select (count(*) * 61) from IFRSRH.HISTORICOS_PROCESSOS_SINISTROS;                                                                  
--create index HPS_EMB_FK on IFRSRH.HISTORICOS_PROCESSOS_SINISTROS                                                                  
(HPS_EMB_EMP_NUMERO_MATRICULA,HPS_EMB_BEN_SIGLA)                                                                                    
Tablespace TSD_INDICE;                                                                                                              
*****************************************************************************************                                           
select (count(*) * 388) from IFRSRH.SINISTROS;                                                                                      
select (count(*) * 61) from IFRSRH.HISTORICOS_PROCESSOS_SINISTROS;                                                                  
--create index HPS_SIN_FK on IFRSRH.HISTORICOS_PROCESSOS_SINISTROS                                                                  
(HPS_SIN_SEQUENCIAL)                                                                                                                
Tablespace TSD_INDICE;                                                                                                              
*****************************************************************************************                                           
select (count(*) * 52) from IFRSRH.HISTORICO_CARGOS_DEPENDENCIAS;                                                                   
select (count(*) * 58) from IFRSRH.HISTORICO_CARGOS_LOTACAO;                                                                        
--create index ICL_HCD_FK on IFRSRH.HISTORICO_CARGOS_LOTACAO                                                                        
(ICL_HCD_DEP_CODIGO,ICL_HCD_DATA_VIGENCIA)                                                                                          
Tablespace TSD_INDICE;                                                                                                              
*****************************************************************************************                                           
select (count(*) * 492) from IFRSRH.CADASTROS;                                                                                      
select (count(*) * 28) from IFRSRH.HISTORICO_GERACAO_TCU;                                                                           
--create index HGT_EMP_FK on IFRSRH.HISTORICO_GERACAO_TCU                                                                           
(HGT_EMP_NUMERO_MATRICULA)                                                                                                          
Tablespace TSD_INDICE;                                                                                                              
*****************************************************************************************                                           
select (count(*) * 70) from IFRSRH.GUIAS_PROCEDIMENTOS;                                                                             
select (count(*) * 82) from IFRSRH.HONORARIOS_MEDICOS;                                                                              
--create index HNM_GPR_FK on IFRSRH.HONORARIOS_MEDICOS                                                                              
(HNM_GPR_GUI_DOC_NUMERO,HNM_GPR_GUI_DOC_CBE_BEN_SIGLA,HNM_GPR_GUI_DOC_CBE_CRE_SEQ,HNM_GPR_GUI_DOC_DEP_CODIGO,HNM_GPR_GUI_NUMERO,HNM_
GPR_SEQUENCIAL)                                                                                                                     
Tablespace TSD_INDICE;                                                                                                              
*****************************************************************************************                                           
select (count(*) * 100) from IFRSRH.RUBRICAS;                                                                                       
select (count(*) * 25) from IFRSRH.INCIDENCIAS_RUBRICAS;                                                                            
--create index IRU_RUB2_FK on IFRSRH.INCIDENCIAS_RUBRICAS                                                                           
(IRU_RUB_CODIGO_INCIDE)                                                                                                             
Tablespace TSD_INDICE;                                                                                                              
*****************************************************************************************                                           
select (count(*) * 244) from IFRDBA2.DEPENDENCIAS;                                                                                  
select (count(*) * 20) from IFRSRH.INDICE_ABSENTEISMO;                                                                              
--create index IAB_DEP_FK on IFRSRH.INDICE_ABSENTEISMO                                                                              
(IAB_DEP_CODIGO)                                                                                                                    
Tablespace TSD_INDICE;                                                                                                              
*****************************************************************************************                                           
select (count(*) * 94) from IFRSRH.TIPOS_OCORRENCIAS;                                                                               
select (count(*) * 20) from IFRSRH.INDICE_ABSENTEISMO;                                                                              
--create index IAB_OFU_FK on IFRSRH.INDICE_ABSENTEISMO                                                                              
(IAB_OFU_CODIGO)                                                                                                                    
Tablespace TSD_INDICE;                                                                                                              
*****************************************************************************************                                           
select (count(*) * 244) from IFRDBA2.DEPENDENCIAS;                                                                                  
select (count(*) * 44) from IFRSRH.ITINERARIOS_LINHAS_TRANSPORTES;                                                                  
--create index ITIN_LIN_TRANS_VAL_DEPENDEN on IFRSRH.ITINERARIOS_LINHAS_TRANSPORTES                                                 
(ILI_DEP_RESP_INCL)                                                                                                                 
Tablespace TSD_INDICE;                                                                                                              
*****************************************************************************************                                           
select (count(*) * 244) from IFRDBA2.DEPENDENCIAS;                                                                                  
select (count(*) * 93) from IFRSRH.LINHAS_TRANSPORTES_FRETADOS;                                                                     
--create index LIN_TRANS_FRET_VAL_DEPENDEN on IFRSRH.LINHAS_TRANSPORTES_FRETADOS                                                    
(LTF_DEP_RESP_INCL)                                                                                                                 
Tablespace TSD_INDICE;                                                                                                              
*****************************************************************************************                                           
select (count(*) * 232) from IFRSRH.CREDENCIADOS;                                                                                   
select (count(*) * 93) from IFRSRH.LINHAS_TRANSPORTES_FRETADOS;                                                                     
--create index LTF_CRE_FK on IFRSRH.LINHAS_TRANSPORTES_FRETADOS                                                                     
(LTF_CRE_SEQUENCIAL)                                                                                                                
Tablespace TSD_INDICE;                                                                                                              
*****************************************************************************************                                           
select (count(*) * 244) from IFRDBA2.DEPENDENCIAS;                                                                                  
select (count(*) * 93) from IFRSRH.LINHAS_TRANSPORTES_FRETADOS;                                                                     
--create index LTF_DEP_FK on IFRSRH.LINHAS_TRANSPORTES_FRETADOS                                                                     
(LTF_DEP_CODIGO)                                                                                                                    
Tablespace TSD_INDICE;                                                                                                              
*****************************************************************************************                                           
select (count(*) * 45) from IFRSRH.FISCAIS_LINHAS_TRANSPORTES;                                                                      
select (count(*) * 93) from IFRSRH.LINHAS_TRANSPORTES_FRETADOS;                                                                     
--create index LTF_FLT_FK on IFRSRH.LINHAS_TRANSPORTES_FRETADOS                                                                     
(LTF_FLT_EMP_NUMERO_MATRICULA)                                                                                                      
Tablespace TSD_INDICE;                                                                                                              
*****************************************************************************************                                           
select (count(*) * 93) from IFRSRH.LINHAS_TRANSPORTES_FRETADOS;                                                                     
select (count(*) * 29) from IFRSRH.LISTAS_ESPERAS_TRANSPORTES;                                                                      
--create index LET_LTF_FK on IFRSRH.LISTAS_ESPERAS_TRANSPORTES                                                                      
(LET_LTF_NUMERO,LET_LTF_DEP_CODIGO)                                                                                                 
Tablespace TSD_INDICE;                                                                                                              
*****************************************************************************************                                           
select (count(*) * 244) from IFRDBA2.DEPENDENCIAS;                                                                                  
select (count(*) * 29) from IFRSRH.LISTAS_ESPERAS_TRANSPORTES;                                                                      
--create index LIS_ESPER_TRANS_VAL_DEPENDEN on IFRSRH.LISTAS_ESPERAS_TRANSPORTES                                                    
(LET_DEP_RESP_INCL)                                                                                                                 
Tablespace TSD_INDICE;                                                                                                              
*****************************************************************************************                                           
select (count(*) * 244) from IFRDBA2.DEPENDENCIAS;                                                                                  
select (count(*) * 28) from IFRSRH.LOCAL_ATENDIMENTO;                                                                               
--create index LOA_DEP_FK on IFRSRH.LOCAL_ATENDIMENTO                                                                               
(LOA_DEP_CODIGO)                                                                                                                    
Tablespace TSD_INDICE;                                                                                                              
*****************************************************************************************                                           
select (count(*) * 425) from IFRSRH.ESPECIALIDADES;                                                                                 
select (count(*) * 83) from IFRSRH.LPM;                                                                                             
--create index LPM_ESP_TIPO_FK on IFRSRH.LPM                                                                                        
(LPM_ESP_TIPO,LPM_ESP_NUMERO)                                                                                                       
Tablespace TSD_INDICE;                                                                                                              
*****************************************************************************************                                           
select (count(*) * 232) from IFRSRH.CREDENCIADOS;                                                                                   
select (count(*) * 87) from IFRSRH.LPM_LOCAL;                                                                                       
--create index LPL_CRE_SEQUENCIAL_FK on IFRSRH.LPM_LOCAL                                                                            
(LPL_CRE_SEQUENCIAL)                                                                                                                
Tablespace TSD_INDICE;                                                                                                              
*****************************************************************************************                                           
select (count(*) * 244) from IFRDBA2.DEPENDENCIAS;                                                                                  
select (count(*) * 110) from IFRSRH.MENSAGENS_CONTRACHEQUES;                                                                        
--create index MEC_DEP_FK on IFRSRH.MENSAGENS_CONTRACHEQUES                                                                         
(MEC_DEP_CODIGO)                                                                                                                    
Tablespace TSD_INDICE;                                                                                                              
*****************************************************************************************                                           
select (count(*) * 131) from IFRSRH.FORMULAS;                                                                                       
select (count(*) * 103) from IFRSRH.MOVIMENTACAO;                                                                                   
--create index MOV_FORM_FK on IFRSRH.MOVIMENTACAO                                                                                   
(MOV_FOR_CODIGO)                                                                                                                    
Tablespace TSD_INDICE;                                                                                                              
*****************************************************************************************                                           
select (count(*) * 207) from IFRSRH.PENSIONISTAS;                                                                                   
select (count(*) * 103) from IFRSRH.MOVIMENTACAO;                                                                                   
--create index MOV_PEN_FK on IFRSRH.MOVIMENTACAO                                                                                    
(MOV_EMP_NUMERO_MATRICULA,MOV_PEN_CODIGO)                                                                                           
Tablespace TSD_INDICE;                                                                                                              
*****************************************************************************************                                           
select (count(*) * 100) from IFRSRH.RUBRICAS;                                                                                       
select (count(*) * 103) from IFRSRH.MOVIMENTACAO;                                                                                   
--create index MOV_RUB_FK on IFRSRH.MOVIMENTACAO                                                                                    
(MOV_RUB_CODIGO)                                                                                                                    
Tablespace TSD_INDICE;                                                                                                              
*****************************************************************************************                                           
select (count(*) * 48) from IFRSRH.CBO;                                                                                             
select (count(*) * 41) from IFRSRH.MOVIMENTACAO_AUTONOMO_COOPERAT;                                                                  
--create index MAC_CBO_FK on IFRSRH.MOVIMENTACAO_AUTONOMO_COOPERAT                                                                  
(MAC_CBO_CODIGO)                                                                                                                    
Tablespace TSD_INDICE;                                                                                                              
*****************************************************************************************                                           
select (count(*) * 232) from IFRSRH.CREDENCIADOS;                                                                                   
select (count(*) * 41) from IFRSRH.MOVIMENTACAO_AUTONOMO_COOPERAT;                                                                  
--create index MAC_CRE_FK on IFRSRH.MOVIMENTACAO_AUTONOMO_COOPERAT                                                                  
(MAC_CRE_SEQUENCIAL)                                                                                                                
Tablespace TSD_INDICE;                                                                                                              
*****************************************************************************************                                           
select (count(*) * 244) from IFRDBA2.DEPENDENCIAS;                                                                                  
select (count(*) * 115) from IFRSRH.OCORRENCIAS_EMPREGADOS;                                                                         
--create index OEM_DEP_FK on IFRSRH.OCORRENCIAS_EMPREGADOS                                                                          
(OEM_DEP_CODIGO)                                                                                                                    
Tablespace TSD_INDICE;                                                                                                              
*****************************************************************************************                                           
select (count(*) * 95) from IFRSRH.PROGRAMACOES_FERIAS;                                                                             
select (count(*) * 115) from IFRSRH.OCORRENCIAS_EMPREGADOS;                                                                         
--create index OEM_PFE_CONFIRM1_FK on IFRSRH.OCORRENCIAS_EMPREGADOS                                                                 
(OEM_PFE_EMP_NUM_MATR_CONFIRM1,OEM_PFE_SEQUENCIAL_CONFIRM1)                                                                         
Tablespace TSD_INDICE;                                                                                                              
*****************************************************************************************                                           
select (count(*) * 95) from IFRSRH.PROGRAMACOES_FERIAS;                                                                             
select (count(*) * 115) from IFRSRH.OCORRENCIAS_EMPREGADOS;                                                                         
--create index OEM_PFE_CONFIRM2_FK on IFRSRH.OCORRENCIAS_EMPREGADOS                                                                 
(OEM_PFE_EMP_NUM_MATR_CONFIRM2,OEM_PFE_SEQUENCIAL_CONFIRM2)                                                                         
Tablespace TSD_INDICE;                                                                                                              
*****************************************************************************************                                           
select (count(*) * 95) from IFRSRH.PROGRAMACOES_FERIAS;                                                                             
select (count(*) * 115) from IFRSRH.OCORRENCIAS_EMPREGADOS;                                                                         
--create index OEM_PFE_PROGRAM_FK on IFRSRH.OCORRENCIAS_EMPREGADOS                                                                  
(OEM_PFE_EMP_NUM_MATR_PROGRAM,OEM_PFE_SEQUENCIAL_PROGRAM)                                                                           
Tablespace TSD_INDICE;                                                                                                              
*****************************************************************************************                                           
select (count(*) * 244) from IFRDBA2.DEPENDENCIAS;                                                                                  
select (count(*) * 57) from IFRSRH.OCORRENCIAS_FREQUENCIA_EMP;                                                                      
--create index OFE_DEP_FK on IFRSRH.OCORRENCIAS_FREQUENCIA_EMP                                                                      
(OFE_DEP_CODIGO)                                                                                                                    
Tablespace TSD_INDICE;                                                                                                              
*****************************************************************************************                                           
select (count(*) * 57) from IFRSRH.OCORRENCIAS_FREQUENCIA_EMP;                                                                      
select (count(*) * 57) from IFRSRH.OCORRENCIAS_FREQUENCIA_EMP;                                                                      
--create index OFE_OFE_FK on IFRSRH.OCORRENCIAS_FREQUENCIA_EMP                                                                      
(OFE_OFE_EMP_NUMERO_MATRICULA,OFE_OFE_OFU_CODIGO,OFE_OFE_DATA_INICIO)                                                               
Tablespace TSD_INDICE;                                                                                                              
*****************************************************************************************                                           
select (count(*) * 99) from IFRSRH.OCORRENCIAS_INSS;                                                                                
select (count(*) * 9) from IFRSRH.OCORRENCIAS_INSS_AGNOCIVOS;                                                                       
--create index OIA_OIN_FK on IFRSRH.OCORRENCIAS_INSS_AGNOCIVOS                                                                      
(OIA_OIN_CODIGO_PADRAO_NACIONAL)                                                                                                    
Tablespace TSD_INDICE;                                                                                                              
*****************************************************************************************                                           
select (count(*) * 71) from IFRSRH.OCORRENCIAS_PIS_PASEP;                                                                           
select (count(*) * 63) from IFRSRH.OCORRENCIAS_PIS_PASEP_ARQUIVO;                                                                   
--create index OPPA_OPP_FK on IFRSRH.OCORRENCIAS_PIS_PASEP_ARQUIVO                                                                  
(OCO_NOME_ARQUIVO,OCO_CODIGO_OCORRENCIA,OCO_TIPO_OCORRENCIA)                                                                        
Tablespace TSD_INDICE;                                                                                                              
*****************************************************************************************                                           
select (count(*) * 71) from IFRSRH.OCORRENCIAS_PIS_PASEP;                                                                           
select (count(*) * 65) from IFRSRH.OCORRENCIAS_PIS_PASEP_EMP;                                                                       
--create index OPPE_OPP_FK on IFRSRH.OCORRENCIAS_PIS_PASEP_EMP                                                                      
(OCO_NOME_ARQUIVO,OCO_CODIGO_OCORRENCIA,OCO_TIPO_OCORRENCIA)                                                                        
Tablespace TSD_INDICE;                                                                                                              
*****************************************************************************************                                           
select (count(*) * 244) from IFRDBA2.DEPENDENCIAS;                                                                                  
select (count(*) * 99) from IFRSRH.OCORRENCIAS_RECEB_TICKETS;                                                                       
--create index ORT_DEP_FK on IFRSRH.OCORRENCIAS_RECEB_TICKETS                                                                       
(ORT_DEP_CODIGO)                                                                                                                    
Tablespace TSD_INDICE;                                                                                                              
*****************************************************************************************                                           
select (count(*) * 30) from IFRSRH.EMPREGADOS_BENEFICIOS;                                                                           
select (count(*) * 99) from IFRSRH.OCORRENCIAS_RECEB_TICKETS;                                                                       
--create index ORT_EMB_FK on IFRSRH.OCORRENCIAS_RECEB_TICKETS                                                                       
(ORT_EMB_EMP_NUMERO_MATRICULA,ORT_EMB_BEN_SIGLA)                                                                                    
Tablespace TSD_INDICE;                                                                                                              
*****************************************************************************************                                           
select (count(*) * 149) from IFRDBA2.UNIDADES_ORGANIZACIONAIS;                                                                      
select (count(*) * 99) from IFRSRH.OCORRENCIAS_RECEB_TICKETS;                                                                       
--create index ORT_UOR_FK on IFRSRH.OCORRENCIAS_RECEB_TICKETS                                                                       
(ORT_UOR_CODIGO)                                                                                                                    
Tablespace TSD_INDICE;                                                                                                              
*****************************************************************************************                                           
select (count(*) * 149) from IFRDBA2.UNIDADES_ORGANIZACIONAIS;                                                                      
select (count(*) * 128) from IFRSRH.OCORRENCIAS_RECEB_VALES;                                                                        
--create index ORV_UOR_FK on IFRSRH.OCORRENCIAS_RECEB_VALES                                                                         
(ORV_UOR_CODIGO)                                                                                                                    
Tablespace TSD_INDICE;                                                                                                              
*****************************************************************************************                                           
select (count(*) * 316) from IFRSRH.AUTORIZACOES_ESPECIAIS;                                                                         
select (count(*) * ) from IFRSRH.PAGAMENTOS_ESPECIAIS;                                                                              
--create index PGE_AES_FK on IFRSRH.PAGAMENTOS_ESPECIAIS                                                                            
(PGE_DEP_CODIGO,PGE_AES_EMB_EMP_NUMERO_MATRIC,PGE_AES_EMB_BEN_SIGLA,PGE_AES_VALOR_AUTORIZADO)                                       
Tablespace TSD_INDICE;                                                                                                              
*****************************************************************************************                                           
select (count(*) * 139) from IFRSRH.CARGOS_CONFIANCA;                                                                               
select (count(*) * 10) from IFRSRH.PARAMETROS_FUNCOES;                                                                              
--create index PRM_FUN_FK on IFRSRH.PARAMETROS_FUNCOES                                                                              
(FUN_CODIGO)                                                                                                                        
Tablespace TSD_INDICE;                                                                                                              
*****************************************************************************************                                           
select (count(*) * 94) from IFRSRH.TIPOS_OCORRENCIAS;                                                                               
select (count(*) * 10) from IFRSRH.PARAMETROS_OCORRENCIAS_FUNC;                                                                     
--create index POF_OFU_FK on IFRSRH.PARAMETROS_OCORRENCIAS_FUNC                                                                     
(OFU_CODIGO)                                                                                                                        
Tablespace TSD_INDICE;                                                                                                              
*****************************************************************************************                                           
select (count(*) * 244) from IFRDBA2.DEPENDENCIAS;                                                                                  
select (count(*) * 135) from IFRSRH.PEDIDOS_TICKETS;                                                                                
--create index PKT_DEP_FK on IFRSRH.PEDIDOS_TICKETS                                                                                 
(PKT_DEP_RESP_INCL)                                                                                                                 
Tablespace TSD_INDICE;                                                                                                              
*****************************************************************************************                                           
select (count(*) * 131) from IFRSRH.FORMULAS;                                                                                       
select (count(*) * 207) from IFRSRH.PENSIONISTAS;                                                                                   
--create index PEN_FOR_13_FK on IFRSRH.PENSIONISTAS                                                                                 
(PEN_FOR_CODIGO_13)                                                                                                                 
Tablespace TSD_INDICE;                                                                                                              
*****************************************************************************************                                           
select (count(*) * 131) from IFRSRH.FORMULAS;                                                                                       
select (count(*) * 207) from IFRSRH.PENSIONISTAS;                                                                                   
--create index PEN_FOR_FERIAS_FK on IFRSRH.PENSIONISTAS                                                                             
(PEN_FOR_CODIGO_FERIAS)                                                                                                             
Tablespace TSD_INDICE;                                                                                                              
*****************************************************************************************                                           
select (count(*) * 131) from IFRSRH.FORMULAS;                                                                                       
select (count(*) * 207) from IFRSRH.PENSIONISTAS;                                                                                   
--create index PEN_FOR_FK on IFRSRH.PENSIONISTAS                                                                                    
(PEN_FOR_CODIGO)                                                                                                                    
Tablespace TSD_INDICE;                                                                                                              
*****************************************************************************************                                           
select (count(*) * 140) from IFRSRH.HIST_PERICUL_INSALUB;                                                                           
select (count(*) * 22) from IFRSRH.PERICUL_INSALUB_AGNOCIVOS;                                                                       
--create index PIA_HPI_FK on IFRSRH.PERICUL_INSALUB_AGNOCIVOS                                                                       
(PIA_HPI_EMP_NUMERO_MATRICULA,PIA_HPI_DATA_INICIO,PIA_HPI_IND_PERICUL_INSALUB)                                                      
Tablespace TSD_INDICE;                                                                                                              
*****************************************************************************************                                           
select (count(*) * 23) from IFRDBA2.MUNICIPIOS;                                                                                     
select (count(*) * 94) from IFRSRH.PESSOAS_VINCULADAS;                                                                              
--create index PVI_MUN_FK on IFRSRH.PESSOAS_VINCULADAS                                                                              
(PVI_MUN_CODIGO_NATURALIDADE,PVI_UFE_SIGLA_NATURALIDADE)                                                                            
Tablespace TSD_INDICE;                                                                                                              
*****************************************************************************************                                           
select (count(*) * 29) from IFRSRH.TIPO_VINCULOS;                                                                                   
select (count(*) * 94) from IFRSRH.PESSOAS_VINCULADAS;                                                                              
--create index PVI_TPV_FK on IFRSRH.PESSOAS_VINCULADAS                                                                              
(PVI_TPV_CODIGO)                                                                                                                    
Tablespace TSD_INDICE;                                                                                                              
*****************************************************************************************                                           
select (count(*) * 347) from IFRSRH.BENEFICIOS;                                                                                     
select (count(*) * 36) from IFRSRH.PESSOAS_VINCULADAS_BENEF;                                                                        
--create index PVB_BEN_FK on IFRSRH.PESSOAS_VINCULADAS_BENEF                                                                        
(EMB_BEN_SIGLA)                                                                                                                     
Tablespace TSD_INDICE;                                                                                                              
*****************************************************************************************                                           
select (count(*) * 173) from IFRSRH.PRE_REQUISITOS;                                                                                 
select (count(*) * 10) from IFRSRH.PRE_REQUISITO_FUNCAO;                                                                            
--create index PRF_PRR_FK on IFRSRH.PRE_REQUISITO_FUNCAO                                                                            
(PRF_PRR_CODIGO)                                                                                                                    
Tablespace TSD_INDICE;                                                                                                              
*****************************************************************************************                                           
select (count(*) * 244) from IFRDBA2.DEPENDENCIAS;                                                                                  
select (count(*) * 28) from IFRSRH.PROCEDIMENTOS_ODONTOLOGICOS;                                                                     
--create index PROCED_ODONT_VAL_DEPENDEN on IFRSRH.PROCEDIMENTOS_ODONTOLOGICOS                                                      
(POD_DEP_RESP_INCL)                                                                                                                 
Tablespace TSD_INDICE;                                                                                                              
*****************************************************************************************                                           
select (count(*) * 492) from IFRSRH.CADASTROS;                                                                                      
select (count(*) * 48) from IFRSRH.PROVISOES_EMPREGADOS;                                                                            
--create index PROV_EMPREG_VAL_CADASTROS on IFRSRH.PROVISOES_EMPREGADOS                                                             
(EMP_NUMERO_MATRICULA)                                                                                                              
Tablespace TSD_INDICE;                                                                                                              
*****************************************************************************************                                           
select (count(*) * 32) from IFRSRH.QUADRO_CARGOS_DEPENDENCIAS;                                                                      
select (count(*) * ) from IFRSRH.QCD_AREA_ATUACAO;                                                                                  
--create index QDA_QCD_FK on IFRSRH.QCD_AREA_ATUACAO                                                                                
(QDA_QCD_HCD_DEP_CODIGO,QDA_QCD_HCD_DATA_VIGENCIA,QDA_QCD_CAR_CODIGO,QDA_QCD_CAR_CODIGO_NIVEL,QDA_QCD_CAR_OCC_CODIGO)               
Tablespace TSD_INDICE;                                                                                                              
*****************************************************************************************                                           
select (count(*) * 31) from IFRSRH.QUADROS_LOTACAO_PESSOAL;                                                                         
select (count(*) * ) from IFRSRH.QLP_AREA_ATUACAO;                                                                                  
--create index QLP_QLP_FK on IFRSRH.QLP_AREA_ATUACAO                                                                                
(QLA_QLP_ICL_UOR_CODIGO,QLA_QLP_ICL_DATA_VIGENCIA,QLA_QLP_CAR_CODIGO,QLA_QLP_CAR_CODIGO_NIVEL,QLA_QLP_CAR_OCC_CODIGO)               
Tablespace TSD_INDICE;                                                                                                              
*****************************************************************************************                                           
select (count(*) * 139) from IFRSRH.CARGOS_CONFIANCA;                                                                               
select (count(*) * 28) from IFRSRH.QUADROS_FUNCOES_DEPENDENCIAS;                                                                    
--create index QFD_FUN_FK on IFRSRH.QUADROS_FUNCOES_DEPENDENCIAS                                                                    
(QFD_FUN_CODIGO)                                                                                                                    
Tablespace TSD_INDICE;                                                                                                              
*****************************************************************************************                                           
select (count(*) * 141) from IFRSRH.CARGOS;                                                                                         
select (count(*) * 31) from IFRSRH.QUADROS_LOTACAO_PESSOAL;                                                                         
--create index QLP_CAR_FK on IFRSRH.QUADROS_LOTACAO_PESSOAL                                                                         
(QLP_CAR_CODIGO,QLP_CAR_CODIGO_NIVEL,QLP_CAR_OCC_CODIGO)                                                                            
Tablespace TSD_INDICE;                                                                                                              
*****************************************************************************************                                           
select (count(*) * 141) from IFRSRH.CARGOS;                                                                                         
select (count(*) * 32) from IFRSRH.QUADRO_CARGOS_DEPENDENCIAS;                                                                      
--create index QCD_CAR_FK on IFRSRH.QUADRO_CARGOS_DEPENDENCIAS                                                                      
(QCD_CAR_CODIGO,QCD_CAR_CODIGO_NIVEL,QCD_CAR_OCC_CODIGO)                                                                            
Tablespace TSD_INDICE;                                                                                                              
*****************************************************************************************                                           
select (count(*) * 54) from IFRSRH.HISTORICOS_FUNCOES_LOTACOES;                                                                     
select (count(*) * 31) from IFRSRH.QUADRO_FUNCOES;                                                                                  
--create index QFU_HFL_FK on IFRSRH.QUADRO_FUNCOES                                                                                  
(QFU_HFL_UOR_CODIGO,QFU_HFL_DATA_VIGENCIA)                                                                                          
Tablespace TSD_INDICE;                                                                                                              
*****************************************************************************************                                           
select (count(*) * 244) from IFRDBA2.DEPENDENCIAS;                                                                                  
select (count(*) * 81) from IFRSRH.REEMBOLSOS;                                                                                      
--create index REEMBOLSOS_FK_DEPENDENCIAS on IFRSRH.REEMBOLSOS                                                                      
(REE_DEP_RESP_INCL)                                                                                                                 
Tablespace TSD_INDICE;                                                                                                              
*****************************************************************************************                                           
select (count(*) * 244) from IFRDBA2.DEPENDENCIAS;                                                                                  
select (count(*) * 81) from IFRSRH.REEMBOLSOS;                                                                                      
--create index REE_DPF_FK on IFRSRH.REEMBOLSOS                                                                                      
(REE_EMP_DEP_CODIGO_FISICO)                                                                                                         
Tablespace TSD_INDICE;                                                                                                              
*****************************************************************************************                                           
select (count(*) * 30) from IFRSRH.EMPREGADOS_BENEFICIOS;                                                                           
select (count(*) * 81) from IFRSRH.REEMBOLSOS;                                                                                      
--create index REE_EMB_FK on IFRSRH.REEMBOLSOS                                                                                      
(REE_EMB_EMP_NUMERO_MATRICULA,REE_EMB_BEN_SIGLA)                                                                                    
Tablespace TSD_INDICE;                                                                                                              
*****************************************************************************************                                           
select (count(*) * 36) from IFRSRH.PESSOAS_VINCULADAS_BENEF;                                                                        
select (count(*) * 81) from IFRSRH.REEMBOLSOS;                                                                                      
--create index REE_PVB_FK on IFRSRH.REEMBOLSOS                                                                                      
(REE_EMB_EMP_NUMERO_MATRICULA,REE_PVB_PVI_SEQUENCIAL,REE_EMB_BEN_SIGLA,REE_PVB_ADESAO)                                              
Tablespace TSD_INDICE;                                                                                                              
*****************************************************************************************                                           
select (count(*) * ) from IFRSRH.PESSOAL_SEM_VINCULO;                                                                               
select (count(*) * ) from IFRSRH.RESP_FINANCEIRO_PSV;                                                                               
--create index RFP_PSV_FK on IFRSRH.RESP_FINANCEIRO_PSV                                                                             
(RFP_PSV_SEQUENCIAL)                                                                                                                
Tablespace TSD_INDICE;                                                                                                              
*****************************************************************************************                                           
select (count(*) * ) from IFRSRH.RESPONSAVEL_FINANCEIRO;                                                                            
select (count(*) * ) from IFRSRH.RESP_FINANCEIRO_PSV;                                                                               
--create index RFP_RFI_FK on IFRSRH.RESP_FINANCEIRO_PSV                                                                             
(RFP_RFI_SEQUENCIAL)                                                                                                                
Tablespace TSD_INDICE;                                                                                                              
*****************************************************************************************                                           
select (count(*) * 492) from IFRSRH.CADASTROS;                                                                                      
select (count(*) * 75) from IFRSRH.RESUMO_ENCARGOS_INFRAPREV;                                                                       
--create index RIN_CAD_FK on IFRSRH.RESUMO_ENCARGOS_INFRAPREV                                                                       
(RIN_EMP_NUMERO_MATRICULA)                                                                                                          
Tablespace TSD_INDICE;                                                                                                              
*****************************************************************************************                                           
select (count(*) * 492) from IFRSRH.CADASTROS;                                                                                      
select (count(*) * 52) from IFRSRH.RESUMO_ENCARGOS_INSS;                                                                            
--create index REI_EMP_FK on IFRSRH.RESUMO_ENCARGOS_INSS                                                                            
(REI_EMP_NUMERO_MATRICULA)                                                                                                          
Tablespace TSD_INDICE;                                                                                                              
*****************************************************************************************                                           
select (count(*) * 232) from IFRSRH.CREDENCIADOS;                                                                                   
select (count(*) * 40) from IFRSRH.RESUMO_ENCARGOS_INSS_AUTONOMO;                                                                   
--create index REA_CRE_FK on IFRSRH.RESUMO_ENCARGOS_INSS_AUTONOMO                                                                   
(REA_CRE_SEQUENCIAL)                                                                                                                
Tablespace TSD_INDICE;                                                                                                              
*****************************************************************************************                                           
select (count(*) * 244) from IFRDBA2.DEPENDENCIAS;                                                                                  
select (count(*) * 40) from IFRSRH.RESUMO_ENCARGOS_INSS_AUTONOMO;                                                                   
--create index REIA_DEP_FK on IFRSRH.RESUMO_ENCARGOS_INSS_AUTONOMO                                                                  
(REA_DEP_CODIGO)                                                                                                                    
Tablespace TSD_INDICE;                                                                                                              
*****************************************************************************************                                           
select (count(*) * 492) from IFRSRH.CADASTROS;                                                                                      
select (count(*) * 35) from IFRSRH.RESUMO_ENCARGOS_IRRF;                                                                            
--create index RIR_CAD_FK on IFRSRH.RESUMO_ENCARGOS_IRRF                                                                            
(RIR_EMP_NUMERO_MATRICULA)                                                                                                          
Tablespace TSD_INDICE;                                                                                                              
*****************************************************************************************                                           
select (count(*) * 492) from IFRSRH.CADASTROS;                                                                                      
select (count(*) * 39) from IFRSRH.RESUMO_ENCARGOS_SAL_EDUCACAO;                                                                    
--create index RSE_CAD_FK on IFRSRH.RESUMO_ENCARGOS_SAL_EDUCACAO                                                                    
(RSE_EMP_NUMERO_MATRICULA)                                                                                                          
Tablespace TSD_INDICE;                                                                                                              
*****************************************************************************************                                           
select (count(*) * 78) from IFRDBA2.CONTA_CONTABIL;                                                                                 
select (count(*) * 100) from IFRSRH.RUBRICAS;                                                                                       
--create index RUB_CC1_FK on IFRSRH.RUBRICAS                                                                                        
(RUB_CCO_CODIGO)                                                                                                                    
Tablespace TSD_INDICE;                                                                                                              
*****************************************************************************************                                           
select (count(*) * 244) from IFRDBA2.DEPENDENCIAS;                                                                                  
select (count(*) * ) from IFRSRH.SALDO_COBRANCA_APOSENTADO;                                                                         
--create index SCA_DEP_FK on IFRSRH.SALDO_COBRANCA_APOSENTADO                                                                       
(SCA_DEP_CODIGO)                                                                                                                    
Tablespace TSD_INDICE;                                                                                                              
*****************************************************************************************                                           
select (count(*) * 25) from IFRSRH.SIAD_ESCALA_PONTUACAO;                                                                           
select (count(*) * 35) from IFRSRH.SIAD_AVALIACAO_FINAL;                                                                            
--create index AV_FINAL_ESCALA_FK on IFRSRH.SIAD_AVALIACAO_FINAL                                                                    
(ANO_ESCALA,TIPO_ESCALA,CODIGO_CLASSIFICACAO)                                                                                       
Tablespace TSD_INDICE;                                                                                                              
*****************************************************************************************                                           
select (count(*) * 110) from IFRSRH.SIAD_FATORES_AVALIATIVOS;                                                                       
select (count(*) * 91) from IFRSRH.SIAD_CONCEITOS_AVALIACAO;                                                                        
--create index CONCEITOS_FATORES_FK on IFRSRH.SIAD_CONCEITOS_AVALIACAO                                                              
(ANO_FORMULARIO,CODIGO_FORMULARIO,CODIGO_FATOR)                                                                                     
Tablespace TSD_INDICE;                                                                                                              
*****************************************************************************************                                           
select (count(*) * 244) from IFRDBA2.DEPENDENCIAS;                                                                                  
select (count(*) * 388) from IFRSRH.SINISTROS;                                                                                      
--create index SIN_DEP_RES_FK on IFRSRH.SINISTROS                                                                                   
(SIN_DEP_RESP_INCL)                                                                                                                 
Tablespace TSD_INDICE;                                                                                                              
*****************************************************************************************                                           
select (count(*) * 30) from IFRSRH.EMPREGADOS_BENEFICIOS;                                                                           
select (count(*) * 388) from IFRSRH.SINISTROS;                                                                                      
--create index SIN_EMB_FK on IFRSRH.SINISTROS                                                                                       
(SIN_EMB_EMP_NUMERO_MATRICULA,SIN_EMB_BEN_SIGLA)                                                                                    
Tablespace TSD_INDICE;                                                                                                              
*****************************************************************************************                                           
select (count(*) * 36) from IFRSRH.PESSOAS_VINCULADAS_BENEF;                                                                        
select (count(*) * 388) from IFRSRH.SINISTROS;                                                                                      
--create index SIN_PVB_FK on IFRSRH.SINISTROS                                                                                       
(SIN_PVB_PVI_EMP_NUMERO_MATRIC,SIN_PVB_PVI_SEQUENCIAL,SIN_PVB_EMB_BEN_SIGLA,SIN_PVB_ADESAO)                                         
Tablespace TSD_INDICE;                                                                                                              
*****************************************************************************************                                           
select (count(*) * 492) from IFRSRH.CADASTROS;                                                                                      
select (count(*) * 29) from IFRSRH.SPF_EMPREGADO_IND_INSUFICIENCI;                                                                  
--create index EII_CADAST_FK on IFRSRH.SPF_EMPREGADO_IND_INSUFICIENCI                                                               
(MATRICULA_EMP_INDICADO_INS)                                                                                                        
Tablespace TSD_INDICE;                                                                                                              
*****************************************************************************************                                           
select (count(*) * 492) from IFRSRH.CADASTROS;                                                                                      
select (count(*) * 32) from IFRSRH.SPF_EMPREGADO_IND_PROMOCAO;                                                                      
--create index EIP_CADATR_FK on IFRSRH.SPF_EMPREGADO_IND_PROMOCAO                                                                   
(MATRICULA_EMP_INDICADO_PROM)                                                                                                       
Tablespace TSD_INDICE;                                                                                                              
*****************************************************************************************                                           
select (count(*) * 141) from IFRSRH.CARGOS;                                                                                         
select (count(*) * 60) from IFRSRH.SPF_EMPREGADO_PROMOVIDO;                                                                         
--create index EMP_PROM_CARGOS_FK on IFRSRH.SPF_EMPREGADO_PROMOVIDO                                                                 
(CARGOS_CAR_CODIGO,CARGOS_CAR_CODIGO_NIVEL,CARGOS_OCUCARGO_OCC_CODIGO)                                                              
Tablespace TSD_INDICE;                                                                                                              
*****************************************************************************************                                           
select (count(*) * 77) from IFRSRH.SPF_PROMOCAO;                                                                                    
select (count(*) * 60) from IFRSRH.SPF_EMPREGADO_PROMOVIDO;                                                                         
--create index EMP_PROM_PROMOCAO_FK on IFRSRH.SPF_EMPREGADO_PROMOVIDO                                                               
(PROMOCAO_TIPOS_OCOR_OFU_CODIGO,PROMOCAO_ANO_PROMOCAO)                                                                              
Tablespace TSD_INDICE;                                                                                                              
*****************************************************************************************                                           
select (count(*) * 77) from IFRSRH.GUIAS;                                                                                           
select (count(*) * 54) from IFRSRH.TAB_DESPESA_MEDICAMENTOS;                                                                        
--create index TDM_GUI_FK on IFRSRH.TAB_DESPESA_MEDICAMENTOS                                                                        
(TDM_GUI_DOC_NUMERO,TDM_GUI_DOC_CBE_BEN_SIGLA,TDM_GUI_DOC_CBE_CRE_SEQUENCIAL,TDM_GUI_DOC_DEP_CODIGO,TDM_GUI_NUMERO)                 
Tablespace TSD_INDICE;                                                                                                              
*****************************************************************************************                                           
select (count(*) * 131) from IFRSRH.FORMULAS;                                                                                       
select (count(*) * 99) from IFRSRH.TEMP_MOVIMENTACAO;                                                                               
--create index TEMP_MOV_FORM_FK on IFRSRH.TEMP_MOVIMENTACAO                                                                         
(MOV_FOR_CODIGO)                                                                                                                    
Tablespace TSD_INDICE;                                                                                                              
*****************************************************************************************                                           
select (count(*) * 207) from IFRSRH.PENSIONISTAS;                                                                                   
select (count(*) * 99) from IFRSRH.TEMP_MOVIMENTACAO;                                                                               
--create index TEMP_MOV_PEN_FK on IFRSRH.TEMP_MOVIMENTACAO                                                                          
(MOV_EMP_NUMERO_MATRICULA,MOV_PEN_CODIGO)                                                                                           
Tablespace TSD_INDICE;                                                                                                              
*****************************************************************************************                                           
select (count(*) * 100) from IFRSRH.RUBRICAS;                                                                                       
select (count(*) * 99) from IFRSRH.TEMP_MOVIMENTACAO;                                                                               
--create index TEMP_MOV_RUB_FK on IFRSRH.TEMP_MOVIMENTACAO                                                                          
(MOV_RUB_CODIGO)                                                                                                                    
Tablespace TSD_INDICE;                                                                                                              
*****************************************************************************************                                           
select (count(*) * 21) from IFRSRH.GRUPOS_OCORRENCIAS_FUNCIONAIS;                                                                   
select (count(*) * 94) from IFRSRH.TIPOS_OCORRENCIAS;                                                                               
--create index OFU_INDICADOR_TIPO_FK on IFRSRH.TIPOS_OCORRENCIAS                                                                    
(OFU_INDICADOR_TIPO)                                                                                                                
Tablespace TSD_INDICE;                                                                                                              
*****************************************************************************************                                           
select (count(*) * 94) from IFRSRH.TIPOS_OCORRENCIAS;                                                                               
select (count(*) * 94) from IFRSRH.TIPOS_OCORRENCIAS;                                                                               
--create index OFU_OFU_FK on IFRSRH.TIPOS_OCORRENCIAS                                                                               
(OFU_OFU_CODIGO)                                                                                                                    
Tablespace TSD_INDICE;                                                                                                              
*****************************************************************************************                                           
select (count(*) * 100) from IFRSRH.RUBRICAS;                                                                                       
select (count(*) * 19) from IFRSRH.TIPOS_OCORRENCIAS_RUBRICAS;                                                                      
--create index TOR_RUB_FK on IFRSRH.TIPOS_OCORRENCIAS_RUBRICAS                                                                      
(TOR_RUB_CODIGO)                                                                                                                    
Tablespace TSD_INDICE;                                                                                                              
*****************************************************************************************                                           
select (count(*) * 347) from IFRSRH.BENEFICIOS;                                                                                     
select (count(*) * 10) from IFRSRH.TIPOS_VINCULOS_BENEFICIOS;                                                                       
--create index BEN_SIGLA_BENEFICIO_FK on IFRSRH.TIPOS_VINCULOS_BENEFICIOS                                                           
(BEN_SIGLA_BENEFICIO)                                                                                                               
Tablespace TSD_INDICE;                                                                                                              
*****************************************************************************************                                           
select (count(*) * 93) from IFRSRH.LINHAS_TRANSPORTES_FRETADOS;                                                                     
select (count(*) * 31) from IFRSRH.USUARIOS_LINHAS_TRANSPORTES;                                                                     
--create index ULT_LTF_FK on IFRSRH.USUARIOS_LINHAS_TRANSPORTES                                                                     
(ULT_LTF_NUMERO,ULT_LTF_DEP_CODIGO)                                                                                                 
Tablespace TSD_INDICE;                                                                                                              
*****************************************************************************************                                           
select (count(*) * 244) from IFRDBA2.DEPENDENCIAS;                                                                                  
select (count(*) * 31) from IFRSRH.USUARIOS_LINHAS_TRANSPORTES;                                                                     
--create index USU_LIN_TRANS_VAL_DEPENDEN on IFRSRH.USUARIOS_LINHAS_TRANSPORTES                                                     
(ULT_DEP_RESP_INCL)                                                                                                                 
Tablespace TSD_INDICE;                                                                                                              
*****************************************************************************************                                           
select (count(*) * 244) from IFRDBA2.DEPENDENCIAS;                                                                                  
select (count(*) * 30) from IFRSRH.USUARIOS_PLANOS_SAUDE;                                                                           
--create index UPS_DEP_FK on IFRSRH.USUARIOS_PLANOS_SAUDE                                                                           
(UPS_DEP_CODIGO)                                                                                                                    
Tablespace TSD_INDICE;                                                                                                              
*****************************************************************************************                                           
select (count(*) * 492) from IFRSRH.CADASTROS;                                                                                      
select (count(*) * 30) from IFRSRH.USUARIOS_PLANOS_SAUDE;                                                                           
--create index UPS_EMP_FK on IFRSRH.USUARIOS_PLANOS_SAUDE                                                                           
(UPS_EMP_NUMERO_MATRICULA)                                                                                                          
Tablespace TSD_INDICE;                                                                                                              
*****************************************************************************************                                           
select (count(*) * 94) from IFRSRH.PESSOAS_VINCULADAS;                                                                              
select (count(*) * 70) from IFRSRH.VINCULADO_UNIVERSITARIOS;                                                                        
--create index PESSOAS_VINC_MAT_SEQ_FK on IFRSRH.VINCULADO_UNIVERSITARIOS                                                           
(VIU_PVI_EMP_NUMERO_MATRICULA,VIU_PVI_SEQUENCIAL)                                                                                   
Tablespace TSD_INDICE;                                                                                                              
*****************************************************************************************                                           
select (count(*) * 244) from IFRDBA2.DEPENDENCIAS;                                                                                  
select (count(*) * 70) from IFRSRH.VINCULADO_UNIVERSITARIOS;                                                                        
--create index VIU_DEP_FK on IFRSRH.VINCULADO_UNIVERSITARIOS                                                                        
(VIU_DEP_RESP_INCL)                                                                                                                 
Tablespace TSD_INDICE;                                                                                                              
*****************************************************************************************                                           
