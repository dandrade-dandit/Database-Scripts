/* Formatted on 2008/01/03 17:06 (Formatter Plus v4.8.0) */
CREATE OR REPLACE PROCEDURE ifrbde.prc_conf_item_resumo_u (
   v_num_seq_contrato   IN   NUMBER
)
IS
--
-- OBJETIVO: executar a carga dos contratos para o arquivo de interface do
-- smartstream chamado conf_item_resumo_u
--
-- MODIFICATION HISTORY
-- Person      Date    Comments
-- ---------   ------  -------------------------------------------
--
--
   v_erro                  VARCHAR2 (200);
   v_sucesso               NUMBER (1);
   v_achou                 VARCHAR2 (30);
   v_res_saldo_0           NUMBER (2);
   v_res_maior_0           NUMBER (2);
   v_entidade              VARCHAR2 (5);
   v_contrato_id           VARCHAR2 (30);
   v_cnt_cod               VARCHAR2 (30);
--   v_conta                 VARCHAR2 (10);
   v_resumo                NUMBER (15);
   v_str_seq_item          VARCHAR2 (4);
   v_str_seq_resumo        VARCHAR2 (3);
   v_perc_garantia         NUMBER (3);
   v_prim_amt              NUMBER (12, 2);
   v_secdy_amt             NUMBER (12, 2);
   v_curr_code_prim        VARCHAR2 (3);
   v_curr_code_secdy       VARCHAR2 (3);
   v_num_versao_anterior   VARCHAR2 (2);

   CURSOR regc
   IS
      SELECT   a.cnt_cod, a.num_versao_contrato, a.num_seq_contrato,
               a.cod_dep_contrato, d.num_seq_resumo, d.flg_moeda_controle,
               x.dep_cod, y.dpp_ncod,
               SUM (NVL (c.val_saldo_crono, 0)) AS val_saldo_resumo,
               SUM (NVL (c.val_saldo_crono_sec, 0)) AS val_saldo_resumo_sec
          FROM ifrbde.tab_contrato a,
               ifrbde.cad_resumo_pagamento b,
               ifrbde.tab_cont_crono_pagamento c,
               ifrbde.cad_resumo_valores d,
               ifrbde.tab_carencia f,
               ifrbde.tab_dependencia x,
               ifrbde.tab_dependencia_pai y,
               ifrbde.tab_tipo_recurso_item z
         WHERE d.num_versao_contrato_res = c.num_versao_contrato_cron
           AND a.num_versao_contrato = d.num_versao_contrato_res
           AND a.cnt_cre_cod = f.cre_cod
           AND a.num_seq_contrato = d.num_seq_contrato_res
           AND d.num_seq_resumo = c.num_seq_contrato_cron
           AND c.num_seq_resumo_pag_retencao = b.num_seq_resumo_pag(+)
           AND (b.cod_tipo_pag_rp = 'P' OR b.cod_tipo_pag_rp IS NULL)
           AND a.num_versao_contrato <> '00'
           AND f.cre_dep_cod = x.dep_cod
           AND x.dep_dpp_cod = y.dpp_cod
           AND c.tip_cronograma IN ('DE', 'DA', 'LR')
           AND c.ccp_rti_cod = z.rti_cod
           AND z.rti_conta <> '000000000'
           AND z.rti_sigla_ss IS NOT NULL
           AND a.num_seq_contrato = v_num_seq_contrato
      GROUP BY a.cnt_cod,
               a.num_versao_contrato,
               a.num_seq_contrato,
               a.cod_dep_contrato,
               d.num_seq_resumo,
               d.flg_moeda_controle,
               x.dep_cod,
               y.dpp_ncod
      ORDER BY 1, 5;
-- Declare program variables as shown above
BEGIN
   v_sucesso := 0;
   v_erro := '';
   v_achou := '';
   v_cnt_cod := 'XX';
   v_res_saldo_0 := 0;
   v_res_maior_0 := 0;
--
--   v_conta := 'X';
--
   v_resumo := 0;
   v_str_seq_item := '1';
   v_str_seq_resumo := '1';

   FOR regs IN regc
   LOOP
      v_sucesso := 0;
      v_erro := '';
      v_perc_garantia := 0;
--
--
      v_prim_amt := 0;
      v_secdy_amt := 0;
      v_curr_code_secdy := ' ';
      v_curr_code_prim := ' ';

/*         IF regs.num_versao_contrato = '00'
         THEN
            IF regs.flg_moeda_controle = '2'
            THEN
               v_secdy_amt := ROUND (regs.val_resumo_sec, 2);
               v_curr_code_secdy := 'US$';
            ELSE
               v_prim_amt := regs.val_resumo;
               v_curr_code_prim := 'R$';
            END IF;
         ELSE
*/
      IF regs.flg_moeda_controle = '2'
      THEN
         v_secdy_amt := ROUND (regs.val_saldo_resumo_sec, 2);
         v_curr_code_secdy := 'US$';

         IF v_secdy_amt = 0
         THEN
            v_res_saldo_0 := v_res_saldo_0 + 1;
         END IF;

         v_res_maior_0 := v_res_maior_0 + 1;
      ELSE
         v_prim_amt := regs.val_saldo_resumo;
         v_curr_code_prim := 'R$';

         IF v_prim_amt = 0
         THEN
            v_res_saldo_0 := v_res_saldo_0 + 1;
         END IF;

         v_res_maior_0 := v_res_maior_0 + 1;
      END IF;

--
--         END IF;
--
--
      IF v_prim_amt > 0 OR v_secdy_amt > 0
      THEN
--
         v_entidade :=
               TRIM (TO_CHAR (regs.dpp_ncod, '00'))
            || TRIM (TO_CHAR (fun_converter_dep (regs.dep_cod), '000'));
--
         v_contrato_id := regs.cnt_cod;
 --
-- converte a entidade beneficiaria de acordo com os ajustes colocados na fun��o
--
         v_entidade := fun_converter_benef (regs.cnt_cod, v_entidade);

--
         IF v_entidade = 'ERRO'
         THEN
            raise_application_error
               (-20100,
                   ' Erro na convers�o da entidade beneficiaria do contrato '
                || v_contrato_id
                || ' - '
                || SQLERRM
               );
         END IF;

--
--
         IF v_cnt_cod <> regs.cnt_cod
         THEN
            v_str_seq_item := '0001';
            v_str_seq_resumo := '001';
            v_cnt_cod := regs.cnt_cod;
            v_resumo := regs.num_seq_resumo;
         ELSE
            v_str_seq_resumo :=
                   TRIM (TO_CHAR ((TO_NUMBER (v_str_seq_resumo) + 1), '000'));
         END IF;

         IF NVL (regs.num_versao_contrato, '00') <> '00'
         THEN
            v_num_versao_anterior :=
               TRIM (TO_CHAR (  TO_NUMBER (NVL (regs.num_versao_contrato,
                                                '00')
                                          )
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
              FROM integracao.conf_item_resumo_u
             WHERE contract_id = v_contrato_id
               AND contract_versao = NVL (regs.num_versao_contrato, '00')
               AND seq_item = TRIM (v_str_seq_item)
               AND codigo_resumo_valor = TRIM (v_str_seq_resumo);

            UPDATE integracao.conf_item_resumo_u
               SET payable_entity_id = v_entidade,
                   tipo_valor = 'E',
                   curr_code = v_curr_code_prim,
                   curr_code_secdy = v_curr_code_secdy,
                   ind_curr_code_controle = regs.flg_moeda_controle,
                   prim_amt = v_prim_amt,
                   secdy_amt = v_secdy_amt,
                   data_ultimo_reajuste = TO_DATE ('01-JAN-1900'),
                   data_prox_reajuste = TO_DATE ('01-JAN-1900'),
                   user_fld_3 = ' ',
                   user_fld_4 = ' ',
                   user_date_2 = TO_DATE ('01-JAN-1900'),
                   user_amt_1 = v_perc_garantia,
                   sistema_origem_code = '02',
                   contract_versao_origem = v_num_versao_anterior,
                   date_changed = SYSDATE,
                   user_id_changed = USER,
                   inactive_ind = '0',
                   active_date = SYSDATE
             WHERE contract_id = v_contrato_id
               AND contract_versao = NVL (regs.num_versao_contrato, '00')
               AND seq_item = TRIM (v_str_seq_item)
               AND codigo_resumo_valor = TRIM (v_str_seq_resumo);
         EXCEPTION
            WHEN NO_DATA_FOUND
            THEN
               INSERT INTO integracao.conf_item_resumo_u
                           (payable_entity_id, contract_id,
                            contract_versao,
                            seq_item, codigo_resumo_valor,
                            tipo_valor, curr_code, curr_code_secdy,
                            ind_curr_code_controle, prim_amt,
                            secdy_amt, data_ultimo_reajuste,
                            data_prox_reajuste, user_fld_3, user_fld_4,
                            user_date_2, user_amt_1, sistema_origem_code,
                            contract_versao_origem, date_created,
                            user_id_created, date_changed, user_id_changed,
                            inactive_ind, active_date, chgstamp
                           )
                    VALUES (v_entidade, v_contrato_id,
                            NVL (regs.num_versao_contrato, '00'),
                            TRIM (v_str_seq_item), TRIM (v_str_seq_resumo),
                            'E', v_curr_code_prim, v_curr_code_secdy,
                            regs.flg_moeda_controle, v_prim_amt,
                            v_secdy_amt, TO_DATE ('01-JAN-1900'),
                            TO_DATE ('01-JAN-1900'), ' ', ' ',
                            TO_DATE ('01-JAN-1900'), v_perc_garantia, '02',
                            v_num_versao_anterior, SYSDATE,
                            USER, SYSDATE, USER,
                            '0', SYSDATE, 0
                           );
            WHEN OTHERS
            THEN
               raise_application_error (-20100, SQLERRM);
         END;
      END IF;
--
   END LOOP;

   IF v_res_saldo_0 <> v_res_maior_0
   THEN
      BEGIN
         UPDATE ifrbde.tab_contrato
            SET dsc_critica_contrato =
                      TO_CHAR (SYSDATE, 'dd/mm/yyyy hh:mi:ss')
                   || ' - Dados dos Itens de Resumo do Contrato foram enviados '
          WHERE num_seq_contrato = v_num_seq_contrato;
      EXCEPTION
         WHEN OTHERS
         THEN
            raise_application_error
               (-20100,
                   'Erro ao Atualizar Situa��o do Contrato e as Criticas para Envio ao SmartStream '
                || SQLERRM
               );
      END;
   ELSE
      raise_application_error
         (-20100,
          'N�o existe resumos para enviar a financeira  - rotina abortada ...... '
         );
   END IF;
--
EXCEPTION
   WHEN OTHERS
   THEN
      raise_application_error
                     (-20100,
                         ' erro ao executar a rotina de cria��o dos resumos '
                      || ' - '
                      || SQLERRM
                     );
END prc_conf_item_resumo_u;                                       -- Procedure
/

-- Grants for Procedure
--GRANT EXECUTE ON ifrbde.prc_conf_item_resumo_u TO bde_geral
--/


-- End of DDL Script for Procedure IFRBDE.PRC_CONF_ITEM_RESUMO_U

