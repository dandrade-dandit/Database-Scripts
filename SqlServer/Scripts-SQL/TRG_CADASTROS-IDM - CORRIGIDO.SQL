CREATE OR REPLACE TRIGGER IFRSRH.TRG_LOG_IDM 
AFTER INSERT  OR UPDATE
ON IFRSRH.cadastros
REFERENCING NEW AS NEW OLD AS OLD
FOR EACH ROW
DECLARE
  CPF_CHEFE_IMEDIATO 			VARCHAR2(11);
	MAT_CHEFE_IMEDIATO 			NUMBER(7);
  SIGLA_DEP_LOTACAO       VARCHAR2(10);
  NOME_DEP_LOTACAO        VARCHAR2(200);
  SIGLA_UOR_LOTACAO       VARCHAR2(10);
  NOME_UOR_LOTACAO        VARCHAR2(200);
  SIGLA_DEP_FISICO        VARCHAR2(10);
  NOME_DEP_FISICO         VARCHAR2(200);
  SIGLA_UOR_FISICO        VARCHAR2(10);
  NOME_UOR_FISICO         VARCHAR2(200);
  NOME_CARGO							VARCHAR2(100);
  V_NOME_EMPREGADO				VARCHAR2(300);
BEGIN
  --
    -- Altero a UOR fisica para que tenha o mesmo valor que a uor da lotacao
    IF INSERTING THEN
    SELECT B.DEP_SIGLA,
        	 B.DEP_NOME,
        	 A.UOR_NOME,
           A.UOR_SIGLA
      INTO SIGLA_DEP_LOTACAO,
        	 NOME_DEP_LOTACAO,
        	 NOME_UOR_LOTACAO,
        	 SIGLA_UOR_LOTACAO
      FROM UNIDADES_ORGANIZACIONAIS A
      INNER JOIN DEPENDENCIAS B
      ON (A.UOR_DEP_CODIGO = B.DEP_CODIGO)
      WHERE UOR_CODIGO     = :NEW.EMP_UOR_CODIGO_LOTACAO;
      SELECT B.DEP_SIGLA,
        	 B.DEP_NOME,
        	 A.UOR_NOME,
           A.UOR_SIGLA
      INTO SIGLA_DEP_FISICO,
        	 NOME_DEP_FISICO,
        	 NOME_UOR_FISICO,
        	 SIGLA_UOR_FISICO
      FROM UNIDADES_ORGANIZACIONAIS A
      INNER JOIN DEPENDENCIAS B
      ON (A.UOR_DEP_CODIGO = B.DEP_CODIGO)
      WHERE UOR_CODIGO     = :NEW.EMP_UOR_CODIGO_FISICO;
      BEGIN
          SELECT CAR_NOME 
           INTO NOME_CARGO
           FROM CARGOS
            WHERE CAR_CODIGO       = :NEW.EMP_QLP_CAR_CODIGO
              AND CAR_CODIGO_NIVEL = :NEW.EMP_QLP_CAR_CODIGO_NIVEL
              AND CAR_OCC_CODIGO   = :NEW.EMP_QLP_CAR_OCC_CODIGO;
	      EXCEPTION
          WHEN NO_DATA_FOUND THEN
            NOME_CARGO := NULL;
          when others then   
          NOME_CARGO := NULL;
        END;  
        
       BEGIN
          IF NOME_CARGO IS NULL THEN
           SELECT FUN_NOME 
           INTO NOME_CARGO
           FROM CARGOS_CONFIANCA
           WHERE FUN_CODIGO = :NEW.EMP_QFU_FUN_CODIGO ;
          END IF;
	      EXCEPTION
          WHEN NO_DATA_FOUND THEN
            NOME_CARGO := NULL;
          when others then   
          NOME_CARGO := NULL;
        END;   
        
        
      BEGIN
        SELECT DISTINCT OEM_EMP_NUMERO_MATRICULA
        INTO  MAT_CHEFE_IMEDIATO
        FROM OCORRENCIAS_EMPREGADOS
        WHERE  OEM_DATA_TERMINO IS NULL
          AND OEM_UOR_CODIGO = :NEW.EMP_UOR_CODIGO_FISICO
          AND OEM_FUN_CODIGO IN (
          ---------PRESIDENTE----------------
          689,
          ---------DIRETOR-------------------
          688,687,686,685,680,979,980,981,982,
          983,
          ---------SUPERINTENDENTE-----------
          761,762,763,764,590,591,592,593,594,
          595,596,597,598,599,607,822,754,756,
          868,869,870,871,918,945,949,970,971,
          ---------COORDENADOR---------------
          735,723,724,727,969,836,830,853,855,
          856,857,885,888,890,897,898,902,903,
          925,926,928,929,937,821,947,973,
          ---------GERENTE-------------------
          170,171,172,173,174,175,176,177,178,179,
          180,181,182,183,184,765,738,739,740,741,
          560,703,704,705,574,758,968,823,862,863,
          866,872,878,880,881,886,891,900,921,
          923,935,938,946,948,963,972,975);
		  EXCEPTION
          WHEN NO_DATA_FOUND THEN
            MAT_CHEFE_IMEDIATO := 0;
          when others then   
          MAT_CHEFE_IMEDIATO := 0;
        END;   
      IF MAT_CHEFE_IMEDIATO > 0 THEN
        BEGIN
          SELECT EMP_NUMERO_CPF
          INTO CPF_CHEFE_IMEDIATO
          FROM CADASTROS
          WHERE EMP_NUMERO_MATRICULA = MAT_CHEFE_IMEDIATO;
         EXCEPTION
            WHEN NO_DATA_FOUND THEN
              CPF_CHEFE_IMEDIATO := 0;
            when others then   
            CPF_CHEFE_IMEDIATO := 0;
          END;       
      END IF;
    INSERT INTO IFRCORP.TAB_INTERFACE_IDM (
    	NUM_CPF,
	    DAT_NASCIMENTO,
	    NUM_CARTEIRA_IDENTIDADE,
	    NOM_ORGAO_EXPEDICAO_CI,
	    NUM_TELEFONE,
	    NME_CADASTRO,
	    DSC_ENDERECO_ELETRONICO,
	    COD_DEP_LOTACAO,
	    SIG_DEP_LOTACAO,
	    NME_DEP_LOTACAO,
	    COD_DEP_FISICA,
	    SIG_DEP_FISICA,
	    NME_DEP_FISICA,
	    COD_UOR_LOTACAO,
	    SIG_UOR_LOTACAO,
	    NME_UOR_LOTACAO,
	    COD_UOR_FISICA,
	    SIG_UOR_FISICA,
	    NME_UOR_FISICA,
	    NUM_CPF_SUPERIOR_IMEDIATO,
	    DSC_SITUACAO_FUNCIONAL,
	    TIP_USUARIO,
	    STA_GERENTE,
	    DAT_ADMISSAO,
	    NME_CARGO,
	    NUM_MATRICULA,
	    NUM_MAT_SUPERIOR_IMEDIATO) 
	  VALUES (
	  	lpad(nvl(:NEW.EMP_NUMERO_CPF,'0'),11,'0') ,
	  	nvl(:NEW.EMP_DATA_NASCIMENTO,SYSDATE), 
	  	replace(replace(replace(replace(nvl(:NEW.EMP_NU_CARTEIRA_IDENTIDADE,'???'),'.',''),'-',''),'/',''),' ',''),
	  	:NEW.EMP_SIGLA_ORGAO_EMITENTE_CI || '/' ||  :NEW.EMP_UFE_SIGLA_CI,
	  	NULL,
	  	REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(INITCAP(:NEW.EMP_NOME), ' Da ', ' da '), ' De ', ' de '), ' Do ', ' do '), ' Dos ', ' dos '), ' Das ', ' das '), ' E ', ' e '),
	  	:NEW.EMP_ENDERECO_ELETRONICO_MAIL,
	  	:NEW.EMP_DEP_CODIGO_LOTACAO,
	  	SIGLA_DEP_LOTACAO,
      REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(INITCAP(NOME_DEP_LOTACAO), ' Da ', ' da '), ' De ', ' de '), ' Do ', ' do '), ' Dos ', ' dos '), ' Das ', ' das '), ' E ', ' e '), 'Ii', 'II'), 'Iii', 'III'), 'iV', 'IV'),
	  	:NEW.EMP_DEP_CODIGO_FISICO,  	
	  	SIGLA_DEP_FISICO,
	  	REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(INITCAP(NOME_DEP_FISICO), ' Da ', ' da '), ' De ', ' de '), ' Do ', ' do '), ' Dos ', ' dos '), ' Das ', ' das '), ' E ', ' e '), 'Ii', 'II'), 'Iii', 'III'), 'iV', 'IV'),
	  	:NEW.EMP_UOR_CODIGO_LOTACAO,
	  	SIGLA_UOR_LOTACAO,
	  	REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(INITCAP(NOME_UOR_LOTACAO), ' Da ', ' da '), ' De ', ' de '), ' Do ', ' do '), ' Dos ', ' dos '), ' Das ', ' das '), ' E ', ' e '), 'Ii', 'II'), 'Iii', 'III'), 'iV', 'IV'),
	  	:NEW.EMP_UOR_CODIGO_FISICO,
	  	SIGLA_UOR_FISICO,
	  	REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(INITCAP(NOME_UOR_FISICO), ' Da ', ' da '), ' De ', ' de '), ' Do ', ' do '), ' Dos ', ' dos '), ' Das ', ' das '), ' E ', ' e '), 'Ii', 'II'), 'Iii', 'III'), 'iV', 'IV'),
	  	lpad(nvl(CPF_CHEFE_IMEDIATO,'0'),11,'0'),
	  	'A',
	  	'EMPREGADO',
	  	'FALSE',
	  	:NEW.EMP_DATA_ADMISSAO,
	  	REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(INITCAP(NOME_CARGO), ' Da ', ' da '), ' De ', ' de '), ' Do ', ' do '), ' Dos ', ' dos '), ' Das ', ' das '), ' E ', ' e '), 'Ii', 'II'), 'Iii', 'III'), 'iV', 'IV'),
	  	lpad(nvl(:NEW.EMP_NUMERO_MATRICULA     ,'0'),7,'0'),
	  	lpad(nvl(MAT_CHEFE_IMEDIATO,'0'),7,'0')
	  );
   	ELSIF UPDATING THEN
      --ALTERA OS STATUS DO EMPREGADO.
      IF :OLD.emp_uor_codigo_lotacao NOT IN ( 10999999, 11645,12458,11873,12094,11845,11846,11528,11530,11531,11646,11532,11529,12427,12453,12454,12429,12095,12361,12362,12363,12836,12990,13098) THEN
          IF :NEW.EMP_STATUS = 0 THEN
            UPDATE IFRCORP.TAB_INTERFACE_IDM 
               SET dsc_situacao_funcional = 'L' 
             WHERE num_cpf = :OLD.emp_numero_cpf
               AND num_matricula = :OLD.emp_numero_matricula;
          ELSIF :NEW.EMP_STATUS = 2 THEN
            UPDATE IFRCORP.TAB_INTERFACE_IDM 
               SET dsc_situacao_funcional = 'I' 
             WHERE num_cpf = :OLD.emp_numero_cpf
               AND num_matricula = :OLD.emp_numero_matricula; 
          ELSE
            UPDATE IFRCORP.TAB_INTERFACE_IDM 
               SET dsc_situacao_funcional = 'A'
             WHERE num_cpf = :OLD.emp_numero_cpf
               AND num_matricula = :OLD.emp_numero_matricula;     
          END IF;
          
          --ALTERA O NOME DO EMPREGADO
          IF (:OLD.EMP_NOME != :NEW.EMP_NOME)  THEN
            UPDATE IFRCORP.TAB_INTERFACE_IDM 
                SET  NME_CADASTRO = REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(INITCAP(:NEW.EMP_NOME), ' Da ', ' da '), ' De ', ' de '), ' Do ', ' do '), ' Dos ', ' dos '), ' Das ', ' das '), ' E ', ' e ')
              WHERE num_cpf = :OLD.emp_numero_cpf
               AND num_matricula = :OLD.emp_numero_matricula;
          END IF;
          
          --ALTERA O EMAIL DO EMPREGADO
          IF (:OLD.EMP_ENDERECO_ELETRONICO_MAIL != :NEW.EMP_ENDERECO_ELETRONICO_MAIL)  THEN
            UPDATE IFRCORP.TAB_INTERFACE_IDM 
                SET  DSC_ENDERECO_ELETRONICO = :NEW.EMP_ENDERECO_ELETRONICO_MAIL
              WHERE num_cpf = :OLD.emp_numero_cpf
               AND num_matricula = :OLD.emp_numero_matricula;
          END IF;
          
          --ALTERA A UOR DO EMPREGADO
          IF ((:OLD.emp_uor_codigo_lotacao != :NEW.emp_uor_codigo_lotacao) OR (:OLD.emp_uor_codigo_fisico != :NEW.emp_uor_codigo_fisico)) THEN
             UPDATE IFRCORP.TAB_INTERFACE_IDM 
                SET  cod_uor_lotacao = :NEW.emp_uor_codigo_lotacao
                  ,  sig_uor_lotacao = (SELECT UOR_SIGLA FROM UNIDADES_ORGANIZACIONAIS WHERE UOR_CODIGO = :NEW.emp_uor_codigo_lotacao AND UOR_DATA_EXTINCAO IS NULL)
                  ,  nme_uor_lotacao = REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(INITCAP((SELECT UOR_NOME FROM UNIDADES_ORGANIZACIONAIS WHERE UOR_CODIGO = :NEW.emp_uor_codigo_lotacao AND UOR_DATA_EXTINCAO IS NULL)), ' Da ', ' da '), ' De ', ' de '), ' Do ', ' do '), ' Dos ', ' dos '), ' Das ', ' das '), ' E ', ' e '), 'Ii', 'II'), 'Iii', 'III'), 'iV', 'IV')
                  ,  cod_uor_fisica = :NEW.emp_uor_codigo_fisico
                  ,  sig_uor_fisica = (SELECT UOR_SIGLA FROM UNIDADES_ORGANIZACIONAIS WHERE UOR_CODIGO = :NEW.emp_uor_codigo_fisico AND UOR_DATA_EXTINCAO IS NULL)
                  ,  nme_uor_fisica = REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(INITCAP((SELECT UOR_NOME FROM UNIDADES_ORGANIZACIONAIS WHERE UOR_CODIGO = :NEW.emp_uor_codigo_fisico AND UOR_DATA_EXTINCAO IS NULL)), ' Da ', ' da '), ' De ', ' de '), ' Do ', ' do '), ' Dos ', ' dos '), ' Das ', ' das '), ' E ', ' e '), 'Ii', 'II'), 'Iii', 'III'), 'iV', 'IV')
              WHERE num_cpf = :OLD.emp_numero_cpf
               AND num_matricula = :OLD.emp_numero_matricula;
          END IF;
          
          --ALTERA A DEP E UOR DO EMPREGADO
          IF ((:OLD.emp_dep_codigo_lotacao != :NEW.emp_dep_codigo_lotacao) OR (:OLD.emp_dep_codigo_fisico != :NEW.emp_dep_codigo_fisico)) THEN
             UPDATE IFRCORP.TAB_INTERFACE_IDM 
                SET  cod_dep_lotacao = :NEW.emp_dep_codigo_lotacao
                  ,  sig_dep_lotacao = (SELECT DEP_SIGLA FROM dependencias WHERE DEP_CODIGO = :NEW.emp_dep_codigo_lotacao AND DEP_DATA_EXTINCAO IS NULL)
                  ,  nme_dep_lotacao = REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(INITCAP((SELECT DEP_NOME FROM dependencias WHERE DEP_CODIGO = :NEW.emp_dep_codigo_lotacao AND DEP_DATA_EXTINCAO IS NULL)), ' Da ', ' da '), ' De ', ' de '), ' Do ', ' do '), ' Dos ', ' dos '), ' Das ', ' das '), ' E ', ' e '), 'Ii', 'II'), 'Iii', 'III'), 'iV', 'IV')
                  ,  cod_dep_fisica = :NEW.emp_dep_codigo_fisico
                  ,  sig_dep_fisica = (SELECT DEP_SIGLA FROM dependencias WHERE DEP_CODIGO = :NEW.emp_dep_codigo_fisico AND DEP_DATA_EXTINCAO IS NULL)
                  ,  nme_dep_fisica = REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(INITCAP((SELECT DEP_NOME FROM dependencias WHERE DEP_CODIGO = :NEW.emp_dep_codigo_fisico AND DEP_DATA_EXTINCAO IS NULL)), ' Da ', ' da '), ' De ', ' de '), ' Do ', ' do '), ' Dos ', ' dos '), ' Das ', ' das '), ' E ', ' e '), 'Ii', 'II'), 'Iii', 'III'), 'iV', 'IV')
              WHERE num_cpf = :OLD.emp_numero_cpf
               AND num_matricula = :OLD.emp_numero_matricula;
          END IF;
          
          --ALTERA O CARGO DO EMPREGADO
          IF (nvl(:OLD.EMP_QFU_FUN_CODIGO,'0') != nvl(:NEW.EMP_QFU_FUN_CODIGO,'0')) THEN
          	begin
	             IF (nvl(:NEW.EMP_QFU_FUN_CODIGO,'0') = '0') THEN 
	              BEGIN
	               SELECT CAR_NOME 
	                 INTO NOME_CARGO
	                 FROM CARGOS
	                WHERE CAR_CODIGO       = :OLD.EMP_QLP_CAR_CODIGO
	                  AND CAR_CODIGO_NIVEL = :OLD.EMP_QLP_CAR_CODIGO_NIVEL
	                  AND CAR_OCC_CODIGO   = :OLD.EMP_QLP_CAR_OCC_CODIGO;
	              EXCEPTION
	                 WHEN NO_DATA_FOUND THEN
	                    NOME_CARGO := NULL;
	                 WHEN others then   
	                    NOME_CARGO := NULL;
	               END;     
	             ELSE
	              BEGIN
	               SELECT FUN_NOME 
	                 INTO NOME_CARGO
	                 FROM CARGOS_CONFIANCA
	                WHERE FUN_CODIGO = :NEW.EMP_QFU_FUN_CODIGO ;
	               EXCEPTION
	                 WHEN NO_DATA_FOUND THEN
	                    NOME_CARGO := NULL;
	                 WHEN others then   
	                    NOME_CARGO := NULL;
	               END; 
	             END IF;
	             UPDATE IFRCORP.TAB_INTERFACE_IDM 
	                SET  nme_cargo = NOME_CARGO
	               WHERE num_cpf = :OLD.emp_numero_cpf
	               AND num_matricula = :OLD.emp_numero_matricula;
						end;	               
          END IF;
          
          END IF;
    END IF;
  --
END; --End TRIGGER trg_uor_fisica 
/