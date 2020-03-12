SELECT  j.job_id , j.name
FROM    msdb..sysjobs j
WHERE   EXISTS ( SELECT 1
                 FROM   msdb..sysjobsteps sj
                        INNER JOIN msdb..sysjobactivity ja ON ja.job_id = j.job_id
                 WHERE  sj.job_id = j.job_id
                        AND ja.start_execution_date <= GETDATE()
                        AND ja.stop_execution_date IS NULL
                        AND ja.session_id = ( SELECT    MAX(ja2.session_id)
                                              FROM      msdb..sysjobactivity ja2
                                              WHERE     ja2.job_id = j.job_id
                                            ) )
                                            

SELECT  SUBSTRING(sp.[program_name], 32, 32)
FROM    sys.dm_exec_sessions sp
WHERE   sp.Status IN ( 'running', 'sleeping' )       


/*
CREATE FUNCTION [dbo].[uf_HexToChar]
    (
      @binaryValue VARBINARY(100) ,
      @numBytes INT
    )
RETURNS VARCHAR(200)
AS
    BEGIN

        DECLARE @i VARBINARY(10) ,
            @hexdigits CHAR(16) ,
            @s VARCHAR(100) ,
            @h VARCHAR(100) ,
            @currentByte SMALLINT
        SET @hexdigits = '0123456789ABCDEF'
        SET @currentByte = 0
        SET @h = ''
          -- process all  bytes
        WHILE @currentByte < @numBytes
            BEGIN
                SET @currentByte = @currentByte + 1
          -- get first character of byte
                SET @i = SUBSTRING(CAST(@binaryValue AS VARBINARY(100)), @currentByte, 1)
          -- get the first character
                SET @s = CAST(SUBSTRING(@hexdigits, @i % 16 + 1, 1) AS CHAR(1))
          -- shift over one character
                SET @i = @i / 16
          -- get the second character
                SET @s = CAST(SUBSTRING(@hexdigits, @i % 16 + 1, 1) AS CHAR(1))
                    + @s
          -- build string of hex characters
                SET @h = @h + @s
            END
        RETURN(@h)
    END
GO

CREATE FUNCTION uf_IsGUID ( @Value VARCHAR(MAX) )
RETURNS BIT
AS
    BEGIN
        DECLARE @rtn BIT
        SET @rtn = 0
        IF @Value IS NULL OR LOWER(@Value) LIKE '[a-f0-9][a-f0-9][a-f0-9][a-f0-9][a-f0-9][a-f0-9][a-f0

-9][a-f0-9]\-[a-f0-9][a-f0-9][a-f0-9][a-f0-9]\-[a-f0-9][a-f0-9][a-f0-9][a-f0-9]\-[a-f0-9][a-f0-9][a-f0

-9][a-f0-9]\-[a-f0-9][a-f0-9][a-f0-9][a-f0-9][a-f0-9][a-f0-9][a-f0-9][a-f0-9][a-f0-9][a-f0-9][a-f0-9]

[a-f0-9]'
            ESCAPE '\'
            SET @rtn = 1
        RETURN @rtn
    END
GO

CREATE FUNCTION [dbo].[uf_IsSQLAgentJobRunning]
    (
      @SQLAgentJobNameFragmentOrId VARCHAR(128)
    )
RETURNS BIT
AS
    BEGIN

        DECLARE @rtn BIT ,
            @isGUID BIT

        -- assume job is not running; must prove otherwise!
        SET @rtn = 0

        -- scrub inputs
        SET @SQLAgentJobNameFragmentOrId = NULLIF(@SQLAgentJobNameFragmentOrId,
                                                  LTRIM(RTRIM('')))

        -- return NULL if NULL or blanks passed (sanity check)
        IF @SQLAgentJobNameFragmentOrId IS NULL
            RETURN NULL

        -- was a job_id passed ?
        SET @isGUID = dbo.uf_IsGUID(@SQLAgentJobNameFragmentOrId)

        -- if no matching job found by job_id or name, return NULL
        IF 1 <> ( SELECT  COUNT(*)
                        FROM    msdb..sysjobs j WITH ( NOLOCK )
                        WHERE   ( @isGUID = 0
                                  AND j.name LIKE '%'
                                  + @SQLAgentJobNameFragmentOrId + '%'
                                )
                                OR ( @isGUID = 1
                                     AND j.job_id = @SQLAgentJobNameFragmentOrId
                                   ) )
            RETURN NULL

        -- if both msdb and dm_exec_sessions considers the job as "running", return 1
        IF EXISTS ( SELECT  1
                    FROM    msdb..sysjobs j
                    WHERE   dbo.uf_HexToChar(j.job_id, 16) IN (
                            SELECT  SUBSTRING(sp.[program_name], 32, 32)
                            FROM    sys.dm_exec_sessions sp
                            WHERE   sp.Status IN ( 'running', 'sleeping' ) )
                            AND ( ( @isGUID = 0
                                    AND j.name LIKE '%'
                                    + @SQLAgentJobNameFragmentOrId + '%'
                                  )
                                  OR ( @isGUID = 1
                                       AND j.job_id = @SQLAgentJobNameFragmentOrId
                                     )
                                ) )
            AND EXISTS ( SELECT 1
                         FROM   msdb..sysjobs j
                         WHERE  EXISTS ( SELECT 1
                                         FROM   msdb..sysjobsteps sj
                                                INNER JOIN msdb..sysjobactivity ja ON ja.job_id =

j.job_id
                                         WHERE  sj.job_id = j.job_id
                                                AND ja.start_execution_date <= GETDATE()
                                                AND ja.stop_execution_date IS NULL
                                                AND ja.session_id = ( SELECT
                                                              MAX(ja2.session_id)
                                                              FROM
                                                              msdb..sysjobactivity ja2
                                                              WHERE
                                                              ja2.job_id = j.job_id
                                                              ) ) )
            SET @rtn = 1

        RETURN @rtn

    END
GO

*/                    

SELECT  j.job_id, j.name
FROM    msdb..sysjobs j
WHERE   dbo.uf_HexToChar(j.job_id, 16) IN (
        SELECT  SUBSTRING(sp.[program_name], 32, 32)
        FROM    sys.dm_exec_sessions sp
        WHERE   sp.status IN ( 'running', 'sleeping' ) )          
        
        

SELECT [dbo].[uf_IsSQLAgentJobRunning]('My Job name here')      

SELECT [dbo].[uf_IsSQLAgentJobRunning]('FEFB4793-22F1-4744-916C-E672A7D14756') 

WHILE [dbo].[uf_IsSQLAgentJobRunning]('FEFB4793-22F1-4744-916C-E672A7D14756') = 1
BEGIN
   WAITFOR DELAY '00:01:00'
END
EXEC some critical process

SELECT * FROM SomeDataTable WHERE [dbo].[uf_IsSQLAgentJobRunning]('FEFB4793-22F1-4744-916C-E672A7D14756') = 0

WHILE [dbo].[uf_IsSQLAgentJobRunning]('FEFB4793-22F1-4744-916C-E672A7D14756') = 0
BEGIN
   --process row(s) or a batch of data as long as job hasn't restarted
END

WHILE [dbo].[uf_IsSQLAgentJobRunning]('FEFB4793-22F1-4744-916C-E672A7D14756') = 1
BEGIN
   WAITFOR DELAY '00:00:01'
END

WHILE [dbo].[uf_IsSQLAgentJobRunning]('A') = 1
BEGIN
   WAITFOR DELAY '00:00:01'
END
EXEC msdb.dbo.sp_Start_job @job_name='B'