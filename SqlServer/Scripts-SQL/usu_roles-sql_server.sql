--ver usuários por role(perfil)
select 
 sdp.name as [user name],
 sdp.type_desc as [user type],
 upper(sdps.name) as [database role]
from sys.database_principals sdp 
inner join sys.database_role_members sdrm
on sdp.principal_id=sdrm.member_principal_id 
inner join sys.database_principals sdps 
on sdrm.role_principal_id = sdps.principal_id
order by 3,1
go

--objetos por perfil
SELECT su.name AS 'User Name', so.name AS 'Object Name', 
Action = CASE sp.action
WHEN 193 THEN 'SELECT'
WHEN 195 THEN 'INSERT'
WHEN 196 THEN 'UPDATE'
WHEN 197 THEN 'DELETE'
WHEN 224 THEN 'EXEC'
ELSE 'UNKNOWN'
END,
Status = 
CASE sp.protecttype 
WHEN 204 THEN 'GRANT_W_GRANT'
WHEN 205 THEN 'GRANT'
WHEN 206 THEN 'REVOKE'
ELSE 'Unknown'
END

FROM master.dbo.sysusers su, sysobjects so, sysprotects sp
WHERE su.uid = so.uid and
so.id = sp.id and 
so.xtype IN ('V','P','TR','U') AND LEFT(so.name,3) 
NOT IN ('dt_', 'dt', 'sys')

--objetos por perfil
-----------------------------------------------------------------------------
--- Rights Granted: Given a list of Users in the current database, return
---		the list of effective rights (including Deny) based on the Grants 
---		issued to the User, all Roles the User is a member of, membership
---		in fixed database Roles (e.g., db_datareader) and membership in any
---		fixed server roles.
-----------------------------------------------------------------------------

set nocount on

---------------------------------------
--- Define the User(s) of interest
---------------------------------------

declare @AllUsers	bit 		

select @AllUsers = 1            --<<< SET THIS VALUE
								--	1 = Gather for ALL Users
								--	0 = Gather for explicit list in @Users table
declare @Users table (
	UserName	sysname
	)

insert into @Users (UserName)
values ('RL_SIVNET_CONSULTA')			--<<< Populate with a list of Users
--	,('MySqlUser')

-----------------------------------------------------------------------------

;with AllRoles	-- Recursively find all Roles the Users are members of
as	(
	select principal_id, name, sid, cast(Null as sysname) MemberName, name BaseName
	from sys.database_principals
	where type in ('S', 'U', 'G')
	or name = 'public'	-- Public is special since it is not in sys.database_role_members

	union all

	select r.principal_id, r.name, r.sid, rm.Name, ar.BaseName
	from
		AllRoles ar
	inner join
		sys.database_role_members drm
			on	drm.member_principal_id = ar.principal_id
	inner join
		sys.database_principals r
			on	r.principal_id = drm.role_principal_id
	inner join
		sys.database_principals rm
			on	rm.principal_id = drm.member_principal_id
)
select a.*
from (
	-------------------------------------------
	--- Object Level Rights: Explicit Grants
	---	(Based on User and Role Memberships)
	-------------------------------------------

	SELECT
		coalesce(so.name, '') AS 'Object Name', 

		sp.permission_name,
		state_desc,

		u.Name Grantee,
		ar.BaseName
	FROM
		sys.database_permissions sp					-- Rights Granted
	inner join
		sys.database_principals u					-- Grantee
			on	sp.grantee_principal_id = u.principal_id

	left outer join
		sys.objects so								-- Object
			on	so.object_id = sp.major_id

	inner join
		AllRoles ar
			on	u.sid = ar.sid

	WHERE 
		(
		so.name is Null
	or
		LEFT(so.name,3) NOT IN ('sp_', 'fn_', 'dt_', 'dtp', 'sys')
		--AND
		--so.type IN ('U','V','TR','P','FN''IF','TF')
		)
	and	not (
			sp.class_desc = 'DATABASE'
		and sp.permission_name = 'CONNECT'
		)
	and	sp.major_id >= 0					-- Negative => System Object
	and (
		ar.BaseName = 'public'
		or
		@AllUsers = 1
		or
		ar.BaseName in (
			select UserName
			from @Users
			)
		)

	union all

	-------------------------------------------
	--- Fixed Database Role Membership
	-------------------------------------------

	select
		ar.name,
		'',
		'',
		ar.MemberName,
		ar.BaseName
	from
		AllRoles ar
	inner join
		sys.database_principals r
			on	r.principal_id = ar.principal_id
			and	r.is_fixed_role = 1
	where
		@AllUsers = 1
		or
		ar.BaseName in (
			select UserName
			from @Users
			)

	union all

	-------------------------------------------
	--- Fixed Server Role Membership
	--- (Assumes: Login Name == User Name)
	-------------------------------------------

	select
		sr.Name,
		'',
		'',
		'Server Role',
		l.Name
	from sys.server_principals l
	inner join
		sys.server_role_members r
	on
		r.member_principal_id = l.principal_id
	inner join
		sys.server_principals sr
	on
		sr.principal_id = r.role_principal_id
	and	sr.type = 'R'
	where
		@AllUsers = 1
		or
		l.name in (
				select UserName
				from @Users
				)
	) a
order by
	BaseName,
	case
		when permission_name = '' then 1 else 2 end,
	'Object Name',
	permission_name,
	state_desc,
	Grantee
	
	
---
select dp.NAME AS principal_name,
           dp.type_desc AS principal_type_desc,
           o.NAME AS object_name,
           p.permission_name,
           p.state_desc AS permission_state_desc
   from    sys.database_permissions p
   left    OUTER JOIN sys.all_objects o
   on     p.major_id = o.OBJECT_ID
   inner   JOIN sys.database_principals dp
   on     p.grantee_principal_id = dp.principal_id
 
--
select USER_NAME(p.grantee_principal_id) AS principal_name,
        dp.type_desc AS principal_type_desc,
        p.class_desc,
        OBJECT_NAME(p.major_id) AS object_name,
        p.permission_name,
        p.state_desc AS permission_state_desc
from    sys.database_permissions p
inner   JOIN sys.database_principals dp
on     p.grantee_principal_id = dp.principal_id

 
--
WITH    perms_cte as
(
        select USER_NAME(p.grantee_principal_id) AS principal_name,
                dp.principal_id,
                dp.type_desc AS principal_type_desc,
                p.class_desc,
                OBJECT_NAME(p.major_id) AS object_name,
                p.permission_name,
                p.state_desc AS permission_state_desc
        from    sys.database_permissions p
        inner   JOIN sys.database_principals dp
        on     p.grantee_principal_id = dp.principal_id
)
--users
SELECT p.principal_name,  p.principal_type_desc, p.class_desc, p.[object_name], p.permission_name, p.permission_state_desc, cast(NULL as sysname) as role_name
FROM    perms_cte p
WHERE   principal_type_desc <> 'DATABASE_ROLE'
UNION
--role members
SELECT rm.member_principal_name, rm.principal_type_desc, p.class_desc, p.object_name, p.permission_name, p.permission_state_desc,rm.role_name
FROM    perms_cte p
right outer JOIN (
    select role_principal_id, dp.type_desc as principal_type_desc, member_principal_id,user_name(member_principal_id) as member_principal_name,user_name(role_principal_id) as role_name--,*
    from    sys.database_role_members rm
    INNER   JOIN sys.database_principals dp
    ON     rm.member_principal_id = dp.principal_id
) rm
ON     rm.role_principal_id = p.principal_id
order by 1

--
select
 sdp.principal_id as [principal id], 
 sdp.name as username, 
 sdp.type_desc as usertype,  
 ssp.name as loginname, 
 ssp.type_desc as logintype
from sys.database_principals sdp 
inner join sys.server_principals ssp 
on sdp.principal_id = ssp.principal_id
go

--
select 
 ssp.name as [login name],
 ssp.type_desc as [login type],
 upper(ssps.name) as [server role]
from sys.server_principals ssp 
inner join sys.server_role_members ssrm
on ssp.principal_id=ssrm.member_principal_id 
inner join sys.server_principals ssps 
on ssrm.role_principal_id = ssps.principal_id