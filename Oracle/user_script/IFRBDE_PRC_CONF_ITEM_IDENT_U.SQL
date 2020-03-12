Create Or Replace PROCEDURE PRC_CONF_ITEM_IDENT_U (v_num_seq_contrato IN NUMBER)
IS
   
--
-- OBJETIVO: executar a carga dos contratos para o arquivo de interface do
-- smartstream chamado conf_item_ident_u
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
   v_str_seq_item          VARCHAR2 (4);
   v_conta                 VARCHAR2 (10);
   v_conta_dv              VARCHAR2 (11);
   v_conta_desc            VARCHAR2 (40);
   v_num_versao_anterior   VARCHAR2 (2);

   CURSOR regc
   IS
      SELECT DISTINCT a.cnt_cod, a.num_seq_contrato, a.cod_dep_contrato,
                      a.num_versao_contrato, e.rti_conta, x.dep_cod,
                      y.dpp_ncod
                 FROM ifrbde.tab_contrato a,
                      ifrbde.tab_firma b,
                      ifrbde.cad_participantes_contrato g,
                      ifrbde.tab_cont_crono_pagamento c,
                      ifrbde.cad_resumo_valores d,
                      ifrbde.tab_tipo_recurso_item e,
                      ifrbde.tab_carencia f,
                      ifrbde.tab_dependencia x,
                      ifrbde.tab_dependencia_pai y
                WHERE d.num_versao_contrato_res = c.num_versao_contrato_cron
                  AND a.num_versao_contrato = d.num_versao_contrato_res
                  AND a.tip_situacao_contrato IN (2, 4)
                  AND a.tip_contrato = 1
                  AND a.num_seq_contrato = g.num_seq_contrato_part
                  AND g.num_fir_cod = b.fir_cod
                  AND a.cnt_cre_cod = f.cre_cod
                  AND a.num_seq_contrato = d.num_seq_contrato_res
                  AND d.num_seq_resumo = c.num_seq_contrato_cron
                  AND f.cre_dep_cod = x.dep_cod
                  AND x.dep_dpp_cod = y.dpp_cod
                  AND c.ccp_rti_cod = e.rti_cod
--                  AND SUBSTR (a.cnt_cod, 1, 2) <> 'CV'
--                  AND a.flg_numero_padrao = 'S'
                  AND c.tip_cronograma IN ('DE', 'DA', 'RJ')
--                  AND a.cnt_cod = 'TC0065-EG/1998/0015'
                  AND a.num_seq_contrato = v_num_seq_contrato
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
                       || TRIM (
                             TO_CHAR (fun_converter_dep (regs.dep_cod), '000')
                          );
         
--
         v_contrato_id := regs.cnt_cod;

         
--
         IF v_cnt_cod <> regs.cnt_cod
         THEN
            v_str_seq_item := '0001';
            v_cnt_cod := regs.cnt_cod;
         
/*         ELSE
            v_str_seq_item :=
                   TRIM (TO_CHAR ((  TO_NUMBER (v_str_seq_item)
                                   + 1
                                  ), '0000'));
*/
         END IF;

         
--
         v_conta := '';
         
--         FOR i IN 1 .. 10
--         LOOP
--            IF SUBSTR (regs.rti_conta, i, 1) NOT IN ('.', '/', '-', ' ')
--            THEN
--               v_conta :=    v_conta
--                          || SUBSTR (regs.rti_conta, i, 1);
--            END IF;
--         END LOOP;


--      v_conta_dv := '0'|| TRIM (v_conta)|| '0';
--         v_conta_dv := ' ';
--         v_conta_desc := '';

/*         BEGIN
            SELECT SUBSTR (rti_desc, 1, 35)
              INTO v_conta_desc
              FROM ifrbde.tab_tipo_recurso_item
             WHERE rti_conta = v_conta AND ROWNUM = 1;

*/
--
         v_conta_dv := '03130100140';
         v_conta_desc := 'RECURSOS PROPRIOS';

         
--
/*         EXCEPTION
            WHEN OTHERS
            THEN
               v_conta_desc := 'Erro - Na Descrição Da Conta';
         END;
*/

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
         BEGIN
            SELECT contract_id
              INTO v_achou
              FROM integracao.conf_item_ident_u
             WHERE contract_id = v_contrato_id
               AND contract_versao = NVL (regs.num_versao_contrato, '00')
               AND seq_item = TRIM (v_str_seq_item);

            UPDATE integracao.conf_item_ident_u
               SET payable_entity_id = v_entidade,
                   tipo_aquisicao = 'OB',
                   qty = 1,
                   unit_of_measure = 'UNID',
                   item_id = NVL (TRIM (v_conta_dv), ' '),
                   item_descp = v_conta_desc,
                   sistema_origem_code = '02',
                   contract_versao_origem = v_num_versao_anterior,
                   date_changed = SYSDATE,
                   user_id_changed = USER,
                   inactive_ind = '0',
                   active_date = SYSDATE
             WHERE contract_id = v_contrato_id
               AND contract_versao = NVL (regs.num_versao_contrato, '00')
               AND seq_item = TRIM (v_str_seq_item);
         EXCEPTION
            WHEN NO_DATA_FOUND
            THEN
               INSERT INTO integracao.conf_item_ident_u
                           (payable_entity_id, contract_id,
                            contract_versao,
                            seq_item, tipo_aquisicao, qty, unit_of_measure,
                            item_id, item_descp, sistema_origem_code,
                            contract_versao_origem, date_created,
                            user_id_created, date_changed, user_id_changed,
                            inactive_ind, active_date, chgstamp)
                    VALUES (v_entidade, v_contrato_id,
                            NVL (regs.num_versao_contrato, '00'),
                            TRIM (v_str_seq_item), 'OB', 1, 'UNID',
                            NVL (TRIM (v_conta_dv), ' '), v_conta_desc, '02',
                            v_num_versao_anterior, SYSDATE,
                            USER, SYSDATE, USER,
                            '0', SYSDATE, 0);
            WHEN OTHERS
            THEN
               raise_application_error (
                  -20100,
                     ' erro na seleção/alteração/inclusão do registro '
                  || regs.cnt_cod
                  || '-'
                  || SQLERRM
               );
         END;

         
--
         BEGIN
            UPDATE ifrbde.tab_contrato
               SET dsc_critica_contrato =
                            TO_CHAR (SYSDATE, 'dd/mm/yyyy hh:mi:ss')
                         || ' - Dados de Identificação de itens enviados '
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
                  ' Erro na rotina de execução dos itens do contrato '
               || regs.cnt_cod
               || ' - '
               || SQLERRM
            );
      END;
   END LOOP;
END prc_conf_item_ident_u; -- Procedure
