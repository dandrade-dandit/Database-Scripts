


CREATE OR REPLACE
procedure trata_movimentacao_cad(p_dep              in number,
                                   p_matricula        in number,
                                   p_ofu_codigo       in number,
                                   p_fun_codigo       in number,
                                   p_tp_oper          in char,
                                   p_sfu_codigo       in number,
                                   p_dt_ini_ocor      in date,
                                   p_dt_fim_ocor      in date,
                                   p_dt_inc_ocor      in date,
                                   p_dt_ini_212       in date,
                                   p_dt_fim_212       in date,
                                   p_dt_ini_ant       in date,
                                   p_dt_fim_ant       in date,
                                   p_tp_remunera      in char,
                                   p_nivel            in number,
                                   p_padrao           in char,
                                   p_escola           in char,
                                   par_cod_erro       in out number,
                                   par_msg_erro       in out varchar2) is
  ---------------------------------------------------------------------------------
  -- Procedure que inclui, exclui, encerra, cancela e troca tipo de recebimento  --
  -- de função de confiança.                                                     --
  --                                                                             --
  -- Observacoes:
  --   1 - Será processada nos programas do cadastro de designação de função de  --
  --       confiança, designação de contratos especiais, substituição de função  --
  --       de confiança, dispensa de função de confiança, cancelamento de função --
  --       de confiança, opção tipo função de confiança.                         --
  --   2 - Campos passados com parâmetros para tratamento da ocorrência de FC    --
  --       p_dep         - Dependência de lotação do empregado                   --
  --       p_matricula   - Matrícula do empregado                                --
  --       p_ofu_codigo  - Código da ocorrência da FC                            --
  --       p_fun_codigo  - Código da FC                                          --
  --       p_tp_oper     - Indica o tipo da operação (E - exclusão, I - inclução,--
  --                     - C - cancelamento, R - mudança de tipo de recebimento, --
  --                     - D - desligamento)                                     --
  --       p_sfu_codigo  - Indica a situação funcional do empregado              --
  --       p_dt_ini_ocor - Data início da ocorrência de FC                       --
  --       p_dt_fim_ocor - Data término da ocorrência de FC                      --
  --       p_dt_inc_ocor - Data inclusão da ocorrência de FC                     --
  --                                                                             --
  --       Estes quatro campos somente serão preenchidos quando for uma troca    --
  --       de recebimento.                                                       --
  --       p_dt_ini_212  - Data início da nova ocorrência 212                    --
  --       p_dt_fim_212  - Data término da nova ocorrência 212                   --
  --       p_dt_ini_ant  - Data início da ocorrência 212 que está sendo fechado  --
  --       p_dt_fim_ant  - Data término da ocorrência 212 que está sendo fechado --
  --                                                                             --
  --       p_tp_remunera - FG - Função gratificada e RG - Remuneração global     --
  --       p_nivel       - Campo emp_nsa_codigo_nivel da tabela de cadastros     --
  --       p_padrao      - Campo emp_nsa_codigo_padrao da tabela de cadastros    --
  --       p_escola      - Campo emp_nsa_in_nivel_escolaridade da tab. cadastros --
  --       par_cod_erro  - Campo de retorno 0 - normal, diferente de 0 erro      --
  --       par_msg_erro  - Texto explicativo quando ocorrer algum erro           --
  --                                                                             --
  ---------------------------------------------------------------------------------
     v_data_ref           date;
     v_data_adm           date;
     v_pagto_mes          varchar2(3);
     v_mes_ref            number(2);
     v_ano_ref            number(4);
     v_mes_ini            number(2);
     v_ano_ini            number(4);
     v_dia_fim_mes        number(2);
     v_seq_pagamento      movimentacao.mov_rub_seq_pagamento%type;
     v_seq                movimentacao.mov_sequencial%type;
     v_dias_trabalhados   movimentacao.mov_dias_proporcionalidade%type;
     v_rubrica            movimentacao.mov_rub_codigo%type;
     v_rubrica_a          movimentacao.mov_rub_codigo%type;
     v_parcela            movimentacao.mov_parcela%type;
     v_dias_1010          movimentacao.mov_dias_proporcionalidade%type;
     v_operando           movimentacao.mov_dias_proporcionalidade%type;
     cursor c_pago is
         select mov_ano_referencia, mov_mes_referencia
         from   movimentacao
         where  to_number(to_char(mov_ano_referencia)||
                          lpad(to_char(mov_mes_referencia),2,'0')
                          ) >=
                to_number(to_char(v_ano_ini)||lpad(to_char(v_mes_ini),2,'0')
                         )
         and    mov_emp_numero_matricula = p_matricula
         and    mov_oem_emp_numero_matricula = p_matricula
         and    mov_oem_ofu_codigo  = p_ofu_codigo
         and    mov_oem_data_inicio = p_dt_ini_ocor
         order  by 1,2;
     r_pago               c_pago%rowtype;
  --------------------------------------------------------------------------
  --                        Inclui movimentacao                           --
  --------------------------------------------------------------------------
  Procedure inclui_movimentacao is
  Begin
     begin
        select rub_seq_pagamento
        into   v_seq_pagamento
        from   rubricas
        where  rub_codigo = v_rubrica;
     end;
     begin
        v_seq := busca_mov_seq (v_mes_ref, v_ano_ref, 1, p_matricula, v_rubrica, 'N');
        insert into movimentacao
           (mov_ano_referencia, mov_mes_referencia, mov_versao_pagamento,
          mov_emp_numero_matricula, mov_rub_codigo, mov_sequencial,
          mov_parcela, mov_parcela_atual, mov_tipo_parametro,
          mov_parametro, mov_tip_rubrica, mov_ind_calculo,
          mov_rub_seq_pagamento, mov_fun_codigo, mov_tipo_funcao,
          mov_ind_exclusivo, mov_dias_proporcionalidade,
          mov_nsa_codigo_nivel, mov_nsa_codigo_padrao,
          mov_nsa_indicador_nivel_escola, mov_emp_dep_codigo_pagto,
                mov_oem_ofu_codigo, mov_oem_data_inicio, mov_oem_emp_numero_matricula)
        values (v_ano_ref, v_mes_ref, 1, p_matricula, v_rubrica, v_seq,
                v_parcela, v_parcela, null, null, 'N', 'N', v_seq_pagamento,
                p_fun_codigo, p_tp_remunera, 'N', v_dias_trabalhados,
                p_nivel, p_padrao, p_escola, p_dep, p_ofu_codigo, p_dt_ini_ocor,
                p_matricula);
     end;
  End;
  /* AGREGADO 07/03/2003 */
  --------------------------------------------------------------------------
  --                    Atualiza funcao movimentacao                      --
  --------------------------------------------------------------------------
  Procedure update_movimentacao_funcao is
    v_rub_codigo MOVIMENTACAO.mov_rub_codigo%TYPE;
    --
    begin
        -- pega codigo de rubrica segum tipo remuneracao
        if p_tp_remunera = 'FG' then
          v_rub_codigo := 1015;
        elsif p_tp_remunera = 'RG' then
          v_rub_codigo := 1010;
        end if;
        --
        update movimentacao
           set mov_fun_codigo = p_fun_codigo
         where mov_ano_referencia         = v_ano_ref
           and mov_mes_referencia         = v_mes_ref
           and mov_versao_pagamento       = 1
           and mov_emp_numero_matricula   = p_matricula
           and mov_rub_codigo             = v_rub_codigo
           and mov_tip_rubrica            = 'N'
           and mov_oem_ofu_codigo         = p_ofu_codigo
           and mov_oem_data_inicio        = p_dt_ini_ocor;
     exception
        when no_data_found then
           null;
    End;
  /* FIM AGREGADO 07/03/2003 */
  --------------------------------------------------------------------------
  --                        Fecha movimentacao                            --
  --------------------------------------------------------------------------
  Procedure fecha_movimentacao is
  Begin
     begin
        update movimentacao
        set    mov_dias_proporcionalidade   = v_dias_trabalhados,
               mov_parcela                  = 1,
               mov_parcela_atual            = 1,
               mov_oem_emp_numero_matricula = null,
               mov_oem_ofu_codigo           = null,
               mov_oem_data_inicio          = null
        where  mov_ano_referencia         = v_ano_ref
        and    mov_mes_referencia         = v_mes_ref
        and    mov_versao_pagamento       = 1
        and    mov_emp_numero_matricula   = p_matricula
        and    mov_rub_codigo             = v_rubrica_a
        and    mov_tip_rubrica            = 'N'
        and    mov_oem_ofu_codigo         = p_ofu_codigo
        and    mov_oem_data_inicio        = p_dt_ini_ocor;
     exception
        when no_data_found then
           null;
     end;
  End;
  --------------------------------------------------------------------------
  --                       Busca dias 1010                                --
  --------------------------------------------------------------------------
  Procedure busca_dias_1010 is
  Begin
     v_operando := 0;
     select nvl(sum(mov_dias_proporcionalidade),0)
     into   v_operando
     from   movimentacao
     where  mov_ano_referencia         = v_ano_ref
     and    mov_mes_referencia         = v_mes_ref
     and    mov_versao_pagamento       = 1
     and    mov_emp_numero_matricula   = p_matricula
     and    mov_rub_codigo             = 1010
     and    mov_tip_rubrica            = 'N';
  Exception
     when no_data_found then
        null;
  End;
  --------------------------------------------------------------------------
  --                       Trata rubrica 1000                             --
  --------------------------------------------------------------------------
  Procedure trata_1000  (p_dias number) is
  Begin
     update movimentacao
     set    mov_dias_proporcionalidade = p_dias
     where  mov_ano_referencia         = v_ano_ref
     and    mov_mes_referencia         = v_mes_ref
     and    mov_versao_pagamento       = 1
     and    mov_emp_numero_matricula   = p_matricula
     and    mov_rub_codigo             = 1000
     and    mov_tip_rubrica            = 'N';
  Exception
     when no_data_found then
        null;
  End;
  --------------------------------------------------------------------------
  --                        Trata troca recebimento                       --
  --------------------------------------------------------------------------
  Procedure trata_troca_recebimento is
  Begin
  --
  --     Se a ocorrência 212 é anterior ao mês aberto, o término da mesma, será a
  --     quantidade de dias trabalhados naquela opção de recebimento, porém, se
  --     for dentro do mês aberto os dias trabalhados serão a data término menos a
  --     data início.
  --     As data 212 são da nova ocorrência, já as ant são da 212 que está sendo fechada.
  --
     v_dias_trabalhados := 0;
     if to_number(to_char(p_dt_ini_ant,'yyyymm')) <
        to_number(to_char(v_data_ref,'yyyymm')) then
        v_dias_trabalhados := to_number(to_char(p_dt_fim_ant,'dd'));
     else
        v_dias_trabalhados := (to_number(to_char(p_dt_fim_ant,'dd')) -
                               to_number(to_char(p_dt_ini_ant,'dd')) + 1);
     end if;
  --
  --  Vamos agora atualizar a rubrica que está sendo encerrada.
  --
     if p_tp_remunera = 'FG' then
        v_rubrica_a := 1010;
        v_rubrica   := 1015;
     elsif p_tp_remunera = 'RG' then
        v_rubrica_a := 1015;
        v_rubrica   := 1010;
     end if;
  --
     fecha_movimentacao;
  --
     v_dias_trabalhados := 0;
     if p_dt_fim_212 is null or
        to_number(to_char(p_dt_fim_212,'yyyymm')) >
        to_number(to_char(v_data_ref,'yyyymm')) then
        v_parcela := 999;
        if to_number(to_char(p_dt_ini_212,'yyyymm')) =
           to_number(to_char(v_data_ref,'yyyymm')) then
           v_dias_trabalhados := (30 - to_number(to_char(p_dt_ini_212,'dd')) + 1);
        end if;
     else
        v_parcela := 1;
        if to_number(to_char(p_dt_ini_212,'yyyymm')) =
           to_number(to_char(v_data_ref,'yyyymm')) then
           v_dias_trabalhados := to_number(to_char(p_dt_fim_212,'dd')) -
                                 to_number(to_char(p_dt_ini_212,'dd')) + 1;
        end if;
     end if;
  --
     inclui_movimentacao;
  --
     busca_dias_1010;
     if p_sfu_codigo = 1 then
        if p_ofu_codigo not in (89, 217, 220) then
           trata_1000 (30 - v_operando);
        end if;
     end if;
  --
  End;
  --------------------------------------------------------------------------
  --                        Trata desligamento                            --
  --------------------------------------------------------------------------
  Procedure trata_desligamento is
  Begin
     v_dias_trabalhados := 0;
     if to_number(to_char(p_dt_fim_ocor,'yyyymm')) >
        to_number(to_char(p_dt_ini_ocor,'yyyymm')) then
        v_dias_trabalhados := to_number(to_char(p_dt_fim_ant,'dd'));
     elsif to_number(to_char(p_dt_fim_ocor,'yyyymm')) =
           to_number(to_char(p_dt_ini_ocor,'yyyymm')) then
        v_dias_trabalhados := (to_number(to_char(p_dt_fim_ant,'dd')) -
                               to_number(to_char(p_dt_ini_ant,'dd')) + 1);
     end if;
     if v_dias_trabalhados > 30 then
        v_dias_trabalhados := 30;
     end if;
     begin
        update movimentacao
        set    mov_dias_proporcionalidade = v_dias_trabalhados,
               mov_parcela                = 1,
               mov_parcela_atual          = 1
        where  mov_ano_referencia         = v_ano_ref
        and    mov_mes_referencia         = v_mes_ref
        and    mov_versao_pagamento       = 1
        and    mov_emp_numero_matricula   = p_matricula
        and    mov_tip_rubrica            = 'N'
        and    mov_oem_ofu_codigo         = p_ofu_codigo
        and    mov_oem_data_inicio        = p_dt_ini_ocor;
     exception
        when no_data_found then
           null;
     end;
     busca_dias_1010;
     if p_sfu_codigo = 1 and p_tp_remunera = 'RG' then
        if p_ofu_codigo not in (89, 217, 220) then
           if to_number(to_char(p_dt_fim_ocor,'yyyymm')) >
              to_number(to_char(v_data_adm,'yyyymm')) then
              trata_1000(30 - v_operando);
           else
              trata_1000((30 - to_number(to_char(v_data_adm,'dd')) + 1) - v_operando);
           end if;
        end if;
     end if;
  End;
  --------------------------------------------------------------------------
  --                        trata_desligamento_mes_ant                    --
  --------------------------------------------------------------------------
  /* AGREGADO 20/02/2003 */
  Procedure trata_desligamento_mes_ant is
      v_rub_codigo NUMBER(8);
    Begin
      -- pega codigo de rubrica segum tipo remuneracao
      if p_tp_remunera = 'FG' then
        v_rub_codigo := 1015;
      elsif p_tp_remunera = 'RG' then
        v_rub_codigo := 1010;
      end if;
      --
      --
      delete
        from MOVIMENTACAO
       where MOV_ANO_REFERENCIA = v_ano_ref
         and MOV_MES_REFERENCIA = v_mes_ref
         and MOV_VERSAO_PAGAMENTO = 1
         and MOV_RUB_CODIGO = v_rub_codigo
         and MOV_EMP_NUMERO_MATRICULA = p_matricula;
    exception
      when others then
        null;
    end;
  /* FIM AGREGADO 20/02/2003 */
  --------------------------------------------------------------------------
  --                      trata_proporcionalidade                         --
  --------------------------------------------------------------------------
  Procedure trata_proporcionalidade is
  Begin
     v_dias_trabalhados := 0;
     if p_dt_fim_ocor is null or
        to_number(to_char(p_dt_fim_ocor,'yyyymm')) >
        to_number(to_char(v_data_ref,'yyyymm')) then
        v_parcela := 999;
        if to_number(to_char(p_dt_ini_ocor,'yyyymm')) =
           to_number(to_char(v_data_ref,'yyyymm')) then
           v_dias_trabalhados := (30 - to_number(to_char(p_dt_ini_ocor,'dd')) + 1);
        elsif to_number(to_char(p_dt_ini_ocor,'yyyymm')) <
              to_number(to_char(v_data_ref,'yyyymm')) then
           v_dias_trabalhados := 30;
        elsif to_number(to_char(p_dt_ini_ocor,'yyyymm')) >
              to_number(to_char(v_data_ref,'yyyymm')) then
           v_dias_trabalhados := 30;
        end if;
     else
        v_parcela := 1;
        if to_number(to_char(p_dt_ini_ocor,'yyyymm')) =
           to_number(to_char(v_data_ref,'yyyymm')) then
           v_dias_trabalhados := to_number(to_char(p_dt_fim_ocor,'dd')) -
                                 to_number(to_char(p_dt_ini_ocor,'dd')) + 1;
        else
           v_dias_trabalhados := to_number(to_char(p_dt_fim_ocor,'dd'));
           if v_dias_trabalhados > 30 then
              v_dias_trabalhados := 30;
           end if;
        end if;
     end if;
     inclui_movimentacao;
  End;
  --------------------------------------------------------------------------
  --                   trata_proporcionalidade_subst                      --
  --------------------------------------------------------------------------
  Procedure trata_proporcionalidade_subst is
  Begin
     v_dias_trabalhados := 0;
     if p_dt_fim_ocor is null or
        to_number(to_char(p_dt_fim_ocor,'yyyymm')) >
        to_number(to_char(v_data_ref,'yyyymm')) then
        v_parcela := 999;
        v_dia_fim_mes := to_number(to_char(last_day(v_data_ref),'dd'));
        if to_number(to_char(p_dt_ini_ocor,'yyyymm')) =
           to_number(to_char(v_data_ref,'yyyymm')) then
           v_dias_trabalhados := (v_dia_fim_mes - to_number(to_char(p_dt_ini_ocor,'dd')) + 1);
        else
           v_dias_trabalhados := v_dia_fim_mes;
        end if;
     else
        v_parcela := 1;
        if to_number(to_char(p_dt_ini_ocor,'yyyymm')) =
           to_number(to_char(v_data_ref,'yyyymm')) then
           v_dias_trabalhados := to_number(to_char(p_dt_fim_ocor,'dd')) -
                                 to_number(to_char(p_dt_ini_ocor,'dd')) + 1;
        else
           v_dias_trabalhados := to_number(to_char(p_dt_fim_ocor,'dd'));
        end if;
     end if;
     inclui_movimentacao;
  End;
  --------------------------------------------------------------------------
  --                        Trata inclusão                                --
  --------------------------------------------------------------------------
  Procedure trata_inclusao is
  Begin
     if p_ofu_codigo in (86, 88, 93) then
        if p_tp_remunera = 'RG' then
           v_rubrica := 1010;
           trata_proporcionalidade;
           busca_dias_1010;
           if p_sfu_codigo = 1 then -- Atualiza rubrica de pagamento para empregados.
              if to_number(to_char(p_dt_ini_ocor,'yyyymm')) >
                 to_number(to_char(v_data_adm,'yyyymm')) then
                 trata_1000 (30 - v_operando);
              else
                 trata_1000 ((30 - to_number(to_char(v_data_adm,'dd')) + 1) - v_operando);
              end if;
           end if;
        elsif p_tp_remunera = 'FG' then
           v_rubrica := 1015;
           trata_proporcionalidade;
        end if;
     elsif p_ofu_codigo in (85, 217) then
        v_rubrica := 1030;
        trata_proporcionalidade_subst;
     elsif p_ofu_codigo in (89, 220) then
        v_rubrica := 1020;
        trata_proporcionalidade_subst;
     elsif p_ofu_codigo = 238 or p_ofu_codigo = 240 then
        v_rubrica := 1065;
        trata_proporcionalidade;
        v_rubrica := 1070;
        trata_proporcionalidade;
     elsif p_ofu_codigo = 125 then
        v_rubrica := 1060;
        trata_proporcionalidade;
        v_rubrica := 1070;
        trata_proporcionalidade;
     elsif p_ofu_codigo = 256 then
        trata_desligamento;
     end if;
  End;
  --**********************************************************************--
  --**                INÍCIO DA PROCEDURE PRINCIPAL                     **--
  --**********************************************************************--
  Begin
     par_cod_erro := 0;
     par_msg_erro := null;
     v_mes_ini := to_number(to_char(p_dt_ini_ocor,'mm'));
     v_ano_ini := to_number(to_char(p_dt_ini_ocor,'yyyy'));
     --
     IF p_tp_oper = 'D' THEN
       v_data_ref := verifica_referencia(to_number(to_char(p_dt_fim_ocor,'mm')),
                                         to_number(to_char(p_dt_fim_ocor,'yyyy')),
                                         p_dep);
     ELSE 
       v_data_ref := verifica_referencia(v_mes_ini,v_ano_ini,p_dep);
     END IF;  
     
     v_mes_ref  := to_number(to_char(v_data_ref,'mm'));
     v_ano_ref  := to_number(to_char(v_data_ref,'yyyy'));
  -- Verifica se folha já foi paga.
     open c_pago;
     loop
        fetch c_pago into r_pago;
        exit when c_pago%notfound;
        Begin
           select 'SIM'
           into   v_pagto_mes
           from   cronogramas_pagamentos
           where  crp_dep_codigo    = p_dep
           and    crp_epg_codigo    = 4 -- evento de pagamento
           and    crp_ano_pagamento = r_pago.mov_ano_referencia
           and    crp_mes_pagamento = r_pago.mov_mes_referencia
           and    crp_sequencial    = 1
           and    crp_data_realizacao is not null;
        exception
           when no_data_found then
                v_pagto_mes := 'NAO';
        end;
        if v_pagto_mes = 'SIM' then
           exit;
        end if;
     end loop;
     close c_pago;
  -- Recupera data de admissão do empregado
     begin
        select emp_data_admissao
        into   v_data_adm
        from   cadastros
        where  emp_numero_matricula = p_matricula;
     end;
  -- Tratamento dos tipos de transações:
  --       E - exclusão,
  --       C - cancelamento,
  --       R - mudança de tipo de recebimento,
  --       D - desligamento,
  --       I - inclusão,
  --       M - modificação.
     if p_tp_oper = 'E' then
        if v_pagto_mes = 'SIM' then
           par_cod_erro := 1;
           par_msg_erro := 'Transação de exclusão não permitida, já existe um evento de '||
                           'pagamento para esta ocorrência. O procedimento permitido é '||
                           'o cancelamento da ocorrência.';
        else
           delete movimentacao
           where  mov_emp_numero_matricula = p_matricula
           and    mov_oem_ofu_codigo       = p_ofu_codigo
           and    mov_oem_data_inicio      = p_dt_ini_ocor;
           if sql%notfound then
              null;
           end if;
           if p_tp_remunera = 'RG' and p_sfu_codigo = 1 then
              busca_dias_1010;
              if p_ofu_codigo not in (89, 217, 220) then
                 if to_number(to_char(p_dt_ini_ocor,'yyyymm')) >
                    to_number(to_char(v_data_adm,'yyyymm')) then
                    trata_1000(30 - v_operando);
                 else
                    trata_1000((30 - to_number(to_char(v_data_adm,'dd')) + 1) - v_operando);
                 end if;
              end if;
           end if;
        end if;
     elsif p_tp_oper = 'C' then
        if v_pagto_mes = 'NAO' then
           par_cod_erro := 1;
           par_msg_erro := 'Transação de cancelamento não permitida, não existe um evento de '||
                           'pagamento para esta ocorrência. O procedimento permitido é '||
                           'a exclusão da ocorrência.';
        else
           delete movimentacao
           where  mov_ano_referencia       = v_ano_ref
           and    mov_mes_referencia       = v_mes_ref
           and    mov_versao_pagamento     = 1
           and    mov_emp_numero_matricula = p_matricula
           and    mov_oem_ofu_codigo       = p_ofu_codigo
           and    mov_oem_data_inicio      = p_dt_ini_ocor;
           if sql%notfound then
              null;
           end if;
           if p_tp_remunera = 'RG' and p_sfu_codigo = 1 then
              busca_dias_1010;
              if p_ofu_codigo not in (89, 217, 220) then
                 if to_number(to_char(p_dt_ini_ocor,'yyyymm')) >
                    to_number(to_char(v_data_adm,'yyyymm')) then
                    trata_1000(30 - v_operando);
                 else
                    trata_1000((30 - to_number(to_char(v_data_adm,'dd')) + 1) - v_operando);
                 end if;
              end if;
           end if;
        end if;
     elsif p_tp_oper = 'R' then
        if p_dt_fim_ant is null then
           par_cod_erro := 1;
           par_msg_erro := 'Transação de mudança de tipo de recebimento não permitida, '||
                           'não existe a data do término da antiga ocorrência 212.';
        elsif p_dt_ini_ant is null then
           par_cod_erro := 1;
           par_msg_erro := 'Transação de mudança de tipo de recebimento não permitida, '||
                           'não existe a data do início da antiga ocorrência 212.';
        elsif p_dt_ini_212 is null then
           par_cod_erro := 1;
           par_msg_erro := 'Transação de mudança de tipo de recebimento não permitida, '||
                           'não existe a data do início da nova ocorrência 212.';
        elsif p_dt_ini_ocor is null then
           par_cod_erro := 1;
           par_msg_erro := 'Transação de mudança de tipo de recebimento não permitida, '||
                           'não existe a data do início da ocorrência de Função de Confiança.';
        elsif to_number(to_char(v_data_ref,'yyyymm')) <>
              to_number(to_char(p_dt_ini_212,'yyyymm')) then
           par_cod_erro := 1;
           par_msg_erro := 'Transação de mudança de tipo de recebimento não permitida, '||
                           'mês e ano da data início da ocorrência 212, está diferente '||
                           'do mês aberto.';
        else
           trata_troca_recebimento;
        end if;
     elsif p_tp_oper = 'D' then
        if p_dt_fim_ocor is null then
           par_cod_erro := 1;
           par_msg_erro := 'Transação de encerramento não permitida, não '||
                           'existe a data do término da ocorrência.';
        else
           if to_number(to_char(p_dt_fim_ocor, 'yyyymm')) <
              to_number(to_char(v_data_ref, 'yyyymm')) then
              /* AGREGADO 20/02/2003 */
              /* Alterado 06/06/2003 */       
                -- Apaga da folha aberta a funçao do empregado, pois já não tem.  
                trata_desligamento_mes_ant;
              /* FIM AGREGADO 20/02/2003 */
              /* Alterado 06/06/2003 */                 
           elsif to_number(to_char(p_dt_fim_ocor, 'yyyymm')) >
                 to_number(to_char(v_data_ref, 'yyyymm')) then
              par_cod_erro := 2;
              par_msg_erro := 'Transação não gera qualquer alteração na tabela de '||
                              'movimentação. Data término da ocorrência é '||
                              'superior ao mês de pagamento aberto.';
           else -- é igual
              -- Atualiza a informção da função na folha aberta 
              trata_desligamento;
           end if;
        end if;
     elsif p_tp_oper = 'I' then
        if p_dt_fim_ocor is not null then
           if to_number(to_char(p_dt_fim_ocor, 'yyyymm')) <
              to_number(to_char(v_data_ref, 'yyyymm')) then
              par_cod_erro := 2;
              par_msg_erro := 'Transação não gera qualquer alteração na tabela de '||
                              'movimentação. Datas início e término da ocorrência '||
                              'são inferiores ao mês de pagamento aberto.';
           else
              trata_inclusao;
           end if;
        else
           trata_inclusao;
        end if;
     /* AGREGADO 07/03/2003*/
     elsif p_tp_oper = 'M' then
        if v_pagto_mes = 'SIM' then
           par_cod_erro := 1;
           par_msg_erro := 'Transação de modificação não permitida, já existe um evento de '||
                           'pagamento para esta ocorrência.';
        else
          update_movimentacao_funcao;
        end if;
     /* FIM AGREGADO 07/03/2003*/
     end if;
  End;
/




