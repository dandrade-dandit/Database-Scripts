
VARIABLE jobno number;
BEGIN
   DBMS_JOB.CHANGE(46, 'statspack.snap;', to_date('06/10/2004 01:30:00', 'DD/MM/YYYY HH24:MI:SS'), 'SYSDATE + 1');
   commit;
END;
/


VARIABLE jobno number;
BEGIN
   DBMS_JOB.CHANGE(203, 'sys.pr_gera_analyze_tab;', to_date('06/10/2004 01:00:00', 'DD/MM/YYYY HH24:MI:SS'), 'SYSDATE + 7');
   commit;
END;
/


VARIABLE jobno number;
BEGIN
   DBMS_JOB.CHANGE(443, 'sys.pr_gera_analyze_tab_zerada;', to_date('06/10/2004 02:00:00', 'DD/MM/YYYY HH24:MI:SS'), 'SYSDATE + 7');
   commit;
END;
/



VARIABLE jobno number;
BEGIN
   DBMS_JOB.CHANGE(83, 'sst.proc_absenteismo_refresh;', to_date('06/10/2004 00:30:00', 'DD/MM/YYYY HH24:MI:SS'), 'SYSDATE + 1');
   commit;
END;
/

VARIABLE jobno number;
BEGIN
   DBMS_JOB.CHANGE(607, 'IFRSRH2.SRH_CAD_PROCEDIMENTOS_DIARIOS;', to_date('04/03/2005 00:05:00', 'DD/MM/YYYY HH24:MI:SS'), 'SYSDATE + 1');
   commit;
END;
/
