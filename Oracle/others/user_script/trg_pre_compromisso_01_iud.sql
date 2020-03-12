/* Formatted on 2005/07/07 16:18 (Formatter Plus v4.5.2) */
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
                              dsc_fundamento_legal,
                              cod_modalidade_licitacao,
                              num_prazo_execucao_contrato OR DELETE
   ON ifrbde.cad_pre_compromisso
   REFERENCING NEW AS NEW OLD AS OLD
   FOR EACH ROW
DECLARE
   v_erro        VARCHAR2 (200);
   v_sucesso     NUMBER (1);
   v_situacao    ifrbde.tab_carencia.num_situacao_carencia%TYPE;
   v_rap_valor   ifrbde.tab_rec_aprovado.rap_valor%TYPE;
--   v_licitacao   ifrbde.cad_licitacao.seq_licitacao%TYPE;
--   v_prazo       ifrbde.cad_licitacao.num_mes_licitacao%TYPE;
BEGIN
   v_sucesso := 0;
   v_erro := '';

   IF INSERTING
   THEN
      
--
      ifrbde.pck_variaveis.v_pck_seq_carencia_precompr :=
                                                   NVL (:NEW.seq_carencia, 0);
      
--
      :NEW.num_situacao_pre_compromisso := 1;
      :NEW.val_pre_compromisso := 0;

      
--
      BEGIN
         SELECT num_situacao_carencia
           INTO v_situacao
           FROM ifrbde.tab_carencia
          WHERE cre_cod = :NEW.seq_carencia;

         
--
         IF v_situacao NOT IN (2, 3, 4, 6)
         THEN
            v_erro :=
                  'A Carência não encontra-se em situação de inclusão do Pré-Compromisso !!!! ';
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

      
--
--  gravar na tabela do bdpu para criar a licitação   
--
/*      IF v_sucesso = 0
      THEN

--
         v_prazo := ROUND (:NEW.num_prazo_execucao / 30);


--
         BEGIN

            DELETE FROM ifrbde.cad_licitacao
             WHERE cod_pgose_licitacao = :NEW.seq_carencia
               AND tip_situacao_licitacao = 'ATV';


            INSERT INTO cad_licitacao
                        (flg_permite_consorcio, cod_licitacao,
                         num_mes_licitacao, tip_situacao_licitacao,
                         cod_pgose_licitacao)
                 VALUES (DECODE (:NEW.flg_consorcio, '0', 'N', '1', 'S'), '',
                         v_prazo, 'ATV',
                         :NEW.seq_carencia);

            SELECT seq_licitacao
              INTO v_licitacao
              FROM ifrbde.cad_licitacao
             WHERE cod_pgose_licitacao = :NEW.seq_carencia
               AND tip_situacao_licitacao = 'ATV';


--
            :NEW.seq_licitacao := v_licitacao;

--
         EXCEPTION
            WHEN OTHERS
            THEN
               v_erro :=    'Erro ao verificar o sequencial da Licitação - '
                         || SQLERRM;
               v_sucesso := 1;
         END;
      END IF;

*/
--
      IF v_sucesso = 0
      THEN
         IF (:NEW.dsc_fundamento_legal IS NULL)
         THEN
            v_erro :=
                  'Pré-Compromisso - Somente a informação de Fundamento Legal é obrigatória em qualquer para modalidade';
            v_sucesso := 1;
         END IF;

         IF      UPPER (:NEW.cod_modalidade_licitacao) NOT IN ('DISP', 'INEX')
             AND (:NEW.num_inciso IS NOT NULL)
         THEN
            
--
            v_erro :=
                  'Pré-Compromisso - Somente a informação de Inciso não é necessaria para modalidade Diferente "Dispensa" ou "Inexigibilidade" ';
            v_sucesso := 1;
         
--
         END IF;

         
--
         IF      UPPER (:NEW.cod_modalidade_licitacao) IN ('DISP', 'INEX')
             AND (:NEW.num_inciso IS NULL)
         THEN
            v_erro :=
                  'Pré-Compromisso - Somente a informação de inciso é obrigatória para modalidade "Dispensa" ou "Inexigibilidade" ';
            v_sucesso := 1;
         END IF;
      
--
      END IF;

      
--
      IF v_sucesso = 0
      THEN
         IF :NEW.flg_risco = '1'
         THEN
            :NEW.tax_garantia := 100;
         ELSE
            :NEW.tax_garantia := 0;
         END IF;

         
--
         IF :NEW.flg_execucao = '1'
         THEN
            IF :NEW.tax_execucao <= 0
            THEN
               v_erro :=
                       ' Taxa de Execução não pode ser igual ou menor que 0 ';
               v_sucesso := 1;
            END IF;

            IF :NEW.tax_execucao > 10
            THEN
               v_erro := ' Taxa de Execução não pode ser maior que 10 ';
               v_sucesso := 1;
            END IF;
         ELSE
            :NEW.tax_execucao := 0;
         END IF;
      END IF;

      
--
      IF      (   :NEW.num_licitacao IS NOT NULL
               OR :NEW.num_ano_licitacao IS NOT NULL
               OR :NEW.num_processo IS NOT NULL
              )
          AND v_sucesso = 0
      THEN
         v_erro :=
               'Os Campos de número e ano  de licitação, e número do processo , só deverão ser informados quando o pré-compromisso tiver valor diferente de zero ';
         v_sucesso := 1;
      END IF;
   
--

   END IF;

   IF UPDATING
   THEN
      
--

      ifrbde.pck_variaveis.v_pck_seq_carencia_precompr :=
                                                   NVL (:NEW.seq_carencia, 0);

      
--
      BEGIN
         SELECT num_situacao_carencia
           INTO v_situacao
           FROM ifrbde.tab_carencia
          WHERE cre_cod = :NEW.seq_carencia;

         
--
         IF v_situacao NOT IN (3, 4)
         THEN
            v_erro :=
                  'A Carência não encontra-se em situação (Pré-Compromissada ou Compromissada/Contratada) para Alteração do Pré-Compromisso !!!! ';
            v_sucesso := 1;
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

      
--
      IF      v_sucesso = 0
          AND :OLD.num_situacao_pre_compromisso <>
                                             :NEW.num_situacao_pre_compromisso
          AND :NEW.num_situacao_pre_compromisso <> 5
      THEN
         v_erro :=
               'A situação do Pré - Compromisso não podem ser modificado manualmente - exceto para Cancelar';
         v_sucesso := 1;
      END IF;
--
      IF  v_sucesso = 0 AND :NEW.num_situacao_pre_compromisso = 1
      THEN
         IF (:NEW.dsc_fundamento_legal IS NULL)
         THEN
            v_erro :=
                  'Pré-Compromisso - Somente a informação de Fundamento Legal é obrigatória em qualquer para modalidade';
            v_sucesso := 1;
         END IF;

         IF      UPPER (:NEW.cod_modalidade_licitacao) NOT IN ('DISP', 'INEX')
             AND (:NEW.num_inciso IS NOT NULL)
         THEN
--
            v_erro :=
                  'Pré-Compromisso - Somente a informação de Inciso não é necessaria para modalidade Diferente "Dispensa" ou "Inexigibilidade" ';
            v_sucesso := 1;
--
         END IF;

         
--
         IF      UPPER (:NEW.cod_modalidade_licitacao) IN ('DISP', 'INEX')
             AND (:NEW.num_inciso IS NULL)
         THEN
            v_erro :=
                  'Pré-Compromisso - Somente a informação de inciso é obrigatória para modalidade "Dispensa" ou "Inexigibilidade" ';
            v_sucesso := 1;
         END IF;
      
--

      END IF;

      
--
      IF      v_sucesso = 0
          AND :OLD.num_situacao_pre_compromisso <> 1
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
               OR :NEW.num_prazo_execucao_contrato <>
                                              :OLD.num_prazo_execucao_contrato
               OR :NEW.num_prazo_execucao <> :OLD.num_prazo_execucao
               OR :NEW.dat_pre_compromisso <> :OLD.dat_pre_compromisso
               OR :NEW.num_licitacao <> :OLD.num_licitacao
               OR :NEW.num_ano_licitacao <> :OLD.num_ano_licitacao
               OR :NEW.num_processo <> :OLD.num_processo
               OR :NEW.val_pre_compromisso <> :OLD.val_pre_compromisso
              )
      THEN
         v_erro :=
               'O Pré-compromisso não esta na situação de Incluido - os dados não podem ser modificados';
         v_sucesso := 1;
      ELSE
         
-- 
--  verificar com montreal e radis sobre a modificação de informação prazo de execução quando estiver criado a licitação no BDPU
--
         IF      :NEW.val_pre_compromisso > 0
             AND :OLD.num_situacao_pre_compromisso = 1
             AND v_sucesso = 0
         THEN
            
--
--  muda a situação para licitando
--          
            IF      (   :NEW.num_licitacao IS NOT NULL
                     OR :NEW.num_ano_licitacao IS NOT NULL
                     OR :NEW.num_processo IS NOT NULL
                    )
                AND :OLD.num_situacao_pre_compromisso = 1
            THEN
               :NEW.num_situacao_pre_compromisso := 2;

               
--
/*            BEGIN
               v_prazo := ROUND (:NEW.num_prazo_execucao / 30);


--
               UPDATE ifrbde.cad_licitacao

--                  SET tip_situacao_licitacao = 'LIC' , -- NÃO IMPLEMENTADA , POIS OS IDIOTAS DA MONTREAL NÃO TEM ESSE TIPO DE SITUAÇÃO
--  ATUALMENTE -> Situação, estado em que se encontra a licitação. (O Domínio para este atributo deve ser: ATV - Ativa, CAN - Cancelada, CON - Concluída , NPC - Não pre-compromissada e PAR - paralisada )
--
                  SET tip_situacao_licitacao = 'LIC',
                      num_mes_licitacao = v_prazo,
                      cod_licitacao =    :NEW.num_licitacao
                                      || :NEW.num_ano_licitacao
                                      || :NEW.num_processo
                WHERE seq_licitacao = :NEW.seq_licitacao;
            EXCEPTION
               WHEN OTHERS
               THEN
                  v_erro :=
                           'Erro ao atualizar o sequencial da Licitação - '
                        || SQLERRM;
                  v_sucesso := 1;
            END;

*/
--
--
               IF v_sucesso = 0
               THEN
                  IF      UPPER (:NEW.cod_modalidade_licitacao) <> 'DISP'
                      AND UPPER (:NEW.cod_modalidade_licitacao) <> 'INEX'
                  THEN
                     IF    (:NEW.dsc_fundamento_legal IS NULL)
                        OR (:NEW.num_licitacao IS NULL)
                        OR (:NEW.num_ano_licitacao IS NULL)
                        OR (:NEW.num_processo IS NULL)
                        OR (:NEW.num_inciso IS NOT NULL)
                     THEN
                        v_erro :=
                              'Pré-Compromisso - As informações dos Dados da Licitação são obrigatórios - Não informar apenas o Inciso';
                        v_sucesso := 1;
                     END IF;
                  END IF;

                  
--
                  IF    UPPER (:NEW.cod_modalidade_licitacao) = 'DISP'
                     OR UPPER (:NEW.cod_modalidade_licitacao) = 'INEX'
                  THEN
                     IF    (:NEW.dsc_fundamento_legal IS NULL)
                        OR (:NEW.num_licitacao IS NOT NULL)
                        OR (:NEW.num_ano_licitacao IS NOT NULL)
                        OR (:NEW.num_processo IS NULL)
                        OR (:NEW.num_inciso IS NULL)
                     THEN
                        v_erro :=
                              'Pré-Compromisso - As informações dos Dados da Licitação para modalidade "Dispensa" ou "Inexigibilidade" não são preenchidos - somente Inciso e Numero do Processo';
                        v_sucesso := 1;
                     END IF;
                  END IF;
               END IF;
            END IF;
         
--               
         END IF;
      
--         
      END IF;

      
--
      IF v_sucesso = 0
      THEN
         IF :NEW.flg_risco = '1'
         THEN
            :NEW.tax_garantia := 100;
         ELSE
            :NEW.tax_garantia := 0;
         END IF;

         
--
         IF :NEW.flg_execucao = '1'
         THEN
            IF :NEW.tax_execucao <= 0
            THEN
               v_erro :=
                       ' Taxa de Execução não pode ser igual ou menor que 0 ';
               v_sucesso := 1;
            END IF;

            IF :NEW.tax_execucao > 10
            THEN
               v_erro := ' Taxa de Execução não pode ser maior que 10 ';
               v_sucesso := 1;
            END IF;
         ELSE
            :NEW.tax_execucao := 0;
         END IF;
      END IF;
   
--      
/*      IF      v_sucesso = 0
          AND :OLD.num_situacao_pre_compromisso = 2
          AND :NEW.num_situacao_pre_compromisso = 5
      THEN
         BEGIN
            UPDATE ifrbde.cad_revisao_orcamento
               SET seq_licitacao_revisao = NULL
             WHERE cod_situacao_revisao = 'F'
               AND seq_licitacao_revisao = :NEW.seq_licitacao;

            :NEW.num_situacao_pre_compromisso := 1;
            :NEW.val_pre_compromisso := 0;
         EXCEPTION
            WHEN OTHERS
            THEN
               v_erro :=
                        'Erro ao desassociar os orçamentos do pré-compromisso - '
                     || SQLERRM;
               v_sucesso := 1;
         END;
      END IF;
*/
--      
   END IF;

   
--
   IF DELETING
   THEN
      
-- situação que não aparece na tela   
      IF :OLD.num_situacao_pre_compromisso <> 9
      THEN
         v_erro :=
               'Pré-Compromisso não pode ser excluido, mude a situação para Cancelado!!!! ';
         v_sucesso := 1;
      END IF;

      
--
      ifrbde.pck_variaveis.v_pck_seq_carencia_precompr :=
                                                    NVL (:OLD.seq_carencia, 0);
   
--
   END IF;

   
--
   IF v_sucesso <> 0
   THEN
      raise_application_error (-20100, v_erro);
   END IF;
--
EXCEPTION
   WHEN INVALID_NUMBER
   THEN
      raise_application_error (
         -20100,
            'Os Campos de número e ano  de licitação, podem somente ser numericos '
         || v_erro
         || SQLERRM
      );
   WHEN OTHERS
   THEN
      
--
      IF v_sucesso <> 0
      THEN
         raise_application_error (-20100, v_erro);
      ELSE
         raise_application_error (-20100,    ' Erro - '
                                          || SQLERRM);
      END IF;
END;
/

