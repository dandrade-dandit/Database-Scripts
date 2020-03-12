use master
go

-------------------------------------------------------------------------------------------
print 'fg_admsql	versao:10/08/2001 09:30'
-------------------------------------------------------------------------------------------
if exists (select * from sysobjects where id = object_id('fg_admsql'))
	drop procedure fg_admsql
go

/*
execute master..fg_admsql @p_comando='backup', @p_execute= 1
*/	

create procedure fg_admsql
	@p_database	varchar(60)	= 'master'
,	@p_comando	varchar(60)	= 'help'
,	@p_execute	tinyint		= 0 -- 0-não(mostra o comando) 1-sim
,	@dir_backup	varchar(100)	= 'd:\'
,	@p_objeto	varchar(60)  	= null

as
set nocount on
declare @cmd 	varchar(2000)
,	@txt	varchar(2000)

--if ((@p_to is null) or (@p_subject is null) or (@p_message is null)) begin
--	raiserror('@p_to, @p_subject, @p_mensage e @p_host tem que ser informados.', 16, -1)
--	return 50000
--end

if (lower(@p_comando) = 'help' or lower(@p_comando) = '?') begin
	print '****************************************************************'
	print 'HELP - Descreve os comando e os parâmetros necessários.'
	print '       Não tem parâmetros.'
	print ''
	print 'BACKUP - Executa ou mostra os comando de BACKUP DATABASE.'
	print 'Exemplo :'
	print 'Exec	master..fg_admsql       @p_comando = ''backup''		-- Sempre deve ser ''backup''.'	
	print ',				@p_execute = 0			-- 0-não(mostra o comando) 1-sim.'
	print ',				@dir_backup = ''d:\''		-- Diretório de destino do backup.'
	print ''
	print 'CHECKDB - Executa ou mostra os comando de DBCC CHECKDB.'
	print 'Exemplo :'
	print 'Exec	master..fg_admsql       @p_comando = ''check_db''	-- Sempre deve ser ''check_db''.'	
	print ',				@p_execute = 0			-- 0-não(mostra o comando) 1-sim.'
	print '****************************************************************'
end else 
if lower(@p_comando) = 'backup' begin
	declare cursor_fg_admsql cursor for
	select 'backup database [' + ltrim(convert(varchar(256), name)) + '] to  disk = N''' + @dir_backup + ltrim(convert(varchar(256), name)) + '_full.bak'' with  init ,  nounload ,  name = N''' + ltrim(convert(varchar(256), name)) + ' full backup'',  noskip ,  stats = 10,  noformat ' as db
	from sysdatabases
	where name not in ('tempdb', 'model', 'msdb')
	open cursor_fg_admsql

	--Print de detalhes...
	print '*-----------------------------------------------------------------------*'
	if @p_execute = 1 begin
		print 'Backup será executado.'
	end else begin
		print 'Script do Backup será exibido.'	
	end
	print '*-----------------------------------------------------------------------*'
	print ''

	while (1=1)begin
		fetch next from cursor_fg_admsql 
		into @cmd
		
		if (@@fetch_status = -1) break	
		
		--select @cmd_backup
		if @p_execute = 1 begin
			execute (@cmd)
		end else begin
			print @cmd	
		end
	end
			
	close cursor_fg_admsql
	deallocate cursor_fg_admsql
end else 
if lower(@p_comando) = 'checkdb' begin
	declare cursor_fg_admsql cursor for
	select 'DBCC CHECKDB (''' + ltrim(convert(varchar(256), name)) + ''') WITH ALL_ERRORMSGS  ' as db
	from sysdatabases
	where name not in ('tempdb', 'model', 'msdb')
	open cursor_fg_admsql

	--Print de detalhes...
	print '*-----------------------------------------------------------------------*'
	if @p_execute = 1 begin
		print 'check db será executado.'
	end else begin
		print 'Script do check db será exibido.'	
	end
	print '*-----------------------------------------------------------------------*'
	print ''

	while (1=1)begin
		fetch next from cursor_fg_admsql 
		into @cmd
		
		if (@@fetch_status = -1) break	
		
		--select @cmd_backup
		if @p_execute = 1 begin
			execute (@cmd)
		end else begin
			print @cmd	
		end
	end
			
	close cursor_fg_admsql
	deallocate cursor_fg_admsql
end
go

grant  execute  on fg_admsql  to public