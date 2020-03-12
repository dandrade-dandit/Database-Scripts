Create Or Replace PROCEDURE PRC_CONF_SOL_PAG_VALOR_U (v_num_seq_resumo_pag IN NUMBER)
IS
   
--
-- OBJETIVO: executar a carga dos contratos para o arquivo de interface do
-- smartstream chamado conf_sol_pag_val_u
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
   v_num_versao_anterior      VARCHAR2 (2);
   v_prim_amt                 NUMBER (12, 2);
   v_secdy_amt                NUMBER (12, 2);

   CURSOR regc
   IS
      SELECT   a.cnt_cod, a.num_seq_contrato, a.num_versao_contrato,
               a.cod_dep_contrato, c.num_seq_pag_contrato, h.fir_cnpj,
               c.num_fatura_pagamento, i.dat_pagamento, i.dat_vencimento_pag,
               b.num_seq_item, b.cod_resumo_valor,
               DECODE (b.tip_cronograma, 'DE', 'D', 'RJ', 'R', 'DA', 'D', 'LR', 'D') AS tipo_cronograma,
               b.num_parcela, d.num_seq_resumo, d.flg_moeda_controle,
               y.dpp_ncod, x.dep_cod, SUM (e.val_retirado_hst) AS val_retirado_hst,
               SUM (e.val_retirado_sec_hst) AS val_retirado_sec_hst
          FROM ifrbde.tab_contrato a,
               ifrbde.tab_cont_crono_pagamento b,
               ifrbde.cad_pagamento_contrato c,
               ifrbde.cad_resumo_valores d,
               ifrbde.hst_pagamento_cronograma e,
               ifrbde.tab_carencia f,
               ifrbde.tab_firma h,
               ifrbde.cad_resumo_pagamento i,
               ifrbde.tab_dependencia x,
               ifrbde.tab_dependencia_pai y
         WHERE a.num_versao_contrato = i.num_versao_contrato_pag
           AND a.num_versao_contrato = d.num_versao_contrato_res
           AND a.num_versao_contrato = b.num_versao_contrato_cron
           AND a.cnt_cre_cod = f.cre_cod
           AND i.num_seq_entidade_pag = h.fir_cod
           AND a.num_seq_contrato = d.num_seq_contrato_res
           AND c.num_seq_pag_contrato = e.num_seq_pag_contrato_hst
           AND e.num_seq_cronograma_hst = b.num_seq_cronograma
           AND f.cre_dep_cod = x.dep_cod
           AND x.dep_dpp_cod = y.dpp_cod
           AND d.num_seq_resumo = i.num_seq_pag_contrato_rp
           AND i.num_seq_resumo_pag = c.num_seq_contrato_pag
           AND i.num_seq_resumo_pag = v_num_seq_resumo_pag
      GROUP BY i.num_seq_resumo_pag,
               a.cnt_cod,
               a.num_seq_contrato,
               a.num_versao_contrato,
               a.cod_dep_contrato,
               c.num_seq_pag_contrato,
               h.fir_cnpj,
               c.num_fatura_pagamento,
               i.dat_pagamento,
               i.dat_vencimento_pag,
               b.num_seq_item,
               b.cod_resumo_valor,
               DECODE (b.tip_cronograma, 'DE', 'D', 'RJ', 'R', 'DA', 'D', 'LR', 'D'),
               b.num_parcela,
               d.num_seq_resumo,
               d.flg_moeda_controle,
               y.dpp_ncod,
               x.dep_cod
      ORDER BY a.cnt_cod,
               d.flg_moeda_controle,
               i.dat_pagamento,
               c.num_fatura_pagamento,
               b.num_seq_item,
               b.cod_resumo_valor,
               10,
               b.num_parcela;
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
         v_contrato_id := regs.cnt_cod;

         
--

         IF regs.num_versao_contrato <> '00'
         THEN
            v_num_versao_anterior :=
                  TRIM (
                     TO_CHAR (  TO_NUMBER (regs.num_versao_contrato)
                              - 1, '00')
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
            v_secdy_amt := NVL (regs.val_retirado_sec_hst, 0);
         ELSE
            v_prim_amt := regs.val_retirado_hst;
         END IF;

         
--
         BEGIN
            SELECT contract_id
              INTO v_achou
              FROM integracao.conf_sol_pag_val_u
             WHERE contract_id = v_contrato_id
               AND contract_versao = TRIM (regs.num_versao_contrato)
               AND vendor_id = v_cnpj_p1
               AND vendor_loc_code = v_cnpj_p2
               AND pmt_rqst_nbr = regs.num_fatura_pagamento
               AND pmt_rqst_date = regs.dat_pagamento
               AND schld_pmt_nbr = 0
               AND seq_item = regs.num_seq_item
               AND codigo_resumo_valor = regs.cod_resumo_valor
               AND tipo_cronograma = regs.tipo_cronograma
               AND numero_parcela =    '0'
                                    || regs.num_parcela;

            UPDATE integracao.conf_sol_pag_val_u
               SET prim_amt = v_prim_amt,
                   secdy_amt = v_secdy_amt,
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
               AND schld_pmt_nbr = 0
               AND seq_item = regs.num_seq_item
               AND codigo_resumo_valor = regs.cod_resumo_valor
               AND tipo_cronograma = regs.tipo_cronograma
               AND numero_parcela =    '0'
                                    || regs.num_parcela;
         EXCEPTION
            WHEN NO_DATA_FOUND
            THEN
               BEGIN
                  INSERT INTO integracao.conf_sol_pag_val_u
                              (payable_entity_id, contract_id,
                               contract_versao, vendor_id,
                               vendor_loc_code, pmt_rqst_nbr,
                               pmt_rqst_date, schld_pmt_nbr, seq_item,
                               codigo_resumo_valor, tipo_cronograma,
                               numero_parcela, prim_amt,
                               secdy_amt, sistema_origem_code,
                               contract_versao_origem,
                               data_vencto, date_created, user_id_created,
                               date_changed, user_id_changed, inactive_ind,
                               active_date, chgstamp)
                       VALUES (v_entidade, v_contrato_id,
                               TRIM (regs.num_versao_contrato), v_cnpj_p1,
                               v_cnpj_p2, regs.num_fatura_pagamento,
                               regs.dat_pagamento, 0, regs.num_seq_item,
                               regs.cod_resumo_valor, regs.tipo_cronograma,
                                  '0'
                               || regs.num_parcela, v_prim_amt,
                               v_secdy_amt, '02',
                               TRIM (v_num_versao_anterior),
                               regs.dat_vencimento_pag, SYSDATE, USER,
                               SYSDATE, USER, '0',
                               SYSDATE, 0);
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
               SET tip_situacao_pagamento = 3,
                   dat_situacao_pagamento = SYSDATE
             WHERE num_seq_pag_contrato = regs.num_seq_pag_contrato;

            
--
            UPDATE ifrbde.cad_resumo_pagamento
               SET tip_situacao_pag = 3
             WHERE num_seq_resumo_pag = v_num_seq_resumo_pag;
         EXCEPTION
            WHEN OTHERS
            THEN
               raise_application_error (
                  -20100,
                     ' ERRO AO ATUALIZAR O valores do pagamento no IFRBDE - '
                  || SQLERRM
               );
         END;
      EXCEPTION
         WHEN OTHERS
         THEN
            raise_application_error (
               -20100,
                  regs.cnt_cod
               || ' - '
               || SQLERRM
            );
      END;
   END LOOP;
END prc_conf_sol_pag_valor_u; -- Procedure
