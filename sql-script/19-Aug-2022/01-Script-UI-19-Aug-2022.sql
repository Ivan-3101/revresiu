alter table ui.dashboardresultset add column vcdashboardresultsetschema TEXT;

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
         "sort":[
            [
               "Live Message ID",
               "desc"
            ]
         ],
         "settings":true,
         "selectable":false,
         "columns":[
            "Class",
            "OS",
            "Failed Amount",
            "New Payer Flag",
            "Decision Details",
            "Live Message ID",
            "IP",
            "Is New payee for Payer",
            "Rule Name",
            "Transaction Amount",
            "MCC",
            "Device ID",
            "Payee VPA",
            "Settled Amount",
            "Score",
            "FRM Passed",
            "Observations",
            "Payer VPA",
            "Transaction time",
            "Location",
            "Device",
            "Transaction ID",
            "Status"
         ],
         "plugin":"datagrid",
         "master":true,
         "name":"Transaction",
         "table":"transaction",
         "linked":false
      }
   }
}',  vcdashboardresultsetschema='{
"Class":"string",
"OS":"string",
"Failed Amount": "float",
"New Payer Flag": "boolean",
"Decision Details": "string",
"Live Message ID": "integer",
"IP":"string",
"Is New payee for Payer":"boolean",
"Rule Name":"string",
"Transaction Amount":"float",
"MCC":"integer",
"Device ID":"string",
"Payee VPA":"string",
"Settled Amount": "float",
"Score":"integer",
"FRM Passed": "boolean",
"Observations":"string",
"Payer VPA":"string",
"Transaction time":"datetime",
"Location":"string",
"Device":"string",
"Transaction ID":"string",
"Status": "string"
}'
	WHERE idashboardresultsetid=1;




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
          "plugin": "datagrid",
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
          "columns": [
            "Rule Name",
            "Type",
            "Score",
            "Count",
            "Acc. External ID"
          ],
          "master": true,
          "name": "Account Wise Rules Triggered",
          "table": "accountwiserulestriggered",
          "linked": false
        }
      }
    }',  vcdashboardresultsetschema='{
    "Rule Name": "string" ,
    "Type": "string",
    "Score" : "integer",
    "Count" : "integer",
    "Acc. External ID" : "string"
    }'
    	WHERE idashboardresultsetid=10;



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
 }',  vcdashboardresultsetschema='{
 "Date" :"date",
 "Decision Name": "string",
 "Rule Name": "string",
 "Score": "integer",
 "Transaction Count": "integer"}'
 	WHERE idashboardresultsetid=6;



 	UPDATE ui.dashboardquery
    	SET  vcdashboardquery='select
    cast(dtcreateddatetime as date) as "Date",
    r.vcrulename as "Rule Name",
    count(l.iruleid) "Transaction Count",
    dscore as "Score",
    d.vcdecisionname as "Decision Name"
    from
    transactions.livedecisiondetails l
    left join masters.rules r on l.iruleid = r.iruleid
    left join masters.decisions d on d.idecisionid = r.idecisionid
     where cast(dtcreateddatetime as date)=:Date and bpassed is false group by l.iruleid, cast(dtcreateddatetime as date), r.vcrulename,dscore,d.vcdecisionname
     order by l.iruleid
     '
    	WHERE idashboardqueryid=12;