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