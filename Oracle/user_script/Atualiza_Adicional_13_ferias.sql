create or replace
PROCEDURE Atualiza_Adicional_13_ferias(p_ano_ini number, p_mes_ini number, p_ano_fim number, p_mes_fim number, p_versao number) IS
   cursor incidencias is
      select distinct(iru_rub_codigo_incide) iru_rub_codigo_incide
      from incidencias_rubricas
      where iru_rub_codigo in(1345,1350)
   --   and   iru_rub_codigo_incide in(1225,1226,1227)
      order by iru_rub_codigo_incide;


   r1   incidencias%rowtype;


   cursor mov is
      select distinct(mov_emp_numero_matricula) mov_emp_numero_matricula,
             mov_mes_referencia,
             mov_ano_referencia
      from movimentacao
      where mov_ano_referencia >= p_ano_ini
      and   mov_ano_referencia <= p_ano_fim
      and   mov_mes_referencia   >= p_mes_ini
      and   mov_mes_referencia   <= p_mes_fim
      and   mov_mes_referencia <> 13
      and   mov_versao_pagamento = p_versao
      and   mov_rub_codigo       = r1.iru_rub_codigo_incide
    --  and   mov_emp_numero_matricula = 3626025
      /*in(228841,522844,620551,624441,3280921,9007318,9865163,
      9865359,9866650,767901,18365,2877,4170532,198524,3947882,770526,811150,772030,3627120,9608972)*/
      order by mov_ano_referencia desc,
               mov_mes_referencia;
-- 9639859

   cursor rub(p_cod_rub number) is
      select rub_indic_fixo_variavel,
             rub_indic_rub_adicional
      from rubricas
      where rub_codigo = p_cod_rub;

   r2   rub%rowtype;


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
     and    mov.mov_emp_numero_matricula = p_matricula
     and  (mov.mov_ind_lancamento_liq_negat = 'N' or
           mov.mov_ind_lancamento_liq_negat is null)
     and   mov.mov_rub_codigo           = rub_codigo
     and   mov.mov_rub_codigo in(select iru_rub_codigo_incide
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
   set transaction use rollback segment rb_grande1;
   --
   -- Cursor de todas as rubricas incidentes da rubrica 1345
   --
   for c1 in incidencias loop
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
      for c2 in mov loop
         --dbms_output.put_line('1 c2.mov_emp_numero_matricula = '||to_char(c2.mov_emp_numero_matricula));
         --dbms_output.put_line('r1.iru_rub_codigo_incide = '||to_char(r1.iru_rub_codigo_incide));
         --
         -- Verifica se a rubrica é de Freqüência
         --
         v_valor := 0;
         if r2.rub_indic_rub_adicional = 4 then
            v_cod_for_rubrica := 0;
            v_valor_extorno   := 0;
            --
            -- efetuando a soma de todos valores de extorno referente a rubrica do cursor c1
            -- que esta sendo tratada no momento
            --
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
               and   mov.mov_rub_codigo               = rub_codigo
               and   mov.mov_rub_codigo               = r1.iru_rub_codigo_incide;
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
               and   mov.mov_rub_codigo               = rub_codigo
               and   mov.mov_rub_codigo               = r1.iru_rub_codigo_incide;
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
            --dbms_output.put_line('v_cod_for_rubrica = '||to_char(v_cod_for_rubrica));
            --
            -- Efetuando a soma de valores das rubricas incidentes da rubrica do cursor c1
            --
            /*
            dbms_output.put_line('somarub c2.mov_ano_referencia = '||to_char(c2.mov_ano_referencia));
            dbms_output.put_line('somarub c2.mov_mes_referencia = '||to_char(c2.mov_mes_referencia));
            dbms_output.put_line('somarub r1.iru_rub_codigo_incide = '||to_char(r1.iru_rub_codigo_incide));
            */
            open somarrubinc(c2.mov_ano_referencia,
                             c2.mov_mes_referencia,
                             r1.iru_rub_codigo_incide,
                             c2.mov_emp_numero_matricula);
            fetch somarrubinc into v_somarrubinc;
            close somarrubinc;
          --  dbms_output.put_line('principal v_somarrubinc = '||to_char(v_somarrubinc));
            --
            -- Buscando Salário Base para rubricas com código de fórmula igual a 26; 81 e 82
            --
            begin
               select mov_valor_integral
               into v_salbas
               from movimentacao
               where mov_ano_referencia       = c2.mov_ano_referencia
               and   mov_mes_referencia       = c2.mov_mes_referencia
               and   mov_versao_pagamento     = 1
               and   mov_emp_numero_matricula = c2.mov_emp_numero_matricula
               and   mov_rub_codigo           = 1000
               and   mov_tip_rubrica          = 'N';

               exception
                  when no_data_found then
                     v_salbas := 0;
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
       /*        dbms_output.put_line('c2.mov_emp_numero_matricula = '||to_char(c2.mov_emp_numero_matricula));
               dbms_output.put_line('ano = '||to_char(c2.mov_ano_referencia)||' - Mês = '||to_char(c2.mov_mes_referencia));
               dbms_output.put_line('10 v_cod_for_rubrica = '||v_cod_for_rubrica);
               dbms_output.put_line('v_valor = '||to_char(v_valor));
               dbms_output.put_line('v_somarrubinc = '||to_char(v_somarrubinc));*/
               begin
                  v_total_horas :=  (v_valor * 180) / nvl((2 * v_somarrubinc),0);
             --  dbms_output.put_line('11 v_total_horas = '||to_char(v_total_horas));
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
               /*
               dbms_output.put_line('c2.mov_emp_numero_matricula = '||to_char(c2.mov_emp_numero_matricula));
               dbms_output.put_line('ano = '||to_char(c2.mov_ano_referencia)||' - Mês = '||to_char(c2.mov_mes_referencia));
               dbms_output.put_line('10 v_cod_for_rubrica = '||v_cod_for_rubrica);
               dbms_output.put_line('v_valor = '||to_char(v_valor));
               dbms_output.put_line('v_somarrubinc = '||to_char(v_somarrubinc));
               */
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
            end;
            --dbms_output.put_line('2 c2.mov_emp_numero_matricula = '||to_char(c2.mov_emp_numero_matricula));
            --dbms_output.put_line('v_valor = '||to_char(v_valor));
            --
         end if;
         --dbms_output.put_line('v_total_horas = '||to_char(v_total_horas));
         --
         -- inserindo dados na tabela ADICIONAL_13_FERIAS
         --
        /*
dbms_output.put_line('c2.mov_mes_referencia = '||to_char(c2.mov_mes_referencia));
dbms_output.put_line('v_total_horas = '||to_char(v_total_horas));
dbms_output.put_line('v_valor = '||to_char(v_valor));
dbms_output.put_line('r1.iru_rub_codigo_incide='||to_char(r1.iru_rub_codigo_incide));
*/
         begin
            insert into adicional_13_ferias
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
                   null,
                   1);                       -- a13f_indica_incidencia

            exception
               when dup_val_on_index then
                  begin
                     update adicional_13_ferias
                     set a13f_qtd_horas            = v_total_horas,
                         a13f_valor                = v_valor,
                         cod_usuario               = v_usuario,
                         dta_inclusao              = sysdate
                     where a13f_ano                  = c2.mov_ano_referencia
                     and   a13f_mes                  = c2.mov_mes_referencia
                     and   a13f_cod_rubrica          = r1.iru_rub_codigo_incide
                     and   a13f_emp_numero_matricula = c2.mov_emp_numero_matricula;
                  end;
               --
               when others then
                   dbms_output.put_line('Erro no insert p/ c2.mov_emp_numero_matricula = '||to_char(c2.mov_emp_numero_matricula));
         end;
         COMMIT;
         set transaction use rollback segment rb_grande1;
      end loop;
   end loop;
   COMMIT;
end;
/
GRANT EXECUTE ON Atualiza_Adicional_13_ferias TO RH_PERFIL_99
/
