CREATE OR REPLACE TRIGGER trg_tab_cont_crono_pag_01
   BEFORE INSERT OR DELETE OR UPDATE OF ccp_data_venc,
                                        ccp_pgose,
                                        ccp_rti_cod,
                                        ccp_valor,
                                        dat_moeda_crono,
                                        dat_vencimento,
                                        num_seq_contrato_cron,
                                        num_seq_cronograma,
                                        tip_cotacao_crono,
                                        tip_cronograma,
                                        val_cotacao_crono,
                                        val_crono_moeda_sec
   ON tab_cont_crono_pagamento
   REFERENCING OLD AS OLD NEW AS NEW
   FOR EACH ROW
DECLARE
   v_erro                    VARCHAR2 (200);
   v_sucesso                 NUMBER (1);
   v_rap_rti_cod             ifrbde.tab_cont_crono_pagamento.ccp_rti_cod%TYPE;
   v_val_resumo              ifrbde.cad_resumo_valores.val_resumo%TYPE;
   v_tip_situacao_contrato   ifrbde.tab_contrato.tip_situacao_contrato%TYPE;
   v_num_seq_contrato        ifrbde.tab_contrato.num_seq_contrato%TYPE;
BEGIN
   v_sucesso := 0;
   v_erro := '';

   IF    INSERTING
      OR UPDATING
   THEN
      :NEW.dat_vencimento := :NEW.ccp_data_venc;
      :NEW.val_saldo_crono := NVL (:NEW.ccp_valor, 0);
      :NEW.val_saldo_crono_sec := 0;

      BEGIN
         SELECT val_resumo
           INTO v_val_resumo
           FROM ifrbde.cad_resumo_valores
          WHERE num_seq_resumo = :NEW.num_seq_contrato_cron;
      EXCEPTION
         WHEN OTHERS
         THEN
            v_erro :=
                     'Não foi possível localizar o resumo de valores do contrato'
                  || SQLERRM;
            v_sucesso := 1;
      END;

      IF v_sucesso = 0
      THEN
         BEGIN
            SELECT c.rap_rti_cod, b.tip_situacao_contrato,
                   b.num_seq_contrato
              INTO v_rap_rti_cod, v_tip_situacao_contrato,
                   v_num_seq_contrato
              FROM ifrbde.cad_resumo_valores a,
                   ifrbde.tab_contrato b,
                   ifrbde.tab_rec_aprovado c
             WHERE a.num_seq_resumo = :NEW.num_seq_contrato_cron
               AND a.num_seq_contrato_res = b.num_seq_contrato
               AND b.cnt_cre_cod = c.rap_cre_cod
               AND c.rap_pgose = :NEW.ccp_pgose
               AND c.rap_rti_cod = :NEW.ccp_rti_cod;
         --  :NEW.ccp_rti_cod := v_rap_rti_cod;

         EXCEPTION
            WHEN OTHERS
            THEN
               v_erro :=
                        'Este Recurso não esta aprovado na carência para este ano, verifique os recursos aprovados !!!!'
                     || SQLERRM;
               v_sucesso := 1;
         END;
      END IF;

      IF  v_tip_situacao_contrato IN ('6', '7') AND v_sucesso = 0
      THEN
         IF :NEW.tip_cronograma = 'DE'
         THEN
            v_erro :=
                     'Contrato Enviado a Financeira o cronograma não pode se modificado !!!'
                  || SQLERRM;
            v_sucesso := 1;
         ELSE
            BEGIN
               UPDATE ifrbde.tab_contrato
                  SET tip_situacao_contrato = 4
                WHERE num_seq_contrato = v_num_seq_contrato;
            EXCEPTION
               WHEN OTHERS
               THEN
                  v_erro :=
                           'Não foi possível Atualizar a situação do contrato para Liberação do Cronograma'
                        || SQLERRM;
                  v_sucesso := 1;
            END;
         END IF;
      END IF;
   END IF;

   IF  INSERTING AND v_sucesso = 0
   THEN
      :NEW.dat_vencimento := :NEW.ccp_data_venc;

      IF :NEW.tip_cronograma = 'DE'
      THEN
         BEGIN
            UPDATE ifrbde.cad_resumo_valores
               SET val_pagamento =   NVL (val_pagamento, 0)
                                   + :NEW.ccp_valor
             WHERE num_seq_resumo = :NEW.num_seq_contrato_cron;
         EXCEPTION
            WHEN OTHERS
            THEN
               v_erro :=
                        'Não foi possível Incluir no Cronograma do resumo do Contrato'
                     || SQLERRM;
               v_sucesso := 1;
         END;
      END IF;

      IF :NEW.tip_cronograma = 'RJ'
      THEN
         BEGIN
            UPDATE ifrbde.cad_resumo_valores
               SET val_reajuste =   NVL (val_reajuste, 0)
                                  + :NEW.ccp_valor
             WHERE num_seq_resumo = :NEW.num_seq_contrato_cron;
         EXCEPTION
            WHEN OTHERS
            THEN
               v_erro :=
                        'Não foi possível Incluir no Cronograma do resumo do Contrato'
                     || SQLERRM;
               v_sucesso := 1;
         END;
      END IF;
   END IF;

   IF  UPDATING AND v_sucesso = 0
   THEN
      :NEW.dat_vencimento := :NEW.ccp_data_venc;

      IF :NEW.tip_cronograma = 'DE'
      THEN
         BEGIN
            UPDATE ifrbde.cad_resumo_valores
               SET val_pagamento =
                        NVL (val_pagamento, 0)
                      - :OLD.ccp_valor
                      + :NEW.ccp_valor
             WHERE num_seq_resumo = :NEW.num_seq_contrato_cron;
         EXCEPTION
            WHEN OTHERS
            THEN
               v_erro :=
                        'Não foi possível Atualizar o Cronograma do resumo do Contrato'
                     || SQLERRM;
               v_sucesso := 1;
         END;
      END IF;

      IF :NEW.tip_cronograma = 'RJ'
      THEN
         BEGIN
            UPDATE ifrbde.cad_resumo_valores
               SET val_reajuste =
                         NVL (val_reajuste, 0)
                       - :NEW.ccp_valor
                       + :NEW.ccp_valor
             WHERE num_seq_resumo = :NEW.num_seq_contrato_cron;
         EXCEPTION
            WHEN OTHERS
            THEN
               v_erro :=
                        'Não foi possível Atualizar o Cronograma do resumo do Contrato'
                     || SQLERRM;
               v_sucesso := 1;
         END;
      END IF;

      IF  :OLD.tip_cronograma <> :NEW.tip_cronograma AND v_sucesso = 0
      THEN
         v_erro :=
               'O Tipo de cronograma não pode ser modificado - Exclua o registro e redigite novamente ';
         v_sucesso := 1;
      END IF;

      IF  :OLD.ccp_rti_cod <> :NEW.ccp_rti_cod AND v_sucesso = 0
      THEN
         v_erro :=
               'O Recurso não pode ser modificado - Exclua o registro e redigite novamente ';
         v_sucesso := 1;
      END IF;

      IF  :OLD.ccp_data_venc <> :NEW.ccp_data_venc AND v_sucesso = 0
      THEN
         v_erro :=
               'A Data de Vencimento não pode ser modificada - Exclua o registro e redigite novamente ';
         v_sucesso := 1;
      END IF;
   END IF;

   IF DELETING
   THEN
      BEGIN
         SELECT val_resumo
           INTO v_val_resumo
           FROM ifrbde.cad_resumo_valores
          WHERE num_seq_resumo = :OLD.num_seq_contrato_cron;
      EXCEPTION
         WHEN OTHERS
         THEN
            v_erro :=
                     'Não foi possível localizar o resumo de valores do contrato'
                  || SQLERRM;
            v_sucesso := 1;
      END;

      IF v_sucesso = 0
      THEN
         IF :OLD.tip_cronograma = 'DE'
         THEN
            BEGIN
               UPDATE ifrbde.cad_resumo_valores
                  SET val_pagamento =   NVL (val_pagamento, 0)
                                      - :OLD.ccp_valor
                WHERE num_seq_resumo = :OLD.num_seq_contrato_cron;
            EXCEPTION
               WHEN OTHERS
               THEN
                  v_erro :=
                           'Não foi possível Excluir o Cronograma do resumo do Contrato'
                        || SQLERRM;
                  v_sucesso := 1;
            END;
         END IF;

         IF :OLD.tip_cronograma = 'RJ'
         THEN
            BEGIN
               UPDATE ifrbde.cad_resumo_valores
                  SET val_reajuste =   NVL (val_reajuste, 0)
                                     - :OLD.ccp_valor
                WHERE num_seq_resumo = :OLD.num_seq_contrato_cron;
            EXCEPTION
               WHEN OTHERS
               THEN
                  v_erro :=
                           'Não foi possível Excluir o Cronograma do resumo do Contrato'
                        || SQLERRM;
                  v_sucesso := 1;
            END;
         END IF;
      END IF;

      IF v_sucesso = 0
      THEN
         BEGIN
            SELECT c.rap_rti_cod, b.tip_situacao_contrato
              INTO v_rap_rti_cod, v_tip_situacao_contrato
              FROM ifrbde.cad_resumo_valores a,
                   ifrbde.tab_contrato b,
                   ifrbde.tab_rec_aprovado c
             WHERE a.num_seq_resumo = :OLD.num_seq_contrato_cron
               AND a.num_seq_contrato_res = b.num_seq_contrato
               AND b.cnt_cre_cod = c.rap_cre_cod
               AND c.rap_pgose = :OLD.ccp_pgose
               AND c.rap_rti_cod = :OLD.ccp_rti_cod;
         EXCEPTION
            WHEN OTHERS
            THEN
               v_erro :=
                        'Este Recurso não esta aprovado na carência para este ano, e não pode ser excluido , verifique os recursos aprovados !!!!'
                     || SQLERRM;
               v_sucesso := 1;
         END;
      END IF;

      IF  v_tip_situacao_contrato NOT IN ('1', '3', '5') AND v_sucesso = 0
      THEN
         v_erro :=
                  'Contrato em Situação que não se pode excluir o cronograma !!!'
               || SQLERRM;
         v_sucesso := 1;
      END IF;
   END IF;

   IF v_sucesso <> 0
   THEN
      raise_application_error (-20100, v_erro);
   END IF;
END;
/

