CREATE OR REPLACE PROCEDURE IFRSIVNET.PRC_CHECKUP_SIVNET
IS

--declare

   v_corpo_comp_msg  varchar2(1500):= null;
   v_corpo_loca_msg  varchar2(1500):= null;
   v_corpo_atua_msg  varchar2(1500):= null;
   v_corpo_zero_msg  varchar2(1500):= null;
   reg               varchar2(4);
   v_comp_cont number(4) := 0;
   v_loca_cont number(4) := 0;
   v_atua_cont number(4) := 0;
   v_zero_cont number(4) := 0;

/*----------------------------------------------------------------------------------
-- Procedure Realizar o check-up do sivnet(Companhias, Atualização e Localidades
-- Criado por Elysio Pires
-- Alterado por Jônatas Bomtempo em 07/07/2005
-- Dependencias:  TISI
----------------------------------------------------------------------------------*/
/*Dado um Aeroporto retorna qual sua regional, Foi adotado fixar este codigos dentro do 
programa pelo fato de não termos uma tabela com as regionais no Banco INET, temos somentes os aeroportos.*/
procedure GetRegionalAeroporto(cdAeroporto in varchar,
                               cdRegional  out varchar) is
begin

 /*Regional Centro Oeste*/
 if cdAeroporto in ('SBBR','SBGO','SBCY','SBUR','SBPM','SBPJ','SBUL') then
   cdRegional := 'SRBR';   
   
  /*Regional Leste*/
 elsif cdAeroporto in ('SBCP','SBRJ','SBJF','SBME','SBJR','SBVT','SBPR','SBMK','SBCF','SBBH','SBGL') then
   cdRegional := 'SRGL';   
   
  /*Regional Sudeste*/
 elsif cdAeroporto in ('SBSJ','SBPP','SBCG','SBKP','SBMT','SBCR','SBSP','SBGR') then
   cdRegional := 'SRGR';    
   
  /*Regional Sul*/
 elsif cdAeroporto in ('SBCT','SBPK','SBUG','SBLO','SBFL','SBPA','SBNF','SBBI','SBBG','SBJV','SBFI') then
   cdRegional := 'SRPA';   
   
  /*Regional Nordeste*/
 elsif cdAeroporto in ('SBJU','SBPL','SBMO','SBTE','SBJP','SBKG','SBFZ','SBNT','SBRF','SBPB') then
     cdRegional := 'SRRF';   
     
  /*Regional Centro-Leste*/
 elsif cdAeroporto in ('SBUF','SBIL','SBSV','SBAR') then
     cdRegional := 'SRSV';   
     
  /*Regional Noroeste*/
 elsif cdAeroporto in ('SBBV','SBRB','SBPV','SBTF','SBCZ','SBTT','SBEG') then
    cdRegional := 'SRMN';   
 
  /*Regional Norte*/
 elsif cdAeroporto in ('SBBE','SBCJ','SBJC','SBIZ','SBMA','SBSN','SBHT','SBSL','SBMQ') then
   cdRegional := 'SRBE';   
 end if;
 
end;
-----------------------------------------------------------------------------------
procedure VerificaGrupo(cdAeroporto varchar,
                        Corpo       varchar,
                        Controle    number,
						Regional    varchar) is
begin
--    if Controle = '1' then
--         envia_email('SIVNET_SEDE@infraero.gov.br','SIVNET_GPDI@infraero.gov.br','SIVNET - Identificacao de Companhias Aérea',v_corpo_comp_msg);
--         envia_email('SIVNET_SEDE@infraero.gov.br','SIVNET_'||Regional||'@infraero.gov.br','SIVNET - Identificacao de Companhias Aérea',v_corpo_comp_msg);         
 --        envia_email('SIVNET_SEDE@infraero.gov.br','SIVNET_SEDE@infraero.gov.br','Acompanhamento equipe SIVNET - Identificacao de Companhias Aérea',v_corpo_comp_msg);                  
--    END IF;

--    if Controle = '2' then
--         envia_email('SIVNET_SEDE@infraero.gov.br','SIVNET_GPDI@infraero.gov.br','SIVNET - Identificacao de Localidades Desconhecidas',v_corpo_loca_msg);
--         envia_email('SIVNET_SEDE@infraero.gov.br','SIVNET_'||Regional||'@infraero.gov.br','SIVNET - Identificacao de Localidades Desconhecidas',v_corpo_loca_msg);         
--         envia_email('SIVNET_SEDE@infraero.gov.br','SIVNET_SEDE@infraero.gov.br','Acompanhamento equipe SIVNET - Identificacao de Localidades Desconhecidas',v_corpo_loca_msg);                  
--    END IF;

    if Controle = '3' then
         envia_email('SIVNET_SEDE@infraero.gov.br','SIVNET_'||cdAeroporto||'@infraero.gov.br','SIVNET - Aeroporto com voos desatualizados a mais de 30 minutos',v_corpo_atua_msg);
         envia_email('SIVNET_SEDE@infraero.gov.br','SIVNET_'||Regional||'@infraero.gov.br','SIVNET - Aeroporto com voos desatualizados a mais de 30 minutos',v_corpo_atua_msg);         
--         envia_email('SIVNET_SEDE@infraero.gov.br','SIVNET_SEDE@infraero.gov.br','Acompanhamento equipe SIVNET - Aeroporto com voos desatualizados a mais de 30 minutos',v_corpo_atua_msg);                  
    END IF;

    if Controle = '4' then
         envia_email('SIVNET_SEDE@infraero.gov.br','SIVNET_'||cdAeroporto||'@infraero.gov.br','CHECKUP - Atencao!!! Aeroportos enviando arquivos sem Informação de Vôos!!!',v_corpo_zero_msg);
         envia_email('SIVNET_SEDE@infraero.gov.br','SIVNET_'||Regional||'@infraero.gov.br','CHECKUP - Atencao!!! Aeroportos enviando arquivos sem Informação de Vôos!!!',v_corpo_zero_msg);         
--         envia_email('SIVNET_SEDE@infraero.gov.br','SIVNET_SEDE@infraero.gov.br','Acompanhamento equipe SIVNET CHECKUP - Atencao!!! Aeroportos enviando arquivos sem Informação de Vôos!!!',v_corpo_zero_msg);                  
    END IF;

end;
-------------------------------------------------------------------------------------
begin
 ----------------------------------------------------------------
 -- Verifica Companhias Não Cadastradas
 ----------------------------------------------------------------
 DECLARE
  CURSOR checaCOMP IS
    SELECT distinct v.cd_cia, v.cd_aeroporto
     FROM voo_operacao v, cia_aerea c
     Where v.cd_cia = c.cod_cia (+)
        and c.cod_cia is null;
  BEGIN

  v_corpo_comp_msg := v_corpo_comp_msg||chr(13)||'O arquivo com as informações dos vôos deste aeroporto contem um '||chr(13)
                                               ||'código de companhia aérea não cadastrada no SIVNET.'||chr(13)
											   ||' '||chr(13)
  											   ||'Por favor corrigir o código da companhia aérea, ou solicitar sua inclusão '||chr(13)
											   ||'no SIVNET enviando uma mensagem para o endereço SIVNET_SEDE@infraero.gov.br '||chr(13)
											   ||'informando o código e o nome da companhia informada abaixo.'||chr(13);

  FOR x IN checaCOMP LOOP

      v_comp_cont := v_comp_cont+1;

      v_corpo_comp_msg := 
	  'Aeroporto : '||x.cd_aeroporto||chr(13)
	                ||' '||chr(13)
					||v_corpo_comp_msg||chr(13)
					||'Codigo Companhia: '||x.cd_cia||chr(13)
					||' '||chr(13)
					||'Nome da Companhia :';
	   
--      v_corpo_comp_msg :=v_corpo_comp_msg||chr(13)||
      
--      'Codigo Aeroporto: '||x.cd_aeroporto;
      
  	     GetRegionalAeroporto(x.cd_Aeroporto,reg);
	  
         VerificaGrupo(x.cd_aeroporto ,v_corpo_comp_msg,1,reg);
      
         v_corpo_comp_msg:= null;
         
  end loop;

 END;
 ----------------------------------------------------------------
 -- Verifica Localidades Não Cadastradas
 ----------------------------------------------------------------
 DECLARE

  CURSOR checaLOCA IS
   SELECT distinct v.cd_dest_orig_iata, v.cd_dest_orig_icao, v.cd_aeroporto, v.dt_voo, v.cd_cia, v.nu_voo,c.nome_cia
    FROM voo_operacao v, localidade l,cia_aerea c
    Where v.cd_dest_orig_iata = l.cd_local_iata (+)
    and v.cd_cia = c.cod_cia
             and l.cd_local_iata is null  ;
  BEGIN
      

      FOR y IN checaLOCA LOOP
          v_loca_cont :=v_loca_cont+1;
          v_corpo_loca_msg :=v_corpo_loca_msg||chr(13)||'Por favor identificar as localidades dos Codigos IATA e ICAO informados abaixo e retornar
          essas ao grupo responsável para cadastro no email SIVNETSEDE@infraero.gov.br'||chr(13)||chr(13);
          
          v_corpo_loca_msg :=v_corpo_loca_msg||chr(13)||
          'Codigo IATA: '||y.cd_dest_orig_iata||chr(13)||
          'Codigo ICAO: '||y.cd_dest_orig_icao||chr(13)||
          'Data do Voo: '||y.dt_voo||chr(13)||
          'Companhia Aerea: '||y.cd_cia||' - '||y.nome_cia||chr(13)||
          'Número do Voo: '||y.nu_voo||chr(13)||
          'Codigo Aeroporto: '||y.cd_aeroporto||
          chr(13)||chr(13);
  	      
		  GetRegionalAeroporto(y.cd_Aeroporto,reg);
          
		  VerificaGrupo(y.cd_aeroporto ,v_corpo_loca_msg,2,reg);          

          v_corpo_loca_msg:= null;          

      end loop;
  END;
 ----------------------------------------------------------------
 -- Verifica as Atualizações
 ----------------------------------------------------------------
 DECLARE

  CURSOR checaATUA IS
  
   select distinct 
          v.CD_AEROPORTO,
		  to_char(v.atual,'hh24:mi:ss') atual1,
		  to_char(v.atual,'dd/mm/yyyy') atual2,
		  l.nm_aeroporto  
		  from voo_operacao_v v,
               localidade l  
		  where v.atual < sysdate-1/48
          and v.cd_aeroporto = l.cd_local_icao;
   
  BEGIN

       
      FOR z IN checaATUA LOOP

          v_atua_cont := v_atua_cont+1;

          v_corpo_atua_msg :=v_corpo_atua_msg||chr(13)||'O servidor do SIVNET nao esta recebendo os arquivos para atualizacao dos voos on line desde as '||z.atual1||' do dia '||z.atual2||'.'||chr(13)||'Por favor verificar a rotina de envio dos arquivos desse servidor.'||chr(13);

          v_corpo_atua_msg :=v_corpo_atua_msg||chr(13)||'Aeroporto: '||z.cd_aeroporto||' - '||z.nm_aeroporto;

		  GetRegionalAeroporto(z.cd_Aeroporto,reg);          
		  
          VerificaGrupo(z.cd_aeroporto ,v_corpo_atua_msg,3,reg);    
          
		  v_corpo_atua_msg := null;
		        
      end loop;
      
  END;
 ----------------------------------------------------------------
 -- Verifica Arquivos Sem Informações de Voos
 ----------------------------------------------------------------
 DECLARE

  CURSOR checaQTDVoos IS

   /* Arquivos sem informações de voo */
   SELECT a.cd_aeroporto, a.qt_voos,l.nm_aeroporto
   FROM ifrsivnet.siv_atual a,
       ifrsivnet.localidade l
   where  qt_voos = 0
   and a.cd_aeroporto = l.cd_local_icao
   and l.adm_infra = 'SIM';
   
  BEGIN
       
      FOR z IN checaQTDVoos LOOP

          v_atua_cont :=v_atua_cont+1;

          v_corpo_zero_msg :=v_corpo_zero_msg||chr(13)||'Foi identificado que o Arquivo enviado por este Aeroporto esta sem informações de Vôos. Por gentileza verificar se 
		  realmente não existem voos ou se há problemas na geração do mesmo.';

          v_corpo_zero_msg :=v_corpo_zero_msg||chr(13)||'Aeroporto: '||z.cd_aeroporto||' - '||z.nm_aeroporto;

		  GetRegionalAeroporto(z.cd_Aeroporto,reg);          
		  
          VerificaGrupo(z.cd_aeroporto ,v_corpo_zero_msg,4,reg);    
          
		  v_corpo_zero_msg := null;
		        
      end loop;
      
  END;

end;
