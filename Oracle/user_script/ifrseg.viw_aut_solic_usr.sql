-- Start of DDL Script for View IFRSEG.VIW_AUT_SOLIC_USR
-- Generated 2-dez-2004 19:27:04 from SYSMAN@HOMOLOG2

CREATE OR REPLACE VIEW ifrseg.viw_aut_solic_usr (
   num_seq_solicitacao,
   cod_infraero_contratada,
   flg_infraero_contratada,
   cod_depend_usr_solic,
   nom_username_solic,
   nom_usuario_solic,
   sgl_unidade_solic,
   num_cpf_solic,
   dsc_email_solic,
   dat_aprovacao,
   flg_situacao_solic,
   dat_solicitacao,
   dsc_motivo_nao_aprov_solic,
   cod_infraero_cont_solic,
   flg_tipo_solicitacao, 
   dsc_nome )
AS
SELECT num_seq_solicitacao,
       cod_infraero_contratada,
       flg_infraero_contratada,
       cod_depend_usr_solic,
       nom_username_solic,
       nom_usuario_solic,
       sgl_unidade_solic,
       num_cpf_solic,
       dsc_email_solic,
       dat_aprovacao,
       flg_situacao_solic,
       dat_solicitacao,
       dsc_motivo_nao_aprov_solic,
       cod_infraero_cont_solic,
       flg_tipo_solicitacao,
       dsc_nome
  FROM cad_solicitacao_usuario, viw_empregado_infraero
 WHERE flg_tipo_solicitacao IN (1, 2) AND flg_situacao_solic <> 'I'
   and cod_infraero_cont_solic=cod_matricula(+)
/
-- Grants for View
GRANT DELETE ON ifrseg.viw_aut_solic_usr TO seg_geral
/
GRANT INSERT ON ifrseg.viw_aut_solic_usr TO seg_geral
/
GRANT SELECT ON ifrseg.viw_aut_solic_usr TO seg_geral
/
GRANT UPDATE ON ifrseg.viw_aut_solic_usr TO seg_geral
/

-- End of DDL Script for View IFRSEG.VIW_AUT_SOLIC_USR

