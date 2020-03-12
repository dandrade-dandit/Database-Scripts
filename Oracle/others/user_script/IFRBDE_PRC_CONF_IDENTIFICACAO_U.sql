Create Or Replace PROCEDURE PRC_CONF_IDENTIFICACAO_U (v_num_seq_contrato IN NUMBER)
IS
   
--
-- OBJETIVO: executar a carga dos contratos para o arquivo de interface do
-- smartstream chamado conf_identificação
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
   v_projeto               VARCHAR2 (8);
   v_contrato_id           VARCHAR2 (30);
   v_num_versao_anterior   VARCHAR2 (2);
   v_custo                 VARCHAR2 (6);

   CURSOR regc
   IS
      SELECT a.*, b.*, x.dep_cod, y.dpp_ncod, b.cre_projeto AS programa,
             x.dep_tipo AS tipo_dependencia, x.dep_sigla AS sigla_dependencia
        FROM ifrbde.tab_contrato a,
             ifrbde.tab_carencia b,
             ifrbde.tab_dependencia x,
             ifrbde.tab_dependencia_pai y
       WHERE a.cnt_cre_cod = b.cre_cod
         AND b.cre_dep_cod = x.dep_cod
         AND x.dep_dpp_cod = y.dpp_cod
--         AND SUBSTR (a.cnt_cod, 1, 2) <> 'CV'
         AND a.num_seq_contrato = v_num_seq_contrato;
-- Declare program variables as shown above
BEGIN
   v_sucesso := 0;
   v_erro := '';
   v_achou := '';

   FOR regs IN regc
   LOOP
      BEGIN
         v_sucesso := 0;
         v_projeto := '';
         v_erro := '';
         v_entidade :=    TRIM (TO_CHAR (regs.dpp_ncod, '00'))
                       || TRIM (
                             TO_CHAR (fun_converter_dep (regs.dep_cod), '000')
                          );
         v_contrato_id := regs.cnt_cod;

         IF regs.cre_projeto = 'S'
         THEN
            v_projeto := 'SEDE    ';
         ELSE
            v_projeto := 'REGIONAL';
         END IF;

         
--

         IF NVL (regs.num_versao_contrato, '00') <> '00'
         THEN
            v_num_versao_anterior :=
                  TRIM (
                     TO_CHAR (
                          TO_NUMBER (NVL (regs.num_versao_contrato, '00'))
                        - 1,
                        '00'
                     )
                  );
         ELSE
            v_num_versao_anterior := '00';
         END IF;

         
--

         IF regs.programa = 'S'
         THEN
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
              FROM integracao.conf_identificacao_u
             WHERE contract_id = v_contrato_id
               AND contract_versao = NVL (regs.num_versao_contrato, '00');

            UPDATE integracao.conf_identificacao_u
               SET payable_entity_id = v_entidade,
                   contract_desc = SUBSTR (regs.cnt_justificativa_cre, 1, 70),
                   contract_status_code = 'IC',
                   contract_prev_status_code = 'IC',
                   contract_type = TRIM (SUBSTR (v_contrato_id, 8, 2)),
                   contract_sub_type = '0001',
                   contract_id_vendor =    v_projeto
                                        || ' Carencia => '
                                        || TO_CHAR (regs.cnt_cre_cod),
                   codigo_mod_contratacao = 'CONC',
                   manager_id = v_custo,
                   security_code = ' ',
                   sistema_origem_code = '02',
                   contract_versao_origem = v_num_versao_anterior,
                   date_changed = SYSDATE,
                   user_id_changed = USER,
                   inactive_ind = '0',
                   active_date = SYSDATE
             WHERE contract_id = v_contrato_id
               AND contract_versao = NVL (regs.num_versao_contrato, '00');
         EXCEPTION
            WHEN NO_DATA_FOUND
            THEN
               INSERT INTO integracao.conf_identificacao_u
                           (payable_entity_id, contract_id,
                            contract_versao,
                            contract_desc, contract_status_code,
                            contract_prev_status_code, contract_type,
                            contract_sub_type,
                            contract_id_vendor,
                            codigo_mod_contratacao, manager_id,
                            security_code, sistema_origem_code,
                            contract_versao_origem, date_created,
                            user_id_created, date_changed, user_id_changed,
                            inactive_ind, active_date, chgstamp)
                    VALUES (v_entidade, v_contrato_id,
                            NVL (regs.num_versao_contrato, '00'),
                            SUBSTR (regs.cnt_justificativa_cre, 1, 70), 'IC',
                            'IC', TRIM (SUBSTR (v_contrato_id, 8, 2)),
                            '0001',
                               v_projeto
                            || ' Carencia => '
                            || TO_CHAR (regs.cnt_cre_cod),
                            'CONC', v_custo,
                            ' ', '02',
                            v_num_versao_anterior, SYSDATE,
                            USER, SYSDATE, USER,
                            '0', SYSDATE, 0);
            WHEN OTHERS
            THEN
               raise_application_error (
                  -20100,
                     ' Erro ao selecionar o registro '
                  || regs.cnt_cod
                  || ' - '
                  || SQLERRM
               );
         END;

         
--
         BEGIN
            UPDATE ifrbde.tab_contrato
               SET dsc_critica_contrato =
                            TO_CHAR (SYSDATE, 'dd/mm/yyyy hh:mi:ss')
                         || ' - Dados de Identificação do Contrato enviado '
             WHERE num_seq_contrato = v_num_seq_contrato;
         EXCEPTION
            WHEN OTHERS
            THEN
               raise_application_error (
                  -20100,
                     'Erro ao Atualizar Situação do Contrato e as Criticas para Envio ao SmartStream '
                  || SQLERRM
               );
         END;
      
--
      EXCEPTION
         WHEN OTHERS
         THEN
            raise_application_error (
               -20100,
                  ' Erro ao processar a rotina de identificação do contrato'
               || ' - '
               || SQLERRM
            );
      END;
   END LOOP;
END prc_conf_identificacao_u; -- Procedure
