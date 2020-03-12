-- Start of DDL Script for View IFRBDE.VIW_REL_CARENCIA_NP
-- Generated 16-mar-2005 10:27:15 from IFRBDE@HOMOLOG2

CREATE OR REPLACE VIEW ifrbde.viw_rel_carencia_np (
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
   vlobras )
AS
SELECT DISTINCT cre.cre_projeto, cn.dpp_cod, cn.dpp_desc, cn.dpp_sigla,
                dep.dep_cod, dep.dep_desc, dep.dep_sigla, dep.dep_uf,
                dep.dep_cod_regiao, cre.cre_cod,
                UPPER (SUBSTR (cre.cre_desc, 1, 100)),
                UPPER (SUBSTR (cre.cre_justificativa, 1, 100)),
                cre.cre_tipo, cre.cre_vlobras
           FROM ifrbde.tab_dependencia_pai cn,
                ifrbde.tab_dependencia dep,
                ifrbde.tab_carencia cre
          WHERE cn.dpp_cod = dep.dep_dpp_cod
            AND dep.dep_cod = cre.cre_dep_cod
/

-- End of DDL Script for View IFRBDE.VIW_REL_CARENCIA_NP

