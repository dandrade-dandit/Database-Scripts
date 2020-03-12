
-- Start of DDL Script for Package IFRBDE.PCK_CARENCIA
-- Generated 2-dez-2004 20:33:59 from SYSMAN@HOMOLOG2

CREATE OR REPLACE PACKAGE ifrbde.pck_carencia
IS
   
--------------------------------------------------------------------------------
   -- tipos globais
   TYPE tyt_ok IS TABLE OF NUMBER (1)
      INDEX BY BINARY_INTEGER;

   SUBTYPE t_data IS CHAR (10);

   TYPE tyt_data IS TABLE OF t_data
      INDEX BY BINARY_INTEGER;

   
--------------------------------------------------------------------------------
   --- TAB_REC_APROVADO
   SUBTYPE t_num_seq_carencia_rec IS ifrbde.tab_rec_aprovado.num_seq_carencia_rec%TYPE;

   SUBTYPE t_rap_cre_cod IS ifrbde.tab_rec_aprovado.rap_cre_cod%TYPE;

   SUBTYPE t_rap_pgose IS ifrbde.tab_rec_aprovado.rap_pgose%TYPE;

   SUBTYPE t_rap_rti_cod IS ifrbde.tab_rec_aprovado.rap_rti_cod%TYPE;

   SUBTYPE t_rap_valor IS ifrbde.tab_rec_aprovado.rap_valor%TYPE;

   SUBTYPE t_rap_cre_pgi IS ifrbde.tab_rec_aprovado.rap_cre_pgi%TYPE;

   SUBTYPE t_rap_valor_pago IS ifrbde.tab_rec_aprovado.rap_valor_pago%TYPE;

   SUBTYPE t_val_saldo_recurso IS ifrbde.tab_rec_aprovado.val_saldo_recurso%TYPE;

   TYPE tyt_num_seq_carencia_rec IS TABLE OF t_num_seq_carencia_rec
      INDEX BY BINARY_INTEGER;

   TYPE tyt_rap_cre_cod IS TABLE OF t_rap_cre_cod
      INDEX BY BINARY_INTEGER;

   TYPE tyt_rap_pgose IS TABLE OF t_rap_pgose
      INDEX BY BINARY_INTEGER;

   TYPE tyt_rap_rti_cod IS TABLE OF t_rap_rti_cod
      INDEX BY BINARY_INTEGER;

   TYPE tyt_rap_valor IS TABLE OF t_rap_valor
      INDEX BY BINARY_INTEGER;

   TYPE tyt_rap_cre_pgi IS TABLE OF t_rap_cre_pgi
      INDEX BY BINARY_INTEGER;

   TYPE tyt_rap_valor_pago IS TABLE OF t_rap_valor_pago
      INDEX BY BINARY_INTEGER;

   TYPE tyt_val_saldo_recurso IS TABLE OF t_val_saldo_recurso
      INDEX BY BINARY_INTEGER;

   PROCEDURE stp_pesquisa_rec_aprovado (
      p_usuario                  IN       VARCHAR2,
      vo_num_seq_carencia_rec    OUT      tyt_num_seq_carencia_rec,
      vo_rap_cre_cod             OUT      tyt_rap_cre_cod,
      vo_rap_pgose               OUT      tyt_rap_pgose,
      vo_rap_rti_cod             OUT      tyt_rap_rti_cod,
      vo_rap_valor               OUT      tyt_rap_valor,
      vo_rap_cre_pgi             OUT      tyt_rap_cre_pgi,
      vo_rap_valor_pago          OUT      tyt_rap_valor_pago,
      vo_val_saldo_recurso       OUT      tyt_val_saldo_recurso,
      vi_num_seq_carencia_rec    IN       t_num_seq_carencia_rec,
      vi_rap_cre_cod             IN       t_rap_cre_cod);

   PROCEDURE stp_exclui_rec_aprovado (
      p_usuario                  IN       VARCHAR2,
      vo_ok                      OUT      tyt_ok,
      vi_num_seq_carencia_rec    IN       t_num_seq_carencia_rec,
      vi_rap_cre_cod             IN       t_rap_cre_cod);

   PROCEDURE stp_inclui_rec_aprovado (
      p_usuario                  IN       VARCHAR2,
      vo_num_seq_carencia_rec    OUT      tyt_num_seq_carencia_rec,
      vo_rap_cre_cod             OUT      tyt_rap_cre_cod,
      vo_rap_pgose               OUT      tyt_rap_pgose,
      vo_rap_rti_cod             OUT      tyt_rap_rti_cod,
      vo_rap_valor               OUT      tyt_rap_valor,
      vo_rap_cre_pgi             OUT      tyt_rap_cre_pgi,
      vo_rap_valor_pago          OUT      tyt_rap_valor_pago,
      vo_val_saldo_recurso       OUT      tyt_val_saldo_recurso,
      vi_rap_cre_cod             IN       t_rap_cre_cod,
      vi_rap_pgose               IN       t_rap_pgose,
      vi_rap_rti_cod             IN       t_rap_rti_cod,
      vi_rap_valor               IN       t_rap_valor,
      vi_rap_cre_pgi             IN       t_rap_cre_pgi,
      vi_rap_valor_pago          IN       t_rap_valor_pago,
      vi_val_saldo_recurso       IN       t_val_saldo_recurso);

   PROCEDURE stp_altera_rec_aprovado (
      p_usuario                  IN       VARCHAR2,
      vo_num_seq_carencia_rec    OUT      tyt_num_seq_carencia_rec,
      vo_rap_cre_cod             OUT      tyt_rap_cre_cod,
      vo_rap_pgose               OUT      tyt_rap_pgose,
      vo_rap_rti_cod             OUT      tyt_rap_rti_cod,
      vo_rap_valor               OUT      tyt_rap_valor,
      vo_rap_cre_pgi             OUT      tyt_rap_cre_pgi,
      vo_rap_valor_pago          OUT      tyt_rap_valor_pago,
      vo_val_saldo_recurso       OUT      tyt_val_saldo_recurso,
      vi_num_seq_carencia_rec    IN       t_num_seq_carencia_rec,
      vi_rap_cre_cod             IN       t_rap_cre_cod,
      vi_rap_pgose               IN       t_rap_pgose,
      vi_rap_rti_cod             IN       t_rap_rti_cod,
      vi_rap_valor               IN       t_rap_valor,
      vi_rap_cre_pgi             IN       t_rap_cre_pgi,
      vi_rap_valor_pago          IN       t_rap_valor_pago,
      vi_val_saldo_recurso       IN       t_val_saldo_recurso);

   
--------------------------------------------------------------------------------
   --- TAB_REC_PRECOMPROVADO
   SUBTYPE t_rpr_cre_cod IS ifrbde.tab_rec_precomprovado.rpr_cre_cod%TYPE;

   SUBTYPE t_rpr_pgose IS ifrbde.tab_rec_precomprovado.rpr_pgose%TYPE;

   SUBTYPE t_rpr_rti_cod IS ifrbde.tab_rec_precomprovado.rpr_rti_cod%TYPE;

   SUBTYPE t_rpr_num IS ifrbde.tab_rec_precomprovado.rpr_num%TYPE;

   SUBTYPE t_rpr_data IS t_data;

   SUBTYPE t_rpr_valor IS ifrbde.tab_rec_precomprovado.rpr_valor%TYPE;

   TYPE tyt_rpr_cre_cod IS TABLE OF t_rpr_cre_cod
      INDEX BY BINARY_INTEGER;

   TYPE tyt_rpr_pgose IS TABLE OF t_rpr_pgose
      INDEX BY BINARY_INTEGER;

   TYPE tyt_rpr_rti_cod IS TABLE OF t_rpr_rti_cod
      INDEX BY BINARY_INTEGER;

   TYPE tyt_rpr_num IS TABLE OF t_rpr_num
      INDEX BY BINARY_INTEGER;

   TYPE tyt_rpr_data IS TABLE OF t_rpr_data
      INDEX BY BINARY_INTEGER;

   TYPE tyt_rpr_valor IS TABLE OF t_rpr_valor
      INDEX BY BINARY_INTEGER;

   PROCEDURE stp_pesquisa_rec_precomprovado (
      p_usuario                  IN       VARCHAR2,
      vo_rpr_cre_cod             OUT      tyt_rpr_cre_cod,
      vo_rpr_pgose               OUT      tyt_rpr_pgose,
      vo_rpr_rti_cod             OUT      tyt_rpr_rti_cod,
      vo_rpr_num                 OUT      tyt_rpr_num,
      vo_rpr_data                OUT      tyt_rpr_data,
      vo_rpr_valor               OUT      tyt_rpr_valor,
      vi_rpr_cre_cod             IN       t_rpr_cre_cod,
      vi_rpr_pgose               IN       t_rpr_pgose,
      vi_rpr_rti_cod             IN       t_rpr_rti_cod,
      vi_rpr_num                 IN       t_rpr_num);

   PROCEDURE stp_exclui_rec_precomprovado (
      p_usuario                  IN       VARCHAR2,
      vo_ok                      OUT      tyt_ok,
      vi_rpr_cre_cod             IN       t_rpr_cre_cod,
      vi_rpr_pgose               IN       t_rpr_pgose,
      vi_rpr_rti_cod             IN       t_rpr_rti_cod,
      vi_rpr_num                 IN       t_rpr_num);

   PROCEDURE stp_inclui_rec_precomprovado (
      p_usuario                  IN       VARCHAR2,
      vo_rpr_cre_cod             OUT      tyt_rpr_cre_cod,
      vo_rpr_pgose               OUT      tyt_rpr_pgose,
      vo_rpr_rti_cod             OUT      tyt_rpr_rti_cod,
      vo_rpr_num                 OUT      tyt_rpr_num,
      vo_rpr_data                OUT      tyt_rpr_data,
      vo_rpr_valor               OUT      tyt_rpr_valor,
      vi_rpr_cre_cod             IN       t_rpr_cre_cod,
      vi_rpr_pgose               IN       t_rpr_pgose,
      vi_rpr_rti_cod             IN       t_rpr_rti_cod,
      vi_rpr_num                 IN       t_rpr_num,
      vi_rpr_data                IN       t_rpr_data,
      vi_rpr_valor               IN       t_rpr_valor);

   PROCEDURE stp_altera_rec_precomprovado (
      p_usuario                  IN       VARCHAR2,
      vo_rpr_cre_cod             OUT      tyt_rpr_cre_cod,
      vo_rpr_pgose               OUT      tyt_rpr_pgose,
      vo_rpr_rti_cod             OUT      tyt_rpr_rti_cod,
      vo_rpr_num                 OUT      tyt_rpr_num,
      vo_rpr_data                OUT      tyt_rpr_data,
      vo_rpr_valor               OUT      tyt_rpr_valor,
      vi_rpr_cre_cod             IN       t_rpr_cre_cod,
      vi_rpr_pgose               IN       t_rpr_pgose,
      vi_rpr_rti_cod             IN       t_rpr_rti_cod,
      vi_rpr_num                 IN       t_rpr_num,
      vi_rpr_data                IN       t_rpr_data,
      vi_rpr_valor               IN       t_rpr_valor);

   
--------------------------------------------------------------------------------
   --- VIW_CARENCIA
   SUBTYPE t_cre_cod IS ifrbde.viw_carencia.cre_cod%TYPE;

   SUBTYPE t_cre_dep_cod IS ifrbde.viw_carencia.cre_dep_cod%TYPE;

   SUBTYPE t_num_prioridade_superint IS ifrbde.viw_carencia.num_prioridade_superint%TYPE;

   SUBTYPE t_num_prioridade_carencia IS ifrbde.viw_carencia.num_prioridade_carencia%TYPE;

   SUBTYPE t_cre_projeto IS ifrbde.viw_carencia.cre_projeto%TYPE;

   SUBTYPE t_num_seq_pessoal_carencia IS ifrbde.viw_carencia.num_seq_pessoal_carencia%TYPE;

   SUBTYPE t_cre_desc IS ifrbde.viw_carencia.cre_desc%TYPE;

   SUBTYPE t_cre_justificativa IS ifrbde.viw_carencia.cre_justificativa%TYPE;

   SUBTYPE t_cre_aen_subcod IS ifrbde.viw_carencia.cre_aen_subcod%TYPE;

   SUBTYPE t_cre_ntf_cod IS ifrbde.viw_carencia.cre_ntf_cod%TYPE;

   SUBTYPE t_cod_detalhe_cliente IS ifrbde.viw_carencia.cod_detalhe_cliente%TYPE;

   SUBTYPE t_cre_prazo IS ifrbde.viw_carencia.cre_prazo%TYPE;

   SUBTYPE t_cre_inicio IS ifrbde.viw_carencia.cre_inicio%TYPE;

   SUBTYPE t_cre_termino IS ifrbde.viw_carencia.cre_termino%TYPE;

   SUBTYPE t_cre_data IS t_data;

   SUBTYPE t_cre_vlobras IS ifrbde.viw_carencia.cre_vlobras%TYPE;

   SUBTYPE t_cre_valor_aprov IS VARCHAR2 (32);

   SUBTYPE t_cre_valor_pago IS VARCHAR2 (32);

   SUBTYPE t_num_situacao_carencia IS ifrbde.viw_carencia.num_situacao_carencia%TYPE;

   SUBTYPE t_dsc_critica_carencia IS ifrbde.viw_carencia.dsc_critica_carencia%TYPE;

   SUBTYPE t_cre_tipo IS ifrbde.viw_carencia.cre_tipo%TYPE;

   TYPE tyt_cre_cod IS TABLE OF t_cre_cod
      INDEX BY BINARY_INTEGER;

   TYPE tyt_cre_dep_cod IS TABLE OF t_cre_dep_cod
      INDEX BY BINARY_INTEGER;

   TYPE tyt_num_prioridade_superint IS TABLE OF t_num_prioridade_superint
      INDEX BY BINARY_INTEGER;

   TYPE tyt_num_prioridade_carencia IS TABLE OF t_num_prioridade_carencia
      INDEX BY BINARY_INTEGER;

   TYPE tyt_cre_projeto IS TABLE OF t_cre_projeto
      INDEX BY BINARY_INTEGER;

   TYPE tyt_num_seq_pessoal_carencia IS TABLE OF t_num_seq_pessoal_carencia
      INDEX BY BINARY_INTEGER;

   TYPE tyt_cre_desc IS TABLE OF t_cre_desc
      INDEX BY BINARY_INTEGER;

   TYPE tyt_cre_justificativa IS TABLE OF t_cre_justificativa
      INDEX BY BINARY_INTEGER;

   TYPE tyt_cre_aen_subcod IS TABLE OF t_cre_aen_subcod
      INDEX BY BINARY_INTEGER;

   TYPE tyt_cre_ntf_cod IS TABLE OF t_cre_ntf_cod
      INDEX BY BINARY_INTEGER;

   TYPE tyt_cod_detalhe_cliente IS TABLE OF t_cod_detalhe_cliente
      INDEX BY BINARY_INTEGER;

   TYPE tyt_cre_prazo IS TABLE OF t_cre_prazo
      INDEX BY BINARY_INTEGER;

   TYPE tyt_cre_inicio IS TABLE OF t_cre_inicio
      INDEX BY BINARY_INTEGER;

   TYPE tyt_cre_termino IS TABLE OF t_cre_termino
      INDEX BY BINARY_INTEGER;

   TYPE tyt_cre_data IS TABLE OF t_cre_data
      INDEX BY BINARY_INTEGER;

   TYPE tyt_cre_vlobras IS TABLE OF t_cre_vlobras
      INDEX BY BINARY_INTEGER;

   TYPE tyt_cre_valor_aprov IS TABLE OF t_cre_valor_aprov
      INDEX BY BINARY_INTEGER;

   TYPE tyt_cre_valor_pago IS TABLE OF t_cre_valor_pago
      INDEX BY BINARY_INTEGER;

   TYPE tyt_num_situacao_carencia IS TABLE OF t_num_situacao_carencia
      INDEX BY BINARY_INTEGER;

   TYPE tyt_dsc_critica_carencia IS TABLE OF t_dsc_critica_carencia
      INDEX BY BINARY_INTEGER;

   TYPE tyt_cre_tipo IS TABLE OF t_cre_tipo
      INDEX BY BINARY_INTEGER;

   PROCEDURE stp_pesquisa_carencia (
      p_usuario                  IN       VARCHAR2,
      vo_cre_cod                 OUT      tyt_cre_cod,
      vo_cre_dep_cod             OUT      tyt_cre_dep_cod,
      vo_num_prioridade_superint OUT      tyt_num_prioridade_superint,
      vo_num_prioridade_carencia OUT      tyt_num_prioridade_carencia,
      vo_cre_projeto             OUT      tyt_cre_projeto,
      vo_num_seq_pessoal_carencia OUT     tyt_num_seq_pessoal_carencia,
      vo_cre_desc                OUT      tyt_cre_desc,
      vo_cre_justificativa       OUT      tyt_cre_justificativa,
      vo_cre_aen_subcod          OUT      tyt_cre_aen_subcod,
      vo_cre_ntf_cod             OUT      tyt_cre_ntf_cod,
      vo_cod_detalhe_cliente     OUT      tyt_cod_detalhe_cliente,
      vo_cre_prazo               OUT      tyt_cre_prazo,
      vo_cre_inicio              OUT      tyt_cre_inicio,
      vo_cre_termino             OUT      tyt_cre_termino,
      vo_cre_data                OUT      tyt_cre_data,
      vo_cre_vlobras             OUT      tyt_cre_vlobras,
      vo_cre_valor_aprov         OUT      tyt_cre_valor_aprov,
      vo_cre_valor_pago          OUT      tyt_cre_valor_pago,
      vo_num_situacao_carencia   OUT      tyt_num_situacao_carencia,
      vo_dsc_critica_carencia    OUT      tyt_dsc_critica_carencia,
      vo_cre_tipo                OUT      tyt_cre_tipo,
      vi_cre_cod                 IN       t_cre_cod);

   PROCEDURE stp_exclui_carencia (
      p_usuario                  IN       VARCHAR2,
      vo_ok                      OUT      tyt_ok,
      vi_cre_cod                 IN       t_cre_cod);

   PROCEDURE stp_inclui_carencia (
      p_usuario                  IN       VARCHAR2,
      vo_cre_cod                 OUT      tyt_cre_cod,
      vo_cre_dep_cod             OUT      tyt_cre_dep_cod,
      vo_num_prioridade_superint OUT      tyt_num_prioridade_superint,
      vo_num_prioridade_carencia OUT      tyt_num_prioridade_carencia,
      vo_cre_projeto             OUT      tyt_cre_projeto,
      vo_num_seq_pessoal_carencia OUT     tyt_num_seq_pessoal_carencia,
      vo_cre_desc                OUT      tyt_cre_desc,
      vo_cre_justificativa       OUT      tyt_cre_justificativa,
      vo_cre_aen_subcod          OUT      tyt_cre_aen_subcod,
      vo_cre_ntf_cod             OUT      tyt_cre_ntf_cod,
      vo_cod_detalhe_cliente     OUT      tyt_cod_detalhe_cliente,
      vo_cre_prazo               OUT      tyt_cre_prazo,
      vo_cre_inicio              OUT      tyt_cre_inicio,
      vo_cre_termino             OUT      tyt_cre_termino,
      vo_cre_data                OUT      tyt_cre_data,
      vo_cre_vlobras             OUT      tyt_cre_vlobras,
      vo_cre_valor_aprov         OUT      tyt_cre_valor_aprov,
      vo_cre_valor_pago          OUT      tyt_cre_valor_pago,
      vo_num_situacao_carencia   OUT      tyt_num_situacao_carencia,
      vo_dsc_critica_carencia    OUT      tyt_dsc_critica_carencia,
      vo_cre_tipo                OUT      tyt_cre_tipo,
      vi_cre_dep_cod             IN       t_cre_dep_cod,
      vi_num_prioridade_superint IN       t_num_prioridade_superint,
      vi_num_prioridade_carencia IN       t_num_prioridade_carencia,
      vi_cre_projeto             IN       t_cre_projeto,
      vi_num_seq_pessoal_carencia IN      t_num_seq_pessoal_carencia,
      vi_cre_desc                IN       t_cre_desc,
      vi_cre_justificativa       IN       t_cre_justificativa,
      vi_cre_aen_subcod          IN       t_cre_aen_subcod,
      vi_cre_ntf_cod             IN       t_cre_ntf_cod,
      vi_cod_detalhe_cliente     IN       t_cod_detalhe_cliente,
      vi_cre_prazo               IN       t_cre_prazo,
      vi_cre_inicio              IN       t_cre_inicio,
      vi_cre_termino             IN       t_cre_termino,
      vi_cre_data                IN       t_cre_data,
      vi_cre_vlobras             IN       t_cre_vlobras,
      vi_num_situacao_carencia   IN       t_num_situacao_carencia,
      vi_cre_tipo                IN       t_cre_tipo);

   PROCEDURE stp_altera_carencia (
      p_usuario                  IN       VARCHAR2,
      vo_cre_cod                 OUT      tyt_cre_cod,
      vo_cre_dep_cod             OUT      tyt_cre_dep_cod,
      vo_num_prioridade_superint OUT      tyt_num_prioridade_superint,
      vo_num_prioridade_carencia OUT      tyt_num_prioridade_carencia,
      vo_cre_projeto             OUT      tyt_cre_projeto,
      vo_num_seq_pessoal_carencia OUT     tyt_num_seq_pessoal_carencia,
      vo_cre_desc                OUT      tyt_cre_desc,
      vo_cre_justificativa       OUT      tyt_cre_justificativa,
      vo_cre_aen_subcod          OUT      tyt_cre_aen_subcod,
      vo_cre_ntf_cod             OUT      tyt_cre_ntf_cod,
      vo_cod_detalhe_cliente     OUT      tyt_cod_detalhe_cliente,
      vo_cre_prazo               OUT      tyt_cre_prazo,
      vo_cre_inicio              OUT      tyt_cre_inicio,
      vo_cre_termino             OUT      tyt_cre_termino,
      vo_cre_data                OUT      tyt_cre_data,
      vo_cre_vlobras             OUT      tyt_cre_vlobras,
      vo_cre_valor_aprov         OUT      tyt_cre_valor_aprov,
      vo_cre_valor_pago          OUT      tyt_cre_valor_pago,
      vo_num_situacao_carencia   OUT      tyt_num_situacao_carencia,
      vo_dsc_critica_carencia    OUT      tyt_dsc_critica_carencia,
      vo_cre_tipo                OUT      tyt_cre_tipo,
      vi_cre_cod                 IN       t_cre_cod,
      vi_cre_dep_cod             IN       t_cre_dep_cod,
      vi_num_prioridade_superint IN       t_num_prioridade_superint,
      vi_num_prioridade_carencia IN       t_num_prioridade_carencia,
      vi_cre_projeto             IN       t_cre_projeto,
      vi_num_seq_pessoal_carencia IN      t_num_seq_pessoal_carencia,
      vi_cre_desc                IN       t_cre_desc,
      vi_cre_justificativa       IN       t_cre_justificativa,
      vi_cre_aen_subcod          IN       t_cre_aen_subcod,
      vi_cre_ntf_cod             IN       t_cre_ntf_cod,
      vi_cod_detalhe_cliente     IN       t_cod_detalhe_cliente,
      vi_cre_prazo               IN       t_cre_prazo,
      vi_cre_inicio              IN       t_cre_inicio,
      vi_cre_termino             IN       t_cre_termino,
      vi_cre_data                IN       t_cre_data,
      vi_cre_vlobras             IN       t_cre_vlobras,
      vi_num_situacao_carencia   IN       t_num_situacao_carencia,
      vi_cre_tipo                IN       t_cre_tipo);

   
--------------------------------------------------------------------------------
   --- VIW_SALDO_CARENCIA_CONTRATO
   SUBTYPE t_num_cre_cod IS ifrbde.viw_saldo_carencia_contrato.num_cre_cod%TYPE;

   SUBTYPE t_val_total_recurso IS ifrbde.viw_saldo_carencia_contrato.val_total_recurso%TYPE;

   SUBTYPE t_val_total_contratado IS ifrbde.viw_saldo_carencia_contrato.val_total_contratado%TYPE;

   SUBTYPE t_val_total_aditivado IS ifrbde.viw_saldo_carencia_contrato.val_total_aditivado%TYPE;

   
--   SUBTYPE t_val_saldo_recurso IS ifrbde.viw_saldo_carencia_contrato.val_saldo_recurso%TYPE;
   TYPE tyt_num_cre_cod IS TABLE OF t_num_cre_cod
      INDEX BY BINARY_INTEGER;

   TYPE tyt_val_total_recurso IS TABLE OF t_val_total_recurso
      INDEX BY BINARY_INTEGER;

   TYPE tyt_val_total_contratado IS TABLE OF t_val_total_contratado
      INDEX BY BINARY_INTEGER;

   TYPE tyt_val_total_aditivado IS TABLE OF t_val_total_aditivado
      INDEX BY BINARY_INTEGER;

   
--   TYPE tyt_val_saldo_recurso IS TABLE OF t_val_saldo_recurso
--      INDEX BY BINARY_INTEGER;
   PROCEDURE stp_pesquisa_saldo_carencia_co (
      p_usuario                  IN       VARCHAR2,
      vo_num_cre_cod             OUT      tyt_num_cre_cod,
      vo_val_total_recurso       OUT      tyt_val_total_recurso,
      vo_val_total_contratado    OUT      tyt_val_total_contratado,
      vo_val_total_aditivado     OUT      tyt_val_total_aditivado,
      vo_val_saldo_recurso       OUT      tyt_val_saldo_recurso,
      vi_num_cre_cod             IN       t_num_cre_cod);

   PROCEDURE stp_exclui_saldo_carencia_cont (
      p_usuario                  IN       VARCHAR2,
      vo_ok                      OUT      tyt_ok,
      vi_num_cre_cod             IN       t_num_cre_cod);

   PROCEDURE stp_inclui_saldo_carencia_cont (
      p_usuario                  IN       VARCHAR2,
      vo_num_cre_cod             OUT      tyt_num_cre_cod,
      vo_val_total_recurso       OUT      tyt_val_total_recurso,
      vo_val_total_contratado    OUT      tyt_val_total_contratado,
      vo_val_total_aditivado     OUT      tyt_val_total_aditivado,
      vo_val_saldo_recurso       OUT      tyt_val_saldo_recurso,
      vi_num_cre_cod             IN       t_num_cre_cod,
      vi_val_total_recurso       IN       t_val_total_recurso,
      vi_val_total_contratado    IN       t_val_total_contratado,
      vi_val_total_aditivado     IN       t_val_total_aditivado,
      vi_val_saldo_recurso       IN       t_val_saldo_recurso);

   PROCEDURE stp_altera_saldo_carencia_cont (
      p_usuario                  IN       VARCHAR2,
      vo_num_cre_cod             OUT      tyt_num_cre_cod,
      vo_val_total_recurso       OUT      tyt_val_total_recurso,
      vo_val_total_contratado    OUT      tyt_val_total_contratado,
      vo_val_total_aditivado     OUT      tyt_val_total_aditivado,
      vo_val_saldo_recurso       OUT      tyt_val_saldo_recurso,
      vi_num_cre_cod             IN       t_num_cre_cod,
      vi_val_total_recurso       IN       t_val_total_recurso,
      vi_val_total_contratado    IN       t_val_total_contratado,
      vi_val_total_aditivado     IN       t_val_total_aditivado,
      vi_val_saldo_recurso       IN       t_val_saldo_recurso);

   
--------------------------------------------------------------------------------
   --- CAD_RECURSOS_SOLICITADOS
   SUBTYPE t_num_seq_carencia IS ifrbde.cad_recursos_solicitados.num_seq_carencia%TYPE;

   SUBTYPE t_num_ano IS ifrbde.cad_recursos_solicitados.num_ano%TYPE;

   SUBTYPE t_val_proposta IS ifrbde.cad_recursos_solicitados.val_proposta%TYPE;

   TYPE tyt_num_seq_carencia IS TABLE OF t_num_seq_carencia
      INDEX BY BINARY_INTEGER;

   TYPE tyt_num_ano IS TABLE OF t_num_ano
      INDEX BY BINARY_INTEGER;

   TYPE tyt_val_proposta IS TABLE OF t_val_proposta
      INDEX BY BINARY_INTEGER;

   PROCEDURE stp_pesquisa_recursos_solicita (
      p_usuario                  IN       VARCHAR2,
      vo_num_seq_carencia        OUT      tyt_num_seq_carencia,
      vo_num_ano                 OUT      tyt_num_ano,
      vo_val_proposta            OUT      tyt_val_proposta,
      vi_num_seq_carencia        IN       t_num_seq_carencia,
      vi_num_ano                 IN       t_num_ano);

   PROCEDURE stp_exclui_recursos_solicitado (
      p_usuario                  IN       VARCHAR2,
      vo_ok                      OUT      tyt_ok,
      vi_num_seq_carencia        IN       t_num_seq_carencia,
      vi_num_ano                 IN       t_num_ano);

   PROCEDURE stp_inclui_recursos_solicitado (
      p_usuario                  IN       VARCHAR2,
      vo_num_seq_carencia        OUT      tyt_num_seq_carencia,
      vo_num_ano                 OUT      tyt_num_ano,
      vo_val_proposta            OUT      tyt_val_proposta,
      vi_num_seq_carencia        IN       t_num_seq_carencia,
      vi_num_ano                 IN       t_num_ano,
      vi_val_proposta            IN       t_val_proposta);

   PROCEDURE stp_altera_recursos_solicitado (
      p_usuario                  IN       VARCHAR2,
      vo_num_seq_carencia        OUT      tyt_num_seq_carencia,
      vo_num_ano                 OUT      tyt_num_ano,
      vo_val_proposta            OUT      tyt_val_proposta,
      vi_num_seq_carencia        IN       t_num_seq_carencia,
      vi_num_ano                 IN       t_num_ano,
      vi_val_proposta            IN       t_val_proposta);

   
--------------------------------------------------------------------------------
   --- VIW_PRE_COMPROMISSO
   SUBTYPE t_seq_pre_compromisso IS ifrbde.viw_pre_compromisso.seq_pre_compromisso%TYPE;

   SUBTYPE t_seq_carencia IS ifrbde.viw_pre_compromisso.seq_carencia%TYPE;

   SUBTYPE t_num_forma_pagamento IS ifrbde.viw_pre_compromisso.num_forma_pagamento%TYPE;

   SUBTYPE t_num_reg_execucao IS ifrbde.viw_pre_compromisso.num_reg_execucao%TYPE;

   SUBTYPE t_flg_consorcio IS ifrbde.viw_pre_compromisso.flg_consorcio%TYPE;

   SUBTYPE t_val_pre_comp IS ifrbde.viw_pre_compromisso.val_pre_comp%TYPE;

   SUBTYPE t_dat_pre_comp IS t_data;

   SUBTYPE t_flg_risco IS ifrbde.viw_pre_compromisso.flg_risco%TYPE;

   SUBTYPE t_tax_garantia IS ifrbde.viw_pre_compromisso.tax_garantia%TYPE;

   SUBTYPE t_flg_execucao IS ifrbde.viw_pre_compromisso.flg_execucao%TYPE;

   SUBTYPE t_tax_execucao IS ifrbde.viw_pre_compromisso.tax_execucao%TYPE;

   SUBTYPE t_dsc_local_entrega IS ifrbde.viw_pre_compromisso.dsc_local_entrega%TYPE;

   SUBTYPE t_num_prz_exec IS ifrbde.viw_pre_compromisso.num_prz_exec%TYPE;

   SUBTYPE t_num_execucao_meses IS ifrbde.viw_pre_compromisso.num_execucao_meses%TYPE;

   SUBTYPE t_num_prz_exec_contrato IS ifrbde.viw_pre_compromisso.num_prz_exec_contrato%TYPE;

   SUBTYPE t_num_exec_contrato_mes IS ifrbde.viw_pre_compromisso.num_exec_contrato_mes%TYPE;

   SUBTYPE t_cod_mod_licitacao IS ifrbde.viw_pre_compromisso.cod_mod_licitacao%TYPE;

   SUBTYPE t_num_inciso IS ifrbde.viw_pre_compromisso.num_inciso%TYPE;

   SUBTYPE t_dsc_fundamento_legal IS ifrbde.viw_pre_compromisso.dsc_fundamento_legal%TYPE;

   SUBTYPE t_num_licitacao IS ifrbde.viw_pre_compromisso.num_licitacao%TYPE;

   SUBTYPE t_num_ano_licitacao IS ifrbde.viw_pre_compromisso.num_ano_licitacao%TYPE;

   SUBTYPE t_num_processo IS ifrbde.viw_pre_compromisso.num_processo%TYPE;

   SUBTYPE t_num_sit_pre_comp IS ifrbde.viw_pre_compromisso.num_sit_pre_comp%TYPE;

   TYPE tyt_seq_pre_compromisso IS TABLE OF t_seq_pre_compromisso
      INDEX BY BINARY_INTEGER;

   TYPE tyt_seq_carencia IS TABLE OF t_seq_carencia
      INDEX BY BINARY_INTEGER;

   TYPE tyt_num_forma_pagamento IS TABLE OF t_num_forma_pagamento
      INDEX BY BINARY_INTEGER;

   TYPE tyt_num_reg_execucao IS TABLE OF t_num_reg_execucao
      INDEX BY BINARY_INTEGER;

   TYPE tyt_flg_consorcio IS TABLE OF t_flg_consorcio
      INDEX BY BINARY_INTEGER;

   TYPE tyt_val_pre_comp IS TABLE OF t_val_pre_comp
      INDEX BY BINARY_INTEGER;

   TYPE tyt_dat_pre_comp IS TABLE OF t_dat_pre_comp
      INDEX BY BINARY_INTEGER;

   TYPE tyt_flg_risco IS TABLE OF t_flg_risco
      INDEX BY BINARY_INTEGER;

   TYPE tyt_tax_garantia IS TABLE OF t_tax_garantia
      INDEX BY BINARY_INTEGER;

   TYPE tyt_flg_execucao IS TABLE OF t_flg_execucao
      INDEX BY BINARY_INTEGER;

   TYPE tyt_tax_execucao IS TABLE OF t_tax_execucao
      INDEX BY BINARY_INTEGER;

   TYPE tyt_dsc_local_entrega IS TABLE OF t_dsc_local_entrega
      INDEX BY BINARY_INTEGER;

   TYPE tyt_num_prz_exec IS TABLE OF t_num_prz_exec
      INDEX BY BINARY_INTEGER;

   TYPE tyt_num_execucao_meses IS TABLE OF t_num_execucao_meses
      INDEX BY BINARY_INTEGER;

   TYPE tyt_num_prz_exec_contrato IS TABLE OF t_num_prz_exec_contrato
      INDEX BY BINARY_INTEGER;

   TYPE tyt_num_exec_contrato_mes IS TABLE OF t_num_exec_contrato_mes
      INDEX BY BINARY_INTEGER;

   TYPE tyt_cod_mod_licitacao IS TABLE OF t_cod_mod_licitacao
      INDEX BY BINARY_INTEGER;

   TYPE tyt_num_inciso IS TABLE OF t_num_inciso
      INDEX BY BINARY_INTEGER;

   TYPE tyt_dsc_fundamento_legal IS TABLE OF t_dsc_fundamento_legal
      INDEX BY BINARY_INTEGER;

   TYPE tyt_num_licitacao IS TABLE OF t_num_licitacao
      INDEX BY BINARY_INTEGER;

   TYPE tyt_num_ano_licitacao IS TABLE OF t_num_ano_licitacao
      INDEX BY BINARY_INTEGER;

   TYPE tyt_num_processo IS TABLE OF t_num_processo
      INDEX BY BINARY_INTEGER;

   TYPE tyt_num_sit_pre_comp IS TABLE OF t_num_sit_pre_comp
      INDEX BY BINARY_INTEGER;

   PROCEDURE stp_pesquisa_pre_compromisso (
      p_usuario                  IN       VARCHAR2,
      vo_seq_pre_compromisso     OUT      tyt_seq_pre_compromisso,
      vo_seq_carencia            OUT      tyt_seq_carencia,
      vo_num_forma_pagamento     OUT      tyt_num_forma_pagamento,
      vo_num_reg_execucao        OUT      tyt_num_reg_execucao,
      vo_flg_consorcio           OUT      tyt_flg_consorcio,
      vo_val_pre_comp            OUT      tyt_val_pre_comp,
      vo_dat_pre_comp            OUT      tyt_dat_pre_comp,
      vo_flg_risco               OUT      tyt_flg_risco,
      vo_tax_garantia            OUT      tyt_tax_garantia,
      vo_flg_execucao            OUT      tyt_flg_execucao,
      vo_tax_execucao            OUT      tyt_tax_execucao,
      vo_dsc_local_entrega       OUT      tyt_dsc_local_entrega,
      vo_num_prz_exec            OUT      tyt_num_prz_exec,
      vo_num_execucao_meses      OUT      tyt_num_execucao_meses,
      vo_num_prz_exec_contrato   OUT      tyt_num_prz_exec_contrato,
      vo_num_exec_contrato_mes   OUT      tyt_num_exec_contrato_mes,
      vo_cod_mod_licitacao       OUT      tyt_cod_mod_licitacao,
      vo_num_inciso              OUT      tyt_num_inciso,
      vo_dsc_fundamento_legal    OUT      tyt_dsc_fundamento_legal,
      vo_num_licitacao           OUT      tyt_num_licitacao,
      vo_num_ano_licitacao       OUT      tyt_num_ano_licitacao,
      vo_num_processo            OUT      tyt_num_processo,
      vo_num_sit_pre_comp        OUT      tyt_num_sit_pre_comp,
      vi_seq_pre_compromisso     IN       t_seq_pre_compromisso,
      vi_seq_carencia            IN       t_seq_carencia);

   PROCEDURE stp_exclui_pre_compromisso (
      p_usuario                  IN       VARCHAR2,
      vo_ok                      OUT      tyt_ok,
      vi_seq_pre_compromisso     IN       t_seq_pre_compromisso,
      vi_seq_carencia            IN       t_seq_carencia);

   PROCEDURE stp_inclui_pre_compromisso (
      p_usuario                  IN       VARCHAR2,
      vo_seq_pre_compromisso     OUT      tyt_seq_pre_compromisso,
      vo_seq_carencia            OUT      tyt_seq_carencia,
      vo_num_forma_pagamento     OUT      tyt_num_forma_pagamento,
      vo_num_reg_execucao        OUT      tyt_num_reg_execucao,
      vo_flg_consorcio           OUT      tyt_flg_consorcio,
      vo_val_pre_comp            OUT      tyt_val_pre_comp,
      vo_dat_pre_comp            OUT      tyt_dat_pre_comp,
      vo_flg_risco               OUT      tyt_flg_risco,
      vo_tax_garantia            OUT      tyt_tax_garantia,
      vo_flg_execucao            OUT      tyt_flg_execucao,
      vo_tax_execucao            OUT      tyt_tax_execucao,
      vo_dsc_local_entrega       OUT      tyt_dsc_local_entrega,
      vo_num_prz_exec            OUT      tyt_num_prz_exec,
      vo_num_execucao_meses      OUT      tyt_num_execucao_meses,
      vo_num_prz_exec_contrato   OUT      tyt_num_prz_exec_contrato,
      vo_num_exec_contrato_mes   OUT      tyt_num_exec_contrato_mes,
      vo_cod_mod_licitacao       OUT      tyt_cod_mod_licitacao,
      vo_num_inciso              OUT      tyt_num_inciso,
      vo_dsc_fundamento_legal    OUT      tyt_dsc_fundamento_legal,
      vo_num_licitacao           OUT      tyt_num_licitacao,
      vo_num_ano_licitacao       OUT      tyt_num_ano_licitacao,
      vo_num_processo            OUT      tyt_num_processo,
      vo_num_sit_pre_comp        OUT      tyt_num_sit_pre_comp,
      vi_seq_carencia            IN       t_seq_carencia,
      vi_num_forma_pagamento     IN       t_num_forma_pagamento,
      vi_num_reg_execucao        IN       t_num_reg_execucao,
      vi_flg_consorcio           IN       t_flg_consorcio,
      vi_dat_pre_comp            IN       t_dat_pre_comp,
      vi_flg_risco               IN       t_flg_risco,
      vi_flg_execucao            IN       t_flg_execucao,
      vi_tax_execucao            IN       t_tax_execucao,
      vi_dsc_local_entrega       IN       t_dsc_local_entrega,
      vi_num_prz_exec            IN       t_num_prz_exec,
      vi_num_prz_exec_contrato   IN       t_num_prz_exec_contrato,
      vi_cod_mod_licitacao       IN       t_cod_mod_licitacao,
      vi_num_inciso              IN       t_num_inciso,
      vi_dsc_fundamento_legal    IN       t_dsc_fundamento_legal,
      vi_num_licitacao           IN       t_num_licitacao,
      vi_num_ano_licitacao       IN       t_num_ano_licitacao,
      vi_num_processo            IN       t_num_processo,
      vi_num_sit_pre_comp        IN       t_num_sit_pre_comp);

   PROCEDURE stp_altera_pre_compromisso (
      p_usuario                  IN       VARCHAR2,
      vo_seq_pre_compromisso     OUT      tyt_seq_pre_compromisso,
      vo_seq_carencia            OUT      tyt_seq_carencia,
      vo_num_forma_pagamento     OUT      tyt_num_forma_pagamento,
      vo_num_reg_execucao        OUT      tyt_num_reg_execucao,
      vo_flg_consorcio           OUT      tyt_flg_consorcio,
      vo_val_pre_comp            OUT      tyt_val_pre_comp,
      vo_dat_pre_comp            OUT      tyt_dat_pre_comp,
      vo_flg_risco               OUT      tyt_flg_risco,
      vo_tax_garantia            OUT      tyt_tax_garantia,
      vo_flg_execucao            OUT      tyt_flg_execucao,
      vo_tax_execucao            OUT      tyt_tax_execucao,
      vo_dsc_local_entrega       OUT      tyt_dsc_local_entrega,
      vo_num_prz_exec            OUT      tyt_num_prz_exec,
      vo_num_execucao_meses      OUT      tyt_num_execucao_meses,
      vo_num_prz_exec_contrato   OUT      tyt_num_prz_exec_contrato,
      vo_num_exec_contrato_mes   OUT      tyt_num_exec_contrato_mes,
      vo_cod_mod_licitacao       OUT      tyt_cod_mod_licitacao,
      vo_num_inciso              OUT      tyt_num_inciso,
      vo_dsc_fundamento_legal    OUT      tyt_dsc_fundamento_legal,
      vo_num_licitacao           OUT      tyt_num_licitacao,
      vo_num_ano_licitacao       OUT      tyt_num_ano_licitacao,
      vo_num_processo            OUT      tyt_num_processo,
      vo_num_sit_pre_comp        OUT      tyt_num_sit_pre_comp,
      vi_seq_pre_compromisso     IN       t_seq_pre_compromisso,
      vi_seq_carencia            IN       t_seq_carencia,
      vi_num_forma_pagamento     IN       t_num_forma_pagamento,
      vi_num_reg_execucao        IN       t_num_reg_execucao,
      vi_flg_consorcio           IN       t_flg_consorcio,
      vi_dat_pre_comp            IN       t_dat_pre_comp,
      vi_flg_risco               IN       t_flg_risco,
      vi_flg_execucao            IN       t_flg_execucao,
      vi_tax_execucao            IN       t_tax_execucao,
      vi_dsc_local_entrega       IN       t_dsc_local_entrega,
      vi_num_prz_exec            IN       t_num_prz_exec,
      vi_num_prz_exec_contrato   IN       t_num_prz_exec_contrato,
      vi_cod_mod_licitacao       IN       t_cod_mod_licitacao,
      vi_num_inciso              IN       t_num_inciso,
      vi_dsc_fundamento_legal    IN       t_dsc_fundamento_legal,
      vi_num_licitacao           IN       t_num_licitacao,
      vi_num_ano_licitacao       IN       t_num_ano_licitacao,
      vi_num_processo            IN       t_num_processo,
      vi_num_sit_pre_comp        IN       t_num_sit_pre_comp);
END;
/

-- Grants for Package
GRANT EXECUTE ON ifrbde.pck_carencia TO bde_geral
/
-- End of DDL Script for Package IFRBDE.PCK_CARENCIA

