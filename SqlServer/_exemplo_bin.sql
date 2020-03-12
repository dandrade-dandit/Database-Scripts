declare @NroInt int
,	@txt varchar(255)

Select @NroInt = 55

select @txt = ''

if (@NroInt &  1) = 1 select  @txt = @txt + '1,'
if (@NroInt &  2) = 2 select  @txt = @txt + '2,'
if (@NroInt &  4) = 4 select  @txt = @txt + '3,'
if (@NroInt &  8) = 8 select  @txt = @txt + '4,'
if (@NroInt &  16) = 16 select  @txt = @txt + '5,'
if (@NroInt &  32) = 32 select @txt = @txt +  '6'

select @txt

if (@NroInt &  1) = 1 print  'Bit 1 ligado.'
if (@NroInt &  2) = 2 print  'Bit 2 ligado.'
if (@NroInt &  4) = 4 print  'Bit 4 ligado.'
if (@NroInt &  8) = 8 print  'Bit 8 ligado.'
if (@NroInt &  16) = 16 print  'Bit 16 ligado.'
if (@NroInt &  32) = 32 print  'Bit 32 ligado.'

