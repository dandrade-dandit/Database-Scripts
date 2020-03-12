SELECT a.usuario as "Usu�rio do Sistema"
     , a.data_hora as "Data e Hora da Opera��o"
     , decode(a.acao,'I','INCLUS�O','D', 'DELE��O', 'U', 'ATUALIZA��O','Outros') AS "A��o"
     , (SELECT b.no_sistema FROM ifrdba2.seg_sistema b WHERE b.cd_sistema = a.ss_cd_sistema) as "Sistema"
     , (SELECT distinct b.no_grupo FROM ifrdba2.seg_grupo_usuario b where b.cd_grupo = a.sgu_cd_grupo and b.ss_cd_sistema = a.ss_cd_sistema) as "Grupo"
     , a.su_id_usuario as "Usu�rio Alterado"
     , a.ds_usuario as "Descri��o do Usu�rio Alterado"
     , decode(a.id_gerente_sistema,'N','N�o', 'S', 'Sim','Outros') as "� gestor do m�dulo?"
     , a.maquina as "M�quina"
     , a.programa as "Programa"
     , a.sousuario as "Usu�rio do Sistema Operacional"
  FROM ifrdba2.seg_log_usuario_sistema a
 WHERE su_id_usuario like '%9882262'
 ORDER
    BY 2 ASC;
    
    --SELECT distinct b.no_grupo FROM ifrdba2.seg_grupo_usuario b where b.cd_grupo = a.sgu_cd_grupo

    
    
