WITH usu as 
        (select	name, is_disabled
		  from	sys.sql_logins
		 where  type = 'S'
		   and  name not like 'I%'
		   and  name not like '##%'
		   and  name not in ('sa', 'DBS', 'DBSBATCH', 'D_SEDE\CLUSTER', 'BUILTIN\Administrators', 'DBSSecurity'))

SELECT		user_id
      ,		rtrim(ltrim(first_name)) + ' ' + rtrim(ltrim(last_name)) as nome 
      ,		CASE a.is_disabled
                WHEN 0 THEN 'ATIVO'
                WHEN 1 THEN 'DESATIVADO'
                ELSE 'DESCONHECIDO' 
             END AS STATUS_BANCO
   FROM		DBSwact..user_master_1
	  ,		usu a
  where		user_id *= a.name
	and		user_id not like 'I%'
	and		user_id not like '##%'
	and		user_id not in ('sa', 'DBS', 'DBSBATCH', 'D_SEDE\CLUSTER', 'BUILTIN\Administrators', 'DBSSecurity')