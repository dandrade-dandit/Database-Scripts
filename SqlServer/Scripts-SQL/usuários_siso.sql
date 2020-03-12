--#Restore database ( BDO e Integracao)

--#Criar os logins

use master
go
CREATE LOGIN user_stms WITH PASSWORD = 'stms@user', DEFAULT_DATABASE=[INTEGRACAO], DEFAULT_LANGUAGE=[Português], CHECK_EXPIRATION=OFF, CHECK_POLICY=OFF;
CREATE LOGIN sitia WITH PASSWORD = '_P_MF0M5H8WES1662UH_DNSSOF2LZ8', DEFAULT_DATABASE=[BDO], DEFAULT_LANGUAGE=[Português], CHECK_EXPIRATION=OFF, CHECK_POLICY=OFF;
CREATE LOGIN user_agente WITH PASSWORD = 'agente', DEFAULT_DATABASE=[BDO], DEFAULT_LANGUAGE=[Português], CHECK_EXPIRATION=OFF, CHECK_POLICY=OFF;
CREATE LOGIN siso_carga WITH PASSWORD = 'X275siso@Z', DEFAULT_DATABASE=[BDO], DEFAULT_LANGUAGE=[Português], CHECK_EXPIRATION=OFF, CHECK_POLICY=OFF;
CREATE LOGIN user_sapios WITH PASSWORD = 'user_sapios', DEFAULT_DATABASE=[INTEGRACAO], DEFAULT_LANGUAGE=[Português], CHECK_EXPIRATION=OFF, CHECK_POLICY=OFF; 
CREATE LOGIN bdoadmin WITH PASSWORD=N'sainfra', DEFAULT_DATABASE=[bdo], DEFAULT_LANGUAGE=[Português], CHECK_EXPIRATION=OFF, CHECK_POLICY=OFF;
CREATE LOGIN usr_dba_sede WITH PASSWORD=N'infraero', DEFAULT_DATABASE=[bdo], DEFAULT_LANGUAGE=[Português], CHECK_EXPIRATION=OFF, CHECK_POLICY=OFF;
CREATE LOGIN usr_sivnet_carga WITH PASSWORD = 'sivnet@usr', DEFAULT_DATABASE=[INTEGRACAO], DEFAULT_LANGUAGE=[Português], CHECK_EXPIRATION=OFF, CHECK_POLICY=OFF;
CREATE LOGIN usr_dba_srrj WITH PASSWORD=N'infrasrrj', DEFAULT_DATABASE=[master], DEFAULT_LANGUAGE=[Português], CHECK_EXPIRATION=OFF, CHECK_POLICY=OFF;
CREATE LOGIN usr_dba_sede WITH PASSWORD=N'infraero', DEFAULT_DATABASE=[bdo], DEFAULT_LANGUAGE=[Português], CHECK_EXPIRATION=OFF, CHECK_POLICY=OFF;
CREATE LOGIN usr_datastage WITH PASSWORD=N'Infraer@', DEFAULT_DATABASE=[bdo], DEFAULT_LANGUAGE=[Português], CHECK_EXPIRATION=OFF, CHECK_POLICY=OFF;

--#Ajustar os usuários com os logins

USE [INTEGRACAO]
GO
EXEC sp_change_users_login 'report'
EXEC sp_change_users_login 'Update_One', 'user_stms', 'user_stms';
EXEC sp_change_users_login 'Update_One', 'sitia', 'sitia';
EXEC sp_change_users_login 'Update_One', 'siso_carga', 'siso_carga';
EXEC sp_change_users_login 'Update_One', 'bdoadmin', 'bdoadmin';
EXEC sp_change_users_login 'Update_One', 'usr_dba_sede', 'usr_dba_sede';
EXEC sp_change_users_login 'Update_One', 'usr_sivnet_carga', 'usr_sivnet_carga';
--EXEC sp_change_users_login 'Update_One', 'user_sapios', 'user_sapios';

USE [BDO]
GO
EXEC sp_change_users_login 'report'
EXEC sp_change_users_login 'Update_One', 'user_stms', 'user_stms';
EXEC sp_change_users_login 'Update_One', 'sitia', 'sitia';
EXEC sp_change_users_login 'Update_One', 'user_agente', 'user_agente';
EXEC sp_change_users_login 'Update_One', 'siso_carga', 'siso_carga';
EXEC sp_change_users_login 'Update_One', 'usr_dba_sede', 'usr_dba_sede';
EXEC sp_change_users_login 'Update_One', 'bdoadmin', 'bdoadmin';
EXEC sp_change_users_login 'Update_One', 'usr_sivnet_carga', 'usr_sivnet_carga';
EXEC sp_change_users_login 'Update_One', 'usr_datastage', 'usr_datastage';
--EXEC sp_change_users_login 'Update_One', 'user_sapios', 'user_sapios';


-- # Ajustar o esquema default

USE [BDO]
GO
ALTER USER SITIA WITH DEFAULT_SCHEMA=[dbo]
ALTER USER user_agente WITH DEFAULT_SCHEMA=[dbo]
ALTER USER siso_carga WITH DEFAULT_SCHEMA=[dbo]
ALTER USER [user_stms] WITH DEFAULT_SCHEMA=[dbo]
ALTER USER [bdoadmin] WITH DEFAULT_SCHEMA=[dbo]
GO
USE [INTEGRACAO]
GO
ALTER USER [SITIA] WITH DEFAULT_SCHEMA=[dbo]
ALTER USER siso_carga WITH DEFAULT_SCHEMA=[dbo]
ALTER USER user_stms WITH DEFAULT_SCHEMA=[dbo]
ALTER USER [bdoadmin] WITH DEFAULT_SCHEMA=[dbo]
GO


