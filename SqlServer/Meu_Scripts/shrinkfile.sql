--1) executar o comando.
use pubs --trocar pelo nome da base.
--2) executar o comando abaixo.
backup log pubs --trocar pelo nome da base.
with no_log
--3) executar o comando abaixo no database e gravar o campo "name" para o arquivo de log.
SELECT * FROM SYSFILES
--4) executar o comando abaixo o conteúdo do campo "name" da consulta acima e o tamanho desejado para o arquivo (em MB).
DBCC SHRINKFILE (pubs_log, 1)