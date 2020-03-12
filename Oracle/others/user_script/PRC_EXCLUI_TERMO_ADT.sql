CREATE OR REPLACE 
PROCEDURE prc_exclui_termo_adt (
   vi_nome_contrato           IN       ifrbde.viw_exclui_termo_aditivo.cnt_cod_res_ex%type,
   vi_versao_ret              IN       ifrbde.viw_exclui_termo_aditivo.num_versao_contrato_res_ex%type
) IS
--
-- OBJETIVO: excluir o último Termo Aditivo de um contrato retornando a versão anterior
--
-- MODIFICATION HISTORY
-- Person      Date    Comments
-- Carlão   29/7/2005  criada
-- ---------   ------  -------------------------------------------
--
   versao_ret                    VARCHAR2 (3);
   p_nome_contrato               VARCHAR2 (30);
   v_nome_contrato               ifrbde.viw_exclui_termo_aditivo.cnt_cod_res_ex%type;
   CURSOR cc (
      v_nome_contrato                     ifrbde.viw_exclui_termo_aditivo.cnt_cod_res_ex%type
   ) IS
      SELECT     *
            FROM ifrbde.tab_contrato
           WHERE cnt_cod = v_nome_contrato
      FOR UPDATE;
   CURSOR cv (
      v_num_seq_contrato_res              NUMBER
   ) IS
      SELECT     *
            FROM ifrbde.cad_resumo_valores
           WHERE num_seq_contrato_res = v_num_seq_contrato_res
      FOR UPDATE;
   CURSOR ct (
      v_num_seq_contrato_origem           NUMBER,
      v_versao_ret                        VARCHAR2
   ) IS
      SELECT     *
            FROM ifrbde.cad_termo_aditivo_contrato
           WHERE num_seq_contrato_origem = v_num_seq_contrato_origem
             AND num_versao_contrato_ta = v_versao_ret
      FOR UPDATE;
   CURSOR cp (
      v_num_seq_pag_contrato_rp           NUMBER,
      v_versao_ret                        VARCHAR2
   ) IS
      SELECT     *
            FROM ifrbde.cad_resumo_pagamento
           WHERE num_seq_pag_contrato_rp = v_num_seq_pag_contrato_rp
             AND num_versao_contrato_pag = v_versao_ret
      FOR UPDATE;
   CURSOR tc (
      v_num_seq_contrato_cron             NUMBER,
      v_versao_ret                        VARCHAR2
   ) IS
      SELECT     *
            FROM ifrbde.tab_cont_crono_pagamento
           WHERE num_seq_contrato_cron = v_num_seq_contrato_cron
             AND num_versao_contrato_cron = v_versao_ret
      FOR UPDATE;
   CURSOR tt (
      v_num_seq_contrato_termo            NUMBER,
      v_versao_ret                        VARCHAR2
   ) IS
      SELECT     *
            FROM ifrbde.tab_cont_termo_aditivo
           WHERE num_seq_contrato_termo = v_num_seq_contrato_termo
             AND num_versao_contrato_vta = v_versao_ret
      FOR UPDATE;
BEGIN
   versao_ret := vi_versao_ret;
   FOR reg_cc IN cc (vi_nome_contrato)
   LOOP
      p_nome_contrato := reg_cc.cnt_cod;
--
      UPDATE ifrbde.tab_contrato
         SET num_termo_aditivo = '',
             tip_situacao_contrato = 4
       WHERE CURRENT OF cc;
--
      FOR reg_cv IN cv (reg_cc.num_seq_contrato)
      LOOP
         UPDATE ifrbde.cad_resumo_valores
            SET num_versao_contrato_res =
                              TRIM (TO_CHAR (TO_NUMBER (versao_ret) - 1, '00'))
          WHERE CURRENT OF cv;
--
         FOR reg_cp IN cp (reg_cv.num_seq_resumo, versao_ret)
         LOOP
            UPDATE ifrbde.cad_resumo_pagamento
               SET num_versao_contrato_pag =
                              TRIM (TO_CHAR (TO_NUMBER (versao_ret) - 1, '00'))
             WHERE CURRENT OF cp;
         END LOOP;
--
         FOR reg_tc IN tc (reg_cv.num_seq_resumo, versao_ret)
         LOOP
            UPDATE ifrbde.tab_cont_crono_pagamento
               SET num_versao_contrato_cron =
                              TRIM (TO_CHAR (TO_NUMBER (versao_ret) - 1, '00'))
             WHERE CURRENT OF tc;
         END LOOP;
      END LOOP;
--
      FOR reg_ct IN ct (reg_cc.num_seq_contrato, versao_ret)
      LOOP
         DELETE FROM ifrbde.cad_termo_aditivo_contrato
               WHERE CURRENT OF ct;
      END LOOP;
--
      FOR reg_tt IN tt (reg_cc.num_seq_contrato, versao_ret)
      LOOP
         DELETE FROM ifrbde.tab_cont_termo_aditivo
               WHERE CURRENT OF tt;
      END LOOP;
--
      UPDATE ifrbde.tab_contrato
         SET num_versao_contrato =
                              TRIM (TO_CHAR (TO_NUMBER (versao_ret) - 1, '00'))
       WHERE CURRENT OF cc;
--
   END LOOP;
   versao_ret := TRIM (TO_CHAR (TO_NUMBER (versao_ret) - 1, '00'));
   IF versao_ret <> '00' THEN
--
      FOR reg_cc IN cc (p_nome_contrato)
      LOOP
--
         FOR reg_ct IN ct (reg_cc.num_seq_contrato, versao_ret)
         LOOP
--
            UPDATE ifrbde.tab_contrato
               SET num_termo_aditivo = reg_ct.num_termo_aditivo
             WHERE CURRENT OF cc;
--
         END LOOP;
      END LOOP;
--
   END IF;
--
   COMMIT;
EXCEPTION
   WHEN OTHERS THEN
      raise_application_error
                         (-20100,
                          'Não foi possível retornar a versão anterior a '
                          || versao_ret
                          || ' do contrato '
                          || v_nome_contrato
                          || ' '
                          || SQLERRM
                         );
END prc_exclui_termo_adt;
/

-- Grants for Procedure
GRANT EXECUTE ON prc_exclui_termo_adt TO bde_geral
/


-- End of DDL Script for Procedure IFRBDE.PRC_EXCLUI_TERMO_ADT

