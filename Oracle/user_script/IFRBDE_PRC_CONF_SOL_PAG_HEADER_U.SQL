/* Formatted on 2003/12/29 17:31 (Formatter Plus v4.5.2) */
CREATE OR REPLACE PROCEDURE prc_conf_sol_pag_header_u (
   v_num_seq_resumo_pag   IN   NUMBER
)
IS
   
--
-- OBJETIVO: executar a carga dos contratos para o arquivo de interface do
-- smartstream chamado conf_sol_pag_head_u
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
   v_num_versao_anterior      VARCHAR2 (2);
   v_pmt_meth_id              VARCHAR2 (5);
   v_payable_entity_id_oper   VARCHAR2 (5);
   v_prim_amt                 NUMBER (12, 2);
   v_secdy_amt                NUMBER (12, 2);

   CURSOR regc
   IS
      SELECT   a.cnt_cod, a.num_seq_contrato, a.num_versao_contrato,
               a.cod_dep_contrato, b.fir_cnpj, d.num_seq_resumo,
               c.num_fatura_pagamento, i.dat_pagamento, i.dat_vencimento_pag,
               c.val_faturado, c.val_cotacao_moeda, c.cod_tipo_pag,
               c.num_seq_pag_contrato, e.rti_conta, d.flg_moeda_controle,
               e.rti_sigla_ss, f.cre_projeto, y.dpp_ncod, x.dep_cod,
               z.dpp_ncod AS reg_oper, w.dep_cod AS dep_oper
          FROM ifrbde.tab_contrato a,
               ifrbde.tab_firma b,
               ifrbde.cad_pagamento_contrato c,
               ifrbde.cad_resumo_pagamento i,
               ifrbde.cad_resumo_valores d,
               ifrbde.tab_tipo_recurso_item e,
               ifrbde.tab_carencia f,
               ifrbde.tab_dependencia x,
               ifrbde.tab_dependencia_pai y,
               ifrbde.tab_dependencia w,
               ifrbde.tab_dependencia_pai z
         WHERE d.num_versao_contrato_res = i.num_versao_contrato_pag
           AND a.num_versao_contrato = d.num_versao_contrato_res
           AND i.num_seq_entidade_pag = b.fir_cod
           AND a.cnt_cre_cod = f.cre_cod
           AND a.num_seq_contrato = d.num_seq_contrato_res
           AND d.num_seq_resumo = i.num_seq_pag_contrato_rp
           AND i.num_seq_resumo_pag = c.num_seq_contrato_pag
           AND f.cre_dep_cod = x.dep_cod
           AND x.dep_dpp_cod = y.dpp_cod
           AND a.cod_dep_contrato = w.dep_cod
           AND w.dep_dpp_cod = z.dpp_cod
           AND c.cod_recurso = e.rti_cod
           AND i.num_seq_resumo_pag = v_num_seq_resumo_pag
      ORDER BY a.cnt_cod,
               e.rti_conta,
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
         FOR i IN 1 .. 20
         LOOP
            IF SUBSTR (regs.fir_cnpj, i, 1) NOT IN ('.', '/', '-', ' ')
            THEN
               v_cnpj :=    v_cnpj
                         || SUBSTR (regs.fir_cnpj, i, 1);
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
         regs.dat_vencimento_pag :=
                                  fun_verificar_data (regs.dat_vencimento_pag);
         
--
         v_secdy_amt := 0;
         v_prim_amt := 0;

         IF regs.flg_moeda_controle = '2'
         THEN
            v_secdy_amt :=
                        ROUND (regs.val_faturado / regs.val_cotacao_moeda, 2);
         ELSE
            v_prim_amt := regs.val_faturado;
         END IF;

         
--
         BEGIN
            SELECT contract_id
              INTO v_achou
              FROM integracao.conf_sol_pag_head_u
             WHERE contract_id = v_contrato_id
               AND contract_versao =
                                   TRIM (NVL (regs.num_versao_contrato, '00'))
               AND vendor_id = v_cnpj_p1
               AND vendor_loc_code = v_cnpj_p2
               AND pmt_rqst_nbr = regs.num_fatura_pagamento
               AND pmt_rqst_date = regs.dat_pagamento
               AND schld_pmt_nbr = 0;

            UPDATE integracao.conf_sol_pag_head_u
               SET tipo_sp = '1',
                   vendor_id_origem = ' ',
                   vendor_loc_code_origem = ' ',
                   pmt_rqst_nbr_origem = ' ',
                   pmt_rqst_date_origem = TO_DATE ('01/01/1900', 'dd/mm/yyyy'),
                   schld_pmt_nbr_origem = 0,
                   prim_amt = v_prim_amt,
                   secdy_amt = v_secdy_amt,
                   sp_status_code = 'IN',
                   sistema_origem_code = '02',
                   contract_versao_origem = TRIM (v_num_versao_anterior),
                   date_changed = SYSDATE,
                   user_id_changed = USER,
                   inactive_ind = '0',
                   active_date = SYSDATE,
                   type_of_pmt = 'BT',
                   seq_nbr = ' ',
                   pmt_meth_id = v_pmt_meth_id,
                   final_due_date = regs.dat_vencimento_pag,
                   terms_of_pmt_id = ' ',
                   payable_entity_id_oper = v_payable_entity_id_oper
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
                  INSERT INTO integracao.conf_sol_pag_head_u
                              (payable_entity_id, contract_id,
                               contract_versao, vendor_id,
                               vendor_loc_code, pmt_rqst_nbr,
                               pmt_rqst_date, schld_pmt_nbr, tipo_sp,
                               vendor_id_origem, vendor_loc_code_origem,
                               pmt_rqst_nbr_origem, pmt_rqst_date_origem,
                               schld_pmt_nbr_origem, prim_amt, secdy_amt,
                               sp_status_code, sistema_origem_code,
                               contract_versao_origem, date_created,
                               user_id_created, date_changed,
                               user_id_changed, inactive_ind, active_date,
                               type_of_pmt, seq_nbr, pmt_meth_id,
                               final_due_date, terms_of_pmt_id,
                               payable_entity_id_oper, chgstamp)
                       VALUES (v_entidade, v_contrato_id,
                               TRIM (regs.num_versao_contrato), v_cnpj_p1,
                               v_cnpj_p2, regs.num_fatura_pagamento,
                               regs.dat_pagamento, 0, '1',
                               ' ', ' ',
                               ' ', TO_DATE ('01/01/1900', 'dd/mm/yyyy'),
                               0, v_prim_amt, v_secdy_amt,
                               'IN', '02',
                               TRIM (v_num_versao_anterior), SYSDATE,
                               USER, SYSDATE,
                               USER, '0', SYSDATE,
                               'BT', ' ', v_pmt_meth_id,
                               regs.dat_vencimento_pag, ' ',
                               v_payable_entity_id_oper, 0);
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
               SET tip_situacao_pagamento = 2,
                   dat_situacao_pagamento = SYSDATE
             WHERE num_seq_pag_contrato = regs.num_seq_pag_contrato;

            
--
            UPDATE ifrbde.cad_resumo_pagamento
               SET tip_situacao_pag = 2
             WHERE num_seq_resumo_pag = v_num_seq_resumo_pag;
         EXCEPTION
            WHEN OTHERS
            THEN
               raise_application_error (
                  -20100,
                     ' ERRO AO ATUALIZAR O pagamento no IFRBDE - '
                  || SQLERRM
               );
         END;
      EXCEPTION
         WHEN OTHERS
         THEN
            raise_application_error (
               -20100,
                  'Erro ao enviar a solicitação de Pagamento do contrato '
               || regs.cnt_cod
               || ' - data de pagamento  '
               || regs.dat_pagamento
               || ' - '
               || SQLERRM
            );
      END;
   END LOOP;
END prc_conf_sol_pag_header_u; -- Procedure

