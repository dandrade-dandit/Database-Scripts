CREATE OR REPLACE 
PACKAGE BODY        ifrbde.pck_geral AS
--------------------------------------------------------------------
-- converte um valor moeda em string
   FUNCTION stf_cur2str (
      curvalue                   IN       NUMBER
   )
      RETURN VARCHAR2 AS
      v_strvalue                    VARCHAR2 (200);
   BEGIN
      v_strvalue := TO_CHAR (curvalue, '999,999,999,999,999.99');
      v_strvalue := REPLACE (v_strvalue, '.', '!');
      v_strvalue := REPLACE (v_strvalue, ',', '.');
      v_strvalue := RTRIM (LTRIM (REPLACE (v_strvalue, '!', ',')));

      IF v_strvalue = ',00' THEN
         v_strvalue := '0,00';
      END IF;

      RETURN v_strvalue;
   END;

--------------------------------------------------------------------
-- Pesquisa Seguranca Acesso Dependencia
-- retorna o recordset correspondente
   PROCEDURE stp_pesquisa_seg_acesso_depend (
      p_usuario                  IN       VARCHAR2,
      vo_nom_username_seg        OUT      tyt_nom_username_seg,
      vo_nom_usuario             OUT      tyt_nom_usuario,
      vo_cod_dependencia         OUT      tyt_cod_dependencia,
      vi_nom_username_seg        IN       t_nom_username_seg
   ) AS
   BEGIN
      IF ifrseg.pck_seguranca.stf_permitido (p_usuario,
                                             'VIW_SEG_ACESSO_DEPEND',
                                             'PESQUISA'
                                            ) THEN
         SELECT nom_username_seg,
                nom_usuario,
                cod_dependencia
           INTO vo_nom_username_seg (1),
                vo_nom_usuario (1),
                vo_cod_dependencia (1)
           FROM ifrbde.viw_seg_acesso_depend
          WHERE nom_username_seg = vi_nom_username_seg;
      END IF;
   EXCEPTION
      WHEN OTHERS THEN
         raise_application_error (-20100, SQLERRM);
   END;

   -- Exclui Seguranca Acesso Dependencia
   -- retorna o OK ou n?o
   PROCEDURE stp_exclui_seg_acesso_depend (
      p_usuario                  IN       VARCHAR2,
      vo_ok                      OUT      tyt_ok,
      vi_nom_username_seg        IN       t_nom_username_seg
   ) AS
      CURSOR c_cursor IS
         SELECT     *
               FROM ifrbde.viw_seg_acesso_depend
              WHERE nom_username_seg = vi_nom_username_seg
         FOR UPDATE;

      v_viw_seg_acesso_depend       ifrbde.viw_seg_acesso_depend%ROWTYPE;
      v_dado                        VARCHAR2 (4000) := NULL;
   BEGIN
      vo_ok (1) := 0;

      IF ifrseg.pck_seguranca.stf_permitido (p_usuario,
                                             'VIW_SEG_ACESSO_DEPEND',
                                             'EXCLUI'
                                            ) THEN
         OPEN c_cursor;

         FETCH c_cursor
          INTO v_viw_seg_acesso_depend;

         IF NOT c_cursor%NOTFOUND THEN
            v_dado :=
               'nom_username_seg = '
               || RTRIM
                       (LTRIM (UPPER (v_viw_seg_acesso_depend.nom_username_seg)
                              )
                       );
            v_dado :=
               v_dado
               || ','
               || 'nom_usuario = '
               || RTRIM (LTRIM (UPPER (v_viw_seg_acesso_depend.nom_usuario)));
            v_dado :=
               v_dado
               || ','
               || 'cod_dependencia = '
               || TO_CHAR (v_viw_seg_acesso_depend.cod_dependencia);

            IF c_cursor%ROWCOUNT = 1 THEN
               vo_ok (1) := 1;
               -- LOG
               ifrseg.pck_seguranca.stp_log (p_usuario,
                                             'VIW_SEG_ACESSO_DEPEND',
                                             'E',
                                             v_dado
                                            );

/*               DELETE FROM ifrbde.viw_seg_acesso_depend
                     WHERE  CURRENT OF c_cursor;
*/
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
-- Inclui Seguranca Acesso Dependencia
-- retorna o recordset correspondente
   PROCEDURE stp_inclui_seg_acesso_depend (
      p_usuario                  IN       VARCHAR2,
      vo_nom_username_seg        OUT      tyt_nom_username_seg,
      vo_nom_usuario             OUT      tyt_nom_usuario,
      vo_cod_dependencia         OUT      tyt_cod_dependencia,
      vi_nom_username_seg        IN       t_nom_username_seg,
      vi_nom_usuario             IN       t_nom_usuario,
      vi_cod_dependencia         IN       t_cod_dependencia
   ) AS
      v_nom_username_seg            viw_seg_acesso_depend.nom_username_seg%TYPE;
      v_nom_usuario                 viw_seg_acesso_depend.nom_usuario%TYPE;
      v_cod_dependencia             viw_seg_acesso_depend.cod_dependencia%TYPE;
      v_dado                        VARCHAR2 (4000) := NULL;
   BEGIN
      IF ifrseg.pck_seguranca.stf_permitido (p_usuario,
                                             'VIW_SEG_ACESSO_DEPEND',
                                             'INCLUI'
                                            ) THEN
         v_nom_username_seg := RTRIM (LTRIM (vi_nom_username_seg));
         v_nom_usuario := RTRIM (LTRIM (vi_nom_usuario));
         v_cod_dependencia := vi_cod_dependencia;

/*         INSERT INTO ifrbde.viw_seg_acesso_depend
                     (nom_username_seg,
                      nom_usuario,
                      cod_dependencia
                     )
              VALUES (v_nom_username_seg,
                      v_nom_usuario,
                      v_cod_dependencia
                     );
*/
         IF SQL%ROWCOUNT = 1 THEN
            stp_pesquisa_seg_acesso_depend (p_usuario,
                                            vo_nom_username_seg,
                                            vo_nom_usuario,
                                            vo_cod_dependencia,
                                            v_nom_username_seg
                                           );
            v_dado :=
                   'nom_username_seg = ' || RTRIM (LTRIM (v_nom_username_seg));
            v_dado :=
               v_dado || ',' || 'nom_usuario = '
               || RTRIM (LTRIM (v_nom_usuario));
            v_dado :=
               v_dado
               || ','
               || 'cod_dependencia = '
               || TO_CHAR (v_cod_dependencia);
            -- LOG
            ifrseg.pck_seguranca.stp_log (p_usuario,
                                          'VIW_SEG_ACESSO_DEPEND',
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
-- Altera Seguranca Acesso Dependencia
-- retorna o recordset correspondente
   PROCEDURE stp_altera_seg_acesso_depend (
      p_usuario                  IN       VARCHAR2,
      vo_nom_username_seg        OUT      tyt_nom_username_seg,
      vo_nom_usuario             OUT      tyt_nom_usuario,
      vo_cod_dependencia         OUT      tyt_cod_dependencia,
      vi_nom_username_seg        IN       t_nom_username_seg,
      vi_nom_usuario             IN       t_nom_usuario,
      vi_cod_dependencia         IN       t_cod_dependencia
   ) AS
      CURSOR c_cursor IS
         SELECT     *
               FROM ifrbde.viw_seg_acesso_depend
              WHERE nom_username_seg = vi_nom_username_seg
         FOR UPDATE;

      v_viw_seg_acesso_depend       ifrbde.viw_seg_acesso_depend%ROWTYPE;
      v_nom_username_seg            ifrbde.viw_seg_acesso_depend.nom_username_seg%TYPE;
      v_nom_usuario                 ifrbde.viw_seg_acesso_depend.nom_usuario%TYPE;
      v_cod_dependencia             ifrbde.viw_seg_acesso_depend.cod_dependencia%TYPE;
      v_dado                        VARCHAR2 (4000) := NULL;
   BEGIN
      IF ifrseg.pck_seguranca.stf_permitido (p_usuario,
                                             'VIW_SEG_ACESSO_DEPEND',
                                             'ALTERA'
                                            ) THEN
         OPEN c_cursor;

         FETCH c_cursor
          INTO v_viw_seg_acesso_depend;

         IF NOT c_cursor%NOTFOUND THEN
            v_nom_username_seg := RTRIM (LTRIM (vi_nom_username_seg));
            v_nom_usuario := RTRIM (LTRIM (vi_nom_usuario));
            v_cod_dependencia := vi_cod_dependencia;

/*            UPDATE ifrbde.viw_seg_acesso_depend
               SET nom_usuario = v_nom_usuario,
                   cod_dependencia = v_cod_dependencia
             WHERE  CURRENT OF c_cursor;
*/
            IF SQL%ROWCOUNT = 1 THEN
               stp_pesquisa_seg_acesso_depend (p_usuario,
                                               vo_nom_username_seg,
                                               vo_nom_usuario,
                                               vo_cod_dependencia,
                                               vi_nom_username_seg
                                              );
               v_dado :=
                   'nom_username_seg = ' || RTRIM (LTRIM (v_nom_username_seg));
               v_dado :=
                  v_dado
                  || ','
                  || 'nom_usuario = '
                  || RTRIM (LTRIM (v_nom_usuario));
               v_dado :=
                  v_dado
                  || ','
                  || 'cod_dependencia = '
                  || TO_CHAR (v_cod_dependencia);
               -- LOG
               ifrseg.pck_seguranca.stp_log (p_usuario,
                                             'VIW_SEG_ACESSO_DEPEND',
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
-- Pesquisa Acesso Dependencia
-- retorna o recordset correspondente
   PROCEDURE stp_pesquisa_acesso_dependenci (
      p_usuario                  IN       VARCHAR2,
      vo_nom_username            OUT      tyt_nom_username,
      vo_cod_dependencia_acesso  OUT      tyt_cod_dependencia_acesso,
      vi_nom_username            IN       t_nom_username,
      vi_cod_dependencia_acesso  IN       t_cod_dependencia_acesso
   ) AS
   BEGIN
      IF ifrseg.pck_seguranca.stf_permitido (p_usuario,
                                             'CAD_ACESSO_DEPENDENCIA',
                                             'PESQUISA'
                                            ) THEN
         SELECT nom_username,
                cod_dependencia_acesso
           INTO vo_nom_username (1),
                vo_cod_dependencia_acesso (1)
           FROM ifrbde.cad_acesso_dependencia
          WHERE nom_username = vi_nom_username
            AND cod_dependencia_acesso = vi_cod_dependencia_acesso;
      END IF;
   EXCEPTION
      WHEN OTHERS THEN
         raise_application_error (-20100, SQLERRM);
   END;

   -- Exclui Acesso Dependencia
   -- retorna o OK ou n?o
   PROCEDURE stp_exclui_acesso_dependencia (
      p_usuario                  IN       VARCHAR2,
      vo_ok                      OUT      tyt_ok,
      vi_nom_username            IN       t_nom_username,
      vi_cod_dependencia_acesso  IN       t_cod_dependencia_acesso
   ) AS
      CURSOR c_cursor IS
         SELECT     *
               FROM ifrbde.cad_acesso_dependencia
              WHERE nom_username = vi_nom_username
                AND cod_dependencia_acesso = vi_cod_dependencia_acesso
         FOR UPDATE;

      v_nom_username                cad_acesso_dependencia.nom_username%TYPE;
      v_cad_acesso_dependencia      ifrbde.cad_acesso_dependencia%ROWTYPE;
      v_dado                        VARCHAR2 (4000) := NULL;
   BEGIN
      vo_ok (1) := 0;
      v_nom_username := RTRIM (LTRIM (vi_nom_username));

      IF ifrseg.pck_seguranca.stf_permitido (p_usuario,
                                             'CAD_ACESSO_DEPENDENCIA',
                                             'EXCLUI'
                                            ) THEN
         OPEN c_cursor;

         FETCH c_cursor
          INTO v_cad_acesso_dependencia;

         IF NOT c_cursor%NOTFOUND THEN
            v_dado :=
               'nom_username = '
               || RTRIM (LTRIM (UPPER (v_cad_acesso_dependencia.nom_username)));
            v_dado :=
               v_dado
               || ','
               || 'cod_dependencia_acesso = '
               || TO_CHAR (v_cad_acesso_dependencia.cod_dependencia_acesso);

            IF c_cursor%ROWCOUNT = 1 THEN
               vo_ok (1) := 1;
               -- LOG
               ifrseg.pck_seguranca.stp_log (p_usuario,
                                             'CAD_ACESSO_DEPENDENCIA',
                                             'E',
                                             v_dado
                                            );

               DELETE FROM ifrbde.cad_acesso_dependencia
                     WHERE CURRENT OF c_cursor;

               IF c_cursor%ROWCOUNT = 1 THEN
                  vo_ok (1) := 1;
                  COMMIT;
                  stp_exclui_dependencia (p_usuario,
                                          v_nom_username,
                                          vi_cod_dependencia_acesso
                                         );
               ELSIF c_cursor%ROWCOUNT > 1 THEN
                  ROLLBACK;
                  raise_application_error
                     (-20100,
                      'Mais de um registro solicitado para exclus?o. Operac?o n?o realizada!!!'
                     );
               END IF;
            END IF;
         ELSE
            raise_application_error
                              (-20100,
                               'Registro n?o foi encontrado para exclus?o!!!'
                              );
         END IF;
      ELSE
         raise_application_error
                              (-20100,
                               'N?o foi concedida permiss?o para exclus?o!!!'
                              );
      END IF;
   EXCEPTION
      WHEN OTHERS THEN
         raise_application_error (-20100, SQLERRM);
   END;

--------------------------------------------------------------------
-- Inclui Acesso Dependencia
-- retorna o recordset correspondente
   PROCEDURE stp_inclui_acesso_dependencia (
      p_usuario                  IN       VARCHAR2,
      vo_nom_username            OUT      tyt_nom_username,
      vo_cod_dependencia_acesso  OUT      tyt_cod_dependencia_acesso,
      vi_nom_username            IN       t_nom_username,
      vi_cod_dependencia_acesso  IN       t_cod_dependencia_acesso
   ) AS
      v_nom_username                cad_acesso_dependencia.nom_username%TYPE;
      v_cod_dependencia_acesso      cad_acesso_dependencia.cod_dependencia_acesso%TYPE;
      v_dado                        VARCHAR2 (4000) := NULL;
   BEGIN
      IF ifrseg.pck_seguranca.stf_permitido (p_usuario,
                                             'CAD_ACESSO_DEPENDENCIA',
                                             'INCLUI'
                                            ) THEN
         v_nom_username := RTRIM (LTRIM (vi_nom_username));
         v_cod_dependencia_acesso := vi_cod_dependencia_acesso;

         INSERT INTO ifrbde.cad_acesso_dependencia
                     (nom_username,
                      cod_dependencia_acesso
                     )
              VALUES (v_nom_username,
                      v_cod_dependencia_acesso
                     );

         IF SQL%ROWCOUNT = 1 THEN
            stp_pesquisa_acesso_dependenci (p_usuario,
                                            vo_nom_username,
                                            vo_cod_dependencia_acesso,
                                            v_nom_username,
                                            v_cod_dependencia_acesso
                                           );
            v_dado := 'nom_username = ' || RTRIM (LTRIM (v_nom_username));
            v_dado :=
               v_dado
               || ','
               || 'cod_dependencia_acesso = '
               || TO_CHAR (v_cod_dependencia_acesso);
            -- LOG
            ifrseg.pck_seguranca.stp_log (p_usuario,
                                          'CAD_ACESSO_DEPENDENCIA',
                                          'I',
                                          v_dado
                                         );
            stp_cadastra_dependencia (p_usuario,
                                      v_nom_username,
                                      vi_cod_dependencia_acesso
                                     );
            COMMIT;
         ELSE
            ROLLBACK;
            raise_application_error
               (-20100,
                'Mais de um registro solicitado para inclus?o. Operac?o n?o realizada!!!'
               );
         END IF;
      ELSE
         raise_application_error
                              (-20100,
                               'N?o foi concedida permiss?o para inclus?o!!!'
                              );
      END IF;
   EXCEPTION
      WHEN OTHERS THEN
         raise_application_error (-20100, SQLERRM);
   END;

--------------------------------------------------------------------
-- Altera Acesso Dependencia
-- retorna o recordset correspondente
   PROCEDURE stp_altera_acesso_dependencia (
      p_usuario                  IN       VARCHAR2,
      vo_nom_username            OUT      tyt_nom_username,
      vo_cod_dependencia_acesso  OUT      tyt_cod_dependencia_acesso,
      vi_nom_username            IN       t_nom_username,
      vi_cod_dependencia_acesso  IN       t_cod_dependencia_acesso
   ) AS
      CURSOR c_cursor IS
         SELECT     *
               FROM ifrbde.cad_acesso_dependencia
              WHERE nom_username = vi_nom_username
                AND cod_dependencia_acesso = vi_cod_dependencia_acesso
         FOR UPDATE;

      v_cad_acesso_dependencia      ifrbde.cad_acesso_dependencia%ROWTYPE;
      v_nom_username                ifrbde.cad_acesso_dependencia.nom_username%TYPE;
      v_cod_dependencia_acesso      ifrbde.cad_acesso_dependencia.cod_dependencia_acesso%TYPE;
      v_dado                        VARCHAR2 (4000) := NULL;
   BEGIN
      IF ifrseg.pck_seguranca.stf_permitido (p_usuario,
                                             'CAD_ACESSO_DEPENDENCIA',
                                             'ALTERA'
                                            ) THEN
         OPEN c_cursor;

         FETCH c_cursor
          INTO v_cad_acesso_dependencia;

         IF NOT c_cursor%NOTFOUND THEN
            v_nom_username := RTRIM (LTRIM (vi_nom_username));
            v_cod_dependencia_acesso := vi_cod_dependencia_acesso;

/*            UPDATE IFRBDE.cad_acesso_dependencia
            SET
            WHERE CURRENT of c_cursor;
*/
            IF SQL%ROWCOUNT = 1 THEN
               stp_pesquisa_acesso_dependenci (p_usuario,
                                               vo_nom_username,
                                               vo_cod_dependencia_acesso,
                                               vi_nom_username,
                                               vi_cod_dependencia_acesso
                                              );
               v_dado := 'nom_username = ' || RTRIM (LTRIM (v_nom_username));
               v_dado :=
                  v_dado
                  || ','
                  || 'cod_dependencia_acesso = '
                  || TO_CHAR (v_cod_dependencia_acesso);
               -- LOG
               ifrseg.pck_seguranca.stp_log (p_usuario,
                                             'CAD_ACESSO_DEPENDENCIA',
                                             'A',
                                             v_dado
                                            );
               COMMIT;
            ELSE
               ROLLBACK;
               raise_application_error
                  (-20100,
                   'Mais de um registro solicitado para alterac?o. Operac?o n?o realizada!!!'
                  );
            END IF;
         ELSE
            raise_application_error
                             (-20100,
                              'Registro n?o foi encontrado para alterac?o!!!'
                             );
         END IF;
      ELSE
         raise_application_error
                             (-20100,
                              'N?o foi concedida permiss?o para alterac?o!!!'
                             );
      END IF;
   EXCEPTION
      WHEN OTHERS THEN
         raise_application_error (-20100, SQLERRM);
   END;

--------------------------------------------------------------------
-- Pesquisa Acesso Projeto
-- retorna o recordset correspondente
   PROCEDURE stp_pesquisa_acesso_projeto (
      p_usuario                  IN       VARCHAR2,
      vo_nom_usuario_proj        OUT      tyt_nom_usuario_proj,
      vo_cod_projeto             OUT      tyt_cod_projeto,
      vi_nom_usuario_proj        IN       t_nom_usuario_proj,
      vi_cod_projeto             IN       t_cod_projeto
   ) AS
   BEGIN
      IF ifrseg.pck_seguranca.stf_permitido (p_usuario,
                                             'VIW_ACESSO_PROJETO',
                                             'PESQUISA'
                                            ) THEN
         SELECT nom_usuario_proj,
                cod_projeto
           INTO vo_nom_usuario_proj (1),
                vo_cod_projeto (1)
           FROM ifrbde.viw_acesso_projeto
          WHERE nom_usuario_proj = vi_nom_usuario_proj
            AND cod_projeto = vi_cod_projeto;
      END IF;
   EXCEPTION
      WHEN OTHERS THEN
         raise_application_error (-20100, SQLERRM);
   END;

   -- Exclui Acesso Projeto
   -- retorna o OK ou n?o
   PROCEDURE stp_exclui_acesso_projeto (
      p_usuario                  IN       VARCHAR2,
      vo_ok                      OUT      tyt_ok,
      vi_nom_usuario_proj        IN       t_nom_usuario_proj,
      vi_cod_projeto             IN       t_cod_projeto
   ) AS
      CURSOR c_cursor IS
         SELECT     *
               FROM ifrbde.viw_acesso_projeto
              WHERE nom_usuario_proj = vi_nom_usuario_proj
                AND cod_projeto = vi_cod_projeto
         FOR UPDATE;

      v_viw_acesso_projeto          ifrbde.viw_acesso_projeto%ROWTYPE;
      v_dado                        VARCHAR2 (4000) := NULL;
   BEGIN
      vo_ok (1) := 0;

      IF ifrseg.pck_seguranca.stf_permitido (p_usuario,
                                             'VIW_ACESSO_PROJETO',
                                             'EXCLUI'
                                            ) THEN
         OPEN c_cursor;

         FETCH c_cursor
          INTO v_viw_acesso_projeto;

         IF NOT c_cursor%NOTFOUND THEN
            v_dado :=
               'nom_usuario_proj = '
               || RTRIM (LTRIM (UPPER (v_viw_acesso_projeto.nom_usuario_proj)));
            v_dado :=
               v_dado
               || ','
               || 'cod_projeto = '
               || RTRIM (LTRIM (UPPER (v_viw_acesso_projeto.cod_projeto)));

            IF c_cursor%ROWCOUNT = 1 THEN
               vo_ok (1) := 1;
               -- LOG
               ifrseg.pck_seguranca.stp_log (p_usuario,
                                             'VIW_ACESSO_PROJETO',
                                             'E',
                                             v_dado
                                            );

               DELETE FROM ifrbde.viw_acesso_projeto
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
-- Inclui Acesso Projeto
-- retorna o recordset correspondente
   PROCEDURE stp_inclui_acesso_projeto (
      p_usuario                  IN       VARCHAR2,
      vo_nom_usuario_proj        OUT      tyt_nom_usuario_proj,
      vo_cod_projeto             OUT      tyt_cod_projeto,
      vi_nom_usuario_proj        IN       t_nom_usuario_proj,
      vi_cod_projeto             IN       t_cod_projeto
   ) AS
      v_nom_usuario_proj            viw_acesso_projeto.nom_usuario_proj%TYPE;
      v_cod_projeto                 viw_acesso_projeto.cod_projeto%TYPE;
      v_dado                        VARCHAR2 (4000) := NULL;
   BEGIN
      IF ifrseg.pck_seguranca.stf_permitido (p_usuario,
                                             'VIW_ACESSO_PROJETO',
                                             'INCLUI'
                                            ) THEN
         v_nom_usuario_proj := RTRIM (LTRIM (vi_nom_usuario_proj));
         v_cod_projeto := RTRIM (LTRIM (vi_cod_projeto));

         INSERT INTO ifrbde.viw_acesso_projeto
                     (nom_usuario_proj,
                      cod_projeto
                     )
              VALUES (v_nom_usuario_proj,
                      v_cod_projeto
                     );

         IF SQL%ROWCOUNT = 1 THEN
            stp_pesquisa_acesso_projeto (p_usuario,
                                         vo_nom_usuario_proj,
                                         vo_cod_projeto,
                                         v_nom_usuario_proj,
                                         v_cod_projeto
                                        );
            v_dado :=
                   'nom_usuario_proj = ' || RTRIM (LTRIM (v_nom_usuario_proj));
            v_dado :=
               v_dado || ',' || 'cod_projeto = '
               || RTRIM (LTRIM (v_cod_projeto));
            -- LOG
            ifrseg.pck_seguranca.stp_log (p_usuario,
                                          'VIW_ACESSO_PROJETO',
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
-- Altera Acesso Projeto
-- retorna o recordset correspondente
   PROCEDURE stp_altera_acesso_projeto (
      p_usuario                  IN       VARCHAR2,
      vo_nom_usuario_proj        OUT      tyt_nom_usuario_proj,
      vo_cod_projeto             OUT      tyt_cod_projeto,
      vi_nom_usuario_proj        IN       t_nom_usuario_proj,
      vi_cod_projeto             IN       t_cod_projeto
   ) AS
      CURSOR c_cursor IS
         SELECT     *
               FROM ifrbde.viw_acesso_projeto
              WHERE nom_usuario_proj = vi_nom_usuario_proj
                AND cod_projeto = vi_cod_projeto
         FOR UPDATE;

      v_viw_acesso_projeto          ifrbde.viw_acesso_projeto%ROWTYPE;
      v_nom_usuario_proj            ifrbde.viw_acesso_projeto.nom_usuario_proj%TYPE;
      v_cod_projeto                 ifrbde.viw_acesso_projeto.cod_projeto%TYPE;
      v_dado                        VARCHAR2 (4000) := NULL;
   BEGIN
      IF ifrseg.pck_seguranca.stf_permitido (p_usuario,
                                             'VIW_ACESSO_PROJETO',
                                             'ALTERA'
                                            ) THEN
         OPEN c_cursor;

         FETCH c_cursor
          INTO v_viw_acesso_projeto;

         IF NOT c_cursor%NOTFOUND THEN
            v_nom_usuario_proj := RTRIM (LTRIM (vi_nom_usuario_proj));
            v_cod_projeto := RTRIM (LTRIM (vi_cod_projeto));

/*            UPDATE IFRBDE.viw_acesso_projeto
            SET
            WHERE CURRENT of c_cursor;
*/
            IF SQL%ROWCOUNT = 1 THEN
               stp_pesquisa_acesso_projeto (p_usuario,
                                            vo_nom_usuario_proj,
                                            vo_cod_projeto,
                                            vi_nom_usuario_proj,
                                            vi_cod_projeto
                                           );
               v_dado :=
                   'nom_usuario_proj = ' || RTRIM (LTRIM (v_nom_usuario_proj));
               v_dado :=
                  v_dado
                  || ','
                  || 'cod_projeto = '
                  || RTRIM (LTRIM (v_cod_projeto));
               -- LOG
               ifrseg.pck_seguranca.stp_log (p_usuario,
                                             'VIW_ACESSO_PROJETO',
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
-- Inclui Sede, Regional e Dependencia para Seguranca Acesso Dependencia
   PROCEDURE stp_cadastra_dependencia (
      p_usuario                  IN       VARCHAR2,
      v_nom_username             IN       t_nom_username_seg,
      v_cod_dependencia_acesso   IN       t_cod_dependencia
   ) AS
      CURSOR c_cursor IS
         SELECT   b.dpp_ncod,
                  a.dep_cod
             FROM ifrbde.tab_dependencia a,
                  ifrbde.tab_dependencia_pai b
            WHERE a.dep_dpp_cod = b.dpp_cod
              AND (   (    a.dep_cod > 0
                       AND a.dep_cod < 200)
                   OR a.dep_cod > 998)
         ORDER BY b.dpp_ncod,
                  a.dep_cod;

      vo_nom_username               tyt_nom_username_seg;
      vo_cod_dependencia_acesso     tyt_cod_dependencia;
      v_cad_acesso_dependencia      ifrbde.cad_acesso_dependencia%ROWTYPE;
      v_dpp_ncod                    cad_acesso_dependencia.cod_dependencia_acesso%TYPE;
      v_dep_cod                     cad_acesso_dependencia.cod_dependencia_acesso%TYPE;
      v_cod                         cad_acesso_dependencia.cod_dependencia_acesso%TYPE;
      v_nom                         cad_acesso_dependencia.nom_username%TYPE;
      v_dado                        VARCHAR2 (4000) := NULL;
   BEGIN
      v_nom := v_nom_username;

      SELECT b.dpp_ncod,
             a.dep_cod
        INTO v_dpp_ncod,
             v_dep_cod
        FROM ifrbde.tab_dependencia a,
             ifrbde.tab_dependencia_pai b
       WHERE a.dep_dpp_cod = b.dpp_cod
         AND a.dep_cod = v_cod_dependencia_acesso;

      FOR v_cad IN c_cursor
      LOOP
         IF     (   v_cad.dpp_ncod = v_dpp_ncod
                 OR v_cod_dependencia_acesso = 1
                )
            AND (v_cad.dep_cod <> v_cod_dependencia_acesso) THEN
            INSERT INTO ifrbde.cad_acesso_dependencia
                        (nom_username,
                         cod_dependencia_acesso
                        )
                 VALUES (v_nom_username,
                         v_cad.dep_cod
                        );

            v_cod := v_cad.dep_cod;

            IF SQL%ROWCOUNT = 1 THEN
               COMMIT;
            ELSE
               ROLLBACK;
            END IF;
         END IF;
      END LOOP;
   EXCEPTION
      WHEN OTHERS THEN
         raise_application_error (-20100, SQLERRM);
   END;

--------------------------------------------------------------------
-- Exclui Sede, Regional e Dependencia para Seguranca Acesso Dependencia
   PROCEDURE stp_exclui_dependencia (
      p_usuario                  IN       VARCHAR2,
      v_nom_username             IN       t_nom_username_seg,
      v_cod_dependencia_acesso   IN       t_cod_dependencia
   ) AS
      CURSOR c_cursor IS
         SELECT   b.dpp_ncod,
                  a.dep_cod
             FROM ifrbde.tab_dependencia a,
                  ifrbde.tab_dependencia_pai b
            WHERE a.dep_dpp_cod = b.dpp_cod
              AND (   (    a.dep_cod > 0
                       AND a.dep_cod < 200)
                   OR a.dep_cod > 998)
         ORDER BY b.dpp_ncod,
                  a.dep_cod;

      vo_nom_username               tyt_nom_username_seg;
      vo_cod_dependencia_acesso     tyt_cod_dependencia;
      v_cad_acesso_dependencia      ifrbde.cad_acesso_dependencia%ROWTYPE;
      v_dpp_ncod                    cad_acesso_dependencia.cod_dependencia_acesso%TYPE;
      v_dep_cod                     cad_acesso_dependencia.cod_dependencia_acesso%TYPE;
      v_cod                         cad_acesso_dependencia.cod_dependencia_acesso%TYPE;
      v_nom                         cad_acesso_dependencia.nom_username%TYPE;
      v_dado                        VARCHAR2 (4000) := NULL;
   BEGIN
      v_nom := v_nom_username;

      SELECT b.dpp_ncod,
             a.dep_cod
        INTO v_dpp_ncod,
             v_dep_cod
        FROM ifrbde.tab_dependencia a,
             ifrbde.tab_dependencia_pai b
       WHERE a.dep_dpp_cod = b.dpp_cod
         AND a.dep_cod = v_cod_dependencia_acesso;

      FOR v_cad IN c_cursor
      LOOP
         IF     (   v_cad.dpp_ncod = v_dpp_ncod
                 OR v_cod_dependencia_acesso = 1
                )
            AND (v_cad.dep_cod <> v_cod_dependencia_acesso) THEN
            IF v_cad.dpp_ncod = v_cod_dependencia_acesso THEN
               DELETE FROM ifrbde.cad_acesso_dependencia
                     WHERE nom_username = v_nom_username
                       AND cod_dependencia_acesso = v_cad.dep_cod;
            ELSE
               DELETE FROM ifrbde.cad_acesso_dependencia
                     WHERE nom_username = v_nom_username
                       AND cod_dependencia_acesso = v_cod_dependencia_acesso;
            END IF;

            v_cod := v_cad.dep_cod;

            IF SQL%ROWCOUNT = 1 THEN
               COMMIT;
            ELSE
               ROLLBACK;
            END IF;
         END IF;
      END LOOP;
   EXCEPTION
      WHEN NO_DATA_FOUND THEN
         NULL;
      WHEN OTHERS THEN
         raise_application_error (-20100, SQLERRM);
   END;
END pck_geral;
/

