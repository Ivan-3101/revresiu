

INSERT INTO ui.dashboardquery (idashboardqueryid, bparametersrequired, vcfilterparametersjson, vcdashboardquery, formattingrequiered, runonanalytics, transposerequired) VALUES (1, false, NULL, 'SELECT Current_date-1;', NULL, NULL, NULL);

UPDATE ui.dashboardfilters SET
idashboardqueryidfordefaultvalue = 1 WHERE
idashboardfilterid = 34;

INSERT INTO ui.dashboard (idashboardid, bactive, bdelete, vcdashboardname, iorder, irowcount) VALUES (16, true, false, 'Master Extracts', 16, 1);

INSERT INTO ui.dashboardfilters (idashboardfilterid, ifilterorder, vcdashboardfiltername, idashboardid, vcdashboardfiltertype, idashboardqueryidfordefaultvalue, idashboardqueryidforoptions, vcdashboardfilterdisplayname) VALUES (38, 0, 'Party', 16, 'Select', NULL, 27, 'Level');

INSERT INTO ui.dashboardquery (idashboardqueryid, bparametersrequired, vcfilterparametersjson, vcdashboardquery, formattingrequiered, runonanalytics, transposerequired) VALUES (48, true, '{"Party": null}', '{
    "Account":"with recursive profile as ( SELECT * FROM masters.accounts ), flat ( iaccountid, key, value) as ( select iaccountid,'''', cast(format(''{\"iaccountid\":\"%s\",\"icustomerid\":\"%s\",\"vcexternalaccountid\":\"%s\",\"iaccounttypeid\":\"%s\" ,\"vcaccount\":\"%s\" ,\"vcifsc\":\"%s\",\"vcaccountproviderid\":\"%s\",\"vcaccountname\":\"%s\",\"dtonboardingdate\":\"%s\",\"dtexpirydate\":\"%s\" ,\"imcc\":\"%s\",\"bverified\":\"%s\"}'',cast(iaccountid as text),cast(icustomerid as text),vcexternalaccountid, cast(iaccounttypeid as text),vcaccount, vcifsc, vcaccountproviderid, vcaccountname, dtonboardingdate, dtexpirydate, cast(imcc as text), cast(bverified as text)) as jsonb) as value from profile \n union select  iaccountid,concat( ''attrib.'', key), value from profile, jsonb_each(vcattribs) \n union select  iaccountid,concat(f.key, '''', j.key), j.value from flat f, jsonb_each(f.value) j where jsonb_typeof(f.value) = ''object'' ) \n select cast(json_agg(data) as text) from ( select iaccountid,jsonb_object_agg(key, value  ) as data from flat where jsonb_typeof(value)<>''object'' group by iaccountid) a;",
    "VPA": "SELECT * FROM masters.vpa"
}', true, false, false);

INSERT INTO ui.dashboardqueryparameters (idashboardparameterid, vcparametername, vcparametertype, idashboardqueryid, iorder) VALUES (73, 'Party', 'JsonPath', 48, 0);

INSERT INTO ui.dashboardresultset (idashboardresultsetid, iresultsetorder, vcdashboardresultsetcolumnjson, vcdashboardresultsetlayout, vcdashboardresultsetname, idashboardqueryid, idashboardid, vcdashboardresultsetschema, icolsize, irowno, dtlastupdatedtimestamp, iuserid) VALUES (24, NULL, NULL, ' {
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
  			"name": "Master Extracts",
  			"table": "masterextracts",
  			"linked": false
  		}
  	}
  }', 'masterextracts', 48, 16, NULL, NULL, 1, NULL, NULL);
