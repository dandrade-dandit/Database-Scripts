set timing on
set serveroutput on

spo log_del_workorder.log

exec dbms_output.put_line( '2 - jul 2009');
delete 
   from ifrmaximo.workorder 
  where STATUS='CAN' 
    and siteid='INFRAERO'
    and orgid='INFRAERO' 
    and reportdate >= to_date('15/07/2009','dd/mm/yyyy')
    and reportdate <= to_date('01/08/2009','dd/mm/yyyy')
/ 

commit
/

exec dbms_output.put_line( '1 - ago 2009');
delete
   from ifrmaximo.workorder 
  where STATUS='CAN' 
    and siteid='INFRAERO'
    and orgid='INFRAERO' 
    and reportdate >= to_date('01/08/2009','dd/mm/yyyy')
    and reportdate <= to_date('15/08/2009','dd/mm/yyyy')
/

commit
/

exec dbms_output.put_line( '2 - ago 2009');
delete
   from ifrmaximo.workorder 
  where STATUS='CAN' 
    and siteid='INFRAERO'
    and orgid='INFRAERO' 
    and reportdate >= to_date('15/08/2009','dd/mm/yyyy')
    and reportdate <= to_date('01/09/2009','dd/mm/yyyy')
/

commit
/

exec dbms_output.put_line( '1 - set 2009');
delete 
   from ifrmaximo.workorder 
  where STATUS='CAN' 
    and siteid='INFRAERO'
    and orgid='INFRAERO' 
    and reportdate >= to_date('01/09/2009','dd/mm/yyyy')
    and reportdate <= to_date('15/09/2009','dd/mm/yyyy')
/

commit
/

exec dbms_output.put_line( '2 - set 2009');    
delete
   from ifrmaximo.workorder 
  where STATUS='CAN' 
    and siteid='INFRAERO'
    and orgid='INFRAERO' 
    and reportdate >= to_date('15/09/2009','dd/mm/yyyy')
    and reportdate <= to_date('01/10/2009','dd/mm/yyyy')
/

commit
/
   
exec dbms_output.put_line( '1 - out 2009');
delete
   from ifrmaximo.workorder 
  where STATUS='CAN' 
    and siteid='INFRAERO'
    and orgid='INFRAERO' 
    and reportdate >= to_date('01/10/2009','dd/mm/yyyy')
    and reportdate <= to_date('15/10/2009','dd/mm/yyyy')
/

commit
/

exec dbms_output.put_line( '2 - out 2009');
delete
   from ifrmaximo.workorder 
  where STATUS='CAN' 
    and siteid='INFRAERO'
    and orgid='INFRAERO' 
    and reportdate >= to_date('15/10/2009','dd/mm/yyyy')
    and reportdate <= to_date('01/11/2009','dd/mm/yyyy')
/

commit
/

exec dbms_output.put_line( '1 - nov 2009');
delete 
   from ifrmaximo.workorder 
  where STATUS='CAN' 
    and siteid='INFRAERO'
    and orgid='INFRAERO' 
    and reportdate >= to_date('01/11/2009','dd/mm/yyyy')
    and reportdate <= to_date('15/11/2009','dd/mm/yyyy')
/

commit
/

exec dbms_output.put_line( '2 - nov 2009');
delete 
   from ifrmaximo.workorder 
  where STATUS='CAN' 
    and siteid='INFRAERO'
    and orgid='INFRAERO' 
    and reportdate >= to_date('15/11/2009','dd/mm/yyyy')
    and reportdate <= to_date('01/12/2009','dd/mm/yyyy')
/

commit
/

exec dbms_output.put_line( '1 - dez 2009');
delete
   from ifrmaximo.workorder 
  where STATUS='CAN' 
    and siteid='INFRAERO'
    and orgid='INFRAERO' 
    and reportdate >= to_date('01/12/2009','dd/mm/yyyy')
    and reportdate <= to_date('15/12/2009','dd/mm/yyyy')
/

commit
/

exec dbms_output.put_line( '2 - dez 2009');
delete 
   from ifrmaximo.workorder 
  where STATUS='CAN' 
    and siteid='INFRAERO'
    and orgid='INFRAERO' 
    and reportdate >= to_date('15/12/2009','dd/mm/yyyy')
    and reportdate <= to_date('31/12/2009','dd/mm/yyyy')
/

commit
/


exec dbms_output.put_line( '1 - jan 2010');
delete 
   from ifrmaximo.workorder 
  where STATUS='CAN' 
    and siteid='INFRAERO'
    and orgid='INFRAERO' 
    and reportdate >= to_date('01/01/2010','dd/mm/yyyy')
    and reportdate <= to_date('15/01/2010','dd/mm/yyyy')
/

commit
/

exec dbms_output.put_line( '2 - jan 2010');
delete 
   from ifrmaximo.workorder 
  where STATUS='CAN' 
    and siteid='INFRAERO'
    and orgid='INFRAERO' 
    and reportdate >= to_date('15/01/2010','dd/mm/yyyy')
    and reportdate <= to_date('01/02/2010','dd/mm/yyyy')
/  

commit
/
 
exec dbms_output.put_line( '1 - fev 2010');
delete 
   from ifrmaximo.workorder 
  where STATUS='CAN' 
    and siteid='INFRAERO'
    and orgid='INFRAERO' 
    and reportdate >= to_date('01/02/2010','dd/mm/yyyy')
    and reportdate <= to_date('15/02/2010','dd/mm/yyyy')
/

commit
/

exec dbms_output.put_line( '2 - fev 2010');
delete 
   from ifrmaximo.workorder 
  where STATUS='CAN' 
    and siteid='INFRAERO'
    and orgid='INFRAERO' 
    and reportdate >= to_date('15/02/2010','dd/mm/yyyy')
    and reportdate <= to_date('01/03/2010','dd/mm/yyyy')
/ 

commit
/  
  
exec dbms_output.put_line( '1 - mar 2010');
delete 
   from ifrmaximo.workorder 
  where STATUS='CAN' 
    and siteid='INFRAERO'
    and orgid='INFRAERO' 
    and reportdate >= to_date('01/03/2010','dd/mm/yyyy')
    and reportdate <= to_date('15/03/2010','dd/mm/yyyy')
/

commit
/

exec dbms_output.put_line( '2 - mar 2010');
delete 
   from ifrmaximo.workorder 
  where STATUS='CAN' 
    and siteid='INFRAERO'
    and orgid='INFRAERO' 
    and reportdate >= to_date('15/03/2010','dd/mm/yyyy')
    and reportdate <= to_date('01/04/2010','dd/mm/yyyy')
/ 

commit
/

exec dbms_output.put_line( '1 - abr 2010');
delete 
   from ifrmaximo.workorder 
  where STATUS='CAN' 
    and siteid='INFRAERO'
    and orgid='INFRAERO' 
    and reportdate >= to_date('01/04/2010','dd/mm/yyyy')
    and reportdate <= to_date('15/04/2010','dd/mm/yyyy')
/

commit
/

exec dbms_output.put_line( '2 - abr 2010');
delete 
   from ifrmaximo.workorder 
  where STATUS='CAN' 
    and siteid='INFRAERO'
    and orgid='INFRAERO' 
    and reportdate >= to_date('15/04/2010','dd/mm/yyyy')
    and reportdate <= to_date('01/05/2010','dd/mm/yyyy')
/ 

commit
/

exec dbms_output.put_line( '1 - mai 2010');
delete 
   from ifrmaximo.workorder 
  where STATUS='CAN' 
    and siteid='INFRAERO'
    and orgid='INFRAERO' 
    and reportdate >= to_date('01/05/2010','dd/mm/yyyy')
    and reportdate <= to_date('15/05/2010','dd/mm/yyyy')
/

commit
/

exec dbms_output.put_line( '2 - mai 2010');
delete 
   from ifrmaximo.workorder 
  where STATUS='CAN' 
    and siteid='INFRAERO'
    and orgid='INFRAERO' 
    and reportdate >= to_date('15/05/2010','dd/mm/yyyy')
    and reportdate <= to_date('01/06/2010','dd/mm/yyyy')
/ 

commit
/

exec dbms_output.put_line( '1 - jun 2010');
delete 
   from ifrmaximo.workorder 
  where STATUS='CAN' 
    and siteid='INFRAERO'
    and orgid='INFRAERO' 
    and reportdate >= to_date('01/06/2010','dd/mm/yyyy')
    and reportdate <= to_date('15/06/2010','dd/mm/yyyy')
/

commit
/

exec dbms_output.put_line( '2 - jun 2010');
delete 
   from ifrmaximo.workorder 
  where STATUS='CAN' 
    and siteid='INFRAERO'
    and orgid='INFRAERO' 
    and reportdate >= to_date('15/06/2010','dd/mm/yyyy')
    and reportdate <= to_date('01/07/2010','dd/mm/yyyy')
/ 

commit
/

exec dbms_output.put_line( '1 - jul 2010');
delete 
   from ifrmaximo.workorder 
  where STATUS='CAN' 
    and siteid='INFRAERO'
    and orgid='INFRAERO' 
    and reportdate >= to_date('01/07/2010','dd/mm/yyyy')
    and reportdate <= to_date('15/07/2010','dd/mm/yyyy')
/

commit
/

exec dbms_output.put_line( '2 - jul 2010');
delete 
   from ifrmaximo.workorder 
  where STATUS='CAN' 
    and siteid='INFRAERO'
    and orgid='INFRAERO' 
    and reportdate >= to_date('15/07/2010','dd/mm/yyyy')
    and reportdate <= to_date('01/08/2010','dd/mm/yyyy')
/ 

commit
/

exec dbms_output.put_line( '1 - ago 2010');
delete
   from ifrmaximo.workorder 
  where STATUS='CAN' 
    and siteid='INFRAERO'
    and orgid='INFRAERO' 
    and reportdate >= to_date('01/08/2010','dd/mm/yyyy')
    and reportdate <= to_date('15/08/2010','dd/mm/yyyy')
/

commit
/

exec dbms_output.put_line( '2 - ago 2010');
delete
   from ifrmaximo.workorder 
  where STATUS='CAN' 
    and siteid='INFRAERO'
    and orgid='INFRAERO' 
    and reportdate >= to_date('15/08/2010','dd/mm/yyyy')
    and reportdate <= to_date('01/09/2010','dd/mm/yyyy')
/

commit
/

exec dbms_output.put_line( '1 - set 2010');
delete 
   from ifrmaximo.workorder 
  where STATUS='CAN' 
    and siteid='INFRAERO'
    and orgid='INFRAERO' 
    and reportdate >= to_date('01/09/2010','dd/mm/yyyy')
    and reportdate <= to_date('15/09/2010','dd/mm/yyyy')
/

commit
/

exec dbms_output.put_line( '2 - set 2010');    
delete
   from ifrmaximo.workorder 
  where STATUS='CAN' 
    and siteid='INFRAERO'
    and orgid='INFRAERO' 
    and reportdate >= to_date('15/09/2010','dd/mm/yyyy')
    and reportdate <= to_date('01/10/2010','dd/mm/yyyy')
/

commit
/
   
exec dbms_output.put_line( '1 - out 2010');
delete
   from ifrmaximo.workorder 
  where STATUS='CAN' 
    and siteid='INFRAERO'
    and orgid='INFRAERO' 
    and reportdate >= to_date('01/10/2010','dd/mm/yyyy')
    and reportdate <= to_date('15/10/2010','dd/mm/yyyy')
/

commit
/

exec dbms_output.put_line( '2 - out 2010');
delete
   from ifrmaximo.workorder 
  where STATUS='CAN' 
    and siteid='INFRAERO'
    and orgid='INFRAERO' 
    and reportdate >= to_date('15/10/2010','dd/mm/yyyy')
    and reportdate <= to_date('01/11/2010','dd/mm/yyyy')
/

commit
/

exec dbms_output.put_line( '1 - nov 2010');
delete 
   from ifrmaximo.workorder 
  where STATUS='CAN' 
    and siteid='INFRAERO'
    and orgid='INFRAERO' 
    and reportdate >= to_date('01/11/2010','dd/mm/yyyy')
    and reportdate <= to_date('15/11/2010','dd/mm/yyyy')
/

commit
/

exec dbms_output.put_line( '2 - nov 2010');
delete 
   from ifrmaximo.workorder 
  where STATUS='CAN' 
    and siteid='INFRAERO'
    and orgid='INFRAERO' 
    and reportdate >= to_date('15/11/2010','dd/mm/yyyy')
    and reportdate <= to_date('01/12/2010','dd/mm/yyyy')
/

commit
/

exec dbms_output.put_line( '1 - dez 2010');
delete
   from ifrmaximo.workorder 
  where STATUS='CAN' 
    and siteid='INFRAERO'
    and orgid='INFRAERO' 
    and reportdate >= to_date('01/12/2010','dd/mm/yyyy')
    and reportdate <= to_date('15/12/2010','dd/mm/yyyy')
/

commit
/

exec dbms_output.put_line( '2 - dez 2010');
delete 
   from ifrmaximo.workorder 
  where STATUS='CAN' 
    and siteid='INFRAERO'
    and orgid='INFRAERO' 
    and reportdate >= to_date('15/12/2010','dd/mm/yyyy')
    and reportdate <= to_date('31/12/2010','dd/mm/yyyy')
/

commit
/

spo off