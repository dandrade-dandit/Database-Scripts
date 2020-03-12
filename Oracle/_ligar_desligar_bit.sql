

--*****************************************************************************
-- SQL SERVER
--*****************************************************************************
select	d.*, DD.DESCRICAO
from	dbo.Dados d
,		dadosdet DD
where   (D.status & 4) = DD.CODIGO


/*
update	dbo.Dados
set		status = status + 16
where	codigo in (select d.codigo
                   from	dbo.Dados d
					,	dadosdet DD
					where   (D.status & 8) = DD.CODIGO)
*/

--*****************************************************************************
-- ORACLE
--*****************************************************************************

SELECT  D.*, C.DESCRICAO
FROM    IFRDBA.DADOS D
,       IFRDBA.CODIGOS C
WHERE   BITAND(STATUS, 4) = C.CODIGO

--DECODE(BITAND(TBL_TEMP.VALUE,2), 2, 2, -1) <> -1;