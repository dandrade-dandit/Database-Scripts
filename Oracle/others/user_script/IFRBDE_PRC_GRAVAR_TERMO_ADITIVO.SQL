Create Or Replace PROCEDURE PRC_GRAVAR_TERMO_ADITIVO (
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

   
--
   CURSOR regc
   IS
      SELECT a.*
        FROM IFRBDE.tab_contrato a
       WHERE a.num_seq_contrato = p_num_seq_contrato_origem;

   
--      FOR UPDATE;


--
   CURSOR regr
   IS
      SELECT     b.*
            FROM IFRBDE.cad_resumo_valores b
           WHERE b.num_seq_contrato_res = p_num_seq_contrato_origem
      FOR UPDATE;

   
--
   CURSOR rega (p_num_seq_resumo NUMBER)
   IS
      SELECT     c.*
            FROM IFRBDE.tab_cont_crono_pagamento c
           WHERE c.num_seq_contrato_cron = p_num_seq_resumo
      FOR UPDATE;

   
--
   CURSOR regp (p_num_seq_resumo_pag NUMBER)
   IS
      SELECT     d.*
            FROM IFRBDE.cad_resumo_pagamento d
           WHERE d.num_seq_pag_contrato_rp = p_num_seq_resumo_pag
             AND d.tip_situacao_pag <> 9
      FOR UPDATE;
--
BEGIN
   v_sucesso := 0;
   v_erro := '';

   
--
   FOR regs IN regc
   LOOP
      
--
      SELECT IFRBDE_views.seq_num_seq_contrato.NEXTVAL
        INTO v_num_seq_contrato_novo
        FROM DUAL;

      p_num_seq_contrato_destino := v_num_seq_contrato_novo;

      
--
/*      BEGIN
         INSERT INTO IFRBDE.hst_contrato
                     (cnt_cre_cod, cnt_cod,
                      cnt_justificativa_cre, cnt_ice_cod,
                      cnt_data_proposta, cnt_data,
                      cnt_data_inicio, cnt_prazo_exec,
                      cnt_prazo_adit, cnt_valor,
                      cnt_valor_compromisso, cnt_valor_termo,
                      cnt_valor_reaj, cnt_valor_pago,
                      cnt_valor_reaj_pago, cnt_cei, cnt_crea,
                      num_seq_gestor, num_seq_assinatura_1,
                      num_seq_assinatura_2, num_ato_administrativo,
                      num_seq_contrato, dat_termino_contrato,
                      num_prazo_exec_meses, tip_situacao_contrato,
                      cod_dep_contrato, tip_contrato,
                      num_contrato_original, flg_numero_padrao,
                      num_versao_contrato,
                      num_termo_aditivo)
              VALUES (regs.cnt_cre_cod, regs.cnt_cod,
                      regs.cnt_justificativa_cre, regs.cnt_ice_cod,
                      regs.cnt_data_proposta, regs.cnt_data,
                      regs.cnt_data_inicio, regs.cnt_prazo_exec,
                      regs.cnt_prazo_adit, regs.cnt_valor,
                      regs.cnt_valor_compromisso, regs.cnt_valor_termo,
                      regs.cnt_valor_reaj, regs.cnt_valor_pago,
                      regs.cnt_valor_reaj_pago, regs.cnt_cei, regs.cnt_crea,
                      regs.num_seq_gestor, regs.num_seq_assinatura_1,
                      regs.num_seq_assinatura_2, regs.num_ato_administrativo,
                      regs.num_seq_contrato, regs.dat_termino_contrato,
                      regs.num_prazo_exec_meses, '8',
                      regs.cod_dep_contrato, regs.tip_contrato,
                      regs.num_contrato_original, regs.flg_numero_padrao,
                      regs.num_versao_contrato,regs.num_termo_aditivo);
      EXCEPTION
         WHEN OTHERS
         THEN
            raise_application_error (
               -20100,
                  ' Erro ao Criar nova versão do Contrato '
               || SQLERRM
            );
      END;
*/
      BEGIN
         UPDATE IFRBDE.tab_contrato
            SET tip_situacao_contrato = 5
          WHERE num_seq_contrato = regs.num_seq_contrato;
      
--            CURRENT OF regc;
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

--
--       gravar termo aditivo de cada resumo
--
/*         SELECT IFRBDE_views.seq_num_seq_contrato.NEXTVAL
           INTO v_num_seq_termo_aditivo_novo
           FROM DUAL;
*/
--
--  falta um loop para copia dos termos de valor que ficaram no historico
--

--      
-- gravar os novos resumos   
--
      FOR regt IN regr
      LOOP
         SELECT IFRBDE_views.seq_num_seq_contrato.NEXTVAL
           INTO v_num_seq_resumo_novo
           FROM DUAL;

         
/*         BEGIN
            INSERT INTO IFRBDE.hst_resumo_valores
                        (num_seq_resumo, num_seq_contrato_res,
                         val_inicial_resumo, val_resumo,
                         val_termo, val_pagamento,
                         val_reajuste, val_pago,
                         val_pago_reajuste, flg_moeda_controle,
                         num_seq_indice, tip_moeda, dat_moeda,
                         val_resumo_sec, val_termo_sec,
                         val_pagamento_sec, val_reajuste_sec,
                         val_pago_sec, val_pago_reajuste_sec,
                         cod_recurso_res, val_cotacao_moeda,
                         tip_cotacao_moeda,num_versao_contrato_res)
                 VALUES (v_num_seq_resumo_novo, v_num_seq_contrato_novo,
                         regt.val_inicial_resumo, regt.val_resumo,
                         regt.val_termo, regt.val_pagamento,
                         regt.val_reajuste, regt.val_pago,
                         regt.val_pago_reajuste, regt.flg_moeda_controle,
                         regt.num_seq_indice, regt.tip_moeda, regt.dat_moeda,
                         regt.val_resumo_sec, regt.val_termo_sec,
                         regt.val_pagamento_sec, regt.val_reajuste_sec,
                         regt.val_pago_sec, regt.val_pago_reajuste_sec,
                         regt.cod_recurso_res, regt.val_cotacao_moeda,
                         regt.tip_cotacao_moeda,regs.num_versao_contrato);
         EXCEPTION
            WHEN OTHERS
            THEN
               raise_application_error (
                  -20100,
                     ' Erro ao Criar novo resumo do novo Contrato '
                  || SQLERRM
               );
         END;
*/
         BEGIN
            UPDATE IFRBDE.cad_resumo_valores
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
            SELECT IFRBDE_views.seq_num_seq_contrato.NEXTVAL
              INTO v_num_seq_termo_aditivo_novo
              FROM DUAL;

            
--         
--
            BEGIN
               INSERT INTO IFRBDE.tab_cont_termo_aditivo
                           (cta_periodo, cta_num,
                            cta_objeto, cta_valor, cta_prazo, cta_deb_cred,
                            cta_aum_dim, num_seq_termo,
                            num_seq_contrato_termo, num_seq_resumo_ta,
                            dat_moeda_ta,
                            val_moeda_ta, tip_cotacao_moeda,
                            num_versao_contrato_vta)
                    VALUES (p_dat_termo_aditivo, p_num_termo_aditivo,
                            p_dsc_objeto_ta, 0, 0, 1,
                            0, v_num_seq_termo_aditivo_novo,
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
-- copiar o cronograma do resumo
--
         FOR regy IN rega (regt.num_seq_resumo)
         LOOP
            
--
--       gravar o cronograma de cada resumo
--
            SELECT IFRBDE_views.seq_num_seq_contrato.NEXTVAL
              INTO v_num_seq_cronograma_novo
              FROM DUAL;

            
/*
            BEGIN
               INSERT INTO IFRBDE.hst_cont_crono_pagamento
                           (ccp_pgose, ccp_data_venc,
                            ccp_rti_cod, ccp_valor,
                            num_seq_cronograma, num_seq_contrato_cron,
                            tip_cronograma, dat_moeda_crono,
                            val_cotacao_crono, tip_cotacao_crono,
                            val_crono_moeda_sec, val_saldo_crono,
                            val_saldo_crono_sec,num_versao_contrato_cron)
                    VALUES (regy.ccp_pgose, regy.ccp_data_venc,
                            regy.ccp_rti_cod, regy.ccp_valor,
                            v_num_seq_cronograma_novo, v_num_seq_resumo_novo,
                            regy.tip_cronograma, regy.dat_moeda_crono,
                            regy.val_cotacao_crono, regy.tip_cotacao_crono,
                            regy.val_crono_moeda_sec,regy.val_saldo_crono,
                            regy.val_saldo_crono_sec,regy.num_versao_contrato_cron);
            EXCEPTION
               WHEN OTHERS
               THEN
                  raise_application_error (
                     -20100,
                        ' Erro ao Criar novo Cronograma do resumo do novo Contrato '
                     || SQLERRM
                  );
            END;
*/
--
            BEGIN
               IF regy.ccp_valor = regy.val_saldo_crono
               THEN
                  UPDATE IFRBDE.tab_cont_crono_pagamento
                     SET num_versao_contrato_cron =
                                                 TRIM (v_num_versao_contrato)
                   WHERE  CURRENT OF rega;
               ELSE
                  IF regy.val_saldo_crono > 0
                  THEN
                     UPDATE IFRBDE.tab_cont_crono_pagamento
                        SET ccp_valor = (  ccp_valor
                                         - val_saldo_crono
                                        )
                      WHERE  CURRENT OF rega;
                  END IF;
               END IF;
            EXCEPTION
               WHEN OTHERS
               THEN
                  raise_application_error (
                     -20100,
                        ' Erro ao aditivar o cronograma - '
                     || SQLERRM
                  );
            END;
         
--
         END LOOP;

         
--
--
-- MUDAR OS PAGAMENTOS PARA HISTORICO
--
         FOR regw IN regp (regt.num_seq_resumo)
         LOOP
            
--
            BEGIN
               UPDATE IFRBDE.cad_resumo_pagamento
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
         
--
         END LOOP;
      
--
      END LOOP;

      BEGIN
         UPDATE IFRBDE.tab_contrato
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
