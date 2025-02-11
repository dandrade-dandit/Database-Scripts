ALTER TABLE SISTEMA_SEG ADD (DCR_RSPNSV_SISTMA    VARCHAR2(100) NULL);

ALTER TABLE USUARIO_SEG ADD (DAT_DESATV_USUAR     DATE NULL);
ALTER TABLE USUARIO_SEG ADD (COD_LOCCLI_USUAR     VARCHAR2(20) NULL);
ALTER TABLE USUARIO_SEG ADD (MRC_AUTRSA_USUAR     VARCHAR2(1)  NULL);

CREATE TABLE LOG_SEG (
       NUM_SQNCIA_LOG       NUMBER(8) NOT NULL,
       COD_CHAVE_LOG        VARCHAR2(50) NULL,
       DAT_LOG              DATE NULL,
       COD_CHAVE_USUAR      VARCHAR2(20) NULL,
       COD_TIPOPR_LOG       VARCHAR2(20) NULL,
       DCR_CNTEUD_LOG       VARCHAR2(2000) NULL );

CREATE UNIQUE INDEX PK_LOG_SEG ON LOG_SEG
(      NUM_SQNCIA_LOG );

ALTER TABLE LOG_SEG
       ADD  ( CONSTRAINT PK_LOG_SEG PRIMARY KEY (NUM_SQNCIA_LOG) ) ;

CREATE TABLE PESSOA_SEG (
       NUM_SQNCIA_PESSOA    NUMBER(8) NOT NULL,
       COD_TIPO_PESSOA      VARCHAR2(1) NOT NULL,
       COD_PESSOA           VARCHAR2(20) NOT NULL,
       NOM_PESSOA           VARCHAR2(50) NOT NULL,
       DCR_EMAIL_PESSOA     VARCHAR2(255) NULL,
       COD_LOGIN_PESSOA     VARCHAR2(20) NULL,
       NUM_CGCCPF_PESSOA    VARCHAR2(20) NULL,
       COD_ORGAO_PESSOA     VARCHAR2(20) NULL,
       COD_CCUSTO_PESSOA    VARCHAR2(20) NULL,
       DAT_INIVAL_PESSOA    VARCHAR2(20) NULL,
       DAT_FIMVAL_PESSOA    VARCHAR2(20) NULL );

CREATE UNIQUE INDEX PK_PESSOA_SEG ON PESSOA_SEG
(      NUM_SQNCIA_PESSOA );

ALTER TABLE PESSOA_SEG
       ADD  ( CONSTRAINT PK_PESSOA_SEG PRIMARY KEY (NUM_SQNCIA_PESSOA) ) ;

ALTER TABLE ATRIBUTO_VALORES_SEG
       ADD  ( CONSTRAINT ATRBTO_ATBVLR
              FOREIGN KEY (NUM_SQNCIA_ATRBTO)
                             REFERENCES ENTIDADE_ATRIBUTO_SEG ) ;

delete profile_funcao_nivel_seg prffun
where
exists (select null from funcao_seg
        where num_funcao = prffun.num_funcao
          and cod_tipo_funcao in ('M','S'));

delete profile_funcao_seg prffun
where
exists (select null from funcao_seg
        where num_funcao = prffun.num_funcao
          and cod_tipo_funcao in ('M','S'));

delete funcao_nivel_seg prffun
where
exists (select null from funcao_seg
        where num_funcao = prffun.num_funcao
          and cod_tipo_funcao in ('M','S'));

delete funcao_seg where cod_sistma = 'SGS' and cod_tipo_funcao = 'S';

update funcao_seg set cod_situac_funcao='A' where cod_situac_funcao is null;

exec PR_INCLUI_FUNCAO_SEG('SEG','140','001.004'  ,'100' ,'F','A','Restri��o','Cadastro de Restri��o','01020304');
exec PR_INCLUI_FUNCAO_SEG('SEG','150','001.005'  ,'100' ,'F','A','Mensagem','Cadastro de Mensagem','01020304');
exec PR_INCLUI_FUNCAO_SEG('SEG','160','001.006'  ,'100' ,'F','A','Idioma','Cadastro de Idioma','01020304');
exec PR_INCLUI_FUNCAO_SEG('SEG','320','003.002'  ,'300' ,'F','A','Perfis e Fun��es de Sistema','Relat�rio de Perfis e Fun��es de Sistema','04');
exec PR_INCLUI_FUNCAO_SEG('SEG','330','003.003'  ,'300' ,'F','A','Fun��es Autorizadas a Usu�rios','Relat�rio de Fun��es Autorizadas a Usu�rios','04');
exec PR_INCLUI_FUNCAO_SEG('SEG','340','003.004'  ,'300' ,'F','A','Acessos a Sistemas','Relat�rio de Acessos a Sistemas','04');
exec PR_INCLUI_FUNCAO_SEG('SEG','350','003.005'  ,'300' ,'F','A','Perfis e Usu�rios de Sistema','Relat�rio de Perfis e Usu�rios de Sistema','04');
exec PR_INCLUI_FUNCAO_SEG('SEG','360','003.006'  ,'300' ,'F','A','Perfis Autorizados a Usu�rios','Relat�rio de Perfis Autorizados a Usu�rios','04');
exec PR_INCLUI_FUNCAO_SEG('SEG','900','004'      ,NULL  ,'M','A','Utilit�rios','Menu de Utilit�rios',NULL);
exec PR_INCLUI_FUNCAO_SEG('SEG','910','004.001'  ,'900' ,'F','A','Par�metros do Sistema','Par�metros do Sistema','04');
exec PR_INCLUI_FUNCAO_SEG('SEG','920','004.002'  ,'900' ,'F','A','Testes de Conex�o','Testes de Conex�o','04');
exec PR_INCLUI_FUNCAO_SEG('SEG','930','004.003'  ,'900' ,'F','A','Entidades','Cadastro de Entidades','04');
exec PR_INCLUI_FUNCAO_SEG('SEG','940','004.004'  ,'900' ,'F','A','Consulta LOG Altera��es','Consulta LOG Altera��es','04');
COMMIT;

update FUNCAO_SEG set COD_SQNCIA_FUNCAO = '002.003', COD_TIPO_FUNCAO = 'F', NOM_FUNCAO = 'Perfil', DCR_FUNCAO = 'Cadastro de Perfis' where COD_SISTMA = 'SEG'  and  COD_FUNCAO = '230';
update FUNCAO_SEG set COD_SQNCIA_FUNCAO = '003', COD_TIPO_FUNCAO = 'M', NOM_FUNCAO = 'Relat�rios', DCR_FUNCAO = 'Menu de Relat�rios' where COD_SISTMA = 'SEG'  and  COD_FUNCAO = '300';
update FUNCAO_SEG set COD_SQNCIA_FUNCAO = '003.001', COD_TIPO_FUNCAO = 'F', NOM_FUNCAO = 'Informa��es de Sistema', DCR_FUNCAO = 'Relat�rio de Informa��es de Sistema' where COD_SISTMA = 'SEG'  and  COD_FUNCAO = '310';
COMMIT;

insert into PROFILE_FUNCAO_SEG
(select
  COD_SISTMA,
  'ADM',
  NUM_FUNCAO  
 from
  FUNCAO_SEG
 where COD_SISTMA = 'SEG'
   and COD_FUNCAO IN ('140', '150', '160', '320', '330', '340', '350', '360', '910', '920', '930', '940')
   and COD_TIPO_FUNCAO IN ('F','P') ); 

insert into PROFILE_FUNCAO_NIVEL_SEG
(select FNCNIV.COD_SISTMA, 'ADM', FNCNIV.NUM_FUNCAO, FNCNIV.COD_NIVAUT
   from FUNCAO_NIVEL_SEG  FNCNIV,
        FUNCAO_SEG        FUNCAO
 where FNCNIV.COD_SISTMA = 'SEG'
   and FNCNIV.NUM_FUNCAO = FUNCAO.NUM_FUNCAO
   and FUNCAO.COD_FUNCAO IN ('140', '150', '160', '320', '330', '340', '350', '360', '910', '920', '930', '940'));

COMMIT;

exec PR_INCLUI_FUNCAO_SEG('SGS','1360','001.022',    '1000','F','A','Pessoa','Pessoa','01020304');
exec PR_INCLUI_FUNCAO_SEG('SGS','1370','001.023',    '1000','F','A','Usu�rio/Unidade','Usu�rio/Unidade','01020304');
exec PR_INCLUI_FUNCAO_SEG('SGS','1350','001.025.011','1500','F','A','Grupo Anat�mico','Grupo Anat�mico','01020304');
exec PR_INCLUI_FUNCAO_SEG('SGS','1380','001.025.012','1500','F','A','Dias Debitados','Dias Debitados','01020304');
exec PR_INCLUI_FUNCAO_SEG('SGS','1390','001.025.014','1500','F','A','Limide de Acidente','Limide de Acidente','01020304');
exec PR_INCLUI_FUNCAO_SEG('SGS','2380','002.003.009','2300','F','A','Manuten��o de Objetos / Coberturas','Manuten��o de Objetos / Coberturas','01020304');
exec PR_INCLUI_FUNCAO_SEG('SGS','2411','002.094.001','2400','P','A','Quitar Sinistro','Quitar Sinistro',NULL);
exec PR_INCLUI_FUNCAO_SEG('SGS','2500','002.007'    ,'2000','M','A','Ocorr�ncia','Ocorr�ncia',NULL);
exec PR_INCLUI_FUNCAO_SEG('SGS','328' ,'003.017',    '3000','F','A','Mensagens','Mensagens','04');
exec PR_INCLUI_FUNCAO_SEG('SGS','437' ,'005.003.007','4200','F','A','Demonstrativo de Endossos','Demonstrativo de Endossos','04');
exec PR_INCLUI_FUNCAO_SEG('SGS','438' ,'005.006.007','4500','F','A','Comunica��o da Ocorr�ncia','Comunica��o da Ocorr�ncia','04');
exec PR_INCLUI_FUNCAO_SEG('SGS','439' ,'005.006.008','4500','F','A','An�lise / Investiga��o','An�lise / Investiga��o','04');
exec PR_INCLUI_FUNCAO_SEG('SGS','9510','999.004',    '9900','P','A','An�lise / Investiga��o','Iniciar - An�lise / Investiga��o',NULL);

exec PR_INCLUI_FUNCAO_SEG('SGS','S001','001.004',    '1000','S','A','','',NULL);
exec PR_INCLUI_FUNCAO_SEG('SGS','S002','001.009',    '1000','S','A','','',NULL);
exec PR_INCLUI_FUNCAO_SEG('SGS','S003','001.015',    '1000','S','A','','',NULL);
exec PR_INCLUI_FUNCAO_SEG('SGS','S004','001.019',    '1000','S','A','','',NULL);
exec PR_INCLUI_FUNCAO_SEG('SGS','S005','001.021',    '1000','S','A','','',NULL);
exec PR_INCLUI_FUNCAO_SEG('SGS','S006','001.024',    '1000','S','A','','',NULL);
exec PR_INCLUI_FUNCAO_SEG('SGS','S007','002.003.004','2300','S','A','','',NULL);
exec PR_INCLUI_FUNCAO_SEG('SGS','S008','002.006'    ,'2000','S','A','','',NULL);
exec PR_INCLUI_FUNCAO_SEG('SGS','S009','002.008'    ,'2000','S','A','','',NULL);
exec PR_INCLUI_FUNCAO_SEG('SGS','S010','002.010'    ,'2000','S','A','','',NULL);
exec PR_INCLUI_FUNCAO_SEG('SGS','S011','002.010'    ,'2000','S','A','','',NULL);
exec PR_INCLUI_FUNCAO_SEG('SGS','S012','002.014',    '2000','S','A','','',NULL);
exec PR_INCLUI_FUNCAO_SEG('SGS','S013','002.014',    '2000','S','A','','',NULL);
exec PR_INCLUI_FUNCAO_SEG('SGS','S014','003.005',    '3000','S','A','','',NULL);
exec PR_INCLUI_FUNCAO_SEG('SGS','S015','003.010',    '3000','S','A','','',NULL);
exec PR_INCLUI_FUNCAO_SEG('SGS','S016','003.013',    '3000','S','A','','',NULL);
exec PR_INCLUI_FUNCAO_SEG('SGS','S017','005.008'    ,'4000','S','A','','',NULL);

COMMIT;

insert into PROFILE_FUNCAO_SEG
(select
  COD_SISTMA,
  'MASTER',
  NUM_FUNCAO  
 from
  FUNCAO_SEG
 where COD_SISTMA = 'SGS'
   and COD_FUNCAO IN ('1360', '1370', '1350', '1380', '1390', '2380', '2411', '2500', '328' , '437' , '438' , '439' , '9510')
   and COD_TIPO_FUNCAO IN ('F','P') ); 

insert into PROFILE_FUNCAO_NIVEL_SEG
(select FNCNIV.COD_SISTMA, 'MASTER', FNCNIV.NUM_FUNCAO, FNCNIV.COD_NIVAUT
   from FUNCAO_NIVEL_SEG  FNCNIV,
        FUNCAO_SEG        FUNCAO
 where FNCNIV.COD_SISTMA = 'SGS'
   and FNCNIV.NUM_FUNCAO = FUNCAO.NUM_FUNCAO
   and FUNCAO.COD_FUNCAO IN ('1360', '1370', '1350', '1380', '1390', '2380', '2411', '2500', '328' , '437' , '438' , '439' , '9510'));

COMMIT;

insert into PROFILE_FUNCAO_SEG
(select
  COD_SISTMA,
  'CN_Gerente',
  NUM_FUNCAO  
 from
  FUNCAO_SEG
 where COD_SISTMA = 'SGS'
   and COD_FUNCAO IN ('1360', '1370', '1350', '1380', '1390', '2380', '2411', '2500', '328' , '437' , '438' , '439' , '9510')
   and COD_TIPO_FUNCAO IN ('F','P') ); 

insert into PROFILE_FUNCAO_NIVEL_SEG
(select FNCNIV.COD_SISTMA, 'CN_Gerente', FNCNIV.NUM_FUNCAO, FNCNIV.COD_NIVAUT
   from FUNCAO_NIVEL_SEG  FNCNIV,
        FUNCAO_SEG        FUNCAO
 where FNCNIV.COD_SISTMA = 'SGS'
   and FNCNIV.NUM_FUNCAO = FUNCAO.NUM_FUNCAO
   and FUNCAO.COD_FUNCAO IN ('1360', '1370', '1350', '1380', '1390', '2380', '2411', '2500', '328' , '437' , '438' , '439' , '9510'));
COMMIT;

insert into PROFILE_FUNCAO_SEG
(select
  COD_SISTMA,
  'Sede_Gerente',
  NUM_FUNCAO  
 from
  FUNCAO_SEG
 where COD_SISTMA = 'SGS'
   and COD_FUNCAO IN ('1360', '1370', '1350', '1380', '1390', '2380', '2411', '2500', '328' , '437' , '438' , '439' , '9510')
   and COD_TIPO_FUNCAO IN ('F','P') ); 

insert into PROFILE_FUNCAO_NIVEL_SEG
(select FNCNIV.COD_SISTMA, 'Sede_Gerente', FNCNIV.NUM_FUNCAO, FNCNIV.COD_NIVAUT
   from FUNCAO_NIVEL_SEG  FNCNIV,
        FUNCAO_SEG        FUNCAO
 where FNCNIV.COD_SISTMA = 'SGS'
   and FNCNIV.NUM_FUNCAO = FUNCAO.NUM_FUNCAO
   and FUNCAO.COD_FUNCAO IN ('1360', '1370', '1350', '1380', '1390', '2380', '2411', '2500', '328' , '437' , '438' , '439' , '9510'));
COMMIT;

insert into PROFILE_FUNCAO_SEG
(select
  COD_SISTMA,
  'Sede_Operacional',
  NUM_FUNCAO  
 from
  FUNCAO_SEG
 where COD_SISTMA = 'SGS'
   and COD_FUNCAO IN ('1360', '1370', '1350', '1380', '1390', '2380', '2411', '2500', '328' , '437' , '438' , '439' , '9510')
   and COD_TIPO_FUNCAO IN ('F','P') ); 

insert into PROFILE_FUNCAO_NIVEL_SEG
(select FNCNIV.COD_SISTMA, 'Sede_Operacional', FNCNIV.NUM_FUNCAO, FNCNIV.COD_NIVAUT
   from FUNCAO_NIVEL_SEG  FNCNIV,
        FUNCAO_SEG        FUNCAO
 where FNCNIV.COD_SISTMA = 'SGS'
   and FNCNIV.NUM_FUNCAO = FUNCAO.NUM_FUNCAO
   and FUNCAO.COD_FUNCAO IN ('1360', '1370', '1350', '1380', '1390', '2380', '2411', '2500', '328' , '437' , '438' , '439' , '9510'));
COMMIT;

update FUNCAO_SEG set COD_SQNCIA_FUNCAO = '001', COD_TIPO_FUNCAO = 'M' where COD_SISTMA = 'SGS'  and  COD_FUNCAO = '1000';
update FUNCAO_SEG set COD_SQNCIA_FUNCAO = '001.001', COD_TIPO_FUNCAO = 'F' where COD_SISTMA = 'SGS'  and  COD_FUNCAO = '1010';
update FUNCAO_SEG set COD_SQNCIA_FUNCAO = '001.002', COD_TIPO_FUNCAO = 'F' where COD_SISTMA = 'SGS'  and  COD_FUNCAO = '1020';
update FUNCAO_SEG set COD_SQNCIA_FUNCAO = '001.003', COD_TIPO_FUNCAO = 'F' where COD_SISTMA = 'SGS'  and  COD_FUNCAO = '1030';
update FUNCAO_SEG set COD_SQNCIA_FUNCAO = '001.004', COD_TIPO_FUNCAO = 'S' where COD_SISTMA = 'SGS'  and  COD_FUNCAO = 'S001';
update FUNCAO_SEG set COD_SQNCIA_FUNCAO = '001.005', COD_TIPO_FUNCAO = 'F' where COD_SISTMA = 'SGS'  and  COD_FUNCAO = '1290';
update FUNCAO_SEG set COD_SQNCIA_FUNCAO = '001.006', COD_TIPO_FUNCAO = 'F' where COD_SISTMA = 'SGS'  and  COD_FUNCAO = '1040';
update FUNCAO_SEG set COD_SQNCIA_FUNCAO = '001.007', COD_TIPO_FUNCAO = 'F' where COD_SISTMA = 'SGS'  and  COD_FUNCAO = '1100';
update FUNCAO_SEG set COD_SQNCIA_FUNCAO = '001.008', COD_TIPO_FUNCAO = 'F' where COD_SISTMA = 'SGS'  and  COD_FUNCAO = '1170';
update FUNCAO_SEG set COD_SQNCIA_FUNCAO = '001.009', COD_TIPO_FUNCAO = 'S' where COD_SISTMA = 'SGS'  and  COD_FUNCAO = 'S002';
update FUNCAO_SEG set COD_SQNCIA_FUNCAO = '001.010', COD_TIPO_FUNCAO = 'F' where COD_SISTMA = 'SGS'  and  COD_FUNCAO = '1060';
update FUNCAO_SEG set COD_SQNCIA_FUNCAO = '001.011', COD_TIPO_FUNCAO = 'F' where COD_SISTMA = 'SGS'  and  COD_FUNCAO = '1070';
update FUNCAO_SEG set COD_SQNCIA_FUNCAO = '001.012', COD_TIPO_FUNCAO = 'F' where COD_SISTMA = 'SGS'  and  COD_FUNCAO = '1080';
update FUNCAO_SEG set COD_SQNCIA_FUNCAO = '001.013', COD_TIPO_FUNCAO = 'F' where COD_SISTMA = 'SGS'  and  COD_FUNCAO = '1140';
update FUNCAO_SEG set COD_SQNCIA_FUNCAO = '001.014', COD_TIPO_FUNCAO = 'F' where COD_SISTMA = 'SGS'  and  COD_FUNCAO = '1150';
update FUNCAO_SEG set COD_SQNCIA_FUNCAO = '001.015', COD_TIPO_FUNCAO = 'S' where COD_SISTMA = 'SGS'  and  COD_FUNCAO = 'S003';
update FUNCAO_SEG set COD_SQNCIA_FUNCAO = '001.016', COD_TIPO_FUNCAO = 'F' where COD_SISTMA = 'SGS'  and  COD_FUNCAO = '1110';
update FUNCAO_SEG set COD_SQNCIA_FUNCAO = '001.017', COD_TIPO_FUNCAO = 'F' where COD_SISTMA = 'SGS'  and  COD_FUNCAO = '1120';
update FUNCAO_SEG set COD_SQNCIA_FUNCAO = '001.018', COD_TIPO_FUNCAO = 'F' where COD_SISTMA = 'SGS'  and  COD_FUNCAO = '1130';
update FUNCAO_SEG set COD_SQNCIA_FUNCAO = '001.019', COD_TIPO_FUNCAO = 'S' where COD_SISTMA = 'SGS'  and  COD_FUNCAO = 'S004';
update FUNCAO_SEG set COD_SQNCIA_FUNCAO = '001.020', COD_TIPO_FUNCAO = 'F' where COD_SISTMA = 'SGS'  and  COD_FUNCAO = '1230';
update FUNCAO_SEG set COD_SQNCIA_FUNCAO = '001.021', COD_TIPO_FUNCAO = 'S' where COD_SISTMA = 'SGS'  and  COD_FUNCAO = 'S005';
update FUNCAO_SEG set COD_SQNCIA_FUNCAO = '001.022', COD_TIPO_FUNCAO = 'F' where COD_SISTMA = 'SGS'  and  COD_FUNCAO = '1360';
update FUNCAO_SEG set COD_SQNCIA_FUNCAO = '001.023', COD_TIPO_FUNCAO = 'F' where COD_SISTMA = 'SGS'  and  COD_FUNCAO = '1370';
update FUNCAO_SEG set COD_SQNCIA_FUNCAO = '001.024', COD_TIPO_FUNCAO = 'S' where COD_SISTMA = 'SGS'  and  COD_FUNCAO = 'S006';
update FUNCAO_SEG set COD_SQNCIA_FUNCAO = '001.025', COD_TIPO_FUNCAO = 'M' where COD_SISTMA = 'SGS'  and  COD_FUNCAO = '1500';
update FUNCAO_SEG set COD_SQNCIA_FUNCAO = '001.025.001', COD_TIPO_FUNCAO = 'F' where COD_SISTMA = 'SGS'  and  COD_FUNCAO = '1300';
update FUNCAO_SEG set COD_SQNCIA_FUNCAO = '001.025.002', COD_TIPO_FUNCAO = 'F' where COD_SISTMA = 'SGS'  and  COD_FUNCAO = '1310';
update FUNCAO_SEG set COD_SQNCIA_FUNCAO = '001.025.003', COD_TIPO_FUNCAO = 'F' where COD_SISTMA = 'SGS'  and  COD_FUNCAO = '1340';
update FUNCAO_SEG set COD_SQNCIA_FUNCAO = '001.025.004', COD_TIPO_FUNCAO = 'F' where COD_SISTMA = 'SGS'  and  COD_FUNCAO = '1190';
update FUNCAO_SEG set COD_SQNCIA_FUNCAO = '001.025.005', COD_TIPO_FUNCAO = 'F' where COD_SISTMA = 'SGS'  and  COD_FUNCAO = '1330';
update FUNCAO_SEG set COD_SQNCIA_FUNCAO = '001.025.006', COD_TIPO_FUNCAO = 'F' where COD_SISTMA = 'SGS'  and  COD_FUNCAO = '1175';
update FUNCAO_SEG set COD_SQNCIA_FUNCAO = '001.025.007', COD_TIPO_FUNCAO = 'F' where COD_SISTMA = 'SGS'  and  COD_FUNCAO = '1180';
update FUNCAO_SEG set COD_SQNCIA_FUNCAO = '001.025.008', COD_TIPO_FUNCAO = 'F' where COD_SISTMA = 'SGS'  and  COD_FUNCAO = '1090';
update FUNCAO_SEG set COD_SQNCIA_FUNCAO = '001.025.009', COD_TIPO_FUNCAO = 'F' where COD_SISTMA = 'SGS'  and  COD_FUNCAO = '1210';
update FUNCAO_SEG set COD_SQNCIA_FUNCAO = '001.025.010', COD_TIPO_FUNCAO = 'F' where COD_SISTMA = 'SGS'  and  COD_FUNCAO = '1320';
update FUNCAO_SEG set COD_SQNCIA_FUNCAO = '001.025.011', COD_TIPO_FUNCAO = 'F' where COD_SISTMA = 'SGS'  and  COD_FUNCAO = '1350';
update FUNCAO_SEG set COD_SQNCIA_FUNCAO = '001.025.012', COD_TIPO_FUNCAO = 'F' where COD_SISTMA = 'SGS'  and  COD_FUNCAO = '1380';
update FUNCAO_SEG set COD_SQNCIA_FUNCAO = '001.025.013', COD_TIPO_FUNCAO = 'F' where COD_SISTMA = 'SGS'  and  COD_FUNCAO = '1200';
update FUNCAO_SEG set COD_SQNCIA_FUNCAO = '001.025.014', COD_TIPO_FUNCAO = 'F' where COD_SISTMA = 'SGS'  and  COD_FUNCAO = '1390';
update FUNCAO_SEG set COD_SQNCIA_FUNCAO = '002', COD_TIPO_FUNCAO = 'M' where COD_SISTMA = 'SGS'  and  COD_FUNCAO = '2000';
update FUNCAO_SEG set COD_SQNCIA_FUNCAO = '002.001', COD_TIPO_FUNCAO = 'F' where COD_SISTMA = 'SGS'  and  COD_FUNCAO = '2100';
update FUNCAO_SEG set COD_SQNCIA_FUNCAO = '002.002', COD_TIPO_FUNCAO = 'F' where COD_SISTMA = 'SGS'  and  COD_FUNCAO = '2210';
update FUNCAO_SEG set COD_SQNCIA_FUNCAO = '002.092', COD_TIPO_FUNCAO = 'G' where COD_SISTMA = 'SGS'  and  COD_FUNCAO = '2200';
update FUNCAO_SEG set COD_SQNCIA_FUNCAO = '002.092.002', COD_TIPO_FUNCAO = 'P' where COD_SISTMA = 'SGS'  and  COD_FUNCAO = '2220';
update FUNCAO_SEG set COD_SQNCIA_FUNCAO = '002.092.003', COD_TIPO_FUNCAO = 'P' where COD_SISTMA = 'SGS'  and  COD_FUNCAO = '2230';
update FUNCAO_SEG set COD_SQNCIA_FUNCAO = '002.092.004', COD_TIPO_FUNCAO = 'P' where COD_SISTMA = 'SGS'  and  COD_FUNCAO = '2240';
update FUNCAO_SEG set COD_SQNCIA_FUNCAO = '002.003', COD_TIPO_FUNCAO = 'M' where COD_SISTMA = 'SGS'  and  COD_FUNCAO = '2300';
update FUNCAO_SEG set COD_SQNCIA_FUNCAO = '002.003.001', COD_TIPO_FUNCAO = 'F' where COD_SISTMA = 'SGS'  and  COD_FUNCAO = '2310';
update FUNCAO_SEG set COD_SQNCIA_FUNCAO = '002.003.002', COD_TIPO_FUNCAO = 'F' where COD_SISTMA = 'SGS'  and  COD_FUNCAO = '2320';
update FUNCAO_SEG set COD_SQNCIA_FUNCAO = '002.003.003', COD_TIPO_FUNCAO = 'F' where COD_SISTMA = 'SGS'  and  COD_FUNCAO = '2330';
update FUNCAO_SEG set COD_SQNCIA_FUNCAO = '002.003.004', COD_TIPO_FUNCAO = 'S' where COD_SISTMA = 'SGS'  and  COD_FUNCAO = 'S007';
update FUNCAO_SEG set COD_SQNCIA_FUNCAO = '002.003.005', COD_TIPO_FUNCAO = 'F' where COD_SISTMA = 'SGS'  and  COD_FUNCAO = '2340';
update FUNCAO_SEG set COD_SQNCIA_FUNCAO = '002.003.006', COD_TIPO_FUNCAO = 'F' where COD_SISTMA = 'SGS'  and  COD_FUNCAO = '2350';
update FUNCAO_SEG set COD_SQNCIA_FUNCAO = '002.003.007', COD_TIPO_FUNCAO = 'F' where COD_SISTMA = 'SGS'  and  COD_FUNCAO = '2360';
update FUNCAO_SEG set COD_SQNCIA_FUNCAO = '002.003.008', COD_TIPO_FUNCAO = 'F' where COD_SISTMA = 'SGS'  and  COD_FUNCAO = '2370';
update FUNCAO_SEG set COD_SQNCIA_FUNCAO = '002.003.009', COD_TIPO_FUNCAO = 'F' where COD_SISTMA = 'SGS'  and  COD_FUNCAO = '2380';
update FUNCAO_SEG set COD_SQNCIA_FUNCAO = '002.004', COD_TIPO_FUNCAO = 'F' where COD_SISTMA = 'SGS'  and  COD_FUNCAO = '2410';
update FUNCAO_SEG set COD_SQNCIA_FUNCAO = '002.094', COD_TIPO_FUNCAO = 'G' where COD_SISTMA = 'SGS'  and  COD_FUNCAO = '2400';
update FUNCAO_SEG set COD_SQNCIA_FUNCAO = '002.094.001', COD_TIPO_FUNCAO = 'P' where COD_SISTMA = 'SGS'  and  COD_FUNCAO = '2411';
update FUNCAO_SEG set COD_SQNCIA_FUNCAO = '002.094.002', COD_TIPO_FUNCAO = 'P' where COD_SISTMA = 'SGS'  and  COD_FUNCAO = '2420';
update FUNCAO_SEG set COD_SQNCIA_FUNCAO = '002.094.003', COD_TIPO_FUNCAO = 'P' where COD_SISTMA = 'SGS'  and  COD_FUNCAO = '2430';
update FUNCAO_SEG set COD_SQNCIA_FUNCAO = '002.094.004', COD_TIPO_FUNCAO = 'P' where COD_SISTMA = 'SGS'  and  COD_FUNCAO = '2440';
update FUNCAO_SEG set COD_SQNCIA_FUNCAO = '002.094.005', COD_TIPO_FUNCAO = 'P' where COD_SISTMA = 'SGS'  and  COD_FUNCAO = '2450';
update FUNCAO_SEG set COD_SQNCIA_FUNCAO = '002.094.006', COD_TIPO_FUNCAO = 'P' where COD_SISTMA = 'SGS'  and  COD_FUNCAO = '2460';
update FUNCAO_SEG set COD_SQNCIA_FUNCAO = '002.094.007', COD_TIPO_FUNCAO = 'P' where COD_SISTMA = 'SGS'  and  COD_FUNCAO = '2470';
update FUNCAO_SEG set COD_SQNCIA_FUNCAO = '002.094.008', COD_TIPO_FUNCAO = 'P' where COD_SISTMA = 'SGS'  and  COD_FUNCAO = '2480';
update FUNCAO_SEG set COD_SQNCIA_FUNCAO = '002.005'    , COD_TIPO_FUNCAO = 'M' where COD_SISTMA = 'SGS'  and  COD_FUNCAO = '2900';
update FUNCAO_SEG set COD_SQNCIA_FUNCAO = '002.005.001', COD_TIPO_FUNCAO = 'F' where COD_SISTMA = 'SGS'  and  COD_FUNCAO = '2910';
update FUNCAO_SEG set COD_SQNCIA_FUNCAO = '002.005.002', COD_TIPO_FUNCAO = 'F' where COD_SISTMA = 'SGS'  and  COD_FUNCAO = '2920';
update FUNCAO_SEG set COD_SQNCIA_FUNCAO = '002.005.091', COD_TIPO_FUNCAO = 'P' where COD_SISTMA = 'SGS'  and  COD_FUNCAO = '2991';
update FUNCAO_SEG set COD_SQNCIA_FUNCAO = '002.005.092', COD_TIPO_FUNCAO = 'P' where COD_SISTMA = 'SGS'  and  COD_FUNCAO = '2992';
update FUNCAO_SEG set COD_SQNCIA_FUNCAO = '002.006'    , COD_TIPO_FUNCAO = 'S' where COD_SISTMA = 'SGS'  and  COD_FUNCAO = 'S008';
update FUNCAO_SEG set COD_SQNCIA_FUNCAO = '002.007'    , COD_TIPO_FUNCAO = 'M' where COD_SISTMA = 'SGS'  and  COD_FUNCAO = '2500';
update FUNCAO_SEG set COD_SQNCIA_FUNCAO = '002.007.001', COD_TIPO_FUNCAO = 'F' where COD_SISTMA = 'SGS'  and  COD_FUNCAO = '2510';
update FUNCAO_SEG set COD_SQNCIA_FUNCAO = '002.007.002', COD_TIPO_FUNCAO = 'F' where COD_SISTMA = 'SGS'  and  COD_FUNCAO = '2520';
update FUNCAO_SEG set COD_SQNCIA_FUNCAO = '002.008'    , COD_TIPO_FUNCAO = 'S' where COD_SISTMA = 'SGS'  and  COD_FUNCAO = 'S009';
update FUNCAO_SEG set COD_SQNCIA_FUNCAO = '002.009'    , COD_TIPO_FUNCAO = 'F' where COD_SISTMA = 'SGS'  and  COD_FUNCAO = '2610';
update FUNCAO_SEG set COD_SQNCIA_FUNCAO = '002.010'    , COD_TIPO_FUNCAO = 'S' where COD_SISTMA = 'SGS'  and  COD_FUNCAO = 'S010';
update FUNCAO_SEG set COD_SQNCIA_FUNCAO = '002.011'    , COD_TIPO_FUNCAO = 'F' where COD_SISTMA = 'SGS'  and  COD_FUNCAO = '2710';
update FUNCAO_SEG set COD_SQNCIA_FUNCAO = '002.010'    , COD_TIPO_FUNCAO = 'S' where COD_SISTMA = 'SGS'  and  COD_FUNCAO = 'S011';
update FUNCAO_SEG set COD_SQNCIA_FUNCAO = '002.012'    , COD_TIPO_FUNCAO = 'M' where COD_SISTMA = 'SGS'  and  COD_FUNCAO = '2950';
update FUNCAO_SEG set COD_SQNCIA_FUNCAO = '002.012.001', COD_TIPO_FUNCAO = 'F' where COD_SISTMA = 'SGS'  and  COD_FUNCAO = '2960';
update FUNCAO_SEG set COD_SQNCIA_FUNCAO = '002.012.002', COD_TIPO_FUNCAO = 'F' where COD_SISTMA = 'SGS'  and  COD_FUNCAO = '2980';
update FUNCAO_SEG set COD_SQNCIA_FUNCAO = '002.012.003', COD_TIPO_FUNCAO = 'F' where COD_SISTMA = 'SGS'  and  COD_FUNCAO = '2990';
update FUNCAO_SEG set COD_SQNCIA_FUNCAO = '002.012.004', COD_TIPO_FUNCAO = 'F' where COD_SISTMA = 'SGS'  and  COD_FUNCAO = '2995';
update FUNCAO_SEG set COD_SQNCIA_FUNCAO = '002.012.005', COD_TIPO_FUNCAO = 'F' where COD_SISTMA = 'SGS'  and  COD_FUNCAO = '2970';
update FUNCAO_SEG set COD_SQNCIA_FUNCAO = '002.014', COD_TIPO_FUNCAO = 'S' where COD_SISTMA = 'SGS'  and  COD_FUNCAO = 'S012';
update FUNCAO_SEG set COD_SQNCIA_FUNCAO = '002.013', COD_TIPO_FUNCAO = 'F' where COD_SISTMA = 'SGS'  and  COD_FUNCAO = '2810';
update FUNCAO_SEG set COD_SQNCIA_FUNCAO = '002.014', COD_TIPO_FUNCAO = 'S' where COD_SISTMA = 'SGS'  and  COD_FUNCAO = 'S013';
update FUNCAO_SEG set COD_SQNCIA_FUNCAO = '002.015', COD_TIPO_FUNCAO = 'F' where COD_SISTMA = 'SGS'  and  COD_FUNCAO = '2940';
update FUNCAO_SEG set COD_SQNCIA_FUNCAO = '003', COD_TIPO_FUNCAO = 'M' where COD_SISTMA = 'SGS'  and  COD_FUNCAO = '3000';
update FUNCAO_SEG set COD_SQNCIA_FUNCAO = '003.001', COD_TIPO_FUNCAO = 'F' where COD_SISTMA = 'SGS'  and  COD_FUNCAO = '301';
update FUNCAO_SEG set COD_SQNCIA_FUNCAO = '003.002', COD_TIPO_FUNCAO = 'F' where COD_SISTMA = 'SGS'  and  COD_FUNCAO = '302';
update FUNCAO_SEG set COD_SQNCIA_FUNCAO = '003.003', COD_TIPO_FUNCAO = 'F' where COD_SISTMA = 'SGS'  and  COD_FUNCAO = '303';
update FUNCAO_SEG set COD_SQNCIA_FUNCAO = '003.004', COD_TIPO_FUNCAO = 'F' where COD_SISTMA = 'SGS'  and  COD_FUNCAO = '304';
update FUNCAO_SEG set COD_SQNCIA_FUNCAO = '003.005', COD_TIPO_FUNCAO = 'S' where COD_SISTMA = 'SGS'  and  COD_FUNCAO = 'S014';
update FUNCAO_SEG set COD_SQNCIA_FUNCAO = '003.006', COD_TIPO_FUNCAO = 'F' where COD_SISTMA = 'SGS'  and  COD_FUNCAO = '305';
update FUNCAO_SEG set COD_SQNCIA_FUNCAO = '003.007', COD_TIPO_FUNCAO = 'F' where COD_SISTMA = 'SGS'  and  COD_FUNCAO = '306';
update FUNCAO_SEG set COD_SQNCIA_FUNCAO = '003.008', COD_TIPO_FUNCAO = 'F' where COD_SISTMA = 'SGS'  and  COD_FUNCAO = '307';
update FUNCAO_SEG set COD_SQNCIA_FUNCAO = '003.009', COD_TIPO_FUNCAO = 'F' where COD_SISTMA = 'SGS'  and  COD_FUNCAO = '309';
update FUNCAO_SEG set COD_SQNCIA_FUNCAO = '003.010', COD_TIPO_FUNCAO = 'S' where COD_SISTMA = 'SGS'  and  COD_FUNCAO = 'S015';
update FUNCAO_SEG set COD_SQNCIA_FUNCAO = '003.011', COD_TIPO_FUNCAO = 'F' where COD_SISTMA = 'SGS'  and  COD_FUNCAO = '310';
update FUNCAO_SEG set COD_SQNCIA_FUNCAO = '003.012', COD_TIPO_FUNCAO = 'F' where COD_SISTMA = 'SGS'  and  COD_FUNCAO = '311';
update FUNCAO_SEG set COD_SQNCIA_FUNCAO = '003.013', COD_TIPO_FUNCAO = 'S' where COD_SISTMA = 'SGS'  and  COD_FUNCAO = 'S016';
update FUNCAO_SEG set COD_SQNCIA_FUNCAO = '003.014', COD_TIPO_FUNCAO = 'F' where COD_SISTMA = 'SGS'  and  COD_FUNCAO = '312';
update FUNCAO_SEG set COD_SQNCIA_FUNCAO = '003.015', COD_TIPO_FUNCAO = 'F' where COD_SISTMA = 'SGS'  and  COD_FUNCAO = '326';
update FUNCAO_SEG set COD_SQNCIA_FUNCAO = '003.016', COD_TIPO_FUNCAO = 'F' where COD_SISTMA = 'SGS'  and  COD_FUNCAO = '327';
update FUNCAO_SEG set COD_SQNCIA_FUNCAO = '003.017', COD_TIPO_FUNCAO = 'F' where COD_SISTMA = 'SGS'  and  COD_FUNCAO = '328';
update FUNCAO_SEG set COD_SQNCIA_FUNCAO = '004', COD_TIPO_FUNCAO = 'M' where COD_SISTMA = 'SGS'  and  COD_FUNCAO = '6000';
update FUNCAO_SEG set COD_SQNCIA_FUNCAO = '004.001', COD_TIPO_FUNCAO = 'F' where COD_SISTMA = 'SGS'  and  COD_FUNCAO = '313';
update FUNCAO_SEG set COD_SQNCIA_FUNCAO = '004.002', COD_TIPO_FUNCAO = 'F' where COD_SISTMA = 'SGS'  and  COD_FUNCAO = '314';
update FUNCAO_SEG set COD_SQNCIA_FUNCAO = '004.003', COD_TIPO_FUNCAO = 'F' where COD_SISTMA = 'SGS'  and  COD_FUNCAO = '319';
update FUNCAO_SEG set COD_SQNCIA_FUNCAO = '004.004', COD_TIPO_FUNCAO = 'F' where COD_SISTMA = 'SGS'  and  COD_FUNCAO = '320';
update FUNCAO_SEG set COD_SQNCIA_FUNCAO = '004.005', COD_TIPO_FUNCAO = 'F' where COD_SISTMA = 'SGS'  and  COD_FUNCAO = '317';
update FUNCAO_SEG set COD_SQNCIA_FUNCAO = '004.006', COD_TIPO_FUNCAO = 'F' where COD_SISTMA = 'SGS'  and  COD_FUNCAO = '318';
update FUNCAO_SEG set COD_SQNCIA_FUNCAO = '004.007', COD_TIPO_FUNCAO = 'F' where COD_SISTMA = 'SGS'  and  COD_FUNCAO = '322';
update FUNCAO_SEG set COD_SQNCIA_FUNCAO = '004.008', COD_TIPO_FUNCAO = 'F' where COD_SISTMA = 'SGS'  and  COD_FUNCAO = '323';
update FUNCAO_SEG set COD_SQNCIA_FUNCAO = '004.009', COD_TIPO_FUNCAO = 'F' where COD_SISTMA = 'SGS'  and  COD_FUNCAO = '324';
update FUNCAO_SEG set COD_SQNCIA_FUNCAO = '004.010', COD_TIPO_FUNCAO = 'F' where COD_SISTMA = 'SGS'  and  COD_FUNCAO = '325';
update FUNCAO_SEG set COD_SQNCIA_FUNCAO = '005', COD_TIPO_FUNCAO = 'M' where COD_SISTMA = 'SGS'  and  COD_FUNCAO = '4000';
update FUNCAO_SEG set COD_SQNCIA_FUNCAO = '005.001', COD_TIPO_FUNCAO = 'M' where COD_SISTMA = 'SGS'  and  COD_FUNCAO = '4100';
update FUNCAO_SEG set COD_SQNCIA_FUNCAO = '005.001.001', COD_TIPO_FUNCAO = 'F' where COD_SISTMA = 'SGS'  and  COD_FUNCAO = '401';
update FUNCAO_SEG set COD_SQNCIA_FUNCAO = '005.001.002', COD_TIPO_FUNCAO = 'F' where COD_SISTMA = 'SGS'  and  COD_FUNCAO = '402';
update FUNCAO_SEG set COD_SQNCIA_FUNCAO = '005.002', COD_TIPO_FUNCAO = 'F' where COD_SISTMA = 'SGS'  and  COD_FUNCAO = '421';
update FUNCAO_SEG set COD_SQNCIA_FUNCAO = '005.003', COD_TIPO_FUNCAO = 'M' where COD_SISTMA = 'SGS'  and  COD_FUNCAO = '4200';
update FUNCAO_SEG set COD_SQNCIA_FUNCAO = '005.003.001', COD_TIPO_FUNCAO = 'F' where COD_SISTMA = 'SGS'  and  COD_FUNCAO = '403';
update FUNCAO_SEG set COD_SQNCIA_FUNCAO = '005.003.002', COD_TIPO_FUNCAO = 'F' where COD_SISTMA = 'SGS'  and  COD_FUNCAO = '404';
update FUNCAO_SEG set COD_SQNCIA_FUNCAO = '005.003.003', COD_TIPO_FUNCAO = 'F' where COD_SISTMA = 'SGS'  and  COD_FUNCAO = '422';
update FUNCAO_SEG set COD_SQNCIA_FUNCAO = '005.003.004', COD_TIPO_FUNCAO = 'F' where COD_SISTMA = 'SGS'  and  COD_FUNCAO = '405';
update FUNCAO_SEG set COD_SQNCIA_FUNCAO = '005.003.005', COD_TIPO_FUNCAO = 'F' where COD_SISTMA = 'SGS'  and  COD_FUNCAO = '406';
update FUNCAO_SEG set COD_SQNCIA_FUNCAO = '005.003.006', COD_TIPO_FUNCAO = 'F' where COD_SISTMA = 'SGS'  and  COD_FUNCAO = '409';
update FUNCAO_SEG set COD_SQNCIA_FUNCAO = '005.003.007', COD_TIPO_FUNCAO = 'F' where COD_SISTMA = 'SGS'  and  COD_FUNCAO = '437';
update FUNCAO_SEG set COD_SQNCIA_FUNCAO = '005.004', COD_TIPO_FUNCAO = 'M' where COD_SISTMA = 'SGS'  and  COD_FUNCAO = '4300';
update FUNCAO_SEG set COD_SQNCIA_FUNCAO = '005.004.001', COD_TIPO_FUNCAO = 'F' where COD_SISTMA = 'SGS'  and  COD_FUNCAO = '407';
update FUNCAO_SEG set COD_SQNCIA_FUNCAO = '005.004.002', COD_TIPO_FUNCAO = 'F' where COD_SISTMA = 'SGS'  and  COD_FUNCAO = '408';
update FUNCAO_SEG set COD_SQNCIA_FUNCAO = '005.005', COD_TIPO_FUNCAO = 'M' where COD_SISTMA = 'SGS'  and  COD_FUNCAO = '4400';
update FUNCAO_SEG set COD_SQNCIA_FUNCAO = '005.005.001', COD_TIPO_FUNCAO = 'F' where COD_SISTMA = 'SGS'  and  COD_FUNCAO = '410';
update FUNCAO_SEG set COD_SQNCIA_FUNCAO = '005.005.002', COD_TIPO_FUNCAO = 'F' where COD_SISTMA = 'SGS'  and  COD_FUNCAO = '432';
update FUNCAO_SEG set COD_SQNCIA_FUNCAO = '005.005.003', COD_TIPO_FUNCAO = 'F' where COD_SISTMA = 'SGS'  and  COD_FUNCAO = '411';
update FUNCAO_SEG set COD_SQNCIA_FUNCAO = '005.005.004', COD_TIPO_FUNCAO = 'F' where COD_SISTMA = 'SGS'  and  COD_FUNCAO = '412';
update FUNCAO_SEG set COD_SQNCIA_FUNCAO = '005.005.005', COD_TIPO_FUNCAO = 'F' where COD_SISTMA = 'SGS'  and  COD_FUNCAO = '413';
update FUNCAO_SEG set COD_SQNCIA_FUNCAO = '005.005.006', COD_TIPO_FUNCAO = 'F' where COD_SISTMA = 'SGS'  and  COD_FUNCAO = '414';
update FUNCAO_SEG set COD_SQNCIA_FUNCAO = '005.005.007', COD_TIPO_FUNCAO = 'F' where COD_SISTMA = 'SGS'  and  COD_FUNCAO = '415';
update FUNCAO_SEG set COD_SQNCIA_FUNCAO = '005.005.008', COD_TIPO_FUNCAO = 'F' where COD_SISTMA = 'SGS'  and  COD_FUNCAO = '416';
update FUNCAO_SEG set COD_SQNCIA_FUNCAO = '005.005.009', COD_TIPO_FUNCAO = 'F' where COD_SISTMA = 'SGS'  and  COD_FUNCAO = '417';
update FUNCAO_SEG set COD_SQNCIA_FUNCAO = '005.005.010', COD_TIPO_FUNCAO = 'F' where COD_SISTMA = 'SGS'  and  COD_FUNCAO = '418';
update FUNCAO_SEG set COD_SQNCIA_FUNCAO = '005.005.011', COD_TIPO_FUNCAO = 'F' where COD_SISTMA = 'SGS'  and  COD_FUNCAO = '434';
update FUNCAO_SEG set COD_SQNCIA_FUNCAO = '005.005.012', COD_TIPO_FUNCAO = 'F' where COD_SISTMA = 'SGS'  and  COD_FUNCAO = '435';
update FUNCAO_SEG set COD_SQNCIA_FUNCAO = '005.005.013', COD_TIPO_FUNCAO = 'F' where COD_SISTMA = 'SGS'  and  COD_FUNCAO = '436';
update FUNCAO_SEG set COD_SQNCIA_FUNCAO = '005.006', COD_TIPO_FUNCAO = 'M' where COD_SISTMA = 'SGS'  and  COD_FUNCAO = '4500';
update FUNCAO_SEG set COD_SQNCIA_FUNCAO = '005.006.001', COD_TIPO_FUNCAO = 'F' where COD_SISTMA = 'SGS'  and  COD_FUNCAO = '419';
update FUNCAO_SEG set COD_SQNCIA_FUNCAO = '005.006.002', COD_TIPO_FUNCAO = 'F' where COD_SISTMA = 'SGS'  and  COD_FUNCAO = '427';
update FUNCAO_SEG set COD_SQNCIA_FUNCAO = '005.006.003', COD_TIPO_FUNCAO = 'F' where COD_SISTMA = 'SGS'  and  COD_FUNCAO = '428';
update FUNCAO_SEG set COD_SQNCIA_FUNCAO = '005.006.004', COD_TIPO_FUNCAO = 'F' where COD_SISTMA = 'SGS'  and  COD_FUNCAO = '429';
update FUNCAO_SEG set COD_SQNCIA_FUNCAO = '005.006.005', COD_TIPO_FUNCAO = 'F' where COD_SISTMA = 'SGS'  and  COD_FUNCAO = '430';
update FUNCAO_SEG set COD_SQNCIA_FUNCAO = '005.006.006', COD_TIPO_FUNCAO = 'F' where COD_SISTMA = 'SGS'  and  COD_FUNCAO = '431';
update FUNCAO_SEG set COD_SQNCIA_FUNCAO = '005.006.007', COD_TIPO_FUNCAO = 'F' where COD_SISTMA = 'SGS'  and  COD_FUNCAO = '438';
update FUNCAO_SEG set COD_SQNCIA_FUNCAO = '005.006.008', COD_TIPO_FUNCAO = 'F' where COD_SISTMA = 'SGS'  and  COD_FUNCAO = '439';
update FUNCAO_SEG set COD_SQNCIA_FUNCAO = '005.007', COD_TIPO_FUNCAO = 'M' where COD_SISTMA = 'SGS'  and  COD_FUNCAO = '4600';
update FUNCAO_SEG set COD_SQNCIA_FUNCAO = '005.007.001', COD_TIPO_FUNCAO = 'F' where COD_SISTMA = 'SGS'  and  COD_FUNCAO = '425';
update FUNCAO_SEG set COD_SQNCIA_FUNCAO = '005.007.002', COD_TIPO_FUNCAO = 'F' where COD_SISTMA = 'SGS'  and  COD_FUNCAO = '426';
update FUNCAO_SEG set COD_SQNCIA_FUNCAO = '005.008'    , COD_TIPO_FUNCAO = 'S' where COD_SISTMA = 'SGS'  and  COD_FUNCAO = 'S017';
update FUNCAO_SEG set COD_SQNCIA_FUNCAO = '005.009'    , COD_TIPO_FUNCAO = 'F' where COD_SISTMA = 'SGS'  and  COD_FUNCAO = '423';
update FUNCAO_SEG set COD_SQNCIA_FUNCAO = '005.010'    , COD_TIPO_FUNCAO = 'F' where COD_SISTMA = 'SGS'  and  COD_FUNCAO = '420';
update FUNCAO_SEG set COD_SQNCIA_FUNCAO = '005.011'    , COD_TIPO_FUNCAO = 'F' where COD_SISTMA = 'SGS'  and  COD_FUNCAO = '433';
update FUNCAO_SEG set COD_SQNCIA_FUNCAO = '006', COD_TIPO_FUNCAO = 'M' where COD_SISTMA = 'SGS'  and  COD_FUNCAO = '5000';
update FUNCAO_SEG set COD_SQNCIA_FUNCAO = '006.001', COD_TIPO_FUNCAO = 'F' where COD_SISTMA = 'SGS'  and  COD_FUNCAO = '1160';
update FUNCAO_SEG set COD_SQNCIA_FUNCAO = '006.002', COD_TIPO_FUNCAO = 'F' where COD_SISTMA = 'SGS'  and  COD_FUNCAO = '510';
update FUNCAO_SEG set COD_SQNCIA_FUNCAO = '006.003', COD_TIPO_FUNCAO = 'F' where COD_SISTMA = 'SGS'  and  COD_FUNCAO = '520';
update FUNCAO_SEG set COD_SQNCIA_FUNCAO = '006.004', COD_TIPO_FUNCAO = 'F' where COD_SISTMA = 'SGS'  and  COD_FUNCAO = '2820';
update FUNCAO_SEG set COD_SQNCIA_FUNCAO = '006.005', COD_TIPO_FUNCAO = 'F' where COD_SISTMA = 'SGS'  and  COD_FUNCAO = '321';
update FUNCAO_SEG set COD_SQNCIA_FUNCAO = '006.006', COD_TIPO_FUNCAO = 'F' where COD_SISTMA = 'SGS'  and  COD_FUNCAO = '540';
update FUNCAO_SEG set COD_SQNCIA_FUNCAO = '006.007', COD_TIPO_FUNCAO = 'F' where COD_SISTMA = 'SGS'  and  COD_FUNCAO = '550';
update FUNCAO_SEG set COD_SQNCIA_FUNCAO = '999', COD_TIPO_FUNCAO = 'M' where COD_SISTMA = 'SGS'  and  COD_FUNCAO = '9900';
update FUNCAO_SEG set COD_SQNCIA_FUNCAO = '999.001', COD_TIPO_FUNCAO = 'P' where COD_SISTMA = 'SGS'  and  COD_FUNCAO = '9901';
update FUNCAO_SEG set COD_SQNCIA_FUNCAO = '999.002', COD_TIPO_FUNCAO = 'P' where COD_SISTMA = 'SGS'  and  COD_FUNCAO = '9130';
update FUNCAO_SEG set COD_SQNCIA_FUNCAO = '999.003', COD_TIPO_FUNCAO = 'P' where COD_SISTMA = 'SGS'  and  COD_FUNCAO = '9370';
update FUNCAO_SEG set COD_SQNCIA_FUNCAO = '999.004', COD_TIPO_FUNCAO = 'P' where COD_SISTMA = 'SGS'  and  COD_FUNCAO = '9510';
update FUNCAO_SEG set COD_SQNCIA_FUNCAO = '999.005', COD_TIPO_FUNCAO = 'P' where COD_SISTMA = 'SGS'  and  COD_FUNCAO = '9940';

COMMIT;

/* Adicionando restri��o */

exec PR_INCLUI_FUNCAO_SEG('SEG','RESTRICAO','000'      ,NULL  ,'R',NULL,'Restricoes do Sistema','Restricoes do Sistema',NULL);

insert into restricao_seg (NUM_SQNCIA_RESTRC,COD_RESTRC,COD_SISTMA,DCR_RESTRC) values (1,'SISTMA','SEG','Sistemas do Security');

insert into valores_restricao_seg (NUM_SQNCIA_RESVLR,NUM_SQNCIA_RESTRC,DCR_CNTEUD_RESVLR,DCR_OBSERV_RESVLR) values (1,1,'SEG','Seguran�a');
insert into valores_restricao_seg (NUM_SQNCIA_RESVLR,NUM_SQNCIA_RESTRC,DCR_CNTEUD_RESVLR,DCR_OBSERV_RESVLR) values (2,1,'SGS','SGS Produ��o');

insert into funcao_restricao_seg (num_sqncia_fncres,num_funcao,num_sqncia_restrc)
 select 1, num_funcao, 1 from funcao_seg
  where cod_sistma='SEG' and cod_funcao='RESTRICAO';

insert into PROFILE_RESTRICAO_SEG (NUM_SQNCIA_PRFRES,NUM_SQNCIA_FNCRES,COD_SISTMA,COD_PRFILE) values (1,1,'SEG','ADM');

insert into PROFILE_RESTRICAO_VALORES_SEG (NUM_SQNCIA_PRRESV,NUM_SQNCIA_PRFRES,NUM_SQNCIA_RESVLR) values (1,1,1);
insert into PROFILE_RESTRICAO_VALORES_SEG (NUM_SQNCIA_PRRESV,NUM_SQNCIA_PRFRES,NUM_SQNCIA_RESVLR) values (2,1,2);

COMMIT;
