-- Script generated on 01/02/02 12:57
-- By: sa
-- Server: S_SEBN60

IF (EXISTS (SELECT name FROM msdb.dbo.sysalerts WHERE name = N'Demo: Full msdb log'))
 ---- Delete the alert with the same name.
  EXECUTE msdb.dbo.sp_delete_alert @name = N'Demo: Full msdb log' 
BEGIN 
EXECUTE msdb.dbo.sp_add_alert @name = N'Demo: Full msdb log', @message_id = 9002, @severity = 0, @enabled = 1, @delay_between_responses = 10, @include_event_description_in = 5, @database_name = N'msdb', @category_name = N'[Uncategorized]'
END
 