set define '^' verify off feedback off

Rem  Copyright (c) Oracle Corporation 2012 - 2014. All Rights Reserved.
Rem
Rem    NAME
Rem      dbpod_install_applications.sql
Rem
Rem    DESCRIPTION
Rem    Install packaged and sample applications as template applications during APEX installation.
Rem
Rem    MODIFIED     (MM/DD/YYYY)
Rem    hfarrell      05/15/2012 - Created - based on cloud_ga/dbservice/pod_internal/template_apps/dbpod_install_applications.sql
Rem    hfarrell      05/15/2012 - Copied INHERIT PRIVILEGES logic from /core/apex_install_sample_app.sql
Rem    hfarrell      05/29/2012 - Uncommented the following list of applications following request from Marc:
Rem                               Opportunity Tracker,Campaign Manager,Asset Manager,Data Model Repository Viewer, Survey Builder,
Rem                               Sample Lists,Sample Collections,Sample Timezone,Sample Files,Sample Access Control,Sample Build Options,
Rem                               Service Notifications,Service Notifications Admin
Rem    jkallman      06/01/2012 - Clear out globals at end of script
Rem    hfarrell      06/18/2012 - Removed 8951 - old Collections Showcase application
Rem    vuvarov       07/24/2012 - Removed 7180 (Feedback)
Rem    hfarrell      07/30/2012 - Added 7650 (Go Live Check List) as requested by Mike
Rem    vuvarov       08/13/2012 - Removed 7620 and 7630 (Service Notifications)
Rem    vuvarov       08/23/2012 - Changed 7650 and 7890 to be locked on install
Rem    vuvarov       11/02/2012 - Set g_import_in_progress (bug 14645890)
Rem    hfarrell      11/20/2012 - Renamed Sample Database Application export file reference from sample_app.sql to f8950.sql
Rem    vuvarov       12/07/2012 - Removed application 7280
Rem    hfarrell      02/19/2013 - Added Survey Builder (7280) and Data Reporter (7250) for 4.2.2
Rem    hfarrell      02/26/2013 - Added Sample RESTful Services (7980) for 4.2.2
Rem    hfarrell      03/26/2013 - Removed Data Reporter (7250) from 4.2.2
Rem    hfarrell      07/16/2013 - Reintroduced Data Reporter (7250) for 4.2.3
Rem    hfarrell      10/22/2013 - Added Live Poll (7340) and Standards Tracker (7260) for 4.2.4
Rem    hfarrell      11/12/2013 - Removed Live Poll (7340)
Rem    hfarrell      01/14/2014 - Added Live Poll (7340) and Geolocation Showcase (7160) for 4.2.5
Rem    vuvarov       01/28/2014 - Reordered installation based on application IDs
Rem    hfarrell      02/04/2014 - Removed Campaign Manager (7000), Asset Manager (7020) ,Data Model Repository Viewer (7239) 
Rem                               Sample Access Control (7600), Sample Build Options (7610), Sample Timezone (7950) from 4.2.5, as not even exposed in packaged app metadata 
Rem    hfarrell      03/15/2014 - Changed build_status from RUN_AND_HIDDEN to RUN_AND_BUILD for Sample Geolocation Showcase (7160)

begin
    execute immediate 'grant inherit privileges on user SYS to ^APPUN';
exception
    when others then
        if sqlcode <> -990 then
            raise;
        end if;
end;
/

prompt Application Express Packaged and Sample Applications installation data

prompt
prompt ...Remove existing packaged applications from SGID11 workspace
prompt
declare
    c_old_import_in_progress constant boolean := wwv_flow.g_import_in_progress;
begin
    wwv_flow_api.set_security_group_id(11);
    wwv_flow.g_import_in_progress := true;

    -- Remove Database Applications
    for c1 in (select id
                 from wwv_flows
                where security_group_id = 11
                  and id >= 7000 and id < 8000
                  or id in (8950,8951) ) loop
        --
        wwv_flow_api.remove_flow(  c1.id );
    end loop;

    -- Remove Websheet Applications
    for c2 in (select id
                 from wwv_flow_ws_applications
                where security_group_id = 11
                  and id in (1097894920371103914,1097895031667104017) ) loop
        --
        wwv_flow_pkg_app_install.deinstall_websheet(  c2.id );
    end loop;
    commit;

    wwv_flow.g_import_in_progress := c_old_import_in_progress;
end;
/

begin
    wwv_flow_api.set_security_group_id(11);
    wwv_flow_application_install.set_workspace_id(11);
    wwv_flow_application_install.set_application_id(null);
    wwv_flow_application_install.generate_offset;
    wwv_flow_application_install.set_schema( wwv_flow.g_flow_schema_owner );
    wwv_flow_application_install.set_image_prefix( wwv_flow_global.g_image_prefix );
end;
/

prompt
prompt ...Decision Manager installation data: Application ID 7010
prompt

@@f7010.sql

update wwv_flows
   set application_type = 'TEMPLATE_HIDDEN',
       build_status = 'RUN_AND_HIDDEN'
 where id = 7010
   and security_group_id = 11;
commit;


prompt
prompt ...Opportunity Tracker installation data: Application ID 7050
prompt

@@f7050.sql

update wwv_flows
   set application_type = 'TEMPLATE_HIDDEN',
       build_status = 'RUN_AND_HIDDEN'
 where id = 7050
   and security_group_id = 11;
commit;


prompt
prompt ...Bug Tracker installation data: Application ID 7060
prompt

@@f7060.sql

update wwv_flows
   set application_type = 'TEMPLATE_HIDDEN',
       build_status = 'RUN_AND_HIDDEN'
 where id = 7060
   and security_group_id = 11;
commit;


prompt
prompt ...Group Calendar installation data: Application ID 7090
prompt

rem @@f7090.sql

update wwv_flows
   set application_type = 'TEMPLATE_HIDDEN',
       build_status = 'RUN_AND_HIDDEN'
 where id = 7090
   and security_group_id = 11;
commit;


prompt
prompt ...Artwork Catalog installation data: Application ID 7100
prompt

@@f7100.sql

update wwv_flows
   set application_type = 'TEMPLATE_HIDDEN',
       build_status = 'RUN_AND_HIDDEN'
 where id = 7100
   and security_group_id = 11;
commit;


prompt
prompt ...Expertise Tracker installation data: Application ID 7120
prompt

@@f7120.sql

update wwv_flows
   set application_type = 'TEMPLATE_HIDDEN',
       build_status = 'RUN_AND_HIDDEN'
 where id = 7120
   and security_group_id = 11;
commit;


prompt
prompt ...Community Requests installation data: Application ID 7130
prompt

@@f7130.sql

update wwv_flows
   set application_type = 'TEMPLATE_HIDDEN',
       build_status = 'RUN_AND_HIDDEN'
 where id = 7130
   and security_group_id = 11;
commit;


prompt
prompt ...Incident Tracking installation data: Application ID 7140
prompt

@@f7140.sql

update wwv_flows
   set application_type = 'TEMPLATE_HIDDEN',
       build_status = 'RUN_AND_HIDDEN'
 where id = 7140
   and security_group_id = 11;
commit;


prompt
prompt ...Systems Catalog installation data: Application ID 7150
prompt

@@f7150.sql

update wwv_flows
   set application_type = 'TEMPLATE_HIDDEN',
       build_status = 'RUN_AND_HIDDEN'
 where id = 7150
   and security_group_id = 11;
commit;


prompt
prompt ...Geolocation Showcase installation data: Application ID 7160
prompt

@@f7160.sql

update wwv_flows
   set application_type = 'TEMPLATE_HIDDEN',
       build_status = 'RUN_AND_BUILD'
 where id = 7160
   and security_group_id = 11;
commit;


prompt
prompt ...Customer Tracker installation data: Application ID 7170
prompt

rem @@f7170.sql

update wwv_flows
   set application_type = 'TEMPLATE_HIDDEN',
       build_status = 'RUN_AND_HIDDEN'
 where id = 7170
   and security_group_id = 11;
commit;


prompt
prompt ...Issue Tracker installation data: Application ID 7190
prompt

@@f7190.sql

update wwv_flows
   set application_type = 'TEMPLATE_HIDDEN',
       build_status = 'RUN_AND_HIDDEN'
 where id = 7190
   and security_group_id = 11;
commit;


prompt
prompt ...P-Track installation data: Application ID 7220
prompt

@@f7220.sql

update wwv_flows
   set application_type = 'TEMPLATE_HIDDEN',
       build_status = 'RUN_AND_HIDDEN'
 where id = 7220
   and security_group_id = 11;
commit;


prompt
prompt ...Checklist Manager installation data: Application ID 7240
prompt

@@f7240.sql

update wwv_flows
   set application_type = 'TEMPLATE_HIDDEN',
       build_status = 'RUN_AND_HIDDEN'
 where id = 7240
   and security_group_id = 11;
commit;


prompt
prompt ...Data Reporter installation data: Application ID 7250
prompt

@@f7250.sql

update wwv_flows
   set application_type = 'TEMPLATE_HIDDEN',
       build_status = 'RUN_AND_HIDDEN'
 where id = 7250
   and security_group_id = 11;
commit;


prompt
prompt ...Standards Tracker installation data: Application ID 7260
prompt

@@f7260.sql

update wwv_flows
   set application_type = 'TEMPLATE_HIDDEN',
       build_status = 'RUN_AND_HIDDEN'
 where id = 7260
   and security_group_id = 11;
commit;


prompt
prompt ...Application Archive installation data: Application ID 7270
prompt

@@f7270.sql

update wwv_flows
   set application_type = 'TEMPLATE_HIDDEN',
       build_status = 'RUN_AND_HIDDEN'
 where id = 7270
   and security_group_id = 11;
commit;


prompt
prompt ...Survey Builder installation data: Application ID 7280
prompt

@@f7280.sql

update wwv_flows
   set application_type = 'TEMPLATE_HIDDEN',
       build_status = 'RUN_AND_HIDDEN'
 where id = 7280
   and security_group_id = 11;
commit;


prompt
prompt ...Meeting Minutes installation data: Application ID 7290
prompt

@@f7290.sql

update wwv_flows
   set application_type = 'TEMPLATE_HIDDEN',
       build_status = 'RUN_AND_HIDDEN'
 where id = 7290
   and security_group_id = 11;
commit;


prompt
prompt ...Use Case Status installation data: Application ID 7300
prompt

@@f7300.sql

update wwv_flows
   set application_type = 'TEMPLATE_HIDDEN',
       build_status = 'RUN_AND_HIDDEN'
 where id = 7300
   and security_group_id = 11;
commit;


prompt
prompt ...Live Poll installation data: Application ID 7340
prompt

rem @@f7340.sql

update wwv_flows
   set application_type = 'TEMPLATE_HIDDEN',
       build_status = 'RUN_AND_HIDDEN'
 where id = 7340
   and security_group_id = 11;
commit;


prompt
prompt ...Go Live Check List: Application ID 7650
prompt

rem @@f7650.sql

update wwv_flows
   set application_type = 'TEMPLATE_HIDDEN',
       build_status = 'RUN_AND_HIDDEN'
 where id = 7650
   and security_group_id = 11;
commit;


prompt
prompt ...Mobile Sample: Application ID 7800
prompt

rem @@f7800.sql

update wwv_flows
   set application_type = 'TEMPLATE_HIDDEN',
       build_status = 'RUN_AND_BUILD'
 where id = 7800
   and security_group_id = 11;
commit;


prompt
prompt ...Sample Interactive Report: Application ID 7810
prompt

rem @@f7810.sql

update wwv_flows
   set application_type = 'TEMPLATE_HIDDEN',
       build_status = 'RUN_AND_BUILD'
 where id = 7810
   and security_group_id = 11;
commit;


prompt
prompt ...Sample Calendar: Application ID 7820
prompt

rem @@f7820.sql

update wwv_flows
   set application_type = 'TEMPLATE_HIDDEN',
       build_status = 'RUN_AND_BUILD'
 where id = 7820
   and security_group_id = 11;
commit;


prompt
prompt ...Sample Charts: Application ID 7830
prompt

rem @@f7830.sql

update wwv_flows
   set application_type = 'TEMPLATE_HIDDEN',
       build_status = 'RUN_AND_BUILD'
 where id = 7830
   and security_group_id = 11;
commit;


prompt
prompt ...Sample Dynamic Actions: Application ID 7840
prompt

rem @@f7840.sql

update wwv_flows
   set application_type = 'TEMPLATE_HIDDEN',
       build_status = 'RUN_AND_BUILD'
 where id = 7840
   and security_group_id = 11;
commit;


prompt
prompt ...Sample Data Loading: Application ID 7850
prompt

rem @@f7850.sql

update wwv_flows
   set application_type = 'TEMPLATE_HIDDEN',
       build_status = 'RUN_AND_BUILD'
 where id = 7850
   and security_group_id = 11;
commit;


prompt
prompt ...Sample Master Detail: Application ID 7860
prompt

rem @@f7860.sql

update wwv_flows
   set application_type = 'TEMPLATE_HIDDEN',
       build_status = 'RUN_AND_BUILD'
 where id = 7860
   and security_group_id = 11;
commit;


prompt
prompt ...Sample Tabular Form: Application ID 7870
prompt

rem @@f7870.sql

update wwv_flows
   set application_type = 'TEMPLATE_HIDDEN',
       build_status = 'RUN_AND_BUILD'
 where id = 7870
   and security_group_id = 11;
commit;


prompt
prompt ...Sample Search: Application ID 7880
prompt

rem @@f7880.sql

update wwv_flows
   set application_type = 'TEMPLATE_HIDDEN',
       build_status = 'RUN_AND_BUILD'
 where id = 7880
   and security_group_id = 11;
commit;


prompt
prompt ...Feedback: Application ID 7890
prompt

rem @@f7890.sql

update wwv_flows
   set application_type = 'TEMPLATE_HIDDEN',
       build_status = 'RUN_AND_HIDDEN'
 where id = 7890
   and security_group_id = 11;
commit;


prompt
prompt ...Sample Dialog: Application ID 7900
prompt

rem @@f7900.sql

update wwv_flows
   set application_type = 'TEMPLATE_HIDDEN',
       build_status = 'RUN_AND_BUILD'
 where id = 7900
   and security_group_id = 11;
commit;


prompt
prompt ...Sample Trees: Application ID 7910
prompt

rem @@f7910.sql

update wwv_flows
   set application_type = 'TEMPLATE_HIDDEN',
       build_status = 'RUN_AND_BUILD'
 where id = 7910
   and security_group_id = 11;
commit;


prompt
prompt ...Sample Lists: Application ID 7920
prompt

rem @@f7920.sql

update wwv_flows
   set application_type = 'TEMPLATE_HIDDEN',
       build_status = 'RUN_AND_BUILD'
 where id = 7920
   and security_group_id = 11;
commit;


prompt
prompt ...Sample Wizard: Application ID 7930
prompt

rem @@f7930.sql

update wwv_flows
   set application_type = 'TEMPLATE_HIDDEN',
       build_status = 'RUN_AND_BUILD'
 where id = 7930
   and security_group_id = 11;
commit;


prompt
prompt ...Sample Collections: Application ID 7940
prompt

rem @@f7940.sql

update wwv_flows
   set application_type = 'TEMPLATE_HIDDEN',
       build_status = 'RUN_AND_BUILD'
 where id = 7940
   and security_group_id = 11;
commit;


prompt
prompt ...Sample Files: Application ID 7960
prompt

rem @@f7960.sql

update wwv_flows
   set application_type = 'TEMPLATE_HIDDEN',
       build_status = 'RUN_AND_BUILD'
 where id = 7960
   and security_group_id = 11;
commit;


prompt
prompt ...Sample RESTful Services: Application ID 7980
prompt

rem @@f7980.sql

update wwv_flows
   set application_type = 'TEMPLATE_HIDDEN',
       build_status = 'RUN_AND_BUILD'
 where id = 7980
   and security_group_id = 11;
commit;


prompt
prompt ...Product Portal Sample Database Application installation data: Application ID 8950
prompt

rem @@f8950.sql

update wwv_flows
   set application_type = 'TEMPLATE_HIDDEN'
 where id = 8950
   and security_group_id = 11;
commit;


begin
    sys.dbms_utility.compile_schema( wwv_flow.g_flow_schema_owner, FALSE );
end;
/


-- Websheet Application Installation Prerequisities
prompt
prompt ...AnyCo IT Department Websheet installation data: Application ID 1097894920371103914
prompt

begin
    wwv_flow_application_install.set_application_id(1097894920371103914);
    wwv_flow_api.set_security_group_id(11);
    wwv_flow_application_install.set_workspace_id(11);
    wwv_flow_application_install.generate_offset;
    wwv_flow_application_install.set_schema(wwv_flow.g_flow_schema_owner);
end;
/

@@anyco_ws.sql

update wwv_flow_ws_applications
   set application_type = 'SAMPLE'
 where id = wwv_flow_application_install.get_application_id
   and security_group_id = 11;
commit;


prompt
prompt ...Big Cats Websheet installation data: Application ID 1097895031667104017
prompt
begin
    wwv_flow_application_install.set_application_id(1097895031667104017);
end;
/

@@cats_ws.sql

update wwv_flow_ws_applications
   set application_type = 'SAMPLE'
 where id = wwv_flow_application_install.get_application_id
   and security_group_id = 11;
commit;


prompt
prompt ...Update application names in SGID11 workspace
prompt
begin
    update wwv_flows
       set name = regexp_replace(name, '[* ]+$', '')
     where security_group_id = 11
       and id >= 7000 and id < 8000;

    commit;
end;
/

--
--  Clear out application globals, so this avoids any downstream effect
begin
    wwv_flow_application_install.clear_all;
end;
/

set verify off feedback on
prompt  ...done
