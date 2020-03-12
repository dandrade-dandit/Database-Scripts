CREATE OR REPLACE PROCEDURE PRC_VERSAO_CONF_ITEM_ACCT_U (v_num_seq_contrato IN varchar2 , v_versao in varchar2)
IS
   
--
-- OBJETIVO: executar a carga dos contratos para o arquivo de interface do
-- smartstream chamado conf_item_acct_distin_u
--
-- MODIFICATION HISTORY
-- Person      Date    Comments
-- ---------   ------  -------------------------------------------
--
--
   v_erro                  VARCHAR2 (200);
   v_sucesso               NUMBER (1);
   v_achou                 VARCHAR2 (30);
   v_entidade              VARCHAR2 (5);
   v_contrato_id           VARCHAR2 (30);
   v_cnt_cod               VARCHAR2 (30);
   v_str_seq_item          VARCHAR2 (5);
   v_conta                 VARCHAR2 (10);
   v_conta_dv              VARCHAR2 (10);
   v_num_versao_anterior   VARCHAR2 (2);
   v_projeto               VARCHAR2 (4);
   v_custo                 VARCHAR2 (6);

   CURSOR regc
   IS
      SELECT DISTINCT a.*, e.rti_conta, x.dep_cod, y.dpp_ncod,
                      f.cre_projeto AS programa,
                      x.dep_tipo AS tipo_dependencia,
                      x.dep_sigla AS sigla_dependencia
                 FROM ifrbde.tab_contrato a,
                      ifrbde.tab_cont_crono_pagamento c,
                      ifrbde.cad_resumo_valores d,
                      ifrbde.tab_tipo_recurso_item e,
                      ifrbde.tab_carencia f,
                      ifrbde.tab_dependencia x,
                      ifrbde.tab_dependencia_pai y
                WHERE a.cnt_cre_cod = f.cre_cod
                  AND a.num_seq_contrato = d.num_seq_contrato_res
                  AND d.num_seq_resumo = c.num_seq_contrato_cron
                  AND f.cre_dep_cod = x.dep_cod
                  AND x.dep_dpp_cod = y.dpp_cod
                  AND c.ccp_rti_cod = e.rti_cod
                  AND a.cnt_cod = v_num_seq_contrato
                  and c.num_versao_contrato_cron = v_versao
             ORDER BY a.cnt_cod, e.rti_conta;

-- Declare program variables as shown above

BEGIN
   v_sucesso := 0;
   v_erro := '';
   v_achou := '';
   v_cnt_cod := 'XX';
   v_str_seq_item := '1';

   FOR regs IN regc
   LOOP
      BEGIN
         v_sucesso := 0;
         v_erro := '';
         
--
         v_entidade :=    TRIM (TO_CHAR (regs.dpp_ncod, '00'))
                       || TRIM (TO_CHAR (regs.dep_cod, '000'));
         
--
         v_contrato_id := regs.cnt_cod;

         
--
         IF v_cnt_cod <> regs.cnt_cod
         THEN
            v_str_seq_item := '0001';
            v_cnt_cod := regs.cnt_cod;
--         ELSE
--            v_str_seq_item :=
--                   TRIM (TO_CHAR ((  TO_NUMBER (v_str_seq_item)
--                                   + 1
--                                  ), '0000'));
         END IF;

         
--
         v_conta := '';

         FOR i IN 1 .. 10
         LOOP
            IF SUBSTR (regs.rti_conta, i, 1) NOT IN ('.', '/', '-', ' ')
            THEN
               v_conta :=    v_conta
                          || SUBSTR (regs.rti_conta, i, 1);
            END IF;
         END LOOP;

         v_conta_dv := v_conta;

         
--

         IF NVL (v_versao, '00') <> '00'
         THEN
            v_num_versao_anterior :=
                  TRIM (
                     TO_CHAR (
                          TO_NUMBER (NVL (v_versao, '00'))
                        - 1,
                        '00'
                     )
                  );
         ELSE
            v_num_versao_anterior := '00';
         END IF;

         IF regs.programa = 'S'
         THEN
            v_projeto := '9500';

            IF      SUBSTR (TRIM (UPPER (regs.tipo_dependencia)), 1, 2) =
                                                                         'SR'
                AND TRIM (UPPER (regs.sigla_dependencia)) = 'SEDE'
            THEN
               v_custo := '201310';
            ELSE
               IF      SUBSTR (TRIM (UPPER (regs.tipo_dependencia)), 1, 2) =
                                                                         'SR'
                   AND TRIM (UPPER (regs.sigla_dependencia)) <> 'SEDE'
               THEN
                  v_custo := '201309';
               ELSE
                  IF      SUBSTR (TRIM (UPPER (regs.tipo_dependencia)), 1, 4) =
                                                                       'AERO'
                      AND TRIM (UPPER (regs.sigla_dependencia)) <> 'SEDE'
                  THEN
                     v_custo := '201309';
                  ELSE
                     IF      SUBSTR (
                                TRIM (UPPER (regs.tipo_dependencia)),
                                1,
                                3
                             ) = 'GNA'
                         AND TRIM (UPPER (regs.sigla_dependencia)) <> 'SEDE'
                     THEN
                        v_custo := '141106';
                     ELSE
                        v_custo := ' ';
                     END IF;
                  END IF;
               END IF;
            END IF;
         ELSE
            v_projeto := '9501';

            IF      (   SUBSTR (TRIM (UPPER (regs.tipo_dependencia)), 1, 2) =
                                                                         'SR'
                     OR SUBSTR (TRIM (UPPER (regs.tipo_dependencia)), 1, 4) =
                                                                       'AERO'
                    )
                AND TRIM (UPPER (regs.sigla_dependencia)) <> 'SEDE'
            THEN
               v_custo := '201309';
            ELSE
               IF      SUBSTR (TRIM (UPPER (regs.tipo_dependencia)), 1, 3) =
                                                                        'GNA'
                   AND TRIM (UPPER (regs.sigla_dependencia)) <> 'SEDE'
               THEN
                  v_custo := '141106';
               ELSE
                  v_custo := ' ';
               END IF;
            END IF;
         END IF;

         
--
         BEGIN
            SELECT contract_id
              INTO v_achou
              FROM integracao.conf_item_acct_distin_u
             WHERE contract_id = v_contrato_id
               AND contract_versao = NVL (v_versao, '00')
               AND seq_item = TRIM (v_str_seq_item)
               AND dependencia = TRIM (TO_CHAR (regs.cod_dep_contrato, '000'))
               AND conta = v_conta_dv;

            UPDATE integracao.conf_item_acct_distin_u
               SET payable_entity_id = v_entidade,
                   type_account_dist = '00001',
                   int_tipo_distr = '1',
                   per_valor_distr = 100,
                   projeto = v_projeto,
                   custo = v_custo,
                   sistema_origem_code = '02',
                   contract_versao_origem = v_num_versao_anterior,
                   date_changed = SYSDATE,
                   user_id_changed = USER,
                   inactive_ind = '0',
                   active_date = SYSDATE
             WHERE contract_id = v_contrato_id
               AND contract_versao = NVL (v_versao, '00')
               AND seq_item = TRIM (v_str_seq_item)
               AND dependencia = TRIM (TO_CHAR (regs.cod_dep_contrato, '000'))
               AND conta = v_conta_dv;
         EXCEPTION
            WHEN NO_DATA_FOUND
            THEN
               INSERT INTO integracao.conf_item_acct_distin_u
                           (payable_entity_id, contract_id,
                            contract_versao,
                            seq_item, type_account_dist, ldr_entity_id,
                            dependencia,
                            conta, programa, projeto, custo, int_tipo_distr,
                            per_valor_distr, sistema_origem_code,
                            contract_versao_origem, date_created,
                            user_id_created, date_changed, user_id_changed,
                            inactive_ind, active_date, chgstamp)
                    VALUES (v_entidade, v_contrato_id,
                            NVL (v_versao, '00'),
                            TRIM (v_str_seq_item), '00001', 'INFRA',
                            TRIM (TO_CHAR (regs.cod_dep_contrato, '000')),
                            v_conta_dv, ' ', v_projeto, v_custo, '1',
                            100, '02',
                            v_num_versao_anterior, SYSDATE,
                            USER, SYSDATE, USER,
                            '0', SYSDATE, 0);
            WHEN OTHERS
            THEN
               raise_application_error (
                  -20100,
                     'Erro ao atualizar ou incluir o registro'
                  || regs.cnt_cod
                  || '-'
                  || SQLERRM
               );
         END;

         
--
      EXCEPTION
         WHEN OTHERS
         THEN
            raise_application_error (
               -20100,
                  ' erro na rotina de gravar a contas contabeis do item '
               || regs.cnt_cod
               || ' - '
               || SQLERRM
            );
      END;
   END LOOP;
END PRC_VERSAO_CONF_ITEM_ACCT_U; -- Procedure
