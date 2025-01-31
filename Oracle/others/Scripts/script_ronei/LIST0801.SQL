CREATE TABLE dispatcherhistory (
  timepoint DATE,
  name VARCHAR2(10),
  network VARCHAR2(10),
  cumulativebusy REAL,
  cumulativeidle REAL,
  intervalload REAL)

CREATE PROCEDURE capturedispatcherloads
  (interval INTEGER, timepoints INTEGER) AS
-- Este procedimento acorda a intervalos fornecidos (especificados em
-- minutos) e registra a carga colocada em cada despachador ocorrida no
-- intervalo. A informa��o de carga � colocada na tabela de hist�rico
-- dos despachadores. Voc� pode ent�o usar os dados na tabela de hist�rico
-- para ver a flutua��o nas cargas dos despachadores ao longo do tempo
-- nos diversos despachadores de seu sistema, e fazer as modifica��es
-- apropriadas em sua configura��o de servidor multilinear.

-- Uso : EXECUTE capturedispatcherloads(mm, nn);
-- Onde : mm = intervalo das amostragens em minutos
--        nn = n�mero de amostragens a fazer

counter INTEGER := 0;
previousbusy REAL;
previousidle REAL;
intervalbusy REAL;
intervalidle REAL;
load REAL;
CURSOR dispatch IS
  SELECT name, network, busy, idle
    FROM v$dispatcher;
BEGIN
  WHILE counter <= timepoints LOOP
    FOR status IN dispatch LOOP
-- situa��o especial com o primeiro datapoints em uma sess�o com uma
-- carga "NULL"
      IF counter = 0 THEN
        INSERT INTO dispatcherhistory
        VALUES(SYSDATE,status.name,status.network,status.busy,status.idle,null);
      ELSE
        SELECT cumulativebusy, cumulativeidle INTO previousbusy, previousidle
          FROM dispatcherhistory
          WHERE name = status.name
          AND timepoint = (SELECT MAX(timepoint)
                           FROM dispatcherhistory
                           WHERE name = status.name);
        intervalbusy := status.busy-previousbusy;
        intervalidle := status.idle-previousidle;
-- caso especial quando o tempo for negativo ou zero, para evitar erros
-- devido a divis�o por zero
        IF intervalbusy <= 0 THEN
          intervalbusy := 0.001;
        END IF;
        load := (intervalbusy/(intervalbusy+intervalidle))*100;
        INSERT INTO dispatcherhistory
        VALUES(SYSDATE,status.name,status.network,status.busy,status.idle,load);
      END IF;
    END LOOP;
    COMMIT;
    dbms_lock.sleep(interval*60);  -- converte intervalo de segundos para minutos
    counter := counter + 1;
  END LOOP;
END capturedispatcherloads;
