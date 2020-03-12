create or replace procedure atualiza_sequencia_rub (p_mes in number, p_ano in number, p_versao in number) is
  TYPE RubCurTyp  IS REF CURSOR;
  v_rub_cursor    RubCurTyp;
  v_particao      varchar2(50) := null;
  v_rowid         varchar2(50);
  v_stmt_str      VARCHAR2(2000);
  v_stmt_update   VARCHAR2(2000);
  v_rubrica       number;
  v_sequencia     number;
begin
  begin
    select 'p'||to_char(p_ano+1)||'_'||decode(p_mes, 1,'janeiro',
                                                     2,'fevereiro',
                                                     3,'marco',
                                                     4,'abril',
                                                     5,'maio',
                                                     6,'junho',
                                                     7,'julho',
                                                     8,'agosto',
                                                     9,'setembro',
                                                     10,'outubro',
                                                     11,'novembro',
                                                     12,'dezembro',
                                                     13,'decimoterceiro')
    into   v_particao
    from   dual;
  exception
    when no_data_found then
      null;
  end;
  v_stmt_str := 'select distinct(mov.mov_rub_codigo) rubrica, rub.rub_seq_pagamento sequencia, mov.rowid '||
                ' from  movimentacao subpartition ('||v_particao||') mov, '||
                '       rubricas rub '||
                ' where  mov.mov_rub_codigo = rub.rub_codigo '||
                ' and    mov.mov_rub_seq_pagamento <> rub.rub_seq_pagamento';
  
  OPEN v_rub_cursor FOR v_stmt_str;
  LOOP
      FETCH v_rub_cursor INTO v_rubrica, v_sequencia, v_rowid;
      EXIT WHEN v_rub_cursor%NOTFOUND;
      dbms_output.put_line(to_char(v_rubrica)||' - '||v_rowid||' - '||to_char(v_sequencia));
      v_stmt_update := 'update movimentacao set mov_rub_seq_pagamento = '||to_char(v_sequencia)||' where rowid = '''||v_rowid||'''';
      dbms_output.put_line(v_stmt_update);
      execute immediate v_stmt_update;
	  commit;
  END LOOP;
  CLOSE v_rub_cursor;
END;
