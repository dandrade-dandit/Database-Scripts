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
   ----- Recebe N�MERO com tipo CHAR e informa se � NUM�RICO  ----
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
   --  In�cio da Func�o --
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
     --  Valida��o do primeiro caracter da formula --
     ------------------------------------------------
     IF SUBSTR (V_FORMULA, 1, 1) IN ('+', '-', '*', '/') THEN
          RETURN 'F�rmula n�o pode iniciar com operador';
     ELSIF SUBSTR (V_FORMULA, 1, 1) = ')' THEN
          RETURN 'F�rmula n�o pode come�ar com fecha par�ntese';
     END IF;
     ---------------------------------------------
     --  Valida��o da quantidade de Par�nteses  --
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
                     '� fecha par�ntese n�o tem abre par�ntese ' ||
                     'correspondente';
           END IF;
         END IF;
         V_POSICAO := V_POSICAO + 1;
       END LOOP;
       IF V_TOT_ABRE_PARENTESE > V_TOT_FECHA_PARENTESE THEN
         IF (V_TOT_ABRE_PARENTESE - V_TOT_FECHA_PARENTESE) > 1 THEN
            RETURN 'H� ' || TO_CHAR(V_TOT_ABRE_PARENTESE -
                                    V_TOT_FECHA_PARENTESE) ||
                   ' par�nteses que n�o foram fechados';
         ELSE
            RETURN 'Falta fechar par�ntese';
         END IF;
       END IF;
     END IF;
     --------------------------------------------------------
     --  Valida��o da seq��ncia de operandos e operadores  --
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
                RETURN 'Primeiro operando n�o cadastrado: <' ||
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
       -- Cr�tica de abertura de par�ntese --
       --------------------------------------
       IF V_TIPO_STRING = 'ABRE_PARENTESE' THEN
         IF V_TIPO_STRING_ANT = 'FECHA_PARENTESE' THEN
           RETURN 'Par�ntese n�o pode ser aberto ap�s fecha par�ntese';
         ELSE
           IF V_TIPO_STRING_ANT = 'OPERANDO' THEN
             RETURN 'Par�ntese n�o pode ser aberto ap�s operando';
           END IF;
         END IF;
       END IF;
       -----------------------------------------
       -- Cr�tica de fechamento de Par�ntese --
       -----------------------------------------
       IF V_TIPO_STRING = 'FECHA_PARENTESE' THEN
         IF V_TIPO_STRING_ANT = 'ABRE_PARENTESE' THEN
           RETURN 'Par�ntese n�o pode ser fechado ap�s abre par�ntese';
         ELSE
           IF V_TIPO_STRING_ANT = 'OPERADOR' THEN
             RETURN 'Par�ntese n�o pode ser fechado ap�s operador';
           END IF;
         END IF;
       END IF;
       ----------------------------------------
       -- Cr�tica de Preced�ncia de operando --
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
              RETURN 'Operando n�o cadastrado: <' || V_STRING || '>';
           END IF;
         END IF;
       END IF;
       ----------------------------------------
       -- Cr�tica de Preced�ncia de operador --
       ----------------------------------------
       IF V_TIPO_STRING = 'OPERADOR'THEN
         IF V_TIPO_STRING_ANT = 'ABRE_PARENTESE' THEN
           RETURN 'Operador <' || V_STRING ||
                  '> n�o pode ser posicionado ap�s abre par�ntese';
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
        RETURN 'F�rmula n�o pode terminar com operador';
     END IF;
     RETURN 'OK';
   END VALIDA_FORMULA;
