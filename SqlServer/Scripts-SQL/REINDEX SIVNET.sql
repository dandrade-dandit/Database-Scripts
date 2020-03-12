
sp_who2 active

--  dbcc inputbuffer (89)
--  kill 89

alter index hst_voo_operacao_status_ix on dbo.hst_voo_operacao_status rebuild partition = all with (fillfactor = 70, pad_index  = off, statistics_norecompute  = off, allow_row_locks  = on, allow_page_locks  = on, online = off, sort_in_tempdb = off )
go


alter index [idx_hst_voo_operacao_status_01] on [dbo].[hst_voo_operacao_status] rebuild partition = all with (fillfactor = 70, pad_index  = off, statistics_norecompute  = off, allow_row_locks  = on, allow_page_locks  = on, online = off, sort_in_tempdb = off )
go


alter index hst_voo_operacao_status_ix2 on dbo.hst_voo_operacao_status rebuild partition = all with (fillfactor = 70, pad_index  = off, statistics_norecompute  = off, allow_row_locks  = on, allow_page_locks  = on, online = off, sort_in_tempdb = off )
go


alter index [idx_hst_voo_operacao_status_03] on [dbo].[hst_voo_operacao_status] rebuild partition = all with (fillfactor = 70, pad_index  = off, statistics_norecompute  = off, allow_row_locks  = on, allow_page_locks  = on, online = off, sort_in_tempdb = off )
go

alter index pk_tab_cia_aerea  on dbo.tab_cia_aerea rebuild partition = all with (fillfactor = 70, pad_index  = off, statistics_norecompute  = off, allow_row_locks  = on, allow_page_locks  = on, online = off, sort_in_tempdb = off )
go

alter index  idx_hst_voo_operacao_01 on dbo.hst_voo_operacao rebuild partition = all with (fillfactor = 70, pad_index  = off, statistics_norecompute  = off, allow_row_locks  = on, allow_page_locks  = on, online = off, sort_in_tempdb = off )
go

alter index  pk_hst_voo_operacao on dbo.hst_voo_operacao rebuild partition = all with (fillfactor = 70, pad_index  = off, statistics_norecompute  = off, allow_row_locks  = on, allow_page_locks  = on, online = off, sort_in_tempdb = off )
go

alter index pk_tab_aeroporto on dbo.tab_aeroporto rebuild partition = all with (fillfactor = 70, pad_index  = off, statistics_norecompute  = off, allow_row_locks  = on, allow_page_locks  = on, online = off, sort_in_tempdb = off )
go

/*

alter index hst_voo_operacao_status_ix on dbo.hst_voo_operacao_status_hist rebuild partition = all with (fillfactor = 90, pad_index  = off, statistics_norecompute  = off, allow_row_locks  = on, allow_page_locks  = on, online = off, sort_in_tempdb = off )
go


alter index [idx_hst_voo_operacao_status_01] on [dbo].[hst_voo_operacao_status_hist] rebuild partition = all with (fillfactor = 90, pad_index  = off, statistics_norecompute  = off, allow_row_locks  = on, allow_page_locks  = on, online = off, sort_in_tempdb = off )
go


alter index hst_voo_operacao_status_ix2 on dbo.hst_voo_operacao_status_hist rebuild partition = all with (fillfactor = 90, pad_index  = off, statistics_norecompute  = off, allow_row_locks  = on, allow_page_locks  = on, online = off, sort_in_tempdb = off )
go


alter index [hst_voo_operacao_status_03] on [dbo].[hst_voo_operacao_status_hist] rebuild partition = all with (fillfactor = 90, pad_index  = off, statistics_norecompute  = off, allow_row_locks  = on, allow_page_locks  = on, online = off, sort_in_tempdb = off )
go

*/