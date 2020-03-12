CREATE OR REPLACE TRIGGER TRG_CAD_RESUMO_VALORES_01
 BEFORE 
 INSERT OR DELETE OR UPDATE OF DAT_MOEDA, FLG_MOEDA_CONTROLE, TIP_COTACAO_MOEDA, TIP_MOEDA, VAL_COTACAO_MOEDA, VAL_INICIAL_RESUMO, VAL_PAGAMENTO, VAL_PAGAMENTO_SEC, VAL_PAGO, VAL_PAGO_REAJUSTE, VAL_PAGO_REAJUSTE_SEC, VAL_PAGO_SEC, VAL_REAJUSTE, VAL_REAJUSTE_SEC, VAL_RESUMO, VAL_RESUMO_SEC, VAL_SALDO_RESUMO, VAL_SALDO_RESUMO_SEC, VAL_TERMO, VAL_TERMO_SEC
 ON CAD_RESUMO_VALORES
 REFERENCING OLD AS OLD NEW AS NEW
 FOR EACH ROW 
DECLARE
   v_erro                   VARCHAR2 (200);
   v_sucesso                NUMBER (1);
   v_versao_contrato        VARCHAR2 (2);
   v_rap_rti_cod            ifrbde.tab_rec_aprovado.rap_rti_cod%TYPE;
   v_saldo_ano              ifrbde.tab_rec_aprovado.val_saldo_recurso%TYPE;
   
-- 
   tot_val_acumulado        NUMBER (12, 2);
   tot_val_acumulado_sec    NUMBER (12, 2);
   tot_val_acumulador       NUMBER (12, 2);
   tot_val_acumulador_sec   NUMBER (12, 2);
--      
BEGIN
   v_sucesso := 0;
   v_erro := '';

   IF    INSERTING
      OR UPDATING
   THEN
      
--
--
-- zerar variavel --
--
      :NEW.val_resumo := NVL (:NEW.val_resumo, 0);
      :NEW.cod_recurso_res := NVL (:NEW.cod_recurso_res, '00.00');
      :NEW.val_saldo_resumo := NVL (:NEW.val_saldo_resumo, 0);
      :NEW.val_termo := NVL (:NEW.val_termo, 0);
      :NEW.val_pago_reajuste := NVL (:NEW.val_pago_reajuste, 0);
      :NEW.val_pago := NVL (:NEW.val_pago, 0);
      :NEW.flg_moeda_controle := NVL (:NEW.flg_moeda_controle, 1);
      :NEW.tip_moeda := NVL (:NEW.tip_moeda, 'REAL');
      :NEW.val_cotacao_moeda := NVL (:NEW.val_cotacao_moeda, 1.0);
      :NEW.dat_moeda := NVL (:NEW.dat_moeda, SYSDATE);
      :NEW.val_saldo_resumo_sec := NVL (:NEW.val_saldo_resumo_sec, 0);
      :NEW.val_resumo_sec := NVL (:NEW.val_resumo_sec, 0);
      :NEW.val_termo_sec := NVL (:NEW.val_termo_sec, 0);
      :NEW.val_pagamento_sec := NVL (:NEW.val_pagamento_sec, 0);
      :NEW.val_reajuste_sec := NVL (:NEW.val_reajuste_sec, 0);
      :NEW.val_pago_sec := NVL (:NEW.val_pago_sec, 0);
      :NEW.val_pago_reajuste_sec := NVL (:NEW.val_pago_reajuste_sec, 0);
      
--
      ifrbde.pck_variaveis.v_pck_num_seq_contrato :=
                                                    :NEW.num_seq_contrato_res;

      
--
      IF :NEW.num_versao_contrato_res IS NULL
      THEN
         BEGIN
            :NEW.num_versao_contrato_res :=
                                      NVL (:NEW.num_versao_contrato_res, '00');

            SELECT num_versao_contrato
              INTO v_versao_contrato
              FROM ifrbde.tab_contrato
             WHERE num_seq_contrato = :NEW.num_seq_contrato_res;

            :NEW.num_versao_contrato_res := NVL (v_versao_contrato, '00');
         EXCEPTION
            WHEN OTHERS
            THEN
               v_erro :=
                          'Erro ao selecionar a versão do contrato'
                       || SQLERRM;
               v_sucesso := 1;
         END;
      END IF;

      IF  :NEW.flg_moeda_controle = 2 AND v_sucesso = 0
      THEN
         IF :NEW.tip_moeda = 'REAL'
         THEN
            v_erro :=
                    'O nome da Moeda não pode ser REAL para moeda secundaria';
            v_sucesso := 1;
         ELSE
            -- calcula valor em real no resumo  
            :NEW.val_resumo_sec :=
                           ROUND (:NEW.val_resumo / :NEW.val_cotacao_moeda, 2);
         END IF;
      END IF;

      
--
--  calcula resumo para moeda principal
--      
--
-- calcula os totais para SP´s de Pagamento, Desembolso aduaneiro
--
      tot_val_acumulado := 0;
      tot_val_acumulado_sec := 0;
      :NEW.val_pago := tot_val_acumulado;
      :NEW.val_pago_sec := tot_val_acumulado_sec;

      IF :NEW.flg_moeda_controle = 1
      THEN
         BEGIN
            SELECT SUM (  val_pagamento
                        - NVL (val_glosa, 0))
              INTO tot_val_acumulado
              FROM ifrbde.cad_pagamento_contrato
             WHERE cod_tipo_pag IN ('P', 'D')
               AND num_seq_resumo_contrato = :NEW.num_seq_resumo;

            :NEW.val_pago := tot_val_acumulado;
            :NEW.val_pago_sec := tot_val_acumulado_sec;
         EXCEPTION
            WHEN OTHERS
            THEN
               v_erro :=
                        'Não foi possível atualizar os Totais de Pagamento'
                     || SQLERRM;
               v_sucesso := 1;
         END;
      END IF;

      
--
-- calcula os totais para SP´s de reajuste
--
      tot_val_acumulado := 0;
      tot_val_acumulado_sec := 0;
      :NEW.val_pago_reajuste := tot_val_acumulado;
      :NEW.val_pago_reajuste_sec := tot_val_acumulado_sec;

      IF :NEW.flg_moeda_controle = 1
      THEN
         BEGIN
            SELECT SUM (  val_pagamento
                        - NVL (val_glosa, 0))
              INTO tot_val_acumulado
              FROM ifrbde.cad_pagamento_contrato
             WHERE cod_tipo_pag IN ('R')
               AND num_seq_resumo_contrato = :NEW.num_seq_resumo;

            :NEW.val_pago_reajuste := tot_val_acumulado;
            :NEW.val_pago_reajuste_sec := tot_val_acumulado_sec;
         EXCEPTION
            WHEN OTHERS
            THEN
               v_erro :=    'Não foi possível atualizar os Totais de Reajuste'
                         || SQLERRM;
               v_sucesso := 1;
         END;
      END IF;

      
--
-- calculos em moeda estrangeira
--
--
-- calcula os totais para SP´s de Pagamento, Desembolso aduaneiro
--

      IF :NEW.flg_moeda_controle = 2
      THEN
         BEGIN
            tot_val_acumulado := 0;
            tot_val_acumulado_sec := 0;
            :NEW.val_pago := tot_val_acumulado;
            :NEW.val_pago_sec := tot_val_acumulado_sec;

            SELECT SUM (
                      ROUND (
                         (  (  (  val_pagamento
                                - NVL (val_glosa, 0)
                               )
                             / NVL (val_cotacao_moeda, 1)
                            )
                          * NVL (:NEW.val_cotacao_moeda, 1)
                         ),
                         2
                      )
                   ),
                   SUM (
                      ROUND (
                           (  val_pagamento
                            - NVL (val_glosa, 0)
                           )
                         / NVL (val_cotacao_moeda, 1),
                         2
                      )
                   )
              INTO tot_val_acumulado,
                   tot_val_acumulado_sec
              FROM ifrbde.cad_pagamento_contrato
             WHERE cod_tipo_pag IN ('P', 'D')
               AND num_seq_resumo_contrato = :NEW.num_seq_resumo;

            :NEW.val_pago := tot_val_acumulado;
            :NEW.val_pago_sec := tot_val_acumulado_sec;
         EXCEPTION
            WHEN OTHERS
            THEN
               v_erro :=
                        'Não foi possível atualizar os Totais de Pagamento'
                     || SQLERRM;
               v_sucesso := 1;
         END;
      END IF;

      
--
-- calcula os totais para SP´s de variação cambial
--

      IF :NEW.flg_moeda_controle = 2
      THEN
         BEGIN
            tot_val_acumulado := 0;
            tot_val_acumulado_sec := 0;
            :NEW.val_pago_reajuste := tot_val_acumulado;

            SELECT SUM (
                        (  val_pagamento
                         - NVL (val_glosa, 0)
                        )
                      - ROUND (
                           (  (  (  val_pagamento
                                  - NVL (val_glosa, 0)
                                 )
                               / NVL (val_cotacao_moeda, 1)
                              )
                            * NVL (:NEW.val_cotacao_moeda, 1)
                           ),
                           2
                        )
                   )
              INTO tot_val_acumulado
              FROM ifrbde.cad_pagamento_contrato
             WHERE cod_tipo_pag IN ('P', 'D')
               AND num_seq_resumo_contrato = :NEW.num_seq_resumo;

            :NEW.val_pago_reajuste := tot_val_acumulado;
            :NEW.val_pago_reajuste_sec := tot_val_acumulado_sec;
         EXCEPTION
            WHEN OTHERS
            THEN
               v_erro :=
                        'Não foi possível atualizar os Totais de variação cambial'
                     || SQLERRM;
               v_sucesso := 1;
         END;
      END IF;

      
--
-- calculos para resumo na moeda principal
--

--
-- calcula os totais para o cronograma de desembolso, Desembolso aduaneiro
--
      tot_val_acumulado := 0;
      tot_val_acumulado_sec := 0;
      :NEW.val_pagamento := tot_val_acumulado;
      :NEW.val_pagamento_sec := tot_val_acumulado_sec;

      IF :NEW.flg_moeda_controle = 1
      THEN
         BEGIN
            SELECT SUM (ccp_valor)
              INTO tot_val_acumulado
              FROM ifrbde.tab_cont_crono_pagamento
             WHERE tip_cronograma IN ('DE', 'DA')
               AND num_seq_contrato_cron = :NEW.num_seq_resumo;

            :NEW.val_pagamento := tot_val_acumulado;
            :NEW.val_pagamento_sec := tot_val_acumulado_sec;
         EXCEPTION
            WHEN OTHERS
            THEN
               v_erro :=
                        'Não foi possível atualizar os Totais do Cronograma de Desembolso ou Desembaraço Aduaneiro'
                     || SQLERRM;
               v_sucesso := 1;
         END;
      END IF;

      
--
-- calcula os totais para o cronograma de reajuste
--
      tot_val_acumulado := 0;
      tot_val_acumulado_sec := 0;
      :NEW.val_reajuste := tot_val_acumulado;
      :NEW.val_reajuste_sec := tot_val_acumulado_sec;

      IF :NEW.flg_moeda_controle = 1
      THEN
         BEGIN
            SELECT SUM (ccp_valor)
              INTO tot_val_acumulado
              FROM ifrbde.tab_cont_crono_pagamento
             WHERE tip_cronograma IN ('RJ')
               AND num_seq_contrato_cron = :NEW.num_seq_resumo;

            :NEW.val_reajuste := tot_val_acumulado;
            :NEW.val_reajuste_sec := tot_val_acumulado_sec;
         EXCEPTION
            WHEN OTHERS
            THEN
               v_erro :=
                        'Não foi possível atualizar os Totais do Cronograma de Reajuste'
                     || SQLERRM;
               v_sucesso := 1;
         END;
      END IF;

      
--
--  calcula o resumo para moeda secundaria
--
--
-- calcula os totais para o cronograma de desembolso, Desembolso aduaneiro
--

      IF :NEW.flg_moeda_controle = 2
      THEN
         BEGIN
            tot_val_acumulado := 0;
            tot_val_acumulado_sec := 0;
            :NEW.val_pagamento := tot_val_acumulado;
            :NEW.val_pagamento_sec := tot_val_acumulado_sec;

            SELECT SUM (
                      ROUND (
                         (  ((ccp_valor) / NVL (val_cotacao_crono, 1))
                          * NVL (:NEW.val_cotacao_moeda, 1)
                         ),
                         2
                      )
                   ),
                   SUM (ROUND ((ccp_valor) / NVL (val_cotacao_crono, 1), 2))
              INTO tot_val_acumulado,
                   tot_val_acumulado_sec
              FROM ifrbde.tab_cont_crono_pagamento
             WHERE tip_cronograma IN ('DE', 'DA')
               AND num_seq_contrato_cron = :NEW.num_seq_resumo;

            :NEW.val_pagamento := tot_val_acumulado;
            :NEW.val_pagamento_sec := tot_val_acumulado_sec;
         EXCEPTION
            WHEN OTHERS
            THEN
               v_erro :=
                        'Não foi possível atualizar os Totais do Cronograma de Desembolso ou Desembaraço Aduaneiro'
                     || SQLERRM;
               v_sucesso := 1;
         END;
      END IF;

      
--
-- calcula os totais para o cronograma de variação cambial
--

      IF :NEW.flg_moeda_controle = 2
      THEN
         BEGIN
            tot_val_acumulado := 0;
            tot_val_acumulado_sec := 0;
            :NEW.val_reajuste := tot_val_acumulado;
            :NEW.val_reajuste_sec := tot_val_acumulado_sec;

            SELECT SUM (
                        (ccp_valor)
                      - ROUND (
                           (  ((ccp_valor) / NVL (val_cotacao_crono, 1))
                            * NVL (:NEW.val_cotacao_moeda, 1)
                           ),
                           2
                        )
                   )
              INTO tot_val_acumulado
              FROM ifrbde.tab_cont_crono_pagamento
             WHERE tip_cronograma IN ('DE', 'DA')
               AND num_seq_contrato_cron = :NEW.num_seq_resumo;

            :NEW.val_reajuste := tot_val_acumulado;
         EXCEPTION
            WHEN OTHERS
            THEN
               v_erro :=
                        'Não foi possível atualizar os Totais do Cronograma de variação cambial'
                     || SQLERRM;
               v_sucesso := 1;
         END;
      END IF;

      
--
--
--      

--      
--
-- calcula o saldo do resumo
--  
      IF v_sucesso = 0
      THEN
         :NEW.val_saldo_resumo :=   NVL (:NEW.val_resumo, 0)
                                  + NVL (:NEW.val_termo, 0)
                                  - NVL (:NEW.val_pago, 0);
      END IF;

      
-- 
-- calcula o saldo do resumo secundario
--

      :NEW.val_saldo_resumo_sec :=   NVL (:NEW.val_resumo_sec, 0)
                                   + NVL (:NEW.val_termo_sec, 0)
                                   - NVL (:NEW.val_pago_sec, 0);

      IF  :NEW.val_saldo_resumo_sec < 0 AND v_sucesso = 0
      THEN
         v_erro :=
              'O Saldo do Resumo de valores secundario não pode ser negativo';
         v_sucesso := 1;
      END IF;

      IF  :NEW.val_resumo_sec < 0 AND v_sucesso = 0
      THEN
         v_erro :=
                'Valor do Resumo de valores secundario não pode ser negativo';
         v_sucesso := 1;
      END IF;

      
--
      IF  :NEW.val_saldo_resumo < 0 AND v_sucesso = 0
      THEN
         v_erro := 'O Saldo do Resumo de valores não pode ser negativo';
         v_sucesso := 1;
      END IF;

      
--
      IF  :NEW.val_resumo < 0 AND v_sucesso = 0
      THEN
         v_erro := 'Valor do Resumo de valores não pode ser negativo';
         v_sucesso := 1;
      END IF;

      
--
      IF v_sucesso = 0
      THEN
         v_saldo_ano := 0;

         BEGIN
            SELECT a.val_saldo_recurso
              INTO v_saldo_ano
              FROM ifrbde_views.viw_saldo_carencia_contrato a,
                   ifrbde.tab_contrato b
             WHERE a.num_cre_cod = b.cnt_cre_cod
               AND b.num_seq_contrato = :NEW.num_seq_contrato_res;

            
--
            IF v_saldo_ano < 0
            THEN
               v_erro :=    'Valor do Saldo de Recurso Aprovado de '
                         || TO_CHAR (v_saldo_ano)
                         || ' é menor que o Valor do Resumo de Valores de '
                         || TO_CHAR (:NEW.val_resumo);
               v_sucesso := 1;
            END IF;
         EXCEPTION
            WHEN NO_DATA_FOUND
            THEN
               v_erro :=
                   'Não existe recurso aprovado para inclusão deste contrato';
               v_sucesso := 1;
            WHEN OTHERS
            THEN
               v_erro :=
                        'Erro ao verificar o saldo de recurso aprovado na carência '
                     || SQLERRM;
               v_sucesso := 1;
         END;
      END IF;
   
--
   END IF;

   
--   
   IF  INSERTING AND v_sucesso = 0
   THEN
      :NEW.val_inicial_resumo := NVL (:NEW.val_resumo, 0);
   END IF;

   
--
   IF  DELETING AND v_sucesso = 0
   THEN
      ifrbde.pck_variaveis.v_pck_num_seq_contrato :=
                                                    :OLD.num_seq_contrato_res;
   END IF;

   
--
   IF v_sucesso <> 0
   THEN
      raise_application_error (-20100, v_erro);
   END IF;
END;
/
