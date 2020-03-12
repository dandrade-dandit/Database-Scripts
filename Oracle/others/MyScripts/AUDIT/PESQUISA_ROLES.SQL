select GRANTED_ROLE "Perfil"
,      Count(1) "Total de Usuários por Perfil"
From   dba_role_privs
where  GRANTED_ROLE Like '%CON%'
and    GRANTEE NOT IN ('SYS', 'SYSTEM', 'SYSMAN', 'PUBLIC')
GROUP BY GRANTED_ROLE
ORDER BY 1, 2
/

SELECT * FROM DBA_ROLES
WHERE ROLE LIKE '%CON%'
ORDER BY 1
/


select GRANTED_ROLE "Perfil"
,      Count(1) "Total de Usuários por Perfil"
From   dba_role_privs
where  (GRANTED_ROLE NOT Like '%MAX%'
and GRANTED_ROLE NOT Like '%PAT%'
and GRANTED_ROLE NOT Like '%SST%'
and GRANTED_ROLE NOT Like '%RH%'
and GRANTED_ROLE NOT Like '%MAT%'
and GRANTED_ROLE NOT Like '%LIC%'
and GRANTED_ROLE NOT Like '%ORC%'
and GRANTED_ROLE NOT Like '%BDE%'
and GRANTED_ROLE NOT Like '%SGP%'
and GRANTED_ROLE NOT Like '%SIAD%'
and GRANTED_ROLE NOT Like '%SIMBE%'
and GRANTED_ROLE NOT Like '%SICAE%'
and GRANTED_ROLE NOT Like '%AGENDA%'
and GRANTED_ROLE NOT Like '%TSR%'
and GRANTED_ROLE NOT Like '%NOTES%'
and GRANTED_ROLE NOT Like '%SGS%'
and GRANTED_ROLE NOT Like '%TES%'
and GRANTED_ROLE NOT Like '%SEG%'
and GRANTED_ROLE NOT Like '%SICOF%'
and GRANTED_ROLE NOT Like '%CON%'
and GRANTED_ROLE NOT Like '%SELO%')
GROUP BY GRANTED_ROLE
ORDER BY 1, 2
/

SELECT * FROM DBA_ROLES
WHERE ROLE LIKE '%MAX%'
ORDER BY 1
/
