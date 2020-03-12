WITH 
CON_IDM_AD
AS (
SELECT upper(a.nome_logon_anterior_win2k) as nome_logon_anterior_win2k
  FROM ifrcorp.usuariosad a
 WHERE upper(a.nome_logon_usuario) LIKE 'I%'
MINUS
SELECT  'I' || LPAD(EMP_NUMERO_MATRICULA,7,'0')
  FROM  CADASTROS
 WHERE  EMP_STATUS != 2)


SELECT  *
FROM    ifrcorp.usuariosad
WHERE    nome_logon_anterior_win2k IN (
SELECT  nome_logon_anterior_win2k
FROM    CON_IDM_AD
);
