SET ECHO OFF
SET HEADING OFF
SET VERIFY OFF
SET FEEDBACK OFF
SET SERVEROUTPUT ON
ACCEPT p_role PROMPT 'Entre com a Role:  '
ACCEPT p_mat PROMPT 'Entre com a Matricula:  '
DECLARE
	v_cnt number(8);
BEGIN
	SELECT 	count(1)
	INTO	v_cnt
	FROM  dba_role_privs 
	WHERE grantee = '&p_mat';
	IF v_cnt > 0 THEN
		GRANT '&p_role' TO '&p_mat';
		SELECT * FROM  dba_role_privs WHERE grantee = '&p_mat';
	END IF;
	/*
	else
		select  count(1)
		into	v_cnt
		from 	CADASTROS
		where 	EMP_STATUS <> 2
		and	EMP_NUMERO_MATRICULA = to_number(substr('&p_mat', 2));
		if (v_cnt > 0) then
			CREATE USER &p_mat IDENTIFIED BY INFRAERO
			DEFAULT TABLESPACE TS_PESSOAL
			TEMPORARY TABLESPACE TEMP
			QUOTA 0 ON TS_PESSOAL;
			GRANT &p_role TO &p_mat;
			select * from  dba_role_privs where grantee = '&p_mat';
		end if;
	end if*/
	DBMS_OUTPUT.PUT_LINE(v_cnt);
END;
/
SET SERVEROUTPUT OFF
SET FEEDBACK ON
SET VERIFY ON
SET HEADING ON
SET ECHO ON