select * from IFRCACCOM.TIPO_CHAMADO where SEQ_TIPO_CHAMADO = 504

select * from IFRCACCOM.SUBTIPO_CHAMADO where  FLG_ATIVO ='S'

select * from ifrcaccom.atividade_chamado where FLG_ATIVO ='N'

select * from ifrcaccom.chamado

--UPDATE IFRCACCOM.SUBTIPO_CHAMADO SET qtd_min_sla_atendimento = 7200 where qtd_min_sla_atendimento = 1440

--UPDATE IFRCACCOM.atividade_chamado SET qtd_min_sla_atendimento = 7200 where qtd_min_sla_atendimento = 1440

--UPDATE IFRCACCOM.chamado SET seq_atividade_chamado = 1

--DELETE IFRCACCOM.TIPO_CHAMADO WHERE SEQ_TIPO_CHAMADO = 502

--DELETE IFRCACCOM.SUBTIPO_CHAMADO WHERE FLG_ATIVO ='N'

--DELETE ifrcaccom.atividade_chamado where SEQ_SUBTIPO_CHAMADO = 2022

--COMMIT

--rollback



SELECT DISTINCT TP.SEQ_TIPO_CHAMADO, TP.DSC_TIPO_CHAMADO
  FROM ifrcaccom.TIPO_CHAMADO TP
  INNER JOIN ifrcaccom.SUBTIPO_CHAMADO SC
            ON TP.SEQ_TIPO_CHAMADO = SC.SEQ_TIPO_CHAMADO
            INNER JOIN ifrcaccom.ATIVIDADE_CHAMADO AC
                      ON SC.SEQ_SUBTIPO_CHAMADO = AC.SEQ_SUBTIPO_CHAMADO
WHERE 1 = 1
--and (TP.FLG_ATENDIMENTO_EXTERNO = 'S')
and TP.FLG_ATIVO = 'S'


[22/07/2015 14:10] Vitor Andrade de Moura: 
if($this->FLG_ATIVO != ""){
			$sqlCorpo .= "  and TP.FLG_ATIVO = '$this->FLG_ATIVO' ";
		}
		if($this->SEQ_TIPO_CHAMADO_NAO_EXIBIR != ""){
			$sqlCorpo .= "  and TP.SEQ_TIPO_CHAMADO not in ($this->SEQ_TIPO_CHAMADO_NAO_EXIBIR) ";
		}
		$sqlCount = $sqlCorpo;

		if ($orderBy != "" ) {
			$sqlCorpo .= " ORDER BY $orderBy ";
		} 



SELECT DISTINCT SC.SEQ_SUBTIPO_CHAMADO, SC.DSC_SUBTIPO_CHAMADO
  FROM ifrcaccom.SUBTIPO_CHAMADO SC
  INNER JOIN ifrcaccom.ATIVIDADE_CHAMADO AC
          ON SC.SEQ_SUBTIPO_CHAMADO = AC.SEQ_SUBTIPO_CHAMADO
 WHERE 1 = 1   
   and SC.SEQ_TIPO_CHAMADO = 504   
   and AC.FLG_ATENDIMENTO_EXTERNO = 'N'   
   and SC.FLG_ATIVO = 'S'   
   and SC.SEQ_SUBTIPO_CHAMADO not in ('61')  
 ORDER 
    BY DSC_SUBTIPO_CHAMADO 