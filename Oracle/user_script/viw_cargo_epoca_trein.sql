-- View VIW_CARGO_EPOCA_TREIN

CREATE OR REPLACE VIEW ifrhumanus.viw_cargo_epoca_trein (
   sequencial,
   matricula,
   car_sigla,
   occ_codigo,
   occ_descricao )
AS
select trn.eve_seq,
	   oco_car.oem_emp_numero_matricula,
	   car.car_sigla,
	   occ.occ_codigo,
       occ.occ_descricao
from ocorrencias_empregados oco_car,
     cargos car,
     ocupacoes_cargo occ,
	 trn_evento trn,
     trn_evento_particip part
where trn.eve_seq = part.evp_eve_seq
      and oco_car.oem_emp_numero_matricula = part.evpemp_numero_matricula
      and oco_car.oem_car_codigo = car.car_codigo
      and oco_car.oem_car_codigo_nivel = car.car_codigo_nivel
      and oco_car.oem_car_occ_codigo = car.car_occ_codigo
      and oco_car.oem_car_occ_codigo = occ.occ_codigo
      and oco_car.oem_data_inicio =
                (select max(oco_car2.oem_data_inicio)
                   from ocorrencias_empregados oco_car2
                   where oco_car2.oem_ofu_codigo in (265,213,259,196,200,202,257,260,194,195,197,198)
                         and oco_car2.oem_data_inicio <= trn.eve_dat_inicio
                         and oco_car2.oem_emp_numero_matricula = oco_car.oem_emp_numero_matricula
                         and oco_car2.oem_car_codigo is not null
                         and oco_car2.oem_car_codigo_nivel is not null
                         and oco_car2.oem_car_occ_codigo is not null)
      and oco_car.oem_ofu_codigo in (265,213,259,196,200,202,257,260,194,195,197,198)
      and oco_car.oem_data_inicio <= trn.eve_dat_inicio
/
-- Grants for View
GRANT SELECT ON ifrhumanus.viw_cargo_epoca_trein TO srh_trn_01
/
GRANT SELECT ON ifrhumanus.viw_cargo_epoca_trein TO srh_trn_02
/
GRANT SELECT ON ifrhumanus.viw_cargo_epoca_trein TO srh_trn_03
/


