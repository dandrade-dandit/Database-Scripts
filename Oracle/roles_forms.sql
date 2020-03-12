CREATE VIEW frm45_enabled_roles (
   role,
   flag )
AS
select urp.granted_role role,
sum(distinct decode(rrp.granted_role,
   'ORAFORMS$OSC',2,
   'ORAFORMS$BGM',4,
   'ORAFORMS$DBG',1,0)) flag
from  sys.user_role_privs urp, role_role_privs rrp
where urp.granted_role = rrp.role (+)
  and urp.granted_role not like 'ORAFORMS$%'
group by urp.granted_role
/

create public synonym FRM45_ENABLED_ROLES for system.FRM50_ENABLED_ROLES;

grant select on FRM45_ENABLED_ROLES to public;

CREATE VIEW frm50_enabled_roles (
   role,
   flag )
AS
select urp.granted_role role,
sum(distinct decode(rrp.granted_role,
   'ORAFORMS$OSC',2,
   'ORAFORMS$BGM',4,
   'ORAFORMS$DBG',1,0)) flag
from  sys.user_role_privs urp, role_role_privs rrp
where urp.granted_role = rrp.role (+)
  and urp.granted_role not like 'ORAFORMS$%'
group by urp.granted_role
/

create public synonym FRM50_ENABLED_ROLES for system.FRM50_ENABLED_ROLES;

grant select on FRM50_ENABLED_ROLES to public;

