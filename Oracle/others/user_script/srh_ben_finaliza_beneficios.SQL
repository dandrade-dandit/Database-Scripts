create or replace procedure srh_ben_finaliza_beneficios is
v_emp_data_admissao         date;
v_pvi_emp_numero_matricula  number(7);
v_pvi_sequencial            number(2);
v_idade                     number(10);
v_pvi_data_nascimento       date;
v_pvi_tpv_codigo            number(2);
v_emb_ben_sigla             char(3);

 v_email         varchar2(80);
 v_email_Origem  varchar2(80);
 v_Assunto       varchar2(80);
 V_mensagem      varchar2(2000);

 v_DATA_ADESAO      varchar2(10);
 v_DATA_EXCLUSAO    varchar2(10);
 v_NOME                         cadastros.EMP_NOME%type;
 v_EMP_ENDERECO_ELETRONICO_MAIL cadastros.EMP_ENDERECO_ELETRONICO_MAIL%type;

---Seleciona todos os empregados que possuem dependentes e que estao ativos---
cursor empregado_cur is
select emp_numero_matricula,emp_data_admissao, EMP_NOME, EMP_ENDERECO_ELETRONICO_MAIL
from cadastros
where emp_status in(0,1)and
      emp_numero_matricula in(select pvi_emp_numero_matricula
                              from pessoas_vinculadas)
and emp_numero_matricula = 661826
                              ;
-----------Seleciona os dependentes do empregados corrente-------------------
cursor dependente_cur is
select pvi_sequencial,
       pvi_data_nascimento,
       ((trunc(months_between(sysdate, pvi_data_nascimento)/12)) * 10000) + (to_number((trunc(mod(months_between(sysdate, pvi_data_nascimento),12)))) * 100) + to_number((to_char(round(mod(months_between(sysdate,pvi_data_nascimento),1) * (TO_NUMBER(TO_CHAR(last_day(sysdate),'DD')))))))
idade,
       pvi_tpv_codigo
from pessoas_vinculadas
where pvi_emp_numero_matricula = v_pvi_emp_numero_matricula and
      pvi_sequencial in
      (select distinct(pvb_pvi_sequencial)
       from pessoas_vinculadas_benef
       where pvb_pvi_emp_numero_matricula =
             v_pvi_emp_numero_matricula  and
             data_exclusao is null and
             pvb_pvi_sequencial in (select distinct(pvi_sequencial)
                                    from pessoas_vinculadas
                                    where pvi_tpv_codigo in (3,4,6,7,10,11,12,13) and
                                    pvi_emp_numero_matricula = v_pvi_emp_numero_matricula));
----------- Seleciona os beneficios do dependentes corrente -------------------
cursor beneficio_dep_cur is
 select ltrim(emb_ben_sigla)
 from pessoas_vinculadas_benef
 where pvb_pvi_emp_numero_matricula =
       v_pvi_emp_numero_matricula and
       pvb_pvi_sequencial =  v_pvi_sequencial and
       data_exclusao is null;


cursor beneficio_depENDENTES_cur is
 select PVI_NOME, PVI_DATA_NASCIMENTO, PVB.EMB_BEN_SIGLA, PVB_ADESAO, PVB.DATA_EXCLUSAO, emp.EMP_ENDERECO_ELETRONICO_MAIL
	FROM	PESSOAS_VINCULADAS_BENEF PVB
    ,		PESSOAS_VINCULADAS PVI
    ,   cadastros emp
	WHERE PVI.PVI_EMP_NUMERO_MATRICULA = emp.EMP_NUMERO_MATRICULA
        and   PVB.EMB_BEN_SIGLA = v_emb_ben_sigla
        AND   PVI.PVI_EMP_NUMERO_MATRICULA = PVB.PVB_PVI_EMP_NUMERO_MATRICULA
	AND   PVI.PVI_SEQUENCIAL = PVB.PVB_PVI_SEQUENCIAL
	AND   PVB.PVB_PVI_EMP_NUMERO_MATRICULA = v_pvi_emp_numero_matricula ;


-----------Inicio do tratamento de bloqueio---------------------------------
begin
open empregado_cur;
loop
exit when empregado_cur%notfound;
fetch empregado_cur into v_pvi_emp_numero_matricula, v_emp_data_admissao, v_NOME, v_EMP_ENDERECO_ELETRONICO_MAIL;
  open dependente_cur;
  loop
  exit when dependente_cur%notfound;
  fetch dependente_cur into v_pvi_sequencial,v_pvi_data_nascimento,v_idade,
                            v_pvi_tpv_codigo;
    open beneficio_dep_cur;
    loop
    exit when beneficio_dep_cur%notfound;
    fetch beneficio_dep_cur into v_emb_ben_sigla;
-----------Inicio do tratamento para beneficio médico-------------------
if v_emb_ben_sigla = 'MED' then
     ---Trata filho(a) nao tecnico universitario-----
     if v_idade >= 211129 and v_idade <= 241129  then
        if v_pvi_tpv_codigo in (3,6,10,11,12,13) then
           update pessoas_vinculadas_benef
           set data_exclusao = sysdate
           where pvb_pvi_emp_numero_matricula = v_pvi_emp_numero_matricula and
                 pvb_pvi_sequencial = v_pvi_sequencial and
                      emb_ben_sigla = v_emb_ben_sigla  and
                      data_exclusao is null;
        end if;
     end if;
     if v_idade >= 241129  then
        if v_pvi_tpv_codigo in (4,7) then
           update pessoas_vinculadas_benef
           set data_exclusao = sysdate
           where pvb_pvi_emp_numero_matricula = v_pvi_emp_numero_matricula and
                 pvb_pvi_sequencial = v_pvi_sequencial and
                      emb_ben_sigla = v_emb_ben_sigla  and
                      data_exclusao is null;
        end if;
      end if;
     ---Trata filho(a) tecnico universitario-----
	if  	(v_idade >= 211129 and v_idade < 241129)
		and (v_emp_data_admissao > to_date('30091999','ddmmyyyy'))
	then    if 	v_pvi_tpv_codigo in (4,7)
		then	update pessoas_vinculadas_benef
           		set data_exclusao = sysdate
           		where pvb_pvi_emp_numero_matricula = v_pvi_emp_numero_matricula and
                	pvb_pvi_sequencial = v_pvi_sequencial and
                      	emb_ben_sigla = v_emb_ben_sigla  and
                      	data_exclusao is null;
        	end if;
	elsif 	v_idade >= 211129 and v_idade < 241129
	then	if 	v_pvi_tpv_codigo in (4,7)
		then	--Verifica a existencia de declaracao universitaria-----
         		srh_ben_verifica_declaracao(v_pvi_emp_numero_matricula,
                        	      v_pvi_sequencial,
                              	v_emb_ben_sigla);
       		end if;
	end if;
  end if;
-----------fim do tratamento para beneficio médico-------------------
-----------Inicio do tratamento para beneficio Odontologico----------
if v_emb_ben_sigla = 'ODO' then
     ---Trata filho(a) nao tecnico universitario-----
     if v_idade >= 211129 and v_idade <= 241129  then
        if v_pvi_tpv_codigo = 3 then
           update pessoas_vinculadas_benef
           set data_exclusao = sysdate
           where pvb_pvi_emp_numero_matricula = v_pvi_emp_numero_matricula and
                 pvb_pvi_sequencial = v_pvi_sequencial and
                      emb_ben_sigla = v_emb_ben_sigla  and
                      data_exclusao is null;
        end if;
     end if;
     if v_idade >= 241129  then
        if v_pvi_tpv_codigo in (4,7) then
           update pessoas_vinculadas_benef
           set data_exclusao = sysdate
           where pvb_pvi_emp_numero_matricula = v_pvi_emp_numero_matricula and
                 pvb_pvi_sequencial = v_pvi_sequencial and
                      emb_ben_sigla = v_emb_ben_sigla  and
                      data_exclusao is null;
        end if;
     end if;
     ---Trata filho(a) tecnico universitario-----
     if v_idade >= 211129 and v_idade < 241129  then
        if v_pvi_tpv_codigo = 4 then
           --Verifica a existencia de declaracao universitaria-----
          srh_ben_verifica_declaracao(v_pvi_emp_numero_matricula,
                                      v_pvi_sequencial,
                                      v_emb_ben_sigla);
       end if;
    end if;
 end if;
-----------Fim do tratamento para beneficio Odontologico----------
-----------Inicio do tratamento para beneficio funeral----------
if v_emb_ben_sigla = 'FUN' then
 if v_idade >= 241129 and v_pvi_tpv_codigo in(3,4) then
     update pessoas_vinculadas_benef
     set data_exclusao = sysdate
     where pvb_pvi_emp_numero_matricula = v_pvi_emp_numero_matricula and
           pvb_pvi_sequencial = v_pvi_sequencial and
                emb_ben_sigla = v_emb_ben_sigla  and
                  data_exclusao is null;
 end if;
end if;
-----------Fim do tratamento para beneficio funeral----------
-----------Inicio do tratamento para beneficio Creche----------
if v_emb_ben_sigla = 'CRE' then
 if v_idade >=  61129 and v_pvi_tpv_codigo in(3,10,12) then
    update pessoas_vinculadas_benef
    set data_exclusao = sysdate
    where pvb_pvi_emp_numero_matricula = v_pvi_emp_numero_matricula and
                    pvb_pvi_sequencial = v_pvi_sequencial and
                         emb_ben_sigla = v_emb_ben_sigla  and
                         data_exclusao is null;
 end if;
 if v_idade >= 201129 and v_pvi_tpv_codigo in(11,13) then
    update pessoas_vinculadas_benef
    set data_exclusao = sysdate
    where pvb_pvi_emp_numero_matricula = v_pvi_emp_numero_matricula and
                    pvb_pvi_sequencial = v_pvi_sequencial and
                         emb_ben_sigla = v_emb_ben_sigla  and
                        data_exclusao is null;
  end if;
end if;
-----------Fim do tratamento para beneficio creche----------
end loop;
close beneficio_dep_cur;
end loop;
close dependente_cur;
end loop;
close empregado_cur;
commit;

-- Teste, avisar que a rotina foi executada
   v_email_Origem := 'beneficio_sede@infraero.gov.br';
   v_email   := 'francisco_ferreira@infraero.gov.br';
   v_Assunto := 'Comunicado de EXCLUSÃO DE BENEFICIO';

V_mensagem := 'Empresa Brasileira de Infra-Estrutura Aeroportuária - INFRAERO, informa:

Beneficio: '||v_emb_ben_sigla||'
Nome do Dependente: '||v_Nome||'
Data da Adesão: '||v_DATA_ADESAO||'
Data da Exclusão: '||v_DATA_EXCLUSAO||'

Coordenação de Benefícios

Email enviado pelo Sistema em '||to_char(sysdate,'dd/mm/yyyy hh24:mi:ss');

   envia_email ( v_email_Origem, v_email, v_Assunto, V_mensagem);
-- Teste, avisar que a rotina foi executada


end srh_ben_finaliza_beneficios;
