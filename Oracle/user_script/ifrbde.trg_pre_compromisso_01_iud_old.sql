/* Formatted on 2005/01/10 15:27 (Formatter Plus v4.5.2) */
-- Start of DDL Script for Trigger IFRBDE.TRG_PRE_COMPROMISSO_01_IUD
-- Generated 2-dez-2004 20:24:30 from SYSMAN@HOMOLOG2

CREATE OR REPLACE TRIGGER ifrbde.trg_pre_compromisso_01_iud
   BEFORE INSERT OR UPDATE OF flg_risco,
                              num_inciso,
                              flg_execucao,
                              num_processo,
                              tax_execucao,
                              tax_garantia,
                              num_licitacao,
                              dsc_local_entrega,
                              num_ano_licitacao,
                              num_prazo_execucao,
                              dat_pre_compromisso,
                              num_forma_pagamento,
                              num_regime_execucao,
                              val_pre_compromisso,
                              dsc_fundamento_legal,
                              cod_modalidade_licitacao,
                              num_prazo_execucao_contrato OR DELETE
   ON ifrbde.cad_pre_compromisso
   REFERENCING NEW AS NEW OLD AS OLD
   FOR EACH ROW
DECLARE
   v_erro                        VARCHAR2 (200);
   v_sucesso                     NUMBER (1);
   v_situacao                    ifrbde.tab_carencia.num_situacao_carencia%TYPE;
   v_rap_valor                   ifrbde.tab_rec_aprovado.rap_valor%TYPE;
BEGIN
   v_sucesso := 0;
   v_erro := '';

   IF INSERTING
   THEN
      ifrbde.pck_variaveis.v_pck_seq_carencia_aprovada :=
                                                   NVL (
                                                      :NEW.seq_carencia,
                                                      0
                                                   );
      :NEW.num_situacao_pre_compromisso := 1;
   END IF;

   IF    INSERTING
      OR UPDATING
   THEN
      ifrbde.pck_variaveis.v_pck_seq_carencia_aprovada :=
                                                   NVL (
                                                      :NEW.seq_carencia,
                                                      0
                                                   );

      BEGIN
         SELECT num_situacao_carencia
           INTO v_situacao
           FROM ifrbde.tab_carencia
          WHERE cre_cod = :NEW.seq_carencia;

         IF INSERTING
         THEN
            IF v_situacao <> 2
            THEN
               v_erro :=
                     'A Carência não encontra-se em situação de inclusão do Pré-Compromisso !!!! ';
               v_sucesso := 1;
            END IF;
         END IF;
      EXCEPTION
         WHEN OTHERS
         THEN
            v_erro :=
                      'Erro ao verificar a situação da Carência - '
                   || SQLERRM;
            v_sucesso := 1;
      END;

      IF UPDATING
      THEN
         BEGIN
            SELECT num_situacao_carencia
              INTO v_situacao
              FROM ifrbde.tab_carencia
             WHERE cre_cod = :NEW.seq_carencia;

            IF v_situacao <> 3
            THEN
               v_erro :=
                     'A Carência não encontra-se em situação de alteração do Pré-Compromisso !!!! ';
               v_sucesso := 1;
            END IF;
         EXCEPTION
            WHEN OTHERS
            THEN
               v_erro :=
                      'Erro ao verificar a situação da Carência - '
                   || SQLERRM;
               v_sucesso := 1;
         END;
      END IF;

      IF      v_sucesso = 0
          AND :NEW.num_situacao_pre_compromisso <> 1
          AND (   :NEW.num_forma_pagamento <> :OLD.num_forma_pagamento
               OR :NEW.num_regime_execucao <> :OLD.num_regime_execucao
               OR :NEW.flg_risco <> :OLD.flg_risco
               OR :NEW.tax_garantia <> :OLD.tax_garantia
               OR :NEW.flg_execucao <> :OLD.flg_execucao
               OR :NEW.tax_execucao <> :OLD.tax_execucao
               OR :NEW.dsc_local_entrega <> :OLD.dsc_local_entrega
               OR :NEW.cod_modalidade_licitacao <>
                                                 :OLD.cod_modalidade_licitacao
               OR :NEW.num_inciso <> :OLD.num_inciso
               OR :NEW.dsc_fundamento_legal <> :OLD.dsc_fundamento_legal
               OR :NEW.num_licitacao <> :OLD.num_licitacao
               OR :NEW.num_ano_licitacao <> :OLD.num_ano_licitacao
               OR :NEW.num_processo <> :OLD.num_processo
               OR :NEW.val_pre_compromisso <> :OLD.val_pre_compromisso
               OR :NEW.num_prazo_execucao_contrato <>
                                              :OLD.num_prazo_execucao_contrato
               OR :NEW.num_prazo_execucao <> :OLD.num_prazo_execucao
               OR :NEW.dat_pre_compromisso <> :OLD.dat_pre_compromisso
              )
      THEN
         v_erro :=
               'O Pré-compromisso não esta na situação de Incluido - os dados não podem ser modificados';
         v_sucesso := 1;
      END IF;

      -- Verifica Dados da Licitação
      IF    INSERTING
         OR UPDATING
      THEN
         IF v_sucesso = 0
         THEN
            BEGIN
               SELECT SUM (
                         rap_valor
                      )
                 INTO v_rap_valor
                 FROM ifrbde.tab_rec_aprovado
                WHERE rap_cre_cod = :NEW.seq_carencia
                  AND rap_pgose >= TO_CHAR (
                                      :NEW.dat_pre_compromisso,
                                      'YYYY'
                                   );

               
--
               IF v_rap_valor < :NEW.val_pre_compromisso
               THEN
                  v_erro :=    'O valor aprovado de '
                            || TO_CHAR (
                                  v_rap_valor
                               )
                            || ' a partir de '
                            || TO_CHAR (
                                  :NEW.dat_pre_compromisso,
                                  'YYYY'
                               )
                            || ' é menor que o valor pré-compromissado de '
                            || TO_CHAR (
                                  :NEW.val_pre_compromisso
                               )
                            || ' !!!! ';
                  v_sucesso := 1;
               END IF;
            EXCEPTION
               WHEN OTHERS
               THEN
                  v_erro :=    'Erro ao verificar a situação da Carência - '
                            || SQLERRM;
                  v_sucesso := 1;
            END;
         END IF;

         IF v_sucesso = 0
         THEN
            IF      UPPER (
                       :NEW.cod_modalidade_licitacao
                    ) <> 'DISP'
                AND UPPER (
                       :NEW.cod_modalidade_licitacao
                    ) <> 'INEX'
            THEN
               IF    (:NEW.dsc_fundamento_legal IS NULL)
                  OR (:NEW.num_licitacao IS NULL)
                  OR (:NEW.num_ano_licitacao IS NULL)
                  OR (:NEW.num_processo IS NULL)
                  OR (:NEW.num_inciso IS NOT NULL)
               THEN
                  v_erro :=
                           v_erro
                        || ' - Pré - Compromisso - As informações dos Dados da Licitação são obrigatórios - Não informar apenas o Inciso';
                  v_sucesso := 1;
               END IF;
            END IF;

            IF    UPPER (
                     :NEW.cod_modalidade_licitacao
                  ) = 'DISP'
               OR UPPER (
                     :NEW.cod_modalidade_licitacao
                  ) = 'INEX'
            THEN
               IF    (:NEW.dsc_fundamento_legal IS NOT NULL)
                  OR (:NEW.num_licitacao IS NOT NULL)
                  OR (:NEW.num_ano_licitacao IS NOT NULL)
                  OR (:NEW.num_processo IS NOT NULL)
                  OR (:NEW.num_inciso IS NULL)
               THEN
                  v_erro :=
                           v_erro
                        || ' - Pré - Compromisso - As informações dos Dados da Licitação para modalidade "Dispensa" ou "Inexigibilidade" não são preenchidos - somente Inciso ';
                  v_sucesso := 1;
               END IF;
            END IF;
         END IF;

         IF v_sucesso = 0
         THEN
            IF :NEW.flg_risco = '1'
            THEN
               :NEW.tax_garantia := 100;
            ELSE
               :NEW.tax_garantia := 0;
            END IF;
         END IF;
      END IF;
   
--
   END IF;

   
--
   IF DELETING
   THEN
      v_sucesso := 1;
      v_erro := 'A exclusão do Pré-Compromisso não é permitida !!!';
   END IF;

   
--
   IF v_sucesso <> 0
   THEN
      raise_application_error (
         -20100,
         v_erro
      );
   END IF;
--
END;
/

-- End of DDL Script for Trigger IFRBDE.TRG_PRE_COMPROMISSO_01_IUD

