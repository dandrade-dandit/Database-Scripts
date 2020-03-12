SELECT	*
--delete
  FROM	TCYT_CALL
 WHERE  ID_RESOURCE_CENTER_ORIGIN = 4073
   AND  DT_CALL > '2011-03-23 00:00:00.000'
   AND  DE_DIALED_NUMBER LIKE '90%'
   AND  ID_CALL_STATUS = 1
 ORDER BY DT_CALL, HR_CALL
 
 
select
	  f.id_closing, c.id_call
from
	           dbo.tcyt_resource          a  WITH (NOLOCK) 
	left  join dbo.tcyt_contract		  a1 WITH (NOLOCK) on a.id_contract				= a1.id_contract
	left  join dbo.tcyt_call              c  WITH (NOLOCK) on a.id_resource 			= c.id_resource_extension
	left  join dbo.tcyt_call_service	  d  WITH (NOLOCK) on c.id_call_service			= d.id_call_service
	left  join dbo.tcyt_service_plan	  e  WITH (NOLOCK) on d.id_service_plan			= e.id_service_plan
	inner join dbo.tcyt_closing			  f  WITH (NOLOCK) on c.dt_call between f.dt_begin_closing and f.dt_end_closing
	                                                      and a1.id_company = f.id_company
where f.de_closing = '2011/04' 



select
	  f.id_closing, count(1) --, c.id_call
from
	           dbo.tcyt_resource          a  WITH (NOLOCK) 
	left  join dbo.tcyt_contract		  a1 WITH (NOLOCK) on a.id_contract				= a1.id_contract
	left  join dbo.tcyt_call              c  WITH (NOLOCK) on a.id_resource 			= c.id_resource_extension
	left  join dbo.tcyt_call_service	  d  WITH (NOLOCK) on c.id_call_service			= d.id_call_service
	left  join dbo.tcyt_service_plan	  e  WITH (NOLOCK) on d.id_service_plan			= e.id_service_plan
	inner join dbo.tcyt_closing			  f  WITH (NOLOCK) on c.dt_call between f.dt_begin_closing and f.dt_end_closing
	                                                      and a1.id_company = f.id_company
where f.de_closing = '2011/04' 
group by f.id_closing