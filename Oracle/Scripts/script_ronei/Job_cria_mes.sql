declare
   jobno number;
begin
   dbms_job.submit(jobno,
                   'sys.pr_limpa_aud$;',
                   to_date('2002/05/01-04:00:00', 'YYYY/MM/DD-HH24:MI:SS'),
                   'add_months(sysdate,1)');
end;
/