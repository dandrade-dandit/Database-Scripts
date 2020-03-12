CREATE PUBLIC SYNONYM SEG_LOG_USUARIO FOR IFRBDA2.SEG_LOG_USUARIO;

create table SEG_LOG_USUARIO(
	usuario				varchar2(30)
,	data_hora			date
,	acao				varchar2(1)
,	id_usuario			varchar2(10)
,	nome_usuario			varchar2(30)
,	dep_cd_dependencia		number(4)
,	cc2_cd_centro_custo		number(5)
,	maquina			varchar2(64)
,	programa			varchar2(64)
,	sousuario			varchar2(15)
)
/


grant select on SEG_LOG_USUARIO to SISLIC_USR;