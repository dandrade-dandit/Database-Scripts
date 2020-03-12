-- Start of DDL Script for View SYSTEM.FRM45_ENABLED_ROLES
-- Generated 6-jan-2005 14:27:30 from SYSTEM@sebu93

-- Drop the old instance of FRM45_ENABLED_ROLES
DROP VIEW system.frm45_enabled_roles
/

CREATE OR REPLACE VIEW system.frm45_enabled_roles (
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

-- Grants for View
GRANT SELECT ON system.frm45_enabled_roles TO tes_adm
/
GRANT SELECT ON system.frm45_enabled_roles TO seg_cad_usr
/
GRANT SELECT ON system.frm45_enabled_roles TO pat_agente_a
/
GRANT SELECT ON system.frm45_enabled_roles TO pat_agente_b
/
GRANT SELECT ON system.frm45_enabled_roles TO pat_detentor
/
GRANT SELECT ON system.frm45_enabled_roles TO pat_ger_area
/
GRANT SELECT ON system.frm45_enabled_roles TO pat_ger_sis
/
GRANT SELECT ON system.frm45_enabled_roles TO pat_tec_custo
/
GRANT SELECT ON system.frm45_enabled_roles TO seg_geral
/
GRANT SELECT ON system.frm45_enabled_roles TO tsr_chf_ter_geral
/
GRANT SELECT ON system.frm45_enabled_roles TO mat_ate_sai_mat
/
GRANT SELECT ON system.frm45_enabled_roles TO lic_ger_sislic
/
GRANT SELECT ON system.frm45_enabled_roles TO lic_dir_ass
/
GRANT SELECT ON system.frm45_enabled_roles TO lic_sup_cn
/
GRANT SELECT ON system.frm45_enabled_roles TO lic_che_lic_cn
/
GRANT SELECT ON system.frm45_enabled_roles TO lic_fun_are_lic
/
GRANT SELECT ON system.frm45_enabled_roles TO lic_fun_inf
/
GRANT SELECT ON system.frm45_enabled_roles TO mat_ges_alm
/
GRANT SELECT ON system.frm45_enabled_roles TO mat_ger_usu
/
GRANT SELECT ON system.frm45_enabled_roles TO mat_usu_ext
/
GRANT SELECT ON system.frm45_enabled_roles TO mat_ges_sed
/
GRANT SELECT ON system.frm45_enabled_roles TO mat_ges_loc
/
GRANT SELECT ON system.frm45_enabled_roles TO mat_cat
/
GRANT SELECT ON system.frm45_enabled_roles TO mat_reg_ent
/
GRANT SELECT ON system.frm45_enabled_roles TO mat_ges_est
/
GRANT SELECT ON system.frm45_enabled_roles TO mat_ges_inv
/
GRANT SELECT ON system.frm45_enabled_roles TO tsr_emp_ter_geral
/
GRANT SELECT ON system.frm45_enabled_roles TO srh_cad_02
/
GRANT SELECT ON system.frm45_enabled_roles TO rh_perfil_99
/
GRANT SELECT ON system.frm45_enabled_roles TO srh_cad_18
/
GRANT SELECT ON system.frm45_enabled_roles TO srh_cad_17
/
GRANT SELECT ON system.frm45_enabled_roles TO srh_cad_01
/
GRANT SELECT ON system.frm45_enabled_roles TO srh_cad_03
/
GRANT SELECT ON system.frm45_enabled_roles TO srh_cad_04
/
GRANT SELECT ON system.frm45_enabled_roles TO srh_cad_05
/
GRANT SELECT ON system.frm45_enabled_roles TO srh_cad_06
/
GRANT SELECT ON system.frm45_enabled_roles TO srh_cad_10
/
GRANT SELECT ON system.frm45_enabled_roles TO srh_sfp_04
/
GRANT SELECT ON system.frm45_enabled_roles TO srh_cad_14
/
GRANT SELECT ON system.frm45_enabled_roles TO srh_ben_02
/
GRANT SELECT ON system.frm45_enabled_roles TO srh_ben_13
/
GRANT SELECT ON system.frm45_enabled_roles TO srh_sfp_03
/
GRANT SELECT ON system.frm45_enabled_roles TO srh_cad_22
/
GRANT SELECT ON system.frm45_enabled_roles TO srh_consulta
/
GRANT SELECT ON system.frm45_enabled_roles TO srh_dac_consulta
/

-- End of DDL Script for View SYSTEM.FRM45_ENABLED_ROLES

-- Start of DDL Script for View SYSTEM.FRM50_ENABLED_ROLES
-- Generated 6-jan-2005 14:27:37 from SYSTEM@sebu93

-- Drop the old instance of FRM50_ENABLED_ROLES
DROP VIEW system.frm50_enabled_roles
/

CREATE OR REPLACE VIEW system.frm50_enabled_roles (
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

-- Grants for View
GRANT SELECT ON system.frm50_enabled_roles TO public
/

-- End of DDL Script for View SYSTEM.FRM50_ENABLED_ROLES

Conn sys as sysdba

-- Start of DDL Script for View SYS.OPER_SESSOES
-- Generated 6-jan-2005 14:30:38 from SYS@MAQUINA4

-- Drop the old instance of OPER_SESSOES
DROP VIEW sys.oper_sessoes
/

CREATE OR REPLACE VIEW sys.oper_sessoes (
   sid,
   serial#,
   username,
   status,
   machine,
   program,
   audsid,
   osuser )
AS
select sid,
   serial#,
   username,
   status,
   machine,
   program,
   audsid,
   osuser From sys.v_$session
/

-- Grants for View
GRANT SELECT ON sys.oper_sessoes TO public
/

-- End of DDL Script for View SYS.OPER_SESSOES

