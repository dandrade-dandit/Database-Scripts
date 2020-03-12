GRANTEE                        OWNER                          TABLE_NAME
------------------------------ ------------------------------ ------------------------------
GRANTOR                        PRIVILEGE                                GRA
------------------------------ ---------------------------------------- ---
I9808178                       SST                            SST_EPI_USUARIO_ENTREGA
SST                            DELETE                                   NO

I9808178                       SST                            SST_EPI_USUARIO_ENTREGA
SST                            INSERT                                   NO

I9808178                       SST                            SST_EPI_USUARIO_ENTREGA
SST                            SELECT                                   NO

I9808178                       SST                            SST_EPI_USUARIO_ENTREGA
SST                            UPDATE                                   NO


4 linhas selecionadas.

SQL> select  EMP_NOME, EMP_STATUS
  2  from  CADASTROS
  3  where  EMP_NUMERO_MATRICULA =9808178;

EMP_NOME                                                     EMP_STATUS
------------------------------------------------------------ ----------
MARIEL MONTES PEREZ                                                   1

1 linha selecionada.

SQL> 