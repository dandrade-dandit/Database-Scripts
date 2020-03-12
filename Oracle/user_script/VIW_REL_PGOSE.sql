/* Formatted on 2003/10/17 10:18 (Formatter Plus v4.5.2) */
-- Start of DDL Script for View IFRBDE.VIW_REL_PGOSE
-- Generated 16/10/2003 16:50:07 from CTIS791@PRODSEDE.WORLD

CREATE OR REPLACE VIEW ifrbde.viw_rel_pgose (
   projeto,
   cncod,
   cndesc,
   cnsigla,
   depcod,
   depdesc,
   depsigla,
   sequencial,
   descricao,
   recurso,
   valor,
   prioridade,
   inicio,
   termino,
   pgose,
   tipo,
   vlobras,
   natureza,
   ccontabil,
   percentual
)
AS
   SELECT DISTINCT cre.cre_projeto, cn.dpp_cod, cn.dpp_desc, cn.dpp_sigla,
                   dep.dep_cod, dep.dep_desc, dep.dep_sigla, cre.cre_cod,
                   cre.cre_desc, rti.rti_sigla, rap.rap_valor,
                   cre.cre_prior_cnl, cre.cre_inicio, cre.cre_termino,
                   rap.rap_pgose, cre.cre_tipo, cre.cre_vlobras, ntf.ntf_desc,
                   rti.rti_conta,
                   ROUND (
                      rap.rap_valor * 100 / cre.cre_vlobras
                   )
              FROM ifrbde_views.tab_dependencia_pai cn,
                   ifrbde_views.tab_dependencia dep,
                   ifrbde_views.tab_carencia cre,
                   ifrbde_views.tab_rec_aprovado rap,
                   ifrbde_views.tab_tipo_recurso_item rti,
                   ifrbde_views.tab_natureza_obra_fil ntf
             WHERE cn.dpp_cod = dep.dep_dpp_cod
               AND cre.cre_dep_cod = dep.dep_cod
               AND rap.rap_cre_cod = cre.cre_cod
               AND rap.rap_rti_cod = rti.rti_cod
               AND cre.cre_ntf_cod = ntf.ntf_cod
          ORDER BY 1 DESC, 3 ASC, 5 ASC, 6 ASC
/

-- Grants for View
GRANT SELECT ON ifrbde.viw_rel_pgose TO bde_geral
/
GRANT SELECT ON ifrbde.viw_rel_pgose TO bde_views
/

-- End of DDL Script for View IFRBDE.VIW_REL_PGOSE

