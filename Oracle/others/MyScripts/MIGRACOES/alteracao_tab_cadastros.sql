EXEC SET_ROLL_SEGMENT

insert into movimentacao1
Select *
from movimentacao
where mov_ano_referencia = 2002
and mov_mes_referencia = 13
/

COMMIT;

EXEC SET_ROLL_SEGMENT

insert into movimentacao1
Select *
from movimentacao
where mov_ano_referencia = 2003
and mov_mes_referencia = 01
/

COMMIT;

EXEC SET_ROLL_SEGMENT

insert into movimentacao1
Select *
from movimentacao
where mov_ano_referencia = 2003
and mov_mes_referencia = 02
/

COMMIT;

EXEC SET_ROLL_SEGMENT

insert into movimentacao1
Select *
from movimentacao
where mov_ano_referencia = 2003
and mov_mes_referencia = 03
/

COMMIT;

EXEC SET_ROLL_SEGMENT

insert into movimentacao1
Select *
from movimentacao
where mov_ano_referencia = 2003
and mov_mes_referencia = 04
/

COMMIT;

EXEC SET_ROLL_SEGMENT

insert into movimentacao1
Select *
from movimentacao
where mov_ano_referencia = 2003
and mov_mes_referencia = 05
/

COMMIT;

EXEC SET_ROLL_SEGMENT

insert into movimentacao1
Select *
from movimentacao
where mov_ano_referencia = 2003
and mov_mes_referencia = 06
/

COMMIT;

EXEC SET_ROLL_SEGMENT

insert into movimentacao1
Select *
from movimentacao
where mov_ano_referencia = 2003
and mov_mes_referencia = 07
/

COMMIT;

EXEC SET_ROLL_SEGMENT

insert into movimentacao1
Select *
from movimentacao
where mov_ano_referencia = 2003
and mov_mes_referencia = 08
/

COMMIT;

EXEC SET_ROLL_SEGMENT

insert into movimentacao1
Select *
from movimentacao
where mov_ano_referencia = 2003
and mov_mes_referencia = 09
/

COMMIT;

EXEC SET_ROLL_SEGMENT

insert into movimentacao1
Select *
from movimentacao
where mov_ano_referencia = 2003
and mov_mes_referencia = 10
/

COMMIT;

EXEC SET_ROLL_SEGMENT

insert into movimentacao1
Select *
from movimentacao
where mov_ano_referencia = 2003
and mov_mes_referencia = 11
/

COMMIT;

EXEC SET_ROLL_SEGMENT

insert into movimentacao1
Select *
from movimentacao
where mov_ano_referencia = 2003
and mov_mes_referencia = 12
/

COMMIT;

EXEC SET_ROLL_SEGMENT

insert into movimentacao1
Select *
from movimentacao
where mov_ano_referencia = 2003
and mov_mes_referencia = 13
/

COMMIT;

EXEC SET_ROLL_SEGMENT

insert into movimentacao1
Select *
from movimentacao
where mov_ano_referencia = 2004
and mov_mes_referencia = 01
/

COMMIT;

EXEC SET_ROLL_SEGMENT

insert into movimentacao1
Select *
from movimentacao
where mov_ano_referencia = 2004
and mov_mes_referencia = 02
/

COMMIT;

EXEC SET_ROLL_SEGMENT

insert into movimentacao1
Select *
from movimentacao
where mov_ano_referencia = 2004
and mov_mes_referencia = 03
/

COMMIT;

EXEC SET_ROLL_SEGMENT

insert into movimentacao1
Select *
from movimentacao
where mov_ano_referencia = 2004
and mov_mes_referencia = 04
/

COMMIT;

EXEC SET_ROLL_SEGMENT

insert into movimentacao1
Select *
from movimentacao
where mov_ano_referencia = 2004
and mov_mes_referencia = 05
/

COMMIT;

EXEC SET_ROLL_SEGMENT

insert into movimentacao1
Select *
from movimentacao
where mov_ano_referencia = 2004
and mov_mes_referencia = 06
/

COMMIT;

EXEC SET_ROLL_SEGMENT

insert into movimentacao1
Select *
from movimentacao
where mov_ano_referencia = 2004
and mov_mes_referencia = 07
/

COMMIT;

EXEC SET_ROLL_SEGMENT

insert into movimentacao1
Select *
from movimentacao
where mov_ano_referencia = 2004
and mov_mes_referencia = 08
/

COMMIT;

EXEC SET_ROLL_SEGMENT

insert into movimentacao1
Select *
from movimentacao
where mov_ano_referencia = 2004
and mov_mes_referencia = 09
/

COMMIT;

EXEC SET_ROLL_SEGMENT

insert into movimentacao1
Select *
from movimentacao
where mov_ano_referencia = 2004
and mov_mes_referencia = 10
/

COMMIT;

EXEC SET_ROLL_SEGMENT

insert into movimentacao1
Select *
from movimentacao
where mov_ano_referencia = 2004
and mov_mes_referencia = 11
/

COMMIT;

EXEC SET_ROLL_SEGMENT

insert into movimentacao1
Select *
from movimentacao
where mov_ano_referencia = 2004
and mov_mes_referencia = 12
/

COMMIT;

EXEC SET_ROLL_SEGMENT

insert into movimentacao1
Select *
from movimentacao
where mov_ano_referencia = 2005
and mov_mes_referencia = 1
/

COMMIT;

EXEC SET_ROLL_SEGMENT

insert into movimentacao1
Select *
from movimentacao
where mov_ano_referencia = 2006
and mov_mes_referencia = 7
/

COMMIT;

EXEC SET_ROLL_SEGMENT

insert into movimentacao1
Select *
from movimentacao
where mov_ano_referencia = 2022
and mov_mes_referencia = 3
/

COMMIT;

EXEC SET_ROLL_SEGMENT

insert into movimentacao1
Select *
from movimentacao
where mov_ano_referencia = 2200
and mov_mes_referencia = 3
/

COMMIT;

EXEC SET_ROLL_SEGMENT

insert into movimentacao1
Select *
from movimentacao
where mov_ano_referencia = 2202
and mov_mes_referencia = 3
/

COMMIT;

EXEC SET_ROLL_SEGMENT

insert into movimentacao1
Select *
from movimentacao
where mov_ano_referencia = 2202
and mov_mes_referencia = 10
/

COMMIT;

EXEC SET_ROLL_SEGMENT

insert into movimentacao1
Select *
from movimentacao
where mov_ano_referencia = 5003
and mov_mes_referencia = 5
/

COMMIT;


select mov_ano_referencia, mov_mes_referencia, count(1)
from movimentacao1
group by mov_ano_referencia, mov_mes_referencia
order by mov_ano_referencia, mov_mes_referencia