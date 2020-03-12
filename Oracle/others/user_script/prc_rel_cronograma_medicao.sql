/* Formatted on 2005/10/19 15:12 (Formatter Plus v4.5.2) */
CREATE OR REPLACE PROCEDURE ifrbde.prc_rel_cronograma_medicao (
   p_num_seq_resumo   IN   NUMBER,
   p_tip_cronograma   IN   VARCHAR2
)
IS
   
--
   CURSOR cur1
   IS
      SELECT a.num_seq_contrato, a.cnt_cre_cod
        FROM ifrbde.tab_contrato a, ifrbde.cad_resumo_valores b
       WHERE b.num_seq_contrato_res = a.num_seq_contrato
         AND b.num_seq_resumo = p_num_seq_resumo;

   
--
   CURSOR cur2 (p_seq_carencia NUMBER)
   IS
      SELECT DISTINCT a.rap_cre_cod, a.rap_pgose, a.rap_rti_cod,
                      SUBSTR (b.rti_sigla, 1, 4) AS sigla_recurso
                 FROM ifrbde.tab_rec_aprovado a,
                      ifrbde.tab_tipo_recurso_item b
                WHERE a.rap_cre_cod = p_seq_carencia
                  AND b.rti_cod = a.rap_rti_cod;

   
--
   CURSOR recur3 (p_carencia_rec NUMBER)
   IS
      SELECT DISTINCT a.cnt_cre_cod, a.num_seq_contrato, c.ccp_rti_cod,
                      TO_CHAR (c.ccp_data_venc, 'yyyy') AS ano,
                      SUBSTR (d.rti_sigla, 1, 4) AS sigla_recurso
                 FROM ifrbde.tab_contrato a,
                      ifrbde.cad_resumo_valores b,
                      ifrbde.tab_cont_crono_pagamento c,
                      ifrbde.tab_tipo_recurso_item d
                WHERE a.num_seq_contrato = b.num_seq_contrato_res
                  AND b.num_seq_resumo = c.num_seq_contrato_cron
                  AND c.ccp_rti_cod = d.rti_cod
                  AND c.tip_cronograma IN ('DE', 'DA', 'RJ')
                  
--           and a.cnt_cre_cod = 21647
                  AND a.cnt_cre_cod = p_carencia_rec;

   
--
   CURSOR cur3 (
      p_seq_contrato    NUMBER,
      p_ano_aprovacao   VARCHAR2,
      p_cod_recurso     VARCHAR2
   )
   IS
      SELECT   TO_CHAR (c.ccp_data_venc, 'yyyy') AS ano,
               TO_CHAR (c.ccp_data_venc, 'mm') AS mes, SUM (c.ccp_valor)
                     AS total
          FROM ifrbde.tab_contrato a,
               ifrbde.cad_resumo_valores b,
               ifrbde.tab_cont_crono_pagamento c
         WHERE a.num_seq_contrato = b.num_seq_contrato_res
           AND b.num_seq_resumo = c.num_seq_contrato_cron
           AND c.tip_cronograma IN ('DE', 'DA', 'RJ')
           AND a.num_seq_contrato = p_seq_contrato
           AND c.ccp_pgose = p_ano_aprovacao
           AND c.ccp_rti_cod = p_cod_recurso
      GROUP BY TO_CHAR (c.ccp_data_venc, 'yyyy'),
               TO_CHAR (c.ccp_data_venc, 'mm');

   
--

   CURSOR cur4 (
      p_seq_contrato1    NUMBER,
      p_ano_aprovacao1   VARCHAR2,
      p_cod_recurso1     VARCHAR2
   )
   IS
      SELECT   TO_CHAR (c.dat_vencimento_pag, 'yyyy') AS ano,
               TO_CHAR (c.dat_vencimento_pag, 'mm') AS mes,
               SUM (  d.val_pagamento
                    - d.val_glosa) AS total
          FROM ifrbde.tab_contrato a,
               ifrbde.cad_resumo_valores b,
               ifrbde.cad_resumo_pagamento c,
               ifrbde.cad_pagamento_contrato d
         WHERE a.num_seq_contrato = b.num_seq_contrato_res
           AND b.num_seq_resumo = c.num_seq_pag_contrato_rp
           AND c.num_seq_resumo_pag = d.num_seq_contrato_pag
           AND a.num_seq_contrato = p_seq_contrato1
           AND d.num_ano_pgose = p_ano_aprovacao1
           AND d.cod_recurso = p_cod_recurso1
      GROUP BY TO_CHAR (c.dat_vencimento_pag, 'yyyy'),
               TO_CHAR (c.dat_vencimento_pag, 'mm');

   
--
   CURSOR cur5 (
      p_seq_contrato2    NUMBER,
      p_ano_aprovacao2   VARCHAR2,
      p_cod_recurso2     VARCHAR2
   )
   IS
      SELECT   TO_CHAR (c.dat_vencimento_rc, 'yyyy') AS ano,
               TO_CHAR (c.dat_vencimento_rc, 'mm') AS mes,
               SUM (
                  c.val_resumo_crno * d.val_percentual_saldo
               ) AS total
          FROM ifrbde.tab_contrato a,
               ifrbde.cad_resumo_valores b,
               ifrbde.cad_resumo_cronograma c,
               ifrbde.tab_rec_aprovado d
         WHERE a.num_seq_contrato = b.num_seq_contrato_res
           AND b.num_seq_resumo = c.num_seq_contrato_rc
           AND a.cnt_cre_cod = d.rap_cre_cod
           AND c.ano_realizacao = d.rap_pgose
           AND c.num_seq_resumo_pag IS NULL
           AND a.num_seq_contrato = p_seq_contrato2
           AND c.ano_realizacao = p_ano_aprovacao2
           AND d.rap_rti_cod = p_cod_recurso2
      GROUP BY TO_CHAR (c.dat_vencimento_rc, 'yyyy'),
               TO_CHAR (c.dat_vencimento_rc, 'mm');

   CURSOR cur6 (
      p_seq_contrato3    NUMBER,
      p_ano_aprovacao3   VARCHAR2,
      p_cod_recurso3     VARCHAR2
   )
   IS
      SELECT   TO_CHAR (c.dat_vencimento_rc, 'yyyy') AS ano,
               TO_CHAR (c.dat_vencimento_rc, 'mm') AS mes,
               SUM (  d.val_pagamento
                    - d.val_glosa) AS total
          FROM ifrbde.tab_contrato a,
               ifrbde.cad_resumo_valores b,
               ifrbde.cad_resumo_cronograma c,
               ifrbde.cad_pagamento_contrato d
         WHERE a.num_seq_contrato = b.num_seq_contrato_res
           AND b.num_seq_resumo = c.num_seq_contrato_rc
           AND c.num_seq_resumo_pag = d.num_seq_contrato_pag
           AND c.num_seq_resumo_pag IS NOT NULL
           AND a.num_seq_contrato = p_seq_contrato3
           AND c.ano_realizacao = p_ano_aprovacao3
           AND d.cod_recurso = p_cod_recurso3
      GROUP BY TO_CHAR (c.dat_vencimento_rc, 'yyyy'),
               TO_CHAR (c.dat_vencimento_rc, 'mm');

   
--
-- variaveis de trabalho ...........
--
   v_erro             VARCHAR2 (200);
   v_sucesso          NUMBER (1);
   
--
   v_total_crono      NUMBER (18, 2);
   v_mes_01           NUMBER (18, 2);
   v_mes_02           NUMBER (18, 2);
   v_mes_03           NUMBER (18, 2);
   v_mes_04           NUMBER (18, 2);
   v_mes_05           NUMBER (18, 2);
   v_mes_06           NUMBER (18, 2);
   v_mes_07           NUMBER (18, 2);
   v_mes_08           NUMBER (18, 2);
   v_mes_09           NUMBER (18, 2);
   v_mes_10           NUMBER (18, 2);
   v_mes_11           NUMBER (18, 2);
   v_mes_12           NUMBER (18, 2);
   v_mes_13           NUMBER (18, 2);
   
--
   v_ano_realizacao   VARCHAR2 (4);
   v_cod_recurso      VARCHAR2 (5);
--
BEGIN
   v_sucesso := 0;
   v_erro := '';

   FOR regx IN cur1
   LOOP
      
--
-- verifica se existe cria ou deleta e recria
--
      BEGIN
         DELETE FROM ifrbde.aux_cronograma_medicao
               WHERE seq_carencia = regx.cnt_cre_cod
                 AND seq_contrato = regx.num_seq_contrato
                 AND tip_cronograma = p_tip_cronograma;
      EXCEPTION
         WHEN OTHERS
         THEN
            v_erro :=
                     'Erro ao excluir as linhas de carga do relatório de cronograma de medição, carencia : '
                  || regx.cnt_cre_cod
                  || ' tipo de cronograma ([C]ronograma [F]inanceiro,[P]agamento,e[R]ealização) : '
                  || p_tip_cronograma;
            v_sucesso := 1;
      END;

      
--
--
--
      IF  v_sucesso = 0 AND p_tip_cronograma IN ('CF')
      THEN
         FOR regy IN recur3 (regx.cnt_cre_cod)
         LOOP
            v_ano_realizacao := regy.ano;
            v_cod_recurso := regy.ccp_rti_cod;
            v_total_crono := 0;
            v_mes_01 := 0;
            v_mes_02 := 0;
            v_mes_03 := 0;
            v_mes_04 := 0;
            v_mes_05 := 0;
            v_mes_06 := 0;
            v_mes_07 := 0;
            v_mes_08 := 0;
            v_mes_09 := 0;
            v_mes_10 := 0;
            v_mes_11 := 0;
            v_mes_12 := 0;
            v_mes_13 := 0;

            BEGIN
               INSERT INTO ifrbde.aux_cronograma_medicao
                           (seq_carencia, seq_contrato,
                            ano_cronograma, cod_recurso,
                            tip_cronograma)
                    VALUES (regx.cnt_cre_cod, regx.num_seq_contrato,
                            v_ano_realizacao, regy.sigla_recurso,
                            p_tip_cronograma);
            EXCEPTION
               WHEN OTHERS
               THEN
                  v_erro :=
                           'Erro ao criar a linha de carga do relatório de cronograma de medição, carencia : '
                        || regx.cnt_cre_cod
                        || ' ano : '
                        || v_ano_realizacao
                        || ' recurso : '
                        || v_cod_recurso
                        || ' tipo de cronograma ([C]ronograma [F]inanceiro) : '
                        || p_tip_cronograma;
                  v_sucesso := 1;
            END;

            
--            
-- inicio o calculo para o tipo de cronograma CF
--
            IF  v_sucesso = 0 AND p_tip_cronograma = 'CF'
            THEN
               FOR regz IN cur3 (
                              regx.num_seq_contrato,
                              v_ano_realizacao,
                              v_cod_recurso
                           )
               LOOP
                  IF v_ano_realizacao = regz.ano
                  THEN
                     IF regz.mes = '01'
                     THEN
                        v_mes_01 :=   regz.total
                                    + v_mes_01;
                        v_total_crono :=   v_total_crono
                                         + v_mes_01;
                     END IF;

                     IF regz.mes = '02'
                     THEN
                        v_mes_02 :=   regz.total
                                    + v_mes_02;
                        v_total_crono :=   v_total_crono
                                         + v_mes_02;
                     END IF;

                     IF regz.mes = '03'
                     THEN
                        v_mes_03 :=   regz.total
                                    + v_mes_03;
                        v_total_crono :=   v_total_crono
                                         + v_mes_03;
                     END IF;

                     IF regz.mes = '04'
                     THEN
                        v_mes_04 :=   regz.total
                                    + v_mes_04;
                        v_total_crono :=   v_total_crono
                                         + v_mes_04;
                     END IF;

                     IF regz.mes = '05'
                     THEN
                        v_mes_05 :=   regz.total
                                    + v_mes_05;
                        v_total_crono :=   v_total_crono
                                         + v_mes_05;
                     END IF;

                     IF regz.mes = '06'
                     THEN
                        v_mes_06 :=   regz.total
                                    + v_mes_06;
                        v_total_crono :=   v_total_crono
                                         + v_mes_06;
                     END IF;

                     IF regz.mes = '07'
                     THEN
                        v_mes_07 :=   regz.total
                                    + v_mes_07;
                        v_total_crono :=   v_total_crono
                                         + v_mes_07;
                     END IF;

                     IF regz.mes = '08'
                     THEN
                        v_mes_08 :=   regz.total
                                    + v_mes_08;
                        v_total_crono :=   v_total_crono
                                         + v_mes_08;
                     END IF;

                     IF regz.mes = '09'
                     THEN
                        v_mes_09 :=   regz.total
                                    + v_mes_09;
                        v_total_crono :=   v_total_crono
                                         + v_mes_09;
                     END IF;

                     IF regz.mes = '10'
                     THEN
                        v_mes_10 :=   regz.total
                                    + v_mes_10;
                        v_total_crono :=   v_total_crono
                                         + v_mes_10;
                     END IF;

                     IF regz.mes = '11'
                     THEN
                        v_mes_11 :=   regz.total
                                    + v_mes_11;
                        v_total_crono :=   v_total_crono
                                         + v_mes_11;
                     END IF;

                     IF regz.mes = '12'
                     THEN
                        v_mes_12 :=   regz.total
                                    + v_mes_12;
                        v_total_crono :=   v_total_crono
                                         + v_mes_12;
                     END IF;
                  
--                     
                  ELSE
                     v_mes_13 :=   v_mes_13
                                 + regz.total;
                     v_total_crono :=   v_total_crono
                                      + v_mes_13;
                  END IF;
               
--                  
               END LOOP;
            END IF;

            
--
            IF v_sucesso = 0
            THEN
               BEGIN
                  UPDATE ifrbde.aux_cronograma_medicao
                     SET val_mes_01 = v_mes_01,
                         val_mes_02 = v_mes_02,
                         val_mes_03 = v_mes_03,
                         val_mes_04 = v_mes_04,
                         val_mes_05 = v_mes_05,
                         val_mes_06 = v_mes_06,
                         val_mes_07 = v_mes_07,
                         val_mes_08 = v_mes_08,
                         val_mes_09 = v_mes_09,
                         val_mes_10 = v_mes_10,
                         val_mes_11 = v_mes_11,
                         val_mes_12 = v_mes_12,
                         val_mes_13 = v_mes_13,
                         val_total_ano = v_total_crono
                   WHERE seq_carencia = regx.cnt_cre_cod
                     AND seq_contrato = regx.num_seq_contrato
                     AND ano_cronograma = v_ano_realizacao
                     AND cod_recurso = regy.sigla_recurso
                     AND tip_cronograma = p_tip_cronograma;
               EXCEPTION
                  WHEN OTHERS
                  THEN
                     v_erro :=
                              'Erro ao Atualizar a linha de carga do relatório de cronograma de medição, carencia : '
                           || regx.cnt_cre_cod
                           || ' ano : '
                           || v_ano_realizacao
                           || ' recurso : '
                           || v_cod_recurso
                           || ' tipo de cronograma ([C]ronograma [F]inanceiro : '
                           || p_tip_cronograma;
                     v_sucesso := 1;
               END;
            END IF;
         END LOOP;
      END IF;

      
--
--
      IF  v_sucesso = 0 AND p_tip_cronograma IN ('CP', 'CR')
      THEN
         FOR regy IN cur2 (regx.cnt_cre_cod)
         LOOP
            v_ano_realizacao := regy.rap_pgose;
            v_cod_recurso := regy.rap_rti_cod;
            v_total_crono := 0;
            v_mes_01 := 0;
            v_mes_02 := 0;
            v_mes_03 := 0;
            v_mes_04 := 0;
            v_mes_05 := 0;
            v_mes_06 := 0;
            v_mes_07 := 0;
            v_mes_08 := 0;
            v_mes_09 := 0;
            v_mes_10 := 0;
            v_mes_11 := 0;
            v_mes_12 := 0;
            v_mes_13 := 0;

            BEGIN
               INSERT INTO ifrbde.aux_cronograma_medicao
                           (seq_carencia, seq_contrato,
                            ano_cronograma, cod_recurso,
                            tip_cronograma)
                    VALUES (regx.cnt_cre_cod, regx.num_seq_contrato,
                            v_ano_realizacao, regy.sigla_recurso,
                            p_tip_cronograma);
            EXCEPTION
               WHEN OTHERS
               THEN
                  v_erro :=
                           'Erro ao criar a linha de carga do relatório de cronograma de medição, carencia : '
                        || regx.cnt_cre_cod
                        || ' ano : '
                        || v_ano_realizacao
                        || ' recurso : '
                        || v_cod_recurso
                        || ' tipo de cronograma ([C]ronograma [F]inanceiro,[P]agamento,e[R]ealização) : '
                        || p_tip_cronograma;
                  v_sucesso := 1;
            END;

            
--
--            
-- inicio o calculo para o tipo de cronograma CP
--
            IF  v_sucesso = 0 AND p_tip_cronograma = 'CP'
            THEN
               FOR regz IN cur4 (
                              regx.num_seq_contrato,
                              v_ano_realizacao,
                              v_cod_recurso
                           )
               LOOP
                  IF v_ano_realizacao = regz.ano
                  THEN
                     IF regz.mes = '01'
                     THEN
                        v_mes_01 :=   regz.total
                                    + v_mes_01;
                        v_total_crono :=   v_total_crono
                                         + v_mes_01;
                     END IF;

                     IF regz.mes = '02'
                     THEN
                        v_mes_02 :=   regz.total
                                    + v_mes_02;
                        v_total_crono :=   v_total_crono
                                         + v_mes_02;
                     END IF;

                     IF regz.mes = '03'
                     THEN
                        v_mes_03 :=   regz.total
                                    + v_mes_03;
                        v_total_crono :=   v_total_crono
                                         + v_mes_03;
                     END IF;

                     IF regz.mes = '04'
                     THEN
                        v_mes_04 :=   regz.total
                                    + v_mes_04;
                        v_total_crono :=   v_total_crono
                                         + v_mes_04;
                     END IF;

                     IF regz.mes = '05'
                     THEN
                        v_mes_05 :=   regz.total
                                    + v_mes_05;
                        v_total_crono :=   v_total_crono
                                         + v_mes_05;
                     END IF;

                     IF regz.mes = '06'
                     THEN
                        v_mes_06 :=   regz.total
                                    + v_mes_06;
                        v_total_crono :=   v_total_crono
                                         + v_mes_06;
                     END IF;

                     IF regz.mes = '07'
                     THEN
                        v_mes_07 :=   regz.total
                                    + v_mes_07;
                        v_total_crono :=   v_total_crono
                                         + v_mes_07;
                     END IF;

                     IF regz.mes = '08'
                     THEN
                        v_mes_08 :=   regz.total
                                    + v_mes_08;
                        v_total_crono :=   v_total_crono
                                         + v_mes_08;
                     END IF;

                     IF regz.mes = '09'
                     THEN
                        v_mes_09 :=   regz.total
                                    + v_mes_09;
                        v_total_crono :=   v_total_crono
                                         + v_mes_09;
                     END IF;

                     IF regz.mes = '10'
                     THEN
                        v_mes_10 :=   regz.total
                                    + v_mes_10;
                        v_total_crono :=   v_total_crono
                                         + v_mes_10;
                     END IF;

                     IF regz.mes = '11'
                     THEN
                        v_mes_11 :=   regz.total
                                    + v_mes_11;
                        v_total_crono :=   v_total_crono
                                         + v_mes_11;
                     END IF;

                     IF regz.mes = '12'
                     THEN
                        v_mes_12 :=   regz.total
                                    + v_mes_12;
                        v_total_crono :=   v_total_crono
                                         + v_mes_12;
                     END IF;
                  
--                     
                  ELSE
                     v_mes_13 :=   v_mes_13
                                 + regz.total;
                     v_total_crono :=   v_total_crono
                                      + v_mes_13;
                  END IF;
               
--                  

               END LOOP;
            END IF;

            
--
--            
-- inicio o calculo para o tipo de cronograma CR
--
            IF  v_sucesso = 0 AND p_tip_cronograma = 'CR'
            THEN
               FOR regz IN cur5 (
                              regx.num_seq_contrato,
                              v_ano_realizacao,
                              v_cod_recurso
                           )
               LOOP
                  IF v_ano_realizacao = regz.ano
                  THEN
                     IF regz.mes = '01'
                     THEN
                        v_mes_01 :=   regz.total
                                    + v_mes_01;
                        v_total_crono :=   v_total_crono
                                         + v_mes_01;
                     END IF;

                     IF regz.mes = '02'
                     THEN
                        v_mes_02 :=   regz.total
                                    + v_mes_02;
                        v_total_crono :=   v_total_crono
                                         + v_mes_02;
                     END IF;

                     IF regz.mes = '03'
                     THEN
                        v_mes_03 :=   regz.total
                                    + v_mes_03;
                        v_total_crono :=   v_total_crono
                                         + v_mes_03;
                     END IF;

                     IF regz.mes = '04'
                     THEN
                        v_mes_04 :=   regz.total
                                    + v_mes_04;
                        v_total_crono :=   v_total_crono
                                         + v_mes_04;
                     END IF;

                     IF regz.mes = '05'
                     THEN
                        v_mes_05 :=   regz.total
                                    + v_mes_05;
                        v_total_crono :=   v_total_crono
                                         + v_mes_05;
                     END IF;

                     IF regz.mes = '06'
                     THEN
                        v_mes_06 :=   regz.total
                                    + v_mes_06;
                        v_total_crono :=   v_total_crono
                                         + v_mes_06;
                     END IF;

                     IF regz.mes = '07'
                     THEN
                        v_mes_07 :=   regz.total
                                    + v_mes_07;
                        v_total_crono :=   v_total_crono
                                         + v_mes_07;
                     END IF;

                     IF regz.mes = '08'
                     THEN
                        v_mes_08 :=   regz.total
                                    + v_mes_08;
                        v_total_crono :=   v_total_crono
                                         + v_mes_08;
                     END IF;

                     IF regz.mes = '09'
                     THEN
                        v_mes_09 :=   regz.total
                                    + v_mes_09;
                        v_total_crono :=   v_total_crono
                                         + v_mes_09;
                     END IF;

                     IF regz.mes = '10'
                     THEN
                        v_mes_10 :=   regz.total
                                    + v_mes_10;
                        v_total_crono :=   v_total_crono
                                         + v_mes_10;
                     END IF;

                     IF regz.mes = '11'
                     THEN
                        v_mes_11 :=   regz.total
                                    + v_mes_11;
                        v_total_crono :=   v_total_crono
                                         + v_mes_11;
                     END IF;

                     IF regz.mes = '12'
                     THEN
                        v_mes_12 :=   regz.total
                                    + v_mes_12;
                        v_total_crono :=   v_total_crono
                                         + v_mes_12;
                     END IF;
                  
--                     
                  ELSE
                     v_mes_13 :=   v_mes_13
                                 + regz.total;
                     v_total_crono :=   v_total_crono
                                      + v_mes_13;
                  END IF;
               
--                  
               END LOOP;

               
--
               FOR regz IN cur6 (
                              regx.num_seq_contrato,
                              v_ano_realizacao,
                              v_cod_recurso
                           )
               LOOP
                  IF v_ano_realizacao = regz.ano
                  THEN
                     IF regz.mes = '01'
                     THEN
                        v_mes_01 :=   v_mes_01
                                    + regz.total;
                        v_total_crono :=   v_total_crono
                                         + v_mes_01;
                     END IF;

                     IF regz.mes = '02'
                     THEN
                        v_mes_02 :=   v_mes_02
                                    + regz.total;
                        v_total_crono :=   v_total_crono
                                         + v_mes_02;
                     END IF;

                     IF regz.mes = '03'
                     THEN
                        v_mes_03 :=   v_mes_03
                                    + regz.total;
                        v_total_crono :=   v_total_crono
                                         + v_mes_03;
                     END IF;

                     IF regz.mes = '04'
                     THEN
                        v_mes_04 :=   v_mes_04
                                    + regz.total;
                        v_total_crono :=   v_total_crono
                                         + v_mes_04;
                     END IF;

                     IF regz.mes = '05'
                     THEN
                        v_mes_05 :=   v_mes_05
                                    + regz.total;
                        v_total_crono :=   v_total_crono
                                         + v_mes_05;
                     END IF;

                     IF regz.mes = '06'
                     THEN
                        v_mes_06 :=   v_mes_06
                                    + regz.total;
                        v_total_crono :=   v_total_crono
                                         + v_mes_06;
                     END IF;

                     IF regz.mes = '07'
                     THEN
                        v_mes_07 :=   v_mes_07
                                    + regz.total;
                        v_total_crono :=   v_total_crono
                                         + v_mes_07;
                     END IF;

                     IF regz.mes = '08'
                     THEN
                        v_mes_08 :=   v_mes_08
                                    + regz.total;
                        v_total_crono :=   v_total_crono
                                         + v_mes_08;
                     END IF;

                     IF regz.mes = '09'
                     THEN
                        v_mes_09 :=   v_mes_09
                                    + regz.total;
                        v_total_crono :=   v_total_crono
                                         + v_mes_09;
                     END IF;

                     IF regz.mes = '10'
                     THEN
                        v_mes_10 :=   v_mes_10
                                    + regz.total;
                        v_total_crono :=   v_total_crono
                                         + v_mes_10;
                     END IF;

                     IF regz.mes = '11'
                     THEN
                        v_mes_11 :=   v_mes_11
                                    + regz.total;
                        v_total_crono :=   v_total_crono
                                         + v_mes_11;
                     END IF;

                     IF regz.mes = '12'
                     THEN
                        v_mes_12 :=   v_mes_12
                                    + regz.total;
                        v_total_crono :=   v_total_crono
                                         + v_mes_12;
                     END IF;
                  
--                     
                  ELSE
                     v_mes_13 :=   v_mes_13
                                 + regz.total;
                     v_total_crono :=   v_total_crono
                                      + v_mes_13;
                  END IF;
               
--                  
               END LOOP;
            END IF;

            
--
            IF v_sucesso = 0
            THEN
               BEGIN
                  UPDATE ifrbde.aux_cronograma_medicao
                     SET val_mes_01 = v_mes_01,
                         val_mes_02 = v_mes_02,
                         val_mes_03 = v_mes_03,
                         val_mes_04 = v_mes_04,
                         val_mes_05 = v_mes_05,
                         val_mes_06 = v_mes_06,
                         val_mes_07 = v_mes_07,
                         val_mes_08 = v_mes_08,
                         val_mes_09 = v_mes_09,
                         val_mes_10 = v_mes_10,
                         val_mes_11 = v_mes_11,
                         val_mes_12 = v_mes_12,
                         val_mes_13 = v_mes_13,
                         val_total_ano = v_total_crono
                   WHERE seq_carencia = regx.cnt_cre_cod
                     AND seq_contrato = regx.num_seq_contrato
                     AND ano_cronograma = v_ano_realizacao
                     AND cod_recurso = regy.sigla_recurso
                     AND tip_cronograma = p_tip_cronograma;
               EXCEPTION
                  WHEN OTHERS
                  THEN
                     v_erro :=
                              'Erro ao Atualizar a linha de carga do relatório de cronograma de medição, carencia : '
                           || regx.cnt_cre_cod
                           || ' ano : '
                           || v_ano_realizacao
                           || ' recurso : '
                           || v_cod_recurso
                           || ' tipo de cronograma ([C]ronograma [F]inanceiro,[P]agamento,e[R]ealização) : '
                           || p_tip_cronograma;
                     v_sucesso := 1;
               END;
            END IF;
         END LOOP;
      END IF;
   
--   
   END LOOP;

   
--   
   IF v_sucesso <> 0
   THEN
      raise_application_error (-20100, v_erro);
   END IF;
END;
/

-- Grants for Procedure
--GRANT EXECUTE ON ifrbde.prc_rel_cronograma_medicao TO bde_geral
--/

