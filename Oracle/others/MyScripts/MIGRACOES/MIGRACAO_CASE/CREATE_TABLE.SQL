-- Start of DDL Script for Table IFRCASE6I.I$SDD_FILES
-- Generated 9-mar-2004 17:17:28 from SYS@HOMOLOG.WORLD

CREATE TABLE i$sdd_files
    (irid                           NUMBER NOT NULL,
    ivid                           NUMBER NOT NULL,
    types                          NUMBER(38) NOT NULL,
    element_type_name              VARCHAR2(10) DEFAULT 'FILES'  NOT NULL,
    date_created                   DATE DEFAULT SYSDATE  NOT NULL,
    created_by                     VARCHAR2(30) DEFAULT USER  NOT NULL,
    date_changed                   DATE,
    changed_by                     VARCHAR2(30),
    notm                           NUMBER(38) DEFAULT 0  NOT NULL,
    file_size                      NUMBER(10),
    name                           VARCHAR2(256) NOT NULL,
    kind                           VARCHAR2(1) NOT NULL,
    crc                            VARCHAR2(20),
    owner                          VARCHAR2(32),
    text_format                    VARCHAR2(1) NOT NULL,
    os_timestamp                   DATE,
    os_privileges                  NUMBER(38),
    short_description              VARCHAR2(240),
    contents_blob                  BLOB)
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
LOB (CONTENTS_BLOB) STORE AS
(
  NOCACHE LOGGING
  CHUNK 2048
  PCTVERSION 10
)
/


-- Indexes for I$SDD_FILES

CREATE INDEX ind_name_files ON i$sdd_files
  (
    name                            ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
  TABLESPACE  tsd_case
/
CREATE INDEX pk_sdd_files_idx ON i$sdd_files
  (
    irid                            ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
  TABLESPACE  tsd_case
/


-- Constraints for I$SDD_FILES

ALTER TABLE i$sdd_files
ADD CONSTRAINT sdd_files_rpk PRIMARY KEY (ivid)
USING INDEX
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
  TABLESPACE  tsd_case
/

-- End of DDL Script for Table IFRCASE6I.I$SDD_FILES


-- Start of DDL Script for Trigger IFRCASE6I.SDD_FILES_AR
-- Generated 10-mar-2004 9:06:18 from SYSTEM@HOMOLOG

CREATE TRIGGER sdd_files_ar
AFTER INSERT  OR UPDATE  OR  DELETE 
ON i$sdd_files
REFERENCING NEW AS NEW OLD AS OLD
FOR EACH ROW
begin
  -- Inserting
  if inserting then
    jr_object_version.ins ( :new.irid, :new.ivid
    , name => :new.NAME
    , type_irid => :new.TYPES
    , table_irid => 384781276420152342318608056225122361
    );
  end if;  -- inserting
  -- Updating
  if updating then
    jr_object_version.upd ( :old.ivid
      , name => :new.NAME
    );
  end if;  -- updating
  -- Deleting
  if deleting then
    jr_object_version.del ( :old.irid, :old.ivid, 'SDD_FILES'
      , null   -- parent_ivid not applicable for primary object
      , true   -- Designer object
      );
  end if;  -- deleting
end SDD_FILES_ar;
/

-- End of DDL Script for Trigger IFRCASE6I.SDD_FILES_AR

-- Start of DDL Script for Trigger IFRCASE6I.SDD_FILES_BR
-- Generated 10-mar-2004 9:06:19 from SYSTEM@HOMOLOG

CREATE TRIGGER sdd_files_br
BEFORE INSERT  OR UPDATE  OR  DELETE 
ON i$sdd_files
REFERENCING NEW AS NEW OLD AS OLD
FOR EACH ROW
begin
  if inserting then
    jr_audit.pre_insert(:new.irid, :new.ivid);
  end if;  -- inserting
end SDD_FILES_br;
/

-- End of DDL Script for Trigger IFRCASE6I.SDD_FILES_BR

-- Start of DDL Script for Trigger IFRCASE6I.SDD_FILES_INV
-- Generated 10-mar-2004 9:06:19 from SYSTEM@HOMOLOG

CREATE TRIGGER sdd_files_inv
AFTER INSERT 
ON i$sdd_files
REFERENCING NEW AS NEW OLD AS OLD
FOR EACH ROW
declare
  this_table_irid number;
  this_type_irid  number;
  action          varchar2(3);
begin
  if not jr_context.constraints_enabled then return; end if;
  this_table_irid := 384781276420152342318608056225122361;
  this_type_irid  := :new.TYPES;
  if updating then
    action := 'UPD';
    -- Check child objects when primary or unique key is changed
    -- Note, the called functions consider whether constraints are immediate or deferred
  end if;   -- updating
  insert into i$sdd_invalid_objects (object_irid, object_ivid, table_irid, type_irid)
  values (:new.irid, :new.ivid, this_table_irid, this_type_irid);
end SDD_FILES_inv;
/

-- End of DDL Script for Trigger IFRCASE6I.SDD_FILES_INV

-- Start of DDL Script for Trigger IFRCASE6I.SDD_FILES_VAL
-- Generated 10-mar-2004 9:06:20 from SYSTEM@HOMOLOG

CREATE TRIGGER sdd_files_val
AFTER INSERT 
ON i$sdd_files
REFERENCING NEW AS NEW OLD AS OLD
declare
  this_table_irid number;
  action          varchar2(3);
  cursor inv_cur (table_irid number) is
    select io.object_irid, io.object_ivid, io.type_irid
    from   i$sdd_invalid_objects io
    where  io.table_irid = inv_cur.table_irid;
begin
  if jr_context.constraints = jr_context.CONSTRAINTS_DEFERRED
    or not jr_context.constraints_enabled then return; end if;
  this_table_irid := 384781276420152342318608056225122361;
  if inserting then
    action := 'INS';
  end if;
  for inv_rec in inv_cur(this_table_irid) loop
    if not PK_SDD_FILES(inv_rec.object_irid, inv_rec.object_ivid) then
      raise_application_error(-20001, 'unique constraint (PK_SDD_FILES) violated');
    end if;
    delete i$sdd_invalid_objects io
    where  io.object_ivid = inv_rec.object_ivid
    and    io.table_irid  = this_table_irid;
  end loop;
end SDD_FILES_val;
/

-- End of DDL Script for Trigger IFRCASE6I.SDD_FILES_VAL

-- Start of DDL Script for Trigger IFRCASE6I.CDI_FILES_CRE_AUDIT
-- Generated 10-mar-2004 9:06:20 from SYSTEM@HOMOLOG

CREATE TRIGGER cdi_files_cre_audit
BEFORE INSERT 
ON i$sdd_files
REFERENCING NEW AS NEW OLD AS OLD
FOR EACH ROW
declare
begin
ci_audit.pre_insert(:new.date_created
                   ,:new.date_changed
                   ,:new.created_by
                   ,:new.changed_by
                   ,:new.types
                   ,:new.irid
                   ,:new.notm
                   ,:new.element_type_name
                   ,null); -- for now
END;
/

-- End of DDL Script for Trigger IFRCASE6I.CDI_FILES_CRE_AUDIT

-- Start of DDL Script for Trigger IFRCASE6I.CDI_FILES_UPD_AUDIT
-- Generated 10-mar-2004 9:06:21 from SYSTEM@HOMOLOG

CREATE TRIGGER cdi_files_upd_audit
BEFORE UPDATE 
ON i$sdd_files
REFERENCING NEW AS NEW OLD AS OLD
FOR EACH ROW
declare
begin
ci_audit.pre_update(:new.date_changed
                   ,:new.changed_by
                   ,:new.types
                   ,:old.notm
                   ,:new.notm
                   ,:new.element_type_name
                   ,null); -- for now
END;
/

-- End of DDL Script for Trigger IFRCASE6I.CDI_FILES_UPD_AUDIT

