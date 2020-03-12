DECLARE @UserName nvarchar(255)
DECLARE Cursor_OrphanedUser cursor for

SELECT NAME FROM sysusers 
WHERE issqluser = 1 and (sid is not null and sid <> 0x01) 
and suser_sname(sid) is NOT null 
ORDER BY name 

OPEN Cursor_OrphanedUser

FETCH NEXT FROM Cursor_OrphanedUser INTO @UserName
WHILE (@@fetch_status = 0)
BEGIN

PRINT @UserName + ' Synchronization of Logins in Progress'
EXEC sp_change_users_login 'Update_one', @UserName, @UserName
FETCH NEXT FROM Cursor_OrphanedUser INTO @UserName

END

CLOSE Cursor_OrphanedUser
DEALLOCATE Cursor_OrphanedUser

Go
---ou
--para mapear os logins orfãos
USE adventureWorks
GO

sp_change_users_login @Action='Report'
GO

 

--para ver a lista dos logins que podem ser consertados e mapeias os users com os logins
USE AdventureWorks
GO

sp_change_users_login @Action='update_one', 
@UserNamePattern='TestUser1', 
@LoginName='TestUser1'
GO

--se o login for igual ao user
EXEC sp_change_users_login 'Auto_Fix', 'TestUser2'
GO

--se o login for igual ao user
EXEC sp_change_users_login 'Auto_Fix', 'TestUser3', null,'pwd'
GO