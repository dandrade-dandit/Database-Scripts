SELECT	DES.SIG_AEROPORTO
	 ,	DES.MAX_DTH_MIGRACAO_DES
	 ,	EMB.MAX_DTH_MIGRACAO_EMB
	 ,	MOV.MAX_DTH_MIGRACAO_MOV
	 ,  DATEADD(HOUR, -1, GETDATE()) DATA
	 ,	CASE
			WHEN DES.MAX_DTH_MIGRACAO_DES < DATEADD(HOUR, -6, GETDATE()) THEN '1-PROBLEMA'
			WHEN DES.MAX_DTH_MIGRACAO_DES < DATEADD(HOUR, -1, GETDATE()) THEN (CASE WHEN EMB.MAX_DTH_MIGRACAO_EMB < DATEADD(HOUR, -6, GETDATE()) THEN '1-PROBLEMA'
																					WHEN EMB.MAX_DTH_MIGRACAO_EMB < DATEADD(HOUR, -1, GETDATE()) THEN (CASE WHEN MOV.MAX_DTH_MIGRACAO_MOV < DATEADD(HOUR, -6, GETDATE()) THEN '1-PROBLEMA'
																																							WHEN MOV.MAX_DTH_MIGRACAO_MOV < DATEADD(HOUR, -1, GETDATE()) THEN '2-ATENÇÃO'
																																							ELSE '3-OK'
																																						END)
																				    ELSE '3-OK'
			                                                                    END)
			ELSE '3-OK'			
		END FLG_VALIDADOR
  FROM	(SELECT	SIG_AEROPORTO
			 ,	MAX(DTH_MIGRACAO) AS MAX_DTH_MIGRACAO_DES
		  FROM	IEOP..IEOP_DESEMBARQUE WITH (NOLOCK)
		 GROUP
			BY	SIG_AEROPORTO) DES,
		(SELECT	SIG_AEROPORTO
			 ,	MAX(DTH_MIGRACAO) AS MAX_DTH_MIGRACAO_EMB
		  FROM	IEOP..IEOP_EMBARQUE WITH (NOLOCK)
		 GROUP
			BY	SIG_AEROPORTO) EMB,
		(SELECT	SIG_AEROPORTO
			 ,	MAX(DTH_MIGRACAO) AS MAX_DTH_MIGRACAO_MOV
		  FROM	IEOP..IEOP_MOVIMENTACAO WITH (NOLOCK)
		 GROUP
			BY	SIG_AEROPORTO) MOV
 WHERE	DES.SIG_AEROPORTO = EMB.SIG_AEROPORTO
   AND	EMB.SIG_AEROPORTO = MOV.SIG_AEROPORTO
   AND  DES.SIG_AEROPORTO NOT IN ('SBGR', 'SBNT')
 ORDER
    BY	6 ASC
	 ,  1 ASC


/*

DECLARE @tableHTML  NVARCHAR(MAX) ;
DECLARE @DATA VARCHAR(30);

SELECT @DATA = CONVERT(VARCHAR(10), GETDATE(), 103) + ' - ' + CONVERT(VARCHAR(10), GETDATE(), 108)

SET @tableHTML =
    N'<H1>Relatório da Migração do IEOP</H1>' +
    N'<H2>Favor verificar a Migração do IEOP nos aeroportos com:</H2>' +
    N'<H3>   1) Se qualquer das Datas de Migração estiverem menor que a data/hora: ' + @DATA + ' => o job do aeroporto não está sendo executado; ou</H3>' +
	N'<H3>   2) Não houve voo operando no aeroporto. Para checar essa informação, favor entrar em contato com o aeroporto.</H3>' +
	N'<H3>   3) Status com "ATENÇÃO" significa que o aeroporto não enviou informações novas até a 3 horas atras.</H3>' +
	N'<H3>   4) Status com "PROBLEMA" significa que o aeroporto não enviou informações novas até a 6 horas atras.</H3>' +
    N'<H3>   OBS.: Mensagem enviada automaticamente. Favor não responder.</H3>' +
    N'<table border="1">' +
    N'<tr><th>Sigla do Aeroporto</th><th>Data da Migração - Desmbarque</th><th>Data da Migração - Embarque</th><th>Data da Migração - Movimentação</th><th>Status</th></tr>' +
    CAST ( ( SELECT	td = XML.SIG_AEROPORTO, ''
				 ,	td = XML.MAX_DTH_MIGRACAO_DES, ''
				 ,	td = XML.MAX_DTH_MIGRACAO_EMB, ''
				 ,	td = XML.MAX_DTH_MIGRACAO_MOV, ''
				 ,  td = SUBSTRING(XML.STATUS,3, 10), ''
				FROM (
					SELECT	DES.SIG_AEROPORTO
						 ,	CONVERT(VARCHAR(10), ISNULL(DES.MAX_DTH_MIGRACAO_DES, ''), 103) + ' - ' + CONVERT(VARCHAR(10), ISNULL(DES.MAX_DTH_MIGRACAO_DES, ''), 108) AS MAX_DTH_MIGRACAO_DES
						 ,	CONVERT(VARCHAR(10), ISNULL(EMB.MAX_DTH_MIGRACAO_EMB, ''), 103) + ' - ' + CONVERT(VARCHAR(10), ISNULL(EMB.MAX_DTH_MIGRACAO_EMB, ''), 108) AS MAX_DTH_MIGRACAO_EMB
						 ,	CONVERT(VARCHAR(10), ISNULL(MOV.MAX_DTH_MIGRACAO_MOV, ''), 103) + ' - ' + CONVERT(VARCHAR(10), ISNULL(MOV.MAX_DTH_MIGRACAO_MOV, ''), 108) AS MAX_DTH_MIGRACAO_MOV
						 ,	CASE
										WHEN DES.MAX_DTH_MIGRACAO_DES < DATEADD(HOUR, -6, GETDATE()) THEN '1-PROBLEMA'
										WHEN DES.MAX_DTH_MIGRACAO_DES < DATEADD(HOUR, -1, GETDATE()) THEN (CASE WHEN EMB.MAX_DTH_MIGRACAO_EMB < DATEADD(HOUR, -6, GETDATE()) THEN '1-PROBLEMA'
																												WHEN EMB.MAX_DTH_MIGRACAO_EMB < DATEADD(HOUR, -1, GETDATE()) THEN (CASE WHEN MOV.MAX_DTH_MIGRACAO_MOV < DATEADD(HOUR, -6, GETDATE()) THEN '1-PROBLEMA'
																																														WHEN MOV.MAX_DTH_MIGRACAO_MOV < DATEADD(HOUR, -1, GETDATE()) THEN '2-ATENÇÃO'
																																														ELSE '3-OK'
																																													END)
																												ELSE '3-OK'
																											END)
										ELSE '3-OK'			
									 END AS STATUS
						  FROM	(SELECT	SIG_AEROPORTO
									 ,	MAX(DTH_MIGRACAO) AS MAX_DTH_MIGRACAO_DES
								  FROM	IEOP..IEOP_DESEMBARQUE WITH (NOLOCK)
								 GROUP
									BY	SIG_AEROPORTO) DES,
								(SELECT	SIG_AEROPORTO
									 ,	MAX(DTH_MIGRACAO) AS MAX_DTH_MIGRACAO_EMB
								  FROM	IEOP..IEOP_EMBARQUE WITH (NOLOCK)
								 GROUP
									BY	SIG_AEROPORTO) EMB,
								(SELECT	SIG_AEROPORTO
									 ,	MAX(DTH_MIGRACAO) AS MAX_DTH_MIGRACAO_MOV
								  FROM	IEOP..IEOP_MOVIMENTACAO WITH (NOLOCK)
								 GROUP
									BY	SIG_AEROPORTO) MOV
						 WHERE	DES.SIG_AEROPORTO = EMB.SIG_AEROPORTO
						   AND	EMB.SIG_AEROPORTO = MOV.SIG_AEROPORTO
						   AND  DES.SIG_AEROPORTO NOT IN ('SBGR', 'SBNT')
						 ) AS XML
					 ORDER
						BY	XML.STATUS ASC
						 ,	XML.SIG_AEROPORTO ASC
						 ,  XML.MAX_DTH_MIGRACAO_DES ASC
						 ,	XML.MAX_DTH_MIGRACAO_EMB ASC
						 ,	XML.MAX_DTH_MIGRACAO_MOV ASC
              FOR XML PATH('tr'), TYPE 
    ) AS NVARCHAR(MAX) ) +
    N'</table>' ;



exec msdb.dbo.sp_send_dbmail @recipients='denis_andrade@infraero.gov.br; romulocruz@infraero.gov.br; pabloperdomo@infraero.gov.br',
		@subject = 'Relatório da Monit da Migração do IEOP',
		@body = @tableHTML,
        @body_format = 'HTML',
		@profile_name='DBA',        
		@importance='high';

*/


/*

DECLARE @xml NVARCHAR(MAX)
DECLARE @body NVARCHAR(MAX)


SELECT @xml = CAST ( ( SELECT	td = DES.SIG_AEROPORTO, ''
				 ,	td = CONVERT(VARCHAR(10), ISNULL(DES.MAX_DTH_MIGRACAO_DES, ''), 103) + ' - ' + CONVERT(VARCHAR(10), ISNULL(DES.MAX_DTH_MIGRACAO_DES, ''), 108), ''
				 ,	td = CONVERT(VARCHAR(10), ISNULL(EMB.MAX_DTH_MIGRACAO_EMB, ''), 103) + ' - ' + CONVERT(VARCHAR(10), ISNULL(EMB.MAX_DTH_MIGRACAO_EMB, ''), 108), ''
				 ,	td = CONVERT(VARCHAR(10), ISNULL(MOV.MAX_DTH_MIGRACAO_MOV, ''), 103) + ' - ' + CONVERT(VARCHAR(10), ISNULL(MOV.MAX_DTH_MIGRACAO_MOV, ''), 108), ''
				 ,  td = CASE
							WHEN DES.MAX_DTH_MIGRACAO_DES < DATEADD(HOUR, -6, GETDATE()) THEN 'PROBLEMA'
							WHEN DES.MAX_DTH_MIGRACAO_DES < DATEADD(HOUR, -1, GETDATE()) THEN (CASE WHEN EMB.MAX_DTH_MIGRACAO_EMB < DATEADD(HOUR, -6, GETDATE()) THEN 'PROBLEMA'
																									WHEN EMB.MAX_DTH_MIGRACAO_EMB < DATEADD(HOUR, -1, GETDATE()) THEN (CASE WHEN MOV.MAX_DTH_MIGRACAO_MOV < DATEADD(HOUR, -6, GETDATE()) THEN 'PROBLEMA'
																																											WHEN MOV.MAX_DTH_MIGRACAO_MOV < DATEADD(HOUR, -1, GETDATE()) THEN 'ATENÇÃO'
																																											ELSE 'OK'
																																										END)
																									ELSE 'OK'
																								END)
							ELSE 'OK'			
						 END, ''
			  FROM	(SELECT	SIG_AEROPORTO
						 ,	MAX(DTH_MIGRACAO) AS MAX_DTH_MIGRACAO_DES
					  FROM	IEOP..IEOP_DESEMBARQUE WITH (NOLOCK)
					 GROUP
						BY	SIG_AEROPORTO) DES,
					(SELECT	SIG_AEROPORTO
						 ,	MAX(DTH_MIGRACAO) AS MAX_DTH_MIGRACAO_EMB
					  FROM	IEOP..IEOP_EMBARQUE WITH (NOLOCK)
					 GROUP
						BY	SIG_AEROPORTO) EMB,
					(SELECT	SIG_AEROPORTO
						 ,	MAX(DTH_MIGRACAO) AS MAX_DTH_MIGRACAO_MOV
					  FROM	IEOP..IEOP_MOVIMENTACAO WITH (NOLOCK)
					 GROUP
						BY	SIG_AEROPORTO) MOV
			 WHERE	DES.SIG_AEROPORTO = EMB.SIG_AEROPORTO
			   AND	EMB.SIG_AEROPORTO = MOV.SIG_AEROPORTO
			   AND  DES.SIG_AEROPORTO NOT IN ('SBGR', 'SBNT')
			 ORDER
				BY	DES.MAX_DTH_MIGRACAO_DES ASC
				 ,	EMB.MAX_DTH_MIGRACAO_EMB ASC
				 ,	MOV.MAX_DTH_MIGRACAO_MOV ASC
              FOR XML PATH('tr'), ELEMENTS ) AS NVARCHAR(MAX))


SET @body ='<html><body><H3>Tennis Rankings Info</H3>
<table border = 1> 
<tr><th>Sigla do Aeroporto</th><th>Data da Migração - Desmbarque</th><th>Data da Migração - Embarque</th><th>Data da Migração - Movimentação</th><th>Status</th></tr>'    

 
SET @body = @body + @xml +'</table></body></html>'


EXEC msdb.dbo.sp_send_dbmail
@profile_name = 'DBA', -- replace with your SQL Database Mail Profile 
@body = @body,
@body_format ='HTML',
@recipients = 'denis_andrade@infraero.gov.br', -- replace with your email address
@subject = 'E-mail in Tabular Format',       
@importance='high';




*/