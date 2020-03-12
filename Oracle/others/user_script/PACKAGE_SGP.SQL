SET SCAN OFF
CREATE OR REPLACE PACKAGE FUNCOES_SGP AS
/******************************************************************************/
/*									      */	
/*                     PACOTE CRIADO POR THIAGO AVELAR	                      */	
/*									      */
/******************************************************************************/
    PROCEDURE INSERE_CONDICOES(ANALISE IN VARCHAR2, DEP IN NUMBER, ANO IN NUMBER);
    PROCEDURE INSERE_POLITICAS(DEP IN NUMBER);
END FUNCOES_SGP;
/
CREATE OR REPLACE PACKAGE BODY FUNCOES_SGP AS
    PROCEDURE INSERE_CONDICOES(ANALISE IN VARCHAR2, DEP IN NUMBER, ANO IN NUMBER) IS 
    BEGIN
         Insert Into T_RES_CONDICOES
         (Analise_Numero, Dep_Analise, Ano, Pci_Min, Area_Tipica, Trafego) 
         values(ANALISE, DEP, ANO, '40','PA','L');

         Insert Into T_RES_CONDICOES
         (Analise_Numero, Dep_Analise, Ano, Pci_Min, Area_Tipica, Trafego)
         values(ANALISE, DEP, ANO, '56', 'PA','P');

	 Insert Into T_RES_CONDICOES
         (Analise_Numero, Dep_Analise, Ano, Pci_Min, Area_Tipica, Trafego)
         values(ANALISE, DEP, ANO, '56', 'PA', 'M');

         Insert Into T_RES_CONDICOES
         (Analise_Numero, Dep_Analise, Ano, Pci_Min, Area_Tipica, Trafego)
         values(ANALISE, DEP, ANO, '56', 'PT', 'L');

         Insert Into T_RES_CONDICOES
         (Analise_Numero, Dep_Analise, Ano, Pci_Min, Area_Tipica, Trafego)
         values(ANALISE, DEP, ANO, '70', 'PT', 'P'); 

         Insert Into T_RES_CONDICOES
         (Analise_Numero, Dep_Analise, Ano, Pci_Min, Area_Tipica, Trafego)
         values(ANALISE, DEP, ANO, '56', 'PT', 'M');

         Insert Into T_RES_CONDICOES
         (Analise_Numero, Dep_Analise, Ano, Pci_Min, Area_Tipica, Trafego)
         values(ANALISE, DEP, ANO, '56', 'PP', 'L');

         Insert Into T_RES_CONDICOES
         (Analise_Numero, Dep_Analise, Ano, Pci_Min, Area_Tipica, Trafego)
         values(ANALISE, DEP, ANO, '70', 'PP', 'P');   

         Insert Into T_RES_CONDICOES
         (Analise_Numero, Dep_Analise, Ano, Pci_Min, Area_Tipica, Trafego)
         values(ANALISE, DEP, ANO, '70', 'PP', 'M');

         COMMIT;
    END INSERE_CONDICOES; 
/******************************************************************************/
    PROCEDURE INSERE_POLITICAS(DEP IN NUMBER) IS
    BEGIN
        Insert into T_Politicas
        (c_neg_codigo, Superficie, Area_Tipica, Trafego, Pci_Ini, Pci_fim, Servico_Codigo)
        Values(DEP,'CAF','PA','L','0','10','RRP');
        
        Insert into T_Politicas
        (c_neg_codigo, Superficie, Area_Tipica, Trafego, Pci_Ini, Pci_fim, Servico_Codigo) 
        Values(DEP,'CAF','PA','L','11','25','RCM');

        Insert into T_Politicas
        (c_neg_codigo, Superficie, Area_Tipica, Trafego, Pci_Ini, Pci_fim, Servico_Codigo) 
        Values(DEP,'CAF','PA','L','26','40','RCD');

        Insert into T_Politicas
        (c_neg_codigo, Superficie, Area_Tipica, Trafego, Pci_Ini, Pci_fim, Servico_Codigo)
        Values(DEP,'CAF','PA','L','41','55','RJ');

        Insert into T_Politicas
        (c_neg_codigo, Superficie, Area_Tipica, Trafego, Pci_Ini, Pci_fim, Servico_Codigo)
        Values(DEP,'CAF','PA','L','56','70','RP');

        Insert into T_Politicas
        (c_neg_codigo, Superficie, Area_Tipica, Trafego, Pci_Ini, Pci_fim, Servico_Codigo)
        Values(DEP,'CAF','PA','L','71','85','SL');

        Insert into T_Politicas
        (c_neg_codigo, Superficie, Area_Tipica, Trafego, Pci_Ini, Pci_fim, Servico_Codigo)
        Values(DEP,'CAF','PA','L','86','100','CR');

        Insert into T_Politicas
        (c_neg_codigo, Superficie, Area_Tipica, Trafego, Pci_Ini, Pci_fim, Servico_Codigo)
        Values(DEP,'CAF','PA','M','0','10','RRP');

        Insert into T_Politicas
        (c_neg_codigo, Superficie, Area_Tipica, Trafego, Pci_Ini, Pci_fim, Servico_Codigo)
        Values(DEP,'CAF','PA','M','11',' 25','RRP');

        Insert into T_Politicas
        (c_neg_codigo, Superficie, Area_Tipica, Trafego, Pci_Ini, Pci_fim, Servico_Codigo)
        Values(DEP,'CAF','PA','M','26','40','RCM');

        Insert into T_Politicas
        (c_neg_codigo, Superficie, Area_Tipica, Trafego, Pci_Ini, Pci_fim, Servico_Codigo)
        Values(DEP,'CAF','PA','M','41','55','RCD');

        Insert into T_Politicas
        (c_neg_codigo, Superficie, Area_Tipica, Trafego, Pci_Ini, Pci_fim, Servico_Codigo)
        Values(DEP,'CAF','PA','M','56','70','RJ');

        Insert into T_Politicas
        (c_neg_codigo, Superficie, Area_Tipica, Trafego, Pci_Ini, Pci_fim, Servico_Codigo)
        Values(DEP,'CAF','PA','M','71','85','RP');

        Insert into T_Politicas
        (c_neg_codigo, Superficie, Area_Tipica, Trafego, Pci_Ini, Pci_fim, Servico_Codigo)
        Values(DEP,'CAF','PA','M','86','100','CR');

        Insert into T_Politicas
        (c_neg_codigo, Superficie, Area_Tipica, Trafego, Pci_Ini, Pci_fim, Servico_Codigo)
        Values(DEP,'CAF','PA','P','0','10','RRP');

        Insert into T_Politicas
        (c_neg_codigo, Superficie, Area_Tipica, Trafego, Pci_Ini, Pci_fim, Servico_Codigo)
        Values(DEP,'CAF','PA','P','11','25','RRP');

        Insert into T_Politicas
        (c_neg_codigo, Superficie, Area_Tipica, Trafego, Pci_Ini, Pci_fim, Servico_Codigo)
        Values(DEP,'CAF','PA','P','26','40','RCE');

        Insert into T_Politicas
        (c_neg_codigo, Superficie, Area_Tipica, Trafego, Pci_Ini, Pci_fim, Servico_Codigo)
        Values(DEP,'CAF','PA','P','41','55','RCD');

        Insert into T_Politicas
        (c_neg_codigo, Superficie, Area_Tipica, Trafego, Pci_Ini, Pci_fim, Servico_Codigo)
        Values(DEP,'CAF','PA','P','56','70','RJ');

        Insert into T_Politicas
        (c_neg_codigo, Superficie, Area_Tipica, Trafego, Pci_Ini, Pci_fim, Servico_Codigo)
        Values(DEP,'CAF','PA','P','71','85','RP');

        Insert into T_Politicas
        (c_neg_codigo, Superficie, Area_Tipica, Trafego, Pci_Ini, Pci_fim, Servico_Codigo)
        Values(DEP,'CAF','PA','P','86','100','CR');

        Insert into T_Politicas
        (c_neg_codigo, Superficie, Area_Tipica, Trafego, Pci_Ini, Pci_fim, Servico_Codigo)
        Values(DEP,'CAF','PP','L','0','10','RRP');

        Insert into T_Politicas
        (c_neg_codigo, Superficie, Area_Tipica, Trafego, Pci_Ini, Pci_fim, Servico_Codigo)
        Values(DEP,'CAF','PP','L','11','25','RCM');

        Insert into T_Politicas
        (c_neg_codigo, Superficie, Area_Tipica, Trafego, Pci_Ini, Pci_fim, Servico_Codigo)
        Values(DEP,'CAF','PP','L','26','40','RCD');

        Insert into T_Politicas
        (c_neg_codigo, Superficie, Area_Tipica, Trafego, Pci_Ini, Pci_fim, Servico_Codigo)
        Values(DEP,'CAF','PP','L','41','55','RJ');

        Insert into T_Politicas
        (c_neg_codigo, Superficie, Area_Tipica, Trafego, Pci_Ini, Pci_fim, Servico_Codigo)
        Values(DEP,'CAF','PP','L','56','70','RP');

        Insert into T_Politicas
        (c_neg_codigo, Superficie, Area_Tipica, Trafego, Pci_Ini, Pci_fim, Servico_Codigo)
        Values(DEP,'CAF','PP','L','71','85','SL');

        Insert into T_Politicas
        (c_neg_codigo, Superficie, Area_Tipica, Trafego, Pci_Ini, Pci_fim, Servico_Codigo)
        Values(DEP,'CAF','PP','L','86','100','CR');

        Insert into T_Politicas
        (c_neg_codigo, Superficie, Area_Tipica, Trafego, Pci_Ini, Pci_fim, Servico_Codigo)
        Values(DEP,'CAF','PP','M','0','10','RRP');

        Insert into T_Politicas
        (c_neg_codigo, Superficie, Area_Tipica, Trafego, Pci_Ini, Pci_fim, Servico_Codigo)
        Values(DEP,'CAF','PP','M','11','25','RRP');

        Insert into T_Politicas
        (c_neg_codigo, Superficie, Area_Tipica, Trafego, Pci_Ini, Pci_fim, Servico_Codigo)
        Values(DEP,'CAF','PP','M','26','40','RCM');

        Insert into T_Politicas
        (c_neg_codigo, Superficie, Area_Tipica, Trafego, Pci_Ini, Pci_fim, Servico_Codigo)
        Values(DEP,'CAF','PP','M','41','55','RCD');

        Insert into T_Politicas
        (c_neg_codigo, Superficie, Area_Tipica, Trafego, Pci_Ini, Pci_fim, Servico_Codigo)
        Values(DEP,'CAF','PP','M','56','70','RJ');

        Insert into T_Politicas
        (c_neg_codigo, Superficie, Area_Tipica, Trafego, Pci_Ini, Pci_fim, Servico_Codigo)
        Values(DEP,'CAF','PP','M','71','85','RP');

        Insert into T_Politicas
        (c_neg_codigo, Superficie, Area_Tipica, Trafego, Pci_Ini, Pci_fim, Servico_Codigo)
        Values(DEP,'CAF','PP','M','86','100','CR');

        Insert into T_Politicas
        (c_neg_codigo, Superficie, Area_Tipica, Trafego, Pci_Ini, Pci_fim, Servico_Codigo)
        Values(DEP,'CAF','PP','P','0','10','RRP');

        Insert into T_Politicas
        (c_neg_codigo, Superficie, Area_Tipica, Trafego, Pci_Ini, Pci_fim, Servico_Codigo)
        Values(DEP,'CAF','PP','P','11','25','RRP');

        Insert into T_Politicas
        (c_neg_codigo, Superficie, Area_Tipica, Trafego, Pci_Ini, Pci_fim, Servico_Codigo)
        Values(DEP,'CAF','PP','P','26','40','RCE');

        Insert into T_Politicas
        (c_neg_codigo, Superficie, Area_Tipica, Trafego, Pci_Ini, Pci_fim, Servico_Codigo)
        Values(DEP,'CAF','PP','P','41','55','RCD');

        Insert into T_Politicas
        (c_neg_codigo, Superficie, Area_Tipica, Trafego, Pci_Ini, Pci_fim, Servico_Codigo)
        Values(DEP,'CAF','PP','P','56','70','RJ');

        Insert into T_Politicas
        (c_neg_codigo, Superficie, Area_Tipica, Trafego, Pci_Ini, Pci_fim, Servico_Codigo)
        Values(DEP,'CAF','PP','P','71','85','RP');

        Insert into T_Politicas
        (c_neg_codigo, Superficie, Area_Tipica, Trafego, Pci_Ini, Pci_fim, Servico_Codigo)
        Values(DEP,'CAF','PP','P','86','100','CR');

        Insert into T_Politicas
        (c_neg_codigo, Superficie, Area_Tipica, Trafego, Pci_Ini, Pci_fim, Servico_Codigo)
        Values(DEP,'CAF','PT','L','0','10','RRP');

        Insert into T_Politicas
        (c_neg_codigo, Superficie, Area_Tipica, Trafego, Pci_Ini, Pci_fim, Servico_Codigo)
        Values(DEP,'CAF','PT','L','11','25','RCM');

        Insert into T_Politicas
        (c_neg_codigo, Superficie, Area_Tipica, Trafego, Pci_Ini, Pci_fim, Servico_Codigo)
        Values(DEP,'CAF','PT','L','26','40','RCD');

        Insert into T_Politicas
        (c_neg_codigo, Superficie, Area_Tipica, Trafego, Pci_Ini, Pci_fim, Servico_Codigo)
        Values(DEP,'CAF','PT','L','41','55','RJ');

        Insert into T_Politicas
        (c_neg_codigo, Superficie, Area_Tipica, Trafego, Pci_Ini, Pci_fim, Servico_Codigo)
        Values(DEP,'CAF','PT','L','56','70','RP');

        Insert into T_Politicas
        (c_neg_codigo, Superficie, Area_Tipica, Trafego, Pci_Ini, Pci_fim, Servico_Codigo)
        Values(DEP,'CAF','PT','L','71','85','SL');

        Insert into T_Politicas
        (c_neg_codigo, Superficie, Area_Tipica, Trafego, Pci_Ini, Pci_fim, Servico_Codigo)
        Values(DEP,'CAF','PT','L','86','100','CR');

        Insert into T_Politicas
        (c_neg_codigo, Superficie, Area_Tipica, Trafego, Pci_Ini, Pci_fim, Servico_Codigo)
        Values(DEP,'CAF','PT','M','0','10','RRP');

        Insert into T_Politicas
        (c_neg_codigo, Superficie, Area_Tipica, Trafego, Pci_Ini, Pci_fim, Servico_Codigo)
        Values(DEP,'CAF','PT','M','11','25','RRP');

        Insert into T_Politicas
        (c_neg_codigo, Superficie, Area_Tipica, Trafego, Pci_Ini, Pci_fim, Servico_Codigo)
        Values(DEP,'CAF','PT','M','26','40','RCM');

        Insert into T_Politicas
        (c_neg_codigo, Superficie, Area_Tipica, Trafego, Pci_Ini, Pci_fim, Servico_Codigo)
        Values(DEP,'CAF','PT','M','41','55','RCD');

        Insert into T_Politicas
        (c_neg_codigo, Superficie, Area_Tipica, Trafego, Pci_Ini, Pci_fim, Servico_Codigo)
        Values(DEP,'CAF','PT','M','56','70','RP');

        Insert into T_Politicas
        (c_neg_codigo, Superficie, Area_Tipica, Trafego, Pci_Ini, Pci_fim, Servico_Codigo)
        Values(DEP,'CAF','PT','M','71','85','SL');

        Insert into T_Politicas
        (c_neg_codigo, Superficie, Area_Tipica, Trafego, Pci_Ini, Pci_fim, Servico_Codigo)
        Values(DEP,'CAF','PT','M','86','100','CR');

        Insert into T_Politicas
        (c_neg_codigo, Superficie, Area_Tipica, Trafego, Pci_Ini, Pci_fim, Servico_Codigo)
        Values(DEP,'CAF','PT','P','0','10','RRP');

        Insert into T_Politicas
        (c_neg_codigo, Superficie, Area_Tipica, Trafego, Pci_Ini, Pci_fim, Servico_Codigo)
        Values(DEP,'CAF','PT','P','11','25','RRP');

        Insert into T_Politicas
        (c_neg_codigo, Superficie, Area_Tipica, Trafego, Pci_Ini, Pci_fim, Servico_Codigo)
        Values(DEP,'CAF','PT','P','26','40','RCE');

        Insert into T_Politicas
        (c_neg_codigo, Superficie, Area_Tipica, Trafego, Pci_Ini, Pci_fim, Servico_Codigo)
        Values(DEP,'CAF','PT','P','41','55','RCD');

        Insert into T_Politicas
        (c_neg_codigo, Superficie, Area_Tipica, Trafego, Pci_Ini, Pci_fim, Servico_Codigo)
        Values(DEP,'CAF','PT','P','56','70','RJ');

        Insert into T_Politicas
        (c_neg_codigo, Superficie, Area_Tipica, Trafego, Pci_Ini, Pci_fim, Servico_Codigo)
        Values(DEP,'CAF','PT','P','71','85','RP');

        Insert into T_Politicas
        (c_neg_codigo, Superficie, Area_Tipica, Trafego, Pci_Ini, Pci_fim, Servico_Codigo)
        Values(DEP,'CAF','PT','P','86','100','CR');

        Insert into T_Politicas
        (c_neg_codigo, Superficie, Area_Tipica, Trafego, Pci_Ini, Pci_fim, Servico_Codigo)
        Values(DEP,'CCP','PA','L','0','10','SP');

        Insert into T_Politicas
        (c_neg_codigo, Superficie, Area_Tipica, Trafego, Pci_Ini, Pci_fim, Servico_Codigo)
        Values(DEP,'CCP','PA','L','11','25','SP');

        Insert into T_Politicas
        (c_neg_codigo, Superficie, Area_Tipica, Trafego, Pci_Ini, Pci_fim, Servico_Codigo)
        Values(DEP,'CCP','PA','L','26','40','SP');

        Insert into T_Politicas
        (c_neg_codigo, Superficie, Area_Tipica, Trafego, Pci_Ini, Pci_fim, Servico_Codigo)
        Values(DEP,'CCP','PA','L','41','55','RM');

        Insert into T_Politicas
        (c_neg_codigo, Superficie, Area_Tipica, Trafego, Pci_Ini, Pci_fim, Servico_Codigo)
        Values(DEP,'CCP','PA','L','56','70','STJ');

        Insert into T_Politicas
        (c_neg_codigo, Superficie, Area_Tipica, Trafego, Pci_Ini, Pci_fim, Servico_Codigo)
        Values(DEP,'CCP','PA','L','71','85','STJ');

        Insert into T_Politicas
        (c_neg_codigo, Superficie, Area_Tipica, Trafego, Pci_Ini, Pci_fim, Servico_Codigo)
        Values(DEP,'CCP','PA','L','86','100','CRC');

        Insert into T_Politicas
        (c_neg_codigo, Superficie, Area_Tipica, Trafego, Pci_Ini, Pci_fim, Servico_Codigo)
        Values(DEP,'CCP','PA','M','0','10','RRPC');

        Insert into T_Politicas
        (c_neg_codigo, Superficie, Area_Tipica, Trafego, Pci_Ini, Pci_fim, Servico_Codigo)
        Values(DEP,'CCP','PA','M','11','25','RRPC');

        Insert into T_Politicas
        (c_neg_codigo, Superficie, Area_Tipica, Trafego, Pci_Ini, Pci_fim, Servico_Codigo)
        Values(DEP,'CCP','PA','M','26','40','SP');

        Insert into T_Politicas
        (c_neg_codigo, Superficie, Area_Tipica, Trafego, Pci_Ini, Pci_fim, Servico_Codigo)
        Values(DEP,'CCP','PA','M','41','55','SP');

        Insert into T_Politicas
        (c_neg_codigo, Superficie, Area_Tipica, Trafego, Pci_Ini, Pci_fim, Servico_Codigo)
        Values(DEP,'CCP','PA','M','56','70','RM');

        Insert into T_Politicas
        (c_neg_codigo, Superficie, Area_Tipica, Trafego, Pci_Ini, Pci_fim, Servico_Codigo)
        Values(DEP,'CCP','PA','M','71','85','STJ');

        Insert into T_Politicas
        (c_neg_codigo, Superficie, Area_Tipica, Trafego, Pci_Ini, Pci_fim, Servico_Codigo)
        Values(DEP,'CCP','PA','M','86','100','CRC');

        Insert into T_Politicas
        (c_neg_codigo, Superficie, Area_Tipica, Trafego, Pci_Ini, Pci_fim, Servico_Codigo)
        Values(DEP,'CCP','PA','P','0','10','RRPC');

        Insert into T_Politicas
        (c_neg_codigo, Superficie, Area_Tipica, Trafego, Pci_Ini, Pci_fim, Servico_Codigo)
        Values(DEP,'CCP','PA','P','11','25','RRPC');

        Insert into T_Politicas
        (c_neg_codigo, Superficie, Area_Tipica, Trafego, Pci_Ini, Pci_fim, Servico_Codigo)
        Values(DEP,'CCP','PA','P','26','40','SP');

        Insert into T_Politicas
        (c_neg_codigo, Superficie, Area_Tipica, Trafego, Pci_Ini, Pci_fim, Servico_Codigo)
        Values(DEP,'CCP','PA','P','41','55','SP');

        Insert into T_Politicas
        (c_neg_codigo, Superficie, Area_Tipica, Trafego, Pci_Ini, Pci_fim, Servico_Codigo)
        Values(DEP,'CCP','PA','P','56','70','RM');

        Insert into T_Politicas
        (c_neg_codigo, Superficie, Area_Tipica, Trafego, Pci_Ini, Pci_fim, Servico_Codigo)
        Values(DEP,'CCP','PA','P','71','85','STJ');

        Insert into T_Politicas
        (c_neg_codigo, Superficie, Area_Tipica, Trafego, Pci_Ini, Pci_fim, Servico_Codigo)
        Values(DEP,'CCP','PA','P','86','100','CRC');

        Insert into T_Politicas
        (c_neg_codigo, Superficie, Area_Tipica, Trafego, Pci_Ini, Pci_fim, Servico_Codigo)
        Values(DEP,'CCP','PP','L','0','10','SP');

        Insert into T_Politicas
        (c_neg_codigo, Superficie, Area_Tipica, Trafego, Pci_Ini, Pci_fim, Servico_Codigo)
        Values(DEP,'CCP','PP','L','11','25','SP');

        Insert into T_Politicas
        (c_neg_codigo, Superficie, Area_Tipica, Trafego, Pci_Ini, Pci_fim, Servico_Codigo)
        Values(DEP,'CCP','PP','L','26','40','SP');

        Insert into T_Politicas
        (c_neg_codigo, Superficie, Area_Tipica, Trafego, Pci_Ini, Pci_fim, Servico_Codigo)
        Values(DEP,'CCP','PP','L','41','55','RM');

        Insert into T_Politicas
        (c_neg_codigo, Superficie, Area_Tipica, Trafego, Pci_Ini, Pci_fim, Servico_Codigo)
        Values(DEP,'CCP','PP','L','56','70','STJ');

        Insert into T_Politicas
        (c_neg_codigo, Superficie, Area_Tipica, Trafego, Pci_Ini, Pci_fim, Servico_Codigo)
        Values(DEP,'CCP','PP','L','71','85','CRC');

        Insert into T_Politicas
        (c_neg_codigo, Superficie, Area_Tipica, Trafego, Pci_Ini, Pci_fim, Servico_Codigo)
        Values(DEP,'CCP','PP','L','86','100','CRC');

        Insert into T_Politicas
        (c_neg_codigo, Superficie, Area_Tipica, Trafego, Pci_Ini, Pci_fim, Servico_Codigo)
        Values(DEP,'CCP','PP','M','0','10','RRPC');

        Insert into T_Politicas
        (c_neg_codigo, Superficie, Area_Tipica, Trafego, Pci_Ini, Pci_fim, Servico_Codigo)
        Values(DEP,'CCP','PP','M','11','25','RRPC');

        Insert into T_Politicas
        (c_neg_codigo, Superficie, Area_Tipica, Trafego, Pci_Ini, Pci_fim, Servico_Codigo)
        Values(DEP,'CCP','PP','M','26','40','SP');

        Insert into T_Politicas
        (c_neg_codigo, Superficie, Area_Tipica, Trafego, Pci_Ini, Pci_fim, Servico_Codigo)
        Values(DEP,'CCP','PP','M','41','55','SP');

        Insert into T_Politicas
        (c_neg_codigo, Superficie, Area_Tipica, Trafego, Pci_Ini, Pci_fim, Servico_Codigo)
        Values(DEP,'CCP','PP','M','56','70','RM');

        Insert into T_Politicas
        (c_neg_codigo, Superficie, Area_Tipica, Trafego, Pci_Ini, Pci_fim, Servico_Codigo)
        Values(DEP,'CCP','PP','M','71','85','STJ');

        Insert into T_Politicas
        (c_neg_codigo, Superficie, Area_Tipica, Trafego, Pci_Ini, Pci_fim, Servico_Codigo)
        Values(DEP,'CCP','PP','M','86','100','CRC');

        Insert into T_Politicas
        (c_neg_codigo, Superficie, Area_Tipica, Trafego, Pci_Ini, Pci_fim, Servico_Codigo)
        Values(DEP,'CCP','PP','P','0','10','RRPC');

        Insert into T_Politicas
        (c_neg_codigo, Superficie, Area_Tipica, Trafego, Pci_Ini, Pci_fim, Servico_Codigo)
        Values(DEP,'CCP','PP','P','11','25','RRPC');

        Insert into T_Politicas
        (c_neg_codigo, Superficie, Area_Tipica, Trafego, Pci_Ini, Pci_fim, Servico_Codigo)
        Values(DEP,'CCP','PP','P','26','40','SP');

        Insert into T_Politicas
        (c_neg_codigo, Superficie, Area_Tipica, Trafego, Pci_Ini, Pci_fim, Servico_Codigo)
        Values(DEP,'CCP','PP','P','41','55','SP');

        Insert into T_Politicas
        (c_neg_codigo, Superficie, Area_Tipica, Trafego, Pci_Ini, Pci_fim, Servico_Codigo)
        Values(DEP,'CCP','PP','P','56','70','RM');

        Insert into T_Politicas
        (c_neg_codigo, Superficie, Area_Tipica, Trafego, Pci_Ini, Pci_fim, Servico_Codigo)
        Values(DEP,'CCP','PP','P','71','85','STJ');

        Insert into T_Politicas
        (c_neg_codigo, Superficie, Area_Tipica, Trafego, Pci_Ini, Pci_fim, Servico_Codigo)
        Values(DEP,'CCP','PP','P','86','100','CRC');

        Insert into T_Politicas
        (c_neg_codigo, Superficie, Area_Tipica, Trafego, Pci_Ini, Pci_fim, Servico_Codigo)
        Values(DEP,'CCP','PT','L','0','10','SP');

        Insert into T_Politicas
        (c_neg_codigo, Superficie, Area_Tipica, Trafego, Pci_Ini, Pci_fim, Servico_Codigo)
        Values(DEP,'CCP','PT','L','11','25','SP');

        Insert into T_Politicas
        (c_neg_codigo, Superficie, Area_Tipica, Trafego, Pci_Ini, Pci_fim, Servico_Codigo)
        Values(DEP,'CCP','PT','L','26','40','SP');

        Insert into T_Politicas
        (c_neg_codigo, Superficie, Area_Tipica, Trafego, Pci_Ini, Pci_fim, Servico_Codigo)
        Values(DEP,'CCP','PT','L','41','55','RM');

        Insert into T_Politicas
        (c_neg_codigo, Superficie, Area_Tipica, Trafego, Pci_Ini, Pci_fim, Servico_Codigo)
        Values(DEP,'CCP','PT','L','56','70','STJ');

        Insert into T_Politicas
        (c_neg_codigo, Superficie, Area_Tipica, Trafego, Pci_Ini, Pci_fim, Servico_Codigo)
        Values(DEP,'CCP','PT','L','71','85','CRC');

        Insert into T_Politicas
        (c_neg_codigo, Superficie, Area_Tipica, Trafego, Pci_Ini, Pci_fim, Servico_Codigo)
        Values(DEP,'CCP','PT','L','86','100','CRC');

        Insert into T_Politicas
        (c_neg_codigo, Superficie, Area_Tipica, Trafego, Pci_Ini, Pci_fim, Servico_Codigo)
        Values(DEP,'CCP','PT','M','0','10','RRPC');

        Insert into T_Politicas
        (c_neg_codigo, Superficie, Area_Tipica, Trafego, Pci_Ini, Pci_fim, Servico_Codigo)
        Values(DEP,'CCP','PT','M','11','25','RRPC');

        Insert into T_Politicas
        (c_neg_codigo, Superficie, Area_Tipica, Trafego, Pci_Ini, Pci_fim, Servico_Codigo)
        Values(DEP,'CCP','PT','M','26','40','SP');

        Insert into T_Politicas
        (c_neg_codigo, Superficie, Area_Tipica, Trafego, Pci_Ini, Pci_fim, Servico_Codigo)
        Values(DEP,'CCP','PT','M','41','55','RM');

        Insert into T_Politicas
        (c_neg_codigo, Superficie, Area_Tipica, Trafego, Pci_Ini, Pci_fim, Servico_Codigo)
        Values(DEP,'CCP','PT','M','56','70','STJ');

        Insert into T_Politicas
        (c_neg_codigo, Superficie, Area_Tipica, Trafego, Pci_Ini, Pci_fim, Servico_Codigo)
        Values(DEP,'CCP','PT','M','71','85','CRC');

        Insert into T_Politicas
        (c_neg_codigo, Superficie, Area_Tipica, Trafego, Pci_Ini, Pci_fim, Servico_Codigo)
        Values(DEP,'CCP','PT','M','86','100','CRC');

        Insert into T_Politicas
        (c_neg_codigo, Superficie, Area_Tipica, Trafego, Pci_Ini, Pci_fim, Servico_Codigo)
        Values(DEP,'CCP','PT','P','0','10','RRPC');

        Insert into T_Politicas
        (c_neg_codigo, Superficie, Area_Tipica, Trafego, Pci_Ini, Pci_fim, Servico_Codigo)
        Values(DEP,'CCP','PT','P','11','25','RRPC');

        Insert into T_Politicas
        (c_neg_codigo, Superficie, Area_Tipica, Trafego, Pci_Ini, Pci_fim, Servico_Codigo)
        Values(DEP,'CCP','PT','P','26','40','SP');

        Insert into T_Politicas
        (c_neg_codigo, Superficie, Area_Tipica, Trafego, Pci_Ini, Pci_fim, Servico_Codigo)
        Values(DEP,'CCP','PT','P','41','55','SP');

        Insert into T_Politicas
        (c_neg_codigo, Superficie, Area_Tipica, Trafego, Pci_Ini, Pci_fim, Servico_Codigo)
        Values(DEP,'CCP','PT','P','56','70','RM');

        Insert into T_Politicas
        (c_neg_codigo, Superficie, Area_Tipica, Trafego, Pci_Ini, Pci_fim, Servico_Codigo)
        Values(DEP,'CCP','PT','P','71','85','STJ');

        Insert into T_Politicas
        (c_neg_codigo, Superficie, Area_Tipica, Trafego, Pci_Ini, Pci_fim, Servico_Codigo)               Values(DEP,'CCP','PT','P','86','100','CRC');

        COMMIT;
    END INSERE_POLITICAS;
END FUNCOES_SGP;
/
SHOW ERROR
         