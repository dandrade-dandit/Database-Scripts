CREATE TABLE sharedserverhistory
(
  timepoint DATE,
  servercount INTEGER
)

CREATE PROCEDURE captureservercounts
  (interval INTEGER, timepoints INTEGER) AS
-- Este procedimento acorda a intervalos fornecidos e registra quantos
-- servidores estÆo em uso em uma tabela hist¢rica de servidores
-- compartilhados. Vocˆ pode entÆo usar os dados da tabela hist¢rica
-- de servidores para ver como o Oracle7 inicializa e encerra os
-- servidores atrav‚s do tempo em seu sistema, e fazer as modifica‡äes
-- apropriadas ao parƒmetro MTS_SERVERS em sua configura‡Æo de servidor
-- multilinear.

-- Uso : EXECUTE captureservercounts(mm, nn);
-- Onde : mm = intervalo das amostragens em minutos
--        nn = n£mero de amostragens a fazer

counter INTEGER := 0;
CURSOR server IS
  SELECT count(*) servers FROM v$shared_server;
BEGIN
  WHILE counter < timepoints LOOP
    FOR status IN server LOOP
      INSERT INTO sharedserverhistory
        VALUES (SYSDATE, status.servers);
    END LOOP;
    counter := counter + 1;
    dbms_lock.sleep(interval*60);
    COMMIT;
  END LOOP;
END captureservercounts;
