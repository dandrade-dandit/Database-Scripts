-- Start of DDL Script for View IFRBDE.VIW_REL_QUINQUENAL
-- Generated 3-nov-2004 11:23:43 from IFRBDE@HOMOLOG2

-- Drop the old instance of VIW_REL_QUINQUENAL
DROP VIEW ifrbde.viw_rel_quinquenal
/

CREATE OR REPLACE VIEW ifrbde.viw_rel_quinquenal (
   projeto,
   cncod,
   cndesc,
   depcod,
   depdesc,
   sequencial,
   descricao,
   justificativa,
   previsto,
   recurso,
   contacontabil,
   ano,
   valor,
   area,
   ardesc,
   arenvolvida )
AS
SELECT DISTINCT cre.cre_projeto, cn.dpp_cod, cn.dpp_sigla, dep.dep_cod,
                   dep.dep_desc, cre.cre_cod, cre.cre_desc,
                   cre.cre_justificativa, cre.cre_vlobras, rti.rti_sigla,
                   rti.rti_conta, rap.rap_pgose, rap.rap_valor, ARE.are_cod,
                   ARE.are_desc,
                   cre.cre_aen_subcod
              FROM ifrbde.tab_dependencia_pai cn,
                   ifrbde.tab_dependencia dep,
                   ifrbde.tab_carencia cre,
                   ifrbde.tab_rec_aprovado rap,
                   ifrbde.tab_tipo_recurso_item rti,
                   ifrbde.tab_natureza_obra_fil ntf,
                   ifrbde.tab_area ARE,
                   ifrbde.tab_area_envolvida aen
             WHERE cn.dpp_cod = dep.dep_dpp_cod AND
                   cre.cre_dep_cod = dep.dep_cod AND
                   rap.rap_cre_cod = cre.cre_cod AND
                   rap.rap_rti_cod = rti.rti_cod AND
                   cre.cre_ntf_cod = ntf.ntf_cod AND
                   cre.cre_aen_subcod = aen.aen_subcod AND
                   aen.aen_cod = ARE.are_cod
          ORDER BY 1 DESC, 3, 5, 6, 11
/

-- Grants for View
GRANT DELETE ON ifrbde.viw_rel_quinquenal TO ifrseg
/
GRANT INSERT ON ifrbde.viw_rel_quinquenal TO ifrseg
/
GRANT SELECT ON ifrbde.viw_rel_quinquenal TO ifrseg
/
GRANT UPDATE ON ifrbde.viw_rel_quinquenal TO ifrseg
/
GRANT SELECT ON ifrbde.viw_rel_quinquenal TO bde_geral
/

-- End of DDL Script for View IFRBDE.VIW_REL_QUINQUENAL

