USE IEOP
GO

ALTER VIEW usr_ieop_bam.VIW_HOTRAN_CHEGADA as
SELECT	SigAeroportoDestino
	 ,	DATEPART(HOUR, HorChegada) HORA
	 ,	DATEPART(WEEKDAY, GETDATE()) DIA_SEMANA
	 ,  COUNT(1) TOTAL
	   /*[SigAeroportoOrigem]
      ,[SigAeroportoDestino]
      ,[HorPartida]
      ,[HorChegada]*/
  FROM [IFRCORP].[dbo].[HotranVigente]
 WHERE (  IndSegunda = DATEPART(WEEKDAY, GETDATE()) OR
	      IndTerca = DATEPART(WEEKDAY, GETDATE()) OR
		  IndQuarta = DATEPART(WEEKDAY, GETDATE()) OR
		  IndQuinta = DATEPART(WEEKDAY, GETDATE()) OR
		  IndSexta = DATEPART(WEEKDAY, GETDATE()) OR
		  IndSabado = DATEPART(WEEKDAY, GETDATE()) OR
		  IndDomingo = DATEPART(WEEKDAY, GETDATE()) )
   AND	SigAeroportoDestino = 'SBSP'
 GROUP
	BY	SigAeroportoDestino
	 ,	DATEPART(HOUR, HorChegada)


/*


SELECT	*
  FROM	IEOP.usr_ieop_bam.VIW_HOTRAN_CHEGADA


*/

