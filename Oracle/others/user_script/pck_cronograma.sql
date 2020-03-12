/* Formatted on 17/03/2005 14:51 (Formatter Plus v4.8.0) */
CREATE OR REPLACE PACKAGE BODY ifrbde.pck_cronograma IS
--------------------------------------------------------------------
-- Pesquisa Cronog. de Desembolso/Reajuste
-- retorna o recordset correspondente
   PROCEDURE stp_pesquisa_cont_crono_pagame (
      p_usuario                  IN       VARCHAR2,
      vo_num_seq_cronograma      OUT      tyt_num_seq_cronograma,
      vo_num_seq_contrato_cron   OUT      tyt_num_seq_contrato_cron,
      vo_ccp_pgose               OUT      tyt_ccp_pgose,
      vo_ccp_rti_cod             OUT      tyt_ccp_rti_cod,
      vo_ccp_data_venc           OUT      tyt_ccp_data_venc,
      vo_ccp_valor               OUT      tyt_ccp_valor,
      vo_tip_cronograma          OUT      tyt_tip_cronograma,
      vo_dat_moeda_crono         OUT      tyt_dat_moeda_crono,
      vo_val_cotacao_crono       OUT      tyt_val_cotacao_crono,
      vo_tip_cotacao_crono       OUT      tyt_tip_cotacao_crono,
      vo_val_saldo_crono         OUT      tyt_val_saldo_crono,
      vo_val_saldo_crono_sec     OUT      tyt_val_saldo_crono_sec,
      vi_num_seq_cronograma      IN       t_num_seq_cronograma,
      vi_num_seq_contrato_cron   IN       t_num_seq_contrato_cron
   ) AS
   BEGIN
      IF ifrseg.pck_seguranca.stf_permitido (p_usuario,
                                             'TAB_CONT_CRONO_PAGAMENTO',
                                             'PESQUISA'
                                            ) THEN
         SELECT num_seq_cronograma,
                num_seq_contrato_cron,
                ccp_pgose,
                ccp_rti_cod,
                ccp_data_venc,
                ccp_valor,
                tip_cronograma,
                dat_moeda_crono,
                val_cotacao_crono,
                tip_cotacao_crono,
                val_saldo_crono,
                val_saldo_crono_sec
           INTO vo_num_seq_cronograma (1),
                vo_num_seq_contrato_cron (1),
                vo_ccp_pgose (1),
                vo_ccp_rti_cod (1),
                vo_ccp_data_venc (1),
                vo_ccp_valor (1),
                vo_tip_cronograma (1),
                vo_dat_moeda_crono (1),
                vo_val_cotacao_crono (1),
                vo_tip_cotacao_crono (1),
                vo_val_saldo_crono (1),
                vo_val_saldo_crono_sec (1)
           FROM ifrbde.tab_cont_crono_pagamento
          WHERE num_seq_cronograma = vi_num_seq_cronograma
            AND num_seq_contrato_cron = vi_num_seq_contrato_cron;
      END IF;
   EXCEPTION
      WHEN OTHERS THEN
         raise_application_error (-20100, SQLERRM);
   END;

   -- Exclui Cronog. de Desembolso/Reajuste
   -- retorna o OK ou não
   PROCEDURE stp_exclui_cont_crono_pagament (
      p_usuario                  IN       VARCHAR2,
      vo_ok                      OUT      tyt_ok,
      vi_num_seq_cronograma      IN       t_num_seq_cronograma,
      vi_num_seq_contrato_cron   IN       t_num_seq_contrato_cron
   ) AS
      CURSOR c_cursor IS
         SELECT     *
               FROM ifrbde.tab_cont_crono_pagamento
              WHERE num_seq_cronograma = vi_num_seq_cronograma
                AND num_seq_contrato_cron = vi_num_seq_contrato_cron
         FOR UPDATE;

      v_tab_cont_crono_pagamento    ifrbde.tab_cont_crono_pagamento%ROWTYPE;
      v_dado                        VARCHAR2 (4000) := NULL;
   BEGIN
      vo_ok (1) := 0;

      IF ifrseg.pck_seguranca.stf_permitido (p_usuario,
                                             'TAB_CONT_CRONO_PAGAMENTO',
                                             'EXCLUI'
                                            ) THEN
         OPEN c_cursor;

         FETCH c_cursor
          INTO v_tab_cont_crono_pagamento;

         IF NOT c_cursor%NOTFOUND THEN
            v_dado :=
               'num_seq_cronograma = '
               || TO_CHAR (v_tab_cont_crono_pagamento.num_seq_cronograma);
            v_dado :=
               v_dado
               || ','
               || 'num_seq_contrato_cron = '
               || TO_CHAR (v_tab_cont_crono_pagamento.num_seq_contrato_cron);
            v_dado :=
               v_dado
               || ','
               || 'ccp_pgose = '
               || RTRIM (LTRIM (UPPER (v_tab_cont_crono_pagamento.ccp_pgose)));
            v_dado :=
               v_dado
               || ','
               || 'ccp_rti_cod = '
               || RTRIM (LTRIM (UPPER (v_tab_cont_crono_pagamento.ccp_rti_cod))
                        );
            v_dado :=
               v_dado
               || ','
               || 'ccp_data_venc = '
               || TO_DATE (v_tab_cont_crono_pagamento.ccp_data_venc,
                           'DD/MM/YYYY'
                          );
            v_dado :=
               v_dado
               || ','
               || 'ccp_valor = '
               || TO_CHAR (v_tab_cont_crono_pagamento.ccp_valor);
            v_dado :=
               v_dado
               || ','
               || 'tip_cronograma = '
               || RTRIM
                      (LTRIM (UPPER (v_tab_cont_crono_pagamento.tip_cronograma)
                             )
                      );
            v_dado :=
               v_dado
               || ','
               || 'dat_moeda_crono = '
               || TO_DATE (v_tab_cont_crono_pagamento.dat_moeda_crono,
                           'DD/MM/YYYY'
                          );
            v_dado :=
               v_dado
               || ','
               || 'val_cotacao_crono = '
               || TO_CHAR (v_tab_cont_crono_pagamento.val_cotacao_crono);
            v_dado :=
               v_dado
               || ','
               || 'tip_cotacao_crono = '
               || RTRIM
                    (LTRIM
                          (UPPER (v_tab_cont_crono_pagamento.tip_cotacao_crono)
                          )
                    );
            v_dado :=
               v_dado
               || ','
               || 'val_saldo_crono = '
               || TO_CHAR (v_tab_cont_crono_pagamento.val_saldo_crono);
            v_dado :=
               v_dado
               || ','
               || 'val_saldo_crono_sec = '
               || TO_CHAR (v_tab_cont_crono_pagamento.val_saldo_crono_sec);

            IF c_cursor%ROWCOUNT = 1 THEN
               vo_ok (1) := 1;
               -- LOG
               ifrseg.pck_seguranca.stp_log (p_usuario,
                                             'TAB_CONT_CRONO_PAGAMENTO',
                                             'E',
                                             v_dado
                                            );

               DELETE FROM ifrbde.tab_cont_crono_pagamento
                     WHERE CURRENT OF c_cursor;

               IF c_cursor%ROWCOUNT = 1 THEN
                  vo_ok (1) := 1;
--
                  ifrbde.prc_critica_crono_contrato (vi_num_seq_contrato_cron);
--
-- atualiza os dados para o relatorio de cronograma de medicao - parte do cronograma financeiro
--
                  ifrbde.prc_rel_cronograma_medicao
                                                   (vi_num_seq_contrato_cron,
                                                    'CF'
                                                   );
--
                  COMMIT;
               ELSIF c_cursor%ROWCOUNT > 1 THEN
                  ROLLBACK;
               END IF;
            END IF;
         END IF;
      END IF;
   EXCEPTION
      WHEN OTHERS THEN
         raise_application_error (-20100, SQLERRM);
   END;

--------------------------------------------------------------------
-- Inclui Cronog. de Desembolso/Reajuste
-- retorna o recordset correspondente
   PROCEDURE stp_inclui_cont_crono_pagament (
      p_usuario                  IN       VARCHAR2,
      vo_num_seq_cronograma      OUT      tyt_num_seq_cronograma,
      vo_num_seq_contrato_cron   OUT      tyt_num_seq_contrato_cron,
      vo_ccp_pgose               OUT      tyt_ccp_pgose,
      vo_ccp_rti_cod             OUT      tyt_ccp_rti_cod,
      vo_ccp_data_venc           OUT      tyt_ccp_data_venc,
      vo_ccp_valor               OUT      tyt_ccp_valor,
      vo_tip_cronograma          OUT      tyt_tip_cronograma,
      vo_dat_moeda_crono         OUT      tyt_dat_moeda_crono,
      vo_val_cotacao_crono       OUT      tyt_val_cotacao_crono,
      vo_tip_cotacao_crono       OUT      tyt_tip_cotacao_crono,
      vo_val_saldo_crono         OUT      tyt_val_saldo_crono,
      vo_val_saldo_crono_sec     OUT      tyt_val_saldo_crono_sec,
      vi_num_seq_contrato_cron   IN       t_num_seq_contrato_cron,
      vi_ccp_pgose               IN       t_ccp_pgose,
      vi_ccp_rti_cod             IN       t_ccp_rti_cod,
      vi_ccp_data_venc           IN       t_ccp_data_venc,
      vi_ccp_valor               IN       t_ccp_valor,
      vi_tip_cronograma          IN       t_tip_cronograma,
      vi_dat_moeda_crono         IN       t_dat_moeda_crono,
      vi_val_cotacao_crono       IN       t_val_cotacao_crono,
      vi_tip_cotacao_crono       IN       t_tip_cotacao_crono
   ) AS
      v_num_seq_cronograma          tab_cont_crono_pagamento.num_seq_cronograma%TYPE;
      v_num_seq_contrato_cron       tab_cont_crono_pagamento.num_seq_contrato_cron%TYPE;
      v_ccp_pgose                   tab_cont_crono_pagamento.ccp_pgose%TYPE;
      v_ccp_rti_cod                 tab_cont_crono_pagamento.ccp_rti_cod%TYPE;
      v_ccp_data_venc               tab_cont_crono_pagamento.ccp_data_venc%TYPE;
      v_ccp_valor                   tab_cont_crono_pagamento.ccp_valor%TYPE;
      v_tip_cronograma              tab_cont_crono_pagamento.tip_cronograma%TYPE;
      v_dat_moeda_crono             tab_cont_crono_pagamento.dat_moeda_crono%TYPE;
      v_val_cotacao_crono           tab_cont_crono_pagamento.val_cotacao_crono%TYPE;
      v_tip_cotacao_crono           tab_cont_crono_pagamento.tip_cotacao_crono%TYPE;
      v_dado                        VARCHAR2 (4000) := NULL;
   BEGIN
      IF ifrseg.pck_seguranca.stf_permitido (p_usuario,
                                             'TAB_CONT_CRONO_PAGAMENTO',
                                             'INCLUI'
                                            ) THEN
         SELECT ifrbde.seq_num_seq_contrato.NEXTVAL
           INTO v_num_seq_cronograma
           FROM DUAL;

         v_ccp_pgose := RTRIM (LTRIM (vi_ccp_pgose));
         v_ccp_rti_cod := RTRIM (LTRIM (vi_ccp_rti_cod));
         v_tip_cronograma := RTRIM (LTRIM (vi_tip_cronograma));
         v_tip_cotacao_crono := RTRIM (LTRIM (vi_tip_cotacao_crono));
         v_ccp_data_venc := TO_DATE (vi_ccp_data_venc, 'DD/MM/YYYY');
         v_dat_moeda_crono := TO_DATE (vi_dat_moeda_crono, 'DD/MM/YYYY');
         v_num_seq_contrato_cron := vi_num_seq_contrato_cron;
         v_ccp_valor := vi_ccp_valor;
         v_val_cotacao_crono := vi_val_cotacao_crono;

         INSERT INTO ifrbde.tab_cont_crono_pagamento
                     (num_seq_cronograma,
                      num_seq_contrato_cron,
                      ccp_pgose,
                      ccp_rti_cod,
                      ccp_data_venc,
                      ccp_valor,
                      tip_cronograma,
                      dat_moeda_crono,
                      val_cotacao_crono,
                      tip_cotacao_crono
                     )
              VALUES (v_num_seq_cronograma,
                      v_num_seq_contrato_cron,
                      v_ccp_pgose,
                      v_ccp_rti_cod,
                      v_ccp_data_venc,
                      v_ccp_valor,
                      v_tip_cronograma,
                      v_dat_moeda_crono,
                      v_val_cotacao_crono,
                      v_tip_cotacao_crono
                     );

         IF SQL%ROWCOUNT = 1 THEN
            stp_pesquisa_cont_crono_pagame (p_usuario,
                                            vo_num_seq_cronograma,
                                            vo_num_seq_contrato_cron,
                                            vo_ccp_pgose,
                                            vo_ccp_rti_cod,
                                            vo_ccp_data_venc,
                                            vo_ccp_valor,
                                            vo_tip_cronograma,
                                            vo_dat_moeda_crono,
                                            vo_val_cotacao_crono,
                                            vo_tip_cotacao_crono,
                                            vo_val_saldo_crono,
                                            vo_val_saldo_crono_sec,
                                            v_num_seq_cronograma,
                                            v_num_seq_contrato_cron
                                           );
            v_dado :=
                     'num_seq_cronograma = ' || TO_CHAR (v_num_seq_cronograma);
            v_dado :=
               v_dado
               || ','
               || 'num_seq_contrato_cron = '
               || TO_CHAR (v_num_seq_contrato_cron);
            v_dado :=
                v_dado || ',' || 'ccp_pgose = ' || RTRIM (LTRIM (v_ccp_pgose));
            v_dado :=
               v_dado || ',' || 'ccp_rti_cod = '
               || RTRIM (LTRIM (v_ccp_rti_cod));
            v_dado :=
               v_dado
               || ','
               || 'ccp_data_venc = '
               || TO_CHAR (v_ccp_data_venc, 'DD/MM/YYYY');
            v_dado := v_dado || ',' || 'ccp_valor = ' || TO_CHAR (v_ccp_valor);
            v_dado :=
               v_dado
               || ','
               || 'tip_cronograma = '
               || RTRIM (LTRIM (v_tip_cronograma));
            v_dado :=
               v_dado
               || ','
               || 'dat_moeda_crono = '
               || TO_CHAR (v_dat_moeda_crono, 'DD/MM/YYYY');
            v_dado :=
               v_dado
               || ','
               || 'val_cotacao_crono = '
               || TO_CHAR (v_val_cotacao_crono);
            v_dado :=
               v_dado
               || ','
               || 'tip_cotacao_crono = '
               || RTRIM (LTRIM (v_tip_cotacao_crono));
            -- LOG
            ifrseg.pck_seguranca.stp_log (p_usuario,
                                          'TAB_CONT_CRONO_PAGAMENTO',
                                          'I',
                                          v_dado
                                         );
--
            ifrbde.prc_critica_crono_contrato (vi_num_seq_contrato_cron);
--
--
-- atualiza os dados para o relatorio de cronograma de medicao - parte do cronograma financeiro
--
            ifrbde.prc_rel_cronograma_medicao (vi_num_seq_contrato_cron, 'CF');
--
            COMMIT;
         ELSE
            ROLLBACK;
         END IF;
      END IF;
   EXCEPTION
      WHEN OTHERS THEN
         raise_application_error (-20100, SQLERRM);
   END;

--------------------------------------------------------------------
-- Altera Cronog. de Desembolso/Reajuste
-- retorna o recordset correspondente
   PROCEDURE stp_altera_cont_crono_pagament (
      p_usuario                  IN       VARCHAR2,
      vo_num_seq_cronograma      OUT      tyt_num_seq_cronograma,
      vo_num_seq_contrato_cron   OUT      tyt_num_seq_contrato_cron,
      vo_ccp_pgose               OUT      tyt_ccp_pgose,
      vo_ccp_rti_cod             OUT      tyt_ccp_rti_cod,
      vo_ccp_data_venc           OUT      tyt_ccp_data_venc,
      vo_ccp_valor               OUT      tyt_ccp_valor,
      vo_tip_cronograma          OUT      tyt_tip_cronograma,
      vo_dat_moeda_crono         OUT      tyt_dat_moeda_crono,
      vo_val_cotacao_crono       OUT      tyt_val_cotacao_crono,
      vo_tip_cotacao_crono       OUT      tyt_tip_cotacao_crono,
      vo_val_saldo_crono         OUT      tyt_val_saldo_crono,
      vo_val_saldo_crono_sec     OUT      tyt_val_saldo_crono_sec,
      vi_num_seq_cronograma      IN       t_num_seq_cronograma,
      vi_num_seq_contrato_cron   IN       t_num_seq_contrato_cron,
      vi_ccp_pgose               IN       t_ccp_pgose,
      vi_ccp_rti_cod             IN       t_ccp_rti_cod,
      vi_ccp_data_venc           IN       t_ccp_data_venc,
      vi_ccp_valor               IN       t_ccp_valor,
      vi_tip_cronograma          IN       t_tip_cronograma,
      vi_dat_moeda_crono         IN       t_dat_moeda_crono,
      vi_val_cotacao_crono       IN       t_val_cotacao_crono,
      vi_tip_cotacao_crono       IN       t_tip_cotacao_crono
   ) AS
      CURSOR c_cursor IS
         SELECT     *
               FROM ifrbde.tab_cont_crono_pagamento
              WHERE num_seq_cronograma = vi_num_seq_cronograma
                AND num_seq_contrato_cron = vi_num_seq_contrato_cron
         FOR UPDATE;

      v_tab_cont_crono_pagamento    ifrbde.tab_cont_crono_pagamento%ROWTYPE;
      v_num_seq_cronograma          ifrbde.tab_cont_crono_pagamento.num_seq_cronograma%TYPE;
      v_num_seq_contrato_cron       ifrbde.tab_cont_crono_pagamento.num_seq_contrato_cron%TYPE;
      v_ccp_pgose                   ifrbde.tab_cont_crono_pagamento.ccp_pgose%TYPE;
      v_ccp_rti_cod                 ifrbde.tab_cont_crono_pagamento.ccp_rti_cod%TYPE;
      v_ccp_data_venc               ifrbde.tab_cont_crono_pagamento.ccp_data_venc%TYPE;
      v_ccp_valor                   ifrbde.tab_cont_crono_pagamento.ccp_valor%TYPE;
      v_tip_cronograma              ifrbde.tab_cont_crono_pagamento.tip_cronograma%TYPE;
      v_dat_moeda_crono             ifrbde.tab_cont_crono_pagamento.dat_moeda_crono%TYPE;
      v_val_cotacao_crono           ifrbde.tab_cont_crono_pagamento.val_cotacao_crono%TYPE;
      v_tip_cotacao_crono           ifrbde.tab_cont_crono_pagamento.tip_cotacao_crono%TYPE;
      v_dado                        VARCHAR2 (4000) := NULL;
   BEGIN
      IF ifrseg.pck_seguranca.stf_permitido (p_usuario,
                                             'TAB_CONT_CRONO_PAGAMENTO',
                                             'ALTERA'
                                            ) THEN
         OPEN c_cursor;

         FETCH c_cursor
          INTO v_tab_cont_crono_pagamento;

         IF NOT c_cursor%NOTFOUND THEN
            v_ccp_pgose := RTRIM (LTRIM (vi_ccp_pgose));
            v_ccp_rti_cod := RTRIM (LTRIM (vi_ccp_rti_cod));
            v_tip_cronograma := RTRIM (LTRIM (vi_tip_cronograma));
            v_tip_cotacao_crono := RTRIM (LTRIM (vi_tip_cotacao_crono));
            v_ccp_data_venc := TO_DATE (vi_ccp_data_venc, 'DD/MM/YYYY');
            v_dat_moeda_crono := TO_DATE (vi_dat_moeda_crono, 'DD/MM/YYYY');
            v_num_seq_cronograma := vi_num_seq_cronograma;
            v_num_seq_contrato_cron := vi_num_seq_contrato_cron;
            v_ccp_valor := vi_ccp_valor;
            v_val_cotacao_crono := vi_val_cotacao_crono;

            UPDATE ifrbde.tab_cont_crono_pagamento
               SET ccp_pgose = v_ccp_pgose,
                   ccp_rti_cod = v_ccp_rti_cod,
                   ccp_data_venc = v_ccp_data_venc,
                   ccp_valor = v_ccp_valor,
                   tip_cronograma = v_tip_cronograma,
                   dat_moeda_crono = v_dat_moeda_crono,
                   val_cotacao_crono = v_val_cotacao_crono,
                   tip_cotacao_crono = v_tip_cotacao_crono
             WHERE CURRENT OF c_cursor;

            IF SQL%ROWCOUNT = 1 THEN
               stp_pesquisa_cont_crono_pagame (p_usuario,
                                               vo_num_seq_cronograma,
                                               vo_num_seq_contrato_cron,
                                               vo_ccp_pgose,
                                               vo_ccp_rti_cod,
                                               vo_ccp_data_venc,
                                               vo_ccp_valor,
                                               vo_tip_cronograma,
                                               vo_dat_moeda_crono,
                                               vo_val_cotacao_crono,
                                               vo_tip_cotacao_crono,
                                               vo_val_saldo_crono,
                                               vo_val_saldo_crono_sec,
                                               vi_num_seq_cronograma,
                                               vi_num_seq_contrato_cron
                                              );
               v_dado :=
                     'num_seq_cronograma = ' || TO_CHAR (v_num_seq_cronograma);
               v_dado :=
                  v_dado
                  || ','
                  || 'num_seq_contrato_cron = '
                  || TO_CHAR (v_num_seq_contrato_cron);
               v_dado :=
                  v_dado || ',' || 'ccp_pgose = '
                  || RTRIM (LTRIM (v_ccp_pgose));
               v_dado :=
                  v_dado
                  || ','
                  || 'ccp_rti_cod = '
                  || RTRIM (LTRIM (v_ccp_rti_cod));
               v_dado :=
                  v_dado
                  || ','
                  || 'ccp_data_venc = '
                  || TO_CHAR (v_ccp_data_venc, 'DD/MM/YYYY');
               v_dado :=
                      v_dado || ',' || 'ccp_valor = ' || TO_CHAR (v_ccp_valor);
               v_dado :=
                  v_dado
                  || ','
                  || 'tip_cronograma = '
                  || RTRIM (LTRIM (v_tip_cronograma));
               v_dado :=
                  v_dado
                  || ','
                  || 'dat_moeda_crono = '
                  || TO_CHAR (v_dat_moeda_crono, 'DD/MM/YYYY');
               v_dado :=
                  v_dado
                  || ','
                  || 'val_cotacao_crono = '
                  || TO_CHAR (v_val_cotacao_crono);
               v_dado :=
                  v_dado
                  || ','
                  || 'tip_cotacao_crono = '
                  || RTRIM (LTRIM (v_tip_cotacao_crono));
               -- LOG
               ifrseg.pck_seguranca.stp_log (p_usuario,
                                             'TAB_CONT_CRONO_PAGAMENTO',
                                             'A',
                                             v_dado
                                            );
--
               ifrbde.prc_critica_crono_contrato (vi_num_seq_contrato_cron);
--
--
-- atualiza os dados para o relatorio de cronograma de medicao - parte do cronograma financeiro
--
               ifrbde.prc_rel_cronograma_medicao (vi_num_seq_contrato_cron,
                                                  'CF'
                                                 );
--
               COMMIT;
            ELSE
               ROLLBACK;
            END IF;
         END IF;
      END IF;
   EXCEPTION
      WHEN OTHERS THEN
         raise_application_error (-20100, SQLERRM);
   END;

--------------------------------------------------------------------
-- Pesquisa Situação do Contrato
-- retorna o recordset correspondente
   PROCEDURE stp_pesquisa_situacao_contrato (
      p_usuario                  IN       VARCHAR2,
      vo_num_seq_contrato        OUT      tyt_num_seq_contrato,
      vo_cnt_cre_cod             OUT      tyt_cnt_cre_cod,
      vo_cnt_cod                 OUT      tyt_cnt_cod,
      vo_num_versao_contrato     OUT      tyt_num_versao_contrato,
      vo_cod_dep_contrato        OUT      tyt_cod_dep_contrato,
      vo_tip_situacao_contrato   OUT      tyt_tip_situacao_contrato,
      vo_tip_contrato            OUT      tyt_tip_contrato,
      vo_dsc_critica_contrato    OUT      tyt_dsc_critica_contrato,
      vi_num_seq_contrato        IN       t_num_seq_contrato,
      vi_cnt_cre_cod             IN       t_cnt_cre_cod
   ) AS
   BEGIN
      IF ifrseg.pck_seguranca.stf_permitido (p_usuario,
                                             'VIW_SITUACAO_CONTRATO',
                                             'PESQUISA'
                                            ) THEN
         SELECT num_seq_contrato,
                cnt_cre_cod,
                cnt_cod,
                num_versao_contrato,
                cod_dep_contrato,
                tip_situacao_contrato,
                tip_contrato,
                dsc_critica_contrato
           INTO vo_num_seq_contrato (1),
                vo_cnt_cre_cod (1),
                vo_cnt_cod (1),
                vo_num_versao_contrato (1),
                vo_cod_dep_contrato (1),
                vo_tip_situacao_contrato (1),
                vo_tip_contrato (1),
                vo_dsc_critica_contrato (1)
           FROM ifrbde.viw_situacao_contrato
          WHERE num_seq_contrato = vi_num_seq_contrato
            AND cnt_cre_cod = vi_cnt_cre_cod;
      END IF;
   EXCEPTION
      WHEN OTHERS THEN
         raise_application_error (-20100, SQLERRM);
   END;

   -- Exclui Situação do Contrato
   -- retorna o OK ou não
   PROCEDURE stp_exclui_situacao_contrato (
      p_usuario                  IN       VARCHAR2,
      vo_ok                      OUT      tyt_ok,
      vi_num_seq_contrato        IN       t_num_seq_contrato,
      vi_cnt_cre_cod             IN       t_cnt_cre_cod
   ) AS
      CURSOR c_cursor IS
         SELECT     *
               FROM ifrbde.viw_situacao_contrato
              WHERE num_seq_contrato = vi_num_seq_contrato
                AND cnt_cre_cod = vi_cnt_cre_cod
         FOR UPDATE;

      v_viw_situacao_contrato       ifrbde.viw_situacao_contrato%ROWTYPE;
      v_dado                        VARCHAR2 (4000) := NULL;
   BEGIN
      vo_ok (1) := 0;

      IF ifrseg.pck_seguranca.stf_permitido (p_usuario,
                                             'VIW_SITUACAO_CONTRATO',
                                             'EXCLUI'
                                            ) THEN
         OPEN c_cursor;

         FETCH c_cursor
          INTO v_viw_situacao_contrato;

         IF NOT c_cursor%NOTFOUND THEN
            v_dado :=
               'num_seq_contrato = '
               || TO_CHAR (v_viw_situacao_contrato.num_seq_contrato);
            v_dado :=
               v_dado
               || ','
               || 'cnt_cre_cod = '
               || TO_CHAR (v_viw_situacao_contrato.cnt_cre_cod);
            v_dado :=
               v_dado
               || ','
               || 'cnt_cod = '
               || RTRIM (LTRIM (UPPER (v_viw_situacao_contrato.cnt_cod)));
            v_dado :=
               v_dado
               || ','
               || 'num_versao_contrato = '
               || RTRIM
                    (LTRIM (UPPER (v_viw_situacao_contrato.num_versao_contrato)
                           )
                    );
            v_dado :=
               v_dado
               || ','
               || 'cod_dep_contrato = '
               || TO_CHAR (v_viw_situacao_contrato.cod_dep_contrato);
            v_dado :=
               v_dado
               || ','
               || 'tip_situacao_contrato = '
               || TO_CHAR (v_viw_situacao_contrato.tip_situacao_contrato);
            v_dado :=
               v_dado
               || ','
               || 'tip_contrato = '
               || RTRIM (LTRIM (UPPER (v_viw_situacao_contrato.tip_contrato)));
            v_dado :=
               v_dado
               || ','
               || 'dsc_critica_contrato = '
               || RTRIM
                    (LTRIM
                          (UPPER (v_viw_situacao_contrato.dsc_critica_contrato)
                          )
                    );

            IF c_cursor%ROWCOUNT = 1 THEN
               vo_ok (1) := 1;
               -- LOG
               ifrseg.pck_seguranca.stp_log (p_usuario,
                                             'VIW_SITUACAO_CONTRATO',
                                             'E',
                                             v_dado
                                            );

               DELETE FROM ifrbde.viw_situacao_contrato
                     WHERE CURRENT OF c_cursor;

               IF c_cursor%ROWCOUNT = 1 THEN
                  vo_ok (1) := 1;
                  COMMIT;
               ELSIF c_cursor%ROWCOUNT > 1 THEN
                  ROLLBACK;
               END IF;
            END IF;
         END IF;
      END IF;
   EXCEPTION
      WHEN OTHERS THEN
         raise_application_error (-20100, SQLERRM);
   END;

--------------------------------------------------------------------
-- Inclui Situação do Contrato
-- retorna o recordset correspondente
   PROCEDURE stp_inclui_situacao_contrato (
      p_usuario                  IN       VARCHAR2,
      vo_num_seq_contrato        OUT      tyt_num_seq_contrato,
      vo_cnt_cre_cod             OUT      tyt_cnt_cre_cod,
      vo_cnt_cod                 OUT      tyt_cnt_cod,
      vo_num_versao_contrato     OUT      tyt_num_versao_contrato,
      vo_cod_dep_contrato        OUT      tyt_cod_dep_contrato,
      vo_tip_situacao_contrato   OUT      tyt_tip_situacao_contrato,
      vo_tip_contrato            OUT      tyt_tip_contrato,
      vo_dsc_critica_contrato    OUT      tyt_dsc_critica_contrato,
      vi_cnt_cre_cod             IN       t_cnt_cre_cod,
      vi_cnt_cod                 IN       t_cnt_cod,
      vi_num_versao_contrato     IN       t_num_versao_contrato,
      vi_cod_dep_contrato        IN       t_cod_dep_contrato,
      vi_tip_situacao_contrato   IN       t_tip_situacao_contrato,
      vi_dsc_critica_contrato    IN       t_dsc_critica_contrato
   ) AS
      v_num_seq_contrato            viw_situacao_contrato.num_seq_contrato%TYPE;
      v_cnt_cre_cod                 viw_situacao_contrato.cnt_cre_cod%TYPE;
      v_cnt_cod                     viw_situacao_contrato.cnt_cod%TYPE;
      v_num_versao_contrato         viw_situacao_contrato.num_versao_contrato%TYPE;
      v_cod_dep_contrato            viw_situacao_contrato.cod_dep_contrato%TYPE;
      v_tip_situacao_contrato       viw_situacao_contrato.tip_situacao_contrato%TYPE;
      v_dsc_critica_contrato        viw_situacao_contrato.dsc_critica_contrato%TYPE;
      v_dado                        VARCHAR2 (4000) := NULL;
   BEGIN
      IF ifrseg.pck_seguranca.stf_permitido (p_usuario,
                                             'VIW_SITUACAO_CONTRATO',
                                             'INCLUI'
                                            ) THEN
         SELECT ifrbde.seq_num_seq_contrato.NEXTVAL
           INTO v_num_seq_contrato
           FROM DUAL;

         v_cnt_cod := RTRIM (LTRIM (vi_cnt_cod));
         v_num_versao_contrato := RTRIM (LTRIM (vi_num_versao_contrato));
         v_dsc_critica_contrato := RTRIM (LTRIM (vi_dsc_critica_contrato));
         v_cnt_cre_cod := vi_cnt_cre_cod;
         v_cod_dep_contrato := vi_cod_dep_contrato;
         v_tip_situacao_contrato := vi_tip_situacao_contrato;

         INSERT INTO ifrbde.viw_situacao_contrato
                     (num_seq_contrato,
                      cnt_cre_cod,
                      cnt_cod,
                      num_versao_contrato,
                      cod_dep_contrato,
                      tip_situacao_contrato,
                      dsc_critica_contrato
                     )
              VALUES (v_num_seq_contrato,
                      v_cnt_cre_cod,
                      v_cnt_cod,
                      v_num_versao_contrato,
                      v_cod_dep_contrato,
                      v_tip_situacao_contrato,
                      v_dsc_critica_contrato
                     );

         IF SQL%ROWCOUNT = 1 THEN
            stp_pesquisa_situacao_contrato (p_usuario,
                                            vo_num_seq_contrato,
                                            vo_cnt_cre_cod,
                                            vo_cnt_cod,
                                            vo_num_versao_contrato,
                                            vo_cod_dep_contrato,
                                            vo_tip_situacao_contrato,
                                            vo_tip_contrato,
                                            vo_dsc_critica_contrato,
                                            v_num_seq_contrato,
                                            v_cnt_cre_cod
                                           );
            v_dado := 'num_seq_contrato = ' || TO_CHAR (v_num_seq_contrato);
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
            v_dado :=
               v_dado
               || ','
               || 'dsc_critica_contrato = '
               || RTRIM (LTRIM (v_dsc_critica_contrato));
            -- LOG
            ifrseg.pck_seguranca.stp_log (p_usuario,
                                          'VIW_SITUACAO_CONTRATO',
                                          'I',
                                          v_dado
                                         );
            COMMIT;
         ELSE
            ROLLBACK;
         END IF;
      END IF;
   EXCEPTION
      WHEN OTHERS THEN
         raise_application_error (-20100, SQLERRM);
   END;

--------------------------------------------------------------------
-- Altera Situação do Contrato
-- retorna o recordset correspondente
   PROCEDURE stp_altera_situacao_contrato (
      p_usuario                  IN       VARCHAR2,
      vo_num_seq_contrato        OUT      tyt_num_seq_contrato,
      vo_cnt_cre_cod             OUT      tyt_cnt_cre_cod,
      vo_cnt_cod                 OUT      tyt_cnt_cod,
      vo_num_versao_contrato     OUT      tyt_num_versao_contrato,
      vo_cod_dep_contrato        OUT      tyt_cod_dep_contrato,
      vo_tip_situacao_contrato   OUT      tyt_tip_situacao_contrato,
      vo_tip_contrato            OUT      tyt_tip_contrato,
      vo_dsc_critica_contrato    OUT      tyt_dsc_critica_contrato,
      vi_num_seq_contrato        IN       t_num_seq_contrato,
      vi_cnt_cre_cod             IN       t_cnt_cre_cod,
      vi_cnt_cod                 IN       t_cnt_cod,
      vi_num_versao_contrato     IN       t_num_versao_contrato,
      vi_cod_dep_contrato        IN       t_cod_dep_contrato,
      vi_tip_situacao_contrato   IN       t_tip_situacao_contrato,
      vi_dsc_critica_contrato    IN       t_dsc_critica_contrato
   ) AS
      CURSOR c_cursor IS
         SELECT     *
               FROM ifrbde.viw_situacao_contrato
              WHERE num_seq_contrato = vi_num_seq_contrato
                AND cnt_cre_cod = vi_cnt_cre_cod
         FOR UPDATE;

      v_viw_situacao_contrato       ifrbde.viw_situacao_contrato%ROWTYPE;
      v_num_seq_contrato            ifrbde.viw_situacao_contrato.num_seq_contrato%TYPE;
      v_cnt_cre_cod                 ifrbde.viw_situacao_contrato.cnt_cre_cod%TYPE;
      v_cnt_cod                     ifrbde.viw_situacao_contrato.cnt_cod%TYPE;
      v_num_versao_contrato         ifrbde.viw_situacao_contrato.num_versao_contrato%TYPE;
      v_cod_dep_contrato            ifrbde.viw_situacao_contrato.cod_dep_contrato%TYPE;
      v_tip_situacao_contrato       ifrbde.viw_situacao_contrato.tip_situacao_contrato%TYPE;
      v_dsc_critica_contrato        ifrbde.viw_situacao_contrato.dsc_critica_contrato%TYPE;
      v_dado                        VARCHAR2 (4000) := NULL;
   BEGIN
      IF ifrseg.pck_seguranca.stf_permitido (p_usuario,
                                             'VIW_SITUACAO_CONTRATO',
                                             'ALTERA'
                                            ) THEN
         OPEN c_cursor;

         FETCH c_cursor
          INTO v_viw_situacao_contrato;

         IF NOT c_cursor%NOTFOUND THEN
            v_cnt_cod := RTRIM (LTRIM (vi_cnt_cod));
            v_num_versao_contrato := RTRIM (LTRIM (vi_num_versao_contrato));
            v_dsc_critica_contrato := RTRIM (LTRIM (vi_dsc_critica_contrato));
            v_num_seq_contrato := vi_num_seq_contrato;
            v_cnt_cre_cod := vi_cnt_cre_cod;
            v_cod_dep_contrato := vi_cod_dep_contrato;
            v_tip_situacao_contrato := vi_tip_situacao_contrato;

            UPDATE ifrbde.viw_situacao_contrato
               SET
/*
                   cnt_cod = v_cnt_cod,
                   num_versao_contrato = v_num_versao_contrato,
                   cod_dep_contrato = v_cod_dep_contrato,
*/
                   tip_situacao_contrato = v_tip_situacao_contrato,
                   dsc_critica_contrato = v_dsc_critica_contrato
             WHERE CURRENT OF c_cursor;

            IF SQL%ROWCOUNT = 1 THEN
               stp_pesquisa_situacao_contrato (p_usuario,
                                               vo_num_seq_contrato,
                                               vo_cnt_cre_cod,
                                               vo_cnt_cod,
                                               vo_num_versao_contrato,
                                               vo_cod_dep_contrato,
                                               vo_tip_situacao_contrato,
                                               vo_tip_contrato,
                                               vo_dsc_critica_contrato,
                                               vi_num_seq_contrato,
                                               vi_cnt_cre_cod
                                              );
               v_dado := 'num_seq_contrato = ' || TO_CHAR (v_num_seq_contrato);
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
               v_dado :=
                  v_dado
                  || ','
                  || 'dsc_critica_contrato = '
                  || RTRIM (LTRIM (v_dsc_critica_contrato));
               -- LOG
               ifrseg.pck_seguranca.stp_log (p_usuario,
                                             'VIW_SITUACAO_CONTRATO',
                                             'A',
                                             v_dado
                                            );
               COMMIT;
            ELSE
               ROLLBACK;
            END IF;
         END IF;
      END IF;
   EXCEPTION
      WHEN OTHERS THEN
         raise_application_error (-20100, SQLERRM);
   END;

--------------------------------------------------------------------
-- Pesquisa Autorizar SP
-- retorna o recordset correspondente
   PROCEDURE stp_pesquisa_resumo_pag_gestor (
      p_usuario                  IN       VARCHAR2,
      vo_num_seq_pag_contrato_rp OUT      tyt_num_seq_pag_contrato_rp,
      vo_num_seq_resumo_pag      OUT      tyt_num_seq_resumo_pag,
      vo_cnt_cre_cod             OUT      tyt_cnt_cre_cod,
      vo_cnt_cod                 OUT      tyt_cnt_cod,
      vo_num_seq_entidade_pag    OUT      tyt_num_seq_entidade_pag,
      vo_cod_tipo_pag_rp         OUT      tyt_cod_tipo_pag_rp,
      vo_dat_pagamento           OUT      tyt_dat_pagamento,
      vo_dat_vencimento_pag      OUT      tyt_dat_vencimento_pag,
      vo_num_fatura_rp           OUT      tyt_num_fatura_rp,
      vo_dat_moeda_rp            OUT      tyt_dat_moeda_rp,
      vo_val_cotacao_moeda_rp    OUT      tyt_val_cotacao_moeda_rp,
      vo_tip_cotacao_moeda_rp    OUT      tyt_tip_cotacao_moeda_rp,
      vo_val_pagamento_rp        OUT      tyt_val_pagamento_rp,
      vo_val_glosa_rp            OUT      tyt_val_glosa_rp,
      vo_dsc_glosa_rp            OUT      tyt_dsc_glosa_rp,
      vo_val_retencao_rp         OUT      tyt_val_retencao_rp,
      vo_num_seq_entidade_rp     OUT      tyt_num_seq_entidade_rp,
      vo_val_multa_rp            OUT      tyt_val_multa_rp,
      vo_val_imposto_irrf_rp     OUT      tyt_val_imposto_irrf_rp,
      vo_val_imposto_iss_rp      OUT      tyt_val_imposto_iss_rp,
      vo_val_imposto_pasep_rp    OUT      tyt_val_imposto_pasep_rp,
      vo_val_imposto_icms_rp     OUT      tyt_val_imposto_icms_rp,
      vo_val_imposto_inss_rp     OUT      tyt_val_imposto_inss_rp,
      vo_val_impostos_rp         OUT      tyt_val_impostos_rp,
      vo_val_liquido_nota_rp     OUT      tyt_val_liquido_nota_rp,
      vo_dsc_solicitacao_rp      OUT      tyt_dsc_solicitacao_rp,
      vo_tip_situacao_pag        OUT      tyt_tip_situacao_pag,
      vi_num_seq_pag_contrato_rp IN       t_num_seq_pag_contrato_rp,
      vi_num_seq_resumo_pag      IN       t_num_seq_resumo_pag
   ) AS
   BEGIN
      IF ifrseg.pck_seguranca.stf_permitido (p_usuario,
                                             'VIW_RESUMO_PAG_GESTOR',
                                             'PESQUISA'
                                            ) THEN
         SELECT num_seq_pag_contrato_rp,
                num_seq_resumo_pag,
                cnt_cre_cod,
                cnt_cod,
                num_seq_entidade_pag,
                cod_tipo_pag_rp,
                dat_pagamento,
                dat_vencimento_pag,
                num_fatura_rp,
                dat_moeda_rp,
                val_cotacao_moeda_rp,
                tip_cotacao_moeda_rp,
                val_pagamento_rp,
                val_glosa_rp,
                dsc_glosa_rp,
                val_retencao_rp,
                num_seq_entidade_rp,
                val_multa_rp,
                val_imposto_irrf_rp,
                val_imposto_iss_rp,
                val_imposto_pasep_rp,
                val_imposto_icms_rp,
                val_imposto_inss_rp,
                val_impostos_rp,
                val_liquido_nota_rp,
                dsc_solicitacao_rp,
                tip_situacao_pag
           INTO vo_num_seq_pag_contrato_rp (1),
                vo_num_seq_resumo_pag (1),
                vo_cnt_cre_cod (1),
                vo_cnt_cod (1),
                vo_num_seq_entidade_pag (1),
                vo_cod_tipo_pag_rp (1),
                vo_dat_pagamento (1),
                vo_dat_vencimento_pag (1),
                vo_num_fatura_rp (1),
                vo_dat_moeda_rp (1),
                vo_val_cotacao_moeda_rp (1),
                vo_tip_cotacao_moeda_rp (1),
                vo_val_pagamento_rp (1),
                vo_val_glosa_rp (1),
                vo_dsc_glosa_rp (1),
                vo_val_retencao_rp (1),
                vo_num_seq_entidade_rp (1),
                vo_val_multa_rp (1),
                vo_val_imposto_irrf_rp (1),
                vo_val_imposto_iss_rp (1),
                vo_val_imposto_pasep_rp (1),
                vo_val_imposto_icms_rp (1),
                vo_val_imposto_inss_rp (1),
                vo_val_impostos_rp (1),
                vo_val_liquido_nota_rp (1),
                vo_dsc_solicitacao_rp (1),
                vo_tip_situacao_pag (1)
           FROM ifrbde.viw_resumo_pag_gestor
          WHERE num_seq_pag_contrato_rp = vi_num_seq_pag_contrato_rp
            AND num_seq_resumo_pag = vi_num_seq_resumo_pag;
      END IF;
   EXCEPTION
      WHEN OTHERS THEN
         raise_application_error (-20100, SQLERRM);
   END;

   -- Exclui Autorizar SP
   -- retorna o OK ou não
   PROCEDURE stp_exclui_resumo_pag_gestor (
      p_usuario                  IN       VARCHAR2,
      vo_ok                      OUT      tyt_ok,
      vi_num_seq_pag_contrato_rp IN       t_num_seq_pag_contrato_rp,
      vi_num_seq_resumo_pag      IN       t_num_seq_resumo_pag
   ) AS
      CURSOR c_cursor IS
         SELECT     *
               FROM ifrbde.viw_resumo_pag_gestor
              WHERE num_seq_pag_contrato_rp = vi_num_seq_pag_contrato_rp
                AND num_seq_resumo_pag = vi_num_seq_resumo_pag
         FOR UPDATE;

      v_viw_resumo_pag_gestor       ifrbde.viw_resumo_pag_gestor%ROWTYPE;
      v_dado                        VARCHAR2 (4000) := NULL;
   BEGIN
      vo_ok (1) := 0;

      IF ifrseg.pck_seguranca.stf_permitido (p_usuario,
                                             'VIW_RESUMO_PAG_GESTOR',
                                             'EXCLUI'
                                            ) THEN
         OPEN c_cursor;

         FETCH c_cursor
          INTO v_viw_resumo_pag_gestor;

         IF NOT c_cursor%NOTFOUND THEN
            v_dado :=
               'num_seq_pag_contrato_rp = '
               || TO_CHAR (v_viw_resumo_pag_gestor.num_seq_pag_contrato_rp);
            v_dado :=
               v_dado
               || ','
               || 'num_seq_resumo_pag = '
               || TO_CHAR (v_viw_resumo_pag_gestor.num_seq_resumo_pag);
            v_dado :=
               v_dado
               || ','
               || 'cnt_cre_cod = '
               || TO_CHAR (v_viw_resumo_pag_gestor.cnt_cre_cod);
            v_dado :=
               v_dado
               || ','
               || 'cnt_cod = '
               || RTRIM (LTRIM (UPPER (v_viw_resumo_pag_gestor.cnt_cod)));
            v_dado :=
               v_dado
               || ','
               || 'num_seq_entidade_pag = '
               || TO_CHAR (v_viw_resumo_pag_gestor.num_seq_entidade_pag);
            v_dado :=
               v_dado
               || ','
               || 'cod_tipo_pag_rp = '
               || RTRIM (LTRIM (UPPER (v_viw_resumo_pag_gestor.cod_tipo_pag_rp)
                               )
                        );
            v_dado :=
               v_dado
               || ','
               || 'dat_pagamento = '
               || TO_DATE (v_viw_resumo_pag_gestor.dat_pagamento,
                           'DD/MM/YYYY');
            v_dado :=
               v_dado
               || ','
               || 'dat_vencimento_pag = '
               || TO_DATE (v_viw_resumo_pag_gestor.dat_vencimento_pag,
                           'DD/MM/YYYY'
                          );
            v_dado :=
               v_dado
               || ','
               || 'num_fatura_rp = '
               || RTRIM (LTRIM (UPPER (v_viw_resumo_pag_gestor.num_fatura_rp)));
            v_dado :=
               v_dado
               || ','
               || 'dat_moeda_rp = '
               || TO_DATE (v_viw_resumo_pag_gestor.dat_moeda_rp, 'DD/MM/YYYY');
            v_dado :=
               v_dado
               || ','
               || 'val_cotacao_moeda_rp = '
               || TO_CHAR (v_viw_resumo_pag_gestor.val_cotacao_moeda_rp);
            v_dado :=
               v_dado
               || ','
               || 'tip_cotacao_moeda_rp = '
               || RTRIM
                    (LTRIM
                          (UPPER (v_viw_resumo_pag_gestor.tip_cotacao_moeda_rp)
                          )
                    );
            v_dado :=
               v_dado
               || ','
               || 'val_pagamento_rp = '
               || TO_CHAR (v_viw_resumo_pag_gestor.val_pagamento_rp);
            v_dado :=
               v_dado
               || ','
               || 'val_glosa_rp = '
               || TO_CHAR (v_viw_resumo_pag_gestor.val_glosa_rp);
            v_dado :=
               v_dado
               || ','
               || 'dsc_glosa_rp = '
               || RTRIM (LTRIM (UPPER (v_viw_resumo_pag_gestor.dsc_glosa_rp)));
            v_dado :=
               v_dado
               || ','
               || 'val_retencao_rp = '
               || TO_CHAR (v_viw_resumo_pag_gestor.val_retencao_rp);
            v_dado :=
               v_dado
               || ','
               || 'num_seq_entidade_rp = '
               || TO_CHAR (v_viw_resumo_pag_gestor.num_seq_entidade_rp);
            v_dado :=
               v_dado
               || ','
               || 'val_multa_rp = '
               || TO_CHAR (v_viw_resumo_pag_gestor.val_multa_rp);
            v_dado :=
               v_dado
               || ','
               || 'val_imposto_irrf_rp = '
               || TO_CHAR (v_viw_resumo_pag_gestor.val_imposto_irrf_rp);
            v_dado :=
               v_dado
               || ','
               || 'val_imposto_iss_rp = '
               || TO_CHAR (v_viw_resumo_pag_gestor.val_imposto_iss_rp);
            v_dado :=
               v_dado
               || ','
               || 'val_imposto_pasep_rp = '
               || TO_CHAR (v_viw_resumo_pag_gestor.val_imposto_pasep_rp);
            v_dado :=
               v_dado
               || ','
               || 'val_imposto_icms_rp = '
               || TO_CHAR (v_viw_resumo_pag_gestor.val_imposto_icms_rp);
            v_dado :=
               v_dado
               || ','
               || 'val_imposto_inss_rp = '
               || TO_CHAR (v_viw_resumo_pag_gestor.val_imposto_inss_rp);
            v_dado :=
               v_dado
               || ','
               || 'val_impostos_rp = '
               || TO_CHAR (v_viw_resumo_pag_gestor.val_impostos_rp);
            v_dado :=
               v_dado
               || ','
               || 'val_liquido_nota_rp = '
               || TO_CHAR (v_viw_resumo_pag_gestor.val_liquido_nota_rp);
            v_dado :=
               v_dado
               || ','
               || 'dsc_solicitacao_rp = '
               || RTRIM
                     (LTRIM (UPPER (v_viw_resumo_pag_gestor.dsc_solicitacao_rp)
                            )
                     );
            v_dado :=
               v_dado
               || ','
               || 'tip_situacao_pag = '
               || RTRIM
                       (LTRIM (UPPER (v_viw_resumo_pag_gestor.tip_situacao_pag)
                              )
                       );

            IF c_cursor%ROWCOUNT = 1 THEN
               vo_ok (1) := 1;
               -- LOG
               ifrseg.pck_seguranca.stp_log (p_usuario,
                                             'VIW_RESUMO_PAG_GESTOR',
                                             'E',
                                             v_dado
                                            );

               DELETE FROM ifrbde.viw_resumo_pag_gestor
                     WHERE CURRENT OF c_cursor;

               IF c_cursor%ROWCOUNT = 1 THEN
                  vo_ok (1) := 1;
                  COMMIT;
               ELSIF c_cursor%ROWCOUNT > 1 THEN
                  ROLLBACK;
               END IF;
            END IF;
         END IF;
      END IF;
   EXCEPTION
      WHEN OTHERS THEN
         raise_application_error (-20100, SQLERRM);
   END;

--------------------------------------------------------------------
-- Inclui Autorizar SP
-- retorna o recordset correspondente
   PROCEDURE stp_inclui_resumo_pag_gestor (
      p_usuario                  IN       VARCHAR2,
      vo_num_seq_pag_contrato_rp OUT      tyt_num_seq_pag_contrato_rp,
      vo_num_seq_resumo_pag      OUT      tyt_num_seq_resumo_pag,
      vo_cnt_cre_cod             OUT      tyt_cnt_cre_cod,
      vo_cnt_cod                 OUT      tyt_cnt_cod,
      vo_num_seq_entidade_pag    OUT      tyt_num_seq_entidade_pag,
      vo_cod_tipo_pag_rp         OUT      tyt_cod_tipo_pag_rp,
      vo_dat_pagamento           OUT      tyt_dat_pagamento,
      vo_dat_vencimento_pag      OUT      tyt_dat_vencimento_pag,
      vo_num_fatura_rp           OUT      tyt_num_fatura_rp,
      vo_dat_moeda_rp            OUT      tyt_dat_moeda_rp,
      vo_val_cotacao_moeda_rp    OUT      tyt_val_cotacao_moeda_rp,
      vo_tip_cotacao_moeda_rp    OUT      tyt_tip_cotacao_moeda_rp,
      vo_val_pagamento_rp        OUT      tyt_val_pagamento_rp,
      vo_val_glosa_rp            OUT      tyt_val_glosa_rp,
      vo_dsc_glosa_rp            OUT      tyt_dsc_glosa_rp,
      vo_val_retencao_rp         OUT      tyt_val_retencao_rp,
      vo_num_seq_entidade_rp     OUT      tyt_num_seq_entidade_rp,
      vo_val_multa_rp            OUT      tyt_val_multa_rp,
      vo_val_imposto_irrf_rp     OUT      tyt_val_imposto_irrf_rp,
      vo_val_imposto_iss_rp      OUT      tyt_val_imposto_iss_rp,
      vo_val_imposto_pasep_rp    OUT      tyt_val_imposto_pasep_rp,
      vo_val_imposto_icms_rp     OUT      tyt_val_imposto_icms_rp,
      vo_val_imposto_inss_rp     OUT      tyt_val_imposto_inss_rp,
      vo_val_impostos_rp         OUT      tyt_val_impostos_rp,
      vo_val_liquido_nota_rp     OUT      tyt_val_liquido_nota_rp,
      vo_dsc_solicitacao_rp      OUT      tyt_dsc_solicitacao_rp,
      vo_tip_situacao_pag        OUT      tyt_tip_situacao_pag,
      vi_num_seq_pag_contrato_rp IN       t_num_seq_pag_contrato_rp,
      vi_num_seq_resumo_pag      IN       t_num_seq_resumo_pag,
      vi_cnt_cre_cod             IN       t_cnt_cre_cod,
      vi_cnt_cod                 IN       t_cnt_cod,
      vi_cod_tipo_pag_rp         IN       t_cod_tipo_pag_rp,
      vi_num_fatura_rp           IN       t_num_fatura_rp,
      vi_tip_cotacao_moeda_rp    IN       t_tip_cotacao_moeda_rp,
      vi_num_seq_entidade_rp     IN       t_num_seq_entidade_rp,
      vi_tip_situacao_pag        IN       t_tip_situacao_pag
   ) AS
      v_num_seq_pag_contrato_rp     viw_resumo_pag_gestor.num_seq_pag_contrato_rp%TYPE;
      v_num_seq_resumo_pag          viw_resumo_pag_gestor.num_seq_resumo_pag%TYPE;
      v_cnt_cre_cod                 viw_resumo_pag_gestor.cnt_cre_cod%TYPE;
      v_cnt_cod                     viw_resumo_pag_gestor.cnt_cod%TYPE;
      v_cod_tipo_pag_rp             viw_resumo_pag_gestor.cod_tipo_pag_rp%TYPE;
      v_num_fatura_rp               viw_resumo_pag_gestor.num_fatura_rp%TYPE;
      v_tip_cotacao_moeda_rp        viw_resumo_pag_gestor.tip_cotacao_moeda_rp%TYPE;
      v_num_seq_entidade_rp         viw_resumo_pag_gestor.num_seq_entidade_rp%TYPE;
      v_tip_situacao_pag            viw_resumo_pag_gestor.tip_situacao_pag%TYPE;
      v_dado                        VARCHAR2 (4000) := NULL;
   BEGIN
      IF ifrseg.pck_seguranca.stf_permitido (p_usuario,
                                             'VIW_RESUMO_PAG_GESTOR',
                                             'INCLUI'
                                            ) THEN
         v_cnt_cod := RTRIM (LTRIM (vi_cnt_cod));
         v_cod_tipo_pag_rp := RTRIM (LTRIM (vi_cod_tipo_pag_rp));
         v_num_fatura_rp := RTRIM (LTRIM (vi_num_fatura_rp));
         v_tip_cotacao_moeda_rp := RTRIM (LTRIM (vi_tip_cotacao_moeda_rp));
         v_tip_situacao_pag := RTRIM (LTRIM (vi_tip_situacao_pag));
         v_num_seq_pag_contrato_rp := vi_num_seq_pag_contrato_rp;
         v_num_seq_resumo_pag := vi_num_seq_resumo_pag;
         v_cnt_cre_cod := vi_cnt_cre_cod;
         v_num_seq_entidade_rp := vi_num_seq_entidade_rp;

         INSERT INTO ifrbde.viw_resumo_pag_gestor
                     (num_seq_pag_contrato_rp,
                      num_seq_resumo_pag,
                      cnt_cre_cod,
                      cnt_cod,
                      cod_tipo_pag_rp,
                      num_fatura_rp,
                      tip_cotacao_moeda_rp,
                      num_seq_entidade_rp,
                      tip_situacao_pag
                     )
              VALUES (v_num_seq_pag_contrato_rp,
                      v_num_seq_resumo_pag,
                      v_cnt_cre_cod,
                      v_cnt_cod,
                      v_cod_tipo_pag_rp,
                      v_num_fatura_rp,
                      v_tip_cotacao_moeda_rp,
                      v_num_seq_entidade_rp,
                      v_tip_situacao_pag
                     );

         IF SQL%ROWCOUNT = 1 THEN
            stp_pesquisa_resumo_pag_gestor (p_usuario,
                                            vo_num_seq_pag_contrato_rp,
                                            vo_num_seq_resumo_pag,
                                            vo_cnt_cre_cod,
                                            vo_cnt_cod,
                                            vo_num_seq_entidade_pag,
                                            vo_cod_tipo_pag_rp,
                                            vo_dat_pagamento,
                                            vo_dat_vencimento_pag,
                                            vo_num_fatura_rp,
                                            vo_dat_moeda_rp,
                                            vo_val_cotacao_moeda_rp,
                                            vo_tip_cotacao_moeda_rp,
                                            vo_val_pagamento_rp,
                                            vo_val_glosa_rp,
                                            vo_dsc_glosa_rp,
                                            vo_val_retencao_rp,
                                            vo_num_seq_entidade_rp,
                                            vo_val_multa_rp,
                                            vo_val_imposto_irrf_rp,
                                            vo_val_imposto_iss_rp,
                                            vo_val_imposto_pasep_rp,
                                            vo_val_imposto_icms_rp,
                                            vo_val_imposto_inss_rp,
                                            vo_val_impostos_rp,
                                            vo_val_liquido_nota_rp,
                                            vo_dsc_solicitacao_rp,
                                            vo_tip_situacao_pag,
                                            v_num_seq_pag_contrato_rp,
                                            v_num_seq_resumo_pag
                                           );
            v_dado :=
               'num_seq_pag_contrato_rp = '
               || TO_CHAR (v_num_seq_pag_contrato_rp);
            v_dado :=
               v_dado
               || ','
               || 'num_seq_resumo_pag = '
               || TO_CHAR (v_num_seq_resumo_pag);
            v_dado :=
                  v_dado || ',' || 'cnt_cre_cod = ' || TO_CHAR (v_cnt_cre_cod);
            v_dado :=
                    v_dado || ',' || 'cnt_cod = ' || RTRIM (LTRIM (v_cnt_cod));
            v_dado :=
               v_dado
               || ','
               || 'cod_tipo_pag_rp = '
               || RTRIM (LTRIM (v_cod_tipo_pag_rp));
            v_dado :=
               v_dado
               || ','
               || 'num_fatura_rp = '
               || RTRIM (LTRIM (v_num_fatura_rp));
            v_dado :=
               v_dado
               || ','
               || 'tip_cotacao_moeda_rp = '
               || RTRIM (LTRIM (v_tip_cotacao_moeda_rp));
            v_dado :=
               v_dado
               || ','
               || 'num_seq_entidade_rp = '
               || TO_CHAR (v_num_seq_entidade_rp);
            v_dado :=
               v_dado
               || ','
               || 'tip_situacao_pag = '
               || RTRIM (LTRIM (v_tip_situacao_pag));
            -- LOG
            ifrseg.pck_seguranca.stp_log (p_usuario,
                                          'VIW_RESUMO_PAG_GESTOR',
                                          'I',
                                          v_dado
                                         );
            COMMIT;
         ELSE
            ROLLBACK;
         END IF;
      END IF;
   EXCEPTION
      WHEN OTHERS THEN
         raise_application_error (-20100, SQLERRM);
   END;

--------------------------------------------------------------------
-- Altera Autorizar SP
-- retorna o recordset correspondente
   PROCEDURE stp_altera_resumo_pag_gestor (
      p_usuario                  IN       VARCHAR2,
      vo_num_seq_pag_contrato_rp OUT      tyt_num_seq_pag_contrato_rp,
      vo_num_seq_resumo_pag      OUT      tyt_num_seq_resumo_pag,
      vo_cnt_cre_cod             OUT      tyt_cnt_cre_cod,
      vo_cnt_cod                 OUT      tyt_cnt_cod,
      vo_num_seq_entidade_pag    OUT      tyt_num_seq_entidade_pag,
      vo_cod_tipo_pag_rp         OUT      tyt_cod_tipo_pag_rp,
      vo_dat_pagamento           OUT      tyt_dat_pagamento,
      vo_dat_vencimento_pag      OUT      tyt_dat_vencimento_pag,
      vo_num_fatura_rp           OUT      tyt_num_fatura_rp,
      vo_dat_moeda_rp            OUT      tyt_dat_moeda_rp,
      vo_val_cotacao_moeda_rp    OUT      tyt_val_cotacao_moeda_rp,
      vo_tip_cotacao_moeda_rp    OUT      tyt_tip_cotacao_moeda_rp,
      vo_val_pagamento_rp        OUT      tyt_val_pagamento_rp,
      vo_val_glosa_rp            OUT      tyt_val_glosa_rp,
      vo_dsc_glosa_rp            OUT      tyt_dsc_glosa_rp,
      vo_val_retencao_rp         OUT      tyt_val_retencao_rp,
      vo_num_seq_entidade_rp     OUT      tyt_num_seq_entidade_rp,
      vo_val_multa_rp            OUT      tyt_val_multa_rp,
      vo_val_imposto_irrf_rp     OUT      tyt_val_imposto_irrf_rp,
      vo_val_imposto_iss_rp      OUT      tyt_val_imposto_iss_rp,
      vo_val_imposto_pasep_rp    OUT      tyt_val_imposto_pasep_rp,
      vo_val_imposto_icms_rp     OUT      tyt_val_imposto_icms_rp,
      vo_val_imposto_inss_rp     OUT      tyt_val_imposto_inss_rp,
      vo_val_impostos_rp         OUT      tyt_val_impostos_rp,
      vo_val_liquido_nota_rp     OUT      tyt_val_liquido_nota_rp,
      vo_dsc_solicitacao_rp      OUT      tyt_dsc_solicitacao_rp,
      vo_tip_situacao_pag        OUT      tyt_tip_situacao_pag,
      vi_num_seq_pag_contrato_rp IN       t_num_seq_pag_contrato_rp,
      vi_num_seq_resumo_pag      IN       t_num_seq_resumo_pag,
      vi_cnt_cre_cod             IN       t_cnt_cre_cod,
      vi_cnt_cod                 IN       t_cnt_cod,
      vi_cod_tipo_pag_rp         IN       t_cod_tipo_pag_rp,
      vi_num_fatura_rp           IN       t_num_fatura_rp,
      vi_tip_cotacao_moeda_rp    IN       t_tip_cotacao_moeda_rp,
      vi_num_seq_entidade_rp     IN       t_num_seq_entidade_rp,
      vi_tip_situacao_pag        IN       t_tip_situacao_pag
   ) AS
      CURSOR c_cursor IS
         SELECT     *
               FROM ifrbde.viw_resumo_pag_gestor
              WHERE num_seq_pag_contrato_rp = vi_num_seq_pag_contrato_rp
                AND num_seq_resumo_pag = vi_num_seq_resumo_pag
         FOR UPDATE;

      v_viw_resumo_pag_gestor       ifrbde.viw_resumo_pag_gestor%ROWTYPE;
      v_num_seq_pag_contrato_rp     ifrbde.viw_resumo_pag_gestor.num_seq_pag_contrato_rp%TYPE;
      v_num_seq_resumo_pag          ifrbde.viw_resumo_pag_gestor.num_seq_resumo_pag%TYPE;
      v_cnt_cre_cod                 ifrbde.viw_resumo_pag_gestor.cnt_cre_cod%TYPE;
      v_cnt_cod                     ifrbde.viw_resumo_pag_gestor.cnt_cod%TYPE;
      v_cod_tipo_pag_rp             ifrbde.viw_resumo_pag_gestor.cod_tipo_pag_rp%TYPE;
      v_num_fatura_rp               ifrbde.viw_resumo_pag_gestor.num_fatura_rp%TYPE;
      v_tip_cotacao_moeda_rp        ifrbde.viw_resumo_pag_gestor.tip_cotacao_moeda_rp%TYPE;
      v_num_seq_entidade_rp         ifrbde.viw_resumo_pag_gestor.num_seq_entidade_rp%TYPE;
      v_tip_situacao_pag            ifrbde.viw_resumo_pag_gestor.tip_situacao_pag%TYPE;
      v_dado                        VARCHAR2 (4000) := NULL;
   BEGIN
      IF ifrseg.pck_seguranca.stf_permitido (p_usuario,
                                             'VIW_RESUMO_PAG_GESTOR',
                                             'ALTERA'
                                            ) THEN
         OPEN c_cursor;

         FETCH c_cursor
          INTO v_viw_resumo_pag_gestor;

         IF NOT c_cursor%NOTFOUND THEN
            v_cnt_cod := RTRIM (LTRIM (vi_cnt_cod));
            v_cod_tipo_pag_rp := RTRIM (LTRIM (vi_cod_tipo_pag_rp));
            v_num_fatura_rp := RTRIM (LTRIM (vi_num_fatura_rp));
            v_tip_cotacao_moeda_rp := RTRIM (LTRIM (vi_tip_cotacao_moeda_rp));
            v_tip_situacao_pag := RTRIM (LTRIM (vi_tip_situacao_pag));
            v_num_seq_pag_contrato_rp := vi_num_seq_pag_contrato_rp;
            v_num_seq_resumo_pag := vi_num_seq_resumo_pag;
            v_cnt_cre_cod := vi_cnt_cre_cod;
            v_num_seq_entidade_rp := vi_num_seq_entidade_rp;

            UPDATE ifrbde.viw_resumo_pag_gestor
               SET tip_situacao_pag = v_tip_situacao_pag
             WHERE CURRENT OF c_cursor;

            IF SQL%ROWCOUNT = 1 THEN
               stp_pesquisa_resumo_pag_gestor (p_usuario,
                                               vo_num_seq_pag_contrato_rp,
                                               vo_num_seq_resumo_pag,
                                               vo_cnt_cre_cod,
                                               vo_cnt_cod,
                                               vo_num_seq_entidade_pag,
                                               vo_cod_tipo_pag_rp,
                                               vo_dat_pagamento,
                                               vo_dat_vencimento_pag,
                                               vo_num_fatura_rp,
                                               vo_dat_moeda_rp,
                                               vo_val_cotacao_moeda_rp,
                                               vo_tip_cotacao_moeda_rp,
                                               vo_val_pagamento_rp,
                                               vo_val_glosa_rp,
                                               vo_dsc_glosa_rp,
                                               vo_val_retencao_rp,
                                               vo_num_seq_entidade_rp,
                                               vo_val_multa_rp,
                                               vo_val_imposto_irrf_rp,
                                               vo_val_imposto_iss_rp,
                                               vo_val_imposto_pasep_rp,
                                               vo_val_imposto_icms_rp,
                                               vo_val_imposto_inss_rp,
                                               vo_val_impostos_rp,
                                               vo_val_liquido_nota_rp,
                                               vo_dsc_solicitacao_rp,
                                               vo_tip_situacao_pag,
                                               vi_num_seq_pag_contrato_rp,
                                               vi_num_seq_resumo_pag
                                              );
               v_dado :=
                  'num_seq_pag_contrato_rp = '
                  || TO_CHAR (v_num_seq_pag_contrato_rp);
               v_dado :=
                  v_dado
                  || ','
                  || 'num_seq_resumo_pag = '
                  || TO_CHAR (v_num_seq_resumo_pag);
               v_dado :=
                  v_dado || ',' || 'cnt_cre_cod = ' || TO_CHAR (v_cnt_cre_cod);
               v_dado :=
                    v_dado || ',' || 'cnt_cod = ' || RTRIM (LTRIM (v_cnt_cod));
               v_dado :=
                  v_dado
                  || ','
                  || 'cod_tipo_pag_rp = '
                  || RTRIM (LTRIM (v_cod_tipo_pag_rp));
               v_dado :=
                  v_dado
                  || ','
                  || 'num_fatura_rp = '
                  || RTRIM (LTRIM (v_num_fatura_rp));
               v_dado :=
                  v_dado
                  || ','
                  || 'tip_cotacao_moeda_rp = '
                  || RTRIM (LTRIM (v_tip_cotacao_moeda_rp));
               v_dado :=
                  v_dado
                  || ','
                  || 'num_seq_entidade_rp = '
                  || TO_CHAR (v_num_seq_entidade_rp);
               v_dado :=
                  v_dado
                  || ','
                  || 'tip_situacao_pag = '
                  || RTRIM (LTRIM (v_tip_situacao_pag));
               -- LOG
               ifrseg.pck_seguranca.stp_log (p_usuario,
                                             'VIW_RESUMO_PAG_GESTOR',
                                             'A',
                                             v_dado
                                            );
               COMMIT;
            ELSE
               ROLLBACK;
            END IF;
         END IF;
      END IF;
   EXCEPTION
      WHEN OTHERS THEN
         raise_application_error (-20100, SQLERRM);
   END;

--------------------------------------------------------------------
-- Pesquisa Muda Situação SP
-- retorna o recordset correspondente
   PROCEDURE stp_pesquisa_resumo_pagamento (
      p_usuario                  IN       VARCHAR2,
      vo_num_seq_pag_contrato_rp OUT      tyt_num_seq_pag_contrato_rp,
      vo_num_seq_resumo_pag      OUT      tyt_num_seq_resumo_pag,
      vo_cnt_cre_cod             OUT      tyt_cnt_cre_cod,
      vo_cnt_cod                 OUT      tyt_cnt_cod,
      vo_num_versao_contrato     OUT      tyt_num_versao_contrato,
      vo_num_seq_entidade_pag    OUT      tyt_num_seq_entidade_pag,
      vo_cod_tipo_pag_rp         OUT      tyt_cod_tipo_pag_rp,
      vo_dat_pagamento_res       OUT      tyt_dat_pagamento_res,
      vo_dat_vencimento_pag_res  OUT      tyt_dat_vencimento_pag_res,
      vo_num_fatura_rp           OUT      tyt_num_fatura_rp,
      vo_val_pagamento_rp        OUT      tyt_val_pagamento_rp,
      vo_tip_situacao_pag        OUT      tyt_tip_situacao_pag,
      vo_num_versao_contrato_pag OUT      tyt_num_versao_contrato_pag,
      vi_num_seq_pag_contrato_rp IN       t_num_seq_pag_contrato_rp,
      vi_num_seq_resumo_pag      IN       t_num_seq_resumo_pag
   ) AS
   BEGIN
      IF ifrseg.pck_seguranca.stf_permitido (p_usuario,
                                             'VIW_RESUMO_PAGAMENTO',
                                             'PESQUISA'
                                            ) THEN
         SELECT num_seq_pag_contrato_rp,
                num_seq_resumo_pag,
                cnt_cre_cod,
                cnt_cod,
                num_versao_contrato,
                num_seq_entidade_pag,
                cod_tipo_pag_rp,
                dat_pagamento_res,
                dat_vencimento_pag_res,
                num_fatura_rp,
                val_pagamento_rp,
                tip_situacao_pag,
                num_versao_contrato_pag
           INTO vo_num_seq_pag_contrato_rp (1),
                vo_num_seq_resumo_pag (1),
                vo_cnt_cre_cod (1),
                vo_cnt_cod (1),
                vo_num_versao_contrato (1),
                vo_num_seq_entidade_pag (1),
                vo_cod_tipo_pag_rp (1),
                vo_dat_pagamento_res (1),
                vo_dat_vencimento_pag_res (1),
                vo_num_fatura_rp (1),
                vo_val_pagamento_rp (1),
                vo_tip_situacao_pag (1),
                vo_num_versao_contrato_pag (1)
           FROM ifrbde.viw_resumo_pagamento
          WHERE num_seq_pag_contrato_rp = vi_num_seq_pag_contrato_rp
            AND num_seq_resumo_pag = vi_num_seq_resumo_pag;
      END IF;
   EXCEPTION
      WHEN OTHERS THEN
         raise_application_error (-20100, SQLERRM);
   END;

   -- Exclui Muda Situação SP
   -- retorna o OK ou não
   PROCEDURE stp_exclui_resumo_pagamento (
      p_usuario                  IN       VARCHAR2,
      vo_ok                      OUT      tyt_ok,
      vi_num_seq_pag_contrato_rp IN       t_num_seq_pag_contrato_rp,
      vi_num_seq_resumo_pag      IN       t_num_seq_resumo_pag
   ) AS
      CURSOR c_cursor IS
         SELECT     *
               FROM ifrbde.viw_resumo_pagamento
              WHERE num_seq_pag_contrato_rp = vi_num_seq_pag_contrato_rp
                AND num_seq_resumo_pag = vi_num_seq_resumo_pag
         FOR UPDATE;

      v_viw_resumo_pagamento        ifrbde.viw_resumo_pagamento%ROWTYPE;
      v_dado                        VARCHAR2 (4000) := NULL;
   BEGIN
      vo_ok (1) := 0;

      IF ifrseg.pck_seguranca.stf_permitido (p_usuario,
                                             'VIW_RESUMO_PAGAMENTO',
                                             'EXCLUI'
                                            ) THEN
         OPEN c_cursor;

         FETCH c_cursor
          INTO v_viw_resumo_pagamento;

         IF NOT c_cursor%NOTFOUND THEN
            v_dado :=
               'num_seq_pag_contrato_rp = '
               || TO_CHAR (v_viw_resumo_pagamento.num_seq_pag_contrato_rp);
            v_dado :=
               v_dado
               || ','
               || 'num_seq_resumo_pag = '
               || TO_CHAR (v_viw_resumo_pagamento.num_seq_resumo_pag);
            v_dado :=
               v_dado
               || ','
               || 'cnt_cre_cod = '
               || TO_CHAR (v_viw_resumo_pagamento.cnt_cre_cod);
            v_dado :=
               v_dado
               || ','
               || 'cnt_cod = '
               || RTRIM (LTRIM (UPPER (v_viw_resumo_pagamento.cnt_cod)));
            v_dado :=
               v_dado
               || ','
               || 'num_versao_contrato = '
               || RTRIM
                     (LTRIM (UPPER (v_viw_resumo_pagamento.num_versao_contrato)
                            )
                     );
            v_dado :=
               v_dado
               || ','
               || 'num_seq_entidade_pag = '
               || TO_CHAR (v_viw_resumo_pagamento.num_seq_entidade_pag);
            v_dado :=
               v_dado
               || ','
               || 'cod_tipo_pag_rp = '
               || RTRIM (LTRIM (UPPER (v_viw_resumo_pagamento.cod_tipo_pag_rp))
                        );
            v_dado :=
               v_dado
               || ','
               || 'dat_pagamento_res = '
               || TO_DATE (v_viw_resumo_pagamento.dat_pagamento_res,
                           'DD/MM/YYYY'
                          );
            v_dado :=
               v_dado
               || ','
               || 'dat_vencimento_pag_res = '
               || TO_DATE (v_viw_resumo_pagamento.dat_vencimento_pag_res,
                           'DD/MM/YYYY'
                          );
            v_dado :=
               v_dado
               || ','
               || 'num_fatura_rp = '
               || RTRIM (LTRIM (UPPER (v_viw_resumo_pagamento.num_fatura_rp)));
            v_dado :=
               v_dado
               || ','
               || 'val_pagamento_rp = '
               || TO_CHAR (v_viw_resumo_pagamento.val_pagamento_rp);
            v_dado :=
               v_dado
               || ','
               || 'tip_situacao_pag = '
               || TO_CHAR (v_viw_resumo_pagamento.tip_situacao_pag);
            v_dado :=
               v_dado
               || ','
               || 'num_versao_contrato_pag = '
               || RTRIM
                    (LTRIM
                        (UPPER (v_viw_resumo_pagamento.num_versao_contrato_pag)
                        )
                    );

            IF c_cursor%ROWCOUNT = 1 THEN
               vo_ok (1) := 1;
               -- LOG
               ifrseg.pck_seguranca.stp_log (p_usuario,
                                             'VIW_RESUMO_PAGAMENTO',
                                             'E',
                                             v_dado
                                            );

               DELETE FROM ifrbde.viw_resumo_pagamento
                     WHERE CURRENT OF c_cursor;

               IF c_cursor%ROWCOUNT = 1 THEN
                  vo_ok (1) := 1;
                  COMMIT;
               ELSIF c_cursor%ROWCOUNT > 1 THEN
                  ROLLBACK;
               END IF;
            END IF;
         END IF;
      END IF;
   EXCEPTION
      WHEN OTHERS THEN
         raise_application_error (-20100, SQLERRM);
   END;

--------------------------------------------------------------------
-- Inclui Muda Situação SP
-- retorna o recordset correspondente
   PROCEDURE stp_inclui_resumo_pagamento (
      p_usuario                  IN       VARCHAR2,
      vo_num_seq_pag_contrato_rp OUT      tyt_num_seq_pag_contrato_rp,
      vo_num_seq_resumo_pag      OUT      tyt_num_seq_resumo_pag,
      vo_cnt_cre_cod             OUT      tyt_cnt_cre_cod,
      vo_cnt_cod                 OUT      tyt_cnt_cod,
      vo_num_versao_contrato     OUT      tyt_num_versao_contrato,
      vo_num_seq_entidade_pag    OUT      tyt_num_seq_entidade_pag,
      vo_cod_tipo_pag_rp         OUT      tyt_cod_tipo_pag_rp,
      vo_dat_pagamento_res       OUT      tyt_dat_pagamento_res,
      vo_dat_vencimento_pag_res  OUT      tyt_dat_vencimento_pag_res,
      vo_num_fatura_rp           OUT      tyt_num_fatura_rp,
      vo_val_pagamento_rp        OUT      tyt_val_pagamento_rp,
      vo_tip_situacao_pag        OUT      tyt_tip_situacao_pag,
      vo_num_versao_contrato_pag OUT      tyt_num_versao_contrato_pag,
      vi_num_seq_pag_contrato_rp IN       t_num_seq_pag_contrato_rp,
      vi_num_seq_resumo_pag      IN       t_num_seq_resumo_pag,
      vi_tip_situacao_pag        IN       t_tip_situacao_pag,
      vi_num_versao_contrato_pag IN       t_num_versao_contrato_pag
   ) AS
      v_num_seq_pag_contrato_rp     viw_resumo_pagamento.num_seq_pag_contrato_rp%TYPE;
      v_num_seq_resumo_pag          viw_resumo_pagamento.num_seq_resumo_pag%TYPE;
      v_tip_situacao_pag            viw_resumo_pagamento.tip_situacao_pag%TYPE;
      v_num_versao_contrato_pag     viw_resumo_pagamento.num_versao_contrato_pag%TYPE;
      v_dado                        VARCHAR2 (4000) := NULL;
   BEGIN
      IF ifrseg.pck_seguranca.stf_permitido (p_usuario,
                                             'VIW_RESUMO_PAGAMENTO',
                                             'INCLUI'
                                            ) THEN
         v_num_versao_contrato_pag :=
                                   RTRIM (LTRIM (vi_num_versao_contrato_pag));
         v_num_seq_pag_contrato_rp := vi_num_seq_pag_contrato_rp;
         v_num_seq_resumo_pag := vi_num_seq_resumo_pag;
         v_tip_situacao_pag := vi_tip_situacao_pag;

         INSERT INTO ifrbde.viw_resumo_pagamento
                     (num_seq_pag_contrato_rp,
                      num_seq_resumo_pag,
                      tip_situacao_pag,
                      num_versao_contrato_pag
                     )
              VALUES (v_num_seq_pag_contrato_rp,
                      v_num_seq_resumo_pag,
                      v_tip_situacao_pag,
                      v_num_versao_contrato_pag
                     );

         IF SQL%ROWCOUNT = 1 THEN
            stp_pesquisa_resumo_pagamento (p_usuario,
                                           vo_num_seq_pag_contrato_rp,
                                           vo_num_seq_resumo_pag,
                                           vo_cnt_cre_cod,
                                           vo_cnt_cod,
                                           vo_num_versao_contrato,
                                           vo_num_seq_entidade_pag,
                                           vo_cod_tipo_pag_rp,
                                           vo_dat_pagamento_res,
                                           vo_dat_vencimento_pag_res,
                                           vo_num_fatura_rp,
                                           vo_val_pagamento_rp,
                                           vo_tip_situacao_pag,
                                           vo_num_versao_contrato_pag,
                                           v_num_seq_pag_contrato_rp,
                                           v_num_seq_resumo_pag
                                          );
            v_dado :=
               'num_seq_pag_contrato_rp = '
               || TO_CHAR (v_num_seq_pag_contrato_rp);
            v_dado :=
               v_dado
               || ','
               || 'num_seq_resumo_pag = '
               || TO_CHAR (v_num_seq_resumo_pag);
            v_dado :=
               v_dado
               || ','
               || 'tip_situacao_pag = '
               || TO_CHAR (v_tip_situacao_pag);
            v_dado :=
               v_dado
               || ','
               || 'num_versao_contrato_pag = '
               || RTRIM (LTRIM (v_num_versao_contrato_pag));
            -- LOG
            ifrseg.pck_seguranca.stp_log (p_usuario,
                                          'VIW_RESUMO_PAGAMENTO',
                                          'I',
                                          v_dado
                                         );
            COMMIT;
         ELSE
            ROLLBACK;
         END IF;
      END IF;
   EXCEPTION
      WHEN OTHERS THEN
         raise_application_error (-20100, SQLERRM);
   END;

--------------------------------------------------------------------
-- Altera Muda Situação SP
-- retorna o recordset correspondente
   PROCEDURE stp_altera_resumo_pagamento (
      p_usuario                  IN       VARCHAR2,
      vo_num_seq_pag_contrato_rp OUT      tyt_num_seq_pag_contrato_rp,
      vo_num_seq_resumo_pag      OUT      tyt_num_seq_resumo_pag,
      vo_cnt_cre_cod             OUT      tyt_cnt_cre_cod,
      vo_cnt_cod                 OUT      tyt_cnt_cod,
      vo_num_versao_contrato     OUT      tyt_num_versao_contrato,
      vo_num_seq_entidade_pag    OUT      tyt_num_seq_entidade_pag,
      vo_cod_tipo_pag_rp         OUT      tyt_cod_tipo_pag_rp,
      vo_dat_pagamento_res       OUT      tyt_dat_pagamento_res,
      vo_dat_vencimento_pag_res  OUT      tyt_dat_vencimento_pag_res,
      vo_num_fatura_rp           OUT      tyt_num_fatura_rp,
      vo_val_pagamento_rp        OUT      tyt_val_pagamento_rp,
      vo_tip_situacao_pag        OUT      tyt_tip_situacao_pag,
      vo_num_versao_contrato_pag OUT      tyt_num_versao_contrato_pag,
      vi_num_seq_pag_contrato_rp IN       t_num_seq_pag_contrato_rp,
      vi_num_seq_resumo_pag      IN       t_num_seq_resumo_pag,
      vi_tip_situacao_pag        IN       t_tip_situacao_pag,
      vi_num_versao_contrato_pag IN       t_num_versao_contrato_pag
   ) AS
      CURSOR c_cursor IS
         SELECT     *
               FROM ifrbde.viw_resumo_pagamento
              WHERE num_seq_pag_contrato_rp = vi_num_seq_pag_contrato_rp
                AND num_seq_resumo_pag = vi_num_seq_resumo_pag
         FOR UPDATE;

      v_viw_resumo_pagamento        ifrbde.viw_resumo_pagamento%ROWTYPE;
      v_num_seq_pag_contrato_rp     ifrbde.viw_resumo_pagamento.num_seq_pag_contrato_rp%TYPE;
      v_num_seq_resumo_pag          ifrbde.viw_resumo_pagamento.num_seq_resumo_pag%TYPE;
      v_tip_situacao_pag            ifrbde.viw_resumo_pagamento.tip_situacao_pag%TYPE;
      v_num_versao_contrato_pag     ifrbde.viw_resumo_pagamento.num_versao_contrato_pag%TYPE;
      v_dado                        VARCHAR2 (4000) := NULL;
   BEGIN
      IF ifrseg.pck_seguranca.stf_permitido (p_usuario,
                                             'VIW_RESUMO_PAGAMENTO',
                                             'ALTERA'
                                            ) THEN
         OPEN c_cursor;

         FETCH c_cursor
          INTO v_viw_resumo_pagamento;

         IF NOT c_cursor%NOTFOUND THEN
            v_num_versao_contrato_pag :=
               RTRIM (LTRIM (v_viw_resumo_pagamento.num_versao_contrato_pag));

            BEGIN
               v_num_seq_pag_contrato_rp :=
                               v_viw_resumo_pagamento.num_seq_pag_contrato_rp;
            EXCEPTION
               WHEN OTHERS THEN
                  raise_application_error
                     (-20100,
                      'v_num_seq_pag_contrato_rp='
                      || TO_CHAR
                               (v_viw_resumo_pagamento.num_seq_pag_contrato_rp)
                      || ' '
                      || SQLERRM
                     );
            END;

            BEGIN
               v_num_seq_resumo_pag :=
                                    v_viw_resumo_pagamento.num_seq_resumo_pag;
            EXCEPTION
               WHEN OTHERS THEN
                  raise_application_error
                        (-20100,
                         'v_num_seq_resumo_pag='
                         || TO_CHAR (v_viw_resumo_pagamento.num_seq_resumo_pag)
                         || ' '
                         || SQLERRM
                        );
            END;

            BEGIN
               v_tip_situacao_pag := v_viw_resumo_pagamento.tip_situacao_pag;
            EXCEPTION
               WHEN OTHERS THEN
                  raise_application_error
                          (-20100,
                           'tip_situacao_pag='
                           || TO_CHAR (v_viw_resumo_pagamento.tip_situacao_pag)
                           || ' '
                           || SQLERRM
                          );
            END;

            UPDATE ifrbde.viw_resumo_pagamento
               SET tip_situacao_pag = v_tip_situacao_pag,
                   num_versao_contrato_pag = v_num_versao_contrato_pag
             WHERE CURRENT OF c_cursor;

            IF SQL%ROWCOUNT = 1 THEN
               stp_pesquisa_resumo_pagamento (p_usuario,
                                              vo_num_seq_pag_contrato_rp,
                                              vo_num_seq_resumo_pag,
                                              vo_cnt_cre_cod,
                                              vo_cnt_cod,
                                              vo_num_versao_contrato,
                                              vo_num_seq_entidade_pag,
                                              vo_cod_tipo_pag_rp,
                                              vo_dat_pagamento_res,
                                              vo_dat_vencimento_pag_res,
                                              vo_num_fatura_rp,
                                              vo_val_pagamento_rp,
                                              vo_tip_situacao_pag,
                                              vo_num_versao_contrato_pag,
                                              vi_num_seq_pag_contrato_rp,
                                              vi_num_seq_resumo_pag
                                             );
               v_dado :=
                  'num_seq_pag_contrato_rp = '
                  || TO_CHAR (v_num_seq_pag_contrato_rp);
               v_dado :=
                  v_dado
                  || ','
                  || 'num_seq_resumo_pag = '
                  || TO_CHAR (v_num_seq_resumo_pag);
               v_dado :=
                  v_dado
                  || ','
                  || 'tip_situacao_pag = '
                  || TO_CHAR (v_tip_situacao_pag);
               v_dado :=
                  v_dado
                  || ','
                  || 'num_versao_contrato_pag = '
                  || RTRIM (LTRIM (v_num_versao_contrato_pag));
               -- LOG
               ifrseg.pck_seguranca.stp_log (p_usuario,
                                             'VIW_RESUMO_PAGAMENTO',
                                             'A',
                                             v_dado
                                            );
               COMMIT;
            ELSE
               ROLLBACK;
            END IF;
         END IF;
      END IF;
   EXCEPTION
      WHEN OTHERS THEN
         raise_application_error (-20100, SQLERRM);
   END;

--------------------------------------------------------------------
-- Pesquisa SP - Financeira
-- retorna o recordset correspondente
   PROCEDURE stp_pesquisa_cad_pagamento_con (
      p_usuario                  IN       VARCHAR2,
      vo_num_seq_contrato_pag    OUT      tyt_num_seq_contrato_pag,
      vo_num_seq_pag_contrato    OUT      tyt_num_seq_pag_contrato,
      vo_num_seq_resumo_contrato OUT      tyt_num_seq_resumo_contrato,
      vo_num_ano_pgose           OUT      tyt_num_ano_pgose,
      vo_cod_recurso             OUT      tyt_cod_recurso,
      vo_cod_tipo_pag            OUT      tyt_cod_tipo_pag,
      vo_num_fatura_pagamento    OUT      tyt_num_fatura_pagamento,
      vo_val_pagamento           OUT      tyt_val_pagamento,
      vo_val_glosa               OUT      tyt_val_glosa,
      vo_dat_situacao_pagamento  OUT      tyt_dat_situacao_pagamento,
      vi_num_seq_contrato_pag    IN       t_num_seq_contrato_pag
   ) AS
   BEGIN
      IF ifrseg.pck_seguranca.stf_permitido (p_usuario,
                                             'VIW_CAD_PAGAMENTO_CONTRATO',
                                             'PESQUISA'
                                            ) THEN
         SELECT num_seq_contrato_pag,
                num_seq_pag_contrato,
                num_seq_resumo_contrato,
                num_ano_pgose,
                cod_recurso,
                cod_tipo_pag,
                num_fatura_pagamento,
                val_pagamento,
                val_glosa,
                dat_situacao_pagamento
           INTO vo_num_seq_contrato_pag (1),
                vo_num_seq_pag_contrato (1),
                vo_num_seq_resumo_contrato (1),
                vo_num_ano_pgose (1),
                vo_cod_recurso (1),
                vo_cod_tipo_pag (1),
                vo_num_fatura_pagamento (1),
                vo_val_pagamento (1),
                vo_val_glosa (1),
                vo_dat_situacao_pagamento (1)
           FROM ifrbde.viw_cad_pagamento_contrato
          WHERE num_seq_contrato_pag = vi_num_seq_contrato_pag;
      END IF;
   EXCEPTION
      WHEN OTHERS THEN
         raise_application_error (-20100, SQLERRM);
   END;

   -- Exclui SP - Financeira
   -- retorna o OK ou não
   PROCEDURE stp_exclui_cad_pagamento_contr (
      p_usuario                  IN       VARCHAR2,
      vo_ok                      OUT      tyt_ok,
      vi_num_seq_contrato_pag    IN       t_num_seq_contrato_pag
   ) AS
      CURSOR c_cursor IS
         SELECT     *
               FROM ifrbde.viw_cad_pagamento_contrato
              WHERE num_seq_contrato_pag = vi_num_seq_contrato_pag
         FOR UPDATE;

      v_viw_cad_pagamento_contrato  ifrbde.viw_cad_pagamento_contrato%ROWTYPE;
      v_dado                        VARCHAR2 (4000) := NULL;
   BEGIN
      vo_ok (1) := 0;

      IF ifrseg.pck_seguranca.stf_permitido (p_usuario,
                                             'VIW_CAD_PAGAMENTO_CONTRATO',
                                             'EXCLUI'
                                            ) THEN
         OPEN c_cursor;

         FETCH c_cursor
          INTO v_viw_cad_pagamento_contrato;

         IF NOT c_cursor%NOTFOUND THEN
            v_dado :=
               'num_seq_contrato_pag = '
               || TO_CHAR (v_viw_cad_pagamento_contrato.num_seq_contrato_pag);
            v_dado :=
               v_dado
               || ','
               || 'num_seq_pag_contrato = '
               || TO_CHAR (v_viw_cad_pagamento_contrato.num_seq_pag_contrato);
            v_dado :=
               v_dado
               || ','
               || 'num_seq_resumo_contrato = '
               || TO_CHAR
                         (v_viw_cad_pagamento_contrato.num_seq_resumo_contrato);
            v_dado :=
               v_dado
               || ','
               || 'num_ano_pgose = '
               || RTRIM
                     (LTRIM (UPPER (v_viw_cad_pagamento_contrato.num_ano_pgose)
                            )
                     );
            v_dado :=
               v_dado
               || ','
               || 'cod_recurso = '
               || RTRIM
                       (LTRIM (UPPER (v_viw_cad_pagamento_contrato.cod_recurso)
                              )
                       );
            v_dado :=
               v_dado
               || ','
               || 'cod_tipo_pag = '
               || RTRIM
                      (LTRIM (UPPER (v_viw_cad_pagamento_contrato.cod_tipo_pag)
                             )
                      );
            v_dado :=
               v_dado
               || ','
               || 'num_fatura_pagamento = '
               || RTRIM
                    (LTRIM
                        (UPPER
                            (v_viw_cad_pagamento_contrato.num_fatura_pagamento)
                        )
                    );
            v_dado :=
               v_dado
               || ','
               || 'val_pagamento = '
               || TO_CHAR (v_viw_cad_pagamento_contrato.val_pagamento);
            v_dado :=
               v_dado
               || ','
               || 'val_glosa = '
               || TO_CHAR (v_viw_cad_pagamento_contrato.val_glosa);
            v_dado :=
               v_dado
               || ','
               || 'dat_situacao_pagamento = '
               || TO_DATE
                         (v_viw_cad_pagamento_contrato.dat_situacao_pagamento,
                          'DD/MM/YYYY'
                         );

            IF c_cursor%ROWCOUNT = 1 THEN
               vo_ok (1) := 1;
               -- LOG
               ifrseg.pck_seguranca.stp_log (p_usuario,
                                             'VIW_CAD_PAGAMENTO_CONTRATO',
                                             'E',
                                             v_dado
                                            );

--
               DELETE FROM ifrbde.viw_cad_pagamento_contrato
                     WHERE CURRENT OF c_cursor;

               IF c_cursor%ROWCOUNT = 1 THEN
                  vo_ok (1) := 1;
                  COMMIT;
               ELSIF c_cursor%ROWCOUNT > 1 THEN
                  ROLLBACK;
               END IF;
            END IF;
         END IF;
      END IF;
   EXCEPTION
      WHEN OTHERS THEN
         raise_application_error (-20100, SQLERRM);
   END;

--------------------------------------------------------------------
-- Inclui SP - Financeira
-- retorna o recordset correspondente
   PROCEDURE stp_inclui_cad_pagamento_contr (
      p_usuario                  IN       VARCHAR2,
      vo_num_seq_contrato_pag    OUT      tyt_num_seq_contrato_pag,
      vo_num_seq_pag_contrato    OUT      tyt_num_seq_pag_contrato,
      vo_num_seq_resumo_contrato OUT      tyt_num_seq_resumo_contrato,
      vo_num_ano_pgose           OUT      tyt_num_ano_pgose,
      vo_cod_recurso             OUT      tyt_cod_recurso,
      vo_cod_tipo_pag            OUT      tyt_cod_tipo_pag,
      vo_num_fatura_pagamento    OUT      tyt_num_fatura_pagamento,
      vo_val_pagamento           OUT      tyt_val_pagamento,
      vo_val_glosa               OUT      tyt_val_glosa,
      vo_dat_situacao_pagamento  OUT      tyt_dat_situacao_pagamento,
      vi_num_seq_contrato_pag    IN       t_num_seq_contrato_pag,
      vi_num_seq_pag_contrato    IN       t_num_seq_pag_contrato,
      vi_num_seq_resumo_contrato IN       t_num_seq_resumo_contrato,
      vi_num_ano_pgose           IN       t_num_ano_pgose,
      vi_cod_recurso             IN       t_cod_recurso,
      vi_cod_tipo_pag            IN       t_cod_tipo_pag,
      vi_num_fatura_pagamento    IN       t_num_fatura_pagamento,
      vi_val_pagamento           IN       t_val_pagamento,
      vi_val_glosa               IN       t_val_glosa,
      vi_dat_situacao_pagamento  IN       t_dat_situacao_pagamento
   ) AS
      v_num_seq_contrato_pag        viw_cad_pagamento_contrato.num_seq_contrato_pag%TYPE;
      v_num_seq_pag_contrato        viw_cad_pagamento_contrato.num_seq_pag_contrato%TYPE;
      v_num_seq_resumo_contrato     viw_cad_pagamento_contrato.num_seq_resumo_contrato%TYPE;
      v_num_ano_pgose               viw_cad_pagamento_contrato.num_ano_pgose%TYPE;
      v_cod_recurso                 viw_cad_pagamento_contrato.cod_recurso%TYPE;
      v_cod_tipo_pag                viw_cad_pagamento_contrato.cod_tipo_pag%TYPE;
      v_num_fatura_pagamento        viw_cad_pagamento_contrato.num_fatura_pagamento%TYPE;
      v_val_pagamento               viw_cad_pagamento_contrato.val_pagamento%TYPE;
      v_val_glosa                   viw_cad_pagamento_contrato.val_glosa%TYPE;
      v_dat_situacao_pagamento      viw_cad_pagamento_contrato.dat_situacao_pagamento%TYPE;
      v_dado                        VARCHAR2 (4000) := NULL;
   BEGIN
      IF ifrseg.pck_seguranca.stf_permitido (p_usuario,
                                             'VIW_CAD_PAGAMENTO_CONTRATO',
                                             'INCLUI'
                                            ) THEN
         v_num_ano_pgose := RTRIM (LTRIM (vi_num_ano_pgose));
         v_cod_recurso := RTRIM (LTRIM (vi_cod_recurso));
         v_cod_tipo_pag := RTRIM (LTRIM (vi_cod_tipo_pag));
         v_num_fatura_pagamento := RTRIM (LTRIM (vi_num_fatura_pagamento));
         v_dat_situacao_pagamento :=
                            TO_DATE (vi_dat_situacao_pagamento, 'DD/MM/YYYY');
         v_num_seq_contrato_pag := vi_num_seq_contrato_pag;
         v_num_seq_pag_contrato := vi_num_seq_pag_contrato;
         v_num_seq_resumo_contrato := vi_num_seq_resumo_contrato;
         v_val_pagamento := vi_val_pagamento;
         v_val_glosa := vi_val_glosa;

         INSERT INTO ifrbde.viw_cad_pagamento_contrato
                     (num_seq_contrato_pag,
                      num_seq_pag_contrato,
                      num_seq_resumo_contrato,
                      num_ano_pgose,
                      cod_recurso,
                      cod_tipo_pag,
                      num_fatura_pagamento,
                      val_pagamento,
                      val_glosa,
                      dat_situacao_pagamento
                     )
              VALUES (v_num_seq_contrato_pag,
                      v_num_seq_pag_contrato,
                      v_num_seq_resumo_contrato,
                      v_num_ano_pgose,
                      v_cod_recurso,
                      v_cod_tipo_pag,
                      v_num_fatura_pagamento,
                      v_val_pagamento,
                      v_val_glosa,
                      v_dat_situacao_pagamento
                     );

         IF SQL%ROWCOUNT = 1 THEN
            stp_pesquisa_cad_pagamento_con (p_usuario,
                                            vo_num_seq_contrato_pag,
                                            vo_num_seq_pag_contrato,
                                            vo_num_seq_resumo_contrato,
                                            vo_num_ano_pgose,
                                            vo_cod_recurso,
                                            vo_cod_tipo_pag,
                                            vo_num_fatura_pagamento,
                                            vo_val_pagamento,
                                            vo_val_glosa,
                                            vo_dat_situacao_pagamento,
                                            v_num_seq_contrato_pag
                                           );
            v_dado :=
                 'num_seq_contrato_pag = ' || TO_CHAR (v_num_seq_contrato_pag);
            v_dado :=
               v_dado
               || ','
               || 'num_seq_pag_contrato = '
               || TO_CHAR (v_num_seq_pag_contrato);
            v_dado :=
               v_dado
               || ','
               || 'num_seq_resumo_contrato = '
               || TO_CHAR (v_num_seq_resumo_contrato);
            v_dado :=
               v_dado
               || ','
               || 'num_ano_pgose = '
               || RTRIM (LTRIM (v_num_ano_pgose));
            v_dado :=
               v_dado || ',' || 'cod_recurso = '
               || RTRIM (LTRIM (v_cod_recurso));
            v_dado :=
               v_dado
               || ','
               || 'cod_tipo_pag = '
               || RTRIM (LTRIM (v_cod_tipo_pag));
            v_dado :=
               v_dado
               || ','
               || 'num_fatura_pagamento = '
               || RTRIM (LTRIM (v_num_fatura_pagamento));
            v_dado :=
               v_dado || ',' || 'val_pagamento = '
               || TO_CHAR (v_val_pagamento);
            v_dado := v_dado || ',' || 'val_glosa = ' || TO_CHAR (v_val_glosa);
            v_dado :=
               v_dado
               || ','
               || 'dat_situacao_pagamento = '
               || TO_CHAR (v_dat_situacao_pagamento, 'DD/MM/YYYY');
            -- LOG
            ifrseg.pck_seguranca.stp_log (p_usuario,
                                          'VIW_CAD_PAGAMENTO_CONTRATO',
                                          'I',
                                          v_dado
                                         );
            COMMIT;
         ELSE
            ROLLBACK;
         END IF;
      END IF;
   EXCEPTION
      WHEN OTHERS THEN
         raise_application_error (-20100, SQLERRM);
   END;

--------------------------------------------------------------------
-- Altera SP - Financeira
-- retorna o recordset correspondente
   PROCEDURE stp_altera_cad_pagamento_contr (
      p_usuario                  IN       VARCHAR2,
      vo_num_seq_contrato_pag    OUT      tyt_num_seq_contrato_pag,
      vo_num_seq_pag_contrato    OUT      tyt_num_seq_pag_contrato,
      vo_num_seq_resumo_contrato OUT      tyt_num_seq_resumo_contrato,
      vo_num_ano_pgose           OUT      tyt_num_ano_pgose,
      vo_cod_recurso             OUT      tyt_cod_recurso,
      vo_cod_tipo_pag            OUT      tyt_cod_tipo_pag,
      vo_num_fatura_pagamento    OUT      tyt_num_fatura_pagamento,
      vo_val_pagamento           OUT      tyt_val_pagamento,
      vo_val_glosa               OUT      tyt_val_glosa,
      vo_dat_situacao_pagamento  OUT      tyt_dat_situacao_pagamento,
      vi_num_seq_contrato_pag    IN       t_num_seq_contrato_pag,
      vi_num_seq_pag_contrato    IN       t_num_seq_pag_contrato,
      vi_num_seq_resumo_contrato IN       t_num_seq_resumo_contrato,
      vi_num_ano_pgose           IN       t_num_ano_pgose,
      vi_cod_recurso             IN       t_cod_recurso,
      vi_cod_tipo_pag            IN       t_cod_tipo_pag,
      vi_num_fatura_pagamento    IN       t_num_fatura_pagamento,
      vi_val_pagamento           IN       t_val_pagamento,
      vi_val_glosa               IN       t_val_glosa,
      vi_dat_situacao_pagamento  IN       t_dat_situacao_pagamento
   ) AS
      CURSOR c_cursor IS
         SELECT     *
               FROM ifrbde.viw_cad_pagamento_contrato
              WHERE num_seq_contrato_pag = vi_num_seq_contrato_pag
         FOR UPDATE;

      v_viw_cad_pagamento_contrato  ifrbde.viw_cad_pagamento_contrato%ROWTYPE;
      v_num_seq_contrato_pag        ifrbde.viw_cad_pagamento_contrato.num_seq_contrato_pag%TYPE;
      v_num_seq_pag_contrato        ifrbde.viw_cad_pagamento_contrato.num_seq_pag_contrato%TYPE;
      v_num_seq_resumo_contrato     ifrbde.viw_cad_pagamento_contrato.num_seq_resumo_contrato%TYPE;
      v_num_ano_pgose               ifrbde.viw_cad_pagamento_contrato.num_ano_pgose%TYPE;
      v_cod_recurso                 ifrbde.viw_cad_pagamento_contrato.cod_recurso%TYPE;
      v_cod_tipo_pag                ifrbde.viw_cad_pagamento_contrato.cod_tipo_pag%TYPE;
      v_num_fatura_pagamento        ifrbde.viw_cad_pagamento_contrato.num_fatura_pagamento%TYPE;
      v_val_pagamento               ifrbde.viw_cad_pagamento_contrato.val_pagamento%TYPE;
      v_val_glosa                   ifrbde.viw_cad_pagamento_contrato.val_glosa%TYPE;
      v_dat_situacao_pagamento      ifrbde.viw_cad_pagamento_contrato.dat_situacao_pagamento%TYPE;
      v_dado                        VARCHAR2 (4000) := NULL;
   BEGIN
      IF ifrseg.pck_seguranca.stf_permitido (p_usuario,
                                             'VIW_CAD_PAGAMENTO_CONTRATO',
                                             'ALTERA'
                                            ) THEN
         OPEN c_cursor;

         FETCH c_cursor
          INTO v_viw_cad_pagamento_contrato;

         IF NOT c_cursor%NOTFOUND THEN
            v_num_ano_pgose := RTRIM (LTRIM (vi_num_ano_pgose));
            v_cod_recurso := RTRIM (LTRIM (vi_cod_recurso));
            v_cod_tipo_pag := RTRIM (LTRIM (vi_cod_tipo_pag));
            v_num_fatura_pagamento := RTRIM (LTRIM (vi_num_fatura_pagamento));
            v_dat_situacao_pagamento :=
                            TO_DATE (vi_dat_situacao_pagamento, 'DD/MM/YYYY');
            v_num_seq_contrato_pag := vi_num_seq_contrato_pag;
            v_num_seq_pag_contrato := vi_num_seq_pag_contrato;
            v_num_seq_resumo_contrato := vi_num_seq_resumo_contrato;
            v_val_pagamento := vi_val_pagamento;
            v_val_glosa := vi_val_glosa;

            UPDATE ifrbde.viw_cad_pagamento_contrato
               SET num_seq_pag_contrato = v_num_seq_pag_contrato,
                   num_seq_resumo_contrato = v_num_seq_resumo_contrato,
                   num_ano_pgose = v_num_ano_pgose,
                   cod_recurso = v_cod_recurso,
                   cod_tipo_pag = v_cod_tipo_pag,
                   num_fatura_pagamento = v_num_fatura_pagamento,
                   val_pagamento = v_val_pagamento,
                   val_glosa = v_val_glosa,
                   dat_situacao_pagamento = v_dat_situacao_pagamento
             WHERE CURRENT OF c_cursor;

            IF SQL%ROWCOUNT = 1 THEN
               stp_pesquisa_cad_pagamento_con (p_usuario,
                                               vo_num_seq_contrato_pag,
                                               vo_num_seq_pag_contrato,
                                               vo_num_seq_resumo_contrato,
                                               vo_num_ano_pgose,
                                               vo_cod_recurso,
                                               vo_cod_tipo_pag,
                                               vo_num_fatura_pagamento,
                                               vo_val_pagamento,
                                               vo_val_glosa,
                                               vo_dat_situacao_pagamento,
                                               vi_num_seq_contrato_pag
                                              );
               v_dado :=
                  'num_seq_contrato_pag = '
                  || TO_CHAR (v_num_seq_contrato_pag);
               v_dado :=
                  v_dado
                  || ','
                  || 'num_seq_pag_contrato = '
                  || TO_CHAR (v_num_seq_pag_contrato);
               v_dado :=
                  v_dado
                  || ','
                  || 'num_seq_resumo_contrato = '
                  || TO_CHAR (v_num_seq_resumo_contrato);
               v_dado :=
                  v_dado
                  || ','
                  || 'num_ano_pgose = '
                  || RTRIM (LTRIM (v_num_ano_pgose));
               v_dado :=
                  v_dado
                  || ','
                  || 'cod_recurso = '
                  || RTRIM (LTRIM (v_cod_recurso));
               v_dado :=
                  v_dado
                  || ','
                  || 'cod_tipo_pag = '
                  || RTRIM (LTRIM (v_cod_tipo_pag));
               v_dado :=
                  v_dado
                  || ','
                  || 'num_fatura_pagamento = '
                  || RTRIM (LTRIM (v_num_fatura_pagamento));
               v_dado :=
                  v_dado
                  || ','
                  || 'val_pagamento = '
                  || TO_CHAR (v_val_pagamento);
               v_dado :=
                      v_dado || ',' || 'val_glosa = ' || TO_CHAR (v_val_glosa);
               v_dado :=
                  v_dado
                  || ','
                  || 'dat_situacao_pagamento = '
                  || TO_CHAR (v_dat_situacao_pagamento, 'DD/MM/YYYY');
               -- LOG
               ifrseg.pck_seguranca.stp_log (p_usuario,
                                             'VIW_CAD_PAGAMENTO_CONTRATO',
                                             'A',
                                             v_dado
                                            );
               COMMIT;
            ELSE
               ROLLBACK;
            END IF;
         END IF;
      END IF;
   EXCEPTION
      WHEN OTHERS THEN
         raise_application_error (-20100, SQLERRM);
   END;

--------------------------------------------------------------------
-- Pesquisa Ajusta Cronograma
-- retorna o recordset correspondente
   PROCEDURE stp_pesquisa_hst_pagamento_cro (
      p_usuario                  IN       VARCHAR2,
      vo_num_seq_cronograma_hst  OUT      tyt_num_seq_cronograma_hst,
      vo_num_seq_pag_contrato_hst OUT     tyt_num_seq_pag_contrato_hst,
      vo_dat_execucao_hst        OUT      tyt_dat_execucao_hst,
      vo_cod_recurso_hst         OUT      tyt_cod_recurso_hst,
      vo_val_retirado_hst        OUT      tyt_val_retirado_hst,
      vo_val_retirado_sec_hst    OUT      tyt_val_retirado_sec_hst,
      vo_tip_historico_pagamento OUT      tyt_tip_historico_pagamento,
      vi_num_seq_cronograma_hst  IN       t_num_seq_cronograma_hst
   ) AS
   BEGIN
      IF ifrseg.pck_seguranca.stf_permitido (p_usuario,
                                             'VIW_HST_PAGAMENTO_CRONOGRAMA',
                                             'PESQUISA'
                                            ) THEN
         SELECT num_seq_cronograma_hst,
                num_seq_pag_contrato_hst,
                dat_execucao_hst,
                cod_recurso_hst,
                val_retirado_hst,
                val_retirado_sec_hst,
                tip_historico_pagamento
           INTO vo_num_seq_cronograma_hst (1),
                vo_num_seq_pag_contrato_hst (1),
                vo_dat_execucao_hst (1),
                vo_cod_recurso_hst (1),
                vo_val_retirado_hst (1),
                vo_val_retirado_sec_hst (1),
                vo_tip_historico_pagamento (1)
           FROM ifrbde.viw_hst_pagamento_cronograma
          WHERE num_seq_cronograma_hst = vi_num_seq_cronograma_hst;
      END IF;
   EXCEPTION
      WHEN OTHERS THEN
         raise_application_error (-20100, SQLERRM);
   END;

   -- Exclui Ajusta Cronograma
   -- retorna o OK ou não
   PROCEDURE stp_exclui_hst_pagamento_crono (
      p_usuario                  IN       VARCHAR2,
      vo_ok                      OUT      tyt_ok,
      vi_num_seq_cronograma_hst  IN       t_num_seq_cronograma_hst
   ) AS
      CURSOR c_cursor IS
         SELECT     *
               FROM ifrbde.viw_hst_pagamento_cronograma
              WHERE num_seq_cronograma_hst = vi_num_seq_cronograma_hst
         FOR UPDATE;

      v_viw_hst_pagamento_cronograma ifrbde.viw_hst_pagamento_cronograma%ROWTYPE;
      v_dado                        VARCHAR2 (4000) := NULL;
   BEGIN
      vo_ok (1) := 0;

      IF ifrseg.pck_seguranca.stf_permitido (p_usuario,
                                             'VIW_HST_PAGAMENTO_CRONOGRAMA',
                                             'EXCLUI'
                                            ) THEN
         OPEN c_cursor;

         FETCH c_cursor
          INTO v_viw_hst_pagamento_cronograma;

         IF NOT c_cursor%NOTFOUND THEN
            v_dado :=
               'num_seq_cronograma_hst = '
               || TO_CHAR
                        (v_viw_hst_pagamento_cronograma.num_seq_cronograma_hst);
            v_dado :=
               v_dado
               || ','
               || 'num_seq_pag_contrato_hst = '
               || TO_CHAR
                      (v_viw_hst_pagamento_cronograma.num_seq_pag_contrato_hst);
            v_dado :=
               v_dado
               || ','
               || 'dat_execucao_hst = '
               || TO_DATE (v_viw_hst_pagamento_cronograma.dat_execucao_hst,
                           'DD/MM/YYYY'
                          );
            v_dado :=
               v_dado
               || ','
               || 'cod_recurso_hst = '
               || RTRIM
                    (LTRIM
                        (UPPER (v_viw_hst_pagamento_cronograma.cod_recurso_hst)
                        )
                    );
            v_dado :=
               v_dado
               || ','
               || 'val_retirado_hst = '
               || TO_CHAR (v_viw_hst_pagamento_cronograma.val_retirado_hst);
            v_dado :=
               v_dado
               || ','
               || 'val_retirado_sec_hst = '
               || TO_CHAR (v_viw_hst_pagamento_cronograma.val_retirado_sec_hst);
            v_dado :=
               v_dado
               || ','
               || 'tip_historico_pagamento = '
               || RTRIM
                    (LTRIM
                        (UPPER
                            (v_viw_hst_pagamento_cronograma.tip_historico_pagamento
                            )
                        )
                    );

            IF c_cursor%ROWCOUNT = 1 THEN
               vo_ok (1) := 1;
               -- LOG
               ifrseg.pck_seguranca.stp_log (p_usuario,
                                             'VIW_HST_PAGAMENTO_CRONOGRAMA',
                                             'E',
                                             v_dado
                                            );

               DELETE FROM ifrbde.viw_hst_pagamento_cronograma
                     WHERE CURRENT OF c_cursor;

               IF c_cursor%ROWCOUNT = 1 THEN
                  vo_ok (1) := 1;
                  COMMIT;
               ELSIF c_cursor%ROWCOUNT > 1 THEN
                  ROLLBACK;
               END IF;
            END IF;
         END IF;
      END IF;
   EXCEPTION
      WHEN OTHERS THEN
         raise_application_error (-20100, SQLERRM);
   END;

--------------------------------------------------------------------
-- Inclui Ajusta Cronograma
-- retorna o recordset correspondente
   PROCEDURE stp_inclui_hst_pagamento_crono (
      p_usuario                  IN       VARCHAR2,
      vo_num_seq_cronograma_hst  OUT      tyt_num_seq_cronograma_hst,
      vo_num_seq_pag_contrato_hst OUT     tyt_num_seq_pag_contrato_hst,
      vo_dat_execucao_hst        OUT      tyt_dat_execucao_hst,
      vo_cod_recurso_hst         OUT      tyt_cod_recurso_hst,
      vo_val_retirado_hst        OUT      tyt_val_retirado_hst,
      vo_val_retirado_sec_hst    OUT      tyt_val_retirado_sec_hst,
      vo_tip_historico_pagamento OUT      tyt_tip_historico_pagamento,
      vi_num_seq_cronograma_hst  IN       t_num_seq_cronograma_hst,
      vi_num_seq_pag_contrato_hst IN      t_num_seq_pag_contrato_hst,
      vi_dat_execucao_hst        IN       t_dat_execucao_hst,
      vi_cod_recurso_hst         IN       t_cod_recurso_hst,
      vi_val_retirado_hst        IN       t_val_retirado_hst,
      vi_val_retirado_sec_hst    IN       t_val_retirado_sec_hst,
      vi_tip_historico_pagamento IN       t_tip_historico_pagamento
   ) AS
      v_num_seq_cronograma_hst      viw_hst_pagamento_cronograma.num_seq_cronograma_hst%TYPE;
      v_num_seq_pag_contrato_hst    viw_hst_pagamento_cronograma.num_seq_pag_contrato_hst%TYPE;
      v_dat_execucao_hst            viw_hst_pagamento_cronograma.dat_execucao_hst%TYPE;
      v_cod_recurso_hst             viw_hst_pagamento_cronograma.cod_recurso_hst%TYPE;
      v_val_retirado_hst            viw_hst_pagamento_cronograma.val_retirado_hst%TYPE;
      v_val_retirado_sec_hst        viw_hst_pagamento_cronograma.val_retirado_sec_hst%TYPE;
      v_tip_historico_pagamento     viw_hst_pagamento_cronograma.tip_historico_pagamento%TYPE;
      v_dado                        VARCHAR2 (4000) := NULL;
   BEGIN
      IF ifrseg.pck_seguranca.stf_permitido (p_usuario,
                                             'VIW_HST_PAGAMENTO_CRONOGRAMA',
                                             'INCLUI'
                                            ) THEN
         v_cod_recurso_hst := RTRIM (LTRIM (vi_cod_recurso_hst));
         v_tip_historico_pagamento :=
                                   RTRIM (LTRIM (vi_tip_historico_pagamento));
         v_dat_execucao_hst := TO_DATE (vi_dat_execucao_hst, 'DD/MM/YYYY');
         v_num_seq_cronograma_hst := vi_num_seq_cronograma_hst;
         v_num_seq_pag_contrato_hst := vi_num_seq_pag_contrato_hst;
         v_val_retirado_hst := vi_val_retirado_hst;
         v_val_retirado_sec_hst := vi_val_retirado_sec_hst;

         INSERT INTO ifrbde.viw_hst_pagamento_cronograma
                     (num_seq_cronograma_hst,
                      num_seq_pag_contrato_hst,
                      dat_execucao_hst,
                      cod_recurso_hst,
                      val_retirado_hst,
                      val_retirado_sec_hst,
                      tip_historico_pagamento
                     )
              VALUES (v_num_seq_cronograma_hst,
                      v_num_seq_pag_contrato_hst,
                      v_dat_execucao_hst,
                      v_cod_recurso_hst,
                      v_val_retirado_hst,
                      v_val_retirado_sec_hst,
                      v_tip_historico_pagamento
                     );

         IF SQL%ROWCOUNT = 1 THEN
            stp_pesquisa_hst_pagamento_cro (p_usuario,
                                            vo_num_seq_cronograma_hst,
                                            vo_num_seq_pag_contrato_hst,
                                            vo_dat_execucao_hst,
                                            vo_cod_recurso_hst,
                                            vo_val_retirado_hst,
                                            vo_val_retirado_sec_hst,
                                            vo_tip_historico_pagamento,
                                            v_num_seq_cronograma_hst
                                           );
            v_dado :=
               'num_seq_cronograma_hst = '
               || TO_CHAR (v_num_seq_cronograma_hst);
            v_dado :=
               v_dado
               || ','
               || 'num_seq_pag_contrato_hst = '
               || TO_CHAR (v_num_seq_pag_contrato_hst);
            v_dado :=
               v_dado
               || ','
               || 'dat_execucao_hst = '
               || TO_CHAR (v_dat_execucao_hst, 'DD/MM/YYYY');
            v_dado :=
               v_dado
               || ','
               || 'cod_recurso_hst = '
               || RTRIM (LTRIM (v_cod_recurso_hst));
            v_dado :=
               v_dado
               || ','
               || 'val_retirado_hst = '
               || TO_CHAR (v_val_retirado_hst);
            v_dado :=
               v_dado
               || ','
               || 'val_retirado_sec_hst = '
               || TO_CHAR (v_val_retirado_sec_hst);
            v_dado :=
               v_dado
               || ','
               || 'tip_historico_pagamento = '
               || RTRIM (LTRIM (v_tip_historico_pagamento));
            -- LOG
            ifrseg.pck_seguranca.stp_log (p_usuario,
                                          'VIW_HST_PAGAMENTO_CRONOGRAMA',
                                          'I',
                                          v_dado
                                         );
            COMMIT;
         ELSE
            ROLLBACK;
         END IF;
      END IF;
   EXCEPTION
      WHEN OTHERS THEN
         raise_application_error (-20100, SQLERRM);
   END;

--------------------------------------------------------------------
-- Altera Ajusta Cronograma
-- retorna o recordset correspondente
   PROCEDURE stp_altera_hst_pagamento_crono (
      p_usuario                  IN       VARCHAR2,
      vo_num_seq_cronograma_hst  OUT      tyt_num_seq_cronograma_hst,
      vo_num_seq_pag_contrato_hst OUT     tyt_num_seq_pag_contrato_hst,
      vo_dat_execucao_hst        OUT      tyt_dat_execucao_hst,
      vo_cod_recurso_hst         OUT      tyt_cod_recurso_hst,
      vo_val_retirado_hst        OUT      tyt_val_retirado_hst,
      vo_val_retirado_sec_hst    OUT      tyt_val_retirado_sec_hst,
      vo_tip_historico_pagamento OUT      tyt_tip_historico_pagamento,
      vi_num_seq_cronograma_hst  IN       t_num_seq_cronograma_hst,
      vi_num_seq_pag_contrato_hst IN      t_num_seq_pag_contrato_hst,
      vi_dat_execucao_hst        IN       t_dat_execucao_hst,
      vi_cod_recurso_hst         IN       t_cod_recurso_hst,
      vi_val_retirado_hst        IN       t_val_retirado_hst,
      vi_val_retirado_sec_hst    IN       t_val_retirado_sec_hst,
      vi_tip_historico_pagamento IN       t_tip_historico_pagamento
   ) AS
      CURSOR c_cursor IS
         SELECT     *
               FROM ifrbde.viw_hst_pagamento_cronograma
              WHERE num_seq_cronograma_hst = vi_num_seq_cronograma_hst
         FOR UPDATE;

      v_viw_hst_pagamento_cronograma ifrbde.viw_hst_pagamento_cronograma%ROWTYPE;
      v_num_seq_cronograma_hst      ifrbde.viw_hst_pagamento_cronograma.num_seq_cronograma_hst%TYPE;
      v_num_seq_pag_contrato_hst    ifrbde.viw_hst_pagamento_cronograma.num_seq_pag_contrato_hst%TYPE;
      v_dat_execucao_hst            ifrbde.viw_hst_pagamento_cronograma.dat_execucao_hst%TYPE;
      v_cod_recurso_hst             ifrbde.viw_hst_pagamento_cronograma.cod_recurso_hst%TYPE;
      v_val_retirado_hst            ifrbde.viw_hst_pagamento_cronograma.val_retirado_hst%TYPE;
      v_val_retirado_sec_hst        ifrbde.viw_hst_pagamento_cronograma.val_retirado_sec_hst%TYPE;
      v_tip_historico_pagamento     ifrbde.viw_hst_pagamento_cronograma.tip_historico_pagamento%TYPE;
      v_dado                        VARCHAR2 (4000) := NULL;
   BEGIN
      IF ifrseg.pck_seguranca.stf_permitido (p_usuario,
                                             'VIW_HST_PAGAMENTO_CRONOGRAMA',
                                             'ALTERA'
                                            ) THEN
         OPEN c_cursor;

         FETCH c_cursor
          INTO v_viw_hst_pagamento_cronograma;

         IF NOT c_cursor%NOTFOUND THEN
            v_cod_recurso_hst := RTRIM (LTRIM (vi_cod_recurso_hst));
            v_tip_historico_pagamento :=
                                   RTRIM (LTRIM (vi_tip_historico_pagamento));
            v_dat_execucao_hst := TO_DATE (vi_dat_execucao_hst, 'DD/MM/YYYY');
            v_num_seq_cronograma_hst := vi_num_seq_cronograma_hst;
            v_num_seq_pag_contrato_hst := vi_num_seq_pag_contrato_hst;
            v_val_retirado_hst := vi_val_retirado_hst;
            v_val_retirado_sec_hst := vi_val_retirado_sec_hst;

            UPDATE ifrbde.viw_hst_pagamento_cronograma
               SET num_seq_pag_contrato_hst = v_num_seq_pag_contrato_hst,
                   dat_execucao_hst = v_dat_execucao_hst,
                   cod_recurso_hst = v_cod_recurso_hst,
                   val_retirado_hst = v_val_retirado_hst,
                   val_retirado_sec_hst = v_val_retirado_sec_hst,
                   tip_historico_pagamento = v_tip_historico_pagamento
             WHERE CURRENT OF c_cursor;

            IF SQL%ROWCOUNT = 1 THEN
               stp_pesquisa_hst_pagamento_cro (p_usuario,
                                               vo_num_seq_cronograma_hst,
                                               vo_num_seq_pag_contrato_hst,
                                               vo_dat_execucao_hst,
                                               vo_cod_recurso_hst,
                                               vo_val_retirado_hst,
                                               vo_val_retirado_sec_hst,
                                               vo_tip_historico_pagamento,
                                               vi_num_seq_cronograma_hst
                                              );
               v_dado :=
                  'num_seq_cronograma_hst = '
                  || TO_CHAR (v_num_seq_cronograma_hst);
               v_dado :=
                  v_dado
                  || ','
                  || 'num_seq_pag_contrato_hst = '
                  || TO_CHAR (v_num_seq_pag_contrato_hst);
               v_dado :=
                  v_dado
                  || ','
                  || 'dat_execucao_hst = '
                  || TO_CHAR (v_dat_execucao_hst, 'DD/MM/YYYY');
               v_dado :=
                  v_dado
                  || ','
                  || 'cod_recurso_hst = '
                  || RTRIM (LTRIM (v_cod_recurso_hst));
               v_dado :=
                  v_dado
                  || ','
                  || 'val_retirado_hst = '
                  || TO_CHAR (v_val_retirado_hst);
               v_dado :=
                  v_dado
                  || ','
                  || 'val_retirado_sec_hst = '
                  || TO_CHAR (v_val_retirado_sec_hst);
               v_dado :=
                  v_dado
                  || ','
                  || 'tip_historico_pagamento = '
                  || RTRIM (LTRIM (v_tip_historico_pagamento));
               -- LOG
               ifrseg.pck_seguranca.stp_log (p_usuario,
                                             'VIW_HST_PAGAMENTO_CRONOGRAMA',
                                             'A',
                                             v_dado
                                            );
               COMMIT;
            ELSE
               ROLLBACK;
            END IF;
         END IF;
      END IF;
   EXCEPTION
      WHEN OTHERS THEN
         raise_application_error (-20100, SQLERRM);
   END;

--------------------------------------------------------------------
-- Pesquisa Justificativa SP
-- retorna o recordset correspondente
   PROCEDURE stp_pesquisa_hst_justificativa (
      p_usuario                  IN       VARCHAR2,
      vo_num_seq_justificativa   OUT      tyt_num_seq_justificativa,
      vo_num_seq_resumo_just     OUT      tyt_num_seq_resumo_just,
      vo_ds_justificativa        OUT      tyt_ds_justificativa,
      vo_dat_inclusao            OUT      tyt_dat_inclusao,
      vo_dat_processamento       OUT      tyt_dat_processamento,
      vi_num_seq_justificativa   IN       t_num_seq_justificativa
   ) AS
   BEGIN
      IF ifrseg.pck_seguranca.stf_permitido (p_usuario,
                                             'VIW_HST_JUSTIFICATIVA_SP',
                                             'PESQUISA'
                                            ) THEN
         SELECT num_seq_justificativa,
                num_seq_resumo_just,
                ds_justificativa,
                dat_inclusao,
                dat_processamento
           INTO vo_num_seq_justificativa (1),
                vo_num_seq_resumo_just (1),
                vo_ds_justificativa (1),
                vo_dat_inclusao (1),
                vo_dat_processamento (1)
           FROM ifrbde.viw_hst_justificativa_sp
          WHERE num_seq_justificativa = vi_num_seq_justificativa;
      END IF;
   EXCEPTION
      WHEN OTHERS THEN
         raise_application_error (-20100, SQLERRM);
   END;

   -- Exclui Justificativa SP
   -- retorna o OK ou não
   PROCEDURE stp_exclui_hst_justificativa_s (
      p_usuario                  IN       VARCHAR2,
      vo_ok                      OUT      tyt_ok,
      vi_num_seq_justificativa   IN       t_num_seq_justificativa
   ) AS
      CURSOR c_cursor IS
         SELECT     *
               FROM ifrbde.viw_hst_justificativa_sp
              WHERE num_seq_justificativa = vi_num_seq_justificativa
         FOR UPDATE;

      v_viw_hst_justificativa_sp    ifrbde.viw_hst_justificativa_sp%ROWTYPE;
      v_dado                        VARCHAR2 (4000) := NULL;
   BEGIN
      vo_ok (1) := 0;

      IF ifrseg.pck_seguranca.stf_permitido (p_usuario,
                                             'VIW_HST_JUSTIFICATIVA_SP',
                                             'EXCLUI'
                                            ) THEN
         OPEN c_cursor;

         FETCH c_cursor
          INTO v_viw_hst_justificativa_sp;

         IF NOT c_cursor%NOTFOUND THEN
            v_dado :=
               'num_seq_justificativa = '
               || TO_CHAR (v_viw_hst_justificativa_sp.num_seq_justificativa);
            v_dado :=
               v_dado
               || ','
               || 'num_seq_resumo_just = '
               || TO_CHAR (v_viw_hst_justificativa_sp.num_seq_resumo_just);
            v_dado :=
               v_dado
               || ','
               || 'ds_justificativa = '
               || RTRIM
                    (LTRIM (UPPER (v_viw_hst_justificativa_sp.ds_justificativa)
                           )
                    );
            v_dado :=
               v_dado
               || ','
               || 'dat_inclusao = '
               || TO_DATE (v_viw_hst_justificativa_sp.dat_inclusao,
                           'DD/MM/YYYY'
                          );
            v_dado :=
               v_dado
               || ','
               || 'dat_processamento = '
               || TO_DATE (v_viw_hst_justificativa_sp.dat_processamento,
                           'DD/MM/YYYY'
                          );

            IF c_cursor%ROWCOUNT = 1 THEN
               vo_ok (1) := 1;
               -- LOG
               ifrseg.pck_seguranca.stp_log (p_usuario,
                                             'VIW_HST_JUSTIFICATIVA_SP',
                                             'E',
                                             v_dado
                                            );

               DELETE FROM ifrbde.viw_hst_justificativa_sp
                     WHERE CURRENT OF c_cursor;

               IF c_cursor%ROWCOUNT = 1 THEN
                  vo_ok (1) := 1;
                  COMMIT;
               ELSIF c_cursor%ROWCOUNT > 1 THEN
                  ROLLBACK;
               END IF;
            END IF;
         END IF;
      END IF;
   EXCEPTION
      WHEN OTHERS THEN
         raise_application_error (-20100, SQLERRM);
   END;

--------------------------------------------------------------------
-- Inclui Justificativa SP
-- retorna o recordset correspondente
   PROCEDURE stp_inclui_hst_justificativa_s (
      p_usuario                  IN       VARCHAR2,
      vo_num_seq_justificativa   OUT      tyt_num_seq_justificativa,
      vo_num_seq_resumo_just     OUT      tyt_num_seq_resumo_just,
      vo_ds_justificativa        OUT      tyt_ds_justificativa,
      vo_dat_inclusao            OUT      tyt_dat_inclusao,
      vo_dat_processamento       OUT      tyt_dat_processamento,
      vi_num_seq_resumo_just     IN       t_num_seq_resumo_just,
      vi_ds_justificativa        IN       t_ds_justificativa,
      vi_dat_inclusao            IN       t_dat_inclusao,
      vi_dat_processamento       IN       t_dat_processamento
   ) AS
      v_num_seq_justificativa       viw_hst_justificativa_sp.num_seq_justificativa%TYPE;
      v_num_seq_resumo_just         viw_hst_justificativa_sp.num_seq_resumo_just%TYPE;
      v_ds_justificativa            viw_hst_justificativa_sp.ds_justificativa%TYPE;
      v_dat_inclusao                viw_hst_justificativa_sp.dat_inclusao%TYPE;
      v_dat_processamento           viw_hst_justificativa_sp.dat_processamento%TYPE;
      v_dado                        VARCHAR2 (4000) := NULL;
   BEGIN
      IF ifrseg.pck_seguranca.stf_permitido (p_usuario,
                                             'VIW_HST_JUSTIFICATIVA_SP',
                                             'INCLUI'
                                            ) THEN
         SELECT num_seq_resumo_pag
           INTO v_num_seq_resumo_just
           FROM ifrbde.hst_justificativa_sp
          WHERE num_seq_resumo_pag = vi_num_seq_resumo_just
            AND dat_processamento IS NULL;

         IF SQL%ROWCOUNT <> 0 THEN
            raise_application_error
               (-2010,
                'Favor processar as justificativas pendentes. Inclusão cancelada !!!'
               );
         END IF;

         SELECT ifrbde.seq_num_seq_contrato.NEXTVAL
           INTO v_num_seq_justificativa
           FROM DUAL;

         v_ds_justificativa := RTRIM (LTRIM (vi_ds_justificativa));
         v_dat_inclusao := TO_DATE (vi_dat_inclusao, 'DD/MM/YYYY');
         v_dat_processamento := TO_DATE (vi_dat_processamento, 'DD/MM/YYYY');
         v_num_seq_resumo_just := vi_num_seq_resumo_just;

         INSERT INTO ifrbde.viw_hst_justificativa_sp
                     (num_seq_justificativa,
                      num_seq_resumo_just,
                      ds_justificativa,
                      dat_inclusao,
                      dat_processamento
                     )
              VALUES (v_num_seq_justificativa,
                      v_num_seq_resumo_just,
                      v_ds_justificativa,
                      v_dat_inclusao,
                      v_dat_processamento
                     );

         IF SQL%ROWCOUNT = 1 THEN
            stp_pesquisa_hst_justificativa (p_usuario,
                                            vo_num_seq_justificativa,
                                            vo_num_seq_resumo_just,
                                            vo_ds_justificativa,
                                            vo_dat_inclusao,
                                            vo_dat_processamento,
                                            v_num_seq_justificativa
                                           );
            v_dado :=
               'num_seq_justificativa = ' || TO_CHAR (v_num_seq_justificativa);
            v_dado :=
               v_dado
               || ','
               || 'num_seq_resumo_just = '
               || TO_CHAR (v_num_seq_resumo_just);
            v_dado :=
               v_dado
               || ','
               || 'ds_justificativa = '
               || RTRIM (LTRIM (v_ds_justificativa));
            v_dado :=
               v_dado
               || ','
               || 'dat_inclusao = '
               || TO_CHAR (v_dat_inclusao, 'DD/MM/YYYY');
            v_dado :=
               v_dado
               || ','
               || 'dat_processamento = '
               || TO_CHAR (v_dat_processamento, 'DD/MM/YYYY');
            -- LOG
            ifrseg.pck_seguranca.stp_log (p_usuario,
                                          'VIW_HST_JUSTIFICATIVA_SP',
                                          'I',
                                          v_dado
                                         );
            COMMIT;
         ELSE
            ROLLBACK;
         END IF;
      END IF;
   EXCEPTION
      WHEN OTHERS THEN
         raise_application_error (-20100, SQLERRM);
   END;

--------------------------------------------------------------------
-- Altera Justificativa SP
-- retorna o recordset correspondente
   PROCEDURE stp_altera_hst_justificativa_s (
      p_usuario                  IN       VARCHAR2,
      vo_num_seq_justificativa   OUT      tyt_num_seq_justificativa,
      vo_num_seq_resumo_just     OUT      tyt_num_seq_resumo_just,
      vo_ds_justificativa        OUT      tyt_ds_justificativa,
      vo_dat_inclusao            OUT      tyt_dat_inclusao,
      vo_dat_processamento       OUT      tyt_dat_processamento,
      vi_num_seq_justificativa   IN       t_num_seq_justificativa,
      vi_num_seq_resumo_just     IN       t_num_seq_resumo_just,
      vi_ds_justificativa        IN       t_ds_justificativa,
      vi_dat_inclusao            IN       t_dat_inclusao,
      vi_dat_processamento       IN       t_dat_processamento
   ) AS
      CURSOR c_cursor IS
         SELECT     *
               FROM ifrbde.viw_hst_justificativa_sp
              WHERE num_seq_justificativa = vi_num_seq_justificativa
         FOR UPDATE;

      v_viw_hst_justificativa_sp    ifrbde.viw_hst_justificativa_sp%ROWTYPE;
      v_num_seq_justificativa       ifrbde.viw_hst_justificativa_sp.num_seq_justificativa%TYPE;
      v_num_seq_resumo_just         ifrbde.viw_hst_justificativa_sp.num_seq_resumo_just%TYPE;
      v_ds_justificativa            ifrbde.viw_hst_justificativa_sp.ds_justificativa%TYPE;
      v_dat_inclusao                ifrbde.viw_hst_justificativa_sp.dat_inclusao%TYPE;
      v_dat_processamento           ifrbde.viw_hst_justificativa_sp.dat_processamento%TYPE;
      v_dado                        VARCHAR2 (4000) := NULL;
   BEGIN
      IF ifrseg.pck_seguranca.stf_permitido (p_usuario,
                                             'VIW_HST_JUSTIFICATIVA_SP',
                                             'ALTERA'
                                            ) THEN
         OPEN c_cursor;

         FETCH c_cursor
          INTO v_viw_hst_justificativa_sp;

         IF NOT c_cursor%NOTFOUND THEN
            v_ds_justificativa := RTRIM (LTRIM (vi_ds_justificativa));
            v_dat_inclusao := TO_DATE (vi_dat_inclusao, 'DD/MM/YYYY');
            v_dat_processamento :=
                                 TO_DATE (vi_dat_processamento, 'DD/MM/YYYY');
            v_num_seq_justificativa := vi_num_seq_justificativa;
            v_num_seq_resumo_just := vi_num_seq_resumo_just;

            UPDATE ifrbde.viw_hst_justificativa_sp
               SET num_seq_resumo_just = v_num_seq_resumo_just,
                   ds_justificativa = v_ds_justificativa,
                   dat_inclusao = v_dat_inclusao,
                   dat_processamento = v_dat_processamento
             WHERE CURRENT OF c_cursor;

            IF SQL%ROWCOUNT = 1 THEN
               stp_pesquisa_hst_justificativa (p_usuario,
                                               vo_num_seq_justificativa,
                                               vo_num_seq_resumo_just,
                                               vo_ds_justificativa,
                                               vo_dat_inclusao,
                                               vo_dat_processamento,
                                               vi_num_seq_justificativa
                                              );
               v_dado :=
                  'num_seq_justificativa = '
                  || TO_CHAR (v_num_seq_justificativa);
               v_dado :=
                  v_dado
                  || ','
                  || 'num_seq_resumo_just = '
                  || TO_CHAR (v_num_seq_resumo_just);
               v_dado :=
                  v_dado
                  || ','
                  || 'ds_justificativa = '
                  || RTRIM (LTRIM (v_ds_justificativa));
               v_dado :=
                  v_dado
                  || ','
                  || 'dat_inclusao = '
                  || TO_CHAR (v_dat_inclusao, 'DD/MM/YYYY');
               v_dado :=
                  v_dado
                  || ','
                  || 'dat_processamento = '
                  || TO_CHAR (v_dat_processamento, 'DD/MM/YYYY');
               -- LOG
               ifrseg.pck_seguranca.stp_log (p_usuario,
                                             'VIW_HST_JUSTIFICATIVA_SP',
                                             'A',
                                             v_dado
                                            );
               COMMIT;
            ELSE
               ROLLBACK;
            END IF;
         END IF;
      END IF;
   EXCEPTION
      WHEN OTHERS THEN
         raise_application_error (-20100, SQLERRM);
   END;

--------------------------------------------------------------------
-- Pesquisa Certificar SP
-- retorna o recordset correspondente
   PROCEDURE stp_pesquisa_certifica_sp (
      p_usuario                  IN       VARCHAR2,
      vo_num_seq_resumo_pag      OUT      tyt_num_seq_resumo_pag,
      vo_cnt_cre_cod             OUT      tyt_cnt_cre_cod,
      vo_cnt_cod                 OUT      tyt_cnt_cod,
      vo_num_fatura_rp           OUT      tyt_num_fatura_rp,
      vo_dat_pagamento           OUT      tyt_dat_pagamento,
      vo_val_pagamento_rp        OUT      tyt_val_pagamento_rp,
      vo_val_glosa_rp            OUT      tyt_val_glosa_rp,
      vo_tip_situacao_pag        OUT      tyt_tip_situacao_pag,
      vi_num_seq_resumo_pag      IN       t_num_seq_resumo_pag
   ) AS
   BEGIN
      IF ifrseg.pck_seguranca.stf_permitido (p_usuario,
                                             'VIW_CERTIFICA_SP',
                                             'PESQUISA'
                                            ) THEN
         SELECT num_seq_resumo_pag,
                cnt_cre_cod,
                cnt_cod,
                num_fatura_rp,
                dat_pagamento,
                val_pagamento_rp,
                val_glosa_rp,
                tip_situacao_pag
           INTO vo_num_seq_resumo_pag (1),
                vo_cnt_cre_cod (1),
                vo_cnt_cod (1),
                vo_num_fatura_rp (1),
                vo_dat_pagamento (1),
                vo_val_pagamento_rp (1),
                vo_val_glosa_rp (1),
                vo_tip_situacao_pag (1)
           FROM ifrbde.viw_certifica_sp
          WHERE num_seq_resumo_pag = vi_num_seq_resumo_pag;
      END IF;
   EXCEPTION
      WHEN OTHERS THEN
         raise_application_error (-20100, SQLERRM);
   END;

   -- Exclui Certificar SP
   -- retorna o OK ou não
   PROCEDURE stp_exclui_certifica_sp (
      p_usuario                  IN       VARCHAR2,
      vo_ok                      OUT      tyt_ok,
      vi_num_seq_resumo_pag      IN       t_num_seq_resumo_pag
   ) AS
      CURSOR c_cursor IS
         SELECT     *
               FROM ifrbde.viw_certifica_sp
              WHERE num_seq_resumo_pag = vi_num_seq_resumo_pag
         FOR UPDATE;

      v_viw_certifica_sp            ifrbde.viw_certifica_sp%ROWTYPE;
      v_dado                        VARCHAR2 (4000) := NULL;
   BEGIN
      vo_ok (1) := 0;

      IF ifrseg.pck_seguranca.stf_permitido (p_usuario,
                                             'VIW_CERTIFICA_SP',
                                             'EXCLUI'
                                            ) THEN
         OPEN c_cursor;

         FETCH c_cursor
          INTO v_viw_certifica_sp;

         IF NOT c_cursor%NOTFOUND THEN
            v_dado :=
               'num_seq_resumo_pag = '
               || TO_CHAR (v_viw_certifica_sp.num_seq_resumo_pag);
            v_dado :=
               v_dado
               || ','
               || 'cnt_cre_cod = '
               || TO_CHAR (v_viw_certifica_sp.cnt_cre_cod);
            v_dado :=
               v_dado
               || ','
               || 'cnt_cod = '
               || RTRIM (LTRIM (UPPER (v_viw_certifica_sp.cnt_cod)));
            v_dado :=
               v_dado
               || ','
               || 'num_fatura_rp = '
               || RTRIM (LTRIM (UPPER (v_viw_certifica_sp.num_fatura_rp)));
            v_dado :=
               v_dado
               || ','
               || 'dat_pagamento = '
               || TO_DATE (v_viw_certifica_sp.dat_pagamento, 'DD/MM/YYYY');
            v_dado :=
               v_dado
               || ','
               || 'val_pagamento_rp = '
               || TO_CHAR (v_viw_certifica_sp.val_pagamento_rp);
            v_dado :=
               v_dado
               || ','
               || 'val_glosa_rp = '
               || TO_CHAR (v_viw_certifica_sp.val_glosa_rp);
            v_dado :=
               v_dado
               || ','
               || 'tip_situacao_pag = '
               || TO_CHAR (v_viw_certifica_sp.tip_situacao_pag);

            IF c_cursor%ROWCOUNT = 1 THEN
               vo_ok (1) := 1;
               -- LOG
               ifrseg.pck_seguranca.stp_log (p_usuario,
                                             'VIW_CERTIFICA_SP',
                                             'E',
                                             v_dado
                                            );

               DELETE FROM ifrbde.viw_certifica_sp
                     WHERE CURRENT OF c_cursor;

               IF c_cursor%ROWCOUNT = 1 THEN
                  vo_ok (1) := 1;
                  COMMIT;
               ELSIF c_cursor%ROWCOUNT > 1 THEN
                  ROLLBACK;
               END IF;
            END IF;
         END IF;
      END IF;
   EXCEPTION
      WHEN OTHERS THEN
         raise_application_error (-20100, SQLERRM);
   END;

--------------------------------------------------------------------
-- Inclui Certificar SP
-- retorna o recordset correspondente
   PROCEDURE stp_inclui_certifica_sp (
      p_usuario                  IN       VARCHAR2,
      vo_num_seq_resumo_pag      OUT      tyt_num_seq_resumo_pag,
      vo_cnt_cre_cod             OUT      tyt_cnt_cre_cod,
      vo_cnt_cod                 OUT      tyt_cnt_cod,
      vo_num_fatura_rp           OUT      tyt_num_fatura_rp,
      vo_dat_pagamento           OUT      tyt_dat_pagamento,
      vo_val_pagamento_rp        OUT      tyt_val_pagamento_rp,
      vo_val_glosa_rp            OUT      tyt_val_glosa_rp,
      vo_tip_situacao_pag        OUT      tyt_tip_situacao_pag,
      vi_num_seq_resumo_pag      IN       t_num_seq_resumo_pag,
      vi_cnt_cre_cod             IN       t_cnt_cre_cod,
      vi_cnt_cod                 IN       t_cnt_cod,
      vi_num_fatura_rp           IN       t_num_fatura_rp,
      vi_dat_pagamento           IN       t_dat_pagamento,
      vi_val_pagamento_rp        IN       t_val_pagamento_rp,
      vi_val_glosa_rp            IN       t_val_glosa_rp,
      vi_tip_situacao_pag        IN       t_tip_situacao_pag
   ) AS
      v_num_seq_resumo_pag          viw_certifica_sp.num_seq_resumo_pag%TYPE;
      v_cnt_cre_cod                 viw_certifica_sp.cnt_cre_cod%TYPE;
      v_cnt_cod                     viw_certifica_sp.cnt_cod%TYPE;
      v_num_fatura_rp               viw_certifica_sp.num_fatura_rp%TYPE;
      v_dat_pagamento               viw_certifica_sp.dat_pagamento%TYPE;
      v_val_pagamento_rp            viw_certifica_sp.val_pagamento_rp%TYPE;
      v_val_glosa_rp                viw_certifica_sp.val_glosa_rp%TYPE;
      v_tip_situacao_pag            viw_certifica_sp.tip_situacao_pag%TYPE;
      v_dado                        VARCHAR2 (4000) := NULL;
   BEGIN
      IF ifrseg.pck_seguranca.stf_permitido (p_usuario,
                                             'VIW_CERTIFICA_SP',
                                             'INCLUI'
                                            ) THEN
         v_cnt_cod := RTRIM (LTRIM (vi_cnt_cod));
         v_num_fatura_rp := RTRIM (LTRIM (vi_num_fatura_rp));
         v_dat_pagamento := TO_DATE (vi_dat_pagamento, 'DD/MM/YYYY');
         v_num_seq_resumo_pag := vi_num_seq_resumo_pag;
         v_cnt_cre_cod := vi_cnt_cre_cod;
         v_val_pagamento_rp := vi_val_pagamento_rp;
         v_val_glosa_rp := vi_val_glosa_rp;
         v_tip_situacao_pag := vi_tip_situacao_pag;

         INSERT INTO ifrbde.viw_certifica_sp
                     (num_seq_resumo_pag,
                      cnt_cre_cod,
                      cnt_cod,
                      num_fatura_rp,
                      dat_pagamento,
                      val_pagamento_rp,
                      val_glosa_rp,
                      tip_situacao_pag
                     )
              VALUES (v_num_seq_resumo_pag,
                      v_cnt_cre_cod,
                      v_cnt_cod,
                      v_num_fatura_rp,
                      v_dat_pagamento,
                      v_val_pagamento_rp,
                      v_val_glosa_rp,
                      v_tip_situacao_pag
                     );

         IF SQL%ROWCOUNT = 1 THEN
            stp_pesquisa_certifica_sp (p_usuario,
                                       vo_num_seq_resumo_pag,
                                       vo_cnt_cre_cod,
                                       vo_cnt_cod,
                                       vo_num_fatura_rp,
                                       vo_dat_pagamento,
                                       vo_val_pagamento_rp,
                                       vo_val_glosa_rp,
                                       vo_tip_situacao_pag,
                                       v_num_seq_resumo_pag
                                      );
            v_dado :=
                     'num_seq_resumo_pag = ' || TO_CHAR (v_num_seq_resumo_pag);
            v_dado :=
                  v_dado || ',' || 'cnt_cre_cod = ' || TO_CHAR (v_cnt_cre_cod);
            v_dado :=
                    v_dado || ',' || 'cnt_cod = ' || RTRIM (LTRIM (v_cnt_cod));
            v_dado :=
               v_dado
               || ','
               || 'num_fatura_rp = '
               || RTRIM (LTRIM (v_num_fatura_rp));
            v_dado :=
               v_dado
               || ','
               || 'dat_pagamento = '
               || TO_CHAR (v_dat_pagamento, 'DD/MM/YYYY');
            v_dado :=
               v_dado
               || ','
               || 'val_pagamento_rp = '
               || TO_CHAR (v_val_pagamento_rp);
            v_dado :=
                v_dado || ',' || 'val_glosa_rp = ' || TO_CHAR (v_val_glosa_rp);
            v_dado :=
               v_dado
               || ','
               || 'tip_situacao_pag = '
               || TO_CHAR (v_tip_situacao_pag);
            -- LOG
            ifrseg.pck_seguranca.stp_log (p_usuario,
                                          'VIW_CERTIFICA_SP',
                                          'I',
                                          v_dado
                                         );
            COMMIT;
         ELSE
            ROLLBACK;
         END IF;
      END IF;
   EXCEPTION
      WHEN OTHERS THEN
         raise_application_error (-20100, SQLERRM);
   END;

--------------------------------------------------------------------
-- Altera Certificar SP
-- retorna o recordset correspondente
   PROCEDURE stp_altera_certifica_sp (
      p_usuario                  IN       VARCHAR2,
      vo_num_seq_resumo_pag      OUT      tyt_num_seq_resumo_pag,
      vo_cnt_cre_cod             OUT      tyt_cnt_cre_cod,
      vo_cnt_cod                 OUT      tyt_cnt_cod,
      vo_num_fatura_rp           OUT      tyt_num_fatura_rp,
      vo_dat_pagamento           OUT      tyt_dat_pagamento,
      vo_val_pagamento_rp        OUT      tyt_val_pagamento_rp,
      vo_val_glosa_rp            OUT      tyt_val_glosa_rp,
      vo_tip_situacao_pag        OUT      tyt_tip_situacao_pag,
      vi_num_seq_resumo_pag      IN       t_num_seq_resumo_pag,
      vi_cnt_cre_cod             IN       t_cnt_cre_cod,
      vi_cnt_cod                 IN       t_cnt_cod,
      vi_num_fatura_rp           IN       t_num_fatura_rp,
      vi_dat_pagamento           IN       t_dat_pagamento,
      vi_val_pagamento_rp        IN       t_val_pagamento_rp,
      vi_val_glosa_rp            IN       t_val_glosa_rp,
      vi_tip_situacao_pag        IN       t_tip_situacao_pag
   ) AS
      CURSOR c_cursor IS
         SELECT     *
               FROM ifrbde.viw_certifica_sp
              WHERE num_seq_resumo_pag = vi_num_seq_resumo_pag
         FOR UPDATE;

      v_viw_certifica_sp            ifrbde.viw_certifica_sp%ROWTYPE;
      v_num_seq_resumo_pag          ifrbde.viw_certifica_sp.num_seq_resumo_pag%TYPE;
      v_cnt_cre_cod                 ifrbde.viw_certifica_sp.cnt_cre_cod%TYPE;
      v_cnt_cod                     ifrbde.viw_certifica_sp.cnt_cod%TYPE;
      v_num_fatura_rp               ifrbde.viw_certifica_sp.num_fatura_rp%TYPE;
      v_dat_pagamento               ifrbde.viw_certifica_sp.dat_pagamento%TYPE;
      v_val_pagamento_rp            ifrbde.viw_certifica_sp.val_pagamento_rp%TYPE;
      v_val_glosa_rp                ifrbde.viw_certifica_sp.val_glosa_rp%TYPE;
      v_tip_situacao_pag            ifrbde.viw_certifica_sp.tip_situacao_pag%TYPE;
      v_dado                        VARCHAR2 (4000) := NULL;
   BEGIN
      IF ifrseg.pck_seguranca.stf_permitido (p_usuario,
                                             'VIW_CERTIFICA_SP',
                                             'ALTERA'
                                            ) THEN
         OPEN c_cursor;

         FETCH c_cursor
          INTO v_viw_certifica_sp;

         IF NOT c_cursor%NOTFOUND THEN
            v_cnt_cod := RTRIM (LTRIM (vi_cnt_cod));
            v_num_fatura_rp := RTRIM (LTRIM (vi_num_fatura_rp));
            v_dat_pagamento := TO_DATE (vi_dat_pagamento, 'DD/MM/YYYY');
            v_num_seq_resumo_pag := vi_num_seq_resumo_pag;
            v_cnt_cre_cod := vi_cnt_cre_cod;
            v_val_pagamento_rp := vi_val_pagamento_rp;
            v_val_glosa_rp := vi_val_glosa_rp;
            v_tip_situacao_pag := vi_tip_situacao_pag;

            UPDATE ifrbde.cad_resumo_pagamento
               SET tip_situacao_pag = 2
             WHERE num_seq_resumo_pag = v_num_seq_resumo_pag;

            IF SQL%ROWCOUNT = 1 THEN
               stp_pesquisa_certifica_sp (p_usuario,
                                          vo_num_seq_resumo_pag,
                                          vo_cnt_cre_cod,
                                          vo_cnt_cod,
                                          vo_num_fatura_rp,
                                          vo_dat_pagamento,
                                          vo_val_pagamento_rp,
                                          vo_val_glosa_rp,
                                          vo_tip_situacao_pag,
                                          vi_num_seq_resumo_pag
                                         );
               v_dado :=
                     'num_seq_resumo_pag = ' || TO_CHAR (v_num_seq_resumo_pag);
               v_dado :=
                  v_dado || ',' || 'cnt_cre_cod = ' || TO_CHAR (v_cnt_cre_cod);
               v_dado :=
                    v_dado || ',' || 'cnt_cod = ' || RTRIM (LTRIM (v_cnt_cod));
               v_dado :=
                  v_dado
                  || ','
                  || 'num_fatura_rp = '
                  || RTRIM (LTRIM (v_num_fatura_rp));
               v_dado :=
                  v_dado
                  || ','
                  || 'dat_pagamento = '
                  || TO_CHAR (v_dat_pagamento, 'DD/MM/YYYY');
               v_dado :=
                  v_dado
                  || ','
                  || 'val_pagamento_rp = '
                  || TO_CHAR (v_val_pagamento_rp);
               v_dado :=
                  v_dado || ',' || 'val_glosa_rp = '
                  || TO_CHAR (v_val_glosa_rp);
               v_dado :=
                  v_dado
                  || ','
                  || 'tip_situacao_pag = '
                  || TO_CHAR (v_tip_situacao_pag);
               -- LOG
               ifrseg.pck_seguranca.stp_log (p_usuario,
                                             'VIW_CERTIFICA_SP',
                                             'A',
                                             v_dado
                                            );
               COMMIT;
            ELSE
               ROLLBACK;
            END IF;
         END IF;
      END IF;
   EXCEPTION
      WHEN OTHERS THEN
         raise_application_error (-20100, SQLERRM);
   END;

--
   --------------------------------------------------------------------
   -- Pesquisa Cronograma Realizado - SP
   -- retorna o recordset correspondente
   PROCEDURE stp_pesquisa_resumo_cronograma (
      p_usuario                  IN       VARCHAR2,
      vo_num_seq_resumo_crono    OUT      tyt_num_seq_resumo_crono,
      vo_num_seq_contrato_rc     OUT      tyt_num_seq_contrato_rc,
      vo_dat_vencimento_rc       OUT      tyt_dat_vencimento_rc,
      vo_val_resumo_crno         OUT      tyt_val_resumo_crno,
      vo_tip_resumo_crono        OUT      tyt_tip_resumo_crono,
      vo_dat_moeda_rc            OUT      tyt_dat_moeda_rc,
      vo_val_cotacao_rc          OUT      tyt_val_cotacao_rc,
      vo_val_moeda_sec_rc        OUT      tyt_val_moeda_sec_rc,
      vo_num_fatura_rc           OUT      tyt_num_fatura_rc,
      vi_num_seq_resumo_crono    IN       t_num_seq_resumo_crono,
      vi_num_seq_contrato_rc     IN       t_num_seq_contrato_rc
   ) AS
   BEGIN
      IF ifrseg.pck_seguranca.stf_permitido (p_usuario,
                                             'VIW_RESUMO_CRONOGRAMA',
                                             'PESQUISA'
                                            ) THEN
         SELECT num_seq_resumo_crono,
                num_seq_contrato_rc,
                dat_vencimento_rc,
                val_resumo_crno,
                tip_resumo_crono,
                dat_moeda_rc,
                val_cotacao_rc,
                val_moeda_sec_rc,
                num_fatura_rc
           INTO vo_num_seq_resumo_crono (1),
                vo_num_seq_contrato_rc (1),
                vo_dat_vencimento_rc (1),
                vo_val_resumo_crno (1),
                vo_tip_resumo_crono (1),
                vo_dat_moeda_rc (1),
                vo_val_cotacao_rc (1),
                vo_val_moeda_sec_rc (1),
                vo_num_fatura_rc (1)
           FROM ifrbde.viw_resumo_cronograma
          WHERE num_seq_resumo_crono = vi_num_seq_resumo_crono
            AND num_seq_contrato_rc = vi_num_seq_contrato_rc;
      END IF;
   EXCEPTION
      WHEN OTHERS THEN
         raise_application_error (-20100, SQLERRM);
   END;

   -- Exclui Cronograma Realizado - SP
   -- retorna o OK ou não
   PROCEDURE stp_exclui_resumo_cronograma (
      p_usuario                  IN       VARCHAR2,
      vo_ok                      OUT      tyt_ok,
      vi_num_seq_resumo_crono    IN       t_num_seq_resumo_crono,
      vi_num_seq_contrato_rc     IN       t_num_seq_contrato_rc
   ) AS
      CURSOR c_cursor IS
         SELECT     *
               FROM ifrbde.cad_resumo_cronograma
              WHERE num_seq_resumo_crono = vi_num_seq_resumo_crono
                AND num_seq_contrato_rc = vi_num_seq_contrato_rc
         FOR UPDATE;

      v_cad_resumo_cronograma       ifrbde.cad_resumo_cronograma%ROWTYPE;
      v_dado                        VARCHAR2 (4000) := NULL;
   BEGIN
      vo_ok (1) := 0;

      IF ifrseg.pck_seguranca.stf_permitido (p_usuario,
                                             'VIW_RESUMO_CRONOGRAMA',
                                             'EXCLUI'
                                            ) THEN
         OPEN c_cursor;

         FETCH c_cursor
          INTO v_cad_resumo_cronograma;

         IF NOT c_cursor%NOTFOUND THEN
            v_dado :=
               'num_seq_resumo_crono = '
               || TO_CHAR (v_cad_resumo_cronograma.num_seq_resumo_crono);
            v_dado :=
               v_dado
               || ','
               || 'num_seq_contrato_rc = '
               || TO_CHAR (v_cad_resumo_cronograma.num_seq_contrato_rc);
            v_dado :=
               v_dado
               || ','
               || 'dat_vencimento_rc = '
               || TO_DATE (v_cad_resumo_cronograma.dat_vencimento_rc,
                           'DD/MM/YYYY'
                          );
            v_dado :=
               v_dado
               || ','
               || 'val_resumo_crno = '
               || TO_CHAR (v_cad_resumo_cronograma.val_resumo_crno);
            v_dado :=
               v_dado
               || ','
               || 'tip_resumo_crono = '
               || RTRIM
                       (LTRIM (UPPER (v_cad_resumo_cronograma.tip_resumo_crono)
                              )
                       );
            v_dado :=
               v_dado
               || ','
               || 'dat_moeda_rc = '
               || TO_DATE (v_cad_resumo_cronograma.dat_moeda_rc, 'DD/MM/YYYY');
            v_dado :=
               v_dado
               || ','
               || 'val_cotacao_rc = '
               || TO_CHAR (v_cad_resumo_cronograma.val_cotacao_rc);
            v_dado :=
               v_dado
               || ','
               || 'val_moeda_sec_rc = '
               || TO_CHAR (v_cad_resumo_cronograma.val_moeda_sec_rc);

            IF c_cursor%ROWCOUNT = 1 THEN
               vo_ok (1) := 1;
               -- LOG
               ifrseg.pck_seguranca.stp_log (p_usuario,
                                             'VIW_RESUMO_CRONOGRAMA',
                                             'E',
                                             v_dado
                                            );

               DELETE FROM ifrbde.cad_resumo_cronograma
                     WHERE CURRENT OF c_cursor;

               IF c_cursor%ROWCOUNT = 1 THEN
--
--
-- atualiza os dados para o relatorio de cronograma de medicao - parte do cronograma de realização
--
                  ifrbde.prc_rel_cronograma_medicao (vi_num_seq_contrato_rc,
                                                     'CR'
                                                    );
--
                  vo_ok (1) := 1;
                  COMMIT;
               ELSIF c_cursor%ROWCOUNT > 1 THEN
                  ROLLBACK;
               END IF;
            END IF;
         END IF;
      END IF;
   EXCEPTION
      WHEN OTHERS THEN
         raise_application_error (-20100, SQLERRM);
   END;

--------------------------------------------------------------------
-- Inclui Cronograma Realizado - SP
-- retorna o recordset correspondente
   PROCEDURE stp_inclui_resumo_cronograma (
      p_usuario                  IN       VARCHAR2,
      vo_num_seq_resumo_crono    OUT      tyt_num_seq_resumo_crono,
      vo_num_seq_contrato_rc     OUT      tyt_num_seq_contrato_rc,
      vo_dat_vencimento_rc       OUT      tyt_dat_vencimento_rc,
      vo_val_resumo_crno         OUT      tyt_val_resumo_crno,
      vo_tip_resumo_crono        OUT      tyt_tip_resumo_crono,
      vo_dat_moeda_rc            OUT      tyt_dat_moeda_rc,
      vo_val_cotacao_rc          OUT      tyt_val_cotacao_rc,
      vo_val_moeda_sec_rc        OUT      tyt_val_moeda_sec_rc,
      vo_num_fatura_rc           OUT      tyt_num_fatura_rc,
      vi_num_seq_contrato_rc     IN       t_num_seq_contrato_rc,
      vi_dat_vencimento_rc       IN       t_dat_vencimento_rc,
      vi_val_resumo_crno         IN       t_val_resumo_crno,
      vi_tip_resumo_crono        IN       t_tip_resumo_crono,
      vi_dat_moeda_rc            IN       t_dat_moeda_rc,
      vi_val_cotacao_rc          IN       t_val_cotacao_rc
   ) AS
      v_num_seq_resumo_crono        cad_resumo_cronograma.num_seq_resumo_crono%TYPE;
      v_num_seq_contrato_rc         cad_resumo_cronograma.num_seq_contrato_rc%TYPE;
      v_dat_vencimento_rc           cad_resumo_cronograma.dat_vencimento_rc%TYPE;
      v_val_resumo_crno             cad_resumo_cronograma.val_resumo_crno%TYPE;
      v_tip_resumo_crono            cad_resumo_cronograma.tip_resumo_crono%TYPE;
      v_dat_moeda_rc                cad_resumo_cronograma.dat_moeda_rc%TYPE;
      v_val_cotacao_rc              cad_resumo_cronograma.val_cotacao_rc%TYPE;
      v_dado                        VARCHAR2 (4000) := NULL;
   BEGIN
      IF ifrseg.pck_seguranca.stf_permitido (p_usuario,
                                             'VIW_RESUMO_CRONOGRAMA',
                                             'INCLUI'
                                            ) THEN
         SELECT ifrbde.seq_num_seq_contrato.NEXTVAL
           INTO v_num_seq_resumo_crono
           FROM DUAL;

         v_tip_resumo_crono := RTRIM (LTRIM (vi_tip_resumo_crono));
         v_dat_vencimento_rc := TO_DATE (vi_dat_vencimento_rc, 'DD/MM/YYYY');
         v_dat_moeda_rc := TO_DATE (vi_dat_moeda_rc, 'DD/MM/YYYY');
         v_num_seq_contrato_rc := vi_num_seq_contrato_rc;
         v_val_resumo_crno := vi_val_resumo_crno;
         v_val_cotacao_rc := vi_val_cotacao_rc;

         INSERT INTO ifrbde.cad_resumo_cronograma
                     (num_seq_resumo_crono,
                      num_seq_contrato_rc,
                      dat_vencimento_rc,
                      val_resumo_crno,
                      tip_resumo_crono,
                      dat_moeda_rc,
                      val_cotacao_rc
                     )
              VALUES (v_num_seq_resumo_crono,
                      v_num_seq_contrato_rc,
                      v_dat_vencimento_rc,
                      v_val_resumo_crno,
                      v_tip_resumo_crono,
                      v_dat_moeda_rc,
                      v_val_cotacao_rc
                     );

         IF SQL%ROWCOUNT = 1 THEN
            stp_pesquisa_resumo_cronograma (p_usuario,
                                            vo_num_seq_resumo_crono,
                                            vo_num_seq_contrato_rc,
                                            vo_dat_vencimento_rc,
                                            vo_val_resumo_crno,
                                            vo_tip_resumo_crono,
                                            vo_dat_moeda_rc,
                                            vo_val_cotacao_rc,
                                            vo_val_moeda_sec_rc,
                                            vo_num_fatura_rc,
                                            v_num_seq_resumo_crono,
                                            v_num_seq_contrato_rc
                                           );
            v_dado :=
                 'num_seq_resumo_crono = ' || TO_CHAR (v_num_seq_resumo_crono);
            v_dado :=
               v_dado
               || ','
               || 'num_seq_contrato_rc = '
               || TO_CHAR (v_num_seq_contrato_rc);
            v_dado :=
               v_dado
               || ','
               || 'dat_vencimento_rc = '
               || TO_CHAR (v_dat_vencimento_rc, 'DD/MM/YYYY');
            v_dado :=
               v_dado
               || ','
               || 'val_resumo_crno = '
               || TO_CHAR (v_val_resumo_crno);
            v_dado :=
               v_dado
               || ','
               || 'tip_resumo_crono = '
               || RTRIM (LTRIM (v_tip_resumo_crono));
            v_dado :=
               v_dado
               || ','
               || 'dat_moeda_rc = '
               || TO_CHAR (v_dat_moeda_rc, 'DD/MM/YYYY');
            v_dado :=
               v_dado || ',' || 'val_cotacao_rc = '
               || TO_CHAR (v_val_cotacao_rc);
            -- LOG
            ifrseg.pck_seguranca.stp_log (p_usuario,
                                          'VIW_RESUMO_CRONOGRAMA',
                                          'I',
                                          v_dado
                                         );
--
--
-- atualiza os dados para o relatorio de cronograma de medicao - parte do cronograma de realização
--
            ifrbde.prc_rel_cronograma_medicao (v_num_seq_contrato_rc, 'CR');
--
            COMMIT;
         ELSE
            ROLLBACK;
         END IF;
      END IF;
   EXCEPTION
      WHEN OTHERS THEN
         raise_application_error (-20100, SQLERRM);
   END;

--------------------------------------------------------------------
-- Altera Cronograma Realizado - SP
-- retorna o recordset correspondente
   PROCEDURE stp_altera_resumo_cronograma (
      p_usuario                  IN       VARCHAR2,
      vo_num_seq_resumo_crono    OUT      tyt_num_seq_resumo_crono,
      vo_num_seq_contrato_rc     OUT      tyt_num_seq_contrato_rc,
      vo_dat_vencimento_rc       OUT      tyt_dat_vencimento_rc,
      vo_val_resumo_crno         OUT      tyt_val_resumo_crno,
      vo_tip_resumo_crono        OUT      tyt_tip_resumo_crono,
      vo_dat_moeda_rc            OUT      tyt_dat_moeda_rc,
      vo_val_cotacao_rc          OUT      tyt_val_cotacao_rc,
      vo_val_moeda_sec_rc        OUT      tyt_val_moeda_sec_rc,
      vo_num_fatura_rc           OUT      tyt_num_fatura_rc,
      vi_num_seq_resumo_crono    IN       t_num_seq_resumo_crono,
      vi_num_seq_contrato_rc     IN       t_num_seq_contrato_rc,
      vi_dat_vencimento_rc       IN       t_dat_vencimento_rc,
      vi_val_resumo_crno         IN       t_val_resumo_crno,
      vi_tip_resumo_crono        IN       t_tip_resumo_crono,
      vi_dat_moeda_rc            IN       t_dat_moeda_rc,
      vi_val_cotacao_rc          IN       t_val_cotacao_rc
   ) AS
      CURSOR c_cursor IS
         SELECT     *
               FROM ifrbde.cad_resumo_cronograma
              WHERE num_seq_resumo_crono = vi_num_seq_resumo_crono
                AND num_seq_contrato_rc = vi_num_seq_contrato_rc
         FOR UPDATE;

      v_cad_resumo_cronograma       ifrbde.cad_resumo_cronograma%ROWTYPE;
      v_num_seq_resumo_crono        ifrbde.cad_resumo_cronograma.num_seq_resumo_crono%TYPE;
      v_num_seq_contrato_rc         ifrbde.cad_resumo_cronograma.num_seq_contrato_rc%TYPE;
      v_dat_vencimento_rc           ifrbde.cad_resumo_cronograma.dat_vencimento_rc%TYPE;
      v_val_resumo_crno             ifrbde.cad_resumo_cronograma.val_resumo_crno%TYPE;
      v_tip_resumo_crono            ifrbde.cad_resumo_cronograma.tip_resumo_crono%TYPE;
      v_dat_moeda_rc                ifrbde.cad_resumo_cronograma.dat_moeda_rc%TYPE;
      v_val_cotacao_rc              ifrbde.cad_resumo_cronograma.val_cotacao_rc%TYPE;
      v_dado                        VARCHAR2 (4000) := NULL;
   BEGIN
      IF ifrseg.pck_seguranca.stf_permitido (p_usuario,
                                             'VIW_RESUMO_CRONOGRAMA',
                                             'ALTERA'
                                            ) THEN
         OPEN c_cursor;

         FETCH c_cursor
          INTO v_cad_resumo_cronograma;

         IF NOT c_cursor%NOTFOUND THEN
            v_tip_resumo_crono := RTRIM (LTRIM (vi_tip_resumo_crono));
            v_dat_vencimento_rc :=
                                 TO_DATE (vi_dat_vencimento_rc, 'DD/MM/YYYY');
            v_dat_moeda_rc := TO_DATE (vi_dat_moeda_rc, 'DD/MM/YYYY');
            v_num_seq_resumo_crono := vi_num_seq_resumo_crono;
            v_num_seq_contrato_rc := vi_num_seq_contrato_rc;
            v_val_resumo_crno := vi_val_resumo_crno;
            v_val_cotacao_rc := vi_val_cotacao_rc;

            UPDATE ifrbde.cad_resumo_cronograma
               SET dat_vencimento_rc = v_dat_vencimento_rc,
                   val_resumo_crno = v_val_resumo_crno,
                   tip_resumo_crono = v_tip_resumo_crono,
                   dat_moeda_rc = v_dat_moeda_rc,
                   val_cotacao_rc = v_val_cotacao_rc
             WHERE CURRENT OF c_cursor;

            IF SQL%ROWCOUNT = 1 THEN
               stp_pesquisa_resumo_cronograma (p_usuario,
                                               vo_num_seq_resumo_crono,
                                               vo_num_seq_contrato_rc,
                                               vo_dat_vencimento_rc,
                                               vo_val_resumo_crno,
                                               vo_tip_resumo_crono,
                                               vo_dat_moeda_rc,
                                               vo_val_cotacao_rc,
                                               vo_val_moeda_sec_rc,
                                               vo_num_fatura_rc,
                                               vi_num_seq_resumo_crono,
                                               vi_num_seq_contrato_rc
                                              );
               v_dado :=
                  'num_seq_resumo_crono = '
                  || TO_CHAR (v_num_seq_resumo_crono);
               v_dado :=
                  v_dado
                  || ','
                  || 'num_seq_contrato_rc = '
                  || TO_CHAR (v_num_seq_contrato_rc);
               v_dado :=
                  v_dado
                  || ','
                  || 'dat_vencimento_rc = '
                  || TO_CHAR (v_dat_vencimento_rc, 'DD/MM/YYYY');
               v_dado :=
                  v_dado
                  || ','
                  || 'val_resumo_crno = '
                  || TO_CHAR (v_val_resumo_crno);
               v_dado :=
                  v_dado
                  || ','
                  || 'tip_resumo_crono = '
                  || RTRIM (LTRIM (v_tip_resumo_crono));
               v_dado :=
                  v_dado
                  || ','
                  || 'dat_moeda_rc = '
                  || TO_CHAR (v_dat_moeda_rc, 'DD/MM/YYYY');
               v_dado :=
                  v_dado
                  || ','
                  || 'val_cotacao_rc = '
                  || TO_CHAR (v_val_cotacao_rc);
               -- LOG
               ifrseg.pck_seguranca.stp_log (p_usuario,
                                             'VIW_RESUMO_CRONOGRAMA',
                                             'A',
                                             v_dado
                                            );
--
--
-- atualiza os dados para o relatorio de cronograma de medicao - parte do cronograma de realização
--
               ifrbde.prc_rel_cronograma_medicao (vi_num_seq_contrato_rc,
                                                  'CR');
--
               COMMIT;
            ELSE
               ROLLBACK;
            END IF;
         END IF;
      END IF;
   EXCEPTION
      WHEN OTHERS THEN
         raise_application_error (-20100, SQLERRM);
   END;
-- -------------------------------------------------
END;
/

-- Grants for Package Body
GRANT EXECUTE ON ifrbde.pck_cronograma TO bde_geral
/
-- End of DDL Script for Package Body IFRBDE.PCK_CRONOGRAMA

