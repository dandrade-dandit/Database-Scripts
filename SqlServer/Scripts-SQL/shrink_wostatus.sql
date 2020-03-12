set timing on
set serveroutput on

spo log_shrink_rebuild_wostatus.log

exec dbms_output.put_line( 'INICIO');

exec dbms_output.put_line( 'TAMANHO DOS SEGMENTOS WOSTATUS ANTES DO SHRINK');
SELECT SEGMENT_NAME, OWNER, (SUM(BYTES)/1024/1024) AS "TOTAL EM MB"
FROM DBA_EXTENTS
WHERE TABLESPACE_NAME  IN ('TSD_MAXIMO', 'TSI_MAXIMO')
AND SEGMENT_TYPE = 'TABLE'
AND SEGMENT_NAME = 'WOSTATUS'
GROUP BY SEGMENT_NAME, OWNER;


SELECT SEGMENT_NAME, OWNER, (SUM(BYTES)/1024/1024) AS "TOTAL EM MB"
FROM DBA_EXTENTS
WHERE TABLESPACE_NAME IN ('TSD_MAXIMO', 'TSI_MAXIMO')
AND SEGMENT_TYPE = 'INDEX'
AND SEGMENT_NAME LIKE '%WOSTATUS%'
GROUP BY SEGMENT_NAME, OWNER;

exec dbms_output.put_line( 'alter table wostatus enable row movement;');
alter table wostatus enable row movement;

exec dbms_output.put_line( 'alter table wostatus shrink space;');
alter table wostatus shrink space;

exec dbms_output.put_line( 'alter index WOSTATUS_NDX1 rebuild online;');
alter index WOSTATUS_NDX1 rebuild online;

exec dbms_output.put_line( 'alter index WOSTATUS_NDX2 rebuild online;');
alter index WOSTATUS_NDX2 rebuild online;

exec dbms_output.put_line( 'alter index WOSTATUS_NDX3 rebuild online;');
alter index WOSTATUS_NDX3 rebuild online;


exec dbms_output.put_line( 'TAMANHO DOS SEGMENTOS WOSTATUS DEPOIS DO SHRINK');
SELECT SEGMENT_NAME, OWNER, (SUM(BYTES)/1024/1024) AS "TOTAL EM MB"
FROM DBA_EXTENTS
WHERE TABLESPACE_NAME  IN ('TSD_MAXIMO', 'TSI_MAXIMO')
AND SEGMENT_TYPE = 'TABLE'
AND SEGMENT_NAME = 'WOSTATUS'
GROUP BY SEGMENT_NAME, OWNER;


SELECT SEGMENT_NAME, OWNER, (SUM(BYTES)/1024/1024) AS "TOTAL EM MB"
FROM DBA_EXTENTS
WHERE TABLESPACE_NAME IN ('TSD_MAXIMO', 'TSI_MAXIMO')
AND SEGMENT_TYPE = 'INDEX'
AND SEGMENT_NAME LIKE '%WOSTATUS%'
GROUP BY SEGMENT_NAME, OWNER;
 
exec dbms_output.put_line( 'FIM');

spo off

