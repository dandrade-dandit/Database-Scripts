/* Formatted on 2005/03/29 10:24 (Formatter Plus v4.5.2) */
CREATE OR REPLACE TRIGGER ifrbde.trg_tab_remanejamento_01
   BEFORE INSERT OR UPDATE OR DELETE
   ON ifrbde.tab_remanejamento
   REFERENCING NEW AS NEW OLD AS OLD
   FOR EACH ROW
DECLARE
   v_erro                      VARCHAR2 (200);
   v_sucesso                   NUMBER (1);
   v_pgose                     ifrbde.tab_rec_aprovado.rap_pgose%TYPE;
   v_num_seq_carencia_rec      NUMBER (15);
   v_saldo_ano                 ifrbde.tab_rec_aprovado.val_saldo_recurso%TYPE;
   v_total_aprovado_carencia   NUMBER (18, 2);
   v_total_comprometido        NUMBER (18, 2);
BEGIN
   v_sucesso := 0;
   v_erro := '';

   
   IF  INSERTING AND v_sucesso = 0
   THEN
      
-- COLOCADA A DATA DA OPERACAO

      :NEW.dat_remanejamento :=
                        TO_DATE (TO_CHAR (SYSDATE, 'DD/MM/YYYY'), 'DD/MM/YYYY');
      :NEW.rmj_usuario := USER;
      
--      
      prc_gravar_usuario_carencia (:NEW.rmj_seq_orig, 'R');
      prc_gravar_usuario_carencia (:NEW.rmj_seq_dest, 'R');

      
--
-- RECURSO APROVADO ORIGEM
--
      IF v_sucesso = 0
      THEN
         BEGIN
            SELECT rap_pgose, rap_valor
              INTO v_pgose, :NEW.val_aprovacao_origem
              FROM ifrbde.tab_rec_aprovado
             WHERE rap_cre_cod = :NEW.rmj_seq_orig
               AND rap_rti_cod = :NEW.rmj_rti_cod_orig
               AND rap_pgose = :NEW.rmj_ano;

            
-- retira da origem
            BEGIN
               UPDATE ifrbde.tab_rec_aprovado
                  SET rap_valor =   rap_valor
                                  - :NEW.rmj_valor,
                      val_remanejado_enviado =
                                       val_remanejado_enviado
                                     + :NEW.rmj_valor
                WHERE rap_cre_cod = :NEW.rmj_seq_orig
                  AND rap_rti_cod = :NEW.rmj_rti_cod_orig
                  AND rap_pgose = :NEW.rmj_ano;
            EXCEPTION
               WHEN OTHERS
               THEN
                  v_erro :=
                           'Inclusão - Não conseguiu retirar o valor na origem , e ano '
                        || SQLERRM;
                  v_sucesso := 1;
            END;
         EXCEPTION
            WHEN OTHERS
            THEN
               v_erro :=
                        'Inclusão - Não Há este recurso na origem informada, para este ano '
                     || SQLERRM;
               v_sucesso := 1;
         END;
      END IF;
--
      IF v_sucesso = 0
      THEN
         
-- VERIFICA SE O VALOR APROVADO DE ORIGEM É ZERO RECURSO APROVADO ORIGEM
         BEGIN
            SELECT rap_pgose
              INTO v_pgose
              FROM ifrbde.tab_rec_aprovado
             WHERE rap_cre_cod = :NEW.rmj_seq_orig
               AND rap_rti_cod = :NEW.rmj_rti_cod_orig
               AND rap_pgose = :NEW.rmj_ano
               AND rap_valor = 0;

            BEGIN
               DELETE FROM ifrbde.tab_rec_aprovado
             WHERE rap_cre_cod = :NEW.rmj_seq_orig
               AND rap_rti_cod = :NEW.rmj_rti_cod_orig
               AND rap_pgose = :NEW.rmj_ano;
            EXCEPTION
               WHEN OTHERS
               THEN
                  v_erro :=
                           'Inclusão - Não consegui excluir a aprovação de origem zerada '
                        || SQLERRM;
                  v_sucesso := 1;
            END;
         EXCEPTION
            WHEN NO_DATA_FOUND
            THEN
               NULL;
            WHEN OTHERS
            THEN
               v_erro :=
                        'Exclusão - consegui localizar a aprovação no destino informado, para este ano '
                     || SQLERRM;
               v_sucesso := 1;
         END;
      END IF;
      
-- RECURSO APROVADO DESTINO

      IF v_sucesso = 0
      THEN
         BEGIN
            SELECT rap_pgose, rap_valor
              INTO v_pgose, :NEW.val_aprovacao_destino
              FROM ifrbde.tab_rec_aprovado
             WHERE rap_cre_cod = :NEW.rmj_seq_dest
               AND rap_rti_cod = :NEW.rmj_rti_cod_dest
               AND rap_pgose = :NEW.rmj_ano;

            BEGIN
               UPDATE ifrbde.tab_rec_aprovado
                  SET rap_valor =   rap_valor
                                  + :NEW.rmj_valor,
                      val_remanejado_recebido =
                                      val_remanejado_recebido
                                    + :NEW.rmj_valor
                WHERE rap_cre_cod = :NEW.rmj_seq_dest
                  AND rap_rti_cod = :NEW.rmj_rti_cod_dest
                  AND rap_pgose = :NEW.rmj_ano;
            EXCEPTION
               WHEN OTHERS
               THEN
                  v_erro :=
                           'Inclusão - Não conseguiu adicionar o valor no destino , e ano '
                        || SQLERRM;
                  v_sucesso := 1;
            END;
         EXCEPTION
            WHEN NO_DATA_FOUND
            THEN
               SELECT ifrbde.seq_num_seq_carencia.NEXTVAL
                 INTO v_num_seq_carencia_rec
                 FROM DUAL;

               INSERT INTO ifrbde.tab_rec_aprovado
                           (num_seq_carencia_rec, rap_cre_cod,
                            rap_rti_cod, rap_pgose,
                            rap_valor, rap_cre_pgi)
                    VALUES (v_num_seq_carencia_rec, :NEW.rmj_seq_dest,
                            :NEW.rmj_rti_cod_dest, :NEW.rmj_ano,
                            :NEW.rmj_valor, 'F');
            WHEN OTHERS
            THEN
               v_erro :=
                        'Inclusão - Não Há este recurso no destino informado, para este ano '
                     || SQLERRM;
               v_sucesso := 1;
         END;
      END IF;

      
--
      IF v_sucesso = 0
      THEN
         v_saldo_ano := 0;
--
         BEGIN
            SELECT a.val_saldo_recurso, a.val_total_recurso,
                   (  a.val_total_contratado
                    + a.val_total_aditivado
                   )
              INTO v_saldo_ano, v_total_aprovado_carencia,
                   v_total_comprometido
              FROM ifrbde.viw_saldo_carencia_contrato a
             WHERE a.num_cre_cod = :NEW.rmj_seq_orig;

            
--
            IF v_saldo_ano < 0
            THEN
               v_erro :=    ' Valor Total do(s) contrato(s) '
                         || TO_CHAR (v_total_comprometido)
                         || ' é maior que o Valor do Aprovado na Carência '
                         || TO_CHAR (v_total_aprovado_carencia);
               v_sucesso := 1;
            END IF;
         EXCEPTION
            WHEN NO_DATA_FOUND
            THEN
               v_erro :=
                     'Não existe recurso aprovado para remanejamento na carencia de origem';
               v_sucesso := 1;
            WHEN OTHERS
            THEN
               v_erro :=
                        'Erro ao verificar o saldo de comprometimento na carência '
                     || SQLERRM;
               v_sucesso := 1;
         END;
      END IF;
   
--
   END IF;

   IF  UPDATING AND v_sucesso = 0
   THEN
	IF :NEW.DSC_JUSTIFICATIVA = :OLD.DSC_JUSTIFICATIVA THEN
      v_erro :=
            'Alteração dos dados não autorizada. Por favor Exclua o remanejamento e faça nova inclusão com as alterações necessarias';         
      v_sucesso := 1;
	END IF;
   END IF;

   IF  DELETING AND v_sucesso = 0
   THEN
      prc_gravar_usuario_carencia (:OLD.rmj_seq_orig, 'R');
      prc_gravar_usuario_carencia (:OLD.rmj_seq_dest, 'R');

      
-- RECURSO APROVADO ORIGEM
      IF v_sucesso = 0
      THEN
         BEGIN
            SELECT rap_pgose
              INTO v_pgose
              FROM ifrbde.tab_rec_aprovado
             WHERE rap_cre_cod = :OLD.rmj_seq_orig
               AND rap_rti_cod = :OLD.rmj_rti_cod_orig
               AND rap_pgose = :OLD.rmj_ano;

            BEGIN
               UPDATE ifrbde.tab_rec_aprovado
                  SET rap_valor =   rap_valor
                                  + :OLD.rmj_valor,
                      val_remanejado_enviado =
                                       val_remanejado_enviado
                                     - :OLD.rmj_valor
                WHERE rap_cre_cod = :OLD.rmj_seq_orig
                  AND rap_rti_cod = :OLD.rmj_rti_cod_orig
                  AND rap_pgose = :OLD.rmj_ano;
            EXCEPTION
               WHEN OTHERS
               THEN
                  v_erro :=
                           'Exclusão - Não conseguiu adicionar o valor na origem , e ano '
                        || SQLERRM;
                  v_sucesso := 1;
            END;
         EXCEPTION
            WHEN OTHERS
            THEN
               v_erro :=
                        'Exclusão - Não Há este recurso na origem informada, para este ano '
                     || SQLERRM;
               v_sucesso := 1;
         END;
      END IF;

      IF v_sucesso = 0
      THEN
         
-- RECURSO APROVADO DESTINO
         BEGIN
            SELECT rap_pgose
              INTO v_pgose
              FROM ifrbde.tab_rec_aprovado
             WHERE rap_cre_cod = :OLD.rmj_seq_dest
               AND rap_rti_cod = :OLD.rmj_rti_cod_dest
               AND rap_pgose = :OLD.rmj_ano;

            BEGIN
               UPDATE ifrbde.tab_rec_aprovado
                  SET rap_valor =   rap_valor
                                  - :OLD.rmj_valor,
                      val_remanejado_recebido =
                                      val_remanejado_recebido
                                    - :OLD.rmj_valor
                WHERE rap_cre_cod = :OLD.rmj_seq_dest
                  AND rap_rti_cod = :OLD.rmj_rti_cod_dest
                  AND rap_pgose = :OLD.rmj_ano;
            EXCEPTION
               WHEN OTHERS
               THEN
                  v_erro :=
                           'Exclusão - Não conseguiu diminuir o valor no destino , e ano '
                        || SQLERRM;
                  v_sucesso := 1;
            END;
         EXCEPTION
            WHEN OTHERS
            THEN
               v_erro :=
                        'Exclusão - Não Há este recurso no destino informado, para este ano '
                     || SQLERRM;
               v_sucesso := 1;
         END;
      END IF;

      
--
      IF v_sucesso = 0
      THEN
         
-- VERIFICA SE O VALOR APROVADO DE DESTINO É ZERO RECURSO APROVADO DESTINO
         BEGIN
            SELECT rap_pgose
              INTO v_pgose
              FROM ifrbde.tab_rec_aprovado
             WHERE rap_cre_cod = :OLD.rmj_seq_dest
               AND rap_rti_cod = :OLD.rmj_rti_cod_dest
               AND rap_pgose = :OLD.rmj_ano
               AND rap_valor = 0;

            BEGIN
               DELETE FROM ifrbde.tab_rec_aprovado
                     WHERE rap_cre_cod = :OLD.rmj_seq_dest
                       AND rap_rti_cod = :OLD.rmj_rti_cod_dest
                       AND rap_pgose = :OLD.rmj_ano;
            EXCEPTION
               WHEN OTHERS
               THEN
                  v_erro :=
                           'Exclusão - Não consegui excluir a aprovação de destino zerada '
                        || SQLERRM;
                  v_sucesso := 1;
            END;
         EXCEPTION
            WHEN NO_DATA_FOUND
            THEN
               NULL;
            WHEN OTHERS
            THEN
               v_erro :=
                        'Exclusão - consegui localizar a aprovação no destino informado, para este ano '
                     || SQLERRM;
               v_sucesso := 1;
         END;
      END IF;
   END IF;

   IF v_sucesso <> 0
   THEN
      raise_application_error (-20100, v_erro);
   END IF;
END;
/

-- End of DDL Script for Trigger IFRBDE.TRG_TAB_REMANEJAMENTO_01

