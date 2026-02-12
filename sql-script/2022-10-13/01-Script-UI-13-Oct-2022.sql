alter table if exists ui.dashboard add column iorder int4;
alter table if exists ui.dashboardresultset add column icolsize int4;
alter table if exists ui.dashboard add column irowcount int4;
alter table if exists ui.dashboardresultset add column irowno int4;
alter table if exists ui.dashboardquery add column transposerequired boolean;

UPDATE ui.dashboard SET  irowcount=1 WHERE irowcount is null;

UPDATE ui.dashboardresultset SET irowno=1 WHERE irowno is null;

INSERT INTO ui.dashboard (idashboardid, bactive, bdelete, vcdashboardname, iorder, irowcount) VALUES (14, true, false, 'Party Profile', 14, 2);

INSERT INTO ui.dashboardquery (idashboardqueryid, bparametersrequired, vcfilterparametersjson, vcdashboardquery, formattingrequiered, runonanalytics, transposerequired) VALUES (38, true, '{"DateRange" : null, "VpaAddress":null, "Type":null, "Party": null}', '{
    "Account": {
        "Payer": "SELECT v.vcexternalaccountid as \"Address\", CASE WHEN bside = true THEN ''Payee'' WHEN bside = false THEN ''Payer'' ELSE null END as \"Type\", last_updated as \"Last Updated\", tdate as \"Date\" FROM profiles.account pv left join masters.accounts v on v.iaccountid = pv.iaccountid where tdate between cast(:StartDate as date)+1 and cast(:EndDate as date) and v.vcexternalaccountid = :VpaAddress and bside = false",
        "Payee": "SELECT v.vcexternalaccountid as \"Address\", CASE WHEN bside = true THEN ''Payee'' WHEN bside = false THEN ''Payer'' ELSE null END as \"Type\", last_updated as \"Last Updated\", tdate as \"Date\" FROM profiles.account pv left join masters.accounts v on v.iaccountid = pv.iaccountid where tdate between cast(:StartDate as date)+1 and cast(:EndDate as date) and v.vcexternalaccountid = :VpaAddress and bside = true",
        "Both": "SELECT v.vcexternalaccountid as \"Address\", CASE WHEN bside = true THEN ''Payee'' WHEN bside = false THEN ''Payer'' ELSE null END as \"Type\", last_updated as \"Last Updated\", tdate as \"Date\" FROM profiles.account pv left join masters.accounts v on v.iaccountid = pv.iaccountid where tdate between cast(:StartDate as date)+1 and cast(:EndDate as date) and v.vcexternalaccountid = :VpaAddress "
    },
    "VPA": {
        "Payer": "SELECT v.vcexternaladdressid as \"Address\", CASE WHEN bside = true THEN ''Payee'' WHEN bside = false THEN ''Payer'' ELSE null END as \"Type\", last_updated as \"Last Updated\", tdate as \"Date\" FROM profiles.vpa pv left join masters.vpa v on v.ivpaid = pv.ivpaid where tdate between cast(:StartDate as date)+1 and cast(:EndDate as date) and v.vcexternaladdressid = :VpaAddress and bside = false",
        "Payee": "SELECT v.vcexternaladdressid as \"Address\", CASE WHEN bside = true THEN ''Payee'' WHEN bside = false THEN ''Payer'' ELSE null END as \"Type\", last_updated as \"Last Updated\", tdate as \"Date\" FROM profiles.vpa pv left join masters.vpa v on v.ivpaid = pv.ivpaid where tdate between cast(:StartDate as date)+1 and cast(:EndDate as date) and v.vcexternaladdressid = :VpaAddress and bside = true",
        "Both": "SELECT v.vcexternaladdressid as \"Address\", CASE WHEN bside = true THEN ''Payee'' WHEN bside = false THEN ''Payer'' ELSE null END as \"Type\", last_updated as \"Last Updated\", tdate as \"Date\" FROM profiles.vpa pv left join masters.vpa v on v.ivpaid = pv.ivpaid where tdate between cast(:StartDate as date)+1 and cast(:EndDate as date) and v.vcexternaladdressid = :VpaAddress"
    }
}', false, false, true);
INSERT INTO ui.dashboardquery (idashboardqueryid, bparametersrequired, vcfilterparametersjson, vcdashboardquery, formattingrequiered, runonanalytics, transposerequired) VALUES (39, true, '{"DateRange" : null, "VpaAddress":null, "Type":null, "Party": null}', '{
    "Account": {
        "Payer": "SELECT ''[''||cast(longevity as text)||'']'' as \"json_agg\" FROM profiles.account pv left join masters.accounts v on v.iaccountid = pv.iaccountid where tdate between cast(:StartDate as date)+1 and cast(:EndDate as date) and v.vcexternalaccountid = :VpaAddress and bside = false",
        "Payee": "SELECT ''[''||cast(longevity as text)||'']'' as \"json_agg\" FROM profiles.account pv left join masters.accounts v on v.iaccountid = pv.iaccountid where tdate between cast(:StartDate as date)+1 and cast(:EndDate as date) and v.vcexternalaccountid = :VpaAddress and bside = true",
        "Both": "SELECT ''[''||cast(longevity as text)||'']'' as \"json_agg\"  FROM profiles.account pv left join masters.accounts v on v.iaccountid = pv.iaccountid where tdate between cast(:StartDate as date)+1 and cast(:EndDate as date) and v.vcexternalaccountid = :VpaAddress "
    },
    "VPA": {
        "Payer": "SELECT ''[''||cast(longevity as text)||'']'' as \"json_agg\" FROM profiles.vpa pv left join masters.vpa v on v.ivpaid = pv.ivpaid where tdate between cast(:StartDate as date)+1 and cast(:EndDate as date) and v.vcexternaladdressid = :VpaAddress and bside = false",
        "Payee": "SELECT ''[''||cast(longevity as text)||'']'' as \"json_agg\" FROM profiles.vpa pv left join masters.vpa v on v.ivpaid = pv.ivpaid where tdate between cast(:StartDate as date)+1 and cast(:EndDate as date) and v.vcexternaladdressid = :VpaAddress and bside = true",
        "Both": "SELECT ''[''||cast(longevity as text)||'']'' as \"json_agg\" FROM profiles.vpa pv left join masters.vpa v on v.ivpaid = pv.ivpaid where tdate between cast(:StartDate as date)+1 and cast(:EndDate as date) and v.vcexternaladdressid = :VpaAddress"
    }
}', true, false, true);
INSERT INTO ui.dashboardquery (idashboardqueryid, bparametersrequired, vcfilterparametersjson, vcdashboardquery, formattingrequiered, runonanalytics, transposerequired) VALUES (40, true, '{"DateRange" : null, "VpaAddress":null, "Type":null, "Party": null}', '{
    "Account": {
        "Payer": "SELECT ''[''||cast(frequency as text)||'']'' as \"json_agg\" FROM profiles.account pv left join masters.accounts v on v.iaccountid = pv.iaccountid where tdate between cast(:StartDate as date)+1 and cast(:EndDate as date) and v.vcexternalaccountid = :VpaAddress and bside = false",
        "Payee": "SELECT ''[''||cast(frequency as text)||'']'' as \"json_agg\" FROM profiles.account pv left join masters.accounts v on v.iaccountid = pv.iaccountid where tdate between cast(:StartDate as date)+1 and cast(:EndDate as date) and v.vcexternalaccountid = :VpaAddress and bside = true",
        "Both": "SELECT ''[''||cast(frequency as text)||'']'' as \"json_agg\"  FROM profiles.account pv left join masters.accounts v on v.iaccountid = pv.iaccountid where tdate between cast(:StartDate as date)+1 and cast(:EndDate as date) and v.vcexternalaccountid = :VpaAddress "
    },
    "VPA": {
        "Payer": "SELECT ''[''||cast(frequency as text)||'']'' as \"json_agg\" FROM profiles.vpa pv left join masters.vpa v on v.ivpaid = pv.ivpaid where tdate between cast(:StartDate as date)+1 and cast(:EndDate as date) and v.vcexternaladdressid = :VpaAddress and bside = false",
        "Payee": "SELECT ''[''||cast(frequency as text)||'']'' as \"json_agg\" FROM profiles.vpa pv left join masters.vpa v on v.ivpaid = pv.ivpaid where tdate between cast(:StartDate as date)+1 and cast(:EndDate as date) and v.vcexternaladdressid = :VpaAddress and bside = true",
        "Both": "SELECT ''[''||cast(frequency as text)||'']'' as \"json_agg\" FROM profiles.vpa pv left join masters.vpa v on v.ivpaid = pv.ivpaid where tdate between cast(:StartDate as date)+1 and cast(:EndDate as date) and v.vcexternaladdressid = :VpaAddress"
    }
}', true, false, true);
INSERT INTO ui.dashboardquery (idashboardqueryid, bparametersrequired, vcfilterparametersjson, vcdashboardquery, formattingrequiered, runonanalytics, transposerequired) VALUES (41, true, '{"DateRange" : null, "VpaAddress":null, "Type":null, "Party": null}', '{
    "Account": {
        "Payer": "SELECT ''[''||cast(velocity as text)||'']'' as \"json_agg\" FROM profiles.account pv left join masters.accounts v on v.iaccountid = pv.iaccountid where tdate between cast(:StartDate as date)+1 and cast(:EndDate as date) and v.vcexternalaccountid = :VpaAddress and bside = false",
        "Payee": "SELECT ''[''||cast(velocity as text)||'']'' as \"json_agg\" FROM profiles.account pv left join masters.accounts v on v.iaccountid = pv.iaccountid where tdate between cast(:StartDate as date)+1 and cast(:EndDate as date) and v.vcexternalaccountid = :VpaAddress and bside = true",
        "Both": "SELECT ''[''||cast(velocity as text)||'']'' as \"json_agg\"  FROM profiles.account pv left join masters.accounts v on v.iaccountid = pv.iaccountid where tdate between cast(:StartDate as date)+1 and cast(:EndDate as date) and v.vcexternalaccountid = :VpaAddress "
    },
    "VPA": {
        "Payer": "SELECT ''[''||cast(velocity as text)||'']'' as \"json_agg\" FROM profiles.vpa pv left join masters.vpa v on v.ivpaid = pv.ivpaid where tdate between cast(:StartDate as date)+1 and cast(:EndDate as date) and v.vcexternaladdressid = :VpaAddress and bside = false",
        "Payee": "SELECT ''[''||cast(velocity as text)||'']'' as \"json_agg\" FROM profiles.vpa pv left join masters.vpa v on v.ivpaid = pv.ivpaid where tdate between cast(:StartDate as date)+1 and cast(:EndDate as date) and v.vcexternaladdressid = :VpaAddress and bside = true",
        "Both": "SELECT ''[''||cast(velocity as text)||'']'' as \"json_agg\" FROM profiles.vpa pv left join masters.vpa v on v.ivpaid = pv.ivpaid where tdate between cast(:StartDate as date)+1 and cast(:EndDate as date) and v.vcexternaladdressid = :VpaAddress"
    }
}', true, false, true);
INSERT INTO ui.dashboardquery (idashboardqueryid, bparametersrequired, vcfilterparametersjson, vcdashboardquery, formattingrequiered, runonanalytics, transposerequired) VALUES (42, true, '{"DateRange" : null, "VpaAddress":null, "Type":null, "Party": null}', '{
    "Account": {
        "Payer": "SELECT ''[''||cast(engagement as text)||'']'' as \"json_agg\" FROM profiles.account pv left join masters.accounts v on v.iaccountid = pv.iaccountid where tdate between cast(:StartDate as date)+1 and cast(:EndDate as date) and v.vcexternalaccountid = :VpaAddress and bside = false",
        "Payee": "SELECT ''[''||cast(engagement as text)||'']'' as \"json_agg\" FROM profiles.account pv left join masters.accounts v on v.iaccountid = pv.iaccountid where tdate between cast(:StartDate as date)+1 and cast(:EndDate as date) and v.vcexternalaccountid = :VpaAddress and bside = true",
        "Both": "SELECT ''[''||cast(engagement as text)||'']'' as \"json_agg\"  FROM profiles.account pv left join masters.accounts v on v.iaccountid = pv.iaccountid where tdate between cast(:StartDate as date)+1 and cast(:EndDate as date) and v.vcexternalaccountid = :VpaAddress "
    },
    "VPA": {
        "Payer": "SELECT ''[''||cast(engagement as text)||'']'' as \"json_agg\" FROM profiles.vpa pv left join masters.vpa v on v.ivpaid = pv.ivpaid where tdate between cast(:StartDate as date)+1 and cast(:EndDate as date) and v.vcexternaladdressid = :VpaAddress and bside = false",
        "Payee": "SELECT ''[''||cast(engagement as text)||'']'' as \"json_agg\" FROM profiles.vpa pv left join masters.vpa v on v.ivpaid = pv.ivpaid where tdate between cast(:StartDate as date)+1 and cast(:EndDate as date) and v.vcexternaladdressid = :VpaAddress and bside = true",
        "Both": "SELECT ''[''||cast(engagement as text)||'']'' as \"json_agg\" FROM profiles.vpa pv left join masters.vpa v on v.ivpaid = pv.ivpaid where tdate between cast(:StartDate as date)+1 and cast(:EndDate as date) and v.vcexternaladdressid = :VpaAddress"
    }
}', true, false, true);
INSERT INTO ui.dashboardquery (idashboardqueryid, bparametersrequired, vcfilterparametersjson, vcdashboardquery, formattingrequiered, runonanalytics, transposerequired) VALUES (43, true, '{"DateRange" : null, "VpaAddress":null, "Type":null, "Party": null}', '{
    "Account": {
        "Payer": "SELECT ''[''||cast(geospatial as text)||'']'' as \"json_agg\" FROM profiles.account pv left join masters.accounts v on v.iaccountid = pv.iaccountid where tdate between cast(:StartDate as date)+1 and cast(:EndDate as date) and v.vcexternalaccountid = :VpaAddress and bside = false",
        "Payee": "SELECT ''[''||cast(geospatial as text)||'']'' as \"json_agg\" FROM profiles.account pv left join masters.accounts v on v.iaccountid = pv.iaccountid where tdate between cast(:StartDate as date)+1 and cast(:EndDate as date) and v.vcexternalaccountid = :VpaAddress and bside = true",
        "Both": "SELECT ''[''||cast(geospatial as text)||'']'' as \"json_agg\"  FROM profiles.account pv left join masters.accounts v on v.iaccountid = pv.iaccountid where tdate between cast(:StartDate as date)+1 and cast(:EndDate as date) and v.vcexternalaccountid = :VpaAddress "
    },
    "VPA": {
        "Payer": "SELECT ''[''||cast(geospatial as text)||'']'' as \"json_agg\" FROM profiles.vpa pv left join masters.vpa v on v.ivpaid = pv.ivpaid where tdate between cast(:StartDate as date)+1 and cast(:EndDate as date) and v.vcexternaladdressid = :VpaAddress and bside = false",
        "Payee": "SELECT ''[''||cast(geospatial as text)||'']'' as \"json_agg\" FROM profiles.vpa pv left join masters.vpa v on v.ivpaid = pv.ivpaid where tdate between cast(:StartDate as date)+1 and cast(:EndDate as date) and v.vcexternaladdressid = :VpaAddress and bside = true",
        "Both": "SELECT ''[''||cast(geospatial as text)||'']'' as \"json_agg\" FROM profiles.vpa pv left join masters.vpa v on v.ivpaid = pv.ivpaid where tdate between cast(:StartDate as date)+1 and cast(:EndDate as date) and v.vcexternaladdressid = :VpaAddress"
    }
}', true, false, true);
INSERT INTO ui.dashboardquery (idashboardqueryid, bparametersrequired, vcfilterparametersjson, vcdashboardquery, formattingrequiered, runonanalytics, transposerequired) VALUES (44, true, '{"DateRange" : null, "VpaAddress":null, "Type":null, "Party": null}', '{
    "Account": {
        "Payer": "SELECT ''[''||cast(events as text)||'']'' as \"json_agg\" FROM profiles.account pv left join masters.accounts v on v.iaccountid = pv.iaccountid where tdate between cast(:StartDate as date)+1 and cast(:EndDate as date) and v.vcexternalaccountid = :VpaAddress and bside = false",
        "Payee": "SELECT ''[''||cast(events as text)||'']'' as \"json_agg\" FROM profiles.account pv left join masters.accounts v on v.iaccountid = pv.iaccountid where tdate between cast(:StartDate as date)+1 and cast(:EndDate as date) and v.vcexternalaccountid = :VpaAddress and bside = true",
        "Both": "SELECT ''[''||cast(events as text)||'']'' as \"json_agg\"  FROM profiles.account pv left join masters.accounts v on v.iaccountid = pv.iaccountid where tdate between cast(:StartDate as date)+1 and cast(:EndDate as date) and v.vcexternalaccountid = :VpaAddress "
    },
    "VPA": {
        "Payer": "SELECT ''[''||cast(events as text)||'']'' as \"json_agg\" FROM profiles.vpa pv left join masters.vpa v on v.ivpaid = pv.ivpaid where tdate between cast(:StartDate as date)+1 and cast(:EndDate as date) and v.vcexternaladdressid = :VpaAddress and bside = false",
        "Payee": "SELECT ''[''||cast(events as text)||'']'' as \"json_agg\" FROM profiles.vpa pv left join masters.vpa v on v.ivpaid = pv.ivpaid where tdate between cast(:StartDate as date)+1 and cast(:EndDate as date) and v.vcexternaladdressid = :VpaAddress and bside = true",
        "Both": "SELECT ''[''||cast(events as text)||'']'' as \"json_agg\" FROM profiles.vpa pv left join masters.vpa v on v.ivpaid = pv.ivpaid where tdate between cast(:StartDate as date)+1 and cast(:EndDate as date) and v.vcexternaladdressid = :VpaAddress"
    }
}', true, false, true);



INSERT INTO ui.dashboardfilters (idashboardfilterid, ifilterorder, vcdashboardfiltername, idashboardid, vcdashboardfiltertype, idashboardqueryidfordefaultvalue, idashboardqueryidforoptions, vcdashboardfilterdisplayname) VALUES (30, 0, 'DateRange', 14, 'DateRangePicker', 32, NULL, 'Date Range');
INSERT INTO ui.dashboardfilters (idashboardfilterid, ifilterorder, vcdashboardfiltername, idashboardid, vcdashboardfiltertype, idashboardqueryidfordefaultvalue, idashboardqueryidforoptions, vcdashboardfilterdisplayname) VALUES (31, 1, 'Party', 14, 'Select', NULL, 27, 'Level');
INSERT INTO ui.dashboardfilters (idashboardfilterid, ifilterorder, vcdashboardfiltername, idashboardid, vcdashboardfiltertype, idashboardqueryidfordefaultvalue, idashboardqueryidforoptions, vcdashboardfilterdisplayname) VALUES (32, 2, 'Type', 14, 'Select', NULL, 25, 'Type');
INSERT INTO ui.dashboardfilters (idashboardfilterid, ifilterorder, vcdashboardfiltername, idashboardid, vcdashboardfiltertype, idashboardqueryidfordefaultvalue, idashboardqueryidforoptions, vcdashboardfilterdisplayname) VALUES (33, 3, 'VpaAddress', 14, 'Input', NULL, NULL, 'Address');

INSERT INTO ui.dashboardqueryparameters (idashboardparameterid, vcparametername, vcparametertype, idashboardqueryid, iorder) VALUES (36, 'Party', 'JsonPath', 38, 0);
INSERT INTO ui.dashboardqueryparameters (idashboardparameterid, vcparametername, vcparametertype, idashboardqueryid, iorder) VALUES (37, 'Type', 'JsonPath', 38, 1);
INSERT INTO ui.dashboardqueryparameters (idashboardparameterid, vcparametername, vcparametertype, idashboardqueryid, iorder) VALUES (38, 'VpaAddress', 'String', 38, NULL);
INSERT INTO ui.dashboardqueryparameters (idashboardparameterid, vcparametername, vcparametertype, idashboardqueryid, iorder) VALUES (39, 'DateRange', 'DateRange', 38, NULL);
INSERT INTO ui.dashboardqueryparameters (idashboardparameterid, vcparametername, vcparametertype, idashboardqueryid, iorder) VALUES (40, 'Party', 'JsonPath', 39, 0);
INSERT INTO ui.dashboardqueryparameters (idashboardparameterid, vcparametername, vcparametertype, idashboardqueryid, iorder) VALUES (41, 'Type', 'JsonPath', 39, 1);
INSERT INTO ui.dashboardqueryparameters (idashboardparameterid, vcparametername, vcparametertype, idashboardqueryid, iorder) VALUES (42, 'VpaAddress', 'String', 39, NULL);
INSERT INTO ui.dashboardqueryparameters (idashboardparameterid, vcparametername, vcparametertype, idashboardqueryid, iorder) VALUES (43, 'DateRange', 'DateRange', 39, NULL);
INSERT INTO ui.dashboardqueryparameters (idashboardparameterid, vcparametername, vcparametertype, idashboardqueryid, iorder) VALUES (44, 'Party', 'JsonPath', 40, 0);
INSERT INTO ui.dashboardqueryparameters (idashboardparameterid, vcparametername, vcparametertype, idashboardqueryid, iorder) VALUES (45, 'Type', 'JsonPath', 40, 1);
INSERT INTO ui.dashboardqueryparameters (idashboardparameterid, vcparametername, vcparametertype, idashboardqueryid, iorder) VALUES (46, 'VpaAddress', 'String', 40, NULL);
INSERT INTO ui.dashboardqueryparameters (idashboardparameterid, vcparametername, vcparametertype, idashboardqueryid, iorder) VALUES (47, 'DateRange', 'DateRange', 40, NULL);
INSERT INTO ui.dashboardqueryparameters (idashboardparameterid, vcparametername, vcparametertype, idashboardqueryid, iorder) VALUES (48, 'Party', 'JsonPath', 41, 0);
INSERT INTO ui.dashboardqueryparameters (idashboardparameterid, vcparametername, vcparametertype, idashboardqueryid, iorder) VALUES (49, 'Type', 'JsonPath', 41, 1);
INSERT INTO ui.dashboardqueryparameters (idashboardparameterid, vcparametername, vcparametertype, idashboardqueryid, iorder) VALUES (50, 'VpaAddress', 'String', 41, NULL);
INSERT INTO ui.dashboardqueryparameters (idashboardparameterid, vcparametername, vcparametertype, idashboardqueryid, iorder) VALUES (51, 'DateRange', 'DateRange', 41, NULL);
INSERT INTO ui.dashboardqueryparameters (idashboardparameterid, vcparametername, vcparametertype, idashboardqueryid, iorder) VALUES (52, 'Party', 'JsonPath', 42, 0);
INSERT INTO ui.dashboardqueryparameters (idashboardparameterid, vcparametername, vcparametertype, idashboardqueryid, iorder) VALUES (53, 'Type', 'JsonPath', 42, 1);
INSERT INTO ui.dashboardqueryparameters (idashboardparameterid, vcparametername, vcparametertype, idashboardqueryid, iorder) VALUES (54, 'VpaAddress', 'String', 42, NULL);
INSERT INTO ui.dashboardqueryparameters (idashboardparameterid, vcparametername, vcparametertype, idashboardqueryid, iorder) VALUES (55, 'DateRange', 'DateRange', 42, NULL);
INSERT INTO ui.dashboardqueryparameters (idashboardparameterid, vcparametername, vcparametertype, idashboardqueryid, iorder) VALUES (56, 'Party', 'JsonPath', 43, 0);
INSERT INTO ui.dashboardqueryparameters (idashboardparameterid, vcparametername, vcparametertype, idashboardqueryid, iorder) VALUES (57, 'Type', 'JsonPath', 43, 1);
INSERT INTO ui.dashboardqueryparameters (idashboardparameterid, vcparametername, vcparametertype, idashboardqueryid, iorder) VALUES (58, 'VpaAddress', 'String', 43, NULL);
INSERT INTO ui.dashboardqueryparameters (idashboardparameterid, vcparametername, vcparametertype, idashboardqueryid, iorder) VALUES (59, 'DateRange', 'DateRange', 43, NULL);
INSERT INTO ui.dashboardqueryparameters (idashboardparameterid, vcparametername, vcparametertype, idashboardqueryid, iorder) VALUES (60, 'Party', 'JsonPath', 44, 0);
INSERT INTO ui.dashboardqueryparameters (idashboardparameterid, vcparametername, vcparametertype, idashboardqueryid, iorder) VALUES (61, 'Type', 'JsonPath', 44, 1);
INSERT INTO ui.dashboardqueryparameters (idashboardparameterid, vcparametername, vcparametertype, idashboardqueryid, iorder) VALUES (62, 'VpaAddress', 'String', 44, NULL);
INSERT INTO ui.dashboardqueryparameters (idashboardparameterid, vcparametername, vcparametertype, idashboardqueryid, iorder) VALUES (63, 'DateRange', 'DateRange', 44, NULL);

INSERT INTO ui.dashboardresultset (idashboardresultsetid, iresultsetorder, vcdashboardresultsetcolumnjson, vcdashboardresultsetlayout, vcdashboardresultsetname, idashboardqueryid, idashboardid, vcdashboardresultsetschema, icolsize, irowno) VALUES (18, NULL, NULL, ' {
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
 			"name": "Engagement",
 			"table": "engagement",
 			"linked": false
 		}
 	}
 }', 'engagement', 42, 14, NULL, 4, 2);

 INSERT INTO ui.dashboardresultset (idashboardresultsetid, iresultsetorder, vcdashboardresultsetcolumnjson, vcdashboardresultsetlayout, vcdashboardresultsetname, idashboardqueryid, idashboardid, vcdashboardresultsetschema, icolsize, irowno) VALUES (14, NULL, NULL, ' {
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
  }', 'partyprofile', 38, 14, NULL, 3, 1);

  INSERT INTO ui.dashboardresultset (idashboardresultsetid, iresultsetorder, vcdashboardresultsetcolumnjson, vcdashboardresultsetlayout, vcdashboardresultsetname, idashboardqueryid, idashboardid, vcdashboardresultsetschema, icolsize, irowno) VALUES (15, NULL, NULL, ' {
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
   			"name": "Longevity",
   			"table": "longevity",
   			"linked": false
   		}
   	}
   }', 'longevity', 39, 14, NULL, 3, 1);
  INSERT INTO ui.dashboardresultset (idashboardresultsetid, iresultsetorder, vcdashboardresultsetcolumnjson, vcdashboardresultsetlayout, vcdashboardresultsetname, idashboardqueryid, idashboardid, vcdashboardresultsetschema, icolsize, irowno) VALUES (16, NULL, NULL, ' {
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
   			"name": "Frequency",
   			"table": "frequency",
   			"linked": false
   		}
   	}
   }', 'frequency', 40, 14, NULL, 3, 1);
  INSERT INTO ui.dashboardresultset (idashboardresultsetid, iresultsetorder, vcdashboardresultsetcolumnjson, vcdashboardresultsetlayout, vcdashboardresultsetname, idashboardqueryid, idashboardid, vcdashboardresultsetschema, icolsize, irowno) VALUES (17, NULL, NULL, ' {
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
   			"name": "Velocity",
   			"table": "velocity",
   			"linked": false
   		}
   	}
   }', 'velocity', 41, 14, NULL, 3, 1);

   INSERT INTO ui.dashboardresultset (idashboardresultsetid, iresultsetorder, vcdashboardresultsetcolumnjson, vcdashboardresultsetlayout, vcdashboardresultsetname, idashboardqueryid, idashboardid, vcdashboardresultsetschema, icolsize, irowno) VALUES (19, NULL, NULL, ' {
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
    			"name": "Geospatial",
    			"table": "geospatial",
    			"linked": false
    		}
    	}
    }', 'geospatial', 43, 14, NULL, 4, 2);
   INSERT INTO ui.dashboardresultset (idashboardresultsetid, iresultsetorder, vcdashboardresultsetcolumnjson, vcdashboardresultsetlayout, vcdashboardresultsetname, idashboardqueryid, idashboardid, vcdashboardresultsetschema, icolsize, irowno) VALUES (20, NULL, NULL, ' {
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
    			"name": "Events",
    			"table": "events",
    			"linked": false
    		}
    	}
    }', 'events', 44, 14, NULL, 4, 2);


UPDATE ui.dashboard SET  iorder=1 WHERE idashboardid=11;
UPDATE ui.dashboard SET  iorder=2 WHERE idashboardid=2;
UPDATE ui.dashboard SET  iorder=3 WHERE idashboardid=3;
UPDATE ui.dashboard SET  iorder=4 WHERE idashboardid=4;
UPDATE ui.dashboard SET  iorder=5 WHERE idashboardid=5;
UPDATE ui.dashboard SET  iorder=6 WHERE idashboardid=12;
UPDATE ui.dashboard SET  iorder=7 WHERE idashboardid=13;
UPDATE ui.dashboard SET  iorder=8 WHERE idashboardid=7;
UPDATE ui.dashboard SET  iorder=9 WHERE idashboardid=8;
UPDATE ui.dashboard SET  iorder=10 WHERE idashboardid=9;
UPDATE ui.dashboard SET  iorder=11 WHERE idashboardid=1;
UPDATE ui.dashboard SET  iorder=12 WHERE idashboardid=6;
UPDATE ui.dashboard SET  iorder=13 WHERE idashboardid=10;
