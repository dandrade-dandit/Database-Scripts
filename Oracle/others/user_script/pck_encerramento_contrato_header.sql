/* Formatted on 2007/01/05 14:40 (Formatter Plus v4.8.0) */
CREATE OR REPLACE PACKAGE ifrbde.pck_encerramento_contrato
IS
   -- tipos globais
   TYPE tyt_ok IS TABLE OF NUMBER (1)
      INDEX BY BINARY_INTEGER;

   SUBTYPE t_data IS CHAR (10);

   TYPE tyt_data IS TABLE OF t_data
      INDEX BY BINARY_INTEGER;

--------------------------------------------------------------------------------
   --- VIW_ENCERRAMENTO_CONTRATO
   SUBTYPE t_num_seq_contrato IS ifrbde.viw_encerramento_contrato.num_seq_contrato%TYPE;

   SUBTYPE t_cnt_cre_cod IS ifrbde.viw_encerramento_contrato.cnt_cre_cod%TYPE;

   SUBTYPE t_cnt_cod IS ifrbde.viw_encerramento_contrato.cnt_cod%TYPE;

   SUBTYPE t_num_versao_contrato IS ifrbde.viw_encerramento_contrato.num_versao_contrato%TYPE;

   SUBTYPE t_num_termo_aditivo IS ifrbde.viw_encerramento_contrato.num_termo_aditivo%TYPE;

   SUBTYPE t_cod_dep_contrato IS ifrbde.viw_encerramento_contrato.cod_dep_contrato%TYPE;

   SUBTYPE t_cnt_justificativa_cre IS ifrbde.viw_encerramento_contrato.cnt_justificativa_cre%TYPE;

   SUBTYPE t_cnt_ice_cod IS ifrbde.viw_encerramento_contrato.cnt_ice_cod%TYPE;

   SUBTYPE t_cnt_data IS t_data;

   SUBTYPE t_cnt_data_proposta IS t_data;

   SUBTYPE t_cnt_data_inicio IS t_data;

   SUBTYPE t_cnt_prazo_exec IS ifrbde.viw_encerramento_contrato.cnt_prazo_exec%TYPE;

   SUBTYPE t_num_prazo_exec_meses IS ifrbde.viw_encerramento_contrato.num_prazo_exec_meses%TYPE;

   SUBTYPE t_cnt_prazo_adit IS ifrbde.viw_encerramento_contrato.cnt_prazo_adit%TYPE;

   SUBTYPE t_dat_termino_contrato IS t_data;

   SUBTYPE t_cnt_valor_compromisso IS ifrbde.viw_encerramento_contrato.cnt_valor_compromisso%TYPE;

   SUBTYPE t_cnt_valor_termo IS ifrbde.viw_encerramento_contrato.cnt_valor_termo%TYPE;

   SUBTYPE t_cnt_valor_pago IS ifrbde.viw_encerramento_contrato.cnt_valor_pago%TYPE;

   SUBTYPE t_cnt_valor_reaj IS ifrbde.viw_encerramento_contrato.cnt_valor_reaj%TYPE;

   SUBTYPE t_cnt_valor_reaj_pago IS ifrbde.viw_encerramento_contrato.cnt_valor_reaj_pago%TYPE;

   SUBTYPE t_cnt_valor IS ifrbde.viw_encerramento_contrato.cnt_valor%TYPE;

   SUBTYPE t_tip_situacao_contrato IS ifrbde.viw_encerramento_contrato.tip_situacao_contrato%TYPE;

   SUBTYPE t_tip_contrato IS ifrbde.viw_encerramento_contrato.tip_contrato%TYPE;

   SUBTYPE t_dsc_critica_contrato IS ifrbde.viw_encerramento_contrato.dsc_critica_contrato%TYPE;

   TYPE tyt_num_seq_contrato IS TABLE OF t_num_seq_contrato
      INDEX BY BINARY_INTEGER;

   TYPE tyt_cnt_cre_cod IS TABLE OF t_cnt_cre_cod
      INDEX BY BINARY_INTEGER;

   TYPE tyt_cnt_cod IS TABLE OF t_cnt_cod
      INDEX BY BINARY_INTEGER;

   TYPE tyt_num_versao_contrato IS TABLE OF t_num_versao_contrato
      INDEX BY BINARY_INTEGER;

   TYPE tyt_num_termo_aditivo IS TABLE OF t_num_termo_aditivo
      INDEX BY BINARY_INTEGER;

   TYPE tyt_cod_dep_contrato IS TABLE OF t_cod_dep_contrato
      INDEX BY BINARY_INTEGER;

   TYPE tyt_cnt_justificativa_cre IS TABLE OF t_cnt_justificativa_cre
      INDEX BY BINARY_INTEGER;

   TYPE tyt_cnt_ice_cod IS TABLE OF t_cnt_ice_cod
      INDEX BY BINARY_INTEGER;

   TYPE tyt_cnt_data IS TABLE OF t_cnt_data
      INDEX BY BINARY_INTEGER;

   TYPE tyt_cnt_data_proposta IS TABLE OF t_cnt_data_proposta
      INDEX BY BINARY_INTEGER;

   TYPE tyt_cnt_data_inicio IS TABLE OF t_cnt_data_inicio
      INDEX BY BINARY_INTEGER;

   TYPE tyt_cnt_prazo_exec IS TABLE OF t_cnt_prazo_exec
      INDEX BY BINARY_INTEGER;

   TYPE tyt_num_prazo_exec_meses IS TABLE OF t_num_prazo_exec_meses
      INDEX BY BINARY_INTEGER;

   TYPE tyt_cnt_prazo_adit IS TABLE OF t_cnt_prazo_adit
      INDEX BY BINARY_INTEGER;

   TYPE tyt_dat_termino_contrato IS TABLE OF t_dat_termino_contrato
      INDEX BY BINARY_INTEGER;

   TYPE tyt_cnt_valor_compromisso IS TABLE OF t_cnt_valor_compromisso
      INDEX BY BINARY_INTEGER;

   TYPE tyt_cnt_valor_termo IS TABLE OF t_cnt_valor_termo
      INDEX BY BINARY_INTEGER;

   TYPE tyt_cnt_valor_pago IS TABLE OF t_cnt_valor_pago
      INDEX BY BINARY_INTEGER;

   TYPE tyt_cnt_valor_reaj IS TABLE OF t_cnt_valor_reaj
      INDEX BY BINARY_INTEGER;

   TYPE tyt_cnt_valor_reaj_pago IS TABLE OF t_cnt_valor_reaj_pago
      INDEX BY BINARY_INTEGER;

   TYPE tyt_cnt_valor IS TABLE OF t_cnt_valor
      INDEX BY BINARY_INTEGER;

   TYPE tyt_tip_situacao_contrato IS TABLE OF t_tip_situacao_contrato
      INDEX BY BINARY_INTEGER;

   TYPE tyt_tip_contrato IS TABLE OF t_tip_contrato
      INDEX BY BINARY_INTEGER;

   TYPE tyt_dsc_critica_contrato IS TABLE OF t_dsc_critica_contrato
      INDEX BY BINARY_INTEGER;

   PROCEDURE stp_pesquisa_encerramento_cont (
      p_usuario                  IN       VARCHAR2,
      vo_num_seq_contrato        OUT      tyt_num_seq_contrato,
      vo_cnt_cre_cod             OUT      tyt_cnt_cre_cod,
      vo_cnt_cod                 OUT      tyt_cnt_cod,
      vo_num_versao_contrato     OUT      tyt_num_versao_contrato,
      vo_num_termo_aditivo       OUT      tyt_num_termo_aditivo,
      vo_cod_dep_contrato        OUT      tyt_cod_dep_contrato,
      vo_cnt_justificativa_cre   OUT      tyt_cnt_justificativa_cre,
      vo_cnt_ice_cod             OUT      tyt_cnt_ice_cod,
      vo_cnt_data                OUT      tyt_cnt_data,
      vo_cnt_data_proposta       OUT      tyt_cnt_data_proposta,
      vo_cnt_data_inicio         OUT      tyt_cnt_data_inicio,
      vo_cnt_prazo_exec          OUT      tyt_cnt_prazo_exec,
      vo_num_prazo_exec_meses    OUT      tyt_num_prazo_exec_meses,
      vo_cnt_prazo_adit          OUT      tyt_cnt_prazo_adit,
      vo_dat_termino_contrato    OUT      tyt_dat_termino_contrato,
      vo_cnt_valor_compromisso   OUT      tyt_cnt_valor_compromisso,
      vo_cnt_valor_termo         OUT      tyt_cnt_valor_termo,
      vo_cnt_valor_pago          OUT      tyt_cnt_valor_pago,
      vo_cnt_valor_reaj          OUT      tyt_cnt_valor_reaj,
      vo_cnt_valor_reaj_pago     OUT      tyt_cnt_valor_reaj_pago,
      vo_cnt_valor               OUT      tyt_cnt_valor,
      vo_tip_situacao_contrato   OUT      tyt_tip_situacao_contrato,
      vo_tip_contrato            OUT      tyt_tip_contrato,
      vo_dsc_critica_contrato    OUT      tyt_dsc_critica_contrato,
      vi_num_seq_contrato        IN       t_num_seq_contrato,
      vi_cnt_cre_cod             IN       t_cnt_cre_cod
   );

   PROCEDURE stp_altera_encerramento_contra (
      p_usuario                  IN       VARCHAR2,
      vo_num_seq_contrato        OUT      tyt_num_seq_contrato,
      vo_cnt_cre_cod             OUT      tyt_cnt_cre_cod,
      vo_cnt_cod                 OUT      tyt_cnt_cod,
      vo_num_versao_contrato     OUT      tyt_num_versao_contrato,
      vo_num_termo_aditivo       OUT      tyt_num_termo_aditivo,
      vo_cod_dep_contrato        OUT      tyt_cod_dep_contrato,
      vo_cnt_justificativa_cre   OUT      tyt_cnt_justificativa_cre,
      vo_cnt_ice_cod             OUT      tyt_cnt_ice_cod,
      vo_cnt_data                OUT      tyt_cnt_data,
      vo_cnt_data_proposta       OUT      tyt_cnt_data_proposta,
      vo_cnt_data_inicio         OUT      tyt_cnt_data_inicio,
      vo_cnt_prazo_exec          OUT      tyt_cnt_prazo_exec,
      vo_num_prazo_exec_meses    OUT      tyt_num_prazo_exec_meses,
      vo_cnt_prazo_adit          OUT      tyt_cnt_prazo_adit,
      vo_dat_termino_contrato    OUT      tyt_dat_termino_contrato,
      vo_cnt_valor_compromisso   OUT      tyt_cnt_valor_compromisso,
      vo_cnt_valor_termo         OUT      tyt_cnt_valor_termo,
      vo_cnt_valor_pago          OUT      tyt_cnt_valor_pago,
      vo_cnt_valor_reaj          OUT      tyt_cnt_valor_reaj,
      vo_cnt_valor_reaj_pago     OUT      tyt_cnt_valor_reaj_pago,
      vo_cnt_valor               OUT      tyt_cnt_valor,
      vo_tip_situacao_contrato   OUT      tyt_tip_situacao_contrato,
      vo_tip_contrato            OUT      tyt_tip_contrato,
      vo_dsc_critica_contrato    OUT      tyt_dsc_critica_contrato,
      vi_num_seq_contrato        IN       t_num_seq_contrato,
      vi_cnt_cre_cod             IN       t_cnt_cre_cod,
      vi_dsc_critica_contrato    IN       t_dsc_critica_contrato
   );
--------------------------------------------------------------------------------
END;                                                           -- Package spec
/

-- Grants for Package
GRANT EXECUTE ON ifrbde.pck_encerramento_contrato TO bde_geral
--/

