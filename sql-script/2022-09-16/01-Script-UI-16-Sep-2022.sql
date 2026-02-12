UPDATE ui.dashboardresultset
	SET vcdashboardresultsetlayout='{
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
         "expressions":[
            "//Type\n if (is_not_null(\"observations.payerVPA.account.externalId\") and   is_not_null(\"observations.payeeVPA.account.externalId\")) {''A2A''} else if (is_not_null(\"observations.payerVPA.account.externalId\")) {''A2P''} else if (is_not_null(\"observations.payeeVPA.account.externalId\")) {''P2A''}else{''-''}"
         ],
         "settings":true,
         "selectable":false,
         "plugin":"datagrid",
         "master":true,
         "name":"Testing",
         "table":"testing",
         "linked":false
      }
   }
}'
	WHERE idashboardresultsetid=11;
