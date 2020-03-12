SELECT	*
FROM	VIW_BIOGER_HOTRAN
WHERE	MES_DES = 12
--AND		DIA_DES = 19
--AND		SIGLA_AEROPORTO_OPERACAO = 'SBBR'
AND		MATRICULA_AERONAVE_DES = 'PRMBS'
--AND		CIA_AEREA_DES = 'GLO'
ORDER BY
		ANO_DES
,		MES_DES
,		DIA_DES
,		HORA_DES
,		MINUTO_DES