grant execute on atualiza_sequencia_rub to RH_PERFIL_99
/
grant execute on atualiza_sequencia_rub to SRH_SFP_01
/
grant execute on atualiza_sequencia_rub to SRH_SFP_03
/
grant execute on atualiza_sequencia_rub to SRH_SFP_04
/

create public synonym ATUALIZA_SEQUENCIA_RUB for ifrsrh.atualiza_sequencia_rub
/

insert into tabelas values ('SRHCAD', 'ATUALIZA_SEQUENCIA_RUB','IFRSRH', 'procudure')
/