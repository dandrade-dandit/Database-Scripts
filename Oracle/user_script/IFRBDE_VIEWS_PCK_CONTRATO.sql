CREATE OR REPLACE 
PACKAGE ifrbde_views.pck_contrato AS
   -- tipos globais

   TYPE tyt_ok IS TABLE OF NUMBER (1)
      INDEX BY BINARY_INTEGER;

   SUBTYPE t_data IS CHAR (10);

   TYPE tyt_data IS TABLE OF t_data
      INDEX BY BINARY_INTEGER;

   
--------------------------------------------------------------------------------
   --- TAB_INDICE
   SUBTYPE t_ice_cod IS ifrbde_views.tab_indice.ice_cod%TYPE;

   SUBTYPE t_tip_indice IS ifrbde_views.tab_indice.tip_indice%TYPE;

   TYPE tyt_ice_cod IS TABLE OF t_ice_cod
      INDEX BY BINARY_INTEGER;

   TYPE tyt_tip_indice IS TABLE OF t_tip_indice
      INDEX BY BINARY_INTEGER;

   PROCEDURE stp_pesquisa_indice (
      p_usuario                VARCHAR2,
      vo_ice_cod      OUT      tyt_ice_cod,
      vo_tip_indice   OUT      tyt_tip_indice,
      vi_ice_cod      IN       t_ice_cod
   );

   PROCEDURE stp_exclui_indice (
      p_usuario             VARCHAR2,
      vo_ok        OUT      tyt_ok,
      vi_ice_cod   IN       t_ice_cod
   );

   PROCEDURE stp_inclui_indice (
      p_usuario                VARCHAR2,
      vo_ice_cod      OUT      tyt_ice_cod,
      vo_tip_indice   OUT      tyt_tip_indice,
      vi_ice_cod      IN       t_ice_cod,
      vi_tip_indice   IN       t_tip_indice
   );

   PROCEDURE stp_altera_indice (
      p_usuario                VARCHAR2,
      vo_ice_cod      OUT      tyt_ice_cod,
      vo_tip_indice   OUT      tyt_tip_indice,
      vi_ice_cod      IN       t_ice_cod,
      vi_tip_indice   IN       t_tip_indice
   );

   --- TAB_INDICE_FIL
   SUBTYPE t_num_seq_indice IS ifrbde_views.tab_indice_fil.num_seq_indice%TYPE;

   SUBTYPE t_ici_ice_cod IS ifrbde_views.tab_indice_fil.ici_ice_cod%TYPE;

   SUBTYPE t_ici_periodo IS t_data;

   SUBTYPE t_ici_valor_diario IS ifrbde_views.tab_indice_fil.ici_valor_diario%TYPE;

   TYPE tyt_num_seq_indice IS TABLE OF t_num_seq_indice
      INDEX BY BINARY_INTEGER;

   TYPE tyt_ici_ice_cod IS TABLE OF t_ici_ice_cod
      INDEX BY BINARY_INTEGER;

   TYPE tyt_ici_periodo IS TABLE OF t_ici_periodo
      INDEX BY BINARY_INTEGER;

   TYPE tyt_ici_valor_diario IS TABLE OF t_ici_valor_diario
      INDEX BY BINARY_INTEGER;

   PROCEDURE stp_pesquisa_indice_fil (
      p_usuario                      VARCHAR2,
      vo_num_seq_indice     OUT      tyt_num_seq_indice,
      vo_ici_ice_cod        OUT      tyt_ici_ice_cod,
      vo_ici_periodo        OUT      tyt_ici_periodo,
      vo_ici_valor_diario   OUT      tyt_ici_valor_diario,
      vi_num_seq_indice     IN       t_num_seq_indice
   );

   PROCEDURE stp_exclui_indice_fil (
      p_usuario                    VARCHAR2,
      vo_ok               OUT      tyt_ok,
      vi_num_seq_indice   IN       t_num_seq_indice
   );

   PROCEDURE stp_inclui_indice_fil (
      p_usuario                      VARCHAR2,
      vo_num_seq_indice     OUT      tyt_num_seq_indice,
      vo_ici_ice_cod        OUT      tyt_ici_ice_cod,
      vo_ici_periodo        OUT      tyt_ici_periodo,
      vo_ici_valor_diario   OUT      tyt_ici_valor_diario,
      vi_ici_ice_cod        IN       t_ici_ice_cod,
      vi_ici_periodo        IN       t_ici_periodo,
      vi_ici_valor_diario   IN       t_ici_valor_diario
   );

   PROCEDURE stp_altera_indice_fil (
      p_usuario                      VARCHAR2,
      vo_num_seq_indice     OUT      tyt_num_seq_indice,
      vo_ici_ice_cod        OUT      tyt_ici_ice_cod,
      vo_ici_periodo        OUT      tyt_ici_periodo,
      vo_ici_valor_diario   OUT      tyt_ici_valor_diario,
      vi_num_seq_indice     IN       t_num_seq_indice,
      vi_ici_ice_cod        IN       t_ici_ice_cod,
      vi_ici_periodo        IN       t_ici_periodo,
      vi_ici_valor_diario   IN       t_ici_valor_diario
   );

   --- CAD_PARTICIPANTES_CONTRATO
   SUBTYPE t_num_seq_contrato_part IS ifrbde_views.cad_participantes_contrato.num_seq_contrato_part%TYPE;

   SUBTYPE t_num_fir_cod IS ifrbde_views.cad_participantes_contrato.num_fir_cod%TYPE;

   TYPE tyt_num_seq_contrato_part IS TABLE OF t_num_seq_contrato_part
      INDEX BY BINARY_INTEGER;

   TYPE tyt_num_fir_cod IS TABLE OF t_num_fir_cod
      INDEX BY BINARY_INTEGER;

   PROCEDURE stp_pesquisa_participantes_con (
      p_usuario                           VARCHAR2,
      vo_num_seq_contrato_part   OUT      tyt_num_seq_contrato_part,
      vo_num_fir_cod             OUT      tyt_num_fir_cod,
      vi_num_seq_contrato_part   IN       t_num_seq_contrato_part,
      vi_num_fir_cod             IN       t_num_fir_cod
   );

   PROCEDURE stp_exclui_participantes_contr (
      p_usuario                           VARCHAR2,
      vo_ok                      OUT      tyt_ok,
      vi_num_seq_contrato_part   IN       t_num_seq_contrato_part,
      vi_num_fir_cod             IN       t_num_fir_cod
   );

   PROCEDURE stp_inclui_participantes_contr (
      p_usuario                           VARCHAR2,
      vo_num_seq_contrato_part   OUT      tyt_num_seq_contrato_part,
      vo_num_fir_cod             OUT      tyt_num_fir_cod,
      vi_num_seq_contrato_part   IN       t_num_seq_contrato_part,
      vi_num_fir_cod             IN       t_num_fir_cod
   );

   PROCEDURE stp_altera_participantes_contr (
      p_usuario                           VARCHAR2,
      vo_num_seq_contrato_part   OUT      tyt_num_seq_contrato_part,
      vo_num_fir_cod             OUT      tyt_num_fir_cod,
      vi_num_seq_contrato_part   IN       t_num_seq_contrato_part,
      vi_num_fir_cod             IN       t_num_fir_cod
   );

   --- CAD_FISCAIS_CONTRATO
   SUBTYPE t_num_seq_contrato_fis IS ifrbde_views.cad_fiscais_contrato.num_seq_contrato_fis%TYPE;

   SUBTYPE t_num_seq_pessoal_fis IS ifrbde_views.cad_fiscais_contrato.num_seq_pessoal_fis%TYPE;

   TYPE tyt_num_seq_contrato_fis IS TABLE OF t_num_seq_contrato_fis
      INDEX BY BINARY_INTEGER;

   TYPE tyt_num_seq_pessoal_fis IS TABLE OF t_num_seq_pessoal_fis
      INDEX BY BINARY_INTEGER;

   PROCEDURE stp_pesquisa_fiscais_contrato (
      p_usuario                          VARCHAR2,
      vo_num_seq_contrato_fis   OUT      tyt_num_seq_contrato_fis,
      vo_num_seq_pessoal_fis    OUT      tyt_num_seq_pessoal_fis,
      vi_num_seq_contrato_fis   IN       t_num_seq_contrato_fis,
      vi_num_seq_pessoal_fis    IN       t_num_seq_pessoal_fis
   );

   PROCEDURE stp_exclui_fiscais_contrato (
      p_usuario                          VARCHAR2,
      vo_ok                     OUT      tyt_ok,
      vi_num_seq_contrato_fis   IN       t_num_seq_contrato_fis,
      vi_num_seq_pessoal_fis    IN       t_num_seq_pessoal_fis
   );

   PROCEDURE stp_inclui_fiscais_contrato (
      p_usuario                          VARCHAR2,
      vo_num_seq_contrato_fis   OUT      tyt_num_seq_contrato_fis,
      vo_num_seq_pessoal_fis    OUT      tyt_num_seq_pessoal_fis,
      vi_num_seq_contrato_fis   IN       t_num_seq_contrato_fis,
      vi_num_seq_pessoal_fis    IN       t_num_seq_pessoal_fis
   );

   PROCEDURE stp_altera_fiscais_contrato (
      p_usuario                          VARCHAR2,
      vo_num_seq_contrato_fis   OUT      tyt_num_seq_contrato_fis,
      vo_num_seq_pessoal_fis    OUT      tyt_num_seq_pessoal_fis,
      vi_num_seq_contrato_fis   IN       t_num_seq_contrato_fis,
      vi_num_seq_pessoal_fis    IN       t_num_seq_pessoal_fis
   );

   --- CAD_RESUMO_VALORES
   SUBTYPE t_num_seq_contrato_res IS ifrbde_views.cad_resumo_valores.num_seq_contrato_res%TYPE;

   SUBTYPE t_num_seq_resumo IS ifrbde_views.cad_resumo_valores.num_seq_resumo%TYPE;

   SUBTYPE t_val_resumo IS ifrbde_views.cad_resumo_valores.val_resumo%TYPE;

   SUBTYPE t_val_termo IS VARCHAR2 (30);

   SUBTYPE t_val_pagamento IS VARCHAR2 (30);

   SUBTYPE t_val_reajuste IS VARCHAR2 (30);

   SUBTYPE t_val_pago IS VARCHAR2 (30);

   SUBTYPE t_val_pago_reajuste IS VARCHAR2 (30);

   SUBTYPE t_val_saldo_resumo IS VARCHAR2 (30);

   SUBTYPE t_flg_moeda_controle IS ifrbde_views.cad_resumo_valores.flg_moeda_controle%TYPE;

   SUBTYPE t_tip_moeda IS ifrbde_views.cad_resumo_valores.tip_moeda%TYPE;

   SUBTYPE t_dat_moeda IS t_data;

   SUBTYPE t_val_cotacao_moeda IS ifrbde_views.cad_resumo_valores.val_cotacao_moeda%TYPE;

   SUBTYPE t_tip_cotacao_moeda IS ifrbde_views.cad_resumo_valores.tip_cotacao_moeda%TYPE;

   SUBTYPE t_val_resumo_sec IS VARCHAR2 (30);

   SUBTYPE t_val_termo_sec IS VARCHAR2 (30);

   SUBTYPE t_val_pagamento_sec IS VARCHAR2 (30);

   SUBTYPE t_val_reajuste_sec IS VARCHAR2 (30);

   SUBTYPE t_val_pago_sec IS VARCHAR2 (30);

   SUBTYPE t_val_pago_reajuste_sec IS VARCHAR2 (30);

   SUBTYPE t_val_saldo_resumo_sec IS VARCHAR2 (30);

   TYPE tyt_num_seq_contrato_res IS TABLE OF t_num_seq_contrato_res
      INDEX BY BINARY_INTEGER;

   TYPE tyt_num_seq_resumo IS TABLE OF t_num_seq_resumo
      INDEX BY BINARY_INTEGER;

   TYPE tyt_val_resumo IS TABLE OF t_val_resumo
      INDEX BY BINARY_INTEGER;

   TYPE tyt_val_termo IS TABLE OF t_val_termo
      INDEX BY BINARY_INTEGER;

   TYPE tyt_val_pagamento IS TABLE OF t_val_pagamento
      INDEX BY BINARY_INTEGER;

   TYPE tyt_val_reajuste IS TABLE OF t_val_reajuste
      INDEX BY BINARY_INTEGER;

   TYPE tyt_val_pago IS TABLE OF t_val_pago
      INDEX BY BINARY_INTEGER;

   TYPE tyt_val_pago_reajuste IS TABLE OF t_val_pago_reajuste
      INDEX BY BINARY_INTEGER;

   TYPE tyt_val_saldo_resumo IS TABLE OF t_val_saldo_resumo
      INDEX BY BINARY_INTEGER;

   TYPE tyt_flg_moeda_controle IS TABLE OF t_flg_moeda_controle
      INDEX BY BINARY_INTEGER;

   TYPE tyt_tip_moeda IS TABLE OF t_tip_moeda
      INDEX BY BINARY_INTEGER;

   TYPE tyt_dat_moeda IS TABLE OF t_dat_moeda
      INDEX BY BINARY_INTEGER;

   TYPE tyt_val_cotacao_moeda IS TABLE OF t_val_cotacao_moeda
      INDEX BY BINARY_INTEGER;

   TYPE tyt_tip_cotacao_moeda IS TABLE OF t_tip_cotacao_moeda
      INDEX BY BINARY_INTEGER;

   TYPE tyt_val_resumo_sec IS TABLE OF t_val_resumo_sec
      INDEX BY BINARY_INTEGER;

   TYPE tyt_val_termo_sec IS TABLE OF t_val_termo_sec
      INDEX BY BINARY_INTEGER;

   TYPE tyt_val_pagamento_sec IS TABLE OF t_val_pagamento_sec
      INDEX BY BINARY_INTEGER;

   TYPE tyt_val_reajuste_sec IS TABLE OF t_val_reajuste_sec
      INDEX BY BINARY_INTEGER;

   TYPE tyt_val_pago_sec IS TABLE OF t_val_pago_sec
      INDEX BY BINARY_INTEGER;

   TYPE tyt_val_pago_reajuste_sec IS TABLE OF t_val_pago_reajuste_sec
      INDEX BY BINARY_INTEGER;

   TYPE tyt_val_saldo_resumo_sec IS TABLE OF t_val_saldo_resumo_sec
      INDEX BY BINARY_INTEGER;

   PROCEDURE stp_pesquisa_resumo_valores (
      p_usuario                           VARCHAR2,
      vo_num_seq_contrato_res    OUT      tyt_num_seq_contrato_res,
      vo_num_seq_resumo          OUT      tyt_num_seq_resumo,
      vo_val_resumo              OUT      tyt_val_resumo,
      vo_val_termo               OUT      tyt_val_termo,
      vo_val_pagamento           OUT      tyt_val_pagamento,
      vo_val_reajuste            OUT      tyt_val_reajuste,
      vo_val_pago                OUT      tyt_val_pago,
      vo_val_pago_reajuste       OUT      tyt_val_pago_reajuste,
      vo_val_saldo_resumo        OUT      tyt_val_saldo_resumo,
      vo_flg_moeda_controle      OUT      tyt_flg_moeda_controle,
      vo_tip_moeda               OUT      tyt_tip_moeda,
      vo_dat_moeda               OUT      tyt_dat_moeda,
      vo_val_cotacao_moeda       OUT      tyt_val_cotacao_moeda,
      vo_tip_cotacao_moeda       OUT      tyt_tip_cotacao_moeda,
      vo_val_resumo_sec          OUT      tyt_val_resumo_sec,
      vo_val_termo_sec           OUT      tyt_val_termo_sec,
      vo_val_pagamento_sec       OUT      tyt_val_pagamento_sec,
      vo_val_reajuste_sec        OUT      tyt_val_reajuste_sec,
      vo_val_pago_sec            OUT      tyt_val_pago_sec,
      vo_val_pago_reajuste_sec   OUT      tyt_val_pago_reajuste_sec,
      vo_val_saldo_resumo_sec    OUT      tyt_val_saldo_resumo_sec,
      vi_num_seq_contrato_res    IN       t_num_seq_contrato_res,
      vi_num_seq_resumo          IN       t_num_seq_resumo
   );

   PROCEDURE stp_exclui_resumo_valores (
      p_usuario                          VARCHAR2,
      vo_ok                     OUT      tyt_ok,
      vi_num_seq_contrato_res   IN       t_num_seq_contrato_res,
      vi_num_seq_resumo         IN       t_num_seq_resumo
   );

   PROCEDURE stp_inclui_resumo_valores (
      p_usuario                           VARCHAR2,
      vo_num_seq_contrato_res    OUT      tyt_num_seq_contrato_res,
      vo_num_seq_resumo          OUT      tyt_num_seq_resumo,
      vo_val_resumo              OUT      tyt_val_resumo,
      vo_val_termo               OUT      tyt_val_termo,
      vo_val_pagamento           OUT      tyt_val_pagamento,
      vo_val_reajuste            OUT      tyt_val_reajuste,
      vo_val_pago                OUT      tyt_val_pago,
      vo_val_pago_reajuste       OUT      tyt_val_pago_reajuste,
      vo_val_saldo_resumo        OUT      tyt_val_saldo_resumo,
      vo_flg_moeda_controle      OUT      tyt_flg_moeda_controle,
      vo_tip_moeda               OUT      tyt_tip_moeda,
      vo_dat_moeda               OUT      tyt_dat_moeda,
      vo_val_cotacao_moeda       OUT      tyt_val_cotacao_moeda,
      vo_tip_cotacao_moeda       OUT      tyt_tip_cotacao_moeda,
      vo_val_resumo_sec          OUT      tyt_val_resumo_sec,
      vo_val_termo_sec           OUT      tyt_val_termo_sec,
      vo_val_pagamento_sec       OUT      tyt_val_pagamento_sec,
      vo_val_reajuste_sec        OUT      tyt_val_reajuste_sec,
      vo_val_pago_sec            OUT      tyt_val_pago_sec,
      vo_val_pago_reajuste_sec   OUT      tyt_val_pago_reajuste_sec,
      vo_val_saldo_resumo_sec    OUT      tyt_val_saldo_resumo_sec,
      vi_num_seq_contrato_res    IN       t_num_seq_contrato_res,
      vi_val_resumo              IN       t_val_resumo,
      vi_flg_moeda_controle      IN       t_flg_moeda_controle,
      vi_tip_moeda               IN       t_tip_moeda,
      vi_dat_moeda               IN       t_dat_moeda,
      vi_val_cotacao_moeda       IN       t_val_cotacao_moeda,
      vi_tip_cotacao_moeda       IN       t_tip_cotacao_moeda
   );

   PROCEDURE stp_altera_resumo_valores (
      p_usuario                           VARCHAR2,
      vo_num_seq_contrato_res    OUT      tyt_num_seq_contrato_res,
      vo_num_seq_resumo          OUT      tyt_num_seq_resumo,
      vo_val_resumo              OUT      tyt_val_resumo,
      vo_val_termo               OUT      tyt_val_termo,
      vo_val_pagamento           OUT      tyt_val_pagamento,
      vo_val_reajuste            OUT      tyt_val_reajuste,
      vo_val_pago                OUT      tyt_val_pago,
      vo_val_pago_reajuste       OUT      tyt_val_pago_reajuste,
      vo_val_saldo_resumo        OUT      tyt_val_saldo_resumo,
      vo_flg_moeda_controle      OUT      tyt_flg_moeda_controle,
      vo_tip_moeda               OUT      tyt_tip_moeda,
      vo_dat_moeda               OUT      tyt_dat_moeda,
      vo_val_cotacao_moeda       OUT      tyt_val_cotacao_moeda,
      vo_tip_cotacao_moeda       OUT      tyt_tip_cotacao_moeda,
      vo_val_resumo_sec          OUT      tyt_val_resumo_sec,
      vo_val_termo_sec           OUT      tyt_val_termo_sec,
      vo_val_pagamento_sec       OUT      tyt_val_pagamento_sec,
      vo_val_reajuste_sec        OUT      tyt_val_reajuste_sec,
      vo_val_pago_sec            OUT      tyt_val_pago_sec,
      vo_val_pago_reajuste_sec   OUT      tyt_val_pago_reajuste_sec,
      vo_val_saldo_resumo_sec    OUT      tyt_val_saldo_resumo_sec,
      vi_num_seq_contrato_res    IN       t_num_seq_contrato_res,
      vi_num_seq_resumo          IN       t_num_seq_resumo,
      vi_val_resumo              IN       t_val_resumo,
      vi_flg_moeda_controle      IN       t_flg_moeda_controle,
      vi_tip_moeda               IN       t_tip_moeda,
      vi_dat_moeda               IN       t_dat_moeda,
      vi_val_cotacao_moeda       IN       t_val_cotacao_moeda,
      vi_tip_cotacao_moeda       IN       t_tip_cotacao_moeda
   );

   --- TAB_CONT_CRONO_PAGAMENTO
   SUBTYPE t_num_seq_cronograma IS ifrbde_views.tab_cont_crono_pagamento.num_seq_cronograma%TYPE;

   SUBTYPE t_num_seq_contrato_cron IS ifrbde_views.tab_cont_crono_pagamento.num_seq_contrato_cron%TYPE;

   SUBTYPE t_ccp_pgose IS ifrbde_views.tab_cont_crono_pagamento.ccp_pgose%TYPE;

   SUBTYPE t_ccp_rti_cod IS ifrbde_views.tab_cont_crono_pagamento.ccp_rti_cod%TYPE;

   SUBTYPE t_ccp_data_venc IS t_data;

   SUBTYPE t_ccp_valor IS ifrbde_views.tab_cont_crono_pagamento.ccp_valor%TYPE;

   SUBTYPE t_tip_cronograma IS ifrbde_views.tab_cont_crono_pagamento.tip_cronograma%TYPE;

   SUBTYPE t_val_saldo_crono IS VARCHAR2 (20);

   SUBTYPE t_val_saldo_crono_sec IS VARCHAR2 (20);

   TYPE tyt_num_seq_cronograma IS TABLE OF t_num_seq_cronograma
      INDEX BY BINARY_INTEGER;

   TYPE tyt_num_seq_contrato_cron IS TABLE OF t_num_seq_contrato_cron
      INDEX BY BINARY_INTEGER;

   TYPE tyt_ccp_pgose IS TABLE OF t_ccp_pgose
      INDEX BY BINARY_INTEGER;

   TYPE tyt_ccp_rti_cod IS TABLE OF t_ccp_rti_cod
      INDEX BY BINARY_INTEGER;

   TYPE tyt_ccp_data_venc IS TABLE OF t_ccp_data_venc
      INDEX BY BINARY_INTEGER;

   TYPE tyt_ccp_valor IS TABLE OF t_ccp_valor
      INDEX BY BINARY_INTEGER;

   TYPE tyt_tip_cronograma IS TABLE OF t_tip_cronograma
      INDEX BY BINARY_INTEGER;

   TYPE tyt_val_saldo_crono IS TABLE OF t_val_saldo_crono
      INDEX BY BINARY_INTEGER;

   TYPE tyt_val_saldo_crono_sec IS TABLE OF t_val_saldo_crono_sec
      INDEX BY BINARY_INTEGER;

   PROCEDURE stp_pesquisa_cont_crono_pagame (
      p_usuario                           VARCHAR2,
      vo_num_seq_cronograma      OUT      tyt_num_seq_cronograma,
      vo_num_seq_contrato_cron   OUT      tyt_num_seq_contrato_cron,
      vo_ccp_pgose               OUT      tyt_ccp_pgose,
      vo_ccp_rti_cod             OUT      tyt_ccp_rti_cod,
      vo_ccp_data_venc           OUT      tyt_ccp_data_venc,
      vo_ccp_valor               OUT      tyt_ccp_valor,
      vo_tip_cronograma          OUT      tyt_tip_cronograma,
      vo_val_saldo_crono         OUT      tyt_val_saldo_crono,
      vo_val_saldo_crono_sec     OUT      tyt_val_saldo_crono_sec,
      vi_num_seq_cronograma      IN       t_num_seq_cronograma,
      vi_num_seq_contrato_cron   IN       t_num_seq_contrato_cron,
      vi_ccp_pgose               IN       t_ccp_pgose,
      vi_ccp_data_venc           IN       t_ccp_data_venc
   );

   PROCEDURE stp_exclui_cont_crono_pagament (
      p_usuario                           VARCHAR2,
      vo_ok                      OUT      tyt_ok,
      vi_num_seq_cronograma      IN       t_num_seq_cronograma,
      vi_num_seq_contrato_cron   IN       t_num_seq_contrato_cron,
      vi_ccp_pgose               IN       t_ccp_pgose,
      vi_ccp_data_venc           IN       t_ccp_data_venc
   );

   PROCEDURE stp_inclui_cont_crono_pagament (
      p_usuario                           VARCHAR2,
      vo_num_seq_cronograma      OUT      tyt_num_seq_cronograma,
      vo_num_seq_contrato_cron   OUT      tyt_num_seq_contrato_cron,
      vo_ccp_pgose               OUT      tyt_ccp_pgose,
      vo_ccp_rti_cod             OUT      tyt_ccp_rti_cod,
      vo_ccp_data_venc           OUT      tyt_ccp_data_venc,
      vo_ccp_valor               OUT      tyt_ccp_valor,
      vo_tip_cronograma          OUT      tyt_tip_cronograma,
      vo_val_saldo_crono         OUT      tyt_val_saldo_crono,
      vo_val_saldo_crono_sec     OUT      tyt_val_saldo_crono_sec,
      vi_num_seq_contrato_cron   IN       t_num_seq_contrato_cron,
      vi_ccp_pgose               IN       t_ccp_pgose,
      vi_ccp_rti_cod             IN       t_ccp_rti_cod,
      vi_ccp_data_venc           IN       t_ccp_data_venc,
      vi_ccp_valor               IN       t_ccp_valor,
      vi_tip_cronograma          IN       t_tip_cronograma
   );

   PROCEDURE stp_altera_cont_crono_pagament (
      p_usuario                           VARCHAR2,
      vo_num_seq_cronograma      OUT      tyt_num_seq_cronograma,
      vo_num_seq_contrato_cron   OUT      tyt_num_seq_contrato_cron,
      vo_ccp_pgose               OUT      tyt_ccp_pgose,
      vo_ccp_rti_cod             OUT      tyt_ccp_rti_cod,
      vo_ccp_data_venc           OUT      tyt_ccp_data_venc,
      vo_ccp_valor               OUT      tyt_ccp_valor,
      vo_tip_cronograma          OUT      tyt_tip_cronograma,
      vo_val_saldo_crono         OUT      tyt_val_saldo_crono,
      vo_val_saldo_crono_sec     OUT      tyt_val_saldo_crono_sec,
      vi_num_seq_cronograma      IN       t_num_seq_cronograma,
      vi_num_seq_contrato_cron   IN       t_num_seq_contrato_cron,
      vi_ccp_pgose               IN       t_ccp_pgose,
      vi_ccp_rti_cod             IN       t_ccp_rti_cod,
      vi_ccp_data_venc           IN       t_ccp_data_venc,
      vi_ccp_valor               IN       t_ccp_valor,
      vi_tip_cronograma          IN       t_tip_cronograma
   );

   
--------------------------------------------------------------------------------
   --- CAD_RESUMO_PAGAMENTO
   SUBTYPE t_num_seq_pag_contrato_rp IS ifrbde_views.cad_resumo_pagamento.num_seq_pag_contrato_rp%TYPE;

   SUBTYPE t_num_seq_resumo_pag IS ifrbde_views.cad_resumo_pagamento.num_seq_resumo_pag%TYPE;

   SUBTYPE t_num_seq_entidade_pag IS ifrbde_views.cad_resumo_pagamento.num_seq_entidade_pag%TYPE;

   SUBTYPE t_cod_tipo_pag_rp IS ifrbde_views.cad_resumo_pagamento.cod_tipo_pag_rp%TYPE;

   SUBTYPE t_dat_pagamento IS t_data;

   SUBTYPE t_dat_vencimento_pag IS t_data;

   SUBTYPE t_num_fatura_rp IS ifrbde_views.cad_resumo_pagamento.num_fatura_rp%TYPE;

   SUBTYPE t_dat_moeda_rp IS t_data;

   SUBTYPE t_val_cotacao_moeda_rp IS ifrbde_views.cad_resumo_pagamento.val_cotacao_moeda_rp%TYPE;

   SUBTYPE t_tip_cotacao_moeda_rp IS ifrbde_views.cad_resumo_pagamento.tip_cotacao_moeda_rp%TYPE;

   SUBTYPE t_val_pagamento_rp IS ifrbde_views.cad_resumo_pagamento.val_pagamento_rp%TYPE;

   SUBTYPE t_val_glosa_rp IS ifrbde_views.cad_resumo_pagamento.val_glosa_rp%TYPE;

   SUBTYPE t_dsc_glosa_rp IS ifrbde_views.cad_resumo_pagamento.dsc_glosa_rp%TYPE;

   SUBTYPE t_val_retencao_rp IS ifrbde_views.cad_resumo_pagamento.val_retencao_rp%TYPE;

   SUBTYPE t_num_seq_entidade_rp IS ifrbde_views.cad_resumo_pagamento.num_seq_entidade_rp%TYPE;

   SUBTYPE t_val_multa_rp IS ifrbde_views.cad_resumo_pagamento.val_multa_rp%TYPE;

   SUBTYPE t_dsc_retencao_rp IS ifrbde_views.cad_resumo_pagamento.dsc_retencao_rp%TYPE;

   SUBTYPE t_val_imposto_irrf_rp IS ifrbde_views.cad_resumo_pagamento.val_imposto_irrf_rp%TYPE;

   SUBTYPE t_val_imposto_iss_rp IS ifrbde_views.cad_resumo_pagamento.val_imposto_iss_rp%TYPE;

   SUBTYPE t_val_imposto_pasep_rp IS ifrbde_views.cad_resumo_pagamento.val_imposto_pasep_rp%TYPE;

   SUBTYPE t_val_imposto_icms_rp IS ifrbde_views.cad_resumo_pagamento.val_imposto_icms_rp%TYPE;

   SUBTYPE t_val_imposto_inss_rp IS ifrbde_views.cad_resumo_pagamento.val_imposto_inss_rp%TYPE;

   SUBTYPE t_val_impostos_rp IS VARCHAR2 (24);

   SUBTYPE t_val_liquido_nota_rp IS ifrbde_views.cad_resumo_pagamento.val_liquido_nota_rp%TYPE;

   SUBTYPE t_dsc_solicitacao_rp IS ifrbde_views.cad_resumo_pagamento.dsc_solicitacao_rp%TYPE;

   SUBTYPE t_tip_situacao_pag IS ifrbde_views.cad_resumo_pagamento.tip_situacao_pag%TYPE;

   TYPE tyt_num_seq_pag_contrato_rp IS TABLE OF t_num_seq_pag_contrato_rp
      INDEX BY BINARY_INTEGER;

   TYPE tyt_num_seq_resumo_pag IS TABLE OF t_num_seq_resumo_pag
      INDEX BY BINARY_INTEGER;

   TYPE tyt_num_seq_entidade_pag IS TABLE OF t_num_seq_entidade_pag
      INDEX BY BINARY_INTEGER;

   TYPE tyt_cod_tipo_pag_rp IS TABLE OF t_cod_tipo_pag_rp
      INDEX BY BINARY_INTEGER;

   TYPE tyt_dat_pagamento IS TABLE OF t_dat_pagamento
      INDEX BY BINARY_INTEGER;

   TYPE tyt_dat_vencimento_pag IS TABLE OF t_dat_vencimento_pag
      INDEX BY BINARY_INTEGER;

   TYPE tyt_num_fatura_rp IS TABLE OF t_num_fatura_rp
      INDEX BY BINARY_INTEGER;

   TYPE tyt_dat_moeda_rp IS TABLE OF t_dat_moeda_rp
      INDEX BY BINARY_INTEGER;

   TYPE tyt_val_cotacao_moeda_rp IS TABLE OF t_val_cotacao_moeda_rp
      INDEX BY BINARY_INTEGER;

   TYPE tyt_tip_cotacao_moeda_rp IS TABLE OF t_tip_cotacao_moeda_rp
      INDEX BY BINARY_INTEGER;

   TYPE tyt_val_pagamento_rp IS TABLE OF t_val_pagamento_rp
      INDEX BY BINARY_INTEGER;

   TYPE tyt_val_glosa_rp IS TABLE OF t_val_glosa_rp
      INDEX BY BINARY_INTEGER;

   TYPE tyt_dsc_glosa_rp IS TABLE OF t_dsc_glosa_rp
      INDEX BY BINARY_INTEGER;

   TYPE tyt_val_retencao_rp IS TABLE OF t_val_retencao_rp
      INDEX BY BINARY_INTEGER;

   TYPE tyt_num_seq_entidade_rp IS TABLE OF t_num_seq_entidade_rp
      INDEX BY BINARY_INTEGER;

   TYPE tyt_val_multa_rp IS TABLE OF t_val_multa_rp
      INDEX BY BINARY_INTEGER;

   TYPE tyt_dsc_retencao_rp IS TABLE OF t_dsc_retencao_rp
      INDEX BY BINARY_INTEGER;

   TYPE tyt_val_imposto_irrf_rp IS TABLE OF t_val_imposto_irrf_rp
      INDEX BY BINARY_INTEGER;

   TYPE tyt_val_imposto_iss_rp IS TABLE OF t_val_imposto_iss_rp
      INDEX BY BINARY_INTEGER;

   TYPE tyt_val_imposto_pasep_rp IS TABLE OF t_val_imposto_pasep_rp
      INDEX BY BINARY_INTEGER;

   TYPE tyt_val_imposto_icms_rp IS TABLE OF t_val_imposto_icms_rp
      INDEX BY BINARY_INTEGER;

   TYPE tyt_val_imposto_inss_rp IS TABLE OF t_val_imposto_inss_rp
      INDEX BY BINARY_INTEGER;

   TYPE tyt_val_impostos_rp IS TABLE OF t_val_impostos_rp
      INDEX BY BINARY_INTEGER;

   TYPE tyt_val_liquido_nota_rp IS TABLE OF t_val_liquido_nota_rp
      INDEX BY BINARY_INTEGER;

   TYPE tyt_dsc_solicitacao_rp IS TABLE OF t_dsc_solicitacao_rp
      INDEX BY BINARY_INTEGER;

   TYPE tyt_tip_situacao_pag IS TABLE OF t_tip_situacao_pag
      INDEX BY BINARY_INTEGER;

   PROCEDURE stp_pesquisa_resumo_pagamento (
      p_usuario                             VARCHAR2,
      vo_num_seq_pag_contrato_rp   OUT      tyt_num_seq_pag_contrato_rp,
      vo_num_seq_resumo_pag        OUT      tyt_num_seq_resumo_pag,
      vo_num_seq_entidade_pag      OUT      tyt_num_seq_entidade_pag,
      vo_cod_tipo_pag_rp           OUT      tyt_cod_tipo_pag_rp,
      vo_dat_pagamento             OUT      tyt_dat_pagamento,
      vo_dat_vencimento_pag        OUT      tyt_dat_vencimento_pag,
      vo_num_fatura_rp             OUT      tyt_num_fatura_rp,
      vo_dat_moeda_rp              OUT      tyt_dat_moeda_rp,
      vo_val_cotacao_moeda_rp      OUT      tyt_val_cotacao_moeda_rp,
      vo_tip_cotacao_moeda_rp      OUT      tyt_tip_cotacao_moeda_rp,
      vo_val_pagamento_rp          OUT      tyt_val_pagamento_rp,
      vo_val_glosa_rp              OUT      tyt_val_glosa_rp,
      vo_dsc_glosa_rp              OUT      tyt_dsc_glosa_rp,
      vo_val_retencao_rp           OUT      tyt_val_retencao_rp,
      vo_num_seq_entidade_rp       OUT      tyt_num_seq_entidade_rp,
      vo_val_multa_rp              OUT      tyt_val_multa_rp,
      vo_dsc_retencao_rp           OUT      tyt_dsc_retencao_rp,
      vo_val_imposto_irrf_rp       OUT      tyt_val_imposto_irrf_rp,
      vo_val_imposto_iss_rp        OUT      tyt_val_imposto_iss_rp,
      vo_val_imposto_pasep_rp      OUT      tyt_val_imposto_pasep_rp,
      vo_val_imposto_icms_rp       OUT      tyt_val_imposto_icms_rp,
      vo_val_imposto_inss_rp       OUT      tyt_val_imposto_inss_rp,
      vo_val_impostos_rp           OUT      tyt_val_impostos_rp,
      vo_val_liquido_nota_rp       OUT      tyt_val_liquido_nota_rp,
      vo_dsc_solicitacao_rp        OUT      tyt_dsc_solicitacao_rp,
      vo_tip_situacao_pag          OUT      tyt_tip_situacao_pag,
      vi_num_seq_pag_contrato_rp   IN       t_num_seq_pag_contrato_rp,
      vi_num_seq_resumo_pag        IN       t_num_seq_resumo_pag
   );

   PROCEDURE stp_exclui_resumo_pagamento (
      p_usuario                             VARCHAR2,
      vo_ok                        OUT      tyt_ok,
      vi_num_seq_pag_contrato_rp   IN       t_num_seq_pag_contrato_rp,
      vi_num_seq_resumo_pag        IN       t_num_seq_resumo_pag
   );

   PROCEDURE stp_inclui_resumo_pagamento (
      p_usuario                             VARCHAR2,
      vo_num_seq_pag_contrato_rp   OUT      tyt_num_seq_pag_contrato_rp,
      vo_num_seq_resumo_pag        OUT      tyt_num_seq_resumo_pag,
      vo_num_seq_entidade_pag      OUT      tyt_num_seq_entidade_pag,
      vo_cod_tipo_pag_rp           OUT      tyt_cod_tipo_pag_rp,
      vo_dat_pagamento             OUT      tyt_dat_pagamento,
      vo_dat_vencimento_pag        OUT      tyt_dat_vencimento_pag,
      vo_num_fatura_rp             OUT      tyt_num_fatura_rp,
      vo_dat_moeda_rp              OUT      tyt_dat_moeda_rp,
      vo_val_cotacao_moeda_rp      OUT      tyt_val_cotacao_moeda_rp,
      vo_tip_cotacao_moeda_rp      OUT      tyt_tip_cotacao_moeda_rp,
      vo_val_pagamento_rp          OUT      tyt_val_pagamento_rp,
      vo_val_glosa_rp              OUT      tyt_val_glosa_rp,
      vo_dsc_glosa_rp              OUT      tyt_dsc_glosa_rp,
      vo_val_retencao_rp           OUT      tyt_val_retencao_rp,
      vo_num_seq_entidade_rp       OUT      tyt_num_seq_entidade_rp,
      vo_val_multa_rp              OUT      tyt_val_multa_rp,
      vo_dsc_retencao_rp           OUT      tyt_dsc_retencao_rp,
      vo_val_imposto_irrf_rp       OUT      tyt_val_imposto_irrf_rp,
      vo_val_imposto_iss_rp        OUT      tyt_val_imposto_iss_rp,
      vo_val_imposto_pasep_rp      OUT      tyt_val_imposto_pasep_rp,
      vo_val_imposto_icms_rp       OUT      tyt_val_imposto_icms_rp,
      vo_val_imposto_inss_rp       OUT      tyt_val_imposto_inss_rp,
      vo_val_impostos_rp           OUT      tyt_val_impostos_rp,
      vo_val_liquido_nota_rp       OUT      tyt_val_liquido_nota_rp,
      vo_dsc_solicitacao_rp        OUT      tyt_dsc_solicitacao_rp,
      vo_tip_situacao_pag          OUT      tyt_tip_situacao_pag,
      vi_num_seq_pag_contrato_rp   IN       t_num_seq_pag_contrato_rp,
      vi_num_seq_entidade_pag      IN       t_num_seq_entidade_pag,
      vi_cod_tipo_pag_rp           IN       t_cod_tipo_pag_rp,
      vi_dat_pagamento             IN       t_dat_pagamento,
      vi_dat_vencimento_pag        IN       t_dat_vencimento_pag,
      vi_num_fatura_rp             IN       t_num_fatura_rp,
      vi_dat_moeda_rp              IN       t_dat_moeda_rp,
      vi_val_cotacao_moeda_rp      IN       t_val_cotacao_moeda_rp,
      vi_tip_cotacao_moeda_rp      IN       t_tip_cotacao_moeda_rp,
      vi_val_pagamento_rp          IN       t_val_pagamento_rp,
      vi_val_glosa_rp              IN       t_val_glosa_rp,
      vi_dsc_glosa_rp              IN       t_dsc_glosa_rp,
      vi_val_retencao_rp           IN       t_val_retencao_rp,
      vi_num_seq_entidade_rp       IN       t_num_seq_entidade_rp,
      vi_val_multa_rp              IN       t_val_multa_rp,
      vi_dsc_retencao_rp           IN       t_dsc_retencao_rp,
      vi_val_imposto_irrf_rp       IN       t_val_imposto_irrf_rp,
      vi_val_imposto_iss_rp        IN       t_val_imposto_iss_rp,
      vi_val_imposto_pasep_rp      IN       t_val_imposto_pasep_rp,
      vi_val_imposto_icms_rp       IN       t_val_imposto_icms_rp,
      vi_val_imposto_inss_rp       IN       t_val_imposto_inss_rp,
      vi_val_liquido_nota_rp       IN       t_val_liquido_nota_rp,
      vi_dsc_solicitacao_rp        IN       t_dsc_solicitacao_rp,
      vi_tip_situacao_pag          IN       t_tip_situacao_pag
   );

   PROCEDURE stp_altera_resumo_pagamento (
      p_usuario                             VARCHAR2,
      vo_num_seq_pag_contrato_rp   OUT      tyt_num_seq_pag_contrato_rp,
      vo_num_seq_resumo_pag        OUT      tyt_num_seq_resumo_pag,
      vo_num_seq_entidade_pag      OUT      tyt_num_seq_entidade_pag,
      vo_cod_tipo_pag_rp           OUT      tyt_cod_tipo_pag_rp,
      vo_dat_pagamento             OUT      tyt_dat_pagamento,
      vo_dat_vencimento_pag        OUT      tyt_dat_vencimento_pag,
      vo_num_fatura_rp             OUT      tyt_num_fatura_rp,
      vo_dat_moeda_rp              OUT      tyt_dat_moeda_rp,
      vo_val_cotacao_moeda_rp      OUT      tyt_val_cotacao_moeda_rp,
      vo_tip_cotacao_moeda_rp      OUT      tyt_tip_cotacao_moeda_rp,
      vo_val_pagamento_rp          OUT      tyt_val_pagamento_rp,
      vo_val_glosa_rp              OUT      tyt_val_glosa_rp,
      vo_dsc_glosa_rp              OUT      tyt_dsc_glosa_rp,
      vo_val_retencao_rp           OUT      tyt_val_retencao_rp,
      vo_num_seq_entidade_rp       OUT      tyt_num_seq_entidade_rp,
      vo_val_multa_rp              OUT      tyt_val_multa_rp,
      vo_dsc_retencao_rp           OUT      tyt_dsc_retencao_rp,
      vo_val_imposto_irrf_rp       OUT      tyt_val_imposto_irrf_rp,
      vo_val_imposto_iss_rp        OUT      tyt_val_imposto_iss_rp,
      vo_val_imposto_pasep_rp      OUT      tyt_val_imposto_pasep_rp,
      vo_val_imposto_icms_rp       OUT      tyt_val_imposto_icms_rp,
      vo_val_imposto_inss_rp       OUT      tyt_val_imposto_inss_rp,
      vo_val_impostos_rp           OUT      tyt_val_impostos_rp,
      vo_val_liquido_nota_rp       OUT      tyt_val_liquido_nota_rp,
      vo_dsc_solicitacao_rp        OUT      tyt_dsc_solicitacao_rp,
      vo_tip_situacao_pag          OUT      tyt_tip_situacao_pag,
      vi_num_seq_pag_contrato_rp   IN       t_num_seq_pag_contrato_rp,
      vi_num_seq_resumo_pag        IN       t_num_seq_resumo_pag,
      vi_num_seq_entidade_pag      IN       t_num_seq_entidade_pag,
      vi_cod_tipo_pag_rp           IN       t_cod_tipo_pag_rp,
      vi_dat_pagamento             IN       t_dat_pagamento,
      vi_dat_vencimento_pag        IN       t_dat_vencimento_pag,
      vi_num_fatura_rp             IN       t_num_fatura_rp,
      vi_dat_moeda_rp              IN       t_dat_moeda_rp,
      vi_val_cotacao_moeda_rp      IN       t_val_cotacao_moeda_rp,
      vi_tip_cotacao_moeda_rp      IN       t_tip_cotacao_moeda_rp,
      vi_val_pagamento_rp          IN       t_val_pagamento_rp,
      vi_val_glosa_rp              IN       t_val_glosa_rp,
      vi_dsc_glosa_rp              IN       t_dsc_glosa_rp,
      vi_val_retencao_rp           IN       t_val_retencao_rp,
      vi_num_seq_entidade_rp       IN       t_num_seq_entidade_rp,
      vi_val_multa_rp              IN       t_val_multa_rp,
      vi_dsc_retencao_rp           IN       t_dsc_retencao_rp,
      vi_val_imposto_irrf_rp       IN       t_val_imposto_irrf_rp,
      vi_val_imposto_iss_rp        IN       t_val_imposto_iss_rp,
      vi_val_imposto_pasep_rp      IN       t_val_imposto_pasep_rp,
      vi_val_imposto_icms_rp       IN       t_val_imposto_icms_rp,
      vi_val_imposto_inss_rp       IN       t_val_imposto_inss_rp,
      vi_val_liquido_nota_rp       IN       t_val_liquido_nota_rp,
      vi_dsc_solicitacao_rp        IN       t_dsc_solicitacao_rp,
      vi_tip_situacao_pag          IN       t_tip_situacao_pag
   );

   
--------------------------------------------------------------------------------
   --- TAB_CONTRATO
   SUBTYPE t_num_seq_contrato IS ifrbde_views.tab_contrato.num_seq_contrato%TYPE;

   SUBTYPE t_cnt_cre_cod IS ifrbde_views.tab_contrato.cnt_cre_cod%TYPE;

   SUBTYPE t_cnt_cod IS ifrbde_views.tab_contrato.cnt_cod%TYPE;

   SUBTYPE t_num_versao_contrato IS ifrbde_views.tab_contrato.num_versao_contrato%TYPE;

   SUBTYPE t_num_termo_aditivo IS VARCHAR2 (40);

   SUBTYPE t_cod_dep_contrato IS ifrbde_views.tab_contrato.cod_dep_contrato%TYPE;

   SUBTYPE t_cnt_justificativa_cre IS ifrbde_views.tab_contrato.cnt_justificativa_cre%TYPE;

   SUBTYPE t_num_seq_gestor IS ifrbde_views.tab_contrato.num_seq_gestor%TYPE;

   SUBTYPE t_num_seq_assinatura_1 IS ifrbde_views.tab_contrato.num_seq_assinatura_1%TYPE;

   SUBTYPE t_num_seq_assinatura_2 IS ifrbde_views.tab_contrato.num_seq_assinatura_2%TYPE;

   SUBTYPE t_num_ato_administrativo IS ifrbde_views.tab_contrato.num_ato_administrativo%TYPE;

   SUBTYPE t_cnt_cei IS ifrbde_views.tab_contrato.cnt_cei%TYPE;

   SUBTYPE t_cnt_crea IS ifrbde_views.tab_contrato.cnt_crea%TYPE;

   SUBTYPE t_cnt_ice_cod IS ifrbde_views.tab_contrato.cnt_ice_cod%TYPE;

   SUBTYPE t_cnt_data IS t_data;

   SUBTYPE t_cnt_data_proposta IS t_data;

   SUBTYPE t_cnt_data_inicio IS t_data;

   SUBTYPE t_cnt_prazo_exec IS ifrbde_views.tab_contrato.cnt_prazo_exec%TYPE;

   SUBTYPE t_num_prazo_exec_meses IS ifrbde_views.tab_contrato.num_prazo_exec_meses%TYPE;

   SUBTYPE t_cnt_prazo_adit IS VARCHAR2 (20);

   SUBTYPE t_dat_termino_contrato IS VARCHAR2 (20);

   SUBTYPE t_dat_publicacao IS t_data;

   SUBTYPE t_num_dou_publicacao IS ifrbde_views.tab_contrato.num_dou_publicacao%TYPE;

   SUBTYPE t_num_pagina_publicacao IS ifrbde_views.tab_contrato.num_pagina_publicacao%TYPE;

   SUBTYPE t_num_secao_publicacao IS ifrbde_views.tab_contrato.num_secao_publicacao%TYPE;

   SUBTYPE t_cod_modalidade_licitacao IS ifrbde_views.tab_contrato.cod_modalidade_licitacao%TYPE;

   SUBTYPE t_num_inciso IS ifrbde_views.tab_contrato.num_inciso%TYPE;

   SUBTYPE t_dsc_fundamento_legal IS ifrbde_views.tab_contrato.dsc_fundamento_legal%TYPE;

   SUBTYPE t_num_licitacao IS ifrbde_views.tab_contrato.num_licitacao%TYPE;

   SUBTYPE t_num_ano_licitacao IS ifrbde_views.tab_contrato.num_ano_licitacao%TYPE;

   SUBTYPE t_num_processo IS ifrbde_views.tab_contrato.num_processo%TYPE;

   SUBTYPE t_cnt_valor_compromisso IS VARCHAR2 (30);

   SUBTYPE t_cnt_valor_termo IS VARCHAR2 (30);

   SUBTYPE t_cnt_valor_pago IS VARCHAR2 (30);

   SUBTYPE t_cnt_valor_reaj IS VARCHAR2 (30);

   SUBTYPE t_cnt_valor_reaj_pago IS VARCHAR2 (30);

   SUBTYPE t_cnt_valor IS VARCHAR2 (30);

   SUBTYPE t_tip_situacao_contrato IS ifrbde_views.tab_contrato.tip_situacao_contrato%TYPE;

   SUBTYPE t_tip_contrato IS VARCHAR2 (4);

   SUBTYPE t_dsc_critica_contrato IS VARCHAR2 (1200);

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

   TYPE tyt_num_seq_gestor IS TABLE OF t_num_seq_gestor
      INDEX BY BINARY_INTEGER;

   TYPE tyt_num_seq_assinatura_1 IS TABLE OF t_num_seq_assinatura_1
      INDEX BY BINARY_INTEGER;

   TYPE tyt_num_seq_assinatura_2 IS TABLE OF t_num_seq_assinatura_2
      INDEX BY BINARY_INTEGER;

   TYPE tyt_num_ato_administrativo IS TABLE OF t_num_ato_administrativo
      INDEX BY BINARY_INTEGER;

   TYPE tyt_cnt_cei IS TABLE OF t_cnt_cei
      INDEX BY BINARY_INTEGER;

   TYPE tyt_cnt_crea IS TABLE OF t_cnt_crea
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

   TYPE tyt_dat_publicacao IS TABLE OF t_dat_publicacao
      INDEX BY BINARY_INTEGER;

   TYPE tyt_num_dou_publicacao IS TABLE OF t_num_dou_publicacao
      INDEX BY BINARY_INTEGER;

   TYPE tyt_num_pagina_publicacao IS TABLE OF t_num_pagina_publicacao
      INDEX BY BINARY_INTEGER;

   TYPE tyt_num_secao_publicacao IS TABLE OF t_num_secao_publicacao
      INDEX BY BINARY_INTEGER;

   TYPE tyt_cod_modalidade_licitacao IS TABLE OF t_cod_modalidade_licitacao
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

   PROCEDURE stp_pesquisa_contrato (
      p_usuario                              VARCHAR2,
      vo_num_seq_contrato           OUT      tyt_num_seq_contrato,
      vo_cnt_cre_cod                OUT      tyt_cnt_cre_cod,
      vo_cnt_cod                    OUT      tyt_cnt_cod,
      vo_num_versao_contrato        OUT      tyt_num_versao_contrato,
      vo_num_termo_aditivo          OUT      tyt_num_termo_aditivo,
      vo_cod_dep_contrato           OUT      tyt_cod_dep_contrato,
      vo_cnt_justificativa_cre      OUT      tyt_cnt_justificativa_cre,
      vo_num_seq_gestor             OUT      tyt_num_seq_gestor,
      vo_num_seq_assinatura_1       OUT      tyt_num_seq_assinatura_1,
      vo_num_seq_assinatura_2       OUT      tyt_num_seq_assinatura_2,
      vo_num_ato_administrativo     OUT      tyt_num_ato_administrativo,
      vo_cnt_cei                    OUT      tyt_cnt_cei,
      vo_cnt_crea                   OUT      tyt_cnt_crea,
      vo_cnt_ice_cod                OUT      tyt_cnt_ice_cod,
      vo_cnt_data                   OUT      tyt_cnt_data,
      vo_cnt_data_proposta          OUT      tyt_cnt_data_proposta,
      vo_cnt_data_inicio            OUT      tyt_cnt_data_inicio,
      vo_cnt_prazo_exec             OUT      tyt_cnt_prazo_exec,
      vo_num_prazo_exec_meses       OUT      tyt_num_prazo_exec_meses,
      vo_cnt_prazo_adit             OUT      tyt_cnt_prazo_adit,
      vo_dat_termino_contrato       OUT      tyt_dat_termino_contrato,
      vo_dat_publicacao             OUT      tyt_dat_publicacao,
      vo_num_dou_publicacao         OUT      tyt_num_dou_publicacao,
      vo_num_pagina_publicacao      OUT      tyt_num_pagina_publicacao,
      vo_num_secao_publicacao       OUT      tyt_num_secao_publicacao,
      vo_cod_modalidade_licitacao   OUT      tyt_cod_modalidade_licitacao,
      vo_num_inciso                 OUT      tyt_num_inciso,
      vo_dsc_fundamento_legal       OUT      tyt_dsc_fundamento_legal,
      vo_num_licitacao              OUT      tyt_num_licitacao,
      vo_num_ano_licitacao          OUT      tyt_num_ano_licitacao,
      vo_num_processo               OUT      tyt_num_processo,
      vo_cnt_valor_compromisso      OUT      tyt_cnt_valor_compromisso,
      vo_cnt_valor_termo            OUT      tyt_cnt_valor_termo,
      vo_cnt_valor_pago             OUT      tyt_cnt_valor_pago,
      vo_cnt_valor_reaj             OUT      tyt_cnt_valor_reaj,
      vo_cnt_valor_reaj_pago        OUT      tyt_cnt_valor_reaj_pago,
      vo_cnt_valor                  OUT      tyt_cnt_valor,
      vo_tip_situacao_contrato      OUT      tyt_tip_situacao_contrato,
      vo_tip_contrato               OUT      tyt_tip_contrato,
      vo_dsc_critica_contrato       OUT      tyt_dsc_critica_contrato,
      vi_num_seq_contrato           IN       t_num_seq_contrato,
      vi_cnt_cre_cod                IN       t_cnt_cre_cod
   );

   PROCEDURE stp_exclui_contrato (
      p_usuario                      VARCHAR2,
      vo_ok                 OUT      tyt_ok,
      vi_num_seq_contrato   IN       t_num_seq_contrato,
      vi_cnt_cre_cod        IN       t_cnt_cre_cod
   );

   PROCEDURE stp_inclui_contrato (
      p_usuario                              VARCHAR2,
      vo_num_seq_contrato           OUT      tyt_num_seq_contrato,
      vo_cnt_cre_cod                OUT      tyt_cnt_cre_cod,
      vo_cnt_cod                    OUT      tyt_cnt_cod,
      vo_num_versao_contrato        OUT      tyt_num_versao_contrato,
      vo_num_termo_aditivo          OUT      tyt_num_termo_aditivo,
      vo_cod_dep_contrato           OUT      tyt_cod_dep_contrato,
      vo_cnt_justificativa_cre      OUT      tyt_cnt_justificativa_cre,
      vo_num_seq_gestor             OUT      tyt_num_seq_gestor,
      vo_num_seq_assinatura_1       OUT      tyt_num_seq_assinatura_1,
      vo_num_seq_assinatura_2       OUT      tyt_num_seq_assinatura_2,
      vo_num_ato_administrativo     OUT      tyt_num_ato_administrativo,
      vo_cnt_cei                    OUT      tyt_cnt_cei,
      vo_cnt_crea                   OUT      tyt_cnt_crea,
      vo_cnt_ice_cod                OUT      tyt_cnt_ice_cod,
      vo_cnt_data                   OUT      tyt_cnt_data,
      vo_cnt_data_proposta          OUT      tyt_cnt_data_proposta,
      vo_cnt_data_inicio            OUT      tyt_cnt_data_inicio,
      vo_cnt_prazo_exec             OUT      tyt_cnt_prazo_exec,
      vo_num_prazo_exec_meses       OUT      tyt_num_prazo_exec_meses,
      vo_cnt_prazo_adit             OUT      tyt_cnt_prazo_adit,
      vo_dat_termino_contrato       OUT      tyt_dat_termino_contrato,
      vo_dat_publicacao             OUT      tyt_dat_publicacao,
      vo_num_dou_publicacao         OUT      tyt_num_dou_publicacao,
      vo_num_pagina_publicacao      OUT      tyt_num_pagina_publicacao,
      vo_num_secao_publicacao       OUT      tyt_num_secao_publicacao,
      vo_cod_modalidade_licitacao   OUT      tyt_cod_modalidade_licitacao,
      vo_num_inciso                 OUT      tyt_num_inciso,
      vo_dsc_fundamento_legal       OUT      tyt_dsc_fundamento_legal,
      vo_num_licitacao              OUT      tyt_num_licitacao,
      vo_num_ano_licitacao          OUT      tyt_num_ano_licitacao,
      vo_num_processo               OUT      tyt_num_processo,
      vo_cnt_valor_compromisso      OUT      tyt_cnt_valor_compromisso,
      vo_cnt_valor_termo            OUT      tyt_cnt_valor_termo,
      vo_cnt_valor_pago             OUT      tyt_cnt_valor_pago,
      vo_cnt_valor_reaj             OUT      tyt_cnt_valor_reaj,
      vo_cnt_valor_reaj_pago        OUT      tyt_cnt_valor_reaj_pago,
      vo_cnt_valor                  OUT      tyt_cnt_valor,
      vo_tip_situacao_contrato      OUT      tyt_tip_situacao_contrato,
      vo_tip_contrato               OUT      tyt_tip_contrato,
      vo_dsc_critica_contrato       OUT      tyt_dsc_critica_contrato,
      vi_cnt_cre_cod                IN       t_cnt_cre_cod,
      vi_cnt_cod                    IN       t_cnt_cod,
      vi_num_versao_contrato        IN       t_num_versao_contrato,
      vi_cod_dep_contrato           IN       t_cod_dep_contrato,
      vi_cnt_justificativa_cre      IN       t_cnt_justificativa_cre,
      vi_num_seq_gestor             IN       t_num_seq_gestor,
      vi_num_seq_assinatura_1       IN       t_num_seq_assinatura_1,
      vi_num_seq_assinatura_2       IN       t_num_seq_assinatura_2,
      vi_num_ato_administrativo     IN       t_num_ato_administrativo,
      vi_cnt_cei                    IN       t_cnt_cei,
      vi_cnt_crea                   IN       t_cnt_crea,
      vi_cnt_ice_cod                IN       t_cnt_ice_cod,
      vi_cnt_data                   IN       t_cnt_data,
      vi_cnt_data_proposta          IN       t_cnt_data_proposta,
      vi_cnt_data_inicio            IN       t_cnt_data_inicio,
      vi_cnt_prazo_exec             IN       t_cnt_prazo_exec,
      vi_num_prazo_exec_meses       IN       t_num_prazo_exec_meses,
      vi_dat_publicacao             IN       t_dat_publicacao,
      vi_num_dou_publicacao         IN       t_num_dou_publicacao,
      vi_num_pagina_publicacao      IN       t_num_pagina_publicacao,
      vi_num_secao_publicacao       IN       t_num_secao_publicacao,
      vi_cod_modalidade_licitacao   IN       t_cod_modalidade_licitacao,
      vi_num_inciso                 IN       t_num_inciso,
      vi_dsc_fundamento_legal       IN       t_dsc_fundamento_legal,
      vi_num_licitacao              IN       t_num_licitacao,
      vi_num_ano_licitacao          IN       t_num_ano_licitacao,
      vi_num_processo               IN       t_num_processo,
      vi_tip_situacao_contrato      IN       t_tip_situacao_contrato
   );

   PROCEDURE stp_altera_contrato (
      p_usuario                              VARCHAR2,
      vo_num_seq_contrato           OUT      tyt_num_seq_contrato,
      vo_cnt_cre_cod                OUT      tyt_cnt_cre_cod,
      vo_cnt_cod                    OUT      tyt_cnt_cod,
      vo_num_versao_contrato        OUT      tyt_num_versao_contrato,
      vo_num_termo_aditivo          OUT      tyt_num_termo_aditivo,
      vo_cod_dep_contrato           OUT      tyt_cod_dep_contrato,
      vo_cnt_justificativa_cre      OUT      tyt_cnt_justificativa_cre,
      vo_num_seq_gestor             OUT      tyt_num_seq_gestor,
      vo_num_seq_assinatura_1       OUT      tyt_num_seq_assinatura_1,
      vo_num_seq_assinatura_2       OUT      tyt_num_seq_assinatura_2,
      vo_num_ato_administrativo     OUT      tyt_num_ato_administrativo,
      vo_cnt_cei                    OUT      tyt_cnt_cei,
      vo_cnt_crea                   OUT      tyt_cnt_crea,
      vo_cnt_ice_cod                OUT      tyt_cnt_ice_cod,
      vo_cnt_data                   OUT      tyt_cnt_data,
      vo_cnt_data_proposta          OUT      tyt_cnt_data_proposta,
      vo_cnt_data_inicio            OUT      tyt_cnt_data_inicio,
      vo_cnt_prazo_exec             OUT      tyt_cnt_prazo_exec,
      vo_num_prazo_exec_meses       OUT      tyt_num_prazo_exec_meses,
      vo_cnt_prazo_adit             OUT      tyt_cnt_prazo_adit,
      vo_dat_termino_contrato       OUT      tyt_dat_termino_contrato,
      vo_dat_publicacao             OUT      tyt_dat_publicacao,
      vo_num_dou_publicacao         OUT      tyt_num_dou_publicacao,
      vo_num_pagina_publicacao      OUT      tyt_num_pagina_publicacao,
      vo_num_secao_publicacao       OUT      tyt_num_secao_publicacao,
      vo_cod_modalidade_licitacao   OUT      tyt_cod_modalidade_licitacao,
      vo_num_inciso                 OUT      tyt_num_inciso,
      vo_dsc_fundamento_legal       OUT      tyt_dsc_fundamento_legal,
      vo_num_licitacao              OUT      tyt_num_licitacao,
      vo_num_ano_licitacao          OUT      tyt_num_ano_licitacao,
      vo_num_processo               OUT      tyt_num_processo,
      vo_cnt_valor_compromisso      OUT      tyt_cnt_valor_compromisso,
      vo_cnt_valor_termo            OUT      tyt_cnt_valor_termo,
      vo_cnt_valor_pago             OUT      tyt_cnt_valor_pago,
      vo_cnt_valor_reaj             OUT      tyt_cnt_valor_reaj,
      vo_cnt_valor_reaj_pago        OUT      tyt_cnt_valor_reaj_pago,
      vo_cnt_valor                  OUT      tyt_cnt_valor,
      vo_tip_situacao_contrato      OUT      tyt_tip_situacao_contrato,
      vo_tip_contrato               OUT      tyt_tip_contrato,
      vo_dsc_critica_contrato       OUT      tyt_dsc_critica_contrato,
      vi_num_seq_contrato           IN       t_num_seq_contrato,
      vi_cnt_cre_cod                IN       t_cnt_cre_cod,
      vi_cnt_cod                    IN       t_cnt_cod,
      vi_num_versao_contrato        IN       t_num_versao_contrato,
      vi_cod_dep_contrato           IN       t_cod_dep_contrato,
      vi_cnt_justificativa_cre      IN       t_cnt_justificativa_cre,
      vi_num_seq_gestor             IN       t_num_seq_gestor,
      vi_num_seq_assinatura_1       IN       t_num_seq_assinatura_1,
      vi_num_seq_assinatura_2       IN       t_num_seq_assinatura_2,
      vi_num_ato_administrativo     IN       t_num_ato_administrativo,
      vi_cnt_cei                    IN       t_cnt_cei,
      vi_cnt_crea                   IN       t_cnt_crea,
      vi_cnt_ice_cod                IN       t_cnt_ice_cod,
      vi_cnt_data                   IN       t_cnt_data,
      vi_cnt_data_proposta          IN       t_cnt_data_proposta,
      vi_cnt_data_inicio            IN       t_cnt_data_inicio,
      vi_cnt_prazo_exec             IN       t_cnt_prazo_exec,
      vi_num_prazo_exec_meses       IN       t_num_prazo_exec_meses,
      vi_dat_publicacao             IN       t_dat_publicacao,
      vi_num_dou_publicacao         IN       t_num_dou_publicacao,
      vi_num_pagina_publicacao      IN       t_num_pagina_publicacao,
      vi_num_secao_publicacao       IN       t_num_secao_publicacao,
      vi_cod_modalidade_licitacao   IN       t_cod_modalidade_licitacao,
      vi_num_inciso                 IN       t_num_inciso,
      vi_dsc_fundamento_legal       IN       t_dsc_fundamento_legal,
      vi_num_licitacao              IN       t_num_licitacao,
      vi_num_ano_licitacao          IN       t_num_ano_licitacao,
      vi_num_processo               IN       t_num_processo,
      vi_tip_situacao_contrato      IN       t_tip_situacao_contrato
   );

   --- VIW_VALORES_CONTRATO
   SUBTYPE t_num_seq_contrato_res_rv IS ifrbde_views.viw_valores_contrato.num_seq_contrato_res_rv%TYPE;

   SUBTYPE t_num_seq_resumo_rv IS ifrbde_views.viw_valores_contrato.num_seq_resumo_rv%TYPE;

   SUBTYPE t_cnt_cre_cod_res IS ifrbde_views.viw_valores_contrato.cnt_cre_cod_res%TYPE;

   SUBTYPE t_cnt_cod_res IS ifrbde_views.viw_valores_contrato.cnt_cod_res%TYPE;

   SUBTYPE t_num_versao_contrato_res_rv IS VARCHAR2 (8);

   SUBTYPE t_val_resumo_rv IS ifrbde_views.viw_valores_contrato.val_resumo_rv%TYPE;

   SUBTYPE t_val_termo_rv IS ifrbde_views.viw_valores_contrato.val_termo_rv%TYPE;

   SUBTYPE t_val_pagamento_rv IS ifrbde_views.viw_valores_contrato.val_pagamento_rv%TYPE;

   SUBTYPE t_val_reajuste_rv IS ifrbde_views.viw_valores_contrato.val_reajuste_rv%TYPE;

   SUBTYPE t_val_pago_rv IS ifrbde_views.viw_valores_contrato.val_pago_rv%TYPE;

   SUBTYPE t_val_pago_reajuste_rv IS ifrbde_views.viw_valores_contrato.val_pago_reajuste_rv%TYPE;

   SUBTYPE t_val_saldo_resumo_rv IS ifrbde_views.viw_valores_contrato.val_saldo_resumo_rv%TYPE;

   SUBTYPE t_flg_moeda_controle_rv IS ifrbde_views.viw_valores_contrato.flg_moeda_controle_rv%TYPE;

   SUBTYPE t_tip_moeda_rv IS ifrbde_views.viw_valores_contrato.tip_moeda_rv%TYPE;

   SUBTYPE t_dat_moeda_rv IS t_data;

   SUBTYPE t_val_cotacao_moeda_rv IS ifrbde_views.viw_valores_contrato.val_cotacao_moeda_rv%TYPE;

   SUBTYPE t_tip_cotacao_moeda_rv IS ifrbde_views.viw_valores_contrato.tip_cotacao_moeda_rv%TYPE;

   SUBTYPE t_val_resumo_sec_rv IS ifrbde_views.viw_valores_contrato.val_resumo_sec_rv%TYPE;

   SUBTYPE t_val_termo_sec_rv IS ifrbde_views.viw_valores_contrato.val_termo_sec_rv%TYPE;

   SUBTYPE t_val_pagamento_sec_rv IS ifrbde_views.viw_valores_contrato.val_pagamento_sec_rv%TYPE;

   SUBTYPE t_val_reajuste_sec_rv IS ifrbde_views.viw_valores_contrato.val_reajuste_sec_rv%TYPE;

   SUBTYPE t_val_pago_sec_rv IS ifrbde_views.viw_valores_contrato.val_pago_sec_rv%TYPE;

   SUBTYPE t_val_pago_reajuste_sec_rv IS ifrbde_views.viw_valores_contrato.val_pago_reajuste_sec_rv%TYPE;

   SUBTYPE t_val_saldo_resumo_sec_rv IS ifrbde_views.viw_valores_contrato.val_saldo_resumo_sec_rv%TYPE;

   TYPE tyt_num_seq_contrato_res_rv IS TABLE OF t_num_seq_contrato_res_rv
      INDEX BY BINARY_INTEGER;

   TYPE tyt_num_seq_resumo_rv IS TABLE OF t_num_seq_resumo_rv
      INDEX BY BINARY_INTEGER;

   TYPE tyt_cnt_cre_cod_res IS TABLE OF t_cnt_cre_cod_res
      INDEX BY BINARY_INTEGER;

   TYPE tyt_cnt_cod_res IS TABLE OF t_cnt_cod_res
      INDEX BY BINARY_INTEGER;

   TYPE tyt_num_versao_contrato_res_rv IS TABLE OF t_num_versao_contrato_res_rv
      INDEX BY BINARY_INTEGER;

   TYPE tyt_val_resumo_rv IS TABLE OF t_val_resumo_rv
      INDEX BY BINARY_INTEGER;

   TYPE tyt_val_termo_rv IS TABLE OF t_val_termo_rv
      INDEX BY BINARY_INTEGER;

   TYPE tyt_val_pagamento_rv IS TABLE OF t_val_pagamento_rv
      INDEX BY BINARY_INTEGER;

   TYPE tyt_val_reajuste_rv IS TABLE OF t_val_reajuste_rv
      INDEX BY BINARY_INTEGER;

   TYPE tyt_val_pago_rv IS TABLE OF t_val_pago_rv
      INDEX BY BINARY_INTEGER;

   TYPE tyt_val_pago_reajuste_rv IS TABLE OF t_val_pago_reajuste_rv
      INDEX BY BINARY_INTEGER;

   TYPE tyt_val_saldo_resumo_rv IS TABLE OF t_val_saldo_resumo_rv
      INDEX BY BINARY_INTEGER;

   TYPE tyt_flg_moeda_controle_rv IS TABLE OF t_flg_moeda_controle_rv
      INDEX BY BINARY_INTEGER;

   TYPE tyt_tip_moeda_rv IS TABLE OF t_tip_moeda_rv
      INDEX BY BINARY_INTEGER;

   TYPE tyt_dat_moeda_rv IS TABLE OF t_dat_moeda_rv
      INDEX BY BINARY_INTEGER;

   TYPE tyt_val_cotacao_moeda_rv IS TABLE OF t_val_cotacao_moeda_rv
      INDEX BY BINARY_INTEGER;

   TYPE tyt_tip_cotacao_moeda_rv IS TABLE OF t_tip_cotacao_moeda_rv
      INDEX BY BINARY_INTEGER;

   TYPE tyt_val_resumo_sec_rv IS TABLE OF t_val_resumo_sec_rv
      INDEX BY BINARY_INTEGER;

   TYPE tyt_val_termo_sec_rv IS TABLE OF t_val_termo_sec_rv
      INDEX BY BINARY_INTEGER;

   TYPE tyt_val_pagamento_sec_rv IS TABLE OF t_val_pagamento_sec_rv
      INDEX BY BINARY_INTEGER;

   TYPE tyt_val_reajuste_sec_rv IS TABLE OF t_val_reajuste_sec_rv
      INDEX BY BINARY_INTEGER;

   TYPE tyt_val_pago_sec_rv IS TABLE OF t_val_pago_sec_rv
      INDEX BY BINARY_INTEGER;

   TYPE tyt_val_pago_reajuste_sec_rv IS TABLE OF t_val_pago_reajuste_sec_rv
      INDEX BY BINARY_INTEGER;

   TYPE tyt_val_saldo_resumo_sec_rv IS TABLE OF t_val_saldo_resumo_sec_rv
      INDEX BY BINARY_INTEGER;

   PROCEDURE stp_pesquisa_valores_contrato (
      p_usuario                                VARCHAR2,
      vo_num_seq_contrato_res_rv      OUT      tyt_num_seq_contrato_res_rv,
      vo_num_seq_resumo_rv            OUT      tyt_num_seq_resumo_rv,
      vo_cnt_cre_cod_res              OUT      tyt_cnt_cre_cod_res,
      vo_cnt_cod_res                  OUT      tyt_cnt_cod_res,
      vo_num_versao_contrato_res_rv   OUT      tyt_num_versao_contrato_res_rv,
      vo_val_resumo_rv                OUT      tyt_val_resumo_rv,
      vo_val_termo_rv                 OUT      tyt_val_termo_rv,
      vo_val_pagamento_rv             OUT      tyt_val_pagamento_rv,
      vo_val_reajuste_rv              OUT      tyt_val_reajuste_rv,
      vo_val_pago_rv                  OUT      tyt_val_pago_rv,
      vo_val_pago_reajuste_rv         OUT      tyt_val_pago_reajuste_rv,
      vo_val_saldo_resumo_rv          OUT      tyt_val_saldo_resumo_rv,
      vo_flg_moeda_controle_rv        OUT      tyt_flg_moeda_controle_rv,
      vo_tip_moeda_rv                 OUT      tyt_tip_moeda_rv,
      vo_dat_moeda_rv                 OUT      tyt_dat_moeda_rv,
      vo_val_cotacao_moeda_rv         OUT      tyt_val_cotacao_moeda_rv,
      vo_tip_cotacao_moeda_rv         OUT      tyt_tip_cotacao_moeda_rv,
      vo_val_resumo_sec_rv            OUT      tyt_val_resumo_sec_rv,
      vo_val_termo_sec_rv             OUT      tyt_val_termo_sec_rv,
      vo_val_pagamento_sec_rv         OUT      tyt_val_pagamento_sec_rv,
      vo_val_reajuste_sec_rv          OUT      tyt_val_reajuste_sec_rv,
      vo_val_pago_sec_rv              OUT      tyt_val_pago_sec_rv,
      vo_val_pago_reajuste_sec_rv     OUT      tyt_val_pago_reajuste_sec_rv,
      vo_val_saldo_resumo_sec_rv      OUT      tyt_val_saldo_resumo_sec_rv,
      vi_num_seq_contrato_res_rv      IN       t_num_seq_contrato_res_rv,
      vi_num_seq_resumo_rv            IN       t_num_seq_resumo_rv
   );

   PROCEDURE stp_exclui_valores_contrato (
      p_usuario                             VARCHAR2,
      vo_ok                        OUT      tyt_ok,
      vi_num_seq_contrato_res_rv   IN       t_num_seq_contrato_res_rv,
      vi_num_seq_resumo_rv         IN       t_num_seq_resumo_rv
   );

   PROCEDURE stp_inclui_valores_contrato (
      p_usuario                                VARCHAR2,
      vo_num_seq_contrato_res_rv      OUT      tyt_num_seq_contrato_res_rv,
      vo_num_seq_resumo_rv            OUT      tyt_num_seq_resumo_rv,
      vo_cnt_cre_cod_res              OUT      tyt_cnt_cre_cod_res,
      vo_cnt_cod_res                  OUT      tyt_cnt_cod_res,
      vo_num_versao_contrato_res_rv   OUT      tyt_num_versao_contrato_res_rv,
      vo_val_resumo_rv                OUT      tyt_val_resumo_rv,
      vo_val_termo_rv                 OUT      tyt_val_termo_rv,
      vo_val_pagamento_rv             OUT      tyt_val_pagamento_rv,
      vo_val_reajuste_rv              OUT      tyt_val_reajuste_rv,
      vo_val_pago_rv                  OUT      tyt_val_pago_rv,
      vo_val_pago_reajuste_rv         OUT      tyt_val_pago_reajuste_rv,
      vo_val_saldo_resumo_rv          OUT      tyt_val_saldo_resumo_rv,
      vo_flg_moeda_controle_rv        OUT      tyt_flg_moeda_controle_rv,
      vo_tip_moeda_rv                 OUT      tyt_tip_moeda_rv,
      vo_dat_moeda_rv                 OUT      tyt_dat_moeda_rv,
      vo_val_cotacao_moeda_rv         OUT      tyt_val_cotacao_moeda_rv,
      vo_tip_cotacao_moeda_rv         OUT      tyt_tip_cotacao_moeda_rv,
      vo_val_resumo_sec_rv            OUT      tyt_val_resumo_sec_rv,
      vo_val_termo_sec_rv             OUT      tyt_val_termo_sec_rv,
      vo_val_pagamento_sec_rv         OUT      tyt_val_pagamento_sec_rv,
      vo_val_reajuste_sec_rv          OUT      tyt_val_reajuste_sec_rv,
      vo_val_pago_sec_rv              OUT      tyt_val_pago_sec_rv,
      vo_val_pago_reajuste_sec_rv     OUT      tyt_val_pago_reajuste_sec_rv,
      vo_val_saldo_resumo_sec_rv      OUT      tyt_val_saldo_resumo_sec_rv,
      vi_num_seq_contrato_res_rv      IN       t_num_seq_contrato_res_rv,
      vi_cnt_cre_cod_res              IN       t_cnt_cre_cod_res,
      vi_cnt_cod_res                  IN       t_cnt_cod_res,
      vi_val_resumo_rv                IN       t_val_resumo_rv,
      vi_val_termo_rv                 IN       t_val_termo_rv,
      vi_val_pagamento_rv             IN       t_val_pagamento_rv,
      vi_val_reajuste_rv              IN       t_val_reajuste_rv,
      vi_val_pago_rv                  IN       t_val_pago_rv,
      vi_val_pago_reajuste_rv         IN       t_val_pago_reajuste_rv,
      vi_val_saldo_resumo_rv          IN       t_val_saldo_resumo_rv,
      vi_flg_moeda_controle_rv        IN       t_flg_moeda_controle_rv,
      vi_tip_moeda_rv                 IN       t_tip_moeda_rv,
      vi_dat_moeda_rv                 IN       t_dat_moeda_rv,
      vi_val_cotacao_moeda_rv         IN       t_val_cotacao_moeda_rv,
      vi_tip_cotacao_moeda_rv         IN       t_tip_cotacao_moeda_rv,
      vi_val_resumo_sec_rv            IN       t_val_resumo_sec_rv,
      vi_val_termo_sec_rv             IN       t_val_termo_sec_rv,
      vi_val_pagamento_sec_rv         IN       t_val_pagamento_sec_rv,
      vi_val_reajuste_sec_rv          IN       t_val_reajuste_sec_rv,
      vi_val_pago_sec_rv              IN       t_val_pago_sec_rv,
      vi_val_pago_reajuste_sec_rv     IN       t_val_pago_reajuste_sec_rv,
      vi_val_saldo_resumo_sec_rv      IN       t_val_saldo_resumo_sec_rv
   );

   PROCEDURE stp_altera_valores_contrato (
      p_usuario                                VARCHAR2,
      vo_num_seq_contrato_res_rv      OUT      tyt_num_seq_contrato_res_rv,
      vo_num_seq_resumo_rv            OUT      tyt_num_seq_resumo_rv,
      vo_cnt_cre_cod_res              OUT      tyt_cnt_cre_cod_res,
      vo_cnt_cod_res                  OUT      tyt_cnt_cod_res,
      vo_num_versao_contrato_res_rv   OUT      tyt_num_versao_contrato_res_rv,
      vo_val_resumo_rv                OUT      tyt_val_resumo_rv,
      vo_val_termo_rv                 OUT      tyt_val_termo_rv,
      vo_val_pagamento_rv             OUT      tyt_val_pagamento_rv,
      vo_val_reajuste_rv              OUT      tyt_val_reajuste_rv,
      vo_val_pago_rv                  OUT      tyt_val_pago_rv,
      vo_val_pago_reajuste_rv         OUT      tyt_val_pago_reajuste_rv,
      vo_val_saldo_resumo_rv          OUT      tyt_val_saldo_resumo_rv,
      vo_flg_moeda_controle_rv        OUT      tyt_flg_moeda_controle_rv,
      vo_tip_moeda_rv                 OUT      tyt_tip_moeda_rv,
      vo_dat_moeda_rv                 OUT      tyt_dat_moeda_rv,
      vo_val_cotacao_moeda_rv         OUT      tyt_val_cotacao_moeda_rv,
      vo_tip_cotacao_moeda_rv         OUT      tyt_tip_cotacao_moeda_rv,
      vo_val_resumo_sec_rv            OUT      tyt_val_resumo_sec_rv,
      vo_val_termo_sec_rv             OUT      tyt_val_termo_sec_rv,
      vo_val_pagamento_sec_rv         OUT      tyt_val_pagamento_sec_rv,
      vo_val_reajuste_sec_rv          OUT      tyt_val_reajuste_sec_rv,
      vo_val_pago_sec_rv              OUT      tyt_val_pago_sec_rv,
      vo_val_pago_reajuste_sec_rv     OUT      tyt_val_pago_reajuste_sec_rv,
      vo_val_saldo_resumo_sec_rv      OUT      tyt_val_saldo_resumo_sec_rv,
      vi_num_seq_contrato_res_rv      IN       t_num_seq_contrato_res_rv,
      vi_num_seq_resumo_rv            IN       t_num_seq_resumo_rv,
      vi_cnt_cre_cod_res              IN       t_cnt_cre_cod_res,
      vi_cnt_cod_res                  IN       t_cnt_cod_res,
      vi_val_resumo_rv                IN       t_val_resumo_rv,
      vi_val_termo_rv                 IN       t_val_termo_rv,
      vi_val_pagamento_rv             IN       t_val_pagamento_rv,
      vi_val_reajuste_rv              IN       t_val_reajuste_rv,
      vi_val_pago_rv                  IN       t_val_pago_rv,
      vi_val_pago_reajuste_rv         IN       t_val_pago_reajuste_rv,
      vi_val_saldo_resumo_rv          IN       t_val_saldo_resumo_rv,
      vi_flg_moeda_controle_rv        IN       t_flg_moeda_controle_rv,
      vi_tip_moeda_rv                 IN       t_tip_moeda_rv,
      vi_dat_moeda_rv                 IN       t_dat_moeda_rv,
      vi_val_cotacao_moeda_rv         IN       t_val_cotacao_moeda_rv,
      vi_tip_cotacao_moeda_rv         IN       t_tip_cotacao_moeda_rv,
      vi_val_resumo_sec_rv            IN       t_val_resumo_sec_rv,
      vi_val_termo_sec_rv             IN       t_val_termo_sec_rv,
      vi_val_pagamento_sec_rv         IN       t_val_pagamento_sec_rv,
      vi_val_reajuste_sec_rv          IN       t_val_reajuste_sec_rv,
      vi_val_pago_sec_rv              IN       t_val_pago_sec_rv,
      vi_val_pago_reajuste_sec_rv     IN       t_val_pago_reajuste_sec_rv,
      vi_val_saldo_resumo_sec_rv      IN       t_val_saldo_resumo_sec_rv
   );

   --- TAB_CONT_TERMO_ADITIVO
   SUBTYPE t_num_seq_termo IS ifrbde_views.tab_cont_termo_aditivo.num_seq_termo%TYPE;

   SUBTYPE t_num_seq_resumo_ta IS ifrbde_views.tab_cont_termo_aditivo.num_seq_resumo_ta%TYPE;

   SUBTYPE t_cta_periodo IS t_data;

   SUBTYPE t_cta_num IS ifrbde_views.tab_cont_termo_aditivo.cta_num%TYPE;

   SUBTYPE t_num_versao_contrato_vta IS VARCHAR2 (2);

   SUBTYPE t_cta_objeto IS ifrbde_views.tab_cont_termo_aditivo.cta_objeto%TYPE;

   SUBTYPE t_cta_valor IS ifrbde_views.tab_cont_termo_aditivo.cta_valor%TYPE;

   SUBTYPE t_cta_deb_cred IS ifrbde_views.tab_cont_termo_aditivo.cta_deb_cred%TYPE;

   SUBTYPE t_dat_moeda_ta IS t_data;

   SUBTYPE t_val_moeda_ta IS ifrbde_views.tab_cont_termo_aditivo.val_moeda_ta%TYPE;

   
--   SUBTYPE t_tip_cotacao_moeda IS ifrbde_views.tab_cont_termo_aditivo.tip_cotacao_moeda%TYPE;

   TYPE tyt_num_seq_termo IS TABLE OF t_num_seq_termo
      INDEX BY BINARY_INTEGER;

   TYPE tyt_num_seq_resumo_ta IS TABLE OF t_num_seq_resumo_ta
      INDEX BY BINARY_INTEGER;

   TYPE tyt_cta_periodo IS TABLE OF t_cta_periodo
      INDEX BY BINARY_INTEGER;

   TYPE tyt_cta_num IS TABLE OF t_cta_num
      INDEX BY BINARY_INTEGER;

   TYPE tyt_num_versao_contrato_vta IS TABLE OF t_num_versao_contrato_vta
      INDEX BY BINARY_INTEGER;

   TYPE tyt_cta_objeto IS TABLE OF t_cta_objeto
      INDEX BY BINARY_INTEGER;

   TYPE tyt_cta_valor IS TABLE OF t_cta_valor
      INDEX BY BINARY_INTEGER;

   TYPE tyt_cta_deb_cred IS TABLE OF t_cta_deb_cred
      INDEX BY BINARY_INTEGER;

   TYPE tyt_dat_moeda_ta IS TABLE OF t_dat_moeda_ta
      INDEX BY BINARY_INTEGER;

   TYPE tyt_val_moeda_ta IS TABLE OF t_val_moeda_ta
      INDEX BY BINARY_INTEGER;

   
--   TYPE tyt_tip_cotacao_moeda IS TABLE OF t_tip_cotacao_moeda
--      INDEX BY BINARY_INTEGER;

   PROCEDURE stp_pesquisa_cont_termo_aditiv (
      p_usuario                             VARCHAR2,
      vo_num_seq_termo             OUT      tyt_num_seq_termo,
      vo_num_seq_resumo_ta         OUT      tyt_num_seq_resumo_ta,
      vo_cta_periodo               OUT      tyt_cta_periodo,
      vo_cta_num                   OUT      tyt_cta_num,
      vo_num_versao_contrato_vta   OUT      tyt_num_versao_contrato_vta,
      vo_cta_objeto                OUT      tyt_cta_objeto,
      vo_cta_valor                 OUT      tyt_cta_valor,
      vo_cta_deb_cred              OUT      tyt_cta_deb_cred,
      vo_dat_moeda_ta              OUT      tyt_dat_moeda_ta,
      vo_val_moeda_ta              OUT      tyt_val_moeda_ta,
      vo_tip_cotacao_moeda         OUT      tyt_tip_cotacao_moeda,
      vi_num_seq_termo             IN       t_num_seq_termo,
      vi_num_seq_resumo_ta         IN       t_num_seq_resumo_ta
   );

   PROCEDURE stp_exclui_cont_termo_aditivo (
      p_usuario                       VARCHAR2,
      vo_ok                  OUT      tyt_ok,
      vi_num_seq_termo       IN       t_num_seq_termo,
      vi_num_seq_resumo_ta   IN       t_num_seq_resumo_ta
   );

   PROCEDURE stp_inclui_cont_termo_aditivo (
      p_usuario                             VARCHAR2,
      vo_num_seq_termo             OUT      tyt_num_seq_termo,
      vo_num_seq_resumo_ta         OUT      tyt_num_seq_resumo_ta,
      vo_cta_periodo               OUT      tyt_cta_periodo,
      vo_cta_num                   OUT      tyt_cta_num,
      vo_num_versao_contrato_vta   OUT      tyt_num_versao_contrato_vta,
      vo_cta_objeto                OUT      tyt_cta_objeto,
      vo_cta_valor                 OUT      tyt_cta_valor,
      vo_cta_deb_cred              OUT      tyt_cta_deb_cred,
      vo_dat_moeda_ta              OUT      tyt_dat_moeda_ta,
      vo_val_moeda_ta              OUT      tyt_val_moeda_ta,
      vo_tip_cotacao_moeda         OUT      tyt_tip_cotacao_moeda,
      vi_num_seq_resumo_ta         IN       t_num_seq_resumo_ta,
      vi_cta_periodo               IN       t_cta_periodo,
      vi_cta_num                   IN       t_cta_num,
      vi_cta_objeto                IN       t_cta_objeto,
      vi_cta_valor                 IN       t_cta_valor,
      vi_cta_deb_cred              IN       t_cta_deb_cred,
      vi_dat_moeda_ta              IN       t_dat_moeda_ta,
      vi_val_moeda_ta              IN       t_val_moeda_ta,
      vi_tip_cotacao_moeda         IN       t_tip_cotacao_moeda
   );

   PROCEDURE stp_altera_cont_termo_aditivo (
      p_usuario                             VARCHAR2,
      vo_num_seq_termo             OUT      tyt_num_seq_termo,
      vo_num_seq_resumo_ta         OUT      tyt_num_seq_resumo_ta,
      vo_cta_periodo               OUT      tyt_cta_periodo,
      vo_cta_num                   OUT      tyt_cta_num,
      vo_num_versao_contrato_vta   OUT      tyt_num_versao_contrato_vta,
      vo_cta_objeto                OUT      tyt_cta_objeto,
      vo_cta_valor                 OUT      tyt_cta_valor,
      vo_cta_deb_cred              OUT      tyt_cta_deb_cred,
      vo_dat_moeda_ta              OUT      tyt_dat_moeda_ta,
      vo_val_moeda_ta              OUT      tyt_val_moeda_ta,
      vo_tip_cotacao_moeda         OUT      tyt_tip_cotacao_moeda,
      vi_num_seq_termo             IN       t_num_seq_termo,
      vi_num_seq_resumo_ta         IN       t_num_seq_resumo_ta,
      vi_cta_periodo               IN       t_cta_periodo,
      vi_cta_num                   IN       t_cta_num,
      vi_cta_objeto                IN       t_cta_objeto,
      vi_cta_valor                 IN       t_cta_valor,
      vi_cta_deb_cred              IN       t_cta_deb_cred,
      vi_dat_moeda_ta              IN       t_dat_moeda_ta,
      vi_val_moeda_ta              IN       t_val_moeda_ta,
      vi_tip_cotacao_moeda         IN       t_tip_cotacao_moeda
   );

   --- CAD_TERMO_ADITIVO_CONTRATO
   SUBTYPE t_num_seq_termo_aditivo IS ifrbde_views.cad_termo_aditivo_contrato.num_seq_termo_aditivo%TYPE;

   SUBTYPE t_num_seq_contrato_origem IS ifrbde_views.cad_termo_aditivo_contrato.num_seq_contrato_origem%TYPE;

   SUBTYPE t_dat_termo_aditivo IS t_data;

   
--   SUBTYPE t_num_termo_aditivo IS ifrbde_views.cad_termo_aditivo_contrato.num_termo_aditivo%TYPE;

   SUBTYPE t_dsc_objeto_termo IS ifrbde_views.cad_termo_aditivo_contrato.dsc_objeto_termo%TYPE;

   
--   SUBTYPE t_dat_publicacao IS t_data;

--   SUBTYPE t_num_dou_publicacao IS ifrbde_views.cad_termo_aditivo_contrato.num_dou_publicacao%TYPE;

--   SUBTYPE t_num_secao_publicacao IS ifrbde_views.cad_termo_aditivo_contrato.num_secao_publicacao%TYPE;

--   SUBTYPE t_num_pagina_publicacao IS ifrbde_views.cad_termo_aditivo_contrato.num_pagina_publicacao%TYPE;

   SUBTYPE t_tip_termo_aditivo IS ifrbde_views.cad_termo_aditivo_contrato.tip_termo_aditivo%TYPE;

   SUBTYPE t_num_prazo IS ifrbde_views.cad_termo_aditivo_contrato.num_prazo%TYPE;

   SUBTYPE t_flg_aum_dim IS ifrbde_views.cad_termo_aditivo_contrato.flg_aum_dim%TYPE;

   TYPE tyt_num_seq_termo_aditivo IS TABLE OF t_num_seq_termo_aditivo
      INDEX BY BINARY_INTEGER;

   TYPE tyt_num_seq_contrato_origem IS TABLE OF t_num_seq_contrato_origem
      INDEX BY BINARY_INTEGER;

   TYPE tyt_dat_termo_aditivo IS TABLE OF t_dat_termo_aditivo
      INDEX BY BINARY_INTEGER;

   
--   TYPE tyt_num_termo_aditivo IS TABLE OF t_num_termo_aditivo
--      INDEX BY BINARY_INTEGER;

   TYPE tyt_dsc_objeto_termo IS TABLE OF t_dsc_objeto_termo
      INDEX BY BINARY_INTEGER;

   
--   TYPE tyt_dat_publicacao IS TABLE OF t_dat_publicacao
--      INDEX BY BINARY_INTEGER;

--   TYPE tyt_num_dou_publicacao IS TABLE OF t_num_dou_publicacao
--      INDEX BY BINARY_INTEGER;

--   TYPE tyt_num_secao_publicacao IS TABLE OF t_num_secao_publicacao
--      INDEX BY BINARY_INTEGER;

--   TYPE tyt_num_pagina_publicacao IS TABLE OF t_num_pagina_publicacao
--      INDEX BY BINARY_INTEGER;

   TYPE tyt_tip_termo_aditivo IS TABLE OF t_tip_termo_aditivo
      INDEX BY BINARY_INTEGER;

   TYPE tyt_num_prazo IS TABLE OF t_num_prazo
      INDEX BY BINARY_INTEGER;

   TYPE tyt_flg_aum_dim IS TABLE OF t_flg_aum_dim
      INDEX BY BINARY_INTEGER;

   PROCEDURE stp_pesquisa_termo_aditivo_con (
      p_usuario                             VARCHAR2,
      vo_num_seq_termo_aditivo     OUT      tyt_num_seq_termo_aditivo,
      vo_num_seq_contrato_origem   OUT      tyt_num_seq_contrato_origem,
      vo_dat_termo_aditivo         OUT      tyt_dat_termo_aditivo,
      vo_num_termo_aditivo         OUT      tyt_num_termo_aditivo,
      vo_dsc_objeto_termo          OUT      tyt_dsc_objeto_termo,
      vo_dat_publicacao            OUT      tyt_dat_publicacao,
      vo_num_dou_publicacao        OUT      tyt_num_dou_publicacao,
      vo_num_secao_publicacao      OUT      tyt_num_secao_publicacao,
      vo_num_pagina_publicacao     OUT      tyt_num_pagina_publicacao,
      vo_tip_termo_aditivo         OUT      tyt_tip_termo_aditivo,
      vo_num_prazo                 OUT      tyt_num_prazo,
      vo_flg_aum_dim               OUT      tyt_flg_aum_dim,
      vi_num_seq_termo_aditivo     IN       t_num_seq_termo_aditivo,
      vi_num_seq_contrato_origem   IN       t_num_seq_contrato_origem
   );

   PROCEDURE stp_exclui_termo_aditivo_contr (
      p_usuario                             VARCHAR2,
      vo_ok                        OUT      tyt_ok,
      vi_num_seq_termo_aditivo     IN       t_num_seq_termo_aditivo,
      vi_num_seq_contrato_origem   IN       t_num_seq_contrato_origem
   );

   PROCEDURE stp_inclui_termo_aditivo_contr (
      p_usuario                             VARCHAR2,
      vo_num_seq_termo_aditivo     OUT      tyt_num_seq_termo_aditivo,
      vo_num_seq_contrato_origem   OUT      tyt_num_seq_contrato_origem,
      vo_dat_termo_aditivo         OUT      tyt_dat_termo_aditivo,
      vo_num_termo_aditivo         OUT      tyt_num_termo_aditivo,
      vo_dsc_objeto_termo          OUT      tyt_dsc_objeto_termo,
      vo_dat_publicacao            OUT      tyt_dat_publicacao,
      vo_num_dou_publicacao        OUT      tyt_num_dou_publicacao,
      vo_num_secao_publicacao      OUT      tyt_num_secao_publicacao,
      vo_num_pagina_publicacao     OUT      tyt_num_pagina_publicacao,
      vo_tip_termo_aditivo         OUT      tyt_tip_termo_aditivo,
      vo_num_prazo                 OUT      tyt_num_prazo,
      vo_flg_aum_dim               OUT      tyt_flg_aum_dim,
      vi_num_seq_contrato_origem   IN       t_num_seq_contrato_origem,
      vi_dat_termo_aditivo         IN       t_dat_termo_aditivo,
      vi_num_termo_aditivo         IN       t_num_termo_aditivo,
      vi_dsc_objeto_termo          IN       t_dsc_objeto_termo,
      vi_dat_publicacao            IN       t_dat_publicacao,
      vi_num_dou_publicacao        IN       t_num_dou_publicacao,
      vi_num_secao_publicacao      IN       t_num_secao_publicacao,
      vi_num_pagina_publicacao     IN       t_num_pagina_publicacao,
      vi_tip_termo_aditivo         IN       t_tip_termo_aditivo,
      vi_num_prazo                 IN       t_num_prazo,
      vi_flg_aum_dim               IN       t_flg_aum_dim
   );

   PROCEDURE stp_altera_termo_aditivo_contr (
      p_usuario                             VARCHAR2,
      vo_num_seq_termo_aditivo     OUT      tyt_num_seq_termo_aditivo,
      vo_num_seq_contrato_origem   OUT      tyt_num_seq_contrato_origem,
      vo_dat_termo_aditivo         OUT      tyt_dat_termo_aditivo,
      vo_num_termo_aditivo         OUT      tyt_num_termo_aditivo,
      vo_dsc_objeto_termo          OUT      tyt_dsc_objeto_termo,
      vo_dat_publicacao            OUT      tyt_dat_publicacao,
      vo_num_dou_publicacao        OUT      tyt_num_dou_publicacao,
      vo_num_secao_publicacao      OUT      tyt_num_secao_publicacao,
      vo_num_pagina_publicacao     OUT      tyt_num_pagina_publicacao,
      vo_tip_termo_aditivo         OUT      tyt_tip_termo_aditivo,
      vo_num_prazo                 OUT      tyt_num_prazo,
      vo_flg_aum_dim               OUT      tyt_flg_aum_dim,
      vi_num_seq_termo_aditivo     IN       t_num_seq_termo_aditivo,
      vi_num_seq_contrato_origem   IN       t_num_seq_contrato_origem,
      vi_dat_termo_aditivo         IN       t_dat_termo_aditivo,
      vi_num_termo_aditivo         IN       t_num_termo_aditivo,
      vi_dsc_objeto_termo          IN       t_dsc_objeto_termo,
      vi_dat_publicacao            IN       t_dat_publicacao,
      vi_num_dou_publicacao        IN       t_num_dou_publicacao,
      vi_num_secao_publicacao      IN       t_num_secao_publicacao,
      vi_num_pagina_publicacao     IN       t_num_pagina_publicacao,
      vi_tip_termo_aditivo         IN       t_tip_termo_aditivo,
      vi_num_prazo                 IN       t_num_prazo,
      vi_flg_aum_dim               IN       t_flg_aum_dim
   );

   
--------------------------------------------------------------------------------
   --- CAD_PARTIC_CONTR_CONTA
--   SUBTYPE t_num_seq_contrato_part IS ifrbde_views.cad_partic_contr_conta.num_seq_contrato_part%TYPE;

--   SUBTYPE t_num_fir_cod IS ifrbde_views.cad_partic_contr_conta.num_fir_cod%TYPE;

   SUBTYPE t_num_seq_conta_part IS ifrbde_views.cad_partic_contr_conta.num_seq_conta_part%TYPE;

   
--   TYPE tyt_num_seq_contrato_part IS TABLE OF t_num_seq_contrato_part
--      INDEX BY BINARY_INTEGER;

--   TYPE tyt_num_fir_cod IS TABLE OF t_num_fir_cod
--      INDEX BY BINARY_INTEGER;

   TYPE tyt_num_seq_conta_part IS TABLE OF t_num_seq_conta_part
      INDEX BY BINARY_INTEGER;

   PROCEDURE stp_pesquisa_partic_contr_cont (
      p_usuario                           VARCHAR2,
      vo_num_seq_contrato_part   OUT      tyt_num_seq_contrato_part,
      vo_num_fir_cod             OUT      tyt_num_fir_cod,
      vo_num_seq_conta_part      OUT      tyt_num_seq_conta_part,
      vi_num_seq_contrato_part   IN       t_num_seq_contrato_part
   );

   PROCEDURE stp_exclui_partic_contr_conta (
      p_usuario                           VARCHAR2,
      vo_ok                      OUT      tyt_ok,
      vi_num_seq_contrato_part   IN       t_num_seq_contrato_part
   );

   PROCEDURE stp_inclui_partic_contr_conta (
      p_usuario                           VARCHAR2,
      vo_num_seq_contrato_part   OUT      tyt_num_seq_contrato_part,
      vo_num_fir_cod             OUT      tyt_num_fir_cod,
      vo_num_seq_conta_part      OUT      tyt_num_seq_conta_part,
      vi_num_seq_contrato_part   IN       t_num_seq_contrato_part,
      vi_num_fir_cod             IN       t_num_fir_cod,
      vi_num_seq_conta_part      IN       t_num_seq_conta_part
   );

   PROCEDURE stp_altera_partic_contr_conta (
      p_usuario                           VARCHAR2,
      vo_num_seq_contrato_part   OUT      tyt_num_seq_contrato_part,
      vo_num_fir_cod             OUT      tyt_num_fir_cod,
      vo_num_seq_conta_part      OUT      tyt_num_seq_conta_part,
      vi_num_seq_contrato_part   IN       t_num_seq_contrato_part,
      vi_num_fir_cod             IN       t_num_fir_cod,
      vi_num_seq_conta_part      IN       t_num_seq_conta_part
   );
END pck_contrato;
/

-- Grants for Package
GRANT EXECUTE ON ifrbde_views.pck_contrato TO bde_views
/
GRANT EXECUTE ON ifrbde_views.pck_contrato TO bde_geral
/

CREATE OR REPLACE 
PACKAGE BODY ifrbde_views.pck_contrato AS
   
--------------------------------------------------------------------------------
   -- Pesquisa Cadastro de Índices/Moedas
   -- retorna o recordset correspondente
   PROCEDURE stp_pesquisa_indice (
      p_usuario                VARCHAR2,
      vo_ice_cod      OUT      tyt_ice_cod,
      vo_tip_indice   OUT      tyt_tip_indice,
      vi_ice_cod      IN       t_ice_cod
   ) AS
   BEGIN
      IF ifrbde_views.pck_seguranca.stf_permitido (
            p_usuario,
            'TAB_INDICE',
            'PESQUISA'
         ) THEN
         SELECT ice_cod,
                tip_indice
           INTO vo_ice_cod (1),
                vo_tip_indice (1)
           FROM ifrbde_views.tab_indice
          WHERE ice_cod = vi_ice_cod;
      END IF;
   EXCEPTION
      WHEN OTHERS THEN
         raise_application_error (-20100, SQLERRM);
   END;

   -- Exclui Cadastro de Índices/Moedas
   -- retorna o OK ou nao
   PROCEDURE stp_exclui_indice (
      p_usuario             VARCHAR2,
      vo_ok        OUT      tyt_ok,
      vi_ice_cod   IN       t_ice_cod
   ) AS
   BEGIN
      vo_ok (1) := 0;

      IF ifrbde_views.pck_seguranca.stf_permitido (
            p_usuario,
            'TAB_INDICE',
            'EXCLUI'
         ) THEN
         DELETE FROM ifrbde_views.tab_indice
               WHERE ice_cod = vi_ice_cod;

         IF SQL%ROWCOUNT = 1 THEN
            vo_ok (1) := 1;
            -- LOG
            ifrbde_views.pck_seguranca.stp_log (
               p_usuario,
               'TAB_INDICE',
               'E',
               vi_ice_cod
            );
            COMMIT;
         ELSIF SQL%ROWCOUNT > 1 THEN
            ROLLBACK;
         END IF;
      END IF;
   EXCEPTION
      WHEN OTHERS THEN
         raise_application_error (-20100, SQLERRM);
   END;

   
--------------------------------------------------------------------
-- Inclui Cadastro de Índices/Moedas
-- retorna o recordset correspondente
   PROCEDURE stp_inclui_indice (
      p_usuario                VARCHAR2,
      vo_ice_cod      OUT      tyt_ice_cod,
      vo_tip_indice   OUT      tyt_tip_indice,
      vi_ice_cod      IN       t_ice_cod,
      vi_tip_indice   IN       t_tip_indice
   ) AS
      v_ice_cod                     tab_indice.ice_cod%TYPE;
      v_tip_indice                  tab_indice.tip_indice%TYPE;
   BEGIN
      IF ifrbde_views.pck_seguranca.stf_permitido (
            p_usuario,
            'TAB_INDICE',
            'INCLUI'
         ) THEN
         v_ice_cod := RTRIM (LTRIM (UPPER (vi_ice_cod)));
         v_tip_indice := RTRIM (LTRIM (UPPER (vi_tip_indice)));

         INSERT INTO ifrbde_views.tab_indice
                     (ice_cod,
                      tip_indice
                     )
              VALUES (v_ice_cod,
                      v_tip_indice
                     );

         IF SQL%ROWCOUNT = 1 THEN
            stp_pesquisa_indice (
               p_usuario,
               vo_ice_cod,
               vo_tip_indice,
               v_ice_cod
            );
            -- LOG
            ifrbde_views.pck_seguranca.stp_log (
               p_usuario,
               'TAB_INDICE',
               'I',
               vi_ice_cod
            );
            COMMIT;
         ELSE
            ROLLBACK;
         END IF;
      END IF;
   EXCEPTION
      WHEN DUP_VAL_ON_INDEX THEN
         raise_application_error (-20100, 'Número do contrato já Existente!');
      WHEN OTHERS THEN
         raise_application_error (-20100, SQLERRM);
   END;

   
--------------------------------------------------------------------
-- Altera Cadastro de Índices/Moedas
-- retorna o recordset correspondente
   PROCEDURE stp_altera_indice (
      p_usuario                VARCHAR2,
      vo_ice_cod      OUT      tyt_ice_cod,
      vo_tip_indice   OUT      tyt_tip_indice,
      vi_ice_cod      IN       t_ice_cod,
      vi_tip_indice   IN       t_tip_indice
   ) AS
      CURSOR c_cursor IS
         SELECT     *
               FROM ifrbde_views.tab_indice
              WHERE ice_cod = vi_ice_cod
         FOR UPDATE;

      v_tab_indice                  ifrbde_views.tab_indice%ROWTYPE;
      v_ice_cod                     ifrbde_views.tab_indice.ice_cod%TYPE;
      v_tip_indice                  ifrbde_views.tab_indice.tip_indice%TYPE;
   BEGIN
      IF ifrbde_views.pck_seguranca.stf_permitido (
            p_usuario,
            'TAB_INDICE',
            'ALTERA'
         ) THEN
         OPEN c_cursor;
         FETCH c_cursor INTO v_tab_indice;

         IF NOT c_cursor%NOTFOUND THEN
            v_ice_cod := RTRIM (LTRIM (UPPER (vi_ice_cod)));
            v_tip_indice := RTRIM (LTRIM (UPPER (vi_tip_indice)));

            UPDATE ifrbde_views.tab_indice
               SET tip_indice = v_tip_indice
             WHERE  CURRENT OF c_cursor;

            IF SQL%ROWCOUNT = 1 THEN
               stp_pesquisa_indice (
                  p_usuario,
                  vo_ice_cod,
                  vo_tip_indice,
                  vi_ice_cod
               );
               -- LOG
               ifrbde_views.pck_seguranca.stp_log (
                  p_usuario,
                  'TAB_INDICE',
                  'A',
                  vi_ice_cod
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
-- Pesquisa Data e Valores
-- retorna o recordset correspondente
   PROCEDURE stp_pesquisa_indice_fil (
      p_usuario                      VARCHAR2,
      vo_num_seq_indice     OUT      tyt_num_seq_indice,
      vo_ici_ice_cod        OUT      tyt_ici_ice_cod,
      vo_ici_periodo        OUT      tyt_ici_periodo,
      vo_ici_valor_diario   OUT      tyt_ici_valor_diario,
      vi_num_seq_indice     IN       t_num_seq_indice
   ) AS
   BEGIN
      IF ifrbde_views.pck_seguranca.stf_permitido (
            p_usuario,
            'TAB_INDICE_FIL',
            'PESQUISA'
         ) THEN
         SELECT num_seq_indice,
                ici_ice_cod,
                ici_periodo,
                ici_valor_diario
           INTO vo_num_seq_indice (1),
                vo_ici_ice_cod (1),
                vo_ici_periodo (1),
                vo_ici_valor_diario (1)
           FROM ifrbde_views.tab_indice_fil
          WHERE num_seq_indice = vi_num_seq_indice;
      END IF;
   EXCEPTION
      WHEN OTHERS THEN
         raise_application_error (-20100, SQLERRM);
   END;

   -- Exclui Data e Valores
   -- retorna o OK ou nao
   PROCEDURE stp_exclui_indice_fil (
      p_usuario                    VARCHAR2,
      vo_ok               OUT      tyt_ok,
      vi_num_seq_indice   IN       t_num_seq_indice
   ) AS
   BEGIN
      vo_ok (1) := 0;

      IF ifrbde_views.pck_seguranca.stf_permitido (
            p_usuario,
            'TAB_INDICE_FIL',
            'EXCLUI'
         ) THEN
         DELETE FROM ifrbde_views.tab_indice_fil
               WHERE num_seq_indice = vi_num_seq_indice;

         IF SQL%ROWCOUNT = 1 THEN
            vo_ok (1) := 1;
            -- LOG
            ifrbde_views.pck_seguranca.stp_log (
               p_usuario,
               'TAB_INDICE_FIL',
               'E',
               TO_CHAR (vi_num_seq_indice)
            );
            COMMIT;
         ELSIF SQL%ROWCOUNT > 1 THEN
            ROLLBACK;
         END IF;
      END IF;
   EXCEPTION
      WHEN OTHERS THEN
         raise_application_error (-20100, SQLERRM);
   END;

   
--------------------------------------------------------------------
-- Inclui Data e Valores
-- retorna o recordset correspondente
   PROCEDURE stp_inclui_indice_fil (
      p_usuario                      VARCHAR2,
      vo_num_seq_indice     OUT      tyt_num_seq_indice,
      vo_ici_ice_cod        OUT      tyt_ici_ice_cod,
      vo_ici_periodo        OUT      tyt_ici_periodo,
      vo_ici_valor_diario   OUT      tyt_ici_valor_diario,
      vi_ici_ice_cod        IN       t_ici_ice_cod,
      vi_ici_periodo        IN       t_ici_periodo,
      vi_ici_valor_diario   IN       t_ici_valor_diario
   ) AS
      v_num_seq_indice              tab_indice_fil.num_seq_indice%TYPE;
      v_ici_ice_cod                 tab_indice_fil.ici_ice_cod%TYPE;
      v_ici_periodo                 tab_indice_fil.ici_periodo%TYPE;
      v_ici_valor_diario            tab_indice_fil.ici_valor_diario%TYPE;
   BEGIN
      IF ifrbde_views.pck_seguranca.stf_permitido (
            p_usuario,
            'TAB_INDICE_FIL',
            'INCLUI'
         ) THEN
         SELECT seq_num_seq_indice.NEXTVAL
           INTO v_num_seq_indice
           FROM DUAL;

         v_ici_ice_cod := RTRIM (LTRIM (UPPER (vi_ici_ice_cod)));
         v_ici_periodo := TO_DATE (vi_ici_periodo, 'DD/MM/YYYY');
         v_ici_valor_diario := vi_ici_valor_diario;

         INSERT INTO ifrbde_views.tab_indice_fil
                     (num_seq_indice,
                      ici_ice_cod,
                      ici_periodo,
                      ici_valor_diario
                     )
              VALUES (v_num_seq_indice,
                      v_ici_ice_cod,
                      v_ici_periodo,
                      v_ici_valor_diario
                     );

         IF SQL%ROWCOUNT = 1 THEN
            stp_pesquisa_indice_fil (
               p_usuario,
               vo_num_seq_indice,
               vo_ici_ice_cod,
               vo_ici_periodo,
               vo_ici_valor_diario,
               v_num_seq_indice
            );
            -- LOG
            ifrbde_views.pck_seguranca.stp_log (
               p_usuario,
               'TAB_INDICE_FIL',
               'I',
               TO_CHAR (v_num_seq_indice) || vi_ici_ice_cod
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
-- Altera Data e Valores
-- retorna o recordset correspondente
   PROCEDURE stp_altera_indice_fil (
      p_usuario                      VARCHAR2,
      vo_num_seq_indice     OUT      tyt_num_seq_indice,
      vo_ici_ice_cod        OUT      tyt_ici_ice_cod,
      vo_ici_periodo        OUT      tyt_ici_periodo,
      vo_ici_valor_diario   OUT      tyt_ici_valor_diario,
      vi_num_seq_indice     IN       t_num_seq_indice,
      vi_ici_ice_cod        IN       t_ici_ice_cod,
      vi_ici_periodo        IN       t_ici_periodo,
      vi_ici_valor_diario   IN       t_ici_valor_diario
   ) AS
      CURSOR c_cursor IS
         SELECT     *
               FROM ifrbde_views.tab_indice_fil
              WHERE num_seq_indice = vi_num_seq_indice
         FOR UPDATE;

      v_tab_indice_fil              ifrbde_views.tab_indice_fil%ROWTYPE;
      v_num_seq_indice              ifrbde_views.tab_indice_fil.num_seq_indice%TYPE;
      v_ici_ice_cod                 ifrbde_views.tab_indice_fil.ici_ice_cod%TYPE;
      v_ici_periodo                 ifrbde_views.tab_indice_fil.ici_periodo%TYPE;
      v_ici_valor_diario            ifrbde_views.tab_indice_fil.ici_valor_diario%TYPE;
   BEGIN
      IF ifrbde_views.pck_seguranca.stf_permitido (
            p_usuario,
            'TAB_INDICE_FIL',
            'ALTERA'
         ) THEN
         OPEN c_cursor;
         FETCH c_cursor INTO v_tab_indice_fil;

         IF NOT c_cursor%NOTFOUND THEN
            v_ici_ice_cod := RTRIM (LTRIM (UPPER (vi_ici_ice_cod)));
            v_ici_periodo := TO_DATE (vi_ici_periodo, 'DD/MM/YYYY');
            v_ici_valor_diario := vi_ici_valor_diario;

            UPDATE ifrbde_views.tab_indice_fil
               SET ici_ice_cod = v_ici_ice_cod,
                   ici_periodo = v_ici_periodo,
                   ici_valor_diario = v_ici_valor_diario
             WHERE  CURRENT OF c_cursor;

            IF SQL%ROWCOUNT = 1 THEN
               stp_pesquisa_indice_fil (
                  p_usuario,
                  vo_num_seq_indice,
                  vo_ici_ice_cod,
                  vo_ici_periodo,
                  vo_ici_valor_diario,
                  vi_num_seq_indice
               );
               -- LOG
               ifrbde_views.pck_seguranca.stp_log (
                  p_usuario,
                  'TAB_INDICE_FIL',
                  'A',
                  TO_CHAR (vi_num_seq_indice) || vi_ici_ice_cod
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
-- Pesquisa Firmas do Contrato
-- retorna o recordset correspondente
   PROCEDURE stp_pesquisa_participantes_con (
      p_usuario                           VARCHAR2,
      vo_num_seq_contrato_part   OUT      tyt_num_seq_contrato_part,
      vo_num_fir_cod             OUT      tyt_num_fir_cod,
      vi_num_seq_contrato_part   IN       t_num_seq_contrato_part,
      vi_num_fir_cod             IN       t_num_fir_cod
   ) AS
   BEGIN
      IF ifrbde_views.pck_seguranca.stf_permitido (
            p_usuario,
            'CAD_PARTICIPANTES_CONTRATO',
            'PESQUISA'
         ) THEN
         SELECT num_seq_contrato_part,
                num_fir_cod
           INTO vo_num_seq_contrato_part (1),
                vo_num_fir_cod (1)
           FROM ifrbde_views.cad_participantes_contrato
          WHERE num_seq_contrato_part = vi_num_seq_contrato_part
            AND num_fir_cod = vi_num_fir_cod;
      END IF;
   EXCEPTION
      WHEN OTHERS THEN
         raise_application_error (-20100, SQLERRM);
   END;

   -- Exclui Firmas do Contrato
   -- retorna o OK ou nao
   PROCEDURE stp_exclui_participantes_contr (
      p_usuario                           VARCHAR2,
      vo_ok                      OUT      tyt_ok,
      vi_num_seq_contrato_part   IN       t_num_seq_contrato_part,
      vi_num_fir_cod             IN       t_num_fir_cod
   ) AS
   BEGIN
      vo_ok (1) := 0;

      IF ifrbde_views.pck_seguranca.stf_permitido (
            p_usuario,
            'CAD_PARTICIPANTES_CONTRATO',
            'EXCLUI'
         ) THEN
         DELETE FROM ifrbde_views.cad_participantes_contrato
               WHERE num_seq_contrato_part = vi_num_seq_contrato_part
                 AND num_fir_cod = vi_num_fir_cod;

         IF SQL%ROWCOUNT = 1 THEN
            vo_ok (1) := 1;
            -- LOG
            ifrbde_views.pck_seguranca.stp_log (
               p_usuario,
               'CAD_PARTICIPANTES_CONTRATO',
               'E',
               TO_CHAR (vi_num_seq_contrato_part) || TO_CHAR (vi_num_fir_cod)
            );
            COMMIT;
         ELSIF SQL%ROWCOUNT > 1 THEN
            ROLLBACK;
         END IF;
      END IF;
   EXCEPTION
      WHEN OTHERS THEN
         raise_application_error (-20100, SQLERRM);
   END;

   
--------------------------------------------------------------------
-- Inclui Firmas do Contrato
-- retorna o recordset correspondente
   PROCEDURE stp_inclui_participantes_contr (
      p_usuario                           VARCHAR2,
      vo_num_seq_contrato_part   OUT      tyt_num_seq_contrato_part,
      vo_num_fir_cod             OUT      tyt_num_fir_cod,
      vi_num_seq_contrato_part   IN       t_num_seq_contrato_part,
      vi_num_fir_cod             IN       t_num_fir_cod
   ) AS
      v_num_seq_contrato_part       cad_participantes_contrato.num_seq_contrato_part%TYPE;
      v_num_fir_cod                 cad_participantes_contrato.num_fir_cod%TYPE;
   BEGIN
      IF ifrbde_views.pck_seguranca.stf_permitido (
            p_usuario,
            'CAD_PARTICIPANTES_CONTRATO',
            'INCLUI'
         ) THEN
         v_num_seq_contrato_part := vi_num_seq_contrato_part;
         v_num_fir_cod := vi_num_fir_cod;

         INSERT INTO ifrbde_views.cad_participantes_contrato
                     (num_seq_contrato_part,
                      num_fir_cod
                     )
              VALUES (v_num_seq_contrato_part,
                      v_num_fir_cod
                     );

         IF SQL%ROWCOUNT = 1 THEN
            stp_pesquisa_participantes_con (
               p_usuario,
               vo_num_seq_contrato_part,
               vo_num_fir_cod,
               v_num_seq_contrato_part,
               v_num_fir_cod
            );
            -- LOG
            ifrbde_views.pck_seguranca.stp_log (
               p_usuario,
               'CAD_PARTICIPANTES_CONTRATO',
               'I',
               TO_CHAR (vi_num_seq_contrato_part) || TO_CHAR (vi_num_fir_cod)
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
-- Altera Firmas do Contrato
-- retorna o recordset correspondente
   PROCEDURE stp_altera_participantes_contr (
      p_usuario                           VARCHAR2,
      vo_num_seq_contrato_part   OUT      tyt_num_seq_contrato_part,
      vo_num_fir_cod             OUT      tyt_num_fir_cod,
      vi_num_seq_contrato_part   IN       t_num_seq_contrato_part,
      vi_num_fir_cod             IN       t_num_fir_cod
   ) AS
      CURSOR c_cursor IS
         SELECT     *
               FROM ifrbde_views.cad_participantes_contrato
              WHERE num_seq_contrato_part = vi_num_seq_contrato_part
                AND num_fir_cod = vi_num_fir_cod
         FOR UPDATE;

      v_cad_participantes_contrato  ifrbde_views.cad_participantes_contrato%ROWTYPE;
      v_num_seq_contrato_part       ifrbde_views.cad_participantes_contrato.num_seq_contrato_part%TYPE;
      v_num_fir_cod                 ifrbde_views.cad_participantes_contrato.num_fir_cod%TYPE;
   BEGIN
      IF ifrbde_views.pck_seguranca.stf_permitido (
            p_usuario,
            'CAD_PARTICIPANTES_CONTRATO',
            'ALTERA'
         ) THEN
         OPEN c_cursor;
         FETCH c_cursor INTO v_cad_participantes_contrato;

         IF NOT c_cursor%NOTFOUND THEN
            v_num_seq_contrato_part := vi_num_seq_contrato_part;
            v_num_fir_cod := vi_num_fir_cod;

            
--            UPDATE IFRBDE_views.cad_participantes_contrato
--            SET
--            WHERE CURRENT of c_cursor;

            IF SQL%ROWCOUNT = 1 THEN
               stp_pesquisa_participantes_con (
                  p_usuario,
                  vo_num_seq_contrato_part,
                  vo_num_fir_cod,
                  vi_num_seq_contrato_part,
                  vi_num_fir_cod
               );
               -- LOG
               ifrbde_views.pck_seguranca.stp_log (
                  p_usuario,
                  'CAD_PARTICIPANTES_CONTRATO',
                  'A',
                  TO_CHAR (vi_num_seq_contrato_part)
                  || TO_CHAR (vi_num_fir_cod)
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
-- Pesquisa Fiscais do Contrato
-- retorna o recordset correspondente
   PROCEDURE stp_pesquisa_fiscais_contrato (
      p_usuario                          VARCHAR2,
      vo_num_seq_contrato_fis   OUT      tyt_num_seq_contrato_fis,
      vo_num_seq_pessoal_fis    OUT      tyt_num_seq_pessoal_fis,
      vi_num_seq_contrato_fis   IN       t_num_seq_contrato_fis,
      vi_num_seq_pessoal_fis    IN       t_num_seq_pessoal_fis
   ) AS
   BEGIN
      IF ifrbde_views.pck_seguranca.stf_permitido (
            p_usuario,
            'CAD_FISCAIS_CONTRATO',
            'PESQUISA'
         ) THEN
         SELECT num_seq_contrato_fis,
                num_seq_pessoal_fis
           INTO vo_num_seq_contrato_fis (1),
                vo_num_seq_pessoal_fis (1)
           FROM ifrbde_views.cad_fiscais_contrato
          WHERE num_seq_contrato_fis = vi_num_seq_contrato_fis
            AND num_seq_pessoal_fis = vi_num_seq_pessoal_fis;
      END IF;
   EXCEPTION
      WHEN OTHERS THEN
         raise_application_error (-20100, SQLERRM);
   END;

   -- Exclui Fiscais do Contrato
   -- retorna o OK ou nao
   PROCEDURE stp_exclui_fiscais_contrato (
      p_usuario                          VARCHAR2,
      vo_ok                     OUT      tyt_ok,
      vi_num_seq_contrato_fis   IN       t_num_seq_contrato_fis,
      vi_num_seq_pessoal_fis    IN       t_num_seq_pessoal_fis
   ) AS
   BEGIN
      vo_ok (1) := 0;

      IF ifrbde_views.pck_seguranca.stf_permitido (
            p_usuario,
            'CAD_FISCAIS_CONTRATO',
            'EXCLUI'
         ) THEN
         DELETE FROM ifrbde_views.cad_fiscais_contrato
               WHERE num_seq_contrato_fis = vi_num_seq_contrato_fis
                 AND num_seq_pessoal_fis = vi_num_seq_pessoal_fis;

         IF SQL%ROWCOUNT = 1 THEN
            vo_ok (1) := 1;
            -- LOG
            ifrbde_views.pck_seguranca.stp_log (
               p_usuario,
               'CAD_FISCAIS_CONTRATO',
               'E',
               TO_CHAR (vi_num_seq_contrato_fis)
               || TO_CHAR (vi_num_seq_pessoal_fis)
            );
            COMMIT;
         ELSIF SQL%ROWCOUNT > 1 THEN
            ROLLBACK;
         END IF;
      END IF;
   EXCEPTION
      WHEN OTHERS THEN
         raise_application_error (-20100, SQLERRM);
   END;

   
--------------------------------------------------------------------
-- Inclui Fiscais do Contrato
-- retorna o recordset correspondente
   PROCEDURE stp_inclui_fiscais_contrato (
      p_usuario                          VARCHAR2,
      vo_num_seq_contrato_fis   OUT      tyt_num_seq_contrato_fis,
      vo_num_seq_pessoal_fis    OUT      tyt_num_seq_pessoal_fis,
      vi_num_seq_contrato_fis   IN       t_num_seq_contrato_fis,
      vi_num_seq_pessoal_fis    IN       t_num_seq_pessoal_fis
   ) AS
      v_num_seq_contrato_fis        cad_fiscais_contrato.num_seq_contrato_fis%TYPE;
      v_num_seq_pessoal_fis         cad_fiscais_contrato.num_seq_pessoal_fis%TYPE;
   BEGIN
      IF ifrbde_views.pck_seguranca.stf_permitido (
            p_usuario,
            'CAD_FISCAIS_CONTRATO',
            'INCLUI'
         ) THEN
         v_num_seq_contrato_fis := vi_num_seq_contrato_fis;
         v_num_seq_pessoal_fis := vi_num_seq_pessoal_fis;

         INSERT INTO ifrbde_views.cad_fiscais_contrato
                     (num_seq_contrato_fis,
                      num_seq_pessoal_fis
                     )
              VALUES (v_num_seq_contrato_fis,
                      v_num_seq_pessoal_fis
                     );

         IF SQL%ROWCOUNT = 1 THEN
            stp_pesquisa_fiscais_contrato (
               p_usuario,
               vo_num_seq_contrato_fis,
               vo_num_seq_pessoal_fis,
               v_num_seq_contrato_fis,
               v_num_seq_pessoal_fis
            );
            -- LOG
            ifrbde_views.pck_seguranca.stp_log (
               p_usuario,
               'CAD_FISCAIS_CONTRATO',
               'I',
               TO_CHAR (vi_num_seq_contrato_fis)
               || TO_CHAR (vi_num_seq_pessoal_fis)
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
-- Altera Fiscais do Contrato
-- retorna o recordset correspondente
   PROCEDURE stp_altera_fiscais_contrato (
      p_usuario                          VARCHAR2,
      vo_num_seq_contrato_fis   OUT      tyt_num_seq_contrato_fis,
      vo_num_seq_pessoal_fis    OUT      tyt_num_seq_pessoal_fis,
      vi_num_seq_contrato_fis   IN       t_num_seq_contrato_fis,
      vi_num_seq_pessoal_fis    IN       t_num_seq_pessoal_fis
   ) AS
      CURSOR c_cursor IS
         SELECT     *
               FROM ifrbde_views.cad_fiscais_contrato
              WHERE num_seq_contrato_fis = vi_num_seq_contrato_fis
                AND num_seq_pessoal_fis = vi_num_seq_pessoal_fis
         FOR UPDATE;

      v_cad_fiscais_contrato        ifrbde_views.cad_fiscais_contrato%ROWTYPE;
      v_num_seq_contrato_fis        ifrbde_views.cad_fiscais_contrato.num_seq_contrato_fis%TYPE;
      v_num_seq_pessoal_fis         ifrbde_views.cad_fiscais_contrato.num_seq_pessoal_fis%TYPE;
   BEGIN
      IF ifrbde_views.pck_seguranca.stf_permitido (
            p_usuario,
            'CAD_FISCAIS_CONTRATO',
            'ALTERA'
         ) THEN
         OPEN c_cursor;
         FETCH c_cursor INTO v_cad_fiscais_contrato;

         IF NOT c_cursor%NOTFOUND THEN
            v_num_seq_contrato_fis := vi_num_seq_contrato_fis;
            v_num_seq_pessoal_fis := vi_num_seq_pessoal_fis;

            
--            UPDATE IFRBDE_views.cad_fiscais_contrato
--            SET
--            WHERE CURRENT of c_cursor;

            IF SQL%ROWCOUNT = 1 THEN
               stp_pesquisa_fiscais_contrato (
                  p_usuario,
                  vo_num_seq_contrato_fis,
                  vo_num_seq_pessoal_fis,
                  vi_num_seq_contrato_fis,
                  vi_num_seq_pessoal_fis
               );
               -- LOG
               ifrbde_views.pck_seguranca.stp_log (
                  p_usuario,
                  'CAD_FISCAIS_CONTRATO',
                  'A',
                  TO_CHAR (vi_num_seq_contrato_fis)
                  || TO_CHAR (vi_num_seq_pessoal_fis)
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
-- Pesquisa Resumo de Valores
-- retorna o recordset correspondente
   PROCEDURE stp_pesquisa_resumo_valores (
      p_usuario                           VARCHAR2,
      vo_num_seq_contrato_res    OUT      tyt_num_seq_contrato_res,
      vo_num_seq_resumo          OUT      tyt_num_seq_resumo,
      vo_val_resumo              OUT      tyt_val_resumo,
      vo_val_termo               OUT      tyt_val_termo,
      vo_val_pagamento           OUT      tyt_val_pagamento,
      vo_val_reajuste            OUT      tyt_val_reajuste,
      vo_val_pago                OUT      tyt_val_pago,
      vo_val_pago_reajuste       OUT      tyt_val_pago_reajuste,
      vo_val_saldo_resumo        OUT      tyt_val_saldo_resumo,
      vo_flg_moeda_controle      OUT      tyt_flg_moeda_controle,
      vo_tip_moeda               OUT      tyt_tip_moeda,
      vo_dat_moeda               OUT      tyt_dat_moeda,
      vo_val_cotacao_moeda       OUT      tyt_val_cotacao_moeda,
      vo_tip_cotacao_moeda       OUT      tyt_tip_cotacao_moeda,
      vo_val_resumo_sec          OUT      tyt_val_resumo_sec,
      vo_val_termo_sec           OUT      tyt_val_termo_sec,
      vo_val_pagamento_sec       OUT      tyt_val_pagamento_sec,
      vo_val_reajuste_sec        OUT      tyt_val_reajuste_sec,
      vo_val_pago_sec            OUT      tyt_val_pago_sec,
      vo_val_pago_reajuste_sec   OUT      tyt_val_pago_reajuste_sec,
      vo_val_saldo_resumo_sec    OUT      tyt_val_saldo_resumo_sec,
      vi_num_seq_contrato_res    IN       t_num_seq_contrato_res,
      vi_num_seq_resumo          IN       t_num_seq_resumo
   ) AS
   BEGIN
      IF ifrbde_views.pck_seguranca.stf_permitido (
            p_usuario,
            'CAD_RESUMO_VALORES',
            'PESQUISA'
         ) THEN
         SELECT num_seq_contrato_res,
                num_seq_resumo,
                val_resumo,
                val_termo,
                val_pagamento,
                val_reajuste,
                val_pago,
                val_pago_reajuste,
                val_saldo_resumo,
                flg_moeda_controle,
                tip_moeda,
                TO_CHAR (dat_moeda, 'DD/MM/YYYY') dat_moeda,
                val_cotacao_moeda,
                tip_cotacao_moeda,
                val_resumo_sec,
                val_termo_sec,
                val_pagamento_sec,
                val_reajuste_sec,
                val_pago_sec,
                val_pago_reajuste_sec,
                val_saldo_resumo_sec
           INTO vo_num_seq_contrato_res (1),
                vo_num_seq_resumo (1),
                vo_val_resumo (1),
                vo_val_termo (1),
                vo_val_pagamento (1),
                vo_val_reajuste (1),
                vo_val_pago (1),
                vo_val_pago_reajuste (1),
                vo_val_saldo_resumo (1),
                vo_flg_moeda_controle (1),
                vo_tip_moeda (1),
                vo_dat_moeda (1),
                vo_val_cotacao_moeda (1),
                vo_tip_cotacao_moeda (1),
                vo_val_resumo_sec (1),
                vo_val_termo_sec (1),
                vo_val_pagamento_sec (1),
                vo_val_reajuste_sec (1),
                vo_val_pago_sec (1),
                vo_val_pago_reajuste_sec (1),
                vo_val_saldo_resumo_sec (1)
           FROM ifrbde_views.cad_resumo_valores
          WHERE num_seq_contrato_res = vi_num_seq_contrato_res
            AND num_seq_resumo = vi_num_seq_resumo;
      END IF;
   EXCEPTION
      WHEN OTHERS THEN
         raise_application_error (-20100, SQLERRM);
   END;

   -- Exclui Resumo de Valores
   -- retorna o OK ou nao
   PROCEDURE stp_exclui_resumo_valores (
      p_usuario                          VARCHAR2,
      vo_ok                     OUT      tyt_ok,
      vi_num_seq_contrato_res   IN       t_num_seq_contrato_res,
      vi_num_seq_resumo         IN       t_num_seq_resumo
   ) AS
   BEGIN
      vo_ok (1) := 0;

      IF ifrbde_views.pck_seguranca.stf_permitido (
            p_usuario,
            'CAD_RESUMO_VALORES',
            'EXCLUI'
         ) THEN
         DELETE FROM ifrbde_views.cad_resumo_valores
               WHERE num_seq_contrato_res = vi_num_seq_contrato_res
                 AND num_seq_resumo = vi_num_seq_resumo;

         IF SQL%ROWCOUNT = 1 THEN
            vo_ok (1) := 1;
            -- LOG
            ifrbde_views.pck_seguranca.stp_log (
               p_usuario,
               'CAD_RESUMO_VALORES',
               'E',
               TO_CHAR (vi_num_seq_contrato_res) || TO_CHAR (
                                                       vi_num_seq_resumo
                                                    )
            );
            ifrbde.prc_critica_contrato (vi_num_seq_contrato_res);
            COMMIT;
         ELSIF SQL%ROWCOUNT > 1 THEN
            ROLLBACK;
         END IF;
      END IF;
   EXCEPTION
      WHEN OTHERS THEN
         raise_application_error (-20100, SQLERRM);
   END;

   
--------------------------------------------------------------------
-- Inclui Resumo de Valores
-- retorna o recordset correspondente
   PROCEDURE stp_inclui_resumo_valores (
      p_usuario                           VARCHAR2,
      vo_num_seq_contrato_res    OUT      tyt_num_seq_contrato_res,
      vo_num_seq_resumo          OUT      tyt_num_seq_resumo,
      vo_val_resumo              OUT      tyt_val_resumo,
      vo_val_termo               OUT      tyt_val_termo,
      vo_val_pagamento           OUT      tyt_val_pagamento,
      vo_val_reajuste            OUT      tyt_val_reajuste,
      vo_val_pago                OUT      tyt_val_pago,
      vo_val_pago_reajuste       OUT      tyt_val_pago_reajuste,
      vo_val_saldo_resumo        OUT      tyt_val_saldo_resumo,
      vo_flg_moeda_controle      OUT      tyt_flg_moeda_controle,
      vo_tip_moeda               OUT      tyt_tip_moeda,
      vo_dat_moeda               OUT      tyt_dat_moeda,
      vo_val_cotacao_moeda       OUT      tyt_val_cotacao_moeda,
      vo_tip_cotacao_moeda       OUT      tyt_tip_cotacao_moeda,
      vo_val_resumo_sec          OUT      tyt_val_resumo_sec,
      vo_val_termo_sec           OUT      tyt_val_termo_sec,
      vo_val_pagamento_sec       OUT      tyt_val_pagamento_sec,
      vo_val_reajuste_sec        OUT      tyt_val_reajuste_sec,
      vo_val_pago_sec            OUT      tyt_val_pago_sec,
      vo_val_pago_reajuste_sec   OUT      tyt_val_pago_reajuste_sec,
      vo_val_saldo_resumo_sec    OUT      tyt_val_saldo_resumo_sec,
      vi_num_seq_contrato_res    IN       t_num_seq_contrato_res,
      vi_val_resumo              IN       t_val_resumo,
      vi_flg_moeda_controle      IN       t_flg_moeda_controle,
      vi_tip_moeda               IN       t_tip_moeda,
      vi_dat_moeda               IN       t_dat_moeda,
      vi_val_cotacao_moeda       IN       t_val_cotacao_moeda,
      vi_tip_cotacao_moeda       IN       t_tip_cotacao_moeda
   ) AS
      v_num_seq_contrato_res        cad_resumo_valores.num_seq_contrato_res%TYPE;
      v_num_seq_resumo              cad_resumo_valores.num_seq_resumo%TYPE;
      v_val_resumo                  cad_resumo_valores.val_resumo%TYPE;
      v_flg_moeda_controle          cad_resumo_valores.flg_moeda_controle%TYPE;
      v_tip_moeda                   cad_resumo_valores.tip_moeda%TYPE;
      v_dat_moeda                   cad_resumo_valores.dat_moeda%TYPE;
      v_val_cotacao_moeda           cad_resumo_valores.val_cotacao_moeda%TYPE;
      v_tip_cotacao_moeda           cad_resumo_valores.tip_cotacao_moeda%TYPE;
   BEGIN
      IF ifrbde_views.pck_seguranca.stf_permitido (
            p_usuario,
            'CAD_RESUMO_VALORES',
            'INCLUI'
         ) THEN
         SELECT seq_num_seq_contrato.NEXTVAL
           INTO v_num_seq_resumo
           FROM DUAL;

         v_flg_moeda_controle :=
                                RTRIM (LTRIM (UPPER (vi_flg_moeda_controle)));
         v_tip_moeda := RTRIM (LTRIM (UPPER (vi_tip_moeda)));
         v_tip_cotacao_moeda := RTRIM (LTRIM (UPPER (vi_tip_cotacao_moeda)));
         v_dat_moeda := TO_DATE (vi_dat_moeda, 'DD/MM/YYYY');
         v_num_seq_contrato_res := vi_num_seq_contrato_res;
         v_val_resumo := vi_val_resumo;
         v_val_cotacao_moeda := vi_val_cotacao_moeda;

         INSERT INTO ifrbde_views.cad_resumo_valores
                     (num_seq_contrato_res,
                      num_seq_resumo,
                      val_resumo,
                      flg_moeda_controle,
                      tip_moeda,
                      dat_moeda,
                      val_cotacao_moeda,
                      tip_cotacao_moeda
                     )
              VALUES (v_num_seq_contrato_res,
                      v_num_seq_resumo,
                      v_val_resumo,
                      v_flg_moeda_controle,
                      v_tip_moeda,
                      v_dat_moeda,
                      v_val_cotacao_moeda,
                      v_tip_cotacao_moeda
                     );

         IF SQL%ROWCOUNT = 1 THEN
            stp_pesquisa_resumo_valores (
               p_usuario,
               vo_num_seq_contrato_res,
               vo_num_seq_resumo,
               vo_val_resumo,
               vo_val_termo,
               vo_val_pagamento,
               vo_val_reajuste,
               vo_val_pago,
               vo_val_pago_reajuste,
               vo_val_saldo_resumo,
               vo_flg_moeda_controle,
               vo_tip_moeda,
               vo_dat_moeda,
               vo_val_cotacao_moeda,
               vo_tip_cotacao_moeda,
               vo_val_resumo_sec,
               vo_val_termo_sec,
               vo_val_pagamento_sec,
               vo_val_reajuste_sec,
               vo_val_pago_sec,
               vo_val_pago_reajuste_sec,
               vo_val_saldo_resumo_sec,
               v_num_seq_contrato_res,
               v_num_seq_resumo
            );
            -- LOG
            ifrbde_views.pck_seguranca.stp_log (
               p_usuario,
               'CAD_RESUMO_VALORES',
               'I',
               TO_CHAR (vi_num_seq_contrato_res) || TO_CHAR (
                                                       v_num_seq_resumo
                                                    )
            );
            ifrbde.prc_critica_contrato (vi_num_seq_contrato_res);
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
-- Altera Resumo de Valores
-- retorna o recordset correspondente
   PROCEDURE stp_altera_resumo_valores (
      p_usuario                           VARCHAR2,
      vo_num_seq_contrato_res    OUT      tyt_num_seq_contrato_res,
      vo_num_seq_resumo          OUT      tyt_num_seq_resumo,
      vo_val_resumo              OUT      tyt_val_resumo,
      vo_val_termo               OUT      tyt_val_termo,
      vo_val_pagamento           OUT      tyt_val_pagamento,
      vo_val_reajuste            OUT      tyt_val_reajuste,
      vo_val_pago                OUT      tyt_val_pago,
      vo_val_pago_reajuste       OUT      tyt_val_pago_reajuste,
      vo_val_saldo_resumo        OUT      tyt_val_saldo_resumo,
      vo_flg_moeda_controle      OUT      tyt_flg_moeda_controle,
      vo_tip_moeda               OUT      tyt_tip_moeda,
      vo_dat_moeda               OUT      tyt_dat_moeda,
      vo_val_cotacao_moeda       OUT      tyt_val_cotacao_moeda,
      vo_tip_cotacao_moeda       OUT      tyt_tip_cotacao_moeda,
      vo_val_resumo_sec          OUT      tyt_val_resumo_sec,
      vo_val_termo_sec           OUT      tyt_val_termo_sec,
      vo_val_pagamento_sec       OUT      tyt_val_pagamento_sec,
      vo_val_reajuste_sec        OUT      tyt_val_reajuste_sec,
      vo_val_pago_sec            OUT      tyt_val_pago_sec,
      vo_val_pago_reajuste_sec   OUT      tyt_val_pago_reajuste_sec,
      vo_val_saldo_resumo_sec    OUT      tyt_val_saldo_resumo_sec,
      vi_num_seq_contrato_res    IN       t_num_seq_contrato_res,
      vi_num_seq_resumo          IN       t_num_seq_resumo,
      vi_val_resumo              IN       t_val_resumo,
      vi_flg_moeda_controle      IN       t_flg_moeda_controle,
      vi_tip_moeda               IN       t_tip_moeda,
      vi_dat_moeda               IN       t_dat_moeda,
      vi_val_cotacao_moeda       IN       t_val_cotacao_moeda,
      vi_tip_cotacao_moeda       IN       t_tip_cotacao_moeda
   ) AS
      CURSOR c_cursor IS
         SELECT     *
               FROM ifrbde_views.cad_resumo_valores
              WHERE num_seq_contrato_res = vi_num_seq_contrato_res
                AND num_seq_resumo = vi_num_seq_resumo
         FOR UPDATE;

      v_cad_resumo_valores          ifrbde_views.cad_resumo_valores%ROWTYPE;
      v_num_seq_contrato_res        ifrbde_views.cad_resumo_valores.num_seq_contrato_res%TYPE;
      v_num_seq_resumo              ifrbde_views.cad_resumo_valores.num_seq_resumo%TYPE;
      v_val_resumo                  ifrbde_views.cad_resumo_valores.val_resumo%TYPE;
      v_flg_moeda_controle          ifrbde_views.cad_resumo_valores.flg_moeda_controle%TYPE;
      v_tip_moeda                   ifrbde_views.cad_resumo_valores.tip_moeda%TYPE;
      v_dat_moeda                   ifrbde_views.cad_resumo_valores.dat_moeda%TYPE;
      v_val_cotacao_moeda           ifrbde_views.cad_resumo_valores.val_cotacao_moeda%TYPE;
      v_tip_cotacao_moeda           ifrbde_views.cad_resumo_valores.tip_cotacao_moeda%TYPE;
   BEGIN
      IF ifrbde_views.pck_seguranca.stf_permitido (
            p_usuario,
            'CAD_RESUMO_VALORES',
            'ALTERA'
         ) THEN
         OPEN c_cursor;
         FETCH c_cursor INTO v_cad_resumo_valores;

         IF NOT c_cursor%NOTFOUND THEN
            v_flg_moeda_controle :=
                                RTRIM (LTRIM (UPPER (vi_flg_moeda_controle)));
            v_tip_moeda := RTRIM (LTRIM (UPPER (vi_tip_moeda)));
            v_tip_cotacao_moeda :=
                                 RTRIM (LTRIM (UPPER (vi_tip_cotacao_moeda)));
            v_dat_moeda := TO_DATE (vi_dat_moeda, 'DD/MM/YYYY');
            v_num_seq_contrato_res := vi_num_seq_contrato_res;
            v_val_resumo := vi_val_resumo;
            v_val_cotacao_moeda := vi_val_cotacao_moeda;

            UPDATE ifrbde_views.cad_resumo_valores
               SET val_resumo = v_val_resumo,
                   flg_moeda_controle = v_flg_moeda_controle,
                   tip_moeda = v_tip_moeda,
                   dat_moeda = v_dat_moeda,
                   val_cotacao_moeda = v_val_cotacao_moeda,
                   tip_cotacao_moeda = v_tip_cotacao_moeda
             WHERE  CURRENT OF c_cursor;

            IF SQL%ROWCOUNT = 1 THEN
               stp_pesquisa_resumo_valores (
                  p_usuario,
                  vo_num_seq_contrato_res,
                  vo_num_seq_resumo,
                  vo_val_resumo,
                  vo_val_termo,
                  vo_val_pagamento,
                  vo_val_reajuste,
                  vo_val_pago,
                  vo_val_pago_reajuste,
                  vo_val_saldo_resumo,
                  vo_flg_moeda_controle,
                  vo_tip_moeda,
                  vo_dat_moeda,
                  vo_val_cotacao_moeda,
                  vo_tip_cotacao_moeda,
                  vo_val_resumo_sec,
                  vo_val_termo_sec,
                  vo_val_pagamento_sec,
                  vo_val_reajuste_sec,
                  vo_val_pago_sec,
                  vo_val_pago_reajuste_sec,
                  vo_val_saldo_resumo_sec,
                  vi_num_seq_contrato_res,
                  vi_num_seq_resumo
               );
               -- LOG
               ifrbde_views.pck_seguranca.stp_log (
                  p_usuario,
                  'CAD_RESUMO_VALORES',
                  'A',
                  TO_CHAR (vi_num_seq_contrato_res)
                  || TO_CHAR (vi_num_seq_resumo)
               );
               ifrbde.prc_critica_contrato (vi_num_seq_contrato_res);
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
-- Pesquisa Cronog. de Desembolso/Reajuste
-- retorna o recordset correspondente
   PROCEDURE stp_pesquisa_cont_crono_pagame (
      p_usuario                           VARCHAR2,
      vo_num_seq_cronograma      OUT      tyt_num_seq_cronograma,
      vo_num_seq_contrato_cron   OUT      tyt_num_seq_contrato_cron,
      vo_ccp_pgose               OUT      tyt_ccp_pgose,
      vo_ccp_rti_cod             OUT      tyt_ccp_rti_cod,
      vo_ccp_data_venc           OUT      tyt_ccp_data_venc,
      vo_ccp_valor               OUT      tyt_ccp_valor,
      vo_tip_cronograma          OUT      tyt_tip_cronograma,
      vo_val_saldo_crono         OUT      tyt_val_saldo_crono,
      vo_val_saldo_crono_sec     OUT      tyt_val_saldo_crono_sec,
      vi_num_seq_cronograma      IN       t_num_seq_cronograma,
      vi_num_seq_contrato_cron   IN       t_num_seq_contrato_cron,
      vi_ccp_pgose               IN       t_ccp_pgose,
      vi_ccp_data_venc           IN       t_ccp_data_venc
   ) AS
   BEGIN
      IF ifrbde_views.pck_seguranca.stf_permitido (
            p_usuario,
            'TAB_CONT_CRONO_PAGAMENTO',
            'PESQUISA'
         ) THEN
         SELECT num_seq_cronograma,
                num_seq_contrato_cron,
                ccp_pgose,
                ccp_rti_cod,
                TO_CHAR (ccp_data_venc, 'DD/MM/YYYY') ccp_data_venc,
                ccp_valor,
                tip_cronograma,
                val_saldo_crono,
                val_saldo_crono_sec
           INTO vo_num_seq_cronograma (1),
                vo_num_seq_contrato_cron (1),
                vo_ccp_pgose (1),
                vo_ccp_rti_cod (1),
                vo_ccp_data_venc (1),
                vo_ccp_valor (1),
                vo_tip_cronograma (1),
                vo_val_saldo_crono (1),
                vo_val_saldo_crono_sec (1)
           FROM ifrbde_views.tab_cont_crono_pagamento
          WHERE num_seq_cronograma = vi_num_seq_cronograma
            AND num_seq_contrato_cron = vi_num_seq_contrato_cron
            AND ccp_pgose = vi_ccp_pgose
            AND ccp_data_venc = vi_ccp_data_venc;
      END IF;
   EXCEPTION
      WHEN OTHERS THEN
         raise_application_error (-20100, SQLERRM);
   END;

   -- Exclui Cronog. de Desembolso/Reajuste
   -- retorna o OK ou nao
   PROCEDURE stp_exclui_cont_crono_pagament (
      p_usuario                           VARCHAR2,
      vo_ok                      OUT      tyt_ok,
      vi_num_seq_cronograma      IN       t_num_seq_cronograma,
      vi_num_seq_contrato_cron   IN       t_num_seq_contrato_cron,
      vi_ccp_pgose               IN       t_ccp_pgose,
      vi_ccp_data_venc           IN       t_ccp_data_venc
   ) AS
   BEGIN
      vo_ok (1) := 0;

      IF ifrbde_views.pck_seguranca.stf_permitido (
            p_usuario,
            'TAB_CONT_CRONO_PAGAMENTO',
            'EXCLUI'
         ) THEN
         DELETE FROM ifrbde_views.tab_cont_crono_pagamento
               WHERE num_seq_cronograma = vi_num_seq_cronograma
                 AND num_seq_contrato_cron = vi_num_seq_contrato_cron
                 AND ccp_pgose = vi_ccp_pgose
                 AND ccp_data_venc = vi_ccp_data_venc;

         IF SQL%ROWCOUNT = 1 THEN
            vo_ok (1) := 1;
            -- LOG
            ifrbde_views.pck_seguranca.stp_log (
               p_usuario,
               'TAB_CONT_CRONO_PAGAMENTO',
               'E',
               TO_CHAR (vi_num_seq_cronograma)
               || TO_CHAR (vi_num_seq_contrato_cron)
               || vi_ccp_pgose
               || vi_ccp_data_venc
            );
            ifrbde.prc_critica_crono_contrato (vi_num_seq_contrato_cron);
            COMMIT;
         ELSIF SQL%ROWCOUNT > 1 THEN
            ROLLBACK;
         END IF;
      END IF;
   EXCEPTION
      WHEN OTHERS THEN
         raise_application_error (-20100, SQLERRM);
   END;

   
--------------------------------------------------------------------
-- Inclui Cronog. de Desembolso/Reajuste
-- retorna o recordset correspondente
   PROCEDURE stp_inclui_cont_crono_pagament (
      p_usuario                           VARCHAR2,
      vo_num_seq_cronograma      OUT      tyt_num_seq_cronograma,
      vo_num_seq_contrato_cron   OUT      tyt_num_seq_contrato_cron,
      vo_ccp_pgose               OUT      tyt_ccp_pgose,
      vo_ccp_rti_cod             OUT      tyt_ccp_rti_cod,
      vo_ccp_data_venc           OUT      tyt_ccp_data_venc,
      vo_ccp_valor               OUT      tyt_ccp_valor,
      vo_tip_cronograma          OUT      tyt_tip_cronograma,
      vo_val_saldo_crono         OUT      tyt_val_saldo_crono,
      vo_val_saldo_crono_sec     OUT      tyt_val_saldo_crono_sec,
      vi_num_seq_contrato_cron   IN       t_num_seq_contrato_cron,
      vi_ccp_pgose               IN       t_ccp_pgose,
      vi_ccp_rti_cod             IN       t_ccp_rti_cod,
      vi_ccp_data_venc           IN       t_ccp_data_venc,
      vi_ccp_valor               IN       t_ccp_valor,
      vi_tip_cronograma          IN       t_tip_cronograma
   ) AS
      v_num_seq_cronograma          tab_cont_crono_pagamento.num_seq_cronograma%TYPE;
      v_num_seq_contrato_cron       tab_cont_crono_pagamento.num_seq_contrato_cron%TYPE;
      v_ccp_pgose                   tab_cont_crono_pagamento.ccp_pgose%TYPE;
      v_ccp_rti_cod                 tab_cont_crono_pagamento.ccp_rti_cod%TYPE;
      v_ccp_data_venc               tab_cont_crono_pagamento.ccp_data_venc%TYPE;
      v_ccp_valor                   tab_cont_crono_pagamento.ccp_valor%TYPE;
      v_tip_cronograma              tab_cont_crono_pagamento.tip_cronograma%TYPE;
   BEGIN
      IF ifrbde_views.pck_seguranca.stf_permitido (
            p_usuario,
            'TAB_CONT_CRONO_PAGAMENTO',
            'INCLUI'
         ) THEN
         SELECT seq_num_seq_contrato.NEXTVAL
           INTO v_num_seq_cronograma
           FROM DUAL;

         v_ccp_pgose := RTRIM (LTRIM (UPPER (vi_ccp_pgose)));
         v_ccp_rti_cod := RTRIM (LTRIM (UPPER (vi_ccp_rti_cod)));
         v_tip_cronograma := RTRIM (LTRIM (UPPER (vi_tip_cronograma)));
         v_ccp_data_venc := TO_DATE (vi_ccp_data_venc, 'DD/MM/YYYY');
         v_num_seq_contrato_cron := vi_num_seq_contrato_cron;
         v_ccp_valor := vi_ccp_valor;

         INSERT INTO ifrbde_views.tab_cont_crono_pagamento
                     (num_seq_cronograma,
                      num_seq_contrato_cron,
                      ccp_pgose,
                      ccp_rti_cod,
                      ccp_data_venc,
                      ccp_valor,
                      tip_cronograma
                     )
              VALUES (v_num_seq_cronograma,
                      v_num_seq_contrato_cron,
                      v_ccp_pgose,
                      v_ccp_rti_cod,
                      v_ccp_data_venc,
                      v_ccp_valor,
                      v_tip_cronograma
                     );

         IF SQL%ROWCOUNT = 1 THEN
            stp_pesquisa_cont_crono_pagame (
               p_usuario,
               vo_num_seq_cronograma,
               vo_num_seq_contrato_cron,
               vo_ccp_pgose,
               vo_ccp_rti_cod,
               vo_ccp_data_venc,
               vo_ccp_valor,
               vo_tip_cronograma,
               vo_val_saldo_crono,
               vo_val_saldo_crono_sec,
               v_num_seq_cronograma,
               v_num_seq_contrato_cron,
               v_ccp_pgose,
               v_ccp_data_venc
            );
            -- LOG
            ifrbde_views.pck_seguranca.stp_log (
               p_usuario,
               'TAB_CONT_CRONO_PAGAMENTO',
               'I',
               TO_CHAR (v_num_seq_cronograma)
               || TO_CHAR (vi_num_seq_contrato_cron)
               || vi_ccp_pgose
               || vi_ccp_data_venc
            );
            ifrbde.prc_critica_crono_contrato (vi_num_seq_contrato_cron);
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
-- Altera Cronog. de Desembolso/Reajuste
-- retorna o recordset correspondente
   PROCEDURE stp_altera_cont_crono_pagament (
      p_usuario                           VARCHAR2,
      vo_num_seq_cronograma      OUT      tyt_num_seq_cronograma,
      vo_num_seq_contrato_cron   OUT      tyt_num_seq_contrato_cron,
      vo_ccp_pgose               OUT      tyt_ccp_pgose,
      vo_ccp_rti_cod             OUT      tyt_ccp_rti_cod,
      vo_ccp_data_venc           OUT      tyt_ccp_data_venc,
      vo_ccp_valor               OUT      tyt_ccp_valor,
      vo_tip_cronograma          OUT      tyt_tip_cronograma,
      vo_val_saldo_crono         OUT      tyt_val_saldo_crono,
      vo_val_saldo_crono_sec     OUT      tyt_val_saldo_crono_sec,
      vi_num_seq_cronograma      IN       t_num_seq_cronograma,
      vi_num_seq_contrato_cron   IN       t_num_seq_contrato_cron,
      vi_ccp_pgose               IN       t_ccp_pgose,
      vi_ccp_rti_cod             IN       t_ccp_rti_cod,
      vi_ccp_data_venc           IN       t_ccp_data_venc,
      vi_ccp_valor               IN       t_ccp_valor,
      vi_tip_cronograma          IN       t_tip_cronograma
   ) AS
      CURSOR c_cursor IS
         SELECT     *
               FROM ifrbde_views.tab_cont_crono_pagamento
              WHERE num_seq_cronograma = vi_num_seq_cronograma
                AND num_seq_contrato_cron = vi_num_seq_contrato_cron
                AND ccp_pgose = vi_ccp_pgose
                AND ccp_data_venc = vi_ccp_data_venc
         FOR UPDATE;

      v_tab_cont_crono_pagamento    ifrbde_views.tab_cont_crono_pagamento%ROWTYPE;
      v_num_seq_cronograma          ifrbde_views.tab_cont_crono_pagamento.num_seq_cronograma%TYPE;
      v_num_seq_contrato_cron       ifrbde_views.tab_cont_crono_pagamento.num_seq_contrato_cron%TYPE;
      v_ccp_pgose                   ifrbde_views.tab_cont_crono_pagamento.ccp_pgose%TYPE;
      v_ccp_rti_cod                 ifrbde_views.tab_cont_crono_pagamento.ccp_rti_cod%TYPE;
      v_ccp_data_venc               ifrbde_views.tab_cont_crono_pagamento.ccp_data_venc%TYPE;
      v_ccp_valor                   ifrbde_views.tab_cont_crono_pagamento.ccp_valor%TYPE;
      v_tip_cronograma              ifrbde_views.tab_cont_crono_pagamento.tip_cronograma%TYPE;
   BEGIN
      IF ifrbde_views.pck_seguranca.stf_permitido (
            p_usuario,
            'TAB_CONT_CRONO_PAGAMENTO',
            'ALTERA'
         ) THEN
         OPEN c_cursor;
         FETCH c_cursor INTO v_tab_cont_crono_pagamento;

         IF NOT c_cursor%NOTFOUND THEN
            v_ccp_pgose := RTRIM (LTRIM (UPPER (vi_ccp_pgose)));
            v_ccp_rti_cod := RTRIM (LTRIM (UPPER (vi_ccp_rti_cod)));
            v_tip_cronograma := RTRIM (LTRIM (UPPER (vi_tip_cronograma)));
            v_ccp_data_venc := TO_DATE (vi_ccp_data_venc, 'DD/MM/YYYY');
            v_num_seq_contrato_cron := vi_num_seq_contrato_cron;
            v_ccp_valor := vi_ccp_valor;

            UPDATE ifrbde_views.tab_cont_crono_pagamento
               SET ccp_rti_cod = v_ccp_rti_cod,
                   ccp_valor = v_ccp_valor,
                   tip_cronograma = v_tip_cronograma
             WHERE  CURRENT OF c_cursor;

            IF SQL%ROWCOUNT = 1 THEN
               stp_pesquisa_cont_crono_pagame (
                  p_usuario,
                  vo_num_seq_cronograma,
                  vo_num_seq_contrato_cron,
                  vo_ccp_pgose,
                  vo_ccp_rti_cod,
                  vo_ccp_data_venc,
                  vo_ccp_valor,
                  vo_tip_cronograma,
                  vo_val_saldo_crono,
                  vo_val_saldo_crono_sec,
                  vi_num_seq_cronograma,
                  vi_num_seq_contrato_cron,
                  vi_ccp_pgose,
                  vi_ccp_data_venc
               );
               -- LOG
               ifrbde_views.pck_seguranca.stp_log (
                  p_usuario,
                  'TAB_CONT_CRONO_PAGAMENTO',
                  'A',
                  TO_CHAR (vi_num_seq_cronograma)
                  || vi_num_seq_contrato_cron
                  || vi_ccp_pgose
                  || vi_ccp_data_venc
               );
               ifrbde.prc_critica_crono_contrato (vi_num_seq_contrato_cron);
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
-- Pesquisa Solicitação de Pagamento - SP
-- retorna o recordset correspondente
   PROCEDURE stp_pesquisa_resumo_pagamento (
      p_usuario                             VARCHAR2,
      vo_num_seq_pag_contrato_rp   OUT      tyt_num_seq_pag_contrato_rp,
      vo_num_seq_resumo_pag        OUT      tyt_num_seq_resumo_pag,
      vo_num_seq_entidade_pag      OUT      tyt_num_seq_entidade_pag,
      vo_cod_tipo_pag_rp           OUT      tyt_cod_tipo_pag_rp,
      vo_dat_pagamento             OUT      tyt_dat_pagamento,
      vo_dat_vencimento_pag        OUT      tyt_dat_vencimento_pag,
      vo_num_fatura_rp             OUT      tyt_num_fatura_rp,
      vo_dat_moeda_rp              OUT      tyt_dat_moeda_rp,
      vo_val_cotacao_moeda_rp      OUT      tyt_val_cotacao_moeda_rp,
      vo_tip_cotacao_moeda_rp      OUT      tyt_tip_cotacao_moeda_rp,
      vo_val_pagamento_rp          OUT      tyt_val_pagamento_rp,
      vo_val_glosa_rp              OUT      tyt_val_glosa_rp,
      vo_dsc_glosa_rp              OUT      tyt_dsc_glosa_rp,
      vo_val_retencao_rp           OUT      tyt_val_retencao_rp,
      vo_num_seq_entidade_rp       OUT      tyt_num_seq_entidade_rp,
      vo_val_multa_rp              OUT      tyt_val_multa_rp,
      vo_dsc_retencao_rp           OUT      tyt_dsc_retencao_rp,
      vo_val_imposto_irrf_rp       OUT      tyt_val_imposto_irrf_rp,
      vo_val_imposto_iss_rp        OUT      tyt_val_imposto_iss_rp,
      vo_val_imposto_pasep_rp      OUT      tyt_val_imposto_pasep_rp,
      vo_val_imposto_icms_rp       OUT      tyt_val_imposto_icms_rp,
      vo_val_imposto_inss_rp       OUT      tyt_val_imposto_inss_rp,
      vo_val_impostos_rp           OUT      tyt_val_impostos_rp,
      vo_val_liquido_nota_rp       OUT      tyt_val_liquido_nota_rp,
      vo_dsc_solicitacao_rp        OUT      tyt_dsc_solicitacao_rp,
      vo_tip_situacao_pag          OUT      tyt_tip_situacao_pag,
      vi_num_seq_pag_contrato_rp   IN       t_num_seq_pag_contrato_rp,
      vi_num_seq_resumo_pag        IN       t_num_seq_resumo_pag
   ) AS
   BEGIN
      IF ifrbde_views.pck_seguranca.stf_permitido (
            p_usuario,
            'CAD_RESUMO_PAGAMENTO',
            'PESQUISA'
         ) THEN
         SELECT num_seq_pag_contrato_rp,
                num_seq_resumo_pag,
                num_seq_entidade_pag,
                cod_tipo_pag_rp,
                TO_CHAR (dat_pagamento, 'DD/MM/YYYY') dat_pagamento,
                TO_CHAR (dat_vencimento_pag, 'DD/MM/YYYY') dat_vencimento_pag,
                num_fatura_rp,
                TO_CHAR (dat_moeda_rp, 'DD/MM/YYYY') dat_moeda_rp,
                val_cotacao_moeda_rp,
                tip_cotacao_moeda_rp,
                val_pagamento_rp,
                val_glosa_rp,
                dsc_glosa_rp,
                val_retencao_rp,
                num_seq_entidade_rp,
                val_multa_rp,
                dsc_retencao_rp,
                val_imposto_irrf_rp,
                val_imposto_iss_rp,
                val_imposto_pasep_rp,
                val_imposto_icms_rp,
                val_imposto_inss_rp,
                val_impostos_rp,
                val_liquido_nota_rp,
                dsc_solicitacao_rp,
                tip_situacao_pag
           INTO vo_num_seq_pag_contrato_rp (1),
                vo_num_seq_resumo_pag (1),
                vo_num_seq_entidade_pag (1),
                vo_cod_tipo_pag_rp (1),
                vo_dat_pagamento (1),
                vo_dat_vencimento_pag (1),
                vo_num_fatura_rp (1),
                vo_dat_moeda_rp (1),
                vo_val_cotacao_moeda_rp (1),
                vo_tip_cotacao_moeda_rp (1),
                vo_val_pagamento_rp (1),
                vo_val_glosa_rp (1),
                vo_dsc_glosa_rp (1),
                vo_val_retencao_rp (1),
                vo_num_seq_entidade_rp (1),
                vo_val_multa_rp (1),
                vo_dsc_retencao_rp (1),
                vo_val_imposto_irrf_rp (1),
                vo_val_imposto_iss_rp (1),
                vo_val_imposto_pasep_rp (1),
                vo_val_imposto_icms_rp (1),
                vo_val_imposto_inss_rp (1),
                vo_val_impostos_rp (1),
                vo_val_liquido_nota_rp (1),
                vo_dsc_solicitacao_rp (1),
                vo_tip_situacao_pag (1)
           FROM ifrbde_views.cad_resumo_pagamento
          WHERE num_seq_pag_contrato_rp = vi_num_seq_pag_contrato_rp
            AND num_seq_resumo_pag = vi_num_seq_resumo_pag;
      END IF;
   EXCEPTION
      WHEN OTHERS THEN
         raise_application_error (-20100, SQLERRM);
   END;

   -- Exclui Solicitação de Pagamento - SP
   -- retorna o OK ou nao
   PROCEDURE stp_exclui_resumo_pagamento (
      p_usuario                             VARCHAR2,
      vo_ok                        OUT      tyt_ok,
      vi_num_seq_pag_contrato_rp   IN       t_num_seq_pag_contrato_rp,
      vi_num_seq_resumo_pag        IN       t_num_seq_resumo_pag
   ) AS
   BEGIN
      vo_ok (1) := 0;

      IF ifrbde_views.pck_seguranca.stf_permitido (
            p_usuario,
            'CAD_RESUMO_PAGAMENTO',
            'EXCLUI'
         ) THEN
         DELETE FROM ifrbde_views.cad_resumo_pagamento
               WHERE num_seq_pag_contrato_rp = vi_num_seq_pag_contrato_rp
                 AND num_seq_resumo_pag = vi_num_seq_resumo_pag;

         IF SQL%ROWCOUNT = 1 THEN
            vo_ok (1) := 1;
            -- LOG
            ifrbde_views.pck_seguranca.stp_log (
               p_usuario,
               'CAD_RESUMO_PAGAMENTO',
               'E',
               TO_CHAR (vi_num_seq_pag_contrato_rp)
               || TO_CHAR (vi_num_seq_resumo_pag)
            );
            COMMIT;
         ELSIF SQL%ROWCOUNT > 1 THEN
            ROLLBACK;
         END IF;
      END IF;
   EXCEPTION
      WHEN OTHERS THEN
         raise_application_error (-20100, SQLERRM);
   END;

   
--------------------------------------------------------------------
-- Inclui Solicitação de Pagamento - SP
-- retorna o recordset correspondente
   PROCEDURE stp_inclui_resumo_pagamento (
      p_usuario                             VARCHAR2,
      vo_num_seq_pag_contrato_rp   OUT      tyt_num_seq_pag_contrato_rp,
      vo_num_seq_resumo_pag        OUT      tyt_num_seq_resumo_pag,
      vo_num_seq_entidade_pag      OUT      tyt_num_seq_entidade_pag,
      vo_cod_tipo_pag_rp           OUT      tyt_cod_tipo_pag_rp,
      vo_dat_pagamento             OUT      tyt_dat_pagamento,
      vo_dat_vencimento_pag        OUT      tyt_dat_vencimento_pag,
      vo_num_fatura_rp             OUT      tyt_num_fatura_rp,
      vo_dat_moeda_rp              OUT      tyt_dat_moeda_rp,
      vo_val_cotacao_moeda_rp      OUT      tyt_val_cotacao_moeda_rp,
      vo_tip_cotacao_moeda_rp      OUT      tyt_tip_cotacao_moeda_rp,
      vo_val_pagamento_rp          OUT      tyt_val_pagamento_rp,
      vo_val_glosa_rp              OUT      tyt_val_glosa_rp,
      vo_dsc_glosa_rp              OUT      tyt_dsc_glosa_rp,
      vo_val_retencao_rp           OUT      tyt_val_retencao_rp,
      vo_num_seq_entidade_rp       OUT      tyt_num_seq_entidade_rp,
      vo_val_multa_rp              OUT      tyt_val_multa_rp,
      vo_dsc_retencao_rp           OUT      tyt_dsc_retencao_rp,
      vo_val_imposto_irrf_rp       OUT      tyt_val_imposto_irrf_rp,
      vo_val_imposto_iss_rp        OUT      tyt_val_imposto_iss_rp,
      vo_val_imposto_pasep_rp      OUT      tyt_val_imposto_pasep_rp,
      vo_val_imposto_icms_rp       OUT      tyt_val_imposto_icms_rp,
      vo_val_imposto_inss_rp       OUT      tyt_val_imposto_inss_rp,
      vo_val_impostos_rp           OUT      tyt_val_impostos_rp,
      vo_val_liquido_nota_rp       OUT      tyt_val_liquido_nota_rp,
      vo_dsc_solicitacao_rp        OUT      tyt_dsc_solicitacao_rp,
      vo_tip_situacao_pag          OUT      tyt_tip_situacao_pag,
      vi_num_seq_pag_contrato_rp   IN       t_num_seq_pag_contrato_rp,
      vi_num_seq_entidade_pag      IN       t_num_seq_entidade_pag,
      vi_cod_tipo_pag_rp           IN       t_cod_tipo_pag_rp,
      vi_dat_pagamento             IN       t_dat_pagamento,
      vi_dat_vencimento_pag        IN       t_dat_vencimento_pag,
      vi_num_fatura_rp             IN       t_num_fatura_rp,
      vi_dat_moeda_rp              IN       t_dat_moeda_rp,
      vi_val_cotacao_moeda_rp      IN       t_val_cotacao_moeda_rp,
      vi_tip_cotacao_moeda_rp      IN       t_tip_cotacao_moeda_rp,
      vi_val_pagamento_rp          IN       t_val_pagamento_rp,
      vi_val_glosa_rp              IN       t_val_glosa_rp,
      vi_dsc_glosa_rp              IN       t_dsc_glosa_rp,
      vi_val_retencao_rp           IN       t_val_retencao_rp,
      vi_num_seq_entidade_rp       IN       t_num_seq_entidade_rp,
      vi_val_multa_rp              IN       t_val_multa_rp,
      vi_dsc_retencao_rp           IN       t_dsc_retencao_rp,
      vi_val_imposto_irrf_rp       IN       t_val_imposto_irrf_rp,
      vi_val_imposto_iss_rp        IN       t_val_imposto_iss_rp,
      vi_val_imposto_pasep_rp      IN       t_val_imposto_pasep_rp,
      vi_val_imposto_icms_rp       IN       t_val_imposto_icms_rp,
      vi_val_imposto_inss_rp       IN       t_val_imposto_inss_rp,
      vi_val_liquido_nota_rp       IN       t_val_liquido_nota_rp,
      vi_dsc_solicitacao_rp        IN       t_dsc_solicitacao_rp,
      vi_tip_situacao_pag          IN       t_tip_situacao_pag
   ) AS
      v_num_seq_pag_contrato_rp     cad_resumo_pagamento.num_seq_pag_contrato_rp%TYPE;
      v_num_seq_resumo_pag          cad_resumo_pagamento.num_seq_resumo_pag%TYPE;
      v_num_seq_entidade_pag        cad_resumo_pagamento.num_seq_entidade_pag%TYPE;
      v_cod_tipo_pag_rp             cad_resumo_pagamento.cod_tipo_pag_rp%TYPE;
      v_dat_pagamento               cad_resumo_pagamento.dat_pagamento%TYPE;
      v_dat_vencimento_pag          cad_resumo_pagamento.dat_vencimento_pag%TYPE;
      v_num_fatura_rp               cad_resumo_pagamento.num_fatura_rp%TYPE;
      v_dat_moeda_rp                cad_resumo_pagamento.dat_moeda_rp%TYPE;
      v_val_cotacao_moeda_rp        cad_resumo_pagamento.val_cotacao_moeda_rp%TYPE;
      v_tip_cotacao_moeda_rp        cad_resumo_pagamento.tip_cotacao_moeda_rp%TYPE;
      v_val_pagamento_rp            cad_resumo_pagamento.val_pagamento_rp%TYPE;
      v_val_glosa_rp                cad_resumo_pagamento.val_glosa_rp%TYPE;
      v_dsc_glosa_rp                cad_resumo_pagamento.dsc_glosa_rp%TYPE;
      v_val_retencao_rp             cad_resumo_pagamento.val_retencao_rp%TYPE;
      v_num_seq_entidade_rp         cad_resumo_pagamento.num_seq_entidade_rp%TYPE;
      v_val_multa_rp                cad_resumo_pagamento.val_multa_rp%TYPE;
      v_dsc_retencao_rp             cad_resumo_pagamento.dsc_retencao_rp%TYPE;
      v_val_imposto_irrf_rp         cad_resumo_pagamento.val_imposto_irrf_rp%TYPE;
      v_val_imposto_iss_rp          cad_resumo_pagamento.val_imposto_iss_rp%TYPE;
      v_val_imposto_pasep_rp        cad_resumo_pagamento.val_imposto_pasep_rp%TYPE;
      v_val_imposto_icms_rp         cad_resumo_pagamento.val_imposto_icms_rp%TYPE;
      v_val_imposto_inss_rp         cad_resumo_pagamento.val_imposto_inss_rp%TYPE;
      v_val_liquido_nota_rp         cad_resumo_pagamento.val_liquido_nota_rp%TYPE;
      v_dsc_solicitacao_rp          cad_resumo_pagamento.dsc_solicitacao_rp%TYPE;
      v_tip_situacao_pag            cad_resumo_pagamento.tip_situacao_pag%TYPE;
   BEGIN
      IF ifrbde_views.pck_seguranca.stf_permitido (
            p_usuario,
            'CAD_RESUMO_PAGAMENTO',
            'INCLUI'
         ) THEN
         SELECT seq_num_seq_contrato.NEXTVAL
           INTO v_num_seq_resumo_pag
           FROM DUAL;

         v_cod_tipo_pag_rp := RTRIM (LTRIM (UPPER (vi_cod_tipo_pag_rp)));
         v_num_fatura_rp := RTRIM (LTRIM (UPPER (vi_num_fatura_rp)));
         v_tip_cotacao_moeda_rp :=
                              RTRIM (LTRIM (UPPER (vi_tip_cotacao_moeda_rp)));
         v_dsc_glosa_rp := RTRIM (LTRIM (UPPER (vi_dsc_glosa_rp)));
         v_dsc_retencao_rp := RTRIM (LTRIM (UPPER (vi_dsc_retencao_rp)));
         v_dsc_solicitacao_rp :=
                                RTRIM (LTRIM (UPPER (vi_dsc_solicitacao_rp)));
         v_tip_situacao_pag := RTRIM (LTRIM (UPPER (vi_tip_situacao_pag)));
         v_dat_pagamento := TO_DATE (vi_dat_pagamento, 'DD/MM/YYYY');
         v_dat_vencimento_pag := TO_DATE (vi_dat_vencimento_pag, 'DD/MM/YYYY');
         v_dat_moeda_rp := TO_DATE (vi_dat_moeda_rp, 'DD/MM/YYYY');
         v_num_seq_pag_contrato_rp := vi_num_seq_pag_contrato_rp;
         v_num_seq_entidade_pag := vi_num_seq_entidade_pag;
         v_val_cotacao_moeda_rp := vi_val_cotacao_moeda_rp;
         v_val_pagamento_rp := vi_val_pagamento_rp;
         v_val_glosa_rp := vi_val_glosa_rp;
         v_val_retencao_rp := vi_val_retencao_rp;
         v_num_seq_entidade_rp := vi_num_seq_entidade_rp;
         v_val_multa_rp := vi_val_multa_rp;
         v_val_imposto_irrf_rp := vi_val_imposto_irrf_rp;
         v_val_imposto_iss_rp := vi_val_imposto_iss_rp;
         v_val_imposto_pasep_rp := vi_val_imposto_pasep_rp;
         v_val_imposto_icms_rp := vi_val_imposto_icms_rp;
         v_val_imposto_inss_rp := vi_val_imposto_inss_rp;
         v_val_liquido_nota_rp := vi_val_liquido_nota_rp;

         INSERT INTO ifrbde_views.cad_resumo_pagamento
                     (num_seq_pag_contrato_rp,
                      num_seq_resumo_pag,
                      num_seq_entidade_pag,
                      cod_tipo_pag_rp,
                      dat_pagamento,
                      dat_vencimento_pag,
                      num_fatura_rp,
                      dat_moeda_rp,
                      val_cotacao_moeda_rp,
                      tip_cotacao_moeda_rp,
                      val_pagamento_rp,
                      val_glosa_rp,
                      dsc_glosa_rp,
                      val_retencao_rp,
                      num_seq_entidade_rp,
                      val_multa_rp,
                      dsc_retencao_rp,
                      val_imposto_irrf_rp,
                      val_imposto_iss_rp,
                      val_imposto_pasep_rp,
                      val_imposto_icms_rp,
                      val_imposto_inss_rp,
                      val_liquido_nota_rp,
                      dsc_solicitacao_rp,
                      tip_situacao_pag
                     )
              VALUES (v_num_seq_pag_contrato_rp,
                      v_num_seq_resumo_pag,
                      v_num_seq_entidade_pag,
                      v_cod_tipo_pag_rp,
                      v_dat_pagamento,
                      v_dat_vencimento_pag,
                      v_num_fatura_rp,
                      v_dat_moeda_rp,
                      v_val_cotacao_moeda_rp,
                      v_tip_cotacao_moeda_rp,
                      v_val_pagamento_rp,
                      v_val_glosa_rp,
                      v_dsc_glosa_rp,
                      v_val_retencao_rp,
                      v_num_seq_entidade_rp,
                      v_val_multa_rp,
                      v_dsc_retencao_rp,
                      v_val_imposto_irrf_rp,
                      v_val_imposto_iss_rp,
                      v_val_imposto_pasep_rp,
                      v_val_imposto_icms_rp,
                      v_val_imposto_inss_rp,
                      v_val_liquido_nota_rp,
                      v_dsc_solicitacao_rp,
                      v_tip_situacao_pag
                     );

         IF SQL%ROWCOUNT = 1 THEN
            stp_pesquisa_resumo_pagamento (
               p_usuario,
               vo_num_seq_pag_contrato_rp,
               vo_num_seq_resumo_pag,
               vo_num_seq_entidade_pag,
               vo_cod_tipo_pag_rp,
               vo_dat_pagamento,
               vo_dat_vencimento_pag,
               vo_num_fatura_rp,
               vo_dat_moeda_rp,
               vo_val_cotacao_moeda_rp,
               vo_tip_cotacao_moeda_rp,
               vo_val_pagamento_rp,
               vo_val_glosa_rp,
               vo_dsc_glosa_rp,
               vo_val_retencao_rp,
               vo_num_seq_entidade_rp,
               vo_val_multa_rp,
               vo_dsc_retencao_rp,
               vo_val_imposto_irrf_rp,
               vo_val_imposto_iss_rp,
               vo_val_imposto_pasep_rp,
               vo_val_imposto_icms_rp,
               vo_val_imposto_inss_rp,
               vo_val_impostos_rp,
               vo_val_liquido_nota_rp,
               vo_dsc_solicitacao_rp,
               vo_tip_situacao_pag,
               v_num_seq_pag_contrato_rp,
               v_num_seq_resumo_pag
            );
            -- LOG
            ifrbde_views.pck_seguranca.stp_log (
               p_usuario,
               'CAD_RESUMO_PAGAMENTO',
               'I',
               TO_CHAR (vi_num_seq_pag_contrato_rp)
               || TO_CHAR (v_num_seq_resumo_pag)
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
-- Altera Solicitação de Pagamento - SP
-- retorna o recordset correspondente
   PROCEDURE stp_altera_resumo_pagamento (
      p_usuario                             VARCHAR2,
      vo_num_seq_pag_contrato_rp   OUT      tyt_num_seq_pag_contrato_rp,
      vo_num_seq_resumo_pag        OUT      tyt_num_seq_resumo_pag,
      vo_num_seq_entidade_pag      OUT      tyt_num_seq_entidade_pag,
      vo_cod_tipo_pag_rp           OUT      tyt_cod_tipo_pag_rp,
      vo_dat_pagamento             OUT      tyt_dat_pagamento,
      vo_dat_vencimento_pag        OUT      tyt_dat_vencimento_pag,
      vo_num_fatura_rp             OUT      tyt_num_fatura_rp,
      vo_dat_moeda_rp              OUT      tyt_dat_moeda_rp,
      vo_val_cotacao_moeda_rp      OUT      tyt_val_cotacao_moeda_rp,
      vo_tip_cotacao_moeda_rp      OUT      tyt_tip_cotacao_moeda_rp,
      vo_val_pagamento_rp          OUT      tyt_val_pagamento_rp,
      vo_val_glosa_rp              OUT      tyt_val_glosa_rp,
      vo_dsc_glosa_rp              OUT      tyt_dsc_glosa_rp,
      vo_val_retencao_rp           OUT      tyt_val_retencao_rp,
      vo_num_seq_entidade_rp       OUT      tyt_num_seq_entidade_rp,
      vo_val_multa_rp              OUT      tyt_val_multa_rp,
      vo_dsc_retencao_rp           OUT      tyt_dsc_retencao_rp,
      vo_val_imposto_irrf_rp       OUT      tyt_val_imposto_irrf_rp,
      vo_val_imposto_iss_rp        OUT      tyt_val_imposto_iss_rp,
      vo_val_imposto_pasep_rp      OUT      tyt_val_imposto_pasep_rp,
      vo_val_imposto_icms_rp       OUT      tyt_val_imposto_icms_rp,
      vo_val_imposto_inss_rp       OUT      tyt_val_imposto_inss_rp,
      vo_val_impostos_rp           OUT      tyt_val_impostos_rp,
      vo_val_liquido_nota_rp       OUT      tyt_val_liquido_nota_rp,
      vo_dsc_solicitacao_rp        OUT      tyt_dsc_solicitacao_rp,
      vo_tip_situacao_pag          OUT      tyt_tip_situacao_pag,
      vi_num_seq_pag_contrato_rp   IN       t_num_seq_pag_contrato_rp,
      vi_num_seq_resumo_pag        IN       t_num_seq_resumo_pag,
      vi_num_seq_entidade_pag      IN       t_num_seq_entidade_pag,
      vi_cod_tipo_pag_rp           IN       t_cod_tipo_pag_rp,
      vi_dat_pagamento             IN       t_dat_pagamento,
      vi_dat_vencimento_pag        IN       t_dat_vencimento_pag,
      vi_num_fatura_rp             IN       t_num_fatura_rp,
      vi_dat_moeda_rp              IN       t_dat_moeda_rp,
      vi_val_cotacao_moeda_rp      IN       t_val_cotacao_moeda_rp,
      vi_tip_cotacao_moeda_rp      IN       t_tip_cotacao_moeda_rp,
      vi_val_pagamento_rp          IN       t_val_pagamento_rp,
      vi_val_glosa_rp              IN       t_val_glosa_rp,
      vi_dsc_glosa_rp              IN       t_dsc_glosa_rp,
      vi_val_retencao_rp           IN       t_val_retencao_rp,
      vi_num_seq_entidade_rp       IN       t_num_seq_entidade_rp,
      vi_val_multa_rp              IN       t_val_multa_rp,
      vi_dsc_retencao_rp           IN       t_dsc_retencao_rp,
      vi_val_imposto_irrf_rp       IN       t_val_imposto_irrf_rp,
      vi_val_imposto_iss_rp        IN       t_val_imposto_iss_rp,
      vi_val_imposto_pasep_rp      IN       t_val_imposto_pasep_rp,
      vi_val_imposto_icms_rp       IN       t_val_imposto_icms_rp,
      vi_val_imposto_inss_rp       IN       t_val_imposto_inss_rp,
      vi_val_liquido_nota_rp       IN       t_val_liquido_nota_rp,
      vi_dsc_solicitacao_rp        IN       t_dsc_solicitacao_rp,
      vi_tip_situacao_pag          IN       t_tip_situacao_pag
   ) AS
      CURSOR c_cursor IS
         SELECT     *
               FROM ifrbde_views.cad_resumo_pagamento
              WHERE num_seq_pag_contrato_rp = vi_num_seq_pag_contrato_rp
                AND num_seq_resumo_pag = vi_num_seq_resumo_pag
         FOR UPDATE;

      v_cad_resumo_pagamento        ifrbde_views.cad_resumo_pagamento%ROWTYPE;
      v_num_seq_pag_contrato_rp     ifrbde_views.cad_resumo_pagamento.num_seq_pag_contrato_rp%TYPE;
      v_num_seq_resumo_pag          ifrbde_views.cad_resumo_pagamento.num_seq_resumo_pag%TYPE;
      v_num_seq_entidade_pag        ifrbde_views.cad_resumo_pagamento.num_seq_entidade_pag%TYPE;
      v_cod_tipo_pag_rp             ifrbde_views.cad_resumo_pagamento.cod_tipo_pag_rp%TYPE;
      v_dat_pagamento               ifrbde_views.cad_resumo_pagamento.dat_pagamento%TYPE;
      v_dat_vencimento_pag          ifrbde_views.cad_resumo_pagamento.dat_vencimento_pag%TYPE;
      v_num_fatura_rp               ifrbde_views.cad_resumo_pagamento.num_fatura_rp%TYPE;
      v_dat_moeda_rp                ifrbde_views.cad_resumo_pagamento.dat_moeda_rp%TYPE;
      v_val_cotacao_moeda_rp        ifrbde_views.cad_resumo_pagamento.val_cotacao_moeda_rp%TYPE;
      v_tip_cotacao_moeda_rp        ifrbde_views.cad_resumo_pagamento.tip_cotacao_moeda_rp%TYPE;
      v_val_pagamento_rp            ifrbde_views.cad_resumo_pagamento.val_pagamento_rp%TYPE;
      v_val_glosa_rp                ifrbde_views.cad_resumo_pagamento.val_glosa_rp%TYPE;
      v_dsc_glosa_rp                ifrbde_views.cad_resumo_pagamento.dsc_glosa_rp%TYPE;
      v_val_retencao_rp             ifrbde_views.cad_resumo_pagamento.val_retencao_rp%TYPE;
      v_num_seq_entidade_rp         ifrbde_views.cad_resumo_pagamento.num_seq_entidade_rp%TYPE;
      v_val_multa_rp                ifrbde_views.cad_resumo_pagamento.val_multa_rp%TYPE;
      v_dsc_retencao_rp             ifrbde_views.cad_resumo_pagamento.dsc_retencao_rp%TYPE;
      v_val_imposto_irrf_rp         ifrbde_views.cad_resumo_pagamento.val_imposto_irrf_rp%TYPE;
      v_val_imposto_iss_rp          ifrbde_views.cad_resumo_pagamento.val_imposto_iss_rp%TYPE;
      v_val_imposto_pasep_rp        ifrbde_views.cad_resumo_pagamento.val_imposto_pasep_rp%TYPE;
      v_val_imposto_icms_rp         ifrbde_views.cad_resumo_pagamento.val_imposto_icms_rp%TYPE;
      v_val_imposto_inss_rp         ifrbde_views.cad_resumo_pagamento.val_imposto_inss_rp%TYPE;
      v_val_liquido_nota_rp         ifrbde_views.cad_resumo_pagamento.val_liquido_nota_rp%TYPE;
      v_dsc_solicitacao_rp          ifrbde_views.cad_resumo_pagamento.dsc_solicitacao_rp%TYPE;
      v_tip_situacao_pag            ifrbde_views.cad_resumo_pagamento.tip_situacao_pag%TYPE;
   BEGIN
      IF ifrbde_views.pck_seguranca.stf_permitido (
            p_usuario,
            'CAD_RESUMO_PAGAMENTO',
            'ALTERA'
         ) THEN
         OPEN c_cursor;
         FETCH c_cursor INTO v_cad_resumo_pagamento;

         IF NOT c_cursor%NOTFOUND THEN
            v_cod_tipo_pag_rp := RTRIM (LTRIM (UPPER (vi_cod_tipo_pag_rp)));
            v_num_fatura_rp := RTRIM (LTRIM (UPPER (vi_num_fatura_rp)));
            v_tip_cotacao_moeda_rp :=
                              RTRIM (LTRIM (UPPER (vi_tip_cotacao_moeda_rp)));
            v_dsc_glosa_rp := RTRIM (LTRIM (UPPER (vi_dsc_glosa_rp)));
            v_dsc_retencao_rp := RTRIM (LTRIM (UPPER (vi_dsc_retencao_rp)));
            v_dsc_solicitacao_rp :=
                                RTRIM (LTRIM (UPPER (vi_dsc_solicitacao_rp)));
            v_tip_situacao_pag := RTRIM (LTRIM (UPPER (vi_tip_situacao_pag)));
            v_dat_pagamento := TO_DATE (vi_dat_pagamento, 'DD/MM/YYYY');
            v_dat_vencimento_pag :=
                                 TO_DATE (vi_dat_vencimento_pag, 'DD/MM/YYYY');
            v_dat_moeda_rp := TO_DATE (vi_dat_moeda_rp, 'DD/MM/YYYY');
            v_num_seq_pag_contrato_rp := vi_num_seq_pag_contrato_rp;
            v_num_seq_entidade_pag := vi_num_seq_entidade_pag;
            v_val_cotacao_moeda_rp := vi_val_cotacao_moeda_rp;
            v_val_pagamento_rp := vi_val_pagamento_rp;
            v_val_glosa_rp := vi_val_glosa_rp;
            v_val_retencao_rp := vi_val_retencao_rp;
            v_num_seq_entidade_rp := vi_num_seq_entidade_rp;
            v_val_multa_rp := vi_val_multa_rp;
            v_val_imposto_irrf_rp := vi_val_imposto_irrf_rp;
            v_val_imposto_iss_rp := vi_val_imposto_iss_rp;
            v_val_imposto_pasep_rp := vi_val_imposto_pasep_rp;
            v_val_imposto_icms_rp := vi_val_imposto_icms_rp;
            v_val_imposto_inss_rp := vi_val_imposto_inss_rp;
            v_val_liquido_nota_rp := vi_val_liquido_nota_rp;

            UPDATE ifrbde_views.cad_resumo_pagamento
               SET num_seq_entidade_pag = v_num_seq_entidade_pag,
                   cod_tipo_pag_rp = v_cod_tipo_pag_rp,
                   dat_pagamento = v_dat_pagamento,
                   dat_vencimento_pag = v_dat_vencimento_pag,
                   num_fatura_rp = v_num_fatura_rp,
                   dat_moeda_rp = v_dat_moeda_rp,
                   val_cotacao_moeda_rp = v_val_cotacao_moeda_rp,
                   tip_cotacao_moeda_rp = v_tip_cotacao_moeda_rp,
                   val_pagamento_rp = v_val_pagamento_rp,
                   val_glosa_rp = v_val_glosa_rp,
                   dsc_glosa_rp = v_dsc_glosa_rp,
                   val_retencao_rp = v_val_retencao_rp,
                   num_seq_entidade_rp = v_num_seq_entidade_rp,
                   val_multa_rp = v_val_multa_rp,
                   dsc_retencao_rp = v_dsc_retencao_rp,
                   val_imposto_irrf_rp = v_val_imposto_irrf_rp,
                   val_imposto_iss_rp = v_val_imposto_iss_rp,
                   val_imposto_pasep_rp = v_val_imposto_pasep_rp,
                   val_imposto_icms_rp = v_val_imposto_icms_rp,
                   val_imposto_inss_rp = v_val_imposto_inss_rp,
                   val_liquido_nota_rp = v_val_liquido_nota_rp,
                   dsc_solicitacao_rp = v_dsc_solicitacao_rp,
                   tip_situacao_pag = v_tip_situacao_pag
             WHERE  CURRENT OF c_cursor;

            IF SQL%ROWCOUNT = 1 THEN
               IF v_cad_resumo_pagamento.tip_situacao_pag = 1 THEN
                  ifrbde.prc_conf_sol_pag_header_u (vi_num_seq_resumo_pag);
                  ifrbde.prc_conf_sol_pag_valor_u (vi_num_seq_resumo_pag);
                  ifrbde.prc_conf_sol_pag_acr_ret_u (vi_num_seq_resumo_pag);
                  ifrbde.prc_conf_sol_pag_outros_u (vi_num_seq_resumo_pag);
               END IF;

               stp_pesquisa_resumo_pagamento (
                  p_usuario,
                  vo_num_seq_pag_contrato_rp,
                  vo_num_seq_resumo_pag,
                  vo_num_seq_entidade_pag,
                  vo_cod_tipo_pag_rp,
                  vo_dat_pagamento,
                  vo_dat_vencimento_pag,
                  vo_num_fatura_rp,
                  vo_dat_moeda_rp,
                  vo_val_cotacao_moeda_rp,
                  vo_tip_cotacao_moeda_rp,
                  vo_val_pagamento_rp,
                  vo_val_glosa_rp,
                  vo_dsc_glosa_rp,
                  vo_val_retencao_rp,
                  vo_num_seq_entidade_rp,
                  vo_val_multa_rp,
                  vo_dsc_retencao_rp,
                  vo_val_imposto_irrf_rp,
                  vo_val_imposto_iss_rp,
                  vo_val_imposto_pasep_rp,
                  vo_val_imposto_icms_rp,
                  vo_val_imposto_inss_rp,
                  vo_val_impostos_rp,
                  vo_val_liquido_nota_rp,
                  vo_dsc_solicitacao_rp,
                  vo_tip_situacao_pag,
                  vi_num_seq_pag_contrato_rp,
                  vi_num_seq_resumo_pag
               );
               -- LOG
               ifrbde_views.pck_seguranca.stp_log (
                  p_usuario,
                  'CAD_RESUMO_PAGAMENTO',
                  'A',
                  TO_CHAR (vi_num_seq_pag_contrato_rp)
                  || TO_CHAR (vi_num_seq_resumo_pag)
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
-- Pesquisa Cadastro de Contratos
-- retorna o recordset correspondente
   PROCEDURE stp_pesquisa_contrato (
      p_usuario                              VARCHAR2,
      vo_num_seq_contrato           OUT      tyt_num_seq_contrato,
      vo_cnt_cre_cod                OUT      tyt_cnt_cre_cod,
      vo_cnt_cod                    OUT      tyt_cnt_cod,
      vo_num_versao_contrato        OUT      tyt_num_versao_contrato,
      vo_num_termo_aditivo          OUT      tyt_num_termo_aditivo,
      vo_cod_dep_contrato           OUT      tyt_cod_dep_contrato,
      vo_cnt_justificativa_cre      OUT      tyt_cnt_justificativa_cre,
      vo_num_seq_gestor             OUT      tyt_num_seq_gestor,
      vo_num_seq_assinatura_1       OUT      tyt_num_seq_assinatura_1,
      vo_num_seq_assinatura_2       OUT      tyt_num_seq_assinatura_2,
      vo_num_ato_administrativo     OUT      tyt_num_ato_administrativo,
      vo_cnt_cei                    OUT      tyt_cnt_cei,
      vo_cnt_crea                   OUT      tyt_cnt_crea,
      vo_cnt_ice_cod                OUT      tyt_cnt_ice_cod,
      vo_cnt_data                   OUT      tyt_cnt_data,
      vo_cnt_data_proposta          OUT      tyt_cnt_data_proposta,
      vo_cnt_data_inicio            OUT      tyt_cnt_data_inicio,
      vo_cnt_prazo_exec             OUT      tyt_cnt_prazo_exec,
      vo_num_prazo_exec_meses       OUT      tyt_num_prazo_exec_meses,
      vo_cnt_prazo_adit             OUT      tyt_cnt_prazo_adit,
      vo_dat_termino_contrato       OUT      tyt_dat_termino_contrato,
      vo_dat_publicacao             OUT      tyt_dat_publicacao,
      vo_num_dou_publicacao         OUT      tyt_num_dou_publicacao,
      vo_num_pagina_publicacao      OUT      tyt_num_pagina_publicacao,
      vo_num_secao_publicacao       OUT      tyt_num_secao_publicacao,
      vo_cod_modalidade_licitacao   OUT      tyt_cod_modalidade_licitacao,
      vo_num_inciso                 OUT      tyt_num_inciso,
      vo_dsc_fundamento_legal       OUT      tyt_dsc_fundamento_legal,
      vo_num_licitacao              OUT      tyt_num_licitacao,
      vo_num_ano_licitacao          OUT      tyt_num_ano_licitacao,
      vo_num_processo               OUT      tyt_num_processo,
      vo_cnt_valor_compromisso      OUT      tyt_cnt_valor_compromisso,
      vo_cnt_valor_termo            OUT      tyt_cnt_valor_termo,
      vo_cnt_valor_pago             OUT      tyt_cnt_valor_pago,
      vo_cnt_valor_reaj             OUT      tyt_cnt_valor_reaj,
      vo_cnt_valor_reaj_pago        OUT      tyt_cnt_valor_reaj_pago,
      vo_cnt_valor                  OUT      tyt_cnt_valor,
      vo_tip_situacao_contrato      OUT      tyt_tip_situacao_contrato,
      vo_tip_contrato               OUT      tyt_tip_contrato,
      vo_dsc_critica_contrato       OUT      tyt_dsc_critica_contrato,
      vi_num_seq_contrato           IN       t_num_seq_contrato,
      vi_cnt_cre_cod                IN       t_cnt_cre_cod
   ) AS
   BEGIN
      IF ifrbde_views.pck_seguranca.stf_permitido (
            p_usuario,
            'TAB_CONTRATO',
            'PESQUISA'
         ) THEN
         SELECT num_seq_contrato,
                cnt_cre_cod,
                cnt_cod,
                num_versao_contrato,
                num_termo_aditivo,
                cod_dep_contrato,
                cnt_justificativa_cre,
                num_seq_gestor,
                num_seq_assinatura_1,
                num_seq_assinatura_2,
                num_ato_administrativo,
                cnt_cei,
                cnt_crea,
                cnt_ice_cod,
                TO_CHAR (cnt_data, 'DD/MM/YYYY') cnt_data,
                TO_CHAR (cnt_data_proposta, 'DD/MM/YYYY') cnt_data_proposta,
                TO_CHAR (cnt_data_inicio, 'DD/MM/YYYY') cnt_data_inicio,
                cnt_prazo_exec,
                num_prazo_exec_meses,
                cnt_prazo_adit,
                TO_CHAR (dat_termino_contrato, 'DD/MM/YYYY') dat_termino_contrato,
                TO_CHAR (dat_publicacao, 'DD/MM/YYYY') dat_publicacao,
                num_dou_publicacao,
                num_pagina_publicacao,
                num_secao_publicacao,
                cod_modalidade_licitacao,
                num_inciso,
                dsc_fundamento_legal,
                num_licitacao,
                num_ano_licitacao,
                num_processo,
                cnt_valor_compromisso,
                cnt_valor_termo,
                cnt_valor_pago,
                cnt_valor_reaj,
                cnt_valor_reaj_pago,
                cnt_valor,
                tip_situacao_contrato,
                tip_contrato,
                dsc_critica_contrato
           INTO vo_num_seq_contrato (1),
                vo_cnt_cre_cod (1),
                vo_cnt_cod (1),
                vo_num_versao_contrato (1),
                vo_num_termo_aditivo (1),
                vo_cod_dep_contrato (1),
                vo_cnt_justificativa_cre (1),
                vo_num_seq_gestor (1),
                vo_num_seq_assinatura_1 (1),
                vo_num_seq_assinatura_2 (1),
                vo_num_ato_administrativo (1),
                vo_cnt_cei (1),
                vo_cnt_crea (1),
                vo_cnt_ice_cod (1),
                vo_cnt_data (1),
                vo_cnt_data_proposta (1),
                vo_cnt_data_inicio (1),
                vo_cnt_prazo_exec (1),
                vo_num_prazo_exec_meses (1),
                vo_cnt_prazo_adit (1),
                vo_dat_termino_contrato (1),
                vo_dat_publicacao (1),
                vo_num_dou_publicacao (1),
                vo_num_pagina_publicacao (1),
                vo_num_secao_publicacao (1),
                vo_cod_modalidade_licitacao (1),
                vo_num_inciso (1),
                vo_dsc_fundamento_legal (1),
                vo_num_licitacao (1),
                vo_num_ano_licitacao (1),
                vo_num_processo (1),
                vo_cnt_valor_compromisso (1),
                vo_cnt_valor_termo (1),
                vo_cnt_valor_pago (1),
                vo_cnt_valor_reaj (1),
                vo_cnt_valor_reaj_pago (1),
                vo_cnt_valor (1),
                vo_tip_situacao_contrato (1),
                vo_tip_contrato (1),
                vo_dsc_critica_contrato (1)
           FROM ifrbde_views.tab_contrato
          WHERE num_seq_contrato = vi_num_seq_contrato
            AND cnt_cre_cod = vi_cnt_cre_cod;
      END IF;
   EXCEPTION
      WHEN OTHERS THEN
         raise_application_error (-20100, SQLERRM);
   END;

   -- Exclui Cadastro de Contratos
   -- retorna o OK ou nao
   PROCEDURE stp_exclui_contrato (
      p_usuario                      VARCHAR2,
      vo_ok                 OUT      tyt_ok,
      vi_num_seq_contrato   IN       t_num_seq_contrato,
      vi_cnt_cre_cod        IN       t_cnt_cre_cod
   ) AS
   BEGIN
      vo_ok (1) := 0;

      IF ifrbde_views.pck_seguranca.stf_permitido (
            p_usuario,
            'TAB_CONTRATO',
            'EXCLUI'
         ) THEN
         DELETE FROM ifrbde_views.tab_contrato
               WHERE num_seq_contrato = vi_num_seq_contrato
                 AND cnt_cre_cod = vi_cnt_cre_cod;

         IF SQL%ROWCOUNT = 1 THEN
            vo_ok (1) := 1;
            -- LOG
            ifrbde_views.pck_seguranca.stp_log (
               p_usuario,
               'TAB_CONTRATO',
               'E',
               TO_CHAR (vi_num_seq_contrato) || TO_CHAR (vi_cnt_cre_cod)
            );
            COMMIT;
         ELSIF SQL%ROWCOUNT > 1 THEN
            ROLLBACK;
         END IF;
      END IF;
   EXCEPTION
      WHEN OTHERS THEN
         raise_application_error (-20100, SQLERRM);
   END;

   
--------------------------------------------------------------------
-- Inclui Cadastro de Contratos
-- retorna o recordset correspondente
   PROCEDURE stp_inclui_contrato (
      p_usuario                              VARCHAR2,
      vo_num_seq_contrato           OUT      tyt_num_seq_contrato,
      vo_cnt_cre_cod                OUT      tyt_cnt_cre_cod,
      vo_cnt_cod                    OUT      tyt_cnt_cod,
      vo_num_versao_contrato        OUT      tyt_num_versao_contrato,
      vo_num_termo_aditivo          OUT      tyt_num_termo_aditivo,
      vo_cod_dep_contrato           OUT      tyt_cod_dep_contrato,
      vo_cnt_justificativa_cre      OUT      tyt_cnt_justificativa_cre,
      vo_num_seq_gestor             OUT      tyt_num_seq_gestor,
      vo_num_seq_assinatura_1       OUT      tyt_num_seq_assinatura_1,
      vo_num_seq_assinatura_2       OUT      tyt_num_seq_assinatura_2,
      vo_num_ato_administrativo     OUT      tyt_num_ato_administrativo,
      vo_cnt_cei                    OUT      tyt_cnt_cei,
      vo_cnt_crea                   OUT      tyt_cnt_crea,
      vo_cnt_ice_cod                OUT      tyt_cnt_ice_cod,
      vo_cnt_data                   OUT      tyt_cnt_data,
      vo_cnt_data_proposta          OUT      tyt_cnt_data_proposta,
      vo_cnt_data_inicio            OUT      tyt_cnt_data_inicio,
      vo_cnt_prazo_exec             OUT      tyt_cnt_prazo_exec,
      vo_num_prazo_exec_meses       OUT      tyt_num_prazo_exec_meses,
      vo_cnt_prazo_adit             OUT      tyt_cnt_prazo_adit,
      vo_dat_termino_contrato       OUT      tyt_dat_termino_contrato,
      vo_dat_publicacao             OUT      tyt_dat_publicacao,
      vo_num_dou_publicacao         OUT      tyt_num_dou_publicacao,
      vo_num_pagina_publicacao      OUT      tyt_num_pagina_publicacao,
      vo_num_secao_publicacao       OUT      tyt_num_secao_publicacao,
      vo_cod_modalidade_licitacao   OUT      tyt_cod_modalidade_licitacao,
      vo_num_inciso                 OUT      tyt_num_inciso,
      vo_dsc_fundamento_legal       OUT      tyt_dsc_fundamento_legal,
      vo_num_licitacao              OUT      tyt_num_licitacao,
      vo_num_ano_licitacao          OUT      tyt_num_ano_licitacao,
      vo_num_processo               OUT      tyt_num_processo,
      vo_cnt_valor_compromisso      OUT      tyt_cnt_valor_compromisso,
      vo_cnt_valor_termo            OUT      tyt_cnt_valor_termo,
      vo_cnt_valor_pago             OUT      tyt_cnt_valor_pago,
      vo_cnt_valor_reaj             OUT      tyt_cnt_valor_reaj,
      vo_cnt_valor_reaj_pago        OUT      tyt_cnt_valor_reaj_pago,
      vo_cnt_valor                  OUT      tyt_cnt_valor,
      vo_tip_situacao_contrato      OUT      tyt_tip_situacao_contrato,
      vo_tip_contrato               OUT      tyt_tip_contrato,
      vo_dsc_critica_contrato       OUT      tyt_dsc_critica_contrato,
      vi_cnt_cre_cod                IN       t_cnt_cre_cod,
      vi_cnt_cod                    IN       t_cnt_cod,
      vi_num_versao_contrato        IN       t_num_versao_contrato,
      vi_cod_dep_contrato           IN       t_cod_dep_contrato,
      vi_cnt_justificativa_cre      IN       t_cnt_justificativa_cre,
      vi_num_seq_gestor             IN       t_num_seq_gestor,
      vi_num_seq_assinatura_1       IN       t_num_seq_assinatura_1,
      vi_num_seq_assinatura_2       IN       t_num_seq_assinatura_2,
      vi_num_ato_administrativo     IN       t_num_ato_administrativo,
      vi_cnt_cei                    IN       t_cnt_cei,
      vi_cnt_crea                   IN       t_cnt_crea,
      vi_cnt_ice_cod                IN       t_cnt_ice_cod,
      vi_cnt_data                   IN       t_cnt_data,
      vi_cnt_data_proposta          IN       t_cnt_data_proposta,
      vi_cnt_data_inicio            IN       t_cnt_data_inicio,
      vi_cnt_prazo_exec             IN       t_cnt_prazo_exec,
      vi_num_prazo_exec_meses       IN       t_num_prazo_exec_meses,
      vi_dat_publicacao             IN       t_dat_publicacao,
      vi_num_dou_publicacao         IN       t_num_dou_publicacao,
      vi_num_pagina_publicacao      IN       t_num_pagina_publicacao,
      vi_num_secao_publicacao       IN       t_num_secao_publicacao,
      vi_cod_modalidade_licitacao   IN       t_cod_modalidade_licitacao,
      vi_num_inciso                 IN       t_num_inciso,
      vi_dsc_fundamento_legal       IN       t_dsc_fundamento_legal,
      vi_num_licitacao              IN       t_num_licitacao,
      vi_num_ano_licitacao          IN       t_num_ano_licitacao,
      vi_num_processo               IN       t_num_processo,
      vi_tip_situacao_contrato      IN       t_tip_situacao_contrato
   ) AS
      v_num_seq_contrato            tab_contrato.num_seq_contrato%TYPE;
      v_cnt_cre_cod                 tab_contrato.cnt_cre_cod%TYPE;
      v_cnt_cod                     tab_contrato.cnt_cod%TYPE;
      v_num_versao_contrato         tab_contrato.num_versao_contrato%TYPE;
      v_cod_dep_contrato            tab_contrato.cod_dep_contrato%TYPE;
      v_cnt_justificativa_cre       tab_contrato.cnt_justificativa_cre%TYPE;
      v_num_seq_gestor              tab_contrato.num_seq_gestor%TYPE;
      v_num_seq_assinatura_1        tab_contrato.num_seq_assinatura_1%TYPE;
      v_num_seq_assinatura_2        tab_contrato.num_seq_assinatura_2%TYPE;
      v_num_ato_administrativo      tab_contrato.num_ato_administrativo%TYPE;
      v_cnt_cei                     tab_contrato.cnt_cei%TYPE;
      v_cnt_crea                    tab_contrato.cnt_crea%TYPE;
      v_cnt_ice_cod                 tab_contrato.cnt_ice_cod%TYPE;
      v_cnt_data                    tab_contrato.cnt_data%TYPE;
      v_cnt_data_proposta           tab_contrato.cnt_data_proposta%TYPE;
      v_cnt_data_inicio             tab_contrato.cnt_data_inicio%TYPE;
      v_cnt_prazo_exec              tab_contrato.cnt_prazo_exec%TYPE;
      v_num_prazo_exec_meses        tab_contrato.num_prazo_exec_meses%TYPE;
      v_dat_publicacao              tab_contrato.dat_publicacao%TYPE;
      v_num_dou_publicacao          tab_contrato.num_dou_publicacao%TYPE;
      v_num_pagina_publicacao       tab_contrato.num_pagina_publicacao%TYPE;
      v_num_secao_publicacao        tab_contrato.num_secao_publicacao%TYPE;
      v_cod_modalidade_licitacao    tab_contrato.cod_modalidade_licitacao%TYPE;
      v_num_inciso                  tab_contrato.num_inciso%TYPE;
      v_dsc_fundamento_legal        tab_contrato.dsc_fundamento_legal%TYPE;
      v_num_licitacao               tab_contrato.num_licitacao%TYPE;
      v_num_ano_licitacao           tab_contrato.num_ano_licitacao%TYPE;
      v_num_processo                tab_contrato.num_processo%TYPE;
      v_tip_situacao_contrato       tab_contrato.tip_situacao_contrato%TYPE;
   BEGIN
      IF ifrbde_views.pck_seguranca.stf_permitido (
            p_usuario,
            'TAB_CONTRATO',
            'INCLUI'
         ) THEN
         SELECT seq_num_seq_contrato.NEXTVAL
           INTO v_num_seq_contrato
           FROM DUAL;

         v_cnt_cod := RTRIM (LTRIM (UPPER (vi_cnt_cod)));
         v_num_versao_contrato :=
                               RTRIM (LTRIM (UPPER (vi_num_versao_contrato)));
         v_cnt_justificativa_cre :=
                             RTRIM (LTRIM (UPPER (vi_cnt_justificativa_cre)));
         v_num_ato_administrativo :=
                            RTRIM (LTRIM (UPPER (vi_num_ato_administrativo)));
         v_cnt_cei := RTRIM (LTRIM (UPPER (vi_cnt_cei)));
         v_cnt_crea := RTRIM (LTRIM (UPPER (vi_cnt_crea)));
         v_cnt_ice_cod := RTRIM (LTRIM (UPPER (vi_cnt_ice_cod)));
         v_num_dou_publicacao :=
                                RTRIM (LTRIM (UPPER (vi_num_dou_publicacao)));
         v_num_pagina_publicacao :=
                             RTRIM (LTRIM (UPPER (vi_num_pagina_publicacao)));
         v_num_secao_publicacao :=
                              RTRIM (LTRIM (UPPER (vi_num_secao_publicacao)));
         v_cod_modalidade_licitacao :=
                          RTRIM (LTRIM (UPPER (vi_cod_modalidade_licitacao)));
         v_dsc_fundamento_legal :=
                              RTRIM (LTRIM (UPPER (vi_dsc_fundamento_legal)));
         v_num_licitacao := RTRIM (LTRIM (UPPER (vi_num_licitacao)));
         v_num_processo := RTRIM (LTRIM (UPPER (vi_num_processo)));
         v_cnt_data := TO_DATE (vi_cnt_data, 'DD/MM/YYYY');
         v_cnt_data_proposta := TO_DATE (vi_cnt_data_proposta, 'DD/MM/YYYY');
         v_cnt_data_inicio := TO_DATE (vi_cnt_data_inicio, 'DD/MM/YYYY');
         v_dat_publicacao := TO_DATE (vi_dat_publicacao, 'DD/MM/YYYY');
         v_cnt_cre_cod := vi_cnt_cre_cod;
         v_cod_dep_contrato := vi_cod_dep_contrato;
         v_num_seq_gestor := vi_num_seq_gestor;
         v_num_seq_assinatura_1 := vi_num_seq_assinatura_1;
         v_num_seq_assinatura_2 := vi_num_seq_assinatura_2;
         v_cnt_prazo_exec := vi_cnt_prazo_exec;
         v_num_prazo_exec_meses := vi_num_prazo_exec_meses;
         v_num_inciso := vi_num_inciso;
         v_num_ano_licitacao := vi_num_ano_licitacao;
         v_tip_situacao_contrato := vi_tip_situacao_contrato;

         INSERT INTO ifrbde_views.tab_contrato
                     (num_seq_contrato,
                      cnt_cre_cod,
                      cnt_cod,
                      num_versao_contrato,
                      cod_dep_contrato,
                      cnt_justificativa_cre,
                      num_seq_gestor,
                      num_seq_assinatura_1,
                      num_seq_assinatura_2,
                      num_ato_administrativo,
                      cnt_cei,
                      cnt_crea,
                      cnt_ice_cod,
                      cnt_data,
                      cnt_data_proposta,
                      cnt_data_inicio,
                      cnt_prazo_exec,
                      num_prazo_exec_meses,
                      dat_publicacao,
                      num_dou_publicacao,
                      num_pagina_publicacao,
                      num_secao_publicacao,
                      cod_modalidade_licitacao,
                      num_inciso,
                      dsc_fundamento_legal,
                      num_licitacao,
                      num_ano_licitacao,
                      num_processo,
                      tip_situacao_contrato
                     )
              VALUES (v_num_seq_contrato,
                      v_cnt_cre_cod,
                      v_cnt_cod,
                      v_num_versao_contrato,
                      v_cod_dep_contrato,
                      v_cnt_justificativa_cre,
                      v_num_seq_gestor,
                      v_num_seq_assinatura_1,
                      v_num_seq_assinatura_2,
                      v_num_ato_administrativo,
                      v_cnt_cei,
                      v_cnt_crea,
                      v_cnt_ice_cod,
                      v_cnt_data,
                      v_cnt_data_proposta,
                      v_cnt_data_inicio,
                      v_cnt_prazo_exec,
                      v_num_prazo_exec_meses,
                      v_dat_publicacao,
                      v_num_dou_publicacao,
                      v_num_pagina_publicacao,
                      v_num_secao_publicacao,
                      v_cod_modalidade_licitacao,
                      v_num_inciso,
                      v_dsc_fundamento_legal,
                      v_num_licitacao,
                      v_num_ano_licitacao,
                      v_num_processo,
                      v_tip_situacao_contrato
                     );

         ifrbde.prc_critica_contrato (v_num_seq_contrato);

         IF SQL%ROWCOUNT = 1 THEN
            stp_pesquisa_contrato (
               p_usuario,
               vo_num_seq_contrato,
               vo_cnt_cre_cod,
               vo_cnt_cod,
               vo_num_versao_contrato,
               vo_num_termo_aditivo,
               vo_cod_dep_contrato,
               vo_cnt_justificativa_cre,
               vo_num_seq_gestor,
               vo_num_seq_assinatura_1,
               vo_num_seq_assinatura_2,
               vo_num_ato_administrativo,
               vo_cnt_cei,
               vo_cnt_crea,
               vo_cnt_ice_cod,
               vo_cnt_data,
               vo_cnt_data_proposta,
               vo_cnt_data_inicio,
               vo_cnt_prazo_exec,
               vo_num_prazo_exec_meses,
               vo_cnt_prazo_adit,
               vo_dat_termino_contrato,
               vo_dat_publicacao,
               vo_num_dou_publicacao,
               vo_num_pagina_publicacao,
               vo_num_secao_publicacao,
               vo_cod_modalidade_licitacao,
               vo_num_inciso,
               vo_dsc_fundamento_legal,
               vo_num_licitacao,
               vo_num_ano_licitacao,
               vo_num_processo,
               vo_cnt_valor_compromisso,
               vo_cnt_valor_termo,
               vo_cnt_valor_pago,
               vo_cnt_valor_reaj,
               vo_cnt_valor_reaj_pago,
               vo_cnt_valor,
               vo_tip_situacao_contrato,
               vo_tip_contrato,
               vo_dsc_critica_contrato,
               v_num_seq_contrato,
               v_cnt_cre_cod
            );
            -- LOG
            ifrbde_views.pck_seguranca.stp_log (
               p_usuario,
               'TAB_CONTRATO',
               'I',
               TO_CHAR (v_num_seq_contrato) || TO_CHAR (vi_cnt_cre_cod)
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
-- Altera Cadastro de Contratos
-- retorna o recordset correspondente
   PROCEDURE stp_altera_contrato (
      p_usuario                              VARCHAR2,
      vo_num_seq_contrato           OUT      tyt_num_seq_contrato,
      vo_cnt_cre_cod                OUT      tyt_cnt_cre_cod,
      vo_cnt_cod                    OUT      tyt_cnt_cod,
      vo_num_versao_contrato        OUT      tyt_num_versao_contrato,
      vo_num_termo_aditivo          OUT      tyt_num_termo_aditivo,
      vo_cod_dep_contrato           OUT      tyt_cod_dep_contrato,
      vo_cnt_justificativa_cre      OUT      tyt_cnt_justificativa_cre,
      vo_num_seq_gestor             OUT      tyt_num_seq_gestor,
      vo_num_seq_assinatura_1       OUT      tyt_num_seq_assinatura_1,
      vo_num_seq_assinatura_2       OUT      tyt_num_seq_assinatura_2,
      vo_num_ato_administrativo     OUT      tyt_num_ato_administrativo,
      vo_cnt_cei                    OUT      tyt_cnt_cei,
      vo_cnt_crea                   OUT      tyt_cnt_crea,
      vo_cnt_ice_cod                OUT      tyt_cnt_ice_cod,
      vo_cnt_data                   OUT      tyt_cnt_data,
      vo_cnt_data_proposta          OUT      tyt_cnt_data_proposta,
      vo_cnt_data_inicio            OUT      tyt_cnt_data_inicio,
      vo_cnt_prazo_exec             OUT      tyt_cnt_prazo_exec,
      vo_num_prazo_exec_meses       OUT      tyt_num_prazo_exec_meses,
      vo_cnt_prazo_adit             OUT      tyt_cnt_prazo_adit,
      vo_dat_termino_contrato       OUT      tyt_dat_termino_contrato,
      vo_dat_publicacao             OUT      tyt_dat_publicacao,
      vo_num_dou_publicacao         OUT      tyt_num_dou_publicacao,
      vo_num_pagina_publicacao      OUT      tyt_num_pagina_publicacao,
      vo_num_secao_publicacao       OUT      tyt_num_secao_publicacao,
      vo_cod_modalidade_licitacao   OUT      tyt_cod_modalidade_licitacao,
      vo_num_inciso                 OUT      tyt_num_inciso,
      vo_dsc_fundamento_legal       OUT      tyt_dsc_fundamento_legal,
      vo_num_licitacao              OUT      tyt_num_licitacao,
      vo_num_ano_licitacao          OUT      tyt_num_ano_licitacao,
      vo_num_processo               OUT      tyt_num_processo,
      vo_cnt_valor_compromisso      OUT      tyt_cnt_valor_compromisso,
      vo_cnt_valor_termo            OUT      tyt_cnt_valor_termo,
      vo_cnt_valor_pago             OUT      tyt_cnt_valor_pago,
      vo_cnt_valor_reaj             OUT      tyt_cnt_valor_reaj,
      vo_cnt_valor_reaj_pago        OUT      tyt_cnt_valor_reaj_pago,
      vo_cnt_valor                  OUT      tyt_cnt_valor,
      vo_tip_situacao_contrato      OUT      tyt_tip_situacao_contrato,
      vo_tip_contrato               OUT      tyt_tip_contrato,
      vo_dsc_critica_contrato       OUT      tyt_dsc_critica_contrato,
      vi_num_seq_contrato           IN       t_num_seq_contrato,
      vi_cnt_cre_cod                IN       t_cnt_cre_cod,
      vi_cnt_cod                    IN       t_cnt_cod,
      vi_num_versao_contrato        IN       t_num_versao_contrato,
      vi_cod_dep_contrato           IN       t_cod_dep_contrato,
      vi_cnt_justificativa_cre      IN       t_cnt_justificativa_cre,
      vi_num_seq_gestor             IN       t_num_seq_gestor,
      vi_num_seq_assinatura_1       IN       t_num_seq_assinatura_1,
      vi_num_seq_assinatura_2       IN       t_num_seq_assinatura_2,
      vi_num_ato_administrativo     IN       t_num_ato_administrativo,
      vi_cnt_cei                    IN       t_cnt_cei,
      vi_cnt_crea                   IN       t_cnt_crea,
      vi_cnt_ice_cod                IN       t_cnt_ice_cod,
      vi_cnt_data                   IN       t_cnt_data,
      vi_cnt_data_proposta          IN       t_cnt_data_proposta,
      vi_cnt_data_inicio            IN       t_cnt_data_inicio,
      vi_cnt_prazo_exec             IN       t_cnt_prazo_exec,
      vi_num_prazo_exec_meses       IN       t_num_prazo_exec_meses,
      vi_dat_publicacao             IN       t_dat_publicacao,
      vi_num_dou_publicacao         IN       t_num_dou_publicacao,
      vi_num_pagina_publicacao      IN       t_num_pagina_publicacao,
      vi_num_secao_publicacao       IN       t_num_secao_publicacao,
      vi_cod_modalidade_licitacao   IN       t_cod_modalidade_licitacao,
      vi_num_inciso                 IN       t_num_inciso,
      vi_dsc_fundamento_legal       IN       t_dsc_fundamento_legal,
      vi_num_licitacao              IN       t_num_licitacao,
      vi_num_ano_licitacao          IN       t_num_ano_licitacao,
      vi_num_processo               IN       t_num_processo,
      vi_tip_situacao_contrato      IN       t_tip_situacao_contrato
   ) AS
      CURSOR c_cursor IS
         SELECT     *
               FROM ifrbde_views.tab_contrato
              WHERE num_seq_contrato = vi_num_seq_contrato
                AND cnt_cre_cod = vi_cnt_cre_cod
         FOR UPDATE;

      v_tab_contrato                ifrbde_views.tab_contrato%ROWTYPE;
      v_num_seq_contrato            ifrbde_views.tab_contrato.num_seq_contrato%TYPE;
      v_cnt_cre_cod                 ifrbde_views.tab_contrato.cnt_cre_cod%TYPE;
      v_cnt_cod                     ifrbde_views.tab_contrato.cnt_cod%TYPE;
      v_num_versao_contrato         ifrbde_views.tab_contrato.num_versao_contrato%TYPE;
      v_cod_dep_contrato            ifrbde_views.tab_contrato.cod_dep_contrato%TYPE;
      v_cnt_justificativa_cre       ifrbde_views.tab_contrato.cnt_justificativa_cre%TYPE;
      v_num_seq_gestor              ifrbde_views.tab_contrato.num_seq_gestor%TYPE;
      v_num_seq_assinatura_1        ifrbde_views.tab_contrato.num_seq_assinatura_1%TYPE;
      v_num_seq_assinatura_2        ifrbde_views.tab_contrato.num_seq_assinatura_2%TYPE;
      v_num_ato_administrativo      ifrbde_views.tab_contrato.num_ato_administrativo%TYPE;
      v_cnt_cei                     ifrbde_views.tab_contrato.cnt_cei%TYPE;
      v_cnt_crea                    ifrbde_views.tab_contrato.cnt_crea%TYPE;
      v_cnt_ice_cod                 ifrbde_views.tab_contrato.cnt_ice_cod%TYPE;
      v_cnt_data                    ifrbde_views.tab_contrato.cnt_data%TYPE;
      v_cnt_data_proposta           ifrbde_views.tab_contrato.cnt_data_proposta%TYPE;
      v_cnt_data_inicio             ifrbde_views.tab_contrato.cnt_data_inicio%TYPE;
      v_cnt_prazo_exec              ifrbde_views.tab_contrato.cnt_prazo_exec%TYPE;
      v_num_prazo_exec_meses        ifrbde_views.tab_contrato.num_prazo_exec_meses%TYPE;
      v_dat_publicacao              ifrbde_views.tab_contrato.dat_publicacao%TYPE;
      v_num_dou_publicacao          ifrbde_views.tab_contrato.num_dou_publicacao%TYPE;
      v_num_pagina_publicacao       ifrbde_views.tab_contrato.num_pagina_publicacao%TYPE;
      v_num_secao_publicacao        ifrbde_views.tab_contrato.num_secao_publicacao%TYPE;
      v_cod_modalidade_licitacao    ifrbde_views.tab_contrato.cod_modalidade_licitacao%TYPE;
      v_num_inciso                  ifrbde_views.tab_contrato.num_inciso%TYPE;
      v_dsc_fundamento_legal        ifrbde_views.tab_contrato.dsc_fundamento_legal%TYPE;
      v_num_licitacao               ifrbde_views.tab_contrato.num_licitacao%TYPE;
      v_num_ano_licitacao           ifrbde_views.tab_contrato.num_ano_licitacao%TYPE;
      v_num_processo                ifrbde_views.tab_contrato.num_processo%TYPE;
      v_tip_situacao_contrato       ifrbde_views.tab_contrato.tip_situacao_contrato%TYPE;
   BEGIN
      IF ifrbde_views.pck_seguranca.stf_permitido (
            p_usuario,
            'TAB_CONTRATO',
            'ALTERA'
         ) THEN
         OPEN c_cursor;
         FETCH c_cursor INTO v_tab_contrato;

         IF NOT c_cursor%NOTFOUND THEN
            v_cnt_cod := RTRIM (LTRIM (UPPER (vi_cnt_cod)));
            v_num_versao_contrato :=
                               RTRIM (LTRIM (UPPER (vi_num_versao_contrato)));
            v_cnt_justificativa_cre :=
                             RTRIM (LTRIM (UPPER (vi_cnt_justificativa_cre)));
            v_num_ato_administrativo :=
                            RTRIM (LTRIM (UPPER (vi_num_ato_administrativo)));
            v_cnt_cei := RTRIM (LTRIM (UPPER (vi_cnt_cei)));
            v_cnt_crea := RTRIM (LTRIM (UPPER (vi_cnt_crea)));
            v_cnt_ice_cod := RTRIM (LTRIM (UPPER (vi_cnt_ice_cod)));
            v_num_dou_publicacao :=
                                RTRIM (LTRIM (UPPER (vi_num_dou_publicacao)));
            v_num_pagina_publicacao :=
                             RTRIM (LTRIM (UPPER (vi_num_pagina_publicacao)));
            v_num_secao_publicacao :=
                              RTRIM (LTRIM (UPPER (vi_num_secao_publicacao)));
            v_cod_modalidade_licitacao :=
                          RTRIM (LTRIM (UPPER (vi_cod_modalidade_licitacao)));
            v_dsc_fundamento_legal :=
                              RTRIM (LTRIM (UPPER (vi_dsc_fundamento_legal)));
            v_num_licitacao := RTRIM (LTRIM (UPPER (vi_num_licitacao)));
            v_num_processo := RTRIM (LTRIM (UPPER (vi_num_processo)));
            v_cnt_data := TO_DATE (vi_cnt_data, 'DD/MM/YYYY');
            v_cnt_data_proposta :=
                                  TO_DATE (vi_cnt_data_proposta, 'DD/MM/YYYY');
            v_cnt_data_inicio := TO_DATE (vi_cnt_data_inicio, 'DD/MM/YYYY');
            v_dat_publicacao := TO_DATE (vi_dat_publicacao, 'DD/MM/YYYY');
            v_cnt_cre_cod := vi_cnt_cre_cod;
            v_cod_dep_contrato := vi_cod_dep_contrato;
            v_num_seq_gestor := vi_num_seq_gestor;
            v_num_seq_assinatura_1 := vi_num_seq_assinatura_1;
            v_num_seq_assinatura_2 := vi_num_seq_assinatura_2;
            v_cnt_prazo_exec := vi_cnt_prazo_exec;
            v_num_prazo_exec_meses := vi_num_prazo_exec_meses;
            v_num_inciso := vi_num_inciso;
            v_num_ano_licitacao := vi_num_ano_licitacao;
            v_tip_situacao_contrato := vi_tip_situacao_contrato;

            UPDATE ifrbde_views.tab_contrato
               SET cnt_cod = v_cnt_cod,
                   num_versao_contrato = v_num_versao_contrato,
                   cod_dep_contrato = v_cod_dep_contrato,
                   cnt_justificativa_cre = v_cnt_justificativa_cre,
                   num_seq_gestor = v_num_seq_gestor,
                   num_seq_assinatura_1 = v_num_seq_assinatura_1,
                   num_seq_assinatura_2 = v_num_seq_assinatura_2,
                   num_ato_administrativo = v_num_ato_administrativo,
                   cnt_cei = v_cnt_cei,
                   cnt_crea = v_cnt_crea,
                   cnt_ice_cod = v_cnt_ice_cod,
                   cnt_data = v_cnt_data,
                   cnt_data_proposta = v_cnt_data_proposta,
                   cnt_data_inicio = v_cnt_data_inicio,
                   cnt_prazo_exec = v_cnt_prazo_exec,
                   num_prazo_exec_meses = v_num_prazo_exec_meses,
                   dat_publicacao = v_dat_publicacao,
                   num_dou_publicacao = v_num_dou_publicacao,
                   num_pagina_publicacao = v_num_pagina_publicacao,
                   num_secao_publicacao = v_num_secao_publicacao,
                   cod_modalidade_licitacao = v_cod_modalidade_licitacao,
                   num_inciso = v_num_inciso,
                   dsc_fundamento_legal = v_dsc_fundamento_legal,
                   num_licitacao = v_num_licitacao,
                   num_ano_licitacao = v_num_ano_licitacao,
                   num_processo = v_num_processo,
                   tip_situacao_contrato = v_tip_situacao_contrato
             WHERE  CURRENT OF c_cursor;

            IF SQL%ROWCOUNT = 1 THEN
               
--
               BEGIN
                  ifrbde.prc_critica_contrato (vi_num_seq_contrato);
               EXCEPTION
                  WHEN OTHERS THEN
                     raise_application_error (
                        -20100,
                        ' Erro ao executar a rotina de critica ' || SQLERRM
                     );
               END;

               
--            

               stp_pesquisa_contrato (
                  p_usuario,
                  vo_num_seq_contrato,
                  vo_cnt_cre_cod,
                  vo_cnt_cod,
                  vo_num_versao_contrato,
                  vo_num_termo_aditivo,
                  vo_cod_dep_contrato,
                  vo_cnt_justificativa_cre,
                  vo_num_seq_gestor,
                  vo_num_seq_assinatura_1,
                  vo_num_seq_assinatura_2,
                  vo_num_ato_administrativo,
                  vo_cnt_cei,
                  vo_cnt_crea,
                  vo_cnt_ice_cod,
                  vo_cnt_data,
                  vo_cnt_data_proposta,
                  vo_cnt_data_inicio,
                  vo_cnt_prazo_exec,
                  vo_num_prazo_exec_meses,
                  vo_cnt_prazo_adit,
                  vo_dat_termino_contrato,
                  vo_dat_publicacao,
                  vo_num_dou_publicacao,
                  vo_num_pagina_publicacao,
                  vo_num_secao_publicacao,
                  vo_cod_modalidade_licitacao,
                  vo_num_inciso,
                  vo_dsc_fundamento_legal,
                  vo_num_licitacao,
                  vo_num_ano_licitacao,
                  vo_num_processo,
                  vo_cnt_valor_compromisso,
                  vo_cnt_valor_termo,
                  vo_cnt_valor_pago,
                  vo_cnt_valor_reaj,
                  vo_cnt_valor_reaj_pago,
                  vo_cnt_valor,
                  vo_tip_situacao_contrato,
                  vo_tip_contrato,
                  vo_dsc_critica_contrato,
                  vi_num_seq_contrato,
                  vi_cnt_cre_cod
               );
               -- LOG
               ifrbde_views.pck_seguranca.stp_log (
                  p_usuario,
                  'TAB_CONTRATO',
                  'A',
                  TO_CHAR (vi_num_seq_contrato) || TO_CHAR (vi_cnt_cre_cod)
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
-- Pesquisa Valores do Contrato
-- retorna o recordset correspondente
   PROCEDURE stp_pesquisa_valores_contrato (
      p_usuario                                VARCHAR2,
      vo_num_seq_contrato_res_rv      OUT      tyt_num_seq_contrato_res_rv,
      vo_num_seq_resumo_rv            OUT      tyt_num_seq_resumo_rv,
      vo_cnt_cre_cod_res              OUT      tyt_cnt_cre_cod_res,
      vo_cnt_cod_res                  OUT      tyt_cnt_cod_res,
      vo_num_versao_contrato_res_rv   OUT      tyt_num_versao_contrato_res_rv,
      vo_val_resumo_rv                OUT      tyt_val_resumo_rv,
      vo_val_termo_rv                 OUT      tyt_val_termo_rv,
      vo_val_pagamento_rv             OUT      tyt_val_pagamento_rv,
      vo_val_reajuste_rv              OUT      tyt_val_reajuste_rv,
      vo_val_pago_rv                  OUT      tyt_val_pago_rv,
      vo_val_pago_reajuste_rv         OUT      tyt_val_pago_reajuste_rv,
      vo_val_saldo_resumo_rv          OUT      tyt_val_saldo_resumo_rv,
      vo_flg_moeda_controle_rv        OUT      tyt_flg_moeda_controle_rv,
      vo_tip_moeda_rv                 OUT      tyt_tip_moeda_rv,
      vo_dat_moeda_rv                 OUT      tyt_dat_moeda_rv,
      vo_val_cotacao_moeda_rv         OUT      tyt_val_cotacao_moeda_rv,
      vo_tip_cotacao_moeda_rv         OUT      tyt_tip_cotacao_moeda_rv,
      vo_val_resumo_sec_rv            OUT      tyt_val_resumo_sec_rv,
      vo_val_termo_sec_rv             OUT      tyt_val_termo_sec_rv,
      vo_val_pagamento_sec_rv         OUT      tyt_val_pagamento_sec_rv,
      vo_val_reajuste_sec_rv          OUT      tyt_val_reajuste_sec_rv,
      vo_val_pago_sec_rv              OUT      tyt_val_pago_sec_rv,
      vo_val_pago_reajuste_sec_rv     OUT      tyt_val_pago_reajuste_sec_rv,
      vo_val_saldo_resumo_sec_rv      OUT      tyt_val_saldo_resumo_sec_rv,
      vi_num_seq_contrato_res_rv      IN       t_num_seq_contrato_res_rv,
      vi_num_seq_resumo_rv            IN       t_num_seq_resumo_rv
   ) AS
   BEGIN
      IF ifrbde_views.pck_seguranca.stf_permitido (
            p_usuario,
            'VIW_VALORES_CONTRATO',
            'PESQUISA'
         ) THEN
         SELECT num_seq_contrato_res_rv,
                num_seq_resumo_rv,
                cnt_cre_cod_res,
                cnt_cod_res,
                num_versao_contrato_res_rv,
                val_resumo_rv,
                val_termo_rv,
                val_pagamento_rv,
                val_reajuste_rv,
                val_pago_rv,
                val_pago_reajuste_rv,
                val_saldo_resumo_rv,
                flg_moeda_controle_rv,
                tip_moeda_rv,
                TO_CHAR (dat_moeda_rv, 'DD/MM/YYYY') dat_moeda_rv,
                val_cotacao_moeda_rv,
                tip_cotacao_moeda_rv,
                val_resumo_sec_rv,
                val_termo_sec_rv,
                val_pagamento_sec_rv,
                val_reajuste_sec_rv,
                val_pago_sec_rv,
                val_pago_reajuste_sec_rv,
                val_saldo_resumo_sec_rv
           INTO vo_num_seq_contrato_res_rv (1),
                vo_num_seq_resumo_rv (1),
                vo_cnt_cre_cod_res (1),
                vo_cnt_cod_res (1),
                vo_num_versao_contrato_res_rv (1),
                vo_val_resumo_rv (1),
                vo_val_termo_rv (1),
                vo_val_pagamento_rv (1),
                vo_val_reajuste_rv (1),
                vo_val_pago_rv (1),
                vo_val_pago_reajuste_rv (1),
                vo_val_saldo_resumo_rv (1),
                vo_flg_moeda_controle_rv (1),
                vo_tip_moeda_rv (1),
                vo_dat_moeda_rv (1),
                vo_val_cotacao_moeda_rv (1),
                vo_tip_cotacao_moeda_rv (1),
                vo_val_resumo_sec_rv (1),
                vo_val_termo_sec_rv (1),
                vo_val_pagamento_sec_rv (1),
                vo_val_reajuste_sec_rv (1),
                vo_val_pago_sec_rv (1),
                vo_val_pago_reajuste_sec_rv (1),
                vo_val_saldo_resumo_sec_rv (1)
           FROM ifrbde_views.viw_valores_contrato
          WHERE num_seq_contrato_res_rv = vi_num_seq_contrato_res_rv
            AND num_seq_resumo_rv = vi_num_seq_resumo_rv;

         
--
         DELETE FROM ifrbde_views.aux_usuario_contrato
               WHERE nom_username = USER;

         INSERT INTO ifrbde_views.aux_usuario_contrato
                     (nom_username,
                      num_seq_contrato_aux
                     )
              VALUES (USER,
                      vi_num_seq_contrato_res_rv
                     );
      
--
      END IF;
   EXCEPTION
      WHEN OTHERS THEN
         raise_application_error (-20100, SQLERRM);
   END;

   -- Exclui Valores do Contrato
   -- retorna o OK ou nao
   PROCEDURE stp_exclui_valores_contrato (
      p_usuario                             VARCHAR2,
      vo_ok                        OUT      tyt_ok,
      vi_num_seq_contrato_res_rv   IN       t_num_seq_contrato_res_rv,
      vi_num_seq_resumo_rv         IN       t_num_seq_resumo_rv
   ) AS
   BEGIN
      vo_ok (1) := 0;

      IF ifrbde_views.pck_seguranca.stf_permitido (
            p_usuario,
            'VIW_VALORES_CONTRATO',
            'EXCLUI'
         ) THEN
         DELETE FROM ifrbde_views.viw_valores_contrato
               WHERE num_seq_contrato_res_rv = vi_num_seq_contrato_res_rv
                 AND num_seq_resumo_rv = vi_num_seq_resumo_rv;

         IF SQL%ROWCOUNT = 1 THEN
            vo_ok (1) := 1;
            -- LOG
            ifrbde_views.pck_seguranca.stp_log (
               p_usuario,
               'VIW_VALORES_CONTRATO',
               'E',
               TO_CHAR (vi_num_seq_contrato_res_rv)
               || TO_CHAR (vi_num_seq_resumo_rv)
            );
            COMMIT;
         ELSIF SQL%ROWCOUNT > 1 THEN
            ROLLBACK;
         END IF;
      END IF;
   EXCEPTION
      WHEN OTHERS THEN
         raise_application_error (-20100, SQLERRM);
   END;

   
--------------------------------------------------------------------
-- Inclui Valores do Contrato
-- retorna o recordset correspondente
   PROCEDURE stp_inclui_valores_contrato (
      p_usuario                                VARCHAR2,
      vo_num_seq_contrato_res_rv      OUT      tyt_num_seq_contrato_res_rv,
      vo_num_seq_resumo_rv            OUT      tyt_num_seq_resumo_rv,
      vo_cnt_cre_cod_res              OUT      tyt_cnt_cre_cod_res,
      vo_cnt_cod_res                  OUT      tyt_cnt_cod_res,
      vo_num_versao_contrato_res_rv   OUT      tyt_num_versao_contrato_res_rv,
      vo_val_resumo_rv                OUT      tyt_val_resumo_rv,
      vo_val_termo_rv                 OUT      tyt_val_termo_rv,
      vo_val_pagamento_rv             OUT      tyt_val_pagamento_rv,
      vo_val_reajuste_rv              OUT      tyt_val_reajuste_rv,
      vo_val_pago_rv                  OUT      tyt_val_pago_rv,
      vo_val_pago_reajuste_rv         OUT      tyt_val_pago_reajuste_rv,
      vo_val_saldo_resumo_rv          OUT      tyt_val_saldo_resumo_rv,
      vo_flg_moeda_controle_rv        OUT      tyt_flg_moeda_controle_rv,
      vo_tip_moeda_rv                 OUT      tyt_tip_moeda_rv,
      vo_dat_moeda_rv                 OUT      tyt_dat_moeda_rv,
      vo_val_cotacao_moeda_rv         OUT      tyt_val_cotacao_moeda_rv,
      vo_tip_cotacao_moeda_rv         OUT      tyt_tip_cotacao_moeda_rv,
      vo_val_resumo_sec_rv            OUT      tyt_val_resumo_sec_rv,
      vo_val_termo_sec_rv             OUT      tyt_val_termo_sec_rv,
      vo_val_pagamento_sec_rv         OUT      tyt_val_pagamento_sec_rv,
      vo_val_reajuste_sec_rv          OUT      tyt_val_reajuste_sec_rv,
      vo_val_pago_sec_rv              OUT      tyt_val_pago_sec_rv,
      vo_val_pago_reajuste_sec_rv     OUT      tyt_val_pago_reajuste_sec_rv,
      vo_val_saldo_resumo_sec_rv      OUT      tyt_val_saldo_resumo_sec_rv,
      vi_num_seq_contrato_res_rv      IN       t_num_seq_contrato_res_rv,
      vi_cnt_cre_cod_res              IN       t_cnt_cre_cod_res,
      vi_cnt_cod_res                  IN       t_cnt_cod_res,
      vi_val_resumo_rv                IN       t_val_resumo_rv,
      vi_val_termo_rv                 IN       t_val_termo_rv,
      vi_val_pagamento_rv             IN       t_val_pagamento_rv,
      vi_val_reajuste_rv              IN       t_val_reajuste_rv,
      vi_val_pago_rv                  IN       t_val_pago_rv,
      vi_val_pago_reajuste_rv         IN       t_val_pago_reajuste_rv,
      vi_val_saldo_resumo_rv          IN       t_val_saldo_resumo_rv,
      vi_flg_moeda_controle_rv        IN       t_flg_moeda_controle_rv,
      vi_tip_moeda_rv                 IN       t_tip_moeda_rv,
      vi_dat_moeda_rv                 IN       t_dat_moeda_rv,
      vi_val_cotacao_moeda_rv         IN       t_val_cotacao_moeda_rv,
      vi_tip_cotacao_moeda_rv         IN       t_tip_cotacao_moeda_rv,
      vi_val_resumo_sec_rv            IN       t_val_resumo_sec_rv,
      vi_val_termo_sec_rv             IN       t_val_termo_sec_rv,
      vi_val_pagamento_sec_rv         IN       t_val_pagamento_sec_rv,
      vi_val_reajuste_sec_rv          IN       t_val_reajuste_sec_rv,
      vi_val_pago_sec_rv              IN       t_val_pago_sec_rv,
      vi_val_pago_reajuste_sec_rv     IN       t_val_pago_reajuste_sec_rv,
      vi_val_saldo_resumo_sec_rv      IN       t_val_saldo_resumo_sec_rv
   ) AS
      v_num_seq_contrato_res_rv     viw_valores_contrato.num_seq_contrato_res_rv%TYPE;
      v_num_seq_resumo_rv           viw_valores_contrato.num_seq_resumo_rv%TYPE;
      v_cnt_cre_cod_res             viw_valores_contrato.cnt_cre_cod_res%TYPE;
      v_cnt_cod_res                 viw_valores_contrato.cnt_cod_res%TYPE;
      v_val_resumo_rv               viw_valores_contrato.val_resumo_rv%TYPE;
      v_val_termo_rv                viw_valores_contrato.val_termo_rv%TYPE;
      v_val_pagamento_rv            viw_valores_contrato.val_pagamento_rv%TYPE;
      v_val_reajuste_rv             viw_valores_contrato.val_reajuste_rv%TYPE;
      v_val_pago_rv                 viw_valores_contrato.val_pago_rv%TYPE;
      v_val_pago_reajuste_rv        viw_valores_contrato.val_pago_reajuste_rv%TYPE;
      v_val_saldo_resumo_rv         viw_valores_contrato.val_saldo_resumo_rv%TYPE;
      v_flg_moeda_controle_rv       viw_valores_contrato.flg_moeda_controle_rv%TYPE;
      v_tip_moeda_rv                viw_valores_contrato.tip_moeda_rv%TYPE;
      v_dat_moeda_rv                viw_valores_contrato.dat_moeda_rv%TYPE;
      v_val_cotacao_moeda_rv        viw_valores_contrato.val_cotacao_moeda_rv%TYPE;
      v_tip_cotacao_moeda_rv        viw_valores_contrato.tip_cotacao_moeda_rv%TYPE;
      v_val_resumo_sec_rv           viw_valores_contrato.val_resumo_sec_rv%TYPE;
      v_val_termo_sec_rv            viw_valores_contrato.val_termo_sec_rv%TYPE;
      v_val_pagamento_sec_rv        viw_valores_contrato.val_pagamento_sec_rv%TYPE;
      v_val_reajuste_sec_rv         viw_valores_contrato.val_reajuste_sec_rv%TYPE;
      v_val_pago_sec_rv             viw_valores_contrato.val_pago_sec_rv%TYPE;
      v_val_pago_reajuste_sec_rv    viw_valores_contrato.val_pago_reajuste_sec_rv%TYPE;
      v_val_saldo_resumo_sec_rv     viw_valores_contrato.val_saldo_resumo_sec_rv%TYPE;
   BEGIN
      IF ifrbde_views.pck_seguranca.stf_permitido (
            p_usuario,
            'VIW_VALORES_CONTRATO',
            'INCLUI'
         ) THEN
         SELECT seq_num_seq_contrato.NEXTVAL
           INTO v_num_seq_resumo_rv
           FROM DUAL;

         v_cnt_cod_res := RTRIM (LTRIM (UPPER (vi_cnt_cod_res)));
         v_flg_moeda_controle_rv :=
                             RTRIM (LTRIM (UPPER (vi_flg_moeda_controle_rv)));
         v_tip_moeda_rv := RTRIM (LTRIM (UPPER (vi_tip_moeda_rv)));
         v_tip_cotacao_moeda_rv :=
                              RTRIM (LTRIM (UPPER (vi_tip_cotacao_moeda_rv)));
         v_dat_moeda_rv := TO_DATE (vi_dat_moeda_rv, 'DD/MM/YYYY');
         v_num_seq_contrato_res_rv := vi_num_seq_contrato_res_rv;
         v_cnt_cre_cod_res := vi_cnt_cre_cod_res;
         v_val_resumo_rv := vi_val_resumo_rv;
         v_val_termo_rv := vi_val_termo_rv;
         v_val_pagamento_rv := vi_val_pagamento_rv;
         v_val_reajuste_rv := vi_val_reajuste_rv;
         v_val_pago_rv := vi_val_pago_rv;
         v_val_pago_reajuste_rv := vi_val_pago_reajuste_rv;
         v_val_saldo_resumo_rv := vi_val_saldo_resumo_rv;
         v_val_cotacao_moeda_rv := vi_val_cotacao_moeda_rv;
         v_val_resumo_sec_rv := vi_val_resumo_sec_rv;
         v_val_termo_sec_rv := vi_val_termo_sec_rv;
         v_val_pagamento_sec_rv := vi_val_pagamento_sec_rv;
         v_val_reajuste_sec_rv := vi_val_reajuste_sec_rv;
         v_val_pago_sec_rv := vi_val_pago_sec_rv;
         v_val_pago_reajuste_sec_rv := vi_val_pago_reajuste_sec_rv;
         v_val_saldo_resumo_sec_rv := vi_val_saldo_resumo_sec_rv;

         INSERT INTO ifrbde_views.viw_valores_contrato
                     (num_seq_contrato_res_rv,
                      num_seq_resumo_rv,
                      cnt_cre_cod_res,
                      cnt_cod_res,
                      val_resumo_rv,
                      val_termo_rv,
                      val_pagamento_rv,
                      val_reajuste_rv,
                      val_pago_rv,
                      val_pago_reajuste_rv,
                      val_saldo_resumo_rv,
                      flg_moeda_controle_rv,
                      tip_moeda_rv,
                      dat_moeda_rv,
                      val_cotacao_moeda_rv,
                      tip_cotacao_moeda_rv,
                      val_resumo_sec_rv,
                      val_termo_sec_rv,
                      val_pagamento_sec_rv,
                      val_reajuste_sec_rv,
                      val_pago_sec_rv,
                      val_pago_reajuste_sec_rv,
                      val_saldo_resumo_sec_rv
                     )
              VALUES (v_num_seq_contrato_res_rv,
                      v_num_seq_resumo_rv,
                      v_cnt_cre_cod_res,
                      v_cnt_cod_res,
                      v_val_resumo_rv,
                      v_val_termo_rv,
                      v_val_pagamento_rv,
                      v_val_reajuste_rv,
                      v_val_pago_rv,
                      v_val_pago_reajuste_rv,
                      v_val_saldo_resumo_rv,
                      v_flg_moeda_controle_rv,
                      v_tip_moeda_rv,
                      v_dat_moeda_rv,
                      v_val_cotacao_moeda_rv,
                      v_tip_cotacao_moeda_rv,
                      v_val_resumo_sec_rv,
                      v_val_termo_sec_rv,
                      v_val_pagamento_sec_rv,
                      v_val_reajuste_sec_rv,
                      v_val_pago_sec_rv,
                      v_val_pago_reajuste_sec_rv,
                      v_val_saldo_resumo_sec_rv
                     );

         IF SQL%ROWCOUNT = 1 THEN
            stp_pesquisa_valores_contrato (
               p_usuario,
               vo_num_seq_contrato_res_rv,
               vo_num_seq_resumo_rv,
               vo_cnt_cre_cod_res,
               vo_cnt_cod_res,
               vo_num_versao_contrato_res_rv,
               vo_val_resumo_rv,
               vo_val_termo_rv,
               vo_val_pagamento_rv,
               vo_val_reajuste_rv,
               vo_val_pago_rv,
               vo_val_pago_reajuste_rv,
               vo_val_saldo_resumo_rv,
               vo_flg_moeda_controle_rv,
               vo_tip_moeda_rv,
               vo_dat_moeda_rv,
               vo_val_cotacao_moeda_rv,
               vo_tip_cotacao_moeda_rv,
               vo_val_resumo_sec_rv,
               vo_val_termo_sec_rv,
               vo_val_pagamento_sec_rv,
               vo_val_reajuste_sec_rv,
               vo_val_pago_sec_rv,
               vo_val_pago_reajuste_sec_rv,
               vo_val_saldo_resumo_sec_rv,
               v_num_seq_contrato_res_rv,
               v_num_seq_resumo_rv
            );
            -- LOG
            ifrbde_views.pck_seguranca.stp_log (
               p_usuario,
               'VIW_VALORES_CONTRATO',
               'I',
               TO_CHAR (vi_num_seq_contrato_res_rv)
               || TO_CHAR (v_num_seq_resumo_rv)
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
-- Altera Valores do Contrato
-- retorna o recordset correspondente
   PROCEDURE stp_altera_valores_contrato (
      p_usuario                                VARCHAR2,
      vo_num_seq_contrato_res_rv      OUT      tyt_num_seq_contrato_res_rv,
      vo_num_seq_resumo_rv            OUT      tyt_num_seq_resumo_rv,
      vo_cnt_cre_cod_res              OUT      tyt_cnt_cre_cod_res,
      vo_cnt_cod_res                  OUT      tyt_cnt_cod_res,
      vo_num_versao_contrato_res_rv   OUT      tyt_num_versao_contrato_res_rv,
      vo_val_resumo_rv                OUT      tyt_val_resumo_rv,
      vo_val_termo_rv                 OUT      tyt_val_termo_rv,
      vo_val_pagamento_rv             OUT      tyt_val_pagamento_rv,
      vo_val_reajuste_rv              OUT      tyt_val_reajuste_rv,
      vo_val_pago_rv                  OUT      tyt_val_pago_rv,
      vo_val_pago_reajuste_rv         OUT      tyt_val_pago_reajuste_rv,
      vo_val_saldo_resumo_rv          OUT      tyt_val_saldo_resumo_rv,
      vo_flg_moeda_controle_rv        OUT      tyt_flg_moeda_controle_rv,
      vo_tip_moeda_rv                 OUT      tyt_tip_moeda_rv,
      vo_dat_moeda_rv                 OUT      tyt_dat_moeda_rv,
      vo_val_cotacao_moeda_rv         OUT      tyt_val_cotacao_moeda_rv,
      vo_tip_cotacao_moeda_rv         OUT      tyt_tip_cotacao_moeda_rv,
      vo_val_resumo_sec_rv            OUT      tyt_val_resumo_sec_rv,
      vo_val_termo_sec_rv             OUT      tyt_val_termo_sec_rv,
      vo_val_pagamento_sec_rv         OUT      tyt_val_pagamento_sec_rv,
      vo_val_reajuste_sec_rv          OUT      tyt_val_reajuste_sec_rv,
      vo_val_pago_sec_rv              OUT      tyt_val_pago_sec_rv,
      vo_val_pago_reajuste_sec_rv     OUT      tyt_val_pago_reajuste_sec_rv,
      vo_val_saldo_resumo_sec_rv      OUT      tyt_val_saldo_resumo_sec_rv,
      vi_num_seq_contrato_res_rv      IN       t_num_seq_contrato_res_rv,
      vi_num_seq_resumo_rv            IN       t_num_seq_resumo_rv,
      vi_cnt_cre_cod_res              IN       t_cnt_cre_cod_res,
      vi_cnt_cod_res                  IN       t_cnt_cod_res,
      vi_val_resumo_rv                IN       t_val_resumo_rv,
      vi_val_termo_rv                 IN       t_val_termo_rv,
      vi_val_pagamento_rv             IN       t_val_pagamento_rv,
      vi_val_reajuste_rv              IN       t_val_reajuste_rv,
      vi_val_pago_rv                  IN       t_val_pago_rv,
      vi_val_pago_reajuste_rv         IN       t_val_pago_reajuste_rv,
      vi_val_saldo_resumo_rv          IN       t_val_saldo_resumo_rv,
      vi_flg_moeda_controle_rv        IN       t_flg_moeda_controle_rv,
      vi_tip_moeda_rv                 IN       t_tip_moeda_rv,
      vi_dat_moeda_rv                 IN       t_dat_moeda_rv,
      vi_val_cotacao_moeda_rv         IN       t_val_cotacao_moeda_rv,
      vi_tip_cotacao_moeda_rv         IN       t_tip_cotacao_moeda_rv,
      vi_val_resumo_sec_rv            IN       t_val_resumo_sec_rv,
      vi_val_termo_sec_rv             IN       t_val_termo_sec_rv,
      vi_val_pagamento_sec_rv         IN       t_val_pagamento_sec_rv,
      vi_val_reajuste_sec_rv          IN       t_val_reajuste_sec_rv,
      vi_val_pago_sec_rv              IN       t_val_pago_sec_rv,
      vi_val_pago_reajuste_sec_rv     IN       t_val_pago_reajuste_sec_rv,
      vi_val_saldo_resumo_sec_rv      IN       t_val_saldo_resumo_sec_rv
   ) AS
      CURSOR c_cursor IS
         SELECT     *
               FROM ifrbde_views.viw_valores_contrato
              WHERE num_seq_contrato_res_rv = vi_num_seq_contrato_res_rv
                AND num_seq_resumo_rv = vi_num_seq_resumo_rv
         FOR UPDATE;

      v_viw_valores_contrato        ifrbde_views.viw_valores_contrato%ROWTYPE;
      v_num_seq_contrato_res_rv     ifrbde_views.viw_valores_contrato.num_seq_contrato_res_rv%TYPE;
      v_num_seq_resumo_rv           ifrbde_views.viw_valores_contrato.num_seq_resumo_rv%TYPE;
      v_cnt_cre_cod_res             ifrbde_views.viw_valores_contrato.cnt_cre_cod_res%TYPE;
      v_cnt_cod_res                 ifrbde_views.viw_valores_contrato.cnt_cod_res%TYPE;
      v_val_resumo_rv               ifrbde_views.viw_valores_contrato.val_resumo_rv%TYPE;
      v_val_termo_rv                ifrbde_views.viw_valores_contrato.val_termo_rv%TYPE;
      v_val_pagamento_rv            ifrbde_views.viw_valores_contrato.val_pagamento_rv%TYPE;
      v_val_reajuste_rv             ifrbde_views.viw_valores_contrato.val_reajuste_rv%TYPE;
      v_val_pago_rv                 ifrbde_views.viw_valores_contrato.val_pago_rv%TYPE;
      v_val_pago_reajuste_rv        ifrbde_views.viw_valores_contrato.val_pago_reajuste_rv%TYPE;
      v_val_saldo_resumo_rv         ifrbde_views.viw_valores_contrato.val_saldo_resumo_rv%TYPE;
      v_flg_moeda_controle_rv       ifrbde_views.viw_valores_contrato.flg_moeda_controle_rv%TYPE;
      v_tip_moeda_rv                ifrbde_views.viw_valores_contrato.tip_moeda_rv%TYPE;
      v_dat_moeda_rv                ifrbde_views.viw_valores_contrato.dat_moeda_rv%TYPE;
      v_val_cotacao_moeda_rv        ifrbde_views.viw_valores_contrato.val_cotacao_moeda_rv%TYPE;
      v_tip_cotacao_moeda_rv        ifrbde_views.viw_valores_contrato.tip_cotacao_moeda_rv%TYPE;
      v_val_resumo_sec_rv           ifrbde_views.viw_valores_contrato.val_resumo_sec_rv%TYPE;
      v_val_termo_sec_rv            ifrbde_views.viw_valores_contrato.val_termo_sec_rv%TYPE;
      v_val_pagamento_sec_rv        ifrbde_views.viw_valores_contrato.val_pagamento_sec_rv%TYPE;
      v_val_reajuste_sec_rv         ifrbde_views.viw_valores_contrato.val_reajuste_sec_rv%TYPE;
      v_val_pago_sec_rv             ifrbde_views.viw_valores_contrato.val_pago_sec_rv%TYPE;
      v_val_pago_reajuste_sec_rv    ifrbde_views.viw_valores_contrato.val_pago_reajuste_sec_rv%TYPE;
      v_val_saldo_resumo_sec_rv     ifrbde_views.viw_valores_contrato.val_saldo_resumo_sec_rv%TYPE;
   BEGIN
      IF ifrbde_views.pck_seguranca.stf_permitido (
            p_usuario,
            'VIW_VALORES_CONTRATO',
            'ALTERA'
         ) THEN
         OPEN c_cursor;
         FETCH c_cursor INTO v_viw_valores_contrato;

         IF NOT c_cursor%NOTFOUND THEN
            v_cnt_cod_res := RTRIM (LTRIM (UPPER (vi_cnt_cod_res)));
            v_flg_moeda_controle_rv :=
                             RTRIM (LTRIM (UPPER (vi_flg_moeda_controle_rv)));
            v_tip_moeda_rv := RTRIM (LTRIM (UPPER (vi_tip_moeda_rv)));
            v_tip_cotacao_moeda_rv :=
                              RTRIM (LTRIM (UPPER (vi_tip_cotacao_moeda_rv)));
            v_dat_moeda_rv := TO_DATE (vi_dat_moeda_rv, 'DD/MM/YYYY');
            v_num_seq_contrato_res_rv := vi_num_seq_contrato_res_rv;
            v_cnt_cre_cod_res := vi_cnt_cre_cod_res;
            v_val_resumo_rv := vi_val_resumo_rv;
            v_val_termo_rv := vi_val_termo_rv;
            v_val_pagamento_rv := vi_val_pagamento_rv;
            v_val_reajuste_rv := vi_val_reajuste_rv;
            v_val_pago_rv := vi_val_pago_rv;
            v_val_pago_reajuste_rv := vi_val_pago_reajuste_rv;
            v_val_saldo_resumo_rv := vi_val_saldo_resumo_rv;
            v_val_cotacao_moeda_rv := vi_val_cotacao_moeda_rv;
            v_val_resumo_sec_rv := vi_val_resumo_sec_rv;
            v_val_termo_sec_rv := vi_val_termo_sec_rv;
            v_val_pagamento_sec_rv := vi_val_pagamento_sec_rv;
            v_val_reajuste_sec_rv := vi_val_reajuste_sec_rv;
            v_val_pago_sec_rv := vi_val_pago_sec_rv;
            v_val_pago_reajuste_sec_rv := vi_val_pago_reajuste_sec_rv;
            v_val_saldo_resumo_sec_rv := vi_val_saldo_resumo_sec_rv;

            UPDATE ifrbde_views.viw_valores_contrato
               SET cnt_cre_cod_res = v_cnt_cre_cod_res,
                   cnt_cod_res = v_cnt_cod_res,
                   val_resumo_rv = v_val_resumo_rv,
                   val_termo_rv = v_val_termo_rv,
                   val_pagamento_rv = v_val_pagamento_rv,
                   val_reajuste_rv = v_val_reajuste_rv,
                   val_pago_rv = v_val_pago_rv,
                   val_pago_reajuste_rv = v_val_pago_reajuste_rv,
                   val_saldo_resumo_rv = v_val_saldo_resumo_rv,
                   flg_moeda_controle_rv = v_flg_moeda_controle_rv,
                   tip_moeda_rv = v_tip_moeda_rv,
                   dat_moeda_rv = v_dat_moeda_rv,
                   val_cotacao_moeda_rv = v_val_cotacao_moeda_rv,
                   tip_cotacao_moeda_rv = v_tip_cotacao_moeda_rv,
                   val_resumo_sec_rv = v_val_resumo_sec_rv,
                   val_termo_sec_rv = v_val_termo_sec_rv,
                   val_pagamento_sec_rv = v_val_pagamento_sec_rv,
                   val_reajuste_sec_rv = v_val_reajuste_sec_rv,
                   val_pago_sec_rv = v_val_pago_sec_rv,
                   val_pago_reajuste_sec_rv = v_val_pago_reajuste_sec_rv,
                   val_saldo_resumo_sec_rv = v_val_saldo_resumo_sec_rv
             WHERE  CURRENT OF c_cursor;

            IF SQL%ROWCOUNT = 1 THEN
               stp_pesquisa_valores_contrato (
                  p_usuario,
                  vo_num_seq_contrato_res_rv,
                  vo_num_seq_resumo_rv,
                  vo_cnt_cre_cod_res,
                  vo_cnt_cod_res,
                  vo_num_versao_contrato_res_rv,
                  vo_val_resumo_rv,
                  vo_val_termo_rv,
                  vo_val_pagamento_rv,
                  vo_val_reajuste_rv,
                  vo_val_pago_rv,
                  vo_val_pago_reajuste_rv,
                  vo_val_saldo_resumo_rv,
                  vo_flg_moeda_controle_rv,
                  vo_tip_moeda_rv,
                  vo_dat_moeda_rv,
                  vo_val_cotacao_moeda_rv,
                  vo_tip_cotacao_moeda_rv,
                  vo_val_resumo_sec_rv,
                  vo_val_termo_sec_rv,
                  vo_val_pagamento_sec_rv,
                  vo_val_reajuste_sec_rv,
                  vo_val_pago_sec_rv,
                  vo_val_pago_reajuste_sec_rv,
                  vo_val_saldo_resumo_sec_rv,
                  vi_num_seq_contrato_res_rv,
                  vi_num_seq_resumo_rv
               );
               -- LOG
               ifrbde_views.pck_seguranca.stp_log (
                  p_usuario,
                  'VIW_VALORES_CONTRATO',
                  'A',
                  TO_CHAR (vi_num_seq_contrato_res_rv)
                  || TO_CHAR (vi_num_seq_resumo_rv)
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
-- Pesquisa Termo aditivo
-- retorna o recordset correspondente
   PROCEDURE stp_pesquisa_cont_termo_aditiv (
      p_usuario                             VARCHAR2,
      vo_num_seq_termo             OUT      tyt_num_seq_termo,
      vo_num_seq_resumo_ta         OUT      tyt_num_seq_resumo_ta,
      vo_cta_periodo               OUT      tyt_cta_periodo,
      vo_cta_num                   OUT      tyt_cta_num,
      vo_num_versao_contrato_vta   OUT      tyt_num_versao_contrato_vta,
      vo_cta_objeto                OUT      tyt_cta_objeto,
      vo_cta_valor                 OUT      tyt_cta_valor,
      vo_cta_deb_cred              OUT      tyt_cta_deb_cred,
      vo_dat_moeda_ta              OUT      tyt_dat_moeda_ta,
      vo_val_moeda_ta              OUT      tyt_val_moeda_ta,
      vo_tip_cotacao_moeda         OUT      tyt_tip_cotacao_moeda,
      vi_num_seq_termo             IN       t_num_seq_termo,
      vi_num_seq_resumo_ta         IN       t_num_seq_resumo_ta
   ) AS
   BEGIN
      IF ifrbde_views.pck_seguranca.stf_permitido (
            p_usuario,
            'TAB_CONT_TERMO_ADITIVO',
            'PESQUISA'
         ) THEN
         SELECT num_seq_termo,
                num_seq_resumo_ta,
                cta_periodo,
                cta_num,
                num_versao_contrato_vta,
                cta_objeto,
                cta_valor,
                cta_deb_cred,
                TO_CHAR (dat_moeda_ta, 'DD/MM/YYYY') dat_moeda_ta,
                val_moeda_ta,
                tip_cotacao_moeda
           INTO vo_num_seq_termo (1),
                vo_num_seq_resumo_ta (1),
                vo_cta_periodo (1),
                vo_cta_num (1),
                vo_num_versao_contrato_vta (1),
                vo_cta_objeto (1),
                vo_cta_valor (1),
                vo_cta_deb_cred (1),
                vo_dat_moeda_ta (1),
                vo_val_moeda_ta (1),
                vo_tip_cotacao_moeda (1)
           FROM ifrbde_views.tab_cont_termo_aditivo
          WHERE num_seq_termo = vi_num_seq_termo
            AND num_seq_resumo_ta = vi_num_seq_resumo_ta;
      END IF;
   EXCEPTION
      WHEN OTHERS THEN
         raise_application_error (-20100, SQLERRM);
   END;

   -- Exclui Termo aditivo
   -- retorna o OK ou nao
   PROCEDURE stp_exclui_cont_termo_aditivo (
      p_usuario                       VARCHAR2,
      vo_ok                  OUT      tyt_ok,
      vi_num_seq_termo       IN       t_num_seq_termo,
      vi_num_seq_resumo_ta   IN       t_num_seq_resumo_ta
   ) AS
   BEGIN
      vo_ok (1) := 0;

      IF ifrbde_views.pck_seguranca.stf_permitido (
            p_usuario,
            'TAB_CONT_TERMO_ADITIVO',
            'EXCLUI'
         ) THEN
         DELETE FROM ifrbde_views.tab_cont_termo_aditivo
               WHERE num_seq_termo = vi_num_seq_termo
                 AND num_seq_resumo_ta = vi_num_seq_resumo_ta;

         IF SQL%ROWCOUNT = 1 THEN
            vo_ok (1) := 1;
            -- LOG
            ifrbde_views.pck_seguranca.stp_log (
               p_usuario,
               'TAB_CONT_TERMO_ADITIVO',
               'E',
               TO_CHAR (vi_num_seq_termo) || TO_CHAR (vi_num_seq_resumo_ta)
            );
            COMMIT;
         ELSIF SQL%ROWCOUNT > 1 THEN
            ROLLBACK;
         END IF;
      END IF;
   EXCEPTION
      WHEN OTHERS THEN
         raise_application_error (-20100, SQLERRM);
   END;

   
--------------------------------------------------------------------
-- Inclui Termo aditivo
-- retorna o recordset correspondente
   PROCEDURE stp_inclui_cont_termo_aditivo (
      p_usuario                             VARCHAR2,
      vo_num_seq_termo             OUT      tyt_num_seq_termo,
      vo_num_seq_resumo_ta         OUT      tyt_num_seq_resumo_ta,
      vo_cta_periodo               OUT      tyt_cta_periodo,
      vo_cta_num                   OUT      tyt_cta_num,
      vo_num_versao_contrato_vta   OUT      tyt_num_versao_contrato_vta,
      vo_cta_objeto                OUT      tyt_cta_objeto,
      vo_cta_valor                 OUT      tyt_cta_valor,
      vo_cta_deb_cred              OUT      tyt_cta_deb_cred,
      vo_dat_moeda_ta              OUT      tyt_dat_moeda_ta,
      vo_val_moeda_ta              OUT      tyt_val_moeda_ta,
      vo_tip_cotacao_moeda         OUT      tyt_tip_cotacao_moeda,
      vi_num_seq_resumo_ta         IN       t_num_seq_resumo_ta,
      vi_cta_periodo               IN       t_cta_periodo,
      vi_cta_num                   IN       t_cta_num,
      vi_cta_objeto                IN       t_cta_objeto,
      vi_cta_valor                 IN       t_cta_valor,
      vi_cta_deb_cred              IN       t_cta_deb_cred,
      vi_dat_moeda_ta              IN       t_dat_moeda_ta,
      vi_val_moeda_ta              IN       t_val_moeda_ta,
      vi_tip_cotacao_moeda         IN       t_tip_cotacao_moeda
   ) AS
      v_num_seq_termo               tab_cont_termo_aditivo.num_seq_termo%TYPE;
      v_num_seq_resumo_ta           tab_cont_termo_aditivo.num_seq_resumo_ta%TYPE;
      v_cta_periodo                 tab_cont_termo_aditivo.cta_periodo%TYPE;
      v_cta_num                     tab_cont_termo_aditivo.cta_num%TYPE;
      v_cta_objeto                  tab_cont_termo_aditivo.cta_objeto%TYPE;
      v_cta_valor                   tab_cont_termo_aditivo.cta_valor%TYPE;
      v_cta_deb_cred                tab_cont_termo_aditivo.cta_deb_cred%TYPE;
      v_dat_moeda_ta                tab_cont_termo_aditivo.dat_moeda_ta%TYPE;
      v_val_moeda_ta                tab_cont_termo_aditivo.val_moeda_ta%TYPE;
      v_tip_cotacao_moeda           tab_cont_termo_aditivo.tip_cotacao_moeda%TYPE;
   BEGIN
      IF ifrbde_views.pck_seguranca.stf_permitido (
            p_usuario,
            'TAB_CONT_TERMO_ADITIVO',
            'INCLUI'
         ) THEN
         SELECT seq_num_seq_contrato.NEXTVAL
           INTO v_num_seq_termo
           FROM DUAL;

         v_cta_num := RTRIM (LTRIM (UPPER (vi_cta_num)));
         v_cta_objeto := RTRIM (LTRIM (UPPER (vi_cta_objeto)));
         v_tip_cotacao_moeda := RTRIM (LTRIM (UPPER (vi_tip_cotacao_moeda)));
         v_cta_periodo := TO_DATE (vi_cta_periodo, 'DD/MM/YYYY');
         v_dat_moeda_ta := TO_DATE (vi_dat_moeda_ta, 'DD/MM/YYYY');
         v_num_seq_resumo_ta := vi_num_seq_resumo_ta;
         v_cta_valor := vi_cta_valor;
         v_cta_deb_cred := vi_cta_deb_cred;
         v_val_moeda_ta := vi_val_moeda_ta;

         INSERT INTO ifrbde_views.tab_cont_termo_aditivo
                     (num_seq_termo,
                      num_seq_resumo_ta,
                      cta_periodo,
                      cta_num,
                      cta_objeto,
                      cta_valor,
                      cta_deb_cred,
                      dat_moeda_ta,
                      val_moeda_ta,
                      tip_cotacao_moeda
                     )
              VALUES (v_num_seq_termo,
                      v_num_seq_resumo_ta,
                      v_cta_periodo,
                      v_cta_num,
                      v_cta_objeto,
                      v_cta_valor,
                      v_cta_deb_cred,
                      v_dat_moeda_ta,
                      v_val_moeda_ta,
                      v_tip_cotacao_moeda
                     );

         IF SQL%ROWCOUNT = 1 THEN
            stp_pesquisa_cont_termo_aditiv (
               p_usuario,
               vo_num_seq_termo,
               vo_num_seq_resumo_ta,
               vo_cta_periodo,
               vo_cta_num,
               vo_num_versao_contrato_vta,
               vo_cta_objeto,
               vo_cta_valor,
               vo_cta_deb_cred,
               vo_dat_moeda_ta,
               vo_val_moeda_ta,
               vo_tip_cotacao_moeda,
               v_num_seq_termo,
               v_num_seq_resumo_ta
            );
            -- LOG
            ifrbde_views.pck_seguranca.stp_log (
               p_usuario,
               'TAB_CONT_TERMO_ADITIVO',
               'I',
               TO_CHAR (v_num_seq_termo) || TO_CHAR (vi_num_seq_resumo_ta)
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
-- Altera Termo aditivo
-- retorna o recordset correspondente
   PROCEDURE stp_altera_cont_termo_aditivo (
      p_usuario                             VARCHAR2,
      vo_num_seq_termo             OUT      tyt_num_seq_termo,
      vo_num_seq_resumo_ta         OUT      tyt_num_seq_resumo_ta,
      vo_cta_periodo               OUT      tyt_cta_periodo,
      vo_cta_num                   OUT      tyt_cta_num,
      vo_num_versao_contrato_vta   OUT      tyt_num_versao_contrato_vta,
      vo_cta_objeto                OUT      tyt_cta_objeto,
      vo_cta_valor                 OUT      tyt_cta_valor,
      vo_cta_deb_cred              OUT      tyt_cta_deb_cred,
      vo_dat_moeda_ta              OUT      tyt_dat_moeda_ta,
      vo_val_moeda_ta              OUT      tyt_val_moeda_ta,
      vo_tip_cotacao_moeda         OUT      tyt_tip_cotacao_moeda,
      vi_num_seq_termo             IN       t_num_seq_termo,
      vi_num_seq_resumo_ta         IN       t_num_seq_resumo_ta,
      vi_cta_periodo               IN       t_cta_periodo,
      vi_cta_num                   IN       t_cta_num,
      vi_cta_objeto                IN       t_cta_objeto,
      vi_cta_valor                 IN       t_cta_valor,
      vi_cta_deb_cred              IN       t_cta_deb_cred,
      vi_dat_moeda_ta              IN       t_dat_moeda_ta,
      vi_val_moeda_ta              IN       t_val_moeda_ta,
      vi_tip_cotacao_moeda         IN       t_tip_cotacao_moeda
   ) AS
      CURSOR c_cursor IS
         SELECT     *
               FROM ifrbde_views.tab_cont_termo_aditivo
              WHERE num_seq_termo = vi_num_seq_termo
                AND num_seq_resumo_ta = vi_num_seq_resumo_ta
         FOR UPDATE;

      v_tab_cont_termo_aditivo      ifrbde_views.tab_cont_termo_aditivo%ROWTYPE;
      v_num_seq_termo               ifrbde_views.tab_cont_termo_aditivo.num_seq_termo%TYPE;
      v_num_seq_resumo_ta           ifrbde_views.tab_cont_termo_aditivo.num_seq_resumo_ta%TYPE;
      v_cta_periodo                 ifrbde_views.tab_cont_termo_aditivo.cta_periodo%TYPE;
      v_cta_num                     ifrbde_views.tab_cont_termo_aditivo.cta_num%TYPE;
      v_cta_objeto                  ifrbde_views.tab_cont_termo_aditivo.cta_objeto%TYPE;
      v_cta_valor                   ifrbde_views.tab_cont_termo_aditivo.cta_valor%TYPE;
      v_cta_deb_cred                ifrbde_views.tab_cont_termo_aditivo.cta_deb_cred%TYPE;
      v_dat_moeda_ta                ifrbde_views.tab_cont_termo_aditivo.dat_moeda_ta%TYPE;
      v_val_moeda_ta                ifrbde_views.tab_cont_termo_aditivo.val_moeda_ta%TYPE;
      v_tip_cotacao_moeda           ifrbde_views.tab_cont_termo_aditivo.tip_cotacao_moeda%TYPE;
   BEGIN
      IF ifrbde_views.pck_seguranca.stf_permitido (
            p_usuario,
            'TAB_CONT_TERMO_ADITIVO',
            'ALTERA'
         ) THEN
         OPEN c_cursor;
         FETCH c_cursor INTO v_tab_cont_termo_aditivo;

         IF NOT c_cursor%NOTFOUND THEN
            v_cta_num := RTRIM (LTRIM (UPPER (vi_cta_num)));
            v_cta_objeto := RTRIM (LTRIM (UPPER (vi_cta_objeto)));
            v_tip_cotacao_moeda :=
                                 RTRIM (LTRIM (UPPER (vi_tip_cotacao_moeda)));
            v_cta_periodo := TO_DATE (vi_cta_periodo, 'DD/MM/YYYY');
            v_dat_moeda_ta := TO_DATE (vi_dat_moeda_ta, 'DD/MM/YYYY');
            v_num_seq_resumo_ta := vi_num_seq_resumo_ta;
            v_cta_valor := vi_cta_valor;
            v_cta_deb_cred := vi_cta_deb_cred;
            v_val_moeda_ta := vi_val_moeda_ta;

            UPDATE ifrbde_views.tab_cont_termo_aditivo
               SET cta_periodo = v_cta_periodo,
                   cta_num = v_cta_num,
                   cta_objeto = v_cta_objeto,
                   cta_valor = v_cta_valor,
                   cta_deb_cred = v_cta_deb_cred,
                   dat_moeda_ta = v_dat_moeda_ta,
                   val_moeda_ta = v_val_moeda_ta,
                   tip_cotacao_moeda = v_tip_cotacao_moeda
             WHERE  CURRENT OF c_cursor;

            IF SQL%ROWCOUNT = 1 THEN
               stp_pesquisa_cont_termo_aditiv (
                  p_usuario,
                  vo_num_seq_termo,
                  vo_num_seq_resumo_ta,
                  vo_cta_periodo,
                  vo_cta_num,
                  vo_num_versao_contrato_vta,
                  vo_cta_objeto,
                  vo_cta_valor,
                  vo_cta_deb_cred,
                  vo_dat_moeda_ta,
                  vo_val_moeda_ta,
                  vo_tip_cotacao_moeda,
                  vi_num_seq_termo,
                  vi_num_seq_resumo_ta
               );
               -- LOG
               ifrbde_views.pck_seguranca.stp_log (
                  p_usuario,
                  'TAB_CONT_TERMO_ADITIVO',
                  'A',
                  TO_CHAR (vi_num_seq_termo) || TO_CHAR (
                                                   vi_num_seq_resumo_ta
                                                )
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
-- Pesquisa Registrar Termo Aditivo
-- retorna o recordset correspondente
   PROCEDURE stp_pesquisa_termo_aditivo_con (
      p_usuario                             VARCHAR2,
      vo_num_seq_termo_aditivo     OUT      tyt_num_seq_termo_aditivo,
      vo_num_seq_contrato_origem   OUT      tyt_num_seq_contrato_origem,
      vo_dat_termo_aditivo         OUT      tyt_dat_termo_aditivo,
      vo_num_termo_aditivo         OUT      tyt_num_termo_aditivo,
      vo_dsc_objeto_termo          OUT      tyt_dsc_objeto_termo,
      vo_dat_publicacao            OUT      tyt_dat_publicacao,
      vo_num_dou_publicacao        OUT      tyt_num_dou_publicacao,
      vo_num_secao_publicacao      OUT      tyt_num_secao_publicacao,
      vo_num_pagina_publicacao     OUT      tyt_num_pagina_publicacao,
      vo_tip_termo_aditivo         OUT      tyt_tip_termo_aditivo,
      vo_num_prazo                 OUT      tyt_num_prazo,
      vo_flg_aum_dim               OUT      tyt_flg_aum_dim,
      vi_num_seq_termo_aditivo     IN       t_num_seq_termo_aditivo,
      vi_num_seq_contrato_origem   IN       t_num_seq_contrato_origem
   ) AS
   BEGIN
      IF ifrbde_views.pck_seguranca.stf_permitido (
            p_usuario,
            'CAD_TERMO_ADITIVO_CONTRATO',
            'PESQUISA'
         ) THEN
         SELECT num_seq_termo_aditivo,
                num_seq_contrato_origem,
                TO_CHAR (dat_termo_aditivo, 'DD/MM/YYYY') dat_termo_aditivo,
                num_termo_aditivo,
                dsc_objeto_termo,
                TO_CHAR (dat_publicacao, 'DD/MM/YYYY') dat_publicacao,
                num_dou_publicacao,
                num_secao_publicacao,
                num_pagina_publicacao,
                tip_termo_aditivo,
                num_prazo,
                flg_aum_dim
           INTO vo_num_seq_termo_aditivo (1),
                vo_num_seq_contrato_origem (1),
                vo_dat_termo_aditivo (1),
                vo_num_termo_aditivo (1),
                vo_dsc_objeto_termo (1),
                vo_dat_publicacao (1),
                vo_num_dou_publicacao (1),
                vo_num_secao_publicacao (1),
                vo_num_pagina_publicacao (1),
                vo_tip_termo_aditivo (1),
                vo_num_prazo (1),
                vo_flg_aum_dim (1)
           FROM ifrbde_views.cad_termo_aditivo_contrato
          WHERE num_seq_termo_aditivo = vi_num_seq_termo_aditivo
            AND num_seq_contrato_origem = vi_num_seq_contrato_origem;
      END IF;
   EXCEPTION
      WHEN OTHERS THEN
         raise_application_error (-20100, SQLERRM);
   END;

   -- Exclui Registrar Termo Aditivo
   -- retorna o OK ou nao
   PROCEDURE stp_exclui_termo_aditivo_contr (
      p_usuario                             VARCHAR2,
      vo_ok                        OUT      tyt_ok,
      vi_num_seq_termo_aditivo     IN       t_num_seq_termo_aditivo,
      vi_num_seq_contrato_origem   IN       t_num_seq_contrato_origem
   ) AS
   BEGIN
      vo_ok (1) := 0;

      IF ifrbde_views.pck_seguranca.stf_permitido (
            p_usuario,
            'CAD_TERMO_ADITIVO_CONTRATO',
            'EXCLUI'
         ) THEN
         DELETE FROM ifrbde_views.cad_termo_aditivo_contrato
               WHERE num_seq_termo_aditivo = vi_num_seq_termo_aditivo
                 AND num_seq_contrato_origem = vi_num_seq_contrato_origem;

         IF SQL%ROWCOUNT = 1 THEN
            vo_ok (1) := 1;
            -- LOG
            ifrbde_views.pck_seguranca.stp_log (
               p_usuario,
               'CAD_TERMO_ADITIVO_CONTRATO',
               'E',
               TO_CHAR (vi_num_seq_termo_aditivo)
               || TO_CHAR (vi_num_seq_contrato_origem)
            );
            COMMIT;
         ELSIF SQL%ROWCOUNT > 1 THEN
            ROLLBACK;
         END IF;
      END IF;
   EXCEPTION
      WHEN OTHERS THEN
         raise_application_error (-20100, SQLERRM);
   END;

   
--------------------------------------------------------------------
-- Inclui Registrar Termo Aditivo
-- retorna o recordset correspondente
   PROCEDURE stp_inclui_termo_aditivo_contr (
      p_usuario                             VARCHAR2,
      vo_num_seq_termo_aditivo     OUT      tyt_num_seq_termo_aditivo,
      vo_num_seq_contrato_origem   OUT      tyt_num_seq_contrato_origem,
      vo_dat_termo_aditivo         OUT      tyt_dat_termo_aditivo,
      vo_num_termo_aditivo         OUT      tyt_num_termo_aditivo,
      vo_dsc_objeto_termo          OUT      tyt_dsc_objeto_termo,
      vo_dat_publicacao            OUT      tyt_dat_publicacao,
      vo_num_dou_publicacao        OUT      tyt_num_dou_publicacao,
      vo_num_secao_publicacao      OUT      tyt_num_secao_publicacao,
      vo_num_pagina_publicacao     OUT      tyt_num_pagina_publicacao,
      vo_tip_termo_aditivo         OUT      tyt_tip_termo_aditivo,
      vo_num_prazo                 OUT      tyt_num_prazo,
      vo_flg_aum_dim               OUT      tyt_flg_aum_dim,
      vi_num_seq_contrato_origem   IN       t_num_seq_contrato_origem,
      vi_dat_termo_aditivo         IN       t_dat_termo_aditivo,
      vi_num_termo_aditivo         IN       t_num_termo_aditivo,
      vi_dsc_objeto_termo          IN       t_dsc_objeto_termo,
      vi_dat_publicacao            IN       t_dat_publicacao,
      vi_num_dou_publicacao        IN       t_num_dou_publicacao,
      vi_num_secao_publicacao      IN       t_num_secao_publicacao,
      vi_num_pagina_publicacao     IN       t_num_pagina_publicacao,
      vi_tip_termo_aditivo         IN       t_tip_termo_aditivo,
      vi_num_prazo                 IN       t_num_prazo,
      vi_flg_aum_dim               IN       t_flg_aum_dim
   ) AS
      v_num_seq_termo_aditivo       cad_termo_aditivo_contrato.num_seq_termo_aditivo%TYPE;
      v_num_seq_contrato_origem     cad_termo_aditivo_contrato.num_seq_contrato_origem%TYPE;
      v_dat_termo_aditivo           cad_termo_aditivo_contrato.dat_termo_aditivo%TYPE;
      v_num_termo_aditivo           cad_termo_aditivo_contrato.num_termo_aditivo%TYPE;
      v_dsc_objeto_termo            cad_termo_aditivo_contrato.dsc_objeto_termo%TYPE;
      v_dat_publicacao              cad_termo_aditivo_contrato.dat_publicacao%TYPE;
      v_num_dou_publicacao          cad_termo_aditivo_contrato.num_dou_publicacao%TYPE;
      v_num_secao_publicacao        cad_termo_aditivo_contrato.num_secao_publicacao%TYPE;
      v_num_pagina_publicacao       cad_termo_aditivo_contrato.num_pagina_publicacao%TYPE;
      v_tip_termo_aditivo           cad_termo_aditivo_contrato.tip_termo_aditivo%TYPE;
      v_num_prazo                   cad_termo_aditivo_contrato.num_prazo%TYPE;
      v_flg_aum_dim                 cad_termo_aditivo_contrato.flg_aum_dim%TYPE;
   BEGIN
      IF ifrbde_views.pck_seguranca.stf_permitido (
            p_usuario,
            'CAD_TERMO_ADITIVO_CONTRATO',
            'INCLUI'
         ) THEN
         SELECT seq_num_seq_contrato.NEXTVAL
           INTO v_num_seq_termo_aditivo
           FROM DUAL;

         v_num_termo_aditivo := RTRIM (LTRIM (UPPER (vi_num_termo_aditivo)));
         v_dsc_objeto_termo := RTRIM (LTRIM (UPPER (vi_dsc_objeto_termo)));
         v_num_dou_publicacao :=
                                RTRIM (LTRIM (UPPER (vi_num_dou_publicacao)));
         v_num_secao_publicacao :=
                              RTRIM (LTRIM (UPPER (vi_num_secao_publicacao)));
         v_num_pagina_publicacao :=
                             RTRIM (LTRIM (UPPER (vi_num_pagina_publicacao)));
         v_tip_termo_aditivo := RTRIM (LTRIM (UPPER (vi_tip_termo_aditivo)));
         v_dat_termo_aditivo := TO_DATE (vi_dat_termo_aditivo, 'DD/MM/YYYY');
         v_dat_publicacao := TO_DATE (vi_dat_publicacao, 'DD/MM/YYYY');
         v_num_seq_contrato_origem := vi_num_seq_contrato_origem;
         v_num_prazo := vi_num_prazo;
         v_flg_aum_dim := vi_flg_aum_dim;

         INSERT INTO ifrbde_views.cad_termo_aditivo_contrato
                     (num_seq_termo_aditivo,
                      num_seq_contrato_origem,
                      dat_termo_aditivo,
                      num_termo_aditivo,
                      dsc_objeto_termo,
                      dat_publicacao,
                      num_dou_publicacao,
                      num_secao_publicacao,
                      num_pagina_publicacao,
                      tip_termo_aditivo,
                      num_prazo,
                      flg_aum_dim
                     )
              VALUES (v_num_seq_termo_aditivo,
                      v_num_seq_contrato_origem,
                      v_dat_termo_aditivo,
                      v_num_termo_aditivo,
                      v_dsc_objeto_termo,
                      v_dat_publicacao,
                      v_num_dou_publicacao,
                      v_num_secao_publicacao,
                      v_num_pagina_publicacao,
                      v_tip_termo_aditivo,
                      v_num_prazo,
                      v_flg_aum_dim
                     );

         IF SQL%ROWCOUNT = 1 THEN
            stp_pesquisa_termo_aditivo_con (
               p_usuario,
               vo_num_seq_termo_aditivo,
               vo_num_seq_contrato_origem,
               vo_dat_termo_aditivo,
               vo_num_termo_aditivo,
               vo_dsc_objeto_termo,
               vo_dat_publicacao,
               vo_num_dou_publicacao,
               vo_num_secao_publicacao,
               vo_num_pagina_publicacao,
               vo_tip_termo_aditivo,
               vo_num_prazo,
               vo_flg_aum_dim,
               v_num_seq_termo_aditivo,
               v_num_seq_contrato_origem
            );
            -- LOG
            ifrbde_views.pck_seguranca.stp_log (
               p_usuario,
               'CAD_TERMO_ADITIVO_CONTRATO',
               'I',
               TO_CHAR (v_num_seq_termo_aditivo)
               || TO_CHAR (vi_num_seq_contrato_origem)
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
-- Altera Registrar Termo Aditivo
-- retorna o recordset correspondente
   PROCEDURE stp_altera_termo_aditivo_contr (
      p_usuario                             VARCHAR2,
      vo_num_seq_termo_aditivo     OUT      tyt_num_seq_termo_aditivo,
      vo_num_seq_contrato_origem   OUT      tyt_num_seq_contrato_origem,
      vo_dat_termo_aditivo         OUT      tyt_dat_termo_aditivo,
      vo_num_termo_aditivo         OUT      tyt_num_termo_aditivo,
      vo_dsc_objeto_termo          OUT      tyt_dsc_objeto_termo,
      vo_dat_publicacao            OUT      tyt_dat_publicacao,
      vo_num_dou_publicacao        OUT      tyt_num_dou_publicacao,
      vo_num_secao_publicacao      OUT      tyt_num_secao_publicacao,
      vo_num_pagina_publicacao     OUT      tyt_num_pagina_publicacao,
      vo_tip_termo_aditivo         OUT      tyt_tip_termo_aditivo,
      vo_num_prazo                 OUT      tyt_num_prazo,
      vo_flg_aum_dim               OUT      tyt_flg_aum_dim,
      vi_num_seq_termo_aditivo     IN       t_num_seq_termo_aditivo,
      vi_num_seq_contrato_origem   IN       t_num_seq_contrato_origem,
      vi_dat_termo_aditivo         IN       t_dat_termo_aditivo,
      vi_num_termo_aditivo         IN       t_num_termo_aditivo,
      vi_dsc_objeto_termo          IN       t_dsc_objeto_termo,
      vi_dat_publicacao            IN       t_dat_publicacao,
      vi_num_dou_publicacao        IN       t_num_dou_publicacao,
      vi_num_secao_publicacao      IN       t_num_secao_publicacao,
      vi_num_pagina_publicacao     IN       t_num_pagina_publicacao,
      vi_tip_termo_aditivo         IN       t_tip_termo_aditivo,
      vi_num_prazo                 IN       t_num_prazo,
      vi_flg_aum_dim               IN       t_flg_aum_dim
   ) AS
      CURSOR c_cursor IS
         SELECT     *
               FROM ifrbde_views.cad_termo_aditivo_contrato
              WHERE num_seq_termo_aditivo = vi_num_seq_termo_aditivo
                AND num_seq_contrato_origem = vi_num_seq_contrato_origem
         FOR UPDATE;

      v_cad_termo_aditivo_contrato  ifrbde_views.cad_termo_aditivo_contrato%ROWTYPE;
      v_num_seq_termo_aditivo       ifrbde_views.cad_termo_aditivo_contrato.num_seq_termo_aditivo%TYPE;
      v_num_seq_contrato_origem     ifrbde_views.cad_termo_aditivo_contrato.num_seq_contrato_origem%TYPE;
      v_dat_termo_aditivo           ifrbde_views.cad_termo_aditivo_contrato.dat_termo_aditivo%TYPE;
      v_num_termo_aditivo           ifrbde_views.cad_termo_aditivo_contrato.num_termo_aditivo%TYPE;
      v_dsc_objeto_termo            ifrbde_views.cad_termo_aditivo_contrato.dsc_objeto_termo%TYPE;
      v_dat_publicacao              ifrbde_views.cad_termo_aditivo_contrato.dat_publicacao%TYPE;
      v_num_dou_publicacao          ifrbde_views.cad_termo_aditivo_contrato.num_dou_publicacao%TYPE;
      v_num_secao_publicacao        ifrbde_views.cad_termo_aditivo_contrato.num_secao_publicacao%TYPE;
      v_num_pagina_publicacao       ifrbde_views.cad_termo_aditivo_contrato.num_pagina_publicacao%TYPE;
      v_tip_termo_aditivo           ifrbde_views.cad_termo_aditivo_contrato.tip_termo_aditivo%TYPE;
      v_num_prazo                   ifrbde_views.cad_termo_aditivo_contrato.num_prazo%TYPE;
      v_flg_aum_dim                 ifrbde_views.cad_termo_aditivo_contrato.flg_aum_dim%TYPE;
   BEGIN
      IF ifrbde_views.pck_seguranca.stf_permitido (
            p_usuario,
            'CAD_TERMO_ADITIVO_CONTRATO',
            'ALTERA'
         ) THEN
         OPEN c_cursor;
         FETCH c_cursor INTO v_cad_termo_aditivo_contrato;

         IF NOT c_cursor%NOTFOUND THEN
            v_num_termo_aditivo :=
                                 RTRIM (LTRIM (UPPER (vi_num_termo_aditivo)));
            v_dsc_objeto_termo := RTRIM (LTRIM (UPPER (vi_dsc_objeto_termo)));
            v_num_dou_publicacao :=
                                RTRIM (LTRIM (UPPER (vi_num_dou_publicacao)));
            v_num_secao_publicacao :=
                              RTRIM (LTRIM (UPPER (vi_num_secao_publicacao)));
            v_num_pagina_publicacao :=
                             RTRIM (LTRIM (UPPER (vi_num_pagina_publicacao)));
            v_tip_termo_aditivo :=
                                 RTRIM (LTRIM (UPPER (vi_tip_termo_aditivo)));
            v_dat_termo_aditivo :=
                                  TO_DATE (vi_dat_termo_aditivo, 'DD/MM/YYYY');
            v_dat_publicacao := TO_DATE (vi_dat_publicacao, 'DD/MM/YYYY');
            v_num_seq_contrato_origem := vi_num_seq_contrato_origem;
            v_num_prazo := vi_num_prazo;
            v_flg_aum_dim := vi_flg_aum_dim;

            UPDATE ifrbde_views.cad_termo_aditivo_contrato
               SET dat_termo_aditivo = v_dat_termo_aditivo,
                   num_termo_aditivo = v_num_termo_aditivo,
                   dsc_objeto_termo = v_dsc_objeto_termo,
                   dat_publicacao = v_dat_publicacao,
                   num_dou_publicacao = v_num_dou_publicacao,
                   num_secao_publicacao = v_num_secao_publicacao,
                   num_pagina_publicacao = v_num_pagina_publicacao,
                   tip_termo_aditivo = v_tip_termo_aditivo,
                   num_prazo = v_num_prazo,
                   flg_aum_dim = v_flg_aum_dim
             WHERE  CURRENT OF c_cursor;

            IF SQL%ROWCOUNT = 1 THEN
               stp_pesquisa_termo_aditivo_con (
                  p_usuario,
                  vo_num_seq_termo_aditivo,
                  vo_num_seq_contrato_origem,
                  vo_dat_termo_aditivo,
                  vo_num_termo_aditivo,
                  vo_dsc_objeto_termo,
                  vo_dat_publicacao,
                  vo_num_dou_publicacao,
                  vo_num_secao_publicacao,
                  vo_num_pagina_publicacao,
                  vo_tip_termo_aditivo,
                  vo_num_prazo,
                  vo_flg_aum_dim,
                  vi_num_seq_termo_aditivo,
                  vi_num_seq_contrato_origem
               );
               -- LOG
               ifrbde_views.pck_seguranca.stp_log (
                  p_usuario,
                  'CAD_TERMO_ADITIVO_CONTRATO',
                  'A',
                  TO_CHAR (vi_num_seq_termo_aditivo)
                  || TO_CHAR (vi_num_seq_contrato_origem)
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

   
--------------------------------------------------------------------------------
   --------------------------------------------------------------------
   -- Pesquisa Conta Bancária
   -- retorna o recordset correspondente
   PROCEDURE stp_pesquisa_partic_contr_cont (
      p_usuario                           VARCHAR2,
      vo_num_seq_contrato_part   OUT      tyt_num_seq_contrato_part,
      vo_num_fir_cod             OUT      tyt_num_fir_cod,
      vo_num_seq_conta_part      OUT      tyt_num_seq_conta_part,
      vi_num_seq_contrato_part   IN       t_num_seq_contrato_part
   ) AS
   BEGIN
      IF ifrbde_views.pck_seguranca.stf_permitido (
            p_usuario,
            'CAD_PARTIC_CONTR_CONTA',
            'PESQUISA'
         ) THEN
         SELECT num_seq_contrato_part,
                num_fir_cod,
                num_seq_conta_part
           INTO vo_num_seq_contrato_part (1),
                vo_num_fir_cod (1),
                vo_num_seq_conta_part (1)
           FROM ifrbde_views.cad_partic_contr_conta
          WHERE num_seq_contrato_part = vi_num_seq_contrato_part;
      END IF;
   EXCEPTION
      WHEN OTHERS THEN
         raise_application_error (-20100, SQLERRM);
   END;

   -- Exclui Conta Bancária
   -- retorna o OK ou nao
   PROCEDURE stp_exclui_partic_contr_conta (
      p_usuario                           VARCHAR2,
      vo_ok                      OUT      tyt_ok,
      vi_num_seq_contrato_part   IN       t_num_seq_contrato_part
   ) AS
   BEGIN
      vo_ok (1) := 0;

      IF ifrbde_views.pck_seguranca.stf_permitido (
            p_usuario,
            'CAD_PARTIC_CONTR_CONTA',
            'EXCLUI'
         ) THEN
         DELETE FROM ifrbde_views.cad_partic_contr_conta
               WHERE num_seq_contrato_part = vi_num_seq_contrato_part;

         IF SQL%ROWCOUNT = 1 THEN
            vo_ok (1) := 1;
            -- LOG
            ifrbde_views.pck_seguranca.stp_log (
               p_usuario,
               'CAD_PARTIC_CONTR_CONTA',
               'E',
               TO_CHAR (vi_num_seq_contrato_part)
            );
            COMMIT;
         ELSIF SQL%ROWCOUNT > 1 THEN
            ROLLBACK;
         END IF;
      END IF;
   EXCEPTION
      WHEN OTHERS THEN
         raise_application_error (-20100, SQLERRM);
   END;

   
--------------------------------------------------------------------
-- Inclui Conta Bancária
-- retorna o recordset correspondente
   PROCEDURE stp_inclui_partic_contr_conta (
      p_usuario                           VARCHAR2,
      vo_num_seq_contrato_part   OUT      tyt_num_seq_contrato_part,
      vo_num_fir_cod             OUT      tyt_num_fir_cod,
      vo_num_seq_conta_part      OUT      tyt_num_seq_conta_part,
      vi_num_seq_contrato_part   IN       t_num_seq_contrato_part,
      vi_num_fir_cod             IN       t_num_fir_cod,
      vi_num_seq_conta_part      IN       t_num_seq_conta_part
   ) AS
      v_num_seq_contrato_part       cad_partic_contr_conta.num_seq_contrato_part%TYPE;
      v_num_fir_cod                 cad_partic_contr_conta.num_fir_cod%TYPE;
      v_num_seq_conta_part          cad_partic_contr_conta.num_seq_conta_part%TYPE;
   BEGIN
      IF ifrbde_views.pck_seguranca.stf_permitido (
            p_usuario,
            'CAD_PARTIC_CONTR_CONTA',
            'INCLUI'
         ) THEN
         v_num_seq_contrato_part := vi_num_seq_contrato_part;
         v_num_fir_cod := vi_num_fir_cod;
         v_num_seq_conta_part := vi_num_seq_conta_part;

         INSERT INTO ifrbde_views.cad_partic_contr_conta
                     (num_seq_contrato_part,
                      num_fir_cod,
                      num_seq_conta_part
                     )
              VALUES (v_num_seq_contrato_part,
                      v_num_fir_cod,
                      v_num_seq_conta_part
                     );

         IF SQL%ROWCOUNT = 1 THEN
            stp_pesquisa_partic_contr_cont (
               p_usuario,
               vo_num_seq_contrato_part,
               vo_num_fir_cod,
               vo_num_seq_conta_part,
               v_num_seq_contrato_part
            );
            -- LOG
            ifrbde_views.pck_seguranca.stp_log (
               p_usuario,
               'CAD_PARTIC_CONTR_CONTA',
               'I',
               TO_CHAR (vi_num_seq_contrato_part)
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
-- Altera Conta Bancária
-- retorna o recordset correspondente
   PROCEDURE stp_altera_partic_contr_conta (
      p_usuario                           VARCHAR2,
      vo_num_seq_contrato_part   OUT      tyt_num_seq_contrato_part,
      vo_num_fir_cod             OUT      tyt_num_fir_cod,
      vo_num_seq_conta_part      OUT      tyt_num_seq_conta_part,
      vi_num_seq_contrato_part   IN       t_num_seq_contrato_part,
      vi_num_fir_cod             IN       t_num_fir_cod,
      vi_num_seq_conta_part      IN       t_num_seq_conta_part
   ) AS
      CURSOR c_cursor IS
         SELECT     *
               FROM ifrbde_views.cad_partic_contr_conta
              WHERE num_seq_contrato_part = vi_num_seq_contrato_part
         FOR UPDATE;

      v_cad_partic_contr_conta      ifrbde_views.cad_partic_contr_conta%ROWTYPE;
      v_num_seq_contrato_part       ifrbde_views.cad_partic_contr_conta.num_seq_contrato_part%TYPE;
      v_num_fir_cod                 ifrbde_views.cad_partic_contr_conta.num_fir_cod%TYPE;
      v_num_seq_conta_part          ifrbde_views.cad_partic_contr_conta.num_seq_conta_part%TYPE;
   BEGIN
      IF ifrbde_views.pck_seguranca.stf_permitido (
            p_usuario,
            'CAD_PARTIC_CONTR_CONTA',
            'ALTERA'
         ) THEN
         OPEN c_cursor;
         FETCH c_cursor INTO v_cad_partic_contr_conta;

         IF NOT c_cursor%NOTFOUND THEN
            v_num_seq_contrato_part := vi_num_seq_contrato_part;
            v_num_fir_cod := vi_num_fir_cod;
            v_num_seq_conta_part := vi_num_seq_conta_part;

            UPDATE ifrbde_views.cad_partic_contr_conta
               SET num_fir_cod = v_num_fir_cod,
                   num_seq_conta_part = v_num_seq_conta_part
             WHERE  CURRENT OF c_cursor;

            IF SQL%ROWCOUNT = 1 THEN
               stp_pesquisa_partic_contr_cont (
                  p_usuario,
                  vo_num_seq_contrato_part,
                  vo_num_fir_cod,
                  vo_num_seq_conta_part,
                  vi_num_seq_contrato_part
               );
               -- LOG
               ifrbde_views.pck_seguranca.stp_log (
                  p_usuario,
                  'CAD_PARTIC_CONTR_CONTA',
                  'A',
                  TO_CHAR (vi_num_seq_contrato_part)
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
--FIM DA PACKAGE
END;
/


-- End of DDL Script for Package IFRBDE_VIEWS.PCK_CONTRATO


