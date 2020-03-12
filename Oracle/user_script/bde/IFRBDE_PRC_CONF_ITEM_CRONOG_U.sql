CREATE OR REPLACE PROCEDURE PRC_CONF_ITEM_CRONOG_U (v_num_seq_contrato IN NUMBER)
IS
   
--
-- OBJETIVO: executar a carga dos contratos para o arquivo de interface do
-- smartstream chamado conf_item_cronograma_u
--
-- MODIFICATION HISTORY
-- Person      Date    Comments
-- ---------   ------  -------------------------------------------
--
--
   v_erro                     VARCHAR2 (200);
   v_sucesso                  NUMBER (1);
   v_achou                    VARCHAR2 (30);
   v_cnpj                     VARCHAR2 (14);
   v_cnpj_p1                  VARCHAR2 (10);
   v_cnpj_p2                  VARCHAR2 (3);
   v_relacao                  VARCHAR2 (2);
   v_entidade                 VARCHAR2 (5);
   v_cnt_cod                  VARCHAR2 (30);
   
--   v_conta                    VARCHAR2 (10);
   v_resumo                   NUMBER (15);
   v_str_seq_item             VARCHAR2 (4);
   v_str_seq_resumo           VARCHAR2 (3);
   v_str_tipo                 VARCHAR2 (1);
   v_str_parcela              VARCHAR2 (4);
   v_contrato_id              VARCHAR2 (30);
   v_pmt_meth_id              VARCHAR2 (5);
   v_payable_entity_id_oper   VARCHAR2 (5);
   v_prim_amt                 NUMBER (12, 2);
   v_secdy_amt                NUMBER (12, 2);
   v_num_versao_anterior      VARCHAR2 (2);

   CURSOR regc
   IS
      SELECT   a.cnt_cod, a.num_seq_contrato, a.cod_dep_contrato,
               a.num_versao_contrato, b.fir_cnpj, d.num_seq_resumo,
               d.flg_moeda_controle, c.ccp_data_venc, c.ccp_valor,
               c.val_cotacao_crono, c.tip_cronograma, c.num_seq_cronograma,
-               e.rti_conta,
               e.rti_sigla_ss, f.cre_projeto, y.dpp_ncod, x.dep_cod,
               z.dpp_ncod AS reg_oper, w.dep_cod AS dep_oper
          FROM ifrbde.tab_contrato a,
               ifrbde.tab_firma b,
               ifrbde.cad_participantes_contrato g,
               ifrbde.tab_cont_crono_pagamento c,
               ifrbde.cad_resumo_valores d,
               ifrbde.tab_tipo_recurso_item e,
               ifrbde.tab_carencia f,
               ifrbde.tab_dependencia x,
               ifrbde.tab_dependencia_pai y,
               ifrbde.tab_dependencia w,
               ifrbde.tab_dependencia_pai z
         WHERE d.num_versao_contrato_res = c.num_versao_contrato_cron
           AND a.num_versao_contrato = d.num_versao_contrato_res
           AND a.num_seq_contrato = g.num_seq_contrato_part
           AND g.num_fir_cod = b.fir_cod
           AND a.cnt_cre_cod = f.cre_cod
           AND a.num_seq_contrato = d.num_seq_contrato_res
           AND d.num_seq_resumo = c.num_seq_contrato_cron
           AND f.cre_dep_cod = x.dep_cod
           AND x.dep_dpp_cod = y.dpp_cod
           AND a.cod_dep_contrato = w.dep_cod
           AND w.dep_dpp_cod = z.dpp_cod
           AND c.ccp_rti_cod = e.rti_cod
           AND a.num_seq_contrato = v_num_seq_contrato
           AND c.tip_cronograma IN ('DE', 'DA', 'RJ')
      ORDER BY a.cnt_cod,
--               e.rti_conta,
               d.num_seq_resumo,
               SUBSTR (c.tip_cronograma, 1, 1),
               c.ccp_data_venc;

   CURSOR rege
   IS
      SELECT   b.fir_cnpj
          FROM ifrbde.tab_contrato a,
               ifrbde.tab_firma b,
               ifrbde.cad_participantes_contrato g
         WHERE a.num_seq_contrato = g.num_seq_contrato_part
           AND g.num_fir_cod = b.fir_cod
           AND a.num_seq_contrato = v_num_seq_contrato
           AND ROWNUM = 1;

-- Declare program variables as shown above

BEGIN
   v_sucesso := 0;
   v_erro := '';
   v_achou := '';
   v_cnt_cod := 'XX';
   
--   v_conta := 'X';
   v_resumo := 0;
   v_str_seq_item := '1';
   v_str_seq_resumo := '1';
   v_str_parcela := '1';
   v_str_tipo := 'X';

   
--
   FOR regx in rege
   loop
    begin
   FOR regs IN regc
   LOOP
      BEGIN
         v_sucesso := 0;
         v_erro := '';
         v_cnpj := '';
         v_entidade :=    TRIM (TO_CHAR (regs.dpp_ncod, '00'))
                       || TRIM (
                             TO_CHAR (fun_converter_dep (regs.dep_cod), '000')
                          );
         
--
         v_pmt_meth_id :=    TRIM (
                                TO_CHAR (
                                   fun_converter_dep (regs.dep_oper),
                                   '000'
                                )
                             )
                          || TRIM (regs.rti_sigla_ss);
         v_payable_entity_id_oper :=
                  TRIM (TO_CHAR (regs.reg_oper, '00'))
               || TRIM (TO_CHAR (fun_converter_dep (regs.dep_oper), '000'));
         
--
         v_contrato_id := regs.cnt_cod;

         
--
         FOR i IN 1 .. 20
         LOOP
            IF SUBSTR (regx.fir_cnpj, i, 1) NOT IN ('.', '/', '-', ' ')
            THEN
               v_cnpj :=    v_cnpj
                         || SUBSTR (regx.fir_cnpj, i, 1);
            END IF;
         END LOOP;

         
--

         IF LENGTH (v_cnpj) = 14
         THEN
            v_cnpj_p1 := SUBSTR (v_cnpj, 1, 9);
            v_cnpj_p2 := SUBSTR (v_cnpj, 10, 3);
         ELSE
            IF LENGTH (v_cnpj) = 11
            THEN
               v_cnpj_p1 := SUBSTR (v_cnpj, 1, 9);
               v_cnpj_p2 := ' ';
            ELSE
               v_cnpj_p1 := '999999999';
               v_cnpj_p2 := '999';
            END IF;
         END IF;

         
--

--
         IF v_cnt_cod <> regs.cnt_cod
         THEN
            v_str_seq_item := '0001';
            v_str_seq_resumo := '001';
            v_str_parcela := '0001';
            v_cnt_cod := regs.cnt_cod;
            
--            v_conta := regs.rti_conta;
            v_resumo := regs.num_seq_resumo;
            v_str_tipo := SUBSTR (regs.tip_cronograma, 1, 1);
         ELSE
            
/*
            IF v_conta <> regs.rti_conta
            THEN
               null
               v_str_seq_item :=
                   TRIM (TO_CHAR ((  TO_NUMBER (v_str_seq_item)
                                   + 1
                                  ), '0000'));
               v_str_seq_resumo := '001';
               v_str_parcela := '0001';
               v_conta := regs.rti_conta;
               v_resumo := regs.num_seq_resumo;
               v_str_tipo := SUBSTR (regs.tip_cronograma, 1, 1);
            ELSE
*/
            IF v_resumo <> regs.num_seq_resumo
            THEN
               v_str_seq_resumo :=
                  TRIM (TO_CHAR ((  TO_NUMBER (v_str_seq_resumo)
                                  + 1
                                 ), '000'));
               v_str_parcela := '0001';
               v_resumo := regs.num_seq_resumo;
               v_str_tipo := SUBSTR (regs.tip_cronograma, 1, 1);
            ELSE
               IF v_str_tipo <> SUBSTR (regs.tip_cronograma, 1, 1)
               THEN
                  v_str_parcela := '0001';
                  v_str_tipo := SUBSTR (regs.tip_cronograma, 1, 1);
               ELSE
                  v_str_parcela := TRIM (
                                      TO_CHAR (
                                         (  TO_NUMBER (v_str_parcela)
                                          + 1
                                         ),
                                         '0000'
                                      )
                                   );
               END IF;
            END IF;
         
--            END IF;
         END IF;

         
--
-- data do vencimento
--
         regs.ccp_data_venc := ifrbde.fun_verificar_data (regs.ccp_data_venc);
         
--
         v_secdy_amt := 0;
         v_prim_amt := 0;

         IF regs.flg_moeda_controle = '2'
         THEN
            v_secdy_amt := ROUND (regs.ccp_valor / regs.val_cotacao_crono, 2);
         ELSE
            v_prim_amt := regs.ccp_valor;
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
         BEGIN
            SELECT contract_id
              INTO v_achou
              FROM integracao.conf_item_cronograma_u
             WHERE contract_id = v_contrato_id
               AND contract_versao = NVL (regs.num_versao_contrato, '00')
               AND seq_item = TRIM (v_str_seq_item)
               AND codigo_resumo_valor = TRIM (v_str_seq_resumo)
               AND tipo_cronograma = SUBSTR (regs.tip_cronograma, 1, 1)
               AND numero_parcela = TRIM (v_str_parcela);

            UPDATE integracao.conf_item_cronograma_u
               SET vendor_id = v_cnpj_p1,
                   vendor_loc_code = v_cnpj_p2,
                   tipo_valor = 'E',
                   data_vencto = regs.ccp_data_venc,
                   prim_amt = v_prim_amt,
                   secdy_amt = v_secdy_amt,
                   codigo_recurso = TRIM (regs.rti_sigla_ss),
                   sistema_origem_code = '02',
                   pmt_meth_id = v_pmt_meth_id,
                   payable_entity_id_oper = v_payable_entity_id_oper,
                   contract_versao_origem = v_num_versao_anterior,
                   date_changed = SYSDATE,
                   user_id_changed = USER,
                   inactive_ind = '0',
                   active_date = SYSDATE
             WHERE contract_id = v_contrato_id
               AND contract_versao = NVL (regs.num_versao_contrato, '00')
               AND seq_item = TRIM (v_str_seq_item)
               AND codigo_resumo_valor = TRIM (v_str_seq_resumo)
               AND tipo_cronograma = SUBSTR (regs.tip_cronograma, 1, 1)
               AND numero_parcela = TRIM (v_str_parcela);
         EXCEPTION
            WHEN NO_DATA_FOUND
            THEN
               BEGIN
                  INSERT INTO integracao.conf_item_cronograma_u
                              (payable_entity_id, contract_id,
                               contract_versao,
                               seq_item,
                               codigo_resumo_valor,
                               tipo_cronograma,
                               numero_parcela, vendor_id, vendor_loc_code,
                               tipo_valor, data_vencto, prim_amt,
                               secdy_amt, codigo_recurso, vendor_id_rec,
                               vendor_loc_code_rec, sistema_origem_code,
                               contract_versao_origem, date_created,
                               user_id_created, date_changed,
                               user_id_changed, inactive_ind, active_date,
                               chgstamp, pmt_meth_id, payable_entity_id_oper)
                       VALUES (v_entidade, v_contrato_id,
                               NVL (regs.num_versao_contrato, '00'),
                               TRIM (v_str_seq_item),
                               TRIM (v_str_seq_resumo),
                               SUBSTR (regs.tip_cronograma, 1, 1),
                               TRIM (v_str_parcela), v_cnpj_p1, v_cnpj_p2,
                               'E', regs.ccp_data_venc, v_prim_amt,
                               v_secdy_amt, TRIM (regs.rti_sigla_ss), ' ',
                               ' ', '02',
                               v_num_versao_anterior, SYSDATE,
                               USER, SYSDATE,
                               USER, '0', SYSDATE,
                               0, v_pmt_meth_id, v_payable_entity_id_oper);
               EXCEPTION
                  WHEN OTHERS
                  THEN
                     raise_application_error (
                        -20100,
                           'erro ao incluir o registro '
                        || regs.cnt_cod
                        || '-'
                        || SQLERRM
                     );
               END;
            WHEN OTHERS
            THEN
               raise_application_error (
                  -20100,
                     'erro ao selecionar/atualizar o registro '
                  || regs.cnt_cod
                  || '-'
                  || SQLERRM
               );
         END;

         BEGIN
            UPDATE ifrbde.tab_cont_crono_pagamento
               SET num_seq_item = TRIM (v_str_seq_item),
                   cod_resumo_valor = TRIM (v_str_seq_resumo),
                   num_parcela =
                             TRIM (TO_CHAR (TO_NUMBER (v_str_parcela), '000'))
             WHERE num_seq_cronograma = regs.num_seq_cronograma;
         EXCEPTION
            WHEN OTHERS
            THEN
               raise_application_error (
                  -20100,
                     ' Ao Atualizar os numeros do Item , Resumo , Parcela do Cronograma - '
                  || SQLERRM
               );
         END;
      
--
      EXCEPTION
         WHEN OTHERS
         THEN
            raise_application_error (
               -20100,
                  'Erro na execução do loop da Rotina de gravação do Cronograma para o Contrato '
               || regs.cnt_cod
               || ' - '
               || SQLERRM
            );
      END;
   END LOOP;
      END;
   END LOOP;

   
--
   BEGIN
      UPDATE ifrbde.tab_contrato
         SET tip_situacao_contrato = 6,
             dsc_critica_contrato =
                      TO_CHAR (SYSDATE, 'dd/mm/yyyy hh:mi:ss')
                   || ' - Dados do Contrato foram enviados com sucesso '
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
--
EXCEPTION
   WHEN OTHERS
   THEN
      raise_application_error (
         -20100,
            'Erro na Rotina de gravação do Cronograma - '
         || SQLERRM
      );
--
END prc_conf_item_cronog_u; -- Procedure
