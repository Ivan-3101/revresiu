UPDATE ui.dashboard SET   vcdashboardname='Rule Efficiency Report Old'	WHERE idashboardid=6;

INSERT INTO ui.dashboard (idashboardid, bactive, bdelete, vcdashboardname) VALUES (12, true, false, 'Rule Efficiency Report');

INSERT INTO ui.dashboardquery (idashboardqueryid, bparametersrequired, vcfilterparametersjson, vcdashboardquery, formattingrequiered, runonanalytics)
VALUES (31, true, '{"Date" : null}','select rp.tdate as "Date", d.vcdecisionname as "Decision", rp.vcclassname as "Class", rp.iruleid as "Rule ID", r.vcrulename as "Rule Name",
rp.score as "Score", rp.scoretxncount as "Scored Txn Count", rp.totaltxncount as "Total Txn Count",
(rp.scoretxncount /rp.totaltxncount) * 100 as "Rule Efficiency",  rp.scoretxnvalue / rp.scoretxncount as "Scored Txn Avg Value",
rp.totaltxnvalue / rp.totaltxncount as "Avg Txn Value"
from transactions.rule_performance rp
left join masters.rules r on r.iruleid = rp.iruleid
left join masters.decisions d on d.idecisionid = rp.idecisionid where tdate = :Date ;
', false, true);

INSERT INTO ui.dashboardquery (idashboardqueryid, bparametersrequired, vcfilterparametersjson, vcdashboardquery, formattingrequiered, runonanalytics)
VALUES (32, false, null,'select current_date-1', false, true);

INSERT INTO ui.dashboardfilters (idashboardfilterid, ifilterorder, vcdashboardfiltername, idashboardid, vcdashboardfiltertype,
idashboardqueryidfordefaultvalue, idashboardqueryidforoptions, vcdashboardfilterdisplayname) VALUES (24, 0, 'Date', 12, 'DatePicker', 32, null, 'Date');

INSERT INTO ui.dashboardqueryparameters (idashboardparameterid, vcparametername, vcparametertype, idashboardqueryid, iorder) VALUES (30, 'Date', 'Date', 31, null);


INSERT INTO ui.dashboardresultset (idashboardresultsetid, iresultsetorder, vcdashboardresultsetcolumnjson, vcdashboardresultsetlayout, vcdashboardresultsetname, idashboardqueryid, idashboardid, vcdashboardresultsetschema)
VALUES (12, NULL, NULL, '{
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
            "Date",
            "Decision",
            "Class",
            "Rule ID",
            "Rule Name",
            "Score",
            "Scored Txn Count",
            "Total Txn Count",
            "Rule Efficiency",
            "Scored Txn Avg Value",
            "Avg Txn Value"
         ],
         "master":true,
         "name":"Rule Efficiency Report",
         "table":"ruleefficiencyreport",
         "linked":false
      }
   }
}', 'ruleefficiencyreport', 31, 12, '{
   "Date":"date",
   "Decision":"string",
   "Class":"string",
   "Rule ID":"integer",
   "Rule Name":"string",
   "Score":"integer",
   "Scored Txn Count":"integer",
   "Total Txn Count":"integer",
   "Rule Efficiency":"float",
   "Scored Txn Avg Value":"float",
   "Avg Txn Value":"float"
}');