-- Script generated on 22/10/2003 10:54
-- By: sa
-- Server: 10.2.17.22 (S_GRBN22)

BEGIN TRANSACTION            
  DECLARE @JobID BINARY(16)  
  DECLARE @ReturnCode INT    
  SELECT @ReturnCode = 0     
IF (SELECT COUNT(*) FROM msdb.dbo.syscategories WHERE name = N'Database Maintenance') < 1 
  EXECUTE msdb.dbo.sp_add_category @name = N'Database Maintenance'

  -- Delete the job with the same name (if it exists)
  SELECT @JobID = job_id     
  FROM   msdb.dbo.sysjobs    
  WHERE (name = N'Backup BDO Full')       
  IF (@JobID IS NOT NULL)    
  BEGIN  
  -- Check if the job is a multi-server job  
  IF (EXISTS (SELECT  * 
              FROM    msdb.dbo.sysjobservers 
              WHERE   (job_id = @JobID) AND (server_id <> 0))) 
  BEGIN 
    -- There is, so abort the script 
    RAISERROR (N'Unable to import job ''Backup BDO Full'' since there is already a multi-server job with this name.', 16, 1) 
    GOTO QuitWithRollback  
  END 
  ELSE 
    -- Delete the [local] job 
    EXECUTE msdb.dbo.sp_delete_job @job_name = N'Backup BDO Full' 
    SELECT @JobID = NULL
  END 

BEGIN 

  -- Add the job
  EXECUTE @ReturnCode = msdb.dbo.sp_add_job @job_id = @JobID OUTPUT , @job_name = N'Backup BDO Full', @owner_login_name = N'sa', @description = N'No description available.', @category_name = N'Database Maintenance', @enabled = 1, @notify_level_email = 0, @notify_level_page = 0, @notify_level_netsend = 0, @notify_level_eventlog = 2, @delete_level= 0
  IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback 

  -- Add the job steps
  EXECUTE @ReturnCode = msdb.dbo.sp_add_jobstep @job_id = @JobID, @step_id = 1, @step_name = N'Rot Backup BDO Full', @command = N'Backup Database BDO to disk = ''D:\MSSQL7\Backup\BDO_FULL.bak'' WITH  INIT ,  NOUNLOAD ,  NAME = N''BDO backup FULL'',  NOSKIP ,  STATS = 10,  NOFORMAT', @database_name = N'master', @server = N'', @database_user_name = N'', @subsystem = N'TSQL', @cmdexec_success_code = 0, @flags = 0, @retry_attempts = 0, @retry_interval = 1, @output_file_name = N'', @on_success_step_id = 0, @on_success_action = 3, @on_fail_step_id = 0, @on_fail_action = 2
  IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback 
  EXECUTE @ReturnCode = msdb.dbo.sp_add_jobstep @job_id = @JobID, @step_id = 2, @step_name = N'Send_email', @command = N'd:\mssql7\postie -from:GRBN22@infraero.gov.br -to:denis_andrade@infraero.gov.br,ronei@infraero.gov.br,talita_barros.cnsp@infraero.gov.br -s:Backup_BDO_full_OK -nomsg -host:10.0.17.47', @database_name = N'', @server = N'', @database_user_name = N'', @subsystem = N'CmdExec', @cmdexec_success_code = 0, @flags = 0, @retry_attempts = 0, @retry_interval = 1, @output_file_name = N'', @on_success_step_id = 0, @on_success_action = 1, @on_fail_step_id = 0, @on_fail_action = 2
  IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback 
  EXECUTE @ReturnCode = msdb.dbo.sp_update_job @job_id = @JobID, @start_step_id = 1 

  IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback 

  -- Add the job schedules
  EXECUTE @ReturnCode = msdb.dbo.sp_add_jobschedule @job_id = @JobID, @name = N'Rot Backup BDO Full', @enabled = 1, @freq_type = 4, @active_start_date = 20031016, @active_start_time = 0, @freq_interval = 1, @freq_subday_type = 8, @freq_subday_interval = 6, @freq_relative_interval = 0, @freq_recurrence_factor = 0, @active_end_date = 99991231, @active_end_time = 235959
  IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback 

  -- Add the Target Servers
  EXECUTE @ReturnCode = msdb.dbo.sp_add_jobserver @job_id = @JobID, @server_name = N'(local)' 
  IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback 

END
COMMIT TRANSACTION          
GOTO   EndSave              
QuitWithRollback:
  IF (@@TRANCOUNT > 0) ROLLBACK TRANSACTION 
EndSave: 


