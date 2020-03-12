ALTER TABLE SEG_MENU DROP CONSTRAINT SMEN_PK;

ALTER TABLE ifrdba2.seg_grupo_usuario_menu DROP CONSTRAINT sgum_sem_fk;

ALTER TABLE ifrdba2.seg_grupo_usuario_menu
 ADD CONSTRAINT sgum_sem_fk FOREIGN KEY (sq_funcao, ss_cd_sistema)
      REFERENCES ifrdba2.seg_menu(sq_funcao, ss_cd_sistema)
/

ALTER TABLE ifrdba2.seg_menu
 ADD CONSTRAINT smen_pk PRIMARY KEY (sq_funcao, ss_cd_sistema)
/