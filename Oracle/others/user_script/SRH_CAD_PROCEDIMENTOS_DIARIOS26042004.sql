


DROP PROCEDURE srh_cad_procedimentos_diarios
/


CREATE OR REPLACE
PROCEDURE        SRH_CAD_PROCEDIMENTOS_DIARIOS( p_emp_numero_matricula NUMBER DEFAULT NULL,
                                         p_data_base            DATE   DEFAULT SYSDATE,
                                         p_insere_anuenio       NUMBER DEFAULT NULL) IS
   --
   ------------------------------------------------------------------------------------
   --                           SRH_CAD_PROCEDIMENTOS_DIARIOS                        --
   --                           --- --- ------------- -------                        --
   --                                                                                --
   --     Procedure que rodar� todos os dias mantendo a tabela de cadastros sincro-  --
   -- nizada com as ocorr�ncias atuais do empregado. Todo 1� dia do m�s, esta mesma  --
   -- rotina verificar� a necessidade de inclus�o ou altera��o das ocorr�ncias 216 e --
   -- 73 (relativas aos anu�nios dos empregados), e se necess�rio as realizar�.      --
   --                                                                                --
   -- Criada por: Edmundo J�nior                                                     --
   --             Luiz Fernando Bastos Coura                                         --
   --             Selson Coatio                                                      --
   -- Data da Cria��o: 13/06/2001                                                    --
   --                                                                                --
   -- Alterada por: Luiz Fernando Bastos Coura                                       --
   -- Data da �ltima altera��o: 05/04/2004                                           --
   --                                                                                --
   -- Obs.: Em 11/07/2001 a procedure foi alterada para come�ar a gravar definitiva- --
   -- mente os dados de anu�nio e hst_dependencia_empregado.                         --
   -- Em 13/12/2001 esta vers�o foi alterada para n�o utilizar dados da tabela de    --
   -- averba��o conforme defini��o da Quedima j� que os dados desta tabela est�o     --
   -- inconsistentes. Caso for necess�rio de se retornar ao antigo modo de tratamento--
   -- de anu�nio utilizando as averba��es, existe uma vers�o j� pronta no diret�rio  --
   -- c\junior\job\job_anuenio.sql da m�quina do Junior                              --
   --                                                                                --
   ------------------------------------------------------------------------------------
   --
   -- Declara��o das vari�veis globais
   anos_tempo_servico       NUMBER      := 0;
   dias_tempo_servico       NUMBER      := 0;
   dias_afastamento         NUMBER(4)   := 0;
   v_ct                     NUMBER(4)   := 0;
   v_percentual             NUMBER(4,2) := 0;
   v_data_ultimo_anuenio    DATE;
   v_folha                  date;
   --
   -- Declara��o das procedures internas ao programa
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
   PROCEDURE ATUALIZA_ATIV_EMPREGADOS;

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
   -- seleciona todos empregados que est�o ativos
   ------------------------------------------------------------------------------------
   CURSOR c_emp IS
      SELECT emp_numero_matricula,
             emp_data_admissao,
             emp_dep_codigo_lotacao
      FROM   cadastros
      WHERE  emp_status != 2
      and   (   (p_emp_numero_matricula is null)
             or (emp_numero_matricula = p_emp_numero_matricula));
   --
   ------------------------------------------------------------------------------------
   -- Rotina que apura o tempo de servi�o do empregado
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
      -- busca a data in�cio da �ltima ocorr�ncia 73 do empregado
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
            dbms_output.put_line('N�o existe ocorr�ncia de ingresso para a matricula = '||to_char(p_emp_numero_matricula));
         end;
      end;
      --
      -- Alimenta a vari�vel com a data do pr�ximo anu�nio do empregado
      v_data_anuenio := TO_DATE( TO_CHAR(v_data_ini_ultimo_anuenio,'DD/MM')|| '/' ||
                                 TO_CHAR(p_data_base,'YYYY'),'DD/MM/YYYY');
      --
      -- Busca o total de dias de afastamento do empregado
      begin
         SELECT SUM( (NVL(oem_data_termino, v_data_anuenio) + 1) - oem_data_inicio)
         into p_total_dias_afastamento
         FROM   ocorrencias_empregados
         WHERE oem_emp_numero_matricula = p_emp_numero_matricula and
               oem_data_inicio >= v_data_ini_ultimo_anuenio      and
               oem_ofu_codigo in
               (SELECT ofu_codigo
                FROM   tipos_ocorrencias             ----------------------------------
                WHERE  --ofu_indicador_tipo IN (2, 13) -->  2 - Afastamento Tempor�rio --
                -- AND                                 --> 13 - Absente�smo            --
                ofu_indicador_anuenio = 'S'
                );
         --                                             ----------------------------------

         if p_total_dias_afastamento is null then
            p_total_dias_afastamento := 0;
         end if;
      end;
      --
      -- Realiza os calculos e alimenta as vari�veis que ser�o retornadas com valor
      v_tempo_servico_corrido := (v_data_anuenio - v_data_ini_ultimo_anuenio);
      p_tempo_servico_dias    := v_tempo_servico_corrido - NVL( p_total_dias_afastamento,  0 );
      p_tempo_servico_anos    := TO_CHAR( TRUNC( ((v_total_anuenio * 365) + (v_tempo_servico_corrido)) /365 ) );
      p_data_ultimo_anuenio   := v_data_ini_ultimo_anuenio;
      --
   END BUSCA_TEMPO_SERVICO_ANUENIO;
   --
   ---------------------------------------------------------------------------------
   -- Rotina que atualiza os percentuais de anu�nios
   -- ------ --- -------- -- ----------- -- --------
   -- Primeiro calcula-se o tempo de servi�o em anos para a partir da� conseguir se
   -- pegar o percentual de anu�nio contido na tabela "Anuenios" e atualizar esse
   -- percentual na tabela de "Ocorrencias_Empregados" (Atualiza a ocorr�ncia "216 -
   -- Quantidade de Anu�nios" com o campo oem_mov_parametro = "percentual calculado").
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
            ,oem_valor                 = p_anos_tempo_servico -- Quantidade de anu�nios
            ,oem_data_termino          = (p_data_ultimo_anuenio + p_dias_tempo_servico + (p_total_dias_afastamento * 2))
            ,oem_diploma_legal_termino = 'OCORR�NCIA GERADA AUTOMATICAMENTE (ROTINA DI�RIA).'
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
                  216, -- Quantidade de anu�nios
                  p_data_base,
                  p_data_ultimo_anuenio,
                 (p_data_ultimo_anuenio + p_dias_tempo_servico + (p_total_dias_afastamento * 2)),
                  p_anos_tempo_servico,
                  v_percentual,
                  'OCORR�NCIA GERADA AUTOMATICAMENTE (ROTINA DI�RIA).',
                  'OCORR�NCIA GERADA AUTOMATICAMENTE (ROTINA DI�RIA).' );
      END IF;
      --
      EXCEPTION
      when dup_val_on_index then
      begin
         update ocorrencias_empregados
         set oem_data_termino  = (p_data_ultimo_anuenio + p_dias_tempo_servico + (p_total_dias_afastamento * 2)),
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
   -- Rotina que busca o percentual do anu�nio do empregado
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
      IF p_anos_tempo_servico >= 23 THEN -- Se o empregado tiver mais de 23 anos de servi�o
         --
         -- Seleciona o maior percentual encontrado na tabela de "anuenios"
         OPEN  c_per_max;
         FETCH c_per_max INTO v_percentual;
         --
         CLOSE c_per_max;
         --
         IF v_percentual = 0 THEN
            DBMS_OUTPUT.PUT_LINE( 'N�o existe nenhum percentual 2 de anu�nio cadastrado !' );
         END IF;
         --
      ELSE -- Se o empregado tiver menos do que 23 anos de servi�o
         --
         IF p_emp_data_admissao <= TO_DATE('30041995','DDMMYYYY') THEN -- Se o empregado foi
            --                                                  admitido antes de 30/04/1995
            -- Seleciona o percentual_1 relacionado ao tempo de servi�o passado como par�metro
            OPEN c_per_1( p_anos_tempo_servico );
            FETCH c_per_1 INTO v_percentual;
            --
            IF c_per_1%NOTFOUND THEN
               v_percentual := 0;
               DBMS_OUTPUT.PUT_LINE( 'N�o existe percentual 1 de anu�nio para tempo de ' ||
                                     'servi�o igual a : ' || to_char(p_anos_tempo_servico) || ' ano(s) !');
            END IF;
            --
            CLOSE c_per_1;
            --
         ELSE -- Se o empregado foi admitido depois de 30/04/1995
            --
            -- Seleciona o percentual_2 relacionado ao tempo de servi�o passado como par�metro
            OPEN  c_per_2( p_anos_tempo_servico );
            FETCH c_per_2 INTO v_percentual;
            --
            IF c_per_2%NOTFOUND THEN
               v_percentual := 0;
               DBMS_OUTPUT.PUT_LINE( 'N�o existe percentual 2 de anu�nio para tempo de ' ||
                                     'servi�o igual a : ' || to_char(p_anos_tempo_servico) || ' ano(s) !');
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
   -- Rotina que insere o anu�nio
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
                     73, -- Adicional por tempo de servi�o
                     p_data_base,
                     (p_data_ultimo_anuenio + p_tempo_servico + (p_dias_afastamento * 2)),
                     (p_data_ultimo_anuenio + p_tempo_servico + (p_dias_afastamento * 2)),
                     'OCORR�NCIA GERADA AUTOMATICAMENTE (ROTINA DI�RIA).',
                     'OCORR�NCIA GERADA AUTOMATICAMENTE (ROTINA DI�RIA).' ,
                     p_percentual,
                     p_anos_tempo_servico);

      exception
      when dup_val_on_index then
      begin
         update ocorrencias_empregados
         set oem_data_termino = (p_data_ultimo_anuenio + p_tempo_servico + (p_dias_afastamento * 2))
         where oem_emp_numero_matricula = p_emp_numero_matricula and
               oem_data_inicio          = (p_emp_data_admissao + p_tempo_servico + (p_dias_afastamento * 2)) and
               oem_ofu_codigo           = 73;
      end;
      --
   END INSERE_ANUENIO;
   --
   ------------------------------------------------------------------------------------
   -- Rotina que atualiza a tabela hst_dependencia_empregado
   -- Que � utilizada no c�lculo da Freq��ncia por afastamento de Absenteismo
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
           AND pvi_data_baixa_ir IS NULL
           AND pvi_indicador_imposto_de_renda = 'S';
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
         AND pvi_data_baixa_ir IS NULL
         AND pvi_indicador_imposto_de_renda = 'S';
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
   -- ativo     - quando possuir data t�rmino do dia anterior ao do sistema,
   -- afastado  - quando possuir data in�cio igual � data do sistema
   -- desligado - quando possuir ocorr�ncia do grupo 10 - Desligamento com data de in�cio igual a
   --             maior data de in�cio de ocorr�ncias do empregado
   -- para as seguintes ocorrencias:
  -- Cod     Descri��o                                             Grupo
  --  13  -  PROMOCAO DE CAMPANHA ELEITORAL                     	2
  --  14  -  ANTECIPA�AO DA LICEN�A GESTANTE                    	13
  --  15  -  AUXILIO DOENCA ACIDENTARIO (INSS)                  	13
  --  16  -  AUX�LIO DOEN�A (INSS) SEM CAR�NCIA                 	13
  --  17  -  AUXILIO DOENCA OCUPACIONAL (INSS)                  	13
  --  18  -  CONTRATO SUSPENSO (SUB-J�DICE)                     	2
  --  21  -  LICENCA GESTANTE                                   	13
  --  22  -  LICENCA MATERNIDADE  (ADO��O)                      	13
  --  23  -  LICEN�A M�DICA INTEGRAL DOEN�A N�O OCUPACIONAL        	13
  --  24  -  LICEN�A M�DICA INTEGRAL DOEN�A OCUPACIONAL         	13
  --  25  -  LICENCA M�DICA ACIDENT�RIA                         	13
  --  26  -  MANDATO ELETIVO SEM �NUS - LEI ELEITORAL              	2
  --  28  -  PRISAO                                             	2
  --  29  -  PRISAO TEMPOR�RIA                                  	2
  --  30  -  PRORROGACAO DA LICENCA GESTANTE                    	13
  --  31  -  SERVICO MILITAR OBRIGATORIO                        	2
  --  32  -  SUSPENSAO DISCIPLINAR                              	2
  --  75  -  LICEN�A- PR�MIO                                    	4
  --  79  -  CONTRATO SUSPENSO                                  	2
  --  124 -  ABORTO                                             	13
  --  127 -  AUX�LIO DOEN�A (INSS)                              	13
  --  139 -  REDU��O ADICIONAL NOTURNO (220)                    	3
  --  143 -  AUS�NCIA POR MOTIVO DE DOEN�A - DET. APOSENTADORIA	    13
  --  144 -  AUS�NCIA MOTIVO DOEN�A ACIDENT DET APOSENTADORIA	    13
  --  178 -  MANDATO ELETIVO COM �NUS - LEI ELEITORAL           	2
  --  224 -  LICEN�A M�DICA MATUTINA N�O OCUPACIONAL            	13
  --  225 -  LICEN�A M�DICA MATUTINA OCUPACIONAL                	13
  --  226 -  LICEN�A M�DICA MATUTINA ACIDENT�RIA                	13
  --  227 -  LICEN�A M�DICA VESPERTINA N�O OCUPACIONAL          	13
  --  228 -  LICEN�A M�DICA VESPERTINA OCUPACIONAL                 	13
  --  229 -  LICEN�A M�DICA VESPERTINA ACIDENT�RIA              	13
  --  230 -  LICEN�A M�DICA NOTURNA N�O OCUPACIONAL             	13
  --  231 -  LICEN�A M�DICA NOTURNA OCUPACIONAL                 	13
  --  232 -  LICEN�A M�DICA NOTURNA ACIDENT�RIA                 	13
  --  Grupo 10 - Todas                                              10
  ------------------------------------------------------------------------------------
  --
   Procedure atualiza_status_empregado is
     --
     -- cursor que recupera empregados de status afastado e que n�o possuem afastamento
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


     -- cursor que recupera empregados de status ativo e que possuem ocorr�ncias de desligamento
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
     -- Esta fun��o tem dois cursores.
     -- c_ini e para carregar na tabela de cadastro a fun��o dos empregados que comen�am
     -- a ter fun��o o dia de hoje.
     -- c_fim e para apagar na tabela de cadastro a fun��o dos empregados que deixam de
     -- ter fun��o o dia de hoje e fechar a ocorrencia 212 ou 255 correspondente.
     --
     -- Cursor que recupera as funcoes que em SYSDATE come�am e tem quer ser atualizadas
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
           and oem_data_inicio = trunc(sysdate);


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
        and oem_data_termino = trunc(sysdate);
   --
   v_data_vigencia DATE;
   --
   Begin
     for r_ini in c_ini_fun
       --
       loop
         begin
           -- Pego a data de vigencia da fun��o
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
       -- com data de retorno em SYSDATE - 1 (quer dizer que em SYSDATE j� acabou a transferencia
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
                                  'TRANSFERENCIA PROVIS�RIA O PRORROGA DA MESMA';
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
   --------------------------
   --------------------------
   -- O procedimento atualiza os dados das atividades empregados de acordo com as altera��es
   -- de ocorrencias de func�o. Para o mesmo existe uma trigger na tabela de ocorrencias_empregados
   -- que insere registros em uma tabela chamada CTRL_FUN_ATIVIDADES_EMPREGADOS toda vez que
   -- se faz um insert, delete or update dos atributos oem_data_termino, oem_data_inicio,
   -- oem_fun_codigo, oem_fun_codigo_acumula o oem_fun_codigo_substitui com as ocorrencias de
   -- fun��o (86,88,93,125,238,240,256,85,217,89,220).
   PROCEDURE ATUALIZA_ATIV_EMPREGADOS IS
        CURSOR CUR_FUN IS
           SELECT
                  CFA_EMP_NUMERO_MATRICULA MATRICULA,
                  CFA_OFU_CODIGO OFU_CODIGO,
                  CFA_OLD_DATA_INICIO OLD_DT_INICIO,
                  CFA_NEW_DATA_INICIO NEW_DT_INICIO,
                  CFA_OLD_DATA_TERMINO OLD_DT_TERMINO,
                  CFA_NEW_DATA_TERMINO NEW_DT_TERMINO,
                  OEM_DIPLOMA_LEGAL DOC_INICIO,
                  OEM_DIPLOMA_LEGAL_TERMINO DOC_TERMINO,
                  CFA_OLD_FUN_CODIGO OLD_FUN_CODIGO,
                  CFA_NEW_FUN_CODIGO NEW_FUN_CODIGO,
                  CFA_DTA_OPERACAO DTA_OPERACAO,
                  CFA_TIP_OPERACAO TIP_OPERACAO,
                  CFA_COD_USUARIO COD_USUARIO,
                  CFA_SEQUENCIAL SEQUENCIAL,
                  NVL(CFA_FLAG_EXECUTO,'N') FLAG_EXECUTO
             FROM CTRL_FUN_ATIVIDADES_EMPREGADOS,
                  OCORRENCIAS_EMPREGADOS
            WHERE CFA_OFU_CODIGO = OEM_OFU_CODIGO(+)
              AND CFA_NEW_DATA_INICIO = OEM_DATA_INICIO(+)
              AND CFA_EMP_NUMERO_MATRICULA = OEM_EMP_NUMERO_MATRICULA(+)
              AND TRUNC(CFA_DTA_OPERACAO) <= (TRUNC(SYSDATE) - 1)
              AND NVL(CFA_FLAG_EXECUTO,'N') = 'N'
           ORDER BY CFA_EMP_NUMERO_MATRICULA,CFA_SEQUENCIAL;
           --
        C_FUN CUR_FUN%ROWTYPE;
        --
        CURSOR C_FUN_ATI IS
          SELECT FUN_CODIGO,
                 ATF_ATI_CODIGO ATI_CODIGO
            FROM FUNCOES,
                 ATIVIDADES_FUNCOES
           WHERE FUN_CODIGO = ATF_FUN_CODIGO
             AND FUN_CODIGO = C_FUN.NEW_FUN_CODIGO
          ORDER BY FUN_CODIGO, ATF_ATI_CODIGO;
        --

        C_ATI C_FUN_ATI%ROWTYPE;
        --
        CURSOR CUR_EXISTE IS
          SELECT 'S' SIM
            FROM OCORRENCIAS_EMPREGADOS
           WHERE OEM_FUN_CODIGO = C_FUN.NEW_FUN_CODIGO
             AND OEM_OFU_CODIGO IN (86,88,93,125,238,240,256) -- PRINCIPAL
             AND OEM_DATA_TERMINO IS NULL
             AND OEM_EMP_NUMERO_MATRICULA = C_FUN.MATRICULA

          UNION

          SELECT 'S' SIM
            FROM OCORRENCIAS_EMPREGADOS
           WHERE OEM_FUN_CODIGO_ACUMULA = C_FUN.NEW_FUN_CODIGO
             AND OEM_OFU_CODIGO IN (85,217) -- ACUMULA
             AND OEM_DATA_TERMINO IS NULL
             AND OEM_EMP_NUMERO_MATRICULA = C_FUN.MATRICULA

          UNION

          SELECT 'S' SIM
            FROM OCORRENCIAS_EMPREGADOS
           WHERE OEM_FUN_CODIGO_SUBSTITUI = C_FUN.NEW_FUN_CODIGO
             AND OEM_OFU_CODIGO IN (89,220)   -- SUBSTITUI
             AND OEM_DATA_TERMINO IS NULL
             AND OEM_EMP_NUMERO_MATRICULA = C_FUN.MATRICULA;
        --
        C_EXISTE CUR_EXISTE%ROWTYPE;
        --
        v_matricula  CADASTROS.emp_numero_matricula%TYPE;
        v_dt_ini     DATE;
        v_dt_ter     DATE;
        v_doc_ini    OCORRENCIAS_EMPREGADOS.OEM_DIPLOMA_LEGAL%TYPE;
        v_doc_ter    OCORRENCIAS_EMPREGADOS.OEM_DIPLOMA_LEGAL_TERMINO%TYPE;
        v_fun_codigo CARGOS_CONFIANCA.FUN_CODIGO%TYPE;
        --
        v_existe			VARCHAR2(1);
        v_existe_oco  VARCHAR2(1);
        --
        v_erro_oracle VARCHAR2(200);
        --
        v_alteradas NUMBER := 0;
        v_erroneas NUMBER := 0;
        --

      BEGIN
        --
        OPEN CUR_FUN;
        --
        LOOP
          BEGIN
            --
            FETCH CUR_FUN INTO C_FUN;
            EXIT WHEN CUR_FUN%NOTFOUND;
            --
            IF C_FUN.TIP_OPERACAO = 'I' THEN -- Opera��o � 'I' (Insert)
              BEGIN
                --
                BEGIN  -- Procuro em atividades empregados o registro
                  SELECT 'S'
                    INTO v_existe
                    FROM ATIVIDADES_EMPREGADOS
                   WHERE AEM_IND_ATI_FUN_CAR = 'F'
                     AND AEM_DATA_TERMINO = (C_FUN.NEW_DT_INICIO - 1) -- Fechada um dia antes
                     AND AEM_FUN_CODIGO = C_FUN.NEW_FUN_CODIGO -- as funcoes devem ser iguais
                     AND AEM_EMP_NUMERO_MATRICULA = C_FUN.MATRICULA
                   GROUP BY 1;
                  --
                EXCEPTION
                  WHEN NO_DATA_FOUND THEN -- Como n�o achou registro devo inserir um novo
                    v_existe := 'N';
                  WHEN OTHERS THEN
                    v_erroneas := v_erroneas + 1;
                    INSERT INTO ERRO_ATUALIZA_ATIV_EMP
                            (
                            ERRO_CFA_SEQUENCIAL,
                            ERRO_CFA_TIP_OPERACAO,
                            ERRO_DESCRICAO
                            )
                       values
                            (
                             C_FUN.SEQUENCIAL,
                             C_FUN.TIP_OPERACAO, -- ERRO_CFA_TIP_OPERACAO
                             'Mat Erro(I) select v_existe:'||to_char(C_FUN.MATRICULA)||'-'||
                                         to_char(C_FUN.NEW_DT_INICIO) -- ERRO_DESCRICAO
                            );
                  --
                END; -- Do select ATIVIDADES_EMPREGADOS
                --
                IF v_existe = 'S' THEN
                  BEGIN -- Como existem datas contiguas devo abrir as atividades
                    UPDATE ATIVIDADES_EMPREGADOS
                       SET AEM_DATA_TERMINO = NULL,
                           AEM_DOCUMENTO_TERMINO = NULL
                     WHERE AEM_IND_ATI_FUN_CAR = 'F'
                       AND AEM_DATA_TERMINO = (C_FUN.NEW_DT_INICIO - 1) -- Fechada um dia antes
                       AND AEM_FUN_CODIGO = C_FUN.NEW_FUN_CODIGO -- as funcoes devem ser iguais
                       AND AEM_EMP_NUMERO_MATRICULA = C_FUN.MATRICULA;
                    --
                    --
                    EXCEPTION
                      WHEN OTHERS THEN
                        v_erroneas := v_erroneas + 1;
                        INSERT INTO ERRO_ATUALIZA_ATIV_EMP
                                (
                                ERRO_CFA_SEQUENCIAL,
                                ERRO_CFA_TIP_OPERACAO,
                                ERRO_DESCRICAO
                                )
                           values
                                (
                                 C_FUN.SEQUENCIAL,
                                 C_FUN.TIP_OPERACAO, -- ERRO_CFA_TIP_OPERACAO
                                 'Mat Erro(I) UPDATE ativ_emp:'||to_char(C_FUN.MATRICULA)||'-'||
                                             to_char(C_FUN.NEW_DT_INICIO) -- ERRO_DESCRICAO
                                );
                  --
                  END;
                ELSE -- v_existe = 'N'
                  -- Como n�o existem datas contiguas devo inserir os novas atividades
                  BEGIN
                    OPEN C_FUN_ATI;
                    --
                    LOOP
                      BEGIN
                        FETCH C_FUN_ATI INTO C_ATI;
                        EXIT WHEN C_FUN_ATI%NOTFOUND;
                        -- fa�o o insert
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
                                  C_FUN.MATRICULA,
                                  C_FUN.NEW_DT_INICIO,
                                  C_FUN.NEW_DT_TERMINO,
                                  C_FUN.DOC_INICIO,
                                  C_FUN.DOC_TERMINO,
                                  NULL, -- AEM_IND_ATI_INERENTE,
                                  'F',  -- FUNCAO, � FIXA
                                  NULL, -- AEM_IND_ATI_INERENTE,
                                  NULL, -- AEM_DATA_CONFIRMA_NAO_INERENTE,
                                  NULL,  -- AEM_ID_USUARIO_CONFIRMACAO,
                                  C_FUN.NEW_FUN_CODIGO
                                );
                      --
                  ---- ******************************************************************
                  -- So para verificar se est� funcionando logo tirar 
                  INSERT INTO ERRO_ATUALIZA_ATIV_EMP
                            (
                            ERRO_CFA_SEQUENCIAL,
                            ERRO_CFA_TIP_OPERACAO,
                            ERRO_DESCRICAO
                            )
                       values
                            (
                             C_FUN.SEQUENCIAL,
                             C_FUN.TIP_OPERACAO, -- ERRO_CFA_TIP_OPERACAO
                             'Isso n�o e erro(I), � so para ver si funciona:'||to_char(C_FUN.MATRICULA)||'-'||
                                         to_char(C_FUN.NEW_DT_INICIO) -- ERRO_DESCRICAO
                            );                  
                  -- 
                  ------- ************************************************************                      
                      --                      
                      EXCEPTION
                        WHEN OTHERS THEN
                          v_erroneas := v_erroneas + 1;
                          INSERT INTO ERRO_ATUALIZA_ATIV_EMP
                                  (
                                  ERRO_CFA_SEQUENCIAL,
                                  ERRO_CFA_TIP_OPERACAO,
                                  ERRO_DESCRICAO
                                  )
                             values
                                  (
                                   C_FUN.SEQUENCIAL,
                                   C_FUN.TIP_OPERACAO, -- ERRO_CFA_TIP_OPERACAO
                                   'Mat Erro(I) INSERT ativ_emp:'||
                                                to_char(C_FUN.MATRICULA)||'-'||
                                                to_char(C_FUN.NEW_DT_INICIO) -- ERRO_DESCRICAO
                                  );
                      --
                      END;
                    END LOOP;
                    CLOSE C_FUN_ATI;
                    --
                    --
                  END; -- Do Begin Insere ATIVIDADES_EMPREGADOS
                END IF; -- IF v_existe = 'S' para update o insere das atividades_empregados
                --
              EXCEPTION
                WHEN OTHERS THEN
                  v_erroneas := v_erroneas + 1;
                  v_erro_oracle :=SUBSTR(SQLERRM,1,200);
                  INSERT INTO ERRO_ATUALIZA_ATIV_EMP
                          (
                          ERRO_CFA_SEQUENCIAL,
                          ERRO_CFA_TIP_OPERACAO,
                          ERRO_DESCRICAO
                          )
                     values
                          (
                           C_FUN.SEQUENCIAL,
                           C_FUN.TIP_OPERACAO, -- ERRO_CFA_TIP_OPERACAO
                           'Mat Erro Oracle(I):'||v_erro_oracle||'-'||
                                           to_char(C_FUN.MATRICULA)||'-'||
                                           to_char(C_FUN.NEW_DT_INICIO) -- ERRO_DESCRICAO
                          );
                  --
              END; -- Do Begin IF C_FUN.TIP_OPERACAO = 'I'
              --
            ELSIF C_FUN.TIP_OPERACAO = 'D' THEN -- Opera��o � 'D' (Delete)
              BEGIN
                --
                DELETE FROM ATIVIDADES_EMPREGADOS
                 WHERE AEM_DATA_INICIO = C_FUN.OLD_DT_INICIO
                   AND AEM_FUN_CODIGO =  C_FUN.OLD_FUN_CODIGO
                   AND AEM_EMP_NUMERO_MATRICULA = C_FUN.MATRICULA;
                --
              EXCEPTION
                WHEN OTHERS THEN
                  v_erroneas := v_erroneas + 1;
                  --
                  v_erro_oracle :=SUBSTR(SQLERRM,1,200);
                  --
                  INSERT INTO ERRO_ATUALIZA_ATIV_EMP
                          (
                          ERRO_CFA_SEQUENCIAL,
                          ERRO_CFA_TIP_OPERACAO,
                          ERRO_DESCRICAO
                          )
                     values
                          (
                           C_FUN.SEQUENCIAL,
                           C_FUN.TIP_OPERACAO, -- ERRO_CFA_TIP_OPERACAO
                           'Mat Erro(D):'||v_erro_oracle||'-'||
                                       to_char(C_FUN.MATRICULA)||'-'||
                                       to_char(C_FUN.OLD_DT_INICIO) -- ERRO_DESCRICAO
                          );
                  --
              END; -- do Begin de C_FUN.TIP_OPERACAO = 'D'
              --
            ELSIF C_FUN.TIP_OPERACAO = 'U' THEN  -- Opera��o � 'U' (Update)
                -- Verifico se a fun��o foi alterada
                IF C_FUN.OLD_FUN_CODIGO != C_FUN.NEW_FUN_CODIGO THEN
                  --
                  BEGIN
                    UPDATE ATIVIDADES_EMPREGADOS
                       SET AEM_FUN_CODIGO = C_FUN.NEW_FUN_CODIGO
                     WHERE AEM_IND_ATI_FUN_CAR = 'F'
                       AND AEM_FUN_CODIGO = C_FUN.OLD_FUN_CODIGO
                       AND AEM_DATA_TERMINO IS NULL
                       AND AEM_EMP_NUMERO_MATRICULA = C_FUN.MATRICULA;
                    --
                    --
                  EXCEPTION
                    WHEN OTHERS THEN
                      v_erroneas := v_erroneas + 1;
                      INSERT INTO ERRO_ATUALIZA_ATIV_EMP
                              (
                              ERRO_CFA_SEQUENCIAL,
                              ERRO_CFA_TIP_OPERACAO,
                              ERRO_DESCRICAO
                              )
                         values
                              (
                               C_FUN.SEQUENCIAL,
                               C_FUN.TIP_OPERACAO, -- ERRO_CFA_TIP_OPERACAO
                               'Mat Erro(U): FUN OLD E NEW !='||
                                           to_char(C_FUN.MATRICULA) -- ERRO_DESCRICAO
                              );
                      --
                  END;
                  --
                END IF;
                -- Verifico se a data inicio foi alterada
                IF C_FUN.OLD_DT_INICIO != C_FUN.NEW_DT_INICIO THEN
                  --
                  BEGIN
                    UPDATE ATIVIDADES_EMPREGADOS
                       SET AEM_DATA_INICIO = C_FUN.NEW_DT_INICIO
                     WHERE AEM_IND_ATI_FUN_CAR = 'F'
                       AND AEM_FUN_CODIGO = C_FUN.NEW_FUN_CODIGO
                       AND AEM_DATA_INICIO = C_FUN.OLD_DT_INICIO
                       AND AEM_EMP_NUMERO_MATRICULA = C_FUN.MATRICULA;
                    --
                    --
                  EXCEPTION
                    WHEN OTHERS THEN
                      v_erroneas := v_erroneas + 1;
                      INSERT INTO ERRO_ATUALIZA_ATIV_EMP
                              (
                              ERRO_CFA_SEQUENCIAL,
                              ERRO_CFA_TIP_OPERACAO,
                              ERRO_DESCRICAO
                              )
                         values
                              (
                               C_FUN.SEQUENCIAL,
                               C_FUN.TIP_OPERACAO, -- ERRO_CFA_TIP_OPERACAO
                               'Mat Erro(U): DT_INI OLD E NEW !='||
                                           to_char(C_FUN.MATRICULA) -- ERRO_DESCRICAO
                              );
                  --
                  END;
                END IF;
                -- Fa�o as atualiza��es respeito da data de termino
                IF C_FUN.OLD_DT_TERMINO IS NULL AND C_FUN.NEW_DT_TERMINO IS NOT NULL
                -- Neste caso tem que verificar se tem que fechar as atividades do empregado
                THEN
                  BEGIN
                    v_existe_oco := NULL;
                    -- Verifico se existe nas ocorrencias do empregado alguma ocorrencia
                    -- que tenha a mesma fun��o e esteja aberta
                    OPEN CUR_EXISTE;
                    FETCH CUR_EXISTE INTO C_EXISTE;
                    v_existe_oco := C_EXISTE.SIM;
                    CLOSE CUR_EXISTE;
                    --
                    IF v_existe_oco IS NULL THEN
                    --
                      UPDATE ATIVIDADES_EMPREGADOS
                         SET AEM_DATA_TERMINO = C_FUN.NEW_DT_TERMINO,
                             AEM_DOCUMENTO_TERMINO = C_FUN.DOC_TERMINO
                       WHERE AEM_IND_ATI_FUN_CAR = 'F'
                         AND AEM_FUN_CODIGO = C_FUN.NEW_FUN_CODIGO
                         AND AEM_DATA_TERMINO IS NULL
                         AND AEM_EMP_NUMERO_MATRICULA = C_FUN.MATRICULA;
                      --
                      --
                    END IF;
                    --
                  EXCEPTION
                    WHEN OTHERS THEN
                      v_erroneas := v_erroneas + 1;
                      INSERT INTO ERRO_ATUALIZA_ATIV_EMP
                              (
                              ERRO_CFA_SEQUENCIAL,
                              ERRO_CFA_TIP_OPERACAO,
                              ERRO_DESCRICAO
                              )
                         values
                              (
                               C_FUN.SEQUENCIAL,
                               C_FUN.TIP_OPERACAO, -- ERRO_CFA_TIP_OPERACAO
                               'Mat Erro(U): FECHA DT_TERMINO !='||
                                           to_char(C_FUN.MATRICULA) -- ERRO_DESCRICAO
                              );
                    --
                  END;
                ELSIF NVL(C_FUN.OLD_DT_TERMINO,'11/11/1900') !=
                      NVL(C_FUN.NEW_DT_TERMINO,'11/11/1900')
                -- Neste caso tem que alterar a data termino
                THEN
                  --
                  BEGIN
                    UPDATE ATIVIDADES_EMPREGADOS
                       SET AEM_DATA_TERMINO = C_FUN.NEW_DT_TERMINO,
                           AEM_DOCUMENTO_TERMINO = C_FUN.DOC_TERMINO
                     WHERE AEM_IND_ATI_FUN_CAR = 'F'
                       AND AEM_FUN_CODIGO = C_FUN.NEW_FUN_CODIGO
                       AND AEM_DATA_TERMINO = C_FUN.OLD_DT_TERMINO
                       AND AEM_EMP_NUMERO_MATRICULA = C_FUN.MATRICULA;
                    --
                    --
                  EXCEPTION
                    WHEN OTHERS THEN
                      v_erroneas := v_erroneas + 1;
                      INSERT INTO ERRO_ATUALIZA_ATIV_EMP
                              (
                              ERRO_CFA_SEQUENCIAL,
                              ERRO_CFA_TIP_OPERACAO,
                              ERRO_DESCRICAO
                              )
                         values
                              (
                               C_FUN.SEQUENCIAL,
                               C_FUN.TIP_OPERACAO, -- ERRO_CFA_TIP_OPERACAO
                               'Mat Erro(U): 11/11/1900'||
                                       to_char(C_FUN.MATRICULA) -- ERRO_DESCRICAO
                              );
                    --
                  END;
                END IF; -- DO IF C_FUN.OLD_DT_TERMINO IS NULL AND C_FUN.NEW_DT_TERMINO
                --
            END IF; -- De IF Opera��es
            --
            -- Atualizo a tabela de controle para o registro ja tratado
            UPDATE CTRL_FUN_ATIVIDADES_EMPREGADOS
               SET CFA_FLAG_EXECUTO = 'S'
             WHERE CFA_SEQUENCIAL = C_FUN.SEQUENCIAL;
            --
            --
          EXCEPTION
            WHEN OTHERS THEN
              NULL;
          END;
        END LOOP; -- De cursor CUR_FUN
        CLOSE CUR_FUN;
        --
        COMMIT;
        --
        EXCEPTION
          WHEN OTHERS THEN
            NULL;
      END ATUALIZA_ATIV_EMPREGADOS;
   ----------------
   ----------------
   --
   --
   ------------------------------------------------------------------------------------
   -- Rotina para atualizar na tabela de Empregados, os atributos referentes �
   -- designa��o de fun��o de empregados que est�o com data t�rmino das ocorrencias
   --    86 Designa��o de fun��o de confian�a
   --    93 Designa��o interina de fun��o de confian�a
   --   125 Designa��o de diretor empregado
   -- igual ao dia anterior � data do sistema
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
   -- Rotina para atualizar na tabela de Empregados, os atributos referentes �
   -- designa��o de fun��o de empregados que est�o com data in�cio das ocorrencias
   --    86 Designa��o de fun��o de confian�a
   --    93 Designa��o interina de fun��o de confian�a
   --   125 Designa��o de diretor empregado
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
   -- Rotina para atualizar na tabela de Empregados, os atributos referentes �
   -- designa��o de fun��o cumulativa ou substitui��o de fun��o com data t�rmino
   -- das ocorrencias
   --    85 Designa��o cumulativa de fun��o de confian�a
   --    89 Substitui��o de fun��o de confian�a maior 7 dias
   --   220 substitui��o cumulativa de fun��o de confian�a maior 7 dias
   --   217 Designa��o cumulativa e interina de fun��o de confian�a
   -- igual ao dia anterior � data do sistema
   ------------------------------------------------------------------------------------
   /*
   Procedure atualiza_final_cumulativa is
      cursor c_fun is
             select oem_emp_numero_matricula,
                    oem_ofu_codigo
             from   ocorrencias_empregados
             where  oem_ofu_codigo in (85, 89, 220, 217)
             and    oem_data_termino = p_data_base - 1;
   Begin
      for r_fun in c_fun
      loop
         if r_fun.oem_ofu_codigo in (85,217) then
            begin
               update cadastros
               set    emp_qfu_fun_codigo_acumula     = null,
                      emp_qfu_hfl_uor_cod_acum       = null,
                      emp_qfu_hfl_data_vigen_acum    = null,
                      emp_tipo_remuner_funcao_acumul = null
               where  emp_numero_matricula = r_fun.oem_emp_numero_matricula;
            end;
         else
            begin
               update cadastros
               set    emp_qfu_fun_codigo_substitui   = null,
                      emp_qfu_hfl_uor_cod_subst      = null,
                      emp_qfu_hfl_data_vigen_subst   = null,
                      emp_tipo_remuner_funcao_subst  = null
               where  emp_numero_matricula = r_fun.oem_emp_numero_matricula;
            end;
         end if;
      end loop;
   End atualiza_final_cumulativa;
   */
   ------------------------------------------------------------------------------------
   -- Rotina para atualizar na tabela de Empregados, os atributos referentes �
   -- designa��o de fun��o cumulativa ou substitui��o de fun��o com data in�cio
   -- das ocorrencias
   --    85 Designa��o cumulativa de fun��o de confian�a
   --    89 Substitui��o de fun��o de confian�a maior 7 dias
   --   220 substitui��o cumulativa de fun��o de confian�a maior 7 dias
   --   217 Designa��o cumulativa e interina de fun��o de confian�a
   -- igual � data do sistema
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
   -- Rotina para atualizar na tabela de Empregados os atributos referentes �s
   -- ocorr�ncias
   --    80 Remo��o de uma depend�ncia para outra
   --    81 Remo��o de uma unidade  organizacional para outra
   --    82 Transfer�ncia definitiva -  intereresse da empresa
   --    83 Transfer�ncia provis�ria -  interesse da empresa
   --    84 Transfer�ncia definitiva - interesse  pr�prio
   --   131 Redu��o hora extra noturna 100% (120)
   --   132 Redu��o hora extra noturna 100% (180)
   --   133 Redu��o hora extra noturna 100% (220)
   -- que est�o com data t�rmino igual ao dia anterior � data do sistema
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
   -- Rotina para atualizar na tabela de Empregados os atributos referentes �s
   -- ocorr�ncias
   --    80 Remo��o de uma depend�ncia para outra
   --    81 Remo��o de uma unidade  organizacional para outra
   --    82 Transfer�ncia definitiva -  intereresse da empresa
   --    83 Transfer�ncia provis�ria -  interesse da empresa
   --    84 Transfer�ncia definitiva - interesse  pr�prio
   --   131 Redu��o hora extra noturna 100% (120)
   --   132 Redu��o hora extra noturna 100% (180)
   --   133 Redu��o hora extra noturna 100% (220)
   -- que est�o com data data in�cio igual � data do sistema
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
   -- Rotina para atualizar na tabela de Empregados os atributos referentes �s
   -- ocorr�ncias
   --   135 Cess�o de empregado com �nus
   --   136 Cess�o de empregado sem �nus
   --   203 Cess�o de empregado com ressarcimento
   -- que est�o com data t�rmino igual ao dia anterior � data do sistema
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
   -- Rotina para atualizar na tabela de Empregados os atributos referentes �s
   -- ocorr�ncias
   --   135 Cess�o de empregado com �nus
   --   136 Cess�o de empregado sem �nus
   --   203 Cess�o de empregado com ressarcimento
   -- que est�o com data in�cio igual � data do sistema
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
   -- Rotina para atualizar na tabela de Empregados os atributos referentes �
   -- ocorr�ncia
   --   212 Op��o tipo fun��o de confian�a empregado
   -- que estiver com a data de t�rmino igual ao dia anterior � data do sistema
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
   -- Rotina para atualizar na tabela de Empregados os atributos referentes �
   -- ocorr�ncia
   --   212 Op��o tipo fun��o de confian�a empregado
   -- que estiver com a data de in�cio igual � data do sistema
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
--______________________ In�cio do Corpo Principal do Programa ______________________--
BEGIN                                                                                --
   --
   ------------------------------------------------------------------------------------
   -- Ficou estabelecido que todo dia 1� de cada m�s                                 --
   -- ser� tomado como base para atualiza��o dos                                     --
   -- percentuais de anu�nios e/ou suas inclus�es                                    --
   --                                                                                --
   IF TO_CHAR(p_data_base, 'DD') = '01' THEN                                         --
      FOR r_emp IN c_emp LOOP                                                        --
         v_ct := v_ct + 1;                                                           --
         --                                                                          --
         BUSCA_TEMPO_SERVICO_ANUENIO ( r_emp.emp_numero_matricula,                   --
                                       r_emp.emp_data_admissao,                      --
                                       v_data_ultimo_anuenio,                        --
                                       anos_tempo_servico,                           --
                                       dias_tempo_servico,                           --
                                       dias_afastamento);                            --
                                                                                     --
         IF to_char((v_data_ultimo_anuenio + dias_tempo_servico +                    --
            (dias_afastamento * 2)),'mmyyyy') = to_char(p_data_base,'mmyyyy') THEN   --
                                                                                     --
            -- Atualiza a ocorr�ncia                                                 --
                                                                                     --
            ATUALIZA_PERCENTUAIS_ANUENIOS( r_emp.emp_numero_matricula,               --
                                           r_emp.emp_data_admissao,                  --
                                           dias_afastamento,                         --
                                           anos_tempo_servico,                       --
                                           dias_tempo_servico,                       --
                                           v_percentual,                             --
                                           V_DATA_ULTIMO_ANUENIO);                   --
            --                                                                       --
            -- Insere a ocorr�ncia 73 (Adicional por tempo de servi�o)               --
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
         --                                                                          --
         IF v_ct = 500 THEN                                                          --
            --                                                                       --
            COMMIT;                                                                  --
            v_ct := 0;                                                               --
            --                                                                       --
         END IF;                                                                     --
         --                                                                          --
      END LOOP;                                                                      --
      --                                                                             --
      COMMIT;                                                                        --
      --                                                                             --
   END IF;                                                                           --
   ------------------------------------------------------------------------------------
   ------------------------------------------------------------------------------------
   -- Ficou estabelecido que todo dia 5 de cada m�s                                  --
   -- ser� tomado como base para atualiza��o dos                                     --
   -- adicionais de 13� sal�rio e f�rias                                             --
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
         -- Insere ou altera na tabela hst_dependencia_empregado qdo a procedure � chamada
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
   -- Realiza atualiza��es nas rubricas da tabela de movimentacao.
   TRATA_AFASTAMENTOS(NULL); -- como envio nulo faz para todas as matriculas
   COMMIT;
   /* FIM AGREGADO 23/07/2003 */
   /* AGREGADO 25/03/2003 */
   -- Atualiza as fun��es quando devem come�ar ou terminat na data atual(SYSDATE)
   ATUALIZA_FUNCAO;
   COMMIT;
   /* FIM AGREGADO 25/03/2003 */
   --
   /* AGREGADO 05/12/2003 */
   RETORNO_TRANSF_PROVISORIA;
   COMMIT;
   /* FIM AGREGADO 05/12/2003 */

   /* AGREGADO 10/03/2004 */
   ATUALIZA_DEPENDENCIA_USUARIO;
   COMMIT;
   /* FIM AGREGADO 10/03/2004 */

   /* AGREGADO 05/04/2004 */
   ATUALIZA_ATIV_EMPREGADOS;
   COMMIT;
   /* FIM AGREGADO 05/04/2004 */




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
END SRH_CAD_PROCEDIMENTOS_DIARIOS;
/


GRANT EXECUTE ON srh_cad_procedimentos_diarios TO rh_perfil_99
/

