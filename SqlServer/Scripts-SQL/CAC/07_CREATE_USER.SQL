create role rol_caccom_cons;

CREATE USER usr_caccom identified by infraero;

grant create session to usr_caccom;

grant create synonym to usr_caccom;

grant rol_caccom_cons to usr_caccom;
