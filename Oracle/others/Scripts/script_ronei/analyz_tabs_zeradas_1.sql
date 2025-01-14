ALTER USER SYS TEMPORARY TABLESPACE TEMP;                                                                                           
exec dbms_stats.gather_table_stats (ownname=>'MONIT',tabname=>'TABMONITSQL',estimate_percent=>25,cascade=>true);                         
exec dbms_stats.gather_table_stats (ownname=>'IFRSRH',tabname=>'DEMONSTRATIVO_CUSTO_BENEFICIO',estimate_percent=>25,cascade=>true);      
exec dbms_stats.gather_table_stats (ownname=>'IFRSRH',tabname=>'SALDO_COBRANCA_APOSENTADO',estimate_percent=>25,cascade=>true);          
exec dbms_stats.gather_table_stats (ownname=>'IFRSRH',tabname=>'TRACE_MOVIMENTACAO',estimate_percent=>25,cascade=>true);                 
exec dbms_stats.gather_table_stats (ownname=>'IFRVGA',tabname=>'RESPONSAVEL_FAMILIA_SGS',estimate_percent=>25,cascade=>true);            
exec dbms_stats.gather_table_stats (ownname=>'IFRVGA',tabname=>'RESPONSAVEL_LOCAL_RISCO_SGS',estimate_percent=>25,cascade=>true);        
exec dbms_stats.gather_table_stats (ownname=>'IFRVGA',tabname=>'RESPONSAVEL_RAMO_SEGURO_SGS',estimate_percent=>25,cascade=>true);        
exec dbms_stats.gather_table_stats (ownname=>'IFRVGA',tabname=>'RESPONSAVEL_SGS',estimate_percent=>25,cascade=>true);                    
exec dbms_stats.gather_table_stats (ownname=>'IFRVGA',tabname=>'RESPONSAVEL_TIPO_SEGURO_SGS',estimate_percent=>25,cascade=>true);        
exec dbms_stats.gather_table_stats (ownname=>'IFRVGA',tabname=>'RESTRICAO_SEG',estimate_percent=>25,cascade=>true);                      
exec dbms_stats.gather_table_stats (ownname=>'IFRVGA',tabname=>'SALVADO_SINISTRO_SGS',estimate_percent=>25,cascade=>true);               
exec dbms_stats.gather_table_stats (ownname=>'IFRVGA',tabname=>'SEGURADO_SGS',estimate_percent=>25,cascade=>true);                       
exec dbms_stats.gather_table_stats (ownname=>'IFRVGA',tabname=>'SESSAO_USUARIO_SGS',estimate_percent=>25,cascade=>true);                 
exec dbms_stats.gather_table_stats (ownname=>'IFRVGA',tabname=>'SINISTRO_SGS',estimate_percent=>25,cascade=>true);                       
exec dbms_stats.gather_table_stats (ownname=>'IFRVGA',tabname=>'SISTEMA_SEG',estimate_percent=>25,cascade=>true);                        
exec dbms_stats.gather_table_stats (ownname=>'IFRVGA',tabname=>'SISTEMA_USUARIO_SEG',estimate_percent=>25,cascade=>true);                
exec dbms_stats.gather_table_stats (ownname=>'IFRVGA',tabname=>'SITUACAO_SEGURADO_SGS',estimate_percent=>25,cascade=>true);              
exec dbms_stats.gather_table_stats (ownname=>'IFRVGA',tabname=>'SNT_COB_OBJ_APOL_SEG_SGS',estimate_percent=>25,cascade=>true);           
exec dbms_stats.gather_table_stats (ownname=>'IFRVGA',tabname=>'SNT_PAGTO_BENEFICIARIO_SGS',estimate_percent=>25,cascade=>true);         
exec dbms_stats.gather_table_stats (ownname=>'IFRVGA',tabname=>'TEXTO_IDIOMA_SEG',estimate_percent=>25,cascade=>true);                   
exec dbms_stats.gather_table_stats (ownname=>'IFRVGA',tabname=>'TICKET_SEG',estimate_percent=>25,cascade=>true);                         
exec dbms_stats.gather_table_stats (ownname=>'IFRVGA',tabname=>'TIPO_CONTABILIZACAO_SGS',estimate_percent=>25,cascade=>true);            
exec dbms_stats.gather_table_stats (ownname=>'IFRVGA',tabname=>'TIPO_ENVOLVIMENTO_SGS',estimate_percent=>25,cascade=>true);              
exec dbms_stats.gather_table_stats (ownname=>'IFRVGA',tabname=>'TIPO_EVENTO_SGS',estimate_percent=>25,cascade=>true);                    
exec dbms_stats.gather_table_stats (ownname=>'IFRVGA',tabname=>'TIPO_ID_USUARIO_SEG',estimate_percent=>25,cascade=>true);                
exec dbms_stats.gather_table_stats (ownname=>'IFRVGA',tabname=>'TIPO_NATUREZA_PERDA_SGS',estimate_percent=>25,cascade=>true);            
exec dbms_stats.gather_table_stats (ownname=>'IFRVGA',tabname=>'TIPO_OCORRENCIA_SGS',estimate_percent=>25,cascade=>true);                
exec dbms_stats.gather_table_stats (ownname=>'IFRVGA',tabname=>'TIPO_PERDAS_DANOS_SGS',estimate_percent=>25,cascade=>true);              
exec dbms_stats.gather_table_stats (ownname=>'IFRVGA',tabname=>'TIPO_SEGURO_SGS',estimate_percent=>25,cascade=>true);                    
exec dbms_stats.gather_table_stats (ownname=>'IFRVGA',tabname=>'UNIDADE_MONETARIA_SGS',estimate_percent=>25,cascade=>true);              
exec dbms_stats.gather_table_stats (ownname=>'IFRVGA',tabname=>'UNID_MEDIDA_SGS',estimate_percent=>25,cascade=>true);                    
exec dbms_stats.gather_table_stats (ownname=>'IFRVGA',tabname=>'USUARIO_ALIAS_SEG',estimate_percent=>25,cascade=>true);                  
exec dbms_stats.gather_table_stats (ownname=>'IFRVGA',tabname=>'USUARIO_PROFILE_SEG',estimate_percent=>25,cascade=>true);                
exec dbms_stats.gather_table_stats (ownname=>'IFRVGA',tabname=>'USUARIO_SEG',estimate_percent=>25,cascade=>true);                        
exec dbms_stats.gather_table_stats (ownname=>'IFRVGA',tabname=>'VALORES_APOLICE_FAMILIA_SGS',estimate_percent=>25,cascade=>true);        
exec dbms_stats.gather_table_stats (ownname=>'IFRVGA',tabname=>'VALORES_APOLICE_SEGURO_SGS',estimate_percent=>25,cascade=>true);         
exec dbms_stats.gather_table_stats (ownname=>'IFRVGA',tabname=>'VALORES_RESTRICAO_SEG',estimate_percent=>25,cascade=>true);              
exec dbms_stats.gather_table_stats (ownname=>'IFRVGA',tabname=>'VIAGEM_SGS',estimate_percent=>25,cascade=>true);                         
exec dbms_stats.gather_table_stats (ownname=>'IFRVGA',tabname=>'NIVEL_LOCRSC_SGS',estimate_percent=>25,cascade=>true);                   
exec dbms_stats.gather_table_stats (ownname=>'IFRVGA',tabname=>'NUMERO_CONTABILIZACAO_APL_SGS',estimate_percent=>25,cascade=>true);      
exec dbms_stats.gather_table_stats (ownname=>'IFRVGA',tabname=>'NUMERO_FATURA_APOLICE_SGS',estimate_percent=>25,cascade=>true);          
exec dbms_stats.gather_table_stats (ownname=>'IFRVGA',tabname=>'NUMERO_VALOR_APOLICE_SGS',estimate_percent=>25,cascade=>true);           
exec dbms_stats.gather_table_stats (ownname=>'IFRVGA',tabname=>'OBJETOS_AFETADOS_OCRR_SGS',estimate_percent=>25,cascade=>true);          
exec dbms_stats.gather_table_stats (ownname=>'IFRVGA',tabname=>'OBJETO_ESPECIF_SEG_SGS',estimate_percent=>25,cascade=>true);             
exec dbms_stats.gather_table_stats (ownname=>'IFRVGA',tabname=>'OBJTO_APOLICE_SEGURO_SGS',estimate_percent=>25,cascade=>true);           
exec dbms_stats.gather_table_stats (ownname=>'IFRVGA',tabname=>'OBJTO_SINISTRO_SGS',estimate_percent=>25,cascade=>true);                 
exec dbms_stats.gather_table_stats (ownname=>'IFRVGA',tabname=>'OCORRENCIA_SGS',estimate_percent=>25,cascade=>true);                     
exec dbms_stats.gather_table_stats (ownname=>'IFRVGA',tabname=>'OCORRENCIA_SINISTRO_SGS',estimate_percent=>25,cascade=>true);            
exec dbms_stats.gather_table_stats (ownname=>'IFRVGA',tabname=>'OCRR_PERDA_DANO_SGS',estimate_percent=>25,cascade=>true);                
exec dbms_stats.gather_table_stats (ownname=>'IFRVGA',tabname=>'ORCAMENTO_SGS',estimate_percent=>25,cascade=>true);                      
exec dbms_stats.gather_table_stats (ownname=>'IFRVGA',tabname=>'PAGAMENTO_CONTAS_SGS',estimate_percent=>25,cascade=>true);               
exec dbms_stats.gather_table_stats (ownname=>'IFRVGA',tabname=>'PAGAMENTO_SGS',estimate_percent=>25,cascade=>true);                      
exec dbms_stats.gather_table_stats (ownname=>'IFRVGA',tabname=>'PARAMETROS_SEG',estimate_percent=>25,cascade=>true);                     
exec dbms_stats.gather_table_stats (ownname=>'IFRVGA',tabname=>'PARAMETROS_SGS',estimate_percent=>25,cascade=>true);                     
exec dbms_stats.gather_table_stats (ownname=>'IFRVGA',tabname=>'PARCELA_PREMIO_APOLICE_SEG_SGS',estimate_percent=>25,cascade=>true);     
exec dbms_stats.gather_table_stats (ownname=>'IFRVGA',tabname=>'PARM_ORCAMENTO_SGS',estimate_percent=>25,cascade=>true);                 
exec dbms_stats.gather_table_stats (ownname=>'IFRVGA',tabname=>'PESO_GRAVIDADE_SGS',estimate_percent=>25,cascade=>true);                 
exec dbms_stats.gather_table_stats (ownname=>'IFRVGA',tabname=>'PESSOA_SEG',estimate_percent=>25,cascade=>true);                         
exec dbms_stats.gather_table_stats (ownname=>'IFRVGA',tabname=>'PREMIO_APOLICE_SEG_SGS',estimate_percent=>25,cascade=>true);             
exec dbms_stats.gather_table_stats (ownname=>'IFRVGA',tabname=>'PREMIO_EMPREGADO_SGS',estimate_percent=>25,cascade=>true);               
exec dbms_stats.gather_table_stats (ownname=>'IFRVGA',tabname=>'PREMIO_SEGURO_SGS',estimate_percent=>25,cascade=>true);                  
exec dbms_stats.gather_table_stats (ownname=>'IFRVGA',tabname=>'PRMAS_OBAPSG_SGS',estimate_percent=>25,cascade=>true);                   
exec dbms_stats.gather_table_stats (ownname=>'IFRVGA',tabname=>'PROBABILIDADE_REPETICAO_SGS',estimate_percent=>25,cascade=>true);        
exec dbms_stats.gather_table_stats (ownname=>'IFRVGA',tabname=>'PROCEDIMENTO_SNSTRO_SGS',estimate_percent=>25,cascade=>true);            
exec dbms_stats.gather_table_stats (ownname=>'IFRVGA',tabname=>'PROFILE_FUNCAO_NIVEL_SEG',estimate_percent=>25,cascade=>true);           
exec dbms_stats.gather_table_stats (ownname=>'IFRVGA',tabname=>'PROFILE_FUNCAO_SEG',estimate_percent=>25,cascade=>true);                 
exec dbms_stats.gather_table_stats (ownname=>'IFRVGA',tabname=>'PROFILE_RESTRICAO_SEG',estimate_percent=>25,cascade=>true);              
exec dbms_stats.gather_table_stats (ownname=>'IFRVGA',tabname=>'PROFILE_RESTRICAO_VALORES_SEG',estimate_percent=>25,cascade=>true);      
exec dbms_stats.gather_table_stats (ownname=>'IFRVGA',tabname=>'PROFILE_SEG',estimate_percent=>25,cascade=>true);                        
exec dbms_stats.gather_table_stats (ownname=>'IFRVGA',tabname=>'RAMO_SEGURO_SGS',estimate_percent=>25,cascade=>true);                    
exec dbms_stats.gather_table_stats (ownname=>'IFRVGA',tabname=>'RATEIO_PREMIO_EOP_SGS',estimate_percent=>25,cascade=>true);              
exec dbms_stats.gather_table_stats (ownname=>'IFRVGA',tabname=>'RATEIO_PREMIO_OBAPSG_SGS',estimate_percent=>25,cascade=>true);           
exec dbms_stats.gather_table_stats (ownname=>'IFRVGA',tabname=>'REALZ_ORCAMENTO_SGS',estimate_percent=>25,cascade=>true);                
exec dbms_stats.gather_table_stats (ownname=>'IFRVGA',tabname=>'RECEBIMENTO_LIQ_SGS',estimate_percent=>25,cascade=>true);                
exec dbms_stats.gather_table_stats (ownname=>'IFRVGA',tabname=>'RECEBIMENTO_SGS',estimate_percent=>25,cascade=>true);                    
exec dbms_stats.gather_table_stats (ownname=>'IFRVGA',tabname=>'DOCUMENTO_PADRAO_SGS',estimate_percent=>25,cascade=>true);               
exec dbms_stats.gather_table_stats (ownname=>'IFRVGA',tabname=>'DOC_ATIV_AGENDA_SGS',estimate_percent=>25,cascade=>true);                
exec dbms_stats.gather_table_stats (ownname=>'IFRVGA',tabname=>'DUAL_SGS',estimate_percent=>25,cascade=>true);                           
exec dbms_stats.gather_table_stats (ownname=>'IFRVGA',tabname=>'ENDOSSO_ADTVO_APLSEG_SGS',estimate_percent=>25,cascade=>true);           
exec dbms_stats.gather_table_stats (ownname=>'IFRVGA',tabname=>'ENTIDADE_ATRIBUTO_SEG',estimate_percent=>25,cascade=>true);              
exec dbms_stats.gather_table_stats (ownname=>'IFRVGA',tabname=>'ENTIDADE_SEG',estimate_percent=>25,cascade=>true);                       
exec dbms_stats.gather_table_stats (ownname=>'IFRVGA',tabname=>'ENVIO_CARTA_SGS',estimate_percent=>25,cascade=>true);                    
exec dbms_stats.gather_table_stats (ownname=>'IFRVGA',tabname=>'ENVOLVIDOS_OCORRENCIA_SGS',estimate_percent=>25,cascade=>true);          
exec dbms_stats.gather_table_stats (ownname=>'IFRVGA',tabname=>'ESPECIFICACAO_SEGURO_SGS',estimate_percent=>25,cascade=>true);           
exec dbms_stats.gather_table_stats (ownname=>'IFRVGA',tabname=>'ESTAGIARIOS_SGS',estimate_percent=>25,cascade=>true);                    
exec dbms_stats.gather_table_stats (ownname=>'IFRVGA',tabname=>'ESTRUTURA_FISICA_SGS',estimate_percent=>25,cascade=>true);               
exec dbms_stats.gather_table_stats (ownname=>'IFRVGA',tabname=>'EVENTO_SGS',estimate_percent=>25,cascade=>true);                         
exec dbms_stats.gather_table_stats (ownname=>'IFRVGA',tabname=>'FAMILIA_SGS',estimate_percent=>25,cascade=>true);                        
exec dbms_stats.gather_table_stats (ownname=>'IFRVGA',tabname=>'FEE_SGS',estimate_percent=>25,cascade=>true);                            
exec dbms_stats.gather_table_stats (ownname=>'IFRVGA',tabname=>'FORMA_PAGAMENTO_SGS',estimate_percent=>25,cascade=>true);                
exec dbms_stats.gather_table_stats (ownname=>'IFRVGA',tabname=>'FORMULA_VALORES_APOLICE_SGS',estimate_percent=>25,cascade=>true);        
exec dbms_stats.gather_table_stats (ownname=>'IFRVGA',tabname=>'FORMULA_VALORES_FAMILIA_SGS',estimate_percent=>25,cascade=>true);        
exec dbms_stats.gather_table_stats (ownname=>'IFRVGA',tabname=>'FUNCAO_NIVEL_SEG',estimate_percent=>25,cascade=>true);                   
exec dbms_stats.gather_table_stats (ownname=>'IFRVGA',tabname=>'FUNCAO_RESTRICAO_SEG',estimate_percent=>25,cascade=>true);               
exec dbms_stats.gather_table_stats (ownname=>'IFRVGA',tabname=>'FUNCAO_SEG',estimate_percent=>25,cascade=>true);                         
exec dbms_stats.gather_table_stats (ownname=>'IFRVGA',tabname=>'GLOSSARIO_SEG',estimate_percent=>25,cascade=>true);                      
exec dbms_stats.gather_table_stats (ownname=>'IFRVGA',tabname=>'GLOSSARIO_SGS',estimate_percent=>25,cascade=>true);                      
exec dbms_stats.gather_table_stats (ownname=>'IFRVGA',tabname=>'HIST_CTA_CONTABIL_FAMILIA_SGS',estimate_percent=>25,cascade=>true);      
exec dbms_stats.gather_table_stats (ownname=>'IFRVGA',tabname=>'IDIOMA_SEG',estimate_percent=>25,cascade=>true);                         
exec dbms_stats.gather_table_stats (ownname=>'IFRVGA',tabname=>'INTERFACE_SGS',estimate_percent=>25,cascade=>true);                      
exec dbms_stats.gather_table_stats (ownname=>'IFRVGA',tabname=>'LAUDO_SINISTRO_SGS',estimate_percent=>25,cascade=>true);                 
exec dbms_stats.gather_table_stats (ownname=>'IFRVGA',tabname=>'LAYOUT_INTERF_SGS',estimate_percent=>25,cascade=>true);                  
exec dbms_stats.gather_table_stats (ownname=>'IFRVGA',tabname=>'LISTA_DOCUMENTO_RAMO_SGS',estimate_percent=>25,cascade=>true);           
exec dbms_stats.gather_table_stats (ownname=>'IFRVGA',tabname=>'LISTA_DOC_EXTERNO_SGS',estimate_percent=>25,cascade=>true);              
exec dbms_stats.gather_table_stats (ownname=>'IFRVGA',tabname=>'LOCAL_RISCO_SGS',estimate_percent=>25,cascade=>true);                    
exec dbms_stats.gather_table_stats (ownname=>'IFRVGA',tabname=>'LOGIN_SEG',estimate_percent=>25,cascade=>true);                          
exec dbms_stats.gather_table_stats (ownname=>'IFRVGA',tabname=>'MELHORIAS_SGS',estimate_percent=>25,cascade=>true);                      
exec dbms_stats.gather_table_stats (ownname=>'IFRVGA',tabname=>'MELHORIA_OCORRENCIA_SGS',estimate_percent=>25,cascade=>true);            
exec dbms_stats.gather_table_stats (ownname=>'IFRVGA',tabname=>'MENSAGEM_IDIOMA_SEG',estimate_percent=>25,cascade=>true);                
exec dbms_stats.gather_table_stats (ownname=>'IFRVGA',tabname=>'MENSAGEM_SEG',estimate_percent=>25,cascade=>true);                       
exec dbms_stats.gather_table_stats (ownname=>'IFRVGA',tabname=>'NATUREZA_POTENCIAL_PERDA_SGS',estimate_percent=>25,cascade=>true);       
exec dbms_stats.gather_table_stats (ownname=>'IFRVGA',tabname=>'NIVEL_AUTORIZACAO_SEG',estimate_percent=>25,cascade=>true);              
exec dbms_stats.gather_table_stats (ownname=>'IFRVGA',tabname=>'ADIANTAMENTO_SGS',estimate_percent=>25,cascade=>true);                   
exec dbms_stats.gather_table_stats (ownname=>'IFRVGA',tabname=>'AGENDA_SGS',estimate_percent=>25,cascade=>true);                         
exec dbms_stats.gather_table_stats (ownname=>'IFRVGA',tabname=>'AJUSTE_APOLICE_SEG_SGS',estimate_percent=>25,cascade=>true);             
exec dbms_stats.gather_table_stats (ownname=>'IFRVGA',tabname=>'AMORTIZACAO_PREMIO_SGS',estimate_percent=>25,cascade=>true);             
exec dbms_stats.gather_table_stats (ownname=>'IFRVGA',tabname=>'APOLICE_SEGURO_SGS',estimate_percent=>25,cascade=>true);                 
exec dbms_stats.gather_table_stats (ownname=>'IFRVGA',tabname=>'ATIVIDADE_AGENDA_SGS',estimate_percent=>25,cascade=>true);               
exec dbms_stats.gather_table_stats (ownname=>'IFRVGA',tabname=>'ATIVIDADE_PADRAO_SGS',estimate_percent=>25,cascade=>true);               
exec dbms_stats.gather_table_stats (ownname=>'IFRVGA',tabname=>'ATIVID_PRECED_AGENDA_SGS',estimate_percent=>25,cascade=>true);           
exec dbms_stats.gather_table_stats (ownname=>'IFRVGA',tabname=>'ATIVID_PRECED_PADRAO_SGS',estimate_percent=>25,cascade=>true);           
exec dbms_stats.gather_table_stats (ownname=>'IFRVGA',tabname=>'ATRIBUTO_VALORES_SEG',estimate_percent=>25,cascade=>true);               
exec dbms_stats.gather_table_stats (ownname=>'IFRVGA',tabname=>'AVERBACAO_APOL_SEG_SGS',estimate_percent=>25,cascade=>true);             
exec dbms_stats.gather_table_stats (ownname=>'IFRVGA',tabname=>'CAPTAL_SEG_EMPRG_SGS',estimate_percent=>25,cascade=>true);               
exec dbms_stats.gather_table_stats (ownname=>'IFRVGA',tabname=>'CARACTERISTICAS_SGS',estimate_percent=>25,cascade=>true);                
exec dbms_stats.gather_table_stats (ownname=>'IFRVGA',tabname=>'CARACTERISTICA_GRAVIDADE_SGS',estimate_percent=>25,cascade=>true);       
exec dbms_stats.gather_table_stats (ownname=>'IFRVGA',tabname=>'CARACTERISTICA_OCORRENCIA_SGS',estimate_percent=>25,cascade=>true);      
exec dbms_stats.gather_table_stats (ownname=>'IFRVGA',tabname=>'CARACT_GRAVIDAD_OCORRENCIA_SGS',estimate_percent=>25,cascade=>true);     
exec dbms_stats.gather_table_stats (ownname=>'IFRVGA',tabname=>'CARTAS_SGS',estimate_percent=>25,cascade=>true);                         
exec dbms_stats.gather_table_stats (ownname=>'IFRVGA',tabname=>'CAUSAS_SGS',estimate_percent=>25,cascade=>true);                         
exec dbms_stats.gather_table_stats (ownname=>'IFRVGA',tabname=>'CAUSA_OCORRENCIA_SGS',estimate_percent=>25,cascade=>true);               
exec dbms_stats.gather_table_stats (ownname=>'IFRVGA',tabname=>'CLASSE_ACIDENTE_SGS',estimate_percent=>25,cascade=>true);                
exec dbms_stats.gather_table_stats (ownname=>'IFRVGA',tabname=>'CLASSIFICACAO_SEGURADO_SGS',estimate_percent=>25,cascade=>true);         
exec dbms_stats.gather_table_stats (ownname=>'IFRVGA',tabname=>'CLIENTE_FORNECEDOR_SGS',estimate_percent=>25,cascade=>true);             
exec dbms_stats.gather_table_stats (ownname=>'IFRVGA',tabname=>'CLIENTE_FORNEC_INTRFACE_SGS',estimate_percent=>25,cascade=>true);        
exec dbms_stats.gather_table_stats (ownname=>'IFRVGA',tabname=>'COBERTURA_SGS',estimate_percent=>25,cascade=>true);                      
exec dbms_stats.gather_table_stats (ownname=>'IFRVGA',tabname=>'COBERTURA_VIAGEM_SGS',estimate_percent=>25,cascade=>true);               
exec dbms_stats.gather_table_stats (ownname=>'IFRVGA',tabname=>'COBERT_OBJ_APOL_SEG_SGS',estimate_percent=>25,cascade=>true);            
exec dbms_stats.gather_table_stats (ownname=>'IFRVGA',tabname=>'COB_OBJ_ESPECIF_SEG_SGS',estimate_percent=>25,cascade=>true);            
exec dbms_stats.gather_table_stats (ownname=>'IFRVGA',tabname=>'COMUNICACAO_CONTATO_CLIFOR_SGS',estimate_percent=>25,cascade=>true);     
exec dbms_stats.gather_table_stats (ownname=>'IFRVGA',tabname=>'CONTABILIZACAO_EXPORT_SGS',estimate_percent=>25,cascade=>true);          
exec dbms_stats.gather_table_stats (ownname=>'IFRVGA',tabname=>'CONTABILIZACAO_LANCAMENTO_SGS',estimate_percent=>25,cascade=>true);      
exec dbms_stats.gather_table_stats (ownname=>'IFRVGA',tabname=>'CONTABILIZACAO_SGS',estimate_percent=>25,cascade=>true);                 
exec dbms_stats.gather_table_stats (ownname=>'IFRVGA',tabname=>'CONTABIL_SGS',estimate_percent=>25,cascade=>true);                       
exec dbms_stats.gather_table_stats (ownname=>'IFRVGA',tabname=>'CONTATOS_CLIFOR_SGS',estimate_percent=>25,cascade=>true);                
exec dbms_stats.gather_table_stats (ownname=>'IFRVGA',tabname=>'CONTA_CONTABIL_FAMILIA_SGS',estimate_percent=>25,cascade=>true);         
exec dbms_stats.gather_table_stats (ownname=>'IFRVGA',tabname=>'CONTEUDO_DOCUMENTO_SGS',estimate_percent=>25,cascade=>true);             
exec dbms_stats.gather_table_stats (ownname=>'IFRVGA',tabname=>'CONTRATO_SGS',estimate_percent=>25,cascade=>true);                       
exec dbms_stats.gather_table_stats (ownname=>'IFRVGA',tabname=>'COSSEGURO_APOLICE_SGS',estimate_percent=>25,cascade=>true);              
exec dbms_stats.gather_table_stats (ownname=>'IFRVGA',tabname=>'COSSEGURO_SEGURADORA_SGS',estimate_percent=>25,cascade=>true);           
exec dbms_stats.gather_table_stats (ownname=>'IFRVGA',tabname=>'COTACAO_DIA_UM_SGS',estimate_percent=>25,cascade=>true);                 
exec dbms_stats.gather_table_stats (ownname=>'IFRVGA',tabname=>'DESPESA_SINISTRO_SGS',estimate_percent=>25,cascade=>true);               
exec dbms_stats.gather_table_stats (ownname=>'IFRVGA',tabname=>'DESTINATARIO_CARTA_SGS',estimate_percent=>25,cascade=>true);             
exec dbms_stats.gather_table_stats (ownname=>'IFRVGA',tabname=>'DICIONARIO_DADOS_SGS',estimate_percent=>25,cascade=>true);               
exec dbms_stats.gather_table_stats (ownname=>'IFRSRH',tabname=>'GRH_HST_DIRF',estimate_percent=>25,cascade=>true);                       
exec dbms_stats.gather_table_stats (ownname=>'SST',tabname=>'SST_LOG_ITEM',estimate_percent=>25,cascade=>true);                          
exec dbms_stats.gather_table_stats (ownname=>'SST',tabname=>'SST_ACIDENTE_TIPO',estimate_percent=>25,cascade=>true);                     
exec dbms_stats.gather_table_stats (ownname=>'SST',tabname=>'SST_AGENTE_LESAO',estimate_percent=>25,cascade=>true);                      
exec dbms_stats.gather_table_stats (ownname=>'SST',tabname=>'SST_AGENTE_NOCIVO',estimate_percent=>25,cascade=>true);                     
exec dbms_stats.gather_table_stats (ownname=>'SST',tabname=>'SST_ATO_INSEGURO',estimate_percent=>25,cascade=>true);                      
exec dbms_stats.gather_table_stats (ownname=>'SST',tabname=>'SST_CODIFICACAO_LESAO',estimate_percent=>25,cascade=>true);                 
exec dbms_stats.gather_table_stats (ownname=>'SST',tabname=>'SST_CONDICAO_INSEGURA',estimate_percent=>25,cascade=>true);                 
exec dbms_stats.gather_table_stats (ownname=>'SST',tabname=>'SST_DIA_DEBITADO',estimate_percent=>25,cascade=>true);                      
exec dbms_stats.gather_table_stats (ownname=>'SST',tabname=>'SST_EMPRESA',estimate_percent=>25,cascade=>true);                           
exec dbms_stats.gather_table_stats (ownname=>'SST',tabname=>'SST_FATOR_INSEGURANCA',estimate_percent=>25,cascade=>true);                 
exec dbms_stats.gather_table_stats (ownname=>'SST',tabname=>'SST_FONTE_LESAO',estimate_percent=>25,cascade=>true);                       
exec dbms_stats.gather_table_stats (ownname=>'SST',tabname=>'SST_LOCAL',estimate_percent=>25,cascade=>true);                             
exec dbms_stats.gather_table_stats (ownname=>'SST',tabname=>'SST_NATUREZA_LESAO',estimate_percent=>25,cascade=>true);                    
exec dbms_stats.gather_table_stats (ownname=>'SST',tabname=>'SST_CIPA_CARGO',estimate_percent=>25,cascade=>true);                        
exec dbms_stats.gather_table_stats (ownname=>'SST',tabname=>'SST_ACIDENTE_CLASSE',estimate_percent=>25,cascade=>true);                   
exec dbms_stats.gather_table_stats (ownname=>'SST',tabname=>'SST_ACIDENTE',estimate_percent=>25,cascade=>true);                          
exec dbms_stats.gather_table_stats (ownname=>'SST',tabname=>'SST_PERMISSAO',estimate_percent=>25,cascade=>true);                         
exec dbms_stats.gather_table_stats (ownname=>'SST',tabname=>'SST_USER_TABLES',estimate_percent=>25,cascade=>true);                       
exec dbms_stats.gather_table_stats (ownname=>'SST',tabname=>'SST_SIM_NAO',estimate_percent=>25,cascade=>true);                           
exec dbms_stats.gather_table_stats (ownname=>'SST',tabname=>'SST_SIM_NAO_TALVEZ',estimate_percent=>25,cascade=>true);                    
exec dbms_stats.gather_table_stats (ownname=>'SST',tabname=>'SST_CONSULTA',estimate_percent=>25,cascade=>true);                          
exec dbms_stats.gather_table_stats (ownname=>'SST',tabname=>'SST_NORMAL_ALTERADO',estimate_percent=>25,cascade=>true);                   
exec dbms_stats.gather_table_stats (ownname=>'SST',tabname=>'SST_DADO_TIPO',estimate_percent=>25,cascade=>true);                         
exec dbms_stats.gather_table_stats (ownname=>'SST',tabname=>'SST_GENERO',estimate_percent=>25,cascade=>true);                            
exec dbms_stats.gather_table_stats (ownname=>'SST',tabname=>'SST_PCO_TEMPERATURA',estimate_percent=>25,cascade=>true);                   
exec dbms_stats.gather_table_stats (ownname=>'SST',tabname=>'SST_PCO_TIPO',estimate_percent=>25,cascade=>true);                          
exec dbms_stats.gather_table_stats (ownname=>'SST',tabname=>'SST_PCO_PAI_TIPO',estimate_percent=>25,cascade=>true);                      
exec dbms_stats.gather_table_stats (ownname=>'SST',tabname=>'SST_PCO_FILHO_TIPO',estimate_percent=>25,cascade=>true);                    
exec dbms_stats.gather_table_stats (ownname=>'SST',tabname=>'SST_OFU_ACESSIVEL',estimate_percent=>25,cascade=>true);                     
exec dbms_stats.gather_table_stats (ownname=>'SST',tabname=>'SST_ACIDENTE_IMAGEM',estimate_percent=>25,cascade=>true);                   
exec dbms_stats.gather_table_stats (ownname=>'SST',tabname=>'SST_CIPA_CADASTRO',estimate_percent=>25,cascade=>true);                     
exec dbms_stats.gather_table_stats (ownname=>'SST',tabname=>'SST_CIPA_CALENDARIO',estimate_percent=>25,cascade=>true);                   
exec dbms_stats.gather_table_stats (ownname=>'SST',tabname=>'SST_CIPA_MANDATO',estimate_percent=>25,cascade=>true);                      
exec dbms_stats.gather_table_stats (ownname=>'SST',tabname=>'SST_ITEM_AUDITADO',estimate_percent=>25,cascade=>true);                     
exec dbms_stats.gather_table_stats (ownname=>'SST',tabname=>'SST_INSPECAO',estimate_percent=>25,cascade=>true);                          
exec dbms_stats.gather_table_stats (ownname=>'IFRSELO',tabname=>'LEITURA_SELOS_TEMP',estimate_percent=>25,cascade=>true);                
exec dbms_stats.gather_table_stats (ownname=>'IFRSELO',tabname=>'LEITURA_SELO_TEMP',estimate_percent=>25,cascade=>true);                 
exec dbms_stats.gather_table_stats (ownname=>'IFRSELO',tabname=>'LEITURA_SELOS_TEMP_DUP',estimate_percent=>25,cascade=>true);            
exec dbms_stats.gather_table_stats (ownname=>'IFRSELO',tabname=>'LEITURA_SELOS_TESTE',estimate_percent=>25,cascade=>true);               
exec dbms_stats.gather_table_stats (ownname=>'IFRSELO',tabname=>'SELOS_DUPLICADOS',estimate_percent=>25,cascade=>true);                  
exec dbms_stats.gather_table_stats (ownname=>'IFRDBA2',tabname=>'DETALHE_DEPREC_REMUN_TEMP',estimate_percent=>25,cascade=>true);         
exec dbms_stats.gather_table_stats (ownname=>'IFRDBA2',tabname=>'TMP1_DETALHEDEPRECREMUN',estimate_percent=>25,cascade=>true);           
exec dbms_stats.gather_table_stats (ownname=>'SST',tabname=>'SST_LOG',estimate_percent=>25,cascade=>true);                               
exec dbms_stats.gather_table_stats (ownname=>'SST',tabname=>'SST_INSPECAO_IMAGEM',estimate_percent=>25,cascade=>true);                   
exec dbms_stats.gather_table_stats (ownname=>'SST',tabname=>'SST_INSPECAO_ITEM',estimate_percent=>25,cascade=>true);                     
exec dbms_stats.gather_table_stats (ownname=>'SST',tabname=>'SST_PCO',estimate_percent=>25,cascade=>true);                               
exec dbms_stats.gather_table_stats (ownname=>'SST',tabname=>'SST_PCO_PC_PAI',estimate_percent=>25,cascade=>true);                        
exec dbms_stats.gather_table_stats (ownname=>'SST',tabname=>'SST_PCO_PC_FILHO',estimate_percent=>25,cascade=>true);                      
exec dbms_stats.gather_table_stats (ownname=>'SST',tabname=>'SST_RISCO_AMBIENTAL',estimate_percent=>25,cascade=>true);                   
exec dbms_stats.gather_table_stats (ownname=>'SST',tabname=>'SST_RAM_ITEM',estimate_percent=>25,cascade=>true);                          
exec dbms_stats.gather_table_stats (ownname=>'SST',tabname=>'SST_RAM_EMPREGADO',estimate_percent=>25,cascade=>true);                     
exec dbms_stats.gather_table_stats (ownname=>'SST',tabname=>'SST_PCMSO_TIPO',estimate_percent=>25,cascade=>true);                        
exec dbms_stats.gather_table_stats (ownname=>'SST',tabname=>'SST_PCMSO_PAI_ITEM',estimate_percent=>25,cascade=>true);                    
exec dbms_stats.gather_table_stats (ownname=>'SST',tabname=>'SST_EVOLUCAO',estimate_percent=>25,cascade=>true);                          
exec dbms_stats.gather_table_stats (ownname=>'SST',tabname=>'SST_EVOLUCAO_ITEM',estimate_percent=>25,cascade=>true);                     
exec dbms_stats.gather_table_stats (ownname=>'SST',tabname=>'SST_EVOLUCAOE',estimate_percent=>25,cascade=>true);                         
exec dbms_stats.gather_table_stats (ownname=>'SST',tabname=>'SST_EVOLUCAOE_ITEM',estimate_percent=>25,cascade=>true);                    
exec dbms_stats.gather_table_stats (ownname=>'SST',tabname=>'SST_CONVOCACAO',estimate_percent=>25,cascade=>true);                        
exec dbms_stats.gather_table_stats (ownname=>'SST',tabname=>'SST_CONVOCACAO_ITEM',estimate_percent=>25,cascade=>true);                   
exec dbms_stats.gather_table_stats (ownname=>'SST',tabname=>'SST_ASO',estimate_percent=>25,cascade=>true);                               
exec dbms_stats.gather_table_stats (ownname=>'SST',tabname=>'SST_EPI_DETALHE',estimate_percent=>25,cascade=>true);                       
exec dbms_stats.gather_table_stats (ownname=>'SST',tabname=>'SST_EPI_IMAGEM',estimate_percent=>25,cascade=>true);                        
exec dbms_stats.gather_table_stats (ownname=>'SST',tabname=>'SST_EPI_USUARIO',estimate_percent=>25,cascade=>true);                       
exec dbms_stats.gather_table_stats (ownname=>'SST',tabname=>'SST_EPI_USUARIO_ITEM',estimate_percent=>25,cascade=>true);                  
exec dbms_stats.gather_table_stats (ownname=>'SST',tabname=>'SST_EPI_USUARIO_ENTREGA',estimate_percent=>25,cascade=>true);               
exec dbms_stats.gather_table_stats (ownname=>'SST',tabname=>'SST_PPP',estimate_percent=>25,cascade=>true);                               
exec dbms_stats.gather_table_stats (ownname=>'IFRVGA',tabname=>'MANUTENCAO_APLSEG_SGS',estimate_percent=>25,cascade=>true);              
exec dbms_stats.gather_table_stats (ownname=>'IFRVGA',tabname=>'MANUTENCAO_OBAPSG_SGS',estimate_percent=>25,cascade=>true);              
exec dbms_stats.gather_table_stats (ownname=>'IFRVGA',tabname=>'MANUTENCAO_CBOBAS_SGS',estimate_percent=>25,cascade=>true);              
exec dbms_stats.gather_table_stats (ownname=>'IFRVGA',tabname=>'COSSEGURADOS_APOLICE_SGS',estimate_percent=>25,cascade=>true);           
exec dbms_stats.gather_table_stats (ownname=>'IFRVGA',tabname=>'ORIGEM_OCORRENCIA_SGS',estimate_percent=>25,cascade=>true);              
exec dbms_stats.gather_table_stats (ownname=>'IFRVGA',tabname=>'RESPONSAVEL_ORIGEM_OCORRNC_SGS',estimate_percent=>25,cascade=>true);     
exec dbms_stats.gather_table_stats (ownname=>'IFRVGA',tabname=>'DOCUMENTO_EXTERNO_SGS',estimate_percent=>25,cascade=>true);              
exec dbms_stats.gather_table_stats (ownname=>'SST',tabname=>'SST_ABSENTEISMO',estimate_percent=>25,cascade=>true);                       
exec dbms_stats.gather_table_stats (ownname=>'IFRSRH',tabname=>'EMPREGADOS_OPTANTES',estimate_percent=>25,cascade=>true);                
exec dbms_stats.gather_table_stats (ownname=>'IFRBDE',tabname=>'CAD_RESUMO_CRONOGRAMA',estimate_percent=>25,cascade=>true);              
exec dbms_stats.gather_table_stats (ownname=>'IFRBDE',tabname=>'CAD_RESUMO_PAGAMENTO',estimate_percent=>25,cascade=>true);               
exec dbms_stats.gather_table_stats (ownname=>'IFRBDE',tabname=>'HST_PAGAMENTO_CRONOGRAMA',estimate_percent=>25,cascade=>true);           
exec dbms_stats.gather_table_stats (ownname=>'IFRBDE',tabname=>'CAD_GARANTIA_CAUCIONARIA',estimate_percent=>25,cascade=>true);           
exec dbms_stats.gather_table_stats (ownname=>'IFRBDE',tabname=>'CAD_TERMO_ADITIVO_CONTRATO',estimate_percent=>25,cascade=>true);         
exec dbms_stats.gather_table_stats (ownname=>'IFRSRH',tabname=>'DEDUCAO_INSS_EMPREGADOS',estimate_percent=>25,cascade=>true);            
exec dbms_stats.gather_table_stats (ownname=>'IFRSRH',tabname=>'DEDUCAO_INSS_AUT_COOP',estimate_percent=>25,cascade=>true);              
exec dbms_stats.gather_table_stats (ownname=>'IFRSRH',tabname=>'CREDENC_INSS_OUTROS_RECOLHIM',estimate_percent=>25,cascade=>true);       
ALTER USER SYS TEMPORARY TABLESPACE SYSTEM;                                                                                          
