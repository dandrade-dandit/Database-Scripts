Create Or Replace PROCEDURE PRC_CONF_TERMO_U (v_num_seq_contrato IN NUMBER)
IS
   
--
-- OBJETIVO: executar a carga dos contratos para o arquivo de interface do
-- smartstream chamado conf_termo
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

   CURSOR regc
   IS
      SELECT a.cnt_cod, a.num_versao_contrato, b.*, x.dep_cod, y.dpp_ncod
        FROM ifrbde.tab_contrato a,
             ifrbde.cad_termo_aditivo_contrato b,
             ifrbde.tab_carencia c,
             ifrbde.tab_dependencia x,
             ifrbde.tab_dependencia_pai y
       WHERE a.num_seq_contrato = b.num_seq_contrato_origem
         AND a.num_versao_contrato = b.num_versao_contrato_ta
         AND a.cnt_cre_cod = c.cre_cod         
         AND c.cre_dep_cod = x.dep_cod
         AND x.dep_dpp_cod = y.dpp_cod
--         AND SUBSTR (a.cnt_cod, 1, 2) <> 'CV'
         AND a.num_versao_contrato <> '00'
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
                       || TRIM (TO_CHAR (regs.dep_cod, '000'));
         v_contrato_id := regs.cnt_cod;

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
-- data do termo
         IF regs.dat_termo_aditivo IS NOT NULL
         THEN
            regs.dat_termo_aditivo :=
                                  fun_verificar_data (regs.dat_termo_aditivo);
         END IF;

         
--
-- data da publicação do termo
         IF regs.dat_publicacao IS NOT NULL
         THEN
            regs.dat_publicacao := fun_verificar_data (regs.dat_publicacao);
         END IF;

         
--
         BEGIN
            SELECT contract_id
              INTO v_achou
              FROM integracao.conf_termo_u
             WHERE contract_id = v_contrato_id
               AND contract_versao = NVL (regs.num_versao_contrato, '00')
               AND contract_numero_termo = regs.num_termo_aditivo;

            UPDATE integracao.conf_termo_u
               SET payable_entity_id = v_entidade,
                   data_termo = regs.dat_termo_aditivo,
                   objeto_desc = SUBSTR (regs.dsc_objeto_termo, 1, 255),
                   publicacao_data =
                           NVL (regs.dat_publicacao, TO_DATE ('01-JAN-1900')),
                   publicacao_numero_dou = NVL (regs.num_dou_publicacao, ' '),
                   publicacao_secao = NVL (regs.num_secao_publicacao, ' '),
                   publicacao_pagina = NVL (regs.num_pagina_publicacao, ' '),
                   tipo_termo = regs.tip_termo_aditivo,
                   sistema_origem_code = '02',
                   contract_versao_origem = '00',
                   date_changed = SYSDATE,
                   user_id_changed = USER,
                   inactive_ind = '0',
                   active_date = SYSDATE
             WHERE contract_id = v_contrato_id
               AND contract_versao = NVL (regs.num_versao_contrato, '00')
               AND contract_numero_termo = regs.num_termo_aditivo;
         EXCEPTION
            WHEN NO_DATA_FOUND
            THEN
               INSERT INTO integracao.conf_termo_u
                           (payable_entity_id, contract_id,
                            contract_versao,
                            contract_numero_termo, data_termo,
                            objeto_desc,
                            publicacao_data,
                            publicacao_numero_dou,
                            publicacao_secao,
                            publicacao_pagina, user_fld_3, user_fld_4,
                            tipo_termo, sistema_origem_code,
                            contract_versao_origem, date_created,
                            user_id_created, date_changed, user_id_changed,
                            inactive_ind, active_date, chgstamp)
                    VALUES (v_entidade, v_contrato_id,
                            NVL (regs.num_versao_contrato, '00'),
                            regs.num_termo_aditivo, regs.dat_termo_aditivo,
                            SUBSTR (regs.dsc_objeto_termo, 1, 255),
                            NVL (
                               regs.dat_publicacao,
                               TO_DATE ('01-JAN-1900')
                            ),
                            NVL (regs.num_dou_publicacao, ' '),
                            NVL (regs.num_secao_publicacao, ' '),
                            NVL (regs.num_pagina_publicacao, ' '), ' ', ' ',
                            regs.tip_termo_aditivo, '02',
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
                         || ' - Dados de termo aditivo do Contrato enviado '
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
END prc_conf_termo_u; -- Procedure

