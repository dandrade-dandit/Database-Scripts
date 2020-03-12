set define off
set verify off
set serveroutput on size 1000000
set feedback off
WHENEVER SQLERROR EXIT SQL.SQLCODE ROLLBACK
begin wwv_flow.g_import_in_progress := true; end; 
/
 
--       AAAA       PPPPP   EEEEEE  XX      XX
--      AA  AA      PP  PP  EE       XX    XX
--     AA    AA     PP  PP  EE        XX  XX
--    AAAAAAAAAA    PPPPP   EEEE       XXXX
--   AA        AA   PP      EE        XX  XX
--  AA          AA  PP      EE       XX    XX
--  AA          AA  PP      EEEEEE  XX      XX
prompt  Set Credentials...
 
begin
 
  -- Assumes you are running the script connected to SQL*Plus as the Oracle user APEX_040000 or as the owner (parsing schema) of the application.
  wwv_flow_api.set_security_group_id(p_security_group_id=>nvl(wwv_flow_application_install.get_workspace_id,6801409874193032));
 
end;
/

begin wwv_flow.g_import_in_progress := true; end;
/
begin 

select value into wwv_flow_api.g_nls_numeric_chars from nls_session_parameters where parameter='NLS_NUMERIC_CHARACTERS';

end;

/
begin execute immediate 'alter session set nls_numeric_characters=''.,''';

end;

/
begin wwv_flow.g_browser_language := 'en'; end;
/
prompt  Check Compatibility...
 
begin
 
-- This date identifies the minimum version required to import this file.
wwv_flow_api.set_version(p_version_yyyy_mm_dd=>'2010.05.13');
 
end;
/

prompt  Set Application ID...
 
begin
 
   -- SET APPLICATION ID
   wwv_flow.g_flow_id := nvl(wwv_flow_application_install.get_application_id,514);
   wwv_flow_api.g_id_offset := nvl(wwv_flow_application_install.get_offset,0);
null;
 
end;
/

--application/themes/106
 
begin
 
    wwv_flow.g_flow_theme_id := 106;
null;
 
end;
/

 
--
prompt  ...theme : 106
--
prompt  ...remove existing theme ...
 
begin
 
 wwv_flow_api.delete_theme(p_flow_id=> wwv_flow.g_flow_id , p_theme_id=>wwv_flow.g_flow_theme_id ,p_import=>'Y');
null;
 
end;
/

prompt  ...page templates for application: 514
--
--application/shared_components/user_interface/templates/page/login
prompt  ......Page template 29461731285167174
 
begin
 
declare
  c1 varchar2(32767) := null;
  c2 varchar2(32767) := null;
  c3 varchar2(32767) := null;
  l_clob clob;
  l_length number := 1;
begin
c1:=c1||'<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">'||chr(10)||
''||chr(10)||
'<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="&BROWSER_LANGUAGE." lang="&BROWSER_LANGUAGE.">'||chr(10)||
'<head>'||chr(10)||
'<title>#TITLE#</title>'||chr(10)||
''||chr(10)||
'<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />'||chr(10)||
'<meta http-equiv="Content-Style-Type" content="text/css" />'||chr(10)||
''||chr(10)||
'#HEAD#'||chr(10)||
'<link href="#IMAGE_P';

c1:=c1||'REFIX#themes/theme_514/style.css" rel="stylesheet" type="text/css" />'||chr(10)||
'<!--[if lt IE 9]><link href="#IMAGE_PREFIX#themes/theme_514/iestyle.css" rel="stylesheet" type="text/css" /><![endif]-->'||chr(10)||
'<script src="#IMAGE_PREFIX#themes/theme_514/cufon-yui.js" type="text/javascript"></script>'||chr(10)||
'<script src="#IMAGE_PREFIX#themes/theme_514/cufon-replace.js" type="text/javascript"></script>'||chr(10)||
''||chr(10)||
''||chr(10)||
'<script src="#IMAGE_P';

c1:=c1||'REFIX#themes/theme_514/wickhop_handwriting_400.font.js" type="text/javascript"></script>'||chr(10)||
'<script src="#IMAGE_PREFIX#themes/theme_514/maxheight.js" type="text/javascript"></script>'||chr(10)||
''||chr(10)||
'<script src="#IMAGE_PREFIX#themes/theme_514/script.js" type="text/javascript"></script>'||chr(10)||
''||chr(10)||
'<link rel="shortcut icon" href="#IMAGE_PREFIX#themes/theme_514/favicon.ico" type="image/x-icon" />'||chr(10)||
''||chr(10)||
'</head>'||chr(10)||
'<body id="login" #ONLO';

c1:=c1||'AD# onload="new ElementMaxHeight()">'||chr(10)||
'#FORM_OPEN#';

c2:=c2||'   <!-- FOOTER -->'||chr(10)||
'<div id="footer-wrap">'||chr(10)||
'   <div id="footer">'||chr(10)||
'      #REGION_POSITION_08#'||chr(10)||
'      <div style="position: absolute; top: 10px; right: 30px;"><a href="http://www.apex-designers.com" title="APEX-Designers.com">'||chr(10)||
'      <img src="#IMAGE_PREFIX#themes/theme_514/ad_logo.png" alt="www.APEX-Designers.com"/></a>'||chr(10)||
'      </div>'||chr(10)||
'   </div>'||chr(10)||
'</div>'||chr(10)||
'#FORM_CLOSE# '||chr(10)||
'<script type="text/javascript"> Cufon.no';

c2:=c2||'w(); </script>'||chr(10)||
'</body>'||chr(10)||
'</html>'||chr(10)||
'';

c3:=c3||'<div id="main">'||chr(10)||
'   <!-- HEADER -->'||chr(10)||
'   <div id="header">'||chr(10)||
'       <div class="logo-nav">'||chr(10)||
'	<h1 class="logo">#LOGO#</h1>'||chr(10)||
'        <ul >#NAVIGATION_BAR#<li class="user"><a href="#">&APP_USER.</a></li></ul>'||chr(10)||
'       </div>'||chr(10)||
''||chr(10)||
'       <div class="tabs">'||chr(10)||
'          <ul class="wrapper">#TAB_CELLS#</ul>'||chr(10)||
'       </div>'||chr(10)||
'   </div>   <!-- /HEADER -->'||chr(10)||
'   <div id="breadcrumb">'||chr(10)||
'               #REGION_POSITION_01#'||chr(10)||
'         ';

c3:=c3||'      #REGION_POSITION_07#'||chr(10)||
'   </div>'||chr(10)||
''||chr(10)||
'   <div id="messages">#NOTIFICATION_MESSAGE##SUCCESS_MESSAGE#</div>'||chr(10)||
'   <!-- CONTENT -->'||chr(10)||
'   <div id="content">'||chr(10)||
'         <div class="wrapper">'||chr(10)||
'            #REGION_POSITION_04#'||chr(10)||
'            <div class="box-body">'||chr(10)||
'             #BOX_BODY#'||chr(10)||
'             #REGION_POSITION_02#            '||chr(10)||
'             #REGION_POSITION_03#'||chr(10)||
'            </div>'||chr(10)||
'            #REGION_POSITION_0';

c3:=c3||'5#'||chr(10)||
'            #REGION_POSITION_06#'||chr(10)||
'         </div>'||chr(10)||
'   </div>   <!-- /CONTENT -->'||chr(10)||
'</div>   <!-- /main -->'||chr(10)||
'';

wwv_flow_api.create_template(
  p_id=> 29461731285167174 + wwv_flow_api.g_id_offset,
  p_flow_id=> wwv_flow.g_flow_id,
  p_name=> 'Login',
  p_body_title=> '',
  p_header_template=> c1,
  p_box=> c3,
  p_footer_template=> c2,
  p_success_message=> '<div class="success" id="MESSAGE">'||chr(10)||
'<img src="#IMAGE_PREFIX#themes/theme_514/close.png" onclick="$x_Remove(''MESSAGE'')" alt="Close" />#SUCCESS_MESSAGE#'||chr(10)||
'</div>',
  p_current_tab=> '',
  p_current_tab_font_attr=> '',
  p_non_current_tab=> '',
  p_non_current_tab_font_attr => '',
  p_top_current_tab=> '',
  p_top_current_tab_font_attr => '',
  p_top_non_curr_tab=> '',
  p_top_non_curr_tab_font_attr=> '',
  p_current_image_tab=> '',
  p_non_current_image_tab=> '',
  p_notification_message=> '<div class="notification" id="MESSAGE"><img src="#IMAGE_PREFIX#themes/theme_514/close.png" onclick="$x_Remove(''MESSAGE'')"  alt="Close" />#MESSAGE#</div>',
  p_navigation_bar=> '#BAR_BODY#',
  p_navbar_entry=> '<li><a href="#LINK#">#TEXT#</a></li>',
  p_app_tab_before_tabs=>'',
  p_app_tab_current_tab=>'',
  p_app_tab_non_current_tab=>'',
  p_app_tab_after_tabs=>'',
  p_region_table_cattributes=> ' summary="" cellpadding="0" border="0" cellspacing="0" width="100%"',
  p_theme_id  => wwv_flow.g_flow_theme_id,
  p_theme_class_id => 6,
  p_template_comment => '');
end;
 
null;
 
end;
/

--application/shared_components/user_interface/templates/page/one_level_tabs
prompt  ......Page template 29462530921167181
 
begin
 
declare
  c1 varchar2(32767) := null;
  c2 varchar2(32767) := null;
  c3 varchar2(32767) := null;
  l_clob clob;
  l_length number := 1;
begin
c1:=c1||'<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">'||chr(10)||
''||chr(10)||
'<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="&BROWSER_LANGUAGE." lang="&BROWSER_LANGUAGE.">'||chr(10)||
'<head>'||chr(10)||
'<title>#TITLE#</title>'||chr(10)||
''||chr(10)||
'<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />'||chr(10)||
'<meta http-equiv="Content-Style-Type" content="text/css" />'||chr(10)||
''||chr(10)||
'#HEAD#'||chr(10)||
'<link href="#IMAGE_P';

c1:=c1||'REFIX#themes/theme_514/style.css" rel="stylesheet" type="text/css" />'||chr(10)||
'<!--[if lt IE 9]><link href="#IMAGE_PREFIX#themes/theme_514/iestyle.css" rel="stylesheet" type="text/css" /><![endif]-->'||chr(10)||
'<script src="#IMAGE_PREFIX#themes/theme_514/cufon-yui.js" type="text/javascript"></script>'||chr(10)||
'<script src="#IMAGE_PREFIX#themes/theme_514/cufon-replace.js" type="text/javascript"></script>'||chr(10)||
''||chr(10)||
''||chr(10)||
'<script src="#IMAGE_P';

c1:=c1||'REFIX#themes/theme_514/wickhop_handwriting_400.font.js" type="text/javascript"></script>'||chr(10)||
'<script src="#IMAGE_PREFIX#themes/theme_514/maxheight.js" type="text/javascript"></script>'||chr(10)||
''||chr(10)||
'<script src="#IMAGE_PREFIX#themes/theme_514/script.js" type="text/javascript"></script>'||chr(10)||
''||chr(10)||
'<link rel="shortcut icon" href="#IMAGE_PREFIX#themes/theme_514/favicon.ico" type="image/x-icon" />'||chr(10)||
''||chr(10)||
'</head>'||chr(10)||
'<body id="one-level" #';

c1:=c1||'ONLOAD# onload="new ElementMaxHeight()">'||chr(10)||
'#FORM_OPEN#';

c2:=c2||'   <!-- FOOTER -->'||chr(10)||
'<div id="footer-wrap">'||chr(10)||
'   <div id="footer">'||chr(10)||
'      #REGION_POSITION_08#'||chr(10)||
'      <div style="position: absolute; top: 10px; right: 30px;"><a href="http://www.apex-designers.com" title="APEX-Designers.com">'||chr(10)||
'      <img src="#IMAGE_PREFIX#themes/theme_514/ad_logo.png" alt="www.APEX-Designers.com"/></a>'||chr(10)||
'      </div>'||chr(10)||
'   </div>'||chr(10)||
'</div>'||chr(10)||
'#FORM_CLOSE# '||chr(10)||
'<script type="text/javascript"> Cufon.no';

c2:=c2||'w(); </script>'||chr(10)||
'</body>'||chr(10)||
'</html>'||chr(10)||
'';

c3:=c3||'<div id="main">'||chr(10)||
'   <!-- HEADER -->'||chr(10)||
'   <div id="header">'||chr(10)||
'       <div class="logo-nav">'||chr(10)||
'	<h1 class="logo">#LOGO#</h1>'||chr(10)||
'        <ul >#NAVIGATION_BAR#<li class="user"><a href="#">&APP_USER.</a></li></ul>'||chr(10)||
'       </div>'||chr(10)||
''||chr(10)||
'       <div class="tabs">'||chr(10)||
'          <ul class="wrapper">#TAB_CELLS#</ul>'||chr(10)||
'       </div>'||chr(10)||
'   </div>   <!-- /HEADER -->'||chr(10)||
'   <div id="breadcrumb">'||chr(10)||
'               #REGION_POSITION_01#'||chr(10)||
'         ';

c3:=c3||'      #REGION_POSITION_07#'||chr(10)||
'   </div>'||chr(10)||
''||chr(10)||
'   <div id="messages">#NOTIFICATION_MESSAGE##SUCCESS_MESSAGE#</div>'||chr(10)||
'   <!-- CONTENT -->'||chr(10)||
'   <div id="content">'||chr(10)||
'         <div class="wrapper">'||chr(10)||
'            #REGION_POSITION_04#'||chr(10)||
'            <div class="box-body">'||chr(10)||
'             #BOX_BODY#'||chr(10)||
'             #REGION_POSITION_02#            '||chr(10)||
'             #REGION_POSITION_03#'||chr(10)||
'            </div>'||chr(10)||
'            #REGION_POSITION_0';

c3:=c3||'5#'||chr(10)||
'            #REGION_POSITION_06#'||chr(10)||
'         </div>'||chr(10)||
'   </div>   <!-- /CONTENT -->'||chr(10)||
'</div>   <!-- /main -->';

wwv_flow_api.create_template(
  p_id=> 29462530921167181 + wwv_flow_api.g_id_offset,
  p_flow_id=> wwv_flow.g_flow_id,
  p_name=> 'One Level Tabs',
  p_body_title=> '',
  p_header_template=> c1,
  p_box=> c3,
  p_footer_template=> c2,
  p_success_message=> '<div class="success" id="MESSAGE">'||chr(10)||
'<img src="#IMAGE_PREFIX#themes/theme_514/close.png" onclick="$x_Remove(''MESSAGE'')" alt="Close" />#SUCCESS_MESSAGE#'||chr(10)||
'</div>',
  p_current_tab=> '<li class="current"><a href="#TAB_LINK#">#TAB_LABEL#</a></li>',
  p_current_tab_font_attr=> '',
  p_non_current_tab=> '<li><a href="#TAB_LINK#">#TAB_LABEL#</a></li>',
  p_non_current_tab_font_attr => '',
  p_top_current_tab=> '',
  p_top_current_tab_font_attr => '',
  p_top_non_curr_tab=> '',
  p_top_non_curr_tab_font_attr=> '',
  p_current_image_tab=> '',
  p_non_current_image_tab=> '',
  p_notification_message=> '<div class="notification" id="MESSAGE"><img src="#IMAGE_PREFIX#themes/theme_514/close.png" onclick="$x_Remove(''MESSAGE'')"  alt="Close" />#MESSAGE#</div>',
  p_navigation_bar=> '#BAR_BODY#',
  p_navbar_entry=> '<li><a href="#LINK#">#TEXT#</a></li>',
  p_app_tab_before_tabs=>'',
  p_app_tab_current_tab=>'',
  p_app_tab_non_current_tab=>'',
  p_app_tab_after_tabs=>'',
  p_region_table_cattributes=> ' summary="" cellpadding="0" border="0" cellspacing="5" align="left"',
  p_breadcrumb_def_reg_pos => 'REGION_POSITION_01',
  p_theme_id  => wwv_flow.g_flow_theme_id,
  p_theme_class_id => 1,
  p_template_comment => '');
end;
 
null;
 
end;
/

--application/shared_components/user_interface/templates/page/popup
prompt  ......Page template 29463140977167183
 
begin
 
declare
  c1 varchar2(32767) := null;
  c2 varchar2(32767) := null;
  c3 varchar2(32767) := null;
  l_clob clob;
  l_length number := 1;
begin
c1:=c1||'<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">'||chr(10)||
''||chr(10)||
'<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="&BROWSER_LANGUAGE." lang="&BROWSER_LANGUAGE.">'||chr(10)||
'<head>'||chr(10)||
'<title>#TITLE#</title>'||chr(10)||
''||chr(10)||
'<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />'||chr(10)||
'<meta http-equiv="Content-Style-Type" content="text/css" />'||chr(10)||
''||chr(10)||
'#HEAD#'||chr(10)||
'<link href="#IMAGE_P';

c1:=c1||'REFIX#themes/theme_514/style.css" rel="stylesheet" type="text/css" />'||chr(10)||
'<!--[if lt IE 9]><link href="#IMAGE_PREFIX#themes/theme_514/iestyle.css" rel="stylesheet" type="text/css" /><![endif]-->'||chr(10)||
'<script src="#IMAGE_PREFIX#themes/theme_514/cufon-yui.js" type="text/javascript"></script>'||chr(10)||
'<script src="#IMAGE_PREFIX#themes/theme_514/cufon-replace.js" type="text/javascript"></script>'||chr(10)||
''||chr(10)||
''||chr(10)||
'<script src="#IMAGE_P';

c1:=c1||'REFIX#themes/theme_514/wickhop_handwriting_400.font.js" type="text/javascript"></script>'||chr(10)||
'<script src="#IMAGE_PREFIX#themes/theme_514/maxheight.js" type="text/javascript"></script>'||chr(10)||
''||chr(10)||
'<script src="#IMAGE_PREFIX#themes/theme_514/script.js" type="text/javascript"></script>'||chr(10)||
''||chr(10)||
'<link rel="shortcut icon" href="#IMAGE_PREFIX#themes/theme_514/favicon.ico" type="image/x-icon" />'||chr(10)||
''||chr(10)||
'</head>'||chr(10)||
'<body id="popup" #ONLO';

c1:=c1||'AD# onload="new ElementMaxHeight()">'||chr(10)||
'#FORM_OPEN#';

c2:=c2||'   <!-- FOOTER -->'||chr(10)||
'<div id="footer-wrap">'||chr(10)||
'   <div id="footer">'||chr(10)||
'      #REGION_POSITION_08#'||chr(10)||
'      <div style="position: absolute; top: 10px; right: 30px;"><a href="http://www.apex-designers.com" title="APEX-Designers.com">'||chr(10)||
'      <img src="#IMAGE_PREFIX#themes/theme_514/ad_logo.png" alt="www.APEX-Designers.com"/></a>'||chr(10)||
'      </div>'||chr(10)||
'   </div>'||chr(10)||
'</div>'||chr(10)||
'#FORM_CLOSE# '||chr(10)||
'<script type="text/javascript"> Cufon.no';

c2:=c2||'w(); </script>'||chr(10)||
'</body>'||chr(10)||
'</html>';

c3:=c3||'<div id="main">'||chr(10)||
'   <div id="breadcrumb">'||chr(10)||
'               #REGION_POSITION_01#'||chr(10)||
'               #REGION_POSITION_07#'||chr(10)||
'   </div>'||chr(10)||
''||chr(10)||
'   <div id="messages">#NOTIFICATION_MESSAGE##SUCCESS_MESSAGE#</div>'||chr(10)||
''||chr(10)||
'   <!-- CONTENT -->'||chr(10)||
'   <div id="content">'||chr(10)||
'         <div class="wrapper">'||chr(10)||
'            #REGION_POSITION_04#'||chr(10)||
'            <div class="box-body">'||chr(10)||
'             #BOX_BODY#'||chr(10)||
'             #REGION_POSITION_02#         ';

c3:=c3||'   '||chr(10)||
'             #REGION_POSITION_03#'||chr(10)||
'            </div>'||chr(10)||
'            #REGION_POSITION_05#'||chr(10)||
'            #REGION_POSITION_06#'||chr(10)||
'         </div>'||chr(10)||
'   </div>   <!-- /CONTENT -->'||chr(10)||
'</div>   <!-- /main -->';

wwv_flow_api.create_template(
  p_id=> 29463140977167183 + wwv_flow_api.g_id_offset,
  p_flow_id=> wwv_flow.g_flow_id,
  p_name=> 'Popup',
  p_body_title=> '',
  p_header_template=> c1,
  p_box=> c3,
  p_footer_template=> c2,
  p_success_message=> '<div class="success" id="MESSAGE">'||chr(10)||
'<img src="#IMAGE_PREFIX#themes/theme_509/close.png" onclick="$x_Remove(''MESSAGE'')" alt="Close" />#SUCCESS_MESSAGE#'||chr(10)||
'</div>',
  p_current_tab=> '',
  p_current_tab_font_attr=> '',
  p_non_current_tab=> '',
  p_non_current_tab_font_attr => '',
  p_top_current_tab=> '',
  p_top_current_tab_font_attr => '',
  p_top_non_curr_tab=> '',
  p_top_non_curr_tab_font_attr=> '',
  p_current_image_tab=> '',
  p_non_current_image_tab=> '',
  p_notification_message=> '<div class="notification" id="MESSAGE"><img src="#IMAGE_PREFIX#themes/theme_509/close.png" onclick="$x_Remove(''MESSAGE'')"  alt="Close" />#MESSAGE#</div>',
  p_navigation_bar=> '#BAR_BODY#',
  p_navbar_entry=> '<li><a href="#LINK#">#TEXT#</a></li>',
  p_app_tab_before_tabs=>'',
  p_app_tab_current_tab=>'',
  p_app_tab_non_current_tab=>'',
  p_app_tab_after_tabs=>'',
  p_region_table_cattributes=> ' summary="" cellpadding="0" border="0" cellspacing="0" width="100%"',
  p_theme_id  => wwv_flow.g_flow_theme_id,
  p_theme_class_id => 4,
  p_template_comment => '');
end;
 
null;
 
end;
/

--application/shared_components/user_interface/templates/page/one_level_tabs_with_sidebar
prompt  ......Page template 29483628800459461
 
begin
 
declare
  c1 varchar2(32767) := null;
  c2 varchar2(32767) := null;
  c3 varchar2(32767) := null;
  l_clob clob;
  l_length number := 1;
begin
c1:=c1||'<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">'||chr(10)||
''||chr(10)||
'<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="&BROWSER_LANGUAGE." lang="&BROWSER_LANGUAGE.">'||chr(10)||
'<head>'||chr(10)||
'<title>#TITLE#</title>'||chr(10)||
''||chr(10)||
'<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />'||chr(10)||
'<meta http-equiv="Content-Style-Type" content="text/css" />'||chr(10)||
''||chr(10)||
'#HEAD#'||chr(10)||
'<link href="#IMAGE_P';

c1:=c1||'REFIX#themes/theme_514/style.css" rel="stylesheet" type="text/css" />'||chr(10)||
'<!--[if lt IE 9]><link href="#IMAGE_PREFIX#themes/theme_514/iestyle.css" rel="stylesheet" type="text/css" /><![endif]-->'||chr(10)||
'<script src="#IMAGE_PREFIX#themes/theme_514/cufon-yui.js" type="text/javascript"></script>'||chr(10)||
'<script src="#IMAGE_PREFIX#themes/theme_514/cufon-replace.js" type="text/javascript"></script>'||chr(10)||
''||chr(10)||
''||chr(10)||
'<script src="#IMAGE_P';

c1:=c1||'REFIX#themes/theme_514/wickhop_handwriting_400.font.js" type="text/javascript"></script>'||chr(10)||
'<script src="#IMAGE_PREFIX#themes/theme_514/maxheight.js" type="text/javascript"></script>'||chr(10)||
''||chr(10)||
'<script src="#IMAGE_PREFIX#themes/theme_514/script.js" type="text/javascript"></script>'||chr(10)||
''||chr(10)||
''||chr(10)||
''||chr(10)||
'<link rel="shortcut icon" href="#IMAGE_PREFIX#themes/theme_514/favicon.ico" type="image/x-icon" />'||chr(10)||
''||chr(10)||
'</head>'||chr(10)||
'<body id="one-level-';

c1:=c1||'sidebar" #ONLOAD# onload="new ElementMaxHeight()">'||chr(10)||
'#FORM_OPEN#';

c2:=c2||'   <!-- FOOTER -->'||chr(10)||
'<div id="footer-wrap">'||chr(10)||
'   <div id="footer">'||chr(10)||
'      #REGION_POSITION_08#'||chr(10)||
'      <div style="position: absolute; top: 10px; right: 30px;"><a href="http://www.apex-designers.com" title="APEX-Designers.com">'||chr(10)||
'      <img src="#IMAGE_PREFIX#themes/theme_514/ad_logo.png" alt="www.APEX-Designers.com"/></a>'||chr(10)||
'      </div>'||chr(10)||
'   </div>'||chr(10)||
'</div>'||chr(10)||
'#FORM_CLOSE# '||chr(10)||
'<script type="text/javascript"> Cufon.no';

c2:=c2||'w(); </script>'||chr(10)||
'</body>'||chr(10)||
'</html>';

c3:=c3||'<div id="main">'||chr(10)||
'   <!-- HEADER -->'||chr(10)||
'   <div id="header">'||chr(10)||
'       <div class="logo-nav">'||chr(10)||
'	<h1 class="logo">#LOGO#</h1>'||chr(10)||
'        <ul >#NAVIGATION_BAR#<li class="user"><a href="#">&APP_USER.</a></li></ul>'||chr(10)||
'       </div>'||chr(10)||
''||chr(10)||
'       <div class="tabs">'||chr(10)||
'          <ul class="wrapper">#TAB_CELLS#</ul>'||chr(10)||
'       </div>'||chr(10)||
'   </div>   <!-- /HEADER -->'||chr(10)||
'   <div id="breadcrumb">'||chr(10)||
'               #REGION_POSITION_01#'||chr(10)||
'         ';

c3:=c3||'      #REGION_POSITION_07#'||chr(10)||
'   </div>'||chr(10)||
''||chr(10)||
'   <div id="messages">#NOTIFICATION_MESSAGE##SUCCESS_MESSAGE#</div>'||chr(10)||
''||chr(10)||
'   <!-- CONTENT -->'||chr(10)||
'   <div id="content">'||chr(10)||
'         <div class="wrapper">'||chr(10)||
'             #REGION_POSITION_04#'||chr(10)||
'            <div class="box-body">'||chr(10)||
'             #BOX_BODY#'||chr(10)||
'            #REGION_POSITION_03#'||chr(10)||
'            </div>'||chr(10)||
'            <div class="side-box">'||chr(10)||
'             #REGION_POSITION_02#'||chr(10)||
'      ';

c3:=c3||'      </div>'||chr(10)||
''||chr(10)||
'            #REGION_POSITION_05#'||chr(10)||
'            #REGION_POSITION_06#'||chr(10)||
''||chr(10)||
'         </div>'||chr(10)||
'   </div>   <!-- /CONTENT -->'||chr(10)||
'</div>   <!-- /main -->';

wwv_flow_api.create_template(
  p_id=> 29483628800459461 + wwv_flow_api.g_id_offset,
  p_flow_id=> wwv_flow.g_flow_id,
  p_name=> 'One Level Tabs with Sidebar',
  p_body_title=> '',
  p_header_template=> c1,
  p_box=> c3,
  p_footer_template=> c2,
  p_success_message=> '<div class="success" id="MESSAGE">'||chr(10)||
'<img src="#IMAGE_PREFIX#themes/theme_514/close.png" onclick="$x_Remove(''MESSAGE'')" alt="Close" />#SUCCESS_MESSAGE#'||chr(10)||
'</div>',
  p_current_tab=> '<li class="current"><a href="#TAB_LINK#">#TAB_LABEL#</a></li>',
  p_current_tab_font_attr=> '',
  p_non_current_tab=> '<li><a href="#TAB_LINK#">#TAB_LABEL#</a></li>',
  p_non_current_tab_font_attr => '',
  p_top_current_tab=> '',
  p_top_current_tab_font_attr => '',
  p_top_non_curr_tab=> '',
  p_top_non_curr_tab_font_attr=> '',
  p_current_image_tab=> '',
  p_non_current_image_tab=> '',
  p_notification_message=> '<div class="notification" id="MESSAGE"><img src="#IMAGE_PREFIX#themes/theme_514/close.png" onclick="$x_Remove(''MESSAGE'')"  alt="Close" />#MESSAGE#</div>',
  p_navigation_bar=> '#BAR_BODY#',
  p_navbar_entry=> '<li><a href="#LINK#">#TEXT#</a></li>',
  p_app_tab_before_tabs=>'',
  p_app_tab_current_tab=>'',
  p_app_tab_non_current_tab=>'',
  p_app_tab_after_tabs=>'',
  p_region_table_cattributes=> ' summary="" cellpadding="0" border="0" cellspacing="5" align="left"',
  p_sidebar_def_reg_pos => 'REGION_POSITION_02',
  p_breadcrumb_def_reg_pos => 'REGION_POSITION_01',
  p_theme_id  => wwv_flow.g_flow_theme_id,
  p_theme_class_id => 16,
  p_template_comment => '');
end;
 
null;
 
end;
/

prompt  ...button templates
--
--application/shared_components/user_interface/templates/button/button
prompt  ......Button Template 29478940667167225
declare
  t varchar2(32767) := null;
  l_clob clob;
  l_length number := 1;
begin
t:=t||'<a href="#LINK#" class="button"><em>#LABEL#</em><b>&nbsp;</b></a>';

wwv_flow_api.create_button_templates (
  p_id=>29478940667167225 + wwv_flow_api.g_id_offset,
  p_flow_id=>wwv_flow.g_flow_id,
  p_template=>t,
  p_template_name=> 'Button',
  p_theme_id  => wwv_flow.g_flow_theme_id,
  p_theme_class_id => 1,
  p_template_comment       => 'Standard Button');
end;
/
--application/shared_components/user_interface/templates/button/button_alternative_1
prompt  ......Button Template 29479139836167227
declare
  t varchar2(32767) := null;
  l_clob clob;
  l_length number := 1;
begin
t:=t||'<a href="#LINK#" class="button button1"><em>#LABEL#</em><b>&nbsp;</b></a>';

wwv_flow_api.create_button_templates (
  p_id=>29479139836167227 + wwv_flow_api.g_id_offset,
  p_flow_id=>wwv_flow.g_flow_id,
  p_template=>t,
  p_template_name=> 'Button, Alternative 1',
  p_theme_id  => wwv_flow.g_flow_theme_id,
  p_theme_class_id => 4,
  p_template_comment       => 'XP Square FFFFFF');
end;
/
--application/shared_components/user_interface/templates/button/button_alternative_2
prompt  ......Button Template 29479322619167227
declare
  t varchar2(32767) := null;
  l_clob clob;
  l_length number := 1;
begin
t:=t||'<a href="#LINK#" class="button button2">#LABEL#</a>';

wwv_flow_api.create_button_templates (
  p_id=>29479322619167227 + wwv_flow_api.g_id_offset,
  p_flow_id=>wwv_flow.g_flow_id,
  p_template=>t,
  p_template_name=> 'Button, Alternative 2',
  p_theme_id  => wwv_flow.g_flow_theme_id,
  p_theme_class_id => 5,
  p_template_comment       => 'Standard Button');
end;
/
--application/shared_components/user_interface/templates/button/button_alternative_3
prompt  ......Button Template 29479515014167227
declare
  t varchar2(32767) := null;
  l_clob clob;
  l_length number := 1;
begin
t:=t||'<a href="#LINK#" class="button button3">#LABEL#</a>';

wwv_flow_api.create_button_templates (
  p_id=>29479515014167227 + wwv_flow_api.g_id_offset,
  p_flow_id=>wwv_flow.g_flow_id,
  p_template=>t,
  p_template_name=> 'Button, Alternative 3',
  p_theme_id  => wwv_flow.g_flow_theme_id,
  p_theme_class_id => 2,
  p_template_comment       => 'Standard Button');
end;
/
---------------------------------------
prompt  ...region templates
--
--application/shared_components/user_interface/templates/region/form_region_w_o_title_and_buttons
prompt  ......region template 15589132851233112
 
begin
 
wwv_flow_api.create_plug_template (
  p_id => 15589132851233112 + wwv_flow_api.g_id_offset
 ,p_flow_id => wwv_flow.g_flow_id
 ,p_template => 
'<div class="region-box">'||chr(10)||
'   <div class="border-right">'||chr(10)||
'      <div class="border-left">'||chr(10)||
'          <div class="left-top-corner">'||chr(10)||
'             <div class="right-top-corner">'||chr(10)||
''||chr(10)||
'		<div class="region form" id="#REGION_STATIC_ID#" #REGION_ATTRIBUTES#>'||chr(10)||
'		<div class="regionbody clear overflow"> #BODY# </div>'||chr(10)||
'		</div>'||chr(10)||
'		'||chr(10)||
'             </div>'||chr(10)||
'          </div>'||chr(10)||
'      </div>'||chr(10)||
'   </div>'||chr(10)||
'<div class="border-bot"><div'||
' class="left-bot-corner"><div class="right-bot-corner"></div></div></div>'||chr(10)||
'</div> '
 ,p_page_plug_template_name => 'Form Region w/o Title and Buttons'
 ,p_plug_table_bgcolor => '#f7f7e7'
,p_theme_id => wwv_flow.g_flow_theme_id
 ,p_theme_class_id => 8
 ,p_plug_heading_bgcolor => '#f7f7e7'
 ,p_plug_font_size => '-1'
 ,p_translate_this_template => 'N'
 ,p_template_comment => 'Red Theme'
  );
null;
 
end;
/

 
begin
 
declare
    t2 varchar2(32767) := null;
begin
t2 := null;
wwv_flow_api.set_plug_template_tab_attr (
  p_id=> 15589132851233112 + wwv_flow_api.g_id_offset,
  p_form_table_attr=> t2 );
exception when others then null;
end;
null;
 
end;
/

--application/shared_components/user_interface/templates/region/borderless_region
prompt  ......region template 29464331286167188
 
begin
 
wwv_flow_api.create_plug_template (
  p_id => 29464331286167188 + wwv_flow_api.g_id_offset
 ,p_flow_id => wwv_flow.g_flow_id
 ,p_template => 
'<div class="region borderless" id="#REGION_STATIC_ID#" #REGION_ATTRIBUTES#>'||chr(10)||
'<h3>#TITLE#</h3>'||chr(10)||
'<div class="buttons">#CLOSE#&nbsp;&nbsp;#PREVIOUS##NEXT#&nbsp;#DELETE##EDIT##CHANGE##CREATE##CREATE2##EXPAND##COPY##HELP#</div>'||chr(10)||
'<div class="regionbody clear overflow"> #BODY# </div>'||chr(10)||
'</div>'
 ,p_page_plug_template_name => 'Borderless Region'
 ,p_plug_table_bgcolor => '#f7f7e7'
,p_theme_id => wwv_flow.g_flow_theme_id
 ,p_theme_class_id => 7
 ,p_plug_heading_bgcolor => '#f7f7e7'
 ,p_plug_font_size => '-1'
  );
null;
 
end;
/

 
begin
 
declare
    t2 varchar2(32767) := null;
begin
t2 := null;
wwv_flow_api.set_plug_template_tab_attr (
  p_id=> 29464331286167188 + wwv_flow_api.g_id_offset,
  p_form_table_attr=> t2 );
exception when others then null;
end;
null;
 
end;
/

--application/shared_components/user_interface/templates/region/bracketed_region
prompt  ......region template 29464618447167189
 
begin
 
wwv_flow_api.create_plug_template (
  p_id => 29464618447167189 + wwv_flow_api.g_id_offset
 ,p_flow_id => wwv_flow.g_flow_id
 ,p_template => 
'<div class="region bracketed" id="#REGION_STATIC_ID#" #REGION_ATTRIBUTES#>'||chr(10)||
'<h3>#TITLE#</h3>'||chr(10)||
'<div class="buttons">#CLOSE#&nbsp;&nbsp;#PREVIOUS##NEXT#&nbsp;#DELETE##EDIT##CHANGE##CREATE##CREATE2##EXPAND##COPY##HELP#</div>'||chr(10)||
'<div class="regionbody clear overflow"> #BODY# </div>'||chr(10)||
'</div>'
 ,p_page_plug_template_name => 'Bracketed Region'
 ,p_plug_table_bgcolor => '#ffffff'
,p_theme_id => wwv_flow.g_flow_theme_id
 ,p_theme_class_id => 18
 ,p_plug_heading_bgcolor => '#ffffff'
 ,p_plug_font_size => '-1'
 ,p_translate_this_template => 'N'
 ,p_template_comment => 'Red Theme'
  );
null;
 
end;
/

 
begin
 
declare
    t2 varchar2(32767) := null;
begin
t2 := null;
wwv_flow_api.set_plug_template_tab_attr (
  p_id=> 29464618447167189 + wwv_flow_api.g_id_offset,
  p_form_table_attr=> t2 );
exception when others then null;
end;
null;
 
end;
/

--application/shared_components/user_interface/templates/region/breadcrumb_region
prompt  ......region template 29464946652167191
 
begin
 
wwv_flow_api.create_plug_template (
  p_id => 29464946652167191 + wwv_flow_api.g_id_offset
 ,p_flow_id => wwv_flow.g_flow_id
 ,p_template => 
'<div id="#REGION_STATIC_ID#" #REGION_ATTRIBUTES# class="fleft">#BODY#</div>'
 ,p_page_plug_template_name => 'Breadcrumb Region'
,p_theme_id => wwv_flow.g_flow_theme_id
 ,p_theme_class_id => 6
 ,p_translate_this_template => 'N'
  );
null;
 
end;
/

 
begin
 
declare
    t2 varchar2(32767) := null;
begin
t2 := null;
wwv_flow_api.set_plug_template_tab_attr (
  p_id=> 29464946652167191 + wwv_flow_api.g_id_offset,
  p_form_table_attr=> t2 );
exception when others then null;
end;
null;
 
end;
/

--application/shared_components/user_interface/templates/region/button_region_with_title
prompt  ......region template 29465228790167191
 
begin
 
wwv_flow_api.create_plug_template (
  p_id => 29465228790167191 + wwv_flow_api.g_id_offset
 ,p_flow_id => wwv_flow.g_flow_id
 ,p_template => 
'<div class="region buttonregionwtitle" id="#REGION_STATIC_ID#" #REGION_ATTRIBUTES#>'||chr(10)||
'<h3>#TITLE#</h3>'||chr(10)||
'<div class="buttons">#CLOSE#&nbsp;&nbsp;#PREVIOUS##NEXT#&nbsp;#DELETE##EDIT##CHANGE##CREATE##CREATE2##EXPAND##COPY##HELP#</div>'||chr(10)||
'<div class="regionbody clear overflow"> #BODY# </div>'||chr(10)||
'</div>'
 ,p_page_plug_template_name => 'Button Region with Title'
,p_theme_id => wwv_flow.g_flow_theme_id
 ,p_theme_class_id => 4
 ,p_translate_this_template => 'N'
  );
null;
 
end;
/

 
begin
 
declare
    t2 varchar2(32767) := null;
begin
t2 := null;
wwv_flow_api.set_plug_template_tab_attr (
  p_id=> 29465228790167191 + wwv_flow_api.g_id_offset,
  p_form_table_attr=> t2 );
exception when others then null;
end;
null;
 
end;
/

--application/shared_components/user_interface/templates/region/button_region_without_title
prompt  ......region template 29465516501167191
 
begin
 
wwv_flow_api.create_plug_template (
  p_id => 29465516501167191 + wwv_flow_api.g_id_offset
 ,p_flow_id => wwv_flow.g_flow_id
 ,p_template => 
'<div class="region buttonregionwotitle" id="#REGION_STATIC_ID#" #REGION_ATTRIBUTES#>'||chr(10)||
'<h3>#TITLE#</h3>'||chr(10)||
'<div class="buttons">#CLOSE#&nbsp;&nbsp;#PREVIOUS##NEXT#&nbsp;#DELETE##EDIT##CHANGE##CREATE##CREATE2##EXPAND##COPY##HELP#</div>'||chr(10)||
'<div class="regionbody clear overflow"> #BODY# </div>'||chr(10)||
'</div>'
 ,p_page_plug_template_name => 'Button Region without Title'
 ,p_plug_table_bgcolor => '#ffffff'
,p_theme_id => wwv_flow.g_flow_theme_id
 ,p_theme_class_id => 17
 ,p_plug_heading_bgcolor => '#ffffff'
 ,p_plug_font_size => '-1'
 ,p_translate_this_template => 'N'
 ,p_template_comment => 'Red Theme'
  );
null;
 
end;
/

 
begin
 
declare
    t2 varchar2(32767) := null;
begin
t2 := null;
wwv_flow_api.set_plug_template_tab_attr (
  p_id=> 29465516501167191 + wwv_flow_api.g_id_offset,
  p_form_table_attr=> t2 );
exception when others then null;
end;
null;
 
end;
/

--application/shared_components/user_interface/templates/region/form_region
prompt  ......region template 29466419307167192
 
begin
 
wwv_flow_api.create_plug_template (
  p_id => 29466419307167192 + wwv_flow_api.g_id_offset
 ,p_flow_id => wwv_flow.g_flow_id
 ,p_template => 
'<div class="region-box">'||chr(10)||
'   <div class="border-right">'||chr(10)||
'      <div class="border-left">'||chr(10)||
'          <div class="left-top-corner">'||chr(10)||
'             <div class="right-top-corner">'||chr(10)||
''||chr(10)||
'		<div class="region form" id="#REGION_STATIC_ID#" #REGION_ATTRIBUTES#><h3>#TITLE#</h3>'||chr(10)||
'		<div class="buttons">#CLOSE#&nbsp;&nbsp;#PREVIOUS##NEXT#&nbsp;#DELETE##EDIT##CHANGE##CREATE##CREATE2##EXPAND##COPY##HELP#</div>'||chr(10)||
'		<div cla'||
'ss="regionbody clear overflow"> #BODY# </div>'||chr(10)||
'		</div>'||chr(10)||
'		'||chr(10)||
'             </div>'||chr(10)||
'          </div>'||chr(10)||
'      </div>'||chr(10)||
'   </div>'||chr(10)||
'<div class="border-bot"><div class="left-bot-corner"><div class="right-bot-corner"></div></div></div>'||chr(10)||
'</div> '
 ,p_page_plug_template_name => 'Form Region'
 ,p_plug_table_bgcolor => '#f7f7e7'
,p_theme_id => wwv_flow.g_flow_theme_id
 ,p_theme_class_id => 8
 ,p_plug_heading_bgcolor => '#f7f7e7'
 ,p_plug_font_size => '-1'
 ,p_translate_this_template => 'N'
 ,p_template_comment => 'Red Theme'
  );
null;
 
end;
/

 
begin
 
declare
    t2 varchar2(32767) := null;
begin
t2 := null;
wwv_flow_api.set_plug_template_tab_attr (
  p_id=> 29466419307167192 + wwv_flow_api.g_id_offset,
  p_form_table_attr=> t2 );
exception when others then null;
end;
null;
 
end;
/

--application/shared_components/user_interface/templates/region/hide_and_show_region
prompt  ......region template 29466746178167192
 
begin
 
wwv_flow_api.create_plug_template (
  p_id => 29466746178167192 + wwv_flow_api.g_id_offset
 ,p_flow_id => wwv_flow.g_flow_id
 ,p_template => 
'<div class="region hideandshow" id="#REGION_STATIC_ID#" #REGION_ATTRIBUTES#>'||chr(10)||
'<h3 class="underline" onclick="$x_ToggleWithImage(''#REGION_ID#image'',''#REGION_ID#body'')" >#TITLE#</h3>'||chr(10)||
'<img src="#IMAGE_PREFIX#themes/theme_514/plus.png" onclick="$x_ToggleWithImage(this,''#REGION_ID#body'')" id="#REGION_ID#image" alt="" />'||chr(10)||
''||chr(10)||
'<div class="buttons">#CLOSE#&nbsp;&nbsp;#PREVIOUS##NEXT#&nbsp;#DELETE##EDIT##CHANGE'||
'##CREATE##CREATE2##EXPAND##COPY##HELP#</div>'||chr(10)||
''||chr(10)||
'<div  id="#REGION_ID#body"  class="regionbody clear overflow" style="display:none;"> #BODY# </div>'||chr(10)||
'</div>'||chr(10)||
''||chr(10)||
''||chr(10)||
''||chr(10)||
''||chr(10)||
''
 ,p_page_plug_template_name => 'Hide and Show Region'
 ,p_plug_table_bgcolor => '#ffffff'
,p_theme_id => wwv_flow.g_flow_theme_id
 ,p_theme_class_id => 1
 ,p_plug_heading_bgcolor => '#ffffff'
 ,p_plug_font_size => '-1'
  );
null;
 
end;
/

 
begin
 
declare
    t2 varchar2(32767) := null;
begin
t2 := null;
wwv_flow_api.set_plug_template_tab_attr (
  p_id=> 29466746178167192 + wwv_flow_api.g_id_offset,
  p_form_table_attr=> t2 );
exception when others then null;
end;
null;
 
end;
/

--application/shared_components/user_interface/templates/region/navigation_region
prompt  ......region template 29467032915167192
 
begin
 
wwv_flow_api.create_plug_template (
  p_id => 29467032915167192 + wwv_flow_api.g_id_offset
 ,p_flow_id => wwv_flow.g_flow_id
 ,p_template => 
'<div class="region navigation" id="#REGION_STATIC_ID#" #REGION_ATTRIBUTES#>'||chr(10)||
'<h3>#TITLE#</h3>'||chr(10)||
'<div class="buttons">#CLOSE#&nbsp;&nbsp;#PREVIOUS##NEXT#&nbsp;#DELETE##EDIT##CHANGE##CREATE##CREATE2##EXPAND##COPY##HELP#</div>'||chr(10)||
'<div class="regionbody clear overflow"> #BODY# </div>'||chr(10)||
'</div>'||chr(10)||
''
 ,p_page_plug_template_name => 'Navigation Region'
,p_theme_id => wwv_flow.g_flow_theme_id
 ,p_theme_class_id => 5
 ,p_translate_this_template => 'N'
  );
null;
 
end;
/

 
begin
 
declare
    t2 varchar2(32767) := null;
begin
t2 := null;
wwv_flow_api.set_plug_template_tab_attr (
  p_id=> 29467032915167192 + wwv_flow_api.g_id_offset,
  p_form_table_attr=> t2 );
exception when others then null;
end;
null;
 
end;
/

--application/shared_components/user_interface/templates/region/navigation_region_alternative_1
prompt  ......region template 29467346704167192
 
begin
 
wwv_flow_api.create_plug_template (
  p_id => 29467346704167192 + wwv_flow_api.g_id_offset
 ,p_flow_id => wwv_flow.g_flow_id
 ,p_template => 
'<div class="region navigationalt1" id="#REGION_STATIC_ID#" #REGION_ATTRIBUTES#>'||chr(10)||
'<h3 class="green">#TITLE#</h3>'||chr(10)||
'<div class="buttons">#CLOSE#&nbsp;&nbsp;#PREVIOUS##NEXT#&nbsp;#DELETE##EDIT##CHANGE##CREATE##CREATE2##EXPAND##COPY##HELP#</div>'||chr(10)||
'<div class="regionbody clear overflow"> #BODY# </div>'||chr(10)||
'</div>'||chr(10)||
''
 ,p_page_plug_template_name => 'Navigation Region, Alternative 1'
,p_theme_id => wwv_flow.g_flow_theme_id
 ,p_theme_class_id => 16
 ,p_translate_this_template => 'N'
  );
null;
 
end;
/

 
begin
 
declare
    t2 varchar2(32767) := null;
begin
t2 := null;
wwv_flow_api.set_plug_template_tab_attr (
  p_id=> 29467346704167192 + wwv_flow_api.g_id_offset,
  p_form_table_attr=> t2 );
exception when others then null;
end;
null;
 
end;
/

--application/shared_components/user_interface/templates/region/region_without_buttons_and_title
prompt  ......region template 29467626818167192
 
begin
 
wwv_flow_api.create_plug_template (
  p_id => 29467626818167192 + wwv_flow_api.g_id_offset
 ,p_flow_id => wwv_flow.g_flow_id
 ,p_template => 
'<div class="region wobuttonsandtitle" id="#REGION_STATIC_ID#" #REGION_ATTRIBUTES#>'||chr(10)||
'<h3>#TITLE#</h3>'||chr(10)||
'<div class="buttons">#CLOSE#&nbsp;&nbsp;#PREVIOUS##NEXT#&nbsp;#DELETE##EDIT##CHANGE##CREATE##CREATE2##EXPAND##COPY##HELP#</div>'||chr(10)||
'<div class="regionbody clear overflow"> #BODY# </div>'||chr(10)||
'</div>'
 ,p_page_plug_template_name => 'Region without Buttons and Title'
,p_theme_id => wwv_flow.g_flow_theme_id
 ,p_theme_class_id => 19
 ,p_translate_this_template => 'N'
  );
null;
 
end;
/

 
begin
 
declare
    t2 varchar2(32767) := null;
begin
t2 := null;
wwv_flow_api.set_plug_template_tab_attr (
  p_id=> 29467626818167192 + wwv_flow_api.g_id_offset,
  p_form_table_attr=> t2 );
exception when others then null;
end;
null;
 
end;
/

--application/shared_components/user_interface/templates/region/region_without_title
prompt  ......region template 29467918107167192
 
begin
 
wwv_flow_api.create_plug_template (
  p_id => 29467918107167192 + wwv_flow_api.g_id_offset
 ,p_flow_id => wwv_flow.g_flow_id
 ,p_template => 
'<div class="region wotitle" id="#REGION_STATIC_ID#" #REGION_ATTRIBUTES#>'||chr(10)||
'<h3>#TITLE#</h3>'||chr(10)||
'<div class="buttons">#CLOSE#&nbsp;&nbsp;#PREVIOUS##NEXT#&nbsp;#DELETE##EDIT##CHANGE##CREATE##CREATE2##EXPAND##COPY##HELP#</div>'||chr(10)||
'<div class="regionbody clear overflow"> #BODY# </div>'||chr(10)||
'</div>'
 ,p_page_plug_template_name => 'Region without Title'
,p_theme_id => wwv_flow.g_flow_theme_id
 ,p_theme_class_id => 11
 ,p_translate_this_template => 'N'
  );
null;
 
end;
/

 
begin
 
declare
    t2 varchar2(32767) := null;
begin
t2 := null;
wwv_flow_api.set_plug_template_tab_attr (
  p_id=> 29467918107167192 + wwv_flow_api.g_id_offset,
  p_form_table_attr=> t2 );
exception when others then null;
end;
null;
 
end;
/

--application/shared_components/user_interface/templates/region/reports_region
prompt  ......region template 29468534142167192
 
begin
 
wwv_flow_api.create_plug_template (
  p_id => 29468534142167192 + wwv_flow_api.g_id_offset
 ,p_flow_id => wwv_flow.g_flow_id
 ,p_template => 
'<div class="region" id="#REGION_STATIC_ID#" #REGION_ATTRIBUTES#>'||chr(10)||
'<h3>#TITLE#</h3>'||chr(10)||
'<div class="buttons">#CLOSE#&nbsp;&nbsp;#PREVIOUS##NEXT#&nbsp;#DELETE##EDIT##CHANGE##CREATE##CREATE2##EXPAND##COPY##HELP#</div>'||chr(10)||
'<div class="regionbody clear overflow"> #BODY# </div>'||chr(10)||
'</div>'
 ,p_page_plug_template_name => 'Reports Region'
 ,p_plug_table_bgcolor => '#ffffff'
,p_theme_id => wwv_flow.g_flow_theme_id
 ,p_theme_class_id => 9
 ,p_plug_heading_bgcolor => '#ffffff'
 ,p_plug_font_size => '-1'
 ,p_template_comment => 'Red Theme'
  );
null;
 
end;
/

 
begin
 
declare
    t2 varchar2(32767) := null;
begin
t2 := null;
wwv_flow_api.set_plug_template_tab_attr (
  p_id=> 29468534142167192 + wwv_flow_api.g_id_offset,
  p_form_table_attr=> t2 );
exception when others then null;
end;
null;
 
end;
/

--application/shared_components/user_interface/templates/region/reports_region_100_width
prompt  ......region template 29468827641167194
 
begin
 
wwv_flow_api.create_plug_template (
  p_id => 29468827641167194 + wwv_flow_api.g_id_offset
 ,p_flow_id => wwv_flow.g_flow_id
 ,p_template => 
'<div class="region" id="#REGION_STATIC_ID#" #REGION_ATTRIBUTES#>'||chr(10)||
'<h3>#TITLE#</h3>'||chr(10)||
'<div class="buttons">#CLOSE#&nbsp;&nbsp;#PREVIOUS##NEXT#&nbsp;#DELETE##EDIT##CHANGE##CREATE##CREATE2##EXPAND##COPY##HELP#</div>'||chr(10)||
'<div class="regionbody clear overflow"> #BODY# </div>'||chr(10)||
'</div>'
 ,p_page_plug_template_name => 'Reports Region 100% Width'
 ,p_plug_table_bgcolor => '#ffffff'
,p_theme_id => wwv_flow.g_flow_theme_id
 ,p_theme_class_id => 13
 ,p_plug_heading_bgcolor => '#ffffff'
 ,p_plug_font_size => '-1'
 ,p_translate_this_template => 'N'
 ,p_template_comment => 'Red Theme'
  );
null;
 
end;
/

 
begin
 
declare
    t2 varchar2(32767) := null;
begin
t2 := null;
wwv_flow_api.set_plug_template_tab_attr (
  p_id=> 29468827641167194 + wwv_flow_api.g_id_offset,
  p_form_table_attr=> t2 );
exception when others then null;
end;
null;
 
end;
/

--application/shared_components/user_interface/templates/region/reports_region_alternative_1
prompt  ......region template 29469128736167194
 
begin
 
wwv_flow_api.create_plug_template (
  p_id => 29469128736167194 + wwv_flow_api.g_id_offset
 ,p_flow_id => wwv_flow.g_flow_id
 ,p_template => 
'<div class="region alternative" id="#REGION_STATIC_ID#" #REGION_ATTRIBUTES#>'||chr(10)||
'<h3 class="green">#TITLE#</h3>'||chr(10)||
'<div class="buttons">#CLOSE#&nbsp;&nbsp;#PREVIOUS##NEXT#&nbsp;#DELETE##EDIT##CHANGE##CREATE##CREATE2##EXPAND##COPY##HELP#</div>'||chr(10)||
'<div class="regionbody clear overflow"> #BODY# </div>'||chr(10)||
'</div>'||chr(10)||
''||chr(10)||
''
 ,p_page_plug_template_name => 'Reports Region, Alternative 1'
 ,p_plug_table_bgcolor => '#ffffff'
,p_theme_id => wwv_flow.g_flow_theme_id
 ,p_theme_class_id => 10
 ,p_plug_heading_bgcolor => '#ffffff'
 ,p_plug_font_size => '-1'
 ,p_translate_this_template => 'N'
  );
null;
 
end;
/

 
begin
 
declare
    t2 varchar2(32767) := null;
begin
t2 := null;
wwv_flow_api.set_plug_template_tab_attr (
  p_id=> 29469128736167194 + wwv_flow_api.g_id_offset,
  p_form_table_attr=> t2 );
exception when others then null;
end;
null;
 
end;
/

--application/shared_components/user_interface/templates/region/sidebar_region
prompt  ......region template 29469429187167194
 
begin
 
wwv_flow_api.create_plug_template (
  p_id => 29469429187167194 + wwv_flow_api.g_id_offset
 ,p_flow_id => wwv_flow.g_flow_id
 ,p_template => 
'<div class="region sidebar" id="#REGION_STATIC_ID#" #REGION_ATTRIBUTES#>'||chr(10)||
'<h3>#TITLE#</h3>'||chr(10)||
'<div class="buttons">#CLOSE#&nbsp;&nbsp;#PREVIOUS##NEXT#&nbsp;#DELETE##EDIT##CHANGE##CREATE##CREATE2##EXPAND##COPY##HELP#</div>'||chr(10)||
'<div class="regionbody clear overflow"> #BODY# </div>'||chr(10)||
'</div>'
 ,p_page_plug_template_name => 'Sidebar Region'
 ,p_plug_table_bgcolor => '#f7f7e7'
,p_theme_id => wwv_flow.g_flow_theme_id
 ,p_theme_class_id => 2
 ,p_plug_heading_bgcolor => '#f7f7e7'
 ,p_plug_font_size => '-1'
 ,p_translate_this_template => 'N'
  );
null;
 
end;
/

 
begin
 
declare
    t2 varchar2(32767) := null;
begin
t2 := null;
wwv_flow_api.set_plug_template_tab_attr (
  p_id=> 29469429187167194 + wwv_flow_api.g_id_offset,
  p_form_table_attr=> t2 );
exception when others then null;
end;
null;
 
end;
/

--application/shared_components/user_interface/templates/region/sidebar_region_alternative_1
prompt  ......region template 29469747395167194
 
begin
 
wwv_flow_api.create_plug_template (
  p_id => 29469747395167194 + wwv_flow_api.g_id_offset
 ,p_flow_id => wwv_flow.g_flow_id
 ,p_template => 
'<div class="region sidebaralt1" id="#REGION_STATIC_ID#" #REGION_ATTRIBUTES#>'||chr(10)||
'<h3 class="green">#TITLE#</h3>'||chr(10)||
'<div class="buttons">#CLOSE#&nbsp;&nbsp;#PREVIOUS##NEXT#&nbsp;#DELETE##EDIT##CHANGE##CREATE##CREATE2##EXPAND##COPY##HELP#</div>'||chr(10)||
'<div class="regionbody clear overflow"> #BODY# </div>'||chr(10)||
'</div>'
 ,p_page_plug_template_name => 'Sidebar Region, Alternative 1'
 ,p_plug_table_bgcolor => '#f7f7e7'
,p_theme_id => wwv_flow.g_flow_theme_id
 ,p_theme_class_id => 3
 ,p_plug_heading_bgcolor => '#f7f7e7'
 ,p_plug_font_size => '-1'
 ,p_translate_this_template => 'N'
  );
null;
 
end;
/

 
begin
 
declare
    t2 varchar2(32767) := null;
begin
t2 := null;
wwv_flow_api.set_plug_template_tab_attr (
  p_id=> 29469747395167194 + wwv_flow_api.g_id_offset,
  p_form_table_attr=> t2 );
exception when others then null;
end;
null;
 
end;
/

--application/shared_components/user_interface/templates/region/test_region
prompt  ......region template 29470331698167194
 
begin
 
wwv_flow_api.create_plug_template (
  p_id => 29470331698167194 + wwv_flow_api.g_id_offset
 ,p_flow_id => wwv_flow.g_flow_id
 ,p_template => 
'<div class="testregion" id="#REGION_STATIC_ID#" #REGION_ATTRIBUTES#>'||chr(10)||
'<span> #TITLE# </span> '||chr(10)||
'#BODY#'||chr(10)||
'</div>'||chr(10)||
''||chr(10)||
''
 ,p_page_plug_template_name => 'Test Region'
,p_theme_id => wwv_flow.g_flow_theme_id
 ,p_theme_class_id => 5
 ,p_translate_this_template => 'N'
  );
null;
 
end;
/

 
begin
 
declare
    t2 varchar2(32767) := null;
begin
t2 := null;
wwv_flow_api.set_plug_template_tab_attr (
  p_id=> 29470331698167194 + wwv_flow_api.g_id_offset,
  p_form_table_attr=> t2 );
exception when others then null;
end;
null;
 
end;
/

prompt  ...List Templates
--
--application/shared_components/user_interface/templates/list/hierarchical_expanding
prompt  ......list template 29474223813167208
 
begin
 
declare
  t varchar2(32767) := null;
  t2 varchar2(32767) := null;
  t3 varchar2(32767) := null;
  t4 varchar2(32767) := null;
  t5 varchar2(32767) := null;
  t6 varchar2(32767) := null;
  t7 varchar2(32767) := null;
  t8 varchar2(32767) := null;
  l_clob clob;
  l_clob2 clob;
  l_clob3 clob;
  l_clob4 clob;
  l_clob5 clob;
  l_clob6 clob;
  l_clob7 clob;
  l_clob8 clob;
  l_length number := 1;
begin
t:=t||'<li><img src="#IMAGE_PREFIX#themes/theme_514/toggle-node.png" align="middle" alt="" />'||chr(10)||
'<a href="#LINK#">#TEXT#</a>'||chr(10)||
'</li>';

t2:=t2||'<li><img src="#IMAGE_PREFIX#themes/theme_514/toggle-node.png" align="middle"  alt="" /><a href="#LINK#">#TEXT#</a></li>';

t3:=t3||'<li><img src="#IMAGE_PREFIX#themes/theme_514/toggle-node.png" align="middle"  alt="" /><a href="#LINK#">#TEXT#</a></li>';

t4:=t4||'<li><img src="#IMAGE_PREFIX#themes/theme_514/toggle-node.png"  align="middle" alt="" /><a href="#LINK#">#TEXT#</a></li>';

t5:=t5||'<li><img src="#IMAGE_PREFIX#themes/theme_514/toggle-plus.png" align="middle" class="pseudoButtonInactive" /><a href="#LINK#" onclick="htmldb_ToggleWithImage(this,''#LIST_ITEM_ID#'')">#TEXT#</a></li>';

t6:=t6||'<li><img src="#IMAGE_PREFIX#themes/theme_514/toggle-plus.png" align="middle"  onclick="htmldb_ToggleWithImage(this,''#LIST_ITEM_ID#'')" class="pseudoButtonInactive" /><a href="#LINK#">#TEXT#</a></li>';

t7:=t7||'<li><img src="#IMAGE_PREFIX#themes/theme_514/toggle-plus.png" onclick="htmldb_ToggleWithImage(this,''#LIST_ITEM_ID#'')" align="middle" class="pseudoButtonInactive" /><a href="#LINK#">#TEXT#</a></li>';

t8:=t8||'<li><img src="#IMAGE_PREFIX#themes/theme_514/toggle-plus.png" onclick="htmldb_ToggleWithImage(this,''#LIST_ITEM_ID#'')" align="middle" class="pseudoButtonInactive" /><a href="#LINK#">#TEXT#</a></li>';

wwv_flow_api.create_list_template (
  p_id=>29474223813167208 + wwv_flow_api.g_id_offset,
  p_flow_id=>wwv_flow.g_flow_id,
  p_list_template_current=>t,
  p_list_template_noncurrent=> t2,
  p_list_template_name=>'Hierarchical Expanding',
  p_theme_id  => wwv_flow.g_flow_theme_id,
  p_theme_class_id => 22,
  p_list_template_before_rows=>'<ul class="dhtmlTree">',
  p_list_template_after_rows=>'</ul><br style="clear:both;"/><br style="clear:both;"/>',
  p_before_sub_list=>'<ul id="#PARENT_LIST_ITEM_ID#" htmldb:listlevel="#LEVEL#" style="display:none;" class="dhtmlTree">',
  p_after_sub_list=>'</ul>',
  p_sub_list_item_current=> t3,
  p_sub_list_item_noncurrent=> t4,
  p_item_templ_curr_w_child=> t5,
  p_item_templ_noncurr_w_child=> t6,
  p_sub_templ_curr_w_child=> t7,
  p_sub_templ_noncurr_w_child=> t8,
  p_list_template_comment=>'');
end;
null;
 
end;
/

--application/shared_components/user_interface/templates/list/horizontal_images_with_label_list
prompt  ......list template 29474538755167210
 
begin
 
declare
  t varchar2(32767) := null;
  t2 varchar2(32767) := null;
  t3 varchar2(32767) := null;
  t4 varchar2(32767) := null;
  t5 varchar2(32767) := null;
  t6 varchar2(32767) := null;
  t7 varchar2(32767) := null;
  t8 varchar2(32767) := null;
  l_clob clob;
  l_clob2 clob;
  l_clob3 clob;
  l_clob4 clob;
  l_clob5 clob;
  l_clob6 clob;
  l_clob7 clob;
  l_clob8 clob;
  l_length number := 1;
begin
t:=t||'<div class="current">'||chr(10)||
'<div class="image"><img src="#IMAGE_PREFIX##IMAGE#" border="0" #IMAGE_ATTR#/></div>'||chr(10)||
'#TEXT#'||chr(10)||
'</div>';

t2:=t2||'<div>'||chr(10)||
'<div class="image">'||chr(10)||
'<a href="#LINK#"><img src="#IMAGE_PREFIX##IMAGE#" border="0" #IMAGE_ATTR#/></a>'||chr(10)||
'</div>'||chr(10)||
'<a href="#LINK#">#TEXT#</a>'||chr(10)||
'</div>';

t3 := null;
t4 := null;
t5 := null;
t6 := null;
t7 := null;
t8 := null;
wwv_flow_api.create_list_template (
  p_id=>29474538755167210 + wwv_flow_api.g_id_offset,
  p_flow_id=>wwv_flow.g_flow_id,
  p_list_template_current=>t,
  p_list_template_noncurrent=> t2,
  p_list_template_name=>'Horizontal Images with Label List',
  p_theme_id  => wwv_flow.g_flow_theme_id,
  p_theme_class_id => 4,
  p_list_template_before_rows=>'<div class="HorizontalImageswithLabelList">',
  p_list_template_after_rows=>'</div>',
  p_translate_this_template => 'N',
  p_list_template_comment=>'');
end;
null;
 
end;
/

--application/shared_components/user_interface/templates/list/horizontal_links_list
prompt  ......list template 29474836565167210
 
begin
 
declare
  t varchar2(32767) := null;
  t2 varchar2(32767) := null;
  t3 varchar2(32767) := null;
  t4 varchar2(32767) := null;
  t5 varchar2(32767) := null;
  t6 varchar2(32767) := null;
  t7 varchar2(32767) := null;
  t8 varchar2(32767) := null;
  l_clob clob;
  l_clob2 clob;
  l_clob3 clob;
  l_clob4 clob;
  l_clob5 clob;
  l_clob6 clob;
  l_clob7 clob;
  l_clob8 clob;
  l_length number := 1;
begin
t:=t||'<a href="#LINK#" class="current">#TEXT#</a>';

t2:=t2||'<a href="#LINK#">#TEXT#</a>';

t3 := null;
t4 := null;
t5 := null;
t6 := null;
t7 := null;
t8 := null;
wwv_flow_api.create_list_template (
  p_id=>29474836565167210 + wwv_flow_api.g_id_offset,
  p_flow_id=>wwv_flow.g_flow_id,
  p_list_template_current=>t,
  p_list_template_noncurrent=> t2,
  p_list_template_name=>'Horizontal Links List',
  p_theme_id  => wwv_flow.g_flow_theme_id,
  p_theme_class_id => 3,
  p_list_template_before_rows=>'<div class="HorizontalLinksList">',
  p_list_template_after_rows=>'</div>',
  p_translate_this_template => 'N',
  p_list_template_comment=>'');
end;
null;
 
end;
/

--application/shared_components/user_interface/templates/list/tree_list
prompt  ......list template 29476042601167214
 
begin
 
declare
  t varchar2(32767) := null;
  t2 varchar2(32767) := null;
  t3 varchar2(32767) := null;
  t4 varchar2(32767) := null;
  t5 varchar2(32767) := null;
  t6 varchar2(32767) := null;
  t7 varchar2(32767) := null;
  t8 varchar2(32767) := null;
  l_clob clob;
  l_clob2 clob;
  l_clob3 clob;
  l_clob4 clob;
  l_clob5 clob;
  l_clob6 clob;
  l_clob7 clob;
  l_clob8 clob;
  l_length number := 1;
begin
t:=t||'<li><a href="#LINK#">#TEXT#</a></li>';

t2:=t2||'<li><a href="#LINK#">#TEXT#</a></li>';

t3:=t3||'<li><a href="#LINK#">#TEXT#</a></li>';

t4:=t4||'<li><a href="#LINK#">#TEXT#</a></li>';

t5:=t5||'<li><a href="#LINK#">#TEXT#</a></li>';

t6:=t6||'<li><a href="#LINK#">#TEXT#</a></li>';

t7:=t7||'<li><a href="#LINK#">#TEXT#</a></li>';

t8:=t8||'<li><a href="#LINK#">#TEXT#</a></li>';

wwv_flow_api.create_list_template (
  p_id=>29476042601167214 + wwv_flow_api.g_id_offset,
  p_flow_id=>wwv_flow.g_flow_id,
  p_list_template_current=>t,
  p_list_template_noncurrent=> t2,
  p_list_template_name=>'Tree List',
  p_theme_id  => wwv_flow.g_flow_theme_id,
  p_theme_class_id => 23,
  p_list_template_before_rows=>'<ul class="htmlTree">',
  p_list_template_after_rows=>'</ul><br style="clear:both;"/><br style="clear:both;"/>',
  p_before_sub_list=>'<ul id="#PARENT_LIST_ITEM_ID#" htmldb:listlevel="#LEVEL#">',
  p_after_sub_list=>'</ul>',
  p_sub_list_item_current=> t3,
  p_sub_list_item_noncurrent=> t4,
  p_item_templ_curr_w_child=> t5,
  p_item_templ_noncurr_w_child=> t6,
  p_sub_templ_curr_w_child=> t7,
  p_sub_templ_noncurr_w_child=> t8,
  p_translate_this_template => 'N',
  p_list_template_comment=>'');
end;
null;
 
end;
/

--application/shared_components/user_interface/templates/list/vertical_images_list
prompt  ......list template 29476340393167216
 
begin
 
declare
  t varchar2(32767) := null;
  t2 varchar2(32767) := null;
  t3 varchar2(32767) := null;
  t4 varchar2(32767) := null;
  t5 varchar2(32767) := null;
  t6 varchar2(32767) := null;
  t7 varchar2(32767) := null;
  t8 varchar2(32767) := null;
  l_clob clob;
  l_clob2 clob;
  l_clob3 clob;
  l_clob4 clob;
  l_clob5 clob;
  l_clob6 clob;
  l_clob7 clob;
  l_clob8 clob;
  l_length number := 1;
begin
t:=t||'<div class="image current">'||chr(10)||
'<a href="#LINK#"><img src="#IMAGE_PREFIX##IMAGE#" #IMAGE_ATTR# /></a> '||chr(10)||
'</div>'||chr(10)||
'<div class="label current">'||chr(10)||
'<a href="#LINK#">#TEXT#</a>'||chr(10)||
'</div>'||chr(10)||
'';

t2:=t2||'<div class="image">'||chr(10)||
'<a href="#LINK#"><img src="#IMAGE_PREFIX##IMAGE#" #IMAGE_ATTR# /></a> '||chr(10)||
'</div>'||chr(10)||
'<div class="label">'||chr(10)||
'<a href="#LINK#">#TEXT#</a>'||chr(10)||
'</div>';

t3 := null;
t4 := null;
t5 := null;
t6 := null;
t7 := null;
t8 := null;
wwv_flow_api.create_list_template (
  p_id=>29476340393167216 + wwv_flow_api.g_id_offset,
  p_flow_id=>wwv_flow.g_flow_id,
  p_list_template_current=>t,
  p_list_template_noncurrent=> t2,
  p_list_template_name=>'Vertical Images List',
  p_theme_id  => wwv_flow.g_flow_theme_id,
  p_theme_class_id => 5,
  p_list_template_before_rows=>'<div class="VerticalImagesList">',
  p_list_template_after_rows=>'</div>',
  p_between_items=>'<br />',
  p_translate_this_template => 'N',
  p_list_template_comment=>'');
end;
null;
 
end;
/

--application/shared_components/user_interface/templates/list/vertical_ordered_list
prompt  ......list template 29476926447167216
 
begin
 
declare
  t varchar2(32767) := null;
  t2 varchar2(32767) := null;
  t3 varchar2(32767) := null;
  t4 varchar2(32767) := null;
  t5 varchar2(32767) := null;
  t6 varchar2(32767) := null;
  t7 varchar2(32767) := null;
  t8 varchar2(32767) := null;
  l_clob clob;
  l_clob2 clob;
  l_clob3 clob;
  l_clob4 clob;
  l_clob5 clob;
  l_clob6 clob;
  l_clob7 clob;
  l_clob8 clob;
  l_length number := 1;
begin
t:=t||'<li class="current"><a href="#LINK#">#TEXT#</a></li>';

t2:=t2||'<li><a href="#LINK#">#TEXT#</a></li>';

t3 := null;
t4 := null;
t5 := null;
t6 := null;
t7 := null;
t8 := null;
wwv_flow_api.create_list_template (
  p_id=>29476926447167216 + wwv_flow_api.g_id_offset,
  p_flow_id=>wwv_flow.g_flow_id,
  p_list_template_current=>t,
  p_list_template_noncurrent=> t2,
  p_list_template_name=>'Vertical Ordered List',
  p_theme_id  => wwv_flow.g_flow_theme_id,
  p_theme_class_id => 2,
  p_list_template_before_rows=>'<ol class="VerticalOrderedList">',
  p_list_template_after_rows=>'</ol>',
  p_translate_this_template => 'N',
  p_list_template_comment=>'');
end;
null;
 
end;
/

--application/shared_components/user_interface/templates/list/vertical_sidebar_list
prompt  ......list template 29477223694167216
 
begin
 
declare
  t varchar2(32767) := null;
  t2 varchar2(32767) := null;
  t3 varchar2(32767) := null;
  t4 varchar2(32767) := null;
  t5 varchar2(32767) := null;
  t6 varchar2(32767) := null;
  t7 varchar2(32767) := null;
  t8 varchar2(32767) := null;
  l_clob clob;
  l_clob2 clob;
  l_clob3 clob;
  l_clob4 clob;
  l_clob5 clob;
  l_clob6 clob;
  l_clob7 clob;
  l_clob8 clob;
  l_length number := 1;
begin
t:=t||'<a href="#LINK#" class="current">#TEXT#</a>';

t2:=t2||'<a href="#LINK#">#TEXT#</a>';

t3 := null;
t4 := null;
t5 := null;
t6 := null;
t7 := null;
t8 := null;
wwv_flow_api.create_list_template (
  p_id=>29477223694167216 + wwv_flow_api.g_id_offset,
  p_flow_id=>wwv_flow.g_flow_id,
  p_list_template_current=>t,
  p_list_template_noncurrent=> t2,
  p_list_template_name=>'Vertical Sidebar List',
  p_theme_id  => wwv_flow.g_flow_theme_id,
  p_theme_class_id => 19,
  p_list_template_before_rows=>'<div class="VerticalSidebarList">',
  p_list_template_after_rows=>'</div>',
  p_translate_this_template => 'N',
  p_list_template_comment=>'');
end;
null;
 
end;
/

--application/shared_components/user_interface/templates/list/vertical_unordered_links_without_bullets
prompt  ......list template 29477519868167216
 
begin
 
declare
  t varchar2(32767) := null;
  t2 varchar2(32767) := null;
  t3 varchar2(32767) := null;
  t4 varchar2(32767) := null;
  t5 varchar2(32767) := null;
  t6 varchar2(32767) := null;
  t7 varchar2(32767) := null;
  t8 varchar2(32767) := null;
  l_clob clob;
  l_clob2 clob;
  l_clob3 clob;
  l_clob4 clob;
  l_clob5 clob;
  l_clob6 clob;
  l_clob7 clob;
  l_clob8 clob;
  l_length number := 1;
begin
t:=t||'<li class="current"><a href="#LINK#">#TEXT#</a></li>';

t2:=t2||'<li><a href="#LINK#">#TEXT#</a></li>';

t3 := null;
t4 := null;
t5 := null;
t6 := null;
t7 := null;
t8 := null;
wwv_flow_api.create_list_template (
  p_id=>29477519868167216 + wwv_flow_api.g_id_offset,
  p_flow_id=>wwv_flow.g_flow_id,
  p_list_template_current=>t,
  p_list_template_noncurrent=> t2,
  p_list_template_name=>'Vertical Unordered Links without Bullets',
  p_theme_id  => wwv_flow.g_flow_theme_id,
  p_theme_class_id => 18,
  p_list_template_before_rows=>'<ul class="VerticalUnorderedLinkswithoutBullets">',
  p_list_template_after_rows=>'</ul>',
  p_translate_this_template => 'N',
  p_list_template_comment=>'');
end;
null;
 
end;
/

--application/shared_components/user_interface/templates/list/vertical_unordered_list_with_bullets
prompt  ......list template 29477825368167219
 
begin
 
declare
  t varchar2(32767) := null;
  t2 varchar2(32767) := null;
  t3 varchar2(32767) := null;
  t4 varchar2(32767) := null;
  t5 varchar2(32767) := null;
  t6 varchar2(32767) := null;
  t7 varchar2(32767) := null;
  t8 varchar2(32767) := null;
  l_clob clob;
  l_clob2 clob;
  l_clob3 clob;
  l_clob4 clob;
  l_clob5 clob;
  l_clob6 clob;
  l_clob7 clob;
  l_clob8 clob;
  l_length number := 1;
begin
t:=t||'<li class="current #A01#"><a href="#LINK#">#TEXT#</a></li>';

t2:=t2||'<li class="#A01#"><a href="#LINK#">#TEXT#</a></li>';

t3 := null;
t4 := null;
t5 := null;
t6 := null;
t7 := null;
t8 := null;
wwv_flow_api.create_list_template (
  p_id=>29477825368167219 + wwv_flow_api.g_id_offset,
  p_flow_id=>wwv_flow.g_flow_id,
  p_list_template_current=>t,
  p_list_template_noncurrent=> t2,
  p_list_template_name=>'Vertical Unordered List with Bullets',
  p_theme_id  => wwv_flow.g_flow_theme_id,
  p_theme_class_id => 1,
  p_list_template_before_rows=>'<ul class="VerticalUnorderedListwithBullets">',
  p_list_template_after_rows=>'</ul>',
  p_sub_list_item_current=> t3,
  p_sub_list_item_noncurrent=> t4,
  p_item_templ_curr_w_child=> t5,
  p_item_templ_noncurr_w_child=> t6,
  p_sub_templ_curr_w_child=> t7,
  p_sub_templ_noncurr_w_child=> t8,
  p_list_template_comment=>'');
end;
null;
 
end;
/

--application/shared_components/user_interface/templates/list/wizard_progress_list
prompt  ......list template 29478119264167219
 
begin
 
declare
  t varchar2(32767) := null;
  t2 varchar2(32767) := null;
  t3 varchar2(32767) := null;
  t4 varchar2(32767) := null;
  t5 varchar2(32767) := null;
  t6 varchar2(32767) := null;
  t7 varchar2(32767) := null;
  t8 varchar2(32767) := null;
  l_clob clob;
  l_clob2 clob;
  l_clob3 clob;
  l_clob4 clob;
  l_clob5 clob;
  l_clob6 clob;
  l_clob7 clob;
  l_clob8 clob;
  l_length number := 1;
begin
t:=t||'<li class="current">#TEXT#</li>';

t2:=t2||'<li>#TEXT#</li>';

t3 := null;
t4 := null;
t5 := null;
t6 := null;
t7 := null;
t8 := null;
wwv_flow_api.create_list_template (
  p_id=>29478119264167219 + wwv_flow_api.g_id_offset,
  p_flow_id=>wwv_flow.g_flow_id,
  p_list_template_current=>t,
  p_list_template_noncurrent=> t2,
  p_list_template_name=>'Wizard Progress List',
  p_theme_id  => wwv_flow.g_flow_theme_id,
  p_theme_class_id => 17,
  p_list_template_before_rows=>'<ul class="WizardProgressList">',
  p_list_template_after_rows=>'</ul>',
  p_sub_list_item_current=> t3,
  p_sub_list_item_noncurrent=> t4,
  p_item_templ_curr_w_child=> t5,
  p_item_templ_noncurr_w_child=> t6,
  p_sub_templ_curr_w_child=> t7,
  p_sub_templ_noncurr_w_child=> t8,
  p_list_template_comment=>'');
end;
null;
 
end;
/

--application/shared_components/user_interface/templates/list/hierarchical_expanded
prompt  ......list template 29559528870266300
 
begin
 
declare
  t varchar2(32767) := null;
  t2 varchar2(32767) := null;
  t3 varchar2(32767) := null;
  t4 varchar2(32767) := null;
  t5 varchar2(32767) := null;
  t6 varchar2(32767) := null;
  t7 varchar2(32767) := null;
  t8 varchar2(32767) := null;
  l_clob clob;
  l_clob2 clob;
  l_clob3 clob;
  l_clob4 clob;
  l_clob5 clob;
  l_clob6 clob;
  l_clob7 clob;
  l_clob8 clob;
  l_length number := 1;
begin
t:=t||'<li class="current"><a href="#LINK#" class="current">#TEXT#</a></li>';

t2:=t2||'<li><a href="#LINK#">#TEXT#</a></li>';

t3:=t3||'<li class="current"><a href="#LINK#" class="current">#TEXT#</a></li>';

t4:=t4||'<li><a href="#LINK#">#TEXT#</a></li>';

t5:=t5||'<li><a href="#LINK#" class="current">#TEXT#</a> <ul class="current"> ';

t6:=t6||'<li><a href="#LINK#">#TEXT#</a> <ul> ';

t7:=t7||'<li class="current"><a href="#LINK#" class="current">#TEXT#</a> <ul class="current"> ';

t8:=t8||'<li><a href="#LINK#">#TEXT#</a> <ul> ';

wwv_flow_api.create_list_template (
  p_id=>29559528870266300 + wwv_flow_api.g_id_offset,
  p_flow_id=>wwv_flow.g_flow_id,
  p_list_template_current=>t,
  p_list_template_noncurrent=> t2,
  p_list_template_name=>'Hierarchical Expanded',
  p_theme_id  => wwv_flow.g_flow_theme_id,
  p_theme_class_id => 23,
  p_list_template_before_rows=>'<ul class="hierarchical-expanded">',
  p_list_template_after_rows=>'</ul>',
  p_after_sub_list=>'</ul></li> '||chr(10)||
'',
  p_sub_list_item_current=> t3,
  p_sub_list_item_noncurrent=> t4,
  p_item_templ_curr_w_child=> t5,
  p_item_templ_noncurr_w_child=> t6,
  p_sub_templ_curr_w_child=> t7,
  p_sub_templ_noncurr_w_child=> t8,
  p_translate_this_template => 'N',
  p_list_template_comment=>'To make this work properly please put all children pages in parent node "Current List Entry" fields.');
end;
null;
 
end;
/

prompt  ...report templates
--
--application/shared_components/user_interface/templates/report/borderless
prompt  ......report template 29471224606167194
 
begin
 
declare
  c1 varchar2(32767) := null;
  c2 varchar2(32767) := null;
  c3 varchar2(32767) := null;
  c4 varchar2(32767) := null;
begin
c1:=c1||'<td headers="#COLUMN_HEADER_NAME#" #ALIGNMENT# class="data">#COLUMN_VALUE#</td>';

c2 := null;
c3 := null;
c4 := null;
wwv_flow_api.create_row_template (
  p_id=> 29471224606167194 + wwv_flow_api.g_id_offset,
  p_flow_id=> wwv_flow.g_flow_id,
  p_row_template_name=> 'Borderless',
  p_row_template1=> c1,
  p_row_template_condition1=> '',
  p_row_template2=> c2,
  p_row_template_condition2=> '',
  p_row_template3=> c3,
  p_row_template_condition3=> '',
  p_row_template4=> c4,
  p_row_template_condition4=> '',
  p_row_template_before_rows=>'<div class="ReportDiv" #REPORT_ATTRIBUTES# id="report_#REGION_STATIC_ID#">'||chr(10)||
'<table>#TOP_PAGINATION#</table>'||chr(10)||
'<table cellspacing="0" cellpadding="0" class="Borderless Report">',
  p_row_template_after_rows =>'<tr ><td class="bottom" colspan="#COLCOUNT#">'||chr(10)||
'<div class="BottomBar"> '||chr(10)||
'<div class="CVS">#EXTERNAL_LINK##CSV_LINK#</div> <table class="PaginationTable">#PAGINATION#</table>'||chr(10)||
'</div></td></tr>'||chr(10)||
'</table>'||chr(10)||
'</div>',
  p_row_template_table_attr =>'OMIT',
  p_row_template_type =>'GENERIC_COLUMNS',
  p_column_heading_template=>'<th class="ReportHeader" #ALIGNMENT# id="#COLUMN_HEADER_NAME#">#COLUMN_HEADER#</th>',
  p_row_template_display_cond1=>'NOT_CONDITIONAL',
  p_row_template_display_cond2=>'NOT_CONDITIONAL',
  p_row_template_display_cond3=>'NOT_CONDITIONAL',
  p_row_template_display_cond4=>'NOT_CONDITIONAL',
  p_next_page_template=>'<a href="#LINK#" class="pagination">#PAGINATION_NEXT# &gt;</a>',
  p_previous_page_template=>'<a href="#LINK#" class="pagination">&lt;#PAGINATION_PREVIOUS#</a>',
  p_next_set_template=>'<a href="#LINK#" class="pagination">#PAGINATION_NEXT_SET#&gt;&gt;</a>',
  p_previous_set_template=>'<a href="#LINK#" class="pagination">&lt;&lt;#PAGINATION_PREVIOUS_SET#</a>',
  p_row_style_mouse_over=>'#EEE',
  p_row_style_checked=>'#EEE',
  p_theme_id  => wwv_flow.g_flow_theme_id,
  p_theme_class_id => 1,
  p_row_template_comment=> '');
end;
null;
 
end;
/

 
begin
 
begin
wwv_flow_api.create_row_template_patch (
  p_id => 29471224606167194 + wwv_flow_api.g_id_offset,
  p_row_template_before_first =>'<tr #HIGHLIGHT_ROW#>',
  p_row_template_after_last =>'</tr>');
exception when others then null;
end;
null;
 
end;
/

--application/shared_components/user_interface/templates/report/horizontal_border
prompt  ......report template 29471532203167200
 
begin
 
declare
  c1 varchar2(32767) := null;
  c2 varchar2(32767) := null;
  c3 varchar2(32767) := null;
  c4 varchar2(32767) := null;
begin
c1:=c1||'<td headers="#COLUMN_HEADER_NAME#" #ALIGNMENT# class="data">#COLUMN_VALUE#</td>';

c2 := null;
c3 := null;
c4 := null;
wwv_flow_api.create_row_template (
  p_id=> 29471532203167200 + wwv_flow_api.g_id_offset,
  p_flow_id=> wwv_flow.g_flow_id,
  p_row_template_name=> 'Horizontal Border',
  p_row_template1=> c1,
  p_row_template_condition1=> '',
  p_row_template2=> c2,
  p_row_template_condition2=> '',
  p_row_template3=> c3,
  p_row_template_condition3=> '',
  p_row_template4=> c4,
  p_row_template_condition4=> '',
  p_row_template_before_rows=>'<div class="ReportDiv" #REPORT_ATTRIBUTES# id="report_#REGION_STATIC_ID#">'||chr(10)||
'<table>#TOP_PAGINATION#</table>'||chr(10)||
'<table cellspacing="0" cellpadding="0" class="HorizontalBorder Report">',
  p_row_template_after_rows =>'<tr><td class="bottom" colspan="#COLCOUNT#">'||chr(10)||
'<div class="BottomBar"> '||chr(10)||
'<div class="CVS">#EXTERNAL_LINK##CSV_LINK#</div> <table class="PaginationTable">#PAGINATION#</table>'||chr(10)||
'</div></td></tr>'||chr(10)||
'</table>'||chr(10)||
'</div>',
  p_row_template_table_attr =>'OMIT',
  p_row_template_type =>'GENERIC_COLUMNS',
  p_column_heading_template=>'<th class="ReportHeader" #ALIGNMENT# id="#COLUMN_HEADER_NAME#">#COLUMN_HEADER#</th>',
  p_row_template_display_cond1=>'NOT_CONDITIONAL',
  p_row_template_display_cond2=>'NOT_CONDITIONAL',
  p_row_template_display_cond3=>'NOT_CONDITIONAL',
  p_row_template_display_cond4=>'NOT_CONDITIONAL',
  p_next_page_template=>'<a href="#LINK#" class="pagination">#PAGINATION_NEXT# &gt;</a>',
  p_previous_page_template=>'<a href="#LINK#" class="pagination">&lt;#PAGINATION_PREVIOUS#</a>',
  p_next_set_template=>'<a href="#LINK#" class="pagination">#PAGINATION_NEXT_SET#&gt;&gt;</a>',
  p_previous_set_template=>'<a href="#LINK#" class="pagination">&lt;&lt;#PAGINATION_PREVIOUS_SET#</a>',
  p_row_style_mouse_over=>'#EEE',
  p_row_style_checked=>'#EEE',
  p_theme_id  => wwv_flow.g_flow_theme_id,
  p_theme_class_id => 2,
  p_row_template_comment=> '');
end;
null;
 
end;
/

 
begin
 
begin
wwv_flow_api.create_row_template_patch (
  p_id => 29471532203167200 + wwv_flow_api.g_id_offset,
  p_row_template_before_first =>'<tr #HIGHLIGHT_ROW#>',
  p_row_template_after_last =>'</tr>');
exception when others then null;
end;
null;
 
end;
/

--application/shared_components/user_interface/templates/report/one_column_unordered_list
prompt  ......report template 29471816166167200
 
begin
 
declare
  c1 varchar2(32767) := null;
  c2 varchar2(32767) := null;
  c3 varchar2(32767) := null;
  c4 varchar2(32767) := null;
begin
c1:=c1||'#COLUMN_VALUE#';

c2 := null;
c3 := null;
c4 := null;
wwv_flow_api.create_row_template (
  p_id=> 29471816166167200 + wwv_flow_api.g_id_offset,
  p_flow_id=> wwv_flow.g_flow_id,
  p_row_template_name=> 'One Column Unordered List',
  p_row_template1=> c1,
  p_row_template_condition1=> '',
  p_row_template2=> c2,
  p_row_template_condition2=> '',
  p_row_template3=> c3,
  p_row_template_condition3=> '',
  p_row_template4=> c4,
  p_row_template_condition4=> '',
  p_row_template_before_rows=>'<div class="ReportDiv" #REPORT_ATTRIBUTES# id="report_#REGION_STATIC_ID#">'||chr(10)||
'<table>#TOP_PAGINATION#</table>'||chr(10)||
'<ul class="OneColumnUnorderedList">',
  p_row_template_after_rows =>'</ul><div class="CVS">#EXTERNAL_LINK##CSV_LINK#</div><table>#PAGINATION#</table></div>',
  p_row_template_table_attr =>'OMIT',
  p_row_template_type =>'GENERIC_COLUMNS',
  p_column_heading_template=>'',
  p_row_template_display_cond1=>'0',
  p_row_template_display_cond2=>'0',
  p_row_template_display_cond3=>'0',
  p_row_template_display_cond4=>'0',
  p_next_page_template=>'<a href="#LINK#" class="pagination">#PAGINATION_NEXT# &gt;</a>',
  p_previous_page_template=>'<a href="#LINK#" class="pagination">&lt;#PAGINATION_PREVIOUS#</a>',
  p_next_set_template=>'<a href="#LINK#" class="pagination">#PAGINATION_NEXT_SET#&gt;&gt;</a>',
  p_previous_set_template=>'<a href="#LINK#" class="pagination">&lt;&lt;#PAGINATION_PREVIOUS_SET#</a>',
  p_theme_id  => wwv_flow.g_flow_theme_id,
  p_theme_class_id => 3,
  p_row_template_comment=> '');
end;
null;
 
end;
/

 
begin
 
begin
wwv_flow_api.create_row_template_patch (
  p_id => 29471816166167200 + wwv_flow_api.g_id_offset,
  p_row_template_before_first =>'<li>',
  p_row_template_after_last =>'</li>');
exception when others then null;
end;
null;
 
end;
/

--application/shared_components/user_interface/templates/report/standard_alternating_row_colors
prompt  ......report template 29472729853167202
 
begin
 
declare
  c1 varchar2(32767) := null;
  c2 varchar2(32767) := null;
  c3 varchar2(32767) := null;
  c4 varchar2(32767) := null;
begin
c1:=c1||'<td headers="#COLUMN_HEADER_NAME#" #ALIGNMENT# class="data">#COLUMN_VALUE#</td>';

c2:=c2||'<td headers="#COLUMN_HEADER_NAME#" #ALIGNMENT# class="dataalt">#COLUMN_VALUE#</td>';

c3 := null;
c4 := null;
wwv_flow_api.create_row_template (
  p_id=> 29472729853167202 + wwv_flow_api.g_id_offset,
  p_flow_id=> wwv_flow.g_flow_id,
  p_row_template_name=> 'Standard, Alternating Row Colors',
  p_row_template1=> c1,
  p_row_template_condition1=> '',
  p_row_template2=> c2,
  p_row_template_condition2=> '',
  p_row_template3=> c3,
  p_row_template_condition3=> '',
  p_row_template4=> c4,
  p_row_template_condition4=> '',
  p_row_template_before_rows=>'<div class="ReportDiv" #REPORT_ATTRIBUTES# id="report_#REGION_STATIC_ID#">'||chr(10)||
'<table>#TOP_PAGINATION#</table>'||chr(10)||
'<table cellspacing="0" cellpadding="0" class="StandardAlternatingRowColors Report">',
  p_row_template_after_rows =>'<tr><td class="bottom" colspan="#COLCOUNT#">'||chr(10)||
'<div class="BottomBar"> '||chr(10)||
'<div class="CVS">#EXTERNAL_LINK##CSV_LINK#</div> <table class="PaginationTable">#PAGINATION#</table>'||chr(10)||
'</div></td></tr>'||chr(10)||
'</table>'||chr(10)||
'</div>',
  p_row_template_table_attr =>'OMIT',
  p_row_template_type =>'GENERIC_COLUMNS',
  p_column_heading_template=>'<th class="ReportHeader" #ALIGNMENT# id="#COLUMN_HEADER_NAME#">#COLUMN_HEADER#</th>',
  p_row_template_display_cond1=>'ODD_ROW_NUMBERS',
  p_row_template_display_cond2=>'NOT_CONDITIONAL',
  p_row_template_display_cond3=>'NOT_CONDITIONAL',
  p_row_template_display_cond4=>'ODD_ROW_NUMBERS',
  p_next_page_template=>'<a href="#LINK#" class="pagination">#PAGINATION_NEXT# &gt;</a>',
  p_previous_page_template=>'<a href="#LINK#" class="pagination">&lt;#PAGINATION_PREVIOUS#</a>',
  p_next_set_template=>'<a href="#LINK#" class="pagination">#PAGINATION_NEXT_SET#&gt;&gt;</a>',
  p_previous_set_template=>'<a href="#LINK#" class="pagination">&lt;&lt;#PAGINATION_PREVIOUS_SET#</a>',
  p_row_style_mouse_over=>'#EEE',
  p_row_style_checked=>'#EEE',
  p_theme_id  => wwv_flow.g_flow_theme_id,
  p_theme_class_id => 5,
  p_row_template_comment=> '');
end;
null;
 
end;
/

 
begin
 
begin
wwv_flow_api.create_row_template_patch (
  p_id => 29472729853167202 + wwv_flow_api.g_id_offset,
  p_row_template_before_first =>'<tr #HIGHLIGHT_ROW#>',
  p_row_template_after_last =>'</tr>');
exception when others then null;
end;
null;
 
end;
/

--application/shared_components/user_interface/templates/report/value_attribute_pairs
prompt  ......report template 29473321203167205
 
begin
 
declare
  c1 varchar2(32767) := null;
  c2 varchar2(32767) := null;
  c3 varchar2(32767) := null;
  c4 varchar2(32767) := null;
begin
c1:=c1||'<tr #HIGHLIGHT_ROW#>'||chr(10)||
'<td class="ReportHeader">#COLUMN_HEADER#</td>'||chr(10)||
'<td class="data">#COLUMN_VALUE#</td>'||chr(10)||
'</tr>';

c2 := null;
c3 := null;
c4 := null;
wwv_flow_api.create_row_template (
  p_id=> 29473321203167205 + wwv_flow_api.g_id_offset,
  p_flow_id=> wwv_flow.g_flow_id,
  p_row_template_name=> 'Value Attribute Pairs',
  p_row_template1=> c1,
  p_row_template_condition1=> '',
  p_row_template2=> c2,
  p_row_template_condition2=> '',
  p_row_template3=> c3,
  p_row_template_condition3=> '',
  p_row_template4=> c4,
  p_row_template_condition4=> '',
  p_row_template_before_rows=>'<div class="ReportDiv" #REPORT_ATTRIBUTES# id="report_#REGION_STATIC_ID#">'||chr(10)||
'<table>#TOP_PAGINATION#</table>'||chr(10)||
'<table cellspacing="0" cellpadding="0" class="ValueAttributePairs Report">',
  p_row_template_after_rows =>'<tr> <td class="bottom" colspan="2"><div class="CVS">#EXTERNAL_LINK##CSV_LINK#</div>'||chr(10)||
'<table>#PAGINATION#</table></td></tr>'||chr(10)||
'</table>'||chr(10)||
'</div>',
  p_row_template_table_attr =>'OMIT',
  p_row_template_type =>'GENERIC_COLUMNS',
  p_column_heading_template=>'',
  p_row_template_display_cond1=>'0',
  p_row_template_display_cond2=>'0',
  p_row_template_display_cond3=>'0',
  p_row_template_display_cond4=>'0',
  p_next_page_template=>'<a href="#LINK#" class="pagination">#PAGINATION_NEXT# &gt;</a>',
  p_previous_page_template=>'<a href="#LINK#" class="pagination">&lt;#PAGINATION_PREVIOUS#</a>',
  p_next_set_template=>'<a href="#LINK#" class="pagination">#PAGINATION_NEXT_SET#&gt;&gt;</a>',
  p_previous_set_template=>'<a href="#LINK#" class="pagination">&lt;&lt;#PAGINATION_PREVIOUS_SET#</a>',
  p_row_style_mouse_over=>'#EEE',
  p_row_style_checked=>'#EEE',
  p_theme_id  => wwv_flow.g_flow_theme_id,
  p_theme_class_id => 6,
  p_row_template_comment=> '');
end;
null;
 
end;
/

 
begin
 
begin
wwv_flow_api.create_row_template_patch (
  p_id => 29473321203167205 + wwv_flow_api.g_id_offset,
  p_row_template_before_first =>'',
  p_row_template_after_last =>'<tr><td class="seperate"></td><td class="seperate"></td></tr>');
exception when others then null;
end;
null;
 
end;
/

--application/shared_components/user_interface/templates/report/standard
prompt  ......report template 29516933451304466
 
begin
 
declare
  c1 varchar2(32767) := null;
  c2 varchar2(32767) := null;
  c3 varchar2(32767) := null;
  c4 varchar2(32767) := null;
begin
c1:=c1||'<td headers="#COLUMN_HEADER_NAME#" #ALIGNMENT# class="data">#COLUMN_VALUE#</td>';

c2:=c2||'<td headers="#COLUMN_HEADER_NAME#" #ALIGNMENT# class="dataalt">#COLUMN_VALUE#</td>';

c3 := null;
c4 := null;
wwv_flow_api.create_row_template (
  p_id=> 29516933451304466 + wwv_flow_api.g_id_offset,
  p_flow_id=> wwv_flow.g_flow_id,
  p_row_template_name=> 'Standard',
  p_row_template1=> c1,
  p_row_template_condition1=> '',
  p_row_template2=> c2,
  p_row_template_condition2=> '',
  p_row_template3=> c3,
  p_row_template_condition3=> '',
  p_row_template4=> c4,
  p_row_template_condition4=> '',
  p_row_template_before_rows=>'<div class="ReportDiv" #REPORT_ATTRIBUTES# id="report_#REGION_STATIC_ID#">'||chr(10)||
'<table>#TOP_PAGINATION#</table>'||chr(10)||
'<table class="Report">',
  p_row_template_after_rows =>'<tr><td class="bottom" colspan="#COLCOUNT#">'||chr(10)||
'<div class="BottomBar"> '||chr(10)||
'<div class="CVS">#EXTERNAL_LINK##CSV_LINK#</div> <table class="PaginationTable">#PAGINATION#</table>'||chr(10)||
'</div></td></tr>'||chr(10)||
'</table>'||chr(10)||
'</div>',
  p_row_template_table_attr =>'OMIT',
  p_row_template_type =>'GENERIC_COLUMNS',
  p_column_heading_template=>'<th class="ReportHeader" #ALIGNMENT# id="#COLUMN_HEADER_NAME#">#COLUMN_HEADER#</th>',
  p_row_template_display_cond1=>'ODD_ROW_NUMBERS',
  p_row_template_display_cond2=>'NOT_CONDITIONAL',
  p_row_template_display_cond3=>'NOT_CONDITIONAL',
  p_row_template_display_cond4=>'ODD_ROW_NUMBERS',
  p_next_page_template=>'<a href="#LINK#" class="pagination">#PAGINATION_NEXT# &gt;</a>',
  p_previous_page_template=>'<a href="#LINK#" class="pagination">&lt;#PAGINATION_PREVIOUS#</a>',
  p_next_set_template=>'<a href="#LINK#" class="pagination">#PAGINATION_NEXT_SET#&gt;&gt;</a>',
  p_previous_set_template=>'<a href="#LINK#" class="pagination">&lt;&lt;#PAGINATION_PREVIOUS_SET#</a>',
  p_row_style_mouse_over=>'#EEE',
  p_row_style_checked=>'#EEE',
  p_theme_id  => wwv_flow.g_flow_theme_id,
  p_theme_class_id => 4,
  p_row_template_comment=> '');
end;
null;
 
end;
/

 
begin
 
begin
wwv_flow_api.create_row_template_patch (
  p_id => 29516933451304466 + wwv_flow_api.g_id_offset,
  p_row_template_before_first =>'<tr #HIGHLIGHT_ROW#>',
  p_row_template_after_last =>'</tr>');
exception when others then null;
end;
null;
 
end;
/

prompt  ...label templates
--
--application/shared_components/user_interface/templates/label/no_label
prompt  ......label template 29478438629167222
 
begin
 
begin
wwv_flow_api.create_field_template (
  p_id=> 29478438629167222 + wwv_flow_api.g_id_offset,
  p_flow_id=> wwv_flow.g_flow_id,
  p_template_name=>'No Label',
  p_template_body1=>'<span class="nolabel">',
  p_template_body2=>'</span>',
  p_on_error_before_label=>'<div class="InlineError">',
  p_on_error_after_label=>'<br/>#ERROR_MESSAGE#</div>',
  p_theme_id  => wwv_flow.g_flow_theme_id,
  p_theme_class_id => 13,
  p_translate_this_template=> 'N',
  p_template_comment=> '');
end;
null;
 
end;
/

--application/shared_components/user_interface/templates/label/optional_label
prompt  ......label template 29478526292167224
 
begin
 
begin
wwv_flow_api.create_field_template (
  p_id=> 29478526292167224 + wwv_flow_api.g_id_offset,
  p_flow_id=> wwv_flow.g_flow_id,
  p_template_name=>'Optional Label',
  p_template_body1=>'<label for="#CURRENT_ITEM_NAME#" tabindex="999"><span class="label optionallabel ">',
  p_template_body2=>'</span></label>',
  p_on_error_before_label=>'<div class="inlineerror">',
  p_on_error_after_label=>'<br/>#ERROR_MESSAGE#</div>',
  p_theme_id  => wwv_flow.g_flow_theme_id,
  p_theme_class_id => 3,
  p_translate_this_template=> 'N',
  p_template_comment=> '');
end;
null;
 
end;
/

--application/shared_components/user_interface/templates/label/optional_label_with_help
prompt  ......label template 29478639800167225
 
begin
 
begin
wwv_flow_api.create_field_template (
  p_id=> 29478639800167225 + wwv_flow_api.g_id_offset,
  p_flow_id=> wwv_flow.g_flow_id,
  p_template_name=>'Optional Label with Help',
  p_template_body1=>'<label for="#CURRENT_ITEM_NAME#" tabindex="999">'||chr(10)||
'<a class="label optionallabelwhelp" href="javascript:popupFieldHelp(''#CURRENT_ITEM_ID#'',''&SESSION.'')" tabindex="999">',
  p_template_body2=>'</a></label>',
  p_on_error_before_label=>'<div class="inlineerror">',
  p_on_error_after_label=>'<br/>#ERROR_MESSAGE#</div>',
  p_theme_id  => wwv_flow.g_flow_theme_id,
  p_theme_class_id => 1,
  p_translate_this_template=> 'N',
  p_template_comment=> '');
end;
null;
 
end;
/

--application/shared_components/user_interface/templates/label/required_label
prompt  ......label template 29478718810167225
 
begin
 
begin
wwv_flow_api.create_field_template (
  p_id=> 29478718810167225 + wwv_flow_api.g_id_offset,
  p_flow_id=> wwv_flow.g_flow_id,
  p_template_name=>'Required Label',
  p_template_body1=>'<label for="#CURRENT_ITEM_NAME#" tabindex="999"><span class="label requiredlabel">',
  p_template_body2=>'</span></label>',
  p_on_error_before_label=>'<div class="inlineerror">',
  p_on_error_after_label=>'<br/>#ERROR_MESSAGE#</div>',
  p_theme_id  => wwv_flow.g_flow_theme_id,
  p_theme_class_id => 4,
  p_translate_this_template=> 'N',
  p_template_comment=> '');
end;
null;
 
end;
/

--application/shared_components/user_interface/templates/label/required_label_with_help
prompt  ......label template 29478823543167225
 
begin
 
begin
wwv_flow_api.create_field_template (
  p_id=> 29478823543167225 + wwv_flow_api.g_id_offset,
  p_flow_id=> wwv_flow.g_flow_id,
  p_template_name=>'Required Label with Help',
  p_template_body1=>'<label for="#CURRENT_ITEM_NAME#" tabindex="999">'||chr(10)||
'<a class="label requiredlabelwhelp" href="javascript:popupFieldHelp(''#CURRENT_ITEM_ID#'',''&SESSION.'')" tabindex="999">',
  p_template_body2=>'</a></label>',
  p_on_error_before_label=>'<div class="inlineerror">',
  p_on_error_after_label=>'<br/>#ERROR_MESSAGE#</div>',
  p_theme_id  => wwv_flow.g_flow_theme_id,
  p_theme_class_id => 2,
  p_translate_this_template=> 'N',
  p_template_comment=> '');
end;
null;
 
end;
/

prompt  ...breadcrumb templates
--
--application/shared_components/user_interface/templates/breadcrumb/breadcrumb_menu
prompt  ......template 29479744342167227
 
begin
 
begin
wwv_flow_api.create_menu_template (
  p_id=> 29479744342167227 + wwv_flow_api.g_id_offset,
  p_flow_id=> wwv_flow.g_flow_id,
  p_name=>'Breadcrumb Menu',
  p_before_first=>'',
  p_current_page_option=>'<a href="#LINK#" class="breadcrumb current">#NAME#</a>',
  p_non_current_page_option=>'<a href="#LINK#" class="breadcrumb">#NAME#</a>',
  p_menu_link_attributes=>'',
  p_between_levels=>'',
  p_after_last=>'',
  p_max_levels=>12,
  p_start_with_node=>'PARENT_TO_LEAF',
  p_theme_id  => wwv_flow.g_flow_theme_id,
  p_theme_class_id => 1,
  p_translate_this_template => 'N',
  p_template_comments=>'');
end;
null;
 
end;
/

--application/shared_components/user_interface/templates/popuplov
prompt  ...popup list of values templates
--
prompt  ......template 29480228833167233
 
begin
 
begin
wwv_flow_api.create_popup_lov_template (
  p_id=> 29480228833167233 + wwv_flow_api.g_id_offset,
  p_flow_id=> wwv_flow.g_flow_id,
  p_popup_icon=>'#IMAGE_PREFIX#list_gray.gif',
  p_popup_icon_attr=>'width="13" height="13" alt="Popup Lov"',
  p_popup_icon2=>'',
  p_popup_icon_attr2=>'',
  p_page_name=>'winlov',
  p_page_title=>'Search Dialog',
  p_page_html_head=>'<link rel="stylesheet" href="#IMAGE_PREFIX#themes/theme_509/style.css" type="text/css">'||chr(10)||
'',
  p_page_body_attr=>'onload="first_field()" style="background-color:#FFFFFF;margin:0;"',
  p_before_field_text=>'<div class="PopupHead">',
  p_page_heading_text=>'',
  p_page_footer_text =>'',
  p_filter_width     =>'20',
  p_filter_max_width =>'100',
  p_filter_text_attr =>'',
  p_find_button_text =>'Search',
  p_find_button_image=>'',
  p_find_button_attr =>'',
  p_close_button_text=>'Close',
  p_close_button_image=>'',
  p_close_button_attr=>'',
  p_next_button_text =>'Next >',
  p_next_button_image=>'',
  p_next_button_attr =>'',
  p_prev_button_text =>'< Previous',
  p_prev_button_image=>'',
  p_prev_button_attr =>'',
  p_after_field_text=>'</div>',
  p_scrollbars=>'1',
  p_resizable=>'1',
  p_width =>'400',
  p_height=>'450',
  p_result_row_x_of_y=>'<br /><div style="padding:2px; font-size:8pt;">Row(s) #FIRST_ROW# - #LAST_ROW#</div>',
  p_result_rows_per_pg=>500,
  p_before_result_set=>'<div class="PopupBody">',
  p_theme_id  => wwv_flow.g_flow_theme_id,
  p_theme_class_id => 1,
  p_translate_this_template => 'N',
  p_after_result_set   =>'</div>');
end;
null;
 
end;
/

prompt  ...calendar templates
--
--application/shared_components/user_interface/templates/calendar/calendar
prompt  ......template 29479926501167228
 
begin
 
begin
wwv_flow_api.create_calendar_template(
  p_id=> 29479926501167228 + wwv_flow_api.g_id_offset,
  p_flow_id=> wwv_flow.g_flow_id,
  p_cal_template_name=>'Calendar',
  p_translate_this_template=> 'Y',
  p_day_of_week_format=> '<th class="DayOfWeek">#IDAY#</th>',
  p_month_title_format=> '<table cellspacing="0" cellpadding="0" summary="" class="MonthCalendarHolder"> '||chr(10)||
' <tr>'||chr(10)||
'   <td class="MonthTitle">#IMONTH# #YYYY#</td>'||chr(10)||
' </tr>'||chr(10)||
' <tr>'||chr(10)||
' <td class="MonthBody">',
  p_month_open_format=> '<table border="0" cellpadding="0" cellspacing="0" summary="0" class="Calendar">',
  p_month_close_format=> '</table></td>'||chr(10)||
'</tr>'||chr(10)||
'</table>'||chr(10)||
'',
  p_day_title_format=> '<div class="DayTitle">#DD#</div>',
  p_day_open_format=> '<td class="Day" valign="top">',
  p_day_close_format=> '</td>',
  p_today_open_format=> '<td valign="top" class="Today">',
  p_weekend_title_format=> '<div class="WeekendDayTitle">#DD#</div>',
  p_weekend_open_format => '<td valign="top" class="WeekendDay">',
  p_weekend_close_format => '</td>',
  p_nonday_title_format => '<div class="NonDayTitle">#DD#</div>',
  p_nonday_open_format => '<td class="NonDay" valign="top">',
  p_nonday_close_format => '</td>',
  p_week_title_format => '',
  p_week_open_format => '<tr>',
  p_week_close_format => '</tr> ',
  p_daily_title_format => '<th width="14%" class="calheader">#IDAY#</th>',
  p_daily_open_format => '<tr>',
  p_daily_close_format => '</tr>',
  p_weekly_title_format => '<table cellspacing="0" cellpadding="0" border="0" summary="" class="WeekCalendarHolder">'||chr(10)||
'<tr>'||chr(10)||
'<td class="MonthTitle" id="test">#WTITLE#</td>'||chr(10)||
'</tr>'||chr(10)||
'<tr>'||chr(10)||
'<td class="WeekBody">',
  p_weekly_day_of_week_format => '<th class="DayOfWeek">#IDAY#<br>#MM#/#DD#</th>',
  p_weekly_month_open_format => '<table border="0" cellpadding="0" cellspacing="0" summary="0" class="WeekCalendar">',
  p_weekly_month_close_format => '</table></td></tr></table>',
  p_weekly_day_title_format => '',
  p_weekly_day_open_format => '<td class="Day" valign="top">',
  p_weekly_day_close_format => '<br /></td>',
  p_weekly_today_open_format => '<td class="Today" valign="top">',
  p_weekly_weekend_title_format => '',
  p_weekly_weekend_open_format => '<td valign="top" class="WeekendDay">',
  p_weekly_weekend_close_format => '<br /></td>',
  p_weekly_time_open_format => '<th class="Hour">',
  p_weekly_time_close_format => '<br /></th>',
  p_weekly_time_title_format => '#TIME#',
  p_weekly_hour_open_format => '<tr>',
  p_weekly_hour_close_format => '</tr>',
  p_daily_day_of_week_format => '<th class="DayOfWeek">#IDAY# #DD#/#MM#</th>',
  p_daily_month_title_format => '<table cellspacing="0" cellpadding="0" border="0" summary="" class="DayCalendarHolder"> <tr> <td class="MonthTitle">#IMONTH# #DD#, #YYYY#</td> </tr> <tr> <td class="DayBody">'||chr(10)||
'',
  p_daily_month_open_format => '<table border="0" cellpadding="2" cellspacing="0" summary="0" class="DayCalendar">',
  p_daily_month_close_format => '</table></td> </tr> </table>',
  p_daily_day_title_format => '',
  p_daily_day_open_format => '<td valign="top" class="Day">',
  p_daily_day_close_format => '<br /></td>',
  p_daily_today_open_format => '<td valign="top" class="Today">',
  p_daily_time_open_format => '<th class="Hour">',
  p_daily_time_close_format => '<br /></th>',
  p_daily_time_title_format => '#TIME#',
  p_daily_hour_open_format => '<tr>',
  p_daily_hour_close_format => '</tr>',
  p_cust_month_title_format => '',
  p_cust_day_of_week_format => '',
  p_cust_month_open_format => '',
  p_cust_month_close_format => '',
  p_cust_week_title_format => '',
  p_cust_week_open_format => '',
  p_cust_week_close_format => '',
  p_cust_day_title_format => '',
  p_cust_day_open_format => '',
  p_cust_day_close_format => '',
  p_cust_today_open_format => '',
  p_cust_daily_title_format => '',
  p_cust_daily_open_format => '',
  p_cust_daily_close_format => '',
  p_cust_nonday_title_format => '',
  p_cust_nonday_open_format => '',
  p_cust_nonday_close_format => '',
  p_cust_weekend_title_format => '',
  p_cust_weekend_open_format => '',
  p_cust_weekend_close_format => '',
  p_cust_hour_open_format => '',
  p_cust_hour_close_format => '',
  p_cust_time_title_format => '',
  p_cust_time_open_format => '',
  p_cust_time_close_format => '',
  p_cust_wk_month_title_format => '',
  p_cust_wk_day_of_week_format => '',
  p_cust_wk_month_open_format => '',
  p_cust_wk_month_close_format => '',
  p_cust_wk_week_title_format => '',
  p_cust_wk_week_open_format => '',
  p_cust_wk_week_close_format => '',
  p_cust_wk_day_title_format => '',
  p_cust_wk_day_open_format => '',
  p_cust_wk_day_close_format => '',
  p_cust_wk_today_open_format => '',
  p_cust_wk_weekend_title_format => '',
  p_cust_wk_weekend_open_format => '',
  p_cust_wk_weekend_close_format => '',
  p_cust_month_day_height_pix => '',
  p_cust_month_day_height_per => '',
  p_cust_week_day_width_pix => '',
  p_cust_week_day_width_per => '',
  p_theme_id  => wwv_flow.g_flow_theme_id,
  p_theme_class_id => 1,
  p_reference_id=> null);
end;
null;
 
end;
/

--application/shared_components/user_interface/templates/calendar/calendar_alternative_1
prompt  ......template 29480015827167231
 
begin
 
begin
wwv_flow_api.create_calendar_template(
  p_id=> 29480015827167231 + wwv_flow_api.g_id_offset,
  p_flow_id=> wwv_flow.g_flow_id,
  p_cal_template_name=>'Calendar, Alternative 1',
  p_translate_this_template=> 'Y',
  p_day_of_week_format=> '<th class="DayOfWeek">#IDAY#</th>',
  p_month_title_format=> '<table cellspacing="0" cellpadding="0" border="0" summary="" class="CalendarAlternativeHolder"> '||chr(10)||
' <tr>'||chr(10)||
'   <td class="MonthTitle">#IMONTH# #YYYY#</td>'||chr(10)||
' </tr>'||chr(10)||
' <tr>'||chr(10)||
' <td class="t502MonthBody">',
  p_month_open_format=> '<table border="0" cellpadding="0" cellspacing="0" summary="0" class="CalendarAlternative">',
  p_month_close_format=> '</table></td>'||chr(10)||
'</tr>'||chr(10)||
'</table>'||chr(10)||
'',
  p_day_title_format=> '<div class="DayTitle">#DD#</div>',
  p_day_open_format=> '<td class="Day" valign="top">',
  p_day_close_format=> '</td>',
  p_today_open_format=> '<td valign="top" class="Today">',
  p_weekend_title_format=> '<div class="WeekendDayTitle">#DD#</div>',
  p_weekend_open_format => '<td valign="top" class="WeekendDay">',
  p_weekend_close_format => '</td>',
  p_nonday_title_format => '<div class="NonDayTitle">#DD#</div>',
  p_nonday_open_format => '<td class="NonDay" valign="top">',
  p_nonday_close_format => '</td>',
  p_week_title_format => '',
  p_week_open_format => '<tr>',
  p_week_close_format => '</tr> ',
  p_daily_title_format => '<th width="14%" class="calheader">#IDAY#</th>',
  p_daily_open_format => '<tr>',
  p_daily_close_format => '</tr>',
  p_weekly_title_format => '<table cellspacing="0" cellpadding="0" border="0" summary="" class="WeekCalendarAlternativeHolder">'||chr(10)||
'<tr>'||chr(10)||
'<td class="MonthTitle" id="test">#WTITLE#</td>'||chr(10)||
'</tr>'||chr(10)||
'<tr>'||chr(10)||
'<td>',
  p_weekly_day_of_week_format => '<th class="DayOfWeek">#IDAY#<br>#MM#/#DD#</th>',
  p_weekly_month_open_format => '<table border="0" cellpadding="0" cellspacing="0" summary="0" class="WeekCalendarAlternative">',
  p_weekly_month_close_format => '</table></td></tr></table>',
  p_weekly_day_title_format => '',
  p_weekly_day_open_format => '<td class="Day" valign="top">',
  p_weekly_day_close_format => '<br /></td>',
  p_weekly_today_open_format => '<td class="Today" valign="top">',
  p_weekly_weekend_title_format => '',
  p_weekly_weekend_open_format => '<td valign="top" class="NonDay">',
  p_weekly_weekend_close_format => '<br /></td>',
  p_weekly_time_open_format => '<th class="Hour">',
  p_weekly_time_close_format => '<br /></th>',
  p_weekly_time_title_format => '#TIME#',
  p_weekly_hour_open_format => '<tr>',
  p_weekly_hour_close_format => '</tr>',
  p_daily_day_of_week_format => '<th class="DayOfWeek">#IDAY# #DD#/#MM#</th>',
  p_daily_month_title_format => '<table cellspacing="0" cellpadding="0" border="0" summary="" class="DayCalendarAlternativeHolder"> <tr><td class="MonthTitle">#IMONTH# #DD#, #YYYY#</td></tr><tr><td>'||chr(10)||
'',
  p_daily_month_open_format => '<table border="0" cellpadding="2" cellspacing="0" summary="0" class="DayCalendarAlternative">',
  p_daily_month_close_format => '</table></td> </tr> </table>',
  p_daily_day_title_format => '',
  p_daily_day_open_format => '<td valign="top" class="Day">',
  p_daily_day_close_format => '<br /></td>',
  p_daily_today_open_format => '<td valign="top" class="Today">',
  p_daily_time_open_format => '<th class="Hour">',
  p_daily_time_close_format => '<br /></th>',
  p_daily_time_title_format => '#TIME#',
  p_daily_hour_open_format => '<tr>',
  p_daily_hour_close_format => '</tr>',
  p_cust_month_title_format => '',
  p_cust_day_of_week_format => '',
  p_cust_month_open_format => '',
  p_cust_month_close_format => '',
  p_cust_week_title_format => '',
  p_cust_week_open_format => '',
  p_cust_week_close_format => '',
  p_cust_day_title_format => '',
  p_cust_day_open_format => '',
  p_cust_day_close_format => '',
  p_cust_today_open_format => '',
  p_cust_daily_title_format => '',
  p_cust_daily_open_format => '',
  p_cust_daily_close_format => '',
  p_cust_nonday_title_format => '',
  p_cust_nonday_open_format => '',
  p_cust_nonday_close_format => '',
  p_cust_weekend_title_format => '',
  p_cust_weekend_open_format => '',
  p_cust_weekend_close_format => '',
  p_cust_hour_open_format => '',
  p_cust_hour_close_format => '',
  p_cust_time_title_format => '',
  p_cust_time_open_format => '',
  p_cust_time_close_format => '',
  p_cust_wk_month_title_format => '',
  p_cust_wk_day_of_week_format => '',
  p_cust_wk_month_open_format => '',
  p_cust_wk_month_close_format => '',
  p_cust_wk_week_title_format => '',
  p_cust_wk_week_open_format => '',
  p_cust_wk_week_close_format => '',
  p_cust_wk_day_title_format => '',
  p_cust_wk_day_open_format => '',
  p_cust_wk_day_close_format => '',
  p_cust_wk_today_open_format => '',
  p_cust_wk_weekend_title_format => '',
  p_cust_wk_weekend_open_format => '',
  p_cust_wk_weekend_close_format => '',
  p_cust_month_day_height_pix => '',
  p_cust_month_day_height_per => '',
  p_cust_week_day_width_pix => '',
  p_cust_week_day_width_per => '',
  p_theme_id  => wwv_flow.g_flow_theme_id,
  p_theme_class_id => 2,
  p_reference_id=> null);
end;
null;
 
end;
/

--application/shared_components/user_interface/templates/calendar/small_calendar
prompt  ......template 29480142209167231
 
begin
 
begin
wwv_flow_api.create_calendar_template(
  p_id=> 29480142209167231 + wwv_flow_api.g_id_offset,
  p_flow_id=> wwv_flow.g_flow_id,
  p_cal_template_name=>'Small Calendar',
  p_translate_this_template=> 'Y',
  p_day_of_week_format=> '<th class="DayOfWeek">#DY#</th>',
  p_month_title_format=> '<table cellspacing="0" cellpadding="0" border="0" summary="" class="SmallCalendarHolder"> '||chr(10)||
' <tr>'||chr(10)||
'   <td class="MonthTitle">#IMONTH# #YYYY#</td>'||chr(10)||
' </tr>'||chr(10)||
' <tr>'||chr(10)||
' <td class="MonthBody">',
  p_month_open_format=> '<table border="0" cellpadding="0" cellspacing="0" summary="0" class="SmallCalendar">',
  p_month_close_format=> '</table></td>'||chr(10)||
'</tr>'||chr(10)||
'</table>'||chr(10)||
'',
  p_day_title_format=> '#DD#',
  p_day_open_format=> '<td class="Day">',
  p_day_close_format=> '</td>',
  p_today_open_format=> '<td class="Today">',
  p_weekend_title_format=> '#DD#',
  p_weekend_open_format => '<td class="WeekendDay">',
  p_weekend_close_format => '</td>',
  p_nonday_title_format => '',
  p_nonday_open_format => '<td class="NonDay">',
  p_nonday_close_format => '</td>',
  p_week_title_format => '',
  p_week_open_format => '<tr>',
  p_week_close_format => '</tr> ',
  p_daily_title_format => '<th width="14%" class="calheader">#IDAY#</th>',
  p_daily_open_format => '<tr>',
  p_daily_close_format => '</tr>',
  p_weekly_title_format => '<table cellspacing="0" cellpadding="0" border="0" summary="" class="SmallWeekCalendarHolder">'||chr(10)||
'<tr>'||chr(10)||
'<td class="MonthTitle" id="test">#WTITLE#</td>'||chr(10)||
'</tr>'||chr(10)||
'<tr>'||chr(10)||
'<td class="WeekBody">',
  p_weekly_day_of_week_format => '<th class="DayOfWeek">#DY#<br />#DD#</th>',
  p_weekly_month_open_format => '<table border="0" cellpadding="0" cellspacing="0" summary="0" class="SmallWeekCalendar">',
  p_weekly_month_close_format => '</table></td></tr></table>',
  p_weekly_day_title_format => '',
  p_weekly_day_open_format => '<td class="Day" valign="top">',
  p_weekly_day_close_format => '<br /></td>',
  p_weekly_today_open_format => '<td class="Today" valign="top">',
  p_weekly_weekend_title_format => '',
  p_weekly_weekend_open_format => '<td valign="top" class="WeekendDay">',
  p_weekly_weekend_close_format => '<br /></td>',
  p_weekly_time_open_format => '<td class="Hour">',
  p_weekly_time_close_format => '<br /></td>',
  p_weekly_time_title_format => '#TIME#',
  p_weekly_hour_open_format => '<tr>',
  p_weekly_hour_close_format => '</tr>',
  p_daily_day_of_week_format => '<th class="DayOfWeek">#IDAY#</th>',
  p_daily_month_title_format => '<table cellspacing="0" cellpadding="0" border="0" summary="" class="SmallDayCalendarHolder"> <tr> <td class="MonthTitle">#IMONTH# #DD#, #YYYY#</td> </tr><tr><td class="DayBody">'||chr(10)||
'',
  p_daily_month_open_format => '<table border="0" cellpadding="2" cellspacing="0" summary="0" class="SmallDayCalendar">',
  p_daily_month_close_format => '</table></td></tr></table>',
  p_daily_day_title_format => '',
  p_daily_day_open_format => '<td valign="top" class="Day">',
  p_daily_day_close_format => '<br /></td>',
  p_daily_today_open_format => '<td valign="top" class="Today">',
  p_daily_time_open_format => '<td class="Hour">',
  p_daily_time_close_format => '<br /></td>',
  p_daily_time_title_format => '#TIME#',
  p_daily_hour_open_format => '<tr>',
  p_daily_hour_close_format => '</tr>',
  p_cust_month_title_format => '',
  p_cust_day_of_week_format => '',
  p_cust_month_open_format => '',
  p_cust_month_close_format => '',
  p_cust_week_title_format => '',
  p_cust_week_open_format => '',
  p_cust_week_close_format => '',
  p_cust_day_title_format => '',
  p_cust_day_open_format => '',
  p_cust_day_close_format => '',
  p_cust_today_open_format => '',
  p_cust_daily_title_format => '',
  p_cust_daily_open_format => '',
  p_cust_daily_close_format => '',
  p_cust_nonday_title_format => '',
  p_cust_nonday_open_format => '',
  p_cust_nonday_close_format => '',
  p_cust_weekend_title_format => '',
  p_cust_weekend_open_format => '',
  p_cust_weekend_close_format => '',
  p_cust_hour_open_format => '',
  p_cust_hour_close_format => '',
  p_cust_time_title_format => '',
  p_cust_time_open_format => '',
  p_cust_time_close_format => '',
  p_cust_wk_month_title_format => '',
  p_cust_wk_day_of_week_format => '',
  p_cust_wk_month_open_format => '',
  p_cust_wk_month_close_format => '',
  p_cust_wk_week_title_format => '',
  p_cust_wk_week_open_format => '',
  p_cust_wk_week_close_format => '',
  p_cust_wk_day_title_format => '',
  p_cust_wk_day_open_format => '',
  p_cust_wk_day_close_format => '',
  p_cust_wk_today_open_format => '',
  p_cust_wk_weekend_title_format => '',
  p_cust_wk_weekend_open_format => '',
  p_cust_wk_weekend_close_format => '',
  p_cust_month_day_height_pix => '',
  p_cust_month_day_height_per => '',
  p_cust_week_day_width_pix => '',
  p_cust_week_day_width_per => '',
  p_theme_id  => wwv_flow.g_flow_theme_id,
  p_theme_class_id => 3,
  p_reference_id=> null);
end;
null;
 
end;
/

prompt  ...application themes
--
--application/shared_components/user_interface/themes/summertheme_apex_designers_com
prompt  ......theme 29480427030167238
begin
wwv_flow_api.create_theme (
  p_id =>29480427030167238 + wwv_flow_api.g_id_offset,
  p_flow_id =>wwv_flow.g_flow_id,
  p_theme_id  => wwv_flow.g_flow_theme_id,
  p_theme_name=>'SummerTheme APEX-Designers.com',
  p_default_page_template=>29462530921167181 + wwv_flow_api.g_id_offset,
  p_error_template=>null + wwv_flow_api.g_id_offset,
  p_printer_friendly_template=>null + wwv_flow_api.g_id_offset,
  p_breadcrumb_display_point=>'REGION_POSITION_01',
  p_sidebar_display_point=>'REGION_POSITION_02',
  p_login_template=>29461731285167174 + wwv_flow_api.g_id_offset,
  p_default_button_template=>29478940667167225 + wwv_flow_api.g_id_offset,
  p_default_region_template=>29468534142167192 + wwv_flow_api.g_id_offset,
  p_default_chart_template =>null + wwv_flow_api.g_id_offset,
  p_default_form_template  =>29466419307167192 + wwv_flow_api.g_id_offset,
  p_default_reportr_template   =>29468534142167192 + wwv_flow_api.g_id_offset,
  p_default_tabform_template=>29468534142167192 + wwv_flow_api.g_id_offset,
  p_default_wizard_template=>null + wwv_flow_api.g_id_offset,
  p_default_menur_template=>29464946652167191 + wwv_flow_api.g_id_offset,
  p_default_listr_template=>29468534142167192 + wwv_flow_api.g_id_offset,
  p_default_irr_template=>null + wwv_flow_api.g_id_offset,
  p_default_report_template   =>29516933451304466 + wwv_flow_api.g_id_offset,
  p_default_label_template=>29478639800167225 + wwv_flow_api.g_id_offset,
  p_default_menu_template=>29479744342167227 + wwv_flow_api.g_id_offset,
  p_default_calendar_template=>29479926501167228 + wwv_flow_api.g_id_offset,
  p_default_list_template=>29477825368167219 + wwv_flow_api.g_id_offset,
  p_default_option_label=>29478639800167225 + wwv_flow_api.g_id_offset,
  p_theme_description=>'This is free theme from APEX-Designers.com'||chr(10)||
'Enjoy !'||chr(10)||
'For any assistance or bug report please go to APEX-Designers.com',
  p_default_required_label=>29478823543167225 + wwv_flow_api.g_id_offset);
end;
/
 
begin
wwv_flow_api.g_varchar2_table := wwv_flow_api.empty_varchar2_table;
wwv_flow_api.g_varchar2_table(1) := '89504E470D0A1A0A0000000D4948445200000096000000500806000000FBB08C4B000000097048597300000B1300000B1301009A9C1800000A4F6943435050686F746F73686F70204943432070726F66696C65000078DA9D53675453E9163DF7DEF4424B';
wwv_flow_api.g_varchar2_table(2) := '8880944B6F5215082052428B801491262A2109104A8821A1D91551C1114545041BC8A088038E8E808C15512C0C8A0AD807E421A28E83A3888ACAFBE17BA36BD6BCF7E6CDFEB5D73EE7ACF39DB3CF07C0080C9648335135800CA9421E11E083C7C4C6E1E4';
wwv_flow_api.g_varchar2_table(3) := '2E40810A2470001008B3642173FD230100F87E3C3C2B22C007BE000178D30B0800C04D9BC0301C87FF0FEA42995C01808401C07491384B08801400407A8E42A600404601809D98265300A0040060CB6362E300502D0060277FE6D300809DF8997B01005B';
wwv_flow_api.g_varchar2_table(4) := '94211501A09100201365884400683B00ACCF568A450058300014664BC43900D82D00304957664800B0B700C0CE100BB200080C00305188852900047B0060C8232378008499001446F2573CF12BAE10E72A00007899B23CB9243945815B082D710757572E';
wwv_flow_api.g_varchar2_table(5) := '1E28CE49172B14366102619A402EC27999193281340FE0F3CC0000A0911511E083F3FD78CE0EAECECE368EB60E5F2DEABF06FF226262E3FEE5CFAB70400000E1747ED1FE2C2FB31A803B06806DFEA225EE04685E0BA075F78B66B20F40B500A0E9DA57F3';
wwv_flow_api.g_varchar2_table(6) := '70F87E3C3C45A190B9D9D9E5E4E4D84AC4425B61CA577DFE67C25FC057FD6CF97E3CFCF7F5E0BEE22481325D814704F8E0C2CCF44CA51CCF92098462DCE68F47FCB70BFFFC1DD322C44962B9582A14E35112718E449A8CF332A52289429229C525D2FF64';
wwv_flow_api.g_varchar2_table(7) := 'E2DF2CFB033EDF3500B06A3E017B912DA85D6303F64B27105874C0E2F70000F2BB6FC1D4280803806883E1CF77FFEF3FFD47A02500806649927100005E44242E54CAB33FC708000044A0812AB0411BF4C1182CC0061CC105DCC10BFC6036844224C4C242';
wwv_flow_api.g_varchar2_table(8) := '10420A64801C726029AC82422886CDB01D2A602FD4401D34C051688693700E2EC255B80E3D700FFA61089EC128BC81090441C808136121DA8801628A58238E08179985F821C14804128B2420C9881451224B91354831528A542055481DF23D720239875C';
wwv_flow_api.g_varchar2_table(9) := '46BA913BC8003282FC86BC47319481B2513DD40CB543B9A8371A8446A20BD06474319A8F16A09BD072B41A3D8C36A1E7D0AB680FDA8F3E43C730C0E8180733C46C302EC6C342B1382C099363CBB122AC0CABC61AB056AC03BB89F563CFB17704128145C0';
wwv_flow_api.g_varchar2_table(10) := '093604774220611E4148584C584ED848A8201C243411DA093709038451C2272293A84BB426BA11F9C4186232318758482C23D6128F132F107B8843C437241289433227B9900249B1A454D212D246D26E5223E92CA99B34481A2393C9DA646BB20739942C';
wwv_flow_api.g_varchar2_table(11) := '202BC885E49DE4C3E433E41BE421F25B0A9D624071A4F853E22852CA6A4A19E510E534E5066598324155A39A52DDA8A15411358F5A42ADA1B652AF5187A81334759A39CD8316494BA5ADA295D31A681768F769AFE874BA11DD951E4E97D057D2CBE947E8';
wwv_flow_api.g_varchar2_table(12) := '97E803F4770C0D861583C7886728199B18071867197718AF984CA619D38B19C754303731EB98E7990F996F55582AB62A7C1591CA0A954A9526951B2A2F54A9AAA6AADEAA0B55F355CB548FA95E537DAE46553353E3A909D496AB55AA9D50EB531B5367A9';
wwv_flow_api.g_varchar2_table(13) := '3BA887AA67A86F543FA47E59FD890659C34CC34F43A451A0B15FE3BCC6200B6319B3782C216B0DAB86758135C426B1CDD97C762ABB98FD1DBB8B3DAAA9A13943334A3357B352F394663F07E39871F89C744E09E728A797F37E8ADE14EF29E2291BA6344C';
wwv_flow_api.g_varchar2_table(14) := 'B931655C6BAA96979658AB48AB51AB47EBBD36AEEDA79DA6BD45BB59FB810E41C74A275C2747678FCE059DE753D953DDA70AA7164D3D3AF5AE2EAA6BA51BA1BB4477BF6EA7EE989EBE5E809E4C6FA7DE79BDE7FA1C7D2FFD54FD6DFAA7F5470C5806B30C';
wwv_flow_api.g_varchar2_table(15) := '2406DB0CCE183CC535716F3C1D2FC7DBF151435DC34043A561956197E18491B9D13CA3D5468D460F8C69C65CE324E36DC66DC6A326062621264B4DEA4DEE9A524DB9A629A63B4C3B4CC7CDCCCDA2CDD699359B3D31D732E79BE79BD79BDFB7605A785A2C';
wwv_flow_api.g_varchar2_table(16) := 'B6A8B6B86549B2E45AA659EEB6BC6E855A3959A558555A5DB346AD9DAD25D6BBADBBA711A7B94E934EAB9ED667C3B0F1B6C9B6A9B719B0E5D806DBAEB66DB67D6167621767B7C5AEC3EE93BD937DBA7D8DFD3D070D87D90EAB1D5A1D7E73B472143A563A';
wwv_flow_api.g_varchar2_table(17) := 'DE9ACE9CEE3F7DC5F496E92F6758CF10CFD833E3B613CB29C4699D539BD347671767B97383F3888B894B82CB2E973E2E9B1BC6DDC8BDE44A74F5715DE17AD2F59D9BB39BC2EDA8DBAFEE36EE69EE87DC9FCC349F299E593373D0C3C843E051E5D13F0B9F';
wwv_flow_api.g_varchar2_table(18) := '95306BDFAC7E4F434F8167B5E7232F632F9157ADD7B0B7A577AAF761EF173EF63E729FE33EE33C37DE32DE595FCC37C0B7C8B7CB4FC36F9E5F85DF437F23FF64FF7AFFD100A78025016703898141815B02FBF87A7C21BF8E3F3ADB65F6B2D9ED418CA0B9';
wwv_flow_api.g_varchar2_table(19) := '4115418F82AD82E5C1AD2168C8EC90AD21F7E798CE91CE690E85507EE8D6D00761E6618BC37E0C2785878557863F8E7088581AD131973577D1DC4373DF44FA449644DE9B67314F39AF2D4A352A3EAA2E6A3CDA37BA34BA3FC62E6659CCD5589D58496C4B';
wwv_flow_api.g_varchar2_table(20) := '1C392E2AAE366E6CBEDFFCEDF387E29DE20BE37B17982FC85D7079A1CEC2F485A716A92E122C3A96404C884E3894F041102AA8168C25F21377258E0A79C21DC267222FD136D188D8435C2A1E4EF2482A4D7A92EC91BC357924C533A52CE5B98427A990BC';
wwv_flow_api.g_varchar2_table(21) := '4C0D4CDD9B3A9E169A76206D323D3ABD31839291907142AA214D93B667EA67E66676CBAC6585B2FEC56E8BB72F1E9507C96BB390AC05592D0AB642A6E8545A28D72A07B267655766BFCD89CA3996AB9E2BCDEDCCB3CADB90379CEF9FFFED12C212E192B6';
wwv_flow_api.g_varchar2_table(22) := 'A5864B572D1D58E6BDAC6A39B23C7179DB0AE315052B865606AC3CB88AB62A6DD54FABED5797AE7EBD267A4D6B815EC1CA82C1B5016BEB0B550AE5857DEBDCD7ED5D4F582F59DFB561FA869D1B3E15898AAE14DB1797157FD828DC78E51B876FCABF99DC';
wwv_flow_api.g_varchar2_table(23) := '94B4A9ABC4B964CF66D266E9E6DE2D9E5B0E96AA97E6970E6E0DD9DAB40DDF56B4EDF5F645DB2F97CD28DBBB83B643B9A3BF3CB8BC65A7C9CECD3B3F54A454F454FA5436EED2DDB561D7F86ED1EE1B7BBCF634ECD5DB5BBCF7FD3EC9BEDB5501554DD566';
wwv_flow_api.g_varchar2_table(24) := 'D565FB49FBB3F73FAE89AAE9F896FB6D5DAD4E6D71EDC703D203FD07230EB6D7B9D4D51DD23D54528FD62BEB470EC71FBEFE9DEF772D0D360D558D9CC6E223704479E4E9F709DFF71E0D3ADA768C7BACE107D31F761D671D2F6A429AF29A469B539AFB5B';
wwv_flow_api.g_varchar2_table(25) := '625BBA4FCC3ED1D6EADE7AFC47DB1F0F9C343C59794AF354C969DAE982D39367F2CF8C9D959D7D7E2EF9DC60DBA2B67BE763CEDF6A0F6FEFBA1074E1D245FF8BE73BBC3BCE5CF2B874F2B2DBE51357B8579AAF3A5F6DEA74EA3CFE93D34FC7BB9CBB9AAE';
wwv_flow_api.g_varchar2_table(26) := 'B95C6BB9EE7ABDB57B66F7E91B9E37CEDDF4BD79F116FFD6D59E393DDDBDF37A6FF7C5F7F5DF16DD7E7227FDCECBBBD97727EEADBC4FBC5FF440ED41D943DD87D53F5BFEDCD8EFDC7F6AC077A0F3D1DC47F7068583CFFE91F58F0F43058F998FCB860D86';
wwv_flow_api.g_varchar2_table(27) := 'EB9E383E3939E23F72FDE9FCA743CF64CF269E17FEA2FECBAE17162F7EF8D5EBD7CED198D1A197F29793BF6D7CA5FDEAC0EB19AFDBC6C2C61EBEC97833315EF456FBEDC177DC771DEFA3DF0F4FE47C207F28FF68F9B1F553D0A7FB93199393FF040398F3';
wwv_flow_api.g_varchar2_table(28) := 'FC63332DDB000000206348524D00007A25000080830000F9FF000080E9000075300000EA6000003A980000176F925FC54600003C0A4944415478DAEC9D777C5CD599F7BF673423CD8C3445D2A87759D555B2B18D6D6CB04D8710EC40B21B082D0D925012';
wwv_flow_api.g_varchar2_table(29) := '92BC0964216C9694CD06120229A4006149082CD89404888B4C31E02AB9AA614BB6556DC91AF551F37DFFB833F79E736724C3EEFEB75C3EFAE099B9F7DC539EF3D4DFF31CA1691A1F5F1F5FFFDB97EDE329F8F8FA98B03EBE3E26AC8FAFFFDB975DFE30FF';
wwv_flow_api.g_varchar2_table(30) := 'AB2F5B7F2F07BE049C0F5401711F4F1908E0FFA0663A05D4016F028F038DF28FFB1FBB6A068E25C27FFAF50D04B508BE012C02E284D06F1042BE3DFC90909A11D3B429D42F85716FF879E5C1F0C7F0EFC63B85F943E43FF57BF315EA70E49F84D22761E9';
wwv_flow_api.g_varchar2_table(31) := '5BA429799CF23F3421A2BE93FB18694508A18C4308119B4A917E93C70C447F2DA44FC2FC97F44CCC3997DA8D5E2361ED4EF47B75A6B208C43710D40A9D3EA4199B8163090468C423B497804BCDD768C69B84D040331BD28416DEC1E189D5F4DF85D0F42E';
wwv_flow_api.g_varchar2_table(32) := '69668F3534F39EC83332718547A4453E699A3EE14243D3CCF61542D0E449D5D0D0EF579AB4F01A4D9317C96441426A333CB8F0389881903475068566F9466ADB7C3182C83C86FBAC2C9032696AE7B4C81C9A44A601429E074D430B6F8CC81C1B73AE4F8F';
wwv_flow_api.g_varchar2_table(33) := '3E3634735D8C4990FA213493108DBE83062EE067C04542884FA2317E761D4BF0EF202E15D2AA082B0B8AEC669B411A566624ADBAF9D926110F42106B03ABBB46447103616143114E15F9CA2622EF9177B5BA85A38805B0C9DF299C39D6D6D724261D9E0F';
wwv_flow_api.g_varchar2_table(34) := '9BB9396DD60E8A701F84C2630D56232C5C53C8EC5668D884CC990CF6A7F64379A5C9CD6DF21A46E629F24E89F323C293A7702F795D853493FA7D36C4A5027E144B2CD82DA2679E86F89AD034734368D2C2A9542B51B62027D5C5B9E56978DD0E65171F3E';
wwv_flow_api.g_varchar2_table(35) := 'DECF8EC69EF0E60C0F4E8BEC1411DE14E13D13796F98F760F242853D19BB4BC3E46E028466D339805077A924008C9E2B5C4A93396E78C235CD985CBD3D0DC2ED2BCF1B5C36CC0AB46809A345BE1620B4C8B39AC16994B664F295C744B468D78450B8AAF5';
wwv_flow_api.g_varchar2_table(36) := 'DD5A787CFAEB227369214285434BFD8C7C0E3764B417E1B62643BD5368FC01383C2D61019F171A71263BD454EE633271A3F14FAD28E0E2EA2C969607A6D5FAFA87C77972CB515E78F73883C31398C2D3228604EA8E465F08639DCDD149132FA9D2B26E42';
wwv_flow_api.g_varchar2_table(37) := '44629B4418110D0A716051118DB623EF92085B6ACFD408CCB1E844A849BB5DDAA0CA7C6AC6668D886F21A20D02612546ABD80DAB269A4C88B2B897FB17F9B716DD8626ED098348239CD8E092C6044ABB464320E2107C1EB85BE9BBEC79AFBEE3D506A05C';
wwv_flow_api.g_varchar2_table(38) := '12FFCAAE93FB363BCFC79D5755CC4850D6EB78F720DF7A622F4D9D43E1B5D664FA37C7A359A48FA60EDE2AC664334D8BA1B01B7A85A1B268D206B15ED2B691273C46EB33F54993797A8CFEE9FAA64A4D5184259B9F92BE23736A6D1A0345B370BE88BEAA';
wwv_flow_api.g_varchar2_table(39) := '699AA26CC79CCFA8D9905EADC9C3D122EACAE1DA47AE9C33938E5564A80556234B3237AE5991CF6FBEBAF4231115407E8687DF7E752925A90961396F33D4052108EB1292FC97883922726CB21EA4B099686B4EDD75FA675BC45A1391FF9B6D094B9F6C58';
wwv_flow_api.g_varchar2_table(40) := '742045EF049B66B16E85A91B098B95A818CF91F7C83AA9AEB36093541DA12850EA628898BA93A4730A590A98FAAAA17F86EFB1C9FD14D6C517E13911AAA124CF957E57CE8CCABB40C42B8BA4A86BFA0B3FB53C9FEF7D665E5897FAE897DFE3E477779D47';
wwv_flow_api.g_varchar2_table(41) := 'BA4BE70BC2D279A198C4AA022E240533C26FA4B5A432DFC7B9E569FAF73661D920224A8791155461555A258B4A480B115970CD306234E33B218977610BF7D92650FE13E67D421A97316C9BA4EC47EEB121CD93ACA0A33C2B2CCE1C598937D65298D6AC86';
wwv_flow_api.g_varchar2_table(42) := '300C30A56D63AE4D95472873AD8E01F09D4D79574CF388CC8E28DB4BCB027CEF3373A388A5A5AD8F96F63E9DE5E52453949B3C3371799D7C677D2577FE7E1F0E77BCAA23A8DE0C73A2C226B221422CC2EC7B9F9ECBFAE5F9BADE77FF1BB4F44F29C4A249';
wwv_flow_api.g_varchar2_table(43) := '8DD9C24FDA30155CABE893395144C9967521A1455C0BB269218CF9D262B83BB4280217867B4693DF25791A84AC546B26173315F2C84D368B2E8C6950806212A1300D590D15F8121DDC716539EB97E7333032C18BEF1DE791571AC3EB2299409A4DD2C7CE';
wwv_flow_api.g_varchar2_table(44) := '62155A4764FA5E045EB7839FDC54ADDC1E1C18E5FA6F3DCFD61D4770B89CC43B9D8086DB21F8C4CA12EEBEF9BC69896CF59222CA9EDB4BCBA4307C63069BD52CDE6DD99F2284F95B78A2D72DCF33880A60ACAB9BF12937099EC488462BF9CF644B533345';
wwv_flow_api.g_varchar2_table(45) := '47C4F241F2C18988FF46B54E85B25832F168A60BC1EA7F3236AE661244783C2631696163C4D8DA922B25DAC215B10272D2F3B6B0852CEF5C6128E11A39A92E6E5A5B0CC083CF1DC4E78EE7A5EF9D6F4823AFDBC14D6B67D1D9D6CB7FD5F620D9E386BA32';
wwv_flow_api.g_varchar2_table(46) := '1D3846E558E145D024032662BADFB4B658117FC18151AEB8F569F6379DA4A0AA92C4649FA2F16D3F39C9BBF7BDCE7DD75773F59A8A982FFFEC2515DCFBCC01DC7E9F69248417363BD54D6EAA8B861303F48F4E84174053C559786091C991AFC9C9491224';
wwv_flow_api.g_varchar2_table(47) := '778237D1C1BA6579785D0E7EF96AA3E22EB9716D31B75F590E40FD897E3EF7D0BB122F14A695A87002C36B60F47D696980F5CBF37972EB51EA4FF41BED57E4FBB8F7DA3954E6E973F49D276BD9BCAF2B4A2C6BD608866C3258B8AF00D62FCBA322CFC7D2';
wwv_flow_api.g_varchar2_table(48) := 'B2547252DDCAF8074626A86F1B6067630FF56DFDEC68EA35378E26F0243AF8CFBB57186BFA1FBF7F8B9F7CE5B2982ACE6DEBE6F1DB97FF4C202FDB6AA14CEB8B5439964DD25DA4417BDC76D62DCF536EDD5BDFC9FEE693145457E2F4248659A5B9D3ED36';
wwv_flow_api.g_varchar2_table(49) := '3B9A3F9907367C409C3D8E4FAC2A8D7AF9FA8BE6F095FFD84A52B22F2C7A75337E769E8F476F5B8CD7E5E067CFEFE799B78E6373D875661E964B1171260451936AEA26E66EFDF18DD52C294B05E05F1ED94CFAAC3C04F0DD6BE7B27E9939B6CA3C1F2B73';
wwv_flow_api.g_varchar2_table(50) := 'E278A7FD8CEA6492886A4E9E97FE91493A4E0F1BA26971690ABFBA6D0900EFEF394ADDE1119C9E442AF3BC3C161E4BE4FAF28585BCB8E930DEF454833369612E278486D7154F459E971D8DBD92EEAE73334DC0450B32B8FDCAF298E38E5C5EB783A565A9';
wwv_flow_api.g_varchar2_table(51) := '2C0D8FF9C4A92136EEE8E0A92D47C1A6F1A965F90A117DF39FCDF989565D5CAC2AF573784CA85E176347689C4579B7C4A8C27F175665291313B99C9E44DC9E444979144A044B0076879D3FBCDD19B3C3C18151064EF69A5619029FDB61101540913F8EBE';
wwv_flow_api.g_varchar2_table(52) := 'CE93167122628436259DAFA34F51DCD72FCF5326ADF7780702C1D7AE2C57882A72AD5C90137EA7EC1D172C2D4FE3A5EFADE24FDF58CE4BDF5B45499ADBE8C0BD9F3675CFB1E1118683FDE406DC51440550949B4C4EC2B8E9E80E4B059FDBC1D7AE2C67CB';
wwv_flow_api.g_varchar2_table(53) := '836B79ECD6C53CF8D939A6D51CEECB4D6B8AF9F18DD5331255AC2B2F2D89DBAF2CE30BE76723105144B46669B1A2335BAFABD7563078AA573260B0440366222CC9D2D084A99BE4A4BAA21E2CCA49C6EF75AA015761C69864B3B4E3F4289BF67644B5F1C7';
wwv_flow_api.g_varchar2_table(54) := '17F660B73BA480ADA032CFAB2C84DFEB223438A2582E4298566AAC41B5B6F5E170B90C73F9C2059951FC6C49792A37AE298EB908EB2F9AC370DF80E23A58B72C8F476F3D4759D092C4094243C33145914070CFB573626E4880F3AAF2181D1C3188D6EB8E';
wwv_flow_api.g_varchar2_table(55) := 'E7B1DB162B7DBA64711E6D873E3016F3C6B5C57CEDCAB2FF1144E1D6ABE773F2E889985C29725D79DBD37CFF57355173E2B74F290132D5953D9328949549299C10D10DACBB6ED3AFFE9967DE3E41CDC1530C8E4C48E10D936A23C2E4E55D1D5CB430DB78';
wwv_flow_api.g_varchar2_table(56) := 'BEB6BE939F3DB99D949C0CD5D764453800672627754535CAD412D338F60409AE8468DF82F4C53DD7CC55FA525D99A5DC312B359EF1B0782ACFF372CFB57362BE4927C0E85EFCF345E50657080E84E81B18550C99EACA6C9E79EB046E5F229A06F75C3B9B';
wwv_flow_api.g_varchar2_table(57) := '8A5C6F543B03277B81529694A5F2B52BCA14AEB261D361B6EE381A05E4A99E9D45756536EB2F9A1D434A84E839D6312DE1D5D677D2DAD647D3403442EAE285D9BCDA3042BC2B01598B8F651CDAA2612AFA0EB2491C6170643266270AB3FDDCFB99796CFE';
wwv_flow_api.g_varchar2_table(58) := 'C11A1EFCDC7C6E58534C4EAADBF48908DD2D8310EC6A3ECD43FF75809A1D47F9E30B7BB9F2D63F31A6D909146623C371ACA4A2EF24A13A458D3E424EC0351D30262C6A044B4A55B6FF8D9B57185CB8A5AD8FF33EFB78B4D57AEE2C428323785CF1FCE886';
wwv_flow_api.g_varchar2_table(59) := 'AA19D15995168248F6B8F8F6F5E7189FFFE591CD3CB9B12E4AF48406874113DCB8A698B5515CD56CDFEB76F0DD6BE6489C7E2FE75DF73B7EF0BBB739D815A2653C819671A7F1F7625D1FDF7A7C07CB6E7A9A9A1D4795D67EF6E476E2ECD3FB206BDE3F8A';
wwv_flow_api.g_varchar2_table(60) := 'CB93C4919E51064626A2FA3C70EAB402F51188981B2B1A3613E57D1034B40FB07641C68C2CF6C2AA2C2EAC82AF5E514A7BCF085B0F74D3D036C096FDDD46ABCFBDDFC963CF7530D4DB4FBCC74751493E7176BBE46310749C1E51DAADAECC626A62D28252';
wwv_flow_api.g_varchar2_table(61) := '88C4066DE4A42446F9D4F49FC4B456CBDD37AD3017E9C5BDC4BB5CEC6AEE65B144804539C90CBF73827557CD8DA90A28A80BCB4B6EF9D4227C89F10687F8E38B7BB9F69A1551BEBC80DB86D7EDE086358533CEEDBA6579461F8203216E7FF0555272D229';
wwv_flow_api.g_varchar2_table(62) := '29C90F1389C9321697A45291EBA522CFCB92D2143C9228AEADEFE4A127B7935992CFAE0F4EC754D6FB064324A5F81008767D709AB5F333A4B90D3274BA9FB4826C35C6AA9D15DD202CB137DDE7F0D2FB6D5C7F7E81315967BB72026E3EB7BA48F78F005B';
wwv_flow_api.g_varchar2_table(63) := 'F6EB44B6BBF9344208D20B729826E44AC7E9D1A8F6468786CD40A8ACB2C7DA2C02E2DD092A982F868336726DD8749894DC741ADA0614C2AA9E9D45A6AF91AF5E615AB3353B8EB27A69F10CD8C8E8F65FDC7C9838879D8E50B4D36941593AEB2E2D36163F';
wwv_flow_api.g_varchar2_table(64) := '56FB08B87A69AEF2D5376F594946712E1A9093E22227D54D768A6B860DA06FA07F7964332E4F22E98539D3C6066BEB3BB1C7DB1142B0BBD924ACE04088879EDC4EBCDB29B97EC251CFB3C16614A49BB46283A149EEF8ED6E1EF8CC6C0A73FC1F59615C3B';
wwv_flow_api.g_varchar2_table(65) := '3FC3E8605BCF30BB8FF4B1BBE9345B0F744BF17D24CC448C8532406C16AFB485B28A7292C311319DB02A723D33EA132DED412A5714D1713A14C5297F78EB0A85A8B6EE68895E78444CDDC87CAE055F7A2A83A129DA7B471425FF96F50B59BDB4401253EF';
wwv_flow_api.g_varchar2_table(66) := '46B55F5D99A5108CDFEBE481AFADFED073DFD2DEC7EDFFF6376A761C2535278359250508040D6D0331EF6F6D0BE24ACF0C339476E22642F49F3CCD864DF51CEF1EA46CE93C297AF12195F748ECCE54C04DC5ACB96B981B7FF62E6B4A93B8E1AA79E105FC';
wwv_flow_api.g_varchar2_table(67) := 'E8576E2091DC4022572FCDE5C4A9215ED9DDC5D67DDD749C1E0D3B33752B323BC525718F6C7A26A788B3DBD122BA5B38CCE17347D91F8C8F86C2962D78668869BEB8F9306EAF9B7897938EBE684E79FEA27C65D1DD9EC4289DE32FEFB429E2C6AA28BFB8';
wwv_flow_api.g_varchar2_table(68) := 'E93005F3CAB0A1D1713AA410964C44353B5AA8D9D1C2FBF52739B7325D51F23FEA151C08F1E2E6C3BCB8E930353B5B887739295E34076F8A8F089AC5668BCDB35A3AFAA82C2A34A4D78B7B7B39D9DA0E6E0F654B0B497039D162227367202C9B10610FB3';
wwv_flow_api.g_varchar2_table(69) := '86CDE00C26554E3A1278AD7994FFFCC62BE426C1795539ACBF70769445F5517C2B5FB9AC84AF5C56C2539B8FF09777DA181C9DA4A35725ACE29C648EB78EE049F129105F81203B25DA9F539C9B2205D2A7BFB6ED682139238010B0BBB96F46CE56B3B385';
wwv_flow_api.g_varchar2_table(70) := 'EBAEBB20EAB7A1BEFEE9B9D5CEA3C4C5DB49CED445ECEE0F4EB3B834655A51E54DF587754EC910F039CF3A8F353B5A6869D7E3B575F55D6CDD719438871D7F7A2A250B679394E23724912DCC343A7A476372378004974B4631925194A344662321382D82';
wwv_flow_api.g_varchar2_table(71) := '55D33E84281496C8A9B080BDEDF176328A729800FE767898BF6EDF84CF36C9B23999AC5E5AC4EA25458A8EF161AF1B2F9CC5EA79E9DCFFCCC1286AF07B5D4C8CF623224174612AF1B1C45061AE9FEED018F1AE84988417D9D5B5F55D942D9D6FECCEC6F6';
wwv_flow_api.g_varchar2_table(72) := '41CA73A245E786CDF5247A93707B9362DA9FD3E936B5F55D7853FC86D51B4B7F8CF465C3E67A0AE797C5303644D4E23FFCE47BB4B4F7D1DA163488C193E223DEED24C19540C9A23978527C44E713994CA2A32F14530C26B85C317C835691678B01803C2B';
wwv_flow_api.g_varchar2_table(73) := '6159EED43029138DEB561572DD0505785C76BEFE873A7637EB93FDFEA9109B9EAA63F0A16DCC4A7771FEA27CD65D58F991B8597E868727BEB18CF69E68CBF0D9EDED089B0A54F3B8EC9C539212D3797BE2D81809AE04BC2EFBB45C28CE6127D19B640C77';
wwv_flow_api.g_varchar2_table(74) := '5AC2DA548F3F2395A1D18928020614EE6A7D87DB9B6460CB9ADA07A715C9710E9DB30D8E4ECE3847AD6D419E79ED30E9853924646633BBB888045742D8D692123CC2F22A3BC5CDB7D697734E490ABF79FD08CF6C6B9D968FD7D67792E04AB0E8AE2AFA42';
wwv_flow_api.g_varchar2_table(75) := '0E76CBC1F319FD58B61838250C001EDC7A6909B75E360B4F78B1E6259F61E8743FC206092E2781DC0C8A1694A36517F0F78621FEE95FB75076D5AFB9E3C1BFF3C717F7121C087D68ABD28A84181D180AFBA622C07FB8F5B252A32F56655FD7B3228EB458';
wwv_flow_api.g_varchar2_table(76) := '62AA05B737318C10D0FD629D31F4ACDAFA4E5A3AFAF0670668EA188A22E0F1D1B1194554A2D763843D3AFB42D3DE979C998A40D0D43138E3DC5457669196EE252D3F036FAA0FA7CB692470D884E40BB409BC6E3BBFBF7DB1B1F9B66FABA3FB58A78EEF12';
wwv_flow_api.g_varchar2_table(77) := 'FA465238E76008B73F49C1C645F060362B68D026743DCD2662BAA9550769387865934227B6301BCF497573DDF90551DEF7BE93BD600C4A1844E8F679C82CCA216B6E397B820E7EB6B189F3BFF23C77FEE40D5ADA831F494CFABD4ED69F5F6CA21E85E05B';
wwv_flow_api.g_varchar2_table(78) := '575770D592D88A6D614E325393537A9247B26B1A6B298837D51F89BDEBE2E17428A618747B3D38DDAE984EB1EB2E9F3DEDEE4708BC015F785EF5958A5ACC81101BB634E0494D8ED9FEBFDEBE266A2E3E7361396726A60C3063C4612C2484AAD765E7A1CF';
wwv_flow_api.g_varchar2_table(79) := '571B1BAFB6BE930D9B1B70BA9D86813614833BDAED0E13212A8105B185D1B73611D9D7A6BBE5ACB1C208D792E284848DF74525D15660754516E3A3A130F149B06061A24285B0618F7710C8CB20393F8F3D3D36AEBCE70DBEF1D3CD1F9A83013C70DBF99C';
wwv_flow_api.g_varchar2_table(80) := '9313CFA292541EF8EC5C85A8ACED14E5FA191B1D430841760CFDA7A53DC886CD0D24B85D44C0CE629A89AEADEF262533D558B43D475425DFEF89AD4F3EB1A10EB7D763ECFAC8661D0AA9EFA86DE824CEE1202533809886F0ACE3FBFAF54BC9889F0CAF99';
wwv_flow_api.g_varchar2_table(81) := 'CD886E0829B9F7D64B6619623D3810E286EF6CC0ED4DD20D0929D61A4BA3D3FB8B041B973DEC2A6459812E4F47586093D86018C61ADE15B1703A7EAF93C51569FACB232C51D8CC08B80C29173A4BB5C73B48CBCB606FD0CE65DF798DBA86AE0FCDB51EFA';
wwv_flow_api.g_varchar2_table(82) := 'EA0A1EBA650117CC4D33BE7FE8A9F7B8FD87AF45BB1C42A1D899C7C0C34FBD4782DB454A56009B0D6C61D1605D7480FEA110893E8FB17BAD3AD0CDEB1746EB41ED41FEF8622D69F9193AE14A0179EBF3C1811089DE4463BE864267A2C65DD7D81DF5DDBF';
wwv_flow_api.g_varchar2_table(83) := '7CAE1AFBE4B824CAF54884D7EDE05B5797F30969E35DF5D5BF70E2D410B3AACA8D5C43618B168532A43B82C19733A78D3F9B656DF928B142A153AD4D0866706273D7754B19E81D307765C43D296598DA8C24069D002362D3959AC2BDCF36B2AFE96454BB';
wwv_flow_api.g_varchar2_table(84) := 'F73D5A73565FCD1D3F7C8DFB1FDD46FB70EC68A1082BF851E26D4B0359C539527ABF3EC058FA4D6D7D1776873DBC31A275A0A2180EE30D9B1B7026BAC8C8CD94C40A3175A8DA862EDDD31DEE6F738C3EBCB8E970D477551599BCF0BD0BB8626126E79426';
wwv_flow_api.g_varchar2_table(85) := '73CEAC143EBB2A8FC7BF720E572E3689EA8E1FBE466D4317E5E7CCC199E8525027C3D68D244CB793898FD7C76D23AAA8818232397B484749BA34D99E55713515EB423E75B0932D2D138A9B5F1848092587C902FC1784A6344EC7D07F376C6E40B81379E0';
wwv_flow_api.g_varchar2_table(86) := '96253114EF56EE7FB486031FF450386716F853639BC7364159B6278A9B0407421465062C93628BB26E366C6E0020D197648CAAB36FEC4379BB533203A6789260A6564577DBCE5692BC1E5352A013B8DC6FBFD7C9C3CFEFE7EBD7CEB788E104BEB9BE62DA';
wwv_flow_api.g_varchar2_table(87) := '7EDCF1C3D77862431D85736691E8F3847D532A363EA63094123E34397C6649473131F46775905AE1B1265134770E313032115324DE73CB32D25F39CC5F76F560B54B85FC5953CC4ECE9F93C695E764B27096AABF3DFCA7F769ED08B2E570908E9FBEC9E5';
wwv_flow_api.g_varchar2_table(88) := '0B33F07B9CD4357451B3B385E040886F7F711593710E7EF97A6B946573FFA3354ADABD952813129D38E2ED6A9FC2FDECEC0B9195ECA4B53DC87D8FD590921530175D83E6693658D43B9253A5B42AB327B2B8BDEFD11A6A1BBA98B37C81929DD4D43114B5';
wwv_flow_api.g_varchar2_table(89) := '217EF7D2417252DD7C7A4DC959DFDFDA1EE486EF6EA0B6A18BC2B925A4E7654802CADCE443A129D519EB752906C0F4DE75A166C89F2DA463606B84251D5283A1D014AFEEEAE4B3E7E7C76CE80B9F98CD254B877863DFA969B91B4059761259C94E56CD49';
wwv_flow_api.g_varchar2_table(90) := '8B29A66A1BBAB8EFD16D6417E7E14C74D132083FDCD0CCC9E3DD4C4D4CB0A4BA8057FFFD1A83C0EFFED9560AE7CEE2F79B5A98E513DCFFE8360E1CE9A162F19C281D6B70788CFB1EDD862F3559AA8FA0A67CFEE0B97A9C43A779FEEFFB199D12542E9EA5';
wwv_flow_api.g_varchar2_table(91) := '640277F58D32383A316D18E78E1FBD4E6B473F5525256642AA34957FDBD385180FF1E2CBBBA96DE822AFBC90245F9291F401D015CB2D21048FBFD9496B475081E45837D5434FBDCF131B6A199D12CC5D5E15F6D3858BAA5888DCEAFEE81B18656AF28C6E';
wwv_flow_api.g_varchar2_table(92) := 'C54A7E4C15DCAF45319DB3C3660C5DCD66FAC6A46C90E7DF6BE7CA7332F14E8372C84B4FE20B1725F1DFBD6A76B672C3775F22D197445E7981219EFDA97EFCA97E1082BBAEAD50B8E6C913DD14CF2DE1AFEFB4D171B48DFE9E312A97CC2531B258D2B5AF';
wwv_flow_api.g_varchar2_table(93) := 'B19BC1D109AACF2D34ABD848816DD039D2F0C038C905799464A562B7DB8DD08616B6C26A8FF6B36A4EC0B0FE6A761EA330C717E6A8AD14CF9D4542A2D388570A4B5D87570FF6D3A3B998B722B2F091DC687DBC7B8F061562D9B6F318820484804D1F8CB2';
wwv_flow_api.g_varchar2_table(94) := 'E5EE57585AE4A1BA32D3E0E4BAA5DBC8506892ECE26C4AF233A5BEDBD4F07E78AC436393CA867E62C37EBCD919312AEB304D351662E5B2C70A42AB89E45A58818F60E58743533CFC7233F7FFF31CFEB7AF87FFF43EF73DFA26BE809FCAEA72C38511A9CF';
wwv_flow_api.g_varchar2_table(95) := '10E97A9295CB49E57A724AF2C899256D34CB469A983C43A2D783DD6157F51D49BDD280249F8724BF272A953D52B9E5ADC33D14A626F0C23F0E71DFA36F92919FC9C13E8DB16198BD642EBE80DF68CB46B43814027266E52A29F25A18B808F041E730BB9A';
wwv_flow_api.g_varchar2_table(96) := '7AB19F99E0CE1FBEC18123BDCC5E3AC7E8EF194F32DB8E877861471DC303C34C4E4C92E44B22A5308792CC000E877D5AAE6264FC681A1F740CF3EB579BE83CD6C9132FD63161B3939E9FA9727A4B911D15D160ADC833AD283495B2A834CC70A8E0DDA620';
wwv_flow_api.g_varchar2_table(97) := '0F3EB38F7BAF5BF0BF4250353B5B79F8E91D6CDBD94A4E492E05E5850AB335FBAD0F6961B13FA6DFC51ADB3445BA6AC1893821E5266A789D0E4AB39328CDD239EDDEA37D7CD0394CA46A8D09AF36E7E4ADC3BD6CDCD2C8B146BDCFE79E5BC1CAD901AA8B';
wwv_flow_api.g_varchar2_table(98) := '7D51FD8B70C1E64EFD6FEFD17E3AFB464DDF5FB8FD45C57E2E5F94C173EFB4D1DC39CCF7FE52CFA19D87985398CCFB7FFD22E5E198E883CF37F2D6E11E9C894E724A72A38C01A536440CC55A4FA6D5B8E29C2C4AB312A92EF693756519FFFAD5F3153DB0';
wwv_flow_api.g_varchar2_table(99) := 'B943EF6B73E720B5110E2AE5740AB37A434C43C0A2BCDB24CB4E2859C966051678FB8361BEF5EB1DDC7BFD82691D8467BB9ED858C7C62D8DD4EC3C862FE063F69279F8027E7D0195309559A4CCCA815ADB83E1989314260DA750A9D9C1118FBC9FF19131';
wwv_flow_api.g_varchar2_table(100) := '9D5804946579F8F1E7E690E434A7E1F314F0EBBF35B371CF2949F8696852D52B01A466072828CAE4F3171570F9C2CC19C75A9A9D4469B6A9226CDB7F9227B7B5D1191C4500D5C57E7E7CBD2E05DEDBDD425DFF10497E0FEBAE3E971F59FA77DDF20C366E';
wwv_flow_api.g_varchar2_table(101) := '6924253B1535955567AF5E978392AC44EA5A8226C78D14031182957302DCB2B680ACE4E9D72DC969A7BAD84F757893B4F78EF046DD299EDBDE16E6C24A9D9C0F51D1CF62526AC25A7CCB4C033F786A8A4F7DBF86F9990EAEBAA094D58B0B669CDCBA862E';
wwv_flow_api.g_varchar2_table(102) := '6A1BBAA96BE862C39646820321320A3299B3742EBE34BF528FC950476C9134F8D859BF2D1DFD64669A5CA2342B8924A75D5FC469ACE9D0484877436425F1C3EB672B8B16B96EBBA294D0F028FF681C0AEBAC22AAF24E799687DBAF2C3638DD47B92E989F';
wwv_flow_api.g_varchar2_table(103) := '4E75B18FDB7EB597D3631A775E31CBF86D647084FEDE7E4A8BD2A2882AB239FCDA08828059994780C7E9E0D32B72B876B95E9F636B5D273F7DA54512E3826B57E470CBDA828FDCDF9C54B7FE5C6894E7F69E96AA4609559F9F56145AC111616BC28A8E88';
wwv_flow_api.g_varchar2_table(104) := 'A4692724FB383438C9B6C7F7D0FBC03FF0274051B65769A3B6A18BE0E018A0E9BA8B2F89D4C23CCAB3745D40139A5267482FB22194A2681199589AA502ED562F2EA0E9A52F7FB459123A07F9E175B189CA089B7C7A3E3BBEBF99FEB844332D3D4CFD1EA7';
wwv_flow_api.g_varchar2_table(105) := '9D7BAE292333D9F9DF56017C4909947BA718742445730F21B8E3CA59D3F66FF9FC6CB6B60CE1F17BC2288F381EBC6E8E323F6BAAB2F8C203AF51BEB0121B70ED8A6C6EFE6F10957CDD724505FFF1E7BF5050512825D97E0868B290704E665DD118753125';
wwv_flow_api.g_varchar2_table(106) := '65DF11EF20AB209BAC021D1E333812D2B942F89EDC391E2A7C493A11298E3529EB3A9CF8A009D5B919A99B505DE4E5D28519ACAC4CFD1FEB74AB171772C7E5E6A2D5357453B3AB959BAF8E16EBDFF9A779DCF987FD24FA3CD8A4A4B67BAF2957886AC396';
wwv_flow_api.g_varchar2_table(107) := '46B6ED3A1616CD6AE8A5AA2283756BCA6342BACF4C9D616070208AF2AF5D5D4C7591CFB00A830321E5F9AA8A0C36ECDE8FD7EF0101775C312B6AD301F474F652119E3F99A85ADB836CD8DAC8B69DC7627AF4AB2A3258B7B63CA63BA3ED481B8595856115';
wwv_flow_api.g_varchar2_table(108) := '013411BB3848EC640A44943B0D8B3A2F3B3BE5E44557A20B97DB1516999AA9AB29712561542FB169D1B509E49D7B69753AB75F5EFCDF22A2D6F620AD1DFD5C2089E9AFDFB0941269116EB8F7657A862679B729C8EFBE7DBE425C5515192CCD8DE7D0A019';
wwv_flow_api.g_varchar2_table(109) := '2EB866593655D2A2DF78CFCBD4EC3A46202B404A9A9F04B719F4EE1986C6F74FF1BBD78FF2D90B0AF8DA3F2D34DA0F0E867862E33EEEFED20516624CE0F3EBE7199FEF7FEC2D52FC6EEEBFF53C29DA51C0DD8FBD0B02AE5D96C379D36CB84848EB7649D4';
wwv_flow_api.g_varchar2_table(110) := '3EB1711FF73FF616A12948CB0E901C485658C696E61136EE3EC02FFEEB00DFBF65B132770FFF69277687DD303C88E93C8DE96E90E22D9A54CE30529741B3940D9418995CF3410BA7729939A65295E088E8B3C5A8EBA445D7F7BC794DFEF4F1C2C1101BB7';
wwv_flow_api.g_varchar2_table(111) := '3451DBD8456B7B3F7511B12B11FDA3F75EA6EA37D244D5357473ACA39F256B1633EA74F28367EBF9D917D58A3A972F2F64EBEFEAC82CC80021B87679B632D1EFECEB60FEB9F3F1A7FB90CBDE65253B5950E423D39F4055A14F2166803B7FBC89E1B1293C';
wwv_flow_api.g_varchar2_table(112) := 'C9AA87FDE6AB17187EC2E06088275FDACF759F591E85A8488E078FCBC135CBB36794FB972D4C27D39F60B477D78F37915998C9EC8A223DFAA0694659CCAA223F2599899464B9A92AF229A2B8AEA19B9FFFE74E8A2A0A95B51742FB1084256CE6C20BB98E';
wwv_flow_api.g_varchar2_table(113) := 'A7454C0A9BE9DCB259DDFC7AA53BCD00754468CF84B36A2246FD6B2D1C72B7D4131D0A4D91E4B4D3DADE4F703044558599E7F6F0D33B79F4D9BDA465A791E44B226F4E39B3FD49D81D7186957126D13B8341D14D922F0967A2CE459A4E8DB3BBA99773A4';
wwv_flow_api.g_varchar2_table(114) := '7CBB0B1617E0FEDDFB089BE0D2AA7465B2AB2B33B9EF8E0BF1A7EA1C6C4191173441559177C6CD70E3BDAFB26DD7312A1755121717372D0C67E39626EC0E3B7D5AB42E377756804FAFCA31FAB36DD73165D344E6F0D26A351FF4EE9BCFA5A04CBF2FD39F';
wwv_flow_api.g_varchar2_table(115) := '40A6DF49467282417CB1AE2737EEE7FE5FBD4D923F89BCD23C8BC26DFB107985369963C99545E462B031EA3FC770A62996A4A67E107295316B48C0C209BFF4EB7DECD8BC8BD048888BCF2BE5F99F5EA5BC30BF349FBC92DC287F60E4B3351EA6848F1ABB';
wwv_flow_api.g_varchar2_table(116) := 'F1F83D8A18DE72A84F212C80F52B8BF87B53C8108191EBEA351FAD8EC2CF9FDEC9C34FEF622834C9FC65F3484EF3477132C5C7B7FB1869D9690C8726E9EA0B297ADDCD57CFE78273B2A44DB62B8AB0AA2A321582F17B9CDCF7E5F33E822AD1CF9D3FD9C4';
wwv_flow_api.g_varchar2_table(117) := 'B65DC7C82AC8A07876B1AAB2D898B608AA3D1A6CA2A944A2C9C5334D696C1A8B6A55BBE8376972182CFC6C8CD2B2C24211D2FBCEBD68311A5059E88BA98759CBB16B12F6BB3B383D98B0B5A31F4FB247290BF96EE3693A7A47C896D2B4AE5E5BCE1F36BD';
wwv_flow_api.g_varchar2_table(118) := 'CEACCCA51F59CFAB6BE866C3D6269E7CE900C1C151F24B72995B9A87DDE1307C46D38AF9AD4DCC3967364208BAFBC715C2928968DBAE636CDB7D3C8ADB5655647EE4FE46DEBB616B13DB761DC3E576B160F97C92D3FCD3485BEDEC1CCB1626182B3F32C2';
wwv_flow_api.g_varchar2_table(119) := '2AB1A0379A3061E5614EA459947DA1062F94FAF0A687D826D98A11AE66538AAD4D77628810422A452D97A816EC3B3E3386DC9DE832F4C148D5B9F79BFB592F115661B68F734BFD338A8B08A1B6B6F753B3EB18AD1DFDD43574EBC4EB4F223D2F8BB98599';
wwv_flow_api.g_varchar2_table(120) := '388CF8DDCCD7B65DC7B13B1CA4E704D034C1BE63032C288C2D629F78E900C9697E1CF18E2858CD87794F6B479096F67EEA1ABBC3EFB5939E1360C1F2F9A4A4F9A575D5541EA06CE2B384746CC252F259986CCF2697918CE2540A9A22AC7CAB85AC910954';
wwv_flow_api.g_varchar2_table(121) := '330F2150EA9947B850384669330AD88B19E04396F28A52AD501BD01D1C23231651C827664886EE3FF6F5B0FE5C35BB68C5FCE86CA3275FDACF86AD4D2060DBCEE320C0E576E24A74911CF0939493CDB9B3CB712739C33ABD793C426462A723D6DA866E52';
wwv_flow_api.g_varchar2_table(122) := 'D2920D2C7B77706C7A0E53D3C4DCC59567176D1DFD3CFCF42E5A3B83B4B6F7D3DAA1E744A6049271263971B99C542D9F474A7A723875331CBCB1498C07B9A63CD39E58A5722CD9BF6093F52CF9940673E14C2BD13C53473EA3056C4695BEE882F4261753';
wwv_flow_api.g_varchar2_table(123) := '1C909A366D6EA3883AC4C9BCC1EB8CE3FAF373C9F0C7F3F49B6D1CE91A31B8D091EE91D8846539C9295200B0BB7F8CE68E21250C134B9FDA50D34C53CF0419D901AACED377B719CC8E560FD62FCB64DD129D406FF8652D684CD32FA86BEAC69B9C642023';
wwv_flow_api.g_varchar2_table(124) := '8E768FC4BC6FE3D6261C0E0719D9690C8F4D45A909569DE9B92D4D1494E4E32FF2B36CB60B775282593C570AFFD88420DDEFE42B97E433BFC0CBD36FB6B36147A7B9F6B1EAF1A3AA5FD15001A5AC10069458FFC926D563574B544740F84248D87709786F';
wwv_flow_api.g_varchar2_table(125) := '4328C5DD22F067F5CC1CA9B89A5406290AB621C5376D02BEF9C9622E5E1060418197EE236D0CF50F1B492147A65914BD6F36332940CA36DA72F07494B5A64710CCABBA3C838C9C3452D25308A42587F1ED914C27947AF2EB9666F2B955B92439E33872BC';
wwv_flow_api.g_varchar2_table(126) := '97B7FEF69E59EB3DC6F5E6AE13BA2B223C8727FBC7638BB2DD2748CF490321A2C629A29C9FE964A627935D94456A5A0A89494E63CE6D464696DEEF24571CFF714325F30B74F1BB65731DC79BDB2C41FEF0D94567232C9B34B1424A0393DD0D3649498E64';
wwv_flow_api.g_varchar2_table(127) := 'F4086912CDE2F49A54A45F2AD68FE57EA94CA44D2A6E2924829B09B40F30BFD06B4C00C060FF1093139386623FDD6E8F70639B94E11211C3EF35F6C554C4E5EBAEEBCFC1363E2E5517D4C2F32617EFD7B878411A9F3B3F47B1E0DC892E32FDB1716D758D';
wwv_flow_api.g_varchar2_table(128) := '7A994A9D58CDC6ACE3080E8EB1716B33A9E9C931E7E7FBB79D17B539D6AF2A606A72326A7DE403033C2E3BF77FBA8C24675CB83FDD6CDCDA8C2B299CC3689308F14365E9488D47C488CD26EF6A4BB0DAA69ECE15CDC164A2300BEA47D23C849460296CA6';
wwv_flow_api.g_varchar2_table(129) := 'BE2427910A9B4D2AC61F5B9AAD284F56267BDBAEE3CA691733129690D2042227356063786C8A37EA4E5A9CABF9510B75D3DA022627A7B0099B54F2D246A4A55959895CBFCA24AA9FFFE76E36D6345350964746726C31F8E44B07F0267B4CCE179E37ABEB';
wwv_flow_api.g_varchar2_table(130) := 'A4AEA11B87C34E466E3A42D862129E95CBDEFECF8BF09E0919C92D36A9E05DE4FFD7AFCA615686DB68E3A6EFFD1D6FB287CC9C74730D6C423D016D26C29253B6AC796AC2E04E6A1DD04816875CE854BD573DC624AA30AA7C8282C2FDD4E2A942C48667F8';
wwv_flow_api.g_varchar2_table(131) := 'DCF12C2B33096B634D138E783BA9E929C66E1F193F33ADF2ABA6A7092597EED089E1B32AC4377C620E0B33D41AF491795C50E8E1FE6B4A490CEFFC8D35CD7CFF37EF50589647665E7A4C0EDCDAD1CF932F1F20A728CB48208ED487B7EA50C1A1313C291E';
wwv_flow_api.g_varchar2_table(132) := '639E86C7CE445985D60C28BF27816F5E5BC999F190A1BF45D627C965E7D68BF3B868BE7994CDD577BD407BCF30F397CC368F96934F2E111FC22A8C46036A8A99A7454511A5E3DF14DF94EA5EB09C5167FE5FA8F869B97EBA52907F1AA7ACDFEB64DDAA54';
wwv_flow_api.g_varchar2_table(133) := '63E1221C212337CD28891479E4C0F1C1691565A11C9C608EF3FDE67EBDF28D94F4DADAD14F61B6EA4FBBFF9673D85ADBC5F62343866F6A5E7E12174A0B54D77892BBFE7D331939E994CDD1639F89317C581B6B9A71253AC92BCA8A52C08F768FB0ACCC6F';
wwv_flow_api.g_varchar2_table(134) := 'E1580E43141D3D195D2260C39626CE5FA456865E5096CE1FEFF0F1E7ED5DF40CEAF5288A33DC5C383F950C9F394777FDFB16EA1A4F72EE9A8561B74CB49F5223C65122C42ABC265B759A4D2F4415B1F6E48A35E145B369329C5944F9373429E151C3A6D3';
wwv_flow_api.g_varchar2_table(135) := '922D1A7B25C2C6AC26D9107AE109E93C3E4BFF6FBA6A9EE2AB79E0D7DB39D639C8799754AA87496AD01D43F98DCAE40D8F593E2D71D7D1413E29119695A80C984A75266BAA9956675AF7F50D9CB127306761995EEF40834C5F34A11F6B1F2033375D3DF5';
wwv_flow_api.g_varchar2_table(136) := '21B216D6D4B13D27F0863956649C47BB4728CE702BE2FA572F37F195ABCAA2603BB75D323D8CE6EB3FDDC253AF1C644E7539BE64AF8143B3D288D044CC23EB6DD1561296EC5A21B90AAC870DE9B256284AA0F42CA6A515EB94AC98E25548D5E285D0B394';
wwv_flow_api.g_varchar2_table(137) := 'E5F74DE300AC6B3CC9CFFFBC87B2B9C586D313C9CA3974629ACC219B50E1CDF2F9CD42B0A33918D312B3EA2ED386719ED9C3EA2F3CCB99B87816AF5C8023C1A1BFC216BB28ECB63D277027BA9553506D61FD72444A7E78E037DBD9D7788A40BA3F9C55A3';
wwv_flow_api.g_varchar2_table(138) := '8BF2160BD712029E7AAD890DEF1CFB70619C8E7E567FE1599E7CF920B3ABCBC82BCE32D7C366261E9BD58B397B968E9157A8C96852CD12CD967DE9D2A90DC6A697C5A4C9396DA060B04C67A9268522A3BD6D113D400346C6A666E4085EBF87A2F23C0BB7';
wwv_flow_api.g_varchar2_table(139) := 'D6FFD1727294A1D1C9A8640CFDB025139B6170D6B043B3E5E428754783544958F6E060889B7EB08507BEB098056569D3BA017EF1CC6EB6ED3E4151791EE5738A4D89216C31BD8A5FFFE9565A3BFA5935AF4229B6A185E1D15B0EF631393ACA732FEDA5AE';
wwv_flow_api.g_varchar2_table(140) := 'F12465738BF125FB24BFA188C99901FEBABB9F631D07B8EBD3F3A671B48EF18B6776F3E4CB07193B6363D99A45F892BD524AAA500ADEA124B49E4D14CAD418D637842CFA6CAAFA157560379A2283951C4523FCA79E892C8CBA8FC272B42D6A2D71345A4E';
wwv_flow_api.g_varchar2_table(141) := '85787D4F17972ECA5426E3E7CFECC19BEC61F1790B54CE6351095A4E8598979F64ECCCBAC6939456259BFD90135A343333FCEFFB4E2B84F5D4CB0769EC0A71CF334D14B80F5296EBA5AA3C9DE060887D8D27D9B6FB04758D27494D4F66F1CAF9A4A6A728';
wwv_flow_api.g_varchar2_table(142) := 'ED46E664EBC1D31C6CE8206132445DF8B9390BCBC29E7A61099BEA6BF3D6915146E29358BE364F07FA29CE628D832706812CD342DE7D02E2F54CEE1D9D67587FDF56166427B0A03C5D4F1D6B3CC9B18E7E36D634333C364551793E7945D961480D3152E8';
wwv_flow_api.g_varchar2_table(143) := '85E27AB71E20656E58E91C94CFFE7C9FA684968588714E8A9043D1A8E76D469FC4AEA17222256228A44388E5B60CFD42330F25D04CFEA89DEE616CA09F6DBBDB70C4C751545EC0ACF23C89E685D2CBC8BB9796FAB8F3F20236D634F3C06FDFE364709CE5';
wwv_flow_api.g_varchar2_table(144) := '6B17618F8FB39C19AD6068018D5BD766919F12CF03BF79978D351FB078D57C0219C9A009BADA4ED21F1CA4FFF4108EF838BCC91E02E929F89293403A4BD9D8FDD2BC8E4F4C72BABB8F91E190FE5C46B2C119342D468CD538C5CC9475E6A9A77AAFBFFD89';
wwv_flow_api.g_varchar2_table(145) := '7C9818E7EB3FDDCAA196D32C5EB9005F8AC7904623C32374B7F5D0DF37C0C4F814BEE424DC892E32F2D28977C449C694859E348B11671EDFCA9FEF5A20A627AC5FEC578712E15A9A69C1CD54295761101663C172AA1B32CD8AD8652CD583C82DED07FB06';
wwv_flow_api.g_varchar2_table(146) := '999C982490E6576AA55ADF1741B24648ADEBC4296A771C222B378DB279C52426BA54C9291FF1AB9C01067BDF3BC4407088F2B9C564E6A599E044C3D05051B55AD4582425C108EAC71E9F666DC30A0691AC76F51C457DDE77BEB58FC98949E62E2CC397EC';
wwv_flow_api.g_varchar2_table(147) := '890696C7E84F24E52D322E4D58D904CA89E0F26F7FBE73FEF48475DD2FF66B325C4644202F963A216AFE8371D072F449EE423E995E0140283A98813A55DE29D0E47AF38A2C21F681CC9A8A8035B844B81FFA63C6C9E5E6BE1452F90B83403443078CBC4B';
wwv_flow_api.g_varchar2_table(148) := '651642CA773439AC8CE9576025F2BC0A4D393C5D3E5C33920E6F3E2B9FF167396D71BAF1476657A899F19A9C66243D249DE12EC1C435C553A46996C5B7708B67EE9C2766F063090B52419807342A28054D95BD56855E58D779DAD212E1F768CAF9C78629';
wwv_flow_api.g_varchar2_table(149) := '4BB412AEC907785BE4BF02EB114215C372910BCB31BDCA5E14D63309859A621F05C51531E2BD96118BE84D2562CC5DCC82C2C2925C805ACE53C6C5590FA156D02996B989A95B4354BFA3214BD3E85C333A48237B4DA86740448E69D53409FF44D4717E66';
wwv_flow_api.g_varchar2_table(150) := '9A78C47A08EF12777C1C97560518199FE2F5DA1E637257562493E673189B68647C8A37EA7A0978125835DBAF1C320950DF364C41C089CB19C7EB753D8C86A65838CB4B619A8B3D47FA69ED0919DD999D9348654E12B26C7FA3AE87E1D094A21F9844AD29';
wwv_flow_api.g_varchar2_table(151) := '957122222EE0496055A59FFAF621EADB860D33DB80952875326CA64358C919D64CCB58E2CA72A249A4208BA4751818334D139612D816B2D650126A23EA830D1584A79C1E2BCB4D23A155D62A35C312D42C042964735F10B3B86D6CCFBB0227D6A2771966';
wwv_flow_api.g_varchar2_table(152) := '1D03AB5E219FCA1AF9FEFCD9C9AC5FAA17C5DFFAEE5126DCBA9371D56C3F79A909341DEFA73A8C7C4C981AA3F9B4C6BA25E9749D1EA5A367C4D0110FD6F733ECD2B86E5531095363BCFDC1085FBFA280EE6088C79EDD4B62B21FAF5FB7802A739358B724';
wwv_flow_api.g_varchar2_table(153) := '9DE6B6014AC3E9E917CF4BE6CE3FD633714628DCD410054228B5144023CDEB60DDD2747AFF16647B4FBF0E7C13916371A55369156927A2B8A1E196B149DF6B18CE52815C4044F56D2BEB6255B414778E154A2994542B9BA4231BB028398467317F88FA5E';
wwv_flow_api.g_varchar2_table(154) := '6652EADD6705FA09695749E5524C6DDCA2330899C76B9A621E47F4924BAA020C8F4E92E8B273D18254FEBA3B6898CA878EF472E51D1BC8CB4966CF9F3EC3B915A96CFA531D50C4532F1DE091BFEED31D9EE1D9C92DCA6649A99F2B96E5515DAA075DBF78';
wwv_flow_api.g_varchar2_table(155) := 'FFDFA96F3CCDAA8B33CDCA2EE10EDEFDD3CDEC6FE9E7BA8B4A78F0F6955478C6D9DBE3607E91974BAA021C3B35CADB0D417A06C6C90F385959994C41C0497DFB086FECEB61647C8A03ADFDD4ED3F4EEFC951AE3EBF8845451EF6B40CB2B2C2CFDB0D418E';
wwv_flow_api.g_varchar2_table(156) := '9D1AE5FA9559BCB1AF9745455EDC4E1B8F6F6A67646C8AFC3427972ED0B3965FDC71925383E35CB7320B77421C8909718C8C4DF17A5D8FF4DE61DED8779A91B1A9B052AD27A154E624B1B2527779EC3932C09E9641DC09362E59904A654E22F5ED23BC5D';
wwv_flow_api.g_varchar2_table(157) := 'DF47CFC038D7AFCA22313E8E53831354E6B8D9B0F3242B2B9209781DBCB1AF973D47061404AF5C0E4658935A94B01C96D3D0B569AB3D467BDEE5C2A6120E5544B29489E121B7C94158A144CA0B022E021E077F79A38143477AB96265313D6D5D8626EA4D';
wwv_flow_api.g_varchar2_table(158) := '8CE7E675F3F9D1DD170270BC6B80D33DFAC03F7B5925AFFE723DAF3CB28E571E59CFB2D5D5E41766F2C26E1DD2921D70F3FCA666DEA9EDA06A49258E7807C2165DC7694E5519BD4EDD8A9B539C8263B49FEFAE2BC221CEB0B438917FBDB6882487C65D57';
wwv_flow_api.g_varchar2_table(159) := '14509EE9A2B6BE8B754BD2583DCB49421CCC2BF4513E2B9D650B72F8E2DA1C7292E3B962819F8A9C4442BDBD8CF40D509193C82D1764E175C2C2222F975638898F837FFBA712CAB35D1407E279E8C6323292E22808385959E127D313C7F8D0105FBD309B';
wwv_flow_api.g_varchar2_table(160) := '858549E1F7A6F38979494C4C4C1ADC2B3FE0E2BBEB0A29CB74312B10CF9D57E4937826C45D97E7B36E493A71DA1417CEF5F3ED4FE4313A324641C0C979957EFCF609725312F8EEBA22FC2E416E723C775E9E4F77478F021650752D61F9B726035F2C874C';
wwv_flow_api.g_varchar2_table(161) := '580E409D1E36C3B81992B19935DE0DB88E2D0A182554C44DD4DF2555BA886B39D1474BF730DEC47816CDF231393905082A0A93F9C9D79673F182543A7B47B8E7976FE374C51B8D8742130CF40F33D03FCC7B3575205082CE892E3B794599043292B9675D';
wwv_flow_api.g_varchar2_table(162) := '21DF5D57C43DEB0A2D7065088D9F31626417851DACDB77B772F8681F492E078E811E4E06431466B8A99A95CCE32F37F2A3DFBE4D5BAB5E7C776438C4B9153A8AE2925B9F63FDDDAFEADF8F84088DE9E19D5F3D57C7455F7C1680346F3CD9F17A22C7E6F7';
wwv_flow_api.g_varchar2_table(163) := '5AD85ED7AE7FCF2053537A0461C50D7FE673FFF23A6DA78649F325B0727E068FBFDCC8BD0F6DE5706DB381C55F15E654177FF9AFACFBE62B5CF3FFFEC6E17DCD54E424B279E709965EF7271EF8FD0E32535C78C7FA40C0E0C8049FBAEB45EA5B75C0E227';
wwv_flow_api.g_varchar2_table(164) := 'BEFA3C2FD41C0160D7F64392D58E82C888E0F24C148ACD201E1B361972673A923586CEA6BC1F476825B2EC8C98B49AC535AA200F882E9BA3A1E14EB0B3A85817790FDEBED278CF17D7CDE3CEDFEE034AD979B89B4B6FFB2FE38D2EB78B55ABF512497F7E';
wwv_flow_api.g_varchar2_table(165) := 'AD9E47FE7A007738EF0F21703BE3F8C25A1DDF74A27B90CBCF2BE2B59DED0C021539662AD5A6778EC0E23463161686FBF14E5D3BA58526EAE068D7308FBD708896B620BFF8AF7A3E7F492159A92EBE74553915857E6A0E0F184396ABF8AD5C3D5FE1F300';
wwv_flow_api.g_varchar2_table(166) := 'DB6BDB292ACB33BE4FF39AB1CCDEA1097EB3F130DB6B3BB878859E99DC3F1CE2B275AB7879FF009AA649EFF5F1E8EBED52A8C6BC162E9BCDDC3C0F0DC774BCFAF8F8249939012AC2880957BC607C6C92FAD6211CF10E3C3E7D4EFA87C6F00492A39C5942';
wwv_flow_api.g_varchar2_table(167) := '82A01BCE69C5591D6D8982D592E7F859088BD735C4D7542B52CD4CD6ACE5DEE4F8A1E2E2102C2AF6E08A8FE3772F1EE09537F5DDF2FF6E5EC28AAA6C1226468C7602697E964BD080248FDB108517AF98853BECC47CA721487EC049C0E3E0F72F1DE2E997';
wwv_flow_api.g_varchar2_table(168) := '0FF2E61F3EC3835F5EC22D0FEDE6A65F1DE6E5BFD618EF01F8E1EDE7813D9E59D9490C8726F9CB6B0D5CB2660EEB2F80FC4C2F99E91E16960538DE13E2BE1BAB383530C6D37FAFE7F66BE71177668A960FDA805240F0E6BE6E2E3F3797571E5987D3151B';
wwv_flow_api.g_varchar2_table(169) := '82134833B1619B769EE0F64FCFC397944066BA93D50BB368E91EC5E1701863CF4A7571CFBA22BA8321366E3BC2BA0B8A883B7386C9BE1EBE73FD4ADEA90FF24E633F172F48E5B1EF5E486E763205E92EBEFCF04E0E1DD737D6F819C1CA6A3DFFF0CFAF35';
wwv_flow_api.g_varchar2_table(170) := 'F0C54F2F02045E7F92E240B0D96C2AB243B31AB142713B094DA8AE24A5508B2211369D0D36F3B840BB0D21E2545FAB261D7E68212C619ADCB21F49030A024EF61D0DF2D85FEBB07B7D64E5A4F1B7BA3E1CF176AA4B52F8A07D90DE937D56038791B1290E';
wwv_flow_api.g_varchar2_table(171) := 'B60ED01F1C222ECEC6C4842E3A4E1EEF6471E12CDEACEBE2C1C7DF27353BC01F371FA73C60A732002DE3537CF233FA490E81021FB5CDBD8C0C8F63B74FB17DDF008F3D5B4767EF282D83367EF64213E7CE4A2231C1CE57FEFD2D9EFDDB0112939C2C294A';
wwv_flow_api.g_varchar2_table(172) := 'E4C6CBCBD97EA8879FFEE13D923C2E0EB60E70A26B903DC7437CFBF7FBF9E439015EA8A9E5A1AFAFD2A1D023937A7F87C6F0A6081A3B4638F0C1291A5A83DCF74C0397CCF1124876F1D80B87F8DD9F77B06C5E2623232183933DF6F756E6A6DB587F4111';
wwv_flow_api.g_varchar2_table(173) := 'FB8E06F9C57FEEC6E94C606A728A0F1A8EB3AB759447DD70418597D19110DF7A642FCF6FAC63448BE3C695192C2A4F65FBBE0E1E7BB61687C3CEC9A133749C388D4070A227C440509754BD8313D436F74A7E3FCB0969C2128613F26992A675AA094D76AF';
wwv_flow_api.g_varchar2_table(174) := '4E21B43FCC182BBCF957F520F825685F534A0B699AA59AB21C4CB5E40D5A423907F63631101CA67A692589EE0434043DA782341E6C212B27C0F0B03EC1F3AA4B157AEDEF1BE2606D136AEE1864E6A4D2D5DE83DDE160E1D24AE21D717CD0D44657DB2932';
wwv_flow_api.g_varchar2_table(175) := '73D32829CF0DC7C4344EB47673BCA5D3F036DBE31DCC2ACF35B8CAF1D64E4E1CED62626292F2B94564E5A6D2D9D6CB89964EFA834304D27C1497EB70E483B5CD7CE19A6ABEFD994A76349EA6E18353DC784539F73EBA9DAD878364E5A673B0B699B9D5A5';
wwv_flow_api.g_varchar2_table(176) := 'F8FC896CAFA9C3EB4F625E75293D2783341E3ACAC4F8245939012AE61673A0B699FEE010E7ADAE4613D0D9768A132D5DF40787484DF387639F1A076B3F20BF288BBCA24C8E1FEDE268937E027D71791EF985994C4E4CB267473D03C14152D3932929CBC3';
wwv_flow_api.g_varchar2_table(177) := 'EB4FE4406DB33EAF0B4B39B0B79981E0302B565773BCA58B13AD9DAC58536D3D4837BC6EB13DEBC488BC84AF5FA069773DF195D93310D6AFEB111AF1085E027169CC0AB9A8A6A6125E8919348C6EC512E4FF1F5FD3C5D762356D048485660DBE4CD3B65A';
wwv_flow_api.g_varchar2_table(178) := 'BCF5CA791ECA329D381C769ADB07B9FDC17F90579A6704C1CF1A439DB63ABACC1B2CE3D1C05A8019CB774C33A76A1B6A905D1E976681C6E84E602D2AA260261303F03AF04960FC8FB75532734847308EA65D06DA37807F035C6ABABD6614DDC2128A31CE';
wwv_flow_api.g_varchar2_table(179) := '07967C5F72496AA144E1A5F85B2C6AB0CC989026439D7E8C747A0568AAA053657FA4261578B57A26A45C472D3A21572078F5C010079EDA4BCF491D00E84B4BA6B028CBB442B518E42E22B82F2DBC30E6B63751B366FF6D12062B528E40864FCBF8ABC8C1';
wwv_flow_api.g_varchar2_table(180) := '941AF23BA45C054D1AAF11EF949025B20354CF103688CBA6C456CD827B024635B4EF010F111BE717A38C9151A14D3C2434ED6F08F1250DD6084495E91E3671572A024218EE7E1D766CC175590ABACAD59015DB528B3A2ECF2C99A3592AF546C21F9A9082';
wwv_flow_api.g_varchar2_table(181) := 'ADB1F40611137D213411B3AE3D168FBC2CFAE72D2A33C719151B440D726A2A5C1B54648726C1511487A5A606CC8DE090882121228412514DC2017CCD7A784304512179F265EE1761819A9022084ACE83A8131A5B35C1E302D12823F066D4B13EBE3EBEFE';
wwv_flow_api.g_varchar2_table(182) := 'B72EDBC753F0F1F531617D7C7D4C581F5FFFB7AFFF3F0001B8217929C0CB820000000049454E44AE426082';
end;
/
begin
wwv_flow_api.create_theme_image(
  p_id =>29480427030167238 + wwv_flow_api.g_id_offset,
  p_flow_id =>wwv_flow.g_flow_id,
  p_theme_id  => wwv_flow.g_flow_theme_id,
  p_varchar2_table=> wwv_flow_api.g_varchar2_table,
  p_mimetype=> '');
end;
/
commit;
begin 
execute immediate 'begin dbms_session.set_nls( param => ''NLS_NUMERIC_CHARACTERS'', value => '''''''' || replace(wwv_flow_api.g_nls_numeric_chars,'''''''','''''''''''') || ''''''''); end;';
end;
/
set verify on
set feedback on
prompt  ...done
