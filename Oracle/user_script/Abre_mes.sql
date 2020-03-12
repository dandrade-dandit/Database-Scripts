Create or Replace
Procedure abre_mes (par_mes            number,
                    par_ano            number,
                    par_versao         number,
                    par_dep_codigo     number,
                    par_list_13        varchar2, -- ' ' -> Sem 13o. Salário
					                                            -- 'A' -> Adiantamento 13o. Salário
                                                 -- 'F' -> 13o. Salário - Parcela Final
                    par_sindical       varchar2, -- 'S' ou 'N'
                    par_confederativa  varchar2, -- 'S' ou 'N'
                    par_num_mov in out number) is

-- Definição de váriaveis e cursores.

v_dia_mes               number;
v_mes_anterior      	cronogramas_pagamentos.crp_mes_pagamento%type;
v_ano_anterior     		cronogramas_pagamentos.crp_ano_pagamento%type;
v_mes_ant_rct       	cronogramas_pagamentos.crp_mes_pagamento%type;
v_ano_ant_rct     		cronogramas_pagamentos.crp_ano_pagamento%type;
v_rub_seq_pagamento		rubricas.rub_seq_pagamento%type;
v_rub_seq_pagto		    rubricas.rub_seq_pagamento%type;
v_sequencial            movimentacao.mov_sequencial%type;
v_ind_calculo           movimentacao.mov_ind_calculo%type;
v_parcela               movimentacao.mov_parcela%type;
v_parcela_ferias        movimentacao.mov_parcela%type;
p_matricula             movimentacao.mov_emp_numero_matricula%type;
v_fun_codigo            cadastros.emp_qfu_fun_codigo%type;
v_fun_codigo_subs       cadastros.emp_qfu_fun_codigo_substitui%type;
v_fun_codigo_acumula    cadastros.emp_qfu_fun_codigo_acumula%type;
v_tipo_remu_subs        cadastros.emp_tipo_remuner_funcao_subst%type;
v_tipo_remu_acumula     cadastros.emp_tipo_remuner_funcao_acumul%type;
v_cont         		    number;
v_rubrica               rubricas.rub_codigo%type;
v_valor_final           number(16,2);
v_parametro				varchar2(1);
v_mov_sequencial        movimentacao.mov_sequencial%type;
v_for_codigo            movimentacao.mov_for_codigo%type;
v_data_adm              date;
v_data_mes              date;
v_emp                   number(7);
v_data_inicio           date;

cursor adiantamento_13 is
       select emp.emp_numero_matricula, emp.emp_dep_codigo_pagto
       from   movimentacao mov, cadastros emp
       where  mov.mov_ano_referencia = par_ano
       and    mov.mov_rub_codigo = 1295
       and    mov.mov_versao_pagamento = par_versao
       and    mov.mov_mes_referencia < par_mes
       and    emp.emp_dep_codigo_pagto = par_dep_codigo
       and    emp.emp_status <> 2 -- Só lançar para empregados ativos e afastados
       and    mov.mov_emp_numero_matricula = emp.emp_numero_matricula
       group  by emp.emp_numero_matricula, emp.emp_dep_codigo_pagto
       having sum( to_number( decode(mov.mov_tip_rubrica, 'N', '+', 'D','+', 'E', '-') || to_char(mov.mov_valor))) = 0
       UNION
       select emp.emp_numero_matricula, emp.emp_dep_codigo_pagto
       from   cadastros emp
       where  emp.emp_status <> 2 -- Só lançar para empregados ativos e afastados
       and    emp.emp_dep_codigo_pagto = par_dep_codigo
       and    emp.emp_numero_matricula not in (select mov.mov_emp_numero_matricula
                                               from   movimentacao mov
                                               where  mov.mov_rub_codigo = 1295
                                               and    mov.mov_ano_referencia = par_ano
                                               and    mov.mov_mes_referencia < par_mes
                                               and    mov.mov_tip_rubrica IN ('N', 'D')
                                               and    mov.mov_versao_pagamento = 1
                                               and    mov.mov_emp_numero_matricula = emp.emp_numero_matricula)
       order by 1;

cursor final_13 is
       select emp.emp_numero_matricula, emp.emp_dep_codigo_pagto
       from   cadastros emp
       where  emp.emp_dep_codigo_pagto = par_dep_codigo
       and    emp.emp_status <> 2 -- lançar para empregados ativos e afastados
       order by 1;

cursor pen_ali_13 is
       select pen.pen_emp_numero_matricula,
              emp.emp_dep_codigo_pagto,
              pen.pen_codigo,
              pen_for_codigo_13,
              pen_mov_parametro_13
       from   cadastros emp, pensionistas pen
       where  emp.emp_dep_codigo_pagto = par_dep_codigo
       and    emp.emp_numero_matricula = pen.pen_emp_numero_matricula
       and    pen.pen_tipo_pensao      = 'A'
       and    pen.pen_ind_13_salario   = 'S'
       and    (pen.pen_data_fim_desc IS NULL OR pen.pen_data_fim_desc > sysdate)
       and    emp.emp_status <> 2 -- lançar para empregados ativos e afastados
       order by 1,2,3;

cursor pen_inde_13 is
       select pen.pen_emp_numero_matricula,
              emp.emp_dep_codigo_pagto,
              pen.pen_codigo,
              pen_for_codigo_13,
              pen_mov_parametro_13
       from   cadastros emp, pensionistas pen
       WHERE  emp.emp_dep_codigo_pagto = par_dep_codigo
       and    emp.emp_numero_matricula = pen.pen_emp_numero_matricula
       and    pen.pen_tipo_pensao      = 'I'
       and    pen.pen_ind_13_salario   = 'S'
       and    (pen.pen_data_fim_desc IS NULL OR pen.pen_data_fim_desc > sysdate)
       and    emp.emp_status <> 2 -- lançar para empregados ativos e afastados
       order by 1,2,3;

cursor cont_associativa is
   select emp.emp_numero_matricula, emp.emp_dep_codigo_pagto
   from   cadastros emp,
          movimentacao mov
   where  mov.mov_emp_numero_matricula = emp.emp_numero_matricula
   and    emp.emp_dep_codigo_pagto = par_dep_codigo
   and    emp.emp_status <> 2
   and    mov.mov_ano_referencia = par_ano
   and    mov.mov_mes_referencia = 12
   and    mov.mov_versao_pagamento = par_versao
   and   (    mov.mov_tip_rubrica = 'N'
          OR  mov.mov_tip_rubrica = 'D')
   and    mov.mov_parcela = 999
   and    mov.mov_rub_codigo = 5135;

    /*
    -- Comentado pois segundo o Alisson essa rubrica deve ser lançada para todos
    -- os empregados que a possuem no mês 12.
    -- Busca todas as ocorrências 238 (DESIGNAÇÃO DE DIRETOR NÃO EMPREGADO)
    -- dos empregados ativos da dependência que está sendo aberta com data
    -- de término nula ou >= do que o 1º dia do mês/ano que está sendo aberto
    select emp.emp_numero_matricula, emp.emp_dep_codigo_pagto
    from   cadastros emp, ocorrencias_empregados oem
    where  emp.emp_numero_matricula = oem.oem_emp_numero_matricula
    and    emp.emp_dep_codigo_pagto = par_dep_codigo
    and    emp.emp_status <> 2 -- lançar para empregados ativos e afastados
    and    oem.oem_ofu_codigo = 238
    and    (oem.oem_data_termino is null or
            to_number(to_char(oem.oem_data_termino,'yyyymmdd')) >=
            to_number(to_char(par_ano)||lpad(to_char(par_mes),2,'0')||'01'))
    order by 1;
    */

cursor cont_sindical is
       select emp.emp_numero_matricula,
              emp.emp_dep_codigo_pagto
       from   cadastros emp
       where  emp.emp_contrib_sindical_anual = 'S'
       and    not exists
             (select 'X'
              from   movimentacao mov
              where  mov.mov_ano_referencia = par_ano
              and    mov.mov_mes_referencia < par_mes
              and    mov.mov_rub_codigo     = 5130
              and    mov.mov_tip_rubrica    = 'N'
              and    mov.mov_versao_pagamento = 1
              and    mov.mov_emp_numero_matricula = emp.emp_numero_matricula)
       and    emp.emp_dep_codigo_pagto = par_dep_codigo
       and    emp.emp_status <> 2 -- lançar para empregados ativos e afastados
       order by 1;

cursor cont_confederativa is
       select emp.emp_numero_matricula,
              emp.emp_dep_codigo_pagto
       from   cadastros emp
       where  emp.emp_contrib_federativa = 'S'
       and    emp.emp_dep_codigo_pagto = par_dep_codigo
       and    emp.emp_status <> 2 -- lançar para empregados ativos e afastados
       order by 1;

cursor c_ocorr is
       select oem_emp_numero_matricula, oem_ofu_codigo, oem_data_inicio, oem_data_termino,
              oem_fun_codigo, oem_fun_codigo_substitui, oem_fun_codigo_acumula,
              emp_tipo_remuneracao_funcao
       from   ocorrencias_empregados, cadastros
       where  (   (oem_data_termino is null)
               or (to_number(to_char(oem_data_termino,'yyyymm')) >
               to_number(to_char(par_ano)||lpad(to_char(par_mes),2,'0'))) )
       and    (to_number(to_char(oem_data_inicio,'yyyymmdd')) >=
               to_number(to_char(v_ano_anterior)||lpad(to_char(v_mes_anterior),2,'0')||'01'))
       and    oem_ofu_codigo in (8,85,86,89,93,125,141,217,220,238,240)
       and    oem_dep_codigo = par_dep_codigo
       and    oem_emp_numero_matricula = emp_numero_matricula
       order by oem_emp_numero_matricula, oem_data_inicio;

cursor c_ocorr_fin is
       select oem_emp_numero_matricula, oem_ofu_codigo, oem_data_inicio, oem_data_termino,
              oem_fun_codigo, oem_fun_codigo_substitui, oem_fun_codigo_acumula,
              emp_tipo_remuneracao_funcao
       from   ocorrencias_empregados, cadastros
       where  to_number(to_char(oem_data_termino,'yyyymmdd')) >=
              to_number(to_char(par_ano)||lpad(to_char(par_mes),2,'0')||'01')
       and    to_number(to_char(oem_data_termino,'yyyymmdd')) <=
              to_number(to_char(par_ano)||lpad(to_char(par_mes),2,'0')||to_char(v_dia_mes))
       and    oem_ofu_codigo in (8,85,86,89,93,125,141,217,220,238,240)
       and    oem_dep_codigo = par_dep_codigo
       and    oem_emp_numero_matricula = emp_numero_matricula
       order by oem_emp_numero_matricula, oem_data_inicio;

cursor c_ocorr_fin_mes_anterior is
       select oem_emp_numero_matricula, oem_ofu_codigo, oem_data_inicio, oem_data_termino,
              oem_fun_codigo, oem_fun_codigo_substitui, oem_fun_codigo_acumula,
              emp_tipo_remuneracao_funcao
       from   ocorrencias_empregados, cadastros
       where  oem_data_termino is not null
       and    oem_data_termino >= to_date('01/' || lpad(to_char(v_mes_anterior),2,'0') || '/' || to_char(v_ano_anterior), 'dd/mm/yyyy')
       and    oem_data_termino < to_date('01/' || lpad(to_char(par_mes),2,'0') || '/' || to_char(par_ano), 'dd/mm/yyyy')
       and    oem_dep_codigo = par_dep_codigo
       and    oem_emp_numero_matricula = emp_numero_matricula
       and    oem_ofu_codigo in (8,85,86,89,93,125,141,217,220,238,240)
       order by oem_emp_numero_matricula, oem_data_inicio;

cursor c_mov is
       select mov.mov_ano_referencia, mov.mov_mes_referencia, mov.mov_versao_pagamento,
 	          mov.mov_emp_numero_matricula, mov.mov_rub_codigo, mov.mov_sequencial,
	          mov.mov_for_codigo, mov.mov_parcela, mov.mov_parcela_atual, mov.mov_tipo_parametro,
	          mov.mov_parametro, mov.mov_valor, mov.mov_tip_rubrica, mov.mov_mes_ref_diferenca,
	          mov.mov_ano_ref_diferenca, mov.mov_pen_codigo, mov.mov_ind_calculo,
              mov.mov_pem_ben_sigla, mov.mov_rub_seq_pagamento, mov.mov_ind_arsaprev,
	          mov.mov_fun_codigo, mov.mov_tipo_funcao, mov.mov_pkt_codigo_pedido,
 	          mov.mov_valor_integral, mov.mov_ind_exclusivo, mov.mov_dias_proporcionalidade,
	          mov.mov_emp_dep_codigo_pagto,mov.mov_flg_frequencia,mov.mov_nsa_codigo_nivel,
              mov.mov_nsa_codigo_padrao,mov.mov_nsa_indicador_nivel_escola,
              mov.mov_oem_data_inicio,mov.mov_oem_emp_numero_matricula,mov.mov_oem_ofu_codigo,
              emp.emp_dep_codigo_lotacao, emp.emp_data_admissao
       from   movimentacao mov, cadastros emp
       where  mov.mov_ano_referencia       = v_ano_anterior
       and    mov.mov_mes_referencia       = v_mes_anterior
       and    mov.mov_versao_pagamento     = par_versao
       and    mov.mov_emp_dep_codigo_pagto = par_dep_codigo
       and   (mov.mov_parcela_atual < mov.mov_parcela or mov.mov_parcela = 999)
       and    mov.mov_emp_numero_matricula = emp.emp_numero_matricula
       and    emp.emp_status <> 2 -- lançar para empregados ativos e afastados
       and    mov.mov_rub_codigo not in (5600, 5601, 5602)
       order by mov_ano_referencia, mov_mes_referencia, mov_versao_pagamento,
 	          mov_emp_numero_matricula, mov_rub_codigo, mov_sequencial;

/* -- talvez será utilizado para substituir o select de cima
       select mov.mov_ano_referencia, mov.mov_mes_referencia, mov.mov_versao_pagamento,
 	          mov.mov_emp_numero_matricula, mov.mov_rub_codigo, mov.mov_sequencial,
	          mov.mov_for_codigo, mov.mov_parcela, mov.mov_parcela_atual, mov.mov_tipo_parametro,
	          mov.mov_parametro, mov.mov_valor, mov.mov_tip_rubrica, mov.mov_mes_ref_diferenca,
	          mov.mov_ano_ref_diferenca, mov.mov_pen_codigo, mov.mov_ind_calculo,
              mov.mov_pem_ben_sigla, mov.mov_rub_seq_pagamento, mov.mov_ind_arsaprev,
	          mov.mov_fun_codigo, mov.mov_tipo_funcao, mov.mov_pkt_codigo_pedido,
 	          mov.mov_valor_integral, mov.mov_ind_exclusivo, mov.mov_dias_proporcionalidade,
	          mov.mov_emp_dep_codigo_pagto,mov.mov_flg_frequencia,mov.mov_nsa_codigo_nivel,
              mov.mov_nsa_codigo_padrao,mov.mov_nsa_indicador_nivel_escola,
              mov.mov_oem_data_inicio,mov.mov_oem_emp_numero_matricula,mov.mov_oem_ofu_codigo,
              emp.emp_dep_codigo_lotacao, emp.emp_data_admissao
       from   movimentacao mov, cadastros emp
       where  mov.mov_ano_referencia       = 2003
       and    mov.mov_mes_referencia       = 5
       and    mov.mov_versao_pagamento     = 1
       and   (mov.mov_parcela_atual < mov.mov_parcela or mov.mov_parcela = 999)
       and    mov.mov_emp_numero_matricula = emp.emp_numero_matricula
       and    emp.emp_status <> 2 -- lançar para empregados ativos e afastados
       and    mov.mov_rub_codigo not in (5600, 5601, 5602)

--       and    mov.mov_emp_numero_matricula = 2627420
--       and    mov.mov_rub_codigo = 5355

       and    exists (select *
                          from   ocorrencias_empregados
                          where  oem_data_termino is not null
                          and    oem_data_termino >= to_date('01/' || lpad(to_char(5),2,'0') || '/' || to_char(2003), 'dd/mm/yyyy')
                          and    oem_data_termino < to_date('01/' || lpad(to_char(6),2,'0') || '/' || to_char(2003), 'dd/mm/yyyy')
--                          and    oem_ofu_codigo in (8,85,86,89,93,125,141,217,220,238,240)
                          and    mov.mov_parcela = 999
                          and    oem_emp_numero_matricula = mov.mov_oem_emp_numero_matricula
                          and    oem_ofu_codigo = mov.mov_oem_ofu_codigo
                          and    oem_data_inicio = mov.mov_oem_data_inicio)
       order by mov_ano_referencia, mov_mes_referencia, mov_versao_pagamento,
 	          mov_emp_numero_matricula, mov_rub_codigo, mov_sequencial
*/

cursor c_ferias is
       select mov_emp_numero_matricula, mov_valor, mov_oem_data_inicio, mov_oem_ofu_codigo
       from   movimentacao
       where  mov_ano_referencia        =  v_ano_anterior
       and    mov_mes_referencia        =  v_mes_anterior
       and    mov_versao_pagamento      =  par_versao
       and    mov_emp_dep_codigo_pagto  =  par_dep_codigo
       and    mov_rub_codigo            =  1290
       and    mov_tip_rubrica           =  'N';

cursor c_ferias1 is
       select mov_parcela, rowid
       from   movimentacao
       where  mov_emp_numero_matricula  = v_emp
       and    mov_oem_data_inicio       = v_data_inicio
       and    mov_versao_pagamento      =  1
       and    mov_rub_codigo            =  5355
       and    mov_tip_rubrica           =  'N'
       and    mov_parcela_atual         =  1;

r_ferias1        c_ferias1%rowtype;

cursor c_emp is
       select emp_numero_matricula
       from   cadastros
       where  emp_dep_codigo_pagto = par_dep_codigo
       and    emp_status <> 2 -- lançar para empregados ativos e afastados
       order  by emp_numero_matricula;

cursor c_ocor_264 is
       select oem.oem_emp_numero_matricula, oem.oem_ofu_codigo, oem.oem_data_inicio, oem.oem_data_inclusao,
              oem.oem_data_termino, oem.oem_texto, oem.oem_diploma_legal, oem.oem_oem_emp_numero_matricula,
              oem.oem_oem_ofu_codigo, oem.oem_oem_data_inicio, oem.oem_emp_numero_matricula_subst,
              oem.oem_uor_codigo, oem.oem_oex_codigo_cedido, oem.oem_oex_codigo_requisitado,
              oem.oem_data_cancel_interrupcao, oem.oem_motivo_cancel_interrupcao,
              oem.oem_indicador_cancelamento, oem.oem_dep_codigo, oem.oem_indicador_onus,
              oem.oem_diploma_legal_termino, oem.oem_pfe_emp_num_matr_program,
              oem.oem_pfe_sequencial_program, oem.oem_pfe_emp_num_matr_confirm1,
              oem.oem_pfe_sequencial_confirm1, oem.oem_pfe_emp_num_matr_confirm2,
              oem.oem_pfe_sequencial_confirm2, oem.oem_fun_codigo, oem.oem_fun_codigo_substitui,
              oem.oem_fun_codigo_acumula, oem.oem_dep_codigo_origem, oem.oem_mov_parametro, oem.oem_car_codigo,
              oem.oem_car_codigo_nivel, oem.oem_car_occ_codigo, oem.oem_emp_nsa_codigo_nivel,
              oem.oem_emp_nsa_codigo_padrao, oem.oem_emp_nsa_in_nivel_escol,
              oem.oem_tipo_remuneracao_funcao, oem.oem_cct_codigo, oem.oem_valor, oem.oem_esc_cid_codigo,
              oem.oem_esc_eid_codigo, oem.oem_tipo_expediente, oem.oem_cod_horario_empregado,
              oem.oem_turno_trabalho_empregado,  emp.emp_dep_codigo_lotacao, emp.emp_uor_codigo_lotacao,
              emp.emp_qlp_car_codigo, emp.emp_nsa_codigo_nivel, emp.emp_nsa_codigo_padrao,
              emp.emp_nsa_in_nivel_escolaridade
       from   ocorrencias_empregados oem, cadastros emp
       where  oem.oem_ofu_codigo in (select ofu_codigo from ocorrencias_funcionais
                                 where ofu_indicador_tipo = 10)
       and   to_number(to_char(oem.oem_data_inicio,'yyyymm')) =
             to_number(lpad(to_char(v_ano_anterior),4,'0')||lpad(to_char(v_mes_anterior),2,'0'))
       -- ***********************************************************************
       -- ***********************************************************************
       -- Verificar com o Alisson se o empregado desligado no início do mês
       -- mesmo que tendo optado por recebimento em folha o abre mês deverá
       -- jogá-lo para RCT gerando a ocorrência 264

        /*and   to_number(to_char(oem.oem_data_inicio,'yyyymmdd')) <=
             to_number(lpad(to_char(par_ano),4,'0')||lpad(to_char(par_mes),2,'0')||
                       lpad(to_char(v_dia_mes),2,'0')) */
       -- ***********************************************************************
       -- ***********************************************************************
	   and   emp.emp_dep_codigo_pagto = par_dep_codigo -- Inserido join com a dependência parâmetro
       and   oem.oem_emp_numero_matricula = emp.emp_numero_matricula
       and   emp.emp_dep_codigo_pagto = par_dep_codigo
       and   oem.oem_emp_numero_matricula not in
            (select oem1.oem_emp_numero_matricula
             from   ocorrencias_empregados oem1
             where  oem1.oem_emp_numero_matricula = oem.oem_emp_numero_matricula
             and    oem1.oem_ofu_codigo           = 264
             and    oem1.oem_data_inicio          = oem.oem_data_inicio);
r_ocor_264              c_ocor_264%rowtype;


-----------------------------------------------------------------------------------
--   Efetua a atualização dos dias de proporcionalidade de função de confiança.  --
-----------------------------------------------------------------------------------
Procedure Atualiza_proporcionalidade (p_fun_codigo number, p_dias number,
                                      p_rubrica number, p_matricula number,
                                      p_parcela number) is
Begin
   update movimentacao
   set    mov_dias_proporcionalidade = p_dias,
          mov_parcela                = p_parcela,
          mov_parcela_atual          = p_parcela
   where  mov_emp_numero_matricula   = p_matricula
   and    mov_ano_referencia         = par_ano
   and    mov_mes_referencia         = par_mes
   and    mov_rub_codigo             = p_rubrica
   and    mov_tip_rubrica            = 'N'
   and   (    (p_fun_codigo is null)
          or  (mov_fun_codigo = p_fun_codigo));

end;  -- término atualiza_proporcionalidade

-----------------------------------------------------------------------------------
--                              Tratamento de RCT.                               --
-----------------------------------------------------------------------------------
Procedure trata_rct is
Begin
   -- C_OCOR_264
   -- cursor que lista todas os dados das ocorrências do grupo 10 (Ocorrências de Saída)
   -- com data de início entre o 1º dia do mês atual e o último dia do mês atual
   -- para os empregados que não possuem uma ocorrência "264 - DESLIGAMENTO  (USO INTERNO SISTEMA)"
   open c_ocor_264;
   loop
     fetch c_ocor_264 into r_ocor_264;
     exit when c_ocor_264%notfound;

     begin
	   -- Insere a ocorrência 264 - DESLIGAMENTO  (USO INTERNO SISTEMA)"
       insert into ocorrencias_empregados
           (oem_emp_numero_matricula, oem_ofu_codigo, oem_data_inicio, oem_data_inclusao,
            oem_data_termino, oem_texto, oem_diploma_legal, oem_oem_emp_numero_matricula,
            oem_oem_ofu_codigo, oem_oem_data_inicio, oem_emp_numero_matricula_subst,
            oem_uor_codigo, oem_oex_codigo_cedido, oem_oex_codigo_requisitado,
            oem_data_cancel_interrupcao, oem_motivo_cancel_interrupcao,
            oem_indicador_cancelamento, oem_dep_codigo, oem_indicador_onus,
            oem_diploma_legal_termino, oem_pfe_emp_num_matr_program, oem_pfe_sequencial_program,
            oem_pfe_emp_num_matr_confirm1, oem_pfe_sequencial_confirm1,
            oem_pfe_emp_num_matr_confirm2, oem_pfe_sequencial_confirm2, oem_fun_codigo,
            oem_fun_codigo_substitui, oem_fun_codigo_acumula, oem_dep_codigo_origem,
            oem_mov_parametro, oem_car_codigo, oem_car_codigo_nivel, oem_car_occ_codigo,
            oem_emp_nsa_codigo_nivel, oem_emp_nsa_codigo_padrao, oem_emp_nsa_in_nivel_escol,
            oem_tipo_remuneracao_funcao, oem_cct_codigo, oem_valor, oem_esc_cid_codigo,
            oem_esc_eid_codigo, oem_tipo_expediente, oem_cod_horario_empregado,
            oem_turno_trabalho_empregado)
         values
           (r_ocor_264.oem_emp_numero_matricula, 264, r_ocor_264.oem_data_inicio, sysdate,
            r_ocor_264.oem_data_termino, r_ocor_264.oem_texto, r_ocor_264.oem_diploma_legal,
            r_ocor_264.oem_emp_numero_matricula, r_ocor_264.oem_ofu_codigo,
            r_ocor_264.oem_data_inicio, null, r_ocor_264.emp_uor_codigo_lotacao, null, null,
            null, null, null, r_ocor_264.emp_dep_codigo_lotacao, null,
            r_ocor_264.oem_diploma_legal, null, null, null, null, null, null, null, null, null,
            null, null, r_ocor_264.emp_qlp_car_codigo, null, null,
            r_ocor_264.emp_nsa_codigo_nivel, r_ocor_264.emp_nsa_codigo_padrao,
            r_ocor_264.emp_nsa_in_nivel_escolaridade, null, null, null, null, null,
            null, null, null);
     end;

   end loop;
   close c_ocor_264;

end;  -- término trata_rct

-----------------------------------------------------------------------------------
--                 Efetua a inclusão das movimentações com base no mês anterior  --
-----------------------------------------------------------------------------------
Procedure Gerar_movimentacao is
Begin
   par_num_mov := 0;

   -- C_MOV
   -- Cursor que trás a movimentação do mês/ano anterior ao parâmetro de todos os
   -- empregados ativos da dependência parâmetro com parcela 999 ou com parcela
   -- atual menor do que a última parcela
   for r_mov in c_mov
   loop
      if r_mov.mov_parcela = 999 then
         v_parcela := 999;
      else
         v_parcela := r_mov.mov_parcela_atual + 1;
      end if;
      if nvl(r_mov.mov_tipo_parametro,'X') <> 'V' then
         r_mov.mov_valor          := null;
         r_mov.mov_valor_integral := null;
      end if;

      v_mov_sequencial := busca_mov_seq
            (par_mes,par_ano,par_versao,r_mov.mov_emp_numero_matricula,r_mov.mov_rub_codigo,'N');

      -- Se empregado admitido no mês anterior...
      if to_number(to_char(r_mov.emp_data_admissao,'yyyymm')) =
         to_number(to_char(v_ano_anterior)||lpad(to_char(v_mes_anterior),2,'0')) then
         r_mov.mov_dias_proporcionalidade := 30;
      end if;

      -- Busca as fórmulas das rubricas abaixo
      -- 5500	PENSÃO ALIMENTÍCIA
      -- 5515	PENSÃO INDENIZATÓRIA
      -- 5520	PENSÃO INDENIZATÓRIA SOBRE FÉRIAS
      -- 5525	PENSÃO INDENIZATÓRIA SOBRE 13.
      if r_mov.mov_rub_codigo in (5500,5515,5520,5525) then
         begin
            select pen_for_codigo
            into   v_for_codigo
            from   pensionistas
            where  pen_emp_numero_matricula = r_mov.mov_emp_numero_matricula
            and    pen_codigo               = r_mov.mov_pen_codigo;
         exception
            when no_data_found then
                v_for_codigo := null;
         end;
      else
         v_for_codigo := null;
      end if;
      begin

   	     -- Insere a movimentação no mês/ano que está sendo aberto
         insert into movimentacao
                (mov_ano_referencia,	mov_mes_referencia,	mov_versao_pagamento,
                 mov_emp_numero_matricula, mov_rub_codigo, mov_sequencial,
                 mov_for_codigo, mov_parcela, mov_parcela_atual, mov_tipo_parametro,
                 mov_parametro, mov_valor, mov_tip_rubrica, mov_mes_ref_diferenca,
                 mov_ano_ref_diferenca, mov_pen_codigo, mov_ind_calculo,
                 mov_pem_ben_sigla, mov_rub_seq_pagamento, mov_ind_arsaprev,
                 mov_fun_codigo, mov_tipo_funcao, mov_pkt_codigo_pedido,
                 mov_valor_integral, mov_ind_exclusivo, mov_dias_proporcionalidade,
                 mov_emp_dep_codigo_pagto, mov_flg_frequencia, mov_nsa_codigo_nivel,
                 mov_nsa_codigo_padrao, mov_nsa_indicador_nivel_escola,
                 mov_oem_data_inicio, mov_oem_emp_numero_matricula,
                 mov_oem_ofu_codigo)
         values (par_ano, par_mes, par_versao, r_mov.mov_emp_numero_matricula,
                 r_mov.mov_rub_codigo, v_mov_sequencial, v_for_codigo,
                 r_mov.mov_parcela, v_parcela, r_mov.mov_tipo_parametro,
                 r_mov.mov_parametro, r_mov.mov_valor, r_mov.mov_tip_rubrica,
                 r_mov.mov_mes_ref_diferenca, r_mov.mov_ano_ref_diferenca,
                 r_mov.mov_pen_codigo, 'N', r_mov.mov_pem_ben_sigla,
                 r_mov.mov_rub_seq_pagamento, r_mov.mov_ind_arsaprev,
                 r_mov.mov_fun_codigo, r_mov.mov_tipo_funcao,
                 r_mov.mov_pkt_codigo_pedido, r_mov.mov_valor_integral,
                 r_mov.mov_ind_exclusivo, r_mov.mov_dias_proporcionalidade,
                 r_mov.emp_dep_codigo_lotacao, r_mov.mov_flg_frequencia,
                 r_mov.mov_nsa_codigo_nivel, r_mov.mov_nsa_codigo_padrao,
                 r_mov.mov_nsa_indicador_nivel_escola, r_mov.mov_oem_data_inicio,
                 r_mov.mov_oem_emp_numero_matricula, r_mov.mov_oem_ofu_codigo);
        par_num_mov := nvl(par_num_mov,0) + 1;
     exception
        when others then
           null;
     end;
   end loop;
end;  -- término Gerar_movimentacao

-----------------------------------------------------------------------------------
--                   Trata desconto de adiantamento de férias                    --
-----------------------------------------------------------------------------------
Procedure trata_ferias is
   v_rowid rowid;
Begin

   -- C_FERIAS
   -- Trás todas as movimentações referentes ao mês/ano anterior ao parâmetro
   -- referentes a rubrica 1290 - ADIANTAMENTO DE FÉRIAS da dependência parâmetro
   -- versão = parâmetro e do tipo 'N' - Normal
   for r_mov in c_ferias
   loop
      if r_mov.mov_oem_data_inicio is not null then
         v_emp         := r_mov.mov_emp_numero_matricula;
         v_data_inicio := r_mov.mov_oem_data_inicio;

		 -- C_FERIAS1
		 -- Busca a 1ª parcela da rubrica 5355 - DESCONTO ADIANTAMENTO DE FÉRIAS
		 -- para o empregado do cursor c_ferias com a mov_oem_data_inicio igual a
		 -- do cursor c_ferias para a versão 1 e tipo de rubrica 'N' - Normal
         open c_ferias1;
         loop
            fetch c_ferias1 into r_ferias1;
            exit when c_ferias1%notfound;

			-- Divide o valor total do adiantamento de férias (encontrado na rub. 1290)
			-- pelo número de parcelas do desconto do adiantamento de férias (5355)
            r_mov.mov_valor  := r_mov.mov_valor / r_ferias1.mov_parcela;

			-- Altera os campos de valor da movimentação com o valor encontrado na linha anterior
            update movimentacao
            set    mov_valor          = r_mov.mov_valor,
                   mov_parametro      = r_mov.mov_valor,
                   mov_valor_integral = r_mov.mov_valor,
                   mov_tipo_parametro = 'V'
            where  rowid = r_ferias1.rowid;
         end loop;
         close c_ferias1;
      elsif r_mov.mov_oem_data_inicio is null then -- Nunca vai entrar aqui!!! (verificar se pode ser retirado do código)
         begin
		    -- Seleciona a quantidade de parcelas da rubrica 5355 - DESCONTO ADIANTAMENTO DE FÉRIAS
			-- para as movimentações referentes a 1ª parcela de sequencial 1 com tipo da rubrica 'N' - Normal,
			-- versão de pagamento = 1 e mês/ano de referência maior do que os da abertura
            select movi.mov_parcela, rowid
            into   v_parcela_ferias, v_rowid
            from   movimentacao movi
            where  mov_emp_numero_matricula  =  r_mov.mov_emp_numero_matricula
            and    to_number(to_char(mov_ano_referencia)||
                        lpad(to_char(mov_mes_referencia),2,'0')) >
                   to_number(to_char(par_ano)||
                        lpad(to_char(par_mes),2,'0'))
            and    mov_versao_pagamento      =  1
            and    mov_rub_codigo            =  5355
            and    mov_tip_rubrica           =  'N'
            and    mov_sequencial            =  1
            and    mov_parcela_atual         =  1;
			-- Divide o valor pela quantidade de parcelas totais
            r_mov.mov_valor  := r_mov.mov_valor / v_parcela_ferias;
			-- Altera os campos de valor da movimentação com o valor encontrado na linha anterior
			-- alterando também o tipo parâmetro para 'V' - valor e o mês/ano ref da diferença para nulos
            update movimentacao
            set    mov_valor          = r_mov.mov_valor,
                   mov_parametro      = r_mov.mov_valor,
                   mov_valor_integral = r_mov.mov_valor,
                   mov_tipo_parametro = 'V'
            where  rowid = v_rowid;
         exception
            when no_data_found then
                null;
         end;
      end if;

   end loop;

End;  -- término trata_ferias
-----------------------------------------------------------------------------------
--                          Trata pericul insalub                                --
-----------------------------------------------------------------------------------
Procedure trata_pericul is
Begin
  --   Atuzaliza lançamentos de periculosidade e insalubridade       --

   -- C_EMP
   -- Trás todos os empregados ativos da dependência parâmetro
   for r_emp in c_emp
   loop
   	  -- Procedure de banco que apaga todas as movimentações de rubricas 1090 - ADICIONAL DE INSALUBRIDADE,
      -- e 1085 - ADICIONAL DE PERICULOSIDADE para o empregado, mês, ano, versão e dependência parâmetros
	  -- e depois busca da tabela HIST_PERICUL_INSALUB as periculosidades/insalubridades referentes ao mês/ano
	  -- parâmetro (com data término nula e data início menor ou igual ao mês/ano parâmetro ou data término
	  -- preenchida maior ou igual ao mês/ano parâmetros e data início menor ou igual ao mês/ano parâmetros)
	  -- calculando em seguida o total de dias em que o empregado esteve em periculosidade ou insalubridade
	  -- dentro do mês/ano parâmetro e inserindo em seguida as rubricas 1090 e 1085 na movimentação referente
	  -- ao mês, ano, versão, empregado e dependência parâmetros com mov_parcela e mov_parcela_atual iguais a 999,
	  -- mov_tipo_parametro = 'P' (percentual), mov_parametro igual ao percentual retornado da tabela HIST_PERICUL_INSALUB
	  -- mov_dias_proporcionalidade igual aos dias calculados e dependência de pagamento igual a parâmetro
      atualiza_pericul_insalub(par_mes, par_ano, par_versao,
                               par_dep_codigo, r_emp.emp_numero_matricula);
   end loop;

End;

-----------------------------------------------------------------------------------
--                          Trata função de confiança                            --
-----------------------------------------------------------------------------------
-- Atualiza os dias de proporcionalidade e as parcelas na tabela de movimentacao --
-----------------------------------------------------------------------------------
Procedure trata_funcao is
Begin

   --   Atuzaliza lançamentos de função de confiança quando os mesmos terminarem no mês anterior --

   -- C_OCORR_FIN_MES_ANTERIOR
   -- Retorna as ocorrências, relacionadas abaixo, do empregado e dependência parâmetros
   -- com a data término >= ao 1º dia do mês/ano anterior ao da abertura (parâmetro) e
   -- data término <= ao último dia do mês/ano anterior ao da abertura (parâmetro)
   --   8	MEMBRO DO CONSELHO FISCAL EFETIVO - NÃO EMPREGADO (INGRESSO NA EMPRESA)
   --  85	DESIGNAÇÃO CUMULATIVA DE FUNÇÃO DE CONFIANÇA (DESIGNAÇÃO/DISPENSA)
   --  86	DESIGNAÇÃO DE FUNÇÃO DE CONFIANÇA (DESIGNAÇÃO/DISPENSA)
   --  89	SUBSTITUIÇÃO DE FC MAIOR OU IGUAL A 07 DIAS (DESIGNAÇÃO/DISPENSA)
   --  93	DESIGNAÇÃO INTERINA DE FUNÇÃO DE CONFIANÇA (DESIGNAÇÃO/DISPENSA)
   -- 125	DESIGNAÇÃO DE DIRETOR EMPREGADO (DESIGNAÇÃO/DISPENSA)
   -- 141	MEMBRO DO CONSELHO DE ADMINISTRAÇÃO-NÃO EMPREGADO (INGRESSO NA EMPRESA)
   -- 217	DESIGNAÇÃO CUMULATIVA E INTERINA DE FUN CONFIANÇA (DESIGNAÇÃO/DISPENSA)
   -- 220	SUBSTITUIÇÃO CUMUL DE FC  MAIOR  OU  IGUAL 07 DIAS (DESIGNAÇÃO/DISPENSA)
   -- 238	DESIGNAÇÃO DE DIRETOR NÃO EMPREGADO (DESIGNAÇÃO/DISPENSA)
   -- 240	DESIGNAÇÃO DE PRESIDENTE NÃO EMPREGADO (DESIGNAÇÃO/DISPENSA)
   --
   for r_ocorr_fin_mes_anterior in c_ocorr_fin_mes_anterior
   loop
      p_matricula := r_ocorr_fin_mes_anterior.oem_emp_numero_matricula;
      if r_ocorr_fin_mes_anterior.oem_ofu_codigo in (85,86,93) then
         if r_ocorr_fin_mes_anterior.emp_tipo_remuneracao_funcao = 'RG' or
            r_ocorr_fin_mes_anterior.emp_tipo_remuneracao_funcao is null then
	 	         -- Se o empregado tiver perdido a ocorrência 85 (DESIGNAÇÃO CUMULATIVA DE FUNÇÃO DE CONFIANÇA),
	 	         -- 86 (DESIGNAÇÃO DE FUNÇÃO DE CONFIANÇA) ou 93 (DESIGNAÇÃO INTERINA DE FUNÇÃO DE CONFIANÇA)
	 	         -- e o empregado tiver optado por RG então atualiza os dias de proporcionalidade da
	 	         -- rubrica 1010 (REMUNERAÇÃO GLOBAL) para 0 (zero) e os da rubrica 1000 (SALÁRIO-BASE)
            -- para 30 dias
            Atualiza_proporcionalidade (r_ocorr_fin_mes_anterior.oem_fun_codigo,
             0, 1010, p_matricula, 1);
            Atualiza_proporcionalidade (null,
             30, 1000, p_matricula, 999);
         else
	 	         -- Se o empregado tiver perdido a ocorrência 85 (DESIGNAÇÃO CUMULATIVA DE FUNÇÃO DE CONFIANÇA),
	 	         -- 86 (DESIGNAÇÃO DE FUNÇÃO DE CONFIANÇA) ou 93 (DESIGNAÇÃO INTERINA DE FUNÇÃO DE CONFIANÇA)
	 	         -- e o empregado não tiver optado por RG então atualiza os dias de proporcionalidade da
	 	         -- rubrica 1015 (FUNÇÃO GRATIFICADA) para 0
            Atualiza_proporcionalidade (r_ocorr_fin_mes_anterior.oem_fun_codigo,
             0, 1015, p_matricula, 1);
         end if;
      elsif r_ocorr_fin_mes_anterior.oem_ofu_codigo in (217,220) then
	 	      -- Se o empregado tiver perdido a ocorrência 217 (DESIGNAÇÃO CUMULATIVA E INTERINA DE FUN CONFIANÇA)
	 	      -- ou a 220 (SUBSTITUIÇÃO CUMUL DE FC  MAIOR  OU  IGUAL 07 DIAS) atualiza os dias de
	 	      -- proporcionalidade da rubrica 1030 (ACUMULAÇÃO FUNÇÃO DE CONFIANÇA) para 0 (zero)
         Atualiza_proporcionalidade (r_ocorr_fin_mes_anterior.oem_fun_codigo,
           0, 1030, p_matricula, 1);
      elsif r_ocorr_fin_mes_anterior.oem_ofu_codigo in (238,240) then
	 	      -- Se o empregado tiver perdido a ocorrência 238 (DESIGNAÇÃO DE DIRETOR NÃO EMPREGADO)
	 	      -- ou a 240 (DESIGNAÇÃO DE PRESIDENTE NÃO EMPREGADO) atualiza os dias de proporcionalidade
	 	      -- das rubricas 1065 (HONORÁRIO DIRETOR - NÃO EMPREGADO) e 1070 (GRATIFICAÇÃO CARGO ELETIVO)
	 	      -- para 0 (zero)
         Atualiza_proporcionalidade (r_ocorr_fin_mes_anterior.oem_fun_codigo,
           0, 1065, p_matricula, 1);
         Atualiza_proporcionalidade (r_ocorr_fin_mes_anterior.oem_fun_codigo,
           0, 1070, p_matricula, 1);
      elsif r_ocorr_fin_mes_anterior.oem_ofu_codigo in (125) then
	 	      -- Se o empregado tiver perdido a ocorrência 125 (SUBSTITUIÇÃO DE FC MAIOR OU IGUAL A 07 DIAS)
	 	      -- atualiza os dias de proporcionalidade das rubricas 1060 (HONORÁRIO DIRETOR - EMPREGADO) e
	 	      -- 1070 (GRATIFICAÇÃO CARGO ELETIVO) para 0 (zero) e os dias de proporcionalidade da 1000 (SALÁRIO-BASE)
	 	      -- para 30 dias
         Atualiza_proporcionalidade (r_ocorr_fin_mes_anterior.oem_fun_codigo,
           0, 1060, p_matricula, 1);
         Atualiza_proporcionalidade (r_ocorr_fin_mes_anterior.oem_fun_codigo,
           0, 1070, p_matricula, 1);
         Atualiza_proporcionalidade (null,
           30, 1000, p_matricula, 999);
      elsif r_ocorr_fin_mes_anterior.oem_ofu_codigo in (89) then
	 	      -- Se o empregado tiver perdido a ocorrência 89 (SUBSTITUIÇÃO DE FC MAIOR OU IGUAL A 07 DIAS)
	 	      -- atualiza os dias de proporcionalidade da rubrica 1020 (SUBSTITUIÇÃO DE FUNÇÃO DE CONFIANÇA)
	 	      -- para 0 (zero)
         Atualiza_proporcionalidade (r_ocorr_fin_mes_anterior.oem_fun_codigo,
           0, 1020, p_matricula, 1);
      elsif r_ocorr_fin_mes_anterior.oem_ofu_codigo in (8) then
	 	      -- Se o empregado tiver perdido a ocorrência 8 (MEMBRO DO CONSELHO FISCAL EFETIVO - NÃO EMPREGADO)
	 	      -- atualiza os dias de proporcionalidade da rubrica 1080 (REMUNERAÇÃO DE CONSELHEIRO - FISCAL)
	 	      -- para 0 (zero)
         Atualiza_proporcionalidade (r_ocorr_fin_mes_anterior.oem_fun_codigo,
           0, 1080, p_matricula, 1);
      elsif r_ocorr_fin_mes_anterior.oem_ofu_codigo in (141) then
	 	      -- Se o empregado tiver perdido a ocorrência 141 (MEMBRO DO CONSELHO DE ADMINISTRAÇÃO-NÃO EMPREGADO)
	 	      -- atualiza os dias de proporcionalidade da rubrica 1075 (REMUNERAÇÃO DE CONSELHEIRO - ADMINISTRAÇÃO)
	 	      -- para 0 (zero)
         Atualiza_proporcionalidade (r_ocorr_fin_mes_anterior.oem_fun_codigo,
           to_number(to_char(r_ocorr_fin_mes_anterior.oem_data_termino,'dd')), 1075, p_matricula, 1);
      end if;
   end loop;

   --   Atuzaliza lançamentos de função de confiança quando a ocorr. term. no mês/ano parâmetro --

   -- C_OCORR_FIN
   -- Retorna as ocorrências, relacionadas abaixo, do empregado e dependência parâmetros
   -- com a data término >= ao 1º dia do mês/ano da abertura (parâmetro) e
   -- data término <= ao último dia do mês/ano da abertura (parâmetro)
   --   8	MEMBRO DO CONSELHO FISCAL EFETIVO - NÃO EMPREGADO (INGRESSO NA EMPRESA)
   --  85	DESIGNAÇÃO CUMULATIVA DE FUNÇÃO DE CONFIANÇA (DESIGNAÇÃO/DISPENSA)
   --  86	DESIGNAÇÃO DE FUNÇÃO DE CONFIANÇA (DESIGNAÇÃO/DISPENSA)
   --  89	SUBSTITUIÇÃO DE FC MAIOR OU IGUAL A 07 DIAS (DESIGNAÇÃO/DISPENSA)
   --  93	DESIGNAÇÃO INTERINA DE FUNÇÃO DE CONFIANÇA (DESIGNAÇÃO/DISPENSA)
   -- 125	DESIGNAÇÃO DE DIRETOR EMPREGADO (DESIGNAÇÃO/DISPENSA)
   -- 141	MEMBRO DO CONSELHO DE ADMINISTRAÇÃO-NÃO EMPREGADO (INGRESSO NA EMPRESA)
   -- 217	DESIGNAÇÃO CUMULATIVA E INTERINA DE FUN CONFIANÇA (DESIGNAÇÃO/DISPENSA)
   -- 220	SUBSTITUIÇÃO CUMUL DE FC  MAIOR  OU  IGUAL 07 DIAS (DESIGNAÇÃO/DISPENSA)
   -- 238	DESIGNAÇÃO DE DIRETOR NÃO EMPREGADO (DESIGNAÇÃO/DISPENSA)
   -- 240	DESIGNAÇÃO DE PRESIDENTE NÃO EMPREGADO (DESIGNAÇÃO/DISPENSA)
   --
   for r_ocorr_fin in c_ocorr_fin
   loop
      p_matricula := r_ocorr_fin.oem_emp_numero_matricula;
      if r_ocorr_fin.oem_ofu_codigo in (85,86,93) then
         if r_ocorr_fin.emp_tipo_remuneracao_funcao = 'RG' then
	 	         -- Se o empregado tiver a ocorrência 85 (DESIGNAÇÃO CUMULATIVA DE FUNÇÃO DE CONFIANÇA),
	 	         -- 86 (DESIGNAÇÃO DE FUNÇÃO DE CONFIANÇA) ou 93 (DESIGNAÇÃO INTERINA DE FUNÇÃO DE CONFIANÇA)
	 	         -- e o empregado tiver optado por RG então atualiza os dias de proporcionalidade da
	 	         -- rubrica 1010 (REMUNERAÇÃO GLOBAL) para nº de dias da data término da ocorrência
	 	         -- e os da rubrica 1000 (SALÁRIO-BASE) para 30 dias menos o nº de dias da data término da ocorrência
            Atualiza_proporcionalidade (r_ocorr_fin.oem_fun_codigo,
             to_number(to_char(r_ocorr_fin.oem_data_termino,'dd')), 1010, p_matricula, 1);
            Atualiza_proporcionalidade (null,
             (30 - to_number(to_char(r_ocorr_fin.oem_data_termino,'dd'))), 1000, p_matricula, 999);
         else
	 	         -- Se o empregado tiver a ocorrência 85 (DESIGNAÇÃO CUMULATIVA DE FUNÇÃO DE CONFIANÇA),
	 	         -- 86 (DESIGNAÇÃO DE FUNÇÃO DE CONFIANÇA) ou 93 (DESIGNAÇÃO INTERINA DE FUNÇÃO DE CONFIANÇA)
	 	         -- e o empregado não tiver optado por RG então atualiza os dias de proporcionalidade da
	 	         -- rubrica 1015 (FUNÇÃO GRATIFICADA) para nº de dias da data término da ocorrência
            Atualiza_proporcionalidade (r_ocorr_fin.oem_fun_codigo,
             to_number(to_char(r_ocorr_fin.oem_data_termino,'dd')), 1015, p_matricula, 1);
         end if;
      elsif r_ocorr_fin.oem_ofu_codigo in (217,220) then
	 	      -- Se o empregado tiver a ocorrência 217 (DESIGNAÇÃO CUMULATIVA E INTERINA DE FUN CONFIANÇA)
	 	      -- ou a 220 (SUBSTITUIÇÃO CUMUL DE FC  MAIOR  OU  IGUAL 07 DIAS) atualiza os dias de
	 	      -- proporcionalidade da rubrica 1030 (ACUMULAÇÃO FUNÇÃO DE CONFIANÇA) para nº de dias da data término da ocorrência
         Atualiza_proporcionalidade (r_ocorr_fin.oem_fun_codigo,
           to_number(to_char(r_ocorr_fin.oem_data_termino,'dd')), 1030, p_matricula, 1);
      elsif r_ocorr_fin.oem_ofu_codigo in (238,240) then
	 	      -- Se o empregado tiver a ocorrência 238 (DESIGNAÇÃO DE DIRETOR NÃO EMPREGADO)
	 	      -- ou a 240 (DESIGNAÇÃO DE PRESIDENTE NÃO EMPREGADO) atualiza os dias de proporcionalidade
	 	      -- das rubricas 1065 (HONORÁRIO DIRETOR - NÃO EMPREGADO) e 1070 (GRATIFICAÇÃO CARGO ELETIVO)
	 	      -- para nº de dias da data término da ocorrência
         Atualiza_proporcionalidade (r_ocorr_fin.oem_fun_codigo,
           to_number(to_char(r_ocorr_fin.oem_data_termino,'dd')), 1065, p_matricula, 1);
         Atualiza_proporcionalidade (r_ocorr_fin.oem_fun_codigo,
           to_number(to_char(r_ocorr_fin.oem_data_termino,'dd')), 1070, p_matricula, 1);
      elsif r_ocorr_fin.oem_ofu_codigo in (125) then
	 	      -- Se o empregado tiver a ocorrência 125 (SUBSTITUIÇÃO DE FC MAIOR OU IGUAL A 07 DIAS)
	 	      -- atualiza os dias de proporcionalidade das rubricas 1060 (HONORÁRIO DIRETOR - EMPREGADO) e
	 	      -- 1070 (GRATIFICAÇÃO CARGO ELETIVO) para nº de dias da data término da ocorrência e os dias de proporcionalidade da 1000 (SALÁRIO-BASE)
	 	      -- para 30 dias menos o nº de dias da data término da ocorrência
         Atualiza_proporcionalidade (r_ocorr_fin.oem_fun_codigo,
           to_number(to_char(r_ocorr_fin.oem_data_termino,'dd')), 1060, p_matricula, 1);
         Atualiza_proporcionalidade (r_ocorr_fin.oem_fun_codigo,
           to_number(to_char(r_ocorr_fin.oem_data_termino,'dd')), 1070, p_matricula, 1);
         Atualiza_proporcionalidade (null,
           (30 - to_number(to_char(r_ocorr_fin.oem_data_termino,'dd'))), 1000,
            p_matricula, 999);
      elsif r_ocorr_fin.oem_ofu_codigo in (89) then
	 	      -- Se o empregado tiver a ocorrência 89 (SUBSTITUIÇÃO DE FC MAIOR OU IGUAL A 07 DIAS)
	 	      -- atualiza os dias de proporcionalidade da rubrica 1020 (SUBSTITUIÇÃO DE FUNÇÃO DE CONFIANÇA)
	 	      -- para nº de dias da data término da ocorrência
         Atualiza_proporcionalidade (r_ocorr_fin.oem_fun_codigo,
           to_number(to_char(r_ocorr_fin.oem_data_termino,'dd')), 1020, p_matricula, 1);
      elsif r_ocorr_fin.oem_ofu_codigo in (8) then
	 	      -- Se o empregado tiver a ocorrência 8 (MEMBRO DO CONSELHO FISCAL EFETIVO - NÃO EMPREGADO)
	 	      -- atualiza os dias de proporcionalidade da rubrica 1080 (REMUNERAÇÃO DE CONSELHEIRO - FISCAL)
	 	      -- para nº de dias da data término da ocorrência
         Atualiza_proporcionalidade (r_ocorr_fin.oem_fun_codigo,
           to_number(to_char(r_ocorr_fin.oem_data_termino,'dd')), 1080, p_matricula, 1);
      elsif r_ocorr_fin.oem_ofu_codigo in (141) then
	 	      -- Se o empregado tiver a ocorrência 141 (MEMBRO DO CONSELHO DE ADMINISTRAÇÃO-NÃO EMPREGADO)
	 	      -- atualiza os dias de proporcionalidade da rubrica 1075 (REMUNERAÇÃO DE CONSELHEIRO - ADMINISTRAÇÃO)
	 	      -- para nº de dias da data término da ocorrência
         Atualiza_proporcionalidade (r_ocorr_fin.oem_fun_codigo,
           to_number(to_char(r_ocorr_fin.oem_data_termino,'dd')), 1075, p_matricula, 1);
      end if;
   end loop;

   --   Atuzaliza lançamentos de função de confiança         --

   -- C_OCORR
   -- Retorna as ocorrências, relacionadas abaixo, do empregado e dependência parâmetros
   -- com a data término nula ou maior que mês/ano parâmetro e data de início >= ao 1º dia
   -- do mês/ano anterior ao da abertura (parâmetro)
   --   8	MEMBRO DO CONSELHO FISCAL EFETIVO - NÃO EMPREGADO (INGRESSO NA EMPRESA)
   --  85	DESIGNAÇÃO CUMULATIVA DE FUNÇÃO DE CONFIANÇA (DESIGNAÇÃO/DISPENSA)
   --  86	DESIGNAÇÃO DE FUNÇÃO DE CONFIANÇA (DESIGNAÇÃO/DISPENSA)
   --  89	SUBSTITUIÇÃO DE FC MAIOR OU IGUAL A 07 DIAS (DESIGNAÇÃO/DISPENSA)
   --  93	DESIGNAÇÃO INTERINA DE FUNÇÃO DE CONFIANÇA (DESIGNAÇÃO/DISPENSA)
   -- 125	DESIGNAÇÃO DE DIRETOR EMPREGADO (DESIGNAÇÃO/DISPENSA)
   -- 141	MEMBRO DO CONSELHO DE ADMINISTRAÇÃO-NÃO EMPREGADO (INGRESSO NA EMPRESA)
   -- 217	DESIGNAÇÃO CUMULATIVA E INTERINA DE FUN CONFIANÇA (DESIGNAÇÃO/DISPENSA)
   -- 220	SUBSTITUIÇÃO CUMUL DE FC  MAIOR  OU  IGUAL 07 DIAS (DESIGNAÇÃO/DISPENSA)
   -- 238	DESIGNAÇÃO DE DIRETOR NÃO EMPREGADO (DESIGNAÇÃO/DISPENSA)
   -- 240	DESIGNAÇÃO DE PRESIDENTE NÃO EMPREGADO (DESIGNAÇÃO/DISPENSA)
   for r_ocorr in c_ocorr
   loop
      p_matricula := r_ocorr.oem_emp_numero_matricula;
      if r_ocorr.oem_ofu_codigo in (85,86,93) then
         if r_ocorr.emp_tipo_remuneracao_funcao = 'RG' then
	 	         -- Se o empregado tiver a ocorrência 85 (DESIGNAÇÃO CUMULATIVA DE FUNÇÃO DE CONFIANÇA),
	 	         -- 86 (DESIGNAÇÃO DE FUNÇÃO DE CONFIANÇA) ou 93 (DESIGNAÇÃO INTERINA DE FUNÇÃO DE CONFIANÇA)
	 	         -- e o empregado tiver optado por RG então atualiza os dias de proporcionalidade da
	 	         -- rubrica 1010 (REMUNERAÇÃO GLOBAL) para 30 e os da rubrica 1000 (SALÁRIO-BASE) para 0
            Atualiza_proporcionalidade (r_ocorr.oem_fun_codigo, 30, 1010, p_matricula, 999);
            Atualiza_proporcionalidade (null, 0, 1000, p_matricula, 999);
         else
	 	         -- Se o empregado tiver a ocorrência 85 (DESIGNAÇÃO CUMULATIVA DE FUNÇÃO DE CONFIANÇA),
	 	         -- 86 (DESIGNAÇÃO DE FUNÇÃO DE CONFIANÇA) ou 93 (DESIGNAÇÃO INTERINA DE FUNÇÃO DE CONFIANÇA)
	 	         -- e o empregado não tiver optado por RG então atualiza os dias de proporcionalidade da
	 	         -- rubrica 1015 (FUNÇÃO GRATIFICADA) para 30
            Atualiza_proporcionalidade (r_ocorr.oem_fun_codigo, 30, 1015, p_matricula, 999);
            Atualiza_proporcionalidade (null, 30, 1000, p_matricula, 999);
         end if;
      elsif r_ocorr.oem_ofu_codigo in (217) then
	 	      -- Se o empregado tiver a ocorrência 217 (DESIGNAÇÃO CUMULATIVA E INTERINA DE FUN CONFIANÇA)
	 	      -- atualiza os dias de proporcionalidade da rubrica 1030 (ACUMULAÇÃO FUNÇÃO DE CONFIANÇA) para 30
         Atualiza_proporcionalidade (r_ocorr.oem_fun_codigo, 30, 1030, p_matricula, 999);
      elsif r_ocorr.oem_ofu_codigo in (220) then
	 	      -- Se o empregado tiver a ocorrência 220 (SUBSTITUIÇÃO CUMUL DE FC  MAIOR  OU  IGUAL 07 DIAS)
	 	      -- atualiza os dias de proporcionalidade da rubrica 1030 (ACUMULAÇÃO FUNÇÃO DE CONFIANÇA)
         -- para o último dia do mês
         Atualiza_proporcionalidade (r_ocorr.oem_fun_codigo, v_dia_mes, 1030, p_matricula, 999);
      elsif r_ocorr.oem_ofu_codigo in (238,240) then
         -- Se o empregado tiver a ocorrência 238 (DESIGNAÇÃO DE DIRETOR NÃO EMPREGADO)
	 	      -- ou a 240 (DESIGNAÇÃO DE PRESIDENTE NÃO EMPREGADO) atualiza os dias de proporcionalidade
	 	      -- das rubricas 1065 (HONORÁRIO DIRETOR - NÃO EMPREGADO) e 1070 (GRATIFICAÇÃO CARGO ELETIVO)
	 	      -- para 30 dias
         Atualiza_proporcionalidade (r_ocorr.oem_fun_codigo, 30, 1065, p_matricula, 999);
         Atualiza_proporcionalidade (r_ocorr.oem_fun_codigo, 30, 1070, p_matricula, 999);
      elsif r_ocorr.oem_ofu_codigo in (125) then
	 	      -- Se o empregado tiver a ocorrência 125 (SUBSTITUIÇÃO DE FC MAIOR OU IGUAL A 07 DIAS)
	 	      -- atualiza os dias de proporcionalidade das rubricas 1060 (HONORÁRIO DIRETOR - EMPREGADO) e
	 	      -- 1070 (GRATIFICAÇÃO CARGO ELETIVO) para 30 dias e os dias de proporcionalidade da 1000 (SALÁRIO-BASE)
	 	      -- para 0 dias
         Atualiza_proporcionalidade (r_ocorr.oem_fun_codigo, 30, 1060, p_matricula, 999);
         Atualiza_proporcionalidade (r_ocorr.oem_fun_codigo, 30, 1070, p_matricula, 999);
         Atualiza_proporcionalidade (null,  0, 1000, p_matricula, 999);
      elsif r_ocorr.oem_ofu_codigo in (89) then
	 	      -- Se o empregado tiver a ocorrência 89 (SUBSTITUIÇÃO DE FC MAIOR OU IGUAL A 07 DIAS)
	 	      -- atualiza os dias de proporcionalidade da rubrica 1020 (SUBSTITUIÇÃO DE FUNÇÃO DE CONFIANÇA)
	 	      -- para o último dia do mês
         Atualiza_proporcionalidade (r_ocorr.oem_fun_codigo, v_dia_mes, 1020, p_matricula, 999);
      elsif r_ocorr.oem_ofu_codigo in (8) then
	 	      -- Se o empregado tiver a ocorrência 8 (MEMBRO DO CONSELHO FISCAL EFETIVO - NÃO EMPREGADO)
	 	      -- atualiza os dias de proporcionalidade da rubrica 1080 (REMUNERAÇÃO DE CONSELHEIRO - FISCAL)
	 	      -- para 30 dias
         Atualiza_proporcionalidade (r_ocorr.oem_fun_codigo, 30, 1080, p_matricula, 999);
      elsif r_ocorr.oem_ofu_codigo in (141) then
	 	      -- Se o empregado tiver a ocorrência 141 (MEMBRO DO CONSELHO DE ADMINISTRAÇÃO-NÃO EMPREGADO)
	 	      -- atualiza os dias de proporcionalidade da rubrica 1075 (REMUNERAÇÃO DE CONSELHEIRO - ADMINISTRAÇÃO)
	 	      -- para 30 dias
         Atualiza_proporcionalidade (r_ocorr.oem_fun_codigo, 30, 1075, p_matricula, 999);
      end if;
   end loop;

end; -- término trata_funcao
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
   dbms_output.enable(1000000);

   if par_versao = 1 and par_mes < 13 then

      begin         -- início do processo de tratamento de RCT e lançamento
                    -- das rubricas permanentes e/ou parcelamentos.

         v_mes_anterior := to_number(to_char(add_months(to_date(to_char(par_mes)||
                           '/'||to_char(par_ano),'MM/YYYY'),-1),'MM'));
         v_ano_anterior := to_number(to_char(add_months(to_date(to_char(par_mes)||
                           '/'||TO_CHAR(par_ano),'MM/YYYY'),-1),'YYYY'));
         v_mes_ant_rct := to_number(to_char(add_months(to_date(to_char(par_mes)||
                          '/'||to_char(par_ano),'MM/YYYY'),-2),'MM'));
         v_ano_ant_rct := to_number(to_char(add_months(to_date(to_char(par_mes)||
                          '/'||to_char(par_ano),'MM/YYYY'),-2),'YYYY'));

         -- data do 1º dia do mês atual
         v_data_mes :=
            to_date(to_char(par_ano)||lpad(to_char(par_mes),2,'0')||'01','yyyymmdd');
         -- último dia do mês atual
         v_dia_mes  :=  to_number(to_char(last_day(v_data_mes),'DD'));

         trata_rct;
         Gerar_movimentacao;
         trata_ferias;
         trata_pericul;
         trata_funcao;

      end;          -- término do processo de tratamento de RCT e lançamento das rubricas
                    -- de permanentes e/ou parcelamentos, bem como os empregados afastados.

   end if;

   -- Lançamento de Movimentação de 13o. Salário --
   if par_list_13 = 'A' then -- Adiantamento 13o. Salário
      v_rub_seq_pagamento := busca_rub_seq_pagto(1295);
      -- ADIANTAMENTO_13
      -- Busca todos os empregados ativos da dependência que está sendo aberta
      -- que possuem saldo igual a zero para a rubrica 1295 (ADIANTAMENTO DE 13º SALÁRIO)
      -- dentro do ano de abertura da folha e mês menor do que o da abertura
      for r_adi_13 in adiantamento_13
      loop
         -- Insere a rubrica 1295 (ADIANTAMENTO DE 13º SALÁRIO)
         -- no mês/ano da folha que está sendo aberta
         insere_movimentacao(par_ano,par_mes,par_versao,r_adi_13.emp_numero_matricula,
                             1295,1,null,1,1,null,null,null,'N',null,null,null,'N',
                             null,v_rub_seq_pagamento,'N',null,null,null,null,'S',
                             30,null,'N',r_adi_13.emp_dep_codigo_pagto);
         par_num_mov := nvl(par_num_mov,0) + 1;
      end loop;
   elsif par_list_13 = 'F' then -- 13o. Salário - Parcela Final
      v_cont := 1;
      -- FINAL_13
      -- Busca todos os empregados ativos e afastados da dependência que está sendo aberta
      for r_final_13 in final_13
      loop
         Begin
            -- Joga na variável "v_valor_final" o valor total da rubrica 1295 (ADIANTAMENTO DE 13º SALÁRIO)
            select nvl(sum(to_number(decode(rub.rub_tipo_rubrica||
                       mov.mov_tip_rubrica,'RN','+','RD','+','RE','-',
                       'DN','-','DD','-','DE','+')||
                       to_char(nvl(mov.mov_valor,0)))),0)
            into   v_valor_final
            from   movimentacao mov, rubricas rub
            where  rub.rub_codigo               = mov.mov_rub_codigo
            and    rub.rub_codigo               = 1295
            and    mov.mov_ano_referencia       = par_ano
            and    mov.mov_versao_pagamento     = par_versao
            and    mov.mov_emp_numero_matricula = r_final_13.emp_numero_matricula;
         Exception
            when no_data_found then
                v_valor_final := 0;
         End;
         if par_mes = 13 then
            if v_valor_final > 0 then
               v_cont := 1; -- Empregado já recebeu 1295 (ADIANTAMENTO DE 13º SALÁRIO)
            else
               v_cont := 2; -- Empregado não recebeu 1295 (ADIANTAMENTO DE 13º SALÁRIO)
            end if;
         else
            v_cont := 3;
         end if;
         loop
            exit when v_cont > 6;
            if v_cont = 1 then -- Lança rubrica 5350 (DESCONTO ADIANTAMENTO 13. SALÁRIO)
                               -- quando o empregado já recebeu o adiantamento de 13º salário
               v_rubrica     := 5350;
               v_ind_calculo := 'N';
               v_parametro   := 'V';
               v_rub_seq_pagamento := busca_rub_seq_pagto(5350);
            elsif v_cont = 2 then -- Lança rubrica 1900 (CÁLCULO FGTS)
               v_rubrica     := 1900;
               v_valor_final := null;
               v_ind_calculo := 'N';
               v_parametro   := null;
               v_rub_seq_pagamento := busca_rub_seq_pagto(1900);
            elsif v_cont = 3 then -- Lamça rubrica 1340 (13º SALÁRIO)
                                  -- quando o mês de calculo for diferente de 13
               -- Parâmetros para inclusão de rubrica de pagamento 1340 (13º SALÁRIO)
               v_rubrica     := 1340;
               v_valor_final := null;
               v_ind_calculo := 'N';
               v_parametro   := null;
               v_rub_seq_pagamento := busca_rub_seq_pagto(1340);
            elsif v_cont = 4 then
               -- Parâmetros para inclusão de rubrica de pagamento 1345 (ADICIONAL PROPORCIONAL 13º SALÁRIO)
               v_rubrica     := 1345;
               v_valor_final := null;
	           v_ind_calculo := 'N';
               v_parametro   := null;
               v_rub_seq_pagamento := busca_rub_seq_pagto(1345);
            elsif v_cont = 5 then
               -- Parâmetros para inclusão de rubrica de pagamento 5060 (CONTRIBUIÇÃO PREVIDENCIÁRIA S/ 13º SALÁRIO)
               v_rubrica     := 5060;
               v_valor_final := null;
               v_ind_calculo := 'N';
   		       v_parametro   := null;
               v_rub_seq_pagamento := busca_rub_seq_pagto(5060);
            elsif v_cont = 6 then
               -- Parâmetros para inclusão de rubrica de pagamento 5105 (IMPOSTO DE RENDA - S/ 13. SALÁRIO)
               v_rubrica     := 5105;
               v_valor_final := null;
               v_ind_calculo := 'N';
               v_parametro   := null;
               v_rub_seq_pagamento := busca_rub_seq_pagto(5105);
            end if;
            --
            v_sequencial := busca_mov_seq(par_mes,par_ano,par_versao,
                              r_final_13.emp_numero_matricula,v_rubrica,'N');
            --
            insere_movimentacao(par_ano,par_mes,par_versao,r_final_13.emp_numero_matricula,
                                v_rubrica,v_sequencial,null,1,1,v_parametro,v_valor_final,
                                v_valor_final,'N',null,null,NULL,v_ind_calculo,
                                null,v_rub_seq_pagamento,null,nu_ll,null,null,
                                v_valor_final,'N',30,null,'N',
                                r_final_13.emp_dep_codigo_pagto);
            v_cont := v_cont + 1;
            par_num_mov := nvl(par_num_mov,0) + 1;
         end loop;
      end loop;

      -- Inclusão de rubrica de pagamento 5510 (PENSÃO ALIMENTÍCIA SOBRE 13. SALÁRIO)
      v_rub_seq_pagamento := busca_rub_seq_pagto(5510);
      -- PEN_ALI_13
      -- Busca todos os pensionistas dos empregados ativos e afastados da dependência parâmetro
      -- com indicador de 13º salário marcado e tipo de pensão = 'A' (alimentícia)
      for r_pen_13 in pen_ali_13
      loop
         v_sequencial := busca_mov_seq(par_mes,par_ano,par_versao,
                                       r_pen_13.pen_emp_numero_matricula,5510,'N');
         insere_movimentacao(par_ano,par_mes,par_versao,r_pen_13.pen_emp_numero_matricula,
                             5510,v_sequencial,r_pen_13.pen_for_codigo_13,1,1,null,
                             r_pen_13.pen_mov_parametro_13,null,'N',null,null,
                             r_pen_13.pen_codigo,'N',null,v_rub_seq_pagamento,
                             null,null,null,null,null,'N',30,null,'N',
                             r_pen_13.emp_dep_codigo_pagto);
         par_num_mov := nvl(par_num_mov,0) + 1;
      end loop;

      -- Inclusão de rubrica de pagamento 5525 (PENSÃO INDENIZATÓRIA SOBRE 13.)
      v_rub_seq_pagamento := busca_rub_seq_pagto(5525);
      -- PEN_INDE_13
      -- Busca todos os pensionistas dos empregados ativos da dependência parâmetro
      -- com indicador de 13º salário marcado e tipo de pensão = 'I' (indenizatória)
      for r_inde_13 in pen_inde_13
      loop
         v_sequencial := busca_mov_seq(par_mes,par_ano,par_versao,
                                       r_inde_13.pen_emp_numero_matricula,5525,'N');
         insere_movimentacao(par_ano,par_mes,par_versao,r_inde_13.pen_emp_numero_matricula,
                             5525,v_sequencial,r_inde_13.pen_for_codigo_13,1,1,null,
                             r_inde_13.pen_mov_parametro_13,null,'N',null,null,
                             r_inde_13.pen_codigo,'N',null,v_rub_seq_pagamento,
                             null,null,null,null,null,'N',30,null,'N',
                             r_inde_13.emp_dep_codigo_pagto);
         par_num_mov := nvl(par_num_mov,0) + 1;
      end loop;

      if par_mes = 13 then
         -- Inclusão de rubrica de pagamento 5135 (CONTRIBUIÇÃO SINDICAL - ASSOCIATIVA)
         v_rub_seq_pagamento := busca_rub_seq_pagto(5135);
         -- CONT_ASSOCIATIVA
         for r_ass in cont_associativa
         loop
            v_sequencial := busca_mov_seq(par_mes,par_ano,par_versao,
                                          r_ass.emp_numero_matricula,5135,'N');
            insere_movimentacao(par_ano,par_mes,par_versao,r_ass.emp_numero_matricula,
                                5135,v_sequencial,null,1,1,null,null,null,'N',null,null,
                                null,'N',null,v_rub_seq_pagamento,
                                null,null,null,null,null,'N',30,null,'N',
                                r_ass.emp_dep_codigo_pagto);
            par_num_mov := nvl(par_num_mov,0) + 1;
         end loop;
      end if;

   end if; -- Fim do Lançamento de 13o. Salário

   if par_sindical = 'S' then

   -- Selecionando sequência da rubrica de pagamento 5130 (CONTRIBUIÇÃO SINDICAL ANUAL)
      v_rub_seq_pagamento := busca_rub_seq_pagto(5130);
      -- CONT_SINDICAL
      -- Busca todos os empregados ativos da dependência que está sendo aberta
      -- com indicador de contribuição sindical anual = 'S' e que não possuam a rubrica 5130
      -- lançada para o ano que está sendo aberto
      for r_cont_sindical in cont_sindical
      loop
         v_sequencial := busca_mov_seq(par_mes,par_ano,par_versao,
                                       r_cont_sindical.emp_numero_matricula,5130,'N');
         insere_movimentacao(par_ano,par_mes,par_versao,r_cont_sindical.emp_numero_matricula,
                             5130,v_sequencial,null,1,1,null,null,null,'N',null,null,null,'N',null,
                             v_rub_seq_pagamento,null,null,null,null,null,'N',30,
                             null,null,r_cont_sindical.emp_dep_codigo_pagto);
         par_num_mov := nvl(par_num_mov,0) + 1;
      end loop;
   end if;

   if par_confederativa = 'S' then

   -- Selecionando sequência da rubrica de pagamento 5140 (CONTRIBUIÇÃO CONFEDERATIVA)
        v_rub_seq_pagamento := busca_rub_seq_pagto(5140);
      -- CONT_CONFEDERATIVA
      -- Busca todos os empregados ativos da dependência que está sendo aberta
      -- com indicador de contribuição federativa = 'S' e que não possuam a rubrica 5140
      -- lançada para o ano que está sendo aberto
      for r_cont_conf in cont_confederativa
      loop
         /* *** Verificar ***
         v_sequencial := busca_mov_seq(par_mes,par_ano,par_versao,
                                 r_cont_conf.emp_numero_matricula,5140,'N'); */

         insere_movimentacao(par_ano,par_mes,par_versao,r_cont_conf.emp_numero_matricula,
                             5140, /*v_sequencial*/1,null,1,1,null,null,null,'N',null,null,null,'N',
                             null,v_rub_seq_pagamento,null,null,null,null,null,'N',
                             30,null,null,r_cont_conf.emp_dep_codigo_pagto);
         par_num_mov := nvl(par_num_mov,0) + 1;
      end loop;
   end if;

End;
/
