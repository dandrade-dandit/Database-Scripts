CREATE OR REPLACE TRIGGER ifrsrh.documentos_cobranca
 AFTER
  DELETE OR UPDATE
 ON ifrsrh.documentos_cobranca
REFERENCING NEW AS NEW OLD AS OLD
 FOR EACH ROW
DECLARE
  v_operacao         VARCHAR2(1);
BEGIN
  --
  -- Pego o tipo de operação
  IF UPDATING THEN
    v_operacao := 'U';
  ELSIF DELETING THEN
    v_operacao := 'D';
  END IF;
  --
  IF
				 (:old.doc_data <> :new.doc_data
				 or :old.doc_data_pagamento <> :new.doc_data_pagamento
				 or :old.doc_valor <> :new.doc_valor
				 or :old.doc_tipo <> :new.doc_tipo
				 or :old.doc_deducao <> :new.doc_deducao
				 or :old.doc_dep_codigo <> :new.doc_dep_codigo
				 or :old.doc_tot_faturamento <> :new.doc_tot_faturamento
				 or :old.doc_tot_glosa <> :new.doc_tot_glosa
				 or :old.doc_tot_irrf <> :new.doc_tot_irrf
				 or :old.doc_tot_iss <> :new.doc_tot_iss
				 or :old.doc_valor_liquido <> :new.doc_valor_liquido
				 or :old.doc_valor_participacao <> :new.doc_valor_participacao
				 or :old.doc_mes_pagamento <> :new.doc_mes_pagamento
				 or :old.doc_ano_pagamento <> :new.doc_ano_pagamento
				 or :old.doc_valor_diferenca <> :new.doc_valor_diferenca
				 or :old.doc_valor_autorizado <> :new.doc_valor_autorizado
				 or :old.doc_mes_vale <> :new.doc_mes_vale
				 or :old.doc_ano_vale <> :new.doc_ano_vale
				 or :old.doc_valor_taxa <> :new.doc_valor_taxa
				 or :old.doc_processo_encerrado <> :new.doc_processo_encerrado
				 or :old.doc_guias_emp <> :new.doc_guias_emp
				 or :old.doc_capital_seguro <> :new.doc_capital_seguro
				 or :old.doc_nr_doc_fiscal <> :new.doc_nr_doc_fiscal
				 or :old.doc_pvi_emp_numero_matricula <> :new.doc_pvi_emp_numero_matricula
				 or :old.doc_dep_resp_incl <> :new.doc_dep_resp_incl
				 or :old.doc_tipo_pedido <> :new.doc_tipo_pedido
				 or :old.doc_ind_imposto <> :new.doc_ind_imposto
				 or :old.doc_numero_imp_acumul <> :new.doc_numero_imp_acumul
				 or :old.doc_mov_participacao <> :new.doc_mov_participacao
				 or :old.doc_valor_inss <> :new.doc_valor_inss
				 or :old.doc_vl_base_inss <> :new.doc_vl_base_inss
				 or :old.doc_qtd_depend_irrf <> :new.doc_qtd_depend_irrf
				 or :old.doc_valor_desc_irrf <> :new.doc_valor_desc_irrf
				 or :old.doc_valor_ajuste <> :new.doc_valor_ajuste
				 or :old.doc_data_criacao <> :new.doc_data_criacao
				 or :old.doc_data_geracao_participacao <> :new.doc_data_geracao_participacao
				 or :old.doc_interface_ps_mes <> :new.doc_interface_ps_mes
				 or :old.doc_interface_ps_ano <> :new.doc_interface_ps_ano
				 or :old.doc_interface_ps_seq <> :new.doc_interface_ps_seq
				 or :old.doc_inss_autonomo <> :new.doc_inss_autonomo
				 or :old.doc_data_inss_autonomo <> :new.doc_data_inss_autonomo
				 or :old.data_processo_encerrado <> :new.data_processo_encerrado
				 or :old.doc_valor_irmp153 <> :new.doc_valor_irmp153
				 or :old.doc_valor_csll <> :new.doc_valor_csll
				 or :old.doc_valor_pispasep <> :new.doc_valor_pispasep
				 or :old.doc_valor_cofins <> :new.doc_valor_cofins
				 or :old.doc_ri_cod_receita <> :new.doc_ri_cod_receita
				 or :old.doc_ri_dat_inicio <> :new.doc_ri_dat_inicio
				 or :old.doc_tipo_servico <> :new.doc_tipo_servico
				 or :old.doc_tdc_seq_cobranca <> :new.doc_tdc_seq_cobranca
				 or :old.doc_val_tax_adm <> :new.doc_val_tax_adm
				 or :old.doc_val_tax_iss <> :new.doc_val_tax_iss
				 or :old.doc_tot_glosado_excedente  <> :new.doc_tot_glosado_excedente) and
				 (:old.data_processo_encerrado is not null or :new.data_processo_encerrado is not null)
	THEN
    INSERT INTO ifrsrh.log_documentos_cobranca
  				(doc_numero
				,doc_cbe_ben_sigla
				,doc_cbe_cre_sequencial
				,doc_data
				,doc_data_pagamento
				,doc_valor
				,doc_tipo
				,doc_deducao
				,doc_especificacao
				,doc_modalidade
				,doc_emb_emp_numero_matricula
				,doc_pvi_sequencial
				,doc_cct_codigo
				,doc_dep_codigo
				,doc_emb_ben_sigla
				,doc_tot_faturamento
				,doc_tot_glosa
				,doc_tot_irrf
				,doc_tot_iss
				,doc_especificacao_deducao
				,doc_valor_liquido
				,doc_valor_participacao
				,doc_mes_pagamento
				,doc_ano_pagamento
				,doc_valor_diferenca
				,doc_valor_autorizado
				,doc_especificacao_diferenca
				,doc_mes_vale
				,doc_ano_vale
				,doc_valor_taxa
				,doc_processo_encerrado
				,doc_guias_emp
				,doc_capital_seguro
				,doc_nr_doc_fiscal
				,doc_pvi_emp_numero_matricula
				,doc_dep_resp_incl
				,doc_tipo_pedido
				,doc_ind_imposto
				,doc_numero_imp_acumul
				,doc_mov_participacao
				,doc_valor_inss
				,doc_vl_base_inss
				,doc_qtd_depend_irrf
				,doc_valor_desc_irrf
				,doc_valor_ajuste
				,doc_data_criacao
				,doc_data_geracao_participacao
				,doc_interface_ps_mes
				,doc_interface_ps_ano
				,doc_interface_ps_seq
				,doc_inss_autonomo
				,doc_data_inss_autonomo
				,data_processo_encerrado
				,doc_valor_irmp153
				,doc_valor_csll
				,doc_valor_pispasep
				,doc_valor_cofins
				,doc_ri_cod_receita
				,doc_ri_dat_inicio
				,doc_tipo_servico
				,doc_tdc_seq_cobranca
				,doc_val_tax_adm
				,doc_val_tax_iss
				,doc_tot_glosado_excedente
				,cod_usuario
				,dat_operacao
				,tip_operacao)
              VALUES
              	(:old.doc_numero
				,:old.doc_cbe_ben_sigla
				,:old.doc_cbe_cre_sequencial
				,:old.doc_data
				,:old.doc_data_pagamento
				,:old.doc_valor
				,:old.doc_tipo
				,:old.doc_deducao
				,:old.doc_especificacao
				,:old.doc_modalidade
				,:old.doc_emb_emp_numero_matricula
				,:old.doc_pvi_sequencial
				,:old.doc_cct_codigo
				,:old.doc_dep_codigo
				,:old.doc_emb_ben_sigla
				,:old.doc_tot_faturamento
				,:old.doc_tot_glosa
				,:old.doc_tot_irrf
				,:old.doc_tot_iss
				,:old.doc_especificacao_deducao
				,:old.doc_valor_liquido
				,:old.doc_valor_participacao
				,:old.doc_mes_pagamento
				,:old.doc_ano_pagamento
				,:old.doc_valor_diferenca
				,:old.doc_valor_autorizado
				,:old.doc_especificacao_diferenca
				,:old.doc_mes_vale
				,:old.doc_ano_vale
				,:old.doc_valor_taxa
				,:old.doc_processo_encerrado
				,:old.doc_guias_emp
				,:old.doc_capital_seguro
				,:old.doc_nr_doc_fiscal
				,:old.doc_pvi_emp_numero_matricula
				,:old.doc_dep_resp_incl
				,:old.doc_tipo_pedido
				,:old.doc_ind_imposto
				,:old.doc_numero_imp_acumul
				,:old.doc_mov_participacao
				,:old.doc_valor_inss
				,:old.doc_vl_base_inss
				,:old.doc_qtd_depend_irrf
				,:old.doc_valor_desc_irrf
				,:old.doc_valor_ajuste
				,:old.doc_data_criacao
				,:old.doc_data_geracao_participacao
				,:old.doc_interface_ps_mes
				,:old.doc_interface_ps_ano
				,:old.doc_interface_ps_seq
				,:old.doc_inss_autonomo
				,:old.doc_data_inss_autonomo
				,:old.data_processo_encerrado
				,:old.doc_valor_irmp153
				,:old.doc_valor_csll
				,:old.doc_valor_pispasep
				,:old.doc_valor_cofins
				,:old.doc_ri_cod_receita
				,:old.doc_ri_dat_inicio
				,:old.doc_tipo_servico
				,:old.doc_tdc_seq_cobranca
				,:old.doc_val_tax_adm
				,:old.doc_val_tax_iss
				,:old.doc_tot_glosado_excedente
                ,SYSDATE
                ,v_operacao
                ,USER);
END IF;
END;
/
