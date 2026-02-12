INSERT INTO ui.dashboardresultset (idashboardresultsetid, iresultsetorder, vcdashboardresultsetcolumnjson, vcdashboardresultsetlayout, vcdashboardresultsetname, idashboardqueryid, idashboardid, vcdashboardresultsetschema, icolsize, irowno, dtlastupdatedtimestamp, iuserid, imenustructuredesc) VALUES (36, NULL, NULL, '{
   "sizes":[
      1
   ],
   "detail":{
      "main":{
         "type":"split-area",
         "orientation":"horizontal",
         "children":[
            {
               "type":"split-area",
               "orientation":"vertical",
               "children":[
                  {
                     "type":"tab-area",
                     "widgets":[
                        "PERSPECTIVE_GENERATED_ID_0"
                     ],
                     "currentIndex":0
                  },
                  {
                     "type":"tab-area",
                     "widgets":[
                        "PERSPECTIVE_GENERATED_ID_1"
                     ],
                     "currentIndex":0
                  },
                  {
                     "type":"tab-area",
                     "widgets":[
                        "PERSPECTIVE_GENERATED_ID_2"
                     ],
                     "currentIndex":0
                  }
               ],
               "sizes":[
                  0.33,
                  0.33,
                  0.33
               ]
            },
            {
               "type":"tab-area",
               "widgets":[
                  "PERSPECTIVE_GENERATED_ID_3"
               ],
               "currentIndex":0
            }
         ],
         "sizes":[
            0.75,
            0.25
         ]
      }
   },
   "mode":"globalFilters",
   "viewers":{
      "PERSPECTIVE_GENERATED_ID_0":{
         "plugin":"Datagrid",
         "plugin_config":{
            "columns":{

            },
            "editable":false,
            "scroll_lock":false
         },
         "settings":false,
         "theme":"Pro Dark",
         "title":"Selected Transaction",
         "group_by":[

         ],
         "split_by":[

         ],
         "columns":[
            "ILiveMessageID",
            "UniqueID",
            "Class",
            "Time",
            "PayerVPA",
            "PayerName",
            "PayeeVPA",
            "PayeeName",
            "Amount",
            "FRMPass",
            "Score",
            "FailedRule",
            "Payer Account",
            "Payee Account",
            "decisiondetails"
         ],
         "filter":[

         ],
         "sort":[

         ],
         "expressions":[

         ],
         "aggregates":{

         },
         "master":false,
         "table":"vpatransaction",
         "linked":false,
         "selectable":"true"
      },
      "PERSPECTIVE_GENERATED_ID_1":{
         "plugin":"Datagrid",
         "plugin_config":{
            "columns":{

            },
            "editable":false,
            "scroll_lock":false
         },
         "settings":false,
         "theme":"Pro Dark",
         "title":"Previous Transactions",
         "group_by":[

         ],
         "split_by":[

         ],
         "columns":[
            "ILiveMessageID",
            "UniqueID",
            "Class",
            "Time",
            "PayerVPA",
            "PayerName",
            "PayeeVPA",
            "PayeeName",
            "Amount",
            "FRMPass",
            "Score",
            "FailedRule",
            "Payer Account",
            "Payee Account",
            "decisiondetails"
         ],
         "filter":[

         ],
         "sort":[

         ],
         "expressions":[

         ],
         "aggregates":{

         },
         "master":false,
         "table":"vpatransaction",
         "linked":false,
         "selectable":"true"
      },
      "PERSPECTIVE_GENERATED_ID_2":{
         "plugin":"Datagrid",
         "plugin_config":{
            "columns":{

            },
            "editable":false,
            "scroll_lock":false
         },
         "settings":false,
         "theme":"Pro Dark",
         "title":"Subsequent Transactions",
         "group_by":[

         ],
         "split_by":[

         ],
         "columns":[
            "ILiveMessageID",
            "UniqueID",
            "Class",
            "Time",
            "PayerVPA",
            "PayerName",
            "PayeeVPA",
            "PayeeName",
            "Amount",
            "FRMPass",
            "Score",
            "FailedRule",
            "Payer Account",
            "Payee Account",
            "decisiondetails"
         ],
         "filter":[

         ],
         "sort":[

         ],
         "expressions":[

         ],
         "aggregates":{

         },
         "master":false,
         "table":"vpatransaction",
         "linked":false,
         "selectable":"true"
      },
      "PERSPECTIVE_GENERATED_ID_3":{
         "plugin":"Datagrid",
         "plugin_config":{
            "columns":{

            },
            "editable":false,
            "scroll_lock":false
         },
         "settings":false,
         "theme":"Pro Dark",
         "title":"Decision details",
         "group_by":[

         ],
         "split_by":[

         ],
         "columns":[
            "Rule Name",
            "Score",
            "Order",
            "Remarks"
         ],
         "filter":[

         ],
         "sort":[

         ],
         "expressions":[

         ],
         "aggregates":{

         },
         "master":false,
         "table":"decisiondetailslive",
         "linked":false
      }
   }
}', 'vpatransaction', 77, NULL, '{
   "ILiveMessageID":"string",
   "UniqueID":"string",
   "Class":"string",
   "Time":"datetime",
   "PayerVPA":"string",
   "PayerName":"string",
   "PayeeVPA":"string",
   "PayeeName":"string",
   "Amount":"float",
   "FRMPass":"boolean",
   "Score":"integer",
   "FailedRule":"string",
   "Payer Account":"string",
   "Payee Account":"string",
   "decisiondetails":"string"
}', NULL, NULL, NULL, NULL, 509);



UPDATE ui.dashboardresultset SET
vcdashboardresultsetlayout = '{
   "sizes":[
      1
   ],
   "detail":{
      "main":{
         "type":"tab-area",
         "widgets":[
            "PERSPECTIVE_GENERATED_ID_1"
         ],
         "currentIndex":0
      }
   },
   "mode":"globalFilters",
   "viewers":{
      "PERSPECTIVE_GENERATED_ID_1":{
         "plugin":"Datagrid",
         "plugin_config":{
            "columns":{

            },
            "editable":false,
            "scroll_lock":false
         },
         "settings":false,
         "theme":"Pro Dark",
         "title":"Analyze Simulator",
         "group_by":[

         ],
         "split_by":[

         ],
         "columns":[
            "Unique ID",
            "Txn Date Time",
            "Score",
            "Remark",
            "Sim Score",
            "Sim Remark"
         ],
         "filter":[

         ],
         "sort":[

         ],
         "expressions":[

         ],
         "aggregates":{

         },
         "master":false,
         "table":"analyzesimulations",
         "linked":false
      }
   }
}'::text WHERE
idashboardresultsetid = 32;