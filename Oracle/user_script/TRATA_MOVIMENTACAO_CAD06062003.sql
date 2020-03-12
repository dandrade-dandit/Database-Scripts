


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
  -- de fun��o de confian�a.                                                     --
  --                                                                             --
  -- Observacoes:
  --   1 - Ser� processada nos programas do cadastro de designa��o de fun��o de  --
  --       confian�a, designa��o de contratos especiais, substitui��o de fun��o  --
  --       de confian�a, dispensa de fun��o de confian�a, cancelamento de fun��o --
  --       de confian�a, op��o tipo fun��o de confian�a.                         --
  --   2 - Campos passados com par�metros para tratamento da ocorr�ncia de FC    --
  --       p_dep         - Depend�ncia de lota��o do empregado                   --
  --       p_matricula   - Matr�cula do empregado                                --
  --       p_ofu_codigo  - C�digo da ocorr�ncia da FC                            --
  --       p_fun_codigo  - C�digo da FC                                          --
  --       p_tp_oper     - Indica o tipo da opera��o (E - exclus�o, I - inclu��o,--
  --                     - C - cancelamento, R - mudan�a de tipo de recebimento, --
  --                     - D - desligamento)                                     --
  --       p_sfu_codigo  - Indica a situa��o funcional do empregado              --
  --       p_dt_ini_ocor - Data in�cio da ocorr�ncia de FC                       --
  --       p_dt_fim_ocor - Data t�rmino da ocorr�ncia de FC                      --
  --       p_dt_inc_ocor - Data inclus�o da ocorr�ncia de FC                     --
  --                                                                             --
  --       Estes quatro campos somente ser�o preenchidos quando for uma troca    --
  --       de recebimento.                                                       --
  --       p_dt_ini_212  - Data in�cio da nova ocorr�ncia 212                    --
  --       p_dt_fim_212  - Data t�rmino da nova ocorr�ncia 212                   --
  --       p_dt_ini_ant  - Data in�cio da ocorr�ncia 212 que est� sendo fechado  --
  --       p_dt_fim_ant  - Data t�rmino da ocorr�ncia 212 que est� sendo fechado --
  --                                                                             --
  --       p_tp_remunera - FG - Fun��o gratificada e RG - Remunera��o global     --
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
  --     Se a ocorr�ncia 212 � anterior ao m�s aberto, o t�rmino da mesma, ser� a
  --     quantidade de dias trabalhados naquela op��o de recebimento, por�m, se
  --     for dentro do m�s aberto os dias trabalhados ser�o a data t�rmino menos a
  --     data in�cio.
  --     As data 212 s�o da nova ocorr�ncia, j� as ant s�o da 212 que est� sendo fechada.
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
  --  Vamos agora atualizar a rubrica que est� sendo encerrada.
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
  --                        Trata inclus�o                                --
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
  --**                IN�CIO DA PROCEDURE PRINCIPAL                     **--
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
  -- Verifica se folha j� foi paga.
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
  -- Recupera data de admiss�o do empregado
     begin
        select emp_data_admissao
        into   v_data_adm
        from   cadastros
        where  emp_numero_matricula = p_matricula;
     end;
  -- Tratamento dos tipos de transa��es:
  --       E - exclus�o,
  --       C - cancelamento,
  --       R - mudan�a de tipo de recebimento,
  --       D - desligamento,
  --       I - inclus�o,
  --       M - modifica��o.
     if p_tp_oper = 'E' then
        if v_pagto_mes = 'SIM' then
           par_cod_erro := 1;
           par_msg_erro := 'Transa��o de exclus�o n�o permitida, j� existe um evento de '||
                           'pagamento para esta ocorr�ncia. O procedimento permitido � '||
                           'o cancelamento da ocorr�ncia.';
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
           par_msg_erro := 'Transa��o de cancelamento n�o permitida, n�o existe um evento de '||
                           'pagamento para esta ocorr�ncia. O procedimento permitido � '||
                           'a exclus�o da ocorr�ncia.';
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
           par_msg_erro := 'Transa��o de mudan�a de tipo de recebimento n�o permitida, '||
                           'n�o existe a data do t�rmino da antiga ocorr�ncia 212.';
        elsif p_dt_ini_ant is null then
           par_cod_erro := 1;
           par_msg_erro := 'Transa��o de mudan�a de tipo de recebimento n�o permitida, '||
                           'n�o existe a data do in�cio da antiga ocorr�ncia 212.';
        elsif p_dt_ini_212 is null then
           par_cod_erro := 1;
           par_msg_erro := 'Transa��o de mudan�a de tipo de recebimento n�o permitida, '||
                           'n�o existe a data do in�cio da nova ocorr�ncia 212.';
        elsif p_dt_ini_ocor is null then
           par_cod_erro := 1;
           par_msg_erro := 'Transa��o de mudan�a de tipo de recebimento n�o permitida, '||
                           'n�o existe a data do in�cio da ocorr�ncia de Fun��o de Confian�a.';
        elsif to_number(to_char(v_data_ref,'yyyymm')) <>
              to_number(to_char(p_dt_ini_212,'yyyymm')) then
           par_cod_erro := 1;
           par_msg_erro := 'Transa��o de mudan�a de tipo de recebimento n�o permitida, '||
                           'm�s e ano da data in�cio da ocorr�ncia 212, est� diferente '||
                           'do m�s aberto.';
        else
           trata_troca_recebimento;
        end if;
     elsif p_tp_oper = 'D' then
        if p_dt_fim_ocor is null then
           par_cod_erro := 1;
           par_msg_erro := 'Transa��o de encerramento n�o permitida, n�o '||
                           'existe a data do t�rmino da ocorr�ncia.';
        else
           if to_number(to_char(p_dt_fim_ocor, 'yyyymm')) <
              to_number(to_char(v_data_ref, 'yyyymm')) then
              /* AGREGADO 20/02/2003 */
              /* Alterado 06/06/2003 */       
                -- Apaga da folha aberta a fun�ao do empregado, pois j� n�o tem.  
                trata_desligamento_mes_ant;
              /* FIM AGREGADO 20/02/2003 */
              /* Alterado 06/06/2003 */                 
           elsif to_number(to_char(p_dt_fim_ocor, 'yyyymm')) >
                 to_number(to_char(v_data_ref, 'yyyymm')) then
              par_cod_erro := 2;
              par_msg_erro := 'Transa��o n�o gera qualquer altera��o na tabela de '||
                              'movimenta��o. Data t�rmino da ocorr�ncia � '||
                              'superior ao m�s de pagamento aberto.';
           else -- � igual
              -- Atualiza a inform��o da fun��o na folha aberta 
              trata_desligamento;
           end if;
        end if;
     elsif p_tp_oper = 'I' then
        if p_dt_fim_ocor is not null then
           if to_number(to_char(p_dt_fim_ocor, 'yyyymm')) <
              to_number(to_char(v_data_ref, 'yyyymm')) then
              par_cod_erro := 2;
              par_msg_erro := 'Transa��o n�o gera qualquer altera��o na tabela de '||
                              'movimenta��o. Datas in�cio e t�rmino da ocorr�ncia '||
                              's�o inferiores ao m�s de pagamento aberto.';
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
           par_msg_erro := 'Transa��o de modifica��o n�o permitida, j� existe um evento de '||
                           'pagamento para esta ocorr�ncia.';
        else
          update_movimentacao_funcao;
        end if;
     /* FIM AGREGADO 07/03/2003*/
     end if;
  End;
/




