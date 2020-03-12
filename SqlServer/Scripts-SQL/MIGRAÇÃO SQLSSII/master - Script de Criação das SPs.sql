USE [master]
GO

/****** Object:  StoredProcedure [dbo].[gsp_allocated_space]    Script Date: 02/07/2011 12:48:24 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE procedure [dbo].[gsp_allocated_space] (@p_dbname varchar(50)) as
exec ('use ' + @p_dbname + ' 
begin try 
SELECT
 --(row_number() over(order by a3.name, a2.name))%2 as l1,
 a3.name AS [schemaname],
 count(a2.name ) as NumberOftables,
 sum(a1.rows) as row_count,
 sum((a1.reserved + ISNULL(a4.reserved,0))* 8) AS reserved, 
 sum(a1.data * 8) AS data,
 sum((CASE WHEN (a1.used + ISNULL(a4.used,0)) > a1.data THEN 
   (a1.used + ISNULL(a4.used,0)) - a1.data ELSE 0 END) * 8 )AS index_size,
 sum((CASE WHEN (a1.reserved + ISNULL(a4.reserved,0)) > a1.used THEN 
   (a1.reserved + ISNULL(a4.reserved,0)) - a1.used ELSE 0 END) * 8) AS unused
FROM
 (SELECT 
  ps.object_id,
  SUM (
   CASE
    WHEN (ps.index_id < 2) THEN row_count
    ELSE 0
   END
   ) AS [rows],
  SUM (ps.reserved_page_count) AS reserved,
  SUM (
   CASE
    WHEN (ps.index_id < 2) THEN 
     (ps.in_row_data_page_count + ps.lob_used_page_count + ps.row_overflow_used_page_count)
    ELSE (ps.lob_used_page_count + ps.row_overflow_used_page_count)
   END
   ) AS data,
  SUM (ps.used_page_count) AS used
 FROM sys.dm_db_partition_stats ps
 GROUP BY ps.object_id) AS a1
LEFT OUTER JOIN 
 (SELECT 
  it.parent_id,
  SUM(ps.reserved_page_count) AS reserved,
  SUM(ps.used_page_count) AS used
  FROM sys.dm_db_partition_stats ps
  INNER JOIN sys.internal_tables it ON (it.object_id = ps.object_id)
  WHERE it.internal_type IN (202,204)
  GROUP BY it.parent_id) AS a4 ON (a4.parent_id = a1.object_id)
INNER JOIN sys.all_objects a2  ON ( a1.object_id = a2.object_id ) 
INNER JOIN sys.schemas a3 ON (a2.schema_id = a3.schema_id)
WHERE a2.type <> ''S'' and a2.type <> ''IT''
group by a3.name 
ORDER BY a3.name
end try 
begin catch 
select 
 -100 as l1
, 1 as schemaname 
,       ERROR_NUMBER() as tablename
,       ERROR_SEVERITY() as row_count
,       ERROR_STATE() as reserved
,       ERROR_MESSAGE() as data
,       1 as index_size
,   1 as unused 
end catch
exec sp_helpdb ''' + @p_dbname + ''''
)


GO

/****** Object:  StoredProcedure [dbo].[gsp_allocated_space_detail]    Script Date: 02/07/2011 12:48:24 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

create procedure [dbo].[gsp_allocated_space_detail] (@p_dbname varchar(50)) as
exec ('use ' + @p_dbname + ' 
begin try 
SELECT
 (row_number() over(order by a3.name, a2.name))%2 as l1,
 a3.name AS [schemaname],
 a2.name AS [tablename],
 a1.rows as row_count,
 (a1.reserved + ISNULL(a4.reserved,0))* 8 AS reserved, 
 a1.data * 8 AS data,
 (CASE WHEN (a1.used + ISNULL(a4.used,0)) > a1.data THEN 
   (a1.used + ISNULL(a4.used,0)) - a1.data ELSE 0 END) * 8 AS index_size,
 (CASE WHEN (a1.reserved + ISNULL(a4.reserved,0)) > a1.used THEN 
   (a1.reserved + ISNULL(a4.reserved,0)) - a1.used ELSE 0 END) * 8 AS unused
FROM
 (SELECT 
  ps.object_id,
  SUM (
   CASE
    WHEN (ps.index_id < 2) THEN row_count
    ELSE 0
   END
   ) AS [rows],
  SUM (ps.reserved_page_count) AS reserved,
  SUM (
   CASE
     WHEN (ps.index_id < 2) THEN 
   (ps.in_row_data_page_count + ps.lob_used_page_count + ps.row_overflow_used_page_count)
     ELSE (ps.lob_used_page_count + ps.row_overflow_used_page_count)
   END
   ) AS data,
  SUM (ps.used_page_count) AS used
 FROM sys.dm_db_partition_stats ps
 GROUP BY ps.object_id) AS a1
LEFT OUTER JOIN 
 (SELECT 
  it.parent_id,
  SUM(ps.reserved_page_count) AS reserved,
  SUM(ps.used_page_count) AS used
  FROM sys.dm_db_partition_stats ps
  INNER JOIN sys.internal_tables it ON (it.object_id = ps.object_id)
  WHERE it.internal_type IN (202,204)
  GROUP BY it.parent_id) AS a4 ON (a4.parent_id = a1.object_id)
INNER JOIN sys.all_objects a2  ON ( a1.object_id = a2.object_id ) 
INNER JOIN sys.schemas a3 ON (a2.schema_id = a3.schema_id)
WHERE a2.type <> ''S'' and a2.type <> ''IT''
ORDER BY a3.name, a2.name
end try 
begin catch 
select 
 -100 as l1
, 1 as schemaname 
,       ERROR_NUMBER() as tablename
,       ERROR_SEVERITY() as row_count
,       ERROR_STATE() as reserved
,       ERROR_MESSAGE() as data
,       1 as index_size
,   1 as unused 
end catch
exec sp_helpdb ''' + @p_dbname + ''''
)
GO

/****** Object:  StoredProcedure [dbo].[gsp_allocated_space_ins]    Script Date: 02/07/2011 12:48:24 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE procedure [dbo].[gsp_allocated_space_ins] (@p_dbname varchar(50)) as
exec ('use ' + @p_dbname + ' 
set nocount on
DECLARE @schemaname varchar(50),
 @NumberOftables float,
 @row_count float,
 @reserved float, 
 @data float,
 @index_size float,
 @unused float
SELECT
 @schemaname = schemaname,
 @NumberOftables = NumberOftables,
 @row_count = row_count,
 @reserved  = reserved , 
 @data = data,
 @index_size = index_size,
 @unused = unused
FROM (
SELECT
 --(row_number() over(order by a3.name, a2.name))%2 as l1,
 a3.name AS [schemaname],
 count(a2.name ) as NumberOftables,
 sum(a1.rows) as row_count,
 sum((a1.reserved + ISNULL(a4.reserved,0))* 8) AS reserved, 
 sum(a1.data * 8) AS data,
 sum((CASE WHEN (a1.used + ISNULL(a4.used,0)) > a1.data THEN 
   (a1.used + ISNULL(a4.used,0)) - a1.data ELSE 0 END) * 8 )AS index_size,
 sum((CASE WHEN (a1.reserved + ISNULL(a4.reserved,0)) > a1.used THEN 
   (a1.reserved + ISNULL(a4.reserved,0)) - a1.used ELSE 0 END) * 8) AS unused
FROM
 (SELECT 
  ps.object_id,
  SUM (
   CASE
    WHEN (ps.index_id < 2) THEN row_count
    ELSE 0
   END
   ) AS [rows],
  SUM (ps.reserved_page_count) AS reserved,
  SUM (
   CASE
    WHEN (ps.index_id < 2) THEN 
     (ps.in_row_data_page_count + ps.lob_used_page_count + ps.row_overflow_used_page_count)
    ELSE (ps.lob_used_page_count + ps.row_overflow_used_page_count)
   END
   ) AS data,
  SUM (ps.used_page_count) AS used
 FROM sys.dm_db_partition_stats ps
 GROUP BY ps.object_id) AS a1
LEFT OUTER JOIN 
 (SELECT 
  it.parent_id,
  SUM(ps.reserved_page_count) AS reserved,
  SUM(ps.used_page_count) AS used
  FROM sys.dm_db_partition_stats ps
  INNER JOIN sys.internal_tables it ON (it.object_id = ps.object_id)
  WHERE it.internal_type IN (202,204)
  GROUP BY it.parent_id) AS a4 ON (a4.parent_id = a1.object_id)
INNER JOIN sys.all_objects a2  ON ( a1.object_id = a2.object_id ) 
INNER JOIN sys.schemas a3 ON (a2.schema_id = a3.schema_id)
WHERE a2.type <> ''S'' and a2.type <> ''IT''
group by a3.name) t


declare @log_size numeric(20,2),
        @idx_size  numeric(20,2),
		@data_size  numeric(20,2)

create table #temp (
name varchar(50),
fileid int,
filename varchar(300),
filegroup varchar(100),
size varchar(50),
maxsize varchar(50),
growth varchar(50),
usage varchar(50))

insert into #temp
exec sp_helpfile

select @log_size = sum(replace(size, ''KB'', '''')/1024)
from #temp
where filename like ''%ldf%''

select @idx_size = sum(replace(size, ''KB'', '''')/1024)
from #temp
where filename like ''%idx%''

select @data_size = sum(replace(size, ''KB'', '''')/1024)
from #temp
where (filename like ''%dat%'' or filename like ''%mdf%'')

drop table #temp

update [INFRAERO].[dbo].[tb_usr_space_used]
set		Data = @data/1024
,		Indexes = @index_size/1024
,		Log_Size_Aloc = @log_size
,		Data_Size_Aloc = @data_size
,		Idx_Size_Aloc = @idx_size
where	User_datetime > convert(varchar(8), getdate(), 112)
  AND   Database_Name = ''' +  @p_dbname + ''''
)


GO

/****** Object:  StoredProcedure [dbo].[procura_texto]    Script Date: 02/07/2011 12:48:24 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO





CREATE     procedure [dbo].[procura_texto] @procura varchar( 255 ), @base char( 255 ) = ''
as
set nocount on
create table #tmp ( tabela char( 255 ), base char( 255 ) )

declare @server  varchar( 255 )
declare @sql     varchar( 255 )

--set @procura = 'GEACrpt.dbo.fap_invoice_ctrl' 
--set @procura = 'usp_valida_data_contabil'

declare c insensitive cursor for 
select rtrim(ltrim(name)) from master..sysdatabases ( NOLOCK )

open c 
fetch next from c into @server

While @@fetch_status = 0
Begin
   
   set @sql = 'insert #tmp select name, '''+@server+''' from '+@server+'..sysobjects ( NOLOCK ) where id in ( select id from '+@server+'..syscomments ( NOLOCK ) where text like ''%'+@procura+ '%'' )'
   exec (@sql)
   fetch next from c into @server

End
Close c
Deallocate c

if @base = ''
   select cast(tabela as char( 255 )), base from #tmp ( NOLOCK ) order by base, tabela
else
   select cast(tabela as char( 255 )), base from #tmp ( NOLOCK ) where base = @base order by base, tabela
   

drop table #tmp

--select * from sysobjects ( NOLOCK ) where id in ( select id from syscomments ( NOLOCK ) where text like '%idx_doc_ap_ar%' )
set nocount off





GO

/****** Object:  StoredProcedure [dbo].[psp_sel_col_info_1]    Script Date: 02/07/2011 12:48:24 ******/
SET ANSI_NULLS OFF
GO

SET QUOTED_IDENTIFIER OFF
GO


CREATE procedure [dbo].[psp_sel_col_info_1]
(	@p_tbl_name	varchar(30) )
AS
declare	@colid 		smallint, 
  			@col_name 	varchar(30),
			@col_type 	tinyint, 
			@col_length tinyint,
			@key_flag 	tinyint

declare @object_id integer, @dbs_type smallint,
	@i smallint, 		/* Fix for defect 20000301080115 */
	@thiskey varchar(30),	/* Fix for defect 20000301080115 */
	@objname varchar(30)	/* Fix for defect 20000301080115 */

create table #tmp_col_info_1
(colid		smallint,
 col_name	varchar(30),
 col_type   tinyint,
 col_length tinyint,
 key_flag   tinyint
)

select	@object_id=id,@objname=name	/* Fix for defect 20000301080115 */ 	
from	sysobjects
where  (type = "U" or type = "V") and	
		 name = @p_tbl_name

select @colid=Min(colid)
from syscolumns
where id=@object_id

select @i = 1 /* Fix for defect 20000301080115 */

while @colid > 0
begin 
	select  @col_name=name, @col_type=usertype, @col_length=length	
	from syscolumns
	where id=@object_id and colid=@colid

/* Start fix for defect 20000301080115 */
	select @thiskey = index_col(@objname, 1, @i)
	if @thiskey is null
	begin 
		select @key_flag = 0
	end
	else
	begin
		select @key_flag = 1 
	end
/* End fix for defect 20000301080115 */

/* 
Start remove code for defect 20000301080115
	if exists (select *
				from syskeys
				where	(id = @object_id) and 
						(key1 = @colid or
						 key2 = @colid or
						 key3 = @colid or
						 key4 = @colid or
						 key5 = @colid or
						 key6 = @colid or
		 				 key7 = @colid or
		 				 key8 = @colid) ) 
	begin 
		select @key_flag = 1
	end
	else
	begin
		select @key_flag = 0 
	end

End remove code for defect 20000301080115
*/
	insert  into #tmp_col_info_1
	select  @colid, @col_name, @col_type, @col_length, @key_flag	

	select @colid=Min(colid)
	from syscolumns
	where id=@object_id and
			colid > @colid
	
	select @i = @i + 1	/* Fix for defect 20000301080115 */

end

select key_flag, col_name, col_type, col_length
from #tmp_col_info_1

drop table #tmp_col_info_1
 
GO

/****** Object:  StoredProcedure [dbo].[sp_BackupDiff]    Script Date: 02/07/2011 12:48:24 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


/*******************************************************************************************************
NOME: sp_BackupFull
DESCRIÇÃO: Gera o backup Full de uma base de dados informada e insere um registro na Tabela de Bancos de

********************************************************************************************************
*/

CREATE PROCEDURE [dbo].[sp_BackupDiff] 
   @Database sysname              -- Nome do Banco 
  ,@Path     VARCHAR(255)         -- Diretorio do Backup
  ,@Zip      varchar(5) = 'False' -- Informa se vai chamar rotina de compactação do backup
AS 
BEGIN
set nocount on 
SET XACT_ABORT ON 
DECLARE @BackupFile     varchar(255),
        @File           varchar(255),
        @DeviceBackup   varchar(300),
        @Hora           char(8),
        @NomeBancoDados varchar(50),
        @comando        varchar(8000),
--        @ZipFile        varchar(255),
        @erro           int    -- Utilizado para saber se a SP finalizou Ok ou Nao
 

   set @Hora = convert(char(8),getdate(),8)   -- 
   set @NomeBancoDados = convert(varchar(50),@Database)
   set @Path = 'G:\MSSQL\BACKUP\'
   
   -- Verifica se o Path esta ou nao com uma \

   if right(@Path,1) <>  '\'   -- Nao tem a \
      begin 
         set @Path = @Path + '\'   -- Adiicona a Barra Invertida
      end 

   set @File = @Database + '_db_diff_'+convert(varchar(10),Getdate(),112)+substring(@Hora,1,2)+substring(@Hora,4,2)+substring(@Hora,7,2)
   set @BackupFile = @File+'.BAK'
   set @DeviceBackup = @Path + @BackupFile

   -- Verifica se o banco existe  

   IF NOT EXISTS(SELECT name FROM master.sys.databases WHERE NAME = @Database)
      BEGIN 
		Raiserror('Atenção: O Banco de Dados informado não existe !!!',16,1)
		return 50000
      END

    BACKUP DATABASE @Database TO DISK = @DeviceBackup WITH DIFFERENTIAL, INIT, NAME = N'Backup Full',stats=10
     IF @@Error > 0   -- Erro no Backup
        begin 
           raiserror ('Erro na Geracao do Backup em Disco.',16,1)
           return 50000
        end 
	print @DeviceBackup
     
--	  -- Verifica se deseja compactar o Backup

--    if isnull(@Zip,'') = 'true'
--	   begin
--		  set @ZipFile = @Path + @File   
---- exec  master.dbo.xp_cmdshell 'WZZIP.EXE -M W:\BACKUP\LOG\BDSicoob0300\BDSICOOB0300_tlog_20031229190020  W:\BACKUP\LOG\BDSicoob0300\BDSICOOB0300_tlog_20031229190020.trn'
--          set @comando = 'exec  master.dbo.xp_cmdshell ''WZZIP.EXE -M '+@ZipFile+' '+@DeviceBackup+''',no_output'
--          exec (@comando)	
--  	   end

end
return 0



GO

/****** Object:  StoredProcedure [dbo].[sp_BackupFull]    Script Date: 02/07/2011 12:48:24 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

/*******************************************************************************************************
NOME: sp_BackupFull
DESCRIÇÃO: Gera o backup Full de uma base de dados informada e insere um registro na Tabela de Bancos de

********************************************************************************************************
*/

CREATE PROCEDURE [dbo].[sp_BackupFull] 
   @Database sysname              -- Nome do Banco 
  ,@Path     VARCHAR(255)         -- Diretorio do Backup
  ,@Zip      varchar(5) = 'False' -- Informa se vai chamar rotina de compactação do backup
AS 
BEGIN
set nocount on 
SET XACT_ABORT ON 
DECLARE @BackupFile     varchar(255),
        @File           varchar(255),
        @DeviceBackup   varchar(300),
        @Hora           char(8),
        @NomeBancoDados varchar(50),
        @comando        varchar(8000),
--        @ZipFile        varchar(255),
        @erro           int    -- Utilizado para saber se a SP finalizou Ok ou Nao
 

   set @Hora = convert(char(8),getdate(),8)   -- 
   set @NomeBancoDados = convert(varchar(50),@Database)
   set @Path = 'G:\MSSQL\BACKUP\'
   
   -- Verifica se o Path esta ou nao com uma \

   if right(@Path,1) <>  '\'   -- Nao tem a \
      begin 
         set @Path = @Path + '\'   -- Adiicona a Barra Invertida
      end 

   set @File = @Database + '_db_full_'+convert(varchar(10),Getdate(),112)+substring(@Hora,1,2)+substring(@Hora,4,2)+substring(@Hora,7,2)
   set @BackupFile = @File+'.BAK'
   set @DeviceBackup = @Path + @BackupFile

   -- Verifica se o banco existe  

   IF NOT EXISTS(SELECT name FROM master.sys.databases WHERE NAME = @Database)
      BEGIN 
		Raiserror('Atenção: O Banco de Dados informado não existe !!!',16,1)
		return 50000
      END

    BACKUP DATABASE @Database TO DISK = @DeviceBackup WITH INIT, NAME = N'Backup Full',stats=10
     IF @@Error > 0   -- Erro no Backup
        begin 
           raiserror ('Erro na Geracao do Backup em Disco.',16,1)
           return 50000
        end 
	print @DeviceBackup
     
--	  -- Verifica se deseja compactar o Backup

--    if isnull(@Zip,'') = 'true'
--	   begin
--		  set @ZipFile = @Path + @File   
---- exec  master.dbo.xp_cmdshell 'WZZIP.EXE -M W:\BACKUP\LOG\BDSicoob0300\BDSICOOB0300_tlog_20031229190020  W:\BACKUP\LOG\BDSicoob0300\BDSICOOB0300_tlog_20031229190020.trn'
--          set @comando = 'exec  master.dbo.xp_cmdshell ''WZZIP.EXE -M '+@ZipFile+' '+@DeviceBackup+''',no_output'
--          exec (@comando)	
--  	   end

end
return 0


GO

/****** Object:  StoredProcedure [dbo].[sp_DropTempTables]    Script Date: 02/07/2011 12:48:24 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[sp_DropTempTables] AS
DECLARE @Cursor AS CURSOR
DECLARE @Name AS VARCHAR(100)
DECLARE @TableName AS sysname
DECLARE @Owner AS VARCHAR(100)
DECLARE @SQL AS NVARCHAR(200)
SET @Cursor = CURSOR SCROLL FOR
SELECT tempdb.dbo.sysobjects.name, tempdb.dbo.sysobjects.*
FROM master.dbo.TempTableToKeep
RIGHT OUTER JOIN tempdb.dbo.sysobjects ON master.dbo.TempTableToKeep.TempTable = tempdb.dbo.sysobjects.name
WHERE ((tempdb.dbo.sysobjects.crdate < DATEADD(hh, -12, GETDATE())) AND (tempdb.dbo.sysobjects.type = 'U') AND (master.dbo.TempTableToKeep.DateToDelete < GETDATE())) OR
((tempdb.dbo.sysobjects.crdate < DATEADD(hh, -12, GETDATE())) AND (tempdb.dbo.sysobjects.type = 'U') AND (master.dbo.TempTableToKeep.DateToDelete IS NULL))
OPEN @Cursor
FETCH FIRST FROM @Cursor
INTO @Name, @Owner
WHILE (@@FETCH_STATUS = 0)
BEGIN
If (@@FETCH_STATUS = 0)
BEGIN
IF EXISTS(SELECT name FROM tempdb..sysobjects WHERE name = @Name AND type = 'U')
BEGIN
SET @SQL = 'DROP TABLE tempdb..' + @Name
PRINT @SQL
--EXECUTE sp_executesql @SQL
END
FETCH NEXT FROM @Cursor
INTO @Name
END
END
CLOSE @Cursor
DEALLOCATE @Cursor

GO

/****** Object:  StoredProcedure [dbo].[sp_activity]    Script Date: 02/07/2011 12:48:24 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[sp_activity] AS

/* SP_ACTIVITY 				*/
/* Author: Mitch van Huuksloot		*/
/* Date: April 30, 2001			*/

set nocount on

select 'Activity on' = convert(char(19), getdate(), 20), Server = @@SERVERNAME

/* temp tables to hold more-or-less consistent sysprocesses/syslockinfo snapshots */

create table #info
(
	spid smallint,
	cmd char(16),
	status char(10),
	blocked smallint,
	waittype binary(2),
	waittime int,
	lastwaittype char(20),
	waitresource char(25),
	dbname char(30),
	loginname char(25),
	hostname char(15),
	cpu int,
	physical_io int,
	[memusage] int,
	login_time char(19),
	last_batch char(19),
	open_tran smallint,
	net_address char(12),
	net_library char(12),	
)

create table #locks
(
	spid int,
	resource char(32),
	dbname char(30),
	indid smallint,
	indname char(30),
	objid integer,
	objectname char(30),
	typeid tinyint,
	type char(3),
	mode char(12),
	status char(10),
	refcnt smallint,
	ownertype char(12),
	transid bigint
)

/* capture sysprocesses */
insert into #info
	select	p.spid,
		convert(char(16), p.cmd), 
		convert(char(10), p.status),
		p.blocked,
		p.waittype,
		p.waittime,
		convert(char(20), p.lastwaittype),
		convert(char(25), p.waitresource),
		convert(char(30), d.name), 
		convert(char(25), p.loginame), 
		convert(char(15), p.hostname), 
		p.cpu,
		p.physical_io,
		p.memusage, 
		convert(char(19), p.login_time, 20),
		convert(char(19), p.last_batch, 20),
		p.open_tran,
		convert(char(12), p.net_address),
		convert(char(12), p.net_library)
	from  master.dbo.sysprocesses p (nolock), master.dbo.sysdatabases d (nolock)
	where p.dbid = d.dbid

/* capture syslockinfo */
insert into #locks
	select
		L.req_spid,
		convert(char(32), L.rsc_text),
		convert(char(30), d.name),
		L.rsc_indid,
		SPACE(30),
		L.rsc_objid,
		SPACE(30),
		L.rsc_type,
		convert(char(3), v.name),
		convert(char(12), v2.name),
		convert(CHAR(10), v3.name),
		L.req_refcnt smallint,
		case L.req_ownertype when 1 then 'Transaction' when 2 then 'Cursor' when 3 then 'Session' when 4 then 'ExSession' else cast(L.req_ownertype as char(12)) end,
		req_transactionID 
	from master..syslockinfo L (nolock), master..sysdatabases d (nolock), 
	     master..spt_values v (nolock),  master..spt_values v2 (nolock), master..spt_values v3 (nolock)
	where 	L.rsc_dbid = d.dbid and 
		L.rsc_type=v.number and v.type='LR' and 
		(L.req_mode+1)=v2.number and v2.type='L' and
		L.req_status=v3.number and v3.type='LS'

/* Show active processes from sysprocesses capture */

print ''
print 'Active SQL Server Processes'
print ''
select * from #info order by spid

/* Dump out block chain, if there is one */

declare @blkd int
select @blkd=count(spid) from #info where blocked = 0 and spid in (select distinct blocked from #info where blocked != 0)
if @blkd > 0
  begin
	print ''
	select 'SPIDs at the head of blocking chains'=spid from #info where blocked = 0 and spid in (select distinct blocked from #info where blocked != 0)
	print ''
  end

/* Dump inputbuffers for each blocking process */

declare @spid smallint, @spidch char(5), @msg varchar(100)

declare c1 cursor for select distinct blocked from #info where blocked > 0 FOR READ ONLY
open c1
fetch c1 into  @spid
while @@fetch_status >= 0
   begin
	select @spidch = convert(char(5), @spid)
	print ''
	select @msg = 'Blocking SPID ' + @spidch + ' input buffer capture'
	print ''
	print @msg
	select @msg = 'dbcc inputbuffer(' + @spidch + ')'
	execute(@msg)
	fetch c1 into  @spid
   end
deallocate c1

/* Dump inputbuffers for each blocked process */

declare c1 cursor for select spid from #info where blocked > 0 FOR READ ONLY
open c1
fetch c1 into  @spid
while @@fetch_status >= 0
   begin
	select @spidch = convert(char(5), @spid)
	print ''
	select @msg = 'Blocked SPID ' + @spidch + ' input buffer capture'
	print ''
	print @msg
	select @msg = 'dbcc inputbuffer(' + @spidch + ')'
	execute(@msg)
	fetch c1 into  @spid
   end
deallocate c1

drop table #info	-- we are finished with the sysprocesses capture

/* Update locks table with tablename, objectname, indexname from the appropriate database */

declare @dbname varchar(30),
	@objid int,
	@indid int,
	@idch varchar(20),
	@indch varchar(20),
	@objname varchar(30),
	@indexname varchar(30),
	@stmt varchar(500)

declare c2 cursor for select distinct dbname, objid, indid from #locks where typeid between 4 and 9 for read only
open c2
fetch c2 into  @dbname, @objid, @indid
while @@fetch_status >= 0
   begin
	select @idch=cast(@objid as varchar(20))
	select @indch=cast(@indid as varchar(20))
	if @indid <> 0
		select @stmt = 'update #locks set objectname = cast(o.name as char(30)), indname=cast(i.name as char(30)) from #locks l, ' +
       			@dbname + '..sysobjects o (nolock), ' + @dbname + '..sysindexes i (nolock) where l.dbname = ' + '''' + @dbname + '''' + 
			' and l.objid = ' + @idch + ' and l.indid = ' + @indch + ' and o.id = ' + @idch + ' and i.id = ' + @idch + ' and i.indid = ' + @indch
	else
		select @stmt = 'update #locks set objectname = cast(o.name as char(30)) from #locks l, ' +
       			@dbname + '..sysobjects o (nolock) where l.dbname = ' + '''' + @dbname + '''' + 
			' and l.objid = ' + @idch + ' and l.indid = ' + @indch + ' and o.id = ' + @idch
	execute(@stmt)
	fetch c2 into  @dbname, @objid, @indid
   end
deallocate c2

/* Show lock information from syslocks capture */

print ''
print 'Locks'
print ''

select spid, type, mode, status, [database]=dbname, [index]=indname, [object]=objectname, resource, ownertype, "trans #"=transid, refcnt
from #locks order by spid, dbname, object, indname, resource, type, mode, status

drop table #locks	-- drop syslockinfo capture

GO

/****** Object:  StoredProcedure [dbo].[sp_dbs_authenticate]    Script Date: 02/07/2011 12:48:24 ******/
SET ANSI_NULLS OFF
GO

SET QUOTED_IDENTIFIER OFF
GO


CREATE procedure [dbo].[sp_dbs_authenticate]
AS
/* Add host_name to the IN list to provide a host 
	   access to "update" stored procedures.
	   "MorLozma" is "NotFound" unscrambled. */

IF NOT EXISTS
	( select host_name() where host_name() IN ( 'DBSStream' ) )
begin
	IF NOT EXISTS 
	  ( Select 1  from master..sysprocesses WHERE sid = suser_sid() AND hostname = 'DBSStream' )
	begin
		if suser_sname() not in ( 'DBS', 'SS_INTEGRACAO', 'TECAPLUS', 'USR_VIAGENS', 'sa', 'AR_SISTEMA', 'AP_SISTEMA','USR_VIAGENSWEB', 'ADAILI', 'usr_idm', 'D_SEDE\I1248925')
		begin
			raiserror 50099 'DBS falha de autenticação.  Acesso negado a Stored Procedure.'
			return -100
		end
	end
end

 


GO

/****** Object:  StoredProcedure [dbo].[sp_dbs_calc_chgstamp]    Script Date: 02/07/2011 12:48:24 ******/
SET ANSI_NULLS OFF
GO

SET QUOTED_IDENTIFIER OFF
GO

CREATE procedure [dbo].[sp_dbs_calc_chgstamp]
(
        @p_old_chgstamp smallint,
        @p_new_chgstamp smallint OUTPUT
)
AS
        if @p_old_chgstamp < 32000
                select @p_new_chgstamp = ( @p_old_chgstamp + 1 )
        else
                select @p_new_chgstamp = 1
 
GO

/****** Object:  StoredProcedure [dbo].[sp_dbs_get_all_languages]    Script Date: 02/07/2011 12:48:24 ******/
SET ANSI_NULLS OFF
GO

SET QUOTED_IDENTIFIER OFF
GO


CREATE procedure [dbo].[sp_dbs_get_all_languages]
AS

select name from syslanguages

 
GO

/****** Object:  StoredProcedure [dbo].[sp_dbs_get_max_packetsize]    Script Date: 02/07/2011 12:48:24 ******/
SET ANSI_NULLS OFF
GO

SET QUOTED_IDENTIFIER OFF
GO



create procedure [dbo].[sp_dbs_get_max_packetsize]
as


/* -------------------------------------------------------------------- */
/* Select value for max packet size from syscurconfigs                  */
/* -------------------------------------------------------------------- */

select value 
  from syscurconfigs
 where config = 139

return

 
GO

/****** Object:  StoredProcedure [dbo].[sp_dbs_get_param_type]    Script Date: 02/07/2011 12:48:24 ******/
SET ANSI_NULLS OFF
GO

SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[sp_dbs_get_param_type]
(
	@procedure_name		varchar(36) = '%', 	/* name of stored procedure  */
	@procedure_owner 	varchar(32) = null,	/* owner of stored procedure */
	@procedure_qualifier	varchar(32) = null	/* name of current database  */
)
AS

declare @semi_pos		int
declare @group_no 		int
declare @full_proc_name 	varchar(70)
declare @proc_id 		int

if @procedure_qualifier is not null
begin
    if db_name() != @procedure_qualifier
    begin
        if @procedure_qualifier = ''
        begin
           select @procedure_name = ''
           select @procedure_owner = ''
        end
        else
           return
    end
end
        
select @semi_pos = charindex(';', @procedure_name)
if (@semi_pos > 0)
begin
    select @group_no = convert(int, substring(@procedure_name, @semi_pos + 1, 2))
    select @procedure_name = substring(@procedure_name,1, @semi_pos - 1 )
end
else
    select @group_no = 1

if @procedure_owner is null
    select @full_proc_name = @procedure_name
else
    select @full_proc_name = @procedure_owner + '.' +  @procedure_name


select @proc_id = object_id(@full_proc_name)

select 
	ORDINAL_POSITION = c.colid,
	TYPE_NAME  = t.name
from
	syscolumns c,
	sysobjects o,
	systypes t
where
	o.id = @proc_id
	and c.id = o.id
	and c.usertype = t.usertype
	and c.name like '%'
	and c.number = 1

order by 1

 
GO

/****** Object:  StoredProcedure [dbo].[sp_dbs_get_user_password]    Script Date: 02/07/2011 12:48:24 ******/
SET ANSI_NULLS OFF
GO

SET QUOTED_IDENTIFIER OFF
GO


CREATE procedure [dbo].[sp_dbs_get_user_password]
(
	@p_user				varchar(30)


)
AS
if exists (Select * from syslogins where name = @p_user )
				
	Select " "," ", password, @p_user 
	 from syslogins where name = @p_user 
else
	Select " "," ", " ", " "


 
GO

/****** Object:  StoredProcedure [dbo].[sp_dbs_getdate]    Script Date: 02/07/2011 12:48:24 ******/
SET ANSI_NULLS OFF
GO

SET QUOTED_IDENTIFIER OFF
GO


CREATE procedure [dbo].[sp_dbs_getdate]
AS
	Select getdate()
 
GO

/****** Object:  StoredProcedure [dbo].[sp_dbs_logon_user_exists]    Script Date: 02/07/2011 12:48:24 ******/
SET ANSI_NULLS OFF
GO

SET QUOTED_IDENTIFIER OFF
GO


CREATE procedure [dbo].[sp_dbs_logon_user_exists]
(
	@p_type_u_i             char(1),
	@p_user_group_i         char(30),
	@p_svr_save_i           char(30),
	@p_db_name1_i           char(30)

)
AS

DECLARE @w_default_lang         char(30)

	CREATE table #svr_db (
		svr_save                char(30),
		svr_exists              char(1),
		db_name                 char(30),
		db_exists               char(1), 
		default_language        char(30) )

if @p_type_u_i = "U"
begin
if exists (select name from master..syslogins where name = @p_user_group_i)
	begin
	insert #svr_db
	select  @p_svr_save_i,
		"Y",
		@p_db_name1_i,
		"",
		""
	end
else
	begin
	insert #svr_db
	select  @p_svr_save_i,
		"N",
		@p_db_name1_i,
		"",
		""
	end
end


if exists (select * from sysusers where name = 
		@p_user_group_i )
   begin
     update #svr_db
       set db_exists ='Y'
	 where  svr_save = @p_svr_save_i and    
		db_name = @p_db_name1_i
			
   end
else 
   begin
     update #svr_db
       set db_exists ='N'
	 where  svr_save = @p_svr_save_i and    
		db_name = @p_db_name1_i
			
   end

if @p_type_u_i = "G"
begin
  insert #svr_db
  select  @p_svr_save_i,
	  "N",
	  @p_db_name1_i,
	  "",
	  ""
end


if exists (select * from sysusers where name = 
		@p_user_group_i )
   begin
     update #svr_db
       set db_exists ='Y'
	 where  svr_save = @p_svr_save_i and    
		db_name = @p_db_name1_i
			
   end
else 
   begin
     update #svr_db
       set db_exists ='N'
	 where  svr_save = @p_svr_save_i and    
		db_name = @p_db_name1_i
			
   end

if exists (select name from master..syslogins where name = @p_user_group_i)
   begin
   select @w_default_lang = language
     from master..syslogins 
       where name = @p_user_group_i
   if @w_default_lang is not null
      update #svr_db
	set default_language = @w_default_lang
	  where svr_save = @p_svr_save_i
   else
      update #svr_db
	set default_language = "us_english"
	  where svr_save = @p_svr_save_i
   end

select * from #svr_db

 
GO

/****** Object:  StoredProcedure [dbo].[sp_dbs_pass_system_addpds]    Script Date: 02/07/2011 12:48:24 ******/
SET ANSI_NULLS OFF
GO

SET QUOTED_IDENTIFIER OFF
GO


CREATE procedure [dbo].[sp_dbs_pass_system_addpds]
(
        @P_COMP_DT           datetime,
        @P_NBR_PERIODS       smallint = 0,
        @P_PERIOD_CD         char(1),
        @P_NBR_TIMES         smallint = 1,
        @P_RTN_CODE            tinyint          output,
        @P_BEGIN_DT_OUT        char(8)          output,
        @P_END_DT_OUT          char(8)          output,
        @P_COMP_DT_DOW         tinyint          output,
        @P_BEGIN_DT_DOW        tinyint          output,
        @P_END_DT_DOW          tinyint          output,
        @P_NBR_DAYS            smallint         output
)
AS

DECLARE
        @w_begin_dt             datetime,
        @w_end_dt               datetime,
        @w_comp_dt_dow          tinyint,
        @w_begin_dt_dow         tinyint,
        @w_end_dt_dow           tinyint,
        @w_return_cd            tinyint,
        @w_begin_dt_out         char(8),
        @w_end_dt_out           char(8),
        @w_nbr_days             smallint,
        @w_times                smallint

                /*      Perform Edit Checks on input parms      */

if @P_COMP_DT is null
   begin
    select @P_RTN_CODE      = 2,
           @P_BEGIN_DT_OUT  = space(8),
           @P_END_DT_OUT    = space(8),
           @P_COMP_DT_DOW   = 0,
           @P_BEGIN_DT_DOW  = 0,
           @P_END_DT_DOW    = 0,
           @P_NBR_DAYS      = 0
        RETURN
   end

if @P_NBR_PERIODS is null
   begin
    select @P_RTN_CODE      = 3,
           @P_BEGIN_DT_OUT  = space(8),
           @P_END_DT_OUT    = space(8),
           @P_COMP_DT_DOW   = 0,
           @P_BEGIN_DT_DOW  = 0,
           @P_END_DT_DOW    = 0,
           @P_NBR_DAYS      = 0
 RETURN
   end

if not (@P_PERIOD_CD = "D" or
        @P_PERIOD_CD = "W" or
        @P_PERIOD_CD = "M" or
        @P_PERIOD_CD = "Q" or
        @P_PERIOD_CD = "Y")
   begin
    select @P_RTN_CODE      = 4,
           @P_BEGIN_DT_OUT  = space(8),
           @P_END_DT_OUT    = space(8),
           @P_COMP_DT_DOW   = 0,
           @P_BEGIN_DT_DOW  = 0,
           @P_END_DT_DOW    = 0,
           @P_NBR_DAYS      = 0
        RETURN
   end

                /*      Initialize variables      */

select @w_return_cd = 0,
       @w_times     = 0

                /*      Determine the begin and end dates     */

while @w_times < @P_NBR_TIMES

   begin
      select @w_times = @w_times + 1

      if @w_times > 1 select @P_COMP_DT = @w_end_dt

      select @w_begin_dt = @P_COMP_DT

      if @P_PERIOD_CD = "D"
         select @w_end_dt   = dateadd(dd,@P_NBR_PERIODS,@P_COMP_DT)
      if @P_PERIOD_CD = "W"
         select @w_end_dt   = dateadd(wk,@P_NBR_PERIODS,@P_COMP_DT)
      if @P_PERIOD_CD = "M"
         select @w_end_dt   = dateadd(mm,@P_NBR_PERIODS,@P_COMP_DT)
      if @P_PERIOD_CD = "Q"
         select @w_end_dt   = dateadd(qq,@P_NBR_PERIODS,@P_COMP_DT)
      if @P_PERIOD_CD = "Y"
         select @w_end_dt   = dateadd(yy,@P_NBR_PERIODS,@P_COMP_DT)

      select    @w_nbr_days     = datediff(dd,@w_begin_dt,@w_end_dt),
                @w_begin_dt_out = convert(char(8),@P_COMP_DT,112),
                @w_end_dt_out   = convert(char(8),@w_end_dt,112),
                @w_comp_dt_dow  = datepart(weekday,@P_COMP_DT),
                @w_begin_dt_dow = datepart(weekday,@w_begin_dt),
                @w_end_dt_dow   = datepart(weekday,@w_end_dt)

select  @P_RTN_CODE      = @w_return_cd
select  @P_BEGIN_DT_OUT  = @w_begin_dt_out
select  @P_END_DT_OUT    = @w_end_dt_out
select  @P_COMP_DT_DOW   = @w_comp_dt_dow
select  @P_BEGIN_DT_DOW  = @w_begin_dt_dow
select  @P_END_DT_DOW    = @w_end_dt_dow
select  @P_NBR_DAYS      = @w_nbr_days

end

 
GO

/****** Object:  StoredProcedure [dbo].[sp_dbs_pass_system_dt2pd]    Script Date: 02/07/2011 12:48:24 ******/
SET ANSI_NULLS OFF
GO

SET QUOTED_IDENTIFIER OFF
GO


CREATE procedure [dbo].[sp_dbs_pass_system_dt2pd]
(
        @P_COMP_DT           datetime,
        @P_PERIOD_CD         char(1),
        @P_RTN_CODE            tinyint          output,
        @P_BEGIN_DT_OUT        char(8)          output,
        @P_END_DT_OUT          char(8)          output,
        @P_COMP_DT_DOW         tinyint          output,
        @P_BEGIN_DT_DOW        tinyint          output,
        @P_END_DT_DOW          tinyint          output,
        @P_NBR_DAYS            smallint         output
)
AS

DECLARE
        @w_begin_dt             datetime,
        @w_end_dt               datetime,
        @w_nbr_periods          smallint,
        @w_comp_dt_dow          tinyint,
        @w_begin_dt_dow         tinyint,
        @w_end_dt_dow           tinyint,
        @w_return_cd            tinyint,
        @w_q_month              char(2),
        @w_begin_dt_out         char(8),
        @w_end_dt_out           char(8),
        @w_temp                 tinyint,
        @w_temp1                char(1),
        @w_nbr_days             smallint

                /*      Perform Edit Checks on input parms      */

if @P_COMP_DT is null
   begin
    select @P_RTN_CODE      = 2,
           @P_BEGIN_DT_OUT  = space(8),
           @P_END_DT_OUT    = space(8),
           @P_COMP_DT_DOW   = 0,
           @P_BEGIN_DT_DOW  = 0,
           @P_END_DT_DOW    = 0,
           @P_NBR_DAYS      = 0
        RETURN
   end

if not (@P_PERIOD_CD = "D" or
        @P_PERIOD_CD = "W" or
        @P_PERIOD_CD = "M" or
        @P_PERIOD_CD = "Q" or
        @P_PERIOD_CD = "Y")
   begin
    select @P_RTN_CODE      = 4,
           @P_BEGIN_DT_OUT  = space(8),
           @P_END_DT_OUT    = space(8),
           @P_COMP_DT_DOW   = 0,
           @P_BEGIN_DT_DOW  = 0,
           @P_END_DT_DOW    = 0,
           @P_NBR_DAYS      = 0
        RETURN
   end

                /*      Initialize variables      */

select @w_return_cd      = 0,
       @w_temp1          = null,
       @w_nbr_periods    = 0

        /*    Calculate the beginning and ending dates for the period */

if @P_PERIOD_CD = "D"
begin
        select  @w_begin_dt = @P_COMP_DT,
                @w_end_dt   = @P_COMP_DT
end

if @P_PERIOD_CD = "W"
begin
        select @w_comp_dt_dow = datepart(weekday,@P_COMP_DT)
        if @w_comp_dt_dow >= @w_nbr_periods
                select @w_begin_dt = dateadd(dy, @w_nbr_periods - @w_comp_dt_dow, @P_COMP_DT)
        else
                select @w_begin_dt = dateadd(dy,@w_nbr_periods - @w_comp_dt_dow - 7, @P_COMP_DT)

        select @w_end_dt = dateadd(dy,6,@w_begin_dt)
end

if @P_PERIOD_CD = "M"
begin
        select @w_temp = datepart(mm,@P_COMP_DT)
        if @w_temp < 10
                select @w_temp1 = "0"
        select @w_begin_dt_out = convert(char(4),datepart(yy,@P_COMP_DT)) +
                                @w_temp1 +
                                rtrim(convert(char(2),@w_temp)) + "01"
        select @w_begin_dt = @w_begin_dt_out
        select @w_end_dt = dateadd(dd,-1,dateadd(mm,1,@w_begin_dt))
end

if @P_PERIOD_CD = "Q"
begin
        select  @w_temp = datepart(mm,@P_COMP_DT),
                @w_q_month = "01"

        if @w_temp > 3
                select @w_q_month = "04"
        if @w_temp > 6
                select @w_q_month = "07"
        if @w_temp > 9
                select @w_q_month = "10"

        select @w_begin_dt_out = convert(char(4),datepart(yy,@P_COMP_DT)) +
                                @w_q_month + "01"
        select @w_begin_dt = @w_begin_dt_out
        select @w_end_dt = dateadd(dd,-1,dateadd(qq,1,@w_begin_dt))
end

if @P_PERIOD_CD = "Y"
begin
        select @w_begin_dt_out = convert(char(4),datepart(yy,@P_COMP_DT)) +
                                "0101"
        select @w_begin_dt = @w_begin_dt_out
        select @w_end_dt = dateadd(dd,-1,dateadd(yy,1,@w_begin_dt))
end

select  @w_nbr_days     = datediff(dd,@w_begin_dt,@w_end_dt) + 1,
        @w_begin_dt_out = convert(char(8),@w_begin_dt,112),
        @w_end_dt_out   = convert(char(8),@w_end_dt,112),
        @w_begin_dt_dow = datepart(weekday,@w_begin_dt),
        @w_end_dt_dow   = datepart(weekday,@w_end_dt),
        @w_comp_dt_dow   = datepart(weekday,@P_COMP_DT)

select  @P_RTN_CODE      = @w_return_cd
select  @P_BEGIN_DT_OUT  = @w_begin_dt_out
select  @P_END_DT_OUT    = @w_end_dt_out
select  @P_COMP_DT_DOW   = @w_comp_dt_dow
select  @P_BEGIN_DT_DOW  = @w_begin_dt_dow
select  @P_END_DT_DOW    = @w_end_dt_dow
select  @P_NBR_DAYS      = @w_nbr_days

 
GO

/****** Object:  StoredProcedure [dbo].[sp_dbs_pass_system_dts2pds]    Script Date: 02/07/2011 12:48:24 ******/
SET ANSI_NULLS OFF
GO

SET QUOTED_IDENTIFIER OFF
GO


CREATE procedure [dbo].[sp_dbs_pass_system_dts2pds]
(
        @P_PERIOD_CD         char(1),
        @P_BEGIN_DT          datetime,
        @P_END_DT            datetime,
        @P_RTN_CODE            tinyint          output,
        @P_BEGIN_DT_OUT        char(8)          output,
        @P_END_DT_OUT          char(8)          output,
        @P_COMP_DT_DOW         tinyint          output,
        @P_BEGIN_DT_DOW        tinyint          output,
        @P_END_DT_DOW          tinyint          output,
        @P_NBR_DAYS            smallint         output
)
AS

DECLARE
        @w_comp_dt_dow          tinyint,
        @w_begin_dt_dow         tinyint,
        @w_end_dt_dow           tinyint,
        @w_return_cd            tinyint,
        @w_begin_dt_out         char(8),
        @w_end_dt_out           char(8),
        @w_temp_dt1             datetime,
        @w_nbr_days             smallint,
        @w_counter              smallint

                /*      Perform Edit Checks on input parms      */

if not (@P_PERIOD_CD = "D" or
        @P_PERIOD_CD = "W" or
        @P_PERIOD_CD = "M" or
        @P_PERIOD_CD = "Q" or
        @P_PERIOD_CD = "Y")
   begin
    select @P_RTN_CODE      = 4,
           @P_BEGIN_DT_OUT  = space(8),
           @P_END_DT_OUT    = space(8),
           @P_COMP_DT_DOW   = 0,
           @P_BEGIN_DT_DOW  = 0,
           @P_END_DT_DOW    = 0,
           @P_NBR_DAYS      = 0
        RETURN
   end

if @P_BEGIN_DT is null
   begin
    select @P_RTN_CODE      = 5,
           @P_BEGIN_DT_OUT  = space(8),
           @P_END_DT_OUT    = space(8),
           @P_COMP_DT_DOW   = 0,
           @P_BEGIN_DT_DOW  = 0,
           @P_END_DT_DOW    = 0,
           @P_NBR_DAYS      = 0
        RETURN
   end

if @P_END_DT is null
   begin
    select @P_RTN_CODE      = 6,
           @P_BEGIN_DT_OUT  = space(8),
           @P_END_DT_OUT    = space(8),
           @P_COMP_DT_DOW   = 0,
           @P_BEGIN_DT_DOW  = 0,
           @P_END_DT_DOW    = 0,
           @P_NBR_DAYS      = 0
        RETURN
   end

if @P_END_DT < @P_BEGIN_DT
   begin
    select @P_RTN_CODE      = 7,
           @P_BEGIN_DT_OUT  = space(8),
           @P_END_DT_OUT    = space(8),
           @P_COMP_DT_DOW   = 0,
           @P_BEGIN_DT_DOW  = 0,
           @P_END_DT_DOW    = 0,
           @P_NBR_DAYS      = 0
        RETURN
   end

                /*      Initialize variables      */

select @w_counter        = 0,
       @w_return_cd      = 0,
       @w_comp_dt_dow    = 0



                /*   Keep adding periods until the end dt is reached.
                     Count the number of periods while doing so.      */

select @w_temp_dt1 = @P_BEGIN_DT

if  @P_PERIOD_CD = "D"
        select @w_counter = datediff(dy,@P_BEGIN_DT,@P_END_DT) + 1

while   @w_temp_dt1 <= @P_END_DT and  @P_PERIOD_CD != "D"
begin
        select @w_counter = @w_counter + 1
        if  @P_PERIOD_CD = "W"
                select @w_temp_dt1 = dateadd(wk,@w_counter,@P_BEGIN_DT)
        if  @P_PERIOD_CD = "M"
                select @w_temp_dt1 = dateadd(mm,@w_counter,@P_BEGIN_DT)
        if @P_PERIOD_CD = "Q"
                select @w_temp_dt1 = dateadd(qq,@w_counter,@P_BEGIN_DT)
        if  @P_PERIOD_CD = "Y"
                select @w_temp_dt1 = dateadd(yy,@w_counter,@P_BEGIN_DT)
end  /* while */

select  @w_nbr_days     = @w_counter,
        @w_begin_dt_out = convert(char(8),@P_BEGIN_DT,112),
        @w_end_dt_out   = convert(char(8),@P_END_DT,112),
        @w_begin_dt_dow = datepart(weekday,@P_BEGIN_DT),
        @w_end_dt_dow   = datepart(weekday,@P_END_DT)

select  @P_RTN_CODE      = @w_return_cd
select  @P_BEGIN_DT_OUT  = @w_begin_dt_out
select  @P_END_DT_OUT    = @w_end_dt_out
select  @P_COMP_DT_DOW   = @w_comp_dt_dow
select  @P_BEGIN_DT_DOW  = @w_begin_dt_dow
select  @P_END_DT_DOW    = @w_end_dt_dow
select  @P_NBR_DAYS      = @w_nbr_days

 
GO

/****** Object:  StoredProcedure [dbo].[sp_dbs_pass_system_subpds]    Script Date: 02/07/2011 12:48:25 ******/
SET ANSI_NULLS OFF
GO

SET QUOTED_IDENTIFIER OFF
GO


CREATE procedure [dbo].[sp_dbs_pass_system_subpds]
(
        @P_COMP_DT           datetime,
        @P_NBR_PERIODS       smallint = 0,
        @P_PERIOD_CD         char(1),
        @P_RTN_CODE            tinyint          output,
        @P_BEGIN_DT_OUT        char(8)          output,
        @P_END_DT_OUT          char(8)          output,
        @P_COMP_DT_DOW         tinyint          output,
        @P_BEGIN_DT_DOW        tinyint          output,
        @P_END_DT_DOW          tinyint          output,
        @P_NBR_DAYS            smallint         output

)
AS

DECLARE
        @w_begin_dt             datetime,
        @w_end_dt               datetime,
        @w_comp_dt_dow          tinyint,
        @w_begin_dt_dow         tinyint,
        @w_end_dt_dow           tinyint,
        @w_return_cd            tinyint,
        @w_begin_dt_out         char(8),
        @w_end_dt_out           char(8),
        @w_nbr_days             smallint

                /*      Perform Edit Checks on input parms      */

if @P_COMP_DT is null
   begin
    select @P_RTN_CODE      = 2,
           @P_BEGIN_DT_OUT  = space(8),
           @P_END_DT_OUT    = space(8),
           @P_COMP_DT_DOW   = 0,
           @P_BEGIN_DT_DOW  = 0,
           @P_END_DT_DOW    = 0,
           @P_NBR_DAYS      = 0
        RETURN
   end

if @P_NBR_PERIODS is null
   begin
    select @P_RTN_CODE      = 3,
           @P_BEGIN_DT_OUT  = space(8),
           @P_END_DT_OUT    = space(8),
           @P_COMP_DT_DOW   = 0,
           @P_BEGIN_DT_DOW  = 0,
           @P_END_DT_DOW    = 0,
           @P_NBR_DAYS      = 0
 RETURN
   end

if not (@P_PERIOD_CD = "D" or
        @P_PERIOD_CD = "W" or
        @P_PERIOD_CD = "M" or
        @P_PERIOD_CD = "Q" or
        @P_PERIOD_CD = "Y")
   begin
    select @P_RTN_CODE      = 4,
           @P_BEGIN_DT_OUT  = space(8),
           @P_END_DT_OUT    = space(8),
           @P_COMP_DT_DOW   = 0,
           @P_BEGIN_DT_DOW  = 0,
           @P_END_DT_DOW    = 0,
           @P_NBR_DAYS      = 0
        RETURN
   end

                /*      Initialize variables      */

select @w_return_cd = 0

                /*      Determine the begin and end dates     */

select @w_end_dt = @P_COMP_DT

select @P_NBR_PERIODS = @P_NBR_PERIODS * -1
if @P_PERIOD_CD = "D"
   select @w_begin_dt   = dateadd(dd,@P_NBR_PERIODS,@P_COMP_DT)
if @P_PERIOD_CD = "W"
   select @w_begin_dt   = dateadd(wk,@P_NBR_PERIODS,@P_COMP_DT)
if @P_PERIOD_CD = "M"
   select @w_begin_dt   = dateadd(mm,@P_NBR_PERIODS,@P_COMP_DT)
if @P_PERIOD_CD = "Q"
   select @w_begin_dt   = dateadd(qq,@P_NBR_PERIODS,@P_COMP_DT)
if @P_PERIOD_CD = "Y"
   select @w_begin_dt   = dateadd(yy,@P_NBR_PERIODS,@P_COMP_DT)

select  @w_nbr_days     = datediff(dd,@w_begin_dt,@w_end_dt),
        @w_begin_dt_out = convert(char(8),@w_begin_dt,112),
        @w_end_dt_out   = convert(char(8),@w_end_dt,112),
        @w_comp_dt_dow  = datepart(weekday,@P_COMP_DT),
        @w_begin_dt_dow = datepart(weekday,@w_begin_dt),
        @w_end_dt_dow   = datepart(weekday,@w_end_dt)

select  @P_RTN_CODE      = @w_return_cd
select  @P_BEGIN_DT_OUT  = @w_begin_dt_out
select  @P_END_DT_OUT    = @w_end_dt_out
select  @P_COMP_DT_DOW   = @w_comp_dt_dow
select  @P_BEGIN_DT_DOW  = @w_begin_dt_dow
select  @P_END_DT_DOW    = @w_end_dt_dow
select  @P_NBR_DAYS      = @w_nbr_days

 
GO

/****** Object:  StoredProcedure [dbo].[sp_dbs_psp_browse_piq_sps]    Script Date: 02/07/2011 12:48:25 ******/
SET ANSI_NULLS OFF
GO

SET QUOTED_IDENTIFIER OFF
GO


CREATE procedure [dbo].[sp_dbs_psp_browse_piq_sps]
(
  @p_like_value                 varchar(40),
  @p_col_no                     tinyint,
  @p_oper_no                    tinyint,
  @p_last_value                 varchar(40) = ''
)
AS
SET rowcount 50

SELECT name
  from sysobjects
 where type = "P"
   and    name like @p_like_value
   and    name > @p_last_value
 order by name
 
GO

/****** Object:  StoredProcedure [dbo].[sp_dbs_psp_browse_piq_tables]    Script Date: 02/07/2011 12:48:25 ******/
SET ANSI_NULLS OFF
GO

SET QUOTED_IDENTIFIER OFF
GO


CREATE procedure [dbo].[sp_dbs_psp_browse_piq_tables]
(
  @p_like_value                 varchar(40),
  @p_col_no                     tinyint,
  @p_oper_no                    tinyint,
  @p_last_value                 varchar(40) = ''
)
AS
SET rowcount 50

SELECT name
from sysobjects
    where   type = "U"
     and    name like @p_like_value
     and    name > @p_last_value
    order by name

 
GO

/****** Object:  StoredProcedure [dbo].[sp_dbs_sel_day_time]    Script Date: 02/07/2011 12:48:25 ******/
SET ANSI_NULLS OFF
GO

SET QUOTED_IDENTIFIER OFF
GO


CREATE procedure [dbo].[sp_dbs_sel_day_time]
AS

DECLARE @w_datetime datetime
SELECT @w_datetime = getdate()
SELECT datepart(weekday,@w_datetime), @w_datetime
 
GO

/****** Object:  StoredProcedure [dbo].[sp_dbs_sel_db_names]    Script Date: 02/07/2011 12:48:25 ******/
SET ANSI_NULLS OFF
GO

SET QUOTED_IDENTIFIER OFF
GO

CREATE procedure [dbo].[sp_dbs_sel_db_names]
AS
	select name from master.dbo.sysdatabases
	 order by name
 
GO

/****** Object:  StoredProcedure [dbo].[sp_dbs_sel_physical_srvnames]    Script Date: 02/07/2011 12:48:25 ******/
SET ANSI_NULLS OFF
GO

SET QUOTED_IDENTIFIER OFF
GO

CREATE procedure [dbo].[sp_dbs_sel_physical_srvnames]
AS
	SELECT	srvname from sysservers
	 where	srvname = srvnetname
	 order by srvname
 
GO

/****** Object:  StoredProcedure [dbo].[sp_dbs_sel_sp_names]    Script Date: 02/07/2011 12:48:25 ******/
SET ANSI_NULLS OFF
GO

SET QUOTED_IDENTIFIER OFF
GO

CREATE procedure [dbo].[sp_dbs_sel_sp_names]
AS
	select name from sysobjects where type = "P"
	 order by name
 
GO

/****** Object:  StoredProcedure [dbo].[sp_dbs_sel_system_addpds]    Script Date: 02/07/2011 12:48:25 ******/
SET ANSI_NULLS OFF
GO

SET QUOTED_IDENTIFIER OFF
GO


CREATE procedure [dbo].[sp_dbs_sel_system_addpds]
(
        @P_COMP_DT           datetime,
        @P_NBR_PERIODS       smallint = 0,
        @P_PERIOD_CD         char(1),
        @P_NBR_TIMES         smallint = 1
)
AS

DECLARE
        @w_begin_dt             datetime,
        @w_end_dt               datetime,
        @w_comp_dt_dow          tinyint,
        @w_begin_dt_dow         tinyint,
        @w_end_dt_dow           tinyint,
        @w_return_cd            tinyint,
        @w_begin_dt_out         char(8),
        @w_end_dt_out           char(8),
        @w_nbr_days             smallint,
        @w_times                smallint

                /*      Perform Edit Checks on input parms      */

if @P_COMP_DT is null
   begin
    select 2, space(8), space(8), 0, 0, 0, 0
        RETURN
   end

if @P_NBR_PERIODS is null
   begin
    select 3, space(8), space(8), 0, 0, 0, 0
 RETURN
   end

if not (@P_PERIOD_CD = "D" or
        @P_PERIOD_CD = "W" or
        @P_PERIOD_CD = "M" or
        @P_PERIOD_CD = "Q" or
        @P_PERIOD_CD = "Y")
   begin
    select 4, space(8), space(8), 0, 0, 0, 0
        RETURN
   end

                /*      Initialize variables      */

select @w_return_cd = 0,
       @w_times     = 0

                /*      Determine the begin and end dates     */

while @w_times < @P_NBR_TIMES

   begin
      select @w_times = @w_times + 1

      if @w_times > 1 select @P_COMP_DT = @w_end_dt

      select @w_begin_dt = @P_COMP_DT

      if @P_PERIOD_CD = "D"
         select @w_end_dt   = dateadd(dd,@P_NBR_PERIODS,@P_COMP_DT)
      if @P_PERIOD_CD = "W"
         select @w_end_dt   = dateadd(wk,@P_NBR_PERIODS,@P_COMP_DT)
      if @P_PERIOD_CD = "M"
         select @w_end_dt   = dateadd(mm,@P_NBR_PERIODS,@P_COMP_DT)
      if @P_PERIOD_CD = "Q"
         select @w_end_dt   = dateadd(qq,@P_NBR_PERIODS,@P_COMP_DT)
      if @P_PERIOD_CD = "Y"
         select @w_end_dt   = dateadd(yy,@P_NBR_PERIODS,@P_COMP_DT)

      select    @w_nbr_days     = datediff(dd,@w_begin_dt,@w_end_dt),
                @w_begin_dt_out = convert(char(8),@P_COMP_DT,112),
                @w_end_dt_out   = convert(char(8),@w_end_dt,112),
                @w_comp_dt_dow  = datepart(weekday,@P_COMP_DT),
                @w_begin_dt_dow = datepart(weekday,@w_begin_dt),
                @w_end_dt_dow   = datepart(weekday,@w_end_dt)

      select @w_return_cd, @w_begin_dt_out, @w_end_dt_out,
        @w_comp_dt_dow, @w_begin_dt_dow, @w_end_dt_dow, @w_nbr_days
end

 
GO

/****** Object:  StoredProcedure [dbo].[sp_dbs_sel_system_dt2pd]    Script Date: 02/07/2011 12:48:25 ******/
SET ANSI_NULLS OFF
GO

SET QUOTED_IDENTIFIER OFF
GO


CREATE procedure [dbo].[sp_dbs_sel_system_dt2pd]
(
        @P_COMP_DT           datetime,
        @P_PERIOD_CD         char(1)
)
AS

DECLARE
        @w_begin_dt             datetime,
        @w_end_dt               datetime,
        @w_nbr_periods          smallint,
        @w_comp_dt_dow          tinyint,
        @w_begin_dt_dow         tinyint,
        @w_end_dt_dow           tinyint,
        @w_return_cd            tinyint,
        @w_q_month              char(2),
        @w_begin_dt_out         char(8),
        @w_end_dt_out           char(8),
        @w_temp                 tinyint,
        @w_temp1                char(1),
        @w_nbr_days             smallint

                /*      Perform Edit Checks on input parms      */

if @P_COMP_DT is null
   begin
    select 2, space(8), space(8), 0, 0, 0, 0
        RETURN
   end

if not (@P_PERIOD_CD = "D" or
        @P_PERIOD_CD = "W" or
        @P_PERIOD_CD = "M" or
        @P_PERIOD_CD = "Q" or
        @P_PERIOD_CD = "Y")
   begin
    select 4, space(8), space(8), 0, 0, 0, 0
        RETURN
   end

                /*      Initialize variables      */

select @w_return_cd      = 0,
       @w_temp1          = null,
       @w_nbr_periods    = 0

        /*    Calculate the beginning and ending dates for the period */

if @P_PERIOD_CD = "D"
begin
        select  @w_begin_dt = @P_COMP_DT,
                @w_end_dt   = @P_COMP_DT
end

if @P_PERIOD_CD = "W"
begin
        select @w_comp_dt_dow = datepart(weekday,@P_COMP_DT)
        if @w_comp_dt_dow >= @w_nbr_periods
                select @w_begin_dt = dateadd(dy, @w_nbr_periods - @w_comp_dt_dow, @P_COMP_DT)
        else
                select @w_begin_dt = dateadd(dy,@w_nbr_periods - @w_comp_dt_dow - 7, @P_COMP_DT)

        select @w_end_dt = dateadd(dy,6,@w_begin_dt)
end

if @P_PERIOD_CD = "M"
begin
        select @w_temp = datepart(mm,@P_COMP_DT)
        if @w_temp < 10
                select @w_temp1 = "0"
        select @w_begin_dt_out = convert(char(4),datepart(yy,@P_COMP_DT)) +
                                @w_temp1 +
                                rtrim(convert(char(2),@w_temp)) + "01"
        select @w_begin_dt = @w_begin_dt_out
        select @w_end_dt = dateadd(dd,-1,dateadd(mm,1,@w_begin_dt))
end

if @P_PERIOD_CD = "Q"
begin
        select  @w_temp = datepart(mm,@P_COMP_DT),
                @w_q_month = "01"

        if @w_temp > 3
                select @w_q_month = "04"
        if @w_temp > 6
                select @w_q_month = "07"
        if @w_temp > 9
                select @w_q_month = "10"

        select @w_begin_dt_out = convert(char(4),datepart(yy,@P_COMP_DT)) +
                                @w_q_month + "01"
        select @w_begin_dt = @w_begin_dt_out
        select @w_end_dt = dateadd(dd,-1,dateadd(qq,1,@w_begin_dt))
end

if @P_PERIOD_CD = "Y"
begin
        select @w_begin_dt_out = convert(char(4),datepart(yy,@P_COMP_DT)) +
                                "0101"
        select @w_begin_dt = @w_begin_dt_out
        select @w_end_dt = dateadd(dd,-1,dateadd(yy,1,@w_begin_dt))
end

select  @w_nbr_days     = datediff(dd,@w_begin_dt,@w_end_dt) + 1,
        @w_begin_dt_out = convert(char(8),@w_begin_dt,112),
        @w_end_dt_out   = convert(char(8),@w_end_dt,112),
        @w_begin_dt_dow = datepart(weekday,@w_begin_dt),
        @w_end_dt_dow   = datepart(weekday,@w_end_dt),
        @w_comp_dt_dow   = datepart(weekday,@P_COMP_DT)

select @w_return_cd, @w_begin_dt_out, @w_end_dt_out,
       @w_comp_dt_dow, @w_begin_dt_dow, @w_end_dt_dow, @w_nbr_days

 
GO

/****** Object:  StoredProcedure [dbo].[sp_dbs_sel_system_dts2pds]    Script Date: 02/07/2011 12:48:25 ******/
SET ANSI_NULLS OFF
GO

SET QUOTED_IDENTIFIER OFF
GO


CREATE procedure [dbo].[sp_dbs_sel_system_dts2pds]
(
        @P_PERIOD_CD         char(1),
        @P_BEGIN_DT          datetime,
        @P_END_DT            datetime
)
AS

DECLARE
        @w_comp_dt_dow          tinyint,
        @w_begin_dt_dow         tinyint,
        @w_end_dt_dow           tinyint,
        @w_return_cd            tinyint,
        @w_begin_dt_out         char(8),
        @w_end_dt_out           char(8),
        @w_temp_dt1             datetime,
        @w_nbr_days             smallint,
        @w_counter              smallint

                /*      Perform Edit Checks on input parms      */

if not (@P_PERIOD_CD = "D" or
        @P_PERIOD_CD = "W" or
        @P_PERIOD_CD = "M" or
        @P_PERIOD_CD = "Q" or
        @P_PERIOD_CD = "Y")
   begin
    select 4, space(8), space(8), 0, 0, 0, 0
        RETURN
   end

if @P_BEGIN_DT is null
   begin
    select 5, space(8), space(8), 0, 0, 0, 0
        RETURN
   end

if @P_END_DT is null
   begin
    select 6, space(8), space(8), 0, 0, 0, 0
        RETURN
   end

if @P_END_DT < @P_BEGIN_DT
   begin
    select 7, space(8), space(8), 0, 0, 0, 0
        RETURN
   end

                /*      Initialize variables      */

select @w_counter        = 0,
       @w_return_cd      = 0,
       @w_comp_dt_dow    = 0



                /*   Keep adding periods until the end dt is reached.
                     Count the number of periods while doing so.      */

select @w_temp_dt1 = @P_BEGIN_DT

if  @P_PERIOD_CD = "D"
        select @w_counter = datediff(dy,@P_BEGIN_DT,@P_END_DT) + 1

while   @w_temp_dt1 <= @P_END_DT and  @P_PERIOD_CD != "D"
begin
        select @w_counter = @w_counter + 1
        if  @P_PERIOD_CD = "W"
                select @w_temp_dt1 = dateadd(wk,@w_counter,@P_BEGIN_DT)
        if  @P_PERIOD_CD = "M"
                select @w_temp_dt1 = dateadd(mm,@w_counter,@P_BEGIN_DT)
        if @P_PERIOD_CD = "Q"
                select @w_temp_dt1 = dateadd(qq,@w_counter,@P_BEGIN_DT)
        if  @P_PERIOD_CD = "Y"
                select @w_temp_dt1 = dateadd(yy,@w_counter,@P_BEGIN_DT)
end  /* while */

select  @w_nbr_days     = @w_counter,
        @w_begin_dt_out = convert(char(8),@P_BEGIN_DT,112),
        @w_end_dt_out   = convert(char(8),@P_END_DT,112),
        @w_begin_dt_dow = datepart(weekday,@P_BEGIN_DT),
        @w_end_dt_dow   = datepart(weekday,@P_END_DT)

select @w_return_cd, @w_begin_dt_out, @w_end_dt_out,
       @w_comp_dt_dow, @w_begin_dt_dow, @w_end_dt_dow, @w_nbr_days

 
GO

/****** Object:  StoredProcedure [dbo].[sp_dbs_sel_system_subpds]    Script Date: 02/07/2011 12:48:25 ******/
SET ANSI_NULLS OFF
GO

SET QUOTED_IDENTIFIER OFF
GO


CREATE procedure [dbo].[sp_dbs_sel_system_subpds]
(
        @P_COMP_DT           datetime,
        @P_NBR_PERIODS       smallint = 0,
        @P_PERIOD_CD         char(1)

)
AS

DECLARE
        @w_begin_dt             datetime,
        @w_end_dt               datetime,
        @w_comp_dt_dow          tinyint,
        @w_begin_dt_dow         tinyint,
        @w_end_dt_dow           tinyint,
        @w_return_cd            tinyint,
        @w_begin_dt_out         char(8),
        @w_end_dt_out           char(8),
        @w_nbr_days             smallint

                /*      Perform Edit Checks on input parms      */

if @P_COMP_DT is null
   begin
    select 2, space(8), space(8), 0, 0, 0, 0
        RETURN
   end

if @P_NBR_PERIODS is null
   begin
    select 3, space(8), space(8), 0, 0, 0, 0
 RETURN
   end

if not (@P_PERIOD_CD = "D" or
        @P_PERIOD_CD = "W" or
        @P_PERIOD_CD = "M" or
        @P_PERIOD_CD = "Q" or
        @P_PERIOD_CD = "Y")
   begin
    select 4, space(8), space(8), 0, 0, 0, 0
        RETURN
   end

                /*      Initialize variables      */

select @w_return_cd = 0

                /*      Determine the begin and end dates     */

select @w_end_dt = @P_COMP_DT

select @P_NBR_PERIODS = @P_NBR_PERIODS * -1
if @P_PERIOD_CD = "D"
   select @w_begin_dt   = dateadd(dd,@P_NBR_PERIODS,@P_COMP_DT)
if @P_PERIOD_CD = "W"
   select @w_begin_dt   = dateadd(wk,@P_NBR_PERIODS,@P_COMP_DT)
if @P_PERIOD_CD = "M"
   select @w_begin_dt   = dateadd(mm,@P_NBR_PERIODS,@P_COMP_DT)
if @P_PERIOD_CD = "Q"
   select @w_begin_dt   = dateadd(qq,@P_NBR_PERIODS,@P_COMP_DT)
if @P_PERIOD_CD = "Y"
   select @w_begin_dt   = dateadd(yy,@P_NBR_PERIODS,@P_COMP_DT)

select  @w_nbr_days     = datediff(dd,@w_begin_dt,@w_end_dt),
        @w_begin_dt_out = convert(char(8),@w_begin_dt,112),
        @w_end_dt_out   = convert(char(8),@w_end_dt,112),
        @w_comp_dt_dow  = datepart(weekday,@P_COMP_DT),
        @w_begin_dt_dow = datepart(weekday,@w_begin_dt),
        @w_end_dt_dow   = datepart(weekday,@w_end_dt)

select @w_return_cd, @w_begin_dt_out, @w_end_dt_out,
       @w_comp_dt_dow, @w_begin_dt_dow, @w_end_dt_dow, @w_nbr_days

 
GO

/****** Object:  StoredProcedure [dbo].[sp_dbs_sqlserver_version]    Script Date: 02/07/2011 12:48:25 ******/
SET ANSI_NULLS OFF
GO

SET QUOTED_IDENTIFIER OFF
GO

CREATE procedure [dbo].[sp_dbs_sqlserver_version]
AS
select value from master..syscurconfigs where config = 122
 
GO

/****** Object:  StoredProcedure [dbo].[sp_dbs_upd_spfx]    Script Date: 02/07/2011 12:48:25 ******/
SET ANSI_NULLS OFF
GO

SET QUOTED_IDENTIFIER OFF
GO


CREATE procedure [dbo].[sp_dbs_upd_spfx]
(       
	@p_file_id      char(8),
	@p_proc_name    varchar(30),
	@p_notes        varchar(255),
	@p_tfam_gen_seq	int		= null,
	@p_udak_flg	char(1)		= "N"
)
AS
EXECUTE DBSctlg.dbo.psp_upd_spfx @p_file_id, @p_proc_name, @p_notes, @p_tfam_gen_seq, @p_udak_flg
 
GO

/****** Object:  StoredProcedure [dbo].[sp_dbs_upd_spfx_seq]    Script Date: 02/07/2011 12:48:25 ******/
SET ANSI_NULLS OFF
GO

SET QUOTED_IDENTIFIER OFF
GO


CREATE procedure [dbo].[sp_dbs_upd_spfx_seq]
(	
	@p_proc_name	varchar(30),
	@p_tfam_gen_seq	smallint
)
AS
EXECUTE DBSctlg.dbo.psp_upd_spfx_seq @p_proc_name, @p_tfam_gen_seq
 
GO

/****** Object:  StoredProcedure [dbo].[sp_dbs_upd_sptx]    Script Date: 02/07/2011 12:48:25 ******/
SET ANSI_NULLS OFF
GO

SET QUOTED_IDENTIFIER OFF
GO

CREATE procedure [dbo].[sp_dbs_upd_sptx]
(
	@p_file_id      char(8),
	@p_tbl_id       char(4)
)
AS
EXECUTE DBSctlg.dbo.psp_upd_sptx @p_file_id, @p_tbl_id
 
GO

/****** Object:  StoredProcedure [dbo].[sp_dbs_upd_sptx2]    Script Date: 02/07/2011 12:48:25 ******/
SET ANSI_NULLS OFF
GO

SET QUOTED_IDENTIFIER OFF
GO

CREATE procedure [dbo].[sp_dbs_upd_sptx2]
(
	@p_file_id      char(8),
	@p_tbl_name     char(30)
)
AS
EXECUTE DBSctlg.dbo.psp_upd_sptx2 @p_file_id, @p_tbl_name
 
GO

/****** Object:  StoredProcedure [dbo].[sp_dbs_upd_trfx]    Script Date: 02/07/2011 12:48:25 ******/
SET ANSI_NULLS OFF
GO

SET QUOTED_IDENTIFIER OFF
GO


CREATE procedure [dbo].[sp_dbs_upd_trfx]
(       
	@p_file_id              char(8),
	@p_triggering_tbl       char(4),
	@p_trigger_name         varchar(30),
	@p_notes                varchar(255),
	@p_udak_flg		char(1)		= "N"
)
AS
EXECUTE  DBSctlg.dbo.psp_upd_trfx @p_file_id, @p_triggering_tbl, @p_trigger_name, @p_notes, @p_udak_flg
 
GO

/****** Object:  StoredProcedure [dbo].[sp_dbs_upd_trtx]    Script Date: 02/07/2011 12:48:25 ******/
SET ANSI_NULLS OFF
GO

SET QUOTED_IDENTIFIER OFF
GO

CREATE procedure [dbo].[sp_dbs_upd_trtx]
(       
	@p_file_id      char(8),
	@p_tbl_id       char(4)
)
AS
EXECUTE DBSctlg.dbo.psp_upd_trtx @p_file_id, @p_tbl_id
 
GO

/****** Object:  StoredProcedure [dbo].[sp_dbs_upd_trtx2]    Script Date: 02/07/2011 12:48:25 ******/
SET ANSI_NULLS OFF
GO

SET QUOTED_IDENTIFIER OFF
GO

CREATE procedure [dbo].[sp_dbs_upd_trtx2]
(       
	@p_file_id      char(8),
	@p_tbl_name     char(30)
)
AS
EXECUTE DBSctlg.dbo.psp_upd_trtx2 @p_file_id, @p_tbl_name
 
GO

/****** Object:  StoredProcedure [dbo].[sp_dbs_upd_vwtx]    Script Date: 02/07/2011 12:48:25 ******/
SET ANSI_NULLS OFF
GO

SET QUOTED_IDENTIFIER OFF
GO

CREATE procedure [dbo].[sp_dbs_upd_vwtx]
(
	@p_view_id      char(4),
	@p_tbl_id       char(4)
)
AS
EXECUTE DBSctlg.dbo.psp_upd_vwtx @p_view_id, @p_tbl_id
 
GO

/****** Object:  StoredProcedure [dbo].[sp_help_for_sp_params]    Script Date: 02/07/2011 12:48:26 ******/
SET ANSI_NULLS OFF
GO

SET QUOTED_IDENTIFIER OFF
GO


create procedure [dbo].[sp_help_for_sp_params]
@objname varchar(92) = NULL			/* object name we're after */
as

declare @objid int				/* id of the object */
declare @sysstat smallint			/* the type of the object */

set nocount on

/*
**  If no @objname given, give a little info about all objects.
*/
if @objname  IS  NULL

/*
**  Make sure the @objname is local to the current database.
*/
if @objname like "%.%.%" and
	substring(@objname, 1, charindex(".", @objname) - 1) != db_name()
begin
	print "Object must be in your current database."
	return  (1)
end

/*
**  Now check to see if the @objname is in sysobjects.  It has to be either
**  in sysobjects or systypes.
*/

select @objid = id, @sysstat = sysstat
	from sysobjects
		where id = object_id(@objname)

/*
**  It wasn't in sysobjects so we'll check in systypes.
*/
if @objid  IS  NULL
begin
	select @objid = usertype
		from systypes
			where name = @objname

	/*
	**  Time to give up -- @objname is not in sysobjects or systypes.
	*/
	if @objid  IS  NULL
	begin
		print "Object does not exist in this database."
		return  (1)
	end

	/*
	** Print help about a data type
	*/
	select Type_name = substring(s.name, 1, 15),
	       Storage_type = substring(st.name, 1, 15),
	       Length = s.length,
	       Nulls = s.allownulls,
	       Default_name=substring(object_name(s.tdefault), 1, 15),
	       Rule_name= substring(object_name(s.domain), 1, 15)
	from systypes s, systypes st
		where s.usertype = @objid
			and s.type = st.type
			and st.usertype != 18 /* ignore sysname */
			and st.usertype < 100

	return (0)
end

/*
**  It's in sysobjects so print out the information.
*/

/*
select Name = o.name, Owner = user_name(uid),
	Type = substring(v.name+ x.name, 1, 16)
	from sysobjects o, master.dbo.spt_values v,
		master.dbo.spt_values x
	where o.id = @objid
		and o.sysstat & 7 = v.number
		and v.type = "O"
		and x.type = "R"
		and o.userstat & -32768 = x.number
*/

/*
** Objects have the following value for sysstat & 7:
**	0 - trigger
**	1 - system table
**	2 - view
**	3 - user table
**	4 - sproc
**	5 - NOT UNUSED
**	6 - default
**	7 - rule
**
**  If the object is a system table, view, or user table, we want to check
**  out the objects columns here. Since the moneyn, intn and floatn are
**  internal representations, created a temporary table to save the values
**  and update those types to money, int and float when printing out.
*/


/*
**  For procedures, the parameters of the procedures are stored in syscolumns.
*/
if @sysstat & 7 = 4
begin
	/*
	**  Does the sproc have any parameters?
	*/
	if exists (select *
			from syscolumns c LEFT OUTER JOIN systypes t ON c.usertype = t.usertype
				where c.id = @objid
					)
	begin
		select Parameter_name = substring(c.name,1,15),
		       Type = substring(t.name,1,15),
		       Length = c.length,
		       '','',  	
		       Param_order=c.colid
		from syscolumns c LEFT OUTER JOIN systypes t ON c.usertype = t.usertype
			where c.id = @objid
				
	end
end

if @@rowcount = 0
begin
	select '','',0,'','',0
end

/*
**  If the objectis a table, check out the indexes.
*/

/*
if @sysstat & 7 in (1, 3)
	execute dbo.sp_helpindex @objname
*/

/*
**  If the object is a table or view, check out the keys.
*/
/*
if @sysstat & 7 in (1, 2, 3)
	execute dbo.sp_helpkey @objname
*/

/*
** Drop the table if we created it
*/
/*
if @sysstat & 7 in (1, 2, 3)
	drop table #sphelptab
*/

return (0)

 
GO

/****** Object:  StoredProcedure [dbo].[sp_help_revlogin]    Script Date: 02/07/2011 12:48:26 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[sp_help_revlogin] @login_name sysname = NULL AS
DECLARE @name    sysname
DECLARE @xstatus int
DECLARE @binpwd  varbinary (256)
DECLARE @txtpwd  sysname
DECLARE @tmpstr  varchar (256)
DECLARE @SID_varbinary varbinary(85)
DECLARE @SID_string varchar(256)

IF (@login_name IS NULL)
  DECLARE login_curs CURSOR FOR 
    SELECT sid, LTRIM(RTRIM(name)) name, xstatus, password FROM master..sysxlogins 
    WHERE srvid IS NULL AND name <> 'sa'
ELSE
  DECLARE login_curs CURSOR FOR 
    SELECT sid, LTRIM(RTRIM(name)) name, xstatus, password FROM master..sysxlogins 
    WHERE srvid IS NULL AND name = @login_name
OPEN login_curs 
FETCH NEXT FROM login_curs INTO @SID_varbinary, @name, @xstatus, @binpwd
IF (@@fetch_status = -1)
BEGIN
  PRINT 'No login(s) found.'
  CLOSE login_curs 
  DEALLOCATE login_curs 
  RETURN -1
END
SET @tmpstr = '/* sp_help_revlogin script ' 
PRINT @tmpstr
SET @tmpstr = '** Generated ' 
  + CONVERT (varchar, GETDATE()) + ' on ' + @@SERVERNAME + ' */'
PRINT @tmpstr
PRINT ''
PRINT 'DECLARE @pwd sysname'
WHILE (@@fetch_status <> -1)
BEGIN
  IF (@@fetch_status <> -2)
  BEGIN
    PRINT ''
    SET @tmpstr = '-- Login: ' + @name
    PRINT @tmpstr 
    IF (@xstatus & 4) = 4
    BEGIN -- NT authenticated account/group
      IF (@xstatus & 1) = 1
      BEGIN -- NT login is denied access
        SET @tmpstr = 'EXEC master..sp_denylogin ''' + @name + ''''
        PRINT @tmpstr 
      END
      ELSE BEGIN -- NT login has access
        SET @tmpstr = 'EXEC master..sp_grantlogin ''' + @name + ''''
        PRINT @tmpstr 
      END
    END
    ELSE BEGIN -- SQL Server authentication
      IF (@binpwd IS NOT NULL)
      BEGIN -- Non-null password
        EXEC sp_hexadecimal @binpwd, @txtpwd OUT
        IF (@xstatus & 2048) = 2048
          SET @tmpstr = 'SET @pwd = CONVERT (varchar(256), ' + @txtpwd + ')'
        ELSE
          SET @tmpstr = 'SET @pwd = CONVERT (varbinary(256), ' + @txtpwd + ')'
        PRINT @tmpstr
	EXEC sp_hexadecimal @SID_varbinary,@SID_string OUT
        SET @tmpstr = 'EXEC master..sp_addlogin ''' + @name 
          + ''', @pwd, @sid = ' + @SID_string + ', @encryptopt = '
      END
      ELSE BEGIN 
        -- Null password
	EXEC sp_hexadecimal @SID_varbinary,@SID_string OUT
        SET @tmpstr = 'EXEC master..sp_addlogin ''' + @name 
          + ''', NULL, @sid = ' + @SID_string + ', @encryptopt = '
      END
      IF (@xstatus & 2048) = 2048
        -- login upgraded from 6.5
        SET @tmpstr = @tmpstr + '''skip_encryption_old''' 
      ELSE 
        SET @tmpstr = @tmpstr + '''skip_encryption'''
      PRINT @tmpstr 
    END
  END
  FETCH NEXT FROM login_curs INTO @SID_varbinary, @name, @xstatus, @binpwd
  END
CLOSE login_curs 
DEALLOCATE login_curs 
RETURN 0

GO

/****** Object:  StoredProcedure [dbo].[sp_hexadecimal]    Script Date: 02/07/2011 12:48:26 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[sp_hexadecimal] 
@binvalue varbinary(256), 
@hexvalue varchar(256) OUTPUT 
AS 
DECLARE @charvalue varchar(256) 
DECLARE @i int 
DECLARE @length int 
DECLARE @hexstring char(16) 
SELECT @charvalue = '0x' 
SELECT @i = 1 
SELECT @length = DATALENGTH (@binvalue) 
SELECT @hexstring = '0123456789ABCDEF' 
WHILE (@i <= @length) 
BEGIN 
DECLARE @tempint int 
DECLARE @firstint int 
DECLARE @secondint int 
SELECT @tempint = CONVERT(int, SUBSTRING(@binvalue,@i,1)) 
SELECT @firstint = FLOOR(@tempint/16) 
SELECT @secondint = @tempint - (@firstint*16) 
SELECT @charvalue = @charvalue + 
SUBSTRING(@hexstring, @firstint+1, 1) + 
SUBSTRING(@hexstring, @secondint+1, 1) 
SELECT @i = @i + 1 
END 
SELECT @hexvalue = @charvalue 

GO

/****** Object:  StoredProcedure [dbo].[sp_processador]    Script Date: 02/07/2011 12:48:26 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE procedure [dbo].[sp_processador]
as
set nocount on
create table #tmp (Statistic char(30), Value float)
insert #tmp exec('DBCC SQLPERF (UMSSTATS)')

delete #tmp where Statistic like 'Scheduler%'
delete #tmp where Statistic like 'Total%'
delete #tmp where Statistic like '  cntxt%'

select Statistic, sum(Value) as Value 
from #tmp ( NOLOCK )
group by Statistic
order by Statistic
set nocount off

GO

/****** Object:  StoredProcedure [dbo].[sp_processos_em_execucao]    Script Date: 02/07/2011 12:48:26 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


create procedure [dbo].[sp_processos_em_execucao]
as
SELECT     spid, kpid, blocked, waittime, lastwaittype, waitresource, DB_NAME(dbid) AS dbname, SUSER_NAME(uid) AS uname, cpu, physical_io, memusage, 
                      login_time, last_batch, open_tran, status, hostname, program_name, hostprocess, cmd, nt_domain, nt_username, loginame, master.dbo.fn_varbintohexstr(sql_handle) as sql_handle, stmt_start, stmt_end
FROM         dbo.sysprocesses
where
status  in ( 'runnable' )
and waittype = 0x0000
and open_tran >= 0
union
SELECT     spid, kpid, blocked, waittime, lastwaittype, waitresource, DB_NAME(dbid) AS dbname, SUSER_NAME(uid) AS uname, cpu, physical_io, memusage, 
                      login_time, last_batch, open_tran, status, hostname, program_name, hostprocess, cmd, nt_domain, nt_username, loginame, master.dbo.fn_varbintohexstr(sql_handle) as sql_handle, stmt_start, stmt_end
FROM         dbo.sysprocesses
where
status  in ( 'runnable' )
and waittype <> 0x0000
and open_tran >= 0
union
SELECT     spid, kpid, blocked, waittime, lastwaittype, waitresource, DB_NAME(dbid) AS dbname, SUSER_NAME(uid) AS uname, cpu, physical_io, memusage, 
                      login_time, last_batch, open_tran, status, hostname, program_name, hostprocess, cmd, nt_domain, nt_username, loginame, master.dbo.fn_varbintohexstr(sql_handle) as sql_handle, stmt_start, stmt_end
FROM         dbo.sysprocesses
where
status  in ( 'sleeping' )
and waittype <> 0x0000
and open_tran >= 0
union
SELECT     spid, kpid, blocked, waittime, lastwaittype, waitresource, DB_NAME(dbid) AS dbname, SUSER_NAME(uid) AS uname, cpu, physical_io, memusage, 
                      login_time, last_batch, open_tran, status, hostname, program_name, hostprocess, cmd, nt_domain, nt_username, loginame, master.dbo.fn_varbintohexstr(sql_handle) as sql_handle, stmt_start, stmt_end
FROM         dbo.sysprocesses
where
    status in ( 'sleeping' )
and waittype = 0x0000
and open_tran > 0





GO

/****** Object:  StoredProcedure [dbo].[sp_spid]    Script Date: 02/07/2011 12:48:26 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE PROC [dbo].[sp_spid]  @id int=null , @debug tinyint=0 as

-- 
-----------------------------------------------------------------------  
------
--
-- Object Name: master.dbo.spid
-- Author: AENDER
-- Created: 24Aug1997
-- Description: Display details for specified spid
-- Return Codes: -1 Spid is not active
--
-- NOTES: This works fine on SQL/Server 6.50 - 6.50.240
-- and 6.50 - 6.50.258
-- But should work fine from version 6 upwards
-- 
-- History:
-- Date Name Version Description
--
-- 
-----------------------------------------------------------------------  
------


SET NOCOUNT ON

-- ---------------------------
-- Ensure Spid exists
-- ---------------------------

   DECLARE @suid varchar(8) , @waittype binary(2)
   SELECT @suid = convert(varchar(8),spid), @waittype = waittype
   FROM master..sysprocesses
   WHERE spid=@id

   IF @suid = null
     RETURN -1

-- -------------------------------------------------------------
-- Display Sysprocess info
-- Extract what is most usefull for your site here.
--   We have integrated security and are more interested in
--   NT login name rather than HOST name or LOGIN names
-- -------------------------------------------------------------

   DECLARE @w1 varchar(255), @w2 varchar(255)
   SELECT @w1='Details for spid ' + convert(varchar(30),@id) + ' at ' 
+ convert(varchar(30),getdate())
   PRINT @w1
   SELECT @w1=replicate('=',datalength(@w1))  /* Underline title */
   PRINT @w1
   PRINT ' '

   SELECT @w1=
' Status........... ' + status + char(10) +
' HostName......... ' + hostname + char(10) +
' Programe Name.... ' + program_name + char(10) +
' Command.......... ' + cmd + char(10) +
' CPU.............. ' + convert(varchar(30),cpu) + char(10) +
' Physical IO...... ' + convert(varchar(30),physical_io) + char(10) 
,
@w2= 
' BLOCKED.......... ' + convert(varchar(30),blocked) + char(10) +
' NT User.......... ' + nt_username + char(10) +
' last_batch ...... ' + convert(varchar(30),last_batch)+  char(10) 
+
' Running For ..... ' + 
convert(varchar(30),datediff(minute,last_batch,getdate()) ) + ' 
minutes' +  char(10) +
' Wait Type ....... ' + convert(varchar(30),convert(int,waittype))
   FROM master..sysprocesses
   WHERE spid=@id

   PRINT @w1
   PRINT @w2

-- -----------------------------------------------------------------
-- Convert waittype into English
-- These descriptions were sourced from Technet article Q162361
-- -----------------------------------------------------------------


  IF convert(int,@waittype) <> 0
    BEGIN
PRINT ' '
DECLARE @waitdesc varchar(255) 
SELECT @waitdesc=
CASE
WHEN @waittype = 0x8006 THEN ' **WAITTYPE 0x800  -- Waiting on 
network I/O completion'
WHEN @waittype = 0x8011 THEN ' **WAITTYPE 0x8011 -- Waiting on 
buffer resource lock (shared) request'
WHEN @waittype = 0x81   THEN ' **WAITTYPE 0x81   -- Waiting on 
writelog'
WHEN @waittype = 0x0020 THEN ' **WAITTYPE 0x0020 -- Waiting on 
buffer in I/O'
WHEN @waittype = 0x0005 THEN ' **WAITTYPE 0x0005 -- Waiting on 
exclusive page lock'
WHEN @waittype = 0x13   THEN ' **WAITTYPE 0x13   -- Waiting on 
buffer resource lock (exclusive) request'
WHEN @waittype = 0x8001 THEN ' **WAITTYPE 0x8001 -- Waiting on 
exclusive table lock'
WHEN @waittype = 0x8007 THEN ' **WAITTYPE 0x8007 -- Waiting on 
update page lock'
WHEN @waittype = 0x8005 THEN ' **WAITTYPE 0x8005 -- Waiting on 
exclusive page lock'
WHEN @waittype = 0x8003 THEN ' **WAITTYPE 0x8003 -- Waiting on 
exclusive intent lock'
WHEN @waittype = 0x6    THEN ' **WAITTYPE 0x6    -- Waiting on 
shared page lock'
WHEN @waittype = 0x8006 THEN ' **WAITTYPE 0x8006 -- Waiting on 
shared page lock'
WHEN @waittype = 0x23   THEN ' **WAITTYPE 0x23   -- Waiting on 
buffer being dumped'
WHEN @waittype = 0x5    THEN ' **WAITTYPE 0x5    -- Waiting on 
exclusive page lock'
WHEN @waittype = 0x0013 THEN ' **WAITTYPE 0x0013 -- Waiting on 
buffer resource lock (exclusive) request'
WHEN @waittype = 0x0022 THEN ' **WAITTYPE 0x0022 -- Waiting on 
buffer being dirtied'
END
PRINT @waitdesc
   END

-- 
-----------------------------------------------------------------------  
------
-- Get input buffer and PSS
-- The use of DBCC PSS Is mentioned in Technet article Q162361.
-- PSS is also documented on several SYBASE user groups.
-- The systax of the command is
-- pss( suid, spid, printopt = { 1 | 0 } )
--
-- You can obtain this via the following code (it works for all DBCC commands)
--
-- DBCC traceon(3604)  /* trace output to client */
-- dbcc help(pss)
-- DBCC traceoff(3604)
--
-- I have encounted no problems with the pss (suid,spid,0) form of the  command.
-- If you miss out any parameters or use printopt=1 you get a LOT of output.
-- 
-----------------------------------------------------------------------  
-------

-- We use the /S @@Servername option because one of our sersers runs 4.2 and 6.5 with different named pipes

   DECLARE @cmd varchar(2000)

   CREATE TABLE #details (id int identity,dbcc_op varchar(255) null)
   SELECT @cmd= 'ISQL /S'+ @@servername + ' /Usa /P /Q"dbcc inputbuffer('+ convert(varchar(10),@id ) + ') DBCC traceon(3604) DBCC PSS (' +@suid + ',' + convert(varchar(10),@id ) + ',0) dbcc traceoff(3604)" /dmaster /w255'
   INSERT INTO #details EXEC master..xp_cmdshell @cmd

   IF @debug>0 select * from #details

-- ----------------------------------------------------------
-- Extract PSS detail
-- The Fields I have chosen are worked out by trial & error
-- ----------------------------------------------------------

-- pcurdb=   Procedure Current Database ?

   DECLARE @db int
   SELECT @db=convert(int,substring(dbcc_op,charindex('pcurdb=',dbcc_op  
)+7,3)) 
   FROM #details
   WHERE dbcc_op like '%pcurdb=%'

-- plastprocid= Procedure ID of last procedure to be executed ?

   DECLARE @pid int
   SELECT @pid=convert(int,substring(dbcc_op,charindex('plastprocid=',dbcc_op)+12,11)) 
   FROM #details
   WHERE dbcc_op like '%plastprocid=%'

-- pline=  The current line of the procedure ?

   DECLARE @pline int
   SELECT @pline=convert(int,substring(dbcc_op,charindex('pline=',dbcc_op)+6,6)) 
   FROM #details
   WHERE dbcc_op like '%pline=%'

-- xactcnt= Transaction count ?  (@@trancount?)

   DECLARE @xact varchar(10)
   SELECT @xact=convert(varchar(10),substring(dbcc_op,charindex('xactcn  
t=',dbcc_op)+8,2)) 
   FROM #details
   WHERE dbcc_op like '%xactcnt=%'

-- pstat=  Process status codes ?

   DECLARE @pstat varchar(255) ,@pss1 int ,@pss2 int
   SELECT @pss1=id-1,@pstat=dbcc_op
   FROM #details
   WHERE dbcc_op like '%pstat=%'

   SELECT @pss2=id-1
   FROM #details
   WHERE dbcc_op like '%PHDR:%'

-- ----------------------------------------------------------------
-- Decifer @pstats
-- These descriptions were sourced from Technet article Q162361
-- ----------------------------------------------------------------

   PRINT ' '

   IF charindex('0x4000 ',@pstat) > 0 PRINT ' **PSTAT    0x4000 -- 
Delay KILL and ATTENTION signals if inside a critical section'
   IF charindex('0x2000 ',@pstat) > 0 PRINT ' **PSTAT    0x2000 -- 
Process is being killed'
   IF charindex('0x800 ',@pstat) > 0 PRINT ' **PSTAT    0x800  -- 
Process is in backout, thus cannot be chosen as deadlock victim'
   IF charindex('0x400 ',@pstat) > 0 PRINT ' **PSTAT    0x400  -- 
Process has received an ATTENTION signal, and has responded by 
raising an internal exception'
   IF charindex('0x100 ',@pstat) > 0 PRINT ' **PSTAT    0x100  -- 
Process in the middle of a single statement xact'
   IF charindex('0x80 ',@pstat) > 0 PRINT ' **PSTAT    0x80   -- 
Process is involved in multi-db transaction'
   IF charindex('0x8 ',@pstat) > 0 PRINT ' **PSTAT    0x8    -- 
Process is currently executing a trigger'
   IF charindex('0x2 ',@pstat) > 0 PRINT ' **PSTAT    0x2    -- 
Process has received KILL command'
   IF charindex('0x1 ',@pstat) > 0 PRINT ' **PSTAT    0x1    -- 
Process has received an ATTENTION signal'
   IF charindex('0x4000,',@pstat) > 0 PRINT ' **PSTAT    0x4000 -- 
Delay KILL and ATTENTION signals if inside a critical section'
   IF charindex('0x2000,',@pstat) > 0 PRINT ' **PSTAT    0x2000 -- 
Process is being killed'
   IF charindex('0x800,',@pstat) > 0 PRINT ' **PSTAT    0x800  -- 
Process is in backout, thus cannot be chosen as deadlock victim'
   IF charindex('0x400,',@pstat) > 0 PRINT ' **PSTAT    0x400  -- 
Process has received an ATTENTION signal, and has responded by 
raising an internal exception'
   IF charindex('0x100,',@pstat) > 0 PRINT ' **PSTAT    0x100  -- 
Process in the middle of a single statement xact'
   IF charindex('0x80,',@pstat) > 0 PRINT ' **PSTAT    0x80   -- 
Process is involved in multi-db transaction'
   IF charindex('0x8,',@pstat) > 0 PRINT ' **PSTAT    0x8    -- 
Process is currently executing a trigger'
   IF charindex('0x2,',@pstat) > 0 PRINT ' **PSTAT    0x2    -- 
Process has received KILL command'
   IF charindex('0x1,',@pstat) > 0 PRINT ' **PSTAT    0x1    -- 
Process has received an ATTENTION signal'

   if @debug >2 select db=@db,pid=@pid,pl=@pline,xc=@xact

-- ---------------------------
-- Display TSQL info
-- ---------------------------

   DECLARE @ipb varchar(255) Select @ipb=dbcc_op from #details where 
id=7
   DECLARE @dbn varchar(255) Select @dbn=name from 
master..sysdatabases where dbid=@db

   PRINT ' '
   SELECT @cmd=' Input buffer.....' + @ipb
   PRINT @cmd

   SELECT @cmd=' Database......... ' + @dbn
   PRINT @cmd

   SELECT @cmd=' @@trancount...... ' + @xact
   PRINT @cmd

-- 
----------------------------------------------------------------------  

-- Display locks
-- I'm not sure when sp_lock2 arrived but it shows locks in more detail
-- 
----------------------------------------------------------------------  


   DECLARE @locks int SELECT @locks = count(*) from master..syslocks 
where spid=@id
   IF @locks > 0
     BEGIN
        SELECT @cmd=' Locks held....... ' + 
convert(varchar(30),@locks)
        PRINT @cmd

PRINT ' '
PRINT '----------------------------- Lock Details 
------------------------------------'
PRINT ' '

IF EXISTS (select * from master..sysobjects where name = 'sp_lock2' 
and type ='p')
select @cmd='sp_lock2 ' + convert(varchar(30),@id)
  ELSE
select @cmd='sp_lock ' + convert(varchar(30),@id)
EXEC (@cmd)

PRINT '---------------------------------------------------------------  
----------------'
PRINT ' '
   END

-- ---------------------------
-- Extract current proc name
-- ---------------------------

   CREATE TABLE #t1(work_op varchar(255) null)
   SELECT @cmd='Select name from ' + @dbn + '..sysobjects where id=' + 
convert(varchar(30),@pid)
   INSERT INTO #t1 EXEC (@cmd)

   DECLARE @cur_proc varchar(255) select @cur_proc=work_op from #t1
   IF Ltrim(@cur_proc) <> null
    BEGIN

PRINT ' '
PRINT '------------------- Currently running Stored Procedure 
------------------------'
PRINT ' '
SELECT @cmd='   Line:' + convert(varchar(30),@pline) + ' (approx.) 
of ' + upper(@cur_proc)
PRINT @cmd

PRINT ' '
PRINT ' '

-- -------------------------------
-- Extract source of current proc
-- -------------------------------

SELECT @cmd='Select text,number from ' + @dbn + '..syscomments where 
id=' + convert(varchar(30),@pid)
CREATE TABLE #t2 (text varchar(255) , number int)
INSERT  INTO #t2 EXEC (@cmd)

-- ------------------------------------------
-- split into lines (still needs some work)
-- -----------------------------------------

declare @crlf char(2) select @crlf=char(13) + char(10)

create table #t3 (x char(3) null ,Line smallint identity, Content 
varchar(255) null)

set nocount on
declare lines cursor for select text from #t2 order by number
open lines
declare @text varchar(255) , @endofline tinyint ,@line varchar(255)
while 1=1
  begin
fetch next from lines into @text
if @@fetch_status <> 0
break
while charindex(@crlf,@text) > 0
  begin
select @line=@line + substring(@text,1,charindex(@crlf,@text)-1) 
insert into #t3(Content) select @line 
select 
@text=substring(@text,charindex(@crlf,@text)+2,datalength(@text)-charindex(@crlf,@text)-1) ,@line=null
END
select @line=@text
end
insert into #t3(Content) select @line
deallocate lines

-- -------------------------------
-- Highlight current line
-- -------------------------------

update #t3 set x='>>>' where line=@pline

-- -------------------------------
-- Dispaly sp
-- -------------------------------

select isnull(x,''),Line,Content=isnull(content,'') from #t3 order by 
line

   END

-- -------------------------------
-- Display Output buffer
-- One day this might be usefull
-- -------------------------------

   PRINT ' '
   PRINT '--------------------------- OUTPUT BUFFER 
----------------------------------'
   DBCC OUTPUTBUFFER (@id)

-- -------------------------------
-- Display PSS
--
-- -------------------------------

   PRINT ' '
   PRINT '-----------------  Process Slot Structure 
--------------------------'
   SELECT ' '=dbcc_op from #details where id between @pss1 and @pss2



GO

/****** Object:  StoredProcedure [dbo].[sp_usrinputbuffer]    Script Date: 02/07/2011 12:48:26 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[sp_usrinputbuffer]
(
	@SPID smallint,		-- O SPID a ser analizado
	@WAIT tinyint = 1,	-- Intervalo de repetição entre as verificações.Valor deve estar entre 0 e 60 segundos
				-- Default é de 1 em 1 segundo
	@NoLoop bit = 1		-- Se =1, o SPID é analizado apenas uma vez. Se =0 fica em loop até o final do processo.
)
AS
BEGIN

/********************************************************************************************
sp_usrinputbuffer: Esta procedure permite identificar a instrução exata que está sendo 
executado por uma dada conexão. Semelhante ao DBCC INPUTBUFFER mas diferente desta, em caso 
de procedure, a proc mostra toda a instrução inteira e não apenas o nome da procedure. Muito boa
para ser usada em conjunto com a procedure sp_usrheadblocker.

Exemplo: sp_usrinputbuffer 54 (Onde 54 é o ID da conexão SPID)

Obs: Se preferir, esta pode ser criada em qualquer banco, porém, ao executá-la deverá passar o nome da
base onde a mesma se encontra. Exemplo: Base..sp_usrinputbuffer 54

Author Original: Narayana Vyas Kondreddi
Source: http://vyaskn.tripod.com
Date Created: 18/12/2003
Alterada por : Nilton Pinheiro
WebSite: http://www.mcdbabrasil.com.br
*********************************************************************************************/	
	 
	SET NOCOUNT ON
 
	DECLARE @sql_handle binary(20), @handle_found bit
	DECLARE @stmt_start int, @stmt_end int
	DECLARE @line varchar(8000), @wait_str varchar(8)
 
	SET @handle_found = 0
 
	IF @WAIT NOT BETWEEN 0 AND 60
	BEGIN
		RAISERROR('Valores válidos para @WAIT estão entre 0 e 60 segundos', 16, 1)
		RETURN -1
	END
	ELSE
	BEGIN
		SET @wait_str = '00:00:' + RIGHT('00' + CAST(@WAIT AS varchar(2)), 2)
	END
 
	WHILE 1 = 1
	BEGIN
		SELECT	@sql_handle = sql_handle,
			@stmt_start = stmt_start/2,
			@stmt_end = CASE WHEN stmt_end = -1 THEN -1 ELSE stmt_end/2 END
			FROM master.dbo.sysprocesses
			WHERE	spid = @SPID
				AND ecid = 0
  
		IF @sql_handle = 0x0
		BEGIN
			IF @handle_found = 0
			BEGIN
				RAISERROR('Não pode encontrar o handle ou o SPID é inválido', 16, 1)
				RETURN -1
			END
			ELSE
			BEGIN
				RAISERROR('Query/Stored procedure completada', 0, 1)
				RETURN 0
			END
		END
		ELSE
		BEGIN
			SET @handle_found = 1
		END
 		Print '******** STATEMENT SENDO EXECUTADO NO MOMENTO ************'
		Print ''

		SELECT @line = text
				--SUBSTRING(	text,
				--		COALESCE(NULLIF(@stmt_start, 0), 1),
				--		CASE @stmt_end 
				--			WHEN -1 
				--				THEN DATALENGTH(text) 
				--			ELSE 
				--				(@stmt_end - @stmt_start) 
    			--			END
				--	) 
   			FROM ::fn_get_sql(@sql_handle)
  		--)
 
		print @line
 
		IF @NoLoop = 1
		BEGIN
			RETURN 0
		END
 
		WAITFOR DELAY @wait_str
 
	END
 
END

GO

