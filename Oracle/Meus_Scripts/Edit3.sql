SET SERVEROUTPUT ON
DECLARE
	--CRIA CURSOR COM TODAS AS MATRICULAS COM STATUS 2(DESLIGADO).
	CURSOR C_MAT IS
	SELECT  au_id
	,      	au_lname
	,	au_fname   
	FROM authors
	WHERE ROWNUM < 13;
	
BEGIN
FOR X IN C_MAT LOOP 
	DBMS_OUTPUT.PUT_LINE('Autor: ' || TO_CHAR(X.au_fname) || ' ' || TO_CHAR(X.au_lname) || ', Id: ' || TO_CHAR(X.au_id));
END LOOP;
END;
/

