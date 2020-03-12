 select * from sys.dba_2pc_pending ;


execute DBMS_TRANSACTION.PURGE_LOST_DB_ENTRY('27.88.90208'); <==== the transaction ID in your case is different of course


