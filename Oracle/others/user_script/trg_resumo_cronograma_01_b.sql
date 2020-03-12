/* Formatted on 2005/02/18 14:49 (Formatter Plus v4.5.2) */
CREATE OR REPLACE TRIGGER ifrbde.trg_resumo_cronograma_01_b
   BEFORE INSERT OR UPDATE OF dat_moeda_rc,
                              tip_cotacao_rc,
                              val_cotacao_rc,
                              val_resumo_crno,
                              tip_resumo_crono,
                              dat_vencimento_rc OR DELETE
   ON ifrbde.cad_resumo_cronograma
   REFERENCING NEW AS NEW OLD AS OLD
   FOR EACH ROW
DECLARE
   v_erro                    VARCHAR2 (200);
   v_sucesso                 NUMBER (1);
   v_moeda_sec               NUMBER (12, 2);
   v_val_resumo              ifrbde.cad_resumo_valores.val_resumo%TYPE;
   v_tip_situacao_contrato   ifrbde.tab_contrato.tip_situacao_contrato%TYPE;
   v_num_seq_contrato        ifrbde.tab_contrato.num_seq_contrato%TYPE;
   v_flg_moeda_controle      ifrbde.cad_resumo_valores.flg_moeda_controle%TYPE;
   v_carencia                ifrbde.tab_contrato.cnt_cre_cod%TYPE;
--   v_recurso                 ifrbde.tab_rec_aprovado.val_saldo_recurso%TYPE;
BEGIN
   v_sucesso := 0;
   v_erro := '';

   IF    INSERTING
      OR UPDATING
   THEN
      :NEW.dat_vencimento_st := :NEW.dat_vencimento_rc;
      :NEW.val_moeda_sec_rc := 0;

      
--
      BEGIN
         SELECT b.tip_situacao_contrato, b.num_seq_contrato,
                a.flg_moeda_controle, b.cnt_cre_cod
           INTO v_tip_situacao_contrato, v_num_seq_contrato,
                v_flg_moeda_controle, v_carencia
           FROM ifrbde.cad_resumo_valores a, ifrbde.tab_contrato b
          WHERE a.num_seq_resumo = :NEW.num_seq_contrato_rc
            AND a.num_seq_contrato_res = b.num_seq_contrato;
      EXCEPTION
         WHEN OTHERS
         THEN
            v_erro :=
                     'Inclusão ou de Cronograma - Resumo do cronograma ou contrato não foi encontrato !!!! '
                  || SQLERRM;
            v_sucesso := 1;
      END;

      
--      

      IF TO_DATE (TO_CHAR (:NEW.dat_vencimento_rc, 'dd/mm/yyyy'), 'dd/mm/yyyy') <
                         TO_DATE (TO_CHAR (SYSDATE, 'dd/mm/yyyy'), 'dd/mm/yyyy')
      THEN
         
--
         IF :NEW.num_seq_resumo_pag IS NULL
         THEN
            v_erro :=
                     'A data de realização do cronograma não pode ser menor do que '
                  || TO_CHAR (SYSDATE, 'dd/mm/yyyy');
            v_sucesso := 1;
         END IF;
      ELSE
         IF :NEW.ano_realizacao IS NULL
         THEN
            IF      TO_NUMBER (TO_CHAR (:NEW.dat_vencimento_rc, 'dd')) >= 1
                AND TO_NUMBER (TO_CHAR (:NEW.dat_vencimento_rc, 'dd')) <= 15
                AND TO_NUMBER (TO_CHAR (:NEW.dat_vencimento_rc, 'mm')) = 1
                AND TO_NUMBER (TO_CHAR (:NEW.dat_vencimento_rc, 'yyyy')) >
                                                                         2003
            THEN
               :NEW.ano_realizacao :=
                     TO_CHAR (
                          TO_NUMBER (TO_CHAR (:NEW.dat_vencimento_rc, 'yyyy'))
                        - 1
                     );
            ELSE
               :NEW.ano_realizacao := TO_CHAR (:NEW.dat_vencimento_rc, 'yyyy');
            END IF;
         END IF;
      END IF;

      
--
--
-- variaveis para recalculo do cronograma em carencia e resumo
--
      IF v_sucesso = 0
      THEN
         ifrbde.pck_variaveis.v_pck_num_seq_carencia_cron := v_carencia;
         ifrbde.pck_variaveis.v_pck_num_ano_pgose_cron := :NEW.ano_realizacao;
         ifrbde.pck_variaveis.v_pck_num_seq_contrato_cron :=
                                                     :NEW.num_seq_contrato_rc;
      END IF;

      
--

      IF  :NEW.tip_resumo_crono = 'LR' AND v_sucesso = 0
      THEN
         v_erro :=
                'Este tipo de Cronograma não pode ser incluido no realizado ';
         v_sucesso := 1;
      END IF;

      
--
-- verifica qual tipo de moeda a do resumo
--
      v_moeda_sec := 0;

      IF  v_flg_moeda_controle = 2 AND v_sucesso = 0
      THEN
         IF    :NEW.dat_moeda_rc IS NULL
            OR NVL (:NEW.val_cotacao_rc, 0) = 0
         THEN
            v_erro := 'Favor informar dados referente a Moeda Secudária. ';
            v_sucesso := 1;
         ELSE
            :NEW.val_moeda_sec_rc :=
                   NVL (:NEW.val_resumo_crno, 0) / NVL (
                                                      :NEW.val_cotacao_rc,
                                                      1
                                                   );
         END IF;
      END IF;
   END IF;

   IF  UPDATING AND v_sucesso = 0
   THEN
      
--
      IF :NEW.num_seq_resumo_pag IS NOT NULL
      THEN
         v_erro :=
               ' Registro não poder alterado , pois cronograma tem numero de Fatura ';
         v_sucesso := 1;
      END IF;

      
--
      IF  :OLD.tip_resumo_crono <> :NEW.tip_resumo_crono AND v_sucesso = 0
      THEN
         v_erro :=
               'O Tipo de cronograma não pode ser modificado - Exclua o registro e redigite novamente ';
         v_sucesso := 1;
      END IF;
   
--
   END IF;

   
--
   IF DELETING
   THEN
      IF v_sucesso = 0
      THEN
         BEGIN
            SELECT b.tip_situacao_contrato, b.num_seq_contrato,
                   a.flg_moeda_controle, b.cnt_cre_cod
              INTO v_tip_situacao_contrato, v_num_seq_contrato,
                   v_flg_moeda_controle, v_carencia
              FROM ifrbde.cad_resumo_valores a, ifrbde.tab_contrato b
             WHERE a.num_seq_resumo = :OLD.num_seq_contrato_rc
               AND a.num_seq_contrato_res = b.num_seq_contrato;
         EXCEPTION
            WHEN OTHERS
            THEN
               v_erro :=
                        'Exclusão de Cronograma - Resumo do cronograma ou contrato não foi encontrato !!!! '
                     || SQLERRM;
               v_sucesso := 1;
         END;
      END IF;

      
--
--
      IF :OLD.num_seq_resumo_pag IS NOT NULL
      THEN
         v_erro :=
               ' Registro não pode Excluido , pois cronograma tem numero de Fatura , Exclua a fatura primeiro ';
         v_sucesso := 1;
      END IF;

      
--
--
-- variaveis para recalculo do cronograma em carencia e resumo
--
      IF v_sucesso = 0
      THEN
         ifrbde.pck_variaveis.v_pck_num_seq_carencia_cron := v_carencia;
         ifrbde.pck_variaveis.v_pck_num_ano_pgose_cron := :OLD.ano_realizacao;
         ifrbde.pck_variaveis.v_pck_num_seq_contrato_cron :=
                                                           v_num_seq_contrato;
      END IF;
   
--
   END IF;

   IF v_sucesso <> 0
   THEN
      raise_application_error (-20100, v_erro);
   END IF;
END;
/

-- End of DDL Script for Trigger IFRBDE.TRG_RESUMO_CRONOGRAMA_01_B

