/* Formatted on 2004/12/27 17:23 (Formatter Plus v4.5.2) */
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
      SELECT DISTINCT a.rap_cre_cod, a.rap_pgose
                 FROM ifrbde.tab_rec_aprovado a
                WHERE a.rap_cre_cod = p_seq_carencia;

   
--
   CURSOR cur3 (p_seq_contrato NUMBER, p_ano_aprovacao VARCHAR2)
   IS
      SELECT   TO_CHAR (c.ccp_data_venc, 'mm') AS mes, SUM (c.ccp_valor)
                     AS total
          FROM ifrbde.tab_contrato a,
               ifrbde.cad_resumo_valores b,
               ifrbde.tab_cont_crono_pagamento c
         WHERE a.num_seq_contrato = b.num_seq_contrato_res
           AND b.num_seq_resumo = c.num_seq_contrato_cron
           AND a.num_seq_contrato = p_seq_contrato
           AND TO_CHAR (c.ccp_data_venc, 'yyyy') = p_ano_aprovacao
      GROUP BY TO_CHAR (c.ccp_data_venc, 'mm');

   
--
   CURSOR cur4 (p_seq_contrato1 NUMBER, p_ano_aprovacao1 VARCHAR2)
   IS
      SELECT   TO_CHAR (c.dat_vencimento_pag, 'mm') AS mes,
               SUM (  c.val_pagamento_rp
                    - c.val_glosa_rp) AS total
          FROM ifrbde.tab_contrato a,
               ifrbde.cad_resumo_valores b,
               ifrbde.cad_resumo_pagamento c
         WHERE a.num_seq_contrato = b.num_seq_contrato_res
           AND b.num_seq_resumo = c.num_seq_pag_contrato_rp
           AND a.num_seq_contrato = p_seq_contrato1
           AND TO_CHAR (c.dat_vencimento_pag, 'yyyy') = p_ano_aprovacao1
      GROUP BY TO_CHAR (c.dat_vencimento_pag, 'mm');

   
--
   CURSOR cur5 (p_seq_contrato2 NUMBER, p_ano_aprovacao2 VARCHAR2)
   IS
      SELECT   TO_CHAR (c.dat_vencimento_rc, 'mm') AS mes,
               SUM (c.val_resumo_crno) AS total
          FROM ifrbde.tab_contrato a,
               ifrbde.cad_resumo_valores b,
               ifrbde.cad_resumo_cronograma c
         WHERE a.num_seq_contrato = b.num_seq_contrato_res
           AND b.num_seq_resumo = c.num_seq_contrato_rc
           AND a.num_seq_contrato = p_seq_contrato2
           AND TO_CHAR (c.dat_vencimento_rc, 'yyyy') = p_ano_aprovacao2
      GROUP BY TO_CHAR (c.dat_vencimento_rc, 'mm');

   
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
   
--
   v_ano_realizacao   VARCHAR2 (4);
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
      IF v_sucesso = 0
      THEN
         FOR regy IN cur2 (regx.cnt_cre_cod)
         LOOP
            BEGIN
               INSERT INTO ifrbde.aux_cronograma_medicao
                           (seq_carencia, seq_contrato,
                            ano_cronograma, tip_cronograma)
                    VALUES (regx.cnt_cre_cod, regx.num_seq_contrato,
                            regy.rap_pgose, p_tip_cronograma);
            EXCEPTION
               WHEN OTHERS
               THEN
                  v_erro :=
                           'Erro ao criar a linha de carga do relatório de cronograma de medição, carencia : '
                        || regx.cnt_cre_cod
                        || ' ano : '
                        || regy.rap_pgose
                        || ' tipo de cronograma ([C]ronograma [F]inanceiro,[P]agamento,e[R]ealização) : '
                        || p_tip_cronograma;
                  v_sucesso := 1;
            END;

            
--            
-- inicio o calculo para o tipo de cronograma CF
--
            IF  v_sucesso = 0 AND p_tip_cronograma = 'CF'
            THEN
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

               FOR regz IN cur3 (regx.num_seq_contrato, regy.rap_pgose)
               LOOP
                  IF regz.mes = '01'
                  THEN
                     v_mes_01 := regz.total;
                     v_total_crono :=   v_total_crono
                                      + v_mes_01;
                  END IF;

                  IF regz.mes = '02'
                  THEN
                     v_mes_02 := regz.total;
                     v_total_crono :=   v_total_crono
                                      + v_mes_02;
                  END IF;

                  IF regz.mes = '03'
                  THEN
                     v_mes_03 := regz.total;
                     v_total_crono :=   v_total_crono
                                      + v_mes_03;
                  END IF;

                  IF regz.mes = '04'
                  THEN
                     v_mes_04 := regz.total;
                     v_total_crono :=   v_total_crono
                                      + v_mes_04;
                  END IF;

                  IF regz.mes = '05'
                  THEN
                     v_mes_05 := regz.total;
                     v_total_crono :=   v_total_crono
                                      + v_mes_05;
                  END IF;

                  IF regz.mes = '06'
                  THEN
                     v_mes_06 := regz.total;
                     v_total_crono :=   v_total_crono
                                      + v_mes_06;
                  END IF;

                  IF regz.mes = '07'
                  THEN
                     v_mes_07 := regz.total;
                     v_total_crono :=   v_total_crono
                                      + v_mes_07;
                  END IF;

                  IF regz.mes = '08'
                  THEN
                     v_mes_08 := regz.total;
                     v_total_crono :=   v_total_crono
                                      + v_mes_08;
                  END IF;

                  IF regz.mes = '09'
                  THEN
                     v_mes_09 := regz.total;
                     v_total_crono :=   v_total_crono
                                      + v_mes_09;
                  END IF;

                  IF regz.mes = '10'
                  THEN
                     v_mes_10 := regz.total;
                     v_total_crono :=   v_total_crono
                                      + v_mes_10;
                  END IF;

                  IF regz.mes = '11'
                  THEN
                     v_mes_11 := regz.total;
                     v_total_crono :=   v_total_crono
                                      + v_mes_11;
                  END IF;

                  IF regz.mes = '12'
                  THEN
                     v_mes_12 := regz.total;
                     v_total_crono :=   v_total_crono
                                      + v_mes_12;
                  END IF;
               END LOOP;
            END IF;

            
--
--            
-- inicio o calculo para o tipo de cronograma CP
--
            IF  v_sucesso = 0 AND p_tip_cronograma = 'CP'
            THEN
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

               FOR regz IN cur4 (regx.num_seq_contrato, regy.rap_pgose)
               LOOP
                  IF regz.mes = '01'
                  THEN
                     v_mes_01 := regz.total;
                     v_total_crono :=   v_total_crono
                                      + v_mes_01;
                  END IF;

                  IF regz.mes = '02'
                  THEN
                     v_mes_02 := regz.total;
                     v_total_crono :=   v_total_crono
                                      + v_mes_02;
                  END IF;

                  IF regz.mes = '03'
                  THEN
                     v_mes_03 := regz.total;
                     v_total_crono :=   v_total_crono
                                      + v_mes_03;
                  END IF;

                  IF regz.mes = '04'
                  THEN
                     v_mes_04 := regz.total;
                     v_total_crono :=   v_total_crono
                                      + v_mes_04;
                  END IF;

                  IF regz.mes = '05'
                  THEN
                     v_mes_05 := regz.total;
                     v_total_crono :=   v_total_crono
                                      + v_mes_05;
                  END IF;

                  IF regz.mes = '06'
                  THEN
                     v_mes_06 := regz.total;
                     v_total_crono :=   v_total_crono
                                      + v_mes_06;
                  END IF;

                  IF regz.mes = '07'
                  THEN
                     v_mes_07 := regz.total;
                     v_total_crono :=   v_total_crono
                                      + v_mes_07;
                  END IF;

                  IF regz.mes = '08'
                  THEN
                     v_mes_08 := regz.total;
                     v_total_crono :=   v_total_crono
                                      + v_mes_08;
                  END IF;

                  IF regz.mes = '09'
                  THEN
                     v_mes_09 := regz.total;
                     v_total_crono :=   v_total_crono
                                      + v_mes_09;
                  END IF;

                  IF regz.mes = '10'
                  THEN
                     v_mes_10 := regz.total;
                     v_total_crono :=   v_total_crono
                                      + v_mes_10;
                  END IF;

                  IF regz.mes = '11'
                  THEN
                     v_mes_11 := regz.total;
                     v_total_crono :=   v_total_crono
                                      + v_mes_11;
                  END IF;

                  IF regz.mes = '12'
                  THEN
                     v_mes_12 := regz.total;
                     v_total_crono :=   v_total_crono
                                      + v_mes_12;
                  END IF;
               END LOOP;
            END IF;

            
--
--            
-- inicio o calculo para o tipo de cronograma CR
--
            IF  v_sucesso = 0 AND p_tip_cronograma = 'CR'
            THEN
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

               FOR regz IN cur5 (regx.num_seq_contrato, regy.rap_pgose)
               LOOP
                  IF regz.mes = '01'
                  THEN
                     v_mes_01 := regz.total;
                     v_total_crono :=   v_total_crono
                                      + v_mes_01;
                  END IF;

                  IF regz.mes = '02'
                  THEN
                     v_mes_02 := regz.total;
                     v_total_crono :=   v_total_crono
                                      + v_mes_02;
                  END IF;

                  IF regz.mes = '03'
                  THEN
                     v_mes_03 := regz.total;
                     v_total_crono :=   v_total_crono
                                      + v_mes_03;
                  END IF;

                  IF regz.mes = '04'
                  THEN
                     v_mes_04 := regz.total;
                     v_total_crono :=   v_total_crono
                                      + v_mes_04;
                  END IF;

                  IF regz.mes = '05'
                  THEN
                     v_mes_05 := regz.total;
                     v_total_crono :=   v_total_crono
                                      + v_mes_05;
                  END IF;

                  IF regz.mes = '06'
                  THEN
                     v_mes_06 := regz.total;
                     v_total_crono :=   v_total_crono
                                      + v_mes_06;
                  END IF;

                  IF regz.mes = '07'
                  THEN
                     v_mes_07 := regz.total;
                     v_total_crono :=   v_total_crono
                                      + v_mes_07;
                  END IF;

                  IF regz.mes = '08'
                  THEN
                     v_mes_08 := regz.total;
                     v_total_crono :=   v_total_crono
                                      + v_mes_08;
                  END IF;

                  IF regz.mes = '09'
                  THEN
                     v_mes_09 := regz.total;
                     v_total_crono :=   v_total_crono
                                      + v_mes_09;
                  END IF;

                  IF regz.mes = '10'
                  THEN
                     v_mes_10 := regz.total;
                     v_total_crono :=   v_total_crono
                                      + v_mes_10;
                  END IF;

                  IF regz.mes = '11'
                  THEN
                     v_mes_11 := regz.total;
                     v_total_crono :=   v_total_crono
                                      + v_mes_11;
                  END IF;

                  IF regz.mes = '12'
                  THEN
                     v_mes_12 := regz.total;
                     v_total_crono :=   v_total_crono
                                      + v_mes_12;
                  END IF;
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
                         val_total_ano = v_total_crono
                   WHERE seq_carencia = regx.cnt_cre_cod
                     AND seq_contrato = regx.num_seq_contrato
                     AND ano_cronograma = regy.rap_pgose
                     AND tip_cronograma = p_tip_cronograma;
               EXCEPTION
                  WHEN OTHERS
                  THEN
                     v_erro :=
                              'Erro ao Atualizar a linha de carga do relatório de cronograma de medição, carencia : '
                           || regx.cnt_cre_cod
                           || ' ano : '
                           || regy.rap_pgose
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
GRANT EXECUTE ON ifrbde.prc_rel_cronograma_medicao TO bde_geral
/

