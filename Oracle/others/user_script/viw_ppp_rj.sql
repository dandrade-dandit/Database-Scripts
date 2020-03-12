CREATE OR REPLACE VIEW viw_ppp_rj (
   oem_emp_numero_matricula,
   oem_ofu_codigo,
   oem_data_inicio,
   oem_data_termino,
   oem_uor_codigo,
   oem_fun_codigo,
   oem_car_codigo,
   oem_car_codigo_nivel,
   oem_car_occ_codigo )
AS
SELECT OEM_EMP_NUMERO_MATRICULA,
       OEM_OFU_CODIGO,
       OEM_DATA_INICIO,
       OEM_DATA_TERMINO,
       OEM_UOR_CODIGO,
       OEM_FUN_CODIGO,
       OEM_CAR_CODIGO,
       OEM_CAR_CODIGO_NIVEL,
       OEM_CAR_OCC_CODIGO
  FROM OCORRENCIAS_EMPREGADOS,
       CADASTROS
WHERE OEM_EMP_NUMERO_MATRICULA = EMP_NUMERO_MATRICULA
  AND OEM_OFU_CODIGO IN (5,6,81,86,88,91,92,125,137,142,196,200,201,202,213,265)
  AND EMP_DEP_CODIGO_FISICO in (61,57,85,62,64,65,23,27,39,58,63,05,72,74,91,937,
  942,943,71,18,24,149,97,48,935,83,87,76,21,31,75,79,81,60,95,45,46,47,40,41)
  AND EMP_STATUS != 2
/
