INSERT INTO ui.dashboard (idashboardid, vcdashboardname, bactive, bdelete) VALUES (7, 'Device Fingerprint', true, false);
INSERT INTO ui.dashboard (idashboardid, vcdashboardname, bactive, bdelete) VALUES (8, 'IP Fingerprint', true, false);
INSERT INTO ui.dashboard (idashboardid, vcdashboardname, bactive, bdelete) VALUES (9, 'KS Dynamics', true, false);

INSERT INTO ui.dashboardfilters (idashboardfilterid, vcdashboardfiltername, idashboardid, ifilterorder, idashboardqueryid, vcdashboardfiltertype) VALUES (8, 'StartDate', 7, 0, NULL, 'DatePicker');
INSERT INTO ui.dashboardfilters (idashboardfilterid, vcdashboardfiltername, idashboardid, ifilterorder, idashboardqueryid, vcdashboardfiltertype) VALUES (9, 'EndDate', 7, 1, NULL, 'DatePicker');
INSERT INTO ui.dashboardfilters (idashboardfilterid, vcdashboardfiltername, idashboardid, ifilterorder, idashboardqueryid, vcdashboardfiltertype) VALUES (10, 'StartDate', 8, 0, NULL, 'DatePicker');
INSERT INTO ui.dashboardfilters (idashboardfilterid, vcdashboardfiltername, idashboardid, ifilterorder, idashboardqueryid, vcdashboardfiltertype) VALUES (11, 'EndDate', 8, 1, NULL, 'DatePicker');
INSERT INTO ui.dashboardfilters (idashboardfilterid, vcdashboardfiltername, idashboardid, ifilterorder, idashboardqueryid, vcdashboardfiltertype) VALUES (12, 'StartDate', 9, 0, NULL, 'DatePicker');
INSERT INTO ui.dashboardfilters (idashboardfilterid, vcdashboardfiltername, idashboardid, ifilterorder, idashboardqueryid, vcdashboardfiltertype) VALUES (13, 'EndDate', 9, 1, NULL, 'DatePicker');



UPDATE ui.dashboardquery
SET   vcdashboardquery='select * from(
SELECT a.iruleid,r.vcrulename, a.dtdate,
       sum(a.cntrule)
       OVER(ORDER BY a.iruleid, a.dtdate ROWS BETWEEN 0 PRECEDING AND CURRENT ROW)
       AS sumday,
  sum(a.cntrule)
       OVER(ORDER BY a.iruleid, a.dtdate ROWS BETWEEN 6 PRECEDING AND CURRENT ROW)
       AS sumweek
  ,
  sum(a.cntrule)
       OVER(ORDER BY a.iruleid, a.dtdate ROWS BETWEEN 30 PRECEDING AND CURRENT ROW)
       AS summonth
       FROM (select iruleid,DATE(dtcreateddatetime) as dtdate,count(*) cntrule from transactions.livedecisiondetails
where bpassed=false group by iruleid,DATE(dtcreateddatetime)) a, masters.rules r
where r.iruleid=a.iruleid )b where dtdate=:Date' WHERE idashboardqueryid=12;

INSERT INTO ui.dashboardquery (idashboardqueryid, bparametersrequired, vcfilterparametersjson, vcdashboardquery) VALUES (13, true, '{"StartDate" : null , "EndDate" : null}', 'select * from transactions.sp_getdatafingerprint_c(:StartDate,:EndDate)');
INSERT INTO ui.dashboardquery (idashboardqueryid, bparametersrequired, vcfilterparametersjson, vcdashboardquery) VALUES (14, true, '{"StartDate" : null , "EndDate" : null}', 'select * from transactions.sp_getdataipfingerprint_c(:StartDate,:EndDate)');
INSERT INTO ui.dashboardquery (idashboardqueryid, bparametersrequired, vcfilterparametersjson, vcdashboardquery) VALUES (15, true, '{"StartDate" : null , "EndDate" : null}', 'select * from transactions.sp_getdataksdynamics_c(:StartDate,:EndDate)');

UPDATE ui.dashboardquery SET vcdashboardquery='select * from profiles.sp_getdatavpa_c(false, :Date)' WHERE idashboardqueryid=8;
UPDATE ui.dashboardquery SET vcdashboardquery='select * from profiles.sp_getdatavpa_c(true, :Date)' WHERE idashboardqueryid=9;
UPDATE ui.dashboardquery SET vcdashboardquery='select adm3 as "District",b.* from profiles.sp_getdatalocation_c(:Date)b, masters.cities where cities.icityid= b."location.ilocationid"' WHERE idashboardqueryid=10;
UPDATE ui.dashboardquery SET vcdashboardquery='select * from profiles.sp_getdatamcc_c(:Date)' WHERE idashboardqueryid=11;
UPDATE ui.dashboardquery SET vcdashboardquery='select vcchannelname as "Trans Channel", b.* from transactions.sp_getdatalivetrans_c(:StartDate,:EndDate) b, masters.channels where channels.ichannelid =  CAST (b."channelID" AS INTEGER);' WHERE idashboardqueryid=7;


INSERT INTO ui.dashboardqueryparameters (iperspectiveparameterid, vcparametername, vcparametertype, idashboardqueryid) VALUES (13, 'StartDate', 'Date', 13);
INSERT INTO ui.dashboardqueryparameters (iperspectiveparameterid, vcparametername, vcparametertype, idashboardqueryid) VALUES (14, 'EndDate', 'Date', 13);
INSERT INTO ui.dashboardqueryparameters (iperspectiveparameterid, vcparametername, vcparametertype, idashboardqueryid) VALUES (15, 'StartDate', 'Date', 14);
INSERT INTO ui.dashboardqueryparameters (iperspectiveparameterid, vcparametername, vcparametertype, idashboardqueryid) VALUES (16, 'EndDate', 'Date', 14);
INSERT INTO ui.dashboardqueryparameters (iperspectiveparameterid, vcparametername, vcparametertype, idashboardqueryid) VALUES (17, 'StartDate', 'Date', 15);
INSERT INTO ui.dashboardqueryparameters (iperspectiveparameterid, vcparametername, vcparametertype, idashboardqueryid) VALUES (18, 'EndDate', 'Date', 15);


INSERT INTO ui.dashboardresultset (idashboardresultsetid, vcdashboardresultsetlayout, vcdashboardresultsetname, idashboardid, vcdashboardresultsetcolumnjson, iresultsetorder, idashboardqueryid) VALUES (7, ' {
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
 			"name": "Device Fingerprint",
 			"table": "devicefingerprint",
 			"linked": false
 		}
 	}
 }', 'devicefingerprint', 7, ' {
        "Cust ID":[],
        "Cust T Date":[],
        "First Txn":[],
        "Last Txn":[],
        "Onboarding Date":[],
        "Days In System":[],
        "Log Days In System":[],
        "First Int Txn Date":[],
        "D05 Txn Count":[],
        "D05 Txn Value":[],
        "D28 Txn Count":[],
        "D28 Txn Value":[],
        "Max Txn Value":[],
        "Active Day":[]
}', NULL, 13);
INSERT INTO ui.dashboardresultset (idashboardresultsetid, vcdashboardresultsetlayout, vcdashboardresultsetname, idashboardid, vcdashboardresultsetcolumnjson, iresultsetorder, idashboardqueryid) VALUES (8, ' {
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
 			"name": "IP Fingerprint",
 			"table": "ipfingerprint",
 			"linked": false
 		}
 	}
 }', 'ipfingerprint', 8, ' {
        "Cust ID":[],
        "Cust T Date":[],
        "First Txn":[],
        "Last Txn":[],
        "Onboarding Date":[],
        "Days In System":[],
        "Log Days In System":[],
        "First Int Txn Date":[],
        "D05 Txn Count":[],
        "D05 Txn Value":[],
        "D28 Txn Count":[],
        "D28 Txn Value":[],
        "Max Txn Value":[],
        "Active Day":[]
}', NULL, 14);
INSERT INTO ui.dashboardresultset (idashboardresultsetid, vcdashboardresultsetlayout, vcdashboardresultsetname, idashboardid, vcdashboardresultsetcolumnjson, iresultsetorder, idashboardqueryid) VALUES (9, ' {
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
 			"name": "KS Dynamics",
 			"table": "ksdynamics",
 			"linked": false
 		}
 	}
 }', 'ksdynamics', 9, ' {
        "Cust ID":[],
        "Cust T Date":[],
        "First Txn":[],
        "Last Txn":[],
        "Onboarding Date":[],
        "Days In System":[],
        "Log Days In System":[],
        "First Int Txn Date":[],
        "D05 Txn Count":[],
        "D05 Txn Value":[],
        "D28 Txn Count":[],
        "D28 Txn Value":[],
        "Max Txn Value":[],
        "Active Day":[]
}', NULL, 15);
