ALTER VIEW VIW_HOTRAN_TEMP AS
SELECT 
		LTRIM(RTRIM([Cód#  Empresa])) CodEmpresa
	 ,	LTRIM(RTRIM([Empresa])) NmeEmpresa	
	 ,	LTRIM(RTRIM([Nº VOO])) NumVoo
	 ,	LTRIM(RTRIM([Equip#])) NmeEquip
	 ,	CASE LEN(LTRIM(RTRIM(Seg)))
			WHEN 0 THEN NULL
			WHEN NULL THEN NULL
			ELSE 2 
		END IndSegunda
	 ,	CASE LEN(LTRIM(RTRIM(Ter)))
			WHEN 0 THEN NULL
			WHEN NULL THEN NULL
			ELSE 3 
		END IndTerca
	 ,	CASE LEN(LTRIM(RTRIM(Qua)))
			WHEN 0 THEN NULL
			WHEN NULL THEN NULL
			ELSE 4 
		END IndQuarta
	 ,	CASE LEN(LTRIM(RTRIM(Qui)))
			WHEN 0 THEN NULL
			WHEN NULL THEN NULL
			ELSE 5 
		END IndQuinta
	 ,	CASE LEN(LTRIM(RTRIM(Sex)))
			WHEN 0 THEN NULL
			WHEN NULL THEN NULL
			ELSE 6 
		END IndSexta
	 ,	CASE LEN(LTRIM(RTRIM(Sáb)))
			WHEN 0 THEN NULL
			WHEN NULL THEN NULL
			ELSE 7 
		END IndSabado
	 ,	CASE LEN(LTRIM(RTRIM(Dom)))
			WHEN 0 THEN NULL
			WHEN NULL THEN NULL
			ELSE 1 
		END IndDomingo
	 ,	LTRIM(RTRIM([Qtde Assentos])) QtdAssentos
	 ,	LTRIM(RTRIM([Número Hotran])) NumHotran
	 ,	CONVERT(DATETIME,SUBSTRING([Data Solicitação],7,4)+SUBSTRING([Data Solicitação],4,2)+SUBSTRING([Data Solicitação],1,2)) DtaSolicitacao
	 ,	CONVERT(DATETIME,SUBSTRING([Data Aprovação],7,4)+SUBSTRING([Data Aprovação],4,2)+SUBSTRING([Data Aprovação],1,2)) DtaAprovacao
	 ,	CONVERT(DATETIME,SUBSTRING([Data Vigência],7,4)+SUBSTRING([Data Vigência],4,2)+SUBSTRING([Data Vigência],1,2)) DtaVigencia
	 ,	UPPER(LTRIM(RTRIM([Natureza Operação]))) DscNaturezaOperacao
	 ,	LTRIM(RTRIM([Nº Etapa])) NumEtapa
	 ,	UPPER(LTRIM(RTRIM([COD# Origem]))) SigAeroportoOrigem
	 ,	UPPER(LTRIM(RTRIM([ARPT Origem]))) NmeAeroportoOrigem
	 ,	UPPER(LTRIM(RTRIM([COD# Destino]))) SigAeroportoDestino
	 ,	UPPER(LTRIM(RTRIM([ARPT Destino]))) NmeAeroportoDestino
	 ,	CONVERT(DATETIME,'19000101 '+LTRIM(RTRIM([Horário Partida])))  HorPartida
	 ,	CONVERT(DATETIME,'19000101 '+LTRIM(RTRIM([Horário Chegada ]))) HorChegada
	 ,	LTRIM(RTRIM([CODESHARE])) DscCodeshare
	 ,	LTRIM(RTRIM([Equip# Alt])) NmeEquipAlternativo
  FROM [IFRCORP].[dbo].[Results]


  /*
  USE IFRCORP 

  TRUNCATE TABLE [HotranVigente]

  INSERT INTO [IFRCORP].[dbo].[HotranVigente]
  SELECT * FROM [IFRCORP].[dbo].VIW_HOTRAN_TEMP



  SELECT LEN(IndSegunda) FROM [IFRCORP].[dbo].VIW_HOTRAN_TEMP ORDER BY 1 ASC




  LTRIM(RTRIM([Cód#  Empresa])) CodEmpresa
	 ,	LTRIM(RTRIM([Empresa])) NmeEmpresa	
	 ,NULL  NumVoo
	 ,NULL  NmeEquip
	 ,NULL IndSegegunda
	 ,NULL IndTerca
	 ,NULL IndQuarta
	 ,NULL IndQuinta
	 ,NULL IndSexta
	 ,NULL  IndSabado
	 ,NULL IndDomingo
	 ,NULL QtdAssentos
	 ,NULL NumHotran
	 ,NULL DtaSolicitacao
	 ,NULL DtaAprovacao
	 ,NULL DtaVigencia
	 ,NULL DscNaturezaOperacao
	 ,NULL NumEtapa
	 ,NULL SigAeroportoOrigem
	 ,NULL NmeAeroportoOrigem
	 ,NULL SigAeroportoDestino
	 ,NULL NmeAeroportoDestino
	 ,NULL HorPartida
	 ,NULL HorChegada
	 ,NULL DscCodeshare
	 ,NULL NmeEquipAlternativo
  */