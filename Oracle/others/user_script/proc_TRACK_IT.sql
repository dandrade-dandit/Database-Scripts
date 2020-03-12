create or replace PROCEDURE TRACKIT60.TRACK_IT IS
Begin
DECLARE
/* Funcionários Ativos que não existem no Sistema Track-It */

   CURSOR C1 IS
      select matr
           , substr(nome, 1, 30) nome
           , substr(cargo,1,30) cargo
           , email
           , cod_unid_org cod_uo
           , sg_unid_org sigla_uo
           , sg_dependencia sg_dept
           , matr matr2
      from Empregados_Track_It@prodsede
      where situacao = 1
      and cod_dependencia= 1  /*  Informar o código da  Regional  a ser atualizado o sistema Track-It */
       and matr not in(select userid from trackit60.tiuser);
   REG_C1 C1%ROWTYPE;

/* Funcionários Inativos (Licença/Férias) */

   CURSOR C2 IS
      select matr
           , substr(nome, 1, 30) nome
           , substr(cargo,1,30) cargo
           , email
           , cod_unid_org cod_uo
           , sg_unid_org sigla_uo
           , sg_dependencia sg_dept
           , matr matr2
      from Empregados_Track_It@prodsede
       where situacao in(0,2)
       and cod_dependencia= 1  /*  Informar o código da  Regional  a ser atualizado o sistema Track-It */
       and matr in(select userid from trackit60.tiuser);
   REG_C2 C2%ROWTYPE;

/* Funcionários que estão ativos no GestoRH e já possuem cadastro no Track-It */

   CURSOR C3 IS
      select matr
           , substr(nome, 1, 30) nome
           , substr(cargo,1,30) cargo
           , email email
           , cod_unid_org cod_uo
           , sg_unid_org sigla_uo
           , sg_dependencia sg_dept
           , matr matr2
       from Empregados_Track_It@prodsede
       where situacao=1
        and cod_dependencia= 1  /*  Informar o código da  Regional  a ser atualizado o sistema Track-It */
        and matr in(select userid
                    from trackit60.tiuser);
   REG_C3 C3%ROWTYPE;

BEGIN

/* Inclui os funcionários Ativos no GestoRH e inexistentes no Cadastro do Track-It */

   OPEN C1;
   FETCH C1 INTO REG_C1;
   WHILE C1%FOUND LOOP
       insert into trackit60.tiuser
        (userid, fullname, title, emailaddr
         ,dept_num, dept, location, employee_id)
       values(reg_c1.matr,reg_c1.nome,reg_c1.cargo,reg_c1.email
         ,reg_c1.cod_uo,reg_c1.sigla_uo,reg_c1.sg_dept,reg_c1.matr2);
        FETCH C1 INTO REG_C1;
   END LOOP;
   CLOSE C1;
   Commit;

/* Atualiza os Dados dos funcionários que entraram de Licença e existem no Track-It */

   OPEN C2;
   FETCH C2 INTO REG_C2;
   WHILE C2%FOUND LOOP
   update trackit60.tiuser
   set emailaddr ='USUARIO INATIVO'
   where userid = REG_C2.matr;
   END LOOP;
   CLOSE C2;
   Commit;

/* Atualiza os dados dos funcionários que já possuem cadastro no Track-It */

   OPEN C3;
   FETCH C3 INTO REG_C3;
   WHILE C3%FOUND LOOP
      update trackit60.tiuser
      set  fullname = REG_C3.nome
          ,title = REG_C3.cargo
          ,emailaddr = REG_C3.email
          ,dept_num = REG_C3.cod_uo
          ,dept=REG_C3.sigla_uo
          ,location = REG_C3.sg_dept
      where userid = REG_C3.matr;
   END LOOP;
   CLOSE C3;
   Commit;

/* Atualiza os chamados que estão abertos por funcionários que se tornaram  Inativos */

   update trackit60.tasks
   set lookup1='Férias/Afastamento'
   where completed is null
   and userid in(select employee_id
                 from trackit60.tiuser
                 where emailaddr = 'USUARIO INATIVO');

   commit;

END;
End;
/