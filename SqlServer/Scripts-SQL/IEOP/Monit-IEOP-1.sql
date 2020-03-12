USE msdb ;
GO

--EXEC dbo.sp_help_jobactivity ;
--GO

DECLARE	@START_RUN_DATE VARCHAR(12)
      , @START_RUN_TIME VARCHAR(6)
	  ,	@DATA DATETIME
	  ,	@SIG_AEROPORTO VARCHAR(4)
	  , @JOB_NAME VARCHAR(100)
	  , @PERIODO SMALLINT
	  , @MINUTO INT

SELECT	@SIG_AEROPORTO = 'SBRF'
SELECT  @PERIODO = 0
SELECT  @DATA = DATEADD(HOUR, @PERIODO, GETDATE())
SELECT  @MINUTO = DATEPART(MINUTE, @DATA)
SELECT	@START_RUN_DATE = CONVERT(VARCHAR(8), @DATA, 112)
SELECT  @JOB_NAME = 'CARGA - ' + @SIG_AEROPORTO +' - IEOP - NOVO BIOGER - DADOS'

IF (@MINUTO >= 30) BEGIN
	SELECT  @START_RUN_TIME = CONVERT(VARCHAR(2),DATEPART(HOUR, @DATA)) + '3000'
END ELSE BEGIN
	SELECT  @START_RUN_TIME = CONVERT(VARCHAR(2),DATEPART(HOUR, @DATA)) + '0000'
END

CREATE TABLE ##TMP (
	job_id varchar(100),
	job_step_id int,
	job_step_desc varchar(100),
	job_name varchar(100),
	run_status int,
	run_data  int,
	run_time int,
	run_duration int,
	operator_emailed varchar(100),
	operator_netsent varchar(100),
	operator_paged varchar(100),
	retries_attempted int,
	server varchar(100),
	sig_aeroporto varchar(10)
)

INSERT INTO ##TMP (job_id, job_name, run_status, run_data, run_time, run_duration, operator_emailed, operator_netsent, operator_paged, retries_attempted, server)
EXEC dbo.sp_help_jobhistory 
    @job_name = @JOB_NAME ,
	@step_id = 1 ,
	@start_run_date = @START_RUN_DATE ,
	@start_run_time = @START_RUN_TIME;

UPDATE ##TMP SET job_step_id = 1, job_step_desc = 'RSO' WHERE job_step_id IS NULL;

INSERT INTO ##TMP (job_id, job_name, run_status, run_data, run_time, run_duration, operator_emailed, operator_netsent, operator_paged, retries_attempted, server)
EXEC dbo.sp_help_jobhistory 
    @job_name = @JOB_NAME ,
	@step_id = 2 ,
	@start_run_date = @START_RUN_DATE ,
	@start_run_time = @START_RUN_TIME;

UPDATE ##TMP SET job_step_id = 2, job_step_desc = 'RPE'  WHERE job_step_id IS NULL;

INSERT INTO ##TMP (job_id, job_name, run_status, run_data, run_time, run_duration, operator_emailed, operator_netsent, operator_paged, retries_attempted, server)
EXEC dbo.sp_help_jobhistory 
    @job_name = @JOB_NAME ,
	@step_id = 3 ,
	@start_run_date = @START_RUN_DATE ,
	@start_run_time = @START_RUN_TIME;

UPDATE ##TMP SET job_step_id = 3, job_step_desc = 'DES' WHERE job_step_id IS NULL;

INSERT INTO ##TMP (job_id, job_name, run_status, run_data, run_time, run_duration, operator_emailed, operator_netsent, operator_paged, retries_attempted, server)
EXEC dbo.sp_help_jobhistory 
    @job_name = @JOB_NAME ,
	@step_id = 4,
	@start_run_date = @START_RUN_DATE ,
	@start_run_time = @START_RUN_TIME;

UPDATE ##TMP SET job_step_id = 4, job_step_desc = 'EMB'  WHERE job_step_id IS NULL;

INSERT INTO ##TMP (job_id, job_name, run_status, run_data, run_time, run_duration, operator_emailed, operator_netsent, operator_paged, retries_attempted, server)
EXEC dbo.sp_help_jobhistory 
    @job_name = @JOB_NAME ,
	@step_id = 5,
	@start_run_date = @START_RUN_DATE ,
	@start_run_time = @START_RUN_TIME;

UPDATE ##TMP SET job_step_id = 5, job_step_desc = 'MOV'  WHERE job_step_id IS NULL;

UPDATE ##TMP SET sig_aeroporto = @SIG_AEROPORTO

SELECT	sig_aeroporto
     ,  job_name
     ,	job_step_id
	 ,	job_step_desc
	 ,	CASE run_status
	      WHEN 0 THEN 'EXECU플O FALHOU'
		  WHEN 1 THEN 'EXECU플O COM SUCESSO'
		  WHEN 2 THEN 'RETRY (STEP ONLY)'
		  WHEN 3 THEN 'EXECU플O CANCELADA'
		  WHEN 4 THEN 'EM EXECU플O'
		  WHEN 5 THEN 'DESCONHECIDO'
        END run_status
	 ,  CONVERT(DATETIME, CONVERT(VARCHAR(8), run_data)) run_data
	 ,  SUBSTRING(RIGHT ('000000' + CONVERT(VARCHAR(8), run_time), 6), 1, 2) + ':' + SUBSTRING(RIGHT ('000000' + CONVERT(VARCHAR(8), run_time), 6), 3, 2) + ':' + SUBSTRING(RIGHT ('000000' + CONVERT(VARCHAR(8), run_time), 6), 5, 2) run_time
	 ,  run_duration
  FROM	##TMP

DROP TABLE ##TMP
	