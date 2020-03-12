CREATE OR REPLACE VIEW viw_catalogo_impresso (
   cod_dependencia,
   uor_nome,
   uor_nome_abreviado,
   uor_subordinacao,
   uor_sigla,
   uor_codigo,
   dsc_funcao_abreviada,
   dsc_funcao,
   emp_nome,
   emp_nome_guerra,
   emp_numero_matricula,
   num_telefone_direto,
   num_telefone_fax,
   ordem1,
   ordem2,
   ordem3,
   ordem4 )
AS
select cad.emp_dep_codigo_fisico cod_dependencia,
       fun_initcap_plus(uoi.uor_nome) uor_nome,
       fun_initcap_plus(uoi.uor_nome_abreviado) uor_nome_abreviado,
       uoi.subordinacao,
       uoi.uor_sigla uor_sigla,
       uoi.uor_codigo uor_codigo,
       fun_initcap_plus(rtrim( decode( substr(car.fun_nome, 1, decode( instr(car.fun_nome, ' '),0, 100,
       instr(car.fun_nome, ' ') ) ),'', '', 'COORD. ', 'COORDENADOR', 'ENC. ', 'ENCARREGADO', 'SUPERV. ', 'SUPERVISOR', 'SUPERINT. ', 'SUPERINTENDENTE', 'SECRET. ', 'SECRETÁRIO',
       decode(car.fun_nome,'PROCURADOR GERAL', 'PROCURADOR GERAL',substr(car.fun_nome, 1, decode(instr(car.fun_nome, ' '),
       0, 100, instr(car.fun_nome, ' ') ) ) ) ))) dsc_funcao_abreviada,
   	   car.fun_nome dsc_funcao,
       fun_initcap_plus(cad.emp_nome_abreviado) emp_nome,
       fun_initcap_plus(cad.emp_nome_guerra) emp_nome_guerra,
   	   cad.emp_numero_matricula emp_numero_matricula,
       decode( length(efc_dir.efc_uff_voip_ddd), 2, '(' || efc_dir.efc_uff_voip_ddd || ') ', '' ) || phone(efc_dir.efc_uff_numero) num_telefone_direto,
       decode( length(efc_fax.efc_uff_voip_ddd), 2, '(' || efc_fax.efc_uff_voip_ddd || ') ', '' ) || phone(efc_fax.efc_uff_numero) num_telefone_fax,
/*14*/ uoi.ordem1,
/*15*/ uoi.ordem2,
/*16*/ to_number(decode(hie.ordem, null, decode(uov.uor_virtual_codigo, null, 10, 12), hie.ordem)) ordem3,
       decode(rtrim( decode( substr(car.fun_nome, 1, decode( instr(car.fun_nome, ' '), 0, 100,
       instr(car.fun_nome, ' ') ) ),'', '', 'COORD. ', 'COORDENADOR', 'ENC. ', 'ENCARREGADO', 'SUPERV. ', 'SUPERVISOR', 'SUPERINT. ', 'SUPERINTENDENTE', 'SECRET. ', 'SECRETÁRIO',
       decode(car.fun_nome,'PROCURADOR GERAL', 'PROCURADOR GERAL',
       substr(car.fun_nome, 1, decode(instr(car.fun_nome, ' '),0, 100, instr(car.fun_nome, ' ') ) ) ) )),
    	'PRESIDENTE', 1,
    	'SUPERINTENDENTE', 2,
    	'DIRETOR', 3,
    	'PROCURADOR GERAL', 4,
    	'PROCURADOR', 5,
    	'SUBPROCURADOR', 6,
    	'ASSESSOR', 7,
    	'GERENTE', 8,
    	'COORDENADOR', 9,
    	'CHEFE', 10,
    	'ASSISTENTE', 11,
    	'ENCARREGADO', 12,
    	'SUPERVISOR', 13,
    	'MEMBRO', 14,
    	'SECRETARIO', 15,
    	'SECRETÁRIO', 16,
    	'', 17,
    	null, 17,
/*17*/'TERCEIROS', 18) ordem4 -- ordena por cargo os funcionários
--    	0 ordem4
from   cadastros                cad,
       cargos_confianca         car,
       hierarquia_agenda        hie,
       empregado_fone_comercial efc_dir,
       empregado_fone_comercial efc_fax,
       empregado_uorg_virtual   uov,
       (select uor1.subordinacao,
               uor1.uor_nome uor_nome,
               uor1.uor_sigla uor_sigla,
		           uor1.uor_codigo uor_codigo,
    		       uor1.uor_dep_codigo,
    		       uor1.uor_uor_codigo,
    		       level nivel,
    		       uor1.ordem ordem1,
    		       rownum ordem2,
    		       uor1.uor_nome_abreviado
    		from   (select uor.subordinacao, uor.ordem, uor.uor_codigo, uor.uor_sigla, uor.uor_nome, uor.uor_uor_codigo, uor.uor_nome_abreviado, uor.uor_tipo_unidad_org, uor.uor_dep_codigo
    		        from   ((select 'PR' subordinacao, 1 ordem, u.* from unidades_organizacionais u
where  u.uor_data_extincao is null and u.uor_dep_codigo = 1
start with u.uor_uor_codigo is null
connect by   prior u.uor_codigo = u.uor_uor_codigo
minus
(select 'PR', 1 ordem, u.* from unidades_organizacionais u
where  u.uor_data_extincao is null and u.uor_dep_codigo = 1
start with u.uor_codigo = 10200000
connect by   prior u.uor_codigo = u.uor_uor_codigo
union
select 'PR', 1 ordem, u.* from unidades_organizacionais u
where  u.uor_data_extincao is null and u.uor_dep_codigo = 1
start with u.uor_codigo = 10300000
connect by   prior u.uor_codigo = u.uor_uor_codigo
union
select 'PR', 1 ordem, u.* from unidades_organizacionais u
where  u.uor_data_extincao is null and u.uor_dep_codigo = 1
start with u.uor_codigo = 10401321
connect by   prior u.uor_codigo = u.uor_uor_codigo
union
select 'PR', 1 ordem, u.* from unidades_organizacionais u
where  u.uor_data_extincao is null and u.uor_dep_codigo = 1
start with u.uor_codigo = 10600000
connect by   prior u.uor_codigo = u.uor_uor_codigo
union
select 'PR', 1 ordem, u.* from unidades_organizacionais u
where  u.uor_data_extincao is null and u.uor_dep_codigo = 1
start with u.uor_codigo = 10500000
connect by   prior u.uor_codigo = u.uor_uor_codigo))
union
(select 'DA', 2 ordem, u.* from unidades_organizacionais u
where  u.uor_data_extincao is null and u.uor_dep_codigo = 1
start with u.uor_codigo = 10200000
connect by   prior u.uor_codigo = u.uor_uor_codigo
union
select 'DC', 3 ordem, u.* from unidades_organizacionais u
where  u.uor_data_extincao is null and u.uor_dep_codigo = 1
start with u.uor_codigo = 10300000
connect by   prior u.uor_codigo = u.uor_uor_codigo
union
select 'DE', 4 ordem, u.* from unidades_organizacionais u
where  u.uor_data_extincao is null and u.uor_dep_codigo = 1
start with u.uor_codigo = 10401321
connect by   prior u.uor_codigo = u.uor_uor_codigo
union
select 'DF', 5 ordem, u.* from unidades_organizacionais u
where  u.uor_data_extincao is null and u.uor_dep_codigo = 1
start with u.uor_codigo = 10600000
connect by   prior u.uor_codigo = u.uor_uor_codigo
union
select 'DO', 6 ordem, u.* from unidades_organizacionais u
where  u.uor_data_extincao is null and u.uor_dep_codigo = 1
start with u.uor_codigo = 10500000
connect by   prior u.uor_codigo = u.uor_uor_codigo
union
select /*+no_filtering */ d.dep_sigla, 7 ordem, u.* from unidades_organizacionais u, dependencias d
where  u.uor_data_extincao is null and u.uor_dep_codigo <> 1 and u.uor_dep_codigo = d.dep_codigo and d.dep_data_extincao is null
start with u.uor_uor_codigo is null
connect by   prior u.uor_codigo = u.uor_uor_codigo
)) uor
    		        where  uor.uor_data_extincao is null and uor.uor_codigo not in( 2027 ,2527,7560,10110002,7499)
    		        union
    		        select 'PR', 1 ordem, uov.uor_virtual_codigo uor_codigo, uov.uor_virtual_sigla uor_sigla, uov.uor_virtual_nome uor_nome,
          					   uov.uor_uor_virtual_codigo uor_uor_codigo, uov.uor_virtual_nome_abreviado uor_nome_abreviado,
          					   uov.uor_virtual_tipo_unidad_org uor_tipo_unidad_org, uov.uor_virtual_dep_codigo uor_dep_codigo
         				from   unidade_organizacional_virtual uov) uor1
       start with   uor1.uor_uor_codigo is null
       connect by   prior uor1.uor_codigo = uor1.uor_uor_codigo) uoi
where  (cad.emp_qfu_fun_codigo is null or  cad.emp_qfu_fun_codigo not in (690, 692)) -- Retira os membros do conselho fiscal e do conselho administrativo
and    uov.emp_numero_matricula (+) = cad.emp_numero_matricula
and    nvl(uov.uor_virtual_codigo, nvl(cad.emp_uor_codigo_fisico_agenda, cad.emp_uor_codigo_fisico)) = uoi.uor_codigo
and    cad.emp_numero_matricula = hie.emp_numero_matricula(+)
and    cad.emp_numero_matricula = efc_dir.efc_emp_numero_matricula(+)
and    cad.emp_numero_matricula = efc_fax.efc_emp_numero_matricula(+)
and    efc_dir.efc_uff_tipo (+) = 1
and    efc_fax.efc_uff_tipo (+) = 3
and    car.fun_codigo (+)= cad.emp_qfu_fun_codigo
and    cad.emp_status <> 2
union -- recupera terceirizados
select ter.ter_dep_codigo_fisico emp_dep_codigo_fisico,
       fun_initcap_plus(uoi.uor_nome) emp_uor_nome,
       fun_initcap_plus(uoi.uor_nome_abreviado) emp_uor_nome_abreviado,
       uoi.subordinacao,
       uoi.uor_sigla emp_uor_sigla,
       uoi.uor_codigo emp_uor_codigo_fisico_agenda,
       'Terceiros' emp_qfu_funcao,
       'Terceiros' emp_qfu_funcao_inteira,
       fun_initcap_plus(ter.ter_nome) emp_nome,
       fun_initcap_plus(ter.ter_nome_guerra) emp_nome_guerra,
       ter.ter_numero_matricula emp_numero_matricula,
       decode( length(ter.ter_ddd_ramal), 2, '(' || ter.ter_ddd_ramal || ') ', '' ) || phone(ter.ter_ramal) emp_efc_uff_numero,
       null emp_efc_uff_fax,
       uoi.ordem1,
       uoi.ordem2,
       to_number(decode(uov.uor_virtual_codigo, null, 11, 12)) ordem3,
       18 ordem4 -- colocar terceiros por ultimo
--       0 ordem4
from   terceiros              ter,
       empregado_uorg_virtual uov,
	  (select  uor1.subordinacao,
             uor1.uor_nome uor_nome,
               uor1.uor_sigla uor_sigla,
		       uor1.uor_codigo uor_codigo,
		       uor1.uor_dep_codigo,
		       uor1.uor_uor_codigo,
		       level nivel,
 		       uor1.ordem ordem1,
 		       rownum ordem2,
		       uor1.uor_nome_abreviado
		from   (select  uor.subordinacao, uor.ordem, uor.uor_codigo, uor.uor_sigla, uor.uor_nome, uor.uor_uor_codigo, uor.uor_nome_abreviado, uor.uor_tipo_unidad_org, uor.uor_dep_codigo
		        from    ((select 'PR' subordinacao, 1 ordem, u.* from unidades_organizacionais u
where  u.uor_data_extincao is null and u.uor_dep_codigo = 1
start with u.uor_uor_codigo is null
connect by   prior u.uor_codigo = u.uor_uor_codigo
minus
(select 'PR', 1 ordem, u.* from unidades_organizacionais u
where  u.uor_data_extincao is null and u.uor_dep_codigo = 1
start with u.uor_codigo = 10200000
connect by   prior u.uor_codigo = u.uor_uor_codigo
union
select 'PR', 1 ordem, u.* from unidades_organizacionais u
where  u.uor_data_extincao is null and u.uor_dep_codigo = 1
start with u.uor_codigo = 10300000
connect by   prior u.uor_codigo = u.uor_uor_codigo
union
select 'PR', 1 ordem, u.* from unidades_organizacionais u
where  u.uor_data_extincao is null and u.uor_dep_codigo = 1
start with u.uor_codigo = 10401321
connect by   prior u.uor_codigo = u.uor_uor_codigo
union
select 'PR', 1 ordem, u.* from unidades_organizacionais u
where  u.uor_data_extincao is null and u.uor_dep_codigo = 1
start with u.uor_codigo = 10600000
connect by   prior u.uor_codigo = u.uor_uor_codigo
union
select 'PR', 1 ordem, u.* from unidades_organizacionais u
where  u.uor_data_extincao is null and u.uor_dep_codigo = 1
start with u.uor_codigo = 10500000
connect by   prior u.uor_codigo = u.uor_uor_codigo))
union
(select 'DA', 2 ordem, u.* from unidades_organizacionais u
where  u.uor_data_extincao is null and u.uor_dep_codigo = 1
start with u.uor_codigo = 10200000
connect by   prior u.uor_codigo = u.uor_uor_codigo
union
select 'DC', 3 ordem, u.* from unidades_organizacionais u
where  u.uor_data_extincao is null and u.uor_dep_codigo = 1
start with u.uor_codigo = 10300000
connect by   prior u.uor_codigo = u.uor_uor_codigo
union
select 'DE', 4 ordem, u.* from unidades_organizacionais u
where  u.uor_data_extincao is null and u.uor_dep_codigo = 1
start with u.uor_codigo = 10401321
connect by   prior u.uor_codigo = u.uor_uor_codigo
union
select 'DF', 5 ordem, u.* from unidades_organizacionais u
where  u.uor_data_extincao is null and u.uor_dep_codigo = 1
start with u.uor_codigo = 10600000
connect by   prior u.uor_codigo = u.uor_uor_codigo
union
select 'DO', 6 ordem, u.* from unidades_organizacionais u
where  u.uor_data_extincao is null and u.uor_dep_codigo = 1
start with u.uor_codigo = 10500000
connect by   prior u.uor_codigo = u.uor_uor_codigo
union
select /*+no_filtering */ d.dep_sigla, 7 ordem, u.* from unidades_organizacionais u, dependencias d
where  u.uor_data_extincao is null and u.uor_dep_codigo <> 1 and u.uor_dep_codigo = d.dep_codigo and d.dep_data_extincao is null
start with u.uor_uor_codigo is null
connect by   prior u.uor_codigo = u.uor_uor_codigo
)) uor
		        where   uor.uor_data_extincao is null and uor.uor_codigo not in( 2027 ,2527,7560,10110002,7499)
		        union
		        select  'PR', 1 ordem, uov.uor_virtual_codigo uor_codigo, uov.uor_virtual_sigla uor_sigla, uov.uor_virtual_nome uor_nome,
					    uov.uor_uor_virtual_codigo uor_uor_codigo, uov.uor_virtual_nome_abreviado uor_nome_abreviado,
					    uov.uor_virtual_tipo_unidad_org uor_tipo_unidad_org, uov.uor_virtual_dep_codigo uor_dep_codigo
				  from  unidade_organizacional_virtual uov) uor1
   start with uor1.uor_uor_codigo is null
   connect by prior uor1.uor_codigo = uor1.uor_uor_codigo) uoi
where  uov.emp_numero_matricula (+) = ter.ter_numero_matricula
and    nvl(uov.uor_virtual_codigo, ter.ter_uor_codigo_fisico_agenda) = uoi.uor_codigo
and    ter.ter_status <> 2
order by 1, 14, 15, 16, 17, 7, 9
/

GRANT SELECT ON viw_catalogo_impresso TO agenda_usu
/
