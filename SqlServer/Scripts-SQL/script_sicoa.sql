--Restore database ( SICOA )

--Criar o login/usuário  SICOAADM

use master
go
--Mudar a compatibilidade do SICOA para 9.0
--SP_DBCMPTLEVEL sicoa,90;
go
sp_addlogin @loginame = 'sicoaadm',@passwd = 'sicoaa',@defdb = 'sicoa',@deflanguage = 'English'
go
exec sp_grantdbaccess N'sicoaadm', N'sicoaadm'
exec sp_addrolemember N'db_owner', N'sicoaadm'
exec sp_addsrvrolemember N'sicoaadm', securityadmin
grant execute on sp_adduser to sicoaadm
grant execute on sp_dropuser to sicoaadm
grant execute on sp_addrole to sicoaadm
grant execute on sp_addlogin to sicoaadm
grant execute on sp_droplogin to sicoaadm
grant execute on sp_password to sicoaadm
go
sp_addlogin @loginame = 'sicoa_carga',@passwd = '1infraero@',@defdb = 'sicoa',@deflanguage = 'English'
go
use sicoa
go
--DBCC UPDATEUSAGE (0);
go
exec sp_grantdbaccess N'sicoaadm', N'sicoaadm'
exec sp_addrolemember N'db_owner', N'sicoaadm'
EXEC sp_addrolemember N'SICOA_ROLE', N'sicoaadm'
EXEC sp_addrolemember N'SICOA_ROLE_CARGA', N'sicoa_carga'
go


-- Mudar o schema dos objetos
use sicoa
select 'ALTER SCHEMA sicoaadm TRANSFER ' + name + ';'
from sysobjects

use sicoa
ALTER AUTHORIZATION ON ROLE::[SICOA_ROLE] TO [sicoaadm]

-- Atribuir os privilegios a role "sicoa_role"
use sicoa
GRANT SELECT, INSERT, DELETE, UPDATE ON sicoaadm.Acessos TO SICOA_ROLE
GRANT SELECT, INSERT, DELETE, UPDATE ON sicoaadm.Aeroportos TO SICOA_ROLE
GRANT SELECT, INSERT, DELETE, UPDATE ON sicoaadm.Areas TO SICOA_ROLE
GRANT SELECT, INSERT, DELETE, UPDATE ON sicoaadm.Cargos TO SICOA_ROLE
GRANT SELECT, INSERT, DELETE, UPDATE ON sicoaadm.Categorias TO SICOA_ROLE
GRANT SELECT, INSERT, DELETE, UPDATE ON sicoaadm.Cidades TO SICOA_ROLE
GRANT SELECT, INSERT, DELETE, UPDATE ON sicoaadm.CursosHabilitacao TO SICOA_ROLE
GRANT SELECT, INSERT, DELETE, UPDATE ON sicoaadm.CursosIdentificados TO SICOA_ROLE
GRANT SELECT, INSERT, DELETE, UPDATE ON sicoaadm.dtproperties TO SICOA_ROLE
GRANT SELECT, INSERT, DELETE, UPDATE ON sicoaadm.Empresas TO SICOA_ROLE
GRANT SELECT, INSERT, DELETE, UPDATE ON sicoaadm.Estados TO SICOA_ROLE
GRANT SELECT, INSERT, DELETE, UPDATE ON sicoaadm.Etiquetas TO SICOA_ROLE
GRANT SELECT, INSERT, DELETE, UPDATE ON sicoaadm.EtqVisitantes TO SICOA_ROLE
GRANT SELECT, INSERT, DELETE, UPDATE ON sicoaadm.Feriados TO SICOA_ROLE
GRANT SELECT, INSERT, DELETE, UPDATE ON sicoaadm.Funcionalidades TO SICOA_ROLE
GRANT SELECT, INSERT, DELETE, UPDATE ON sicoaadm.Funcoes TO SICOA_ROLE
GRANT SELECT, INSERT, DELETE, UPDATE ON sicoaadm.Grupos TO SICOA_ROLE
GRANT SELECT, INSERT, DELETE, UPDATE ON sicoaadm.GruposLeitoras TO SICOA_ROLE
GRANT SELECT, INSERT, DELETE, UPDATE ON sicoaadm.Habilitados TO SICOA_ROLE
GRANT SELECT, INSERT, DELETE, UPDATE ON sicoaadm.Identificados TO SICOA_ROLE
GRANT SELECT, INSERT, DELETE, UPDATE ON sicoaadm.ImgAeroportos TO SICOA_ROLE
GRANT SELECT, INSERT, DELETE, UPDATE ON sicoaadm.ImgEmpresas TO SICOA_ROLE
GRANT SELECT, INSERT, DELETE, UPDATE ON sicoaadm.ImgEtiquetas TO SICOA_ROLE
GRANT SELECT, INSERT, DELETE, UPDATE ON sicoaadm.ImgIdentificados TO SICOA_ROLE
GRANT SELECT, INSERT, DELETE, UPDATE ON sicoaadm.ImgMapas TO SICOA_ROLE
GRANT SELECT, INSERT, DELETE, UPDATE ON sicoaadm.ImgTiposEmpresas TO SICOA_ROLE
GRANT SELECT, INSERT, DELETE, UPDATE ON sicoaadm.ImgVisitantes TO SICOA_ROLE
GRANT SELECT, INSERT, DELETE, UPDATE ON sicoaadm.Leitoras TO SICOA_ROLE
GRANT SELECT, INSERT, DELETE, UPDATE ON sicoaadm.Listas TO SICOA_ROLE
GRANT SELECT, INSERT, DELETE, UPDATE ON sicoaadm.Log_Sicoa TO SICOA_ROLE
GRANT SELECT, INSERT, DELETE, UPDATE ON sicoaadm.Logons TO SICOA_ROLE
GRANT SELECT, INSERT, DELETE, UPDATE ON sicoaadm.Logs TO SICOA_ROLE
GRANT SELECT, INSERT, DELETE, UPDATE ON sicoaadm.logsbackup TO SICOA_ROLE
GRANT SELECT, INSERT, DELETE, UPDATE ON sicoaadm.Lotacoes TO SICOA_ROLE
GRANT SELECT, INSERT, DELETE, UPDATE ON sicoaadm.Mapas TO SICOA_ROLE
GRANT SELECT, INSERT, DELETE, UPDATE ON sicoaadm.Ocorrencias TO SICOA_ROLE
GRANT SELECT, INSERT, DELETE, UPDATE ON sicoaadm.OcorrenciasAtiv TO SICOA_ROLE
GRANT SELECT, INSERT, DELETE, UPDATE ON sicoaadm.PortaoAcesso TO SICOA_ROLE
GRANT SELECT, INSERT, DELETE, UPDATE ON sicoaadm.Sequences TO SICOA_ROLE
GRANT SELECT, INSERT, DELETE, UPDATE ON sicoaadm.Solicitacoes TO SICOA_ROLE
GRANT SELECT, INSERT, DELETE, UPDATE ON sicoaadm.Tarefas TO SICOA_ROLE
GRANT SELECT, INSERT, DELETE, UPDATE ON sicoaadm.Tipos TO SICOA_ROLE
GRANT SELECT, INSERT, DELETE, UPDATE ON sicoaadm.TiposEmpresas TO SICOA_ROLE
GRANT SELECT, INSERT, DELETE, UPDATE ON sicoaadm.TipoServicoVeiculo TO SICOA_ROLE
GRANT SELECT, INSERT, DELETE, UPDATE ON sicoaadm.TiposLeitoras TO SICOA_ROLE
GRANT SELECT, INSERT, DELETE, UPDATE ON sicoaadm.Usuarios TO SICOA_ROLE
GRANT SELECT, INSERT, DELETE, UPDATE ON sicoaadm.UsuariosFuncionalidades TO SICOA_ROLE
GRANT SELECT, INSERT, DELETE, UPDATE ON sicoaadm.UsuariosFuncoes TO SICOA_ROLE
GRANT SELECT, INSERT, DELETE, UPDATE ON sicoaadm.Veiculos TO SICOA_ROLE
GRANT SELECT, INSERT, DELETE, UPDATE ON sicoaadm.Vinculos TO SICOA_ROLE
GRANT SELECT, INSERT, DELETE, UPDATE ON sicoaadm.Visitantes TO SICOA_ROLE
GRANT EXECUTE ON sicoaadm.PRC_INSERE_LOG_SICOA TO SICOA_ROLE

use sicoa
ALTER AUTHORIZATION ON ROLE::[SICOA_ROLE_CARGA] TO [sicoaadm]

-- Atribuir os privilegios a role "sicoa_role_carga"
grant select on sicoaadm.identificados to  SICOA_ROLE_CARGA
grant select on sicoaadm.vinculos to SICOA_ROLE_CARGA 
grant select on sicoaadm.lotacoes to SICOA_ROLE_CARGA
grant select on sicoaadm.empresas to SICOA_ROLE_CARGA

-- Criar os logins
-- Exemplo EXEC sp_addLogin 'usuário', password, 'Banco'
use sicoa
select 'EXEC sp_addLogin ''' + login +
 ''', ''' + senha + ''', ''' + 'sicoa''' 
from sicoaadm.usuarios

ou

use sicoa
select 'CREATE LOGIN ' + login + ' WITH PASSWORD = ''' + senha + ''', DEFAULT_DATABASE = sicoa,  CHECK_POLICY =  OFF;'
from sicoaadm.usuarios

-- Criar os logins para senha menor que 6
-- Exemplo EXEC sp_addLogin 'usuário', password, 'Banco'
use sicoa
select 'EXEC sp_addLogin ''' + login +
 ''', ''nsjvdhtq1'', ''' + 'sicoa''' 
from sicoaadm.usuarios
where len(senha)<6


-- Showing a report of the current user to login mappings
use sicoa
EXEC sp_change_users_login 'report'

-- Mapping a database user to a new SQL Server login
-- Exemplo EXEC sp_change_users_login 'Acao', 'user', 'login', 'password';
use sicoa
select 'EXEC sp_change_users_login @Action =' + '''Update_One''' + ', @UserNamePattern =''' + login +
 ''', @LoginName = ''' + login + ''''
from sicoaadm.usuarios

OU 

use sicoa
select 'EXEC sp_change_users_login ' + '''Auto_Fix''' + ', ''' + login + ''''
from sicoaadm.usuarios

EXEC sp_change_users_login @Action ='Update_One', @UserNamePattern ='MASTER', @LoginName = 'MASTER'
EXEC sp_change_users_login @Action ='Update_One', @UserNamePattern ='SICOAADM', @LoginName = 'SICOAADM'
EXEC sp_change_users_login @Action ='Update_One', @UserNamePattern ='sicoa_carga', @LoginName = 'sicoa_carga'
EXEC sp_change_users_login @Action ='Update_One', @UserNamePattern ='user_sica', @LoginName = 'user_sica'
EXEC sp_change_users_login 'Update_One', 'usr_dba_sede', 'usr_dba_sede';


-- Alterar o default schema para sicoaadm 
USE [sicoa]
GO
select 'ALTER USER ' + login +
 ' WITH DEFAULT_SCHEMA=[sicoaadm]' 
from sicoaadm.usuarios
GO
ALTER USER sicoaadm WITH DEFAULT_SCHEMA=[sicoaadm]
GO

-- Drop schemas
select 'DROP login ' + login 
from sicoaadm.usuarios

