--insert into movimentacao
SELECT  
            TRIM(a.mov_ano_referencia) mov_ano_referencia
,           TRIM(a.mov_mes_referencia) mov_mes_referencia
,           TRIM(a.mov_versao_pagamento) mov_versao_pagamento
,           TRIM(a.mov_emp_numero_matricula) mov_emp_numero_matricula
,           TRIM(a.mov_rub_codigo) mov_rub_codigo
,           TRIM(a.mov_sequencial ) mov_sequencial
,           TRIM(a.mov_parcela) mov_parcela
,           TRIM(a.mov_parcela_atual) mov_parcela_atual
,           242 mov_rub_seq_pagamento
,           TRIM(a.mov_emp_dep_codigo_pagto) mov_emp_dep_codigo_pagto
,           TRIM(a.mov_tip_rubrica) mov_tip_rubrica
,           TRIM(a.mov_ind_calculo) mov_ind_calculo
,           TRIM(a.mov_ind_exclusivo) mov_ind_exclusivo
,           TRIM(a.mov_for_codigo) mov_for_codigo
,           ROUND(a.mov_parametro,2) mov_parametro
,           ROUND(a.mov_valor,2) mov_valor
,           TRIM(a.mov_ano_ref_diferenca  ) mov_ano_ref_diferenca
,           TRIM(a.mov_mes_ref_diferenca) mov_mes_ref_diferenca
,           TRIM(a.mov_pen_codigo) mov_pen_codigo
,           TRIM(a.mov_pkt_codigo_pedido) mov_pkt_codigo_pedido
,           ROUND(a.mov_valor_integral,2) mov_valor_integral
,           TRIM(a.mov_fun_codigo) mov_fun_codigo
,           TRIM(a.mov_dias_proporcionalidade) mov_dias_proporcionalidade
,           TRIM(a.mov_nsa_codigo_nivel) mov_nsa_codigo_nivel
,           TRIM(a.mov_oem_emp_numero_matricula) mov_oem_emp_numero_matricula
,           TRIM(a.mov_oem_ofu_codigo) mov_oem_ofu_codigo
,           TRIM(a.mov_oem_data_inicio) mov_oem_data_inicio
,           TRIM(a.mov_data_calculo) mov_data_calculo
,           TRIM(a.mov_pem_ben_sigla   ) mov_pem_ben_sigla
,           TRIM(a.mov_tipo_funcao) mov_tipo_funcao
,           TRIM(a.mov_tipo_parametro) mov_tipo_parametro
,           TRIM(a.mov_ind_13) mov_ind_13
,           TRIM(a.mov_ind_arsaprev) mov_ind_arsaprev
,           TRIM(a.mov_ind_lancamento_liq_negat) mov_ind_lancamento_liq_negat
,           TRIM(a.mov_nsa_codigo_padrao) mov_nsa_codigo_padrao
,           TRIM(a.mov_nsa_indicador_nivel_escola) mov_nsa_indicador_nivel_escola
,           TRIM(a.mov_flg_frequencia) mov_flg_frequencia
,           TRIM(a.cod_usuario) cod_usuario
,           TRIM(a.dta_operacao) dta_operacao
,           TRIM(a.mov_ctrl_txt_freq) mov_ctrl_txt_freq
,           TRIM(a.mov_versao_ref_diferenca) mov_versao_ref_diferenca
,           null mov_cod_infraero_saude
FROM        ifrsrh.mov_reembolso_122010 a
WHERE       mov_emp_numero_matricula NOT IN (1001090,1044849,1163153,4110066,4132052,4133931,4143045,4196997,6802115,9048201,9081991,9435979,9504008,9516391,9677457,9812976,9964357,9609087)

