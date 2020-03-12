-- +----------------------------------------------------------------------------+
-- |                          Jeffrey M. Hunter                                 |
-- |                      jhunter@idevelopment.info                             |
-- |                         www.idevelopment.info                              |
-- |----------------------------------------------------------------------------|
-- |      Copyright (c) 1998-2009 Jeffrey M. Hunter. All rights reserved.       |
-- |----------------------------------------------------------------------------|
-- | DATABASE : Oracle                                                          |
-- | FILE     : dba_index_stats.sql                                             |
-- | CLASS    : Database Administration                                         |
-- | PURPOSE  : Report index statistics.                                        |
-- | NOTE     : As with any code, ensure to test this script in a development   |
-- |            environment before attempting to run it in production.          |
-- +----------------------------------------------------------------------------+

SET LINESIZE 145
SET PAGESIZE 9999
SET VERIFY   OFF

DEF index_owner    = &&index_owner
DEF index_name     = &&index_name
  
TTITLE -  
  LEFT  'Index Statistics'  skip 2  
  
SET HEADING off  
  
COL name   newline  
COL headsep              newline  
COL height               newline  
COL blocks               newline  
COL lf_rows              newline  
COL lf_blks        	 newline  
COL lf_rows_len          newline  
COL lf_blk_len           newline  
COL br_rows              newline  
COL br_blks              newline  
COL br_rows_len          newline  
COL br_blk_len           newline  
COL del_lf_rows          newline  
COL del_lf_rows_len      newline  
COL distinct_keys        newline  
COL most_repeated_key    newline  
COL btree_space          newline  
COL used_space    	 newline  
COL pct_used             newline  
COL rows_per_key         newline  
COL blks_gets_per_access newline  
  
validate index &index_owner..&index_name;  
  

SELECT  
  name,  
  '----------------------------------------------------------'    headsep,  
  'height               '||to_char(height,     '999,999,990')     height,  
  'blocks               '||to_char(blocks,     '999,999,990')     blocks,  
  'del_lf_rows          '||to_char(del_lf_rows,'999,999,990')     del_lf_rows,  
  'del_lf_rows_len      '||to_char(del_lf_rows_len,'999,999,990') del_lf_rows_len,  
  'distinct_keys        '||to_char(distinct_keys,'999,999,990')   distinct_keys,  
  'most_repeated_key    '||to_char(most_repeated_key,'999,999,990') most_repeated_key,  
  'btree_space          '||to_char(btree_space,'999,999,990')       btree_space,  
  'used_space           '||to_char(used_space,'999,999,990')        used_space,  
  'pct_used                     '||to_char(pct_used,'990')          pct_used,  
  'rows_per_key         '||to_char(rows_per_key,'999,999,990')      rows_per_key,  
  'blks_gets_per_access '||to_char(blks_gets_per_access,'999,999,990') blks_gets_per_access,  
  'lf_rows      '||to_char(lf_rows,    '999,999,990')||'        '||+  
  'br_rows      '||to_char(br_rows,    '999,999,990')                  br_rows,  
  'lf_blks      '||to_char(lf_blks,    '999,999,990')||'        '||+  
  'br_blks      '||to_char(br_blks,    '999,999,990')                  br_blks,  
  'lf_rows_len  '||to_char(lf_rows_len,'999,999,990')||'        '||+  
  'br_rows_len  '||to_char(br_rows_len,'999,999,990')                  br_rows_len,  
  'lf_blk_len   '||to_char(lf_blk_len, '999,999,990')||'        '||+  
  'br_blk_len   '||to_char(br_blk_len, '999,999,990')                br_blk_len  
FROM  
  index_stats  
/  

  
UNDEF index_owner  
UNDEF index_name  

set verify on


