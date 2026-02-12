UPDATE ui.dashboard	SET bactive=false WHERE idashboardid=14;

UPDATE ui.dashboard SET bactive=false WHERE idashboardid=15;

INSERT INTO ui.dashboard (idashboardid, bactive, bdelete, vcdashboardname, iorder, irowcount) VALUES (17, true, false, 'Party Profile', 17, 1);

INSERT INTO ui.dashboardfilters (idashboardfilterid, ifilterorder, vcdashboardfiltername, idashboardid, vcdashboardfiltertype, idashboardqueryidfordefaultvalue, idashboardqueryidforoptions, vcdashboardfilterdisplayname) VALUES (39, 0, 'DateRange', 17, 'DateRangePicker', 16, NULL, 'Date Range');
INSERT INTO ui.dashboardfilters (idashboardfilterid, ifilterorder, vcdashboardfiltername, idashboardid, vcdashboardfiltertype, idashboardqueryidfordefaultvalue, idashboardqueryidforoptions, vcdashboardfilterdisplayname) VALUES (40, 1, 'Party', 17, 'Select', NULL, 27, 'Level');
INSERT INTO ui.dashboardfilters (idashboardfilterid, ifilterorder, vcdashboardfiltername, idashboardid, vcdashboardfiltertype, idashboardqueryidfordefaultvalue, idashboardqueryidforoptions, vcdashboardfilterdisplayname) VALUES (41, 2, 'VpaAddress', 17, 'Input', NULL, NULL, 'Address');

INSERT INTO ui.dashboardquery (idashboardqueryid, bparametersrequired, vcfilterparametersjson, vcdashboardquery, formattingrequiered, runonanalytics, transposerequired) VALUES (57, true, '{"DateRange" : null, "VpaAddress":null, "Party": null}', '  {
    "Account": "with recursive profile as ( SELECT pv.*,v.vcexternalaccountid, v.vcaccountname FROM new_profiles.account pv left join masters.accounts v on v.iaccountid = pv.iaccountid where tdate between cast(:StartDate as date) and cast(:EndDate as date)-1 and v.vcexternalaccountid =:VpaAddress ), flat ( iaccountid, key, value) as ( select iaccountid,'''',cast(format(''{\"ID\":\"%s\",\"Address\":\"%s\",\"Date\":\"%s\",\"Last Update\":\"%s\" ,\"Name\":\"%s\"}'', iaccountid, vcexternalaccountid, tdate, last_updated, vcaccountname) as jsonb) as value from profile \n union select  iaccountid,concat( '''', key), value from profile, jsonb_each(val) \n union select  iaccountid,concat(f.key, '''', j.key), j.value from flat f, jsonb_each(f.value) j where jsonb_typeof(f.value) = ''object'' ) \n select cast(json_agg(data) as text) from ( select iaccountid,jsonb_object_agg(key, value  ) as data from flat where jsonb_typeof(value)<>''object'' group by iaccountid) a;",
    "VPA": "with recursive profile as ( SELECT pv.*,v.vcexternaladdressid, v.vcvpaname FROM new_profiles.vpa pv left join masters.vpa v on v.ivpaid = pv.ivpaid where tdate between cast(:StartDate as date) and cast(:EndDate as date)-1 and v.vcexternaladdressid = :VpaAddress ), flat (ivpaid, key, value) as ( select ivpaid,'''',cast(format(''{\"ID\":\"%s\",\"Address\":\"%s\",\"Date\":\"%s\",\"Last Update\":\"%s\" ,\"Name\":\"%s\"}'', ivpaid, vcexternaladdressid, tdate, last_updated, vcvpaname) as jsonb) as value from profile \n union select  ivpaid,concat( '''', key), value from profile, jsonb_each(val) \n union select  ivpaid,concat(f.key, '''', j.key), j.value from flat f, jsonb_each(f.value) j where jsonb_typeof(f.value) = ''object'' ) \n select cast(json_agg(data) as text) from ( select ivpaid,jsonb_object_agg(key, value  ) as data from flat where jsonb_typeof(value)<>''object'' group by ivpaid) a;"
}', true, true, false);


INSERT INTO ui.dashboardqueryparameters (idashboardparameterid, vcparametername, vcparametertype, idashboardqueryid, iorder) VALUES (93, 'Party', 'JsonPath', 57, 0);
INSERT INTO ui.dashboardqueryparameters (idashboardparameterid, vcparametername, vcparametertype, idashboardqueryid, iorder) VALUES (94, 'VpaAddress', 'String', 57, NULL);
INSERT INTO ui.dashboardqueryparameters (idashboardparameterid, vcparametername, vcparametertype, idashboardqueryid, iorder) VALUES (95, 'DateRange', 'DateRange', 57, NULL);

INSERT INTO ui.dashboardresultset (idashboardresultsetid, iresultsetorder, vcdashboardresultsetcolumnjson, vcdashboardresultsetlayout, vcdashboardresultsetname, idashboardqueryid, idashboardid, vcdashboardresultsetschema, icolsize, irowno, dtlastupdatedtimestamp, iuserid) VALUES (26, NULL, NULL, ' {
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
  			"name": "Party Profile",
  			"table": "partyprofile",
  			"linked": false
  		}
  	}
  }', 'partyprofile', 57, 17, NULL, 12, 1, NULL, NULL);


UPDATE ui.dashboardquery
	SET  vcdashboardquery='{
    "Account":"SELECT count(RT.IRULEID) AS \"count\", R.VCRULENAME AS \"name\" FROM TRANSACTIONS.RULE_TRIGGERED AS RT JOIN MASTERS.RULES AS R ON R.IRULEID = RT.IRULEID WHERE RT.vcpayeraccountexternalid = :Address group by RT.IRULEID, R.VCRULENAME;",
     "VPA": "SELECT count(RT.IRULEID) AS \"count\", R.VCRULENAME AS \"name\" FROM TRANSACTIONS.RULE_TRIGGERED AS RT JOIN MASTERS.RULES AS R ON R.IRULEID = RT.IRULEID WHERE RT.vcpayeraddr = :Address group by RT.IRULEID, R.VCRULENAME;"
}', runonanalytics=true
	WHERE idashboardqueryid=49;