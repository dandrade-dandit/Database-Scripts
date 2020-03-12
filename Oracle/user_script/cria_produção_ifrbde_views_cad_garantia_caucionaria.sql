CREATE OR REPLACE VIEW ifrbde_views.cad_garantia_caucionaria (
   num_seq_garantia,
   num_seq_contrato_gar,
   dat_operacao,
   dat_vencimento,
   dat_devolucao,
   val_custodia,
   num_documento,
   cod_origem,
   nom_origem,
   sit_custodia,
   dsc_observacao,
   num_contrato,
   tip_garantia,
   tip_operacao,
   dat_carga_fin )
AS
SELECT num_seq_garantia,
       num_seq_contrato_gar,
       dat_operacao,
       dat_vencimento,
       dat_devolucao,
       val_custodia,
       num_documento,
       cod_origem,
       nom_origem,
       sit_custodia,
       dsc_observacao,
       num_contrato,
       tip_garantia,
       tip_operacao,
       dat_carga_fin
FROM IFRBDE.CAD_GARANTIA_CAUCIONARIA
/


-- End of DDL Script for View IFRBDE_VIEWS.CAD_GARANTIA_CAUCIONARIA


