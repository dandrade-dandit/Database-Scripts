--************************************************************************
CREATE PUBLIC DATABASE LINK PRODSEDE_MIG.WORLD
  CONNECT TO ifrdba IDENTIFIED BY XPTO
  USING 'PRODSEDE'
/

--************************************************************************
INSERT INTO CADASTROS
SELECT * FROM CADASTROS@PRODSEDE_MIG.WORLD
WHERE EMP_NUMERO_MATRICULA IN (
 SELECT EMP_NUMERO_MATRICULA FROM (
   SELECT EMP_NUMERO_MATRICULA FROM CADASTROS@PRODSEDE_MIG.WORLD
   MINUS
   SELECT EMP_NUMERO_MATRICULA FROM CADASTROS
 )
)
/

--************************************************************************
INSERT INTO UNIDADES_ORGANIZACIONAIS
SELECT * FROM UNIDADES_ORGANIZACIONAIS@PRODSEDE_MIG.WORLD
WHERE UOR_CODIGO IN (
 SELECT UOR_CODIGO FROM (
   SELECT UOR_CODIGO FROM UNIDADES_ORGANIZACIONAIS@PRODSEDE_MIG.WORLD
   MINUS
   SELECT UOR_CODIGO FROM UNIDADES_ORGANIZACIONAIS 
 )
)
/

--************************************************************************
INSERT INTO UNIDADES_ORGANIZACIONAIS
SELECT * FROM UNIDADES_ORGANIZACIONAIS@PRODSEDE_MIG.WORLD
WHERE UOR_CODIGO IN (
 SELECT UOR_CODIGO FROM (
   SELECT UOR_CODIGO FROM UNIDADES_ORGANIZACIONAIS@PRODSEDE_MIG.WORLD
   MINUS
   SELECT UOR_CODIGO FROM TERCEIROS 
 )
)
/

--************************************************************************
DECLARE
   CURSOR C_CADASTROS IS
   SELECT emp_numero_matricula,
   	emp_nome_guerra,
	emp_status,
	emp_dep_codigo_lotacao,
	emp_dep_codigo_fisico,
	emp_uor_codigo_lotacao,
	emp_uor_codigo_fisico,
	emp_qfu_fun_codigo,
	emp_qlp_car_codigo,
	emp_qlp_car_occ_codigo,
	emp_qlp_car_codigo_nivel,
	emp_endereco_eletronico_mail 
   FROM CADASTROS@PRODSEDE_MIG.WORLD;


BEGIN
	
	FOR A IN C_CADASTROS LOOP

	UPDATE CADASTROS
	SET	emp_nome_guerra = A.emp_nome_guerra,
	        emp_status = A.emp_status,
	        emp_dep_codigo_lotacao = A.emp_dep_codigo_lotacao,
	        emp_dep_codigo_fisico = A.emp_dep_codigo_fisico,
	        emp_uor_codigo_lotacao = A.emp_uor_codigo_lotacao,
	        emp_uor_codigo_fisico = A.emp_uor_codigo_fisico,
	        emp_qfu_fun_codigo = A.emp_qfu_fun_codigo,
	        emp_qlp_car_codigo = A.emp_qlp_car_codigo,
	        emp_qlp_car_occ_codigo = A.emp_qlp_car_occ_codigo,
	        emp_qlp_car_codigo_nivel = A.emp_qlp_car_codigo_nivel,
	        emp_endereco_eletronico_mail = A.emp_endereco_eletronico_mail  
	WHERE  emp_numero_matricula = A.emp_numero_matricula;

	COMMIT;

	END LOOP;
END;
/


--************************************************************************
DECLARE
   CURSOR C_UNIDADES_ORGANIZACIONAIS IS
   SELECT 	UOR_CODIGO
   ,  		UOR_DATA_EXTINCAO
   FROM 	UNIDADES_ORGANIZACIONAIS@PRODSEDE_MIG.WORLD;


BEGIN
	
	FOR A IN C_UNIDADES_ORGANIZACIONAIS LOOP

	UPDATE UNIDADES_ORGANIZACIONAIS
	SET    UOR_DATA_EXTINCAO = A.UOR_DATA_EXTINCAO  
	WHERE  UOR_CODIGO = A.UOR_CODIGO;

	COMMIT;

	END LOOP;
END;
/
	
	             
--************************************************************************
DELETE FROM TERCEIROS;

INSERT INTO TERCEIROS
SELECT 	*
FROM	TERCEIROS@PRODSEDE_MIG.WORLD;

--************************************************************************
DROP PUBLIC DATABASE LINK PRODSEDE_MIG.WORLD;