/* Formatted on 2005/09/13 11:54 (Formatter Plus v4.5.2) */
CREATE OR REPLACE TRIGGER ifrbde.trg_tab_contrato_02
   BEFORE INSERT OR UPDATE
   ON ifrbde.tab_contrato
   REFERENCING NEW AS NEW OLD AS OLD
   FOR EACH ROW
DECLARE
   CURSOR pre
   IS
      SELECT     b.*
            FROM ifrbde.cad_pre_compromisso b
           WHERE b.seq_carencia = :NEW.cnt_cre_cod
             AND b.seq_contrato IS NULL
             AND b.num_situacao_pre_compromisso = 2
      FOR UPDATE;

   CURSOR pp
   IS
      SELECT b.*
        FROM ifrbde.cad_pre_compromisso b
       WHERE b.seq_carencia = :NEW.cnt_cre_cod
         AND b.seq_contrato = :NEW.num_seq_contrato;

   CURSOR tt (p_num_seq_contrato NUMBER, p_numero_contrato VARCHAR2)
   IS
      SELECT   c.contract_sub_type
          FROM ifrbde.cad_pre_compromisso b, ifrbde.viw_subtipo_contrato c
         WHERE b.seq_contrato = p_num_seq_contrato
           AND TRIM (c.contract_type) =
                                      TRIM (SUBSTR (p_numero_contrato, 8, 2))
           AND c.ind_garantia_caucionaria = b.flg_execucao
           AND DECODE (c.per_garantia_fixa, 0, '0', '1') = b.flg_risco
      ORDER BY c.contract_sub_type;

   v_erro                  VARCHAR2 (200);
   v_sucesso               NUMBER (1);
   v_qtd_pre_compromisso   NUMBER (2);
   v_subtipo               NUMBER (2);
   v_contrato_id           VARCHAR2 (30);
   v_contrato              VARCHAR2 (30);
BEGIN
   v_sucesso := 0;
   v_erro := '';
   v_qtd_pre_compromisso := 0;
   v_contrato_id := '';
   v_contrato := '';

   
--
--
--
   IF    INSERTING
      OR UPDATING
   THEN
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
   END IF;

   
--
--
--*************************************** SubTipo e copiar os dados do pre-compromisso *****************************************
--
   IF INSERTING
   THEN
      FOR cur IN pre
      LOOP
         v_qtd_pre_compromisso :=   v_qtd_pre_compromisso
                                  + 1;
      END LOOP;

      IF v_qtd_pre_compromisso = 0
      THEN
         v_erro :=
               'Não foi encontrado Pré-Compromisso para este contrato, favor cadastrar!!!';
         v_sucesso := 1;
      END IF;

      IF v_qtd_pre_compromisso > 1
      THEN
         v_erro :=
               'Foi encontrado mais de um Pré-Compromisso em situação de licitando, favor rever os pre-compromissos!!!';
         v_sucesso := 1;
      END IF;

      IF  v_qtd_pre_compromisso = 1 AND v_sucesso = 0
      THEN
         FOR cur IN pre
         LOOP
            BEGIN
               :NEW.cod_modalidade_licitacao := cur.cod_modalidade_licitacao;
               :NEW.num_inciso := cur.num_inciso;
               :NEW.dsc_fundamento_legal := cur.dsc_fundamento_legal;
               :NEW.num_licitacao := cur.num_licitacao;
               :NEW.num_ano_licitacao := cur.num_ano_licitacao;
               :NEW.num_processo := cur.num_processo;
               :NEW.cnt_prazo_exec := cur.num_prazo_execucao;
            EXCEPTION
               WHEN OTHERS
               THEN
                  v_erro :=
                           'Erro ao copiar os dados do Pre-Compromisso do Contrato - '
                        || SQLERRM;
                  v_sucesso := 1;
            END;
         END LOOP;
      END IF;

      
--

      IF v_sucesso = 0
      THEN
         v_subtipo := 0;

         
--
         FOR xx IN tt (:NEW.num_seq_contrato, :NEW.cnt_cod)
         LOOP
            v_subtipo :=   v_subtipo
                         + 1;

            IF v_subtipo = 1
            THEN
               :NEW.cod_subtipo_contrato := xx.contract_sub_type;
               EXIT;
            END IF;
         END LOOP;

         
--
         IF v_subtipo = 0
         THEN
            :NEW.cod_subtipo_contrato := '0000';
         
--            v_erro :=
--                  'Não foi encontrado para o tipo do contrato nenhum um subtipo !!!';
--            v_sucesso := 1;
         END IF;
      END IF;
   
--
--
   END IF;

   
--
   IF UPDATING
   THEN
      FOR cur IN pp
      LOOP
         v_qtd_pre_compromisso :=   v_qtd_pre_compromisso
                                  + 1;
      END LOOP;

      
--
      IF v_qtd_pre_compromisso = 0
      THEN
         FOR cur IN pre
         LOOP
            v_qtd_pre_compromisso :=   v_qtd_pre_compromisso
                                     + 1;
         END LOOP;

         IF v_qtd_pre_compromisso = 0
         THEN
            v_erro :=
                  'Não foi encontrado Pré-Compromisso para este contrato, favor cadastrar!!!';
            v_sucesso := 1;
         END IF;

         IF v_qtd_pre_compromisso > 1
         THEN
            v_erro :=
                  'Foi encontrado mais de um Pré-Compromisso em situação de licitando, favor rever os pre-compromissos!!!';
            v_sucesso := 1;
         END IF;

         
--
         IF  v_qtd_pre_compromisso = 1 AND v_sucesso = 0
         THEN
            FOR cur IN pre
            LOOP
               BEGIN
                  IF :NEW.tip_situacao_contrato IN (2, 4, 5, 6)
                  THEN
                     :NEW.cod_modalidade_licitacao :=
                                                 cur.cod_modalidade_licitacao;
                     :NEW.num_inciso := cur.num_inciso;
                     :NEW.dsc_fundamento_legal := cur.dsc_fundamento_legal;
                     :NEW.num_licitacao := cur.num_licitacao;
                     :NEW.num_ano_licitacao := cur.num_ano_licitacao;
                     :NEW.num_processo := cur.num_processo;
                     :NEW.cnt_prazo_exec := cur.num_prazo_execucao;

                     UPDATE ifrbde.cad_pre_compromisso
                        SET seq_contrato = :NEW.num_seq_contrato,
                            num_situacao_pre_compromisso = '3'
                      WHERE  CURRENT OF pre;
                  END IF;

                  IF :NEW.tip_situacao_contrato IN (1, 3)
                  THEN
                     :NEW.dsc_critica_contrato :=
                              TO_CHAR (SYSDATE, 'dd/mm/yyyy hh24:mi:ss')
                           || ' - Contrato Encerrado / Rescindido - '
                           || :NEW.dsc_critica_contrato;

                     UPDATE ifrbde.cad_pre_compromisso
                        SET seq_contrato = :NEW.num_seq_contrato,
                            num_situacao_pre_compromisso = '4'
                      WHERE  CURRENT OF pre;
                  END IF;
               EXCEPTION
                  WHEN OTHERS
                  THEN
                     v_erro :=
                              'Erro ao verificar o Pre-Compromisso do Contrato - '
                           || SQLERRM;
                     v_sucesso := 1;
               END;
            END LOOP;
         END IF;
      END IF;

      
--
      IF v_sucesso = 0
      THEN
         v_subtipo := 0;

         
--
         FOR xx IN tt (:NEW.num_seq_contrato, :NEW.cnt_cod)
         LOOP
            IF :NEW.cod_subtipo_contrato IS NULL
            THEN
               v_subtipo := 1;
               :NEW.cod_subtipo_contrato := xx.contract_sub_type;
               EXIT;
            ELSE
               IF :NEW.cod_subtipo_contrato = xx.contract_sub_type
               THEN
                  v_subtipo := 1;
                  :NEW.cod_subtipo_contrato := xx.contract_sub_type;
               END IF;
            END IF;
         END LOOP;

         
--
         IF v_subtipo = 0
         THEN
            :NEW.cod_subtipo_contrato := '0000';
         
--            v_erro :=
--                  'Não foi encontrado para o tipo do contrato nenhum um subtipo ou o subtipo não é compativel com o pré-compromisso do contrato!!!';
--            v_sucesso := 1;
         END IF;
      END IF;
   
--
--
   END IF;

   
--
--
   IF v_sucesso = 1
   THEN
      raise_application_error (-20100, v_erro);
   END IF;
END;
/

