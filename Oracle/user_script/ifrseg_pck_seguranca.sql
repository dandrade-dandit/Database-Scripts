/* Formatted on 30/03/2005 13:32 (Formatter Plus v4.8.0) */
-- Start of DDL Script for Package Body IFRSEG.PCK_SEGURANCA
-- Generated 2-dez-2004 19:38:08 from SYSMAN@HOMOLOG2

CREATE OR REPLACE PACKAGE BODY ifrseg.pck_seguranca AS
---------------------------------------------------------------------------------------------------------------------
   -- validacao de usuário e senha, armazena em TAB_ACESSO
   PROCEDURE stp_login (
      vo_ok                      OUT      tyt_ok,
      p_usuario                  IN       VARCHAR2,
      p_senha                    IN       VARCHAR2,
      p_sessionid                IN       VARCHAR2
   ) AS
      v_ok                          NUMBER (1) DEFAULT 0;
      v_usuario                     VARCHAR2 (30);
      v_senha                       VARCHAR2 (30);
      v_sistema                     ifrseg.tab_acesso.cod_sistema_acesso%TYPE;
      v_sistema_acs                 ifrseg.tab_acesso.cod_sistema_acesso%TYPE;
      v_cpf                         VARCHAR2 (11);
      v_matricula                   VARCHAR2 (10);
      v_banco                       VARCHAR2 (10);
      v_emp_status                  ifrseg.viw_empregado_infraero.emp_status%TYPE
                                                                      := NULL;
      v_num_seq_sessionid           ifrseg.tab_acesso.num_seq_sessionid%TYPE;
   BEGIN
      v_usuario := pck_seguranca.stf_separausername (p_usuario, 'U');
      v_senha := p_senha;
      v_sistema :=
                TO_NUMBER (pck_seguranca.stf_separausername (p_usuario, 'A'));
      v_cpf := pck_seguranca.stf_separausername (p_usuario, 'C');
      v_matricula := pck_seguranca.stf_separausername (p_usuario, 'M');
      v_banco := pck_seguranca.stf_separausername (p_usuario, 'B');

      IF UPPER (v_usuario) = 'ANONYMOUS' THEN
         BEGIN
            SELECT emp_status
              INTO v_emp_status
              FROM ifrseg.viw_empregado_infraero
             WHERE num_cpf = TO_NUMBER (v_cpf)
               AND cod_matricula = TO_NUMBER (v_matricula);

--            IF SQL%ROWCOUNT <> 0 THEN
            IF v_emp_status <> 1 THEN
               raise_application_error (-20100,
                                        'Solicitante desligado ou afastado!'
                                       );
            END IF;
/*            ELSE
               raise_application_error
                                   (-20100,
                                    'Solicitante não cadastrado na INFRAERO!'
                                   );
            END IF;
*/
         EXCEPTION
            WHEN NO_DATA_FOUND THEN
               raise_application_error
                               (-20100,
                                'Solicitante não cadastrado na INFRAERO! '
                                || SQLERRM
                               );
            WHEN OTHERS THEN
               raise_application_error (-20100, SQLERRM);
         END;
      END IF;

      IF UPPER (v_usuario) = 'ANONYMOUS' THEN
         v_usuario := v_matricula;
      END IF;

      IF v_sistema = 0 THEN
         -- grava log de acesso
         INSERT INTO ifrseg.viw_tab_acesso
                     (acs_sessionid,
                      acs_data,
                      acs_usuario
                     )
              VALUES (UPPER (p_sessionid),
                      SYSDATE,
                      v_usuario
                     );
      ELSE
         SELECT num_seq_sessionid,
                cod_sistema_acesso
           INTO v_num_seq_sessionid,
                v_sistema_acs
           FROM ifrseg.tab_acesso
          WHERE UPPER (num_sessionid) = UPPER (p_sessionid)
            AND UPPER (nom_username_acesso) = UPPER (v_usuario)
            AND dat_encerramento IS NULL;

         IF SQL%ROWCOUNT = 0 THEN
            INSERT INTO ifrseg.viw_tab_acesso
                        (acs_sessionid,
                         acs_data,
                         acs_usuario,
                         acs_sistema
                        )
                 VALUES (UPPER (p_sessionid),
                         SYSDATE,
                         v_usuario,
                         v_sistema
                        );
         ELSE
            IF v_sistema_acs IS NULL THEN
               UPDATE ifrseg.tab_acesso
                  SET cod_sistema_acesso = v_sistema
                WHERE UPPER (num_sessionid) = UPPER (p_sessionid)
                  AND UPPER (nom_username_acesso) = UPPER (v_usuario)
                  AND dat_encerramento IS NULL;
            ELSE
               UPDATE ifrseg.tab_acesso
                  SET dat_encerramento = SYSDATE
                WHERE dat_acesso < SYSDATE
                  AND UPPER (nom_username_acesso) = UPPER (v_usuario)
                  AND dat_encerramento IS NULL;

               INSERT INTO ifrseg.viw_tab_acesso
                           (acs_sessionid,
                            acs_data,
                            acs_usuario,
                            acs_sistema
                           )
                    VALUES (UPPER (p_sessionid),
                            SYSDATE,
                            v_usuario,
                            v_sistema
                           );
            END IF;
         END IF;
      END IF;

      -- verifica
      IF SQL%ROWCOUNT = 1 THEN
         COMMIT;
         v_ok := 1;
      ELSE
         ROLLBACK;
      END IF;

      vo_ok (1) := v_ok;
   END;

---------------------------------------------------------------------------------------------------------------------
   -- validacao de usuário e senha, armazena em TAB_ACESSO
   PROCEDURE stp_logout (
      vo_ok                      OUT      tyt_ok,
      p_usuario                  IN       VARCHAR2,
      p_senha                    IN       VARCHAR2,
      p_sessionid                IN       VARCHAR2
   ) AS
      v_ok                          NUMBER (1) DEFAULT 0;
      v_usuario                     VARCHAR2 (30);
      v_senha                       VARCHAR2 (30);
      v_sistema                     ifrseg.tab_acesso.cod_sistema_acesso%TYPE;
      v_sistema_acs                 ifrseg.tab_acesso.cod_sistema_acesso%TYPE;
   BEGIN
      v_usuario := pck_seguranca.stf_separausername (p_usuario, 'U');
      v_senha := p_senha;
      v_sistema :=
                TO_NUMBER (pck_seguranca.stf_separausername (p_usuario, 'A'));

      IF UPPER (v_usuario) = 'ANONYMOUS' THEN
         v_usuario := pck_seguranca.stf_separausername (p_usuario, 'M');
      END IF;

      SELECT cod_sistema_acesso
        INTO v_sistema_acs
        FROM ifrseg.tab_acesso
       WHERE UPPER (num_sessionid) = UPPER (p_sessionid)
         AND UPPER (nom_username_acesso) = UPPER (v_usuario)
         AND dat_encerramento IS NULL;

      IF v_sistema_acs IS NULL THEN
         UPDATE ifrseg.viw_tab_acesso
            SET acs_dt_encerramento = SYSDATE
          WHERE UPPER (acs_sessionid) = UPPER (p_sessionid)
            AND UPPER (acs_usuario) = UPPER (v_usuario)
            AND acs_dt_encerramento IS NULL
            AND acs_sistema IS NULL;
      ELSE
         UPDATE ifrseg.viw_tab_acesso
            SET acs_dt_encerramento = SYSDATE
          WHERE UPPER (acs_sessionid) = UPPER (p_sessionid)
            AND UPPER (acs_usuario) = UPPER (v_usuario)
            AND acs_dt_encerramento IS NULL
            AND acs_sistema = v_sistema;
      END IF;

      -- verifica
      IF SQL%ROWCOUNT = 1 THEN
         COMMIT;
         v_ok := 1;
      ELSE
         ROLLBACK;
      END IF;

      vo_ok (1) := v_ok;
   END;

---------------------------------------------------------------------------------------------------------------------
   -- traz o USUÁRIO de acordo com a SESSIONID de  TAB_ACESSO);
   PROCEDURE stp_validar (
      vo_usuario                 OUT      tyt_usuario,
      p_sessionid                IN       VARCHAR2
   ) AS
      v_sessionid                   ifrseg.tab_acesso.num_sessionid%TYPE;
      v_sistema                     ifrseg.tab_acesso.cod_sistema_acesso%TYPE;

      CURSOR c_usuario (
         v_sessionid                IN       VARCHAR2,
         v_sistema                  IN       VARCHAR2
      ) IS
         SELECT   acs_usuario
             FROM ifrseg.viw_tab_acesso
            WHERE UPPER (acs_sessionid) = UPPER (v_sessionid)
              AND acs_sistema = v_sistema
              AND acs_dt_encerramento IS NULL
         ORDER BY acs_data DESC;
   BEGIN
      vo_usuario (1) := '';
      v_sessionid :=
               UPPER ((pck_seguranca.stf_separausername (p_sessionid, 'S')));
      v_sistema := pck_seguranca.stf_separausername (p_sessionid, 'A');

      FOR c IN c_usuario (v_sessionid, v_sistema)
      LOOP
         vo_usuario (1) := c.acs_usuario;
         EXIT WHEN TRUE;
      END LOOP;
   END;

--------------------------------------------------------------------
-- Verifica se o usuário tem permissão de acesso a determinada tabela/ação
-- retorna TRUE/FALSE
   FUNCTION stf_permitido (
      p_usuario                  IN       VARCHAR2,
      p_objeto                   IN       VARCHAR2,
      p_acao                     IN       VARCHAR2
   )
      RETURN BOOLEAN AS
      v_flg_pesquisa                VARCHAR2 (1);
      v_flg_inclusao                VARCHAR2 (1);
      v_flg_alteracao               VARCHAR2 (1);
      v_flg_exclusao                VARCHAR2 (1);
      v_cod_grupo                   NUMBER (3);
      v_cod_grupo_obj               NUMBER (3);
      vo_flg_pesquisa               VARCHAR2 (1);
      vo_flg_inclusao               VARCHAR2 (1);
      vo_flg_alteracao              VARCHAR2 (1);
      vo_flg_exclusao               VARCHAR2 (1);
   BEGIN
      v_flg_pesquisa := '';
      v_flg_inclusao := '';
      v_flg_alteracao := '';
      v_flg_exclusao := '';
      v_flg_pesquisa := '';
      v_cod_grupo := '';
      v_cod_grupo_obj := '';
      vo_flg_inclusao := '';
      vo_flg_alteracao := '';
      vo_flg_exclusao := '';

-- DEPENDENTE DO IFRSEG
      BEGIN
         SELECT DECODE (a.flg_consulta_acesso, 0, 'N', 1, 'S') flg_pesquisa,
                DECODE (a.flg_inclusao_acesso, 0, 'N', 1, 'S') flg_inclusao,
                DECODE (a.flg_alteracao_acesso, 0, 'N', 1, 'S') flg_alteracao,
                DECODE (a.flg_exclusao_acesso, 0, 'N', 1, 'S') flg_exclusao,
                a.cod_grupo_acesso cod_grupo,
                a.num_cod_grupo_obj
           INTO v_flg_pesquisa,
                v_flg_inclusao,
                v_flg_alteracao,
                v_flg_exclusao,
                v_cod_grupo,
                v_cod_grupo_obj
           FROM ifrseg.cad_acesso a,
                ifrseg.cad_usuario b
          WHERE b.nom_username =
                             pck_seguranca.stf_separausername (p_usuario, 'U')
            AND a.cod_sistema_acesso =
                             pck_seguranca.stf_separausername (p_usuario, 'A')
            AND b.cod_usuario = a.cod_usuario_acesso;
      EXCEPTION
         WHEN OTHERS THEN
            NULL;
      END;

      BEGIN
         SELECT DECODE (c.flg_consulta_grupo_menu, 0, 'N', 1, 'S')
                                                                 flg_pesquisa,
                DECODE (c.flg_inclusao_grupo_menu, 0, 'N', 1, 'S')
                                                                 flg_inclusao,
                DECODE (c.flg_alteracao_grupo_menu, 0, 'N', 1, 'S')
                                                                flg_alteracao,
                DECODE (c.flg_exclusao_grupo_menu, 0, 'N', 1, 'S')
                                                                 flg_exclusao
           INTO v_flg_pesquisa,
                v_flg_inclusao,
                v_flg_alteracao,
                v_flg_exclusao
           FROM ifrseg.viw_tabela_formulario a,
                ifrseg.cad_menu_sistema b,
                ifrseg.cad_grupo_menu c,
                ifrseg.cad_formulario d
          WHERE a.nom_objeto = p_objeto
            AND a.num_seq_objeto = d.num_seq_tabela_formulario
--            AND c.cod_grupo_grupo_menu = v_cod_grupo
            AND b.cod_sistema_menu =
                             pck_seguranca.stf_separausername (p_usuario, 'A')
            AND d.num_seq_formulario = b.num_seq_formulario_menu
            AND b.cod_sistema_menu = c.cod_sistema_grupo_menu
            AND b.num_funcao_menu = c.num_funcao_grupo_menu;
      EXCEPTION
         WHEN OTHERS THEN
            NULL;
      END;

      BEGIN
         SELECT DECODE (a.flg_consulta_acesso_obj, 0, 'N', 1, 'S')
                                                                 flg_pesquisa,
                DECODE (a.flg_inclusao_acesso_obj, 0, 'N', 1, 'S')
                                                                 flg_inclusao,
                DECODE (a.flg_alteracao_acesso_obj, 0, 'N', 1, 'S')
                                                                flg_alteracao,
                DECODE (a.flg_exclusao_acesso_obj, 0, 'N', 1, 'S')
                                                                 flg_exclusao
           INTO v_flg_pesquisa,
                v_flg_inclusao,
                v_flg_alteracao,
                v_flg_exclusao
           FROM ifrseg.cad_acesso_objeto a,
                ifrseg.viw_tabela_formulario b
          WHERE b.nom_objeto = p_objeto
            AND a.num_cod_grupo_acesso_obj = v_cod_grupo_obj
            AND a.cod_sistema_grupo =
                             pck_seguranca.stf_separausername (p_usuario, 'A')
            AND b.num_seq_objeto = a.num_seq_objeto;
      EXCEPTION
         WHEN OTHERS THEN
            NULL;
      END;

--
      IF p_acao = 'PESQUISA' THEN
         IF vo_flg_pesquisa <> '' THEN
            IF vo_flg_pesquisa = 'S' THEN
               RETURN TRUE;
            ELSE
               RETURN FALSE;
            END IF;
         ELSE
            IF v_flg_pesquisa = 'S' THEN
               RETURN TRUE;
            ELSE
               RETURN FALSE;
            END IF;
         END IF;
      END IF;

--
      IF p_acao = 'INCLUI' THEN
         IF vo_flg_inclusao <> '' THEN
            IF vo_flg_inclusao = 'S' THEN
               RETURN TRUE;
            ELSE
               RETURN FALSE;
            END IF;
         ELSE
            IF v_flg_inclusao = 'S' THEN
               RETURN TRUE;
            ELSE
               RETURN FALSE;
            END IF;
         END IF;
      END IF;

--
      IF p_acao = 'ALTERA' THEN
         IF vo_flg_alteracao <> '' THEN
            IF vo_flg_alteracao = 'S' THEN
               RETURN TRUE;
            ELSE
               RETURN FALSE;
            END IF;
         ELSE
            IF v_flg_alteracao = 'S' THEN
               RETURN TRUE;
            ELSE
               RETURN FALSE;
            END IF;
         END IF;
      END IF;

--
      IF p_acao = 'EXCLUI' THEN
         IF vo_flg_exclusao <> '' THEN
            IF vo_flg_exclusao = 'S' THEN
               RETURN TRUE;
            ELSE
               RETURN FALSE;
            END IF;
         ELSE
            IF v_flg_exclusao = 'S' THEN
               RETURN TRUE;
            ELSE
               RETURN FALSE;
            END IF;
         END IF;
      END IF;
   END;

-------------------------------------------------------------------------------
   -- retorna todas as permissoes de um usuario sobre um objeto
   PROCEDURE stp_permissoes (
      p_usuario                  IN       VARCHAR2,
      p_objeto                   IN       VARCHAR2,
      vo_pesquisa                OUT      tyt_ok,
      vo_exclui                  OUT      tyt_ok,
      vo_inclui                  OUT      tyt_ok,
      vo_altera                  OUT      tyt_ok
   ) AS
   BEGIN
      vo_pesquisa (1) := 0;
      vo_exclui (1) := 0;
      vo_inclui (1) := 0;
      vo_altera (1) := 0;

      IF stf_permitido (p_usuario, p_objeto, 'PESQUISA') THEN
         vo_pesquisa (1) := 1;
      END IF;

      IF stf_permitido (p_usuario, p_objeto, 'EXCLUI') THEN
         vo_exclui (1) := 1;
      END IF;

      IF stf_permitido (p_usuario, p_objeto, 'INCLUI') THEN
         vo_inclui (1) := 1;
      END IF;

      IF stf_permitido (p_usuario, p_objeto, 'ALTERA') THEN
         vo_altera (1) := 1;
      END IF;
   END;

--------------------------------------------------------------------
-- Armazena Log de acesso
   PROCEDURE stp_log (
      p_sessionid                IN       VARCHAR2,
      p_tabela                   IN       VARCHAR2,
      p_tipo                     IN       VARCHAR2,
      p_dado                     IN       VARCHAR2
   ) AS
      vnumseq                       ifrseg.tab_log.num_seq_sessionid_log%TYPE;
      v_sessionid                   ifrseg.tab_acesso.num_sessionid%TYPE;
      v_sistema                     ifrseg.tab_acesso.cod_sistema_acesso%TYPE;
      v_usuario                     ifrseg.tab_acesso.nom_username_acesso%TYPE;
   BEGIN
      v_sessionid :=
                  UPPER (pck_seguranca.stf_separausername (p_sessionid, 'S'));
      v_sistema := pck_seguranca.stf_separausername (p_sessionid, 'A');
      v_usuario := pck_seguranca.stf_separausername (p_sessionid, 'U');

      IF UPPER (v_usuario) = 'ANONYMOUS' THEN
         v_usuario := pck_seguranca.stf_separausername (p_sessionid, 'M');
      END IF;

      SELECT num_seq_sessionid
        INTO vnumseq
        FROM ifrseg.tab_acesso
       WHERE UPPER (num_sessionid) = v_sessionid
         AND UPPER (nom_username_acesso) = UPPER (v_usuario)
         AND cod_sistema_acesso = v_sistema
         AND dat_encerramento IS NULL;

      IF SQL%ROWCOUNT = 1 THEN
         INSERT INTO ifrseg.viw_tab_log
                     (log_cod,
                      log_data,
                      log_tabela,
                      log_tipo,
                      log_dado,
                      log_num_seq_sessionid_log
                     )
              VALUES (UPPER (pck_seguranca.stf_separausername (p_sessionid,
                                                               'S'
                                                              )
                            ),
                      SYSDATE,
                      pck_sistema.stf_num_seq_tabela (p_tabela),
                      p_tipo,
                      p_dado,
                      vnumseq
                     );
      ELSE
         raise_application_error
                              (-20100,
                               'LOG - Sessão não encontrada para usuário '
                               || v_usuario
                               || ' e sistema '
                               || v_sistema
                              );
      END IF;
   END;

--------------------------------------------------------------------
-- Próximo Número do Segurança
   FUNCTION stf_proximo_seq
      RETURN NUMBER AS
      v_num                         NUMBER;
   BEGIN
      SELECT seq_num_seq_seguranca.NEXTVAL
        INTO v_num
        FROM DUAL;

      RETURN v_num;
   END;

--------------------------------------------------------------------
-- Separa o Username, a Session e o Sistema
-- Tipo = "U" --> UserName
-- Tipo = "S" --> SessionID
-- Tipo = "A" --> Sistema
-- Tipo = "C" --> CPF
-- Tipo = "M" --> Matrícula
-- Tipo = "B" --> Banco
   FUNCTION stf_separausername (
      p_usuario                  IN       VARCHAR2,
      p_tipo                     IN       VARCHAR2
   )
      RETURN VARCHAR2 AS
      v_username                    ifrseg.viw_cad_usuario.nom_username%TYPE;
      v_sessionid                   ifrseg.viw_tab_acesso.acs_sessionid%TYPE;
      v_sistema                     ifrseg.viw_tab_acesso.acs_sistema%TYPE;
      v_cpf                         ifrseg.viw_cad_usuario.num_cpf%TYPE;
      v_matricula                   ifrseg.viw_cad_solic_usr.cod_infraero_cont_solic%TYPE;
      v_banco                       VARCHAR2 (10);
      v_ind1                        NUMBER;
      v_ind2                        NUMBER;
      v_ind3                        NUMBER;
      v_ind4                        NUMBER;
      v_ind5                        NUMBER;
   BEGIN
      v_ind1 := INSTR (p_usuario, ';');
      v_ind2 := INSTR (p_usuario, '|');
      v_ind3 := INSTR (p_usuario, '!');
      v_ind4 := INSTR (p_usuario, '-');
      v_ind5 := INSTR (p_usuario, '#');
      v_username := TRIM (SUBSTR (p_usuario, 1, v_ind1 - 1));
            /*
            v_sessionid :=
               paranumero (TRIM (SUBSTR (p_usuario,
                                         v_ind1 + 1,
                                         (v_ind2 - (v_ind1 + 1))
                                        )
                                )
                          );
      */
      v_sessionid :=
         UPPER (TRIM (SUBSTR (p_usuario, v_ind1 + 1, (v_ind2 - (v_ind1 + 1))))
               );
      v_sistema :=
                TRIM (SUBSTR (p_usuario, v_ind2 + 1, (v_ind3 - (v_ind2 + 1))));
      v_cpf := TRIM (SUBSTR (p_usuario, v_ind3 + 1, (v_ind4 - (v_ind3 + 1))));
      v_matricula :=
                TRIM (SUBSTR (p_usuario, v_ind4 + 1, (v_ind5 - (v_ind4 + 1))));
      v_banco :=
           TRIM (SUBSTR (p_usuario, v_ind5 + 1, (LENGTH (p_usuario) - v_ind5)));

      IF UPPER (p_tipo) = 'U' THEN
         RETURN v_username;
      END IF;

      IF UPPER (p_tipo) = 'S' THEN
         RETURN v_sessionid;
      END IF;

      IF UPPER (p_tipo) = 'A' THEN
         RETURN v_sistema;
      END IF;

      IF UPPER (p_tipo) = 'C' THEN
         RETURN v_cpf;
      END IF;

      IF UPPER (p_tipo) = 'M' THEN
         RETURN v_matricula;
      END IF;

      IF UPPER (p_tipo) = 'B' THEN
         RETURN v_banco;
      END IF;
   END;

   FUNCTION paranumero (
      p_strvalor                 IN       VARCHAR2
   )
      RETURN NUMBER AS
      i                             NUMBER;
      novo                          VARCHAR2 (30);
   BEGIN
      novo := '';

      FOR i IN 1 .. LENGTH (TRIM (p_strvalor))
      LOOP
         IF SUBSTR (TRIM (p_strvalor), i, 1) IN
                          ('0', '1', '2', '3', '4', '5', '6', '7', '8', '9') THEN
            novo := novo || SUBSTR (TRIM (p_strvalor), i, 1);
         END IF;
      END LOOP;

      RETURN TO_NUMBER (novo);
   END;

--------------------------------------------------------------------
-- Pesquisa Cadastro de Role
-- retorna o recordset correspondente
   PROCEDURE stp_pesquisa_cad_role (
      p_usuario                  IN       VARCHAR2,
      vo_num_seq_role            OUT      tyt_num_seq_role,
      vo_nom_role                OUT      tyt_nom_role,
      vo_dsc_role                OUT      tyt_dsc_role,
      vi_num_seq_role            IN       t_num_seq_role
   ) AS
   BEGIN
      IF ifrseg.pck_seguranca.stf_permitido (p_usuario,
                                             'VIW_CAD_ROLE',
                                             'PESQUISA'
                                            ) THEN
         SELECT num_seq_role,
                nom_role,
                dsc_role
           INTO vo_num_seq_role (1),
                vo_nom_role (1),
                vo_dsc_role (1)
           FROM ifrseg.viw_cad_role
          WHERE num_seq_role = vi_num_seq_role;
      END IF;
   EXCEPTION
      WHEN OTHERS THEN
         raise_application_error (-20100, SQLERRM);
   END;

   -- Exclui Cadastro de Role
   -- retorna o OK ou não
   PROCEDURE stp_exclui_cad_role (
      p_usuario                  IN       VARCHAR2,
      vo_ok                      OUT      tyt_ok,
      vi_num_seq_role            IN       t_num_seq_role
   ) AS
      CURSOR c_cursor IS
         SELECT     *
               FROM ifrseg.viw_cad_role
              WHERE num_seq_role = vi_num_seq_role
         FOR UPDATE;

      v_viw_cad_role                ifrseg.viw_cad_role%ROWTYPE;
      v_dado                        VARCHAR2 (4000) := NULL;
   BEGIN
      vo_ok (1) := 0;

      IF ifrseg.pck_seguranca.stf_permitido (p_usuario,
                                             'VIW_CAD_ROLE',
                                             'EXCLUI'
                                            ) THEN
         OPEN c_cursor;

         FETCH c_cursor
          INTO v_viw_cad_role;

         IF NOT c_cursor%NOTFOUND THEN
            v_dado :=
                   'num_seq_role = ' || TO_CHAR (v_viw_cad_role.num_seq_role);
            v_dado :=
               v_dado
               || ','
               || 'nom_role = '
               || RTRIM (LTRIM (UPPER (v_viw_cad_role.nom_role)));
            v_dado :=
               v_dado
               || ','
               || 'dsc_role = '
               || RTRIM (LTRIM (UPPER (v_viw_cad_role.dsc_role)));

            IF c_cursor%ROWCOUNT = 1 THEN
               vo_ok (1) := 1;
               -- LOG
               ifrseg.pck_seguranca.stp_log (p_usuario,
                                             'VIW_CAD_ROLE',
                                             'E',
                                             v_dado
                                            );

               DELETE FROM ifrseg.viw_cad_role
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
-- Inclui Cadastro de Role
-- retorna o recordset correspondente
   PROCEDURE stp_inclui_cad_role (
      p_usuario                  IN       VARCHAR2,
      vo_num_seq_role            OUT      tyt_num_seq_role,
      vo_nom_role                OUT      tyt_nom_role,
      vo_dsc_role                OUT      tyt_dsc_role,
      vi_nom_role                IN       t_nom_role,
      vi_dsc_role                IN       t_dsc_role
   ) AS
      v_num_seq_role                viw_cad_role.num_seq_role%TYPE;
      v_nom_role                    viw_cad_role.nom_role%TYPE;
      v_dsc_role                    viw_cad_role.dsc_role%TYPE;
      v_dado                        VARCHAR2 (4000) := NULL;
   BEGIN
      IF ifrseg.pck_seguranca.stf_permitido (p_usuario,
                                             'VIW_CAD_ROLE',
                                             'INCLUI'
                                            ) THEN
         SELECT seq_num_seq_seguranca.NEXTVAL
           INTO v_num_seq_role
           FROM DUAL;

         v_nom_role := RTRIM (LTRIM (vi_nom_role));
         v_dsc_role := RTRIM (LTRIM (vi_dsc_role));

         INSERT INTO ifrseg.viw_cad_role
                     (num_seq_role,
                      nom_role,
                      dsc_role
                     )
              VALUES (v_num_seq_role,
                      v_nom_role,
                      v_dsc_role
                     );

         IF SQL%ROWCOUNT = 1 THEN
            stp_pesquisa_cad_role (p_usuario,
                                   vo_num_seq_role,
                                   vo_nom_role,
                                   vo_dsc_role,
                                   v_num_seq_role
                                  );
            v_dado := 'num_seq_role = ' || TO_CHAR (v_num_seq_role);
            v_dado :=
                  v_dado || ',' || 'nom_role = ' || RTRIM (LTRIM (v_nom_role));
            v_dado :=
                  v_dado || ',' || 'dsc_role = ' || RTRIM (LTRIM (v_dsc_role));
            -- LOG
            ifrseg.pck_seguranca.stp_log (p_usuario,
                                          'VIW_CAD_ROLE',
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
-- Altera Cadastro de Role
-- retorna o recordset correspondente
   PROCEDURE stp_altera_cad_role (
      p_usuario                  IN       VARCHAR2,
      vo_num_seq_role            OUT      tyt_num_seq_role,
      vo_nom_role                OUT      tyt_nom_role,
      vo_dsc_role                OUT      tyt_dsc_role,
      vi_num_seq_role            IN       t_num_seq_role,
      vi_nom_role                IN       t_nom_role,
      vi_dsc_role                IN       t_dsc_role
   ) AS
      CURSOR c_cursor IS
         SELECT     *
               FROM ifrseg.viw_cad_role
              WHERE num_seq_role = vi_num_seq_role
         FOR UPDATE;

      v_viw_cad_role                ifrseg.viw_cad_role%ROWTYPE;
      v_num_seq_role                ifrseg.viw_cad_role.num_seq_role%TYPE;
      v_nom_role                    ifrseg.viw_cad_role.nom_role%TYPE;
      v_dsc_role                    ifrseg.viw_cad_role.dsc_role%TYPE;
      v_dado                        VARCHAR2 (4000) := NULL;
   BEGIN
      IF ifrseg.pck_seguranca.stf_permitido (p_usuario,
                                             'VIW_CAD_ROLE',
                                             'ALTERA'
                                            ) THEN
         OPEN c_cursor;

         FETCH c_cursor
          INTO v_viw_cad_role;

         IF NOT c_cursor%NOTFOUND THEN
            v_nom_role := RTRIM (LTRIM (vi_nom_role));
            v_dsc_role := RTRIM (LTRIM (vi_dsc_role));
            v_num_seq_role := vi_num_seq_role;

            UPDATE ifrseg.viw_cad_role
               SET nom_role = v_nom_role,
                   dsc_role = v_dsc_role
             WHERE CURRENT OF c_cursor;

            IF SQL%ROWCOUNT = 1 THEN
               stp_pesquisa_cad_role (p_usuario,
                                      vo_num_seq_role,
                                      vo_nom_role,
                                      vo_dsc_role,
                                      vi_num_seq_role
                                     );
               v_dado := 'num_seq_role = ' || TO_CHAR (v_num_seq_role);
               v_dado :=
                  v_dado || ',' || 'nom_role = ' || RTRIM (LTRIM (v_nom_role));
               v_dado :=
                  v_dado || ',' || 'dsc_role = ' || RTRIM (LTRIM (v_dsc_role));
               -- LOG
               ifrseg.pck_seguranca.stp_log (p_usuario,
                                             'VIW_CAD_ROLE',
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
-- Pesquisa Sistema Rloe
-- retorna o recordset correspondente
   PROCEDURE stp_pesquisa_cad_role_sistema (
      p_usuario                  IN       VARCHAR2,
      vo_num_seq_role_sistema    OUT      tyt_num_seq_role_sistema,
      vo_cod_sistema_role        OUT      tyt_cod_sistema_role,
      vi_num_seq_role_sistema    IN       t_num_seq_role_sistema,
      vi_cod_sistema_role        IN       t_cod_sistema_role
   ) AS
   BEGIN
      IF ifrseg.pck_seguranca.stf_permitido (p_usuario,
                                             'VIW_CAD_ROLE_SISTEMA',
                                             'PESQUISA'
                                            ) THEN
         SELECT num_seq_role_sistema,
                cod_sistema_role
           INTO vo_num_seq_role_sistema (1),
                vo_cod_sistema_role (1)
           FROM ifrseg.viw_cad_role_sistema
          WHERE num_seq_role_sistema = vi_num_seq_role_sistema
            AND cod_sistema_role = vi_cod_sistema_role;
      END IF;
   EXCEPTION
      WHEN OTHERS THEN
         raise_application_error (-20100, SQLERRM);
   END;

   -- Exclui Sistema Rloe
   -- retorna o OK ou não
   PROCEDURE stp_exclui_cad_role_sistema (
      p_usuario                  IN       VARCHAR2,
      vo_ok                      OUT      tyt_ok,
      vi_num_seq_role_sistema    IN       t_num_seq_role_sistema,
      vi_cod_sistema_role        IN       t_cod_sistema_role
   ) AS
      CURSOR c_cursor IS
         SELECT     *
               FROM ifrseg.viw_cad_role_sistema
              WHERE num_seq_role_sistema = vi_num_seq_role_sistema
                AND cod_sistema_role = vi_cod_sistema_role
         FOR UPDATE;

      v_viw_cad_role_sistema        ifrseg.viw_cad_role_sistema%ROWTYPE;
      v_dado                        VARCHAR2 (4000) := NULL;
   BEGIN
      vo_ok (1) := 0;

      IF ifrseg.pck_seguranca.stf_permitido (p_usuario,
                                             'VIW_CAD_ROLE_SISTEMA',
                                             'EXCLUI'
                                            ) THEN
         OPEN c_cursor;

         FETCH c_cursor
          INTO v_viw_cad_role_sistema;

         IF NOT c_cursor%NOTFOUND THEN
            v_dado :=
               'num_seq_role_sistema = '
               || TO_CHAR (v_viw_cad_role_sistema.num_seq_role_sistema);
            v_dado :=
               v_dado
               || ','
               || 'cod_sistema_role = '
               || TO_CHAR (v_viw_cad_role_sistema.cod_sistema_role);

            IF c_cursor%ROWCOUNT = 1 THEN
               vo_ok (1) := 1;
               -- LOG
               ifrseg.pck_seguranca.stp_log (p_usuario,
                                             'VIW_CAD_ROLE_SISTEMA',
                                             'E',
                                             v_dado
                                            );

               DELETE FROM ifrseg.viw_cad_role_sistema
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
-- Inclui Sistema Rloe
-- retorna o recordset correspondente
   PROCEDURE stp_inclui_cad_role_sistema (
      p_usuario                  IN       VARCHAR2,
      vo_num_seq_role_sistema    OUT      tyt_num_seq_role_sistema,
      vo_cod_sistema_role        OUT      tyt_cod_sistema_role,
      vi_num_seq_role_sistema    IN       t_num_seq_role_sistema,
      vi_cod_sistema_role        IN       t_cod_sistema_role
   ) AS
      v_num_seq_role_sistema        viw_cad_role_sistema.num_seq_role_sistema%TYPE;
      v_cod_sistema_role            viw_cad_role_sistema.cod_sistema_role%TYPE;
      v_dado                        VARCHAR2 (4000) := NULL;
   BEGIN
      IF ifrseg.pck_seguranca.stf_permitido (p_usuario,
                                             'VIW_CAD_ROLE_SISTEMA',
                                             'INCLUI'
                                            ) THEN
         v_num_seq_role_sistema := vi_num_seq_role_sistema;
         v_cod_sistema_role := vi_cod_sistema_role;

         INSERT INTO ifrseg.viw_cad_role_sistema
                     (num_seq_role_sistema,
                      cod_sistema_role
                     )
              VALUES (v_num_seq_role_sistema,
                      v_cod_sistema_role
                     );

         IF SQL%ROWCOUNT = 1 THEN
            stp_pesquisa_cad_role_sistema (p_usuario,
                                           vo_num_seq_role_sistema,
                                           vo_cod_sistema_role,
                                           v_num_seq_role_sistema,
                                           v_cod_sistema_role
                                          );
            v_dado :=
                 'num_seq_role_sistema = ' || TO_CHAR (v_num_seq_role_sistema);
            v_dado :=
               v_dado
               || ','
               || 'cod_sistema_role = '
               || TO_CHAR (v_cod_sistema_role);
            -- LOG
            ifrseg.pck_seguranca.stp_log (p_usuario,
                                          'VIW_CAD_ROLE_SISTEMA',
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
-- Altera Sistema Rloe
-- retorna o recordset correspondente
   PROCEDURE stp_altera_cad_role_sistema (
      p_usuario                  IN       VARCHAR2,
      vo_num_seq_role_sistema    OUT      tyt_num_seq_role_sistema,
      vo_cod_sistema_role        OUT      tyt_cod_sistema_role,
      vi_num_seq_role_sistema    IN       t_num_seq_role_sistema,
      vi_cod_sistema_role        IN       t_cod_sistema_role
   ) AS
      CURSOR c_cursor IS
         SELECT     *
               FROM ifrseg.viw_cad_role_sistema
              WHERE num_seq_role_sistema = vi_num_seq_role_sistema
                AND cod_sistema_role = vi_cod_sistema_role
         FOR UPDATE;

      v_viw_cad_role_sistema        ifrseg.viw_cad_role_sistema%ROWTYPE;
      v_num_seq_role_sistema        ifrseg.viw_cad_role_sistema.num_seq_role_sistema%TYPE;
      v_cod_sistema_role            ifrseg.viw_cad_role_sistema.cod_sistema_role%TYPE;
      v_dado                        VARCHAR2 (4000) := NULL;
   BEGIN
      IF ifrseg.pck_seguranca.stf_permitido (p_usuario,
                                             'VIW_CAD_ROLE_SISTEMA',
                                             'ALTERA'
                                            ) THEN
         OPEN c_cursor;

         FETCH c_cursor
          INTO v_viw_cad_role_sistema;

         IF NOT c_cursor%NOTFOUND THEN
            v_num_seq_role_sistema := vi_num_seq_role_sistema;
            v_cod_sistema_role := vi_cod_sistema_role;

/*            UPDATE IFRSEG.viw_cad_role_sistema
            SET
            WHERE CURRENT of c_cursor;
*/
            IF SQL%ROWCOUNT = 1 THEN
               stp_pesquisa_cad_role_sistema (p_usuario,
                                              vo_num_seq_role_sistema,
                                              vo_cod_sistema_role,
                                              vi_num_seq_role_sistema,
                                              vi_cod_sistema_role
                                             );
               v_dado :=
                  'num_seq_role_sistema = '
                  || TO_CHAR (v_num_seq_role_sistema);
               v_dado :=
                  v_dado
                  || ','
                  || 'cod_sistema_role = '
                  || TO_CHAR (v_cod_sistema_role);
               -- LOG
               ifrseg.pck_seguranca.stp_log (p_usuario,
                                             'VIW_CAD_ROLE_SISTEMA',
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
-- Pesquisa LOG DO SISTEMA
-- retorna o recordset correspondente
   PROCEDURE stp_pesquisa_log (
      p_usuario                  IN       VARCHAR2,
      vo_num_seq_log             OUT      tyt_num_seq_log,
      vo_data_log                OUT      tyt_data_log,
      vo_sistema                 OUT      tyt_sistema,
      vo_viw_tabela              OUT      tyt_viw_tabela,
      vo_username                OUT      tyt_username,
      vo_nome                    OUT      tyt_nome,
      vo_unidade                 OUT      tyt_unidade,
      vo_tipo                    OUT      tyt_tipo,
      vo_descricao               OUT      tyt_descricao,
      vi_num_seq_log             IN       t_num_seq_log
   ) AS
   BEGIN
      IF ifrseg.pck_seguranca.stf_permitido (p_usuario, 'VIW_LOG',
                                             'PESQUISA') THEN
         SELECT num_seq_log,
                data_log,
                sistema,
                viw_tabela,
                username,
                nome,
                unidade,
                tipo,
                descricao
           INTO vo_num_seq_log (1),
                vo_data_log (1),
                vo_sistema (1),
                vo_viw_tabela (1),
                vo_username (1),
                vo_nome (1),
                vo_unidade (1),
                vo_tipo (1),
                vo_descricao (1)
           FROM ifrseg.viw_log
          WHERE num_seq_log = vi_num_seq_log;
      END IF;
   EXCEPTION
      WHEN OTHERS THEN
         raise_application_error (-20100, SQLERRM);
   END;

   -- Exclui LOG DO SISTEMA
   -- retorna o OK ou não
   PROCEDURE stp_exclui_log (
      p_usuario                  IN       VARCHAR2,
      vo_ok                      OUT      tyt_ok,
      vi_num_seq_log             IN       t_num_seq_log
   ) AS
      CURSOR c_cursor IS
         SELECT     *
               FROM ifrseg.viw_log
              WHERE num_seq_log = vi_num_seq_log
         FOR UPDATE;

      v_viw_log                     ifrseg.viw_log%ROWTYPE;
      v_dado                        VARCHAR2 (4000) := NULL;
   BEGIN
      vo_ok (1) := 0;

      IF ifrseg.pck_seguranca.stf_permitido (p_usuario, 'VIW_LOG', 'EXCLUI') THEN
         OPEN c_cursor;

         FETCH c_cursor
          INTO v_viw_log;

         IF NOT c_cursor%NOTFOUND THEN
            v_dado := 'num_seq_log = ' || TO_CHAR (v_viw_log.num_seq_log);
            v_dado :=
               v_dado
               || ','
               || 'data_log = '
               || RTRIM (LTRIM (UPPER (v_viw_log.data_log)));
            v_dado :=
               v_dado
               || ','
               || 'sistema = '
               || RTRIM (LTRIM (UPPER (v_viw_log.sistema)));
            v_dado :=
               v_dado
               || ','
               || 'viw_tabela = '
               || RTRIM (LTRIM (UPPER (v_viw_log.viw_tabela)));
            v_dado :=
               v_dado
               || ','
               || 'username = '
               || RTRIM (LTRIM (UPPER (v_viw_log.username)));
            v_dado :=
               v_dado
               || ','
               || 'nome = '
               || RTRIM (LTRIM (UPPER (v_viw_log.nome)));
            v_dado :=
               v_dado
               || ','
               || 'unidade = '
               || RTRIM (LTRIM (UPPER (v_viw_log.unidade)));
            v_dado :=
               v_dado
               || ','
               || 'tipo = '
               || RTRIM (LTRIM (UPPER (v_viw_log.tipo)));
            v_dado :=
               v_dado
               || ','
               || 'descricao = '
               || RTRIM (LTRIM (UPPER (v_viw_log.descricao)));

            IF c_cursor%ROWCOUNT = 1 THEN
               vo_ok (1) := 1;
               -- LOG
               ifrseg.pck_seguranca.stp_log (p_usuario,
                                             'VIW_LOG',
                                             'E',
                                             v_dado
                                            );

               DELETE FROM ifrseg.viw_log
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
-- Inclui LOG DO SISTEMA
-- retorna o recordset correspondente
   PROCEDURE stp_inclui_log (
      p_usuario                  IN       VARCHAR2,
      vo_num_seq_log             OUT      tyt_num_seq_log,
      vo_data_log                OUT      tyt_data_log,
      vo_sistema                 OUT      tyt_sistema,
      vo_viw_tabela              OUT      tyt_viw_tabela,
      vo_username                OUT      tyt_username,
      vo_nome                    OUT      tyt_nome,
      vo_unidade                 OUT      tyt_unidade,
      vo_tipo                    OUT      tyt_tipo,
      vo_descricao               OUT      tyt_descricao,
      vi_num_seq_log             IN       t_num_seq_log,
      vi_data_log                IN       t_data_log,
      vi_sistema                 IN       t_sistema,
      vi_viw_tabela              IN       t_viw_tabela,
      vi_username                IN       t_username,
      vi_nome                    IN       t_nome,
      vi_unidade                 IN       t_unidade,
      vi_tipo                    IN       t_tipo,
      vi_descricao               IN       t_descricao
   ) AS
      v_num_seq_log                 viw_log.num_seq_log%TYPE;
      v_data_log                    viw_log.data_log%TYPE;
      v_sistema                     viw_log.sistema%TYPE;
      v_viw_tabela                  viw_log.viw_tabela%TYPE;
      v_username                    viw_log.username%TYPE;
      v_nome                        viw_log.nome%TYPE;
      v_unidade                     viw_log.unidade%TYPE;
      v_tipo                        viw_log.tipo%TYPE;
      v_descricao                   viw_log.descricao%TYPE;
      v_dado                        VARCHAR2 (4000) := NULL;
   BEGIN
      IF ifrseg.pck_seguranca.stf_permitido (p_usuario, 'VIW_LOG', 'INCLUI') THEN
         v_data_log := RTRIM (LTRIM (vi_data_log));
         v_sistema := RTRIM (LTRIM (vi_sistema));
         v_viw_tabela := RTRIM (LTRIM (vi_viw_tabela));
         v_username := RTRIM (LTRIM (vi_username));
         v_nome := RTRIM (LTRIM (vi_nome));
         v_unidade := RTRIM (LTRIM (vi_unidade));
         v_tipo := RTRIM (LTRIM (vi_tipo));
         v_descricao := RTRIM (LTRIM (vi_descricao));
         v_num_seq_log := vi_num_seq_log;

         INSERT INTO ifrseg.viw_log
                     (num_seq_log,
                      data_log,
                      sistema,
                      viw_tabela,
                      username,
                      nome,
                      unidade,
                      tipo,
                      descricao
                     )
              VALUES (v_num_seq_log,
                      v_data_log,
                      v_sistema,
                      v_viw_tabela,
                      v_username,
                      v_nome,
                      v_unidade,
                      v_tipo,
                      v_descricao
                     );

         IF SQL%ROWCOUNT = 1 THEN
            stp_pesquisa_log (p_usuario,
                              vo_num_seq_log,
                              vo_data_log,
                              vo_sistema,
                              vo_viw_tabela,
                              vo_username,
                              vo_nome,
                              vo_unidade,
                              vo_tipo,
                              vo_descricao,
                              v_num_seq_log
                             );
            v_dado := 'num_seq_log = ' || TO_CHAR (v_num_seq_log);
            v_dado :=
                  v_dado || ',' || 'data_log = ' || RTRIM (LTRIM (v_data_log));
            v_dado :=
                    v_dado || ',' || 'sistema = ' || RTRIM (LTRIM (v_sistema));
            v_dado :=
               v_dado || ',' || 'viw_tabela = '
               || RTRIM (LTRIM (v_viw_tabela));
            v_dado :=
                  v_dado || ',' || 'username = ' || RTRIM (LTRIM (v_username));
            v_dado := v_dado || ',' || 'nome = ' || RTRIM (LTRIM (v_nome));
            v_dado :=
                    v_dado || ',' || 'unidade = ' || RTRIM (LTRIM (v_unidade));
            v_dado := v_dado || ',' || 'tipo = ' || RTRIM (LTRIM (v_tipo));
            v_dado :=
                v_dado || ',' || 'descricao = ' || RTRIM (LTRIM (v_descricao));
            -- LOG
            ifrseg.pck_seguranca.stp_log (p_usuario, 'VIW_LOG', 'I', v_dado);
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
-- Altera LOG DO SISTEMA
-- retorna o recordset correspondente
   PROCEDURE stp_altera_log (
      p_usuario                  IN       VARCHAR2,
      vo_num_seq_log             OUT      tyt_num_seq_log,
      vo_data_log                OUT      tyt_data_log,
      vo_sistema                 OUT      tyt_sistema,
      vo_viw_tabela              OUT      tyt_viw_tabela,
      vo_username                OUT      tyt_username,
      vo_nome                    OUT      tyt_nome,
      vo_unidade                 OUT      tyt_unidade,
      vo_tipo                    OUT      tyt_tipo,
      vo_descricao               OUT      tyt_descricao,
      vi_num_seq_log             IN       t_num_seq_log,
      vi_data_log                IN       t_data_log,
      vi_sistema                 IN       t_sistema,
      vi_viw_tabela              IN       t_viw_tabela,
      vi_username                IN       t_username,
      vi_nome                    IN       t_nome,
      vi_unidade                 IN       t_unidade,
      vi_tipo                    IN       t_tipo,
      vi_descricao               IN       t_descricao
   ) AS
      CURSOR c_cursor IS
         SELECT     *
               FROM ifrseg.viw_log
              WHERE num_seq_log = vi_num_seq_log
         FOR UPDATE;

      v_viw_log                     ifrseg.viw_log%ROWTYPE;
      v_num_seq_log                 ifrseg.viw_log.num_seq_log%TYPE;
      v_data_log                    ifrseg.viw_log.data_log%TYPE;
      v_sistema                     ifrseg.viw_log.sistema%TYPE;
      v_viw_tabela                  ifrseg.viw_log.viw_tabela%TYPE;
      v_username                    ifrseg.viw_log.username%TYPE;
      v_nome                        ifrseg.viw_log.nome%TYPE;
      v_unidade                     ifrseg.viw_log.unidade%TYPE;
      v_tipo                        ifrseg.viw_log.tipo%TYPE;
      v_descricao                   ifrseg.viw_log.descricao%TYPE;
      v_dado                        VARCHAR2 (4000) := NULL;
   BEGIN
      IF ifrseg.pck_seguranca.stf_permitido (p_usuario, 'VIW_LOG', 'ALTERA') THEN
         OPEN c_cursor;

         FETCH c_cursor
          INTO v_viw_log;

         IF NOT c_cursor%NOTFOUND THEN
            v_data_log := RTRIM (LTRIM (vi_data_log));
            v_sistema := RTRIM (LTRIM (vi_sistema));
            v_viw_tabela := RTRIM (LTRIM (vi_viw_tabela));
            v_username := RTRIM (LTRIM (vi_username));
            v_nome := RTRIM (LTRIM (vi_nome));
            v_unidade := RTRIM (LTRIM (vi_unidade));
            v_tipo := RTRIM (LTRIM (vi_tipo));
            v_descricao := RTRIM (LTRIM (vi_descricao));
            v_num_seq_log := vi_num_seq_log;

            UPDATE ifrseg.viw_log
               SET data_log = v_data_log,
                   sistema = v_sistema,
                   viw_tabela = v_viw_tabela,
                   username = v_username,
                   nome = v_nome,
                   unidade = v_unidade,
                   tipo = v_tipo,
                   descricao = v_descricao
             WHERE CURRENT OF c_cursor;

            IF SQL%ROWCOUNT = 1 THEN
               stp_pesquisa_log (p_usuario,
                                 vo_num_seq_log,
                                 vo_data_log,
                                 vo_sistema,
                                 vo_viw_tabela,
                                 vo_username,
                                 vo_nome,
                                 vo_unidade,
                                 vo_tipo,
                                 vo_descricao,
                                 vi_num_seq_log
                                );
               v_dado := 'num_seq_log = ' || TO_CHAR (v_num_seq_log);
               v_dado :=
                  v_dado || ',' || 'data_log = ' || RTRIM (LTRIM (v_data_log));
               v_dado :=
                    v_dado || ',' || 'sistema = ' || RTRIM (LTRIM (v_sistema));
               v_dado :=
                  v_dado
                  || ','
                  || 'viw_tabela = '
                  || RTRIM (LTRIM (v_viw_tabela));
               v_dado :=
                  v_dado || ',' || 'username = ' || RTRIM (LTRIM (v_username));
               v_dado := v_dado || ',' || 'nome = ' || RTRIM (LTRIM (v_nome));
               v_dado :=
                    v_dado || ',' || 'unidade = ' || RTRIM (LTRIM (v_unidade));
               v_dado := v_dado || ',' || 'tipo = ' || RTRIM (LTRIM (v_tipo));
               v_dado :=
                  v_dado || ',' || 'descricao = '
                  || RTRIM (LTRIM (v_descricao));
               -- LOG
               ifrseg.pck_seguranca.stp_log (p_usuario, 'VIW_LOG', 'A',
                                             v_dado);
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
---------------------------------------------------------------------------------
END;
/

-- Grants for Package Body
GRANT EXECUTE ON ifrseg.pck_seguranca TO bde_geral
/
-- End of DDL Script for Package Body IFRSEG.PCK_SEGURANCA

