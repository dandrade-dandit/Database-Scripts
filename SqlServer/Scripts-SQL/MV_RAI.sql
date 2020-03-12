--
--**************************************************************************************
DROP INDEX "IFRMYSAR"."IDX_TRAFFIC_01";

CREATE INDEX "IFRMYSAR"."IDX_TRAFFIC_01" ON "IFRMYSAR"."TRAFFIC"
    ("DATA", "IP") TABLESPACE "TSI_MYSAR_HIST" ;

DROP INDEX "IFRMYSAR"."IDX_TRAFFIC_02";

CREATE INDEX "IFRMYSAR"."IDX_TRAFFIC_02" ON "IFRMYSAR"."TRAFFIC"
    ("USERSID", "SITESID", "IP") TABLESPACE "TSI_MYSAR_HIST" ;

--**************************************************************************************
SELECT  id, data, to_char(time, 'hh24:mi:ss') hora, url, authuser, sitesid, usersid, bytes, ip
  FROM  IFRMYSAR.TRAFFIC
 WHERE  AUTHUSER = 'i9459763'
   AND  SITESID = 335882
   order by 2, 3
   
   
SELECT  min(to_char(time, 'dd/mm/yyyy hh24:mi:ss')) min_hora
     ,  max(to_char(time, 'dd/mm/yyyy hh24:mi:ss')) max_hora
     ,  (((max(time)-min(time))*24)*60)*60 tempo_toral
  FROM  IFRMYSAR.TRAFFIC
 WHERE  AUTHUSER = 'i9459763'
   AND  SITESID = 335882

SELECT  sum(bytes) sum_bytes
     ,  (((max(time)-min(time))*24)*60)*60 tempo_toral
  FROM  IFRMYSAR.TRAFFIC
 WHERE  AUTHUSER = 'i9459763'
   AND  SITESID = 335882

--**************************************************************************************

SELECT  id, data, to_char(time, 'hh24:mi:ss') hora, url, authuser, sitesid, usersid, bytes, ip
  FROM  IFRMYSAR.TRAFFIC
 WHERE  usersid = 2302
   AND  SITESID = 9858
   AND  IP = 167797727
   order by 2, 3

select *
  from IFRMYSAR.users
 where id = 1237
   
select *
  from IFRMYSAR.hostnames
 where ip = 168171699
 
select  distinct usersid, authuser, data
  FROM  IFRMYSAR.TRAFFIC
 WHERE  data = to_date('01/06/2011','DD/MM/YYYY')
   and  ip = 168171699
   and  authuser != '-'


SELECT USERSID,
  MATRICULA,
  IP,
  HOSTNAME,
  DATA,
  to_char(HORA_INICIO, 'dd/mm/yyyy hh24:mi:ss') hora_ini,
  to_char(HORA_FIM, 'dd/mm/yyyy hh24:mi:ss') hora_fim,
  SITESID,
  SITE,
  BYTES,
  SUM_TIME
FROM IFRMYSAR.TAB_DADOS_DETALHADOS ;


--**************************************************************************************
--TESTE -> www.beautive.com - INICIO ÀS 22:24 e FIM ÀS 22:27 DO DIA 23/06/2011
--
--RESULTADO -> 22:23:58	22:26:46	168	284148

SELECT  id, data, to_char(time, 'hh24:mi:ss') hora, url, authuser, sitesid, usersid, bytes, ip
  FROM  IFRMYSAR.TRAFFIC
 WHERE  data = to_date('23/06/2011','DD/MM/YYYY')
   and  IP = 167797727
   AND  SITESID = 455746
   order by 2, 3;
   
select *
  from IFRMYSAR.users
 where id = 1237
   
select *
  from IFRMYSAR.hostnames
 where ip = 167797727
 
SELECT *
  FROM IFRMYSAR.SITES
 WHERE SITE like '%www.beautive.com%'


SELECT      min(to_char(time, 'hh24:mi:ss')) min_hora
       ,    max(to_char(time, 'hh24:mi:ss')) max_hora
       ,    nvl((((max(time)-min(time))*24)*60)*60,0) tempo_toral
       ,    nvl(sum(bytes),0) sum_bytes
    FROM    IFRMYSAR.TRAFFIC
   WHERE    usersid = 21119
     AND    sitesid =455746
     AND    ip = 167797727; 
 
--**************************************************************************************

SELECT USERSID,
  MATRICULA,
  IP,
  HOSTNAME,
  DATA,
  to_char(HORA_INICIO, 'hh24:mi:ss') hora_ini,
  to_char(HORA_FIM, 'hh24:mi:ss') hora_fim,
  SITESID,
  SITE,
  BYTES,
  SUM_TIME
FROM IFRMYSAR.TAB_DADOS_DETALHADOS 
--WHERE MATRICULA = 'i1190738';


SELECT MATRICULA, IP, DATA, SITESID, COUNT(1) TOTAL
FROM (SELECT USERSID,
  MATRICULA,
  IP,
  HOSTNAME,
  DATA,
  MIN(to_char(HORA_INICIO, 'hh24:mi:ss')) hora_ini,
  MAX(to_char(HORA_FIM, 'hh24:mi:ss')) hora_fim,
  SITESID,
  SITE,
  SUM(BYTES) BYTES,
  SUM(SUM_TIME) SUM_TIME
FROM IFRMYSAR.TAB_DADOS_DETALHADOS_TMP
GROUP
   BY USERSID,
  MATRICULA,
  IP,
  HOSTNAME,
  DATA,
  SITESID,
  SITE) A
GROUP BY MATRICULA, IP, DATA, SITESID 
HAVING COUNT(1) > 1
--WHERE MATRICULA = 'i1190738';


SELECT USERSID,
  MATRICULA,
  IP,
  HOSTNAME,
  DATA,
  MIN(to_char(HORA_INICIO, 'hh24:mi:ss')) hora_ini,
  MAX(to_char(HORA_FIM, 'hh24:mi:ss')) hora_fim,
  SITESID,
  SITE,
  SUM(BYTES) BYTES,
  SUM(SUM_TIME) SUM_TIME
FROM IFRMYSAR.TAB_DADOS_DETALHADOS_TMP
WHERE MATRICULA = 'i0222663'
  AND IP = 168305671
  AND DATA = to_date('01/06/2011','DD/MM/YYYY')
  AND to_char(HORA_INICIO, 'hh24:mi:ss') = '17:19:52'
  AND SITESID = 10024
GROUP
   BY USERSID,
  MATRICULA,
  IP,
  HOSTNAME,
  DATA,
  SITESID,
  SITE;

--**************************************************************************************

SELECT T.AUTHUSER, S.DATA, S.SITE, SUM(ts.summarytime) TEMPO_TOTAL
  FROM IFRMYSAR.trafficsummaries TS
     , IFRMYSAR.SITES S
     , IFRMYSAR.TRAFFIC T
WHERE  T.SITESID = S.ID
  AND  S.ID = ts.sitesid
  AND  T.AUTHUSER = 'i9459763'
  AND  S.SITE = 'http://www.gizmodo.com.br/'
GROUP BY T.AUTHUSER, S.DATA, S.SITE

SELECT  id, data, to_char(time, 'hh24:mi:ss') hora, url, authuser, sitesid, usersid, bytes, ip
  FROM  IFRMYSAR.TRAFFIC
 WHERE  usersid = 1237
   AND  SITESID = 9995
   order by 2, 3

select  distinct
        data
     ,  ip
     ,  usersid
     ,  sitesid
  from  IFRMYSAR.trafficsummaries
 where  data = to_date('01/06/2011','DD/MM/YYYY')
 order
    by  usersid
     ,  sitesid
     
     
select *
  from IFRMYSAR.users
 where id = 1237
   
select *
  from IFRMYSAR.hostnames
 where ip = 167798826
 
select distinct usersid, authuser, data
   FROM  IFRMYSAR.TRAFFIC
 WHERE  data = to_date('01/06/2011','DD/MM/YYYY')
   and  ip = 167798826
   and  authuser != '-'
 
 
 
  

SELECT S.DATA, S.SITE, SUM(ts.summarytime) TEMPO_TOTAL
  FROM IFRMYSAR.trafficsummaries TS
     , IFRMYSAR.SITES S
WHERE  S.ID = ts.sitesid
  AND S.SITE = 'http://www.gizmodo.com.br/'
GROUP BY S.DATA, S.SITE
ORDER BY 1
   
   
SELECT  matricula
     ,  site
     ,  round(bytes/1024,2) total_MBytes
  FROM  mv_dados_consolidados
 WHERE  matricula = 'i1190738'
 ORDER 
    BY  3 DESC
    
SELECT  *
  FROM  mv_dados_detalhados
 WHERE  matricula = 'i9459763'
   AND  site = 'http://s.glbimg.com/'
 ORDER
    BY  2 DESC
    
    
SELECT S.DATA, S.SITE, SUM(ts.summarytime) TEMPO_TOTAL
  FROM IFRMYSAR.trafficsummaries TS
     , IFRMYSAR.SITES S
WHERE  S.ID = ts.sitesid
  AND S.SITE = 'http://www.gizmodo.com.br/'
GROUP BY S.DATA, S.SITE
ORDER BY 1

select * from dba_jobs


select * from cadastros where emp_nome like 'MANOEL GIME%'


select * from tab_interface_idm where num_matricula = '1686013'

--*******************************************************************************
--UPDATE IFRMYSAR.trafficsummaries SET FLG_MIGRADO = 1 WHERE FLG_MIGRADO = 0

SELECT COUNT(1)
  FROM IFRMYSAR.trafficsummaries
 WHERE FLG_MIGRADO = 0
 --WHERE data != to_date('25/06/2011','DD/MM/YYYY')
 
 
--ALTER TABLE IFRMYSAR.TAB_DADOS_DETALHADOS_TMP ADD FLG_MIGRADO NUMBER(1) DEFAULT 0;
--create index idx_TAB_DADOS_DET_TMP_01 on TAB_DADOS_DETALHADOS_TMP(FLG_MIGRADO) tablespace tsi_mysar_hist;
--UPDATE IFRMYSAR.TAB_DADOS_DETALHADOS_TMP SET FLG_MIGRADO = 1 WHERE FLG_MIGRADO = 0;
--*******************************************************************************

SELECT DISTINCT
    VUI.MATRICULA,
    NVL(VUI.NOME, 'Não Autenticado') USUARIO,
    NVL(VDM.DEP_SIGLA, 'Não informada') DEPENDENCIA,
    NVL(VUM.UOR_SIGLA, 'Não informada') LOTACAO,
    TO_CHAR(T.DATA, 'YYYY') ANO,
    TO_CHAR(T.DATA, 'MM') MES,
    ROUND(SUM(T.BYTES)/1024/1024, 0) AS BYTES
FROM VIW_USUARIOS_IDM VUI
  right JOIN IFRMYSAR.TAB_DADOS_DETALHADOS T 
   ON VUI.MATRICULA = T.MATRICULA
  LEFT JOIN VIW_DEPENDENCIAS_MYSAR VDM
   ON VUI.DEPENDENCIA = VDM.DEP_CODIGO
  LEFT JOIN VIW_UOR_MYSAR VUM
   ON VUI.LOTACAO = VUM.UOR_CODIGO
--WHERE T.MATRICULA = 'Não Autenticado'
GROUP BY VUI.MATRICULA, NVL(VUI.NOME, 'Não Autenticado'), NVL(VDM.DEP_SIGLA, 'Não informada'), NVL(VUM.UOR_SIGLA, 'Não informada'), TO_CHAR(T.DATA, 'YYYY'), TO_CHAR(T.DATA, 'MM')
ORDER BY BYTES DESC

--****************************************************************************************************************
--LIXO MIGRAÇÃO RAI - ARQUIVO 1
--
SELECT MATRICULA, IP, DATA, SITESID, COUNT(1) TOTAL
FROM (SELECT USERSID,
  MATRICULA,
  IP,
  HOSTNAME,
  DATA,
  MIN(to_char(HORA_INICIO, 'hh24:mi:ss')) hora_ini,
  MAX(to_char(HORA_FIM, 'hh24:mi:ss')) hora_fim,
  SITESID,
  SITE,
  SUM(BYTES) BYTES,
  SUM(SUM_TIME) SUM_TIME
FROM IFRMYSAR.TAB_DADOS_DETALHADOS_TMP
GROUP
   BY USERSID,
  MATRICULA,
  IP,
  HOSTNAME,
  DATA,
  SITESID,
  SITE) A
GROUP BY MATRICULA, IP, DATA, SITESID 
HAVING COUNT(1) > 1
--WHERE MATRICULA = 'i1190738';


SELECT USERSID,
  MATRICULA,
  IP,
  HOSTNAME,
  DATA,
  MIN(to_char(HORA_INICIO, 'hh24:mi:ss')) hora_ini,
  MAX(to_char(HORA_FIM, 'hh24:mi:ss')) hora_fim,
  SITESID,
  SITE,
  SUM(BYTES) BYTES,
  SUM(SUM_TIME) SUM_TIME
FROM IFRMYSAR.TAB_DADOS_DETALHADOS_TMP
WHERE MATRICULA = 'i0222663'
  AND IP = 168305671
  AND DATA = to_date('01/06/2011','DD/MM/YYYY')
  AND to_char(HORA_INICIO, 'hh24:mi:ss') = '17:19:52'
  AND SITESID = 10024
GROUP
   BY USERSID,
  MATRICULA,
  IP,
  HOSTNAME,
  DATA,
  SITESID,
  SITE;

--****************************************************************************************************************
--LIXO MIGRAÇÃO RAI - ARQUIVO 2
--
SELECT DATA, COUNT(1)
FROM IFRMYSAR.TAB_DADOS_DETALHADOS_TMP
GROUP BY DATA
ORDER BY DATA;

SELECT DATA, COUNT(1)
  FROM IFRMYSAR.trafficsummaries
 WHERE FLG_MIGRADO = 0
 GROUP BY DATA
 ORDER BY DATA;

--UPDATE IFRMYSAR.trafficsummaries SET FLG_MIGRADO = 1 WHERE FLG_MIGRADO = 0

SELECT COUNT(1)
  FROM IFRMYSAR.trafficsummaries
 WHERE FLG_MIGRADO = 0
 --WHERE data != to_date('25/06/2011','DD/MM/YYYY')

select  distinct
        data
     ,  ip
     ,  usersid
     ,  sitesid
  from  IFRMYSAR.trafficsummaries
--sample  (2)
 where  data = to_date('13/06/2011','DD/MM/YYYY')
   and  ip = 4294967295
 order
    by  usersid
     ,  sitesid;
     
select *
  from  IFRMYSAR.traffic
--sample  (2)
 where  data = to_date('20/06/2011','DD/MM/YYYY')
   and  ip = 167825970

--****************************************************************************************************************
--LIXO MIGRAÇÃO RAI - ARQUIVO 3
--
SELECT DISTINCT USERSID,
  MATRICULA,
  IP,
  HOSTNAME,
  DATA,
  to_char(HORA_INICIO, 'hh24:mi:ss') hora_ini,
  to_char(HORA_FIM, 'hh24:mi:ss') hora_fim,
  SITESID,
  SITE,
  BYTES,
  SUM_TIME
FROM IFRMYSAR.TAB_DADOS_DETALHADOS_TMP
WHERE DATA = to_date('13/06/2011','DD/MM/YYYY')
--MATRICULA = 'i1190738'
--ORDER BY DATA DESC, 7;

/*
 select  distinct 
        usersid
     ,  authuser
  from  IFRMYSAR.TRAFFIC
 where  data = to_date('20/06/2011','DD/MM/YYYY') --to_date(nData,'DD/MM/YYYY')
   and  ip in (167825970) 
 order 
    by  2 desc;

--
167797031
167797057
167797002
167799577
167799567
167798151

select ip, count(1) from (
 select  distinct 
        usersid
     ,  authuser
     ,  ip
  from  IFRMYSAR.TRAFFIC
 where  data = to_date('20/06/2011','DD/MM/YYYY') --to_date(nData,'DD/MM/YYYY')
   and  ip in (167825970) ) a
group by ip
 order 
    by  2 desc;
*/


--****************************************************************************************************************
--LIXO MIGRAÇÃO RAI - ARQUIVO 4
--
SELECT SITE, COUNT(1)
FROM IFRMYSAR.TAB_DADOS_DETALHADOS_TMP
WHERE DATA = to_date('13/06/2011','DD/MM/YYYY')
GROUP BY SITE
ORDER BY 2 DESC;

SELECT MATRICULA, COUNT(1)
FROM IFRMYSAR.TAB_DADOS_DETALHADOS_TMP
WHERE DATA = to_date('13/06/2011','DD/MM/YYYY')
  --AND SITE = 'http://www.google-analytics.com/'
GROUP BY MATRICULA
ORDER BY 2 DESC;

SELECT *
FROM IFRMYSAR.TAB_DADOS_DETALHADOS_TMP
WHERE DATA = to_date('13/06/2011','DD/MM/YYYY')
  AND SITE = 'http://www.google-analytics.com/'

SELECT *
FROM IFRMYSAR.TAB_DADOS_DETALHADOS_TMP
WHERE DATA = to_date('13/06/2011','DD/MM/YYYY')
  AND SITE = 'http://www.google-analytics.com/'
  AND MATRICULA = 'i1123757'
 
select  ip
     ,  count(1)
  from  IFRMYSAR.TRAFFIC
 where  data = to_date('13/06/2011','DD/MM/YYYY')
 group
    by  ip
 order 
    by  2 desc; 
 
select   
        usersid
     ,  authuser
     ,  ip
     , count(1)
  from  IFRMYSAR.TRAFFIC
 where  data = to_date('13/06/2011','DD/MM/YYYY')
 group
    by  usersid
     ,  authuser
     ,  ip
 order 
    by  4 desc;
  
SELECT  id, data, to_char(time, 'hh24:mi:ss') hora, url, authuser, sitesid, usersid, bytes, ip
  FROM  IFRMYSAR.TRAFFIC
 WHERE  data = to_date('13/06/2011','DD/MM/YYYY')
   --and  IP = 167798538
   --AND  SITESID = 82156
   --order by 2, 3;
   
select *
  from IFRMYSAR.hostnames
 where hostname like 's-%infraero%' order by hostname desc
 where ip in ( 167797031 )



--****************************************************************************************************************
--LIXO MIGRAÇÃO RAI - ARQUIVO 5
--
SELECT MATRICULA, SITE, COUNT(1)
FROM IFRMYSAR.TAB_DADOS_DETALHADOS_TMP
WHERE DATA = to_date('13/06/2011','DD/MM/YYYY')
GROUP BY MATRICULA, SITE
ORDER BY 3 DESC, 1;

/*

SELECT  USERSID,
        MATRICULA,
        IP,
        HOSTNAME,
        DATA,
        to_char(HORA_INICIO, 'hh24:mi:ss') hora_ini,
        to_char(HORA_FIM, 'hh24:mi:ss') hora_fim,
        SITESID,
        SITE,
        BYTES,
        SUM_TIME
  FROM IFRMYSAR.TAB_DADOS_DETALHADOS_TMP
 WHERE DATA = to_date('13/06/2011','DD/MM/YYYY')
   AND MATRICULA = 'biblioteca'
   AND SITE = 'http://www.google-analytics.com/';
   
SELECT 	USERSID,
			  MATRICULA,
			  IP,
			  HOSTNAME,
			  DATA,
			  to_char(MIN(HORA_INICIO), 'hh24:mi:ss') hora_ini,
        to_char(MAX(HORA_FIM), 'hh24:mi:ss') hora_fim,
			  SITESID,
			  SITE,
			  SUM(BYTES) BYTES,
			  --SUM(SUM_TIME) SUM_TIME
			  ROUND(nvl((((MAX(HORA_FIM)-MIN(HORA_INICIO))*24)*60)*60,0),0) SUM_TIME
FROM IFRMYSAR.TAB_DADOS_DETALHADOS_TMP
WHERE DATA = to_date('13/06/2011','DD/MM/YYYY')
   AND MATRICULA = 'i1367817'
--   AND SITE = 'http://www.google-analytics.com/'
GROUP
   BY USERSID,
		  MATRICULA,
		  IP,
		  HOSTNAME,
		  DATA,
		  SITESID,
		  SITE
/

i1367817
t724119881
i1411556
i9459763

SELECT *
  FROM IFRMYSAR.sites
 WHERE DATA = to_date('13/06/2011','DD/MM/YYYY')
 
SELECT DISTINCT
    VUI.MATRICULA,
    NVL(VUI.NOME, 'Não Autenticado') USUARIO,
    NVL(VDM.DEP_SIGLA, 'Não informada') DEPENDENCIA,
    NVL(VUM.UOR_SIGLA, 'Não informada') LOTACAO,
    TO_CHAR(T.DATA, 'YYYY') ANO,
    TO_CHAR(T.DATA, 'MM') MES,
    ROUND(SUM(T.BYTES)/1024/1024, 0) AS BYTES
FROM VIW_USUARIOS_IDM VUI
  right JOIN (
            SELECT 	USERSID,
                    MATRICULA,
                    IP,
                    HOSTNAME,
                    DATA,
                    MIN(HORA_INICIO) hora_ini,
                    MAX(HORA_FIM) hora_fim,
                    SITESID,
                    SITE,
                    SUM(BYTES) BYTES,
                    --SUM(SUM_TIME) SUM_TIME
                    ROUND(nvl((((MAX(HORA_FIM)-MIN(HORA_INICIO))*24)*60)*60,0),0) SUM_TIME
            FROM IFRMYSAR.TAB_DADOS_DETALHADOS_TMP
            GROUP
               BY USERSID,
                  MATRICULA,
                  IP,
                  HOSTNAME,
                  DATA,
                  SITESID,
                  SITE
    ) T 
   ON VUI.MATRICULA = T.MATRICULA
  LEFT JOIN VIW_DEPENDENCIAS_MYSAR VDM
   ON VUI.DEPENDENCIA = VDM.DEP_CODIGO
  LEFT JOIN VIW_UOR_MYSAR VUM
   ON VUI.LOTACAO = VUM.UOR_CODIGO
GROUP BY VUI.MATRICULA, NVL(VUI.NOME, 'Não Autenticado'), NVL(VDM.DEP_SIGLA, 'Não informada'), NVL(VUM.UOR_SIGLA, 'Não informada'), TO_CHAR(T.DATA, 'YYYY'), TO_CHAR(T.DATA, 'MM')
ORDER BY BYTES DESC;

*/

--**************************************************************************************************************
--NOVAS MV
--
--**************************************************************************************
--DROP MV ANTIGA
--**************************************************************************************
--DROP MV ANTIGA
DROP MATERIALIZED VIEW "IFRMYSAR"."MV_DADOS_RESUMIDOS" 
/

--CRIAR NOVA MV
CREATE MATERIALIZED VIEW "IFRMYSAR"."MV_DADOS_RESUMIDOS" 
TABLESPACE TSD_MYSAR_HIST
REFRESH COMPLETE
START WITH SYSDATE
NEXT SYSDATE + 1 AS
SELECT DISTINCT
       VUI.MATRICULA
     , NVL(VUI.NOME, 'Não Autenticado') USUARIO
     , NVL(VDM.DEP_SIGLA, 'Não informada') DEPENDENCIA
     , NVL(VUM.UOR_SIGLA, 'Não informada') LOTACAO
     , TO_CHAR(T.DATA, 'YYYY') ANO
     , TO_CHAR(T.DATA, 'MM') MES
     , ROUND(SUM(T.BYTES)/1024, 0) AS BYTES
  FROM VIW_USUARIOS_IDM VUI
       RIGHT JOIN IFRMYSAR.TRAFFIC T
   						 ON VUI.MATRICULA = T.AUTHUSER
  		 LEFT JOIN VIW_DEPENDENCIAS_MYSAR VDM
   						 ON VUI.DEPENDENCIA = VDM.DEP_CODIGO
  			LEFT JOIN VIW_UOR_MYSAR VUM
   						ON VUI.LOTACAO = VUM.UOR_CODIGO
 WHERE T.DATA >= TO_DATE('18/07/2011','DD/MM/YYYY')
   AND T.RESULTCODE != 'TCP_DENIED/403'
 GROUP 
    BY VUI.MATRICULA
     , NVL(VUI.NOME, 'Não Autenticado')
     , NVL(VDM.DEP_SIGLA, 'Não informada')
     , NVL(VUM.UOR_SIGLA, 'Não informada')
     , TO_CHAR(T.DATA, 'YYYY')
     , TO_CHAR(T.DATA, 'MM')
/

--GRANTS
grant select on MV_DADOS_RESUMIDOS to rl_mysar_consulta;

grant select on MV_DADOS_RESUMIDOS to rl_mysar_admin;

--CRIAÇÃO DOS ÍNDICES
create index idx_mv_dados_resumidos_01 on mv_dados_resumidos(ano) tablespace tsi_mysar_hist;

create index idx_mv_dados_resumidos_02 on mv_dados_resumidos(mes) tablespace tsi_mysar_hist;

create index idx_mv_dados_resumidos_03 on mv_dados_resumidos(lotacao) tablespace tsi_mysar_hist;

create index idx_mv_dados_resumidos_04 on mv_dados_resumidos(dependencia) tablespace tsi_mysar_hist;

create index idx_mv_dados_resumidos_05 on mv_dados_resumidos(matricula) tablespace tsi_mysar_hist;

--
--**************************************************************************************
--DROP MV ANTIGA  
DROP MATERIALIZED VIEW "IFRMYSAR"."MV_DADOS_CONSOLIDADOS" 
/

--CRIAR NOVA MV
CREATE MATERIALIZED VIEW "IFRMYSAR"."MV_DADOS_CONSOLIDADOS" 
TABLESPACE TSD_MYSAR_HIST
PARALLEL 4
BUILD IMMEDIATE
REFRESH COMPLETE
START WITH SYSDATE
NEXT SYSDATE + 1 AS
SELECT DISTINCT
    	 T.AUTHUSER MATRICULA
     , S.SITE
     , TO_CHAR(T.DATA, 'YYYY') ANO
     , TO_CHAR(T.DATA, 'MM') MES
     , ROUND(SUM(T.BYTES)/1024, 0) AS BYTES
  FROM TRAFFIC T 
       INNER JOIN SITES S 
               ON S.ID = T.SITESID
 WHERE T.DATA >= TO_DATE('18/07/2011','DD/MM/YYYY')
   AND T.RESULTCODE != 'TCP_DENIED/403'
 GROUP 
    BY T.AUTHUSER
     , S.SITE 
     , TO_CHAR(T.DATA, 'YYYY')
     , TO_CHAR(T.DATA, 'MM')
/

--GRANTS
grant select on MV_DADOS_CONSOLIDADOS to rl_mysar_consulta;

grant select on MV_DADOS_CONSOLIDADOS to rl_mysar_admin;

--CRIAÇÃO DOS ÍNDICES
create index idx_MV_DADOS_CONSOLIDADOS_01 on MV_DADOS_CONSOLIDADOS(MATRICULA, ANO, MES) tablespace tsi_mysar_hist;

--
--**************************************************************************************
--DROP MV ANTIGA
DROP MATERIALIZED VIEW "IFRMYSAR"."MV_DADOS_DETALHADOS" 
/

--CRIAR NOVA MV
CREATE MATERIALIZED VIEW "IFRMYSAR"."MV_DADOS_DETALHADOS" 
TABLESPACE TSD_MYSAR_HIST
PARALLEL 4
BUILD IMMEDIATE
REFRESH COMPLETE
START WITH SYSDATE
NEXT SYSDATE + 1 AS
SELECT T.AUTHUSER MATRICULA
     , T.DATA
     , T.SITESID
     , S.SITE
     , TO_CHAR(T.DATA, 'YYYY') ANO
     , TO_CHAR(T.DATA, 'MM') MES
     , ROUND(SUM(T.BYTES)/1024, 0) AS BYTES
  FROM TRAFFIC T 
     	 INNER JOIN SITES S 
             	 ON S.ID = T.SITESID
 WHERE T.DATA >= TO_DATE('18/07/2011','DD/MM/YYYY')
   AND T.RESULTCODE != 'TCP_DENIED/403'
 GROUP 
    BY T.AUTHUSER
     , T.DATA
     , T.SITESID
     , S.SITE
     , TO_CHAR(T.DATA, 'YYYY')
     , TO_CHAR(T.DATA, 'MM')
/

--GRANTS
grant select on MV_DADOS_DETALHADOS to rl_mysar_consulta;

grant select on MV_DADOS_DETALHADOS to rl_mysar_admin;

--CRIAÇÃO DOS ÍNDICES
create index idx_MV_DADOS_DETALHADOS_01 on MV_DADOS_DETALHADOS(MATRICULA, SITE, ANO, MES) tablespace tsi_mysar_hist;

--
--**************************************************************************************

--
--**************************************************************************************
--****************************************
VARIABLE jobno number;
BEGIN
DBMS_JOB.SUBMIT(:jobno,'dbms_refresh.refresh(''"IFRMYSAR"."MV_DADOS_DETALHADOS"'');',
to_date('21/08/2011 02:00:00', 'DD/MM/YYYY HH24:MI:SS'), 'SYSDATE + 1');
commit;
END;
/ 


VARIABLE jobno number;
BEGIN
   DBMS_JOB.CHANGE(408, 'dbms_refresh.refresh(''"IFRMYSAR"."MV_DADOS_RESUMIDOS"'');', to_date('07/08/2011 01:00:00', 'DD/MM/YYYY HH24:MI:SS'), 'SYSDATE + 1');
   commit;
END;
/

VARIABLE jobno number;
BEGIN
   DBMS_JOB.CHANGE(423, 'dbms_refresh.refresh(''"IFRMYSAR"."MV_DADOS_CONSOLIDADOS"'');', to_date('07/08/2011 01:30:00', 'DD/MM/YYYY HH24:MI:SS'), 'SYSDATE + 1');
   commit;
END;
/

VARIABLE jobno number;
BEGIN
   DBMS_JOB.CHANGE(445, 'dbms_refresh.refresh(''"IFRMYSAR"."MV_DADOS_DETALHADOS"'');', to_date('07/08/2011 02:00:00', 'DD/MM/YYYY HH24:MI:SS'), 'SYSDATE + 1');
   commit;
END;
/


--1 GRUPO
VARIABLE jobno number;
BEGIN
	dbms_job.broken(364, FALSE, to_date('22/07/2011 00:30:00', 'DD/MM/YYYY HH24:MI:SS'));
commit;
END;
/

VARIABLE jobno number;
BEGIN
	dbms_job.broken(363, FALSE, to_date('22/07/2011 01:30:00', 'DD/MM/YYYY HH24:MI:SS'));
commit;
END;
/

VARIABLE jobno number;
BEGIN
	dbms_job.broken(365, FALSE, to_date('22/07/2011 02:30:00', 'DD/MM/YYYY HH24:MI:SS'));
commit;
END;
/


--2 GRUPO
VARIABLE jobno number;
BEGIN
	dbms_job.broken(408, FALSE, to_date('17/08/2011 02:30:00', 'DD/MM/YYYY HH24:MI:SS'));
commit;
END;
/

VARIABLE jobno number;
BEGIN
	dbms_job.broken(423, FALSE, to_date('17/08/2011 03:00:00', 'DD/MM/YYYY HH24:MI:SS'));
commit;
END;
/

VARIABLE jobno number;
BEGIN
	dbms_job.broken(446, FALSE, to_date('22/08/2011 02:00:00', 'DD/MM/YYYY HH24:MI:SS'));
commit;
END;
/

VARIABLE jobno number;
BEGIN
   DBMS_JOB.run(346);
   commit;
END;
/

VARIABLE jobno number;
BEGIN
   DBMS_JOB.run(347);
   commit;
END;
/

VARIABLE jobno number;
BEGIN
   DBMS_JOB.run(348);
   commit;
END;
/


VARIABLE jobno number;
BEGIN
   DBMS_JOB.remove(445);
   commit;
END;
/

select * from dba_jobs where log_user = 'IFRMYSAR'


--CREATE USER USR_MYSAR IDENTIFIED BY VALUES '56925AF4A82A9368';

--GRANT RL_MYSAR_CONSULTA TO USR_MYSAR;

-- DROP USER USR_MYSAR CASCADE;

--ALTER USER USR_MYSAR IDENTIFIED BY TESTE;

EXEC dbms_refresh.refresh('"IFRMYSAR"."MV_DADOS_RESUMIDOS"');


EXEC dbms_refresh.refresh('"IFRMYSAR"."MV_DADOS_CONSOLIDADOS"');


EXEC dbms_refresh.refresh('"IFRMYSAR"."MV_DADOS_DETALHADOS"');


--************************************************************************************************
--VALIDAR DUPLICAÇÃO

SELECT * 
--DELETE
FROM IFRMYSAR.TAB_DADOS_DETALHADOS
WHERE (USERSID,
         MATRICULA,
         IP,
         HOSTNAME,
         DATA,
         HORA_INICIO,
         HORA_FIM,
         SITESID,
         SITE)
IN (
 SELECT  USERSID,
         MATRICULA,
         IP,
         HOSTNAME,
         DATA,
         HORA_INICIO,
         HORA_FIM,
         SITESID,
         SITE
 FROM IFRMYSAR.TAB_DADOS_DETALHADOS
 WHERE data >= to_date('29/06/2011','DD/MM/YYYY')
 INTERSECT
SELECT DISTINCT
        USERSID,
         MATRICULA,
         IP,
         HOSTNAME,
         DATA,
         HORA_INICIO,
         HORA_FIM,
         SITESID,
         SITE
 FROM (
 SELECT  DISTINCT
         USERSID,
         MATRICULA,
         IP,
         HOSTNAME,
         DATA,
         MIN(HORA_INICIO) HORA_INICIO,
         MAX(HORA_FIM) hora_fim,
         SITESID,
         SITE,
         SUM(BYTES) BYTES,
         ROUND(nvl((((MAX(HORA_FIM)-MIN(HORA_INICIO))*24)*60)*60,0),0) SUM_TIME
 FROM IFRMYSAR.TAB_DADOS_DETALHADOS_TMP
 WHERE FLG_MIGRADO = 0
 GROUP
    BY USERSID,
       MATRICULA,
       IP,
       HOSTNAME,
       DATA,
       SITESID,
       SITE) A )
ORDER BY BYTES DESC;


--CONTINUAÇÃO
select  DATA, COUNT(1) TOTAL
  from  IFRMYSAR.TAB_DADOS_DETALHADOS_TMP
--update IFRMYSAR.trafficsummaries set FLG_MIGRADO = 9
 where  data >= to_date('01/06/2011','DD/MM/YYYY')
   and  FLG_MIGRADO = 0
   and  ip != 4294967295
GROUP BY DATA
ORDER BY DATA DESC;  