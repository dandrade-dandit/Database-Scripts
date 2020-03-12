/* Formatted on 11/08/2005 16:44 (Formatter Plus v4.8.0) */
CREATE OR REPLACE TRIGGER ifrseg.trg_cad_solic_sist_usr_02_aiu
   AFTER INSERT OR UPDATE
   ON ifrseg.cad_solic_sistema_usuario
   REFERENCING NEW AS NEW OLD AS OLD
   FOR EACH ROW
DECLARE
   CURSOR usuario IS
      SELECT     flg_situacao_solic,
                 dat_aprovacao,
                 cod_usuario_solic,
                 flg_tipo_solicitacao,
                 cod_depend_usr_solic,
                 nom_username_solic,
                 dsc_email_solic,
                 DECODE (flg_infraero_contratada,
                         'I', 'Infraero',
                         'C', 'Contratada'
                        ) flg_infraero_contratada,
                 cod_infraero_contratada,
                 nom_usuario_solic
            FROM cad_solicitacao_usuario
           WHERE num_seq_solicitacao = :NEW.num_seq_solic_sist_usr
      FOR UPDATE;

   CURSOR gestor (
      cod_depend                          ifrseg.cad_solicitacao_usuario.cod_depend_usr_solic%TYPE
   ) IS
      SELECT b.dsc_email
        FROM ifrseg.viw_gestor_usuario a,
             ifrseg.cad_usuario b,
             ifrseg.cad_sistema_gestor_usuario c
       WHERE a.flg_processar_solicitacao = 1
         AND a.flg_autorizacao = 1
         AND c.cod_sist_gest_usr = :NEW.cod_sistema_solic_sist_usr
         AND a.num_seq_gestor_usuario = c.num_seq_gest_usr_sist
         AND a.cod_usuario_gest_usr = b.cod_usuario
         AND a.num_seq_gestor_usuario IN (
                                 SELECT num_seq_gest_usr_dependencia
                                   FROM ifrseg.cad_gestor_usr_dependencia
                                  WHERE cod_depend_usr_dependencia =
                                                                    cod_depend);

   CURSOR vrole (
      usr                                 viw_roles_usuarios.usuario%TYPE
   ) IS
      SELECT ROLE
        FROM viw_roles_usuarios
       WHERE upper(usuario) = upper(usr);

   msgemail                      VARCHAR2 (1000);
   assunto                       VARCHAR2 (100);
   remetente                     VARCHAR2 (100);
   remetentebanco                VARCHAR2 (100);
   destinatario                  VARCHAR2 (100);
   v_sgl_sistema                 ifrseg.cad_sistema.dsc_sgl_sistema%TYPE;
   envia                         BOOLEAN;
   enviabanco                    BOOLEAN;
   msgemailbanco                 VARCHAR2 (1000);
   assuntobanco                  VARCHAR2 (100);
   v_nom_role                    ifrseg.viw_role_sistema.nom_role%TYPE;
   v_nom_role_grupo              ifrseg.viw_role_sistema.nom_role%TYPE;
   v_role                        ifrseg.viw_role_sistema.nom_role%TYPE;
BEGIN
   remetente := NULL;
   destinatario := NULL;
   envia := FALSE;
   enviabanco := FALSE;
   msgemail := NULL;
   assunto := NULL;
   msgemailbanco := NULL;
   assuntobanco := NULL;
   remetentebanco := NULL;
   v_role := NULL;

   SELECT a.dsc_sgl_sistema
     INTO v_sgl_sistema
     FROM ifrseg.cad_sistema a
    WHERE a.cod_sistema = :NEW.cod_sistema_solic_sist_usr;

   FOR c IN usuario
   LOOP
      IF UPDATING THEN
         IF :NEW.flg_situacao_solic_sist_usr = 'C' THEN
            assunto := 'Autorizada solicitação';
            msgemail :='Usuário '||c.nom_username_solic||' Senha infraero. FAVOR TROCAR A SENHA NO PRIMEIRO ACESSO !!!';
			destinatario := c.dsc_email_solic;
            envia := TRUE;

            IF :OLD.cod_grupo_solic_sist_usr <> :NEW.cod_grupo_solic_sist_usr THEN
               BEGIN
                  SELECT nom_role
                    INTO v_nom_role
                    FROM ifrseg.viw_role_sistema
                   WHERE cod_sistema_role = :NEW.cod_sistema_solic_sist_usr;
               EXCEPTION
                  WHEN NO_DATA_FOUND THEN
                     v_nom_role := '';
               END;

               BEGIN
                  SELECT nom_role
                    INTO v_nom_role_grupo
                    FROM ifrseg.viw_cad_grupo,
                         ifrseg.cad_role
                   WHERE cod_sistema_grupo = :NEW.cod_sistema_solic_sist_usr
                     AND num_seq_role_grupo = num_seq_role
                     AND cod_grupo = :NEW.cod_grupo_solic_sist_usr;
               EXCEPTION
                  WHEN NO_DATA_FOUND THEN
                     v_nom_role_grupo := '';
               END;

               IF LENGTH (TRIM (v_nom_role_grupo)) <> 0 THEN
                  IF TRIM (v_nom_role) <> TRIM (v_nom_role_grupo) THEN
                     assuntobanco := 'Troca de privilégio';
                     remetentebanco := NULL;
                     msgemailbanco :=
                        'Solicito trocar o privilégio do usuário '
                        || c.nom_username_solic
                        || ' da role '
                        || v_nom_role
                        || ' para a role '
                        || v_nom_role_grupo
                        || '.';
                     enviabanco := TRUE;

                     FOR r IN vrole (c.nom_username_solic)
                     LOOP
                        IF UPPER (r.ROLE) = UPPER (v_nom_role_grupo) THEN
                           enviabanco := FALSE;
                        END IF;
                     END LOOP;
                  END IF;
               END IF;
            END IF;
         END IF;

         IF :NEW.flg_situacao_solic_sist_usr = 'N' THEN
            assunto := 'Solicitação de acesso';
            msgemail :=
               'Não foi possível autorizar sua solicitação. Favor entrar em contato com o gestor pelo endereço deste.';
            destinatario := c.dsc_email_solic;
            envia := TRUE;
         END IF;

         remetente := NULL;
      END IF;

      IF INSERTING THEN
         assunto := 'Solicitação de acesso';
         msgemail :=
            'Solicitação nº:'
            || :NEW.num_seq_solic_sist_usr
            || ' para o sistema '
            || v_sgl_sistema
            || ' da matrícula:'
            || c.flg_infraero_contratada
            || ' - '
            || c.cod_infraero_contratada
            || ' de '
            || c.nom_usuario_solic
            || '.';
         remetente := LOWER (c.dsc_email_solic);
         envia := TRUE;
         msgemailbanco := msgemail;

         BEGIN
            SELECT nom_role
              INTO v_nom_role
              FROM ifrseg.viw_role_sistema
             WHERE cod_sistema_role = :NEW.cod_sistema_solic_sist_usr;
         EXCEPTION
            WHEN NO_DATA_FOUND THEN
               v_nom_role := '';
         END;

         enviabanco := TRUE;

         IF LENGTH (TRIM (v_nom_role)) <> 0 THEN
            v_role := v_nom_role;

            FOR r IN vrole (c.nom_username_solic)
            LOOP
               IF UPPER (r.ROLE) = UPPER (v_role) THEN
                  v_nom_role := ' ';
                  enviabanco := FALSE;
               END IF;
            END LOOP;
         END IF;

         IF LENGTH (TRIM (v_nom_role)) <> 0 THEN
            msgemailbanco :=
               msgemailbanco
               || ' Nas roles SEG_ACESSO do PRODSEDE2 e '
               || v_nom_role
               || '.';
         ELSE
            enviabanco := TRUE;

            FOR r IN vrole (c.nom_username_solic)
            LOOP
               IF UPPER (r.ROLE) = 'SEG_ACESSO' THEN
                  enviabanco := FALSE;
               END IF;
            END LOOP;

            msgemailbanco :=
                          msgemailbanco || ' Na role SEG_ACESSO do PRODSEDE2.';
         END IF;

         assuntobanco := assunto;
      END IF;

      IF    envia
         OR enviabanco THEN
         FOR gst IN gestor (c.cod_depend_usr_solic)
         LOOP
            IF remetente IS NULL THEN
               remetente := LOWER (gst.dsc_email);
            END IF;

            IF destinatario IS NULL THEN
               destinatario := LOWER (gst.dsc_email);
            END IF;

            IF remetentebanco IS NULL THEN
               remetentebanco := LOWER (gst.dsc_email);
            END IF;
         END LOOP;
      END IF;

      IF     (envia)
         AND (NOT remetente IS NULL)
         AND (NOT destinatario IS NULL) THEN
         ifrseg.prc_envia_email (remetente, destinatario, assunto, msgemail);
      END IF;

      IF     (enviabanco)
         AND (NOT remetentebanco IS NULL) THEN
         ifrseg.prc_envia_email (remetentebanco,
                                 'banco_de_dados@infraero.gov.br',
                                 assuntobanco,
                                 msgemailbanco
                                );
      END IF;
   END LOOP;
EXCEPTION
   WHEN OTHERS THEN
      raise_application_error
                           (-20100,
                            SQLERRM
                            || ' Envio de email não concluido. Favor Verificar.'
                           );
END;
/

