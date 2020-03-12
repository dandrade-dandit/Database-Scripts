Create Or Replace PROCEDURE PRC_CONF_SOL_PAG_ACR_RET_U (v_num_seq_resumo_pag IN NUMBER)
IS

--
-- OBJETIVO: executar a carga dos contratos para o arquivo de interface do
-- smartstream chamado conf_sol_pag_acr_ret_u
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
   v_obs                      VARCHAR2 (70);
   v_num_versao_anterior      VARCHAR2 (2);


--
   CURSOR regc
   IS
      SELECT   a.cnt_cod, a.num_seq_contrato, a.num_versao_contrato,
               a.cod_dep_contrato, b.fir_cnpj, d.num_seq_resumo,
               c.num_fatura_pagamento, i.dat_pagamento, c.val_cotacao_moeda,
               c.val_faturado, c.cod_tipo_pag, c.num_seq_pag_contrato,
               e.rti_conta, d.flg_moeda_controle, e.rti_sigla_ss,
               f.cre_projeto, y.dpp_ncod, x.dep_cod, c.val_imposto_irrf,
               c.val_imposto_iss, c.val_imposto_pasep, c.val_imposto_icms,
               c.val_imposto_inss, c.val_retencao, c.val_glosa, c.val_multa
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
         FOR y IN 1 .. 8
         LOOP
            v_obs := ' ';
--
            IF y = 1
            THEN
               v_val_acr_ret := NVL (regs.val_glosa, 0);
               v_acr_ret := 'GLEP';
               v_obs := 'Valor de Glosa de Empreedimento';
            END IF;

--

            IF y = 2
            THEN
               v_val_acr_ret := NVL (regs.val_imposto_irrf, 0);
               v_acr_ret := 'IRRF';
               v_obs := 'Valor de Imposto de IRRF';
            END IF;


--
            IF y = 3
            THEN
               v_val_acr_ret := NVL (regs.val_imposto_iss, 0);
               v_acr_ret := 'ISS';
               v_obs := 'Valor de Imposto de ISS';
            END IF;


--
            IF y = 4
            THEN
               v_val_acr_ret := NVL (regs.val_imposto_pasep, 0);
               v_acr_ret := 'PSP';
               v_obs := 'Valor de Imposto de PASEP';
            END IF;


--
            IF y = 5
            THEN
               v_val_acr_ret := NVL (regs.val_imposto_icms, 0);
               v_acr_ret := 'ICMS';
               v_obs := 'Valor de Imposto de ICMS';
            END IF;


--
            IF y = 6
            THEN
               v_val_acr_ret := NVL (regs.val_imposto_inss, 0);
               v_acr_ret := 'INSS';
               v_obs := 'Valor de Imposto de INSS';
            END IF;


--
            IF y = 7
            THEN
               v_val_acr_ret := NVL (regs.val_multa, 0);
               v_acr_ret := 'MULT';
               v_obs := 'Valor da Multa';
            END IF;


--
            IF y = 8
            THEN
               v_val_acr_ret := NVL (regs.val_retencao, 0);
               v_acr_ret := 'RETJ';
               v_obs := 'Valor de RETENCAO';
            END IF;


--

            IF v_val_acr_ret > 0
            THEN
               v_sucesso := 0;
               v_erro := '';
               v_cnpj := '';
               v_entidade :=    TRIM (TO_CHAR (regs.dpp_ncod, '00'))
                             || TRIM (TO_CHAR (regs.dep_cod, '000'));

--
               v_contrato_id := regs.cnt_cod;


--

               IF regs.num_versao_contrato <> '00'
               THEN
                  v_num_versao_anterior :=
                        TRIM (
                           TO_CHAR (
                                TO_NUMBER (regs.num_versao_contrato)
                              - 1,
                              '00'
                           )
                        );
               ELSE
                  v_num_versao_anterior := '00';
               END IF;


--
--
               IF regs.flg_moeda_controle = '2'
               THEN
                  v_val_acr_ret :=
                            ROUND (v_val_acr_ret / regs.val_cotacao_moeda, 2);
                  v_per_ret_acr :=   (v_val_acr_ret * 100)
                                   / ROUND (
                                          regs.val_faturado
                                        / regs.val_cotacao_moeda,
                                        2
                                     );
               ELSE
                  v_per_ret_acr :=   (v_val_acr_ret * 100)
                                   / regs.val_faturado;
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
         IF LENGTH (v_cnpj) =  14
         THEN
            v_cnpj_p1 := SUBSTR (v_cnpj, 1, 9);
            v_cnpj_p2 := SUBSTR (v_cnpj, 10, 3);
         ELSE
            IF LENGTH (v_cnpj) =  11
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

               BEGIN
                  SELECT contract_id
                    INTO v_achou
                    FROM integracao.conf_sol_pag_acr_ret_u
                   WHERE contract_id = v_contrato_id
                     AND contract_versao = TRIM (regs.num_versao_contrato)
                     AND vendor_id = v_cnpj_p1
                     AND vendor_loc_code = v_cnpj_p2
                     AND pmt_rqst_nbr = regs.num_fatura_pagamento
                     AND pmt_rqst_date = regs.dat_pagamento
                     AND schld_pmt_nbr = 0
                     AND codigo_red_acres = v_acr_ret;

                  UPDATE integracao.conf_sol_pag_acr_ret_u
                     SET trans_amt = v_val_acr_ret,
                         descp = v_obs,
                         val_brt = regs.val_faturado,
                         per_ret_acre = v_per_ret_acr,
                         dependencia = TRIM (TO_CHAR (regs.dep_cod, '000')),
                         conta = TRIM (regs.rti_conta),
                         sistema_origem_code = '02',
                         contract_versao_origem =
                                                 TRIM (v_num_versao_anterior),
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
                     AND codigo_red_acres = v_acr_ret;
               EXCEPTION
                  WHEN NO_DATA_FOUND
                  THEN
                     BEGIN
                        INSERT INTO integracao.conf_sol_pag_acr_ret_u
                                    (payable_entity_id, contract_id,
                                     contract_versao,
                                     vendor_id, vendor_loc_code,
                                     pmt_rqst_nbr,
                                     pmt_rqst_date, schld_pmt_nbr,
                                     codigo_red_acres, trans_amt, descp,
                                     sistema_origem_code,
                                     contract_versao_origem,
                                     val_brt, per_ret_acre,
                                     ldr_entity_id,
                                     dependencia,
                                     conta, programa, projeto, custo,
                                     date_created, user_id_created,
                                     date_changed, user_id_changed,
                                     inactive_ind, active_date, chgstamp)
                             VALUES (v_entidade, v_contrato_id,
                                     TRIM (regs.num_versao_contrato),
                                     v_cnpj_p1, v_cnpj_p2,
                                     regs.num_fatura_pagamento,
                                     regs.dat_pagamento, 0,
                                     v_acr_ret, v_val_acr_ret, v_obs,
                                     '02',
                                     TRIM (v_num_versao_anterior),
                                     regs.val_faturado, v_per_ret_acr,
                                     'INFRA',
                                     TRIM (TO_CHAR (regs.dep_cod, '000')),
                                     TRIM (regs.rti_conta), ' ', ' ', ' ',
                                     SYSDATE, USER,
                                     SYSDATE, USER,
                                     '0', SYSDATE, 0);
                     EXCEPTION
                        WHEN OTHERS
                        THEN
                           raise_application_error (-20100, SQLERRM);
                     END;
                  WHEN OTHERS
                  THEN
                     raise_application_error (-20100, SQLERRM);
               END;
            END IF;
         END LOOP;

         BEGIN
            UPDATE ifrbde.cad_pagamento_contrato
               SET tip_situacao_pagamento = 4,
                   dat_situacao_pagamento = SYSDATE
             WHERE num_seq_pag_contrato = regs.num_seq_pag_contrato;


--
            UPDATE ifrbde.cad_resumo_pagamento
               SET tip_situacao_pag = 4
             WHERE num_seq_resumo_pag = v_num_seq_resumo_pag;
         EXCEPTION
            WHEN OTHERS
            THEN
               raise_application_error (
                  -20100,
                     ' ERRO AO ATUALIZAR O pagamento no ifrbde - '
                  || SQLERRM
               );
         END;
      EXCEPTION
         WHEN OTHERS
         THEN

--            NULL;
            raise_application_error (
               -20100,
                  regs.cnt_cod
               || ' - '
               || SQLERRM
            );
      END;
   END LOOP;
END; -- Procedure
