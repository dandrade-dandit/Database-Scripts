-- informações dos usuários que solicitaram o chamado, somente para a SEDE.
CREATE OR REPLACE VIEW helpdesk.viw_solicitante_chamado (
   cod_solicitante,
   nome,
   lotacao,
   ramal )
AS
select a.EMP_NUMERO_MATRICULA 
      ,a.EMP_NOME
      ,b.UOR_SIGLA
      ,substr(lpad(f.EFC_UFF_NUMERO,8,'3'),5,4) -- pega apenas os 4 ultimos digitos - ramal
from  cadastros a , unidades_organizacionais b, 
	 (select efc_uff_numero, efc_emp_numero_matricula 
	    from empregado_fone_comercial
	   where efc_uff_tipo = 1 ) f -- fone comercial direto
where a.emp_dep_codigo_lotacao = 1 -- apenas SEDE
and   a.emp_status <> 2
and   b.uor_codigo = a.emp_uor_codigo_lotacao
and   a.emp_numero_matricula = f.efc_emp_numero_matricula(+) 
union all
select ter_cpf
      ,ter_nome
      ,uor_sigla
      ,ter_ramal
from  ( select a.ter_cpf
      ,a.ter_nome
      ,b.uor_sigla, 
	  ,a.ter_ramal, max(TER_DATA_CADASTRAMENTO)
	  from terceiros a , unidades_organizacionais b
	  where a.ter_dep_codigo_lotacao = 1 -- apenas SEDE
	  and   a.ter_status <> 2 -- (0. AFASTADO; 1. ATIVO; 2. DESLIGADO
  	  and   b.uor_codigo = a.ter_uor_codigo_lotacao
	  group by a.ter_cpf
      ,a.ter_nome
      ,b.uor_sigla
	  ,a.ter_ramal) Terceiros_Ativos
/
comment on view helpdesk.viw_solicitante_chamado is 'Esta view armazena informações dos usuários que solicitaram o chamado, somente para a SEDE.'

CREATE PUBLIC SYNONYM viw_solicitante_chamado FOR helpdesk.viw_solicitante_chamado
/

-- Armazena os técnicos e atendentes de Help Desk
CREATE OR REPLACE VIEW helpdesk.viw_tecnico_sede (
   matricula,
   nome,
   lotacao,
   situacao )
AS
select ter_cpf
      ,ter_nome
      ,uor_sigla
      ,ter_status
from  ( select a.ter_cpf
      ,a.ter_nome
      ,b.uor_sigla, 
	  ,a.ter_status, max(TER_DATA_CADASTRAMENTO)
	  from terceiros a , unidades_organizacionais b
	  where a.ter_uor_codigo_lotacao = 7061 -- apenas TIST - SUPORTE
	  and   a.ter_status <> 2 -- (0. AFASTADO; 1. ATIVO; 2. DESLIGADO
  	  and   b.uor_codigo = a.ter_uor_codigo_lotacao
	  group by a.ter_cpf
      ,a.ter_nome
      ,b.uor_sigla
	  ,a.ter_status) Terceiros_Ativos
/

comment on view helpdesk.viw_tecnicos_sede is 'Armazena os técnicos e atendentes de Help Desk.'

CREATE  SYNONYM viw_tecnicos_sede FOR helpdesk.viw_tecnicos_sede
/

--TABELA DE TÉCNICOS
create table helpdesk.cad_tecnico_helpdesk
( cod_tecnico       number not null,
  flg_atual         varchar2(1),
  flg_ativo         varchar2(1),
  flg_atendente     varchar2(1),
  dsc_senha         varchar2(10));


-- Trigger que controla a inclusão do cod_tecnico na tabela cad_tecnico_helpdesk, baseado na viw_tecnico_sede
CREATE OR REPLACE TRIGGER helpdesk.trg_tec_help_iu
 BEFORE INSERT OR UPDATE ON helpdesk.cad_tecnico_helpdesk
REFERENCING NEW AS NEW OLD AS OLD
 FOR EACH ROW
declare
 	v_qtde_reg number:=0;
Begin
    -- Verifica se o cod_tecnico existe na viw_tecnico_sede
	if (:new.cod_tecnico is not null) then
		begin
			select 	count(*)
			into	v_qtde_reg
			from	helpdesk.viw_tecnico_sede
			where	matricula = :new.cod_tecnico;
		end;
		
		if v_qtde_reg = 0 then
		   	raise_application_error(-20000,'Não existe o técnico na viw_tecnico_sede',true);
		end if;
		
	end if;
End;
/

--constraint
alter table helpdesk.cad_tecnico_helpdesk
    add constraint thd_pk primary key (cod_tecnico);

--comentários
comment on table helpdesk.cad_tecnico_helpdesk is 'Tabela que armazena os técnicos e atendentes de Help Desk';
comment on column helpdesk.cad_tecnico_helpdesk.cod_tecnico is 'Código do técnico. Originado da view viw_tecnicos_sede poderá ser o CPF se for terceirizado ou matricula se for funcionario';
comment on column helpdesk.cad_tecnico_helpdesk.flg_atual is 'Flag que informa se o técnico é o proximo a atender um chamado';
comment on column helpdesk.cad_tecnico_helpdesk.flg_ativo is 'Flag que informa se o técnico está ativo (não está de férias, atestado, dispensado)';
comment on column helpdesk.cad_tecnico_helpdesk.flg_atendente is 'Flag que informa se o técnico é atendente de Help Desk';
comment on column helpdesk.cad_tecnico_helpdesk.dsc_senha is 'Campo que armazena a senha do atendente';


--TABELA DE SITUAÇÕES
create table helpdesk.tab_situacao_chamado
( cod_situacao_chamado      number,
  dsc_situacao_chamado     varchar2(50));

--constraint
alter table helpdesk.tab_situacao_chamado
    add constraint sch_pk primary key (cod_situacao);
    
--comentarios
comment on table helpdesk.tab_situacao_chamado is 'Tabela que armazena as possíveis situações para um chamado';
comment on column helpdesk.tab_situacao_chamado.cod_situacao_chamado is 'Código da situação do chamado.';
comment on column helpdesk.tab_situacao_chamado.dsc_situacao_chamado is 'Descritivo da situação do chamado';


--TABELA PARA RECADOS
create table helpdesk.cad_recado
( seq_recado        number,
  nom_remetente     varchar2(50),
  nom_destinatario  varchar2(50),
  txt_recado        varchar2(2000),
  flg_visivel       varchar2(1));

--constraint
alter table helpdesk.cad_recado
    add constraint rec_pk primary key (seq_recado);
    
--comentários
comment on table helpdesk.cad_recado is 'Tabela que armazena os recados para os técnicos e/ou atendentes';
comment on column helpdesk.cad_recado.seq_recado is 'Código do recado. Campo auto-numerico, alimentado por uma sequence'; 
comment on column helpdesk.cad_recado.nom_remetente is 'Nome do remetente do recado';
comment on column helpdesk.cad_recado.nom_destinatario is 'Nome do destinatário do recado';
comment on column helpdesk.cad_recado.txt_recado is 'Texto descritivo que armazena o recado';
comment on column helpdesk.cad_recado.flg_visivel is 'Flag que informa se o recado ficará visível ou não';

--sequence
CREATE SEQUENCE helpdesk.seq_recado
  INCREMENT BY 1
  START WITH 1
  MINVALUE 1
  MAXVALUE 99999
  NOCYCLE
  ORDER
  NOCACHE
/

--trigger para incrementar a sequence
CREATE or replace TRIGGER helpdesk.trg_rec_i
 BEFORE
  INSERT
 ON helpdesk.CAD_RECADO
REFERENCING NEW AS NEW OLD AS OLD
 FOR EACH ROW
Begin
	 select SEQ_RECADO.nextval into :new.SEQ_RECADO from dual;
End;
/

--TABELA PARA REGISTRAR CHAMADOS
create table helpdesk.cad_chamado
( seq_chamado          number,
  dat_abertura         date,
  cod_atendente   	   number,
  cod_tecnico     	   number, 
  cod_solicitante  	   number, 
  cod_situacao_chamado number,
  dat_fechamento       date,
  txt_resumo           varchar2 (150),
  txt_motivo_chamado   varchar2 (2000),
  txt_conclusao        varchar2 (2000));

--Constraints  
alter table helpdesk.cad_chamado 
    add constraint cha_pk primary key (seq_chamado);
  
ALTER TABLE helpdesk.cad_chamado 
    ADD CONSTRAINT cha_tec_fk FOREIGN KEY (cod_tecnico)
    REFERENCES helpdesk.cad_tecnico_helpdesk (cod_tecnico);

ALTER TABLE helpdesk.cad_chamado 
    ADD CONSTRAINT cha_tec_ate_fk FOREIGN KEY (cod_atendente)
    REFERENCES helpdesk.cad_tecnico_helpdesk (cod_tecnico);

ALTER TABLE helpdesk.cad_chamado
    ADD CONSTRAINT cha_sch_fk FOREIGN KEY (cod_situacao_chamado)
    REFERENCES HELPDESK.tab_situacao_chamado (cod_situacao_chamado)
/

-- Trigger que controla a inclusão do cod_solicitante na tabela cad_chamado, baseado na viw_solicitante_chamado
CREATE OR REPLACE TRIGGER helpdesk.trg_cha_iu
 BEFORE INSERT OR UPDATE ON helpdesk.cad_chamado
REFERENCING NEW AS NEW OLD AS OLD
 FOR EACH ROW
declare
 	v_qtde_reg number:=0;
Begin
    -- Verifica se o cod_solicitante existe na viw_solicitante_chamado
	if (:new.cod_solicitante is not null) then
		begin
			select 	count(*)
			into	v_qtde_reg
			from	helpdesk.viw_solicitante_chamado
			where	cod_solicitante = :new.cod_solicitante;
		end;
		
		if v_qtde_reg = 0 then
		   	raise_application_error(-20000,'Não existe o solicitante na VIW_SOLICITANTE_CHAMADO',true);
		end if;
		
	end if;
End;
/

--Comentários
comment on table helpdesk.cad_chamado is 'Tabela para registro de chamados técnicos';
comment on column helpdesk.cad_chamado.cod_chamado is 'Código do chamando. Campo auto-numerico, alimentado por uma sequence';
comment on column helpdesk.cad_chamado.txt_motivo_chamado is 'Texto descritivo do chamado';
comment on column helpdesk.cad_chamado.txt_resumo is 'Texto descritivo com resumo do chamado';
comment on column helpdesk.cad_chamado.cod_situacao_chamado is 'Código da situação do chamado';
comment on column helpdesk.cad_chamado.cod_atendente is 'Código do atendente de Help Desk';
comment on column helpdesk.cad_chamado.cod_tecnico is 'Código do técnico de suporte responsável pelo chamado';
comment on column helpdesk.cad_chamado.cod_solicitante is 'Código do usuário que solicitou o chamado, integridade mantida por trigger';
comment on column helpdesk.cad_chamado.txt_conclusao is 'Texto descritivo que contem as ações realizadas para atender ao chamado';
comment on column helpdesk.cad_chamado.dat_abertura is 'Data e hora da abertura do chamado';
comment on column helpdesk.cad_chamado.dat_fechamento is 'Data e hora do fechamento/conclusão do chamado';


--sequence

CREATE SEQUENCE helpdesk.seq_chamado
  INCREMENT BY 1
  START WITH 1
  MINVALUE 1
  MAXVALUE 99999
  NOCYCLE
  ORDER
  NOCACHE
/
