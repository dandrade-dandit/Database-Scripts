declare @DtaJob 	varchar(8)
,	@NmeJob		varchar(255)

Select 	@DtaJob = convert(varchar(80), getdate(), 112)
,	@NmeJob = 'AIMS backup Full'

if (select  h.run_status	from 	msdb..sysjobs j
	,	msdb..sysjobsteps s
	,	msdb..sysjobhistory h
	where 	j.name = @NmeJob
	and	h.run_date = @DtaJob
	and	j.job_id = s.job_id
	and	s.job_id = h.job_id
	and	s.step_id = h.step_id
	and	s.step_id = 2) = 0 begin

	print 'Passo do Job Executado Ocorreu Erro'
end else begin
	print 'Passo do Job Executado Ocorreu Sucesso'
end