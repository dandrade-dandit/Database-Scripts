Set ServerOutPut ON

DECLARE
OptValue1 number ;
OptValue2 varchar2(200) ;
BEGIN
OptValue1 := 0 ;
OptValue2 := 'não executou!';
ifrcorp.sp_idm_ativa_inativa_usuario(px_result_cod => OptValue1, px_result_des => OptValue2, px_login => 'I1190738', px_flag => 0); 
DBMS_OUTPUT.PUT_LINE('Value Returned Is : '||OptValue1) ;
DBMS_OUTPUT.PUT_LINE('Value Returned Is : '||OptValue2) ;
END ;
/


DECLARE
OptValue1 number ;
OptValue2 varchar2(200) ;
BEGIN
OptValue1 := 0 ;
OptValue2 := 'não executou!';
ifrcorp.sp_idm_ativa_inativa_usuario(px_result_cod => OptValue1, px_result_des => OptValue2, px_login => 'I1190738', px_flag => 1); 
DBMS_OUTPUT.PUT_LINE('Value Returned Is : '||OptValue1) ;
DBMS_OUTPUT.PUT_LINE('Value Returned Is : '||OptValue2) ;
END ;
/


DECLARE
OptValue1 number ;
OptValue2 varchar2(200) ;
BEGIN
OptValue1 := 0 ;
OptValue2 := 'não executou!';
ifrcorp.sp_idm_alt_perfil(px_result_cod => OptValue1, px_result_des => OptValue2, px_login => 'I1190738', px_perfil => 'SRH_CAD_01', px_flag => 0); 
DBMS_OUTPUT.PUT_LINE('Value Returned Is : '||OptValue1) ;
DBMS_OUTPUT.PUT_LINE('Value Returned Is : '||OptValue2) ;
END ;
/

DECLARE
OptValue1 number ;
OptValue2 varchar2(200) ;
BEGIN
OptValue1 := 0 ;
OptValue2 := 'não executou!';
ifrcorp.sp_idm_alt_perfil(px_result_cod => OptValue1, px_result_des => OptValue2, px_login => 'I1190738', px_perfil => 'SICAE_DARH', px_flag => 1); 
DBMS_OUTPUT.PUT_LINE('Value Returned Is : '||OptValue1) ;
DBMS_OUTPUT.PUT_LINE('Value Returned Is : '||OptValue2) ;
END ;
/


DECLARE
OptValue1 number ;
OptValue2 varchar2(200) ;
BEGIN
OptValue1 := 0 ;
OptValue2 := 'não executou!';
ifrcorp.sp_idm_alt_senha(px_result_cod => OptValue1, px_result_des => OptValue2, px_login => 'I1190738', px_password => 'SWDE12345&%$!KS415'); 
DBMS_OUTPUT.PUT_LINE('Value Returned Is : '||OptValue1) ;
DBMS_OUTPUT.PUT_LINE('Value Returned Is : '||OptValue2) ;
END ;
/


DECLARE
OptValue1 number ;
OptValue2 varchar2(200) ;
BEGIN
OptValue1 := 0 ;
OptValue2 := 'não executou!';
ifrcorp.sp_idm_ins_usuario(px_result_cod => OptValue1, px_result_des => OptValue2, px_login => 'I1644819', px_password => 'idm', px_nome => 'WISLANIA', px_sobrenome  => 'PEREIRA DOS SANTOS', px_perfil     => 'SRH_WEB', px_depFisica  => 'TISI-1', px_matricula  => '1644819', px_email => 'wislania@infraero.gov.br' ); 
DBMS_OUTPUT.PUT_LINE('Value Returned Is : '||OptValue1) ;
DBMS_OUTPUT.PUT_LINE('Value Returned Is : '||OptValue2) ;
END ;
/

DECLARE
OptValue1 number ;
OptValue2 varchar2(200) ;
BEGIN
OptValue1 := 0 ;
OptValue2 := 'não executou!';
ifrcorp.sp_idm_del_usuario(px_result_cod => OptValue1, px_result_des => OptValue2, px_login => 'I1644819'); 
DBMS_OUTPUT.PUT_LINE('Value Returned Is : '||OptValue1) ;
DBMS_OUTPUT.PUT_LINE('Value Returned Is : '||OptValue2) ;
END ;
/
    
    
--1
SELECT * 
--DELETE
FROM CONTROLE_USUARIO_DEPENDENCIA 
WHERE SGU_ID_USUARIO = 'I1644819';

--2
SELECT * 
--DELETE
FROM SEG_USUARIO_CENTRO_CUSTO 
WHERE SU_ID_USUARIO = 'I1644819';

--3
SELECT * 
--DELETE
FROM SEG_USUARIO_SISTEMA 
WHERE SU_ID_USUARIO = 'I1644819';

--4
SELECT * 
--DELETE
FROM SEG_USUARIO 
WHERE ID_USUARIO = 'I1644819';