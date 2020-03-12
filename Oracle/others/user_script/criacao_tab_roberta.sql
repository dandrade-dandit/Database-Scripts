create table SEG_LOG_USUARIO_DEPENDENCIA(
	usuario			varchar2(30)
,	data_hora		date
,	acao			varchar2(1)
,	sgu_id_usuario		varchar2(10)
,	dep_cd_dependencia	number(4)
,	maquina			varchar2(64)
,	programa		varchar2(64)
,	sousuario		varchar2(15)
)
/
ALTER TABLE SEG_LOG_USUARIO_DEPENDENCIA
ADD CONSTRAINT SEG_LOG_USUARIO_DEP_PK PRIMARY KEY(usuario, data_hora, acao)
/
CREATE PUBLIC SYNONYM SEG_LOG_USUARIO_DEPENDENCIA 
       FOR IFRDBA2.SEG_LOG_USUARIO_DEPENDENCIA
/
INSERT INTO TABELAS VALUES  ('SISEG', 'SEG_LOG_USUARIO_DEPENDENCIA', 'IFRDBA2', 'TABELA')
/     


create table SEG_LOG_USUARIO_SISTEMA(
	usuario			varchar2(30)
,	data_hora		date
,	acao			varchar2(1)
,	ss_cd_sistema           number(2)
,	sgu_cd_grupo            number(2)
,	su_id_usuario           varchar2(10)
,	ds_usuario              varchar2(100)
,	id_gerente_sistema      varchar2(1)
,       maquina                 varchar2(64)
,       programa                varchar2(64)
,       sousuario               varchar2(15)
)       
/
ALTER TABLE SEG_LOG_USUARIO_SISTEMA
ADD CONSTRAINT SEG_LOG_USUARIO_SIS_PK PRIMARY KEY(usuario, data_hora, acao)
/
CREATE PUBLIC SYNONYM SEG_LOG_USUARIO_SISTEMA 
       FOR IFRDBA2.SEG_LOG_USUARIO_SISTEMA
/
INSERT INTO TABELAS VALUES  ('SISEG', 'SEG_LOG_USUARIO_SISTEMA', 'IFRDBA2', 'TABELA')
/  