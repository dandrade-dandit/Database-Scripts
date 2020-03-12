declare @nome_db varchar(100)

select @nome_db = DB_NAME()

select	'SQLCMD -S sqlssii -d ' + @nome_db + ' -E -Q "exec sp_helptext ''dbo.' + name + '''" -o "d:\' + @nome_db + '\' + 
	case type
	   when 'V' then 'VIEW - ' 
	   when 'P' then 'PROC - '
	   when 'TR' then 'TRIGGER - '
	end
	+ name + '.sql" -W -h-1' 
  from	sys.objects
 where  type in ('V','P', 'TR')
 ORDER BY TYPE





