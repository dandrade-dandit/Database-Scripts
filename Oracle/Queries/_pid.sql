SELECT PID 
FROM V$PROCESS 
WHERE ADDR=         
         (SELECT PADDR  
          FROM V$SESSION 
          WHERE SID=&1)
/
