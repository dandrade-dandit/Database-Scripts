col lmode format 9999999999999
col request format 9999999999999
COL SESS FORMAT A15
SELECT INST_ID,DECODE(request,0,'Holder: ','Waiter: ')||sid sess,
         id1, id2, lmode, request, type
    FROM GV$LOCK
   WHERE (INST_ID,id1, id2, type) IN
             (SELECT INST_ID,id1, id2, type FROM GV$LOCK WHERE request>0)
   ORDER BY  ID1,request
/


