CREATE OR REPLACE 
PACKAGE ifrcorp.pck_usuario
IS
   PROCEDURE prc_verifica_roles (
      p_usuario                 IN       VARCHAR2,
      p_role	                IN       VARCHAR2,
      vo_ok                     OUT      NUMBER
   );

   PROCEDURE prc_lista_roles (
      p_usuario                 IN       VARCHAR2,
      vo_ok                     OUT      NUMBER
   );	
   
END;
/


CREATE OR REPLACE 
PACKAGE BODY        ifrcorp.pck_usuario
IS
--------------------------------------------------------------------
-- 
-- 
   PROCEDURE prc_verifica_roles (
      p_usuario                 IN       VARCHAR2,
      p_role	                IN       VARCHAR2,
      vo_ok			OUT      NUMBER
   )
   IS
   	v_retorno number;
   	v_usuario varchar2(10);
   	v_role varchar2(10);
   BEGIN
   	v_usuario := p_usuario;
   	v_role := p_role;
   
      	SELECT count(1)
      	INTO v_retorno
	FROM dba_role_privs
	WHERE grantee = v_usuario
	AND granted_role = v_role;
	
	IF v_retorno > 0 THEN
		vo_ok:=1;
	 END IF;
   EXCEPTION
      WHEN NO_DATA_FOUND
      THEN
         vo_ok:=0;
      WHEN OTHERS
      THEN
         raise_application_error (-20100, SQLERRM);
   END;

--------------------------------------------------------------------
-- 
-- 
   PROCEDURE prc_lista_roles (
      p_usuario                 IN       VARCHAR2,
      p_role	                IN       VARCHAR2,
      vo_ok			OUT      NUMBER
   )
   IS
   	v_retorno varchar2(32);
   	v_usuario varchar2(10);
   BEGIN
   	v_usuario := p_usuario;

   	CURSOR C_ROLES IS
	SELECT grantee
      	INTO v_retorno
	FROM dba_role_privs
	WHERE grantee = v_usuario;
	
	IF v_retorno > 0 THEN
		vo_ok:=1;
	 END IF;
   EXCEPTION
      WHEN NO_DATA_FOUND
      THEN
         vo_ok:=0;
      WHEN OTHERS
      THEN
         raise_application_error (-20100, SQLERRM);
   END;

END;
/

-- Grants for Package
GRANT EXECUTE ON ifrcorp.pck_usuario TO public
/


