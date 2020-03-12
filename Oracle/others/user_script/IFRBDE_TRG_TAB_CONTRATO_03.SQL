CREATE OR REPLACE TRIGGER TRG_TAB_CONTRATO_03
 BEFORE 
 INSERT OR UPDATE OF CNT_VALOR, CNT_VALOR_COMPROMISSO, CNT_VALOR_PAGO, CNT_VALOR_REAJ, CNT_VALOR_REAJ_PAGO, CNT_VALOR_TERMO
 ON TAB_CONTRATO
 REFERENCING OLD AS OLD NEW AS NEW
 FOR EACH ROW 
DECLARE
   v_erro                  VARCHAR2 (200);
   v_sucesso               NUMBER (1);
   v_cre_dep_cod           IFRBDE.tab_contrato.cod_dep_contrato%TYPE;
   v_saldo_ano             IFRBDE.tab_rec_aprovado.val_saldo_recurso%TYPE;
   v_contrato_id           VARCHAR2 (30);
   
--   
-- Totais para o contrato
--
   tot_val_resumo          NUMBER (12, 2);
   tot_val_termo           NUMBER (12, 2);
   tot_val_reajuste        NUMBER (12, 2);
   tot_val_pago_reajuste   NUMBER (12, 2);
   tot_val_pago            NUMBER (12, 2);
BEGIN
   v_sucesso := 0;
   v_erro := '';
   tot_val_resumo := 0;
   tot_val_termo := 0;
   tot_val_reajuste := 0;
   tot_val_pago_reajuste := 0;
   tot_val_pago := 0;

   IF    INSERTING
      OR UPDATING
   THEN
      
--
      BEGIN
         SELECT SUM (NVL (val_resumo, 0)), SUM (NVL (val_termo, 0)),
                SUM (NVL (val_pago_reajuste, 0)), SUM (NVL (val_pago, 0)),
                SUM (NVL (val_reajuste, 0))
           INTO tot_val_resumo, tot_val_termo,
                tot_val_pago_reajuste, tot_val_pago,
                tot_val_reajuste
           FROM IFRBDE.cad_resumo_valores
          WHERE num_seq_contrato_res = :NEW.num_seq_contrato;
      EXCEPTION
         WHEN OTHERS
         THEN
            v_erro :=    'Erro ao Calcular os valores do Contrato'
                      || SQLERRM;
            v_sucesso := 1;
      END;

      
--
-- coloca o somatorio nas variaveis correspondentes --
--
--
      :NEW.cnt_valor_compromisso := NVL (tot_val_resumo, 0);
      :NEW.cnt_valor := NVL (:NEW.cnt_valor, 0);
      :NEW.cnt_valor_termo := NVL (tot_val_termo, 0);
      :NEW.cnt_valor_reaj := NVL (tot_val_reajuste, 0);
      :NEW.cnt_valor_reaj_pago := NVL (tot_val_pago_reajuste, 0);
      :NEW.cnt_valor_pago := NVL (tot_val_pago, 0);
      
--
-- calcula o saldo do contrato
--  
      :NEW.cnt_valor :=   NVL (:NEW.cnt_valor_compromisso, 0)
                        + NVL (:NEW.cnt_valor_termo, 0)
                        - NVL (:NEW.cnt_valor_pago, 0);

      
--
--                        - NVL (:NEW.cnt_valor_reaj_pago,0)
--
      IF  :NEW.cnt_valor < 0 AND :NEW.num_seq_contrato NOT IN
                                                             (211, 1790, 419)
      THEN
         v_erro := 'O Saldo do Contrato não pode ser negativo';
         v_sucesso := 1;
      END IF;

      
--
--
--
      IF :NEW.cnt_valor_compromisso < 0
      THEN
         v_erro := 'Valor do contrato não pode ser negativo';
         v_sucesso := 1;
      END IF;
   
--                  
   END IF;
--
   IF v_sucesso <> 0
   THEN
      raise_application_error (-20100, v_erro);
   END IF;
END;
/
