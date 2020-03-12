CREATE OR REPLACE TRIGGER log_ocorrencias_empregados
AFTER INSERT  OR UPDATE OF 
  oem_car_codigo,
  oem_car_codigo_nivel,
  oem_car_occ_codigo,
  oem_cct_codigo,
  oem_cod_horario_empregado,
  oem_data_cancel_interrupcao,
  oem_data_inclusao,
  oem_data_inicio,
  oem_data_termino,
  oem_dep_codigo,
  oem_dep_codigo_origem,
  oem_diploma_legal,
  oem_diploma_legal_termino,
  oem_emp_nsa_codigo_nivel,
  oem_emp_nsa_codigo_padrao,
  oem_emp_nsa_in_nivel_escol,
  oem_emp_numero_matricula,
  oem_emp_numero_matricula_subst,
  oem_esc_cid_codigo,
  oem_esc_eid_codigo,
  oem_fun_codigo,
  oem_fun_codigo_acumula,
  oem_fun_codigo_substitui,
  oem_indicador_cancelamento,
  oem_indicador_onus,
  oem_motivo_cancel_interrupcao,
  oem_mov_parametro,
  oem_oem_data_inicio,
  oem_oem_emp_numero_matricula,
  oem_oem_ofu_codigo,
  oem_oex_codigo_cedido,
  oem_oex_codigo_requisitado,
  oem_ofu_codigo,
  oem_pfe_emp_num_matr_confirm1,
  oem_pfe_emp_num_matr_confirm2,
  oem_pfe_emp_num_matr_program,
  oem_pfe_sequencial_confirm1,
  oem_pfe_sequencial_confirm2,
  oem_pfe_sequencial_program,
  oem_texto,
  oem_tipo_expediente,
  oem_tipo_remuneracao_funcao,
  oem_turno_trabalho_empregado,
  oem_uor_codigo,
  oem_valor
 OR  DELETE 
ON ocorrencias_empregados
REFERENCING NEW AS NEW OLD AS OLD
FOR EACH ROW
DECLARE
  n_oem_data_inclusao                 log_ocorrencias_empregados.oem_data_inclusao%TYPE;
  n_oem_data_termino                  log_ocorrencias_empregados.oem_data_termino%TYPE;
  n_oem_texto                         log_ocorrencias_empregados.oem_texto%TYPE;
  n_oem_diploma_legal                 log_ocorrencias_empregados.oem_diploma_legal%TYPE;
  n_oem_oem_emp_numero_matricula      log_ocorrencias_empregados.oem_oem_emp_numero_matricula%TYPE;
  n_oem_oem_ofu_codigo                log_ocorrencias_empregados.oem_oem_ofu_codigo%TYPE;
  n_oem_oem_data_inicio               log_ocorrencias_empregados.oem_oem_data_inicio%TYPE;
  n_oem_emp_numero_matricula_sub      log_ocorrencias_empregados.oem_emp_numero_matricula_subst%TYPE;
  n_oem_uor_codigo                    log_ocorrencias_empregados.oem_uor_codigo%TYPE;
  n_oem_oex_codigo_cedido             log_ocorrencias_empregados.oem_oex_codigo_cedido%TYPE;
  n_oem_oex_codigo_requisitado        log_ocorrencias_empregados.oem_oex_codigo_requisitado%TYPE;
  n_oem_data_cancel_interrupcao       log_ocorrencias_empregados.oem_data_cancel_interrupcao%TYPE;
  n_oem_motivo_cancel_interrup        log_ocorrencias_empregados.oem_motivo_cancel_interrupcao %TYPE;
  n_oem_indicador_cancelamento        log_ocorrencias_empregados.oem_indicador_cancelamento%TYPE;
  n_oem_dep_codigo                    log_ocorrencias_empregados.oem_dep_codigo%TYPE;
  n_oem_indicador_onus                log_ocorrencias_empregados.oem_indicador_onus%TYPE;
  n_oem_diploma_legal_termino         log_ocorrencias_empregados.oem_diploma_legal_termino%TYPE;
  n_oem_pfe_emp_num_matr_program      log_ocorrencias_empregados.oem_pfe_emp_num_matr_program%TYPE;
  n_oem_pfe_sequencial_program        log_ocorrencias_empregados.oem_pfe_sequencial_program%TYPE;
  n_oem_pfe_emp_num_matr_confir1      log_ocorrencias_empregados.oem_pfe_emp_num_matr_confirm1%TYPE;
  n_oem_pfe_sequencial_confirm1       log_ocorrencias_empregados.oem_pfe_sequencial_confirm1%TYPE;
  n_oem_pfe_emp_num_matr_confir2      log_ocorrencias_empregados.oem_pfe_emp_num_matr_confirm2%TYPE;
  n_oem_pfe_sequencial_confirm2       log_ocorrencias_empregados.oem_pfe_sequencial_confirm2%TYPE;
  n_oem_fun_codigo                    log_ocorrencias_empregados.oem_fun_codigo%TYPE;
  n_oem_fun_codigo_substitui          log_ocorrencias_empregados.oem_fun_codigo_substitui%TYPE;
  n_oem_fun_codigo_acumula            log_ocorrencias_empregados.oem_fun_codigo_acumula%TYPE;
  n_OEM_DEP_CODIGO_ORIGEM	      log_ocorrencias_empregados.OEM_DEP_CODIGO_ORIGEM%TYPE;
  n_OEM_MOV_PARAMETRO                 log_ocorrencias_empregados.OEM_MOV_PARAMETRO%TYPE;
  n_OEM_CAR_CODIGO                    log_ocorrencias_empregados.OEM_CAR_CODIGO%TYPE;
  n_OEM_CAR_CODIGO_NIVEL              log_ocorrencias_empregados.OEM_CAR_CODIGO_NIVEL%TYPE;
  n_OEM_CAR_OCC_CODIGO                log_ocorrencias_empregados.OEM_CAR_OCC_CODIGO%TYPE;
  n_OEM_EMP_NSA_CODIGO_NIVEL          log_ocorrencias_empregados.OEM_EMP_NSA_CODIGO_NIVEL%TYPE;
  n_OEM_EMP_NSA_CODIGO_PADRAO         log_ocorrencias_empregados.OEM_EMP_NSA_CODIGO_PADRAO%TYPE;
  n_OEM_EMP_NSA_IN_NIVEL_ESCOL        log_ocorrencias_empregados.OEM_EMP_NSA_IN_NIVEL_ESCOL%TYPE;
  n_OEM_TIPO_REMUNERACAO_FUNCAO       log_ocorrencias_empregados.OEM_TIPO_REMUNERACAO_FUNCAO%TYPE;
  n_OEM_CCT_CODIGO                    log_ocorrencias_empregados.OEM_CCT_CODIGO%TYPE;
  n_OEM_VALOR                         log_ocorrencias_empregados.OEM_VALOR%TYPE;
  n_OEM_ESC_CID_CODIGO                log_ocorrencias_empregados.OEM_ESC_CID_CODIGO%TYPE;
  n_OEM_ESC_EID_CODIGO                log_ocorrencias_empregados.OEM_ESC_EID_CODIGO%TYPE;
  n_OEM_TIPO_EXPEDIENTE               log_ocorrencias_empregados.OEM_TIPO_EXPEDIENTE%TYPE;
  n_OEM_COD_HORARIO_EMPREGADO         log_ocorrencias_empregados.OEM_COD_HORARIO_EMPREGADO%TYPE;
  n_OEM_TURNO_TRABALHO_EMPREGADO      log_ocorrencias_empregados.OEM_TURNO_TRABALHO_EMPREGADO%TYPE;
BEGIN
  IF INSERTING THEN
     INSERT INTO LOG_OCORRENCIAS_EMPREGADOS (
                oem_emp_numero_matricula,
                oem_ofu_codigo,
                oem_data_inicio,
                oem_data_inclusao,
                oem_data_termino,
                oem_texto,
                oem_diploma_legal,
                oem_oem_emp_numero_matricula,
                oem_oem_ofu_codigo,
                oem_oem_data_inicio,
                oem_emp_numero_matricula_subst,
                oem_uor_codigo,
                oem_oex_codigo_cedido,
                oem_oex_codigo_requisitado,
                oem_data_cancel_interrupcao,
                oem_motivo_cancel_interrupcao,
                oem_indicador_cancelamento,
                oem_dep_codigo,
                oem_indicador_onus,
                oem_diploma_legal_termino,
                oem_pfe_emp_num_matr_program,
                oem_pfe_sequencial_program,
                oem_pfe_emp_num_matr_confirm1,
                oem_pfe_sequencial_confirm1,
                oem_pfe_emp_num_matr_confirm2,
                oem_pfe_sequencial_confirm2,
                oem_fun_codigo,
                oem_fun_codigo_substitui,
                oem_fun_codigo_acumula,
     		OEM_DEP_CODIGO_ORIGEM,
		OEM_MOV_PARAMETRO,
     		OEM_CAR_CODIGO,
     		OEM_CAR_CODIGO_NIVEL,
     		OEM_CAR_OCC_CODIGO,
     		OEM_EMP_NSA_CODIGO_NIVEL,
     		OEM_EMP_NSA_CODIGO_PADRAO,
     		OEM_EMP_NSA_IN_NIVEL_ESCOL,
     		OEM_TIPO_REMUNERACAO_FUNCAO,
     		OEM_CCT_CODIGO,
     		OEM_VALOR,
     		OEM_ESC_CID_CODIGO,
     		OEM_ESC_EID_CODIGO,
     		OEM_TIPO_EXPEDIENTE,
     		OEM_COD_HORARIO_EMPREGADO,
     		OEM_TURNO_TRABALHO_EMPREGADO,
                dta_operacao,
                tip_operacao,
                cod_usuario
                )
     VALUES
                (:new.oem_emp_numero_matricula,
                 :new.oem_ofu_codigo,
                 :new.oem_data_inicio,
                 :new.oem_data_inclusao,
                 :new.oem_data_termino,
                 :new.oem_texto,
                 :new.oem_diploma_legal,
                 :new.oem_oem_emp_numero_matricula,
                 :new.oem_oem_ofu_codigo,
                 :new.oem_oem_data_inicio,
                 :new.oem_emp_numero_matricula_subst,
                 :new.oem_uor_codigo,
                 :new.oem_oex_codigo_cedido,
                 :new.oem_oex_codigo_requisitado,
                 :new.oem_data_cancel_interrupcao,
                 :new.oem_motivo_cancel_interrupcao,
                 :new.oem_indicador_cancelamento,
                 :new.oem_dep_codigo,
                 :new.oem_indicador_onus,
                 :new.oem_diploma_legal_termino,
                 :new.oem_pfe_emp_num_matr_program,
                 :new.oem_pfe_sequencial_program,
                 :new.oem_pfe_emp_num_matr_confirm1,
                 :new.oem_pfe_sequencial_confirm1,
                 :new.oem_pfe_emp_num_matr_confirm2,
                 :new.oem_pfe_sequencial_confirm2,
                 :new.oem_fun_codigo,
                 :new.oem_fun_codigo_substitui,
                 :new.oem_fun_codigo_acumula,
     		 :new.OEM_DEP_CODIGO_ORIGEM,
                 :new.OEM_MOV_PARAMETRO,
     		 :new.OEM_CAR_CODIGO,
     		 :new.OEM_CAR_CODIGO_NIVEL,
     		 :new.OEM_CAR_OCC_CODIGO,
     		 :new.OEM_EMP_NSA_CODIGO_NIVEL,
     		 :new.OEM_EMP_NSA_CODIGO_PADRAO,
     		 :new.OEM_EMP_NSA_IN_NIVEL_ESCOL,
     		 :new.OEM_TIPO_REMUNERACAO_FUNCAO,
     		 :new.OEM_CCT_CODIGO,
     		 :new.OEM_VALOR,
     		 :new.OEM_ESC_CID_CODIGO,
     		 :new.OEM_ESC_EID_CODIGO,
     		 :new.OEM_TIPO_EXPEDIENTE,
     		 :new.OEM_COD_HORARIO_EMPREGADO,
     		 :new.OEM_TURNO_TRABALHO_EMPREGADO,
                 sysdate,
                 'I',
                 user
                );
  END IF;
  IF DELETING THEN
     INSERT INTO LOG_OCORRENCIAS_EMPREGADOS (
                oem_emp_numero_matricula,
                oem_ofu_codigo,
                oem_data_inicio,
                oem_data_inclusao,
                oem_data_termino,
                oem_texto,
                oem_diploma_legal,
                oem_oem_emp_numero_matricula,
                oem_oem_ofu_codigo,
                oem_oem_data_inicio,
                oem_emp_numero_matricula_subst,
                oem_uor_codigo,
                oem_oex_codigo_cedido,
                oem_oex_codigo_requisitado,
                oem_data_cancel_interrupcao,
                oem_motivo_cancel_interrupcao,
                oem_indicador_cancelamento,
                oem_dep_codigo,
                oem_indicador_onus,
                oem_diploma_legal_termino,
                oem_pfe_emp_num_matr_program,
                oem_pfe_sequencial_program,
                oem_pfe_emp_num_matr_confirm1,
                oem_pfe_sequencial_confirm1,
                oem_pfe_emp_num_matr_confirm2,
                oem_pfe_sequencial_confirm2,
                oem_fun_codigo,
                oem_fun_codigo_substitui,
                oem_fun_codigo_acumula,
    		OEM_DEP_CODIGO_ORIGEM,
		OEM_MOV_PARAMETRO,
     		OEM_CAR_CODIGO,
     		OEM_CAR_CODIGO_NIVEL,
     		OEM_CAR_OCC_CODIGO,
     		OEM_EMP_NSA_CODIGO_NIVEL,
     		OEM_EMP_NSA_CODIGO_PADRAO,
     		OEM_EMP_NSA_IN_NIVEL_ESCOL,
     		OEM_TIPO_REMUNERACAO_FUNCAO,
     		OEM_CCT_CODIGO,
     		OEM_VALOR,
     		OEM_ESC_CID_CODIGO,
     		OEM_ESC_EID_CODIGO,
     		OEM_TIPO_EXPEDIENTE,
     		OEM_COD_HORARIO_EMPREGADO,
     		OEM_TURNO_TRABALHO_EMPREGADO,
                dta_operacao,
                tip_operacao,
                cod_usuario
                )
     VALUES
                (:old.oem_emp_numero_matricula,
                 :old.oem_ofu_codigo,
                 :old.oem_data_inicio,
                 :old.oem_data_inclusao,
                 :old.oem_data_termino,
                 :old.oem_texto,
                 :old.oem_diploma_legal,
                 :old.oem_oem_emp_numero_matricula,
                 :old.oem_oem_ofu_codigo,
                 :old.oem_oem_data_inicio,
                 :old.oem_emp_numero_matricula_subst,
                 :old.oem_uor_codigo,
                 :old.oem_oex_codigo_cedido,
                 :old.oem_oex_codigo_requisitado,
                 :old.oem_data_cancel_interrupcao,
                 :old.oem_motivo_cancel_interrupcao,
                 :old.oem_indicador_cancelamento,
                 :old.oem_dep_codigo,
                 :old.oem_indicador_onus,
                 :old.oem_diploma_legal_termino,
                 :old.oem_pfe_emp_num_matr_program,
                 :old.oem_pfe_sequencial_program,
                 :old.oem_pfe_emp_num_matr_confirm1,
                 :old.oem_pfe_sequencial_confirm1,
                 :old.oem_pfe_emp_num_matr_confirm2,
                 :old.oem_pfe_sequencial_confirm2,
                 :old.oem_fun_codigo,
                 :old.oem_fun_codigo_substitui,
                 :old.oem_fun_codigo_acumula,
     		 :old.OEM_DEP_CODIGO_ORIGEM,
                 :old.OEM_MOV_PARAMETRO,
     		 :old.OEM_CAR_CODIGO,
     		 :old.OEM_CAR_CODIGO_NIVEL,
     		 :old.OEM_CAR_OCC_CODIGO,
     		 :old.OEM_EMP_NSA_CODIGO_NIVEL,
     		 :old.OEM_EMP_NSA_CODIGO_PADRAO,
     		 :old.OEM_EMP_NSA_IN_NIVEL_ESCOL,
     		 :old.OEM_TIPO_REMUNERACAO_FUNCAO,
     		 :old.OEM_CCT_CODIGO,
     		 :old.OEM_VALOR,
     		 :old.OEM_ESC_CID_CODIGO,
     		 :old.OEM_ESC_EID_CODIGO,
     		 :old.OEM_TIPO_EXPEDIENTE,
     		 :old.OEM_COD_HORARIO_EMPREGADO,
     		 :old.OEM_TURNO_TRABALHO_EMPREGADO,
                 sysdate,
                 'E',
                 user
                );
  END IF;
  IF UPDATING THEN
     IF :old.oem_data_inclusao = :new.oem_data_inclusao THEN
        n_oem_data_inclusao := null;
     ELSE
        n_oem_data_inclusao := :new.oem_data_inclusao;
     END IF;
     IF :old.oem_data_termino = :new.oem_data_termino THEN
        n_oem_data_termino := null;
     ELSE
        n_oem_data_termino := :new.oem_data_termino;
     END IF;
     IF :old.oem_texto = :new.oem_texto THEN
        n_oem_texto := null;
     ELSE
        n_oem_texto := :new.oem_texto;
     END IF;
     IF :old.oem_diploma_legal = :new.oem_diploma_legal THEN
        n_oem_diploma_legal := null;
     ELSE
        n_oem_diploma_legal:= :new.oem_diploma_legal;
     END IF;
     IF :old.oem_oem_emp_numero_matricula = :new.oem_oem_emp_numero_matricula THEN
        n_oem_oem_emp_numero_matricula := null;
     ELSE
        n_oem_oem_emp_numero_matricula := :new.oem_oem_emp_numero_matricula;
     END IF;
     IF :old.oem_oem_ofu_codigo = :new.oem_oem_ofu_codigo THEN
        n_oem_oem_ofu_codigo := null;
     ELSE
        n_oem_oem_ofu_codigo := :new.oem_oem_ofu_codigo;
     END IF;
     IF :old.oem_oem_data_inicio = :new.oem_oem_data_inicio THEN
        n_oem_oem_data_inicio := null;
     ELSE
        n_oem_oem_data_inicio := :new.oem_oem_data_inicio;
     END IF;
     IF :old.oem_emp_numero_matricula_subst = :new.oem_emp_numero_matricula_subst THEN
        n_oem_emp_numero_matricula_sub := null;
     ELSE
        n_oem_emp_numero_matricula_sub := :new.oem_emp_numero_matricula_subst;
     END IF;
     IF :old.oem_uor_codigo = :new.oem_uor_codigo THEN
        n_oem_uor_codigo := null;
     ELSE
        n_oem_uor_codigo := :new.oem_uor_codigo;
     END IF;
     IF :old.oem_oex_codigo_cedido = :new.oem_oex_codigo_cedido THEN
        n_oem_oex_codigo_cedido := null;
     ELSE
        n_oem_oex_codigo_cedido := :new.oem_oex_codigo_cedido;
     END IF;
     IF :old.oem_oex_codigo_requisitado = :new.oem_oex_codigo_requisitado THEN
        n_oem_oex_codigo_requisitado := null;
     ELSE
        n_oem_oex_codigo_requisitado := :new.oem_oex_codigo_requisitado;
     END IF;
     IF :old.oem_data_cancel_interrupcao = :new.oem_data_cancel_interrupcao THEN
        n_oem_data_cancel_interrupcao := null;
     ELSE
        n_oem_data_cancel_interrupcao := :new.oem_data_cancel_interrupcao;
     END IF;
     IF :old.oem_motivo_cancel_interrupcao = :new.oem_motivo_cancel_interrupcao THEN
        n_oem_motivo_cancel_interrup := null;
     ELSE
        n_oem_motivo_cancel_interrup := :new.oem_motivo_cancel_interrupcao;
     END IF;
     IF :old.oem_indicador_cancelamento = :new.oem_indicador_cancelamento THEN
        n_oem_indicador_cancelamento := null;
     ELSE
        n_oem_indicador_cancelamento := :new.oem_indicador_cancelamento;
     END IF;
     IF :old.oem_dep_codigo = :new.oem_dep_codigo THEN
        n_oem_dep_codigo := null;
     ELSE
        n_oem_dep_codigo := :new.oem_dep_codigo;
     END IF;
     IF :old.oem_indicador_onus = :new.oem_indicador_onus THEN
        n_oem_indicador_onus := null;
     ELSE
        n_oem_indicador_onus := :new.oem_indicador_onus;
     END IF;
     IF :old.oem_diploma_legal_termino = :new.oem_diploma_legal_termino THEN
        n_oem_diploma_legal_termino := null;
     ELSE
        n_oem_diploma_legal_termino := :new.oem_diploma_legal_termino;
     END IF;
     IF :old.oem_pfe_emp_num_matr_program = :new.oem_pfe_emp_num_matr_program THEN
        n_oem_pfe_emp_num_matr_program := null;
     ELSE
        n_oem_pfe_emp_num_matr_program := :new.oem_pfe_emp_num_matr_program;
     END IF;
     IF :old.oem_pfe_sequencial_program = :new.oem_pfe_sequencial_program THEN
        n_oem_pfe_sequencial_program := null;
     ELSE
        n_oem_pfe_sequencial_program := :new.oem_pfe_sequencial_program;
     END IF;
     IF :old.oem_pfe_emp_num_matr_confirm1 = :new.oem_pfe_emp_num_matr_confirm1 THEN
        n_oem_pfe_emp_num_matr_confir1 := null;
     ELSE
        n_oem_pfe_emp_num_matr_confir1 := :new.oem_pfe_emp_num_matr_confirm1;
     END IF;
     IF :old.oem_pfe_sequencial_confirm1 = :new.oem_pfe_sequencial_confirm1 THEN
        n_oem_pfe_sequencial_confirm1 := null;
     ELSE
        n_oem_pfe_sequencial_confirm1 := :new.oem_pfe_sequencial_confirm1;
     END IF;
     IF :old.oem_pfe_emp_num_matr_confirm2 = :new.oem_pfe_emp_num_matr_confirm2 THEN
        n_oem_pfe_emp_num_matr_confir2 := null;
     ELSE
        n_oem_pfe_emp_num_matr_confir2 := :new.oem_pfe_emp_num_matr_confirm2;
     END IF;
     IF :old.oem_pfe_sequencial_confirm2 = :new.oem_pfe_sequencial_confirm2 THEN
        n_oem_pfe_sequencial_confirm2 := null;
     ELSE
        n_oem_pfe_sequencial_confirm2 := :new.oem_pfe_sequencial_confirm2;
     END IF;
     IF :old.oem_fun_codigo = :new.oem_fun_codigo THEN
        n_oem_fun_codigo := null;
     ELSE
        n_oem_fun_codigo := :new.oem_fun_codigo;
     END IF;
     IF :old.oem_fun_codigo_substitui = :new.oem_fun_codigo_substitui THEN
        n_oem_fun_codigo_substitui := null;
     ELSE
        n_oem_fun_codigo_substitui := :new.oem_fun_codigo_substitui;
     END IF;
     IF :old.oem_fun_codigo_acumula = :new.oem_fun_codigo_acumula THEN
        n_oem_fun_codigo_acumula := null;
     ELSE
        n_oem_fun_codigo_acumula := :new.oem_fun_codigo_acumula;
     END IF;
     IF :old.OEM_DEP_CODIGO_ORIGEM = :new.OEM_DEP_CODIGO_ORIGEM THEN
        n_OEM_DEP_CODIGO_ORIGEM := null;
     ELSE
        n_OEM_DEP_CODIGO_ORIGEM := :new.OEM_DEP_CODIGO_ORIGEM;
     END IF;
     IF :old.OEM_MOV_PARAMETRO = :new.OEM_MOV_PARAMETRO THEN
        n_OEM_MOV_PARAMETRO := null;
     ELSE
        n_OEM_MOV_PARAMETRO := :new.OEM_MOV_PARAMETRO;
     END IF;
     IF :old.OEM_CAR_CODIGO = :new.OEM_CAR_CODIGO THEN
        n_OEM_CAR_CODIGO := null;
     ELSE
        n_OEM_CAR_CODIGO := :new.OEM_CAR_CODIGO;
     END IF;
     IF  :old.OEM_CAR_CODIGO_NIVEL = :new.OEM_CAR_CODIGO_NIVEL THEN
        n_OEM_CAR_CODIGO_NIVEL := null;
     ELSE
        n_OEM_CAR_CODIGO_NIVEL := :new.OEM_CAR_CODIGO_NIVEL;
     END IF;
     IF  :old.OEM_CAR_OCC_CODIGO = :new.OEM_CAR_OCC_CODIGO THEN
        n_OEM_CAR_OCC_CODIGO := null;
     ELSE
        n_OEM_CAR_OCC_CODIGO := :new.OEM_CAR_OCC_CODIGO;
     END IF;
     IF  :old.OEM_EMP_NSA_CODIGO_NIVEL = :new.OEM_EMP_NSA_CODIGO_NIVEL THEN
        n_OEM_EMP_NSA_CODIGO_NIVEL := null;
     ELSE
        n_OEM_EMP_NSA_CODIGO_NIVEL := :new.OEM_EMP_NSA_CODIGO_NIVEL;
     END IF;
     IF  :old.OEM_EMP_NSA_CODIGO_PADRAO = :new.OEM_EMP_NSA_CODIGO_PADRAO THEN
        n_OEM_EMP_NSA_CODIGO_PADRAO := null;
     ELSE
        n_OEM_EMP_NSA_CODIGO_PADRAO := :new.OEM_EMP_NSA_CODIGO_PADRAO;
     END IF;
     IF  :old.OEM_EMP_NSA_IN_NIVEL_ESCOL = :new.OEM_EMP_NSA_IN_NIVEL_ESCOL THEN
        n_OEM_EMP_NSA_IN_NIVEL_ESCOL := null;
     ELSE
        n_OEM_EMP_NSA_IN_NIVEL_ESCOL := :new.OEM_EMP_NSA_IN_NIVEL_ESCOL;
     END IF;
     IF  :old.OEM_TIPO_REMUNERACAO_FUNCAO = :new.OEM_TIPO_REMUNERACAO_FUNCAO THEN
        n_OEM_TIPO_REMUNERACAO_FUNCAO := null;
     ELSE
        n_OEM_TIPO_REMUNERACAO_FUNCAO := :new.OEM_TIPO_REMUNERACAO_FUNCAO;
     END IF;
     IF  :old.OEM_CCT_CODIGO = :new.OEM_CCT_CODIGO THEN
        n_OEM_CCT_CODIGO := null;
     ELSE
        n_OEM_CCT_CODIGO := :new.OEM_CCT_CODIGO;
     END IF;
     IF  :old.OEM_VALOR = :new.OEM_VALOR THEN
        n_OEM_VALOR := null;
     ELSE
        n_OEM_VALOR := :new.OEM_VALOR;
     END IF;
     IF  :old.OEM_ESC_CID_CODIGO = :new.OEM_ESC_CID_CODIGO THEN
        n_OEM_ESC_CID_CODIGO := null;
     ELSE
        n_OEM_ESC_CID_CODIGO := :new.OEM_ESC_CID_CODIGO;
     END IF;
     IF  :old.OEM_ESC_EID_CODIGO = :new.OEM_ESC_EID_CODIGO THEN
        n_OEM_ESC_EID_CODIGO := null;
     ELSE
        n_OEM_ESC_EID_CODIGO := :new.OEM_ESC_EID_CODIGO;
     END IF;
     IF  :old.OEM_TIPO_EXPEDIENTE = :new.OEM_TIPO_EXPEDIENTE THEN
        n_OEM_TIPO_EXPEDIENTE := null;
     ELSE
        n_OEM_TIPO_EXPEDIENTE := :new.OEM_TIPO_EXPEDIENTE;
     END IF;
     IF  :old.OEM_COD_HORARIO_EMPREGADO = :new.OEM_COD_HORARIO_EMPREGADO THEN
        n_OEM_COD_HORARIO_EMPREGADO := null;
     ELSE
        n_OEM_COD_HORARIO_EMPREGADO := :new.OEM_COD_HORARIO_EMPREGADO;
     END IF;
     IF  :old.OEM_TURNO_TRABALHO_EMPREGADO = :new.OEM_TURNO_TRABALHO_EMPREGADO THEN
        n_OEM_TURNO_TRABALHO_EMPREGADO := null;
     ELSE
        n_OEM_TURNO_TRABALHO_EMPREGADO := :new.OEM_TURNO_TRABALHO_EMPREGADO;
     END IF;
     INSERT INTO LOG_OCORRENCIAS_EMPREGADOS (
                oem_emp_numero_matricula,
                oem_ofu_codigo,
                oem_data_inicio,
                oem_data_inclusao,
                oem_data_termino,
                oem_texto,
                oem_diploma_legal,
                oem_oem_emp_numero_matricula,
                oem_oem_ofu_codigo,
                oem_oem_data_inicio,
                oem_emp_numero_matricula_subst,
                oem_uor_codigo,
                oem_oex_codigo_cedido,
                oem_oex_codigo_requisitado,
                oem_data_cancel_interrupcao,
                oem_motivo_cancel_interrupcao,
                oem_indicador_cancelamento,
                oem_dep_codigo,
                oem_indicador_onus,
                oem_diploma_legal_termino,
                oem_pfe_emp_num_matr_program,
                oem_pfe_sequencial_program,
                oem_pfe_emp_num_matr_confirm1,
                oem_pfe_sequencial_confirm1,
                oem_pfe_emp_num_matr_confirm2,
                oem_pfe_sequencial_confirm2,
                oem_fun_codigo,
                oem_fun_codigo_substitui,
                oem_fun_codigo_acumula,
	        OEM_DEP_CODIGO_ORIGEM,
		OEM_MOV_PARAMETRO,
	        OEM_CAR_CODIGO,
	        OEM_CAR_CODIGO_NIVEL,
	        OEM_CAR_OCC_CODIGO,
	        OEM_EMP_NSA_CODIGO_NIVEL,
	        OEM_EMP_NSA_CODIGO_PADRAO,
	        OEM_EMP_NSA_IN_NIVEL_ESCOL,
	        OEM_TIPO_REMUNERACAO_FUNCAO,
	        OEM_CCT_CODIGO,
     		OEM_VALOR,
     		OEM_ESC_CID_CODIGO,
     		OEM_ESC_EID_CODIGO,
     		OEM_TIPO_EXPEDIENTE,
     		OEM_COD_HORARIO_EMPREGADO,
     		OEM_TURNO_TRABALHO_EMPREGADO,
                dta_operacao,
                tip_operacao,
                cod_usuario
                )
      VALUES
                (:old.oem_emp_numero_matricula,
                 :old.oem_ofu_codigo,
                 :old.oem_data_inicio,
                 n_oem_data_inclusao,
                 n_oem_data_termino,
                 n_oem_texto,
                 n_oem_diploma_legal,
                 n_oem_oem_emp_numero_matricula,
                 n_oem_oem_ofu_codigo,
                 n_oem_oem_data_inicio,
                 n_oem_emp_numero_matricula_sub,
                 n_oem_uor_codigo,
                 n_oem_oex_codigo_cedido,
                 n_oem_oex_codigo_requisitado,
                 n_oem_data_cancel_interrupcao,
                 n_oem_motivo_cancel_interrup,
                 n_oem_indicador_cancelamento,
                 n_oem_dep_codigo,
                 n_oem_indicador_onus,
                 n_oem_diploma_legal_termino,
                 n_oem_pfe_emp_num_matr_program,
                 n_oem_pfe_sequencial_program,
                 n_oem_pfe_emp_num_matr_confir1,
                 n_oem_pfe_sequencial_confirm1,
                 n_oem_pfe_emp_num_matr_confir2,
                 n_oem_pfe_sequencial_confirm2,
                 n_oem_fun_codigo,
                 n_oem_fun_codigo_substitui,
                 n_oem_fun_codigo_acumula,
  	         n_OEM_DEP_CODIGO_ORIGEM,
		 n_OEM_MOV_PARAMETRO,
	         n_OEM_CAR_CODIGO,
	         n_OEM_CAR_CODIGO_NIVEL,
	         n_OEM_CAR_OCC_CODIGO,
	         n_OEM_EMP_NSA_CODIGO_NIVEL,
	         n_OEM_EMP_NSA_CODIGO_PADRAO,
	         n_OEM_EMP_NSA_IN_NIVEL_ESCOL,
	         n_OEM_TIPO_REMUNERACAO_FUNCAO,
	         n_OEM_CCT_CODIGO,
     		 n_OEM_VALOR,
     		 n_OEM_ESC_CID_CODIGO,
     		 n_OEM_ESC_EID_CODIGO,
     		 n_OEM_TIPO_EXPEDIENTE,
     		 n_OEM_COD_HORARIO_EMPREGADO,
     		 n_OEM_TURNO_TRABALHO_EMPREGADO,
                 sysdate,
                 'A',
                 user
                );
  END IF;
END;
/
