create or replace procedure atualiza_adicional_ferias  (p_ano_ini number,
                                      p_mes_ini number,
                                      p_ano_fim number,
                                      p_mes_fim number,
                                      p_versao  number,
                                      p_mat     number) IS
   --
   --------------------------------------------------------------------------------------------
   --                              ATUALIZA_ADICIONAL_FERIAS                                 --
   --                              -------- --------- ------                                 --
   --      Pega todas as rubricas incidentes da 1350 de cada empregado que a(s)              --
   -- tiver(em) e verifica se a mesma é de frequencia. Se for acumula em variáveis separadas --
   -- os valores extornados e os valores diferentes de extorno e depois busca o código da    --
   -- fórmula da rubrica para fazer a fórmula inversa e chegar a quantidade de horas refe -  --
   -- rente a frequencia paga. Se a rubrica não for de frequencia armazena o valor dela.     --
   -- Com esses valores em mãos armazena os dados de cada rubrica na tabela                  --
   -- ADICIONAL_13_FERIAS de acordo com o mês inicial e final passados como parâmetros.      --
   --                                                                                        --
   --------------------------------------------------------------------------------------------
   --
   cursor incidencias is
      select distinct (iru_rub_codigo_incide) iru_rub_codigo_incide
      from   incidencias_rubricas
      where  iru_rub_codigo in (1350)
      order  by iru_rub_codigo_incide;
   --
   r1   incidencias%rowtype;
   --
   cursor mov (p_ano_inicio         number,
               p_mes_inicio         number,
               p_ano_termino        number,
               p_mes_termino        number,
               p_rubrica_incide     number,
               p_matricula          number,
               p_ver                number)  is
      select distinct(mov_emp_numero_matricula) mov_emp_numero_matricula,
             mov_mes_referencia,
             mov_ano_referencia
      from   movimentacao
      where  TO_NUMBER(LPAD(TO_CHAR(mov_ano_referencia), 4, '0') || LPAD(TO_CHAR(mov_mes_referencia), 2, '0')) >=
             TO_NUMBER(LPAD(TO_CHAR(p_ano_inicio), 4, '0') || LPAD(TO_CHAR(p_mes_inicio), 2, '0'))
      and    TO_NUMBER(LPAD(TO_CHAR(mov_ano_referencia), 4, '0') || LPAD(TO_CHAR(mov_mes_referencia), 2, '0')) <
             TO_NUMBER(LPAD(TO_CHAR(p_ano_termino), 4, '0') || LPAD(TO_CHAR(p_mes_termino), 2, '0'))
      and    mov_mes_referencia <> 13
      and    mov_versao_pagamento = p_ver
      and    mov_rub_codigo       = p_rubrica_incide
      and    mov_emp_numero_matricula = p_mat
      order  by mov_ano_referencia desc,
                mov_mes_referencia;
   --
   cursor rub(p_cod_rub number) is
      select rub_indic_fixo_variavel, -- 'F' - Fixa; 'C' - Cheia; 'V' - Variável.
             rub_indic_rub_adicional -- Código do grupo da rubrica
      from   rubricas
      where  rub_codigo = p_cod_rub;
   --
   r2   rub%rowtype;
   --
   cursor somarrubinc(p_ano         number,
                      p_mes         number,
                      p_rubrica     number,
                      p_matricula   number) is
      select nvl(sum(to_number(decode(rub_tipo_rubrica||mov.mov_tip_rubrica,
                       'RN','+','RD','+','RE','-','DN','-','DD','-','DE','+')||
                       to_char(nvl(mov.mov_valor,0)))),0)
      from  movimentacao mov, rubricas
      where mov.mov_ano_referencia        = p_ano
      and   mov.mov_mes_referencia        = p_mes
      and   mov.mov_versao_pagamento      = 1
      and   mov.mov_emp_numero_matricula = p_matricula
      and  (mov.mov_ind_lancamento_liq_negat = 'N' or
            mov.mov_ind_lancamento_liq_negat is null)
      and   mov.mov_rub_codigo           = rub_codigo
      and   NVL(mov.cod_usuario, 'A') <> 'REAJUSTE'
      and   mov.mov_rub_codigo in (select iru_rub_codigo_incide
                                   from   incidencias_rubricas
                                   where  iru_rub_codigo = p_rubrica
                                   and  ((mov.mov_tip_rubrica = 'N' and iru_tip_normal      = 'S') or
                                         (mov.mov_tip_rubrica = 'D' and iru_tip_diferenca   = 'S') or
                                         (mov.mov_tip_rubrica = 'E' and iru_tip_estorno_dev = 'S'))
                                   and   (data_termino is null
                                          or
                                          data_termino >= to_date('01'||'/'||to_char(p_mes)||'/'||to_char(p_ano),'DD/MM/YYYY')));
   --
   v_usuario            varchar2(30);
   v_valor              number(18,2);
   v_valor_extorno      number(18,2);
   v_cod_for_rubrica    number(3);
   v_total_horas        number(18,3);
   v_somarrubinc        number(11,2);
   v_salbas             number(18,2);
   --
begin
   --
   -- Buscando a conta do usuário conectado
   --
   begin
      select user
      into v_usuario
      from dual;
   end;
   --
   -- Cursor de todas as rubricas incidentes da rubrica 1350
   --
   for c1 in incidencias loop
      --
      -- Zera as variáveis
      v_total_horas := 0;
      v_valor       := 0;
      --
      r1.iru_rub_codigo_incide := c1.iru_rub_codigo_incide;
      --
      -- buscando os indicadores da rubrica no cursor RUB
      --
      open rub(r1.iru_rub_codigo_incide);
      fetch rub into r2;
      close rub;
      --
      -- Cursor de todos empregados que possuem a rubrica do cursor C1
      --
      for c2 in mov(p_ano_ini, p_mes_ini, p_ano_fim, p_mes_fim, r1.iru_rub_codigo_incide, p_mat, p_versao) loop
         -- Verifica se a rubrica é de Freqüência
         v_valor := 0;
         if r2.rub_indic_rub_adicional = 4 then
            v_cod_for_rubrica := 0;
            v_valor_extorno   := 0;
            --
            -- efetuando a soma de todos valores de extorno referente a rubrica do cursor c1
            -- que esta sendo tratada no momento
            begin
               select nvl(sum(mov.mov_valor),0) * -1
               into v_valor_extorno
               from  movimentacao mov, rubricas
               where mov.mov_ano_referencia           = c2.mov_ano_referencia
               and   mov.mov_mes_referencia           = c2.mov_mes_referencia
               and   mov.mov_versao_pagamento         = 1
               and   mov.mov_emp_numero_matricula     = c2.mov_emp_numero_matricula
               and   mov.mov_rub_codigo               = rub_codigo
               and   mov.mov_tip_rubrica              = 'E'
               and  (mov.mov_ind_lancamento_liq_negat = 'N' or
                     mov.mov_ind_lancamento_liq_negat is null)
               and   NVL(mov.cod_usuario, 'A') <> 'REAJUSTE'
               and   mov.mov_rub_codigo               = rub_codigo
               and   mov.mov_rub_codigo               = r1.iru_rub_codigo_incide;
            exception
            	 when others then
            	    dbms_output.put_line('Erro ao efetuar a soma de todos os valores estornados - '||to_char(sqlcode)||' - '||sqlerrm);
            end;
            --
            -- efetuando a soma de todos valores diferentes de extorno referente a rubrica
            -- do cursor c1 que esta sendo tratada no momento
            --
            begin
               select nvl(sum(mov.mov_valor),0)
               into v_valor
               from  movimentacao mov, rubricas
               where mov.mov_ano_referencia           = c2.mov_ano_referencia
               and   mov.mov_mes_referencia           = c2.mov_mes_referencia
               and   mov.mov_versao_pagamento         = 1
               and   mov.mov_emp_numero_matricula     = c2.mov_emp_numero_matricula
               and   mov.mov_rub_codigo               = rub_codigo
               and   mov.mov_tip_rubrica              != 'E'
               and  (mov.mov_ind_lancamento_liq_negat = 'N' or
                     mov.mov_ind_lancamento_liq_negat is null)
               and   NVL(mov.cod_usuario, 'A')        <> 'REAJUSTE'
               and   mov.mov_rub_codigo               = rub_codigo
               and   mov.mov_rub_codigo               = r1.iru_rub_codigo_incide;
            exception
            	 when others then
            	    dbms_output.put_line('Erro ao efetuar a soma de todos os valores que não são estornos - '||to_char(sqlcode)||' - '||sqlerrm);
            end;
            --
            begin
               select fru_for_codigo
               into  v_cod_for_rubrica
               from formulas_rubricas
               where fru_rub_codigo = r1.iru_rub_codigo_incide;
            exception
               when no_data_found then
                 dbms_output.put_line('Rubrica sem formula para matrícula = '||to_char(c2.mov_emp_numero_matricula)||' - Rubrica = '||to_char(r1.iru_rub_codigo_incide)||' - Formula = '||to_char(v_cod_for_rubrica));
                 exit;
               when too_many_rows then
                 dbms_output.put_line('Rubrica com duas formulas para matrícula = '||to_char(c2.mov_emp_numero_matricula)||' - Rubrica = '||to_char(r1.iru_rub_codigo_incide)||' - Formula = '||to_char(v_cod_for_rubrica));
                 exit;
            end;
            --
            -- Efetuando a soma de valores das rubricas incidentes da rubrica do cursor c1
            --
            open somarrubinc(c2.mov_ano_referencia,
                             c2.mov_mes_referencia,
                             r1.iru_rub_codigo_incide,
                             c2.mov_emp_numero_matricula);
            fetch somarrubinc into v_somarrubinc;
            close somarrubinc;
            --
            -- Buscando Salário Base para rubricas com código de fórmula igual a 26; 81 e 82
            --
            begin
               select mov_valor_integral
               into   v_salbas
               from   movimentacao
               where  mov_ano_referencia       = c2.mov_ano_referencia
               and    mov_mes_referencia       = c2.mov_mes_referencia
               and    mov_versao_pagamento     = 1
               and    mov_emp_numero_matricula = c2.mov_emp_numero_matricula
               and    mov_rub_codigo           = 1000
               and    mov_tip_rubrica          = 'N'
               and    mov_parcela              = 999
               and    mov_parcela_atual        = 999;
            exception
               when no_data_found then
                 v_salbas := 0;
               when others then
                 dbms_output.put_line('Erro ao buscar salário base - '||to_char(sqlcode)||' - '||sqlerrm);
            end;
            --
            -- Efetuando a formula inversa para descobrir a quantidade de horas para rubricas de freqüência
            --
            if v_cod_for_rubrica = 12 then
               begin
                  v_total_horas := (v_valor * 120) / nvl((1.7 * v_somarrubinc),0);
               exception
                  when zero_divide then
                     dbms_output.put_line('Rubrica com somarrubinc negativo p/ matrícula = '||to_char(c2.mov_emp_numero_matricula)||' - Rubrica = '||to_char(r1.iru_rub_codigo_incide)||' - Formula = '||to_char(v_cod_for_rubrica)||' mês = '||to_char(c2.mov_mes_referencia)||' - ano = '||to_char(c2.mov_ano_referencia));
                     v_total_horas := 0;
               end;
            elsif v_cod_for_rubrica = 13 then
               begin
                  v_total_horas := (v_valor * 120) / nvl((2 * v_somarrubinc),0);
               exception
                  when zero_divide then
                     dbms_output.put_line('Rubrica com somarrubinc negativo p/ matrícula = '||to_char(c2.mov_emp_numero_matricula)||' - Rubrica = '||to_char(r1.iru_rub_codigo_incide)||' - Formula = '||to_char(v_cod_for_rubrica)||' mês = '||to_char(c2.mov_mes_referencia)||' - ano = '||to_char(c2.mov_ano_referencia));
                     v_total_horas := 0;
               end;
            elsif v_cod_for_rubrica = 14 then
               begin
                  v_total_horas := (v_valor * 180) / nvl((1.7 * v_somarrubinc),0);
               exception
                  when zero_divide then
                     dbms_output.put_line('Rubrica com somarrubinc negativo p/ matrícula = '||to_char(c2.mov_emp_numero_matricula)||' - Rubrica = '||to_char(r1.iru_rub_codigo_incide)||' - Formula = '||to_char(v_cod_for_rubrica)||' mês = '||to_char(c2.mov_mes_referencia)||' - ano = '||to_char(c2.mov_ano_referencia));
                     v_total_horas := 0;
               end;
            elsif v_cod_for_rubrica = 15 then
               begin
                  v_total_horas :=  (v_valor * 180) / nvl((2 * v_somarrubinc),0);
               exception
                  when zero_divide then
                     dbms_output.put_line('Rubrica com somarrubinc negativo p/ matrícula = '||to_char(c2.mov_emp_numero_matricula)||' - Rubrica = '||to_char(r1.iru_rub_codigo_incide)||' - Formula = '||to_char(v_cod_for_rubrica)||' mês = '||to_char(c2.mov_mes_referencia)||' - ano = '||to_char(c2.mov_ano_referencia));
                     v_total_horas := 0;
               end;
            elsif v_cod_for_rubrica = 16 then
               begin
                  v_total_horas :=  (v_valor * 220) / nvl((1.7 * v_somarrubinc),0);
               exception
                  when zero_divide then
                     dbms_output.put_line('Rubrica com somarrubinc negativo p/ matrícula = '||to_char(c2.mov_emp_numero_matricula)||' - Rubrica = '||to_char(r1.iru_rub_codigo_incide)||' - Formula = '||to_char(v_cod_for_rubrica)||' mês = '||to_char(c2.mov_mes_referencia)||' - ano = '||to_char(c2.mov_ano_referencia));
                     v_total_horas := 0;
               end;
            elsif v_cod_for_rubrica = 17 then
               begin
                  v_total_horas :=  (v_valor * 120) / nvl((1.7 * 1.6 * v_somarrubinc),0);
               exception
                  when zero_divide then
                     dbms_output.put_line('Rubrica com somarrubinc negativo p/ matrícula = '||to_char(c2.mov_emp_numero_matricula)||' - Rubrica = '||to_char(r1.iru_rub_codigo_incide)||' - Formula = '||to_char(v_cod_for_rubrica)||' mês = '||to_char(c2.mov_mes_referencia)||' - ano = '||to_char(c2.mov_ano_referencia));
                     v_total_horas := 0;
               end;
            elsif v_cod_for_rubrica = 18 then
               begin
                  v_total_horas :=  (v_valor * 120) / nvl((2 * 1.6 * v_somarrubinc),0);
               exception
                  when zero_divide then
                     dbms_output.put_line('Rubrica com somarrubinc negativo p/ matrícula = '||to_char(c2.mov_emp_numero_matricula)||' - Rubrica = '||to_char(r1.iru_rub_codigo_incide)||' - Formula = '||to_char(v_cod_for_rubrica)||' mês = '||to_char(c2.mov_mes_referencia)||' - ano = '||to_char(c2.mov_ano_referencia));
                     v_total_horas := 0;
               end;
            elsif v_cod_for_rubrica = 19 then
               begin
                  v_total_horas :=  (v_valor * 180) / nvl((1.7 * 1.6 * v_somarrubinc),0);
               exception
                  when zero_divide then
                     dbms_output.put_line('Rubrica com somarrubinc negativo p/ matrícula = '||to_char(c2.mov_emp_numero_matricula)||' - Rubrica = '||to_char(r1.iru_rub_codigo_incide)||' - Formula = '||to_char(v_cod_for_rubrica)||' mês = '||to_char(c2.mov_mes_referencia)||' - ano = '||to_char(c2.mov_ano_referencia));
                     v_total_horas := 0;
               end;
            elsif v_cod_for_rubrica = 20 then
               begin
                  v_total_horas :=  (v_valor * 180) / nvl((2 * 1.6 * v_somarrubinc),0);
               exception
                  when zero_divide then
                     dbms_output.put_line('Rubrica com somarrubinc negativo p/ matrícula = '||to_char(c2.mov_emp_numero_matricula)||' - Rubrica = '||to_char(r1.iru_rub_codigo_incide)||' - Formula = '||to_char(v_cod_for_rubrica)||' mês = '||to_char(c2.mov_mes_referencia)||' - ano = '||to_char(c2.mov_ano_referencia));
                     v_total_horas := 0;
               end;
            elsif v_cod_for_rubrica = 21 then
               begin
                  v_total_horas :=  (v_valor * 220) / nvl((1.7 * 1.6 * v_somarrubinc),0);
               exception
                  when zero_divide then
                     dbms_output.put_line('Rubrica com somarrubinc negativo p/ matrícula = '||to_char(c2.mov_emp_numero_matricula)||' - Rubrica = '||to_char(r1.iru_rub_codigo_incide)||' - Formula = '||to_char(v_cod_for_rubrica)||' mês = '||to_char(c2.mov_mes_referencia)||' - ano = '||to_char(c2.mov_ano_referencia));
                     v_total_horas := 0;
               end;
            elsif v_cod_for_rubrica = 22 then
               begin
                  v_total_horas :=  (v_valor * 220) / nvl((2 * 1.6 * v_somarrubinc),0);
               exception
                  when zero_divide then
                     dbms_output.put_line('Rubrica com somarrubinc negativo p/ matrícula = '||to_char(c2.mov_emp_numero_matricula)||' - Rubrica = '||to_char(r1.iru_rub_codigo_incide)||' - Formula = '||to_char(v_cod_for_rubrica)||' mês = '||to_char(c2.mov_mes_referencia)||' - ano = '||to_char(c2.mov_ano_referencia));
                     v_total_horas := 0;
               end;
            elsif v_cod_for_rubrica = 23 then
               begin
                  v_total_horas :=  (v_valor * 120) / nvl((0.6 * v_somarrubinc),0);
               exception
                  when zero_divide then
                     dbms_output.put_line('Rubrica com somarrubinc negativo p/ matrícula = '||to_char(c2.mov_emp_numero_matricula)||' - Rubrica = '||to_char(r1.iru_rub_codigo_incide)||' - Formula = '||to_char(v_cod_for_rubrica)||' mês = '||to_char(c2.mov_mes_referencia)||' - ano = '||to_char(c2.mov_ano_referencia));
                     v_total_horas := 0;
               end;
            elsif v_cod_for_rubrica = 24 then
               begin
                  v_total_horas :=  (v_valor * 180) / nvl((0.6 * v_somarrubinc),0);
               exception
                  when zero_divide then
                     dbms_output.put_line('Rubrica com somarrubinc negativo p/ matrícula = '||to_char(c2.mov_emp_numero_matricula)||' - Rubrica = '||to_char(r1.iru_rub_codigo_incide)||' - Formula = '||to_char(v_cod_for_rubrica)||' mês = '||to_char(c2.mov_mes_referencia)||' - ano = '||to_char(c2.mov_ano_referencia));
                     v_total_horas := 0;
               end;
            elsif v_cod_for_rubrica = 25 then
               begin
                  v_total_horas :=  (v_valor * 220) / nvl((0.6 * v_somarrubinc),0);
               exception
                  when zero_divide then
                     dbms_output.put_line('Rubrica com somarrubinc negativo p/ matrícula = '||to_char(c2.mov_emp_numero_matricula)||' - Rubrica = '||to_char(r1.iru_rub_codigo_incide)||' - Formula = '||to_char(v_cod_for_rubrica)||' mês = '||to_char(c2.mov_mes_referencia)||' - ano = '||to_char(c2.mov_ano_referencia));
                     v_total_horas := 0;
               end;
            elsif v_cod_for_rubrica = 26 then
               begin
                  v_total_horas :=  (v_valor * 120) / nvl((0.3333 * v_salbas),0);
               exception
                  when zero_divide then
                     dbms_output.put_line('Rubrica com somarrubinc negativo p/ matrícula = '||to_char(c2.mov_emp_numero_matricula)||' - Rubrica = '||to_char(r1.iru_rub_codigo_incide)||' - Formula = '||to_char(v_cod_for_rubrica)||' mês = '||to_char(c2.mov_mes_referencia)||' - ano = '||to_char(c2.mov_ano_referencia));
                     v_total_horas := 0;
               end;
            elsif v_cod_for_rubrica = 44 then
               begin
                  v_total_horas :=  (v_valor * 220) / nvl((2 * v_somarrubinc),0);
               exception
                  when zero_divide then
                     dbms_output.put_line('Rubrica com somarrubinc negativo p/ matrícula = '||to_char(c2.mov_emp_numero_matricula)||' - Rubrica = '||to_char(r1.iru_rub_codigo_incide)||' - Formula = '||to_char(v_cod_for_rubrica)||' mês = '||to_char(c2.mov_mes_referencia)||' - ano = '||to_char(c2.mov_ano_referencia));
                     v_total_horas := 0;
               end;
            elsif v_cod_for_rubrica = 54 then
               begin
                  v_total_horas :=  (v_valor * 120) / nvl((1.6 * v_somarrubinc),0);
               exception
                  when zero_divide then
                     dbms_output.put_line('Rubrica com somarrubinc negativo p/ matrícula = '||to_char(c2.mov_emp_numero_matricula)||' - Rubrica = '||to_char(r1.iru_rub_codigo_incide)||' - Formula = '||to_char(v_cod_for_rubrica)||' mês = '||to_char(c2.mov_mes_referencia)||' - ano = '||to_char(c2.mov_ano_referencia));
                     v_total_horas := 0;
               end;
            elsif v_cod_for_rubrica = 55 then
               begin
                  v_total_horas :=  (v_valor * 180) / nvl((1.6 * v_somarrubinc),0);
               exception
                  when zero_divide then
                     dbms_output.put_line('Rubrica com somarrubinc negativo p/ matrícula = '||to_char(c2.mov_emp_numero_matricula)||' - Rubrica = '||to_char(r1.iru_rub_codigo_incide)||' - Formula = '||to_char(v_cod_for_rubrica)||' mês = '||to_char(c2.mov_mes_referencia)||' - ano = '||to_char(c2.mov_ano_referencia));
                     v_total_horas := 0;
               end;
            elsif v_cod_for_rubrica = 56 then
               begin
                  v_total_horas :=  (v_valor * 220) / nvl((1.6 * v_somarrubinc),0);
               exception
                  when zero_divide then
                     dbms_output.put_line('Rubrica com somarrubinc negativo p/ matrícula = '||to_char(c2.mov_emp_numero_matricula)||' - Rubrica = '||to_char(r1.iru_rub_codigo_incide)||' - Formula = '||to_char(v_cod_for_rubrica)||' mês = '||to_char(c2.mov_mes_referencia)||' - ano = '||to_char(c2.mov_ano_referencia));
                     v_total_horas := 0;
               end;
            elsif v_cod_for_rubrica = 57 then
               begin
                  v_total_horas :=  (v_valor * 120) / nvl((1.6 * 1.6 * v_somarrubinc),0);
               exception
                  when zero_divide then
                     dbms_output.put_line('Rubrica com somarrubinc negativo p/ matrícula = '||to_char(c2.mov_emp_numero_matricula)||' - Rubrica = '||to_char(r1.iru_rub_codigo_incide)||' - Formula = '||to_char(v_cod_for_rubrica)||' mês = '||to_char(c2.mov_mes_referencia)||' - ano = '||to_char(c2.mov_ano_referencia));
                     v_total_horas := 0;
               end;
            elsif v_cod_for_rubrica = 58 then
               begin
                  v_total_horas :=  (v_valor * 180) / nvl((1.6 * 1.6 * v_somarrubinc),0);
               exception
                  when zero_divide then
                     dbms_output.put_line('Rubrica com somarrubinc negativo p/ matrícula = '||to_char(c2.mov_emp_numero_matricula)||' - Rubrica = '||to_char(r1.iru_rub_codigo_incide)||' - Formula = '||to_char(v_cod_for_rubrica)||' mês = '||to_char(c2.mov_mes_referencia)||' - ano = '||to_char(c2.mov_ano_referencia));
                     v_total_horas := 0;
               end;
            elsif v_cod_for_rubrica = 59 then
               begin
                  v_total_horas :=  (v_valor * 220) / nvl((1.6 * 1.6 * v_somarrubinc),0);
               exception
                  when zero_divide then
                     dbms_output.put_line('Rubrica com somarrubinc negativo p/ matrícula = '||to_char(c2.mov_emp_numero_matricula)||' - Rubrica = '||to_char(r1.iru_rub_codigo_incide)||' - Formula = '||to_char(v_cod_for_rubrica)||' mês = '||to_char(c2.mov_mes_referencia)||' - ano = '||to_char(c2.mov_ano_referencia));
                     v_total_horas := 0;
               end;
            elsif v_cod_for_rubrica = 81 then
               begin
                  v_total_horas :=  (v_valor * 180) / nvl((0.3333 * v_salbas),0);
               exception
                  when zero_divide then
                     dbms_output.put_line('Rubrica com somarrubinc negativo p/ matrícula = '||to_char(c2.mov_emp_numero_matricula)||' - Rubrica = '||to_char(r1.iru_rub_codigo_incide)||' - Formula = '||to_char(v_cod_for_rubrica)||' mês = '||to_char(c2.mov_mes_referencia)||' - ano = '||to_char(c2.mov_ano_referencia));
                     v_total_horas := 0;
               end;
            elsif v_cod_for_rubrica = 82 then
               begin
                  v_total_horas :=  (v_valor * 220) / nvl((0.3333 * v_salbas),0);
               exception
                  when zero_divide then
                     dbms_output.put_line('Rubrica com somarrubinc negativo p/ matrícula = '||to_char(c2.mov_emp_numero_matricula)||' - Rubrica = '||to_char(r1.iru_rub_codigo_incide)||' - Formula = '||to_char(v_cod_for_rubrica)||' mês = '||to_char(c2.mov_mes_referencia)||' - ano = '||to_char(c2.mov_ano_referencia));
                     v_total_horas := 0;
               end;
            elsif v_cod_for_rubrica = 83 then
               begin
                  v_total_horas :=  (v_valor * 180) /  nvl(v_somarrubinc,0);
               exception
                  when zero_divide then
                     dbms_output.put_line('Rubrica com somarrubinc negativo p/ matrícula = '||to_char(c2.mov_emp_numero_matricula)||' - Rubrica = '||to_char(r1.iru_rub_codigo_incide)||' - Formula = '||to_char(v_cod_for_rubrica)||' mês = '||to_char(c2.mov_mes_referencia)||' - ano = '||to_char(c2.mov_ano_referencia));
                     v_total_horas := 0;
               end;
            elsif v_cod_for_rubrica = 84 then
               begin
                  v_total_horas :=  (v_valor * 220) /  nvl(v_somarrubinc,0);
               exception
                  when zero_divide then
                     dbms_output.put_line('Rubrica com somarrubinc negativo p/ matrícula = '||to_char(c2.mov_emp_numero_matricula)||' - Rubrica = '||to_char(r1.iru_rub_codigo_incide)||' - Formula = '||to_char(v_cod_for_rubrica)||' mês = '||to_char(c2.mov_mes_referencia)||' - ano = '||to_char(c2.mov_ano_referencia));
                     v_total_horas := 0;
               end;
            elsif v_cod_for_rubrica = 86 then
               begin
                  v_total_horas :=  (v_valor * 220) / (2 * v_somarrubinc);
               exception
                  when zero_divide then
                     dbms_output.put_line('Rubrica com somarrubinc negativo p/ matrícula = '||to_char(c2.mov_emp_numero_matricula)||' - Rubrica = '||to_char(r1.iru_rub_codigo_incide)||' - Formula = '||to_char(v_cod_for_rubrica)||' mês = '||to_char(c2.mov_mes_referencia)||' - ano = '||to_char(c2.mov_ano_referencia));
                     v_total_horas := 0;
               end;
            end if;
            v_valor := v_valor_extorno;
         else
            --
            -- efetuando a soma de todos valores referente a rubrica do cursor c1 que esta sendo tratada no momento
            --
            begin
               select nvl(sum(to_number(decode(rub_tipo_rubrica||mov.mov_tip_rubrica,
                                'RN','+','RD','+','RE','-','DN','-','DD','-','DE','+')||
                                to_char(nvl(mov.mov_valor,0)))),0)
               into v_valor
               from  movimentacao mov, rubricas
               where mov.mov_ano_referencia           = c2.mov_ano_referencia
               and   mov.mov_mes_referencia           = c2.mov_mes_referencia
               and   mov.mov_versao_pagamento         = 1
               and   mov.mov_emp_numero_matricula     = c2.mov_emp_numero_matricula
               and  (mov.mov_ind_lancamento_liq_negat = 'N' or
                     mov.mov_ind_lancamento_liq_negat is null)
               and   mov.mov_rub_codigo               = rub_codigo
               and   mov.mov_rub_codigo               = r1.iru_rub_codigo_incide;
            exception
            	 when others then
            	    dbms_output.put_line('Erro ao efetuar a soma de todas as incidência da rubrica '||to_char(r1.iru_rub_codigo_incide)||' - '||to_char(sqlcode)||' - '||sqlerrm);
            end;
            --
         end if;
         --
         -- inserindo dados na tabela ADICIONAL_13_FERIAS
         --
         begin
            insert into adicional_13_ferias
                  (a13f_ano,
                   a13f_mes,
                   a13f_cod_rubrica,
                   a13f_emp_numero_matricula,
                   a13f_perc_correcao_13,
                   a13f_perc_correcao_ferias,
                   a13f_qtd_horas,
                   a13f_valor,
                   cod_usuario,
                   dta_inclusao,
                   a13f_indica_incidencia,
                   a13f_sequencial)
            values(c2.mov_ano_referencia,       -- a13f_ano
                   c2.mov_mes_referencia,       -- a13f_mes
                   r1.iru_rub_codigo_incide,    -- a13f_cod_rubrica
                   c2.mov_emp_numero_matricula, -- a13f_emp_numero_matricula
                   0,                           -- a13f_perc_correcao_13
                   0,                           -- a13f_perc_correcao_ferias
                   v_total_horas,               -- a13f_qtd_horas
                   v_valor,                     -- a13f_valor
                   v_usuario,                   -- cod_usuario
                   sysdate,                     -- dta_inclusao
                   null,                        -- a13f_indica_incidencia
                   1);                          -- a13f_sequencial

            exception
               when dup_val_on_index then
                  begin
                     update adicional_13_ferias
                     set    a13f_qtd_horas            = v_total_horas,
                            a13f_valor                = v_valor,
                            cod_usuario               = v_usuario,
                            dta_inclusao              = sysdate
                     where  a13f_ano                  = c2.mov_ano_referencia
                     and    a13f_mes                  = c2.mov_mes_referencia
                     and    a13f_cod_rubrica          = r1.iru_rub_codigo_incide
                     and    a13f_emp_numero_matricula = c2.mov_emp_numero_matricula
                     and    a13f_sequencial           = 1;
                  end;
         end;
         --
         COMMIT;
         --
      end loop;
   end loop;
   --
   COMMIT;
   --
end;
