create or replace
procedure trata_diaria_viagem(p_mes          NUMBER,
                              p_ano          NUMBER,
                              p_versao       NUMBER,
                              p_dep_codigo   NUMBER,
                              p_matricula    NUMBER) is
-----------------------------------------------------------------------------------
-- Procedure que inclui e exclui rubricas de diária de viagem na movimentacao    --
-- financeira do empregado.                                                      --
--                                                                               --
-- Observacoes:
--   1 - Será processada no momento do cálculo, onde excluíra todas as rubricas  --
--       normais de diária de viagem, e efetuará o lançamento com base nas ocor- --
--       rências do grupo 8 (oito), com data término no mês anterior ao do folha --
--       que está sendo calculada.                                               --
--   2 - Campos passados com parâmetros p/ tratamento da ocorrência de Diária.   --
--       p_mes         - mês de referência que será efetuado o cálculo.          --
--       p_ano         - ano de referência que será efetuado o cálculo.          --
--       p_versao      - versao de pagamento que será efetuado o cálculo.        --
--       p_dep_codigo  - código da dependência que estará sendo calculada.       --
--       p_matricula   - Matrícula do empregado, somente quando for efetuado um  --
--                       cálculo individual.                                     --
--                                                                               --
-----------------------------------------------------------------------------------

   v_ano_ant           movimentacao.mov_ano_referencia%type;
   v_mes_ant           movimentacao.mov_mes_referencia%type;
   v_seq_pagto         movimentacao.mov_rub_seq_pagamento%type;
   v_valor_oem         number;
   v_valor_1905        number;
   p_rubrica           number(4);


   cursor c_via is
       select distinct(mov_emp_numero_matricula) mov_emp_numero_matricula,
              mov_emp_dep_codigo_pagto, emp_status
       from   movimentacao,
              cadastros
       where emp_numero_matricula = mov_emp_numero_matricula
       and   mov_ano_referencia   = p_ano
       and   mov_mes_referencia   = p_mes
       and   mov_versao_pagamento = p_versao
       and   (mov_emp_dep_codigo_pagto = p_dep_codigo or p_dep_codigo is null)
       and   (mov_emp_numero_matricula = p_matricula  or p_matricula  is null)
       order by 1;

   r_via               c_via%rowtype;

   cursor c_oem is
       select sum(oem_mov_parametro) oem_mov_parametro
       from   ocorrencias_empregados
       where  oem_emp_numero_matricula = r_via.mov_emp_numero_matricula
       and    oem_ofu_codigo  in
             (select ofu_codigo
              from   ocorrencias_funcionais
              where  ofu_indicador_tipo = 8)
       and    to_number(to_char(oem_data_termino,'yyyy')) = v_ano_ant
       and    to_number(to_char(oem_data_termino,'mm'))   = v_mes_ant
       and    oem_indicador_onus = 'S';

   cursor c_mov is
       select mov_valor
       from   movimentacao
       where  mov_ano_referencia       = v_ano_ant
       and    mov_mes_referencia       = v_mes_ant
       and    mov_versao_pagamento     = p_versao
       and    mov_emp_numero_matricula = r_via.mov_emp_numero_matricula
       and    mov_rub_codigo           = 1905  -- rubrica remuneracao do empregado
       and    mov_tip_rubrica          = 'N';

   cursor c_rub is
       select rub_seq_pagamento
       from   rubricas
       where  rub_codigo = p_rubrica;

--**********************************************************************--
--**                INÍCIO DA PROCEDURE PRINCIPAL                     **--
--**********************************************************************--
Begin
   open c_via;
   loop
      fetch c_via into r_via;
      exit when c_via%notfound;
      --
      -- Exclui todas as rubricas referentes à diária de viagem.
      --
      begin
        delete movimentacao
        where  mov_ano_referencia       = p_ano
        and    mov_mes_referencia       = p_mes
        and    mov_versao_pagamento     = p_versao
        and    mov_emp_numero_matricula = r_via.mov_emp_numero_matricula
        and    mov_rub_codigo          in (1100,1110,5650)
        and    mov_tip_rubrica          = 'N';
      exception
        when others then
          null;
      end;
      --
      if r_via.emp_status <> 2 then
         v_mes_ant := to_number(to_char(add_months(to_date(to_char(p_mes)||
                      '/'||to_char(p_ano),'MM/YYYY'),-1),'MM'));
         v_ano_ant := to_number(to_char(add_months(to_date(to_char(p_mes)||
                      '/'||to_char(p_ano),'MM/YYYY'),-1),'YYYY'));

         v_valor_oem  := 0;
         v_valor_1905 := 0;
         p_rubrica  := null;

         open  c_oem;
         fetch c_oem into v_valor_oem;
         close c_oem;

         open  c_mov;
         fetch c_mov into v_valor_1905;
         close c_mov;

         if v_valor_1905 > 0 and v_valor_oem > 0 then
            if (v_valor_1905 / 2) > v_valor_oem then    -- lança menor que 50% da remuneração.
               p_rubrica  := 1100;
            elsif (v_valor_1905 / 2) < v_valor_oem then -- lança maior que 50% da remuneração.
               p_rubrica  := 1110;
            end if;

            v_seq_pagto := 0;

            open  c_rub;
            fetch c_rub into v_seq_pagto;
            close c_rub;

            insert into movimentacao ( mov_emp_numero_matricula, 
                                       mov_ano_referencia,
                                       mov_mes_referencia, 
                                       mov_versao_pagamento, 
                                       mov_rub_codigo, 
                                       mov_sequencial,
                                       mov_parcela, 
                                       mov_parcela_atual, 
                                       mov_tip_rubrica,
                                       mov_ind_calculo,
                                       mov_rub_seq_pagamento,
                                       mov_ind_exclusivo,
                                       mov_valor,
                                       mov_tipo_parametro,
                                       mov_parametro,
                                       mov_valor_integral,
                                       mov_emp_dep_codigo_pagto,
                                       mov_data_calculo )
            values ( r_via.mov_emp_numero_matricula,
                     p_ano,
                     p_mes,
                     p_versao,
                     p_rubrica,
                     1,
                     001,
                     001,
                     'N',
                     'S',
                     v_seq_pagto,
                     'S',
                     v_valor_oem,
                     'V',
                     v_valor_oem,
                     v_valor_oem,
                     r_via.mov_emp_dep_codigo_pagto,
                     sysdate );

            p_rubrica   := 5650;
            v_seq_pagto := 0;

            open  c_rub;
            fetch c_rub into v_seq_pagto;
            close c_rub;

            insert into movimentacao ( mov_emp_numero_matricula, 
                                       mov_ano_referencia,
                                       mov_mes_referencia, 
                                       mov_versao_pagamento, 
                                       mov_rub_codigo, 
                                       mov_sequencial,
                                       mov_parcela, 
                                       mov_parcela_atual, 
                                       mov_tip_rubrica,
                                       mov_ind_calculo,
                                       mov_rub_seq_pagamento,
                                       mov_ind_exclusivo,
                                       mov_valor,
                                       mov_tipo_parametro,
                                       mov_parametro,
                                       mov_valor_integral,
                                       mov_emp_dep_codigo_pagto,
                                       mov_data_calculo )
            values ( r_via.mov_emp_numero_matricula,
                     p_ano,
                     p_mes,
                     p_versao,
                     p_rubrica,
                     1,
                     001,
                     001,
                     'N',
                     'S',
                     v_seq_pagto,
                     'S',
                     v_valor_oem,
                     'V',
                     v_valor_oem,
                     v_valor_oem,
                     r_via.mov_emp_dep_codigo_pagto,
                     sysdate );
         end if;
      end if;
   end loop;
   close c_via;
End;
