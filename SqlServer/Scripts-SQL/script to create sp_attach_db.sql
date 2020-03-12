if exists 
        (select name from sys.sysobjects where name = 'usp_attachdb')
        drop procedure usp_attachdb
go

create proc usp_attachdb
           @db sysname  = null
as
  set nocount  on
  set concat_null_yields_null  off
  declare  @cmd varchar(1000)
  declare  @a varchar(2000)
  declare  @filecnt int
  declare  @cnt int
  declare  @sq char(1)
  declare  @dq char(2)
  declare  @tempfilename varchar(1000)
  declare  @tempfilename1 varchar(1000)
  set @sq = ''''
  set @dq = ''''''
  set @cnt = 1
  if @db is not null
    begin
      create table #1 (
        fileid   int,
        filename sysname,
        name     sysname)
      set @cmd = 'insert into #1 (fileid,filename,name) select fileid,filename,name from '
                   + quotename(@db)
                   + '.dbo.sysfiles'
      exec( @cmd)
      select @filecnt = max(fileid)
      from   #1
      while @cnt <= @filecnt
        begin
          select @tempfilename = filename
          from   #1
          where  fileid = @cnt
          select @tempfilename = rtrim(@tempfilename)
          select @a = @a
                        + ','
                        + char(13)
                        + char(9)
          select @a = @a
                        + '@filename'
                        + convert(varchar(2),@cnt)
                        + ' = '
                        + @sq
                        + @tempfilename
                        + @sq
          set @cnt = @cnt
                       + 1
        end
      select @a = 'exec sp_attach_db @dbname = '
                    + @sq
                    + @db
                    + @sq
                    + @a
      print @a
    end
  else
    begin
      declare db_cursor cursor  for
      select   name
      from     sysdatabases
      where    name not in ('tempdb','master','msdb','model')
               and dbid not in (select database_id
                                from   sys.databases
                                where  state > 0)
      order by dbid
      open db_cursor
      fetch next from db_cursor
      into @db
      while @@fetch_status = 0
        begin
          create table #2 (
            fileid   int,
            filename sysname,
            name     sysname)
          set @cmd = 'insert into #2 (fileid,filename,name) select file_id, physical_name, name 
from sys.master_files where database_id = db_id('''+@db+''')'
          exec( @cmd)
          select @filecnt = (select count(*) from sys.master_files where database_id = db_id(@db))
          from   #2
          while @cnt <= @filecnt
            begin
              select @tempfilename = filename
              from   #2
              where  fileid = @cnt
              select @tempfilename = rtrim(@tempfilename)
              select @a = @a
                            + ', '
                            + char(13)
                            + char(9)
              select @a = @a
                            + '@filename'
                            + convert(varchar(2),@cnt)
                            + ' = '
                            + @sq
                            + @tempfilename
                            + @sq
              set @cnt = @cnt
                           + 1
            end
          select @a = 'exec sp_attach_db @dbname = '
                        + @sq
                        + @db
                        + @sq
                        + @a
          print @a
          print 'go'
          select @a = ' '
          drop table #2
          set @cnt = 1
          fetch next from db_cursor
          into @db
        end
      close db_cursor
      deallocate db_cursor
    end

