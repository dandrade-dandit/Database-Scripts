/* Formatted on 2005/05/25 11:12 (Formatter Plus v4.5.2) */
CREATE OR REPLACE PACKAGE BODY ifrbde.pck_orcamento
IS
   
--  
--------------------------------------------------------------------
-- Pesquisa Remanejamento
-- retorna o recordset correspondente
   PROCEDURE stp_pesquisa_remanejamento (
      p_usuario                  IN       VARCHAR2,
      vo_rmj_cod                 OUT      tyt_rmj_cod,
      vo_rmj_ano                 OUT      tyt_rmj_ano,
      vo_rmj_seq_orig            OUT      tyt_rmj_seq_orig,
      vo_rmj_rti_cod_orig        OUT      tyt_rmj_rti_cod_orig,
      vo_rmj_dep_orig            OUT      tyt_rmj_dep_orig,
      vo_val_aprovacao_origem    OUT      tyt_val_aprovacao_origem,
      vo_rmj_obj_orig            OUT      tyt_rmj_obj_orig,
      vo_rmj_seq_dest            OUT      tyt_rmj_seq_dest,
      vo_rmj_rti_cod_dest        OUT      tyt_rmj_rti_cod_dest,
      vo_rmj_dep_dest            OUT      tyt_rmj_dep_dest,
      vo_val_aprovacao_destino   OUT      tyt_val_aprovacao_destino,
      vo_rmj_obj_dest            OUT      tyt_rmj_obj_dest,
      vo_rmj_valor               OUT      tyt_rmj_valor,
      vo_dat_remanejamento       OUT      tyt_dat_remanejamento,
      vo_rmj_usuario             OUT      tyt_rmj_usuario,
      vo_dsc_justificativa       OUT      tyt_dsc_justificativa,
      vi_rmj_cod                 IN       t_rmj_cod
   )
   AS
   BEGIN
      IF ifrseg.pck_seguranca.stf_permitido (
            p_usuario,
            'VIW_REMANEJAMENTO',
            'PESQUISA'
         )
      THEN
         SELECT rmj_cod, rmj_ano, rmj_seq_orig,
                rmj_rti_cod_orig, rmj_dep_orig,
                val_aprovacao_origem, rmj_obj_orig,
                rmj_seq_dest, rmj_rti_cod_dest,
                rmj_dep_dest, val_aprovacao_destino,
                rmj_obj_dest, rmj_valor,
                dat_remanejamento, rmj_usuario,
                dsc_justificativa
           INTO vo_rmj_cod (1), vo_rmj_ano (1), vo_rmj_seq_orig (1),
                vo_rmj_rti_cod_orig (1), vo_rmj_dep_orig (1),
                vo_val_aprovacao_origem (1), vo_rmj_obj_orig (1),
                vo_rmj_seq_dest (1), vo_rmj_rti_cod_dest (1),
                vo_rmj_dep_dest (1), vo_val_aprovacao_destino (1),
                vo_rmj_obj_dest (1), vo_rmj_valor (1),
                vo_dat_remanejamento (1), vo_rmj_usuario (1),
                vo_dsc_justificativa (1)
           FROM ifrbde.viw_remanejamento
          WHERE rmj_cod = vi_rmj_cod;
      END IF;
   EXCEPTION
      WHEN OTHERS
      THEN
         raise_application_error (-20100, SQLERRM);
   END;

   -- Exclui Remanejamento
   -- retorna o OK ou não
   PROCEDURE stp_exclui_remanejamento (
      p_usuario    IN       VARCHAR2,
      vo_ok        OUT      tyt_ok,
      vi_rmj_cod   IN       t_rmj_cod
   )
   AS
      CURSOR c_cursor
      IS
         SELECT     *
               FROM ifrbde.viw_remanejamento
              WHERE rmj_cod = vi_rmj_cod
         FOR UPDATE;

      v_viw_remanejamento   ifrbde.viw_remanejamento%ROWTYPE;
      v_dado                VARCHAR2 (4000)                    := NULL;
   BEGIN
      vo_ok (1) := 0;

      IF ifrseg.pck_seguranca.stf_permitido (
            p_usuario,
            'VIW_REMANEJAMENTO',
            'EXCLUI'
         )
      THEN
         OPEN c_cursor;
         FETCH c_cursor INTO v_viw_remanejamento;

         IF NOT c_cursor%NOTFOUND
         THEN
            v_dado :=    'rmj_cod = '
                      || TO_CHAR (v_viw_remanejamento.rmj_cod);
            v_dado :=    v_dado
                      || ','
                      || 'rmj_ano = '
                      || RTRIM (LTRIM (UPPER (v_viw_remanejamento.rmj_ano)));
            v_dado :=    v_dado
                      || ','
                      || 'rmj_seq_orig = '
                      || TO_CHAR (v_viw_remanejamento.rmj_seq_orig);
            v_dado :=
                     v_dado
                  || ','
                  || 'rmj_rti_cod_orig = '
                  || RTRIM (
                        LTRIM (UPPER (v_viw_remanejamento.rmj_rti_cod_orig))
                     );
            v_dado :=    v_dado
                      || ','
                      || 'rmj_dep_orig = '
                      || TO_CHAR (v_viw_remanejamento.rmj_dep_orig);
            v_dado :=    v_dado
                      || ','
                      || 'val_aprovacao_origem = '
                      || TO_CHAR (v_viw_remanejamento.val_aprovacao_origem);
            v_dado :=    v_dado
                      || ','
                      || 'rmj_obj_orig = '
                      || RTRIM (
                            LTRIM (UPPER (v_viw_remanejamento.rmj_obj_orig))
                         );
            v_dado :=    v_dado
                      || ','
                      || 'rmj_seq_dest = '
                      || TO_CHAR (v_viw_remanejamento.rmj_seq_dest);
            v_dado :=
                     v_dado
                  || ','
                  || 'rmj_rti_cod_dest = '
                  || RTRIM (
                        LTRIM (UPPER (v_viw_remanejamento.rmj_rti_cod_dest))
                     );
            v_dado :=    v_dado
                      || ','
                      || 'rmj_dep_dest = '
                      || TO_CHAR (v_viw_remanejamento.rmj_dep_dest);
            v_dado :=    v_dado
                      || ','
                      || 'val_aprovacao_destino = '
                      || TO_CHAR (v_viw_remanejamento.val_aprovacao_destino);
            v_dado :=    v_dado
                      || ','
                      || 'rmj_obj_dest = '
                      || RTRIM (
                            LTRIM (UPPER (v_viw_remanejamento.rmj_obj_dest))
                         );
            v_dado :=    v_dado
                      || ','
                      || 'rmj_valor = '
                      || TO_CHAR (v_viw_remanejamento.rmj_valor);
            v_dado :=    v_dado
                      || ','
                      || 'dat_remanejamento = '
                      || TO_DATE (
                            v_viw_remanejamento.dat_remanejamento,
                            'DD/MM/YYYY'
                         );
            v_dado :=    v_dado
                      || ','
                      || 'rmj_usuario = '
                      || RTRIM (
                            LTRIM (UPPER (v_viw_remanejamento.rmj_usuario))
                         );
            v_dado :=
                     v_dado
                  || ','
                  || 'dsc_justificativa = '
                  || RTRIM (
                        LTRIM (UPPER (v_viw_remanejamento.dsc_justificativa))
                     );

            IF c_cursor%ROWCOUNT = 1
            THEN
               vo_ok (1) := 1;
               -- LOG
               ifrseg.pck_seguranca.stp_log (
                  p_usuario,
                  'VIW_REMANEJAMENTO',
                  'E',
                  v_dado
               );

               DELETE FROM ifrbde.tab_remanejamento
                     WHERE rmj_cod = vi_rmj_cod;

               IF c_cursor%ROWCOUNT = 1
               THEN
                  vo_ok (1) := 1;
                  COMMIT;
               ELSIF c_cursor%ROWCOUNT > 1
               THEN
                  ROLLBACK;
               END IF;
            END IF;
         END IF;
      END IF;
   EXCEPTION
      WHEN OTHERS
      THEN
         raise_application_error (-20100, SQLERRM);
   END;

   
--------------------------------------------------------------------
-- Inclui Remanejamento
-- retorna o recordset correspondente
   PROCEDURE stp_inclui_remanejamento (
      p_usuario                  IN       VARCHAR2,
      vo_rmj_cod                 OUT      tyt_rmj_cod,
      vo_rmj_ano                 OUT      tyt_rmj_ano,
      vo_rmj_seq_orig            OUT      tyt_rmj_seq_orig,
      vo_rmj_rti_cod_orig        OUT      tyt_rmj_rti_cod_orig,
      vo_rmj_dep_orig            OUT      tyt_rmj_dep_orig,
      vo_val_aprovacao_origem    OUT      tyt_val_aprovacao_origem,
      vo_rmj_obj_orig            OUT      tyt_rmj_obj_orig,
      vo_rmj_seq_dest            OUT      tyt_rmj_seq_dest,
      vo_rmj_rti_cod_dest        OUT      tyt_rmj_rti_cod_dest,
      vo_rmj_dep_dest            OUT      tyt_rmj_dep_dest,
      vo_val_aprovacao_destino   OUT      tyt_val_aprovacao_destino,
      vo_rmj_obj_dest            OUT      tyt_rmj_obj_dest,
      vo_rmj_valor               OUT      tyt_rmj_valor,
      vo_dat_remanejamento       OUT      tyt_dat_remanejamento,
      vo_rmj_usuario             OUT      tyt_rmj_usuario,
      vo_dsc_justificativa       OUT      tyt_dsc_justificativa,
      vi_rmj_ano                 IN       t_rmj_ano,
      vi_rmj_seq_orig            IN       t_rmj_seq_orig,
      vi_rmj_rti_cod_orig        IN       t_rmj_rti_cod_orig,
      vi_rmj_dep_orig            IN       t_rmj_dep_orig,
      vi_rmj_seq_dest            IN       t_rmj_seq_dest,
      vi_rmj_rti_cod_dest        IN       t_rmj_rti_cod_dest,
      vi_rmj_dep_dest            IN       t_rmj_dep_dest,
      vi_rmj_valor               IN       t_rmj_valor,
      vi_dat_remanejamento       IN       t_dat_remanejamento,
      vi_rmj_usuario             IN       t_rmj_usuario,
      vi_dsc_justificativa       IN       t_dsc_justificativa
   )
   AS
      v_rmj_cod             viw_remanejamento.rmj_cod%TYPE;
      v_rmj_ano             viw_remanejamento.rmj_ano%TYPE;
      v_rmj_seq_orig        viw_remanejamento.rmj_seq_orig%TYPE;
      v_rmj_rti_cod_orig    viw_remanejamento.rmj_rti_cod_orig%TYPE;
      v_rmj_dep_orig        viw_remanejamento.rmj_dep_orig%TYPE;
      v_rmj_seq_dest        viw_remanejamento.rmj_seq_dest%TYPE;
      v_rmj_rti_cod_dest    viw_remanejamento.rmj_rti_cod_dest%TYPE;
      v_rmj_dep_dest        viw_remanejamento.rmj_dep_dest%TYPE;
      v_rmj_valor           viw_remanejamento.rmj_valor%TYPE;
      v_dat_remanejamento   viw_remanejamento.dat_remanejamento%TYPE;
      v_rmj_usuario         viw_remanejamento.rmj_usuario%TYPE;
      v_dsc_justificativa   viw_remanejamento.dsc_justificativa%TYPE;
      v_dado                VARCHAR2 (4000)                            := NULL;
   BEGIN
      IF ifrseg.pck_seguranca.stf_permitido (
            p_usuario,
            'VIW_REMANEJAMENTO',
            'INCLUI'
         )
      THEN
         SELECT seq_rmj_cod.NEXTVAL
           INTO v_rmj_cod
           FROM DUAL;

         v_rmj_ano := RTRIM (LTRIM (vi_rmj_ano));
         v_rmj_rti_cod_orig := RTRIM (LTRIM (vi_rmj_rti_cod_orig));
         v_rmj_rti_cod_dest := RTRIM (LTRIM (vi_rmj_rti_cod_dest));
         v_rmj_usuario := RTRIM (LTRIM (vi_rmj_usuario));
         v_dsc_justificativa := RTRIM (LTRIM (vi_dsc_justificativa));
         v_dat_remanejamento := TO_DATE (vi_dat_remanejamento, 'DD/MM/YYYY');
         v_rmj_seq_orig := vi_rmj_seq_orig;
         v_rmj_dep_orig := vi_rmj_dep_orig;
         v_rmj_seq_dest := vi_rmj_seq_dest;
         v_rmj_dep_dest := vi_rmj_dep_dest;
         v_rmj_valor := vi_rmj_valor;

         INSERT INTO ifrbde.tab_remanejamento
                     (rmj_cod, rmj_ano, rmj_seq_orig,
                      rmj_rti_cod_orig
--            , rmj_dep_orig
                                      ,
                      rmj_seq_dest, rmj_rti_cod_dest
--            , rmj_dep_dest
                                                    , rmj_valor,
                      dat_remanejamento, rmj_usuario,
                      dsc_justificativa)
              VALUES (v_rmj_cod, v_rmj_ano, v_rmj_seq_orig,
                      v_rmj_rti_cod_orig --           , v_rmj_dep_orig
                                        ,
                      v_rmj_seq_dest, v_rmj_rti_cod_dest
--            , v_rmj_dep_dest
                                                        , v_rmj_valor,
                      v_dat_remanejamento, v_rmj_usuario,
                      v_dsc_justificativa);

         IF SQL%ROWCOUNT = 1
         THEN
            stp_pesquisa_remanejamento (
               p_usuario,
               vo_rmj_cod,
               vo_rmj_ano,
               vo_rmj_seq_orig,
               vo_rmj_rti_cod_orig,
               vo_rmj_dep_orig,
               vo_val_aprovacao_origem,
               vo_rmj_obj_orig,
               vo_rmj_seq_dest,
               vo_rmj_rti_cod_dest,
               vo_rmj_dep_dest,
               vo_val_aprovacao_destino,
               vo_rmj_obj_dest,
               vo_rmj_valor,
               vo_dat_remanejamento,
               vo_rmj_usuario,
               vo_dsc_justificativa,
               v_rmj_cod
            );
            v_dado :=    'rmj_cod = '
                      || TO_CHAR (v_rmj_cod);
            v_dado :=
                        v_dado
                     || ','
                     || 'rmj_ano = '
                     || RTRIM (LTRIM (v_rmj_ano));
            v_dado :=
                    v_dado
                 || ','
                 || 'rmj_seq_orig = '
                 || TO_CHAR (v_rmj_seq_orig);
            v_dado :=    v_dado
                      || ','
                      || 'rmj_rti_cod_orig = '
                      || RTRIM (LTRIM (v_rmj_rti_cod_orig));
            v_dado :=
                    v_dado
                 || ','
                 || 'rmj_dep_orig = '
                 || TO_CHAR (v_rmj_dep_orig);
            v_dado :=
                    v_dado
                 || ','
                 || 'rmj_seq_dest = '
                 || TO_CHAR (v_rmj_seq_dest);
            v_dado :=    v_dado
                      || ','
                      || 'rmj_rti_cod_dest = '
                      || RTRIM (LTRIM (v_rmj_rti_cod_dest));
            v_dado :=
                    v_dado
                 || ','
                 || 'rmj_dep_dest = '
                 || TO_CHAR (v_rmj_dep_dest);
            v_dado :=    v_dado
                      || ','
                      || 'rmj_valor = '
                      || TO_CHAR (v_rmj_valor);
            v_dado :=    v_dado
                      || ','
                      || 'dat_remanejamento = '
                      || TO_CHAR (v_dat_remanejamento, 'DD/MM/YYYY');
            v_dado :=    v_dado
                      || ','
                      || 'rmj_usuario = '
                      || RTRIM (LTRIM (v_rmj_usuario));
            v_dado :=    v_dado
                      || ','
                      || 'dsc_justificativa = '
                      || RTRIM (LTRIM (v_dsc_justificativa));
            -- LOG
            ifrseg.pck_seguranca.stp_log (
               p_usuario,
               'VIW_REMANEJAMENTO',
               'I',
               v_dado
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
-- Altera Remanejamento
-- retorna o recordset correspondente
   PROCEDURE stp_altera_remanejamento (
      p_usuario                  IN       VARCHAR2,
      vo_rmj_cod                 OUT      tyt_rmj_cod,
      vo_rmj_ano                 OUT      tyt_rmj_ano,
      vo_rmj_seq_orig            OUT      tyt_rmj_seq_orig,
      vo_rmj_rti_cod_orig        OUT      tyt_rmj_rti_cod_orig,
      vo_rmj_dep_orig            OUT      tyt_rmj_dep_orig,
      vo_val_aprovacao_origem    OUT      tyt_val_aprovacao_origem,
      vo_rmj_obj_orig            OUT      tyt_rmj_obj_orig,
      vo_rmj_seq_dest            OUT      tyt_rmj_seq_dest,
      vo_rmj_rti_cod_dest        OUT      tyt_rmj_rti_cod_dest,
      vo_rmj_dep_dest            OUT      tyt_rmj_dep_dest,
      vo_val_aprovacao_destino   OUT      tyt_val_aprovacao_destino,
      vo_rmj_obj_dest            OUT      tyt_rmj_obj_dest,
      vo_rmj_valor               OUT      tyt_rmj_valor,
      vo_dat_remanejamento       OUT      tyt_dat_remanejamento,
      vo_rmj_usuario             OUT      tyt_rmj_usuario,
      vo_dsc_justificativa       OUT      tyt_dsc_justificativa,
      vi_rmj_cod                 IN       t_rmj_cod,
      vi_rmj_ano                 IN       t_rmj_ano,
      vi_rmj_seq_orig            IN       t_rmj_seq_orig,
      vi_rmj_rti_cod_orig        IN       t_rmj_rti_cod_orig,
      vi_rmj_dep_orig            IN       t_rmj_dep_orig,
      vi_rmj_seq_dest            IN       t_rmj_seq_dest,
      vi_rmj_rti_cod_dest        IN       t_rmj_rti_cod_dest,
      vi_rmj_dep_dest            IN       t_rmj_dep_dest,
      vi_rmj_valor               IN       t_rmj_valor,
      vi_dat_remanejamento       IN       t_dat_remanejamento,
      vi_rmj_usuario             IN       t_rmj_usuario,
      vi_dsc_justificativa       IN       t_dsc_justificativa
   )
   AS
      CURSOR c_cursor
      IS
         SELECT     *
               FROM ifrbde.viw_remanejamento
              WHERE rmj_cod = vi_rmj_cod
         FOR UPDATE;

      v_viw_remanejamento   ifrbde.viw_remanejamento%ROWTYPE;
      v_rmj_cod             ifrbde.viw_remanejamento.rmj_cod%TYPE;
      v_rmj_ano             ifrbde.viw_remanejamento.rmj_ano%TYPE;
      v_rmj_seq_orig        ifrbde.viw_remanejamento.rmj_seq_orig%TYPE;
      v_rmj_rti_cod_orig    ifrbde.viw_remanejamento.rmj_rti_cod_orig%TYPE;
      v_rmj_dep_orig        ifrbde.viw_remanejamento.rmj_dep_orig%TYPE;
      v_rmj_seq_dest        ifrbde.viw_remanejamento.rmj_seq_dest%TYPE;
      v_rmj_rti_cod_dest    ifrbde.viw_remanejamento.rmj_rti_cod_dest%TYPE;
      v_rmj_dep_dest        ifrbde.viw_remanejamento.rmj_dep_dest%TYPE;
      v_rmj_valor           ifrbde.viw_remanejamento.rmj_valor%TYPE;
      v_dat_remanejamento   ifrbde.viw_remanejamento.dat_remanejamento%TYPE;
      v_rmj_usuario         ifrbde.viw_remanejamento.rmj_usuario%TYPE;
      v_dsc_justificativa   ifrbde.viw_remanejamento.dsc_justificativa%TYPE;
      v_dado                VARCHAR2 (4000)                                 := NULL;
   BEGIN
      IF ifrseg.pck_seguranca.stf_permitido (
            p_usuario,
            'VIW_REMANEJAMENTO',
            'ALTERA'
         )
      THEN
         OPEN c_cursor;
         FETCH c_cursor INTO v_viw_remanejamento;

         IF NOT c_cursor%NOTFOUND
         THEN
            v_rmj_ano := RTRIM (LTRIM (vi_rmj_ano));
            v_rmj_rti_cod_orig := RTRIM (LTRIM (vi_rmj_rti_cod_orig));
            v_rmj_rti_cod_dest := RTRIM (LTRIM (vi_rmj_rti_cod_dest));
            v_rmj_usuario := RTRIM (LTRIM (vi_rmj_usuario));
            v_dsc_justificativa := RTRIM (LTRIM (vi_dsc_justificativa));
            v_dat_remanejamento :=
                                  TO_DATE (vi_dat_remanejamento, 'DD/MM/YYYY');
            v_rmj_cod := vi_rmj_cod;
            v_rmj_seq_orig := vi_rmj_seq_orig;
            v_rmj_dep_orig := vi_rmj_dep_orig;
            v_rmj_seq_dest := vi_rmj_seq_dest;
            v_rmj_dep_dest := vi_rmj_dep_dest;
            v_rmj_valor := vi_rmj_valor;

            UPDATE ifrbde.tab_remanejamento
               SET rmj_ano = v_rmj_ano,
                   rmj_seq_orig = v_rmj_seq_orig,
                   rmj_rti_cod_orig = v_rmj_rti_cod_orig
--               ,rmj_dep_orig = v_rmj_dep_orig
                                                        ,
                   rmj_seq_dest = v_rmj_seq_dest,
                   rmj_rti_cod_dest = v_rmj_rti_cod_dest
--               ,rmj_dep_dest = v_rmj_dep_dest
                                                        ,
                   rmj_valor = v_rmj_valor,
                   dat_remanejamento = v_dat_remanejamento,
                   rmj_usuario = v_rmj_usuario,
                   dsc_justificativa = v_dsc_justificativa
             WHERE rmj_cod = v_rmj_cod;

            IF SQL%ROWCOUNT = 1
            THEN
               stp_pesquisa_remanejamento (
                  p_usuario,
                  vo_rmj_cod,
                  vo_rmj_ano,
                  vo_rmj_seq_orig,
                  vo_rmj_rti_cod_orig,
                  vo_rmj_dep_orig,
                  vo_val_aprovacao_origem,
                  vo_rmj_obj_orig,
                  vo_rmj_seq_dest,
                  vo_rmj_rti_cod_dest,
                  vo_rmj_dep_dest,
                  vo_val_aprovacao_destino,
                  vo_rmj_obj_dest,
                  vo_rmj_valor,
                  vo_dat_remanejamento,
                  vo_rmj_usuario,
                  vo_dsc_justificativa,
                  vi_rmj_cod
               );
               v_dado :=    'rmj_cod = '
                         || TO_CHAR (v_rmj_cod);
               v_dado :=
                        v_dado
                     || ','
                     || 'rmj_ano = '
                     || RTRIM (LTRIM (v_rmj_ano));
               v_dado :=    v_dado
                         || ','
                         || 'rmj_seq_orig = '
                         || TO_CHAR (v_rmj_seq_orig);
               v_dado :=    v_dado
                         || ','
                         || 'rmj_rti_cod_orig = '
                         || RTRIM (LTRIM (v_rmj_rti_cod_orig));
               v_dado :=    v_dado
                         || ','
                         || 'rmj_dep_orig = '
                         || TO_CHAR (v_rmj_dep_orig);
               v_dado :=    v_dado
                         || ','
                         || 'rmj_seq_dest = '
                         || TO_CHAR (v_rmj_seq_dest);
               v_dado :=    v_dado
                         || ','
                         || 'rmj_rti_cod_dest = '
                         || RTRIM (LTRIM (v_rmj_rti_cod_dest));
               v_dado :=    v_dado
                         || ','
                         || 'rmj_dep_dest = '
                         || TO_CHAR (v_rmj_dep_dest);
               v_dado :=
                          v_dado
                       || ','
                       || 'rmj_valor = '
                       || TO_CHAR (v_rmj_valor);
               v_dado :=    v_dado
                         || ','
                         || 'dat_remanejamento = '
                         || TO_CHAR (v_dat_remanejamento, 'DD/MM/YYYY');
               v_dado :=    v_dado
                         || ','
                         || 'rmj_usuario = '
                         || RTRIM (LTRIM (v_rmj_usuario));
               v_dado :=    v_dado
                         || ','
                         || 'dsc_justificativa = '
                         || RTRIM (LTRIM (v_dsc_justificativa));
               -- LOG
               ifrseg.pck_seguranca.stp_log (
                  p_usuario,
                  'VIW_REMANEJAMENTO',
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
      WHEN OTHERS
      THEN
         raise_application_error (-20100, SQLERRM);
   END;

   
--------------------------------------------------------------------
-- Pesquisa Associa/Desassocia Orçamento
-- retorna o recordset correspondente
   PROCEDURE stp_pesquisa_orcamento_licitac (
      p_usuario                    IN       VARCHAR2,
      vo_seq_licitacao_lic         OUT      tyt_seq_licitacao_lic,
      vo_seq_pre_compromisso_lic   OUT      tyt_seq_pre_compromisso_lic,
      vo_seq_orcamento_lic         OUT      tyt_seq_orcamento_lic,
      vi_seq_licitacao_lic         IN       t_seq_licitacao_lic,
      vi_seq_pre_compromisso_lic   IN       t_seq_pre_compromisso_lic,
      vi_seq_orcamento_lic         IN       t_seq_orcamento_lic
   )
   AS
   BEGIN
      IF ifrseg.pck_seguranca.stf_permitido (
            p_usuario,
            'VIW_ORCAMENTO_LICITACAO',
            'PESQUISA'
         )
      THEN
         SELECT seq_licitacao_lic, seq_pre_compromisso_lic,
                seq_orcamento_lic
           INTO vo_seq_licitacao_lic (1), vo_seq_pre_compromisso_lic (1),
                vo_seq_orcamento_lic (1)
           FROM ifrbde.viw_orcamento_licitacao
          WHERE seq_licitacao_lic = vi_seq_licitacao_lic
            AND seq_pre_compromisso_lic = vi_seq_pre_compromisso_lic
            AND seq_orcamento_lic = vi_seq_orcamento_lic;
      END IF;
   EXCEPTION
      WHEN OTHERS
      THEN
         raise_application_error (-20100, SQLERRM);
   END;

   -- Exclui Associa/Desassocia Orçamento
   -- retorna o OK ou não
   PROCEDURE stp_exclui_orcamento_licitacao (
      p_usuario                    IN       VARCHAR2,
      vo_ok                        OUT      tyt_ok,
      vi_seq_licitacao_lic         IN       t_seq_licitacao_lic,
      vi_seq_pre_compromisso_lic   IN       t_seq_pre_compromisso_lic,
      vi_seq_orcamento_lic         IN       t_seq_orcamento_lic
   )
   AS
      CURSOR c_cursor
      IS
         SELECT     *
               FROM ifrbde.viw_orcamento_licitacao
              WHERE seq_licitacao_lic = vi_seq_licitacao_lic
                AND seq_pre_compromisso_lic = vi_seq_pre_compromisso_lic
                AND seq_orcamento_lic = vi_seq_orcamento_lic;

      v_viw_orcamento_licitacao   ifrbde.viw_orcamento_licitacao%ROWTYPE;
      v_dado                      VARCHAR2 (4000)                          := NULL;
   BEGIN
      vo_ok (1) := 0;

      IF ifrseg.pck_seguranca.stf_permitido (
            p_usuario,
            'VIW_ORCAMENTO_LICITACAO',
            'EXCLUI'
         )
      THEN
         OPEN c_cursor;
         FETCH c_cursor INTO v_viw_orcamento_licitacao;

         IF NOT c_cursor%NOTFOUND
         THEN
            v_dado :=    'seq_licitacao_lic = '
                      || TO_CHAR (
                            v_viw_orcamento_licitacao.seq_licitacao_lic
                         );
            v_dado :=
                     v_dado
                  || ','
                  || 'seq_pre_compromisso_lic = '
                  || TO_CHAR (
                        v_viw_orcamento_licitacao.seq_pre_compromisso_lic
                     );
            v_dado :=    v_dado
                      || ','
                      || 'seq_orcamento_lic = '
                      || TO_CHAR (
                            v_viw_orcamento_licitacao.seq_orcamento_lic
                         );

            IF c_cursor%ROWCOUNT = 1
            THEN
               vo_ok (1) := 1;
               -- LOG
               ifrseg.pck_seguranca.stp_log (
                  p_usuario,
                  'VIW_ORCAMENTO_LICITACAO',
                  'E',
                  v_dado
               );
--
               ifrbde.prc_associa_orcamento_bdpu (
                  vi_seq_orcamento_lic,
                  vi_seq_licitacao_lic,
                  vi_seq_pre_compromisso_lic,
                  'D'
               );
--
               IF c_cursor%ROWCOUNT = 1
               THEN
                  vo_ok (1) := 1;
                  COMMIT;
               ELSIF c_cursor%ROWCOUNT > 1
               THEN
                  ROLLBACK;
               END IF;
            END IF;
         END IF;
      END IF;
   EXCEPTION
      WHEN OTHERS
      THEN
         raise_application_error (-20100, SQLERRM);
   END;

   
--------------------------------------------------------------------
-- Altera Associa/Desassocia Orçamento
-- retorna o recordset correspondente
   PROCEDURE stp_altera_orcamento_licitacao (
      p_usuario                    IN       VARCHAR2,
      vo_seq_licitacao_lic         OUT      tyt_seq_licitacao_lic,
      vo_seq_pre_compromisso_lic   OUT      tyt_seq_pre_compromisso_lic,
      vo_seq_orcamento_lic         OUT      tyt_seq_orcamento_lic,
      vi_seq_licitacao_lic         IN       t_seq_licitacao_lic,
      vi_seq_pre_compromisso_lic   IN       t_seq_pre_compromisso_lic,
      vi_seq_orcamento_lic         IN       t_seq_orcamento_lic
   )
   AS
      CURSOR c_cursor
      IS
         SELECT     *
               FROM ifrbde.viw_orcamento_licitacao
              WHERE seq_licitacao_lic = vi_seq_licitacao_lic
                AND seq_pre_compromisso_lic = vi_seq_pre_compromisso_lic
                AND seq_orcamento_lic = vi_seq_orcamento_lic;

      v_viw_orcamento_licitacao   ifrbde.viw_orcamento_licitacao%ROWTYPE;
      v_seq_licitacao_lic         ifrbde.viw_orcamento_licitacao.seq_licitacao_lic%TYPE;
      v_seq_pre_compromisso_lic   ifrbde.viw_orcamento_licitacao.seq_pre_compromisso_lic%TYPE;
      v_seq_orcamento_lic         ifrbde.viw_orcamento_licitacao.seq_orcamento_lic%TYPE;
      v_dado                      VARCHAR2 (4000)                           := NULL;
   BEGIN
      IF ifrseg.pck_seguranca.stf_permitido (
            p_usuario,
            'VIW_ORCAMENTO_LICITACAO',
            'ALTERA'
         )
      THEN
         OPEN c_cursor;
         FETCH c_cursor INTO v_viw_orcamento_licitacao;

         IF NOT c_cursor%NOTFOUND
         THEN
            v_seq_licitacao_lic := vi_seq_licitacao_lic;
            v_seq_pre_compromisso_lic := vi_seq_pre_compromisso_lic;
            v_seq_orcamento_lic := vi_seq_orcamento_lic;
            
--            
            ifrbde.prc_associa_orcamento_bdpu (
               vi_seq_orcamento_lic,
               vi_seq_licitacao_lic,
               vi_seq_pre_compromisso_lic,
               'A'
            );

            
--
            IF SQL%ROWCOUNT = 1
            THEN
               stp_pesquisa_orcamento_licitac (
                  p_usuario,
                  vo_seq_licitacao_lic,
                  vo_seq_pre_compromisso_lic,
                  vo_seq_orcamento_lic,
                  vi_seq_licitacao_lic,
                  vi_seq_pre_compromisso_lic,
                  vi_seq_orcamento_lic
               );
               v_dado :=
                        'seq_licitacao_lic = '
                     || TO_CHAR (v_seq_licitacao_lic);
               v_dado :=    v_dado
                         || ','
                         || 'seq_pre_compromisso_lic = '
                         || TO_CHAR (v_seq_pre_compromisso_lic);
               v_dado :=    v_dado
                         || ','
                         || 'seq_orcamento_lic = '
                         || TO_CHAR (v_seq_orcamento_lic);
               -- LOG
               ifrseg.pck_seguranca.stp_log (
                  p_usuario,
                  'VIW_ORCAMENTO_LICITACAO',
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
      WHEN OTHERS
      THEN
         raise_application_error (-20100, SQLERRM);
   END;
END;
/

-- Grants for Package Body
GRANT EXECUTE ON ifrbde.pck_orcamento TO bde_geral
/
-- End of DDL Script for Package Body IFRBDE.PCK_ORCAMENTO

