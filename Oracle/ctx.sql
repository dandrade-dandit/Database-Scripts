UNRECOVERABLE LOAD data

ctxsrv -user ctxsys/intermedia_portal_infra_01 -logfile /ora05/inet/log
ctxsrv -user ctxsys/intermedia_portal_infra_01 -personality M -log /ora05/inet/ctxsrv.log & 


You can simply use a BEFORE SHUTDOWN TRIGGER created in the  CTXSYS schema that calls CTX_ADM.SHUTDOWN.  
Here is an example:  
CREATE OR REPLACE TRIGGER Stop_CtxSrv  
BEFORE SHUTDOWN ON DATABASE  
  BEGIN      
    Ctx_Adm.Shutdown();  
  END; 
/    


ctx_ddl.sync_index('<indexname>'); 
