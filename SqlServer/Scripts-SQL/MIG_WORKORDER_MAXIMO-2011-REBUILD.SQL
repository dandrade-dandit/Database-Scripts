set timing on
set serveroutput on

spo log_shrink_rebuild_workorder.log

exec dbms_output.put_line( 'INICIO');

exec dbms_output.put_line( 'TAMANHO DOS SEGMENTOS WORKORDER ANTES DO SHRINK');
SELECT SEGMENT_NAME, OWNER, (SUM(BYTES)/1024/1024) AS "TOTAL EM MB"
FROM DBA_EXTENTS
WHERE TABLESPACE_NAME  IN ('TSD_MAXIMO', 'TSI_MAXIMO')
AND SEGMENT_TYPE = 'TABLE'
AND SEGMENT_NAME = 'WORKORDER'
GROUP BY SEGMENT_NAME, OWNER;


SELECT SEGMENT_NAME, OWNER, (SUM(BYTES)/1024/1024) AS "TOTAL EM MB"
FROM DBA_EXTENTS
WHERE TABLESPACE_NAME IN ('TSD_MAXIMO', 'TSI_MAXIMO')
AND SEGMENT_TYPE = 'INDEX'
AND SEGMENT_NAME LIKE '%WORKORDER%'
GROUP BY SEGMENT_NAME, OWNER;

exec dbms_output.put_line( 'alter table workorder enable row movement;');
alter table workorder enable row movement;

exec dbms_output.put_line( 'alter table workorder shrink space;');
alter table workorder shrink space;

exec dbms_output.put_line( 'alter index WORKORDER_NDX1 rebuild online;');
alter index WORKORDER_NDX1 rebuild online;

exec dbms_output.put_line( 'alter index WORKORDER_NDX12 rebuild online;');
alter index WORKORDER_NDX12 rebuild online;

exec dbms_output.put_line( 'alter index WORKORDER_NDX2 rebuild online;');
alter index WORKORDER_NDX2 rebuild online;

exec dbms_output.put_line( 'alter index WORKORDER_NDX3 rebuild online;');
alter index WORKORDER_NDX3 rebuild online;

exec dbms_output.put_line( 'alter index WORKORDER_NDX4 rebuild online;');
alter index WORKORDER_NDX4 rebuild online;

exec dbms_output.put_line( 'alter index WORKORDER_NDX5 rebuild online;');
alter index WORKORDER_NDX5 rebuild online;

exec dbms_output.put_line( 'alter index WORKORDER_NDX6 rebuild online;');
alter index WORKORDER_NDX6 rebuild online;

exec dbms_output.put_line( 'alter index WORKORDER_NDX7 rebuild online;');
alter index WORKORDER_NDX7 rebuild online;

exec dbms_output.put_line( 'alter index WORKORDER_NDX8 rebuild online;');
alter index WORKORDER_NDX8 rebuild online;

exec dbms_output.put_line( 'alter index WORKORDER_NDX9 rebuild online;');
alter index WORKORDER_NDX9 rebuild online;

exec dbms_output.put_line( 'alter index WORKORDER_NDX10 rebuild online;');
alter index WORKORDER_NDX10 rebuild online;

exec dbms_output.put_line( 'alter index WORKORDER_NDX11 rebuild online;');
alter index WORKORDER_NDX11 rebuild online;

exec dbms_output.put_line( 'alter index WORKORDER_NDX13 rebuild online;');
alter index WORKORDER_NDX13 rebuild online;

exec dbms_output.put_line( 'alter index WORKORDER_NDX14 rebuild online;');
alter index WORKORDER_NDX14 rebuild online;

exec dbms_output.put_line( 'alter index WORKORDER_NDX15 rebuild online;');
alter index WORKORDER_NDX15 rebuild online;

exec dbms_output.put_line( 'alter index WORKORDER_NDX16 rebuild online;');
alter index WORKORDER_NDX16 rebuild online;

exec dbms_output.put_line( 'alter index WORKORDER_NDX17 rebuild online;');
alter index WORKORDER_NDX17 rebuild online;

exec dbms_output.put_line( 'alter index WORKORDER_NDX18 rebuild online;');
alter index WORKORDER_NDX18 rebuild online;

exec dbms_output.put_line( 'alter index WORKORDER_NDX19 rebuild online;');
alter index WORKORDER_NDX19 rebuild online;

exec dbms_output.put_line( 'CREATE MATERIALIZED VIEW IFRMAXIMO.VIW_RELATORIOS');
CREATE MATERIALIZED VIEW "IFRMAXIMO"."VIW_RELATORIOS" ("WONUM", "STATUS", "LOCATION", "EQNUM2", "EQNUM", "HSFUNCIONA", "SUPERINT", "REPORTDATE", "STATUSDATE", "LOCATION_FEC", "LOCATION2", "DESCRIPTION", "DESCSUBSISTEMA", "WO19", "ACTSTART", "ACTFINISH", "WOPM7", "GLACCOUNT", "ACTLABCOST", "ACTLABHRS", "WO4", "W05", "WO7", "WO8", "WO15", "WORKTYPE") ORGANIZATION HEAP PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 NOCOMPRESS LOGGING STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645 PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT) TABLESPACE "TSD_MAXIMO" BUILD IMMEDIATE USING INDEX REFRESH FORCE ON DEMAND USING DEFAULT LOCAL ROLLBACK SEGMENT USING ENFORCED CONSTRAINTS DISABLE QUERY REWRITE
AS
  SELECT VIW_OS_FECHADA.WONUM,
    VIW_OS_FECHADA.STATUS,
    VIW_EQUIPAMENT.LOCATION,
    VIW_EQUIPAMENT.EQNUM2,
    VIW_EQUIPAMENT.EQNUM,
    VIW_DEPENDENCIA_SUPERINT.HSFUNCIONA,
    VIW_DEPENDENCIA_SUPERINT.SUPERINT,
    VIW_OS_FECHADA.REPORTDATE,
    VIW_OS_FECHADA.STATUSDATE,
    VIW_OS_FECHADA.LOCATION AS LOCATION_FEC,
    VIW_EQUIPAMENT.LOCATION2,
    EQUIPAMENTO.DESCRIPTION,
    EQUIPAMENTO.DESCSUBSISTEMA,
    VIW_OS_FECHADA.WO19,
    VIW_OS_FECHADA.ACTSTART,
    VIW_OS_FECHADA.ACTFINISH,
    VIW_EQUIPAMENT.WOPM7,
    VIW_OS_FECHADA.GLACCOUNT,
    VIW_OS_FECHADA.ACTLABCOST,
    VIW_OS_FECHADA.ACTLABHRS,
    VIW_OS_FECHADA.WO4,
    VIW_OS_FECHADA.W05,
    VIW_OS_FECHADA.WO7,
    VIW_OS_FECHADA.WO8,
    VIW_OS_FECHADA.WO15,
    VIW_OS_FECHADA.WORKTYPE
  FROM IFRMAXIMO.VIW_EQUIPAMENT VIW_EQUIPAMENT,
    IFRMAXIMO.EQUIPAMENTO EQUIPAMENTO,
    IFRMAXIMO.VIW_DEPENDENCIA_SUPERINT VIW_DEPENDENCIA_SUPERINT,
    IFRMAXIMO.VIW_OS_FECHADA VIW_OS_FECHADA
  WHERE ( (VIW_EQUIPAMENT.EQNUM2 = EQUIPAMENTO.EQNUM)
  AND (VIW_EQUIPAMENT.LOCATION2  = EQUIPAMENTO.SUBSISTEMA))
  AND (VIW_EQUIPAMENT.WOPM7      = VIW_DEPENDENCIA_SUPERINT.WOPM7)
  AND ( (VIW_EQUIPAMENT.EQNUM    = VIW_OS_FECHADA.EQNUM(+))
  AND (VIW_EQUIPAMENT.WOPM7      = VIW_OS_FECHADA.WOPM7(+)))
/

exec dbms_output.put_line( 'TAMANHO DOS SEGMENTOS WORKORDER DEPOIS DO SHRINK');
SELECT SEGMENT_NAME, OWNER, (SUM(BYTES)/1024/1024) AS "TOTAL EM MB"
FROM DBA_EXTENTS
WHERE TABLESPACE_NAME  IN ('TSD_MAXIMO', 'TSI_MAXIMO')
AND SEGMENT_TYPE = 'TABLE'
AND SEGMENT_NAME = 'WORKORDER'
GROUP BY SEGMENT_NAME, OWNER;


SELECT SEGMENT_NAME, OWNER, (SUM(BYTES)/1024/1024) AS "TOTAL EM MB"
FROM DBA_EXTENTS
WHERE TABLESPACE_NAME IN ('TSD_MAXIMO', 'TSI_MAXIMO')
AND SEGMENT_TYPE = 'INDEX'
AND SEGMENT_NAME LIKE '%WORKORDER%'
GROUP BY SEGMENT_NAME, OWNER;
 
exec dbms_output.put_line( 'FIM');

spo off