/* Formatted on 2006/03/14 09:51 (Formatter Plus v4.8.0) */
CREATE OR REPLACE PACKAGE ifrbde.pck_viw_carencia
IS
--------------------------------------------------------------------------------
   -- tipos globais
   TYPE tyt_ok IS TABLE OF NUMBER (1)
      INDEX BY BINARY_INTEGER;

   SUBTYPE t_data IS CHAR (10);

   TYPE tyt_data IS TABLE OF t_data
      INDEX BY BINARY_INTEGER;

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
      p_usuario                     IN       VARCHAR2,
      vo_cre_cod                    OUT      tyt_cre_cod,
      vo_cre_dep_cod                OUT      tyt_cre_dep_cod,
      vo_num_prioridade_superint    OUT      tyt_num_prioridade_superint,
      vo_num_prioridade_carencia    OUT      tyt_num_prioridade_carencia,
      vo_cre_projeto                OUT      tyt_cre_projeto,
      vo_num_seq_pessoal_carencia   OUT      tyt_num_seq_pessoal_carencia,
      vo_cre_desc                   OUT      tyt_cre_desc,
      vo_cre_justificativa          OUT      tyt_cre_justificativa,
      vo_cre_aen_subcod             OUT      tyt_cre_aen_subcod,
      vo_cre_ntf_cod                OUT      tyt_cre_ntf_cod,
      vo_cod_detalhe_cliente        OUT      tyt_cod_detalhe_cliente,
      vo_cre_prazo                  OUT      tyt_cre_prazo,
      vo_cre_inicio                 OUT      tyt_cre_inicio,
      vo_cre_termino                OUT      tyt_cre_termino,
      vo_cre_data                   OUT      tyt_cre_data,
      vo_cre_vlobras                OUT      tyt_cre_vlobras,
      vo_cre_valor_aprov            OUT      tyt_cre_valor_aprov,
      vo_cre_valor_pago             OUT      tyt_cre_valor_pago,
      vo_num_situacao_carencia      OUT      tyt_num_situacao_carencia,
      vo_dsc_critica_carencia       OUT      tyt_dsc_critica_carencia,
      vo_cre_tipo                   OUT      tyt_cre_tipo,
      vi_cre_cod                    IN       t_cre_cod
   );

   PROCEDURE stp_exclui_carencia (
      p_usuario    IN       VARCHAR2,
      vo_ok        OUT      tyt_ok,
      vi_cre_cod   IN       t_cre_cod
   );

   PROCEDURE stp_inclui_carencia (
      p_usuario                     IN       VARCHAR2,
      vo_cre_cod                    OUT      tyt_cre_cod,
      vo_cre_dep_cod                OUT      tyt_cre_dep_cod,
      vo_num_prioridade_superint    OUT      tyt_num_prioridade_superint,
      vo_num_prioridade_carencia    OUT      tyt_num_prioridade_carencia,
      vo_cre_projeto                OUT      tyt_cre_projeto,
      vo_num_seq_pessoal_carencia   OUT      tyt_num_seq_pessoal_carencia,
      vo_cre_desc                   OUT      tyt_cre_desc,
      vo_cre_justificativa          OUT      tyt_cre_justificativa,
      vo_cre_aen_subcod             OUT      tyt_cre_aen_subcod,
      vo_cre_ntf_cod                OUT      tyt_cre_ntf_cod,
      vo_cod_detalhe_cliente        OUT      tyt_cod_detalhe_cliente,
      vo_cre_prazo                  OUT      tyt_cre_prazo,
      vo_cre_inicio                 OUT      tyt_cre_inicio,
      vo_cre_termino                OUT      tyt_cre_termino,
      vo_cre_data                   OUT      tyt_cre_data,
      vo_cre_vlobras                OUT      tyt_cre_vlobras,
      vo_cre_valor_aprov            OUT      tyt_cre_valor_aprov,
      vo_cre_valor_pago             OUT      tyt_cre_valor_pago,
      vo_num_situacao_carencia      OUT      tyt_num_situacao_carencia,
      vo_dsc_critica_carencia       OUT      tyt_dsc_critica_carencia,
      vo_cre_tipo                   OUT      tyt_cre_tipo,
      vi_cre_dep_cod                IN       t_cre_dep_cod,
      vi_num_prioridade_superint    IN       t_num_prioridade_superint,
      vi_num_prioridade_carencia    IN       t_num_prioridade_carencia,
      vi_cre_projeto                IN       t_cre_projeto,
      vi_num_seq_pessoal_carencia   IN       t_num_seq_pessoal_carencia,
      vi_cre_desc                   IN       t_cre_desc,
      vi_cre_justificativa          IN       t_cre_justificativa,
      vi_cre_aen_subcod             IN       t_cre_aen_subcod,
      vi_cre_ntf_cod                IN       t_cre_ntf_cod,
      vi_cod_detalhe_cliente        IN       t_cod_detalhe_cliente,
      vi_cre_prazo                  IN       t_cre_prazo,
      vi_cre_inicio                 IN       t_cre_inicio,
      vi_cre_termino                IN       t_cre_termino,
      vi_cre_data                   IN       t_cre_data,
      vi_cre_vlobras                IN       t_cre_vlobras,
      vi_num_situacao_carencia      IN       t_num_situacao_carencia,
      vi_cre_tipo                   IN       t_cre_tipo
   );

   PROCEDURE stp_altera_carencia (
      p_usuario                     IN       VARCHAR2,
      vo_cre_cod                    OUT      tyt_cre_cod,
      vo_cre_dep_cod                OUT      tyt_cre_dep_cod,
      vo_num_prioridade_superint    OUT      tyt_num_prioridade_superint,
      vo_num_prioridade_carencia    OUT      tyt_num_prioridade_carencia,
      vo_cre_projeto                OUT      tyt_cre_projeto,
      vo_num_seq_pessoal_carencia   OUT      tyt_num_seq_pessoal_carencia,
      vo_cre_desc                   OUT      tyt_cre_desc,
      vo_cre_justificativa          OUT      tyt_cre_justificativa,
      vo_cre_aen_subcod             OUT      tyt_cre_aen_subcod,
      vo_cre_ntf_cod                OUT      tyt_cre_ntf_cod,
      vo_cod_detalhe_cliente        OUT      tyt_cod_detalhe_cliente,
      vo_cre_prazo                  OUT      tyt_cre_prazo,
      vo_cre_inicio                 OUT      tyt_cre_inicio,
      vo_cre_termino                OUT      tyt_cre_termino,
      vo_cre_data                   OUT      tyt_cre_data,
      vo_cre_vlobras                OUT      tyt_cre_vlobras,
      vo_cre_valor_aprov            OUT      tyt_cre_valor_aprov,
      vo_cre_valor_pago             OUT      tyt_cre_valor_pago,
      vo_num_situacao_carencia      OUT      tyt_num_situacao_carencia,
      vo_dsc_critica_carencia       OUT      tyt_dsc_critica_carencia,
      vo_cre_tipo                   OUT      tyt_cre_tipo,
      vi_cre_cod                    IN       t_cre_cod,
      vi_cre_dep_cod                IN       t_cre_dep_cod,
      vi_num_prioridade_superint    IN       t_num_prioridade_superint,
      vi_num_prioridade_carencia    IN       t_num_prioridade_carencia,
      vi_cre_projeto                IN       t_cre_projeto,
      vi_num_seq_pessoal_carencia   IN       t_num_seq_pessoal_carencia,
      vi_cre_desc                   IN       t_cre_desc,
      vi_cre_justificativa          IN       t_cre_justificativa,
      vi_cre_aen_subcod             IN       t_cre_aen_subcod,
      vi_cre_ntf_cod                IN       t_cre_ntf_cod,
      vi_cod_detalhe_cliente        IN       t_cod_detalhe_cliente,
      vi_cre_prazo                  IN       t_cre_prazo,
      vi_cre_inicio                 IN       t_cre_inicio,
      vi_cre_termino                IN       t_cre_termino,
      vi_cre_data                   IN       t_cre_data,
      vi_cre_vlobras                IN       t_cre_vlobras,
      vi_num_situacao_carencia      IN       t_num_situacao_carencia,
      vi_cre_tipo                   IN       t_cre_tipo
   );
END;

