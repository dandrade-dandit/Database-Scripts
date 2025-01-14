insert into RELPROXY..traffic
SELECT ltrim(rtrim([Col001])) ip
      ,ltrim(rtrim(Col003)) usuario
      ,SUBSTRING(Col004,2,30) data_hora
      ,SUBSTRING(SUBSTRING(Col004,2,11),8,4) +
        CASE SUBSTRING(SUBSTRING(Col004,2,11),4,3)
          WHEN 'Jan' THEN '01'
          WHEN 'Fev' THEN '02'
          WHEN 'Mar' THEN '03'
          WHEN 'Apr' THEN '04'
          WHEN 'May' THEN '05'
          WHEN 'Jun' THEN '06'
          WHEN 'Jul' THEN '07'
          WHEN 'Agu' THEN '08'
          WHEN 'Set' THEN '09'
          WHEN 'Oct' THEN '10'
          WHEN 'Nov' THEN '11'
          WHEN 'Dec' THEN '12'
         END
      + SUBSTRING(SUBSTRING(Col004,2,11),1,2) as data
      ,SUBSTRING(Col004,14,11) as hora
      ,ltrim(rtrim(Col006)) url
      ,ltrim(rtrim([Col007])) resultCode
      ,ltrim(rtrim(Col008)) bytes
      , null
  FROM RELPROXY.[dbo].[log_sede_Jun]

/*
CREATE TABLE RELPROXY..traffic (
  ip varchar(20)
, usuario varchar(30)
, data_hora_txt varchar(30)
, data datetime
, hora datetime
, url varchar(max)
, resultcode int
, bytes bigint)



*/