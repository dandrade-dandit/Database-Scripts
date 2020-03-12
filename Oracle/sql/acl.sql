Sun Oct 03 07:56:36 2010
Errors in file /u01/rdbms/oracle/diag/rdbms/ifrprod/ifrprod1/trace/ifrprod1_j000_31113.trc:
ORA-12012: erro ao executar automaticamente o job 75491
ORA-20001: The following error has occured: ORA-24247: acesso à rede negado pela ACL (access control list)
ORA-06512: em "IFRSRH.ENVIA_EMAIL", line 43
ORA-06512: em "IFRSRH.SRH_BEN_FINALIZA_BENEFICIOS", line 398
ORA-06512: em "IFRSRH.SRH_CAD_PROCEDIMENTOS_DIARIOS", line 2136
ORA-06512: em line 2
Sun Oct 03 07:58:53 2010



ALTER SYSTEM SET control_management_pack_access='NONE' SCOPE=MEMORY;


BEGIN 
DBMS_NETWORK_ACL_ADMIN.CREATE_ACL(acl => 'ACL_TEST.xml',
description => 'ACL FOR TEST PURPOSES',
principal => 'JSUNG',
is_grant => true,
privilege => 'connect',
start_date => null,
end_date => null );
COMMIT;
END;
/ 


begin
dbms_network_acl_admin.create_acl (
acl => 'utlpkg.xml',
description => 'Normal Access',
principal => 'PUBLIC',
is_grant => TRUE,
privilege => 'connect',
start_date => null,
end_date => null
);
end;

Begin
dbms_network_acl_admin.add_privilege (
acl => 'utlpkg.xml',
principal => 'SYSMAN',
is_grant => TRUE,
privilege => 'connect',
start_date => null,
end_date => null);
End;
/

begin
dbms_network_acl_admin.assign_acl (
acl => 'utlpkg.xml',
host => 'smtp.infranet.gov.br',
lower_port => 1,
upper_port => 10000);
end;
/

SELECT DECODE(
DBMS_NETWORK_ACL_ADMIN.check_privilege('utlpkg.xml', 'IFRDBA', 'connect'),
1, 'GRANTED', 0, 'DENIED', NULL) privilege
FROM dual
/

exec ENVIA_EMAIL ('GESTORH','banco_de_dados@infraero.gov.br','Tem empregados com novo anuenio', 'Na Regional GestorH');
