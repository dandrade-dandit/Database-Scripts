DECLARE @DATABASE varchar(30)

set @DATABASE= 'DBSwsam'

set nocount on

PRINT 'use ' + @DATABASE

PRINT '--SCRIPT PARA GERAÇÃO DAS ROLES'
--para ROLES
SELECT	'CREATE ROLE [' + name + '] WITH DEFAULT_SCHEMA = [dbo];' 
FROM	sysusers
WHERE	name not in ('DBSSecurity','guest','dbo','public','db_owner','db_accessadmin','db_securityadmin','db_ddladmin','db_backupoperator','db_datareader','db_datawriter','db_denydatareader','db_denydatawriter','Backup$Operators')
AND		issqlrole = 1

PRINT '--SCRIPT PARA GERAÇÃO DOS USUÁRIOS'
--para USER
SELECT	'CREATE USER [' + name + '];' 
FROM	sysusers
WHERE	name not in ('DBSSecurity','guest','dbo','public','db_owner','db_accessadmin','db_securityadmin','db_ddladmin','db_backupoperator','db_datareader','db_datawriter','db_denydatareader','db_denydatawriter','Backup$Operators')
AND		issqlrole = 0

PRINT '--SCRIPT PARA GERAÇÃO DA RELAÇÃO USUÁRIOS POR ROLES'
--para USER por ROLES
--SELECT	'exec sp_grantdbaccess N''' + (select name from sysusers where issqlrole = 0 and uid = memberuid) + ''', ''' + (select name from sysusers where issqlrole = 0 and uid = memberuid) + ''''
--FROM	sysmembers 

SELECT	'exec sp_addrolemember N''' + (select name from sysusers where issqlrole = 1 and uid = groupuid) + ''', ''' + (select name from sysusers where issqlrole = 0 and uid = memberuid) + ''''
FROM	sysmembers 

--exec sp_help_revlogin_2000_to_2005 @login_name=I9028405, @include_db=1, @include_role=1
