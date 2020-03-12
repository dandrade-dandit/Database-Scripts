CREATE OR REPLACE PROCEDURE ifrbde.prc_conf_sol_pag_outros_u (
   v_num_seq_resumo_pag   IN   NUMBER
)
IS
--
-- OBJETIVO: executar a carga dos contratos para o arquivo de interface do
-- smartstream chamado conf_sol_pag_outros_u
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
   v_contrato_id              VARCHAR2 (30);
   v_pmt_meth_id              VARCHAR2 (5);
   v_payable_entity_id_oper   VARCHAR2 (5);
   v_val_acr_ret              NUMBER (12, 2);
   v_acr_ret                  VARCHAR2 (4);
   v_per_ret_acr              NUMBER (6, 3);
   v_obs                      VARCHAR2 (93);
   v_num_versao_anterior      VARCHAR2 (2);

--
   CURSOR regc
   IS
      SELECT DISTINCT a.cnt_cod, a.num_seq_contrato, a.num_versao_contrato,
                      a.cod_dep_contrato, b.fir_cnpj, d.num_seq_resumo,
                      c.num_fatura_pagamento, i.dat_pagamento,
                      c.val_faturado, c.cod_tipo_pag, c.num_seq_pag_contrato,
                      e.rti_conta, d.flg_moeda_controle, e.rti_sigla_ss,
                      f.cre_projeto, y.dpp_ncod, x.dep_cod, i.dsc_glosa_rp,
                      i.dsc_retencao_rp, i.dsc_solicitacao_rp
                 FROM ifrbde.tab_contrato a,
                      ifrbde.tab_firma b,
                      ifrbde.cad_pagamento_contrato c,
                      ifrbde.cad_resumo_valores d,
                      ifrbde.tab_tipo_recurso_item e,
                      ifrbde.tab_carencia f,
                      ifrbde.cad_resumo_pagamento i,
                      ifrbde.tab_dependencia x,
                      ifrbde.tab_dependencia_pai y
                WHERE a.num_versao_contrato = i.num_versao_contrato_pag
                  AND a.num_versao_contrato = d.num_versao_contrato_res
                  AND i.num_seq_entidade_pag = b.fir_cod
                  AND a.cnt_cre_cod = f.cre_cod
                  AND a.num_seq_contrato = d.num_seq_contrato_res
                  AND f.cre_dep_cod = x.dep_cod
                  AND x.dep_dpp_cod = y.dpp_cod
                  AND c.cod_recurso = e.rti_cod
                  AND d.num_seq_resumo = i.num_seq_pag_contrato_rp
                  AND i.num_seq_resumo_pag = c.num_seq_contrato_pag
                  AND i.num_seq_resumo_pag = v_num_seq_resumo_pag
             ORDER BY a.cnt_cod,
                      d.flg_moeda_controle,
                      i.dat_pagamento,
                      c.num_fatura_pagamento;
-- Declare program variables as shown above
BEGIN
   v_sucesso := 0;
   v_erro := '';
   v_achou := '';

--
   FOR regs IN regc
   LOOP
      BEGIN
         v_sucesso := 0;
         v_erro := '';
         v_cnpj := '';
         v_obs := '';
         v_entidade :=
               TRIM (TO_CHAR (regs.dpp_ncod, '00'))
            || TRIM (TO_CHAR (fun_converter_dep (regs.dep_cod), '000'));
--
         v_contrato_id := regs.cnt_cod;
--
-- converte a entidade beneficiaria de acordo com os ajustes colocados na função
--
         v_entidade := fun_converter_benef (regs.cnt_cod, v_entidade);

--
         IF v_entidade = 'ERRO'
         THEN
            raise_application_error
               (-20100,
                   ' Erro na conversão da entidade beneficiaria do contrato '
                || v_contrato_id
                || ' - '
                || SQLERRM
               );
         END IF;

--
         v_obs :=
            TRIM (SUBSTR (   NVL (regs.dsc_glosa_rp, ' Glosa sem descrição')
                          || NVL (regs.dsc_retencao_rp,
                                  'Retenção sem descrição'
                                 ),
                          1,
                          93
                         )
                 );

--
         IF regs.num_versao_contrato <> '00'
         THEN
            v_num_versao_anterior :=
               TRIM (TO_CHAR (TO_NUMBER (regs.num_versao_contrato) - 1, '00'));
         ELSE
            v_num_versao_anterior := '00';
         END IF;

--
         FOR i IN 1 .. 20
         LOOP
            IF SUBSTR (regs.fir_cnpj, i, 1) NOT IN ('.', '/', '-', ' ')
            THEN
               v_cnpj := v_cnpj || SUBSTR (regs.fir_cnpj, i, 1);
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
         regs.dat_pagamento := fun_verificar_data (regs.dat_pagamento);

--
         BEGIN
            SELECT contract_id
              INTO v_achou
              FROM integracao.conf_sol_pag_outros_u
             WHERE contract_id = v_contrato_id
               AND contract_versao = TRIM (regs.num_versao_contrato)
               AND vendor_id = v_cnpj_p1
               AND vendor_loc_code = v_cnpj_p2
               AND pmt_rqst_nbr = regs.num_fatura_pagamento
               AND pmt_rqst_date = regs.dat_pagamento
               AND schld_pmt_nbr = 0;

            UPDATE integracao.conf_sol_pag_outros_u
               SET desc_glosa = v_obs,
                   desc_aplicacao =
                                NVL (regs.dsc_solicitacao_rp, 'sem descrição'),
                   sistema_origem_code = '02',
                   contract_versao_origem = TRIM (v_num_versao_anterior),
                   date_changed = SYSDATE,
                   user_id_changed = USER,
                   inactive_ind = '0',
                   active_date = SYSDATE
             WHERE contract_id = v_contrato_id
               AND contract_versao = TRIM (regs.num_versao_contrato)
               AND vendor_id = v_cnpj_p1
               AND vendor_loc_code = v_cnpj_p2
               AND pmt_rqst_nbr = regs.num_fatura_pagamento
               AND pmt_rqst_date = regs.dat_pagamento
               AND schld_pmt_nbr = 0;
         EXCEPTION
            WHEN NO_DATA_FOUND
            THEN
               BEGIN
                  INSERT INTO integracao.conf_sol_pag_outros_u
                              (payable_entity_id, contract_id,
                               contract_versao, vendor_id,
                               vendor_loc_code, pmt_rqst_nbr,
                               pmt_rqst_date, schld_pmt_nbr, desc_glosa,
                               desc_aplicacao,
                               user_fld_1, user_fld_2, user_fld_3,
                               sistema_origem_code, contract_versao_origem,
                               date_created, user_id_created, date_changed,
                               user_id_changed, inactive_ind, active_date,
                               chgstamp
                              )
                       VALUES (v_entidade, v_contrato_id,
                               TRIM (regs.num_versao_contrato), v_cnpj_p1,
                               v_cnpj_p2, regs.num_fatura_pagamento,
                               regs.dat_pagamento, 0, v_obs,
                               NVL (regs.dsc_solicitacao_rp, 'sem descrição'),
                               ' ', ' ', ' ',
                               '02', TRIM (v_num_versao_anterior),
                               SYSDATE, USER, SYSDATE,
                               USER, '0', SYSDATE,
                               0
                              );
               EXCEPTION
                  WHEN OTHERS
                  THEN
                     raise_application_error (-20100, SQLERRM);
               END;
            WHEN OTHERS
            THEN
               raise_application_error (-20100, SQLERRM);
         END;

         BEGIN
            UPDATE ifrbde.cad_pagamento_contrato
               SET tip_situacao_pagamento = 5,
                   dat_situacao_pagamento = SYSDATE
             WHERE num_seq_pag_contrato = regs.num_seq_pag_contrato;

--
            UPDATE ifrbde.cad_resumo_pagamento
               SET tip_situacao_pag = 5
             WHERE num_seq_resumo_pag = v_num_seq_resumo_pag;
         EXCEPTION
            WHEN OTHERS
            THEN
               raise_application_error
                  (-20100,
                      ' ERRO AO ATUALIZAR as descrições do pagamento no IFRBDE - '
                   || SQLERRM
                  );
         END;
      EXCEPTION
         WHEN OTHERS
         THEN
--            NULL;
            raise_application_error
               (-20100,
                   regs.cnt_cod
                || ' - programa integração da SP parte de descrições de glosa e aplicação do Material (PRC_CONF_SOL_PAG_OUTROS_U) - '
                || SQLERRM
               );
      END;
   END LOOP;
END prc_conf_sol_pag_outros_u;                                    -- Procedure
/

-- Grants for Procedure
--GRANT EXECUTE ON ifrbde.prc_conf_sol_pag_outros_u TO bde_geral
--/


-- End of DDL Script for Procedure IFRBDE.PRC_CONF_SOL_PAG_OUTROS_U

