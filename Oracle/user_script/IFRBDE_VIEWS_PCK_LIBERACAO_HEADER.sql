CREATE OR REPLACE PACKAGE PCK_LIBERACAO
IS
   -- tipos globais

   TYPE tyt_ok IS TABLE OF NUMBER (1)
      INDEX BY BINARY_INTEGER;

   SUBTYPE t_data IS CHAR (10);

   TYPE tyt_data IS TABLE OF t_data
      INDEX BY BINARY_INTEGER;

   
--------------------------------------------------------------------------------
   --- VIW_TAB_CONTRATO
   SUBTYPE t_cnt_cre_cod IS ifrbde_views.viw_tab_contrato.cnt_cre_cod%TYPE;

   SUBTYPE t_cnt_cod IS ifrbde_views.viw_tab_contrato.cnt_cod%TYPE;

   TYPE tyt_cnt_cre_cod IS TABLE OF t_cnt_cre_cod
      INDEX BY BINARY_INTEGER;

   TYPE tyt_cnt_cod IS TABLE OF t_cnt_cod
      INDEX BY BINARY_INTEGER;

   PROCEDURE stp_pesquisa_tab_contrato (
      p_usuario                 VARCHAR2,
      vo_cnt_cre_cod   OUT      tyt_cnt_cre_cod,
      vo_cnt_cod       OUT      tyt_cnt_cod,
      vi_cnt_cre_cod   IN       t_cnt_cre_cod,
      vi_cnt_cod       IN       t_cnt_cod
   );

   PROCEDURE stp_exclui_tab_contrato (
      p_usuario                 VARCHAR2,
      vo_ok            OUT      tyt_ok,
      vi_cnt_cre_cod   IN       t_cnt_cre_cod,
      vi_cnt_cod       IN       t_cnt_cod
   );

   PROCEDURE stp_inclui_tab_contrato (
      p_usuario                 VARCHAR2,
      vo_cnt_cre_cod   OUT      tyt_cnt_cre_cod,
      vo_cnt_cod       OUT      tyt_cnt_cod,
      vi_cnt_cre_cod   IN       t_cnt_cre_cod,
      vi_cnt_cod       IN       t_cnt_cod
   );

   PROCEDURE stp_altera_tab_contrato (
      p_usuario                 VARCHAR2,
      vo_cnt_cre_cod   OUT      tyt_cnt_cre_cod,
      vo_cnt_cod       OUT      tyt_cnt_cod,
      vi_cnt_cre_cod   IN       t_cnt_cre_cod,
      vi_cnt_cod       IN       t_cnt_cod
   );

   
--------------------------------------------------------------------------------
   --- VIW_RESUMO_PAGAMENTO_LIB
   SUBTYPE t_cnt_cre_cod_r IS ifrbde_views.viw_resumo_pagamento_lib.cnt_cre_cod_r%TYPE;

   SUBTYPE t_cnt_cod_r IS ifrbde_views.viw_resumo_pagamento_lib.cnt_cod_r%TYPE;

   SUBTYPE t_num_fatura_rp IS ifrbde_views.viw_resumo_pagamento_lib.num_fatura_rp%TYPE;

   SUBTYPE t_val_pagamento_rp IS ifrbde_views.viw_resumo_pagamento_lib.val_pagamento_rp%TYPE;

   SUBTYPE t_dat_pagamento IS t_data;

   TYPE tyt_cnt_cre_cod_r IS TABLE OF t_cnt_cre_cod_r
      INDEX BY BINARY_INTEGER;

   TYPE tyt_cnt_cod_r IS TABLE OF t_cnt_cod_r
      INDEX BY BINARY_INTEGER;

   TYPE tyt_num_fatura_rp IS TABLE OF t_num_fatura_rp
      INDEX BY BINARY_INTEGER;

   TYPE tyt_val_pagamento_rp IS TABLE OF t_val_pagamento_rp
      INDEX BY BINARY_INTEGER;

   TYPE tyt_dat_pagamento IS TABLE OF t_dat_pagamento
      INDEX BY BINARY_INTEGER;

   PROCEDURE stp_pesquisa_resumo_pagamento_ (
      p_usuario                      VARCHAR2,
      vo_cnt_cre_cod_r      OUT      tyt_cnt_cre_cod_r,
      vo_cnt_cod_r          OUT      tyt_cnt_cod_r,
      vo_num_fatura_rp      OUT      tyt_num_fatura_rp,
      vo_val_pagamento_rp   OUT      tyt_val_pagamento_rp,
      vo_dat_pagamento      OUT      tyt_dat_pagamento,
      vi_cnt_cre_cod_r      IN       t_cnt_cre_cod_r,
      vi_cnt_cod_r          IN       t_cnt_cod_r,
      vi_num_fatura_rp      IN       t_num_fatura_rp
   );

   PROCEDURE stp_exclui_resumo_pagamento_li (
      p_usuario                   VARCHAR2,
      vo_ok              OUT      tyt_ok,
      vi_cnt_cre_cod_r   IN       t_cnt_cre_cod_r,
      vi_cnt_cod_r       IN       t_cnt_cod_r,
      vi_num_fatura_rp   IN       t_num_fatura_rp
   );

   PROCEDURE stp_inclui_resumo_pagamento_li (
      p_usuario                      VARCHAR2,
      vo_cnt_cre_cod_r      OUT      tyt_cnt_cre_cod_r,
      vo_cnt_cod_r          OUT      tyt_cnt_cod_r,
      vo_num_fatura_rp      OUT      tyt_num_fatura_rp,
      vo_val_pagamento_rp   OUT      tyt_val_pagamento_rp,
      vo_dat_pagamento      OUT      tyt_dat_pagamento,
      vi_cnt_cre_cod_r      IN       t_cnt_cre_cod_r,
      vi_cnt_cod_r          IN       t_cnt_cod_r,
      vi_num_fatura_rp      IN       t_num_fatura_rp,
      vi_val_pagamento_rp   IN       t_val_pagamento_rp,
      vi_dat_pagamento      IN       t_dat_pagamento
   );

   PROCEDURE stp_altera_resumo_pagamento_li (
      p_usuario                      VARCHAR2,
      vo_cnt_cre_cod_r      OUT      tyt_cnt_cre_cod_r,
      vo_cnt_cod_r          OUT      tyt_cnt_cod_r,
      vo_num_fatura_rp      OUT      tyt_num_fatura_rp,
      vo_val_pagamento_rp   OUT      tyt_val_pagamento_rp,
      vo_dat_pagamento      OUT      tyt_dat_pagamento,
      vi_cnt_cre_cod_r      IN       t_cnt_cre_cod_r,
      vi_cnt_cod_r          IN       t_cnt_cod_r,
      vi_num_fatura_rp      IN       t_num_fatura_rp,
      vi_val_pagamento_rp   IN       t_val_pagamento_rp,
      vi_dat_pagamento      IN       t_dat_pagamento
   );

   
--------------------------------------------------------------------------------
   --- VIW_AUX_LIBERACAO_SP
   SUBTYPE t_cnt_cre_cod_aux IS ifrbde_views.viw_aux_liberacao_sp.cnt_cre_cod_aux%TYPE;

   SUBTYPE t_cnt_cod_aux IS ifrbde_views.viw_aux_liberacao_sp.cnt_cod_aux%TYPE;

   SUBTYPE t_num_fatura_sp IS ifrbde_views.viw_aux_liberacao_sp.num_fatura_sp%TYPE;

   SUBTYPE t_dat_liberacao IS t_data;

   SUBTYPE t_dat_inclusao IS t_data;

   TYPE tyt_cnt_cre_cod_aux IS TABLE OF t_cnt_cre_cod_aux
      INDEX BY BINARY_INTEGER;

   TYPE tyt_cnt_cod_aux IS TABLE OF t_cnt_cod_aux
      INDEX BY BINARY_INTEGER;

   TYPE tyt_num_fatura_sp IS TABLE OF t_num_fatura_sp
      INDEX BY BINARY_INTEGER;

   TYPE tyt_dat_liberacao IS TABLE OF t_dat_liberacao
      INDEX BY BINARY_INTEGER;

   TYPE tyt_dat_inclusao IS TABLE OF t_dat_inclusao
      INDEX BY BINARY_INTEGER;

   PROCEDURE stp_pesquisa_aux_liberacao_sp (
      p_usuario                     VARCHAR2,
      vo_cnt_cre_cod_aux   OUT      tyt_cnt_cre_cod_aux,
      vo_cnt_cod_aux       OUT      tyt_cnt_cod_aux,
      vo_num_fatura_sp     OUT      tyt_num_fatura_sp,
      vo_dat_liberacao     OUT      tyt_dat_liberacao,
      vo_dat_inclusao      OUT      tyt_dat_inclusao,
      vi_cnt_cre_cod_aux   IN       t_cnt_cre_cod_aux,
      vi_cnt_cod_aux       IN       t_cnt_cod_aux,
      vi_num_fatura_sp     IN       t_num_fatura_sp,
      vi_dat_liberacao     IN       t_dat_liberacao
   );

   PROCEDURE stp_exclui_aux_liberacao_sp (
      p_usuario                     VARCHAR2,
      vo_ok                OUT      tyt_ok,
      vi_cnt_cre_cod_aux   IN       t_cnt_cre_cod_aux,
      vi_cnt_cod_aux       IN       t_cnt_cod_aux,
      vi_num_fatura_sp     IN       t_num_fatura_sp,
      vi_dat_liberacao     IN       t_dat_liberacao
   );

   PROCEDURE stp_inclui_aux_liberacao_sp (
      p_usuario                     VARCHAR2,
      vo_cnt_cre_cod_aux   OUT      tyt_cnt_cre_cod_aux,
      vo_cnt_cod_aux       OUT      tyt_cnt_cod_aux,
      vo_num_fatura_sp     OUT      tyt_num_fatura_sp,
      vo_dat_liberacao     OUT      tyt_dat_liberacao,
      vo_dat_inclusao      OUT      tyt_dat_inclusao,
      vi_cnt_cre_cod_aux   IN       t_cnt_cre_cod_aux,
      vi_cnt_cod_aux       IN       t_cnt_cod_aux,
      vi_num_fatura_sp     IN       t_num_fatura_sp,
      vi_dat_liberacao     IN       t_dat_liberacao,
      vi_dat_inclusao      IN       t_dat_inclusao
   );

   PROCEDURE stp_altera_aux_liberacao_sp (
      p_usuario                     VARCHAR2,
      vo_cnt_cre_cod_aux   OUT      tyt_cnt_cre_cod_aux,
      vo_cnt_cod_aux       OUT      tyt_cnt_cod_aux,
      vo_num_fatura_sp     OUT      tyt_num_fatura_sp,
      vo_dat_liberacao     OUT      tyt_dat_liberacao,
      vo_dat_inclusao      OUT      tyt_dat_inclusao,
      vi_cnt_cre_cod_aux   IN       t_cnt_cre_cod_aux,
      vi_cnt_cod_aux       IN       t_cnt_cod_aux,
      vi_num_fatura_sp     IN       t_num_fatura_sp,
      vi_dat_liberacao     IN       t_dat_liberacao,
      vi_dat_inclusao      IN       t_dat_inclusao
   );
END; -- Package spec

