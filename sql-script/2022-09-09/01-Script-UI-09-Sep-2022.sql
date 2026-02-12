alter table if exists ui.dashboardquery add column formattingrequiered boolean;

alter table if exists ui.dashboardquery add column runonanalytics boolean;

alter table if exists ui.dashboardqueryparameters add column iorder int4;

INSERT INTO ui.dashboard (idashboardid, bactive, bdelete, vcdashboardname) VALUES (11, true, false, 'Transaction New');

INSERT INTO ui.dashboardquery (idashboardqueryid, bparametersrequired, vcfilterparametersjson, vcdashboardquery, formattingrequiered, runonanalytics) VALUES (30, true, '{"DateRange" : null, "VpaAddress":null, "Type":null, "Party": null}', '{
    "Account":{
        "Payer":"with recursive livetrn as (select * from transactions.trans l where l.vcpayeraccountexternalid = :VpaAddress  and  cast(dttrxntime at time zone ''Asia/Kolkata'' at time zone :timeZone as date) between cast(:StartDate as date) and cast( :EndDate as date) ) ,  flat (ilivemessageid, key, value) as ( select ilivemessageid,  ''trans'',cast(format(''{\"ilivemessageid\":%s}'',cast(ilivemessageid as text)) as jsonb) as value from livetrn union select ilivemessageid ,  key, value from livetrn, jsonb_each(observations) union select ilivemessageid,  key, value from livetrn, jsonb_each(result #- ''{score,observations}'') union select f.ilivemessageid, concat(f.key, ''.'', j.key), j.value from flat f, jsonb_each(f.value) j where jsonb_typeof(f.value) = ''object'' ) select cast(json_agg(data) as text) from ( select jsonb_object_agg(key, value) as data from flat where jsonb_typeof(value) <> ''object'' group by ilivemessageid ) a;",
        "Payee":"with recursive livetrn as (select * from transactions.trans l where l.vcpayeeaccountexternalid = :VpaAddress  and  cast(dttrxntime at time zone ''Asia/Kolkata'' at time zone :timeZone as date) between cast(:StartDate as date) and cast( :EndDate as date) ) ,  flat (ilivemessageid, key, value) as ( select ilivemessageid,  ''trans'',cast(format(''{\"ilivemessageid\":%s}'',cast(ilivemessageid as text)) as jsonb) as value from livetrn union select ilivemessageid ,  key, value from livetrn, jsonb_each(observations) union select ilivemessageid,  key, value from livetrn, jsonb_each(result #- ''{score,observations}'') union select f.ilivemessageid, concat(f.key, ''.'', j.key), j.value from flat f, jsonb_each(f.value) j where jsonb_typeof(f.value) = ''object'' ) select cast(json_agg(data) as text) from ( select jsonb_object_agg(key, value) as data from flat where jsonb_typeof(value) <> ''object'' group by ilivemessageid ) a;",
        "Both": "with recursive livetrn as (select * from transactions.trans l where (l.vcpayeraccountexternalid = :VpaAddress or l.vcpayeeaccountexternalid=l.vcpayeraccountexternalid ) and  cast(dttrxntime at time zone ''Asia/Kolkata'' at time zone :timeZone as date) between cast(:StartDate as date) and cast( :EndDate as date) ) ,  flat (ilivemessageid, key, value) as ( select ilivemessageid,  ''trans'',cast(format(''{\"ilivemessageid\":%s}'',cast(ilivemessageid as text)) as jsonb) as value from livetrn union select ilivemessageid ,  key, value from livetrn, jsonb_each(observations) union select ilivemessageid,  key, value from livetrn, jsonb_each(result #- ''{score,observations}'') union select f.ilivemessageid, concat(f.key, ''.'', j.key), j.value from flat f, jsonb_each(f.value) j where jsonb_typeof(f.value) = ''object'' ) select cast(json_agg(data) as text) from ( select jsonb_object_agg(key, value) as data from flat where jsonb_typeof(value) <> ''object'' group by ilivemessageid ) a;"
    },
    "VPA":{
        "Payer":"with recursive livetrn as (select * from transactions.trans l where l.vcpayeraddr = :VpaAddress  and  cast(dttrxntime at time zone ''Asia/Kolkata'' at time zone :timeZone as date) between cast(:StartDate as date) and cast( :EndDate as date) ) ,  flat (ilivemessageid, key, value) as ( select ilivemessageid,  ''trans'',cast(format(''{\"ilivemessageid\":%s}'',cast(ilivemessageid as text)) as jsonb) as value from livetrn union select ilivemessageid ,  key, value from livetrn, jsonb_each(observations) union select ilivemessageid,  key, value from livetrn, jsonb_each(result #- ''{score,observations}'') union select f.ilivemessageid, concat(f.key, ''.'', j.key), j.value from flat f, jsonb_each(f.value) j where jsonb_typeof(f.value) = ''object'' ) select cast(json_agg(data) as text) from ( select jsonb_object_agg(key, value) as data from flat where jsonb_typeof(value) <> ''object'' group by ilivemessageid ) a;",
        "Payee":"with recursive livetrn as (select * from transactions.trans l where l.vcpayeeaddr = :VpaAddress  and  cast(dttrxntime at time zone ''Asia/Kolkata'' at time zone :timeZone as date) between cast(:StartDate as date) and cast( :EndDate as date) ) ,  flat (ilivemessageid, key, value) as ( select ilivemessageid,  ''trans'',cast(format(''{\"ilivemessageid\":%s}'',cast(ilivemessageid as text)) as jsonb) as value from livetrn union select ilivemessageid ,  key, value from livetrn, jsonb_each(observations) union select ilivemessageid,  key, value from livetrn, jsonb_each(result #- ''{score,observations}'') union select f.ilivemessageid, concat(f.key, ''.'', j.key), j.value from flat f, jsonb_each(f.value) j where jsonb_typeof(f.value) = ''object'' ) select cast(json_agg(data) as text) from ( select jsonb_object_agg(key, value) as data from flat where jsonb_typeof(value) <> ''object'' group by ilivemessageid ) a;",
        "Both":"with recursive livetrn as (select * from transactions.trans l where (l.vcpayeeaddr = :VpaAddress or l.vcpayeraddr = l.vcpayeeaddr) and  cast(dttrxntime at time zone ''Asia/Kolkata'' at time zone :timeZone as date) between cast(:StartDate as date) and cast( :EndDate as date) ) ,  flat (ilivemessageid, key, value) as ( select ilivemessageid,  ''trans'',cast(format(''{\"ilivemessageid\":%s}'',cast(ilivemessageid as text)) as jsonb) as value from livetrn union select ilivemessageid ,  key, value from livetrn, jsonb_each(observations) union select ilivemessageid,  key, value from livetrn, jsonb_each(result #- ''{score,observations}'') union select f.ilivemessageid, concat(f.key, ''.'', j.key), j.value from flat f, jsonb_each(f.value) j where jsonb_typeof(f.value) = ''object'' ) select cast(json_agg(data) as text) from ( select jsonb_object_agg(key, value) as data from flat where jsonb_typeof(value) <> ''object'' group by ilivemessageid ) a;"
    }
}



with recursive livetrn as ( select * from transactions.trans l where (l.vcpayeraccountexternalid = :VpaAddress or l.vcpayeeaccountexternalid= :VpaAddress ) and  cast(dttrxntime at time zone ''Asia/Kolkata'' at time zone ''Asia/Kolkata'' as date) between ''2022-09-07'' and ''2022-09-08'' ) ', true, true);

INSERT INTO ui.dashboardfilters (idashboardfilterid, ifilterorder, vcdashboardfiltername, idashboardid, vcdashboardfiltertype, idashboardqueryidfordefaultvalue, idashboardqueryidforoptions, vcdashboardfilterdisplayname) VALUES (20, 2, 'Type', 11, 'Select', NULL, 25, 'Type');
INSERT INTO ui.dashboardfilters (idashboardfilterid, ifilterorder, vcdashboardfiltername, idashboardid, vcdashboardfiltertype, idashboardqueryidfordefaultvalue, idashboardqueryidforoptions, vcdashboardfilterdisplayname) VALUES (21, 1, 'Party', 11, 'Select', NULL, 27, 'Level');
INSERT INTO ui.dashboardfilters (idashboardfilterid, ifilterorder, vcdashboardfiltername, idashboardid, vcdashboardfiltertype, idashboardqueryidfordefaultvalue, idashboardqueryidforoptions, vcdashboardfilterdisplayname) VALUES (22, 3, 'VpaAddress', 11, 'Input', NULL, NULL, 'Address');
INSERT INTO ui.dashboardfilters (idashboardfilterid, ifilterorder, vcdashboardfiltername, idashboardid, vcdashboardfiltertype, idashboardqueryidfordefaultvalue, idashboardqueryidforoptions, vcdashboardfilterdisplayname) VALUES (23, 0, 'DateRange', 11, 'DateRangePicker', 16, NULL, 'Date Range');

INSERT INTO ui.dashboardqueryparameters (idashboardparameterid, vcparametername, vcparametertype, idashboardqueryid, iorder) VALUES (26, 'Party', 'JsonPath', 30, 0);
INSERT INTO ui.dashboardqueryparameters (idashboardparameterid, vcparametername, vcparametertype, idashboardqueryid, iorder) VALUES (27, 'Type', 'JsonPath', 30, 1);
INSERT INTO ui.dashboardqueryparameters (idashboardparameterid, vcparametername, vcparametertype, idashboardqueryid, iorder) VALUES (28, 'VpaAddress', 'String', 30, NULL);
INSERT INTO ui.dashboardqueryparameters (idashboardparameterid, vcparametername, vcparametertype, idashboardqueryid, iorder) VALUES (29, 'DateRange', 'DateRange', 30, NULL);

INSERT INTO ui.dashboardresultset (idashboardresultsetid, iresultsetorder, vcdashboardresultsetcolumnjson, vcdashboardresultsetlayout, vcdashboardresultsetname, idashboardqueryid, idashboardid, vcdashboardresultsetschema) VALUES (11, NULL, NULL, ' {
 	"sizes": [
 		1
 	],
 	"master": {
 		"widgets": ["PERSPECTIVE_GENERATED_ID_1"]
 	},
 	"viewers": {
 		"PERSPECTIVE_GENERATED_ID_1": {
                        "settings":true,
 			"selectable": false,
 			"plugin": "datagrid",
 			"master": true,
 			"name": "Testing",
 			"table": "testing",
 			"linked": false
 		}
 	}
 }', 'testing', 30, 11, NULL);