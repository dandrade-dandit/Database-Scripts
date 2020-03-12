SELECT	convert(varchar(10), Event_Timestamp, 103) as DATA
,		convert(varchar(10), Event_Timestamp, 108) as HORA
,		Substring(User_Name, 13, 100) as USUÁRIO       
,       RIGHT('00' + CONVERT(VARCHAR(2), ROUND(SUM(convert(float,Acct_Session_Time)/60/60), 0)),2) + ':' +
        RIGHT('00' + CONVERT(VARCHAR(2), ( FLOOR(SUM(convert(float,Acct_Session_Time)/60)) -  (FLOOR(SUM(convert(float,Acct_Session_Time)/60/60))*60) )),2) + ':' +
        RIGHT('00' + CONVERT(VARCHAR(2), ( SUM(convert(float,Acct_Session_Time)) -  (FLOOR(SUM(convert(float,Acct_Session_Time)/60))*60) )),2) AS TEMPO
,		SUM(convert(float,Acct_Session_Time)) AS TOTAL
FROM	[IASODBC].[dbo].[accounting_data]
WHERE	Acct_Session_Id IS NOT NULL
AND		Acct_Status_Type = 2
AND		month(timestamp) = 8
AND		year(timestamp) = 2010
AND     SUBSTRING(Client_IP_Address, 1, 5) = '10.6.' 
AND		Substring(Called_Station_Id, 19, 30) LIKE 'vex%'
GROUP BY 
		convert(varchar(10), Event_Timestamp, 103) 
,		convert(varchar(10), Event_Timestamp, 108)
,		Substring(User_Name, 13, 100)
ORDER BY 1, 2