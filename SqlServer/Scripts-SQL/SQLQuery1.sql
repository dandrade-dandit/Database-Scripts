SELECT	E.SEQ_EQUIPAMENTO
,		D.DEP_SIGLA
,		D.DEP_NOME
,		T.NOM_TIPO_EQUIPAMENTO
,		ISNULL(M.NOM_TAMANHO_MONITOR, 'N�O INFORMADO') AS NOM_TAMANHO_MONITOR
,		E.QTD_EQUIPAMENTO
,		E.NOM_FABRICANTE
,		E.DES_LOCALIZACAO
,		CASE E.FLG_PROPRIETARIO_INFRAERO
			WHEN 'I' THEN 'INFRAERO'
			WHEN 'T' THEN 'TERCEIRO'
		END AS PROPRIETARIO
,		CONVERT(VARCHAR(12), E.DAT_AQUISICAO, 103) AS DAT_AQUISICAO
,		E.FLG_PROPRIETARIO_TERCEIRO
,		CONVERT(VARCHAR(12), E.DAT_INICIO_CONTRATO, 103) AS DAT_INICIO_CONTRATO
,		CONVERT(VARCHAR(12), E.DAT_FIM_CONTRATO, 103) AS DAT_FIM_CONTRATO
,		E.NUM_PATRIMONIO

FROM    equipamento AS E INNER JOIN
		tipo_equipamento AS T ON E.SEQ_TIPO_EQUIPAMENTO = T.SEQ_TIPO_EQUIPAMENTO LEFT JOIN
		tamanho_monitor AS M ON E.SEQ_TAMANHO_MONITOR = M.SEQ_TAMANHO_MONITOR INNER JOIN
		IFRCORP..DEPENDENCIAS AS D ON E.DEP_CODIGO = D.DEP_CODIGO


