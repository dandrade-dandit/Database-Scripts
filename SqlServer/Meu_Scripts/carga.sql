declare @c int
set @c=1
while (@c <= 100000)
begin
   insert into denis values ('Denis And', @c)
   select @c = @c + 1
end

select count(1) from denis