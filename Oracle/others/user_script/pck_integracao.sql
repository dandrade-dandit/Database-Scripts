-- Start of DDL Script for Package Body IFRBDE.PCK_INTEGRACAO
-- Generated 2-dez-2004 20:36:57 from SYSMAN@HOMOLOG2

CREATE OR REPLACE 
PACKAGE BODY ifrbde.pck_integracao IS
--------------------------------------------------------------------
-- Pesquisa Contrato - Identificação
-- retorna o recordset correspondente
   PROCEDURE stp_pesquisa_conf_identificaca (
      p_usuario                  IN       VARCHAR2,
      vo_payable_entity_id       OUT      tyt_payable_entity_id,
      vo_contract_id             OUT      tyt_contract_id,
      vo_contract_versao         OUT      tyt_contract_versao,
      vo_contract_desc           OUT      tyt_contract_desc,
      vo_contract_status_code    OUT      tyt_contract_status_code,
      vo_contract_prev_status_code OUT    tyt_contract_prev_status_code,
      vo_contract_type           OUT      tyt_contract_type,
      vo_contract_sub_type       OUT      tyt_contract_sub_type,
      vo_contract_id_vendor      OUT      tyt_contract_id_vendor,
      vo_codigo_mod_contratacao  OUT      tyt_codigo_mod_contratacao,
      vo_manager_id              OUT      tyt_manager_id,
      vo_security_code           OUT      tyt_security_code,
      vo_sistema_origem_code     OUT      tyt_sistema_origem_code,
      vo_contract_versao_origem  OUT      tyt_contract_versao_origem,
      vo_date_created            OUT      tyt_date_created,
      vo_user_id_created         OUT      tyt_user_id_created,
      vo_date_changed            OUT      tyt_date_changed,
      vo_user_id_changed         OUT      tyt_user_id_changed,
      vo_inactive_ind            OUT      tyt_inactive_ind,
      vo_active_date             OUT      tyt_active_date,
      vi_payable_entity_id       IN       t_payable_entity_id,
      vi_contract_id             IN       t_contract_id,
      vi_contract_versao         IN       t_contract_versao
   ) AS
   BEGIN
      IF ifrseg.pck_seguranca.stf_permitido (p_usuario,
                                             'VIW_CONF_IDENTIFICACAO_U',
                                             'PESQUISA'
                                            ) THEN
         SELECT payable_entity_id,
                contract_id,
                contract_versao,
                contract_desc,
                contract_status_code,
                contract_prev_status_code,
                contract_type,
                contract_sub_type,
                contract_id_vendor,
                codigo_mod_contratacao,
                manager_id,
                security_code,
                sistema_origem_code,
                contract_versao_origem,
                date_created,
                user_id_created,
                date_changed,
                user_id_changed,
                inactive_ind,
                active_date
           INTO vo_payable_entity_id (1),
                vo_contract_id (1),
                vo_contract_versao (1),
                vo_contract_desc (1),
                vo_contract_status_code (1),
                vo_contract_prev_status_code (1),
                vo_contract_type (1),
                vo_contract_sub_type (1),
                vo_contract_id_vendor (1),
                vo_codigo_mod_contratacao (1),
                vo_manager_id (1),
                vo_security_code (1),
                vo_sistema_origem_code (1),
                vo_contract_versao_origem (1),
                vo_date_created (1),
                vo_user_id_created (1),
                vo_date_changed (1),
                vo_user_id_changed (1),
                vo_inactive_ind (1),
                vo_active_date (1)
           FROM ifrbde.viw_conf_identificacao_u
          WHERE payable_entity_id = vi_payable_entity_id
            AND contract_id = vi_contract_id
            AND contract_versao = vi_contract_versao;
      END IF;
   EXCEPTION
      WHEN OTHERS THEN
         raise_application_error (-20100, SQLERRM);
   END;

   -- Exclui Contrato - Identificação
   -- retorna o OK ou não
   PROCEDURE stp_exclui_conf_identificacao_ (
      p_usuario                  IN       VARCHAR2,
      vo_ok                      OUT      tyt_ok,
      vi_payable_entity_id       IN       t_payable_entity_id,
      vi_contract_id             IN       t_contract_id,
      vi_contract_versao         IN       t_contract_versao
   ) AS
      CURSOR c_cursor IS
         SELECT     *
               FROM ifrbde.viw_conf_identificacao_u
              WHERE payable_entity_id = vi_payable_entity_id
                AND contract_id = vi_contract_id
                AND contract_versao = vi_contract_versao
         FOR UPDATE;

      v_viw_conf_identificacao_u    ifrbde.viw_conf_identificacao_u%ROWTYPE;
      v_dado                        VARCHAR2 (4000) := NULL;
   BEGIN
      vo_ok (1) := 0;

      IF ifrseg.pck_seguranca.stf_permitido (p_usuario,
                                             'VIW_CONF_IDENTIFICACAO_U',
                                             'EXCLUI'
                                            ) THEN
         OPEN c_cursor;

         FETCH c_cursor
          INTO v_viw_conf_identificacao_u;

         IF NOT c_cursor%NOTFOUND THEN
            v_dado :=
               'payable_entity_id = '
               || RTRIM
                    (LTRIM
                          (UPPER (v_viw_conf_identificacao_u.payable_entity_id)
                          )
                    );
            v_dado :=
               v_dado
               || ','
               || 'contract_id = '
               || RTRIM (LTRIM (UPPER (v_viw_conf_identificacao_u.contract_id))
                        );
            v_dado :=
               v_dado
               || ','
               || 'contract_versao = '
               || RTRIM
                     (LTRIM (UPPER (v_viw_conf_identificacao_u.contract_versao)
                            )
                     );
            v_dado :=
               v_dado
               || ','
               || 'contract_desc = '
               || RTRIM
                       (LTRIM (UPPER (v_viw_conf_identificacao_u.contract_desc)
                              )
                       );
            v_dado :=
               v_dado
               || ','
               || 'contract_status_code = '
               || RTRIM
                    (LTRIM
                        (UPPER
                              (v_viw_conf_identificacao_u.contract_status_code)
                        )
                    );
            v_dado :=
               v_dado
               || ','
               || 'contract_prev_status_code = '
               || RTRIM
                    (LTRIM
                        (UPPER
                            (v_viw_conf_identificacao_u.contract_prev_status_code
                            )
                        )
                    );
            v_dado :=
               v_dado
               || ','
               || 'contract_type = '
               || RTRIM
                       (LTRIM (UPPER (v_viw_conf_identificacao_u.contract_type)
                              )
                       );
            v_dado :=
               v_dado
               || ','
               || 'contract_sub_type = '
               || RTRIM
                    (LTRIM
                          (UPPER (v_viw_conf_identificacao_u.contract_sub_type)
                          )
                    );
            v_dado :=
               v_dado
               || ','
               || 'contract_id_vendor = '
               || RTRIM
                    (LTRIM
                         (UPPER (v_viw_conf_identificacao_u.contract_id_vendor)
                         )
                    );
            v_dado :=
               v_dado
               || ','
               || 'codigo_mod_contratacao = '
               || RTRIM
                    (LTRIM
                        (UPPER
                            (v_viw_conf_identificacao_u.codigo_mod_contratacao)
                        )
                    );
            v_dado :=
               v_dado
               || ','
               || 'manager_id = '
               || RTRIM (LTRIM (UPPER (v_viw_conf_identificacao_u.manager_id)));
            v_dado :=
               v_dado
               || ','
               || 'security_code = '
               || RTRIM
                       (LTRIM (UPPER (v_viw_conf_identificacao_u.security_code)
                              )
                       );
            v_dado :=
               v_dado
               || ','
               || 'sistema_origem_code = '
               || RTRIM
                    (LTRIM
                        (UPPER (v_viw_conf_identificacao_u.sistema_origem_code)
                        )
                    );
            v_dado :=
               v_dado
               || ','
               || 'contract_versao_origem = '
               || RTRIM
                    (LTRIM
                        (UPPER
                            (v_viw_conf_identificacao_u.contract_versao_origem)
                        )
                    );
            v_dado :=
               v_dado
               || ','
               || 'date_created = '
               || TO_DATE (v_viw_conf_identificacao_u.date_created,
                           'DD/MM/YYYY'
                          );
            v_dado :=
               v_dado
               || ','
               || 'user_id_created = '
               || RTRIM
                     (LTRIM (UPPER (v_viw_conf_identificacao_u.user_id_created)
                            )
                     );
            v_dado :=
               v_dado
               || ','
               || 'date_changed = '
               || TO_DATE (v_viw_conf_identificacao_u.date_changed,
                           'DD/MM/YYYY'
                          );
            v_dado :=
               v_dado
               || ','
               || 'user_id_changed = '
               || RTRIM
                     (LTRIM (UPPER (v_viw_conf_identificacao_u.user_id_changed)
                            )
                     );
            v_dado :=
               v_dado
               || ','
               || 'inactive_ind = '
               || RTRIM (LTRIM (UPPER (v_viw_conf_identificacao_u.inactive_ind)
                               )
                        );
            v_dado :=
               v_dado
               || ','
               || 'active_date = '
               || TO_DATE (v_viw_conf_identificacao_u.active_date,
                           'DD/MM/YYYY'
                          );

            IF c_cursor%ROWCOUNT = 1 THEN
               vo_ok (1) := 1;
               -- LOG
               ifrseg.pck_seguranca.stp_log (p_usuario,
                                             'VIW_CONF_IDENTIFICACAO_U',
                                             'E',
                                             v_dado
                                            );

               DELETE FROM ifrbde.viw_conf_identificacao_u
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
-- Inclui Contrato - Identificação
-- retorna o recordset correspondente
   PROCEDURE stp_inclui_conf_identificacao_ (
      p_usuario                  IN       VARCHAR2,
      vo_payable_entity_id       OUT      tyt_payable_entity_id,
      vo_contract_id             OUT      tyt_contract_id,
      vo_contract_versao         OUT      tyt_contract_versao,
      vo_contract_desc           OUT      tyt_contract_desc,
      vo_contract_status_code    OUT      tyt_contract_status_code,
      vo_contract_prev_status_code OUT    tyt_contract_prev_status_code,
      vo_contract_type           OUT      tyt_contract_type,
      vo_contract_sub_type       OUT      tyt_contract_sub_type,
      vo_contract_id_vendor      OUT      tyt_contract_id_vendor,
      vo_codigo_mod_contratacao  OUT      tyt_codigo_mod_contratacao,
      vo_manager_id              OUT      tyt_manager_id,
      vo_security_code           OUT      tyt_security_code,
      vo_sistema_origem_code     OUT      tyt_sistema_origem_code,
      vo_contract_versao_origem  OUT      tyt_contract_versao_origem,
      vo_date_created            OUT      tyt_date_created,
      vo_user_id_created         OUT      tyt_user_id_created,
      vo_date_changed            OUT      tyt_date_changed,
      vo_user_id_changed         OUT      tyt_user_id_changed,
      vo_inactive_ind            OUT      tyt_inactive_ind,
      vo_active_date             OUT      tyt_active_date,
      vi_payable_entity_id       IN       t_payable_entity_id,
      vi_contract_id             IN       t_contract_id,
      vi_contract_versao         IN       t_contract_versao,
      vi_contract_desc           IN       t_contract_desc,
      vi_contract_type           IN       t_contract_type,
      vi_contract_sub_type       IN       t_contract_sub_type,
      vi_contract_id_vendor      IN       t_contract_id_vendor,
      vi_codigo_mod_contratacao  IN       t_codigo_mod_contratacao,
      vi_manager_id              IN       t_manager_id,
      vi_security_code           IN       t_security_code,
      vi_user_id_created         IN       t_user_id_created
   ) AS
      v_payable_entity_id           viw_conf_identificacao_u.payable_entity_id%TYPE;
      v_contract_id                 viw_conf_identificacao_u.contract_id%TYPE;
      v_contract_versao             viw_conf_identificacao_u.contract_versao%TYPE;
      v_contract_desc               viw_conf_identificacao_u.contract_desc%TYPE;
      v_contract_type               viw_conf_identificacao_u.contract_type%TYPE;
      v_contract_sub_type           viw_conf_identificacao_u.contract_sub_type%TYPE;
      v_contract_id_vendor          viw_conf_identificacao_u.contract_id_vendor%TYPE;
      v_codigo_mod_contratacao      viw_conf_identificacao_u.codigo_mod_contratacao%TYPE;
      v_manager_id                  viw_conf_identificacao_u.manager_id%TYPE;
      v_security_code               viw_conf_identificacao_u.security_code%TYPE;
      v_user_id_created             viw_conf_identificacao_u.user_id_created%TYPE;
      v_dado                        VARCHAR2 (4000) := NULL;
   BEGIN
      IF ifrseg.pck_seguranca.stf_permitido (p_usuario,
                                             'VIW_CONF_IDENTIFICACAO_U',
                                             'INCLUI'
                                            ) THEN
         v_payable_entity_id := RTRIM (LTRIM (vi_payable_entity_id));
         v_contract_id := RTRIM (LTRIM (vi_contract_id));
         v_contract_versao := RTRIM (LTRIM (vi_contract_versao));
         v_contract_desc := RTRIM (LTRIM (vi_contract_desc));
         v_contract_type := RTRIM (LTRIM (vi_contract_type));
         v_contract_sub_type := RTRIM (LTRIM (vi_contract_sub_type));
         v_contract_id_vendor := RTRIM (LTRIM (vi_contract_id_vendor));
         v_codigo_mod_contratacao :=
                                    RTRIM (LTRIM (vi_codigo_mod_contratacao));
         v_manager_id := RTRIM (LTRIM (vi_manager_id));
         v_security_code := RTRIM (LTRIM (vi_security_code));
         v_user_id_created := RTRIM (LTRIM (vi_user_id_created));

         INSERT INTO ifrbde.viw_conf_identificacao_u
                     (payable_entity_id,
                      contract_id,
                      contract_versao,
                      contract_desc,
                      contract_type,
                      contract_sub_type,
                      contract_id_vendor,
                      codigo_mod_contratacao,
                      manager_id,
                      security_code,
                      user_id_created
                     )
              VALUES (v_payable_entity_id,
                      v_contract_id,
                      v_contract_versao,
                      v_contract_desc,
                      v_contract_type,
                      v_contract_sub_type,
                      v_contract_id_vendor,
                      v_codigo_mod_contratacao,
                      v_manager_id,
                      v_security_code,
                      v_user_id_created
                     );

         IF SQL%ROWCOUNT = 1 THEN
            stp_pesquisa_conf_identificaca (p_usuario,
                                            vo_payable_entity_id,
                                            vo_contract_id,
                                            vo_contract_versao,
                                            vo_contract_desc,
                                            vo_contract_status_code,
                                            vo_contract_prev_status_code,
                                            vo_contract_type,
                                            vo_contract_sub_type,
                                            vo_contract_id_vendor,
                                            vo_codigo_mod_contratacao,
                                            vo_manager_id,
                                            vo_security_code,
                                            vo_sistema_origem_code,
                                            vo_contract_versao_origem,
                                            vo_date_created,
                                            vo_user_id_created,
                                            vo_date_changed,
                                            vo_user_id_changed,
                                            vo_inactive_ind,
                                            vo_active_date,
                                            v_payable_entity_id,
                                            v_contract_id,
                                            v_contract_versao
                                           );
            v_dado :=
                 'payable_entity_id = ' || RTRIM (LTRIM (v_payable_entity_id));
            v_dado :=
               v_dado || ',' || 'contract_id = '
               || RTRIM (LTRIM (v_contract_id));
            v_dado :=
               v_dado
               || ','
               || 'contract_versao = '
               || RTRIM (LTRIM (v_contract_versao));
            v_dado :=
               v_dado
               || ','
               || 'contract_desc = '
               || RTRIM (LTRIM (v_contract_desc));
            v_dado :=
               v_dado
               || ','
               || 'contract_type = '
               || RTRIM (LTRIM (v_contract_type));
            v_dado :=
               v_dado
               || ','
               || 'contract_sub_type = '
               || RTRIM (LTRIM (v_contract_sub_type));
            v_dado :=
               v_dado
               || ','
               || 'contract_id_vendor = '
               || RTRIM (LTRIM (v_contract_id_vendor));
            v_dado :=
               v_dado
               || ','
               || 'codigo_mod_contratacao = '
               || RTRIM (LTRIM (v_codigo_mod_contratacao));
            v_dado :=
               v_dado || ',' || 'manager_id = '
               || RTRIM (LTRIM (v_manager_id));
            v_dado :=
               v_dado
               || ','
               || 'security_code = '
               || RTRIM (LTRIM (v_security_code));
            v_dado :=
               v_dado
               || ','
               || 'user_id_created = '
               || RTRIM (LTRIM (v_user_id_created));
            -- LOG
            ifrseg.pck_seguranca.stp_log (p_usuario,
                                          'VIW_CONF_IDENTIFICACAO_U',
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
-- Altera Contrato - Identificação
-- retorna o recordset correspondente
   PROCEDURE stp_altera_conf_identificacao_ (
      p_usuario                  IN       VARCHAR2,
      vo_payable_entity_id       OUT      tyt_payable_entity_id,
      vo_contract_id             OUT      tyt_contract_id,
      vo_contract_versao         OUT      tyt_contract_versao,
      vo_contract_desc           OUT      tyt_contract_desc,
      vo_contract_status_code    OUT      tyt_contract_status_code,
      vo_contract_prev_status_code OUT    tyt_contract_prev_status_code,
      vo_contract_type           OUT      tyt_contract_type,
      vo_contract_sub_type       OUT      tyt_contract_sub_type,
      vo_contract_id_vendor      OUT      tyt_contract_id_vendor,
      vo_codigo_mod_contratacao  OUT      tyt_codigo_mod_contratacao,
      vo_manager_id              OUT      tyt_manager_id,
      vo_security_code           OUT      tyt_security_code,
      vo_sistema_origem_code     OUT      tyt_sistema_origem_code,
      vo_contract_versao_origem  OUT      tyt_contract_versao_origem,
      vo_date_created            OUT      tyt_date_created,
      vo_user_id_created         OUT      tyt_user_id_created,
      vo_date_changed            OUT      tyt_date_changed,
      vo_user_id_changed         OUT      tyt_user_id_changed,
      vo_inactive_ind            OUT      tyt_inactive_ind,
      vo_active_date             OUT      tyt_active_date,
      vi_payable_entity_id       IN       t_payable_entity_id,
      vi_contract_id             IN       t_contract_id,
      vi_contract_versao         IN       t_contract_versao,
      vi_contract_desc           IN       t_contract_desc,
      vi_contract_type           IN       t_contract_type,
      vi_contract_sub_type       IN       t_contract_sub_type,
      vi_contract_id_vendor      IN       t_contract_id_vendor,
      vi_codigo_mod_contratacao  IN       t_codigo_mod_contratacao,
      vi_manager_id              IN       t_manager_id,
      vi_security_code           IN       t_security_code,
      vi_user_id_created         IN       t_user_id_created
   ) AS
      CURSOR c_cursor IS
         SELECT     *
               FROM ifrbde.viw_conf_identificacao_u
              WHERE payable_entity_id = vi_payable_entity_id
                AND contract_id = vi_contract_id
                AND contract_versao = vi_contract_versao
         FOR UPDATE;

      v_viw_conf_identificacao_u    ifrbde.viw_conf_identificacao_u%ROWTYPE;
      v_payable_entity_id           ifrbde.viw_conf_identificacao_u.payable_entity_id%TYPE;
      v_contract_id                 ifrbde.viw_conf_identificacao_u.contract_id%TYPE;
      v_contract_versao             ifrbde.viw_conf_identificacao_u.contract_versao%TYPE;
      v_contract_desc               ifrbde.viw_conf_identificacao_u.contract_desc%TYPE;
      v_contract_type               ifrbde.viw_conf_identificacao_u.contract_type%TYPE;
      v_contract_sub_type           ifrbde.viw_conf_identificacao_u.contract_sub_type%TYPE;
      v_contract_id_vendor          ifrbde.viw_conf_identificacao_u.contract_id_vendor%TYPE;
      v_codigo_mod_contratacao      ifrbde.viw_conf_identificacao_u.codigo_mod_contratacao%TYPE;
      v_manager_id                  ifrbde.viw_conf_identificacao_u.manager_id%TYPE;
      v_security_code               ifrbde.viw_conf_identificacao_u.security_code%TYPE;
      v_user_id_created             ifrbde.viw_conf_identificacao_u.user_id_created%TYPE;
      v_dado                        VARCHAR2 (4000) := NULL;
   BEGIN
      IF ifrseg.pck_seguranca.stf_permitido (p_usuario,
                                             'VIW_CONF_IDENTIFICACAO_U',
                                             'ALTERA'
                                            ) THEN
         OPEN c_cursor;

         FETCH c_cursor
          INTO v_viw_conf_identificacao_u;

         IF NOT c_cursor%NOTFOUND THEN
            v_payable_entity_id := RTRIM (LTRIM (vi_payable_entity_id));
            v_contract_id := RTRIM (LTRIM (vi_contract_id));
            v_contract_versao := RTRIM (LTRIM (vi_contract_versao));
            v_contract_desc := RTRIM (LTRIM (vi_contract_desc));
            v_contract_type := RTRIM (LTRIM (vi_contract_type));
            v_contract_sub_type := RTRIM (LTRIM (vi_contract_sub_type));
            v_contract_id_vendor := RTRIM (LTRIM (vi_contract_id_vendor));
            v_codigo_mod_contratacao :=
                                    RTRIM (LTRIM (vi_codigo_mod_contratacao));
            v_manager_id := RTRIM (LTRIM (vi_manager_id));
            v_security_code := RTRIM (LTRIM (vi_security_code));
            v_user_id_created := RTRIM (LTRIM (vi_user_id_created));

            UPDATE ifrbde.viw_conf_identificacao_u
               SET contract_desc = v_contract_desc,
                   contract_type = v_contract_type,
                   contract_sub_type = v_contract_sub_type,
                   contract_id_vendor = v_contract_id_vendor,
                   codigo_mod_contratacao = v_codigo_mod_contratacao,
                   manager_id = v_manager_id,
                   security_code = v_security_code,
                   user_id_created = v_user_id_created
             WHERE CURRENT OF c_cursor;

            IF SQL%ROWCOUNT = 1 THEN
               stp_pesquisa_conf_identificaca (p_usuario,
                                               vo_payable_entity_id,
                                               vo_contract_id,
                                               vo_contract_versao,
                                               vo_contract_desc,
                                               vo_contract_status_code,
                                               vo_contract_prev_status_code,
                                               vo_contract_type,
                                               vo_contract_sub_type,
                                               vo_contract_id_vendor,
                                               vo_codigo_mod_contratacao,
                                               vo_manager_id,
                                               vo_security_code,
                                               vo_sistema_origem_code,
                                               vo_contract_versao_origem,
                                               vo_date_created,
                                               vo_user_id_created,
                                               vo_date_changed,
                                               vo_user_id_changed,
                                               vo_inactive_ind,
                                               vo_active_date,
                                               vi_payable_entity_id,
                                               vi_contract_id,
                                               vi_contract_versao
                                              );
               v_dado :=
                  'payable_entity_id = '
                  || RTRIM (LTRIM (v_payable_entity_id));
               v_dado :=
                  v_dado
                  || ','
                  || 'contract_id = '
                  || RTRIM (LTRIM (v_contract_id));
               v_dado :=
                  v_dado
                  || ','
                  || 'contract_versao = '
                  || RTRIM (LTRIM (v_contract_versao));
               v_dado :=
                  v_dado
                  || ','
                  || 'contract_desc = '
                  || RTRIM (LTRIM (v_contract_desc));
               v_dado :=
                  v_dado
                  || ','
                  || 'contract_type = '
                  || RTRIM (LTRIM (v_contract_type));
               v_dado :=
                  v_dado
                  || ','
                  || 'contract_sub_type = '
                  || RTRIM (LTRIM (v_contract_sub_type));
               v_dado :=
                  v_dado
                  || ','
                  || 'contract_id_vendor = '
                  || RTRIM (LTRIM (v_contract_id_vendor));
               v_dado :=
                  v_dado
                  || ','
                  || 'codigo_mod_contratacao = '
                  || RTRIM (LTRIM (v_codigo_mod_contratacao));
               v_dado :=
                  v_dado
                  || ','
                  || 'manager_id = '
                  || RTRIM (LTRIM (v_manager_id));
               v_dado :=
                  v_dado
                  || ','
                  || 'security_code = '
                  || RTRIM (LTRIM (v_security_code));
               v_dado :=
                  v_dado
                  || ','
                  || 'user_id_created = '
                  || RTRIM (LTRIM (v_user_id_created));
               -- LOG
               ifrseg.pck_seguranca.stp_log (p_usuario,
                                             'VIW_CONF_IDENTIFICACAO_U',
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
-- Pesquisa Contrato - Objeto
-- retorna o recordset correspondente
   PROCEDURE stp_pesquisa_conf_objeto_u (
      p_usuario                  IN       VARCHAR2,
      vo_payable_entity_id_obj   OUT      tyt_payable_entity_id_obj,
      vo_contract_id_obj         OUT      tyt_contract_id_obj,
      vo_contract_versao_obj     OUT      tyt_contract_versao_obj,
      vo_objeto_desc             OUT      tyt_objeto_desc,
      vo_sistema_origem_code_obj OUT      tyt_sistema_origem_code_obj,
      vo_contract_versao_origem_obj OUT   tyt_contract_versao_origem_obj,
      vo_date_created_obj        OUT      tyt_date_created_obj,
      vo_user_id_created_obj     OUT      tyt_user_id_created_obj,
      vo_date_changed_obj        OUT      tyt_date_changed_obj,
      vo_user_id_changed_obj     OUT      tyt_user_id_changed_obj,
      vo_inactive_ind_obj        OUT      tyt_inactive_ind_obj,
      vo_active_date_obj         OUT      tyt_active_date_obj,
      vi_payable_entity_id_obj   IN       t_payable_entity_id_obj,
      vi_contract_id_obj         IN       t_contract_id_obj,
      vi_contract_versao_obj     IN       t_contract_versao_obj
   ) AS
   BEGIN
      IF ifrseg.pck_seguranca.stf_permitido (p_usuario,
                                             'VIW_CONF_OBJETO_U',
                                             'PESQUISA'
                                            ) THEN
         SELECT payable_entity_id_obj,
                contract_id_obj,
                contract_versao_obj,
                objeto_desc,
                sistema_origem_code_obj,
                contract_versao_origem_obj,
                date_created_obj,
                user_id_created_obj,
                date_changed_obj,
                user_id_changed_obj,
                inactive_ind_obj,
                active_date_obj
           INTO vo_payable_entity_id_obj (1),
                vo_contract_id_obj (1),
                vo_contract_versao_obj (1),
                vo_objeto_desc (1),
                vo_sistema_origem_code_obj (1),
                vo_contract_versao_origem_obj (1),
                vo_date_created_obj (1),
                vo_user_id_created_obj (1),
                vo_date_changed_obj (1),
                vo_user_id_changed_obj (1),
                vo_inactive_ind_obj (1),
                vo_active_date_obj (1)
           FROM ifrbde.viw_conf_objeto_u
          WHERE payable_entity_id_obj = vi_payable_entity_id_obj
            AND contract_id_obj = vi_contract_id_obj
            AND contract_versao_obj = vi_contract_versao_obj;
      END IF;
   EXCEPTION
      WHEN OTHERS THEN
         raise_application_error (-20100, SQLERRM);
   END;

   -- Exclui Contrato - Objeto
   -- retorna o OK ou não
   PROCEDURE stp_exclui_conf_objeto_u (
      p_usuario                  IN       VARCHAR2,
      vo_ok                      OUT      tyt_ok,
      vi_payable_entity_id_obj   IN       t_payable_entity_id_obj,
      vi_contract_id_obj         IN       t_contract_id_obj,
      vi_contract_versao_obj     IN       t_contract_versao_obj
   ) AS
      CURSOR c_cursor IS
         SELECT     *
               FROM ifrbde.viw_conf_objeto_u
              WHERE payable_entity_id_obj = vi_payable_entity_id_obj
                AND contract_id_obj = vi_contract_id_obj
                AND contract_versao_obj = vi_contract_versao_obj
         FOR UPDATE;

      v_viw_conf_objeto_u           ifrbde.viw_conf_objeto_u%ROWTYPE;
      v_dado                        VARCHAR2 (4000) := NULL;
   BEGIN
      vo_ok (1) := 0;

      IF ifrseg.pck_seguranca.stf_permitido (p_usuario,
                                             'VIW_CONF_OBJETO_U',
                                             'EXCLUI'
                                            ) THEN
         OPEN c_cursor;

         FETCH c_cursor
          INTO v_viw_conf_objeto_u;

         IF NOT c_cursor%NOTFOUND THEN
            v_dado :=
               'payable_entity_id_obj = '
               || RTRIM
                      (LTRIM (UPPER (v_viw_conf_objeto_u.payable_entity_id_obj)
                             )
                      );
            v_dado :=
               v_dado
               || ','
               || 'contract_id_obj = '
               || RTRIM (LTRIM (UPPER (v_viw_conf_objeto_u.contract_id_obj)));
            v_dado :=
               v_dado
               || ','
               || 'contract_versao_obj = '
               || RTRIM (LTRIM (UPPER (v_viw_conf_objeto_u.contract_versao_obj)
                               )
                        );
            v_dado :=
               v_dado
               || ','
               || 'objeto_desc = '
               || RTRIM (LTRIM (UPPER (v_viw_conf_objeto_u.objeto_desc)));
            v_dado :=
               v_dado
               || ','
               || 'sistema_origem_code_obj = '
               || RTRIM
                    (LTRIM (UPPER (v_viw_conf_objeto_u.sistema_origem_code_obj)
                           )
                    );
            v_dado :=
               v_dado
               || ','
               || 'contract_versao_origem_obj = '
               || RTRIM
                    (LTRIM
                        (UPPER (v_viw_conf_objeto_u.contract_versao_origem_obj)
                        )
                    );
            v_dado :=
               v_dado
               || ','
               || 'date_created_obj = '
               || TO_DATE (v_viw_conf_objeto_u.date_created_obj, 'DD/MM/YYYY');
            v_dado :=
               v_dado
               || ','
               || 'user_id_created_obj = '
               || RTRIM (LTRIM (UPPER (v_viw_conf_objeto_u.user_id_created_obj)
                               )
                        );
            v_dado :=
               v_dado
               || ','
               || 'date_changed_obj = '
               || TO_DATE (v_viw_conf_objeto_u.date_changed_obj, 'DD/MM/YYYY');
            v_dado :=
               v_dado
               || ','
               || 'user_id_changed_obj = '
               || RTRIM (LTRIM (UPPER (v_viw_conf_objeto_u.user_id_changed_obj)
                               )
                        );
            v_dado :=
               v_dado
               || ','
               || 'inactive_ind_obj = '
               || RTRIM (LTRIM (UPPER (v_viw_conf_objeto_u.inactive_ind_obj)));
            v_dado :=
               v_dado
               || ','
               || 'active_date_obj = '
               || TO_DATE (v_viw_conf_objeto_u.active_date_obj, 'DD/MM/YYYY');

            IF c_cursor%ROWCOUNT = 1 THEN
               vo_ok (1) := 1;
               -- LOG
               ifrseg.pck_seguranca.stp_log (p_usuario,
                                             'VIW_CONF_OBJETO_U',
                                             'E',
                                             v_dado
                                            );

               DELETE FROM ifrbde.viw_conf_objeto_u
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
-- Inclui Contrato - Objeto
-- retorna o recordset correspondente
   PROCEDURE stp_inclui_conf_objeto_u (
      p_usuario                  IN       VARCHAR2,
      vo_payable_entity_id_obj   OUT      tyt_payable_entity_id_obj,
      vo_contract_id_obj         OUT      tyt_contract_id_obj,
      vo_contract_versao_obj     OUT      tyt_contract_versao_obj,
      vo_objeto_desc             OUT      tyt_objeto_desc,
      vo_sistema_origem_code_obj OUT      tyt_sistema_origem_code_obj,
      vo_contract_versao_origem_obj OUT   tyt_contract_versao_origem_obj,
      vo_date_created_obj        OUT      tyt_date_created_obj,
      vo_user_id_created_obj     OUT      tyt_user_id_created_obj,
      vo_date_changed_obj        OUT      tyt_date_changed_obj,
      vo_user_id_changed_obj     OUT      tyt_user_id_changed_obj,
      vo_inactive_ind_obj        OUT      tyt_inactive_ind_obj,
      vo_active_date_obj         OUT      tyt_active_date_obj,
      vi_payable_entity_id_obj   IN       t_payable_entity_id_obj,
      vi_contract_id_obj         IN       t_contract_id_obj,
      vi_contract_versao_obj     IN       t_contract_versao_obj,
      vi_objeto_desc             IN       t_objeto_desc,
      vi_user_id_created_obj     IN       t_user_id_created_obj
   ) AS
      v_payable_entity_id_obj       viw_conf_objeto_u.payable_entity_id_obj%TYPE;
      v_contract_id_obj             viw_conf_objeto_u.contract_id_obj%TYPE;
      v_contract_versao_obj         viw_conf_objeto_u.contract_versao_obj%TYPE;
      v_objeto_desc                 viw_conf_objeto_u.objeto_desc%TYPE;
      v_user_id_created_obj         viw_conf_objeto_u.user_id_created_obj%TYPE;
      v_dado                        VARCHAR2 (4000) := NULL;
   BEGIN
      IF ifrseg.pck_seguranca.stf_permitido (p_usuario,
                                             'VIW_CONF_OBJETO_U',
                                             'INCLUI'
                                            ) THEN
         v_payable_entity_id_obj := RTRIM (LTRIM (vi_payable_entity_id_obj));
         v_contract_id_obj := RTRIM (LTRIM (vi_contract_id_obj));
         v_contract_versao_obj := RTRIM (LTRIM (vi_contract_versao_obj));
         v_objeto_desc := RTRIM (LTRIM (vi_objeto_desc));
         v_user_id_created_obj := RTRIM (LTRIM (vi_user_id_created_obj));

         INSERT INTO ifrbde.viw_conf_objeto_u
                     (payable_entity_id_obj,
                      contract_id_obj,
                      contract_versao_obj,
                      objeto_desc,
                      user_id_created_obj
                     )
              VALUES (v_payable_entity_id_obj,
                      v_contract_id_obj,
                      v_contract_versao_obj,
                      v_objeto_desc,
                      v_user_id_created_obj
                     );

         IF SQL%ROWCOUNT = 1 THEN
            stp_pesquisa_conf_objeto_u (p_usuario,
                                        vo_payable_entity_id_obj,
                                        vo_contract_id_obj,
                                        vo_contract_versao_obj,
                                        vo_objeto_desc,
                                        vo_sistema_origem_code_obj,
                                        vo_contract_versao_origem_obj,
                                        vo_date_created_obj,
                                        vo_user_id_created_obj,
                                        vo_date_changed_obj,
                                        vo_user_id_changed_obj,
                                        vo_inactive_ind_obj,
                                        vo_active_date_obj,
                                        v_payable_entity_id_obj,
                                        v_contract_id_obj,
                                        v_contract_versao_obj
                                       );
            v_dado :=
               'payable_entity_id_obj = '
               || RTRIM (LTRIM (v_payable_entity_id_obj));
            v_dado :=
               v_dado
               || ','
               || 'contract_id_obj = '
               || RTRIM (LTRIM (v_contract_id_obj));
            v_dado :=
               v_dado
               || ','
               || 'contract_versao_obj = '
               || RTRIM (LTRIM (v_contract_versao_obj));
            v_dado :=
               v_dado || ',' || 'objeto_desc = '
               || RTRIM (LTRIM (v_objeto_desc));
            v_dado :=
               v_dado
               || ','
               || 'user_id_created_obj = '
               || RTRIM (LTRIM (v_user_id_created_obj));
            -- LOG
            ifrseg.pck_seguranca.stp_log (p_usuario,
                                          'VIW_CONF_OBJETO_U',
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
-- Altera Contrato - Objeto
-- retorna o recordset correspondente
   PROCEDURE stp_altera_conf_objeto_u (
      p_usuario                  IN       VARCHAR2,
      vo_payable_entity_id_obj   OUT      tyt_payable_entity_id_obj,
      vo_contract_id_obj         OUT      tyt_contract_id_obj,
      vo_contract_versao_obj     OUT      tyt_contract_versao_obj,
      vo_objeto_desc             OUT      tyt_objeto_desc,
      vo_sistema_origem_code_obj OUT      tyt_sistema_origem_code_obj,
      vo_contract_versao_origem_obj OUT   tyt_contract_versao_origem_obj,
      vo_date_created_obj        OUT      tyt_date_created_obj,
      vo_user_id_created_obj     OUT      tyt_user_id_created_obj,
      vo_date_changed_obj        OUT      tyt_date_changed_obj,
      vo_user_id_changed_obj     OUT      tyt_user_id_changed_obj,
      vo_inactive_ind_obj        OUT      tyt_inactive_ind_obj,
      vo_active_date_obj         OUT      tyt_active_date_obj,
      vi_payable_entity_id_obj   IN       t_payable_entity_id_obj,
      vi_contract_id_obj         IN       t_contract_id_obj,
      vi_contract_versao_obj     IN       t_contract_versao_obj,
      vi_objeto_desc             IN       t_objeto_desc,
      vi_user_id_created_obj     IN       t_user_id_created_obj
   ) AS
      CURSOR c_cursor IS
         SELECT     *
               FROM ifrbde.viw_conf_objeto_u
              WHERE payable_entity_id_obj = vi_payable_entity_id_obj
                AND contract_id_obj = vi_contract_id_obj
                AND contract_versao_obj = vi_contract_versao_obj
         FOR UPDATE;

      v_viw_conf_objeto_u           ifrbde.viw_conf_objeto_u%ROWTYPE;
      v_payable_entity_id_obj       ifrbde.viw_conf_objeto_u.payable_entity_id_obj%TYPE;
      v_contract_id_obj             ifrbde.viw_conf_objeto_u.contract_id_obj%TYPE;
      v_contract_versao_obj         ifrbde.viw_conf_objeto_u.contract_versao_obj%TYPE;
      v_objeto_desc                 ifrbde.viw_conf_objeto_u.objeto_desc%TYPE;
      v_user_id_created_obj         ifrbde.viw_conf_objeto_u.user_id_created_obj%TYPE;
      v_dado                        VARCHAR2 (4000) := NULL;
   BEGIN
      IF ifrseg.pck_seguranca.stf_permitido (p_usuario,
                                             'VIW_CONF_OBJETO_U',
                                             'ALTERA'
                                            ) THEN
         OPEN c_cursor;

         FETCH c_cursor
          INTO v_viw_conf_objeto_u;

         IF NOT c_cursor%NOTFOUND THEN
            v_payable_entity_id_obj :=
                                     RTRIM (LTRIM (vi_payable_entity_id_obj));
            v_contract_id_obj := RTRIM (LTRIM (vi_contract_id_obj));
            v_contract_versao_obj := RTRIM (LTRIM (vi_contract_versao_obj));
            v_objeto_desc := RTRIM (LTRIM (vi_objeto_desc));
            v_user_id_created_obj := RTRIM (LTRIM (vi_user_id_created_obj));

            UPDATE ifrbde.viw_conf_objeto_u
               SET objeto_desc = v_objeto_desc,
                   user_id_created_obj = v_user_id_created_obj
             WHERE CURRENT OF c_cursor;

            IF SQL%ROWCOUNT = 1 THEN
               stp_pesquisa_conf_objeto_u (p_usuario,
                                           vo_payable_entity_id_obj,
                                           vo_contract_id_obj,
                                           vo_contract_versao_obj,
                                           vo_objeto_desc,
                                           vo_sistema_origem_code_obj,
                                           vo_contract_versao_origem_obj,
                                           vo_date_created_obj,
                                           vo_user_id_created_obj,
                                           vo_date_changed_obj,
                                           vo_user_id_changed_obj,
                                           vo_inactive_ind_obj,
                                           vo_active_date_obj,
                                           vi_payable_entity_id_obj,
                                           vi_contract_id_obj,
                                           vi_contract_versao_obj
                                          );
               v_dado :=
                  'payable_entity_id_obj = '
                  || RTRIM (LTRIM (v_payable_entity_id_obj));
               v_dado :=
                  v_dado
                  || ','
                  || 'contract_id_obj = '
                  || RTRIM (LTRIM (v_contract_id_obj));
               v_dado :=
                  v_dado
                  || ','
                  || 'contract_versao_obj = '
                  || RTRIM (LTRIM (v_contract_versao_obj));
               v_dado :=
                  v_dado
                  || ','
                  || 'objeto_desc = '
                  || RTRIM (LTRIM (v_objeto_desc));
               v_dado :=
                  v_dado
                  || ','
                  || 'user_id_created_obj = '
                  || RTRIM (LTRIM (v_user_id_created_obj));
               -- LOG
               ifrseg.pck_seguranca.stp_log (p_usuario,
                                             'VIW_CONF_OBJETO_U',
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
-- Pesquisa Contrato - Datas e Prazos
-- retorna o recordset correspondente
   PROCEDURE stp_pesquisa_conf_datas_u (
      p_usuario                  IN       VARCHAR2,
      vo_payable_entity_id_dt    OUT      tyt_payable_entity_id_dt,
      vo_contract_id_dt          OUT      tyt_contract_id_dt,
      vo_contract_versao_dt      OUT      tyt_contract_versao_dt,
      vo_proposta_data           OUT      tyt_proposta_data,
      vo_assinatura_data         OUT      tyt_assinatura_data,
      vo_tipo_prazo              OUT      tyt_tipo_prazo,
      vo_quant_prazo             OUT      tyt_quant_prazo,
      vo_entrega_data            OUT      tyt_entrega_data,
      vo_garantia_data           OUT      tyt_garantia_data,
      vo_inicio_data             OUT      tyt_inicio_data,
      vo_termino_prev_data       OUT      tyt_termino_prev_data,
      vo_termino_data            OUT      tyt_termino_data,
      vo_sistema_origem_code_dt  OUT      tyt_sistema_origem_code_dt,
      vo_contract_versao_origem_dt OUT    tyt_contract_versao_origem_dt,
      vo_date_created_dt         OUT      tyt_date_created_dt,
      vo_user_id_created_dt      OUT      tyt_user_id_created_dt,
      vo_date_changed_dt         OUT      tyt_date_changed_dt,
      vo_user_id_changed_dt      OUT      tyt_user_id_changed_dt,
      vo_inactive_ind_dt         OUT      tyt_inactive_ind_dt,
      vo_active_date_dt          OUT      tyt_active_date_dt,
      vi_payable_entity_id_dt    IN       t_payable_entity_id_dt,
      vi_contract_id_dt          IN       t_contract_id_dt,
      vi_contract_versao_dt      IN       t_contract_versao_dt
   ) AS
   BEGIN
      IF ifrseg.pck_seguranca.stf_permitido (p_usuario,
                                             'VIW_CONF_DATAS_U',
                                             'PESQUISA'
                                            ) THEN
         SELECT payable_entity_id_dt,
                contract_id_dt,
                contract_versao_dt,
                proposta_data,
                assinatura_data,
                tipo_prazo,
                quant_prazo,
                entrega_data,
                garantia_data,
                inicio_data,
                termino_prev_data,
                termino_data,
                sistema_origem_code_dt,
                contract_versao_origem_dt,
                date_created_dt,
                user_id_created_dt,
                date_changed_dt,
                user_id_changed_dt,
                inactive_ind_dt,
                active_date_dt
           INTO vo_payable_entity_id_dt (1),
                vo_contract_id_dt (1),
                vo_contract_versao_dt (1),
                vo_proposta_data (1),
                vo_assinatura_data (1),
                vo_tipo_prazo (1),
                vo_quant_prazo (1),
                vo_entrega_data (1),
                vo_garantia_data (1),
                vo_inicio_data (1),
                vo_termino_prev_data (1),
                vo_termino_data (1),
                vo_sistema_origem_code_dt (1),
                vo_contract_versao_origem_dt (1),
                vo_date_created_dt (1),
                vo_user_id_created_dt (1),
                vo_date_changed_dt (1),
                vo_user_id_changed_dt (1),
                vo_inactive_ind_dt (1),
                vo_active_date_dt (1)
           FROM ifrbde.viw_conf_datas_u
          WHERE payable_entity_id_dt = vi_payable_entity_id_dt
            AND contract_id_dt = vi_contract_id_dt
            AND contract_versao_dt = vi_contract_versao_dt;
      END IF;
   EXCEPTION
      WHEN OTHERS THEN
         raise_application_error (-20100, SQLERRM);
   END;

   -- Exclui Contrato - Datas e Prazos
   -- retorna o OK ou não
   PROCEDURE stp_exclui_conf_datas_u (
      p_usuario                  IN       VARCHAR2,
      vo_ok                      OUT      tyt_ok,
      vi_payable_entity_id_dt    IN       t_payable_entity_id_dt,
      vi_contract_id_dt          IN       t_contract_id_dt,
      vi_contract_versao_dt      IN       t_contract_versao_dt
   ) AS
      CURSOR c_cursor IS
         SELECT     *
               FROM ifrbde.viw_conf_datas_u
              WHERE payable_entity_id_dt = vi_payable_entity_id_dt
                AND contract_id_dt = vi_contract_id_dt
                AND contract_versao_dt = vi_contract_versao_dt
         FOR UPDATE;

      v_viw_conf_datas_u            ifrbde.viw_conf_datas_u%ROWTYPE;
      v_dado                        VARCHAR2 (4000) := NULL;
   BEGIN
      vo_ok (1) := 0;

      IF ifrseg.pck_seguranca.stf_permitido (p_usuario,
                                             'VIW_CONF_DATAS_U',
                                             'EXCLUI'
                                            ) THEN
         OPEN c_cursor;

         FETCH c_cursor
          INTO v_viw_conf_datas_u;

         IF NOT c_cursor%NOTFOUND THEN
            v_dado :=
               'payable_entity_id_dt = '
               || RTRIM (LTRIM (UPPER (v_viw_conf_datas_u.payable_entity_id_dt)
                               )
                        );
            v_dado :=
               v_dado
               || ','
               || 'contract_id_dt = '
               || RTRIM (LTRIM (UPPER (v_viw_conf_datas_u.contract_id_dt)));
            v_dado :=
               v_dado
               || ','
               || 'contract_versao_dt = '
               || RTRIM (LTRIM (UPPER (v_viw_conf_datas_u.contract_versao_dt)));
            v_dado :=
               v_dado
               || ','
               || 'proposta_data = '
               || TO_DATE (v_viw_conf_datas_u.proposta_data, 'DD/MM/YYYY');
            v_dado :=
               v_dado
               || ','
               || 'assinatura_data = '
               || TO_DATE (v_viw_conf_datas_u.assinatura_data, 'DD/MM/YYYY');
            v_dado :=
               v_dado
               || ','
               || 'tipo_prazo = '
               || RTRIM (LTRIM (UPPER (v_viw_conf_datas_u.tipo_prazo)));
            v_dado :=
               v_dado
               || ','
               || 'quant_prazo = '
               || TO_CHAR (v_viw_conf_datas_u.quant_prazo);
            v_dado :=
               v_dado
               || ','
               || 'entrega_data = '
               || TO_DATE (v_viw_conf_datas_u.entrega_data, 'DD/MM/YYYY');
            v_dado :=
               v_dado
               || ','
               || 'garantia_data = '
               || TO_DATE (v_viw_conf_datas_u.garantia_data, 'DD/MM/YYYY');
            v_dado :=
               v_dado
               || ','
               || 'inicio_data = '
               || TO_DATE (v_viw_conf_datas_u.inicio_data, 'DD/MM/YYYY');
            v_dado :=
               v_dado
               || ','
               || 'termino_prev_data = '
               || TO_DATE (v_viw_conf_datas_u.termino_prev_data, 'DD/MM/YYYY');
            v_dado :=
               v_dado
               || ','
               || 'termino_data = '
               || TO_DATE (v_viw_conf_datas_u.termino_data, 'DD/MM/YYYY');
            v_dado :=
               v_dado
               || ','
               || 'sistema_origem_code_dt = '
               || RTRIM
                      (LTRIM (UPPER (v_viw_conf_datas_u.sistema_origem_code_dt)
                             )
                      );
            v_dado :=
               v_dado
               || ','
               || 'contract_versao_origem_dt = '
               || RTRIM
                    (LTRIM
                          (UPPER (v_viw_conf_datas_u.contract_versao_origem_dt)
                          )
                    );
            v_dado :=
               v_dado
               || ','
               || 'date_created_dt = '
               || TO_DATE (v_viw_conf_datas_u.date_created_dt, 'DD/MM/YYYY');
            v_dado :=
               v_dado
               || ','
               || 'user_id_created_dt = '
               || RTRIM (LTRIM (UPPER (v_viw_conf_datas_u.user_id_created_dt)));
            v_dado :=
               v_dado
               || ','
               || 'date_changed_dt = '
               || TO_DATE (v_viw_conf_datas_u.date_changed_dt, 'DD/MM/YYYY');
            v_dado :=
               v_dado
               || ','
               || 'user_id_changed_dt = '
               || RTRIM (LTRIM (UPPER (v_viw_conf_datas_u.user_id_changed_dt)));
            v_dado :=
               v_dado
               || ','
               || 'inactive_ind_dt = '
               || RTRIM (LTRIM (UPPER (v_viw_conf_datas_u.inactive_ind_dt)));
            v_dado :=
               v_dado
               || ','
               || 'active_date_dt = '
               || TO_DATE (v_viw_conf_datas_u.active_date_dt, 'DD/MM/YYYY');

            IF c_cursor%ROWCOUNT = 1 THEN
               vo_ok (1) := 1;
               -- LOG
               ifrseg.pck_seguranca.stp_log (p_usuario,
                                             'VIW_CONF_DATAS_U',
                                             'E',
                                             v_dado
                                            );

               DELETE FROM ifrbde.viw_conf_datas_u
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
-- Inclui Contrato - Datas e Prazos
-- retorna o recordset correspondente
   PROCEDURE stp_inclui_conf_datas_u (
      p_usuario                  IN       VARCHAR2,
      vo_payable_entity_id_dt    OUT      tyt_payable_entity_id_dt,
      vo_contract_id_dt          OUT      tyt_contract_id_dt,
      vo_contract_versao_dt      OUT      tyt_contract_versao_dt,
      vo_proposta_data           OUT      tyt_proposta_data,
      vo_assinatura_data         OUT      tyt_assinatura_data,
      vo_tipo_prazo              OUT      tyt_tipo_prazo,
      vo_quant_prazo             OUT      tyt_quant_prazo,
      vo_entrega_data            OUT      tyt_entrega_data,
      vo_garantia_data           OUT      tyt_garantia_data,
      vo_inicio_data             OUT      tyt_inicio_data,
      vo_termino_prev_data       OUT      tyt_termino_prev_data,
      vo_termino_data            OUT      tyt_termino_data,
      vo_sistema_origem_code_dt  OUT      tyt_sistema_origem_code_dt,
      vo_contract_versao_origem_dt OUT    tyt_contract_versao_origem_dt,
      vo_date_created_dt         OUT      tyt_date_created_dt,
      vo_user_id_created_dt      OUT      tyt_user_id_created_dt,
      vo_date_changed_dt         OUT      tyt_date_changed_dt,
      vo_user_id_changed_dt      OUT      tyt_user_id_changed_dt,
      vo_inactive_ind_dt         OUT      tyt_inactive_ind_dt,
      vo_active_date_dt          OUT      tyt_active_date_dt,
      vi_payable_entity_id_dt    IN       t_payable_entity_id_dt,
      vi_contract_id_dt          IN       t_contract_id_dt,
      vi_contract_versao_dt      IN       t_contract_versao_dt,
      vi_proposta_data           IN       t_proposta_data,
      vi_assinatura_data         IN       t_assinatura_data,
      vi_tipo_prazo              IN       t_tipo_prazo,
      vi_quant_prazo             IN       t_quant_prazo,
      vi_entrega_data            IN       t_entrega_data,
      vi_garantia_data           IN       t_garantia_data,
      vi_inicio_data             IN       t_inicio_data,
      vi_termino_prev_data       IN       t_termino_prev_data,
      vi_termino_data            IN       t_termino_data,
      vi_user_id_created_dt      IN       t_user_id_created_dt
   ) AS
      v_payable_entity_id_dt        viw_conf_datas_u.payable_entity_id_dt%TYPE;
      v_contract_id_dt              viw_conf_datas_u.contract_id_dt%TYPE;
      v_contract_versao_dt          viw_conf_datas_u.contract_versao_dt%TYPE;
      v_proposta_data               viw_conf_datas_u.proposta_data%TYPE;
      v_assinatura_data             viw_conf_datas_u.assinatura_data%TYPE;
      v_tipo_prazo                  viw_conf_datas_u.tipo_prazo%TYPE;
      v_quant_prazo                 viw_conf_datas_u.quant_prazo%TYPE;
      v_entrega_data                viw_conf_datas_u.entrega_data%TYPE;
      v_garantia_data               viw_conf_datas_u.garantia_data%TYPE;
      v_inicio_data                 viw_conf_datas_u.inicio_data%TYPE;
      v_termino_prev_data           viw_conf_datas_u.termino_prev_data%TYPE;
      v_termino_data                viw_conf_datas_u.termino_data%TYPE;
      v_user_id_created_dt          viw_conf_datas_u.user_id_created_dt%TYPE;
      v_dado                        VARCHAR2 (4000) := NULL;
   BEGIN
      IF ifrseg.pck_seguranca.stf_permitido (p_usuario,
                                             'VIW_CONF_DATAS_U',
                                             'INCLUI'
                                            ) THEN
         v_payable_entity_id_dt := RTRIM (LTRIM (vi_payable_entity_id_dt));
         v_contract_id_dt := RTRIM (LTRIM (vi_contract_id_dt));
         v_contract_versao_dt := RTRIM (LTRIM (vi_contract_versao_dt));
         v_tipo_prazo := RTRIM (LTRIM (vi_tipo_prazo));
         v_user_id_created_dt := RTRIM (LTRIM (vi_user_id_created_dt));
         v_proposta_data := TO_DATE (vi_proposta_data, 'DD/MM/YYYY');
         v_assinatura_data := TO_DATE (vi_assinatura_data, 'DD/MM/YYYY');
         v_entrega_data := TO_DATE (vi_entrega_data, 'DD/MM/YYYY');
         v_garantia_data := TO_DATE (vi_garantia_data, 'DD/MM/YYYY');
         v_inicio_data := TO_DATE (vi_inicio_data, 'DD/MM/YYYY');
         v_termino_prev_data := TO_DATE (vi_termino_prev_data, 'DD/MM/YYYY');
         v_termino_data := TO_DATE (vi_termino_data, 'DD/MM/YYYY');
         v_quant_prazo := vi_quant_prazo;

         INSERT INTO ifrbde.viw_conf_datas_u
                     (payable_entity_id_dt,
                      contract_id_dt,
                      contract_versao_dt,
                      proposta_data,
                      assinatura_data,
                      tipo_prazo,
                      quant_prazo,
                      entrega_data,
                      garantia_data,
                      inicio_data,
                      termino_prev_data,
                      termino_data,
                      user_id_created_dt
                     )
              VALUES (v_payable_entity_id_dt,
                      v_contract_id_dt,
                      v_contract_versao_dt,
                      v_proposta_data,
                      v_assinatura_data,
                      v_tipo_prazo,
                      v_quant_prazo,
                      v_entrega_data,
                      v_garantia_data,
                      v_inicio_data,
                      v_termino_prev_data,
                      v_termino_data,
                      v_user_id_created_dt
                     );

         IF SQL%ROWCOUNT = 1 THEN
            stp_pesquisa_conf_datas_u (p_usuario,
                                       vo_payable_entity_id_dt,
                                       vo_contract_id_dt,
                                       vo_contract_versao_dt,
                                       vo_proposta_data,
                                       vo_assinatura_data,
                                       vo_tipo_prazo,
                                       vo_quant_prazo,
                                       vo_entrega_data,
                                       vo_garantia_data,
                                       vo_inicio_data,
                                       vo_termino_prev_data,
                                       vo_termino_data,
                                       vo_sistema_origem_code_dt,
                                       vo_contract_versao_origem_dt,
                                       vo_date_created_dt,
                                       vo_user_id_created_dt,
                                       vo_date_changed_dt,
                                       vo_user_id_changed_dt,
                                       vo_inactive_ind_dt,
                                       vo_active_date_dt,
                                       v_payable_entity_id_dt,
                                       v_contract_id_dt,
                                       v_contract_versao_dt
                                      );
            v_dado :=
               'payable_entity_id_dt = '
               || RTRIM (LTRIM (v_payable_entity_id_dt));
            v_dado :=
               v_dado
               || ','
               || 'contract_id_dt = '
               || RTRIM (LTRIM (v_contract_id_dt));
            v_dado :=
               v_dado
               || ','
               || 'contract_versao_dt = '
               || RTRIM (LTRIM (v_contract_versao_dt));
            v_dado :=
               v_dado
               || ','
               || 'proposta_data = '
               || TO_CHAR (v_proposta_data, 'DD/MM/YYYY');
            v_dado :=
               v_dado
               || ','
               || 'assinatura_data = '
               || TO_CHAR (v_assinatura_data, 'DD/MM/YYYY');
            v_dado :=
               v_dado || ',' || 'tipo_prazo = '
               || RTRIM (LTRIM (v_tipo_prazo));
            v_dado :=
                  v_dado || ',' || 'quant_prazo = ' || TO_CHAR (v_quant_prazo);
            v_dado :=
               v_dado
               || ','
               || 'entrega_data = '
               || TO_CHAR (v_entrega_data, 'DD/MM/YYYY');
            v_dado :=
               v_dado
               || ','
               || 'garantia_data = '
               || TO_CHAR (v_garantia_data, 'DD/MM/YYYY');
            v_dado :=
               v_dado
               || ','
               || 'inicio_data = '
               || TO_CHAR (v_inicio_data, 'DD/MM/YYYY');
            v_dado :=
               v_dado
               || ','
               || 'termino_prev_data = '
               || TO_CHAR (v_termino_prev_data, 'DD/MM/YYYY');
            v_dado :=
               v_dado
               || ','
               || 'termino_data = '
               || TO_CHAR (v_termino_data, 'DD/MM/YYYY');
            v_dado :=
               v_dado
               || ','
               || 'user_id_created_dt = '
               || RTRIM (LTRIM (v_user_id_created_dt));
            -- LOG
            ifrseg.pck_seguranca.stp_log (p_usuario,
                                          'VIW_CONF_DATAS_U',
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
-- Altera Contrato - Datas e Prazos
-- retorna o recordset correspondente
   PROCEDURE stp_altera_conf_datas_u (
      p_usuario                  IN       VARCHAR2,
      vo_payable_entity_id_dt    OUT      tyt_payable_entity_id_dt,
      vo_contract_id_dt          OUT      tyt_contract_id_dt,
      vo_contract_versao_dt      OUT      tyt_contract_versao_dt,
      vo_proposta_data           OUT      tyt_proposta_data,
      vo_assinatura_data         OUT      tyt_assinatura_data,
      vo_tipo_prazo              OUT      tyt_tipo_prazo,
      vo_quant_prazo             OUT      tyt_quant_prazo,
      vo_entrega_data            OUT      tyt_entrega_data,
      vo_garantia_data           OUT      tyt_garantia_data,
      vo_inicio_data             OUT      tyt_inicio_data,
      vo_termino_prev_data       OUT      tyt_termino_prev_data,
      vo_termino_data            OUT      tyt_termino_data,
      vo_sistema_origem_code_dt  OUT      tyt_sistema_origem_code_dt,
      vo_contract_versao_origem_dt OUT    tyt_contract_versao_origem_dt,
      vo_date_created_dt         OUT      tyt_date_created_dt,
      vo_user_id_created_dt      OUT      tyt_user_id_created_dt,
      vo_date_changed_dt         OUT      tyt_date_changed_dt,
      vo_user_id_changed_dt      OUT      tyt_user_id_changed_dt,
      vo_inactive_ind_dt         OUT      tyt_inactive_ind_dt,
      vo_active_date_dt          OUT      tyt_active_date_dt,
      vi_payable_entity_id_dt    IN       t_payable_entity_id_dt,
      vi_contract_id_dt          IN       t_contract_id_dt,
      vi_contract_versao_dt      IN       t_contract_versao_dt,
      vi_proposta_data           IN       t_proposta_data,
      vi_assinatura_data         IN       t_assinatura_data,
      vi_tipo_prazo              IN       t_tipo_prazo,
      vi_quant_prazo             IN       t_quant_prazo,
      vi_entrega_data            IN       t_entrega_data,
      vi_garantia_data           IN       t_garantia_data,
      vi_inicio_data             IN       t_inicio_data,
      vi_termino_prev_data       IN       t_termino_prev_data,
      vi_termino_data            IN       t_termino_data,
      vi_user_id_created_dt      IN       t_user_id_created_dt
   ) AS
      CURSOR c_cursor IS
         SELECT     *
               FROM ifrbde.viw_conf_datas_u
              WHERE payable_entity_id_dt = vi_payable_entity_id_dt
                AND contract_id_dt = vi_contract_id_dt
                AND contract_versao_dt = vi_contract_versao_dt
         FOR UPDATE;

      v_viw_conf_datas_u            ifrbde.viw_conf_datas_u%ROWTYPE;
      v_payable_entity_id_dt        ifrbde.viw_conf_datas_u.payable_entity_id_dt%TYPE;
      v_contract_id_dt              ifrbde.viw_conf_datas_u.contract_id_dt%TYPE;
      v_contract_versao_dt          ifrbde.viw_conf_datas_u.contract_versao_dt%TYPE;
      v_proposta_data               ifrbde.viw_conf_datas_u.proposta_data%TYPE;
      v_assinatura_data             ifrbde.viw_conf_datas_u.assinatura_data%TYPE;
      v_tipo_prazo                  ifrbde.viw_conf_datas_u.tipo_prazo%TYPE;
      v_quant_prazo                 ifrbde.viw_conf_datas_u.quant_prazo%TYPE;
      v_entrega_data                ifrbde.viw_conf_datas_u.entrega_data%TYPE;
      v_garantia_data               ifrbde.viw_conf_datas_u.garantia_data%TYPE;
      v_inicio_data                 ifrbde.viw_conf_datas_u.inicio_data%TYPE;
      v_termino_prev_data           ifrbde.viw_conf_datas_u.termino_prev_data%TYPE;
      v_termino_data                ifrbde.viw_conf_datas_u.termino_data%TYPE;
      v_user_id_created_dt          ifrbde.viw_conf_datas_u.user_id_created_dt%TYPE;
      v_dado                        VARCHAR2 (4000) := NULL;
   BEGIN
      IF ifrseg.pck_seguranca.stf_permitido (p_usuario,
                                             'VIW_CONF_DATAS_U',
                                             'ALTERA'
                                            ) THEN
         OPEN c_cursor;

         FETCH c_cursor
          INTO v_viw_conf_datas_u;

         IF NOT c_cursor%NOTFOUND THEN
            v_payable_entity_id_dt := RTRIM (LTRIM (vi_payable_entity_id_dt));
            v_contract_id_dt := RTRIM (LTRIM (vi_contract_id_dt));
            v_contract_versao_dt := RTRIM (LTRIM (vi_contract_versao_dt));
            v_tipo_prazo := RTRIM (LTRIM (vi_tipo_prazo));
            v_user_id_created_dt := RTRIM (LTRIM (vi_user_id_created_dt));
            v_proposta_data := TO_DATE (vi_proposta_data, 'DD/MM/YYYY');
            v_assinatura_data := TO_DATE (vi_assinatura_data, 'DD/MM/YYYY');
            v_entrega_data := TO_DATE (vi_entrega_data, 'DD/MM/YYYY');
            v_garantia_data := TO_DATE (vi_garantia_data, 'DD/MM/YYYY');
            v_inicio_data := TO_DATE (vi_inicio_data, 'DD/MM/YYYY');
            v_termino_prev_data :=
                                 TO_DATE (vi_termino_prev_data, 'DD/MM/YYYY');
            v_termino_data := TO_DATE (vi_termino_data, 'DD/MM/YYYY');
            v_quant_prazo := vi_quant_prazo;

            UPDATE ifrbde.viw_conf_datas_u
               SET proposta_data = v_proposta_data,
                   assinatura_data = v_assinatura_data,
                   tipo_prazo = v_tipo_prazo,
                   quant_prazo = v_quant_prazo,
                   entrega_data = v_entrega_data,
                   garantia_data = v_garantia_data,
                   inicio_data = v_inicio_data,
                   termino_prev_data = v_termino_prev_data,
                   termino_data = v_termino_data,
                   user_id_created_dt = v_user_id_created_dt
             WHERE CURRENT OF c_cursor;

            IF SQL%ROWCOUNT = 1 THEN
               stp_pesquisa_conf_datas_u (p_usuario,
                                          vo_payable_entity_id_dt,
                                          vo_contract_id_dt,
                                          vo_contract_versao_dt,
                                          vo_proposta_data,
                                          vo_assinatura_data,
                                          vo_tipo_prazo,
                                          vo_quant_prazo,
                                          vo_entrega_data,
                                          vo_garantia_data,
                                          vo_inicio_data,
                                          vo_termino_prev_data,
                                          vo_termino_data,
                                          vo_sistema_origem_code_dt,
                                          vo_contract_versao_origem_dt,
                                          vo_date_created_dt,
                                          vo_user_id_created_dt,
                                          vo_date_changed_dt,
                                          vo_user_id_changed_dt,
                                          vo_inactive_ind_dt,
                                          vo_active_date_dt,
                                          vi_payable_entity_id_dt,
                                          vi_contract_id_dt,
                                          vi_contract_versao_dt
                                         );
               v_dado :=
                  'payable_entity_id_dt = '
                  || RTRIM (LTRIM (v_payable_entity_id_dt));
               v_dado :=
                  v_dado
                  || ','
                  || 'contract_id_dt = '
                  || RTRIM (LTRIM (v_contract_id_dt));
               v_dado :=
                  v_dado
                  || ','
                  || 'contract_versao_dt = '
                  || RTRIM (LTRIM (v_contract_versao_dt));
               v_dado :=
                  v_dado
                  || ','
                  || 'proposta_data = '
                  || TO_CHAR (v_proposta_data, 'DD/MM/YYYY');
               v_dado :=
                  v_dado
                  || ','
                  || 'assinatura_data = '
                  || TO_CHAR (v_assinatura_data, 'DD/MM/YYYY');
               v_dado :=
                  v_dado
                  || ','
                  || 'tipo_prazo = '
                  || RTRIM (LTRIM (v_tipo_prazo));
               v_dado :=
                  v_dado || ',' || 'quant_prazo = ' || TO_CHAR (v_quant_prazo);
               v_dado :=
                  v_dado
                  || ','
                  || 'entrega_data = '
                  || TO_CHAR (v_entrega_data, 'DD/MM/YYYY');
               v_dado :=
                  v_dado
                  || ','
                  || 'garantia_data = '
                  || TO_CHAR (v_garantia_data, 'DD/MM/YYYY');
               v_dado :=
                  v_dado
                  || ','
                  || 'inicio_data = '
                  || TO_CHAR (v_inicio_data, 'DD/MM/YYYY');
               v_dado :=
                  v_dado
                  || ','
                  || 'termino_prev_data = '
                  || TO_CHAR (v_termino_prev_data, 'DD/MM/YYYY');
               v_dado :=
                  v_dado
                  || ','
                  || 'termino_data = '
                  || TO_CHAR (v_termino_data, 'DD/MM/YYYY');
               v_dado :=
                  v_dado
                  || ','
                  || 'user_id_created_dt = '
                  || RTRIM (LTRIM (v_user_id_created_dt));
               -- LOG
               ifrseg.pck_seguranca.stp_log (p_usuario,
                                             'VIW_CONF_DATAS_U',
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
-- Pesquisa Contrato - Participantes
-- retorna o recordset correspondente
   PROCEDURE stp_pesquisa_conf_participante (
      p_usuario                  IN       VARCHAR2,
      vo_payable_entity_id_prc   OUT      tyt_payable_entity_id_prc,
      vo_contract_id_prc         OUT      tyt_contract_id_prc,
      vo_contract_versao_prc     OUT      tyt_contract_versao_prc,
      vo_vendor_id               OUT      tyt_vendor_id,
      vo_vendor_loc_code         OUT      tyt_vendor_loc_code,
      vo_addr_fmt                OUT      tyt_addr_fmt,
      vo_cod_relacao_contrato    OUT      tyt_cod_relacao_contrato,
      vo_addr_line_1             OUT      tyt_addr_line_1,
      vo_com_ddd                 OUT      tyt_com_ddd,
      vo_street_post_office_box_1 OUT     tyt_street_post_office_box_1,
      vo_com_tel                 OUT      tyt_com_tel,
      vo_street_post_office_box_2 OUT     tyt_street_post_office_box_2,
      vo_com_fax                 OUT      tyt_com_fax,
      vo_city_name               OUT      tyt_city_name,
      vo_com_email               OUT      tyt_com_email,
      vo_country_sub_entity_code OUT      tyt_country_sub_entity_code,
      vo_postal_code             OUT      tyt_postal_code,
      vo_country_code            OUT      tyt_country_code,
      vo_type_of_pmt             OUT      tyt_type_of_pmt,
      vo_seq_nbr                 OUT      tyt_seq_nbr,
      vo_sistema_origem_code_prc OUT      tyt_sistema_origem_code_prc,
      vo_contract_versao_origem_prc OUT   tyt_contract_versao_origem_prc,
      vo_date_created_prc        OUT      tyt_date_created_prc,
      vo_user_id_created_prc     OUT      tyt_user_id_created_prc,
      vo_date_changed_prc        OUT      tyt_date_changed_prc,
      vo_user_id_changed_prc     OUT      tyt_user_id_changed_prc,
      vo_inactive_ind_prc        OUT      tyt_inactive_ind_prc,
      vo_active_date_prc         OUT      tyt_active_date_prc,
      vi_payable_entity_id_prc   IN       t_payable_entity_id_prc,
      vi_contract_id_prc         IN       t_contract_id_prc,
      vi_contract_versao_prc     IN       t_contract_versao_prc,
      vi_vendor_id               IN       t_vendor_id,
      vi_vendor_loc_code         IN       t_vendor_loc_code
   ) AS
   BEGIN
      IF ifrseg.pck_seguranca.stf_permitido (p_usuario,
                                             'VIW_CONF_PARTICIPANTES_U',
                                             'PESQUISA'
                                            ) THEN
         SELECT payable_entity_id_prc,
                contract_id_prc,
                contract_versao_prc,
                vendor_id,
                vendor_loc_code,
                addr_fmt,
                cod_relacao_contrato,
                addr_line_1,
                com_ddd,
                street_post_office_box_1,
                com_tel,
                street_post_office_box_2,
                com_fax,
                city_name,
                com_email,
                country_sub_entity_code,
                postal_code,
                country_code,
                type_of_pmt,
                seq_nbr,
                sistema_origem_code_prc,
                contract_versao_origem_prc,
                date_created_prc,
                user_id_created_prc,
                date_changed_prc,
                user_id_changed_prc,
                inactive_ind_prc,
                active_date_prc
           INTO vo_payable_entity_id_prc (1),
                vo_contract_id_prc (1),
                vo_contract_versao_prc (1),
                vo_vendor_id (1),
                vo_vendor_loc_code (1),
                vo_addr_fmt (1),
                vo_cod_relacao_contrato (1),
                vo_addr_line_1 (1),
                vo_com_ddd (1),
                vo_street_post_office_box_1 (1),
                vo_com_tel (1),
                vo_street_post_office_box_2 (1),
                vo_com_fax (1),
                vo_city_name (1),
                vo_com_email (1),
                vo_country_sub_entity_code (1),
                vo_postal_code (1),
                vo_country_code (1),
                vo_type_of_pmt (1),
                vo_seq_nbr (1),
                vo_sistema_origem_code_prc (1),
                vo_contract_versao_origem_prc (1),
                vo_date_created_prc (1),
                vo_user_id_created_prc (1),
                vo_date_changed_prc (1),
                vo_user_id_changed_prc (1),
                vo_inactive_ind_prc (1),
                vo_active_date_prc (1)
           FROM ifrbde.viw_conf_participantes_u
          WHERE payable_entity_id_prc = vi_payable_entity_id_prc
            AND contract_id_prc = vi_contract_id_prc
            AND contract_versao_prc = vi_contract_versao_prc
            AND vendor_id = vi_vendor_id
            AND vendor_loc_code = vi_vendor_loc_code;
      END IF;
   EXCEPTION
      WHEN OTHERS THEN
         raise_application_error (-20100, SQLERRM);
   END;

   -- Exclui Contrato - Participantes
   -- retorna o OK ou não
   PROCEDURE stp_exclui_conf_participantes_ (
      p_usuario                  IN       VARCHAR2,
      vo_ok                      OUT      tyt_ok,
      vi_payable_entity_id_prc   IN       t_payable_entity_id_prc,
      vi_contract_id_prc         IN       t_contract_id_prc,
      vi_contract_versao_prc     IN       t_contract_versao_prc,
      vi_vendor_id               IN       t_vendor_id,
      vi_vendor_loc_code         IN       t_vendor_loc_code
   ) AS
      CURSOR c_cursor IS
         SELECT     *
               FROM ifrbde.viw_conf_participantes_u
              WHERE payable_entity_id_prc = vi_payable_entity_id_prc
                AND contract_id_prc = vi_contract_id_prc
                AND contract_versao_prc = vi_contract_versao_prc
                AND vendor_id = vi_vendor_id
                AND vendor_loc_code = vi_vendor_loc_code
         FOR UPDATE;

      v_viw_conf_participantes_u    ifrbde.viw_conf_participantes_u%ROWTYPE;
      v_dado                        VARCHAR2 (4000) := NULL;
   BEGIN
      vo_ok (1) := 0;

      IF ifrseg.pck_seguranca.stf_permitido (p_usuario,
                                             'VIW_CONF_PARTICIPANTES_U',
                                             'EXCLUI'
                                            ) THEN
         OPEN c_cursor;

         FETCH c_cursor
          INTO v_viw_conf_participantes_u;

         IF NOT c_cursor%NOTFOUND THEN
            v_dado :=
               'payable_entity_id_prc = '
               || RTRIM
                    (LTRIM
                        (UPPER
                             (v_viw_conf_participantes_u.payable_entity_id_prc)
                        )
                    );
            v_dado :=
               v_dado
               || ','
               || 'contract_id_prc = '
               || RTRIM
                     (LTRIM (UPPER (v_viw_conf_participantes_u.contract_id_prc)
                            )
                     );
            v_dado :=
               v_dado
               || ','
               || 'contract_versao_prc = '
               || RTRIM
                    (LTRIM
                        (UPPER (v_viw_conf_participantes_u.contract_versao_prc)
                        )
                    );
            v_dado :=
               v_dado
               || ','
               || 'vendor_id = '
               || RTRIM (LTRIM (UPPER (v_viw_conf_participantes_u.vendor_id)));
            v_dado :=
               v_dado
               || ','
               || 'vendor_loc_code = '
               || RTRIM
                     (LTRIM (UPPER (v_viw_conf_participantes_u.vendor_loc_code)
                            )
                     );
            v_dado :=
               v_dado
               || ','
               || 'addr_fmt = '
               || RTRIM (LTRIM (UPPER (v_viw_conf_participantes_u.addr_fmt)));
            v_dado :=
               v_dado
               || ','
               || 'cod_relacao_contrato = '
               || RTRIM
                    (LTRIM
                        (UPPER
                              (v_viw_conf_participantes_u.cod_relacao_contrato)
                        )
                    );
            v_dado :=
               v_dado
               || ','
               || 'addr_line_1 = '
               || RTRIM (LTRIM (UPPER (v_viw_conf_participantes_u.addr_line_1))
                        );
            v_dado :=
               v_dado
               || ','
               || 'com_ddd = '
               || RTRIM (LTRIM (UPPER (v_viw_conf_participantes_u.com_ddd)));
            v_dado :=
               v_dado
               || ','
               || 'street_post_office_box_1 = '
               || RTRIM
                    (LTRIM
                        (UPPER
                            (v_viw_conf_participantes_u.street_post_office_box_1
                            )
                        )
                    );
            v_dado :=
               v_dado
               || ','
               || 'com_tel = '
               || RTRIM (LTRIM (UPPER (v_viw_conf_participantes_u.com_tel)));
            v_dado :=
               v_dado
               || ','
               || 'street_post_office_box_2 = '
               || RTRIM
                    (LTRIM
                        (UPPER
                            (v_viw_conf_participantes_u.street_post_office_box_2
                            )
                        )
                    );
            v_dado :=
               v_dado
               || ','
               || 'com_fax = '
               || RTRIM (LTRIM (UPPER (v_viw_conf_participantes_u.com_fax)));
            v_dado :=
               v_dado
               || ','
               || 'city_name = '
               || RTRIM (LTRIM (UPPER (v_viw_conf_participantes_u.city_name)));
            v_dado :=
               v_dado
               || ','
               || 'com_email = '
               || RTRIM (LTRIM (UPPER (v_viw_conf_participantes_u.com_email)));
            v_dado :=
               v_dado
               || ','
               || 'country_sub_entity_code = '
               || RTRIM
                    (LTRIM
                        (UPPER
                            (v_viw_conf_participantes_u.country_sub_entity_code
                            )
                        )
                    );
            v_dado :=
               v_dado
               || ','
               || 'postal_code = '
               || RTRIM (LTRIM (UPPER (v_viw_conf_participantes_u.postal_code))
                        );
            v_dado :=
               v_dado
               || ','
               || 'country_code = '
               || RTRIM (LTRIM (UPPER (v_viw_conf_participantes_u.country_code)
                               )
                        );
            v_dado :=
               v_dado
               || ','
               || 'type_of_pmt = '
               || RTRIM (LTRIM (UPPER (v_viw_conf_participantes_u.type_of_pmt))
                        );
            v_dado :=
               v_dado
               || ','
               || 'seq_nbr = '
               || RTRIM (LTRIM (UPPER (v_viw_conf_participantes_u.seq_nbr)));
            v_dado :=
               v_dado
               || ','
               || 'sistema_origem_code_prc = '
               || RTRIM
                    (LTRIM
                        (UPPER
                            (v_viw_conf_participantes_u.sistema_origem_code_prc
                            )
                        )
                    );
            v_dado :=
               v_dado
               || ','
               || 'contract_versao_origem_prc = '
               || RTRIM
                    (LTRIM
                        (UPPER
                            (v_viw_conf_participantes_u.contract_versao_origem_prc
                            )
                        )
                    );
            v_dado :=
               v_dado
               || ','
               || 'date_created_prc = '
               || TO_DATE (v_viw_conf_participantes_u.date_created_prc,
                           'DD/MM/YYYY'
                          );
            v_dado :=
               v_dado
               || ','
               || 'user_id_created_prc = '
               || RTRIM
                    (LTRIM
                        (UPPER (v_viw_conf_participantes_u.user_id_created_prc)
                        )
                    );
            v_dado :=
               v_dado
               || ','
               || 'date_changed_prc = '
               || TO_DATE (v_viw_conf_participantes_u.date_changed_prc,
                           'DD/MM/YYYY'
                          );
            v_dado :=
               v_dado
               || ','
               || 'user_id_changed_prc = '
               || RTRIM
                    (LTRIM
                        (UPPER (v_viw_conf_participantes_u.user_id_changed_prc)
                        )
                    );
            v_dado :=
               v_dado
               || ','
               || 'inactive_ind_prc = '
               || RTRIM
                    (LTRIM (UPPER (v_viw_conf_participantes_u.inactive_ind_prc)
                           )
                    );
            v_dado :=
               v_dado
               || ','
               || 'active_date_prc = '
               || TO_DATE (v_viw_conf_participantes_u.active_date_prc,
                           'DD/MM/YYYY'
                          );

            IF c_cursor%ROWCOUNT = 1 THEN
               vo_ok (1) := 1;
               -- LOG
               ifrseg.pck_seguranca.stp_log (p_usuario,
                                             'VIW_CONF_PARTICIPANTES_U',
                                             'E',
                                             v_dado
                                            );

               DELETE FROM ifrbde.viw_conf_participantes_u
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
-- Inclui Contrato - Participantes
-- retorna o recordset correspondente
   PROCEDURE stp_inclui_conf_participantes_ (
      p_usuario                  IN       VARCHAR2,
      vo_payable_entity_id_prc   OUT      tyt_payable_entity_id_prc,
      vo_contract_id_prc         OUT      tyt_contract_id_prc,
      vo_contract_versao_prc     OUT      tyt_contract_versao_prc,
      vo_vendor_id               OUT      tyt_vendor_id,
      vo_vendor_loc_code         OUT      tyt_vendor_loc_code,
      vo_addr_fmt                OUT      tyt_addr_fmt,
      vo_cod_relacao_contrato    OUT      tyt_cod_relacao_contrato,
      vo_addr_line_1             OUT      tyt_addr_line_1,
      vo_com_ddd                 OUT      tyt_com_ddd,
      vo_street_post_office_box_1 OUT     tyt_street_post_office_box_1,
      vo_com_tel                 OUT      tyt_com_tel,
      vo_street_post_office_box_2 OUT     tyt_street_post_office_box_2,
      vo_com_fax                 OUT      tyt_com_fax,
      vo_city_name               OUT      tyt_city_name,
      vo_com_email               OUT      tyt_com_email,
      vo_country_sub_entity_code OUT      tyt_country_sub_entity_code,
      vo_postal_code             OUT      tyt_postal_code,
      vo_country_code            OUT      tyt_country_code,
      vo_type_of_pmt             OUT      tyt_type_of_pmt,
      vo_seq_nbr                 OUT      tyt_seq_nbr,
      vo_sistema_origem_code_prc OUT      tyt_sistema_origem_code_prc,
      vo_contract_versao_origem_prc OUT   tyt_contract_versao_origem_prc,
      vo_date_created_prc        OUT      tyt_date_created_prc,
      vo_user_id_created_prc     OUT      tyt_user_id_created_prc,
      vo_date_changed_prc        OUT      tyt_date_changed_prc,
      vo_user_id_changed_prc     OUT      tyt_user_id_changed_prc,
      vo_inactive_ind_prc        OUT      tyt_inactive_ind_prc,
      vo_active_date_prc         OUT      tyt_active_date_prc,
      vi_payable_entity_id_prc   IN       t_payable_entity_id_prc,
      vi_contract_id_prc         IN       t_contract_id_prc,
      vi_contract_versao_prc     IN       t_contract_versao_prc,
      vi_vendor_id               IN       t_vendor_id,
      vi_vendor_loc_code         IN       t_vendor_loc_code,
      vi_cod_relacao_contrato    IN       t_cod_relacao_contrato,
      vi_addr_line_1             IN       t_addr_line_1,
      vi_com_ddd                 IN       t_com_ddd,
      vi_street_post_office_box_1 IN      t_street_post_office_box_1,
      vi_com_tel                 IN       t_com_tel,
      vi_street_post_office_box_2 IN      t_street_post_office_box_2,
      vi_com_fax                 IN       t_com_fax,
      vi_city_name               IN       t_city_name,
      vi_com_email               IN       t_com_email,
      vi_country_sub_entity_code IN       t_country_sub_entity_code,
      vi_postal_code             IN       t_postal_code,
      vi_country_code            IN       t_country_code,
      vi_type_of_pmt             IN       t_type_of_pmt,
      vi_seq_nbr                 IN       t_seq_nbr,
      vi_user_id_created_prc     IN       t_user_id_created_prc
   ) AS
      v_payable_entity_id_prc       viw_conf_participantes_u.payable_entity_id_prc%TYPE;
      v_contract_id_prc             viw_conf_participantes_u.contract_id_prc%TYPE;
      v_contract_versao_prc         viw_conf_participantes_u.contract_versao_prc%TYPE;
      v_vendor_id                   viw_conf_participantes_u.vendor_id%TYPE;
      v_vendor_loc_code             viw_conf_participantes_u.vendor_loc_code%TYPE;
      v_cod_relacao_contrato        viw_conf_participantes_u.cod_relacao_contrato%TYPE;
      v_addr_line_1                 viw_conf_participantes_u.addr_line_1%TYPE;
      v_com_ddd                     viw_conf_participantes_u.com_ddd%TYPE;
      v_street_post_office_box_1    viw_conf_participantes_u.street_post_office_box_1%TYPE;
      v_com_tel                     viw_conf_participantes_u.com_tel%TYPE;
      v_street_post_office_box_2    viw_conf_participantes_u.street_post_office_box_2%TYPE;
      v_com_fax                     viw_conf_participantes_u.com_fax%TYPE;
      v_city_name                   viw_conf_participantes_u.city_name%TYPE;
      v_com_email                   viw_conf_participantes_u.com_email%TYPE;
      v_country_sub_entity_code     viw_conf_participantes_u.country_sub_entity_code%TYPE;
      v_postal_code                 viw_conf_participantes_u.postal_code%TYPE;
      v_country_code                viw_conf_participantes_u.country_code%TYPE;
      v_type_of_pmt                 viw_conf_participantes_u.type_of_pmt%TYPE;
      v_seq_nbr                     viw_conf_participantes_u.seq_nbr%TYPE;
      v_user_id_created_prc         viw_conf_participantes_u.user_id_created_prc%TYPE;
      v_dado                        VARCHAR2 (4000) := NULL;
   BEGIN
      IF ifrseg.pck_seguranca.stf_permitido (p_usuario,
                                             'VIW_CONF_PARTICIPANTES_U',
                                             'INCLUI'
                                            ) THEN
         v_payable_entity_id_prc := RTRIM (LTRIM (vi_payable_entity_id_prc));
         v_contract_id_prc := RTRIM (LTRIM (vi_contract_id_prc));
         v_contract_versao_prc := RTRIM (LTRIM (vi_contract_versao_prc));
         v_vendor_id := RTRIM (LTRIM (vi_vendor_id));
         v_vendor_loc_code := RTRIM (LTRIM (vi_vendor_loc_code));
         v_cod_relacao_contrato := RTRIM (LTRIM (vi_cod_relacao_contrato));
         v_addr_line_1 := RTRIM (LTRIM (vi_addr_line_1));
         v_com_ddd := RTRIM (LTRIM (vi_com_ddd));
         v_street_post_office_box_1 :=
                                  RTRIM (LTRIM (vi_street_post_office_box_1));
         v_com_tel := RTRIM (LTRIM (vi_com_tel));
         v_street_post_office_box_2 :=
                                  RTRIM (LTRIM (vi_street_post_office_box_2));
         v_com_fax := RTRIM (LTRIM (vi_com_fax));
         v_city_name := RTRIM (LTRIM (vi_city_name));
         v_com_email := RTRIM (LTRIM (vi_com_email));
         v_country_sub_entity_code :=
                                   RTRIM (LTRIM (vi_country_sub_entity_code));
         v_postal_code := RTRIM (LTRIM (vi_postal_code));
         v_country_code := RTRIM (LTRIM (vi_country_code));
         v_type_of_pmt := RTRIM (LTRIM (vi_type_of_pmt));
         v_seq_nbr := RTRIM (LTRIM (vi_seq_nbr));
         v_user_id_created_prc := RTRIM (LTRIM (vi_user_id_created_prc));

         INSERT INTO ifrbde.viw_conf_participantes_u
                     (payable_entity_id_prc,
                      contract_id_prc,
                      contract_versao_prc,
                      vendor_id,
                      vendor_loc_code,
                      cod_relacao_contrato,
                      addr_line_1,
                      com_ddd,
                      street_post_office_box_1,
                      com_tel,
                      street_post_office_box_2,
                      com_fax,
                      city_name,
                      com_email,
                      country_sub_entity_code,
                      postal_code,
                      country_code,
                      type_of_pmt,
                      seq_nbr,
                      user_id_created_prc
                     )
              VALUES (v_payable_entity_id_prc,
                      v_contract_id_prc,
                      v_contract_versao_prc,
                      v_vendor_id,
                      v_vendor_loc_code,
                      v_cod_relacao_contrato,
                      v_addr_line_1,
                      v_com_ddd,
                      v_street_post_office_box_1,
                      v_com_tel,
                      v_street_post_office_box_2,
                      v_com_fax,
                      v_city_name,
                      v_com_email,
                      v_country_sub_entity_code,
                      v_postal_code,
                      v_country_code,
                      v_type_of_pmt,
                      v_seq_nbr,
                      v_user_id_created_prc
                     );

         IF SQL%ROWCOUNT = 1 THEN
            stp_pesquisa_conf_participante (p_usuario,
                                            vo_payable_entity_id_prc,
                                            vo_contract_id_prc,
                                            vo_contract_versao_prc,
                                            vo_vendor_id,
                                            vo_vendor_loc_code,
                                            vo_addr_fmt,
                                            vo_cod_relacao_contrato,
                                            vo_addr_line_1,
                                            vo_com_ddd,
                                            vo_street_post_office_box_1,
                                            vo_com_tel,
                                            vo_street_post_office_box_2,
                                            vo_com_fax,
                                            vo_city_name,
                                            vo_com_email,
                                            vo_country_sub_entity_code,
                                            vo_postal_code,
                                            vo_country_code,
                                            vo_type_of_pmt,
                                            vo_seq_nbr,
                                            vo_sistema_origem_code_prc,
                                            vo_contract_versao_origem_prc,
                                            vo_date_created_prc,
                                            vo_user_id_created_prc,
                                            vo_date_changed_prc,
                                            vo_user_id_changed_prc,
                                            vo_inactive_ind_prc,
                                            vo_active_date_prc,
                                            v_payable_entity_id_prc,
                                            v_contract_id_prc,
                                            v_contract_versao_prc,
                                            v_vendor_id,
                                            v_vendor_loc_code
                                           );
            v_dado :=
               'payable_entity_id_prc = '
               || RTRIM (LTRIM (v_payable_entity_id_prc));
            v_dado :=
               v_dado
               || ','
               || 'contract_id_prc = '
               || RTRIM (LTRIM (v_contract_id_prc));
            v_dado :=
               v_dado
               || ','
               || 'contract_versao_prc = '
               || RTRIM (LTRIM (v_contract_versao_prc));
            v_dado :=
                v_dado || ',' || 'vendor_id = ' || RTRIM (LTRIM (v_vendor_id));
            v_dado :=
               v_dado
               || ','
               || 'vendor_loc_code = '
               || RTRIM (LTRIM (v_vendor_loc_code));
            v_dado :=
               v_dado
               || ','
               || 'cod_relacao_contrato = '
               || RTRIM (LTRIM (v_cod_relacao_contrato));
            v_dado :=
               v_dado || ',' || 'addr_line_1 = '
               || RTRIM (LTRIM (v_addr_line_1));
            v_dado :=
                    v_dado || ',' || 'com_ddd = ' || RTRIM (LTRIM (v_com_ddd));
            v_dado :=
               v_dado
               || ','
               || 'street_post_office_box_1 = '
               || RTRIM (LTRIM (v_street_post_office_box_1));
            v_dado :=
                    v_dado || ',' || 'com_tel = ' || RTRIM (LTRIM (v_com_tel));
            v_dado :=
               v_dado
               || ','
               || 'street_post_office_box_2 = '
               || RTRIM (LTRIM (v_street_post_office_box_2));
            v_dado :=
                    v_dado || ',' || 'com_fax = ' || RTRIM (LTRIM (v_com_fax));
            v_dado :=
                v_dado || ',' || 'city_name = ' || RTRIM (LTRIM (v_city_name));
            v_dado :=
                v_dado || ',' || 'com_email = ' || RTRIM (LTRIM (v_com_email));
            v_dado :=
               v_dado
               || ','
               || 'country_sub_entity_code = '
               || RTRIM (LTRIM (v_country_sub_entity_code));
            v_dado :=
               v_dado || ',' || 'postal_code = '
               || RTRIM (LTRIM (v_postal_code));
            v_dado :=
               v_dado
               || ','
               || 'country_code = '
               || RTRIM (LTRIM (v_country_code));
            v_dado :=
               v_dado || ',' || 'type_of_pmt = '
               || RTRIM (LTRIM (v_type_of_pmt));
            v_dado :=
                    v_dado || ',' || 'seq_nbr = ' || RTRIM (LTRIM (v_seq_nbr));
            v_dado :=
               v_dado
               || ','
               || 'user_id_created_prc = '
               || RTRIM (LTRIM (v_user_id_created_prc));
            -- LOG
            ifrseg.pck_seguranca.stp_log (p_usuario,
                                          'VIW_CONF_PARTICIPANTES_U',
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
-- Altera Contrato - Participantes
-- retorna o recordset correspondente
   PROCEDURE stp_altera_conf_participantes_ (
      p_usuario                  IN       VARCHAR2,
      vo_payable_entity_id_prc   OUT      tyt_payable_entity_id_prc,
      vo_contract_id_prc         OUT      tyt_contract_id_prc,
      vo_contract_versao_prc     OUT      tyt_contract_versao_prc,
      vo_vendor_id               OUT      tyt_vendor_id,
      vo_vendor_loc_code         OUT      tyt_vendor_loc_code,
      vo_addr_fmt                OUT      tyt_addr_fmt,
      vo_cod_relacao_contrato    OUT      tyt_cod_relacao_contrato,
      vo_addr_line_1             OUT      tyt_addr_line_1,
      vo_com_ddd                 OUT      tyt_com_ddd,
      vo_street_post_office_box_1 OUT     tyt_street_post_office_box_1,
      vo_com_tel                 OUT      tyt_com_tel,
      vo_street_post_office_box_2 OUT     tyt_street_post_office_box_2,
      vo_com_fax                 OUT      tyt_com_fax,
      vo_city_name               OUT      tyt_city_name,
      vo_com_email               OUT      tyt_com_email,
      vo_country_sub_entity_code OUT      tyt_country_sub_entity_code,
      vo_postal_code             OUT      tyt_postal_code,
      vo_country_code            OUT      tyt_country_code,
      vo_type_of_pmt             OUT      tyt_type_of_pmt,
      vo_seq_nbr                 OUT      tyt_seq_nbr,
      vo_sistema_origem_code_prc OUT      tyt_sistema_origem_code_prc,
      vo_contract_versao_origem_prc OUT   tyt_contract_versao_origem_prc,
      vo_date_created_prc        OUT      tyt_date_created_prc,
      vo_user_id_created_prc     OUT      tyt_user_id_created_prc,
      vo_date_changed_prc        OUT      tyt_date_changed_prc,
      vo_user_id_changed_prc     OUT      tyt_user_id_changed_prc,
      vo_inactive_ind_prc        OUT      tyt_inactive_ind_prc,
      vo_active_date_prc         OUT      tyt_active_date_prc,
      vi_payable_entity_id_prc   IN       t_payable_entity_id_prc,
      vi_contract_id_prc         IN       t_contract_id_prc,
      vi_contract_versao_prc     IN       t_contract_versao_prc,
      vi_vendor_id               IN       t_vendor_id,
      vi_vendor_loc_code         IN       t_vendor_loc_code,
      vi_cod_relacao_contrato    IN       t_cod_relacao_contrato,
      vi_addr_line_1             IN       t_addr_line_1,
      vi_com_ddd                 IN       t_com_ddd,
      vi_street_post_office_box_1 IN      t_street_post_office_box_1,
      vi_com_tel                 IN       t_com_tel,
      vi_street_post_office_box_2 IN      t_street_post_office_box_2,
      vi_com_fax                 IN       t_com_fax,
      vi_city_name               IN       t_city_name,
      vi_com_email               IN       t_com_email,
      vi_country_sub_entity_code IN       t_country_sub_entity_code,
      vi_postal_code             IN       t_postal_code,
      vi_country_code            IN       t_country_code,
      vi_type_of_pmt             IN       t_type_of_pmt,
      vi_seq_nbr                 IN       t_seq_nbr,
      vi_user_id_created_prc     IN       t_user_id_created_prc
   ) AS
      CURSOR c_cursor IS
         SELECT     *
               FROM ifrbde.viw_conf_participantes_u
              WHERE payable_entity_id_prc = vi_payable_entity_id_prc
                AND contract_id_prc = vi_contract_id_prc
                AND contract_versao_prc = vi_contract_versao_prc
                AND vendor_id = vi_vendor_id
                AND vendor_loc_code = vi_vendor_loc_code
         FOR UPDATE;

      v_viw_conf_participantes_u    ifrbde.viw_conf_participantes_u%ROWTYPE;
      v_payable_entity_id_prc       ifrbde.viw_conf_participantes_u.payable_entity_id_prc%TYPE;
      v_contract_id_prc             ifrbde.viw_conf_participantes_u.contract_id_prc%TYPE;
      v_contract_versao_prc         ifrbde.viw_conf_participantes_u.contract_versao_prc%TYPE;
      v_vendor_id                   ifrbde.viw_conf_participantes_u.vendor_id%TYPE;
      v_vendor_loc_code             ifrbde.viw_conf_participantes_u.vendor_loc_code%TYPE;
      v_cod_relacao_contrato        ifrbde.viw_conf_participantes_u.cod_relacao_contrato%TYPE;
      v_addr_line_1                 ifrbde.viw_conf_participantes_u.addr_line_1%TYPE;
      v_com_ddd                     ifrbde.viw_conf_participantes_u.com_ddd%TYPE;
      v_street_post_office_box_1    ifrbde.viw_conf_participantes_u.street_post_office_box_1%TYPE;
      v_com_tel                     ifrbde.viw_conf_participantes_u.com_tel%TYPE;
      v_street_post_office_box_2    ifrbde.viw_conf_participantes_u.street_post_office_box_2%TYPE;
      v_com_fax                     ifrbde.viw_conf_participantes_u.com_fax%TYPE;
      v_city_name                   ifrbde.viw_conf_participantes_u.city_name%TYPE;
      v_com_email                   ifrbde.viw_conf_participantes_u.com_email%TYPE;
      v_country_sub_entity_code     ifrbde.viw_conf_participantes_u.country_sub_entity_code%TYPE;
      v_postal_code                 ifrbde.viw_conf_participantes_u.postal_code%TYPE;
      v_country_code                ifrbde.viw_conf_participantes_u.country_code%TYPE;
      v_type_of_pmt                 ifrbde.viw_conf_participantes_u.type_of_pmt%TYPE;
      v_seq_nbr                     ifrbde.viw_conf_participantes_u.seq_nbr%TYPE;
      v_user_id_created_prc         ifrbde.viw_conf_participantes_u.user_id_created_prc%TYPE;
      v_dado                        VARCHAR2 (4000) := NULL;
   BEGIN
      IF ifrseg.pck_seguranca.stf_permitido (p_usuario,
                                             'VIW_CONF_PARTICIPANTES_U',
                                             'ALTERA'
                                            ) THEN
         OPEN c_cursor;

         FETCH c_cursor
          INTO v_viw_conf_participantes_u;

         IF NOT c_cursor%NOTFOUND THEN
            v_payable_entity_id_prc :=
                                     RTRIM (LTRIM (vi_payable_entity_id_prc));
            v_contract_id_prc := RTRIM (LTRIM (vi_contract_id_prc));
            v_contract_versao_prc := RTRIM (LTRIM (vi_contract_versao_prc));
            v_vendor_id := RTRIM (LTRIM (vi_vendor_id));
            v_vendor_loc_code := RTRIM (LTRIM (vi_vendor_loc_code));
            v_cod_relacao_contrato := RTRIM (LTRIM (vi_cod_relacao_contrato));
            v_addr_line_1 := RTRIM (LTRIM (vi_addr_line_1));
            v_com_ddd := RTRIM (LTRIM (vi_com_ddd));
            v_street_post_office_box_1 :=
                                  RTRIM (LTRIM (vi_street_post_office_box_1));
            v_com_tel := RTRIM (LTRIM (vi_com_tel));
            v_street_post_office_box_2 :=
                                  RTRIM (LTRIM (vi_street_post_office_box_2));
            v_com_fax := RTRIM (LTRIM (vi_com_fax));
            v_city_name := RTRIM (LTRIM (vi_city_name));
            v_com_email := RTRIM (LTRIM (vi_com_email));
            v_country_sub_entity_code :=
                                   RTRIM (LTRIM (vi_country_sub_entity_code));
            v_postal_code := RTRIM (LTRIM (vi_postal_code));
            v_country_code := RTRIM (LTRIM (vi_country_code));
            v_type_of_pmt := RTRIM (LTRIM (vi_type_of_pmt));
            v_seq_nbr := RTRIM (LTRIM (vi_seq_nbr));
            v_user_id_created_prc := RTRIM (LTRIM (vi_user_id_created_prc));

            UPDATE ifrbde.viw_conf_participantes_u
               SET cod_relacao_contrato = v_cod_relacao_contrato,
                   addr_line_1 = v_addr_line_1,
                   com_ddd = v_com_ddd,
                   street_post_office_box_1 = v_street_post_office_box_1,
                   com_tel = v_com_tel,
                   street_post_office_box_2 = v_street_post_office_box_2,
                   com_fax = v_com_fax,
                   city_name = v_city_name,
                   com_email = v_com_email,
                   country_sub_entity_code = v_country_sub_entity_code,
                   postal_code = v_postal_code,
                   country_code = v_country_code,
                   type_of_pmt = v_type_of_pmt,
                   seq_nbr = v_seq_nbr,
                   user_id_created_prc = v_user_id_created_prc
             WHERE CURRENT OF c_cursor;

            IF SQL%ROWCOUNT = 1 THEN
               stp_pesquisa_conf_participante (p_usuario,
                                               vo_payable_entity_id_prc,
                                               vo_contract_id_prc,
                                               vo_contract_versao_prc,
                                               vo_vendor_id,
                                               vo_vendor_loc_code,
                                               vo_addr_fmt,
                                               vo_cod_relacao_contrato,
                                               vo_addr_line_1,
                                               vo_com_ddd,
                                               vo_street_post_office_box_1,
                                               vo_com_tel,
                                               vo_street_post_office_box_2,
                                               vo_com_fax,
                                               vo_city_name,
                                               vo_com_email,
                                               vo_country_sub_entity_code,
                                               vo_postal_code,
                                               vo_country_code,
                                               vo_type_of_pmt,
                                               vo_seq_nbr,
                                               vo_sistema_origem_code_prc,
                                               vo_contract_versao_origem_prc,
                                               vo_date_created_prc,
                                               vo_user_id_created_prc,
                                               vo_date_changed_prc,
                                               vo_user_id_changed_prc,
                                               vo_inactive_ind_prc,
                                               vo_active_date_prc,
                                               vi_payable_entity_id_prc,
                                               vi_contract_id_prc,
                                               vi_contract_versao_prc,
                                               vi_vendor_id,
                                               vi_vendor_loc_code
                                              );
               v_dado :=
                  'payable_entity_id_prc = '
                  || RTRIM (LTRIM (v_payable_entity_id_prc));
               v_dado :=
                  v_dado
                  || ','
                  || 'contract_id_prc = '
                  || RTRIM (LTRIM (v_contract_id_prc));
               v_dado :=
                  v_dado
                  || ','
                  || 'contract_versao_prc = '
                  || RTRIM (LTRIM (v_contract_versao_prc));
               v_dado :=
                  v_dado || ',' || 'vendor_id = '
                  || RTRIM (LTRIM (v_vendor_id));
               v_dado :=
                  v_dado
                  || ','
                  || 'vendor_loc_code = '
                  || RTRIM (LTRIM (v_vendor_loc_code));
               v_dado :=
                  v_dado
                  || ','
                  || 'cod_relacao_contrato = '
                  || RTRIM (LTRIM (v_cod_relacao_contrato));
               v_dado :=
                  v_dado
                  || ','
                  || 'addr_line_1 = '
                  || RTRIM (LTRIM (v_addr_line_1));
               v_dado :=
                    v_dado || ',' || 'com_ddd = ' || RTRIM (LTRIM (v_com_ddd));
               v_dado :=
                  v_dado
                  || ','
                  || 'street_post_office_box_1 = '
                  || RTRIM (LTRIM (v_street_post_office_box_1));
               v_dado :=
                    v_dado || ',' || 'com_tel = ' || RTRIM (LTRIM (v_com_tel));
               v_dado :=
                  v_dado
                  || ','
                  || 'street_post_office_box_2 = '
                  || RTRIM (LTRIM (v_street_post_office_box_2));
               v_dado :=
                    v_dado || ',' || 'com_fax = ' || RTRIM (LTRIM (v_com_fax));
               v_dado :=
                  v_dado || ',' || 'city_name = '
                  || RTRIM (LTRIM (v_city_name));
               v_dado :=
                  v_dado || ',' || 'com_email = '
                  || RTRIM (LTRIM (v_com_email));
               v_dado :=
                  v_dado
                  || ','
                  || 'country_sub_entity_code = '
                  || RTRIM (LTRIM (v_country_sub_entity_code));
               v_dado :=
                  v_dado
                  || ','
                  || 'postal_code = '
                  || RTRIM (LTRIM (v_postal_code));
               v_dado :=
                  v_dado
                  || ','
                  || 'country_code = '
                  || RTRIM (LTRIM (v_country_code));
               v_dado :=
                  v_dado
                  || ','
                  || 'type_of_pmt = '
                  || RTRIM (LTRIM (v_type_of_pmt));
               v_dado :=
                    v_dado || ',' || 'seq_nbr = ' || RTRIM (LTRIM (v_seq_nbr));
               v_dado :=
                  v_dado
                  || ','
                  || 'user_id_created_prc = '
                  || RTRIM (LTRIM (v_user_id_created_prc));
               -- LOG
               ifrseg.pck_seguranca.stp_log (p_usuario,
                                             'VIW_CONF_PARTICIPANTES_U',
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
-- Pesquisa Termo Aditivo
-- retorna o recordset correspondente
   PROCEDURE stp_pesquisa_conf_termo_u (
      p_usuario                  IN       VARCHAR2,
      vo_payable_entity_id_ter   OUT      tyt_payable_entity_id_ter,
      vo_contract_id_ter         OUT      tyt_contract_id_ter,
      vo_contract_versao_ter     OUT      tyt_contract_versao_ter,
      vo_contract_numero_termo   OUT      tyt_contract_numero_termo,
      vo_data_termo              OUT      tyt_data_termo,
      vo_objeto_desc             OUT      tyt_objeto_desc,
      vo_publicacao_data         OUT      tyt_publicacao_data,
      vo_publicacao_numero_dou   OUT      tyt_publicacao_numero_dou,
      vo_publicacao_secao        OUT      tyt_publicacao_secao,
      vo_publicacao_pagina       OUT      tyt_publicacao_pagina,
      vo_user_fld_3              OUT      tyt_user_fld_3,
      vo_user_fld_4              OUT      tyt_user_fld_4,
      vo_tipo_termo              OUT      tyt_tipo_termo,
      vo_sistema_origem_code_ter OUT      tyt_sistema_origem_code_ter,
      vo_contract_versao_origem_ter OUT   tyt_contract_versao_origem_ter,
      vo_date_created_ter        OUT      tyt_date_created_ter,
      vo_user_id_created_ter     OUT      tyt_user_id_created_ter,
      vo_date_changed_ter        OUT      tyt_date_changed_ter,
      vo_user_id_changed_ter     OUT      tyt_user_id_changed_ter,
      vo_inactive_ind_ter        OUT      tyt_inactive_ind_ter,
      vo_active_date_ter         OUT      tyt_active_date_ter,
      vi_payable_entity_id_ter   IN       t_payable_entity_id_ter,
      vi_contract_id_ter         IN       t_contract_id_ter,
      vi_contract_versao_ter     IN       t_contract_versao_ter
   ) AS
   BEGIN
      IF ifrseg.pck_seguranca.stf_permitido (p_usuario,
                                             'VIW_CONF_TERMO_U',
                                             'PESQUISA'
                                            ) THEN
         SELECT payable_entity_id_ter,
                contract_id_ter,
                contract_versao_ter,
                contract_numero_termo,
                data_termo,
                objeto_desc,
                publicacao_data,
                publicacao_numero_dou,
                publicacao_secao,
                publicacao_pagina,
                user_fld_3,
                user_fld_4,
                tipo_termo,
                sistema_origem_code_ter,
                contract_versao_origem_ter,
                date_created_ter,
                user_id_created_ter,
                date_changed_ter,
                user_id_changed_ter,
                inactive_ind_ter,
                active_date_ter
           INTO vo_payable_entity_id_ter (1),
                vo_contract_id_ter (1),
                vo_contract_versao_ter (1),
                vo_contract_numero_termo (1),
                vo_data_termo (1),
                vo_objeto_desc (1),
                vo_publicacao_data (1),
                vo_publicacao_numero_dou (1),
                vo_publicacao_secao (1),
                vo_publicacao_pagina (1),
                vo_user_fld_3 (1),
                vo_user_fld_4 (1),
                vo_tipo_termo (1),
                vo_sistema_origem_code_ter (1),
                vo_contract_versao_origem_ter (1),
                vo_date_created_ter (1),
                vo_user_id_created_ter (1),
                vo_date_changed_ter (1),
                vo_user_id_changed_ter (1),
                vo_inactive_ind_ter (1),
                vo_active_date_ter (1)
           FROM ifrbde.viw_conf_termo_u
          WHERE payable_entity_id_ter = vi_payable_entity_id_ter
            AND contract_id_ter = vi_contract_id_ter
            AND contract_versao_ter = vi_contract_versao_ter;
      END IF;
   EXCEPTION
      WHEN OTHERS THEN
         raise_application_error (-20100, SQLERRM);
   END;

   -- Exclui Termo Aditivo
   -- retorna o OK ou não
   PROCEDURE stp_exclui_conf_termo_u (
      p_usuario                  IN       VARCHAR2,
      vo_ok                      OUT      tyt_ok,
      vi_payable_entity_id_ter   IN       t_payable_entity_id_ter,
      vi_contract_id_ter         IN       t_contract_id_ter,
      vi_contract_versao_ter     IN       t_contract_versao_ter
   ) AS
      CURSOR c_cursor IS
         SELECT     *
               FROM ifrbde.viw_conf_termo_u
              WHERE payable_entity_id_ter = vi_payable_entity_id_ter
                AND contract_id_ter = vi_contract_id_ter
                AND contract_versao_ter = vi_contract_versao_ter
         FOR UPDATE;

      v_viw_conf_termo_u            ifrbde.viw_conf_termo_u%ROWTYPE;
      v_dado                        VARCHAR2 (4000) := NULL;
   BEGIN
      vo_ok (1) := 0;

      IF ifrseg.pck_seguranca.stf_permitido (p_usuario,
                                             'VIW_CONF_TERMO_U',
                                             'EXCLUI'
                                            ) THEN
         OPEN c_cursor;

         FETCH c_cursor
          INTO v_viw_conf_termo_u;

         IF NOT c_cursor%NOTFOUND THEN
            v_dado :=
               'payable_entity_id_ter = '
               || RTRIM
                       (LTRIM (UPPER (v_viw_conf_termo_u.payable_entity_id_ter)
                              )
                       );
            v_dado :=
               v_dado
               || ','
               || 'contract_id_ter = '
               || RTRIM (LTRIM (UPPER (v_viw_conf_termo_u.contract_id_ter)));
            v_dado :=
               v_dado
               || ','
               || 'contract_versao_ter = '
               || RTRIM (LTRIM (UPPER (v_viw_conf_termo_u.contract_versao_ter))
                        );
            v_dado :=
               v_dado
               || ','
               || 'contract_numero_termo = '
               || RTRIM
                       (LTRIM (UPPER (v_viw_conf_termo_u.contract_numero_termo)
                              )
                       );
            v_dado :=
               v_dado
               || ','
               || 'data_termo = '
               || TO_DATE (v_viw_conf_termo_u.data_termo, 'DD/MM/YYYY');
            v_dado :=
               v_dado
               || ','
               || 'objeto_desc = '
               || RTRIM (LTRIM (UPPER (v_viw_conf_termo_u.objeto_desc)));
            v_dado :=
               v_dado
               || ','
               || 'publicacao_data = '
               || TO_DATE (v_viw_conf_termo_u.publicacao_data, 'DD/MM/YYYY');
            v_dado :=
               v_dado
               || ','
               || 'publicacao_numero_dou = '
               || RTRIM
                       (LTRIM (UPPER (v_viw_conf_termo_u.publicacao_numero_dou)
                              )
                       );
            v_dado :=
               v_dado
               || ','
               || 'publicacao_secao = '
               || RTRIM (LTRIM (UPPER (v_viw_conf_termo_u.publicacao_secao)));
            v_dado :=
               v_dado
               || ','
               || 'publicacao_pagina = '
               || RTRIM (LTRIM (UPPER (v_viw_conf_termo_u.publicacao_pagina)));
            v_dado :=
               v_dado
               || ','
               || 'user_fld_3 = '
               || RTRIM (LTRIM (UPPER (v_viw_conf_termo_u.user_fld_3)));
            v_dado :=
               v_dado
               || ','
               || 'user_fld_4 = '
               || RTRIM (LTRIM (UPPER (v_viw_conf_termo_u.user_fld_4)));
            v_dado :=
               v_dado
               || ','
               || 'tipo_termo = '
               || RTRIM (LTRIM (UPPER (v_viw_conf_termo_u.tipo_termo)));
            v_dado :=
               v_dado
               || ','
               || 'sistema_origem_code_ter = '
               || RTRIM
                     (LTRIM (UPPER (v_viw_conf_termo_u.sistema_origem_code_ter)
                            )
                     );
            v_dado :=
               v_dado
               || ','
               || 'contract_versao_origem_ter = '
               || RTRIM
                    (LTRIM
                         (UPPER (v_viw_conf_termo_u.contract_versao_origem_ter)
                         )
                    );
            v_dado :=
               v_dado
               || ','
               || 'date_created_ter = '
               || TO_DATE (v_viw_conf_termo_u.date_created_ter, 'DD/MM/YYYY');
            v_dado :=
               v_dado
               || ','
               || 'user_id_created_ter = '
               || RTRIM (LTRIM (UPPER (v_viw_conf_termo_u.user_id_created_ter))
                        );
            v_dado :=
               v_dado
               || ','
               || 'date_changed_ter = '
               || TO_DATE (v_viw_conf_termo_u.date_changed_ter, 'DD/MM/YYYY');
            v_dado :=
               v_dado
               || ','
               || 'user_id_changed_ter = '
               || RTRIM (LTRIM (UPPER (v_viw_conf_termo_u.user_id_changed_ter))
                        );
            v_dado :=
               v_dado
               || ','
               || 'inactive_ind_ter = '
               || RTRIM (LTRIM (UPPER (v_viw_conf_termo_u.inactive_ind_ter)));
            v_dado :=
               v_dado
               || ','
               || 'active_date_ter = '
               || TO_DATE (v_viw_conf_termo_u.active_date_ter, 'DD/MM/YYYY');

            IF c_cursor%ROWCOUNT = 1 THEN
               vo_ok (1) := 1;
               -- LOG
               ifrseg.pck_seguranca.stp_log (p_usuario,
                                             'VIW_CONF_TERMO_U',
                                             'E',
                                             v_dado
                                            );

               DELETE FROM ifrbde.viw_conf_termo_u
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
-- Inclui Termo Aditivo
-- retorna o recordset correspondente
   PROCEDURE stp_inclui_conf_termo_u (
      p_usuario                  IN       VARCHAR2,
      vo_payable_entity_id_ter   OUT      tyt_payable_entity_id_ter,
      vo_contract_id_ter         OUT      tyt_contract_id_ter,
      vo_contract_versao_ter     OUT      tyt_contract_versao_ter,
      vo_contract_numero_termo   OUT      tyt_contract_numero_termo,
      vo_data_termo              OUT      tyt_data_termo,
      vo_objeto_desc             OUT      tyt_objeto_desc,
      vo_publicacao_data         OUT      tyt_publicacao_data,
      vo_publicacao_numero_dou   OUT      tyt_publicacao_numero_dou,
      vo_publicacao_secao        OUT      tyt_publicacao_secao,
      vo_publicacao_pagina       OUT      tyt_publicacao_pagina,
      vo_user_fld_3              OUT      tyt_user_fld_3,
      vo_user_fld_4              OUT      tyt_user_fld_4,
      vo_tipo_termo              OUT      tyt_tipo_termo,
      vo_sistema_origem_code_ter OUT      tyt_sistema_origem_code_ter,
      vo_contract_versao_origem_ter OUT   tyt_contract_versao_origem_ter,
      vo_date_created_ter        OUT      tyt_date_created_ter,
      vo_user_id_created_ter     OUT      tyt_user_id_created_ter,
      vo_date_changed_ter        OUT      tyt_date_changed_ter,
      vo_user_id_changed_ter     OUT      tyt_user_id_changed_ter,
      vo_inactive_ind_ter        OUT      tyt_inactive_ind_ter,
      vo_active_date_ter         OUT      tyt_active_date_ter,
      vi_payable_entity_id_ter   IN       t_payable_entity_id_ter,
      vi_contract_id_ter         IN       t_contract_id_ter,
      vi_contract_versao_ter     IN       t_contract_versao_ter,
      vi_contract_numero_termo   IN       t_contract_numero_termo,
      vi_data_termo              IN       t_data_termo,
      vi_objeto_desc             IN       t_objeto_desc,
      vi_publicacao_data         IN       t_publicacao_data,
      vi_publicacao_numero_dou   IN       t_publicacao_numero_dou,
      vi_publicacao_secao        IN       t_publicacao_secao,
      vi_publicacao_pagina       IN       t_publicacao_pagina,
      vi_user_fld_3              IN       t_user_fld_3,
      vi_user_fld_4              IN       t_user_fld_4,
      vi_tipo_termo              IN       t_tipo_termo,
      vi_user_id_created_ter     IN       t_user_id_created_ter
   ) AS
      v_payable_entity_id_ter       viw_conf_termo_u.payable_entity_id_ter%TYPE;
      v_contract_id_ter             viw_conf_termo_u.contract_id_ter%TYPE;
      v_contract_versao_ter         viw_conf_termo_u.contract_versao_ter%TYPE;
      v_contract_numero_termo       viw_conf_termo_u.contract_numero_termo%TYPE;
      v_data_termo                  viw_conf_termo_u.data_termo%TYPE;
      v_objeto_desc                 viw_conf_termo_u.objeto_desc%TYPE;
      v_publicacao_data             viw_conf_termo_u.publicacao_data%TYPE;
      v_publicacao_numero_dou       viw_conf_termo_u.publicacao_numero_dou%TYPE;
      v_publicacao_secao            viw_conf_termo_u.publicacao_secao%TYPE;
      v_publicacao_pagina           viw_conf_termo_u.publicacao_pagina%TYPE;
      v_user_fld_3                  viw_conf_termo_u.user_fld_3%TYPE;
      v_user_fld_4                  viw_conf_termo_u.user_fld_4%TYPE;
      v_tipo_termo                  viw_conf_termo_u.tipo_termo%TYPE;
      v_user_id_created_ter         viw_conf_termo_u.user_id_created_ter%TYPE;
      v_dado                        VARCHAR2 (4000) := NULL;
   BEGIN
      IF ifrseg.pck_seguranca.stf_permitido (p_usuario,
                                             'VIW_CONF_TERMO_U',
                                             'INCLUI'
                                            ) THEN
         v_payable_entity_id_ter := RTRIM (LTRIM (vi_payable_entity_id_ter));
         v_contract_id_ter := RTRIM (LTRIM (vi_contract_id_ter));
         v_contract_versao_ter := RTRIM (LTRIM (vi_contract_versao_ter));
         v_contract_numero_termo := RTRIM (LTRIM (vi_contract_numero_termo));
         v_objeto_desc := RTRIM (LTRIM (vi_objeto_desc));
         v_publicacao_numero_dou := RTRIM (LTRIM (vi_publicacao_numero_dou));
         v_publicacao_secao := RTRIM (LTRIM (vi_publicacao_secao));
         v_publicacao_pagina := RTRIM (LTRIM (vi_publicacao_pagina));
         v_user_fld_3 := RTRIM (LTRIM (vi_user_fld_3));
         v_user_fld_4 := RTRIM (LTRIM (vi_user_fld_4));
         v_tipo_termo := RTRIM (LTRIM (vi_tipo_termo));
         v_user_id_created_ter := RTRIM (LTRIM (vi_user_id_created_ter));
         v_data_termo := TO_DATE (vi_data_termo, 'DD/MM/YYYY');
         v_publicacao_data := TO_DATE (vi_publicacao_data, 'DD/MM/YYYY');

         INSERT INTO ifrbde.viw_conf_termo_u
                     (payable_entity_id_ter,
                      contract_id_ter,
                      contract_versao_ter,
                      contract_numero_termo,
                      data_termo,
                      objeto_desc,
                      publicacao_data,
                      publicacao_numero_dou,
                      publicacao_secao,
                      publicacao_pagina,
                      user_fld_3,
                      user_fld_4,
                      tipo_termo,
                      user_id_created_ter
                     )
              VALUES (v_payable_entity_id_ter,
                      v_contract_id_ter,
                      v_contract_versao_ter,
                      v_contract_numero_termo,
                      v_data_termo,
                      v_objeto_desc,
                      v_publicacao_data,
                      v_publicacao_numero_dou,
                      v_publicacao_secao,
                      v_publicacao_pagina,
                      v_user_fld_3,
                      v_user_fld_4,
                      v_tipo_termo,
                      v_user_id_created_ter
                     );

         IF SQL%ROWCOUNT = 1 THEN
            stp_pesquisa_conf_termo_u (p_usuario,
                                       vo_payable_entity_id_ter,
                                       vo_contract_id_ter,
                                       vo_contract_versao_ter,
                                       vo_contract_numero_termo,
                                       vo_data_termo,
                                       vo_objeto_desc,
                                       vo_publicacao_data,
                                       vo_publicacao_numero_dou,
                                       vo_publicacao_secao,
                                       vo_publicacao_pagina,
                                       vo_user_fld_3,
                                       vo_user_fld_4,
                                       vo_tipo_termo,
                                       vo_sistema_origem_code_ter,
                                       vo_contract_versao_origem_ter,
                                       vo_date_created_ter,
                                       vo_user_id_created_ter,
                                       vo_date_changed_ter,
                                       vo_user_id_changed_ter,
                                       vo_inactive_ind_ter,
                                       vo_active_date_ter,
                                       v_payable_entity_id_ter,
                                       v_contract_id_ter,
                                       v_contract_versao_ter
                                      );
            v_dado :=
               'payable_entity_id_ter = '
               || RTRIM (LTRIM (v_payable_entity_id_ter));
            v_dado :=
               v_dado
               || ','
               || 'contract_id_ter = '
               || RTRIM (LTRIM (v_contract_id_ter));
            v_dado :=
               v_dado
               || ','
               || 'contract_versao_ter = '
               || RTRIM (LTRIM (v_contract_versao_ter));
            v_dado :=
               v_dado
               || ','
               || 'contract_numero_termo = '
               || RTRIM (LTRIM (v_contract_numero_termo));
            v_dado :=
               v_dado
               || ','
               || 'data_termo = '
               || TO_CHAR (v_data_termo, 'DD/MM/YYYY');
            v_dado :=
               v_dado || ',' || 'objeto_desc = '
               || RTRIM (LTRIM (v_objeto_desc));
            v_dado :=
               v_dado
               || ','
               || 'publicacao_data = '
               || TO_CHAR (v_publicacao_data, 'DD/MM/YYYY');
            v_dado :=
               v_dado
               || ','
               || 'publicacao_numero_dou = '
               || RTRIM (LTRIM (v_publicacao_numero_dou));
            v_dado :=
               v_dado
               || ','
               || 'publicacao_secao = '
               || RTRIM (LTRIM (v_publicacao_secao));
            v_dado :=
               v_dado
               || ','
               || 'publicacao_pagina = '
               || RTRIM (LTRIM (v_publicacao_pagina));
            v_dado :=
               v_dado || ',' || 'user_fld_3 = '
               || RTRIM (LTRIM (v_user_fld_3));
            v_dado :=
               v_dado || ',' || 'user_fld_4 = '
               || RTRIM (LTRIM (v_user_fld_4));
            v_dado :=
               v_dado || ',' || 'tipo_termo = '
               || RTRIM (LTRIM (v_tipo_termo));
            v_dado :=
               v_dado
               || ','
               || 'user_id_created_ter = '
               || RTRIM (LTRIM (v_user_id_created_ter));
            -- LOG
            ifrseg.pck_seguranca.stp_log (p_usuario,
                                          'VIW_CONF_TERMO_U',
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
-- Altera Termo Aditivo
-- retorna o recordset correspondente
   PROCEDURE stp_altera_conf_termo_u (
      p_usuario                  IN       VARCHAR2,
      vo_payable_entity_id_ter   OUT      tyt_payable_entity_id_ter,
      vo_contract_id_ter         OUT      tyt_contract_id_ter,
      vo_contract_versao_ter     OUT      tyt_contract_versao_ter,
      vo_contract_numero_termo   OUT      tyt_contract_numero_termo,
      vo_data_termo              OUT      tyt_data_termo,
      vo_objeto_desc             OUT      tyt_objeto_desc,
      vo_publicacao_data         OUT      tyt_publicacao_data,
      vo_publicacao_numero_dou   OUT      tyt_publicacao_numero_dou,
      vo_publicacao_secao        OUT      tyt_publicacao_secao,
      vo_publicacao_pagina       OUT      tyt_publicacao_pagina,
      vo_user_fld_3              OUT      tyt_user_fld_3,
      vo_user_fld_4              OUT      tyt_user_fld_4,
      vo_tipo_termo              OUT      tyt_tipo_termo,
      vo_sistema_origem_code_ter OUT      tyt_sistema_origem_code_ter,
      vo_contract_versao_origem_ter OUT   tyt_contract_versao_origem_ter,
      vo_date_created_ter        OUT      tyt_date_created_ter,
      vo_user_id_created_ter     OUT      tyt_user_id_created_ter,
      vo_date_changed_ter        OUT      tyt_date_changed_ter,
      vo_user_id_changed_ter     OUT      tyt_user_id_changed_ter,
      vo_inactive_ind_ter        OUT      tyt_inactive_ind_ter,
      vo_active_date_ter         OUT      tyt_active_date_ter,
      vi_payable_entity_id_ter   IN       t_payable_entity_id_ter,
      vi_contract_id_ter         IN       t_contract_id_ter,
      vi_contract_versao_ter     IN       t_contract_versao_ter,
      vi_contract_numero_termo   IN       t_contract_numero_termo,
      vi_data_termo              IN       t_data_termo,
      vi_objeto_desc             IN       t_objeto_desc,
      vi_publicacao_data         IN       t_publicacao_data,
      vi_publicacao_numero_dou   IN       t_publicacao_numero_dou,
      vi_publicacao_secao        IN       t_publicacao_secao,
      vi_publicacao_pagina       IN       t_publicacao_pagina,
      vi_user_fld_3              IN       t_user_fld_3,
      vi_user_fld_4              IN       t_user_fld_4,
      vi_tipo_termo              IN       t_tipo_termo,
      vi_user_id_created_ter     IN       t_user_id_created_ter
   ) AS
      CURSOR c_cursor IS
         SELECT     *
               FROM ifrbde.viw_conf_termo_u
              WHERE payable_entity_id_ter = vi_payable_entity_id_ter
                AND contract_id_ter = vi_contract_id_ter
                AND contract_versao_ter = vi_contract_versao_ter
         FOR UPDATE;

      v_viw_conf_termo_u            ifrbde.viw_conf_termo_u%ROWTYPE;
      v_payable_entity_id_ter       ifrbde.viw_conf_termo_u.payable_entity_id_ter%TYPE;
      v_contract_id_ter             ifrbde.viw_conf_termo_u.contract_id_ter%TYPE;
      v_contract_versao_ter         ifrbde.viw_conf_termo_u.contract_versao_ter%TYPE;
      v_contract_numero_termo       ifrbde.viw_conf_termo_u.contract_numero_termo%TYPE;
      v_data_termo                  ifrbde.viw_conf_termo_u.data_termo%TYPE;
      v_objeto_desc                 ifrbde.viw_conf_termo_u.objeto_desc%TYPE;
      v_publicacao_data             ifrbde.viw_conf_termo_u.publicacao_data%TYPE;
      v_publicacao_numero_dou       ifrbde.viw_conf_termo_u.publicacao_numero_dou%TYPE;
      v_publicacao_secao            ifrbde.viw_conf_termo_u.publicacao_secao%TYPE;
      v_publicacao_pagina           ifrbde.viw_conf_termo_u.publicacao_pagina%TYPE;
      v_user_fld_3                  ifrbde.viw_conf_termo_u.user_fld_3%TYPE;
      v_user_fld_4                  ifrbde.viw_conf_termo_u.user_fld_4%TYPE;
      v_tipo_termo                  ifrbde.viw_conf_termo_u.tipo_termo%TYPE;
      v_user_id_created_ter         ifrbde.viw_conf_termo_u.user_id_created_ter%TYPE;
      v_dado                        VARCHAR2 (4000) := NULL;
   BEGIN
      IF ifrseg.pck_seguranca.stf_permitido (p_usuario,
                                             'VIW_CONF_TERMO_U',
                                             'ALTERA'
                                            ) THEN
         OPEN c_cursor;

         FETCH c_cursor
          INTO v_viw_conf_termo_u;

         IF NOT c_cursor%NOTFOUND THEN
            v_payable_entity_id_ter :=
                                     RTRIM (LTRIM (vi_payable_entity_id_ter));
            v_contract_id_ter := RTRIM (LTRIM (vi_contract_id_ter));
            v_contract_versao_ter := RTRIM (LTRIM (vi_contract_versao_ter));
            v_contract_numero_termo :=
                                     RTRIM (LTRIM (vi_contract_numero_termo));
            v_objeto_desc := RTRIM (LTRIM (vi_objeto_desc));
            v_publicacao_numero_dou :=
                                     RTRIM (LTRIM (vi_publicacao_numero_dou));
            v_publicacao_secao := RTRIM (LTRIM (vi_publicacao_secao));
            v_publicacao_pagina := RTRIM (LTRIM (vi_publicacao_pagina));
            v_user_fld_3 := RTRIM (LTRIM (vi_user_fld_3));
            v_user_fld_4 := RTRIM (LTRIM (vi_user_fld_4));
            v_tipo_termo := RTRIM (LTRIM (vi_tipo_termo));
            v_user_id_created_ter := RTRIM (LTRIM (vi_user_id_created_ter));
            v_data_termo := TO_DATE (vi_data_termo, 'DD/MM/YYYY');
            v_publicacao_data := TO_DATE (vi_publicacao_data, 'DD/MM/YYYY');

            UPDATE ifrbde.viw_conf_termo_u
               SET contract_numero_termo = v_contract_numero_termo,
                   data_termo = v_data_termo,
                   objeto_desc = v_objeto_desc,
                   publicacao_data = v_publicacao_data,
                   publicacao_numero_dou = v_publicacao_numero_dou,
                   publicacao_secao = v_publicacao_secao,
                   publicacao_pagina = v_publicacao_pagina,
                   user_fld_3 = v_user_fld_3,
                   user_fld_4 = v_user_fld_4,
                   tipo_termo = v_tipo_termo,
                   user_id_created_ter = v_user_id_created_ter
             WHERE CURRENT OF c_cursor;

            IF SQL%ROWCOUNT = 1 THEN
               stp_pesquisa_conf_termo_u (p_usuario,
                                          vo_payable_entity_id_ter,
                                          vo_contract_id_ter,
                                          vo_contract_versao_ter,
                                          vo_contract_numero_termo,
                                          vo_data_termo,
                                          vo_objeto_desc,
                                          vo_publicacao_data,
                                          vo_publicacao_numero_dou,
                                          vo_publicacao_secao,
                                          vo_publicacao_pagina,
                                          vo_user_fld_3,
                                          vo_user_fld_4,
                                          vo_tipo_termo,
                                          vo_sistema_origem_code_ter,
                                          vo_contract_versao_origem_ter,
                                          vo_date_created_ter,
                                          vo_user_id_created_ter,
                                          vo_date_changed_ter,
                                          vo_user_id_changed_ter,
                                          vo_inactive_ind_ter,
                                          vo_active_date_ter,
                                          vi_payable_entity_id_ter,
                                          vi_contract_id_ter,
                                          vi_contract_versao_ter
                                         );
               v_dado :=
                  'payable_entity_id_ter = '
                  || RTRIM (LTRIM (v_payable_entity_id_ter));
               v_dado :=
                  v_dado
                  || ','
                  || 'contract_id_ter = '
                  || RTRIM (LTRIM (v_contract_id_ter));
               v_dado :=
                  v_dado
                  || ','
                  || 'contract_versao_ter = '
                  || RTRIM (LTRIM (v_contract_versao_ter));
               v_dado :=
                  v_dado
                  || ','
                  || 'contract_numero_termo = '
                  || RTRIM (LTRIM (v_contract_numero_termo));
               v_dado :=
                  v_dado
                  || ','
                  || 'data_termo = '
                  || TO_CHAR (v_data_termo, 'DD/MM/YYYY');
               v_dado :=
                  v_dado
                  || ','
                  || 'objeto_desc = '
                  || RTRIM (LTRIM (v_objeto_desc));
               v_dado :=
                  v_dado
                  || ','
                  || 'publicacao_data = '
                  || TO_CHAR (v_publicacao_data, 'DD/MM/YYYY');
               v_dado :=
                  v_dado
                  || ','
                  || 'publicacao_numero_dou = '
                  || RTRIM (LTRIM (v_publicacao_numero_dou));
               v_dado :=
                  v_dado
                  || ','
                  || 'publicacao_secao = '
                  || RTRIM (LTRIM (v_publicacao_secao));
               v_dado :=
                  v_dado
                  || ','
                  || 'publicacao_pagina = '
                  || RTRIM (LTRIM (v_publicacao_pagina));
               v_dado :=
                  v_dado
                  || ','
                  || 'user_fld_3 = '
                  || RTRIM (LTRIM (v_user_fld_3));
               v_dado :=
                  v_dado
                  || ','
                  || 'user_fld_4 = '
                  || RTRIM (LTRIM (v_user_fld_4));
               v_dado :=
                  v_dado
                  || ','
                  || 'tipo_termo = '
                  || RTRIM (LTRIM (v_tipo_termo));
               v_dado :=
                  v_dado
                  || ','
                  || 'user_id_created_ter = '
                  || RTRIM (LTRIM (v_user_id_created_ter));
               -- LOG
               ifrseg.pck_seguranca.stp_log (p_usuario,
                                             'VIW_CONF_TERMO_U',
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
-- Pesquisa Contrato Item - Identificação
-- retorna o recordset correspondente
   PROCEDURE stp_pesquisa_conf_item_ident_u (
      p_usuario                  IN       VARCHAR2,
      vo_payable_entity_id_iid   OUT      tyt_payable_entity_id_iid,
      vo_contract_id_iid         OUT      tyt_contract_id_iid,
      vo_contract_versao_iid     OUT      tyt_contract_versao_iid,
      vo_seq_item                OUT      tyt_seq_item,
      vo_qty                     OUT      tyt_qty,
      vo_unit_of_measure         OUT      tyt_unit_of_measure,
      vo_item_id                 OUT      tyt_item_id,
      vo_item_descp              OUT      tyt_item_descp,
      vo_sistema_origem_code_iid OUT      tyt_sistema_origem_code_iid,
      vo_contract_versao_origem_iid OUT   tyt_contract_versao_origem_iid,
      vo_date_created_iid        OUT      tyt_date_created_iid,
      vo_user_id_created_iid     OUT      tyt_user_id_created_iid,
      vo_date_changed_iid        OUT      tyt_date_changed_iid,
      vo_user_id_changed_iid     OUT      tyt_user_id_changed_iid,
      vo_inactive_ind_iid        OUT      tyt_inactive_ind_iid,
      vo_active_date_iid         OUT      tyt_active_date_iid,
      vi_payable_entity_id_iid   IN       t_payable_entity_id_iid,
      vi_contract_id_iid         IN       t_contract_id_iid,
      vi_contract_versao_iid     IN       t_contract_versao_iid
   ) AS
   BEGIN
      IF ifrseg.pck_seguranca.stf_permitido (p_usuario,
                                             'VIW_CONF_ITEM_IDENT_U',
                                             'PESQUISA'
                                            ) THEN
         SELECT payable_entity_id_iid,
                contract_id_iid,
                contract_versao_iid,
                seq_item,
                qty,
                unit_of_measure,
                item_id,
                item_descp,
                sistema_origem_code_iid,
                contract_versao_origem_iid,
                date_created_iid,
                user_id_created_iid,
                date_changed_iid,
                user_id_changed_iid,
                inactive_ind_iid,
                active_date_iid
           INTO vo_payable_entity_id_iid (1),
                vo_contract_id_iid (1),
                vo_contract_versao_iid (1),
                vo_seq_item (1),
                vo_qty (1),
                vo_unit_of_measure (1),
                vo_item_id (1),
                vo_item_descp (1),
                vo_sistema_origem_code_iid (1),
                vo_contract_versao_origem_iid (1),
                vo_date_created_iid (1),
                vo_user_id_created_iid (1),
                vo_date_changed_iid (1),
                vo_user_id_changed_iid (1),
                vo_inactive_ind_iid (1),
                vo_active_date_iid (1)
           FROM ifrbde.viw_conf_item_ident_u
          WHERE payable_entity_id_iid = vi_payable_entity_id_iid
            AND contract_id_iid = vi_contract_id_iid
            AND contract_versao_iid = vi_contract_versao_iid;
      END IF;
   EXCEPTION
      WHEN OTHERS THEN
         raise_application_error (-20100, SQLERRM);
   END;

   -- Exclui Contrato Item - Identificação
   -- retorna o OK ou não
   PROCEDURE stp_exclui_conf_item_ident_u (
      p_usuario                  IN       VARCHAR2,
      vo_ok                      OUT      tyt_ok,
      vi_payable_entity_id_iid   IN       t_payable_entity_id_iid,
      vi_contract_id_iid         IN       t_contract_id_iid,
      vi_contract_versao_iid     IN       t_contract_versao_iid
   ) AS
      CURSOR c_cursor IS
         SELECT     *
               FROM ifrbde.viw_conf_item_ident_u
              WHERE payable_entity_id_iid = vi_payable_entity_id_iid
                AND contract_id_iid = vi_contract_id_iid
                AND contract_versao_iid = vi_contract_versao_iid
         FOR UPDATE;

      v_viw_conf_item_ident_u       ifrbde.viw_conf_item_ident_u%ROWTYPE;
      v_dado                        VARCHAR2 (4000) := NULL;
   BEGIN
      vo_ok (1) := 0;

      IF ifrseg.pck_seguranca.stf_permitido (p_usuario,
                                             'VIW_CONF_ITEM_IDENT_U',
                                             'EXCLUI'
                                            ) THEN
         OPEN c_cursor;

         FETCH c_cursor
          INTO v_viw_conf_item_ident_u;

         IF NOT c_cursor%NOTFOUND THEN
            v_dado :=
               'payable_entity_id_iid = '
               || RTRIM
                    (LTRIM
                         (UPPER (v_viw_conf_item_ident_u.payable_entity_id_iid)
                         )
                    );
            v_dado :=
               v_dado
               || ','
               || 'contract_id_iid = '
               || RTRIM (LTRIM (UPPER (v_viw_conf_item_ident_u.contract_id_iid)
                               )
                        );
            v_dado :=
               v_dado
               || ','
               || 'contract_versao_iid = '
               || RTRIM
                    (LTRIM (UPPER (v_viw_conf_item_ident_u.contract_versao_iid)
                           )
                    );
            v_dado :=
               v_dado
               || ','
               || 'seq_item = '
               || RTRIM (LTRIM (UPPER (v_viw_conf_item_ident_u.seq_item)));
            v_dado :=
               v_dado || ',' || 'qty = '
               || TO_CHAR (v_viw_conf_item_ident_u.qty);
            v_dado :=
               v_dado
               || ','
               || 'unit_of_measure = '
               || RTRIM (LTRIM (UPPER (v_viw_conf_item_ident_u.unit_of_measure)
                               )
                        );
            v_dado :=
               v_dado
               || ','
               || 'item_id = '
               || RTRIM (LTRIM (UPPER (v_viw_conf_item_ident_u.item_id)));
            v_dado :=
               v_dado
               || ','
               || 'item_descp = '
               || RTRIM (LTRIM (UPPER (v_viw_conf_item_ident_u.item_descp)));
            v_dado :=
               v_dado
               || ','
               || 'sistema_origem_code_iid = '
               || RTRIM
                    (LTRIM
                        (UPPER
                              (v_viw_conf_item_ident_u.sistema_origem_code_iid)
                        )
                    );
            v_dado :=
               v_dado
               || ','
               || 'contract_versao_origem_iid = '
               || RTRIM
                    (LTRIM
                        (UPPER
                            (v_viw_conf_item_ident_u.contract_versao_origem_iid
                            )
                        )
                    );
            v_dado :=
               v_dado
               || ','
               || 'date_created_iid = '
               || TO_DATE (v_viw_conf_item_ident_u.date_created_iid,
                           'DD/MM/YYYY'
                          );
            v_dado :=
               v_dado
               || ','
               || 'user_id_created_iid = '
               || RTRIM
                    (LTRIM (UPPER (v_viw_conf_item_ident_u.user_id_created_iid)
                           )
                    );
            v_dado :=
               v_dado
               || ','
               || 'date_changed_iid = '
               || TO_DATE (v_viw_conf_item_ident_u.date_changed_iid,
                           'DD/MM/YYYY'
                          );
            v_dado :=
               v_dado
               || ','
               || 'user_id_changed_iid = '
               || RTRIM
                    (LTRIM (UPPER (v_viw_conf_item_ident_u.user_id_changed_iid)
                           )
                    );
            v_dado :=
               v_dado
               || ','
               || 'inactive_ind_iid = '
               || RTRIM
                       (LTRIM (UPPER (v_viw_conf_item_ident_u.inactive_ind_iid)
                              )
                       );
            v_dado :=
               v_dado
               || ','
               || 'active_date_iid = '
               || TO_DATE (v_viw_conf_item_ident_u.active_date_iid,
                           'DD/MM/YYYY'
                          );

            IF c_cursor%ROWCOUNT = 1 THEN
               vo_ok (1) := 1;
               -- LOG
               ifrseg.pck_seguranca.stp_log (p_usuario,
                                             'VIW_CONF_ITEM_IDENT_U',
                                             'E',
                                             v_dado
                                            );

               DELETE FROM ifrbde.viw_conf_item_ident_u
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
-- Inclui Contrato Item - Identificação
-- retorna o recordset correspondente
   PROCEDURE stp_inclui_conf_item_ident_u (
      p_usuario                  IN       VARCHAR2,
      vo_payable_entity_id_iid   OUT      tyt_payable_entity_id_iid,
      vo_contract_id_iid         OUT      tyt_contract_id_iid,
      vo_contract_versao_iid     OUT      tyt_contract_versao_iid,
      vo_seq_item                OUT      tyt_seq_item,
      vo_qty                     OUT      tyt_qty,
      vo_unit_of_measure         OUT      tyt_unit_of_measure,
      vo_item_id                 OUT      tyt_item_id,
      vo_item_descp              OUT      tyt_item_descp,
      vo_sistema_origem_code_iid OUT      tyt_sistema_origem_code_iid,
      vo_contract_versao_origem_iid OUT   tyt_contract_versao_origem_iid,
      vo_date_created_iid        OUT      tyt_date_created_iid,
      vo_user_id_created_iid     OUT      tyt_user_id_created_iid,
      vo_date_changed_iid        OUT      tyt_date_changed_iid,
      vo_user_id_changed_iid     OUT      tyt_user_id_changed_iid,
      vo_inactive_ind_iid        OUT      tyt_inactive_ind_iid,
      vo_active_date_iid         OUT      tyt_active_date_iid,
      vi_payable_entity_id_iid   IN       t_payable_entity_id_iid,
      vi_contract_id_iid         IN       t_contract_id_iid,
      vi_contract_versao_iid     IN       t_contract_versao_iid,
      vi_seq_item                IN       t_seq_item,
      vi_qty                     IN       t_qty,
      vi_unit_of_measure         IN       t_unit_of_measure,
      vi_item_id                 IN       t_item_id,
      vi_item_descp              IN       t_item_descp,
      vi_user_id_created_iid     IN       t_user_id_created_iid
   ) AS
      v_payable_entity_id_iid       viw_conf_item_ident_u.payable_entity_id_iid%TYPE;
      v_contract_id_iid             viw_conf_item_ident_u.contract_id_iid%TYPE;
      v_contract_versao_iid         viw_conf_item_ident_u.contract_versao_iid%TYPE;
      v_seq_item                    viw_conf_item_ident_u.seq_item%TYPE;
      v_qty                         viw_conf_item_ident_u.qty%TYPE;
      v_unit_of_measure             viw_conf_item_ident_u.unit_of_measure%TYPE;
      v_item_id                     viw_conf_item_ident_u.item_id%TYPE;
      v_item_descp                  viw_conf_item_ident_u.item_descp%TYPE;
      v_user_id_created_iid         viw_conf_item_ident_u.user_id_created_iid%TYPE;
      v_dado                        VARCHAR2 (4000) := NULL;
   BEGIN
      IF ifrseg.pck_seguranca.stf_permitido (p_usuario,
                                             'VIW_CONF_ITEM_IDENT_U',
                                             'INCLUI'
                                            ) THEN
         v_payable_entity_id_iid := RTRIM (LTRIM (vi_payable_entity_id_iid));
         v_contract_id_iid := RTRIM (LTRIM (vi_contract_id_iid));
         v_contract_versao_iid := RTRIM (LTRIM (vi_contract_versao_iid));
         v_seq_item := RTRIM (LTRIM (vi_seq_item));
         v_unit_of_measure := RTRIM (LTRIM (vi_unit_of_measure));
         v_item_id := RTRIM (LTRIM (vi_item_id));
         v_item_descp := RTRIM (LTRIM (vi_item_descp));
         v_user_id_created_iid := RTRIM (LTRIM (vi_user_id_created_iid));
         v_qty := vi_qty;

         INSERT INTO ifrbde.viw_conf_item_ident_u
                     (payable_entity_id_iid,
                      contract_id_iid,
                      contract_versao_iid,
                      seq_item,
                      qty,
                      unit_of_measure,
                      item_id,
                      item_descp,
                      user_id_created_iid
                     )
              VALUES (v_payable_entity_id_iid,
                      v_contract_id_iid,
                      v_contract_versao_iid,
                      v_seq_item,
                      v_qty,
                      v_unit_of_measure,
                      v_item_id,
                      v_item_descp,
                      v_user_id_created_iid
                     );

         IF SQL%ROWCOUNT = 1 THEN
            stp_pesquisa_conf_item_ident_u (p_usuario,
                                            vo_payable_entity_id_iid,
                                            vo_contract_id_iid,
                                            vo_contract_versao_iid,
                                            vo_seq_item,
                                            vo_qty,
                                            vo_unit_of_measure,
                                            vo_item_id,
                                            vo_item_descp,
                                            vo_sistema_origem_code_iid,
                                            vo_contract_versao_origem_iid,
                                            vo_date_created_iid,
                                            vo_user_id_created_iid,
                                            vo_date_changed_iid,
                                            vo_user_id_changed_iid,
                                            vo_inactive_ind_iid,
                                            vo_active_date_iid,
                                            v_payable_entity_id_iid,
                                            v_contract_id_iid,
                                            v_contract_versao_iid
                                           );
            v_dado :=
               'payable_entity_id_iid = '
               || RTRIM (LTRIM (v_payable_entity_id_iid));
            v_dado :=
               v_dado
               || ','
               || 'contract_id_iid = '
               || RTRIM (LTRIM (v_contract_id_iid));
            v_dado :=
               v_dado
               || ','
               || 'contract_versao_iid = '
               || RTRIM (LTRIM (v_contract_versao_iid));
            v_dado :=
                  v_dado || ',' || 'seq_item = ' || RTRIM (LTRIM (v_seq_item));
            v_dado := v_dado || ',' || 'qty = ' || TO_CHAR (v_qty);
            v_dado :=
               v_dado
               || ','
               || 'unit_of_measure = '
               || RTRIM (LTRIM (v_unit_of_measure));
            v_dado :=
                    v_dado || ',' || 'item_id = ' || RTRIM (LTRIM (v_item_id));
            v_dado :=
               v_dado || ',' || 'item_descp = '
               || RTRIM (LTRIM (v_item_descp));
            v_dado :=
               v_dado
               || ','
               || 'user_id_created_iid = '
               || RTRIM (LTRIM (v_user_id_created_iid));
            -- LOG
            ifrseg.pck_seguranca.stp_log (p_usuario,
                                          'VIW_CONF_ITEM_IDENT_U',
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
-- Altera Contrato Item - Identificação
-- retorna o recordset correspondente
   PROCEDURE stp_altera_conf_item_ident_u (
      p_usuario                  IN       VARCHAR2,
      vo_payable_entity_id_iid   OUT      tyt_payable_entity_id_iid,
      vo_contract_id_iid         OUT      tyt_contract_id_iid,
      vo_contract_versao_iid     OUT      tyt_contract_versao_iid,
      vo_seq_item                OUT      tyt_seq_item,
      vo_qty                     OUT      tyt_qty,
      vo_unit_of_measure         OUT      tyt_unit_of_measure,
      vo_item_id                 OUT      tyt_item_id,
      vo_item_descp              OUT      tyt_item_descp,
      vo_sistema_origem_code_iid OUT      tyt_sistema_origem_code_iid,
      vo_contract_versao_origem_iid OUT   tyt_contract_versao_origem_iid,
      vo_date_created_iid        OUT      tyt_date_created_iid,
      vo_user_id_created_iid     OUT      tyt_user_id_created_iid,
      vo_date_changed_iid        OUT      tyt_date_changed_iid,
      vo_user_id_changed_iid     OUT      tyt_user_id_changed_iid,
      vo_inactive_ind_iid        OUT      tyt_inactive_ind_iid,
      vo_active_date_iid         OUT      tyt_active_date_iid,
      vi_payable_entity_id_iid   IN       t_payable_entity_id_iid,
      vi_contract_id_iid         IN       t_contract_id_iid,
      vi_contract_versao_iid     IN       t_contract_versao_iid,
      vi_seq_item                IN       t_seq_item,
      vi_qty                     IN       t_qty,
      vi_unit_of_measure         IN       t_unit_of_measure,
      vi_item_id                 IN       t_item_id,
      vi_item_descp              IN       t_item_descp,
      vi_user_id_created_iid     IN       t_user_id_created_iid
   ) AS
      CURSOR c_cursor IS
         SELECT     *
               FROM ifrbde.viw_conf_item_ident_u
              WHERE payable_entity_id_iid = vi_payable_entity_id_iid
                AND contract_id_iid = vi_contract_id_iid
                AND contract_versao_iid = vi_contract_versao_iid
         FOR UPDATE;

      v_viw_conf_item_ident_u       ifrbde.viw_conf_item_ident_u%ROWTYPE;
      v_payable_entity_id_iid       ifrbde.viw_conf_item_ident_u.payable_entity_id_iid%TYPE;
      v_contract_id_iid             ifrbde.viw_conf_item_ident_u.contract_id_iid%TYPE;
      v_contract_versao_iid         ifrbde.viw_conf_item_ident_u.contract_versao_iid%TYPE;
      v_seq_item                    ifrbde.viw_conf_item_ident_u.seq_item%TYPE;
      v_qty                         ifrbde.viw_conf_item_ident_u.qty%TYPE;
      v_unit_of_measure             ifrbde.viw_conf_item_ident_u.unit_of_measure%TYPE;
      v_item_id                     ifrbde.viw_conf_item_ident_u.item_id%TYPE;
      v_item_descp                  ifrbde.viw_conf_item_ident_u.item_descp%TYPE;
      v_user_id_created_iid         ifrbde.viw_conf_item_ident_u.user_id_created_iid%TYPE;
      v_dado                        VARCHAR2 (4000) := NULL;
   BEGIN
      IF ifrseg.pck_seguranca.stf_permitido (p_usuario,
                                             'VIW_CONF_ITEM_IDENT_U',
                                             'ALTERA'
                                            ) THEN
         OPEN c_cursor;

         FETCH c_cursor
          INTO v_viw_conf_item_ident_u;

         IF NOT c_cursor%NOTFOUND THEN
            v_payable_entity_id_iid :=
                                     RTRIM (LTRIM (vi_payable_entity_id_iid));
            v_contract_id_iid := RTRIM (LTRIM (vi_contract_id_iid));
            v_contract_versao_iid := RTRIM (LTRIM (vi_contract_versao_iid));
            v_seq_item := RTRIM (LTRIM (vi_seq_item));
            v_unit_of_measure := RTRIM (LTRIM (vi_unit_of_measure));
            v_item_id := RTRIM (LTRIM (vi_item_id));
            v_item_descp := RTRIM (LTRIM (vi_item_descp));
            v_user_id_created_iid := RTRIM (LTRIM (vi_user_id_created_iid));
            v_qty := vi_qty;

            UPDATE ifrbde.viw_conf_item_ident_u
               SET seq_item = v_seq_item,
                   qty = v_qty,
                   unit_of_measure = v_unit_of_measure,
                   item_id = v_item_id,
                   item_descp = v_item_descp,
                   user_id_created_iid = v_user_id_created_iid
             WHERE CURRENT OF c_cursor;

            IF SQL%ROWCOUNT = 1 THEN
               stp_pesquisa_conf_item_ident_u (p_usuario,
                                               vo_payable_entity_id_iid,
                                               vo_contract_id_iid,
                                               vo_contract_versao_iid,
                                               vo_seq_item,
                                               vo_qty,
                                               vo_unit_of_measure,
                                               vo_item_id,
                                               vo_item_descp,
                                               vo_sistema_origem_code_iid,
                                               vo_contract_versao_origem_iid,
                                               vo_date_created_iid,
                                               vo_user_id_created_iid,
                                               vo_date_changed_iid,
                                               vo_user_id_changed_iid,
                                               vo_inactive_ind_iid,
                                               vo_active_date_iid,
                                               vi_payable_entity_id_iid,
                                               vi_contract_id_iid,
                                               vi_contract_versao_iid
                                              );
               v_dado :=
                  'payable_entity_id_iid = '
                  || RTRIM (LTRIM (v_payable_entity_id_iid));
               v_dado :=
                  v_dado
                  || ','
                  || 'contract_id_iid = '
                  || RTRIM (LTRIM (v_contract_id_iid));
               v_dado :=
                  v_dado
                  || ','
                  || 'contract_versao_iid = '
                  || RTRIM (LTRIM (v_contract_versao_iid));
               v_dado :=
                  v_dado || ',' || 'seq_item = ' || RTRIM (LTRIM (v_seq_item));
               v_dado := v_dado || ',' || 'qty = ' || TO_CHAR (v_qty);
               v_dado :=
                  v_dado
                  || ','
                  || 'unit_of_measure = '
                  || RTRIM (LTRIM (v_unit_of_measure));
               v_dado :=
                    v_dado || ',' || 'item_id = ' || RTRIM (LTRIM (v_item_id));
               v_dado :=
                  v_dado
                  || ','
                  || 'item_descp = '
                  || RTRIM (LTRIM (v_item_descp));
               v_dado :=
                  v_dado
                  || ','
                  || 'user_id_created_iid = '
                  || RTRIM (LTRIM (v_user_id_created_iid));
               -- LOG
               ifrseg.pck_seguranca.stp_log (p_usuario,
                                             'VIW_CONF_ITEM_IDENT_U',
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
-- Pesquisa Contrato Item - Projeto
-- retorna o recordset correspondente
   PROCEDURE stp_pesquisa_conf_item_projeto (
      p_usuario                  IN       VARCHAR2,
      vo_payable_entity_id_ipr   OUT      tyt_payable_entity_id_ipr,
      vo_contract_id_ipr         OUT      tyt_contract_id_ipr,
      vo_contract_versao_ipr     OUT      tyt_contract_versao_ipr,
      vo_seq_item                OUT      tyt_seq_item,
      vo_project_ind_automatico  OUT      tyt_project_ind_automatico,
      vo_project_entity_id       OUT      tyt_project_entity_id,
      vo_project_id              OUT      tyt_project_id,
      vo_component_id            OUT      tyt_component_id,
      vo_cost_element_id         OUT      tyt_cost_element_id,
      vo_manager_id              OUT      tyt_manager_id,
      vo_security_code           OUT      tyt_security_code,
      vo_sistema_origem_code_ipr OUT      tyt_sistema_origem_code_ipr,
      vo_contract_versao_origem_ipr OUT   tyt_contract_versao_origem_ipr,
      vo_date_created_ipr        OUT      tyt_date_created_ipr,
      vo_user_id_created_ipr     OUT      tyt_user_id_created_ipr,
      vo_date_changed_ipr        OUT      tyt_date_changed_ipr,
      vo_user_id_changed_ipr     OUT      tyt_user_id_changed_ipr,
      vo_inactive_ind_ipr        OUT      tyt_inactive_ind_ipr,
      vo_active_date_ipr         OUT      tyt_active_date_ipr,
      vi_payable_entity_id_ipr   IN       t_payable_entity_id_ipr,
      vi_contract_id_ipr         IN       t_contract_id_ipr,
      vi_contract_versao_ipr     IN       t_contract_versao_ipr
   ) AS
   BEGIN
      IF ifrseg.pck_seguranca.stf_permitido (p_usuario,
                                             'VIW_CONF_ITEM_PROJETO_U',
                                             'PESQUISA'
                                            ) THEN
         SELECT payable_entity_id_ipr,
                contract_id_ipr,
                contract_versao_ipr,
                seq_item,
                project_ind_automatico,
                project_entity_id,
                project_id,
                component_id,
                cost_element_id,
                manager_id,
                security_code,
                sistema_origem_code_ipr,
                contract_versao_origem_ipr,
                date_created_ipr,
                user_id_created_ipr,
                date_changed_ipr,
                user_id_changed_ipr,
                inactive_ind_ipr,
                active_date_ipr
           INTO vo_payable_entity_id_ipr (1),
                vo_contract_id_ipr (1),
                vo_contract_versao_ipr (1),
                vo_seq_item (1),
                vo_project_ind_automatico (1),
                vo_project_entity_id (1),
                vo_project_id (1),
                vo_component_id (1),
                vo_cost_element_id (1),
                vo_manager_id (1),
                vo_security_code (1),
                vo_sistema_origem_code_ipr (1),
                vo_contract_versao_origem_ipr (1),
                vo_date_created_ipr (1),
                vo_user_id_created_ipr (1),
                vo_date_changed_ipr (1),
                vo_user_id_changed_ipr (1),
                vo_inactive_ind_ipr (1),
                vo_active_date_ipr (1)
           FROM ifrbde.viw_conf_item_projeto_u
          WHERE payable_entity_id_ipr = vi_payable_entity_id_ipr
            AND contract_id_ipr = vi_contract_id_ipr
            AND contract_versao_ipr = vi_contract_versao_ipr;
      END IF;
   EXCEPTION
      WHEN OTHERS THEN
         raise_application_error (-20100, SQLERRM);
   END;

   -- Exclui Contrato Item - Projeto
   -- retorna o OK ou não
   PROCEDURE stp_exclui_conf_item_projeto_u (
      p_usuario                  IN       VARCHAR2,
      vo_ok                      OUT      tyt_ok,
      vi_payable_entity_id_ipr   IN       t_payable_entity_id_ipr,
      vi_contract_id_ipr         IN       t_contract_id_ipr,
      vi_contract_versao_ipr     IN       t_contract_versao_ipr
   ) AS
      CURSOR c_cursor IS
         SELECT     *
               FROM ifrbde.viw_conf_item_projeto_u
              WHERE payable_entity_id_ipr = vi_payable_entity_id_ipr
                AND contract_id_ipr = vi_contract_id_ipr
                AND contract_versao_ipr = vi_contract_versao_ipr
         FOR UPDATE;

      v_viw_conf_item_projeto_u     ifrbde.viw_conf_item_projeto_u%ROWTYPE;
      v_dado                        VARCHAR2 (4000) := NULL;
   BEGIN
      vo_ok (1) := 0;

      IF ifrseg.pck_seguranca.stf_permitido (p_usuario,
                                             'VIW_CONF_ITEM_PROJETO_U',
                                             'EXCLUI'
                                            ) THEN
         OPEN c_cursor;

         FETCH c_cursor
          INTO v_viw_conf_item_projeto_u;

         IF NOT c_cursor%NOTFOUND THEN
            v_dado :=
               'payable_entity_id_ipr = '
               || RTRIM
                    (LTRIM
                        (UPPER
                              (v_viw_conf_item_projeto_u.payable_entity_id_ipr)
                        )
                    );
            v_dado :=
               v_dado
               || ','
               || 'contract_id_ipr = '
               || RTRIM
                      (LTRIM (UPPER (v_viw_conf_item_projeto_u.contract_id_ipr)
                             )
                      );
            v_dado :=
               v_dado
               || ','
               || 'contract_versao_ipr = '
               || RTRIM
                    (LTRIM
                         (UPPER (v_viw_conf_item_projeto_u.contract_versao_ipr)
                         )
                    );
            v_dado :=
               v_dado
               || ','
               || 'seq_item = '
               || RTRIM (LTRIM (UPPER (v_viw_conf_item_projeto_u.seq_item)));
            v_dado :=
               v_dado
               || ','
               || 'project_ind_automatico = '
               || RTRIM
                    (LTRIM
                        (UPPER
                             (v_viw_conf_item_projeto_u.project_ind_automatico)
                        )
                    );
            v_dado :=
               v_dado
               || ','
               || 'project_entity_id = '
               || RTRIM
                    (LTRIM (UPPER (v_viw_conf_item_projeto_u.project_entity_id)
                           )
                    );
            v_dado :=
               v_dado
               || ','
               || 'project_id = '
               || RTRIM (LTRIM (UPPER (v_viw_conf_item_projeto_u.project_id)));
            v_dado :=
               v_dado
               || ','
               || 'component_id = '
               || RTRIM (LTRIM (UPPER (v_viw_conf_item_projeto_u.component_id))
                        );
            v_dado :=
               v_dado
               || ','
               || 'cost_element_id = '
               || RTRIM
                      (LTRIM (UPPER (v_viw_conf_item_projeto_u.cost_element_id)
                             )
                      );
            v_dado :=
               v_dado
               || ','
               || 'manager_id = '
               || RTRIM (LTRIM (UPPER (v_viw_conf_item_projeto_u.manager_id)));
            v_dado :=
               v_dado
               || ','
               || 'security_code = '
               || RTRIM (LTRIM (UPPER (v_viw_conf_item_projeto_u.security_code)
                               )
                        );
            v_dado :=
               v_dado
               || ','
               || 'sistema_origem_code_ipr = '
               || RTRIM
                    (LTRIM
                        (UPPER
                            (v_viw_conf_item_projeto_u.sistema_origem_code_ipr)
                        )
                    );
            v_dado :=
               v_dado
               || ','
               || 'contract_versao_origem_ipr = '
               || RTRIM
                    (LTRIM
                        (UPPER
                            (v_viw_conf_item_projeto_u.contract_versao_origem_ipr
                            )
                        )
                    );
            v_dado :=
               v_dado
               || ','
               || 'date_created_ipr = '
               || TO_DATE (v_viw_conf_item_projeto_u.date_created_ipr,
                           'DD/MM/YYYY'
                          );
            v_dado :=
               v_dado
               || ','
               || 'user_id_created_ipr = '
               || RTRIM
                    (LTRIM
                         (UPPER (v_viw_conf_item_projeto_u.user_id_created_ipr)
                         )
                    );
            v_dado :=
               v_dado
               || ','
               || 'date_changed_ipr = '
               || TO_DATE (v_viw_conf_item_projeto_u.date_changed_ipr,
                           'DD/MM/YYYY'
                          );
            v_dado :=
               v_dado
               || ','
               || 'user_id_changed_ipr = '
               || RTRIM
                    (LTRIM
                         (UPPER (v_viw_conf_item_projeto_u.user_id_changed_ipr)
                         )
                    );
            v_dado :=
               v_dado
               || ','
               || 'inactive_ind_ipr = '
               || RTRIM
                     (LTRIM (UPPER (v_viw_conf_item_projeto_u.inactive_ind_ipr)
                            )
                     );
            v_dado :=
               v_dado
               || ','
               || 'active_date_ipr = '
               || TO_DATE (v_viw_conf_item_projeto_u.active_date_ipr,
                           'DD/MM/YYYY'
                          );

            IF c_cursor%ROWCOUNT = 1 THEN
               vo_ok (1) := 1;
               -- LOG
               ifrseg.pck_seguranca.stp_log (p_usuario,
                                             'VIW_CONF_ITEM_PROJETO_U',
                                             'E',
                                             v_dado
                                            );

               DELETE FROM ifrbde.viw_conf_item_projeto_u
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
-- Inclui Contrato Item - Projeto
-- retorna o recordset correspondente
   PROCEDURE stp_inclui_conf_item_projeto_u (
      p_usuario                  IN       VARCHAR2,
      vo_payable_entity_id_ipr   OUT      tyt_payable_entity_id_ipr,
      vo_contract_id_ipr         OUT      tyt_contract_id_ipr,
      vo_contract_versao_ipr     OUT      tyt_contract_versao_ipr,
      vo_seq_item                OUT      tyt_seq_item,
      vo_project_ind_automatico  OUT      tyt_project_ind_automatico,
      vo_project_entity_id       OUT      tyt_project_entity_id,
      vo_project_id              OUT      tyt_project_id,
      vo_component_id            OUT      tyt_component_id,
      vo_cost_element_id         OUT      tyt_cost_element_id,
      vo_manager_id              OUT      tyt_manager_id,
      vo_security_code           OUT      tyt_security_code,
      vo_sistema_origem_code_ipr OUT      tyt_sistema_origem_code_ipr,
      vo_contract_versao_origem_ipr OUT   tyt_contract_versao_origem_ipr,
      vo_date_created_ipr        OUT      tyt_date_created_ipr,
      vo_user_id_created_ipr     OUT      tyt_user_id_created_ipr,
      vo_date_changed_ipr        OUT      tyt_date_changed_ipr,
      vo_user_id_changed_ipr     OUT      tyt_user_id_changed_ipr,
      vo_inactive_ind_ipr        OUT      tyt_inactive_ind_ipr,
      vo_active_date_ipr         OUT      tyt_active_date_ipr,
      vi_payable_entity_id_ipr   IN       t_payable_entity_id_ipr,
      vi_contract_id_ipr         IN       t_contract_id_ipr,
      vi_contract_versao_ipr     IN       t_contract_versao_ipr,
      vi_seq_item                IN       t_seq_item,
      vi_project_ind_automatico  IN       t_project_ind_automatico,
      vi_project_entity_id       IN       t_project_entity_id,
      vi_project_id              IN       t_project_id,
      vi_component_id            IN       t_component_id,
      vi_cost_element_id         IN       t_cost_element_id,
      vi_manager_id              IN       t_manager_id,
      vi_security_code           IN       t_security_code,
      vi_user_id_created_ipr     IN       t_user_id_created_ipr
   ) AS
      v_payable_entity_id_ipr       viw_conf_item_projeto_u.payable_entity_id_ipr%TYPE;
      v_contract_id_ipr             viw_conf_item_projeto_u.contract_id_ipr%TYPE;
      v_contract_versao_ipr         viw_conf_item_projeto_u.contract_versao_ipr%TYPE;
      v_seq_item                    viw_conf_item_projeto_u.seq_item%TYPE;
      v_project_ind_automatico      viw_conf_item_projeto_u.project_ind_automatico%TYPE;
      v_project_entity_id           viw_conf_item_projeto_u.project_entity_id%TYPE;
      v_project_id                  viw_conf_item_projeto_u.project_id%TYPE;
      v_component_id                viw_conf_item_projeto_u.component_id%TYPE;
      v_cost_element_id             viw_conf_item_projeto_u.cost_element_id%TYPE;
      v_manager_id                  viw_conf_item_projeto_u.manager_id%TYPE;
      v_security_code               viw_conf_item_projeto_u.security_code%TYPE;
      v_user_id_created_ipr         viw_conf_item_projeto_u.user_id_created_ipr%TYPE;
      v_dado                        VARCHAR2 (4000) := NULL;
   BEGIN
      IF ifrseg.pck_seguranca.stf_permitido (p_usuario,
                                             'VIW_CONF_ITEM_PROJETO_U',
                                             'INCLUI'
                                            ) THEN
         v_payable_entity_id_ipr := RTRIM (LTRIM (vi_payable_entity_id_ipr));
         v_contract_id_ipr := RTRIM (LTRIM (vi_contract_id_ipr));
         v_contract_versao_ipr := RTRIM (LTRIM (vi_contract_versao_ipr));
         v_seq_item := RTRIM (LTRIM (vi_seq_item));
         v_project_ind_automatico :=
                                    RTRIM (LTRIM (vi_project_ind_automatico));
         v_project_entity_id := RTRIM (LTRIM (vi_project_entity_id));
         v_project_id := RTRIM (LTRIM (vi_project_id));
         v_component_id := RTRIM (LTRIM (vi_component_id));
         v_cost_element_id := RTRIM (LTRIM (vi_cost_element_id));
         v_manager_id := RTRIM (LTRIM (vi_manager_id));
         v_security_code := RTRIM (LTRIM (vi_security_code));
         v_user_id_created_ipr := RTRIM (LTRIM (vi_user_id_created_ipr));

         INSERT INTO ifrbde.viw_conf_item_projeto_u
                     (payable_entity_id_ipr,
                      contract_id_ipr,
                      contract_versao_ipr,
                      seq_item,
                      project_ind_automatico,
                      project_entity_id,
                      project_id,
                      component_id,
                      cost_element_id,
                      manager_id,
                      security_code,
                      user_id_created_ipr
                     )
              VALUES (v_payable_entity_id_ipr,
                      v_contract_id_ipr,
                      v_contract_versao_ipr,
                      v_seq_item,
                      v_project_ind_automatico,
                      v_project_entity_id,
                      v_project_id,
                      v_component_id,
                      v_cost_element_id,
                      v_manager_id,
                      v_security_code,
                      v_user_id_created_ipr
                     );

         IF SQL%ROWCOUNT = 1 THEN
            stp_pesquisa_conf_item_projeto (p_usuario,
                                            vo_payable_entity_id_ipr,
                                            vo_contract_id_ipr,
                                            vo_contract_versao_ipr,
                                            vo_seq_item,
                                            vo_project_ind_automatico,
                                            vo_project_entity_id,
                                            vo_project_id,
                                            vo_component_id,
                                            vo_cost_element_id,
                                            vo_manager_id,
                                            vo_security_code,
                                            vo_sistema_origem_code_ipr,
                                            vo_contract_versao_origem_ipr,
                                            vo_date_created_ipr,
                                            vo_user_id_created_ipr,
                                            vo_date_changed_ipr,
                                            vo_user_id_changed_ipr,
                                            vo_inactive_ind_ipr,
                                            vo_active_date_ipr,
                                            v_payable_entity_id_ipr,
                                            v_contract_id_ipr,
                                            v_contract_versao_ipr
                                           );
            v_dado :=
               'payable_entity_id_ipr = '
               || RTRIM (LTRIM (v_payable_entity_id_ipr));
            v_dado :=
               v_dado
               || ','
               || 'contract_id_ipr = '
               || RTRIM (LTRIM (v_contract_id_ipr));
            v_dado :=
               v_dado
               || ','
               || 'contract_versao_ipr = '
               || RTRIM (LTRIM (v_contract_versao_ipr));
            v_dado :=
                  v_dado || ',' || 'seq_item = ' || RTRIM (LTRIM (v_seq_item));
            v_dado :=
               v_dado
               || ','
               || 'project_ind_automatico = '
               || RTRIM (LTRIM (v_project_ind_automatico));
            v_dado :=
               v_dado
               || ','
               || 'project_entity_id = '
               || RTRIM (LTRIM (v_project_entity_id));
            v_dado :=
               v_dado || ',' || 'project_id = '
               || RTRIM (LTRIM (v_project_id));
            v_dado :=
               v_dado
               || ','
               || 'component_id = '
               || RTRIM (LTRIM (v_component_id));
            v_dado :=
               v_dado
               || ','
               || 'cost_element_id = '
               || RTRIM (LTRIM (v_cost_element_id));
            v_dado :=
               v_dado || ',' || 'manager_id = '
               || RTRIM (LTRIM (v_manager_id));
            v_dado :=
               v_dado
               || ','
               || 'security_code = '
               || RTRIM (LTRIM (v_security_code));
            v_dado :=
               v_dado
               || ','
               || 'user_id_created_ipr = '
               || RTRIM (LTRIM (v_user_id_created_ipr));
            -- LOG
            ifrseg.pck_seguranca.stp_log (p_usuario,
                                          'VIW_CONF_ITEM_PROJETO_U',
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
-- Altera Contrato Item - Projeto
-- retorna o recordset correspondente
   PROCEDURE stp_altera_conf_item_projeto_u (
      p_usuario                  IN       VARCHAR2,
      vo_payable_entity_id_ipr   OUT      tyt_payable_entity_id_ipr,
      vo_contract_id_ipr         OUT      tyt_contract_id_ipr,
      vo_contract_versao_ipr     OUT      tyt_contract_versao_ipr,
      vo_seq_item                OUT      tyt_seq_item,
      vo_project_ind_automatico  OUT      tyt_project_ind_automatico,
      vo_project_entity_id       OUT      tyt_project_entity_id,
      vo_project_id              OUT      tyt_project_id,
      vo_component_id            OUT      tyt_component_id,
      vo_cost_element_id         OUT      tyt_cost_element_id,
      vo_manager_id              OUT      tyt_manager_id,
      vo_security_code           OUT      tyt_security_code,
      vo_sistema_origem_code_ipr OUT      tyt_sistema_origem_code_ipr,
      vo_contract_versao_origem_ipr OUT   tyt_contract_versao_origem_ipr,
      vo_date_created_ipr        OUT      tyt_date_created_ipr,
      vo_user_id_created_ipr     OUT      tyt_user_id_created_ipr,
      vo_date_changed_ipr        OUT      tyt_date_changed_ipr,
      vo_user_id_changed_ipr     OUT      tyt_user_id_changed_ipr,
      vo_inactive_ind_ipr        OUT      tyt_inactive_ind_ipr,
      vo_active_date_ipr         OUT      tyt_active_date_ipr,
      vi_payable_entity_id_ipr   IN       t_payable_entity_id_ipr,
      vi_contract_id_ipr         IN       t_contract_id_ipr,
      vi_contract_versao_ipr     IN       t_contract_versao_ipr,
      vi_seq_item                IN       t_seq_item,
      vi_project_ind_automatico  IN       t_project_ind_automatico,
      vi_project_entity_id       IN       t_project_entity_id,
      vi_project_id              IN       t_project_id,
      vi_component_id            IN       t_component_id,
      vi_cost_element_id         IN       t_cost_element_id,
      vi_manager_id              IN       t_manager_id,
      vi_security_code           IN       t_security_code,
      vi_user_id_created_ipr     IN       t_user_id_created_ipr
   ) AS
      CURSOR c_cursor IS
         SELECT     *
               FROM ifrbde.viw_conf_item_projeto_u
              WHERE payable_entity_id_ipr = vi_payable_entity_id_ipr
                AND contract_id_ipr = vi_contract_id_ipr
                AND contract_versao_ipr = vi_contract_versao_ipr
         FOR UPDATE;

      v_viw_conf_item_projeto_u     ifrbde.viw_conf_item_projeto_u%ROWTYPE;
      v_payable_entity_id_ipr       ifrbde.viw_conf_item_projeto_u.payable_entity_id_ipr%TYPE;
      v_contract_id_ipr             ifrbde.viw_conf_item_projeto_u.contract_id_ipr%TYPE;
      v_contract_versao_ipr         ifrbde.viw_conf_item_projeto_u.contract_versao_ipr%TYPE;
      v_seq_item                    ifrbde.viw_conf_item_projeto_u.seq_item%TYPE;
      v_project_ind_automatico      ifrbde.viw_conf_item_projeto_u.project_ind_automatico%TYPE;
      v_project_entity_id           ifrbde.viw_conf_item_projeto_u.project_entity_id%TYPE;
      v_project_id                  ifrbde.viw_conf_item_projeto_u.project_id%TYPE;
      v_component_id                ifrbde.viw_conf_item_projeto_u.component_id%TYPE;
      v_cost_element_id             ifrbde.viw_conf_item_projeto_u.cost_element_id%TYPE;
      v_manager_id                  ifrbde.viw_conf_item_projeto_u.manager_id%TYPE;
      v_security_code               ifrbde.viw_conf_item_projeto_u.security_code%TYPE;
      v_user_id_created_ipr         ifrbde.viw_conf_item_projeto_u.user_id_created_ipr%TYPE;
      v_dado                        VARCHAR2 (4000) := NULL;
   BEGIN
      IF ifrseg.pck_seguranca.stf_permitido (p_usuario,
                                             'VIW_CONF_ITEM_PROJETO_U',
                                             'ALTERA'
                                            ) THEN
         OPEN c_cursor;

         FETCH c_cursor
          INTO v_viw_conf_item_projeto_u;

         IF NOT c_cursor%NOTFOUND THEN
            v_payable_entity_id_ipr :=
                                     RTRIM (LTRIM (vi_payable_entity_id_ipr));
            v_contract_id_ipr := RTRIM (LTRIM (vi_contract_id_ipr));
            v_contract_versao_ipr := RTRIM (LTRIM (vi_contract_versao_ipr));
            v_seq_item := RTRIM (LTRIM (vi_seq_item));
            v_project_ind_automatico :=
                                    RTRIM (LTRIM (vi_project_ind_automatico));
            v_project_entity_id := RTRIM (LTRIM (vi_project_entity_id));
            v_project_id := RTRIM (LTRIM (vi_project_id));
            v_component_id := RTRIM (LTRIM (vi_component_id));
            v_cost_element_id := RTRIM (LTRIM (vi_cost_element_id));
            v_manager_id := RTRIM (LTRIM (vi_manager_id));
            v_security_code := RTRIM (LTRIM (vi_security_code));
            v_user_id_created_ipr := RTRIM (LTRIM (vi_user_id_created_ipr));

            UPDATE ifrbde.viw_conf_item_projeto_u
               SET seq_item = v_seq_item,
                   project_ind_automatico = v_project_ind_automatico,
                   project_entity_id = v_project_entity_id,
                   project_id = v_project_id,
                   component_id = v_component_id,
                   cost_element_id = v_cost_element_id,
                   manager_id = v_manager_id,
                   security_code = v_security_code,
                   user_id_created_ipr = v_user_id_created_ipr
             WHERE CURRENT OF c_cursor;

            IF SQL%ROWCOUNT = 1 THEN
               stp_pesquisa_conf_item_projeto (p_usuario,
                                               vo_payable_entity_id_ipr,
                                               vo_contract_id_ipr,
                                               vo_contract_versao_ipr,
                                               vo_seq_item,
                                               vo_project_ind_automatico,
                                               vo_project_entity_id,
                                               vo_project_id,
                                               vo_component_id,
                                               vo_cost_element_id,
                                               vo_manager_id,
                                               vo_security_code,
                                               vo_sistema_origem_code_ipr,
                                               vo_contract_versao_origem_ipr,
                                               vo_date_created_ipr,
                                               vo_user_id_created_ipr,
                                               vo_date_changed_ipr,
                                               vo_user_id_changed_ipr,
                                               vo_inactive_ind_ipr,
                                               vo_active_date_ipr,
                                               vi_payable_entity_id_ipr,
                                               vi_contract_id_ipr,
                                               vi_contract_versao_ipr
                                              );
               v_dado :=
                  'payable_entity_id_ipr = '
                  || RTRIM (LTRIM (v_payable_entity_id_ipr));
               v_dado :=
                  v_dado
                  || ','
                  || 'contract_id_ipr = '
                  || RTRIM (LTRIM (v_contract_id_ipr));
               v_dado :=
                  v_dado
                  || ','
                  || 'contract_versao_ipr = '
                  || RTRIM (LTRIM (v_contract_versao_ipr));
               v_dado :=
                  v_dado || ',' || 'seq_item = ' || RTRIM (LTRIM (v_seq_item));
               v_dado :=
                  v_dado
                  || ','
                  || 'project_ind_automatico = '
                  || RTRIM (LTRIM (v_project_ind_automatico));
               v_dado :=
                  v_dado
                  || ','
                  || 'project_entity_id = '
                  || RTRIM (LTRIM (v_project_entity_id));
               v_dado :=
                  v_dado
                  || ','
                  || 'project_id = '
                  || RTRIM (LTRIM (v_project_id));
               v_dado :=
                  v_dado
                  || ','
                  || 'component_id = '
                  || RTRIM (LTRIM (v_component_id));
               v_dado :=
                  v_dado
                  || ','
                  || 'cost_element_id = '
                  || RTRIM (LTRIM (v_cost_element_id));
               v_dado :=
                  v_dado
                  || ','
                  || 'manager_id = '
                  || RTRIM (LTRIM (v_manager_id));
               v_dado :=
                  v_dado
                  || ','
                  || 'security_code = '
                  || RTRIM (LTRIM (v_security_code));
               v_dado :=
                  v_dado
                  || ','
                  || 'user_id_created_ipr = '
                  || RTRIM (LTRIM (v_user_id_created_ipr));
               -- LOG
               ifrseg.pck_seguranca.stp_log (p_usuario,
                                             'VIW_CONF_ITEM_PROJETO_U',
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
-- Pesquisa Contrato Item - Clas. Contábil
-- retorna o recordset correspondente
   PROCEDURE stp_pesquisa_conf_item_acct_di (
      p_usuario                  IN       VARCHAR2,
      vo_payable_entity_id_icc   OUT      tyt_payable_entity_id_icc,
      vo_contract_id_icc         OUT      tyt_contract_id_icc,
      vo_contract_versao_icc     OUT      tyt_contract_versao_icc,
      vo_seq_item                OUT      tyt_seq_item,
      vo_type_account_dist       OUT      tyt_type_account_dist,
      vo_ldr_entity_id           OUT      tyt_ldr_entity_id,
      vo_dependencia             OUT      tyt_dependencia,
      vo_conta                   OUT      tyt_conta,
      vo_programa                OUT      tyt_programa,
      vo_projeto                 OUT      tyt_projeto,
      vo_custo                   OUT      tyt_custo,
      vo_int_tipo_distr          OUT      tyt_int_tipo_distr,
      vo_per_valor_distr         OUT      tyt_per_valor_distr,
      vo_sistema_origem_code_icc OUT      tyt_sistema_origem_code_icc,
      vo_contract_versao_origem_icc OUT   tyt_contract_versao_origem_icc,
      vo_date_created_icc        OUT      tyt_date_created_icc,
      vo_user_id_created_icc     OUT      tyt_user_id_created_icc,
      vo_date_changed_icc        OUT      tyt_date_changed_icc,
      vo_user_id_changed_icc     OUT      tyt_user_id_changed_icc,
      vo_inactive_ind_icc        OUT      tyt_inactive_ind_icc,
      vo_active_date_icc         OUT      tyt_active_date_icc,
      vi_payable_entity_id_icc   IN       t_payable_entity_id_icc,
      vi_contract_id_icc         IN       t_contract_id_icc,
      vi_contract_versao_icc     IN       t_contract_versao_icc,
      vi_dependencia             IN       t_dependencia,
      vi_conta                   IN       t_conta
   ) AS
   BEGIN
      IF ifrseg.pck_seguranca.stf_permitido (p_usuario,
                                             'VIW_CONF_ITEM_ACCT_DISTIN_U',
                                             'PESQUISA'
                                            ) THEN
         SELECT payable_entity_id_icc,
                contract_id_icc,
                contract_versao_icc,
                seq_item,
                type_account_dist,
                ldr_entity_id,
                dependencia,
                conta,
                programa,
                projeto,
                custo,
                int_tipo_distr,
                per_valor_distr,
                sistema_origem_code_icc,
                contract_versao_origem_icc,
                date_created_icc,
                user_id_created_icc,
                date_changed_icc,
                user_id_changed_icc,
                inactive_ind_icc,
                active_date_icc
           INTO vo_payable_entity_id_icc (1),
                vo_contract_id_icc (1),
                vo_contract_versao_icc (1),
                vo_seq_item (1),
                vo_type_account_dist (1),
                vo_ldr_entity_id (1),
                vo_dependencia (1),
                vo_conta (1),
                vo_programa (1),
                vo_projeto (1),
                vo_custo (1),
                vo_int_tipo_distr (1),
                vo_per_valor_distr (1),
                vo_sistema_origem_code_icc (1),
                vo_contract_versao_origem_icc (1),
                vo_date_created_icc (1),
                vo_user_id_created_icc (1),
                vo_date_changed_icc (1),
                vo_user_id_changed_icc (1),
                vo_inactive_ind_icc (1),
                vo_active_date_icc (1)
           FROM ifrbde.viw_conf_item_acct_distin_u
          WHERE payable_entity_id_icc = vi_payable_entity_id_icc
            AND contract_id_icc = vi_contract_id_icc
            AND contract_versao_icc = vi_contract_versao_icc
            AND dependencia = vi_dependencia
            AND conta = vi_conta;
      END IF;
   EXCEPTION
      WHEN OTHERS THEN
         raise_application_error (-20100, SQLERRM);
   END;

   -- Exclui Contrato Item - Clas. Contábil
   -- retorna o OK ou não
   PROCEDURE stp_exclui_conf_item_acct_dist (
      p_usuario                  IN       VARCHAR2,
      vo_ok                      OUT      tyt_ok,
      vi_payable_entity_id_icc   IN       t_payable_entity_id_icc,
      vi_contract_id_icc         IN       t_contract_id_icc,
      vi_contract_versao_icc     IN       t_contract_versao_icc,
      vi_dependencia             IN       t_dependencia,
      vi_conta                   IN       t_conta
   ) AS
      CURSOR c_cursor IS
         SELECT     *
               FROM ifrbde.viw_conf_item_acct_distin_u
              WHERE payable_entity_id_icc = vi_payable_entity_id_icc
                AND contract_id_icc = vi_contract_id_icc
                AND contract_versao_icc = vi_contract_versao_icc
                AND dependencia = vi_dependencia
                AND conta = vi_conta
         FOR UPDATE;

      v_viw_conf_item_acct_distin_u ifrbde.viw_conf_item_acct_distin_u%ROWTYPE;
      v_dado                        VARCHAR2 (4000) := NULL;
   BEGIN
      vo_ok (1) := 0;

      IF ifrseg.pck_seguranca.stf_permitido (p_usuario,
                                             'VIW_CONF_ITEM_ACCT_DISTIN_U',
                                             'EXCLUI'
                                            ) THEN
         OPEN c_cursor;

         FETCH c_cursor
          INTO v_viw_conf_item_acct_distin_u;

         IF NOT c_cursor%NOTFOUND THEN
            v_dado :=
               'payable_entity_id_icc = '
               || RTRIM
                    (LTRIM
                        (UPPER
                            (v_viw_conf_item_acct_distin_u.payable_entity_id_icc
                            )
                        )
                    );
            v_dado :=
               v_dado
               || ','
               || 'contract_id_icc = '
               || RTRIM
                    (LTRIM
                         (UPPER (v_viw_conf_item_acct_distin_u.contract_id_icc)
                         )
                    );
            v_dado :=
               v_dado
               || ','
               || 'contract_versao_icc = '
               || RTRIM
                    (LTRIM
                        (UPPER
                            (v_viw_conf_item_acct_distin_u.contract_versao_icc)
                        )
                    );
            v_dado :=
               v_dado
               || ','
               || 'seq_item = '
               || RTRIM (LTRIM (UPPER (v_viw_conf_item_acct_distin_u.seq_item))
                        );
            v_dado :=
               v_dado
               || ','
               || 'type_account_dist = '
               || RTRIM
                    (LTRIM
                        (UPPER
                              (v_viw_conf_item_acct_distin_u.type_account_dist)
                        )
                    );
            v_dado :=
               v_dado
               || ','
               || 'ldr_entity_id = '
               || RTRIM
                    (LTRIM (UPPER (v_viw_conf_item_acct_distin_u.ldr_entity_id)
                           )
                    );
            v_dado :=
               v_dado
               || ','
               || 'dependencia = '
               || RTRIM
                      (LTRIM (UPPER (v_viw_conf_item_acct_distin_u.dependencia)
                             )
                      );
            v_dado :=
               v_dado
               || ','
               || 'conta = '
               || RTRIM (LTRIM (UPPER (v_viw_conf_item_acct_distin_u.conta)));
            v_dado :=
               v_dado
               || ','
               || 'programa = '
               || RTRIM (LTRIM (UPPER (v_viw_conf_item_acct_distin_u.programa))
                        );
            v_dado :=
               v_dado
               || ','
               || 'projeto = '
               || RTRIM (LTRIM (UPPER (v_viw_conf_item_acct_distin_u.projeto)));
            v_dado :=
               v_dado
               || ','
               || 'custo = '
               || RTRIM (LTRIM (UPPER (v_viw_conf_item_acct_distin_u.custo)));
            v_dado :=
               v_dado
               || ','
               || 'int_tipo_distr = '
               || RTRIM
                    (LTRIM
                          (UPPER (v_viw_conf_item_acct_distin_u.int_tipo_distr)
                          )
                    );
            v_dado :=
               v_dado
               || ','
               || 'per_valor_distr = '
               || TO_CHAR (v_viw_conf_item_acct_distin_u.per_valor_distr);
            v_dado :=
               v_dado
               || ','
               || 'sistema_origem_code_icc = '
               || RTRIM
                    (LTRIM
                        (UPPER
                            (v_viw_conf_item_acct_distin_u.sistema_origem_code_icc
                            )
                        )
                    );
            v_dado :=
               v_dado
               || ','
               || 'contract_versao_origem_icc = '
               || RTRIM
                    (LTRIM
                        (UPPER
                            (v_viw_conf_item_acct_distin_u.contract_versao_origem_icc
                            )
                        )
                    );
            v_dado :=
               v_dado
               || ','
               || 'date_created_icc = '
               || TO_DATE (v_viw_conf_item_acct_distin_u.date_created_icc,
                           'DD/MM/YYYY'
                          );
            v_dado :=
               v_dado
               || ','
               || 'user_id_created_icc = '
               || RTRIM
                    (LTRIM
                        (UPPER
                            (v_viw_conf_item_acct_distin_u.user_id_created_icc)
                        )
                    );
            v_dado :=
               v_dado
               || ','
               || 'date_changed_icc = '
               || TO_DATE (v_viw_conf_item_acct_distin_u.date_changed_icc,
                           'DD/MM/YYYY'
                          );
            v_dado :=
               v_dado
               || ','
               || 'user_id_changed_icc = '
               || RTRIM
                    (LTRIM
                        (UPPER
                            (v_viw_conf_item_acct_distin_u.user_id_changed_icc)
                        )
                    );
            v_dado :=
               v_dado
               || ','
               || 'inactive_ind_icc = '
               || RTRIM
                    (LTRIM
                        (UPPER (v_viw_conf_item_acct_distin_u.inactive_ind_icc)
                        )
                    );
            v_dado :=
               v_dado
               || ','
               || 'active_date_icc = '
               || TO_DATE (v_viw_conf_item_acct_distin_u.active_date_icc,
                           'DD/MM/YYYY'
                          );

            IF c_cursor%ROWCOUNT = 1 THEN
               vo_ok (1) := 1;
               -- LOG
               ifrseg.pck_seguranca.stp_log (p_usuario,
                                             'VIW_CONF_ITEM_ACCT_DISTIN_U',
                                             'E',
                                             v_dado
                                            );

               DELETE FROM ifrbde.viw_conf_item_acct_distin_u
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
-- Inclui Contrato Item - Clas. Contábil
-- retorna o recordset correspondente
   PROCEDURE stp_inclui_conf_item_acct_dist (
      p_usuario                  IN       VARCHAR2,
      vo_payable_entity_id_icc   OUT      tyt_payable_entity_id_icc,
      vo_contract_id_icc         OUT      tyt_contract_id_icc,
      vo_contract_versao_icc     OUT      tyt_contract_versao_icc,
      vo_seq_item                OUT      tyt_seq_item,
      vo_type_account_dist       OUT      tyt_type_account_dist,
      vo_ldr_entity_id           OUT      tyt_ldr_entity_id,
      vo_dependencia             OUT      tyt_dependencia,
      vo_conta                   OUT      tyt_conta,
      vo_programa                OUT      tyt_programa,
      vo_projeto                 OUT      tyt_projeto,
      vo_custo                   OUT      tyt_custo,
      vo_int_tipo_distr          OUT      tyt_int_tipo_distr,
      vo_per_valor_distr         OUT      tyt_per_valor_distr,
      vo_sistema_origem_code_icc OUT      tyt_sistema_origem_code_icc,
      vo_contract_versao_origem_icc OUT   tyt_contract_versao_origem_icc,
      vo_date_created_icc        OUT      tyt_date_created_icc,
      vo_user_id_created_icc     OUT      tyt_user_id_created_icc,
      vo_date_changed_icc        OUT      tyt_date_changed_icc,
      vo_user_id_changed_icc     OUT      tyt_user_id_changed_icc,
      vo_inactive_ind_icc        OUT      tyt_inactive_ind_icc,
      vo_active_date_icc         OUT      tyt_active_date_icc,
      vi_payable_entity_id_icc   IN       t_payable_entity_id_icc,
      vi_contract_id_icc         IN       t_contract_id_icc,
      vi_contract_versao_icc     IN       t_contract_versao_icc,
      vi_seq_item                IN       t_seq_item,
      vi_type_account_dist       IN       t_type_account_dist,
      vi_ldr_entity_id           IN       t_ldr_entity_id,
      vi_dependencia             IN       t_dependencia,
      vi_conta                   IN       t_conta,
      vi_programa                IN       t_programa,
      vi_projeto                 IN       t_projeto,
      vi_custo                   IN       t_custo,
      vi_int_tipo_distr          IN       t_int_tipo_distr,
      vi_per_valor_distr         IN       t_per_valor_distr,
      vi_user_id_created_icc     IN       t_user_id_created_icc
   ) AS
      v_payable_entity_id_icc       viw_conf_item_acct_distin_u.payable_entity_id_icc%TYPE;
      v_contract_id_icc             viw_conf_item_acct_distin_u.contract_id_icc%TYPE;
      v_contract_versao_icc         viw_conf_item_acct_distin_u.contract_versao_icc%TYPE;
      v_seq_item                    viw_conf_item_acct_distin_u.seq_item%TYPE;
      v_type_account_dist           viw_conf_item_acct_distin_u.type_account_dist%TYPE;
      v_ldr_entity_id               viw_conf_item_acct_distin_u.ldr_entity_id%TYPE;
      v_dependencia                 viw_conf_item_acct_distin_u.dependencia%TYPE;
      v_conta                       viw_conf_item_acct_distin_u.conta%TYPE;
      v_programa                    viw_conf_item_acct_distin_u.programa%TYPE;
      v_projeto                     viw_conf_item_acct_distin_u.projeto%TYPE;
      v_custo                       viw_conf_item_acct_distin_u.custo%TYPE;
      v_int_tipo_distr              viw_conf_item_acct_distin_u.int_tipo_distr%TYPE;
      v_per_valor_distr             viw_conf_item_acct_distin_u.per_valor_distr%TYPE;
      v_user_id_created_icc         viw_conf_item_acct_distin_u.user_id_created_icc%TYPE;
      v_dado                        VARCHAR2 (4000) := NULL;
   BEGIN
      IF ifrseg.pck_seguranca.stf_permitido (p_usuario,
                                             'VIW_CONF_ITEM_ACCT_DISTIN_U',
                                             'INCLUI'
                                            ) THEN
         v_payable_entity_id_icc := RTRIM (LTRIM (vi_payable_entity_id_icc));
         v_contract_id_icc := RTRIM (LTRIM (vi_contract_id_icc));
         v_contract_versao_icc := RTRIM (LTRIM (vi_contract_versao_icc));
         v_seq_item := RTRIM (LTRIM (vi_seq_item));
         v_type_account_dist := RTRIM (LTRIM (vi_type_account_dist));
         v_ldr_entity_id := RTRIM (LTRIM (vi_ldr_entity_id));
         v_dependencia := RTRIM (LTRIM (vi_dependencia));
         v_conta := RTRIM (LTRIM (vi_conta));
         v_programa := RTRIM (LTRIM (vi_programa));
         v_projeto := RTRIM (LTRIM (vi_projeto));
         v_custo := RTRIM (LTRIM (vi_custo));
         v_int_tipo_distr := RTRIM (LTRIM (vi_int_tipo_distr));
         v_user_id_created_icc := RTRIM (LTRIM (vi_user_id_created_icc));
         v_per_valor_distr := vi_per_valor_distr;

         INSERT INTO ifrbde.viw_conf_item_acct_distin_u
                     (payable_entity_id_icc,
                      contract_id_icc,
                      contract_versao_icc,
                      seq_item,
                      type_account_dist,
                      ldr_entity_id,
                      dependencia,
                      conta,
                      programa,
                      projeto,
                      custo,
                      int_tipo_distr,
                      per_valor_distr,
                      user_id_created_icc
                     )
              VALUES (v_payable_entity_id_icc,
                      v_contract_id_icc,
                      v_contract_versao_icc,
                      v_seq_item,
                      v_type_account_dist,
                      v_ldr_entity_id,
                      v_dependencia,
                      v_conta,
                      v_programa,
                      v_projeto,
                      v_custo,
                      v_int_tipo_distr,
                      v_per_valor_distr,
                      v_user_id_created_icc
                     );

         IF SQL%ROWCOUNT = 1 THEN
            stp_pesquisa_conf_item_acct_di (p_usuario,
                                            vo_payable_entity_id_icc,
                                            vo_contract_id_icc,
                                            vo_contract_versao_icc,
                                            vo_seq_item,
                                            vo_type_account_dist,
                                            vo_ldr_entity_id,
                                            vo_dependencia,
                                            vo_conta,
                                            vo_programa,
                                            vo_projeto,
                                            vo_custo,
                                            vo_int_tipo_distr,
                                            vo_per_valor_distr,
                                            vo_sistema_origem_code_icc,
                                            vo_contract_versao_origem_icc,
                                            vo_date_created_icc,
                                            vo_user_id_created_icc,
                                            vo_date_changed_icc,
                                            vo_user_id_changed_icc,
                                            vo_inactive_ind_icc,
                                            vo_active_date_icc,
                                            v_payable_entity_id_icc,
                                            v_contract_id_icc,
                                            v_contract_versao_icc,
                                            v_dependencia,
                                            v_conta
                                           );
            v_dado :=
               'payable_entity_id_icc = '
               || RTRIM (LTRIM (v_payable_entity_id_icc));
            v_dado :=
               v_dado
               || ','
               || 'contract_id_icc = '
               || RTRIM (LTRIM (v_contract_id_icc));
            v_dado :=
               v_dado
               || ','
               || 'contract_versao_icc = '
               || RTRIM (LTRIM (v_contract_versao_icc));
            v_dado :=
                  v_dado || ',' || 'seq_item = ' || RTRIM (LTRIM (v_seq_item));
            v_dado :=
               v_dado
               || ','
               || 'type_account_dist = '
               || RTRIM (LTRIM (v_type_account_dist));
            v_dado :=
               v_dado
               || ','
               || 'ldr_entity_id = '
               || RTRIM (LTRIM (v_ldr_entity_id));
            v_dado :=
               v_dado || ',' || 'dependencia = '
               || RTRIM (LTRIM (v_dependencia));
            v_dado := v_dado || ',' || 'conta = ' || RTRIM (LTRIM (v_conta));
            v_dado :=
                  v_dado || ',' || 'programa = ' || RTRIM (LTRIM (v_programa));
            v_dado :=
                    v_dado || ',' || 'projeto = ' || RTRIM (LTRIM (v_projeto));
            v_dado := v_dado || ',' || 'custo = ' || RTRIM (LTRIM (v_custo));
            v_dado :=
               v_dado
               || ','
               || 'int_tipo_distr = '
               || RTRIM (LTRIM (v_int_tipo_distr));
            v_dado :=
               v_dado
               || ','
               || 'per_valor_distr = '
               || TO_CHAR (v_per_valor_distr);
            v_dado :=
               v_dado
               || ','
               || 'user_id_created_icc = '
               || RTRIM (LTRIM (v_user_id_created_icc));
            -- LOG
            ifrseg.pck_seguranca.stp_log (p_usuario,
                                          'VIW_CONF_ITEM_ACCT_DISTIN_U',
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
-- Altera Contrato Item - Clas. Contábil
-- retorna o recordset correspondente
   PROCEDURE stp_altera_conf_item_acct_dist (
      p_usuario                  IN       VARCHAR2,
      vo_payable_entity_id_icc   OUT      tyt_payable_entity_id_icc,
      vo_contract_id_icc         OUT      tyt_contract_id_icc,
      vo_contract_versao_icc     OUT      tyt_contract_versao_icc,
      vo_seq_item                OUT      tyt_seq_item,
      vo_type_account_dist       OUT      tyt_type_account_dist,
      vo_ldr_entity_id           OUT      tyt_ldr_entity_id,
      vo_dependencia             OUT      tyt_dependencia,
      vo_conta                   OUT      tyt_conta,
      vo_programa                OUT      tyt_programa,
      vo_projeto                 OUT      tyt_projeto,
      vo_custo                   OUT      tyt_custo,
      vo_int_tipo_distr          OUT      tyt_int_tipo_distr,
      vo_per_valor_distr         OUT      tyt_per_valor_distr,
      vo_sistema_origem_code_icc OUT      tyt_sistema_origem_code_icc,
      vo_contract_versao_origem_icc OUT   tyt_contract_versao_origem_icc,
      vo_date_created_icc        OUT      tyt_date_created_icc,
      vo_user_id_created_icc     OUT      tyt_user_id_created_icc,
      vo_date_changed_icc        OUT      tyt_date_changed_icc,
      vo_user_id_changed_icc     OUT      tyt_user_id_changed_icc,
      vo_inactive_ind_icc        OUT      tyt_inactive_ind_icc,
      vo_active_date_icc         OUT      tyt_active_date_icc,
      vi_payable_entity_id_icc   IN       t_payable_entity_id_icc,
      vi_contract_id_icc         IN       t_contract_id_icc,
      vi_contract_versao_icc     IN       t_contract_versao_icc,
      vi_seq_item                IN       t_seq_item,
      vi_type_account_dist       IN       t_type_account_dist,
      vi_ldr_entity_id           IN       t_ldr_entity_id,
      vi_dependencia             IN       t_dependencia,
      vi_conta                   IN       t_conta,
      vi_programa                IN       t_programa,
      vi_projeto                 IN       t_projeto,
      vi_custo                   IN       t_custo,
      vi_int_tipo_distr          IN       t_int_tipo_distr,
      vi_per_valor_distr         IN       t_per_valor_distr,
      vi_user_id_created_icc     IN       t_user_id_created_icc
   ) AS
      CURSOR c_cursor IS
         SELECT     *
               FROM ifrbde.viw_conf_item_acct_distin_u
              WHERE payable_entity_id_icc = vi_payable_entity_id_icc
                AND contract_id_icc = vi_contract_id_icc
                AND contract_versao_icc = vi_contract_versao_icc
                AND dependencia = vi_dependencia
                AND conta = vi_conta
         FOR UPDATE;

      v_viw_conf_item_acct_distin_u ifrbde.viw_conf_item_acct_distin_u%ROWTYPE;
      v_payable_entity_id_icc       ifrbde.viw_conf_item_acct_distin_u.payable_entity_id_icc%TYPE;
      v_contract_id_icc             ifrbde.viw_conf_item_acct_distin_u.contract_id_icc%TYPE;
      v_contract_versao_icc         ifrbde.viw_conf_item_acct_distin_u.contract_versao_icc%TYPE;
      v_seq_item                    ifrbde.viw_conf_item_acct_distin_u.seq_item%TYPE;
      v_type_account_dist           ifrbde.viw_conf_item_acct_distin_u.type_account_dist%TYPE;
      v_ldr_entity_id               ifrbde.viw_conf_item_acct_distin_u.ldr_entity_id%TYPE;
      v_dependencia                 ifrbde.viw_conf_item_acct_distin_u.dependencia%TYPE;
      v_conta                       ifrbde.viw_conf_item_acct_distin_u.conta%TYPE;
      v_programa                    ifrbde.viw_conf_item_acct_distin_u.programa%TYPE;
      v_projeto                     ifrbde.viw_conf_item_acct_distin_u.projeto%TYPE;
      v_custo                       ifrbde.viw_conf_item_acct_distin_u.custo%TYPE;
      v_int_tipo_distr              ifrbde.viw_conf_item_acct_distin_u.int_tipo_distr%TYPE;
      v_per_valor_distr             ifrbde.viw_conf_item_acct_distin_u.per_valor_distr%TYPE;
      v_user_id_created_icc         ifrbde.viw_conf_item_acct_distin_u.user_id_created_icc%TYPE;
      v_dado                        VARCHAR2 (4000) := NULL;
   BEGIN
      IF ifrseg.pck_seguranca.stf_permitido (p_usuario,
                                             'VIW_CONF_ITEM_ACCT_DISTIN_U',
                                             'ALTERA'
                                            ) THEN
         OPEN c_cursor;

         FETCH c_cursor
          INTO v_viw_conf_item_acct_distin_u;

         IF NOT c_cursor%NOTFOUND THEN
            v_payable_entity_id_icc :=
                                     RTRIM (LTRIM (vi_payable_entity_id_icc));
            v_contract_id_icc := RTRIM (LTRIM (vi_contract_id_icc));
            v_contract_versao_icc := RTRIM (LTRIM (vi_contract_versao_icc));
            v_seq_item := RTRIM (LTRIM (vi_seq_item));
            v_type_account_dist := RTRIM (LTRIM (vi_type_account_dist));
            v_ldr_entity_id := RTRIM (LTRIM (vi_ldr_entity_id));
            v_dependencia := RTRIM (LTRIM (vi_dependencia));
            v_conta := RTRIM (LTRIM (vi_conta));
            v_programa := RTRIM (LTRIM (vi_programa));
            v_projeto := RTRIM (LTRIM (vi_projeto));
            v_custo := RTRIM (LTRIM (vi_custo));
            v_int_tipo_distr := RTRIM (LTRIM (vi_int_tipo_distr));
            v_user_id_created_icc := RTRIM (LTRIM (vi_user_id_created_icc));
            v_per_valor_distr := vi_per_valor_distr;

            UPDATE ifrbde.viw_conf_item_acct_distin_u
               SET seq_item = v_seq_item,
                   type_account_dist = v_type_account_dist,
                   ldr_entity_id = v_ldr_entity_id,
                   programa = v_programa,
                   projeto = v_projeto,
                   custo = v_custo,
                   int_tipo_distr = v_int_tipo_distr,
                   per_valor_distr = v_per_valor_distr,
                   user_id_created_icc = v_user_id_created_icc
             WHERE CURRENT OF c_cursor;

            IF SQL%ROWCOUNT = 1 THEN
               stp_pesquisa_conf_item_acct_di (p_usuario,
                                               vo_payable_entity_id_icc,
                                               vo_contract_id_icc,
                                               vo_contract_versao_icc,
                                               vo_seq_item,
                                               vo_type_account_dist,
                                               vo_ldr_entity_id,
                                               vo_dependencia,
                                               vo_conta,
                                               vo_programa,
                                               vo_projeto,
                                               vo_custo,
                                               vo_int_tipo_distr,
                                               vo_per_valor_distr,
                                               vo_sistema_origem_code_icc,
                                               vo_contract_versao_origem_icc,
                                               vo_date_created_icc,
                                               vo_user_id_created_icc,
                                               vo_date_changed_icc,
                                               vo_user_id_changed_icc,
                                               vo_inactive_ind_icc,
                                               vo_active_date_icc,
                                               vi_payable_entity_id_icc,
                                               vi_contract_id_icc,
                                               vi_contract_versao_icc,
                                               vi_dependencia,
                                               vi_conta
                                              );
               v_dado :=
                  'payable_entity_id_icc = '
                  || RTRIM (LTRIM (v_payable_entity_id_icc));
               v_dado :=
                  v_dado
                  || ','
                  || 'contract_id_icc = '
                  || RTRIM (LTRIM (v_contract_id_icc));
               v_dado :=
                  v_dado
                  || ','
                  || 'contract_versao_icc = '
                  || RTRIM (LTRIM (v_contract_versao_icc));
               v_dado :=
                  v_dado || ',' || 'seq_item = ' || RTRIM (LTRIM (v_seq_item));
               v_dado :=
                  v_dado
                  || ','
                  || 'type_account_dist = '
                  || RTRIM (LTRIM (v_type_account_dist));
               v_dado :=
                  v_dado
                  || ','
                  || 'ldr_entity_id = '
                  || RTRIM (LTRIM (v_ldr_entity_id));
               v_dado :=
                  v_dado
                  || ','
                  || 'dependencia = '
                  || RTRIM (LTRIM (v_dependencia));
               v_dado :=
                        v_dado || ',' || 'conta = ' || RTRIM (LTRIM (v_conta));
               v_dado :=
                  v_dado || ',' || 'programa = ' || RTRIM (LTRIM (v_programa));
               v_dado :=
                    v_dado || ',' || 'projeto = ' || RTRIM (LTRIM (v_projeto));
               v_dado :=
                        v_dado || ',' || 'custo = ' || RTRIM (LTRIM (v_custo));
               v_dado :=
                  v_dado
                  || ','
                  || 'int_tipo_distr = '
                  || RTRIM (LTRIM (v_int_tipo_distr));
               v_dado :=
                  v_dado
                  || ','
                  || 'per_valor_distr = '
                  || TO_CHAR (v_per_valor_distr);
               v_dado :=
                  v_dado
                  || ','
                  || 'user_id_created_icc = '
                  || RTRIM (LTRIM (v_user_id_created_icc));
               -- LOG
               ifrseg.pck_seguranca.stp_log (p_usuario,
                                             'VIW_CONF_ITEM_ACCT_DISTIN_U',
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
-- Pesquisa Contrato Item - Resumo Valor
-- retorna o recordset correspondente
   PROCEDURE stp_pesquisa_conf_item_resumo_ (
      p_usuario                  IN       VARCHAR2,
      vo_payable_entity_id_ire   OUT      tyt_payable_entity_id_ire,
      vo_contract_id_ire         OUT      tyt_contract_id_ire,
      vo_contract_versao_ire     OUT      tyt_contract_versao_ire,
      vo_seq_item                OUT      tyt_seq_item,
      vo_codigo_resumo_valor     OUT      tyt_codigo_resumo_valor,
      vo_tipo_valor              OUT      tyt_tipo_valor,
      vo_curr_code               OUT      tyt_curr_code,
      vo_curr_code_secdy         OUT      tyt_curr_code_secdy,
      vo_ind_curr_code_controle  OUT      tyt_ind_curr_code_controle,
      vo_prim_amt                OUT      tyt_prim_amt,
      vo_secdy_amt               OUT      tyt_secdy_amt,
      vo_data_ultimo_reajuste    OUT      tyt_data_ultimo_reajuste,
      vo_data_prox_reajuste      OUT      tyt_data_prox_reajuste,
      vo_sistema_origem_code_ire OUT      tyt_sistema_origem_code_ire,
      vo_contract_versao_origem_ire OUT   tyt_contract_versao_origem_ire,
      vo_date_created_ire        OUT      tyt_date_created_ire,
      vo_user_id_created_ire     OUT      tyt_user_id_created_ire,
      vo_date_changed_ire        OUT      tyt_date_changed_ire,
      vo_user_id_changed_ire     OUT      tyt_user_id_changed_ire,
      vo_inactive_ind_ire        OUT      tyt_inactive_ind_ire,
      vo_active_date_ire         OUT      tyt_active_date_ire,
      vi_payable_entity_id_ire   IN       t_payable_entity_id_ire,
      vi_contract_id_ire         IN       t_contract_id_ire,
      vi_contract_versao_ire     IN       t_contract_versao_ire
   ) AS
   BEGIN
      IF ifrseg.pck_seguranca.stf_permitido (p_usuario,
                                             'VIW_CONF_ITEM_RESUMO_U',
                                             'PESQUISA'
                                            ) THEN
         SELECT payable_entity_id_ire,
                contract_id_ire,
                contract_versao_ire,
                seq_item,
                codigo_resumo_valor,
                tipo_valor,
                curr_code,
                curr_code_secdy,
                ind_curr_code_controle,
                prim_amt,
                secdy_amt,
                data_ultimo_reajuste,
                data_prox_reajuste,
                sistema_origem_code_ire,
                contract_versao_origem_ire,
                date_created_ire,
                user_id_created_ire,
                date_changed_ire,
                user_id_changed_ire,
                inactive_ind_ire,
                active_date_ire
           INTO vo_payable_entity_id_ire (1),
                vo_contract_id_ire (1),
                vo_contract_versao_ire (1),
                vo_seq_item (1),
                vo_codigo_resumo_valor (1),
                vo_tipo_valor (1),
                vo_curr_code (1),
                vo_curr_code_secdy (1),
                vo_ind_curr_code_controle (1),
                vo_prim_amt (1),
                vo_secdy_amt (1),
                vo_data_ultimo_reajuste (1),
                vo_data_prox_reajuste (1),
                vo_sistema_origem_code_ire (1),
                vo_contract_versao_origem_ire (1),
                vo_date_created_ire (1),
                vo_user_id_created_ire (1),
                vo_date_changed_ire (1),
                vo_user_id_changed_ire (1),
                vo_inactive_ind_ire (1),
                vo_active_date_ire (1)
           FROM ifrbde.viw_conf_item_resumo_u
          WHERE payable_entity_id_ire = vi_payable_entity_id_ire
            AND contract_id_ire = vi_contract_id_ire
            AND contract_versao_ire = vi_contract_versao_ire;
      END IF;
   EXCEPTION
      WHEN OTHERS THEN
         raise_application_error (-20100, SQLERRM);
   END;

   -- Exclui Contrato Item - Resumo Valor
   -- retorna o OK ou não
   PROCEDURE stp_exclui_conf_item_resumo_u (
      p_usuario                  IN       VARCHAR2,
      vo_ok                      OUT      tyt_ok,
      vi_payable_entity_id_ire   IN       t_payable_entity_id_ire,
      vi_contract_id_ire         IN       t_contract_id_ire,
      vi_contract_versao_ire     IN       t_contract_versao_ire
   ) AS
      CURSOR c_cursor IS
         SELECT     *
               FROM ifrbde.viw_conf_item_resumo_u
              WHERE payable_entity_id_ire = vi_payable_entity_id_ire
                AND contract_id_ire = vi_contract_id_ire
                AND contract_versao_ire = vi_contract_versao_ire
         FOR UPDATE;

      v_viw_conf_item_resumo_u      ifrbde.viw_conf_item_resumo_u%ROWTYPE;
      v_dado                        VARCHAR2 (4000) := NULL;
   BEGIN
      vo_ok (1) := 0;

      IF ifrseg.pck_seguranca.stf_permitido (p_usuario,
                                             'VIW_CONF_ITEM_RESUMO_U',
                                             'EXCLUI'
                                            ) THEN
         OPEN c_cursor;

         FETCH c_cursor
          INTO v_viw_conf_item_resumo_u;

         IF NOT c_cursor%NOTFOUND THEN
            v_dado :=
               'payable_entity_id_ire = '
               || RTRIM
                    (LTRIM
                        (UPPER (v_viw_conf_item_resumo_u.payable_entity_id_ire)
                        )
                    );
            v_dado :=
               v_dado
               || ','
               || 'contract_id_ire = '
               || RTRIM
                       (LTRIM (UPPER (v_viw_conf_item_resumo_u.contract_id_ire)
                              )
                       );
            v_dado :=
               v_dado
               || ','
               || 'contract_versao_ire = '
               || RTRIM
                    (LTRIM
                          (UPPER (v_viw_conf_item_resumo_u.contract_versao_ire)
                          )
                    );
            v_dado :=
               v_dado
               || ','
               || 'seq_item = '
               || RTRIM (LTRIM (UPPER (v_viw_conf_item_resumo_u.seq_item)));
            v_dado :=
               v_dado
               || ','
               || 'codigo_resumo_valor = '
               || RTRIM
                    (LTRIM
                          (UPPER (v_viw_conf_item_resumo_u.codigo_resumo_valor)
                          )
                    );
            v_dado :=
               v_dado
               || ','
               || 'tipo_valor = '
               || RTRIM (LTRIM (UPPER (v_viw_conf_item_resumo_u.tipo_valor)));
            v_dado :=
               v_dado
               || ','
               || 'curr_code = '
               || RTRIM (LTRIM (UPPER (v_viw_conf_item_resumo_u.curr_code)));
            v_dado :=
               v_dado
               || ','
               || 'curr_code_secdy = '
               || RTRIM
                       (LTRIM (UPPER (v_viw_conf_item_resumo_u.curr_code_secdy)
                              )
                       );
            v_dado :=
               v_dado
               || ','
               || 'ind_curr_code_controle = '
               || RTRIM
                    (LTRIM
                        (UPPER
                              (v_viw_conf_item_resumo_u.ind_curr_code_controle)
                        )
                    );
            v_dado :=
               v_dado
               || ','
               || 'prim_amt = '
               || TO_CHAR (v_viw_conf_item_resumo_u.prim_amt);
            v_dado :=
               v_dado
               || ','
               || 'secdy_amt = '
               || TO_CHAR (v_viw_conf_item_resumo_u.secdy_amt);
            v_dado :=
               v_dado
               || ','
               || 'data_ultimo_reajuste = '
               || TO_DATE (v_viw_conf_item_resumo_u.data_ultimo_reajuste,
                           'DD/MM/YYYY'
                          );
            v_dado :=
               v_dado
               || ','
               || 'data_prox_reajuste = '
               || TO_DATE (v_viw_conf_item_resumo_u.data_prox_reajuste,
                           'DD/MM/YYYY'
                          );
            v_dado :=
               v_dado
               || ','
               || 'sistema_origem_code_ire = '
               || RTRIM
                    (LTRIM
                        (UPPER
                             (v_viw_conf_item_resumo_u.sistema_origem_code_ire)
                        )
                    );
            v_dado :=
               v_dado
               || ','
               || 'contract_versao_origem_ire = '
               || RTRIM
                    (LTRIM
                        (UPPER
                            (v_viw_conf_item_resumo_u.contract_versao_origem_ire
                            )
                        )
                    );
            v_dado :=
               v_dado
               || ','
               || 'date_created_ire = '
               || TO_DATE (v_viw_conf_item_resumo_u.date_created_ire,
                           'DD/MM/YYYY'
                          );
            v_dado :=
               v_dado
               || ','
               || 'user_id_created_ire = '
               || RTRIM
                    (LTRIM
                          (UPPER (v_viw_conf_item_resumo_u.user_id_created_ire)
                          )
                    );
            v_dado :=
               v_dado
               || ','
               || 'date_changed_ire = '
               || TO_DATE (v_viw_conf_item_resumo_u.date_changed_ire,
                           'DD/MM/YYYY'
                          );
            v_dado :=
               v_dado
               || ','
               || 'user_id_changed_ire = '
               || RTRIM
                    (LTRIM
                          (UPPER (v_viw_conf_item_resumo_u.user_id_changed_ire)
                          )
                    );
            v_dado :=
               v_dado
               || ','
               || 'inactive_ind_ire = '
               || RTRIM
                      (LTRIM (UPPER (v_viw_conf_item_resumo_u.inactive_ind_ire)
                             )
                      );
            v_dado :=
               v_dado
               || ','
               || 'active_date_ire = '
               || TO_DATE (v_viw_conf_item_resumo_u.active_date_ire,
                           'DD/MM/YYYY'
                          );

            IF c_cursor%ROWCOUNT = 1 THEN
               vo_ok (1) := 1;
               -- LOG
               ifrseg.pck_seguranca.stp_log (p_usuario,
                                             'VIW_CONF_ITEM_RESUMO_U',
                                             'E',
                                             v_dado
                                            );

               DELETE FROM ifrbde.viw_conf_item_resumo_u
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
-- Inclui Contrato Item - Resumo Valor
-- retorna o recordset correspondente
   PROCEDURE stp_inclui_conf_item_resumo_u (
      p_usuario                  IN       VARCHAR2,
      vo_payable_entity_id_ire   OUT      tyt_payable_entity_id_ire,
      vo_contract_id_ire         OUT      tyt_contract_id_ire,
      vo_contract_versao_ire     OUT      tyt_contract_versao_ire,
      vo_seq_item                OUT      tyt_seq_item,
      vo_codigo_resumo_valor     OUT      tyt_codigo_resumo_valor,
      vo_tipo_valor              OUT      tyt_tipo_valor,
      vo_curr_code               OUT      tyt_curr_code,
      vo_curr_code_secdy         OUT      tyt_curr_code_secdy,
      vo_ind_curr_code_controle  OUT      tyt_ind_curr_code_controle,
      vo_prim_amt                OUT      tyt_prim_amt,
      vo_secdy_amt               OUT      tyt_secdy_amt,
      vo_data_ultimo_reajuste    OUT      tyt_data_ultimo_reajuste,
      vo_data_prox_reajuste      OUT      tyt_data_prox_reajuste,
      vo_sistema_origem_code_ire OUT      tyt_sistema_origem_code_ire,
      vo_contract_versao_origem_ire OUT   tyt_contract_versao_origem_ire,
      vo_date_created_ire        OUT      tyt_date_created_ire,
      vo_user_id_created_ire     OUT      tyt_user_id_created_ire,
      vo_date_changed_ire        OUT      tyt_date_changed_ire,
      vo_user_id_changed_ire     OUT      tyt_user_id_changed_ire,
      vo_inactive_ind_ire        OUT      tyt_inactive_ind_ire,
      vo_active_date_ire         OUT      tyt_active_date_ire,
      vi_payable_entity_id_ire   IN       t_payable_entity_id_ire,
      vi_contract_id_ire         IN       t_contract_id_ire,
      vi_contract_versao_ire     IN       t_contract_versao_ire,
      vi_seq_item                IN       t_seq_item,
      vi_codigo_resumo_valor     IN       t_codigo_resumo_valor,
      vi_tipo_valor              IN       t_tipo_valor,
      vi_curr_code               IN       t_curr_code,
      vi_curr_code_secdy         IN       t_curr_code_secdy,
      vi_ind_curr_code_controle  IN       t_ind_curr_code_controle,
      vi_prim_amt                IN       t_prim_amt,
      vi_secdy_amt               IN       t_secdy_amt,
      vi_data_ultimo_reajuste    IN       t_data_ultimo_reajuste,
      vi_data_prox_reajuste      IN       t_data_prox_reajuste,
      vi_user_id_created_ire     IN       t_user_id_created_ire
   ) AS
      v_payable_entity_id_ire       viw_conf_item_resumo_u.payable_entity_id_ire%TYPE;
      v_contract_id_ire             viw_conf_item_resumo_u.contract_id_ire%TYPE;
      v_contract_versao_ire         viw_conf_item_resumo_u.contract_versao_ire%TYPE;
      v_seq_item                    viw_conf_item_resumo_u.seq_item%TYPE;
      v_codigo_resumo_valor         viw_conf_item_resumo_u.codigo_resumo_valor%TYPE;
      v_tipo_valor                  viw_conf_item_resumo_u.tipo_valor%TYPE;
      v_curr_code                   viw_conf_item_resumo_u.curr_code%TYPE;
      v_curr_code_secdy             viw_conf_item_resumo_u.curr_code_secdy%TYPE;
      v_ind_curr_code_controle      viw_conf_item_resumo_u.ind_curr_code_controle%TYPE;
      v_prim_amt                    viw_conf_item_resumo_u.prim_amt%TYPE;
      v_secdy_amt                   viw_conf_item_resumo_u.secdy_amt%TYPE;
      v_data_ultimo_reajuste        viw_conf_item_resumo_u.data_ultimo_reajuste%TYPE;
      v_data_prox_reajuste          viw_conf_item_resumo_u.data_prox_reajuste%TYPE;
      v_user_id_created_ire         viw_conf_item_resumo_u.user_id_created_ire%TYPE;
      v_dado                        VARCHAR2 (4000) := NULL;
   BEGIN
      IF ifrseg.pck_seguranca.stf_permitido (p_usuario,
                                             'VIW_CONF_ITEM_RESUMO_U',
                                             'INCLUI'
                                            ) THEN
         v_payable_entity_id_ire := RTRIM (LTRIM (vi_payable_entity_id_ire));
         v_contract_id_ire := RTRIM (LTRIM (vi_contract_id_ire));
         v_contract_versao_ire := RTRIM (LTRIM (vi_contract_versao_ire));
         v_seq_item := RTRIM (LTRIM (vi_seq_item));
         v_codigo_resumo_valor := RTRIM (LTRIM (vi_codigo_resumo_valor));
         v_tipo_valor := RTRIM (LTRIM (vi_tipo_valor));
         v_curr_code := RTRIM (LTRIM (vi_curr_code));
         v_curr_code_secdy := RTRIM (LTRIM (vi_curr_code_secdy));
         v_ind_curr_code_controle :=
                                    RTRIM (LTRIM (vi_ind_curr_code_controle));
         v_user_id_created_ire := RTRIM (LTRIM (vi_user_id_created_ire));
         v_data_ultimo_reajuste :=
                              TO_DATE (vi_data_ultimo_reajuste, 'DD/MM/YYYY');
         v_data_prox_reajuste :=
                                TO_DATE (vi_data_prox_reajuste, 'DD/MM/YYYY');
         v_prim_amt := vi_prim_amt;
         v_secdy_amt := vi_secdy_amt;

         INSERT INTO ifrbde.viw_conf_item_resumo_u
                     (payable_entity_id_ire,
                      contract_id_ire,
                      contract_versao_ire,
                      seq_item,
                      codigo_resumo_valor,
                      tipo_valor,
                      curr_code,
                      curr_code_secdy,
                      ind_curr_code_controle,
                      prim_amt,
                      secdy_amt,
                      data_ultimo_reajuste,
                      data_prox_reajuste,
                      user_id_created_ire
                     )
              VALUES (v_payable_entity_id_ire,
                      v_contract_id_ire,
                      v_contract_versao_ire,
                      v_seq_item,
                      v_codigo_resumo_valor,
                      v_tipo_valor,
                      v_curr_code,
                      v_curr_code_secdy,
                      v_ind_curr_code_controle,
                      v_prim_amt,
                      v_secdy_amt,
                      v_data_ultimo_reajuste,
                      v_data_prox_reajuste,
                      v_user_id_created_ire
                     );

         IF SQL%ROWCOUNT = 1 THEN
            stp_pesquisa_conf_item_resumo_ (p_usuario,
                                            vo_payable_entity_id_ire,
                                            vo_contract_id_ire,
                                            vo_contract_versao_ire,
                                            vo_seq_item,
                                            vo_codigo_resumo_valor,
                                            vo_tipo_valor,
                                            vo_curr_code,
                                            vo_curr_code_secdy,
                                            vo_ind_curr_code_controle,
                                            vo_prim_amt,
                                            vo_secdy_amt,
                                            vo_data_ultimo_reajuste,
                                            vo_data_prox_reajuste,
                                            vo_sistema_origem_code_ire,
                                            vo_contract_versao_origem_ire,
                                            vo_date_created_ire,
                                            vo_user_id_created_ire,
                                            vo_date_changed_ire,
                                            vo_user_id_changed_ire,
                                            vo_inactive_ind_ire,
                                            vo_active_date_ire,
                                            v_payable_entity_id_ire,
                                            v_contract_id_ire,
                                            v_contract_versao_ire
                                           );
            v_dado :=
               'payable_entity_id_ire = '
               || RTRIM (LTRIM (v_payable_entity_id_ire));
            v_dado :=
               v_dado
               || ','
               || 'contract_id_ire = '
               || RTRIM (LTRIM (v_contract_id_ire));
            v_dado :=
               v_dado
               || ','
               || 'contract_versao_ire = '
               || RTRIM (LTRIM (v_contract_versao_ire));
            v_dado :=
                  v_dado || ',' || 'seq_item = ' || RTRIM (LTRIM (v_seq_item));
            v_dado :=
               v_dado
               || ','
               || 'codigo_resumo_valor = '
               || RTRIM (LTRIM (v_codigo_resumo_valor));
            v_dado :=
               v_dado || ',' || 'tipo_valor = '
               || RTRIM (LTRIM (v_tipo_valor));
            v_dado :=
                v_dado || ',' || 'curr_code = ' || RTRIM (LTRIM (v_curr_code));
            v_dado :=
               v_dado
               || ','
               || 'curr_code_secdy = '
               || RTRIM (LTRIM (v_curr_code_secdy));
            v_dado :=
               v_dado
               || ','
               || 'ind_curr_code_controle = '
               || RTRIM (LTRIM (v_ind_curr_code_controle));
            v_dado := v_dado || ',' || 'prim_amt = ' || TO_CHAR (v_prim_amt);
            v_dado := v_dado || ',' || 'secdy_amt = ' || TO_CHAR (v_secdy_amt);
            v_dado :=
               v_dado
               || ','
               || 'data_ultimo_reajuste = '
               || TO_CHAR (v_data_ultimo_reajuste, 'DD/MM/YYYY');
            v_dado :=
               v_dado
               || ','
               || 'data_prox_reajuste = '
               || TO_CHAR (v_data_prox_reajuste, 'DD/MM/YYYY');
            v_dado :=
               v_dado
               || ','
               || 'user_id_created_ire = '
               || RTRIM (LTRIM (v_user_id_created_ire));
            -- LOG
            ifrseg.pck_seguranca.stp_log (p_usuario,
                                          'VIW_CONF_ITEM_RESUMO_U',
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
-- Altera Contrato Item - Resumo Valor
-- retorna o recordset correspondente
   PROCEDURE stp_altera_conf_item_resumo_u (
      p_usuario                  IN       VARCHAR2,
      vo_payable_entity_id_ire   OUT      tyt_payable_entity_id_ire,
      vo_contract_id_ire         OUT      tyt_contract_id_ire,
      vo_contract_versao_ire     OUT      tyt_contract_versao_ire,
      vo_seq_item                OUT      tyt_seq_item,
      vo_codigo_resumo_valor     OUT      tyt_codigo_resumo_valor,
      vo_tipo_valor              OUT      tyt_tipo_valor,
      vo_curr_code               OUT      tyt_curr_code,
      vo_curr_code_secdy         OUT      tyt_curr_code_secdy,
      vo_ind_curr_code_controle  OUT      tyt_ind_curr_code_controle,
      vo_prim_amt                OUT      tyt_prim_amt,
      vo_secdy_amt               OUT      tyt_secdy_amt,
      vo_data_ultimo_reajuste    OUT      tyt_data_ultimo_reajuste,
      vo_data_prox_reajuste      OUT      tyt_data_prox_reajuste,
      vo_sistema_origem_code_ire OUT      tyt_sistema_origem_code_ire,
      vo_contract_versao_origem_ire OUT   tyt_contract_versao_origem_ire,
      vo_date_created_ire        OUT      tyt_date_created_ire,
      vo_user_id_created_ire     OUT      tyt_user_id_created_ire,
      vo_date_changed_ire        OUT      tyt_date_changed_ire,
      vo_user_id_changed_ire     OUT      tyt_user_id_changed_ire,
      vo_inactive_ind_ire        OUT      tyt_inactive_ind_ire,
      vo_active_date_ire         OUT      tyt_active_date_ire,
      vi_payable_entity_id_ire   IN       t_payable_entity_id_ire,
      vi_contract_id_ire         IN       t_contract_id_ire,
      vi_contract_versao_ire     IN       t_contract_versao_ire,
      vi_seq_item                IN       t_seq_item,
      vi_codigo_resumo_valor     IN       t_codigo_resumo_valor,
      vi_tipo_valor              IN       t_tipo_valor,
      vi_curr_code               IN       t_curr_code,
      vi_curr_code_secdy         IN       t_curr_code_secdy,
      vi_ind_curr_code_controle  IN       t_ind_curr_code_controle,
      vi_prim_amt                IN       t_prim_amt,
      vi_secdy_amt               IN       t_secdy_amt,
      vi_data_ultimo_reajuste    IN       t_data_ultimo_reajuste,
      vi_data_prox_reajuste      IN       t_data_prox_reajuste,
      vi_user_id_created_ire     IN       t_user_id_created_ire
   ) AS
      CURSOR c_cursor IS
         SELECT     *
               FROM ifrbde.viw_conf_item_resumo_u
              WHERE payable_entity_id_ire = vi_payable_entity_id_ire
                AND contract_id_ire = vi_contract_id_ire
                AND contract_versao_ire = vi_contract_versao_ire
         FOR UPDATE;

      v_viw_conf_item_resumo_u      ifrbde.viw_conf_item_resumo_u%ROWTYPE;
      v_payable_entity_id_ire       ifrbde.viw_conf_item_resumo_u.payable_entity_id_ire%TYPE;
      v_contract_id_ire             ifrbde.viw_conf_item_resumo_u.contract_id_ire%TYPE;
      v_contract_versao_ire         ifrbde.viw_conf_item_resumo_u.contract_versao_ire%TYPE;
      v_seq_item                    ifrbde.viw_conf_item_resumo_u.seq_item%TYPE;
      v_codigo_resumo_valor         ifrbde.viw_conf_item_resumo_u.codigo_resumo_valor%TYPE;
      v_tipo_valor                  ifrbde.viw_conf_item_resumo_u.tipo_valor%TYPE;
      v_curr_code                   ifrbde.viw_conf_item_resumo_u.curr_code%TYPE;
      v_curr_code_secdy             ifrbde.viw_conf_item_resumo_u.curr_code_secdy%TYPE;
      v_ind_curr_code_controle      ifrbde.viw_conf_item_resumo_u.ind_curr_code_controle%TYPE;
      v_prim_amt                    ifrbde.viw_conf_item_resumo_u.prim_amt%TYPE;
      v_secdy_amt                   ifrbde.viw_conf_item_resumo_u.secdy_amt%TYPE;
      v_data_ultimo_reajuste        ifrbde.viw_conf_item_resumo_u.data_ultimo_reajuste%TYPE;
      v_data_prox_reajuste          ifrbde.viw_conf_item_resumo_u.data_prox_reajuste%TYPE;
      v_user_id_created_ire         ifrbde.viw_conf_item_resumo_u.user_id_created_ire%TYPE;
      v_dado                        VARCHAR2 (4000) := NULL;
   BEGIN
      IF ifrseg.pck_seguranca.stf_permitido (p_usuario,
                                             'VIW_CONF_ITEM_RESUMO_U',
                                             'ALTERA'
                                            ) THEN
         OPEN c_cursor;

         FETCH c_cursor
          INTO v_viw_conf_item_resumo_u;

         IF NOT c_cursor%NOTFOUND THEN
            v_payable_entity_id_ire :=
                                     RTRIM (LTRIM (vi_payable_entity_id_ire));
            v_contract_id_ire := RTRIM (LTRIM (vi_contract_id_ire));
            v_contract_versao_ire := RTRIM (LTRIM (vi_contract_versao_ire));
            v_seq_item := RTRIM (LTRIM (vi_seq_item));
            v_codigo_resumo_valor := RTRIM (LTRIM (vi_codigo_resumo_valor));
            v_tipo_valor := RTRIM (LTRIM (vi_tipo_valor));
            v_curr_code := RTRIM (LTRIM (vi_curr_code));
            v_curr_code_secdy := RTRIM (LTRIM (vi_curr_code_secdy));
            v_ind_curr_code_controle :=
                                    RTRIM (LTRIM (vi_ind_curr_code_controle));
            v_user_id_created_ire := RTRIM (LTRIM (vi_user_id_created_ire));
            v_data_ultimo_reajuste :=
                              TO_DATE (vi_data_ultimo_reajuste, 'DD/MM/YYYY');
            v_data_prox_reajuste :=
                                TO_DATE (vi_data_prox_reajuste, 'DD/MM/YYYY');
            v_prim_amt := vi_prim_amt;
            v_secdy_amt := vi_secdy_amt;

            UPDATE ifrbde.viw_conf_item_resumo_u
               SET seq_item = v_seq_item,
                   codigo_resumo_valor = v_codigo_resumo_valor,
                   tipo_valor = v_tipo_valor,
                   curr_code = v_curr_code,
                   curr_code_secdy = v_curr_code_secdy,
                   ind_curr_code_controle = v_ind_curr_code_controle,
                   prim_amt = v_prim_amt,
                   secdy_amt = v_secdy_amt,
                   data_ultimo_reajuste = v_data_ultimo_reajuste,
                   data_prox_reajuste = v_data_prox_reajuste,
                   user_id_created_ire = v_user_id_created_ire
             WHERE CURRENT OF c_cursor;

            IF SQL%ROWCOUNT = 1 THEN
               stp_pesquisa_conf_item_resumo_ (p_usuario,
                                               vo_payable_entity_id_ire,
                                               vo_contract_id_ire,
                                               vo_contract_versao_ire,
                                               vo_seq_item,
                                               vo_codigo_resumo_valor,
                                               vo_tipo_valor,
                                               vo_curr_code,
                                               vo_curr_code_secdy,
                                               vo_ind_curr_code_controle,
                                               vo_prim_amt,
                                               vo_secdy_amt,
                                               vo_data_ultimo_reajuste,
                                               vo_data_prox_reajuste,
                                               vo_sistema_origem_code_ire,
                                               vo_contract_versao_origem_ire,
                                               vo_date_created_ire,
                                               vo_user_id_created_ire,
                                               vo_date_changed_ire,
                                               vo_user_id_changed_ire,
                                               vo_inactive_ind_ire,
                                               vo_active_date_ire,
                                               vi_payable_entity_id_ire,
                                               vi_contract_id_ire,
                                               vi_contract_versao_ire
                                              );
               v_dado :=
                  'payable_entity_id_ire = '
                  || RTRIM (LTRIM (v_payable_entity_id_ire));
               v_dado :=
                  v_dado
                  || ','
                  || 'contract_id_ire = '
                  || RTRIM (LTRIM (v_contract_id_ire));
               v_dado :=
                  v_dado
                  || ','
                  || 'contract_versao_ire = '
                  || RTRIM (LTRIM (v_contract_versao_ire));
               v_dado :=
                  v_dado || ',' || 'seq_item = ' || RTRIM (LTRIM (v_seq_item));
               v_dado :=
                  v_dado
                  || ','
                  || 'codigo_resumo_valor = '
                  || RTRIM (LTRIM (v_codigo_resumo_valor));
               v_dado :=
                  v_dado
                  || ','
                  || 'tipo_valor = '
                  || RTRIM (LTRIM (v_tipo_valor));
               v_dado :=
                  v_dado || ',' || 'curr_code = '
                  || RTRIM (LTRIM (v_curr_code));
               v_dado :=
                  v_dado
                  || ','
                  || 'curr_code_secdy = '
                  || RTRIM (LTRIM (v_curr_code_secdy));
               v_dado :=
                  v_dado
                  || ','
                  || 'ind_curr_code_controle = '
                  || RTRIM (LTRIM (v_ind_curr_code_controle));
               v_dado :=
                        v_dado || ',' || 'prim_amt = ' || TO_CHAR (v_prim_amt);
               v_dado :=
                      v_dado || ',' || 'secdy_amt = ' || TO_CHAR (v_secdy_amt);
               v_dado :=
                  v_dado
                  || ','
                  || 'data_ultimo_reajuste = '
                  || TO_CHAR (v_data_ultimo_reajuste, 'DD/MM/YYYY');
               v_dado :=
                  v_dado
                  || ','
                  || 'data_prox_reajuste = '
                  || TO_CHAR (v_data_prox_reajuste, 'DD/MM/YYYY');
               v_dado :=
                  v_dado
                  || ','
                  || 'user_id_created_ire = '
                  || RTRIM (LTRIM (v_user_id_created_ire));
               -- LOG
               ifrseg.pck_seguranca.stp_log (p_usuario,
                                             'VIW_CONF_ITEM_RESUMO_U',
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
-- Pesquisa Cronograma Desembolso Reajuste
-- retorna o recordset correspondente
   PROCEDURE stp_pesquisa_conf_item_cronogr (
      p_usuario                  IN       VARCHAR2,
      vo_payable_entity_id_icr   OUT      tyt_payable_entity_id_icr,
      vo_contract_id_icr         OUT      tyt_contract_id_icr,
      vo_contract_versao_icr     OUT      tyt_contract_versao_icr,
      vo_seq_item                OUT      tyt_seq_item,
      vo_codigo_resumo_valor     OUT      tyt_codigo_resumo_valor,
      vo_tipo_cronograma         OUT      tyt_tipo_cronograma,
      vo_numero_parcela          OUT      tyt_numero_parcela,
      vo_vendor_id               OUT      tyt_vendor_id,
      vo_vendor_loc_code         OUT      tyt_vendor_loc_code,
      vo_tipo_valor              OUT      tyt_tipo_valor,
      vo_data_vencto             OUT      tyt_data_vencto,
      vo_prim_amt                OUT      tyt_prim_amt,
      vo_secdy_amt               OUT      tyt_secdy_amt,
      vo_codigo_recurso          OUT      tyt_codigo_recurso,
      vo_vendor_id_rec           OUT      tyt_vendor_id_rec,
      vo_vendor_loc_code_rec     OUT      tyt_vendor_loc_code_rec,
      vo_sistema_origem_code_icr OUT      tyt_sistema_origem_code_icr,
      vo_contract_versao_origem_icr OUT   tyt_contract_versao_origem_icr,
      vo_date_created_icr        OUT      tyt_date_created_icr,
      vo_user_id_created_icr     OUT      tyt_user_id_created_icr,
      vo_date_changed_icr        OUT      tyt_date_changed_icr,
      vo_user_id_changed_icr     OUT      tyt_user_id_changed_icr,
      vo_inactive_ind_icr        OUT      tyt_inactive_ind_icr,
      vo_active_date_icr         OUT      tyt_active_date_icr,
      vi_payable_entity_id_icr   IN       t_payable_entity_id_icr,
      vi_contract_id_icr         IN       t_contract_id_icr,
      vi_contract_versao_icr     IN       t_contract_versao_icr,
      vi_seq_item                IN       t_seq_item,
      vi_codigo_resumo_valor     IN       t_codigo_resumo_valor,
      vi_numero_parcela          IN       t_numero_parcela
   ) AS
   BEGIN
      IF ifrseg.pck_seguranca.stf_permitido (p_usuario,
                                             'VIW_CONF_ITEM_CRONOGRAMA_U',
                                             'PESQUISA'
                                            ) THEN
         SELECT payable_entity_id_icr,
                contract_id_icr,
                contract_versao_icr,
                seq_item,
                codigo_resumo_valor,
                tipo_cronograma,
                numero_parcela,
                vendor_id,
                vendor_loc_code,
                tipo_valor,
                data_vencto,
                prim_amt,
                secdy_amt,
                codigo_recurso,
                vendor_id_rec,
                vendor_loc_code_rec,
                sistema_origem_code_icr,
                contract_versao_origem_icr,
                date_created_icr,
                user_id_created_icr,
                date_changed_icr,
                user_id_changed_icr,
                inactive_ind_icr,
                active_date_icr
           INTO vo_payable_entity_id_icr (1),
                vo_contract_id_icr (1),
                vo_contract_versao_icr (1),
                vo_seq_item (1),
                vo_codigo_resumo_valor (1),
                vo_tipo_cronograma (1),
                vo_numero_parcela (1),
                vo_vendor_id (1),
                vo_vendor_loc_code (1),
                vo_tipo_valor (1),
                vo_data_vencto (1),
                vo_prim_amt (1),
                vo_secdy_amt (1),
                vo_codigo_recurso (1),
                vo_vendor_id_rec (1),
                vo_vendor_loc_code_rec (1),
                vo_sistema_origem_code_icr (1),
                vo_contract_versao_origem_icr (1),
                vo_date_created_icr (1),
                vo_user_id_created_icr (1),
                vo_date_changed_icr (1),
                vo_user_id_changed_icr (1),
                vo_inactive_ind_icr (1),
                vo_active_date_icr (1)
           FROM ifrbde.viw_conf_item_cronograma_u
          WHERE payable_entity_id_icr = vi_payable_entity_id_icr
            AND contract_id_icr = vi_contract_id_icr
            AND contract_versao_icr = vi_contract_versao_icr
            AND seq_item = vi_seq_item
            AND codigo_resumo_valor = vi_codigo_resumo_valor
            AND numero_parcela = vi_numero_parcela;
      END IF;
   EXCEPTION
      WHEN OTHERS THEN
         raise_application_error (-20100, SQLERRM);
   END;

   -- Exclui Cronograma Desembolso Reajuste
   -- retorna o OK ou não
   PROCEDURE stp_exclui_conf_item_cronogram (
      p_usuario                  IN       VARCHAR2,
      vo_ok                      OUT      tyt_ok,
      vi_payable_entity_id_icr   IN       t_payable_entity_id_icr,
      vi_contract_id_icr         IN       t_contract_id_icr,
      vi_contract_versao_icr     IN       t_contract_versao_icr,
      vi_seq_item                IN       t_seq_item,
      vi_codigo_resumo_valor     IN       t_codigo_resumo_valor,
      vi_numero_parcela          IN       t_numero_parcela
   ) AS
      CURSOR c_cursor IS
         SELECT     *
               FROM ifrbde.viw_conf_item_cronograma_u
              WHERE payable_entity_id_icr = vi_payable_entity_id_icr
                AND contract_id_icr = vi_contract_id_icr
                AND contract_versao_icr = vi_contract_versao_icr
                AND seq_item = vi_seq_item
                AND codigo_resumo_valor = vi_codigo_resumo_valor
                AND numero_parcela = vi_numero_parcela
         FOR UPDATE;

      v_viw_conf_item_cronograma_u  ifrbde.viw_conf_item_cronograma_u%ROWTYPE;
      v_dado                        VARCHAR2 (4000) := NULL;
   BEGIN
      vo_ok (1) := 0;

      IF ifrseg.pck_seguranca.stf_permitido (p_usuario,
                                             'VIW_CONF_ITEM_CRONOGRAMA_U',
                                             'EXCLUI'
                                            ) THEN
         OPEN c_cursor;

         FETCH c_cursor
          INTO v_viw_conf_item_cronograma_u;

         IF NOT c_cursor%NOTFOUND THEN
            v_dado :=
               'payable_entity_id_icr = '
               || RTRIM
                    (LTRIM
                        (UPPER
                            (v_viw_conf_item_cronograma_u.payable_entity_id_icr
                            )
                        )
                    );
            v_dado :=
               v_dado
               || ','
               || 'contract_id_icr = '
               || RTRIM
                    (LTRIM
                          (UPPER (v_viw_conf_item_cronograma_u.contract_id_icr)
                          )
                    );
            v_dado :=
               v_dado
               || ','
               || 'contract_versao_icr = '
               || RTRIM
                    (LTRIM
                        (UPPER
                             (v_viw_conf_item_cronograma_u.contract_versao_icr)
                        )
                    );
            v_dado :=
               v_dado
               || ','
               || 'seq_item = '
               || RTRIM (LTRIM (UPPER (v_viw_conf_item_cronograma_u.seq_item)));
            v_dado :=
               v_dado
               || ','
               || 'codigo_resumo_valor = '
               || RTRIM
                    (LTRIM
                        (UPPER
                             (v_viw_conf_item_cronograma_u.codigo_resumo_valor)
                        )
                    );
            v_dado :=
               v_dado
               || ','
               || 'tipo_cronograma = '
               || RTRIM
                    (LTRIM
                          (UPPER (v_viw_conf_item_cronograma_u.tipo_cronograma)
                          )
                    );
            v_dado :=
               v_dado
               || ','
               || 'numero_parcela = '
               || RTRIM
                    (LTRIM (UPPER (v_viw_conf_item_cronograma_u.numero_parcela)
                           )
                    );
            v_dado :=
               v_dado
               || ','
               || 'vendor_id = '
               || RTRIM (LTRIM (UPPER (v_viw_conf_item_cronograma_u.vendor_id))
                        );
            v_dado :=
               v_dado
               || ','
               || 'vendor_loc_code = '
               || RTRIM
                    (LTRIM
                          (UPPER (v_viw_conf_item_cronograma_u.vendor_loc_code)
                          )
                    );
            v_dado :=
               v_dado
               || ','
               || 'tipo_valor = '
               || RTRIM (LTRIM (UPPER (v_viw_conf_item_cronograma_u.tipo_valor)
                               )
                        );
            v_dado :=
               v_dado
               || ','
               || 'data_vencto = '
               || TO_DATE (v_viw_conf_item_cronograma_u.data_vencto,
                           'DD/MM/YYYY'
                          );
            v_dado :=
               v_dado
               || ','
               || 'prim_amt = '
               || TO_CHAR (v_viw_conf_item_cronograma_u.prim_amt);
            v_dado :=
               v_dado
               || ','
               || 'secdy_amt = '
               || TO_CHAR (v_viw_conf_item_cronograma_u.secdy_amt);
            v_dado :=
               v_dado
               || ','
               || 'codigo_recurso = '
               || RTRIM
                    (LTRIM (UPPER (v_viw_conf_item_cronograma_u.codigo_recurso)
                           )
                    );
            v_dado :=
               v_dado
               || ','
               || 'vendor_id_rec = '
               || RTRIM
                     (LTRIM (UPPER (v_viw_conf_item_cronograma_u.vendor_id_rec)
                            )
                     );
            v_dado :=
               v_dado
               || ','
               || 'vendor_loc_code_rec = '
               || RTRIM
                    (LTRIM
                        (UPPER
                             (v_viw_conf_item_cronograma_u.vendor_loc_code_rec)
                        )
                    );
            v_dado :=
               v_dado
               || ','
               || 'sistema_origem_code_icr = '
               || RTRIM
                    (LTRIM
                        (UPPER
                            (v_viw_conf_item_cronograma_u.sistema_origem_code_icr
                            )
                        )
                    );
            v_dado :=
               v_dado
               || ','
               || 'contract_versao_origem_icr = '
               || RTRIM
                    (LTRIM
                        (UPPER
                            (v_viw_conf_item_cronograma_u.contract_versao_origem_icr
                            )
                        )
                    );
            v_dado :=
               v_dado
               || ','
               || 'date_created_icr = '
               || TO_DATE (v_viw_conf_item_cronograma_u.date_created_icr,
                           'DD/MM/YYYY'
                          );
            v_dado :=
               v_dado
               || ','
               || 'user_id_created_icr = '
               || RTRIM
                    (LTRIM
                        (UPPER
                             (v_viw_conf_item_cronograma_u.user_id_created_icr)
                        )
                    );
            v_dado :=
               v_dado
               || ','
               || 'date_changed_icr = '
               || TO_DATE (v_viw_conf_item_cronograma_u.date_changed_icr,
                           'DD/MM/YYYY'
                          );
            v_dado :=
               v_dado
               || ','
               || 'user_id_changed_icr = '
               || RTRIM
                    (LTRIM
                        (UPPER
                             (v_viw_conf_item_cronograma_u.user_id_changed_icr)
                        )
                    );
            v_dado :=
               v_dado
               || ','
               || 'inactive_ind_icr = '
               || RTRIM
                    (LTRIM
                         (UPPER (v_viw_conf_item_cronograma_u.inactive_ind_icr)
                         )
                    );
            v_dado :=
               v_dado
               || ','
               || 'active_date_icr = '
               || TO_DATE (v_viw_conf_item_cronograma_u.active_date_icr,
                           'DD/MM/YYYY'
                          );

            IF c_cursor%ROWCOUNT = 1 THEN
               vo_ok (1) := 1;
               -- LOG
               ifrseg.pck_seguranca.stp_log (p_usuario,
                                             'VIW_CONF_ITEM_CRONOGRAMA_U',
                                             'E',
                                             v_dado
                                            );

               DELETE FROM ifrbde.viw_conf_item_cronograma_u
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
-- Inclui Cronograma Desembolso Reajuste
-- retorna o recordset correspondente
   PROCEDURE stp_inclui_conf_item_cronogram (
      p_usuario                  IN       VARCHAR2,
      vo_payable_entity_id_icr   OUT      tyt_payable_entity_id_icr,
      vo_contract_id_icr         OUT      tyt_contract_id_icr,
      vo_contract_versao_icr     OUT      tyt_contract_versao_icr,
      vo_seq_item                OUT      tyt_seq_item,
      vo_codigo_resumo_valor     OUT      tyt_codigo_resumo_valor,
      vo_tipo_cronograma         OUT      tyt_tipo_cronograma,
      vo_numero_parcela          OUT      tyt_numero_parcela,
      vo_vendor_id               OUT      tyt_vendor_id,
      vo_vendor_loc_code         OUT      tyt_vendor_loc_code,
      vo_tipo_valor              OUT      tyt_tipo_valor,
      vo_data_vencto             OUT      tyt_data_vencto,
      vo_prim_amt                OUT      tyt_prim_amt,
      vo_secdy_amt               OUT      tyt_secdy_amt,
      vo_codigo_recurso          OUT      tyt_codigo_recurso,
      vo_vendor_id_rec           OUT      tyt_vendor_id_rec,
      vo_vendor_loc_code_rec     OUT      tyt_vendor_loc_code_rec,
      vo_sistema_origem_code_icr OUT      tyt_sistema_origem_code_icr,
      vo_contract_versao_origem_icr OUT   tyt_contract_versao_origem_icr,
      vo_date_created_icr        OUT      tyt_date_created_icr,
      vo_user_id_created_icr     OUT      tyt_user_id_created_icr,
      vo_date_changed_icr        OUT      tyt_date_changed_icr,
      vo_user_id_changed_icr     OUT      tyt_user_id_changed_icr,
      vo_inactive_ind_icr        OUT      tyt_inactive_ind_icr,
      vo_active_date_icr         OUT      tyt_active_date_icr,
      vi_payable_entity_id_icr   IN       t_payable_entity_id_icr,
      vi_contract_id_icr         IN       t_contract_id_icr,
      vi_contract_versao_icr     IN       t_contract_versao_icr,
      vi_seq_item                IN       t_seq_item,
      vi_codigo_resumo_valor     IN       t_codigo_resumo_valor,
      vi_tipo_cronograma         IN       t_tipo_cronograma,
      vi_numero_parcela          IN       t_numero_parcela,
      vi_vendor_id               IN       t_vendor_id,
      vi_vendor_loc_code         IN       t_vendor_loc_code,
      vi_tipo_valor              IN       t_tipo_valor,
      vi_data_vencto             IN       t_data_vencto,
      vi_prim_amt                IN       t_prim_amt,
      vi_secdy_amt               IN       t_secdy_amt,
      vi_codigo_recurso          IN       t_codigo_recurso,
      vi_vendor_id_rec           IN       t_vendor_id_rec,
      vi_vendor_loc_code_rec     IN       t_vendor_loc_code_rec,
      vi_user_id_created_icr     IN       t_user_id_created_icr
   ) AS
      v_payable_entity_id_icr       viw_conf_item_cronograma_u.payable_entity_id_icr%TYPE;
      v_contract_id_icr             viw_conf_item_cronograma_u.contract_id_icr%TYPE;
      v_contract_versao_icr         viw_conf_item_cronograma_u.contract_versao_icr%TYPE;
      v_seq_item                    viw_conf_item_cronograma_u.seq_item%TYPE;
      v_codigo_resumo_valor         viw_conf_item_cronograma_u.codigo_resumo_valor%TYPE;
      v_tipo_cronograma             viw_conf_item_cronograma_u.tipo_cronograma%TYPE;
      v_numero_parcela              viw_conf_item_cronograma_u.numero_parcela%TYPE;
      v_vendor_id                   viw_conf_item_cronograma_u.vendor_id%TYPE;
      v_vendor_loc_code             viw_conf_item_cronograma_u.vendor_loc_code%TYPE;
      v_tipo_valor                  viw_conf_item_cronograma_u.tipo_valor%TYPE;
      v_data_vencto                 viw_conf_item_cronograma_u.data_vencto%TYPE;
      v_prim_amt                    viw_conf_item_cronograma_u.prim_amt%TYPE;
      v_secdy_amt                   viw_conf_item_cronograma_u.secdy_amt%TYPE;
      v_codigo_recurso              viw_conf_item_cronograma_u.codigo_recurso%TYPE;
      v_vendor_id_rec               viw_conf_item_cronograma_u.vendor_id_rec%TYPE;
      v_vendor_loc_code_rec         viw_conf_item_cronograma_u.vendor_loc_code_rec%TYPE;
      v_user_id_created_icr         viw_conf_item_cronograma_u.user_id_created_icr%TYPE;
      v_dado                        VARCHAR2 (4000) := NULL;
   BEGIN
      IF ifrseg.pck_seguranca.stf_permitido (p_usuario,
                                             'VIW_CONF_ITEM_CRONOGRAMA_U',
                                             'INCLUI'
                                            ) THEN
         v_payable_entity_id_icr := RTRIM (LTRIM (vi_payable_entity_id_icr));
         v_contract_id_icr := RTRIM (LTRIM (vi_contract_id_icr));
         v_contract_versao_icr := RTRIM (LTRIM (vi_contract_versao_icr));
         v_seq_item := RTRIM (LTRIM (vi_seq_item));
         v_codigo_resumo_valor := RTRIM (LTRIM (vi_codigo_resumo_valor));
         v_tipo_cronograma := RTRIM (LTRIM (vi_tipo_cronograma));
         v_numero_parcela := RTRIM (LTRIM (vi_numero_parcela));
         v_vendor_id := RTRIM (LTRIM (vi_vendor_id));
         v_vendor_loc_code := RTRIM (LTRIM (vi_vendor_loc_code));
         v_tipo_valor := RTRIM (LTRIM (vi_tipo_valor));
         v_codigo_recurso := RTRIM (LTRIM (vi_codigo_recurso));
         v_vendor_id_rec := RTRIM (LTRIM (vi_vendor_id_rec));
         v_vendor_loc_code_rec := RTRIM (LTRIM (vi_vendor_loc_code_rec));
         v_user_id_created_icr := RTRIM (LTRIM (vi_user_id_created_icr));
         v_data_vencto := TO_DATE (vi_data_vencto, 'DD/MM/YYYY');
         v_prim_amt := vi_prim_amt;
         v_secdy_amt := vi_secdy_amt;

         INSERT INTO ifrbde.viw_conf_item_cronograma_u
                     (payable_entity_id_icr,
                      contract_id_icr,
                      contract_versao_icr,
                      seq_item,
                      codigo_resumo_valor,
                      tipo_cronograma,
                      numero_parcela,
                      vendor_id,
                      vendor_loc_code,
                      tipo_valor,
                      data_vencto,
                      prim_amt,
                      secdy_amt,
                      codigo_recurso,
                      vendor_id_rec,
                      vendor_loc_code_rec,
                      user_id_created_icr
                     )
              VALUES (v_payable_entity_id_icr,
                      v_contract_id_icr,
                      v_contract_versao_icr,
                      v_seq_item,
                      v_codigo_resumo_valor,
                      v_tipo_cronograma,
                      v_numero_parcela,
                      v_vendor_id,
                      v_vendor_loc_code,
                      v_tipo_valor,
                      v_data_vencto,
                      v_prim_amt,
                      v_secdy_amt,
                      v_codigo_recurso,
                      v_vendor_id_rec,
                      v_vendor_loc_code_rec,
                      v_user_id_created_icr
                     );

         IF SQL%ROWCOUNT = 1 THEN
            stp_pesquisa_conf_item_cronogr (p_usuario,
                                            vo_payable_entity_id_icr,
                                            vo_contract_id_icr,
                                            vo_contract_versao_icr,
                                            vo_seq_item,
                                            vo_codigo_resumo_valor,
                                            vo_tipo_cronograma,
                                            vo_numero_parcela,
                                            vo_vendor_id,
                                            vo_vendor_loc_code,
                                            vo_tipo_valor,
                                            vo_data_vencto,
                                            vo_prim_amt,
                                            vo_secdy_amt,
                                            vo_codigo_recurso,
                                            vo_vendor_id_rec,
                                            vo_vendor_loc_code_rec,
                                            vo_sistema_origem_code_icr,
                                            vo_contract_versao_origem_icr,
                                            vo_date_created_icr,
                                            vo_user_id_created_icr,
                                            vo_date_changed_icr,
                                            vo_user_id_changed_icr,
                                            vo_inactive_ind_icr,
                                            vo_active_date_icr,
                                            v_payable_entity_id_icr,
                                            v_contract_id_icr,
                                            v_contract_versao_icr,
                                            v_seq_item,
                                            v_codigo_resumo_valor,
                                            v_numero_parcela
                                           );
            v_dado :=
               'payable_entity_id_icr = '
               || RTRIM (LTRIM (v_payable_entity_id_icr));
            v_dado :=
               v_dado
               || ','
               || 'contract_id_icr = '
               || RTRIM (LTRIM (v_contract_id_icr));
            v_dado :=
               v_dado
               || ','
               || 'contract_versao_icr = '
               || RTRIM (LTRIM (v_contract_versao_icr));
            v_dado :=
                  v_dado || ',' || 'seq_item = ' || RTRIM (LTRIM (v_seq_item));
            v_dado :=
               v_dado
               || ','
               || 'codigo_resumo_valor = '
               || RTRIM (LTRIM (v_codigo_resumo_valor));
            v_dado :=
               v_dado
               || ','
               || 'tipo_cronograma = '
               || RTRIM (LTRIM (v_tipo_cronograma));
            v_dado :=
               v_dado
               || ','
               || 'numero_parcela = '
               || RTRIM (LTRIM (v_numero_parcela));
            v_dado :=
                v_dado || ',' || 'vendor_id = ' || RTRIM (LTRIM (v_vendor_id));
            v_dado :=
               v_dado
               || ','
               || 'vendor_loc_code = '
               || RTRIM (LTRIM (v_vendor_loc_code));
            v_dado :=
               v_dado || ',' || 'tipo_valor = '
               || RTRIM (LTRIM (v_tipo_valor));
            v_dado :=
               v_dado
               || ','
               || 'data_vencto = '
               || TO_CHAR (v_data_vencto, 'DD/MM/YYYY');
            v_dado := v_dado || ',' || 'prim_amt = ' || TO_CHAR (v_prim_amt);
            v_dado := v_dado || ',' || 'secdy_amt = ' || TO_CHAR (v_secdy_amt);
            v_dado :=
               v_dado
               || ','
               || 'codigo_recurso = '
               || RTRIM (LTRIM (v_codigo_recurso));
            v_dado :=
               v_dado
               || ','
               || 'vendor_id_rec = '
               || RTRIM (LTRIM (v_vendor_id_rec));
            v_dado :=
               v_dado
               || ','
               || 'vendor_loc_code_rec = '
               || RTRIM (LTRIM (v_vendor_loc_code_rec));
            v_dado :=
               v_dado
               || ','
               || 'user_id_created_icr = '
               || RTRIM (LTRIM (v_user_id_created_icr));
            -- LOG
            ifrseg.pck_seguranca.stp_log (p_usuario,
                                          'VIW_CONF_ITEM_CRONOGRAMA_U',
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
-- Altera Cronograma Desembolso Reajuste
-- retorna o recordset correspondente
   PROCEDURE stp_altera_conf_item_cronogram (
      p_usuario                  IN       VARCHAR2,
      vo_payable_entity_id_icr   OUT      tyt_payable_entity_id_icr,
      vo_contract_id_icr         OUT      tyt_contract_id_icr,
      vo_contract_versao_icr     OUT      tyt_contract_versao_icr,
      vo_seq_item                OUT      tyt_seq_item,
      vo_codigo_resumo_valor     OUT      tyt_codigo_resumo_valor,
      vo_tipo_cronograma         OUT      tyt_tipo_cronograma,
      vo_numero_parcela          OUT      tyt_numero_parcela,
      vo_vendor_id               OUT      tyt_vendor_id,
      vo_vendor_loc_code         OUT      tyt_vendor_loc_code,
      vo_tipo_valor              OUT      tyt_tipo_valor,
      vo_data_vencto             OUT      tyt_data_vencto,
      vo_prim_amt                OUT      tyt_prim_amt,
      vo_secdy_amt               OUT      tyt_secdy_amt,
      vo_codigo_recurso          OUT      tyt_codigo_recurso,
      vo_vendor_id_rec           OUT      tyt_vendor_id_rec,
      vo_vendor_loc_code_rec     OUT      tyt_vendor_loc_code_rec,
      vo_sistema_origem_code_icr OUT      tyt_sistema_origem_code_icr,
      vo_contract_versao_origem_icr OUT   tyt_contract_versao_origem_icr,
      vo_date_created_icr        OUT      tyt_date_created_icr,
      vo_user_id_created_icr     OUT      tyt_user_id_created_icr,
      vo_date_changed_icr        OUT      tyt_date_changed_icr,
      vo_user_id_changed_icr     OUT      tyt_user_id_changed_icr,
      vo_inactive_ind_icr        OUT      tyt_inactive_ind_icr,
      vo_active_date_icr         OUT      tyt_active_date_icr,
      vi_payable_entity_id_icr   IN       t_payable_entity_id_icr,
      vi_contract_id_icr         IN       t_contract_id_icr,
      vi_contract_versao_icr     IN       t_contract_versao_icr,
      vi_seq_item                IN       t_seq_item,
      vi_codigo_resumo_valor     IN       t_codigo_resumo_valor,
      vi_tipo_cronograma         IN       t_tipo_cronograma,
      vi_numero_parcela          IN       t_numero_parcela,
      vi_vendor_id               IN       t_vendor_id,
      vi_vendor_loc_code         IN       t_vendor_loc_code,
      vi_tipo_valor              IN       t_tipo_valor,
      vi_data_vencto             IN       t_data_vencto,
      vi_prim_amt                IN       t_prim_amt,
      vi_secdy_amt               IN       t_secdy_amt,
      vi_codigo_recurso          IN       t_codigo_recurso,
      vi_vendor_id_rec           IN       t_vendor_id_rec,
      vi_vendor_loc_code_rec     IN       t_vendor_loc_code_rec,
      vi_user_id_created_icr     IN       t_user_id_created_icr
   ) AS
      CURSOR c_cursor IS
         SELECT     *
               FROM ifrbde.viw_conf_item_cronograma_u
              WHERE payable_entity_id_icr = vi_payable_entity_id_icr
                AND contract_id_icr = vi_contract_id_icr
                AND contract_versao_icr = vi_contract_versao_icr
                AND seq_item = vi_seq_item
                AND codigo_resumo_valor = vi_codigo_resumo_valor
                AND numero_parcela = vi_numero_parcela
         FOR UPDATE;

      v_viw_conf_item_cronograma_u  ifrbde.viw_conf_item_cronograma_u%ROWTYPE;
      v_payable_entity_id_icr       ifrbde.viw_conf_item_cronograma_u.payable_entity_id_icr%TYPE;
      v_contract_id_icr             ifrbde.viw_conf_item_cronograma_u.contract_id_icr%TYPE;
      v_contract_versao_icr         ifrbde.viw_conf_item_cronograma_u.contract_versao_icr%TYPE;
      v_seq_item                    ifrbde.viw_conf_item_cronograma_u.seq_item%TYPE;
      v_codigo_resumo_valor         ifrbde.viw_conf_item_cronograma_u.codigo_resumo_valor%TYPE;
      v_tipo_cronograma             ifrbde.viw_conf_item_cronograma_u.tipo_cronograma%TYPE;
      v_numero_parcela              ifrbde.viw_conf_item_cronograma_u.numero_parcela%TYPE;
      v_vendor_id                   ifrbde.viw_conf_item_cronograma_u.vendor_id%TYPE;
      v_vendor_loc_code             ifrbde.viw_conf_item_cronograma_u.vendor_loc_code%TYPE;
      v_tipo_valor                  ifrbde.viw_conf_item_cronograma_u.tipo_valor%TYPE;
      v_data_vencto                 ifrbde.viw_conf_item_cronograma_u.data_vencto%TYPE;
      v_prim_amt                    ifrbde.viw_conf_item_cronograma_u.prim_amt%TYPE;
      v_secdy_amt                   ifrbde.viw_conf_item_cronograma_u.secdy_amt%TYPE;
      v_codigo_recurso              ifrbde.viw_conf_item_cronograma_u.codigo_recurso%TYPE;
      v_vendor_id_rec               ifrbde.viw_conf_item_cronograma_u.vendor_id_rec%TYPE;
      v_vendor_loc_code_rec         ifrbde.viw_conf_item_cronograma_u.vendor_loc_code_rec%TYPE;
      v_user_id_created_icr         ifrbde.viw_conf_item_cronograma_u.user_id_created_icr%TYPE;
      v_dado                        VARCHAR2 (4000) := NULL;
   BEGIN
      IF ifrseg.pck_seguranca.stf_permitido (p_usuario,
                                             'VIW_CONF_ITEM_CRONOGRAMA_U',
                                             'ALTERA'
                                            ) THEN
         OPEN c_cursor;

         FETCH c_cursor
          INTO v_viw_conf_item_cronograma_u;

         IF NOT c_cursor%NOTFOUND THEN
            v_payable_entity_id_icr :=
                                     RTRIM (LTRIM (vi_payable_entity_id_icr));
            v_contract_id_icr := RTRIM (LTRIM (vi_contract_id_icr));
            v_contract_versao_icr := RTRIM (LTRIM (vi_contract_versao_icr));
            v_seq_item := RTRIM (LTRIM (vi_seq_item));
            v_codigo_resumo_valor := RTRIM (LTRIM (vi_codigo_resumo_valor));
            v_tipo_cronograma := RTRIM (LTRIM (vi_tipo_cronograma));
            v_numero_parcela := RTRIM (LTRIM (vi_numero_parcela));
            v_vendor_id := RTRIM (LTRIM (vi_vendor_id));
            v_vendor_loc_code := RTRIM (LTRIM (vi_vendor_loc_code));
            v_tipo_valor := RTRIM (LTRIM (vi_tipo_valor));
            v_codigo_recurso := RTRIM (LTRIM (vi_codigo_recurso));
            v_vendor_id_rec := RTRIM (LTRIM (vi_vendor_id_rec));
            v_vendor_loc_code_rec := RTRIM (LTRIM (vi_vendor_loc_code_rec));
            v_user_id_created_icr := RTRIM (LTRIM (vi_user_id_created_icr));
            v_data_vencto := TO_DATE (vi_data_vencto, 'DD/MM/YYYY');
            v_prim_amt := vi_prim_amt;
            v_secdy_amt := vi_secdy_amt;

            UPDATE ifrbde.viw_conf_item_cronograma_u
               SET tipo_cronograma = v_tipo_cronograma,
                   vendor_id = v_vendor_id,
                   vendor_loc_code = v_vendor_loc_code,
                   tipo_valor = v_tipo_valor,
                   data_vencto = v_data_vencto,
                   prim_amt = v_prim_amt,
                   secdy_amt = v_secdy_amt,
                   codigo_recurso = v_codigo_recurso,
                   vendor_id_rec = v_vendor_id_rec,
                   vendor_loc_code_rec = v_vendor_loc_code_rec,
                   user_id_created_icr = v_user_id_created_icr
             WHERE CURRENT OF c_cursor;

            IF SQL%ROWCOUNT = 1 THEN
               stp_pesquisa_conf_item_cronogr (p_usuario,
                                               vo_payable_entity_id_icr,
                                               vo_contract_id_icr,
                                               vo_contract_versao_icr,
                                               vo_seq_item,
                                               vo_codigo_resumo_valor,
                                               vo_tipo_cronograma,
                                               vo_numero_parcela,
                                               vo_vendor_id,
                                               vo_vendor_loc_code,
                                               vo_tipo_valor,
                                               vo_data_vencto,
                                               vo_prim_amt,
                                               vo_secdy_amt,
                                               vo_codigo_recurso,
                                               vo_vendor_id_rec,
                                               vo_vendor_loc_code_rec,
                                               vo_sistema_origem_code_icr,
                                               vo_contract_versao_origem_icr,
                                               vo_date_created_icr,
                                               vo_user_id_created_icr,
                                               vo_date_changed_icr,
                                               vo_user_id_changed_icr,
                                               vo_inactive_ind_icr,
                                               vo_active_date_icr,
                                               vi_payable_entity_id_icr,
                                               vi_contract_id_icr,
                                               vi_contract_versao_icr,
                                               vi_seq_item,
                                               vi_codigo_resumo_valor,
                                               vi_numero_parcela
                                              );
               v_dado :=
                  'payable_entity_id_icr = '
                  || RTRIM (LTRIM (v_payable_entity_id_icr));
               v_dado :=
                  v_dado
                  || ','
                  || 'contract_id_icr = '
                  || RTRIM (LTRIM (v_contract_id_icr));
               v_dado :=
                  v_dado
                  || ','
                  || 'contract_versao_icr = '
                  || RTRIM (LTRIM (v_contract_versao_icr));
               v_dado :=
                  v_dado || ',' || 'seq_item = ' || RTRIM (LTRIM (v_seq_item));
               v_dado :=
                  v_dado
                  || ','
                  || 'codigo_resumo_valor = '
                  || RTRIM (LTRIM (v_codigo_resumo_valor));
               v_dado :=
                  v_dado
                  || ','
                  || 'tipo_cronograma = '
                  || RTRIM (LTRIM (v_tipo_cronograma));
               v_dado :=
                  v_dado
                  || ','
                  || 'numero_parcela = '
                  || RTRIM (LTRIM (v_numero_parcela));
               v_dado :=
                  v_dado || ',' || 'vendor_id = '
                  || RTRIM (LTRIM (v_vendor_id));
               v_dado :=
                  v_dado
                  || ','
                  || 'vendor_loc_code = '
                  || RTRIM (LTRIM (v_vendor_loc_code));
               v_dado :=
                  v_dado
                  || ','
                  || 'tipo_valor = '
                  || RTRIM (LTRIM (v_tipo_valor));
               v_dado :=
                  v_dado
                  || ','
                  || 'data_vencto = '
                  || TO_CHAR (v_data_vencto, 'DD/MM/YYYY');
               v_dado :=
                        v_dado || ',' || 'prim_amt = ' || TO_CHAR (v_prim_amt);
               v_dado :=
                      v_dado || ',' || 'secdy_amt = ' || TO_CHAR (v_secdy_amt);
               v_dado :=
                  v_dado
                  || ','
                  || 'codigo_recurso = '
                  || RTRIM (LTRIM (v_codigo_recurso));
               v_dado :=
                  v_dado
                  || ','
                  || 'vendor_id_rec = '
                  || RTRIM (LTRIM (v_vendor_id_rec));
               v_dado :=
                  v_dado
                  || ','
                  || 'vendor_loc_code_rec = '
                  || RTRIM (LTRIM (v_vendor_loc_code_rec));
               v_dado :=
                  v_dado
                  || ','
                  || 'user_id_created_icr = '
                  || RTRIM (LTRIM (v_user_id_created_icr));
               -- LOG
               ifrseg.pck_seguranca.stp_log (p_usuario,
                                             'VIW_CONF_ITEM_CRONOGRAMA_U',
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
-- Pesquisa SP - Valores
-- retorna o recordset correspondente
   PROCEDURE stp_pesquisa_conf_sol_pag_val_ (
      p_usuario                  IN       VARCHAR2,
      vo_payable_entity_id_spv   OUT      tyt_payable_entity_id_spv,
      vo_contract_id_spv         OUT      tyt_contract_id_spv,
      vo_contract_versao_spv     OUT      tyt_contract_versao_spv,
      vo_vendor_id               OUT      tyt_vendor_id,
      vo_vendor_loc_code         OUT      tyt_vendor_loc_code,
      vo_pmt_rqst_nbr            OUT      tyt_pmt_rqst_nbr,
      vo_pmt_rqst_date           OUT      tyt_pmt_rqst_date,
      vo_schld_pmt_nbr           OUT      tyt_schld_pmt_nbr,
      vo_seq_item                OUT      tyt_seq_item,
      vo_codigo_resumo_valor     OUT      tyt_codigo_resumo_valor,
      vo_tipo_cronograma         OUT      tyt_tipo_cronograma,
      vo_numero_parcela          OUT      tyt_numero_parcela,
      vo_prim_amt                OUT      tyt_prim_amt,
      vo_secdy_amt               OUT      tyt_secdy_amt,
      vo_sistema_origem_code_spv OUT      tyt_sistema_origem_code_spv,
      vo_contract_versao_origem_spv OUT   tyt_contract_versao_origem_spv,
      vo_date_created_spv        OUT      tyt_date_created_spv,
      vo_user_id_created_spv     OUT      tyt_user_id_created_spv,
      vo_date_changed_spv        OUT      tyt_date_changed_spv,
      vo_user_id_changed_spv     OUT      tyt_user_id_changed_spv,
      vo_inactive_ind_spv        OUT      tyt_inactive_ind_spv,
      vo_active_date_spv         OUT      tyt_active_date_spv,
      vi_payable_entity_id_spv   IN       t_payable_entity_id_spv,
      vi_contract_id_spv         IN       t_contract_id_spv,
      vi_contract_versao_spv     IN       t_contract_versao_spv,
      vi_vendor_id               IN       t_vendor_id,
      vi_vendor_loc_code         IN       t_vendor_loc_code,
      vi_pmt_rqst_nbr            IN       t_pmt_rqst_nbr
   ) AS
   BEGIN
      IF ifrseg.pck_seguranca.stf_permitido (p_usuario,
                                             'VIW_CONF_SOL_PAG_VAL_U',
                                             'PESQUISA'
                                            ) THEN
         SELECT payable_entity_id_spv,
                contract_id_spv,
                contract_versao_spv,
                vendor_id,
                vendor_loc_code,
                pmt_rqst_nbr,
                pmt_rqst_date,
                schld_pmt_nbr,
                seq_item,
                codigo_resumo_valor,
                tipo_cronograma,
                numero_parcela,
                prim_amt,
                secdy_amt,
                sistema_origem_code_spv,
                contract_versao_origem_spv,
                date_created_spv,
                user_id_created_spv,
                date_changed_spv,
                user_id_changed_spv,
                inactive_ind_spv,
                active_date_spv
           INTO vo_payable_entity_id_spv (1),
                vo_contract_id_spv (1),
                vo_contract_versao_spv (1),
                vo_vendor_id (1),
                vo_vendor_loc_code (1),
                vo_pmt_rqst_nbr (1),
                vo_pmt_rqst_date (1),
                vo_schld_pmt_nbr (1),
                vo_seq_item (1),
                vo_codigo_resumo_valor (1),
                vo_tipo_cronograma (1),
                vo_numero_parcela (1),
                vo_prim_amt (1),
                vo_secdy_amt (1),
                vo_sistema_origem_code_spv (1),
                vo_contract_versao_origem_spv (1),
                vo_date_created_spv (1),
                vo_user_id_created_spv (1),
                vo_date_changed_spv (1),
                vo_user_id_changed_spv (1),
                vo_inactive_ind_spv (1),
                vo_active_date_spv (1)
           FROM ifrbde.viw_conf_sol_pag_val_u
          WHERE payable_entity_id_spv = vi_payable_entity_id_spv
            AND contract_id_spv = vi_contract_id_spv
            AND contract_versao_spv = vi_contract_versao_spv
            AND vendor_id = vi_vendor_id
            AND vendor_loc_code = vi_vendor_loc_code
            AND pmt_rqst_nbr = vi_pmt_rqst_nbr;
      END IF;
   EXCEPTION
      WHEN OTHERS THEN
         raise_application_error (-20100, SQLERRM);
   END;

   -- Exclui SP - Valores
   -- retorna o OK ou não
   PROCEDURE stp_exclui_conf_sol_pag_val_u (
      p_usuario                  IN       VARCHAR2,
      vo_ok                      OUT      tyt_ok,
      vi_payable_entity_id_spv   IN       t_payable_entity_id_spv,
      vi_contract_id_spv         IN       t_contract_id_spv,
      vi_contract_versao_spv     IN       t_contract_versao_spv,
      vi_vendor_id               IN       t_vendor_id,
      vi_vendor_loc_code         IN       t_vendor_loc_code,
      vi_pmt_rqst_nbr            IN       t_pmt_rqst_nbr
   ) AS
      CURSOR c_cursor IS
         SELECT     *
               FROM ifrbde.viw_conf_sol_pag_val_u
              WHERE payable_entity_id_spv = vi_payable_entity_id_spv
                AND contract_id_spv = vi_contract_id_spv
                AND contract_versao_spv = vi_contract_versao_spv
                AND vendor_id = vi_vendor_id
                AND vendor_loc_code = vi_vendor_loc_code
                AND pmt_rqst_nbr = vi_pmt_rqst_nbr
         FOR UPDATE;

      v_viw_conf_sol_pag_val_u      ifrbde.viw_conf_sol_pag_val_u%ROWTYPE;
      v_dado                        VARCHAR2 (4000) := NULL;
   BEGIN
      vo_ok (1) := 0;

      IF ifrseg.pck_seguranca.stf_permitido (p_usuario,
                                             'VIW_CONF_SOL_PAG_VAL_U',
                                             'EXCLUI'
                                            ) THEN
         OPEN c_cursor;

         FETCH c_cursor
          INTO v_viw_conf_sol_pag_val_u;

         IF NOT c_cursor%NOTFOUND THEN
            v_dado :=
               'payable_entity_id_spv = '
               || RTRIM
                    (LTRIM
                        (UPPER (v_viw_conf_sol_pag_val_u.payable_entity_id_spv)
                        )
                    );
            v_dado :=
               v_dado
               || ','
               || 'contract_id_spv = '
               || RTRIM
                       (LTRIM (UPPER (v_viw_conf_sol_pag_val_u.contract_id_spv)
                              )
                       );
            v_dado :=
               v_dado
               || ','
               || 'contract_versao_spv = '
               || RTRIM
                    (LTRIM
                          (UPPER (v_viw_conf_sol_pag_val_u.contract_versao_spv)
                          )
                    );
            v_dado :=
               v_dado
               || ','
               || 'vendor_id = '
               || RTRIM (LTRIM (UPPER (v_viw_conf_sol_pag_val_u.vendor_id)));
            v_dado :=
               v_dado
               || ','
               || 'vendor_loc_code = '
               || RTRIM
                       (LTRIM (UPPER (v_viw_conf_sol_pag_val_u.vendor_loc_code)
                              )
                       );
            v_dado :=
               v_dado
               || ','
               || 'pmt_rqst_nbr = '
               || RTRIM (LTRIM (UPPER (v_viw_conf_sol_pag_val_u.pmt_rqst_nbr)));
            v_dado :=
               v_dado
               || ','
               || 'pmt_rqst_date = '
               || TO_DATE (v_viw_conf_sol_pag_val_u.pmt_rqst_date,
                           'DD/MM/YYYY'
                          );
            v_dado :=
               v_dado
               || ','
               || 'schld_pmt_nbr = '
               || TO_CHAR (v_viw_conf_sol_pag_val_u.schld_pmt_nbr);
            v_dado :=
               v_dado
               || ','
               || 'seq_item = '
               || RTRIM (LTRIM (UPPER (v_viw_conf_sol_pag_val_u.seq_item)));
            v_dado :=
               v_dado
               || ','
               || 'codigo_resumo_valor = '
               || RTRIM
                    (LTRIM
                          (UPPER (v_viw_conf_sol_pag_val_u.codigo_resumo_valor)
                          )
                    );
            v_dado :=
               v_dado
               || ','
               || 'tipo_cronograma = '
               || RTRIM
                       (LTRIM (UPPER (v_viw_conf_sol_pag_val_u.tipo_cronograma)
                              )
                       );
            v_dado :=
               v_dado
               || ','
               || 'numero_parcela = '
               || RTRIM (LTRIM (UPPER (v_viw_conf_sol_pag_val_u.numero_parcela)
                               )
                        );
            v_dado :=
               v_dado
               || ','
               || 'prim_amt = '
               || TO_CHAR (v_viw_conf_sol_pag_val_u.prim_amt);
            v_dado :=
               v_dado
               || ','
               || 'secdy_amt = '
               || TO_CHAR (v_viw_conf_sol_pag_val_u.secdy_amt);
            v_dado :=
               v_dado
               || ','
               || 'sistema_origem_code_spv = '
               || RTRIM
                    (LTRIM
                        (UPPER
                             (v_viw_conf_sol_pag_val_u.sistema_origem_code_spv)
                        )
                    );
            v_dado :=
               v_dado
               || ','
               || 'contract_versao_origem_spv = '
               || RTRIM
                    (LTRIM
                        (UPPER
                            (v_viw_conf_sol_pag_val_u.contract_versao_origem_spv
                            )
                        )
                    );
            v_dado :=
               v_dado
               || ','
               || 'date_created_spv = '
               || TO_DATE (v_viw_conf_sol_pag_val_u.date_created_spv,
                           'DD/MM/YYYY'
                          );
            v_dado :=
               v_dado
               || ','
               || 'user_id_created_spv = '
               || RTRIM
                    (LTRIM
                          (UPPER (v_viw_conf_sol_pag_val_u.user_id_created_spv)
                          )
                    );
            v_dado :=
               v_dado
               || ','
               || 'date_changed_spv = '
               || TO_DATE (v_viw_conf_sol_pag_val_u.date_changed_spv,
                           'DD/MM/YYYY'
                          );
            v_dado :=
               v_dado
               || ','
               || 'user_id_changed_spv = '
               || RTRIM
                    (LTRIM
                          (UPPER (v_viw_conf_sol_pag_val_u.user_id_changed_spv)
                          )
                    );
            v_dado :=
               v_dado
               || ','
               || 'inactive_ind_spv = '
               || RTRIM
                      (LTRIM (UPPER (v_viw_conf_sol_pag_val_u.inactive_ind_spv)
                             )
                      );
            v_dado :=
               v_dado
               || ','
               || 'active_date_spv = '
               || TO_DATE (v_viw_conf_sol_pag_val_u.active_date_spv,
                           'DD/MM/YYYY'
                          );

            IF c_cursor%ROWCOUNT = 1 THEN
               vo_ok (1) := 1;
               -- LOG
               ifrseg.pck_seguranca.stp_log (p_usuario,
                                             'VIW_CONF_SOL_PAG_VAL_U',
                                             'E',
                                             v_dado
                                            );

               DELETE FROM ifrbde.viw_conf_sol_pag_val_u
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
-- Inclui SP - Valores
-- retorna o recordset correspondente
   PROCEDURE stp_inclui_conf_sol_pag_val_u (
      p_usuario                  IN       VARCHAR2,
      vo_payable_entity_id_spv   OUT      tyt_payable_entity_id_spv,
      vo_contract_id_spv         OUT      tyt_contract_id_spv,
      vo_contract_versao_spv     OUT      tyt_contract_versao_spv,
      vo_vendor_id               OUT      tyt_vendor_id,
      vo_vendor_loc_code         OUT      tyt_vendor_loc_code,
      vo_pmt_rqst_nbr            OUT      tyt_pmt_rqst_nbr,
      vo_pmt_rqst_date           OUT      tyt_pmt_rqst_date,
      vo_schld_pmt_nbr           OUT      tyt_schld_pmt_nbr,
      vo_seq_item                OUT      tyt_seq_item,
      vo_codigo_resumo_valor     OUT      tyt_codigo_resumo_valor,
      vo_tipo_cronograma         OUT      tyt_tipo_cronograma,
      vo_numero_parcela          OUT      tyt_numero_parcela,
      vo_prim_amt                OUT      tyt_prim_amt,
      vo_secdy_amt               OUT      tyt_secdy_amt,
      vo_sistema_origem_code_spv OUT      tyt_sistema_origem_code_spv,
      vo_contract_versao_origem_spv OUT   tyt_contract_versao_origem_spv,
      vo_date_created_spv        OUT      tyt_date_created_spv,
      vo_user_id_created_spv     OUT      tyt_user_id_created_spv,
      vo_date_changed_spv        OUT      tyt_date_changed_spv,
      vo_user_id_changed_spv     OUT      tyt_user_id_changed_spv,
      vo_inactive_ind_spv        OUT      tyt_inactive_ind_spv,
      vo_active_date_spv         OUT      tyt_active_date_spv,
      vi_payable_entity_id_spv   IN       t_payable_entity_id_spv,
      vi_contract_id_spv         IN       t_contract_id_spv,
      vi_contract_versao_spv     IN       t_contract_versao_spv,
      vi_vendor_id               IN       t_vendor_id,
      vi_vendor_loc_code         IN       t_vendor_loc_code,
      vi_pmt_rqst_nbr            IN       t_pmt_rqst_nbr,
      vi_pmt_rqst_date           IN       t_pmt_rqst_date,
      vi_schld_pmt_nbr           IN       t_schld_pmt_nbr,
      vi_seq_item                IN       t_seq_item,
      vi_codigo_resumo_valor     IN       t_codigo_resumo_valor,
      vi_tipo_cronograma         IN       t_tipo_cronograma,
      vi_numero_parcela          IN       t_numero_parcela,
      vi_prim_amt                IN       t_prim_amt,
      vi_secdy_amt               IN       t_secdy_amt,
      vi_user_id_created_spv     IN       t_user_id_created_spv
   ) AS
      v_payable_entity_id_spv       viw_conf_sol_pag_val_u.payable_entity_id_spv%TYPE;
      v_contract_id_spv             viw_conf_sol_pag_val_u.contract_id_spv%TYPE;
      v_contract_versao_spv         viw_conf_sol_pag_val_u.contract_versao_spv%TYPE;
      v_vendor_id                   viw_conf_sol_pag_val_u.vendor_id%TYPE;
      v_vendor_loc_code             viw_conf_sol_pag_val_u.vendor_loc_code%TYPE;
      v_pmt_rqst_nbr                viw_conf_sol_pag_val_u.pmt_rqst_nbr%TYPE;
      v_pmt_rqst_date               viw_conf_sol_pag_val_u.pmt_rqst_date%TYPE;
      v_schld_pmt_nbr               viw_conf_sol_pag_val_u.schld_pmt_nbr%TYPE;
      v_seq_item                    viw_conf_sol_pag_val_u.seq_item%TYPE;
      v_codigo_resumo_valor         viw_conf_sol_pag_val_u.codigo_resumo_valor%TYPE;
      v_tipo_cronograma             viw_conf_sol_pag_val_u.tipo_cronograma%TYPE;
      v_numero_parcela              viw_conf_sol_pag_val_u.numero_parcela%TYPE;
      v_prim_amt                    viw_conf_sol_pag_val_u.prim_amt%TYPE;
      v_secdy_amt                   viw_conf_sol_pag_val_u.secdy_amt%TYPE;
      v_user_id_created_spv         viw_conf_sol_pag_val_u.user_id_created_spv%TYPE;
      v_dado                        VARCHAR2 (4000) := NULL;
   BEGIN
      IF ifrseg.pck_seguranca.stf_permitido (p_usuario,
                                             'VIW_CONF_SOL_PAG_VAL_U',
                                             'INCLUI'
                                            ) THEN
         v_payable_entity_id_spv := RTRIM (LTRIM (vi_payable_entity_id_spv));
         v_contract_id_spv := RTRIM (LTRIM (vi_contract_id_spv));
         v_contract_versao_spv := RTRIM (LTRIM (vi_contract_versao_spv));
         v_vendor_id := RTRIM (LTRIM (vi_vendor_id));
         v_vendor_loc_code := RTRIM (LTRIM (vi_vendor_loc_code));
         v_pmt_rqst_nbr := RTRIM (LTRIM (vi_pmt_rqst_nbr));
         v_seq_item := RTRIM (LTRIM (vi_seq_item));
         v_codigo_resumo_valor := RTRIM (LTRIM (vi_codigo_resumo_valor));
         v_tipo_cronograma := RTRIM (LTRIM (vi_tipo_cronograma));
         v_numero_parcela := RTRIM (LTRIM (vi_numero_parcela));
         v_user_id_created_spv := RTRIM (LTRIM (vi_user_id_created_spv));
         v_pmt_rqst_date := TO_DATE (vi_pmt_rqst_date, 'DD/MM/YYYY');
         v_schld_pmt_nbr := vi_schld_pmt_nbr;
         v_prim_amt := vi_prim_amt;
         v_secdy_amt := vi_secdy_amt;

         INSERT INTO ifrbde.viw_conf_sol_pag_val_u
                     (payable_entity_id_spv,
                      contract_id_spv,
                      contract_versao_spv,
                      vendor_id,
                      vendor_loc_code,
                      pmt_rqst_nbr,
                      pmt_rqst_date,
                      schld_pmt_nbr,
                      seq_item,
                      codigo_resumo_valor,
                      tipo_cronograma,
                      numero_parcela,
                      prim_amt,
                      secdy_amt,
                      user_id_created_spv
                     )
              VALUES (v_payable_entity_id_spv,
                      v_contract_id_spv,
                      v_contract_versao_spv,
                      v_vendor_id,
                      v_vendor_loc_code,
                      v_pmt_rqst_nbr,
                      v_pmt_rqst_date,
                      v_schld_pmt_nbr,
                      v_seq_item,
                      v_codigo_resumo_valor,
                      v_tipo_cronograma,
                      v_numero_parcela,
                      v_prim_amt,
                      v_secdy_amt,
                      v_user_id_created_spv
                     );

         IF SQL%ROWCOUNT = 1 THEN
            stp_pesquisa_conf_sol_pag_val_ (p_usuario,
                                            vo_payable_entity_id_spv,
                                            vo_contract_id_spv,
                                            vo_contract_versao_spv,
                                            vo_vendor_id,
                                            vo_vendor_loc_code,
                                            vo_pmt_rqst_nbr,
                                            vo_pmt_rqst_date,
                                            vo_schld_pmt_nbr,
                                            vo_seq_item,
                                            vo_codigo_resumo_valor,
                                            vo_tipo_cronograma,
                                            vo_numero_parcela,
                                            vo_prim_amt,
                                            vo_secdy_amt,
                                            vo_sistema_origem_code_spv,
                                            vo_contract_versao_origem_spv,
                                            vo_date_created_spv,
                                            vo_user_id_created_spv,
                                            vo_date_changed_spv,
                                            vo_user_id_changed_spv,
                                            vo_inactive_ind_spv,
                                            vo_active_date_spv,
                                            v_payable_entity_id_spv,
                                            v_contract_id_spv,
                                            v_contract_versao_spv,
                                            v_vendor_id,
                                            v_vendor_loc_code,
                                            v_pmt_rqst_nbr
                                           );
            v_dado :=
               'payable_entity_id_spv = '
               || RTRIM (LTRIM (v_payable_entity_id_spv));
            v_dado :=
               v_dado
               || ','
               || 'contract_id_spv = '
               || RTRIM (LTRIM (v_contract_id_spv));
            v_dado :=
               v_dado
               || ','
               || 'contract_versao_spv = '
               || RTRIM (LTRIM (v_contract_versao_spv));
            v_dado :=
                v_dado || ',' || 'vendor_id = ' || RTRIM (LTRIM (v_vendor_id));
            v_dado :=
               v_dado
               || ','
               || 'vendor_loc_code = '
               || RTRIM (LTRIM (v_vendor_loc_code));
            v_dado :=
               v_dado
               || ','
               || 'pmt_rqst_nbr = '
               || RTRIM (LTRIM (v_pmt_rqst_nbr));
            v_dado :=
               v_dado
               || ','
               || 'pmt_rqst_date = '
               || TO_CHAR (v_pmt_rqst_date, 'DD/MM/YYYY');
            v_dado :=
               v_dado || ',' || 'schld_pmt_nbr = '
               || TO_CHAR (v_schld_pmt_nbr);
            v_dado :=
                  v_dado || ',' || 'seq_item = ' || RTRIM (LTRIM (v_seq_item));
            v_dado :=
               v_dado
               || ','
               || 'codigo_resumo_valor = '
               || RTRIM (LTRIM (v_codigo_resumo_valor));
            v_dado :=
               v_dado
               || ','
               || 'tipo_cronograma = '
               || RTRIM (LTRIM (v_tipo_cronograma));
            v_dado :=
               v_dado
               || ','
               || 'numero_parcela = '
               || RTRIM (LTRIM (v_numero_parcela));
            v_dado := v_dado || ',' || 'prim_amt = ' || TO_CHAR (v_prim_amt);
            v_dado := v_dado || ',' || 'secdy_amt = ' || TO_CHAR (v_secdy_amt);
            v_dado :=
               v_dado
               || ','
               || 'user_id_created_spv = '
               || RTRIM (LTRIM (v_user_id_created_spv));
            -- LOG
            ifrseg.pck_seguranca.stp_log (p_usuario,
                                          'VIW_CONF_SOL_PAG_VAL_U',
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
-- Altera SP - Valores
-- retorna o recordset correspondente
   PROCEDURE stp_altera_conf_sol_pag_val_u (
      p_usuario                  IN       VARCHAR2,
      vo_payable_entity_id_spv   OUT      tyt_payable_entity_id_spv,
      vo_contract_id_spv         OUT      tyt_contract_id_spv,
      vo_contract_versao_spv     OUT      tyt_contract_versao_spv,
      vo_vendor_id               OUT      tyt_vendor_id,
      vo_vendor_loc_code         OUT      tyt_vendor_loc_code,
      vo_pmt_rqst_nbr            OUT      tyt_pmt_rqst_nbr,
      vo_pmt_rqst_date           OUT      tyt_pmt_rqst_date,
      vo_schld_pmt_nbr           OUT      tyt_schld_pmt_nbr,
      vo_seq_item                OUT      tyt_seq_item,
      vo_codigo_resumo_valor     OUT      tyt_codigo_resumo_valor,
      vo_tipo_cronograma         OUT      tyt_tipo_cronograma,
      vo_numero_parcela          OUT      tyt_numero_parcela,
      vo_prim_amt                OUT      tyt_prim_amt,
      vo_secdy_amt               OUT      tyt_secdy_amt,
      vo_sistema_origem_code_spv OUT      tyt_sistema_origem_code_spv,
      vo_contract_versao_origem_spv OUT   tyt_contract_versao_origem_spv,
      vo_date_created_spv        OUT      tyt_date_created_spv,
      vo_user_id_created_spv     OUT      tyt_user_id_created_spv,
      vo_date_changed_spv        OUT      tyt_date_changed_spv,
      vo_user_id_changed_spv     OUT      tyt_user_id_changed_spv,
      vo_inactive_ind_spv        OUT      tyt_inactive_ind_spv,
      vo_active_date_spv         OUT      tyt_active_date_spv,
      vi_payable_entity_id_spv   IN       t_payable_entity_id_spv,
      vi_contract_id_spv         IN       t_contract_id_spv,
      vi_contract_versao_spv     IN       t_contract_versao_spv,
      vi_vendor_id               IN       t_vendor_id,
      vi_vendor_loc_code         IN       t_vendor_loc_code,
      vi_pmt_rqst_nbr            IN       t_pmt_rqst_nbr,
      vi_pmt_rqst_date           IN       t_pmt_rqst_date,
      vi_schld_pmt_nbr           IN       t_schld_pmt_nbr,
      vi_seq_item                IN       t_seq_item,
      vi_codigo_resumo_valor     IN       t_codigo_resumo_valor,
      vi_tipo_cronograma         IN       t_tipo_cronograma,
      vi_numero_parcela          IN       t_numero_parcela,
      vi_prim_amt                IN       t_prim_amt,
      vi_secdy_amt               IN       t_secdy_amt,
      vi_user_id_created_spv     IN       t_user_id_created_spv
   ) AS
      CURSOR c_cursor IS
         SELECT     *
               FROM ifrbde.viw_conf_sol_pag_val_u
              WHERE payable_entity_id_spv = vi_payable_entity_id_spv
                AND contract_id_spv = vi_contract_id_spv
                AND contract_versao_spv = vi_contract_versao_spv
                AND vendor_id = vi_vendor_id
                AND vendor_loc_code = vi_vendor_loc_code
                AND pmt_rqst_nbr = vi_pmt_rqst_nbr
         FOR UPDATE;

      v_viw_conf_sol_pag_val_u      ifrbde.viw_conf_sol_pag_val_u%ROWTYPE;
      v_payable_entity_id_spv       ifrbde.viw_conf_sol_pag_val_u.payable_entity_id_spv%TYPE;
      v_contract_id_spv             ifrbde.viw_conf_sol_pag_val_u.contract_id_spv%TYPE;
      v_contract_versao_spv         ifrbde.viw_conf_sol_pag_val_u.contract_versao_spv%TYPE;
      v_vendor_id                   ifrbde.viw_conf_sol_pag_val_u.vendor_id%TYPE;
      v_vendor_loc_code             ifrbde.viw_conf_sol_pag_val_u.vendor_loc_code%TYPE;
      v_pmt_rqst_nbr                ifrbde.viw_conf_sol_pag_val_u.pmt_rqst_nbr%TYPE;
      v_pmt_rqst_date               ifrbde.viw_conf_sol_pag_val_u.pmt_rqst_date%TYPE;
      v_schld_pmt_nbr               ifrbde.viw_conf_sol_pag_val_u.schld_pmt_nbr%TYPE;
      v_seq_item                    ifrbde.viw_conf_sol_pag_val_u.seq_item%TYPE;
      v_codigo_resumo_valor         ifrbde.viw_conf_sol_pag_val_u.codigo_resumo_valor%TYPE;
      v_tipo_cronograma             ifrbde.viw_conf_sol_pag_val_u.tipo_cronograma%TYPE;
      v_numero_parcela              ifrbde.viw_conf_sol_pag_val_u.numero_parcela%TYPE;
      v_prim_amt                    ifrbde.viw_conf_sol_pag_val_u.prim_amt%TYPE;
      v_secdy_amt                   ifrbde.viw_conf_sol_pag_val_u.secdy_amt%TYPE;
      v_user_id_created_spv         ifrbde.viw_conf_sol_pag_val_u.user_id_created_spv%TYPE;
      v_dado                        VARCHAR2 (4000) := NULL;
   BEGIN
      IF ifrseg.pck_seguranca.stf_permitido (p_usuario,
                                             'VIW_CONF_SOL_PAG_VAL_U',
                                             'ALTERA'
                                            ) THEN
         OPEN c_cursor;

         FETCH c_cursor
          INTO v_viw_conf_sol_pag_val_u;

         IF NOT c_cursor%NOTFOUND THEN
            v_payable_entity_id_spv :=
                                     RTRIM (LTRIM (vi_payable_entity_id_spv));
            v_contract_id_spv := RTRIM (LTRIM (vi_contract_id_spv));
            v_contract_versao_spv := RTRIM (LTRIM (vi_contract_versao_spv));
            v_vendor_id := RTRIM (LTRIM (vi_vendor_id));
            v_vendor_loc_code := RTRIM (LTRIM (vi_vendor_loc_code));
            v_pmt_rqst_nbr := RTRIM (LTRIM (vi_pmt_rqst_nbr));
            v_seq_item := RTRIM (LTRIM (vi_seq_item));
            v_codigo_resumo_valor := RTRIM (LTRIM (vi_codigo_resumo_valor));
            v_tipo_cronograma := RTRIM (LTRIM (vi_tipo_cronograma));
            v_numero_parcela := RTRIM (LTRIM (vi_numero_parcela));
            v_user_id_created_spv := RTRIM (LTRIM (vi_user_id_created_spv));
            v_pmt_rqst_date := TO_DATE (vi_pmt_rqst_date, 'DD/MM/YYYY');
            v_schld_pmt_nbr := vi_schld_pmt_nbr;
            v_prim_amt := vi_prim_amt;
            v_secdy_amt := vi_secdy_amt;

            UPDATE ifrbde.viw_conf_sol_pag_val_u
               SET pmt_rqst_date = v_pmt_rqst_date,
                   schld_pmt_nbr = v_schld_pmt_nbr,
                   seq_item = v_seq_item,
                   codigo_resumo_valor = v_codigo_resumo_valor,
                   tipo_cronograma = v_tipo_cronograma,
                   numero_parcela = v_numero_parcela,
                   prim_amt = v_prim_amt,
                   secdy_amt = v_secdy_amt,
                   user_id_created_spv = v_user_id_created_spv
             WHERE CURRENT OF c_cursor;

            IF SQL%ROWCOUNT = 1 THEN
               stp_pesquisa_conf_sol_pag_val_ (p_usuario,
                                               vo_payable_entity_id_spv,
                                               vo_contract_id_spv,
                                               vo_contract_versao_spv,
                                               vo_vendor_id,
                                               vo_vendor_loc_code,
                                               vo_pmt_rqst_nbr,
                                               vo_pmt_rqst_date,
                                               vo_schld_pmt_nbr,
                                               vo_seq_item,
                                               vo_codigo_resumo_valor,
                                               vo_tipo_cronograma,
                                               vo_numero_parcela,
                                               vo_prim_amt,
                                               vo_secdy_amt,
                                               vo_sistema_origem_code_spv,
                                               vo_contract_versao_origem_spv,
                                               vo_date_created_spv,
                                               vo_user_id_created_spv,
                                               vo_date_changed_spv,
                                               vo_user_id_changed_spv,
                                               vo_inactive_ind_spv,
                                               vo_active_date_spv,
                                               vi_payable_entity_id_spv,
                                               vi_contract_id_spv,
                                               vi_contract_versao_spv,
                                               vi_vendor_id,
                                               vi_vendor_loc_code,
                                               vi_pmt_rqst_nbr
                                              );
               v_dado :=
                  'payable_entity_id_spv = '
                  || RTRIM (LTRIM (v_payable_entity_id_spv));
               v_dado :=
                  v_dado
                  || ','
                  || 'contract_id_spv = '
                  || RTRIM (LTRIM (v_contract_id_spv));
               v_dado :=
                  v_dado
                  || ','
                  || 'contract_versao_spv = '
                  || RTRIM (LTRIM (v_contract_versao_spv));
               v_dado :=
                  v_dado || ',' || 'vendor_id = '
                  || RTRIM (LTRIM (v_vendor_id));
               v_dado :=
                  v_dado
                  || ','
                  || 'vendor_loc_code = '
                  || RTRIM (LTRIM (v_vendor_loc_code));
               v_dado :=
                  v_dado
                  || ','
                  || 'pmt_rqst_nbr = '
                  || RTRIM (LTRIM (v_pmt_rqst_nbr));
               v_dado :=
                  v_dado
                  || ','
                  || 'pmt_rqst_date = '
                  || TO_CHAR (v_pmt_rqst_date, 'DD/MM/YYYY');
               v_dado :=
                  v_dado
                  || ','
                  || 'schld_pmt_nbr = '
                  || TO_CHAR (v_schld_pmt_nbr);
               v_dado :=
                  v_dado || ',' || 'seq_item = ' || RTRIM (LTRIM (v_seq_item));
               v_dado :=
                  v_dado
                  || ','
                  || 'codigo_resumo_valor = '
                  || RTRIM (LTRIM (v_codigo_resumo_valor));
               v_dado :=
                  v_dado
                  || ','
                  || 'tipo_cronograma = '
                  || RTRIM (LTRIM (v_tipo_cronograma));
               v_dado :=
                  v_dado
                  || ','
                  || 'numero_parcela = '
                  || RTRIM (LTRIM (v_numero_parcela));
               v_dado :=
                        v_dado || ',' || 'prim_amt = ' || TO_CHAR (v_prim_amt);
               v_dado :=
                      v_dado || ',' || 'secdy_amt = ' || TO_CHAR (v_secdy_amt);
               v_dado :=
                  v_dado
                  || ','
                  || 'user_id_created_spv = '
                  || RTRIM (LTRIM (v_user_id_created_spv));
               -- LOG
               ifrseg.pck_seguranca.stp_log (p_usuario,
                                             'VIW_CONF_SOL_PAG_VAL_U',
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
-- Pesquisa SP - Acréscimos e Retenções
-- retorna o recordset correspondente
   PROCEDURE stp_pesquisa_conf_sol_pag_acr_ (
      p_usuario                  IN       VARCHAR2,
      vo_payable_entity_id_par   OUT      tyt_payable_entity_id_par,
      vo_contract_id_par         OUT      tyt_contract_id_par,
      vo_contract_versao_par     OUT      tyt_contract_versao_par,
      vo_vendor_id               OUT      tyt_vendor_id,
      vo_vendor_loc_code         OUT      tyt_vendor_loc_code,
      vo_pmt_rqst_nbr            OUT      tyt_pmt_rqst_nbr,
      vo_pmt_rqst_date           OUT      tyt_pmt_rqst_date,
      vo_schld_pmt_nbr           OUT      tyt_schld_pmt_nbr,
      vo_codigo_red_acres        OUT      tyt_codigo_red_acres,
      vo_trans_amt               OUT      tyt_trans_amt,
      vo_descp                   OUT      tyt_descp,
      vo_sistema_origem_code_par OUT      tyt_sistema_origem_code_par,
      vo_contract_versao_origem_par OUT   tyt_contract_versao_origem_par,
      vo_date_created_par        OUT      tyt_date_created_par,
      vo_user_id_created_par     OUT      tyt_user_id_created_par,
      vo_date_changed_par        OUT      tyt_date_changed_par,
      vo_user_id_changed_par     OUT      tyt_user_id_changed_par,
      vo_inactive_ind_par        OUT      tyt_inactive_ind_par,
      vo_active_date_par         OUT      tyt_active_date_par,
      vi_payable_entity_id_par   IN       t_payable_entity_id_par,
      vi_contract_id_par         IN       t_contract_id_par,
      vi_contract_versao_par     IN       t_contract_versao_par
   ) AS
   BEGIN
      IF ifrseg.pck_seguranca.stf_permitido (p_usuario,
                                             'VIW_CONF_SOL_PAG_ACR_RET_U',
                                             'PESQUISA'
                                            ) THEN
         SELECT payable_entity_id_par,
                contract_id_par,
                contract_versao_par,
                vendor_id,
                vendor_loc_code,
                pmt_rqst_nbr,
                pmt_rqst_date,
                schld_pmt_nbr,
                codigo_red_acres,
                trans_amt,
                descp,
                sistema_origem_code_par,
                contract_versao_origem_par,
                date_created_par,
                user_id_created_par,
                date_changed_par,
                user_id_changed_par,
                inactive_ind_par,
                active_date_par
           INTO vo_payable_entity_id_par (1),
                vo_contract_id_par (1),
                vo_contract_versao_par (1),
                vo_vendor_id (1),
                vo_vendor_loc_code (1),
                vo_pmt_rqst_nbr (1),
                vo_pmt_rqst_date (1),
                vo_schld_pmt_nbr (1),
                vo_codigo_red_acres (1),
                vo_trans_amt (1),
                vo_descp (1),
                vo_sistema_origem_code_par (1),
                vo_contract_versao_origem_par (1),
                vo_date_created_par (1),
                vo_user_id_created_par (1),
                vo_date_changed_par (1),
                vo_user_id_changed_par (1),
                vo_inactive_ind_par (1),
                vo_active_date_par (1)
           FROM ifrbde.viw_conf_sol_pag_acr_ret_u
          WHERE payable_entity_id_par = vi_payable_entity_id_par
            AND contract_id_par = vi_contract_id_par
            AND contract_versao_par = vi_contract_versao_par;
      END IF;
   EXCEPTION
      WHEN OTHERS THEN
         raise_application_error (-20100, SQLERRM);
   END;

   -- Exclui SP - Acréscimos e Retenções
   -- retorna o OK ou não
   PROCEDURE stp_exclui_conf_sol_pag_acr_re (
      p_usuario                  IN       VARCHAR2,
      vo_ok                      OUT      tyt_ok,
      vi_payable_entity_id_par   IN       t_payable_entity_id_par,
      vi_contract_id_par         IN       t_contract_id_par,
      vi_contract_versao_par     IN       t_contract_versao_par
   ) AS
      CURSOR c_cursor IS
         SELECT     *
               FROM ifrbde.viw_conf_sol_pag_acr_ret_u
              WHERE payable_entity_id_par = vi_payable_entity_id_par
                AND contract_id_par = vi_contract_id_par
                AND contract_versao_par = vi_contract_versao_par
         FOR UPDATE;

      v_viw_conf_sol_pag_acr_ret_u  ifrbde.viw_conf_sol_pag_acr_ret_u%ROWTYPE;
      v_dado                        VARCHAR2 (4000) := NULL;
   BEGIN
      vo_ok (1) := 0;

      IF ifrseg.pck_seguranca.stf_permitido (p_usuario,
                                             'VIW_CONF_SOL_PAG_ACR_RET_U',
                                             'EXCLUI'
                                            ) THEN
         OPEN c_cursor;

         FETCH c_cursor
          INTO v_viw_conf_sol_pag_acr_ret_u;

         IF NOT c_cursor%NOTFOUND THEN
            v_dado :=
               'payable_entity_id_par = '
               || RTRIM
                    (LTRIM
                        (UPPER
                            (v_viw_conf_sol_pag_acr_ret_u.payable_entity_id_par
                            )
                        )
                    );
            v_dado :=
               v_dado
               || ','
               || 'contract_id_par = '
               || RTRIM
                    (LTRIM
                          (UPPER (v_viw_conf_sol_pag_acr_ret_u.contract_id_par)
                          )
                    );
            v_dado :=
               v_dado
               || ','
               || 'contract_versao_par = '
               || RTRIM
                    (LTRIM
                        (UPPER
                             (v_viw_conf_sol_pag_acr_ret_u.contract_versao_par)
                        )
                    );
            v_dado :=
               v_dado
               || ','
               || 'vendor_id = '
               || RTRIM (LTRIM (UPPER (v_viw_conf_sol_pag_acr_ret_u.vendor_id))
                        );
            v_dado :=
               v_dado
               || ','
               || 'vendor_loc_code = '
               || RTRIM
                    (LTRIM
                          (UPPER (v_viw_conf_sol_pag_acr_ret_u.vendor_loc_code)
                          )
                    );
            v_dado :=
               v_dado
               || ','
               || 'pmt_rqst_nbr = '
               || RTRIM
                      (LTRIM (UPPER (v_viw_conf_sol_pag_acr_ret_u.pmt_rqst_nbr)
                             )
                      );
            v_dado :=
               v_dado
               || ','
               || 'pmt_rqst_date = '
               || TO_DATE (v_viw_conf_sol_pag_acr_ret_u.pmt_rqst_date,
                           'DD/MM/YYYY'
                          );
            v_dado :=
               v_dado
               || ','
               || 'schld_pmt_nbr = '
               || TO_CHAR (v_viw_conf_sol_pag_acr_ret_u.schld_pmt_nbr);
            v_dado :=
               v_dado
               || ','
               || 'codigo_red_acres = '
               || RTRIM
                    (LTRIM
                         (UPPER (v_viw_conf_sol_pag_acr_ret_u.codigo_red_acres)
                         )
                    );
            v_dado :=
               v_dado
               || ','
               || 'trans_amt = '
               || TO_CHAR (v_viw_conf_sol_pag_acr_ret_u.trans_amt);
            v_dado :=
               v_dado
               || ','
               || 'descp = '
               || RTRIM (LTRIM (UPPER (v_viw_conf_sol_pag_acr_ret_u.descp)));
            v_dado :=
               v_dado
               || ','
               || 'sistema_origem_code_par = '
               || RTRIM
                    (LTRIM
                        (UPPER
                            (v_viw_conf_sol_pag_acr_ret_u.sistema_origem_code_par
                            )
                        )
                    );
            v_dado :=
               v_dado
               || ','
               || 'contract_versao_origem_par = '
               || RTRIM
                    (LTRIM
                        (UPPER
                            (v_viw_conf_sol_pag_acr_ret_u.contract_versao_origem_par
                            )
                        )
                    );
            v_dado :=
               v_dado
               || ','
               || 'date_created_par = '
               || TO_DATE (v_viw_conf_sol_pag_acr_ret_u.date_created_par,
                           'DD/MM/YYYY'
                          );
            v_dado :=
               v_dado
               || ','
               || 'user_id_created_par = '
               || RTRIM
                    (LTRIM
                        (UPPER
                             (v_viw_conf_sol_pag_acr_ret_u.user_id_created_par)
                        )
                    );
            v_dado :=
               v_dado
               || ','
               || 'date_changed_par = '
               || TO_DATE (v_viw_conf_sol_pag_acr_ret_u.date_changed_par,
                           'DD/MM/YYYY'
                          );
            v_dado :=
               v_dado
               || ','
               || 'user_id_changed_par = '
               || RTRIM
                    (LTRIM
                        (UPPER
                             (v_viw_conf_sol_pag_acr_ret_u.user_id_changed_par)
                        )
                    );
            v_dado :=
               v_dado
               || ','
               || 'inactive_ind_par = '
               || RTRIM
                    (LTRIM
                         (UPPER (v_viw_conf_sol_pag_acr_ret_u.inactive_ind_par)
                         )
                    );
            v_dado :=
               v_dado
               || ','
               || 'active_date_par = '
               || TO_DATE (v_viw_conf_sol_pag_acr_ret_u.active_date_par,
                           'DD/MM/YYYY'
                          );

            IF c_cursor%ROWCOUNT = 1 THEN
               vo_ok (1) := 1;
               -- LOG
               ifrseg.pck_seguranca.stp_log (p_usuario,
                                             'VIW_CONF_SOL_PAG_ACR_RET_U',
                                             'E',
                                             v_dado
                                            );

               DELETE FROM ifrbde.viw_conf_sol_pag_acr_ret_u
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
-- Inclui SP - Acréscimos e Retenções
-- retorna o recordset correspondente
   PROCEDURE stp_inclui_conf_sol_pag_acr_re (
      p_usuario                  IN       VARCHAR2,
      vo_payable_entity_id_par   OUT      tyt_payable_entity_id_par,
      vo_contract_id_par         OUT      tyt_contract_id_par,
      vo_contract_versao_par     OUT      tyt_contract_versao_par,
      vo_vendor_id               OUT      tyt_vendor_id,
      vo_vendor_loc_code         OUT      tyt_vendor_loc_code,
      vo_pmt_rqst_nbr            OUT      tyt_pmt_rqst_nbr,
      vo_pmt_rqst_date           OUT      tyt_pmt_rqst_date,
      vo_schld_pmt_nbr           OUT      tyt_schld_pmt_nbr,
      vo_codigo_red_acres        OUT      tyt_codigo_red_acres,
      vo_trans_amt               OUT      tyt_trans_amt,
      vo_descp                   OUT      tyt_descp,
      vo_sistema_origem_code_par OUT      tyt_sistema_origem_code_par,
      vo_contract_versao_origem_par OUT   tyt_contract_versao_origem_par,
      vo_date_created_par        OUT      tyt_date_created_par,
      vo_user_id_created_par     OUT      tyt_user_id_created_par,
      vo_date_changed_par        OUT      tyt_date_changed_par,
      vo_user_id_changed_par     OUT      tyt_user_id_changed_par,
      vo_inactive_ind_par        OUT      tyt_inactive_ind_par,
      vo_active_date_par         OUT      tyt_active_date_par,
      vi_payable_entity_id_par   IN       t_payable_entity_id_par,
      vi_contract_id_par         IN       t_contract_id_par,
      vi_contract_versao_par     IN       t_contract_versao_par,
      vi_vendor_id               IN       t_vendor_id,
      vi_vendor_loc_code         IN       t_vendor_loc_code,
      vi_pmt_rqst_nbr            IN       t_pmt_rqst_nbr,
      vi_pmt_rqst_date           IN       t_pmt_rqst_date,
      vi_schld_pmt_nbr           IN       t_schld_pmt_nbr,
      vi_codigo_red_acres        IN       t_codigo_red_acres,
      vi_trans_amt               IN       t_trans_amt,
      vi_descp                   IN       t_descp,
      vi_user_id_created_par     IN       t_user_id_created_par
   ) AS
      v_payable_entity_id_par       viw_conf_sol_pag_acr_ret_u.payable_entity_id_par%TYPE;
      v_contract_id_par             viw_conf_sol_pag_acr_ret_u.contract_id_par%TYPE;
      v_contract_versao_par         viw_conf_sol_pag_acr_ret_u.contract_versao_par%TYPE;
      v_vendor_id                   viw_conf_sol_pag_acr_ret_u.vendor_id%TYPE;
      v_vendor_loc_code             viw_conf_sol_pag_acr_ret_u.vendor_loc_code%TYPE;
      v_pmt_rqst_nbr                viw_conf_sol_pag_acr_ret_u.pmt_rqst_nbr%TYPE;
      v_pmt_rqst_date               viw_conf_sol_pag_acr_ret_u.pmt_rqst_date%TYPE;
      v_schld_pmt_nbr               viw_conf_sol_pag_acr_ret_u.schld_pmt_nbr%TYPE;
      v_codigo_red_acres            viw_conf_sol_pag_acr_ret_u.codigo_red_acres%TYPE;
      v_trans_amt                   viw_conf_sol_pag_acr_ret_u.trans_amt%TYPE;
      v_descp                       viw_conf_sol_pag_acr_ret_u.descp%TYPE;
      v_user_id_created_par         viw_conf_sol_pag_acr_ret_u.user_id_created_par%TYPE;
      v_dado                        VARCHAR2 (4000) := NULL;
   BEGIN
      IF ifrseg.pck_seguranca.stf_permitido (p_usuario,
                                             'VIW_CONF_SOL_PAG_ACR_RET_U',
                                             'INCLUI'
                                            ) THEN
         v_payable_entity_id_par := RTRIM (LTRIM (vi_payable_entity_id_par));
         v_contract_id_par := RTRIM (LTRIM (vi_contract_id_par));
         v_contract_versao_par := RTRIM (LTRIM (vi_contract_versao_par));
         v_vendor_id := RTRIM (LTRIM (vi_vendor_id));
         v_vendor_loc_code := RTRIM (LTRIM (vi_vendor_loc_code));
         v_pmt_rqst_nbr := RTRIM (LTRIM (vi_pmt_rqst_nbr));
         v_codigo_red_acres := RTRIM (LTRIM (vi_codigo_red_acres));
         v_descp := RTRIM (LTRIM (vi_descp));
         v_user_id_created_par := RTRIM (LTRIM (vi_user_id_created_par));
         v_pmt_rqst_date := TO_DATE (vi_pmt_rqst_date, 'DD/MM/YYYY');
         v_schld_pmt_nbr := vi_schld_pmt_nbr;
         v_trans_amt := vi_trans_amt;

         INSERT INTO ifrbde.viw_conf_sol_pag_acr_ret_u
                     (payable_entity_id_par,
                      contract_id_par,
                      contract_versao_par,
                      vendor_id,
                      vendor_loc_code,
                      pmt_rqst_nbr,
                      pmt_rqst_date,
                      schld_pmt_nbr,
                      codigo_red_acres,
                      trans_amt,
                      descp,
                      user_id_created_par
                     )
              VALUES (v_payable_entity_id_par,
                      v_contract_id_par,
                      v_contract_versao_par,
                      v_vendor_id,
                      v_vendor_loc_code,
                      v_pmt_rqst_nbr,
                      v_pmt_rqst_date,
                      v_schld_pmt_nbr,
                      v_codigo_red_acres,
                      v_trans_amt,
                      v_descp,
                      v_user_id_created_par
                     );

         IF SQL%ROWCOUNT = 1 THEN
            stp_pesquisa_conf_sol_pag_acr_ (p_usuario,
                                            vo_payable_entity_id_par,
                                            vo_contract_id_par,
                                            vo_contract_versao_par,
                                            vo_vendor_id,
                                            vo_vendor_loc_code,
                                            vo_pmt_rqst_nbr,
                                            vo_pmt_rqst_date,
                                            vo_schld_pmt_nbr,
                                            vo_codigo_red_acres,
                                            vo_trans_amt,
                                            vo_descp,
                                            vo_sistema_origem_code_par,
                                            vo_contract_versao_origem_par,
                                            vo_date_created_par,
                                            vo_user_id_created_par,
                                            vo_date_changed_par,
                                            vo_user_id_changed_par,
                                            vo_inactive_ind_par,
                                            vo_active_date_par,
                                            v_payable_entity_id_par,
                                            v_contract_id_par,
                                            v_contract_versao_par
                                           );
            v_dado :=
               'payable_entity_id_par = '
               || RTRIM (LTRIM (v_payable_entity_id_par));
            v_dado :=
               v_dado
               || ','
               || 'contract_id_par = '
               || RTRIM (LTRIM (v_contract_id_par));
            v_dado :=
               v_dado
               || ','
               || 'contract_versao_par = '
               || RTRIM (LTRIM (v_contract_versao_par));
            v_dado :=
                v_dado || ',' || 'vendor_id = ' || RTRIM (LTRIM (v_vendor_id));
            v_dado :=
               v_dado
               || ','
               || 'vendor_loc_code = '
               || RTRIM (LTRIM (v_vendor_loc_code));
            v_dado :=
               v_dado
               || ','
               || 'pmt_rqst_nbr = '
               || RTRIM (LTRIM (v_pmt_rqst_nbr));
            v_dado :=
               v_dado
               || ','
               || 'pmt_rqst_date = '
               || TO_CHAR (v_pmt_rqst_date, 'DD/MM/YYYY');
            v_dado :=
               v_dado || ',' || 'schld_pmt_nbr = '
               || TO_CHAR (v_schld_pmt_nbr);
            v_dado :=
               v_dado
               || ','
               || 'codigo_red_acres = '
               || RTRIM (LTRIM (v_codigo_red_acres));
            v_dado := v_dado || ',' || 'trans_amt = ' || TO_CHAR (v_trans_amt);
            v_dado := v_dado || ',' || 'descp = ' || RTRIM (LTRIM (v_descp));
            v_dado :=
               v_dado
               || ','
               || 'user_id_created_par = '
               || RTRIM (LTRIM (v_user_id_created_par));
            -- LOG
            ifrseg.pck_seguranca.stp_log (p_usuario,
                                          'VIW_CONF_SOL_PAG_ACR_RET_U',
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
-- Altera SP - Acréscimos e Retenções
-- retorna o recordset correspondente
   PROCEDURE stp_altera_conf_sol_pag_acr_re (
      p_usuario                  IN       VARCHAR2,
      vo_payable_entity_id_par   OUT      tyt_payable_entity_id_par,
      vo_contract_id_par         OUT      tyt_contract_id_par,
      vo_contract_versao_par     OUT      tyt_contract_versao_par,
      vo_vendor_id               OUT      tyt_vendor_id,
      vo_vendor_loc_code         OUT      tyt_vendor_loc_code,
      vo_pmt_rqst_nbr            OUT      tyt_pmt_rqst_nbr,
      vo_pmt_rqst_date           OUT      tyt_pmt_rqst_date,
      vo_schld_pmt_nbr           OUT      tyt_schld_pmt_nbr,
      vo_codigo_red_acres        OUT      tyt_codigo_red_acres,
      vo_trans_amt               OUT      tyt_trans_amt,
      vo_descp                   OUT      tyt_descp,
      vo_sistema_origem_code_par OUT      tyt_sistema_origem_code_par,
      vo_contract_versao_origem_par OUT   tyt_contract_versao_origem_par,
      vo_date_created_par        OUT      tyt_date_created_par,
      vo_user_id_created_par     OUT      tyt_user_id_created_par,
      vo_date_changed_par        OUT      tyt_date_changed_par,
      vo_user_id_changed_par     OUT      tyt_user_id_changed_par,
      vo_inactive_ind_par        OUT      tyt_inactive_ind_par,
      vo_active_date_par         OUT      tyt_active_date_par,
      vi_payable_entity_id_par   IN       t_payable_entity_id_par,
      vi_contract_id_par         IN       t_contract_id_par,
      vi_contract_versao_par     IN       t_contract_versao_par,
      vi_vendor_id               IN       t_vendor_id,
      vi_vendor_loc_code         IN       t_vendor_loc_code,
      vi_pmt_rqst_nbr            IN       t_pmt_rqst_nbr,
      vi_pmt_rqst_date           IN       t_pmt_rqst_date,
      vi_schld_pmt_nbr           IN       t_schld_pmt_nbr,
      vi_codigo_red_acres        IN       t_codigo_red_acres,
      vi_trans_amt               IN       t_trans_amt,
      vi_descp                   IN       t_descp,
      vi_user_id_created_par     IN       t_user_id_created_par
   ) AS
      CURSOR c_cursor IS
         SELECT     *
               FROM ifrbde.viw_conf_sol_pag_acr_ret_u
              WHERE payable_entity_id_par = vi_payable_entity_id_par
                AND contract_id_par = vi_contract_id_par
                AND contract_versao_par = vi_contract_versao_par
         FOR UPDATE;

      v_viw_conf_sol_pag_acr_ret_u  ifrbde.viw_conf_sol_pag_acr_ret_u%ROWTYPE;
      v_payable_entity_id_par       ifrbde.viw_conf_sol_pag_acr_ret_u.payable_entity_id_par%TYPE;
      v_contract_id_par             ifrbde.viw_conf_sol_pag_acr_ret_u.contract_id_par%TYPE;
      v_contract_versao_par         ifrbde.viw_conf_sol_pag_acr_ret_u.contract_versao_par%TYPE;
      v_vendor_id                   ifrbde.viw_conf_sol_pag_acr_ret_u.vendor_id%TYPE;
      v_vendor_loc_code             ifrbde.viw_conf_sol_pag_acr_ret_u.vendor_loc_code%TYPE;
      v_pmt_rqst_nbr                ifrbde.viw_conf_sol_pag_acr_ret_u.pmt_rqst_nbr%TYPE;
      v_pmt_rqst_date               ifrbde.viw_conf_sol_pag_acr_ret_u.pmt_rqst_date%TYPE;
      v_schld_pmt_nbr               ifrbde.viw_conf_sol_pag_acr_ret_u.schld_pmt_nbr%TYPE;
      v_codigo_red_acres            ifrbde.viw_conf_sol_pag_acr_ret_u.codigo_red_acres%TYPE;
      v_trans_amt                   ifrbde.viw_conf_sol_pag_acr_ret_u.trans_amt%TYPE;
      v_descp                       ifrbde.viw_conf_sol_pag_acr_ret_u.descp%TYPE;
      v_user_id_created_par         ifrbde.viw_conf_sol_pag_acr_ret_u.user_id_created_par%TYPE;
      v_dado                        VARCHAR2 (4000) := NULL;
   BEGIN
      IF ifrseg.pck_seguranca.stf_permitido (p_usuario,
                                             'VIW_CONF_SOL_PAG_ACR_RET_U',
                                             'ALTERA'
                                            ) THEN
         OPEN c_cursor;

         FETCH c_cursor
          INTO v_viw_conf_sol_pag_acr_ret_u;

         IF NOT c_cursor%NOTFOUND THEN
            v_payable_entity_id_par :=
                                     RTRIM (LTRIM (vi_payable_entity_id_par));
            v_contract_id_par := RTRIM (LTRIM (vi_contract_id_par));
            v_contract_versao_par := RTRIM (LTRIM (vi_contract_versao_par));
            v_vendor_id := RTRIM (LTRIM (vi_vendor_id));
            v_vendor_loc_code := RTRIM (LTRIM (vi_vendor_loc_code));
            v_pmt_rqst_nbr := RTRIM (LTRIM (vi_pmt_rqst_nbr));
            v_codigo_red_acres := RTRIM (LTRIM (vi_codigo_red_acres));
            v_descp := RTRIM (LTRIM (vi_descp));
            v_user_id_created_par := RTRIM (LTRIM (vi_user_id_created_par));
            v_pmt_rqst_date := TO_DATE (vi_pmt_rqst_date, 'DD/MM/YYYY');
            v_schld_pmt_nbr := vi_schld_pmt_nbr;
            v_trans_amt := vi_trans_amt;

            UPDATE ifrbde.viw_conf_sol_pag_acr_ret_u
               SET vendor_id = v_vendor_id,
                   vendor_loc_code = v_vendor_loc_code,
                   pmt_rqst_nbr = v_pmt_rqst_nbr,
                   pmt_rqst_date = v_pmt_rqst_date,
                   schld_pmt_nbr = v_schld_pmt_nbr,
                   codigo_red_acres = v_codigo_red_acres,
                   trans_amt = v_trans_amt,
                   descp = v_descp,
                   user_id_created_par = v_user_id_created_par
             WHERE CURRENT OF c_cursor;

            IF SQL%ROWCOUNT = 1 THEN
               stp_pesquisa_conf_sol_pag_acr_ (p_usuario,
                                               vo_payable_entity_id_par,
                                               vo_contract_id_par,
                                               vo_contract_versao_par,
                                               vo_vendor_id,
                                               vo_vendor_loc_code,
                                               vo_pmt_rqst_nbr,
                                               vo_pmt_rqst_date,
                                               vo_schld_pmt_nbr,
                                               vo_codigo_red_acres,
                                               vo_trans_amt,
                                               vo_descp,
                                               vo_sistema_origem_code_par,
                                               vo_contract_versao_origem_par,
                                               vo_date_created_par,
                                               vo_user_id_created_par,
                                               vo_date_changed_par,
                                               vo_user_id_changed_par,
                                               vo_inactive_ind_par,
                                               vo_active_date_par,
                                               vi_payable_entity_id_par,
                                               vi_contract_id_par,
                                               vi_contract_versao_par
                                              );
               v_dado :=
                  'payable_entity_id_par = '
                  || RTRIM (LTRIM (v_payable_entity_id_par));
               v_dado :=
                  v_dado
                  || ','
                  || 'contract_id_par = '
                  || RTRIM (LTRIM (v_contract_id_par));
               v_dado :=
                  v_dado
                  || ','
                  || 'contract_versao_par = '
                  || RTRIM (LTRIM (v_contract_versao_par));
               v_dado :=
                  v_dado || ',' || 'vendor_id = '
                  || RTRIM (LTRIM (v_vendor_id));
               v_dado :=
                  v_dado
                  || ','
                  || 'vendor_loc_code = '
                  || RTRIM (LTRIM (v_vendor_loc_code));
               v_dado :=
                  v_dado
                  || ','
                  || 'pmt_rqst_nbr = '
                  || RTRIM (LTRIM (v_pmt_rqst_nbr));
               v_dado :=
                  v_dado
                  || ','
                  || 'pmt_rqst_date = '
                  || TO_CHAR (v_pmt_rqst_date, 'DD/MM/YYYY');
               v_dado :=
                  v_dado
                  || ','
                  || 'schld_pmt_nbr = '
                  || TO_CHAR (v_schld_pmt_nbr);
               v_dado :=
                  v_dado
                  || ','
                  || 'codigo_red_acres = '
                  || RTRIM (LTRIM (v_codigo_red_acres));
               v_dado :=
                      v_dado || ',' || 'trans_amt = ' || TO_CHAR (v_trans_amt);
               v_dado :=
                        v_dado || ',' || 'descp = ' || RTRIM (LTRIM (v_descp));
               v_dado :=
                  v_dado
                  || ','
                  || 'user_id_created_par = '
                  || RTRIM (LTRIM (v_user_id_created_par));
               -- LOG
               ifrseg.pck_seguranca.stp_log (p_usuario,
                                             'VIW_CONF_SOL_PAG_ACR_RET_U',
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
-- Pesquisa Solicitação de Pagamento
-- retorna o recordset correspondente
   PROCEDURE stp_pesquisa_conf_sol_pag_head (
      p_usuario                  IN       VARCHAR2,
      vo_payable_entity_id_sph   OUT      tyt_payable_entity_id_sph,
      vo_contract_id_sph         OUT      tyt_contract_id_sph,
      vo_contract_versao_sph     OUT      tyt_contract_versao_sph,
      vo_vendor_id               OUT      tyt_vendor_id,
      vo_vendor_loc_code         OUT      tyt_vendor_loc_code,
      vo_pmt_rqst_nbr            OUT      tyt_pmt_rqst_nbr,
      vo_pmt_rqst_date           OUT      tyt_pmt_rqst_date,
      vo_schld_pmt_nbr           OUT      tyt_schld_pmt_nbr,
      vo_tipo_sp                 OUT      tyt_tipo_sp,
      vo_vendor_id_origem        OUT      tyt_vendor_id_origem,
      vo_vendor_loc_code_origem  OUT      tyt_vendor_loc_code_origem,
      vo_pmt_rqst_nbr_origem     OUT      tyt_pmt_rqst_nbr_origem,
      vo_pmt_rqst_date_origem    OUT      tyt_pmt_rqst_date_origem,
      vo_schld_pmt_nbr_origem    OUT      tyt_schld_pmt_nbr_origem,
      vo_prim_amt                OUT      tyt_prim_amt,
      vo_secdy_amt               OUT      tyt_secdy_amt,
      vo_sp_status_code          OUT      tyt_sp_status_code,
      vo_sistema_origem_code_sph OUT      tyt_sistema_origem_code_sph,
      vo_contract_versao_origem_sph OUT   tyt_contract_versao_origem_sph,
      vo_date_created_sph        OUT      tyt_date_created_sph,
      vo_user_id_created_sph     OUT      tyt_user_id_created_sph,
      vo_date_changed_sph        OUT      tyt_date_changed_sph,
      vo_user_id_changed_sph     OUT      tyt_user_id_changed_sph,
      vo_inactive_ind_sph        OUT      tyt_inactive_ind_sph,
      vo_active_date_sph         OUT      tyt_active_date_sph,
      vi_payable_entity_id_sph   IN       t_payable_entity_id_sph,
      vi_contract_id_sph         IN       t_contract_id_sph,
      vi_contract_versao_sph     IN       t_contract_versao_sph,
      vi_vendor_id               IN       t_vendor_id,
      vi_vendor_loc_code         IN       t_vendor_loc_code,
      vi_pmt_rqst_nbr            IN       t_pmt_rqst_nbr
   ) AS
   BEGIN
      IF ifrseg.pck_seguranca.stf_permitido (p_usuario,
                                             'VIW_CONF_SOL_PAG_HEAD_U',
                                             'PESQUISA'
                                            ) THEN
         SELECT payable_entity_id_sph,
                contract_id_sph,
                contract_versao_sph,
                vendor_id,
                vendor_loc_code,
                pmt_rqst_nbr,
                pmt_rqst_date,
                schld_pmt_nbr,
                tipo_sp,
                vendor_id_origem,
                vendor_loc_code_origem,
                pmt_rqst_nbr_origem,
                pmt_rqst_date_origem,
                schld_pmt_nbr_origem,
                prim_amt,
                secdy_amt,
                sp_status_code,
                sistema_origem_code_sph,
                contract_versao_origem_sph,
                date_created_sph,
                user_id_created_sph,
                date_changed_sph,
                user_id_changed_sph,
                inactive_ind_sph,
                active_date_sph
           INTO vo_payable_entity_id_sph (1),
                vo_contract_id_sph (1),
                vo_contract_versao_sph (1),
                vo_vendor_id (1),
                vo_vendor_loc_code (1),
                vo_pmt_rqst_nbr (1),
                vo_pmt_rqst_date (1),
                vo_schld_pmt_nbr (1),
                vo_tipo_sp (1),
                vo_vendor_id_origem (1),
                vo_vendor_loc_code_origem (1),
                vo_pmt_rqst_nbr_origem (1),
                vo_pmt_rqst_date_origem (1),
                vo_schld_pmt_nbr_origem (1),
                vo_prim_amt (1),
                vo_secdy_amt (1),
                vo_sp_status_code (1),
                vo_sistema_origem_code_sph (1),
                vo_contract_versao_origem_sph (1),
                vo_date_created_sph (1),
                vo_user_id_created_sph (1),
                vo_date_changed_sph (1),
                vo_user_id_changed_sph (1),
                vo_inactive_ind_sph (1),
                vo_active_date_sph (1)
           FROM ifrbde.viw_conf_sol_pag_head_u
          WHERE payable_entity_id_sph = vi_payable_entity_id_sph
            AND contract_id_sph = vi_contract_id_sph
            AND contract_versao_sph = vi_contract_versao_sph
            AND vendor_id = vi_vendor_id
            AND vendor_loc_code = vi_vendor_loc_code
            AND pmt_rqst_nbr = vi_pmt_rqst_nbr;
      END IF;
   EXCEPTION
      WHEN OTHERS THEN
         raise_application_error (-20100, SQLERRM);
   END;

   -- Exclui Solicitação de Pagamento
   -- retorna o OK ou não
   PROCEDURE stp_exclui_conf_sol_pag_head_u (
      p_usuario                  IN       VARCHAR2,
      vo_ok                      OUT      tyt_ok,
      vi_payable_entity_id_sph   IN       t_payable_entity_id_sph,
      vi_contract_id_sph         IN       t_contract_id_sph,
      vi_contract_versao_sph     IN       t_contract_versao_sph,
      vi_vendor_id               IN       t_vendor_id,
      vi_vendor_loc_code         IN       t_vendor_loc_code,
      vi_pmt_rqst_nbr            IN       t_pmt_rqst_nbr
   ) AS
      CURSOR c_cursor IS
         SELECT     *
               FROM ifrbde.viw_conf_sol_pag_head_u
              WHERE payable_entity_id_sph = vi_payable_entity_id_sph
                AND contract_id_sph = vi_contract_id_sph
                AND contract_versao_sph = vi_contract_versao_sph
                AND vendor_id = vi_vendor_id
                AND vendor_loc_code = vi_vendor_loc_code
                AND pmt_rqst_nbr = vi_pmt_rqst_nbr
         FOR UPDATE;

      v_viw_conf_sol_pag_head_u     ifrbde.viw_conf_sol_pag_head_u%ROWTYPE;
      v_dado                        VARCHAR2 (4000) := NULL;
   BEGIN
      vo_ok (1) := 0;

      IF ifrseg.pck_seguranca.stf_permitido (p_usuario,
                                             'VIW_CONF_SOL_PAG_HEAD_U',
                                             'EXCLUI'
                                            ) THEN
         OPEN c_cursor;

         FETCH c_cursor
          INTO v_viw_conf_sol_pag_head_u;

         IF NOT c_cursor%NOTFOUND THEN
            v_dado :=
               'payable_entity_id_sph = '
               || RTRIM
                    (LTRIM
                        (UPPER
                              (v_viw_conf_sol_pag_head_u.payable_entity_id_sph)
                        )
                    );
            v_dado :=
               v_dado
               || ','
               || 'contract_id_sph = '
               || RTRIM
                      (LTRIM (UPPER (v_viw_conf_sol_pag_head_u.contract_id_sph)
                             )
                      );
            v_dado :=
               v_dado
               || ','
               || 'contract_versao_sph = '
               || RTRIM
                    (LTRIM
                         (UPPER (v_viw_conf_sol_pag_head_u.contract_versao_sph)
                         )
                    );
            v_dado :=
               v_dado
               || ','
               || 'vendor_id = '
               || RTRIM (LTRIM (UPPER (v_viw_conf_sol_pag_head_u.vendor_id)));
            v_dado :=
               v_dado
               || ','
               || 'vendor_loc_code = '
               || RTRIM
                      (LTRIM (UPPER (v_viw_conf_sol_pag_head_u.vendor_loc_code)
                             )
                      );
            v_dado :=
               v_dado
               || ','
               || 'pmt_rqst_nbr = '
               || RTRIM (LTRIM (UPPER (v_viw_conf_sol_pag_head_u.pmt_rqst_nbr))
                        );
            v_dado :=
               v_dado
               || ','
               || 'pmt_rqst_date = '
               || TO_DATE (v_viw_conf_sol_pag_head_u.pmt_rqst_date,
                           'DD/MM/YYYY'
                          );
            v_dado :=
               v_dado
               || ','
               || 'schld_pmt_nbr = '
               || TO_CHAR (v_viw_conf_sol_pag_head_u.schld_pmt_nbr);
            v_dado :=
               v_dado
               || ','
               || 'tipo_sp = '
               || RTRIM (LTRIM (UPPER (v_viw_conf_sol_pag_head_u.tipo_sp)));
            v_dado :=
               v_dado
               || ','
               || 'vendor_id_origem = '
               || RTRIM
                     (LTRIM (UPPER (v_viw_conf_sol_pag_head_u.vendor_id_origem)
                            )
                     );
            v_dado :=
               v_dado
               || ','
               || 'vendor_loc_code_origem = '
               || RTRIM
                    (LTRIM
                        (UPPER
                             (v_viw_conf_sol_pag_head_u.vendor_loc_code_origem)
                        )
                    );
            v_dado :=
               v_dado
               || ','
               || 'pmt_rqst_nbr_origem = '
               || RTRIM
                    (LTRIM
                         (UPPER (v_viw_conf_sol_pag_head_u.pmt_rqst_nbr_origem)
                         )
                    );
            v_dado :=
               v_dado
               || ','
               || 'pmt_rqst_date_origem = '
               || TO_DATE (v_viw_conf_sol_pag_head_u.pmt_rqst_date_origem,
                           'DD/MM/YYYY'
                          );
            v_dado :=
               v_dado
               || ','
               || 'schld_pmt_nbr_origem = '
               || TO_CHAR (v_viw_conf_sol_pag_head_u.schld_pmt_nbr_origem);
            v_dado :=
               v_dado
               || ','
               || 'prim_amt = '
               || RTRIM (LTRIM (UPPER (v_viw_conf_sol_pag_head_u.prim_amt)));
            v_dado :=
               v_dado
               || ','
               || 'secdy_amt = '
               || TO_CHAR (v_viw_conf_sol_pag_head_u.secdy_amt);
            v_dado :=
               v_dado
               || ','
               || 'sp_status_code = '
               || RTRIM
                       (LTRIM (UPPER (v_viw_conf_sol_pag_head_u.sp_status_code)
                              )
                       );
            v_dado :=
               v_dado
               || ','
               || 'sistema_origem_code_sph = '
               || RTRIM
                    (LTRIM
                        (UPPER
                            (v_viw_conf_sol_pag_head_u.sistema_origem_code_sph)
                        )
                    );
            v_dado :=
               v_dado
               || ','
               || 'contract_versao_origem_sph = '
               || RTRIM
                    (LTRIM
                        (UPPER
                            (v_viw_conf_sol_pag_head_u.contract_versao_origem_sph
                            )
                        )
                    );
            v_dado :=
               v_dado
               || ','
               || 'date_created_sph = '
               || TO_DATE (v_viw_conf_sol_pag_head_u.date_created_sph,
                           'DD/MM/YYYY'
                          );
            v_dado :=
               v_dado
               || ','
               || 'user_id_created_sph = '
               || RTRIM
                    (LTRIM
                         (UPPER (v_viw_conf_sol_pag_head_u.user_id_created_sph)
                         )
                    );
            v_dado :=
               v_dado
               || ','
               || 'date_changed_sph = '
               || TO_DATE (v_viw_conf_sol_pag_head_u.date_changed_sph,
                           'DD/MM/YYYY'
                          );
            v_dado :=
               v_dado
               || ','
               || 'user_id_changed_sph = '
               || RTRIM
                    (LTRIM
                         (UPPER (v_viw_conf_sol_pag_head_u.user_id_changed_sph)
                         )
                    );
            v_dado :=
               v_dado
               || ','
               || 'inactive_ind_sph = '
               || RTRIM
                     (LTRIM (UPPER (v_viw_conf_sol_pag_head_u.inactive_ind_sph)
                            )
                     );
            v_dado :=
               v_dado
               || ','
               || 'active_date_sph = '
               || TO_DATE (v_viw_conf_sol_pag_head_u.active_date_sph,
                           'DD/MM/YYYY'
                          );

            IF c_cursor%ROWCOUNT = 1 THEN
               vo_ok (1) := 1;
               -- LOG
               ifrseg.pck_seguranca.stp_log (p_usuario,
                                             'VIW_CONF_SOL_PAG_HEAD_U',
                                             'E',
                                             v_dado
                                            );

               DELETE FROM ifrbde.viw_conf_sol_pag_head_u
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
-- Inclui Solicitação de Pagamento
-- retorna o recordset correspondente
   PROCEDURE stp_inclui_conf_sol_pag_head_u (
      p_usuario                  IN       VARCHAR2,
      vo_payable_entity_id_sph   OUT      tyt_payable_entity_id_sph,
      vo_contract_id_sph         OUT      tyt_contract_id_sph,
      vo_contract_versao_sph     OUT      tyt_contract_versao_sph,
      vo_vendor_id               OUT      tyt_vendor_id,
      vo_vendor_loc_code         OUT      tyt_vendor_loc_code,
      vo_pmt_rqst_nbr            OUT      tyt_pmt_rqst_nbr,
      vo_pmt_rqst_date           OUT      tyt_pmt_rqst_date,
      vo_schld_pmt_nbr           OUT      tyt_schld_pmt_nbr,
      vo_tipo_sp                 OUT      tyt_tipo_sp,
      vo_vendor_id_origem        OUT      tyt_vendor_id_origem,
      vo_vendor_loc_code_origem  OUT      tyt_vendor_loc_code_origem,
      vo_pmt_rqst_nbr_origem     OUT      tyt_pmt_rqst_nbr_origem,
      vo_pmt_rqst_date_origem    OUT      tyt_pmt_rqst_date_origem,
      vo_schld_pmt_nbr_origem    OUT      tyt_schld_pmt_nbr_origem,
      vo_prim_amt                OUT      tyt_prim_amt,
      vo_secdy_amt               OUT      tyt_secdy_amt,
      vo_sp_status_code          OUT      tyt_sp_status_code,
      vo_sistema_origem_code_sph OUT      tyt_sistema_origem_code_sph,
      vo_contract_versao_origem_sph OUT   tyt_contract_versao_origem_sph,
      vo_date_created_sph        OUT      tyt_date_created_sph,
      vo_user_id_created_sph     OUT      tyt_user_id_created_sph,
      vo_date_changed_sph        OUT      tyt_date_changed_sph,
      vo_user_id_changed_sph     OUT      tyt_user_id_changed_sph,
      vo_inactive_ind_sph        OUT      tyt_inactive_ind_sph,
      vo_active_date_sph         OUT      tyt_active_date_sph,
      vi_payable_entity_id_sph   IN       t_payable_entity_id_sph,
      vi_contract_id_sph         IN       t_contract_id_sph,
      vi_contract_versao_sph     IN       t_contract_versao_sph,
      vi_vendor_id               IN       t_vendor_id,
      vi_vendor_loc_code         IN       t_vendor_loc_code,
      vi_pmt_rqst_nbr            IN       t_pmt_rqst_nbr,
      vi_pmt_rqst_date           IN       t_pmt_rqst_date,
      vi_schld_pmt_nbr           IN       t_schld_pmt_nbr,
      vi_tipo_sp                 IN       t_tipo_sp,
      vi_vendor_id_origem        IN       t_vendor_id_origem,
      vi_vendor_loc_code_origem  IN       t_vendor_loc_code_origem,
      vi_pmt_rqst_nbr_origem     IN       t_pmt_rqst_nbr_origem,
      vi_pmt_rqst_date_origem    IN       t_pmt_rqst_date_origem,
      vi_schld_pmt_nbr_origem    IN       t_schld_pmt_nbr_origem,
      vi_prim_amt                IN       t_prim_amt,
      vi_secdy_amt               IN       t_secdy_amt,
      vi_sp_status_code          IN       t_sp_status_code,
      vi_user_id_created_sph     IN       t_user_id_created_sph
   ) AS
      v_payable_entity_id_sph       viw_conf_sol_pag_head_u.payable_entity_id_sph%TYPE;
      v_contract_id_sph             viw_conf_sol_pag_head_u.contract_id_sph%TYPE;
      v_contract_versao_sph         viw_conf_sol_pag_head_u.contract_versao_sph%TYPE;
      v_vendor_id                   viw_conf_sol_pag_head_u.vendor_id%TYPE;
      v_vendor_loc_code             viw_conf_sol_pag_head_u.vendor_loc_code%TYPE;
      v_pmt_rqst_nbr                viw_conf_sol_pag_head_u.pmt_rqst_nbr%TYPE;
      v_pmt_rqst_date               viw_conf_sol_pag_head_u.pmt_rqst_date%TYPE;
      v_schld_pmt_nbr               viw_conf_sol_pag_head_u.schld_pmt_nbr%TYPE;
      v_tipo_sp                     viw_conf_sol_pag_head_u.tipo_sp%TYPE;
      v_vendor_id_origem            viw_conf_sol_pag_head_u.vendor_id_origem%TYPE;
      v_vendor_loc_code_origem      viw_conf_sol_pag_head_u.vendor_loc_code_origem%TYPE;
      v_pmt_rqst_nbr_origem         viw_conf_sol_pag_head_u.pmt_rqst_nbr_origem%TYPE;
      v_pmt_rqst_date_origem        viw_conf_sol_pag_head_u.pmt_rqst_date_origem%TYPE;
      v_schld_pmt_nbr_origem        viw_conf_sol_pag_head_u.schld_pmt_nbr_origem%TYPE;
      v_prim_amt                    viw_conf_sol_pag_head_u.prim_amt%TYPE;
      v_secdy_amt                   viw_conf_sol_pag_head_u.secdy_amt%TYPE;
      v_sp_status_code              viw_conf_sol_pag_head_u.sp_status_code%TYPE;
      v_user_id_created_sph         viw_conf_sol_pag_head_u.user_id_created_sph%TYPE;
      v_dado                        VARCHAR2 (4000) := NULL;
   BEGIN
      IF ifrseg.pck_seguranca.stf_permitido (p_usuario,
                                             'VIW_CONF_SOL_PAG_HEAD_U',
                                             'INCLUI'
                                            ) THEN
         v_payable_entity_id_sph := RTRIM (LTRIM (vi_payable_entity_id_sph));
         v_contract_id_sph := RTRIM (LTRIM (vi_contract_id_sph));
         v_contract_versao_sph := RTRIM (LTRIM (vi_contract_versao_sph));
         v_vendor_id := RTRIM (LTRIM (vi_vendor_id));
         v_vendor_loc_code := RTRIM (LTRIM (vi_vendor_loc_code));
         v_pmt_rqst_nbr := RTRIM (LTRIM (vi_pmt_rqst_nbr));
         v_tipo_sp := RTRIM (LTRIM (vi_tipo_sp));
         v_vendor_id_origem := RTRIM (LTRIM (vi_vendor_id_origem));
         v_vendor_loc_code_origem :=
                                    RTRIM (LTRIM (vi_vendor_loc_code_origem));
         v_pmt_rqst_nbr_origem := RTRIM (LTRIM (vi_pmt_rqst_nbr_origem));
         v_prim_amt := RTRIM (LTRIM (vi_prim_amt));
         v_sp_status_code := RTRIM (LTRIM (vi_sp_status_code));
         v_user_id_created_sph := RTRIM (LTRIM (vi_user_id_created_sph));
         v_pmt_rqst_date := TO_DATE (vi_pmt_rqst_date, 'DD/MM/YYYY');
         v_pmt_rqst_date_origem :=
                              TO_DATE (vi_pmt_rqst_date_origem, 'DD/MM/YYYY');
         v_schld_pmt_nbr := vi_schld_pmt_nbr;
         v_schld_pmt_nbr_origem := vi_schld_pmt_nbr_origem;
         v_secdy_amt := vi_secdy_amt;

         INSERT INTO ifrbde.viw_conf_sol_pag_head_u
                     (payable_entity_id_sph,
                      contract_id_sph,
                      contract_versao_sph,
                      vendor_id,
                      vendor_loc_code,
                      pmt_rqst_nbr,
                      pmt_rqst_date,
                      schld_pmt_nbr,
                      tipo_sp,
                      vendor_id_origem,
                      vendor_loc_code_origem,
                      pmt_rqst_nbr_origem,
                      pmt_rqst_date_origem,
                      schld_pmt_nbr_origem,
                      prim_amt,
                      secdy_amt,
                      sp_status_code,
                      user_id_created_sph
                     )
              VALUES (v_payable_entity_id_sph,
                      v_contract_id_sph,
                      v_contract_versao_sph,
                      v_vendor_id,
                      v_vendor_loc_code,
                      v_pmt_rqst_nbr,
                      v_pmt_rqst_date,
                      v_schld_pmt_nbr,
                      v_tipo_sp,
                      v_vendor_id_origem,
                      v_vendor_loc_code_origem,
                      v_pmt_rqst_nbr_origem,
                      v_pmt_rqst_date_origem,
                      v_schld_pmt_nbr_origem,
                      v_prim_amt,
                      v_secdy_amt,
                      v_sp_status_code,
                      v_user_id_created_sph
                     );

         IF SQL%ROWCOUNT = 1 THEN
            stp_pesquisa_conf_sol_pag_head (p_usuario,
                                            vo_payable_entity_id_sph,
                                            vo_contract_id_sph,
                                            vo_contract_versao_sph,
                                            vo_vendor_id,
                                            vo_vendor_loc_code,
                                            vo_pmt_rqst_nbr,
                                            vo_pmt_rqst_date,
                                            vo_schld_pmt_nbr,
                                            vo_tipo_sp,
                                            vo_vendor_id_origem,
                                            vo_vendor_loc_code_origem,
                                            vo_pmt_rqst_nbr_origem,
                                            vo_pmt_rqst_date_origem,
                                            vo_schld_pmt_nbr_origem,
                                            vo_prim_amt,
                                            vo_secdy_amt,
                                            vo_sp_status_code,
                                            vo_sistema_origem_code_sph,
                                            vo_contract_versao_origem_sph,
                                            vo_date_created_sph,
                                            vo_user_id_created_sph,
                                            vo_date_changed_sph,
                                            vo_user_id_changed_sph,
                                            vo_inactive_ind_sph,
                                            vo_active_date_sph,
                                            v_payable_entity_id_sph,
                                            v_contract_id_sph,
                                            v_contract_versao_sph,
                                            v_vendor_id,
                                            v_vendor_loc_code,
                                            v_pmt_rqst_nbr
                                           );
            v_dado :=
               'payable_entity_id_sph = '
               || RTRIM (LTRIM (v_payable_entity_id_sph));
            v_dado :=
               v_dado
               || ','
               || 'contract_id_sph = '
               || RTRIM (LTRIM (v_contract_id_sph));
            v_dado :=
               v_dado
               || ','
               || 'contract_versao_sph = '
               || RTRIM (LTRIM (v_contract_versao_sph));
            v_dado :=
                v_dado || ',' || 'vendor_id = ' || RTRIM (LTRIM (v_vendor_id));
            v_dado :=
               v_dado
               || ','
               || 'vendor_loc_code = '
               || RTRIM (LTRIM (v_vendor_loc_code));
            v_dado :=
               v_dado
               || ','
               || 'pmt_rqst_nbr = '
               || RTRIM (LTRIM (v_pmt_rqst_nbr));
            v_dado :=
               v_dado
               || ','
               || 'pmt_rqst_date = '
               || TO_CHAR (v_pmt_rqst_date, 'DD/MM/YYYY');
            v_dado :=
               v_dado || ',' || 'schld_pmt_nbr = '
               || TO_CHAR (v_schld_pmt_nbr);
            v_dado :=
                    v_dado || ',' || 'tipo_sp = ' || RTRIM (LTRIM (v_tipo_sp));
            v_dado :=
               v_dado
               || ','
               || 'vendor_id_origem = '
               || RTRIM (LTRIM (v_vendor_id_origem));
            v_dado :=
               v_dado
               || ','
               || 'vendor_loc_code_origem = '
               || RTRIM (LTRIM (v_vendor_loc_code_origem));
            v_dado :=
               v_dado
               || ','
               || 'pmt_rqst_nbr_origem = '
               || RTRIM (LTRIM (v_pmt_rqst_nbr_origem));
            v_dado :=
               v_dado
               || ','
               || 'pmt_rqst_date_origem = '
               || TO_CHAR (v_pmt_rqst_date_origem, 'DD/MM/YYYY');
            v_dado :=
               v_dado
               || ','
               || 'schld_pmt_nbr_origem = '
               || TO_CHAR (v_schld_pmt_nbr_origem);
            v_dado :=
                  v_dado || ',' || 'prim_amt = ' || RTRIM (LTRIM (v_prim_amt));
            v_dado := v_dado || ',' || 'secdy_amt = ' || TO_CHAR (v_secdy_amt);
            v_dado :=
               v_dado
               || ','
               || 'sp_status_code = '
               || RTRIM (LTRIM (v_sp_status_code));
            v_dado :=
               v_dado
               || ','
               || 'user_id_created_sph = '
               || RTRIM (LTRIM (v_user_id_created_sph));
            -- LOG
            ifrseg.pck_seguranca.stp_log (p_usuario,
                                          'VIW_CONF_SOL_PAG_HEAD_U',
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
-- Altera Solicitação de Pagamento
-- retorna o recordset correspondente
   PROCEDURE stp_altera_conf_sol_pag_head_u (
      p_usuario                  IN       VARCHAR2,
      vo_payable_entity_id_sph   OUT      tyt_payable_entity_id_sph,
      vo_contract_id_sph         OUT      tyt_contract_id_sph,
      vo_contract_versao_sph     OUT      tyt_contract_versao_sph,
      vo_vendor_id               OUT      tyt_vendor_id,
      vo_vendor_loc_code         OUT      tyt_vendor_loc_code,
      vo_pmt_rqst_nbr            OUT      tyt_pmt_rqst_nbr,
      vo_pmt_rqst_date           OUT      tyt_pmt_rqst_date,
      vo_schld_pmt_nbr           OUT      tyt_schld_pmt_nbr,
      vo_tipo_sp                 OUT      tyt_tipo_sp,
      vo_vendor_id_origem        OUT      tyt_vendor_id_origem,
      vo_vendor_loc_code_origem  OUT      tyt_vendor_loc_code_origem,
      vo_pmt_rqst_nbr_origem     OUT      tyt_pmt_rqst_nbr_origem,
      vo_pmt_rqst_date_origem    OUT      tyt_pmt_rqst_date_origem,
      vo_schld_pmt_nbr_origem    OUT      tyt_schld_pmt_nbr_origem,
      vo_prim_amt                OUT      tyt_prim_amt,
      vo_secdy_amt               OUT      tyt_secdy_amt,
      vo_sp_status_code          OUT      tyt_sp_status_code,
      vo_sistema_origem_code_sph OUT      tyt_sistema_origem_code_sph,
      vo_contract_versao_origem_sph OUT   tyt_contract_versao_origem_sph,
      vo_date_created_sph        OUT      tyt_date_created_sph,
      vo_user_id_created_sph     OUT      tyt_user_id_created_sph,
      vo_date_changed_sph        OUT      tyt_date_changed_sph,
      vo_user_id_changed_sph     OUT      tyt_user_id_changed_sph,
      vo_inactive_ind_sph        OUT      tyt_inactive_ind_sph,
      vo_active_date_sph         OUT      tyt_active_date_sph,
      vi_payable_entity_id_sph   IN       t_payable_entity_id_sph,
      vi_contract_id_sph         IN       t_contract_id_sph,
      vi_contract_versao_sph     IN       t_contract_versao_sph,
      vi_vendor_id               IN       t_vendor_id,
      vi_vendor_loc_code         IN       t_vendor_loc_code,
      vi_pmt_rqst_nbr            IN       t_pmt_rqst_nbr,
      vi_pmt_rqst_date           IN       t_pmt_rqst_date,
      vi_schld_pmt_nbr           IN       t_schld_pmt_nbr,
      vi_tipo_sp                 IN       t_tipo_sp,
      vi_vendor_id_origem        IN       t_vendor_id_origem,
      vi_vendor_loc_code_origem  IN       t_vendor_loc_code_origem,
      vi_pmt_rqst_nbr_origem     IN       t_pmt_rqst_nbr_origem,
      vi_pmt_rqst_date_origem    IN       t_pmt_rqst_date_origem,
      vi_schld_pmt_nbr_origem    IN       t_schld_pmt_nbr_origem,
      vi_prim_amt                IN       t_prim_amt,
      vi_secdy_amt               IN       t_secdy_amt,
      vi_sp_status_code          IN       t_sp_status_code,
      vi_user_id_created_sph     IN       t_user_id_created_sph
   ) AS
      CURSOR c_cursor IS
         SELECT     *
               FROM ifrbde.viw_conf_sol_pag_head_u
              WHERE payable_entity_id_sph = vi_payable_entity_id_sph
                AND contract_id_sph = vi_contract_id_sph
                AND contract_versao_sph = vi_contract_versao_sph
                AND vendor_id = vi_vendor_id
                AND vendor_loc_code = vi_vendor_loc_code
                AND pmt_rqst_nbr = vi_pmt_rqst_nbr
         FOR UPDATE;

      v_viw_conf_sol_pag_head_u     ifrbde.viw_conf_sol_pag_head_u%ROWTYPE;
      v_payable_entity_id_sph       ifrbde.viw_conf_sol_pag_head_u.payable_entity_id_sph%TYPE;
      v_contract_id_sph             ifrbde.viw_conf_sol_pag_head_u.contract_id_sph%TYPE;
      v_contract_versao_sph         ifrbde.viw_conf_sol_pag_head_u.contract_versao_sph%TYPE;
      v_vendor_id                   ifrbde.viw_conf_sol_pag_head_u.vendor_id%TYPE;
      v_vendor_loc_code             ifrbde.viw_conf_sol_pag_head_u.vendor_loc_code%TYPE;
      v_pmt_rqst_nbr                ifrbde.viw_conf_sol_pag_head_u.pmt_rqst_nbr%TYPE;
      v_pmt_rqst_date               ifrbde.viw_conf_sol_pag_head_u.pmt_rqst_date%TYPE;
      v_schld_pmt_nbr               ifrbde.viw_conf_sol_pag_head_u.schld_pmt_nbr%TYPE;
      v_tipo_sp                     ifrbde.viw_conf_sol_pag_head_u.tipo_sp%TYPE;
      v_vendor_id_origem            ifrbde.viw_conf_sol_pag_head_u.vendor_id_origem%TYPE;
      v_vendor_loc_code_origem      ifrbde.viw_conf_sol_pag_head_u.vendor_loc_code_origem%TYPE;
      v_pmt_rqst_nbr_origem         ifrbde.viw_conf_sol_pag_head_u.pmt_rqst_nbr_origem%TYPE;
      v_pmt_rqst_date_origem        ifrbde.viw_conf_sol_pag_head_u.pmt_rqst_date_origem%TYPE;
      v_schld_pmt_nbr_origem        ifrbde.viw_conf_sol_pag_head_u.schld_pmt_nbr_origem%TYPE;
      v_prim_amt                    ifrbde.viw_conf_sol_pag_head_u.prim_amt%TYPE;
      v_secdy_amt                   ifrbde.viw_conf_sol_pag_head_u.secdy_amt%TYPE;
      v_sp_status_code              ifrbde.viw_conf_sol_pag_head_u.sp_status_code%TYPE;
      v_user_id_created_sph         ifrbde.viw_conf_sol_pag_head_u.user_id_created_sph%TYPE;
      v_dado                        VARCHAR2 (4000) := NULL;
   BEGIN
      IF ifrseg.pck_seguranca.stf_permitido (p_usuario,
                                             'VIW_CONF_SOL_PAG_HEAD_U',
                                             'ALTERA'
                                            ) THEN
         OPEN c_cursor;

         FETCH c_cursor
          INTO v_viw_conf_sol_pag_head_u;

         IF NOT c_cursor%NOTFOUND THEN
            v_payable_entity_id_sph :=
                                     RTRIM (LTRIM (vi_payable_entity_id_sph));
            v_contract_id_sph := RTRIM (LTRIM (vi_contract_id_sph));
            v_contract_versao_sph := RTRIM (LTRIM (vi_contract_versao_sph));
            v_vendor_id := RTRIM (LTRIM (vi_vendor_id));
            v_vendor_loc_code := RTRIM (LTRIM (vi_vendor_loc_code));
            v_pmt_rqst_nbr := RTRIM (LTRIM (vi_pmt_rqst_nbr));
            v_tipo_sp := RTRIM (LTRIM (vi_tipo_sp));
            v_vendor_id_origem := RTRIM (LTRIM (vi_vendor_id_origem));
            v_vendor_loc_code_origem :=
                                    RTRIM (LTRIM (vi_vendor_loc_code_origem));
            v_pmt_rqst_nbr_origem := RTRIM (LTRIM (vi_pmt_rqst_nbr_origem));
            v_prim_amt := RTRIM (LTRIM (vi_prim_amt));
            v_sp_status_code := RTRIM (LTRIM (vi_sp_status_code));
            v_user_id_created_sph := RTRIM (LTRIM (vi_user_id_created_sph));
            v_pmt_rqst_date := TO_DATE (vi_pmt_rqst_date, 'DD/MM/YYYY');
            v_pmt_rqst_date_origem :=
                              TO_DATE (vi_pmt_rqst_date_origem, 'DD/MM/YYYY');
            v_schld_pmt_nbr := vi_schld_pmt_nbr;
            v_schld_pmt_nbr_origem := vi_schld_pmt_nbr_origem;
            v_secdy_amt := vi_secdy_amt;

            UPDATE ifrbde.viw_conf_sol_pag_head_u
               SET pmt_rqst_date = v_pmt_rqst_date,
                   schld_pmt_nbr = v_schld_pmt_nbr,
                   tipo_sp = v_tipo_sp,
                   vendor_id_origem = v_vendor_id_origem,
                   vendor_loc_code_origem = v_vendor_loc_code_origem,
                   pmt_rqst_nbr_origem = v_pmt_rqst_nbr_origem,
                   pmt_rqst_date_origem = v_pmt_rqst_date_origem,
                   schld_pmt_nbr_origem = v_schld_pmt_nbr_origem,
                   prim_amt = v_prim_amt,
                   secdy_amt = v_secdy_amt,
                   sp_status_code = v_sp_status_code,
                   user_id_created_sph = v_user_id_created_sph
             WHERE CURRENT OF c_cursor;

            IF SQL%ROWCOUNT = 1 THEN
               stp_pesquisa_conf_sol_pag_head (p_usuario,
                                               vo_payable_entity_id_sph,
                                               vo_contract_id_sph,
                                               vo_contract_versao_sph,
                                               vo_vendor_id,
                                               vo_vendor_loc_code,
                                               vo_pmt_rqst_nbr,
                                               vo_pmt_rqst_date,
                                               vo_schld_pmt_nbr,
                                               vo_tipo_sp,
                                               vo_vendor_id_origem,
                                               vo_vendor_loc_code_origem,
                                               vo_pmt_rqst_nbr_origem,
                                               vo_pmt_rqst_date_origem,
                                               vo_schld_pmt_nbr_origem,
                                               vo_prim_amt,
                                               vo_secdy_amt,
                                               vo_sp_status_code,
                                               vo_sistema_origem_code_sph,
                                               vo_contract_versao_origem_sph,
                                               vo_date_created_sph,
                                               vo_user_id_created_sph,
                                               vo_date_changed_sph,
                                               vo_user_id_changed_sph,
                                               vo_inactive_ind_sph,
                                               vo_active_date_sph,
                                               vi_payable_entity_id_sph,
                                               vi_contract_id_sph,
                                               vi_contract_versao_sph,
                                               vi_vendor_id,
                                               vi_vendor_loc_code,
                                               vi_pmt_rqst_nbr
                                              );
               v_dado :=
                  'payable_entity_id_sph = '
                  || RTRIM (LTRIM (v_payable_entity_id_sph));
               v_dado :=
                  v_dado
                  || ','
                  || 'contract_id_sph = '
                  || RTRIM (LTRIM (v_contract_id_sph));
               v_dado :=
                  v_dado
                  || ','
                  || 'contract_versao_sph = '
                  || RTRIM (LTRIM (v_contract_versao_sph));
               v_dado :=
                  v_dado || ',' || 'vendor_id = '
                  || RTRIM (LTRIM (v_vendor_id));
               v_dado :=
                  v_dado
                  || ','
                  || 'vendor_loc_code = '
                  || RTRIM (LTRIM (v_vendor_loc_code));
               v_dado :=
                  v_dado
                  || ','
                  || 'pmt_rqst_nbr = '
                  || RTRIM (LTRIM (v_pmt_rqst_nbr));
               v_dado :=
                  v_dado
                  || ','
                  || 'pmt_rqst_date = '
                  || TO_CHAR (v_pmt_rqst_date, 'DD/MM/YYYY');
               v_dado :=
                  v_dado
                  || ','
                  || 'schld_pmt_nbr = '
                  || TO_CHAR (v_schld_pmt_nbr);
               v_dado :=
                    v_dado || ',' || 'tipo_sp = ' || RTRIM (LTRIM (v_tipo_sp));
               v_dado :=
                  v_dado
                  || ','
                  || 'vendor_id_origem = '
                  || RTRIM (LTRIM (v_vendor_id_origem));
               v_dado :=
                  v_dado
                  || ','
                  || 'vendor_loc_code_origem = '
                  || RTRIM (LTRIM (v_vendor_loc_code_origem));
               v_dado :=
                  v_dado
                  || ','
                  || 'pmt_rqst_nbr_origem = '
                  || RTRIM (LTRIM (v_pmt_rqst_nbr_origem));
               v_dado :=
                  v_dado
                  || ','
                  || 'pmt_rqst_date_origem = '
                  || TO_CHAR (v_pmt_rqst_date_origem, 'DD/MM/YYYY');
               v_dado :=
                  v_dado
                  || ','
                  || 'schld_pmt_nbr_origem = '
                  || TO_CHAR (v_schld_pmt_nbr_origem);
               v_dado :=
                  v_dado || ',' || 'prim_amt = ' || RTRIM (LTRIM (v_prim_amt));
               v_dado :=
                      v_dado || ',' || 'secdy_amt = ' || TO_CHAR (v_secdy_amt);
               v_dado :=
                  v_dado
                  || ','
                  || 'sp_status_code = '
                  || RTRIM (LTRIM (v_sp_status_code));
               v_dado :=
                  v_dado
                  || ','
                  || 'user_id_created_sph = '
                  || RTRIM (LTRIM (v_user_id_created_sph));
               -- LOG
               ifrseg.pck_seguranca.stp_log (p_usuario,
                                             'VIW_CONF_SOL_PAG_HEAD_U',
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
END;
/

-- Grants for Package Body
GRANT EXECUTE ON ifrbde.pck_integracao TO bde_geral
/


-- End of DDL Script for Package Body IFRBDE.PCK_INTEGRACAO

