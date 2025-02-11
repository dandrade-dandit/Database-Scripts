CREATE TABLE VERSAO_OBJETOS (
 ver_cd_sistema  number(2)   not null
, ver_objeto  varchar2(15)  not null
, ver_data_hora  varchar2(15) 
)
/

ALTER TABLE VERSAO_OBJETOS 
ADD CONSTRAINTS VO_PK 
PRIMARY KEY (ver_cd_sistema, ver_objeto)
/


ALTER  TABLE VERSAO_OBJETOS 
ADD  CONSTRAINTS VO_SS_FK 
 FOREIGN KEY (ver_cd_sistema) 
 REFERENCES SEG_SISTEMA(cd_sistema)
/

--HOMOLOG SO TEM ESSA ROLE

GRANT SELECT, INSERT, UPDATE, DELETE ON VERSAO_OBJETOS TO RH_PERFIL_99;
GRANT SELECT ON VERSAO_OBJETOS TO SRH_BEN_01;
GRANT SELECT ON VERSAO_OBJETOS TO SRH_BEN_02;
GRANT SELECT ON VERSAO_OBJETOS TO SRH_BEN_03;
GRANT SELECT ON VERSAO_OBJETOS TO SRH_BEN_04;
GRANT SELECT ON VERSAO_OBJETOS TO SRH_BEN_05;
GRANT SELECT ON VERSAO_OBJETOS TO SRH_BEN_06;
GRANT SELECT ON VERSAO_OBJETOS TO SRH_BEN_07;
GRANT SELECT ON VERSAO_OBJETOS TO SRH_BEN_09;
GRANT SELECT ON VERSAO_OBJETOS TO SRH_BEN_13;
GRANT SELECT ON VERSAO_OBJETOS TO SRH_CAD_01;
GRANT SELECT ON VERSAO_OBJETOS TO SRH_CAD_02;
GRANT SELECT ON VERSAO_OBJETOS TO SRH_CAD_03;
GRANT SELECT ON VERSAO_OBJETOS TO SRH_CAD_04;
GRANT SELECT ON VERSAO_OBJETOS TO SRH_CAD_05;
GRANT SELECT ON VERSAO_OBJETOS TO SRH_CAD_06;
GRANT SELECT ON VERSAO_OBJETOS TO SRH_CAD_07;
GRANT SELECT ON VERSAO_OBJETOS TO SRH_CAD_08;
GRANT SELECT ON VERSAO_OBJETOS TO SRH_CAD_09;
GRANT SELECT ON VERSAO_OBJETOS TO SRH_CAD_10;
GRANT SELECT ON VERSAO_OBJETOS TO SRH_CAD_11;
GRANT SELECT ON VERSAO_OBJETOS TO SRH_CAD_12;
GRANT SELECT ON VERSAO_OBJETOS TO SRH_CAD_13;
GRANT SELECT ON VERSAO_OBJETOS TO SRH_CAD_14;
GRANT SELECT ON VERSAO_OBJETOS TO SRH_CAD_15;
GRANT SELECT ON VERSAO_OBJETOS TO SRH_CAD_16;
GRANT SELECT ON VERSAO_OBJETOS TO SRH_CNPA;
GRANT SELECT ON VERSAO_OBJETOS TO SRH_TRN_01;

--PRODSEDE
GRANT SELECT, INSERT, UPDATE, DELETE ON VERSAO_OBJETOS TO RH_PERFIL_99;
GRANT SELECT ON VERSAO_OBJETOS TO SRH_BEN_01;
GRANT SELECT ON VERSAO_OBJETOS TO SRH_BEN_02;
GRANT SELECT ON VERSAO_OBJETOS TO SRH_BEN_05;
GRANT SELECT ON VERSAO_OBJETOS TO SRH_BEN_10;
GRANT SELECT ON VERSAO_OBJETOS TO SRH_BEN_11;
GRANT SELECT ON VERSAO_OBJETOS TO SRH_BEN_12;
GRANT SELECT ON VERSAO_OBJETOS TO SRH_BEN_13;
GRANT SELECT ON VERSAO_OBJETOS TO SRH_BEN_14;
GRANT SELECT ON VERSAO_OBJETOS TO SRH_BEN_15;
GRANT SELECT ON VERSAO_OBJETOS TO SRH_CAD_01;
GRANT SELECT ON VERSAO_OBJETOS TO SRH_CAD_02;
GRANT SELECT ON VERSAO_OBJETOS TO SRH_CAD_03;
GRANT SELECT ON VERSAO_OBJETOS TO SRH_CAD_04;
GRANT SELECT ON VERSAO_OBJETOS TO SRH_CAD_05;
GRANT SELECT ON VERSAO_OBJETOS TO SRH_CAD_06;
GRANT SELECT ON VERSAO_OBJETOS TO SRH_CAD_07;
GRANT SELECT ON VERSAO_OBJETOS TO SRH_CAD_08;
GRANT SELECT ON VERSAO_OBJETOS TO SRH_CAD_09;
GRANT SELECT ON VERSAO_OBJETOS TO SRH_CAD_10;
GRANT SELECT ON VERSAO_OBJETOS TO SRH_CAD_11;
GRANT SELECT ON VERSAO_OBJETOS TO SRH_CAD_12;
GRANT SELECT ON VERSAO_OBJETOS TO SRH_CAD_13;
GRANT SELECT ON VERSAO_OBJETOS TO SRH_CAD_14;
GRANT SELECT ON VERSAO_OBJETOS TO SRH_CAD_15;
GRANT SELECT ON VERSAO_OBJETOS TO SRH_CAD_16;
GRANT SELECT ON VERSAO_OBJETOS TO SRH_CAD_17;
GRANT SELECT ON VERSAO_OBJETOS TO SRH_CAD_18;
GRANT SELECT ON VERSAO_OBJETOS TO SRH_CAD_19;
GRANT SELECT ON VERSAO_OBJETOS TO SRH_CAD_20;
GRANT SELECT ON VERSAO_OBJETOS TO SRH_CAD_21;
GRANT SELECT ON VERSAO_OBJETOS TO SRH_CAD_22;
GRANT SELECT ON VERSAO_OBJETOS TO SRH_CAD_99;
GRANT SELECT ON VERSAO_OBJETOS TO SRH_CNPA;
GRANT SELECT ON VERSAO_OBJETOS TO SRH_CONSULTA;
GRANT SELECT ON VERSAO_OBJETOS TO SRH_NOTES;
GRANT SELECT ON VERSAO_OBJETOS TO SRH_PDI;
GRANT SELECT ON VERSAO_OBJETOS TO SRH_SFP_01;
GRANT SELECT ON VERSAO_OBJETOS TO SRH_SFP_03;
GRANT SELECT ON VERSAO_OBJETOS TO SRH_SFP_04;
GRANT SELECT ON VERSAO_OBJETOS TO SRH_SPF_01;
GRANT SELECT ON VERSAO_OBJETOS TO SRH_SPF_02;
GRANT SELECT ON VERSAO_OBJETOS TO SRH_SPF_03;
GRANT SELECT ON VERSAO_OBJETOS TO SRH_TRN_01;
GRANT SELECT ON VERSAO_OBJETOS TO SRH_TRN_02;
GRANT SELECT ON VERSAO_OBJETOS TO SRH_TRN_03;
GRANT SELECT ON VERSAO_OBJETOS TO SRH_TRN_04;
GRANT SELECT ON VERSAO_OBJETOS TO SRH_WEB;

--HOMOLOG
CREATE PUBLIC SYNONYM VERSAO_OBJETOS 
FOR DBA_INFRAERO.VERSAO_OBJETOS;

--PRODSEDE
CREATE PUBLIC SYNONYM VERSAO_OBJETOS 
FOR IFRSRH.VERSAO_OBJETOS;