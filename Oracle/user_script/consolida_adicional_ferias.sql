create or replace procedure Consolida_Adicional_Ferias (par_ano number, par_mes number, par_versao number,
                                      par_ano_ini number, par_mes_ini number, par_ano_fim number,
                                      par_mes_fim number, par_data_parametro date, par_dias_ferias number,
                                      par_matricula number := null) is
   v_a13f_indica_incidencia number(4);
   v_possui_rubrica         varchar2(1);
   v_valor_1355             movimentacao.mov_valor%TYPE;
   v_tipo_remuneracao       varchar2(2);
   v_meses_rg               number;
   v_dias_proporc           number := 0;
   --
   CURSOR c_a13f_principal(p_rub_codigo number) IS
      select a13f.a13f_emp_numero_matricula,
             NVL( SUM( NVL( (a13f.a13f_valor * ((100 + NVL(a13f.a13f_perc_correcao_ferias, 0))/100)), 0)), 0) total_valor,
             NVL( SUM( NVL( a13f.a13f_qtd_horas, 0)), 0) total_horas
      from   adicional_13_ferias a13f
      where  a13f.a13f_cod_rubrica    = p_rub_codigo
      and    TO_NUMBER(LPAD(TO_CHAR(a13f.a13f_ano), 4, '0') || LPAD(TO_CHAR(a13f.a13f_mes), 2, '0')) >=
             TO_NUMBER(LPAD(TO_CHAR(par_ano_ini), 4, '0') || LPAD(TO_CHAR(par_mes_ini), 2, '0'))
      and    TO_NUMBER(LPAD(TO_CHAR(a13f.a13f_ano), 4, '0') || LPAD(TO_CHAR(a13f.a13f_mes), 2, '0')) <
             TO_NUMBER(LPAD(TO_CHAR(par_ano_fim), 4, '0') || LPAD(TO_CHAR(par_mes_fim), 2, '0'))
      and    a13f.a13f_emp_numero_matricula = par_matricula
      and    a13f.a13f_mes <> 13
      and    a13f.a13f_sequencial = 1
      group  by a13f.a13f_emp_numero_matricula;
   --
   CURSOR c_meses_rg IS
      select COUNT(1) num_meses,
             nvl(sum(mov_dias_proporcionalidade)/decode((count(1)-1),0,1,(count(1)-1)),0) resultado
      from   adicional_13_ferias,
             movimentacao
      where  a13f_cod_rubrica = 1010
      and    a13f_ano                  = mov_ano_referencia
      and    a13f_mes                  = mov_mes_referencia
      and    mov_versao_pagamento      = 1
      and    a13f_emp_numero_matricula = mov_emp_numero_matricula
      and    a13f_cod_rubrica          = mov_rub_codigo
      and    TO_NUMBER(LPAD(TO_CHAR(a13f_ano), 4, '0') || LPAD(TO_CHAR(a13f_mes), 2, '0')) >=
             TO_NUMBER(LPAD(TO_CHAR(par_ano_ini), 4, '0') || LPAD(TO_CHAR(par_mes_ini), 2, '0'))
      and    TO_NUMBER(LPAD(TO_CHAR(a13f_ano), 4, '0') || LPAD(TO_CHAR(a13f_mes), 2, '0')) <
             TO_NUMBER(LPAD(TO_CHAR(par_ano_fim), 4, '0') || LPAD(TO_CHAR(par_mes_fim), 2, '0'))
      and    a13f_emp_numero_matricula = par_matricula
      and    a13f_mes <> 13
      and    a13f_sequencial = 1;
   --
   CURSOR c_somarubinc(p_rub_codigo number, p_ano number, p_mes number) IS
      select iru.iru_rub_codigo_incide, rub.rub_indic_fixo_variavel, rub.rub_indic_rub_adicional
      from   incidencias_rubricas iru, rubricas rub
      where  iru.iru_rub_codigo = p_rub_codigo
      and    iru.iru_rub_codigo_incide = rub.rub_codigo
      and   (iru.data_termino is null or to_number(to_char(iru.data_termino,'yyyymmdd')) >=
             to_number(lpad(to_char(p_ano),4,'0')||lpad(to_char(p_mes),2,'0')||lpad(to_char(01),2,'0')));
   --
   CURSOR c_verif_data_param(p_data date, p_emp_numero_matricula number, p_rub_codigo number) IS
      select 'S'
      from   movimentacao mov
      where  mov.mov_ano_referencia   = TO_NUMBER(TO_CHAR(p_data, 'YYYY'))
      and    mov.mov_mes_referencia   = TO_NUMBER(TO_CHAR(p_data, 'MM'))
      and    mov.mov_versao_pagamento = 1
      and    mov.mov_rub_codigo = p_rub_codigo
      and    mov.mov_emp_numero_matricula = p_emp_numero_matricula
      and    exists (select 'X'
                     from   ocorrencias_empregados oem
                     where  oem.oem_ofu_codigo = mov.mov_oem_ofu_codigo
                     and    oem.oem_data_inicio = mov.mov_oem_data_inicio
                     and    oem.oem_emp_numero_matricula = mov.mov_emp_numero_matricula
                     and  ((oem.oem_data_termino is not null and oem.oem_data_termino >= p_data)
                            or (oem.oem_data_termino is null)) and oem.oem_data_inicio <= p_data);
   --
   CURSOR c_verif_data_param_funcao(p_data date, p_emp_numero_matricula number, p_rub_codigo number) IS
      select 'S'
      from   movimentacao mov
      where  mov.mov_ano_referencia   = TO_NUMBER(TO_CHAR(p_data, 'YYYY'))
      and    mov.mov_mes_referencia   = TO_NUMBER(TO_CHAR(p_data, 'MM'))
      and    mov.mov_versao_pagamento = 1
      and    mov.mov_rub_codigo in (1010, 1015)
      and    mov.mov_emp_numero_matricula = p_emp_numero_matricula
      and    exists (select 'X'
                     from   ocorrencias_empregados oem
                     where  oem.oem_ofu_codigo = mov.mov_oem_ofu_codigo
                     and    oem.oem_data_inicio = mov.mov_oem_data_inicio
                     and    oem.oem_emp_numero_matricula = mov.mov_emp_numero_matricula
                     and  ((oem.oem_data_termino is not null and oem.oem_data_termino >= p_data)
                            or (oem.oem_data_termino is null)) and oem.oem_data_inicio <= p_data);
   --
   CURSOR c_verif_data_param_peri_ins(p_data date, p_emp_numero_matricula number, p_rub_codigo number) IS
      select 'S'
      from   movimentacao mov
      where  mov.mov_ano_referencia   = TO_NUMBER(TO_CHAR(p_data, 'YYYY'))
      and    mov.mov_mes_referencia   = TO_NUMBER(TO_CHAR(p_data, 'MM'))
      and    mov.mov_versao_pagamento = 1
      and    mov.mov_rub_codigo in (1085, 1090)
      and    mov.mov_emp_numero_matricula = p_emp_numero_matricula
      and    exists (select 'X'
                     from   ocorrencias_empregados oem
                     where  oem.oem_ofu_codigo = mov.mov_oem_ofu_codigo
                     and    oem.oem_data_inicio = mov.mov_oem_data_inicio
                     and    oem.oem_emp_numero_matricula = mov.mov_emp_numero_matricula
                     and  ((oem.oem_data_termino is not null and oem.oem_data_termino >= p_data)
                            or (oem.oem_data_termino is null)) and oem.oem_data_inicio <= p_data);
   --
   cursor c_verif_dt_param_erro(p_data date, p_emp_numero_matricula number, p_tipo_remuneracao varchar2) IS
      select 'S'
      from (select max(oem.oem_data_inicio) max_data_inicio
            from  ocorrencias_empregados oem
            where oem.oem_ofu_codigo = 212
            and   oem.oem_tipo_remuneracao_funcao = p_tipo_remuneracao
            and   oem.oem_emp_numero_matricula = p_emp_numero_matricula
            and   ((oem.oem_data_termino is not null
                    and oem.oem_data_termino >= p_data)
                  or(oem.oem_data_termino is null))
            and   oem.oem_data_inicio <= p_data) v_oem
      where v_oem.max_data_inicio is not null;
   --
   CURSOR c_valor(p_emp_numero_matricula number, p_mov_ano_referencia number, p_mov_mes_referencia number, p_mov_versao_pagamento number, p_rub_codigo number) IS
      select nvl(sum(nvl(mov.mov_valor_integral,0)),0)
      from   movimentacao mov
      where  mov.mov_ano_referencia       = p_mov_ano_referencia
      and    mov.mov_mes_referencia       = p_mov_mes_referencia
      and    mov.mov_versao_pagamento     = p_mov_versao_pagamento
      and    mov.mov_emp_numero_matricula = p_emp_numero_matricula
      and   (mov.mov_ind_lancamento_liq_negat = 'N' or mov.mov_ind_lancamento_liq_negat is null)
      and    mov.mov_tip_rubrica = 'N'
      and    mov.mov_rub_codigo           = p_rub_codigo
      and    mov.mov_sequencial in (select max(mov1.mov_sequencial)
                                    from   movimentacao mov1
                                    where  mov1.mov_ano_referencia       = mov.mov_ano_referencia
                                    and    mov1.mov_mes_referencia       = mov.mov_mes_referencia
                                    and    mov1.mov_versao_pagamento     = 1
                                    and    mov1.mov_emp_numero_matricula = mov.mov_emp_numero_matricula
                                    and    mov1.mov_rub_codigo           = mov.mov_rub_codigo);
   var_valor_fgts       number;
   v_mov_valor          number;
   v_mov_valor_integral number;
   --
   Procedure Gera_Consolidado_1350 (par_ano number, par_mes number, par_versao number, par_rub_codigo number,
                                    par_data_parametro date, par_dias_ferias number);
   --
   Procedure Gera_Consolidado_1350 (par_ano number, par_mes number, par_versao number, par_rub_codigo number,
                                    par_data_parametro date, par_dias_ferias number) is
      v_valor      number;
      v_SOMARUBINC number;
      v_NumAvos13  number;
      CURSOR c_a13f IS
         SELECT a13f_emp_numero_matricula emp_numero_matricula, NVL(SUM(NVL(a13f_valor,0)),0) somarubinc
         FROM   adicional_13_ferias
         WHERE  a13f_ano = par_ano
         and    a13f_mes = par_mes
         and    a13f_sequencial = par_versao
         and    a13f_indica_incidencia = par_rub_codigo
         and   (a13f_emp_numero_matricula = par_matricula) -- par_matricula is null or 
         GROUP  BY a13f_emp_numero_matricula;
      --
      CURSOR c_Avos13(p_emp_numero_matricula number, p_ano number, p_mes number) IS
         select egt_numero_mes_13
         from   empregados_pagamentos
         where  egt_emp_numero_matricula = p_emp_numero_matricula
         and    egt_crp_ano_pagamento    = TO_NUMBER(TO_CHAR(par_data_parametro, 'YYYY'))
         and    egt_crp_mes_pagamento    = TO_NUMBER(TO_CHAR(par_data_parametro, 'MM'))
         and    egt_crp_sequencial       = 1;
      --
      CURSOR c_folha_atual IS
         select verifica_folha_atual
         from   dual;
      --
      v_data_folha_atual date;
      v_data_parametro   date;
      v_avos             number;
   Begin
      --------------------------------------------------------------------------
      -- Gera o valor consolidado da rubrica parâmetro no mês / ano / versão  --
      -- parâmetros. Utiliza a fórmula abaixo para gerar o valor da rubrica   --
      -- parâmetro:                                                           --
      -- (SOMARUBINC/12/30)* DIASFERIAS                                       --
      --------------------------------------------------------------------------
      -- Retorna o SOMARUBINC da rubrica parâmetro
      FOR r_a13f IN c_a13f LOOP
         v_SOMARUBINC := r_a13f.somarubinc;
         OPEN  c_folha_atual;
         FETCH c_folha_atual INTO v_data_folha_atual;
         CLOSE c_folha_atual;
         v_avos := 12;
         v_valor := (v_SomaRubInc/v_avos/30) * par_dias_ferias;
         BEGIN
            -- Insere valor total da rubrica parâmetro para ser utilizado
            -- no cálculo geral do 13º salário
            INSERT INTO adicional_13_ferias
                   (a13f_ano, a13f_mes, a13f_cod_rubrica, a13f_emp_numero_matricula, a13f_perc_correcao_13,
                    a13f_perc_correcao_ferias, a13f_qtd_horas, a13f_valor, cod_usuario, dta_inclusao,
                    a13f_indica_incidencia, a13f_sequencial)
            VALUES (par_ano, par_mes, par_rub_codigo, r_a13f.emp_numero_matricula, 0, 0, null,
                    v_valor, USER, SYSDATE, null, par_versao);
         EXCEPTION
            when dup_val_on_index then
            BEGIN
               UPDATE adicional_13_ferias
               SET    a13f_valor = v_valor,
                      a13f_qtd_horas = null,
                      cod_usuario = USER,
                      dta_inclusao = SYSDATE
               WHERE  a13f_ano = par_ano
               AND    a13f_mes = par_mes
               AND    a13f_sequencial = par_versao
               AND    a13f_cod_rubrica = par_rub_codigo
               AND    a13f_emp_numero_matricula  = r_a13f.emp_numero_matricula;
            END;
         END;
         commit;
      END LOOP;
   End Gera_Consolidado_1350;
   --
Begin
   -------------------------------------------------------------------------------
   -- Calcula o valor da rubrica 1350 de acordo com a fórmula abaixo:           --
   -- (SOMARUBINC/12)* NUMAVOS13                                                --
   -------------------------------------------------------------------------------
   -- Apaga todos os dados existentes no mês/ano e versão 99 (utilizada para o consolidado)
   DELETE adicional_13_ferias
   WHERE  a13f_ano = par_ano_fim
   and    a13f_mes = par_mes_fim
   and    a13f_sequencial = 99
   and   (a13f_emp_numero_matricula = par_matricula); -- par_matricula is null or 
   commit;
   -- Buscar rubricas incidentes da 1350
   FOR r_somarubinc IN c_somarubinc(1350, par_ano, par_mes) LOOP
      -- Busca somatório dos valores na tabela ADICIONAL_13_FERIAS que está entre os mes/ano inicial e final
      FOR r_a13f_principal IN c_a13f_principal(r_somarubinc.iru_rub_codigo_incide) LOOP
         if r_somarubinc.rub_indic_rub_adicional = 4 then
            v_mov_valor := null;
            Calcula_Valor_Rubrica(TO_NUMBER(TO_CHAR(par_data_parametro, 'MM')),  -- par_mes_calculo
              		              TO_NUMBER(TO_CHAR(par_data_parametro, 'YYYY')),-- par_ano_calculo
                                  1,                                             -- par_versao
                                  r_a13f_principal.a13f_emp_numero_matricula,    -- par_matricula
                                  r_somarubinc.iru_rub_codigo_incide,            -- par_rub_codigo
                                  1,                                             -- par_mov_sequencial
                                  null,                                          -- par_mov_for_codigo
                                  1,                                             -- par_mov_parcela
                                  1,                                             -- par_mov_parcela_atual
                                  'H',                                           -- par_mov_tipo_parametro
                                  r_a13f_principal.total_horas,                  -- par_mov_parametro
                                  v_mov_valor,                                   -- par_mov_valor
                                  'N',                                           -- par_mov_tip_rubrica
                                  null,                                          -- par_mov_mes_ref_diferenca
                                  null,                                          -- par_mov_ano_ref_diferenca
                                  v_mov_valor_integral,                          -- par_mov_valor_integral
                                  30,                                            -- par_mov_dias_proporcionalidade
                                  null,                                          -- par_mov_fun_codigo
                                  null,                                          -- par_mov_tipo_funcao
                                  null,                                          -- par_mov_nsa_codigo_nivel
                                  null,                                          -- par_mov_nsa_codigo_padrao
                                  null,                                          -- par_mov_oem_emp_numero_matricu
                                  null,                                          -- par_mov_oem_ofu_codigo
                                  null,                                          -- par_mov_oem_data_inicio
                                  null,                                          -- par_mov_nsa_indicador_nivel_es
                  		          var_valor_fgts);                               -- par_valor_fgts
            -- Quando a rubrica for de frequencia o estorno será lançado em valor (sinal negativo) e será deduzido do valor calculado
            r_a13f_principal.total_valor := NVL(v_mov_valor,0) + NVL(r_a13f_principal.total_valor,0); -- (valor calculado - estorno) -- Obs.: o estorno já esta gravado com sinal de menos (-)         
         end if;
         v_a13f_indica_incidencia := null;
         v_possui_rubrica         := null;
            -- Alimenta flag indicadora de 1355 ou 1350 verificando se o empregado teve a rubrica na data parâmetro
         if r_somarubinc.rub_indic_fixo_variavel = 'F' then -- fixa
            if r_somarubinc.iru_rub_codigo_incide in (1010, 1015) then
               -- Verifica se o empregado teve as rubricas na data parâmetro
               OPEN  c_verif_data_param_funcao(par_data_parametro, 
                                               r_a13f_principal.a13f_emp_numero_matricula, 
                                               r_somarubinc.iru_rub_codigo_incide);
               FETCH c_verif_data_param_funcao INTO v_possui_rubrica;
               CLOSE c_verif_data_param_funcao;
            else
               -- Verifica se o empregado teve a rubrica na data parâmetro
               OPEN  c_verif_data_param(par_data_parametro, 
                                        r_a13f_principal.a13f_emp_numero_matricula, 
                                        r_somarubinc.iru_rub_codigo_incide);
               FETCH c_verif_data_param INTO v_possui_rubrica;
               CLOSE c_verif_data_param;
            end if;
            if v_possui_rubrica is null then
               if r_somarubinc.iru_rub_codigo_incide = 1010 then
                  v_tipo_remuneracao := 'RG';
               else
                  v_tipo_remuneracao := 'FG';
               end if;
               -- Verifica a ocorrência de função que empregado teve p/rubrica na data parâmetro
               if r_somarubinc.iru_rub_codigo_incide in (1010, 1015, 1060) then
                  OPEN  c_verif_dt_param_erro (par_data_parametro, 
                                               r_a13f_principal.a13f_emp_numero_matricula, 
                                               v_tipo_remuneracao);
                  FETCH c_verif_dt_param_erro INTO v_possui_rubrica;
                  CLOSE c_verif_dt_param_erro;
               else
                  begin
                    select 'S'
                    into v_possui_rubrica
                    from (select max(oem.oem_data_inicio) max_data_inicio
                          from  ocorrencias_empregados oem
                          where oem.oem_ofu_codigo in (85, 217, 220, 222)
                          and   oem.oem_tipo_remuneracao_funcao = v_tipo_remuneracao
                          and   oem.oem_emp_numero_matricula = r_a13f_principal.a13f_emp_numero_matricula
                          and   ((oem.oem_data_termino is not null
                          and oem.oem_data_termino >= par_data_parametro)
                            or(oem.oem_data_termino is null))
                          and   oem.oem_data_inicio <= par_data_parametro) v_oem
                    where v_oem.max_data_inicio is not null;
                  exception
                    when no_data_found then
                      v_possui_rubrica := 'N';
                  end;
               end if;
            end if;
            if v_possui_rubrica = 'S' then
               v_a13f_indica_incidencia := 1355;
            else
               v_a13f_indica_incidencia := 1350;
            end if;
         elsif r_somarubinc.rub_indic_fixo_variavel = 'C' then -- cheia
            v_a13f_indica_incidencia := 1355;
         elsif r_somarubinc.rub_indic_fixo_variavel = 'V' then -- variável
            v_a13f_indica_incidencia := 1350;
         end if;
         if v_a13f_indica_incidencia = 1355 then
            -- Busca o valor do mês da data parâmetro
            OPEN  c_valor(r_a13f_principal.a13f_emp_numero_matricula,     -- matrícula
                          TO_NUMBER(TO_CHAR(par_data_parametro, 'YYYY')), -- ano
                          TO_NUMBER(TO_CHAR(par_data_parametro, 'MM')),   -- mes
                          1, -- versao
                          r_somarubinc.iru_rub_codigo_incide);
            FETCH c_valor INTO v_valor_1355;
            CLOSE c_valor;
            if r_somarubinc.rub_indic_fixo_variavel = 'C' then
               if nvl(v_valor_1355,0) = 0 then
                  v_a13f_indica_incidencia := 1350;
               else 
                  r_a13f_principal.total_valor := v_valor_1355;
               end if;
            else 
               r_a13f_principal.total_valor := v_valor_1355;
            end if;
         end if; -- fim v_a13f_indica_incidencia = 1355
         if r_somarubinc.iru_rub_codigo_incide = 1010 then
           -- Busca número de meses que o empregado teve RG
            OPEN  c_meses_rg;
            FETCH c_meses_rg INTO v_meses_rg, v_dias_proporc;
            CLOSE c_meses_rg;
            
            if v_dias_proporc > 30 then
               v_dias_proporc := 30;
            end if;
            -- Retira da RG o valor do salário base do empregado
            r_a13f_principal.total_valor := r_a13f_principal.total_valor - ((NVL(retorna_salariobas(par_mes, par_ano, par_matricula),0) * v_meses_rg ) *( v_dias_proporc/30));
         end if; -- fim r_somarubinc.iru_rub_codigo_incide = 1010
            -- Insere valor total de cada rubrica para ser utilizado no cálculo geral do adicional proporcional de férias
         begin
           INSERT INTO adicional_13_ferias
                  (a13f_ano, a13f_mes, a13f_cod_rubrica, a13f_emp_numero_matricula, a13f_perc_correcao_13,
                   a13f_perc_correcao_ferias, a13f_qtd_horas, a13f_valor, cod_usuario, dta_inclusao,
                   a13f_indica_incidencia, a13f_sequencial)
           VALUES (par_ano_fim, par_mes_fim, r_somarubinc.iru_rub_codigo_incide, r_a13f_principal.a13f_emp_numero_matricula,
                   0, 0, r_a13f_principal.total_horas, r_a13f_principal.total_valor, USER,
                   SYSDATE, v_a13f_indica_incidencia, 99);
         exception
           when dup_val_on_index then
             begin
               update adicional_13_ferias
               set    a13f_perc_correcao_13     = 0,
                      a13f_perc_correcao_ferias = 0,
                      a13f_qtd_horas            = r_a13f_principal.total_horas,
                      a13f_valor                = r_a13f_principal.total_valor,
                      a13f_indica_incidencia    = v_a13f_indica_incidencia,
                      cod_usuario               = USER,
                      dta_inclusao              = sysdate
               where  a13f_ano                  = par_ano_fim
               and    a13f_mes                  = par_mes_fim
               and    a13f_cod_rubrica          = r_somarubinc.iru_rub_codigo_incide
               and    a13f_emp_numero_matricula = r_a13f_principal.a13f_emp_numero_matricula
               and    a13f_sequencial           = 99;
             end;
         end;
         commit;
      END LOOP;
   END LOOP;
   -- Tratamento de exceções
   begin
      -- Exclui todos os registros da rubrica 1000 do mês 13 qdo existe a rubrica 1010
      -- com o atributo a13f_indica_incidencia igual a 1355
      delete adicional_13_ferias
      where a13f_ano         = par_ano_fim
      and   a13f_mes         = par_mes_fim
      and   a13f_cod_rubrica = 1000
      and   a13f_sequencial  = 99
      and  (a13f_emp_numero_matricula = par_matricula) -- par_matricula is null or 
      and   a13f_emp_numero_matricula in (select a13.a13f_emp_numero_matricula
                                          from adicional_13_ferias a13
                                          where a13.a13f_ano                  = par_ano_fim
                                          and   a13.a13f_mes                  = par_mes_fim
                                          and   a13.a13f_emp_numero_matricula = a13f_emp_numero_matricula
                                          and   a13.a13f_cod_rubrica          = 1010
                                          and   a13.a13f_valor                <> 0
                                          and   a13.a13f_indica_incidencia    = 1355
                                          and   a13.a13f_sequencial           = 99);
      -- Diretor não tem direito a 13º salário sobre adicional por tempo de serviço e sobre salário base
      delete adicional_13_ferias
      where  a13f_ano         = par_ano_fim
      and    a13f_mes         = par_mes_fim
      and    a13f_cod_rubrica IN (1000, 1005)
      and    a13f_sequencial  = 99
      and   (a13f_emp_numero_matricula = par_matricula) -- par_matricula is null or 
      and    a13f_emp_numero_matricula in (select emp.emp_numero_matricula
                                           from   cadastros emp
                                           where  emp.emp_tipo_remuneracao_funcao = 'DI'
                                           and    emp.emp_numero_matricula = a13f_emp_numero_matricula);
      delete adicional_13_ferias a13f
      where  a13f.a13f_ano         = par_ano_fim
      and    a13f.a13f_mes         = par_mes_fim
      and    a13f.a13f_sequencial  = 99
      and    a13f.a13f_cod_rubrica in (1060, 1015, 1010)
      and    a13f.a13f_indica_incidencia = 1350
      and   (a13f_emp_numero_matricula = par_matricula) -- par_matricula is null or 
      and    exists (select 'X'
                     from   adicional_13_ferias a13f1
                     where  a13f1.a13f_ano         = par_ano_fim
                     and    a13f1.a13f_mes         = par_mes_fim
                     and    a13f1.a13f_sequencial  = 99
                     and    a13f1.a13f_emp_numero_matricula = a13f.a13f_emp_numero_matricula
                     and    a13f1.a13f_indica_incidencia = 1355
                     and    a13f1.a13f_cod_rubrica in (1060, 1015, 1010));
   end;
   -- Gera valor da rubrica 1350
   Gera_Consolidado_1350(par_ano_fim, par_mes_fim, 99, 1350, par_data_parametro, par_dias_ferias);
End;
