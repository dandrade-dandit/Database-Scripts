SQL> 
SQL> DECLARE
  2   my_ow        all_tables.owner%type;
  3   my_tab       all_tables.table_name%type;
  4   cursor_name  INTEGER;
  5   ret   INTEGER;
  6   script  varchar2(100);
  7   cursor c1 is
  8     select a.owner,a.table_name
  9     from   ifrbanco.analyz_tabelas b, sys.dba_tables A
 10     where A.owner not in ('SYS','SYSMAN','SYSTEM','DONOREP','DISCOVERER','WEBSYS',
 11           'OUTLN','PERFSTAT','OSE$HTTP$ADMIN','AURORA$JIS$UTILITY$') and
 12           'LOG_' <> substr(A.table_name,1,4) and
 13           'TMP_' <> substr(A.table_name,1,4) and
 14           'EMP_' <> substr(A.table_name,1,4) and
 15           'TEMP_' <> substr(A.table_name,1,5) and
 16           'PLAN_' <> substr(A.table_name,1,5) and
 17      A.table_name not in ('LEITURA_SELOS','HST_LEITURA_SELOS_OLD',
 18       'RECIBO_TARIFAS_EMBARQUE_OLD','PAGAMENTO_CALCULADO_2110',
 19       'PAGAMENTO_CALCULADO_FINAL','REMUNERACAO_2110',
 20       'REMUNERACAO_FINAL','PROJECAO_MOVIMENTO_PAGAMENTO',
 21       'POSICAO_MOVIMENTO_PAGAMENTO') and
 22      a.num_rows * a.avg_row_len > 131000 and
 23      to_char(b.data_analyz,'yyyy/mm/dd')='2002/11/28' and
 24           a.owner=b.owner and a.table_name=b.tabela and a.num_rows <> b.num_regs
 25     order by A.owner,A.table_name;
 26   CURSOR C2 IS
 27        SELECT owner,table_name,num_rows,avg_row_len
 28        FROM sys.dba_tables
 29        WHERE (num_rows > 0 and num_rows is not null)
 30        ORDER BY 1,2;
 31  BEGIN
 32    dbms_output.put_line ('ALTER USER SYS TEMPORARY TABLESPACE TEMP;');
 33    OPEN C1;
 34    LOOP
 35      FETCH C1 inTO my_ow, my_tab;
 36        EXIT WHEN C1%NOTFOUND;
 37        dbms_output.put_line ('exec dbms_stats.gather_table_stats (ownname=>'''||my_ow||''',tabname=>'''||my_tab||''',estimate_percent=>25,cascade=>true);');
 38    end loop;
 39    dbms_output.put_line ('ALTER USER SYS TEMPORARY TABLESPACE SYSTEM;');
 40    close c1;
 41  --  FOR C3 IN C2 LOOP
 42  --         BEGIN
 43  --            insert into ifrbanco.analyz_tabelas
 44  --     values
 45  --     (C3.owner,C3.table_name,SYSDATE,C3.num_rows,C3.avg_row_len);
 46  --         END;
 47  --  END LOOP;
 48  --  COMMIT;
 49  END;
 50  /
ALTER USER SYS TEMPORARY TABLESPACE TEMP;                                                                                           
exec dbms_stats.gather_table_stats (ownname=>'IFRCLIM',tabname=>'ATRIB_ESTACAO',estimate_percent=>25,cascade=>true);                
exec dbms_stats.gather_table_stats (ownname=>'IFRCLIM',tabname=>'CORR_ATRIB_EST',estimate_percent=>25,cascade=>true);               
exec dbms_stats.gather_table_stats (ownname=>'IFRCLIM',tabname=>'IMPORTA_INFOMET',estimate_percent=>25,cascade=>true);              
exec dbms_stats.gather_table_stats (ownname=>'IFRCLIM',tabname=>'MEDICAO',estimate_percent=>25,cascade=>true);                      
exec dbms_stats.gather_table_stats (ownname=>'IFRCLIM',tabname=>'MEDICAO_ALT',estimate_percent=>25,cascade=>true);                  
exec dbms_stats.gather_table_stats (ownname=>'IFRCLIM',tabname=>'MEDICAO_INV',estimate_percent=>25,cascade=>true);                  
exec dbms_stats.gather_table_stats (ownname=>'IFRCLIM',tabname=>'MULTIANUAL',estimate_percent=>25,cascade=>true);                   
exec dbms_stats.gather_table_stats (ownname=>'IFRDBA2',tabname=>'ACOMP_SITUACAO_BEM_PATRIM',estimate_percent=>25,cascade=>true);    
exec dbms_stats.gather_table_stats (ownname=>'IFRDBA2',tabname=>'AGENCIAINF',estimate_percent=>25,cascade=>true);                   
exec dbms_stats.gather_table_stats (ownname=>'IFRDBA2',tabname=>'AUX_EVENT_SIMBEP',estimate_percent=>25,cascade=>true);             
exec dbms_stats.gather_table_stats (ownname=>'IFRDBA2',tabname=>'BAIXA_BEM_PATRIMONIAL',estimate_percent=>25,cascade=>true);        
exec dbms_stats.gather_table_stats (ownname=>'IFRDBA2',tabname=>'BEM_PATRIMONIAL',estimate_percent=>25,cascade=>true);              
exec dbms_stats.gather_table_stats (ownname=>'IFRDBA2',tabname=>'CARAC_MAT_ITEM_GENERICO',estimate_percent=>25,cascade=>true);      
exec dbms_stats.gather_table_stats (ownname=>'IFRDBA2',tabname=>'CONTA_CONTABIL',estimate_percent=>25,cascade=>true);               
exec dbms_stats.gather_table_stats (ownname=>'IFRDBA2',tabname=>'CUSTODIA',estimate_percent=>25,cascade=>true);                     
exec dbms_stats.gather_table_stats (ownname=>'IFRDBA2',tabname=>'DESPESAS_ORCAMENTO',estimate_percent=>25,cascade=>true);           
exec dbms_stats.gather_table_stats (ownname=>'IFRDBA2',tabname=>'DETALHE_ADICAO_EXCLUSAO_FA',estimate_percent=>25,cascade=>true);   
exec dbms_stats.gather_table_stats (ownname=>'IFRDBA2',tabname=>'DETALHE_ADICAO_PO',estimate_percent=>25,cascade=>true);            
exec dbms_stats.gather_table_stats (ownname=>'IFRDBA2',tabname=>'DETALHE_DEPREC_REMUN',estimate_percent=>25,cascade=>true);         
exec dbms_stats.gather_table_stats                                                                                                  
(ownname=>'IFRDBA2',tabname=>'DET_ADICAO_EXCL_FA_CH_CONTABIL',estimate_percent=>25,cascade=>true);                                  
exec dbms_stats.gather_table_stats (ownname=>'IFRDBA2',tabname=>'DIVULGACAO_LICITACAO',estimate_percent=>25,cascade=>true);         
exec dbms_stats.gather_table_stats (ownname=>'IFRDBA2',tabname=>'DOCUMENTOS_PROCESSO',estimate_percent=>25,cascade=>true);          
exec dbms_stats.gather_table_stats (ownname=>'IFRDBA2',tabname=>'EDITAL_LICITACAO',estimate_percent=>25,cascade=>true);             
exec dbms_stats.gather_table_stats (ownname=>'IFRDBA2',tabname=>'ENTRADA_ESTOQUE',estimate_percent=>25,cascade=>true);              
exec dbms_stats.gather_table_stats (ownname=>'IFRDBA2',tabname=>'EVENTO_DO_PROCESSO',estimate_percent=>25,cascade=>true);           
exec dbms_stats.gather_table_stats (ownname=>'IFRDBA2',tabname=>'EXCLUSAO_BEM_PATRIMONIAL',estimate_percent=>25,cascade=>true);     
exec dbms_stats.gather_table_stats (ownname=>'IFRDBA2',tabname=>'FATOR_PREVISAO',estimate_percent=>25,cascade=>true);               
exec dbms_stats.gather_table_stats (ownname=>'IFRDBA2',tabname=>'FORNECEDOR',estimate_percent=>25,cascade=>true);                   
exec dbms_stats.gather_table_stats (ownname=>'IFRDBA2',tabname=>'FORNECEDOR_DEPENDENCIA',estimate_percent=>25,cascade=>true);       
exec dbms_stats.gather_table_stats (ownname=>'IFRDBA2',tabname=>'HISTORICO_CENTRO_CUSTOS',estimate_percent=>25,cascade=>true);      
exec dbms_stats.gather_table_stats (ownname=>'IFRDBA2',tabname=>'INCIDENCIA_CENTRO_CUSTO',estimate_percent=>25,cascade=>true);      
exec dbms_stats.gather_table_stats (ownname=>'IFRDBA2',tabname=>'INVENTARIO',estimate_percent=>25,cascade=>true);                   
exec dbms_stats.gather_table_stats (ownname=>'IFRDBA2',tabname=>'ITEM_DA_TRANSFERENCIA',estimate_percent=>25,cascade=>true);        
exec dbms_stats.gather_table_stats (ownname=>'IFRDBA2',tabname=>'ITEM_DO_SISTEMA',estimate_percent=>25,cascade=>true);              
exec dbms_stats.gather_table_stats (ownname=>'IFRDBA2',tabname=>'ITEM_ENTRADA_ESTOQUE',estimate_percent=>25,cascade=>true);         
exec dbms_stats.gather_table_stats (ownname=>'IFRDBA2',tabname=>'ITEM_GENERICO',estimate_percent=>25,cascade=>true);                
exec dbms_stats.gather_table_stats (ownname=>'IFRDBA2',tabname=>'ITEM_INEDITO',estimate_percent=>25,cascade=>true);                 
exec dbms_stats.gather_table_stats (ownname=>'IFRDBA2',tabname=>'ITEM_MENSAL_PROP_ORC_SIM',estimate_percent=>25,cascade=>true);     
exec dbms_stats.gather_table_stats (ownname=>'IFRDBA2',tabname=>'ITEM_POR_DEPENDENCIA',estimate_percent=>25,cascade=>true);         
exec dbms_stats.gather_table_stats (ownname=>'IFRDBA2',tabname=>'ITEM_PROPOSTA_LICITACAO',estimate_percent=>25,cascade=>true);      
exec dbms_stats.gather_table_stats (ownname=>'IFRDBA2',tabname=>'ITEM_PROPOSTA_ORCAMENTARIA',estimate_percent=>25,cascade=>true);   
exec dbms_stats.gather_table_stats (ownname=>'IFRDBA2',tabname=>'ITEM_PROPOSTA_ORC_SIMULADA',estimate_percent=>25,cascade=>true);   
exec dbms_stats.gather_table_stats (ownname=>'IFRDBA2',tabname=>'ITEM_REQUISICAO',estimate_percent=>25,cascade=>true);              
exec dbms_stats.gather_table_stats (ownname=>'IFRDBA2',tabname=>'ITEM_SAIDA_ESTOQUE',estimate_percent=>25,cascade=>true);           
exec dbms_stats.gather_table_stats (ownname=>'IFRDBA2',tabname=>'LANCAMENTO_CONTABIL_MATERIAL',estimate_percent=>25,cascade=>true); 
exec dbms_stats.gather_table_stats (ownname=>'IFRDBA2',tabname=>'LOTE_ESTOQUE',estimate_percent=>25,cascade=>true);                 
exec dbms_stats.gather_table_stats (ownname=>'IFRDBA2',tabname=>'LOTE_REQUISICOES_COMPRAS',estimate_percent=>25,cascade=>true);     
exec dbms_stats.gather_table_stats (ownname=>'IFRDBA2',tabname=>'MEMBRO_COMISSAO_LICITACAO',estimate_percent=>25,cascade=>true);    
exec dbms_stats.gather_table_stats (ownname=>'IFRDBA2',tabname=>'ORC_CONSOL_ANA_CONTA',estimate_percent=>25,cascade=>true);         
exec dbms_stats.gather_table_stats (ownname=>'IFRDBA2',tabname=>'ORDEM_SERVICO',estimate_percent=>25,cascade=>true);                
exec dbms_stats.gather_table_stats (ownname=>'IFRDBA2',tabname=>'PARTICIPANTE_DE_LICITACAO',estimate_percent=>25,cascade=>true);    
exec dbms_stats.gather_table_stats (ownname=>'IFRDBA2',tabname=>'PROCESSO_LICITATORIO',estimate_percent=>25,cascade=>true);         
exec dbms_stats.gather_table_stats (ownname=>'IFRDBA2',tabname=>'PROJECAO_MENSAL_REC_SIM',estimate_percent=>25,cascade=>true);      
exec dbms_stats.gather_table_stats (ownname=>'IFRDBA2',tabname=>'PROJECAO_RECEITA_SIMULADA',estimate_percent=>25,cascade=>true);    
exec dbms_stats.gather_table_stats (ownname=>'IFRDBA2',tabname=>'RELAT_CC_SELECIONADOS',estimate_percent=>25,cascade=>true);        
exec dbms_stats.gather_table_stats (ownname=>'IFRDBA2',tabname=>'RELAT_COLUNA_ANUAL',estimate_percent=>25,cascade=>true);           
exec dbms_stats.gather_table_stats (ownname=>'IFRDBA2',tabname=>'RELAT_DEP_SELECIONADAS',estimate_percent=>25,cascade=>true);       
exec dbms_stats.gather_table_stats (ownname=>'IFRDBA2',tabname=>'REQUISICAO_COMPRA_ITEM',estimate_percent=>25,cascade=>true);       
exec dbms_stats.gather_table_stats (ownname=>'IFRDBA2',tabname=>'REQUISICOES_COMPRAS_DO_LOTE',estimate_percent=>25,cascade=>true);  
exec dbms_stats.gather_table_stats (ownname=>'IFRDBA2',tabname=>'SAIDA_ESTOQUE',estimate_percent=>25,cascade=>true);                
exec dbms_stats.gather_table_stats (ownname=>'IFRDBA2',tabname=>'SEG_LOG_USUARIO_DEPENDENCIA',estimate_percent=>25,cascade=>true);  
exec dbms_stats.gather_table_stats (ownname=>'IFRDBA2',tabname=>'SEG_LOG_USUARIO_SISTEMA',estimate_percent=>25,cascade=>true);      
exec dbms_stats.gather_table_stats (ownname=>'IFRDBA2',tabname=>'SEG_USUARIO',estimate_percent=>25,cascade=>true);                  
exec dbms_stats.gather_table_stats (ownname=>'IFRDBA2',tabname=>'SEG_USUARIO_CENTRO_CUSTO',estimate_percent=>25,cascade=>true);     
exec dbms_stats.gather_table_stats (ownname=>'IFRDBA2',tabname=>'SEG_USUARIO_SISTEMA',estimate_percent=>25,cascade=>true);          
exec dbms_stats.gather_table_stats (ownname=>'IFRDBA2',tabname=>'SIPAT_EMPREGADOS',estimate_percent=>25,cascade=>true);             
exec dbms_stats.gather_table_stats (ownname=>'IFRDBA2',tabname=>'SIPAT_INTERFACE_CONTABIL',estimate_percent=>25,cascade=>true);     
exec dbms_stats.gather_table_stats                                                                                                  
(ownname=>'IFRDBA2',tabname=>'SIT_ANUAL_CONTA_PATRIM_EXE_ANT',estimate_percent=>25,cascade=>true);                                  
exec dbms_stats.gather_table_stats (ownname=>'IFRDBA2',tabname=>'SIT_MENSAL_BEM_PATRIMONIAL',estimate_percent=>25,cascade=>true);   
exec dbms_stats.gather_table_stats (ownname=>'IFRDBA2',tabname=>'SIT_MENSAL_CONTA_PATRIMONIAL',estimate_percent=>25,cascade=>true); 
exec dbms_stats.gather_table_stats (ownname=>'IFRDBA2',tabname=>'SMS',estimate_percent=>25,cascade=>true);                          
exec dbms_stats.gather_table_stats (ownname=>'IFRDBA2',tabname=>'SS_BEM_PATRIMONIAL',estimate_percent=>25,cascade=>true);           
exec dbms_stats.gather_table_stats (ownname=>'IFRDBA2',tabname=>'TRANSFERENCIA_ITENS',estimate_percent=>25,cascade=>true);          
exec dbms_stats.gather_table_stats (ownname=>'IFRDBA2',tabname=>'TRANSFER_BEM_PATRIMONIAL',estimate_percent=>25,cascade=>true);     
exec dbms_stats.gather_table_stats (ownname=>'IFRDBA2',tabname=>'UNIDADES_ORGANIZACIONAIS',estimate_percent=>25,cascade=>true);     
exec dbms_stats.gather_table_stats (ownname=>'IFRDBA2',tabname=>'VALOR_CARAC_BEM_PATRIMONIAL',estimate_percent=>25,cascade=>true);  
exec dbms_stats.gather_table_stats (ownname=>'IFRHUMANUS',tabname=>'TRN_EVENTO_PARTICIP',estimate_percent=>25,cascade=>true);       
exec dbms_stats.gather_table_stats (ownname=>'IFRMAXIMO',tabname=>'CHARTOFACCOUNTS',estimate_percent=>25,cascade=>true);            
exec dbms_stats.gather_table_stats (ownname=>'IFRMAXIMO',tabname=>'EQHIERARCHY',estimate_percent=>25,cascade=>true);                
exec dbms_stats.gather_table_stats (ownname=>'IFRMAXIMO',tabname=>'EQHISTORY',estimate_percent=>25,cascade=>true);                  
exec dbms_stats.gather_table_stats (ownname=>'IFRMAXIMO',tabname=>'EQSTATUS',estimate_percent=>25,cascade=>true);                   
exec dbms_stats.gather_table_stats (ownname=>'IFRMAXIMO',tabname=>'EQTRANS',estimate_percent=>25,cascade=>true);                    
exec dbms_stats.gather_table_stats (ownname=>'IFRMAXIMO',tabname=>'EQUIPAMENTO',estimate_percent=>25,cascade=>true);                
exec dbms_stats.gather_table_stats (ownname=>'IFRMAXIMO',tabname=>'EQUIPMENT',estimate_percent=>25,cascade=>true);                  
exec dbms_stats.gather_table_stats (ownname=>'IFRMAXIMO',tabname=>'INVBALANCES',estimate_percent=>25,cascade=>true);                
exec dbms_stats.gather_table_stats (ownname=>'IFRMAXIMO',tabname=>'INVENTORY',estimate_percent=>25,cascade=>true);                  
exec dbms_stats.gather_table_stats (ownname=>'IFRMAXIMO',tabname=>'INVRESERVE',estimate_percent=>25,cascade=>true);                 
exec dbms_stats.gather_table_stats (ownname=>'IFRMAXIMO',tabname=>'INVTRANS',estimate_percent=>25,cascade=>true);                   
exec dbms_stats.gather_table_stats (ownname=>'IFRMAXIMO',tabname=>'ITEM',estimate_percent=>25,cascade=>true);                       
exec dbms_stats.gather_table_stats (ownname=>'IFRMAXIMO',tabname=>'JOBLABOR',estimate_percent=>25,cascade=>true);                   
exec dbms_stats.gather_table_stats (ownname=>'IFRMAXIMO',tabname=>'JOBOPERATION',estimate_percent=>25,cascade=>true);               
exec dbms_stats.gather_table_stats (ownname=>'IFRMAXIMO',tabname=>'JOBPLAN',estimate_percent=>25,cascade=>true);                    
exec dbms_stats.gather_table_stats (ownname=>'IFRMAXIMO',tabname=>'JOBTOOL',estimate_percent=>25,cascade=>true);                    
exec dbms_stats.gather_table_stats (ownname=>'IFRMAXIMO',tabname=>'LABOR',estimate_percent=>25,cascade=>true);                      
exec dbms_stats.gather_table_stats (ownname=>'IFRMAXIMO',tabname=>'LABTRANS',estimate_percent=>25,cascade=>true);                   
exec dbms_stats.gather_table_stats (ownname=>'IFRMAXIMO',tabname=>'LOCANCESTOR',estimate_percent=>25,cascade=>true);                
exec dbms_stats.gather_table_stats (ownname=>'IFRMAXIMO',tabname=>'LOCATIONS',estimate_percent=>25,cascade=>true);                  
exec dbms_stats.gather_table_stats (ownname=>'IFRMAXIMO',tabname=>'LOCHIERARCHY',estimate_percent=>25,cascade=>true);               
exec dbms_stats.gather_table_stats (ownname=>'IFRMAXIMO',tabname=>'LOCOPER',estimate_percent=>25,cascade=>true);                    
exec dbms_stats.gather_table_stats (ownname=>'IFRMAXIMO',tabname=>'LONGDESCRIPTION',estimate_percent=>25,cascade=>true);            
exec dbms_stats.gather_table_stats (ownname=>'IFRMAXIMO',tabname=>'MATUSETRANS',estimate_percent=>25,cascade=>true);                
exec dbms_stats.gather_table_stats (ownname=>'IFRMAXIMO',tabname=>'MAXHLP',estimate_percent=>25,cascade=>true);                     
exec dbms_stats.gather_table_stats (ownname=>'IFRMAXIMO',tabname=>'MAXSYSCOLSCFG',estimate_percent=>25,cascade=>true);              
exec dbms_stats.gather_table_stats (ownname=>'IFRMAXIMO',tabname=>'MAXSYSCOLUMNS',estimate_percent=>25,cascade=>true);              
exec dbms_stats.gather_table_stats (ownname=>'IFRMAXIMO',tabname=>'MAXUSERAUTH',estimate_percent=>25,cascade=>true);                
exec dbms_stats.gather_table_stats (ownname=>'IFRMAXIMO',tabname=>'PM',estimate_percent=>25,cascade=>true);                         
exec dbms_stats.gather_table_stats (ownname=>'IFRMAXIMO',tabname=>'PMANCESTOR',estimate_percent=>25,cascade=>true);                 
exec dbms_stats.gather_table_stats (ownname=>'IFRMAXIMO',tabname=>'PMSEQUENCE',estimate_percent=>25,cascade=>true);                 
exec dbms_stats.gather_table_stats (ownname=>'IFRMAXIMO',tabname=>'TOOL',estimate_percent=>25,cascade=>true);                       
exec dbms_stats.gather_table_stats (ownname=>'IFRMAXIMO',tabname=>'TOOLTRANS',estimate_percent=>25,cascade=>true);                  
exec dbms_stats.gather_table_stats (ownname=>'IFRMAXIMO',tabname=>'USERRESTRICTIONS',estimate_percent=>25,cascade=>true);           
exec dbms_stats.gather_table_stats (ownname=>'IFRMAXIMO',tabname=>'WOANCESTOR',estimate_percent=>25,cascade=>true);                 
exec dbms_stats.gather_table_stats (ownname=>'IFRMAXIMO',tabname=>'WORKORDER',estimate_percent=>25,cascade=>true);                  
exec dbms_stats.gather_table_stats (ownname=>'IFRMAXIMO',tabname=>'WORKPERIOD',estimate_percent=>25,cascade=>true);                 
exec dbms_stats.gather_table_stats (ownname=>'IFRMAXIMO',tabname=>'WOSTATUS',estimate_percent=>25,cascade=>true);                   
exec dbms_stats.gather_table_stats (ownname=>'IFRMAXIMO',tabname=>'WPLABOR',estimate_percent=>25,cascade=>true);                    
exec dbms_stats.gather_table_stats (ownname=>'IFRMAXIMO',tabname=>'WPMATERIAL',estimate_percent=>25,cascade=>true);                 
exec dbms_stats.gather_table_stats (ownname=>'IFRMAXIMO',tabname=>'WPOPERATION',estimate_percent=>25,cascade=>true);                
exec dbms_stats.gather_table_stats (ownname=>'IFRMAXIMO',tabname=>'WPTOOL',estimate_percent=>25,cascade=>true);                     
exec dbms_stats.gather_table_stats (ownname=>'IFRSELO',tabname=>'DISCREPANCIAS_SELOS',estimate_percent=>25,cascade=>true);          
exec dbms_stats.gather_table_stats (ownname=>'IFRSELO',tabname=>'HST_LEITURA_SELOS',estimate_percent=>25,cascade=>true);            
exec dbms_stats.gather_table_stats (ownname=>'IFRSELO',tabname=>'RECIBO_TARIFAS_EMBARQUE',estimate_percent=>25,cascade=>true);      
exec dbms_stats.gather_table_stats (ownname=>'IFRSELO',tabname=>'RSTE_TARIFAS_EMBARQUE',estimate_percent=>25,cascade=>true);        
exec dbms_stats.gather_table_stats (ownname=>'IFRSELO',tabname=>'SELOS_DEVOLVIDOS',estimate_percent=>25,cascade=>true);             
exec dbms_stats.gather_table_stats (ownname=>'IFRSRH',tabname=>'AMB',estimate_percent=>25,cascade=>true);                           
exec dbms_stats.gather_table_stats (ownname=>'IFRSRH',tabname=>'ANS',estimate_percent=>25,cascade=>true);                           
exec dbms_stats.gather_table_stats (ownname=>'IFRSRH',tabname=>'ARQUIVO_CREDITO_BANCARIO',estimate_percent=>25,cascade=>true);      
exec dbms_stats.gather_table_stats (ownname=>'IFRSRH',tabname=>'ARQUIVO_CREDITO_BANCARIO_PENS',estimate_percent=>25,cascade=>true); 
exec dbms_stats.gather_table_stats (ownname=>'IFRSRH',tabname=>'ATIVIDADES',estimate_percent=>25,cascade=>true);                    
exec dbms_stats.gather_table_stats (ownname=>'IFRSRH',tabname=>'AUTORIZACOES_TRATAMENTOS_ODONT',estimate_percent=>25,cascade=>true);
exec dbms_stats.gather_table_stats (ownname=>'IFRSRH',tabname=>'A_PROCEDIMENTOS_ODONTOLOGICOS',estimate_percent=>25,cascade=>true); 
exec dbms_stats.gather_table_stats (ownname=>'IFRSRH',tabname=>'BENEFICIARIOS_SEGUROS',estimate_percent=>25,cascade=>true);         
exec dbms_stats.gather_table_stats (ownname=>'IFRSRH',tabname=>'CADASTROS',estimate_percent=>25,cascade=>true);                     
exec dbms_stats.gather_table_stats (ownname=>'IFRSRH',tabname=>'CADASTROS_TMP',estimate_percent=>25,cascade=>true);                 
exec dbms_stats.gather_table_stats (ownname=>'IFRSRH',tabname=>'CID',estimate_percent=>25,cascade=>true);                           
exec dbms_stats.gather_table_stats (ownname=>'IFRSRH',tabname=>'CONTROLE_USUARIOS_FUNCOES',estimate_percent=>25,cascade=>true);     
exec dbms_stats.gather_table_stats (ownname=>'IFRSRH',tabname=>'CONTROLE_USUARIOS_OCORRENCIAS',estimate_percent=>25,cascade=>true); 
exec dbms_stats.gather_table_stats (ownname=>'IFRSRH',tabname=>'CONTROLE_USUARIO_DEPENDENCIA',estimate_percent=>25,cascade=>true);  
exec dbms_stats.gather_table_stats (ownname=>'IFRSRH',tabname=>'CORPO_CLINICO',estimate_percent=>25,cascade=>true);                 
exec dbms_stats.gather_table_stats (ownname=>'IFRSRH',tabname=>'CREDENCIADOS',estimate_percent=>25,cascade=>true);                  
exec dbms_stats.gather_table_stats (ownname=>'IFRSRH',tabname=>'CREDENCIADOS_CONTRATOS',estimate_percent=>25,cascade=>true);        
exec dbms_stats.gather_table_stats (ownname=>'IFRSRH',tabname=>'CRONOGRAMAS_PAGAMENTOS',estimate_percent=>25,cascade=>true);        
exec dbms_stats.gather_table_stats (ownname=>'IFRSRH',tabname=>'DATAPREV_REEMBOLSO_RUBRICAS',estimate_percent=>25,cascade=>true);   
exec dbms_stats.gather_table_stats (ownname=>'IFRSRH',tabname=>'DATAPREV_REEMBOLSO_RUBRICAS_TE',estimate_percent=>25,cascade=>true);
exec dbms_stats.gather_table_stats (ownname=>'IFRSRH',tabname=>'DEPENDENTES_USU_PLANO_SAUDE',estimate_percent=>25,cascade=>true);   
exec dbms_stats.gather_table_stats (ownname=>'IFRSRH',tabname=>'DIVERSOS_MEDICAS_HOSPIT',estimate_percent=>25,cascade=>true);       
exec dbms_stats.gather_table_stats (ownname=>'IFRSRH',tabname=>'DOCUMENTACAO_CONTRATUAL',estimate_percent=>25,cascade=>true);       
exec dbms_stats.gather_table_stats (ownname=>'IFRSRH',tabname=>'DOCUMENTOS_COBRANCA',estimate_percent=>25,cascade=>true);           
exec dbms_stats.gather_table_stats (ownname=>'IFRSRH',tabname=>'EFETIVO_INFRAERO',estimate_percent=>25,cascade=>true);              
exec dbms_stats.gather_table_stats (ownname=>'IFRSRH',tabname=>'EMPREGADOS_BENEFICIOS',estimate_percent=>25,cascade=>true);         
exec dbms_stats.gather_table_stats (ownname=>'IFRSRH',tabname=>'EMPREGADOS_CATEGORIAS',estimate_percent=>25,cascade=>true);         
exec dbms_stats.gather_table_stats (ownname=>'IFRSRH',tabname=>'EMPREGADOS_FERIAS_13',estimate_percent=>25,cascade=>true);          
exec dbms_stats.gather_table_stats (ownname=>'IFRSRH',tabname=>'EMPREGADOS_PAGAMENTOS',estimate_percent=>25,cascade=>true);         
exec dbms_stats.gather_table_stats (ownname=>'IFRSRH',tabname=>'EMPREGADOS_PARTICIPACAO_LUCROS',estimate_percent=>25,cascade=>true);
exec dbms_stats.gather_table_stats (ownname=>'IFRSRH',tabname=>'EMPRESTIMOS_INFRAPREV',estimate_percent=>25,cascade=>true);         
exec dbms_stats.gather_table_stats (ownname=>'IFRSRH',tabname=>'ESPECIFICACAO_CID',estimate_percent=>25,cascade=>true);             
exec dbms_stats.gather_table_stats (ownname=>'IFRSRH',tabname=>'EXAMES_OBRIGATORIOS',estimate_percent=>25,cascade=>true);           
exec dbms_stats.gather_table_stats (ownname=>'IFRSRH',tabname=>'GUIAS',estimate_percent=>25,cascade=>true);                         
exec dbms_stats.gather_table_stats (ownname=>'IFRSRH',tabname=>'GUIAS_PROCEDIMENTOS',estimate_percent=>25,cascade=>true);           
exec dbms_stats.gather_table_stats (ownname=>'IFRSRH',tabname=>'HISTORICOS_FUNCOES_LOTACOES',estimate_percent=>25,cascade=>true);   
exec dbms_stats.gather_table_stats (ownname=>'IFRSRH',tabname=>'HISTORICO_CARGOS_LOTACAO',estimate_percent=>25,cascade=>true);      
exec dbms_stats.gather_table_stats (ownname=>'IFRSRH',tabname=>'HISTORICO_EMPREGADOS_BENEF',estimate_percent=>25,cascade=>true);    
exec dbms_stats.gather_table_stats (ownname=>'IFRSRH',tabname=>'HISTORICO_NIVEIS_SALARIAIS',estimate_percent=>25,cascade=>true);    
exec dbms_stats.gather_table_stats (ownname=>'IFRSRH',tabname=>'HIST_PERICUL_INSALUB',estimate_percent=>25,cascade=>true);          
exec dbms_stats.gather_table_stats (ownname=>'IFRSRH',tabname=>'HONORARIOS_MEDICOS',estimate_percent=>25,cascade=>true);            
exec dbms_stats.gather_table_stats (ownname=>'IFRSRH',tabname=>'HORARIOS_FREQUENCIA',estimate_percent=>25,cascade=>true);           
exec dbms_stats.gather_table_stats (ownname=>'IFRSRH',tabname=>'HST_DEPENDENCIA_EMPREGADO',estimate_percent=>25,cascade=>true);     
exec dbms_stats.gather_table_stats (ownname=>'IFRSRH',tabname=>'INDICE_ABSENTEISMO',estimate_percent=>25,cascade=>true);            
exec dbms_stats.gather_table_stats (ownname=>'IFRSRH',tabname=>'LPM',estimate_percent=>25,cascade=>true);                           
exec dbms_stats.gather_table_stats (ownname=>'IFRSRH',tabname=>'MOVIMENTACAO',estimate_percent=>25,cascade=>true);                  
exec dbms_stats.gather_table_stats (ownname=>'IFRSRH',tabname=>'MOV_SOMA_MENSAL',estimate_percent=>25,cascade=>true);               
exec dbms_stats.gather_table_stats (ownname=>'IFRSRH',tabname=>'OCORRENCIAS_EMPREGADOS',estimate_percent=>25,cascade=>true);        
exec dbms_stats.gather_table_stats (ownname=>'IFRSRH',tabname=>'OCORRENCIAS_EMPREGADOS_TEMP',estimate_percent=>25,cascade=>true);   
exec dbms_stats.gather_table_stats (ownname=>'IFRSRH',tabname=>'OCORRENCIAS_FREQUENCIA_EMP',estimate_percent=>25,cascade=>true);    
exec dbms_stats.gather_table_stats (ownname=>'IFRSRH',tabname=>'OCORRENCIAS_PIS_PASEP_EMP',estimate_percent=>25,cascade=>true);     
exec dbms_stats.gather_table_stats (ownname=>'IFRSRH',tabname=>'OCORRENCIAS_RECEB_TICKETS',estimate_percent=>25,cascade=>true);     
exec dbms_stats.gather_table_stats (ownname=>'IFRSRH',tabname=>'OCORRENCIAS_RECEB_VALES',estimate_percent=>25,cascade=>true);       
exec dbms_stats.gather_table_stats (ownname=>'IFRSRH',tabname=>'PEDIDOS_COBRANCAS',estimate_percent=>25,cascade=>true);             
exec dbms_stats.gather_table_stats (ownname=>'IFRSRH',tabname=>'PEDIDOS_TICKETS',estimate_percent=>25,cascade=>true);               
exec dbms_stats.gather_table_stats (ownname=>'IFRSRH',tabname=>'PENSIONISTAS',estimate_percent=>25,cascade=>true);                  
exec dbms_stats.gather_table_stats (ownname=>'IFRSRH',tabname=>'PESSOAS_VINCULADAS',estimate_percent=>25,cascade=>true);            
exec dbms_stats.gather_table_stats (ownname=>'IFRSRH',tabname=>'PESSOAS_VINCULADAS_BENEF',estimate_percent=>25,cascade=>true);      
exec dbms_stats.gather_table_stats (ownname=>'IFRSRH',tabname=>'PREMIO_SEGURO',estimate_percent=>25,cascade=>true);                 
exec dbms_stats.gather_table_stats (ownname=>'IFRSRH',tabname=>'PROCEDIMENTOS_ODONTOLOGICOS',estimate_percent=>25,cascade=>true);   
exec dbms_stats.gather_table_stats (ownname=>'IFRSRH',tabname=>'PROGRAMACOES_FERIAS',estimate_percent=>25,cascade=>true);           
exec dbms_stats.gather_table_stats (ownname=>'IFRSRH',tabname=>'PROVISOES_EMPREGADOS',estimate_percent=>25,cascade=>true);          
exec dbms_stats.gather_table_stats (ownname=>'IFRSRH',tabname=>'QUADROS_LOTACAO_PESSOAL',estimate_percent=>25,cascade=>true);       
exec dbms_stats.gather_table_stats (ownname=>'IFRSRH',tabname=>'QUADRO_CARGOS_DEPENDENCIAS',estimate_percent=>25,cascade=>true);    
exec dbms_stats.gather_table_stats (ownname=>'IFRSRH',tabname=>'QUADRO_FUNCOES',estimate_percent=>25,cascade=>true);                
exec dbms_stats.gather_table_stats (ownname=>'IFRSRH',tabname=>'REEMBOLSOS',estimate_percent=>25,cascade=>true);                    
exec dbms_stats.gather_table_stats (ownname=>'IFRSRH',tabname=>'RESUMO_ENCARGOS_INFRAPREV',estimate_percent=>25,cascade=>true);     
exec dbms_stats.gather_table_stats (ownname=>'IFRSRH',tabname=>'RESUMO_ENCARGOS_INSS',estimate_percent=>25,cascade=>true);          
exec dbms_stats.gather_table_stats (ownname=>'IFRSRH',tabname=>'RESUMO_ENCARGOS_INSS_AUTONOMO',estimate_percent=>25,cascade=>true); 
exec dbms_stats.gather_table_stats (ownname=>'IFRSRH',tabname=>'RESUMO_ENCARGOS_IRRF',estimate_percent=>25,cascade=>true);          
exec dbms_stats.gather_table_stats (ownname=>'IFRSRH',tabname=>'RESUMO_ENCARGOS_SAL_EDUCACAO',estimate_percent=>25,cascade=>true);  
exec dbms_stats.gather_table_stats (ownname=>'IFRSRH',tabname=>'SIAD_ATRIBUICAO_CONCEITOS',estimate_percent=>25,cascade=>true);     
exec dbms_stats.gather_table_stats (ownname=>'IFRSRH',tabname=>'SIAD_AVALIACAO',estimate_percent=>25,cascade=>true);                
exec dbms_stats.gather_table_stats (ownname=>'IFRSRH',tabname=>'SIAD_AVALIACAO_FINAL',estimate_percent=>25,cascade=>true);          
exec dbms_stats.gather_table_stats (ownname=>'IFRSRH',tabname=>'SIAD_AVALIACAO_TREINAMENTO',estimate_percent=>25,cascade=>true);    
exec dbms_stats.gather_table_stats (ownname=>'IFRSRH',tabname=>'SPF_EMPREGADO_IND_INSUFICIENCI',estimate_percent=>25,cascade=>true);
exec dbms_stats.gather_table_stats (ownname=>'IFRSRH',tabname=>'SPF_EMPREGADO_IND_PROMOCAO',estimate_percent=>25,cascade=>true);    
exec dbms_stats.gather_table_stats (ownname=>'IFRSRH',tabname=>'SPF_EMPREGADO_NAO_PROMOVIDO',estimate_percent=>25,cascade=>true);   
exec dbms_stats.gather_table_stats (ownname=>'IFRSRH',tabname=>'SPF_EMPREGADO_NAO_PROMOVIDO_2',estimate_percent=>25,cascade=>true); 
exec dbms_stats.gather_table_stats (ownname=>'IFRSRH',tabname=>'SPF_EMPREGADO_PROMOVIDO',estimate_percent=>25,cascade=>true);       
exec dbms_stats.gather_table_stats (ownname=>'IFRSRH',tabname=>'TAB_DESPESA_MEDICAMENTOS',estimate_percent=>25,cascade=>true);      
exec dbms_stats.gather_table_stats (ownname=>'IFRSRH',tabname=>'USUARIOS_PLANOS_SAUDE',estimate_percent=>25,cascade=>true);         
exec dbms_stats.gather_table_stats (ownname=>'IFRSRH',tabname=>'VALOR_INCENTIVO',estimate_percent=>25,cascade=>true);               
ALTER USER SYS TEMPORARY TABLESPACE SYSTEM;                                                                                         
SQL> spool off
