-- Procedure SRH_CAD_PROCEDIMENTOS_DIARIOS

CREATE OR REPLACE
PROCEDURE srh_cad_procedimentos_diarios( p_emp_numero_matricula NUMBER DEFAULT NULL,
                                         p_data_base            DATE   DEFAULT SYSDATE,
                                         p_insere_anuenio       NUMBER DEFAULT NULL) IS
   --
   ------------------------------------------------------------------------------------
   --                           SRH_CAD_PROCEDIMENTOS_DIARIOS                        --
   --                           --- --- ------------- -------                        --
   --                                                                                --
   --     Procedure que rodará todos os dias mantendo a tabela de cadastros sincro-  --
   -- nizada com as ocorrências atuais do empregado. Todo 1º dia do mês, esta mesma  --
   -- rotina verificará a necessidade de inclusão ou alteração das ocorrências 216 e --
   -- 73 (relativas aos anuênios dos empregados), e se necessário as realizará.      --
   --                                                                                --
   -- Criada por: Edmundo Júnior                                                     --
   --             Luiz Fernando Bastos Coura                                         --
   --             Selson Coatio                                                      --
   -- Data da Criação: 13/06/2001                                                    --
   --                                                                                --
   -- Alterada por: Luiz Fernando Bastos Coura                                       --
   -- Data da última alteração: 05/04/2004                                           --
   --                                                                                --
   -- Obs.: Em 11/07/2001 a procedure foi alterada para começar a gravar definitiva- --
   -- mente os dados de anuênio e hst_dependencia_empregado.                         --
   -- Em 13/12/2001 esta versão foi alterada para não utilizar dados da tabela de    --
   -- averbação conforme definição da Quedima já que os dados desta tabela estão     --
   -- inconsistentes. Caso for necessário de se retornar ao antigo modo de tratamento--
   -- de anuênio utilizando as averbações, existe uma versão já pronta no diretório  --
   -- c\junior\job\job_anuenio.sql da máquina do Junior                              --
   --                                                                                --
   ------------------------------------------------------------------------------------
   --
   -- Declaração das variáveis globais
   anos_tempo_servico       NUMBER      := 0;
   dias_tempo_servico       NUMBER      := 0;
   dias_afastamento         NUMBER(4)   := 0;
   v_ct                     NUMBER(4)   := 0;
   v_percentual             NUMBER(4,2) := 0;
   v_data_ultimo_anuenio    DATE;
   v_folha                  DATE;
   --  Variaveis para controle de rodada do JOB
   v_nome_processo          VARCHAR2(60) := 'SRH_CAD_PROCEDIMENTOS_DIARIOS';
   v_data_inicio            DATE := sysdate;
   --
   --
   -- Declaração das procedures internas ao programa
   PROCEDURE BUSCA_TEMPO_SERVICO_ANUENIO ( p_emp_numero_matricula      NUMBER,
                                           p_emp_data_admissao         DATE,
                                           p_data_ultimo_anuenio    IN OUT DATE,
                                           p_tempo_servico_anos     IN OUT NUMBER,
                                           p_tempo_servico_dias     IN OUT NUMBER,
                                           p_total_dias_afastamento IN OUT NUMBER);
   --
   PROCEDURE ATUALIZA_PERCENTUAIS_ANUENIOS( p_emp_numero_matricula    NUMBER,
                                            p_emp_data_admissao       DATE,
                                            p_total_dias_afastamento  number,
                                            p_anos_tempo_servico      number,
                                            p_dias_tempo_servico      number,
                                            p_percentual              IN OUT NUMBER,
                                            p_data_ultimo_anuenio     date);
   --
   FUNCTION  BUSCA_PERCENTUAL_ANUENIO ( p_emp_data_admissao  DATE,
                                        p_anos_tempo_servico NUMBER ) return NUMBER;
   --
   PROCEDURE INSERE_ANUENIO ( p_emp_numero_matricula NUMBER,
                              p_emp_data_admissao    DATE,
                              p_dias_afastamento     number,
                              p_tempo_servico        number,
                              p_percentual           number,
                              p_data_ultimo_anuenio  date,
                              p_anos_tempo_servico   number);
   --
   PROCEDURE INSERE_DEPENDENCIA_EMPREGADO(p_emp_numero_matricula   number,
                                          p_emp_dep_codigo_lotacao number);
   --

   Procedure atualiza_status_empregado;
   --
   PROCEDURE ATUALIZA_DEPENDENTES;
   PROCEDURE ATUALIZA_FUNCAO;
   PROCEDURE RETORNO_TRANSF_PROVISORIA;
   --
   -- Para manter a tabela de Atividades_empregados
   PROCEDURE APAGA_ATIV_EMP_ALTERADAS;
   PROCEDURE INS_ATIV_EMP_PRI_SUB;
   PROCEDURE INS_ATIV_EMP_ACUM;
   --
   --
   --
   /*
   Procedure atualiza_final_funcao;
   Procedure atualiza_inicio_funcao;
   Procedure atualiza_final_cumulativa;
   Procedure atualiza_inicio_cumulativa;
   Procedure atualiza_final_transferencia;
   Procedure atualiza_inicio_transferencia;
   Procedure atualiza_final_cessao;
   Procedure atualiza_inicio_cessao;
   */
-- Procedure atualiza_final_func_conf;
-- Procedure atualiza_inicio_func_conf;
   --
   ------------------------------------------------------------------------------------
   -- cursor principal do JOB
   -- seleciona todos empregados que estão ativos
   ------------------------------------------------------------------------------------
   CURSOR c_emp IS
      SELECT emp_numero_matricula,
             emp_data_admissao,
             emp_dep_codigo_lotacao,
             emp_sfu_codigo
      FROM   cadastros
      WHERE  emp_status != 2
      and   (   (p_emp_numero_matricula is null)
             or (emp_numero_matricula = p_emp_numero_matricula));
   --
   ------------------------------------------------------------------------------------
   -- Rotina que apura o tempo de serviço do empregado
   --
   ------------------------------------------------------------------------------------


   PROCEDURE BUSCA_TEMPO_SERVICO_ANUENIO ( p_emp_numero_matricula   IN     NUMBER,
                                           p_emp_data_admissao      IN     DATE,
                                           p_data_ultimo_anuenio    IN OUT DATE,
                                           p_tempo_servico_anos     IN OUT NUMBER,
                                           p_tempo_servico_dias     IN OUT NUMBER,
                                           p_total_dias_afastamento IN OUT NUMBER) IS
      --
      v_tempo_servico             NUMBER;
      v_tempo_servico_corrido     NUMBER;
      v_tempo_servico_averbacao   NUMBER;
      v_tempo_servico_abatimento  NUMBER;
      v_data_anuenio              DATE;
      v_data_ini_ultimo_anuenio   DATE;
      v_total_anuenio             NUMBER := 0;
      --
   BEGIN
      --
      -- busca a data início da última ocorrência 73 do empregado
      begin
         select oem.oem_data_inicio,
                nvl(oem.oem_valor,0)
         into v_data_ini_ultimo_anuenio,
              v_total_anuenio
         from ocorrencias_empregados oem
         where oem.oem_emp_numero_matricula = p_emp_numero_matricula and
               oem.oem_ofu_codigo = 73 and
               oem.oem_data_inicio in(select max(oco.oem_data_inicio)
                                  from ocorrencias_empregados oco
                                  where oco.oem_emp_numero_matricula = oem.oem_emp_numero_matricula and
                                        oco.oem_ofu_codigo = 73);

         exception
         when no_data_found then
         begin
            select oem.oem_data_inicio,
                   nvl(oem.oem_valor,0)
            into v_data_ini_ultimo_anuenio,
                 v_total_anuenio
            from ocorrencias_empregados oem,
                 tipos_ocorrencias
            where oem.oem_emp_numero_matricula = p_emp_numero_matricula and
                  oem.oem_ofu_codigo = ofu_codigo and
                  ofu_indicador_tipo = 1 and
                  ofu_codigo not in(142,201) and
                  oem.oem_data_inicio in(select max(oco.oem_data_inicio)
                                         from ocorrencias_empregados oco
                                         where oco.oem_emp_numero_matricula = oem.oem_emp_numero_matricula and
                                               oco.oem_ofu_codigo = oem.oem_ofu_codigo);

            exception
            when no_data_found then
              --
              begin
                select oem.oem_data_inicio,
                       nvl(oem.oem_valor,0)
                 into v_data_ini_ultimo_anuenio,
                      v_total_anuenio
                 from ocorrencias_empregados oem,
                      tipos_ocorrencias
                where oem.oem_emp_numero_matricula = p_emp_numero_matricula and
                      oem.oem_ofu_codigo = ofu_codigo and
                      ofu_indicador_tipo = 1 and
                      ofu_codigo in(142,201) and
                      oem.oem_data_inicio in(select max(oco.oem_data_inicio)
                                              from ocorrencias_empregados oco
                                             where oco.oem_emp_numero_matricula = oem.oem_emp_numero_matricula and
                                                   oco.oem_ofu_codigo = oem.oem_ofu_codigo);

                exception
                  when no_data_found then
                    dbms_output.put_line('Não existe ocorrência de ingresso para a matricula = '||to_char(p_emp_numero_matricula));
               end;
              --
            --dbms_output.put_line('Não existe ocorrência de ingresso para a matricula = '||to_char(p_emp_numero_matricula));
         end;
      end;
      --
      -- Alimenta a variável com a data do próximo anuênio do empregado
      v_data_anuenio := TO_DATE( TO_CHAR(v_data_ini_ultimo_anuenio,'DD/MM')|| '/' ||
                                 TO_CHAR(p_data_base,'YYYY'),'DD/MM/YYYY');
--      dbms_output.put_line('v_data_ini_ultimo_anuenio:'||to_char(v_data_ini_ultimo_anuenio,'dd/mm/yyyy'));
--      dbms_output.put_line('v_data_anuenio:'||to_char(v_data_anuenio,'dd/mm/yyyy'));
      --
      -- Busca o total de dias de afastamento do empregado
      begin
         SELECT -- SUM( (NVL(oem_data_termino, v_data_anuenio) + 1) - oem_data_inicio)
                -- Se oem_data_termino is null, quer dizer que o empregado ainda está
                -- afastado então considero sysdate mais 1 mes para que não faça o calculo
                -- de anuenio
                SUM(NVL(oem_data_termino,trunc(add_months(sysdate,1)) + 1) - oem_data_inicio + 1)
           into p_total_dias_afastamento
         FROM   ocorrencias_empregados
         WHERE oem_emp_numero_matricula = p_emp_numero_matricula
         and
               oem_data_inicio >= v_data_ini_ultimo_anuenio      and
               oem_ofu_codigo in
               (SELECT ofu_codigo
                FROM   tipos_ocorrencias             ----------------------------------
                WHERE  --ofu_indicador_tipo IN (2, 13) -->  2 - Afastamento Temporário --
                -- AND                                 --> 13 - Absenteísmo            --
                ofu_indicador_anuenio = 'S'
                );
         --                                             ----------------------------------

         if p_total_dias_afastamento is null then
            p_total_dias_afastamento := 0;
         end if;
      end;
      --
--      dbms_output.put_line('p_total_dias_afastamento:'||
--                           to_char(p_total_dias_afastamento));
      -- Realiza os calculos e alimenta as variáveis que serão retornadas com valor
      v_tempo_servico_corrido := (v_data_anuenio - v_data_ini_ultimo_anuenio);
      p_tempo_servico_dias    := v_tempo_servico_corrido - NVL( p_total_dias_afastamento,  0 );
--      p_tempo_servico_anos    := TO_CHAR( TRUNC( ((v_total_anuenio * 365) + (v_tempo_servico_corrido)) /365 ) );
      p_tempo_servico_anos    := TO_CHAR( TRUNC( ((v_total_anuenio * 365) + (v_tempo_servico_corrido) - NVL( p_total_dias_afastamento,  0 )) /365 ));
      p_data_ultimo_anuenio   := v_data_ini_ultimo_anuenio;
      --
   END BUSCA_TEMPO_SERVICO_ANUENIO;
   --
   ---------------------------------------------------------------------------------
   -- Rotina que atualiza os percentuais de anuênios
   -- ------ --- -------- -- ----------- -- --------
   -- Primeiro calcula-se o tempo de serviço em anos para a partir daí conseguir se
   -- pegar o percentual de anuênio contido na tabela "Anuenios" e atualizar esse
   -- percentual na tabela de "Ocorrencias_Empregados" (Atualiza a ocorrência "216 -
   -- Quantidade de Anuênios" com o campo oem_mov_parametro = "percentual calculado").
   ------------------------------------------------------------------------------------
   PROCEDURE ATUALIZA_PERCENTUAIS_ANUENIOS( p_emp_numero_matricula    NUMBER,
                                            p_emp_data_admissao       DATE,
                                            p_total_dias_afastamento  NUMBER,
                                            p_anos_tempo_servico      NUMBER,
                                            p_dias_tempo_servico      NUMBER,
                                            p_percentual              in out number,
                                            p_data_ultimo_anuenio     date) IS
      --
      v_percentual         NUMBER;
      --
   BEGIN
      --
      v_percentual := BUSCA_PERCENTUAL_ANUENIO( p_emp_data_admissao,
                                                p_anos_tempo_servico);
      --
      p_percentual := v_percentual;
      --
      UPDATE ocorrencias_empregados
      SET    oem_mov_parametro         = v_percentual
            ,oem_valor                 = p_anos_tempo_servico -- Quantidade de anuênios
--            ,oem_data_termino          = (p_data_ultimo_anuenio + p_dias_tempo_servico + (p_total_dias_afastamento * 2))
            ,oem_data_termino          = (add_months(p_data_ultimo_anuenio,12) + NVL(p_total_dias_afastamento,0 ))
            ,oem_diploma_legal_termino = 'OCORRÊNCIA GERADA AUTOMATICAMENTE (ROTINA DIÁRIA).'
      WHERE  oem_emp_numero_matricula  = p_emp_numero_matricula
      AND    oem_ofu_codigo            = 216;
      --
      IF SQL%NOTFOUND THEN
         INSERT INTO ocorrencias_empregados
                ( oem_emp_numero_matricula,
                  oem_ofu_codigo,
                  oem_data_inclusao,
                  oem_data_inicio,
                  oem_data_termino,
                  oem_valor,
                  oem_mov_parametro,
                  oem_diploma_legal,
                  oem_diploma_legal_termino )
         VALUES ( p_emp_numero_matricula,
                  216, -- Quantidade de anuênios
                  p_data_base,
                  p_data_ultimo_anuenio,
--                 (p_data_ultimo_anuenio + p_dias_tempo_servico + (p_total_dias_afastamento * 2)),
                  (add_months(p_data_ultimo_anuenio,12) + NVL(p_total_dias_afastamento,0 )),
                  p_anos_tempo_servico,
                  v_percentual,
                  'OCORRÊNCIA GERADA AUTOMATICAMENTE (ROTINA DIÁRIA).',
                  'OCORRÊNCIA GERADA AUTOMATICAMENTE (ROTINA DIÁRIA).' );
      END IF;
      --
      EXCEPTION
      when dup_val_on_index then
      begin
         update ocorrencias_empregados
         set -- oem_data_termino  = (p_data_ultimo_anuenio + p_dias_tempo_servico + (p_total_dias_afastamento * 2)),
             oem_data_termino  = (add_months(p_data_ultimo_anuenio,12) + NVL(p_total_dias_afastamento,0 )),
             oem_valor         = p_anos_tempo_servico,
             oem_mov_parametro = v_percentual
         where oem_emp_numero_matricula = p_emp_numero_matricula and
               oem_data_inicio          = p_emp_data_admissao    and
               oem_ofu_codigo           = 216;
      end;
      WHEN OTHERS THEN
         DBMS_OUTPUT.PUT_LINE( SUBSTR( SQLERRM, 1, 200) || ' - Mat: ' || TO_CHAR(p_emp_numero_matricula) || '.');
         --
   END ATUALIZA_PERCENTUAIS_ANUENIOS;
   --
   ------------------------------------------------------------------------------------
   -- Rotina que busca o percentual do anuênio do empregado
   -- ------ --- ----- - ---------- -- ------- -- ---------
   --
   ------------------------------------------------------------------------------------
   FUNCTION BUSCA_PERCENTUAL_ANUENIO( p_emp_data_admissao  DATE,
                                      p_anos_tempo_servico NUMBER) RETURN NUMBER IS
      --
      v_percentual NUMBER;
      --
      CURSOR c_per_1 (p_anos_tempo_servico NUMBER) IS
         SELECT anu_percentual_1
         FROM   anuenios
         WHERE  anu_quantidade_ano = p_anos_tempo_servico;
      --
      CURSOR c_per_2 (p_anos_tempo_servico NUMBER) IS
         SELECT anu_percentual_2
         FROM   anuenios
         WHERE  anu_quantidade_ano = p_anos_tempo_servico;
      --
      CURSOR c_per_max IS
         SELECT NVL( MAX( anu_percentual_1 ), 0)
         FROM   anuenios;
      --
   BEGIN
      --
      IF p_anos_tempo_servico >= 23 THEN -- Se o empregado tiver mais de 23 anos de serviço
         --
         -- Seleciona o maior percentual encontrado na tabela de "anuenios"
         OPEN  c_per_max;
         FETCH c_per_max INTO v_percentual;
         --
         CLOSE c_per_max;
         --
         IF v_percentual = 0 THEN
            DBMS_OUTPUT.PUT_LINE( 'Não existe nenhum percentual 2 de anuênio cadastrado !' );
         END IF;
         --
      ELSE -- Se o empregado tiver menos do que 23 anos de serviço
         --
         IF p_emp_data_admissao <= TO_DATE('30041995','DDMMYYYY') THEN -- Se o empregado foi
            --                                                  admitido antes de 30/04/1995
            -- Seleciona o percentual_1 relacionado ao tempo de serviço passado como parâmetro
            OPEN c_per_1( p_anos_tempo_servico );
            FETCH c_per_1 INTO v_percentual;
            --
            IF c_per_1%NOTFOUND THEN
               v_percentual := 0;
               DBMS_OUTPUT.PUT_LINE( 'Não existe percentual 1 de anuênio para tempo de ' ||
                                     'serviço igual a : ' || to_char(p_anos_tempo_servico) || ' ano(s) !');
            END IF;
            --
            CLOSE c_per_1;
            --
         ELSE -- Se o empregado foi admitido depois de 30/04/1995
            --
            -- Seleciona o percentual_2 relacionado ao tempo de serviço passado como parâmetro
            OPEN  c_per_2( p_anos_tempo_servico );
            FETCH c_per_2 INTO v_percentual;
            --
            IF c_per_2%NOTFOUND THEN
               v_percentual := 0;
               DBMS_OUTPUT.PUT_LINE( 'Não existe percentual 2 de anuênio para tempo de ' ||
                                     'serviço igual a : ' || to_char(p_anos_tempo_servico) || ' ano(s) !');
            END IF;
            --
            CLOSE c_per_2;
            --
         END IF;
         --
      END IF;
      --
      RETURN( v_percentual );
      --
   END BUSCA_PERCENTUAL_ANUENIO;
   --
   ------------------------------------------------------------------------------------
   -- Rotina que insere o anuênio
   ------------------------------------------------------------------------------------
   PROCEDURE INSERE_ANUENIO ( p_emp_numero_matricula NUMBER,
                              p_emp_data_admissao    DATE,
                              p_dias_afastamento     NUMBER,
                              p_tempo_servico        NUMBER,
                              p_percentual           number,
                              p_data_ultimo_anuenio  date,
                              p_anos_tempo_servico   number) IS
      --
   BEGIN
      --
      INSERT INTO ocorrencias_empregados
                   ( oem_emp_numero_matricula,
                     oem_ofu_codigo,
                     oem_data_inclusao,
                     oem_data_inicio,
                     oem_data_termino,
                     oem_diploma_legal,
                     oem_diploma_legal_termino,
                     oem_mov_parametro,
                     oem_valor)
      VALUES       ( p_emp_numero_matricula,
                     73, -- Adicional por tempo de serviço
                     p_data_base,
                     --(p_data_ultimo_anuenio + p_tempo_servico + (p_dias_afastamento * 2)),
                     --(p_data_ultimo_anuenio + p_tempo_servico + (p_dias_afastamento * 2)),
                     add_months(p_data_ultimo_anuenio,12) + nvl(p_dias_afastamento,0),
                     add_months(p_data_ultimo_anuenio,12) + nvl(p_dias_afastamento,0),
                     'OCORRÊNCIA GERADA AUTOMATICAMENTE (ROTINA DIÁRIA).',
                     'OCORRÊNCIA GERADA AUTOMATICAMENTE (ROTINA DIÁRIA).' ,
                     p_percentual,
                     p_anos_tempo_servico);

      exception
      when dup_val_on_index then
      begin
         update ocorrencias_empregados
         set -- oem_data_termino = (p_data_ultimo_anuenio + p_tempo_servico + (p_dias_afastamento * 2))
             oem_data_termino = (p_data_ultimo_anuenio + NVL(p_dias_afastamento,0) )
         where oem_emp_numero_matricula = p_emp_numero_matricula and
               oem_data_inicio          = (p_emp_data_admissao + p_tempo_servico + (p_dias_afastamento * 2)) and
               oem_ofu_codigo           = 73;
      end;
      --
   END INSERE_ANUENIO;
   --
   ------------------------------------------------------------------------------------
   -- Rotina que atualiza a tabela hst_dependencia_empregado
   -- Que é utilizada no cálculo da Freqüência por afastamento de Absenteismo
   ------------------------------------------------------------------------------------
   PROCEDURE INSERE_DEPENDENCIA_EMPREGADO (p_emp_numero_matricula   number,
                                           p_emp_dep_codigo_lotacao number) IS
      --
      v_dep NUMBER(4);
      --
      v_ano NUMBER(4) := to_number(to_char(p_data_base,'yyyy'));
      --
      v_mes number(2) := to_number(to_char(p_data_base,'mm'));
      --
   BEGIN
      --
      v_dep := NVL(BUSCA_DEPENDENCIA( p_emp_numero_matricula,
                                      LAST_DAY( TO_DATE( LPAD(TO_CHAR(v_mes),2,'0') || TO_CHAR(v_ano), 'MMYYYY') ) )
                                     , p_emp_dep_codigo_lotacao );
      --
      BEGIN
         --
         UPDATE hst_dependencia_empregado
         SET    hde_dep_codigo = v_dep
         WHERE  hde_emp_numero_matricula = p_emp_numero_matricula
         AND    hde_mes_referencia       = v_mes
         AND    hde_ano_referencia       = v_ano;
         --
         IF SQL%NOTFOUND THEN
            INSERT INTO HST_DEPENDENCIA_EMPREGADO
                   ( hde_emp_numero_matricula,
                     hde_mes_referencia,
                     hde_ano_referencia,
                     hde_dep_codigo )
            VALUES ( p_emp_numero_matricula,
                     v_mes,
                     v_ano,
                     v_dep );
         END IF;
         --
      END;
   END INSERE_DEPENDENCIA_EMPREGADO;
   --
   PROCEDURE ATUALIZA_DEPENDENTES IS
   BEGIN
     --
     BEGIN
       -- UPDATE PARA 21 ANOS
       UPDATE PESSOAS_VINCULADAS
          -- 252 MESES DA 21 ANOS
          SET pvi_data_baixa_ir = DECODE(SIGN((ADD_MONTHS(pvi_data_nascimento,252)) -
                                                          pvi_data_adesao_ir),
                                              -1, pvi_data_adesao_ir,
                                               ADD_MONTHS(pvi_data_nascimento,252)
                                        )
           WHERE EXISTS (SELECT 'S'
                           FROM CADASTROS
                          WHERE emp_numero_matricula  = pvi_emp_numero_matricula
                            AND emp_status != 2
                         )
           -- PARA 21 ANOS
           AND pvi_tpv_codigo in(3,6,14,17,20,10,12)
           AND pvi_data_nascimento <
                       TO_DATE(TO_CHAR(SYSDATE,'dd/mm')||'/'||
                               TO_CHAR(TO_NUMBER(TO_CHAR(SYSDATE,'yyyy'))-21),'dd/mm/yyyy')
           AND pvi_indicador_imposto_de_renda = 'S'
           AND pvi_data_baixa_ir IS NULL
           AND pvi_emp_numero_matricula > 0
           AND pvi_sequencial > 0;
       --
       IF SQL%NOTFOUND THEN
         NULL;
       END IF;
     --
     EXCEPTION
       WHEN OTHERS THEN
         NULL;
     END;
     --
     --
     BEGIN
       -- UPDATE PARA 24 ANOS
       UPDATE PESSOAS_VINCULADAS
          SET pvi_data_baixa_ir = DECODE(SIGN((ADD_MONTHS(pvi_data_nascimento,288)) -
                                                          pvi_data_adesao_ir),
                                             -1, pvi_data_adesao_ir,
                                             ADD_MONTHS(pvi_data_nascimento,288)
                                        )
       WHERE EXISTS (SELECT 'S'
                       FROM CADASTROS
                      WHERE emp_numero_matricula  = pvi_emp_numero_matricula
                        AND emp_status != 2
                     )
         --     PARA 24 ANOS
         AND pvi_tpv_codigo IN (4,7,15,18,21)
         AND pvi_data_nascimento <
                 TO_DATE(TO_CHAR(SYSDATE,'dd/mm')||'/'||
                         TO_CHAR(TO_NUMBER(TO_CHAR(SYSDATE,'yyyy'))-24),'dd/mm/yyyy')
         AND pvi_indicador_imposto_de_renda = 'S'
         AND pvi_data_baixa_ir IS NULL
         AND pvi_emp_numero_matricula > 0
         AND pvi_sequencial > 0;
       --
       IF SQL%NOTFOUND THEN
         NULL;
       END IF;
     --
     EXCEPTION
       WHEN OTHERS THEN
         NULL;
     END;
     --
   END ATUALIZA_DEPENDENTES;
   --
   ------------------------------------------------------------------------------------
   -- Rotina para atualizar o status do empregado para:
   -- ativo     - quando possuir data término do dia anterior ao do sistema,
   -- afastado  - quando possuir data início igual à data do sistema
   -- desligado - quando possuir ocorrência do grupo 10 - Desligamento com data de início igual a
   --             maior data de início de ocorrências do empregado
   -- para as seguintes ocorrencias:
  -- Cod     Descrição                                             Grupo
  --  13  -  PROMOCAO DE CAMPANHA ELEITORAL                     	2
  --  14  -  ANTECIPAÇAO DA LICENÇA GESTANTE                    	13
  --  15  -  AUXILIO DOENCA ACIDENTARIO (INSS)                  	13
  --  16  -  AUXÍLIO DOENÇA (INSS) SEM CARÊNCIA                 	13
  --  17  -  AUXILIO DOENCA OCUPACIONAL (INSS)                  	13
  --  18  -  CONTRATO SUSPENSO (SUB-JÚDICE)                     	2
  --  21  -  LICENCA GESTANTE                                   	13
  --  22  -  LICENCA MATERNIDADE  (ADOÇÃO)                      	13
  --  23  -  LICENÇA MÉDICA INTEGRAL DOENÇA NÃO OCUPACIONAL        	13
  --  24  -  LICENÇA MÉDICA INTEGRAL DOENÇA OCUPACIONAL         	13
  --  25  -  LICENCA MÉDICA ACIDENTÁRIA                         	13
  --  26  -  MANDATO ELETIVO SEM ÔNUS - LEI ELEITORAL              	2
  --  28  -  PRISAO                                             	2
  --  29  -  PRISAO TEMPORÁRIA                                  	2
  --  30  -  PRORROGACAO DA LICENCA GESTANTE                    	13
  --  31  -  SERVICO MILITAR OBRIGATORIO                        	2
  --  32  -  SUSPENSAO DISCIPLINAR                              	2
  --  75  -  LICENÇA- PRÊMIO                                    	4
  --  79  -  CONTRATO SUSPENSO                                  	2
  --  124 -  ABORTO                                             	13
  --  127 -  AUXÍLIO DOENÇA (INSS)                              	13
  --  139 -  REDUÇÃO ADICIONAL NOTURNO (220)                    	3
  --  143 -  AUSÊNCIA POR MOTIVO DE DOENÇA - DET. APOSENTADORIA	    13
  --  144 -  AUSÊNCIA MOTIVO DOENÇA ACIDENT DET APOSENTADORIA	    13
  --  178 -  MANDATO ELETIVO COM ÔNUS - LEI ELEITORAL           	2
  --  224 -  LICENÇA MÉDICA MATUTINA NÃO OCUPACIONAL            	13
  --  225 -  LICENÇA MÉDICA MATUTINA OCUPACIONAL                	13
  --  226 -  LICENÇA MÉDICA MATUTINA ACIDENTÁRIA                	13
  --  227 -  LICENÇA MÉDICA VESPERTINA NÃO OCUPACIONAL          	13
  --  228 -  LICENÇA MÉDICA VESPERTINA OCUPACIONAL                 	13
  --  229 -  LICENÇA MÉDICA VESPERTINA ACIDENTÁRIA              	13
  --  230 -  LICENÇA MÉDICA NOTURNA NÃO OCUPACIONAL             	13
  --  231 -  LICENÇA MÉDICA NOTURNA OCUPACIONAL                 	13
  --  232 -  LICENÇA MÉDICA NOTURNA ACIDENTÁRIA                 	13
  --  Grupo 10 - Todas                                              10
  ------------------------------------------------------------------------------------
  --
   Procedure atualiza_status_empregado is
     --
     -- cursor que recupera empregados de status afastado e que não possuem afastamento
     --
     cursor c_ativ is
            select emp.emp_numero_matricula,
                   emp.rowid
            from   cadastros emp
            where emp.emp_status = 0
            and   emp.emp_numero_matricula not in
                  (select oco.oem_emp_numero_matricula
                   from   ocorrencias_empregados oco
                   where oco.oem_emp_numero_matricula = emp.emp_numero_matricula
                   and   oco.oem_ofu_codigo in (13,14,15,16,17,18,21,22,23,24,25,26,28,29,30,31,32,75,79,124,127,139,143,144,178,224,225,226,227,228,229,230,231,232)
                   and   to_date(to_char(oco.oem_data_inicio,'ddmmyyyy'),'ddmmyyyy') <= to_date(to_char(sysdate,'ddmmyyyy'),'ddmmyyyy')
                   and   (oco.oem_data_termino is null or
                         to_date(to_char(oco.oem_data_termino,'ddmmyyyy'),'ddmmyyyy') >= to_date(to_char(sysdate,'ddmmyyyy'),'ddmmyyyy')));


     -- cursor que recupera empregados de status ativo e que possuem afastamento
     cursor c_afast is
            select emp.emp_numero_matricula,
                   emp.rowid
            from   cadastros emp
            where emp.emp_status = 1
            and   emp.emp_numero_matricula in
                  (select oco.oem_emp_numero_matricula
                   from   ocorrencias_empregados oco
                   where oco.oem_emp_numero_matricula = emp.emp_numero_matricula
                   and   oco.oem_ofu_codigo in (13,14,15,16,17,18,21,22,23,24,25,26,28,29,30,31,32,75,79,124,127,139,143,144,178,224,225,226,227,228,229,230,231,232)
                   and   to_date(to_char(oco.oem_data_inicio,'ddmmyyyy'),'ddmmyyyy') <= to_date(to_char(sysdate,'ddmmyyyy'),'ddmmyyyy')
                   and   (oco.oem_data_termino is null or
                         to_date(to_char(oco.oem_data_termino,'ddmmyyyy'),'ddmmyyyy') >= to_date(to_char(sysdate,'ddmmyyyy'),'ddmmyyyy')));


     -- cursor que recupera empregados de status ativo e que possuem ocorrências de desligamento
     cursor c_desl is
            select emp_numero_matricula,
                   emp.rowid
            from cadastros emp
            where emp.emp_status != 2
            and   emp.emp_numero_matricula in(select oem.oem_emp_numero_matricula
                                              from ocorrencias_empregados oem,
                                                   tipos_ocorrencias
                                              where oem.oem_emp_numero_matricula = emp_numero_matricula
                                              and   oem.oem_ofu_codigo           = ofu_codigo
                                              and   ofu_indicador_tipo           = 10
                                              and   ofu_codigo                  != 264
                                              and   oem.oem_data_inicio in(select max(oco.oem_data_inicio)
                                                                           from ocorrencias_empregados oco
                                                                           where oco.oem_emp_numero_matricula = oem.oem_emp_numero_matricula));
   --
   Begin
      for r_ativ in c_ativ
         --
         loop
            begin
               update cadastros
               set emp_status = 1 -- ativo
               where rowid = r_ativ.rowid;
            end;
      end loop;
      --
      for r_afast in c_afast
         --
         loop
            begin
               update cadastros
               set emp_status = 0 -- afastado
               where rowid = r_afast.rowid;
            end;
      end loop;
      --
      for r_desl in c_desl
         --
         loop
            begin
               update cadastros
               set emp_status = 2 -- desligado
               where rowid = r_desl.rowid;
            end;
      end loop;
   End atualiza_status_empregado;
   --
   --
   Procedure ATUALIZA_FUNCAO is
     -- Esta função tem dois cursores.
     -- c_ini e para carregar na tabela de cadastro a função dos empregados que començam
     -- a ter função o dia de hoje.
     -- c_fim e para apagar na tabela de cadastro a função dos empregados que deixam de
     -- ter função o dia de hoje e fechar a ocorrencia 212 ou 255 correspondente.
     --
     -- Cursor que recupera as funcoes que em SYSDATE começam e tem quer ser atualizadas
     cursor c_ini_fun is
        -- para atualizar a tabela de cadastros
        select oem_ofu_codigo,
               oem_fun_codigo,
               oem_uor_codigo,
      	       oem_tipo_remuneracao_funcao,
      	       -- data_vigencia_funcao, -- pego com o select de funcao
               oem_emp_numero_matricula,
               oem_data_inicio,
               oem_data_termino
          from ocorrencias_empregados
         where oem_ofu_codigo in (217,85,86,93,125)
           and oem_data_inicio = p_data_base - 1;


     -- Cursor que recupera as funcoes que em SYSDATE terminam e tem quer ser desligadas
     cursor c_fim_fun is
      select oem_ofu_codigo,
             oem_fun_codigo,
             oem_uor_codigo,
    	     oem_tipo_remuneracao_funcao,
    	     --dsp_data_criacao_funcao, -- com o select de funcao
             oem_emp_numero_matricula,
             oem_data_inicio,
             oem_data_termino
        from ocorrencias_empregados
       where oem_ofu_codigo in (217,85,86,93,125)
        and oem_data_termino = p_data_base - 1;
   --
   v_data_vigencia DATE;
   --
   Begin
     for r_ini in c_ini_fun
       --
       loop
         begin
           -- Pego a data de vigencia da função
           begin
             select max(qfu_hfl_data_vigencia)
                    into v_data_vigencia
               from funcoes fun,
                    quadro_funcoes qfu
              where fun.fun_codigo = qfu.qfu_fun_codigo
               and qfu.qfu_hfl_uor_codigo = r_ini.oem_uor_codigo
               and fun_codigo = r_ini.oem_fun_codigo;
           exception
             when others then
               null;
           end;
           --
           -- Atualizo a tabela de cadastros
           if r_ini.oem_ofu_codigo in (86,93,125) then
             update cadastros
               set emp_qfu_fun_codigo          = r_ini.oem_fun_codigo,
                   emp_qfu_hfl_uor_codigo      = r_ini.oem_uor_codigo,
                   emp_qfu_hfl_data_vigencia   = v_data_vigencia,
                   emp_tipo_remuneracao_funcao = r_ini.oem_tipo_remuneracao_funcao
             where emp_numero_matricula = r_ini.oem_emp_numero_matricula;

           elsif r_ini.oem_ofu_codigo in (85,217) then
             update cadastros
                set emp_qfu_fun_codigo_acumula      = r_ini.oem_fun_codigo,
                    emp_qfu_hfl_uor_cod_acum        = r_ini.oem_uor_codigo,
                    emp_qfu_hfl_data_vigen_acum     = v_data_vigencia,
                    emp_tipo_remuner_funcao_acumul  = r_ini.oem_tipo_remuneracao_funcao
              where emp_numero_matricula = r_ini.oem_emp_numero_matricula;
           end if;
         end;
       end loop;
       --
     for r_fim in c_fim_fun
       --
       loop
         begin
           -- Atualizo a tabela de cadastros e fecho a ocorrencia 212 ou 255 correspondente
           if r_fim.oem_ofu_codigo in (86,93,125) then
             --
             update ocorrencias_empregados
                set oem_data_termino = r_fim.oem_data_termino
              where oem_emp_numero_matricula = r_fim.oem_emp_numero_matricula
                and oem_data_inicio = r_fim.oem_data_inicio
                and oem_ofu_codigo = 212;
             --
             update cadastros
               set emp_qfu_fun_codigo          = null,
                   emp_qfu_hfl_uor_codigo      = null,
                   emp_qfu_hfl_data_vigencia   = null,
                   emp_tipo_remuneracao_funcao = null
             where emp_numero_matricula = r_fim.oem_emp_numero_matricula;
             --
           elsif r_fim.oem_ofu_codigo in (85,217) then
             --
             update ocorrencias_empregados
                set oem_data_termino = r_fim.oem_data_termino
              where oem_emp_numero_matricula = r_fim.oem_emp_numero_matricula
                and oem_data_inicio = r_fim.oem_data_inicio
                and oem_ofu_codigo = 255;
             --
             update cadastros
                set emp_qfu_fun_codigo_acumula      = null,
                    emp_qfu_hfl_uor_cod_acum        = null,
                    emp_qfu_hfl_data_vigen_acum     = null,
                    emp_tipo_remuner_funcao_acumul  = null
              where emp_numero_matricula = r_fim.oem_emp_numero_matricula;
              --
           end if;
         end;
       end loop;
       --
   End atualiza_funcao;
   --
   -- ESTE PROCEDIMENTO ATUALIZA A DEPENDENCIA,UOR E CENTRO DE CUSTO DA TABELA DE CADASTROS
   -- E FAZ O INSERE NA TABELA DE HISTORICO_CENTRO_CUSTOS
   PROCEDURE RETORNO_TRANSF_PROVISORIA IS
     --
     CURSOR C_PRO IS
       -- Pega os dados das matriculas ocorrencia 81, que tem uma transferencia provisoria
       -- com data de retorno em SYSDATE - 1 (quer dizer que em SYSDATE já acabou a transferencia
       -- provisoria)
       SELECT OEM_EMP_NUMERO_MATRICULA MATRICULA,
              OEM_OFU_CODIGO OFU_CODIGO,
              OEM_DATA_INICIO DT_INICIO,
              OEM_DEP_CODIGO DEP_CODIGO,
              OEM_UOR_CODIGO UOR_CODIGO,
              OEM_CCT_CODIGO CCT_CODIGO,
              SUBSTR(OEM_CCT_CODIGO,1,LENGTH(OEM_CCT_CODIGO)-1) HCC_CCT_CODIGO -- Sem Digito Verificador
         FROM OCORRENCIAS_EMPREGADOS OCO
        WHERE EXISTS (SELECT 'S'
                        FROM OCORRENCIAS_EMPREGADOS OCO2
                       WHERE (OCO2.OEM_DATA_TERMINO + 1) = TRUNC(SYSDATE)
                         AND OCO2.OEM_OFU_CODIGO IN (83,277) -- TRANSF. PROVISORIA E PRORROGA
                         AND OCO2.OEM_EMP_NUMERO_MATRICULA = OCO.OEM_EMP_NUMERO_MATRICULA
                      )
          AND OEM_DATA_TERMINO IS NULL
          AND OEM_OFU_CODIGO = 81
       ORDER BY OEM_EMP_NUMERO_MATRICULA;
   --
   R_PRO  C_PRO%ROWTYPE;
   --
   V_OBSERVACAO  VARCHAR2(200) := 'REGISTRO GERADO AUTOMATICAMENTE PELO RETORNO DE UMA '||
                                  'TRANSFERENCIA PROVISÓRIA O PRORROGA DA MESMA';
   --
   BEGIN
     FOR R_PRO IN C_PRO
       --
       LOOP
         BEGIN
           --
           -- ATUALIZO A TABELA DE CADASTROS
           UPDATE CADASTROS
              SET EMP_DEP_CODIGO_FISICO       = R_PRO.DEP_CODIGO,
                  EMP_UOR_CODIGO_LOTACAO      = R_PRO.UOR_CODIGO,
                  EMP_ATI_CT_CUSTOS           = R_PRO.CCT_CODIGO
            WHERE EMP_NUMERO_MATRICULA = R_PRO.MATRICULA;
         --
         EXCEPTION
           WHEN OTHERS THEN
             NULL;
         END;
         --
         BEGIN
           -- INSERE O NOVO CENTRO DE CUSTOS NA TABELA DE HISTORICOS
           INSERT INTO HISTORICO_CENTRO_CUSTOS
                   (
                   HCC_EMP_NUMERO_MATRICULA,
                   HCC_CCT_CODIGO,
                   HCC_DATA,
                   HCC_OBSERVACAO
                   )
              VALUES
                   (
                   R_PRO.MATRICULA,
                   R_PRO.HCC_CCT_CODIGO, -- Centro de Custo sem Digito Verificador
                   TRUNC(SYSDATE), -- A PARTIR DE HOJE VOLTA A TER O CC DA 81 EM ABERTO
                   V_OBSERVACAO
                   );
         --
         EXCEPTION
           WHEN OTHERS THEN
             NULL;
         END;
       END LOOP;
       --
   END RETORNO_TRANSF_PROVISORIA;
   -----------------------------------------------------------------------------------------
   -----------------------------------------------------------------------------------------
   --     ---------------- ******* MANUTENÇÃO ATIVIDADES_EMPREGADOS *********
   -- O procedimento atualiza os dados das atividades empregados de acordo com as alterações
   -- de ocorrencias de funcão. Para o mesmo existe uma trigger na tabela de ocorrencias_empregados
   -- que insere registros em uma tabela chamada CTRL_FUN_ATIVIDADES_EMPREGADOS toda vez que
   -- se faz um insert, delete or update dos atributos oem_data_termino, oem_data_inicio,
   -- oem_fun_codigo, oem_fun_codigo_acumula o oem_fun_codigo_substitui com as ocorrencias de
   -- função (86,88,93,125,238,240,256,85,217,89,220).
   -- Apaga as atividades_empregados que tiveram alteracões de função
   PROCEDURE APAGA_ATIV_EMP_ALTERADAS IS

      CURSOR Cur_fun IS
         SELECT CFA_EMP_NUMERO_MATRICULA MATRICULA,
                CFA_NEW_FUN_CODIGO FUN_CODIGO
           FROM CTRL_FUN_ATIVIDADES_EMPREGADOS
          WHERE CFA_FLAG_EXECUTO = 'N'
            AND CFA_NEW_FUN_CODIGO IS NOT NULL
         GROUP BY CFA_EMP_NUMERO_MATRICULA,
                  CFA_NEW_FUN_CODIGO

         UNION

         SELECT CFA_EMP_NUMERO_MATRICULA MATRICULA,
                CFA_OLD_FUN_CODIGO FUN_CODIGO
           FROM CTRL_FUN_ATIVIDADES_EMPREGADOS
          WHERE CFA_FLAG_EXECUTO = 'N'
            AND CFA_OLD_FUN_CODIGO IS NOT NULL
         GROUP BY CFA_EMP_NUMERO_MATRICULA,
                  CFA_OLD_FUN_CODIGO;
     --
     C_FUN CUR_FUN%ROWTYPE;
     --
     BEGIN
       --
       OPEN CUR_FUN;
       --
       LOOP
           --
           FETCH CUR_FUN INTO C_FUN;
           EXIT WHEN CUR_FUN%NOTFOUND;
           --
           DELETE ATIVIDADES_EMPREGADOS
           WHERE AEM_FUN_CODIGO = C_FUN.FUN_CODIGO
             AND AEM_EMP_NUMERO_MATRICULA = C_FUN.MATRICULA;
           --
         END LOOP;
       CLOSE CUR_FUN;
       --
       COMMIT;
       --
   END APAGA_ATIV_EMP_ALTERADAS;
   ----------------
   -------------
   -- Insere as Atividades que foram apagadas atualizadas da tabela de ocorrencias so para
   -- as funções que foram modificadas.
   -- Procedimentos INS_ATIV_EMP_PRI_SUB e INS_ATIV_EMP_ACUM
   PROCEDURE INS_ATIV_EMP_PRI_SUB IS
         CURSOR C_fun_prin IS
            SELECT OEM_EMP_NUMERO_MATRICULA MATRICULA,
                   OEM_OFU_CODIGO OFU_CODIGO,
                   OEM_DATA_INICIO DT_INICIO,
                   OEM_DATA_TERMINO DT_TERMINO,
                   SUBSTR(NVL(OEM_DIPLOMA_LEGAL,'NAO INFORMADO'),1,30) DOC_INICIO,
                   SUBSTR(OEM_DIPLOMA_LEGAL_TERMINO,1,30) DOC_TERMINO,
                   DECODE(OEM_OFU_CODIGO,89,OEM_FUN_CODIGO_SUBSTITUI,
                                         220,OEM_FUN_CODIGO_SUBSTITUI,
                                         OEM_FUN_CODIGO
                          ) FUN_CODIGO
              FROM OCORRENCIAS_EMPREGADOS OCO,
                   CARGOS_CONFIANCA FUN,
                   CADASTROS,
                   (
                    SELECT CFA_EMP_NUMERO_MATRICULA MATRICULA,
                           CFA_NEW_FUN_CODIGO FUN_CODIGO
                      FROM CTRL_FUN_ATIVIDADES_EMPREGADOS
                     WHERE CFA_FLAG_EXECUTO = 'N'
                       AND CFA_NEW_FUN_CODIGO IS NOT NULL
                    GROUP BY CFA_EMP_NUMERO_MATRICULA,
                             CFA_NEW_FUN_CODIGO
                    UNION
                    SELECT CFA_EMP_NUMERO_MATRICULA MATRICULA,
                           CFA_OLD_FUN_CODIGO FUN_CODIGO
                      FROM CTRL_FUN_ATIVIDADES_EMPREGADOS
                     WHERE CFA_FLAG_EXECUTO = 'N'
                       AND CFA_OLD_FUN_CODIGO IS NOT NULL
                    GROUP BY CFA_EMP_NUMERO_MATRICULA,
                             CFA_OLD_FUN_CODIGO
                   ) APAGA
             WHERE OEM_EMP_NUMERO_MATRICULA = APAGA.MATRICULA
               AND DECODE(OEM_OFU_CODIGO,89,OEM_FUN_CODIGO_SUBSTITUI,
                                         220,OEM_FUN_CODIGO_SUBSTITUI,
                                         OEM_FUN_CODIGO
                          ) = APAGA.FUN_CODIGO
               AND OEM_EMP_NUMERO_MATRICULA = EMP_NUMERO_MATRICULA
               AND DECODE(OEM_OFU_CODIGO,89,OEM_FUN_CODIGO_SUBSTITUI,
                                         220,OEM_FUN_CODIGO_SUBSTITUI,
                                         OEM_FUN_CODIGO
                          ) = FUN.FUN_CODIGO
               AND FUN_DATA_CRIACAO >= '10/04/2001'
               AND TRUNC(OEM_DATA_INCLUSAO) <= TRUNC(SYSDATE) -1
               AND OCO.OEM_OFU_CODIGO IN (86,88,93,125,238,240,256, -- FUN PRINCIPAIS
                                          89,220) -- FUN SUBSTITUICOES
               AND EMP_STATUS != 2
             ORDER BY 1,3 DESC,7;
        --
        c_prin C_fun_prin%rowtype;
        --
        CURSOR c_fun_ati(p_fun_codigo cargos_confianca.fun_codigo%TYPE) IS
          select fun_codigo,
                 atf_ati_codigo ati_codigo
            from cargos_confianca,
                 atividades_funcoes
           where fun_codigo = atf_fun_codigo
             and fun_codigo = p_fun_codigo
          order by fun_codigo, atf_ati_codigo;
        --

        c_ati c_fun_ati%rowtype;
        --
        v_matricula  CADASTROS.emp_numero_matricula%TYPE;
        v_dt_ini     DATE;
        v_dt_ter     DATE;
        v_doc_ini    OCORRENCIAS_EMPREGADOS.OEM_DIPLOMA_LEGAL%TYPE;
        v_doc_ter    OCORRENCIAS_EMPREGADOS.OEM_DIPLOMA_LEGAL_TERMINO%TYPE;
        v_fun_codigo CARGOS_CONFIANCA.FUN_CODIGO%TYPE;
        --
        v_alteradas NUMBER := 0;
        v_erroneas NUMBER := 0;
        --
        v_qtde_dias         number:= 0;
        v_paso      VARCHAR2(1) := 'N';

        BEGIN
          --
          open c_fun_prin;
          --
          fetch c_fun_prin into c_prin;
          -- exit when c_fun_prin%notfound;
          --
          v_matricula   := c_prin.matricula;
          v_dt_ini      := c_prin.dt_inicio;
          v_dt_ter      := c_prin.dt_termino;
          v_doc_ini     := c_prin.doc_inicio;
          v_doc_ter     := c_prin.doc_termino;
          v_fun_codigo  := c_prin.fun_codigo;
          --
          loop
            begin
              --
              fetch c_fun_prin into c_prin;
              exit when c_fun_prin%notfound;
              --
              -- Verifica se é a mesma matricula
              if v_matricula = c_prin.matricula then
                --
                v_paso := 'N';
                --
                -- Verifica se as datas são contiguas
                if v_dt_ini = (c_prin.dt_termino + 1) and v_fun_codigo = c_prin.fun_codigo
                then
                  v_dt_ini    := c_prin.dt_inicio;
                  v_doc_ini     := c_prin.doc_inicio;
                  --
                else -- Se as datas não são contiguas ou a função e diferente,
                     -- devo inserir o registro anterior
                  --
                  -- Pego as atividades da função
                  open c_fun_ati(v_fun_codigo);
                  --
                  loop
                      --
                      fetch c_fun_ati into c_ati;
                      exit when c_fun_ati%notfound;
                      --
                      --
                      -- FAÇO O INSERT NA TABELA DE ATIVIDADES_EMPREGADOS
                      BEGIN
                        INSERT INTO ATIVIDADES_EMPREGADOS
                                (
                                  AEM_ATI_CODIGO,
                                  AEM_EMP_NUMERO_MATRICULA,
                                  AEM_DATA_INICIO,
                                  AEM_DATA_TERMINO,
                                  AEM_DOCUMENTO_INICIO,
                                  AEM_DOCUMENTO_TERMINO,
                                  AEM_OBSERVACAO,
                                  AEM_IND_ATI_FUN_CAR,
                                  AEM_IND_ATI_INERENTE,
                                  AEM_DATA_CONFIRMA_NAO_INERENTE,
                                  AEM_ID_USUARIO_CONFIRMACAO,
                                  AEM_FUN_CODIGO
                                )
                           values
                                (
                                  C_ATI.ATI_CODIGO,
                                  V_MATRICULA,
                                  V_DT_INI,
                                  V_DT_TER,
                                  V_DOC_INI,
                                  V_DOC_TER,
                                  NULL, -- AEM_IND_ATI_INERENTE,
                                  'F',  -- FUNCAO, É FIXA
                                  NULL, -- AEM_IND_ATI_INERENTE,
                                  NULL, -- AEM_DATA_CONFIRMA_NAO_INERENTE,
                                  NULL,  -- AEM_ID_USUARIO_CONFIRMACAO,
                                  v_fun_codigo
                                );

                      --
                      COMMIT;
                      --
                      EXCEPTION
                      WHEN DUP_VAL_ON_INDEX THEN
                        NULL;
                        -- dbms_output.put_line('Matriculas com dados dup:'||to_char(v_matricula));
                      END;
                  end loop;
                  close c_fun_ati;
                  --
                  -- Preparo o novo registro com o ultimo registro sem inserir
                  v_dt_ini      := c_prin.dt_inicio;
                  v_dt_ter      := c_prin.dt_termino;
                  v_doc_ini     := c_prin.doc_inicio;
                  v_doc_ter     := c_prin.doc_termino;
                  v_fun_codigo  := c_prin.fun_codigo;
                  --
                end if; -- de Verifica se as datas são contiguas
                --
              else -- Se é outra matricula então insere o registro
                --
                open c_fun_ati(v_fun_codigo);
                --
                loop
                    fetch c_fun_ati into c_ati;
                    exit when c_fun_ati%notfound;
                    --
                    -- FAÇO O INSERT NA TABELA DE ATIVIDADES_EMPREGADOS
                    BEGIN
                      INSERT INTO ATIVIDADES_EMPREGADOS
                          (
                            AEM_ATI_CODIGO,
                            AEM_EMP_NUMERO_MATRICULA,
                            AEM_DATA_INICIO,
                            AEM_DATA_TERMINO,
                            AEM_DOCUMENTO_INICIO,
                            AEM_DOCUMENTO_TERMINO,
                            AEM_OBSERVACAO,
                            AEM_IND_ATI_FUN_CAR,
                            AEM_IND_ATI_INERENTE,
                            AEM_DATA_CONFIRMA_NAO_INERENTE,
                            AEM_ID_USUARIO_CONFIRMACAO,
                            AEM_FUN_CODIGO
                          )
                     values
                          (
                            C_ATI.ATI_CODIGO,
                            V_MATRICULA,
                            V_DT_INI,
                            V_DT_TER,
                            V_DOC_INI,
                            V_DOC_TER,
                            NULL, -- AEM_IND_ATI_INERENTE,
                            'F',  -- FUNCAO, É FIXA
                            NULL, -- AEM_IND_ATI_INERENTE,
                            NULL, -- AEM_DATA_CONFIRMA_NAO_INERENTE,
                            NULL,  -- AEM_ID_USUARIO_CONFIRMACAO
                            v_fun_codigo
                          );
                    --
                    COMMIT;
                    --
                    EXCEPTION
                    WHEN DUP_VAL_ON_INDEX THEN
                      NULL;
                      -- dbms_output.put_line('Matriculas com dados dup:'||to_char(v_matricula));
                    END;
                end loop;
                close c_fun_ati;
                --
                v_matricula   := c_prin.matricula;
                v_dt_ini      := c_prin.dt_inicio;
                v_dt_ter      := c_prin.dt_termino;
                v_doc_ini     := c_prin.doc_inicio;
                v_doc_ter     := c_prin.doc_termino;
                v_fun_codigo  := c_prin.fun_codigo;
                --
              end if; -- De v_matricula = c_prin.matricula
              --
              --              dbms_output.put_line();
            end;
          end loop;
        close c_fun_prin;
        -- Faço o insere do ultimo registro
        open c_fun_ati(v_fun_codigo);
        --
        loop
            fetch c_fun_ati into c_ati;
            exit when c_fun_ati%notfound;
            --
            -- FAÇO O INSERT NA TABELA DE ATIVIDADES_EMPREGADOS
            BEGIN
              INSERT INTO ATIVIDADES_EMPREGADOS
                          (
                            AEM_ATI_CODIGO,
                            AEM_EMP_NUMERO_MATRICULA,
                            AEM_DATA_INICIO,
                            AEM_DATA_TERMINO,
                            AEM_DOCUMENTO_INICIO,
                            AEM_DOCUMENTO_TERMINO,
                            AEM_OBSERVACAO,
                            AEM_IND_ATI_FUN_CAR,
                            AEM_IND_ATI_INERENTE,
                            AEM_DATA_CONFIRMA_NAO_INERENTE,
                            AEM_ID_USUARIO_CONFIRMACAO,
                            AEM_FUN_CODIGO
                          )
                     values
                          (
                            C_ATI.ATI_CODIGO,
                            V_MATRICULA,
                            V_DT_INI,
                            V_DT_TER,
                            V_DOC_INI,
                            V_DOC_TER,
                            NULL, -- AEM_IND_ATI_INERENTE,
                            'F',  -- FUNCAO, É FIXA
                            NULL, -- AEM_IND_ATI_INERENTE,
                            NULL, -- AEM_DATA_CONFIRMA_NAO_INERENTE,
                            NULL,  -- AEM_ID_USUARIO_CONFIRMACAO
                            V_FUN_CODIGO
                          );
            --
            COMMIT;
            --
            EXCEPTION
              WHEN DUP_VAL_ON_INDEX THEN
                NULL;-- dbms_output.put_line('Matriculas com dados dup:'||to_char(v_matricula));
            END;
        end loop;
        close c_fun_ati;
        --
        COMMIT;
        --
        EXCEPTION
          WHEN DUP_VAL_ON_INDEX THEN
            NULL;
        --
   END INS_ATIV_EMP_PRI_SUB;
   -----------------
   PROCEDURE INS_ATIV_EMP_ACUM IS
        CURSOR C_fun_cum IS
          select oem_emp_numero_matricula matricula,
                 oem_ofu_codigo ofu_codigo,
                 oem_data_inicio dt_inicio,
                 oem_data_termino dt_termino,
                 SUBSTR(NVL(oem_diploma_legal,'NAO INFORMADO'),1,30) doc_inicio,
                 SUBSTR(oem_diploma_legal_termino,1,30) doc_termino,
                 OEM_FUN_CODIGO_ACUMULA fun_codigo
            from ocorrencias_empregados oem_acum,
                 cargos_confianca fun,
                 cadastros,
                 (
                  SELECT CFA_EMP_NUMERO_MATRICULA MATRICULA,
                         CFA_NEW_FUN_CODIGO FUN_CODIGO
                    FROM CTRL_FUN_ATIVIDADES_EMPREGADOS
                   WHERE CFA_FLAG_EXECUTO = 'N'
                     AND CFA_NEW_FUN_CODIGO IS NOT NULL
                  GROUP BY CFA_EMP_NUMERO_MATRICULA,
                           CFA_NEW_FUN_CODIGO
                  UNION
                  SELECT CFA_EMP_NUMERO_MATRICULA MATRICULA,
                         CFA_OLD_FUN_CODIGO FUN_CODIGO
                    FROM CTRL_FUN_ATIVIDADES_EMPREGADOS
                   WHERE CFA_FLAG_EXECUTO = 'N'
                     AND CFA_OLD_FUN_CODIGO IS NOT NULL
                  GROUP BY CFA_EMP_NUMERO_MATRICULA,
                           CFA_OLD_FUN_CODIGO
                 ) APAGA
           where oem_emp_numero_matricula = APAGA.MATRICULA
             AND OEM_FUN_CODIGO_ACUMULA = APAGA.FUN_CODIGO
             and oem_emp_numero_matricula = emp_numero_matricula
             and OEM_FUN_CODIGO_ACUMULA = fun.fun_codigo
             and fun_data_criacao >= '10/04/2001'
             and oem_acum.oem_ofu_codigo in (85,217) --1207
             and not exists
                      (select 'S'
                         from ocorrencias_empregados oem_pri
                        where oem_pri.oem_ofu_codigo in (86,88,93,125,238,240,256,89,220)
                          and oem_pri.oem_fun_codigo = oem_acum.oem_fun_codigo
                          and ((oem_acum.oem_data_inicio >= oem_pri.oem_data_inicio and
                                oem_acum.oem_data_inicio <= oem_pri.oem_data_termino
                                ) or
                               (oem_acum.oem_data_termino >= oem_pri.oem_data_inicio and
                                oem_acum.oem_data_termino <= oem_pri.oem_data_termino )
                               )
                          and oem_pri.oem_emp_numero_matricula = oem_acum.oem_emp_numero_matricula
                      )
            and OEM_FUN_CODIGO_ACUMULA is not null
            AND TRUNC(OEM_DATA_INCLUSAO) <= TRUNC(SYSDATE) -1
--             and oco.oem_emp_numero_matricula = 1978---217750 --9608972
             and emp_status != 2
             order by 1,3 desc,7;
        --
        c_cum C_fun_cum%rowtype;
        --
        CURSOR c_fun_ati(p_fun_codigo cargos_confianca.fun_codigo%TYPE) IS
          select fun_codigo,
                 atf_ati_codigo ati_codigo
            from cargos_confianca,
                 atividades_funcoes
           where fun_codigo = atf_fun_codigo
             and fun_codigo = p_fun_codigo
          order by fun_codigo, atf_ati_codigo;
        --

        c_ati c_fun_ati%rowtype;
        --
        v_matricula  CADASTROS.emp_numero_matricula%TYPE;
        v_dt_ini     DATE;
        v_dt_ter     DATE;
        v_doc_ini    OCORRENCIAS_EMPREGADOS.OEM_DIPLOMA_LEGAL%TYPE;
        v_doc_ter    OCORRENCIAS_EMPREGADOS.OEM_DIPLOMA_LEGAL_TERMINO%TYPE;
        v_fun_codigo CARGOS_CONFIANCA.FUN_CODIGO%TYPE;
        --
        v_alteradas     NUMBER := 0;
        v_erroneas      NUMBER := 0;
        --
        v_qtde_dias     number:= 0;
        v_paso          VARCHAR2(1) := 'N';

        BEGIN
          --
          open c_fun_cum;
          --
          fetch c_fun_cum into c_cum;
          -- exit when c_fun_cum%notfound;
          --
          v_matricula   := c_cum.matricula;
          v_dt_ini      := c_cum.dt_inicio;
          v_dt_ter      := c_cum.dt_termino;
          v_doc_ini     := c_cum.doc_inicio;
          v_doc_ter     := c_cum.doc_termino;
          v_fun_codigo  := c_cum.fun_codigo;
          --
          loop
            begin
              --
              fetch c_fun_cum into c_cum;
              exit when c_fun_cum%notfound;
              --
              -- Verifica se é a mesma matricula
              if v_matricula = c_cum.matricula then
                --
                v_paso := 'N';
                --
                -- Verifica se as datas são contiguas
                if v_dt_ini = (c_cum.dt_termino + 1) and v_fun_codigo = c_cum.fun_codigo
                then
                  v_dt_ini    := c_cum.dt_inicio;
                  v_doc_ini     := c_cum.doc_inicio;
                  --
                else -- Se as datas não são contiguas ou a função e diferente,
                     -- devo inserir o registro anterior
                  --
                  -- Pego as atividades da função
                  open c_fun_ati(v_fun_codigo);
                  --
                  loop
                      fetch c_fun_ati into c_ati;
                      exit when c_fun_ati%notfound;
                      --
                      -- FAÇO O INSERT NA TABELA DE ATIVIDADES_EMPREGADOS
                      BEGIN
                        INSERT INTO ATIVIDADES_EMPREGADOS
                                (
                                  AEM_ATI_CODIGO,
                                  AEM_EMP_NUMERO_MATRICULA,
                                  AEM_DATA_INICIO,
                                  AEM_DATA_TERMINO,
                                  AEM_DOCUMENTO_INICIO,
                                  AEM_DOCUMENTO_TERMINO,
                                  AEM_OBSERVACAO,
                                  AEM_IND_ATI_FUN_CAR,
                                  AEM_IND_ATI_INERENTE,
                                  AEM_DATA_CONFIRMA_NAO_INERENTE,
                                  AEM_ID_USUARIO_CONFIRMACAO,
                                  AEM_FUN_CODIGO
                                )
                           values
                                (
                                  C_ATI.ATI_CODIGO,
                                  V_MATRICULA,
                                  V_DT_INI,
                                  V_DT_TER,
                                  V_DOC_INI,
                                  V_DOC_TER,
                                  NULL, -- AEM_IND_ATI_INERENTE,
                                  'F',  -- FUNCAO, É FIXA
                                  NULL, -- AEM_IND_ATI_INERENTE,
                                  NULL, -- AEM_DATA_CONFIRMA_NAO_INERENTE,
                                  NULL,  -- AEM_ID_USUARIO_CONFIRMACAO
                                  V_FUN_CODIGO
                                );

                      --
                      COMMIT;
                      --
                      EXCEPTION
                      WHEN DUP_VAL_ON_INDEX THEN
                        NULL;
                        -- dbms_output.put_line('Matriculas com dados dup:'||to_char(v_matricula));
                      END;
                  end loop;
                  close c_fun_ati;
                  -- Preparo o novo registro com o ultimo registro sem inserir
                  v_dt_ini      := c_cum.dt_inicio;
                  v_dt_ter      := c_cum.dt_termino;
                  v_doc_ini     := c_cum.doc_inicio;
                  v_doc_ter     := c_cum.doc_termino;
                  v_fun_codigo  := c_cum.fun_codigo;
                  --
                end if; -- de Verifica se as datas são contiguas
                --
              else -- Se é outra matricula então insere o registro
                --
                open c_fun_ati(v_fun_codigo);
                --
                loop
                    fetch c_fun_ati into c_ati;
                    exit when c_fun_ati%notfound;
                    --
                    -- FAÇO O INSERT NA TABELA DE ATIVIDADES_EMPREGADOS
                    BEGIN
                      INSERT INTO ATIVIDADES_EMPREGADOS
                          (
                            AEM_ATI_CODIGO,
                            AEM_EMP_NUMERO_MATRICULA,
                            AEM_DATA_INICIO,
                            AEM_DATA_TERMINO,
                            AEM_DOCUMENTO_INICIO,
                            AEM_DOCUMENTO_TERMINO,
                            AEM_OBSERVACAO,
                            AEM_IND_ATI_FUN_CAR,
                            AEM_IND_ATI_INERENTE,
                            AEM_DATA_CONFIRMA_NAO_INERENTE,
                            AEM_ID_USUARIO_CONFIRMACAO,
                            AEM_FUN_CODIGO
                          )
                     values
                          (
                            C_ATI.ATI_CODIGO,
                            V_MATRICULA,
                            V_DT_INI,
                            V_DT_TER,
                            V_DOC_INI,
                            V_DOC_TER,
                            NULL, -- AEM_IND_ATI_INERENTE,
                            'F',  -- FUNCAO, É FIXA
                            NULL, -- AEM_IND_ATI_INERENTE,
                            NULL, -- AEM_DATA_CONFIRMA_NAO_INERENTE,
                            NULL,  -- AEM_ID_USUARIO_CONFIRMACAO
                            V_FUN_CODIGO
                          );
                    --
                    COMMIT;
                    --
                    EXCEPTION
                      WHEN DUP_VAL_ON_INDEX THEN
                        NULL;
                      -- dbms_output.put_line('Matriculas com dados dup:'||to_char(v_matricula));
                    END;
                end loop;
                close c_fun_ati;
                --
                v_matricula   := c_cum.matricula;
                v_dt_ini      := c_cum.dt_inicio;
                v_dt_ter      := c_cum.dt_termino;
                v_doc_ini     := c_cum.doc_inicio;
                v_doc_ter     := c_cum.doc_termino;
                v_fun_codigo  := c_cum.fun_codigo;
                --
              end if; -- De v_matricula = c_cum.matricula
              --
              --              dbms_output.put_line();
            end;
          end loop;
        close c_fun_cum;
        -- Faço o insere do ultimo registro
        open c_fun_ati(v_fun_codigo);
        --
        loop
            fetch c_fun_ati into c_ati;
            exit when c_fun_ati%notfound;
            --
            -- FAÇO O INSERT NA TABELA DE ATIVIDADES_EMPREGADOS
            BEGIN
              INSERT INTO ATIVIDADES_EMPREGADOS
                          (
                            AEM_ATI_CODIGO,
                            AEM_EMP_NUMERO_MATRICULA,
                            AEM_DATA_INICIO,
                            AEM_DATA_TERMINO,
                            AEM_DOCUMENTO_INICIO,
                            AEM_DOCUMENTO_TERMINO,
                            AEM_OBSERVACAO,
                            AEM_IND_ATI_FUN_CAR,
                            AEM_IND_ATI_INERENTE,
                            AEM_DATA_CONFIRMA_NAO_INERENTE,
                            AEM_ID_USUARIO_CONFIRMACAO,
                            AEM_FUN_CODIGO
                          )
                     values
                          (
                            C_ATI.ATI_CODIGO,
                            V_MATRICULA,
                            V_DT_INI,
                            V_DT_TER,
                            V_DOC_INI,
                            V_DOC_TER,
                            NULL, -- AEM_IND_ATI_INERENTE,
                            'F',  -- FUNCAO, É FIXA
                            NULL, -- AEM_IND_ATI_INERENTE,
                            NULL, -- AEM_DATA_CONFIRMA_NAO_INERENTE,
                            NULL,  -- AEM_ID_USUARIO_CONFIRMACAO
                            V_FUN_CODIGO
                          );
            --
            COMMIT;
            --
            EXCEPTION
            WHEN DUP_VAL_ON_INDEX THEN
              NULL;
              --dbms_output.put_line('Matriculas com dados dup:'||to_char(v_matricula));
            END;
        end loop;
        close c_fun_ati;
        -- ATUALIZA O FLAG DA TABELA DE CONTROL
        UPDATE CTRL_FUN_ATIVIDADES_EMPREGADOS
           SET CFA_FLAG_EXECUTO = 'S'
         WHERE (EXISTS (SELECT 'S'
                          FROM ATIVIDADES_FUNCOES
                         WHERE atf_fun_codigo = CFA_NEW_FUN_CODIGO
                        )
                OR CFA_TIP_OPERACAO = 'D'
               )
           AND CFA_FLAG_EXECUTO = 'N'
           AND TRUNC(CFA_DTA_OPERACAO) <= TRUNC(SYSDATE) - 1;
        --
        COMMIT;
--        dbms_output.put_line('Matriculas com mais de um afas:'||v_matricula);
        --
        EXCEPTION
        WHEN DUP_VAL_ON_INDEX THEN
          NULL;
          -- dbms_output.put_line('Matriculas com dados dup:'||to_char(v_matricula));
   END INS_ATIV_EMP_ACUM;
   ----------------
   ---------------- ******* FIM MANUTENÇÃO ATIVIDADES_EMPREGADOS *********
   -----------------------------------------------------------------------------------------
   ---***********************************************************************************---
   --
   --
   ------------------------------------------------------------------------------------
   -- Rotina para atualizar na tabela de Empregados, os atributos referentes à
   -- designação de função de empregados que estão com data término das ocorrencias
   --    86 Designação de função de confiança
   --    93 Designação interina de função de confiança
   --   125 Designação de diretor empregado
   -- igual ao dia anterior à data do sistema
   ------------------------------------------------------------------------------------
   /*
   Procedure atualiza_final_funcao is
      cursor c_fun is
             select oem_emp_numero_matricula
             from   ocorrencias_empregados
             where  oem_ofu_codigo in (86, 93, 125)
             and    oem_data_termino = p_data_base - 1;
   Begin
      for r_fun in c_fun
      loop
         begin
            update cadastros
            set    emp_qfu_fun_codigo           = null,
                   emp_qfu_hfl_uor_codigo       = null,
                   emp_qfu_hfl_data_vigencia    = null,
                   emp_tipo_remuneracao_funcao  = null
            where  emp_numero_matricula = r_fun.oem_emp_numero_matricula;
         end;
      end loop;
   End atualiza_final_funcao;
   */
   ------------------------------------------------------------------------------------
   -- Rotina para atualizar na tabela de Empregados, os atributos referentes à
   -- designação de função de empregados que estão com data início das ocorrencias
   --    86 Designação de função de confiança
   --    93 Designação interina de função de confiança
   --   125 Designação de diretor empregado
   -- igual ao dia do sistema
   ------------------------------------------------------------------------------------
   /*
   Procedure atualiza_inicio_funcao is
      v_data_vigencia   date;
      cursor c_fun is
             select oem_emp_numero_matricula,
                    oem_fun_codigo,
                    oem_uor_codigo,
                    oem_tipo_remuneracao_funcao
             from   ocorrencias_empregados
             where  oem_ofu_codigo in (86, 93, 125)
             and    oem_data_inicio = p_data_base;
   Begin
      for r_fun in c_fun
      loop
         begin
           select max(qfd_hfd_data_vigencia)
           into   v_data_vigencia
           from   quadros_funcoes_dependencias
           where  qfd_fun_codigo = r_fun.oem_fun_codigo;
         end;
         begin
           update cadastros
           set    emp_qfu_fun_codigo          = r_fun.oem_fun_codigo,
                  emp_qfu_hfl_uor_codigo      = r_fun.oem_uor_codigo,
                  emp_qfu_hfl_data_vigencia   = v_data_vigencia,
                  emp_tipo_remuneracao_funcao = r_fun.oem_tipo_remuneracao_funcao
           where  emp_numero_matricula        = r_fun.oem_emp_numero_matricula;
         end;
      end loop;
   End atualiza_inicio_funcao;
   */
   ------------------------------------------------------------------------------------
   -- Rotina para atualizar na tabela de Empregados, os atributos referentes à
   -- designação de função cumulativa ou substituição de função com data término
   -- das ocorrencias
   --    85 Designação cumulativa de função de confiança
   --    89 Substituição de função de confiança maior 7 dias
   --   220 substituição cumulativa de função de confiança maior 7 dias
   --   217 Designação cumulativa e interina de função de confiança
   -- igual ao dia anterior à data do sistema
   ------------------------------------------------------------------------------------

   Procedure atualiza_final_cumulativa is
     cursor c_acum is
             select oem_emp_numero_matricula,
                    oem_ofu_codigo,
                    oco.oem_fun_codigo_acumula
             from   ocorrencias_empregados oco,
                    cadastros
             where not exists
                     (select 'S'
                        from ocorrencias_empregados oco2
                       where oco2.oem_emp_numero_matricula = emp_numero_matricula
                         and oco2.oem_fun_codigo_acumula = emp_qfu_fun_codigo_acumula
                         and oem_data_termino >= trunc(p_data_base) - 1

                     )
               and emp_numero_matricula = oem_emp_numero_matricula
               and emp_qfu_fun_codigo_acumula = oco.oem_fun_codigo_acumula
               and oem_ofu_codigo in (85, 217)
               and oem_data_termino < trunc(p_data_base) - 1
               and emp_status != 2;


     cursor c_subs is
             select oem_emp_numero_matricula,
                    oem_ofu_codigo,
                    oco.oem_fun_codigo_substitui
             from   ocorrencias_empregados oco,
                    cadastros
             where not exists
                     (select 'S'
                        from ocorrencias_empregados oco2
                       where oco2.oem_emp_numero_matricula = emp_numero_matricula
                         and oco2.oem_fun_codigo_substitui = emp_qfu_fun_codigo_substitui
                         and oem_data_termino >= trunc(p_data_base) - 1
                     )
               and emp_numero_matricula = oem_emp_numero_matricula
               and emp_qfu_fun_codigo_substitui = oco.oem_fun_codigo_substitui
               and oem_ofu_codigo in (89, 220)
               and oem_data_termino < trunc(p_data_base) - 1
               and emp_status != 2;

   r_acum c_acum%rowtype;
   r_subs c_subs%rowtype;
   v_count_acum number := 0;
   v_count_subs number := 0;
begin
  for r_acum in c_acum loop
        begin
          update cadastros
             set    emp_qfu_fun_codigo_acumula     = null,
                    emp_qfu_hfl_uor_cod_acum       = null,
                    emp_qfu_hfl_data_vigen_acum    = null,
                    emp_tipo_remuner_funcao_acumul = null
             where  emp_numero_matricula = r_acum.oem_emp_numero_matricula;
          --
          --v_count_acum := v_count_acum + 1;
        --
        exception
          when others then
            null;
        end;
    end loop;
    --
    for r_subs in c_subs loop
         begin
           update cadastros
              set    emp_qfu_fun_codigo_substitui   = null,
                     emp_qfu_hfl_uor_cod_subst      = null,
                     emp_qfu_hfl_data_vigen_subst   = null,
                     emp_tipo_remuner_funcao_subst  = null
              where  emp_numero_matricula = r_subs.oem_emp_numero_matricula;
           --
           --v_count_subs := v_count_subs + 1;
        --
        exception
          when others then
            null;
         end;
     end loop;
     --
   End atualiza_final_cumulativa;

   ------------------------------------------------------------------------------------
   -- Rotina para atualizar na tabela de Empregados, os atributos referentes à
   -- designação de função cumulativa ou substituição de função com data início
   -- das ocorrencias
   --    85 Designação cumulativa de função de confiança
   --    89 Substituição de função de confiança maior 7 dias
   --   220 substituição cumulativa de função de confiança maior 7 dias
   --   217 Designação cumulativa e interina de função de confiança
   -- igual à data do sistema
   ------------------------------------------------------------------------------------
   /*
   Procedure atualiza_inicio_cumulativa is
      v_data_vigencia   date;
      cursor c_fun is
             select oem_emp_numero_matricula,
                    oem_ofu_codigo,
                    oem_fun_codigo,
                    oem_uor_codigo,
                    oem_tipo_remuneracao_funcao
             from   ocorrencias_empregados
             where  oem_ofu_codigo in (85, 89, 220, 217)
             and    oem_data_inicio = p_data_base;
   Begin
      for r_fun in c_fun
      loop
        begin
          select max(qfd_hfd_data_vigencia)
          into   v_data_vigencia
          from   quadros_funcoes_dependencias
          where  qfd_fun_codigo = r_fun.oem_fun_codigo;
        end;
        if r_fun.oem_ofu_codigo in (85, 217) then
           begin
             update cadastros
             set    emp_qfu_fun_codigo_acumula       = r_fun.oem_fun_codigo,
                    emp_qfu_hfl_uor_cod_acum         = r_fun.oem_uor_codigo,
                    emp_qfu_hfl_data_vigen_acum      = v_data_vigencia,
                    emp_tipo_remuner_funcao_acumul   = r_fun.oem_tipo_remuneracao_funcao
             where  emp_numero_matricula   = r_fun.oem_emp_numero_matricula;
           end;
        else
           begin
             update cadastros
             set    emp_qfu_fun_codigo_substitui    = r_fun.oem_fun_codigo,
                    emp_qfu_hfl_uor_cod_subst       = r_fun.oem_uor_codigo,
                    emp_qfu_hfl_data_vigen_subst    = v_data_vigencia,
                    emp_tipo_remuner_funcao_subst   = r_fun.oem_tipo_remuneracao_funcao
             where  emp_numero_matricula   = r_fun.oem_emp_numero_matricula;
           end;
        end if;
      end loop;
   End atualiza_inicio_cumulativa;
   */
   ------------------------------------------------------------------------------------
   -- Rotina para atualizar na tabela de Empregados os atributos referentes às
   -- ocorrências
   --    80 Remoção de uma dependência para outra
   --    81 Remoção de uma unidade  organizacional para outra
   --    82 Transferência definitiva -  intereresse da empresa
   --    83 Transferência provisória -  interesse da empresa
   --    84 Transferência definitiva - interesse  próprio
   --   131 Redução hora extra noturna 100% (120)
   --   132 Redução hora extra noturna 100% (180)
   --   133 Redução hora extra noturna 100% (220)
   -- que estão com data término igual ao dia anterior à data do sistema
   ------------------------------------------------------------------------------------
   /*
   Procedure atualiza_final_transferencia is
      cursor c1 is
         select oem_emp_numero_matricula,
                oem_ofu_codigo
         from ocorrencias_empregados
         where oem_ofu_codigo in (80,81,82,83,84,131,132,133) and
               oem_data_termino = p_data_base - 1;
   Begin
      for c2 in c1 loop
         if c2.oem_ofu_codigo in (80,82,84) then
            begin
               update cadastros
               set    emp_dep_codigo_lotacao = null,
                      emp_dep_codigo_pagto   = null,
                      emp_dep_codigo_fisico  = null,
                      emp_uor_codigo_lotacao = null,
                      emp_qlp_hcl_uor_codigo = null
               where  emp_numero_matricula   = c2.oem_emp_numero_matricula;
            end;
         elsif c2.oem_ofu_codigo = 81 then
            begin
               update cadastros
               set    emp_uor_codigo_lotacao = null,
                      emp_qlp_hcl_uor_codigo = null
               where  emp_numero_matricula   = c2.oem_emp_numero_matricula;
            end;
         elsif c2.oem_ofu_codigo = 83 then
            begin
               update cadastros
               set    emp_dep_codigo_fisico = null
               where  emp_numero_matricula  = c2.oem_emp_numero_matricula;
            end;
         end if;
      end loop;
   End atualiza_final_transferencia;
   */
   ------------------------------------------------------------------------------------
   -- Rotina para atualizar na tabela de Empregados os atributos referentes às
   -- ocorrências
   --    80 Remoção de uma dependência para outra
   --    81 Remoção de uma unidade  organizacional para outra
   --    82 Transferência definitiva -  intereresse da empresa
   --    83 Transferência provisória -  interesse da empresa
   --    84 Transferência definitiva - interesse  próprio
   --   131 Redução hora extra noturna 100% (120)
   --   132 Redução hora extra noturna 100% (180)
   --   133 Redução hora extra noturna 100% (220)
   -- que estão com data data início igual à data do sistema
   ------------------------------------------------------------------------------------
   /*
   Procedure atualiza_inicio_transferencia is
      cursor c1 is
         select oem_emp_numero_matricula,
                oem_ofu_codigo,
                oem_uor_codigo,
                oem_dep_codigo
         from ocorrencias_empregados
         where oem_ofu_codigo in (80,81,82,83,84,131,132,133) and
               oem_data_inicio = p_data_base;
   Begin
      for c2 in c1 loop
         if c2.oem_ofu_codigo in (80,82,84) then
            begin
               update cadastros
               set    emp_dep_codigo_lotacao = c2.oem_dep_codigo,
                      emp_dep_codigo_pagto   = c2.oem_dep_codigo,
                      emp_dep_codigo_fisico  = c2.oem_dep_codigo,
                      emp_uor_codigo_lotacao = c2.oem_uor_codigo,
                      emp_qlp_hcl_uor_codigo = c2.oem_uor_codigo
               where  emp_numero_matricula   = c2.oem_emp_numero_matricula;
            end;
         elsif c2.oem_ofu_codigo = 81 then
            begin
               update cadastros
               set    emp_uor_codigo_lotacao = c2.oem_uor_codigo,
                      emp_qlp_hcl_uor_codigo = c2.oem_uor_codigo
               where  emp_numero_matricula   = c2.oem_emp_numero_matricula;
            end;
         elsif c2.oem_ofu_codigo = 83 then
            begin
               update cadastros
               set    emp_dep_codigo_fisico = c2.oem_dep_codigo
               where  emp_numero_matricula  = c2.oem_emp_numero_matricula;
            end;
         end if;
      end loop;
   End atualiza_inicio_transferencia;
   */
   ------------------------------------------------------------------------------------
   -- Rotina para atualizar na tabela de Empregados os atributos referentes às
   -- ocorrências
   --   135 Cessão de empregado com ônus
   --   136 Cessão de empregado sem ônus
   --   203 Cessão de empregado com ressarcimento
   -- que estão com data término igual ao dia anterior à data do sistema
   ------------------------------------------------------------------------------------
   /*
   Procedure atualiza_final_cessao is
      cursor c1 is
         select oem_emp_numero_matricula
         from   ocorrencias_empregados
         where  oem_ofu_codigo in (135,136,203) and
                oem_data_termino = p_data_base - 1;
   begin
      for c2 in c1 loop
         begin
            update cadastros
            set    emp_uor_codigo_lotacao = null,
                   emp_oex_codigo_cedido  = null,
                   emp_dep_codigo_pagto   = null,
                   emp_dep_codigo_fisico  = null,
                   emp_ati_ct_custos      = null
            where  emp_numero_matricula = c2.oem_emp_numero_matricula;
         end;
      end loop;
   end atualiza_final_cessao;
   */
   ------------------------------------------------------------------------------------
   -- Rotina para atualizar na tabela de Empregados os atributos referentes às
   -- ocorrências
   --   135 Cessão de empregado com ônus
   --   136 Cessão de empregado sem ônus
   --   203 Cessão de empregado com ressarcimento
   -- que estão com data início igual à data do sistema
   ------------------------------------------------------------------------------------
   /*
   Procedure atualiza_inicio_cessao is
      cursor c1 is
         select oem_emp_numero_matricula,
                oem_uor_codigo,
                oem_dep_codigo,
                oem_oex_codigo_cedido,
                oem_cct_codigo
         from ocorrencias_empregados
         where oem_ofu_codigo in(135,136,203) and
               oem_data_inicio = p_data_base;
   Begin
      for c2 in c1 loop
         begin
            update cadastros
            set    emp_uor_codigo_lotacao = c2.oem_uor_codigo,
                   emp_oex_codigo_cedido  = c2.oem_oex_codigo_cedido,
                   emp_dep_codigo_pagto   = c2.oem_dep_codigo,
                   emp_dep_codigo_fisico  = c2.oem_dep_codigo,
                   emp_ati_ct_custos      = c2.oem_cct_codigo
            where  emp_numero_matricula   = c2.oem_emp_numero_matricula;
         end;
      end loop;
   End atualiza_inicio_cessao;
   */
   ------------------------------------------------------------------------------------
   -- Rotina para atualizar na tabela de Empregados os atributos referentes à
   -- ocorrência
   --   212 Opção tipo função de confiança empregado
   -- que estiver com a data de término igual ao dia anterior à data do sistema
   ------------------------------------------------------------------------------------
   /*
   Procedure atualiza_final_func_conf is
      cursor c1 is
         select oem.oem_emp_numero_matricula,
                oem.oem_fun_codigo,
                oem.oem_fun_codigo_acumula
         from ocorrencias_empregados oem
         where oem.oem_ofu_codigo   = 212 and
               oem.oem_data_termino = p_data_base - 1;
   Begin
      for c2 in c1 loop
         begin
            if c2.ofu_fun_codigo is not null then
               update casdastros
               set    emp_tipo_remuneracao_funcao = null
               where  emp_numero_matricula = c2.oem_emp_numero_matricula;
            elsif c2.ofu_fun_codigo_acumula is not null then
               update cadastros
               set    emp_tipo_remuneracao_funcao_acumul = null
               where  emp_numero_matricula = c2.oem_emp_numero_matricula;
            end if;
         end;
      end loop;
   End atualiza_final_func_conf;
   */
   ------------------------------------------------------------------------------------
   -- Rotina para atualizar na tabela de Empregados os atributos referentes à
   -- ocorrência
   --   212 Opção tipo função de confiança empregado
   -- que estiver com a data de início igual à data do sistema
   ------------------------------------------------------------------------------------
   /*
   Procedure atualiza_inicio_func_conf is
      cursor c1 is
         select oem.oem_emp_numero_matricula,
                oem.oem_fun_codigo,
                oem.oem_fun_codigo_acumula
         from ocorrencias_empregados oem
         where oem.oem_ofu_codigo  = 212 and
               oem.oem_data_inicio = p_data_base;
   Begin
      for c2 in c1 loop
         begin
            if c2.ofu_fun_codigo is not null then
               update cadastros
               set    emp_tipo_remuneracao_funcao = c2.oem_fun_codigo
               where  emp_numero_matricula = c2.oem_emp_numero_matricula;
            elsif c2.ofu_fun_codigo_acumula is not null then
               update cadastros
               set    emp_tipo_remuneracao_funcao_acumul = c2.oem_fun_codigo_acumula
               where  emp_numero_matricula = c2.oem_emp_numero_matricula;
            end if;
         end;
      end loop;
   End atualiza_inicio_func_conf;
   */
--______________________ Início do Corpo Principal do Programa ______________________--
BEGIN                                                                                --
   --
   ------------------------------------------------------------------------------------
   -- Faz o insere de inicio do processo na tabela LOG_JOB para controle de rodada do job
   BEGIN
     --
     INSERT INTO LOG_JOB
           (
           LJ_NOM_PROCESSO,
           LJ_DAT_INICIO_PROCESSO,
           LJ_DAT_TERMINO_PROCESSO
           )
        VALUES
           (
           v_nome_processo,
           v_data_inicio,
           null
           );
     --
     COMMIT;
     --
   END;
   --
   ------------------------------------------------------------------------------------
   -- Ficou estabelecido que todo dia 1° de cada mês                                 --
   -- será tomado como base para atualização dos                                     --
   -- percentuais de anuênios e/ou suas inclusões                                    --
   --                                                                                --
   IF TO_CHAR(p_data_base, 'DD') = '01' THEN                                         --
      FOR r_emp IN c_emp LOOP
       BEGIN
         -- Só os empregados de Situação Funcional 1 (Do Quadro) que podem ter anuenios
         IF r_emp.emp_sfu_codigo = 1 THEN                                                          --
           v_ct := v_ct + 1;                                                           --
           --                                                                          --
           BUSCA_TEMPO_SERVICO_ANUENIO ( r_emp.emp_numero_matricula,                   --
                                         r_emp.emp_data_admissao,                      --
                                         v_data_ultimo_anuenio,                        --
                                         anos_tempo_servico,                           --
                                         dias_tempo_servico,                           --
                                         dias_afastamento);                            --
                                                                                       --
--         IF to_char((v_data_ultimo_anuenio + dias_tempo_servico +                    --
--            (dias_afastamento * 2)),'mmyyyy') = to_char(p_data_base,'mmyyyy') THEN   --
/*  Alterado em 29/10/2004 */
           IF to_char((add_months(v_data_ultimo_anuenio,12) +                          --
              dias_afastamento),'mmyyyy') = to_char(p_data_base,'mmyyyy') THEN   --
/* Fim alteração 29/10/2004*/
                                                                                     --
              -- Atualiza a ocorrência                                                 --
                                                                                       --
              ATUALIZA_PERCENTUAIS_ANUENIOS( r_emp.emp_numero_matricula,               --
                                             r_emp.emp_data_admissao,                  --
                                             dias_afastamento,                         --
                                             anos_tempo_servico,                       --
                                             dias_tempo_servico,                       --
                                             v_percentual,                             --
                                             V_DATA_ULTIMO_ANUENIO);                   --
              --                                                                       --
              -- Insere a ocorrência 73 (Adicional por tempo de serviço)               --
              INSERE_ANUENIO( r_emp.emp_numero_matricula,                              --
                              V_DATA_ULTIMO_ANUENIO,                                   --
                              dias_afastamento,                                        --
                              dias_tempo_servico,                                      --
                              v_percentual,                                            --
                              V_DATA_ULTIMO_ANUENIO,                                   --
                              anos_tempo_servico);                                     --
              --                                                                       --
           END IF;                                                                     --
           --                                                                          --
           -- Insere ou altera na tabela hst_dependencia_empregado                     --
           --                                                                          --
           INSERE_DEPENDENCIA_EMPREGADO(r_emp.emp_numero_matricula,                    --
                                        r_emp.emp_dep_codigo_lotacao);                 --
           --                                                                            --
           IF v_ct = 500 THEN                                                          --
              --                                                                       --
              COMMIT;                                                                  --
              v_ct := 0;                                                               --
              --                                                                       --
           END IF;                                                                     --
           --
         END IF;
       EXCEPTION
         WHEN OTHERS THEN
           dbms_output.put_line(SQLERRM||' - Matricula:'||to_char(r_emp.emp_numero_matricula));
       END;
       --                                                                                  --
      END LOOP;                                                                      --
      --                                                                             --
      COMMIT;                                                                        --
      --                                                                             --
   END IF;                                                                           --
   ------------------------------------------------------------------------------------
   ------------------------------------------------------------------------------------
   -- Ficou estabelecido que todo dia 5 de cada mês                                  --
   -- será tomado como base para atualização dos                                     --
   -- adicionais de 13º salário e férias                                             --
   --                                                                                --
   IF TO_CHAR(p_data_base, 'DD') = '05' THEN                                         --
      --                                                                             --
      Atualiza_Adicional_13_Ferias(TO_NUMBER(TO_CHAR(SYSDATE, 'YYYY')),              --
                                   TO_NUMBER(TO_CHAR(SYSDATE, 'MM')),                --
                                   TO_NUMBER(TO_CHAR(SYSDATE, 'YYYY')),              --
                                   TO_NUMBER(TO_CHAR(SYSDATE, 'MM')), 1);            --
      --                                                                             --
   END IF;                                                                           --
   ------------------------------------------------------------------------------------
   --
   -- Rotinas Diarias
   -- if p_insere_anuenio <> null then
   /* corrigido 06/01/2003 */
   if p_insere_anuenio is not null then
   /* fim  corrigido 06/01/2003 */
      FOR r_emp IN c_emp LOOP
         --
         -- Insere ou altera na tabela hst_dependencia_empregado qdo a procedure é chamada
         -- pelo programa de calculo do efetivo Infraero
         --
         INSERE_DEPENDENCIA_EMPREGADO(r_emp.emp_numero_matricula,
                                      r_emp.emp_dep_codigo_lotacao);
         --
         v_folha := verifica_folha_atual;
         ATUALIZA_ORDEM_CALCULO (to_number(to_char(v_folha,'mm')), to_number(to_char(v_folha,'yyyy')));
         ATUALIZA_SEQUENCIA_RUB (to_number(to_char(v_folha,'mm')), to_number(to_char(v_folha,'yyyy')),1);
         --
         IF v_ct = 500 THEN
            --
            COMMIT;
            v_ct := 0;
            --
         END IF;
         --
         COMMIT;
         --
      END LOOP;
   end if;

   ATUALIZA_STATUS_EMPREGADO;
   COMMIT;
   /* AGREGADO 26/03/2003 */
   ATUALIZA_DEPENDENTES;
   COMMIT;
   /* FIM AGREGADO 26/03/2003 */
   /* AGREGADO 23/07/2003 */
   -- Realiza atualizações nas rubricas da tabela de movimentacao.
   TRATA_AFASTAMENTOS(NULL); -- como envio nulo faz para todas as matriculas
   COMMIT;
   /* FIM AGREGADO 23/07/2003 */
   /* AGREGADO 25/03/2003 */
   -- Atualiza as funções quando devem começar ou terminat na data atual(SYSDATE)
   ATUALIZA_FUNCAO;
   COMMIT;
   /* FIM AGREGADO 25/03/2003 */
   ATUALIZA_FINAL_CUMULATIVA;
   COMMIT;
   --
   /* AGREGADO 05/12/2003 */
   RETORNO_TRANSF_PROVISORIA;
   COMMIT;
   /* FIM AGREGADO 05/12/2003 */

   /* AGREGADO 10/03/2004 */
   ATUALIZA_DEPENDENCIA_USUARIO;
   COMMIT;
   /* FIM AGREGADO 10/03/2004 */

   /* Agregado em 29/04/2004 */
   -- Para manter atualizadas as atividades empregados
   BEGIN
     APAGA_ATIV_EMP_ALTERADAS;
     COMMIT;
     INS_ATIV_EMP_PRI_SUB;
     COMMIT;
     INS_ATIV_EMP_ACUM;
     COMMIT;
     --
   EXCEPTION
     WHEN OTHERS THEN
       NULL;
   END;

   /* FIM AGREGADO 29/04/2004 */

   /* AGREGADO 15/06/2004 */
   ATUALIZA_CENTRO_CUSTO;
   COMMIT;
   /* FIM AGREGADO 15/06/2004 */

   /* ACRESCENTADO EM 29/07/2004 */
   -- Procedure para enviar Contratos (Interface SSContratos X Benefícios) para tabelas de Integração
   TRATA_DOC_COBRANCA_SEM_SP (NULL);
   /* FIM ACRESCENTADO EM 29/07/2004 */



   /*
   ATUALIZA_FINAL_FUNCAO;
   ATUALIZA_INICIO_FUNCAO;
   ATUALIZA_FINAL_CUMULATIVA;
   ATUALIZA_INICIO_CUMULATIVA;
   ATUALINA_FINAL_TRANSFERENCIA;
   ATUALIZA_INICIO_TRANSFERENCIA;
   ATUALIZA_FINAL_CESSAO;
   ATUALIZA_INICIO_CESSAO;
   ATUALIZA_FINAL_FUNC_CONF;
   ATUALIZA_INICIO_FUNC_CONF;
   */
   --
   -- Faz o update na tabela de controle de job (LOG_JOB) para encerrar a data de termino do processo
   BEGIN
     UPDATE LOG_JOB
        SET LJ_DAT_TERMINO_PROCESSO = sysdate
      WHERE LJ_NOM_PROCESSO = v_nome_processo
        AND LJ_DAT_INICIO_PROCESSO = v_data_inicio
        AND LJ_DAT_TERMINO_PROCESSO IS NULL;
     --
     COMMIT;
     --
   END;
   --
END SRH_CAD_PROCEDIMENTOS_DIARIOS;
/




