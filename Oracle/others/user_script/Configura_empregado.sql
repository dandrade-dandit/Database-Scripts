CREATE OR REPLACE PROCEDURE configura_empregado (p_mes         IN NUMBER,
                               p_ano         IN NUMBER,
                               p_versao      IN NUMBER,
                               p_dep_codigo  IN NUMBER,
                               p_matricula   IN NUMBER) IS
CURSOR c_emp IS
  select   mov.mov_emp_numero_matricula emp_numero_matricula,
           emp.emp_dep_codigo_pagto,
           emp.emp_data_admissao,
           emp.emp_status
  from     movimentacao mov,
           cadastros    emp
  where    mov.mov_emp_numero_matricula = emp.emp_numero_matricula
  and      mov.mov_ano_referencia   = p_ano
  and      mov.mov_mes_referencia   = p_mes
  and      mov.mov_versao_pagamento = p_versao
  and     (p_dep_codigo is null or mov_emp_dep_codigo_pagto = p_dep_codigo)
  and     (p_matricula is null or mov_emp_numero_matricula = p_matricula)
  group by mov.mov_emp_numero_matricula,
           emp.emp_dep_codigo_pagto,
           emp.emp_data_admissao,
           emp.emp_status;
r_emp               c_emp%ROWTYPE;
cursor c_ocor_falta is
  select ofe1.ofe_emp_numero_matricula,
         to_number(to_char(ofe1.ofe_data_inicio,'mm')),
         count(ofe1.ofe_emp_numero_matricula) total
  from   ocorrencias_frequencia_emp ofe1
  where  ofe1.ofe_ofu_codigo = 51
  and    ofe1.ofe_emp_numero_matricula = r_emp.emp_numero_matricula
  and    to_number(to_char(ofe1.ofe_data_inicio,'yyyy')) = p_ano
  and    not exists (select 'X'
                     from   ocorrencias_frequencia_emp ofe
                     where  ofe.ofe_emp_numero_matricula = ofe1.ofe_emp_numero_matricula
                     and    ofe.ofe_data_inicio          = ofe1.ofe_data_inicio
                     and    ofe.ofe_ofu_codigo           = 258)
  group by ofe1.ofe_emp_numero_matricula,
           to_number(to_char(ofe1.ofe_data_inicio,'mm'));
  -- custo 02 - unique scan ocorrencias_frequencias_emp
cursor c_ocor_resto is
  select   oem.oem_emp_numero_matricula,
           oem.oem_ofu_codigo,
           oem.oem_data_inicio,
           nvl(oem.oem_data_termino,to_date('31/12/'||to_char(p_ano),'dd/mm/yyyy'))  oem_data_termino,
         ((nvl(oem.oem_data_termino,to_date('31/12/'||to_char(p_ano),'dd/mm/yyyy')) - decode(to_number(to_char(oem.oem_data_inicio,'yyyy')),p_ano,oem.oem_data_inicio,to_date('01/01/'||to_char(p_ano),'dd/mm/yyyy'))) + 1) total
  from     ocorrencias_empregados oem
  where    oem.oem_ofu_codigo in (32,15,16,21,31,18,79,12,28,29,22,127,14,144,143,17,30)
  and      oem.oem_emp_numero_matricula = r_emp.emp_numero_matricula
  and      (to_number(to_char(oem.oem_data_inicio,'yyyy')) <= p_ano)
  and      (to_number(to_char(oem.oem_data_termino,'yyyy')) >= p_ano
            or
            oem.oem_data_termino is null);
  -- custo 01 - range scan ocorrencias_empregados
v_emp                           empregados_pagamentos%ROWTYPE;
v_emp_sfu_codigo                empregados.emp_sfu_codigo%TYPE;
v_emp_tipo_remuneracao_funcao   empregados.emp_tipo_remuneracao_funcao%TYPE;
v_mov_parametro                 movimentacao.mov_parametro%TYPE;
v_seq_pagamento                 rubricas.rub_seq_pagamento%TYPE;
v_mat                           ocorrencias_empregados.oem_emp_numero_matricula%type;
v_ofu_cod                       ocorrencias_empregados.oem_ofu_codigo%type;
v_data_ini                      ocorrencias_empregados.oem_data_inicio%type;
v_data_fim                      ocorrencias_empregados.oem_data_termino%type;
v_data_teste_ini                ocorrencias_empregados.oem_data_inicio%type;
v_data_teste_fim                ocorrencias_empregados.oem_data_termino%type;
v_mov_ind_13                    movimentacao.mov_ind_13%type;
v_total                         number := 0;
v_mes                           number := 0;
v_total_avos                    number := 0;
v_dias_mes_i                    number := 0;
v_dias_mes_f                    number := 0;
v_mes_01                        number := 0;
v_mes_02                        number := 0;
v_mes_03                        number := 0;
v_mes_04                        number := 0;
v_mes_05                        number := 0;
v_mes_06                        number := 0;
v_mes_07                        number := 0;
v_mes_08                        number := 0;
v_mes_09                        number := 0;
v_mes_10                        number := 0;
v_mes_11                        number := 0;
v_mes_12                        number := 0;
v_dias_mes_01                   number := 0;
v_dias_mes_02                   number := 0;
v_dias_mes_03                   number := 0;
v_dias_mes_04                   number := 0;
v_dias_mes_05                   number := 0;
v_dias_mes_06                   number := 0;
v_dias_mes_07                   number := 0;
v_dias_mes_08                   number := 0;
v_dias_mes_09                   number := 0;
v_dias_mes_10                   number := 0;
v_dias_mes_11                   number := 0;
v_dias_mes_12                   number := 0;
v_mes_i                         number := 0;
v_mes_f                         number := 0;
v_cont                          number := 0;
v_data_teste                    date;
v_mes_ini                       number;
v_mes_fim                       number;
--------------------------------------------------------------------------
--                    PROCEDURE ZERA_VARIAVEIS                       --
--------------------------------------------------------------------------
PROCEDURE ZERA_VARIAVEIS IS
BEGIN
   v_emp.egt_emp_numero_matricula         := NULL;
   v_emp.egt_crp_ano_pagamento            := NULL;
   v_emp.egt_crp_mes_pagamento            := NULL;
   v_emp.egt_crp_sequencial               := NULL;
   v_emp.egt_dep_codigo                   := NULL;
   v_emp.egt_uor_codigo                   := NULL;
   v_emp.egt_valor_fg                     := NULL;
   v_emp.egt_valor_rg                     := NULL;
   v_emp.egt_dependentes_ir               := NULL;
   v_emp.egt_dependentes_sal_fam          := NULL;
   v_emp.egt_numero_mes_13                := NULL;
   v_emp.egt_numero_anuenios              := NULL;
   v_emp.egt_carga_horaria_mes            := NULL;
   v_emp.egt_plano_arsaprev               := NULL;
   v_emp.egt_emp_qlp_car_codigo           := NULL;
   v_emp.egt_emp_qlp_car_codigo_nivel     := NULL;
   v_emp.egt_emp_qlp_car_occ_codigo       := NULL;
   v_emp.egt_emp_nsa_codigo_nivel         := NULL;
   v_emp.egt_emp_nsa_codigo_padrao        := NULL;
   v_emp.egt_emp_nsa_in_nivel_escolarid   := NULL;
   v_emp.egt_emp_qfu_fun_codigo           := NULL;
   v_emp.egt_hcc_cct_codigo               := NULL;
   v_emp.egt_dep_codigo_fisico            := NULL;
   v_mov_parametro                        := NULL;
END ZERA_VARIAVEIS;
--------------------------------------------------------------------------
--                      PROCEDURE BUSCA_DEP_IR                          --
--------------------------------------------------------------------------
PROCEDURE BUSCA_DEP_IR IS
BEGIN
  SELECT COUNT(*)
  INTO   v_emp.egt_dependentes_ir
  FROM   pessoas_vinculadas
  WHERE  pvi_emp_numero_matricula = r_emp.emp_numero_matricula
  AND    pvi_data_adesao_ir IS NOT NULL
  AND    (pvi_data_baixa_ir IS NULL
          OR to_number(TO_CHAR(pvi_data_baixa_ir,'YYYYMM')) >=
             to_number(TO_CHAR(p_ano,'9999')||
                  lpad(TO_CHAR(p_mes),2,'0')));
 -- custo 01 - range scan movimentacao
EXCEPTION
  WHEN no_data_found THEN
       v_emp.egt_dependentes_ir := 0;
END BUSCA_DEP_IR;
--------------------------------------------------------------------------
--                   PROCEDURE BUSCA_DEP_SAL_FAM                        --
--------------------------------------------------------------------------
PROCEDURE BUSCA_DEP_SAL_FAM IS
BEGIN
  SELECT COUNT(*)
  INTO   v_emp.egt_dependentes_sal_fam
  FROM   pessoas_vinculadas
  WHERE  pvi_emp_numero_matricula = r_emp.emp_numero_matricula
  AND    pvi_data_adesao_sf IS NOT NULL
  AND    (pvi_data_baixa_sf IS NULL
          OR to_number(TO_CHAR(pvi_data_baixa_sf,'YYYYMM')) >=
             to_number(TO_CHAR(p_ano,'9999')||
                  lpad(TO_CHAR(p_mes),2,'0')));
  -- custo 01 - range scan movimentacao
EXCEPTION
  WHEN no_data_found THEN
       v_emp.egt_dependentes_sal_fam := 0;
END BUSCA_DEP_SAL_FAM;
--------------------------------------------------------------------------
--                   PROCEDURE BUSCA_CARGA_HORARIA                      --
--------------------------------------------------------------------------
PROCEDURE BUSCA_CARGA_HORARIA IS
BEGIN
  SELECT jtr_quantidade_horas_mensais
  INTO   v_emp.egt_carga_horaria_mes
  FROM   cadastros, jornadas_trabalho
  WHERE  emp_numero_matricula = r_emp.emp_numero_matricula
  AND    emp_jtr_codigo       = jtr_codigo ;
  -- custo 02 - unique scan cadastros
  --          - unique scan jornadas_trabalho

EXCEPTION
  WHEN no_data_found THEN
       v_emp.egt_carga_horaria_mes := 0;
END BUSCA_CARGA_HORARIA;
--------------------------------------------------------------------------
--                   PROCEDURE BUSCA_DADOS_EMPREGADO                    --
--------------------------------------------------------------------------
PROCEDURE BUSCA_DADOS_EMPREGADO IS
BEGIN
  SELECT emp_plano_arsaprev, emp_qlp_car_codigo,
         emp_qlp_car_codigo_nivel, emp_qlp_car_occ_codigo, emp_nsa_codigo_nivel,
         emp_nsa_codigo_padrao, emp_nsa_in_nivel_escolaridade, emp_qfu_fun_codigo,
         emp_ati_ct_custos, emp_dep_codigo_pagto, emp_uor_codigo_lotacao,
         emp_sfu_codigo,emp_tipo_remuneracao_funcao, emp_dep_codigo_fisico
  INTO   v_emp.egt_plano_arsaprev,
         v_emp.egt_emp_qlp_car_codigo, v_emp.egt_emp_qlp_car_codigo_nivel,
         v_emp.egt_emp_qlp_car_occ_codigo, v_emp.egt_emp_nsa_codigo_nivel,
         v_emp.egt_emp_nsa_codigo_padrao, v_emp.egt_emp_nsa_in_nivel_escolarid,
         v_emp.egt_emp_qfu_fun_codigo, v_emp.egt_hcc_cct_codigo,
         v_emp.egt_dep_codigo, v_emp.egt_uor_codigo, v_emp_sfu_codigo,v_emp_tipo_remuneracao_funcao,
         v_emp.egt_dep_codigo_fisico
  FROM   cadastros
  WHERE  emp_numero_matricula = r_emp.emp_numero_matricula;
  -- custo 01 - unique scan cadastros

EXCEPTION
  WHEN no_data_found THEN
       v_emp.egt_dep_codigo := NULL;
       v_emp.egt_uor_codigo := NULL;
END BUSCA_DADOS_EMPREGADO;
--------------------------------------------------------------------------
--                  PROCEDURE BUSCA_NUMERO_ANUENIOS                     --
--------------------------------------------------------------------------
PROCEDURE BUSCA_NUMERO_ANUENIOS IS
BEGIN
  BEGIN
    SELECT oem.oem_mov_parametro, oem.oem_valor
    INTO   v_mov_parametro, v_emp.egt_numero_anuenios
    FROM   ocorrencias_empregados oem
    WHERE  oem.oem_emp_numero_matricula = r_emp.emp_numero_matricula
    AND    oem.oem_ofu_codigo = 216; -- Ocorrência de Quantidade de Anuênios
    -- custo 01 - range scan ocorrencias_empregados
  EXCEPTION
    WHEN no_data_found THEN
         v_emp.egt_numero_anuenios := 0;
         v_mov_parametro := 0;
  END;
END BUSCA_NUMERO_ANUENIOS;
--------------------------------------------------------------------------
--              INICIO DA PROCEDURE CALCULA_AVOS                        --
--------------------------------------------------------------------------
PROCEDURE CALCULA_AVOS IS
----------------------------------------------------------------------
-- Procedure que calcula a quantidade de avos que o empregado tem   --
-- direito para o cálculo do 13 salário.                            --
--                                                                  --
-- Criada          em 28/07/2000                                   --
-- Última alteração em                                              --
--                                                                  --
----------------------------------------------------------------------
   --
   v_data_reintegracao date;
   --
   CURSOR c_reintegrado(p_mat NUMBER) IS
      SELECT MAX(oem_data_inicio)
      FROM   ocorrencias_empregados
      WHERE  oem_ofu_codigo in (142,201,289,290)
      AND    oem_emp_numero_matricula = p_mat;
      -- custo 01 - range scan ocorrencias_empregados
   --
Begin
   --
   OPEN  c_reintegrado(r_emp.emp_numero_matricula);
   FETCH c_reintegrado INTO v_data_reintegracao;
   CLOSE c_reintegrado;
   --
   if v_data_reintegracao > r_emp.emp_data_admissao then
      r_emp.emp_data_admissao := v_data_reintegracao;
   end if;
   --
   if to_char(r_emp.emp_data_admissao,'YYYY') = p_ano then
      v_total_avos := 13 - to_number(to_char(r_emp.emp_data_admissao,'mm'));
      if to_number(last_day(r_emp.emp_data_admissao) - r_emp.emp_data_admissao) <
         round(to_number(to_char(last_day(r_emp.emp_data_admissao),'dd')) / 2) then
         v_total_avos := v_total_avos - 1;
      end if;
   else
      v_total_avos := 12;
   end if;
   v_mat            := null;
   v_ofu_cod        := null;
   v_data_ini       := null;
   v_data_fim       := null;
   v_total          := null;
   open c_ocor_falta;
   loop
      fetch c_ocor_falta into v_mat, v_mes, v_total;
      exit when c_ocor_falta%notfound;
      if v_mes    = 01 then v_dias_mes_01 := v_total;
      elsif v_mes = 02 then v_dias_mes_02 := v_total;
      elsif v_mes = 03 then v_dias_mes_03 := v_total;
      elsif v_mes = 04 then v_dias_mes_04 := v_total;
      elsif v_mes = 05 then v_dias_mes_05 := v_total;
      elsif v_mes = 06 then v_dias_mes_06 := v_total;
      elsif v_mes = 07 then v_dias_mes_07 := v_total;
      elsif v_mes = 08 then v_dias_mes_08 := v_total;
      elsif v_mes = 09 then v_dias_mes_09 := v_total;
      elsif v_mes = 10 then v_dias_mes_10 := v_total;
      elsif v_mes = 11 then v_dias_mes_11 := v_total;
      elsif v_mes = 12 then v_dias_mes_12 := v_total;
      end if;
   end loop;
   close c_ocor_falta;
   v_mat            := null;
   v_ofu_cod        := null;
   v_data_ini       := null;
   v_data_fim       := null;
   v_total          := null;
   open c_ocor_resto;
   loop
      fetch c_ocor_resto into v_mat, v_ofu_cod, v_data_ini, v_data_fim, v_total;
      exit when c_ocor_resto%notfound;
      -- Transforma data_ini e data_fim  para que as duas estejam dentro do ano
      if to_number(to_char(v_data_ini, 'yyyy')) <> p_ano then
         v_data_ini := to_date('01/01/'||to_char(p_ano),'dd/mm/yyyy');
      end if;
      if to_number(to_char(v_data_fim, 'yyyy')) <> p_ano then
         v_data_fim := to_date('31/12/'||to_char(p_ano),'dd/mm/yyyy');
      end if;
      if to_char(v_data_ini,'mm') = to_char(v_data_fim,'mm') then
         if to_char(v_data_ini,'mm')    = 01 then v_dias_mes_01 := nvl(v_dias_mes_01,0) + v_total;
         elsif to_char(v_data_ini,'mm') = 02 then v_dias_mes_02 := nvl(v_dias_mes_02,0) + v_total;
         elsif to_char(v_data_ini,'mm') = 03 then v_dias_mes_03 := nvl(v_dias_mes_03,0) + v_total;
         elsif to_char(v_data_ini,'mm') = 04 then v_dias_mes_04 := nvl(v_dias_mes_04,0) + v_total;
         elsif to_char(v_data_ini,'mm') = 05 then v_dias_mes_05 := nvl(v_dias_mes_05,0) + v_total;
         elsif to_char(v_data_ini,'mm') = 06 then v_dias_mes_06 := nvl(v_dias_mes_06,0) + v_total;
         elsif to_char(v_data_ini,'mm') = 07 then v_dias_mes_07 := nvl(v_dias_mes_07,0) + v_total;
         elsif to_char(v_data_ini,'mm') = 08 then v_dias_mes_08 := nvl(v_dias_mes_08,0) + v_total;
         elsif to_char(v_data_ini,'mm') = 09 then v_dias_mes_09 := nvl(v_dias_mes_09,0) + v_total;
         elsif to_char(v_data_ini,'mm') = 10 then v_dias_mes_10 := nvl(v_dias_mes_10,0) + v_total;
         elsif to_char(v_data_ini,'mm') = 11 then v_dias_mes_11 := nvl(v_dias_mes_11,0) + v_total;
         elsif to_char(v_data_ini,'mm') = 12 then v_dias_mes_12 := nvl(v_dias_mes_12,0) + v_total;
         end if;
      else
         v_data_teste_ini := last_day(v_data_ini);
         v_data_teste_fim := to_date('01'||to_char(nvl(v_data_fim,trunc(sysdate)),'mmyyyy'),'ddmmyyyy');
         v_mes_i := ((v_data_teste_ini - v_data_ini) + 1);
         v_mes_f := ((v_data_fim - v_data_teste_fim) + 1);
         if to_char(v_data_ini,'mm')    = 01 then v_dias_mes_01 := nvl(v_dias_mes_01,0) + v_mes_i;
         elsif to_char(v_data_ini,'mm') = 02 then v_dias_mes_02 := nvl(v_dias_mes_02,0) + v_mes_i;
         elsif to_char(v_data_ini,'mm') = 03 then v_dias_mes_03 := nvl(v_dias_mes_03,0) + v_mes_i;
         elsif to_char(v_data_ini,'mm') = 04 then v_dias_mes_04 := nvl(v_dias_mes_04,0) + v_mes_i;
         elsif to_char(v_data_ini,'mm') = 05 then v_dias_mes_05 := nvl(v_dias_mes_05,0) + v_mes_i;
         elsif to_char(v_data_ini,'mm') = 06 then v_dias_mes_06 := nvl(v_dias_mes_06,0) + v_mes_i;
         elsif to_char(v_data_ini,'mm') = 07 then v_dias_mes_07 := nvl(v_dias_mes_07,0) + v_mes_i;
         elsif to_char(v_data_ini,'mm') = 08 then v_dias_mes_08 := nvl(v_dias_mes_08,0) + v_mes_i;
         elsif to_char(v_data_ini,'mm') = 09 then v_dias_mes_09 := nvl(v_dias_mes_09,0) + v_mes_i;
         elsif to_char(v_data_ini,'mm') = 10 then v_dias_mes_10 := nvl(v_dias_mes_10,0) + v_mes_i;
         elsif to_char(v_data_ini,'mm') = 11 then v_dias_mes_11 := nvl(v_dias_mes_11,0) + v_mes_i;
         elsif to_char(v_data_ini,'mm') = 12 then v_dias_mes_12 := nvl(v_dias_mes_12,0) + v_mes_i;
         end if;
         if to_char(v_data_fim,'mm')    = 01 then v_dias_mes_01 := nvl(v_dias_mes_01,0) + v_mes_f;
         elsif to_char(v_data_fim,'mm') = 02 then v_dias_mes_02 := nvl(v_dias_mes_02,0) + v_mes_f;
         elsif to_char(v_data_fim,'mm') = 03 then v_dias_mes_03 := nvl(v_dias_mes_03,0) + v_mes_f;
         elsif to_char(v_data_fim,'mm') = 04 then v_dias_mes_04 := nvl(v_dias_mes_04,0) + v_mes_f;
         elsif to_char(v_data_fim,'mm') = 05 then v_dias_mes_05 := nvl(v_dias_mes_05,0) + v_mes_f;
         elsif to_char(v_data_fim,'mm') = 06 then v_dias_mes_06 := nvl(v_dias_mes_06,0) + v_mes_f;
         elsif to_char(v_data_fim,'mm') = 07 then v_dias_mes_07 := nvl(v_dias_mes_07,0) + v_mes_f;
         elsif to_char(v_data_fim,'mm') = 08 then v_dias_mes_08 := nvl(v_dias_mes_08,0) + v_mes_f;
         elsif to_char(v_data_fim,'mm') = 09 then v_dias_mes_09 := nvl(v_dias_mes_09,0) + v_mes_f;
         elsif to_char(v_data_fim,'mm') = 10 then v_dias_mes_10 := nvl(v_dias_mes_10,0) + v_mes_f;
         elsif to_char(v_data_fim,'mm') = 11 then v_dias_mes_11 := nvl(v_dias_mes_11,0) + v_mes_f;
         elsif to_char(v_data_fim,'mm') = 12 then v_dias_mes_12 := nvl(v_dias_mes_12,0) + v_mes_f;
         end if;
         if to_number(to_char(v_data_fim,'yyyy')) > to_number(to_char(v_data_ini,'yyyy')) then
            if ((13 - to_number(to_char(v_data_ini,'mm'))) + to_number(to_char(v_data_fim,'mm'))) > 1 then
                if to_number(to_number(to_char(v_data_ini,'mm')) + 1) > 12 then
                  v_mes_ini := 1;
               else
                  v_mes_ini := to_number(to_char(v_data_ini,'mm')) + 1;
               end if;
               v_mes_fim := to_number(to_char(v_data_fim,'mm'));
               loop
                  exit when v_mes_ini = v_mes_fim;
                  if v_mes_ini    = 01 then v_mes_01 := 1;
                  elsif v_mes_ini = 02 then v_mes_02 := 1;
                  elsif v_mes_ini = 03 then v_mes_03 := 1;
                  elsif v_mes_ini = 04 then v_mes_04 := 1;
                  elsif v_mes_ini = 05 then v_mes_05 := 1;
                  elsif v_mes_ini = 06 then v_mes_06 := 1;
                  elsif v_mes_ini = 07 then v_mes_07 := 1;
                  elsif v_mes_ini = 08 then v_mes_08 := 1;
                  elsif v_mes_ini = 09 then v_mes_09 := 1;
                  elsif v_mes_ini = 10 then v_mes_10 := 1;
                  elsif v_mes_ini = 11 then v_mes_11 := 1;
                  elsif v_mes_ini = 12 then v_mes_12 := 1;
                  end if;
                  v_mes_ini := v_mes_ini + 1;
               end loop;
            end if;
         else
            if to_number(to_char(v_data_fim,'mm')) - to_number(to_char(v_data_ini,'mm')) > 1 then
               v_mes_ini := to_number(to_char(v_data_ini,'mm')) + 1;
               v_mes_fim := to_number(to_char(v_data_fim,'mm'));
               loop
                  exit when v_mes_ini = v_mes_fim;
                  if v_mes_ini    = 01 then v_mes_01 := 1;
                  elsif v_mes_ini = 02 then v_mes_02 := 1;
                  elsif v_mes_ini = 03 then v_mes_03 := 1;
                  elsif v_mes_ini = 04 then v_mes_04 := 1;
                  elsif v_mes_ini = 05 then v_mes_05 := 1;
                  elsif v_mes_ini = 06 then v_mes_06 := 1;
                  elsif v_mes_ini = 07 then v_mes_07 := 1;
                  elsif v_mes_ini = 08 then v_mes_08 := 1;
                  elsif v_mes_ini = 09 then v_mes_09 := 1;
                  elsif v_mes_ini = 10 then v_mes_10 := 1;
                  elsif v_mes_ini = 11 then v_mes_11 := 1;
                  elsif v_mes_ini = 12 then v_mes_12 := 1;
                  end if;
                  v_mes_ini := v_mes_ini + 1;
               end loop;
            end if;
         end if;
      end if;
   end loop;
   close c_ocor_resto;
   v_cont := 1;
   loop
     exit when v_cont > 12;
     v_data_teste   := to_date('01'||to_char(v_cont,'00')||to_char(p_ano),'ddmmyyyy');
     v_dias_mes_i   := round(to_number(to_char(last_day(v_data_teste),'dd')) / 2);
     if v_cont = 1   then if v_dias_mes_01 > v_dias_mes_i then v_mes_01 := 1; end if; end if;
     if v_cont = 2   then if v_dias_mes_02 > v_dias_mes_i then v_mes_02 := 1; end if; end if;
     if v_cont = 3   then if v_dias_mes_03 > v_dias_mes_i then v_mes_03 := 1; end if; end if;
     if v_cont = 4   then if v_dias_mes_04 > v_dias_mes_i then v_mes_04 := 1; end if; end if;
     if v_cont = 5   then if v_dias_mes_05 > v_dias_mes_i then v_mes_05 := 1; end if; end if;
     if v_cont = 6   then if v_dias_mes_06 > v_dias_mes_i then v_mes_06 := 1; end if; end if;
     if v_cont = 7   then if v_dias_mes_07 > v_dias_mes_i then v_mes_07 := 1; end if; end if;
     if v_cont = 8   then if v_dias_mes_08 > v_dias_mes_i then v_mes_08 := 1; end if; end if;
     if v_cont = 9   then if v_dias_mes_09 > v_dias_mes_i then v_mes_09 := 1; end if; end if;
     if v_cont = 10  then if v_dias_mes_10 > v_dias_mes_i then v_mes_10 := 1; end if; end if;
     if v_cont = 11  then if v_dias_mes_11 > v_dias_mes_i then v_mes_11 := 1; end if; end if;
     if v_cont = 12  then if v_dias_mes_12 > v_dias_mes_i then v_mes_12 := 1; end if; end if;
     v_cont := v_cont + 1;
   end loop;
   v_emp.egt_numero_mes_13 := v_total_avos - (v_mes_01 + v_mes_02 + v_mes_03 + v_mes_04 +
                                              v_mes_05 + v_mes_06 + v_mes_07 + v_mes_08 +
                                              v_mes_09 + v_mes_10 + v_mes_11 + v_mes_12);
   v_total_avos        := 0;
   v_dias_mes_i        := 0;
   v_dias_mes_f        := 0;
   v_mes_01            := 0;
   v_mes_02            := 0;
   v_mes_03            := 0;
   v_mes_04            := 0;
   v_mes_05            := 0;
   v_mes_06            := 0;
   v_mes_07            := 0;
   v_mes_08            := 0;
   v_mes_09            := 0;
   v_mes_10            := 0;
   v_mes_11            := 0;
   v_mes_12            := 0;
   v_dias_mes_01       := 0;
   v_dias_mes_02       := 0;
   v_dias_mes_03       := 0;
   v_dias_mes_04       := 0;
   v_dias_mes_05       := 0;
   v_dias_mes_06       := 0;
   v_dias_mes_07       := 0;
   v_dias_mes_08       := 0;
   v_dias_mes_09       := 0;
   v_dias_mes_10       := 0;
   v_dias_mes_11       := 0;
   v_dias_mes_12       := 0;
end calcula_avos;
--------------------------------------------------------------------------
--              INICIO DA PROCEDURE CONFIGURA_EMPREGADO                 --
--------------------------------------------------------------------------
BEGIN
    ZERA_VARIAVEIS;
    OPEN C_emp;
    LOOP
        FETCH C_emp INTO R_emp;
        EXIT  WHEN C_emp%NOTFOUND;
          IF r_emp.emp_status != 2 THEN
             BUSCA_DEP_IR;
             BUSCA_DEP_SAL_FAM;
             BUSCA_DADOS_EMPREGADO;
             BUSCA_NUMERO_ANUENIOS;
             --if p_mes > 11 then
             calcula_avos;
             --end if;
             if v_emp_sfu_codigo = 1 and p_mes < 13 and
                (v_emp_tipo_remuneracao_funcao is null OR
                 v_emp_tipo_remuneracao_funcao != 'DI' )
             then
                UPDATE movimentacao
                SET    mov_parametro        = v_mov_parametro,
                       mov_tipo_parametro   = 'P'
                WHERE  mov_ano_referencia   = p_ano
                AND    mov_mes_referencia   = p_mes
                AND    mov_versao_pagamento = 1 -- versao normal
                AND    mov_emp_numero_matricula = r_emp.emp_numero_matricula
                AND    mov_rub_codigo       = 1005 -- Rubrica de Anuênio
                AND    mov_tip_rubrica      = 'N'
                AND    mov_sequencial       = 01;
                -- custo 01 - unique scan movimentacao

                IF SQL%NOTFOUND THEN
                   IF v_mov_parametro > 0 THEN
                      BEGIN
                         SELECT rub.rub_seq_pagamento
                         INTO   v_seq_pagamento
                         FROM   rubricas rub
                         WHERE  rub.rub_codigo = 1005; -- Rubrica de Anuênio
                      EXCEPTION
                         WHEN NO_DATA_FOUND THEN
                              v_seq_pagamento := 999;
                      END;
                      if p_mes = 13 then
                         v_mov_ind_13 := 'S';
                      else
                         v_mov_ind_13 := 'N';
                      end if;
                      INSERE_MOVIMENTACAO(p_ano, -- ano
                                          p_mes, -- mês
                                          1, -- versão
                                          r_emp.emp_numero_matricula, -- Matricula
                                          1005, -- Rubrica de Anuênio
                                          1, -- mov_seq
                                          NULL, -- Código da fórmula
                                          999, -- mov_parcela_
                                          999, -- mov_parcela_atual
                                          'P', -- mov_tipo_parametro
                                          v_mov_parametro, -- mov_parametro
                                          NULL, -- mov_valor
                                          'N', -- mov_tip_rubrica
                                          NULL, -- mov_mes_dif
                                          NULL, -- mov_ano_dif
                                          NULL, -- mov_pen_codigo
                                          'N', -- mov_ind_calculo
                                          NULL, -- mov_pem_ben_sigla
                                          v_seq_pagamento, -- mov_rub_seq_pgto
                                          NULL, -- mov_ind_arsaprev
                                          NULL, -- mov_fun_codigo
                                          NULL, -- mov_tipo_funcao
                                          NULL, -- mov_pkt_codigo_pedido
                                          NULL, -- mov_valor_integral
                                          'N', -- mov_ind_exclusivo
                                          30, -- mov_dias_proporcionalidade
                                          NULL, -- mov_data_calculo
                                          NULL, -- mov_ind_13,
                                          r_emp.emp_dep_codigo_pagto);
                   END IF;
                END IF;
             END IF;
          ELSIF r_emp.emp_status = 2 THEN
             BUSCA_DADOS_EMPREGADO;
          end if;
          UPDATE empregados_pagamentos
          SET    egt_dep_codigo                 = v_emp.egt_dep_codigo,
                 egt_uor_codigo                 = v_emp.egt_uor_codigo,
                 egt_valor_fg                   = v_emp.egt_valor_fg,
                 egt_valor_rg                   = v_emp.egt_valor_rg,
                 egt_dependentes_ir             = v_emp.egt_dependentes_ir,
                 egt_dependentes_sal_fam        = v_emp.egt_dependentes_sal_fam,
                 egt_numero_mes_13              = v_emp.egt_numero_mes_13,
                 egt_numero_anuenios            = v_emp.egt_numero_anuenios,
                 egt_carga_horaria_mes          = v_emp.egt_carga_horaria_mes,
                 egt_plano_arsaprev             = v_emp.egt_plano_arsaprev,
                 egt_emp_qlp_car_codigo         = v_emp.egt_emp_qlp_car_codigo,
                 egt_emp_qlp_car_codigo_nivel   = v_emp.egt_emp_qlp_car_codigo_nivel,
                 egt_emp_qlp_car_occ_codigo     = v_emp.egt_emp_qlp_car_occ_codigo,
                 egt_emp_nsa_codigo_nivel       = v_emp.egt_emp_nsa_codigo_nivel,
                 egt_emp_nsa_codigo_padrao      = v_emp.egt_emp_nsa_codigo_padrao,
                 egt_emp_nsa_in_nivel_escolarid = v_emp.egt_emp_nsa_in_nivel_escolarid,
                 egt_emp_qfu_fun_codigo         = v_emp.egt_emp_qfu_fun_codigo,
                 egt_hcc_cct_codigo             = v_emp.egt_hcc_cct_codigo,
                 egt_dep_codigo_fisico          = v_emp.egt_dep_codigo_fisico
          WHERE  egt_emp_numero_matricula = r_emp.emp_numero_matricula
          AND    egt_crp_ano_pagamento    = p_ano
          AND    egt_crp_mes_pagamento    = p_mes
          AND    egt_crp_sequencial       = p_versao;
          -- custo 01 - unique scan empregados_pagamentos
          IF SQL%NOTFOUND THEN
             INSERT INTO
                 empregados_pagamentos (egt_emp_numero_matricula,
                                        egt_crp_ano_pagamento,
                                        egt_crp_mes_pagamento,
                                        egt_crp_sequencial,
                                        egt_dep_codigo,
                                        egt_uor_codigo,
                                        egt_valor_fg,
                                        egt_valor_rg,
                                        egt_dependentes_ir,
                                        egt_dependentes_sal_fam,
                                        egt_numero_mes_13,
                                        egt_numero_anuenios,
                                        egt_carga_horaria_mes,
                                        egt_plano_arsaprev,
                                        egt_emp_qlp_car_codigo,
                                        egt_emp_qlp_car_codigo_nivel,
                                        egt_emp_qlp_car_occ_codigo,
                                        egt_emp_nsa_codigo_nivel,
                                        egt_emp_nsa_codigo_padrao,
                                        egt_emp_nsa_in_nivel_escolarid,
                                        egt_emp_qfu_fun_codigo,
                                        egt_hcc_cct_codigo,
                                        egt_dep_codigo_fisico)
                VALUES                (r_emp.emp_numero_matricula,
                                        p_ano,
                                        p_mes,
                                        p_versao,
                                        v_emp.egt_dep_codigo,
                                        v_emp.egt_uor_codigo,
                                        v_emp.egt_valor_fg,
                                        v_emp.egt_valor_rg,
                                        v_emp.egt_dependentes_ir,
                                        v_emp.egt_dependentes_sal_fam,
                                        v_emp.egt_numero_mes_13,
                                        v_emp.egt_numero_anuenios,
                                        v_emp.egt_carga_horaria_mes,
                                        v_emp.egt_plano_arsaprev,
                                        v_emp.egt_emp_qlp_car_codigo,
                                        v_emp.egt_emp_qlp_car_codigo_nivel,
                                        v_emp.egt_emp_qlp_car_occ_codigo,
                                        v_emp.egt_emp_nsa_codigo_nivel,
                                        v_emp.egt_emp_nsa_codigo_padrao,
                                        v_emp.egt_emp_nsa_in_nivel_escolarid,
                                        v_emp.egt_emp_qfu_fun_codigo,
                                        v_emp.egt_hcc_cct_codigo,
                                        v_emp.egt_dep_codigo_fisico);
          END IF;
          ZERA_VARIAVEIS;
    END LOOP;
    CLOSE C_emp;
END;
