CREATE OR REPLACE TRIGGER TRG_TAB_CARENCIA_01
 BEFORE 
 INSERT OR DELETE OR UPDATE
 ON TAB_CARENCIA
 REFERENCING OLD AS OLD NEW AS NEW
 FOR EACH ROW 
DECLARE
   v_erro           VARCHAR2 (200);
   v_sucesso        NUMBER (1);
-- totais
   tot_valor_pago   NUMBER (12, 2);
BEGIN
   v_sucesso := 0;
   v_erro := '';
   tot_valor_pago := 0;
--   

   IF    INSERTING
      OR UPDATING
   THEN
      :NEW.cre_vlobras := NVL (:NEW.cre_vlobras, 0);
      :NEW.cre_total_pago := NVL (:NEW.cre_total_pago, 0);

      IF :NEW.cre_vlobras = 0
      THEN
         v_erro :=
                   'O Valor Proposta da Carência não pode ser Zero'
                || SQLERRM;
         v_sucesso := 1;
      END IF;

      IF v_sucesso = 0
      THEN
         tot_valor_pago := 0;
         BEGIN
            SELECT SUM (NVL (rap_valor_pago, 0))
              INTO tot_valor_pago
              FROM IFRBDE.tab_rec_aprovado
             WHERE rap_cre_cod = :NEW.cre_cod;

            :NEW.cre_total_pago := NVL (tot_valor_pago, 0);
         EXCEPTION
            WHEN NO_DATA_FOUND
            THEN
               :NEW.cre_total_pago := 0;
            WHEN OTHERS
            THEN
               v_erro :=    'Erro ao totalizar o valor faturado da carência'
                         || SQLERRM;
               v_sucesso := 1;
         END;
      END IF;
   END IF;
--
   IF v_sucesso <> 0
   THEN
      raise_application_error (-20100, v_erro);
   END IF;
END;
/
