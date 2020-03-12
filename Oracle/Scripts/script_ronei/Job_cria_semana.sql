declare
   jobno number;
begin
   dbms_job.submit(jobno,
                   'sys.pr_gera_analyze;',
                   to_date('2002/04/02-20:00', 'YYYY/MM/DD-HH24:MI'),
                   'sysdate + 7');
end;
/