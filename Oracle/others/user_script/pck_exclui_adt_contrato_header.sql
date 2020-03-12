/* Formatted on 2007/01/03 11:09 (Formatter Plus v4.8.0) */
CREATE OR REPLACE PACKAGE ifrbde.pck_exclui_adt_contrato
IS
   -- tipos globais
   TYPE tyt_ok IS TABLE OF NUMBER (1)
      INDEX BY BINARY_INTEGER;

   SUBTYPE t_data IS CHAR (10);

   TYPE tyt_data IS TABLE OF t_data
      INDEX BY BINARY_INTEGER;

--------------------------------------------------------------------------------
   --- VIW_EXCLUI_TERMO_ADITIVO
   --- ************* ATENÇÃO *************
   -- PROCEDURE ALTERADA NA ALTERAÇÃO
   --
   SUBTYPE t_cnt_cre_cod_res_ex IS ifrbde.viw_exclui_termo_aditivo.cnt_cre_cod_res_ex%TYPE;

   SUBTYPE t_cnt_cod_res_ex IS ifrbde.viw_exclui_termo_aditivo.cnt_cod_res_ex%TYPE;

   SUBTYPE t_num_versao_contrato_res_ex IS ifrbde.viw_exclui_termo_aditivo.num_versao_contrato_res_ex%TYPE;

   TYPE tyt_cnt_cre_cod_res_ex IS TABLE OF t_cnt_cre_cod_res_ex
      INDEX BY BINARY_INTEGER;

   TYPE tyt_cnt_cod_res_ex IS TABLE OF t_cnt_cod_res_ex
      INDEX BY BINARY_INTEGER;

   TYPE tyt_num_versao_contrato_res_ex IS TABLE OF t_num_versao_contrato_res_ex
      INDEX BY BINARY_INTEGER;

   PROCEDURE stp_pesquisa_exclui_termo_adit (
      p_usuario                       IN       VARCHAR2,
      vo_cnt_cre_cod_res_ex           OUT      tyt_cnt_cre_cod_res_ex,
      vo_cnt_cod_res_ex               OUT      tyt_cnt_cod_res_ex,
      vo_num_versao_contrato_res_ex   OUT      tyt_num_versao_contrato_res_ex,
      vi_cnt_cre_cod_res_ex           IN       t_cnt_cre_cod_res_ex,
      vi_cnt_cod_res_ex               IN       t_cnt_cod_res_ex
   );

   PROCEDURE stp_exclui_exclui_termo_aditiv (
      p_usuario                       IN       VARCHAR2,
      vo_ok                           OUT      tyt_ok,
      vi_cnt_cre_cod_res_ex           IN       t_cnt_cre_cod_res_ex,
      vi_cnt_cod_res_ex               IN       t_cnt_cod_res_ex,
      vi_num_versao_contrato_res_ex   IN       t_num_versao_contrato_res_ex
   );

   PROCEDURE stp_altera_exclui_termo_aditiv (
      p_usuario                       IN       VARCHAR2,
      vo_cnt_cre_cod_res_ex           OUT      tyt_cnt_cre_cod_res_ex,
      vo_cnt_cod_res_ex               OUT      tyt_cnt_cod_res_ex,
      vo_num_versao_contrato_res_ex   OUT      tyt_num_versao_contrato_res_ex,
      vi_cnt_cre_cod_res_ex           IN       t_cnt_cre_cod_res_ex,
      vi_cnt_cod_res_ex               IN       t_cnt_cod_res_ex,
      vi_num_versao_contrato_res_ex   IN       t_num_versao_contrato_res_ex
   );
--------------------------------------------------------------------------------
END;                                                           -- Package spec
/

-- Grants for Package
--GRANT EXECUTE ON ifrbde.pck_exclui_adt_contrato TO bde_geral
--/

