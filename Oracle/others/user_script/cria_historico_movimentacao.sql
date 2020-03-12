-- Table HISTORICO_MOVIMENTACAO

CREATE TABLE HISTORICO_MOVIMENTACAO
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
  mov_dias_proporcionalidade  NUMBER(3),
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
  mov_flg_frequencia         VARCHAR2(1),
  cod_usuario                VARCHAR2(30),
  dta_operacao               DATE
 )
tablespace tsd_pessoal
/

-- Column Comments for HISTORICO_MOVIMENTACAO

COMMENT ON COLUMN HISTORICO_MOVIMENTACAO.cod_usuario IS 'Indica o usu�rio que efetuou a transa��o'
/
COMMENT ON COLUMN HISTORICO_MOVIMENTACAO.dta_operacao IS 'Indica a data e hora da transa��o'
/
COMMENT ON COLUMN HISTORICO_MOVIMENTACAO.mov_ano_ref_diferenca IS 'Indica o ano referenca � rubrida de diferen�a ou extorno, lan�ada na HISTORICO_MOVIMENTACAO do empregado'
/
COMMENT ON COLUMN HISTORICO_MOVIMENTACAO.mov_ano_referencia IS 'Indica o ano referente ao pagamento'
/
COMMENT ON COLUMN HISTORICO_MOVIMENTACAO.mov_data_calculo IS 'Informa a data que foi efetuado o c�lculo'
/
COMMENT ON COLUMN HISTORICO_MOVIMENTACAO.mov_dias_proporcionalidade IS 'Indica a quantidade de dias que obedecer� a proporcionalidade do c�lculo'
/
COMMENT ON COLUMN HISTORICO_MOVIMENTACAO.mov_emp_dep_codigo_pagto IS 'Indica o c�digo da depend�ncia de pagamento do empregado'
/
COMMENT ON COLUMN HISTORICO_MOVIMENTACAO.mov_emp_numero_matricula IS 'Informa a matricula do empregado'
/
COMMENT ON COLUMN HISTORICO_MOVIMENTACAO.mov_flg_frequencia IS 'Indica se a rubrica � relativa � frequ�ncia'
/
COMMENT ON COLUMN HISTORICO_MOVIMENTACAO.mov_for_codigo IS 'Indica o c�digo da formula de calculo da rubrica'
/
COMMENT ON COLUMN HISTORICO_MOVIMENTACAO.mov_fun_codigo IS 'Indica o c�digo da fun��o do empregado'
/
COMMENT ON COLUMN HISTORICO_MOVIMENTACAO.mov_ind_arsaprev IS 'Indica se a rubrica � relativa ao fundo de pens�o da Infraero'
/
COMMENT ON COLUMN HISTORICO_MOVIMENTACAO.mov_ind_calculo IS 'Indica se a rubrica j� foi calculada, N - n�o, S - sim'
/
COMMENT ON COLUMN HISTORICO_MOVIMENTACAO.mov_ind_exclusivo IS 'Indica se a rubrica � lan�ada exclusivamente pelo sistema'
/
COMMENT ON COLUMN HISTORICO_MOVIMENTACAO.mov_ind_lancamento_liq_negat IS 'Indica se a rubrica � candidata a ser migrada para um pr�ximo m�s, ap�s c�lculo de depend�ncia e antes do c�lculo final'
/
COMMENT ON COLUMN HISTORICO_MOVIMENTACAO.mov_ind_13 IS 'Indicador que ser� utilizado somente no c�lculo do 13�, marca as rubricas que foram utilizadas e devem ser retiradas ap�s o c�lculo'
/
COMMENT ON COLUMN HISTORICO_MOVIMENTACAO.mov_mes_ref_diferenca IS 'Indica o m�s referenca � rubrida de diferen�a ou extorno, lan�ada na HISTORICO_MOVIMENTACAO do empregado'
/
COMMENT ON COLUMN HISTORICO_MOVIMENTACAO.mov_mes_referencia IS 'Indica o m�s referente ao pagamento'
/
COMMENT ON COLUMN HISTORICO_MOVIMENTACAO.mov_nsa_codigo_nivel IS 'Indica o n�vel salarial do empregado'
/
COMMENT ON COLUMN HISTORICO_MOVIMENTACAO.mov_nsa_codigo_padrao IS 'Indica c�digo padr�o salarial do empregado'
/
COMMENT ON COLUMN HISTORICO_MOVIMENTACAO.mov_nsa_indicador_nivel_escola IS 'Indica o n�vel de escolaridade do empregado'
/
COMMENT ON COLUMN HISTORICO_MOVIMENTACAO.mov_oem_data_inicio IS 'Informa a data in�cio da ocorr�ncia funcional que deu origem � rubrica'
/
COMMENT ON COLUMN HISTORICO_MOVIMENTACAO.mov_oem_emp_numero_matricula IS 'Informa a matricula do empregado na ocorr�ncia que deu origem � rubrica'
/
COMMENT ON COLUMN HISTORICO_MOVIMENTACAO.mov_oem_ofu_codigo IS 'Informa o c�digo da ocorr�ncia funcional que deu origem � rubrica'
/
COMMENT ON COLUMN HISTORICO_MOVIMENTACAO.mov_parametro IS 'Indica o valor do parametro que ser� ultilizado no c�lculo da rubrica'
/
COMMENT ON COLUMN HISTORICO_MOVIMENTACAO.mov_parcela IS 'Indica a quantidade de parcelas da rubrica, 999 indica rubrica permanente'
/
COMMENT ON COLUMN HISTORICO_MOVIMENTACAO.mov_parcela_atual IS 'Indica a parcela atual da quantidade de parcelas da rubrica, 999 indica rubrica permanente'
/
COMMENT ON COLUMN HISTORICO_MOVIMENTACAO.mov_pem_ben_sigla IS 'Informa a sigla do tipo de benef�cio'
/
COMMENT ON COLUMN HISTORICO_MOVIMENTACAO.mov_pen_codigo IS 'Indica o c�digo do pedido de ticket no benef�cio'
/
COMMENT ON COLUMN HISTORICO_MOVIMENTACAO.mov_rub_codigo IS 'Indica o c�digo de provento ou desconto (rubrica)'
/
COMMENT ON COLUMN HISTORICO_MOVIMENTACAO.mov_rub_seq_pagamento IS 'Indica a sequ�ncia de c�lculo da rubrica'
/
COMMENT ON COLUMN HISTORICO_MOVIMENTACAO.mov_sequencial IS 'Indica o sequencial da rubrica no mesmo m�s'
/
COMMENT ON COLUMN HISTORICO_MOVIMENTACAO.mov_tipo_funcao IS 'Indica a sigla da fun��o do empregado, FG, DG, DI'
/
COMMENT ON COLUMN HISTORICO_MOVIMENTACAO.mov_tipo_parametro IS 'Indica o tipo do parametro, H - horas, D - dias, V - valor, P - percentual, Q - quantidade'
/
COMMENT ON COLUMN HISTORICO_MOVIMENTACAO.mov_tip_rubrica IS 'Indica o tipo de rubrica, D - diferen�a, N - normal, E - extorno, R - recibo '
/
COMMENT ON COLUMN HISTORICO_MOVIMENTACAO.mov_valor IS 'Indica o valor final da rubrica, utilizando o mov_dias_proporcionalidade'
/
COMMENT ON COLUMN HISTORICO_MOVIMENTACAO.mov_valor_integral IS 'Valor integral da rubrica, valor base para aplicar a proporcionalidade dos c�lculos'
/
COMMENT ON COLUMN HISTORICO_MOVIMENTACAO.mov_versao_pagamento IS 'Indica a vers�o de pagamento dentro do mesmo m�s'
/

-- Grants for HISTORICO_MOVIMENTACAO

GRANT DELETE,INSERT,SELECT,UPDATE ON HISTORICO_MOVIMENTACAO TO rh_perfil_99
/

-- Indexes for HISTORICO_MOVIMENTACAO

CREATE  INDEX hst_mov_dep_ix
 ON HISTORICO_MOVIMENTACAO
  ( mov_ano_referencia,
    mov_mes_referencia,
    mov_versao_pagamento,
    mov_emp_dep_codigo_pagto,
    mov_emp_numero_matricula  )
tablespace tsi_pessoal
/

CREATE  INDEX hst_mov_emp_idx
 ON HISTORICO_MOVIMENTACAO
  ( mov_emp_numero_matricula  )
tablespace tsi_pessoal
/

CREATE  INDEX HISTORICO_MOVIMENTACAO_IND1
 ON HISTORICO_MOVIMENTACAO
  ( mov_oem_emp_numero_matricula,
    mov_oem_ofu_codigo,
    mov_oem_data_inicio  )
tablespace tsi_pessoal
/

CREATE  INDEX mov_pkt_cod_pedido_ix
 ON HISTORICO_MOVIMENTACAO
  ( mov_pkt_codigo_pedido  )
tablespace tsi_pessoal
/

-- Constraints for HISTORICO_MOVIMENTACAO

ALTER TABLE HISTORICO_MOVIMENTACAO
 ADD CONSTRAINT hst_mov_pk PRIMARY KEY (mov_ano_referencia,mov_mes_referencia,
 mov_versao_pagamento,mov_emp_numero_matricula,mov_rub_codigo,mov_tip_rubrica,
 mov_sequencial)
using index tablespace tsi_pessoal
/

ALTER TABLE HISTORICO_MOVIMENTACAO
 ADD CONSTRAINT hst_mov_emp_fk FOREIGN KEY (mov_emp_numero_matricula)
      REFERENCES CADASTROS(emp_numero_matricula)
/

ALTER TABLE HISTORICO_MOVIMENTACAO
 ADD CONSTRAINT hst_mov_form_fk FOREIGN KEY (mov_for_codigo)
      REFERENCES FORMULAS(for_codigo)
/

ALTER TABLE HISTORICO_MOVIMENTACAO
 ADD CONSTRAINT hst_mov_oem_fk FOREIGN KEY (mov_oem_emp_numero_matricula,mov_oem_ofu_codigo,
 mov_oem_data_inicio)
      REFERENCES OCORRENCIAS_EMPREGADOS(oem_emp_numero_matricula,oem_ofu_codigo,
   oem_data_inicio)
/

ALTER TABLE HISTORICO_MOVIMENTACAO
 ADD CONSTRAINT hst_mov_pen_fk FOREIGN KEY (mov_emp_numero_matricula,mov_pen_codigo)
      REFERENCES PENSIONISTAS(pen_emp_numero_matricula,pen_codigo)
/

ALTER TABLE HISTORICO_MOVIMENTACAO
 ADD CONSTRAINT hst_mov_rub_fk FOREIGN KEY (mov_rub_codigo)
      REFERENCES RUBRICAS(rub_codigo)
/

ALTER TABLE HISTORICO_MOVIMENTACAO
  ADD CONSTRAINT hst_hst_mov_ck_1 CHECK ( mov_tipo_parametro in ('H','D','V','P','Q') )
/

ALTER TABLE HISTORICO_MOVIMENTACAO
  ADD CONSTRAINT hst_mov_ck_2 CHECK ( mov_tip_rubrica in ('N','D','E','R') )
/

ALTER TABLE HISTORICO_MOVIMENTACAO
  ADD CONSTRAINT hst_mov_ck_3 CHECK ( mov_ind_arsaprev in ('S','N','I') )
/

ALTER TABLE HISTORICO_MOVIMENTACAO
  ADD CONSTRAINT hst_mov_ck_4 CHECK ( mov_tipo_funcao in ('FG','RG','DI') )
/

ALTER TABLE HISTORICO_MOVIMENTACAO
  ADD CONSTRAINT hst_mov_ck_5 CHECK ( mov_ind_exclusivo in ('S','N') )
/

ALTER TABLE HISTORICO_MOVIMENTACAO
  ADD CONSTRAINT hst_mov_ck_6 CHECK ( mov_ind_13 in ('S','N') )
/

ALTER TABLE HISTORICO_MOVIMENTACAO
  ADD CONSTRAINT hst_mov_ck_7 CHECK ( mov_ind_calculo IN ( 'S' , 'N' ) )
/


-- End of DDL script for HISTORICO_MOVIMENTACAO
