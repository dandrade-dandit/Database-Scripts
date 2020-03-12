SELECT table_name, owner, compression, compress_for, 'ALTER TABLE ' || owner || '.' || table_name || ' NOCOMPRESS;' 
FROM dba_tables 
where compression != 'DISABLED' --owner = 'IFRPAMI';
