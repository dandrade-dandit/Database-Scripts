declare

v_telefone         VARCHAR2(12);
v_tot_funcao       number;
v_sigla_mat_funcao VARCHAR2(12);
v_uor_responsavel  VARCHAR2(12);
v_sigla_resp_uor   VARCHAR2(12);
v_matricula_resp   number;
v_cpf_responsavel  VARCHAR2(11);
v_status_func      char(1);
v_status_gerente   VARCHAR2(12) := 'FALSE';
v_desc_funcao      VARCHAR2(50);

cursor c1 is
SELECT  EMP_NUMERO_CPF                                                                             AS NUM_CPF
     ,  TO_DATE(TO_CHAR(EMP_DATA_NASCIMENTO, 'DD/MM/YYYY'), 'DD/MM/YYYY')                          AS DAT_NASCIMENTO
     ,  EMP_NU_CARTEIRA_IDENTIDADE                                                                 AS NUM_CARTEIRA_IDENTIDADE
     ,  EMP_SIGLA_ORGAO_EMITENTE_CI || '/' ||  EMP_UFE_SIGLA_CI                                    AS NOM_ORGAO_EXPEDICAO_CI
     ,  EMP_NOME                                                                                   AS NME_CADASTRO
     ,  EMP_ENDERECO_ELETRONICO_MAIL                                                               AS DSC_ENDERECO_ELETRONICO
     ,  EMP_DEP_CODIGO_LOTACAO 																																		 AS COD_DEP_LOTACAO
     ,  (SELECT DEP_SIGLA FROM DEPENDENCIAS WHERE DEP_CODIGO = EMP_DEP_CODIGO_LOTACAO)             AS SIG_DEP_LOTACAO
     ,  (SELECT DEP_NOME FROM DEPENDENCIAS WHERE DEP_CODIGO = EMP_DEP_CODIGO_LOTACAO)              AS NME_DEP_LOTACAO
     ,  EMP_DEP_CODIGO_FISICO 																																		 AS COD_DEP_FISICA
     ,  (SELECT DEP_SIGLA FROM DEPENDENCIAS WHERE DEP_CODIGO = EMP_DEP_CODIGO_FISICO)              AS SIG_DEP_FISICA
     ,  (SELECT DEP_NOME FROM DEPENDENCIAS WHERE DEP_CODIGO = EMP_DEP_CODIGO_FISICO)               AS NME_DEP_FISICA
     ,  EMP_UOR_CODIGO_LOTACAO																																		 AS COD_UOR_LOTACAO
     ,  (SELECT UOR_SIGLA FROM UNIDADES_ORGANIZACIONAIS WHERE UOR_CODIGO = EMP_UOR_CODIGO_LOTACAO) AS SIG_UOR_LOTACAO
     ,  (SELECT UOR_NOME FROM UNIDADES_ORGANIZACIONAIS WHERE UOR_CODIGO = EMP_UOR_CODIGO_LOTACAO)  AS NME_UOR_LOTACAO
     ,  EMP_UOR_CODIGO_FISICO																																		 AS COD_UOR_FISICA
     ,  (SELECT UOR_SIGLA FROM UNIDADES_ORGANIZACIONAIS WHERE UOR_CODIGO = EMP_UOR_CODIGO_FISICO)  AS SIG_UOR_FISICA
     ,  (SELECT UOR_NOME FROM UNIDADES_ORGANIZACIONAIS WHERE UOR_CODIGO = EMP_UOR_CODIGO_FISICO)   AS NME_UOR_FISICA
     ,  'xxxxxx'/*'209552' */                                                                      AS NUM_MAT_SUPERIOR_IMEDIATO      --ALTERAR (PEGA O CHEFE IMADIATO)
     ,  'xxxxxx'/*'21386463191'*/                                                                  AS NUM_CPF_SUPERIOR_IMEDIATO --ALTERAR (PEGA O CHEFE IMADIATO)
     ,  'xxxxxx'/*'A'*/                                                                            AS DSC_SITUACAO_FUNCIONAL    --ALTERAR (Por exemplo: A – ativo; I – Inativo; L – licença -> EMP_STATUS E OCORRENCIAS_EMPREGADOS)
     ,  'EMPREGADO'                                                                                AS TIP_USUARIO               --ALTERAR (TAMBÉM PARA ESTAGIARIO E TERCEIROS)
     ,  'xxxxx' /*'FALSE'  */                                                                      AS STA_GERENTE               --ALTERAR (COLOCAR TRUE SOMENTE PARA A FUNÇÃO DE GERENTE DA AREA)
     ,  EMP_NUMERO_MATRICULA                                                                       AS NUM_MATRICULA
     ,  TO_DATE(TO_CHAR(EMP_DATA_ADMISSAO, 'DD/MM/YYYY'), 'DD/MM/YYYY')                            AS DAT_ADMISSAO
     ,  'xxxxx' /*'COORDENADOR SEDE'*/                                                             AS NME_CARGO                 --ALTERAR (PEGAR DA TABELAS DE FUNÇÃO OU CARGO)
     ,  emp_qfu_fun_codigo                                                                         AS FUN_CODIGO
     ,  emp_qlp_car_codigo                                                                         AS CAR_CODIGO
     ,  emp_qlp_car_codigo_nivel                                                                   AS CAR_CODIGO_NIVEL
     ,  emp_qlp_car_occ_codigo                                                                     AS CAR_OCC_CODIGO

  FROM  CADASTROS
 WHERE  /*EMP_NUMERO_MATRICULA = 3807314
 AND */EMP_STATUS <> 2;

---------------------------------------------------------------------------------
procedure    GetCargoFunc (v_car_codigo        in number,
                           v_car_codigo_nivel  in number,
                           v_car_occ_codigo    in number,
                           v_nome_cargo        out varchar) as
begin

     select car_nome 
     into v_nome_cargo
     from cargos
      where car_codigo       = v_car_codigo
        and car_codigo_nivel = v_car_codigo_nivel
        and car_occ_codigo   = v_car_occ_codigo;
EXCEPTION
    WHEN NO_DATA_FOUND THEN
      v_nome_cargo := NULL;
    WHEN others  THEN
     v_nome_cargo := NULL; 
end;
---------------------------------------------------------------------------------

procedure     GetFuncaoFunc( v_matricula      in  NUMBER, 
                             v_fun_codigo     in  NUMBER,
                             v_desc_funcao    OUT VARCHAR,
                             v_status_gerente OUT VARCHAR) as
begin

BEGIN
SELECT FUN_NOME
INTO  v_desc_funcao
FROM CARGOS_CONFIANCA
WHERE fun_CODIGO = v_fun_codigo;
EXCEPTION
    WHEN NO_DATA_FOUND THEN
      v_desc_funcao := NULL;
      WHEN others THEN
     v_desc_funcao := NULL;   
end;

    if v_fun_codigo in (170,171,172,173,174,175,176,177,178,179,
    180,181,182,183,184,765,738,739,740,741,
    560,703,704,705,574,758,968,823,862,863,
    866,872,878,880,881,886,891,900,921,
    923,935,938,946,948,963,972,975) then
    
        v_status_gerente := 'TRUE';
    
    ELSE
        
        v_status_gerente := 'FALSE';
        
    end if;


end;
---------------------------------------------------------------------------------
procedure GetStatusFunc( v_matricula  in NUMBER,
                         v_emp_status out char
) as

v_lincenca number := 0;

begin

select count(*)
into v_lincenca
from ocorrencias_empregados
where 
oem_ofu_codigo IN (14,21, 22, 23, 24, 25, 30, 49, 60, 61, 75,243,224,225,226,227,228,229,230,231,232,284,285) /*LICENÇA*/
and oem_data_termino IS NULL
and oem_emp_numero_matricula = v_matricula ;

if v_lincenca > 0 then
  
    v_emp_status := 'L';

else

    v_emp_status := 'A';

end if;

end;

---------------------------------------------------------------------------------
procedure GetSuperiorImediatoComFuncao(
                              v_matricula in NUMBER,
                              v_uor_sigla in VARCHAR2,
                              v_emp_resp  out number,
                              v_cpf_resp  out number
                              ) as

v_uor_codigo varchar2(10);
v_status_cargo varchar2(10);

begin

  /*Recuperando o codigo da UOR*/
  BEGIN
  select uor_uor_codigo
  into v_uor_codigo
  from unidades_organizacionais
  where uor_sigla = v_uor_sigla
  and uor_data_extincao is null;
EXCEPTION
    WHEN NO_DATA_FOUND THEN
      v_uor_codigo := NULL;
    when others then
      v_uor_codigo := NULL;  
end;
  /*Recuperando o superior imediato*/
  begin
  select DISTINCT oem_emp_numero_matricula
  into  v_emp_resp
  from ocorrencias_empregados
  where  oem_data_termino IS NULL
    and oem_uor_codigo = v_uor_codigo
    AND OEM_FUN_CODIGO IN (
    ---------PRESIDENTE----------------
    689,
    ---------DIRETOR-------------------
    688,687,686,685,680,
    ---------SUPERINTENDENTE-----------
    761,762,763,764,590,591,592,593,594,
    595,596,597,598,599,607,822,754,756,
    868,869,870,871,918,945,949,970,971,
    ---------COORDENADOR---------------
    735,723,724,727,969,836,830,853,855,
    856,857,885,888,890,897,898,902,903,
    925,926,928,929,937,821,947,973,
    ---------GERENTE-------------------
    170,171,172,173,174,175,176,177,178,179,
    180,181,182,183,184,765,738,739,740,741,
    560,703,704,705,574,758,968,823,862,863,
    866,872,878,880,881,886,891,900,921,
    923,935,938,946,948,963,972,975);
    BEGIN
    select emp_numero_cpf
    into v_cpf_resp
    from cadastros
    where emp_numero_matricula = v_emp_resp;
    EXCEPTION
    WHEN NO_DATA_FOUND THEN
      v_cpf_resp := NULL;
    end;
exception
    WHEN NO_DATA_FOUND THEN
      v_emp_resp := NULL;
  when others then
    dbms_output.put_line('Foi encontrado mais de um responsavel para a matricula '||v_matricula);
      v_emp_resp := NULL;
end;
END;

---------------------------------------------------------------------------------
procedure GetSuperiorImediatoSemFuncao(
                              v_matricula in NUMBER,
                              v_uor_sigla in VARCHAR2,
                              v_emp_resp  out number,
                              v_cpf_resp  out number
                              ) as

v_uor_codigo varchar2(10);

begin

  /*Recuperando o codigo da UOR*/
  BEGIN
  select uor_codigo
  into v_uor_codigo
  from unidades_organizacionais
  where uor_sigla = v_uor_sigla
  and uor_data_extincao is null;
  EXCEPTION
    WHEN NO_DATA_FOUND THEN
      v_uor_codigo := NULL;
    when others then   
    v_uor_codigo := NULL;
  END;
  
  /*Recuperando o superior imediato*/
  begin
  select DISTINCT oem_emp_numero_matricula
  into  v_emp_resp
  from ocorrencias_empregados
  where  oem_data_termino IS NULL
    and oem_uor_codigo = v_uor_codigo
    AND OEM_FUN_CODIGO IN (
    ---------PRESIDENTE----------------
    689,
    ---------DIRETOR-------------------
    688,687,686,685,680,
    ---------SUPERINTENDENTE-----------
    761,762,763,764,590,591,592,593,594,
    595,596,597,598,599,607,822,754,756,
    868,869,870,871,918,945,949,970,971,
    ---------COORDENADOR---------------
    735,723,724,727,969,836,830,853,855,
    856,857,885,888,890,897,898,902,903,
    925,926,928,929,937,821,947,973,
    ---------GERENTE-------------------
    170,171,172,173,174,175,176,177,178,179,
    180,181,182,183,184,765,738,739,740,741,
    560,703,704,705,574,758,968,823,862,863,
    866,872,878,880,881,886,891,900,921,
    923,935,938,946,948,963,972,975);
    
    BEGIN
    select emp_numero_cpf
    into v_cpf_resp
    from cadastros
    where emp_numero_matricula = v_emp_resp;
    EXCEPTION
    WHEN NO_DATA_FOUND THEN
      v_cpf_resp := NULL;
    END;
      
  END;
exception
    WHEN NO_DATA_FOUND THEN
      v_emp_resp := NULL;
  when others then
    dbms_output.put_line('Foi encontrado mais de um responsavel para a matricula '||v_matricula);
    v_emp_resp := NULL;
end;
--END;

---------------------------------------------------------------------------------

begin

for x in c1 loop

  begin
    SELECT replace(replace(decode(a.telefone_direto,null, a.telefone_fax ,a.telefone_direto),' ',''),'-','') telefone
    into v_telefone
  FROM ifragenda.viw_catalogo a
  where num_matricula = x.NUM_MATRICULA;
  exception
    when others then
       v_telefone := null;
  end;

/*Verifica se o funcionario tem alguma função*/
  select count(*)
  into  v_tot_funcao
  from ocorrencias_empregados
  where  oem_data_termino IS NULL
    and oem_emp_numero_matricula = x.NUM_MATRICULA
    AND OEM_FUN_CODIGO IN (
    ---------PRESIDENTE----------------
    689,
    ---------DIRETOR-------------------
    688,687,686,685,680,
    ---------SUPERINTENDENTE-----------
    761,762,763,764,590,591,592,593,594,
    595,596,597,598,599,607,822,754,756,
    868,869,870,871,918,945,949,970,971,
    ---------COORDENADOR---------------
    735,723,724,727,969,836,830,853,855,
    856,857,885,888,890,897,898,902,903,
    925,926,928,929,937,821,947,973,
    ---------GERENTE-------------------
    170,171,172,173,174,175,176,177,178,179,
    180,181,182,183,184,765,738,739,740,741,
    560,703,704,705,574,758,968,823,862,863,
    866,872,878,880,881,886,891,900,921,
    923,935,938,946,948,963,972,975);

    if v_tot_funcao > 0 then
        
        GetSuperiorImediatoComFuncao(x.NUM_MATRICULA,X.sig_uor_fisica,v_matricula_resp,v_cpf_responsavel);

    else
    
        GetSuperiorImediatoSemFuncao(x.NUM_MATRICULA,X.sig_uor_fisica,v_matricula_resp,v_cpf_responsavel);

    end if;    

    GetStatusFunc( x.NUM_MATRICULA, v_status_func);

IF X.FUN_CODIGO IS NOT NULL THEN
    GetFuncaoFunc( x.NUM_MATRICULA, X.FUN_CODIGO,v_desc_funcao,v_status_gerente);
ELSE
    GetCargoFunc (X.CAR_CODIGO,
                  X.CAR_CODIGO_NIVEL,
                  X.CAR_OCC_CODIGO,
                  v_desc_funcao);

END IF;
   
 insert into ifrcorp.tab_interface_idm 
(NUM_CPF                       ,--VARCHAR2(11)          NOT NULL
DAT_NASCIMENTO                 ,--DATE                  NOT NULL
NUM_CARTEIRA_IDENTIDADE        ,--VARCHAR2(15)          NOT NULL
NOM_ORGAO_EXPEDICAO_CI         ,--VARCHAR2(20)          NOT NULL
NUM_TELEFONE                   ,--VARCHAR2(12)
NME_CADASTRO                   ,--VARCHAR2(80)          NOT NULL
DSC_ENDERECO_ELETRONICO        ,--VARCHAR2(60)
COD_DEP_LOTACAO                ,--NUMBER(4)
SIG_DEP_LOTACAO                ,--VARCHAR2(4)           NOT NULL
NME_DEP_LOTACAO                ,--VARCHAR2(50)          NOT NULL
COD_DEP_FISICA                 ,--NUMBER(4)
SIG_DEP_FISICA                 ,--VARCHAR2(10)          NOT NULL
NME_DEP_FISICA                 ,--VARCHAR2(50)          NOT NULL
COD_UOR_LOTACAO                ,--NUMBER(4)
SIG_UOR_LOTACAO                ,--VARCHAR2(10)          NOT NULL
NME_UOR_LOTACAO                ,--VARCHAR2(200)         NOT NULL
COD_UOR_FISICA                 ,--NUMBER(4)
SIG_UOR_FISICA                 ,--VARCHAR2(10)          NOT NULL
NME_UOR_FISICA                 ,--VARCHAR2(200)         NOT NULL
NUM_MAT_SUPERIOR_IMEDIATO      ,--NUMBER(7,0)           NOT NULL
NUM_CPF_SUPERIOR_IMEDIATO      ,--VARCHAR2(11)          NOT NULL
DSC_SITUACAO_FUNCIONAL         ,--VARCHAR2(20)          NOT NULL
TIP_USUARIO                    ,--VARCHAR2(15)          NOT NULL
STA_GERENTE                    ,--VARCHAR2(5)           NOT NULL
NUM_MATRICULA                  ,--NUMBER(7,0)           NOT NULL
DAT_ADMISSAO                   ,--DATE                  NOT NULL
NME_CARGO                      )--VARCHAR2(50)          NOT NULL
values
(
lpad(nvl(x.NUM_CPF            ,'0'),11,'0') ,--VARCHAR2(11)          NOT NULL
nvl(x.DAT_NASCIMENTO          ,SYSDATE)     ,--DATE                  NOT NULL
replace(replace(replace(replace(nvl(x.num_carteira_identidade,'???'),'.',''),'-',''),'/',''),' ',''),
nvl(x.NOM_ORGAO_EXPEDICAO_CI  ,'???')       ,--VARCHAR2(20)          NOT NULL
nvl(v_telefone                ,'???')       ,--VARCHAR2(12)
nvl(x.NME_CADASTRO            ,'???')       ,--VARCHAR2(80)          NOT NULL
nvl(x.DSC_ENDERECO_ELETRONICO ,'???')       ,--VARCHAR2(60)
nvl(x.COD_DEP_LOTACAO         ,0)           ,--VARCHAR2(4)           NOT NULL
nvl(x.SIG_DEP_LOTACAO         ,'???')       ,--VARCHAR2(4)           NOT NULL
nvl(x.NME_DEP_LOTACAO         ,'???')       ,--VARCHAR2(200)         NOT NULL
nvl(x.COD_DEP_FISICA          ,0)           ,--VARCHAR2(10)          NOT NULL
nvl(x.SIG_DEP_FISICA          ,'???')       ,--VARCHAR2(10)          NOT NULL
nvl(x.NME_DEP_FISICA          ,'???')       ,--VARCHAR2(200)         NOT NULL
nvl(x.COD_UOR_LOTACAO         ,0)           ,--VARCHAR2(10)          NOT NULL
nvl(x.SIG_UOR_LOTACAO         ,'???')       ,--VARCHAR2(10)          NOT NULL
nvl(x.NME_UOR_LOTACAO         ,'???')       ,--VARCHAR2(200)         NOT NULL
nvl(x.COD_UOR_FISICA          ,0)           ,--VARCHAR2(10)          NOT NULL
nvl(x.SIG_UOR_FISICA          ,'???')       ,--VARCHAR2(10)          NOT NULL
nvl(x.NME_UOR_FISICA          ,'???')       ,--VARCHAR2(200)         NOT NULL
lpad(nvl(v_matricula_resp     ,'0'),7,'0')  ,--NUMBER(7,0)           NOT NULL
lpad(nvl(v_cpf_responsavel    ,'0'),11,'0') ,--VARCHAR2(11)          NOT NULL
nvl(v_status_func             ,'???')       ,--VARCHAR2(20)          NOT NULL
nvl(x.TIP_USUARIO             ,'???')       ,--VARCHAR2(15)          NOT NULL
nvl(v_status_gerente          ,'???')       ,--VARCHAR2(5)           NOT NULL
lpad(nvl(x.NUM_MATRICULA      ,'0'),7,'0')  ,--NUMBER(7,0)           NOT NULL
nvl(x.DAT_ADMISSAO            ,SYSDATE)     ,--DATE                  NOT NULL
nvl(v_desc_funcao             ,'???')        --VARCHAR2(50)          NOT NULL
);

dbms_output.put_line('Responsavel pelo area é '||v_matricula_resp);

end loop;
end;

