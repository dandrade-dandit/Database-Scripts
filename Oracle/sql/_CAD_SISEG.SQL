DECLARE
      V_SISTEMA       NUMBER(3)    := 13; -- INFRANET
      V_GRUPO         VARCHAR2(20) := 'SRH_WEB';
      V_COD_GRUPO     NUMBER(3)    := NULL;
      --
      CURSOR EMP IS
          select substr(emp_nome_abreviado,1,30) emp_nome,
                   emp_dep_codigo_lotacao emp_dep,
                   substr(emp_ati_ct_custos,1,5) ct_custos,
                   'I'||lpad(emp_numero_matricula,7,'0') usuario
            from   cadastros
            where  not exists (select 'S'
                                from seg_usuario
                                where id_usuario like 'I%'
                                  and id_usuario = 'I'||lpad(emp_numero_matricula,7,'0')
                              )
              and emp_status != 2;
      --
    BEGIN
      -- verificar se o empregado existe na SEG_USUARIO
      --
      BEGIN
        SELECT CD_GRUPO
        INTO   V_COD_GRUPO
        FROM   SEG_GRUPO_USUARIO
        WHERE  SS_CD_SISTEMA = V_SISTEMA
        AND    ROLE          = V_GRUPO;
      EXCEPTION
        WHEN NO_DATA_FOUND THEN
          dbms_output.put_line('Grupo não cadastrado');
      END;
      --
      FOR C1 IN EMP LOOP
        INSERT INTO SEG_USUARIO (ID_USUARIO,
                                 NO_USUARIO,
                                 DEP_CD_DEPENDENCIA,
                                 CC2_CD_CENTRO_CUSTO,
                                 DS_USUARIO)
             VALUES (C1.usuario,
                     C1.emp_nome,
                     C1.emp_dep,
                     C1.ct_custos,
                     'USUARIO GESTORH');
      IF SUBSTR(C1.usuario,1,1) <> 'I' THEN
         dbms_output.put_line('Usuário inválido: '||C1.usuario);
      END IF;
      BEGIN
        INSERT INTO SEG_USUARIO_SISTEMA (SU_ID_USUARIO,
                                         SS_CD_SISTEMA,
                                         SGU_CD_GRUPO,
                                         DS_USUARIO,
                                         ID_GERENTE_SISTEMA)
        VALUES (C1.usuario,
                V_SISTEMA,
                V_COD_GRUPO,
                'USUÁRIO GESTORH: CONSULTA GERAL',
                'N');
      EXCEPTION
        WHEN OTHERS THEN
          dbms_output.put_line('Erro ao inserir usuario/sistema: '||C1.usuario||to_char(sqlcode)||' - '||sqlerrm);
      END;
      BEGIN
        INSERT INTO SEG_USUARIO_CENTRO_CUSTO (SU_ID_USUARIO,
                                              SS_CD_SISTEMA,
                                              CC2_CD_CENTRO_CUSTO,
                                              IN_CC2_PRINCIPAL)
        VALUES (C1.usuario,
                V_SISTEMA,
                C1.CT_CUSTOS,
                'S');
      EXCEPTION
        WHEN OTHERS THEN
          dbms_output.put_line('Erro ao inserir usuario/centro de custo: '||C1.usuario||to_char(sqlcode)||' - '||sqlerrm);
      END;
      BEGIN
        INSERT INTO CONTROLE_USUARIO_DEPENDENCIA (SGU_ID_USUARIO,
                                                  DEP_CD_DEPENDENCIA,
                                                  FLAG_IND_DEP_FREQUENCIA,
                                                  SSI_CD_SISTEMA,
                                                  IN_DEP_PRINCIPAL)
        VALUES (C1.usuario,
                C1.EMP_DEP,
                'N',
                V_SISTEMA,
                'S');
      EXCEPTION
        WHEN OTHERS THEN
          dbms_output.put_line('Erro ao inserir usuario/dependencia: '||C1.usuario||to_char(sqlcode)||' - '||sqlerrm);
      END;
      END LOOP;
   END INSERE_USUARIOS_SISEG;
/