SET LINESIZE 150
SET PAGESIZE 150
SELECT  TABLESPACE_NAME as "Nome do Tablespace"
     ,  ALLOCATED_BYTES as "Espaço Alocado em GB"
     ,  ROUND(ALLOCATED_BYTES - FREE,2) as "Espaço Usado em GB"
     ,  ROUND(FREE,2) as "Espaço Livre em GB"
     ,  ROUND((((ALLOCATED_BYTES-FREE)*100/ALLOCATED_BYTES)),2) as "% de Uso"
  FROM (SELECT  A.TABLESPACE_NAME
             ,  SUM(A.BYTES)/1024/1024 ALLOCATED_BYTES
             ,  SUM(B.FREE_BYTES)/1024/1024 FREE 
          FROM  DBA_DATA_FILES A  
             , (SELECT FILE_ID
                     , SUM(BYTES) FREE_BYTES
                  FROM DBA_FREE_SPACE B 
                 GROUP 
                    BY FILE_ID) B
         WHERE  A.FILE_ID=B.FILE_ID 
         GROUP 
            BY  A.TABLESPACE_NAME
         ORDER 
            BY  A.TABLESPACE_NAME)
 ORDER 
    BY  5 DESC
/