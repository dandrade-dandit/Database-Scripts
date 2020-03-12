/***cria jobs***/

variable jobno number;
begin
dbms_job.submit(:jobno,
		'p_homem_hora;',
		to_date('01/02/2002 01:00:00','DD/MM/YYYY HH:MI:SS'),
		'ADD_MONTHS(SYSDATE,1)');
END;
/







variable jobno number;
begin
dbms_job.submit(:jobno,
		'SRH_CAD_PROCEDIMENTOS_DIARIOS;',
		to_date('11/01/2003 01:00:00','DD/MM/YYYY HH:MI:SS'),
		'SYSDATE + 1');
END;
/


variable jobno number;
begin
dbms_job.remove(3); -- 3 é o código do job
END;
/
