Step 1: detect the corrupt blocks
Query the view v$database_block_corruption to detect the corrupt blocks. (You will 
usually also see an entry in the alertfile. However, in this particular case there was no 
alertfile entry.) 
SQL> select * from v$database_block_corruption; 
     FILE#     BLOCK#     BLOCKS CORRUPTION_CHANGE# CORRUPTIO 
 --------- ------------------ ---------- ---------- ----------
       395     106431          1                  0 FRACTURED 


Step 2: determine if it is an index or table block
SQL> select tablespace_name, segment_type, owner, segment_name 
from dba_extents 
where file_id = 395 and 106431 between block_id and block_id + 
blocks-1; 
TABLESPACE_NAME  SEGMENT_TYPE    OWNER            SEGMENT_NAME 
 ---------------------------------------------------------------------------
PROD_DATA        TABLE           PROD_USER        PROD_INTERFACE 
In this case the object is a table. 


Step 3: determine if the corrupt block is an empty table block
select * from prod_user.prod_interface where 
dbms_rowid.rowid_block_number(rowid)=395; 
If this query returns no rows than the block is empty. If the query returns an error that 
the block is corrupt, than the block is not empty. 
An alternative approach to check is the following query: 
select distinct DBMS_ROWID.ROWID_BLOCK_NUMBER(rowid) from 
gl.gl_interface order by 1 desc; 
Then check if the corrupt blocknumber is part of the blocknumbers returned by the 
query. 


Step 4: In case the corrupt block is not empty: perform a block recovery with rman: 
Rman> configure channel device type sbt format '%d_%s_%t_%p' 
PARMS 'ENV=(NSR_SERVER=nlprod02,NSR_GROUP=Customer_PROD)'; 
Rman> blockrecover datafile 395 block 106431;   

Step 5: DBMS_REPAIR

http://download.oracle.com/docs/cd/B28359_01/server.111/b28310/repair004.htm