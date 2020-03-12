SELECT   count(1) total_usuarios, round(sum(bytes)/1024,2) total_bytes_MB, round((sum(bytes)/1024)/count(1),2) media_MB
  FROM   mv_dados_resumidos
 WHERE   Matricula not in ('-')
   AND   Matricula not in (
                    select * from (
                        SELECT   Matricula
                          FROM   mv_dados_resumidos
                         WHERE   Matricula not in ('-')
                         ORDER
                            BY   BYTES DESC)
                    where   Rownum < 51
                    union
                    select * from (
                        SELECT   Matricula
                          FROM   mv_dados_resumidos
                         WHERE   Matricula not in ('-')
                         ORDER
                            BY   BYTES ASC)
                    where   Rownum < 51)
 ORDER
    BY   BYTES DESC


