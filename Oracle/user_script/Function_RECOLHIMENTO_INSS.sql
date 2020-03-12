create or replace FUNCTION RECOLHIMENTO_INSS (p_dep              in  number,
                            p_ano              in  number,
                            p_mes              in  number,
                            p_versao           in  number,
                            p_outras_entidades out number) return number is
    cursor c_emp is
        select /*+ rule */
               nvl(rei_fpas,0) rei_fpas,
               nvl(rei_incra,0) rei_incra,
               nvl(rei_fundo_aeroviario,0) rei_fundo_aeroviario,
               nvl(rei_atualizacao_monetaria,0)*100 rei_atualizacao_monetaria,
               nvl(rei_multa_juros,0)*100 rei_multa_juros,
               nvl(val_per_juros,0)*100 rei_juros,
               nvl(sum(rei_base_calc_inss),0) rei_base_calc_inss,
               nvl(sum(rei_valor_faixa_inss),0) rei_valor_faixa_inss,
               nvl(sum(rei_salario_maternidade),0) rei_salario_maternidade,
               nvl(sum(rei_salario_familia),0) rei_salario_familia
          from resumo_encargos_inss, empregados_pagamentos
         where rei_ano_referencia = p_ano
           and rei_mes_referencia = p_mes
           and rei_versao_pagto = p_versao
           and egt_crp_ano_pagamento = rei_ano_referencia
           and egt_crp_mes_pagamento = rei_mes_referencia
           and egt_crp_sequencial = rei_versao_pagto
           and egt_emp_numero_matricula = rei_emp_numero_matricula
           and egt_dep_codigo = p_dep
           and nvl(egt_emp_qfu_fun_codigo,0) not in (675,690,691,692)
         group by nvl(rei_fpas,0),
               nvl(rei_incra,0),
               nvl(rei_fundo_aeroviario,0),
               nvl(rei_atualizacao_monetaria,0),
               nvl(rei_multa_juros,0),
               nvl(val_per_juros,0);
    cursor c_patronal is
        select /*+ rule */
               nvl(rei_fpas,0) rei_fpas,
               nvl(rei_atualizacao_monetaria,0)*100 rei_atualizacao_monetaria,
               nvl(rei_multa_juros,0)*100 rei_multa_juros,
               nvl(val_per_juros,0)*100 rei_juros,
               nvl(sum(rei_base_calc_inss),0) rei_base_calc_inss
          from resumo_encargos_inss, empregados_pagamentos
         where rei_ano_referencia = p_ano
           and rei_mes_referencia = p_mes
           and rei_versao_pagto = p_versao
           and egt_crp_ano_pagamento = rei_ano_referencia
           and egt_crp_mes_pagamento = rei_mes_referencia
           and egt_crp_sequencial = rei_versao_pagto
           and egt_emp_numero_matricula = rei_emp_numero_matricula
           and egt_dep_codigo = p_dep
           and (egt_emp_qfu_fun_codigo =  675 or
                egt_emp_qfu_fun_codigo =  690 or
                egt_emp_qfu_fun_codigo =  691 or
                egt_emp_qfu_fun_codigo =  692 )
         group by nvl(rei_fpas,0),
                  nvl(rei_atualizacao_monetaria,0),
                  nvl(rei_multa_juros,0),
                  nvl(val_per_juros,0);
    cursor c_aut is
        select /*+ rule */
               nvl(sum(rea_base_calc_autonomo),0) base_autonomo,
               nvl(sum(rea_inss_autonomo),0) inss_autonomo
        from resumo_encargos_inss_autonomo
        where rea_ano_referencia = p_ano
          and rea_mes_referencia = p_mes
          and rea_versao_pagto = p_versao
          and rea_dep_codigo = p_dep
          and rea_ind_aut_coop in ('A','AM');
    cursor c_coop is
        select /*+ rule */
               nvl(sum(rea_base_calc_autonomo),0) base_cooperativa
        from resumo_encargos_inss_autonomo
        where rea_ano_referencia = p_ano
          and rea_mes_referencia = p_mes
          and rea_versao_pagto = p_versao
          and rea_dep_codigo = p_dep
          and rea_ind_aut_coop in ('C','CM');
    cursor c_soma_sat is
        select /*+ rule */
               sum((nvl(sum(t2.rei_base_calc_inss),0) * nvl(t2.rei_sat,0))) soma_sat
          from empregados_pagamentos t1,
               resumo_encargos_inss t2
         where rei_ano_referencia = p_ano
           and rei_mes_referencia = p_mes
           and rei_versao_pagto = p_versao
           and egt_crp_ano_pagamento = rei_ano_referencia
           and egt_crp_mes_pagamento = rei_mes_referencia
           and egt_crp_sequencial = rei_versao_pagto
           and egt_emp_numero_matricula = rei_emp_numero_matricula
           and egt_dep_codigo = p_dep
           and nvl(egt_emp_qfu_fun_codigo,0) not in (675,690,691,692)
         group by nvl(t2.rei_sat,0);
    cursor c_deducoes_emp is
        select /*+ rule */
               nvl(sum(die_valor_deducao),0) soma_deducao_emp
          from deducao_inss_empregados
         where die_ano_deducao = p_ano
           and die_mes_deducao = p_mes
           and die_versao = p_versao
           and die_dep_codigo = p_dep;
    cursor c_deducoes_aut_coop is
        select /*+ rule */
               nvl(sum(dia_valor_deducao),0) soma_deducao_aut_coop
          from deducao_inss_aut_coop
         where dia_ano_deducao = p_ano
           and dia_mes_deducao = p_mes
           and dia_versao = p_versao
           and dia_dep_codigo = p_dep;
    r_emp                    c_emp%rowtype;
    r_patronal               c_patronal%rowtype;
    r_aut                    c_aut%rowtype;
    r_coop                   c_coop%rowtype;
    v_soma_sat               number;
    v_soma_deducao_emp       number;
    v_soma_deducao_aut_coop  number;
    v_fpas_20                number;
    v_fpas_15                number;
    v_inss_autonomo          number;
    v_incra                  number;
    v_fundo_aeroviario       number;
    v_deducoes               number;
    v_sub_total              number;
    v_atualizacao_monetaria  number;
    v_multa                  number;
    v_juros                  number;
    v_total                  number;
    Procedure Inicializa_Variaveis is
    Begin
        v_soma_sat                := 0;
        v_soma_deducao_emp        := 0;
        v_soma_deducao_aut_coop   := 0;
        v_fpas_20                 := 0;
        v_fpas_15                 := 0;
        v_inss_autonomo           := 0;
        v_incra                   := 0;
        v_fundo_aeroviario        := 0;
        p_outras_entidades        := 0;
        v_deducoes                := 0;
        v_sub_total               := 0;
        v_atualizacao_monetaria   := 0;
        v_multa                   := 0;
        v_juros                   := 0;
        v_total                   := 0;
    End;
Begin
    Inicializa_Variaveis;
    open c_emp;
    fetch c_emp into r_emp;
    close c_emp;
    open c_patronal;
    fetch c_patronal into r_patronal;
    close c_patronal;
    open c_aut;
    fetch c_aut into r_aut;
    close c_aut;
    open c_coop;
    fetch c_coop into r_coop;
    close c_coop;
    open c_soma_sat;
    fetch c_soma_sat into v_soma_sat;
    close c_soma_sat;
    open c_deducoes_emp;
    fetch c_deducoes_emp into v_soma_deducao_emp;
    close c_deducoes_emp;
    open c_deducoes_aut_coop;
    fetch c_deducoes_aut_coop into v_soma_deducao_aut_coop;
    close c_deducoes_aut_coop;
    v_fpas_20 := (nvl(r_emp.rei_base_calc_inss,0) * nvl(r_emp.rei_fpas,0) / 100 )           +
                 (nvl(r_patronal.rei_base_calc_inss,0) * nvl(r_patronal.rei_fpas,0) / 100 ) +
                 (nvl(r_aut.base_autonomo,0) * 20 / 100 );
    v_fpas_15 := nvl(r_coop.base_cooperativa,0) * 15 / 100;
    v_inss_autonomo := nvl(r_aut.inss_autonomo,0);
    v_incra := nvl(r_emp.rei_base_calc_inss,0) * nvl(r_emp.rei_incra,0) / 100;
    v_fundo_aeroviario := nvl(r_emp.rei_base_calc_inss,0) * nvl(r_emp.rei_fundo_aeroviario,0) / 100;
    p_outras_entidades := v_incra + v_fundo_aeroviario; -- para GPS
    v_deducoes := nvl(r_emp.rei_salario_maternidade,0) + nvl(r_emp.rei_salario_familia,0) +
                  nvl(v_soma_deducao_emp,0) + nvl(v_soma_deducao_aut_coop,0);
    v_sub_total := v_fpas_20                         +
                   v_fpas_15                         +
                   v_inss_autonomo                   +
                   v_incra                           +
                   v_fundo_aeroviario                +
                   nvl(r_emp.rei_valor_faixa_inss,0) +
                   nvl(v_soma_sat,0)                 -
                   v_deducoes;
    v_atualizacao_monetaria := v_sub_total * nvl(r_emp.rei_atualizacao_monetaria,0);
    v_multa := (v_sub_total + v_atualizacao_monetaria) * nvl(r_emp.rei_multa_juros,0);
    v_juros := (v_sub_total + v_atualizacao_monetaria) * nvl(r_emp.rei_juros,0);
    v_total := v_sub_total + v_atualizacao_monetaria + v_multa + v_juros;
    return (v_total);
End;
