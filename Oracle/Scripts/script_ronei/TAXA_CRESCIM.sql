set heading off
SET FEEDBACK OFF
set verify off

select 'Períodos Válidos' from dual;
select distinct( to_char(data_analyz,'YYYY/MM/DD'))
from analyz_tabelas
;

Accept dat1 PROMPT 'Informe data inicial (aaaa/mm/dd): ';

Accept dat2 PROMPT 'Informe data final   (aaaa/mm/dd): ';
spool C:\Sistemas\Sql\Infraero\Oracle\Scripts\script_ronei\taxa_crescim.log

SELECT '#### Total das tabelas na data &dat1:'||to_char(sum(B.NUM_REGS * B.TAMANHO_MEDIO_REGS),'999,999,999,999')||' bytes'
FROM ANALYZ_TABELAS B
WHERE 	to_char(B.DATA_ANALYZ,'YYYY/MM/DD') = '&dat1' 
;
SELECT '#### Total das tabelas na data &dat2:'||to_char(sum(A.NUM_REGS * A.TAMANHO_MEDIO_REGS),'999,999,999,999')||' bytes'
FROM ANALYZ_TABELAS A
WHERE 	to_char(A.DATA_ANALYZ,'YYYY/MM/DD') = '&dat2'
;
SELECT '#### Total de crescimento das TABELAS JÁ EXISTENTES no período &dat1 à &dat2' FROM DUAL;
SELECT to_char(SUM ((A.NUM_REGS * A.TAMANHO_MEDIO_REGS) - (B.NUM_REGS * B.TAMANHO_MEDIO_REGS)),'999,999,999,999')||' bytes' 
FROM ANALYZ_TABELAS A, ANALYZ_TABELAS B
WHERE 	A.OWNER=B.OWNER AND A.TABELA=B.TABELA AND
	to_char(B.DATA_ANALYZ,'YYYY/MM/DD') = '&dat1' AND
	to_char(A.DATA_ANALYZ,'YYYY/MM/DD') = '&dat2'
;
SELECT '#### Total de TABELAS CRIADAS no período &dat1 à &dat2' FROM DUAL;
SELECT to_char(SUM ((A.NUM_REGS * A.TAMANHO_MEDIO_REGS)),'999,999,999,999')||' bytes' 
FROM ANALYZ_TABELAS A
WHERE 	to_char(A.DATA_ANALYZ,'YYYY/MM/DD') = '&dat2' AND
        A.OWNER||A.TABELA NOT IN (SELECT D.OWNER||D.TABELA FROM ANALYZ_TABELAS D 
                                  WHERE D.OWNER=A.OWNER AND D.TABELA=A.TABELA AND
					to_char(D.DATA_ANALYZ,'YYYY/MM/DD') = '&dat1')
;
SELECT '#### Total de TABELAS DROPADAS no período &dat1 à &dat2' FROM DUAL;
SELECT to_char(SUM ((A.NUM_REGS * A.TAMANHO_MEDIO_REGS)),'999,999,999,999')||' bytes' 
FROM ANALYZ_TABELAS A
WHERE 	to_char(A.DATA_ANALYZ,'YYYY/MM/DD') = '&dat1' AND
        A.OWNER||A.TABELA NOT IN (SELECT D.OWNER||D.TABELA FROM ANALYZ_TABELAS D 
                                  WHERE D.OWNER=A.OWNER AND D.TABELA=A.TABELA AND
					to_char(D.DATA_ANALYZ,'YYYY/MM/DD') = '&dat2')
;
SELECT '#### Total de crescimento no período &dat1 à &dat2:'||to_char((B.valor - A.valor),'999,999,999,999')||' bytes'
FROM (select sum(NUM_REGS * TAMANHO_MEDIO_REGS) valor
      from ANALYZ_TABELAS
      where to_char(DATA_ANALYZ,'YYYY/MM/DD') = '&dat1' ) A,
     (select sum(NUM_REGS * TAMANHO_MEDIO_REGS) valor
      from ANALYZ_TABELAS
      where to_char(DATA_ANALYZ,'YYYY/MM/DD') = '&dat2' ) B
;
SELECT '#### Percentual de crescimento no período &dat1 à &dat2:'||to_char((((B.valor / A.valor) * 100) - 100),'99.99')||'%'
FROM (select sum(NUM_REGS * TAMANHO_MEDIO_REGS) valor
      from ANALYZ_TABELAS
      where to_char(DATA_ANALYZ,'YYYY/MM/DD') = '&dat1' ) A,
     (select sum(NUM_REGS * TAMANHO_MEDIO_REGS) valor
      from ANALYZ_TABELAS
      where to_char(DATA_ANALYZ,'YYYY/MM/DD') = '&dat2' ) B
;
--
SELECT '#### Total de tabelas POR OWNER, no período &dat1 à &dat2' FROM DUAL;
SELECT B.owner||' na data &dat1 '||to_char(A.valor,'999,999,999,999')||' bytes '||' e na data &dat2 '||to_char(B.valor,'999,999,999,999')||' bytes'
FROM (select sum(NUM_REGS * TAMANHO_MEDIO_REGS) valor, owner
      from ANALYZ_TABELAS
      where to_char(DATA_ANALYZ,'YYYY/MM/DD') = '&dat1'
      group by owner ) A,
     (select sum(NUM_REGS * TAMANHO_MEDIO_REGS) valor, owner
      from ANALYZ_TABELAS
      where to_char(DATA_ANALYZ,'YYYY/MM/DD') = '&dat2'
      group by owner ) B
WHERE A.OWNER(+)=B.OWNER
;
--
SELECT '#### Total de tabelas POR SISTEMA (cadastrado), no período &dat1 à &dat2' FROM DUAL;
SELECT C.APLICACAO||' na data &dat1 '||to_char(sum(A.valor),'999,999,999,999')||' bytes '||' e na data &dat2 '||to_char(sum(B.valor),'999,999,999,999')||' bytes'
FROM  TABELAS C,
     (select sum(NUM_REGS * TAMANHO_MEDIO_REGS) valor, owner, tabela
      from ANALYZ_TABELAS
      where to_char(DATA_ANALYZ,'YYYY/MM/DD') = '&dat1'
      group by owner,tabela ) A,
     (select sum(NUM_REGS * TAMANHO_MEDIO_REGS) valor, owner, tabela
      from ANALYZ_TABELAS
      where to_char(DATA_ANALYZ,'YYYY/MM/DD') = '&dat2'
      group by owner,tabela ) B
WHERE A.OWNER(+)=B.OWNER AND A.TABELA(+)=B.TABELA AND C.OWNER=B.OWNER AND C.TABELA=B.TABELA
GROUP BY C.APLICACAO
;

SELECT '#### Total de Tabelas não cadastradas, em &dat2' FROM DUAL;
SELECT A.OWNER||'.'||A.TABELA||' = '||to_char(SUM ((A.NUM_REGS * A.TAMANHO_MEDIO_REGS)),'999,999,999,999')||' bytes' 
FROM  ANALYZ_TABELAS A
WHERE 	to_char(A.DATA_ANALYZ,'YYYY/MM/DD') = '&dat2' AND
        A.OWNER||A.TABELA NOT IN (SELECT D.OWNER||D.TABELA FROM TABELAS D 
                                  WHERE D.OWNER=A.OWNER AND D.TABELA=A.TABELA)
GROUP BY A.OWNER,A.TABELA;

SELECT '#### Tabelas que CRESCERAM, no período &dat1 à &dat2' FROM DUAL;
SELECT C.TABELA||' '||to_char(SUM ((A.NUM_REGS * A.TAMANHO_MEDIO_REGS) - (B.NUM_REGS * B.TAMANHO_MEDIO_REGS)),'999,999,999,999')||' bytes' 
FROM ANALYZ_TABELAS A, ANALYZ_TABELAS B, TABELAS C
WHERE 	A.OWNER=B.OWNER AND A.TABELA=B.TABELA AND C.OWNER=B.OWNER AND C.TABELA=B.TABELA AND
	to_char(B.DATA_ANALYZ,'YYYY/MM/DD') = '&dat1' AND
	to_char(A.DATA_ANALYZ,'YYYY/MM/DD') = '&dat2' AND
	0 < ((A.NUM_REGS * A.TAMANHO_MEDIO_REGS) - (B.NUM_REGS * B.TAMANHO_MEDIO_REGS)) 
GROUP BY C.OWNER,C.TABELA
ORDER BY (SUM ((A.NUM_REGS * A.TAMANHO_MEDIO_REGS) - (B.NUM_REGS * B.TAMANHO_MEDIO_REGS))) DESC 
;

SELECT '#### Tabelas que DIMINUIRAM, no período &dat1 à &dat2' FROM DUAL;
SELECT C.TABELA||' '||to_char(SUM ((A.NUM_REGS * A.TAMANHO_MEDIO_REGS) - (B.NUM_REGS * B.TAMANHO_MEDIO_REGS)),'999,999,999,999')||' bytes' 
FROM ANALYZ_TABELAS A, ANALYZ_TABELAS B, TABELAS C
WHERE 	A.OWNER=B.OWNER AND A.TABELA=B.TABELA AND C.OWNER=B.OWNER AND C.TABELA=B.TABELA AND
	to_char(B.DATA_ANALYZ,'YYYY/MM/DD') = '&dat1' AND
	to_char(A.DATA_ANALYZ,'YYYY/MM/DD') = '&dat2' AND
	0 > ((A.NUM_REGS * A.TAMANHO_MEDIO_REGS) - (B.NUM_REGS * B.TAMANHO_MEDIO_REGS)) 
GROUP BY C.OWNER,C.TABELA
ORDER BY (SUM ((A.NUM_REGS * A.TAMANHO_MEDIO_REGS) - (B.NUM_REGS * B.TAMANHO_MEDIO_REGS))) 
;

spool off
 