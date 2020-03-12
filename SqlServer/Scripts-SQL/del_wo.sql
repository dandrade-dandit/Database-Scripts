set timing on
set serveroutput on
clear screen;

exec dbms_output.put_line( 'jan');
delete
 from IFRMAXIMO.wostatus 
where siteid='INFRAERO'
    and changedate >= to_date('01/01/2008','dd/mm/yyyy')
    and changedate <= to_date('01/02/2008','dd/mm/yyyy')
/

commit
/

exec dbms_output.put_line( 'fev');
delete
 from IFRMAXIMO.wostatus 
where siteid='INFRAERO'
    and changedate >= to_date('01/02/2008','dd/mm/yyyy')
    and changedate <= to_date('01/03/2008','dd/mm/yyyy')
/

commit
/

exec dbms_output.put_line( 'mar');
delete
 from IFRMAXIMO.wostatus 
where siteid='INFRAERO'
    and changedate >= to_date('01/03/2008','dd/mm/yyyy')
    and changedate <= to_date('01/04/2008','dd/mm/yyyy')
/

commit
/

exec dbms_output.put_line( 'abr');
delete
 from IFRMAXIMO.wostatus 
where siteid='INFRAERO'
    and changedate >= to_date('01/04/2008','dd/mm/yyyy')
    and changedate <= to_date('01/05/2008','dd/mm/yyyy')
/

commit
/

exec dbms_output.put_line( 'mai');
delete
 from IFRMAXIMO.wostatus 
where siteid='INFRAERO'
    and changedate >= to_date('01/05/2008','dd/mm/yyyy')
    and changedate <= to_date('01/06/2008','dd/mm/yyyy')
/

commit
/

exec dbms_output.put_line( 'jun');
delete
 from IFRMAXIMO.wostatus 
where siteid='INFRAERO'
    and changedate >= to_date('01/06/2008','dd/mm/yyyy')
    and changedate <= to_date('01/07/2008','dd/mm/yyyy')
/

commit
/

exec dbms_output.put_line( 'jul');
delete
 from IFRMAXIMO.wostatus 
where siteid='INFRAERO'
    and changedate >= to_date('01/07/2008','dd/mm/yyyy')
    and changedate <= to_date('01/08/2008','dd/mm/yyyy')
/

commit
/

exec dbms_output.put_line( 'ago');
delete
 from IFRMAXIMO.wostatus 
where siteid='INFRAERO'
    and changedate >= to_date('01/08/2008','dd/mm/yyyy')
    and changedate <= to_date('01/09/2008','dd/mm/yyyy')
/

commit
/

exec dbms_output.put_line( 'set');
delete
 from IFRMAXIMO.wostatus 
where siteid='INFRAERO'
    and changedate >= to_date('01/09/2008','dd/mm/yyyy')
    and changedate <= to_date('01/10/2008','dd/mm/yyyy')
/

commit
/

exec dbms_output.put_line( 'out');
delete
 from IFRMAXIMO.wostatus 
where siteid='INFRAERO'
    and changedate >= to_date('01/10/2008','dd/mm/yyyy')
    and changedate <= to_date('01/11/2008','dd/mm/yyyy')
/

commit
/

exec dbms_output.put_line( 'nov');
delete
 from IFRMAXIMO.wostatus 
where siteid='INFRAERO'
    and changedate >= to_date('01/11/2008','dd/mm/yyyy')
    and changedate <= to_date('01/12/2008','dd/mm/yyyy')
/

commit
/

exec dbms_output.put_line( 'dez');
delete
 from IFRMAXIMO.wostatus 
where siteid='INFRAERO'
    and changedate >= to_date('01/12/2008','dd/mm/yyyy')
    and changedate <= to_date('31/12/2008','dd/mm/yyyy')
/

commit
/

