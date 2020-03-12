set verify off
COL SEGMENT_NAME FORMAT A45
COL TABLESPACE_NAME FORMAT A30
ACCEPT 2 CHAR PROMPT 'ENTRE COM O SID: '

SELECT * FROM X$KGLLK LOCK_A   
WHERE KGLLKREQ = 0
    AND EXISTS (SELECT LOCK_B.KGLLKHDL FROM X$KGLLK LOCK_B
                WHERE KGLLKSES in (select saddr from v$session where sid = &2) /* BLOCKED SESSION */
                AND LOCK_A.KGLLKHDL = LOCK_B.KGLLKHDL                
                AND KGLLKREQ > 0);   
                
/* If we look a bit further we can then again match KGLLKSES with SADDR */  
/* in v$session to find further information on the blocking session: */

SELECT SID,USERNAME,TERMINAL,PROGRAM FROM V$SESSION  
WHERE SADDR in    
   (SELECT KGLLKSES FROM X$KGLLK LOCK_A     
   WHERE KGLLKREQ = 0      
   AND EXISTS (SELECT LOCK_B.KGLLKHDL FROM X$KGLLK LOCK_B                  
               WHERE KGLLKSES in (select saddr from v$session where sid = &2) /* BLOCKED SESSION */                  
               AND LOCK_A.KGLLKHDL = LOCK_B.KGLLKHDL                  
               AND KGLLKREQ > 0)   
);   
               
/* In the same way we can also find all the blocked sessions:   */

SELECT SID,USERNAME,TERMINAL,PROGRAM FROM V$SESSION  
WHERE SADDR in    
   (SELECT KGLLKSES FROM X$KGLLK LOCK_A     
   WHERE KGLLKREQ > 0      
   AND EXISTS (SELECT LOCK_B.KGLLKHDL FROM X$KGLLK LOCK_B                  
               WHERE KGLLKSES in (select saddr from v$session where sid = &2) /* 'saddr_from_v$session' - BLOCKING SESSION */                  
               AND LOCK_A.KGLLKHDL = LOCK_B.KGLLKHDL                  
               AND KGLLKREQ = 0)   
); 