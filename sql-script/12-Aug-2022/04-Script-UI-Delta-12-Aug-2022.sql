UPDATE ui.dashboardquery
SET  vcdashboardquery='select cast(dtcreateddatetime as date) as dtdate, r.vcrulename, sum(l.iruleid) cntrule from
transactions.livedecisiondetails l
left join masters.rules r on l.iruleid = r.iruleid
 where cast(dtcreateddatetime as date)=:Date and bpassed is false group by l.iruleid, cast(dtcreateddatetime as date), r.vcrulename
 order by l.iruleid'
WHERE idashboardqueryid=12;


UPDATE ui.perspectivequeryparameters
SET iperspectivequeryid=26
WHERE  iperspectiveparameterid=65;

INSERT INTO ui.dashboard (idashboardid, vcdashboardname, bactive, bdelete) VALUES (10, 'Account Wise Rules Triggered', true, false);

INSERT INTO ui.dashboardfilters (idashboardfilterid, vcdashboardfiltername, idashboardid, ifilterorder, vcdashboardfiltertype, idashboardqueryidfordefaultvalue, idashboardqueryidforoptions, vcdashboardfilterdisplayname) VALUES (19, 'Date', 10, 0, 'DatePicker', NULL, NULL, 'Date');

INSERT INTO ui.dashboardquery (idashboardqueryid, bparametersrequired, vcfilterparametersjson, vcdashboardquery) VALUES (28, true, '{"Date" : null }', 'SELECT * from ui.get_account_wise_rules_triggered(:Date)');

INSERT INTO ui.dashboardqueryparameters (idashboardparameterid, vcparametername, vcparametertype, idashboardqueryid) VALUES (25, 'Date', 'Date', 28);

INSERT INTO ui.dashboardresultset (idashboardresultsetid, vcdashboardresultsetlayout, vcdashboardresultsetname, idashboardid, vcdashboardresultsetcolumnjson, iresultsetorder, idashboardqueryid) VALUES (10, ' {
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
 			"name": "Account Wise Rules Triggered",
 			"table": "accountwiserulestriggered",
 			"linked": false
 		}
 	}
 }', 'accountwiserulestriggered', 10, ' {
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
}', NULL, 28);