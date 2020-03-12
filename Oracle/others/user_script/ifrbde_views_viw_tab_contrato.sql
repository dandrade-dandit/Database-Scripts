CREATE OR REPLACE VIEW ifrbde_views.viw_tab_contrato (
   cnt_cre_cod,
   cnt_cod )
AS
SELECT cnt_cre_cod,
       cnt_cod
  FROM ifrbde.tab_contrato
 WHERE cnt_cre_cod IN (SELECT cre_cod
                         FROM ifrbde_views.tab_carencia)
/

-- Grants for View
GRANT DELETE ON ifrbde_views.viw_tab_contrato TO bde_views
/
GRANT INSERT ON ifrbde_views.viw_tab_contrato TO bde_views
/
GRANT SELECT ON ifrbde_views.viw_tab_contrato TO bde_views
/
GRANT UPDATE ON ifrbde_views.viw_tab_contrato TO bde_views
/
GRANT DELETE ON ifrbde_views.viw_tab_contrato TO bde_geral
/
GRANT INSERT ON ifrbde_views.viw_tab_contrato TO bde_geral
/
GRANT SELECT ON ifrbde_views.viw_tab_contrato TO bde_geral
/
GRANT UPDATE ON ifrbde_views.viw_tab_contrato TO bde_geral
/

-- End of DDL Script for View IFRBDE_VIEWS.VIW_TAB_CONTRATO


