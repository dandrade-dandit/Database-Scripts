INSERT INTO [DM_DA].[dbo].[TAB_ESTATISTICA_OCUPACAO_VAGAS_GEST]
SELECT left(a.AER_REGIONAL, 4) as REGIONAL, 
left(a.AER_SIGLA, 4) as AEROPORTO, 
sum(a.OCUPACAO_PATIO) OCUPACAO, 
sum(a.VAGAS_PATIO) VAGAS, 
cast((sum(a.OCUPACAO_PATIO)*100)/sum(cast(a.VAGAS_PATIO as float)) as numeric(10,2)) PERCENTUAL, 
CONVERT(VARCHAR(8), A.DAT_INSERT , 112) DAT_INSERT 
from [SBRF - GESTNET].GESTNET.dbo.VW_OCUPACAO_CONSOLIDADA a 
--where DAT_INSERT = (SELECT CONVERT(VARCHAR(8), GETDATE()-1, 112)) 
group by left(a.AER_REGIONAL, 4), left(a.AER_SIGLA, 4), CONVERT(VARCHAR(8), A.DAT_INSERT , 112)
order by left(a.AER_REGIONAL, 4) asc, left(a.AER_SIGLA, 4) asc, CONVERT(VARCHAR(8), A.DAT_INSERT , 112) DESC


/*

SELECT TOP 1000 [REGIONAL]
      ,[AEROPORTO]
      ,[OCUPACAO]
      ,[VAGAS]
      ,[PERCENTUAL]
      ,[DAT_INSERT]
  FROM [DM_DA].[dbo].[TAB_ESTATISTICA_OCUPACAO_VAGAS_GEST]
  WHERE DAT_INSERT = '20150110'


*/