/* Formatted on 2005/05/25 11:24 (Formatter Plus v4.5.2) */
CREATE OR REPLACE TRIGGER ifrbde.trg_pre_compromisso_04_u
   BEFORE UPDATE OF val_pre_compromisso
   ON ifrbde.cad_pre_compromisso
   REFERENCING NEW AS NEW OLD AS OLD
   FOR EACH ROW
DECLARE
   v_erro                VARCHAR2 (200);
   v_sucesso             NUMBER (1);
   v_situacao            ifrbde.tab_carencia.num_situacao_carencia%TYPE;
   v_rap_valor           ifrbde.tab_rec_aprovado.rap_valor%TYPE;
   
--
   v_val_total_revisao   NUMBER (18, 2);
--      
BEGIN
   v_sucesso := 0;
   v_erro := '';

   IF UPDATING
   THEN
      IF :NEW.seq_licitacao IS NOT NULL
      THEN
         
--       
         :NEW.val_pre_compromisso := 0;
              v_val_total_revisao := 0;
--    
         BEGIN
            SELECT SUM (nvl(val_total_revisao,0))
              INTO v_val_total_revisao
              FROM ifrbde.cad_revisao_orcamento
             WHERE seq_licitacao_revisao = :NEW.seq_licitacao
			 AND cod_situacao_revisao = 'F';
--       
            :NEW.val_pre_compromisso := v_val_total_revisao;
--    
         EXCEPTION
            WHEN NO_DATA_FOUND
            THEN
               NULL;
            WHEN OTHERS
            THEN
               v_erro :=
                      'Erro ao Somar os Orçamentos Associados ao Pré-compromisso - '
                   || SQLERRM;
               v_sucesso := 1;
         END;
--
      END IF;

      IF v_sucesso = 0
      THEN
         BEGIN
            SELECT SUM (rap_valor)
              INTO v_rap_valor
              FROM ifrbde.tab_rec_aprovado
             WHERE rap_cre_cod = :NEW.seq_carencia
               AND rap_pgose >= TO_CHAR (:NEW.dat_pre_compromisso, 'YYYY');

            
--
            IF v_rap_valor < :NEW.val_pre_compromisso
            THEN
               v_erro :=    'O valor aprovado de '
                         || TO_CHAR (v_rap_valor)
                         || ' a partir de '
                         || TO_CHAR (:NEW.dat_pre_compromisso, 'YYYY')
                         || ' é menor que o valor pré-compromissado de '
                         || TO_CHAR (:NEW.val_pre_compromisso)
                         || ' !!!! ';
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
   END IF;

   
--
   IF v_sucesso <> 0
   THEN
      raise_application_error (-20100, v_erro);
   END IF;
--
EXCEPTION
   WHEN OTHERS
   THEN
      raise_application_error (
         -20100,
            'Aconteceu um erro fora de controle - Avise ao analista responsavel - '
         || SQLERRM
      );
END;
/

-- End of DDL Script for Trigger IFRBDE.TRG_PRE_COMPROMISSO_01_IUD

