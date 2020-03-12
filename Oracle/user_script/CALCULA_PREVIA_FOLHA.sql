create or replace procedure ifrsrh_folha.calcula_previa(par_mes_calculo number,
                     	 par_ano_calculo number,
                    	 par_versao      number,
                		 par_dep_codigo  number,
            		     par_matricula   number,
                		 par_valor_fgts  in out number) is
----------------------------------------------------------------------
-- Procedure que calcula a prévia dos valores das rubricas na       --
-- movimentação do empregado, no mês/ano-versão                     --
--                                                                  --
-- Criada 	        em 09/01/1998                                   --
--                                                                  --
--                                                                  --
-- AUTORES : Marcos Perdigão - Grupo IOS                            --
--           Gelmires Luiz   - Grupo IOS                            --
--           Toninho         - Grupo IOS                            --
--                                                                  --
----------------------------------------------------------------------
  v_empregado              ifrsrh_folha.empregados_pagamentos%rowtype;
  cursor c_cadastros (p_matricula number) is
    select emp_sfu_codigo,
           emp_data_admissao,
           emp_nsa_codigo_nivel,
           emp_nsa_codigo_padrao,
           emp_nsa_in_nivel_escolaridade,
           emp_qfu_fun_codigo,
           emp_tipo_remuneracao_funcao
    from   ifrsrh_folha.cadastros
    where  emp_numero_matricula = p_matricula;
  
  cursor c_mov_dep is
    select mov.mov_ano_referencia, mov.mov_mes_referencia, mov.mov_versao_pagamento,
           mov.mov_emp_numero_matricula, mov.mov_rub_codigo, mov.mov_sequencial,
           mov.mov_for_codigo, mov.mov_parcela, mov.mov_parcela_atual,
           mov.mov_tipo_parametro, mov.mov_parametro, mov.mov_valor, mov.mov_tip_rubrica,
           mov.mov_mes_ref_diferenca, mov.mov_ano_ref_diferenca, mov.mov_pen_codigo,
           mov.mov_ind_calculo, mov.mov_rub_seq_pagamento, mov.mov_valor_integral,
           mov.mov_dias_proporcionalidade, mov.mov_fun_codigo, mov.mov_tipo_funcao,
           mov.mov_nsa_codigo_nivel, mov.mov_nsa_codigo_padrao,
           mov.mov_oem_emp_numero_matricula, mov.mov_oem_ofu_codigo, mov.mov_oem_data_inicio,
           mov.mov_nsa_indicador_nivel_escola, mov.ROWID
    from   ifrsrh_folha.movimentacao mov
    where  mov.mov_ano_referencia       = par_ano_calculo
    and    mov.mov_mes_referencia       = par_mes_calculo
    and    mov.mov_versao_pagamento     = par_versao
    and    mov.mov_emp_dep_codigo_pagto = par_dep_codigo
    and    nvl(mov.mov_ind_lancamento_liq_negat,'N') = 'N'
    order  by mov.mov_emp_numero_matricula,
              mov.mov_rub_seq_pagamento,
              mov.mov_tip_rubrica,
              mov.mov_rub_codigo,
              mov.mov_sequencial;
  cursor c_mov_mat is
    select mov.mov_ano_referencia, mov.mov_mes_referencia, mov.mov_versao_pagamento,
           mov.mov_emp_numero_matricula, mov.mov_rub_codigo, mov.mov_sequencial,
           mov.mov_for_codigo, mov.mov_parcela, mov.mov_parcela_atual,
           mov.mov_tipo_parametro, mov.mov_parametro, mov.mov_valor, mov.mov_tip_rubrica,
           mov.mov_mes_ref_diferenca, mov.mov_ano_ref_diferenca, mov.mov_pen_codigo,
           mov.mov_ind_calculo, mov.mov_rub_seq_pagamento, mov.mov_valor_integral,
           mov.mov_dias_proporcionalidade, mov.mov_fun_codigo, mov.mov_tipo_funcao,
           mov.mov_nsa_codigo_nivel, mov.mov_nsa_codigo_padrao,
           mov.mov_oem_emp_numero_matricula, mov.mov_oem_ofu_codigo, mov.mov_oem_data_inicio,
           mov.mov_nsa_indicador_nivel_escola, mov.ROWID
    from   ifrsrh_folha.movimentacao mov
    where  mov.mov_ano_referencia       = par_ano_calculo
    and    mov.mov_mes_referencia       = par_mes_calculo
    and    mov.mov_versao_pagamento     = par_versao
    and    mov.mov_emp_dep_codigo_pagto = par_dep_codigo
    and    mov.mov_emp_numero_matricula = par_matricula
    and    nvl(mov.mov_ind_lancamento_liq_negat,'N') = 'N'
    order  by mov.mov_emp_numero_matricula,
              mov.mov_rub_seq_pagamento,
              mov.mov_tip_rubrica,
              mov.mov_rub_codigo,
              mov.mov_sequencial;
  cursor c_inss is
    select fai_lim_superior, fai_per_desc_empr
    from   ifrsrh_folha.faixas_inss
    order  by fai_lim_superior;

  r_inss        c_inss%rowtype;
  type array_inss is table of c_inss%rowtype
  index by binary_integer;
  --
  arinss array_inss;
    
  cursor c_salfam is
    select saf_renda_maxima, saf_valor
    from   ifrsrh_folha.salario_familia
    order  by saf_renda_maxima;
  
  r_salfam        c_salfam%rowtype;
  type array_salfam is table of c_salfam%rowtype
  index by binary_integer;
  --
  arsalfam array_salfam;
    
  cursor c_infraprev is
    select ars_plano, ars_faixa, ars_valor, ars_percentual, ars_mes, ars_ano
    from   ifrsrh_folha.faixa_arsaprev
    order  by ars_plano, ars_faixa;

  r_infraprev        c_infraprev%rowtype;
  type array_infraprev is table of c_infraprev%rowtype
  index by binary_integer;
  --
  arinfraprev array_infraprev;
    
  cursor c_irrf is
    select imr_renda_maxima, imr_valor_a_deduzir, imr_aliquota, imr_vlr_deducao_dep
    from   ifrsrh_folha.impostos_rendas
    order  by imr_renda_maxima;
    
  r_irrf        c_irrf%rowtype;
  type array_irrf is table of c_irrf%rowtype
  index by binary_integer;
  --
  arirrf array_irrf;
    
  r_mov                     c_mov_dep%rowtype;
  v_matricula_anterior      ifrsrh_folha.cadastros.emp_numero_matricula%type;
  v_formula                 varchar2(600);
  v_formula_com_valores     varchar2(800);
  v_operador                char(1);
  v_operando                varchar2(20);
  v_coluna_chave            varchar2(30);
  v_liquido                 number(14,2) := 0; -- Sal. líquido
  v_liquido_ant             number(14,2) := 0; -- Sal. líquido anterior
  v_valor_operando          number(14,5);
  v_valor_rubrica           number(14,2);
  v_mes_anterior            number(2);
  v_ano_anterior            number(4);
  v_anuenio                 ifrsrh_folha.movimentacao.mov_parametro%type;
  v_funcao                  ifrsrh_folha.movimentacao.mov_fun_codigo%type;
  v_valor_infra_emp         number;
  v_rub_codigo              number(4)    := NULL;
  v_base_inss               number(14,2) := 0;  -- BASE DE CALCULO DO INSS
  v_valor_5060              number(14,2) := 0;  -- BASE DE INSS 5060
  v_base_inss_cal           number(14,2) := 0;  -- BASE DE CALCULO DO INSS
  v_faixa_inss              ifrsrh_folha.faixas_inss.fai_per_desc_empr%TYPE;
  v_base_irrf               number(14,2) := 0;  -- BASE DE CALCULO DO IR
  v_base_irrf_13            number(14,2) := 0;  -- BASE DE CALCULO DO IR 13º
  v_base_irrf_ferias        number(14,2) := 0;  -- BASE DE CALCULO DO IR FÉRIAS
  v_egt_base_irrf           number(14,2) := 0;  -- BASE DE CALCULO DO IR SOBRE ABONO
  v_base_fgts               number(14,2) := 0;  -- BASE DE CALCULO DO FGTS
  v_base_fgts_sem_13        number(14,2) := 0;  -- BASE DE CALCULO DO FGTS
  v_base_fgts_13            number(14,2) := 0;  -- BASE DE CALCULO DO FGT
  v_deducaodep              number(14,2) := 0;  -- DEDUCAO POR DEPENDENTE
  v_numdepir                number(2)    := 0;  -- NÚMERO DE DEPENDENTES
  v_parcela_deduzir         number(11,2) := 0;  -- VALOR A DEDUZIR DO IR
  v_teto_salfam             number(14,2) := 0;  -- TETO DO SALÁRIO FAMÍLIA
  v_salcont_infraprev       number(14,2) := 0;  -- SALÁRIO DE CONTRIBUIÇÃO DO INFRAPREV
  v_base_infraprev          number(14,2) := 0;  -- BASE DE CALCULO DO INFRAPREV
  v_cont_infraprev          number(14,2) := 0;  -- VALOR DA CONTRIBUIÇÃO DO INFRAPREV
  v_teto_infraprev          number(14,2) := 0;  -- VALOR DO TETO MÁXIMO PARA CALCULO DO INFRAPREV
  v_valor_aux               number(11,2) := 0;
  v_valor_1010              number(11,2) := 0;
  v_valor_1015              number(11,2) := 0;
  v_valor_1085              number(11,2) := 0;
  v_valor_1090              number(11,2) := 0;
  v_valor_13_ferias         number(11,2) := 0;
  v_ano_mes_ini             number;
  v_ano_mes_fim             number;
  v_mes_ant                 number;
  v_ano_ant                 number;
  v_tipo_remuneracao        varchar2(2);
  v_valor_dia               number(11,2) := 0;
  v_dias_proporcionalidade  number(2) := 0;
  v_dt_inicio_ocor          date;
  v_dt_termino_ocor         date;
  v_dt_inicio_periodo_aquis    date;
  v_dt_termino_periodo_aquis   date;
  v_conta                   number;
  v_fator_proporcional      number(5,3) := 0;
  v_dias_uteis              ifrsrh_folha.previsao_pagamento.ppa_dias_uteis%TYPE; -- NUMERO DE DIAS UTEIS NO MES
  v_num_dias                number(02):= 0;
  v_fun_codigo              number(3) := 0;
  v_tipo_funcao             varchar2(2);
  v_valor_func_sub          number(10,2) := 0;
  v_valor_func_tit          number(10,2) := 0;
  v_valor_salario_sub       number(10,2) := 0;
  v_valor_salario_tit       number(10,2) := 0;
  v_diferenca_funcao        number(10,2) := 0;
  v_diferenca_salario       number(10,2) := 0;
  v_valor_subst             number(10,2) := 0;
  v_sfu_codigo              number(1);
  v_valor_rg                ifrsrh_folha.funcoes.cfv_valor_rg%type;
  v_valor_fg                ifrsrh_folha.funcoes.cfv_valor_fg%type;
  v_valor_salario           ifrsrh_folha.historico_niveis_salariais.hns_valor_remuneracao%type;
  v_funcao_titular          number(10,2) := 0;
  v_valor_rubricas          number(10,2) := 0;
  v_nsa_codigo_nivel        ifrsrh_folha.cadastros.emp_nsa_codigo_nivel%type;
  v_nsa_codigo_padrao       ifrsrh_folha.cadastros.emp_nsa_codigo_padrao%type;
  v_nsa_in_nivel_escolaridade ifrsrh_folha.cadastros.emp_nsa_in_nivel_escolaridade%type;  
  v_tipo_remuneracao_funcao ifrsrh_folha.cadastros.emp_tipo_remuneracao_funcao%type;
  v_infra_emp               number(10,2) := 0;
  v_indice_beneficio        number(12,6) := 0;
  v_data_admissao           date;
  v_valor_funcao            number;
  v_erro                    varchar2(300);
--
--  Tratamento de array para manter a tabela constantes legais.
--
  cursor c_constant is
     select col_codigo, col_valor
     from   ifrsrh_folha.constantes_legais;
     
  r_constant        c_constant%rowtype;
  type array_constant is table of c_constant%rowtype
  index by binary_integer;
      --
  ar array_constant;
  v_vale            number := 0;
--------------------------------------------------------------------------
--                      GRAVA ERROS NO EVENTO_FOLHA                        --
--------------------------------------------------------------------------
Procedure grava_log_erro is
Begin
  v_erro := sqlcode||' - '||sqlerrm;
  null;
/*  insert into ifrsrh_folha.EVENTO_FOLHA( evf_mes_referencia,evf_ano_referencia,evf_versao_pagamento,
                         evf_rub_codigo,evf_emp_numero_matricula,evf_mensagem,
                         evf_cdr_cod_rotina,evf_data_evento)
  values (r_mov.mov_mes_referencia, r_mov.mov_ano_referencia, r_mov.mov_versao_pagamento,
          r_mov.mov_rub_codigo, r_mov.mov_emp_numero_matricula, v_erro,
          '6', sysdate);*/
End;

--------------------------------------------------------------------------
--         Atribui valor ao operando de acordo com a rubrica            --
--------------------------------------------------------------------------
Procedure Obtem_valor_operando (p_rubrica number) is
Begin
  select nvl(sum(to_number(decode(rub_tipo_rubrica||mov.mov_tip_rubrica,
                 'RN','+','RD','+','RE','-','DN','-','DD','-','DE','+')||
                 to_char(nvl(mov.mov_valor,0)))),0)
  into   v_valor_operando
  from   ifrsrh_folha.movimentacao mov, rubricas
  where  mov.mov_ano_referencia           = r_mov.mov_ano_referencia
  and    mov.mov_mes_referencia           = r_mov.mov_mes_referencia
  and    mov.mov_versao_pagamento         = r_mov.mov_versao_pagamento
  and    mov.mov_emp_numero_matricula     = r_mov.mov_emp_numero_matricula
  and    nvl(mov.mov_ind_lancamento_liq_negat,'N') = 'N'
  and    mov.mov_rub_codigo           = rub_codigo
  and    mov.mov_rub_codigo in
        (select iru_rub_codigo_incide
         from   incidencias_rubricas
         where  iru_rub_codigo = p_rubrica
         and  ((mov.mov_tip_rubrica = 'N' and iru_tip_normal      = 'S') or
               (mov.mov_tip_rubrica = 'D' and iru_tip_diferenca   = 'S') or
               (mov.mov_tip_rubrica = 'E' and iru_tip_estorno_dev = 'S')));
Exception
  when others then
     grava_log_erro;
End;

--------------------------------------------------------------------------
--                 Atribui valor ao operando SOMARUBINC                 --
--------------------------------------------------------------------------
Procedure Obtem_valor_somarubinc is
Begin
  v_valor_operando := 0;
  Obtem_valor_operando(v_rub_codigo);
  if v_rub_codigo = 1900 then  -- rubrica de FGTS
     v_base_fgts := v_valor_operando;
  end if;
  if v_rub_codigo = 1901 then
     v_base_fgts_13 := v_valor_operando;
  end if;
  if v_rub_codigo = 1908 then
     v_base_fgts_sem_13 := v_valor_operando;
  end if;
  if r_mov.mov_rub_codigo in (5067,5092) then  -- rubrica de INFRAPREV PLANO CDFGTS
     v_salcont_infraprev := v_valor_operando;
  end if;
  if r_mov.mov_rub_codigo in (5937,5938,5939) and v_valor_operando < 0 then -- rubrica de MARGEM CONSIGNÁVEL
  	 v_valor_operando := (v_valor_operando * -1);
  end if;
Exception
  when others then
     grava_log_erro;
End;
--------------------------------------------------------------------------
--                 Atribui valor ao operando SOMARUBDES                 --
--------------------------------------------------------------------------
Procedure Obtem_valor_somarubdes is
Begin
  Obtem_valor_operando (v_rub_codigo);
  
  if v_rub_codigo = 1900 then  -- rubrica de FGTS
     v_base_fgts := v_valor_operando;
  end if;
  if v_rub_codigo = 1901 then
     v_base_fgts_13 := v_valor_operando;
  end if;
  if v_rub_codigo = 1908 then
     v_base_fgts_sem_13 := v_valor_operando;
  end if;
Exception
  when others then
     grava_log_erro;
End;
--------------------------------------------------------------------------
--                 Atribui valor ao operando VALRUB                     --
--------------------------------------------------------------------------
Procedure Obtem_valor_valrub is
Begin
  select nvl(sum(nvl(mov.mov_valor,0)),0),
         nvl(sum(nvl(mov.mov_dias_proporcionalidade,0)),0)
  into   v_valor_operando, v_dias_proporcionalidade
  from   ifrsrh_folha.movimentacao mov
  where  mov.mov_ano_referencia       = r_mov.mov_ano_referencia
  and    mov.mov_mes_referencia       = r_mov.mov_mes_referencia
  and    mov.mov_versao_pagamento     = r_mov.mov_versao_pagamento
  and    mov.mov_emp_numero_matricula = r_mov.mov_emp_numero_matricula
  and    mov.mov_rub_codigo           = v_rub_codigo
  and    mov.mov_tip_rubrica          = r_mov.mov_tip_rubrica;
Exception
  when no_data_found then
    v_valor_operando         := 0;
    v_dias_proporcionalidade := 0;
  when others then
     grava_log_erro;
End;
--------------------------------------------------------------------------
--                 Atribui valor ao operando COMPULSO                   --
--------------------------------------------------------------------------
Procedure Obtem_valor_compulso is
Begin
  Obtem_valor_operando (5905);
  if v_valor_operando < 0 then
     v_valor_operando := (v_valor_operando * -1);
  end if;
Exception
  when others then
     grava_log_erro;
End;

--------------------------------------------------------------------------
--                 Atribui valor ao operando BASEINSS                   --
--------------------------------------------------------------------------
Procedure Obtem_valor_baseinss is
Begin
  Obtem_valor_operando(r_mov.mov_rub_codigo);
  v_base_inss := v_valor_operando;
  v_rub_codigo := 1993; -- BASE CÁLCULO INSS- AFASTAMENTO
  obtem_valor_valrub;
  v_base_inss_cal := v_base_inss - v_valor_operando;
  for i in arinss.first..arinss.last loop
    if arinss(i).fai_lim_superior >= v_base_inss_cal then
       v_valor_operando := v_base_inss_cal;
       exit;
    else
       v_valor_operando := arinss(i).fai_lim_superior;
    end if;
  end loop;
End;
--------------------------------------------------------------------------
--                 Atribui valor ao operando PERCINSS                   --
--------------------------------------------------------------------------
Procedure Obtem_valor_percinss is
Begin
  for i in arinss.first..arinss.last loop
    if arinss(i).fai_lim_superior >= v_base_inss_cal then
       v_valor_operando := arinss(i).fai_per_desc_empr;
       exit;
    else
       v_valor_operando := arinss(i).fai_per_desc_empr;
    end if;
  end loop;
  v_faixa_inss := v_valor_operando;
End;
--------------------------------------------------------------------------
--                 Atribui valor ao operando BASEIRRF                   --
--------------------------------------------------------------------------
Procedure Obtem_valor_baseirrf is
Begin
  Obtem_valor_operando (r_mov.mov_rub_codigo);
  v_base_irrf := v_valor_operando;
End;
--------------------------------------------------------------------------
--                 Atribui valor ao operando NUMDEPIR                   --
--------------------------------------------------------------------------
Procedure Obtem_valor_numdepir is
Begin
  v_valor_operando := nvl(v_empregado.egt_dependentes_ir,0);
  v_numdepir       := v_valor_operando;
End;
--------------------------------------------------------------------------
--                 Atribui valor ao operando TETOPREV                   --
--------------------------------------------------------------------------
Procedure Obtem_valor_tetoprev is
Begin
    v_valor_operando := arinss(arinss.last).fai_lim_superior;
End;
--------------------------------------------------------------------------
--                 Atribui valor ao operando DEDUCAODEP                 --
--------------------------------------------------------------------------
Procedure Obtem_valor_deducaodep is
Begin
  if v_deducaodep = 0 then
     v_valor_operando := arirrf(arirrf.last).imr_vlr_deducao_dep;
     v_deducaodep := v_valor_operando;
  else
     v_valor_operando := v_deducaodep;
  end if;
End;
--------------------------------------------------------------------------
--                 Atribui valor ao operando PERCIRRF                   --
--------------------------------------------------------------------------
Procedure Obtem_valor_percirrf is
  v_renda   	number(14,2);
Begin
  v_renda := (v_base_irrf - (nvl(v_deducaodep,0) * nvl(v_numdepir,0)));
  for i in arirrf.first..arirrf.last loop
    if arirrf(i).imr_renda_maxima >= v_renda then
       v_valor_operando  := arirrf(i).imr_aliquota;
       v_parcela_deduzir := arirrf(i).imr_valor_a_deduzir;
       exit;
    else
       v_valor_operando  := 0;
       v_parcela_deduzir := 0;
    end if;
  end loop;
  v_base_irrf := v_renda;
Exception
  when others then
     grava_log_erro;
End;
--------------------------------------------------------------------------
--               Atribui valor ao operando PARDEDUZIR                   --
--------------------------------------------------------------------------
Procedure Obtem_valor_pardeduzir is
Begin
  v_valor_operando := v_parcela_deduzir;
End;
--------------------------------------------------------------------------
--               Atribui valor ao operando VALTOTHE                     --
--------------------------------------------------------------------------
Procedure Obtem_valor_total_horas_extras is
Begin
  Obtem_valor_operando(1930);
  if v_valor_operando < 0 then
     v_valor_operando := 0;
  end if;    
End;
--------------------------------------------------------------------------
--                    PROCEDURE OBTEM_TETO_INFRAPREV                    --
--------------------------------------------------------------------------
Procedure Obtem_Teto_Infraprev (p_plano number) is
Begin
   for i in arinfraprev.first..arinfraprev.last  loop
     if p_plano = arinfraprev(i).ars_plano then
        if arinfraprev(i).ars_faixa = arinfraprev(arinfraprev.first).ars_faixa then
           v_teto_infraprev := arinfraprev(i).ars_valor;
           exit;
        end if;
     end if;
  end loop;

Exception
  when others then
     grava_log_erro;
End;
--------------------------------------------------------------------------
--                 Atribui valor ao operando CINFRAPREV                 --
--------------------------------------------------------------------------
Procedure Obtem_valor_cinfraprev is
Begin
  v_teto_infraprev := 0;
  Obtem_Teto_Infraprev (v_empregado.egt_plano_arsaprev);
  Obtem_valor_operando(r_mov.mov_rub_codigo);
  if v_salcont_infraprev < v_teto_infraprev then
     v_teto_infraprev := v_salcont_infraprev;
  end if;
  v_base_infraprev := v_teto_infraprev;
  v_cont_infraprev := 0;
  open c_infraprev;
  loop
    fetch c_infraprev into r_infraprev;
    exit when c_infraprev%notfound;
    if r_infraprev.ars_faixa = 1 and v_empregado.egt_plano_arsaprev = 2 then
       r_infraprev.ars_percentual := r_mov.mov_parametro;
    end if;
    if v_teto_infraprev >= r_infraprev.ars_valor then
       v_cont_infraprev := nvl(v_cont_infraprev,0) +
  		  ((v_base_infraprev*r_infraprev.ars_percentual)/100);
       v_base_infraprev := v_teto_infraprev - r_infraprev.ars_valor;
    else
       v_cont_infraprev := nvl(v_cont_infraprev,0) +
		  ((v_base_infraprev*r_infraprev.ars_percentual)/100);
       exit;
    end if;
  end loop;
  close c_infraprev;
  v_valor_operando := v_cont_infraprev;
Exception
  when others then
     grava_log_erro;
End;
--------------------------------------------------------------------------
--                 Atribui valor ao operando VALSALFAM                  --
--------------------------------------------------------------------------
Procedure Obtem_valor_valsalfam is
Begin
  if v_valor_salario is null then
     v_teto_salfam := v_valor_funcao;
  else
     v_teto_salfam := v_valor_salario;
  end if;
  v_teto_salfam := v_valor_salario;
  open c_salfam;
  loop
    fetch c_salfam into r_salfam;
    exit when c_salfam%notfound;
    if r_salfam.saf_renda_maxima >= v_teto_salfam then
       v_valor_operando := r_salfam.saf_valor;
       exit;
    else
       v_valor_operando := r_salfam.saf_valor;
    end if;
  end loop;
  close c_salfam;
Exception
  when others then
     grava_log_erro;
End;
--------------------------------------------------------------------------
--                 Atribui valor ao operando NUMDEPSF                   --
--------------------------------------------------------------------------
Procedure Obtem_valor_numdepsf is
Begin
   v_valor_operando := nvl(v_empregado.egt_dependentes_sal_fam,0);
End;
--------------------------------------------------------------------------
--                 Atribui valor ao operando NUMAVOS13                  --
--------------------------------------------------------------------------
Procedure Obtem_valor_numavos13 is
Begin
   v_valor_operando := nvl(v_empregado.egt_numero_mes_13,0);
End;
--------------------------------------------------------------------------
--                 Atribui valor ao operando PARAMETRO                  --
--------------------------------------------------------------------------
Procedure Obtem_valor_parametro is
Begin
  v_valor_operando := nvl(r_mov.mov_parametro,0);
End;
--------------------------------------------------------------------------
--                 Atribui valor ao operando VALFIXORUB                 --
--------------------------------------------------------------------------
Procedure Obtem_valor_valfixorub is
Begin
  select nvl(mov.mov_valor_integral,0)
  into   v_valor_operando
  from   ifrsrh_folha.movimentacao mov
  where  mov.mov_ano_referencia       = r_mov.mov_ano_referencia
  and    mov.mov_mes_referencia       = r_mov.mov_mes_referencia
  and    mov.mov_versao_pagamento     = r_mov.mov_versao_pagamento
  and    mov.mov_emp_numero_matricula = r_mov.mov_emp_numero_matricula
  and    mov.mov_rub_codigo           = v_rub_codigo
  and    mov.mov_tip_rubrica          = r_mov.mov_tip_rubrica;
Exception
  when no_data_found then
    v_valor_operando := 0;
  when others then
     grava_log_erro;
End;
--------------------------------------------------------------------------
--            Atribui valor integral ao v_valor_operando                --
--------------------------------------------------------------------------
Procedure Obtem_valor_integral_valrub is
Begin
  select nvl(sum(nvl(mov.mov_valor_integral,0)),0),
         nvl(sum(nvl(mov.mov_dias_proporcionalidade,0)),0)
  into   v_valor_operando, v_dias_proporcionalidade
  from   ifrsrh_folha.movimentacao mov
  where  mov.mov_ano_referencia       = r_mov.mov_ano_referencia
  and    mov.mov_mes_referencia       = r_mov.mov_mes_referencia
  and    mov.mov_versao_pagamento     = r_mov.mov_versao_pagamento
  and    mov.mov_emp_numero_matricula = r_mov.mov_emp_numero_matricula
  and    mov.mov_rub_codigo           = v_rub_codigo
  and    mov.mov_tip_rubrica          = r_mov.mov_tip_rubrica;
Exception
  when no_data_found then
    v_valor_operando := 0;
  when others then
     grava_log_erro;
End;
--------------------------------------------------------------------------
--                 Atribui valor ao operando PARRUB                     --
--------------------------------------------------------------------------
Procedure Obtem_valor_parrub is
Begin
  select mov.mov_parametro
  into   v_valor_operando
  from   ifrsrh_folha.movimentacao mov
  where  mov.mov_ano_referencia       = r_mov.mov_ano_referencia
  and    mov.mov_mes_referencia       = r_mov.mov_mes_referencia
  and    mov.mov_versao_pagamento     = r_mov.mov_versao_pagamento
  and    mov.mov_emp_numero_matricula = r_mov.mov_emp_numero_matricula
  and    mov.mov_rub_codigo           = v_rub_codigo
  and    mov.mov_tip_rubrica          = 'N';
Exception
  when no_data_found then
    v_valor_operando := 0;
  when others then
     grava_log_erro;
End;
--------------------------------------------------------------------------
--          Atribui valor ao operandos de CONSTANTES LEGAIS             --
--------------------------------------------------------------------------
Procedure Obtem_valor_constante (p_codigo in number) is
Begin
   for i in ar.first..ar.last  loop
       if p_codigo = ar(i).col_codigo then
          v_valor_operando := ar(i).col_valor;
          exit;
       end if;
   end loop;
Exception
  when others then
     grava_log_erro;
End;
--------------------------------------------------------------------------
--            Trata valor mínino para recolhimento de IRRF              --
--------------------------------------------------------------------------
Procedure Obtem_valor_irrf is
Begin
  obtem_valor_constante (16);
  if v_valor_rubrica <= v_valor_operando then
     v_liquido := v_liquido + v_valor_rubrica;
     v_valor_rubrica := 0;
  end if;
Exception
  when others then
     grava_log_erro;
End;
--------------------------------------------------------------------------
--  Atribui valor ao operando REMUGLOBAL, FUNGRATIFI e HONORADIR        --
--------------------------------------------------------------------------
Procedure Obtem_valor_funcao (p_fun_codigo number,
                              p_tipo_funcao varchar2 default null) is
   v_tipo_funcao1 varchar2(2);
Begin
  if p_tipo_funcao is null then
     v_tipo_funcao1 := r_mov.mov_tipo_funcao;
  else
     v_tipo_funcao1 := p_tipo_funcao;
  end if;
  if v_tipo_funcao1 = 'DI' then
     obtem_valor_constante (11);
  elsif v_tipo_funcao1 in ('RG','FG') then
     Begin
       select fun.cfv_valor_rg, fun.cfv_valor_fg
       into   v_valor_rg, v_valor_fg
       from   ifrsrh_folha.funcoes fun
       where  fun.fun_codigo     = p_fun_codigo;
     Exception
       when no_data_found then
         v_valor_operando := 0;
       when others then
         grava_log_erro;
     End;
     if v_tipo_funcao1 = 'RG' then
        v_valor_operando := nvl(v_valor_rg,0);
     elsif v_tipo_funcao1 = 'FG' then
        v_valor_operando := nvl(v_valor_fg,0);
     end if;
  else
     v_valor_operando := 0;
  end if;
  v_valor_funcao := v_valor_operando;
Exception
  when others then
     grava_log_erro;
End;
--------------------------------------------------------------------------
--                 Atribui valor ao operando DEDESCO                    --
--------------------------------------------------------------------------
Procedure Obtem_valor_dedesco is
Begin
  obtem_valor_funcao (r_mov.mov_fun_codigo);
  v_funcao_titular := v_valor_operando;
  -------------------------------------------------------------
  -- Busca o valor do salário base do empregado substituído  --
  -------------------------------------------------------------
  Begin
     select hns.hns_valor_remuneracao
     into   v_valor_salario_tit
     from   ifrsrh_folha.historico_niveis_salariais hns
     where  hns.hns_nsa_codigo_nivel           = r_mov.mov_nsa_codigo_nivel
     and    hns.hns_nsa_codigo_padrao          = r_mov.mov_nsa_codigo_padrao
     and    hns.hns_nsa_indicador_nivel_escola = r_mov.mov_nsa_indicador_nivel_escola;
  Exception
    when no_data_found then
       v_valor_salario_tit := 0;
    when others then
       grava_log_erro;
  End;
  v_valor_operando    := 0;
  v_valor_salario_sub := 0;
  v_rub_codigo        := 1000;
  obtem_valor_valrub;
  v_valor_salario_sub := v_valor_operando;
  v_rub_codigo := 1010;
  obtem_valor_valrub;
  v_valor_func_sub := nvl(v_valor_operando,0);
  if v_valor_func_sub = 0 then
     v_rub_codigo := 1015;
     obtem_valor_valrub;
     v_valor_func_sub := v_valor_operando;
  end if;
  if r_mov.mov_tipo_funcao = 'RG' then
     v_valor_operando := v_funcao_titular - (v_valor_salario_sub + v_valor_func_sub);
  elsif r_mov.mov_tipo_funcao = 'FG' then
     v_valor_operando := (v_valor_salario_tit + v_funcao_titular) -
                         (v_valor_salario_sub + v_valor_func_sub);
  end if;
  if v_valor_operando < 0 then
     v_valor_operando := 0;
  end if;
Exception
  when others then
     grava_log_erro;
End;
--------------------------------------------------------------------------
--                 Atribui valor ao operando CARGHORMEN                 --
--------------------------------------------------------------------------
Procedure Obtem_valor_carghormen is
Begin
  v_valor_operando := nvl(v_empregado.egt_carga_horaria_mes,0);
End;
--------------------------------------------------------------------------
--                 Atribui valor ao operando DIASUTEIS                 --
--------------------------------------------------------------------------
Procedure Obtem_valor_diasuteis is
Begin
  if r_mov.mov_mes_referencia = 01 then
     v_mes_anterior := 12;
     v_ano_anterior := r_mov.mov_ano_referencia - 1;
  elsif r_mov.mov_mes_referencia = 13 then
     v_mes_anterior := 11;
     v_ano_anterior := r_mov.mov_ano_referencia;
  else
     v_mes_anterior := r_mov.mov_mes_referencia - 1;
     v_ano_anterior := r_mov.mov_ano_referencia;
  end if;
  v_num_dias := to_number(to_char(last_day(to_date(to_char(v_mes_anterior,'00')
     	        	   ||'/'||to_char(v_ano_anterior,'0000'),'MM/YYYY')),'DD'));
  Begin
    select ppa.ppa_dias_uteis
    into   v_valor_operando
    from   ifrsrh_folha.previsao_pagamento ppa
    where  ppa.ppa_ano_pagamento = v_ano_anterior
    and    ppa.ppa_mes_pagamento = v_mes_anterior;
  Exception
    when no_data_found then
      v_valor_operando := 0;
    when others then
      grava_log_erro;
  End;
  v_dias_uteis := v_valor_operando;
Exception
  when others then
     grava_log_erro;
End;
--------------------------------------------------------------------------
--                 Atribui valor ao operando DIASNUTEIS                --
--------------------------------------------------------------------------
Procedure Obtem_valor_diasnuteis is
Begin
  if nvl(v_dias_uteis ,0) = 0 then
     Begin
       select (v_num_dias - ppa.ppa_dias_uteis)
       into    v_valor_operando
       from    ifrsrh_folha.previsao_pagamento ppa
       where   ppa.ppa_ano_pagamento = v_ano_anterior
       and     ppa.ppa_mes_pagamento = v_mes_anterior;
     Exception
       when no_data_found then
         v_valor_operando := 0;
       when others then
         grava_log_erro;
     End;
  else
     v_valor_operando := v_num_dias - v_dias_uteis;
  end if;
Exception
  when others then
     grava_log_erro;
End;
--------------------------------------------------------------------------
--                 Atribui valor ao operando SALARIOBAS                 --
--------------------------------------------------------------------------
Procedure Obtem_valor_salariobas(p_nivel        in number default null,
                                 p_padrao       in varchar2 default null,
                                 p_escolaridade in varchar2 default null) is
Begin
  if v_sfu_codigo = 1 then
     Begin
       select hns.hns_valor_remuneracao
       into   v_valor_salario
       from   ifrsrh_folha.historico_niveis_salariais hns
       where  hns.hns_nsa_codigo_nivel           = nvl(p_nivel,v_nsa_codigo_nivel)
       and    hns.hns_nsa_codigo_padrao          = nvl(p_padrao,v_nsa_codigo_padrao)
       and    hns.hns_nsa_indicador_nivel_escola = nvl(p_escolaridade,v_nsa_in_nivel_escolaridade);
     Exception
       when no_data_found then
         v_valor_salario := 0;
       when others then
         grava_log_erro;
     End;
     v_valor_operando := v_valor_salario;
  elsif (v_sfu_codigo = 2  or v_sfu_codigo = 4) then
     obtem_valor_funcao (r_mov.mov_fun_codigo);
     v_valor_salario := v_valor_operando;
  end if;
Exception
  when others then
     grava_log_erro;
End;
--------------------------------------------------------------------------
--                   Atribui valor ao operando BACAFA                   --
--------------------------------------------------------------------------
Procedure Obtem_valor_bacafa is
Begin
  if v_sfu_codigo = 1 then
     Begin
       select hns.hns_valor_remuneracao
       into   v_valor_salario
       from   ifrsrh_folha.historico_niveis_salariais hns
       where  hns.hns_nsa_codigo_nivel           = v_nsa_codigo_nivel
       and    hns.hns_nsa_codigo_padrao          = v_nsa_codigo_padrao
       and    hns.hns_nsa_indicador_nivel_escola = v_nsa_in_nivel_escolaridade;
     Exception
       when no_data_found then
         v_valor_salario := 0;
       when others then
         grava_log_erro;
     End;
     Begin
        select mov_parametro
        into   v_anuenio
        from   ifrsrh_folha.movimentacao
        where  mov_ano_referencia       = par_ano_calculo
        and    mov_mes_referencia       = par_mes_calculo
        and    mov_versao_pagamento     = par_versao
        and    mov_emp_numero_matricula = r_mov.mov_emp_numero_matricula
        and    mov_rub_codigo           = 1005
        and    mov_tip_rubrica          = 'N';
     exception
        when no_data_found then
            v_anuenio := 1;
        when others then
            grava_log_erro;
     End;
     v_valor_operando := ((v_valor_salario) + ((v_valor_salario * v_anuenio) / 100));
  elsif (v_sfu_codigo = 2  or v_sfu_codigo = 4) then
     obtem_valor_funcao (v_funcao);
  end if;
Exception
  when others then
     grava_log_erro;
End;
--------------------------------------------------------------------------
--                 Calcula valor adicional                              --
--------------------------------------------------------------------------
Procedure calcula_valor_adicional is
Begin
  null;
Exception
  when others then
     grava_log_erro;
End;
--------------------------------------------------------------------------
--                 Atribui valor ao operando OBADI13                    --
--------------------------------------------------------------------------
Procedure Obtem_valor_obadi13 is
Begin
   v_ano_mes_ini := to_number(to_char(par_ano_calculo)||'01');
   v_ano_mes_fim := to_number(to_char(par_ano_calculo)||lpad(to_char(par_mes_calculo),2,'0'));
   calcula_valor_adicional;
Exception
  when others then
     grava_log_erro;
End;
--------------------------------------------------------------------------
--                 Atribui valor ao operando DIASFER                    --
--------------------------------------------------------------------------
Procedure obtem_total_dias_ferias is
Begin
  select mov_parametro
  into   v_valor_operando
  from   ifrsrh_folha.movimentacao
  where  mov_oem_emp_numero_matricula = r_mov.mov_emp_numero_matricula
  and    mov_oem_ofu_codigo           = r_mov.mov_oem_ofu_codigo
  and    mov_oem_data_inicio          = r_mov.mov_oem_data_inicio
  and    mov_tip_rubrica			  = 'N' -- Agregado em 20/08/2003
  and    mov_rub_codigo               = 1355
  and    mov_versao_pagamento         = par_versao;
Exception
  when no_data_found then
     v_valor_operando := 0;
  when others then
     grava_log_erro;
End;
--------------------------------------------------------------------------
--                 Atribui valor ao operando OBADIFERIA                 --
--------------------------------------------------------------------------
Procedure Obtem_valor_obadiferia is
Begin
   v_dt_inicio_ocor             := null;
   v_dt_termino_ocor            := null;
   v_dt_inicio_periodo_aquis    := null;
   v_dt_termino_periodo_aquis   := null;
   begin
      select oem_data_inicio, oem_data_termino
      into   v_dt_inicio_ocor, v_dt_termino_ocor
      from   ifrsrh_folha.ocorrencias_empregados
      where  oem_emp_numero_matricula = r_mov.mov_emp_numero_matricula
      and    oem_ofu_codigo    = 74;
   exception
      when no_data_found then
         insert into ifrsrh_folha.EVENTO_FOLHA
        		(evf_mes_referencia, evf_ano_referencia, evf_versao_pagamento,
        		 evf_rub_codigo, evf_emp_numero_matricula, evf_data_evento,
        		 evf_cdr_cod_rotina, evf_mensagem)
       	 values (par_mes_calculo, par_ano_calculo, par_versao, r_mov.mov_rub_codigo,
        		 r_mov.mov_emp_numero_matricula, sysdate, 6,
	             'Problemas ao tentar recuperar a ocorrência de férias.');
      when others then
         grava_log_erro;
   end;
   begin
      select pfe_dt_inicio_periodo_aquis, pfe_dt_termino_periodo_aquis
      into   v_dt_inicio_periodo_aquis, v_dt_termino_periodo_aquis
      from   ifrsrh_folha.programacoes_ferias
      where  pfe_emp_numero_matricula = r_mov.mov_emp_numero_matricula
      and   ((pfe_data_inicio_1  = v_dt_inicio_ocor and
              pfe_data_termino_1 = v_dt_termino_ocor) or
             (pfe_data_inicio_2  = v_dt_inicio_ocor and
              pfe_data_termino_2 = v_dt_termino_ocor));
   exception
      when no_data_found then
         insert into ifrsrh_folha.EVENTO_FOLHA
        		(evf_mes_referencia, evf_ano_referencia, evf_versao_pagamento,
        		 evf_rub_codigo, evf_emp_numero_matricula, evf_data_evento,
        		 evf_cdr_cod_rotina, evf_mensagem)
       	 values (par_mes_calculo, par_ano_calculo, par_versao, r_mov.mov_rub_codigo,
        		 r_mov.mov_emp_numero_matricula, sysdate, 6,
	             'Problemas ao tentar recuperar o período aquisitivo de férias.');
      when others then
         grava_log_erro;
   end;
   if v_dt_inicio_periodo_aquis is not null and
      v_dt_termino_periodo_aquis  is not null then
      v_ano_mes_ini := to_number(to_char(v_dt_inicio_periodo_aquis,'yyyymm'));
      v_ano_mes_fim := to_number(to_char(v_dt_termino_periodo_aquis,'yyyymm') - 1);
      calcula_valor_adicional;
   end if;
Exception
  when others then
     grava_log_erro;
End;
--------------------------------------------------------------------------
--                 Atribui valor ao operando SUBSTFUNC                  --
--------------------------------------------------------------------------
Procedure Obtem_valor_substfunc is
Begin
  Obtem_valor_funcao (r_mov.mov_fun_codigo);
  v_valor_func_tit := v_valor_operando;
  if r_mov.mov_tipo_funcao = 'FG' then
     -------------------------------------------------------------
     -- Busca o valor do salário base do empregado substituído  --
     -------------------------------------------------------------
     Begin
       select hns.hns_valor_remuneracao
       into   v_valor_salario_tit
       from   ifrsrh_folha.historico_niveis_salariais hns
       where  hns.hns_nsa_codigo_nivel           = r_mov.mov_nsa_codigo_nivel
       and    hns.hns_nsa_codigo_padrao          = r_mov.mov_nsa_codigo_padrao
       and    hns.hns_nsa_indicador_nivel_escola = r_mov.mov_nsa_indicador_nivel_escola;
     Exception
       when no_data_found then
         v_valor_salario_tit := 0;
       when others then
         grava_log_erro;
     End;
--     dbms_output.put_line('valor salario tit ' || v_valor_salario_tit);
  end if;
  --------------------------------------------------------------
  -- Verifica se o empregado substituto possui ou não função  --
  -- de confiança, se possuir irá buscar o valor da FG ou RG  --
  --------------------------------------------------------------
  if v_tipo_funcao is not null then
     Obtem_valor_funcao (v_fun_codigo, v_tipo_funcao);
     v_valor_func_sub := v_valor_operando;
  end if;
  if v_tipo_funcao is null or v_tipo_funcao = 'FG' then
     Obtem_valor_salariobas;
     v_valor_salario_sub := v_valor_operando;
  end if;
  if r_mov.mov_tipo_funcao = 'RG' then
     if v_tipo_funcao = 'FG' then
        v_valor_subst := v_valor_func_tit - v_valor_func_sub - v_valor_salario_sub;
     elsif v_tipo_funcao = 'RG' then
        v_valor_subst := v_valor_func_tit - v_valor_func_sub;
     elsif v_tipo_funcao is null then
        v_valor_subst := v_valor_func_tit - v_valor_salario_sub;
     end if;
  elsif r_mov.mov_tipo_funcao = 'FG' then
     if v_tipo_funcao = 'FG' then
        v_diferenca_funcao  := v_valor_func_tit - v_valor_func_sub;
        v_diferenca_salario := v_valor_salario_tit - v_valor_salario_sub;
        if v_diferenca_funcao < 0 then
           v_diferenca_funcao := 0;
        end if;
        if v_diferenca_salario < 0 then
           v_diferenca_salario := 0;
        end if;
        v_valor_subst := v_diferenca_funcao + v_diferenca_salario;
     elsif v_tipo_funcao = 'RG' then
        v_valor_subst := v_valor_func_tit + v_valor_salario_tit - v_valor_func_sub;
     elsif v_tipo_funcao is null then
        v_diferenca_salario := v_valor_salario_tit - v_valor_salario_sub;
        if v_diferenca_salario < 0 then
           v_diferenca_salario := 0;
        end if;
        v_valor_subst := v_valor_func_tit + v_diferenca_salario;
     end if;
  end if;
  if v_valor_subst < 0 then
     v_valor_subst := 0;
  end if;
  v_valor_operando := v_valor_subst;
Exception
  when others then
     grava_log_erro;
End;
--------------------------------------------------------------------------
--                 PROCEDURE OBTEM_VALOR_AVOFERPROV                     --
--------------------------------------------------------------------------
Procedure Obtem_Valor_Avoferprov is
    v_data_referencia  date   := last_day(to_date('01' || '/' || to_char(par_mes_calculo)
                                                       || '/' || to_char(par_ano_calculo),'dd/mm/yyyy'));
    cursor c_oem is
        select t1.oem_data_inicio, t1.oem_data_termino
          from ifrsrh_folha.ocorrencias_empregados t1
         where t1.oem_emp_numero_matricula = r_mov.mov_emp_numero_matricula
           and t1.oem_ofu_codigo = 74;
    r_oem      c_oem%rowtype;
    cursor c_pfe is
        select pfe_data_inicio_1,
               pfe_data_inicio_2,
               pfe_data_termino_1,
               pfe_data_termino_2,
               pfe_dt_inicio_periodo_aquis,
               pfe_dt_termino_periodo_aquis,
               pfe_data_ini_abono_pecuniario,
               pfe_data_fim_abono_pecuniario
          from ifrsrh_folha.programacoes_ferias
         where pfe_emp_numero_matricula = r_mov.mov_emp_numero_matricula;
    r_pfe      c_pfe%rowtype;
    v_avos             number;
    -- Determina a data de admissao do empregado
    Function Data_Admissao return date is
    Begin
        return (v_data_admissao);
    End;
    Function Meses (v_data_funcao date) return number is
       v_meses number;
    Begin
       v_meses := (((to_number(to_char(v_data_referencia,'yyyy')) - to_number(to_char(v_data_funcao,'yyyy'))) * 12)
                  +
                  (to_number(to_char(v_data_referencia,'mm')) - to_number(to_char(v_data_funcao,'mm'))) + 1);
       return (v_meses);
    End;
Begin
    v_avos                := 0;
    r_oem.oem_data_inicio := null;
    open c_oem;
    fetch c_oem into r_oem;
    close c_oem;
    if r_oem.oem_data_inicio is null then
       v_avos := Meses(Data_Admissao);
    else
       open c_pfe;
       fetch c_pfe into r_pfe;
       close c_pfe;
       v_avos := Meses(r_pfe.pfe_dt_termino_periodo_aquis + 1);
    end if;
    v_valor_operando := v_avos;
Exception
  when others then
     grava_log_erro;
End;
--------------------------------------------------------------------------
--                 PROCEDURE OBTEM_VALOR_DIAFERPROV                     --
--------------------------------------------------------------------------
Procedure Obtem_Valor_Diaferprov is
    cursor c_oem is
        select t1.oem_data_inicio, t1.oem_data_termino
          from ifrsrh_folha.ocorrencias_empregados t1
         where t1.oem_emp_numero_matricula = r_mov.mov_emp_numero_matricula
           and t1.oem_ofu_codigo = 74
           and t1.oem_data_inicio between to_date('01' || '/' || to_char(par_mes_calculo,'00')
                                                       || '/' || to_char(par_ano_calculo,'0000'),'dd/mm/yyyy')
                                      and last_day(to_date(to_char(par_mes_calculo,'00')
                                                       || '/' || to_char(par_ano_calculo,'0000'),'mm/yyyy'));
    r_oem      c_oem%rowtype;
    cursor c_pfe is
        select pfe_data_inicio_1,
               pfe_data_inicio_2,
               pfe_data_termino_1,
               pfe_data_termino_2,
               pfe_dt_inicio_periodo_aquis,
               pfe_dt_termino_periodo_aquis,
               pfe_data_ini_abono_pecuniario,
               pfe_data_fim_abono_pecuniario,
               pfe_numero_dias_gozo_2
          from ifrsrh_folha.programacoes_ferias
         where pfe_emp_numero_matricula = r_mov.mov_emp_numero_matricula;
    r_pfe      c_pfe%rowtype;
    v_dias          number;
Begin
    v_dias := 0;
    open c_oem;
    fetch c_oem into r_oem;
    close c_oem;
    open c_pfe;
    fetch c_pfe into r_pfe;
    close c_pfe;
    if (r_oem.oem_data_inicio  = r_pfe.pfe_data_inicio_2  and r_oem.oem_data_termino = r_pfe.pfe_data_termino_2)                or
       (r_oem.oem_data_inicio  = r_pfe.pfe_data_inicio_2  and r_oem.oem_data_termino = r_pfe.pfe_data_ini_abono_pecuniario-1)   or
       (r_oem.oem_data_termino = r_pfe.pfe_data_termino_2 and r_oem.oem_data_inicio  = r_pfe.pfe_data_fim_abono_pecuniario+1) then
       v_dias := 0;
    else
       if r_pfe.pfe_data_inicio_2 is null then
          v_dias := 0;
       else
          v_dias := r_pfe.pfe_numero_dias_gozo_2;
       end if;
    end if;
    v_valor_operando := v_dias;
Exception
  when others then
     grava_log_erro;
End;
Procedure obtem_valor_val13sal is
   CURSOR c_a13_f IS
      select a13f_valor
      from   ifrsrh_folha.adicional_13_ferias
      where  a13f_ano = par_ano_calculo
      and    a13f_mes = 13
      and    a13f_sequencial = par_versao
      and    a13f_emp_numero_matricula = r_mov.mov_emp_numero_matricula
      and    a13f_cod_rubrica = 1340;
Begin
   --
   v_valor_operando := 0;
   OPEN  c_a13_f;
   FETCH c_a13_f into v_valor_operando;
   CLOSE c_a13_f;
   --
End;
Procedure obtem_valor_valadic13 is
   CURSOR c_a13f IS
      select a13f_valor
      from   ifrsrh_folha.adicional_13_ferias
      where  a13f_ano = par_ano_calculo
      and    a13f_mes = 13
      and    a13f_sequencial = par_versao
      and    a13f_emp_numero_matricula = r_mov.mov_emp_numero_matricula
      and    a13f_cod_rubrica = 1345;
Begin
   --
   v_valor_operando := 0;
   OPEN  c_a13f;
   FETCH c_a13f into v_valor_operando;
   CLOSE c_a13f;
   --
End;
Procedure obtem_valor_valadicFer is
   CURSOR c_a13f (p_matricula in number) IS
      select sum(a13f_valor)
      from   ifrsrh_folha.adicional_13_ferias
      where  a13f_emp_numero_matricula = p_matricula;   
Begin
   v_valor_operando := 0;
   OPEN  c_a13f (r_mov.mov_emp_numero_matricula);
   FETCH c_a13f into v_valor_operando;
   CLOSE c_a13f;
   --
End;
--------------------------------------------------------------------------
--                PROCEDURE OBTEM_INFRAPREV_PRINCIPAL_EMP               --
--------------------------------------------------------------------------
Procedure Obtem_Infraprev_Principal_Emp is
Begin
  if par_mes_calculo = 13 then
     v_rub_codigo := 5092;
  else
     v_rub_codigo := 5067;
  end if;
  obtem_valor_somarubinc;
  v_valor_infra_emp := v_valor_operando;
  v_rub_codigo := 1995;
  obtem_valor_valrub;
  if v_valor_operando > 0 then
     v_valor_infra_emp   := v_valor_infra_emp + v_valor_operando;
     v_salcont_infraprev := v_valor_infra_emp;
  end if;
  v_teto_infraprev := 0;
  Obtem_Teto_Infraprev (1);
  if v_valor_infra_emp >= v_teto_infraprev then
     v_infra_emp := (v_teto_infraprev * 8) / 100;
  else
     v_infra_emp := (v_valor_infra_emp * 8) / 100;
  end if;
  if par_mes_calculo = 13 then
     v_rub_codigo := 5092;
  else
     v_rub_codigo := 5067;
  end if;
  obtem_valor_valrub;
  if v_valor_operando = 0 then
     v_rub_codigo := 1995;
     obtem_valor_integral_valrub;
     if v_valor_operando = 0 then
        v_valor_operando := v_infra_emp;
     else
        v_salcont_infraprev := v_valor_operando;
        if par_mes_calculo = 13 then
           v_rub_codigo := 5092;
        else
           v_rub_codigo := 5067;
        end if;
        obtem_valor_parrub;
        v_valor_operando    := (v_salcont_infraprev * v_valor_operando) / 100;
     end if;
  end if;
  v_valor_operando := (v_valor_operando * nvl(r_mov.mov_parametro,0)) / 100;
  if v_valor_operando > v_infra_emp then
     v_valor_operando := v_infra_emp;
  end if;
Exception
  when others then
     grava_log_erro;
End;
--------------------------------------------------------------------------
--                 PROCEDURE SUBSTITUI_OPERANDO_POR_VALOR               --
--------------------------------------------------------------------------
Procedure Subs_operando_por_valor is
Begin
   Begin
     select for_formula
     into   v_formula
     from   ifrsrh_folha.formulas_rubricas
     where ((fru_for_codigo = r_mov.mov_for_codigo) or (fru_rub_codigo = r_mov.mov_rub_codigo));
   Exception
     when no_data_found then
       v_formula := 0;
     when others then
       grava_log_erro;
   End;
  v_formula := replace(v_formula, '+', ' + ');
  v_formula := replace(v_formula, '/', ' / ');
  v_formula := replace(v_formula, '*', ' * ');
  v_formula := replace(v_formula, '(', ' ( ');
  v_formula := replace(v_formula, ')', ' ) ');
  v_formula := v_formula || ' ';
  while instr(v_formula, '  ') > 0 loop
     v_formula := replace (v_formula, '  ', ' ');
  end loop;
--------------------------------------------------------------------------
--                 LOOP de atribuição de valores aos operandos          --
--------------------------------------------------------------------------
  while instr(v_formula, ' ') > 0 loop
    if substr(v_formula, 1, 1) in ('*', '/', '+', '-', '(', ')') then
       v_formula_com_valores := v_formula_com_valores ||substr(v_formula, 1, 1) || ' ';
       v_formula := substr(v_formula,3);
    else
       v_operando:= substr(v_formula, 1, instr(v_formula, ' ') - 1);
       if v_operando = 'SALARIOBAS' then
          obtem_valor_salariobas (r_mov.mov_nsa_codigo_nivel,
                                  r_mov.mov_nsa_codigo_padrao,
                                  r_mov.mov_nsa_indicador_nivel_escola);
       elsif v_operando = 'SOMARUBINC' then
          v_rub_codigo := r_mov.mov_rub_codigo;
          obtem_valor_somarubinc;
       elsif v_operando = 'SORINSSFER' then
          obtem_valor_operando (r_mov.mov_rub_codigo);
       elsif v_operando = 'BACAFA' then
          obtem_valor_bacafa;
       elsif v_operando = 'SOMARUBDES' then
          v_rub_codigo := r_mov.mov_rub_codigo;
          obtem_valor_somarubdes;
       elsif substr(v_operando, 1,6) = 'VALRUB' then
          v_rub_codigo := to_number(substr(v_operando, 7,4));
          obtem_valor_valrub;
       elsif substr(v_operando, 1,6) = 'PARRUB' then
          v_rub_codigo := to_number(substr(v_operando, 7,4));
          obtem_valor_parrub;
       elsif v_operando = 'SALBRUTO' then
          v_rub_codigo := 1910;
          obtem_valor_somarubinc;
       elsif v_operando = 'COMPULSO' then
          obtem_valor_compulso;
       elsif v_operando = 'DIASFER' then
          obtem_total_dias_ferias;
       elsif SUBSTR(v_operando, 1,10) = 'VALFIXORUB' then
          v_rub_codigo := TO_NUMBER(SUBSTR(v_operando, 11,14));
          obtem_valor_valfixorub;
       elsif v_operando = 'OBADI13' then
          obtem_valor_obadi13;
       elsif v_operando = 'REMUBRUTA' then
          v_rub_codigo := 1905;
          obtem_valor_somarubinc;
       elsif v_operando = 'PARAMETRO' then
          obtem_valor_parametro;
       elsif v_operando = 'TETOPREV' then
          obtem_valor_tetoprev;
       elsif v_operando = 'INFRAEMP' then
          Obtem_Infraprev_Principal_Emp;
       elsif v_operando = 'CARGHORMEN' then
          obtem_valor_carghormen;
       elsif v_operando = 'BASEINSS' then
          obtem_valor_baseinss;
       elsif v_operando = 'DEDESCO' then
          obtem_valor_dedesco;
       elsif v_operando = 'PERCINSS' then
          obtem_valor_percinss;
       elsif v_operando = 'NUMDEPIR' then
          obtem_valor_numdepir;
       elsif v_operando = 'BASEIRRF' then
          obtem_valor_baseirrf;
       elsif v_operando = 'PERCIRRF' then
          obtem_valor_percirrf;
       elsif v_operando = 'PARDEDUZIR' then
          obtem_valor_pardeduzir;
       elsif v_operando = 'NUMDEPSF' then
          obtem_valor_numdepsf;
       elsif v_operando = 'VALSALFAM' then
          obtem_valor_valsalfam;
       elsif v_operando = 'DEDUCAODEP' then
          obtem_valor_deducaodep;
       elsif v_operando = 'OBADIFERIA' then
          obtem_valor_obadiferia;
       elsif v_operando = 'PERCFGTS' then
          obtem_valor_constante (01);
       elsif v_operando = 'GRATIFUNC' then
          obtem_valor_funcao (r_mov.mov_fun_codigo);
       elsif v_operando = 'PERGRATDIR' then
          obtem_valor_constante (04);
       elsif v_operando = 'PEREMUCONS' then
          obtem_valor_constante (05);
       elsif v_operando = 'BASEINSALU' then
          obtem_valor_constante (09);
       elsif v_operando = 'DIASUTEIS' then
          obtem_valor_diasuteis;
       elsif v_operando = 'DIASNUTEIS' then
          obtem_valor_diasnuteis;
       elsif v_operando = 'LIMITEREMU' then
          obtem_valor_constante (03);
       elsif v_operando = 'BASE13ADI' then
          obtem_valor_operando(r_mov.mov_rub_codigo);
       elsif v_operando = 'NUMAVOS13' then
          obtem_valor_numavos13;
       elsif v_operando = 'SALMINIMO' then
          obtem_valor_constante (02);
       elsif v_operando = 'BTN' then
          obtem_valor_constante (07);
       elsif v_operando = 'LIMISALMAT' then
          obtem_valor_constante (08);
       elsif v_operando = 'CINFRAPREV' then
          obtem_valor_cinfraprev;
       elsif v_operando = 'VALTOTHE' then
          obtem_valor_total_horas_extras;
       elsif v_operando = 'SUBSTFUNC' then
          obtem_valor_substfunc;
       elsif v_operando = 'AVOFERPROV' then
          obtem_valor_avoferprov;
       elsif v_operando = 'DIAFERPROV' then
          obtem_valor_diaferprov;
       elsif v_operando = 'VAL13SAL' then
          obtem_valor_val13sal;
       elsif v_operando = 'VALADIC13' then
          obtem_valor_valadic13;
       elsif v_operando = 'VALADICFER' then
          obtem_valor_valadicFer;
       else
          Begin
             v_valor_operando := to_number(v_operando);
          Exception
             when others then
                grava_log_erro;
          End;
       end if;
       v_formula             := substr(v_formula, instr(v_formula, ' ') + 1);
       v_formula_com_valores := v_formula_com_valores ||
                                to_char(v_valor_operando) || ' ';
    end if;
  end loop;
Exception
  when others then
     grava_log_erro;
End;
--------------------------------------------------------------------------
--                 PROCEDURE OBTEM_ACERTO_DIFERENCA_13                  --
--------------------------------------------------------------------------
Procedure Obtem_acerto_diferenca_13 is
Begin
  Begin
    select nvl(sum(nvl(mov.mov_valor,0)),0)
    into   v_valor_rubrica
    from   ifrsrh_folha.movimentacao mov
    where  mov.mov_ano_referencia       = r_mov.mov_ano_referencia
    and    mov.mov_mes_referencia       = 13
    and    mov.mov_versao_pagamento     = 1
    and    mov.mov_emp_numero_matricula = r_mov.mov_emp_numero_matricula
    and    mov.mov_rub_codigo           = r_mov.mov_rub_codigo
    and    mov.mov_tip_rubrica          = r_mov.mov_tip_rubrica
    and    mov.mov_sequencial           = r_mov.mov_sequencial;
  Exception
    when no_data_found then
      v_valor_rubrica := 0;
    when others then
      grava_log_erro;
  End;
  -- Busca acerto do mês 13 versão 2
  Begin
    select nvl(sum(nvl(mov.mov_valor,0)),0)
    into   v_valor_operando
    from   ifrsrh_folha.movimentacao mov
    where  mov.mov_ano_referencia       = r_mov.mov_ano_referencia
    and    mov.mov_mes_referencia       = 13
    and    mov.mov_versao_pagamento     = 2
    and    mov.mov_emp_numero_matricula = r_mov.mov_emp_numero_matricula
    and    mov.mov_rub_codigo           = r_mov.mov_rub_codigo
    and    mov.mov_tip_rubrica          = r_mov.mov_tip_rubrica
    and    mov.mov_sequencial           = r_mov.mov_sequencial;
  Exception
    when no_data_found then
      v_valor_operando := 0;
    when others then
      grava_log_erro;
  End;
  --       v.2        <      v.1
  if v_valor_operando < v_valor_rubrica then
     v_valor_rubrica := v_valor_rubrica - v_valor_operando;
     begin
       update ifrsrh_folha.movimentacao
       set    mov_tip_rubrica = 'E'
       where rowid = r_mov.rowid;
       r_mov.mov_tip_rubrica := 'E';
     exception
       when others then
         grava_log_erro;
     end;
  elsif v_valor_operando > v_valor_rubrica then
     v_valor_rubrica := v_valor_operando - v_valor_rubrica;
     begin
       update ifrsrh_folha.movimentacao
       set    mov_tip_rubrica = 'D'
  	   where rowid = r_mov.rowid;
      r_mov.mov_tip_rubrica := 'D';
     exception
       when others then
         grava_log_erro;
     end;
  elsif v_valor_operando = v_valor_rubrica then
     v_valor_rubrica := 0;
  end if;
Exception
  when others then
     grava_log_erro;
End;
--------------------------------------------------------------------------
--                  PROCEDURE CARREGA_ARRAY_CONSTANT                    --
--------------------------------------------------------------------------
Procedure carrega_array_constant is
Begin
   v_vale := 0;
   open c_constant;
   loop
       fetch c_constant into r_constant;
       exit when c_constant%notfound;
       v_vale := v_vale + 1;
       ar(v_vale).col_codigo := r_constant.col_codigo;
       ar(v_vale).col_valor  := r_constant.col_valor;
   end loop;
   close c_constant;
Exception
  when others then
     grava_log_erro;
End;
--------------------------------------------------------------------------
--                  PROCEDURE CARREGA_ARRAY_IRRF                    --
--------------------------------------------------------------------------
Procedure carrega_array_irrf is
Begin
   v_vale := 0;
   open c_irrf;
   loop
       fetch c_irrf into r_irrf;
       exit when c_irrf%notfound;
       v_vale := v_vale + 1;
       arirrf(v_vale).imr_renda_maxima    := r_irrf.imr_renda_maxima;
       arirrf(v_vale).imr_valor_a_deduzir := r_irrf.imr_valor_a_deduzir;
       arirrf(v_vale).imr_aliquota        := r_irrf.imr_aliquota;
       arirrf(v_vale).imr_vlr_deducao_dep := r_irrf.imr_vlr_deducao_dep;
   end loop;
   close c_irrf;
Exception
  when others then
     grava_log_erro;
End;

--------------------------------------------------------------------------
--              PROCEDURE CARREGA_ARRAY_SALARIO_FAMILIA                 --
--------------------------------------------------------------------------
Procedure carrega_array_salario_familia is
Begin
   v_vale := 0;
   open c_salfam;
   loop
       fetch c_salfam into r_salfam;
       exit when c_salfam%notfound;
       v_vale := v_vale + 1;
       arsalfam(v_vale).saf_renda_maxima := r_salfam.saf_renda_maxima;
       arsalfam(v_vale).saf_valor        := r_salfam.saf_valor;
   end loop;
   close c_salfam;
Exception
  when others then
     grava_log_erro;
End;
--------------------------------------------------------------------------
--                  PROCEDURE CARREGA_ARRAY_ARSAPREV                    --
--------------------------------------------------------------------------
Procedure carrega_array_arsaprev is
Begin
   v_vale := 0;
   open c_infraprev;
   loop
       fetch c_infraprev into r_infraprev;
       exit when c_infraprev%notfound;
       v_vale := v_vale + 1;
       arinfraprev(v_vale).ars_plano      := r_infraprev.ars_plano;
       arinfraprev(v_vale).ars_faixa      := r_infraprev.ars_faixa;
       arinfraprev(v_vale).ars_valor      := r_infraprev.ars_valor;
       arinfraprev(v_vale).ars_percentual := r_infraprev.ars_percentual;
       arinfraprev(v_vale).ars_mes        := r_infraprev.ars_ano;
   end loop;
   close c_infraprev;
Exception
  when others then
     grava_log_erro;
End;

--------------------------------------------------------------------------
--                  PROCEDURE CARREGA_ARRAY_INSS                        --
--------------------------------------------------------------------------
Procedure carrega_array_inss is
Begin
   v_vale := 0;
   open c_inss;
   loop
       fetch c_inss into r_inss;
       exit when c_inss%notfound;
       v_vale := v_vale + 1;
       arinss(v_vale).fai_lim_superior  := r_inss.fai_lim_superior;
       arinss(v_vale).fai_per_desc_empr := r_inss.fai_per_desc_empr;
   end loop;
   close c_inss;
Exception
  when others then
     grava_log_erro;
End;

--------------------------------------------------------------------------
--                 PROCEDURE EFETUA_CALCULO                             --
--------------------------------------------------------------------------
Procedure Efetua_calculo is
Begin
  if r_mov.mov_emp_numero_matricula <> nvl(v_matricula_anterior,0) then
     open c_cadastros (r_mov.mov_emp_numero_matricula);
     fetch c_cadastros into v_sfu_codigo, v_data_admissao, v_nsa_codigo_nivel, v_nsa_codigo_padrao, 
	                        v_nsa_in_nivel_escolaridade, v_fun_codigo, v_tipo_funcao;
     close c_cadastros;      
        
     if v_base_irrf < 0 then
        v_base_irrf := 0;
     end if;
     if v_base_inss = 0 then
       begin
  	     v_rub_codigo := 5805;
  	     Obtem_valor_somarubinc;
  	     v_base_inss := v_valor_operando;
       exception
     	   when others then
       	   v_base_inss := 0;
       end;
       v_faixa_inss := 0;
     end if;
     v_valor_5060 := 0;
     Obtem_valor_operando(5060);
     begin
       select nvl(sum(to_number(decode(rub_tipo_rubrica||mov.mov_tip_rubrica,
                   'RN','+','RD','+','RE','-','DN','-','DD','-','DE','+')||
                   to_char(nvl(mov_valor,0)))),0)
       into   v_valor_5060
       from   ifrsrh_folha.movimentacao mov, rubricas
       where  mov.mov_ano_referencia       = r_mov.mov_ano_referencia
       and    mov.mov_mes_referencia       = r_mov.mov_mes_referencia
       and    mov.mov_versao_pagamento     = r_mov.mov_versao_pagamento
       and    mov.mov_emp_numero_matricula = r_mov.mov_emp_numero_matricula
       and    nvl(mov.mov_ind_lancamento_liq_negat,'N') = 'N'
       and    mov.mov_rub_codigo           = rub_codigo
       and    mov.mov_rub_codigo in
             (select iru_rub_codigo_incide
              from   ifrsrh_folha.incidencias_rubricas
              where  iru_rub_codigo = 5060
              and  ((mov.mov_tip_rubrica = 'N' AND iru_tip_normal      = 'S') or
                    (mov.mov_tip_rubrica = 'D' AND iru_tip_diferenca   = 'S') or
                    (mov.mov_tip_rubrica = 'E' AND iru_tip_estorno_dev = 'S')));
     Exception
       when others then
         grava_log_erro;
     End;
     Begin
        update ifrsrh_folha.empregados_pagamentos
        set    egt_base_fgts            = v_base_fgts,
               egt_base_fgts_sem_13     = nvl(v_base_fgts_sem_13,0),
               egt_base_fgts_13         = nvl(v_base_fgts_13,0),
               egt_base_inss            = v_base_inss + nvl(v_valor_5060,0),
               egt_base_irrf            = v_base_irrf,
               egt_base_irrf_13         = v_base_irrf_13,
               egt_base_irrf_ferias     = v_base_irrf_ferias,
               egt_base_arsaprev        = v_salcont_infraprev,
               egt_faixa_inss           = v_faixa_inss,
               egt_remuneracao_liquido  = v_liquido
        where  egt_emp_numero_matricula = v_matricula_anterior
        and    egt_crp_ano_pagamento    = par_ano_calculo
        and    egt_crp_mes_pagamento    = par_mes_calculo
        and    egt_crp_sequencial       = par_versao;
     Exception
       when others then
          grava_log_erro;
     End;
     if par_mes_calculo < 13 and nvl(v_matricula_anterior,0) > 0 then
        if par_mes_calculo = 1 then
           v_mes_ant := 12;
           v_ano_ant := par_ano_calculo - 1;
        else
           v_mes_ant := par_mes_calculo - 1;
           v_ano_ant := par_ano_calculo;
        end if;
        Begin
           select egt_remuneracao_liquido
           into   v_liquido_ant
           from   ifrsrh_folha.empregados_pagamentos
           where  egt_emp_numero_matricula = v_matricula_anterior
           and    egt_crp_ano_pagamento    = v_ano_ant
           and    egt_crp_mes_pagamento    = v_mes_ant
           and    egt_crp_sequencial       = par_versao;
           if v_liquido > (v_liquido_ant * 3) then
              v_liquido := v_liquido - v_liquido_ant;
              insert into ifrsrh_folha.EVENTO_FOLHA
        	         (evf_mes_referencia, evf_ano_referencia, evf_versao_pagamento,
        		      evf_rub_codigo, evf_emp_numero_matricula, evf_data_evento,
        		      evf_cdr_cod_rotina, evf_mensagem)
          	  values (par_mes_calculo, par_ano_calculo, par_versao, null,
        		      v_matricula_anterior, sysdate, 1,
	                  'Salário líquido superior em '||to_char(v_liquido)||
                      ' ao do mês anterior.');
           end if;
        exception
           when no_data_found then
              null;
           when others then
              grava_log_erro;
        End;
     end if;
     Begin
        select egt_dependentes_ir, egt_dependentes_sal_fam,
               egt_numero_mes_13, egt_numero_anuenios,
               egt_carga_horaria_mes, egt_base_fgts,
               egt_base_fgts_sem_13, egt_base_fgts_13,
               egt_base_inss, egt_base_irrf,
               egt_base_irrf_13, egt_base_irrf_ferias,
               egt_percentual_arsaprev,
               egt_plano_arsaprev
        into   v_empregado.egt_dependentes_ir,
               v_empregado.egt_dependentes_sal_fam,
               v_empregado.egt_numero_mes_13,
               v_empregado.egt_numero_anuenios,
               v_empregado.egt_carga_horaria_mes,
               v_empregado.egt_base_fgts,
               v_empregado.egt_base_fgts_sem_13,
               v_empregado.egt_base_fgts_13,
               v_empregado.egt_base_inss,
               v_empregado.egt_base_irrf,
               v_empregado.egt_base_irrf_13,
               v_empregado.egt_base_irrf_ferias,
               v_empregado.egt_percentual_arsaprev,
               v_empregado.egt_plano_arsaprev
        from   ifrsrh_folha.empregados_pagamentos
        where  egt_emp_numero_matricula = r_mov.mov_emp_numero_matricula
        and    egt_crp_ano_pagamento    = r_mov.mov_ano_referencia
        and    egt_crp_mes_pagamento    = r_mov.mov_mes_referencia
        and    egt_crp_sequencial       = r_mov.mov_versao_pagamento;
     Exception
	    when no_data_found then
          null;
        when others then
          grava_log_erro;
     End;
     v_matricula_anterior := r_mov.mov_emp_numero_matricula;
     v_liquido   		  := 0;
     v_base_fgts 		  := 0;
     v_base_fgts_sem_13   := 0;
     v_base_fgts_13       := 0;
     v_base_inss 		  := 0;
     v_base_inss_cal      := 0;
     v_base_irrf 		  := 0;
     v_base_irrf_13  	  := 0;
     v_base_irrf_ferias	  := 0;
     v_salcont_infraprev  := 0;
     v_faixa_inss 		  := 0;
     v_valor_salario      := null;
     v_valor_funcao       := null;
  end if;
  if r_mov.mov_mes_referencia = 12 and r_mov.mov_versao_pagamento = 1 and r_mov.mov_rub_codigo in
    (5350,5105,1340,1302,1325,1390,1345,5060,5090,5095,5098,5085,
     5510,5525,5092,5094,1925,1926,1945,1342,
     5934,5935,5902) then
     obtem_acerto_diferenca_13;
  else
    if nvl(r_mov.mov_tipo_parametro,'D') <> 'V' then
        v_formula_com_valores := null;
        v_valor_rubrica	   := 0;
        subs_operando_por_valor;
        if v_formula_com_valores <> ' ' then
           begin
              v_valor_rubrica := ifrsrh.sql_dinamico('select trunc('||
                                 replace(v_formula_com_valores,',','.')||',2)from dual');
           exception
             when others then
                grava_log_erro;
           end;
        end if;
    else
       v_valor_rubrica := r_mov.mov_valor;
    end if;
  end if;
  -- tratamento da cobrança de contribuição confederativa - Acrescentado em 30/06/2005 por Eduardo Lima
  if r_mov.mov_rub_codigo = 5140 then
     obtem_valor_constante (31);
     if v_valor_rubrica > v_valor_operando then
        v_valor_rubrica := v_valor_operando;
     end if;
  end if;
  -- Fim do tratamento da cobrança de contribuição confederativa

  if v_valor_rubrica < 0 then
     v_valor_rubrica := 0;
  end if;
  if substr(r_mov.mov_rub_codigo,1,2) not in (19,59) then
     v_fator_proporcional := nvl(r_mov.mov_dias_proporcionalidade,0);
     if substr(to_char(r_mov.mov_rub_codigo), 1, 1) = 5 then
        if r_mov.mov_tip_rubrica in ('N', 'D') then
           v_liquido := v_liquido - ((v_valor_rubrica/30) * v_fator_proporcional);
        elsif r_mov.mov_tip_rubrica = 'E' then
           v_liquido := v_liquido + ((v_valor_rubrica/30) * v_fator_proporcional);
        end if;
     elsif substr(to_char(r_mov.mov_rub_codigo), 1, 1) = 1 then
        if r_mov.mov_tip_rubrica in ('N', 'D') then
           v_liquido := v_liquido + ((v_valor_rubrica/30) * v_fator_proporcional);
        elsif r_mov.mov_tip_rubrica = 'E' then
           v_liquido := v_liquido - ((v_valor_rubrica/30) * v_fator_proporcional);
        end if;
     end if;
  elsif r_mov.mov_rub_codigo = 1900 then
     par_valor_fgts := v_valor_rubrica;
  end if;
  --  tratamento para cobrança de IRRF   ---
  if r_mov.mov_mes_referencia = 12 then
     if r_mov.mov_rub_codigo in (5100,5110,5115) and nvl(r_mov.mov_tipo_parametro,'D') <> 'V' then
        Obtem_valor_irrf;
 	    Obtem_valor_numdepir;
        Obtem_valor_deducaodep;
        v_base_irrf_13 := 0;
        if r_mov.mov_rub_codigo = 5110 then
           v_rub_codigo := r_mov.mov_rub_codigo;
           Obtem_valor_somarubinc;
           v_base_irrf_ferias := (v_valor_operando - (v_numdepir * nvl(v_deducaodep,0)));
        end if;
     end if;
  else
     if r_mov.mov_rub_codigo in (5100,5105,5110,5115) and nvl(r_mov.mov_tipo_parametro,'D') <> 'V' then
        Obtem_valor_irrf;
        Obtem_valor_numdepir;
        Obtem_valor_deducaodep;
        if r_mov.mov_rub_codigo = 5105 then
           v_rub_codigo := r_mov.mov_rub_codigo;
           Obtem_valor_somarubinc;
           v_base_irrf_13 := (v_valor_operando - (v_numdepir * nvl(v_deducaodep,0)));
        end if;
        if r_mov.mov_rub_codigo = 5110 then
           v_rub_codigo := r_mov.mov_rub_codigo;
           Obtem_valor_somarubinc;
           v_base_irrf_ferias := (v_valor_operando - (v_numdepir * nvl(v_deducaodep,0)));
        end if;
     end if;
  end if;
  if v_base_irrf_13 < 0 then
     v_base_irrf_13 := 0;
  end if;
  if v_base_irrf_ferias < 0 then
     v_base_irrf_ferias := 0;
  end if;
   --  Calcula o fator de Proporcionalidade --
  if nvl(r_mov.mov_dias_proporcionalidade,0) < 30 or
     nvl(r_mov.mov_dias_proporcionalidade,0) > 30 then
     v_fator_proporcional := nvl(r_mov.mov_dias_proporcionalidade,0);
     begin
       update ifrsrh_folha.movimentacao
       set    mov_valor           = (v_valor_rubrica/30) * v_fator_proporcional,
              mov_valor_integral  = v_valor_rubrica,
              mov_ind_calculo     = 'S',
       		  mov_data_calculo    = trunc(sysdate)
   	   where rowid = r_mov.rowid;
     exception
       when others then
         grava_log_erro;
     end;
  else
     begin
       update ifrsrh_folha.movimentacao
       set    mov_valor           = v_valor_rubrica,
              mov_valor_integral  = v_valor_rubrica,
              mov_ind_calculo     = 'S',
     		  mov_data_calculo    = trunc(sysdate)
  	   where rowid = r_mov.rowid;
     exception
       when others then
         grava_log_erro;
     end;
  end if;
  v_conta := nvl(v_conta,0) + 1;
Exception
  when others then
     grava_log_erro;
End;
--**********************************************************************--
--**                INÍCIO DA PROCEDURE PRINCIPAL                     **--
--**********************************************************************--
Begin
	 --rollback;
   carrega_array_constant;
   carrega_array_irrf;
   carrega_array_arsaprev;
   carrega_array_salario_familia;
   carrega_array_inss;
   if par_matricula is null then
      if par_mes_calculo = 12 and par_versao = 1 then
         delete from ifrsrh_folha.movimentacao
         where  mov_ano_referencia       = par_ano_calculo
         and    mov_mes_referencia       = par_mes_calculo
         and    mov_versao_pagamento     = par_versao
         and    mov_emp_dep_codigo_pagto = par_dep_codigo
         and    mov_rub_codigo in (5350,5105,1302,1325,1390,1340,1345,5060,5090,5095,5098,5085,
                                   5510,5525,5092,5094,1925,1926,1945,1342,
                                   5934,5935,5902,1295);
         --
         commit;
         --
         copia_movimentacao(par_ano_calculo, 13, 2, -- origem
                            par_ano_calculo, 12, 1, -- destino
                            null, par_dep_codigo, null);
         --
         commit;
         --
      end if;
      open c_mov_dep;
      loop
         fetch c_mov_dep into r_mov;
         exit when c_mov_dep%notfound;
         efetua_calculo;
      end loop;
      close c_mov_dep;
   else
      if par_mes_calculo = 12 and par_versao = 1 then
         delete from ifrsrh_folha.movimentacao
         where  mov_ano_referencia = par_ano_calculo
         and    mov_mes_referencia = par_mes_calculo
         and    mov_versao_pagamento = par_versao
         and    mov_emp_numero_matricula = par_matricula
         and    mov_rub_codigo in (5350,5105,1302,1325,1390,1340,1345,5060,5090,5095,5098,5085,
                                   5510,5525,5092,5094,1925,1926,1945,1342,
                                   5934,5935,5902,1295);
         --
         commit;
         --
         copia_movimentacao(par_ano_calculo, 13, 2, -- origem
                            par_ano_calculo, 12, 1, -- destino
                            null, par_dep_codigo, par_matricula);
         --
         commit;
         --
      end if;
      open c_mov_mat;
      loop
         fetch c_mov_mat into r_mov;
         exit when c_mov_mat%notfound;
         efetua_calculo;
      end loop;
      close c_mov_mat;
   end if;
   -- Atualização da tabela de empregados_pagamentos
   if v_base_irrf < 0 then
      v_base_irrf := 0;
   end if;
   if v_base_inss = 0 then
      begin
  	    v_rub_codigo := 5805;
  	    Obtem_valor_somarubinc;
  	    v_base_inss := v_valor_operando;
      exception
     	  when others then
          v_base_inss := 0;
      end;
      v_faixa_inss := 0;
   end if;
   v_valor_5060 := 0;
   begin
     select nvl(sum(to_number(decode(rub_tipo_rubrica||mov.mov_tip_rubrica,
                 'RN','+','RD','+','RE','-','DN','-','DD','-','DE','+')||
                  to_char(nvl(mov_valor,0)))),0)
     into   v_valor_5060
     from   ifrsrh_folha.movimentacao mov, rubricas
     where  mov.mov_ano_referencia       = r_mov.mov_ano_referencia
     and    mov.mov_mes_referencia       = r_mov.mov_mes_referencia
     and    mov.mov_versao_pagamento     = r_mov.mov_versao_pagamento
     and    mov.mov_emp_numero_matricula = r_mov.mov_emp_numero_matricula
     and    nvl(mov.mov_ind_lancamento_liq_negat,'N') = 'N'
     and    mov.mov_rub_codigo           = rub_codigo
     and    mov.mov_rub_codigo in
           (select iru_rub_codigo_incide
            from   ifrsrh_folha.incidencias_rubricas
            where  iru_rub_codigo = 5060
            and  ((mov.mov_tip_rubrica = 'N' AND iru_tip_normal      = 'S') or
                  (mov.mov_tip_rubrica = 'D' AND iru_tip_diferenca   = 'S') or
                  (mov.mov_tip_rubrica = 'E' AND iru_tip_estorno_dev = 'S')));
   Exception
     when others then
       grava_log_erro;
   End;
   Begin
      update ifrsrh_folha.empregados_pagamentos
      set    egt_base_fgts            = v_base_fgts,
             egt_base_fgts_sem_13     = nvl(v_base_fgts_sem_13,0),
             egt_base_fgts_13         = nvl(v_base_fgts_13,0),
             egt_base_inss            = v_base_inss + nvl(v_valor_5060,0),
             egt_base_irrf            = v_base_irrf,
             egt_base_irrf_13         = v_base_irrf_13,
             egt_base_irrf_ferias     = v_base_irrf_ferias,
             egt_base_arsaprev        = v_salcont_infraprev,
             egt_faixa_inss           = v_faixa_inss,
             egt_remuneracao_liquido  = v_liquido
      where  egt_emp_numero_matricula = v_matricula_anterior
      and    egt_crp_ano_pagamento    = par_ano_calculo
      and    egt_crp_mes_pagamento    = par_mes_calculo
      and    egt_crp_sequencial       = par_versao;
   Exception
     when others then
       grava_log_erro;
   End;
   if par_mes_calculo < 13 and nvl(v_matricula_anterior,0) > 0 then
     if par_mes_calculo = 1 then
        v_mes_ant := 12;
        v_ano_ant := par_ano_calculo - 1;
     else
        v_mes_ant := par_mes_calculo - 1;
        v_ano_ant := par_ano_calculo;
     end if;
     Begin
        select egt_remuneracao_liquido
        into   v_liquido_ant
        from   ifrsrh_folha.empregados_pagamentos
        where  egt_emp_numero_matricula = v_matricula_anterior
        and    egt_crp_ano_pagamento    = v_ano_ant
        and    egt_crp_mes_pagamento    = v_mes_ant
        and    egt_crp_sequencial       = par_versao;
        if v_liquido > (v_liquido_ant * 3) then
           v_liquido := v_liquido - v_liquido_ant;
           insert into ifrsrh_folha.EVENTO_FOLHA
     	         (evf_mes_referencia, evf_ano_referencia, evf_versao_pagamento,
     		      evf_rub_codigo, evf_emp_numero_matricula, evf_data_evento,
     		      evf_cdr_cod_rotina, evf_mensagem)
       	   values (par_mes_calculo, par_ano_calculo, par_versao, null,
        	       v_matricula_anterior, sysdate, 1,
	               'Salário líquido superior em '||to_char(v_liquido)||
                   ' ao do mês anterior.');
        end if;
     exception
        when no_data_found then
            null;
        when others then
            grava_log_erro;
     End;
   end if;
Exception
  when others then
     grava_log_erro;
End;
