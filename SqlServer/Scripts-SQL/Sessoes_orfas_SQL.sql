select 
db_name(req.database_id)as dbname,
req.database_id,
ses.session_id,
req.command,
ses.status,
req.blocking_session_id,
req.wait_type,
req.wait_time,
req.open_transaction_count,
req.transaction_id,
tra.transaction_id,
tra.enlist_count,
case
when tra.is_user_transaction=0 then 'System transaction'
when tra.is_user_transaction=1 then 'initiated by a user'
end as is_user_transaction,
case
when tra.is_local=1 then 'Local transaction'
when tra.is_local=0 then 'MSDTC'
end as is_local,
ses.host_name,
ses.program_name,
--ses.host_process_id,
ses.client_interface_name,
ses.login_name,
ses.original_login_name,
ses.cpu_time,
case 
when ses.transaction_isolation_level = 0 then 'Unspecified'
when ses.transaction_isolation_level = 1 then 'ReadUncomitted'
when ses.transaction_isolation_level = 2 then 'ReadCommitted'
when ses.transaction_isolation_level = 3 then 'Repeatable'
when ses.transaction_isolation_level = 4 then 'Serializable'
when ses.transaction_isolation_level = 5 then 'Snapshot'
end as transaction_isolation_level

from 
sys.dm_exec_sessions as ses 
inner join sys.dm_tran_session_transactions as tra on
ses.session_id = tra.session_id 
left join sys.dm_exec_requests as req on
ses.session_id = req.session_id
where
--req.database_id in (6,74) 
req.database_id is null 
--AND ses.is_user_process=1 
--AND ses.status <> 'running'