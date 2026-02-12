truncate ui.dashboard cascade;
truncate ui.dashboardquery cascade;
truncate ui.dashboardfilters cascade;
truncate ui.dashboardqueryparameters cascade;
truncate ui.dashboardresultset cascade;


INSERT INTO ui.dashboard (idashboardid, vcdashboardname, bactive, bdelete) VALUES (1, 'Transaction', true, false);
INSERT INTO ui.dashboard (idashboardid, vcdashboardname, bactive, bdelete) VALUES (2, 'Payer Profile', true, false);
INSERT INTO ui.dashboard (idashboardid, vcdashboardname, bactive, bdelete) VALUES (3, 'Payee Profile', true, false);
INSERT INTO ui.dashboard (idashboardid, vcdashboardname, bactive, bdelete) VALUES (4, 'Location Profile', true, false);
INSERT INTO ui.dashboard (idashboardid, vcdashboardname, bactive, bdelete) VALUES (5, 'MCC Profile', true, false);
INSERT INTO ui.dashboard (idashboardid, vcdashboardname, bactive, bdelete) VALUES (6, 'Rule Efficiency Report', true, false);
INSERT INTO ui.dashboard (idashboardid, vcdashboardname, bactive, bdelete) VALUES (7, 'Device Fingerprint', true, false);
INSERT INTO ui.dashboard (idashboardid, vcdashboardname, bactive, bdelete) VALUES (8, 'IP Fingerprint', true, false);
INSERT INTO ui.dashboard (idashboardid, vcdashboardname, bactive, bdelete) VALUES (9, 'KS Dynamics', true, false);

INSERT INTO ui.dashboardquery (idashboardqueryid, bparametersrequired, vcfilterparametersjson, vcdashboardquery) VALUES (1, false, NULL, 'SELECT DISTINCT  REPLACE(REPLACE(SPLIT_PART(vcpath,''.'',1),''['',''''),'']'',''''), false  FROM profiles.metadata
');
INSERT INTO ui.dashboardquery (idashboardqueryid, bparametersrequired, vcfilterparametersjson, vcdashboardquery) VALUES (3, false, NULL, 'SELECT DISTINCT  REPLACE(REPLACE(SPLIT_PART(vcpath,''.'',1),''['',''''),'']'',''''), false  FROM profiles.metadata
');
INSERT INTO ui.dashboardquery (idashboardqueryid, bparametersrequired, vcfilterparametersjson, vcdashboardquery) VALUES (2, true, '{"Label1" : null}', 'SELECT DISTINCT bside, true from profiles.:Label1
');
INSERT INTO ui.dashboardquery (idashboardqueryid, bparametersrequired, vcfilterparametersjson, vcdashboardquery) VALUES (4, true, '{"Label1" : null , "Label2" : null}', 'SELECT * from profiles.fngetFilter(:Label1,:Label2)');
INSERT INTO ui.dashboardquery (idashboardqueryid, bparametersrequired, vcfilterparametersjson, vcdashboardquery) VALUES (5, true, '{"Label1" : null , "Label3" : null}', 'SELECT icustomerid,velocity ->> ''d05_txn_count'' as "d05_txn_count"
,velocity ->> ''d05_txn_value'' as "d05_txn_value"
,velocity ->> ''d28_txn_count'' as "d28_txn_count"
,velocity ->> ''d28_txn_value'' as "d28_txn_value" FROM profiles.:Label1 where icustomerid=:Label3');
INSERT INTO ui.dashboardquery (idashboardqueryid, bparametersrequired, vcfilterparametersjson, vcdashboardquery) VALUES (6, false, NULL, 'select * from profiles.sp_getdatacust(''cust'')');
INSERT INTO ui.dashboardquery (idashboardqueryid, bparametersrequired, vcfilterparametersjson, vcdashboardquery) VALUES (16, false, NULL, 'select dtTrxnTime as "Time" from transactions.vw_LiveTrans order by dtTrxnTime desc limit 1');
INSERT INTO ui.dashboardquery (idashboardqueryid, bparametersrequired, vcfilterparametersjson, vcdashboardquery) VALUES (17, false, NULL, 'select tdate from profiles.vpa where bside=false order by tdate desc limit 1');
INSERT INTO ui.dashboardquery (idashboardqueryid, bparametersrequired, vcfilterparametersjson, vcdashboardquery) VALUES (18, false, NULL, 'select tdate from profiles.vpa where bside=true order by tdate desc limit 1');
INSERT INTO ui.dashboardquery (idashboardqueryid, bparametersrequired, vcfilterparametersjson, vcdashboardquery) VALUES (19, false, NULL, 'select tdate from profiles.location order by tdate desc limit 1');
INSERT INTO ui.dashboardquery (idashboardqueryid, bparametersrequired, vcfilterparametersjson, vcdashboardquery) VALUES (20, false, NULL, 'select tdate from profiles.mcc order by tdate desc limit 1');
INSERT INTO ui.dashboardquery (idashboardqueryid, bparametersrequired, vcfilterparametersjson, vcdashboardquery) VALUES (13, true, '{"DateRange" : null}', 'select * from transactions.sp_getdatafingerprint_c(:StartDate,:EndDate)');
INSERT INTO ui.dashboardquery (idashboardqueryid, bparametersrequired, vcfilterparametersjson, vcdashboardquery) VALUES (14, true, '{"DateRange" : null}', 'select * from transactions.sp_getdataipfingerprint_c(:StartDate,:EndDate)');
INSERT INTO ui.dashboardquery (idashboardqueryid, bparametersrequired, vcfilterparametersjson, vcdashboardquery) VALUES (15, true, '{"DateRange" : null}', 'select * from transactions.sp_getdataksdynamics_c(:StartDate,:EndDate)');
INSERT INTO ui.dashboardquery (idashboardqueryid, bparametersrequired, vcfilterparametersjson, vcdashboardquery) VALUES (12, true, '{"Date" : null }', 'select vcrulename as "Rule", dtdate as "Time Stamp", sumday as "Day-Sum", sumweek as "Week-Sum", summonth as "Month-Sum" from(
SELECT a.iruleid,r.vcrulename, a.dtdate,
       sum(a.cntrule)
       OVER(ORDER BY a.iruleid, a.dtdate ROWS BETWEEN 0 PRECEDING AND CURRENT ROW)
       AS sumday,
  sum(a.cntrule)
       OVER(ORDER BY a.iruleid, a.dtdate ROWS BETWEEN 6 PRECEDING AND CURRENT ROW)
       AS sumweek,
  sum(a.cntrule)
       OVER(ORDER BY a.iruleid, a.dtdate ROWS BETWEEN 30 PRECEDING AND CURRENT ROW)
       AS summonth
       FROM (
select x.iruleid,dtcreateddate as dtdate,sum(CASE WHEN bpassed is null THEN 0 else case when bpassed then 0 else 1 end END) cntrule from
			 (
				select iruleid,dtcreateddate from masters.rules r,
              (SELECT cast(generate_series(min(dtcreateddatetime), max(dtcreateddatetime), ''1d'') as date) AS dtcreateddate
              FROM   transactions.livedecisiondetails) b
               ) x
           LEFT  JOIN
			 transactions.livedecisiondetails d ON dtcreateddate =cast(dtcreateddatetime as date) and x.iruleid=d.iruleid
group by x.iruleid,x.dtcreateddate  order by x.iruleid,dtcreateddate) a, masters.rules r
where r.iruleid=a.iruleid )b where dtdate=:Date');
INSERT INTO ui.dashboardquery (idashboardqueryid, bparametersrequired, vcfilterparametersjson, vcdashboardquery) VALUES (23, false, NULL, 'select cast(dtentrydatetime as date) from transactions.live_clientkeystrokedynamics order by dtentrydatetime desc limit 1');
INSERT INTO ui.dashboardquery (idashboardqueryid, bparametersrequired, vcfilterparametersjson, vcdashboardquery) VALUES (24, false, NULL, 'select cast(dtentrydatetime as date) from transactions.live_fingerprints order by dtentrydatetime desc limit 1');
INSERT INTO ui.dashboardquery (idashboardqueryid, bparametersrequired, vcfilterparametersjson, vcdashboardquery) VALUES (21, false, NULL, 'select cast(dtcreateddatetime as date) from transactions.livedecisiondetails where bpassed=false order by dtcreateddatetime desc limit 1');
INSERT INTO ui.dashboardquery (idashboardqueryid, bparametersrequired, vcfilterparametersjson, vcdashboardquery) VALUES (9, true, '{"Date" : null, "VpaAddress": null }', 'select * from profiles.sp_getdatavpa_c(false,:Date,:VpaAddress)');
INSERT INTO ui.dashboardquery (idashboardqueryid, bparametersrequired, vcfilterparametersjson, vcdashboardquery) VALUES (22, false, NULL, 'select cast(dtentrydatetime as date) from transactions.live_clientipaddresses order by dtentrydatetime desc limit 1');
INSERT INTO ui.dashboardquery (idashboardqueryid, bparametersrequired, vcfilterparametersjson, vcdashboardquery) VALUES (11, true, '{"Date" : null }', 'select * from profiles.sp_getdatamcc_c(:Date)');
INSERT INTO ui.dashboardquery (idashboardqueryid, bparametersrequired, vcfilterparametersjson, vcdashboardquery) VALUES (26, false, NULL, 'SELECT  adm3, icityid, true FROM masters.cities;');
INSERT INTO ui.dashboardquery (idashboardqueryid, bparametersrequired, vcfilterparametersjson, vcdashboardquery) VALUES (10, true, '{"Date" : null, "LocationAddress" : null}', 'select adm3 as "District",b.* from profiles.sp_getdatalocation_c(:Date, :LocationAddress)b, masters.cities where cities.icityid= b."location.ilocationid"');
INSERT INTO ui.dashboardquery (idashboardqueryid, bparametersrequired, vcfilterparametersjson, vcdashboardquery) VALUES (8, true, '{"Date" : null , "VpaAddress" : null}', '
select vcaddress,b.* from profiles.sp_getdatavpa_c(true, :Date, :VpaAddress) b,masters.vpa where vpa.Ivpaid= b."vpa.ivpaid"');
INSERT INTO ui.dashboardquery (idashboardqueryid, bparametersrequired, vcfilterparametersjson, vcdashboardquery) VALUES (27, false, NULL, 'SELECT X.* FROM   (VALUES (''Account'', ''Account''),(''VPA'', ''VPA'')) AS X ("label", "value");');
INSERT INTO ui.dashboardquery (idashboardqueryid, bparametersrequired, vcfilterparametersjson, vcdashboardquery) VALUES (25, true, '{"Party" : null }', 'SELECT * from ui.gettypeoptions( :Party )');
INSERT INTO ui.dashboardquery (idashboardqueryid, bparametersrequired, vcfilterparametersjson, vcdashboardquery) VALUES (7, true, '{"DateRange" : null, "VpaAddress":null, "Type":null, "Party": null}', 'Select * from masters.getlivedata(:Type, :StartDate, :EndDate, :VpaAddress, :timeZone, :Party, 1000);');


INSERT INTO ui.dashboardqueryparameters (idashboardparameterid, vcparametername, vcparametertype, idashboardqueryid) VALUES (1, 'Label1', 'TableName', 2);
INSERT INTO ui.dashboardqueryparameters (idashboardparameterid, vcparametername, vcparametertype, idashboardqueryid) VALUES (2, 'Label1', 'String', 4);
INSERT INTO ui.dashboardqueryparameters (idashboardparameterid, vcparametername, vcparametertype, idashboardqueryid) VALUES (3, 'Label2', 'Boolean', 4);
INSERT INTO ui.dashboardqueryparameters (idashboardparameterid, vcparametername, vcparametertype, idashboardqueryid) VALUES (5, 'Label1', 'TableName', 5);
INSERT INTO ui.dashboardqueryparameters (idashboardparameterid, vcparametername, vcparametertype, idashboardqueryid) VALUES (4, 'Label3', 'Integer', 5);
INSERT INTO ui.dashboardqueryparameters (idashboardparameterid, vcparametername, vcparametertype, idashboardqueryid) VALUES (8, 'Date', 'Date', 8);
INSERT INTO ui.dashboardqueryparameters (idashboardparameterid, vcparametername, vcparametertype, idashboardqueryid) VALUES (9, 'Date', 'Date', 9);
INSERT INTO ui.dashboardqueryparameters (idashboardparameterid, vcparametername, vcparametertype, idashboardqueryid) VALUES (10, 'Date', 'Date', 10);
INSERT INTO ui.dashboardqueryparameters (idashboardparameterid, vcparametername, vcparametertype, idashboardqueryid) VALUES (11, 'Date', 'Date', 11);
INSERT INTO ui.dashboardqueryparameters (idashboardparameterid, vcparametername, vcparametertype, idashboardqueryid) VALUES (12, 'Date', 'Date', 12);
INSERT INTO ui.dashboardqueryparameters (idashboardparameterid, vcparametername, vcparametertype, idashboardqueryid) VALUES (6, 'DateRange', 'DateRange', 7);
INSERT INTO ui.dashboardqueryparameters (idashboardparameterid, vcparametername, vcparametertype, idashboardqueryid) VALUES (13, 'DateRange', 'DateRange', 13);
INSERT INTO ui.dashboardqueryparameters (idashboardparameterid, vcparametername, vcparametertype, idashboardqueryid) VALUES (15, 'DateRange', 'DateRange', 14);
INSERT INTO ui.dashboardqueryparameters (idashboardparameterid, vcparametername, vcparametertype, idashboardqueryid) VALUES (17, 'DateRange', 'DateRange', 15);
INSERT INTO ui.dashboardqueryparameters (idashboardparameterid, vcparametername, vcparametertype, idashboardqueryid) VALUES (18, 'VpaAddress', 'String', 7);
INSERT INTO ui.dashboardqueryparameters (idashboardparameterid, vcparametername, vcparametertype, idashboardqueryid) VALUES (19, 'Type', 'String', 7);
INSERT INTO ui.dashboardqueryparameters (idashboardparameterid, vcparametername, vcparametertype, idashboardqueryid) VALUES (20, 'VpaAddress', 'String', 8);
INSERT INTO ui.dashboardqueryparameters (idashboardparameterid, vcparametername, vcparametertype, idashboardqueryid) VALUES (21, 'VpaAddress', 'String', 9);
INSERT INTO ui.dashboardqueryparameters (idashboardparameterid, vcparametername, vcparametertype, idashboardqueryid) VALUES (22, 'LocationAddress', 'Integer', 10);
INSERT INTO ui.dashboardqueryparameters (idashboardparameterid, vcparametername, vcparametertype, idashboardqueryid) VALUES (23, 'Party', 'String', 25);
INSERT INTO ui.dashboardqueryparameters (idashboardparameterid, vcparametername, vcparametertype, idashboardqueryid) VALUES (24, 'Party', 'String', 7);


INSERT INTO ui.dashboardfilters (idashboardfilterid, vcdashboardfiltername, idashboardid, ifilterorder, vcdashboardfiltertype, idashboardqueryidfordefaultvalue, idashboardqueryidforoptions, vcdashboardfilterdisplayname) VALUES (3, 'Date', 2, 0, 'DatePicker', 17, NULL, 'Date');
INSERT INTO ui.dashboardfilters (idashboardfilterid, vcdashboardfiltername, idashboardid, ifilterorder, vcdashboardfiltertype, idashboardqueryidfordefaultvalue, idashboardqueryidforoptions, vcdashboardfilterdisplayname) VALUES (4, 'Date', 3, 0, 'DatePicker', 18, NULL, 'Date');
INSERT INTO ui.dashboardfilters (idashboardfilterid, vcdashboardfiltername, idashboardid, ifilterorder, vcdashboardfiltertype, idashboardqueryidfordefaultvalue, idashboardqueryidforoptions, vcdashboardfilterdisplayname) VALUES (5, 'Date', 4, 0, 'DatePicker', 19, NULL, 'Date');
INSERT INTO ui.dashboardfilters (idashboardfilterid, vcdashboardfiltername, idashboardid, ifilterorder, vcdashboardfiltertype, idashboardqueryidfordefaultvalue, idashboardqueryidforoptions, vcdashboardfilterdisplayname) VALUES (6, 'Date', 5, 0, 'DatePicker', 20, NULL, 'Date');
INSERT INTO ui.dashboardfilters (idashboardfilterid, vcdashboardfiltername, idashboardid, ifilterorder, vcdashboardfiltertype, idashboardqueryidfordefaultvalue, idashboardqueryidforoptions, vcdashboardfilterdisplayname) VALUES (7, 'Date', 6, 0, 'DatePicker', 21, NULL, 'Date');
INSERT INTO ui.dashboardfilters (idashboardfilterid, vcdashboardfiltername, idashboardid, ifilterorder, vcdashboardfiltertype, idashboardqueryidfordefaultvalue, idashboardqueryidforoptions, vcdashboardfilterdisplayname) VALUES (8, 'DateRange', 7, 0, 'DateRangePicker', 22, NULL, 'Date Range');
INSERT INTO ui.dashboardfilters (idashboardfilterid, vcdashboardfiltername, idashboardid, ifilterorder, vcdashboardfiltertype, idashboardqueryidfordefaultvalue, idashboardqueryidforoptions, vcdashboardfilterdisplayname) VALUES (10, 'DateRange', 8, 0, 'DateRangePicker', 24, NULL, 'Date Range');
INSERT INTO ui.dashboardfilters (idashboardfilterid, vcdashboardfiltername, idashboardid, ifilterorder, vcdashboardfiltertype, idashboardqueryidfordefaultvalue, idashboardqueryidforoptions, vcdashboardfilterdisplayname) VALUES (12, 'DateRange', 9, 0, 'DateRangePicker', 23, NULL, 'Date Range');
INSERT INTO ui.dashboardfilters (idashboardfilterid, vcdashboardfiltername, idashboardid, ifilterorder, vcdashboardfiltertype, idashboardqueryidfordefaultvalue, idashboardqueryidforoptions, vcdashboardfilterdisplayname) VALUES (13, 'VpaAddress', 1, 2, 'Input', NULL, NULL, 'User');
INSERT INTO ui.dashboardfilters (idashboardfilterid, vcdashboardfiltername, idashboardid, ifilterorder, vcdashboardfiltertype, idashboardqueryidfordefaultvalue, idashboardqueryidforoptions, vcdashboardfilterdisplayname) VALUES (14, 'Type', 1, 1, 'Select', NULL, 25, 'Type');
INSERT INTO ui.dashboardfilters (idashboardfilterid, vcdashboardfiltername, idashboardid, ifilterorder, vcdashboardfiltertype, idashboardqueryidfordefaultvalue, idashboardqueryidforoptions, vcdashboardfilterdisplayname) VALUES (15, 'VpaAddress', 2, 1, 'Input', NULL, NULL, 'Address/Account No.');
INSERT INTO ui.dashboardfilters (idashboardfilterid, vcdashboardfiltername, idashboardid, ifilterorder, vcdashboardfiltertype, idashboardqueryidfordefaultvalue, idashboardqueryidforoptions, vcdashboardfilterdisplayname) VALUES (16, 'VpaAddress', 3, 1, 'Input', NULL, NULL, 'Address/Account No.');
INSERT INTO ui.dashboardfilters (idashboardfilterid, vcdashboardfiltername, idashboardid, ifilterorder, vcdashboardfiltertype, idashboardqueryidfordefaultvalue, idashboardqueryidforoptions, vcdashboardfilterdisplayname) VALUES (17, 'LocationAddress', 4, 1, 'Select', NULL, 26, 'Location Address');
INSERT INTO ui.dashboardfilters (idashboardfilterid, vcdashboardfiltername, idashboardid, ifilterorder, vcdashboardfiltertype, idashboardqueryidfordefaultvalue, idashboardqueryidforoptions, vcdashboardfilterdisplayname) VALUES (1, 'DateRange', 1, 3, 'DateRangePicker', 16, NULL, 'Date Range');
INSERT INTO ui.dashboardfilters (idashboardfilterid, vcdashboardfiltername, idashboardid, ifilterorder, vcdashboardfiltertype, idashboardqueryidfordefaultvalue, idashboardqueryidforoptions, vcdashboardfilterdisplayname) VALUES (18, 'Party', 1, 0, 'Select', NULL, 27, 'Party');



INSERT INTO ui.dashboardresultset (idashboardresultsetid, vcdashboardresultsetlayout, vcdashboardresultsetname, idashboardid, vcdashboardresultsetcolumnjson, iresultsetorder, idashboardqueryid) VALUES (2, ' {
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
                "name": "Payer Profile",
                "table": "payerprofile",
                "linked": false
            }
        }
    }', 'payerprofile', 2, ' {
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
}', NULL, 8);
INSERT INTO ui.dashboardresultset (idashboardresultsetid, vcdashboardresultsetlayout, vcdashboardresultsetname, idashboardid, vcdashboardresultsetcolumnjson, iresultsetorder, idashboardqueryid) VALUES (1, ' {
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
                "name": "Transaction",
                "table": "transaction",
                "linked": false
            }
        }
    }', 'transaction', 1, ' {
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
}', NULL, 7);
INSERT INTO ui.dashboardresultset (idashboardresultsetid, vcdashboardresultsetlayout, vcdashboardresultsetname, idashboardid, vcdashboardresultsetcolumnjson, iresultsetorder, idashboardqueryid) VALUES (3, ' {
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
                "name": "Payee Profile",
                "table": "payeeprofile",
                "linked": false
            }
        }
    }', 'payeeprofile', 3, ' {
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
}', NULL, 9);
INSERT INTO ui.dashboardresultset (idashboardresultsetid, vcdashboardresultsetlayout, vcdashboardresultsetname, idashboardid, vcdashboardresultsetcolumnjson, iresultsetorder, idashboardqueryid) VALUES (4, ' {
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
 			"name": "Location Profile",
 			"table": "locationprofile",
 			"linked": false
 		}
 	}
 }', 'locationprofile', 4, ' {
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
}', NULL, 10);
INSERT INTO ui.dashboardresultset (idashboardresultsetid, vcdashboardresultsetlayout, vcdashboardresultsetname, idashboardid, vcdashboardresultsetcolumnjson, iresultsetorder, idashboardqueryid) VALUES (5, ' {
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
 			"name": "MCC Profile",
 			"table": "mccprofile",
 			"linked": false
 		}
 	}
 }', 'mccprofile', 5, ' {
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
}', NULL, 11);
INSERT INTO ui.dashboardresultset (idashboardresultsetid, vcdashboardresultsetlayout, vcdashboardresultsetname, idashboardid, vcdashboardresultsetcolumnjson, iresultsetorder, idashboardqueryid) VALUES (6, '{
   "sizes":[
      1
   ],
   "master":{
      "widgets":[
         "PERSPECTIVE_GENERATED_ID_1"
      ]
   },
   "viewers":{
      "PERSPECTIVE_GENERATED_ID_1":{
         "settings":true,
         "selectable":false,
         "plugin":"datagrid",
         "columns":[
            "Rule",
            "Time Stamp",
            "Day-Sum",
            "Week-Sum",
            "Month-Sum"
         ],
         "master":true,
         "name":"Rule Efficiency Report",
         "table":"ruleefficiencyreport",
         "linked":false
      }
   }
}', 'ruleefficiencyreport', 6, ' {
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
}', NULL, 12);
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



truncate ui.perspectivequeryparameters cascade ;
truncate ui.perspectivequery cascade ;


INSERT INTO ui.perspectivequery (iperspectivequeryid, vcquery, vctablename) VALUES (4, 'select
iLiveMessageID as "ID",
vcmsgid as "Unique ID",
dtTrxnTime at time zone ''utc'' at time zone :timeZone as "Time",
cast(observations  ->  ''payer'' ->> ''addr''  as text) as "Payer VPA",
cast(observations  ->  ''payer'' -> ''attribs'' -> ''identity'' ->> ''verified_name''as text) as "Payer Name",
cast(observations  ->  ''payee'' ->> ''addr''  as text) as "Payee VPA",
cast(observations  ->  ''payee'' -> ''attribs'' -> ''identity'' ->> ''verified_name'' as text) as "Payee Name",
dTransAmount as "Amount",
bFRMPassed as "FRM Pass",
score as "Score",
vcrulename as "Rule",
cast(observations  ->  ''observations'' -> ''payerVPA'' -> ''account'' ->> ''accountNumber''  as text) as "Payer Account",
cast(observations  ->  ''observations'' -> ''payeeVPA'' -> ''account'' ->> ''accountNumber'' as text) as "Payee Account"
from transactions.vw_LiveTrans where txnclass = :className order by dtTrxnTime desc
limit 50', 'livetransactionbyclass');
INSERT INTO ui.perspectivequery (iperspectivequeryid, vcquery, vctablename) VALUES (3, 'select
iLiveMessageID as "ID",
vcmsgid as "Unique ID",
dtTrxnTime at time zone ''utc'' at time zone :timeZone as "Time",
cast(observations  ->  ''payer'' ->> ''addr''  as text) as "Payer VPA",
cast(observations  ->  ''payer'' -> ''attribs'' -> ''identity'' ->> ''verified_name''as text) as "Payer Name",
cast(observations  ->  ''payee'' ->> ''addr''  as text) as "Payee VPA",
cast(observations  ->  ''payee'' -> ''attribs'' -> ''identity'' ->> ''verified_name'' as text) as "Payee Name",
dTransAmount as "Amount",
bFRMPassed as "FRM Pass",
score as "Score",
vcrulename as "Rule",
cast(observations  ->  ''observations'' -> ''payerVPA'' -> ''account'' ->> ''accountNumber''  as text) as "Payer Account",
cast(observations  ->  ''observations'' -> ''payeeVPA'' -> ''account'' ->> ''accountNumber'' as text) as "Payee Account"
from transactions.vw_LiveTrans order by dtTrxnTime desc
limit 50', 'livetransaction');
INSERT INTO ui.perspectivequery (iperspectivequeryid, vcquery, vctablename) VALUES (20, 'select
vcmsgid as "Unique ID",
dtTrxnTime at time zone ''utc'' at time zone :timeZone as "Time",
Payer.vcAddress as "Payer VPA",
Payee.vcAddress as "Payee VPA",
dTransAmount as "Amount",
ld.vcremark as "Remark",
ld.dscore as  "Rule Score"
from transactions.vw_livetrans L, masters.VPA Payer, masters.VPA Payee, transactions.LiveDecisionDetails ld where
Payer.iVPAID = L.iPayerVPAID   and Payee.iVPAID = L.iPayeeVPAID and ld.ilivemessageid= L.ilivemessageid and score=:score
and ld.dscore > 0 and dtTrxnTime between now() - cast(:lastTime as interval)  AND now()
order by dtTrxnTime desc', 'alertTransactions');
INSERT INTO ui.perspectivequery (iperspectivequeryid, vcquery, vctablename) VALUES (19, 'SELECT l.ilivemessageid, lt.vcmsgid, r.iruleid, r.vcrulename, l.bpassed, l.dscore, l.dinfo, l.vcremark, l.dtcreateddatetime
from transactions.LiveDecisionDetails l, masters.Rules r, transactions.livetrans lt
where  l.ilivemessageid = :iLiveMessageID and r.iRuleID=l.iRuleID and l.ilivemessageid = lt.ilivemessageid
order by dscore desc', 'decisiondetailsforlivetrans');
INSERT INTO ui.perspectivequery (iperspectivequeryid, vcquery, vctablename) VALUES (16, 'select
iLiveMessageID as "ID",
vcmsgid as "Unique ID",
dtTrxnTime at time zone ''utc'' at time zone :timeZone as "Time",
cast(observations  ->  ''payer'' ->> ''addr''  as text) as "Payer VPA",
cast(observations  ->  ''payer'' -> ''attribs'' -> ''identity'' ->> ''verified_name''as text) as "Payer Name",
cast(observations  ->  ''payee'' ->> ''addr''  as text) as "Payee VPA",
cast(observations  ->  ''payee'' -> ''attribs'' -> ''identity'' ->> ''verified_name'' as text) as "Payee Name",
dTransAmount as "Amount",
bFRMPassed as "FRM Pass",
score as "Score",
vcrulename as "Rule",
cast(observations  ->  ''observations'' -> ''payerVPA'' -> ''account'' ->> ''accountNumber''  as text) as "Payer Account",
cast(observations  ->  ''observations'' -> ''payeeVPA'' -> ''account'' ->> ''accountNumber'' as text) as "Payee Account"
from transactions.vw_LiveTrans L where iLiveMessageID > :iLiveMessageID order by dtTrxnTime desc;', 'livetransactionAutoRefresh');
INSERT INTO ui.perspectivequery (iperspectivequeryid, vcquery, vctablename) VALUES (2, 'SELECT * from ui.getdecisiondetails(
	 :vcMsgID
)', 'decisiondetails');
INSERT INTO ui.perspectivequery (iperspectivequeryid, vcquery, vctablename) VALUES (21, 'select
vcmsgid as "Unique ID",
dtTrxnTime at time zone ''utc'' at time zone :timeZone as "Time",
Payer.vcAddress as "Payer VPA",
Payee.vcAddress as "Payee VPA",
dTransAmount as "Amount",
ld.vcremark as "Remark",
ld.dscore as  "Rule Score"
from transactions.vw_livetrans L, masters.VPA Payer, masters.VPA Payee, transactions.LiveDecisionDetails ld where
Payer.iVPAID = L.iPayerVPAID   and Payee.iVPAID = L.iPayeeVPAID and ld.ilivemessageid= L.ilivemessageid and score=:score
and ld.dscore > 0 and txnclass = :className and dtTrxnTime between now() - cast(:lastTime as interval) and now()
order by dtTrxnTime  desc', 'alertTransactionsByClass');
INSERT INTO ui.perspectivequery (iperspectivequeryid, vcquery, vctablename) VALUES (26, 'SELECT * from ui.gettxnprofileselectedtxnbyclass(
	:vpaType,
	:timeZone,
	:msgid,
	:vpaAddress,
	:txnClass,
	:txnDate
)', 'selectedTransactionbyclass');
INSERT INTO ui.perspectivequery (iperspectivequeryid, vcquery, vctablename) VALUES (17, 'select
iLiveMessageID as "ID",
vcmsgid as "Unique ID",
dtTrxnTime at time zone ''utc'' at time zone :timeZone as "Time",
cast(observations  ->  ''payer'' ->> ''addr''  as text) as "Payer VPA",
cast(observations  ->  ''payer'' -> ''attribs'' -> ''identity'' ->> ''verified_name''as text) as "Payer Name",
cast(observations  ->  ''payee'' ->> ''addr''  as text) as "Payee VPA",
cast(observations  ->  ''payee'' -> ''attribs'' -> ''identity'' ->> ''verified_name'' as text) as "Payee Name",
dTransAmount as "Amount",
bFRMPassed as "FRM Pass",
score as "Score",
vcrulename as "Rule",
cast(observations  ->  ''observations'' -> ''payerVPA'' -> ''account'' ->> ''accountNumber''  as text) as "Payer Account",
cast(observations  ->  ''observations'' -> ''payeeVPA'' -> ''account'' ->> ''accountNumber'' as text) as "Payee Account"
from transactions.vw_LiveTrans where
txnclass = :className and iLiveMessageID > :iLiveMessageID order by dtTrxnTime desc;', 'livetransactionbyclassAutoRefresh');
INSERT INTO ui.perspectivequery (iperspectivequeryid, vcquery, vctablename) VALUES (27, 'SELECT * from ui.getpartydtxn(
	:party,
	:userType,
	:timeZone,
	:useraddress,
	1000
)', 'partyDashboard');
INSERT INTO ui.perspectivequery (iperspectivequeryid, vcquery, vctablename) VALUES (28, 'SELECT * from  ui.getpartydtxnbyclass(
	:party,
	:userType,
	:timeZone,
	:txnClass,
	:useraddress,
	1000
)', 'partyDashboardByClass');
INSERT INTO ui.perspectivequery (iperspectivequeryid, vcquery, vctablename) VALUES (15, 'select
iLiveMessageID as "ID",
vcmsgid  as "Unique ID",
dtTrxnTime at time zone ''utc'' at time zone :timeZone as "Time",
cast(observations  ->  ''payer'' ->> ''addr''  as text) as "Payer VPA",
cast(observations  ->  ''payer'' -> ''attribs'' -> ''identity'' ->> ''verified_name''as text) as "Payer Name",
cast(observations  ->  ''payee'' ->> ''addr''  as text) as "Payee VPA",
cast(observations  ->  ''payee'' -> ''attribs'' -> ''identity'' ->> ''verified_name'' as text) as "Payee Name",
dTransAmount as "Amount",
bFRMPassed as "FRM Pass",
score as "Score",
vcrulename as "Rule"
from transactions.vw_LiveTrans L ORDER BY dttrxntime  desc LIMIT 1', 'vpaTransactionProfileInitial');
INSERT INTO ui.perspectivequery (iperspectivequeryid, vcquery, vctablename) VALUES (24, 'select
iLiveMessageID as "ID",
vcmsgid  as "Unique ID",
dtTrxnTime at time zone ''utc'' at time zone :timeZone as "Time",
cast(L.observations  ->  ''payer'' ->> ''addr''  as character varying) as "Payer VPA",
cast(L.observations  ->  ''payer'' -> ''attribs'' -> ''identity'' ->> ''verified_name''as character varying) as "Payer Name",
cast(L.observations  ->  ''payee'' ->> ''addr''  as character varying) as "Payee VPA",
cast(L.observations  ->  ''payee'' -> ''attribs'' -> ''identity'' ->> ''verified_name'' as character varying) as "Payee Name",
dTransAmount as "Amount",
bFRMPassed as "FRM Pass",
score as "Score",
vcrulename as "Rule"
from transactions.vw_LiveTrans L where
 vcmsgid=:msgid', 'selectedTransactionbymsgid');
INSERT INTO ui.perspectivequery (iperspectivequeryid, vcquery, vctablename) VALUES (22, 'SELECT * from ui.gettxnprofilebyclass(
	:vpaType,
	:txnType,
	:timeZone,
	:iLiveMsgID,
	:vpaAddress,
	:txnClass,
	20
)', 'transactionProfileByClass');
INSERT INTO ui.perspectivequery (iperspectivequeryid, vcquery, vctablename) VALUES (23, 'SELECT * from ui.gettxnprofile(
	:vpaType,
	:txnType,
	:timeZone,
	:iLiveMsgID,
	:vpaAddress,
	20
)', 'transactionProfile');
INSERT INTO ui.perspectivequery (iperspectivequeryid, vcquery, vctablename) VALUES (25, 'SELECT * from ui.gettxnprofileselectedtxn(
	:vpaType,
	:timeZone,
	:msgid,
	:vpaAddress,
	:txnDate
)', 'selectedTransaction');
INSERT INTO ui.perspectivequery (iperspectivequeryid, vcquery, vctablename) VALUES (18, 'select
    iLiveMessageID as "ID",
    vcmsgid  as "Unique ID",
    dtTrxnTime at time zone ''utc'' at time zone :timeZone as "Time",
    cast(L.observations  ->  ''payer'' ->> ''addr''  as character varying) as "Payer VPA",
    cast(L.observations  ->  ''payer'' -> ''attribs'' -> ''identity'' ->> ''verified_name''as character varying) as "Payer Name",
    cast(L.observations  ->  ''payee'' ->> ''addr''  as character varying) as "Payee VPA",
    cast(L.observations  ->  ''payee'' -> ''attribs'' -> ''identity'' ->> ''verified_name'' as character varying) as "Payee Name",
    dTransAmount as "Amount",
    bFRMPassed as "FRM Pass",
    score as "Score",
    vcrulename as "Rule",
    cast(observations  ->  ''observations'' -> ''payerVPA'' -> ''account'' ->> ''accountNumber''  as character varying) as "Payer Account",
    cast(observations  ->  ''observations'' -> ''payeeVPA'' -> ''account'' ->> ''accountNumber'' as character varying) as "Payee Account"
from transactions.vw_LiveTrans L
where ipayervpaid = (select ipayervpaid FROM transactions.vw_livetrans ORDER BY dttrxntime desc LIMIT 1)
  and (CAST(dtTrxnTime AS date) = CURRENT_DATE-1 or CAST(dtTrxnTime AS date) = CURRENT_DATE) limit 1000;', 'vpaDashboardInitial');




DROP TABLE IF EXISTS ui.perspectivequeryparameters;


CREATE TABLE IF NOT EXISTS ui.perspectivequeryparameters
(
    iperspectiveparameterid integer NOT NULL,
    iposition integer,
    vcparametername character varying(255) COLLATE pg_catalog."default",
    vcparametertype character varying(255) COLLATE pg_catalog."default",
    iperspectivequeryid integer,
    CONSTRAINT perspectivequeryparameters_pkey PRIMARY KEY (iperspectiveparameterid),
    CONSTRAINT fk9i73wcdvo3l1lxskek6inbkcl FOREIGN KEY (iperspectivequeryid)
    REFERENCES ui.perspectivequery (iperspectivequeryid) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION
    );

CREATE SEQUENCE IF NOT EXISTS ui.perspectivequeryparameters_iperspectiveparameterid_seq
    INCREMENT 1
    START 1
    MINVALUE 1
    MAXVALUE 2147483647
    CACHE 1
    OWNED BY ui.perspectivequeryparameters.iperspectiveparameterid;


alter table ui.perspectivequeryparameters alter iperspectiveparameterid set DEFAULT nextval('ui.perspectivequeryparameters_iperspectiveparameterid_seq'::regclass);


INSERT INTO ui.perspectivequeryparameters (iperspectiveparameterid, iposition, vcparametername, vcparametertype, iperspectivequeryid) VALUES (2, 1, 'className', 'String', 4);
INSERT INTO ui.perspectivequeryparameters (iperspectiveparameterid, iposition, vcparametername, vcparametertype, iperspectivequeryid) VALUES (20, 1, 'iLiveMessageID', 'Integer', 16);
INSERT INTO ui.perspectivequeryparameters (iperspectiveparameterid, iposition, vcparametername, vcparametertype, iperspectivequeryid) VALUES (21, 1, 'className', 'String', 17);
INSERT INTO ui.perspectivequeryparameters (iperspectiveparameterid, iposition, vcparametername, vcparametertype, iperspectivequeryid) VALUES (22, 2, 'iLiveMessageID', 'Integer', 17);
INSERT INTO ui.perspectivequeryparameters (iperspectiveparameterid, iposition, vcparametername, vcparametertype, iperspectivequeryid) VALUES (1, 1, 'vcMsgID', 'String', 2);
INSERT INTO ui.perspectivequeryparameters (iperspectiveparameterid, iposition, vcparametername, vcparametertype, iperspectivequeryid) VALUES (23, 1, 'iLiveMessageID', 'Integer', 19);
INSERT INTO ui.perspectivequeryparameters (iperspectiveparameterid, iposition, vcparametername, vcparametertype, iperspectivequeryid) VALUES (24, 0, 'score', 'Integer', 20);
INSERT INTO ui.perspectivequeryparameters (iperspectiveparameterid, iposition, vcparametername, vcparametertype, iperspectivequeryid) VALUES (25, 0, 'score', 'Integer', 21);
INSERT INTO ui.perspectivequeryparameters (iperspectiveparameterid, iposition, vcparametername, vcparametertype, iperspectivequeryid) VALUES (26, 1, 'className', 'String', 21);
INSERT INTO ui.perspectivequeryparameters (iperspectiveparameterid, iposition, vcparametername, vcparametertype, iperspectivequeryid) VALUES (5, 1, 'vpaType', 'String', 23);
INSERT INTO ui.perspectivequeryparameters (iperspectiveparameterid, iposition, vcparametername, vcparametertype, iperspectivequeryid) VALUES (6, 2, 'txnType', 'String', 23);
INSERT INTO ui.perspectivequeryparameters (iperspectiveparameterid, iposition, vcparametername, vcparametertype, iperspectivequeryid) VALUES (28, 6, 'vpaAddress', 'String', 23);
INSERT INTO ui.perspectivequeryparameters (iperspectiveparameterid, iposition, vcparametername, vcparametertype, iperspectivequeryid) VALUES (29, 1, 'msgid', 'String', 24);
INSERT INTO ui.perspectivequeryparameters (iperspectiveparameterid, iposition, vcparametername, vcparametertype, iperspectivequeryid) VALUES (30, 1, 'vpaType', 'String', 22);
INSERT INTO ui.perspectivequeryparameters (iperspectiveparameterid, iposition, vcparametername, vcparametertype, iperspectivequeryid) VALUES (31, 2, 'txnType', 'String', 22);
INSERT INTO ui.perspectivequeryparameters (iperspectiveparameterid, iposition, vcparametername, vcparametertype, iperspectivequeryid) VALUES (3, 6, 'vpaAddress', 'String', 22);
INSERT INTO ui.perspectivequeryparameters (iperspectiveparameterid, iposition, vcparametername, vcparametertype, iperspectivequeryid) VALUES (4, 6, 'txnClass', 'String', 22);
INSERT INTO ui.perspectivequeryparameters (iperspectiveparameterid, iposition, vcparametername, vcparametertype, iperspectivequeryid) VALUES (27, 4, 'iLiveMsgID', 'Integer', 23);
INSERT INTO ui.perspectivequeryparameters (iperspectiveparameterid, iposition, vcparametername, vcparametertype, iperspectivequeryid) VALUES (33, 4, 'iLiveMsgID', 'Integer', 22);
INSERT INTO ui.perspectivequeryparameters (iperspectiveparameterid, iposition, vcparametername, vcparametertype, iperspectivequeryid) VALUES (34, 1, 'vpaType', 'String', 25);
INSERT INTO ui.perspectivequeryparameters (iperspectiveparameterid, iposition, vcparametername, vcparametertype, iperspectivequeryid) VALUES (35, 3, 'msgid', 'String', 25);
INSERT INTO ui.perspectivequeryparameters (iperspectiveparameterid, iposition, vcparametername, vcparametertype, iperspectivequeryid) VALUES (36, 4, 'vpaAddress', 'String', 25);
INSERT INTO ui.perspectivequeryparameters (iperspectiveparameterid, iposition, vcparametername, vcparametertype, iperspectivequeryid) VALUES (37, 5, 'txnDate', 'Date', 25);
INSERT INTO ui.perspectivequeryparameters (iperspectiveparameterid, iposition, vcparametername, vcparametertype, iperspectivequeryid) VALUES (38, 1, 'vpaType', 'String', 26);
INSERT INTO ui.perspectivequeryparameters (iperspectiveparameterid, iposition, vcparametername, vcparametertype, iperspectivequeryid) VALUES (39, 3, 'msgid', 'String', 26);
INSERT INTO ui.perspectivequeryparameters (iperspectiveparameterid, iposition, vcparametername, vcparametertype, iperspectivequeryid) VALUES (40, 4, 'vpaAddress', 'String', 26);
INSERT INTO ui.perspectivequeryparameters (iperspectiveparameterid, iposition, vcparametername, vcparametertype, iperspectivequeryid) VALUES (41, 5, 'txnClass', 'String', 26);
INSERT INTO ui.perspectivequeryparameters (iperspectiveparameterid, iposition, vcparametername, vcparametertype, iperspectivequeryid) VALUES (42, 6, 'txnDate', 'Date', 26);
INSERT INTO ui.perspectivequeryparameters (iperspectiveparameterid, iposition, vcparametername, vcparametertype, iperspectivequeryid) VALUES (43, 3, 'lastTime', 'String', 20);
INSERT INTO ui.perspectivequeryparameters (iperspectiveparameterid, iposition, vcparametername, vcparametertype, iperspectivequeryid) VALUES (44, 4, 'lastTime', 'String', 21);
INSERT INTO ui.perspectivequeryparameters (iperspectiveparameterid, iposition, vcparametername, vcparametertype, iperspectivequeryid) VALUES (45, 1, 'party', 'String', 27);
INSERT INTO ui.perspectivequeryparameters (iperspectiveparameterid, iposition, vcparametername, vcparametertype, iperspectivequeryid) VALUES (46, 2, 'userType', 'String', 27);
INSERT INTO ui.perspectivequeryparameters (iperspectiveparameterid, iposition, vcparametername, vcparametertype, iperspectivequeryid) VALUES (47, 4, 'useraddress', 'String', 27);
INSERT INTO ui.perspectivequeryparameters (iperspectiveparameterid, iposition, vcparametername, vcparametertype, iperspectivequeryid) VALUES (48, 1, 'party', 'String', 28);
INSERT INTO ui.perspectivequeryparameters (iperspectiveparameterid, iposition, vcparametername, vcparametertype, iperspectivequeryid) VALUES (49, 2, 'userType', 'String', 28);
INSERT INTO ui.perspectivequeryparameters (iperspectiveparameterid, iposition, vcparametername, vcparametertype, iperspectivequeryid) VALUES (50, 4, 'txnClass', 'String', 28);
INSERT INTO ui.perspectivequeryparameters (iperspectiveparameterid, iposition, vcparametername, vcparametertype, iperspectivequeryid) VALUES (51, 5, 'useraddress', 'String', 28);


UPDATE ui.menustructuredesc
SET vcaction='PartyDashboard', vccontroller='PartyDashboard', vcmenuname='Party Dashboard', vcmini='PD', vcpath='/analytics/party-dashboard'	WHERE vcaction='VPADB';
