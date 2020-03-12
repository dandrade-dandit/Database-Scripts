accept id number prompt 'Entre com o ID do usuario: '

select osuser
from v$session
where sid = &id
/
