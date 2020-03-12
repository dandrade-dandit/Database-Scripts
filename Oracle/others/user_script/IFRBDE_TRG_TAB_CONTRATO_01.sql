CREATE OR REPLACE TRIGGER TRG_TAB_CONTRATO_01
 BEFORE 
 INSERT OR UPDATE OF CNT_CEI, CNT_COD, CNT_CREA, CNT_CRE_COD, CNT_DATA, CNT_DATA_INICIO, CNT_DATA_PROPOSTA, CNT_ICE_COD, CNT_JUSTIFICATIVA_CRE, CNT_PRAZO_EXEC, COD_DEP_CONTRATO, DAT_TERMINO_CONTRATO, FLG_NUMERO_PADRAO, NUM_ATO_ADMINISTRATIVO, NUM_PRAZO_EXEC_MESES, NUM_SEQ_ASSINATURA_1, NUM_SEQ_ASSINATURA_2, NUM_SEQ_CONTRATO, NUM_SEQ_GESTOR
 ON TAB_CONTRATO
 REFERENCING OLD AS OLD NEW AS NEW
 FOR EACH ROW 
DECLARE
   v_erro          VARCHAR2 (200);
   v_sucesso       NUMBER (1);
   v_cre_dep_cod   ifrbde.tab_contrato.cod_dep_contrato%TYPE;
   v_saldo_ano     ifrbde.tab_rec_aprovado.val_saldo_recurso%TYPE;
   v_contrato_id   VARCHAR2 (30);
BEGIN
   v_sucesso := 0;
   v_erro := '';
   v_contrato_id := '';

   
--

   IF    INSERTING
      OR UPDATING
   THEN
      
--
--
-- zerar variavel --
--

      :NEW.cnt_prazo_exec := NVL (:NEW.cnt_prazo_exec, 0);
      :NEW.num_prazo_exec_meses := NVL (:NEW.num_prazo_exec_meses, 0);
      :NEW.num_seq_gestor := NVL (:NEW.num_seq_gestor, 0);
      :NEW.num_seq_assinatura_1 := NVL (:NEW.num_seq_assinatura_1, 0);
      :NEW.num_seq_assinatura_2 := NVL (:NEW.num_seq_assinatura_2, 0);
      :NEW.cnt_prazo_adit := NVL (:NEW.cnt_prazo_adit, 0);
      :NEW.num_versao_contrato := NVL (:NEW.num_versao_contrato, '00');

      IF :NEW.cnt_prazo_exec < 0
      THEN
         v_erro :=
                'Prazo de Execução do Contrato em dias não pode ser negativo';
         v_sucesso := 1;
      END IF;

      IF :NEW.num_prazo_exec_meses < 0
      THEN
         v_erro :=
               'Prazo de Execução do Contrato em meses não pode ser negativo';
         v_sucesso := 1;
      END IF;

      IF  :NEW.cnt_prazo_exec = 0 AND :NEW.num_prazo_exec_meses = 0
      THEN
         v_erro := 'Favor Informar o prazo em dias ou em meses';
         v_sucesso := 1;
      ELSE
         IF NVL (:NEW.cnt_prazo_exec, 0) > 0
         THEN
            :NEW.dat_termino_contrato :=
                                :NEW.cnt_data_inicio
                              + :NEW.cnt_prazo_exec
                              - 1;
            :NEW.num_prazo_exec_meses :=
                  MONTHS_BETWEEN (
                     :NEW.dat_termino_contrato,
                     :NEW.cnt_data_inicio
                  );
            :NEW.dat_termino_contrato :=   :NEW.cnt_data_inicio
                                         + :NEW.cnt_prazo_exec
                                         + :NEW.cnt_prazo_adit
                                         - 1;
         ELSE
            :NEW.dat_termino_contrato :=
                  TO_DATE (
                     TO_CHAR (
                          ADD_MONTHS (
                             :NEW.cnt_data_inicio,
                             :NEW.num_prazo_exec_meses
                          )
                        + :NEW.cnt_prazo_adit
                        - 1,
                        'DD/MM/YYYY'
                     )
                  );
            :NEW.cnt_prazo_exec :=   (  :NEW.dat_termino_contrato
                                      - :NEW.cnt_data_inicio
                                     )
                                   - :NEW.cnt_prazo_adit;
         END IF;
      END IF;

      
/*
      IF v_sucesso = 0
      THEN
         v_cre_dep_cod := 0;

         BEGIN
            SELECT nvl(cre_dep_cod,0)
              INTO v_cre_dep_cod
              FROM IFRBDE.tab_carencia
             WHERE cre_cod = :NEW.cnt_cre_cod;

            :NEW.cod_dep_contrato := v_cre_dep_cod;

            if v_cre_dep_cod = 0 then
               v_erro :=
                  'Código da Dependencia igual a 0 , Carência não existe ou Você não tem Privilegio para vê-la - Entre em contato com o suporte do sistema';
               v_sucesso := 1;
            end if;

         EXCEPTION
            WHEN NO_DATA_FOUND
            THEN

--             :NEW.cod_dep_contrato := 999;
               v_erro :=
                  'Carência não existe ou Você não tem Privilegio para vê-la';
               v_sucesso := 1;
            WHEN OTHERS
            THEN
               v_erro :=    'Erro ao selecionar a dependencia '
                         || SQLERRM;
               v_sucesso := 1;
         END;
      END IF;


      IF  v_sucesso = 0 AND UPDATING
      THEN
         IF  :NEW.cnt_cod <> :OLD.cnt_cod AND :OLD.flg_numero_padrao = 'S'
         THEN
            v_erro := 'Numero do Contrato padronizado para o SMARTSTREAM';
            v_sucesso := 1;
         END IF;
      END IF;

*/

-- verificar o formato do campo numero do contrato

      IF v_sucesso = 0
      THEN
         BEGIN
            FOR i IN 1 .. 30
            LOOP
               IF SUBSTR (:NEW.cnt_cod, i, 1) <> ' '
               THEN
                  v_contrato_id :=
                                  v_contrato_id
                               || SUBSTR (:NEW.cnt_cod, i, 1);
               END IF;
            END LOOP;

            IF    (    SUBSTR (v_contrato_id, 1, 2) IN ('TC', 'MS', 'CV')
                   AND SUBSTR (v_contrato_id, 6, 1) = '-'
                   AND SUBSTR (v_contrato_id, 9, 1) = '/'
                   AND SUBSTR (v_contrato_id, 14, 1) = '/'
                   AND LENGTH (v_contrato_id) = 18
                   AND TO_NUMBER (SUBSTR (v_contrato_id, 3, 3)) > 0
                   AND TO_NUMBER (SUBSTR (v_contrato_id, 10, 4)) > 0
                   AND TO_NUMBER (SUBSTR (v_contrato_id, 15, 4)) > 0
                  )
               OR (    SUBSTR (v_contrato_id, 1, 2) IN ('TC', 'MS', 'CV', 'CC')
                   AND SUBSTR (v_contrato_id, 7, 1) = '-'
                   AND SUBSTR (v_contrato_id, 10, 1) = '/'
                   AND SUBSTR (v_contrato_id, 15, 1) = '/'
                   AND LENGTH (v_contrato_id) = 19
                   AND TO_NUMBER (SUBSTR (v_contrato_id, 3, 4)) > 0
                   AND TO_NUMBER (SUBSTR (v_contrato_id, 11, 4)) > 0
                   AND TO_NUMBER (SUBSTR (v_contrato_id, 16, 4)) > 0
                  )
            THEN
               
--
-- outras verificações
--
               IF      LENGTH (v_contrato_id) = 18
                   AND (   TO_NUMBER (SUBSTR (v_contrato_id, 10, 4)) < 1989
                        OR TO_NUMBER (SUBSTR (v_contrato_id, 10, 4)) >
                                         TO_NUMBER (TO_CHAR (SYSDATE, 'YYYY'))
                       )
               THEN
                  v_erro :=
                           'Ano do Contrato Invalido. Não pode ser menor 1989 ou maior que '
                        || TO_CHAR (SYSDATE, 'YYYY');
                  v_sucesso := 1;
               END IF;

               IF      LENGTH (v_contrato_id) = 19
                   AND (   TO_NUMBER (SUBSTR (v_contrato_id, 11, 4)) < 1989
                        OR TO_NUMBER (SUBSTR (v_contrato_id, 11, 4)) >
                                          TO_NUMBER (TO_CHAR (SYSDATE, 'YYYY'))
                       )
               THEN
                  v_erro :=
                           'Ano do Contrato Invalido. Não pode ser menor 1989 ou maior que '
                        || TO_CHAR (SYSDATE, 'YYYY');
                  v_sucesso := 1;
               END IF;

               IF  LENGTH (v_contrato_id) = 18 AND v_sucesso = 0
               THEN
                  v_contrato_id :=    SUBSTR (v_contrato_id, 1, 2)
                                   || '0'
                                   || SUBSTR (v_contrato_id, 3, 16);
               END IF;

               IF SUBSTR (v_contrato_id, 8, 2) NOT IN ('BE',
                                                       'CI',
                                                       'EG',
                                                       'EM',
                                                       'LI',
                                                       'LM',
                                                       'MC',
                                                       'PA',
                                                       'PS',
                                                       'SB',
                                                       'SF',
                                                       'SL',
                                                       'SM',
                                                       'SS',
                                                       'ST',
                                                       'SV',
                                                       'TG'
                                                      )
               THEN
                  v_erro :=
                        'Tipo do Contrato Invalido. Consulte a Ajuda do Formato do Contrato';
                  v_sucesso := 1;
               END IF;

               IF v_sucesso = 0
               THEN
                  IF INSERTING
                  THEN
                     :NEW.cnt_cod := v_contrato_id;
                     :NEW.num_contrato_original := v_contrato_id;
                     :NEW.flg_numero_padrao := 'S';
                  ELSE
                     :NEW.cnt_cod := v_contrato_id;
                     :NEW.flg_numero_padrao := 'S';
                  END IF;
               END IF;
            ELSE
               v_erro :=
                     'O numero do contrato não esta no formato padrão - XXSSSS-TT/AAAA/DDDD , onde XX é TC, CV , ou MS , SSSS é a sequencia, TT é o Tipo do contrato , AAAA é o ano e DDDD é a Dependência.';
               v_sucesso := 1;
            END IF;
         EXCEPTION
            WHEN OTHERS
            THEN
               v_erro :=
                     'O numero do contrato não esta no formato padrão - XXSSSS-TT/AAAA/DDDD , onde XX é TC, CV , ou MS , SSSS é a sequencia, TT é o Tipo do contrato , AAAA é o ano e DDDD é a Dependência.';
               v_sucesso := 1;
         END;
      END IF;
   
--
   END IF;

   IF  INSERTING AND v_sucesso = 0
   THEN
      
--
--    default de inclusão de contrato 5 incompleto
--  
      :NEW.tip_situacao_contrato := 5;

      
--
--
      IF :NEW.num_termo_aditivo IS NULL
      THEN
         :NEW.num_versao_contrato := '00';
      END IF;

      IF v_sucesso = 0
      THEN
         v_cre_dep_cod := 0;
         :NEW.cod_dep_contrato := v_cre_dep_cod;

         BEGIN
            SELECT NVL (cre_dep_cod, 0)
              INTO v_cre_dep_cod
              FROM ifrbde.tab_carencia
             WHERE cre_cod = :NEW.cnt_cre_cod;

            :NEW.cod_dep_contrato := v_cre_dep_cod;

            IF v_cre_dep_cod = 0
            THEN
               v_erro :=
                     'Código da Dependencia igual a 0 , Carência não existe ou Você não tem Privilegio para vê-la - Entre em contato com o suporte do sistema';
               v_sucesso := 1;
            END IF;
         EXCEPTION
            WHEN NO_DATA_FOUND
            THEN
               
--             :NEW.cod_dep_contrato := 999;
               v_erro :=
                  'Carência não existe ou Você não tem Privilegio para vê-la';
               v_sucesso := 1;
            WHEN OTHERS
            THEN
               v_erro :=    'Erro ao selecionar a dependencia '
                         || SQLERRM;
               v_sucesso := 1;
         END;
      END IF;
   END IF;

   
--
   IF  UPDATING AND v_sucesso = 0
   THEN
      IF (  :NEW.cnt_prazo_exec
          + :OLD.cnt_prazo_adit
         ) < 0
      THEN
         v_erro :=
                  'Prazo de Execução + Prazo Aditivado não pode ser negativo';
         v_sucesso := 1;
      END IF;

      IF :OLD.tip_situacao_contrato <> :NEW.tip_situacao_contrato
      THEN
         v_erro :=
               'Situação não pode ser mudada manualmente - informação atualizada automaticamente';
         v_sucesso := 1;
      END IF;

      
--
      IF      :OLD.tip_situacao_contrato IN (1, 3)
          AND :NEW.tip_situacao_contrato NOT IN (1, 3)
      THEN
         v_erro :=
              'Situação não pode ser mudada manualmente - Contrato encerrado';
         v_sucesso := 1;
      END IF;

      
--
      IF      :OLD.tip_situacao_contrato = 5
          AND :NEW.tip_situacao_contrato IN (2, 4, 6, 7, 8)
      THEN
         v_erro :=
               'Situação não pode ser mudada manualmente - corrija os erros e atualize o contrato.';
         v_sucesso := 1;
      END IF;

      
--
      IF :OLD.tip_situacao_contrato IN (6, 7, 8)
      THEN
         v_erro :=
               'Os dados do contrato não pode ser mudada manualmente - Contrato Transmitido para SmartStream ';
         v_sucesso := 1;
      END IF;

      
--
      IF :OLD.num_versao_contrato <> :NEW.num_versao_contrato
      THEN
         v_erro := 'A versão do Contrato não pode ser mudada manualmente ';
         v_sucesso := 1;
      END IF;

      
--
      IF  :OLD.num_versao_contrato <> '00' AND :OLD.cnt_cod <> :NEW.cnt_cod
      THEN
         v_erro :=
               'Numero do contrato não pode ser alterado, pois a versão do contrato não é a original "00" ';
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
