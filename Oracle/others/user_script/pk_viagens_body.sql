CREATE OR REPLACE 
PACKAGE BODY pk_viagens  IS
 function aprovador( p_dep_codigo number,
                     p_uor_codigo number := 0,
                     p_emp_qfu_fun_codigo number := 0,
                     p_avi_ofu_codigo number,
                     p_via_data_inicio date := trunc(sysdate),
                     p_via_data_termino date := trunc(sysdate)) return number is
  v_aprovador cadastros.emp_numero_matricula%type := 0;
  v_uor_codigo unidades_organizacionais.uor_codigo%type := p_uor_codigo;
 begin
 	if p_dep_codigo = 1 then -- sede
 	 if nvl(p_emp_qfu_fun_codigo, 0) = 918 then -- superintendente sede
 	 	v_uor_codigo := superior_uor(v_uor_codigo);
 	 end if;
 	 if v_uor_codigo != 0 then
 	 	v_aprovador := aprovador_delegado(v_uor_codigo, p_avi_ofu_codigo, p_via_data_inicio, p_via_data_termino);
 	 	if v_aprovador = 0 then
		  declare
		   cursor c1 is
		    select a.emp_numero_matricula
		     from cadastros a
		     where a.EMP_QFU_FUN_CODIGO in(685,680,688,686,687,689,918)
		      and a.EMP_STATUS = 1
		      and a.emp_dep_codigo_lotacao = p_dep_codigo
		      and a.emp_uor_codigo_lotacao = v_uor_codigo;
		   r1 c1%rowtype;
		  begin
		   open c1;
		   fetch c1 into r1;
		   if c1%found then
		   	/*
        v_aprovador := substituicao(r1.emp_numero_matricula, p_via_data_inicio, p_via_data_termino);
        if v_aprovador = 0 then
	 					v_aprovador := r1.emp_numero_matricula;
        end if;
        */
				v_aprovador := r1.emp_numero_matricula;
		    close c1;
		   else
		    v_aprovador := aprovador(p_dep_codigo,
		                             superior_uor(v_uor_codigo),
		                             0,
		                             p_avi_ofu_codigo,
		                             p_via_data_inicio,
                                 p_via_data_termino);
		    close c1;
		   end if;
		  end;
		end if;
 	 end if;
 	else -- demais dependencias  sem ser a sede
 	 while v_uor_codigo != 0 loop
 	 	v_aprovador := aprovador_delegado(v_uor_codigo, p_avi_ofu_codigo, p_via_data_inicio, p_via_data_termino);
	 	if v_aprovador = 0 then
	 		v_uor_codigo := superior_uor(v_uor_codigo);
	 	else
	 		v_uor_codigo := 0;
	 	end if;
 	 end loop;
 	 if v_aprovador = 0 then
	   declare
	    cursor c0 is
	     select a.uor_dep_codigo, a.uor_codigo
	      from unidades_organizacionais a, dependencias b
	      where a.uor_dep_codigo = b.dep_dep_codigo
	        and a.uor_uor_codigo is null
	        and a.uor_data_extincao is null
	        and b.dep_grupos_dependencias = 18
	        and b.dep_data_extincao is null
	        and b.dep_codigo = p_dep_codigo;
	    r0 c0%rowtype;
	    cursor c1 is
	     select a.emp_numero_matricula
	      from cadastros a
	      where a.EMP_QFU_FUN_CODIGO in(877,883,884,889,945)
	       and a.EMP_STATUS = 1
	       and a.emp_dep_codigo_lotacao = p_dep_codigo;
	    r1 c1%rowtype;
	   begin
	   	open c0;
	   	fetch c0 into r0;
	   	if c0%found then
	   		close c0;
		    v_aprovador := aprovador(r0.uor_dep_codigo,
		                             r0.uor_codigo,
		                             0,
		                             p_avi_ofu_codigo,
		                             p_via_data_inicio,
                                 p_via_data_termino);
	   	else
	   		close c0;
		   	open c1;
		   	fetch c1 into r1;
		   	if c1%found then
/*
	        v_aprovador := substituicao(r1.emp_numero_matricula, p_via_data_inicio, p_via_data_termino);
	        if v_aprovador = 0 then
	 					v_aprovador := r1.emp_numero_matricula;
	        end if;
*/
	 				v_aprovador := r1.emp_numero_matricula;
	      else
	       v_aprovador := nomeacao_aeroporto(p_dep_codigo, p_via_data_inicio, p_via_data_termino);
		   	end if;
		   	close c1;
		  end if;
	   end;
	 end if;
 	end if;
 	return v_aprovador;
 end;

 function superior_uor(p_uor_codigo number) return number is
   cursor c1 is
    select a.uor_uor_codigo, a.uor_dep_codigo
     FROM unidades_organizacionais a
     where a.uor_codigo = p_uor_codigo;
   r1 c1%rowtype;
   v_superior_uor r1.uor_uor_codigo%type := 0;
   cursor c2 is
   	 select a.uor_codigo
	     from unidades_organizacionais a, dependencias b
	     where a.uor_dep_codigo = b.dep_dep_codigo
	       and a.uor_uor_codigo is null
	       and a.uor_data_extincao is null
	       and b.dep_grupos_dependencias = 18
	       and b.dep_data_extincao is null
	       and b.dep_codigo = r1.uor_dep_codigo;
   r2 c2%rowtype;
 begin
 	open c1;
 	fetch c1 into r1;
 	if c1%found then
 	 v_superior_uor := r1.uor_uor_codigo;
 	end if;
 	close c1;
 	if nvl(v_superior_uor,0)= 0 then
 		open c2;
 		fetch c2 into r2;
 		if c2%found then
 	 		v_superior_uor := r2.uor_codigo;
 		end if;
 		close c2;
 	end if;
 	return v_superior_uor;
 end;

 function aprovador_delegado(p_uor_codigo number,
                             p_avi_ofu_codigo number,
                             p_via_data_inicio date := trunc(sysdate),
                             p_via_data_termino date := trunc(sysdate)) return number is
  cursor c1 is
   select a.avi_emp_numero_matricula
    from aprovador_viagem a, aprovador_viagem_tipo b
    where a.avi_data_confirmacao is not null
      and a.avi_uor_codigo = b.avi_uor_codigo
      and a.avi_data_inicio = b.avi_data_inicio
      and a.avi_uor_codigo = p_uor_codigo
      and a.avi_principal = 'S'
      and trunc(sysdate) between a.avi_data_inicio and nvl(a.avi_data_termino, to_date('31129999','ddmmyyyy'))
      and b.avi_ofu_codigo = p_avi_ofu_codigo;
   r1 c1%rowtype;
  v_aprovador cadastros.emp_numero_matricula%type := 0;
  begin
		open c1;
		fetch c1 into r1;
		if c1%found then
			close c1;
/*      v_aprovador := substituicao(r1.avi_emp_numero_matricula, p_via_data_inicio, p_via_data_termino);
      if v_aprovador = 0 then
	  		return(r1.avi_emp_numero_matricula);
      end if;
     	return(v_aprovador);
*/
	 		return(r1.avi_emp_numero_matricula);
		end if;
		close c1;
	  return 0;
  end;

 function diaria_padrao(p_emp_nsa_codigo_nivel number,
                        p_emp_nsa_codigo_padrao varchar2,
                        p_cfu_vld_codigo number,
                        p_emp_qfu_fun_codigo number,
                        p_acompanhante number := 0) return number is
  cursor c1 is
   select a.vld_diaria
    from valores_diaria a, niveis_salariais b
    where a.vld_codigo = b.nsa_vld_codigo
      and b.nsa_codigo_nivel = p_emp_nsa_codigo_nivel
      and b.nsa_codigo_padrao = p_emp_nsa_codigo_padrao
    order by a.vld_data_vigencia desc;
  cursor c2 is
   select a.vld_diaria
    from valores_diaria a
    where a.vld_codigo = p_cfu_vld_codigo
    order by a.vld_data_vigencia desc;
  cursor c3 is
   select a.vld_diaria
    from valores_diaria a
    where a.vld_codigo = 5
    order by a.vld_data_vigencia desc;
  r1 c1%rowtype;
  r2 c2%rowtype;
  r3 c3%rowtype;
 begin
 	if p_acompanhante = 1 or p_emp_qfu_fun_codigo in (680, 685, 686, 687, 688, 689) then
 	 open c3;
 	 fetch c3 into r3;
 	 if c3%notfound then
 	 	r3.vld_diaria := 0;
 	 end if;
 	 close c3;
 	 return(r3.vld_diaria);
 	else
 	 open c1;
 	 fetch c1 into r1;
 	 if c1%notfound then
 	 	r1.vld_diaria := 0;
 	 end if;
 	 close c1;
 	 open c2;
 	 fetch c2 into r2;
 	 if c2%notfound then
 	 	r2.vld_diaria := 0;
 	 end if;
 	 close c2;
 	 return greatest(r1.vld_diaria, r2.vld_diaria);
 	end if;
 end;

 function diaria_substituicao(p_emp_numero_matricula number,
                              p_via_data_inicio date,
                              p_via_data_termino date) return number is
  cursor c1 is
   select d.vld_diaria
    from ocorrencias_empregados a, cargos_confianca b, categorias_funcoes c, valores_diaria d
    where a.oem_ofu_codigo in(85, 89, 217, 220)
      and a.oem_emp_numero_matricula = p_emp_numero_matricula
      and p_via_data_inicio between a.oem_data_inicio and nvl(a.oem_data_termino, to_date('31129999', 'ddmmyyyy'))
      and p_via_data_termino between a.oem_data_inicio and nvl(a.oem_data_termino, to_date('31129999', 'ddmmyyyy'))
      and a.oem_fun_codigo = b.fun_codigo
      and b.fun_cfu_codigo = c.cfu_codigo
      and c.cfu_vld_codigo = d.vld_codigo
    order by  d.vld_data_vigencia desc;
  r1 c1%rowtype;
 begin
 	 open c1;
 	 fetch c1 into r1;
 	 if c1%notfound then
 	 	r1.vld_diaria := 0;
 	 end if;
 	 close c1;
 	 return(r1.vld_diaria);
 end;

 function chefe_imediato(p_emp_uor_codigo_lotacao number,
                         p_emp_numero_matricula number,
                         p_via_data_inicio date := trunc(sysdate),
                         p_via_data_termino date  := trunc(sysdate)) return number is
 begin
 	 return chefe_imediato_subst(p_emp_uor_codigo_lotacao,
                               p_emp_numero_matricula,
                               p_via_data_inicio,
                               p_via_data_termino,
                               1);
 end;

 function chefe_imediato_subst(p_emp_uor_codigo_lotacao number,
                               p_emp_numero_matricula number,
                               p_via_data_inicio date := trunc(sysdate),
                               p_via_data_termino date := trunc(sysdate),
                               p_subst number := 1) return number is
	cursor c1 is
   select a.oem_emp_numero_matricula -- substituicao
    from ocorrencias_empregados a
    where a.oem_ofu_codigo in(89, 220, 221, 222)
      and a.oem_uor_codigo = p_emp_uor_codigo_lotacao
      and p_via_data_inicio between a.oem_data_inicio and nvl(a.oem_data_termino, to_date('31129999', 'ddmmyyyy'))
      and p_via_data_termino between a.oem_data_inicio and nvl(a.oem_data_termino, to_date('31129999', 'ddmmyyyy'))
      and a.oem_emp_numero_matricula_subst is not null
      and p_subst = 1
      and exists(select 'x'
                  from cadastros b, cargos_confianca c
									where b.emp_status = 1
	  							and b.emp_numero_matricula = a.oem_emp_numero_matricula_subst
	  							and b.emp_qfu_fun_codigo  = c.fun_codigo
	 							 	and c.fun_posicao_trabalho = 0);

	cursor c2 is
   select a.oem_emp_numero_matricula -- diretores
    from ocorrencias_empregados a
    where a.oem_ofu_codigo in(125, 238, 240)
      and a.oem_uor_codigo = p_emp_uor_codigo_lotacao
      and p_via_data_inicio between a.oem_data_inicio and nvl(a.oem_data_termino, to_date('31129999', 'ddmmyyyy'))
      and p_via_data_termino between a.oem_data_inicio and nvl(a.oem_data_termino, to_date('31129999', 'ddmmyyyy'));
	cursor c3 is
   select a.oem_emp_numero_matricula  -- nomeação tem que ter posição de trabalho = 0
    from ocorrencias_empregados a
    where a.oem_ofu_codigo in(85, 86, 88, 93, 217, 256) -- designacao
      and a.oem_uor_codigo = p_emp_uor_codigo_lotacao
      and p_via_data_inicio between a.oem_data_inicio and nvl(a.oem_data_termino, to_date('31129999', 'ddmmyyyy'))
      and p_via_data_termino between a.oem_data_inicio and nvl(a.oem_data_termino, to_date('31129999', 'ddmmyyyy'))
      and exists(select 'x'
                  from cadastros b, cargos_confianca c
									where b.emp_status = 1
	  							and b.emp_numero_matricula = a.oem_emp_numero_matricula
	  							and b.emp_qfu_fun_codigo  = c.fun_codigo
	 							 	and c.fun_posicao_trabalho = 0);
	r1 c1%rowtype;
	v_c1_found boolean;
 begin
 	if p_emp_uor_codigo_lotacao != 0 then
	 open c1;
	 fetch c1 into r1;
	 if c1%notfound then
    close c1;
	  open c2;
	  fetch c2 into r1;
	  if c2%notfound then
     close c2;
	   open c3;
	   fetch c3 into r1;
	   if c3%notfound then
	    close c3;
   		return(chefe_imediato_subst(superior_uor(p_emp_uor_codigo_lotacao),
                            p_emp_numero_matricula,
                            p_via_data_inicio,
                            p_via_data_termino,
                            p_subst));
     end if;
     close c3;
	  else
	   close c2;
	  end if;
	 else
    close c1;
	 end if;
   if r1.oem_emp_numero_matricula = p_emp_numero_matricula then
     r1.oem_emp_numero_matricula :=chefe_imediato_subst(superior_uor(p_emp_uor_codigo_lotacao),
                           p_emp_numero_matricula,
                           p_via_data_inicio,
                           p_via_data_termino,
                           p_subst);
     if nvl(r1.oem_emp_numero_matricula, 0) = 0 then
     	return p_emp_numero_matricula;
     else
     	return r1.oem_emp_numero_matricula;
     end if;
	 end if;
	 return (r1.oem_emp_numero_matricula);
	end if;
	return 0;
 end;


 function substituicao(p_emp_numero_matricula number,
                       p_via_data_inicio date := trunc(sysdate),
                       p_via_data_termino date := trunc(sysdate)) return number is
	cursor c1 is
   select a.oem_emp_numero_matricula -- substituicao
    from ocorrencias_empregados a
    where a.oem_ofu_codigo in(89, 220, 221, 222)
      and a.oem_emp_numero_matricula_subst = p_emp_numero_matricula
      and a.oem_emp_numero_matricula_subst is not null
      and p_via_data_inicio between a.oem_data_inicio and nvl(a.oem_data_termino, to_date('31129999', 'ddmmyyyy'))
      and p_via_data_termino between a.oem_data_inicio and nvl(a.oem_data_termino, to_date('31129999', 'ddmmyyyy'));
   r1 c1%rowtype;
  begin
		open c1;
		fetch c1 into r1;
		if c1%found then
			close c1;
			return(r1.oem_emp_numero_matricula);
		end if;
		close c1;
	  return 0;
  end;

 function nomeacao_aeroporto(p_dep_codigo number,
                             p_via_data_inicio date  := trunc(sysdate),
                             p_via_data_termino date := trunc(sysdate)) return number is
	cursor c1 is
   select a.oem_emp_numero_matricula  -- nomeação busca por funcao
    from ocorrencias_empregados a
    where a.oem_ofu_codigo in(85, 93, 217) -- designacao
      and a.oem_dep_codigo = p_dep_codigo
      and a.oem_fun_codigo in(877,883,884,889,945) -- superintendentes
      and p_via_data_inicio between a.oem_data_inicio and nvl(a.oem_data_termino, to_date('31129999', 'ddmmyyyy'))
      and p_via_data_termino between a.oem_data_inicio and nvl(a.oem_data_termino, to_date('31129999', 'ddmmyyyy'));
   r1 c1%rowtype;
  begin
		open c1;
		fetch c1 into r1;
		if c1%found then
			close c1;
			return(r1.oem_emp_numero_matricula);
		end if;
		close c1;
	  return 0;
  end;

END;
/