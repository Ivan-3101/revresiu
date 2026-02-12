UPDATE ui.dashboardquery SET
vcdashboardquery = 'SELECT d.vcdecisionname as "Decision Name", r.iruleid as "Rule ID", r.vcrulename as "Rule Name", makeruser.vcusername as "Maker User", r.dtentrystamp at time zone ''asia/kolkata'' as "Maker Time Stamp", r.vcremark as "Maker & Checker Remarks", checkeruser.vcusername as "Checker User", r.dtapproverstamp at time zone ''asia/kolkata'' as "Checker Time Stamp", case when r.vcaction = ''A'' then ''Add'' when r.vcaction = ''M'' then ''Modify'' when r.vcaction = ''X'' then ''Delete'' when r.vcaction = ''N'' then ''No Change'' end as "Action", iversion as "Rule Version", vclabel as "Rule Label", vcruledescription as "Rule Description", vcruledetail as "Rule Detail", vcruleparams as "Rule Params", vcruleorder as "Rule Order" FROM ui.rulesaudit r inner join ui.decisions d on r.idecisionid = d.idecisionid left join ui.webuser makeruser on makeruser.iuserid = r.ientryuserid left join ui.webuser checkeruser on checkeruser.iuserid = r.iapproveruserid where cast(r.dtentrystamp as date) between cast(:StartDate as date) and cast(:EndDate as date)-1;'::text WHERE
idashboardqueryid = 82;


INSERT INTO ui.dashboard (
idashboardid, bactive, bdelete, vcdashboardname, iorder, irowcount, imenustructuredesc) VALUES (
'26'::integer, true::boolean, false::boolean, 'Audit Report - Class'::character varying, '26'::integer, '1'::integer, '577'::integer)
 returning idashboardid;


INSERT INTO ui.dashboardfilters (
idashboardfilterid, ifilterorder, vcdashboardfiltername, idashboardid, vcdashboardfiltertype, idashboardqueryidfordefaultvalue, vcdashboardfilterdisplayname) VALUES (
'57'::integer, '0'::integer, 'DateRange'::character varying, '26'::integer, 'DateRangePicker'::character varying, '79'::integer, 'Date Range'::character varying)
 returning idashboardfilterid;


INSERT INTO ui.dashboardquery (
idashboardqueryid, bparametersrequired, vcfilterparametersjson, vcdashboardquery, formattingrequiered, runonanalytics, transposerequired, imenustructuredesc) VALUES (
'83'::integer, true::boolean, '{  "DateRange": null }'::text, 'SELECT r.vcclassname as "Class Name", r.iclassid as "Class ID", d.vcdecisionname as "Decision Name", p.vcproductname as "Product Name", c.vcchannelname as "Channel Name", makeruser.vcusername as "Maker User", r.dtentrystamp at time zone ''asia/kolkata'' as "Maker Time Stamp", r.vcremark as "Maker & Checker Remarks", checkeruser.vcusername as "Checker User", r.dtapproverstamp at time zone ''asia/kolkata'' as "Checker Time Stamp", case when r.vcaction = ''A'' then ''Add'' when r.vcaction = ''M'' then ''Modify'' when r.vcaction = ''X'' then ''Delete'' when r.vcaction = ''N'' then ''No Change'' end as "Action", r.bpayeemandatory as	"Payee Mandatory", r.bpayermandatory  as "Payer Mandatory", cast(r.vcdecisionparams as text)   as "Decision Parameters", r.skipprocessing   as "Skip Processing" FROM ui.transactionclassesaudit r left join ui.decisions d on r.idecisionid = d.idecisionid left join masters.products p on r.iproductid = p.iproductid left join masters.channels c on r.ichannelid = c.ichannelid left join ui.webuser makeruser on makeruser.iuserid = r.ientryuserid left join ui.webuser checkeruser on checkeruser.iuserid = r.iapproveruserid where cast(r.dtentrystamp as date) between cast(:StartDate as date) and cast(:EndDate as date)-1;'::text, false::boolean, false::boolean, false::boolean, '577'::integer)
 returning idashboardqueryid;


INSERT INTO ui.dashboardresultset (
idashboardresultsetid, vcdashboardresultsetlayout, vcdashboardresultsetname, idashboardid, vcdashboardresultsetschema, irowno, imenustructuredesc, idashboardqueryid) VALUES (
'38'::integer, '{"sizes":[1],"detail":{"main":{"type":"tab-area","widgets":["PERSPECTIVE_GENERATED_ID_1"],"currentIndex":0}},"mode":"globalFilters","viewers":{"PERSPECTIVE_GENERATED_ID_1":{"plugin":"Datagrid","plugin_config":{"columns":{},"editable":false,"scroll_lock":false},"settings":false,"theme":"Pro Dark","title":"Audit Report - Class","group_by":[],"split_by":[],"columns":[],"filter":[],"sort":[],"expressions":[],"aggregates":{},"master":false,"table":"auditreportclass","linked":false}}}'::text, 'auditreportclass'::character varying, '26'::integer, '{
    "Class Name":"string",
    "Class ID":"integer",
    "Decision Name":"string",
    "Product Name": "integer",
    "Channel Name":"integer",
    "Maker User":"string",
    "Maker Time Stamp":"datetime",
    "Maker & Checker Remarks":"string",
    "Checker User":"string",
    "Checker Time Stamp": "datetime",
    "Action": "string",
    "Payee Mandatory":"boolean",
    "Payer Mandatory":"boolean",
    "Decision Parameters":"string",
    "Skip Processing":"integer"
}
'::text, '1'::integer, '577'::integer, '83'::integer)
 returning idashboardresultsetid;


INSERT INTO ui.dashboardqueryparameters (
idashboardparameterid, vcparametername, vcparametertype, idashboardqueryid) VALUES (
'128'::integer, 'DateRange'::character varying, 'DateRange'::character varying, '83'::integer)
 returning idashboardparameterid;




INSERT INTO ui.dashboard (
idashboardid, bactive, bdelete, vcdashboardname, iorder, irowcount, imenustructuredesc) VALUES (
'32'::integer, true::boolean, false::boolean, 'Audit Report - Activity Log'::character varying, '32'::integer, '1'::integer, '577'::integer)
 returning idashboardid;


INSERT INTO ui.dashboard (
idashboardid, bactive, bdelete, vcdashboardname, iorder, irowcount, imenustructuredesc) VALUES (
'31'::integer, true::boolean, false::boolean, 'Audit Report - Metadata'::character varying, '31'::integer, '1'::integer, '577'::integer)
 returning idashboardid;

INSERT INTO ui.dashboard (
idashboardid, bactive, bdelete, vcdashboardname, iorder, irowcount, imenustructuredesc) VALUES (
'30'::integer, true::boolean, false::boolean, 'Audit Report - User'::character varying, '30'::integer, '1'::integer, '577'::integer)
 returning idashboardid;

INSERT INTO ui.dashboard (
idashboardid, bactive, bdelete, vcdashboardname, iorder, irowcount, imenustructuredesc) VALUES (
'29'::integer, true::boolean, false::boolean, 'Audit Report - Observations'::character varying, '29'::integer, '1'::integer, '577'::integer)
 returning idashboardid;

INSERT INTO ui.dashboard (
idashboardid, bactive, bdelete, vcdashboardname, iorder, irowcount, imenustructuredesc) VALUES (
'28'::integer, true::boolean, false::boolean, 'Audit Report - Windows'::character varying, '28'::integer, '1'::integer, '577'::integer)
 returning idashboardid;

INSERT INTO ui.dashboard (
idashboardid, bactive, bdelete, vcdashboardname, iorder, irowcount, imenustructuredesc) VALUES (
'27'::integer, true::boolean, false::boolean, 'Audit Report - Decision'::character varying, '27'::integer, '1'::integer, '577'::integer)
 returning idashboardid;


INSERT INTO ui.dashboardquery (
idashboardqueryid, bparametersrequired, vcfilterparametersjson, vcdashboardquery, formattingrequiered, runonanalytics, transposerequired, imenustructuredesc) VALUES (
'84'::integer, true::boolean, '{  "DateRange": null }'::text, 'SELECT r.vcdecisionname as "Decision Name", r.vcdecisiondetail as "Decision Description", r.idecisionid as "Decision ID", makeruser.vcusername as "Maker User", r.dtentrystamp at time zone ''asia/kolkata'' as "Maker Time Stamp", r.vcremark as "Maker & Checker Remarks", checkeruser.vcusername as "Checker User", r.dtapproverstamp at time zone ''asia/kolkata'' as "Checker Time Stamp", case when r.vcaction = ''A'' then ''Add'' when r.vcaction = ''M'' then ''Modify'' when r.vcaction = ''X'' then ''Delete'' when r.vcaction = ''N'' then ''No Change'' end as "Action", cast(r.vcresultparams as text) as "Decision Parameters", p.vcproductname as "Product Name", cast(r.attribs as text) as "Attributes", r.vcdecisionmapinfo as "Decision Info" FROM ui.decisionsaudit r left join masters.products p on r.iproductid = p.iproductid left join ui.webuser makeruser on makeruser.iuserid = r.ientryuserid left join ui.webuser checkeruser on checkeruser.iuserid = r.iapproveruserid where cast(r.dtentrystamp at time zone :timeZone as date) between cast(:StartDate as date) and cast(:EndDate as date)-1;'::text, false::boolean, false::boolean, false::boolean, '577'::integer)
 returning idashboardqueryid;

ALTER TABLE IF EXISTS ui.observationwindowsuiaudit
    ADD COLUMN wdesc text;


ALTER TABLE IF EXISTS ui.observationwindowsui
    ADD COLUMN wdesc text;

INSERT INTO ui.dashboardquery (
idashboardqueryid, bparametersrequired, vcfilterparametersjson, vcdashboardquery, formattingrequiered, runonanalytics, transposerequired, imenustructuredesc) VALUES (
'85'::integer, true::boolean, '{  "DateRange": null }'::text, 'SELECT r.wname as "Window Name", r.wdesc as  "Window Description", r.wid "Window ID", makeruser.vcusername as "Maker User", r.dtentrystamp at time zone ''asia/kolkata'' as "Maker Time Stamp", r.vcremark as "Maker & Checker Remarks", checkeruser.vcusername as "Checker User", r.dtapproverstamp at time zone ''asia/kolkata'' as "Checker Time Stamp", case when r.vcaction = ''A'' then ''Add'' when r.vcaction = ''M'' then ''Modify'' when r.vcaction = ''X'' then ''Delete'' when r.vcaction = ''N'' then ''No Change'' end as "Action", r.selectexpr as "Select", r.whereexpr as "Where", r.groupbyexpr as "Group By", r.wcount as "Window Count", r.wduration as "Window Duration" FROM ui.observationwindowsuiaudit r left join ui.webuser makeruser on makeruser.iuserid = r.ientryuserid left join ui.webuser checkeruser on checkeruser.iuserid = r.iapproveruserid where cast(r.dtentrystamp at time zone :timeZone as date) between cast(:StartDate as date) and cast(:EndDate as date)-1;'::text, false::boolean, false::boolean, false::boolean, '577'::integer)
 returning idashboardqueryid;


INSERT INTO ui.dashboardquery (
idashboardqueryid, bparametersrequired, vcdashboardquery, vcfilterparametersjson, formattingrequiered, runonanalytics, transposerequired, imenustructuredesc) VALUES (
'86'::integer, true::boolean, 'SELECT r.oname as "Observation Name", r.odesc as  "Observation Description", r.oid as "Observation ID", w.wname as "Window Name", makeruser.vcusername as "Maker User", r.dtentrystamp at time zone ''asia/kolkata'' as "Maker Time Stamp", r.vcremark as "Maker & Checker Remarks", checkeruser.vcusername as "Checker User", r.dtapproverstamp at time zone ''asia/kolkata'' as "Checker Time Stamp", case when r.vcaction = ''A'' then ''Add'' when r.vcaction = ''M'' then ''Modify'' when r.vcaction = ''X'' then ''Delete'' when r.vcaction = ''N'' then ''No Change'' end as "Action", cast(r.wexpr as text) as "Group By", cast(r.whereexpr as text) as "Where", r.aggregationtype as "Aggregation", r.oduration as "Duration", r.ocount as "Observation Count" FROM ui.observationsuiaudit r left join ui.observationwindowsui w on w.wid = r.wid left join ui.webuser makeruser on makeruser.iuserid = r.ientryuserid left join ui.webuser checkeruser on checkeruser.iuserid = r.iapproveruserid where cast(r.dtentrystamp at time zone :timeZone as date) between cast(:StartDate as date) and cast(:EndDate as date)-1;'::text, '{  "DateRange": null }'::text, false::boolean, false::boolean, false::boolean, '577'::integer)
 returning idashboardqueryid;


INSERT INTO ui.dashboardquery (
idashboardqueryid, bparametersrequired, vcdashboardquery, vcfilterparametersjson, formattingrequiered, runonanalytics, transposerequired, imenustructuredesc) VALUES (
'87'::integer, true::boolean, 'SELECT r.vcusername as "User Name", r.vcfirstname as  "First Name", r.vclastname as "Last Name", r.vcemailid as "Email ID", r.iuserid as "User ID", r.vcmobile as "Mobile", makeruser.vcusername as "Maker User", r.dtentrystamp at time zone ''asia/kolkata'' as "Maker Time Stamp", r.vcremark as "Maker & Checker Remarks", checkeruser.vcusername as "Checker User", r.dtapproverstamp at time zone ''asia/kolkata'' as "Checker Time Stamp", case when r.vcaction = ''A'' then ''Add'' when r.vcaction = ''M'' then ''Modify'' when r.vcaction = ''X'' then ''Delete'' when r.vcaction = ''N'' then ''No Change'' end as "Action", r.vcaddress as "Address", r.vccontact as "Contact", r.vcdesignation as "Designation" FROM ui.webuseraudit r left join ui.webuser makeruser on makeruser.iuserid = r.ientryuserid left join ui.webuser checkeruser on checkeruser.iuserid = r.iapproveruserid where cast(r.dtentrystamp at time zone :timeZone as date) between cast(:StartDate as date) and cast(:EndDate as date)-1;'::text, '{  "DateRange": null }'::text, false::boolean, false::boolean, false::boolean, '577'::integer)
 returning idashboardqueryid;



INSERT INTO ui.dashboardquery (
idashboardqueryid, bparametersrequired, vcdashboardquery, vcfilterparametersjson, formattingrequiered, runonanalytics, transposerequired, imenustructuredesc) VALUES (
'88'::integer, true::boolean, 'SELECT r.vccolumnname as "Parameter Name", r.vcdescription as  "Parameter Description", r.vcdtype as "Data Type", cast(r.vcprefix as text) as "Prefix", r.vcpath as "Path", r.vcquery as "Query", r.vcroot as "Root Level", r.bml as "ML", r.bscore as "Score", r.bui as "UI", cast(r.config as text) as "Config", makeruser.vcusername as "Maker User", r.dtentrystamp at time zone ''asia/kolkata'' as "Maker Time Stamp", r.vcremark as "Maker & Checker Remarks", checkeruser.vcusername as "Checker User", r.dtapproverstamp at time zone ''asia/kolkata'' as "Checker Time Stamp", case when r.vcaction = ''A'' then ''Add'' when r.vcaction = ''M'' then ''Modify'' when r.vcaction = ''X'' then ''Delete'' when r.vcaction = ''N'' then ''No Change'' end as "Action" FROM ui.metadataaudit r left join ui.webuser makeruser on makeruser.iuserid = r.ientryuserid left join ui.webuser checkeruser on checkeruser.iuserid = r.iapproveruserid where cast(r.dtentrystamp at time zone :timeZone as date) between cast(:StartDate as date) and cast(:EndDate as date)-1;'::text, '{  "DateRange": null }'::text, false::boolean, false::boolean, false::boolean, '577'::integer)
 returning idashboardqueryid;


INSERT INTO ui.dashboardfilters (
idashboardfilterid, ifilterorder, vcdashboardfiltername, idashboardid, vcdashboardfiltertype, idashboardqueryidfordefaultvalue, vcdashboardfilterdisplayname) VALUES (
'62'::integer, '0'::integer, 'DateRange'::character varying, '31'::integer, 'DateRangePicker'::character varying, '79'::integer, 'Date Range'::character varying)
 returning idashboardfilterid;

INSERT INTO ui.dashboardfilters (
idashboardfilterid, ifilterorder, vcdashboardfiltername, idashboardid, vcdashboardfiltertype, idashboardqueryidfordefaultvalue, vcdashboardfilterdisplayname) VALUES (
'61'::integer, '0'::integer, 'DateRange'::character varying, '30'::integer, 'DateRangePicker'::character varying, '79'::integer, 'Date Range'::character varying)
 returning idashboardfilterid;

INSERT INTO ui.dashboardfilters (
idashboardfilterid, ifilterorder, vcdashboardfiltername, idashboardid, vcdashboardfiltertype, idashboardqueryidfordefaultvalue, vcdashboardfilterdisplayname) VALUES (
'60'::integer, '0'::integer, 'DateRange'::character varying, '29'::integer, 'DateRangePicker'::character varying, '79'::integer, 'Date Range'::character varying)
 returning idashboardfilterid;

INSERT INTO ui.dashboardfilters (
idashboardfilterid, ifilterorder, vcdashboardfiltername, idashboardid, vcdashboardfiltertype, idashboardqueryidfordefaultvalue, vcdashboardfilterdisplayname) VALUES (
'59'::integer, '0'::integer, 'DateRange'::character varying, '28'::integer, 'DateRangePicker'::character varying, '79'::integer, 'Date Range'::character varying)
 returning idashboardfilterid;

INSERT INTO ui.dashboardfilters (
idashboardfilterid, ifilterorder, vcdashboardfiltername, idashboardid, vcdashboardfiltertype, idashboardqueryidfordefaultvalue, vcdashboardfilterdisplayname) VALUES (
'58'::integer, '0'::integer, 'DateRange'::character varying, '27'::integer, 'DateRangePicker'::character varying, '79'::integer, 'Date Range'::character varying)
 returning idashboardfilterid;


INSERT INTO ui.dashboardqueryparameters (
idashboardparameterid, vcparametername, vcparametertype, idashboardqueryid) VALUES (
'133'::integer, 'DateRange'::character varying, 'DateRange'::character varying, '88'::integer)
 returning idashboardparameterid;

INSERT INTO ui.dashboardqueryparameters (
idashboardparameterid, vcparametername, vcparametertype, idashboardqueryid) VALUES (
'132'::integer, 'DateRange'::character varying, 'DateRange'::character varying, '87'::integer)
 returning idashboardparameterid;

INSERT INTO ui.dashboardqueryparameters (
idashboardparameterid, vcparametername, vcparametertype, idashboardqueryid) VALUES (
'131'::integer, 'DateRange'::character varying, 'DateRange'::character varying, '86'::integer)
 returning idashboardparameterid;

INSERT INTO ui.dashboardqueryparameters (
idashboardparameterid, vcparametername, vcparametertype, idashboardqueryid) VALUES (
'130'::integer, 'DateRange'::character varying, 'DateRange'::character varying, '85'::integer)
 returning idashboardparameterid;

INSERT INTO ui.dashboardqueryparameters (
idashboardparameterid, vcparametername, vcparametertype, idashboardqueryid) VALUES (
'129'::integer, 'DateRange'::character varying, 'DateRange'::character varying, '84'::integer)
 returning idashboardparameterid;

INSERT INTO ui.dashboardresultset (
idashboardresultsetid, vcdashboardresultsetlayout, vcdashboardresultsetname, idashboardqueryid, idashboardid, vcdashboardresultsetschema, irowno, imenustructuredesc) VALUES (
'43'::integer, '{"sizes":[1],"detail":{"main":{"type":"tab-area","widgets":["PERSPECTIVE_GENERATED_ID_1"],"currentIndex":0}},"mode":"globalFilters","viewers":{"PERSPECTIVE_GENERATED_ID_1":{"plugin":"Datagrid","plugin_config":{"columns":{},"editable":false,"scroll_lock":false},"settings":false,"theme":"Pro Dark","title":"Audit Report - Metadata","group_by":[],"split_by":[],"columns":[],"filter":[],"sort":[],"expressions":[],"aggregates":{},"master":false,"table":"auditreportmetadata","linked":false}}}'::text, 'auditreportmetadata'::character varying, '88'::integer, '31'::integer, '{
  "Metadata ID":"integer",
  "Parameter Name":"string",
  "Parameter Description":"string",
  "Data Type":"string",
  "Prefix":"string",
  "Path":"string",
  "Query":"string",
  "Root Level":"string",
"ML":"boolean",
"Score":"boolean",
"UI":"boolean",
"Config":"string"
}
'::text, '1'::integer, '577'::integer)
 returning idashboardresultsetid;

INSERT INTO ui.dashboardresultset (
idashboardresultsetid, vcdashboardresultsetlayout, vcdashboardresultsetname, idashboardqueryid, idashboardid, vcdashboardresultsetschema, irowno, imenustructuredesc) VALUES (
'42'::integer, '{"sizes":[1],"detail":{"main":{"type":"tab-area","widgets":["PERSPECTIVE_GENERATED_ID_1"],"currentIndex":0}},"mode":"globalFilters","viewers":{"PERSPECTIVE_GENERATED_ID_1":{"plugin":"Datagrid","plugin_config":{"columns":{},"editable":false,"scroll_lock":false},"settings":false,"theme":"Pro Dark","title":"Audit Report - User","group_by":[],"split_by":[],"columns":[],"filter":[],"sort":[],"expressions":[],"aggregates":{},"master":false,"table":"auditreportuser","linked":false}}}'::text, 'auditreportuser'::character varying, '87'::integer, '30'::integer, '{
   "User Name":"string",
   "First Name":"string",
   "Last Name":"string",
   "Email ID":"string",
   "User ID":"integer",
   "Mobile":"string",
   "Maker User":"string",
    "Maker Time Stamp":"datetime",
    "Maker & Checker Remarks":"string",
    "Checker User":"string",
    "Checker Time Stamp": "datetime",
    "Action": "string",
    "Address":"string",
    "Contact":"string",
    "Designation":"string"
}
'::text, '1'::integer, '577'::integer)
 returning idashboardresultsetid;

INSERT INTO ui.dashboardresultset (
idashboardresultsetid, vcdashboardresultsetlayout, vcdashboardresultsetname, idashboardqueryid, idashboardid, vcdashboardresultsetschema, irowno, imenustructuredesc) VALUES (
'41'::integer, '{"sizes":[1],"detail":{"main":{"type":"tab-area","widgets":["PERSPECTIVE_GENERATED_ID_1"],"currentIndex":0}},"mode":"globalFilters","viewers":{"PERSPECTIVE_GENERATED_ID_1":{"plugin":"Datagrid","plugin_config":{"columns":{},"editable":false,"scroll_lock":false},"settings":false,"theme":"Pro Dark","title":"Audit Report - Observations","group_by":[],"split_by":[],"columns":[],"filter":[],"sort":[],"expressions":[],"aggregates":{},"master":false,"table":"auditreportobservations","linked":false}}}'::text, 'auditreportobservations'::character varying, '86'::integer, '29'::integer, '{
    "Observation Name":"string",
    "Observation Description":"string",
    "Observation ID":"integer",
    "Window Name":"string",
    "Maker User":"string",
    "Maker Time Stamp":"datetime",
    "Maker & Checker Remarks":"string",
    "Checker User":"string",
    "Checker Time Stamp": "datetime",
    "Action": "string",
    "Where": "string",
    "Aggregation":"string",
    "Duration":"string",
    "Observation Count":"integer"
}
'::text, '1'::integer, '577'::integer)
 returning idashboardresultsetid;

INSERT INTO ui.dashboardresultset (
idashboardresultsetid, vcdashboardresultsetlayout, vcdashboardresultsetname, idashboardqueryid, idashboardid, vcdashboardresultsetschema, irowno, imenustructuredesc) VALUES (
'40'::integer, '{"sizes":[1],"detail":{"main":{"type":"tab-area","widgets":["PERSPECTIVE_GENERATED_ID_1"],"currentIndex":0}},"mode":"globalFilters","viewers":{"PERSPECTIVE_GENERATED_ID_1":{"plugin":"Datagrid","plugin_config":{"columns":{},"editable":false,"scroll_lock":false},"settings":false,"theme":"Pro Dark","title":"Audit Report - Windows","group_by":[],"split_by":[],"columns":[],"filter":[],"sort":[],"expressions":[],"aggregates":{},"master":false,"table":"auditreportwindows","linked":false}}}'::text, 'auditreportwindows'::character varying, '85'::integer, '28'::integer, '{
    "Window Name":"string",
    "Window Description":"string",
    "Window ID":"integer",
    "Maker User":"string",
    "Maker Time Stamp":"datetime",
    "Maker & Checker Remarks":"string",
    "Checker User":"string",
    "Checker Time Stamp": "datetime",
    "Action": "string",
   "Select":"string",
   "Where":"string",
   "Group By":"string",
   "Window Count":"integer",
   "Window Duration":"string"
}
'::text, '1'::integer, '577'::integer)
 returning idashboardresultsetid;

INSERT INTO ui.dashboardresultset (
idashboardresultsetid, vcdashboardresultsetlayout, vcdashboardresultsetname, idashboardqueryid, idashboardid, vcdashboardresultsetschema, irowno, imenustructuredesc) VALUES (
'39'::integer, '{"sizes":[1],"detail":{"main":{"type":"tab-area","widgets":["PERSPECTIVE_GENERATED_ID_1"],"currentIndex":0}},"mode":"globalFilters","viewers":{"PERSPECTIVE_GENERATED_ID_1":{"plugin":"Datagrid","plugin_config":{"columns":{},"editable":false,"scroll_lock":false},"settings":false,"theme":"Pro Dark","title":"Audit Report - Decision","group_by":[],"split_by":[],"columns":[],"filter":[],"sort":[],"expressions":[],"aggregates":{},"master":false,"table":"auditreportdecision","linked":false}}}'::text, 'auditreportdecision'::character varying, '84'::integer, '27'::integer, '{
 "Decision Name":"string",
 "Decision Description":"string",
 "Decision ID":"integer",
 "Maker User":"string",
 "Maker Time Stamp":"datetime",
 "Maker & Checker Remarks":"string",
 "Checker User":"string",
 "Checker Time Stamp": "datetime",
 "Action": "string",
 "Decision Parameters":"string",
 "Product Name": "string",
 "Attributes":"string",
 "Decision Info" : "string"
}
'::text, '1'::integer, '577'::integer)
 returning idashboardresultsetid;




 UPDATE ui.dashboardresultset SET
 vcdashboardresultsetlayout = '{"sizes":[1],"detail":{"main":{"type":"tab-area","widgets":["PERSPECTIVE_GENERATED_ID_1"],"currentIndex":0}},"mode":"globalFilters","viewers":{"PERSPECTIVE_GENERATED_ID_1":{"plugin":"Datagrid","plugin_config":{"columns":{},"editable":false,"scroll_lock":false},"settings":false,"theme":"Pro Dark","title":"Audit Report - Class","group_by":[],"split_by":[],"columns":[],"filter":[],"sort":[],"expressions":[],"aggregates":{},"master":false,"table":"auditreportclass","linked":false}}}'::text WHERE
 idashboardresultsetid = 38;

ALTER TABLE IF EXISTS ui.observationsuiaudit
    ADD COLUMN odesc text;

ALTER TABLE IF EXISTS ui.observationsui
    ADD COLUMN odesc text;


UPDATE ui.dashboardresultset SET
vcdashboardresultsetschema = '{
  "Parameter Name":"string",
  "Parameter Description":"string",
  "Data Type":"string",
  "Prefix":"string",
  "Path":"string",
  "Query":"string",
  "Root Level":"string",
"ML":"boolean",
"Score":"boolean",
"UI":"boolean",
 "Maker User":"string",
    "Maker Time Stamp":"datetime",
    "Maker & Checker Remarks":"string",
    "Checker User":"string",
    "Checker Time Stamp": "datetime",
    "Action": "string",
"Config":"string"
}
'::text WHERE
idashboardresultsetid = 43;


INSERT INTO ui.dashboardquery (
idashboardqueryid, vcdashboardquery, vcfilterparametersjson, formattingrequiered, runonanalytics, transposerequired, imenustructuredesc) VALUES (
'89'::integer, 'SELECT makeruser.vcusername as "User Name", r.dtactivity at time zone ''asia/kolkata'' as "Time stamp", r.vcactivity as "UI", r.vcparameters as "Query Parameter" FROM ui.activitylog r left join ui.webuser makeruser on makeruser.iuserid = r.iuserid where cast(r.dtactivity at time zone :timeZone as date) between cast(:StartDate as date) and cast(:EndDate as date)-1;'::text, '{  "DateRange": null }'::text, false::boolean, false::boolean, false::boolean, '577'::integer)
 returning idashboardqueryid;


INSERT INTO ui.dashboardfilters (
idashboardfilterid, ifilterorder, vcdashboardfiltername, idashboardid, vcdashboardfiltertype, idashboardqueryidfordefaultvalue, vcdashboardfilterdisplayname) VALUES (
'63'::integer, '0'::integer, 'DateRange'::character varying, '32'::integer, 'DateRangePicker'::character varying, '79'::integer, 'Date Range'::character varying)
 returning idashboardfilterid;


INSERT INTO ui.dashboardqueryparameters (
idashboardparameterid, vcparametername, vcparametertype, idashboardqueryid) VALUES (
'134'::integer, 'DateRange'::character varying, 'DateRange'::character varying, '89'::integer)
 returning idashboardparameterid;

INSERT INTO ui.dashboardresultset (
idashboardresultsetid, vcdashboardresultsetlayout, vcdashboardresultsetname, idashboardqueryid, idashboardid, vcdashboardresultsetschema, irowno) VALUES (
'44'::integer, '{"sizes":[1],"detail":{"main":{"type":"tab-area","widgets":["PERSPECTIVE_GENERATED_ID_1"],"currentIndex":0}},"mode":"globalFilters","viewers":{"PERSPECTIVE_GENERATED_ID_1":{"plugin":"Datagrid","plugin_config":{"columns":{},"editable":false,"scroll_lock":false},"settings":false,"theme":"Pro Dark","title":"Audit Report - Activity Log","group_by":[],"split_by":[],"columns":[],"filter":[],"sort":[],"expressions":[],"aggregates":{},"master":false,"table":"auditreportactivitylog","linked":false}}}'::text, 'auditreportactivitylog'::character varying, '89'::integer, '32'::integer, '{
    "User Name":"string",
    "Time stamp":"datetime",
    "UI":"string",
    "Query Parameter":"string"
}'::text, '1'::integer)
 returning idashboardresultsetid;


UPDATE ui.dashboardresultset SET
imenustructuredesc = '577'::integer WHERE
idashboardresultsetid = 44;


UPDATE ui.dashboardquery SET
bparametersrequired = true::boolean WHERE
idashboardqueryid = 89;