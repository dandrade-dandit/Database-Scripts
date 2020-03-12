drop TABLE log_info
/

create TABLE log_info (
 	login_date DATE
, 	username VARCHAR2(30)
, 	user# number
, 	status number(1)
)
/

CREATE OR REPLACE TRIGGER logon_audit AFTER LOGON ON DATABASE  
WHEN (user = 'INTEGRACAO_NOTES_VSCV')
BEGIN 
     insert into ifrbanco.log_info values(sysdate,user, 0, 0);
END; 
/ 

CREATE OR REPLACE TRIGGER logoff_audit BEFORE LOGOFF ON DATABASE  
WHEN (user = 'INTEGRACAO_NOTES_VSCV')
BEGIN 
     insert into ifrbanco.log_info values(sysdate,user, 0, 1);
END; 
/ 


SELECT to_char(login_date, 'DD/MM/YYYY HH24:MI;SS') "Data/Hora"
, 	username "Usuário"
, 	status "Tipo do Evento"
FROM log_info
/

select * 
from v$session
where user# = 8323