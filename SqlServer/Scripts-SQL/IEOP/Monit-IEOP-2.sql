/*
USE IEOP

EXEC IEOP.[dbo].PRC_MONIT_CARGA_IEOP 1, 1, 'SBRF'

*/
ALTER PROCEDURE [dbo].PRC_MONIT_CARGA_IEOP (@P_SHOW TINYINT = 0, @P_PERIODO TINYINT = 0, @P_SIG VARCHAR(4)=NULL)
AS 
DECLARE	@START_RUN_DATE VARCHAR(12)
      , @START_RUN_TIME VARCHAR(6)
	  ,	@DATA DATETIME
	  ,	@SIG_AEROPORTO VARCHAR(4)
	  , @JOB_NAME VARCHAR(100)
	  , @PERIODO SMALLINT
	  , @MINUTO INT
	  ,	@run_status_tmp int
	  , @run_time_tmp int
	  , @run_duration_tmp int

BEGIN

SET NOCOUNT ON;

IF (@P_PERIODO > 24) BEGIN
	SELECT	@PERIODO = -24
END ELSE BEGIN
	SELECT	@PERIODO = @P_PERIODO * -1
END;
SELECT  @DATA = DATEADD(HOUR, @PERIODO, GETDATE())
SELECT  @MINUTO = DATEPART(MINUTE, @DATA)
SELECT	@START_RUN_DATE = CONVERT(VARCHAR(8), @DATA, 112)

IF (@MINUTO >= 30) BEGIN
	SELECT  @START_RUN_TIME = CONVERT(VARCHAR(2),DATEPART(HOUR, @DATA)) + '3000'
END ELSE BEGIN
	SELECT  @START_RUN_TIME = CONVERT(VARCHAR(2),DATEPART(HOUR, @DATA)) + '0000'
END

CREATE TABLE ##TMP (
    sig_aeroporto varchar(4),
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
	server varchar(100)
)

CREATE TABLE ##TMP2 (
    sig_aeroporto varchar(4),
	job_name varchar(100),
	run_data  int,
	job_step_id_rso int,
	job_step_desc_rso varchar(100),
	run_status_rso int,
	run_time_rso int,
	run_duration_rso int,
	job_step_id_rpe int,
	job_step_desc_rpe varchar(100),
	run_status_rpe int,
	run_time_rpe int,
	run_duration_rpe int,
	job_step_id_des int,
	job_step_desc_des varchar(100),
	run_status_des int,
	run_time_des int,
	run_duration_des int,
	job_step_id_emb int,
	job_step_desc_emb varchar(100),
	run_status_emb int,
	run_time_emb int,
	run_duration_emb int,
	job_step_id_mov int,
	job_step_desc_mov varchar(100),
	run_status_mov int,
	run_time_mov int,
	run_duration_mov int
)

DECLARE cursor_aeroportos CURSOR FOR 
SELECT	sig_aeroporto
  FROM	BIOGER..BIOGER_SERVERS_SISO WITH (NOLOCK)
 WHERE  sta_srv_primario = 1
   AND  (@P_SIG IS NULL OR sig_aeroporto = @P_SIG)
   --AND  sig_aeroporto NOT IN ('SBBR', 'SBGR', 'SBKP')
 ORDER
    BY	1

OPEN cursor_aeroportos

FETCH NEXT FROM cursor_aeroportos
INTO @SIG_AEROPORTO

WHILE @@FETCH_STATUS = 0
BEGIN
	BEGIN TRY
		SELECT  @JOB_NAME = 'CARGA - ' + @SIG_AEROPORTO +' - IEOP - NOVO BIOGER - DADOS';

		--CARGA HISTORICO EXECU플O DO STEP - RSO
		INSERT INTO ##TMP (job_id, job_name, run_status, run_data, run_time, run_duration, operator_emailed, operator_netsent, operator_paged, retries_attempted, server)
		EXEC msdb.dbo.sp_help_jobhistory 
			@job_name = @JOB_NAME ,
			@step_id = 1 ,
			@start_run_date = @START_RUN_DATE ,
			@start_run_time = @START_RUN_TIME;

		UPDATE ##TMP SET job_step_id = 1, job_step_desc = 'RSO', sig_aeroporto = @SIG_AEROPORTO WHERE job_step_id IS NULL;

		INSERT INTO ##TMP2 (sig_aeroporto, job_name, run_data, job_step_id_rso, job_step_desc_rso, run_status_rso, run_time_rso, run_duration_rso)
		SELECT sig_aeroporto, job_name, run_data, 1, 'RSO', run_status, run_time, run_duration
		  FROM ##TMP;


		--CARGA HISTORICO EXECU플O DO STEP - RPE
		INSERT INTO ##TMP (job_id, job_name, run_status, run_data, run_time, run_duration, operator_emailed, operator_netsent, operator_paged, retries_attempted, server)
		EXEC msdb.dbo.sp_help_jobhistory 
			@job_name = @JOB_NAME ,
			@step_id = 2 ,
			@start_run_date = @START_RUN_DATE ,
			@start_run_time = @START_RUN_TIME;

		UPDATE ##TMP SET job_step_id = 2, job_step_desc = 'RPE', sig_aeroporto = @SIG_AEROPORTO  WHERE job_step_id IS NULL;

		UPDATE ##TMP2
		   SET	job_step_id_rpe = 2
			 ,	job_step_desc_rpe = 'RPE'
			 ,	run_status_rpe = ISNULL(T1.run_status, 0)
			 ,	run_time_rpe = T1.run_time
			 ,	run_duration_rpe = T1.run_duration
	     FROM	##TMP T1
		     ,	##TMP2 T2
		WHERE	T1.job_step_id = 2
		   AND  T1.sig_aeroporto = @SIG_AEROPORTO 
		   AND  T1.sig_aeroporto = T2.sig_aeroporto
		   AND  SUBSTRING(RIGHT('0000'+ CONVERT(VARCHAR(10),T1.run_time), 6), 1, 4) = SUBSTRING(RIGHT('0000'+ CONVERT(VARCHAR(10),T2.run_time_rso), 6), 1, 4);

		--CARGA HISTORICO EXECU플O DO STEP - DES
		INSERT INTO ##TMP (job_id, job_name, run_status, run_data, run_time, run_duration, operator_emailed, operator_netsent, operator_paged, retries_attempted, server)
		EXEC msdb.dbo.sp_help_jobhistory 
			@job_name = @JOB_NAME ,
			@step_id = 3,
			@start_run_date = @START_RUN_DATE ,
			@start_run_time = @START_RUN_TIME;

		UPDATE ##TMP SET job_step_id = 3, job_step_desc = 'DES', sig_aeroporto = @SIG_AEROPORTO  WHERE job_step_id IS NULL;

		UPDATE ##TMP2
		   SET	job_step_id_des = 3
			 ,	job_step_desc_des = 'DES'
			 ,	run_status_des = ISNULL(T1.run_status, 0)
			 ,	run_time_des = T1.run_time
			 ,	run_duration_des = T1.run_duration
	     FROM	##TMP T1
		     ,	##TMP2 T2
		WHERE	T1.job_step_id = 3
		   AND  T1.sig_aeroporto = @SIG_AEROPORTO 
		   AND  T1.sig_aeroporto = T2.sig_aeroporto
		   AND  SUBSTRING(RIGHT('0000'+ CONVERT(VARCHAR(10),T1.run_time), 6), 1, 4) = SUBSTRING(RIGHT('0000'+ CONVERT(VARCHAR(10),T2.run_time_rso), 6), 1, 4);

		
		--CARGA HISTORICO EXECU플O DO STEP - EMB
		INSERT INTO ##TMP (job_id, job_name, run_status, run_data, run_time, run_duration, operator_emailed, operator_netsent, operator_paged, retries_attempted, server)
		EXEC msdb.dbo.sp_help_jobhistory 
			@job_name = @JOB_NAME ,
			@step_id = 4 ,
			@start_run_date = @START_RUN_DATE ,
			@start_run_time = @START_RUN_TIME;

		UPDATE ##TMP SET job_step_id = 4, job_step_desc = 'EMB', sig_aeroporto = @SIG_AEROPORTO  WHERE job_step_id IS NULL;

		UPDATE ##TMP2
		   SET	job_step_id_emb = 4
			 ,	job_step_desc_emb = 'EMB'
			 ,	run_status_emb = ISNULL(T1.run_status, 0)
			 ,	run_time_emb = T1.run_time
			 ,	run_duration_emb = T1.run_duration
	     FROM	##TMP T1
		     ,	##TMP2 T2
		WHERE	T1.job_step_id = 4
		   AND  T1.sig_aeroporto = @SIG_AEROPORTO 
		   AND  T1.sig_aeroporto = T2.sig_aeroporto
		   AND  SUBSTRING(RIGHT('0000'+ CONVERT(VARCHAR(10),T1.run_time), 6), 1, 4) = SUBSTRING(RIGHT('0000'+ CONVERT(VARCHAR(10),T2.run_time_rso), 6), 1, 4);


		--CARGA HISTORICO EXECU플O DO STEP - MOV
		INSERT INTO ##TMP (job_id, job_name, run_status, run_data, run_time, run_duration, operator_emailed, operator_netsent, operator_paged, retries_attempted, server)
		EXEC msdb.dbo.sp_help_jobhistory 
			@job_name = @JOB_NAME ,
			@step_id = 5,
			@start_run_date = @START_RUN_DATE ,
			@start_run_time = @START_RUN_TIME;

		UPDATE ##TMP SET job_step_id = 5, job_step_desc = 'MOV', sig_aeroporto = @SIG_AEROPORTO  WHERE job_step_id IS NULL;

		UPDATE ##TMP2
		   SET	job_step_id_mov = 5
			 ,	job_step_desc_mov = 'MOV'
			 ,	run_status_mov = ISNULL(T1.run_status, 0)
			 ,	run_time_mov = T1.run_time
			 ,	run_duration_mov = T1.run_duration
	     FROM	##TMP T1
		     ,	##TMP2 T2
		WHERE	T1.job_step_id = 5
		   AND  T1.sig_aeroporto = @SIG_AEROPORTO 
		   AND  T1.sig_aeroporto = T2.sig_aeroporto
		   AND  SUBSTRING(RIGHT('0000'+ CONVERT(VARCHAR(10),T1.run_time), 6), 1, 4) = SUBSTRING(RIGHT('0000'+ CONVERT(VARCHAR(10),T2.run_time_rso), 6), 1, 4);

		--UPDATE AEROPORTO
		 UPDATE ##TMP SET sig_aeroporto = @SIG_AEROPORTO
	END TRY

	BEGIN CATCH
		PRINT 'ERRO NO AEROPORTO: ' + @SIG_AEROPORTO
	END CATCH

	FETCH NEXT FROM cursor_aeroportos
	INTO @SIG_AEROPORTO

	DELETE FROM ##TMP;

	SELECT	@run_status_tmp = NULL
		 ,	@run_time_tmp = NULL
		 ,	@run_duration_tmp = NULL;
END


CLOSE cursor_aeroportos;
DEALLOCATE cursor_aeroportos;

IF (@P_SHOW = 0) BEGIN
	SELECT  --DISTINCT
			sig_aeroporto
		 ,  CONVERT(DATETIME, CONVERT(VARCHAR(8), run_data)) run_data
		 ,  SUBSTRING(RIGHT ('000000' + CONVERT(VARCHAR(8), run_time_rso), 6), 1, 2) + ':' + SUBSTRING(RIGHT ('000000' + CONVERT(VARCHAR(8), run_time_rso), 6), 3, 2) + ':' + SUBSTRING(RIGHT ('000000' + CONVERT(VARCHAR(8), run_time_rso), 6), 5, 2) run_time
		 ,	job_step_desc_rso
		 ,	CASE run_status_rso
			  WHEN 0 THEN 'EXECU플O FALHOU'
			  WHEN 1 THEN 'EXECUTADO COM SUCESSO'
			  WHEN 2 THEN 'RETRY (STEP ONLY)'
			  WHEN 3 THEN 'EXECU플O CANCELADA'
			  WHEN 4 THEN 'EM EXECU플O'
			  WHEN 5 THEN 'DESCONHECIDO'
			END desc_run_status_rso
		 ,  run_status_rso
		 ,	job_step_desc_rpe
		 ,	CASE run_status_rpe
			  WHEN 0 THEN 'EXECU플O FALHOU'
			  WHEN 1 THEN 'EXECUTADO COM SUCESSO'
			  WHEN 2 THEN 'RETRY (STEP ONLY)'
			  WHEN 3 THEN 'EXECU플O CANCELADA'
			  WHEN 4 THEN 'EM EXECU플O'
			  WHEN 5 THEN 'DESCONHECIDO'
			END desc_run_status_rpe
		 ,  run_status_rpe
		 ,	job_step_desc_des
		 ,	CASE run_status_des
			  WHEN 0 THEN 'EXECU플O FALHOU'
			  WHEN 1 THEN 'EXECUTADO COM SUCESSO'
			  WHEN 2 THEN 'RETRY (STEP ONLY)'
			  WHEN 3 THEN 'EXECU플O CANCELADA'
			  WHEN 4 THEN 'EM EXECU플O'
			  WHEN 5 THEN 'DESCONHECIDO'
			END desc_run_status_des
		 ,  run_status_des
		 ,	job_step_desc_emb
		 ,	CASE run_status_emb
			  WHEN 0 THEN 'EXECU플O FALHOU'
			  WHEN 1 THEN 'EXECUTADO COM SUCESSO'
			  WHEN 2 THEN 'RETRY (STEP ONLY)'
			  WHEN 3 THEN 'EXECU플O CANCELADA'
			  WHEN 4 THEN 'EM EXECU플O'
			  WHEN 5 THEN 'DESCONHECIDO'
			END desc_run_status_emb
		 ,  run_status_emb
		 ,	job_step_desc_mov
		 ,	CASE run_status_mov
			  WHEN 0 THEN 'EXECU플O FALHOU'
			  WHEN 1 THEN 'EXECUTADO COM SUCESSO'
			  WHEN 2 THEN 'RETRY (STEP ONLY)'
			  WHEN 3 THEN 'EXECU플O CANCELADA'
			  WHEN 4 THEN 'EM EXECU플O'
			  WHEN 5 THEN 'DESCONHECIDO'
			END desc_run_status_mov
		 ,  run_status_mov 
	  FROM ##TMP2
	  ORDER BY run_status_des, sig_aeroporto, run_data, run_time_des DESC;
END ELSE BEGIN
		SELECT  --DISTINCT
			sig_aeroporto
		 ,	job_name
		 ,  CONVERT(DATETIME, CONVERT(VARCHAR(8), run_data)) run_data
		 ,	job_step_id_rso
		 ,	job_step_desc_rso
		 ,	CASE run_status_rso
			  WHEN 0 THEN 'EXECU플O FALHOU'
			  WHEN 1 THEN 'EXECUTADO COM SUCESSO'
			  WHEN 2 THEN 'RETRY (STEP ONLY)'
			  WHEN 3 THEN 'EXECU플O CANCELADA'
			  WHEN 4 THEN 'EM EXECU플O'
			  WHEN 5 THEN 'DESCONHECIDO'
			END desc_run_status_rso
		 ,  run_status_rso
		 ,  SUBSTRING(RIGHT ('000000' + CONVERT(VARCHAR(8), run_time_rso), 6), 1, 2) + ':' + SUBSTRING(RIGHT ('000000' + CONVERT(VARCHAR(8), run_time_rso), 6), 3, 2) + ':' + SUBSTRING(RIGHT ('000000' + CONVERT(VARCHAR(8), run_time_rso), 6), 5, 2) run_time_rso
		 ,  run_duration_rso 
		 ,	job_step_id_rpe
		 ,	job_step_desc_rpe
		 ,	CASE run_status_rpe
			  WHEN 0 THEN 'EXECU플O FALHOU'
			  WHEN 1 THEN 'EXECUTADO COM SUCESSO'
			  WHEN 2 THEN 'RETRY (STEP ONLY)'
			  WHEN 3 THEN 'EXECU플O CANCELADA'
			  WHEN 4 THEN 'EM EXECU플O'
			  WHEN 5 THEN 'DESCONHECIDO'
			END desc_run_status_rpe
		 ,  run_status_rpe
		 ,  SUBSTRING(RIGHT ('000000' + CONVERT(VARCHAR(8), run_time_rpe), 6), 1, 2) + ':' + SUBSTRING(RIGHT ('000000' + CONVERT(VARCHAR(8), run_time_rpe), 6), 3, 2) + ':' + SUBSTRING(RIGHT ('000000' + CONVERT(VARCHAR(8), run_time_rpe), 6), 5, 2) run_time_rpe
		 ,  run_duration_rpe 
		 ,	job_step_id_des
		 ,	job_step_desc_des
		 ,	CASE run_status_des
			  WHEN 0 THEN 'EXECU플O FALHOU'
			  WHEN 1 THEN 'EXECUTADO COM SUCESSO'
			  WHEN 2 THEN 'RETRY (STEP ONLY)'
			  WHEN 3 THEN 'EXECU플O CANCELADA'
			  WHEN 4 THEN 'EM EXECU플O'
			  WHEN 5 THEN 'DESCONHECIDO'
			END desc_run_status_des
		 ,  run_status_des
		 ,  SUBSTRING(RIGHT ('000000' + CONVERT(VARCHAR(8), run_time_des), 6), 1, 2) + ':' + SUBSTRING(RIGHT ('000000' + CONVERT(VARCHAR(8), run_time_des), 6), 3, 2) + ':' + SUBSTRING(RIGHT ('000000' + CONVERT(VARCHAR(8), run_time_des), 6), 5, 2) run_time_des
		 ,  run_duration_des 
		 ,	job_step_id_emb
		 ,	job_step_desc_emb
		 ,	CASE run_status_emb
			  WHEN 0 THEN 'EXECU플O FALHOU'
			  WHEN 1 THEN 'EXECUTADO COM SUCESSO'
			  WHEN 2 THEN 'RETRY (STEP ONLY)'
			  WHEN 3 THEN 'EXECU플O CANCELADA'
			  WHEN 4 THEN 'EM EXECU플O'
			  WHEN 5 THEN 'DESCONHECIDO'
			END desc_run_status_emb
		 ,  run_status_emb
		 ,  SUBSTRING(RIGHT ('000000' + CONVERT(VARCHAR(8), run_time_emb), 6), 1, 2) + ':' + SUBSTRING(RIGHT ('000000' + CONVERT(VARCHAR(8), run_time_emb), 6), 3, 2) + ':' + SUBSTRING(RIGHT ('000000' + CONVERT(VARCHAR(8), run_time_emb), 6), 5, 2) run_time_emb
		 ,  run_duration_emb 
		 ,	job_step_id_mov
		 ,	job_step_desc_mov
		 ,	CASE run_status_mov
			  WHEN 0 THEN 'EXECU플O FALHOU'
			  WHEN 1 THEN 'EXECUTADO COM SUCESSO'
			  WHEN 2 THEN 'RETRY (STEP ONLY)'
			  WHEN 3 THEN 'EXECU플O CANCELADA'
			  WHEN 4 THEN 'EM EXECU플O'
			  WHEN 5 THEN 'DESCONHECIDO'
			END desc_run_status_mov
		 ,  run_status_mov
		 ,  SUBSTRING(RIGHT ('000000' + CONVERT(VARCHAR(8), run_time_mov), 6), 1, 2) + ':' + SUBSTRING(RIGHT ('000000' + CONVERT(VARCHAR(8), run_time_mov), 6), 3, 2) + ':' + SUBSTRING(RIGHT ('000000' + CONVERT(VARCHAR(8), run_time_mov), 6), 5, 2) run_time_mov
		 ,  run_duration_mov 
	  FROM ##TMP2
	  ORDER BY run_status_des, sig_aeroporto, run_data, run_time_des DESC;
END;

DROP TABLE ##TMP;
DROP TABLE ##TMP2;
END;