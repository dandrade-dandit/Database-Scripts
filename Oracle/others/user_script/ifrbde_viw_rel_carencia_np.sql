-- Start of DDL Script for View IFRBDE.VIW_REL_CARENCIA_NP
-- Generated 9-jun-2005 15:37:49 from IFRBDE@PRODSEDE2

CREATE OR REPLACE VIEW viw_rel_carencia_np (
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
   justificativa,
   tipo,
   vlobras,
   natureza,
   ano )
AS
SELECT DISTINCT cre.cre_projeto, cn.dpp_cod, cn.dpp_desc, cn.dpp_sigla,
                dep.dep_cod, dep.dep_desc, dep.dep_sigla, dep.dep_uf,
                dep.dep_cod_regiao, cre.cre_cod,
                UPPER (SUBSTR (cre.cre_desc, 1, 100)),
                UPPER (SUBSTR (cre.cre_justificativa, 1, 100)),
                cre.cre_tipo,
                cre.cre_vlobras,
                rap.rap_pgose,
                nat.ntf_desc
           FROM ifrbde.tab_dependencia_pai cn,
                ifrbde.tab_dependencia dep,
                ifrbde.tab_carencia cre,
                ifrbde.tab_rec_aprovado rap,
                ifrbde.tab_natureza_obra_fil nat
          WHERE cn.dpp_cod = dep.dep_dpp_cod
            AND dep.dep_cod = cre.cre_dep_cod
            and nat.ntf_cod = cre.cre_ntf_cod
            and rap.rap_cre_cod(+) = cre.cre_cod
            and rap.rap_pgose is null

/

-- Grants for View
GRANT SELECT ON viw_rel_carencia_np TO bde_geral
/

-- End of DDL Script for View IFRBDE.VIW_REL_CARENCIA_NP

