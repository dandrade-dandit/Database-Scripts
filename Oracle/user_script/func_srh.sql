CREATE OR REPLACE
FUNCTION Recolhimento_INSS (p_dep              in  number,
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
           and nvl(egt_emp_qfu_fun_codigo,0) not in (/*686,687,*/689,675,690,691,692)
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
           and (/*egt_emp_qfu_fun_codigo =  686 or
                egt_emp_qfu_fun_codigo =  687 or*/
                egt_emp_qfu_fun_codigo =  689 or
                egt_emp_qfu_fun_codigo =  675 or
                egt_emp_qfu_fun_codigo =  690 or
                egt_emp_qfu_fun_codigo =  691 or
                egt_emp_qfu_fun_codigo =  692 )
         group by nvl(rei_fpas,0),
                  nvl(rei_atualizacao_monetaria,0),
                  nvl(rei_multa_juros,0),
                  nvl(val_per_juros,0);
    cursor c_aut is
        select /*+ rule */
               nvl(sum(rea_base_calc_autonomo),0) base_autonomo
        from resumo_encargos_inss_autonomo, credenciados
        where rea_cre_sequencial = cre_sequencial
          and rea_ano_referencia = p_ano
          and rea_mes_referencia = p_mes
          and rea_versao_pagto = p_versao
          and rea_dep_codigo = p_dep
          and nvl(cre_tipo,14) = 14;
    cursor c_coop is
        select /*+ rule */
               nvl(sum(rea_base_calc_autonomo),0) base_cooperativa
        from resumo_encargos_inss_autonomo, credenciados
        where rea_cre_sequencial = cre_sequencial
          and rea_ano_referencia = p_ano
          and rea_mes_referencia = p_mes
          and rea_versao_pagto = p_versao
          and rea_dep_codigo = p_dep
          and (cre_tipo = 12 or
               cre_tipo = 13 or
               cre_tipo = 15 or
               cre_tipo = 16);
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
           and nvl(egt_emp_qfu_fun_codigo,0) not in (/*686,687,*/689,675,690,691,692)
         group by nvl(t2.rei_sat,0);
    r_emp                    c_emp%rowtype;
    r_patronal               c_patronal%rowtype;
    r_aut                    c_aut%rowtype;
    r_coop                   c_coop%rowtype;
    v_soma_sat               number;
    v_fpas_20                number;
    v_fpas_15                number;
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
        v_fpas_20                 := 0;
        v_fpas_15                 := 0;
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
    v_fpas_20 := (nvl(r_emp.rei_base_calc_inss,0) * nvl(r_emp.rei_fpas,0) / 100 )           +
                 (nvl(r_patronal.rei_base_calc_inss,0) * nvl(r_patronal.rei_fpas,0) / 100 ) +
                 (nvl(r_aut.base_autonomo,0) * 20 / 100 );
    v_fpas_15 := nvl(r_coop.base_cooperativa,0) * 15 / 100;
    v_incra := nvl(r_emp.rei_base_calc_inss,0) * nvl(r_emp.rei_incra,0) / 100;
    v_fundo_aeroviario := nvl(r_emp.rei_base_calc_inss,0) * nvl(r_emp.rei_fundo_aeroviario,0) / 100;
    p_outras_entidades := v_incra + v_fundo_aeroviario; -- para GPS
    v_deducoes := nvl(r_emp.rei_salario_maternidade,0) + nvl(r_emp.rei_salario_familia,0);
    v_sub_total := v_fpas_20                         +
                   v_fpas_15                         +
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
/

-- Grants for RECOLHIMENTO_INSS

GRANT EXECUTE ON recolhimento_inss TO rh_perfil_99
/
