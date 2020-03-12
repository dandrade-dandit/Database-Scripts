/* Formatted on 2005/05/16 10:14 (Formatter Plus v4.5.2) */
CREATE OR REPLACE TRIGGER ifrbde.trg_tab_cont_termo_aditivo_01
   BEFORE INSERT OR UPDATE OF cta_num,
                              cta_prazo,
                              cta_valor,
                              cta_objeto,
                              cta_aum_dim,
                              cta_periodo,
                              dat_periodo,
                              cta_deb_cred,
                              dat_moeda_ta,
                              val_moeda_ta,
                              tip_cotacao_moeda OR DELETE
   ON ifrbde.tab_cont_termo_aditivo
   REFERENCING NEW AS NEW OLD AS OLD
   FOR EACH ROW
DECLARE
   v_erro                      VARCHAR2 (400);
   v_sucesso                   NUMBER (1);
   v_saldo_recurso             NUMBER (18, 2);
   v_termo_sec                 NUMBER (18, 2);
   v_termo_old_sec             NUMBER (18, 2);
   v_num_seq_resumo            NUMBER (15);
   v_resumos                   NUMBER (6);
   v_contrato_id               VARCHAR2 (30);
   v_flg_moeda_controle        VARCHAR2 (1);
   v_num_versao_contrato_res   VARCHAR2 (2);
BEGIN
   v_erro := '';
   v_sucesso := 0;
   v_termo_sec := 0;
   v_termo_old_sec := 0;

   
--
--

   IF UPDATING
   THEN
      
--
-- copia a data para classificação do programa
--
      :NEW.dat_periodo := :NEW.cta_periodo;

      
--
-- criticas do aditivo de Contrato
--
      IF :NEW.cta_valor < 0
      THEN
         v_erro :=
               'O Valor do Aditivo não pode ser negativo, escolha o tipo Credito ou Debito';
         v_sucesso := 1;
      END IF;

      IF  (:NEW.cta_periodo <> :OLD.cta_periodo) AND v_sucesso = 0
      THEN
         v_erro :=    'O campo data não pode ser modificado.'
                   || '......... Alteração - '
                   || ' data : '
                   || TO_CHAR (:NEW.cta_periodo)
                   || '......... Antigo    - '
                   || ' data : '
                   || TO_CHAR (:OLD.cta_periodo)
                   || '.......................................';
         v_sucesso := 1;
      END IF;

      IF  (TRIM (:NEW.cta_num) <> TRIM (:OLD.cta_num)) AND v_sucesso = 0
      THEN
         v_erro :=    'O campo Numero TA não pode ser modificado.'
                   || '......... Alteração - '
                   || ' Numero TA :'
                   || TRIM (:NEW.cta_num)
                   || '......... Antigo    - '
                   || ' Numero TA :'
                   || TRIM (:OLD.cta_num)
                   || '.......................................';
         v_sucesso := 1;
      END IF;
   
/*
      IF (trim(:NEW.cta_objeto) <> trim(:OLD.cta_objeto)) and v_sucesso = 0
      THEN
         v_erro :=
               'O campo Objeto do TA não pode ser modificado.'
               ||'......... Alteração - '
               ||' Objeto : '||trim(:NEW.cta_objeto)
               ||'......... Antigo    - '
               ||' Objeto : '||trim(:old.cta_objeto)
               ||'.......................................';
         v_sucesso := 1;
      END IF;
*/

--
   END IF;

   IF  UPDATING AND v_sucesso = 0
   THEN
      
--
      BEGIN
         SELECT flg_moeda_controle, num_versao_contrato_res
           INTO v_flg_moeda_controle, v_num_versao_contrato_res
           FROM ifrbde.cad_resumo_valores
          WHERE num_seq_resumo = :NEW.num_seq_resumo_ta;

         IF v_flg_moeda_controle = '2'
         THEN
            IF :NEW.val_moeda_ta <> 0
            THEN
               v_termo_sec := :NEW.cta_valor / :NEW.val_moeda_ta;
               v_termo_old_sec := :OLD.cta_valor / :OLD.val_moeda_ta;
            ELSE
               v_erro :=
                    'O Valor da Cotação da Moeda , não pode ser zero !!!!!!!';
               v_sucesso := 1;
            END IF;
         ELSE
            :NEW.dat_moeda_ta := SYSDATE;
            :NEW.val_moeda_ta := 1;
            :NEW.tip_cotacao_moeda := 'V';
         END IF;

         IF      v_num_versao_contrato_res <> :NEW.num_versao_contrato_vta
             AND v_sucesso = 0
         THEN
            v_erro :=
                  'Versão do Termo aditivo é diferente a Versão do Contrato, não pode haver modificações no termo';
            v_sucesso := 1;
         END IF;
      EXCEPTION
         WHEN OTHERS
         THEN
            v_erro :=    'Erro ao verificar o resumo .... '
                      || SQLERRM;
            v_sucesso := 1;
      END;

      
--
      IF  :OLD.cta_deb_cred = 0 AND :NEW.cta_deb_cred = 0 AND v_sucesso = 0
      THEN
         BEGIN
            UPDATE ifrbde.cad_resumo_valores
               SET val_termo =   val_termo
                               - :NEW.cta_valor
                               + :OLD.cta_valor,
                   val_termo_sec =
                                val_termo_sec
                              - v_termo_sec
                              + v_termo_old_sec
             WHERE num_seq_resumo = :NEW.num_seq_resumo_ta;
         EXCEPTION
            WHEN OTHERS
            THEN
               v_erro :=    'Problemas ao debitar o valor - '
                         || SQLERRM;
               v_sucesso := 1;
         END;
      END IF;

      IF  :OLD.cta_deb_cred = 1 AND :NEW.cta_deb_cred = 1 AND v_sucesso = 0
      THEN
         BEGIN
            UPDATE ifrbde.cad_resumo_valores
               SET val_termo =   val_termo
                               - :OLD.cta_valor
                               + :NEW.cta_valor,
                   val_termo_sec =
                                val_termo_sec
                              - v_termo_old_sec
                              + v_termo_sec
             WHERE num_seq_resumo = :NEW.num_seq_resumo_ta;
         EXCEPTION
            WHEN OTHERS
            THEN
               v_erro :=    'Problemas ao creditar o valor - '
                         || SQLERRM;
               v_sucesso := 1;
         END;
      END IF;

      
--
      IF  :OLD.cta_deb_cred = 0 AND :NEW.cta_deb_cred = 1 AND v_sucesso = 0
      THEN
         BEGIN
            UPDATE ifrbde.cad_resumo_valores
               SET val_termo =   val_termo
                               + :NEW.cta_valor
                               + :OLD.cta_valor,
                   val_termo_sec =
                                val_termo_sec
                              + v_termo_sec
                              + v_termo_old_sec
             WHERE num_seq_resumo = :NEW.num_seq_resumo_ta;
         EXCEPTION
            WHEN OTHERS
            THEN
               v_erro :=    'Problemas passar debito para Credito do valor - '
                         || SQLERRM;
               v_sucesso := 1;
         END;
      END IF;

      
--
      IF  :OLD.cta_deb_cred = 1 AND :NEW.cta_deb_cred = 0 AND v_sucesso = 0
      THEN
         BEGIN
            UPDATE ifrbde.cad_resumo_valores
               SET val_termo =   val_termo
                               - :OLD.cta_valor
                               - :NEW.cta_valor,
                   val_termo_sec =
                                val_termo_sec
                              - v_termo_old_sec
                              - v_termo_sec
             WHERE num_seq_resumo = :NEW.num_seq_resumo_ta;
         EXCEPTION
            WHEN OTHERS
            THEN
               v_erro :=    'Problemas ao creditar o valor - '
                         || SQLERRM;
               v_sucesso := 1;
         END;
      END IF;

      
--
      IF  v_sucesso = 0 AND :NEW.cta_valor > 0
      THEN
         v_saldo_recurso := 0;

         BEGIN
            SELECT b.val_saldo_recurso
              INTO v_saldo_recurso
              FROM ifrbde.viw_saldo_carencia_contrato b, ifrbde.tab_contrato a
             WHERE b.num_cre_cod = a.cnt_cre_cod
               AND a.num_seq_contrato = :NEW.num_seq_contrato_termo;

            IF v_saldo_recurso < 0
            THEN
               v_erro :=
                        ' O Valor do aditivo excede o Valor do Saldo de Recurso Aprovado, valor não pode ser negativo '
                     || TO_CHAR (v_saldo_recurso, '999999.99')
                     || ' para a Carência : '
                     || TO_CHAR (:NEW.cta_cnt_cre_cod);
               v_sucesso := 1;
            END IF;
         EXCEPTION
            WHEN NO_DATA_FOUND
            THEN
               v_erro :=
                   'Não existe recurso aprovado para inclusão deste Aditivo ';
               v_sucesso := 1;
            WHEN OTHERS
            THEN
               v_erro :=
                        'Erro ao verificar o saldo de recurso aprovado na carência '
                     || SQLERRM;
               v_sucesso := 1;
         END;
      END IF;

      IF  :NEW.cta_deb_cred <> 1 AND :NEW.cta_deb_cred <> 0
      THEN
         v_erro := 'Códigos de Debito e Credito de Valor Inválidos!';
         v_sucesso := 1;
      END IF;
   END IF;

   IF v_sucesso <> 0
   THEN
      raise_application_error (-20100, v_erro);
   END IF;
END;
/

-- End of DDL Script for Trigger IFRBDE.TRG_TAB_CONT_TERMO_ADITIVO_01

