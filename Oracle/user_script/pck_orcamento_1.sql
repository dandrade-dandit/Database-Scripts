/* Formatted on 2005/03/29 10:03 (Formatter Plus v4.5.2) */
CREATE OR REPLACE PACKAGE ifrbde.pck_orcamento
IS
   -- tipos globais
   TYPE tyt_ok IS TABLE OF NUMBER (1)
      INDEX BY BINARY_INTEGER;

   SUBTYPE t_data IS CHAR (10);

   TYPE tyt_data IS TABLE OF t_data
      INDEX BY BINARY_INTEGER;

   --- VIW_REMANEJAMENTO
   SUBTYPE t_rmj_cod IS ifrbde.viw_remanejamento.rmj_cod%TYPE;

   SUBTYPE t_rmj_ano IS ifrbde.viw_remanejamento.rmj_ano%TYPE;

   SUBTYPE t_rmj_seq_orig IS ifrbde.viw_remanejamento.rmj_seq_orig%TYPE;

   SUBTYPE t_rmj_rti_cod_orig IS ifrbde.viw_remanejamento.rmj_rti_cod_orig%TYPE;

   SUBTYPE t_rmj_dep_orig IS ifrbde.viw_remanejamento.rmj_dep_orig%TYPE;

   SUBTYPE t_val_aprovacao_origem IS ifrbde.viw_remanejamento.val_aprovacao_origem%TYPE;

   SUBTYPE t_rmj_obj_orig IS ifrbde.viw_remanejamento.rmj_obj_orig%TYPE;

   SUBTYPE t_rmj_seq_dest IS ifrbde.viw_remanejamento.rmj_seq_dest%TYPE;

   SUBTYPE t_rmj_rti_cod_dest IS ifrbde.viw_remanejamento.rmj_rti_cod_dest%TYPE;

   SUBTYPE t_rmj_dep_dest IS ifrbde.viw_remanejamento.rmj_dep_dest%TYPE;

   SUBTYPE t_val_aprovacao_destino IS ifrbde.viw_remanejamento.val_aprovacao_destino%TYPE;

   SUBTYPE t_rmj_obj_dest IS ifrbde.viw_remanejamento.rmj_obj_dest%TYPE;

   SUBTYPE t_rmj_valor IS ifrbde.viw_remanejamento.rmj_valor%TYPE;

   SUBTYPE t_dat_remanejamento IS t_data;

   SUBTYPE t_rmj_usuario IS ifrbde.viw_remanejamento.rmj_usuario%TYPE;

   SUBTYPE t_dsc_justificativa IS ifrbde.viw_remanejamento.dsc_justificativa%TYPE;

   TYPE tyt_rmj_cod IS TABLE OF t_rmj_cod
      INDEX BY BINARY_INTEGER;

   TYPE tyt_rmj_ano IS TABLE OF t_rmj_ano
      INDEX BY BINARY_INTEGER;

   TYPE tyt_rmj_seq_orig IS TABLE OF t_rmj_seq_orig
      INDEX BY BINARY_INTEGER;

   TYPE tyt_rmj_rti_cod_orig IS TABLE OF t_rmj_rti_cod_orig
      INDEX BY BINARY_INTEGER;

   TYPE tyt_rmj_dep_orig IS TABLE OF t_rmj_dep_orig
      INDEX BY BINARY_INTEGER;

   TYPE tyt_val_aprovacao_origem IS TABLE OF t_val_aprovacao_origem
      INDEX BY BINARY_INTEGER;

   TYPE tyt_rmj_obj_orig IS TABLE OF t_rmj_obj_orig
      INDEX BY BINARY_INTEGER;

   TYPE tyt_rmj_seq_dest IS TABLE OF t_rmj_seq_dest
      INDEX BY BINARY_INTEGER;

   TYPE tyt_rmj_rti_cod_dest IS TABLE OF t_rmj_rti_cod_dest
      INDEX BY BINARY_INTEGER;

   TYPE tyt_rmj_dep_dest IS TABLE OF t_rmj_dep_dest
      INDEX BY BINARY_INTEGER;

   TYPE tyt_val_aprovacao_destino IS TABLE OF t_val_aprovacao_destino
      INDEX BY BINARY_INTEGER;

   TYPE tyt_rmj_obj_dest IS TABLE OF t_rmj_obj_dest
      INDEX BY BINARY_INTEGER;

   TYPE tyt_rmj_valor IS TABLE OF t_rmj_valor
      INDEX BY BINARY_INTEGER;

   TYPE tyt_dat_remanejamento IS TABLE OF t_dat_remanejamento
      INDEX BY BINARY_INTEGER;

   TYPE tyt_rmj_usuario IS TABLE OF t_rmj_usuario
      INDEX BY BINARY_INTEGER;

   TYPE tyt_dsc_justificativa IS TABLE OF t_dsc_justificativa
      INDEX BY BINARY_INTEGER;

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
   );

   PROCEDURE stp_exclui_remanejamento (
      p_usuario    IN       VARCHAR2,
      vo_ok        OUT      tyt_ok,
      vi_rmj_cod   IN       t_rmj_cod
   );

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
   );

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
   );
END; -- Package spec
/

-- Grants for Package
GRANT EXECUTE ON ifrbde.pck_orcamento TO bde_geral
/
-- End of DDL Script for Package IFRBDE.PCK_ORCAMENTO

