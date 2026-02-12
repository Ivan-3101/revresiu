alter table if exists ui.roledesc
       add column imenustructuredesc int4;


alter table if exists ui.roledesc
       add constraint FK9mjc5y5nqu5emvia5e6s7k5bs
       foreign key (imenustructuredesc)
       references ui.menustructuredesc;



INSERT INTO ui.dashboardquery (
idashboardqueryid, bparametersrequired, vcfilterparametersjson, vcdashboardquery, formattingrequiered, runonanalytics, transposerequired) VALUES (
'69'::integer, true::boolean, '{
   "party":null,
   "userType":null,
   "txnClass":null,
   "useraddress":null,
   "date":null
}'::text, ' {
    "All": {
        "VPA": {
            "Payer": "select result->''score''->>''decisiondetails'' as \"decisiondetails\", ilivemessageid as \"ILiveMessageID\", vcmsgid as \"UniqueID\", vcclassname as \"Class\",  dttrxntime at time zone ''Asia/Kolkata'' at time zone :timeZone as \"Time\", cast(dttrxntime at time zone ''Asia/Kolkata'' at time zone :timeZone as date)  as \"Date\", dobservationamount as \"Amount\", score as \"Score\",  cast(result->''score''->>''bpass'' as text)as \"FRMPass\", vcpayeraccountexternalid as \"Payer Account\", vcpayeraddr as \"PayerVPA\", vcpayeeaccountexternalid as \"Payee Account\", vcpayeeaddr as \"PayeeVPA\", null as \"FailedRule\", cast(observations->''observations''->''payerVPA''->>''vpaName'' as text) as \"PayerName\",  cast(observations->''observations''->''payeeVPA''->>''vpaName'' as text) as \"PayeeName\" from transactions.trans where vcpayeraddr = :useraddress and (CAST(dttrxntime AS date) between cast(:date as date)-1 and  :date ) order by dttrxntime desc;",
            "Payee": "select result->''score''->>''decisiondetails'' as \"decisiondetails\", ilivemessageid as \"ILiveMessageID\", vcmsgid as \"UniqueID\", vcclassname as \"Class\",  dttrxntime at time zone ''Asia/Kolkata'' at time zone :timeZone as \"Time\", cast(dttrxntime at time zone ''Asia/Kolkata'' at time zone :timeZone as date)  as \"Date\", dobservationamount as \"Amount\", score as \"Score\",  cast(result->''score''->>''bpass'' as text)as \"FRMPass\", vcpayeraccountexternalid as \"Payer Account\", vcpayeraddr as \"PayerVPA\", vcpayeeaccountexternalid as \"Payee Account\", vcpayeeaddr as \"PayeeVPA\", null as \"FailedRule\", cast(observations->''observations''->''payerVPA''->>''vpaName'' as text) as \"PayerName\",  cast(observations->''observations''->''payeeVPA''->>''vpaName'' as text) as \"PayeeName\" from transactions.trans where vcpayeeaddr = :useraddress and (CAST(dttrxntime AS date) between cast(:date as date)-1 and  :date ) order by dttrxntime desc;",
            "Both": "select result->''score''->>''decisiondetails'' as \"decisiondetails\", ilivemessageid as \"ILiveMessageID\", vcmsgid as \"UniqueID\", vcclassname as \"Class\",  dttrxntime at time zone ''Asia/Kolkata'' at time zone :timeZone as \"Time\", cast(dttrxntime at time zone ''Asia/Kolkata'' at time zone :timeZone as date)  as \"Date\", dobservationamount as \"Amount\", score as \"Score\",  cast(result->''score''->>''bpass'' as text)as \"FRMPass\", vcpayeraccountexternalid as \"Payer Account\", vcpayeraddr as \"PayerVPA\", vcpayeeaccountexternalid as \"Payee Account\", vcpayeeaddr as \"PayeeVPA\", null as \"FailedRule\", cast(observations->''observations''->''payerVPA''->>''vpaName'' as text) as \"PayerName\",  cast(observations->''observations''->''payeeVPA''->>''vpaName'' as text) as \"PayeeName\" from transactions.trans where (vcpayeraddr = :useraddress or vcpayeeaddr = :useraddress  ) and (CAST(dttrxntime AS date) between cast(:date as date)-1 and :date ) order by dttrxntime desc;"
        },
        "Account": {
            "Payer": "select result->''score''->>''decisiondetails'' as \"decisiondetails\", ilivemessageid as \"ILiveMessageID\", vcmsgid as \"UniqueID\", vcclassname as \"Class\",  dttrxntime at time zone ''Asia/Kolkata'' at time zone :timeZone as \"Time\", cast(dttrxntime at time zone ''Asia/Kolkata'' at time zone :timeZone as date)  as \"Date\", dobservationamount as \"Amount\", score as \"Score\",  cast(result->''score''->>''bpass'' as text)as \"FRMPass\", vcpayeraccountexternalid as \"Payer Account\", vcpayeraddr as \"PayerVPA\", vcpayeeaccountexternalid as \"Payee Account\", vcpayeeaddr as \"PayeeVPA\", null as \"FailedRule\", cast(observations->''observations''->''payerVPA''->>''vpaName'' as text) as \"PayerName\",  cast(observations->''observations''->''payeeVPA''->>''vpaName'' as text) as \"PayeeName\" from transactions.trans where vcpayeraccountexternalid = :useraddress and (CAST(dttrxntime AS date) between cast(:date as date)-1 and :date ) order by dttrxntime desc;",
            "Payee": "select result->''score''->>''decisiondetails'' as \"decisiondetails\", ilivemessageid as \"ILiveMessageID\", vcmsgid as \"UniqueID\", vcclassname as \"Class\",  dttrxntime at time zone ''Asia/Kolkata'' at time zone :timeZone as \"Time\", cast(dttrxntime at time zone ''Asia/Kolkata'' at time zone :timeZone as date)  as \"Date\", dobservationamount as \"Amount\", score as \"Score\",  cast(result->''score''->>''bpass'' as text)as \"FRMPass\", vcpayeraccountexternalid as \"Payer Account\", vcpayeraddr as \"PayerVPA\", vcpayeeaccountexternalid as \"Payee Account\", vcpayeeaddr as \"PayeeVPA\", null as \"FailedRule\", cast(observations->''observations''->''payerVPA''->>''vpaName'' as text) as \"PayerName\",  cast(observations->''observations''->''payeeVPA''->>''vpaName'' as text) as \"PayeeName\" from transactions.trans where vcpayeeaccountexternalid = :useraddress and (CAST(dttrxntime AS date) between cast(:date as date)-1 and  :date ) order by dttrxntime desc;",
            "Both": "select result->''score''->>''decisiondetails'' as \"decisiondetails\", ilivemessageid as \"ILiveMessageID\", vcmsgid as \"UniqueID\", vcclassname as \"Class\",  dttrxntime at time zone ''Asia/Kolkata'' at time zone :timeZone as \"Time\", cast(dttrxntime at time zone ''Asia/Kolkata'' at time zone :timeZone as date)  as \"Date\", dobservationamount as \"Amount\", score as \"Score\",  cast(result->''score''->>''bpass'' as text)as \"FRMPass\", vcpayeraccountexternalid as \"Payer Account\", vcpayeraddr as \"PayerVPA\", vcpayeeaccountexternalid as \"Payee Account\", vcpayeeaddr as \"PayeeVPA\", null as \"FailedRule\", cast(observations->''observations''->''payerVPA''->>''vpaName'' as text) as \"PayerName\",  cast(observations->''observations''->''payeeVPA''->>''vpaName'' as text) as \"PayeeName\" from transactions.trans where (vcpayeraccountexternalid = :useraddress or vcpayeeaccountexternalid = :useraddress ) and (CAST(dttrxntime AS date) between cast(:date as date)-1 and :date ) order by dttrxntime desc;"
        }
    },
    "Other": {
        "VPA": {
            "Payer": "select result->''score''->>''decisiondetails'' as \"decisiondetails\", ilivemessageid as \"ILiveMessageID\", vcmsgid as \"UniqueID\", vcclassname as \"Class\",  dttrxntime at time zone ''Asia/Kolkata'' at time zone :timeZone as \"Time\", cast(dttrxntime at time zone ''Asia/Kolkata'' at time zone :timeZone as date)  as \"Date\", dobservationamount as \"Amount\", score as \"Score\",  cast(result->''score''->>''bpass'' as text)as \"FRMPass\", vcpayeraccountexternalid as \"Payer Account\", vcpayeraddr as \"PayerVPA\", vcpayeeaccountexternalid as \"Payee Account\", vcpayeeaddr as \"PayeeVPA\", null as \"FailedRule\", cast(observations->''observations''->''payerVPA''->>''vpaName'' as text) as \"PayerName\",  cast(observations->''observations''->''payeeVPA''->>''vpaName'' as text) as \"PayeeName\" from transactions.trans where vcpayeraddr = :useraddress and vcclassname  = :txnClass and (CAST(dttrxntime AS date) between cast(:date as date)-1 and  :date ) order by dttrxntime desc;",
            "Payee": "select result->''score''->>''decisiondetails'' as \"decisiondetails\", ilivemessageid as \"ILiveMessageID\", vcmsgid as \"UniqueID\", vcclassname as \"Class\",  dttrxntime at time zone ''Asia/Kolkata'' at time zone :timeZone as \"Time\", cast(dttrxntime at time zone ''Asia/Kolkata'' at time zone :timeZone as date)  as \"Date\", dobservationamount as \"Amount\", score as \"Score\",  cast(result->''score''->>''bpass'' as text)as \"FRMPass\", vcpayeraccountexternalid as \"Payer Account\", vcpayeraddr as \"PayerVPA\", vcpayeeaccountexternalid as \"Payee Account\", vcpayeeaddr as \"PayeeVPA\", null as \"FailedRule\", cast(observations->''observations''->''payerVPA''->>''vpaName'' as text) as \"PayerName\",  cast(observations->''observations''->''payeeVPA''->>''vpaName'' as text) as \"PayeeName\" from transactions.trans where vcpayeeaddr = :useraddress and vcclassname  = :txnClass and (CAST(dttrxntime AS date) between cast(:date as date)-1 and  :date ) order by dttrxntime desc;",
            "Both": "select result->''score''->>''decisiondetails'' as \"decisiondetails\", ilivemessageid as \"ILiveMessageID\", vcmsgid as \"UniqueID\", vcclassname as \"Class\",  dttrxntime at time zone ''Asia/Kolkata'' at time zone :timeZone as \"Time\", cast(dttrxntime at time zone ''Asia/Kolkata'' at time zone :timeZone as date)  as \"Date\", dobservationamount as \"Amount\", score as \"Score\",  cast(result->''score''->>''bpass'' as text)as \"FRMPass\", vcpayeraccountexternalid as \"Payer Account\", vcpayeraddr as \"PayerVPA\", vcpayeeaccountexternalid as \"Payee Account\", vcpayeeaddr as \"PayeeVPA\", null as \"FailedRule\", cast(observations->''observations''->''payerVPA''->>''vpaName'' as text) as \"PayerName\",  cast(observations->''observations''->''payeeVPA''->>''vpaName'' as text) as \"PayeeName\" from transactions.trans where (vcpayeraddr = :useraddress or vcpayeeaddr = :useraddress ) and vcclassname  = :txnClass and (CAST(dttrxntime AS date) between cast(:date as date)-1 and  :date ) order by dttrxntime desc;"
        },
        "Account": {
            "Payer": "select result->''score''->>''decisiondetails'' as \"decisiondetails\", ilivemessageid as \"ILiveMessageID\", vcmsgid as \"UniqueID\", vcclassname as \"Class\",  dttrxntime at time zone ''Asia/Kolkata'' at time zone :timeZone as \"Time\", cast(dttrxntime at time zone ''Asia/Kolkata'' at time zone :timeZone as date)  as \"Date\", dobservationamount as \"Amount\", score as \"Score\",  cast(result->''score''->>''bpass'' as text)as \"FRMPass\", vcpayeraccountexternalid as \"Payer Account\", vcpayeraddr as \"PayerVPA\", vcpayeeaccountexternalid as \"Payee Account\", vcpayeeaddr as \"PayeeVPA\", null as \"FailedRule\", cast(observations->''observations''->''payerVPA''->>''vpaName'' as text) as \"PayerName\",  cast(observations->''observations''->''payeeVPA''->>''vpaName'' as text) as \"PayeeName\" from transactions.trans where vcpayeraccountexternalid = :useraddress and vcclassname  = :txnClass and (CAST(dttrxntime AS date) between cast(:date as date)-1 and  :date ) order by dttrxntime desc;",
            "Payee": "select result->''score''->>''decisiondetails'' as \"decisiondetails\", ilivemessageid as \"ILiveMessageID\", vcmsgid as \"UniqueID\", vcclassname as \"Class\",  dttrxntime at time zone ''Asia/Kolkata'' at time zone :timeZone as \"Time\", cast(dttrxntime at time zone ''Asia/Kolkata'' at time zone :timeZone as date)  as \"Date\", dobservationamount as \"Amount\", score as \"Score\",  cast(result->''score''->>''bpass'' as text)as \"FRMPass\", vcpayeraccountexternalid as \"Payer Account\", vcpayeraddr as \"PayerVPA\", vcpayeeaccountexternalid as \"Payee Account\", vcpayeeaddr as \"PayeeVPA\", null as \"FailedRule\", cast(observations->''observations''->''payerVPA''->>''vpaName'' as text) as \"PayerName\",  cast(observations->''observations''->''payeeVPA''->>''vpaName'' as text) as \"PayeeName\" from transactions.trans where vcpayeeaccountexternalid = :useraddress and vcclassname  = :txnClass and (CAST(dttrxntime AS date) between cast(:date as date)-1 and  :date ) order by dttrxntime desc;",
            "Both": "select  result->''score''->>''decisiondetails'' as \"decisiondetails\", ilivemessageid as \"ILiveMessageID\", vcmsgid as \"UniqueID\", vcclassname as \"Class\",  dttrxntime at time zone ''Asia/Kolkata'' at time zone :timeZone as \"Time\", cast(dttrxntime at time zone ''Asia/Kolkata'' at time zone :timeZone as date)  as \"Date\", dobservationamount as \"Amount\", score as \"Score\",  cast(result->''score''->>''bpass'' as text)as \"FRMPass\", vcpayeraccountexternalid as \"Payer Account\", vcpayeraddr as \"PayerVPA\", vcpayeeaccountexternalid as \"Payee Account\", vcpayeeaddr as \"PayeeVPA\", null as \"FailedRule\", cast(observations->''observations''->''payerVPA''->>''vpaName'' as text) as \"PayerName\",  cast(observations->''observations''->''payeeVPA''->>''vpaName'' as text) as \"PayeeName\" from transactions.trans where (vcpayeraccountexternalid = :useraddress or vcpayeeaccountexternalid = :useraddress )  and vcclassname  = :txnClass and (CAST(dttrxntime AS date) between cast(:date as date)-1 and :date ) order by dttrxntime desc;"
        }
    }
}'::text, false::boolean, true::boolean, false::boolean)
 returning idashboardqueryid;



 INSERT INTO ui.dashboardquery (
 bparametersrequired, idashboardqueryid, vcdashboardquery, formattingrequiered, runonanalytics, transposerequired) VALUES (
 false::boolean, '68'::integer, 'select ilivemessageid as "ILiveMessageID", vcmsgid as "UniqueID", vcclassname as "Class", dttrxntime at time zone ''Asia/Kolkata'' at time zone :timeZone as "Time",
 dobservationamount as "Amount", score as "Score",  cast(result->''score''->>''bpass'' as text)as "FRMPass", vcpayeraccountexternalid as "Payer Account", vcpayeraddr as "PayerVPA",
 vcpayeeaccountexternalid as "Payee Account", vcpayeeaddr as "PayeeVPA", null as "FailedRule", cast(observations->''observations''->''payerVPA''->>''vpaName'' as text) as "PayerName",  cast(observations->''observations''->''payeeVPA''->>''vpaName'' as text) as "PayeeName" from transactions.trans
  order by dttrxntime desc limit 1;'::text, false::boolean, true::boolean, false::boolean)
  returning idashboardqueryid;




  INSERT INTO ui.dashboardresultset (
  idashboardresultsetid, vcdashboardresultsetlayout, idashboardqueryid, vcdashboardresultsetschema, vcdashboardresultsetname) VALUES (
  '31'::integer, '{
      "sizes": [
          1
      ],
      "detail": {
          "main": {
              "type": "split-area",
              "orientation": "horizontal",
              "children": [
                  {
                      "type": "tab-area",
                      "widgets": [
                          "PERSPECTIVE_GENERATED_ID_0"
                      ],
                      "currentIndex": 0
                  },
                  {
                      "type": "split-area",
                      "orientation": "vertical",
                      "children": [
                          {
                              "type": "tab-area",
                              "widgets": [
                                  "PERSPECTIVE_GENERATED_ID_2"
                              ],
                              "currentIndex": 0
                          },
                          {
                              "type": "tab-area",
                              "widgets": [
                                  "PERSPECTIVE_GENERATED_ID_1"
                              ],
                              "currentIndex": 0
                          }
                      ],
                      "sizes": [
                          0.5,
                          0.5
                      ]
                  }
              ],
              "sizes": [
                  0.6830815760672325,
                  0.3169184239327675
              ]
          }
      },
      "mode": "globalFilters",
      "viewers": {
          "PERSPECTIVE_GENERATED_ID_0": {
              "plugin": "Custom Datagrid",
              "plugin_config": {
                  "columns": {},
                  "editable": false,
                  "scroll_lock": true
              },
              "settings": false,
              "theme": "Material Dark",
              "group_by": [],
              "split_by": [],
              "columns": [
                  "ILiveMessageID",
                  "UniqueID",
                  "Class",
                  "Type",
                  "Time",
                  "Amount",
                  "Score",
                  "FRMPass",
                  "PayerVPA",
                  "PayeeVPA",
                  "PayerName",
                  "PayeeName",
                  "Payer Account",
                  "Payee Account",
                  "decisiondetails"
              ],
              "filter": [],
              "sort": [
                  [
                      "Time",
                      "desc"
                  ]
              ],
              "expressions": [
                  "//Type\n if (is_not_null(\"Payer Account\") and is_not_null(\"Payee Account\")) {\n ''A2A''\n } else if (is_not_null(\"Payer Account\")) {\n ''A2P''\n } else if (is_not_null(\"Payee Account\")) {\n ''P2A''\n }else\n {\n ''-''\n }"
              ],
              "aggregates": {},
              "master": false,
              "name": "Transactions",
              "table": "vpatransaction",
              "linked": false,
              "selectable": "true"
          },
          "PERSPECTIVE_GENERATED_ID_2": {
              "plugin": "Custom Datagrid",
              "plugin_config": {
                  "columns": {},
                  "editable": false,
                  "scroll_lock": true
              },
              "settings": false,
              "theme": "Material Dark",
              "group_by": [
                  "Date"
              ],
              "split_by": [],
              "columns": [
                  "Txn Count",
                  "Amount",
                  "Pass",
                  "Fail"
              ],
              "filter": [],
              "sort": [],
              "expressions": [
                  "// Txn Count\ninteger(1)",
                  "// Pass \nif(\"FRMPass\" == true) {\n    integer(1)\n} else {\n    integer(0)\n}\n",
                  "// Fail\nif(\"FRMPass\" == false){\ninteger(1)\n} else {\ninteger(0)}"
              ],
              "aggregates": {
                  "Fail": "abs sum",
                  "Txn Count": "count",
                  "Pass": "abs sum"
              },
              "master": false,
              "name": "Transaction Summary",
              "table": "vpatransaction",
              "linked": false
          },
          "PERSPECTIVE_GENERATED_ID_1": {
              "plugin": "Custom Datagrid",
              "plugin_config": {
                  "columns": {},
                  "editable": false,
                  "scroll_lock": true
              },
              "settings": false,
              "theme": "Material Dark",
              "group_by": [],
              "split_by": [],
              "columns": [
                  "Rule Name",
                  "Score",
                  "Order",
                  "Remarks"
              ],
              "filter": [],
              "sort": [],
              "expressions": [],
              "aggregates": {},
              "master": false,
              "name": "Decision Detail",
              "table": "decisiondetailslive",
              "linked": false
          }
      }
  }'::text, '69'::integer, ' {
      "ILiveMessageID": "string",
      "UniqueID": "string",
      "Class": "string",
      "Time": "datetime",
      "PayerVPA": "string",
      "PayerName": "string",
      "PayeeVPA": "string",
      "PayeeName": "string",
      "Amount": "float",
      "FRMPass": "boolean",
      "Score": "integer",
      "FailedRule": "string",
      "Payer Account": "string",
      "Payee Account": "string",
      "decisiondetails": "string",
      "Date": "date"
  }
  '::text, 'vpatransaction'::character varying)
   returning idashboardresultsetid;


INSERT INTO ui.dashboardqueryparameters (
idashboardparameterid, vcparametername, vcparametertype, idashboardqueryid) VALUES (
'110'::integer, 'date'::character varying, 'Date'::character varying, '69'::integer)
 returning idashboardparameterid;

 INSERT INTO ui.dashboardqueryparameters (
 idashboardparameterid, vcparametername, vcparametertype, idashboardqueryid) VALUES (
 '109'::integer, 'useraddress'::character varying, 'String'::character varying, '69'::integer)
  returning idashboardparameterid;

  INSERT INTO ui.dashboardqueryparameters (
  idashboardparameterid, vcparametername, vcparametertype, idashboardqueryid, iorder) VALUES (
  '108'::integer, 'userType'::character varying, 'JsonPath'::character varying, '69'::integer, '2'::integer)
   returning idashboardparameterid;

   INSERT INTO ui.dashboardqueryparameters (
   idashboardparameterid, vcparametername, vcparametertype, idashboardqueryid, iorder) VALUES (
   '107'::integer, 'party'::character varying, 'JsonPath'::character varying, '69'::integer, '1'::integer)
    returning idashboardparameterid;

    INSERT INTO ui.dashboardqueryparameters (
    idashboardparameterid, vcparametername, vcparametertype, idashboardqueryid, iorder) VALUES (
    '106'::integer, 'txnClass'::character varying, 'JsonPath'::character varying, '69'::integer, '0'::integer)
     returning idashboardparameterid;


SELECT pg_catalog.setval('ui.rolemenuaccessmap_irolemenumapid_seq', (SELECT MAX(irolemenumapid) FROM ui.rolemenuaccessmap), true);


INSERT INTO ui.menustructuredesc (
imenuid, bcollapse, isortorder, vcaction, vccontroller, vclayout, vcmenuname, vcmini, vcpath, iparentmenu, istatus) VALUES (
'573'::integer, false::boolean, '1'::integer, 'RunSimulation'::character varying, 'RunSimulation'::character varying, '/user'::character varying, 'Run Simulation'::character varying, 'RS'::character varying, '/try-out/run-simulation'::character varying, '480'::integer, '1'::integer)
 returning imenuid;

INSERT INTO ui.menustructuredesc (
imenuid, bcollapse, isortorder, vcaction, vccontroller, vclayout, vcmenuname, vcmini, vcpath, iparentmenu, istatus) VALUES (
'574'::integer, false::boolean, '2'::integer, 'AnalyzeSimulation'::character varying, 'AnalyzeSimulation'::character varying, '/user'::character varying, 'Analyze Simulation'::character varying, 'AS'::character varying, '/try-out/analyze-simulation'::character varying, '480'::integer, '1'::integer)
 returning imenuid;


INSERT INTO ui.rolemenuaccessmap (
 badd, bapprove, bdelete, bedit, bpublish, bview, istatus, imenuid, iroleid) VALUES (
 true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, '573'::integer, '1'::integer)
 returning irolemenumapid;



 INSERT INTO ui.rolemenuaccessmap (
  badd, bapprove, bdelete, bedit, bpublish, bview, istatus, imenuid, iroleid) VALUES (
  true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, '574'::integer, '1'::integer)
  returning irolemenumapid;



  UPDATE ui.taskfiltermaster SET
  vcerrorname = 'AML Status'::character varying WHERE
  itaskfilterid = 10;



  INSERT INTO ui.dashboardquery (
  idashboardqueryid, bparametersrequired, vcfilterparametersjson, vcdashboardquery, formattingrequiered, runonanalytics, transposerequired) VALUES (
  '70'::integer, true::boolean, '{"DateRange" : null, "tablename":null, }'::text, 'SELECT vcmsgid as "Unique ID", dttrxntime as "Txn Date Time", dscore as "Score", vcremark as "Remark", sim_dscore as "Sim Score", sim_vcremark as "Sim Remark"
  	FROM sim.:tablename  where dttrxntime  between :StartDate  and :EndDate;'::text, false::boolean, true::boolean, false::boolean)
   returning idashboardqueryid;



   INSERT INTO ui.dashboardresultset (
   idashboardresultsetid, vcdashboardresultsetlayout, vcdashboardresultsetname, idashboardqueryid, vcdashboardresultsetschema) VALUES (
   '32'::integer, ' {
    	"sizes": [
    		1
    	],
    	"master": {
    		"widgets": ["PERSPECTIVE_GENERATED_ID_1"]
    	},
    	"viewers": {
    		"PERSPECTIVE_GENERATED_ID_1": {
                           "settings":false,
    			"selectable": false,
    			"plugin": "datagrid",
    			"master": true,
    			"name": "Analyze Simulations",
    			"table": "analyzesimulations",
    			"linked": false
    		}
    	}
    }'::text, 'analyzesimulations'::character varying, '70'::integer, '{
      "Unique ID":"string",
      "Txn Date Time":"datetime",
      "Score":"integer",
      "Remark":"string",
      "Sim Score":"integer",
      "Sim Remark":"string"
   }'::text)
    returning idashboardresultsetid;

INSERT INTO ui.dashboardqueryparameters (idashboardparameterid, vcparametername, vcparametertype, idashboardqueryid, iorder) VALUES (112, 'DateRange', 'DateRange', 70, NULL);
INSERT INTO ui.dashboardqueryparameters (idashboardparameterid, vcparametername, vcparametertype, idashboardqueryid, iorder) VALUES (111, 'tablename', 'TableName', 70, NULL);


UPDATE ui.dashboardquery SET
vcdashboardquery = 'SELECT vcmsgid as "Unique ID", dttrxntime as "Txn Date Time", dscore as "Score", vcremark as "Remark", sim_dscore as "Sim Score", sim_vcremark as "Sim Remark"
  	FROM sim.":tablename"  where dttrxntime  between :StartDate  and :EndDate;'::text WHERE
idashboardqueryid = 70;
