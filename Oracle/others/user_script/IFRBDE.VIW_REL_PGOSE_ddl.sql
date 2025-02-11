-- Start of DDL Script for View IFRBDE.VIW_REL_PGOSE
-- Generated 3-nov-2004 11:23:14 from IFRBDE@HOMOLOG2

-- Drop the old instance of VIW_REL_PGOSE
DROP VIEW ifrbde.viw_rel_pgose
/

CREATE OR REPLACE VIEW ifrbde.viw_rel_pgose (
   projeto,
   cncod,
   cndesc,
   cnsigla,
   depcod,
   depdesc,
   depsigla,
   depuf,
   depregiao,
   sequencial,
   descricao,
   recurso,
   recursodesc,
   valor,
   valorpago,
   inicio,
   termino,
   pgose,
   tipo,
   vlobras,
   ccontabil,
   natureza,
   natureza_desc,
   recursocod,
   rctcod,
   pgi,
   cliente,
   situacao,
   justificativa,
   percentual,
   prioridade,
   area_envolvida )
AS
SELECT   cre.cre_projeto,
         cn.dpp_cod,
         cn.dpp_desc,
         cn.dpp_sigla,
         dep.dep_cod,
         dep.dep_desc,
         dep.dep_sigla,
         dep.dep_uf,
         dep.dep_cod_regiao,
         cre.cre_cod,
         UPPER (TO_CHAR (cre.cre_desc)),
         rti.rti_sigla,
         rti.rti_desc,
         rap.rap_valor,
         rap.rap_valor_pago,
         cre.cre_inicio,
         cre.cre_termino,
         TO_NUMBER (rap.rap_pgose),
         cre.cre_tipo,
         cre.cre_vlobras,
         rti.rti_conta,
         vnt.desc_natureza,
         vnt.natureza,
         rti.rti_cod,
         rct.rct_cod,
         rap.rap_cre_pgi,
         vdc.dsc_cliente_completo,
         num_situacao_carencia,
         UPPER (TO_CHAR (cre.cre_justificativa)),
         ROUND (rap.rap_valor * 100 / cre.cre_vlobras),
         cre.num_prioridade_carencia,
         cre.cre_aen_subcod
    FROM ifrbde.tab_dependencia_pai cn,
         ifrbde.tab_dependencia dep,
         ifrbde.tab_carencia cre,
         ifrbde.tab_rec_aprovado rap,
         ifrbde.tab_tipo_recurso_item rti,
         ifrbde.tab_tipo_recurso rct,
         ifrbde.viw_natureza vnt,
         ifrbde.viw_detalhe_cliente vdc,
         ifrbde.tab_area_envolvida aen
   WHERE cn.dpp_cod = dep.dep_dpp_cod
     AND cre.cre_dep_cod = dep.dep_cod
     AND rap.rap_cre_cod = cre.cre_cod
     AND rap.rap_rti_cod = rti.rti_cod
     AND rti.rti_rct_cod = rct.rct_cod
     AND cre.cre_ntf_cod = vnt.codigo
     AND cre.cre_aen_subcod = aen.aen_subcod
     AND cre.cod_detalhe_cliente = vdc.seq_detalhe
ORDER BY 1 DESC,
         3 ASC,
         5 ASC,
         6 ASC
/

-- Grants for View
GRANT DELETE ON ifrbde.viw_rel_pgose TO ifrseg
/
GRANT INSERT ON ifrbde.viw_rel_pgose TO ifrseg
/
GRANT SELECT ON ifrbde.viw_rel_pgose TO ifrseg
/
GRANT UPDATE ON ifrbde.viw_rel_pgose TO ifrseg
/
GRANT SELECT ON ifrbde.viw_rel_pgose TO bde_geral
/

-- End of DDL Script for View IFRBDE.VIW_REL_PGOSE

