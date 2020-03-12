-- Start of DDL Script for Procedure IFRBDE.PRC_GRAVAR_TERMO_ADITIVO
-- Generated 2-dez-2004 20:31:09 from SYSMAN@HOMOLOG2

CREATE OR REPLACE 
PROCEDURE ifrbde.prc_gravar_termo_aditivo (
   p_num_seq_contrato_origem    IN       NUMBER,
   p_num_termo_aditivo          IN       VARCHAR2,
   p_dat_termo_aditivo          IN       DATE,
   p_dsc_objeto_ta              IN       VARCHAR2,
   p_tip_termo_aditivo          IN       VARCHAR2,
   p_num_seq_contrato_destino   OUT      NUMBER
)
IS

--
-- OBJETIVO: executar gravação nova versão do contrato,
-- quando for solicitado o termo aditivo
--
-- MODIFICATION HISTORY
-- Person      Date    Comments
-- ---------   ------  -------------------------------------------
--
--
   v_erro                         VARCHAR2 (200);
   v_sucesso                      NUMBER (1);
   v_num_versao_contrato          VARCHAR2 (2);
   v_num_seq_contrato_novo        NUMBER (15);
   v_num_seq_resumo_novo          NUMBER (15);
   v_num_seq_cronograma_novo      NUMBER (15);
   v_num_seq_termo_aditivo_novo   NUMBER (15);
   v_num_seq_pag_contrato_novo    NUMBER (15);
   v_num_seq_resumo_pag_novo      NUMBER (15);


--
   CURSOR regc
   IS
      SELECT a.*
        FROM ifrbde.tab_contrato a
       WHERE a.num_seq_contrato = p_num_seq_contrato_origem;


--      FOR UPDATE;


--
   CURSOR regr
   IS
      SELECT     b.*
            FROM ifrbde.cad_resumo_valores b
           WHERE b.num_seq_contrato_res = p_num_seq_contrato_origem
      FOR UPDATE;


--
   CURSOR rega (p_num_seq_resumo NUMBER)
   IS
      SELECT     c.*
            FROM ifrbde.tab_cont_crono_pagamento c
           WHERE c.num_seq_contrato_cron = p_num_seq_resumo
      FOR UPDATE;


--
   CURSOR regp (p_num_seq_pag_contrato_rp NUMBER)
   IS
      SELECT     d.*
            FROM ifrbde.cad_resumo_pagamento d
           WHERE d.num_seq_pag_contrato_rp = p_num_seq_pag_contrato_rp

--             AND d.tip_situacao_pag <> 9
      FOR UPDATE;


--
   CURSOR regh (p_num_seq_cronograma_hst NUMBER)
   IS
      SELECT     e.*
            FROM ifrbde.hst_pagamento_cronograma e
           WHERE e.num_seq_cronograma_hst = p_num_seq_cronograma_hst
      FOR UPDATE;


--
   CURSOR regj (p_num_seq_contrato_pag NUMBER)
   IS
      SELECT     f.*
            FROM ifrbde.cad_pagamento_contrato f
           WHERE f.num_seq_contrato_pag = p_num_seq_contrato_pag
      FOR UPDATE;
--
BEGIN
   v_sucesso := 0;
   v_erro := '';


--
   FOR regs IN regc
   LOOP

--
      SELECT ifrbde.seq_num_seq_contrato.NEXTVAL
        INTO v_num_seq_contrato_novo
        FROM DUAL;

      p_num_seq_contrato_destino := v_num_seq_contrato_novo;


--

      BEGIN
         INSERT INTO ifrbde.hst_contrato
                     (cnt_cre_cod, cnt_cod,
                      cnt_justificativa_cre, cnt_ice_cod,
                      cnt_data_proposta,
                      cnt_data,
                      cnt_data_inicio,
                      cnt_prazo_exec, cnt_prazo_adit,
                      cnt_valor, cnt_valor_compromisso,
                      cnt_valor_termo, cnt_valor_reaj,
                      cnt_valor_pago, cnt_valor_reaj_pago,
                      cnt_cei, cnt_crea, num_seq_gestor,
                      num_seq_assinatura_1, num_seq_assinatura_2,
                      num_ato_administrativo, num_seq_contrato,
                      dat_termino_contrato,
                      num_prazo_exec_meses, tip_situacao_contrato,
                      cod_dep_contrato, tip_contrato,
                      num_contrato_original, flg_numero_padrao,
                      num_versao_contrato, num_termo_aditivo,
                      dat_termo_aditivo,
                      dsc_critica_contrato,
                      dat_publicacao,
                      num_dou_publicacao, num_pagina_publicacao,
                      num_secao_publicacao,
                      cod_modalidade_licitacao, num_inciso,
                      dsc_fundamento_legal, num_licitacao,
                      num_ano_licitacao, num_processo,
                      tip_regularidade_fiscal)
              VALUES (regs.cnt_cre_cod, regs.cnt_cod,
                      regs.cnt_justificativa_cre, regs.cnt_ice_cod,
                      TO_DATE (
                         TO_CHAR (regs.cnt_data_proposta, 'DD/MM/YYYY'),
                         'DD/MM/YYYY'
                      ),
                      TO_DATE (
                         TO_CHAR (regs.cnt_data, 'DD/MM/YYYY'),
                         'DD/MM/YYYY'
                      ),
                      TO_DATE (
                         TO_CHAR (regs.cnt_data_inicio, 'DD/MM/YYYY'),
                         'DD/MM/YYYY'
                      ),
                      regs.cnt_prazo_exec, regs.cnt_prazo_adit,
                      regs.cnt_valor, regs.cnt_valor_compromisso,
                      regs.cnt_valor_termo, regs.cnt_valor_reaj,
                      regs.cnt_valor_pago, regs.cnt_valor_reaj_pago,
                      regs.cnt_cei, regs.cnt_crea, regs.num_seq_gestor,
                      regs.num_seq_assinatura_1, regs.num_seq_assinatura_2,
                      regs.num_ato_administrativo, v_num_seq_contrato_novo,
                      TO_DATE (
                         TO_CHAR (regs.dat_termino_contrato, 'DD/MM/YYYY'),
                         'DD/MM/YYYY'
                      ),
                      regs.num_prazo_exec_meses, '8',
                      regs.cod_dep_contrato, regs.tip_contrato,
                      regs.num_contrato_original, regs.flg_numero_padrao,
                      regs.num_versao_contrato, regs.num_termo_aditivo,
                      TO_DATE (
                         TO_CHAR (regs.dat_termo_aditivo, 'DD/MM/YYYY'),
                         'DD/MM/YYYY'
                      ),
                      regs.dsc_critica_contrato,
                      TO_DATE (
                         TO_CHAR (regs.dat_publicacao, 'DD/MM/YYYY'),
                         'DD/MM/YYYY'
                      ),
                      regs.num_dou_publicacao, regs.num_pagina_publicacao,
                      regs.num_secao_publicacao,
                      regs.cod_modalidade_licitacao, regs.num_inciso,
                      regs.dsc_fundamento_legal, regs.num_licitacao,
                      regs.num_ano_licitacao, regs.num_processo,
                      regs.tip_regularidade_fiscal);
      EXCEPTION
         WHEN OTHERS
         THEN
            raise_application_error (
               -20100,
                  ' Erro ao Criar nova versão do Contrato '
               || TO_CHAR (regs.cnt_data_proposta, 'DD/MM/YYYY')
               || ' PROP  '
               || TO_CHAR (regs.cnt_data, 'DD/MM/YYYY')
               || ' DATA  '
               || TO_CHAR (regs.cnt_data_inicio, 'DD/MM/YYYY')
               || ' INICIO'
               || SQLERRM
            );
      END;

      BEGIN
         UPDATE ifrbde.tab_contrato
            SET tip_situacao_contrato = 5
          WHERE num_seq_contrato = regs.num_seq_contrato;
      EXCEPTION
         WHEN OTHERS
         THEN
            raise_application_error (
               -20100,
                  ' Erro mudar a situacao do contrato - '
               || SQLERRM
            );
      END;


--
      v_num_versao_contrato :=
               TRIM (TO_CHAR (  TO_NUMBER (regs.num_versao_contrato)
                              + 1, '00'));


--
-- gravar os novos resumos
--
      FOR regt IN regr
      LOOP
         SELECT ifrbde.seq_num_seq_contrato.NEXTVAL
           INTO v_num_seq_resumo_novo
           FROM DUAL;

         BEGIN
            INSERT INTO ifrbde.hst_resumo_valores
                        (num_seq_resumo, num_seq_contrato_res,
                         val_inicial_resumo, val_saldo_resumo,
                         val_resumo, val_termo, val_pagamento,
                         val_reajuste, val_pago,
                         val_pago_reajuste, flg_moeda_controle,
                         num_seq_indice, tip_moeda, dat_moeda,
                         val_saldo_resumo_sec, val_resumo_sec,
                         val_termo_sec, val_pagamento_sec,
                         val_reajuste_sec, val_pago_sec,
                         val_pago_reajuste_sec, cod_recurso_res,
                         tip_cotacao_moeda,
                         num_versao_contrato_res,
                         val_cotacao_moeda)
                 VALUES (v_num_seq_resumo_novo, v_num_seq_contrato_novo,
                         regt.val_inicial_resumo, regt.val_saldo_resumo,
                         regt.val_resumo, regt.val_termo, regt.val_pagamento,
                         regt.val_reajuste, regt.val_pago,
                         regt.val_pago_reajuste, regt.flg_moeda_controle,
                         regt.num_seq_indice, regt.tip_moeda, regt.dat_moeda,
                         regt.val_saldo_resumo_sec, regt.val_resumo_sec,
                         regt.val_termo_sec, regt.val_pagamento_sec,
                         regt.val_reajuste_sec, regt.val_pago_sec,
                         regt.val_pago_reajuste_sec, regt.cod_recurso_res,
                         regt.tip_cotacao_moeda,
                         regt.num_versao_contrato_res,
                         regt.val_cotacao_moeda);
         EXCEPTION
            WHEN OTHERS
            THEN
               raise_application_error (
                  -20100,
                     ' Erro ao Criar novo resumo do novo Contrato '
                  || SQLERRM
               );
         END;

         BEGIN
            UPDATE ifrbde.cad_resumo_valores
               SET num_versao_contrato_res = TRIM (v_num_versao_contrato)
             WHERE  CURRENT OF regr;
         EXCEPTION
            WHEN OTHERS
            THEN
               raise_application_error (
                  -20100,
                     ' Erro ao aditivar o resumo - '
                  || SQLERRM
               );
         END;

         IF p_tip_termo_aditivo IN ('02', '03')
         THEN

--
--       gravar termo aditivo de valores de cada resumo
--
            SELECT ifrbde.seq_num_seq_contrato.NEXTVAL
              INTO v_num_seq_termo_aditivo_novo
              FROM DUAL;


--
--
            BEGIN
               INSERT INTO ifrbde.tab_cont_termo_aditivo
                           (cta_periodo,
                            cta_num, cta_objeto, cta_valor, cta_prazo,
                            cta_deb_cred, cta_aum_dim, num_seq_termo,
                            num_seq_contrato_termo, num_seq_resumo_ta,
                            dat_moeda_ta,
                            val_moeda_ta, tip_cotacao_moeda,
                            num_versao_contrato_vta)
                    VALUES (TO_DATE (
                               TO_CHAR (p_dat_termo_aditivo, 'dd/mm/yyyy'),
                               'dd/mm/yyyy'
                            ),
                            p_num_termo_aditivo, p_dsc_objeto_ta, 0, 0,
                            1, 0, v_num_seq_termo_aditivo_novo,
                            regs.num_seq_contrato, regt.num_seq_resumo,
                            TO_DATE (
                               TO_CHAR (SYSDATE, 'dd/mm/yyyy'),
                               'dd/mm/yyyy'
                            ),
                            1, 'V',
                            TRIM (v_num_versao_contrato));
            EXCEPTION
               WHEN OTHERS
               THEN
                  raise_application_error (
                     -20100,
                        ' Erro ao Criar novos termo aditivo do resumo do novo Contrato '
                     || SQLERRM
                  );
            END;
         END IF;


--
-- copiar o cronograma do resumo , Historico , sp por recurso realizada , e solitação de pagamentos
--
         FOR regy IN rega (regt.num_seq_resumo)
         LOOP

--
--       gravar o cronograma de cada resumo
--
            SELECT ifrbde.seq_num_seq_contrato.NEXTVAL
              INTO v_num_seq_cronograma_novo
              FROM DUAL;


--
--
            BEGIN
               INSERT INTO ifrbde.hst_cronograma_resumo
                           (ccp_pgose, ccp_data_venc,
                            ccp_rti_cod, ccp_valor,
                            num_seq_cronograma, dat_vencimento,
                            num_seq_contrato_cron, tip_cronograma,
                            dat_moeda_crono, tip_cotacao_crono,
                            val_crono_moeda_sec, val_saldo_crono,
                            val_saldo_crono_sec, num_seq_item,
                            cod_resumo_valor, num_parcela,
                            num_seq_resumo_pag_retencao,
                            num_versao_contrato_cron,
                            val_cotacao_crono)
                    VALUES (regy.ccp_pgose, regy.ccp_data_venc,
                            regy.ccp_rti_cod, regy.ccp_valor,
                            v_num_seq_cronograma_novo, regy.dat_vencimento,
                            v_num_seq_resumo_novo, regy.tip_cronograma,
                            regy.dat_moeda_crono, regy.tip_cotacao_crono,
                            regy.val_crono_moeda_sec, regy.val_saldo_crono,
                            regy.val_saldo_crono_sec, regy.num_seq_item,
                            regy.cod_resumo_valor, regy.num_parcela,
                            regy.num_seq_resumo_pag_retencao,
                            regy.num_versao_contrato_cron,
                            regy.val_cotacao_crono);
            EXCEPTION
               WHEN OTHERS
               THEN
                  raise_application_error (
                     -20100,
                        ' Erro ao Criar novo Cronograma do resumo do novo Contrato '
                     || SQLERRM
                  );
            END;


--
-- copiar o Historico de pagamento
--
            FOR rggh IN regh (regy.num_seq_cronograma)
            LOOP

--
--
               BEGIN
                  INSERT INTO ifrbde.hst_bkp_pagamento_cronograma
                              (num_seq_cronograma_hst,
                               num_seq_pag_contrato_hst,
                               dat_execucao_hst, cod_recurso_hst,
                               val_retirado_hst,
                               val_retirado_sec_hst,
                               tip_historico_pagamento)
                       VALUES (v_num_seq_cronograma_novo,
                               rggh.num_seq_pag_contrato_hst,
                               rggh.dat_execucao_hst, rggh.cod_recurso_hst,
                               rggh.val_retirado_hst,
                               rggh.val_retirado_sec_hst,
                               rggh.tip_historico_pagamento);
               EXCEPTION
                  WHEN OTHERS
                  THEN
                     raise_application_error (
                        -20100,
                           ' Erro ao Criar novo Historico de Cronograma pagamento do Contrato '
                        || SQLERRM
                     );
               END;

--
--
-- fim de historico de pagamento
--
            END LOOP;


--
--  versiona o cronograma
--
            BEGIN
               UPDATE ifrbde.tab_cont_crono_pagamento
                  SET num_versao_contrato_cron = TRIM (v_num_versao_contrato),
                      num_seq_item = NULL,
                      cod_resumo_valor = NULL,
                      num_parcela = NULL
                WHERE  CURRENT OF rega;
            EXCEPTION
               WHEN OTHERS
               THEN
                  raise_application_error (
                     -20100,
                        ' Erro ao alterar o numero do aditivo no cronograma - '
                     || SQLERRM
                  );
            END;

--
--
-- fim de cronograma
         END LOOP;


--
--
-- MUDAR OS PAGAMENTOS PARA HISTORICO
--
         FOR regw IN regp (regt.num_seq_resumo)
         LOOP

--
            IF regw.tip_situacao_pag = 1
            THEN
               raise_application_error (
                  -20100,
                  'Erro - Existem SP´s que estão na situação de CADASTRADA - Favor ENVIAR A FINANCEIRA '
               );
            ELSE

--
               IF regw.tip_situacao_pag = 2
               THEN
                  raise_application_error (
                     -20100,
                     'Erro - Existem SP´s que estão na situação de CERTIFICADA - Favor ENVIAR A FINANCEIRA ou retornar a situação de CADASTRADA'
                  );
               ELSE

--
-- copiar o pagamento de contrato
--
--
--       gravar novo numero do resumo de pagamento
--
                  SELECT ifrbde.seq_num_seq_contrato.NEXTVAL
                    INTO v_num_seq_resumo_pag_novo
                    FROM DUAL;


--
--
                  BEGIN
                     INSERT INTO ifrbde.hst_resumo_pagamento
                                 (num_seq_resumo_pag,
                                  num_seq_pag_contrato_rp,
                                  cod_tipo_pag_rp,
                                  dsc_solicitacao_rp,
                                  dat_pagamento, num_fatura_rp,
                                  val_pagamento_rp, val_glosa_rp,
                                  dsc_glosa_rp, val_retencao_rp,
                                  num_seq_entidade_rp,
                                  val_imposto_irrf_rp,
                                  val_imposto_iss_rp,
                                  val_imposto_pasep_rp,
                                  val_imposto_icms_rp,
                                  val_imposto_inss_rp,
                                  val_multa_rp,
                                  val_liquido_nota_rp,
                                  dat_pagamento_st, dat_moeda_rp,
                                  tip_cotacao_moeda_rp,
                                  num_seq_entidade_pag,
                                  dat_vencimento_pag,
                                  val_impostos_rp,
                                  tip_situacao_pag,
                                  num_versao_contrato_pag,
                                  val_cotacao_moeda_rp,
                                  dsc_retencao_rp)
                          VALUES (v_num_seq_resumo_pag_novo,
                                  v_num_seq_resumo_novo,
                                  regw.cod_tipo_pag_rp,
                                  regw.dsc_solicitacao_rp,
                                  regw.dat_pagamento, regw.num_fatura_rp,
                                  regw.val_pagamento_rp, regw.val_glosa_rp,
                                  regw.dsc_glosa_rp, regw.val_retencao_rp,
                                  regw.num_seq_entidade_rp,
                                  regw.val_imposto_irrf_rp,
                                  regw.val_imposto_iss_rp,
                                  regw.val_imposto_pasep_rp,
                                  regw.val_imposto_icms_rp,
                                  regw.val_imposto_inss_rp,
                                  regw.val_multa_rp,
                                  regw.val_liquido_nota_rp,
                                  regw.dat_pagamento_st, regw.dat_moeda_rp,
                                  regw.tip_cotacao_moeda_rp,
                                  regw.num_seq_entidade_pag,
                                  regw.dat_vencimento_pag,
                                  regw.val_impostos_rp,
                                  regw.tip_situacao_pag,
                                  regw.num_versao_contrato_pag,
                                  regw.val_cotacao_moeda_rp,
                                  regw.dsc_retencao_rp);
                  EXCEPTION
                     WHEN OTHERS
                     THEN
                        raise_application_error (
                           -20100,
                              ' Erro ao Criar novo Historico do Resumo de pagamento do Contrato '
                           || SQLERRM
                        );
                  END;


--

--
-- copiar o pagamento de contrato
--
                  FOR rggj IN regj (regw.num_seq_resumo_pag)
                  LOOP

--
--       gravar novo numero do resumo de pagamento
--
                     SELECT ifrbde.seq_num_seq_contrato.NEXTVAL
                       INTO v_num_seq_pag_contrato_novo
                       FROM DUAL;


--
--
                     BEGIN
                        INSERT INTO ifrbde.hst_pagamento_contrato
                                    (num_seq_pag_contrato,
                                     num_ano_pgose, cod_recurso,
                                     cod_tipo_pag, val_pagamento,
                                     num_fatura_pagamento,
                                     val_glosa, val_retencao,
                                     val_impostos, val_multa,
                                     val_liquido_nota,
                                     num_seq_contrato_pag,
                                     val_faturado, val_acumulado,
                                     tip_situacao_pagamento,
                                     dat_situacao_pagamento,
                                     val_imposto_irrf,
                                     val_imposto_iss,
                                     val_imposto_pasep,
                                     val_imposto_icms,
                                     val_imposto_inss,
                                     num_seq_resumo_contrato,
                                     val_cotacao_moeda)
                             VALUES (v_num_seq_pag_contrato_novo,
                                     rggj.num_ano_pgose, rggj.cod_recurso,
                                     rggj.cod_tipo_pag, rggj.val_pagamento,
                                     rggj.num_fatura_pagamento,
                                     rggj.val_glosa, rggj.val_retencao,
                                     rggj.val_impostos, rggj.val_multa,
                                     rggj.val_liquido_nota,
                                     v_num_seq_resumo_pag_novo,
                                     rggj.val_faturado, rggj.val_acumulado,
                                     rggj.tip_situacao_pagamento,
                                     rggj.dat_situacao_pagamento,
                                     rggj.val_imposto_irrf,
                                     rggj.val_imposto_iss,
                                     rggj.val_imposto_pasep,
                                     rggj.val_imposto_icms,
                                     rggj.val_imposto_inss,
                                     v_num_seq_resumo_novo,
                                     rggj.val_cotacao_moeda);
                     EXCEPTION
                        WHEN OTHERS
                        THEN
                           raise_application_error (
                              -20100,
                                 ' Erro ao Criar novo Historico de Pagamento de Contrato '
                              || SQLERRM
                           );
                     END;


--
-- atualiza no historico de pagamento com o novo numero do pagamento de contrato
--
                     BEGIN
                        UPDATE ifrbde.hst_bkp_pagamento_cronograma
                           SET num_seq_pag_contrato_hst =
                                                  v_num_seq_pag_contrato_novo
                         WHERE num_seq_pag_contrato_hst =
                                                    rggj.num_seq_pag_contrato;
                     EXCEPTION
                        WHEN OTHERS
                        THEN
                           raise_application_error (
                              -20100,
                                 ' Erro ao Atualizar novo Historico de Pagamento de Contrato com novo numero de SP '
                              || SQLERRM
                           );
                     END;

--
-- fim de pagamento de contrato
--
                  END LOOP;


--
--   se o resumo de pagamento tiver retenção
--
                  IF regw.val_retencao_rp > 0
                  THEN

--
-- atualiza no historico de pagamento com o novo numero do pagamento de contrato
--
                     BEGIN
                        UPDATE ifrbde.hst_cronograma_resumo
                           SET num_seq_resumo_pag_retencao =
                                                    v_num_seq_resumo_pag_novo
                         WHERE num_seq_resumo_pag_retencao =
                                                      regw.num_seq_resumo_pag
                           AND ccp_rti_cod = 'LR';
                     EXCEPTION
                        WHEN OTHERS
                        THEN
                           raise_application_error (
                              -20100,
                                 ' Erro ao Atualizar novo Historico de Cronograma a referencia de retenção da SP '
                              || SQLERRM
                           );
                     END;
                  END IF;


--
--
--

                  BEGIN
                     UPDATE ifrbde.cad_resumo_pagamento
                        SET tip_situacao_pag = 9
                      WHERE  CURRENT OF regp;
                  EXCEPTION
                     WHEN OTHERS
                     THEN
                        raise_application_error (
                           -20100,
                              ' Erro ao aditivar os pagamentos - '
                           || SQLERRM
                        );
                  END;
               END IF;
            END IF;

-- fim do solicitação de pagamento
         END LOOP;

--  fim do resumo
      END LOOP;


--
--  executar a rotina para exclusão do historico de relacionamento com o cronograma
--
      ifrbde.prc_exclui_hst_pag_crono (regs.num_seq_contrato);


--
--  atualiza a versão do contrato.
--
      BEGIN
         UPDATE ifrbde.tab_contrato
            SET num_versao_contrato =
                      TRIM (
                         TO_CHAR (
                              TO_NUMBER (regs.num_versao_contrato)
                            + 1,
                            '00'
                         )
                      ),
                num_termo_aditivo =
                                   TRIM (SUBSTR (p_num_termo_aditivo, 1, 30))
          WHERE num_seq_contrato = regs.num_seq_contrato;
      EXCEPTION
         WHEN OTHERS
         THEN
            raise_application_error (
               -20100,
                  ' Erro ao aditivar o contrato - '
               || SQLERRM
            );
      END;

--
   END LOOP;
END; -- Procedure
/

-- Grants for Procedure
GRANT EXECUTE ON ifrbde.prc_gravar_termo_aditivo TO bde_geral
/


-- End of DDL Script for Procedure IFRBDE.PRC_GRAVAR_TERMO_ADITIVO

