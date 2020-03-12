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
       upper(os_username) like 'DATI%' or
       upper(os_username) like 'SIRJ%' or
       upper(os_username) like 'TIRJ%' or
       upper(os_username) like 'IFPA%' or
       upper(os_username) like 'SIPA%' or
       upper(os_username) like 'TIPA%' or
       upper(os_username) like 'SISP%' or
       upper(os_username) like 'TISP%' or
       upper(os_username) like 'IFMN%' or
       upper(os_username) like 'TIMN%' or
       upper(os_username) like 'IFBE%' or
       upper(os_username) like 'TIBE%' or
       upper(os_username) like 'IFRF%' or
       upper(os_username) like 'TIRF%' or
       upper(os_username) like 'IFBR%' OR
       upper(os_username) like 'TIBR%'    ) and
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
       upper(os_username) like 'DATI%' or
       upper(os_username) like 'SIRJ%' or
       upper(os_username) like 'TIRJ%' or
       upper(os_username) like 'IFPA%' or
       upper(os_username) like 'SIPA%' or
       upper(os_username) like 'TIPA%' or
       upper(os_username) like 'SISP%' or
       upper(os_username) like 'TISP%' or
       upper(os_username) like 'IFMN%' or
       upper(os_username) like 'TIMN%' or
       upper(os_username) like 'IFBE%' or
       upper(os_username) like 'TIBE%' or
       upper(os_username) like 'IFRF%' or
       upper(os_username) like 'TIRF%' or
       upper(os_username) like 'IFBR%' OR
       upper(os_username) like 'TIBR%'    )
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

select 'Periodo de '||min(timestamp)||' ate '||max(timestamp)
from dba_audit_session;


select '--total de acessos, POR U.O.' from dual;
select upper(substr(uor_sigla,1,4)),' Qtd:'||count(*)
from dba_audit_session,cadastros,unidades_organizacionais
where to_number(substr(username,2,7))=emp_numero_matricula and
emp_uor_codigo_lotacao=uor_codigo and
username not like 'IF%' and
username not like 'IN%' and
username like 'I%' and
returncode <> 1017
group by upper(substr(uor_sigla,1,4));

select '--total de acessos da area de INFORMÁTICA com conta de usuário, POR U.O.' from dual;
select upper(substr(uor_sigla,1,4)),' Qtd:'||count(*)
from dba_audit_session,cadastros,unidades_organizacionais
where to_number(substr(username,2,7))=emp_numero_matricula and
emp_uor_codigo_lotacao=uor_codigo and
username not like 'IF%' and
username not like 'IN%' and
username like 'I%' AND
returncode <> 1017  AND
 (upper(os_username) like 'PRSI%' or
       upper(os_username) like 'DATI%' or
       upper(os_username) like 'SIRJ%' or
       upper(os_username) like 'TIRJ%' or
       upper(os_username) like 'IFPA%' or
       upper(os_username) like 'SIPA%' or
       upper(os_username) like 'TIPA%' or
       upper(os_username) like 'SISP%' or
       upper(os_username) like 'TISP%' or
       upper(os_username) like 'IFMN%' or
       upper(os_username) like 'TIMN%' or
       upper(os_username) like 'IFBE%' or
       upper(os_username) like 'TIBE%' or
       upper(os_username) like 'IFRF%' or
       upper(os_username) like 'TIRF%' or
       upper(os_username) like 'IFBR%' OR
       upper(os_username) like 'TIBR%'    )
group by upper(substr(uor_sigla,1,4));

select '--total de acessos da area de INFORMÁTICA com conta de usuário, POR CONTA E U.O.' from dual;
select OS_USERNAME||'       '||upper(substr(uor_sigla,1,4))||'   Qtd:'||count(*)
from dba_audit_session,cadastros,unidades_organizacionais
where to_number(substr(username,2,7))=emp_numero_matricula and
emp_uor_codigo_lotacao=uor_codigo and
username not like 'IF%' and
username not like 'IN%' and
username like 'I%' AND
returncode <> 1017  AND
 (upper(os_username) like 'PRSI%' or
       upper(os_username) like 'DATI%' or
       upper(os_username) like 'SIRJ%' or
       upper(os_username) like 'TIRJ%' or
       upper(os_username) like 'IFPA%' or
       upper(os_username) like 'SIPA%' or
       upper(os_username) like 'TIPA%' or
       upper(os_username) like 'SISP%' or
       upper(os_username) like 'TISP%' or
       upper(os_username) like 'IFMN%' or
       upper(os_username) like 'TIMN%' or
       upper(os_username) like 'IFBE%' or
       upper(os_username) like 'TIBE%' or
       upper(os_username) like 'IFRF%' or
       upper(os_username) like 'TIRF%' or
       upper(os_username) like 'IFBR%' OR
       upper(os_username) like 'TIBR%'    )
group by OS_USERNAME,upper(substr(uor_sigla,1,4));

select '--acessos da area de INFORMÁTICA com conta de usuário, POR CONTA NA REDE' from dual;
select OS_USERNAME||'       '||upper(emp_nome)||'   Qtd:'||count(*)
from dba_audit_session,cadastros
--,unidades_organizacionais
where to_number(substr(username,2,7))=emp_numero_matricula and
--emp_uor_codigo_lotacao=uor_codigo and
username not like 'IF%' and
username not like 'IN%' and
username like 'I%' AND
returncode <> 1017  AND
instr(upper(emp_nome),upper(substr(os_username,6,5))) = 0   and
 (upper(os_username) like 'PRSI%' or
       upper(os_username) like 'DATI%' or
       upper(os_username) like 'SIRJ%' or
       upper(os_username) like 'TIRJ%' or
       upper(os_username) like 'IFPA%' or
       upper(os_username) like 'SIPA%' or
       upper(os_username) like 'TIPA%' or
       upper(os_username) like 'SISP%' or
       upper(os_username) like 'TISP%' or
       upper(os_username) like 'IFMN%' or
       upper(os_username) like 'TIMN%' or
       upper(os_username) like 'IFBE%' or
       upper(os_username) like 'TIBE%' or
       upper(os_username) like 'IFRF%' or
       upper(os_username) like 'TIRF%' or
       upper(os_username) like 'IFBR%' OR
       upper(os_username) like 'TIBR%'    )
group by OS_USERNAME,upper(emp_nome);
 
select '-- CONEXOES INDEVIDAS SEM SUCESSO' from dual;
select OS_USERNAME||'     '||USERNAME||'   Qtd:'||count(*)
from dba_audit_session
where username NOT like 'I%' AND
      returncode = 1017
GROUP BY OS_USERNAME,USERNAME;


set heading on