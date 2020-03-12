select job_name
     , step_name
     , case run_status
        when 0 then 'Erro'
        When 1 then 'Sucesso'
        Else 'Desconhecido'
       end run_status
     , run_datetime
     , run_duration 
from 
( 
select job_name, run_datetime, step_name, run_status,
SUBSTRING(run_duration, 1, 2) + ':' + SUBSTRING(run_duration, 3, 2) + ':' + 
SUBSTRING(run_duration, 5, 2) AS run_duration 
from 
( 
select DISTINCT 
j.name as job_name, step_name, run_status,
run_datetime = CONVERT(DATETIME, RTRIM(run_date)) + 
(run_time * 9 + run_time % 10000 * 6 + run_time % 100 * 10) / 216e4, 
run_duration = RIGHT('000000' + CONVERT(varchar(6), run_duration), 6) 
from msdb..sysjobhistory h 
inner join msdb..sysjobs j 
on h.job_id = j.job_id 
) t 
where job_name = 'CARGA - INTEGRAÇÃO SISO SMART'
  and convert(varchar(8), run_datetime,112) = convert(varchar(8), GETDATE(), 112)
) t 
order by run_datetime, job_name, step_name
