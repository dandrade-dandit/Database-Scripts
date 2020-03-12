/* Formatted on 2004/12/17 10:26 (Formatter Plus v4.5.2) */
CREATE OR REPLACE VIEW ifrbde.viw_item_governo_u (
   tp_aquisicao,
   item_id_gov,
   item_desc_gov
)
AS
   SELECT 'AD', TRIM (a.item_id_gov),
             'Aquisição Direta - '
          || a.item_desc_gov
     FROM integracao.item_governo_u a
    WHERE TRIM (a.item_id_gov) LIKE 'GYYYY%'
   UNION
   SELECT 'AT', TRIM (a.item_id_gov),
             'Ativo Permanente - '
          || a.item_desc_gov
     FROM integracao.item_governo_u a
    WHERE TRIM (a.item_id) LIKE '0132%'
   UNION
   SELECT 'OB', TRIM (a.item_id_gov),
             'Obras            - '
          || a.item_desc_gov
     FROM integracao.item_governo_u a
    WHERE TRIM (a.item_id) LIKE '0313%'
   UNION 
/*
SELECT 'ST',TRIM(a.item_id_gov), 'Almoxarifado     - '||a.item_desc_gov
  FROM integracao.item_governo_u a
  where trim(a.ITEM_ID_GOV) like 'GYYYZ%'
union
*/
   SELECT 'AA', '00000000000000', 'Em Branco     - Sem codigo do Governo '
     FROM DUAL
/

-- Grants for View
GRANT SELECT ON ifrbde.viw_item_governo_u TO bde_geral
/

-- End of DDL Script for View IFRBDE.VIW_ITEM_GOVERNO_U

