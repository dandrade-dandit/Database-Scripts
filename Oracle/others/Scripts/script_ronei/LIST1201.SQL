CREATE TABLE sgastatshistory (
timepoint DATE,
-- colunas para estatisticas cumulativas
cumlibraryreloads REAL,
cumlibrarypins REAL,
cumdictionarygetmisses REAL,
cumdictionarygets REAL,
cumsgablockgets REAL,
cumsgaconsistentgets REAL,
cumsgadiskgets REAL,
-- colunas para percentuais de intervalos
intlibraryreloadpercentage REAL,
intdictionarymisspercentage REAL,
intbuffermisspercentage REAL);

CREATE or replace PROCEDURE gathersgastats (interval INTEGER, timepoints INTEGER) AS
-- Este procedimento coleta pontos de dados a intervalos especificos
-- (em minutos) para o numero de timepoints fornecido, para acompanhar o
-- percentual de ausencias as solicitacoes de biblioteca, dicionario, e buffers
-- de cache. Baixos percentuais sao bons, altos percentuais significam que os
-- tamanhos do cache precisam de ajuste.

counter INTEGER := 0;
-- variaveis para as estatisticas cumulativas atuais
curlibraryreloads REAL;
curlibrarypins REAL;
curdictionarygetmisses REAL;
curdictionarygets REAL;
cursgablockgets REAL;
cursgaconsistentgets REAL;
cursgadiskgets REAL;
-- variaveis para as estatisticas acumuladas anteriores
prevlibraryreloads REAL;
prevlibrarypins REAL;
prevdictionarygetmisses REAL;
prevdictionarygets REAL;
prevsgablockgets REAL;
prevsgaconsistentgets REAL;
prevsgadiskgets REAL;
-- variaveis para estatisticas do intervalo
intlibraryreloads REAL;
intlibrarypins REAL;
intdictionarygetmisses REAL;
intdictionarygets REAL;
intsgablockgets REAL;
intsgaconsistentgets REAL;
intsgadiskgets REAL;
-- variaveis para percentuais do intervalo
libraryreloadpercentage REAL;
dictionarymisspercentage REAL;
buffermisspercentage REAL;

-- cursor para coletar estatisticas do buffer de cache da SGA
CURSOR bufferdata IS
  SELECT name, value
    FROM v$sysstat
    WHERE name IN ('db block gets','consistent gets','physical reads');

BEGIN

-- define loop para coleta dorme/acorda de pontos de dados
WHILE counter <= timepoints LOOP

-- consulta para coletar estatisticas de cache de biblioteca
  SELECT SUM(reloads), SUM(pins)
    INTO curlibraryreloads, curlibrarypins
    FROM v$librarycache;
-- consulta para coletar estatisticas de cache de dicionario
  SELECT SUM(getmisses), SUM(gets)
    INTO curdictionarygetmisses, curdictionarygets
    FROM v$rowcache;
-- abre cursor para coletar estatisticas de cache de buffer da SGA
  FOR buffercache IN bufferdata LOOP
    IF buffercache.name = 'db block gets' THEN
      cursgablockgets := buffercache.value;
    ELSIF buffercache.name = 'consistent gets' THEN
      cursgaconsistentgets := buffercache.value;
    ELSE
      cursgadiskgets := buffercache.value;
    END IF;
  END LOOP;

-- Calcula o percentual de recarga da biblioteca, percentual de ausencias do
-- dicionario e percentual de ausencias do cache de buffer. Caso especial no
-- primeiro datapoint em uma sessao com percentuais NULL.

  IF counter != 0 THEN

-- primeiro, coleta estatisticas acumuladas anteriores da SGASTATHISTORY
    SELECT cumlibraryreloads, cumlibrarypins,
      cumdictionarygetmisses, cumdictionarygets,
      cumsgablockgets, cumsgaconsistentgets, cumsgadiskgets
      INTO prevlibraryreloads, prevlibrarypins,
        prevdictionarygetmisses, prevdictionarygets,
        prevsgablockgets, prevsgaconsistentgets, prevsgadiskgets
      FROM sgastatshistory
      WHERE timepoint = (SELECT MAX(timepoint)
                         FROM sgastatshistory);

-- calcula percentual de recarga da biblioteca
    intlibraryreloads := curlibraryreloads - prevlibraryreloads;
    intlibrarypins := curlibrarypins - prevlibrarypins;
    libraryreloadpercentage :=
      ROUND((intlibraryreloads/(intlibraryreloads + intlibrarypins))*100,2);

-- calcula percentual de ausencias de dicionario
    intdictionarygetmisses := curdictionarygetmisses - prevdictionarygetmisses;
    intdictionarygets := curdictionarygets - prevdictionarygets;
    dictionarymisspercentage :=
      ROUND((intdictionarygetmisses/(intdictionarygetmisses +
        intdictionarygets))*100,2);

-- calcula percentual de ausencias do buffer de cache
    intsgablockgets := cursgablockgets - prevsgablockgets;
    intsgaconsistentgets := cursgaconsistentgets - prevsgaconsistentgets;
    intsgadiskgets := cursgadiskgets - prevsgadiskgets;
    buffermisspercentage :=
      ROUND((intsgadiskgets/(intsgablockgets + intsgaconsistentgets))*100,2);
  ELSE
    libraryreloadpercentage := NULL;
    dictionarymisspercentage := NULL;
    buffermisspercentage := NULL;
  END IF;

-- inclui ponto de dados na tabela SGASTATSHISTORY
  INSERT INTO sgastatshistory
    VALUES (SYSDATE, curlibraryreloads, curlibrarypins, curdictionarygetmisses,
      curdictionarygets, cursgablockgets, cursgaconsistentgets, cursgadiskgets,
      libraryreloadpercentage, dictionarymisspercentage, buffermisspercentage);

  counter := counter + 1;
  dbms_lock.sleep(interval*60);
END LOOP;

END gathersgastats;
