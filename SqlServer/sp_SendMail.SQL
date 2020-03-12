use master
go

-------------------------------------------------------------------------------------------
print 'fg_SendMail	Versao:10/08/2001 09:30'
-------------------------------------------------------------------------------------------
if exists (select * from sysobjects where id = object_id('fg_SendMail'))
	drop procedure fg_SendMail
go

/*
execute master..fg_SendMail @p_User = 'Denis@Denis', @p_To = 'denis_andrade@infraero.gov.br'
, @p_Subject = 'Teste da SP fg_sendmail', @p_Message = 'Teste de Envio pela SP fg_sendmail...'
*/	

CREATE procedure fg_SendMail
	@p_Local	varchar(60)	= 'd:\mssql7\mailto'
,	@p_User		varchar(60)	= 'User@User'
,	@p_To		varchar(60)  	= Null
,	@p_CC		varchar(60)	= Null
,	@p_Subject	varchar(60)	= Null
,	@p_Message	varchar(600)	= Null
,	@p_Host		varchar(60)	= '10.0.17.47'
as
set nocount on
Declare @Cmd 	varchar(2000)
,	@Txt	varchar(100)

if ((@p_To is null) or (@p_Subject is null) or (@p_Message is null)) begin
	raiserror('@p_To, @p_Subject, @p_Mensage e @p_Host tem que ser informados.', 16, -1)
	return 50000
end

if (@p_CC is not null) begin
	Set @Txt = '-CC ' + @p_CC
end else begin
	Set @Txt = ' '
end

Select @cmd = 'execute master..xp_cmdshell '''
Select @cmd = @cmd + @p_Local
Select @cmd = @cmd + ' -U ' + @p_User
Select @cmd = @cmd + ' -D ' + @p_To + @Txt
Select @cmd = @cmd + ' -S "' + @p_Subject + '"'
Select @cmd = @cmd + ' -M "' + @p_Message + '"'
Select @cmd = @cmd + ' -H ' +  @p_Host + ''''

execute (@Cmd)
go

Grant  Execute  On fg_SendMail  To Public