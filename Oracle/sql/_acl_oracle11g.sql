EXEC DBMS_NETWORK_ACL_ADMIN.CREATE_ACL(acl => 'send_mail.xml',description => 'send_mail ACL',principal => 'IFRSRH',is_grant => true,privilege => 'connect');
 
EXEC DBMS_NETWORK_ACL_ADMIN.ADD_PRIVILEGE(acl => 'send_mail.xml',principal => 'IFRSRH',is_grant  => true,privilege => 'resolve');
 
EXEC DBMS_NETWORK_ACL_ADMIN.ASSIGN_ACL(acl => 'send_mail.xml',host => 'smtp.infranet.gov.br'); -- this ip is out smtp server ip


grant execute on utl_smtp to ifrsrh;