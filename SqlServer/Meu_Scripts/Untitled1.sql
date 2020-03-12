declare @au_id varchar(12)
,      	@au_lname varchar(100)
,	@au_fname varchar(50)
,	@message varchar(200)

DECLARE titles_cursor CURSOR FOR 
select 	top 12 
	au_id
,      	au_lname
,	au_fname 
from authors

OPEN titles_cursor
FETCH NEXT FROM titles_cursor 
INTO @au_id
,    @au_lname
,    @au_fname

WHILE @@FETCH_STATUS = 0
BEGIN

   SET @message = 'Autor: ' + @au_fname + ' ' + @au_lname + ', Id: ' + @au_id
   PRINT @message
   FETCH NEXT FROM titles_cursor 
   INTO @au_id
   ,    @au_lname
   ,    @au_fname

END

CLOSE titles_cursor
DEALLOCATE titles_cursor
   
