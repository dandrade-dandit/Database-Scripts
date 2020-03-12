select * from chamado where seq_chamado = 73532

select * from IFRGESTAO_TI.ATRIBUICAO_CHAMADO where seq_chamado = 73532

select * from IFRGESTAO_TI.HISTORICO_CHAMADO where seq_chamado = 73532

update chamado set seq_situacao_chamado = 4, dth_encerramento_efetivo = to_date('09/05/2014', 'DD/MM/RRRR') where seq_chamado = 73532

update IFRGESTAO_TI.HISTORICO_CHAMADO set seq_situacao_chamado = 4 where seq_chamado = 73532 

update IFRGESTAO_TI.ATRIBUICAO_CHAMADO set seq_situacao_chamado = 4 where seq_chamado = 73532 



COMMIT


---EQUIPE DE SÃO PAULO

SELECT  *
  FROM  CHAMADO
 WHERE  SEQ_CHAMADO IN (
                SELECT  SEQ_CHAMADO
                  FROM  ATRIBUICAO_CHAMADO
                 WHERE  SEQ_EQUIPE_TI IN ( 541, 801 )
                   AND  SEQ_SITUACAO_CHAMADO != 4
                   );
                   
---EQUIPE DE RIO DE JANEIRO

SELECT  *
  FROM  CHAMADO
 WHERE  SEQ_CHAMADO IN (
                SELECT  SEQ_CHAMADO
                  FROM  ATRIBUICAO_CHAMADO
                 WHERE  SEQ_EQUIPE_TI IN ( 1081 )
                   AND  SEQ_SITUACAO_CHAMADO != 4
                   );
                   
---EQUIPE DE RECEIFE

SELECT  *
  FROM  CHAMADO
 WHERE  SEQ_CHAMADO IN (
                SELECT  SEQ_CHAMADO
                  FROM  ATRIBUICAO_CHAMADO
                 WHERE  SEQ_EQUIPE_TI IN ( ? )
                   AND  SEQ_SITUACAO_CHAMADO != 4
                   );