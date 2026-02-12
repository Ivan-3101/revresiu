INSERT INTO ui.dashboard (idashboardid, vcdashboardname, bactive, bdelete) VALUES (6, 'Rule Efficiency Report', true, false);


INSERT INTO ui.dashboardfilters (idashboardfilterid, vcdashboardfiltername, idashboardid, ifilterorder, idashboardqueryid, vcdashboardfiltertype) VALUES (7, 'Date', 6, 0, NULL, 'DatePicker');

INSERT INTO ui.dashboardquery (idashboardqueryid, bparametersrequired, vcfilterparametersjson, vcdashboardquery) VALUES (12, true, '{"Date" : null }', 'SELECT a.iruleid,r.vcrulename, a.dtdate,
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
where r.iruleid=a.iruleid and a.dtdate =:Date ;');

INSERT INTO ui.dashboardqueryparameters (iperspectiveparameterid, vcparametername, vcparametertype, idashboardqueryid) VALUES (12, 'Date', 'Date', 12);

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
            "vcrulename",
            "dtdate",
            "sumday",
            "sumweek",
            "summonth"
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