INSERT INTO ui.dashboard (
idashboardid, bactive, bdelete, vcdashboardname, iorder, irowcount, imenustructuredesc, itenantid, bdynamic) VALUES (
'83'::integer, true::boolean, false::boolean, 'Audit Report - Activity Log DL'::character varying, '33'::integer, '1'::integer, '577'::integer, '14'::integer, true::boolean)
 returning idashboardid,itenantid;

INSERT INTO ui.dashboardquery (
idashboardqueryid, bparametersrequired, vcfilterparametersjson, vcdashboardquery, formattingrequiered, runonanalytics, transposerequired, imenustructuredesc, itenantid, dbtype) VALUES (
'175'::integer, true::boolean, '{  "DateRange": null }'::text, 'SELECT makeruser.vcusername as "User Name", r.dtactivity  as  "Time stamp", r.vcactivity as "UI", r.vcparameters as "Query Parameter" FROM t14refined.ui.activitylog r left join postgresql.ui.webuser makeruser on makeruser.iuserid = r.iuserid where makeruser.iuserid in (select webuserid from postgresql.ui.webusermapping where mappingid = :tenantid and mappingtype = ''Tenant'') and r.dtactivity between :StartDate and :EndDate  limit 50000'::text, false::boolean, false::boolean, false::boolean, '577'::integer, '14'::integer, '3'::integer)
 returning idashboardqueryid,itenantid;

INSERT INTO ui.dashboardresultset (
idashboardresultsetid, vcdashboardresultsetlayout, vcdashboardresultsetname, idashboardqueryid, idashboardid, vcdashboardresultsetschema, irowno, imenustructuredesc, itenantid) VALUES (
(SELECT max(idashboardresultsetid)+1 FROM ui.dashboardresultset), '{"sizes":[1],"detail":{"main":{"type":"tab-area","widgets":["PERSPECTIVE_GENERATED_ID_1"],"currentIndex":0}},"mode":"globalFilters","viewers":{"PERSPECTIVE_GENERATED_ID_1":{"plugin":"Datagrid","plugin_config":{"columns":{},"editable":false,"scroll_lock":false},"settings":false,"theme":"Pro Dark","title":"Audit Report - Activity Log","group_by":[],"split_by":[],"columns":[],"filter":[],"sort":[],"expressions":[],"aggregates":{},"master":false,"table":"auditreportactivitylog","linked":false}}}'::text, 'auditreportactivitylog'::character varying, '175'::integer, '83'::integer, '{
    "User Name":"string",
    "Time stamp":"datetime",
    "UI":"string",
    "Query Parameter":"string"
}'::text, '1'::integer, '577'::integer, '14'::integer)
 returning idashboardresultsetid,itenantid;

 INSERT INTO ui.dashboardqueryparameters (idashboardparameterid,
vcparametername, vcparametertype, idashboardqueryid, itenantid) VALUES (
( SELECT max(idashboardparameterid) +1 FROM ui.dashboardqueryparameters) ,'DateRange'::character varying, 'DateRange'::character varying, '175'::integer, '14'::integer)
 returning idashboardparameterid,itenantid;

 INSERT INTO ui.dashboardfilters (
idashboardfilterid, ifilterorder, vcdashboardfiltername, idashboardid, vcdashboardfiltertype, idashboardqueryidfordefaultvalue, itenantid, vcdashboardfilterdisplayname) VALUES (
(SELECT max(idashboardfilterid)+1 FROM ui.dashboardfilters), '0'::integer, 'DateRange'::character varying, '83'::integer, 'DateRangePicker'::character varying, '79'::integer, '14'::integer, 'Date Range'::character varying)
 returning idashboardfilterid,itenantid;

UPDATE ui.dashboardquery SET
vcdashboardquery = ' SELECT makeruser.vcusername as "User Name", r.dtactivity  as  "Time stamp", r.vcactivity as "UI", r.vcparameters as "Query Parameter" FROM t14refined.ui.activitylog r left join postgresql.ui.webuser makeruser on makeruser.iuserid = r.iuserid where makeruser.iuserid in (select webuserid from postgresql.ui.webusermapping where mappingid = :tenantid and mappingtype = ''Tenant'') and r.dtactivity between :StartDate and :EndDate  limit 50000'::text WHERE
idashboardqueryid = 175 AND itenantid = 14;
