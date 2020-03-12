create or replace procedure ifrsrh_folha.copia_movimentacao      (p_ano_origem     in number,
                                   p_mes_origem     in number,
                                   p_versao_origem  in number,
                                   p_ano_destino    in number   default null,
                                   p_mes_destino    in number   default null,
                                   p_versao_destino in number   default null,
                                   p_mov_ind_13     in varchar2 default null,
                                   p_dep_codigo     in number,
                                   p_matricula      in number) is
cursor c_mov_mat is
  select mov.mov_ano_referencia, mov.mov_mes_referencia, mov.mov_versao_pagamento,
         mov.mov_emp_numero_matricula, mov.mov_rub_codigo, mov.mov_sequencial,
         mov.mov_for_codigo, mov.mov_parcela, mov.mov_parcela_atual,
         mov.mov_tipo_parametro, mov.mov_parametro, mov.mov_valor,
         mov.mov_tip_rubrica, mov.mov_mes_ref_diferenca, mov.mov_ano_ref_diferenca,
         mov.mov_pen_codigo, mov.mov_ind_calculo, mov.mov_pem_ben_sigla,
         mov.mov_rub_seq_pagamento, mov.mov_ind_arsaprev, mov.mov_fun_codigo,
         mov.mov_tipo_funcao, mov.mov_pkt_codigo_pedido, mov.mov_valor_integral,
         mov.mov_ind_exclusivo, mov.mov_dias_proporcionalidade,
         mov.mov_nsa_codigo_nivel, mov.mov_nsa_codigo_padrao,
         mov.mov_nsa_indicador_nivel_escola, mov.mov_ind_lancamento_liq_negat,
         mov.mov_flg_frequencia, mov.mov_data_calculo,
         mov.mov_emp_dep_codigo_pagto,
         mov.mov_oem_emp_numero_matricula, mov.mov_oem_ofu_codigo, mov.mov_oem_data_inicio, mov.mov_ind_13, emp.emp_status,
         emp.emp_qfu_fun_codigo, emp.emp_tipo_remuneracao_funcao
  from   ifrsrh_folha.movimentacao mov,
         ifrsrh_folha.cadastros emp
  where  mov.mov_ano_referencia = p_ano_origem
  and    mov.mov_mes_referencia = p_mes_origem
  and    mov.mov_versao_pagamento = p_versao_origem
  and    mov.mov_emp_dep_codigo_pagto = p_dep_codigo
  and    mov.mov_emp_numero_matricula = p_matricula
  and    mov.mov_emp_numero_matricula = emp.emp_numero_matricula
  and    not exists
        (select 'x'
         from   ifrsrh_folha.movimentacao mov1
         where  mov1.mov_ano_referencia = p_ano_destino
         and    mov1.mov_mes_referencia = p_mes_destino
         and    mov1.mov_versao_pagamento = p_versao_destino
         and    mov1.mov_emp_dep_codigo_pagto = p_dep_codigo
         and    mov1.mov_emp_numero_matricula = p_matricula
         and    mov1.mov_rub_codigo = mov.mov_rub_codigo
         and    mov1.mov_tip_rubrica = mov.mov_tip_rubrica);

cursor c_mov_dep is
  select mov.mov_ano_referencia, mov.mov_mes_referencia, mov.mov_versao_pagamento,
         mov.mov_emp_numero_matricula, mov.mov_rub_codigo, mov.mov_sequencial,
         mov.mov_for_codigo, mov.mov_parcela, mov.mov_parcela_atual,
         mov.mov_tipo_parametro, mov.mov_parametro, mov.mov_valor,
         mov.mov_tip_rubrica, mov.mov_mes_ref_diferenca, mov.mov_ano_ref_diferenca,
         mov.mov_pen_codigo, mov.mov_ind_calculo, mov.mov_pem_ben_sigla,
         mov.mov_rub_seq_pagamento, mov.mov_ind_arsaprev, mov.mov_fun_codigo,
         mov.mov_tipo_funcao, mov.mov_pkt_codigo_pedido, mov.mov_valor_integral,
         mov.mov_ind_exclusivo, mov.mov_dias_proporcionalidade,
         mov.mov_nsa_codigo_nivel, mov.mov_nsa_codigo_padrao,
         mov.mov_nsa_indicador_nivel_escola, mov.mov_ind_lancamento_liq_negat,
         mov.mov_flg_frequencia, mov.mov_data_calculo,
         mov.mov_emp_dep_codigo_pagto,
         mov.mov_oem_emp_numero_matricula, mov.mov_oem_ofu_codigo, mov.mov_oem_data_inicio, mov.mov_ind_13, emp.emp_status,
         emp.emp_qfu_fun_codigo, emp.emp_tipo_remuneracao_funcao
  from   ifrsrh_folha.movimentacao mov,
         ifrsrh_folha.cadastros emp
  where  mov.mov_ano_referencia = p_ano_origem
  and    mov.mov_mes_referencia = p_mes_origem
  and    mov.mov_versao_pagamento = p_versao_origem
  and    mov.mov_emp_dep_codigo_pagto = p_dep_codigo
  and    mov.mov_emp_numero_matricula = emp.emp_numero_matricula
  and    not exists
        (select 'x'
         from   ifrsrh_folha.movimentacao mov1
         where  mov1.mov_ano_referencia = p_ano_destino
         and    mov1.mov_mes_referencia = p_mes_destino
         and    mov1.mov_versao_pagamento = p_versao_destino
         and    mov1.mov_emp_dep_codigo_pagto = p_dep_codigo
         and    mov1.mov_emp_numero_matricula = mov.mov_emp_numero_matricula
         and    mov1.mov_rub_codigo = mov.mov_rub_codigo
         and    mov1.mov_tip_rubrica = mov.mov_tip_rubrica);

r_mov           c_mov_dep%ROWTYPE;

v_dias_proporcionalidade number(3);

--------------------------------------------------------------------------
--              INICIO DA PROCEDURE COPIA MOVIMENTACAO                  --
--------------------------------------------------------------------------
Begin
   if p_matricula is null then
      open c_mov_dep;
      loop
         fetch c_mov_dep into r_mov;
         exit when c_mov_dep%notfound;
         if p_mes_origem = 12 and p_mes_destino = 13 then
             if r_mov.emp_status = 0
             and r_mov.mov_dias_proporcionalidade = 0 then
                v_dias_proporcionalidade := 30;
             else
             	  v_dias_proporcionalidade := r_mov.mov_dias_proporcionalidade;
             end if;
             if r_mov.emp_qfu_fun_codigo is not null         and
                r_mov.emp_tipo_remuneracao_funcao = 'RG' and
                r_mov.mov_rub_codigo = 1000                  then
             	  v_dias_proporcionalidade := r_mov.mov_dias_proporcionalidade;
             end if;
         else
            v_dias_proporcionalidade := r_mov.mov_dias_proporcionalidade;
         end if;
         if ((p_mes_origem  <>  12 or p_mes_destino <> 13) or (p_mes_origem = 12 and p_mes_destino = 13 and r_mov.mov_rub_codigo not in
            (1390,1340,1345,5090,5098,5085,5095,5060,5510,5525,5105,1925,5092,5350,5902) )) then
            Begin
               insert into ifrsrh_folha.movimentacao
                  (mov_ano_referencia, mov_mes_referencia, mov_versao_pagamento,
                   mov_emp_numero_matricula, mov_rub_codigo, mov_sequencial,
                   mov_for_codigo, mov_parcela, mov_parcela_atual, mov_tipo_parametro,
                   mov_parametro, mov_valor, mov_tip_rubrica, mov_mes_ref_diferenca,
                   mov_ano_ref_diferenca, mov_pen_codigo, mov_ind_calculo, mov_pem_ben_sigla,
                   mov_rub_seq_pagamento, mov_ind_arsaprev, mov_fun_codigo, mov_tipo_funcao,
                   mov_pkt_codigo_pedido, mov_valor_integral, mov_ind_exclusivo,
                   mov_dias_proporcionalidade, mov_nsa_codigo_nivel,
                   mov_nsa_codigo_padrao, mov_nsa_indicador_nivel_escola,
                   mov_ind_lancamento_liq_negat, mov_flg_frequencia,
                   mov_ind_13, mov_data_calculo, mov_emp_dep_codigo_pagto,
                   mov_oem_emp_numero_matricula, mov_oem_ofu_codigo, mov_oem_data_inicio)
                values
                  (p_ano_destino, p_mes_destino, p_versao_destino,
                   r_mov.mov_emp_numero_matricula, r_mov.mov_rub_codigo,
                   r_mov.mov_sequencial, r_mov.mov_for_codigo,
                   r_mov.mov_parcela, r_mov.mov_parcela_atual, r_mov.mov_tipo_parametro,
                   r_mov.mov_parametro, r_mov.mov_valor, r_mov.mov_tip_rubrica,
                   r_mov.mov_mes_ref_diferenca, r_mov.mov_ano_ref_diferenca,
                   r_mov.mov_pen_codigo, r_mov.mov_ind_calculo, r_mov.mov_pem_ben_sigla,
                   r_mov.mov_rub_seq_pagamento, r_mov.mov_ind_arsaprev, r_mov.mov_fun_codigo,
                   r_mov.mov_tipo_funcao, r_mov.mov_pkt_codigo_pedido,
                   r_mov.mov_valor_integral, r_mov.mov_ind_exclusivo,
                   r_mov.mov_dias_proporcionalidade,
                   r_mov.mov_nsa_codigo_nivel, r_mov.mov_nsa_codigo_padrao,
                   r_mov.mov_nsa_indicador_nivel_escola, r_mov.mov_ind_lancamento_liq_negat,
                   r_mov.mov_flg_frequencia, NVL(p_mov_ind_13, r_mov.mov_ind_13), r_mov.mov_data_calculo,
                   r_mov.mov_emp_dep_codigo_pagto,
                   r_mov.mov_oem_emp_numero_matricula, r_mov.mov_oem_ofu_codigo, r_mov.mov_oem_data_inicio);
               exception
                  when others then
                   dbms_output.put_line('Mat: '||r_mov.mov_emp_numero_matricula||' rub: '||r_mov.mov_rub_codigo||' tip: '||r_mov.mov_tip_rubrica);
--null;
               end;
         end if;
         commit;
      end loop;
      close c_mov_dep;
   else
      open c_mov_mat;
      loop
         fetch c_mov_mat into r_mov;
         exit when c_mov_mat%notfound;
         if p_mes_origem = 12 and p_mes_destino = 13 then
             if r_mov.emp_status = 0
             and r_mov.mov_dias_proporcionalidade = 0 then
                v_dias_proporcionalidade := 30;
             else
             	  v_dias_proporcionalidade := r_mov.mov_dias_proporcionalidade;
             end if;
             if r_mov.emp_qfu_fun_codigo is not null         and
                r_mov.emp_tipo_remuneracao_funcao = 'RG' and
                r_mov.mov_rub_codigo = 1000                  then
             	  v_dias_proporcionalidade := r_mov.mov_dias_proporcionalidade;
             end if;
         else
            v_dias_proporcionalidade := r_mov.mov_dias_proporcionalidade;
         end if;
         if ((p_mes_origem  <>  12 or p_mes_destino <> 13) or (p_mes_origem = 12 and p_mes_destino = 13 and r_mov.mov_rub_codigo not in
            (1390,1340,1345,5090,5098,5085,5095,5060,5510,5525,5105,1925,5092,5350,5902) )) then
            Begin
             insert into ifrsrh_folha.movimentacao
                  (mov_ano_referencia, mov_mes_referencia, mov_versao_pagamento,
                   mov_emp_numero_matricula, mov_rub_codigo, mov_sequencial,
                   mov_for_codigo, mov_parcela, mov_parcela_atual, mov_tipo_parametro,
                   mov_parametro, mov_valor, mov_tip_rubrica, mov_mes_ref_diferenca,
                   mov_ano_ref_diferenca, mov_pen_codigo, mov_ind_calculo, mov_pem_ben_sigla,
                   mov_rub_seq_pagamento, mov_ind_arsaprev, mov_fun_codigo, mov_tipo_funcao,
                   mov_pkt_codigo_pedido, mov_valor_integral, mov_ind_exclusivo,
                   mov_dias_proporcionalidade,
                   mov_nsa_codigo_nivel, mov_nsa_codigo_padrao,
                   mov_nsa_indicador_nivel_escola, mov_ind_lancamento_liq_negat,
                   mov_flg_frequencia, mov_ind_13, mov_data_calculo, mov_emp_dep_codigo_pagto,
                   mov_oem_emp_numero_matricula, mov_oem_ofu_codigo, mov_oem_data_inicio)
             values
                  (p_ano_destino, p_mes_destino, p_versao_destino,
                   r_mov.mov_emp_numero_matricula, r_mov.mov_rub_codigo,
                   r_mov.mov_sequencial, r_mov.mov_for_codigo,
                   r_mov.mov_parcela, r_mov.mov_parcela_atual, r_mov.mov_tipo_parametro,
                   r_mov.mov_parametro, r_mov.mov_valor, r_mov.mov_tip_rubrica,
                   r_mov.mov_mes_ref_diferenca, r_mov.mov_ano_ref_diferenca,
                   r_mov.mov_pen_codigo, r_mov.mov_ind_calculo, r_mov.mov_pem_ben_sigla,
                   r_mov.mov_rub_seq_pagamento, r_mov.mov_ind_arsaprev, r_mov.mov_fun_codigo,
                   r_mov.mov_tipo_funcao, r_mov.mov_pkt_codigo_pedido,
                   r_mov.mov_valor_integral, r_mov.mov_ind_exclusivo,
                   v_dias_proporcionalidade,
                   r_mov.mov_nsa_codigo_nivel, r_mov.mov_nsa_codigo_padrao,
                   r_mov.mov_nsa_indicador_nivel_escola, r_mov.mov_ind_lancamento_liq_negat,
                   r_mov.mov_flg_frequencia, NVL(p_mov_ind_13, r_mov.mov_ind_13), r_mov.mov_data_calculo,
                   r_mov.mov_emp_dep_codigo_pagto,
                   r_mov.mov_oem_emp_numero_matricula, r_mov.mov_oem_ofu_codigo, r_mov.mov_oem_data_inicio);
               exception
                  when others then
                    dbms_output.put_line('Mat: '||r_mov.mov_emp_numero_matricula||' rub: '||r_mov.mov_rub_codigo||' tip: '||r_mov.mov_tip_rubrica);
--null;
               end;
            end if;
            commit;
      end loop;
      close c_mov_mat;
   end if;
End;
