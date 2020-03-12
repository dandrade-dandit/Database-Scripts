declare
   jobno number;
begin
   dbms_job.submit(jobno,
                   'sys.pr_gera_analyze_tab;',
                   to_date('2003/03/24-20:00', 'YYYY/MM/DD-HH24:MI'),
                   'sysdate + 7');
end;
/