Create Or Replace PROCEDURE PRC_CONF_DATAS_U (v_num_seq_contrato IN NUMBER)
IS
   
--
-- OBJETIVO: executar a carga dos contratos para o arquivo de interface do
-- smartstream chamado conf_datas_u
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
   v_contrato_id           VARCHAR2 (100);
   v_num_versao_anterior   VARCHAR2 (2);

   CURSOR regc
   IS
      SELECT a.*, x.dep_cod, y.dpp_ncod
        FROM ifrbde.tab_contrato a,
             ifrbde.tab_dependencia x,
             ifrbde.tab_dependencia_pai y,
             ifrbde.tab_carencia z
       WHERE a.cnt_cre_cod = z.cre_cod
         AND z.cre_dep_cod = x.dep_cod
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
         v_erro := '';
         v_contrato_id := '';
         v_entidade :=    TRIM (TO_CHAR (regs.dpp_ncod, '00'))
                       || TRIM (
                             TO_CHAR (fun_converter_dep (regs.dep_cod), '000')
                          );
         v_contrato_id := regs.cnt_cod;

         
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
-- data da proposta
         regs.cnt_data_proposta := fun_verificar_data (regs.cnt_data_proposta);
         
-- data do contrato
         regs.cnt_data := fun_verificar_data (regs.cnt_data);
         
-- data de termino
         regs.dat_termino_contrato :=
                                fun_verificar_data (regs.dat_termino_contrato);
         
-- data inicio
         regs.cnt_data_inicio := fun_verificar_data (regs.cnt_data_inicio);

         
--

         BEGIN
            SELECT contract_id
              INTO v_achou
              FROM integracao.conf_datas_u
             WHERE contract_id = v_contrato_id
               AND contract_versao = NVL (regs.num_versao_contrato, '00');

            UPDATE integracao.conf_datas_u
               SET payable_entity_id = v_entidade,
                   proposta_data = regs.cnt_data_proposta,
                   assinatura_data = regs.cnt_data,
                   tipo_prazo = 'D',
                   quant_prazo =   regs.cnt_prazo_exec
                                 + regs.cnt_prazo_adit,
                   entrega_data = regs.dat_termino_contrato,
                   garantia_data = regs.cnt_data_inicio,
                   inicio_data = regs.cnt_data_inicio,
                   termino_prev_data = regs.dat_termino_contrato,
                   termino_data = regs.dat_termino_contrato,
                   sistema_origem_code = '02',
                   contract_versao_origem = v_num_versao_anterior,
                   date_created = SYSDATE,
                   date_changed = SYSDATE,
                   user_id_changed = USER,
                   inactive_ind = '0',
                   active_date = SYSDATE
             WHERE contract_id = v_contrato_id
               AND contract_versao = NVL (regs.num_versao_contrato, '00');
         EXCEPTION
            WHEN NO_DATA_FOUND
            THEN
               BEGIN
                  INSERT INTO integracao.conf_datas_u
                              (payable_entity_id, contract_id,
                               contract_versao,
                               proposta_data, assinatura_data, tipo_prazo,
                               quant_prazo,
                               entrega_data,
                               garantia_data, inicio_data,
                               termino_prev_data,
                               termino_data, sistema_origem_code,
                               contract_versao_origem, date_created,
                               user_id_created, date_changed,
                               user_id_changed, inactive_ind, active_date,
                               chgstamp)
                       VALUES (v_entidade, v_contrato_id,
                               NVL (regs.num_versao_contrato, '00'),
                               regs.cnt_data_proposta, regs.cnt_data, 'D',
                                 regs.cnt_prazo_exec
                               + regs.cnt_prazo_adit,
                               regs.dat_termino_contrato,
                               regs.cnt_data_inicio, regs.cnt_data_inicio,
                               regs.dat_termino_contrato,
                               regs.dat_termino_contrato, '02',
                               v_num_versao_anterior, SYSDATE,
                               USER, SYSDATE,
                               USER, '0', SYSDATE,
                               0);
               EXCEPTION
                  WHEN OTHERS
                  THEN
                     raise_application_error (
                        -20100,
                           ' erro ao incluir o registro '
                        || regs.cnt_cod
                        || ' - '
                        || SQLERRM
                     );
               END;
            WHEN OTHERS
            THEN
               raise_application_error (
                  -20100,
                     ' erro ao selecionar o registro '
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
                         || ' - Dados de Datas e Prazos do Contrato enviados '
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
                  ' Erro ao executar a rotina de datas do contrato '
               || ' - '
               || SQLERRM
            );
      END;
   END LOOP;
END prc_conf_datas_u; -- Procedure
