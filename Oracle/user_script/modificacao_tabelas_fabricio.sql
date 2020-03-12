Tabela  area_movimentacao_aeronave :
      	Campo val_primeiro_cadastro  - alterar para number(25,2).
	Campo val_ultima_atualizacao - alterar para number(25,2).

ALTER TABLE area_movimentacao_aeronave
MODIFY 	val_primeiro_cadastro number(25,2)
/
ALTER TABLE area_movimentacao_aeronave
MODIFY	val_ultima_atualizacao number(25,2)
/

Tabela  area_urbanizacao :
	Campo val_primeiro_cadastro  - alterar para number(25,2).
	Campo val_ultima_atualizacao  - alterar para number(25,2).

ALTER TABLE area_urbanizacao
MODIFY 	val_primeiro_cadastro number(25,2)
/
ALTER TABLE area_urbanizacao
MODIFY	val_ultima_atualizacao number(25,2)
/

Tabela   componentes_terreno :
	Campo area_m2 - alterar para number(11,2).

ALTER TABLE componentes_terreno
MODIFY AREA_M2 number(11,2)
/

Tabela  componente_cal_area_mov_aer :
      	Campo comprimento - alterar para number(6,2).

ALTER TABLE componente_cal_area_mov_aer
MODIFY	comprimento number(6,2)
/

Tabela  componente_cal_edificacao :
      	Campo val_custo_reproducao - alterar para number(25,2).
      	Campo area_util_m2  - alterar para number(9,2).
      	Campo capacidade_volume_m3  - alterar para number(9,2).
      	Campo val_custo_unitario_basico  - alterar para number(9,2).


ALTER TABLE componente_cal_edificacao
MODIFY	val_custo_reproducao number(25,2)
/
ALTER TABLE componente_cal_edificacao
MODIFY	area_util_m2 number(9,2)
/
ALTER TABLE componente_cal_edificacao
MODIFY	capacidade_volume_m3 number(9,2)
/
ALTER TABLE componente_cal_edificacao
MODIFY	val_custo_unitario_basico number(9,2)
/


Tabela  componente_cal_terreno :
      	Campo val_generico_m2 - alterar para number(9,2).
      	Campo area_total_m2  - alterar para number(11,2).

ALTER TABLE componente_cal_terreno
MODIFY	val_generico_m2 number(9,2)
/
ALTER TABLE componente_cal_terreno
MODIFY	area_total_m2 number(11,2)
/

Tabela  edificacao :
      	Campo area_coberta_m2 - alterar para number(9,2).
      	Campo val_primeiro_cadastro - alterar para number(25,2).
	Campo val_ultima_atualizacao  - alterar para number(25,2).
	
ALTER TABLE edificacao
MODIFY	area_coberta_m2 number(9,2)
/
ALTER TABLE edificacao
MODIFY	val_primeiro_cadastro number(25,2)
/
ALTER TABLE edificacao
MODIFY	val_ultima_atualizacao number(25,2)
/


Tabela  obra_realizada_benfeitoria :
      	Campo val_investimento  - alterar para number(25,2).

ALTER TABLE obra_realizada_benfeitoria
MODIFY	val_investimento number(25,2)
/


Tabela  tab_padrao_qualid_mater_benf :
      	Campo val_padrao_qualidade_material  - alterar para number(15,2).

ALTER TABLE tab_padrao_qualid_mater_benf
MODIFY	val_padrao_qualidade_material number(15,2)
/


Tabela  terreno_aeroporto :
      	Campo val_primeiro_cadastro  - alterar para number(25,2).
	Campo val_ultima_atualizacao  - alterar para number(25,2).
      	Campo area_infraero_m2  - alterar para number(11,2).

ALTER TABLE terreno_aeroporto
MODIFY	val_primeiro_cadastro number(25,2)
/
ALTER TABLE terreno_aeroporto
MODIFY	val_ultima_atualizacao number(25,2)
/
ALTER TABLE terreno_aeroporto
MODIFY	area_infraero_m2 number(11,2)
/

Tabela  valor_item_ocorr_benfeitoria :
      	Campo val_item  - alterar para number(15,2).


ALTER TABLE valor_item_ocorr_benfeitoria
MODIFY	val_item number(15,2)
/
