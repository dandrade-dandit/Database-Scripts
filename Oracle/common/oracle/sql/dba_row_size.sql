-- +----------------------------------------------------------------------------+
-- |                          Jeffrey M. Hunter                                 |
-- |                      jhunter@idevelopment.info                             |
-- |                         www.idevelopment.info                              |
-- |----------------------------------------------------------------------------|
-- |      Copyright (c) 1998-2009 Jeffrey M. Hunter. All rights reserved.       |
-- |----------------------------------------------------------------------------|
-- | DATABASE : Oracle                                                          |
-- | FILE     : dba_row_size.sql                                                |
-- | CLASS    : Database Administration                                         |
-- | PURPOSE  : Determines the row sizes for all tables in a given schema.      |
-- | NOTE     : As with any code, ensure to test this script in a development   |
-- |            environment before attempting to run it in production.          |
-- +----------------------------------------------------------------------------+

Accept INTAB prompt 'Enter Table Schema Owner (i.e. SCOTT) : '

SET LINESIZE 135
SET PAGESIZE 999

COLUMN Tot_Size   FORMAT 99,999
COLUMN data_type  FORMAT a15

BREAK ON table_name SKIP 2

COMPUTE SUM OF Tot_Size    ON table_name
COMPUTE SUM OF data_length ON table_name

SELECT
    table_name
  , column_name
  , DECODE(    DATA_TYPE
             , 'NUMBER'   , DATA_PRECISION+DATA_SCALE
             , 'VARCHAR2' , TO_NUMBER(DATA_LENGTH)
             , 'CHAR'     , TO_NUMBER(DATA_LENGTH)
             , 'DATE'     , TO_NUMBER(DATA_LENGTH)) Tot_Size
  , DATA_TYPE
FROM      all_tab_columns
WHERE     owner = UPPER('&INTAB')
ORDER BY  table_name
        , column_id
/
