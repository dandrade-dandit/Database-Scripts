create or replace procedure atualiza_pericul_insalub
                   (par_mes            number,
		                  par_ano            number,
		                  par_versao         number,
                    par_dep            number,
                    par_mat            number) is

cursor c_mane is
	select  hpi_data_inicio, 
         hpi_data_termino,
         hpi_ind_pericul_insalub, 
         hpi_percentual
	from	   hist_pericul_insalub
	where	  hpi_emp_numero_matricula = par_mat
 and   ((hpi_data_termino is null and  to_number(to_char(hpi_data_inicio,'yyyymm')) <=
            to_number(to_char(par_ano)||lpad(to_char(par_mes),2,0))) or
           (hpi_data_termino is not null and
            to_number(to_char(hpi_data_termino,'yyyymm')) >=
            to_number(to_char(par_ano)||lpad(to_char(par_mes),2,0)) and
            to_number(to_char(hpi_data_inicio,'yyyymm')) <=
            to_number(to_char(par_ano)||lpad(to_char(par_mes),2,0))))
 and     hpi_data_autorizacao_sede is not null
 and     hpi_cod_resp_autorizacao_sede is not null
 and     hpi_data_retirada_movim is null
	order   by hpi_data_inicio;

r_mane                  c_mane%rowtype;
v_sequencial            movimentacao.mov_sequencial%TYPE;
v_rub                   movimentacao.mov_rub_codigo%TYPE;
v_seq_pagamento		    rubricas.rub_seq_pagamento%TYPE;
v_rub_seq_pagto 		rubricas.rub_seq_pagamento%TYPE;
v_data_ini              date;
v_data_fim              date;
v_dias_mes              number;
v_dias                  number;
-----------------------------------------------------------------------------------
--                 Função para recuperar a sequência de pagamento das rubricas   --
-----------------------------------------------------------------------------------
function busca_rub_seq_pagto (p_rub number)
         return number is
Begin
   Begin
      select distinct rub.rub_seq_pagamento
      into   v_rub_seq_pagto
      from   rubricas rub
      where  rub.rub_codigo = p_rub;
   Exception
      when no_data_found then
         v_rub_seq_pagto := 999;
   End;
   return(v_rub_seq_pagto);
End;
--**********************************************************************--
--**                INÍCIO DA PROCEDURE PRINCIPAL                     **--
--**********************************************************************--
Begin

  delete movimentacao
  where  mov_ano_referencia       = par_ano
  and    mov_mes_referencia       = par_mes
  and    mov_versao_pagamento     = par_versao
  and    mov_emp_dep_codigo_pagto = par_dep
  and    mov_emp_numero_matricula = par_mat
  and    mov_rub_codigo in (1085, 1090);

  v_data_ini := to_date('01'||lpad(to_char(par_mes),2,'0')||to_char(par_ano),'ddmmyyyy');
  v_data_fim := last_day(v_data_ini);
  v_dias_mes := to_number(to_char(last_day(v_data_ini),'dd'));

  open c_mane;
  loop
     fetch c_mane into r_mane;
     exit when c_mane%notfound;

     if r_mane.hpi_ind_pericul_insalub = 'P' then
        v_rub := 1085;
     elsif r_mane.hpi_ind_pericul_insalub = 'I' then
        v_rub := 1090;
     end if;

     if r_mane.hpi_data_termino is null then
        if r_mane.hpi_data_inicio <= v_data_ini then
           v_dias := (v_data_fim - v_data_ini) + 1;
        else
           v_dias := (v_data_fim - r_mane.hpi_data_inicio) + 1;
        end if;
     else
        if r_mane.hpi_data_termino <= v_data_fim then
           if r_mane.hpi_data_inicio <= v_data_ini then
              v_dias := (r_mane.hpi_data_termino - v_data_ini) + 1;
           else
              v_dias := (r_mane.hpi_data_termino - r_mane.hpi_data_inicio) + 1;
           end if;
        else
           if r_mane.hpi_data_inicio <= v_data_ini then
              v_dias := (v_data_fim - v_data_ini) + 1;
           else
              v_dias := (v_data_fim - r_mane.hpi_data_inicio) + 1;
           end if;
        end if;
     end if;

     if v_dias = v_dias_mes then
        v_dias := 30;
     end if;

     v_sequencial    := busca_mov_seq(par_mes,par_ano,par_versao,par_mat,v_rub,'N');
     v_seq_pagamento := busca_rub_seq_pagto(v_rub);

     insert into movimentacao
              (mov_ano_referencia,	mov_mes_referencia,	mov_versao_pagamento,
  			   mov_emp_numero_matricula, mov_rub_codigo, mov_sequencial,
 			   mov_for_codigo, mov_parcela, mov_parcela_atual, mov_tipo_parametro,
		 	   mov_parametro, mov_valor, mov_tip_rubrica, mov_mes_ref_diferenca,
			   mov_ano_ref_diferenca, mov_pen_codigo, mov_ind_calculo,
    		   mov_pem_ben_sigla, mov_rub_seq_pagamento, mov_ind_arsaprev,
		  	   mov_fun_codigo, mov_tipo_funcao, mov_pkt_codigo_pedido,
			   mov_valor_integral, mov_ind_exclusivo, mov_dias_proporcionalidade,
			   mov_emp_dep_codigo_pagto)
       values (par_ano, par_mes, par_versao, par_mat,
               v_rub, v_sequencial, null, 999, 999, 'P', r_mane.hpi_percentual,
               null, 'N', null, null, null, 'N', null, v_seq_pagamento, null,
     	       null, null, null, null, 'N', v_dias, par_dep);
  end loop;
End;

