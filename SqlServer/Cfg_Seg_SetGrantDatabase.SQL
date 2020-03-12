--	AddLogins, DropAllUsers/Groups, AddAllGroups/Users, SetAllGrants
--
--	Certifique-se de estar no DATABASE correto
-- 	sp_who
Set Nocount On

print 'Cfg_Seg_SetGrantDatabase - Versao SQL7'
print ' '

if not exists ( select * from Sysobjects where Name = 'Sp_Who') begin 

	declare  @suid	smallint
		,@name	varchar(64)

	declare  @Type	char(2)
		,@cmd	varchar(255)
	
	if not exists (select * from master..syslogins where name = 'SITIA' )
		execute sp_addlogin SITIA, SITIA, AIMS

	declare cursor_sysusers cursor for 
		select 	u.uid, u.name 
		from 	sysusers u
		,	master..syslogins l
		where	u.name = l.name
		and	l.suid > 1
	
	open 	cursor_sysusers
	while (1=1) begin
		fetch 	next from cursor_sysusers INTO @suid, @name
		if (@@FETCH_STATUS = -1) break
		if exists (select * from sysusers where name = @name) begin
			execute sp_revokedbaccess @name
		end
	end
	deallocate cursor_sysusers 

	--					Insere os Usuarios no DATABASE
	--
	if not exists (select * from sysusers where name = 'Programs' )
		execute sp_addrole 'Programs'
	if not exists (select * from sysusers where name = 'Public' )
		execute sp_addrole 'Public'

	declare cursor_syslogins cursor for 
		select 	name 
		from 	master..syslogins 
		where 	suid > 1
	
	open 	cursor_syslogins
	while (1=1) begin
	
		fetch 	next from cursor_syslogins INTO @name
		if (@@FETCH_STATUS = -1) break

		execute sp_grantdbaccess @name, @name

		if (Upper(substring(@name,1,5)) = 'SITIA') begin
			execute sp_addrolemember 'Programs', @name
		end

	end
	deallocate cursor_syslogins                   
	
	--					Define Acesso aos objetos do DATABASE
	--
	Declare Cursor_Sysobjects Cursor For 
		Select 	 Name
			,Type
		From 	Sysobjects
		Where	status  >= 0
		and	(Type 	= 'U'
		Or	Type 	= 'P')
		Order By Type DESC, Name

	Open 	Cursor_Sysobjects

	While (1 = 1) begin
	
		Fetch 	Next From Cursor_Sysobjects Into @Name, @Type

		if (@@Fetch_Status = -1) break
		
		If (@Type = 'P') Begin			-- Store Procedures
			Select @Cmd = 'Revoke All On ' + @Name + ' From Public'
			Execute ( @Cmd)			Select @Cmd = 'Grant Execute  On ' + @Name + ' To Public'
			Execute ( @Cmd)
			Print @Cmd
		End Else If (@Type = 'U') Begin		-- Tabelas
			Select @Cmd = 'Revoke All On ' + @Name + ' From Public'
			Execute ( @Cmd)
			Select @Cmd = 'Revoke All On ' + @Name + ' From SITIA'
			Execute ( @Cmd)
			Select @Cmd = 'Revoke All On ' + @Name + ' From Guest'
			Execute ( @Cmd)
			Select @Cmd = 'Grant Select  On ' + @Name + ' To Public'
			Execute ( @Cmd)
			Print @Cmd
			Select @Cmd = 'Grant Insert  On ' + @Name + ' To SITIA'
			Execute ( @Cmd)
			Print @Cmd
			Select @Cmd = 'Grant Update  On ' + @Name + ' To SITIA'
			Execute ( @Cmd)
			Print @Cmd
			Select @Cmd = 'Grant Delete  On ' + @Name + ' To SITIA'
			Execute ( @Cmd)
			Print @Cmd
		End
		
	End		

	Deallocate Cursor_Sysobjects
end else begin
	Raiserror( 'Nao Executa Na Master', 16, -1)
end
Go
