CREATE TABLE HIERARQUIA_AGENDA (
   uor_codigo NUMBER(9),
   uor_nome VARCHAR2(100),
   uor_uor_codigo NUMBER(9),
   emp_qfu_fun_codigo number(3),
   fun_nome VARCHAR2(60),
   emp_nome VARCHAR2(60),
   ordem number(4))
/

GRANT INSERT, UPDATE, DELETE , SELECT ON HIERARQUIA_AGENDA TO RH_PERFIL_99
/

CREATE PUBLIC SYNONYM HIERARQUIA_AGENDA FOR IFRSRH.HIERARQUIA_AGENDA
/
