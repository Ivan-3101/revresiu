DELETE FROM ui.panelaccessmap
	WHERE workflowid in (4, 5) and panelid in (2, 4);


INSERT INTO ui.dashboardquery (
idashboardqueryid, bparametersrequired, vcdashboardquery, formattingrequiered, runonanalytics, transposerequired) VALUES (
'64'::integer, false::boolean, 'SELECT X.* FROM   (VALUES (''Monthly'', ''Monthly'')) AS X ("label", "value");'::text, false::boolean, false::boolean, false::boolean)
 returning idashboardqueryid;

INSERT INTO ui.dashboard (
idashboardid, bactive, bdelete, vcdashboardname, iorder, irowcount) VALUES (
'21'::integer, true::boolean, false::boolean, 'Batch Party Profile'::character varying, '21'::integer, '1'::integer)
 returning idashboardid;

INSERT INTO ui.dashboardfilters (
idashboardfilterid, ifilterorder, vcdashboardfiltername, vcdashboardfiltertype, idashboardid, idashboardqueryidfordefaultvalue, vcdashboardfilterdisplayname) VALUES (
'46'::integer, '0'::integer, 'DateRange'::character varying, 'DateRangePicker'::character varying, '21'::integer, '16'::integer, 'Date Range'::character varying)
 returning idashboardfilterid;

INSERT INTO ui.dashboardfilters (
idashboardfilterid, ifilterorder, vcdashboardfiltername, idashboardid, vcdashboardfiltertype, idashboardqueryidforoptions, vcdashboardfilterdisplayname) VALUES (
'47'::integer, '1'::integer, 'Level'::character varying, '21'::integer, 'Select'::character varying, '27'::integer, 'Level'::character varying)
 returning idashboardfilterid;

INSERT INTO ui.dashboardfilters (
idashboardfilterid, ifilterorder, vcdashboardfiltername, idashboardid, vcdashboardfilterdisplayname, vcdashboardfiltertype, idashboardqueryidforoptions) VALUES (
'48'::integer, '2'::integer, 'Frequency'::character varying, '21'::integer, 'Frequency'::character varying, 'Select'::character varying, '64'::integer)
 returning idashboardfilterid;

INSERT INTO ui.dashboardfilters (
idashboardfilterid, ifilterorder, vcdashboardfiltername, idashboardid, vcdashboardfilterdisplayname, vcdashboardfiltertype) VALUES (
'49'::integer, '3'::integer, 'Address'::character varying, '21'::integer, 'Address'::character varying, 'Input'::character varying)
 returning idashboardfilterid;


 INSERT INTO ui.dashboardquery (
 idashboardqueryid, bparametersrequired, vcdashboardquery, formattingrequiered, runonanalytics, transposerequired, vcfilterparametersjson) VALUES (
 '65'::integer, true::boolean, '{
 	"Account": {
 		"Monthly": "with recursive profile as ( SELECT pv.*,v.vcexternalaccountid, v.vcaccountname FROM profiles.account_monthly pv left join masters.accounts v on v.iaccountid = pv.iaccountid where tdate between cast(:StartDate as date) and cast(:EndDate as date)-1 and v.vcexternalaccountid =:Address ), flat ( iaccountid, key, value) as ( select iaccountid,'''',cast(format(''{\"Address\":\"%s\",\"Last Update\":\"%s\" ,\"Name\":\"%s\"}'', vcexternalaccountid, last_updated, vcaccountname) as jsonb) as value from profile \n union select  iaccountid,concat( '''', key), value from profile, jsonb_each(val) \n union select  iaccountid,concat(f.key, ''.'', j.key), j.value from flat f, jsonb_each(f.value) j where jsonb_typeof(f.value) = ''object'' ) \n select cast(json_agg(data) as text) from ( select iaccountid,jsonb_object_agg((select CASE WHEN (select vccolumnname from profiles.metadata where vcpath = key and vcroot = ''account'') IS NULL THEN key ELSE (select vccolumnname from profiles.metadata where vcpath = key and vcroot = ''account'') END AS  vccolumnname ), value  ) as data from flat where jsonb_typeof(value)<>''object'' group by iaccountid) a;"
 	},
 	"VPA": {
 		"Monthly": "with recursive profile as ( SELECT pv.*,v.vcexternaladdressid, v.vcvpaname FROM profiles.vpa_monthly pv left join masters.vpa v on v.ivpaid = pv.ivpaid where tdate between cast(:StartDate as date) and cast(:EndDate as date)-1 and v.vcexternaladdressid = :Address ), flat (ivpaid, key, value) as ( select ivpaid,'''',cast(format(''{\"Address\":\"%s\",\"Last Update\":\"%s\" ,\"Name\":\"%s\"}'', vcexternaladdressid, last_updated, vcvpaname) as jsonb) as value from profile \n union select  ivpaid,concat( '''', key), value from profile, jsonb_each(val) \n union select  ivpaid,concat(f.key, ''.'', j.key), j.value from flat f, jsonb_each(f.value) j where jsonb_typeof(f.value) = ''object'' ) \n select cast(json_agg(data) as text) from ( select ivpaid,jsonb_object_agg((select CASE WHEN (select vccolumnname from profiles.metadata where vcpath = key and vcroot = ''vpa'') IS NULL THEN key ELSE (select vccolumnname from profiles.metadata where vcpath = key and vcroot = ''account'') END AS  vccolumnname ), value  ) as data from flat where jsonb_typeof(value)<>''object'' group by ivpaid) a;"
 	}
 }'::text, false::boolean, true::boolean, false::boolean, '{"DateRange" : null, "Address":null, "Level": null, "Frequency":null}'::text)
  returning idashboardqueryid;

 INSERT INTO ui.dashboardqueryparameters (
 idashboardparameterid, vcparametername, vcparametertype, idashboardqueryid, iorder) VALUES (
 '102'::integer, 'Level'::character varying, 'JsonPath'::character varying, '65'::integer, '0'::integer)
  returning idashboardparameterid;


  INSERT INTO ui.dashboardqueryparameters (
  idashboardparameterid, vcparametername, vcparametertype, idashboardqueryid, iorder) VALUES (
  '103'::integer, 'Frequency'::character varying, 'JsonPath'::character varying, '65'::integer, '1'::integer)
   returning idashboardparameterid;


   INSERT INTO ui.dashboardqueryparameters (
   idashboardparameterid, vcparametername, vcparametertype, idashboardqueryid) VALUES (
   '105'::integer, 'Address'::character varying, 'String'::character varying, '65'::integer)
    returning idashboardparameterid;


    INSERT INTO ui.dashboardqueryparameters (
    idashboardparameterid, vcparametername, vcparametertype, idashboardqueryid) VALUES (
    '104'::integer, 'DateRange'::character varying, 'DateRange'::character varying, '65'::integer)
     returning idashboardparameterid;



INSERT INTO ui.dashboardresultset (
idashboardresultsetid, vcdashboardresultsetlayout, vcdashboardresultsetname, idashboardqueryid, idashboardid) VALUES (
'30'::integer, ' {
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
  			"name": "Batch Party Profile",
  			"table": "batchpartyprofile",
  			"linked": false
  		}
  	}
  }'::text, 'batchpartyprofile'::character varying, '65'::integer, '21'::integer)
 returning idashboardresultsetid;

 UPDATE ui.dashboardresultset SET
 icolsize = '12'::integer, irowno = '1'::integer WHERE
 idashboardresultsetid = 30;

     UPDATE ui.dashboardquery SET
     formattingrequiered = true::boolean WHERE
     idashboardqueryid = 65;