
INSERT INTO ui.dashboard (idashboardid, bactive, bdelete, vcdashboardname, iorder, irowcount, imenustructuredesc, itenantid, bdynamic) 
SELECT 70, true, false, 'Audit Report - Lists', 33, 1, 577, t.itenantid, true FROM ui.tenants t WHERE itenantid > 0 ;

INSERT INTO ui.dashboardquery (idashboardqueryid, bparametersrequired, vcfilterparametersjson, vcdashboardquery, formattingrequiered, runonanalytics, transposerequired, imenustructuredesc, itenantid) 
	SELECT 146, true, '{ "DateRange": null }','SELECT 
  i.ilistitemauditid as "List item id", 
  i.ilisttype as "List Type",  
  makeruser.vcusername as "Maker User", 
  i.dtentrystamp as "Maker Time Stamp", 
  i.vcremark as "Remarks", 
  checkeruser.vcusername as "Checker User", 
  i.dtapproverstamp as "Checker Time Stamp", 
  i.vcfield as "Field",
  i.vcvalue as "Value",
  i.attribs as "Attributes",
  i.vcnote as  "Note",
	i.vcsource as "Source",
	i.dteffectivefrom as "Effective From",
	i.dtexpiresat as "Expires At",
	i.irecordstatus as "Record Status"
FROM 
	ui.listaudit i 
  left join ui.webuser makeruser on makeruser.iuserid = i.ientryuserid 
  left join ui.webuser checkeruser on checkeruser.iuserid = i.iapproveruserid 
where 
  i.itenantid = :tenantid 
  and cast(i.dtentrystamp as date) between cast(:StartDate as date) 
  and cast(:EndDate as date) limit 10000;', false, false, false, 577,  t.itenantid FROM ui.tenants t WHERE itenantid > 0 ;

INSERT INTO ui.dashboardresultset (idashboardresultsetid, iresultsetorder, vcdashboardresultsetcolumnjson, vcdashboardresultsetlayout, vcdashboardresultsetname, idashboardqueryid, idashboardid, vcdashboardresultsetschema, icolsize, irowno, dtlastupdatedtimestamp, iuserid, imenustructuredesc, itenantid, iorgid)
SELECT 229, NULL, NULL, '{"sizes":[1],"detail":{"main":{"type":"tab-area","widgets":["PERSPECTIVE_GENERATED_ID_1"],"currentIndex":0}},"mode":"globalFilters","viewers":{"PERSPECTIVE_GENERATED_ID_1":{"plugin":"Datagrid","plugin_config":{"columns":{},"editable":false,"scroll_lock":false},"settings":false,"theme":"Pro Dark","title":"Audit Report - List","group_by":[],"split_by":[],"columns":[],"filter":[],"sort":[],"expressions":[],"aggregates":{},"master":false,"table":"auditreportlist","linked":false}}}',
	'auditreportlist', 146, 70, '{
   "List item id":"integer",
	"List Type": "integer",
	"Record Status": "integer",
  "Maker User":"string",
  "Remarks":"string",
  "Checker User":"string",
  "Field":"string",
  "Value":"string",
	"Attributes":"string",
	"Note":"string",
	"Source":"string",
  "Maker Time Stamp":"datetime",
  "Checker Time Stamp":"datetime",
	"Effective From":"datetime",
  "Expires At":"datetime"
}', NULL, 1, NULL, NULL, 577, t.itenantid, o.iorgid FROM ui.tenants t join ui.orgs o on t.iorgid=o.iorgid WHERE itenantid > 0;

INSERT INTO ui.dashboardfilters (idashboardfilterid, ifilterorder, vcdashboardfiltername, idashboardid, vcdashboardfiltertype, idashboardqueryidfordefaultvalue, idashboardqueryidforoptions, itenantid, vcdashboardfilterdisplayname)
	SELECT 183 , 0, 'DateRange', 70, 'DateRangePicker', 79, NULL, t.itenantid, 'Date Range' FROM ui.tenants t WHERE itenantid > 0;


INSERT INTO ui.dashboardqueryparameters (idashboardparameterid, vcparametername, vcparametertype, idashboardqueryid, iorder, itenantid) 
	SELECT 294 , 'DateRange', 'DateRange',146 ,null , t.itenantid FROM ui.tenants t WHERE itenantid > 0;
