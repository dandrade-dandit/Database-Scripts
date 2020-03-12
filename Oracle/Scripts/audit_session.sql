set heading off

select 'Total de conexões, por dia e por Departamento................' from dual;

break on to_char(timestamp,'DD-MM-YYYY') skip 1
select to_char(timestamp,'DD-MM-YYYY')||' Dept.:'||upper(substr(os_username,1,4))||' Qtd:'||count(*)
from dba_audit_session
group by to_char(timestamp,'DD-MM-YYYY'),upper(substr(os_username,1,4));

select 'Detalhamento de logins feitos pela informática' from dual;

select 'Conta_NT:'||os_username||' # Conta_BD:'||username||'-'||no_usuario||'- Dep:'||dep_cd_dependencia,
'Estação:'||terminal||' # Lwrite:'||logoff_lwrite||' # Lock:'||logoff_dlock,
'Logon:'||to_char(timestamp,'DD/MM/YYYY HH24:MI')||' Logoff:'||to_char(logoff_time,'HH24:MI')||' Erro:'||returncode
from dba_audit_session, seg_usuario
where (upper(os_username) like 'PRSI%' or
       upper(os_username) like 'SIRJ%' or
       upper(os_username) like 'IFPA%' or
       upper(os_username) like 'SISP%' or
       upper(os_username) like 'IFMN%' or
       upper(os_username) like 'IFBE%' or
       upper(os_username) like 'IFRF%' or
       upper(os_username) like 'IFBR%')   and
       upper(username) = upper(id_usuario(+))
order by timestamp;

select 'Total de conexões da PRSI, por dia e por conta...............' from dual;

break on to_char(timestamp,'DD-MM-YYYY') skip 1
select to_char(timestamp,'DD-MM-YYYY')||' Conta_NT:'||upper(os_username)||' Conta_BD:'||upper(username)||' Qtd:'||count(*)
from dba_audit_session
where (upper(os_username) like 'PRSI%')
group by to_char(timestamp,'DD-MM-YYYY'),upper(os_username),upper(username);

select 'Total de conexões da área de informática, por dia............' from dual;

break on to_char(timestamp,'DD-MM-YYYY') skip 1
select to_char(timestamp,'DD-MM-YYYY')||' Qtd:'||count(*)
from dba_audit_session
where (upper(os_username) like 'PRSI%' or
       upper(os_username) like 'SIRJ%' or
       upper(os_username) like 'IFPA%' or
       upper(os_username) like 'SISP%' or
       upper(os_username) like 'IFMN%' or
       upper(os_username) like 'IFBE%' or
       upper(os_username) like 'IFRF%' or
       upper(os_username) like 'IFBR%')
group by to_char(timestamp,'DD-MM-YYYY');

select 'Total de conexões com sucesso, por dia.......................' from dual;

select to_char(timestamp,'DD-MM-YYYY')||' Qtd:'||count(*)
from dba_audit_session
where returncode <> 1017
group by to_char(timestamp,'DD-MM-YYYY');

select 'Total de conexões com falha, por dia.........................' from dual;

select to_char(timestamp,'DD-MM-YYYY')||' Qtd:'||count(*)
from dba_audit_session
where returncode = 1017
group by to_char(timestamp,'DD-MM-YYYY');

set heading on