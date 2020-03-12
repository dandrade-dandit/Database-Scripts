CREATE OR REPLACE 
PACKAGE ifrbde_views.pck_liberacao IS
   -- tipos globais

   TYPE tyt_ok IS TABLE OF NUMBER (1)
      INDEX BY BINARY_INTEGER;

   SUBTYPE t_data IS CHAR (10);

   TYPE tyt_data IS TABLE OF t_data
      INDEX BY BINARY_INTEGER;

   
--------------------------------------------------------------------------------
   --- VIW_TAB_CONTRATO
   SUBTYPE t_cnt_cre_cod IS ifrbde_views.viw_tab_contrato.cnt_cre_cod%TYPE;

   SUBTYPE t_cnt_cod IS ifrbde_views.viw_tab_contrato.cnt_cod%TYPE;

   TYPE tyt_cnt_cre_cod IS TABLE OF t_cnt_cre_cod
      INDEX BY BINARY_INTEGER;

   TYPE tyt_cnt_cod IS TABLE OF t_cnt_cod
      INDEX BY BINARY_INTEGER;

   PROCEDURE stp_pesquisa_tab_contrato (
      p_usuario                 VARCHAR2,
      vo_cnt_cre_cod   OUT      tyt_cnt_cre_cod,
      vo_cnt_cod       OUT      tyt_cnt_cod,
      vi_cnt_cre_cod   IN       t_cnt_cre_cod,
      vi_cnt_cod       IN       t_cnt_cod
   );

   PROCEDURE stp_exclui_tab_contrato (
      p_usuario                 VARCHAR2,
      vo_ok            OUT      tyt_ok,
      vi_cnt_cre_cod   IN       t_cnt_cre_cod,
      vi_cnt_cod       IN       t_cnt_cod
   );

   PROCEDURE stp_inclui_tab_contrato (
      p_usuario                 VARCHAR2,
      vo_cnt_cre_cod   OUT      tyt_cnt_cre_cod,
      vo_cnt_cod       OUT      tyt_cnt_cod,
      vi_cnt_cre_cod   IN       t_cnt_cre_cod,
      vi_cnt_cod       IN       t_cnt_cod
   );

   PROCEDURE stp_altera_tab_contrato (
      p_usuario                 VARCHAR2,
      vo_cnt_cre_cod   OUT      tyt_cnt_cre_cod,
      vo_cnt_cod       OUT      tyt_cnt_cod,
      vi_cnt_cre_cod   IN       t_cnt_cre_cod,
      vi_cnt_cod       IN       t_cnt_cod
   );

   
--------------------------------------------------------------------------------
   --- VIW_RESUMO_PAGAMENTO_LIB
   SUBTYPE t_num_seq_resumo_pag IS ifrbde_views.viw_resumo_pagamento_lib.num_seq_resumo_pag%TYPE;

   SUBTYPE t_cnt_cre_cod_r IS ifrbde_views.viw_resumo_pagamento_lib.cnt_cre_cod_r%TYPE;

   SUBTYPE t_cnt_cod_r IS ifrbde_views.viw_resumo_pagamento_lib.cnt_cod_r%TYPE;

   SUBTYPE t_num_fatura_rp IS ifrbde_views.viw_resumo_pagamento_lib.num_fatura_rp%TYPE;

   SUBTYPE t_cod_tipo_pag_r IS ifrbde_views.viw_resumo_pagamento_lib.cod_tipo_pag_r%TYPE;

   SUBTYPE t_val_pagamento_rp IS ifrbde_views.viw_resumo_pagamento_lib.val_pagamento_rp%TYPE;

   SUBTYPE t_dat_pagamento IS t_data;

   TYPE tyt_num_seq_resumo_pag IS TABLE OF t_num_seq_resumo_pag
      INDEX BY BINARY_INTEGER;

   TYPE tyt_cnt_cre_cod_r IS TABLE OF t_cnt_cre_cod_r
      INDEX BY BINARY_INTEGER;

   TYPE tyt_cnt_cod_r IS TABLE OF t_cnt_cod_r
      INDEX BY BINARY_INTEGER;

   TYPE tyt_num_fatura_rp IS TABLE OF t_num_fatura_rp
      INDEX BY BINARY_INTEGER;

   TYPE tyt_cod_tipo_pag_r IS TABLE OF t_cod_tipo_pag_r
      INDEX BY BINARY_INTEGER;

   TYPE tyt_val_pagamento_rp IS TABLE OF t_val_pagamento_rp
      INDEX BY BINARY_INTEGER;

   TYPE tyt_dat_pagamento IS TABLE OF t_dat_pagamento
      INDEX BY BINARY_INTEGER;

   PROCEDURE stp_pesquisa_resumo_pagamento_ (
      p_usuario                        VARCHAR2,
      vo_num_seq_resumo_pag   OUT      tyt_num_seq_resumo_pag,
      vo_cnt_cre_cod_r        OUT      tyt_cnt_cre_cod_r,
      vo_cnt_cod_r            OUT      tyt_cnt_cod_r,
      vo_num_fatura_rp        OUT      tyt_num_fatura_rp,
      vo_cod_tipo_pag_r       OUT      tyt_cod_tipo_pag_r,
      vo_val_pagamento_rp     OUT      tyt_val_pagamento_rp,
      vo_dat_pagamento        OUT      tyt_dat_pagamento,
      vi_num_seq_resumo_pag   IN       t_num_seq_resumo_pag,
      vi_cnt_cre_cod_r        IN       t_cnt_cre_cod_r,
      vi_cnt_cod_r            IN       t_cnt_cod_r
   );

   PROCEDURE stp_exclui_resumo_pagamento_li (
      p_usuario                        VARCHAR2,
      vo_ok                   OUT      tyt_ok,
      vi_num_seq_resumo_pag   IN       t_num_seq_resumo_pag,
      vi_cnt_cre_cod_r        IN       t_cnt_cre_cod_r,
      vi_cnt_cod_r            IN       t_cnt_cod_r
   );

   PROCEDURE stp_inclui_resumo_pagamento_li (
      p_usuario                        VARCHAR2,
      vo_num_seq_resumo_pag   OUT      tyt_num_seq_resumo_pag,
      vo_cnt_cre_cod_r        OUT      tyt_cnt_cre_cod_r,
      vo_cnt_cod_r            OUT      tyt_cnt_cod_r,
      vo_num_fatura_rp        OUT      tyt_num_fatura_rp,
      vo_cod_tipo_pag_r       OUT      tyt_cod_tipo_pag_r,
      vo_val_pagamento_rp     OUT      tyt_val_pagamento_rp,
      vo_dat_pagamento        OUT      tyt_dat_pagamento,
      vi_num_seq_resumo_pag   IN       t_num_seq_resumo_pag,
      vi_cnt_cre_cod_r        IN       t_cnt_cre_cod_r,
      vi_cnt_cod_r            IN       t_cnt_cod_r,
      vi_num_fatura_rp        IN       t_num_fatura_rp,
      vi_cod_tipo_pag_r       IN       t_cod_tipo_pag_r,
      vi_val_pagamento_rp     IN       t_val_pagamento_rp,
      vi_dat_pagamento        IN       t_dat_pagamento
   );

   PROCEDURE stp_altera_resumo_pagamento_li (
      p_usuario                        VARCHAR2,
      vo_num_seq_resumo_pag   OUT      tyt_num_seq_resumo_pag,
      vo_cnt_cre_cod_r        OUT      tyt_cnt_cre_cod_r,
      vo_cnt_cod_r            OUT      tyt_cnt_cod_r,
      vo_num_fatura_rp        OUT      tyt_num_fatura_rp,
      vo_cod_tipo_pag_r       OUT      tyt_cod_tipo_pag_r,
      vo_val_pagamento_rp     OUT      tyt_val_pagamento_rp,
      vo_dat_pagamento        OUT      tyt_dat_pagamento,
      vi_num_seq_resumo_pag   IN       t_num_seq_resumo_pag,
      vi_cnt_cre_cod_r        IN       t_cnt_cre_cod_r,
      vi_cnt_cod_r            IN       t_cnt_cod_r,
      vi_num_fatura_rp        IN       t_num_fatura_rp,
      vi_cod_tipo_pag_r       IN       t_cod_tipo_pag_r,
      vi_val_pagamento_rp     IN       t_val_pagamento_rp,
      vi_dat_pagamento        IN       t_dat_pagamento
   );

   
--------------------------------------------------------------------------------
   --- VIW_AUX_LIBERACAO_SP
   SUBTYPE t_cnt_cre_cod_aux IS ifrbde_views.viw_aux_liberacao_sp.cnt_cre_cod_aux%TYPE;

   SUBTYPE t_cnt_cod_aux IS ifrbde_views.viw_aux_liberacao_sp.cnt_cod_aux%TYPE;

   SUBTYPE t_num_fatura_sp IS ifrbde_views.viw_aux_liberacao_sp.num_fatura_sp%TYPE;

   SUBTYPE t_dat_liberacao IS t_data;

   SUBTYPE t_dat_inclusao IS t_data;

   SUBTYPE t_cod_tipo_pag_rp IS ifrbde_views.viw_aux_liberacao_sp.cod_tipo_pag_rp%TYPE;

   SUBTYPE t_num_ano_realizacao IS ifrbde_views.viw_aux_liberacao_sp.num_ano_realizacao%TYPE;

   TYPE tyt_cnt_cre_cod_aux IS TABLE OF t_cnt_cre_cod_aux
      INDEX BY BINARY_INTEGER;

   TYPE tyt_cnt_cod_aux IS TABLE OF t_cnt_cod_aux
      INDEX BY BINARY_INTEGER;

   TYPE tyt_num_fatura_sp IS TABLE OF t_num_fatura_sp
      INDEX BY BINARY_INTEGER;

   TYPE tyt_dat_liberacao IS TABLE OF t_dat_liberacao
      INDEX BY BINARY_INTEGER;

   TYPE tyt_dat_inclusao IS TABLE OF t_dat_inclusao
      INDEX BY BINARY_INTEGER;

   TYPE tyt_cod_tipo_pag_rp IS TABLE OF t_cod_tipo_pag_rp
      INDEX BY BINARY_INTEGER;

   TYPE tyt_num_ano_realizacao IS TABLE OF t_num_ano_realizacao
      INDEX BY BINARY_INTEGER;

   PROCEDURE stp_pesquisa_aux_liberacao_sp (
      p_usuario                        VARCHAR2,
      vo_cnt_cre_cod_aux      OUT      tyt_cnt_cre_cod_aux,
      vo_cnt_cod_aux          OUT      tyt_cnt_cod_aux,
      vo_num_fatura_sp        OUT      tyt_num_fatura_sp,
      vo_dat_liberacao        OUT      tyt_dat_liberacao,
      vo_dat_inclusao         OUT      tyt_dat_inclusao,
      vo_cod_tipo_pag_rp      OUT      tyt_cod_tipo_pag_rp,
      vo_num_ano_realizacao   OUT      tyt_num_ano_realizacao,
      vi_cnt_cre_cod_aux      IN       t_cnt_cre_cod_aux,
      vi_cnt_cod_aux          IN       t_cnt_cod_aux,
      vi_num_fatura_sp        IN       t_num_fatura_sp,
      vi_dat_liberacao        IN       t_dat_liberacao
   );

   PROCEDURE stp_exclui_aux_liberacao_sp (
      p_usuario                     VARCHAR2,
      vo_ok                OUT      tyt_ok,
      vi_cnt_cre_cod_aux   IN       t_cnt_cre_cod_aux,
      vi_cnt_cod_aux       IN       t_cnt_cod_aux,
      vi_num_fatura_sp     IN       t_num_fatura_sp,
      vi_dat_liberacao     IN       t_dat_liberacao
   );

   PROCEDURE stp_inclui_aux_liberacao_sp (
      p_usuario                        VARCHAR2,
      vo_cnt_cre_cod_aux      OUT      tyt_cnt_cre_cod_aux,
      vo_cnt_cod_aux          OUT      tyt_cnt_cod_aux,
      vo_num_fatura_sp        OUT      tyt_num_fatura_sp,
      vo_dat_liberacao        OUT      tyt_dat_liberacao,
      vo_dat_inclusao         OUT      tyt_dat_inclusao,
      vo_cod_tipo_pag_rp      OUT      tyt_cod_tipo_pag_rp,
      vo_num_ano_realizacao   OUT      tyt_num_ano_realizacao,
      vi_cnt_cre_cod_aux      IN       t_cnt_cre_cod_aux,
      vi_cnt_cod_aux          IN       t_cnt_cod_aux,
      vi_num_fatura_sp        IN       t_num_fatura_sp,
      vi_dat_liberacao        IN       t_dat_liberacao,
      vi_dat_inclusao         IN       t_dat_inclusao,
      vi_cod_tipo_pag_rp      IN       t_cod_tipo_pag_rp,
      vi_num_ano_realizacao   IN       t_num_ano_realizacao
   );

   PROCEDURE stp_altera_aux_liberacao_sp (
      p_usuario                        VARCHAR2,
      vo_cnt_cre_cod_aux      OUT      tyt_cnt_cre_cod_aux,
      vo_cnt_cod_aux          OUT      tyt_cnt_cod_aux,
      vo_num_fatura_sp        OUT      tyt_num_fatura_sp,
      vo_dat_liberacao        OUT      tyt_dat_liberacao,
      vo_dat_inclusao         OUT      tyt_dat_inclusao,
      vo_cod_tipo_pag_rp      OUT      tyt_cod_tipo_pag_rp,
      vo_num_ano_realizacao   OUT      tyt_num_ano_realizacao,
      vi_cnt_cre_cod_aux      IN       t_cnt_cre_cod_aux,
      vi_cnt_cod_aux          IN       t_cnt_cod_aux,
      vi_num_fatura_sp        IN       t_num_fatura_sp,
      vi_dat_liberacao        IN       t_dat_liberacao,
      vi_dat_inclusao         IN       t_dat_inclusao,
      vi_cod_tipo_pag_rp      IN       t_cod_tipo_pag_rp,
      vi_num_ano_realizacao   IN       t_num_ano_realizacao
   );
END; -- Package spec
/

show err

-- Grants for Package
GRANT EXECUTE ON ifrbde_views.pck_liberacao TO bde_views
/
GRANT EXECUTE ON ifrbde_views.pck_liberacao TO bde_geral
/

CREATE OR REPLACE 
PACKAGE BODY ifrbde_views.pck_liberacao IS
   
--------------------------------------------------------------------
-- Pesquisa Liberação SP - Contrato
-- retorna o recordset correspondente
   PROCEDURE stp_pesquisa_tab_contrato (
      p_usuario                 VARCHAR2,
      vo_cnt_cre_cod   OUT      tyt_cnt_cre_cod,
      vo_cnt_cod       OUT      tyt_cnt_cod,
      vi_cnt_cre_cod   IN       t_cnt_cre_cod,
      vi_cnt_cod       IN       t_cnt_cod
   ) AS
   BEGIN
      IF ifrbde_views.pck_seguranca.stf_permitido (
            p_usuario,
            'VIW_TAB_CONTRATO',
            'PESQUISA'
         ) THEN
         SELECT cnt_cre_cod,
                cnt_cod
           INTO vo_cnt_cre_cod (1),
                vo_cnt_cod (1)
           FROM ifrbde_views.viw_tab_contrato
          WHERE cnt_cre_cod = vi_cnt_cre_cod AND cnt_cod = vi_cnt_cod;
      END IF;
   EXCEPTION
      WHEN OTHERS THEN
         raise_application_error (-20100, SQLERRM);
   END;

   -- Exclui Liberação SP - Contrato
   -- retorna o OK ou nao
   PROCEDURE stp_exclui_tab_contrato (
      p_usuario                 VARCHAR2,
      vo_ok            OUT      tyt_ok,
      vi_cnt_cre_cod   IN       t_cnt_cre_cod,
      vi_cnt_cod       IN       t_cnt_cod
   ) AS
   BEGIN
      vo_ok (1) := 0;

      IF ifrbde_views.pck_seguranca.stf_permitido (
            p_usuario,
            'VIW_TAB_CONTRATO',
            'EXCLUI'
         ) THEN
         DELETE FROM ifrbde_views.viw_tab_contrato
               WHERE cnt_cre_cod = vi_cnt_cre_cod AND cnt_cod = vi_cnt_cod;

         IF SQL%ROWCOUNT = 1 THEN
            vo_ok (1) := 1;
            -- LOG
            ifrbde_views.pck_seguranca.stp_log (
               p_usuario,
               'VIW_TAB_CONTRATO',
               'E',
               TO_CHAR (vi_cnt_cre_cod) || (vi_cnt_cod)
            );
            COMMIT;
         ELSIF SQL%ROWCOUNT > 1 THEN
            ROLLBACK;
         END IF;
      END IF;
   EXCEPTION
      WHEN OTHERS THEN
         raise_application_error (-20100, SQLERRM);
   END;

   
--------------------------------------------------------------------
-- Inclui Liberação SP - Contrato
-- retorna o recordset correspondente
   PROCEDURE stp_inclui_tab_contrato (
      p_usuario                 VARCHAR2,
      vo_cnt_cre_cod   OUT      tyt_cnt_cre_cod,
      vo_cnt_cod       OUT      tyt_cnt_cod,
      vi_cnt_cre_cod   IN       t_cnt_cre_cod,
      vi_cnt_cod       IN       t_cnt_cod
   ) AS
      v_cnt_cre_cod                 viw_tab_contrato.cnt_cre_cod%TYPE;
      v_cnt_cod                     viw_tab_contrato.cnt_cod%TYPE;
   BEGIN
      IF ifrbde_views.pck_seguranca.stf_permitido (
            p_usuario,
            'VIW_TAB_CONTRATO',
            'INCLUI'
         ) THEN
         v_cnt_cod := RTRIM (LTRIM (UPPER (vi_cnt_cod)));
         v_cnt_cre_cod := vi_cnt_cre_cod;

         INSERT INTO ifrbde_views.viw_tab_contrato
                     (cnt_cre_cod,
                      cnt_cod
                     )
              VALUES (v_cnt_cre_cod,
                      v_cnt_cod
                     );

         IF SQL%ROWCOUNT = 1 THEN
            stp_pesquisa_tab_contrato (
               p_usuario,
               vo_cnt_cre_cod,
               vo_cnt_cod,
               v_cnt_cre_cod,
               v_cnt_cod
            );
            -- LOG
            ifrbde_views.pck_seguranca.stp_log (
               p_usuario,
               'VIW_TAB_CONTRATO',
               'I',
               TO_CHAR (vi_cnt_cre_cod) || (vi_cnt_cod)
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
-- Altera Liberação SP - Contrato
-- retorna o recordset correspondente
   PROCEDURE stp_altera_tab_contrato (
      p_usuario                 VARCHAR2,
      vo_cnt_cre_cod   OUT      tyt_cnt_cre_cod,
      vo_cnt_cod       OUT      tyt_cnt_cod,
      vi_cnt_cre_cod   IN       t_cnt_cre_cod,
      vi_cnt_cod       IN       t_cnt_cod
   ) AS
      CURSOR c_cursor IS
         SELECT     *
               FROM ifrbde_views.viw_tab_contrato
              WHERE cnt_cre_cod = vi_cnt_cre_cod AND cnt_cod = vi_cnt_cod
         FOR UPDATE;

      v_viw_tab_contrato            ifrbde_views.viw_tab_contrato%ROWTYPE;
      v_cnt_cre_cod                 ifrbde_views.viw_tab_contrato.cnt_cre_cod%TYPE;
      v_cnt_cod                     ifrbde_views.viw_tab_contrato.cnt_cod%TYPE;
   BEGIN
      IF ifrbde_views.pck_seguranca.stf_permitido (
            p_usuario,
            'VIW_TAB_CONTRATO',
            'ALTERA'
         ) THEN
         OPEN c_cursor;
         FETCH c_cursor INTO v_viw_tab_contrato;

         IF NOT c_cursor%NOTFOUND THEN
            v_cnt_cod := RTRIM (LTRIM (UPPER (vi_cnt_cod)));
            v_cnt_cre_cod := vi_cnt_cre_cod;

            
/*            UPDATE ifrbde_views.viw_tab_contrato
            SET
            WHERE CURRENT of c_cursor;
*/
            IF SQL%ROWCOUNT = 1 THEN
               stp_pesquisa_tab_contrato (
                  p_usuario,
                  vo_cnt_cre_cod,
                  vo_cnt_cod,
                  vi_cnt_cre_cod,
                  vi_cnt_cod
               );
               -- LOG
               ifrbde_views.pck_seguranca.stp_log (
                  p_usuario,
                  'VIW_TAB_CONTRATO',
                  'A',
                  TO_CHAR (vi_cnt_cre_cod) || (vi_cnt_cod)
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

   
/*            BEGIN
               INSERT INTO ifrbde.aux_liberacao_sp
                           (cnt_cre_cod_aux,
                            cnt_cod_aux,
                            num_fatura_sp,
                            dat_liberacao,
                            cod_tipo_pag_rp
                           )
                    VALUES (v_cnt_cre_cod_r,
                            v_cnt_cod_r,
                            v_num_fatura_rp,
                            vi_dat_liberacao,
                            v_cod_tipo_pag_r
                           );
            EXCEPTION
               WHEN DUP_VAL_ON_INDEX THEN
                  raise_application_error (
                     -20100,
                     'Liberação de SP já cadastrada!!!!'
                  );
            END;

            IF SQL%ROWCOUNT = 1 THEN
               stp_pesquisa_resumo_pagamento_ (
                  p_usuario,
                  vo_cnt_cre_cod_r,
                  vo_cnt_cod_r,
                  vo_num_fatura_rp,
                  vo_val_pagamento_rp,
                  vo_dat_pagamento,
                  vo_cod_tipo_pag_r,
                  vi_cnt_cre_cod_r,
                  vi_cnt_cod_r,
                  vi_num_fatura_rp,
                  vi_cod_tipo_pag_r
               );
               -- LOG
               ifrbde_views.pck_seguranca.stp_log (
                  p_usuario,
                  'VIW_RESUMO_PAGAMENTO_LIB',
                  'A',
                  TO_CHAR (vi_cnt_cre_cod_r)
                  || (vi_cnt_cod_r)
                  || (vi_num_fatura_rp)
                  || (vi_cod_tipo_pag_r)
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
*/
   --------------------------------------------------------------------
   -- Pesquisa Liberação SP Existente
   -- retorna o recordset correspondente
   PROCEDURE stp_pesquisa_resumo_pagamento_ (
      p_usuario                        VARCHAR2,
      vo_num_seq_resumo_pag   OUT      tyt_num_seq_resumo_pag,
      vo_cnt_cre_cod_r        OUT      tyt_cnt_cre_cod_r,
      vo_cnt_cod_r            OUT      tyt_cnt_cod_r,
      vo_num_fatura_rp        OUT      tyt_num_fatura_rp,
      vo_cod_tipo_pag_r       OUT      tyt_cod_tipo_pag_r,
      vo_val_pagamento_rp     OUT      tyt_val_pagamento_rp,
      vo_dat_pagamento        OUT      tyt_dat_pagamento,
      vi_num_seq_resumo_pag   IN       t_num_seq_resumo_pag,
      vi_cnt_cre_cod_r        IN       t_cnt_cre_cod_r,
      vi_cnt_cod_r            IN       t_cnt_cod_r
   ) AS
   BEGIN
      IF ifrbde_views.pck_seguranca.stf_permitido (
            p_usuario,
            'VIW_RESUMO_PAGAMENTO_LIB',
            'PESQUISA'
         ) THEN
         SELECT num_seq_resumo_pag,
                cnt_cre_cod_r,
                cnt_cod_r,
                num_fatura_rp,
                cod_tipo_pag_r,
                val_pagamento_rp,
                TO_CHAR (dat_pagamento, 'DD/MM/YYYY') dat_pagamento
           INTO vo_num_seq_resumo_pag (1),
                vo_cnt_cre_cod_r (1),
                vo_cnt_cod_r (1),
                vo_num_fatura_rp (1),
                vo_cod_tipo_pag_r (1),
                vo_val_pagamento_rp (1),
                vo_dat_pagamento (1)
           FROM ifrbde_views.viw_resumo_pagamento_lib
          WHERE num_seq_resumo_pag = vi_num_seq_resumo_pag
            AND cnt_cre_cod_r = vi_cnt_cre_cod_r
            AND cnt_cod_r = vi_cnt_cod_r;
      END IF;
   EXCEPTION
      WHEN OTHERS THEN
         raise_application_error (-20100, SQLERRM);
   END;

   -- Exclui Liberação SP Existente
   -- retorna o OK ou nao
   PROCEDURE stp_exclui_resumo_pagamento_li (
      p_usuario                        VARCHAR2,
      vo_ok                   OUT      tyt_ok,
      vi_num_seq_resumo_pag   IN       t_num_seq_resumo_pag,
      vi_cnt_cre_cod_r        IN       t_cnt_cre_cod_r,
      vi_cnt_cod_r            IN       t_cnt_cod_r
   ) AS
   BEGIN
      vo_ok (1) := 0;

      IF ifrbde_views.pck_seguranca.stf_permitido (
            p_usuario,
            'VIW_RESUMO_PAGAMENTO_LIB',
            'EXCLUI'
         ) THEN
         DELETE FROM ifrbde_views.viw_resumo_pagamento_lib
               WHERE num_seq_resumo_pag = vi_num_seq_resumo_pag
                 AND cnt_cre_cod_r = vi_cnt_cre_cod_r
                 AND cnt_cod_r = vi_cnt_cod_r;

         IF SQL%ROWCOUNT = 1 THEN
            vo_ok (1) := 1;
            -- LOG
            ifrbde_views.pck_seguranca.stp_log (
               p_usuario,
               'VIW_RESUMO_PAGAMENTO_LIB',
               'E',
               TO_CHAR (vi_num_seq_resumo_pag)
               || TO_CHAR (vi_cnt_cre_cod_r)
               ||  (vi_cnt_cod_r)
            );
            COMMIT;
         ELSIF SQL%ROWCOUNT > 1 THEN
            ROLLBACK;
         END IF;
      END IF;
   EXCEPTION
      WHEN OTHERS THEN
         raise_application_error (-20100, SQLERRM);
   END;

   
--------------------------------------------------------------------
-- Inclui Liberação SP Existente
-- retorna o recordset correspondente
   PROCEDURE stp_inclui_resumo_pagamento_li (
      p_usuario                        VARCHAR2,
      vo_num_seq_resumo_pag   OUT      tyt_num_seq_resumo_pag,
      vo_cnt_cre_cod_r        OUT      tyt_cnt_cre_cod_r,
      vo_cnt_cod_r            OUT      tyt_cnt_cod_r,
      vo_num_fatura_rp        OUT      tyt_num_fatura_rp,
      vo_cod_tipo_pag_r       OUT      tyt_cod_tipo_pag_r,
      vo_val_pagamento_rp     OUT      tyt_val_pagamento_rp,
      vo_dat_pagamento        OUT      tyt_dat_pagamento,
      vi_num_seq_resumo_pag   IN       t_num_seq_resumo_pag,
      vi_cnt_cre_cod_r        IN       t_cnt_cre_cod_r,
      vi_cnt_cod_r            IN       t_cnt_cod_r,
      vi_num_fatura_rp        IN       t_num_fatura_rp,
      vi_cod_tipo_pag_r       IN       t_cod_tipo_pag_r,
      vi_val_pagamento_rp     IN       t_val_pagamento_rp,
      vi_dat_pagamento        IN       t_dat_pagamento
   ) AS
      v_num_seq_resumo_pag          viw_resumo_pagamento_lib.num_seq_resumo_pag%TYPE;
      v_cnt_cre_cod_r               viw_resumo_pagamento_lib.cnt_cre_cod_r%TYPE;
      v_cnt_cod_r                   viw_resumo_pagamento_lib.cnt_cod_r%TYPE;
      v_num_fatura_rp               viw_resumo_pagamento_lib.num_fatura_rp%TYPE;
      v_cod_tipo_pag_r              viw_resumo_pagamento_lib.cod_tipo_pag_r%TYPE;
      v_val_pagamento_rp            viw_resumo_pagamento_lib.val_pagamento_rp%TYPE;
      v_dat_pagamento               viw_resumo_pagamento_lib.dat_pagamento%TYPE;
   BEGIN
      IF ifrbde_views.pck_seguranca.stf_permitido (
            p_usuario,
            'VIW_RESUMO_PAGAMENTO_LIB',
            'INCLUI'
         ) THEN
         v_cnt_cod_r := RTRIM (LTRIM (UPPER (vi_cnt_cod_r)));
         v_num_fatura_rp := RTRIM (LTRIM (UPPER (vi_num_fatura_rp)));
         v_cod_tipo_pag_r := RTRIM (LTRIM (UPPER (vi_cod_tipo_pag_r)));
         v_dat_pagamento := TO_DATE (vi_dat_pagamento, 'DD/MM/YYYY');
         v_num_seq_resumo_pag := vi_num_seq_resumo_pag;
         v_cnt_cre_cod_r := vi_cnt_cre_cod_r;
         v_val_pagamento_rp := vi_val_pagamento_rp;

         INSERT INTO ifrbde_views.viw_resumo_pagamento_lib
                     (num_seq_resumo_pag,
                      cnt_cre_cod_r,
                      cnt_cod_r,
                      num_fatura_rp,
                      cod_tipo_pag_r,
                      val_pagamento_rp,
                      dat_pagamento
                     )
              VALUES (v_num_seq_resumo_pag,
                      v_cnt_cre_cod_r,
                      v_cnt_cod_r,
                      v_num_fatura_rp,
                      v_cod_tipo_pag_r,
                      v_val_pagamento_rp,
                      v_dat_pagamento
                     );

         IF SQL%ROWCOUNT = 1 THEN
            stp_pesquisa_resumo_pagamento_ (
               p_usuario,
               vo_num_seq_resumo_pag,
               vo_cnt_cre_cod_r,
               vo_cnt_cod_r,
               vo_num_fatura_rp,
               vo_cod_tipo_pag_r,
               vo_val_pagamento_rp,
               vo_dat_pagamento,
               v_num_seq_resumo_pag,
               v_cnt_cre_cod_r,
               v_cnt_cod_r
            );
            -- LOG
            ifrbde_views.pck_seguranca.stp_log (
               p_usuario,
               'VIW_RESUMO_PAGAMENTO_LIB',
               'I',
               TO_CHAR (vi_num_seq_resumo_pag)
               || TO_CHAR (vi_cnt_cre_cod_r)
               ||  (vi_cnt_cod_r)
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
-- Altera Liberação SP Existente
-- retorna o recordset correspondente
   PROCEDURE stp_altera_resumo_pagamento_li (
      p_usuario                        VARCHAR2,
      vo_num_seq_resumo_pag   OUT      tyt_num_seq_resumo_pag,
      vo_cnt_cre_cod_r        OUT      tyt_cnt_cre_cod_r,
      vo_cnt_cod_r            OUT      tyt_cnt_cod_r,
      vo_num_fatura_rp        OUT      tyt_num_fatura_rp,
      vo_cod_tipo_pag_r       OUT      tyt_cod_tipo_pag_r,
      vo_val_pagamento_rp     OUT      tyt_val_pagamento_rp,
      vo_dat_pagamento        OUT      tyt_dat_pagamento,
      vi_num_seq_resumo_pag   IN       t_num_seq_resumo_pag,
      vi_cnt_cre_cod_r        IN       t_cnt_cre_cod_r,
      vi_cnt_cod_r            IN       t_cnt_cod_r,
      vi_num_fatura_rp        IN       t_num_fatura_rp,
      vi_cod_tipo_pag_r       IN       t_cod_tipo_pag_r,
      vi_val_pagamento_rp     IN       t_val_pagamento_rp,
      vi_dat_pagamento        IN       t_dat_pagamento
   ) AS
      CURSOR c_cursor IS
         SELECT *
           FROM ifrbde_views.viw_resumo_pagamento_lib
          WHERE num_seq_resumo_pag = vi_num_seq_resumo_pag
            AND cnt_cre_cod_r = vi_cnt_cre_cod_r
            AND cnt_cod_r = vi_cnt_cod_r;

      
--         FOR UPDATE;
      v_viw_resumo_pagamento_lib    ifrbde_views.viw_resumo_pagamento_lib%ROWTYPE;
      v_num_seq_resumo_pag          ifrbde_views.viw_resumo_pagamento_lib.num_seq_resumo_pag%TYPE;
      v_cnt_cre_cod_r               ifrbde_views.viw_resumo_pagamento_lib.cnt_cre_cod_r%TYPE;
      v_cnt_cod_r                   ifrbde_views.viw_resumo_pagamento_lib.cnt_cod_r%TYPE;
      v_num_fatura_rp               ifrbde_views.viw_resumo_pagamento_lib.num_fatura_rp%TYPE;
      v_cod_tipo_pag_r              ifrbde_views.viw_resumo_pagamento_lib.cod_tipo_pag_r%TYPE;
      v_val_pagamento_rp            ifrbde_views.viw_resumo_pagamento_lib.val_pagamento_rp%TYPE;
      v_dat_pagamento               ifrbde_views.viw_resumo_pagamento_lib.dat_pagamento%TYPE;
      vi_dat_inclusao               ifrbde_views.viw_resumo_pagamento_lib.dat_pagamento%TYPE;
      vi_dat_liberacao              ifrbde_views.viw_resumo_pagamento_lib.dat_pagamento%TYPE;
   BEGIN
      vi_dat_liberacao := TRUNC (SYSDATE);
      vi_dat_inclusao := NULL;

      IF ifrbde_views.pck_seguranca.stf_permitido (
            p_usuario,
            'VIW_RESUMO_PAGAMENTO_LIB',
            'ALTERA'
         ) THEN
         OPEN c_cursor;
         FETCH c_cursor INTO v_viw_resumo_pagamento_lib;

         IF NOT c_cursor%NOTFOUND THEN
            v_cnt_cod_r := RTRIM (LTRIM (UPPER (vi_cnt_cod_r)));
            v_num_fatura_rp := RTRIM (LTRIM (UPPER (vi_num_fatura_rp)));
            v_cod_tipo_pag_r := RTRIM (LTRIM (UPPER (vi_cod_tipo_pag_r)));
            v_dat_pagamento := TO_DATE (vi_dat_pagamento, 'DD/MM/YYYY');
            v_num_seq_resumo_pag := vi_num_seq_resumo_pag;
            v_cnt_cre_cod_r := vi_cnt_cre_cod_r;
            v_val_pagamento_rp := vi_val_pagamento_rp;

            
/*
            UPDATE ifrbde_views.viw_resumo_pagamento_lib
            SET
               num_fatura_rp = v_num_fatura_rp

               ,cod_tipo_pag_r = v_cod_tipo_pag_r

               ,val_pagamento_rp = v_val_pagamento_rp

               ,dat_pagamento = v_dat_pagamento

            WHERE CURRENT of c_cursor;
*/
            BEGIN
               INSERT INTO ifrbde.aux_liberacao_sp
                           (cnt_cre_cod_aux,
                            cnt_cod_aux,
                            num_fatura_sp,
                            dat_liberacao,
                            cod_tipo_pag_rp
                           )
                    VALUES (v_cnt_cre_cod_r,
                            v_cnt_cod_r,
                            v_num_fatura_rp,
                            vi_dat_liberacao,
                            v_cod_tipo_pag_r
                           );
            EXCEPTION
               WHEN DUP_VAL_ON_INDEX THEN
                  raise_application_error (
                     -20100,
                     'Liberação de SP já cadastrada!!!!'
                  );
            END;

            IF SQL%ROWCOUNT = 1 THEN
               stp_pesquisa_resumo_pagamento_ (
                  p_usuario,
                  vo_num_seq_resumo_pag,
                  vo_cnt_cre_cod_r,
                  vo_cnt_cod_r,
                  vo_num_fatura_rp,
                  vo_cod_tipo_pag_r,
                  vo_val_pagamento_rp,
                  vo_dat_pagamento,
                  vi_num_seq_resumo_pag,
                  vi_cnt_cre_cod_r,
                  vi_cnt_cod_r
               );
               -- LOG
               ifrbde_views.pck_seguranca.stp_log (
                  p_usuario,
                  'VIW_RESUMO_PAGAMENTO_LIB',
                  'A',
                  TO_CHAR (vi_num_seq_resumo_pag)
                  || TO_CHAR (vi_cnt_cre_cod_r)
                  ||  (vi_cnt_cod_r)
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
-- Pesquisa Liberação de SP
-- retorna o recordset correspondente
   PROCEDURE stp_pesquisa_aux_liberacao_sp (
      p_usuario                        VARCHAR2,
      vo_cnt_cre_cod_aux      OUT      tyt_cnt_cre_cod_aux,
      vo_cnt_cod_aux          OUT      tyt_cnt_cod_aux,
      vo_num_fatura_sp        OUT      tyt_num_fatura_sp,
      vo_dat_liberacao        OUT      tyt_dat_liberacao,
      vo_dat_inclusao         OUT      tyt_dat_inclusao,
      vo_cod_tipo_pag_rp      OUT      tyt_cod_tipo_pag_rp,
      vo_num_ano_realizacao   OUT      tyt_num_ano_realizacao,
      vi_cnt_cre_cod_aux      IN       t_cnt_cre_cod_aux,
      vi_cnt_cod_aux          IN       t_cnt_cod_aux,
      vi_num_fatura_sp        IN       t_num_fatura_sp,
      vi_dat_liberacao        IN       t_dat_liberacao
   ) AS
   BEGIN
      IF ifrbde_views.pck_seguranca.stf_permitido (
            p_usuario,
            'VIW_AUX_LIBERACAO_SP',
            'PESQUISA'
         ) THEN
         SELECT cnt_cre_cod_aux,
                cnt_cod_aux,
                num_fatura_sp,
                dat_liberacao,
                dat_inclusao,
                cod_tipo_pag_rp,
                num_ano_realizacao
           INTO vo_cnt_cre_cod_aux (1),
                vo_cnt_cod_aux (1),
                vo_num_fatura_sp (1),
                vo_dat_liberacao (1),
                vo_dat_inclusao (1),
                vo_cod_tipo_pag_rp (1),
                vo_num_ano_realizacao (1)
           FROM ifrbde_views.viw_aux_liberacao_sp
          WHERE cnt_cre_cod_aux = vi_cnt_cre_cod_aux
            AND cnt_cod_aux = vi_cnt_cod_aux
            AND num_fatura_sp = vi_num_fatura_sp
            AND TO_CHAR (dat_liberacao, 'DD/MM/YYYY') =
                      TO_CHAR (
                         ifrbde.fun_verificar_data (
                            TO_DATE (vi_dat_liberacao, 'DD/MM/YYYY')
                         ),
                         'DD/MM/YYYY'
                      );
      END IF;
   EXCEPTION
      WHEN OTHERS THEN
         raise_application_error (-20100, SQLERRM);
   END;

   -- Exclui Liberação de SP
   -- retorna o OK ou nao
   PROCEDURE stp_exclui_aux_liberacao_sp (
      p_usuario                     VARCHAR2,
      vo_ok                OUT      tyt_ok,
      vi_cnt_cre_cod_aux   IN       t_cnt_cre_cod_aux,
      vi_cnt_cod_aux       IN       t_cnt_cod_aux,
      vi_num_fatura_sp     IN       t_num_fatura_sp,
      vi_dat_liberacao     IN       t_dat_liberacao
   ) AS
   BEGIN
      vo_ok (1) := 0;

      IF ifrbde_views.pck_seguranca.stf_permitido (
            p_usuario,
            'VIW_AUX_LIBERACAO_SP',
            'EXCLUI'
         ) THEN
         DELETE FROM ifrbde_views.viw_aux_liberacao_sp
               WHERE cnt_cre_cod_aux = vi_cnt_cre_cod_aux
                 AND cnt_cod_aux = vi_cnt_cod_aux
                 AND num_fatura_sp = vi_num_fatura_sp
                 AND TO_CHAR (dat_liberacao, 'dd/mm/yyyy') =
                           TO_CHAR (
                              ifrbde.fun_verificar_data (
                                 TO_DATE (vi_dat_liberacao, 'DD/MM/YYYY')
                              ),
                              'DD/MM/YYYY'
                           );

         IF SQL%ROWCOUNT = 1 THEN
            vo_ok (1) := 1;
            -- LOG
            ifrbde_views.pck_seguranca.stp_log (
               p_usuario,
               'VIW_AUX_LIBERACAO_SP',
               'E',
               TO_CHAR (vi_cnt_cre_cod_aux)
               || (vi_cnt_cod_aux)
               || (vi_num_fatura_sp)
               || (vi_dat_liberacao)
            );
            COMMIT;
         ELSIF SQL%ROWCOUNT > 1 THEN
            ROLLBACK;
         END IF;
      END IF;
   EXCEPTION
      WHEN OTHERS THEN
         raise_application_error (-20100, SQLERRM);
   END;

   
--------------------------------------------------------------------
-- Inclui Liberação de SP
-- retorna o recordset correspondente
   PROCEDURE stp_inclui_aux_liberacao_sp (
      p_usuario                        VARCHAR2,
      vo_cnt_cre_cod_aux      OUT      tyt_cnt_cre_cod_aux,
      vo_cnt_cod_aux          OUT      tyt_cnt_cod_aux,
      vo_num_fatura_sp        OUT      tyt_num_fatura_sp,
      vo_dat_liberacao        OUT      tyt_dat_liberacao,
      vo_dat_inclusao         OUT      tyt_dat_inclusao,
      vo_cod_tipo_pag_rp      OUT      tyt_cod_tipo_pag_rp,
      vo_num_ano_realizacao   OUT      tyt_num_ano_realizacao,
      vi_cnt_cre_cod_aux      IN       t_cnt_cre_cod_aux,
      vi_cnt_cod_aux          IN       t_cnt_cod_aux,
      vi_num_fatura_sp        IN       t_num_fatura_sp,
      vi_dat_liberacao        IN       t_dat_liberacao,
      vi_dat_inclusao         IN       t_dat_inclusao,
      vi_cod_tipo_pag_rp      IN       t_cod_tipo_pag_rp,
      vi_num_ano_realizacao   IN       t_num_ano_realizacao
   ) AS
      v_cnt_cre_cod_aux             viw_aux_liberacao_sp.cnt_cre_cod_aux%TYPE;
      v_cnt_cod_aux                 viw_aux_liberacao_sp.cnt_cod_aux%TYPE;
      v_num_fatura_sp               viw_aux_liberacao_sp.num_fatura_sp%TYPE;
      v_dat_liberacao               viw_aux_liberacao_sp.dat_liberacao%TYPE;
      v_dat_inclusao                viw_aux_liberacao_sp.dat_inclusao%TYPE;
      v_cod_tipo_pag_rp             viw_aux_liberacao_sp.cod_tipo_pag_rp%TYPE;
      v_num_ano_realizacao          viw_aux_liberacao_sp.num_ano_realizacao%TYPE;
   BEGIN
      IF ifrbde_views.pck_seguranca.stf_permitido (
            p_usuario,
            'VIW_AUX_LIBERACAO_SP',
            'INCLUI'
         ) THEN
         v_cnt_cod_aux := RTRIM (LTRIM (UPPER (vi_cnt_cod_aux)));
         v_num_fatura_sp := RTRIM (LTRIM (UPPER (vi_num_fatura_sp)));
         v_cod_tipo_pag_rp := RTRIM (LTRIM (UPPER (vi_cod_tipo_pag_rp)));
         v_num_ano_realizacao :=
                                RTRIM (LTRIM (UPPER (vi_num_ano_realizacao)));
         v_dat_liberacao := TO_DATE (vi_dat_liberacao, 'DD/MM/YYYY');
         v_dat_inclusao := TO_DATE (vi_dat_inclusao, 'DD/MM/YYYY');
         v_cnt_cre_cod_aux := vi_cnt_cre_cod_aux;

         INSERT INTO ifrbde_views.viw_aux_liberacao_sp
                     (cnt_cre_cod_aux,
                      cnt_cod_aux,
                      num_fatura_sp,
                      dat_liberacao,
                      dat_inclusao,
                      cod_tipo_pag_rp,
                      num_ano_realizacao
                     )
              VALUES (v_cnt_cre_cod_aux,
                      v_cnt_cod_aux,
                      v_num_fatura_sp,
                      ifrbde.fun_verificar_data (
                         TO_DATE (v_dat_liberacao, 'DD/MM/YYYY')
                      ),
                      v_dat_inclusao,
                      v_cod_tipo_pag_rp,
                      v_num_ano_realizacao
                     );

         IF SQL%ROWCOUNT = 1 THEN
            stp_pesquisa_aux_liberacao_sp (
               p_usuario,
               vo_cnt_cre_cod_aux,
               vo_cnt_cod_aux,
               vo_num_fatura_sp,
               vo_dat_liberacao,
               vo_dat_inclusao,
               vo_cod_tipo_pag_rp,
               vo_num_ano_realizacao,
               v_cnt_cre_cod_aux,
               v_cnt_cod_aux,
               v_num_fatura_sp,
               v_dat_liberacao
            );
            -- LOG
            ifrbde_views.pck_seguranca.stp_log (
               p_usuario,
               'VIW_AUX_LIBERACAO_SP',
               'I',
               TO_CHAR (vi_cnt_cre_cod_aux)
               || (vi_cnt_cod_aux)
               || (vi_num_fatura_sp)
               || (vi_dat_liberacao)
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
-- Altera Liberação de SP
-- retorna o recordset correspondente
   PROCEDURE stp_altera_aux_liberacao_sp (
      p_usuario                        VARCHAR2,
      vo_cnt_cre_cod_aux      OUT      tyt_cnt_cre_cod_aux,
      vo_cnt_cod_aux          OUT      tyt_cnt_cod_aux,
      vo_num_fatura_sp        OUT      tyt_num_fatura_sp,
      vo_dat_liberacao        OUT      tyt_dat_liberacao,
      vo_dat_inclusao         OUT      tyt_dat_inclusao,
      vo_cod_tipo_pag_rp      OUT      tyt_cod_tipo_pag_rp,
      vo_num_ano_realizacao   OUT      tyt_num_ano_realizacao,
      vi_cnt_cre_cod_aux      IN       t_cnt_cre_cod_aux,
      vi_cnt_cod_aux          IN       t_cnt_cod_aux,
      vi_num_fatura_sp        IN       t_num_fatura_sp,
      vi_dat_liberacao        IN       t_dat_liberacao,
      vi_dat_inclusao         IN       t_dat_inclusao,
      vi_cod_tipo_pag_rp      IN       t_cod_tipo_pag_rp,
      vi_num_ano_realizacao   IN       t_num_ano_realizacao
   ) AS
      CURSOR c_cursor IS
         SELECT     *
               FROM ifrbde_views.viw_aux_liberacao_sp
              WHERE cnt_cre_cod_aux = vi_cnt_cre_cod_aux
                AND cnt_cod_aux = vi_cnt_cod_aux
                AND num_fatura_sp = vi_num_fatura_sp
                AND TO_CHAR (dat_liberacao, 'dd/mm/yyyy') =
                          TO_CHAR (
                             TO_DATE (vi_dat_liberacao, 'dd/mm/yyyy'),
                             'dd/mm/yyyy'
                          )
         FOR UPDATE;

      v_viw_aux_liberacao_sp        ifrbde_views.viw_aux_liberacao_sp%ROWTYPE;
      v_cnt_cre_cod_aux             ifrbde_views.viw_aux_liberacao_sp.cnt_cre_cod_aux%TYPE;
      v_cnt_cod_aux                 ifrbde_views.viw_aux_liberacao_sp.cnt_cod_aux%TYPE;
      v_num_fatura_sp               ifrbde_views.viw_aux_liberacao_sp.num_fatura_sp%TYPE;
      v_dat_liberacao               ifrbde_views.viw_aux_liberacao_sp.dat_liberacao%TYPE;
      v_dat_inclusao                ifrbde_views.viw_aux_liberacao_sp.dat_inclusao%TYPE;
      v_cod_tipo_pag_rp             ifrbde_views.viw_aux_liberacao_sp.cod_tipo_pag_rp%TYPE;
      v_num_ano_realizacao          ifrbde_views.viw_aux_liberacao_sp.num_ano_realizacao%TYPE;
   BEGIN
      IF ifrbde_views.pck_seguranca.stf_permitido (
            p_usuario,
            'VIW_AUX_LIBERACAO_SP',
            'ALTERA'
         ) THEN
         OPEN c_cursor;
         FETCH c_cursor INTO v_viw_aux_liberacao_sp;

         IF NOT c_cursor%NOTFOUND THEN
            v_cnt_cod_aux := RTRIM (LTRIM (UPPER (vi_cnt_cod_aux)));
            v_num_fatura_sp := RTRIM (LTRIM (UPPER (vi_num_fatura_sp)));
            v_cod_tipo_pag_rp := RTRIM (LTRIM (UPPER (vi_cod_tipo_pag_rp)));
            v_num_ano_realizacao :=
                                RTRIM (LTRIM (UPPER (vi_num_ano_realizacao)));
            v_dat_liberacao := TO_DATE (vi_dat_liberacao, 'DD/MM/YYYY');
            v_dat_inclusao := TO_DATE (vi_dat_inclusao, 'DD/MM/YYYY');
            v_cnt_cre_cod_aux := vi_cnt_cre_cod_aux;

            UPDATE ifrbde_views.viw_aux_liberacao_sp
               SET dat_inclusao = v_dat_inclusao,
                   cod_tipo_pag_rp = v_cod_tipo_pag_rp,
                   num_ano_realizacao = v_num_ano_realizacao
             WHERE  CURRENT OF c_cursor;

            IF SQL%ROWCOUNT = 1 THEN
               stp_pesquisa_aux_liberacao_sp (
                  p_usuario,
                  vo_cnt_cre_cod_aux,
                  vo_cnt_cod_aux,
                  vo_num_fatura_sp,
                  vo_dat_liberacao,
                  vo_dat_inclusao,
                  vo_cod_tipo_pag_rp,
                  vo_num_ano_realizacao,
                  vi_cnt_cre_cod_aux,
                  vi_cnt_cod_aux,
                  vi_num_fatura_sp,
                  vi_dat_liberacao
               );
               -- LOG
               ifrbde_views.pck_seguranca.stp_log (
                  p_usuario,
                  'VIW_AUX_LIBERACAO_SP',
                  'A',
                  TO_CHAR (vi_cnt_cre_cod_aux)
                  || (vi_cnt_cod_aux)
                  || (vi_num_fatura_sp)
                  || (vi_dat_liberacao)
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
END;
/


-- End of DDL Script for Package IFRBDE_VIEWS.PCK_LIBERACAO

show err
