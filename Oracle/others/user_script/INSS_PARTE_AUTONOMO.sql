create or replace FUNCTION INSS_Parte_Autonomo (p_cre_codigo number, p_ano number, p_mes number)  return number is
    
    -- Retorna o valor de inss já recolhido do autônomo p_cre no ano p_ano e mes p_mes, limitado ao teto de inss

    c_teto_inss                  number(15,2) := Valor_Constante_Legal(18,p_ano,p_mes); -- Constante Legal: Teto Autônomo
    c_perc_aut                   number(15,2) := Valor_Constante_Legal(17,p_ano,p_mes); -- Constante Legal: Percentual Retenção Autônomo

    v_inss_aut                   number(15,2);
    v_recolhido_mac_doc          number(15,2);
    v_recolhido_outros_orgaos    number(15,2);
    v_data_ultimo_calculo        date;

    Function Data_Ultimo_Calculo return date is
        -- retorna a data e hora do ultimo pagamento feito no mes para o autônomo ou a data do primeiro dia do mês
        cursor c_mac is
            select nvl(max(mac_dta_pagto), to_date('01/'||to_char(p_mes,'00')||'/'||to_char(p_ano,'0000'),'dd/mm/yyyy')) data_mac
              from movimentacao_autonomo_cooperat
             where mac_ano_referencia = p_ano
               and mac_mes_referencia = p_mes
               and mac_cre_sequencial = p_cre_codigo;
        cursor c_doc is
            select nvl(max(doc_data), to_date('01/'||to_char(p_mes,'00')||'/'||to_char(p_ano,'0000'),'dd/mm/yyyy')) data_doc
              from documentos_cobranca
             where to_number(ltrim(to_char(doc_data,'mm'))) = p_mes
               and to_number(ltrim(to_char(doc_data,'yyyy'))) = p_ano
               and doc_cbe_cre_sequencial = p_cre_codigo;
        v_data_mac  date;
        v_data_doc  date;
    Begin
        open c_mac;
        fetch c_mac into v_data_mac;
        close c_mac;
        open c_doc;
        fetch c_doc into v_data_doc;
        close c_doc;
        if v_data_mac > v_data_doc then
           return (v_data_mac);
        else
           return (v_data_doc);
        end if;
    End;

    Function Recolhido_Mac_Doc return number is
        -- retorna a soma dos valores já recolhidos nos campos movimentacao_autonomo_cooperat.mac_inss_autonomo e 
        -- documentos_cobranca.doc_inss_autonomo
        cursor c_mac is
            select nvl(sum(mac_inss_autonomo),0) inss_ja_recolhido
              from movimentacao_autonomo_cooperat
             where mac_ano_referencia = p_ano
               and mac_mes_referencia = p_mes
               and mac_cre_sequencial = p_cre_codigo;
        cursor c_doc is
            select nvl(sum(doc_inss_autonomo),0) inss_ja_recolhido
              from documentos_cobranca
             where to_number(ltrim(to_char(doc_data,'mm'))) = p_mes
               and to_number(ltrim(to_char(doc_data,'yyyy'))) = p_ano
               and doc_cbe_cre_sequencial = p_cre_codigo;
        v_total_mac  number;
        v_total_doc  number;
    Begin
        open c_mac;
        fetch c_mac into v_total_mac;
        close c_mac;
        open c_doc;
        fetch c_doc into v_total_doc;
        close c_doc;
        return (nvl(v_total_mac,0) + nvl(v_total_doc,0));
    End;

    Function Recolhido_Outros_Orgaos return number is
        cursor c_docs is
            select nvl(sum(t1.cor_valor_inss_aut),0)  valor
              from credenc_inss_outros_recolhim t1
             where t1.cor_cre_sequencial = p_cre_codigo
               and to_number(ltrim(to_char(t1.cor_dta_doc_fiscal,'yyyy'))) = p_ano
               and to_number(ltrim(to_char(t1.cor_dta_doc_fiscal,'mm'))) = p_mes
               and t1.cor_dta_inclusao > v_data_ultimo_calculo
               and ((t1.cor_ind_tip_operacao = 'I'
                    and t1.cor_dta_inclusao not in
                        (select t2.cor_cor_dta_inclusao
                           from credenc_inss_outros_recolhim t2
                          where t2.cor_cor_cre_sequencial = t1.cor_cre_sequencial
                            and t2.cor_cor_dta_doc_fiscal = t1.cor_dta_doc_fiscal
                            and t2.cor_cor_num_doc_fiscal = t1.cor_num_doc_fiscal
                            and t2.cor_cor_cnpj_empresa =   t1.cor_cnpj_empresa))
                    or (t1.cor_ind_tip_operacao = 'A'
                        and (t1.cor_dta_inclusao =
                            (select max(t3.cor_dta_inclusao)
                               from credenc_inss_outros_recolhim t3
                              where t3.cor_cor_cre_sequencial = t1.cor_cre_sequencial
                                and t3.cor_cor_dta_doc_fiscal = t1.cor_dta_doc_fiscal
                                and t3.cor_cor_num_doc_fiscal = t1.cor_num_doc_fiscal
                                and t3.cor_cor_cnpj_empresa =   t1.cor_cnpj_empresa
                                and t3.cor_ind_tip_operacao = 'A'))
                        and (t1.cor_dta_inclusao not in
                            (select t4.cor_cor_dta_inclusao
                               from credenc_inss_outros_recolhim t4
                              where t4.cor_cor_cre_sequencial = t1.cor_cre_sequencial
                                and t4.cor_cor_dta_doc_fiscal = t1.cor_dta_doc_fiscal
                                and t4.cor_cor_num_doc_fiscal = t1.cor_num_doc_fiscal
                                and t4.cor_cor_cnpj_empresa =   t1.cor_cnpj_empresa
                                and t4.cor_ind_tip_operacao = 'E'))));
        v_valor_docs number;
    Begin
        open c_docs;
        fetch c_docs into v_valor_docs;
        close c_docs;
        return (nvl(v_valor_docs,0));
    End;

Begin

    -- se autonomo ja tiver recolhido pelo teto, somando-se movimentacao e beneficio,
    -- retorna o valor do teto
    v_recolhido_mac_doc := Recolhido_Mac_Doc;
    if v_recolhido_mac_doc >= c_teto_inss then
       return(c_teto_inss);
    end if;

    v_data_ultimo_calculo := Data_Ultimo_Calculo;
    v_recolhido_outros_orgaos := Recolhido_Outros_Orgaos;
    v_inss_aut := v_recolhido_mac_doc + v_recolhido_outros_orgaos;

    if v_inss_aut > c_teto_inss then
       v_inss_aut := c_teto_inss;
    end if;

    return (nvl(v_inss_aut,0));

End;
/
