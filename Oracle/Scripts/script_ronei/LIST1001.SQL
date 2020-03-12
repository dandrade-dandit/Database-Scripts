CREATE PROCEDURE estimatetablesize (tableowner IN VARCHAR2,
  tablename IN VARCHAR2, rowestimate IN INTEGER) AS
-- Este procedimento estima o tamanho de uma tabela e seus °ndices.
-- Este procedimento requer que vocà primeiro crie uma tabela prot¢tipo
-- e respectivos °ndices, insira linhas representativas, e ent∆o use o
-- comando ANALYZE para coletar estat°sticas sobre a tabela e seus °ndices.

-- Uso: EXECUTE estimatetablesize('owner','tabela',linhas)
-- Onde: owner = owner da tabela
--       tabela = nome da tabela
--       linhas = n£mero de linhas esperadas para a tabela

-- vari†veis para armazenar diversos n£meros necess†rios para os c†lculos
blocksize INTEGER;
reservedblockspace INTEGER;
averagerowlength INTEGER;
numberofrows INTEGER;
tablesizeestimate NUMBER;
indexsizeestimate NUMBER;

-- cursor para recuperar estat°sticas dos °ndices da tabela
CURSOR indexdata (own IN VARCHAR2, tab IN VARCHAR2) IS
  SELECT index_name, leaf_blocks
  FROM sys.dba_indexes
  WHERE table_owner = own AND table_name = tab;

BEGIN
-- consulta para capturar estat°sticas sobre a tabela
SELECT avg_space, avg_row_len, num_rows
  INTO reservedblockspace, averagerowlength, numberofrows
  FROM sys.dba_tables
  WHERE owner=UPPER(tableowner) AND table_name=UPPER(tablename);

-- consulta para pegar o tamanho de bloco do banco de dados
SELECT value INTO blocksize
  FROM v$parameter
  WHERE name='db_block_size';

-- c†lculo da estimativa de tamanho da tabela
tablesizeestimate := CEIL(rowestimate/FLOOR((blocksize-reservedblockspace)/
  averagerowlength));

-- imprime cabeáalho do relat¢rio
DBMS_OUTPUT.PUT_LINE('');
DBMS_OUTPUT.PUT_LINE('Estimativas de Tamanho para a Tabela:'
  ||UPPER(tableowner)||'.'||UPPER(tablename));
DBMS_OUTPUT.PUT_LINE('------------------------------------------------------');
DBMS_OUTPUT.PUT_LINE('');

-- imprime tamanho estimado da tabela em bytes
DBMS_OUTPUT.PUT_LINE('Tamanho em Kbytes:  '
  ||ROUND((tablesizeestimate*blocksize)/1000,0)||'K');
DBMS_OUTPUT.PUT_LINE('');

-- cabeáalho para estimativas de tamanho de °ndices, se houverem
DBMS_OUTPUT.PUT_LINE('  Estimativas de Tamanho dos Indices Associados');
DBMS_OUTPUT.PUT_LINE('');
-- imprime estimativas de tamanho dos °ndices, se houverem
FOR tableindexes IN indexdata(UPPER(tableowner), UPPER(tablename)) LOOP
  DBMS_OUTPUT.PUT_LINE('  Nome do Indice:    '||tableindexes.index_name);

-- c†lculo da estimativa de tamanho do °ndice
  indexsizeestimate := tableindexes.leaf_blocks*(rowestimate/numberofrows);
  DBMS_OUTPUT.PUT_LINE('  Tamanho em Kbytes: '
    ||ROUND((indexsizeestimate*blocksize)/1000,0)||'K');
  DBMS_OUTPUT.PUT_LINE('');
END LOOP;
END estimatetablesize;
