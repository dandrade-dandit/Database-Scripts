SELECT TOP 1000 *
  FROM [msdb].[dbo].[sysmail_faileditems]
   ORDER BY [sent_date] DESC
   
   
SELECT TOP 1000 *
  FROM [msdb].[dbo].[sysmail_sentitems]
 ORDER BY [sent_date] DESC
 
SELECT TOP 1000 *
  FROM [msdb].[dbo].[sysmail_unsentitems]
  
--http://www.idevelopment.info/data/SQLServer/DBA_tips/Database_Administration/DBA_20.shtml

xp_cmdshell 'copy \\10.0.99.223\temp$\logo.JPG E:\temp\ /Y'

xp_cmdshell 'dir E:\temp\'


EXEC msdb.dbo.sp_send_dbmail
@profile_name = 'APC', -- replace with your SQL Database Mail Profile 
@body = '<head>
<title> Embedded Logo Example</title>
<meta name="Generator" content="EditPlus">
<meta name="Author" content="">
<meta name="Keywords" content="">
<meta name="Description" content="">
</head>
<body>
<table>
<tr><td valign="top" align="left"><img src="cid:logo.JPG" width="800" height="50" border="0" alt=""></td></tr>
<tr><td>
<PRE>
Resposta - Reclamação feita em 02/02/2015 as 11:00

Nome: ddasfsda

e-mail: fds

Reclamação: dsdsdads

Resposta: faffdsf

Atenciosamente,
Aeroporto de Congonhas
</PRE>
</td></tr>
</table>
</body>',
@body_format ='HTML',
@recipients = 'vitormoura@infraero.gov.br', -- replace with your email address
@subject = 'Infraero - Avaliação de Ponto Comercial - Aeroporto de Congonhas',
@file_attachments = N'E:\temp\logo.JPG';