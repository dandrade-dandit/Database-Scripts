SELECT a.usuario as "Usuário do Sistema"
     , a.data_hora as "Data e Hora da Operação"
     , decode(a.acao,'I','INCLUSÃO','D', 'DELEÇÃO', 'U', 'ATUALIZAÇÃO','Outros') AS "Ação"
     , (SELECT b.no_sistema FROM ifrdba2.seg_sistema b WHERE b.cd_sistema = a.ss_cd_sistema) as "Sistema"
     , (SELECT distinct b.no_grupo FROM ifrdba2.seg_grupo_usuario b where b.cd_grupo = a.sgu_cd_grupo and b.ss_cd_sistema = a.ss_cd_sistema) as "Grupo"
     , a.su_id_usuario as "Usuário Alterado"
     , a.ds_usuario as "Descrição do Usuário Alterado"
     , decode(a.id_gerente_sistema,'N','Não', 'S', 'Sim','Outros') as "É gestor do módulo?"
     , a.maquina as "Máquina"
     , a.programa as "Programa"
     , a.sousuario as "Usuário do Sistema Operacional"
  FROM ifrdba2.seg_log_usuario_sistema a
 WHERE su_id_usuario like '%9882262'
 ORDER
    BY 2 ASC;
    
    --SELECT distinct b.no_grupo FROM ifrdba2.seg_grupo_usuario b where b.cd_grupo = a.sgu_cd_grupo

    
    
