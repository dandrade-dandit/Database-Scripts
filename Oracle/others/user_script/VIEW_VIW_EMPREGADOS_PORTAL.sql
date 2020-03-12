-- Start of DDL Script for View IFRSRH.VIW_EMPREGADOS_PORTAL
-- Generated 12-fev-2004 15:52:02 from IFRSRH@MAQUINA4.WORLD

CREATE OR REPLACE VIEW VIW_EMPREGADOS_PORTAL (
   emp_numero_matricula,
   emp_nome,
   emp_endeco_eletronico_mail,
   emp_status )
AS
select
              "EMP_NUMERO_MATRICULA",
              "EMP_NOME",
              "EMP_ENDERECO_ELETRONICO_MAIL",
              "EMP_STATUS"
       from   CADASTROS
/

-- Grants for View
GRANT SELECT ON viw_empregados_portal TO rh_perfil_99
/
GRANT SELECT ON viw_empregados_portal TO srh_portal_licitacoes
/

-- End of DDL Script for View IFRSRH.VIW_EMPREGADOS_PORTAL

