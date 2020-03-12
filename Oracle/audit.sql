select 	b.*
,				a.SESSIONID
,				a.USERID
,				a.USERHOST
,				a.TERMINAL
,				A.CLIENTID
from sys.aud$ a, sys.audit_actions b
where a.action# = action
and name not in ('LOGON', 'LOGOFF', 'LOGOFF BY CLEANUP', 'SELECT', 'UPDATE', 'DELETE', 'INSERT')
order by timestamp# desc
/

select b.*,a.* 
from sys.aud$ a, sys.audit_actions b
where a.action# = action
/

--Prodsede 14/10/2005

audit update table;
audit insert table;
audit delete table;

audit delete any table;
audit insert any table;
audit update any table;


AUDIT INSERT, UPDATE, DELETE ON DENIS.COMPENSAHORAS_TMP; 

alter system set audit_trail='DB' scope=spfile;


audit alter table by ifrmaximo;
audit create table by ifrmaximo;
audit drop any table by ifrmaximo;
audit create view by ifrmaximo;
audit drop any view by ifrmaximo;
audit alter any procedure by ifrmaximo;
audit create procedure by ifrmaximo;
audit drop any procedure by ifrmaximo;
audit create sequence by ifrmaximo;
audit drop any sequence by ifrmaximo;
audit alter any index by ifrmaximo;
audit create any index by ifrmaximo;
audit drop any index by ifrmaximo;
audit alter any trigger by ifrmaximo;
audit create any trigger by ifrmaximo;
audit drop any trigger by ifrmaximo;

audit all by ifrmaximo, ifrbde, ifrseg, integracao;
audit all privileges by ifrmaximo, ifrbde, ifrseg, integracao;

--NOAUDIT...............

noaudit update table;
noaudit delete table;
noaudit insert table;
noaudit delete any table;
noaudit insert any table;
noaudit update any table;

--NOAUDIT...............
audit all by system, ifrdba,IFRAD;
audit all privileges by system, ifrdba,IFRAD;

 

create table audx tablespace TSD_AUDIT as select * from aud$ where 1 = 2;

rename AUD$ to AUD$$;

rename audx to aud$;

drop index i_aud1;

create index i_aud1 on aud$(sessionid, ses$tid) tablespace TSD_AUDIT;

drop table AUD$$ purge;



--audit ligado em 15/02/2008 07:54
audit alter table by ifrmaximo, sysadm;
audit create table by ifrmaximo, sysadm;
audit drop any table by ifrmaximo, sysadm;
audit create view by ifrmaximo, sysadm;
audit drop any view by ifrmaximo, sysadm;
audit alter any procedure by ifrmaximo, sysadm;
audit create procedure by ifrmaximo, sysadm;
audit drop any procedure by ifrmaximo, sysadm;
audit create sequence by ifrmaximo, sysadm;
audit drop any sequence by ifrmaximo, sysadm;
audit alter any index by ifrmaximo, sysadm;
audit create any index by ifrmaximo, sysadm;
audit drop any index by ifrmaximo, sysadm;
audit alter any trigger by ifrmaximo, sysadm;
audit create any trigger by ifrmaximo, sysadm;
audit drop any trigger by ifrmaximo, sysadm;


--AUDIT PESSOAL DO GESTORH EM 03/06/2009.

audit all by SRH_SFP,C000225,CTIS0888,T725761381,T057126701,T834307251,CTIS1269,T398970361,T071299698,T733301321,T398434161;
audit all privileges by SRH_SFP,C000225,CTIS0888,T725761381,T057126701,T834307251,CTIS1269,T398970361,T071299698,T733301321,T398434161;

audit all by SRH_SFP,C000225,CTIS0888,T725761381,T057126701,T834307251,CTIS1269,T398970361,T071299698,T733301321,T398434161 by access;
audit update table, delete table, insert table by SRH_SFP,C000225,CTIS0888,T725761381,T057126701,T834307251,CTIS1269,T398970361,T071299698,T733301321,T398434161 by access;



noaudit all by SRH_SFP,C000225,CTIS0888,T725761381,T057126701,T834307251,CTIS1269,T398970361,T071299698,T733301321,T398434161;
noaudit all privileges by SRH_SFP,C000225,CTIS0888,T725761381,T057126701,T834307251,CTIS1269,T398970361,T071299698,T733301321,T398434161;

noaudit all by SRH_SFP,C000225,CTIS0888,T725761381,T057126701,T834307251,CTIS1269,T398970361,T071299698,T733301321,T398434161;
noaudit update table, delete table, insert table by SRH_SFP,C000225,CTIS0888,T725761381,T057126701,T834307251,CTIS1269,T398970361,T071299698,T733301321,T398434161;
