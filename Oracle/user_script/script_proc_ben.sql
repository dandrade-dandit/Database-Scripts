create or replace procedure insere_participacao_folha(p_ano_pagamento    in number,
                                                      p_mes_pagamento    in number,
                                                      p_matricula        in number,
                                                      p_tipo_lancamento  in varchar2,
                                                      p_rubrica          in number,
                                                      p_participacao     in number,
                                                      p_ben_sigla        in varchar2,
                                                      p_mes_diferenca    in number,
                                                      p_ano_diferenca    in number) 



/* =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-= */
/*
|| Nome         : Insere_Participação_Folha
|| Autora       : Yara Fonseca
|| Date Created : 06/02/2002
||
|| Obejetivo: Procedure genérica que insere as participações relativas 
||            a beneficios na Folha de Pagamento. 
||
||
*/

is

v_dependencia	         number(4);
v_seq_pagamento          number(3);
v_indic_exclusividade    varchar2(1);
v_error_code             number;
v_error_message          varchar2(255);     
v_matricula              number(7); 

begin

  ---Busca a dependência física do empregado

  begin

    select emp_dep_codigo_lotacao into v_dependencia
    from empregados
    where emp_numero_matricula = p_matricula;

  exception

  when no_data_found then
       dbms_output.put_line('Erro de processamento. Não é possível lançar participações na folha de pagamento. [Exception - no_data_found ]');
  when others then
       v_error_code     := SQLCODE;
       v_error_message  := SQLERRM; 
       dbms_output.put_line('Erro ao selecionar dependência de lotação do empregado. '||to_char(v_error_code)||' - '||v_error_message);

  end;

     ---Verificar se existe registro para o mes corrente.

  begin

    select distinct mov_emp_numero_matricula into v_matricula
    from   movimentacao
    where mov_parcela              = 1  
    and   mov_ano_referencia       = p_ano_pagamento
    and   mov_mes_referencia       = p_mes_pagamento
    and   mov_versao_pagamento     = 1
    and   mov_sequencial           = 1
    and   mov_rub_codigo           = p_rubrica
    and   mov_emp_numero_matricula = p_matricula
    and   mov_tip_rubrica          = p_tipo_lancamento;

  exception

  when no_data_found then null;
     
  when others then
       v_error_code     := SQLCODE;
       v_error_message  := SQLERRM; 
       dbms_output.put_line('Erro de processamento ao selecionar movimentação - '||to_char(v_error_code)||' - '||v_error_message);
 end;

 ----Busca sequencial de pagamento e indicador de exclusividade da rubrica

 begin

  select rub_seq_pagamento,rub_indic_exclusiva
  into  v_seq_pagamento,v_indic_exclusividade
  from  rubricas
  where rub_codigo = p_rubrica;

 end;

 if v_matricula is null then

    chamada_inserir_movimentacao
    (p_mes_pagamento,
     p_ano_pagamento,
     p_matricula,
     p_rubrica,
     1,
     p_participacao,
     p_tipo_lancamento,
     p_mes_diferenca,
     p_ano_diferenca,
     p_ben_sigla,
     v_seq_pagamento,   
     v_indic_exclusividade,
     v_dependencia);

 else

    begin

      update movimentacao
      set    mov_valor                = mov_valor          + p_participacao,
             mov_parametro            = mov_parametro      + p_participacao,
             mov_valor_integral       = mov_valor_integral + p_participacao
      where  mov_parcela              = 1 
      and    mov_ano_referencia       = p_ano_pagamento
      and    mov_mes_referencia       = p_mes_pagamento
      and    mov_versao_pagamento     = 1
      and    mov_sequencial           = 1
      and    mov_rub_codigo           = p_rubrica
      and    mov_emp_numero_matricula = p_matricula
      and    mov_tip_rubrica          = p_tipo_lancamento;

   exception
     when no_data_found then
          dbms_output.put_line('Erro de processamento. Não é possível lançar participações na folha de pagamento.');
     when others then
          v_error_code     := SQLCODE;
          v_error_message  := SQLERRM; 
          dbms_output.put_line('Erro de processamento ao alterar tabela de movimentação - '||to_char(v_error_code)||' - '||v_error_message);
  end;

      
  end if;

end insere_participacao_folha;

/
/*
create or replace function verifica_folha_beneficio(p_mes_pagamento in number,
                                                    p_ano_pagamento in number,
                                                    p_dependencia in number) return boolean 

/* =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-= */
/*
|| Nome         : Verifica_Folha_Beneficio
|| Autora       : Yara Fonseca
|| Date Created : 06/02/2002
||
|| Obejetivo: Função que verifica se a folha está aberta para lançamentos
||            do benefício. 
||
||
*/
/*
is

v_conta number(10);

begin

  select count(*) into v_conta
  from cronogramas_pagamentos
  where crp_data_realizacao is not null
  and crp_dep_codigo      = p_dependencia
  and crp_epg_codigo      = 11
  and crp_mes_pagamento   = p_mes_pagamento
  and crp_ano_pagamento   = p_ano_pagamento;

  return(true);
 
exception

  when no_data_found then
       return(false);
 when others then
       return(false);
end verifica_folha_beneficio;
*/