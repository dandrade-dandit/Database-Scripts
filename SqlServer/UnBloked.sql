-- =============================================
-- Declare and using a READ_ONLY cursor
-- =============================================
-- select * from TB_WHO2
use master
go

SET NOCOUNT ON
DECLARE	@Counter   	INT
,	@StartTime 	DATETIME
,	@MaxMinutes 	INT
,	@BlkBy		varchar(5)
,	@Qtd		int
,	@Txt	 	varchar(128)
,	@Now	 	varchar(128)
	

SELECT  @MaxMinutes 	= 1		-- Limit on time allowed
,	@StartTime	= GETDATE()

DECLARE OBJ_CURSOR CURSOR READ_ONLY FOR 
	select	BlkBy
	,	Qtd = count(*) 
	from 	TB_WHO2
	where	BlkBy != '  .  '
	and 	Login = 'xxxIntranet'
	group 	by BlkBy
	order 	by count(*) desc

WHILE	@MaxMinutes > DATEDIFF (mi, @StartTime, GETDATE()) BEGIN 										-- Outer loop.

	delete	TB_WHO2
	insert	TB_WHO2
	exec	SP_WHO2
	select	@Counter	= 0

	select	@Now = 'Data ' + convert(varchar(32), GETDATE(), 113)
	print 	@Now
	
	OPEN OBJ_CURSOR
	
	WHILE (1=1) BEGIN
		FETCH NEXT FROM OBJ_CURSOR 
		INTO	@BlkBy
		,	@Qtd	
	
		IF @@fetch_status = -1 BREAK
		
		if ( @Counter = 0 ) 	print 'BlkBy-Qtd--Server'

		SELECT	@Txt 	= CONVERT(CHAR(6), SPID) 
				+ CONVERT(CHAR(5), @Qtd )			
				+ ', ' + HostName
				+ ', ' + DBName
				+ ', ' + Command
		FROM	TB_WHO2 
		WHERE	SPID = @BlkBy

		print 	@Txt
		if exists ( SELECT * FROM TB_WHO2 WHERE	SPID = @BlkBy and Command = 'AWAITING COMMAND' ) begin
			SELECT	@Txt 	= 'kill ' + CONVERT(VARCHAR(5), @BlkBy )
			EXEC (@Txt)
		end
		--   						
		SELECT  @Counter	= @Counter + 1
	END
	
	CLOSE OBJ_CURSOR

	WAITFOR DELAY '00:00:05'
END  
 										
DEALLOCATE OBJ_CURSOR
GO

