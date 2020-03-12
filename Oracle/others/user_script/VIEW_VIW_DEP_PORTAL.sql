-- Start of DDL Script for View IFRSRH.VIW_DEP_PORTAL
-- Generated 12-fev-2004 15:52:46 from IFRSRH@MAQUINA4.WORLD

CREATE OR REPLACE VIEW VIW_DEP_PORTAL (
   dep_codigo,
   dep_sigla,
   dep_nome,
   dep_data_criacao,
   dep_data_extincao,
   dep_ufe_sigla,
   dep_dep_codigo )
AS
select
              "DEP_CODIGO",
              "DEP_SIGLA",
              "DEP_NOME",
              "DEP_DATA_CRIACAO",
              "DEP_DATA_EXTINCAO",
              "DEP_UFE_SIGLA",
              "DEP_DEP_CODIGO"
       from DEPENDENCIAS
/

-- Grants for View
GRANT SELECT ON viw_dep_portal TO rh_perfil_99
/
GRANT SELECT ON viw_dep_portal TO srh_portal_licitacoes
/

-- End of DDL Script for View IFRSRH.VIW_DEP_PORTAL

