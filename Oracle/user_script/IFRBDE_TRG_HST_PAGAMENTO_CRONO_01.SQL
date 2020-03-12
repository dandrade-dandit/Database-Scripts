CREATE OR REPLACE TRIGGER TRG_HST_PAGAMENTO_CRONO_01
 BEFORE 
 INSERT OR DELETE OR UPDATE
 ON HST_PAGAMENTO_CRONOGRAMA
 REFERENCING OLD AS OLD NEW AS NEW
 FOR EACH ROW 
DECLARE
   v_erro        VARCHAR2 (200);
   v_sucesso     NUMBER (1);
   v_val_saldo   NUMBER (12, 2);
BEGIN
   v_sucesso := 0;
   v_erro := '';

   IF INSERTING
   THEN
      BEGIN
         SELECT val_saldo_crono
           INTO v_val_saldo
           FROM ifrbde.tab_cont_crono_pagamento
          WHERE num_seq_cronograma = :NEW.num_seq_cronograma_hst;
      EXCEPTION
         WHEN OTHERS
         THEN
            v_erro :=    'Não foi possível localizar o cronograma - Inclusão'
                      || SQLERRM;
            v_sucesso := 1;
      END;

      IF  v_sucesso = 0 AND :NEW.tip_historico_pagamento = 'P'
      THEN
         BEGIN
            UPDATE ifrbde.tab_cont_crono_pagamento
               SET val_saldo_crono =   NVL (val_saldo_crono, 0)
                                     - NVL (:NEW.val_retirado_hst, 0),
                   val_saldo_crono_sec =   NVL (val_saldo_crono_sec, 0)
                                         - NVL (:NEW.val_retirado_sec_hst, 0)
             WHERE num_seq_cronograma = :NEW.num_seq_cronograma_hst;
         EXCEPTION
            WHEN OTHERS
            THEN
               v_erro :=
                        'Erro ao atualizar o cronograma - Inclusão'
                     || SQLERRM;
               v_sucesso := 1;
         END;
      END IF;
   END IF;

   IF DELETING
   THEN
      BEGIN
         SELECT val_saldo_crono
           INTO v_val_saldo
           FROM ifrbde.tab_cont_crono_pagamento
          WHERE num_seq_cronograma = :OLD.num_seq_cronograma_hst;
      EXCEPTION
         WHEN OTHERS
         THEN
            v_erro :=    'Não foi possível localizar o cronograma - Exclusão'
                      || SQLERRM;
            v_sucesso := 1;
      END;

      IF  v_sucesso = 0 AND :OLD.tip_historico_pagamento = 'P'
      THEN
         BEGIN
            UPDATE ifrbde.tab_cont_crono_pagamento
               SET val_saldo_crono =   NVL (val_saldo_crono, 0)
                                     + NVL (:OLD.val_retirado_hst, 0),
                   val_saldo_crono_sec =   NVL (val_saldo_crono_sec, 0)
                                         + NVL (:OLD.val_retirado_sec_hst, 0)
             WHERE num_seq_cronograma = :OLD.num_seq_cronograma_hst;
         EXCEPTION
            WHEN OTHERS
            THEN
               v_erro :=
                        'Erro ao atualizar o cronograma - Exclusão'
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
