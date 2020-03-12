ACCEPT NUM_NOTAM CHAR PROMPT 'ENTRE COM O NUM NOTAM: '
ACCEPT SERIE_NOTAM CHAR PROMPT 'ENTRE COM A SERIE DO NOTAM: '
ACCEPT ANO_TXT CHAR PROMPT 'ENTRE COM O ANO COM OS 2 ULTIMOS DIGITOS: '
ACCEPT ANO_NUM NUMBER PROMPT 'ENTRE COM O ANO: '

delete
--select count(1)
from bia_rx
where numero_notam = '&NUM_NOTAM'
and serie = UPPER('&SERIE_NOTAM')
and ano_notam = '&ANO_TXT'
/

delete 
--select count(1)
from bia_notamerro
where notamid in (select notamid
		from bia_notam
		where numeronotam = '&NUM_NOTAM'
		and serie = UPPER('&SERIE_NOTAM')
		and anonotam = &ANO_NUM)
/

delete 
--select count(1)
from bia_notamlocalidade
where notamid in (select notamid
   		from bia_notam
		where numeronotam = '&NUM_NOTAM'
		and serie = UPPER('&SERIE_NOTAM')
		and anonotam = &ANO_NUM)
/

delete
--select count(1)
from bia_notam
where numeronotam = '&NUM_NOTAM'
and serie = UPPER('&SERIE_NOTAM')
and anonotam = &ANO_NUM
/

delete 
--select count(1)
from BIA_NOTAMANALISE
where bia_rx_id in (select notamid
		from bia_notam
		where numeronotam = '&NUM_NOTAM'
		and serie = UPPER('&SERIE_NOTAM')
		and anonotam = &ANO_NUM)
/

delete 
--select count(1)
from BIA_NOTAMANALISELOCALIDADE
where notamanaliseid in (select notamid
			from bia_notam
			where numeronotam = '&NUM_NOTAM'
			and serie = UPPER('&SERIE_NOTAM')
			and anonotam = &ANO_NUM)
/

delete 
--select count(1)
from BIA_NOTAMANALISEERRO
where notamanaliseid in (select notamid
			from bia_notam
			where numeronotam = '&NUM_NOTAM'
			and serie = UPPER('&SERIE_NOTAM')
			and anonotam = &ANO_NUM)
/

COMMIT;