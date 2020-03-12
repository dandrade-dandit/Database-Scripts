--oracle
SELECT  *
  FROM  DBA_COL_COMMENTS
 WHERE  OWNER = 'IFRSRH'
ORDER BY 2,3 

--smartstream
SELECT tm.tbl_name as "NOME DA TABELA"
      ,tm.notes as "COMENTÁRIO DA TABELA"
      ,cm.col_name as "NOME DA COLUNA"
      ,cm.col_label as "DESCRIÇÃO DA COLUNA"
      ,cm.notes as "COMENTÁRIO DA COLUNA"
  FROM [DBSwact].[dbo].[column_master] cm
  ,    [DBSctlg].[dbo].[tbl_colm_1] tc
  ,	   [DBSctlg].[dbo].[tbl_master_1] tm
  where cm.col_id = tc.col_id
    and tm.tbl_id = tc.tbl_id
    and tm.tblfam_id = 'ufcx'
    and tc.tbl_id like 'uf%'
  order by tc.tbl_id
	  ,    cm.col_id
  


--**********************************************
SELECT TOP 1000 [col_id]
      ,[col_name]
      ,[col_label]
      ,[col_type]
      ,[col_length]
      ,[event_col_nbr]
      ,[user_def]
      ,[notes]
      ,[col_case]
      ,[chgstamp]
  FROM [DBSwact].[dbo].[column_master]
  where col_id in (
  SELECT TOP 1000 [col_id]
  FROM [DBSctlg].[dbo].[tbl_colm_1]
  where tbl_id like 'uf04%'
  )

SELECT TOP 1000 [tbl_id]
      ,[column_nbr]
      ,[col_id]
      ,[primary_key]
      ,[chgstamp]
  FROM [DBSctlg].[dbo].[tbl_colm_1]
  where tbl_id like 'uf04%'
  

SELECT TOP 1000 [tbl_id]
      ,[tbl_name]
      ,[tbl_type]
      ,[tblfam_id]
      ,[owner_app]
      ,[notes]
      ,[udak_flg]
      ,[user_def]
      ,[chgstamp]
  FROM [DBSctlg].[dbo].[tbl_master_1]
 where [tblfam_id] = 'ufcx'
   and tbl_id = 'uf06'




  