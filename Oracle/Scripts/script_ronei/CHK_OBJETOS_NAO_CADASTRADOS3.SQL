-- parametrização necessaria
 set pause off
 set heading off
 set echo off
 set verify off
 SET FEEDBACK OFF
 SET PAGESIZE 1000
 SET linesize 1000
 SET SERVEROUTPUT ON SIZE 1000000

SPOOL C:\Sistemas\Sql\Infraero\Oracle\Scripts\script_ronei\LOG_OBJETOS_NAO_CADASTRADOS.LOG

DECLARE
 virg       varchar2(1);
 my_own     dba_tab_columns.owner%type;
 my_tab     dba_tab_columns.table_name%type;

 cursor c1 is
SELECT A.TABLE_NAME,A.OWNER
FROM DBA_TABLES A
WHERE 	A.OWNER IN (	'IFRCLIM',
					'IFRDBA2',
					'IFRHUMANUS',
					'IFRMAXIMO',
					'IFRSELO',
					'IFRSGP',
					'IFRSRH',
					'IFRVGA',
					'IFR_DESENV',
					'MONIT',
					'OPERACAO',
					'IFRBDE',
					'IFRBDE_VIEWS',
					'IFRBANCO',
					'SST'
				) AND
	A.OWNER||A.TABLE_NAME NOT IN (SELECT B.OWNER||B.TABELA
				    FROM IFRBANCO.TABELAS B
				    WHERE B.OWNER=A.OWNER AND
					  B.TABELA=A.TABLE_NAME AND
 					  B.TIPO='TABELA')
ORDER BY A.OWNER,A.TABLE_NAME;

--'INSERT INTO IFRBANCO.TABELAS VALUES',
--       '(''OOOOOO'','''||A.VIEW_NAME||''','''||A.OWNER||''',''VIEW'');'

 cursor c2 is
SELECT A.VIEW_NAME,A.OWNER
FROM DBA_VIEWS A
WHERE 	A.OWNER IN (	'IFRCLIM',
					'IFRDBA2',
					'IFRHUMANUS',
					'IFRMAXIMO',
					'IFRSELO',
					'IFRSGP',
					'IFRSRH',
					'IFRVGA',
					'IFR_DESENV',
					'MONIT',
					'OPERACAO',
					'IFRBDE',
					'IFRBDE_VIEWS',
					'IFRBANCO',
					'SST'
				) AND
	A.OWNER||A.VIEW_NAME NOT IN (SELECT B.OWNER||B.TABELA
				    FROM IFRBANCO.TABELAS B
				    WHERE B.OWNER=A.OWNER AND
					  B.TABELA=A.VIEW_NAME AND
 					  B.TIPO='VIEW')
ORDER BY A.OWNER,A.VIEW_NAME;

 cursor c3 is
SELECT A.SEQUENCE_NAME,A.SEQUENCE_OWNER
FROM DBA_SEQUENCES A
WHERE 	A.SEQUENCE_OWNER IN (	'IFRCLIM',
					'IFRDBA2',
					'IFRHUMANUS',
					'IFRMAXIMO',
					'IFRSELO',
					'IFRSGP',
					'IFRSRH',
					'IFRVGA',
					'IFR_DESENV',
					'MONIT',
					'OPERACAO',
					'IFRBDE',
					'IFRBDE_VIEWS',
					'IFRBANCO',
					'SST'
				) AND
	A.SEQUENCE_OWNER||A.SEQUENCE_NAME NOT IN (SELECT B.OWNER||B.TABELA
				    FROM IFRBANCO.TABELAS B
				    WHERE B.OWNER=A.SEQUENCE_OWNER AND
					  B.TABELA=A.SEQUENCE_NAME AND
 					  B.TIPO='SEQUENCE')
ORDER BY A.SEQUENCE_OWNER,A.SEQUENCE_NAME;

 cursor c4 is
SELECT A.NAME,A.OWNER
FROM DBA_SOURCE A
WHERE 	A.OWNER IN (	'IFRCLIM',
					'IFRDBA2',
					'IFRHUMANUS',
					'IFRMAXIMO',
					'IFRSELO',
					'IFRSGP',
					'IFRSRH',
					'IFRVGA',
					'IFR_DESENV',
					'MONIT',
					'OPERACAO',
					'IFRBDE',
					'IFRBDE_VIEWS',
					'IFRBANCO',
					'SST'
				) AND
	A.OWNER||A.NAME NOT IN (SELECT B.OWNER||B.TABELA
				FROM IFRBANCO.TABELAS B
				WHERE B.OWNER=A.OWNER AND
				      B.TABELA=A.NAME AND
 				      B.TIPO='FUNCTION')
GROUP BY A.OWNER,A.NAME
ORDER BY A.OWNER,A.NAME;

 cursor c5 is
SELECT A.NAME,A.OWNER
FROM DBA_SOURCE A
WHERE 	A.OWNER IN (	'IFRCLIM',
					'IFRDBA2',
					'IFRHUMANUS',
					'IFRMAXIMO',
					'IFRSELO',
					'IFRSGP',
					'IFRSRH',
					'IFRVGA',
					'IFR_DESENV',
					'MONIT',
					'OPERACAO',
					'IFRBDE',
					'IFRBDE_VIEWS',
					'IFRBANCO',
					'SST'
				) AND
	A.OWNER||A.NAME NOT IN (SELECT B.OWNER||B.TABELA
				FROM IFRBANCO.TABELAS B
				WHERE B.OWNER=A.OWNER AND
				      B.TABELA=A.NAME AND
 				      B.TIPO='PROCEDURE')
GROUP BY A.OWNER,A.NAME
ORDER BY A.OWNER,A.NAME;

 cursor c6 is
SELECT A.NAME,A.OWNER
FROM DBA_SOURCE A
WHERE 	A.OWNER IN (	'IFRCLIM',
					'IFRDBA2',
					'IFRHUMANUS',
					'IFRMAXIMO',
					'IFRSELO',
					'IFRSGP',
					'IFRSRH',
					'IFRVGA',
					'IFR_DESENV',
					'MONIT',
					'OPERACAO',
					'IFRBDE',
					'IFRBDE_VIEWS',
					'IFRBANCO',
					'SST'
				) AND
	A.OWNER||A.NAME NOT IN (SELECT B.OWNER||B.TABELA
				FROM IFRBANCO.TABELAS B
				WHERE B.OWNER=A.OWNER AND
				      B.TABELA=A.NAME AND
 				      B.TIPO='PACKAGE')
GROUP BY A.OWNER,A.NAME
ORDER BY A.OWNER,A.NAME;

 cursor c7 is
SELECT A.NAME,A.OWNER
FROM DBA_SOURCE A
WHERE 	A.OWNER IN (	'IFRCLIM',
					'IFRDBA2',
					'IFRHUMANUS',
					'IFRMAXIMO',
					'IFRSELO',
					'IFRSGP',
					'IFRSRH',
					'IFRVGA',
					'IFR_DESENV',
					'MONIT',
					'OPERACAO',
					'IFRBDE',
					'IFRBDE_VIEWS',
					'IFRBANCO',
					'SST'
				) AND
	A.OWNER||A.NAME NOT IN (SELECT B.OWNER||B.TABELA
				FROM IFRBANCO.TABELAS B
				WHERE B.OWNER=A.OWNER AND
				      B.TABELA=A.NAME AND
 				      B.TIPO='PACKAGE BODY')
GROUP BY A.OWNER,A.NAME
ORDER BY A.OWNER,A.NAME;


BEGIN 

-- IFRBANCO.TABELAS
 OPEN C1;
 LOOP
    FETCH C1 inTO my_tab, my_own;
       EXIT WHEN C1%NOTFOUND;
        dbms_output.put_line ('INSERT INTO IFRBANCO.TABELAS VALUES');
        IF my_own = 'IFRCLIM' then 
            dbms_output.put ('(''BDCLIM'',''');
	  end if;
        IF my_own = 'IFRDBA2' then 
            dbms_output.put ('(''SIXXX'',''');
	  end if;
        IF my_own = 'IFRHUMANUS' then 
            dbms_output.put ('(''HUMANUS'',''');
	  end if;
        IF my_own = 'IFRMAXIMO' then 
            dbms_output.put ('(''MAXIMO'',''');
	  end if;
        IF my_own = 'IFRSELO' then 
            dbms_output.put ('(''SISELO'',''');
	  end if;
        IF my_own = 'IFRSGP' then 
            dbms_output.put ('(''SGP'',''');
	  end if;
        IF my_own = 'IFRSRH' then 
            dbms_output.put ('(''SRHXXX'',''');
	  end if;
        IF my_own = 'IFRVGA' then 
            dbms_output.put ('(''SEGUROS'',''');
	  end if;
        IF my_own = 'IFR_DESENV' then 
            dbms_output.put ('(''DESENV'',''');
	  end if;
        IF my_own = 'MONIT' then 
            dbms_output.put ('(''MONIT'',''');
	  end if;
        IF my_own = 'OPERACAO' then 
            dbms_output.put ('(''OPERACAO'',''');
	  end if;
        IF my_own = 'SST' then 
            dbms_output.put ('(''SST'',''');
	  end if;
        IF my_own = 'IFRBDE' or my_own = 'IFRBDE_VIEWS' then 
            dbms_output.put ('(''BDE'',''');
	  end if;
        IF my_own = 'IFRBANCO' then 
            dbms_output.put ('(''BANCO'',''');
	  end if;
        dbms_output.put (my_tab||''',''');
	  dbms_output.put_line (my_own||''',''TABELA'');');
 END LOOP;
 CLOSE C1;

-- VIEWs
 OPEN C2;
 LOOP
    FETCH C2 inTO my_tab, my_own;
       EXIT WHEN C2%NOTFOUND;
        dbms_output.put_line ('INSERT INTO IFRBANCO.TABELAS VALUES');
        IF my_own = 'IFRCLIM' then 
            dbms_output.put ('(''BDCLIM'',''');
	  end if;
        IF my_own = 'IFRDBA2' then 
            dbms_output.put ('(''SIXXX'',''');
	  end if;
        IF my_own = 'IFRHUMANUS' then 
            dbms_output.put ('(''HUMANUS'',''');
	  end if;
        IF my_own = 'IFRMAXIMO' then 
            dbms_output.put ('(''MAXIMO'',''');
	  end if;
        IF my_own = 'IFRSELO' then 
            dbms_output.put ('(''SISELO'',''');
	  end if;
        IF my_own = 'IFRSGP' then 
            dbms_output.put ('(''SGP'',''');
	  end if;
        IF my_own = 'IFRSRH' then 
            dbms_output.put ('(''SRHXXX'',''');
	  end if;
        IF my_own = 'IFRVGA' then 
            dbms_output.put ('(''SEGUROS'',''');
	  end if;
        IF my_own = 'IFR_DESENV' then 
            dbms_output.put ('(''DESENV'',''');
	  end if;
        IF my_own = 'MONIT' then 
            dbms_output.put ('(''MONIT'',''');
	  end if;
        IF my_own = 'OPERACAO' then 
            dbms_output.put ('(''OPERACAO'',''');
	  end if;
        IF my_own = 'SST' then 
            dbms_output.put ('(''SST'',''');
	  end if;
        IF my_own = 'IFRBDE' or my_own = 'IFRBDE_VIEWS' then 
            dbms_output.put ('(''BDE'',''');
	  end if;
        IF my_own = 'IFRBANCO' then 
            dbms_output.put ('(''BANCO'',''');
	  end if;
        dbms_output.put (my_tab||''',''');
	  dbms_output.put_line (my_own||''',''VIEW'');');
 END LOOP;
 CLOSE C2;

-- SEQUENCEs
 OPEN C3;
 LOOP
    FETCH C3 inTO my_tab, my_own;
       EXIT WHEN C3%NOTFOUND;
        dbms_output.put_line ('INSERT INTO IFRBANCO.TABELAS VALUES');
        IF my_own = 'IFRCLIM' then 
            dbms_output.put ('(''BDCLIM'',''');
	  end if;
        IF my_own = 'IFRDBA2' then 
            dbms_output.put ('(''SIXXX'',''');
	  end if;
        IF my_own = 'IFRHUMANUS' then 
            dbms_output.put ('(''HUMANUS'',''');
	  end if;
        IF my_own = 'IFRMAXIMO' then 
            dbms_output.put ('(''MAXIMO'',''');
	  end if;
        IF my_own = 'IFRSELO' then 
            dbms_output.put ('(''SISELO'',''');
	  end if;
        IF my_own = 'IFRSGP' then 
            dbms_output.put ('(''SGP'',''');
	  end if;
        IF my_own = 'IFRSRH' then 
            dbms_output.put ('(''SRHXXX'',''');
	  end if;
        IF my_own = 'IFRVGA' then 
            dbms_output.put ('(''SEGUROS'',''');
	  end if;
        IF my_own = 'IFR_DESENV' then 
            dbms_output.put ('(''DESENV'',''');
	  end if;
        IF my_own = 'MONIT' then 
            dbms_output.put ('(''MONIT'',''');
	  end if;
        IF my_own = 'OPERACAO' then 
            dbms_output.put ('(''OPERACAO'',''');
	  end if;
        IF my_own = 'SST' then 
            dbms_output.put ('(''SST'',''');
	  end if;
        IF my_own = 'IFRBDE' or my_own = 'IFRBDE_VIEWS' then 
            dbms_output.put ('(''BDE'',''');
	  end if;
        IF my_own = 'IFRBANCO' then 
            dbms_output.put ('(''BANCO'',''');
	  end if;
        dbms_output.put (my_tab||''',''');
	  dbms_output.put_line (my_own||''',''SEQUENCE'');');
 END LOOP;
 CLOSE C3;

--FUNCTIONs
 OPEN C4;
 LOOP
    FETCH C4 inTO my_tab, my_own;
       EXIT WHEN C4%NOTFOUND;
        dbms_output.put_line ('INSERT INTO IFRBANCO.TABELAS VALUES');
        IF my_own = 'IFRCLIM' then 
            dbms_output.put ('(''BDCLIM'',''');
	  end if;
        IF my_own = 'IFRDBA2' then 
            dbms_output.put ('(''SIXXX'',''');
	  end if;
        IF my_own = 'IFRHUMANUS' then 
            dbms_output.put ('(''HUMANUS'',''');
	  end if;
        IF my_own = 'IFRMAXIMO' then 
            dbms_output.put ('(''MAXIMO'',''');
	  end if;
        IF my_own = 'IFRSELO' then 
            dbms_output.put ('(''SISELO'',''');
	  end if;
        IF my_own = 'IFRSGP' then 
            dbms_output.put ('(''SGP'',''');
	  end if;
        IF my_own = 'IFRSRH' then 
            dbms_output.put ('(''SRHXXX'',''');
	  end if;
        IF my_own = 'IFRVGA' then 
            dbms_output.put ('(''SEGUROS'',''');
	  end if;
        IF my_own = 'IFR_DESENV' then 
            dbms_output.put ('(''DESENV'',''');
	  end if;
        IF my_own = 'MONIT' then 
            dbms_output.put ('(''MONIT'',''');
	  end if;
        IF my_own = 'OPERACAO' then 
            dbms_output.put ('(''OPERACAO'',''');
	  end if;
        IF my_own = 'SST' then 
            dbms_output.put ('(''SST'',''');
	  end if;
        IF my_own = 'IFRBDE' or my_own = 'IFRBDE_VIEWS' then 
            dbms_output.put ('(''BDE'',''');
	  end if;
        IF my_own = 'IFRBANCO' then 
            dbms_output.put ('(''BANCO'',''');
	  end if;
       dbms_output.put (my_tab||''',''');
	  dbms_output.put_line (my_own||''',''FUNCTION'');');
 END LOOP;
 CLOSE C4;

--PROCEDUREs
 OPEN C5;
 LOOP
    FETCH C5 inTO my_tab, my_own;
       EXIT WHEN C5%NOTFOUND;
        dbms_output.put_line ('INSERT INTO IFRBANCO.TABELAS VALUES');
        IF my_own = 'IFRCLIM' then 
            dbms_output.put ('(''BDCLIM'',''');
	  end if;
        IF my_own = 'IFRDBA2' then 
            dbms_output.put ('(''SIXXX'',''');
	  end if;
        IF my_own = 'IFRHUMANUS' then 
            dbms_output.put ('(''HUMANUS'',''');
	  end if;
        IF my_own = 'IFRMAXIMO' then 
            dbms_output.put ('(''MAXIMO'',''');
	  end if;
        IF my_own = 'IFRSELO' then 
            dbms_output.put ('(''SISELO'',''');
	  end if;
        IF my_own = 'IFRSGP' then 
            dbms_output.put ('(''SGP'',''');
	  end if;
        IF my_own = 'IFRSRH' then 
            dbms_output.put ('(''SRHXXX'',''');
	  end if;
        IF my_own = 'IFRVGA' then 
            dbms_output.put ('(''SEGUROS'',''');
	  end if;
        IF my_own = 'IFR_DESENV' then 
            dbms_output.put ('(''DESENV'',''');
	  end if;
        IF my_own = 'MONIT' then 
            dbms_output.put ('(''MONIT'',''');
	  end if;
        IF my_own = 'OPERACAO' then 
            dbms_output.put ('(''OPERACAO'',''');
	  end if;
        IF my_own = 'SST' then 
            dbms_output.put ('(''SST'',''');
	  end if;
        IF my_own = 'IFRBDE' or my_own = 'IFRBDE_VIEWS' then 
            dbms_output.put ('(''BDE'',''');
	  end if;
        IF my_own = 'IFRBANCO' then 
            dbms_output.put ('(''BANCO'',''');
	  end if;
       dbms_output.put (my_tab||''',''');
	  dbms_output.put_line (my_own||''',''PROCEDURE'');');
 END LOOP;
 CLOSE C5;

--PACKAGEs
 OPEN C6;
 LOOP
    FETCH C6 inTO my_tab, my_own;
       EXIT WHEN C6%NOTFOUND;
        dbms_output.put_line ('INSERT INTO IFRBANCO.TABELAS VALUES');
        IF my_own = 'IFRCLIM' then 
            dbms_output.put ('(''BDCLIM'',''');
	  end if;
        IF my_own = 'IFRDBA2' then 
            dbms_output.put ('(''SIXXX'',''');
	  end if;
        IF my_own = 'IFRHUMANUS' then 
            dbms_output.put ('(''HUMANUS'',''');
	  end if;
        IF my_own = 'IFRMAXIMO' then 
            dbms_output.put ('(''MAXIMO'',''');
	  end if;
        IF my_own = 'IFRSELO' then 
            dbms_output.put ('(''SISELO'',''');
	  end if;
        IF my_own = 'IFRSGP' then 
            dbms_output.put ('(''SGP'',''');
	  end if;
        IF my_own = 'IFRSRH' then 
            dbms_output.put ('(''SRHXXX'',''');
	  end if;
        IF my_own = 'IFRVGA' then 
            dbms_output.put ('(''SEGUROS'',''');
	  end if;
        IF my_own = 'IFR_DESENV' then 
            dbms_output.put ('(''DESENV'',''');
	  end if;
        IF my_own = 'MONIT' then 
            dbms_output.put ('(''MONIT'',''');
	  end if;
        IF my_own = 'OPERACAO' then 
            dbms_output.put ('(''OPERACAO'',''');
	  end if;
        IF my_own = 'SST' then 
            dbms_output.put ('(''SST'',''');
	  end if;
        IF my_own = 'IFRBDE' or my_own = 'IFRBDE_VIEWS' then 
            dbms_output.put ('(''BDE'',''');
	  end if;
        IF my_own = 'IFRBANCO' then 
            dbms_output.put ('(''BANCO'',''');
	  end if;
        dbms_output.put (my_tab||''',''');
	  dbms_output.put_line (my_own||''',''PACKAGE'');');
 END LOOP;
 CLOSE C6;

--PACKAGE BODYs
 OPEN C7;
 LOOP
    FETCH C7 inTO my_tab, my_own;
       EXIT WHEN C7%NOTFOUND;
        dbms_output.put_line ('INSERT INTO IFRBANCO.TABELAS VALUES');
        IF my_own = 'IFRCLIM' then 
            dbms_output.put ('(''BDCLIM'',''');
	  end if;
        IF my_own = 'IFRDBA2' then 
            dbms_output.put ('(''SIXXX'',''');
	  end if;
        IF my_own = 'IFRHUMANUS' then 
            dbms_output.put ('(''HUMANUS'',''');
	  end if;
        IF my_own = 'IFRMAXIMO' then 
            dbms_output.put ('(''MAXIMO'',''');
	  end if;
        IF my_own = 'IFRSELO' then 
            dbms_output.put ('(''SISELO'',''');
	  end if;
        IF my_own = 'IFRSGP' then 
            dbms_output.put ('(''SGP'',''');
	  end if;
        IF my_own = 'IFRSRH' then 
            dbms_output.put ('(''SRHXXX'',''');
	  end if;
        IF my_own = 'IFRVGA' then 
            dbms_output.put ('(''SEGUROS'',''');
	  end if;
        IF my_own = 'IFR_DESENV' then 
            dbms_output.put ('(''DESENV'',''');
	  end if;
        IF my_own = 'MONIT' then 
            dbms_output.put ('(''MONIT'',''');
	  end if;
        IF my_own = 'OPERACAO' then 
            dbms_output.put ('(''OPERACAO'',''');
	  end if;
        IF my_own = 'SST' then 
            dbms_output.put ('(''SST'',''');
	  end if;
        IF my_own = 'IFRBDE' or my_own = 'IFRBDE_VIEWS' then 
            dbms_output.put ('(''BDE'',''');
	  end if;
        IF my_own = 'IFRBANCO' then 
            dbms_output.put ('(''BANCO'',''');
	  end if;
       dbms_output.put (my_tab||''',''');
	  dbms_output.put_line (my_own||''',''PACKAGE BODY'');');
 END LOOP;
 CLOSE C7;
 END;
/
SPOOL OFF