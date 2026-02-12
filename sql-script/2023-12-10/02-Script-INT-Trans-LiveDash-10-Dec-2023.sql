--set up dashboard entries for 3 hardcoded dashboards
INSERT INTO ui.dashboard (
idashboardid, bactive, bdelete, vcdashboardname, iorder, irowcount, imenustructuredesc) VALUES (
'34'::integer, true::boolean, false::boolean, 'Transaction DB'::character varying, '0'::integer, '1'::integer, '507'::integer)
 returning idashboardid;

 INSERT INTO ui.dashboard (
idashboardid, bactive, bdelete, vcdashboardname, iorder, irowcount, imenustructuredesc) VALUES (
'35'::integer, true::boolean, false::boolean, 'Party Dashboard'::character varying, '0'::integer, '1'::integer, '536'::integer)
 returning idashboardid;

INSERT INTO ui.dashboard (
idashboardid, bactive, bdelete, vcdashboardname, iorder, irowcount, imenustructuredesc) VALUES (
'36'::integer, true::boolean, false::boolean, 'Transaction Profile'::character varying, '0'::integer, '1'::integer, '509'::integer)
 returning idashboardid;

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

update ui.dashboardresultset set idashboardid=34 where idashboardresultsetid=25;
update ui.dashboardresultset set idashboardid=35 where idashboardresultsetid=31;
update ui.dashboardresultset set idashboardid=36 where idashboardresultsetid=36;


---Live Transaction Dashboard
UPDATE ui.dashboardquery SET
vcfilterparametersjson = '{"Request":null, "className":null,"score":null,"iLiveMessageID":null}'::text WHERE
idashboardqueryid = 55;

SELECT setval(pg_get_serial_sequence('ui.dashboardqueryparameters', 'idashboardparameterid'), 
coalesce(MAX(idashboardparameterid), 1)) from ui.dashboardqueryparameters;

INSERT INTO ui.dashboardqueryparameters (
vcparametername, vcparametertype, idashboardqueryid, iorder) VALUES (
'Request'::character varying, 'JsonPath'::character varying, '55'::integer, '0'::integer)
 returning idashboardparameterid;

INSERT INTO ui.dashboardqueryparameters (
vcparametername, vcparametertype, idashboardqueryid) VALUES (
'iLiveMessageID'::character varying, 'Integer'::character varying, '55'::integer)
 returning idashboardparameterid;

UPDATE ui.dashboardqueryparameters set iorder=1 where idashboardqueryid=55 and vcparametername='className';

UPDATE ui.dashboardquery SET
vcdashboardquery =  E'{"Initial": 
{"All": "select result->''score''->>''decisiondetails'' as \\"decisiondetails\\", ilivemessageid as \\"ILiveMessageID\\", vcmsgid as \\"UniqueID\\", vcclassname as \\"Class\\", dttrxntime at time zone ''Asia/Kolkata'' at time zone :timeZone as \\"Time\\", dobservationamount as \\"Amount\\", score as \\"Score\\",  cast(result->''score''->>''bpass'' as text)as \\"FRMPass\\", vcpayeraccountexternalid as \\"Payer Account\\", vcpayeraddr as \\"PayerVPA\\", vcpayeeaccountexternalid as \\"Payee Account\\", vcpayeeaddr as \\"PayeeVPA\\", null as \\"FailedRule\\", cast(observations->''observations''->''payerVPA''->>''vpaName'' as text) as \\"PayerName\\",  cast(observations->''observations''->''payeeVPA''->>''vpaName'' as text) as \\"PayeeName\\" from analytics.trans where vcclassname in (with d1 as (select mappingid from ui.webusermapping where webuserid = :loggedinuser and mappingtype = ''TransactionClass'') (select vcclassname FROM ui.transactionclasses where (iclassid in (select mappingid from d1) or -1 in (select mappingid from d1)) and itenantid=:tenantid)) and score >= :score and dttrxntime > cast(current_date as timestamp) and itenantid = :tenantid order by dttrxntime desc limit 50;",
"Other": "select result->''score''->>''decisiondetails'' as \\"decisiondetails\\", ilivemessageid as \\"ILiveMessageID\\", vcmsgid as \\"UniqueID\\", vcclassname as \\"Class\\", dttrxntime at time zone ''Asia/Kolkata'' at time zone :timeZone as \\"Time\\", dobservationamount as \\"Amount\\", score as \\"Score\\",  cast(result->''score''->>''bpass'' as text)as \\"FRMPass\\", vcpayeraccountexternalid as \\"Payer Account\\", vcpayeraddr as \\"PayerVPA\\", vcpayeeaccountexternalid as \\"Payee Account\\", vcpayeeaddr as \\"PayeeVPA\\", null as \\"FailedRule\\", cast(observations->''observations''->''payerVPA''->>''vpaName'' as text) as \\"PayerName\\",  cast(observations->''observations''->''payeeVPA''->>''vpaName'' as text) as \\"PayeeName\\" from analytics.trans where score >= :score and dttrxntime > cast(current_date as timestamp) and vcclassname  = :className and itenantid = :tenantid order by dttrxntime desc limit 50;"},
"Refresh":
    {
    "All": " select result->''score''->>''decisiondetails'' as \\"decisiondetails\\", ilivemessageid as \\"ILiveMessageID\\", vcmsgid as \\"UniqueID\\", vcclassname as \\"Class\\", dttrxntime at time zone ''Asia/Kolkata'' at time zone :timeZone as \\"Time\\", dobservationamount as \\"Amount\\", score as \\"Score\\",  cast(result->''score''->>''bpass'' as text)as \\"FRMPass\\", vcpayeraccountexternalid as \\"Payer Account\\", vcpayeraddr as \\"PayerVPA\\", vcpayeeaccountexternalid as \\"Payee Account\\", vcpayeeaddr as \\"PayeeVPA\\", null as \\"FailedRule\\", cast(observations->''observations''->''payerVPA''->>''vpaName'' as text) as \\"PayerName\\",  cast(observations->''observations''->''payeeVPA''->>''vpaName'' as text) as \\"PayeeName\\" from analytics.trans where vcclassname in (with d1 as (select mappingid from ui.webusermapping where webuserid = :loggedinuser and mappingtype = ''TransactionClass'') (select vcclassname FROM ui.transactionclasses where (iclassid in (select mappingid from d1) or -1 in (select mappingid from d1)) and itenantid=:tenantid)) and score >= :score and ilivemessageid > :iLiveMessageID and itenantid = :tenantid order by dttrxntime desc;",
    "Other": "select result->''score''->>''decisiondetails'' as \\"decisiondetails\\", ilivemessageid as \\"ILiveMessageID\\", vcmsgid as \\"UniqueID\\", vcclassname as \\"Class\\", dttrxntime at time zone ''Asia/Kolkata'' at time zone :timeZone as \\"Time\\", dobservationamount as \\"Amount\\", score as \\"Score\\",  cast(result->''score''->>''bpass'' as text)as \\"FRMPass\\", vcpayeraccountexternalid as \\"Payer Account\\", vcpayeraddr as \\"PayerVPA\\", vcpayeeaccountexternalid as \\"Payee Account\\", vcpayeeaddr as \\"PayeeVPA\\", null as \\"FailedRule\\", cast(observations->''observations''->''payerVPA''->>''vpaName'' as text) as \\"PayerName\\",  cast(observations->''observations''->''payeeVPA''->>''vpaName'' as text) as \\"PayeeName\\" from analytics.trans  where score >= :score and vcclassname  = :className and ilivemessageid > :iLiveMessageID and itenantid = :tenantid order by dttrxntime desc;"}
}'::text WHERE
idashboardqueryid = 55;

---Party Dashboard
INSERT INTO ui.dashboardqueryparameters (
vcparametername, vcparametertype, idashboardqueryid, iorder) VALUES (
'Request'::character varying, 'JsonPath'::character varying, '69'::integer, '0'::integer)
 returning idashboardparameterid;

UPDATE ui.dashboardqueryparameters set iorder=1 where idashboardqueryid=69 and vcparametername='txnClass';
UPDATE ui.dashboardqueryparameters set iorder=2 where idashboardqueryid=69 and vcparametername='party';
UPDATE ui.dashboardqueryparameters set iorder=3 where idashboardqueryid=69 and vcparametername='userType';
UPDATE ui.dashboardquery SET
vcfilterparametersjson = '{
   "Request":null,
   "party":null,
   "userType":null,
   "txnClass":null,
   "useraddress":null,
   "date":null
}'::text WHERE
idashboardqueryid = 69;

UPDATE ui.dashboardquery SET
vcdashboardquery =  E'{
    "Initial":{"All":{"All":{"All":"select ilivemessageid as \\"ILiveMessageID\\", vcmsgid as \\"UniqueID\\", vcclassname as \\"Class\\", dttrxntime at time zone ''Asia/Kolkata'' at time zone :timeZone as \\"Time\\", dobservationamount as \\"Amount\\", score as \\"Score\\",  cast(result->''score''->>''bpass'' as text)as \\"FRMPass\\", vcpayeraccountexternalid as \\"Payer Account\\", vcpayeraddr as \\"PayerVPA\\", vcpayeeaccountexternalid as \\"Payee Account\\", vcpayeeaddr as \\"PayeeVPA\\", null as \\"FailedRule\\", cast(observations->''observations''->''payerVPA''->>''vpaName'' as text) as \\"PayerName\\",  cast(observations->''observations''->''payeeVPA''->>''vpaName'' as text) as \\"PayeeName\\" from analytics.trans where vcclassname in (with d1 as (select mappingid from ui.webusermapping where webuserid = :loggedinuser and mappingtype = ''TransactionClass'') (select vcclassname FROM ui.transactionclasses where (iclassid in (select mappingid from d1) or -1 in (select mappingid from d1)) and itenantid=:tenantid)) and itenantid = :tenantid order by dttrxntime desc limit 1;"}}},
    "Search":{
    "All": {
        "VPA": {
            "Payer": "select   result->''score''->>''decisiondetails'' as \\"decisiondetails\\", ilivemessageid as \\"ILiveMessageID\\", vcmsgid as \\"UniqueID\\", vcclassname as \\"Class\\",  dttrxntime at time zone ''Asia/Kolkata'' at time zone :timeZone as \\"Time\\", cast(dttrxntime at time zone ''Asia/Kolkata'' at time zone :timeZone as date)  as \\"Date\\", dobservationamount as \\"Amount\\", score as \\"Score\\",  cast(result->''score''->>''bpass'' as text)as \\"FRMPass\\", vcpayeraccountexternalid as \\"Payer Account\\", vcpayeraddr as \\"PayerVPA\\", vcpayeeaccountexternalid as \\"Payee Account\\", vcpayeeaddr as \\"PayeeVPA\\", null as \\"FailedRule\\", cast(observations->''observations''->''payerVPA''->>''vpaName'' as text) as \\"PayerName\\",  cast(observations->''observations''->''payeeVPA''->>''vpaName'' as text) as \\"PayeeName\\" from analytics.trans where vcclassname in (with d1 as (select mappingid from ui.webusermapping where webuserid = :loggedinuser and mappingtype = ''TransactionClass'') (select vcclassname FROM ui.transactionclasses where (iclassid in (select mappingid from d1) or -1 in (select mappingid from d1)) and itenantid=:tenantid)) and itenantid = :tenantid and vcpayeraddr = :useraddress and dttrxntime between cast(cast(:date as date)-1 as timestamp) and cast(:date as date)+ 1 - interval ''1 sec''  order by dttrxntime desc;",
            "Payee": "select result->''score''->>''decisiondetails'' as \\"decisiondetails\\", ilivemessageid as \\"ILiveMessageID\\", vcmsgid as \\"UniqueID\\", vcclassname as \\"Class\\",  dttrxntime at time zone ''Asia/Kolkata'' at time zone :timeZone as \\"Time\\", cast(dttrxntime at time zone ''Asia/Kolkata'' at time zone :timeZone as date)  as \\"Date\\", dobservationamount as \\"Amount\\", score as \\"Score\\",  cast(result->''score''->>''bpass'' as text)as \\"FRMPass\\", vcpayeraccountexternalid as \\"Payer Account\\", vcpayeraddr as \\"PayerVPA\\", vcpayeeaccountexternalid as \\"Payee Account\\", vcpayeeaddr as \\"PayeeVPA\\", null as \\"FailedRule\\", cast(observations->''observations''->''payerVPA''->>''vpaName'' as text) as \\"PayerName\\",  cast(observations->''observations''->''payeeVPA''->>''vpaName'' as text) as \\"PayeeName\\" from analytics.trans where vcclassname in (with d1 as (select mappingid from ui.webusermapping where webuserid = :loggedinuser and mappingtype = ''TransactionClass'') (select vcclassname FROM ui.transactionclasses where (iclassid in (select mappingid from d1) or -1 in (select mappingid from d1)) and itenantid=:tenantid)) and itenantid = :tenantid and vcpayeeaddr = :useraddress and dttrxntime between cast(cast(:date as date)-1 as timestamp) and cast(:date as date)+ 1 - interval ''1 sec''  order by dttrxntime desc;",
            "Both": "select result->''score''->>''decisiondetails'' as \\"decisiondetails\\", ilivemessageid as \\"ILiveMessageID\\", vcmsgid as \\"UniqueID\\", vcclassname as \\"Class\\",  dttrxntime at time zone ''Asia/Kolkata'' at time zone :timeZone as \\"Time\\", cast(dttrxntime at time zone ''Asia/Kolkata'' at time zone :timeZone as date)  as \\"Date\\", dobservationamount as \\"Amount\\", score as \\"Score\\",  cast(result->''score''->>''bpass'' as text)as \\"FRMPass\\", vcpayeraccountexternalid as \\"Payer Account\\", vcpayeraddr as \\"PayerVPA\\", vcpayeeaccountexternalid as \\"Payee Account\\", vcpayeeaddr as \\"PayeeVPA\\", null as \\"FailedRule\\", cast(observations->''observations''->''payerVPA''->>''vpaName'' as text) as \\"PayerName\\",  cast(observations->''observations''->''payeeVPA''->>''vpaName'' as text) as \\"PayeeName\\" from analytics.trans where vcclassname in (with d1 as (select mappingid from ui.webusermapping where webuserid = :loggedinuser and mappingtype = ''TransactionClass'') (select vcclassname FROM ui.transactionclasses where (iclassid in (select mappingid from d1) or -1 in (select mappingid from d1)) and itenantid=:tenantid)) and itenantid = :tenantid and (vcpayeraddr = :useraddress or vcpayeeaddr = :useraddress) and dttrxntime between cast(cast(:date as date)-1 as timestamp) and cast(:date as date)+ 1 - interval ''1 sec''  order by dttrxntime desc;"
        },
        "Account": {
            "Payer": "select result->''score''->>''decisiondetails'' as \\"decisiondetails\\", ilivemessageid as \\"ILiveMessageID\\", vcmsgid as \\"UniqueID\\", vcclassname as \\"Class\\",  dttrxntime at time zone ''Asia/Kolkata'' at time zone :timeZone as \\"Time\\", cast(dttrxntime at time zone ''Asia/Kolkata'' at time zone :timeZone as date)  as \\"Date\\", dobservationamount as \\"Amount\\", score as \\"Score\\",  cast(result->''score''->>''bpass'' as text)as \\"FRMPass\\", vcpayeraccountexternalid as \\"Payer Account\\", vcpayeraddr as \\"PayerVPA\\", vcpayeeaccountexternalid as \\"Payee Account\\", vcpayeeaddr as \\"PayeeVPA\\", null as \\"FailedRule\\", cast(observations->''observations''->''payerVPA''->>''vpaName'' as text) as \\"PayerName\\",  cast(observations->''observations''->''payeeVPA''->>''vpaName'' as text) as \\"PayeeName\\" from analytics.trans where vcclassname in (with d1 as (select mappingid from ui.webusermapping where webuserid = :loggedinuser and mappingtype = ''TransactionClass'') (select vcclassname FROM ui.transactionclasses where (iclassid in (select mappingid from d1) or -1 in (select mappingid from d1)) and itenantid=:tenantid)) and itenantid = :tenantid and vcpayeraccountexternalid = :useraddress and dttrxntime between cast(cast(:date as date)-1 as timestamp) and cast(:date as date)+ 1 - interval ''1 sec''  order by dttrxntime desc;",
            "Payee": "select result->''score''->>''decisiondetails'' as \\"decisiondetails\\", ilivemessageid as \\"ILiveMessageID\\", vcmsgid as \\"UniqueID\\", vcclassname as \\"Class\\",  dttrxntime at time zone ''Asia/Kolkata'' at time zone :timeZone as \\"Time\\", cast(dttrxntime at time zone ''Asia/Kolkata'' at time zone :timeZone as date)  as \\"Date\\", dobservationamount as \\"Amount\\", score as \\"Score\\",  cast(result->''score''->>''bpass'' as text)as \\"FRMPass\\", vcpayeraccountexternalid as \\"Payer Account\\", vcpayeraddr as \\"PayerVPA\\", vcpayeeaccountexternalid as \\"Payee Account\\", vcpayeeaddr as \\"PayeeVPA\\", null as \\"FailedRule\\", cast(observations->''observations''->''payerVPA''->>''vpaName'' as text) as \\"PayerName\\",  cast(observations->''observations''->''payeeVPA''->>''vpaName'' as text) as \\"PayeeName\\" from analytics.trans where vcclassname in (with d1 as (select mappingid from ui.webusermapping where webuserid = :loggedinuser and mappingtype = ''TransactionClass'') (select vcclassname FROM ui.transactionclasses where (iclassid in (select mappingid from d1) or -1 in (select mappingid from d1)) and itenantid=:tenantid)) and itenantid = :tenantid and vcpayeeaccountexternalid = :useraddress and dttrxntime between cast(cast(:date as date)-1 as timestamp) and cast(:date as date)+ 1 - interval ''1 sec''  order by dttrxntime desc;",
            "Both": "select result->''score''->>''decisiondetails'' as \\"decisiondetails\\", ilivemessageid as \\"ILiveMessageID\\", vcmsgid as \\"UniqueID\\", vcclassname as \\"Class\\",  dttrxntime at time zone ''Asia/Kolkata'' at time zone :timeZone as \\"Time\\", cast(dttrxntime at time zone ''Asia/Kolkata'' at time zone :timeZone as date)  as \\"Date\\", dobservationamount as \\"Amount\\", score as \\"Score\\",  cast(result->''score''->>''bpass'' as text)as \\"FRMPass\\", vcpayeraccountexternalid as \\"Payer Account\\", vcpayeraddr as \\"PayerVPA\\", vcpayeeaccountexternalid as \\"Payee Account\\", vcpayeeaddr as \\"PayeeVPA\\", null as \\"FailedRule\\", cast(observations->''observations''->''payerVPA''->>''vpaName'' as text) as \\"PayerName\\",  cast(observations->''observations''->''payeeVPA''->>''vpaName'' as text) as \\"PayeeName\\" from analytics.trans where vcclassname in (with d1 as (select mappingid from ui.webusermapping where webuserid = :loggedinuser and mappingtype = ''TransactionClass'') (select vcclassname FROM ui.transactionclasses where (iclassid in (select mappingid from d1) or -1 in (select mappingid from d1)) and itenantid=:tenantid)) and itenantid = :tenantid and (vcpayeraccountexternalid = :useraddress or vcpayeeaccountexternalid = :useraddress ) and dttrxntime between cast(cast(:date as date)-1 as timestamp) and cast(:date as date)+ 1 - interval ''1 sec''  order by dttrxntime desc;"
        }
    },
    "Other": {
        "VPA": {
            "Payer": "select result->''score''->>''decisiondetails'' as \\"decisiondetails\\", ilivemessageid as \\"ILiveMessageID\\", vcmsgid as \\"UniqueID\\", vcclassname as \\"Class\\",  dttrxntime at time zone ''Asia/Kolkata'' at time zone :timeZone as \\"Time\\", cast(dttrxntime at time zone ''Asia/Kolkata'' at time zone :timeZone as date)  as \\"Date\\", dobservationamount as \\"Amount\\", score as \\"Score\\",  cast(result->''score''->>''bpass'' as text)as \\"FRMPass\\", vcpayeraccountexternalid as \\"Payer Account\\", vcpayeraddr as \\"PayerVPA\\", vcpayeeaccountexternalid as \\"Payee Account\\", vcpayeeaddr as \\"PayeeVPA\\", null as \\"FailedRule\\", cast(observations->''observations''->''payerVPA''->>''vpaName'' as text) as \\"PayerName\\",  cast(observations->''observations''->''payeeVPA''->>''vpaName'' as text) as \\"PayeeName\\" from analytics.trans where itenantid = :tenantid and vcpayeraddr = :useraddress and vcclassname  = :txnClass and dttrxntime between cast(cast(:date as date)-1 as timestamp) and cast(:date as date)+ 1 - interval ''1 sec''  order by dttrxntime desc;",
            "Payee": "select result->''score''->>''decisiondetails'' as \\"decisiondetails\\", ilivemessageid as \\"ILiveMessageID\\", vcmsgid as \\"UniqueID\\", vcclassname as \\"Class\\",  dttrxntime at time zone ''Asia/Kolkata'' at time zone :timeZone as \\"Time\\", cast(dttrxntime at time zone ''Asia/Kolkata'' at time zone :timeZone as date)  as \\"Date\\", dobservationamount as \\"Amount\\", score as \\"Score\\",  cast(result->''score''->>''bpass'' as text)as \\"FRMPass\\", vcpayeraccountexternalid as \\"Payer Account\\", vcpayeraddr as \\"PayerVPA\\", vcpayeeaccountexternalid as \\"Payee Account\\", vcpayeeaddr as \\"PayeeVPA\\", null as \\"FailedRule\\", cast(observations->''observations''->''payerVPA''->>''vpaName'' as text) as \\"PayerName\\",  cast(observations->''observations''->''payeeVPA''->>''vpaName'' as text) as \\"PayeeName\\" from analytics.trans where itenantid = :tenantid and vcpayeeaddr = :useraddress and vcclassname  = :txnClass and dttrxntime between cast(cast(:date as date)-1 as timestamp) and cast(:date as date)+ 1 - interval ''1 sec''  order by dttrxntime desc;",
            "Both": "select result->''score''->>''decisiondetails'' as \\"decisiondetails\\", ilivemessageid as \\"ILiveMessageID\\", vcmsgid as \\"UniqueID\\", vcclassname as \\"Class\\",  dttrxntime at time zone ''Asia/Kolkata'' at time zone :timeZone as \\"Time\\", cast(dttrxntime at time zone ''Asia/Kolkata'' at time zone :timeZone as date)  as \\"Date\\", dobservationamount as \\"Amount\\", score as \\"Score\\",  cast(result->''score''->>''bpass'' as text)as \\"FRMPass\\", vcpayeraccountexternalid as \\"Payer Account\\", vcpayeraddr as \\"PayerVPA\\", vcpayeeaccountexternalid as \\"Payee Account\\", vcpayeeaddr as \\"PayeeVPA\\", null as \\"FailedRule\\", cast(observations->''observations''->''payerVPA''->>''vpaName'' as text) as \\"PayerName\\",  cast(observations->''observations''->''payeeVPA''->>''vpaName'' as text) as \\"PayeeName\\" from analytics.trans where itenantid = :tenantid and (vcpayeraddr = :useraddress or vcpayeeaddr = :useraddress ) and vcclassname  = :txnClass and dttrxntime between cast(cast(:date as date)-1 as timestamp) and cast(:date as date)+ 1 - interval ''1 sec''  order by dttrxntime desc;"
        },
        "Account": {
            "Payer": "select result->''score''->>''decisiondetails'' as \\"decisiondetails\\", ilivemessageid as \\"ILiveMessageID\\", vcmsgid as \\"UniqueID\\", vcclassname as \\"Class\\",  dttrxntime at time zone ''Asia/Kolkata'' at time zone :timeZone as \\"Time\\", cast(dttrxntime at time zone ''Asia/Kolkata'' at time zone :timeZone as date)  as \\"Date\\", dobservationamount as \\"Amount\\", score as \\"Score\\",  cast(result->''score''->>''bpass'' as text)as \\"FRMPass\\", vcpayeraccountexternalid as \\"Payer Account\\", vcpayeraddr as \\"PayerVPA\\", vcpayeeaccountexternalid as \\"Payee Account\\", vcpayeeaddr as \\"PayeeVPA\\", null as \\"FailedRule\\", cast(observations->''observations''->''payerVPA''->>''vpaName'' as text) as \\"PayerName\\",  cast(observations->''observations''->''payeeVPA''->>''vpaName'' as text) as \\"PayeeName\\" from analytics.trans where itenantid = :tenantid and vcpayeraccountexternalid = :useraddress and vcclassname  = :txnClass and dttrxntime between cast(cast(:date as date)-1 as timestamp) and cast(:date as date)+ 1 - interval ''1 sec''  order by dttrxntime desc;",
            "Payee": "select result->''score''->>''decisiondetails'' as \\"decisiondetails\\", ilivemessageid as \\"ILiveMessageID\\", vcmsgid as \\"UniqueID\\", vcclassname as \\"Class\\",  dttrxntime at time zone ''Asia/Kolkata'' at time zone :timeZone as \\"Time\\", cast(dttrxntime at time zone ''Asia/Kolkata'' at time zone :timeZone as date)  as \\"Date\\", dobservationamount as \\"Amount\\", score as \\"Score\\",  cast(result->''score''->>''bpass'' as text)as \\"FRMPass\\", vcpayeraccountexternalid as \\"Payer Account\\", vcpayeraddr as \\"PayerVPA\\", vcpayeeaccountexternalid as \\"Payee Account\\", vcpayeeaddr as \\"PayeeVPA\\", null as \\"FailedRule\\", cast(observations->''observations''->''payerVPA''->>''vpaName'' as text) as \\"PayerName\\",  cast(observations->''observations''->''payeeVPA''->>''vpaName'' as text) as \\"PayeeName\\" from analytics.trans where itenantid = :tenantid and vcpayeeaccountexternalid = :useraddress and vcclassname  = :txnClass and dttrxntime between cast(cast(:date as date)-1 as timestamp) and cast(:date as date)+ 1 - interval ''1 sec''  order by dttrxntime desc;",
            "Both": "select  result->''score''->>''decisiondetails'' as \\"decisiondetails\\", ilivemessageid as \\"ILiveMessageID\\", vcmsgid as \\"UniqueID\\", vcclassname as \\"Class\\",  dttrxntime at time zone ''Asia/Kolkata'' at time zone :timeZone as \\"Time\\", cast(dttrxntime at time zone ''Asia/Kolkata'' at time zone :timeZone as date)  as \\"Date\\", dobservationamount as \\"Amount\\", score as \\"Score\\",  cast(result->''score''->>''bpass'' as text)as \\"FRMPass\\", vcpayeraccountexternalid as \\"Payer Account\\", vcpayeraddr as \\"PayerVPA\\", vcpayeeaccountexternalid as \\"Payee Account\\", vcpayeeaddr as \\"PayeeVPA\\", null as \\"FailedRule\\", cast(observations->''observations''->''payerVPA''->>''vpaName'' as text) as \\"PayerName\\",  cast(observations->''observations''->''payeeVPA''->>''vpaName'' as text) as \\"PayeeName\\" from analytics.trans where itenantid = :tenantid and (vcpayeraccountexternalid = :useraddress or vcpayeeaccountexternalid = :useraddress )  and vcclassname  = :txnClass and dttrxntime between cast(cast(:date as date)-1 as timestamp) and cast(:date as date)+ 1 - interval ''1 sec''  order by dttrxntime desc;"
        }
    }
    }
}'::text WHERE
idashboardqueryid = 69;

--Transaction Profile Dashboard
INSERT INTO ui.dashboardqueryparameters (
vcparametername, vcparametertype, idashboardqueryid, iorder) VALUES (
'Request'::character varying, 'JsonPath'::character varying, '77'::integer, '0'::integer)
 returning idashboardparameterid;
UPDATE ui.dashboardqueryparameters set iorder=1 where idashboardqueryid=77 and vcparametername='txnClass';
UPDATE ui.dashboardqueryparameters set iorder=2 where idashboardqueryid=77 and vcparametername='party';
UPDATE ui.dashboardqueryparameters set iorder=3 where idashboardqueryid=77 and vcparametername='vpaType';
UPDATE ui.dashboardquery SET
vcfilterparametersjson = '{ "Request":null, "party": null, "vpaType": null, "msgid": null, "vpaAddress": null, "txnClass": null }'::text WHERE
idashboardqueryid = 77;

UPDATE ui.dashboardquery SET
vcdashboardquery =  E'{
    "Initial":{
        "All":{
            "All":{
                "All":"select ilivemessageid as \\"ILiveMessageID\\", vcmsgid as \\"UniqueID\\", vcclassname as \\"Class\\", dttrxntime at time zone  ''Asia/Kolkata'' at time zone :timeZone as \\"Time\\", dobservationamount as \\"Amount\\", score as \\"Score\\",  cast(result->''score''->>''bpass'' as text)as \\"FRMPass\\", vcpayeraccountexternalid as \\"Payer Account\\", vcpayeraddr as \\"PayerVPA\\", vcpayeeaccountexternalid as \\"Payee Account\\", vcpayeeaddr as \\"PayeeVPA\\", null as \\"FailedRule\\", cast(observations->''observations''->''payerVPA''->>''vpaName'' as text) as \\"PayerName\\",  cast(observations->''observations''->''payeeVPA''->>''vpaName'' as text) as \\"PayeeName\\" from analytics.trans where vcclassname in (with d1 as (select mappingid from ui.webusermapping where webuserid = :loggedinuser and mappingtype = ''TransactionClass'') (select vcclassname FROM ui.transactionclasses where (iclassid in (select mappingid from d1) or -1 in (select mappingid from d1)) and itenantid=:tenantid)) and itenantid = :tenantid ORDER BY dttrxntime desc LIMIT 1;"
            }
        }
    },
    "Redirect":{
        "All":{
          "All":{
              "All":"select ilivemessageid as \\"ILiveMessageID\\", vcmsgid as \\"UniqueID\\", vcclassname as \\"Class\\", dttrxntime at time zone ''Asia/Kolkata'' at time zone :timeZone as \\"Time\\", dobservationamount as \\"Amount\\", score as \\"Score\\",  cast(result->''score''->>''bpass'' as text)as \\"FRMPass\\", vcpayeraccountexternalid as \\"Payer Account\\", vcpayeraddr as \\"PayerVPA\\", vcpayeeaccountexternalid as \\"Payee Account\\", vcpayeeaddr as \\"PayeeVPA\\", null as \\"FailedRule\\", cast(observations->''observations''->''payerVPA''->>''vpaName'' as text) as \\"PayerName\\", cast(observations->''observations''->''payeeVPA''->>''vpaName'' as text) as \\"PayeeName\\" from analytics.trans where vcmsgid =:msgid and itenantid=:tenantid;"
         }
      }
    },
    "Search":{
    "All": {
        "Account": {
            "Payer": "WITH first_query_result AS ( SELECT result->''score''->>''decisiondetails'' as \\"decisiondetails\\", ilivemessageid as \\"ILiveMessageID\\", vcmsgid as \\"UniqueID\\", vcclassname as \\"Class\\", dttrxntime at time zone ''Asia/Kolkata'' as \\"Time\\", dobservationamount as \\"Amount\\", score as \\"Score\\", cast(result->''score''->>''bpass'' as text) as \\"FRMPass\\", vcpayeraccountexternalid as \\"Payer Account\\", vcpayeraddr as \\"PayerVPA\\", vcpayeeaccountexternalid as \\"Payee Account\\", vcpayeeaddr as \\"PayeeVPA\\", null as \\"FailedRule\\", cast(observations->''observations''->''payerVPA''->>''vpaName'' as text) as \\"PayerName\\", cast(observations->''observations''->''payeeVPA''->>''vpaName'' as text) as \\"PayeeName\\" FROM analytics.trans WHERE vcmsgid = :msgid ) SELECT * FROM first_query_result UNION ALL ( SELECT result->''score''->>''decisiondetails'' as \\"decisiondetails\\", ilivemessageid as \\"ILiveMessageID\\", vcmsgid as \\"UniqueID\\", vcclassname as \\"Class\\", dttrxntime at time zone ''Asia/Kolkata'' as \\"Time\\", dobservationamount as \\"Amount\\", score as \\"Score\\", cast(result->''score''->>''bpass'' as text) as \\"FRMPass\\", vcpayeraccountexternalid as \\"Payer Account\\", vcpayeraddr as \\"PayerVPA\\", vcpayeeaccountexternalid as \\"Payee Account\\", vcpayeeaddr as \\"PayeeVPA\\", null as \\"FailedRule\\", cast(observations->''observations''->''payerVPA''->>''vpaName'' as text) as \\"PayerName\\", cast(observations->''observations''->''payeeVPA''->>''vpaName'' as text) as \\"PayeeName\\" FROM analytics.trans WHERE vcclassname in (with d1 as (select mappingid from ui.webusermapping where webuserid = :loggedinuser and mappingtype = ''TransactionClass'') (select vcclassname FROM ui.transactionclasses where (iclassid in (select mappingid from d1) or -1 in (select mappingid from d1)) and itenantid=:tenantid)) and itenantid = :tenantid and vcpayeraccountexternalid = :vpaAddress AND ilivemessageid > (SELECT \\"ILiveMessageID\\" FROM first_query_result) ORDER BY ilivemessageid ASC LIMIT 20 ) UNION ALL ( SELECT result->''score''->>''decisiondetails'' as \\"decisiondetails\\", ilivemessageid as \\"ILiveMessageID\\", vcmsgid as \\"UniqueID\\", vcclassname as \\"Class\\", dttrxntime at time zone ''Asia/Kolkata'' as \\"Time\\", dobservationamount as \\"Amount\\", score as \\"Score\\", cast(result->''score''->>''bpass'' as text) as \\"FRMPass\\", vcpayeraccountexternalid as \\"Payer Account\\", vcpayeraddr as \\"PayerVPA\\", vcpayeeaccountexternalid as \\"Payee Account\\", vcpayeeaddr as \\"PayeeVPA\\", null as \\"FailedRule\\", cast(observations->''observations''->''payerVPA''->>''vpaName'' as text) as \\"PayerName\\", cast(observations->''observations''->''payeeVPA''->>''vpaName'' as text) as \\"PayeeName\\" FROM analytics.trans WHERE vcpayeraccountexternalid = :vpaAddress AND ilivemessageid < (SELECT \\"ILiveMessageID\\" FROM first_query_result) ORDER BY ilivemessageid DESC LIMIT 20 );",
            "Payee": "WITH first_query_result AS ( SELECT result->''score''->>''decisiondetails'' as \\"decisiondetails\\", ilivemessageid as \\"ILiveMessageID\\", vcmsgid as \\"UniqueID\\", vcclassname as \\"Class\\", dttrxntime at time zone ''Asia/Kolkata'' as \\"Time\\", dobservationamount as \\"Amount\\", score as \\"Score\\", cast(result->''score''->>''bpass'' as text) as \\"FRMPass\\", vcpayeraccountexternalid as \\"Payer Account\\", vcpayeraddr as \\"PayerVPA\\", vcpayeeaccountexternalid as \\"Payee Account\\", vcpayeeaddr as \\"PayeeVPA\\", null as \\"FailedRule\\", cast(observations->''observations''->''payerVPA''->>''vpaName'' as text) as \\"PayerName\\", cast(observations->''observations''->''payeeVPA''->>''vpaName'' as text) as \\"PayeeName\\" FROM analytics.trans WHERE vcmsgid = :msgid ) SELECT * FROM first_query_result UNION ALL ( SELECT result->''score''->>''decisiondetails'' as \\"decisiondetails\\", ilivemessageid as \\"ILiveMessageID\\", vcmsgid as \\"UniqueID\\", vcclassname as \\"Class\\", dttrxntime at time zone ''Asia/Kolkata'' as \\"Time\\", dobservationamount as \\"Amount\\", score as \\"Score\\", cast(result->''score''->>''bpass'' as text) as \\"FRMPass\\", vcpayeraccountexternalid as \\"Payer Account\\", vcpayeraddr as \\"PayerVPA\\", vcpayeeaccountexternalid as \\"Payee Account\\", vcpayeeaddr as \\"PayeeVPA\\", null as \\"FailedRule\\", cast(observations->''observations''->''payerVPA''->>''vpaName'' as text) as \\"PayerName\\", cast(observations->''observations''->''payeeVPA''->>''vpaName'' as text) as \\"PayeeName\\" FROM analytics.trans WHERE vcclassname in (with d1 as (select mappingid from ui.webusermapping where webuserid = :loggedinuser and mappingtype = ''TransactionClass'') (select vcclassname FROM ui.transactionclasses where (iclassid in (select mappingid from d1) or -1 in (select mappingid from d1)) and itenantid=:tenantid)) and itenantid = :tenantid and vcpayeeaccountexternalid = :vpaAddress AND ilivemessageid > (SELECT \\"ILiveMessageID\\" FROM first_query_result) ORDER BY ilivemessageid ASC LIMIT 20 ) UNION ALL ( SELECT result->''score''->>''decisiondetails'' as \\"decisiondetails\\", ilivemessageid as \\"ILiveMessageID\\", vcmsgid as \\"UniqueID\\", vcclassname as \\"Class\\", dttrxntime at time zone ''Asia/Kolkata'' as \\"Time\\", dobservationamount as \\"Amount\\", score as \\"Score\\", cast(result->''score''->>''bpass'' as text) as \\"FRMPass\\", vcpayeraccountexternalid as \\"Payer Account\\", vcpayeraddr as \\"PayerVPA\\", vcpayeeaccountexternalid as \\"Payee Account\\", vcpayeeaddr as \\"PayeeVPA\\", null as \\"FailedRule\\", cast(observations->''observations''->''payerVPA''->>''vpaName'' as text) as \\"PayerName\\", cast(observations->''observations''->''payeeVPA''->>''vpaName'' as text) as \\"PayeeName\\" FROM analytics.trans WHERE vcpayeeaccountexternalid = :vpaAddress AND ilivemessageid < (SELECT \\"ILiveMessageID\\" FROM first_query_result) ORDER BY ilivemessageid DESC LIMIT 20 );",
            "Both": "WITH first_query_result AS ( SELECT result->''score''->>''decisiondetails'' as \\"decisiondetails\\", ilivemessageid as \\"ILiveMessageID\\", vcmsgid as \\"UniqueID\\", vcclassname as \\"Class\\", dttrxntime at time zone ''Asia/Kolkata'' as \\"Time\\", dobservationamount as \\"Amount\\", score as \\"Score\\", cast(result->''score''->>''bpass'' as text) as \\"FRMPass\\", vcpayeraccountexternalid as \\"Payer Account\\", vcpayeraddr as \\"PayerVPA\\", vcpayeeaccountexternalid as \\"Payee Account\\", vcpayeeaddr as \\"PayeeVPA\\", null as \\"FailedRule\\", cast(observations->''observations''->''payerVPA''->>''vpaName'' as text) as \\"PayerName\\", cast(observations->''observations''->''payeeVPA''->>''vpaName'' as text) as \\"PayeeName\\" FROM analytics.trans WHERE vcmsgid = :msgid ) SELECT * FROM first_query_result UNION ALL ( SELECT result->''score''->>''decisiondetails'' as \\"decisiondetails\\", ilivemessageid as \\"ILiveMessageID\\", vcmsgid as \\"UniqueID\\", vcclassname as \\"Class\\", dttrxntime at time zone ''Asia/Kolkata'' as \\"Time\\", dobservationamount as \\"Amount\\", score as \\"Score\\", cast(result->''score''->>''bpass'' as text) as \\"FRMPass\\", vcpayeraccountexternalid as \\"Payer Account\\", vcpayeraddr as \\"PayerVPA\\", vcpayeeaccountexternalid as \\"Payee Account\\", vcpayeeaddr as \\"PayeeVPA\\", null as \\"FailedRule\\", cast(observations->''observations''->''payerVPA''->>''vpaName'' as text) as \\"PayerName\\", cast(observations->''observations''->''payeeVPA''->>''vpaName'' as text) as \\"PayeeName\\" FROM analytics.trans WHERE vcclassname in (with d1 as (select mappingid from ui.webusermapping where webuserid = :loggedinuser and mappingtype = ''TransactionClass'') (select vcclassname FROM ui.transactionclasses where (iclassid in (select mappingid from d1) or -1 in (select mappingid from d1)) and itenantid=:tenantid)) and itenantid = :tenantid and (vcpayeraccountexternalid = :vpaAddress or vcpayeeaccountexternalid = :vpaAddress) AND ilivemessageid > (SELECT \\"ILiveMessageID\\" FROM first_query_result) ORDER BY ilivemessageid ASC LIMIT 20 ) UNION ALL ( SELECT result->''score''->>''decisiondetails'' as \\"decisiondetails\\", ilivemessageid as \\"ILiveMessageID\\", vcmsgid as \\"UniqueID\\", vcclassname as \\"Class\\", dttrxntime at time zone ''Asia/Kolkata'' as \\"Time\\", dobservationamount as \\"Amount\\", score as \\"Score\\", cast(result->''score''->>''bpass'' as text) as \\"FRMPass\\", vcpayeraccountexternalid as \\"Payer Account\\", vcpayeraddr as \\"PayerVPA\\", vcpayeeaccountexternalid as \\"Payee Account\\", vcpayeeaddr as \\"PayeeVPA\\", null as \\"FailedRule\\", cast(observations->''observations''->''payerVPA''->>''vpaName'' as text) as \\"PayerName\\", cast(observations->''observations''->''payeeVPA''->>''vpaName'' as text) as \\"PayeeName\\" FROM analytics.trans WHERE (vcpayeraccountexternalid = :vpaAddress or vcpayeeaccountexternalid = :vpaAddress) AND ilivemessageid < (SELECT \\"ILiveMessageID\\" FROM first_query_result) ORDER BY ilivemessageid DESC LIMIT 20 );"
        },
        "VPA": {
            "Payer": "WITH first_query_result AS ( SELECT result->''score''->>''decisiondetails'' as \\"decisiondetails\\", ilivemessageid as \\"ILiveMessageID\\", vcmsgid as \\"UniqueID\\", vcclassname as \\"Class\\", dttrxntime at time zone ''Asia/Kolkata'' as \\"Time\\", dobservationamount as \\"Amount\\", score as \\"Score\\", cast(result->''score''->>''bpass'' as text) as \\"FRMPass\\", vcpayeraccountexternalid as \\"Payer Account\\", vcpayeraddr as \\"PayerVPA\\", vcpayeeaccountexternalid as \\"Payee Account\\", vcpayeeaddr as \\"PayeeVPA\\", null as \\"FailedRule\\", cast(observations->''observations''->''payerVPA''->>''vpaName'' as text) as \\"PayerName\\", cast(observations->''observations''->''payeeVPA''->>''vpaName'' as text) as \\"PayeeName\\" FROM analytics.trans WHERE vcmsgid = :msgid ) SELECT * FROM first_query_result UNION ALL ( SELECT result->''score''->>''decisiondetails'' as \\"decisiondetails\\", ilivemessageid as \\"ILiveMessageID\\", vcmsgid as \\"UniqueID\\", vcclassname as \\"Class\\", dttrxntime at time zone ''Asia/Kolkata'' as \\"Time\\", dobservationamount as \\"Amount\\", score as \\"Score\\", cast(result->''score''->>''bpass'' as text) as \\"FRMPass\\", vcpayeraccountexternalid as \\"Payer Account\\", vcpayeraddr as \\"PayerVPA\\", vcpayeeaccountexternalid as \\"Payee Account\\", vcpayeeaddr as \\"PayeeVPA\\", null as \\"FailedRule\\", cast(observations->''observations''->''payerVPA''->>''vpaName'' as text) as \\"PayerName\\", cast(observations->''observations''->''payeeVPA''->>''vpaName'' as text) as \\"PayeeName\\" FROM analytics.trans WHERE itenantid = :tenantid and vcpayeraddr = :vpaAddress AND ilivemessageid > (SELECT \\"ILiveMessageID\\" FROM first_query_result) ORDER BY ilivemessageid ASC LIMIT 20 ) UNION ALL ( SELECT result->''score''->>''decisiondetails'' as \\"decisiondetails\\", ilivemessageid as \\"ILiveMessageID\\", vcmsgid as \\"UniqueID\\", vcclassname as \\"Class\\", dttrxntime at time zone ''Asia/Kolkata'' as \\"Time\\", dobservationamount as \\"Amount\\", score as \\"Score\\", cast(result->''score''->>''bpass'' as text) as \\"FRMPass\\", vcpayeraccountexternalid as \\"Payer Account\\", vcpayeraddr as \\"PayerVPA\\", vcpayeeaccountexternalid as \\"Payee Account\\", vcpayeeaddr as \\"PayeeVPA\\", null as \\"FailedRule\\", cast(observations->''observations''->''payerVPA''->>''vpaName'' as text) as \\"PayerName\\", cast(observations->''observations''->''payeeVPA''->>''vpaName'' as text) as \\"PayeeName\\" FROM analytics.trans WHERE vcclassname in (with d1 as (select mappingid from ui.webusermapping where webuserid = :loggedinuser and mappingtype = ''TransactionClass'') (select vcclassname FROM ui.transactionclasses where (iclassid in (select mappingid from d1) or -1 in (select mappingid from d1)) and itenantid=:tenantid)) and vcpayeraddr = :vpaAddress AND ilivemessageid < (SELECT \\"ILiveMessageID\\" FROM first_query_result) ORDER BY ilivemessageid DESC LIMIT 20 );",
            "Payee": "WITH first_query_result AS ( SELECT result->''score''->>''decisiondetails'' as \\"decisiondetails\\", ilivemessageid as \\"ILiveMessageID\\", vcmsgid as \\"UniqueID\\", vcclassname as \\"Class\\", dttrxntime at time zone ''Asia/Kolkata'' as \\"Time\\", dobservationamount as \\"Amount\\", score as \\"Score\\", cast(result->''score''->>''bpass'' as text) as \\"FRMPass\\", vcpayeraccountexternalid as \\"Payer Account\\", vcpayeraddr as \\"PayerVPA\\", vcpayeeaccountexternalid as \\"Payee Account\\", vcpayeeaddr as \\"PayeeVPA\\", null as \\"FailedRule\\", cast(observations->''observations''->''payerVPA''->>''vpaName'' as text) as \\"PayerName\\", cast(observations->''observations''->''payeeVPA''->>''vpaName'' as text) as \\"PayeeName\\" FROM analytics.trans WHERE vcmsgid = :msgid ) SELECT * FROM first_query_result UNION ALL ( SELECT result->''score''->>''decisiondetails'' as \\"decisiondetails\\", ilivemessageid as \\"ILiveMessageID\\", vcmsgid as \\"UniqueID\\", vcclassname as \\"Class\\", dttrxntime at time zone ''Asia/Kolkata'' as \\"Time\\", dobservationamount as \\"Amount\\", score as \\"Score\\", cast(result->''score''->>''bpass'' as text) as \\"FRMPass\\", vcpayeraccountexternalid as \\"Payer Account\\", vcpayeraddr as \\"PayerVPA\\", vcpayeeaccountexternalid as \\"Payee Account\\", vcpayeeaddr as \\"PayeeVPA\\", null as \\"FailedRule\\", cast(observations->''observations''->''payerVPA''->>''vpaName'' as text) as \\"PayerName\\", cast(observations->''observations''->''payeeVPA''->>''vpaName'' as text) as \\"PayeeName\\" FROM analytics.trans WHERE itenantid = :tenantid and vcpayeeaddr = :vpaAddress AND ilivemessageid > (SELECT \\"ILiveMessageID\\" FROM first_query_result) ORDER BY ilivemessageid ASC LIMIT 20 ) UNION ALL ( SELECT result->''score''->>''decisiondetails'' as \\"decisiondetails\\", ilivemessageid as \\"ILiveMessageID\\", vcmsgid as \\"UniqueID\\", vcclassname as \\"Class\\", dttrxntime at time zone ''Asia/Kolkata'' as \\"Time\\", dobservationamount as \\"Amount\\", score as \\"Score\\", cast(result->''score''->>''bpass'' as text) as \\"FRMPass\\", vcpayeraccountexternalid as \\"Payer Account\\", vcpayeraddr as \\"PayerVPA\\", vcpayeeaccountexternalid as \\"Payee Account\\", vcpayeeaddr as \\"PayeeVPA\\", null as \\"FailedRule\\", cast(observations->''observations''->''payerVPA''->>''vpaName'' as text) as \\"PayerName\\", cast(observations->''observations''->''payeeVPA''->>''vpaName'' as text) as \\"PayeeName\\" FROM analytics.trans WHERE vcclassname in (with d1 as (select mappingid from ui.webusermapping where webuserid = :loggedinuser and mappingtype = ''TransactionClass'') (select vcclassname FROM ui.transactionclasses where (iclassid in (select mappingid from d1) or -1 in (select mappingid from d1)) and itenantid=:tenantid)) and vcpayeeaddr = :vpaAddress AND ilivemessageid < (SELECT \\"ILiveMessageID\\" FROM first_query_result) ORDER BY ilivemessageid DESC LIMIT 20 );",
            "Both": "WITH first_query_result AS ( SELECT result->''score''->>''decisiondetails'' as \\"decisiondetails\\", ilivemessageid as \\"ILiveMessageID\\", vcmsgid as \\"UniqueID\\", vcclassname as \\"Class\\", dttrxntime at time zone ''Asia/Kolkata'' as \\"Time\\", dobservationamount as \\"Amount\\", score as \\"Score\\", cast(result->''score''->>''bpass'' as text) as \\"FRMPass\\", vcpayeraccountexternalid as \\"Payer Account\\", vcpayeraddr as \\"PayerVPA\\", vcpayeeaccountexternalid as \\"Payee Account\\", vcpayeeaddr as \\"PayeeVPA\\", null as \\"FailedRule\\", cast(observations->''observations''->''payerVPA''->>''vpaName'' as text) as \\"PayerName\\", cast(observations->''observations''->''payeeVPA''->>''vpaName'' as text) as \\"PayeeName\\" FROM analytics.trans WHERE vcmsgid = :msgid ) SELECT * FROM first_query_result UNION ALL ( SELECT result->''score''->>''decisiondetails'' as \\"decisiondetails\\", ilivemessageid as \\"ILiveMessageID\\", vcmsgid as \\"UniqueID\\", vcclassname as \\"Class\\", dttrxntime at time zone ''Asia/Kolkata'' as \\"Time\\", dobservationamount as \\"Amount\\", score as \\"Score\\", cast(result->''score''->>''bpass'' as text) as \\"FRMPass\\", vcpayeraccountexternalid as \\"Payer Account\\", vcpayeraddr as \\"PayerVPA\\", vcpayeeaccountexternalid as \\"Payee Account\\", vcpayeeaddr as \\"PayeeVPA\\", null as \\"FailedRule\\", cast(observations->''observations''->''payerVPA''->>''vpaName'' as text) as \\"PayerName\\", cast(observations->''observations''->''payeeVPA''->>''vpaName'' as text) as \\"PayeeName\\" FROM analytics.trans WHERE itenantid = :tenantid and (vcpayeraddr = :vpaAddress or vcpayeeaddr = :vpaAddress) AND ilivemessageid > (SELECT \\"ILiveMessageID\\" FROM first_query_result) ORDER BY ilivemessageid ASC LIMIT 20 ) UNION ALL ( SELECT result->''score''->>''decisiondetails'' as \\"decisiondetails\\", ilivemessageid as \\"ILiveMessageID\\", vcmsgid as \\"UniqueID\\", vcclassname as \\"Class\\", dttrxntime at time zone ''Asia/Kolkata'' as \\"Time\\", dobservationamount as \\"Amount\\", score as \\"Score\\", cast(result->''score''->>''bpass'' as text) as \\"FRMPass\\", vcpayeraccountexternalid as \\"Payer Account\\", vcpayeraddr as \\"PayerVPA\\", vcpayeeaccountexternalid as \\"Payee Account\\", vcpayeeaddr as \\"PayeeVPA\\", null as \\"FailedRule\\", cast(observations->''observations''->''payerVPA''->>''vpaName'' as text) as \\"PayerName\\", cast(observations->''observations''->''payeeVPA''->>''vpaName'' as text) as \\"PayeeName\\" FROM analytics.trans WHERE vcclassname in (with d1 as (select mappingid from ui.webusermapping where webuserid = :loggedinuser and mappingtype = ''TransactionClass'') (select vcclassname FROM ui.transactionclasses where (iclassid in (select mappingid from d1) or -1 in (select mappingid from d1)) and itenantid=:tenantid)) and (vcpayeraddr = :vpaAddress or vcpayeeaddr = :vpaAddress) AND ilivemessageid < (SELECT \\"ILiveMessageID\\" FROM first_query_result) ORDER BY ilivemessageid DESC LIMIT 20 );"
        }
    },
    "Other": {
        "Account": {
            "Payer": "WITH first_query_result AS ( SELECT result->''score''->>''decisiondetails'' as \\"decisiondetails\\", ilivemessageid as \\"ILiveMessageID\\", vcmsgid as \\"UniqueID\\", vcclassname as \\"Class\\", dttrxntime at time zone ''Asia/Kolkata'' as \\"Time\\", dobservationamount as \\"Amount\\", score as \\"Score\\", cast(result->''score''->>''bpass'' as text) as \\"FRMPass\\", vcpayeraccountexternalid as \\"Payer Account\\", vcpayeraddr as \\"PayerVPA\\", vcpayeeaccountexternalid as \\"Payee Account\\", vcpayeeaddr as \\"PayeeVPA\\", null as \\"FailedRule\\", cast(observations->''observations''->''payerVPA''->>''vpaName'' as text) as \\"PayerName\\", cast(observations->''observations''->''payeeVPA''->>''vpaName'' as text) as \\"PayeeName\\" FROM analytics.trans WHERE vcmsgid = :msgid ) SELECT * FROM first_query_result UNION ALL ( SELECT result->''score''->>''decisiondetails'' as \\"decisiondetails\\", ilivemessageid as \\"ILiveMessageID\\", vcmsgid as \\"UniqueID\\", vcclassname as \\"Class\\", dttrxntime at time zone ''Asia/Kolkata'' as \\"Time\\", dobservationamount as \\"Amount\\", score as \\"Score\\", cast(result->''score''->>''bpass'' as text) as \\"FRMPass\\", vcpayeraccountexternalid as \\"Payer Account\\", vcpayeraddr as \\"PayerVPA\\", vcpayeeaccountexternalid as \\"Payee Account\\", vcpayeeaddr as \\"PayeeVPA\\", null as \\"FailedRule\\", cast(observations->''observations''->''payerVPA''->>''vpaName'' as text) as \\"PayerName\\", cast(observations->''observations''->''payeeVPA''->>''vpaName'' as text) as \\"PayeeName\\" FROM analytics.trans WHERE vcpayeraccountexternalid = :vpaAddress and vcclassname = :txnClass AND ilivemessageid > (SELECT \\"ILiveMessageID\\" FROM first_query_result) ORDER BY ilivemessageid ASC LIMIT 20 ) UNION ALL ( SELECT result->''score''->>''decisiondetails'' as \\"decisiondetails\\", ilivemessageid as \\"ILiveMessageID\\", vcmsgid as \\"UniqueID\\", vcclassname as \\"Class\\", dttrxntime at time zone ''Asia/Kolkata'' as \\"Time\\", dobservationamount as \\"Amount\\", score as \\"Score\\", cast(result->''score''->>''bpass'' as text) as \\"FRMPass\\", vcpayeraccountexternalid as \\"Payer Account\\", vcpayeraddr as \\"PayerVPA\\", vcpayeeaccountexternalid as \\"Payee Account\\", vcpayeeaddr as \\"PayeeVPA\\", null as \\"FailedRule\\", cast(observations->''observations''->''payerVPA''->>''vpaName'' as text) as \\"PayerName\\", cast(observations->''observations''->''payeeVPA''->>''vpaName'' as text) as \\"PayeeName\\" FROM analytics.trans WHERE itenantid = :tenantid and vcpayeraccountexternalid = :vpaAddress and vcclassname = :txnClass AND ilivemessageid < (SELECT \\"ILiveMessageID\\" FROM first_query_result) ORDER BY ilivemessageid DESC LIMIT 20 );",
            "Payee": "WITH first_query_result AS ( SELECT result->''score''->>''decisiondetails'' as \\"decisiondetails\\", ilivemessageid as \\"ILiveMessageID\\", vcmsgid as \\"UniqueID\\", vcclassname as \\"Class\\", dttrxntime at time zone ''Asia/Kolkata'' as \\"Time\\", dobservationamount as \\"Amount\\", score as \\"Score\\", cast(result->''score''->>''bpass'' as text) as \\"FRMPass\\", vcpayeraccountexternalid as \\"Payer Account\\", vcpayeraddr as \\"PayerVPA\\", vcpayeeaccountexternalid as \\"Payee Account\\", vcpayeeaddr as \\"PayeeVPA\\", null as \\"FailedRule\\", cast(observations->''observations''->''payerVPA''->>''vpaName'' as text) as \\"PayerName\\", cast(observations->''observations''->''payeeVPA''->>''vpaName'' as text) as \\"PayeeName\\" FROM analytics.trans WHERE vcmsgid = :msgid ) SELECT * FROM first_query_result UNION ALL ( SELECT result->''score''->>''decisiondetails'' as \\"decisiondetails\\", ilivemessageid as \\"ILiveMessageID\\", vcmsgid as \\"UniqueID\\", vcclassname as \\"Class\\", dttrxntime at time zone ''Asia/Kolkata'' as \\"Time\\", dobservationamount as \\"Amount\\", score as \\"Score\\", cast(result->''score''->>''bpass'' as text) as \\"FRMPass\\", vcpayeraccountexternalid as \\"Payer Account\\", vcpayeraddr as \\"PayerVPA\\", vcpayeeaccountexternalid as \\"Payee Account\\", vcpayeeaddr as \\"PayeeVPA\\", null as \\"FailedRule\\", cast(observations->''observations''->''payerVPA''->>''vpaName'' as text) as \\"PayerName\\", cast(observations->''observations''->''payeeVPA''->>''vpaName'' as text) as \\"PayeeName\\" FROM analytics.trans WHERE vcpayeeaccountexternalid = :vpaAddress and vcclassname = :txnClass AND ilivemessageid > (SELECT \\"ILiveMessageID\\" FROM first_query_result) ORDER BY ilivemessageid ASC LIMIT 20 ) UNION ALL ( SELECT result->''score''->>''decisiondetails'' as \\"decisiondetails\\", ilivemessageid as \\"ILiveMessageID\\", vcmsgid as \\"UniqueID\\", vcclassname as \\"Class\\", dttrxntime at time zone ''Asia/Kolkata'' as \\"Time\\", dobservationamount as \\"Amount\\", score as \\"Score\\", cast(result->''score''->>''bpass'' as text) as \\"FRMPass\\", vcpayeraccountexternalid as \\"Payer Account\\", vcpayeraddr as \\"PayerVPA\\", vcpayeeaccountexternalid as \\"Payee Account\\", vcpayeeaddr as \\"PayeeVPA\\", null as \\"FailedRule\\", cast(observations->''observations''->''payerVPA''->>''vpaName'' as text) as \\"PayerName\\", cast(observations->''observations''->''payeeVPA''->>''vpaName'' as text) as \\"PayeeName\\" FROM analytics.trans WHERE itenantid = :tenantid and vcpayeeaccountexternalid = :vpaAddress and vcclassname = :txnClass AND ilivemessageid < (SELECT \\"ILiveMessageID\\" FROM first_query_result) ORDER BY ilivemessageid DESC LIMIT 20 );",
            "Both": "WITH first_query_result AS ( SELECT result->''score''->>''decisiondetails'' as \\"decisiondetails\\", ilivemessageid as \\"ILiveMessageID\\", vcmsgid as \\"UniqueID\\", vcclassname as \\"Class\\", dttrxntime at time zone ''Asia/Kolkata'' as \\"Time\\", dobservationamount as \\"Amount\\", score as \\"Score\\", cast(result->''score''->>''bpass'' as text) as \\"FRMPass\\", vcpayeraccountexternalid as \\"Payer Account\\", vcpayeraddr as \\"PayerVPA\\", vcpayeeaccountexternalid as \\"Payee Account\\", vcpayeeaddr as \\"PayeeVPA\\", null as \\"FailedRule\\", cast(observations->''observations''->''payerVPA''->>''vpaName'' as text) as \\"PayerName\\", cast(observations->''observations''->''payeeVPA''->>''vpaName'' as text) as \\"PayeeName\\" FROM analytics.trans WHERE vcmsgid = :msgid ) SELECT * FROM first_query_result UNION ALL ( SELECT result->''score''->>''decisiondetails'' as \\"decisiondetails\\", ilivemessageid as \\"ILiveMessageID\\", vcmsgid as \\"UniqueID\\", vcclassname as \\"Class\\", dttrxntime at time zone ''Asia/Kolkata'' as \\"Time\\", dobservationamount as \\"Amount\\", score as \\"Score\\", cast(result->''score''->>''bpass'' as text) as \\"FRMPass\\", vcpayeraccountexternalid as \\"Payer Account\\", vcpayeraddr as \\"PayerVPA\\", vcpayeeaccountexternalid as \\"Payee Account\\", vcpayeeaddr as \\"PayeeVPA\\", null as \\"FailedRule\\", cast(observations->''observations''->''payerVPA''->>''vpaName'' as text) as \\"PayerName\\", cast(observations->''observations''->''payeeVPA''->>''vpaName'' as text) as \\"PayeeName\\" FROM analytics.trans WHERE (vcpayeraccountexternalid = :vpaAddress or vcpayeeaccountexternalid = :vpaAddress) and vcclassname = :txnClass AND ilivemessageid > (SELECT \\"ILiveMessageID\\" FROM first_query_result) ORDER BY ilivemessageid ASC LIMIT 20 ) UNION ALL ( SELECT result->''score''->>''decisiondetails'' as \\"decisiondetails\\", ilivemessageid as \\"ILiveMessageID\\", vcmsgid as \\"UniqueID\\", vcclassname as \\"Class\\", dttrxntime at time zone ''Asia/Kolkata'' as \\"Time\\", dobservationamount as \\"Amount\\", score as \\"Score\\", cast(result->''score''->>''bpass'' as text) as \\"FRMPass\\", vcpayeraccountexternalid as \\"Payer Account\\", vcpayeraddr as \\"PayerVPA\\", vcpayeeaccountexternalid as \\"Payee Account\\", vcpayeeaddr as \\"PayeeVPA\\", null as \\"FailedRule\\", cast(observations->''observations''->''payerVPA''->>''vpaName'' as text) as \\"PayerName\\", cast(observations->''observations''->''payeeVPA''->>''vpaName'' as text) as \\"PayeeName\\" FROM analytics.trans WHERE itenantid = :tenantid and (vcpayeraccountexternalid = :vpaAddress or vcpayeeaccountexternalid = :vpaAddress) and vcclassname = :txnClass AND ilivemessageid < (SELECT \\"ILiveMessageID\\" FROM first_query_result) ORDER BY ilivemessageid DESC LIMIT 20 );"
        },
        "VPA": {
            "Payer": "WITH first_query_result AS ( SELECT result->''score''->>''decisiondetails'' as \\"decisiondetails\\", ilivemessageid as \\"ILiveMessageID\\", vcmsgid as \\"UniqueID\\", vcclassname as \\"Class\\", dttrxntime at time zone ''Asia/Kolkata'' as \\"Time\\", dobservationamount as \\"Amount\\", score as \\"Score\\", cast(result->''score''->>''bpass'' as text) as \\"FRMPass\\", vcpayeraccountexternalid as \\"Payer Account\\", vcpayeraddr as \\"PayerVPA\\", vcpayeeaccountexternalid as \\"Payee Account\\", vcpayeeaddr as \\"PayeeVPA\\", null as \\"FailedRule\\", cast(observations->''observations''->''payerVPA''->>''vpaName'' as text) as \\"PayerName\\", cast(observations->''observations''->''payeeVPA''->>''vpaName'' as text) as \\"PayeeName\\" FROM analytics.trans WHERE vcmsgid = :msgid ) SELECT * FROM first_query_result UNION ALL ( SELECT result->''score''->>''decisiondetails'' as \\"decisiondetails\\", ilivemessageid as \\"ILiveMessageID\\", vcmsgid as \\"UniqueID\\", vcclassname as \\"Class\\", dttrxntime at time zone ''Asia/Kolkata'' as \\"Time\\", dobservationamount as \\"Amount\\", score as \\"Score\\", cast(result->''score''->>''bpass'' as text) as \\"FRMPass\\", vcpayeraccountexternalid as \\"Payer Account\\", vcpayeraddr as \\"PayerVPA\\", vcpayeeaccountexternalid as \\"Payee Account\\", vcpayeeaddr as \\"PayeeVPA\\", null as \\"FailedRule\\", cast(observations->''observations''->''payerVPA''->>''vpaName'' as text) as \\"PayerName\\", cast(observations->''observations''->''payeeVPA''->>''vpaName'' as text) as \\"PayeeName\\" FROM analytics.trans WHERE vcpayeraddr = :vpaAddress and vcclassname = :txnClass AND ilivemessageid > (SELECT \\"ILiveMessageID\\" FROM first_query_result) ORDER BY ilivemessageid ASC LIMIT 20 ) UNION ALL ( SELECT result->''score''->>''decisiondetails'' as \\"decisiondetails\\", ilivemessageid as \\"ILiveMessageID\\", vcmsgid as \\"UniqueID\\", vcclassname as \\"Class\\", dttrxntime at time zone ''Asia/Kolkata'' as \\"Time\\", dobservationamount as \\"Amount\\", score as \\"Score\\", cast(result->''score''->>''bpass'' as text) as \\"FRMPass\\", vcpayeraccountexternalid as \\"Payer Account\\", vcpayeraddr as \\"PayerVPA\\", vcpayeeaccountexternalid as \\"Payee Account\\", vcpayeeaddr as \\"PayeeVPA\\", null as \\"FailedRule\\", cast(observations->''observations''->''payerVPA''->>''vpaName'' as text) as \\"PayerName\\", cast(observations->''observations''->''payeeVPA''->>''vpaName'' as text) as \\"PayeeName\\" FROM analytics.trans WHERE itenantid = :tenantid and vcpayeraddr = :vpaAddress and vcclassname = :txnClass AND ilivemessageid < (SELECT \\"ILiveMessageID\\" FROM first_query_result) ORDER BY ilivemessageid DESC LIMIT 20 );",
            "Payee": "WITH first_query_result AS ( SELECT result->''score''->>''decisiondetails'' as \\"decisiondetails\\", ilivemessageid as \\"ILiveMessageID\\", vcmsgid as \\"UniqueID\\", vcclassname as \\"Class\\", dttrxntime at time zone ''Asia/Kolkata'' as \\"Time\\", dobservationamount as \\"Amount\\", score as \\"Score\\", cast(result->''score''->>''bpass'' as text) as \\"FRMPass\\", vcpayeraccountexternalid as \\"Payer Account\\", vcpayeraddr as \\"PayerVPA\\", vcpayeeaccountexternalid as \\"Payee Account\\", vcpayeeaddr as \\"PayeeVPA\\", null as \\"FailedRule\\", cast(observations->''observations''->''payerVPA''->>''vpaName'' as text) as \\"PayerName\\", cast(observations->''observations''->''payeeVPA''->>''vpaName'' as text) as \\"PayeeName\\" FROM analytics.trans WHERE vcmsgid = :msgid ) SELECT * FROM first_query_result UNION ALL ( SELECT result->''score''->>''decisiondetails'' as \\"decisiondetails\\", ilivemessageid as \\"ILiveMessageID\\", vcmsgid as \\"UniqueID\\", vcclassname as \\"Class\\", dttrxntime at time zone ''Asia/Kolkata'' as \\"Time\\", dobservationamount as \\"Amount\\", score as \\"Score\\", cast(result->''score''->>''bpass'' as text) as \\"FRMPass\\", vcpayeraccountexternalid as \\"Payer Account\\", vcpayeraddr as \\"PayerVPA\\", vcpayeeaccountexternalid as \\"Payee Account\\", vcpayeeaddr as \\"PayeeVPA\\", null as \\"FailedRule\\", cast(observations->''observations''->''payerVPA''->>''vpaName'' as text) as \\"PayerName\\", cast(observations->''observations''->''payeeVPA''->>''vpaName'' as text) as \\"PayeeName\\" FROM analytics.trans WHERE vcpayeeaddr = :vpaAddress and vcclassname = :txnClass AND ilivemessageid > (SELECT \\"ILiveMessageID\\" FROM first_query_result) ORDER BY ilivemessageid ASC LIMIT 20 ) UNION ALL ( SELECT result->''score''->>''decisiondetails'' as \\"decisiondetails\\", ilivemessageid as \\"ILiveMessageID\\", vcmsgid as \\"UniqueID\\", vcclassname as \\"Class\\", dttrxntime at time zone ''Asia/Kolkata'' as \\"Time\\", dobservationamount as \\"Amount\\", score as \\"Score\\", cast(result->''score''->>''bpass'' as text) as \\"FRMPass\\", vcpayeraccountexternalid as \\"Payer Account\\", vcpayeraddr as \\"PayerVPA\\", vcpayeeaccountexternalid as \\"Payee Account\\", vcpayeeaddr as \\"PayeeVPA\\", null as \\"FailedRule\\", cast(observations->''observations''->''payerVPA''->>''vpaName'' as text) as \\"PayerName\\", cast(observations->''observations''->''payeeVPA''->>''vpaName'' as text) as \\"PayeeName\\" FROM analytics.trans WHERE itenantid = :tenantid and vcpayeeaddr = :vpaAddress and vcclassname = :txnClass AND ilivemessageid < (SELECT \\"ILiveMessageID\\" FROM first_query_result) ORDER BY ilivemessageid DESC LIMIT 20 );",
            "Both": "WITH first_query_result AS ( SELECT result->''score''->>''decisiondetails'' as \\"decisiondetails\\", ilivemessageid as \\"ILiveMessageID\\", vcmsgid as \\"UniqueID\\", vcclassname as \\"Class\\", dttrxntime at time zone ''Asia/Kolkata'' as \\"Time\\", dobservationamount as \\"Amount\\", score as \\"Score\\", cast(result->''score''->>''bpass'' as text) as \\"FRMPass\\", vcpayeraccountexternalid as \\"Payer Account\\", vcpayeraddr as \\"PayerVPA\\", vcpayeeaccountexternalid as \\"Payee Account\\", vcpayeeaddr as \\"PayeeVPA\\", null as \\"FailedRule\\", cast(observations->''observations''->''payerVPA''->>''vpaName'' as text) as \\"PayerName\\", cast(observations->''observations''->''payeeVPA''->>''vpaName'' as text) as \\"PayeeName\\" FROM analytics.trans WHERE vcmsgid = :msgid ) SELECT * FROM first_query_result UNION ALL ( SELECT result->''score''->>''decisiondetails'' as \\"decisiondetails\\", ilivemessageid as \\"ILiveMessageID\\", vcmsgid as \\"UniqueID\\", vcclassname as \\"Class\\", dttrxntime at time zone ''Asia/Kolkata'' as \\"Time\\", dobservationamount as \\"Amount\\", score as \\"Score\\", cast(result->''score''->>''bpass'' as text) as \\"FRMPass\\", vcpayeraccountexternalid as \\"Payer Account\\", vcpayeraddr as \\"PayerVPA\\", vcpayeeaccountexternalid as \\"Payee Account\\", vcpayeeaddr as \\"PayeeVPA\\", null as \\"FailedRule\\", cast(observations->''observations''->''payerVPA''->>''vpaName'' as text) as \\"PayerName\\", cast(observations->''observations''->''payeeVPA''->>''vpaName'' as text) as \\"PayeeName\\" FROM analytics.trans WHERE (vcpayeraddr = :vpaAddress or vcpayeeaddr = :vpaAddress) and vcclassname = :txnClass AND ilivemessageid > (SELECT \\"ILiveMessageID\\" FROM first_query_result) ORDER BY ilivemessageid ASC LIMIT 20 ) UNION ALL ( SELECT result->''score''->>''decisiondetails'' as \\"decisiondetails\\", ilivemessageid as \\"ILiveMessageID\\", vcmsgid as \\"UniqueID\\", vcclassname as \\"Class\\", dttrxntime at time zone ''Asia/Kolkata'' as \\"Time\\", dobservationamount as \\"Amount\\", score as \\"Score\\", cast(result->''score''->>''bpass'' as text) as \\"FRMPass\\", vcpayeraccountexternalid as \\"Payer Account\\", vcpayeraddr as \\"PayerVPA\\", vcpayeeaccountexternalid as \\"Payee Account\\", vcpayeeaddr as \\"PayeeVPA\\", null as \\"FailedRule\\", cast(observations->''observations''->''payerVPA''->>''vpaName'' as text) as \\"PayerName\\", cast(observations->''observations''->''payeeVPA''->>''vpaName'' as text) as \\"PayeeName\\" FROM analytics.trans WHERE itenantid = :tenantid and (vcpayeraddr = :vpaAddress or vcpayeeaddr = :vpaAddress) and vcclassname = :txnClass AND ilivemessageid < (SELECT \\"ILiveMessageID\\" FROM first_query_result) ORDER BY ilivemessageid DESC LIMIT 20 );"
        }
    }
    }
}'::text WHERE
idashboardqueryid = 77;



