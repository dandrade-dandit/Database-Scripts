/* Formatted on 2007/01/05 16:02 (Formatter Plus v4.8.0) */
CREATE OR REPLACE PACKAGE BODY ifrbde.pck_envio_contrato
IS
--------------------------------------------------------------------
   -- Pesquisa Enviar Contrato para Financ.
   -- retorna o recordset correspondente
   PROCEDURE stp_pesquisa_envio_contrato (
      p_usuario                  IN       VARCHAR2,
      vo_tip_comando             OUT      tyt_tip_comando,
      vo_num_seq_contrato        OUT      tyt_num_seq_contrato,
      vo_cnt_cre_cod             OUT      tyt_cnt_cre_cod,
      vo_cnt_cod                 OUT      tyt_cnt_cod,
      vo_num_versao_contrato     OUT      tyt_num_versao_contrato,
      vo_cod_dep_contrato        OUT      tyt_cod_dep_contrato,
      vo_tip_situacao_contrato   OUT      tyt_tip_situacao_contrato,
      vi_num_seq_contrato        IN       t_num_seq_contrato
   )
   AS
   BEGIN
      IF ifrseg.pck_seguranca.stf_permitido (p_usuario,
                                             'VIW_ENVIO_CONTRATO',
                                             'PESQUISA'
                                            )
      THEN
         SELECT tip_comando, num_seq_contrato,
                cnt_cre_cod, cnt_cod,
                num_versao_contrato, cod_dep_contrato,
                tip_situacao_contrato
           INTO vo_tip_comando (1), vo_num_seq_contrato (1),
                vo_cnt_cre_cod (1), vo_cnt_cod (1),
                vo_num_versao_contrato (1), vo_cod_dep_contrato (1),
                vo_tip_situacao_contrato (1)
           FROM ifrbde.viw_envio_contrato
          WHERE num_seq_contrato = vi_num_seq_contrato;
      END IF;
   EXCEPTION
      WHEN OTHERS
      THEN
         raise_application_error (-20100, SQLERRM);
   END;

--------------------------------------------------------------------
--
-- rotina alterar para enviar o contrato
--
-- Altera Enviar Contrato para Financ.
-- retorna o recordset correspondente
   PROCEDURE stp_altera_envio_contrato (
      p_usuario                  IN       VARCHAR2,
      vo_tip_comando             OUT      tyt_tip_comando,
      vo_num_seq_contrato        OUT      tyt_num_seq_contrato,
      vo_cnt_cre_cod             OUT      tyt_cnt_cre_cod,
      vo_cnt_cod                 OUT      tyt_cnt_cod,
      vo_num_versao_contrato     OUT      tyt_num_versao_contrato,
      vo_cod_dep_contrato        OUT      tyt_cod_dep_contrato,
      vo_tip_situacao_contrato   OUT      tyt_tip_situacao_contrato,
      vi_tip_comando             IN       t_tip_comando,
      vi_num_seq_contrato        IN       t_num_seq_contrato,
      vi_cnt_cre_cod             IN       t_cnt_cre_cod,
      vi_cnt_cod                 IN       t_cnt_cod,
      vi_num_versao_contrato     IN       t_num_versao_contrato,
      vi_cod_dep_contrato        IN       t_cod_dep_contrato,
      vi_tip_situacao_contrato   IN       t_tip_situacao_contrato
   )
   AS
      CURSOR c_cursor
      IS
         SELECT *
           FROM ifrbde.viw_envio_contrato
          WHERE num_seq_contrato = vi_num_seq_contrato;

--
      CURSOR regr
      IS
         SELECT *
           FROM ifrbde.cad_resumo_valores
          WHERE num_seq_contrato_res = vi_num_seq_contrato;

--
      v_viw_envio_contrato      ifrbde.viw_envio_contrato%ROWTYPE;
      v_tip_comando             ifrbde.viw_envio_contrato.tip_comando%TYPE;
      v_num_seq_contrato        ifrbde.viw_envio_contrato.num_seq_contrato%TYPE;
      v_cnt_cre_cod             ifrbde.viw_envio_contrato.cnt_cre_cod%TYPE;
      v_cnt_cod                 ifrbde.viw_envio_contrato.cnt_cod%TYPE;
      v_num_versao_contrato     ifrbde.viw_envio_contrato.num_versao_contrato%TYPE;
      v_cod_dep_contrato        ifrbde.viw_envio_contrato.cod_dep_contrato%TYPE;
      v_tip_situacao_contrato   ifrbde.viw_envio_contrato.tip_situacao_contrato%TYPE;
      v_dado                    VARCHAR2 (4000)                       := NULL;
--
      v_existe_real             NUMBER (1);
--
   BEGIN
      IF ifrseg.pck_seguranca.stf_permitido (p_usuario,
                                             'VIW_ENVIO_CONTRATO',
                                             'ALTERA'
                                            )
      THEN
         OPEN c_cursor;

         FETCH c_cursor
          INTO v_viw_envio_contrato;

         IF NOT c_cursor%NOTFOUND
         THEN
            v_tip_comando := RTRIM (LTRIM (vi_tip_comando));
            v_cnt_cod := RTRIM (LTRIM (vi_cnt_cod));
            v_num_versao_contrato := RTRIM (LTRIM (vi_num_versao_contrato));
            v_num_seq_contrato := vi_num_seq_contrato;
            v_cnt_cre_cod := vi_cnt_cre_cod;
            v_cod_dep_contrato := vi_cod_dep_contrato;
            v_tip_situacao_contrato := vi_tip_situacao_contrato;

--
--
-- disparar a integração com smartstream para alteração da situação do contrato
--
            IF v_tip_situacao_contrato IN (2, 4)
            THEN
--
-- limpa o historico e refaz o saldo no cronograma antes da versão atual
--
               ifrbde.prc_calcula_hst_pag_crono (v_num_seq_contrato);
--
--    transmite para o area de integração a ultima versão do contrato
--
--  Exclui a versão do contrato atual da integração
--
               ifrbde.prc_exclui_sst_contrato (v_cnt_cod,
                                               v_num_versao_contrato
                                              );
--
               ifrbde.prc_conf_identificacao_u (v_num_seq_contrato);
               ifrbde.prc_conf_objeto_u (v_num_seq_contrato);
               ifrbde.prc_conf_termo_u (v_num_seq_contrato);
               ifrbde.prc_conf_datas_publicacao_u (v_num_seq_contrato);
               ifrbde.prc_conf_participantes_u (v_num_seq_contrato);
               ifrbde.prc_conf_item_ident_u (v_num_seq_contrato);
               ifrbde.prc_conf_item_acct_u (v_num_seq_contrato);
--            ifrbde.prc_conf_seguranca_u (v_num_seq_contrato);
               ifrbde.prc_conf_item_resumo_u (v_num_seq_contrato);
               ifrbde.prc_conf_item_cronog_u (v_num_seq_contrato);
--
--
-- refaz o saldo no cronograma da versão atual
--
               ifrbde.prc_calcula_hst_pag_crono_vers (v_num_seq_contrato);
--
-- verifica a necessidade de recriar o cronograma de realização
-- verifica se existe resumo com cronogramas divergentes
--
               v_existe_real := 0;

               FOR regs IN regr
               LOOP
--
-- calcula os totais para o cronograma realizado de desembolso, Desembolso aduaneiro
--
                  IF regs.flg_moeda_controle = 1
                  THEN
                     IF NVL (regs.val_pagamento, 0) <>
                                        NVL (regs.val_crono_realizado_pag, 0)
                     THEN
                        v_existe_real := 1;
                     END IF;

--
-- calcula os totais para o cronograma de reajuste
--
                     IF NVL (regs.val_reajuste, 0) <
                                        NVL (regs.val_crono_realizado_reaj, 0)
                     THEN
                        v_existe_real := 1;
                     END IF;
                  END IF;

--
--  calcula o resumo para moeda secundaria
--  calcula os totais para o cronograma de desembolso, Desembolso aduaneiro
--
                  IF regs.flg_moeda_controle = 2
                  THEN
                     IF NVL (regs.val_pagamento_sec, 0) <>
                                    NVL (regs.val_crono_realizado_pag_sec, 0)
                     THEN
                        v_existe_real := 1;
                     END IF;
                  END IF;
               END LOOP;

--
--
               IF v_existe_real = 1
               THEN
--
--   executa a rotina quando for enviado para financeira e avisar que necessita  de ajuste
--
                  ifrbde.prc_gerar_cronograma_realizado (v_num_seq_contrato);
               END IF;

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
                     raise_application_error
                        (-20100,
                            'Erro ao Atualizar Situação do Contrato e as Criticas '
                         || SQLERRM
                        );
               END;
--
            END IF;

--
            IF SQL%ROWCOUNT = 1
            THEN
               stp_pesquisa_envio_contrato (p_usuario,
                                            vo_tip_comando,
                                            vo_num_seq_contrato,
                                            vo_cnt_cre_cod,
                                            vo_cnt_cod,
                                            vo_num_versao_contrato,
                                            vo_cod_dep_contrato,
                                            vo_tip_situacao_contrato,
                                            vi_num_seq_contrato
                                           );
               v_dado := 'tip_comando = ' || RTRIM (LTRIM (v_tip_comando));
               v_dado :=
                     v_dado
                  || ','
                  || 'num_seq_contrato = '
                  || TO_CHAR (v_num_seq_contrato);
               v_dado :=
                  v_dado || ',' || 'cnt_cre_cod = ' || TO_CHAR (v_cnt_cre_cod);
               v_dado :=
                    v_dado || ',' || 'cnt_cod = ' || RTRIM (LTRIM (v_cnt_cod));
               v_dado :=
                     v_dado
                  || ','
                  || 'num_versao_contrato = '
                  || RTRIM (LTRIM (v_num_versao_contrato));
               v_dado :=
                     v_dado
                  || ','
                  || 'cod_dep_contrato = '
                  || TO_CHAR (v_cod_dep_contrato);
               v_dado :=
                     v_dado
                  || ','
                  || 'tip_situacao_contrato = '
                  || TO_CHAR (v_tip_situacao_contrato);
               -- LOG
               ifrseg.pck_seguranca.stp_log (p_usuario,
                                             'VIW_ENVIO_CONTRATO',
                                             'A',
                                             v_dado
                                            );
               COMMIT;
            ELSE
               ROLLBACK;
               raise_application_error
                  (-20100,
                   'Mais de um registro solicitado para alteração. Operação não realizada!!!'
                  );
            END IF;
         ELSE
            raise_application_error
                             (-20100,
                              'Registro não foi encontrado para alteração!!!'
                             );
         END IF;
      ELSE
         raise_application_error
                             (-20100,
                              'Não foi concedida permissão para alteração!!!'
                             );
      END IF;
   EXCEPTION
      WHEN OTHERS
      THEN
         raise_application_error (-20100, SQLERRM);
   END;
--------------------------------------------------------------------
END;
/

