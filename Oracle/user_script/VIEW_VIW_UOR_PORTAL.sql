-- Start of DDL Script for View IFRSRH.VIW_UOR_PORTAL
-- Generated 12-fev-2004 15:53:15 from IFRSRH@MAQUINA4.WORLD

CREATE OR REPLACE VIEW VIW_UOR_PORTAL (
   uor_codigo,
   uor_sigla,
   uor_nome,
   uor_data_criacao,
   uor_data_extincao,
   uor_ufe_sigla,
   uor_uor_codigo )
AS
select
              "UOR_CODIGO",
              "UOR_SIGLA",
              "UOR_NOME",
              "UOR_DATA_CRIACAO",
              "UOR_DATA_EXTINCAO",
              "UOR_UFE_SIGLA",
              "UOR_UOR_CODIGO"
       from UNIDADES_ORGANIZACIONAIS
/

-- Grants for View
GRANT SELECT ON viw_uor_portal TO rh_perfil_99
/
GRANT SELECT ON viw_uor_portal TO srh_portal_licitacoes
/

-- End of DDL Script for View IFRSRH.VIW_UOR_PORTAL

