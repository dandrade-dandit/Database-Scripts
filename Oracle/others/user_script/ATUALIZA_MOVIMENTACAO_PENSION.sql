CREATE OR REPLACE TRIGGER atualiza_movimentacao_pension
AFTER UPDATE
  OF pen_data_fim_desc
ON pensionistas
REFERENCING NEW AS NEW OLD AS OLD
FOR EACH ROW
DECLARE
   v_mes_ocorrencia             NUMBER(2);
   v_ano_ocorrencia             NUMBER(4);
   v_mes_movimentacao           NUMBER(2);
   v_ano_movimentacao           NUMBER(4);
   v_numero_meses_oem           NUMBER(2);
   v_ref                        DATE;
   v_mes_mov                    DATE;
   x                            NUMBER(2);
   v_dep                        NUMBER(4);
   v_dias_proporcionais_termino NUMBER(2);
   v_parametro                  NUMBER(11,3);
   v_dia_termino                NUMBER(2);
   v_dia_inicio                 NUMBER(2);
   v_evento                     NUMBER(1);
   v_ind_abertura               CHAR(1);
   v_movimentacao_aberta        CHAR(1);
   v_rubrica                    rubricas.rub_codigo%TYPE;
   v_ano_movimentacao_anterior  NUMBER(4);
   v_mes_movimentacao_anterior  NUMBER(2);
   v_ref_anterior               DATE;
   v_parcela                    movimentacao.mov_parcela%TYPE;
   v_parcela_atual              movimentacao.mov_parcela_atual%TYPE;
   CURSOR c_mov IS
   SELECT mov_rub_codigo,
          mov_sequencial,
          mov_for_codigo,
          mov_parcela,
          mov_parcela_atual,
          mov_tipo_parametro,
          mov_parametro,
          mov_valor,
          mov_tip_rubrica,
          mov_mes_ref_diferenca,
          mov_ano_ref_diferenca,
          mov_pen_codigo,
          mov_ind_calculo,
          mov_pem_ben_sigla,
          mov_rub_seq_pagamento,
          mov_ind_arsaprev,
          mov_fun_codigo,
          mov_tipo_funcao,
          mov_pkt_codigo_pedido,
          mov_valor_integral,
          rub_indic_proporcional
    FROM  movimentacao,
          rubricas
    WHERE mov_rub_codigo           = v_rubrica
    AND   mov_ind_abertura         = 'N'
    AND   mov_mes_referencia       = v_mes_movimentacao
    AND   mov_ano_referencia       = v_ano_movimentacao
    AND   mov_versao_pagamento     = 1
    AND   mov_emp_numero_matricula = :new.pen_emp_numero_matricula
    AND   mov_pen_codigo           = :new.pen_codigo
    AND   (mov_parcela_atual < mov_parcela OR mov_parcela = 999);

BEGIN
IF :old.pen_data_fim_desc IS NULL THEN
   BEGIN
      SELECT emp_dep_codigo_pagto
      INTO   v_dep
      FROM   empregados
      WHERE  emp_numero_matricula = :new.pen_emp_numero_matricula;
   EXCEPTION
      WHEN NO_DATA_FOUND THEN
           NULL;
   END;
   v_mes_ocorrencia := TO_NUMBER(TO_CHAR(:new.pen_data_inicio_desc,'MM'));
   v_ano_ocorrencia := TO_NUMBER(TO_CHAR(:new.pen_data_inicio_desc,'YYYY'));
   v_ref := verifica_referencia(v_mes_ocorrencia,
                                v_ano_ocorrencia,
                                v_dep);
   v_mes_movimentacao := TO_NUMBER(TO_CHAR(v_ref,'MM'));
   v_ano_movimentacao := TO_NUMBER(TO_CHAR(v_ref,'YYYY'));
   IF :new.pen_tipo_pensao = 'A' THEN
      v_rubrica := 5500;
   ELSE
      v_rubrica := 5515;
   END IF;
   -- Pensão é sempre paga proporcional
   v_dias_proporcionais_termino := 30;
   -- Verifica se existe evento de abertura para a referência atual
   BEGIN
      SELECT 'S'
      INTO   v_movimentacao_aberta
      FROM   cronogramas_pagamentos
      WHERE  crp_ano_pagamento = v_ano_movimentacao
      AND    crp_mes_pagamento = v_mes_movimentacao
      AND    crp_sequencial    = 1 --versao do pagamento
      AND    crp_dep_codigo    = v_dep
      AND    crp_epg_codigo    = 2; --evento de abertura da movimentacao
   EXCEPTION
      WHEN NO_DATA_FOUND THEN
           v_movimentacao_aberta := 'N';
   END;
  -- Término da pensão < que a movimentacao
  IF TO_DATE(TO_CHAR(:new.pen_data_fim_desc,'MM/YYYY'),'MM/YYYY') <
     TO_DATE(TO_CHAR(v_mes_movimentacao,'09')||'/'||TO_CHAR(v_ano_movimentacao,'9999'),'MM/YYYY') THEN
     IF v_movimentacao_aberta = 'S' THEN
        -- Deletar a rubrica de pensão do empregado para a referencia atual
        DELETE movimentacao
        WHERE  mov_emp_numero_matricula = :new.pen_emp_numero_matricula
        AND    mov_pen_codigo           = :new.pen_codigo
        AND    mov_ano_referencia       = v_ano_movimentacao
        AND    mov_mes_referencia       = v_mes_movimentacao
        AND    mov_versao_pagamento     = 1
        AND    mov_rub_codigo           = v_rubrica
        AND    mov_tip_rubrica          = 'N';
     ELSE -- não existe o evento de abertura para a referencia atual
        v_ref_anterior := ADD_MONTHS(v_ref,-1);
        v_mes_movimentacao_anterior := TO_NUMBER(TO_CHAR(v_ref_anterior,'MM'));
        v_ano_movimentacao_anterior := TO_NUMBER(TO_CHAR(v_ref_anterior,'YYYY'));
        UPDATE movimentacao
        SET    mov_ind_abertura = 'S'
        WHERE  mov_emp_numero_matricula = :new.pen_emp_numero_matricula
        AND    mov_pen_codigo           = :new.pen_codigo
        AND    mov_ano_referencia       = v_ano_movimentacao_anterior
        AND    mov_mes_referencia       = v_mes_movimentacao_anterior
        AND    mov_versao_pagamento     = 1
        AND    mov_rub_codigo           = v_rubrica
        AND    mov_tip_rubrica          = 'N';
     END IF;
  -- Término da pensão = a movimentacao
  ELSIF TO_DATE(TO_CHAR(:new.pen_data_fim_desc)||'/'||TO_CHAR(:new.pen_data_fim_desc),'MM/YYYY') =
        TO_DATE(TO_CHAR(v_mes_movimentacao)||'/'||TO_CHAR(v_ano_movimentacao),'MM/YYYY') THEN
     IF v_movimentacao_aberta = 'S' THEN
        UPDATE movimentacao
        SET    mov_parcela                = 1,
               mov_parcela_atual          = 1
        WHERE  mov_emp_numero_matricula = :new.pen_emp_numero_matricula
        AND    mov_pen_codigo           = :new.pen_codigo
        AND    mov_ano_referencia       = v_ano_movimentacao
        AND    mov_mes_referencia       = v_mes_movimentacao
        AND    mov_versao_pagamento     = 1
        AND    mov_rub_codigo           = v_rubrica
        AND    mov_tip_rubrica          = 'N';
     ELSE -- não existe o evento de abertura para a referencia atual
        v_ref_anterior := ADD_MONTHS(v_ref,-1);
        v_mes_movimentacao_anterior := TO_NUMBER(TO_CHAR(v_ref_anterior,'MM'));
        v_ano_movimentacao_anterior := TO_NUMBER(TO_CHAR(v_ref_anterior,'YYYY'));
        UPDATE movimentacao
        SET    mov_ind_abertura = 'S'
        WHERE  mov_emp_numero_matricula = :new.pen_emp_numero_matricula
        AND    mov_pen_codigo           = :new.pen_codigo
        AND    mov_ano_referencia       = v_ano_movimentacao_anterior
        AND    mov_mes_referencia       = v_mes_movimentacao_anterior
        AND    mov_versao_pagamento     = 1
        AND    mov_rub_codigo           = v_rubrica
        AND    mov_tip_rubrica          = 'N';
     END IF;
  -- Término da pensão > a movimentacao
  ELSIF TO_DATE(TO_CHAR(:new.pen_data_fim_desc,'MM')||'/'||TO_CHAR(:new.pen_data_fim_desc,'YYYY'),'MM/YYYY') >
        TO_DATE(TO_CHAR(v_mes_movimentacao)||'/'||TO_CHAR(v_ano_movimentacao),'MM/YYYY') THEN
        UPDATE movimentacao
        SET    mov_ind_abertura         = 'S'
        WHERE  mov_emp_numero_matricula = :new.pen_emp_numero_matricula
        AND    mov_pen_codigo           = :new.pen_codigo
        AND    mov_ano_referencia       = v_ano_movimentacao
        AND    mov_mes_referencia       = v_mes_movimentacao
        AND    mov_versao_pagamento     = 1
        AND    mov_rub_codigo           = v_rubrica
        AND    mov_tip_rubrica          = 'N';
        v_numero_meses_oem := MONTHS_BETWEEN(TO_DATE('01/'||TO_CHAR(:new.pen_data_fim_desc,'MM/YYYY'),'DD/MM/YYYY'),
                              TO_DATE('01/'||TO_CHAR(v_ref,'MM/YYYY'),'DD/MM/YYYY'));
        v_mes_mov := v_ref;
        x := 1;
        WHILE x <= v_numero_meses_oem LOOP
              v_mes_mov := add_months(v_mes_mov,1);
              FOR R_mov IN C_mov LOOP
                  IF x <> v_numero_meses_oem THEN
                     v_ind_abertura := 'S';
                     v_parcela := 999;
                     v_parcela_atual := 999;
                  ELSE
                     v_ind_abertura := 'N';
                     v_parcela := 1;
                     v_parcela_atual := 1;
                  END IF;
                  INSERE_MOVIMENTACAO(TO_NUMBER(TO_CHAR(v_mes_mov,'YYYY')),
                                      TO_NUMBER(TO_CHAR(v_mes_mov,'MM')),
                                      1, -- Versão Pagto
                                      :new.pen_emp_numero_matricula,
                                      v_rubrica,
                                      R_mov.mov_sequencial,
                                      R_mov.mov_for_codigo,
                                      v_parcela,
                                      v_parcela_atual,
                                      R_mov.mov_tipo_parametro,
                                      R_mov.mov_parametro,
                                      R_mov.mov_valor,
                                      R_mov.mov_tip_rubrica,
                                      R_mov.mov_mes_ref_diferenca,
                                      R_mov.mov_ano_ref_diferenca,
                                      R_mov.mov_pen_codigo,
                                      R_mov.mov_ind_calculo,
                                      R_mov.mov_pem_ben_sigla,
                                      R_mov.mov_rub_seq_pagamento,
                                      R_mov.mov_ind_arsaprev,
                                      R_mov.mov_fun_codigo,
                                      R_mov.mov_tipo_funcao,
                                      NULL, -- Codigo do Pedido Vale/Ticket
                                      R_mov.mov_valor_integral,
                                      'N', -- Indicador de exclusivo
                                      v_dias_proporcionais_termino,
                                      null, -- data do credito
                                      null,  -- indicador 13
                                      v_dep); -- dependecia de pgto
                END LOOP;
                x := x + 1;
            END LOOP;
  END IF;
END IF;
END;
/
