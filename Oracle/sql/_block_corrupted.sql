alter system set "_DB_ALWAYS_CHECK_SYSTEM_TS"=false;
alter system set  db_block_checksum=false;
Select   obj#,actionsize 
from sys.trigger$ 
where dbms_rowid.rowid_block_number(rowid) = 36487 and dbms_rowid.rowid_relative_fno(rowid) = 1;
alter system set "_DB_ALWAYS_CHECK_SYSTEM_TS"=true;
alter system set  db_block_checksum=true;


select header_file,header_block from dba_segments where segment_name='TRIGGER$';

oradebug setmypid
alter system dump datafile 1 block 36487;
alter system dump datafile 1 block 601;
oradebug tracefile_name;

