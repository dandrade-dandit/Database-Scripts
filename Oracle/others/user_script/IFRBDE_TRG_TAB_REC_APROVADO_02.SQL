CREATE OR REPLACE TRIGGER TRG_TAB_REC_APROVADO_02
 BEFORE 
 INSERT OR UPDATE OF RAP_VALOR_PAGO, VAL_CRONOGRAMADO
 ON TAB_REC_APROVADO
 REFERENCING OLD AS OLD NEW AS NEW
 FOR EACH ROW 
DECLARE
   v_erro             VARCHAR2 (200);
   v_sucesso          NUMBER (1);
   
--   
-- Totais do recurso
--
   tot_val_faturado       NUMBER (12, 2);
   tot_val_cronogramado   NUMBER (12, 2);
BEGIN
   v_sucesso := 0;
   v_erro := '';
   tot_val_faturado := 0;

   IF    INSERTING
      OR UPDATING
   THEN
      
--
      BEGIN
         SELECT SUM (NVL (a.val_faturado, 0))
           INTO tot_val_faturado
           FROM ifrbde.cad_pagamento_contrato a,
                ifrbde.cad_resumo_valores b,
                ifrbde.tab_contrato c
          WHERE a.cod_tipo_pag IN ('P', 'D', 'R')
            AND a.num_seq_resumo_contrato = b.num_seq_resumo
            AND b.num_seq_contrato_res = c.num_seq_contrato
            AND c.cnt_cre_cod = :NEW.rap_cre_cod
            AND a.cod_recurso = :NEW.rap_rti_cod
            AND a.num_ano_pgose = :NEW.rap_pgose;

         :NEW.rap_valor_pago := NVL (tot_val_faturado, 0);
         
      EXCEPTION
         WHEN NO_DATA_FOUND
         THEN
            :NEW.rap_valor_pago := 0;
         WHEN OTHERS
         THEN
            v_erro :=
                     ' Erro ao Calcular o total faturado para este recurso '
                  || :NEW.rap_rti_cod
                  || ' e ano '
                  || :NEW.rap_pgose
                  || ' - '
                  || SQLERRM;
            v_sucesso := 1;
      END;

      
--
      BEGIN
         SELECT SUM (NVL (a.CCP_VALOR, 0))
           INTO tot_val_cronogramado
           FROM ifrbde.tab_cont_crono_pagamento a,
                ifrbde.cad_resumo_valores b,
                ifrbde.tab_contrato c
          WHERE a.TIP_CRONOGRAMA IN ('DE', 'DA', 'RJ')
            AND a.NUM_SEQ_CONTRATO_CRON = b.num_seq_resumo
            AND b.num_seq_contrato_res = c.num_seq_contrato
            AND c.cnt_cre_cod = :NEW.rap_cre_cod
            AND a.CCP_RTI_COD = :NEW.rap_rti_cod
            AND a.CCP_PGOSE = :NEW.rap_pgose;

         :NEW.val_cronogramado := NVL (tot_val_cronogramado, 0);
         
      EXCEPTION
         WHEN NO_DATA_FOUND
         THEN
            :NEW.val_cronogramado := 0;
         WHEN OTHERS
         THEN
            v_erro :=
                     ' Erro ao Calcular o total cronogramado para este recurso '
                  || :NEW.rap_rti_cod
                  || ' e ano '
                  || :NEW.rap_pgose
                  || ' - '
                  || SQLERRM;
            v_sucesso := 1;
      END;
--

      :NEW.val_saldo_recurso :=
                          NVL (:NEW.rap_valor, 0)
                        - NVL (:NEW.rap_valor_pago, 0);

      IF :NEW.val_saldo_recurso < 0
      THEN
         v_erro := 'O Saldo do Recurso da Carência não pode ser negativo - Carência : '
         ||To_char(:new.rap_cre_cod)||' - ano : '||:new.rap_pgose||' - aprovado : '
         ||to_char(:NEW.rap_valor)||' - faturado : '||to_char(:NEW.rap_valor_pago);
         v_sucesso := 1;
      END IF;
/*
      IF :NEW.rap_valor < :new.val_cronogramado and v_sucesso = 0 
      THEN
         v_erro := 'O Total cronogramado é superior ao valor aprovado para o Recurso e Ano da Carência';
         v_sucesso := 1;
      END IF;
*/
--                  

   END IF;

   IF v_sucesso <> 0
   THEN
      raise_application_error (-20100, v_erro);
   END IF;
END;
/
