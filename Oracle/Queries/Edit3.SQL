mknod temp.dmp p
nohup uncompress <exp_ifrsrh_sebu04.DMP.Z >temp.dmp & 
imp ifrsrh2 fromuser=ifrsrh touser=ifrsrh2 tables=PROGRAMACOES_FERIAS,PROJECAO_MOVIMENTO_PAGAMENTO,PROVISOES_EMPREGADOS,QUADROS_FUNCOES_DEPENDENCIAS,QUADROS_LOTACAO_PESSOAL,QUADRO_ARMA_ESPEC,QUADRO_CARGOS_DEPENDENCIAS,QUADRO_FUNCOES,REAJUSTE_PERCENTUAL_13_FERIAS,REEMBOLSOS,REEMBOLSOS_AUXILIOS_CRECHES,REFER_AUXILIO_ALIMENTACAO,REG_ERRO_MIGRACAO_FOLHA_RDB,REG_TEMP_FGTS,RESUMO_ENCARGOS_FGTS,RESUMO_ENCARGOS_INFRAPREV indexes=n file=temp.dmp ignore=y log=imp_ifrsrh_6.log


mknod temp2.dmp p
nohup uncompress <exp_ifrsrh_sebu04.DMP.Z >temp2.dmp & 
imp ifrsrh2 fromuser=ifrsrh touser=ifrsrh2 tables=PROGRAMACOES_FERIAS indexes=n file=temp2.dmp ignore=y log=imp_ifrsrh_6.log