--kill 129
--select * from sys.sysprocesses where spid = 714

dbcc inputbuffer (432)

--PAG
use DBSwact
go

dbcc page (6,1,1014766, 3)

                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                  
select object_name(389576426)




--TAB: 74:631725353:13
--
use GEACufcf
go

select object_name(631725353)

--KEY: 6:72057595316011008 (010086470766)
--KEY: 6:72057595316338688 (76021497f191)
use DBSwact
go

SELECT o.name as obj_name, i.name as idx_name
FROM sys.partitions p 
JOIN sys.objects o ON p.object_id = o.object_id 
JOIN sys.indexes i ON p.object_id = i.object_id 
AND p.index_id = i.index_id 
WHERE p.hobt_id = 72057595316011008 

select p.[object_id], p.[index_id], a.total_pages 
from sys.partitions p join sys.allocation_units a on p.partition_id=a.container_id
where a.container_id=72057595316011008

select object_name(325576198)