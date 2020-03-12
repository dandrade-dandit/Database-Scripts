DECLARE @DATABASE varchar(30)
,		@sql varchar(4000)

--TRUNCATE TABLE INFRAERO..tb_usr_space_used

DECLARE _databases
CURSOR
LOCAL
FORWARD_ONLY
READ_ONLY
FOR
SELECT	LTRIM(RTRIM(name )) name
FROM	master..sysdatabases
WHERE	name not in ('tempdb', 'model', 'msdb')

OPEN _databases
FETCH
NEXT
FROM _databases
INTO
@DATABASE
WHILE @@FETCH_STATUS = 0
BEGIN

	SET @sql = 'Use ' + @DATABASE + CHAR(13) 

	SET @sql = @sql + 'set nocount on ' + CHAR(13)

	SET @sql = @sql + 'Declare @reserved dec(15,0) ' + CHAR(13)
	SET @sql = @sql + ',	   @data1 dec(15,0) ' + CHAR(13)
	SET @sql = @sql + ',	   @data2 dec(15,0) ' + CHAR(13)
	SET @sql = @sql + ',	   @indexp dec(15,0) ' + CHAR(13)
	SET @sql = @sql + ',	   @unused dec(15,0) ' + CHAR(13)
	SET @sql = @sql + ',	   @dbsize dec(15,0) ' + CHAR(13)
	SET @sql = @sql + ',	   @logsize dec(15) ' + CHAR(13)
	SET @sql = @sql + ',	   @bytesperpage dec(15,0) ' + CHAR(13)
	SET @sql = @sql + ',	   @pagesperMB dec(15,0) ' + CHAR(13)
	SET @sql = @sql + ',	   @databasename varchar(30) ' + CHAR(13)
	SET @sql = @sql + ',	   @DB_Size numeric(20,2) ' + CHAR(13)
	SET @sql = @sql + ',	   @DB_Data_Size numeric(20,2) ' + CHAR(13)
	SET @sql = @sql + ',	   @DB_Space_Available numeric(20,2) ' + CHAR(13)
	SET @sql = @sql + ',	   @Reserved numeric(20,2) ' + CHAR(13)
	SET @sql = @sql + ',	   @Data numeric(20,2) ' + CHAR(13)
	SET @sql = @sql + ',	   @Indexes numeric(20,2) ' + CHAR(13)
	SET @sql = @sql + ',	   @Unused numeric(20,2) ' + CHAR(13)
	SET @sql = @sql + ',	   @DB_Log_Size numeric(20,2) ' + CHAR(13)

	SET @sql = @sql + 'Select @databasename = db_name()  ' + CHAR(13)
	--SET @sql = @sql + 'DBCC UPDATEUSAGE (0) WITH NO_INFOMSGS; '

	SET @sql = @sql + 'Select @dbsize = sum(convert(dec(15),size)) from dbo.sysfiles where (status & 64 = 0) ' + CHAR(13)
	SET @sql = @sql + 'Select @logsize = sum(convert(dec(15),size)) from dbo.sysfiles where (status & 64 <> 0) ' + CHAR(13)
	SET @sql = @sql + 'Select @bytesperpage = low from master.dbo.spt_values where number = 1 and type = ''E'' ' + CHAR(13)
	SET @sql = @sql + 'Select @pagesperMB = 1048576 / @bytesperpage ' + CHAR(13)

	SET @sql = @sql + 'Select @reserved = sum(reserved) from sysindexes where indid in (0, 1, 255) ' + CHAR(13)
	SET @sql = @sql + 'Select @data1 = sum(dpages) from sysindexes where indid < 2  ' + CHAR(13)
	SET @sql = @sql + 'Select @data2 = sum(used) from sysindexes where indid = 255 ' + CHAR(13)
	SET @sql = @sql + 'Select @indexp = sum(used) from sysindexes where indid in (0, 1, 255) ' + CHAR(13)
	SET @sql = @sql + 'Select @unused = sum(reserved) - sum(used) from sysindexes where indid in (0, 1, 255) ' + CHAR(13)


	SET @sql = @sql + 'Select	@DB_Size = ltrim(str((@dbsize + @logsize) / @pagesperMB,15,2)),  ' + CHAR(13)
	SET @sql = @sql + '			@DB_Data_Size = ltrim(str((@dbsize) / @pagesperMB,15,2)), '  + CHAR(13)
	SET @sql = @sql + '			@DB_Space_Available = ltrim(str((@dbsize - (select sum(convert(dec(15),reserved)) from sysindexes where indid in (0, 1, 255))) / @pagesperMB,15,2)), '  + CHAR(13)
	SET @sql = @sql + '			@Reserved = ltrim(str((@reserved*8)/1024)), '  + CHAR(13)
	SET @sql = @sql + '			@Data = ltrim(str(((@data1 + @data2)*8)/1024)), '  + CHAR(13)
	SET @sql = @sql + '			@Indexes = ltrim(str(((@indexp - (@data1+@data2))*8)/1024)), '  + CHAR(13)
	SET @sql = @sql + '			@Unused = ltrim(str((@unused*8)/1024)) '  + CHAR(13)

	SET @sql = @sql + 'Select   @DB_Log_Size = (@DB_Size - @DB_Data_Size) '  + CHAR(13)
	
	SET @sql = @sql + 'Insert Into INFRAERO..tb_usr_space_used Values (@databasename,@DB_Size,@DB_Data_Size,@DB_Log_Size,@DB_Space_Available,@Reserved,@Data,@Indexes,@Unused,getdate()) '  + CHAR(13)

	EXECUTE (@sql)
	--print @sql

	FETCH
	NEXT
	FROM _databases
	INTO
	@DATABASE
END
CLOSE _databases
DEALLOCATE _databases


SELECT Database_Name as 'Database Name', 
		   (convert(varchar(30), DB_Size) + ' MB') as 'DB Size',
		   (convert(varchar(30), DB_Data_Size) + ' MB') as 'DB Data Size',
		   (convert(varchar(30), (DB_Log_Size)) + ' MB') as 'DB Log Size',
		   (convert(varchar(30), DB_Space_Available) + ' MB') as 'DB Space Available',
		   (convert(varchar(30), Reserved) + ' MB') as 'Reserved' ,
		   (convert(varchar(30), Data) + ' MB') as 'Data',
		   (convert(varchar(30), Indexes) + ' MB') as 'Indexes' ,
		   (convert(varchar(30), Unused) + ' MB') as 'Unused',
			User_datetime as 'Data de Inserção'
FROM		INFRAERO..tb_usr_space_used (nolock)
Where		User_datetime > getdate()-1
ORDER BY	DB_Log_Size desc

/*

USE INFRAERO

/****** Object:  Table [dbo].[tb_usr_space_used]    Script Date: 03/06/2009 14:33:57 ******/
SET ANSI_NULLS ON

SET QUOTED_IDENTIFIER ON

SET ANSI_PADDING ON

DROP TABLE [dbo].[tb_usr_space_used]

CREATE TABLE [dbo].[tb_usr_space_used](
	[Database_Name] [varchar](30) NULL,
	[DB_Size] [numeric](20, 2) NULL,
	[DB_Data_Size] [numeric](20, 2) NULL,
	[DB_Log_Size] [numeric](20, 2) NULL,
	[DB_Space_Available] [numeric](20, 2) NULL,
	[Reserved] [numeric](20, 2) NULL,
	[Data] [numeric](20, 2) NULL,
	[Indexes] [numeric](20, 2) NULL,
	[Unused] [numeric](20, 2) NULL,
	[User_datetime] [datetime] NULL
) ON [PRIMARY]

SET ANSI_PADDING OFF


select count(1) from master..sysdatabases
*/