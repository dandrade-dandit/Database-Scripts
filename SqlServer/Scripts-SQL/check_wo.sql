clear screen;

select count(1) jan
 from IFRMAXIMO.wostatus 
where siteid='INFRAERO'
    and changedate >= to_date('01/01/2008','dd/mm/yyyy')
    and changedate <= to_date('01/02/2008','dd/mm/yyyy')
/


select count(1) fev
 from IFRMAXIMO.wostatus 
where siteid='INFRAERO'
    and changedate >= to_date('01/02/2008','dd/mm/yyyy')
    and changedate <= to_date('01/03/2008','dd/mm/yyyy')
/

select count(1) mar
 from IFRMAXIMO.wostatus 
where siteid='INFRAERO'
    and changedate >= to_date('01/03/2008','dd/mm/yyyy')
    and changedate <= to_date('01/04/2008','dd/mm/yyyy')
/

select count(1) abr
 from IFRMAXIMO.wostatus 
where siteid='INFRAERO'
    and changedate >= to_date('01/04/2008','dd/mm/yyyy')
    and changedate <= to_date('01/05/2008','dd/mm/yyyy')
/

select count(1) mai
 from IFRMAXIMO.wostatus 
where siteid='INFRAERO'
    and changedate >= to_date('01/05/2008','dd/mm/yyyy')
    and changedate <= to_date('01/06/2008','dd/mm/yyyy')
/

select count(1) jun
 from IFRMAXIMO.wostatus 
where siteid='INFRAERO'
    and changedate >= to_date('01/06/2008','dd/mm/yyyy')
    and changedate <= to_date('01/07/2008','dd/mm/yyyy')
/

select count(1) jul
 from IFRMAXIMO.wostatus 
where siteid='INFRAERO'
    and changedate >= to_date('01/07/2008','dd/mm/yyyy')
    and changedate <= to_date('01/08/2008','dd/mm/yyyy')
/

select count(1) ago
 from IFRMAXIMO.wostatus 
where siteid='INFRAERO'
    and changedate >= to_date('01/08/2008','dd/mm/yyyy')
    and changedate <= to_date('01/09/2008','dd/mm/yyyy')
/

select count(1) "set"
 from IFRMAXIMO.wostatus 
where siteid='INFRAERO'
    and changedate >= to_date('01/09/2008','dd/mm/yyyy')
    and changedate <= to_date('01/10/2008','dd/mm/yyyy')
/

select count(1) out
 from IFRMAXIMO.wostatus 
where siteid='INFRAERO'
    and changedate >= to_date('01/10/2008','dd/mm/yyyy')
    and changedate <= to_date('01/11/2008','dd/mm/yyyy')
/

select count(1) nov
 from IFRMAXIMO.wostatus 
where siteid='INFRAERO'
    and changedate >= to_date('01/11/2008','dd/mm/yyyy')
    and changedate <= to_date('01/12/2008','dd/mm/yyyy')
/

select count(1) dez
 from IFRMAXIMO.wostatus 
where siteid='INFRAERO'
    and changedate >= to_date('01/12/2008','dd/mm/yyyy')
    and changedate <= to_date('31/12/2008','dd/mm/yyyy')
/

