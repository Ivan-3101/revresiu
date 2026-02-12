INSERT INTO ui.dashboard (
idashboardid, bactive, bdelete, vcdashboardname, iorder, irowcount, imenustructuredesc) VALUES (
'25'::integer, true::boolean, false::boolean, 'Audit Report - Rules'::character varying, '25'::integer, '1'::integer, '577'::integer)
 returning idashboardid;


INSERT INTO ui.dashboardquery (
idashboardqueryid, bparametersrequired, vcdashboardquery, formattingrequiered, runonanalytics, transposerequired) VALUES (
'81'::integer, false::boolean, 'SELECT X.* FROM   (VALUES (''Rules'', ''Rules'')) AS X ("label", "value")'::text, false::boolean, false::boolean, false::boolean)
 returning idashboardqueryid;



  INSERT INTO ui.dashboardfilters (
  idashboardfilterid, ifilterorder, vcdashboardfiltername, idashboardid, vcdashboardfiltertype, idashboardqueryidfordefaultvalue, vcdashboardfilterdisplayname) VALUES (
  '56'::integer, '1'::integer, 'DateRange'::character varying, '25'::integer, 'DateRangePicker'::character varying, '79'::integer, 'Date Range'::character varying)
   returning idashboardfilterid;


   INSERT INTO ui.dashboardquery (
   idashboardqueryid, bparametersrequired, vcfilterparametersjson, vcdashboardquery, formattingrequiered, runonanalytics, transposerequired, imenustructuredesc) VALUES (
   '82'::integer, true::boolean, '
   {
       "DateRange": null
   }'::text, '{
       "Rules": "SELECT d.vcdecisionname as \"Decision Name\", r.iruleid as \"Rule ID\", r.vcrulename as \"Rule Name\", makeruser.vcusername as \"Maker User\", r.dtentrydatetime as \"Maker Time Stamp\", r.vcremark as \"Maker & Checker Remarks\", checkeruser.vcusername as \"Checker User\", r.dtapproverstamp as \"Checker Time Stamp\", case when r.vcaction = ''A'' then ''Add'' when r.vcaction = ''M'' then ''Modify'' when r.vcaction = ''X'' then ''Delete'' when r.vcaction = ''N'' then ''No Change'' end as \"Action\", iversion as \"Rule Version\", vclabel as \"Rule Label\", vcruledescription as \"Rule Description\", vcruledetail as \"Rule Detail\", vcruleparams as \"Rule Params\", vcruleorder as \"Rule Order\" FROM ui.rulesaudit r inner join ui.decisions d on r.idecisionid = d.idecisionid left join ui.webuser makeruser on makeruser.iuserid = r.ientryuserid left join ui.webuser checkeruser on checkeruser.iuserid = r.ientryuserid where cast(r.dtentrystamp as date) between cast(:StartDate as date) and cast(:EndDate as date)-1;"
   }'::text, false::boolean, false::boolean, false::boolean, '577'::integer)
    returning idashboardqueryid;

    INSERT INTO ui.dashboardqueryparameters (
    idashboardparameterid, vcparametername, vcparametertype, idashboardqueryid) VALUES (
    '127'::integer, 'DateRange'::character varying, 'DateRange'::character varying, '82'::integer)
     returning idashboardparameterid;





      INSERT INTO ui.dashboardresultset (
      idashboardresultsetid, vcdashboardresultsetlayout, vcdashboardresultsetname, idashboardqueryid, idashboardid, vcdashboardresultsetschema, imenustructuredesc) VALUES (
      '37'::integer, ' {
        	"sizes": [
        		1
        	],
        	"master": {
        		"widgets": ["PERSPECTIVE_GENERATED_ID_1"]
        	},
        	"viewers": {
        		"PERSPECTIVE_GENERATED_ID_1": {
                               "settings":false,
        			"selectable": false,
        			"plugin": "datagrid",
        			"master": true,
        			"name": "Audit Report - Rules",
        			"table": "auditreport",
        			"linked": false
        		}
        	}
        }'::text, 'auditreport'::character varying, '82'::integer, '25'::integer, '{
          "Decision Name": "string",
          "Rule ID": "integer",
          "Rule Name": "string",
          "Maker User": "string",
          "Maker Time Stamp": "datetime",
          "Maker & Checker Remarks":"string",
          "Checker User":"string",
          "Checker Time Stamp":"datetime",
          "Action":"string",
          "Rule Version": "integer",
          "Rule Label":"string",
          "Rule Description":"string",
          "Rule Detail":"string",
          "Rule Params":"string",
          "Rule Order":"string"
      }'::text, '577'::integer)
       returning idashboardresultsetid;



       UPDATE ui.dashboardresultset SET
       irowno = '1'::integer WHERE
       idashboardresultsetid = 37;


       UPDATE ui.dashboardquery SET
       vcfilterparametersjson = '{ "DateRange": null }'::text WHERE
       idashboardqueryid = 82;


       UPDATE ui.dashboardresultset SET
       vcdashboardresultsetlayout = '{"sizes":[1],"detail":{"main":{"type":"tab-area","widgets":["PERSPECTIVE_GENERATED_ID_1"],"currentIndex":0}},"mode":"globalFilters","viewers":{"PERSPECTIVE_GENERATED_ID_1":{"plugin":"Datagrid","plugin_config":{"columns":{},"editable":false,"scroll_lock":false},"settings":false,"theme":"Pro Dark","title":"Audit Report - Rules","group_by":[],"split_by":[],"columns":[],"filter":[],"sort":[],"expressions":[],"aggregates":{},"master":false,"table":"auditreport","linked":false}}}'::text WHERE
       idashboardresultsetid = 37;


       UPDATE ui.dashboardquery SET
       vcdashboardquery = 'SELECT d.vcdecisionname as "Decision Name", r.iruleid as "Rule ID", r.vcrulename as "Rule Name", makeruser.vcusername as "Maker User", r.dtentrydatetime as "Maker Time Stamp", r.vcremark as "Maker & Checker Remarks", checkeruser.vcusername as "Checker User", r.dtapproverstamp as "Checker Time Stamp", case when r.vcaction = ''A'' then ''Add'' when r.vcaction = ''M'' then ''Modify'' when r.vcaction = ''X'' then ''Delete'' when r.vcaction = ''N'' then ''No Change'' end as "Action", iversion as "Rule Version", vclabel as "Rule Label", vcruledescription as "Rule Description", vcruledetail as "Rule Detail", vcruleparams as "Rule Params", vcruleorder as "Rule Order" FROM ui.rulesaudit r inner join ui.decisions d on r.idecisionid = d.idecisionid left join ui.webuser makeruser on makeruser.iuserid = r.ientryuserid left join ui.webuser checkeruser on checkeruser.iuserid = r.ientryuserid where cast(r.dtentrystamp as date) between cast(:StartDate as date) and cast(:EndDate as date)-1;'::text WHERE
       idashboardqueryid = 82;