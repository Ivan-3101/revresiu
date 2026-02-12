UPDATE ui.dashboardquery
	SET vcdashboardquery='select
    cast(dtcreateddatetime as date) as "Date",
    r.vcrulename as "Rule Name",
    count(l.iruleid) "Transaction Count",
    dscore as "Score",
    d.vcdecisionname as "Decision Name",
	tc.vcclassname as "Class Name"
    from
    transactions.livedecisiondetails l
    left join masters.rules r on l.iruleid = r.iruleid
    left join masters.decisions d on d.idecisionid = r.idecisionid
	left join masters.transactionclasses tc on tc.idecisionid = d.idecisionid
     where cast(dtcreateddatetime as date)=:Date and bpassed is false group by l.iruleid, cast(dtcreateddatetime as date),
	 r.vcrulename,dscore,d.vcdecisionname,tc.vcclassname
     order by l.iruleid'
	WHERE idashboardqueryid=12;


UPDATE ui.dashboardresultset
	SET  vcdashboardresultsetlayout='{
  "sizes": [
    1
  ],
  "master": {
    "widgets": [
      "PERSPECTIVE_GENERATED_ID_1"
    ]
  },
  "viewers": {
    "PERSPECTIVE_GENERATED_ID_1": {
      "settings": true,
      "selectable": false,
      "sort": [
        [
          "Decision Name",
          "asc"
        ],
        [
          "Score",
          "desc"
        ],
        [
          "Transaction Count",
          "desc"
        ]
      ],
      "plugin": "datagrid",
      "columns": [
        "Date",
        "Decision Name",
         "Class Name",
        "Rule Name",
        "Score",
        "Transaction Count"
      ],
      "master": true,
      "name": "Rule Efficiency Report",
      "table": "ruleefficiencyreport",
      "linked": false
    }
  }
}', vcdashboardresultsetschema='{
"Date" :"date",
"Decision Name": "string",
"Class Name": "string",
"Rule Name": "string",
"Score": "integer",
"Transaction Count": "integer"}'
	WHERE idashboardresultsetid=6;



UPDATE ui.dashboardresultset
	SET  vcdashboardresultsetlayout='{
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
         "sort":[
            [
               "Rule Name",
               "asc"
            ],
            [
               "Score",
               "desc"
            ],
            [
               "Count",
               "desc"
            ]
         ],
         "columns":[
            "Rule Name",
            "Class Name",
            "Type",
            "Score",
            "Count",
            "Acc. External ID"
         ],
         "master":true,
         "name":"Account Wise Rules Triggered",
         "table":"accountwiserulestriggered",
         "linked":false
      }
   }
}', vcdashboardresultsetschema='{
"Rule Name": "string" ,
"Type": "string",
"Score" : "integer",
"Count" : "integer",
"Acc. External ID" : "string",
"Class Name" : "string"
}'
	WHERE idashboardresultsetid=10;



