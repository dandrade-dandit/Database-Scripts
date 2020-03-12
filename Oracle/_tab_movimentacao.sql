CREATE TABLE ifrsrh2.movimentacao
    (mov_ano_referencia             NUMBER(4,0) NOT NULL,
    mov_mes_referencia             NUMBER(2,0) NOT NULL,
    mov_versao_pagamento           NUMBER(2,0) NOT NULL,
    mov_emp_numero_matricula       NUMBER(7,0) NOT NULL,
    mov_rub_codigo                 NUMBER(4,0) NOT NULL,
    mov_sequencial                 NUMBER(2,0) NOT NULL,
    mov_parcela                    NUMBER(3,0),
    mov_parcela_atual              NUMBER(3,0),
    mov_rub_seq_pagamento          NUMBER(3,0),
    mov_emp_dep_codigo_pagto       NUMBER(4,0),
    mov_tip_rubrica                VARCHAR2(1) NOT NULL,
    mov_ind_calculo                VARCHAR2(1),
    mov_ind_exclusivo              VARCHAR2(1),
    mov_for_codigo                 NUMBER(3,0),
    mov_parametro                  NUMBER(14,6),
    mov_valor                      NUMBER(11,2),
    mov_ano_ref_diferenca          NUMBER(4,0),
    mov_mes_ref_diferenca          NUMBER(2,0),
    mov_pen_codigo                 NUMBER(2,0),
    mov_pkt_codigo_pedido          NUMBER,
    mov_valor_integral             NUMBER(11,2),
    mov_fun_codigo                 NUMBER(3,0),
    mov_dias_proporcionalidade     NUMBER(3,0),
    mov_nsa_codigo_nivel           NUMBER(2,0),
    mov_oem_emp_numero_matricula   NUMBER(7,0),
    mov_oem_ofu_codigo             NUMBER(4,0),
    mov_oem_data_inicio            DATE,
    mov_data_calculo               DATE,
    mov_pem_ben_sigla              VARCHAR2(3),
    mov_tipo_funcao                VARCHAR2(2),
    mov_tipo_parametro             VARCHAR2(1),
    mov_ind_13                     VARCHAR2(1),
    mov_ind_arsaprev               VARCHAR2(1),
    mov_ind_lancamento_liq_negat   VARCHAR2(1),
    mov_nsa_codigo_padrao          VARCHAR2(4),
    mov_nsa_indicador_nivel_escola VARCHAR2(1),
    mov_flg_frequencia             VARCHAR2(1),
    cod_usuario                    VARCHAR2(30),
    dta_operacao                   DATE,
    mov_ctrl_txt_freq              NUMBER(4,0)
)
PARTITION BY RANGE(mov_ano_referencia,mov_mes_referencia) 
(
PARTITION mov_menor2001 VALUES LESS THAN(2001,13),
PARTITION mov_1bimes2002 VALUES LESS THAN(2002,2),
PARTITION mov_2bimes2002 VALUES LESS THAN(2002,4),
PARTITION mov_3bimes2002 VALUES LESS THAN(2002,6),
PARTITION mov_4bimes2002 VALUES LESS THAN(2002,8),
PARTITION mov_5bimes2002 VALUES LESS THAN(2002,10),
PARTITION mov_6bimes2002 VALUES LESS THAN(2002,13),
PARTITION mov_1bimes2003 VALUES LESS THAN(2003,2),
PARTITION mov_2bimes2003 VALUES LESS THAN(2003,4),
PARTITION mov_3bimes2003 VALUES LESS THAN(2003,6),
PARTITION mov_4bimes2003 VALUES LESS THAN(2003,8),
PARTITION mov_5bimes2003 VALUES LESS THAN(2003,10),
PARTITION mov_6bimes2003 VALUES LESS THAN(2003,13),
PARTITION mov_1bimes2004 VALUES LESS THAN(2004,2),
PARTITION mov_2bimes2004 VALUES LESS THAN(2004,4),
PARTITION mov_3bimes2004 VALUES LESS THAN(2004,6),
PARTITION mov_4bimes2004 VALUES LESS THAN(2004,8),
PARTITION mov_5bimes2004 VALUES LESS THAN(2004,10),
PARTITION mov_6bimes2004 VALUES LESS THAN(2004,13),
PARTITION mov_1bimes2005 VALUES LESS THAN(2005,2),
PARTITION mov_2bimes2005 VALUES LESS THAN(2005,4),
PARTITION mov_3bimes2005 VALUES LESS THAN(2005,6),
PARTITION mov_4bimes2005 VALUES LESS THAN(2005,8),
PARTITION mov_5bimes2005 VALUES LESS THAN(2005,10),
PARTITION mov_6bimes2005 VALUES LESS THAN(2005,13),
PARTITION mov_maior2005 VALUES LESS THAN(MAXVALUE,13))
/

ALTER TABLE IFRSRH2.MOVIMENTACAO 
ADD CONSTRAINT MOV_PK
  PRIMARY KEY (mov_ano_referencia, mov_mes_referencia, mov_versao_pagamento, mov_emp_numero_matricula, mov_rub_codigo, mov_tip_rubrica, mov_sequencial)
  USING INDEX LOCAL
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
  TABLESPACE  tsi_pessoal
  STORAGE   (
    INITIAL     65536
    MINEXTENTS  1
    MAXEXTENTS  2147483645
  )
/


-- Indexes for IFRSRH2.MOVIMENTACAO

CREATE INDEX ifrsrh2.idx_mov_emp_fk ON ifrsrh2.movimentacao
  (
    mov_emp_numero_matricula        ASC  
  ) LOCAL
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
  TABLESPACE  tsi_pessoal
  STORAGE   (
    INITIAL     65536
    MINEXTENTS  1
    MAXEXTENTS  2147483645
  )
/

CREATE INDEX ifrsrh2.mov_01_ix ON ifrsrh2.movimentacao
  (
    mov_tip_rubrica                 ASC,
    mov_emp_numero_matricula        ASC,
    mov_versao_pagamento            ASC,
    mov_ano_referencia              ASC
  ) LOCAL
  PCTFREE     20
  INITRANS    2
  MAXTRANS    255
  TABLESPACE  tsi_pessoal
  STORAGE   (
    INITIAL     65536
    MINEXTENTS  1
    MAXEXTENTS  2147483645
  )
/

CREATE INDEX ifrsrh2.mov_dep_ix ON ifrsrh2.movimentacao
  (
    mov_ano_referencia              ASC,
    mov_mes_referencia              ASC,
    mov_versao_pagamento            ASC,
    mov_emp_dep_codigo_pagto        ASC,
    mov_emp_numero_matricula        ASC
  ) LOCAL
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
  TABLESPACE  tsi_pessoal
  STORAGE   (
    INITIAL     65536
    MINEXTENTS  1
    MAXEXTENTS  2147483645
  )
/

CREATE INDEX ifrsrh2.mov_pen_fk ON ifrsrh2.movimentacao
  (
    mov_emp_numero_matricula        ASC,
    mov_pen_codigo                  ASC
  ) LOCAL
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
  TABLESPACE  tsi_pessoal
  STORAGE   (
    INITIAL     65536
    MINEXTENTS  1
    MAXEXTENTS  2147483645
  )
/

CREATE INDEX ifrsrh2.movimentacao_ind1 ON ifrsrh2.movimentacao
  (
    mov_oem_emp_numero_matricula    ASC,
    mov_oem_ofu_codigo              ASC,
    mov_oem_data_inicio             ASC
  ) LOCAL
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
  TABLESPACE  tsi_pessoal
  STORAGE   (
    INITIAL     65536
    MINEXTENTS  1
    MAXEXTENTS  2147483645
  )
/

