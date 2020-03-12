--CREATE VIEW [dbo].[VIW_ITEM_REQUISICAO] AS
SELECT DISTINCT 
                      rl.req_id AS NUM_REQUISICAO, rl.req_line_nbr AS NUM_LN_ITEM_REQUISICAO, rl.item_id AS COD_ITEM_ALMOXARIFADO, SUBSTRING(gtp.descp_text, 1, 255) 
                      AS DSC_BASICA, SUBSTRING(gtp.long_descp, 1, 4000) AS DSC_COMPLEMENTAR, rl.qtde AS QTD_SOLICITADA, rl.valor AS VAL_UNITARIO, 
                      CASE WHEN ras.req_line_status_code = 2 THEN 1 WHEN ras.req_line_status_code = 5 THEN 2 WHEN ras.req_line_status_code = 6 THEN 3 WHEN ras.req_line_status_code
                       = 4 THEN 1 ELSE 0 END AS TIP_STATUS_ITEM, ras_autorizado.create_date AS DAT_AUTORIZACAO, ras_autorizado.matricula AS NUM_MATRICULA_AUTORIZACAO, 
                      SUBSTRING(ras.req_line_rej_hist, 1, 500) AS DSC_JUSTIFICATIVA, UM.unit_of_measure_descp AS DSC_UNIDADE_FORNECIMENTO, 
                      r.custo_gestor AS COD_CENTRO_CUSTO, ras_aprovado.create_date AS DAT_AVALIACAO, ras_aprovado.matricula AS NUM_MATRICULA_AVALIACAO, 
                      CASE WHEN item.commodity_code = '0000' THEN '1' ELSE '0' END AS FLG_REQUISICAO_MATERIAL, r.justificativa AS DSC_JUSTIFICATIVA_CONTRATACAO, 
                      r.objeto_desc AS DSC_OBJETO, r.exig_add AS DSC_EXIGENCIA_ADICIONAL
FROM         CORPORATIVO_SSHML.GEACcompras.dbo.gtb_req_line_u AS rl WITH (NOLOCK) INNER JOIN
                      CORPORATIVO_SSHML.GEACcompras.dbo.gtb_req_inf_add_u AS r WITH (NOLOCK) ON r.req_id = rl.req_id AND r.site_id = rl.site_id INNER JOIN
                      CORPORATIVO_SSHML.GEACcompras.dbo.gtb_apprv_req_line_sislic_hist AS ras WITH (NOLOCK) ON rl.req_id = ras.req_id AND rl.site_id = ras.site_id AND 
                      rl.req_line_nbr = ras.req_line_nbr AND rl.req_line_status_code IN (2, 5, 6, 4) AND ras.create_date =
                          (SELECT     MAX(create_date) AS Expr1
                            FROM          CORPORATIVO_SSHML.GEACcompras.dbo.gtb_apprv_req_line_sislic_hist AS ras_last
                            WHERE      (req_id = ras.req_id) AND (req_line_nbr = ras.req_line_nbr)) LEFT OUTER JOIN
                      CORPORATIVO_SSHML.GEACcompras.dbo.gtb_apprv_req_line_sislic_hist AS ras_autorizado WITH (NOLOCK) ON rl.req_id = ras_autorizado.req_id AND 
                      rl.site_id = ras_autorizado.site_id AND rl.req_line_nbr = ras_autorizado.req_line_nbr AND ras_autorizado.req_line_status_code = 2 AND 
                      ras_autorizado.create_date =
                          (SELECT     MAX(create_date) AS Expr1
                            FROM          CORPORATIVO_SSHML.GEACcompras.dbo.gtb_apprv_req_line_sislic_hist AS max_ras_autorizado WITH (NOLOCK)
                            WHERE      (req_id = ras_autorizado.req_id) AND (site_id = ras_autorizado.site_id) AND (req_line_nbr = ras_autorizado.req_line_nbr) AND 
                                                   (req_line_status_code = ras_autorizado.req_line_status_code)) LEFT OUTER JOIN
                      CORPORATIVO_SSHML.GEACcompras.dbo.gtb_apprv_req_line_sislic_hist AS ras_aprovado WITH (NOLOCK) ON rl.req_id = ras_aprovado.req_id AND 
                      rl.site_id = ras_aprovado.site_id AND rl.req_line_nbr = ras_aprovado.req_line_nbr AND ras_aprovado.req_line_status_code = 2 AND 
                      ras_aprovado.create_date =
                          (SELECT     MAX(create_date) AS Expr1
                            FROM          CORPORATIVO_SSHML.GEACcompras.dbo.gtb_apprv_req_line_sislic_hist AS max_ras_aprovado WITH (NOLOCK)
                            WHERE      (req_id = ras_aprovado.req_id) AND (site_id = ras_aprovado.site_id) AND (req_line_nbr = ras_aprovado.req_line_nbr) AND 
                                                   (req_line_status_code = ras_aprovado.req_line_status_code)) INNER JOIN
                      CORPORATIVO_SSHML.GEACpdm.dbo.gtb_item_pdm_u AS gtp WITH (NOLOCK) ON rl.item_id = gtp.item_id INNER JOIN
                      CORPORATIVO_SSHML.DBSpmam.dbo.item AS item WITH (NOLOCK) ON rl.item_id = item.item_id INNER JOIN
                      CORPORATIVO_SSHML.DBSuomm.dbo.unit_of_measure AS UM WITH (NOLOCK) ON UM.unit_of_measure = item.unit_of_measure







GO