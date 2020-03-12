-- Procedure TRATA_AFASTAMENTOS

CREATE OR REPLACE
Procedure trata_afastamentos (par_matricula   number) is
  v_dia                    number;
  v_mes_proximo            number(2);
  v_ano_proximo            number(4);
  v_dep                    number(4);
  v_dias_desconto          number(2);
  v_dias_funcao            number(2);
  v_seq                    number(4);
  v_seq_pagto              number(4);
  v_cont                   number(4);
  v_data_ref               date;
  v_ano_calculo            number(4);
  v_mes_calculo            number(2);
  v_versao                 number(1);
  cursor c_afa is
    select  distinct(oem_emp_numero_matricula) oem_emp_numero_matricula
    from    ocorrencias_empregados
    where   oem_ofu_codigo in (13,15,16,18,21,22,26,28,29,31,33,79,127,136,143,144)
    and   ((to_number(to_char(oem_data_inicio,'yyyymm')) =
            to_number(to_char(v_ano_calculo)||lpad(to_char(v_mes_calculo),2,'0'))) or
           (to_number(to_char(oem_data_termino,'yyyymm')) =
            to_number(to_char(v_ano_calculo)||lpad(to_char(v_mes_calculo),2,'0'))) or
           (to_number(to_char(oem_data_inicio,'yyyymm')) <
            to_number(to_char(v_ano_calculo)||lpad(to_char(v_mes_calculo),2,'0')) and
            to_number(to_char(oem_data_termino,'yyyymm')) >
            to_number(to_char(v_ano_calculo)||lpad(to_char(v_mes_calculo),2,'0'))) or
           (to_number(to_char(oem_data_inicio,'yyyymm')) <=
            to_number(to_char(v_ano_calculo)||lpad(to_char(v_mes_calculo),2,'0')) and
            oem_data_termino is null));
  r_afa                    c_afa%rowtype;
  cursor c_afa1 is
    select  oem_emp_numero_matricula, oem_ofu_codigo, oem_data_inicio, oem_data_termino
    from    ocorrencias_empregados
    where   oem_emp_numero_matricula = r_afa.oem_emp_numero_matricula
    and     oem_ofu_codigo in (13,15,16,18,21,22,26,28,29,31,33,79,127,136,143,144)
    and   ((to_number(to_char(oem_data_inicio,'yyyymm')) =
            to_number(to_char(v_ano_calculo)||lpad(to_char(v_mes_calculo),2,'0'))) or
           (to_number(to_char(oem_data_termino,'yyyymm')) =
            to_number(to_char(v_ano_calculo)||lpad(to_char(v_mes_calculo),2,'0'))) or
           (to_number(to_char(oem_data_inicio,'yyyymm')) <
            to_number(to_char(v_ano_calculo)||lpad(to_char(v_mes_calculo),2,'0')) and
            to_number(to_char(oem_data_termino,'yyyymm')) >
            to_number(to_char(v_ano_calculo)||lpad(to_char(v_mes_calculo),2,'0'))) or
           (to_number(to_char(oem_data_inicio,'yyyymm')) <=
            to_number(to_char(v_ano_calculo)||lpad(to_char(v_mes_calculo),2,'0')) and
            oem_data_termino is null))
    order by oem_data_inicio;
  r_afa1                   c_afa1%rowtype;
  v_ano_ant                number(4);
  v_mes_ant                number(2);
  cursor c_afa2 is
    select  distinct(oem_emp_numero_matricula) oem_emp_numero_matricula
    from    ocorrencias_empregados
    where   oem_ofu_codigo in (13,15,16,18,21,22,26,28,29,31,33,79,127,136,143,144)
    and    (to_number(to_char(oem_data_termino,'yyyymm')) =
            to_number(to_char(v_ano_ant)||lpad(to_char(v_mes_ant),2,'0')))
    and     oem_emp_numero_matricula not in (
          select oem_emp_numero_matricula
          from   ocorrencias_empregados
          where  oem_ofu_codigo in (13,15,16,18,21,22,26,28,29,31,33,79,127,136,143,144)
          and  ((to_number(to_char(oem_data_inicio,'yyyymm')) =
                 to_number(to_char(v_ano_calculo)||lpad(to_char(v_mes_calculo),2,'0'))) or
                (to_number(to_char(oem_data_termino,'yyyymm')) =
                 to_number(to_char(v_ano_calculo)||lpad(to_char(v_mes_calculo),2,'0'))) or
                (to_number(to_char(oem_data_inicio,'yyyymm')) <
                 to_number(to_char(v_ano_calculo)||lpad(to_char(v_mes_calculo),2,'0')) and
                 to_number(to_char(oem_data_termino,'yyyymm')) >
                 to_number(to_char(v_ano_calculo)||lpad(to_char(v_mes_calculo),2,'0'))) or
                (to_number(to_char(oem_data_inicio,'yyyymm')) <=
                 to_number(to_char(v_ano_calculo)||lpad(to_char(v_mes_calculo),2,'0')) and
                 oem_data_termino is null)));
  cursor c_ocor is
    select  oem_emp_numero_matricula, oem_ofu_codigo, oem_data_inicio, oem_data_termino,
            oem_tipo_remuneracao_funcao, oem_fun_codigo
    from    ocorrencias_empregados
    where   oem_emp_numero_matricula = r_afa.oem_emp_numero_matricula
    and     oem_ofu_codigo = 212
    and   ((to_number(to_char(oem_data_inicio,'yyyymm')) =
            to_number(to_char(v_ano_calculo)||lpad(to_char(v_mes_calculo),2,'0'))) or
           (to_number(to_char(oem_data_termino,'yyyymm')) =
            to_number(to_char(v_ano_calculo)||lpad(to_char(v_mes_calculo),2,'0'))) or
           (to_number(to_char(oem_data_inicio,'yyyymm')) <
            to_number(to_char(v_ano_calculo)||lpad(to_char(v_mes_calculo),2,'0')) and
            to_number(to_char(oem_data_termino,'yyyymm')) >
            to_number(to_char(v_ano_calculo)||lpad(to_char(v_mes_calculo),2,'0'))) or
           (to_number(to_char(oem_data_inicio,'yyyymm')) <=
            to_number(to_char(v_ano_calculo)||lpad(to_char(v_mes_calculo),2,'0')) and
            oem_data_termino is null))
    order by oem_data_inicio;
  r_ocor                    c_ocor%rowtype;
  cursor c_mov_ben is
     select mov_emp_numero_matricula, mov_rub_codigo, mov_tip_rubrica, rowid
     from   movimentacao
     where  mov_ano_referencia       = v_ano_calculo
     and    mov_mes_referencia       = v_mes_calculo
     and    mov_versao_pagamento     = v_versao
     and    mov_emp_numero_matricula = r_afa1.oem_emp_numero_matricula
     and  ((mov_rub_codigo       in (select rub_codigo from rubricas
                                     where  rub_tipo_rubrica    = 'D'
                                     and    rub_indic_exclusiva = 'S')) or
           (mov_rub_codigo       in (select rub_codigo from rubricas
                                     where  rub_tipo_rubrica    = 'D'
                                     and    rub_indic_exclusiva = 'N') and
            mov_parcela > 1))
     and    mov_rub_codigo    not in (select rub_codigo from rubricas
                                      where  rub_indic_beneficio    = 'S')
     and    mov_rub_codigo    not in (5100,5050,5615,5207,5620,5625,5030,5067)
     order by mov_rub_codigo, mov_sequencial;
  r_mov_ben                c_mov_ben%rowtype;
  cursor c_mov is
     select mov_emp_numero_matricula, mov_rub_codigo, mov_tip_rubrica, rowid
     from   movimentacao
     where  mov_ano_referencia       = v_ano_calculo
     and    mov_mes_referencia       = v_mes_calculo
     and    mov_versao_pagamento     = v_versao
     and    mov_emp_numero_matricula = r_afa1.oem_emp_numero_matricula
     and  ((mov_rub_codigo       in (select rub_codigo from rubricas
                                     where  rub_tipo_rubrica    = 'D'
                                     and    rub_indic_exclusiva = 'S')) or
           (mov_rub_codigo       in (select rub_codigo from rubricas
                                     where  rub_tipo_rubrica    = 'D'
                                     and    rub_indic_exclusiva = 'N') and
            mov_parcela > 1))
     and    mov_rub_codigo       not in (5100,5050,5615,5207,5510,5620,5625,5030,5067,5500)
     order by mov_rub_codigo, mov_sequencial;
  r_mov                    c_mov%rowtype;
--------------------------------------------------------------------------
--                 CALCULA DIAS PORPORCIONAIS                           --
--------------------------------------------------------------------------
Procedure Calcula_dias_proporcionais is
Begin
   v_dia  := to_number(to_char(last_day(to_date(to_char(v_mes_calculo,'00')
     	        	   ||'/'||to_char(v_ano_calculo,'0000'),'MM/YYYY')),'DD'));
   -- data início igual ao último dia do mês que está sendo calculado
   if to_number(to_char(r_afa1.oem_data_inicio,'dd')) = v_dia and
      to_number(to_char(r_afa1.oem_data_inicio,'yyyymm')) =
      to_number(to_char(v_ano_calculo)||lpad(to_char(v_mes_calculo),2,'0')) then
           v_dias_desconto := v_dias_desconto + 1; -- se for fevereiro dia 28 deverá calcular 3 dias?
   -- data início e término no mesmo mês
   elsif to_number(to_char(r_afa1.oem_data_inicio,'yyyymm')) =
         to_number(to_char(v_ano_calculo)||lpad(to_char(v_mes_calculo),2,'0')) and
         to_number(to_char(r_afa1.oem_data_termino,'yyyymm')) =
         to_number(to_char(v_ano_calculo)||lpad(to_char(v_mes_calculo),2,'0')) then
         v_dias_desconto := v_dias_desconto + ((r_afa1.oem_data_termino -
                            r_afa1.oem_data_inicio ) + 1);
   --  data início dentro do mês de cálculo e data término maior que o mês de cálculo
   elsif to_number(to_char(r_afa1.oem_data_inicio,'yyyymm')) =
         to_number(to_char(v_ano_calculo)||lpad(to_char(v_mes_calculo),2,'0')) and
         to_number(to_char(r_afa1.oem_data_termino,'yyyymm')) >
         to_number(to_char(v_ano_calculo)||lpad(to_char(v_mes_calculo),2,'0')) then
         v_dias_desconto := v_dias_desconto +
                            ((30 - to_number(to_char(r_afa1.oem_data_inicio,'dd'))) + 1);
         if v_dias_desconto = 0 then -- entrará aqui se a data de início for dia 31
            v_dias_desconto := 1;
         end if;
   -- data início dentro do mês de cálculo e data término nula
   elsif to_number(to_char(r_afa1.oem_data_inicio,'yyyymm')) =
         to_number(to_char(v_ano_calculo)||lpad(to_char(v_mes_calculo),2,'0')) and
         r_afa1.oem_data_termino is null then
         v_dias_desconto := v_dias_desconto +
                            ((30 - to_number(to_char(r_afa1.oem_data_inicio,'dd'))) + 1);
         if v_dias_desconto = 0 then -- entrará aqui se a data de início for dia 31
            v_dias_desconto := 1;
         end if;
   -- data início começando antes do mês de cálculo e data término terminando depois do mês de cálculo
   elsif to_number(to_char(r_afa1.oem_data_inicio,'yyyymm')) <
         to_number(to_char(v_ano_calculo)||lpad(to_char(v_mes_calculo),2,'0')) and
         to_number(to_char(r_afa1.oem_data_termino,'yyyymm')) >
         to_number(to_char(v_ano_calculo)||lpad(to_char(v_mes_calculo),2,'0')) then
         v_dias_desconto := 30;
   -- data início começando antes do mês de cálculo e data término nula
   elsif to_number(to_char(r_afa1.oem_data_inicio,'yyyymm')) <
         to_number(to_char(v_ano_calculo)||lpad(to_char(v_mes_calculo),2,'0')) and
         r_afa1.oem_data_termino is null then
         v_dias_desconto := 30;
   -- data início começando antes do mês de cálculo e data término dentro do mês de cálculo
   elsif to_number(to_char(r_afa1.oem_data_inicio,'yyyymm')) <
         to_number(to_char(v_ano_calculo)||lpad(to_char(v_mes_calculo),2,'0')) and
         to_number(to_char(r_afa1.oem_data_termino,'yyyymm')) =
         to_number(to_char(v_ano_calculo)||lpad(to_char(v_mes_calculo),2,'0')) then
         v_dias_desconto := to_number(to_char(r_afa1.oem_data_termino,'DD'));
   end if;
   if v_dias_desconto > 30 then
      v_dias_desconto := 30;
   end if;
   if v_dias_desconto < 0 then
      v_dias_desconto := 0;
   end if;
End;
--------------------------------------------------------------------------
--                       RUBRICAS_MENOS_BENEFICIO                       --
--------------------------------------------------------------------------
Procedure rubricas_menos_beneficio is
Begin
  v_seq := 0;
  open c_mov_ben;
  loop
    fetch c_mov_ben into r_mov_ben;
    exit when c_mov_ben%notfound;
    v_seq := busca_mov_seq (v_mes_proximo, v_ano_proximo, v_versao,
                            r_afa1.oem_emp_numero_matricula, r_mov_ben.mov_rub_codigo,
                            r_mov_ben.mov_tip_rubrica);
    update movimentacao
    set    mov_mes_referencia  = v_mes_proximo,
           mov_ano_referencia  = v_ano_proximo,
           mov_sequencial      = v_seq
    where  rowid = r_mov_ben.rowid;
  end loop;
  close c_mov_ben;
End;
--------------------------------------------------------------------------
--                       TRANSFERE_RUBRICAS_TOTAL                       --
--------------------------------------------------------------------------
Procedure transfere_rubricas_total is
Begin
  v_seq := 0;
  open c_mov;
  loop
    fetch c_mov into r_mov;
    exit when c_mov%notfound;
    if r_mov.mov_rub_codigo in (5200,5210,5205,5215,5225,5230,5220,5235,5202) and
       r_mov.mov_tip_rubrica = 'N' then
       r_mov.mov_tip_rubrica := 'D';
    end if;
    v_seq := busca_mov_seq (v_mes_proximo, v_ano_proximo, v_versao,
                            r_afa1.oem_emp_numero_matricula, r_mov.mov_rub_codigo,
                            r_mov.mov_tip_rubrica);
    update movimentacao
    set    mov_mes_referencia    = v_mes_proximo,
           mov_ano_referencia    = v_ano_proximo,
           mov_sequencial        = v_seq,
           mov_ano_ref_diferenca = v_ano_calculo,
           mov_mes_ref_diferenca = v_mes_calculo,
           mov_tip_rubrica       = r_mov.mov_tip_rubrica
    where  rowid = r_mov.rowid;
  end loop;
  close c_mov;
End;
--------------------------------------------------------------------------
--                     ATUALIZA_PROPORCIONALIDADE                       --
--------------------------------------------------------------------------
Procedure atualiza_proporcionalidade is
Begin
  begin
    update movimentacao
    set    mov_dias_proporcionalidade = 30 - v_dias_desconto
    where  mov_ano_referencia         = v_ano_calculo
    and    mov_mes_referencia         = v_mes_calculo
    and    mov_versao_pagamento       = v_versao
    and    mov_emp_numero_matricula   = r_afa1.oem_emp_numero_matricula
    and    mov_rub_codigo       in (select rub_codigo from rubricas
                                    where  rub_indic_proporcional = 'S')
    and    mov_tip_rubrica = 'N'
    and    mov_rub_codigo not in (1020,1030,1387,1390);
--
    update movimentacao
    set    mov_dias_proporcionalidade = 0
    where  mov_ano_referencia         = v_ano_calculo
    and    mov_mes_referencia         = v_mes_calculo
    and    mov_versao_pagamento       = v_versao
    and    mov_emp_numero_matricula   = r_afa1.oem_emp_numero_matricula
    and    mov_rub_codigo             = 5067
    and    mov_tip_rubrica            = 'N';
  end;
End;
--------------------------------------------------------------------------
--                       ATUALIZA_1993_1994_1995                        --
--------------------------------------------------------------------------
Procedure Atualiza_1993_1994_1995 is
Begin
--  if r_afa1.oem_ofu_codigo in (21, 22, 136) then  -- BASE INSS 1993
if r_afa1.oem_ofu_codigo in (22, 136) then  -- BASE INSS 1993
     begin
       select rub_seq_pagamento
       into   v_seq_pagto
       from   rubricas
       where  rub_codigo  = 1993;
     end;
     update movimentacao
     set    mov_parcela                = 1,
            mov_parcela_atual          = 1,
            mov_rub_seq_pagamento      = v_seq_pagto,
            mov_dias_proporcionalidade = v_dias_desconto
     where  mov_ano_referencia         = v_ano_calculo
     and    mov_mes_referencia         = v_mes_calculo
     and    mov_versao_pagamento       = v_versao
     and    mov_emp_numero_matricula   = r_afa1.oem_emp_numero_matricula
     and    mov_rub_codigo             = 1993
     and    mov_tip_rubrica            = 'N';
     if sql%notfound then
       insert into movimentacao (mov_ano_referencia,mov_mes_referencia,mov_versao_pagamento,
           mov_emp_numero_matricula, mov_rub_codigo, mov_sequencial, mov_parcela,
           mov_parcela_atual, mov_rub_seq_pagamento, mov_emp_dep_codigo_pagto,
           mov_tip_rubrica,mov_ind_calculo,mov_ind_exclusivo,mov_dias_proporcionalidade,
           mov_ind_arsaprev, mov_flg_frequencia)
       values (v_ano_calculo,v_mes_calculo,v_versao,r_afa1.oem_emp_numero_matricula,
               1993,1,1,1,v_seq_pagto,v_dep,'N','N','S',v_dias_desconto,'N','N');
     end if;
  end if;
--  if r_afa1.oem_ofu_codigo in (15, 31, 144, 21, 22, 136) then -- BASE FGTS 1994
  if r_afa1.oem_ofu_codigo in (15, 31, 144, 22, 136) then -- BASE FGTS 1994
     begin
       select rub_seq_pagamento
       into   v_seq_pagto
       from   rubricas
       where  rub_codigo  = 1994;
     end;
     update movimentacao
     set    mov_parcela                = 1,
            mov_parcela_atual          = 1,
            mov_rub_seq_pagamento      = v_seq_pagto,
            mov_dias_proporcionalidade = v_dias_desconto
     where  mov_ano_referencia         = v_ano_calculo
     and    mov_mes_referencia         = v_mes_calculo
     and    mov_versao_pagamento       = v_versao
     and    mov_emp_numero_matricula   = r_afa1.oem_emp_numero_matricula
     and    mov_rub_codigo             = 1994
     and    mov_tip_rubrica            = 'N';
     if sql%notfound then
       insert into movimentacao (mov_ano_referencia,mov_mes_referencia,mov_versao_pagamento,
           mov_emp_numero_matricula, mov_rub_codigo, mov_sequencial, mov_parcela,
           mov_parcela_atual, mov_rub_seq_pagamento, mov_emp_dep_codigo_pagto,
           mov_tip_rubrica,mov_ind_calculo,mov_ind_exclusivo,mov_dias_proporcionalidade,
           mov_ind_arsaprev, mov_flg_frequencia)
       values (v_ano_calculo,v_mes_calculo,v_versao,r_afa1.oem_emp_numero_matricula,
               1994,1,1,1,v_seq_pagto,v_dep,'N','N','S',v_dias_desconto,'N','N');
     end if;
  end if;
  if r_afa1.oem_ofu_codigo in (15, 16, 127, 21, 22, 136) then  -- BASE INFRAPREV 1995
     begin
       select rub_seq_pagamento
       into   v_seq_pagto
       from   rubricas
       where  rub_codigo  = 1995;
     end;
     update movimentacao
     set    mov_parcela                = 1,
            mov_parcela_atual          = 1,
            mov_rub_seq_pagamento      = v_seq_pagto,
            mov_dias_proporcionalidade = v_dias_desconto
     where  mov_ano_referencia         = v_ano_calculo
     and    mov_mes_referencia         = v_mes_calculo
     and    mov_versao_pagamento       = v_versao
     and    mov_emp_numero_matricula   = r_afa1.oem_emp_numero_matricula
     and    mov_rub_codigo             = 1995
     and    mov_tip_rubrica            = 'N';
     if sql%notfound then
       insert into movimentacao (mov_ano_referencia,mov_mes_referencia,mov_versao_pagamento,
           mov_emp_numero_matricula, mov_rub_codigo, mov_sequencial, mov_parcela,
           mov_parcela_atual, mov_rub_seq_pagamento, mov_emp_dep_codigo_pagto,
           mov_tip_rubrica,mov_ind_calculo,mov_ind_exclusivo,mov_dias_proporcionalidade,
           mov_ind_arsaprev, mov_flg_frequencia)
       values (v_ano_calculo,v_mes_calculo,v_versao,r_afa1.oem_emp_numero_matricula,
               1995,1,1,1,v_seq_pagto,v_dep,'N','N','S',v_dias_desconto,'N','N');
     end if;
  end if;
End;
--------------------------------------------------------------------------
--                           TRATA_FUNCAO                               --
--------------------------------------------------------------------------
Procedure trata_funcao is
Begin
  open c_ocor;
  loop
     fetch c_ocor into r_ocor;
     exit when c_ocor%notfound;
     v_dia  := to_number(to_char(last_day(to_date(to_char(v_mes_calculo,'00')||'/'||
                         to_char(v_ano_calculo,'0000'),'MM/YYYY')),'DD'));
     if to_number(to_char(r_ocor.oem_data_inicio,'dd')) = v_dia and
        to_number(to_char(r_ocor.oem_data_inicio,'yyyymm')) =
        to_number(to_char(v_ano_calculo)||lpad(to_char(v_mes_calculo),2,'0')) then
           v_dias_funcao := 1;
     elsif to_number(to_char(r_ocor.oem_data_inicio,'yyyymm')) =
           to_number(to_char(v_ano_calculo)||lpad(to_char(v_mes_calculo),2,'0')) and
           to_number(to_char(r_ocor.oem_data_termino,'yyyymm')) =
           to_number(to_char(v_ano_calculo)||lpad(to_char(v_mes_calculo),2,'0')) then
           v_dias_funcao := ((r_ocor.oem_data_termino -  r_ocor.oem_data_inicio ) + 1);
     elsif to_number(to_char(r_ocor.oem_data_inicio,'yyyymm')) =
           to_number(to_char(v_ano_calculo)||lpad(to_char(v_mes_calculo),2,'0')) and
           to_number(to_char(r_ocor.oem_data_termino,'yyyymm')) >
           to_number(to_char(v_ano_calculo)||lpad(to_char(v_mes_calculo),2,'0')) then
           v_dias_funcao := ((30 - to_number(to_char(r_ocor.oem_data_inicio,'dd'))) + 1);
     elsif to_number(to_char(r_ocor.oem_data_inicio,'yyyymm')) =
           to_number(to_char(v_ano_calculo)||lpad(to_char(v_mes_calculo),2,'0')) and
           r_ocor.oem_data_termino is null then
           v_dias_funcao := ((30 - to_number(to_char(r_ocor.oem_data_inicio,'dd'))) + 1);
     elsif to_number(to_char(r_ocor.oem_data_inicio,'yyyymm')) <
           to_number(to_char(v_ano_calculo)||lpad(to_char(v_mes_calculo),2,'0')) and
           to_number(to_char(r_ocor.oem_data_termino,'yyyymm')) >
           to_number(to_char(v_ano_calculo)||lpad(to_char(v_mes_calculo),2,'0')) then
           v_dias_funcao := 30;
     elsif to_number(to_char(r_ocor.oem_data_inicio,'yyyymm')) <
           to_number(to_char(v_ano_calculo)||lpad(to_char(v_mes_calculo),2,'0')) and
           r_ocor.oem_data_termino is null then
           v_dias_funcao := 30;
     elsif to_number(to_char(r_ocor.oem_data_inicio,'yyyymm')) <
           to_number(to_char(v_ano_calculo)||lpad(to_char(v_mes_calculo),2,'0')) and
           to_number(to_char(r_ocor.oem_data_termino,'yyyymm')) =
           to_number(to_char(v_ano_calculo)||lpad(to_char(v_mes_calculo),2,'0')) then
           v_dias_funcao := to_number(to_char(r_ocor.oem_data_termino,'DD'));
     end if;
     if r_ocor.oem_tipo_remuneracao_funcao = 'RG' then
        begin
          update movimentacao
          set    mov_dias_proporcionalidade = v_dias_funcao
          where  mov_ano_referencia         = v_ano_calculo
          and    mov_mes_referencia         = v_mes_calculo
          and    mov_versao_pagamento       = v_versao
          and    mov_emp_numero_matricula   = r_afa.oem_emp_numero_matricula
          and    mov_rub_codigo            in (1010,1060,1070)
          and    mov_tip_rubrica            = 'N'
          and    mov_oem_ofu_codigo         = r_ocor.oem_ofu_codigo
          and    mov_oem_data_inicio        = r_ocor.oem_data_inicio;
        exception
          when no_data_found then
            null;
        end;
        begin
          update movimentacao
          set    mov_dias_proporcionalidade = 30 - v_dias_funcao
          where  mov_ano_referencia         = v_ano_calculo
          and    mov_mes_referencia         = v_mes_calculo
          and    mov_versao_pagamento       = v_versao
          and    mov_emp_numero_matricula   = r_afa.oem_emp_numero_matricula
          and    mov_rub_codigo             = 1000
          and    mov_tip_rubrica            = 'N';
        exception
          when no_data_found then
            null;
        end;
     end if;
  end loop;
  close c_ocor;
End;
--------------------------------------------------------------------------
--                       ATUALIZA_MES_ANTERIOR                          --
--------------------------------------------------------------------------
Procedure atualiza_mes_anterior is
Begin
  begin
    update movimentacao
    set    mov_dias_proporcionalidade = 30
    where  mov_ano_referencia         = v_ano_calculo
    and    mov_mes_referencia         = v_mes_calculo
    and    mov_versao_pagamento       = v_versao
    and    mov_emp_numero_matricula   = r_afa.oem_emp_numero_matricula
    and    mov_rub_codigo not in (1020,1030);
  end;
  begin
    delete movimentacao
    where  mov_ano_referencia         = v_ano_calculo
    and    mov_mes_referencia         = v_mes_calculo
    and    mov_versao_pagamento       = v_versao
    and    mov_emp_numero_matricula   = r_afa.oem_emp_numero_matricula
    and    mov_rub_codigo in (1993,1994,1995);
  end;
  trata_funcao;
End;
--------------------------------------------------------------------------
--                          EFETUA_AFASTAMENTO                          --
--------------------------------------------------------------------------
Procedure efetua_afastamento is
Begin
  v_dias_desconto := 0;
  v_cont          := 0;
  open c_afa1;
  loop
     fetch c_afa1 into r_afa1;
     exit when c_afa1%notfound;
     v_cont := v_cont + 1;
     if r_afa1.oem_ofu_codigo in (21, 22) then
        rubricas_menos_beneficio;
     else
        transfere_rubricas_total;
     end if;
     calcula_dias_proporcionais;
     atualiza_proporcionalidade;
     trata_funcao;
     begin
       select emp_dep_codigo_lotacao
       into   v_dep
       from   cadastros
       where  emp_numero_matricula = r_afa1.oem_emp_numero_matricula;
     end;
     atualiza_1993_1994_1995;
  end loop;
  close c_afa1;
  if v_cont = 0 then
     atualiza_mes_anterior;
  end if;
End;
--**********************************************************************--
--**                INÍCIO DA PROCEDURE PRINCIPAL                     **--
--**********************************************************************--
Begin
   v_data_ref     := verifica_folha_atual;
   v_mes_calculo  := to_number(to_char(v_data_ref,'MM'));
   v_ano_calculo  := to_number(to_char(v_data_ref,'YYYY'));
--   v_mes_calculo  := 09;
--   v_ano_calculo  := 2002;
   v_versao       := 1;
   if v_mes_calculo = 12 then
      v_mes_proximo := 1;
      v_ano_proximo := v_ano_calculo + 1;
   else
      v_mes_proximo := v_mes_calculo + 1;
      v_ano_proximo := v_ano_calculo;
   end if;
   if par_matricula is null then
     open c_afa;
     loop
       fetch c_afa into r_afa;
       exit when c_afa%notfound;
       efetua_afastamento;
     end loop;
     close c_afa;
     -- Tratamento para os afastamentos que terminaram no mês anterior.
     if v_mes_calculo = 01 then
        v_ano_ant := v_ano_calculo - 1;
        v_mes_ant := 12;
     else
        v_ano_ant := v_ano_calculo;
        v_mes_ant := v_mes_calculo - 1;
     end if;
     open c_afa2;
     loop
       fetch c_afa2 into r_afa;
       exit when c_afa2%notfound;
       efetua_afastamento;
     end loop;
     close c_afa2;
   else
     r_afa.oem_emp_numero_matricula := par_matricula;
     efetua_afastamento;
   end if;
End;
/

-- Grants for TRATA_AFASTAMENTOS

GRANT EXECUTE ON trata_afastamentos TO rh_perfil_99
/

-- End of DDL script for TRATA_AFASTAMENTOS
