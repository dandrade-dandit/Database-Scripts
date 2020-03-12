CREATE OR REPLACE FUNCTION VALIDA_FORMULA (PAR_FORMULA VARCHAR2)
         RETURN VARCHAR2 IS
   V_EXISTE_OPERANDO        CHAR(1);
   V_FORMULA                VARCHAR2(200);
   V_FORMULA_AUX            VARCHAR2(200);
   V_OPERANDO               VARCHAR2(100);
   V_POSICAO                NUMBER(3);
   V_POSICAO_BRANCO         NUMBER(3);
   V_STRING                 VARCHAR2(200);
   V_STRING_ANT             VARCHAR2(200);
   V_TAMANHO                NUMBER(3);
   V_TIPO_STRING            VARCHAR2(40);
   V_TIPO_STRING_ANT        VARCHAR2(40);
   V_TOT_ABRE_PARENTESE     NUMBER(2);
   V_TOT_FECHA_PARENTESE    NUMBER(2);
   ---------------------------------------------------------------
   ----- Recebe NÚMERO com tipo CHAR e informa se é NUMÉRICO  ----
   ---------------------------------------------------------------
   FUNCTION NUMERICO (NUMERO_CHAR VARCHAR2) RETURN BOOLEAN IS
    NUMERO  NUMBER(14,4);
   BEGIN
        IF NUMERO_CHAR IS NULL THEN
       RETURN FALSE;
    ELSE
           NUMERO:= TO_NUMBER(NUMERO_CHAR);
       RETURN TRUE;
        END IF;
   EXCEPTION
        WHEN OTHERS THEN
             RETURN FALSE;
   END NUMERICO;
   -----------------------
   --  Início da Funcão --
   -----------------------
   BEGIN
     V_FORMULA:=PAR_FORMULA;
     V_FORMULA:=REPLACE(V_FORMULA, '(', ' ( ');
     V_FORMULA:=REPLACE(V_FORMULA, ')', ' ) ');
     V_FORMULA:=REPLACE(V_FORMULA, '+', ' + ');
     V_FORMULA:=REPLACE(V_FORMULA, '-', ' - ');
     V_FORMULA:=REPLACE(V_FORMULA, '/', ' / ');
     V_FORMULA:=REPLACE(V_FORMULA, '*', ' * ');
     V_FORMULA:=LTRIM(V_FORMULA) || ' ';
     WHILE INSTR(V_FORMULA, '  ') > 0 LOOP
       V_FORMULA := REPLACE (V_FORMULA, '  ', ' ');
     END LOOP;
     ------------------------------------------------
     --  Validação do primeiro caracter da formula --
     ------------------------------------------------
     IF SUBSTR (V_FORMULA, 1, 1) IN ('+', '-', '*', '/') THEN
          RETURN 'Fórmula não pode iniciar com operador';
     ELSIF SUBSTR (V_FORMULA, 1, 1) = ')' THEN
          RETURN 'Fórmula não pode começar com fecha parêntese';
     END IF;
     ---------------------------------------------
     --  Validação da quantidade de Parênteses  --
     ---------------------------------------------
     V_POSICAO:= 1;
     V_TAMANHO:=LENGTH(V_FORMULA);
     IF V_POSICAO > 0 THEN
       V_TOT_ABRE_PARENTESE := 0;
       V_TOT_FECHA_PARENTESE := 0;
       WHILE V_POSICAO <= V_TAMANHO LOOP
         IF SUBSTR(V_FORMULA, V_POSICAO, 1) = '(' THEN
           V_TOT_ABRE_PARENTESE := V_TOT_ABRE_PARENTESE + 1;
         ELSIF SUBSTR(V_FORMULA, V_POSICAO, 1) = ')' THEN
           V_TOT_FECHA_PARENTESE := V_TOT_FECHA_PARENTESE + 1;
           IF V_TOT_FECHA_PARENTESE > V_TOT_ABRE_PARENTESE THEN
              RETURN 'O ' || TO_CHAR(V_TOT_FECHA_PARENTESE) ||
                     'º fecha parêntese não tem abre parêntese ' ||
                     'correspondente';
           END IF;
         END IF;
         V_POSICAO := V_POSICAO + 1;
       END LOOP;
       IF V_TOT_ABRE_PARENTESE > V_TOT_FECHA_PARENTESE THEN
         IF (V_TOT_ABRE_PARENTESE - V_TOT_FECHA_PARENTESE) > 1 THEN
            RETURN 'Há ' || TO_CHAR(V_TOT_ABRE_PARENTESE -
                                    V_TOT_FECHA_PARENTESE) ||
                   ' parênteses que não foram fechados';
         ELSE
            RETURN 'Falta fechar parêntese';
         END IF;
       END IF;
     END IF;
     --------------------------------------------------------
     --  Validação da seqüência de operandos e operadores  --
     --------------------------------------------------------
     V_POSICAO_BRANCO:=NVL(INSTR(V_FORMULA, ' '),0);
     V_STRING_ANT:=SUBSTR(V_FORMULA, 1, V_POSICAO_BRANCO - 1);
     IF    V_STRING_ANT IN ('+','-','*','/') THEN
           V_TIPO_STRING_ANT := 'OPERADOR';
     ELSIF V_STRING_ANT = '(' THEN
           V_TIPO_STRING_ANT := 'ABRE_PARENTESE';
     ELSIF V_STRING_ANT = ')' THEN
           V_TIPO_STRING_ANT := 'FECHA_PARENTESE';
     ELSE
     DBMS_OUTPUT.PUT_LINE('AQUI ');
           V_TIPO_STRING_ANT := 'OPERANDO';
           IF NOT NUMERICO(V_STRING_ANT) THEN
             IF SUBSTR(V_STRING_ANT, 1, 6) IN ('VALRUB', 'FORRUB') THEN
                V_OPERANDO := SUBSTR(V_STRING_ANT, 1, 6);
             ELSE
                V_OPERANDO := V_STRING_ANT;
             END IF;
             BEGIN
               SELECT  'S'
               INTO    V_EXISTE_OPERANDO
               FROM    OPERANDOS
               WHERE   OPE_SIGLA = V_OPERANDO;
             EXCEPTION
               WHEN NO_DATA_FOUND THEN
                    V_EXISTE_OPERANDO := 'N';
             END;
             IF V_EXISTE_OPERANDO = 'N' THEN
                RETURN 'Primeiro operando não cadastrado: <' ||
                        V_STRING_ANT || '>';
             END IF;
           END IF;
     END IF;
     V_FORMULA_AUX:=SUBSTR (V_FORMULA, V_POSICAO_BRANCO + 1);
     V_POSICAO_BRANCO:=NVL(INSTR(V_FORMULA_AUX, ' '),0);
     WHILE LENGTH(V_FORMULA_AUX) > 0 LOOP
       V_STRING:=SUBSTR(V_FORMULA_AUX, 1, V_POSICAO_BRANCO - 1);
       IF    V_STRING IN ('+','-','*','/') THEN
             V_TIPO_STRING := 'OPERADOR';
       ELSIF V_STRING = '(' THEN
             V_TIPO_STRING := 'ABRE_PARENTESE';
       ELSIF V_STRING = ')' THEN
             V_TIPO_STRING := 'FECHA_PARENTESE';
       ELSE
             V_TIPO_STRING := 'OPERANDO';
       END IF;
       --------------------------------------
       -- Crítica de abertura de parêntese --
       --------------------------------------
       IF V_TIPO_STRING = 'ABRE_PARENTESE' THEN
         IF V_TIPO_STRING_ANT = 'FECHA_PARENTESE' THEN
           RETURN 'Parêntese não pode ser aberto após fecha parêntese';
         ELSE
           IF V_TIPO_STRING_ANT = 'OPERANDO' THEN
             RETURN 'Parêntese não pode ser aberto após operando';
           END IF;
         END IF;
       END IF;
       -----------------------------------------
       -- Crítica de fechamento de Parêntese --
       -----------------------------------------
       IF V_TIPO_STRING = 'FECHA_PARENTESE' THEN
         IF V_TIPO_STRING_ANT = 'ABRE_PARENTESE' THEN
           RETURN 'Parêntese não pode ser fechado após abre parêntese';
         ELSE
           IF V_TIPO_STRING_ANT = 'OPERADOR' THEN
             RETURN 'Parêntese não pode ser fechado após operador';
           END IF;
         END IF;
       END IF;
       ----------------------------------------
       -- Crítica de Precedência de operando --
       ----------------------------------------
       IF V_TIPO_STRING = 'OPERANDO' THEN
         IF V_TIPO_STRING_ANT = 'FECHA_PARENTESE' OR
            V_TIPO_STRING_ANT = 'OPERANDO' THEN
           RETURN 'Falta operador antes do operando <' ||
                   V_STRING || '>';
         END IF;
         IF NOT NUMERICO(V_STRING) THEN
           IF SUBSTR(V_STRING, 1, 6) IN ('VALRUB', 'FORRUB', 'PARRUB') THEN
              V_OPERANDO := SUBSTR(V_STRING, 1, 6);
           ELSE
              V_OPERANDO := V_STRING;
           END IF;
           BEGIN
             SELECT  'S'
             INTO    V_EXISTE_OPERANDO
             FROM    OPERANDOS
             WHERE   OPE_SIGLA = V_OPERANDO;
           EXCEPTION
             WHEN NO_DATA_FOUND THEN
                  V_EXISTE_OPERANDO := 'N';
           END;
           IF V_EXISTE_OPERANDO = 'N' THEN
              RETURN 'Operando não cadastrado: <' || V_STRING || '>';
           END IF;
         END IF;
       END IF;
       ----------------------------------------
       -- Crítica de Precedência de operador --
       ----------------------------------------
       IF V_TIPO_STRING = 'OPERADOR'THEN
         IF V_TIPO_STRING_ANT = 'ABRE_PARENTESE' THEN
           RETURN 'Operador <' || V_STRING ||
                  '> não pode ser posicionado após abre parêntese';
         ELSIF V_TIPO_STRING_ANT = 'OPERADOR' THEN
           RETURN 'Falta operando entre os operadores <' ||
                   V_STRING_ANT || '> e <' || V_STRING || '>';
         END IF;
       END IF;
       V_TIPO_STRING_ANT := V_TIPO_STRING;
       V_STRING_ANT := V_STRING;
       V_FORMULA_AUX:=SUBSTR (V_FORMULA_AUX, V_POSICAO_BRANCO + 1);
       V_POSICAO_BRANCO:=NVL(INSTR(V_FORMULA_AUX, ' '),0);
     END LOOP;
     IF V_TIPO_STRING_ANT = 'OPERADOR' THEN
        RETURN 'Fórmula não pode terminar com operador';
     END IF;
     RETURN 'OK';
   END VALIDA_FORMULA;
