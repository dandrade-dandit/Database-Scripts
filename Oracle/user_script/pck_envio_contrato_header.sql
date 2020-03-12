/* Formatted on 2007/01/05 15:19 (Formatter Plus v4.8.0) */
CREATE OR REPLACE PACKAGE ifrbde.pck_envio_contrato
IS
   -- tipos globais
   TYPE tyt_ok IS TABLE OF NUMBER (1)
      INDEX BY BINARY_INTEGER;

   SUBTYPE t_data IS CHAR (10);

   TYPE tyt_data IS TABLE OF t_data
      INDEX BY BINARY_INTEGER;

--------------------------------------------------------------------------------
   --- VIW_ENVIO_CONTRATO
   SUBTYPE t_tip_comando IS ifrbde.viw_envio_contrato.tip_comando%TYPE;

   SUBTYPE t_num_seq_contrato IS ifrbde.viw_envio_contrato.num_seq_contrato%TYPE;

   SUBTYPE t_cnt_cre_cod IS ifrbde.viw_envio_contrato.cnt_cre_cod%TYPE;

   SUBTYPE t_cnt_cod IS ifrbde.viw_envio_contrato.cnt_cod%TYPE;

   SUBTYPE t_num_versao_contrato IS ifrbde.viw_envio_contrato.num_versao_contrato%TYPE;

   SUBTYPE t_cod_dep_contrato IS ifrbde.viw_envio_contrato.cod_dep_contrato%TYPE;

   SUBTYPE t_tip_situacao_contrato IS ifrbde.viw_envio_contrato.tip_situacao_contrato%TYPE;

   TYPE tyt_tip_comando IS TABLE OF t_tip_comando
      INDEX BY BINARY_INTEGER;

   TYPE tyt_num_seq_contrato IS TABLE OF t_num_seq_contrato
      INDEX BY BINARY_INTEGER;

   TYPE tyt_cnt_cre_cod IS TABLE OF t_cnt_cre_cod
      INDEX BY BINARY_INTEGER;

   TYPE tyt_cnt_cod IS TABLE OF t_cnt_cod
      INDEX BY BINARY_INTEGER;

   TYPE tyt_num_versao_contrato IS TABLE OF t_num_versao_contrato
      INDEX BY BINARY_INTEGER;

   TYPE tyt_cod_dep_contrato IS TABLE OF t_cod_dep_contrato
      INDEX BY BINARY_INTEGER;

   TYPE tyt_tip_situacao_contrato IS TABLE OF t_tip_situacao_contrato
      INDEX BY BINARY_INTEGER;

   PROCEDURE stp_pesquisa_envio_contrato (
      p_usuario                  IN       VARCHAR2,
      vo_tip_comando             OUT      tyt_tip_comando,
      vo_num_seq_contrato        OUT      tyt_num_seq_contrato,
      vo_cnt_cre_cod             OUT      tyt_cnt_cre_cod,
      vo_cnt_cod                 OUT      tyt_cnt_cod,
      vo_num_versao_contrato     OUT      tyt_num_versao_contrato,
      vo_cod_dep_contrato        OUT      tyt_cod_dep_contrato,
      vo_tip_situacao_contrato   OUT      tyt_tip_situacao_contrato,
      vi_num_seq_contrato        IN       t_num_seq_contrato
   );

   PROCEDURE stp_altera_envio_contrato (
      p_usuario                  IN       VARCHAR2,
      vo_tip_comando             OUT      tyt_tip_comando,
      vo_num_seq_contrato        OUT      tyt_num_seq_contrato,
      vo_cnt_cre_cod             OUT      tyt_cnt_cre_cod,
      vo_cnt_cod                 OUT      tyt_cnt_cod,
      vo_num_versao_contrato     OUT      tyt_num_versao_contrato,
      vo_cod_dep_contrato        OUT      tyt_cod_dep_contrato,
      vo_tip_situacao_contrato   OUT      tyt_tip_situacao_contrato,
      vi_tip_comando             IN       t_tip_comando,
      vi_num_seq_contrato        IN       t_num_seq_contrato,
      vi_cnt_cre_cod             IN       t_cnt_cre_cod,
      vi_cnt_cod                 IN       t_cnt_cod,
      vi_num_versao_contrato     IN       t_num_versao_contrato,
      vi_cod_dep_contrato        IN       t_cod_dep_contrato,
      vi_tip_situacao_contrato   IN       t_tip_situacao_contrato
   );
--------------------------------------------------------------------------------
END;                                                           -- Package spec
/

-- Grants for Package
GRANT EXECUTE ON ifrbde.pck_envio_contrato TO bde_geral
--/

