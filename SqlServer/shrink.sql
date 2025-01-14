/*
RESTORE FILELISTONLY 
	FROM DISK = '\\S-SEAN34\d$\backup\DBSPACEUSED.BAK'
*/
SET NOCOUNT ON
DECLARE @LogicalFileName sysname,
   @MaxMinutes INT,
   @NewSize INT

-- *** MAKE SURE TO CHANGE THE NEXT 4 LINES WITH YOUR CRITERIA. ***
USE     BDO              -- This is the name of the database
                          -- for which the log will be shrunk.
SELECT  @LogicalFileName = 'aims_log',  -- Use sp_helpfile to 
-- identify the logical file 
-- name that you want to shrink.
   @MaxMinutes = 5,      -- Limit on time allowed to wrap log.
   @NewSize    = 50  -- in MB

-- Setup / initialize
DECLARE @OriginalSize int
SELECT @OriginalSize = size -- in 8K pages
FROM sysfiles
WHERE name = @LogicalFileName
SELECT 'Original Size of ' + db_name() + ' LOG is ' + 
   CONVERT(VARCHAR(30),@OriginalSize) + ' 8K pages or ' + 
   CONVERT(VARCHAR(30),(@OriginalSize*8/1024)) + 'MB'
FROM sysfiles
WHERE name = @LogicalFileName

CREATE TABLE DummyTrans
(DummyColumn char (8000) not null)

-- Wrap log and truncate it.
DECLARE @Counter   INT,
   @StartTime DATETIME,
   @TruncLog  VARCHAR(255)
SELECT  @StartTime = GETDATE(),
   @TruncLog = 'BACKUP LOG ['+ db_name() + '] WITH TRUNCATE_ONLY'
-- Try an initial shrink.
DBCC SHRINKFILE (@LogicalFileName, @NewSize)

EXEC (@TruncLog)

-- Wrap the log if necessary.
WHILE     @MaxMinutes > DATEDIFF (mi, @StartTime, GETDATE()) -- time has not expired
 AND @OriginalSize = (SELECT size FROM sysfiles WHERE name = @LogicalFileName)  -- the log has not shrunk    
 AND (@OriginalSize * 8 /1024) > @NewSize  -- The value passed in for new size is smaller than the current size.
BEGIN -- Outer loop.
SELECT @Counter = 0
WHILE  ((@Counter < @OriginalSize / 16) AND (@Counter < 50000))
 BEGIN -- update
   INSERT DummyTrans VALUES ('Fill Log')  -- Because it is a char field it inserts 8000 bytes.
   DELETE DummyTrans
   SELECT @Counter = @Counter + 1
 END   -- update

EXEC (@TruncLog)  -- See if a trunc of the log shrinks it.

END   -- outer loop
SELECT 'Final Size of ' + db_name() + ' LOG is ' +
   CONVERT(VARCHAR(30),size) + ' 8K pages or ' + 
   CONVERT(VARCHAR(30),(size*8/1024)) + 'MB'
FROM sysfiles 
WHERE name = @LogicalFileName
DROP TABLE DummyTrans
PRINT '*** Perform a full database backup ***'
SET NOCOUNT OFF