-- Start of DDL Script for Package Body IFRSIVNET.VOO_TOP3V
-- Generated 11-mai-2005 9:41:03 from IFRSIVNET@INET

-- Drop the old instance of VOO_TOP3V
DROP PACKAGE BODY ifrsivnet.voo_top3v
/

CREATE OR REPLACE 
package body                     ifrsivnet.voo_top3v is
PROCEDURE INI ( p_cd_aeroporto_ini in varchar2 default null,
p_cd_opcao   in varchar2 default 'chegadas',
p_cd_cia     in varchar2 default null,
p_cd_ori_des in varchar2 default null,
p_nu_voo     in varchar2 default null,
p_cd_natureza in varchar2 default null ) is
cursor voos is
 select decode(cd_sentido,
   'C','chegadas',
   'P','partidas','erro' ) opcao,
  count(*) svl_qtde
 from   voo_operacao
 where  cd_aeroporto = p_cd_aeroporto_ini
 group  by decode(cd_sentido,
  'C','chegadas',
  'P','partidas','erro' );
cursor cidades is
 select l.nm_cidade, l.nm_aeroporto, o.cd_aeroporto, count(l.nm_aeroporto) qt_aeroportos
 from   localidade l,  voo_operacao o
 where  l.cd_local_icao = o.cd_aeroporto
 group by l.nm_cidade, l.nm_aeroporto, o.cd_aeroporto;
cursor aeroportos is
 select distinct nm_aeroporto, cd_local_icao
 from   localidade;
reg_voos 	voos%rowtype;
reg_aeroportos 	aeroportos%rowtype;
reg_cidades 	cidades%rowtype;

size_col_cia varchar2(50) := ' width="58" nowrap ';
size_col_voo varchar2(50) := ' width="35" nowrap ';
size_col_o_d varchar2(50) := ' width="150" nowrap ';
size_col_dta varchar2(50) := ' width="28" nowrap ';
size_col_hpr varchar2(50) := ' width="50" nowrap ';
size_col_hes varchar2(50) := ' width="50" nowrap ';
size_col_tps varchar2(50) := ' width="30" nowrap ';
size_col_esc varchar2(50) := ' width="150" nowrap ';
size_col_sta varchar2(50) := ' width="90" nowrap ';

p_cd_sentido varchar2(30);
begin
htp.print( '
<script language="javascript" >
<!--
 function cidade_sub()    { document.cidade.submit(); }
 function aeroporto_sub() { document.aeroporto.submit(); }
 function opcao_sub()     { document.opcao.submit(); }
 function cia_sub() { document.filtro_cia.submit(); }
 function num_sub() { document.filtro_num.submit(); }
 function ori_des_sub()   { document.filtro_ori_des.submit(); }
 function natureza_sub()  { document.filtro_natureza.submit(); }
-->
</script>');
SIV_BANNER;
htp.print( ' <FORM action="voo_top3v.ini" method="GET" class="input"
name="cidade">
<table width="770" border="0" align="center" cellpadding="0" cellspacing="0"
       bgcolor="#D3ECF8" class="tab1" >
  <tr valign="middle"  height="30">
    <td width="60" align="right" bgcolor="#D3ECF8">
       <span style="font-family: verdana; font-size: 15px ; color: #0e3463 ; font-weight: 700;" >Cidade&nbsp;</span></td><td  width="510" align="left" bgcolor="#D3ECF8">
 <SELECT name="p_cd_aeroporto_ini" onchange="cidade_sub()" class="input_cidade" >
   <OPTION value="0">Selecione</OPTION>');
   open cidades;
    loop
    fetch cidades into reg_cidades;
          exit when cidades%notfound;
    htp.print( ' <OPTION ' );
    if reg_cidades.cd_aeroporto = p_cd_aeroporto_ini  then
 htp.print( 'SELECTED ');
    end if;
    htp.print( ' value="'||reg_cidades.cd_aeroporto||'">'||reg_cidades.nm_cidade||
   '-'||reg_cidades.nm_aeroporto||'</OPTION>');
   end loop;
   close cidades;
htp.print('</SELECT>
 <input type="hidden" name="p_cd_opcao" value="chegadas">
');
-- Escolhe a OPCAO DE VOO --

if  nvl(p_cd_aeroporto_ini,'0') = '0' then
   htp.print( '</td></TABLE>');
   SIV_APRESENTACAO;
   htp.print( '</body></html>');
   return;
else
htp.print( '</td></form>
  <FORM action="voo_top3v.ini" method="GET" class="input" name="opcao">
  <td width="200" align="left" bgcolor="#D3ECF8">
  <input type="hidden" name="p_cd_aeroporto_ini"
         value="'||p_cd_aeroporto_ini||'"> ');
   open voos;
    loop
    fetch voos into reg_voos;
    exit when voos%notfound;
    htp.print(' <input type="radio" name="p_cd_opcao"');
    if p_cd_aeroporto_ini is not null then
       if reg_voos.opcao = p_cd_opcao then
          htp.print( ' CHECKED ');
       end if;
    end if;
    htp.print( 'onclick="javascript:document.opcao.submit()"
                value="'||reg_voos.opcao||'">
              <font  color="#0e3463" size="1"><strong>'|| reg_voos.opcao||'</strong></font>');
   end loop;
   close voos;
end if;
htp.print('</td></tr></TABLE></form>');

-- Monta tabela com flash de chegadas/partidas e nome do aeroporto --

if p_cd_opcao is null then
   SIV_APRESENTACAO;
   htp.print( '</body></html>');
   return;
end if;
SIV_VOOS ( p_cd_aeroporto_ini,p_cd_opcao,
      p_cd_cia, p_cd_ori_des, p_nu_voo, p_cd_natureza );
  p_cd_sentido  := 'C'; -- default chegadas
if ( p_cd_opcao = 'partidas' ) then
  p_cd_sentido  := 'P';
end if;
htp.print( '</TR><TR><TD width=770 >');
SIV_DADOS ( v_dt_atual );
htp.print( '</TD></TR>');
-- ABRIR FORM PARA USO DE ELEMENTOS VISUAIS
----------- Header ------------------ inicio
htp.print('
<TABLE width="770"  border="0" cellpadding="0" cellspacing="0"
       bgcolor="#ffffff" align="center"  >
 <TR >
    <TD '||size_col_cia||' class="head" >'||'Cia A&eacute;rea</TD>
    <TD '||size_col_voo||' class="head" >'||'V&ocirc;os</TD>' );
  if (p_cd_sentido = 'C') then
     htp.print('    <TD '||size_col_o_d||'class="head" ><center>Origem</TD>');
  end if;
  if (p_cd_sentido = 'P') then
     htp.print('    <TD '||size_col_o_d||'class="head" ><center>Destino</TD>');
  end if;
htp.print('
    <TD '||size_col_dta||'class="head" >'||'Data</font></TD>
    <TD '||size_col_hpr||'class="head" >'||'Previsto</font></TD>
    <TD '||size_col_hes||'class="head" >'||'Estimado</font></TD>
    <TD '||size_col_tps||'class="head" >'||'Term.</font></TD>
    <TD '||size_col_esc||'class="head" >'||'Escalas</font></TD>
    <TD '||size_col_sta||'class="head" >'||'Status</font></TD>
    <TD width="15" class="head" >'||'&nbsp;</TD>
 </TR><TR><TD colspan="11">');
----------- Header ------------------ fim
htp.print( '<iframe frameborder="0" width="770" height="274"
            marginwidth="0" marginheight="0" align="left"
            src="voo_body2v.ini?p_cd_aeroporto_ini='||p_cd_aeroporto_ini||
                '&p_cd_opcao='||p_cd_opcao||
                '&p_cd_cia='||p_cd_cia||
                '&p_cd_ori_des='||p_cd_ori_des||
                '&p_nu_voo='||p_nu_voo||
                '&p_cd_natureza='||p_cd_natureza||'"
                scrolling="yes" name="disp"></iframe>'
 );
open responsabilidade;
fetch responsabilidade into reg_rtexto;
close responsabilidade;
htp.print(' </TR></TD></TABLE>
<!--
<table align="center" border="0" cellspacing="1" bgcolor="#ffffff" width="770">
     <tr><td width="100%" align="center">
<img src="http://www.infraero.gov.br/sivnet/img/'||lower(p_cd_aeroporto_ini)||'.jpg"
 alt="'||lower(p_cd_aeroporto_ini)||'">
</td>
</tr><tr>
<td style="font-family: verdana; font-size: 9pt;"> '||reg_rtexto.rtexto||
' <br></td></tr></table>
-->
</TD></TR></TABLE>
</TD></TR></TABLE></BODY></HTML>');
END INI;
PROCEDURE SIV_VOOS ( p_cd_aeroporto_ini in varchar2 default null,
     p_cd_opcao   in varchar2 default null,
     p_cd_cia     in varchar2 default null,
     p_cd_ori_des in varchar2 default null,
     p_nu_voo     in varchar2 default null,
     p_cd_natureza in varchar2 default null ) IS
v_cd_natureza char(1);
v_cd_sentido  char(1);
p_cd_sentido varchar2(30);
cursor codigo_cidade is
select cd_local_iata cd_cidade
from   localidade where rtrim(nm_cidade) = p_cd_ori_des;
reg_cd_cidade codigo_cidade%rowtype;
begin
v_dt_atual := '';
open loc ( p_cd_aeroporto_ini );
 fetch loc into reg_loc;
 nome_aeroporto_cidade := reg_loc.nm_aeroporto||' - '||reg_loc.nm_cidade;
close loc;
-- Monta flash de chegasdas / partidas no meio da tela --
 SIV_FILTRO( p_cd_aeroporto_ini,p_cd_opcao, p_cd_cia,
             p_cd_ori_des,p_nu_voo, p_cd_natureza  );
  htp.print( '<td bgcolor="#ffffff" valign="middle" align="center" width="200">
    <embed width="120" height="50"
            src="http://www.infraero.gov.br/sivnet/img/flash/'||p_cd_opcao||'.swf"
            loop="true" align="center">  </td></table></td>   ');
END SIV_VOOS;

PROCEDURE SIV_DIA_HORA IS
hoje varchar2( 40 );
begin
select to_char( sysdate, 'dd "de" month "de" yyyy', 'NLS_DATE_LANGUAGE=''BRAZILIAN PORTUGUESE''' ) into hoje
from dual;

htp.print('<font style="font-size:10px;font-family:Verdana; color:#0e3463;">'||hoje||'</font>');
--
END SIV_DIA_HORA;

PROCEDURE SIV_BANNER IS
begin
htp.print( '<HTML>
<HEAD>
<meta http-equiv="Content-Type" content="text/html; charset=windows-1252">
<meta http-equiv="Content-Language" content="pt-br">
<META content=120 http-equiv=refresh>
<STYLE type=text/css>
<!--
BODY { font-family: verdana ; font-size: 10;
       text-align: right;
     background: url("http://www.infraero.gov.br/sivnet/img/bg_siv.jpg") }
A:link { text-decoration: none;}
A:visited { text-decoration: none;}
A:active { text-decoration: none;}
A:hover { text-decoration: none;}
.tab1 { padding: 0px 0px 0px 0px; marging: 0px 0px 0px 0px; }
.tab2 { border-color: #8C8C8C; border-style: solid; border-width: 2px;
        padding: 0px 0px 0px 0px; marging: 0px 0px 0px 0px; }
.tab3 { border-color: #ffffff; border-style: solid; border-width: 1px;
        padding: 0px 0px 0px 0px; marging: 0px 0px 0px 0px; }
.head { background: #949494; border-style: outset; border-width: 2px;
          font-family: Verdana; font-size: 9px; font-weight: 700;
          text-align: center; color: #ffffff; padding: 0px 0px 0px 0px;}
.escala { BACKGROUND: #353635; COLOR: #F8DE03; FONT-WEIGHT: normal }
.label  { BACKGROUND: #ffffcc; COLOR: #2840ff; FONT-WEIGHT: bold ;
          font-family: verdana ; font-size: 10; text-align: right;
          padding: 0px 0px 0px 0px; margin: 0px 0px 0px 0px;}
.label1 { BACKGROUND: #ffffff; COLOR: #2840ff; FONT-WEIGHT: bold ;
          font-family: verdana ; font-size: 10; text-align: right;
          padding: 0px 0px 0px 0px; margin: 0px 0px 0px 0px;}
.atual  { BACKGROUND: #ffffff; COLOR: #0e3463; FONT-WEIGHT: bold ;
          font-family: verdana ; font-size: 10; text-align: center;
          padding: 0px 0px 0px 0px; margin: 0px 0px 0px 0px;}
.input  { BACKGROUND: #ffffff; COLOR: #000000;
          FONT-WEIGHT: normal ;  FONT-FAMILY: verdana, arial, sans-serif;
          FONT-SIZE: 8 pt ; max-height: 10px;
          padding: 0px 0px 0px 0px; margin: 0px 0px 0px 0px;}

.input_cidade {
	PADDING-RIGHT: 0px; PADDING-LEFT: 0px; FONT-WEIGHT: normal; FONT-SIZE: 8pt; BACKGROUND: #ffffff; PADDING-BOTTOM: 0px; MARGIN: 0px; COLOR: #000000; PADDING-TOP: 0px; FONT-FAMILY: arial, arial, sans-serif; max-height: 10px
}

.dthr   { BACKGROUND: #efefef; COLOR: #000000;
          FONT-WEIGHT: bold; FONT-FAMILY: arial, sans-serif;
          FONT-SIZE: 9px ; max-height: 10px;
          padding: 0px 0px 0px 0px; margin: 0px 0px 0px 0px;}
.dthr1   { BACKGROUND: #cccccc; COLOR: #000000;
          FONT-WEIGHT: bold; FONT-FAMILY: arial, sans-serif;
          FONT-SIZE: 9px ; max-height: 10px;
          padding: 0px 0px 0px 0px; margin: 0px 0px 0px 0px;}
A.nav:link    { COLOR: black; TEXT-DECORATION: none  }
A.nav:visited { COLOR: black; TEXT-DECORATION: none  }
A.nav:hover   { COLOR: #ff0000; TEXT-DECORATION: underline }
-->
</STYLE>
<TITLE>SivNet - INFRAERO</TITLE></HEAD>');

htp.print( '<BODY link="#336699" vlink="" font size="1" face="verdana"
  leftmargin="0" rigthmargin="0" topmargin="0"
  marginwidth="0" marginheight="0" >
<TABLE width="770"  border="0" align="center" cellpadding="0" cellspacing="0"
       bgcolor="#ffffff" class="tab1" ><TR><TD>
<!-- Tabela do banner da tela -->
<table border="0" cellpadding="0" cellspacing="0" width="770" >
    <tr nowrap bgcolor="#0e3463" >
<!-- Logo INFRAERO -->
<td background="http://www.infraero.gov.br/sivnet/img/logo_sivnets.jpg"
height="46">
<!-- <td valign="bottom" bgcolor="#0e3463" width="40%">
 <p align="right">
  <a href="http://www.infraero.gov.br">
   <img border="0"
     src="http://www.infraero.gov.br/sivnet/img/home_infraeros.gif"
     alt="INFRAERO" width="30" height="40">
  </a>
  <a href="pls/sivdb/voo_top3v.ini">
   <img border="0"
     src="http://www.infraero.gov.br/sivnet/img/home_sivnets.gif"
     alt="Home" width="30" height="40">
  </a>
  <a HREF="http://oracle-dsv-rj2.infranet.gov.br/pls/portal30/PORTAL30.wwsec_app_priv.login?p_requested_url=http%3A%2F%2Foracle-dsv-rj2.infranet.gov.br%2Fpls%2Fportal30%2FPORTAL30.home&p_cancel_url=http%3A%2F%2Foracle-dsv-rj2.infranet.gov.br%2Fpls%2Fportal30%2FPORTAL30.home">
   <img border="0"
     src="http://www.infraero.gov.br/sivnet/img/login_portals.gif"
     alt="Login" width="30" height="40">&nbsp;
  </a>
 </p> -->
</td></tr>
<tr valign=top height=14>
<td align=right
    background="http://www.infraero.gov.br/sivnet/img/logo_sivnet_comp.jpg"
    height="14" style="font-size:14px;font-family:Verdana; color:#0e3463;" >');
SIV_DIA_HORA;
htp.print( '</td></tr></table>');
END SIV_BANNER;

PROCEDURE SIV_APRESENTACAO IS
cursor noticia is
select texto from noticia_doop;
reg_texto noticia%rowtype;
begin
open noticia;
fetch noticia into reg_texto;
close noticia;
htp.print('<table align="center" border="0" cellspacing="1" width="100%"    >
 <tr>
  <td align="top" rowspan="1" >
<p align="center">
<img border="0"
   src="http://www.infraero.gov.br/sivnet/img/corpo_sivnet_mapa.jpg"
   width="230" height="215"></p></td></tr><tr><td>
   <span style="font-size:8;font-family:Verdana; color:#0e3463;">'
     ||reg_texto.texto||'</span><br></td></tr></table> ');
END SIV_APRESENTACAO;

PROCEDURE SIV_FILTRO ( p_cd_aeroporto_ini in varchar2 default null,
 p_cd_opcao   in varchar2 default null,
 p_cd_cia     in varchar2 default null,
 p_cd_ori_des in varchar2 default null,
 p_nu_voo     in varchar2 default null,
 p_cd_natureza in varchar2 default null ) is
cursor voos_natureza is
select cd_natureza , decode(nvl(cd_natureza,'..'),
 'D','Domestico','I','Internacional','erro') natureza
from   voo_operacao v
where  cd_aeroporto = p_cd_aeroporto_ini
  and  cd_sentido = decode(p_cd_opcao,
 'chegadas','C',
 'partidas','P','erro' )
group by v.cd_natureza, decode(nvl(cd_natureza,'..'),'..','D','Domestico','I','Internacional','erro') ;
reg_voos_natureza voos_natureza%rowtype;
cursor voos_cia is
select cd_cia , decode(nvl(nome_cia,'..'),'..',cd_cia,nome_cia) companhia
from   voo_operacao v, cia_aerea c
where  cd_aeroporto = p_cd_aeroporto_ini
  and  cd_sentido = decode(p_cd_opcao,
 'chegadas','C',
 'partidas','P','erro' )
  and  v.cd_cia = c.cod_cia(+)
group  by v.cd_cia, decode(nvl(nome_cia,'..'),'..',cd_cia,nome_cia) ;
reg_voos_cia voos_cia%rowtype;
cursor voos_ori_des is
select cd_dest_orig_iata ,
 decode(nvl(nm_cidade,'..'),'..',cd_dest_orig_iata,nm_cidade) cidade
from   voo_operacao v, localidade l
where  cd_aeroporto = p_cd_aeroporto_ini
  and  cd_sentido = decode(p_cd_opcao,
 'chegadas','C',
 'partidas','P','erro' )
  and  v.cd_dest_orig_iata = l.cd_local_iata(+)
group  by cd_dest_orig_iata,
    decode(nvl(nm_cidade,'..'),'..',cd_dest_orig_iata,nm_cidade);
reg_voos_ori_des voos_ori_des%rowtype;
cursor voos_escalas is
  select escalas_iata
   from  voo_operacao v
   where cd_aeroporto = p_cd_aeroporto_ini
     and cd_sentido = decode(p_cd_opcao,
   'chegadas','C',
   'partidas','P','erro' )
     and escalas_iata is not null;
reg_voos_escalas voos_escalas%rowtype;
cursor voos_num is
  select distinct nu_voo from voo_operacao
  where  cd_aeroporto = p_cd_aeroporto_ini
    and  cd_sentido = decode(p_cd_opcao,
   'chegadas','C',
   'partidas','P','erro' ) ;
reg_voos_num voos_num%rowtype;
i  number(3) := 0;
ja number(1) := 0;
v_localescala     varchar2(600);
v_localescalanome varchar2(200);
v_num_voo   varchar2(5);
v_x   number(3);
v_y   number(3);
v_z   number(3);
begin
-- -----------------------------------------------
-- Informacao da hora de atulizacao dos dados
-- ----------------------------------------------
v_cd_aeroporto_ini := p_cd_aeroporto_ini;
open atualiza;
fetch atualiza into reg_atual;
close atualiza;
v_dt_atual := reg_atual.atual;
-- -----------------------------------------------
-- Uso da pl/sql table para incluir escalas
-- -----------------------------------------------
-- str_table_locais.delete;
i := 0;
  open voos_ori_des;
    loop
    fetch voos_ori_des into reg_voos_ori_des;
exit when voos_ori_des%notfound;
ja := 0;
if str_table_locais.count > 0 then
   for i in str_table_locais.first .. str_table_locais.last loop
    if str_table_locais(i) = rtrim(reg_voos_ori_des.cidade) then
  ja := 1;
end if;
   end loop;
   if ja = 0 then
i := str_table_locais.count + 1;
str_table_locais(i) := rtrim(reg_voos_ori_des.cidade) ;
   end if;
else
   str_table_locais(1) := rtrim(reg_voos_ori_des.cidade) ;
end if;
    end loop;
  close voos_ori_des;
  open voos_escalas;
    loop
    fetch voos_escalas into reg_voos_escalas;
exit when voos_escalas%notfound;
ja := 0;
v_x := 1;
v_y := 1;
loop
  exit when v_x > nvl(length(rtrim(reg_voos_escalas.escalas_iata)),0);
  -- acha o nome da escala --------------------------------------------------
  open loc (substr(reg_voos_escalas.escalas_iata,v_x,3));
   fetch loc into reg_loc;
    if loc%notfound then
 v_localescalanome := '['||(substr(reg_voos_escalas.escalas_iata,v_x,3))||']';
     else
 v_localescalanome := rtrim(reg_loc.nm_cidade);
    end if;
  close loc; -- -------------------------------------------------------------
  ja := 0;
  if str_table_locais.count > 0 then
    for i in str_table_locais.first .. str_table_locais.last loop
if ( str_table_locais(i) = rtrim(v_localescalanome) and ja = 0 ) then
ja := 1;
 end if;
    end loop;
    if ja = 0 then
i := str_table_locais.count + 1;
str_table_locais(i) := rtrim(v_localescalanome) ;
    end if;
  else
    str_table_locais(1) := rtrim(v_localescalanome) ;
  end if;
v_x := v_y * 4 + 1;
v_y := v_y + 1;
end loop;
    end loop;
  close voos_escalas;
-- -----------------------
-- Escolhe o FILTRO de Origem.Destino -->
htp.print('
<table width="770" border="0" cellspacing="0"  height="15" cellpadding="0"
                                                         bgcolor="#efefef">
  <tr>
    <td width="577" bgcolor="#efefef" > <!-- coluna apenas para sintaxe da table abaixo -->
 <table width="577" border="0" align="left" cellpadding="0" cellspacing="0"                                              class="tab2" >
 <tr valign="middle" >
          <td width="73" align="right" >
    <form action="voo_top3v.ini" method="GET" name="filtro_cia" target="_self">
 <font color="#0e3463" size="2"><strong>Filtro&nbsp;</strong></font>
          </td>
          <td width="340" align=left height="30"
                         valign="top" bgcolor="#efefef" >
       <table width="300" cellspacing=0 cellpadding=2 border=0 class="tab3">
        <tr><td bgcolor="#CCCCCC" width="80">
            <input type="hidden" name="p_cd_aeroporto_ini"
               value="'||p_cd_aeroporto_ini||'" >
            <input type="hidden" name="p_cd_opcao"
               value="'||p_cd_opcao||'" >
<strong><font color="#0e3463" size="1">&nbsp;');
if p_cd_opcao = 'chegadas' then
   htp.print( 'Origens' );
else
   htp.print( 'Destinos' );
end if;
htp.print( '</font></strong>&nbsp;&nbsp;</td><td width="200" bgcolor="#CCCCCC">
<SELECT name="p_cd_ori_des" onchange="cia_sub()" class="input" >
<OPTION value="">');
if p_cd_opcao = 'chegadas' then
   htp.print( 'Todas' );
else
   htp.print( 'Todos' );
end if;
htp.print('</OPTION>     ');
     for i in str_table_locais.first .. str_table_locais.last loop
 htp.print( '<option ');
 if str_table_locais(i) = p_cd_ori_des then
    htp.print( ' SELECTED ' );
 end if;
 htp.print( 'value="'|| str_table_locais(i)||'">'||
str_table_locais(i)||'</OPTION>');
     end loop;
htp.print(' </SELECT>
                 </td>
</tr><tr> <td width="80" valign="top" bgcolor="#CCCCCC" >
<strong><font color="#0e3463" size="1">&nbsp;
    Cia A&eacute;rea</font></strong>&nbsp;&nbsp;
</td><td width="200" bgcolor="#CCCCCC">
       <SELECT name="p_cd_cia" onchange="cia_sub()" class="input">
   <OPTION value="">Todas</OPTION> ');
   open voos_cia;
    loop
    fetch voos_cia into reg_voos_cia;
          exit when voos_cia%notfound;
    htp.print( '<OPTION ' );
 if reg_voos_cia.cd_cia = p_cd_cia then
   htp.print( ' SELECTED ' );
 end if;
htp.print( 'value="'||reg_voos_cia.cd_cia||'">'||reg_voos_cia.companhia||
     '</OPTION>');
   end loop;
   close voos_cia;
  htp.print( '</SELECT>
  <input type="hidden" name="p_nu_voo" value="" >
  <input type="hidden" name="p_cd_natureza" value="" >
</td></tr></table>
</td> <!-- fecha opcoes de origens/destinos e cias -->
</form>
<form action="voo_top3v.ini" method="GET" name="filtro_num" target="_self" >
<td width="160" valign="middle" align="center" bgcolor="#CCCCCC" class="tab3" >
  <input type="hidden" name="p_cd_aeroporto_ini" value="'||p_cd_aeroporto_ini||'" >
  <input type="hidden" name="p_cd_opcao" value="'||p_cd_opcao||'" >
  <input type="hidden" name="p_cd_cia" value="" >
  <input type="hidden" name="p_cd_ori_des" value="" >
<strong><font color="#0e3463" size="1"><b>&nbsp;N&ordm; do V&ocirc;o</b></font></strong>&nbsp;
  <SELECT name="p_nu_voo" onchange="num_sub()" class="input">
   <OPTION value="">Todos</OPTION> ');
   open voos_num;
    loop
    fetch voos_num into reg_voos_num;
exit when voos_num%notfound;
    htp.print( '    <OPTION ' );
 if reg_voos_num.nu_voo = p_nu_voo then
   htp.print( ' SELECTED ' );
 end if;
 If length(reg_voos_num.nu_voo) = 5 then
    v_num_voo := substr(reg_voos_num.nu_voo,2,4);
 else
    v_num_voo := reg_voos_num.nu_voo;
 end if;
htp.print( 'value="'||reg_voos_num.nu_voo||'">'||v_num_voo||
     '</OPTION>');
   end loop;
   close voos_num;
htp.print( '</SELECT>
  <input type="hidden" name="p_cd_natureza" value="" >
</td></form><td width="20">&nbsp;</td></tr></table>
</td><!-- sera fechado no flash -->');
END SIV_FILTRO;

PROCEDURE SIV_DADOS ( p_dt_atual in varchar2 default null )
is
begin
open responsabilidade;
fetch responsabilidade into reg_rtexto;
close responsabilidade;
htp.print('<table border="0" cellspacing="0" cellpadding="0" width="100%" >
<tr>
  <td align="right" class="atual">
     Dados atualizados at&eacute; '||v_dt_atual||'&nbsp;
     ( Hor&aacute;rio de Bras&iacute;lia )
</td></tr> </table>
<table align="center" border="0" cellspacing="1" bgcolor="#ffffff" width="770">
     <tr><td width="100%" align="center">
</td>
</tr><tr>
<td style="font-family: verdana; font-size: 9pt;"> '||reg_rtexto.rtexto||
'</td></tr></table>
');
END SIV_DADOS;
END;
/

-- Grants for Package Body
GRANT EXECUTE ON ifrsivnet.voo_top3v TO sivnet_geral
/


-- End of DDL Script for Package Body IFRSIVNET.VOO_TOP3V

