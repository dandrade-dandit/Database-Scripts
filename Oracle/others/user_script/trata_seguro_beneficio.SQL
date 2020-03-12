create or replace
Procedure trata_seguro_beneficio (par_mes         number,
  		                          par_ano         number,
		                          par_versao      number,
		                          par_dep         number,
		                          par_matricula   number) is

   cursor c_mov is
     select distinct(mov_emp_numero_matricula) mov_emp_numero_matricula,
            mov_emp_dep_codigo_pagto
     from   movimentacao
     where  mov_ano_referencia       = par_ano
     and    mov_mes_referencia       = par_mes
     and    mov_versao_pagamento     = par_versao
     and   (mov_emp_dep_codigo_pagto = par_dep       or par_dep       is null)
     and   (mov_emp_numero_matricula = par_matricula or par_matricula is null)
     order by mov_emp_numero_matricula;

   r_mov              c_mov%rowtype;
   v_existe_emp_ben   number;
   v_existe_rub       number;

begin
  dbms_output.enable(10000000);
  open c_mov;
  loop
     fetch c_mov into r_mov;
     exit when c_mov%notfound;

--   Tratamento para a rubrica 5615.

     begin
        select count(*)
        into   v_existe_emp_ben
        from   empregados_beneficios
        where  emb_emp_numero_matricula = r_mov.mov_emp_numero_matricula
        and    emb_ben_sigla            = 'SGC'
        and   (emb_data_exclusao is null or
     	        to_number(to_char(emb_data_exclusao,'yyyymm')) >=
                to_number(lpad(to_char(par_ano),4,'0')||
                          lpad(to_char(par_mes),2,'0')));
     end;

     begin
        select count(*)
        into   v_existe_rub
        from   movimentacao
        where  mov_ano_referencia       = par_ano
        and    mov_mes_referencia       = par_mes
        and    mov_versao_pagamento     = par_versao
        and    mov_emp_numero_matricula = r_mov.mov_emp_numero_matricula
        and    mov_rub_codigo           = 5615
        and    mov_tip_rubrica          = 'N';
     end;

     if v_existe_emp_ben = 0 and v_existe_rub > 0 then
        begin
           delete movimentacao
           where  mov_ano_referencia       = par_ano
           and    mov_mes_referencia       = par_mes
           and    mov_versao_pagamento     = par_versao
           and    mov_emp_numero_matricula = r_mov.mov_emp_numero_matricula
           and    mov_rub_codigo           = 5615
           and    mov_tip_rubrica          = 'N';
        end;
     elsif v_existe_emp_ben > 0 and v_existe_rub = 0 then
        insert into movimentacao (mov_ano_referencia, mov_mes_referencia,
                mov_versao_pagamento, mov_emp_numero_matricula, mov_rub_codigo,
                mov_sequencial, mov_parcela, mov_parcela_atual, mov_rub_seq_pagamento,
                mov_emp_dep_codigo_pagto, mov_tip_rubrica, mov_ind_calculo,
                mov_ind_exclusivo, mov_for_codigo, mov_parametro, mov_valor,
                mov_ano_ref_diferenca, mov_mes_ref_diferenca, mov_pen_codigo,
                mov_pkt_codigo_pedido, mov_valor_integral, mov_fun_codigo,
                mov_dias_proporcionalidade, mov_nsa_codigo_nivel,
                mov_oem_emp_numero_matricula, mov_oem_ofu_codigo, mov_oem_data_inicio,
                mov_data_calculo, mov_pem_ben_sigla, mov_tipo_funcao, mov_tipo_parametro,
                mov_ind_13, mov_ind_arsaprev, mov_ind_lancamento_liq_negat,
                mov_nsa_codigo_padrao, mov_nsa_indicador_nivel_escola, mov_flg_frequencia)
        values (par_ano,par_mes,par_versao,r_mov.mov_emp_numero_matricula,5615,1,999,999,
                225,r_mov.mov_emp_dep_codigo_pagto,'N','N','S',123,null,null,null,null,
                null,null,null,null,30,
                null,null,null,null,null,null,null,null,null,'N',null,null,null,'N');
     end if;


--   Tratamento para a rubrica 5207.

     begin
        select count(*)
        into   v_existe_emp_ben
        from   empregados_beneficios
        where  emb_emp_numero_matricula = r_mov.mov_emp_numero_matricula
        and    emb_ben_sigla            = 'SGE'
        and   (emb_data_exclusao is null or
     	        to_number(to_char(emb_data_exclusao,'yyyymm')) >=
                to_number(lpad(to_char(par_ano),4,'0')||
                          lpad(to_char(par_mes),2,'0')));
     end;

     begin
        select count(*)
        into   v_existe_rub
        from   movimentacao
        where  mov_ano_referencia       = par_ano
        and    mov_mes_referencia       = par_mes
        and    mov_versao_pagamento     = par_versao
        and    mov_emp_numero_matricula = r_mov.mov_emp_numero_matricula
        and    mov_rub_codigo           = 5207
        and    mov_tip_rubrica          = 'N';
     end;

     if v_existe_emp_ben = 0 and v_existe_rub > 0 then
        begin
           delete movimentacao
           where  mov_ano_referencia       = par_ano
           and    mov_mes_referencia       = par_mes
           and    mov_versao_pagamento     = par_versao
           and    mov_emp_numero_matricula = r_mov.mov_emp_numero_matricula
           and    mov_rub_codigo           = 5207
           and    mov_tip_rubrica          = 'N';
        end;
     elsif v_existe_emp_ben > 0 and v_existe_rub = 0 then
        insert into movimentacao (mov_ano_referencia, mov_mes_referencia,
                mov_versao_pagamento, mov_emp_numero_matricula, mov_rub_codigo,
                mov_sequencial, mov_parcela, mov_parcela_atual, mov_rub_seq_pagamento,
                mov_emp_dep_codigo_pagto, mov_tip_rubrica, mov_ind_calculo,
                mov_ind_exclusivo, mov_for_codigo, mov_parametro, mov_valor,
                mov_ano_ref_diferenca, mov_mes_ref_diferenca, mov_pen_codigo,
                mov_pkt_codigo_pedido, mov_valor_integral, mov_fun_codigo,
                mov_dias_proporcionalidade, mov_nsa_codigo_nivel,
                mov_oem_emp_numero_matricula, mov_oem_ofu_codigo, mov_oem_data_inicio,
                mov_data_calculo, mov_pem_ben_sigla, mov_tipo_funcao, mov_tipo_parametro,
                mov_ind_13, mov_ind_arsaprev, mov_ind_lancamento_liq_negat,
                mov_nsa_codigo_padrao, mov_nsa_indicador_nivel_escola, mov_flg_frequencia)
        values (par_ano,par_mes,par_versao,r_mov.mov_emp_numero_matricula,5207,1,999,999,
                207,r_mov.mov_emp_dep_codigo_pagto,'N','N','S',122,null,null,null,null,
                null,null,null,null,30,
                null,null,null,null,null,null,null,null,null,'N',null,null,null,'N');
     end if;

  end loop;
  close c_mov;

end;

