CREATE OR REPLACE PACKAGE BODY pck_cronograma
AS
   
--------------------------------------------------------------------
-- Pesquisa Cronog. de Desembolso/Reajuste
-- retorna o recordset correspondente
   PROCEDURE stp_pesquisa_cont_crono_pagame (
      p_usuario                           VARCHAR2,
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
   )
   AS
   BEGIN
      IF ifrbde_views.pck_seguranca.stf_permitido (
            p_usuario,
            'TAB_CONT_CRONO_PAGAMENTO',
            'PESQUISA'
         )
      THEN
         SELECT num_seq_cronograma, num_seq_contrato_cron,
                ccp_pgose, ccp_rti_cod, ccp_data_venc,
                ccp_valor, tip_cronograma,
                dat_moeda_crono, val_cotacao_crono,
                tip_cotacao_crono, val_saldo_crono,
                val_saldo_crono_sec
           INTO vo_num_seq_cronograma (1), vo_num_seq_contrato_cron (1),
                vo_ccp_pgose (1), vo_ccp_rti_cod (1), vo_ccp_data_venc (1),
                vo_ccp_valor (1), vo_tip_cronograma (1),
                vo_dat_moeda_crono (1), vo_val_cotacao_crono (1),
                vo_tip_cotacao_crono (1), vo_val_saldo_crono (1),
                vo_val_saldo_crono_sec (1)
           FROM ifrbde_views.tab_cont_crono_pagamento
          WHERE num_seq_cronograma = vi_num_seq_cronograma
            AND num_seq_contrato_cron = vi_num_seq_contrato_cron;
      END IF;
   EXCEPTION
      WHEN OTHERS
      THEN
         raise_application_error (-20100, SQLERRM);
   END;

   -- Exclui Cronog. de Desembolso/Reajuste
   -- retorna o OK ou nao
   PROCEDURE stp_exclui_cont_crono_pagament (
      p_usuario                           VARCHAR2,
      vo_ok                      OUT      tyt_ok,
      vi_num_seq_cronograma      IN       t_num_seq_cronograma,
      vi_num_seq_contrato_cron   IN       t_num_seq_contrato_cron
   )
   AS
   BEGIN
      vo_ok (1) := 0;

      IF ifrbde_views.pck_seguranca.stf_permitido (
            p_usuario,
            'TAB_CONT_CRONO_PAGAMENTO',
            'EXCLUI'
         )
      THEN
         DELETE FROM ifrbde_views.tab_cont_crono_pagamento
               WHERE num_seq_cronograma = vi_num_seq_cronograma
                 AND num_seq_contrato_cron = vi_num_seq_contrato_cron;

         IF SQL%ROWCOUNT = 1
         THEN
            ifrbde.prc_critica_crono_contrato (vi_num_seq_contrato_cron);
            vo_ok (1) := 1;
            -- LOG
            ifrbde_views.pck_seguranca.stp_log (
               p_usuario,
               'TAB_CONT_CRONO_PAGAMENTO',
               'E',
                  TO_CHAR (vi_num_seq_cronograma)
               || TO_CHAR (vi_num_seq_contrato_cron)
            );
            COMMIT;
         ELSIF SQL%ROWCOUNT > 1
         THEN
            ROLLBACK;
         END IF;
      END IF;
   EXCEPTION
      WHEN OTHERS
      THEN
         raise_application_error (-20100, SQLERRM);
   END;

   
--------------------------------------------------------------------
-- Inclui Cronog. de Desembolso/Reajuste
-- retorna o recordset correspondente
   PROCEDURE stp_inclui_cont_crono_pagament (
      p_usuario                           VARCHAR2,
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
   )
   AS
      v_num_seq_cronograma      tab_cont_crono_pagamento.num_seq_cronograma%TYPE;
      v_num_seq_contrato_cron   tab_cont_crono_pagamento.num_seq_contrato_cron%TYPE;
      v_ccp_pgose               tab_cont_crono_pagamento.ccp_pgose%TYPE;
      v_ccp_rti_cod             tab_cont_crono_pagamento.ccp_rti_cod%TYPE;
      v_ccp_data_venc           tab_cont_crono_pagamento.ccp_data_venc%TYPE;
      v_ccp_valor               tab_cont_crono_pagamento.ccp_valor%TYPE;
      v_tip_cronograma          tab_cont_crono_pagamento.tip_cronograma%TYPE;
      v_dat_moeda_crono         tab_cont_crono_pagamento.dat_moeda_crono%TYPE;
      v_val_cotacao_crono       tab_cont_crono_pagamento.val_cotacao_crono%TYPE;
      v_tip_cotacao_crono       tab_cont_crono_pagamento.tip_cotacao_crono%TYPE;
   BEGIN
      IF ifrbde_views.pck_seguranca.stf_permitido (
            p_usuario,
            'TAB_CONT_CRONO_PAGAMENTO',
            'INCLUI'
         )
      THEN
         SELECT seq_num_seq_contrato.NEXTVAL
           INTO v_num_seq_cronograma
           FROM DUAL;

         v_ccp_pgose := RTRIM (LTRIM (UPPER (vi_ccp_pgose)));
         v_ccp_rti_cod := RTRIM (LTRIM (UPPER (vi_ccp_rti_cod)));
         v_tip_cronograma := RTRIM (LTRIM (UPPER (vi_tip_cronograma)));
         v_tip_cotacao_crono := RTRIM (LTRIM (UPPER (vi_tip_cotacao_crono)));
         v_ccp_data_venc := TO_DATE (vi_ccp_data_venc, 'DD/MM/YYYY');
         v_dat_moeda_crono := TO_DATE (vi_dat_moeda_crono, 'DD/MM/YYYY');
         v_num_seq_contrato_cron := vi_num_seq_contrato_cron;
         v_ccp_valor := vi_ccp_valor;
         v_val_cotacao_crono := vi_val_cotacao_crono;

         INSERT INTO ifrbde_views.tab_cont_crono_pagamento
                     (num_seq_cronograma, num_seq_contrato_cron,
                      ccp_pgose, ccp_rti_cod, ccp_data_venc,
                      ccp_valor, tip_cronograma, dat_moeda_crono,
                      val_cotacao_crono, tip_cotacao_crono)
              VALUES (v_num_seq_cronograma, v_num_seq_contrato_cron,
                      v_ccp_pgose, v_ccp_rti_cod, v_ccp_data_venc,
                      v_ccp_valor, v_tip_cronograma, v_dat_moeda_crono,
                      v_val_cotacao_crono, v_tip_cotacao_crono);

         IF SQL%ROWCOUNT = 1
         THEN
            ifrbde.prc_critica_crono_contrato (vi_num_seq_contrato_cron);
            stp_pesquisa_cont_crono_pagame (
               p_usuario,
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
            -- LOG
            ifrbde_views.pck_seguranca.stp_log (
               p_usuario,
               'TAB_CONT_CRONO_PAGAMENTO',
               'I',
                  TO_CHAR (v_num_seq_cronograma)
               || TO_CHAR (vi_num_seq_contrato_cron)
            );
            COMMIT;
         ELSE
            ROLLBACK;
         END IF;
      END IF;
   EXCEPTION
      WHEN OTHERS
      THEN
         raise_application_error (-20100, SQLERRM);
   END;

   
--------------------------------------------------------------------
-- Altera Cronog. de Desembolso/Reajuste
-- retorna o recordset correspondente
   PROCEDURE stp_altera_cont_crono_pagament (
      p_usuario                           VARCHAR2,
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
   )
   AS
      CURSOR c_cursor
      IS
         SELECT     *
               FROM ifrbde_views.tab_cont_crono_pagamento
              WHERE num_seq_cronograma = vi_num_seq_cronograma
                AND num_seq_contrato_cron = vi_num_seq_contrato_cron
         FOR UPDATE;

      v_tab_cont_crono_pagamento   ifrbde_views.tab_cont_crono_pagamento%ROWTYPE;
      v_num_seq_cronograma         ifrbde_views.tab_cont_crono_pagamento.num_seq_cronograma%TYPE;
      v_num_seq_contrato_cron      ifrbde_views.tab_cont_crono_pagamento.num_seq_contrato_cron%TYPE;
      v_ccp_pgose                  ifrbde_views.tab_cont_crono_pagamento.ccp_pgose%TYPE;
      v_ccp_rti_cod                ifrbde_views.tab_cont_crono_pagamento.ccp_rti_cod%TYPE;
      v_ccp_data_venc              ifrbde_views.tab_cont_crono_pagamento.ccp_data_venc%TYPE;
      v_ccp_valor                  ifrbde_views.tab_cont_crono_pagamento.ccp_valor%TYPE;
      v_tip_cronograma             ifrbde_views.tab_cont_crono_pagamento.tip_cronograma%TYPE;
      v_dat_moeda_crono            ifrbde_views.tab_cont_crono_pagamento.dat_moeda_crono%TYPE;
      v_val_cotacao_crono          ifrbde_views.tab_cont_crono_pagamento.val_cotacao_crono%TYPE;
      v_tip_cotacao_crono          ifrbde_views.tab_cont_crono_pagamento.tip_cotacao_crono%TYPE;
   BEGIN
      IF ifrbde_views.pck_seguranca.stf_permitido (
            p_usuario,
            'TAB_CONT_CRONO_PAGAMENTO',
            'ALTERA'
         )
      THEN
         OPEN c_cursor;
         FETCH c_cursor INTO v_tab_cont_crono_pagamento;

         IF NOT c_cursor%NOTFOUND
         THEN
            v_ccp_pgose := RTRIM (LTRIM (UPPER (vi_ccp_pgose)));
            v_ccp_rti_cod := RTRIM (LTRIM (UPPER (vi_ccp_rti_cod)));
            v_tip_cronograma := RTRIM (LTRIM (UPPER (vi_tip_cronograma)));
            v_tip_cotacao_crono :=
                                 RTRIM (LTRIM (UPPER (vi_tip_cotacao_crono)));
            v_ccp_data_venc := TO_DATE (vi_ccp_data_venc, 'DD/MM/YYYY');
            v_dat_moeda_crono := TO_DATE (vi_dat_moeda_crono, 'DD/MM/YYYY');
            v_num_seq_contrato_cron := vi_num_seq_contrato_cron;
            v_ccp_valor := vi_ccp_valor;
            v_val_cotacao_crono := vi_val_cotacao_crono;

            UPDATE ifrbde_views.tab_cont_crono_pagamento
               SET ccp_pgose = v_ccp_pgose,
                   ccp_rti_cod = v_ccp_rti_cod,
                   ccp_data_venc = v_ccp_data_venc,
                   ccp_valor = v_ccp_valor,
                   tip_cronograma = v_tip_cronograma,
                   dat_moeda_crono = v_dat_moeda_crono,
                   val_cotacao_crono = v_val_cotacao_crono,
                   tip_cotacao_crono = v_tip_cotacao_crono
             WHERE  CURRENT OF c_cursor;

            IF SQL%ROWCOUNT = 1
            THEN
               ifrbde.prc_critica_crono_contrato (vi_num_seq_contrato_cron);
               stp_pesquisa_cont_crono_pagame (
                  p_usuario,
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
               -- LOG
               ifrbde_views.pck_seguranca.stp_log (
                  p_usuario,
                  'TAB_CONT_CRONO_PAGAMENTO',
                  'A',
                     TO_CHAR (vi_num_seq_cronograma)
                  || TO_CHAR (vi_num_seq_contrato_cron)
               );
               COMMIT;
            ELSE
               ROLLBACK;
            END IF;
         END IF;
      END IF;
   EXCEPTION
      WHEN OTHERS
      THEN
         raise_application_error (-20100, SQLERRM);
   END;

   -- Pesquisa Situação do Contrato
   -- retorna o recordset correspondente
   PROCEDURE stp_pesquisa_situacao_contrato (
      p_usuario                           VARCHAR2,
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
   )
   AS
   BEGIN
      IF ifrbde_views.pck_seguranca.stf_permitido (
            p_usuario,
            'VIW_SITUACAO_CONTRATO',
            'PESQUISA'
         )
      THEN
         SELECT num_seq_contrato, cnt_cre_cod, cnt_cod,
                num_versao_contrato, cod_dep_contrato,
                tip_situacao_contrato, tip_contrato,
                dsc_critica_contrato
           INTO vo_num_seq_contrato (1), vo_cnt_cre_cod (1), vo_cnt_cod (1),
                vo_num_versao_contrato (1), vo_cod_dep_contrato (1),
                vo_tip_situacao_contrato (1), vo_tip_contrato (1),
                vo_dsc_critica_contrato (1)
           FROM ifrbde_views.viw_situacao_contrato
          WHERE num_seq_contrato = vi_num_seq_contrato
            AND cnt_cre_cod = vi_cnt_cre_cod;
      END IF;
   EXCEPTION
      WHEN OTHERS
      THEN
         raise_application_error (-20100, SQLERRM);
   END;

   -- Exclui Situação do Contrato
   -- retorna o OK ou nao
   PROCEDURE stp_exclui_situacao_contrato (
      p_usuario                      VARCHAR2,
      vo_ok                 OUT      tyt_ok,
      vi_num_seq_contrato   IN       t_num_seq_contrato,
      vi_cnt_cre_cod        IN       t_cnt_cre_cod
   )
   AS
   BEGIN
      vo_ok (1) := 0;

      IF ifrbde_views.pck_seguranca.stf_permitido (
            p_usuario,
            'VIW_SITUACAO_CONTRATO',
            'EXCLUI'
         )
      THEN
         
/*         DELETE FROM ifrbde_views.viw_situacao_contrato
               WHERE num_seq_contrato = vi_num_seq_contrato
                 AND cnt_cre_cod = vi_cnt_cre_cod;
*/
         IF SQL%ROWCOUNT = 1
         THEN
            vo_ok (1) := 1;
            -- LOG
            ifrbde_views.pck_seguranca.stp_log (
               p_usuario,
               'VIW_SITUACAO_CONTRATO',
               'E',
                  TO_CHAR (vi_num_seq_contrato)
               || TO_CHAR (vi_cnt_cre_cod)
            );
            COMMIT;
         ELSIF SQL%ROWCOUNT > 1
         THEN
            ROLLBACK;
         END IF;
      END IF;
   EXCEPTION
      WHEN OTHERS
      THEN
         raise_application_error (-20100, SQLERRM);
   END;

   
--------------------------------------------------------------------
-- Inclui Situação do Contrato
-- retorna o recordset correspondente
   PROCEDURE stp_inclui_situacao_contrato (
      p_usuario                           VARCHAR2,
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
   )
   AS
      v_num_seq_contrato        viw_situacao_contrato.num_seq_contrato%TYPE;
      v_cnt_cre_cod             viw_situacao_contrato.cnt_cre_cod%TYPE;
      v_cnt_cod                 viw_situacao_contrato.cnt_cod%TYPE;
      v_num_versao_contrato     viw_situacao_contrato.num_versao_contrato%TYPE;
      v_cod_dep_contrato        viw_situacao_contrato.cod_dep_contrato%TYPE;
      v_tip_situacao_contrato   viw_situacao_contrato.tip_situacao_contrato%TYPE;
      v_dsc_critica_contrato    viw_situacao_contrato.dsc_critica_contrato%TYPE;
   BEGIN
      IF ifrbde_views.pck_seguranca.stf_permitido (
            p_usuario,
            'VIW_SITUACAO_CONTRATO',
            'INCLUI'
         )
      THEN
         
/*         SELECT seq_num_seq_contrato.NEXTVAL
           INTO v_num_seq_contrato
           FROM DUAL;

         v_cnt_cod := RTRIM (LTRIM (UPPER (vi_cnt_cod)));
         v_num_versao_contrato :=
                               RTRIM (LTRIM (UPPER (vi_num_versao_contrato)));
         v_cnt_cre_cod := vi_cnt_cre_cod;
         v_cod_dep_contrato := vi_cod_dep_contrato;
         v_tip_situacao_contrato := vi_tip_situacao_contrato;
         v_dsc_critica_contrato := vi_dsc_critica_contrato;

         INSERT INTO ifrbde_views.viw_situacao_contrato
                     (num_seq_contrato, cnt_cre_cod, cnt_cod,
                      num_versao_contrato, cod_dep_contrato,
                      tip_situacao_contrato, dsc_critica_contrato)
              VALUES (v_num_seq_contrato, v_cnt_cre_cod, v_cnt_cod,
                      v_num_versao_contrato, v_cod_dep_contrato,
                      v_tip_situacao_contrato, v_dsc_critica_contrato);
*/
         IF SQL%ROWCOUNT = 1
         THEN
            stp_pesquisa_situacao_contrato (
               p_usuario,
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
            -- LOG
            ifrbde_views.pck_seguranca.stp_log (
               p_usuario,
               'VIW_SITUACAO_CONTRATO',
               'I',
                  TO_CHAR (v_num_seq_contrato)
               || TO_CHAR (vi_cnt_cre_cod)
            );
            COMMIT;
         ELSE
            ROLLBACK;
         END IF;
      END IF;
   EXCEPTION
      WHEN OTHERS
      THEN
         raise_application_error (-20100, SQLERRM);
   END;

   
--------------------------------------------------------------------
-- Altera Situação do Contrato
-- retorna o recordset correspondente
   PROCEDURE stp_altera_situacao_contrato (
      p_usuario                           VARCHAR2,
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
   )
   AS
      CURSOR c_cursor
      IS
         SELECT     *
               FROM ifrbde_views.viw_situacao_contrato
              WHERE num_seq_contrato = vi_num_seq_contrato
                AND cnt_cre_cod = vi_cnt_cre_cod
         FOR UPDATE;

      v_viw_situacao_contrato   ifrbde_views.viw_situacao_contrato%ROWTYPE;
      v_num_seq_contrato        ifrbde_views.viw_situacao_contrato.num_seq_contrato%TYPE;
      v_cnt_cre_cod             ifrbde_views.viw_situacao_contrato.cnt_cre_cod%TYPE;
      v_cnt_cod                 ifrbde_views.viw_situacao_contrato.cnt_cod%TYPE;
      v_num_versao_contrato     ifrbde_views.viw_situacao_contrato.num_versao_contrato%TYPE;
      v_cod_dep_contrato        ifrbde_views.viw_situacao_contrato.cod_dep_contrato%TYPE;
      v_tip_situacao_contrato   ifrbde_views.viw_situacao_contrato.tip_situacao_contrato%TYPE;
      v_dsc_critica_contrato    ifrbde_views.viw_situacao_contrato.dsc_critica_contrato%TYPE;
   BEGIN
      IF ifrbde_views.pck_seguranca.stf_permitido (
            p_usuario,
            'VIW_SITUACAO_CONTRATO',
            'ALTERA'
         )
      THEN
         OPEN c_cursor;
         FETCH c_cursor INTO v_viw_situacao_contrato;

         IF NOT c_cursor%NOTFOUND
         THEN
            v_cnt_cod := RTRIM (LTRIM (UPPER (vi_cnt_cod)));
            v_num_versao_contrato :=
                               RTRIM (LTRIM (UPPER (vi_num_versao_contrato)));
            v_cnt_cre_cod := vi_cnt_cre_cod;
            v_cod_dep_contrato := vi_cod_dep_contrato;
            v_tip_situacao_contrato := vi_tip_situacao_contrato;
            v_dsc_critica_contrato := vi_dsc_critica_contrato;

            UPDATE ifrbde_views.viw_situacao_contrato
               SET 
--                   cnt_cod = v_cnt_cod,
--                   num_versao_contrato = v_num_versao_contrato,
--                   cod_dep_contrato = v_cod_dep_contrato,
                   tip_situacao_contrato = v_tip_situacao_contrato,
                   dsc_critica_contrato = v_dsc_critica_contrato
             WHERE  CURRENT OF c_cursor;

            IF SQL%ROWCOUNT = 1
            THEN
               stp_pesquisa_situacao_contrato (
                  p_usuario,
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
               -- LOG
               ifrbde_views.pck_seguranca.stp_log (
                  p_usuario,
                  'VIW_SITUACAO_CONTRATO',
                  'A',
                     TO_CHAR (vi_num_seq_contrato)
                  || TO_CHAR (vi_cnt_cre_cod)
               );
               COMMIT;
            ELSE
               ROLLBACK;
            END IF;
         END IF;
      END IF;
   EXCEPTION
      WHEN OTHERS
      THEN
         raise_application_error (-20100, SQLERRM);
   END;
--------------------------------------------------------------------------------
--FIM DA PACKAGE
END;

