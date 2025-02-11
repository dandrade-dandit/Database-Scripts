/****** Script for SelectTopNRows command from SSMS  ******/
SELECT TOP 1000 [Codempresa]
      ,[NmeEmpresa]
      ,[NumVoo]
      ,[NmeEquip]
      ,[IndSegunda]
      ,[IndTerca]
      ,[IndQuarta]
      ,[IndQuinta]
      ,[IndSexta]
      ,[IndSabado]
      ,[IndDomingo]
      ,[QtdAssentos]
      ,[NumHotran]
      ,[DtaSolicitacao]
      ,[DtaAprovacao]
      ,[DtaVigencia]
      ,[DscNaturezaOperacao]
      ,[NumEtapa]
      ,[SigAeroportoOrigem]
      ,[NmeAeroportoOrigem]
      ,[SigAeroportoDestino]
      ,[NmeAeroportoDestino]
      ,[HorPartida]
      ,[HorChegada]
      ,[DscCodeshare]
      ,[NmeEquipAlternativo]
  FROM [IFRCORP].[dbo].[HotranVigente]
 WHERE [SigAeroportoDestino] = 'SBSP'
   AND (  IndSegunda = DATEPART(WEEKDAY, GETDATE()) OR
	      IndTerca = DATEPART(WEEKDAY, GETDATE()) OR
		  IndQuarta = DATEPART(WEEKDAY, GETDATE()) OR
		  IndQuinta = DATEPART(WEEKDAY, GETDATE()) OR
		  IndSexta = DATEPART(WEEKDAY, GETDATE()) OR
		  IndSabado = DATEPART(WEEKDAY, GETDATE()) OR
		  IndDomingo = DATEPART(WEEKDAY, GETDATE()) )
   AND	DATEPART(HOUR, HorChegada) >=  DATEPART(HOUR, GETDATE()) 
 ORDER
    BY HorChegada	

