-- Start of DDL Script for Package Body IFRSIVNET.VOO_TOTEM_V2
-- Generated 11-mai-2005 9:41:20 from IFRSIVNET@INET

-- Drop the old instance of VOO_TOTEM_V2
DROP PACKAGE BODY ifrsivnet.voo_totem_v2
/

CREATE OR REPLACE 
package body                     ifrsivnet.voo_totem_v2 is
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
SIV_BANNER;
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
htp.print( ' <FORM action="voo_totem_v2.ini" method="GET" class="input"
name="cidade">
<table width="1000" border="0" align="center" cellpadding="0" cellspacing="0"
       bgcolor="#D3ECF8" class="tab1" >
  <tr valign="middle"  height="30">
    <td width="73" align="right" bgcolor="#D3ECF8">
<!--       <font color="#0e3463" size="2" >
         <strong> -->
<font class="Titulo">Cidade&nbsp;
<!-- </strong> -->
</font>
    </td>
    <td  width="510" align="left" bgcolor="#D3ECF8">
 <SELECT name="p_cd_aeroporto_ini" onchange="cidade_sub()" class="input_cidade">
   <OPTION value="0">
Toque na tela e escolha o Aeroporto &gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; </OPTION>');
   open cidades;
    loop
    fetch cidades into reg_cidades;
          exit when cidades%notfound;
    htp.print( ' <OPTION ' );
    if reg_cidades.cd_aeroporto = p_cd_aeroporto_ini  then
 htp.print( 'SELECTED ');
    end if;
  htp.print('value="'||reg_cidades.cd_aeroporto||'">'||reg_cidades.nm_cidade||
   '-'||reg_cidades.nm_aeroporto||'</OPTION>');
   end loop;
   close cidades;
htp.print(' </SELECT>
 <input type="hidden" name="p_cd_opcao" value="chegadas">
');
-- Escolhe a OPCAO DE VOO --

if  nvl(p_cd_aeroporto_ini,'0') = '0' then
   htp.print( '</td></TABLE>');
   SIV_APRESENTACAO;
   htp.print( '</body></html>');
   return;
else
htp.print( ' </td></form>
  <FORM action="voo_totem_v2.ini" method="GET" name="opcao">
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
              <font  color="#0e3463" size="2"><strong>'|| reg_voos.opcao||'</strong></font></td>');
   end loop;
   close voos;
end if;
htp.print('</tr></form></TABLE>');

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
htp.print( '</TR><TR bgcolor=#0e3463 ><TD background=#0e3463 width=1000 >');
SIV_DADOS ( v_dt_atual );
htp.print( '</TD></TR>');
-- ABRIR FORM PARA USO DE ELEMENTOS VISUAIS
----------- Header ------------------ inicio
htp.print('
<TABLE width="770"  border="0" cellpadding="0" cellspacing="0"
       bgcolor="#0e3463" align="center"  >
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
htp.print( '<iframe frameborder="0" width="770" height="543"
            marginwidth="0" marginheight="0" align="left"
            src="voo_body1v.ini?p_cd_aeroporto_ini='||p_cd_aeroporto_ini||
                '&p_cd_opcao='||p_cd_opcao||
                '&p_cd_cia='||p_cd_cia||
                '&p_cd_ori_des='||p_cd_ori_des||
                '&p_nu_voo='||p_nu_voo||
                '&p_cd_natureza='||p_cd_natureza||'"
                scrolling="yes" name="disp"></iframe>'
 );
htp.print(' </TR><TR><TD colspan=11 align=center><font class="atual" >Toque na tela na op&ccedil;&atilde;o desejada</font></TD></TR></TD></TABLE>
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
    <embed width="100" height="35"
            src="http://www.infraero.gov.br/sivnet/img/flash/'||p_cd_opcao||'.swf"
            loop="true" align="center">  </td></table></td>   ');
END SIV_VOOS;

PROCEDURE SIV_DIA_HORA IS
hoje varchar2( 40 );
begin
select to_char( sysdate, 'dd "de" month "de" yyyy', 'NLS_DATE_LANGUAGE=''BRAZILIAN PORTUGUESE''' ) into hoje
from dual;

  htp.print('<font style="font-size:9px;font-family:Verdana; color:#ffffff;">
  <center>'||hoje||'</font></center>');
--
END SIV_DIA_HORA;

PROCEDURE SIV_BANNER IS
begin
htp.print( '<HTML>
<HEAD>
<meta http-equiv="Content-Type" content="text/html; charset=windows-1252">
<meta http-equiv="Content-Language" content="pt-br">
<META content=120 http-equiv=refresh>

<SCRIPT LANGUAGE="JavaScript">
	var contador = 0;
    // Csdigo novo
    var posX = 0;
    var posY = 0;
    // Fim
	function fechaJanela(){
	    contador++;
		if (contador >= 6000)
		{
		    window.close();
		}
	}
	function limparCount()
	{
	    // Csdigo novo
	    if ((posX != event.clientX) || (posY != event.clientY))
	    {
	        posX = event.clientX;
	        posY = event.clientY;
	    // Fim
	        contador = 0;
	    // Csdigo novo
	    }
	    // Fim
    }
	function verificarPermanencia()
	{
	    fechaJanela();
		window.setTimeout("verificarPermanencia()",10);
	}
</SCRIPT>



<STYLE type=text/css>
<!--
BODY { font-family: verdana ; font-size: 34;
       text-align: right; background: #0e3463}
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
          font-family: verdana ; font-size: 30 px; text-align: right;
          padding: 0px 0px 0px 0px; margin: 0px 0px 0px 0px;}
.atual  { BACKGROUND: #0e3463 ; COLOR: #ffffff; FONT-WEIGHT: bold ;
          font-family: verdana ; font-size: 10; text-align: center;
          padding: 0px 0px 0px 0px; margin: 0px 0px 0px 0px;}
.input  { BACKGROUND: #ffffff; COLOR: #000000;
          FONT-WEIGHT: normal ;  FONT-FAMILY: verdana, arial, sans-serif;
          FONT-SIZE: 16 px ; max-height: 10px;
          padding: 0px 0px 0px 0px; margin: 0px 0px 0px 0px;}

.input_cidade {
	PADDING-RIGHT: 0px; PADDING-LEFT: 0px; FONT-WEIGHT: normal; FONT-SIZE: 16px; BACKGROUND: #ffffff; PADDING-BOTTOM: 0px; MARGIN: 0px; COLOR: #000000; PADDING-TOP: 0px; FONT-FAMILY: arial, arial, sans-serif; max-height: 10px
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
.titulo { font-size: 20 px; color: #0e3463; }
.titulo2 { font-size: 14 px; color: #0e3463; font-weight: 700; }
-->
</STYLE>
<TITLE>SivNet - INFRAERO</TITLE></HEAD>');

htp.print( '<BODY link="#336699" vlink="" font size="1" face="verdana"
 onmousemove="JavaScript:limparCount();"
onload="JavaScript:verificarPermanencia();"
  leftmargin="0" rigthmargin="0" topmargin="0"
  marginwidth="0" marginheight="0" >
<TABLE width="1000"  border="0" align="center" cellpadding="0" cellspacing="0"
       bgcolor="#ffffff" class="tab1" ><TR><TD>
<!-- Tabela do banner da tela -->
<table border="0" cellpadding="0" cellspacing="0"
       height="50" width="1000"
       background="http://www.infraero.gov.br/sivnet/img/testa_totem.gif">
    <tr nowrap >
<!-- Logo INFRAERO -->
<td  width=520 >
</td>
<td valign="bottom" bgcolor="#0e3463" width="378">   ');
-- Data Atual
SIV_DIA_HORA;
htp.print( '</td>
<!-- Links do SivNet -->
<td bgcolor="#0e3463" width="96" >
 <p align="right">
<script language="javascript" >
<!--
 function totem_fecha() {
  window.location.href = "file://c:\\gcwebc\\inicial\\principal.html?origem=inicial"; }
-->
</script>
  <a href="javascript:totem_fecha();">
   <img border="0"
     src="http://www.infraero.gov.br/sivnet/img/fechar1.jpg"
     alt="Fechar" width=50 height=42 >
  </a>
 </p>
</td></tr></table>');
END SIV_BANNER;

PROCEDURE SIV_APRESENTACAO IS
cursor noticia is
select texto from noticia_doop;
reg_texto noticia%rowtype;
begin
open noticia;
fetch noticia into reg_texto;
close noticia;
htp.print('<table align="center" border="0" cellspacing="1" width="100%" >
 <tr>
  <td align="top" rowspan="1" >
<p align="center">
<img border="0"
   src="http://www.infraero.gov.br/sivnet/img/corpo_sivnet_mapa.jpg"
   width="230" height="215">
</a></p>    </td>   </tr>    <tr>     <td>
<font face="Arial, sans-serif" color="#FFFFFF"
      size="1">'||reg_texto.texto||'</font>     <br>
  </td>   </tr>    </table> ');
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
<table width="1000" border="0" cellspacing="0"  height="15" cellpadding="0"
                                                         bgcolor="#efefef">
  <tr valign="top" >
    <td width="900" bgcolor="#efefef" > <!-- coluna apenas para sintaxe da table abaixo -->
 <form action="voo_totem_v2.ini" method="GET" name="filtro_cia" target="_self">
 <table width="900" border="0" align="left" cellpadding="0" cellspacing="0"                                              class="tab2" >
 <tr valign="middle" >
          <td width="73" align="right" >
 <font class="Titulo" >Filtro&nbsp;</font>
          </td>
          <td width="625" align=left height="30"
                         valign="middle" bgcolor="#efefef" >
       <table width="623" cellspacing=0 cellpadding=2 border=0 class="tab3">
        <tr valign="middle" ><td bgcolor="#CCCCCC" valign="middle" width="180">
            <input type="hidden" name="p_cd_aeroporto_ini"
               value="'||p_cd_aeroporto_ini||'" >
            <input type="hidden" name="p_cd_opcao"
               value="'||p_cd_opcao||'" >
<font class="Titulo2">&nbsp;');
if p_cd_opcao = 'chegadas' then
   htp.print( 'Origens' );
else
   htp.print( 'Destinos' );
end if;
htp.print( '</font>&nbsp;</td><td valign="middle" width="200" bgcolor="#CCCCCC">
<SELECT name="p_cd_ori_des" onchange="cia_sub()" class="input">
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
 <td width="270" valign="middle" bgcolor="#CCCCCC" >
<font class="Titulo2" >&nbsp;
    Cia A&eacute;rea</font>&nbsp;
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
<form action="voo_totem_v2.ini" method="GET" name="filtro_num" target="_self" >
<td width="200" valign="middle" align="center" bgcolor="#CCCCCC" class="tab3" >
  <input type="hidden" name="p_cd_aeroporto_ini" value="'||p_cd_aeroporto_ini||'" >
  <input type="hidden" name="p_cd_opcao" value="'||p_cd_opcao||'" >
  <input type="hidden" name="p_cd_cia" value="" >
  <input type="hidden" name="p_cd_ori_des" value="" >
<font class="Titulo2">&nbsp;N&ordm; do V&ocirc;o</font>&nbsp;
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
htp.print('<table border="0" cellspacing="0" cellpadding="0" width="100%" >
<tr>
  <td bgcolor=#0e3463 align="center" class="atual">
     Dados atualizados at&eacute; '||v_dt_atual||'&nbsp;
     ( Hor&aacute;rio de Bras&iacute;lia )
</td></tr> </table>');
open responsabilidade;
fetch responsabilidade into reg_texto;
close responsabilidade;
htp.print(' <table align="center" border="0" cellspacing="1"
       bgcolor="#0e3463" width="1000">
<tr><td style="font-family: verdana; font-size: 9pt;"> <b>'||reg_texto.texto||'</b></td></tr></table>');

END SIV_DADOS;
END;
/

-- Grants for Package Body
GRANT EXECUTE ON ifrsivnet.voo_totem_v2 TO sivnet_geral
/


-- End of DDL Script for Package Body IFRSIVNET.VOO_TOTEM_V2

