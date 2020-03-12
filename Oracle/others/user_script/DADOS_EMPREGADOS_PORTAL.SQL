DELETE FROM EMPREGADOS_PORTAL
/

DELETE FROM UOR_PORTAL
/

DELETE FROM DEP_PORTAL
/

INSERT INTO DEP_PORTAL
select
              "DEP_CODIGO",
              "DEP_SIGLA",
              "DEP_NOME",
              "DEP_DATA_CRIACAO",
              "DEP_DATA_EXTINCAO",
              "DEP_UFE_SIGLA",
              "DEP_DEP_CODIGO"
       from DEPENDENCIAS
/


INSERT INTO EMPREGADOS_PORTAL
select
              "EMP_NUMERO_MATRICULA",
              "EMP_NOME",
              "EMP_ENDERECO_ELETRONICO_MAIL",
              "EMP_STATUS",
              "EMP_DEP_CODIGO_LOTACAO"
       from   CADASTROS
WHERE EMP_DEP_CODIGO_LOTACAO IS NOT NULL
/


INSERT INTO UOR_PORTAL
select
              "UOR_CODIGO",
              "UOR_SIGLA",
              "UOR_NOME",
              "UOR_DATA_CRIACAO",
              "UOR_DATA_EXTINCAO",
              "UOR_UFE_SIGLA",
              "UOR_UOR_CODIGO",
              "UOR_DEP_CODIGO"
       from UNIDADES_ORGANIZACIONAIS
/

COMMIT
/
