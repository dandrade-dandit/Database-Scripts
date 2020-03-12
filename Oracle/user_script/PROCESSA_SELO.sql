CREATE OR REPLACE
Procedure IFRSELO.processa_selo (par_dep number) is
   cursor c_selo is
     select ls.serie_selo, ls.num_selo, ls.cod_motivo,
            ls.dat_leitura_selo, ls.dep_codigo_leitura, ls.rowid
     from   leitura_selos ls, recibo_tarifas_embarque rte
     where  ls.serie_selo         = rte.serie_selo
     and    ls.num_selo           = rte.num_selo
     and    ls.dep_codigo_leitura = par_dep;

     r_selo     c_selo%rowtype;

   cursor c_selo_s is
     select ls.serie_selo, ls.num_selo, ls.cod_motivo,
            ls.dat_leitura_selo, ls.dep_codigo_leitura, ls.rowid
     from   leitura_selos ls
     where  ls.dep_codigo_leitura = par_dep;

     r_selo_s           c_selo_s%rowtype;
     v_data_inclusao    date;
     v_data_inclusao2   date;
     v_dt_fechamento    date;
     v_data1            date;
     v_data2            date;
     v_hh2              number;
     v_hh1              number;
     v_mi2              number;
     v_mi1              number;
     v_ss2              number;
     v_ss1              number;
     v_hora             number;
     v_tot1             number := 0;
     v_tot2             number := 0;
     v_temp             number := 0;
     v_motivo           hst_leitura_selos.cod_motivo%type;

--------------------------------------------------------------------------
--                 Atribui valor ao operando CARGHORMEN                 --
--------------------------------------------------------------------------
Procedure trata_hora is
Begin
   v_data1  := to_date(to_char(v_data_inclusao,'dd/mm/yyyy'));
   v_data2  := to_date(to_char(v_data_inclusao2,'dd/mm/yyyy'));
   v_hora   := (((trunc(v_data_inclusao2) - trunc(v_data_inclusao)) * 24) * 60) * 60;
   v_hh1    := to_number(to_char(v_data_inclusao,'hh24'));
   v_hh2    := to_number(to_char(v_data_inclusao2,'hh24'));
   v_mi1    := to_number(to_char(v_data_inclusao,'mi'));
   v_mi2    := to_number(to_char(v_data_inclusao2,'mi'));
   v_ss1    := to_number(to_char(v_data_inclusao,'ss'));
   v_ss2    := to_number(to_char(v_data_inclusao2,'ss'));
   v_tot1   := ((v_hh1 * 60) * 60) + (v_mi1 * 60) + v_ss1;
   v_tot2   := ((v_hh2 * 60) * 60) + (v_mi2 * 60) + v_ss2;
   v_temp   :=  (v_hora - ((v_tot2 - v_tot1) * -1));

End;

--**********************************************************************--
--**                INÍCIO DA PROCEDURE PRINCIPAL                     **--
--**********************************************************************--
Begin
    for r_selo in c_selo loop
      begin
         v_data_inclusao2 := r_selo.dat_leitura_selo;
         insert into hst_leitura_selos (serie_selo, num_selo, cod_motivo,
                                        dat_leitura_selo, dep_codigo_leitura)
                values(r_selo.serie_selo, r_selo.num_selo, r_selo.cod_motivo,
                       r_selo.dat_leitura_selo, r_selo.dep_codigo_leitura);
      exception
         when others then
           if sqlcode = -1 then
              begin
                 select cod_motivo, dt_fechamento
                 into   v_motivo, v_dt_fechamento
                 from   hst_leitura_selos
                 where  serie_selo = r_selo.serie_selo
                 and    num_selo   = r_selo.num_selo;
              end;
              if v_motivo = 1 then
                 if v_dt_fechamento is null then
                 update hst_leitura_selos
                 set    cod_motivo         = r_selo.cod_motivo,
                        dat_leitura_selo   = r_selo.dat_leitura_selo,
                        dep_codigo_leitura = r_selo.dep_codigo_leitura
                 where  serie_selo = r_selo.serie_selo
                 and    num_selo   =  r_selo.num_selo;
                 else
                    begin
                       insert into discrepancias_selos (dat_leitura_selo, dep_cod_leitura,
                                                        serie_selo, num_selo, desc_motivo)
                              values(r_selo.dat_leitura_selo, r_selo.dep_codigo_leitura,
                                     r_selo.serie_selo, r_selo.num_selo, 'Selo Faturado');
                    exception
                       when others then
                          null;
                    end;

                 end if;
              else
                 select dat_leitura_selo
                 into   v_data_inclusao
                 from   hst_leitura_selos
                 where  serie_selo = r_selo.serie_selo
                 and    num_selo   = r_selo.num_selo;
                 trata_hora;
                 if v_temp > 43200 then
                    begin
                       insert into discrepancias_selos (dat_leitura_selo, dep_cod_leitura,
                                                        serie_selo, num_selo, desc_motivo)
                              values(r_selo.dat_leitura_selo, r_selo.dep_codigo_leitura,
                                     r_selo.serie_selo, r_selo.num_selo, 'Leitura Duplicada');
                    exception
                       when others then
                          null;
                    end;
                 end if;
              end if;
           end if;
      end;
      delete leitura_selos
      where  rowid = r_selo.rowid;
   end loop;
   for r_selo_s in c_selo_s loop
      begin
         insert into discrepancias_selos (dat_leitura_selo, dep_cod_leitura,
                                          serie_selo, num_selo, desc_motivo)
                values(r_selo_s.dat_leitura_selo, r_selo_s.dep_codigo_leitura,
                       r_selo_s.serie_selo, r_selo_s.num_selo, 'Selo Inexistente');
      exception
         when others then
            null;
      end;
      delete leitura_selos
      where  rowid = r_selo_s.rowid;
   end loop;
End;
/
