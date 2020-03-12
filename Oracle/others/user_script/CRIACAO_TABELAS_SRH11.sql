CREATE TABLE tmp_Absenteismo
 (
  Usuario                   VARCHAR2(30),
  Dep_Lot_epoca             VARCHAR2(10),
  Dep_Lot_atual             VARCHAR2(10),
  Dep_fis_atual             VARCHAR2(10),
  Matricula                 NUMBER(7),
  Nome                      VARCHAR2(60),
  Sexo                      VARCHAR2(1),
  Ocorrencia                NUMBER(4),
  Descrição                 VARCHAR2(50),
  Data_Inicio               DATE,
  Data_Termino              DATE,
  UOR_Epoca                 VARCHAR2(10),
  Subord                    VARCHAR2(10),
  Tipo_exp                  NUMBER(1),
  cid_codigo                VARCHAR2(5),
  ofu_codigo                NUMBER(4)
 )
/

grant select, insert, update, delete on tmp_Absenteismo to RH_PERFIL_99;

create public synonym tmp_Absenteismo for IFRSRH.tmp_Absenteismo
/

insert into tabelas values ('SRHCAD', 'tmp_Absenteismo', 'IFRSRH', 'tabela')
/


grant execute on CARREGAR_TMP_ABSENTEISMO to RH_PERFIL_99;

create public synonym CARREGAR_TMP_ABSENTEISMO for IFRSRH.CARREGAR_TMP_ABSENTEISMO
/

insert into tabelas values ('SRHCAD', 'CARREGAR_TMP_ABSENTEISMO', 'IFRSRH', 'PROCEDURE')
/
