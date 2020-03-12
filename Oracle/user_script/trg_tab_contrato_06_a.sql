/* Formatted on 2005/09/13 11:54 (Formatter Plus v4.5.2) */
CREATE OR REPLACE TRIGGER ifrbde.trg_tab_contrato_06_a
   AFTER INSERT
   ON ifrbde.tab_contrato
   REFERENCING NEW AS NEW OLD AS OLD
   FOR EACH ROW
DECLARE
   CURSOR pre (p_carencia NUMBER)
   IS
      SELECT     b.*
            FROM ifrbde.cad_pre_compromisso b
           WHERE b.seq_carencia = p_carencia
             AND b.seq_contrato IS NULL
             AND b.num_situacao_pre_compromisso = 2
      FOR UPDATE;

   v_erro                  VARCHAR2 (200);
   v_sucesso               NUMBER (1);
   v_qtd_pre_compromisso   NUMBER (2);
BEGIN
   v_sucesso := 0;
   v_erro := '';
   v_qtd_pre_compromisso := 0;

   
--
--*************************************** atualizar os dados do pre-compromisso *****************************************
--
   IF INSERTING
   THEN
      FOR cur IN pre (:NEW.cnt_cre_cod)
      LOOP
         v_qtd_pre_compromisso :=   v_qtd_pre_compromisso
                                  + 1;
      END LOOP;

      IF  v_qtd_pre_compromisso = 1 AND v_sucesso = 0
      THEN
         FOR cur IN pre (:NEW.cnt_cre_cod)
         LOOP
            BEGIN
               UPDATE ifrbde.cad_pre_compromisso
                  SET seq_contrato = :NEW.num_seq_contrato,
                      num_situacao_pre_compromisso = '3'
                WHERE  CURRENT OF pre;
            EXCEPTION
               WHEN OTHERS
               THEN
                  v_erro :=
                           'Erro ao Atualizar o Pre-Compromisso do Contrato - '
                        || SQLERRM;
                  v_sucesso := 1;
            END;
         END LOOP;
      END IF;
   
--
   END IF;

   
--
   IF v_sucesso = 1
   THEN
      raise_application_error (-20100, v_erro);
   END IF;
END;
/

