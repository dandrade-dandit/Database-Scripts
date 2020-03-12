select * from dba_jobs
/

select what,failures,TO_CHAR(last_date,'DD/MM/YYYY HH24:MI:SS'),TO_CHAR(next_date,'DD/MM/YYYY HH24:MI:SS') from dba_jobs WHERE WHAT LIKE 'dbms_refresh.refresh%'
/


VARIABLE jobno number;
BEGIN
	dbms_job.broken(344, TRUE);
commit;
END;
/


VARIABLE jobno number;
BEGIN
	dbms_job.broken(408, FALSE, to_date('30/08/2011 05:00:00', 'DD/MM/YYYY HH24:MI:SS'));
commit;
END;
/

VARIABLE jobno number;
BEGIN
	dbms_job.broken(41, FALSE, to_date('10/09/2012 01:00:00', 'DD/MM/YYYY HH24:MI:SS'));
commit;
END;
/

VARIABLE jobno number;
BEGIN
	dbms_job.broken(465, FALSE, to_date('30/08/2011 03:00:00', 'DD/MM/YYYY HH24:MI:SS'));
commit;
END;
/



VARIABLE jobno number;
BEGIN
   DBMS_JOB.run(41);
   commit;
END;
/

VARIABLE jobno number;
BEGIN
   DBMS_JOB.CHANGE(263, 'dbms_refresh.refresh(''"IFRMYSAR"."MV_DADOS_RESUMIDOS"'');', to_date('28/06/2011 00:30:00', 'DD/MM/YYYY HH24:MI:SS'), 'SYSDATE + 1');
   commit;
END;
/


VARIABLE jobno number;
BEGIN
   DBMS_JOB.remove(23);
   commit;
END;
/

VARIABLE jobno number;
BEGIN
   DBMS_JOB.SUBMIT(:jobno,  'DBMS_MVIEW.REFRESH(''"IFRMAXIMO"."VIW_RELATORIOS"'', ''C'');', to_date('10/07/2012 01:00:00', 'DD/MM/YYYY HH24:MI:SS'), 'SYSDATE + 1');
   commit;
END;
/

VARIABLE jobno number;
BEGIN
DBMS_JOB.SUBMIT(:jobno,'IFRMAT.GERA_INVENTARIO;',
to_date('01/01/2011 00:01:00', 'DD/MM/YYYY HH24:MI:SS'), 'add_months(sysdate,1)');
commit;
END;
/ 

--587  IFRSRH   SYSDATE + 1                 ifrsrh.atualiza_dados_portal;
--487  IFRSRH   SYSDATE + 1                 IFRSRH.PROC_INSERE_HIERARQUIA_AGENDA;
--607  IFRSRH   SYSDATE + 1                 IFRSRH.SRH_CAD_PROCEDIMENTOS_DIARIOS;
--648  IFRSRH   /*1:Days*/ sysdate + 1      dbms_refresh.refresh('"IFRSRH2"."VIW_SALARIO_ATIVOS"');

--134  IFRDBA2  add_months(sysdate,1)       begin gera_inventario; end;

--83   SST      SYSDATE + 1                 sst.proc_absenteismo_refresh;

--    SST_AUDIOINT	sysdate+1           begin SST_AUDIO.NEXO_INTEGRA_INFRAERO.INTEGRA_INFRAERO(SYSDATE); end;                                                                                                                                                                                    	17                                     	




  