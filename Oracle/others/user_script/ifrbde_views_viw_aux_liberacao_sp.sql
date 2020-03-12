CREATE OR REPLACE VIEW ifrbde_views.viw_aux_liberacao_sp (
   cnt_cre_cod_aux,
   cnt_cod_aux,
   num_fatura_sp,
   dat_liberacao,
   dat_inclusao,
   cod_tipo_pag_rp,
   num_ano_realizacao )
AS
SELECT cnt_cre_cod_aux,
       cnt_cod_aux,
       num_fatura_sp,
       dat_liberacao,
       dat_inclusao,
       cod_tipo_pag_rp,
       num_ano_realizacao
  FROM ifrbde.aux_liberacao_sp
/

-- Grants for View
GRANT DELETE ON ifrbde_views.viw_aux_liberacao_sp TO bde_views
/
GRANT INSERT ON ifrbde_views.viw_aux_liberacao_sp TO bde_views
/
GRANT SELECT ON ifrbde_views.viw_aux_liberacao_sp TO bde_views
/
GRANT UPDATE ON ifrbde_views.viw_aux_liberacao_sp TO bde_views
/
GRANT DELETE ON ifrbde_views.viw_aux_liberacao_sp TO bde_geral
/
GRANT INSERT ON ifrbde_views.viw_aux_liberacao_sp TO bde_geral
/
GRANT SELECT ON ifrbde_views.viw_aux_liberacao_sp TO bde_geral
/
GRANT UPDATE ON ifrbde_views.viw_aux_liberacao_sp TO bde_geral
/
GRANT DELETE ON ifrbde_views.viw_aux_liberacao_sp TO ifrbde
/
GRANT INSERT ON ifrbde_views.viw_aux_liberacao_sp TO ifrbde
/
GRANT SELECT ON ifrbde_views.viw_aux_liberacao_sp TO ifrbde
/
GRANT UPDATE ON ifrbde_views.viw_aux_liberacao_sp TO ifrbde
/

-- End of DDL Script for View IFRBDE_VIEWS.VIW_AUX_LIBERACAO_SP


