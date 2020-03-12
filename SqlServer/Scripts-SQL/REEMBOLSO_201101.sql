--insert into movimentacao
SELECT distinct a.mov_ano_referencia, a.mov_mes_referencia,
       a.mov_versao_pagamento, a.mov_emp_numero_matricula,
       a.mov_rub_codigo, a.mov_sequencial, a.mov_parcela,
       a.mov_parcela_atual, trim(mov_rub_seq_pagamento) as mov_rub_seq_pagamento,
       a.mov_emp_dep_codigo_pagto, trim(a.mov_tip_rubrica) as mov_tip_rubrica, trim(a.mov_ind_calculo) as mov_ind_calculo,
        trim(a.mov_ind_exclusivo) as mov_ind_exclusivo, a.mov_for_codigo, round(a.mov_parametro,2) as mov_parametro,
       round(a.mov_valor,2) as mov_valor, a.mov_ano_ref_diferenca, a.mov_mes_ref_diferenca,
       a.mov_pen_codigo, a.mov_pkt_codigo_pedido, round(a.mov_valor_integral,2) as mov_valor_integral,
       a.mov_fun_codigo, a.mov_dias_proporcionalidade,
       a.mov_nsa_codigo_nivel, a.mov_oem_emp_numero_matricula,
       a.mov_oem_ofu_codigo, a.mov_oem_data_inicio, a.mov_data_calculo,
       a.mov_pem_ben_sigla, a.mov_tipo_funcao, trim(a.mov_tipo_parametro) as mov_tipo_parametro,
       trim(a.mov_ind_13) as mov_ind_13, a.mov_ind_arsaprev, a.mov_ind_lancamento_liq_negat,
       a.mov_nsa_codigo_padrao, a.mov_nsa_indicador_nivel_escola,
       a.mov_flg_frequencia, a.cod_usuario, a.dta_operacao,
       a.mov_ctrl_txt_freq, a.mov_versao_ref_diferenca,
       null as mov_cod_infraero_saude
  FROM ifrsrh.reembolso_201101 a
  where a.mov_emp_numero_matricula  in (
  1379317,
2101765,
4195215,
4748785,
5814405,
7804103,
7806392,
9202519,
9462290,
9498260,
9535288,
9545872,
9973062
  )
  
  
/*
SELECT distinct mov_ano_referencia,
    mov_mes_referencia,
    mov_versao_pagamento,
    mov_emp_numero_matricula,
    mov_rub_codigo,
    mov_tip_rubrica,
    mov_sequencial
  FROM ifrsrh.reembolso_201101 a
order by mov_ano_referencia,
    mov_mes_referencia,
    mov_versao_pagamento,
    mov_emp_numero_matricula,
    mov_rub_codigo,
    mov_tip_rubrica,
    mov_sequencial
    
    
select * 
from movimentacao
where ( mov_ano_referencia,
    mov_mes_referencia,
    mov_versao_pagamento,
    mov_emp_numero_matricula,
    mov_rub_codigo,
    mov_tip_rubrica,
    mov_sequencial)
  in (
  SELECT distinct mov_ano_referencia,
    mov_mes_referencia,
    mov_versao_pagamento,
    mov_emp_numero_matricula,
    mov_rub_codigo,
    mov_tip_rubrica,
    mov_sequencial
  FROM ifrsrh.reembolso_201101 a)

*/
