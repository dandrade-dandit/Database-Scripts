--abertas  
--OK
INSERT INTO ifrmaximo.wostatus_temp
SELECT *
  FROM IFRMAXIMO.WOSTATUS
  WHERE WONUM IN ( 
  SELECT WONUM
    FROM IFRMAXIMO.WORKORDER
    WHERE siteid = 'INFRAERO'
    AND  status not in ('FECHADO', 'CAN')
    and reportdate >= TO_DATE ('01/05/2010', 'DD/MM/YYYY')
    and reportdate < TO_DATE ('13/05/2010', 'DD/MM/YYYY')
    )
    
--OK
INSERT INTO ifrmaximo.wostatus_temp
SELECT *
  FROM IFRMAXIMO.WOSTATUS
  WHERE WONUM IN ( 
  SELECT WONUM 
    FROM IFRMAXIMO.WORKORDER
    WHERE siteid = 'INFRAERO'
    AND  status not in ('FECHADO', 'CAN')
    and reportdate >= TO_DATE ('01/04/2010', 'DD/MM/YYYY')
    and reportdate < TO_DATE ('01/05/2010', 'DD/MM/YYYY')
    )
--OK
INSERT INTO ifrmaximo.wostatus_temp    
SELECT *
  FROM IFRMAXIMO.WOSTATUS
  WHERE WONUM IN ( 
  SELECT WONUM
    FROM IFRMAXIMO.WORKORDER
    WHERE siteid = 'INFRAERO'
    AND  status not in ('FECHADO', 'CAN')
    and reportdate >= TO_DATE ('01/03/2010', 'DD/MM/YYYY')
    and reportdate < TO_DATE ('01/04/2010', 'DD/MM/YYYY')
    )
--OK
INSERT INTO ifrmaximo.wostatus_temp    
SELECT *
  FROM IFRMAXIMO.WOSTATUS
  WHERE WONUM IN ( 
  SELECT WONUM 
    FROM IFRMAXIMO.WORKORDER
    WHERE siteid = 'INFRAERO'
    AND  status not in ('FECHADO', 'CAN')
    and reportdate >= TO_DATE ('01/02/2010', 'DD/MM/YYYY')
    and reportdate < TO_DATE ('01/03/2010', 'DD/MM/YYYY')
    )        
--OK
INSERT INTO ifrmaximo.wostatus_temp    
SELECT *
  FROM IFRMAXIMO.WOSTATUS
  WHERE WONUM IN ( 
  SELECT WONUM
    FROM IFRMAXIMO.WORKORDER
    WHERE siteid = 'INFRAERO'
    AND  status not in ('FECHADO', 'CAN')
    and reportdate >= TO_DATE ('01/01/2010', 'DD/MM/YYYY')
    and reportdate < TO_DATE ('01/02/2010', 'DD/MM/YYYY')
    )
    
--fechadas e canceladas
--OK
INSERT INTO ifrmaximo.wostatus_temp
SELECT *
  FROM IFRMAXIMO.WOSTATUS
  WHERE WONUM IN ( 
  SELECT WONUM
    FROM IFRMAXIMO.WORKORDER
    WHERE siteid = 'INFRAERO'
    AND  status in ('FECHADO', 'CAN')
    and reportdate >= TO_DATE ('01/05/2010', 'DD/MM/YYYY')
    and reportdate < TO_DATE ('13/05/2010', 'DD/MM/YYYY')
    )

--ok
INSERT INTO ifrmaximo.wostatus_temp
SELECT *
  FROM IFRMAXIMO.WOSTATUS
  WHERE WONUM IN ( 
  SELECT WONUM
    FROM IFRMAXIMO.WORKORDER
    WHERE siteid = 'INFRAERO'
    AND  status in ('FECHADO', 'CAN')
    and reportdate >= TO_DATE ('01/04/2010', 'DD/MM/YYYY')
    and reportdate < TO_DATE ('01/05/2010', 'DD/MM/YYYY')
    )
--ok
INSERT INTO ifrmaximo.wostatus_temp
SELECT *
  FROM IFRMAXIMO.WOSTATUS
  WHERE WONUM IN ( 
  SELECT WONUM
    FROM IFRMAXIMO.WORKORDER
    WHERE siteid = 'INFRAERO'
    AND  status in ('FECHADO', 'CAN')
    and reportdate >= TO_DATE ('01/03/2010', 'DD/MM/YYYY')
    and reportdate < TO_DATE ('01/04/2010', 'DD/MM/YYYY')
    )
--ok
INSERT INTO ifrmaximo.wostatus_temp
SELECT *
  FROM IFRMAXIMO.WOSTATUS
  WHERE WONUM IN ( 
  SELECT WONUM 
    FROM IFRMAXIMO.WORKORDER
    WHERE siteid = 'INFRAERO'
    AND  status in ('FECHADO', 'CAN')
    and reportdate >= TO_DATE ('01/02/2010', 'DD/MM/YYYY')
    and reportdate < TO_DATE ('01/03/2010', 'DD/MM/YYYY')
    )
--ok
INSERT INTO ifrmaximo.wostatus_temp
SELECT *
  FROM IFRMAXIMO.WOSTATUS
  WHERE WONUM IN ( 
  SELECT WONUM
    FROM IFRMAXIMO.WORKORDER
    WHERE siteid = 'INFRAERO'
    AND  status in ('FECHADO', 'CAN')
    and reportdate >= TO_DATE ('01/01/2010', 'DD/MM/YYYY')
    and reportdate < TO_DATE ('01/02/2010', 'DD/MM/YYYY')
    )
    
-----*************************************************************************
INSERT INTO ifrmaximo.wostatus  
SELECT *
  FROM IFRMAXIMO.WOSTATUS_HIST
  WHERE WONUM IN ( 
  SELECT WONUM
    FROM IFRMAXIMO.WORKORDER
    WHERE siteid = 'INFRAERO'
    AND  status not in ('FECHADO', 'CAN')
    and reportdate >= TO_DATE ('01/01/2009', 'DD/MM/YYYY')
    and reportdate < TO_DATE ('01/02/2009', 'DD/MM/YYYY')
    )
/

INSERT INTO ifrmaximo.wostatus  
SELECT *
  FROM IFRMAXIMO.WOSTATUS_HIST
  WHERE WONUM IN ( 
  SELECT WONUM
    FROM IFRMAXIMO.WORKORDER
    WHERE siteid = 'INFRAERO'
    AND  status not in ('FECHADO', 'CAN')
    and reportdate >= TO_DATE ('01/02/2009', 'DD/MM/YYYY')
    and reportdate < TO_DATE ('01/03/2009', 'DD/MM/YYYY')
    )
/

INSERT INTO ifrmaximo.wostatus  
SELECT *
  FROM IFRMAXIMO.WOSTATUS_HIST
  WHERE WONUM IN ( 
  SELECT WONUM
    FROM IFRMAXIMO.WORKORDER
    WHERE siteid = 'INFRAERO'
    AND  status not in ('FECHADO', 'CAN')
    and reportdate >= TO_DATE ('01/03/2009', 'DD/MM/YYYY')
    and reportdate < TO_DATE ('01/04/2009', 'DD/MM/YYYY')
    )
/

commit;


INSERT INTO ifrmaximo.wostatus  
SELECT *
  FROM IFRMAXIMO.WOSTATUS_HIST
  WHERE WONUM IN ( 
  SELECT WONUM
    FROM IFRMAXIMO.WORKORDER
    WHERE siteid = 'INFRAERO'
    AND  status not in ('FECHADO', 'CAN')
    and reportdate >= TO_DATE ('01/04/2009', 'DD/MM/YYYY')
    and reportdate < TO_DATE ('01/05/2009', 'DD/MM/YYYY')
    )
/

INSERT INTO ifrmaximo.wostatus  
SELECT *
  FROM IFRMAXIMO.WOSTATUS_HIST
  WHERE WONUM IN ( 
  SELECT WONUM
    FROM IFRMAXIMO.WORKORDER
    WHERE siteid = 'INFRAERO'
    AND  status not in ('FECHADO', 'CAN')
    and reportdate >= TO_DATE ('01/05/2009', 'DD/MM/YYYY')
    and reportdate < TO_DATE ('01/06/2009', 'DD/MM/YYYY')
    )
/

INSERT INTO ifrmaximo.wostatus  
SELECT *
  FROM IFRMAXIMO.WOSTATUS_HIST
  WHERE WONUM IN ( 
  SELECT WONUM
    FROM IFRMAXIMO.WORKORDER
    WHERE siteid = 'INFRAERO'
    AND  status not in ('FECHADO', 'CAN')
    and reportdate >= TO_DATE ('01/06/2009', 'DD/MM/YYYY')
    and reportdate < TO_DATE ('01/07/2009', 'DD/MM/YYYY')
    )
/

commit;

INSERT INTO ifrmaximo.wostatus  
SELECT *
  FROM IFRMAXIMO.WOSTATUS_HIST
  WHERE WONUM IN ( 
  SELECT WONUM
    FROM IFRMAXIMO.WORKORDER
    WHERE siteid = 'INFRAERO'
    AND  status not in ('FECHADO', 'CAN')
    and reportdate >= TO_DATE ('01/07/2009', 'DD/MM/YYYY')
    and reportdate < TO_DATE ('01/08/2009', 'DD/MM/YYYY')
    )
/

INSERT INTO ifrmaximo.wostatus  
SELECT *
  FROM IFRMAXIMO.WOSTATUS_HIST
  WHERE WONUM IN ( 
  SELECT WONUM
    FROM IFRMAXIMO.WORKORDER
    WHERE siteid = 'INFRAERO'
    AND  status not in ('FECHADO', 'CAN')
    and reportdate >= TO_DATE ('01/08/2009', 'DD/MM/YYYY')
    and reportdate < TO_DATE ('01/09/2009', 'DD/MM/YYYY')
    )
/

INSERT INTO ifrmaximo.wostatus  
SELECT *
  FROM IFRMAXIMO.WOSTATUS_HIST
  WHERE WONUM IN ( 
  SELECT WONUM
    FROM IFRMAXIMO.WORKORDER
    WHERE siteid = 'INFRAERO'
    AND  status not in ('FECHADO', 'CAN')
    and reportdate >= TO_DATE ('01/09/2009', 'DD/MM/YYYY')
    and reportdate < TO_DATE ('01/10/2009', 'DD/MM/YYYY')
    )
/

commit;

INSERT INTO ifrmaximo.wostatus  
SELECT *
  FROM IFRMAXIMO.WOSTATUS_HIST
  WHERE WONUM IN ( 
  SELECT WONUM
    FROM IFRMAXIMO.WORKORDER
    WHERE siteid = 'INFRAERO'
    AND  status not in ('FECHADO', 'CAN')
    and reportdate >= TO_DATE ('01/10/2009', 'DD/MM/YYYY')
    and reportdate < TO_DATE ('01/11/2009', 'DD/MM/YYYY')
    )
/

INSERT INTO ifrmaximo.wostatus  
SELECT *
  FROM IFRMAXIMO.WOSTATUS_HIST
  WHERE WONUM IN ( 
  SELECT WONUM
    FROM IFRMAXIMO.WORKORDER
    WHERE siteid = 'INFRAERO'
    AND  status not in ('FECHADO', 'CAN')
    and reportdate >= TO_DATE ('01/11/2009', 'DD/MM/YYYY')
    and reportdate < TO_DATE ('01/12/2009', 'DD/MM/YYYY')
    )
/

INSERT INTO ifrmaximo.wostatus  
SELECT *
  FROM IFRMAXIMO.WOSTATUS_HIST
  WHERE WONUM IN ( 
  SELECT WONUM
    FROM IFRMAXIMO.WORKORDER
    WHERE siteid = 'INFRAERO'
    AND  status not in ('FECHADO', 'CAN')
    and reportdate >= TO_DATE ('01/12/2009', 'DD/MM/YYYY')
    and reportdate < TO_DATE ('01/01/2010', 'DD/MM/YYYY')
    )
/

commit;

INSERT INTO ifrmaximo.wostatus  
SELECT *
  FROM IFRMAXIMO.WOSTATUS_HIST
  WHERE WONUM IN ( 
  SELECT WONUM--, STATUS 
    FROM IFRMAXIMO.WORKORDER
    WHERE siteid != 'INFRAERO'
    AND  status NOT in ('CANNNN')
    and reportdate >= TO_DATE ('01/01/2009', 'DD/MM/YYYY')
    and reportdate < TO_DATE ('13/05/2010', 'DD/MM/YYYY')
    )
/

COMMIT;

-----*************************************************************************
INSERT INTO ifrmaximo.wostatus  
SELECT *
  FROM IFRMAXIMO.WOSTATUS_HIST
  WHERE WONUM IN ( 
  SELECT WONUM
    FROM IFRMAXIMO.WORKORDER
    WHERE siteid = 'INFRAERO'
    AND  status in ('FECHADO', 'CAN')
    and reportdate >= TO_DATE ('01/01/2009', 'DD/MM/YYYY')
    and reportdate < TO_DATE ('01/02/2009', 'DD/MM/YYYY')
    )
/

INSERT INTO ifrmaximo.wostatus  
SELECT *
  FROM IFRMAXIMO.WOSTATUS_HIST
  WHERE WONUM IN ( 
  SELECT WONUM
    FROM IFRMAXIMO.WORKORDER
    WHERE siteid = 'INFRAERO'
    AND  status in ('FECHADO', 'CAN')
    and reportdate >= TO_DATE ('01/02/2009', 'DD/MM/YYYY')
    and reportdate < TO_DATE ('01/03/2009', 'DD/MM/YYYY')
    )
/

INSERT INTO ifrmaximo.wostatus  
SELECT *
  FROM IFRMAXIMO.WOSTATUS_HIST
  WHERE WONUM IN ( 
  SELECT WONUM
    FROM IFRMAXIMO.WORKORDER
    WHERE siteid = 'INFRAERO'
    AND  status in ('FECHADO', 'CAN')
    and reportdate >= TO_DATE ('01/03/2009', 'DD/MM/YYYY')
    and reportdate < TO_DATE ('01/04/2009', 'DD/MM/YYYY')
    )
/

commit;


INSERT INTO ifrmaximo.wostatus  
SELECT *
  FROM IFRMAXIMO.WOSTATUS_HIST
  WHERE WONUM IN ( 
  SELECT WONUM
    FROM IFRMAXIMO.WORKORDER
    WHERE siteid = 'INFRAERO'
    AND  status in ('FECHADO', 'CAN')
    and reportdate >= TO_DATE ('01/04/2009', 'DD/MM/YYYY')
    and reportdate < TO_DATE ('01/05/2009', 'DD/MM/YYYY')
    )
/

INSERT INTO ifrmaximo.wostatus  
SELECT *
  FROM IFRMAXIMO.WOSTATUS_HIST
  WHERE WONUM IN ( 
  SELECT WONUM
    FROM IFRMAXIMO.WORKORDER
    WHERE siteid = 'INFRAERO'
    AND  status in ('FECHADO', 'CAN')
    and reportdate >= TO_DATE ('01/05/2009', 'DD/MM/YYYY')
    and reportdate < TO_DATE ('01/06/2009', 'DD/MM/YYYY')
    )
/

INSERT INTO ifrmaximo.wostatus  
SELECT *
  FROM IFRMAXIMO.WOSTATUS_HIST
  WHERE WONUM IN ( 
  SELECT WONUM
    FROM IFRMAXIMO.WORKORDER
    WHERE siteid = 'INFRAERO'
    AND  status in ('FECHADO', 'CAN')
    and reportdate >= TO_DATE ('01/06/2009', 'DD/MM/YYYY')
    and reportdate < TO_DATE ('01/07/2009', 'DD/MM/YYYY')
    )
/

commit;

INSERT INTO ifrmaximo.wostatus  
SELECT *
  FROM IFRMAXIMO.WOSTATUS_HIST
  WHERE WONUM IN ( 
  SELECT WONUM
    FROM IFRMAXIMO.WORKORDER
    WHERE siteid = 'INFRAERO'
    AND  status in ('FECHADO', 'CAN')
    and reportdate >= TO_DATE ('01/07/2009', 'DD/MM/YYYY')
    and reportdate < TO_DATE ('01/08/2009', 'DD/MM/YYYY')
    )
/

INSERT INTO ifrmaximo.wostatus  
SELECT *
  FROM IFRMAXIMO.WOSTATUS_HIST
  WHERE WONUM IN ( 
  SELECT WONUM
    FROM IFRMAXIMO.WORKORDER
    WHERE siteid = 'INFRAERO'
    AND  status in ('FECHADO', 'CAN')
    and reportdate >= TO_DATE ('01/08/2009', 'DD/MM/YYYY')
    and reportdate < TO_DATE ('01/09/2009', 'DD/MM/YYYY')
    )
/

INSERT INTO ifrmaximo.wostatus  
SELECT *
  FROM IFRMAXIMO.WOSTATUS_HIST
  WHERE WONUM IN ( 
  SELECT WONUM
    FROM IFRMAXIMO.WORKORDER
    WHERE siteid = 'INFRAERO'
    AND  status in ('FECHADO', 'CAN')
    and reportdate >= TO_DATE ('01/09/2009', 'DD/MM/YYYY')
    and reportdate < TO_DATE ('01/10/2009', 'DD/MM/YYYY')
    )
/

commit;

INSERT INTO ifrmaximo.wostatus  
SELECT *
  FROM IFRMAXIMO.WOSTATUS_HIST
  WHERE WONUM IN ( 
  SELECT WONUM
    FROM IFRMAXIMO.WORKORDER
    WHERE siteid = 'INFRAERO'
    AND  status in ('FECHADO', 'CAN')
    and reportdate >= TO_DATE ('01/10/2009', 'DD/MM/YYYY')
    and reportdate < TO_DATE ('01/11/2009', 'DD/MM/YYYY')
    )
/

INSERT INTO ifrmaximo.wostatus  
SELECT *
  FROM IFRMAXIMO.WOSTATUS_HIST
  WHERE WONUM IN ( 
  SELECT WONUM
    FROM IFRMAXIMO.WORKORDER
    WHERE siteid = 'INFRAERO'
    AND  status in ('FECHADO', 'CAN')
    and reportdate >= TO_DATE ('01/11/2009', 'DD/MM/YYYY')
    and reportdate < TO_DATE ('01/12/2009', 'DD/MM/YYYY')
    )
/

INSERT INTO ifrmaximo.wostatus  
SELECT *
  FROM IFRMAXIMO.WOSTATUS_HIST
  WHERE WONUM IN ( 
  SELECT WONUM
    FROM IFRMAXIMO.WORKORDER
    WHERE siteid = 'INFRAERO'
    AND  status in ('FECHADO', 'CAN')
    and reportdate >= TO_DATE ('01/12/2009', 'DD/MM/YYYY')
    and reportdate < TO_DATE ('01/01/2010', 'DD/MM/YYYY')
    )
/

commit;
