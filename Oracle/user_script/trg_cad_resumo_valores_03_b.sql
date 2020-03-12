/* Formatted on 2004/12/09 16:29 (Formatter Plus v4.5.2) */

CREATE OR REPLACE TRIGGER ifrbde.trg_cad_resumo_valores_03_b
   BEFORE INSERT  OR UPDATE OF 
  val_pago,
  dat_moeda,
  tip_moeda,
  val_termo,
  val_resumo,
  val_pago_sec,
  val_reajuste,
  val_pagamento,
  val_termo_sec,
  val_resumo_sec,
  val_reajuste_sec,
  val_saldo_resumo,
  tip_cotacao_moeda,
  val_cotacao_moeda,
  val_pagamento_sec,
  val_pago_reajuste,
  flg_moeda_controle,
  val_inicial_resumo,
  val_saldo_resumo_sec,
  val_pago_reajuste_sec,
  val_crono_realizado_reaj,  
  val_crono_realizado_pag ,
  val_crono_realizado_pag_sec,
  qtd_crono_realizado_invalidos,
  dat_base_crono_invalido  
   ON ifrbde.cad_resumo_valores
   REFERENCING NEW AS NEW OLD AS OLD
   FOR EACH ROW
DECLARE
   v_erro                      VARCHAR2 (200);
   v_sucesso                   NUMBER (1);
   v_versao_contrato           VARCHAR2 (2);
   v_rap_rti_cod               ifrbde.tab_rec_aprovado.rap_rti_cod%TYPE;
   v_saldo_ano                 ifrbde.tab_rec_aprovado.val_saldo_recurso%TYPE;
   
--
   tot_val_acumulado           NUMBER (12, 2);
   tot_val_acumulado_sec       NUMBER (12, 2);
   tot_val_acumulador          NUMBER (12, 2);
   tot_val_acumulador_sec      NUMBER (12, 2);
   tot_qtd_ocorrencias_crono   NUMBER (5);
--
BEGIN
   v_sucesso := 0;
   v_erro := '';

   IF UPDATING
   THEN
      
--
      ifrbde.pck_variaveis.v_pck_num_seq_contrato_sit :=
                                                    :NEW.num_seq_contrato_res;
      
--
--
-- calcula os totais para o cronograma de realização de desembolso, e Desembolso aduaneiro
--
      tot_val_acumulado := 0;
      tot_val_acumulado_sec := 0;
      :NEW.val_crono_realizado_pag := tot_val_acumulado;
      :NEW.val_crono_realizado_pag_sec := tot_val_acumulado_sec;

      IF :NEW.flg_moeda_controle = 1
      THEN
         BEGIN
            SELECT SUM (NVL (val_resumo_crno, 0))
              INTO tot_val_acumulado
              FROM ifrbde.cad_resumo_cronograma
             WHERE tip_resumo_crono IN ('DE', 'DA')
               AND num_seq_contrato_rc = :NEW.num_seq_resumo;

            :NEW.val_crono_realizado_pag := tot_val_acumulado;
            :NEW.val_crono_realizado_pag_sec := tot_val_acumulado_sec;

            IF (  NVL (:OLD.val_resumo, 0)
                + NVL (:OLD.val_termo, 0)
               ) < tot_val_acumulado
            THEN
               v_erro :=
                        ' Valor Total do Cronograma Realizado para desembolso '
                     || TO_CHAR (NVL (tot_val_acumulado, 0))
                     || ' não pode ser Maior do que Valor Total do Cronograma de Desembolso '
                     || TO_CHAR (
                           (  NVL (:OLD.val_resumo, 0)
                            + NVL (:OLD.val_termo, 0)
                           )
                        );
               v_sucesso := 1;
            END IF;
         EXCEPTION
            WHEN OTHERS
            THEN
               v_erro :=
                        'Não foi possível atualizar os Totais do Cronograma de Realização de Desembolso ou Desembaraço Aduaneiro'
                     || SQLERRM;
               v_sucesso := 1;
         END;
      END IF;

      
--
-- calcula os totais para o cronograma de realização de reajuste
--
      tot_val_acumulado := 0;
      
--      tot_val_acumulado_sec := 0;
      :NEW.val_crono_realizado_reaj := tot_val_acumulado;

      
--      :NEW.val_crono_realizado_pag_sec := tot_val_acumulado_sec;

      IF :NEW.flg_moeda_controle = 1
      THEN
         BEGIN
            SELECT SUM (NVL (val_resumo_crno, 0))
              INTO tot_val_acumulado
              FROM ifrbde.cad_resumo_cronograma
             WHERE tip_resumo_crono IN ('RJ')
               AND num_seq_contrato_rc = :NEW.num_seq_resumo;

            :NEW.val_crono_realizado_reaj := tot_val_acumulado;
         
--            :NEW.val_crono_realizado_pag_sec := tot_val_acumulado_sec;
/*
            IF NVL (:NEW.val_reajuste, 0) > tot_val_acumulado
            THEN
               v_erro :=
                        ' Valor Total do Cronograma Realizado para reajuste '
                     || TO_CHAR (NVL (tot_val_acumulado, 0))
                     || ' deve ser Maior ou igual ao Valor Total do Cronograma de reajuste '
                     || TO_CHAR (NVL (:NEW.val_reajuste, 0));
               v_sucesso := 1;
            END IF;
*/
         EXCEPTION
            WHEN OTHERS
            THEN
               v_erro :=
                        'Não foi possível atualizar os Totais do Cronograma de Realização de Reajuste'
                     || SQLERRM;
               v_sucesso := 1;
         END;
      END IF;

      
--
--  calcula o resumo para moeda secundaria
--
--
--
-- calcula os totais para o cronograma de desembolso, Desembolso aduaneiro
--

      IF :NEW.flg_moeda_controle = 2
      THEN
         BEGIN
            tot_val_acumulado := 0;
            tot_val_acumulado_sec := 0;
            :NEW.val_crono_realizado_pag_sec := tot_val_acumulado_sec;

            SELECT SUM (val_moeda_sec_rc)
              INTO tot_val_acumulado_sec
              FROM ifrbde.cad_resumo_cronograma
             WHERE tip_resumo_crono IN ('DE', 'DA')
               AND num_seq_contrato_rc = :NEW.num_seq_resumo;

            :NEW.val_crono_realizado_pag_sec := tot_val_acumulado_sec;
         
/*            IF :old.val_pagamento_sec > tot_val_acumulado_sec
            THEN
               v_erro :=
                        ' Valor Total do Cronograma Realizado para desembolso '
                     || TO_CHAR (NVL (tot_val_acumulado_sec, 0))
                     || ' não pode ser Maior do que Valor Total do Cronograma de Desembolso '
                     || TO_CHAR (NVL (:NEW.val_pagamento_sec, 0))
                     || ' para moeda secundaria ';
               v_sucesso := 1;
            END IF;
*/
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
-- calcular quantas linhas de cronograma não realizado são menores que hoje.
--

      BEGIN
         tot_qtd_ocorrencias_crono := 0;

         SELECT COUNT (val_moeda_sec_rc)
           INTO tot_qtd_ocorrencias_crono
           FROM ifrbde.cad_resumo_cronograma
          WHERE num_seq_contrato_rc = :NEW.num_seq_resumo
            AND TO_DATE (
                   TO_CHAR (dat_vencimento_rc, 'dd/mm/yyyy'),
                   'dd/mm/yyyy'
                ) < TO_DATE (TO_CHAR (SYSDATE, 'dd/mm/yyyy'), 'dd/mm/yyyy')
            AND num_seq_resumo_pag IS NULL;

         :NEW.qtd_crono_realizado_invalidos := tot_qtd_ocorrencias_crono;
         :NEW.dat_base_crono_invalido :=
                        TO_DATE (TO_CHAR (SYSDATE, 'dd/mm/yyyy'), 'dd/mm/yyyy');
      EXCEPTION
         WHEN OTHERS
         THEN
            v_erro :=
                  'Não foi possível atualizar a quantidade de ocorrencias não realizadas antes de hoje';
            v_sucesso := 1;
      END;
   
--
   END IF;

   
--
   IF v_sucesso <> 0
   THEN
      raise_application_error (-20100, v_erro);
   END IF;
END;
/

-- End of DDL Script for Trigger IFRBDE.TRG_CAD_RESUMO_VALORES_03_B

