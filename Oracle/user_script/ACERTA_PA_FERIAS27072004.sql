-- Procedure ACERTA_PA_FERIAS

CREATE OR REPLACE
PROCEDURE ACERTA_PA_FERIAS( p_mat            NUMBER,
                            periodo_i IN OUT DATE,
                            periodo_f IN OUT DATE ) IS
   --
   -----------------------------------------------------------------------------------------
   --                                                                                     --
   --                                   ACERTA_PA_FERIAS                                  --
   --                                   ------ -- ------                                  --
   --                                                                                     --
   --        Procedure que recebe as duas datas padrão dos P.A.s e as retorna modificadas --
   -- de acordo com os afastamentos do empregado. Os afastamentos que alteram o P.A. do   --
   -- empregado são os seguintes:                                                         --
   --       -->  15 AUXILIO DOENCA ACIDENTARIO (INSS)                                     --
   --       -->  16 AUXÍLIO DOENÇA (INSS) SEM CARÊNCIA                                    --
   --       -->  17 AUXILIO DOENCA OCUPACIONAL (INSS)                                     --
   --            18 CONTRATO SUSPENSO (SUB-JÚDICE)                                        --
   --            79 CONTRATO SUSPENSO                                                     --
   --       --> 127 AUXÍLIO DOENÇA (INSS)                                                 --
   --           143 AUSÊNCIA POR MOTIVO DE DOENÇA - DET. APOSENTADORIA                    --
   --           144 AUSÊNCIA MOTIVO DOENÇA ACIDENT DET APOSENTADORIA                      --
   -- Obs.: As ocorrências (15, 16, 17, 127) alteram o P.A. de forma diferente das outras,--
   -- no caso delas o P.A. só é alterado se o somatório de dias afastados der mais do que --
   -- 180 dias, acarretando na  mudança da data de  início  do P.A. para o 1º dia após  o --
   -- afastamento e a data de término para a data de início mais 364 dias.                --
   --                                                                                     --
   -- Criado por: Luiz Fernando Bastos Coura                                              --
   -- Data da criação: 07/08/2001                                                         --
   --                                                                                     --
   -- Alterado por: Edmundo Paiva Junior                                                  --
   -- Data da última alteração: 18/12/2001                                                --
   -- Obs.: Foi incluída a condição para a rotina despresar as ocorrências                --
   -- (15, 16, 17, 127) cuja diferença entre a data término do PA menos a data início da  --
   -- não ultrapassar 180 dias                                                            --
   -----------------------------------------------------------------------------------------
   --
   -- /* Agregado 27/03/2003*/
   -- Declaração de procedimentos e funções internas
   FUNCTION DATAS_CONTIGUAS (p_ofu_codigo OCORRENCIAS_FUNCIONAIS.ofu_codigo%TYPE,
                          p_data_termino DATE,
                          p_matricula CADASTROS.emp_numero_matricula%TYPE
                          ) RETURN VARCHAR2;
   -- /* Fim Agregado 27/03/2003*/
   --
   -- Cursor que busca todos os afastamentos do empregado
   CURSOR c_afastamento IS
      SELECT oem_ofu_codigo,
             oem_data_inicio,
             oem_data_termino
      FROM   ocorrencias_empregados
      WHERE  oem_emp_numero_matricula = p_mat
      AND    (oem_data_termino is null or to_char(oem_data_termino,'yyyy') > 2001 )
      AND    oem_ofu_codigo IN (15, 16, 17, 18, 28, 127, 79, 143, 144)
      ORDER  BY 2, 3;
   --
   data_i              DATE;
   data_f              DATE;
   data_i_contigua     DATE;
   data_f_contigua     DATE;
   v_data_reintegracao DATE;           -- Agregado 24/01/2003
   v_tot_dias_PA       NUMBER(4) := 0; -- Agregado 24/01/2003
   codigo              NUMBER(4);
   v_total             NUMBER := 0;
   v_total_1           NUMBER := 0;
   --
   --
   -- Corpo de procedimentos internos
   -- -----------------------------------------------------------------------------
   -- Rotina para detectar se existem afastamentos com datas contiguas
   -- -----------------------------------------------------------------------------
   -- /* Agregado 27/03/2003*/
   FUNCTION DATAS_CONTIGUAS (p_ofu_codigo OCORRENCIAS_FUNCIONAIS.ofu_codigo%TYPE,
                          p_data_termino DATE,
                          p_matricula CADASTROS.emp_numero_matricula%TYPE
                          )
    RETURN VARCHAR2 IS
      v_contigua VARCHAR2(1);
   BEGIN
     BEGIN
        SELECT 'S'
         INTO v_contigua
         FROM ocorrencias_empregados
        WHERE oem_ofu_codigo = p_ofu_codigo
          AND TRUNC(oem_data_inicio) = TRUNC(p_data_termino) + 1
          AND oem_emp_numero_matricula = p_matricula;
     EXCEPTION
       WHEN NO_DATA_FOUND THEN
         v_contigua := 'N';
     END;
     RETURN(v_contigua);
   END;
   -- /* Fim Agregado 27/03/2003 */
   --
-- -----------------------------------------------------------------------------------
-- -----------------------------------------------------------------------------------
--                          COMENÇO DA ROTINA PRINCIPAL
-- -----------------------------------------------------------------------------------
-- -----------------------------------------------------------------------------------
BEGIN
   /* Agregado 24/01/2003 */
   -- Verifica se o empregado tem reintegraçoes
   BEGIN
     SELECT MAX(oem_data_inicio)
        INTO v_data_reintegracao
        FROM ocorrencias_empregados
       WHERE oem_emp_numero_matricula = p_mat
         AND oem_ofu_codigo IN (142,201)
         AND oem_data_termino IS NULL;
   EXCEPTION
     WHEN OTHERS THEN
       v_data_reintegracao := NULL;
   END;
   -- Verifica se a data de reintegraçao é maior ao PA. Sim é maior então modifica as datas
   -- do PA.
   IF NVL(v_data_reintegracao,periodo_i) > periodo_f THEN
     v_tot_dias_PA := (periodo_f - periodo_i);
     periodo_i := v_data_reintegracao;
     periodo_f := v_data_reintegracao + v_tot_dias_PA;
   END IF;
   /* fim Agregado 24/01/2003 */           --
   OPEN c_afastamento;
   FETCH c_afastamento INTO codigo, data_i, data_f;
   --
   IF codigo IS NOT NULL THEN -- Se o empregado tiver algum afastamento
      --
      LOOP
         /* AGREGADO 27/03/2003 */
         IF DATAS_CONTIGUAS(codigo,data_f,p_mat)= 'S' THEN
           FETCH c_afastamento INTO codigo, data_i_contigua, data_f_contigua;
           --
           -- altero a data_f pela da ocorrencia com datas contiguas
           data_f := data_f_contigua;
         END IF;
         /* FIM AGREGADO 27/03/2003 */
         --
--       DBMS_OUTPUT.PUT_LINE('Afastamento data_i='||to_char(data_i,'dd/mm/yyyy hh24:mi:ss'));
--       DBMS_OUTPUT.PUT_LINE('Afastamento data_f='||to_char(data_f,'dd/mm/yyyy hh24:mi:ss'));
         IF TO_NUMBER(TO_CHAR(periodo_f, 'YYYY')) > (TO_NUMBER(TO_CHAR(SYSDATE, 'YYYY')) + 1) THEN
            --
            periodo_i := NULL;
            periodo_f := NULL;
            EXIT;
            --
         END IF;
         --
         IF data_f IS NULL THEN
           /* verifica se o afastamento com data_f em null esta dentro do PA */
           IF NOT(periodo_f < data_i) THEN
             periodo_i := NULL;
             periodo_f := NULL;
             EXIT;
             --
           END IF;
         END IF;
         --
         IF (data_i <= periodo_i) AND (data_f >= periodo_i) THEN
            --
            IF codigo = 79 OR codigo = 143 OR codigo = 144 OR codigo = 18
               OR codigo = 28
            THEN
               v_total := v_total + ((data_f - periodo_i) + 1);
            ELSE
               v_total_1 := v_total_1 + ((data_f - periodo_i) + 1);
            END IF;
            --
         ELSIF (data_i <= periodo_f) AND (data_i >= periodo_i) THEN
            --
            IF data_f >= periodo_f THEN
               --
               IF codigo = 79 OR codigo = 143 OR codigo = 144 OR codigo = 18
                  OR codigo = 28               
               THEN
                  v_total := v_total + ((periodo_f - data_i) + 1);
               ELSE
                  -- Para as ocorrências em que o total de dias não pode ser maior
                  -- do que 180 deve-se calcular o afastamento como um todo.
                  if (periodo_f - data_i) > 180 then
                     v_total_1 := v_total_1 + ((data_f - data_i) + 1);
        --          /* Agregado 17/01/2003 */
        --          else
        --             v_total_1 := v_total_1 + ((periodo_f - data_i) + 1);
                  /* Fim Agregado 17/01/2003 */
                  end if;
               END IF;
               --
            ELSE
               --
               IF codigo = 79 OR codigo = 143 OR codigo = 144 OR codigo = 18
                  OR codigo = 28               
               THEN
                  v_total := v_total + ((data_f - data_i) + 1);
               ELSE
                  v_total_1 := v_total_1 + ((data_f - data_i) + 1);
               END IF;
               --
            END IF;
            --
         END IF;
         --
         IF codigo = 79 OR codigo = 143 OR codigo = 144 OR codigo = 18
            OR codigo = 28         
         THEN
            --
            IF v_total <> 0 THEN
               --
               IF v_total >= ((periodo_f - periodo_i) + 1) THEN
                  periodo_f := add_months(data_f,12) - 1;
               ELSIF data_f < periodo_f THEN
                  periodo_f := periodo_f + v_total;
               ELSE
                  periodo_f := data_f + v_total;
               END IF;
               --
            END IF;
            --
            -- Limpa a variável de v_total
            v_total := 0;
            --
         ELSE -- (15, 16, 17, 127)
            --
            IF v_total_1 > 180 THEN
               --
               periodo_i := data_f + 1;
               periodo_f := add_months(periodo_i,12) - 1;
               --
               -- Limpa a variável de v_total_1
               v_total_1 := 0;
            /* Agregado 17/01/2003 */
       --     ELSIF v_total_1 > 0  THEN
       --             periodo_f := data_f + (v_total_1-1);
               --
               -- Limpa a variável de v_total_1
       --        v_total_1 := 0;
            /* Fim Agregado 17/01/2003*/
            --
            END IF;
            --
         END IF;
         --
         FETCH c_afastamento INTO codigo, data_i, data_f;
         EXIT WHEN c_afastamento%NOTFOUND;
         --
      END LOOP;
      --
      CLOSE c_afastamento;
      --
   END IF; -- Fim do IF que verifica se o empregado tem algum afastamento
   --
EXCEPTION
   WHEN VALUE_ERROR THEN DBMS_OUTPUT.PUT_LINE( 'VALUE_ERROR MAT: ' || TO_CHAR(p_mat) );
END;
/

