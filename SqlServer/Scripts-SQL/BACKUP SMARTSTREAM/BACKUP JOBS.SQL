USE [msdb]
GO

/****** Object:  Job [ADMIN - BACKUP DIFF]    Script Date: 05/02/2011 10:47:12 ******/
BEGIN TRANSACTION
DECLARE @ReturnCode INT
SELECT @ReturnCode = 0
/****** Object:  JobCategory [Database Maintenance]    Script Date: 05/02/2011 10:47:13 ******/
IF NOT EXISTS (SELECT name FROM msdb.dbo.syscategories WHERE name=N'Database Maintenance' AND category_class=1)
BEGIN
EXEC @ReturnCode = msdb.dbo.sp_add_category @class=N'JOB', @type=N'LOCAL', @name=N'Database Maintenance'
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback

END

DECLARE @jobId BINARY(16)
EXEC @ReturnCode =  msdb.dbo.sp_add_job @job_name=N'ADMIN - BACKUP DIFF', 
		@enabled=1, 
		@notify_level_eventlog=2, 
		@notify_level_email=2, 
		@notify_level_netsend=0, 
		@notify_level_page=0, 
		@delete_level=0, 
		@description=N'O backup full é diário, pois nao existe espaço disponível para armazenamento dos backups de log e diferencial.                     Criado por Denis Andrade em 05/02/2011', 
		@category_name=N'Database Maintenance', 
		@owner_login_name=N'sa', 
		@notify_email_operator_name=N'Notifica Falha de Backup', @job_id = @jobId OUTPUT
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
/****** Object:  Step [Apaga arquivos dia anterior]    Script Date: 05/02/2011 10:47:23 ******/
EXEC @ReturnCode = msdb.dbo.sp_add_jobstep @job_id=@jobId, @step_name=N'Apaga arquivos dia anterior', 
		@step_id=1, 
		@cmdexec_success_code=0, 
		@on_success_action=4, 
		@on_success_step_id=2, 
		@on_fail_action=4, 
		@on_fail_step_id=3, 
		@retry_attempts=0, 
		@retry_interval=0, 
		@os_run_priority=0, @subsystem=N'TSQL', 
		@command=N'declare @dia tinyint
declare @cmd  varchar (250)

  select @dia = datepart(dw, getdate())
  
  if (@dia = 1) begin
	set @cmd = (''exec xp_cmdshell ''''del H:\MSSQL\BACKUP\DIFF\*_db_*.bak /Q'''''')
  end 
   
exec (@cmd)', 
		@database_name=N'master', 
		@flags=0
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
/****** Object:  Step [Executa backup]    Script Date: 05/02/2011 10:47:29 ******/
EXEC @ReturnCode = msdb.dbo.sp_add_jobstep @job_id=@jobId, @step_name=N'Executa backup', 
		@step_id=2, 
		@cmdexec_success_code=0, 
		@on_success_action=4, 
		@on_success_step_id=4, 
		@on_fail_action=4, 
		@on_fail_step_id=3, 
		@retry_attempts=0, 
		@retry_interval=0, 
		@os_run_priority=0, @subsystem=N'TSQL', 
		@command=N'declare @Cmd varchar(2000)
declare @Banco nvarchar(500)
 
declare CarregaBanco CURSOR FOR 
select name from master.sys.databases(nolock) where database_id not in(1, 2,3,4,111) order by name desc
		
open CarregaBanco 

fetch next from CarregaBanco into @Banco
while @@FETCH_STATUS = 0
begin
 set @Cmd =''exec sp_BackupDiff ''+@Banco+'',null''
 --print (@Cmd)  
 exec (@Cmd) 
 fetch next from CarregaBanco INTO @Banco
end

close CarregaBanco 
deallocate CarregaBanco
', 
		@database_name=N'master', 
		@flags=0
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
/****** Object:  Step [Envia E-mail de erro]    Script Date: 05/02/2011 10:47:34 ******/
EXEC @ReturnCode = msdb.dbo.sp_add_jobstep @job_id=@jobId, @step_name=N'Envia E-mail de erro', 
		@step_id=3, 
		@cmdexec_success_code=0, 
		@on_success_action=1, 
		@on_success_step_id=0, 
		@on_fail_action=2, 
		@on_fail_step_id=0, 
		@retry_attempts=0, 
		@retry_interval=0, 
		@os_run_priority=0, @subsystem=N'TSQL', 
		@command=N'DECLARE
		@P_TXT_EMAIL VARCHAR(50)
,		@P_TXT_EMAIL_CC  VARCHAR(50)
,		@TXT_SUBJECT VARCHAR(30)
,		@TABLEHTML VARCHAR(2000)

SET		@P_TXT_EMAIL = ''banco_de_dados@infraero.gov.br''
SET		@P_TXT_EMAIL_CC = ''adias@infraero.gov.br''
SET		@TXT_SUBJECT = ''ERRO NO BACKUP DIFERENCIAL DO SMARTSTREAM - SQLSSII''
SET		@TABLEHTML = ''<HTML><BODY><B>Erro no backup do servidor SQLSSII.<BR>JOB:: ADMIN - BACKUP DIFF<BR>Mensagem de carater informativo.</BODY></HTML>''


EXEC msdb.dbo.sp_send_dbmail @recipients=@P_TXT_EMAIL,
		@copy_recipients = @P_TXT_EMAIL_CC,
		@subject = @TXT_SUBJECT,
		@body = @TABLEHTML,
		@body_format = ''HTML'', 
		@profile_name = ''SQLMail'',        
		@importance = ''HIGH'';


', 
		@database_name=N'master', 
		@flags=0
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
/****** Object:  Step [Envia Listagem do diretório do backup diferencial]    Script Date: 05/02/2011 10:47:39 ******/
EXEC @ReturnCode = msdb.dbo.sp_add_jobstep @job_id=@jobId, @step_name=N'Envia Listagem do diretório do backup diferencial', 
		@step_id=4, 
		@cmdexec_success_code=0, 
		@on_success_action=1, 
		@on_success_step_id=0, 
		@on_fail_action=2, 
		@on_fail_step_id=0, 
		@retry_attempts=0, 
		@retry_interval=0, 
		@os_run_priority=0, @subsystem=N'TSQL', 
		@command=N'EXEC msdb.dbo.sp_send_dbmail @recipients=''banco_de_dados@infraero.gov.br'',
	@subject = ''LISTAGEM DO DIRETÓRIO H:\ - COM OS BACKUPS DIFERENCIAS DO SERVIDOR SQLSSII - EXECUTADO DE DOMINGO À SEXTA-FEIRA'',
	@query = ''exec xp_cmdshell ''''dir h:\mssql\backup\diff'''''',
	@profile_name = ''SQLMail'',        
	@importance = ''HIGH'';', 
		@database_name=N'master', 
		@flags=0
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
EXEC @ReturnCode = msdb.dbo.sp_update_job @job_id = @jobId, @start_step_id = 1
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
EXEC @ReturnCode = msdb.dbo.sp_add_jobschedule @job_id=@jobId, @name=N'Agendamento Backup Differencial', 
		@enabled=1, 
		@freq_type=8, 
		@freq_interval=63, 
		@freq_subday_type=1, 
		@freq_subday_interval=0, 
		@freq_relative_interval=0, 
		@freq_recurrence_factor=1, 
		@active_start_date=20110205, 
		@active_end_date=99991231, 
		@active_start_time=235000, 
		@active_end_time=235959, 
		@schedule_uid=N'e2830439-07a1-49b8-80a1-e8ce76ee97d3'
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
EXEC @ReturnCode = msdb.dbo.sp_add_jobserver @job_id = @jobId, @server_name = N'(local)'
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
COMMIT TRANSACTION
GOTO EndSave
QuitWithRollback:
    IF (@@TRANCOUNT > 0) ROLLBACK TRANSACTION
EndSave:

GO

/****** Object:  Job [ADMIN - BACKUP FULL]    Script Date: 05/02/2011 10:48:00 ******/
BEGIN TRANSACTION
DECLARE @ReturnCode INT
SELECT @ReturnCode = 0
/****** Object:  JobCategory [Database Maintenance]    Script Date: 05/02/2011 10:48:00 ******/
IF NOT EXISTS (SELECT name FROM msdb.dbo.syscategories WHERE name=N'Database Maintenance' AND category_class=1)
BEGIN
EXEC @ReturnCode = msdb.dbo.sp_add_category @class=N'JOB', @type=N'LOCAL', @name=N'Database Maintenance'
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback

END

DECLARE @jobId BINARY(16)
EXEC @ReturnCode =  msdb.dbo.sp_add_job @job_name=N'ADMIN - BACKUP FULL', 
		@enabled=1, 
		@notify_level_eventlog=2, 
		@notify_level_email=2, 
		@notify_level_netsend=0, 
		@notify_level_page=0, 
		@delete_level=0, 
		@description=N'O backup full é diário, pois nao existe espaço disponível para armazenamento dos backups de log e diferencial.                     Criado por Wagner Andrade', 
		@category_name=N'Database Maintenance', 
		@owner_login_name=N'sa', 
		@notify_email_operator_name=N'Notifica Falha de Backup', @job_id = @jobId OUTPUT
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
/****** Object:  Step [Apaga arquivos dia anterior]    Script Date: 05/02/2011 10:48:10 ******/
EXEC @ReturnCode = msdb.dbo.sp_add_jobstep @job_id=@jobId, @step_name=N'Apaga arquivos dia anterior', 
		@step_id=1, 
		@cmdexec_success_code=0, 
		@on_success_action=4, 
		@on_success_step_id=2, 
		@on_fail_action=4, 
		@on_fail_step_id=3, 
		@retry_attempts=0, 
		@retry_interval=0, 
		@os_run_priority=0, @subsystem=N'TSQL', 
		@command=N'declare @Hora char(8)
declare @cmd  varchar (250)

  set @cmd = (''exec xp_cmdshell ''''del G:\MSSQL\BACKUP\FULL\*_db_*.bak /Q'''''')
   
exec (@cmd)', 
		@database_name=N'master', 
		@flags=0
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
/****** Object:  Step [Executa backup]    Script Date: 05/02/2011 10:48:10 ******/
EXEC @ReturnCode = msdb.dbo.sp_add_jobstep @job_id=@jobId, @step_name=N'Executa backup', 
		@step_id=2, 
		@cmdexec_success_code=0, 
		@on_success_action=1, 
		@on_success_step_id=0, 
		@on_fail_action=4, 
		@on_fail_step_id=3, 
		@retry_attempts=0, 
		@retry_interval=0, 
		@os_run_priority=0, @subsystem=N'TSQL', 
		@command=N'declare @Cmd varchar(2000)
declare @Banco nvarchar(500)
 
declare CarregaBanco CURSOR FOR 
select name from master.sys.databases(nolock) where database_id not in(2,3,4,111,108) order by name desc
		
open CarregaBanco 

fetch next from CarregaBanco into @Banco
while @@FETCH_STATUS = 0
begin
 set @Cmd =''exec sp_BackupFull ''+@Banco+'',null''
 --print (@Cmd)  
 exec (@Cmd) 
 fetch next from CarregaBanco INTO @Banco
end

close CarregaBanco 
deallocate CarregaBanco
', 
		@database_name=N'master', 
		@flags=0
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
/****** Object:  Step [Envia E-mail de erro]    Script Date: 05/02/2011 10:48:16 ******/
EXEC @ReturnCode = msdb.dbo.sp_add_jobstep @job_id=@jobId, @step_name=N'Envia E-mail de erro', 
		@step_id=3, 
		@cmdexec_success_code=0, 
		@on_success_action=1, 
		@on_success_step_id=0, 
		@on_fail_action=2, 
		@on_fail_step_id=0, 
		@retry_attempts=0, 
		@retry_interval=0, 
		@os_run_priority=0, @subsystem=N'TSQL', 
		@command=N'DECLARE
		@P_TXT_EMAIL VARCHAR(50)
,		@P_TXT_EMAIL_CC  VARCHAR(50)
,		@TXT_SUBJECT VARCHAR(30)
,		@TABLEHTML VARCHAR(2000)

SET		@P_TXT_EMAIL = ''banco_de_dados@infraero.gov.br''
SET		@P_TXT_EMAIL_CC = ''adias@infraero.gov.br''
SET		@TXT_SUBJECT = ''ERRO NO BACKUP FULL DO SMARTSTREAM - SQLSSII''
SET		@TABLEHTML = ''<HTML><BODY><B>Erro no backup do servidor SQLSSII.<BR>JOB:: ADMIN - BACKUP FULL<BR>Mensagem de carater informativo.</BODY></HTML>''


EXEC msdb.dbo.sp_send_dbmail @recipients=@P_TXT_EMAIL,
		@copy_recipients = @P_TXT_EMAIL_CC,
		@subject = @TXT_SUBJECT,
		@body = @TABLEHTML,
		@body_format = ''HTML'', 
		@profile_name = ''SQLMail'',        
		@importance = ''HIGH'';


', 
		@database_name=N'master', 
		@flags=0
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
EXEC @ReturnCode = msdb.dbo.sp_update_job @job_id = @jobId, @start_step_id = 1
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
EXEC @ReturnCode = msdb.dbo.sp_add_jobschedule @job_id=@jobId, @name=N'Agendamento:: ADMIN - BACKUP FULL', 
		@enabled=1, 
		@freq_type=8, 
		@freq_interval=66, 
		@freq_subday_type=1, 
		@freq_subday_interval=0, 
		@freq_relative_interval=0, 
		@freq_recurrence_factor=1, 
		@active_start_date=20100611, 
		@active_end_date=99991231, 
		@active_start_time=220000, 
		@active_end_time=235959, 
		@schedule_uid=N'8ea88d90-7cad-443d-acd0-0f6e850662f9'
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
EXEC @ReturnCode = msdb.dbo.sp_add_jobserver @job_id = @jobId, @server_name = N'(local)'
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
COMMIT TRANSACTION
GOTO EndSave
QuitWithRollback:
    IF (@@TRANCOUNT > 0) ROLLBACK TRANSACTION
EndSave:

GO

/****** Object:  Job [ADMIN - BACKUP FULL - AVULSO]    Script Date: 05/02/2011 10:48:36 ******/
BEGIN TRANSACTION
DECLARE @ReturnCode INT
SELECT @ReturnCode = 0
/****** Object:  JobCategory [Database Engine Tuning Advisor]    Script Date: 05/02/2011 10:48:37 ******/
IF NOT EXISTS (SELECT name FROM msdb.dbo.syscategories WHERE name=N'Database Engine Tuning Advisor' AND category_class=1)
BEGIN
EXEC @ReturnCode = msdb.dbo.sp_add_category @class=N'JOB', @type=N'LOCAL', @name=N'Database Engine Tuning Advisor'
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback

END

DECLARE @jobId BINARY(16)
EXEC @ReturnCode =  msdb.dbo.sp_add_job @job_name=N'ADMIN - BACKUP FULL - AVULSO', 
		@enabled=1, 
		@notify_level_eventlog=0, 
		@notify_level_email=0, 
		@notify_level_netsend=0, 
		@notify_level_page=0, 
		@delete_level=0, 
		@description=N'No description available.', 
		@category_name=N'Database Engine Tuning Advisor', 
		@owner_login_name=N'sa', @job_id = @jobId OUTPUT
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
/****** Object:  Step [passo 1]    Script Date: 05/02/2011 10:48:47 ******/
EXEC @ReturnCode = msdb.dbo.sp_add_jobstep @job_id=@jobId, @step_name=N'passo 1', 
		@step_id=1, 
		@cmdexec_success_code=0, 
		@on_success_action=1, 
		@on_success_step_id=0, 
		@on_fail_action=2, 
		@on_fail_step_id=0, 
		@retry_attempts=0, 
		@retry_interval=0, 
		@os_run_priority=0, @subsystem=N'TSQL', 
		@command=N'declare @Cmd varchar(2000)
declare @Banco nvarchar(500)
 
declare CarregaBanco CURSOR FOR 
select name from master.sys.databases(nolock) 
where database_id not in(1,2,3,4,111) 
  and name not in (
''GEACutax'',''GEACupax'',''GEACrrcv'',''DBSrrcv'',''GCC''
 )
order by name desc
		
open CarregaBanco 

fetch next from CarregaBanco into @Banco
while @@FETCH_STATUS = 0
begin
 set @Cmd =''exec sp_BackupFull ''+@Banco+'',null''
 --print (@Cmd)  
 exec (@Cmd) 
 fetch next from CarregaBanco INTO @Banco
end

close CarregaBanco 
deallocate CarregaBanco', 
		@database_name=N'master', 
		@flags=0
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
EXEC @ReturnCode = msdb.dbo.sp_update_job @job_id = @jobId, @start_step_id = 1
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
EXEC @ReturnCode = msdb.dbo.sp_add_jobserver @job_id = @jobId, @server_name = N'(local)'
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
COMMIT TRANSACTION
GOTO EndSave
QuitWithRollback:
    IF (@@TRANCOUNT > 0) ROLLBACK TRANSACTION
EndSave:

GO

/****** Object:  Job [ADMIN - BACKUP FULL - GEACupax]    Script Date: 05/02/2011 10:48:57 ******/
BEGIN TRANSACTION
DECLARE @ReturnCode INT
SELECT @ReturnCode = 0
/****** Object:  JobCategory [Database Maintenance]    Script Date: 05/02/2011 10:48:57 ******/
IF NOT EXISTS (SELECT name FROM msdb.dbo.syscategories WHERE name=N'Database Maintenance' AND category_class=1)
BEGIN
EXEC @ReturnCode = msdb.dbo.sp_add_category @class=N'JOB', @type=N'LOCAL', @name=N'Database Maintenance'
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback

END

DECLARE @jobId BINARY(16)
EXEC @ReturnCode =  msdb.dbo.sp_add_job @job_name=N'ADMIN - BACKUP FULL - GEACupax', 
		@enabled=1, 
		@notify_level_eventlog=2, 
		@notify_level_email=2, 
		@notify_level_netsend=0, 
		@notify_level_page=0, 
		@delete_level=0, 
		@description=N'O backup full é diário, pois nao existe espaço disponível para armazenamento dos backups de log e diferencial.                     Criado por Wagner Andrade', 
		@category_name=N'Database Maintenance', 
		@owner_login_name=N'sa', 
		@notify_email_operator_name=N'Notifica Falha de Backup', @job_id = @jobId OUTPUT
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
/****** Object:  Step [Apaga arquivos dia anterior]    Script Date: 05/02/2011 10:49:08 ******/
EXEC @ReturnCode = msdb.dbo.sp_add_jobstep @job_id=@jobId, @step_name=N'Apaga arquivos dia anterior', 
		@step_id=1, 
		@cmdexec_success_code=0, 
		@on_success_action=4, 
		@on_success_step_id=2, 
		@on_fail_action=4, 
		@on_fail_step_id=2, 
		@retry_attempts=0, 
		@retry_interval=0, 
		@os_run_priority=0, @subsystem=N'TSQL', 
		@command=N'declare @Hora char(8)
declare @cmd  varchar (250)

  set @cmd = (''exec xp_cmdshell ''''del G:\MSSQL\BACKUP\FULL\GEACupax*_db_*.bak /Q'''''')
   
   exec (@cmd)', 
		@database_name=N'master', 
		@flags=0
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
/****** Object:  Step [Executa backup]    Script Date: 05/02/2011 10:49:13 ******/
EXEC @ReturnCode = msdb.dbo.sp_add_jobstep @job_id=@jobId, @step_name=N'Executa backup', 
		@step_id=2, 
		@cmdexec_success_code=0, 
		@on_success_action=4, 
		@on_success_step_id=4, 
		@on_fail_action=4, 
		@on_fail_step_id=3, 
		@retry_attempts=0, 
		@retry_interval=0, 
		@os_run_priority=0, @subsystem=N'TSQL', 
		@command=N'declare @Cmd varchar(2000)
declare @Banco nvarchar(500)
 
declare CarregaBanco CURSOR FOR 
select name from master.sys.databases(nolock) where database_id in(108) order by name desc
		
open CarregaBanco 

fetch next from CarregaBanco into @Banco
while @@FETCH_STATUS = 0
begin
 set @Cmd =''exec sp_BackupFull ''+@Banco+'',null''
 --print (@Cmd)  
 exec (@Cmd) 
 fetch next from CarregaBanco INTO @Banco
end

close CarregaBanco 
deallocate CarregaBanco
', 
		@database_name=N'master', 
		@flags=0
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
/****** Object:  Step [Envia E-mail de erro]    Script Date: 05/02/2011 10:49:18 ******/
EXEC @ReturnCode = msdb.dbo.sp_add_jobstep @job_id=@jobId, @step_name=N'Envia E-mail de erro', 
		@step_id=3, 
		@cmdexec_success_code=0, 
		@on_success_action=1, 
		@on_success_step_id=0, 
		@on_fail_action=2, 
		@on_fail_step_id=0, 
		@retry_attempts=0, 
		@retry_interval=0, 
		@os_run_priority=0, @subsystem=N'TSQL', 
		@command=N'DECLARE
		@P_TXT_EMAIL VARCHAR(50)
,		@P_TXT_EMAIL_CC  VARCHAR(50)
,		@TXT_SUBJECT VARCHAR(30)
,		@TABLEHTML VARCHAR(2000)

SET		@P_TXT_EMAIL = ''banco_de_dados@infraero.gov.br''
SET		@P_TXT_EMAIL_CC = ''adias@infraero.gov.br''
SET		@TXT_SUBJECT = ''ERRO NO BACKUP FULL DO SMARTSTREAM - SQLSSII - GEACupax''
SET		@TABLEHTML = ''<HTML><BODY><B>Erro no backup do servidor SQLSSII.<BR>JOB:: ADMIN - BACKUP FULL<BR>Mensagem de carater informativo.</BODY></HTML>''


EXEC msdb.dbo.sp_send_dbmail @recipients=@P_TXT_EMAIL,
		@copy_recipients = @P_TXT_EMAIL_CC,
		@subject = @TXT_SUBJECT,
		@body = @TABLEHTML,
		@body_format = ''HTML'', 
		@profile_name = ''SQLMail'',        
		@importance = ''HIGH'';


', 
		@database_name=N'master', 
		@flags=0
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
/****** Object:  Step [envia listagem dos diretório do backup FULL]    Script Date: 05/02/2011 10:49:24 ******/
EXEC @ReturnCode = msdb.dbo.sp_add_jobstep @job_id=@jobId, @step_name=N'envia listagem dos diretório do backup FULL', 
		@step_id=4, 
		@cmdexec_success_code=0, 
		@on_success_action=1, 
		@on_success_step_id=0, 
		@on_fail_action=2, 
		@on_fail_step_id=0, 
		@retry_attempts=0, 
		@retry_interval=0, 
		@os_run_priority=0, @subsystem=N'TSQL', 
		@command=N'EXEC msdb.dbo.sp_send_dbmail @recipients=''banco_de_dados@infraero.gov.br'',
	@subject = ''LISTAGEM DO DIRETÓRIO G:\ - COM OS BACKUP FULL DO SERVIDOR SQLSSII - EXECUTADO TODO SÁBADO'',
	@query = ''exec xp_cmdshell ''''dir g:\mssql\backup\full'''''',
	@profile_name = ''SQLMail'',        
	@importance = ''HIGH'';', 
		@database_name=N'master', 
		@flags=0
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
EXEC @ReturnCode = msdb.dbo.sp_update_job @job_id = @jobId, @start_step_id = 1
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
EXEC @ReturnCode = msdb.dbo.sp_add_jobschedule @job_id=@jobId, @name=N'Agentamento Backup GEACupax', 
		@enabled=1, 
		@freq_type=8, 
		@freq_interval=1, 
		@freq_subday_type=1, 
		@freq_subday_interval=0, 
		@freq_relative_interval=0, 
		@freq_recurrence_factor=1, 
		@active_start_date=20100915, 
		@active_end_date=99991231, 
		@active_start_time=20000, 
		@active_end_time=235959, 
		@schedule_uid=N'f1a77604-13ec-43cc-a321-7e2a359e755c'
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
EXEC @ReturnCode = msdb.dbo.sp_add_jobserver @job_id = @jobId, @server_name = N'(local)'
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
COMMIT TRANSACTION
GOTO EndSave
QuitWithRollback:
    IF (@@TRANCOUNT > 0) ROLLBACK TRANSACTION
EndSave:

GO

/****** Object:  Job [ADMIN - KILL PROCESSOS ORFAOS]    Script Date: 05/02/2011 10:49:45 ******/
BEGIN TRANSACTION
DECLARE @ReturnCode INT
SELECT @ReturnCode = 0
/****** Object:  JobCategory [Database Maintenance]    Script Date: 05/02/2011 10:49:45 ******/
IF NOT EXISTS (SELECT name FROM msdb.dbo.syscategories WHERE name=N'Database Maintenance' AND category_class=1)
BEGIN
EXEC @ReturnCode = msdb.dbo.sp_add_category @class=N'JOB', @type=N'LOCAL', @name=N'Database Maintenance'
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback

END

DECLARE @jobId BINARY(16)
EXEC @ReturnCode =  msdb.dbo.sp_add_job @job_name=N'ADMIN - KILL PROCESSOS ORFAOS', 
		@enabled=0, 
		@notify_level_eventlog=0, 
		@notify_level_email=0, 
		@notify_level_netsend=0, 
		@notify_level_page=0, 
		@delete_level=0, 
		@description=N'No description available.', 
		@category_name=N'Database Maintenance', 
		@owner_login_name=N'sa', @job_id = @jobId OUTPUT
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
/****** Object:  Step [Executa Kill]    Script Date: 05/02/2011 10:49:55 ******/
EXEC @ReturnCode = msdb.dbo.sp_add_jobstep @job_id=@jobId, @step_name=N'Executa Kill', 
		@step_id=1, 
		@cmdexec_success_code=0, 
		@on_success_action=1, 
		@on_success_step_id=0, 
		@on_fail_action=2, 
		@on_fail_step_id=0, 
		@retry_attempts=0, 
		@retry_interval=0, 
		@os_run_priority=0, @subsystem=N'TSQL', 
		@command=N'SET NOCOUNT ON

DECLARE @CMD		VARCHAR(15)
DECLARE @SESSION	VARCHAR(15)

DECLARE killsessions CURSOR FOR 

select 
ses.session_id
from 
	sys.dm_exec_sessions as ses 
		inner join sys.dm_tran_session_transactions as tra on
			ses.session_id = tra.session_id 
				left join sys.dm_exec_requests as req on
					ses.session_id = req.session_id
where
	req.database_id is null and
	ses.login_name<>''DBS''; 
	
OPEN killsessions

FETCH NEXT FROM killsessions into @SESSION

WHILE @@FETCH_STATUS = 0

	BEGIN
		SET		@CMD=''kill ''+@SESSION
		--PRINT	@CMD
		EXEC	(@CMD)
FETCH NEXT FROM killsessions INTO @SESSION
END

CLOSE killsessions
DEALLOCATE killsessions', 
		@database_name=N'master', 
		@flags=0
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
EXEC @ReturnCode = msdb.dbo.sp_update_job @job_id = @jobId, @start_step_id = 1
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
EXEC @ReturnCode = msdb.dbo.sp_add_jobschedule @job_id=@jobId, @name=N'Agendamento - ADMIN - KILL PROCESSOS ORFAOS', 
		@enabled=1, 
		@freq_type=8, 
		@freq_interval=62, 
		@freq_subday_type=4, 
		@freq_subday_interval=5, 
		@freq_relative_interval=0, 
		@freq_recurrence_factor=1, 
		@active_start_date=20100721, 
		@active_end_date=99991231, 
		@active_start_time=80000, 
		@active_end_time=195959, 
		@schedule_uid=N'f70e9d55-f604-4c03-8f70-5f4aaed4414b'
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
EXEC @ReturnCode = msdb.dbo.sp_add_jobserver @job_id = @jobId, @server_name = N'(local)'
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
COMMIT TRANSACTION
GOTO EndSave
QuitWithRollback:
    IF (@@TRANCOUNT > 0) ROLLBACK TRANSACTION
EndSave:

GO

/****** Object:  Job [ADMIN - LOG TRANSAÇÕES]    Script Date: 05/02/2011 10:50:06 ******/
BEGIN TRANSACTION
DECLARE @ReturnCode INT
SELECT @ReturnCode = 0
/****** Object:  JobCategory [[Uncategorized (Local)]]]    Script Date: 05/02/2011 10:50:06 ******/
IF NOT EXISTS (SELECT name FROM msdb.dbo.syscategories WHERE name=N'[Uncategorized (Local)]' AND category_class=1)
BEGIN
EXEC @ReturnCode = msdb.dbo.sp_add_category @class=N'JOB', @type=N'LOCAL', @name=N'[Uncategorized (Local)]'
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback

END

DECLARE @jobId BINARY(16)
EXEC @ReturnCode =  msdb.dbo.sp_add_job @job_name=N'ADMIN - LOG TRANSAÇÕES', 
		@enabled=1, 
		@notify_level_eventlog=0, 
		@notify_level_email=0, 
		@notify_level_netsend=0, 
		@notify_level_page=0, 
		@delete_level=0, 
		@description=N'No description available.', 
		@category_name=N'[Uncategorized (Local)]', 
		@owner_login_name=N'sa', @job_id = @jobId OUTPUT
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
/****** Object:  Step [PASSO 1]    Script Date: 05/02/2011 10:50:11 ******/
EXEC @ReturnCode = msdb.dbo.sp_add_jobstep @job_id=@jobId, @step_name=N'PASSO 1', 
		@step_id=1, 
		@cmdexec_success_code=0, 
		@on_success_action=1, 
		@on_success_step_id=0, 
		@on_fail_action=2, 
		@on_fail_step_id=0, 
		@retry_attempts=0, 
		@retry_interval=0, 
		@os_run_priority=0, @subsystem=N'TSQL', 
		@command=N'set nocount on

declare @table table (
spid int,
dbname varchar(100),
usuario varchar(100),
cmd varchar(100),
blocked int,
tempo int,
status varchar(100),
cpu int,
physical_io int,
net_library  varchar(100),
program_name  varchar(1000),
lastwaittype  varchar(1000),
waitresource  varchar(100) )

insert into @table
exec GEACrrcv..gsp_who2

insert into IFRCORP..tab_log_trans
select	usuario, u.sec_group_id, 1 as qtd, getdate() date
from	@table
   ,    [DBSwact].[dbo].[user_master_1] u
where	usuario != ''sa''
  and   usuario not like ''D_SEDE%''
  and   usuario = u.user_id

/*

create table IFRCORP..tab_log_trans (
 usuario varchar(100),
 grupo varchar(100),
 qtd int,
 data datetime)
 
 */', 
		@database_name=N'master', 
		@flags=0
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
EXEC @ReturnCode = msdb.dbo.sp_update_job @job_id = @jobId, @start_step_id = 1
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
EXEC @ReturnCode = msdb.dbo.sp_add_jobschedule @job_id=@jobId, @name=N'AGENDAMENTO', 
		@enabled=1, 
		@freq_type=4, 
		@freq_interval=1, 
		@freq_subday_type=4, 
		@freq_subday_interval=1, 
		@freq_relative_interval=0, 
		@freq_recurrence_factor=0, 
		@active_start_date=20100909, 
		@active_end_date=99991231, 
		@active_start_time=0, 
		@active_end_time=235959, 
		@schedule_uid=N'9ea54bda-a0a4-4f47-bbd8-b4789c71e6b3'
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
EXEC @ReturnCode = msdb.dbo.sp_add_jobserver @job_id = @jobId, @server_name = N'(local)'
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
COMMIT TRANSACTION
GOTO EndSave
QuitWithRollback:
    IF (@@TRANCOUNT > 0) ROLLBACK TRANSACTION
EndSave:

GO

/****** Object:  Job [ADMIN - REINDEX]    Script Date: 05/02/2011 10:50:27 ******/
BEGIN TRANSACTION
DECLARE @ReturnCode INT
SELECT @ReturnCode = 0
/****** Object:  JobCategory [Database Maintenance]    Script Date: 05/02/2011 10:50:27 ******/
IF NOT EXISTS (SELECT name FROM msdb.dbo.syscategories WHERE name=N'Database Maintenance' AND category_class=1)
BEGIN
EXEC @ReturnCode = msdb.dbo.sp_add_category @class=N'JOB', @type=N'LOCAL', @name=N'Database Maintenance'
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback

END

DECLARE @jobId BINARY(16)
EXEC @ReturnCode =  msdb.dbo.sp_add_job @job_name=N'ADMIN - REINDEX', 
		@enabled=1, 
		@notify_level_eventlog=0, 
		@notify_level_email=0, 
		@notify_level_netsend=0, 
		@notify_level_page=0, 
		@delete_level=0, 
		@description=N'No description available.', 
		@category_name=N'Database Maintenance', 
		@owner_login_name=N'D_SEDE\I1419434', @job_id = @jobId OUTPUT
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
/****** Object:  Step [EXEC REINDEX]    Script Date: 05/02/2011 10:50:32 ******/
EXEC @ReturnCode = msdb.dbo.sp_add_jobstep @job_id=@jobId, @step_name=N'EXEC REINDEX', 
		@step_id=1, 
		@cmdexec_success_code=0, 
		@on_success_action=1, 
		@on_success_step_id=0, 
		@on_fail_action=2, 
		@on_fail_step_id=0, 
		@retry_attempts=0, 
		@retry_interval=0, 
		@os_run_priority=0, @subsystem=N'TSQL', 
		@command=N'declare @Cmd varchar(2000)
declare @Banco nvarchar(500)
 
declare CarregaBanco CURSOR FOR 
		select name from master.sys.databases(nolock) where database_id not in(1,2,3,4,5,7,13,18,53,63,68,108,109) order by name -- retirados os bancos com mais de 100GB por falta de espaco para reindex
		
open CarregaBanco 

fetch next from CarregaBanco into @Banco
while @@FETCH_STATUS = 0
begin
 set @Cmd =''use ''+@Banco+char(32)+ ''exec spu_ReindexDB 7,80''
 --print (@Cmd)  
 exec (@Cmd) 
 fetch next from CarregaBanco INTO @Banco
end

close CarregaBanco 
deallocate CarregaBanco', 
		@database_name=N'master', 
		@flags=0
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
EXEC @ReturnCode = msdb.dbo.sp_update_job @job_id = @jobId, @start_step_id = 1
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
EXEC @ReturnCode = msdb.dbo.sp_add_jobschedule @job_id=@jobId, @name=N'Agendamento Reindex', 
		@enabled=1, 
		@freq_type=8, 
		@freq_interval=1, 
		@freq_subday_type=1, 
		@freq_subday_interval=0, 
		@freq_relative_interval=0, 
		@freq_recurrence_factor=1, 
		@active_start_date=20100621, 
		@active_end_date=99991231, 
		@active_start_time=3000, 
		@active_end_time=235959, 
		@schedule_uid=N'1217564c-e465-46ee-ae9b-536fbfa0b0d1'
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
EXEC @ReturnCode = msdb.dbo.sp_add_jobserver @job_id = @jobId, @server_name = N'(local)'
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
COMMIT TRANSACTION
GOTO EndSave
QuitWithRollback:
    IF (@@TRANCOUNT > 0) ROLLBACK TRANSACTION
EndSave:

GO

/****** Object:  Job [ADMIN - UPDATESTATISCS]    Script Date: 05/02/2011 10:50:42 ******/
BEGIN TRANSACTION
DECLARE @ReturnCode INT
SELECT @ReturnCode = 0
/****** Object:  JobCategory [Database Engine Tuning Advisor]    Script Date: 05/02/2011 10:50:43 ******/
IF NOT EXISTS (SELECT name FROM msdb.dbo.syscategories WHERE name=N'Database Engine Tuning Advisor' AND category_class=1)
BEGIN
EXEC @ReturnCode = msdb.dbo.sp_add_category @class=N'JOB', @type=N'LOCAL', @name=N'Database Engine Tuning Advisor'
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback

END

DECLARE @jobId BINARY(16)
EXEC @ReturnCode =  msdb.dbo.sp_add_job @job_name=N'ADMIN - UPDATESTATISCS', 
		@enabled=1, 
		@notify_level_eventlog=0, 
		@notify_level_email=0, 
		@notify_level_netsend=0, 
		@notify_level_page=0, 
		@delete_level=0, 
		@description=N'No description available.', 
		@category_name=N'Database Engine Tuning Advisor', 
		@owner_login_name=N'D_SEDE\I1419434', @job_id = @jobId OUTPUT
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
/****** Object:  Step [Exec atualizaestatisticas]    Script Date: 05/02/2011 10:50:53 ******/
EXEC @ReturnCode = msdb.dbo.sp_add_jobstep @job_id=@jobId, @step_name=N'Exec atualizaestatisticas', 
		@step_id=1, 
		@cmdexec_success_code=0, 
		@on_success_action=1, 
		@on_success_step_id=0, 
		@on_fail_action=2, 
		@on_fail_step_id=0, 
		@retry_attempts=0, 
		@retry_interval=0, 
		@os_run_priority=0, @subsystem=N'TSQL', 
		@command=N'SET QUOTED_IDENTIFIER OFF
SET ARITHABORT OFF

create table #tmpquery(query varchar(8000))
declare #bancos cursor for 
SELECT name FROM master.dbo.sysdatabases where dbid not in(1,2,3,4,5,6,7,13,21,53)
for read only
declare 
	@bancos	varchar(255),
	@comando	varchar(8000),
	@Servidor	varchar(255),
	@Path		varchar(255),
	@UltRestore      datetime,
	@data		varchar(30)

open #bancos
fetch next from #bancos into @bancos
while @@Fetch_status =  0
begin
set @comando=(''USE ''+@bancos+CHAR(13)+''select ''''update statistics ''+@bancos+''.dbo.''+char(39)+''+object_name(id) from ''+@bancos+''.dbo.sysindexes where indid=1 and id>100 and rowcnt>0'')
--print @comando
	insert into #tmpquery exec (@comando)

	fetch next from #bancos into @bancos
end
declare #tmpquery cursor  for       
select * from #tmpquery  where query not in (''update statistics INFRAgco.dbo.cad_previsao_composicao_planilha_tmp'')
--select count(*) from #tmpquery 
open #tmpquery
fetch next from #tmpquery into @comando
while @@Fetch_status =  0
begin
--	print @comando
	exec (@comando)
	fetch next from #tmpquery into @comando
end
close #bancos
deallocate #bancos

close #tmpquery
deallocate #tmpquery
 go
 drop table #tmpquery
', 
		@database_name=N'master', 
		@flags=0
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
EXEC @ReturnCode = msdb.dbo.sp_update_job @job_id = @jobId, @start_step_id = 1
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
EXEC @ReturnCode = msdb.dbo.sp_add_jobschedule @job_id=@jobId, @name=N'Agendamento AtualizaEstatisticas', 
		@enabled=1, 
		@freq_type=8, 
		@freq_interval=62, 
		@freq_subday_type=8, 
		@freq_subday_interval=6, 
		@freq_relative_interval=0, 
		@freq_recurrence_factor=1, 
		@active_start_date=20100707, 
		@active_end_date=99991231, 
		@active_start_time=60000, 
		@active_end_time=235959, 
		@schedule_uid=N'eeec03c6-358c-460f-885d-6bc564ae551c'
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
EXEC @ReturnCode = msdb.dbo.sp_add_jobserver @job_id = @jobId, @server_name = N'(local)'
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
COMMIT TRANSACTION
GOTO EndSave
QuitWithRollback:
    IF (@@TRANCOUNT > 0) ROLLBACK TRANSACTION
EndSave:

GO

/****** Object:  Job [Atualiza Requisitantes]    Script Date: 05/02/2011 10:51:09 ******/
BEGIN TRANSACTION
DECLARE @ReturnCode INT
SELECT @ReturnCode = 0
/****** Object:  JobCategory [Database Maintenance]    Script Date: 05/02/2011 10:51:09 ******/
IF NOT EXISTS (SELECT name FROM msdb.dbo.syscategories WHERE name=N'Database Maintenance' AND category_class=1)
BEGIN
EXEC @ReturnCode = msdb.dbo.sp_add_category @class=N'JOB', @type=N'LOCAL', @name=N'Database Maintenance'
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback

END

DECLARE @jobId BINARY(16)
EXEC @ReturnCode =  msdb.dbo.sp_add_job @job_name=N'Atualiza Requisitantes', 
		@enabled=1, 
		@notify_level_eventlog=0, 
		@notify_level_email=0, 
		@notify_level_netsend=0, 
		@notify_level_page=0, 
		@delete_level=0, 
		@description=N'INFRAERO.dbo.dbo.sp_seg_atualiza_user_SU_u', 
		@category_name=N'Database Maintenance', 
		@owner_login_name=N'ADAILI', @job_id = @jobId OUTPUT
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
/****** Object:  Step [Executa procedure sp_seg_atualiza_user_SU_u]    Script Date: 05/02/2011 10:51:19 ******/
EXEC @ReturnCode = msdb.dbo.sp_add_jobstep @job_id=@jobId, @step_name=N'Executa procedure sp_seg_atualiza_user_SU_u', 
		@step_id=1, 
		@cmdexec_success_code=0, 
		@on_success_action=1, 
		@on_success_step_id=0, 
		@on_fail_action=2, 
		@on_fail_step_id=0, 
		@retry_attempts=0, 
		@retry_interval=0, 
		@os_run_priority=0, @subsystem=N'TSQL', 
		@command=N'INFRAERO.dbo.sp_seg_atualiza_user_SU_u', 
		@database_name=N'INFRAERO', 
		@flags=0
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
EXEC @ReturnCode = msdb.dbo.sp_update_job @job_id = @jobId, @start_step_id = 1
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
EXEC @ReturnCode = msdb.dbo.sp_add_jobschedule @job_id=@jobId, @name=N'Processo almoço', 
		@enabled=1, 
		@freq_type=4, 
		@freq_interval=1, 
		@freq_subday_type=1, 
		@freq_subday_interval=0, 
		@freq_relative_interval=0, 
		@freq_recurrence_factor=0, 
		@active_start_date=20090910, 
		@active_end_date=99991231, 
		@active_start_time=121000, 
		@active_end_time=235959, 
		@schedule_uid=N'34258eec-eb8d-4255-89de-b21336c84121'
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
EXEC @ReturnCode = msdb.dbo.sp_add_jobschedule @job_id=@jobId, @name=N'Processo noturno', 
		@enabled=1, 
		@freq_type=4, 
		@freq_interval=1, 
		@freq_subday_type=1, 
		@freq_subday_interval=0, 
		@freq_relative_interval=0, 
		@freq_recurrence_factor=0, 
		@active_start_date=20090910, 
		@active_end_date=99991231, 
		@active_start_time=20000, 
		@active_end_time=235959, 
		@schedule_uid=N'003e74eb-7cc8-482f-a8c4-2594cdf99205'
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
EXEC @ReturnCode = msdb.dbo.sp_add_jobserver @job_id = @jobId, @server_name = N'(local)'
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
COMMIT TRANSACTION
GOTO EndSave
QuitWithRollback:
    IF (@@TRANCOUNT > 0) ROLLBACK TRANSACTION
EndSave:

GO

/****** Object:  Job [Carga do IFRCORP]    Script Date: 05/02/2011 10:51:45 ******/
BEGIN TRANSACTION
DECLARE @ReturnCode INT
SELECT @ReturnCode = 0
/****** Object:  JobCategory [Database Engine Tuning Advisor]    Script Date: 05/02/2011 10:51:45 ******/
IF NOT EXISTS (SELECT name FROM msdb.dbo.syscategories WHERE name=N'Database Engine Tuning Advisor' AND category_class=1)
BEGIN
EXEC @ReturnCode = msdb.dbo.sp_add_category @class=N'JOB', @type=N'LOCAL', @name=N'Database Engine Tuning Advisor'
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback

END

DECLARE @jobId BINARY(16)
EXEC @ReturnCode =  msdb.dbo.sp_add_job @job_name=N'Carga do IFRCORP', 
		@enabled=1, 
		@notify_level_eventlog=0, 
		@notify_level_email=0, 
		@notify_level_netsend=0, 
		@notify_level_page=0, 
		@delete_level=0, 
		@description=N'No description available.', 
		@category_name=N'Database Engine Tuning Advisor', 
		@owner_login_name=N'sa', @job_id = @jobId OUTPUT
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
/****** Object:  Step [iniciar_carga_ifrcorp]    Script Date: 05/02/2011 10:51:56 ******/
EXEC @ReturnCode = msdb.dbo.sp_add_jobstep @job_id=@jobId, @step_name=N'iniciar_carga_ifrcorp', 
		@step_id=1, 
		@cmdexec_success_code=0, 
		@on_success_action=1, 
		@on_success_step_id=0, 
		@on_fail_action=2, 
		@on_fail_step_id=0, 
		@retry_attempts=0, 
		@retry_interval=0, 
		@os_run_priority=0, @subsystem=N'TSQL', 
		@command=N'EXEC PRC_CARGA', 
		@database_name=N'IFRCORP', 
		@flags=0
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
EXEC @ReturnCode = msdb.dbo.sp_update_job @job_id = @jobId, @start_step_id = 1
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
EXEC @ReturnCode = msdb.dbo.sp_add_jobschedule @job_id=@jobId, @name=N'agendamento', 
		@enabled=1, 
		@freq_type=4, 
		@freq_interval=1, 
		@freq_subday_type=1, 
		@freq_subday_interval=0, 
		@freq_relative_interval=0, 
		@freq_recurrence_factor=0, 
		@active_start_date=20100701, 
		@active_end_date=99991231, 
		@active_start_time=10000, 
		@active_end_time=235959, 
		@schedule_uid=N'51c72bd4-777e-4a3a-8c7e-cf3a091a394f'
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
EXEC @ReturnCode = msdb.dbo.sp_add_jobschedule @job_id=@jobId, @name=N'agendamento tarde', 
		@enabled=1, 
		@freq_type=4, 
		@freq_interval=1, 
		@freq_subday_type=1, 
		@freq_subday_interval=0, 
		@freq_relative_interval=0, 
		@freq_recurrence_factor=0, 
		@active_start_date=20100701, 
		@active_end_date=99991231, 
		@active_start_time=123000, 
		@active_end_time=235959, 
		@schedule_uid=N'0ba17c83-58ce-4763-bc2d-12b8dc52c44e'
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
EXEC @ReturnCode = msdb.dbo.sp_add_jobserver @job_id = @jobId, @server_name = N'(local)'
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
COMMIT TRANSACTION
GOTO EndSave
QuitWithRollback:
    IF (@@TRANCOUNT > 0) ROLLBACK TRANSACTION
EndSave:

GO

/****** Object:  Job [Check Espaço em Disco]    Script Date: 05/02/2011 10:52:22 ******/
BEGIN TRANSACTION
DECLARE @ReturnCode INT
SELECT @ReturnCode = 0
/****** Object:  JobCategory [Database Engine Tuning Advisor]    Script Date: 05/02/2011 10:52:22 ******/
IF NOT EXISTS (SELECT name FROM msdb.dbo.syscategories WHERE name=N'Database Engine Tuning Advisor' AND category_class=1)
BEGIN
EXEC @ReturnCode = msdb.dbo.sp_add_category @class=N'JOB', @type=N'LOCAL', @name=N'Database Engine Tuning Advisor'
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback

END

DECLARE @jobId BINARY(16)
EXEC @ReturnCode =  msdb.dbo.sp_add_job @job_name=N'Check Espaço em Disco', 
		@enabled=0, 
		@notify_level_eventlog=0, 
		@notify_level_email=0, 
		@notify_level_netsend=0, 
		@notify_level_page=0, 
		@delete_level=0, 
		@description=N'No description available.', 
		@category_name=N'Database Engine Tuning Advisor', 
		@owner_login_name=N'sa', @job_id = @jobId OUTPUT
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
/****** Object:  Step [Check espaço em Disco]    Script Date: 05/02/2011 10:52:33 ******/
EXEC @ReturnCode = msdb.dbo.sp_add_jobstep @job_id=@jobId, @step_name=N'Check espaço em Disco', 
		@step_id=1, 
		@cmdexec_success_code=0, 
		@on_success_action=3, 
		@on_success_step_id=0, 
		@on_fail_action=2, 
		@on_fail_step_id=0, 
		@retry_attempts=0, 
		@retry_interval=0, 
		@os_run_priority=0, @subsystem=N'TSQL', 
		@command=N'DECLARE @DATABASE varchar(30)
,	  @sql varchar(4000)

DECLARE _databases
CURSOR
LOCAL
FORWARD_ONLY
READ_ONLY
FOR
SELECT	LTRIM(RTRIM(name )) name
FROM	master..sysdatabases
WHERE	name not in (''tempdb'', ''model'', ''msdb'')

OPEN _databases
FETCH
NEXT
FROM _databases
INTO
@DATABASE
WHILE @@FETCH_STATUS = 0
BEGIN

	SET @sql = ''Use '' + @DATABASE + CHAR(13) 

	SET @sql = @sql + ''set nocount on '' + CHAR(13)

	SET @sql = @sql + ''Declare @reserved dec(15,0) '' + CHAR(13)
	SET @sql = @sql + '',	   @data1 dec(15,0) '' + CHAR(13)
	SET @sql = @sql + '',	   @data2 dec(15,0) '' + CHAR(13)
	SET @sql = @sql + '',	   @indexp dec(15,0) '' + CHAR(13)
	SET @sql = @sql + '',	   @unused dec(15,0) '' + CHAR(13)
	SET @sql = @sql + '',	   @dbsize dec(15,0) '' + CHAR(13)
	SET @sql = @sql + '',	   @logsize dec(15) '' + CHAR(13)
	SET @sql = @sql + '',	   @bytesperpage dec(15,0) '' + CHAR(13)
	SET @sql = @sql + '',	   @pagesperMB dec(15,0) '' + CHAR(13)
	SET @sql = @sql + '',	   @databasename varchar(30) '' + CHAR(13)
	SET @sql = @sql + '',	   @DB_Size numeric(20,2) '' + CHAR(13)
	SET @sql = @sql + '',	   @DB_Data_Size numeric(20,2) '' + CHAR(13)
	SET @sql = @sql + '',	   @DB_Space_Available numeric(20,2) '' + CHAR(13)
	SET @sql = @sql + '',	   @Reserved numeric(20,2) '' + CHAR(13)
	SET @sql = @sql + '',	   @Data numeric(20,2) '' + CHAR(13)
	SET @sql = @sql + '',	   @Indexes numeric(20,2) '' + CHAR(13)
	SET @sql = @sql + '',	   @Unused numeric(20,2) '' + CHAR(13)
	SET @sql = @sql + '',	   @DB_Log_Size numeric(20,2) '' + CHAR(13)

	SET @sql = @sql + ''Select @databasename = db_name()  '' + CHAR(13)
	SET @sql = @sql + ''DBCC UPDATEUSAGE (0) WITH NO_INFOMSGS; ''

	SET @sql = @sql + ''Select @dbsize = sum(convert(dec(15),size)) from dbo.sysfiles where (status & 64 = 0) '' + CHAR(13)
	SET @sql = @sql + ''Select @logsize = sum(convert(dec(15),size)) from dbo.sysfiles where (status & 64 <> 0) '' + CHAR(13)
	SET @sql = @sql + ''Select @bytesperpage = low from master.dbo.spt_values where number = 1 and type = ''''E'''' '' + CHAR(13)
	SET @sql = @sql + ''Select @pagesperMB = 1048576 / @bytesperpage '' + CHAR(13)

	SET @sql = @sql + ''Select @reserved = sum(reserved) from sysindexes where indid in (0, 1, 255) '' + CHAR(13)
	SET @sql = @sql + ''Select @data1 = sum(dpages) from sysindexes where indid < 2  '' + CHAR(13)
	SET @sql = @sql + ''Select @data2 = sum(used) from sysindexes where indid = 255 '' + CHAR(13)
	SET @sql = @sql + ''Select @indexp = sum(used) from sysindexes where indid in (0, 1, 255) '' + CHAR(13)
	SET @sql = @sql + ''Select @unused = sum(reserved) - sum(used) from sysindexes where indid in (0, 1, 255) '' + CHAR(13)


	SET @sql = @sql + ''Select	@DB_Size = ltrim(str((@dbsize + @logsize) / @pagesperMB,15,2)),  '' + CHAR(13)
	SET @sql = @sql + ''			@DB_Data_Size = ltrim(str((@dbsize) / @pagesperMB,15,2)), ''  + CHAR(13)
	SET @sql = @sql + ''			@DB_Space_Available = ltrim(str((@dbsize - (select sum(convert(dec(15),reserved)) from sysindexes where indid in (0, 1, 255))) / @pagesperMB,15,2)), ''  + CHAR(13)
	SET @sql = @sql + ''			@Reserved = ltrim(str((@reserved*8)/1024)), ''  + CHAR(13)
	SET @sql = @sql + ''			@Data = ltrim(str(((@data1 + @data2)*8)/1024)), ''  + CHAR(13)
	SET @sql = @sql + ''			@Indexes = ltrim(str(((@indexp - (@data1+@data2))*8)/1024)), ''  + CHAR(13)
	SET @sql = @sql + ''			@Unused = ltrim(str((@unused*8)/1024)) ''  + CHAR(13)

	SET @sql = @sql + ''Select   @DB_Log_Size = (@DB_Size - @DB_Data_Size) ''  + CHAR(13)
	
	SET @sql = @sql + ''Insert Into INFRAERO..tb_usr_space_used Values (@databasename,@DB_Size,@DB_Data_Size,@DB_Log_Size,@DB_Space_Available,@Reserved,@Data,@Indexes,@Unused,getdate(),NULL,NULL,NULL ) ''  + CHAR(13)

	EXECUTE (@sql)

	set @sql = ''master..gsp_allocated_space_ins '''''' + @DATABASE + ''''''''

	EXECUTE (@sql)

	FETCH
	NEXT
	FROM _databases
	INTO
	@DATABASE
END
CLOSE _databases
DEALLOCATE _databases', 
		@database_name=N'master', 
		@flags=0
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
/****** Object:  Step [Envia email]    Script Date: 05/02/2011 10:52:38 ******/
EXEC @ReturnCode = msdb.dbo.sp_add_jobstep @job_id=@jobId, @step_name=N'Envia email', 
		@step_id=2, 
		@cmdexec_success_code=0, 
		@on_success_action=1, 
		@on_success_step_id=0, 
		@on_fail_action=2, 
		@on_fail_step_id=0, 
		@retry_attempts=0, 
		@retry_interval=0, 
		@os_run_priority=0, @subsystem=N'TSQL', 
		@command=N'DECLARE @tableHTML  NVARCHAR(MAX) ;

SET @tableHTML =
    N''<H1>Relatório de Espaço dos LOGs - SmartStream - SQLSSII</H1>'' +
    N''<table border="1">'' +
    N''<tr><th>Database Name</th><th>DB Size</th>'' +
    N''<th>DB Log Size</th><th>DB Space Available</th><th>Reserved</th>'' +
    N''<th>Unused</th><th>Log Size Aloc</th>'' +
    N''<th>Data Alocated</th><th>Data Used</th>'' +
	N''<th>Index Alocated</th><th>Index Used</th>'' +
    N''<th>Total Database</th></tr>'' +
    CAST ( ( SELECT td = substring(Database_Name,1,20),       '''',
                    td = ISNULL(DB_Size, 0), '''',
                    td = ISNULL(DB_Log_Size, 0), '''',
                    td = ISNULL(DB_Space_Available, 0), '''',
                    td = ISNULL(Reserved, 0), '''',				
					td = ISNULL(Unused, 0), '''',
                    td = ISNULL(Log_Size_Aloc, 0), '''',
                    td = ISNULL(Data_Size_Aloc, 0), '''',
					td = ISNULL(Data, 0), '''',
                    td = ISNULL(Idx_Size_Aloc, 0), '''',
					td = ISNULL(Indexes, 0), '''',
                    td = ISNULL(Data_Size_Aloc+Idx_Size_Aloc, 0)
				FROM		INFRAERO..tb_usr_space_used 
				WHERE		User_datetime > getdate() -1 
				ORDER 
				   BY		DB_Log_Size Desc 
              FOR XML PATH(''tr''), TYPE 
    ) AS NVARCHAR(MAX) ) +
    N''</table>'' ;


exec msdb.dbo.sp_send_dbmail @recipients=''banco_de_dados@infraero.gov.br'',
		@subject = ''Espaço dos LOGs - SmartStream - SQLSSII'',
		@body = @tableHTML,
        @body_format = ''HTML'',
		@profile_name=''Manutenção Banco de Dados'',        
		@importance=''high'';', 
		@database_name=N'master', 
		@flags=0
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
EXEC @ReturnCode = msdb.dbo.sp_update_job @job_id = @jobId, @start_step_id = 1
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
EXEC @ReturnCode = msdb.dbo.sp_add_jobschedule @job_id=@jobId, @name=N'Agendamento', 
		@enabled=1, 
		@freq_type=4, 
		@freq_interval=1, 
		@freq_subday_type=1, 
		@freq_subday_interval=0, 
		@freq_relative_interval=0, 
		@freq_recurrence_factor=0, 
		@active_start_date=20090304, 
		@active_end_date=99991231, 
		@active_start_time=0, 
		@active_end_time=235959, 
		@schedule_uid=N'add21550-d5c8-47f0-8a47-1fe003877bae'
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
EXEC @ReturnCode = msdb.dbo.sp_add_jobserver @job_id = @jobId, @server_name = N'(local)'
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
COMMIT TRANSACTION
GOTO EndSave
QuitWithRollback:
    IF (@@TRANCOUNT > 0) ROLLBACK TRANSACTION
EndSave:

GO

/****** Object:  Job [Limpa Tabela de Mensagens]    Script Date: 05/02/2011 10:52:59 ******/
BEGIN TRANSACTION
DECLARE @ReturnCode INT
SELECT @ReturnCode = 0
/****** Object:  JobCategory [Database Engine Tuning Advisor]    Script Date: 05/02/2011 10:52:59 ******/
IF NOT EXISTS (SELECT name FROM msdb.dbo.syscategories WHERE name=N'Database Engine Tuning Advisor' AND category_class=1)
BEGIN
EXEC @ReturnCode = msdb.dbo.sp_add_category @class=N'JOB', @type=N'LOCAL', @name=N'Database Engine Tuning Advisor'
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback

END

DECLARE @jobId BINARY(16)
EXEC @ReturnCode =  msdb.dbo.sp_add_job @job_name=N'Limpa Tabela de Mensagens', 
		@enabled=1, 
		@notify_level_eventlog=0, 
		@notify_level_email=0, 
		@notify_level_netsend=0, 
		@notify_level_page=0, 
		@delete_level=0, 
		@description=N'BEGIN TRAN 

PRINT ''CRIA TABELA TEMPORARIA''
SELECT TOP 100000 server_name,
		seq_nbr
INTO    MSG#
from	DBSwact.dbo.message_queue_1 (NOLOCK)
where (activity_id in (''pam0120'',''pst0130'') and create_time < dateadd(dd,-2,getdate())) -- TODOS INFORMACIONALES, DATABASE ADMIN., con mas de 7 DIAS
or (create_time < dateadd(mm,-1,getdate()))                             -- TODOS con mas de 1 MESES
or (create_time < dateadd(dd,-2,getdate()) and msg_status = 3)          -- TODOS FINALIZADOS con mas de 7 DIAS

', 
		@category_name=N'Database Engine Tuning Advisor', 
		@owner_login_name=N'sa', @job_id = @jobId OUTPUT
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
/****** Object:  Step [Limpa tabelas]    Script Date: 05/02/2011 10:53:09 ******/
EXEC @ReturnCode = msdb.dbo.sp_add_jobstep @job_id=@jobId, @step_name=N'Limpa tabelas', 
		@step_id=1, 
		@cmdexec_success_code=0, 
		@on_success_action=3, 
		@on_success_step_id=0, 
		@on_fail_action=2, 
		@on_fail_step_id=0, 
		@retry_attempts=0, 
		@retry_interval=0, 
		@os_run_priority=0, @subsystem=N'TSQL', 
		@command=N'BEGIN TRAN 

PRINT ''CRIA TABELA TEMPORARIA''
SELECT TOP 100000 server_name,
		seq_nbr
INTO    MSG#
from	DBSwact.dbo.message_queue_1 (NOLOCK)
where (activity_id in (''pam0120'',''pst0130'') and create_time < dateadd(dd,-2,getdate())) -- TODOS INFORMACIONALES, DATABASE ADMIN., con mas de 7 DIAS
or (create_time < dateadd(mm,-1,getdate()))                             -- TODOS con mas de 1 MESES
or (create_time < dateadd(dd,-2,getdate()) and msg_status = 3)          -- TODOS FINALIZADOS con mas de 7 DIAS

PRINT ''DELETA TABELA message_queue_1''
--SELECT	COUNT(1)--MQ.*)
DELETE MQ
  FROM	DBSwact.dbo.message_queue_1 AS MQ (NOLOCK)
     ,  MSG# MSG
 WHERE  MQ.server_name = MSG.server_name
   AND  MQ.seq_nbr = MSG.seq_nbr

PRINT ''DROP TABELA TEMPORARIA''
DROP TABLE MSG#

COMMIT TRAN
--ROLLBACK TRAN', 
		@database_name=N'DBSwact', 
		@flags=0
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
/****** Object:  Step [Limpa Mensagens]    Script Date: 05/02/2011 10:53:15 ******/
EXEC @ReturnCode = msdb.dbo.sp_add_jobstep @job_id=@jobId, @step_name=N'Limpa Mensagens', 
		@step_id=2, 
		@cmdexec_success_code=0, 
		@on_success_action=1, 
		@on_success_step_id=0, 
		@on_fail_action=2, 
		@on_fail_step_id=0, 
		@retry_attempts=0, 
		@retry_interval=0, 
		@os_run_priority=0, @subsystem=N'TSQL', 
		@command=N'exec GEACrpt..sp_delete_message_queue_u
', 
		@database_name=N'master', 
		@flags=0
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
EXEC @ReturnCode = msdb.dbo.sp_update_job @job_id = @jobId, @start_step_id = 2
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
EXEC @ReturnCode = msdb.dbo.sp_add_jobschedule @job_id=@jobId, @name=N'Agendemento', 
		@enabled=1, 
		@freq_type=8, 
		@freq_interval=1, 
		@freq_subday_type=1, 
		@freq_subday_interval=0, 
		@freq_relative_interval=0, 
		@freq_recurrence_factor=1, 
		@active_start_date=20100324, 
		@active_end_date=99991231, 
		@active_start_time=60000, 
		@active_end_time=235959, 
		@schedule_uid=N'cd5c51a6-253b-4e02-8d8a-0c45c42ba1b4'
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
EXEC @ReturnCode = msdb.dbo.sp_add_jobserver @job_id = @jobId, @server_name = N'(local)'
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
COMMIT TRANSACTION
GOTO EndSave
QuitWithRollback:
    IF (@@TRANCOUNT > 0) ROLLBACK TRANSACTION
EndSave:

GO

/****** Object:  Job [Processamento_Classes_SS]    Script Date: 05/02/2011 10:53:36 ******/
BEGIN TRANSACTION
DECLARE @ReturnCode INT
SELECT @ReturnCode = 0
/****** Object:  JobCategory [Database Engine Tuning Advisor]    Script Date: 05/02/2011 10:53:36 ******/
IF NOT EXISTS (SELECT name FROM msdb.dbo.syscategories WHERE name=N'Database Engine Tuning Advisor' AND category_class=1)
BEGIN
EXEC @ReturnCode = msdb.dbo.sp_add_category @class=N'JOB', @type=N'LOCAL', @name=N'Database Engine Tuning Advisor'
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback

END

DECLARE @jobId BINARY(16)
EXEC @ReturnCode =  msdb.dbo.sp_add_job @job_name=N'Processamento_Classes_SS', 
		@enabled=1, 
		@notify_level_eventlog=0, 
		@notify_level_email=0, 
		@notify_level_netsend=0, 
		@notify_level_page=0, 
		@delete_level=0, 
		@description=N'No description available.', 
		@category_name=N'Database Engine Tuning Advisor', 
		@owner_login_name=N'sa', @job_id = @jobId OUTPUT
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
/****** Object:  Step [Prc_Classes]    Script Date: 05/02/2011 10:53:46 ******/
EXEC @ReturnCode = msdb.dbo.sp_add_jobstep @job_id=@jobId, @step_name=N'Prc_Classes', 
		@step_id=1, 
		@cmdexec_success_code=0, 
		@on_success_action=1, 
		@on_success_step_id=0, 
		@on_fail_action=2, 
		@on_fail_step_id=0, 
		@retry_attempts=0, 
		@retry_interval=0, 
		@os_run_priority=0, @subsystem=N'TSQL', 
		@command=N'exec gsp_processamento_das_classes', 
		@database_name=N'GEACrpt', 
		@flags=0
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
EXEC @ReturnCode = msdb.dbo.sp_update_job @job_id = @jobId, @start_step_id = 1
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
EXEC @ReturnCode = msdb.dbo.sp_add_jobschedule @job_id=@jobId, @name=N'Processa_classe', 
		@enabled=1, 
		@freq_type=4, 
		@freq_interval=1, 
		@freq_subday_type=1, 
		@freq_subday_interval=0, 
		@freq_relative_interval=0, 
		@freq_recurrence_factor=0, 
		@active_start_date=20100920, 
		@active_end_date=99991231, 
		@active_start_time=190000, 
		@active_end_time=235959, 
		@schedule_uid=N'0cf91f1e-829f-485c-a6e5-97583de67e1a'
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
EXEC @ReturnCode = msdb.dbo.sp_add_jobserver @job_id = @jobId, @server_name = N'(local)'
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
COMMIT TRANSACTION
GOTO EndSave
QuitWithRollback:
    IF (@@TRANCOUNT > 0) ROLLBACK TRANSACTION
EndSave:

GO

/****** Object:  Job [RelatorioDiarioBackup]    Script Date: 05/02/2011 10:54:07 ******/
BEGIN TRANSACTION
DECLARE @ReturnCode INT
SELECT @ReturnCode = 0
/****** Object:  JobCategory [Database Maintenance]    Script Date: 05/02/2011 10:54:07 ******/
IF NOT EXISTS (SELECT name FROM msdb.dbo.syscategories WHERE name=N'Database Maintenance' AND category_class=1)
BEGIN
EXEC @ReturnCode = msdb.dbo.sp_add_category @class=N'JOB', @type=N'LOCAL', @name=N'Database Maintenance'
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback

END

DECLARE @jobId BINARY(16)
EXEC @ReturnCode =  msdb.dbo.sp_add_job @job_name=N'RelatorioDiarioBackup', 
		@enabled=1, 
		@notify_level_eventlog=0, 
		@notify_level_email=0, 
		@notify_level_netsend=0, 
		@notify_level_page=0, 
		@delete_level=0, 
		@description=N'Relatório diário de backup dos servidores sql server', 
		@category_name=N'Database Maintenance', 
		@owner_login_name=N'sa', @job_id = @jobId OUTPUT
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
/****** Object:  Step [Verifica histórico e envia por email]    Script Date: 05/02/2011 10:54:18 ******/
EXEC @ReturnCode = msdb.dbo.sp_add_jobstep @job_id=@jobId, @step_name=N'Verifica histórico e envia por email', 
		@step_id=1, 
		@cmdexec_success_code=0, 
		@on_success_action=1, 
		@on_success_step_id=0, 
		@on_fail_action=2, 
		@on_fail_step_id=0, 
		@retry_attempts=0, 
		@retry_interval=0, 
		@os_run_priority=0, @subsystem=N'TSQL', 
		@command=N'exec sp_relatorio_backup', 
		@database_name=N'master', 
		@flags=0
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
EXEC @ReturnCode = msdb.dbo.sp_update_job @job_id = @jobId, @start_step_id = 1
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
EXEC @ReturnCode = msdb.dbo.sp_add_jobschedule @job_id=@jobId, @name=N'Executar diariamente às 10h', 
		@enabled=1, 
		@freq_type=4, 
		@freq_interval=1, 
		@freq_subday_type=1, 
		@freq_subday_interval=0, 
		@freq_relative_interval=0, 
		@freq_recurrence_factor=0, 
		@active_start_date=20110317, 
		@active_end_date=99991231, 
		@active_start_time=100000, 
		@active_end_time=235959, 
		@schedule_uid=N'9a8410e0-d39a-4a94-8618-b5c5781c57bf'
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
EXEC @ReturnCode = msdb.dbo.sp_add_jobserver @job_id = @jobId, @server_name = N'(local)'
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
COMMIT TRANSACTION
GOTO EndSave
QuitWithRollback:
    IF (@@TRANCOUNT > 0) ROLLBACK TRANSACTION
EndSave:

GO

/****** Object:  Job [jobs_gco]    Script Date: 05/02/2011 10:54:34 ******/
BEGIN TRANSACTION
DECLARE @ReturnCode INT
SELECT @ReturnCode = 0
/****** Object:  JobCategory [Database Engine Tuning Advisor]    Script Date: 05/02/2011 10:54:34 ******/
IF NOT EXISTS (SELECT name FROM msdb.dbo.syscategories WHERE name=N'Database Engine Tuning Advisor' AND category_class=1)
BEGIN
EXEC @ReturnCode = msdb.dbo.sp_add_category @class=N'JOB', @type=N'LOCAL', @name=N'Database Engine Tuning Advisor'
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback

END

DECLARE @jobId BINARY(16)
EXEC @ReturnCode =  msdb.dbo.sp_add_job @job_name=N'jobs_gco', 
		@enabled=1, 
		@notify_level_eventlog=0, 
		@notify_level_email=0, 
		@notify_level_netsend=0, 
		@notify_level_page=0, 
		@delete_level=0, 
		@description=N'procedures solicitadas para serem executas a 1:00 diariamente pelo Sr. Good, da GCO', 
		@category_name=N'Database Engine Tuning Advisor', 
		@owner_login_name=N'sa', @job_id = @jobId OUTPUT
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
/****** Object:  Step [passo_cad_total_contrato]    Script Date: 05/02/2011 10:54:44 ******/
EXEC @ReturnCode = msdb.dbo.sp_add_jobstep @job_id=@jobId, @step_name=N'passo_cad_total_contrato', 
		@step_id=1, 
		@cmdexec_success_code=0, 
		@on_success_action=1, 
		@on_success_step_id=0, 
		@on_fail_action=2, 
		@on_fail_step_id=0, 
		@retry_attempts=0, 
		@retry_interval=0, 
		@os_run_priority=0, @subsystem=N'TSQL', 
		@command=N'exec prc_pop_cad_total_contrato_consolidado
go
', 
		@database_name=N'INFRAgco', 
		@flags=0
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
/****** Object:  Step [passo_60_dias]    Script Date: 05/02/2011 10:54:49 ******/
EXEC @ReturnCode = msdb.dbo.sp_add_jobstep @job_id=@jobId, @step_name=N'passo_60_dias', 
		@step_id=2, 
		@cmdexec_success_code=0, 
		@on_success_action=1, 
		@on_success_step_id=0, 
		@on_fail_action=2, 
		@on_fail_step_id=0, 
		@retry_attempts=0, 
		@retry_interval=0, 
		@os_run_priority=0, @subsystem=N'TSQL', 
		@command=N'exec prc_exclui_60_dias
go', 
		@database_name=N'INFRAgco', 
		@flags=0
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
EXEC @ReturnCode = msdb.dbo.sp_update_job @job_id = @jobId, @start_step_id = 1
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
EXEC @ReturnCode = msdb.dbo.sp_add_jobschedule @job_id=@jobId, @name=N'Job_infragco_dia', 
		@enabled=1, 
		@freq_type=4, 
		@freq_interval=1, 
		@freq_subday_type=1, 
		@freq_subday_interval=0, 
		@freq_relative_interval=0, 
		@freq_recurrence_factor=0, 
		@active_start_date=20090601, 
		@active_end_date=99991231, 
		@active_start_time=10000, 
		@active_end_time=235959, 
		@schedule_uid=N'1a48dffb-60e3-42c7-bd1b-094a7c28b907'
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
EXEC @ReturnCode = msdb.dbo.sp_add_jobserver @job_id = @jobId, @server_name = N'(local)'
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
COMMIT TRANSACTION
GOTO EndSave
QuitWithRollback:
    IF (@@TRANCOUNT > 0) ROLLBACK TRANSACTION
EndSave:

GO

