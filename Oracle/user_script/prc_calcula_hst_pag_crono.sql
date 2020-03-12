/* Formatted on 2005/02/16 10:14 (Formatter Plus v4.5.2) */

CREATE OR REPLACE PROCEDURE ifrbde.prc_calcula_hst_pag_crono (
   v_num_seq_contrato   IN   NUMBER
)
IS
   
--
-- OBJETIVO: recalcular os valores dos saldo do cronograma em relação ao pagamento
--
-- MODIFICATION HISTORY
-- Person      Date    Comments
-- ---------   ------  -------------------------------------------
--
--
   v_erro               VARCHAR2 (200);
   v_tipo               VARCHAR2 (2);
   v_sucesso            NUMBER (1);
   v_val_retirada       NUMBER (18, 2);
   v_val_retirada_sec   NUMBER (18, 2);
   v_val_resta          NUMBER (18, 2);
   v_val_resta_sec      NUMBER (18, 2);

   CURSOR rega
   IS
      SELECT   d.dat_pagamento, a.*, b.num_seq_resumo, c.cnt_cre_cod,
               c.cnt_cod, c.num_versao_contrato, b.flg_moeda_controle
          FROM ifrbde.cad_pagamento_contrato a,
               ifrbde.cad_resumo_valores b,
               ifrbde.tab_contrato c,
               ifrbde.cad_resumo_pagamento d
         WHERE c.num_seq_contrato = b.num_seq_contrato_res
           AND b.num_seq_resumo = d.num_seq_pag_contrato_rp
           AND d.num_seq_resumo_pag = a.num_seq_contrato_pag
           AND c.num_seq_contrato = v_num_seq_contrato
           AND c.num_versao_contrato <> d.num_versao_contrato_pag
      ORDER BY c.cnt_cod,
               b.num_seq_resumo,
               a.num_ano_pgose,
               d.dat_pagamento,
               a.cod_tipo_pag;

   CURSOR regb (p_num_seq_contrato_res NUMBER)
   IS
      SELECT b.*, c.*
        FROM ifrbde.cad_resumo_valores b, ifrbde.tab_contrato c
       WHERE c.num_seq_contrato = b.num_seq_contrato_res
         AND c.num_seq_contrato = p_num_seq_contrato_res;

   CURSOR regc (
      p_num_seq_resumo   NUMBER,
      p_tip_cronograma   VARCHAR2,
      p_cod_recurso      VARCHAR2,
      p_pgose            VARCHAR2,
      p_num_versao       VARCHAR2
   )
   IS
      SELECT   a.*
          FROM ifrbde.tab_cont_crono_pagamento a
         WHERE a.num_seq_contrato_cron = p_num_seq_resumo
           
--         AND a.ccp_rti_cod = p_cod_recurso
--         AND a.ccp_pgose = p_pgose
           AND a.val_saldo_crono > 0
           AND a.tip_cronograma = p_tip_cronograma
      
--           AND a.num_versao_contrato_cron = p_num_versao
      ORDER BY a.ccp_data_venc, a.tip_cronograma;

   CURSOR regd
   IS
      SELECT b.num_seq_resumo, c.cnt_cre_cod, c.cnt_cod, d.num_seq_cronograma
        FROM ifrbde.cad_resumo_valores b,
             ifrbde.tab_contrato c,
             ifrbde.tab_cont_crono_pagamento d
       WHERE c.num_seq_contrato = b.num_seq_contrato_res
         AND c.num_seq_contrato = v_num_seq_contrato
         AND b.num_seq_resumo = d.num_seq_contrato_cron;
--         AND c.num_versao_contrato = d.num_versao_contrato_cron;
BEGIN
   v_sucesso := 0;
   v_erro := '';
   v_val_resta := 0;

   
--
-- EXCLUI O HISTORICO PARA REPROCESSAR OS VALORES
--
   FOR regz IN regd
   LOOP
      DELETE FROM ifrbde.hst_pagamento_cronograma
            WHERE num_seq_cronograma_hst = regz.num_seq_cronograma;
   END LOOP;

   
--
-- AJUSTA OS VALORES DOS SALDO NO CRONOGRAMA
--
   FOR regy IN regb (v_num_seq_contrato)
   LOOP
      IF regy.flg_moeda_controle = '1'
      THEN
         UPDATE ifrbde.tab_cont_crono_pagamento
            SET val_saldo_crono = ccp_valor,
                val_saldo_crono_sec = 0
          WHERE num_seq_contrato_cron = regy.num_seq_resumo
            AND num_versao_contrato_cron = regy.num_versao_contrato;
      ELSE
         UPDATE ifrbde.tab_cont_crono_pagamento
            SET val_saldo_crono = ccp_valor,
                val_saldo_crono_sec =
                                  ROUND ((ccp_valor / val_cotacao_crono), 2)
          WHERE num_seq_contrato_cron = regy.num_seq_resumo
            AND num_versao_contrato_cron = regy.num_versao_contrato;
      END IF;
   END LOOP;

   FOR regx IN rega
   LOOP
      v_sucesso := 0;
      v_erro := '';
      v_val_resta := 0;
      v_val_retirada := 0;
      v_val_resta_sec := 0;
      v_val_retirada_sec := 0;

      IF regx.flg_moeda_controle = '2'
      THEN
         v_val_resta_sec := ROUND (
                               (  (  regx.val_pagamento
                                   - regx.val_glosa
                                  )
                                / regx.val_cotacao_moeda
                               ),
                               2
                            );
      ELSE
         v_val_resta := (  regx.val_pagamento
                         - regx.val_glosa
                        );
      END IF;

      IF regx.cod_tipo_pag = 'P'
      THEN
         v_tipo := 'DE';
      END IF;

      IF regx.cod_tipo_pag = 'R'
      THEN
         v_tipo := 'RJ';
      END IF;

      IF regx.cod_tipo_pag = 'L'
      THEN
         v_tipo := 'LR';
      END IF;

      IF regx.cod_tipo_pag = 'D'
      THEN
         v_tipo := 'DA';
      END IF;

      FOR regs IN regc (
                     regx.num_seq_resumo_contrato,
                     v_tipo,
                     regx.cod_recurso,
                     regx.num_ano_pgose,
                     regx.num_versao_contrato
                  )
      LOOP
         IF    v_val_resta > 0
            OR v_val_resta_sec > 0
         THEN
            IF regx.flg_moeda_controle = '1'
            THEN
               IF regs.val_saldo_crono >= v_val_resta
               THEN
                  v_val_retirada := v_val_resta;
                  v_val_resta := 0;
               ELSE
                  v_val_retirada := regs.val_saldo_crono;
                  v_val_resta :=   v_val_resta
                                 - v_val_retirada;
               END IF;
            ELSE
               IF regs.val_saldo_crono_sec >= v_val_resta_sec
               THEN
                  v_val_retirada_sec := v_val_resta_sec;
                  v_val_resta := 0;
               ELSE
                  v_val_retirada_sec := regs.val_saldo_crono_sec;
                  v_val_resta_sec :=   v_val_resta_sec
                                     - v_val_retirada_sec;
               END IF;

               v_val_retirada :=
                     ROUND ((v_val_retirada_sec * regx.val_cotacao_moeda), 2);
            END IF;

            IF v_sucesso = 0
            THEN
               BEGIN
                  INSERT INTO ifrbde.hst_pagamento_cronograma
                              (num_seq_cronograma_hst,
                               num_seq_pag_contrato_hst, dat_execucao_hst,
                               cod_recurso_hst, val_retirado_hst,
                               val_retirado_sec_hst, tip_historico_pagamento)
                       VALUES (regs.num_seq_cronograma,
                               regx.num_seq_pag_contrato, SYSDATE,
                               regx.cod_recurso, v_val_retirada,
                               v_val_retirada_sec, 'P');
               EXCEPTION
                  WHEN OTHERS
                  THEN
                     v_erro :=
                              'Erro ao incluir a parcela no historico de pagamento x cronograma'
                           || 'resumo '
                           || TO_CHAR (regx.num_seq_resumo_contrato)
                           || 'tipo '
                           || v_tipo
                           || 'recurso '
                           || regx.cod_recurso
                           || ' ano    '
                           || regx.num_ano_pgose
                           || ' erro '
                           || SQLERRM;
                     v_sucesso := 1;
               END;
            END IF;
         END IF;
      END LOOP;

      IF v_val_resta > 0
      THEN
         v_erro :=    'Não há saldo no cronograma para gravar no historico'
                   || ' resumo  '
                   || TO_CHAR (regx.num_seq_resumo_contrato)
                   || ' tipo    '
                   || v_tipo
                   || ' ano     '
                   || regx.num_ano_pgose;
         v_sucesso := 1;
      END IF;

      
--
     IF regx.val_glosa > 0 and v_sucesso = 0
      THEN

--
         v_sucesso := 0;
         v_erro := '';
         v_val_resta := 0;
         v_val_retirada := 0;
         v_val_resta_sec := 0;
         v_val_retirada_sec := 0;

         IF regx.flg_moeda_controle = '2'
         THEN
            v_val_resta_sec :=
                     ROUND (((regx.val_glosa) / regx.val_cotacao_moeda), 2);
         ELSE
            v_val_resta := regx.val_glosa;
         END IF;

         IF regx.cod_tipo_pag = 'P'
         THEN
            v_tipo := 'DE';
         END IF;

         IF regx.cod_tipo_pag = 'R'
         THEN
            v_tipo := 'RJ';
         END IF;

         IF regx.cod_tipo_pag = 'L'
         THEN
            v_tipo := 'LR';
         END IF;

         IF regx.cod_tipo_pag = 'D'
         THEN
            v_tipo := 'DA';
         END IF;

         FOR regs IN regc (
                        regx.num_seq_resumo_contrato,
                        v_tipo,
                        regx.cod_recurso,
                        regx.num_ano_pgose,
                        regx.num_versao_contrato
                     )
         LOOP
            IF    v_val_resta > 0
               OR v_val_resta_sec > 0
            THEN
               IF regx.flg_moeda_controle = '1'
               THEN
                  IF regs.val_saldo_crono >= v_val_resta
                  THEN
                     v_val_retirada := v_val_resta;
                     v_val_resta := 0;
                  ELSE
                     v_val_retirada := regs.val_saldo_crono;
                     v_val_resta :=   v_val_resta
                                    - v_val_retirada;
                  END IF;
               ELSE
                  IF regs.val_saldo_crono_sec >= v_val_resta_sec
                  THEN
                     v_val_retirada_sec := v_val_resta_sec;
                     v_val_resta := 0;
                  ELSE
                     v_val_retirada_sec := regs.val_saldo_crono_sec;
                     v_val_resta_sec :=
                                         v_val_resta_sec
                                       - v_val_retirada_sec;
                  END IF;

                  v_val_retirada :=
                     ROUND ((v_val_retirada_sec * regx.val_cotacao_moeda), 2);
               END IF;

               IF v_sucesso = 0
               THEN
                  BEGIN
                     INSERT INTO ifrbde.hst_pagamento_cronograma
                                 (num_seq_cronograma_hst,
                                  num_seq_pag_contrato_hst, dat_execucao_hst,
                                  cod_recurso_hst, val_retirado_hst,
                                  val_retirado_sec_hst,
                                  tip_historico_pagamento)
                          VALUES (regs.num_seq_cronograma,
                                  regx.num_seq_pag_contrato, SYSDATE,
                                  regx.cod_recurso, v_val_retirada,
                                  v_val_retirada_sec,
                                  'G');
                  EXCEPTION
                     WHEN OTHERS
                     THEN
                        v_erro :=
                                 'Erro ao incluir a parcela no historico de pagamento x cronograma para glosa '
                              || 'resumo '
                              || TO_CHAR (regx.num_seq_resumo_contrato)
                              || 'tipo '
                              || v_tipo
                              || 'recurso '
                              || regx.cod_recurso
                              || ' ano    '
                              || regx.num_ano_pgose
                              || ' erro '
                              || SQLERRM;
                        v_sucesso := 1;
                  END;
               END IF;
            END IF;
         END LOOP;

         IF v_val_resta > 0
         THEN
            v_erro :=
                     'Não há saldo no cronograma para gravar no historico de glosa '
                  || ' resumo  '
                  || TO_CHAR (regx.num_seq_resumo_contrato)
                  || ' tipo    '
                  || v_tipo
                  || ' ano     '
                  || regx.num_ano_pgose;
            v_sucesso := 1;
         END IF;

--
      END IF;
--      
      IF v_sucesso <> 0
      THEN
         raise_application_error (-20100, v_erro);
      END IF;
   
--
   END LOOP;
EXCEPTION
   WHEN OTHERS
   THEN
      v_erro :=    'Erro na procedure PRC_CALCULA_HST_PAG_CRONO - '
                || SQLERRM;
      v_sucesso := 1;
      raise_application_error (-20100, v_erro);
END prc_calcula_hst_pag_crono; -- Procedure
/

-- Grants for Procedure
GRANT EXECUTE ON ifrbde.prc_calcula_hst_pag_crono TO bde_geral
/


-- End of DDL Script for Procedure IFRBDE.PRC_CALCULA_HST_PAG_CRONO

