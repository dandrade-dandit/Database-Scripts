CREATE OR REPLACE PROCEDURE PRC_GERA_XML(STIPO VARCHAR2) IS
  CURSOR cAEROPORTO IS
        select l.nm_cidade, l.nm_aeroporto, o.cd_aeroporto
        from   localidade l,  voo_operacao o
        where  l.cd_local_icao = o.cd_aeroporto
        group by l.nm_cidade, l.nm_aeroporto, o.cd_aeroporto;
  DADOS_AEROPORTO cAEROPORTO%ROWTYPE;
  
  CURSOR cORIGEM_DESTINO IS
       select v.cd_aeroporto, v.cd_sentido, 
              decode(nvl(nm_cidade,'..'),'..',cd_dest_orig_iata,nm_cidade) cidade,
              v.cd_dest_orig_iata
			 from   voo_operacao v, localidade l
			 where  v.cd_dest_orig_iata = l.cd_local_iata(+)
			 group  by v.cd_aeroporto, v.cd_sentido,
			           decode(nvl(nm_cidade,'..'),'..',cd_dest_orig_iata,nm_cidade), 
			           v.cd_dest_orig_iata;
  DADOS_ORI_DES cORIGEM_DESTINO%ROWTYPE;			           
  
  CURSOR cORI_DES_COMPANHIA IS
       select cd_aeroporto, cd_sentido, cd_cia,  
              decode(nvl(nm_cidade,'..'),'..',cd_dest_orig_iata,nm_cidade) cidade,
              cd_dest_orig_iata
       from   voo_operacao v, localidade l
       where  v.cd_dest_orig_iata = l.cd_local_iata(+)
       group  by cd_aeroporto, cd_sentido, cd_cia,  
                 decode(nvl(nm_cidade,'..'),'..',cd_dest_orig_iata,nm_cidade),
                 cd_dest_orig_iata ;
  DADOS_ORI_DES_COMPANHIA cORI_DES_COMPANHIA%ROWTYPE;
  
  CURSOR cCOMPANHIA_AEREA IS
       select cd_aeroporto, cd_sentido, cd_cia, 
              decode(nvl(nome_cia,'..'),'..',cd_cia,nome_cia) companhia             
			 from   voo_operacao v, cia_aerea c
			 where  v.cd_cia = c.cod_cia(+)
			 group  by v.cd_aeroporto, v.cd_sentido, 
			           decode(nvl(nome_cia,'..'),'..',cd_cia,nome_cia), 
			           v.cd_cia;
  DADOS_COMPANHIA_AEREA cCOMPANHIA_AEREA%ROWTYPE;
  
  CURSOR cCOMPANHIA_AEREA_ORI_DES IS
       select cd_aeroporto, cd_sentido, cd_dest_orig_iata,  cd_cia,               
              decode(nvl(nome_cia,'..'),'..',cd_cia,nome_cia) companhia     
  		 from   voo_operacao v, cia_aerea c
			 where  v.cd_cia = c.cod_cia(+)
			 group  by cd_aeroporto, cd_sentido, cd_dest_orig_iata, cd_cia,                         
			           decode(nvl(nome_cia,'..'),'..',cd_cia,nome_cia);
  DADOS_COMPANHIA_AEREA_ORI_DES cCOMPANHIA_AEREA_ORI_DES%ROWTYPE;
  
  CURSOR cNUM_VOO IS
       select cd_aeroporto, cd_sentido, nu_voo, cd_dest_orig_iata, cd_cia
			 from voo_operacao
			 group by cd_aeroporto, cd_sentido, nu_voo, cd_dest_orig_iata, cd_cia;
  DADOS_NUM_VOO cNUM_VOO%ROWTYPE;
  
  CURSOR cNUM_VOO_CIA IS
       select cd_aeroporto, cd_sentido, cd_cia, nu_voo, cd_dest_orig_iata
			 from voo_operacao
			 group by cd_aeroporto, cd_sentido, cd_cia, nu_voo, cd_dest_orig_iata;
  DADOS_NUM_VOO_CIA cNUM_VOO_CIA%ROWTYPE;
  
  CURSOR cNUM_VOO_ORI_DES IS
       select cd_aeroporto, cd_sentido, cd_dest_orig_iata, nu_voo, cd_cia
			 from voo_operacao
			 group by cd_aeroporto, cd_sentido, cd_dest_orig_iata, nu_voo, cd_cia;
  DADOS_NUM_VOO_ORI_DES cNUM_VOO_ORI_DES%ROWTYPE;
  
  vXML VARCHAR2(32767);
  v_file  Utl_File.File_Type;
  v_sentido char := 'A';
  v_aeroporto varchar2(10) := 'tttt';
  v_companhia varchar2(10) := 'aaaa';
  
BEGIN  
 IF STIPO = 'AEROPORTO' THEN
 	   open cAEROPORTO;
		 v_file := Utl_File.FOpen('/ora05/sivnet/files','aeroporto.xml','w');
		 vXML := '<?xml version="1.0" encoding="ISO8859-1"?>
		 					<!DOCTYPE AGENDA SYSTEM "DTD_TOTEM.dtd">';
		 Utl_File.Put_Line(v_file, Substr(vXML, 1, 32767));
		 vXML := '<AEROPORTO>';
		 Utl_File.Put_Line(v_file, Substr(vXML, 1, 32767));
		 LOOP
		      FETCH cAEROPORTO  INTO DADOS_AEROPORTO;
		      EXIT WHEN cAEROPORTO%NOTFOUND;		      		         
		      IF INSTR(DADOS_AEROPORTO.NM_CIDADE, '-') > 0 THEN
		         vXML := '<NOME codigo='||'"'||DADOS_AEROPORTO.CD_AEROPORTO||'"'||'>'||ltrim(rtrim(substr(DADOS_AEROPORTO.NM_CIDADE, 1, instr(DADOS_AEROPORTO.NM_CIDADE, '-')-1)))||' - '||DADOS_AEROPORTO.NM_AEROPORTO;
		      ELSE
	           vXML := '<NOME codigo='||'"'||DADOS_AEROPORTO.CD_AEROPORTO||'"'||'>'||DADOS_AEROPORTO.NM_CIDADE||' - '||DADOS_AEROPORTO.NM_AEROPORTO;
	        END IF;   
		      Utl_File.Put_Line(v_file, Substr(vXML, 1, 32767));		      
		      vXML := '</NOME>';
		      Utl_File.Put_Line(v_file, Substr(vXML, 1, 32767));
		 END LOOP;
		 close cAEROPORTO;
		 vXML := '</AEROPORTO>';
		 Utl_File.Put_Line(v_file, Substr(vXML, 1, 32767));  
		 Utl_File.FClose(v_file);
		 
	ELSIF STIPO = 'ORIGEM_DESTINO' THEN
 	   open cORIGEM_DESTINO;
		 v_file := Utl_File.FOpen('/ora05/sivnet/files','origem_destino.xml','w');
		 vXML := '<?xml version="1.0" encoding="ISO8859-1"?>
		          <!DOCTYPE AGENDA SYSTEM "DTD_TOTEM.dtd">';
		 Utl_File.Put_Line(v_file, Substr(vXML, 1, 32767));	
		 vXML := '<DADOS>';	 
		 Utl_File.Put_Line(v_file, Substr(vXML, 1, 32767));	
		 LOOP
		      FETCH cORIGEM_DESTINO  INTO DADOS_ORI_DES;
		      EXIT WHEN cORIGEM_DESTINO%NOTFOUND;
		      IF DADOS_ORI_DES.CD_AEROPORTO <> V_AEROPORTO THEN		      	 
		      	 IF V_AEROPORTO <> 'tttt' THEN
		      	 	  vXML := '</SENTIDO></AEROPORTO>';
		      	 	  Utl_File.Put_Line(v_file, Substr(vXML, 1, 32767));
		      	 END IF;	  
		      	 V_AEROPORTO := DADOS_ORI_DES.CD_AEROPORTO;
		      	 V_SENTIDO := 'A';
		      	 vXML := '<AEROPORTO codigo="'||DADOS_ORI_DES.CD_AEROPORTO||'">';	
		      	 Utl_File.Put_Line(v_file, Substr(vXML, 1, 32767));		      	 		      	 
		      END IF;
		      IF DADOS_ORI_DES.CD_SENTIDO <> V_SENTIDO THEN		      	 
		      	 IF V_SENTIDO <> 'A' THEN
		      	 	  vXML := '</SENTIDO>';
		      	 	  Utl_File.Put_Line(v_file, Substr(vXML, 1, 32767));
		      	 END IF;	  
		      	 V_SENTIDO := DADOS_ORI_DES.CD_SENTIDO;
		      	 vXML := '<SENTIDO cod_sentido="'||DADOS_ORI_DES.CD_SENTIDO||'">';	
		      	 Utl_File.Put_Line(v_file, Substr(vXML, 1, 32767));		      	 
		      	 IF V_SENTIDO = 'P' THEN
		      	   vXML := '<CIDADE cod_iata="">Todos</CIDADE>';
		      	 ELSE
		      	 	 vXML := '<CIDADE cod_iata="">Todas</CIDADE>';
		      	 END IF;
		      	 Utl_File.Put_Line(v_file, Substr(vXML, 1, 32767));
		      END IF;
		      vXML := '<CIDADE cod_iata="'||DADOS_ORI_DES.CD_DEST_ORIG_IATA||'">'||DADOS_ORI_DES.CIDADE;		      
		      Utl_File.Put_Line(v_file, Substr(vXML, 1, 32767));
		      vXML := '</CIDADE>';
		      Utl_File.Put_Line(v_file, Substr(vXML, 1, 32767));		      		      
		 END LOOP;
		 close cORIGEM_DESTINO;	
		 vXML := '</SENTIDO>';
		 Utl_File.Put_Line(v_file, Substr(vXML, 1, 32767)); 	 
		 vXML := '</AEROPORTO>';
		 Utl_File.Put_Line(v_file, Substr(vXML, 1, 32767));  
		 vXML := '</DADOS>';	 
		 Utl_File.Put_Line(v_file, Substr(vXML, 1, 32767));			 
		 Utl_File.FClose(v_file);
		 
	ELSIF STIPO = 'ORI_DES_COMPANHIA' THEN
 	   open cORI_DES_COMPANHIA;
		 v_file := Utl_File.FOpen('/ora05/sivnet/files','ori_des_companhia.xml','w');
		 vXML := '<?xml version="1.0" encoding="ISO8859-1"?>
		          <!DOCTYPE AGENDA SYSTEM "DTD_TOTEM.dtd">';
		 Utl_File.Put_Line(v_file, Substr(vXML, 1, 32767));	
		 vXML := '<DADOS>';	 
		 Utl_File.Put_Line(v_file, Substr(vXML, 1, 32767));	
		 LOOP
		      FETCH cORI_DES_COMPANHIA  INTO DADOS_ORI_DES_COMPANHIA;
		      EXIT WHEN cORI_DES_COMPANHIA%NOTFOUND;
		      IF DADOS_ORI_DES_COMPANHIA.CD_AEROPORTO <> V_AEROPORTO THEN		      	 
		      	 IF V_AEROPORTO <> 'tttt' THEN
		      	 	  vXML := '</COMPANHIA></SENTIDO></AEROPORTO>';
		      	 	  Utl_File.Put_Line(v_file, Substr(vXML, 1, 32767));
		      	 END IF;	  
		      	 V_COMPANHIA := 'aaaa';
		      	 V_SENTIDO := 'A';
		      	 V_AEROPORTO := DADOS_ORI_DES_COMPANHIA.CD_AEROPORTO;
		      	 vXML := '<AEROPORTO codigo="'||DADOS_ORI_DES_COMPANHIA.CD_AEROPORTO||'">';	
		      	 Utl_File.Put_Line(v_file, Substr(vXML, 1, 32767));		      	 
		      END IF;
		      IF DADOS_ORI_DES_COMPANHIA.CD_SENTIDO <> V_SENTIDO THEN		      	 
		      	 IF V_SENTIDO <> 'A' THEN
		      	 	  vXML := '</COMPANHIA></SENTIDO>';
		      	 	  Utl_File.Put_Line(v_file, Substr(vXML, 1, 32767));
		      	 END IF;	  
		      	 V_SENTIDO := DADOS_ORI_DES_COMPANHIA.CD_SENTIDO;
		      	 V_COMPANHIA := 'aaaa';
		      	 vXML := '<SENTIDO cod_sentido="'||DADOS_ORI_DES_COMPANHIA.CD_SENTIDO||'">';	
		      	 Utl_File.Put_Line(v_file, Substr(vXML, 1, 32767));		      	 		      	 
		      END IF;
		      IF DADOS_ORI_DES_COMPANHIA.CD_CIA <> V_COMPANHIA THEN		      	 
		      	 IF V_COMPANHIA <> 'aaaa' THEN
		      	 	  vXML := '</COMPANHIA>';
		      	 	  Utl_File.Put_Line(v_file, Substr(vXML, 1, 32767));
		      	 END IF;	  
		      	 V_COMPANHIA := DADOS_ORI_DES_COMPANHIA.CD_CIA;
		      	 vXML := '<COMPANHIA cod_companhia="'||DADOS_ORI_DES_COMPANHIA.CD_CIA||'">';
		      	 Utl_File.Put_Line(v_file, Substr(vXML, 1, 32767));		      	 
		      	 IF V_SENTIDO = 'P' THEN
		      	   vXML := '<CIDADE cod_iata="">Todos</CIDADE>';
		      	 ELSE
		      	 	 vXML := '<CIDADE cod_iata="">Todas</CIDADE>';
		      	 END IF;
		      	 Utl_File.Put_Line(v_file, Substr(vXML, 1, 32767));
		      END IF;			      
		         vXML := '<CIDADE cod_iata="'||DADOS_ORI_DES_COMPANHIA.CD_DEST_ORIG_IATA||'">'||DADOS_ORI_DES_COMPANHIA.CIDADE;		      
		         Utl_File.Put_Line(v_file, Substr(vXML, 1, 32767));
		         vXML := '</CIDADE>';
		         Utl_File.Put_Line(v_file, Substr(vXML, 1, 32767));		      		      		         
		 END LOOP;
		 close cORI_DES_COMPANHIA;		 
		 vXML := '</COMPANHIA>';
		 Utl_File.Put_Line(v_file, Substr(vXML, 1, 32767));
		 vXML := '</SENTIDO>';
		 Utl_File.Put_Line(v_file, Substr(vXML, 1, 32767)); 
		 vXML := '</AEROPORTO>';
		 Utl_File.Put_Line(v_file, Substr(vXML, 1, 32767));
		 vXML := '</DADOS>';	 
		 Utl_File.Put_Line(v_file, Substr(vXML, 1, 32767));			 
		 Utl_File.FClose(v_file);	 
		 
	ELSIF STIPO = 'COMPANHIA_AEREA' THEN
 	   open cCOMPANHIA_AEREA;
		 v_file := Utl_File.FOpen('/ora05/sivnet/files','companhia_aerea.xml','w');
		 vXML := '<?xml version="1.0" encoding="ISO8859-1"?>
		          <!DOCTYPE AGENDA SYSTEM "DTD_TOTEM.dtd">';
		 Utl_File.Put_Line(v_file, Substr(vXML, 1, 32767));	
		 vXML := '<DADOS>';	 
		 Utl_File.Put_Line(v_file, Substr(vXML, 1, 32767));	
		 LOOP
		      FETCH cCOMPANHIA_AEREA  INTO DADOS_COMPANHIA_AEREA;
		      EXIT WHEN cCOMPANHIA_AEREA%NOTFOUND;
		      IF DADOS_COMPANHIA_AEREA.CD_AEROPORTO <> V_AEROPORTO THEN		      	 
		      	 IF V_AEROPORTO <> 'tttt' THEN
		      	 	  vXML := '</SENTIDO></AEROPORTO>';
		      	 	  Utl_File.Put_Line(v_file, Substr(vXML, 1, 32767));
		      	 END IF;	  
		      	 V_AEROPORTO := DADOS_COMPANHIA_AEREA.CD_AEROPORTO;	
		      	 V_SENTIDO := 'A';	      	 
		      	 vXML := '<AEROPORTO codigo="'||DADOS_COMPANHIA_AEREA.CD_AEROPORTO||'">';	
		      	 Utl_File.Put_Line(v_file, Substr(vXML, 1, 32767));		      	 
		      END IF;	
		      IF DADOS_COMPANHIA_AEREA.CD_SENTIDO <> V_SENTIDO THEN		      	 
		      	 IF V_SENTIDO <> 'A' THEN
		      	 	  vXML := '</SENTIDO>';
		      	 	  Utl_File.Put_Line(v_file, Substr(vXML, 1, 32767));
		      	 END IF;	  
		      	 V_SENTIDO := DADOS_COMPANHIA_AEREA.CD_SENTIDO;
		      	 vXML := '<SENTIDO cod_sentido="'||DADOS_COMPANHIA_AEREA.CD_SENTIDO||'">';	
		      	 Utl_File.Put_Line(v_file, Substr(vXML, 1, 32767));		      	 
		      	 vXML := '<COMPANHIA cod_companhia="">Todas</COMPANHIA>';
		      	 Utl_File.Put_Line(v_file, Substr(vXML, 1, 32767));
		      END IF;
		      vXML := '<COMPANHIA cod_companhia="'||DADOS_COMPANHIA_AEREA.CD_CIA||'">'||DADOS_COMPANHIA_AEREA.COMPANHIA;		      
		      Utl_File.Put_Line(v_file, Substr(vXML, 1, 32767));
		      vXML := '</COMPANHIA>';
		      Utl_File.Put_Line(v_file, Substr(vXML, 1, 32767));		      		      
		 END LOOP;
		 close cCOMPANHIA_AEREA;
		 vXML := '</SENTIDO>';
		 Utl_File.Put_Line(v_file, Substr(vXML, 1, 32767));		 		 
		 vXML := '</AEROPORTO>';
		 Utl_File.Put_Line(v_file, Substr(vXML, 1, 32767));  
		 vXML := '</DADOS>';	 
		 Utl_File.Put_Line(v_file, Substr(vXML, 1, 32767));			 
		 Utl_File.FClose(v_file);
		 
	ELSIF STIPO = 'COMPANHIA_AEREA_ORI_DES' THEN
 	   open cCOMPANHIA_AEREA_ORI_DES;
		 v_file := Utl_File.FOpen('/ora05/sivnet/files','companhia_aerea_ori_des.xml','w');
		 vXML := '<?xml version="1.0" encoding="ISO8859-1"?>
		          <!DOCTYPE AGENDA SYSTEM "DTD_TOTEM.dtd">';
		 Utl_File.Put_Line(v_file, Substr(vXML, 1, 32767));	
		 vXML := '<DADOS>';	 
		 Utl_File.Put_Line(v_file, Substr(vXML, 1, 32767));	
		 LOOP
		      FETCH cCOMPANHIA_AEREA_ORI_DES  INTO DADOS_COMPANHIA_AEREA_ORI_DES;
		      EXIT WHEN cCOMPANHIA_AEREA_ORI_DES%NOTFOUND;
		      IF DADOS_COMPANHIA_AEREA_ORI_DES.CD_AEROPORTO <> V_AEROPORTO THEN		      	 
		      	 IF V_AEROPORTO <> 'tttt' THEN
		      	 	  vXML := '</CIDADE></SENTIDO></AEROPORTO>';
		      	 	  Utl_File.Put_Line(v_file, Substr(vXML, 1, 32767));
		      	 END IF;	  
		      	 V_COMPANHIA := 'aaaa';
		      	 V_SENTIDO := 'A';
		      	 V_AEROPORTO := DADOS_COMPANHIA_AEREA_ORI_DES.CD_AEROPORTO;		      	 
		      	 vXML := '<AEROPORTO codigo="'||DADOS_COMPANHIA_AEREA_ORI_DES.CD_AEROPORTO||'">';	
		      	 Utl_File.Put_Line(v_file, Substr(vXML, 1, 32767));
		      END IF;
		      IF DADOS_COMPANHIA_AEREA_ORI_DES.CD_SENTIDO <> V_SENTIDO THEN		      	 
		      	 IF V_SENTIDO <> 'A' THEN
		      	 	  vXML := '</CIDADE></SENTIDO>';
		      	 	  Utl_File.Put_Line(v_file, Substr(vXML, 1, 32767));
		      	 END IF;	  
		      	 V_SENTIDO := DADOS_COMPANHIA_AEREA_ORI_DES.CD_SENTIDO;
		      	 V_COMPANHIA := 'aaaa';
		      	 vXML := '<SENTIDO cod_sentido="'||DADOS_COMPANHIA_AEREA_ORI_DES.CD_SENTIDO||'">';	
		      	 Utl_File.Put_Line(v_file, Substr(vXML, 1, 32767));		      	 		      	 
		      END IF;
		      IF DADOS_COMPANHIA_AEREA_ORI_DES.CD_DEST_ORIG_IATA <> V_COMPANHIA THEN		      	 
		      	 IF V_COMPANHIA <> 'aaaa' THEN
		      	 	  vXML := '</CIDADE>';
		      	 	  Utl_File.Put_Line(v_file, Substr(vXML, 1, 32767));
		      	 END IF;	  
		      	 V_COMPANHIA := DADOS_COMPANHIA_AEREA_ORI_DES.CD_DEST_ORIG_IATA;
		      	 vXML := '<CIDADE cod_iata="'||DADOS_COMPANHIA_AEREA_ORI_DES.CD_DEST_ORIG_IATA||'">';
		      	 Utl_File.Put_Line(v_file, Substr(vXML, 1, 32767));
		      	 vXML := '<COMPANHIA cod_companhia="">Todas</COMPANHIA>';
		      	 Utl_File.Put_Line(v_file, Substr(vXML, 1, 32767));
		      END IF;			      
		         vXML := '<COMPANHIA cod_companhia="'||DADOS_COMPANHIA_AEREA_ORI_DES.CD_CIA||'">'||DADOS_COMPANHIA_AEREA_ORI_DES.COMPANHIA;		      
		         Utl_File.Put_Line(v_file, Substr(vXML, 1, 32767));
		         vXML := '</COMPANHIA>';
		         Utl_File.Put_Line(v_file, Substr(vXML, 1, 32767));		      		      
		 END LOOP;
		 close cCOMPANHIA_AEREA_ORI_DES;		 
		 vXML := '</CIDADE>';
		 Utl_File.Put_Line(v_file, Substr(vXML, 1, 32767)); 
		 vXML := '</SENTIDO>';
		 Utl_File.Put_Line(v_file, Substr(vXML, 1, 32767)); 
		 vXML := '</AEROPORTO>';
		 Utl_File.Put_Line(v_file, Substr(vXML, 1, 32767));
		 vXML := '</DADOS>';	 
		 Utl_File.Put_Line(v_file, Substr(vXML, 1, 32767));			 
		 Utl_File.FClose(v_file);
	
	ELSIF STIPO = 'NUM_VOO' THEN
 	   open cNUM_VOO;
		 v_file := Utl_File.FOpen('/ora05/sivnet/files','num_voo.xml','w');
		 vXML := '<?xml version="1.0" encoding="ISO8859-1"?>
		          <!DOCTYPE AGENDA SYSTEM "DTD_TOTEM.dtd">';
		 Utl_File.Put_Line(v_file, Substr(vXML, 1, 32767));
		 vXML := '<DADOS>';
		 Utl_File.Put_Line(v_file, Substr(vXML, 1, 32767));
		 LOOP
		      FETCH cNUM_VOO  INTO DADOS_NUM_VOO;
		      EXIT WHEN cNUM_VOO%NOTFOUND;		      		         
		      IF DADOS_NUM_VOO.CD_AEROPORTO <> V_AEROPORTO THEN		      	 
		      	 IF V_AEROPORTO <> 'tttt' THEN
		      	 	  vXML := '</SENTIDO></AEROPORTO>';
		      	 	  Utl_File.Put_Line(v_file, Substr(vXML, 1, 32767));
		      	 END IF;	  		      	 
		      	 V_AEROPORTO := DADOS_NUM_VOO.CD_AEROPORTO;	
		      	 V_SENTIDO := 'A';		      	 	      	 
		      	 vXML := '<AEROPORTO codigo="'||DADOS_NUM_VOO.CD_AEROPORTO||'">';		
		      	 Utl_File.Put_Line(v_file, Substr(vXML, 1, 32767));		      	 
		      END IF;
		      IF DADOS_NUM_VOO.CD_SENTIDO <> V_SENTIDO THEN		      	 
		      	 IF V_SENTIDO <> 'A' THEN
		      	 	  vXML := '</SENTIDO>';
		      	 	  Utl_File.Put_Line(v_file, Substr(vXML, 1, 32767));
		      	 END IF;	  
		      	 V_SENTIDO := DADOS_NUM_VOO.CD_SENTIDO;
		      	 vXML := '<SENTIDO cod_sentido="'||DADOS_NUM_VOO.CD_SENTIDO||'">';	
		      	 Utl_File.Put_Line(v_file, Substr(vXML, 1, 32767));		      	 
		      	 vXML := '<NUM_VOO cod_companhia="" cod_iata="">Todos</NUM_VOO>';
		      	 Utl_File.Put_Line(v_file, Substr(vXML, 1, 32767));
		      END IF;
		      vXML := '<NUM_VOO cod_companhia="'||DADOS_NUM_VOO.CD_CIA||'" cod_iata="'||DADOS_NUM_VOO.CD_DEST_ORIG_IATA||'">'||DADOS_NUM_VOO.NU_VOO;		      
		      Utl_File.Put_Line(v_file, Substr(vXML, 1, 32767));
		      vXML := '</NUM_VOO>';
		      Utl_File.Put_Line(v_file, Substr(vXML, 1, 32767));
		 END LOOP;
		 close cNUM_VOO;
		 vXML := '</SENTIDO>';
		 Utl_File.Put_Line(v_file, Substr(vXML, 1, 32767));
		 vXML := '</AEROPORTO>';
		 Utl_File.Put_Line(v_file, Substr(vXML, 1, 32767));
		 vXML := '</DADOS>';
		 Utl_File.Put_Line(v_file, Substr(vXML, 1, 32767));  
		 Utl_File.FClose(v_file);	
		 
	ELSIF STIPO = 'NUM_VOO_CIA' THEN
 	   open cNUM_VOO_CIA;
		 v_file := Utl_File.FOpen('/ora05/sivnet/files','num_voo_cia.xml','w');
		 vXML := '<?xml version="1.0" encoding="ISO8859-1"?>
		          <!DOCTYPE AGENDA SYSTEM "DTD_TOTEM.dtd">';
		 Utl_File.Put_Line(v_file, Substr(vXML, 1, 32767));
		 vXML := '<DADOS>';
		 Utl_File.Put_Line(v_file, Substr(vXML, 1, 32767));
		 LOOP
		      FETCH cNUM_VOO_CIA  INTO DADOS_NUM_VOO_CIA;
		      EXIT WHEN cNUM_VOO_CIA%NOTFOUND;		      		         
		      IF DADOS_NUM_VOO_CIA.CD_AEROPORTO <> V_AEROPORTO THEN		      	 
		      	 IF V_AEROPORTO <> 'tttt' THEN
		      	 	  vXML := '</COMPANHIA></SENTIDO></AEROPORTO>';
		      	 	  Utl_File.Put_Line(v_file, Substr(vXML, 1, 32767));
		      	 END IF;	  		      	 
		      	 V_AEROPORTO := DADOS_NUM_VOO_CIA.CD_AEROPORTO;
		      	 V_COMPANHIA := 'aaaa';	
		      	 V_SENTIDO := 'A';		      	 	      	 
		      	 vXML := '<AEROPORTO codigo="'||DADOS_NUM_VOO_CIA.CD_AEROPORTO||'">';		
		      	 Utl_File.Put_Line(v_file, Substr(vXML, 1, 32767));		      	 
		      END IF;
		      IF DADOS_NUM_VOO_CIA.CD_SENTIDO <> V_SENTIDO THEN
		      	 IF V_SENTIDO <> 'A' THEN
		      	 	  vXML := '</COMPANHIA></SENTIDO>';
		      	 	  Utl_File.Put_Line(v_file, Substr(vXML, 1, 32767));
		      	 END IF;	  
		      	 V_SENTIDO := DADOS_NUM_VOO_CIA.CD_SENTIDO;
		      	 V_COMPANHIA := 'aaaa';
		      	 vXML := '<SENTIDO cod_sentido="'||DADOS_NUM_VOO_CIA.CD_SENTIDO||'">';	
		      	 Utl_File.Put_Line(v_file, Substr(vXML, 1, 32767));		      	 		      	 
		      END IF;
		      IF DADOS_NUM_VOO_CIA.CD_CIA <> V_COMPANHIA THEN		      	 
		      	 IF V_COMPANHIA <> 'aaaa' THEN
		      	 	  vXML := '</COMPANHIA>';
		      	 	  Utl_File.Put_Line(v_file, Substr(vXML, 1, 32767));
		      	 END IF;	  		      	 
		      	 V_COMPANHIA := DADOS_NUM_VOO_CIA.CD_CIA;
		      	 vXML := '<COMPANHIA cod_companhia="'||DADOS_NUM_VOO_CIA.CD_CIA||'">';
		      	 Utl_File.Put_Line(v_file, Substr(vXML, 1, 32767));		      	 
		      	 vXML := '<NUM_VOO cod_iata="">Todos</NUM_VOO>';
		      	 Utl_File.Put_Line(v_file, Substr(vXML, 1, 32767));
		      END IF;
		         vXML := '<NUM_VOO cod_iata="'||DADOS_NUM_VOO_CIA.CD_DEST_ORIG_IATA||'">'||DADOS_NUM_VOO_CIA.NU_VOO;		      
		         Utl_File.Put_Line(v_file, Substr(vXML, 1, 32767));
		         vXML := '</NUM_VOO>';
		         Utl_File.Put_Line(v_file, Substr(vXML, 1, 32767));
		 END LOOP;
		 close cNUM_VOO_CIA;
		 vXML := '</COMPANHIA>';
		 Utl_File.Put_Line(v_file, Substr(vXML, 1, 32767));
		 vXML := '</SENTIDO>';
		 Utl_File.Put_Line(v_file, Substr(vXML, 1, 32767));
		 vXML := '</AEROPORTO>';
		 Utl_File.Put_Line(v_file, Substr(vXML, 1, 32767));
		 vXML := '</DADOS>';
		 Utl_File.Put_Line(v_file, Substr(vXML, 1, 32767));  
		 Utl_File.FClose(v_file);	
		 
  ELSIF STIPO = 'NUM_VOO_ORI_DES' THEN
 	   open cNUM_VOO_ORI_DES;
		 v_file := Utl_File.FOpen('/ora05/sivnet/files','num_voo_ori_des.xml','w');
		 vXML := '<?xml version="1.0" encoding="ISO8859-1"?>
		          <!DOCTYPE AGENDA SYSTEM "DTD_TOTEM.dtd">';
		 Utl_File.Put_Line(v_file, Substr(vXML, 1, 32767));
		 vXML := '<DADOS>';
		 Utl_File.Put_Line(v_file, Substr(vXML, 1, 32767));
		 LOOP
		      FETCH cNUM_VOO_ORI_DES  INTO DADOS_NUM_VOO_ORI_DES;
		      EXIT WHEN cNUM_VOO_ORI_DES%NOTFOUND;		      		         
		      IF DADOS_NUM_VOO_ORI_DES.CD_AEROPORTO <> V_AEROPORTO THEN		      	 
		      	 IF V_AEROPORTO <> 'tttt' THEN
		      	 	  vXML := '</CIDADE></SENTIDO></AEROPORTO>';
		      	 	  Utl_File.Put_Line(v_file, Substr(vXML, 1, 32767));
		      	 END IF;	  		      	 
		      	 V_AEROPORTO := DADOS_NUM_VOO_ORI_DES.CD_AEROPORTO;
		      	 V_COMPANHIA := 'aaaa';	
		      	 V_SENTIDO := 'A';	      	 	      	 
		      	 vXML := '<AEROPORTO codigo="'||DADOS_NUM_VOO_ORI_DES.CD_AEROPORTO||'">';		
		      	 Utl_File.Put_Line(v_file, Substr(vXML, 1, 32767));		      	 
		      END IF;
		      IF DADOS_NUM_VOO_ORI_DES.CD_SENTIDO <> V_SENTIDO THEN
		      	 IF V_SENTIDO <> 'A' THEN
		      	 	  vXML := '</CIDADE></SENTIDO>';
		      	 	  Utl_File.Put_Line(v_file, Substr(vXML, 1, 32767));
		      	 END IF;	  
		      	 V_SENTIDO := DADOS_NUM_VOO_ORI_DES.CD_SENTIDO;
		      	 V_COMPANHIA := 'aaaa';
		      	 vXML := '<SENTIDO cod_sentido="'||DADOS_NUM_VOO_ORI_DES.CD_SENTIDO||'">';	
		      	 Utl_File.Put_Line(v_file, Substr(vXML, 1, 32767));		      	 		      	 
		      END IF;
		      IF DADOS_NUM_VOO_ORI_DES.CD_DEST_ORIG_IATA <> V_COMPANHIA THEN		      	 
		      	 IF V_COMPANHIA <> 'aaaa' THEN
		      	 	  vXML := '</CIDADE>';
		      	 	  Utl_File.Put_Line(v_file, Substr(vXML, 1, 32767));
		      	 END IF;	  		      	 
		      	 V_COMPANHIA := DADOS_NUM_VOO_ORI_DES.CD_DEST_ORIG_IATA;
		      	 vXML := '<CIDADE cod_iata="'||DADOS_NUM_VOO_ORI_DES.CD_DEST_ORIG_IATA||'">';
		      	 Utl_File.Put_Line(v_file, Substr(vXML, 1, 32767));		      	 
		      	 vXML := '<NUM_VOO cod_companhia="">Todos</NUM_VOO>';
		      	 Utl_File.Put_Line(v_file, Substr(vXML, 1, 32767));		      	 
		      END IF;
		         vXML := '<NUM_VOO cod_companhia="'||DADOS_NUM_VOO_ORI_DES.CD_CIA||'">'||DADOS_NUM_VOO_ORI_DES.NU_VOO;		      
		         Utl_File.Put_Line(v_file, Substr(vXML, 1, 32767));
		         vXML := '</NUM_VOO>';
		         Utl_File.Put_Line(v_file, Substr(vXML, 1, 32767));
		 END LOOP;
		 close cNUM_VOO_ORI_DES;
		 vXML := '</CIDADE>';
		 Utl_File.Put_Line(v_file, Substr(vXML, 1, 32767));
		 vXML := '</SENTIDO>';
		 Utl_File.Put_Line(v_file, Substr(vXML, 1, 32767));
		 vXML := '</AEROPORTO>';
		 Utl_File.Put_Line(v_file, Substr(vXML, 1, 32767));
		 vXML := '</DADOS>';
		 Utl_File.Put_Line(v_file, Substr(vXML, 1, 32767));  
		 Utl_File.FClose(v_file);		  
  END IF;
END;