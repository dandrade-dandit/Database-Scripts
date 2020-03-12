CREATE OR REPLACE
Procedure IFRSELO.insere_distribuicao_selos(      par_seq_rste    in number,
                                   par_serie_selo  in char,
                                   par_num_selo_i  in number,
                                   par_num_selo_f  in number,
                                   par_data        in date,
                                   par_cia_aerea   in char,
                                   par_dependencia in number) is
Begin

for i in par_num_selo_i .. par_num_selo_f
  loop
      insert into recibo_tarifas_embarque
         (seq_rste,serie_selo,num_selo, dat_entrega_selo,cia_cd_cia_aerea, dep_codigo)
      values(par_seq_rste,par_serie_selo,i,
             par_data,par_cia_aerea,par_dependencia);
  end loop;
  commit;
End;
/
