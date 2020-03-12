accept cpid char prompt 'Entre com o Numero do Job: '

select fp.os_process_id
from fnd_concurrent_processes fp,
     fnd_concurrent_requests fr
where fr.controlling_manager = fp.concurrent_process_id
  and fr.request_id = '&cpid'
/
