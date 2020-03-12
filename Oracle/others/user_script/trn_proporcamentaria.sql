
-- Start of DDL script for TRN_PROPORCAMENTARIA
-- Generated 7-jan-03  3:11:51 pm
-- from prodsede-CTIS713:1

-- View TRN_PROPORCAMENTARIA

CREATE OR REPLACE VIEW trn_proporcamentaria (
   ano,
   dep_cod_dependencia,
   no_dependencia,
   cc2_cd_centro_custo,
   ds_centro_custo,
   cc1_nr_conta,
   no_conta,
   prj_cd_projeto,
   ds_projeto,
   val_jan,
   val_fev,
   val_mar,
   val_abr,
   val_mai,
   val_jun,
   val_jul,
   val_ago,
   val_set,
   val_out,
   val_nov,
   val_dez,
   val_total )
AS
select
  t1.vsp_nr_ano                num_ano,
  t1.dep_cd_dependencia        cod_dep,
  t2.no_dependencia            nom_dep,
  t1.cc2_cd_centro_custo       cod_centro_custo,
  t3.ds_centro_custo           nom_centro_custo,
  t1.cc1_nr_conta              num_conta,
  t4.no_conta                  nom_conta,
  t1.prj_cd_projeto            cod_projeto,
  t5.ds_projeto                nom_projeto,
  sum(decode(vl_unitario_item,null,val_jan,vl_unitario_item*qtd_jan))
  val_jan,
  sum(decode(vl_unitario_item,null,val_fev,vl_unitario_item*qtd_fev))
  val_fev,
  sum(decode(vl_unitario_item,null,val_mar,vl_unitario_item*qtd_mar))
  val_mar,
  sum(decode(vl_unitario_item,null,val_abr,vl_unitario_item*qtd_abr))
  val_abr,
  sum(decode(vl_unitario_item,null,val_mai,vl_unitario_item*qtd_mai))
  val_mai,
  sum(decode(vl_unitario_item,null,val_jun,vl_unitario_item*qtd_jun))
  val_jun,
  sum(decode(vl_unitario_item,null,val_jul,vl_unitario_item*qtd_jul))
  val_jul,
  sum(decode(vl_unitario_item,null,val_ago,vl_unitario_item*qtd_ago))
  val_ago,
  sum(decode(vl_unitario_item,null,val_set,vl_unitario_item*qtd_set))
  val_set,
  sum(decode(vl_unitario_item,null,val_out,vl_unitario_item*qtd_out))
  val_out,
  sum(decode(vl_unitario_item,null,val_nov,vl_unitario_item*qtd_nov))
  val_nov,
  sum(decode(vl_unitario_item,null,val_dez,vl_unitario_item*qtd_dez))
  val_dez,
  sum(decode(vl_unitario_item,
             null,
             val_jan+val_fev+val_mar+val_abr+val_mai+val_jun+
             val_jul+val_ago+val_set+val_out+val_nov+val_dez,
             vl_unitario_item*(qtd_jan+qtd_fev+qtd_mar+
                               qtd_abr+qtd_mai+qtd_jun+
                               qtd_jul+qtd_ago+qtd_set+
                               qtd_out+qtd_nov+qtd_dez))) val_total
  from item_proposta_orc_simulada t1,
       dependencia t2,
       centro_custo t3,
       conta_contabil t4,
       projeto t5
  where vsp_nr_ano >= 2002
    and rtrim(vsp_cd_nivel_versao) = '3'
    and rtrim(vsp_cd_versao) = '8'
    and cc1_nr_conta in ('31103011','31103012','31103013')
    and t1.dep_cd_dependencia = t2.cd_dependencia
    and t1.cc2_cd_centro_custo = t3.cd_centro_custo
    and t1.cc1_nr_conta = t4.nr_conta
    and t1.prj_cd_projeto = t5.cd_projeto
  group by
  t1.vsp_nr_ano,
  t1.dep_cd_dependencia,
  t2.no_dependencia,
  t1.cc2_cd_centro_custo,
  t3.ds_centro_custo,
  t1.cc1_nr_conta,
  t4.no_conta,
  t1.prj_cd_projeto,
  t5.ds_projeto
/

-- Grants for TRN_PROPORCAMENTARIA

GRANT SELECT ON trn_proporcamentaria TO srh_trn_01
/

-- End of DDL script for TRN_PROPORCAMENTARIA
