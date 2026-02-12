
INSERT INTO ui.menustructuredesc (
imenuid, bcollapse, isortorder, vcaction, vccontroller, vclayout, vcmenuname, vcmini, vcpath, iparentmenu, istatus) VALUES (
'577'::integer, false::boolean, '3'::integer, 'AdminReports'::character varying, 'AdminReports'::character varying, '/user'::character varying, 'Admin Reports'::character varying, 'AR'::character varying, '/admin/reports'::character varying, '482'::integer, '1'::integer)
 returning imenuid;

INSERT INTO ui.rolemenuaccessmap (
badd, bapprove, bdelete, bedit, bpublish, bview, istatus, imenuid, iroleid) VALUES (
true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, '577'::integer, '1'::integer)
 returning irolemenumapid;

INSERT INTO ui.dashboardquery (
idashboardqueryid, bparametersrequired, vcdashboardquery, formattingrequiered, runonanalytics) VALUES (
'79'::integer, false::boolean, 'SELECT (NOW()) as "startdate", (NOW() - interval ''1 day'') as "enddate";'::text, false::boolean, false::boolean)
 returning idashboardqueryid;

INSERT INTO ui.dashboard (
idashboardid, bactive, bdelete, vcdashboardname, iorder, irowcount, imenustructuredesc) VALUES (
'24'::integer, true::boolean, false::boolean, 'Txn Count Report'::character varying, '1'::integer, '1'::integer, '577'::integer)
 returning idashboardid;

INSERT INTO ui.dashboardfilters (
idashboardfilterid, ifilterorder, vcdashboardfiltername, idashboardid, vcdashboardfiltertype, idashboardqueryidfordefaultvalue, vcdashboardfilterdisplayname) VALUES (
'55'::integer, '0'::integer, 'DateRange'::character varying, '24'::integer, 'DateRangePicker'::character varying, '79'::integer, 'Date Range'::character varying)
 returning idashboardfilterid;


INSERT INTO ui.dashboardquery (
idashboardqueryid, bparametersrequired, vcfilterparametersjson, vcdashboardquery, formattingrequiered, runonanalytics, transposerequired, imenustructuredesc) VALUES (
'80'::integer, true::boolean, '{"DateRange":null}'::text, 'select cast(dttrxntime as date) as "Date", vcclassname as "Class", count(*) as "Txn Count" from transactions.trans where cast(dttrxntime as date) between cast(:StartDate as date) and cast(:EndDate as date) group by cast(dttrxntime as date), vcclassname;'::text, false::boolean, true::boolean, false::boolean, '577'::integer)
 returning idashboardqueryid;

INSERT INTO ui.dashboardresultset (
idashboardresultsetid, vcdashboardresultsetlayout, vcdashboardresultsetname, idashboardqueryid, idashboardid, vcdashboardresultsetschema, irowno, imenustructuredesc) VALUES (
'35'::integer, '{"sizes":[1],"detail":{"main":{"type":"tab-area","widgets":["PERSPECTIVE_GENERATED_ID_1"],"currentIndex":0}},"mode":"globalFilters","viewers":{"PERSPECTIVE_GENERATED_ID_1":{"plugin":"Datagrid","plugin_config":{"columns":{},"editable":false,"scroll_lock":false},"settings":false,"theme":"Pro Dark","title":"Txn Count Report","group_by":[],"split_by":[],"columns":["Date", "Class", "Txn Count"],"filter":[],"sort":[],"expressions":[],"aggregates":{},"master":false,"table":"transaction","linked":false}}}
'::text, 'transaction'::character varying, '80'::integer, '24'::integer, '{"Date":"date", "Class":"string", "Txn Count":"integer"}'::text, '1'::integer, '577'::integer)
 returning idashboardresultsetid;

INSERT INTO ui.dashboardqueryparameters (
idashboardparameterid, vcparametername, vcparametertype, idashboardqueryid) VALUES (
'126'::integer, 'DateRange'::character varying, 'DateRange'::character varying, '80'::integer)
 returning idashboardparameterid;