/* Formatted on 2005/05/16 16:15 (Formatter Plus v4.5.2) */
CREATE OR REPLACE TRIGGER ifrbde.trg_tab_carencia_03
   BEFORE INSERT OR UPDATE
   ON ifrbde.tab_carencia
   REFERENCING NEW AS NEW OLD AS OLD
   FOR EACH ROW
DECLARE
   v_erro                           VARCHAR2 (200);
   v_sucesso                        NUMBER (1);
   v_count_aprovacao                NUMBER (3);
   v_count_pre_compromisso          NUMBER (3);
   v_count_contratos                NUMBER (3);
   v_count_pre_compromisso_ativos   NUMBER (3);
   v_count_contratos_ativos         NUMBER (3);
   v_count_pre_compromisso_encerr   NUMBER (3);
   v_count_contratos_encerr         NUMBER (3);
   v_tip_operacao                   VARCHAR2 (1);

   
--
   CURSOR rsaldo (p_carencia NUMBER)
   IS
      SELECT a.*
        FROM ifrbde.viw_saldo_carencia_crono a
       WHERE a.num_seq_carencia = p_carencia;

   
--
   CURSOR rsaldoc (p_carencia1 NUMBER)
   IS
      SELECT a.*
        FROM ifrbde.viw_saldo_crono_carencia a
       WHERE a.num_seq_carencia = p_carencia1;
BEGIN
   v_sucesso := 0;
   v_erro := '';
   v_count_aprovacao := 0;
   v_count_pre_compromisso := 0;
   v_count_contratos := 0;
   v_count_pre_compromisso_ativos := 0;
   v_count_contratos_ativos := 0;
   v_count_pre_compromisso_encerr := 0;
   v_count_contratos_encerr := 0;

   
--
   IF INSERTING
   THEN
      
--
      IF v_sucesso = 0
      THEN
         :NEW.num_situacao_carencia := 1;
      END IF;
   
--
   END IF;

   
--
   IF UPDATING
   THEN
      
--
-- EXECUTA A VERIFICAÇÃO SE NÃO ESTIVER FAZENDO REMANEJAMENTO
--
      v_tip_operacao := 'F';

      BEGIN
         SELECT tip_operacao
           INTO v_tip_operacao
           FROM ifrbde.aux_usuario_carencia
          WHERE nom_username = USER
            AND seq_carencia = :NEW.cre_cod
            AND tip_operacao = 'R';
      
--
      EXCEPTION
         WHEN NO_DATA_FOUND
         THEN
            NULL;
         
--               
         WHEN OTHERS
         THEN
            raise_application_error (
               -20100,
                  'erro ao selecionar ir o usuario do arquivo auxiliar do carencia do tipo '
               || v_tip_operacao
               || ' - '
               || SQLERRM
            );
      END;

      
--
      IF v_tip_operacao = 'F'
      THEN
         
--            
         IF v_sucesso = 0
         THEN
            FOR regz IN rsaldoc (:NEW.cre_cod)
            LOOP
               IF regz.val_total_cronogramado >= 0
               THEN
                  v_erro :=    ' Para Valor Cronogramado de '
                            || TO_CHAR (regz.val_total_cronogramado)
                            || ' não existe aprovação no Ano de '
                            || regz.ano_pgose
                            || ' na carência '
                            || TO_CHAR (regz.num_seq_carencia);
                  v_sucesso := 1;
               END IF;
            END LOOP;
         END IF;

         
--
         IF v_sucesso = 0
         THEN
            
--
            FOR regx IN rsaldo (:NEW.cre_cod)
            LOOP
               IF regx.val_saldo_cronogramado < 0
               THEN
                  v_erro :=    ' Valor Cronogramado de '
                            || TO_CHAR (regx.val_total_cronogramado)
                            || ' e maior que o Valor aprovado de '
                            || TO_CHAR (regx.val_total_recurso)
                            || ' no Ano de '
                            || regx.ano_pgose
                            || ' na carência '
                            || TO_CHAR (regx.num_seq_carencia);
                  v_sucesso := 1;
               END IF;
            END LOOP;
         
--         
         END IF;
      ELSE
         
--
         BEGIN
            DELETE FROM ifrbde.aux_usuario_carencia
                  WHERE nom_username = USER
                    AND seq_carencia = :NEW.cre_cod
                    AND tip_operacao = 'R';
         EXCEPTION
            WHEN OTHERS
            THEN
               raise_application_error (
                  -20100,
                     'erro ao excluir ir o usuario do arquivo auxiliar do carencia do tipo '
                  || v_tip_operacao
                  || ' - '
                  || SQLERRM
               );
         END;
      
--
      END IF;

      
--
--
--

--
-- inicio verificações basicas
--

      IF v_sucesso = 0
      THEN
         BEGIN
            SELECT COUNT (*)
              INTO v_count_aprovacao
              FROM ifrbde.tab_rec_aprovado
             WHERE rap_cre_cod = :NEW.cre_cod;
         EXCEPTION
            WHEN OTHERS
            THEN
               v_erro :=    'Erro ao selecionar as aprovações da carencia '
                         || SQLERRM;
               v_sucesso := 1;
         END;
      END IF;

      
--
      IF v_sucesso = 0
      THEN
         BEGIN
            SELECT COUNT (*)
              INTO v_count_pre_compromisso
              FROM ifrbde.cad_pre_compromisso
             WHERE seq_carencia = :NEW.cre_cod
               AND num_situacao_pre_compromisso <> 9;
         EXCEPTION
            WHEN OTHERS
            THEN
               v_erro :=
                          'Erro ao selecionar os pre-compromissos '
                       || SQLERRM;
               v_sucesso := 1;
         END;
      END IF;

      
--
      IF v_sucesso = 0
      THEN
         BEGIN
            SELECT COUNT (*)
              INTO v_count_contratos
              FROM ifrbde.tab_contrato
             WHERE cnt_cre_cod = :NEW.cre_cod;
         EXCEPTION
            WHEN OTHERS
            THEN
               v_erro :=
                        'Erro ao selecionar os todos os contratos '
                     || SQLERRM;
               v_sucesso := 1;
         END;
      END IF;

      
-- ativos

      IF v_sucesso = 0
      THEN
         BEGIN
            SELECT COUNT (*)
              INTO v_count_pre_compromisso_ativos
              FROM ifrbde.cad_pre_compromisso
             WHERE seq_carencia = :NEW.cre_cod
               AND num_situacao_pre_compromisso NOT IN (4, 5, 9);
         EXCEPTION
            WHEN OTHERS
            THEN
               v_erro :=
                        'Erro ao selecionar os pre-compromissos incluido e contratados'
                     || SQLERRM;
               v_sucesso := 1;
         END;
      END IF;

      IF v_sucesso = 0
      THEN
         BEGIN
            SELECT COUNT (*)
              INTO v_count_contratos_ativos
              FROM ifrbde.tab_contrato
             WHERE cnt_cre_cod = :NEW.cre_cod
               AND tip_situacao_contrato NOT IN (1, 3);
         EXCEPTION
            WHEN OTHERS
            THEN
               v_erro :=
                           'Erro ao selecionar os contratos ativos'
                        || SQLERRM;
               v_sucesso := 1;
         END;
      END IF;

      
-- encerrados

      IF v_sucesso = 0
      THEN
         BEGIN
            SELECT COUNT (*)
              INTO v_count_pre_compromisso_encerr
              FROM ifrbde.cad_pre_compromisso
             WHERE seq_carencia = :NEW.cre_cod
               AND num_situacao_pre_compromisso IN (4, 5, 9);
         EXCEPTION
            WHEN OTHERS
            THEN
               v_erro :=
                        'Erro ao selecionar os pre-compromissos Cancelado ou rescindido'
                     || SQLERRM;
               v_sucesso := 1;
         END;
      END IF;

      
--
      IF v_sucesso = 0
      THEN
         BEGIN
            SELECT COUNT (*)
              INTO v_count_contratos_encerr
              FROM ifrbde.tab_contrato
             WHERE cnt_cre_cod = :NEW.cre_cod
               AND tip_situacao_contrato IN (1, 3);
         EXCEPTION
            WHEN OTHERS
            THEN
               v_erro :=
                        'Erro ao selecionar os contratos encerrados os rescindidos'
                     || SQLERRM;
               v_sucesso := 1;
         END;
      END IF;

      
--
      IF v_sucesso = 0
      THEN
         
--
         :NEW.num_situacao_carencia := -1;

         
--
         IF      v_count_aprovacao = 0
             AND v_count_pre_compromisso = 0
             AND v_count_contratos = 0
         THEN
            :NEW.num_situacao_carencia := 1;
         END IF;

         IF      v_count_aprovacao > 0
             AND v_count_pre_compromisso_ativos = 0
             AND v_count_contratos_ativos = 0
         THEN
            :NEW.num_situacao_carencia := 2;
         END IF;

         IF      v_count_aprovacao > 0
             AND v_count_pre_compromisso_ativos > 0
             AND v_count_contratos_ativos = 0
         THEN
            :NEW.num_situacao_carencia := 3;
         END IF;

         IF      v_count_aprovacao > 0
             AND v_count_pre_compromisso_ativos > 0
             AND v_count_contratos_ativos > 0
         THEN
            :NEW.num_situacao_carencia := 4;
         END IF;

         IF      v_count_aprovacao > 0
             AND v_count_pre_compromisso_encerr = v_count_pre_compromisso
             AND v_count_contratos_encerr = v_count_contratos
             AND v_count_pre_compromisso > 0
             AND v_count_contratos > 0
         THEN
            :NEW.num_situacao_carencia := 6;
         END IF;

         IF :NEW.num_situacao_carencia = -1
         THEN
            :NEW.num_situacao_carencia := 0;
            :NEW.dsc_critica_carencia :=
                     TO_CHAR (SYSDATE, 'dd/mm/yyyy hh:mi:ss')
                  || ' - Dados de Complementares da Carência inconsistentes '
                  || ' - Aprovações =>'
                  || TO_CHAR (v_count_aprovacao)
                  || ' - Pre-compromissos Ativos =>'
                  || TO_CHAR (v_count_pre_compromisso_ativos)
                  || ',Encerrados =>'
                  || TO_CHAR (v_count_pre_compromisso_encerr)
                  || ',Total =>'
                  || TO_CHAR (v_count_pre_compromisso)
                  || ' - Contratos Ativos =>'
                  || TO_CHAR (v_count_contratos_ativos)
                  || ',Encerrados =>'
                  || TO_CHAR (v_count_contratos_encerr)
                  || ',Total =>'
                  || TO_CHAR (v_count_contratos);
         ELSE
            :NEW.dsc_critica_carencia :=
                     TO_CHAR (SYSDATE, 'dd/mm/yyyy hh:mi:ss')
                  || ' - Dados OK - Analise das informações da Carência Concluida .... ';
         END IF;
      END IF;
   
--
-- fim verificações basicas
--
--
   END IF;

   
--
   IF v_sucesso <> 0
   THEN
      raise_application_error (-20100, v_erro);
   END IF;
--
/*EXCEPTION
   WHEN OTHERS
   THEN
      raise_application_error (
         -20100,
            'Aconteceu um erro fora de controle - Avise ao analista responsavel - '
         || SQLERRM
      ); */
END;
/

-- End of DDL Script for Trigger IFRBDE.TRG_TAB_CARENCIA_03

