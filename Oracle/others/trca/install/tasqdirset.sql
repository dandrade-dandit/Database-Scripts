CREATE OR REPLACE PROCEDURE sys.sqlt$_trca$_dir_set
/* $Header: 215187.1 tasqdirset.sql 11.4.5.0 2012/11/21 carlos.sierra $ */
AS
  PRAGMA AUTONOMOUS_TRANSACTION;
  TEST_FILENAME CONSTANT VARCHAR2(32) := 'tasqdirset.txt';

  l_rdbms_version v$instance.version%TYPE;
  l_rdbms_release NUMBER;
  l_open_mode VARCHAR2(2);
  l_user_dump_dest VARCHAR2(4000);
  l_background_dump_dest VARCHAR2(4000);
  l_sqlt$udump VARCHAR2(4000);
  l_sqlt$bdump VARCHAR2(4000);
  l_sqlt$stage VARCHAR2(4000);
  l_trca$input1 VARCHAR2(4000);
  l_trca$input2 VARCHAR2(4000);
  l_trca$stage VARCHAR2(4000);

  /* -------------------------------------------------------------------- */

  FUNCTION get_rdbms_version
  RETURN VARCHAR2
  IS
  BEGIN
    IF l_rdbms_version IS NULL THEN
      SELECT version INTO l_rdbms_version FROM v$instance;
    END IF;
    RETURN l_rdbms_version;
  END get_rdbms_version;

  /* -------------------------------------------------------------------- */

  FUNCTION get_rdbms_release
  RETURN NUMBER
  IS
    l_rdbms_version v$instance.version%TYPE;
    l_dot1 NUMBER;
    l_dot2 NUMBER;
  BEGIN
    IF l_rdbms_release IS NULL THEN
      l_rdbms_version := get_rdbms_version;
      l_dot1 := INSTR(l_rdbms_version, '.');
      l_dot2 := INSTR(l_rdbms_version, '.', l_dot1 + 1);
      l_rdbms_release :=
      TO_NUMBER(SUBSTR(l_rdbms_version, 1, l_dot1 - 1)) +
      (TO_NUMBER(SUBSTR(l_rdbms_version, l_dot1 + 1, l_dot2 - l_dot1 - 1)) / POWER(10, (l_dot2 - l_dot1 - 1)));
    END IF;
    RETURN l_rdbms_release;
  END get_rdbms_release;

  /* -------------------------------------------------------------------- */

  FUNCTION get_dir_path (p2_name IN VARCHAR2)
  RETURN VARCHAR2
  IS
    l2_value VARCHAR2(4000);
  BEGIN
    SELECT value INTO l2_value FROM v$system_parameter WHERE name = LOWER(TRIM(p2_name));
    RETURN l2_value;
  END get_dir_path;

  /* -------------------------------------------------------------------- */

  FUNCTION get_directory_path (p2_name IN VARCHAR2)
  RETURN VARCHAR2
  IS
    l2_value VARCHAR2(4000);
  BEGIN
    SELECT directory_path INTO l2_value FROM sys.dba_directories WHERE owner = 'SYS' AND directory_name = UPPER(TRIM(p2_name));
    RETURN l2_value;
  EXCEPTION
    WHEN NO_DATA_FOUND THEN
      RETURN NULL;
  END get_directory_path;

  /* -------------------------------------------------------------------- */

  FUNCTION open_write_close (
    p2_directory_alias IN VARCHAR2,
    p2_filename        IN VARCHAR2 )
  RETURN BOOLEAN
  IS
    out_file_type UTL_FILE.file_type;
  BEGIN
    SYS.DBMS_OUTPUT.PUT_LINE(p2_directory_alias||': write test file '||p2_filename);
    out_file_type :=
    SYS.UTL_FILE.FOPEN (
       location     => p2_directory_alias,
       filename     => p2_filename,
       open_mode    => l_open_mode,
       max_linesize => 32767 );

    IF l_rdbms_release < 10 THEN
      SYS.UTL_FILE.PUT_LINE (
        file   => out_file_type,
        buffer => 'Hello World!');
    ELSE
      SYS.UTL_FILE.PUT_RAW (
        file   => out_file_type,
        buffer => SYS.UTL_RAW.CAST_TO_RAW('Hello World!'||CHR(10)));
    END IF;

    SYS.UTL_FILE.FCLOSE(file => out_file_type);
    RETURN TRUE;
  EXCEPTION
    WHEN OTHERS THEN
      SYS.DBMS_OUTPUT.PUT_LINE('sys.sqlt$_trca$_dir_set.open_write_close: '||SQLERRM);
      RETURN FALSE;
  END open_write_close;

  /* -------------------------------------------------------------------- */

  FUNCTION open_read_close (
    p2_directory_alias IN VARCHAR2,
    p2_filename        IN VARCHAR2 )
  RETURN BOOLEAN
  IS
    l2_file BFILE;
    l2_file_len INTEGER := NULL;
    l2_file_offset INTEGER;
    l2_chunk_raw RAW(32767);
    l2_chunk VARCHAR2(32767);
  BEGIN
    SYS.DBMS_OUTPUT.PUT_LINE(p2_directory_alias||': read test file '||p2_filename);
    l2_file := BFILENAME(p2_directory_alias, p2_filename);
    SYS.DBMS_LOB.FILEOPEN (file_loc => l2_file);
    l2_file_len := SYS.DBMS_LOB.GETLENGTH(file_loc => l2_file);
    l2_file_offset := 1;

    SYS.DBMS_LOB.READ (
      file_loc => l2_file,
      amount   => l2_file_len,
      offset   => l2_file_offset,
      buffer   => l2_chunk_raw );

    l2_chunk := SYS.UTL_RAW.CAST_TO_VARCHAR2 (r => l2_chunk_raw);
    SYS.DBMS_LOB.FILECLOSE (file_loc => l2_file);
    RETURN TRUE;
  EXCEPTION
    WHEN OTHERS THEN
      SYS.DBMS_OUTPUT.PUT_LINE('sys.sqlt$_trca$_dir_set.open_read_close: '||SQLERRM);
      RETURN FALSE;
  END open_read_close;

  /* -------------------------------------------------------------------- */

  FUNCTION read_attributes (
    p2_directory_alias IN VARCHAR2,
    p2_filename       IN VARCHAR2 )
  RETURN BOOLEAN
  IS
    l2_file_exists     BOOLEAN;
    l2_file_length     NUMBER;
    l2_file_block_size NUMBER;
  BEGIN
    SYS.UTL_FILE.FGETATTR (
      location     => p2_directory_alias,
      filename     => p2_filename,
      fexists      => l2_file_exists,
      file_length  => l2_file_length,
      block_size   => l2_file_block_size );

    IF l2_file_exists THEN
      SYS.DBMS_OUTPUT.PUT_LINE(p2_directory_alias||': get attributes for file '||p2_filename);
      RETURN TRUE;
    ELSE
      SYS.DBMS_OUTPUT.PUT_LINE(p2_directory_alias||': cannot get attributes for file '||p2_filename);
      RETURN FALSE;
    END IF;
  END read_attributes;

  /* -------------------------------------------------------------------- */

  PROCEDURE revoke_directory (
    p2_directory_alias IN VARCHAR2,
    p2_tool_owner      IN VARCHAR2,
    p2_read_write      IN VARCHAR2 )
  IS
    l2_count NUMBER;
  BEGIN
    SELECT COUNT(*) INTO l2_count FROM sys.dba_users WHERE username = UPPER(p2_tool_owner);
    IF l2_count > 0 THEN
      BEGIN
        EXECUTE IMMEDIATE 'REVOKE '||UPPER(p2_read_write)||' ON DIRECTORY '||UPPER(p2_directory_alias)||' FROM '||UPPER(p2_tool_owner);
        SYS.DBMS_OUTPUT.PUT_LINE(p2_directory_alias||': '||p2_read_write||' access revoked from '||p2_tool_owner);
      EXCEPTION
        WHEN OTHERS THEN
          SYS.DBMS_OUTPUT.PUT_LINE('-> '||SQLERRM);
          SYS.DBMS_OUTPUT.PUT_LINE('-> '||p2_directory_alias||': '||p2_read_write||' access not revoked from '||p2_tool_owner||' due to error above (ignore this error)');
      END;
    END IF;
  END revoke_directory;

  /* -------------------------------------------------------------------- */

  PROCEDURE grant_directory (
    p2_directory_alias IN VARCHAR2,
    p2_tool_owner      IN VARCHAR2,
    p2_read_write      IN VARCHAR2 )
  IS
    l2_count NUMBER;
  BEGIN
    SELECT COUNT(*) INTO l2_count FROM sys.dba_users WHERE username = UPPER(p2_tool_owner);
    IF l2_count > 0 THEN
      EXECUTE IMMEDIATE 'GRANT '||UPPER(p2_read_write)||' ON DIRECTORY '||UPPER(p2_directory_alias)||' TO '||UPPER(p2_tool_owner);
      SYS.DBMS_OUTPUT.PUT_LINE(p2_directory_alias||': '||p2_read_write||' access granted to '||p2_tool_owner);
      IF p2_directory_alias = 'SQLT$STAGE' AND UPPER(p2_tool_owner) = 'SQLTXADMIN' THEN
        SELECT COUNT(*) INTO l2_count FROM sys.dba_roles WHERE role = 'SQLT_USER_ROLE';
        IF l2_count > 0 THEN
          BEGIN
            -- needed to invoke test case builder and expdp
            EXECUTE IMMEDIATE 'GRANT '||UPPER(p2_read_write)||' ON DIRECTORY '||UPPER(p2_directory_alias)||' TO SQLT_USER_ROLE';
            SYS.DBMS_OUTPUT.PUT_LINE(p2_directory_alias||': '||p2_read_write||' access granted to SQLT_USER_ROLE');
          EXCEPTION
            WHEN OTHERS THEN
              SYS.DBMS_OUTPUT.PUT_LINE('-> '||SQLERRM);
              SYS.DBMS_OUTPUT.PUT_LINE('-> '||p2_directory_alias||': '||p2_read_write||' access not granted to '||p2_tool_owner||' due to error above (ignore this error)');
          END;
        END IF;
      END IF;
    END IF;
  END grant_directory;

  /* -------------------------------------------------------------------- */

  PROCEDURE create_directory (
    p2_directory_alias IN VARCHAR2,
    p2_directory_path  IN VARCHAR2,
    p2_read_write      IN VARCHAR2 )
  IS
    l2_count NUMBER;
    l2_directory_path VARCHAR2(32767);
  BEGIN
    l2_directory_path := REPLACE(p2_directory_path, '''', '''''');
    IF l2_directory_path LIKE '%?%' OR l2_directory_path LIKE '%*%' THEN
      RAISE_APPLICATION_ERROR(-20101, 'Create directory failed. Path cannot contain "?", or "*" symbols');
    END IF;

    EXECUTE IMMEDIATE 'CREATE OR REPLACE DIRECTORY '||UPPER(p2_directory_alias)||' AS '''||l2_directory_path||'''';
    SYS.DBMS_OUTPUT.PUT_LINE(p2_directory_alias||': created');

    revoke_directory(p2_directory_alias, 'SQLTXPLAIN', p2_read_write);
    revoke_directory(p2_directory_alias, 'TRCANLZR', p2_read_write);
    grant_directory(p2_directory_alias, 'SQLTXADMIN', p2_read_write);
    grant_directory(p2_directory_alias, 'TRCADMIN', p2_read_write);
  END create_directory;

/* ---------------------------------------------------------------------- */

  PROCEDURE process_stage_directory (
    p2_directory_alias    IN VARCHAR2,
    p2_directory_path_old IN VARCHAR2,
    p2_directory_path_new IN VARCHAR2,
    p2_read_write         IN VARCHAR2 )
  IS

  /* -------------------------------------------------------------------- */

    PROCEDURE create_stage_directory
    IS
    BEGIN
      create_directory(p2_directory_alias, p2_directory_path_new, p2_read_write);
      IF open_write_close(p2_directory_alias, TEST_FILENAME) AND open_read_close(p2_directory_alias, TEST_FILENAME) AND read_attributes(p2_directory_alias, TEST_FILENAME) THEN
        SYS.DBMS_OUTPUT.PUT_LINE(p2_directory_alias||': '||p2_directory_path_new);
      ELSE
        RAISE_APPLICATION_ERROR(-20102, p2_directory_alias||': not capable of reading or writing.');
      END IF;
    END create_stage_directory;

  /* -------------------------------------------------------------------- */

  BEGIN
    IF p2_directory_path_old IS NULL THEN
      create_stage_directory;
    ELSE
      IF open_write_close(p2_directory_alias, TEST_FILENAME) AND open_read_close(p2_directory_alias, TEST_FILENAME) AND read_attributes(p2_directory_alias, TEST_FILENAME) THEN
        revoke_directory(p2_directory_alias, 'SQLTXPLAIN', p2_read_write);
        revoke_directory(p2_directory_alias, 'TRCANLZR', p2_read_write);
        grant_directory(p2_directory_alias, 'SQLTXADMIN', p2_read_write);
        grant_directory(p2_directory_alias, 'TRCADMIN', p2_read_write);
        SYS.DBMS_OUTPUT.PUT_LINE(p2_directory_alias||': '||p2_directory_path_old);
      ELSE
        create_stage_directory;
      END IF;
    END IF;
  END process_stage_directory;

/* ---------------------------------------------------------------------- */

  PROCEDURE process_input_directory (
    p2_directory_alias      IN VARCHAR2,
    p2_directory_path_old   IN VARCHAR2,
    p2_directory_path_new   IN VARCHAR2,
    p2_directory_path_stage IN VARCHAR2,
    p2_read_write           IN VARCHAR2 )
  IS

  /* -------------------------------------------------------------------- */

  BEGIN
    IF p2_directory_path_old IS NULL OR p2_directory_path_old <> p2_directory_path_new THEN
      create_directory(p2_directory_alias, p2_directory_path_new, p2_read_write);
    ELSE
      revoke_directory(p2_directory_alias, 'SQLTXPLAIN', p2_read_write);
      revoke_directory(p2_directory_alias, 'TRCANLZR', p2_read_write);
      grant_directory(p2_directory_alias, 'SQLTXADMIN', p2_read_write);
      grant_directory(p2_directory_alias, 'TRCADMIN', p2_read_write);
    END IF;
    IF p2_directory_path_new = p2_directory_path_stage THEN
      IF open_read_close(p2_directory_alias, TEST_FILENAME) AND read_attributes(p2_directory_alias, TEST_FILENAME) THEN
        SYS.DBMS_OUTPUT.PUT_LINE(p2_directory_alias||': '||p2_directory_path_new);
      ELSE
        RAISE_APPLICATION_ERROR(-20103, p2_directory_alias||': not capable of reading.');
      END IF;
    ELSE
      SYS.DBMS_OUTPUT.PUT_LINE(p2_directory_alias||': '||p2_directory_path_new);
    END IF;
  END process_input_directory;

/* ---------------------------------------------------------------------- */

BEGIN
  l_rdbms_version := get_rdbms_version;
  l_rdbms_release := get_rdbms_release;

  IF l_rdbms_release < 10 THEN
    l_open_mode := 'W';
  ELSE
    l_open_mode := 'WB';
  END IF;

  l_user_dump_dest := get_dir_path('user_dump_dest');
  l_background_dump_dest := get_dir_path('background_dump_dest');

  l_sqlt$udump := get_directory_path('SQLT$UDUMP');
  l_sqlt$bdump := get_directory_path('SQLT$BDUMP');
  l_sqlt$stage := get_directory_path('SQLT$STAGE');

  l_trca$input1 := get_directory_path('TRCA$INPUT1');
  l_trca$input2 := get_directory_path('TRCA$INPUT1');
  l_trca$stage := get_directory_path('TRCA$STAGE');

  process_stage_directory('SQLT$STAGE', l_sqlt$stage, l_user_dump_dest, 'READ,WRITE');
  l_sqlt$stage := get_directory_path('SQLT$STAGE');
  process_stage_directory('TRCA$STAGE', l_trca$stage, l_user_dump_dest, 'READ,WRITE');
  l_trca$stage := get_directory_path('TRCA$STAGE');

  process_input_directory('SQLT$UDUMP', l_sqlt$udump, l_user_dump_dest, l_sqlt$stage, 'READ');
  l_sqlt$udump := get_directory_path('SQLT$UDUMP');
  process_input_directory('SQLT$BDUMP', l_sqlt$bdump, l_background_dump_dest, l_sqlt$stage, 'READ');
  l_sqlt$bdump := get_directory_path('SQLT$BDUMP');

  process_input_directory('TRCA$INPUT1', l_trca$input1, l_user_dump_dest, l_trca$stage, 'READ');
  l_trca$input1 := get_directory_path('TRCA$INPUT1');
  process_input_directory('TRCA$INPUT2', l_trca$input2, l_background_dump_dest, l_trca$stage, 'READ');
  l_trca$input2 := get_directory_path('TRCA$INPUT1');

  COMMIT; -- AUTONOMOUS_TRANSACTION
END sqlt$_trca$_dir_set;
/

SET TERM ON;
SHOW ERRORS;
SET ECHO ON TERM OFF;

WHENEVER SQLERROR CONTINUE;

DECLARE
  my_count INTEGER;
BEGIN
  SELECT COUNT(*) INTO my_count FROM sys.dba_users WHERE username = 'SQLTXPLAIN';
  IF my_count > 0 THEN
    EXECUTE IMMEDIATE 'REVOKE EXECUTE ON sys.sqlt$_trca$_dir_set FROM SQLTXPLAIN';
  END IF;
END;
/

DECLARE
  my_count INTEGER;
BEGIN
  SELECT COUNT(*) INTO my_count FROM sys.dba_users WHERE username = 'TRCANLZR';
  IF my_count > 0 THEN
    EXECUTE IMMEDIATE 'REVOKE EXECUTE ON sys.sqlt$_trca$_dir_set FROM TRCANLZR';
  END IF;
END;
/

DECLARE
  my_count INTEGER;
BEGIN
  SELECT COUNT(*) INTO my_count FROM sys.dba_users WHERE username = 'SQLTXADMIN';
  IF my_count > 0 THEN
    EXECUTE IMMEDIATE 'GRANT EXECUTE ON sys.sqlt$_trca$_dir_set TO SQLTXADMIN';
  END IF;
END;
/

DECLARE
  my_count INTEGER;
BEGIN
  SELECT COUNT(*) INTO my_count FROM sys.dba_users WHERE username = 'TRCADMIN';
  IF my_count > 0 THEN
    EXECUTE IMMEDIATE 'GRANT EXECUTE ON sys.sqlt$_trca$_dir_set TO TRCADMIN';
  END IF;
END;
/

SET SERVEROUT ON SIZE 1000000;
EXEC sqlt$_trca$_dir_set;
