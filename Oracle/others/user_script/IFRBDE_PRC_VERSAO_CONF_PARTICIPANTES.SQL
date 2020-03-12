CREATE OR REPLACE PROCEDURE PRC_VERSAO_CONF_PARTICIPANTES (v_num_seq_contrato IN varchar2 , v_versao in varchar2)
IS
   
--
-- OBJETIVO: executar a carga dos contratos para o arquivo de interface do
-- smartstream chamado conf_participantes
--
-- MODIFICATION HISTORY
-- Person      Date    Comments
-- ---------   ------  -------------------------------------------
--
--
   v_erro                  VARCHAR2 (200);
   v_sucesso               NUMBER (1);
   v_achou                 VARCHAR2 (30);
   v_cnpj                  VARCHAR2 (14);
   v_cnpj_p1               VARCHAR2 (10);
   v_cnpj_p2               VARCHAR2 (3);
   v_relacao               VARCHAR2 (2);
   v_entidade              VARCHAR2 (5);
   v_contrato_id           VARCHAR2 (30);
   v_num_versao_anterior   VARCHAR2 (2);

   CURSOR regc
   IS
      SELECT a.*, b.*, y.dpp_ncod, x.dep_cod
        FROM ifrbde.tab_contrato a,
             ifrbde.tab_firma b,
             ifrbde.cad_participantes_contrato c,
             ifrbde.tab_dependencia x,
             ifrbde.tab_dependencia_pai y,
             ifrbde.tab_carencia z
       WHERE a.num_seq_contrato = c.num_seq_contrato_part
         AND c.num_fir_cod = b.fir_cod
         AND a.cnt_cre_cod = z.cre_cod
         AND z.cre_dep_cod = x.dep_cod
         AND x.dep_dpp_cod = y.dpp_cod
--         AND SUBSTR (a.cnt_cod, 1, 2) <> 'CV'
--         AND flg_numero_padrao = 'S'
--         AND a.num_seq_contrato = v_num_seq_contrato;
         AND a.cnt_cod = v_num_seq_contrato;
-- Declare program variables as shown above
BEGIN
   v_sucesso := 0;
   v_erro := '';
   v_achou := '';

   FOR regs IN regc
   LOOP
      BEGIN
         v_sucesso := 0;
         v_erro := '';
         v_cnpj := '';
         v_entidade :=    TRIM (TO_CHAR (regs.dpp_ncod, '00'))
                             || TRIM (
                                   TO_CHAR (
                                      fun_converter_dep (regs.dep_cod),
                                      '000'
                                   )
                                );
         v_contrato_id := regs.cnt_cod;

         FOR i IN 1 .. 20
         LOOP
            IF SUBSTR (regs.fir_cnpj, i, 1) NOT IN ('.', '/', '-', ' ')
            THEN
               v_cnpj :=    v_cnpj
                         || SUBSTR (regs.fir_cnpj, i, 1);
            END IF;
         END LOOP;

         
--

         IF LENGTH (v_cnpj) = 14
         THEN
            v_cnpj_p1 := SUBSTR (v_cnpj, 1, 9);
            v_cnpj_p2 := SUBSTR (v_cnpj, 10, 3);
         ELSE
            IF LENGTH (v_cnpj) = 11
            THEN
               v_cnpj_p1 := SUBSTR (v_cnpj, 1, 9);
               v_cnpj_p2 := ' ';
            ELSE
               v_cnpj_p1 := '999999999';
               v_cnpj_p2 := '999';
            END IF;
         END IF;

         
--

         IF regs.tip_contrato = 1
         THEN
            v_relacao := '01';
         ELSE
            v_relacao := '05';
         END IF;

         
--

         IF NVL (v_versao, '00') <> '00'
         THEN
            v_num_versao_anterior :=
                  TRIM (
                     TO_CHAR (
                          TO_NUMBER (NVL (v_versao, '00'))
                        - 1,
                        '00'
                     )
                  );
         ELSE
            v_num_versao_anterior := '00';
         END IF;

         
--

         BEGIN
            SELECT contract_id
              INTO v_achou
              FROM integracao.conf_participantes_u
             WHERE contract_id = v_contrato_id
               AND contract_versao = NVL (v_versao, '00')
               AND vendor_id = v_cnpj_p1
               AND vendor_loc_code = v_cnpj_p2;

            UPDATE integracao.conf_participantes_u
               SET payable_entity_id = v_entidade,
                   addr_fmt = 'GN3',
                   addr_line_1 = ' ',
                   street_or_post_office_box_1 = ' ',
                   street_or_post_office_box_2 = ' ',
                   city_name = ' ',
                   country_sub_entity_code = ' ',
                   postal_code = ' ',
                   country_code = '  ',
                   com_ddd = ' ',
                   com_tel = ' ',
                   com_fax = '  ',
                   com_email = NVL (regs.fir_email, ' '),
                   cod_relacao_contrato = v_relacao,
                   type_of_pmt = 'BT',
                   seq_nbr = ' ',
                   sistema_origem_code = '02',
                   contract_versao_origem = v_num_versao_anterior,
                   date_changed = SYSDATE,
                   user_id_changed = USER,
                   inactive_ind = '0',
                   active_date = SYSDATE
             WHERE contract_id = v_contrato_id
               AND contract_versao = NVL (v_versao, '00')
               AND vendor_id = v_cnpj_p1
               AND vendor_loc_code = v_cnpj_p2;
         EXCEPTION
            WHEN NO_DATA_FOUND
            THEN
               BEGIN
                  INSERT INTO integracao.conf_participantes_u
                              (payable_entity_id, contract_id,
                               contract_versao,
                               vendor_id, vendor_loc_code, addr_fmt,
                               addr_line_1, street_or_post_office_box_1,
                               street_or_post_office_box_2, city_name,
                               country_sub_entity_code, postal_code,
                               country_code, com_ddd, com_tel, com_fax,
                               com_email, cod_relacao_contrato, type_of_pmt,
                               seq_nbr, sistema_origem_code,
                               contract_versao_origem, date_created,
                               user_id_created, date_changed,
                               user_id_changed, inactive_ind, active_date,
                               chgstamp)
                       VALUES (v_entidade, v_contrato_id,
                               NVL (v_versao, '00'),
                               v_cnpj_p1, v_cnpj_p2, 'GN3',
                               ' ', ' ',
                               ' ', ' ',
                               ' ', ' ',
                               ' ', ' ', ' ', ' ',
                               NVL (regs.fir_email, ' '), v_relacao, 'BT',
                               ' ', '02',
                               v_num_versao_anterior, SYSDATE,
                               USER, SYSDATE,
                               USER, '0', SYSDATE,
                               0);
               EXCEPTION
                  WHEN OTHERS
                  THEN
                     raise_application_error (
                        -20100,
                           v_contrato_id
                        || ' - '
                        || SQLERRM
                     );
               END;
            WHEN OTHERS
            THEN
               raise_application_error (
                  -20100,
                     TO_CHAR (regs.num_seq_contrato)
                  || ' - '
                  || SQLERRM
               );
         END;

         

--
      EXCEPTION
         WHEN OTHERS
         THEN
            raise_application_error (
               -20100,
                  'Erro ao gerar o cadastro de participantes '
               || TO_CHAR (regs.num_seq_contrato)
               || ' - '
               || SQLERRM
            );
      END;
   END LOOP;
END PRC_VERSAO_CONF_PARTICIPANTES; -- Procedure
