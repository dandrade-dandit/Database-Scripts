create or replace function Retorna_salariobas(par_mes       number,
                                              par_ano       number,
                                              par_matricula number) return number is
   v_sfu_codigo     number(1);
   v_valor_salario  historico_niveis_salariais.hns_valor_remuneracao%type;
   v_valor_operando number(14,5);
   v_funcao         movimentacao.mov_fun_codigo%type;
   v_tipo_funcao    cadastros.emp_tipo_remuneracao_funcao%type;
   --
   Procedure grava_erro is
     v_erro varchar2(300);
   Begin
     v_erro := 'Consolidado - ' || sqlcode||' - '||sqlerrm;
     insert into EVENTO_FOLHA( evf_mes_referencia,evf_ano_referencia,evf_versao_pagamento,
                            evf_rub_codigo,evf_emp_numero_matricula,evf_mensagem,
                            evf_cdr_cod_rotina,evf_data_evento)
     values (par_mes, par_ano, 1,
             null, par_matricula, v_erro,
             '6', sysdate);
   End grava_erro;
   --
   Function Retorna_valor_funcao (p_fun_codigo number,
                                  p_tipo_funcao varchar2 default null) return number is
      v_tipo_funcao1   varchar2(2);
      v_valor_operando number(14,5);
      v_valor_rg       categorias_funcoes_valor.cfv_valor_rg%type;
      v_valor_fg       categorias_funcoes_valor.cfv_valor_fg%type;
   Begin
     v_tipo_funcao1 := p_tipo_funcao;
     if v_tipo_funcao1 = 'DI' then
        --
        Begin
           -- Obtem constante com código 11
           select col_valor
           into   v_valor_operando
           from   constantes_legais,
                 (select max(to_date(to_char(col_mes_referencia)||'/'||
                                     to_char(col_ano_referencia),'MM/YYYY')) data
                  from   constantes_legais
                  where  to_number(lpad(to_char(col_ano_referencia),4,'0')||
                                   lpad(to_char(col_mes_referencia),2,'0')) <=
                         to_number(lpad(to_char(par_ano),4,'0')||
                                   lpad(to_char(par_mes),2,'0'))) table_data
           where  to_date(to_char(col_mes_referencia)||'/'||
                          to_char(col_ano_referencia),'MM/YYYY') = table_data.data
           and    col_codigo = 11;
           --
        Exception
          when no_data_found then
            v_valor_operando := 0;
          when others then
            grava_erro;
        End;
        --
     elsif v_tipo_funcao1 in ('RG','FG') then
        Begin
          select cfv.cfv_valor_rg, cfv.cfv_valor_fg
          into   v_valor_rg, v_valor_fg
          from   funcoes fun, categorias_funcoes_valor cfv
          where  fun.fun_codigo     = p_fun_codigo
          and    fun.fun_cfu_codigo = cfv.cfv_cfu_codigo
          and    cfv.cfv_data_vigencia in
                (select max(cfv1.cfv_data_vigencia)
                 from   categorias_funcoes_valor cfv1
                 where  cfv1.cfv_cfu_codigo = cfv.cfv_cfu_codigo
                 and    to_number(to_char(cfv1.cfv_data_vigencia,'yyyymm')) <=
                        to_number(lpad(to_char(par_ano),4,'0')||
                                  lpad(to_char(par_mes),2,'0')));
        Exception
          when no_data_found then
            v_valor_operando := 0;
          when others then
            grava_erro;
        End;
        if v_tipo_funcao1 = 'RG' then
           v_valor_operando := nvl(v_valor_rg,0);
        elsif v_tipo_funcao1 = 'FG' then
           v_valor_operando := nvl(v_valor_fg,0);
        end if;
     else
        v_valor_operando := 0;
     end if;
     --
     return (v_valor_operando);
     --
   Exception
     when others then
        grava_erro;
   End Retorna_valor_funcao;
   --
Begin
	 --
  select emp_sfu_codigo
  into   v_sfu_codigo
  from   cadastros
  where  emp_numero_matricula = par_matricula;
  if v_sfu_codigo = 1 then
     Begin
       select hns.hns_valor_remuneracao
       into   v_valor_salario
       from   cadastros emp, historico_niveis_salariais hns
       where  emp.emp_numero_matricula           = par_matricula
       and    hns.hns_nsa_codigo_nivel           = emp.emp_nsa_codigo_nivel
       and    hns.hns_nsa_codigo_padrao          = emp.emp_nsa_codigo_padrao
       and    hns.hns_nsa_indicador_nivel_escola = emp.emp_nsa_in_nivel_escolaridade
       and    hns.hns_data_vigencia =
   	         (select max(hns.hns_data_vigencia)
              from   historico_niveis_salariais hns, cadastros
              where  emp_numero_matricula          = par_matricula
              and    emp_nsa_in_nivel_escolaridade = hns.hns_nsa_indicador_nivel_escola
              and    to_number(to_char(hns.hns_data_vigencia,'yyyymm')) <=
                     to_number(lpad(to_char(par_ano),4,'0')||
                               lpad(to_char(par_mes),2,'0')));
     Exception
       when no_data_found then
         v_valor_salario := 0;
       when others then
         grava_erro;
     End;
     v_valor_operando := v_valor_salario;
  elsif (v_sfu_codigo = 2  or v_sfu_codigo = 4) then
     begin
        select emp_qfu_fun_codigo, emp_tipo_remuneracao_funcao
        into   v_funcao, v_tipo_funcao
        from   cadastros
        where  emp_numero_matricula = par_matricula;
     exception
        when others then
          grava_erro;
     end;
     --
     v_valor_salario := retorna_valor_funcao(v_funcao, v_tipo_funcao);
     --
  end if;
  --
  return(v_valor_operando);
  --
Exception
  when others then
     grava_erro;
End;
