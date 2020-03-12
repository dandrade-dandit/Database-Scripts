/* Formatted on 2005/09/09 14:39 (Formatter Plus v4.5.2) */
CREATE OR REPLACE TRIGGER ifrbde.trg_tab_contrato_04
   BEFORE INSERT OR UPDATE OF tip_situacao_contrato OR DELETE
   ON ifrbde.tab_contrato
   REFERENCING NEW AS NEW OLD AS OLD
   FOR EACH ROW
DECLARE
   v_erro             VARCHAR2 (400);
   v_sucesso          NUMBER (1);
   v_situacao         ifrbde.tab_carencia.num_situacao_carencia%TYPE;
   v_sit_integracao   VARCHAR2 (2);

   CURSOR vv (p_cnt_cod VARCHAR2, p_versao VARCHAR2)
   IS
      SELECT a.contract_id, a.contract_versao, a.contract_status_code,
             a.contract_prev_status_code
        FROM ifrbde.viw_conf_identificacao_u a
       WHERE a.contract_id = p_cnt_cod AND a.contract_versao = p_versao;
BEGIN
   v_sucesso := 0;
   v_erro := '';
   v_sit_integracao := ' ';

   
--
   IF INSERTING
   THEN
      ifrbde.pck_variaveis.v_pck_seq_carencia_aprovada :=
                                                    NVL (:NEW.cnt_cre_cod, 0);
      :NEW.tip_situacao_contrato := 5;
   END IF;

   IF UPDATING
   THEN
      ifrbde.pck_variaveis.v_pck_seq_carencia_aprovada :=
                                                    NVL (:NEW.cnt_cre_cod, 0);

      
--
--   verifica a situa��o na integra��o
--
--
--  TIPOS DE SITUA��O DO CONTRATO NA INTEGRA��O CONTIDOS NO CAMPO contract_status_code
--     IC - COMPLETO
--     P2 - PENDENTE DE APROVA��O DO GESTOR
--     P3 - PENDENTE DE APROVA��O DO REVISOR
--     CP - COMPLETO - ATIVO NA FINANCEIRA 
--     AD - ADITADO
--     CA - CANCELADO - VOLTA A INTEGRA��O PARA A SITUA��O DE IC - COMPLETO
--     DS - DISTRATO DE CONTRATO             
--     EN - ENCERRADO NA FINANCEIRA        
--
      FOR xx IN vv (:NEW.cnt_cod, :NEW.num_versao_contrato)
      LOOP
         v_sit_integracao := xx.contract_status_code;
      END LOOP;

      
--                                                    

      IF      :OLD.tip_situacao_contrato IN (1, 3)
          AND :NEW.tip_situacao_contrato IN (4, 5, 8)
      
--          AND v_sit_integracao IN ('AD', '  ')
      THEN
         
--
         IF UPPER (TRIM (:NEW.dsc_critica_contrato)) <> 'REATIVAR'
         THEN
            v_erro :=
                  'Contrato encerrado ou rescindido s� pode retornar para a situa��o de incompleto ou ativado';
            v_sucesso := 1;
         ELSE
            BEGIN
               SELECT num_situacao_carencia
                 INTO v_situacao
                 FROM ifrbde.tab_carencia
                WHERE cre_cod = :NEW.cnt_cre_cod;

               
--
               IF v_situacao NOT IN (3, 4)
               THEN
                  :NEW.dsc_critica_contrato :=
                           TO_CHAR (SYSDATE, 'DD/MM/YYYY HH24:MI:SS ')
                        || ' Contrato reativado pelo usu�rio '
                        || USER
                        || ' nesta data e hora ';
                  ifrbde.prc_exclui_hst_pag_crono (:NEW.num_seq_contrato);
               ELSE
                  v_erro :=
                        'Car�ncia n�o esta em situa��o para cadastrar ou alterar o contrato';
                  v_sucesso := 1;
               END IF;
            
--
            EXCEPTION
               WHEN OTHERS
               THEN
                  v_erro :=    'Erro ao verificar a situa��o da Car�ncia - '
                            || SQLERRM;
                  v_sucesso := 1;
            END;
         END IF;
      END IF;

      
--
      IF      :OLD.tip_situacao_contrato = 2
          AND :NEW.tip_situacao_contrato NOT IN (2, 7)
          
--          AND v_sit_integracao <> 'CP'
          AND v_sucesso = 0
      THEN
         v_erro :=
               'Contrato Acrescentando Reajuste s� pode permanecer na mesma a situa��o ou mudar para Ativo na Financeira';
         v_sucesso := 1;
      END IF;

      
--
      IF      :OLD.tip_situacao_contrato = 4
          AND :NEW.tip_situacao_contrato NOT IN (4, 5, 6)
          AND v_sucesso = 0
      THEN
         v_erro :=
               'Contrato Ativo s� pode permanecer na mesma a situa��o ou mudar para Incompleto ,  ou Enviado a Financeira';
         v_sucesso := 1;
      END IF;

      
--

      IF      :OLD.tip_situacao_contrato = 5
          AND :NEW.tip_situacao_contrato NOT IN (4, 5)
          AND v_sucesso = 0
      THEN
         v_erro :=
               'Contrato Incompleto s� pode permanecer na mesma a situa��o ou mudar para Ativo';
         v_sucesso := 1;
      END IF;

      
--
      IF      :OLD.tip_situacao_contrato = 6
          AND :NEW.tip_situacao_contrato NOT IN (1, 2, 3, 4, 5, 6, 9)
          
--          
-- colocar quando ativar a integra��o  AND :NEW.tip_situacao_contrato NOT IN (4, 5, 6, 7)
--
          AND v_sucesso = 0
      THEN
         v_erro :=
               'Contrato Enviado a Financeira s� pode permanecer na mesma a situa��o ou Incompleto , Ativo , Ativo na Financeira';
         v_sucesso := 1;
      END IF;

      
--
      IF      :OLD.tip_situacao_contrato = 6
          AND :NEW.tip_situacao_contrato IN (4, 5)
          
--          AND v_sit_integracao NOT IN ('IC', '  ')
          AND v_sucesso = 0
      THEN
         v_erro :=
               'Contrato n�o esta marcado na integra��o com a situa��o correta, que � Incompleto ou N�o existe na Integra��o ';
         v_sucesso := 1;
      END IF;

      
--
      IF      :OLD.tip_situacao_contrato = 6
          AND :NEW.tip_situacao_contrato = 7
          
--          AND v_sit_integracao <> 'CP'
          AND v_sucesso = 0
      THEN
         v_erro :=
               'Contrato n�o esta marcado na integra��o com a situa��o correta, que � Ativo';
         v_sucesso := 1;
      END IF;

      
--
      IF      :OLD.tip_situacao_contrato = 7
          AND :NEW.tip_situacao_contrato NOT IN (1, 2, 3, 4, 5, 7, 8)
          AND v_sucesso = 0
      THEN
         v_erro :=
               'Contrato Ativo na Financeira s� pode permanecer na mesma a situa��o ou Ativo , ou Incompleto , Aditado na Financeira';
         v_sucesso := 1;
      END IF;

      
--
      IF      :OLD.tip_situacao_contrato = 7
          AND :NEW.tip_situacao_contrato IN (1, 3)
          
--          AND v_sit_integracao <> 'EN'
          AND v_sucesso = 0
      THEN
         v_erro :=
               'Contrato n�o esta marcado na integra��o com a situa��o correta, que � Encerrado';
         v_sucesso := 1;
      END IF;

      
--
      IF      :OLD.tip_situacao_contrato = 7
          AND :NEW.tip_situacao_contrato = 2
          
--          AND v_sit_integracao <> 'CP'
          AND v_sucesso = 0
      THEN
         v_erro :=
               'Contrato n�o esta marcado na integra��o com a situa��o correta, que � Ativo';
         v_sucesso := 1;
      END IF;

      
--
      IF      :OLD.tip_situacao_contrato = 7
          AND :NEW.tip_situacao_contrato IN (4, 5)
          
--          AND v_sit_integracao <> 'IC'
          AND v_sucesso = 0
      THEN
         v_erro :=
               'Contrato n�o esta marcado na integra��o com a situa��o correta, que � Incompleto';
         v_sucesso := 1;
      END IF;

      
--
      IF      :OLD.tip_situacao_contrato = 7
          AND :NEW.tip_situacao_contrato = 8
          
--          AND v_sit_integracao <> 'AD'
          AND v_sucesso = 0
      THEN
         v_erro :=
               'Contrato n�o esta marcado na integra��o com a situa��o correta, que � Aditado';
         v_sucesso := 1;
      END IF;

      
--
      IF      :OLD.tip_situacao_contrato = 8
          AND :NEW.tip_situacao_contrato NOT IN (4, 5, 8)
          
--          AND v_sit_integracao <> 'AD'
          AND v_sucesso = 0
      THEN
         v_erro :=
               'Contrato n�o esta marcado na integra��o com a situa��o correta, que � Aditado';
         v_sucesso := 1;
      END IF;

      
--

      IF      :OLD.tip_situacao_contrato <> 3
          AND :NEW.tip_situacao_contrato IN (1, 3)
          AND v_sucesso = 0
      THEN
         IF LENGTH (TRIM (:NEW.dsc_critica_contrato)) = 0
         THEN
            v_erro := 'Motivo do encerramento n�o pode sr nulo !!!';
            v_sucesso := 1;
         END IF;

         IF LENGTH (TRIM (:NEW.dsc_critica_contrato)) <= 10
         THEN
            v_erro := 'Descreva melhor o motivo do encerramento !!!';
            v_sucesso := 1;
         END IF;

         IF SUBSTR (:NEW.dsc_critica_contrato, 1, 1) IN ('.',
                                                         '!',
                                                         ',',
                                                         '?',
                                                         '*',
                                                         '/',
                                                         '+',
                                                         '-',
                                                         '@',
                                                         '#',
                                                         '$',
                                                         '%',
                                                         '�',
                                                         '&',
                                                         '=',
                                                         '`'
                                                        )
         THEN
            v_erro :=
                  'Motivo do encerramento n�o aceita come�ar com ".", "!", ",", "?", "*", "/", "+", "-", "@", "#", "$", "%", "�", "&", "=", "`". !!!';
            v_sucesso := 1;
         END IF;

         IF v_sucesso = 0
         THEN
            :NEW.dsc_critica_contrato :=
                     TO_CHAR (SYSDATE, 'dd/mm/yyyy hh:mi:ss')
                  || ' - Contrato Encerrado / Rescindido - '
                  || :NEW.dsc_critica_contrato;

            UPDATE ifrbde.cad_pre_compromisso
               SET num_situacao_pre_compromisso = 4
             WHERE seq_contrato = :NEW.num_seq_contrato;
         END IF;
      END IF;
   END IF;

   
--
   IF DELETING
   THEN
      ifrbde.pck_variaveis.v_pck_seq_carencia_aprovada :=
                                                    NVL (:OLD.cnt_cre_cod, 0);
   END IF;

   
--
   IF v_sucesso <> 0
   THEN
      raise_application_error (-20100, v_erro);
   END IF;
END;
/

