-- Start of DDL Script for Trigger IFRBDE.TRG_TAB_REC_APROVADO_01
-- Generated 2-dez-2004 20:25:14 from SYSMAN@HOMOLOG2

CREATE OR REPLACE TRIGGER ifrbde.trg_tab_rec_aprovado_01
BEFORE INSERT  OR UPDATE OF 
  rap_pgose,
  rap_valor,
  rap_cre_cod,
  rap_cre_pgi,
  rap_rti_cod,
 OR  DELETE 
ON ifrbde.tab_rec_aprovado
REFERENCING NEW AS NEW OLD AS OLD
FOR EACH ROW
DECLARE
   v_erro       VARCHAR2 (200);
   v_sucesso    NUMBER (1);
   v_situacao   ifrbde.tab_carencia.num_situacao_carencia%TYPE;
BEGIN
   v_sucesso := 0;
   v_erro := '';

   IF INSERTING OR UPDATING
   THEN
      ifrbde.pck_variaveis.v_pck_seq_carencia_aprovada :=
                                                    NVL (:NEW.rap_cre_cod, 0);

      IF :NEW.rap_valor < 0
      THEN
         v_erro := 'Valor do Recurso da Carência não pode ser negativo';
         v_sucesso := 1;
      END IF;

      IF :NEW.rap_valor_pago IS NULL
      THEN
         :NEW.rap_valor_pago := 0;
      END IF;

      IF :NEW.val_cronogramado IS NULL
      THEN
         :NEW.val_cronogramado := 0;
      END IF;

      IF :NEW.val_remanejado_recebido IS NULL
      THEN
         :NEW.val_remanejado_recebido := 0;
      END IF;

      IF :NEW.val_remanejado_enviado IS NULL
      THEN
         :NEW.val_remanejado_enviado := 0;
      END IF;

      :NEW.val_saldo_recurso :=
                         NVL (:NEW.rap_valor, 0)
                         - NVL (:NEW.rap_valor_pago, 0);

      --                               - NVL (:NEW.val_remanejado_enviado, 0)
      --                               + NVL (:NEW.val_remanejado_recebido, 0);
      IF :NEW.val_saldo_recurso < 0
      THEN
         v_erro := 'Com o valor da aprovação igual a '||
		 to_char(:NEW.rap_valor)||' e valor total faturado igual a '||
		 to_char(:NEW.rap_valor_pago)||', o saldo do recurso na Carência ficará negativo. Solicite valor inferior para que não fique negativo';
         v_sucesso := 1;
      END IF;
/*   IF v_sucesso = 0
   THEN
        ifrbde.prc_gravar_rel_quinquenal (
         :new.rap_cre_cod,
         :new.rap_rti_cod,
         :new.rap_pgose,
         :new.rap_valor
      );
   END IF;
*/
--
--
/*
      BEGIN
         SELECT num_situacao_carencia
           INTO v_situacao
           FROM ifrbde.tab_carencia
          WHERE cre_cod = :NEW.rap_cre_cod;


--
         IF v_situacao NOT IN (1, 2)
         THEN
            IF INSERTING
            THEN
               v_erro :=
                     'Carência não esta em situação para cadastrar ou alterar a aprovação';
               v_sucesso := 1;
            ELSE
               IF      :NEW.val_remanejado_recebido =
                                                 :OLD.val_remanejado_recebido
                   AND :NEW.val_remanejado_enviado =
                                                  :OLD.val_remanejado_enviado
               THEN
                  v_erro :=
                        'Carência não esta em situação para cadastrar ou alterar a aprovação';
                  v_sucesso := 1;
               END IF;
            END IF;
         END IF;

--
      EXCEPTION
         WHEN OTHERS
         THEN
            v_erro :=
                      'Erro ao verificar a situação da Carência - '
                   || SQLERRM;
            v_sucesso := 1;
      END;
*/
--

   --
   END IF;

   IF UPDATING AND v_sucesso = 0
   THEN
      IF :NEW.rap_pgose <> :OLD.rap_pgose AND NVL (:OLD.rap_valor_pago, 0) >
                                                                            0
      THEN
         v_erro :=
               'Existem Faturas para este Ano e Recurso - Modificação de Ano';
         v_sucesso := 1;
      END IF;

      IF     :NEW.rap_rti_cod <> :OLD.rap_rti_cod
         AND NVL (:OLD.rap_valor_pago, 0) > 0
      THEN
         v_erro :=
            'Existem Faturas para este Ano e Recurso - Modificação de Recurso';
         v_sucesso := 1;
      END IF;
--
   END IF;

   IF DELETING
   THEN
      ifrbde.pck_variaveis.v_pck_seq_carencia_aprovada :=
                                                    NVL (:OLD.rap_cre_cod, 0);

      IF NVL (:OLD.rap_valor_pago, 0) > 0
      THEN
         v_erro :=
            'Este recurso já foi utilizado para pagamento e não pode ser excluido';
         v_sucesso := 1;
      END IF;

/*
-- retirado por solicitação do sr. benedito lima no dia 03/09/2003

     IF NVL(:OLD.val_cronogramado, 0 ) > 0
      THEN
         v_erro := 'Este recurso já foi utilizado no cronograma para pagamento e não pode ser excluido';
         v_sucesso := 1;
      END IF;


   IF v_sucesso = 0
   THEN
        ifrbde.prc_gravar_rel_quinquenal (
         :old.rap_cre_cod,
         :old.rap_rti_cod,
         :old.rap_pgose,
         0
      );
   END IF;
*/
--
      BEGIN
         SELECT num_situacao_carencia
           INTO v_situacao
           FROM ifrbde.tab_carencia
          WHERE cre_cod = :OLD.rap_cre_cod;

--
         IF v_situacao NOT IN (1, 2) AND NVL (:OLD.rap_valor_pago, 0) > 0
         THEN
            v_erro :=
                     'Carência não esta em situação para Excluir a aprovação';
            v_sucesso := 1;
         END IF;
--
      EXCEPTION
         WHEN OTHERS
         THEN
            v_erro :=
                  'Erro ao verificar a situação da Carência (exclusão) - '
               || SQLERRM;
            v_sucesso := 1;
      END;
--
   END IF;

   IF v_sucesso <> 0
   THEN
      raise_application_error (-20100, v_erro);
   END IF;
END;
/

-- End of DDL Script for Trigger IFRBDE.TRG_TAB_REC_APROVADO_01

