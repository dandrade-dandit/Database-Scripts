DROP TABLE movimentacao
/

-- Table MOVIMENTACAO

CREATE TABLE movimentacao
 (
  mov_ano_referencia         NUMBER(4) NOT NULL,
  mov_mes_referencia         NUMBER(2) NOT NULL,
  mov_versao_pagamento       NUMBER(2) NOT NULL,
  mov_emp_numero_matricula   NUMBER(7) NOT NULL,
  mov_rub_codigo             NUMBER(4) NOT NULL,
  mov_sequencial             NUMBER(2) NOT NULL,
  mov_parcela                NUMBER(3) NOT NULL,
  mov_parcela_atual          NUMBER(3) NOT NULL,
  mov_rub_seq_pagamento      NUMBER(3) NOT NULL,
  mov_emp_dep_codigo_pagto   NUMBER(4) NOT NULL,
  mov_tip_rubrica            VARCHAR2(1) NOT NULL,
  mov_ind_calculo            VARCHAR2(1) NOT NULL,
  mov_ind_exclusivo          VARCHAR2(1) NOT NULL,
  mov_for_codigo             NUMBER(3),
  mov_parametro              NUMBER(14,6),
  mov_valor                  NUMBER(11,2),
  mov_ano_ref_diferenca      NUMBER(4),
  mov_mes_ref_diferenca      NUMBER(2),
  mov_pen_codigo             NUMBER(2),
  mov_pkt_codigo_pedido      NUMBER,
  mov_valor_integral         NUMBER(11,2),
  mov_fun_codigo             NUMBER(3),
  mov_dias_proporcionalidade  NUMBER(3) DEFAULT 30,
  mov_nsa_codigo_nivel       NUMBER(2),
  mov_oem_emp_numero_matricula  NUMBER(7),
  mov_oem_ofu_codigo         NUMBER(4),
  mov_oem_data_inicio        DATE,
  mov_data_calculo           DATE,
  mov_pem_ben_sigla          VARCHAR2(3),
  mov_tipo_funcao            VARCHAR2(2),
  mov_tipo_parametro         VARCHAR2(1),
  mov_ind_13                 VARCHAR2(1),
  mov_ind_arsaprev           VARCHAR2(1),
  mov_ind_lancamento_liq_negat  VARCHAR2(1),
  mov_nsa_codigo_padrao      VARCHAR2(4),
  mov_nsa_indicador_nivel_escola  VARCHAR2(1),
  mov_flg_frequencia         VARCHAR2(1) DEFAULT 'N'
 )
 TABLESPACE ts_selo
 STORAGE   (
      INITIAL     662773760
      NEXT        52428800
      PCTINCREASE 0
      MINEXTENTS  1
      MAXEXTENTS  5
   )
/
