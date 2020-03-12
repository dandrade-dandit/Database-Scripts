--Script para backup full online semanal.
BACKUP DATABASE PUBS 
TO  DISK = N'f:\PUBS_FULL.BAK' 
WITH  INIT,  
NOUNLOAD,  
NAME = N'PUBS BACKUP FULL',  
NOSKIP,  
STATS = 10,  
NOFORMAT 

--Script para backup diferencial online diário menos no dia do full.
BACKUP DATABASE PUBS 
TO  DISK = N'D:\MSSQL\BACKUP\PUBS_DIF.BAK' 
WITH  INIT,  
NOUNLOAD,  
DIFFERENTIAL,  
NAME = N'PUBS BACKUP DIF',  
NOSKIP,  
STATS = 10,  
NOFORMAT 

--Script para backup dos log online a cada 1 ou 2 horas.
--Após o backup ele limpa os logs. 
--Se for SQL SERVER 7.0 antes de executar esse comando tem q desabilitar 
--nas propriedades do database a opção "truncate log on checkpoint".
BACKUP LOG PUBS 
TO DISK = N'F:\PUBS_LOG.BAK'
WITH INIT,
NOUNLOAD,  
NAME = N'PUBS BACKUP LOG'

