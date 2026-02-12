UPDATE ui.dashboard SET   vcdashboardname='Account Wise Rules Triggered Old'	WHERE idashboardid=10;

INSERT INTO ui.dashboard (idashboardid, bactive, bdelete, vcdashboardname) VALUES (13, true, false, 'Account Wise Rules Triggered');


INSERT INTO ui.dashboardquery (idashboardqueryid, bparametersrequired, vcfilterparametersjson, vcdashboardquery, formattingrequiered, runonanalytics)
VALUES (33, true, '{"class" : null, "decision" : null, "rule" : null, "DateRange" : null, "score" : null }','{
    "All":
    {
        "All" : {
            "All" : "SELECT RT.DTTRXNTIME AS \"Txn Date Time\", RT.VCUNIQUETRANSID AS \"Txn ID\", RT.vcpayercustomerexternalid AS \"Payer Customer ID\", RT.vcpayeraccountexternalid AS \"Payer Account ID\", RT.vcpayeraddr AS \"Payer VPA ID\", RT.vcpayeecustomerexternalid AS \"Payee Customer ID\", RT.vcpayeeaccountexternalid AS \"Payee Account ID\", RT.vcpayeeaddr AS \"Payee VPA ID\", RT.VCCLASSNAME AS \"Txn Class\", RT.DOBSERVATIONAMOUNT AS \"Txn Amount\", RT.VCDECISIONNAME AS \"Decision Name\", RT.IRULEID AS \"Rule ID\", R.VCRULENAME AS \"Rule Name\", RT.RULE_SCORE AS \"Score\" FROM TRANSACTIONS.RULE_TRIGGERED AS RT JOIN MASTERS.RULES AS R ON R.IRULEID = RT.IRULEID JOIN MASTERS.DECISIONS AS D ON D.IDECISIONID = RT.IDECISIONID WHERE RT.RULE_SCORE >= :score AND cast(RT.DTTRXNTIME as date) BETWEEN :StartDate AND :EndDate",
            "Other": "SELECT RT.DTTRXNTIME AS \"Txn Date Time\", RT.VCUNIQUETRANSID AS \"Txn ID\", RT.vcpayercustomerexternalid AS \"Payer Customer ID\", RT.vcpayeraccountexternalid AS \"Payer Account ID\", RT.vcpayeraddr AS \"Payer VPA ID\", RT.vcpayeecustomerexternalid AS \"Payee Customer ID\", RT.vcpayeeaccountexternalid AS \"Payee Account ID\", RT.vcpayeeaddr AS \"Payee VPA ID\", RT.VCCLASSNAME AS \"Txn Class\", RT.DOBSERVATIONAMOUNT AS \"Txn Amount\", RT.VCDECISIONNAME AS \"Decision Name\", RT.IRULEID AS \"Rule ID\", R.VCRULENAME AS \"Rule Name\", RT.RULE_SCORE AS \"Score\" FROM TRANSACTIONS.RULE_TRIGGERED AS RT JOIN MASTERS.RULES AS R ON R.IRULEID = RT.IRULEID JOIN MASTERS.DECISIONS AS D ON D.IDECISIONID = RT.IDECISIONID WHERE RT.RULE_SCORE >= :score AND cast(RT.DTTRXNTIME as date) BETWEEN :StartDate AND :EndDate and RT.vcrulename = :rule"
        },
        "Other": {
            "All" : "SELECT RT.DTTRXNTIME AS \"Txn Date Time\", RT.VCUNIQUETRANSID AS \"Txn ID\", RT.vcpayercustomerexternalid AS \"Payer Customer ID\", RT.vcpayeraccountexternalid AS \"Payer Account ID\", RT.vcpayeraddr AS \"Payer VPA ID\", RT.vcpayeecustomerexternalid AS \"Payee Customer ID\", RT.vcpayeeaccountexternalid AS \"Payee Account ID\", RT.vcpayeeaddr AS \"Payee VPA ID\", RT.VCCLASSNAME AS \"Txn Class\", RT.DOBSERVATIONAMOUNT AS \"Txn Amount\", RT.VCDECISIONNAME AS \"Decision Name\", RT.IRULEID AS \"Rule ID\", R.VCRULENAME AS \"Rule Name\", RT.RULE_SCORE AS \"Score\" FROM TRANSACTIONS.RULE_TRIGGERED AS RT JOIN MASTERS.RULES AS R ON R.IRULEID = RT.IRULEID JOIN MASTERS.DECISIONS AS D ON D.IDECISIONID = RT.IDECISIONID WHERE RT.RULE_SCORE >= :score AND cast(RT.DTTRXNTIME as date) BETWEEN :StartDate AND :EndDate  and RT.VCDECISIONNAME = :decision ",
            "Other": "SELECT RT.DTTRXNTIME AS \"Txn Date Time\", RT.VCUNIQUETRANSID AS \"Txn ID\", RT.vcpayercustomerexternalid AS \"Payer Customer ID\", RT.vcpayeraccountexternalid AS \"Payer Account ID\", RT.vcpayeraddr AS \"Payer VPA ID\", RT.vcpayeecustomerexternalid AS \"Payee Customer ID\", RT.vcpayeeaccountexternalid AS \"Payee Account ID\", RT.vcpayeeaddr AS \"Payee VPA ID\", RT.VCCLASSNAME AS \"Txn Class\", RT.DOBSERVATIONAMOUNT AS \"Txn Amount\", RT.VCDECISIONNAME AS \"Decision Name\", RT.IRULEID AS \"Rule ID\", R.VCRULENAME AS \"Rule Name\", RT.RULE_SCORE AS \"Score\" FROM TRANSACTIONS.RULE_TRIGGERED AS RT JOIN MASTERS.RULES AS R ON R.IRULEID = RT.IRULEID JOIN MASTERS.DECISIONS AS D ON D.IDECISIONID = RT.IDECISIONID WHERE RT.RULE_SCORE >= :score AND cast(RT.DTTRXNTIME as date) BETWEEN :StartDate AND :EndDate and RT.VCDECISIONNAME = :decision and RT.vcrulename = :rule"
        }
    },
    "Other":
    {
        "All" : {
            "All" : "SELECT RT.DTTRXNTIME AS \"Txn Date Time\", RT.VCUNIQUETRANSID AS \"Txn ID\", RT.vcpayercustomerexternalid AS \"Payer Customer ID\", RT.vcpayeraccountexternalid AS \"Payer Account ID\", RT.vcpayeraddr AS \"Payer VPA ID\", RT.vcpayeecustomerexternalid AS \"Payee Customer ID\", RT.vcpayeeaccountexternalid AS \"Payee Account ID\", RT.vcpayeeaddr AS \"Payee VPA ID\", RT.VCCLASSNAME AS \"Txn Class\", RT.DOBSERVATIONAMOUNT AS \"Txn Amount\", RT.VCDECISIONNAME AS \"Decision Name\", RT.IRULEID AS \"Rule ID\", R.VCRULENAME AS \"Rule Name\", RT.RULE_SCORE AS \"Score\" FROM TRANSACTIONS.RULE_TRIGGERED AS RT JOIN MASTERS.RULES AS R ON R.IRULEID = RT.IRULEID JOIN MASTERS.DECISIONS AS D ON D.IDECISIONID = RT.IDECISIONID WHERE RT.RULE_SCORE >= :score AND cast(RT.DTTRXNTIME as date) BETWEEN :StartDate AND :EndDate and RT.VCCLASSNAME = :class ",
            "Other": "SELECT RT.DTTRXNTIME AS \"Txn Date Time\", RT.VCUNIQUETRANSID AS \"Txn ID\", RT.vcpayercustomerexternalid AS \"Payer Customer ID\", RT.vcpayeraccountexternalid AS \"Payer Account ID\", RT.vcpayeraddr AS \"Payer VPA ID\", RT.vcpayeecustomerexternalid AS \"Payee Customer ID\", RT.vcpayeeaccountexternalid AS \"Payee Account ID\", RT.vcpayeeaddr AS \"Payee VPA ID\", RT.VCCLASSNAME AS \"Txn Class\", RT.DOBSERVATIONAMOUNT AS \"Txn Amount\", RT.VCDECISIONNAME AS \"Decision Name\", RT.IRULEID AS \"Rule ID\", R.VCRULENAME AS \"Rule Name\", RT.RULE_SCORE AS \"Score\" FROM TRANSACTIONS.RULE_TRIGGERED AS RT JOIN MASTERS.RULES AS R ON R.IRULEID = RT.IRULEID JOIN MASTERS.DECISIONS AS D ON D.IDECISIONID = RT.IDECISIONID WHERE RT.RULE_SCORE >= :score AND cast(RT.DTTRXNTIME as date) BETWEEN :StartDate AND :EndDate and RT.vcrulename = :rule and RT.VCCLASSNAME = :class"
        },
        "Other": {
            "All" : "SELECT RT.DTTRXNTIME AS \"Txn Date Time\", RT.VCUNIQUETRANSID AS \"Txn ID\", RT.vcpayercustomerexternalid AS \"Payer Customer ID\", RT.vcpayeraccountexternalid AS \"Payer Account ID\", RT.vcpayeraddr AS \"Payer VPA ID\", RT.vcpayeecustomerexternalid AS \"Payee Customer ID\", RT.vcpayeeaccountexternalid AS \"Payee Account ID\", RT.vcpayeeaddr AS \"Payee VPA ID\", RT.VCCLASSNAME AS \"Txn Class\", RT.DOBSERVATIONAMOUNT AS \"Txn Amount\", RT.VCDECISIONNAME AS \"Decision Name\", RT.IRULEID AS \"Rule ID\", R.VCRULENAME AS \"Rule Name\", RT.RULE_SCORE AS \"Score\" FROM TRANSACTIONS.RULE_TRIGGERED AS RT JOIN MASTERS.RULES AS R ON R.IRULEID = RT.IRULEID JOIN MASTERS.DECISIONS AS D ON D.IDECISIONID = RT.IDECISIONID WHERE RT.RULE_SCORE >= :score AND cast(RT.DTTRXNTIME as date) BETWEEN :StartDate AND :EndDate  and RT.VCDECISIONNAME = :decision and RT.VCCLASSNAME = :class",
            "Other": "SELECT RT.DTTRXNTIME AS \"Txn Date Time\", RT.VCUNIQUETRANSID AS \"Txn ID\", RT.vcpayercustomerexternalid AS \"Payer Customer ID\", RT.vcpayeraccountexternalid AS \"Payer Account ID\", RT.vcpayeraddr AS \"Payer VPA ID\", RT.vcpayeecustomerexternalid AS \"Payee Customer ID\", RT.vcpayeeaccountexternalid AS \"Payee Account ID\", RT.vcpayeeaddr AS \"Payee VPA ID\", RT.VCCLASSNAME AS \"Txn Class\", RT.DOBSERVATIONAMOUNT AS \"Txn Amount\", RT.VCDECISIONNAME AS \"Decision Name\", RT.IRULEID AS \"Rule ID\", R.VCRULENAME AS \"Rule Name\", RT.RULE_SCORE AS \"Score\" FROM TRANSACTIONS.RULE_TRIGGERED AS RT JOIN MASTERS.RULES AS R ON R.IRULEID = RT.IRULEID JOIN MASTERS.DECISIONS AS D ON D.IDECISIONID = RT.IDECISIONID WHERE RT.RULE_SCORE >= :score AND cast(RT.DTTRXNTIME as date) BETWEEN :StartDate AND :EndDate and RT.VCDECISIONNAME = :decision and RT.vcrulename = :rule and RT.VCCLASSNAME = :class"
        }
    }
}', false, true);

INSERT INTO ui.dashboardquery (idashboardqueryid, bparametersrequired, vcfilterparametersjson, vcdashboardquery, formattingrequiered, runonanalytics)
VALUES (34, false, null,'select vcclassname as "lebal", vcclassname as "value" FROM masters.transactionclasses where bactive=true UNION SELECT  ''All'' AS "lebal", ''All'' AS "value"', false, true);


INSERT INTO ui.dashboardquery (idashboardqueryid, bparametersrequired, vcfilterparametersjson, vcdashboardquery, formattingrequiered, runonanalytics)
VALUES (35, false, null,'select vcdecisionname as "lebal", vcdecisionname as "value" FROM masters.decisions where bactive=true UNION SELECT  ''All'' AS "lebal", ''All'' AS "value"', false, true);


INSERT INTO ui.dashboardquery (idashboardqueryid, bparametersrequired, vcfilterparametersjson, vcdashboardquery, formattingrequiered, runonanalytics)
VALUES (36, false, null,'select vcrulename as "lebal", vcrulename as "value" FROM masters.rules where bactive=true UNION SELECT  ''All'' AS "lebal", ''All'' AS "value"', false, true);

INSERT INTO ui.dashboardquery (idashboardqueryid, bparametersrequired, vcfilterparametersjson, vcdashboardquery, formattingrequiered, runonanalytics)
VALUES (37, false, null,'select 0 as "score"', false, true);


INSERT INTO ui.dashboardfilters (idashboardfilterid, ifilterorder, vcdashboardfiltername, idashboardid, vcdashboardfiltertype,
idashboardqueryidfordefaultvalue, idashboardqueryidforoptions, vcdashboardfilterdisplayname) VALUES (25, 0, 'DateRange', 13, 'DateRangePicker', 16, null, 'Date Range');

INSERT INTO ui.dashboardfilters (idashboardfilterid, ifilterorder, vcdashboardfiltername, idashboardid, vcdashboardfiltertype,
idashboardqueryidfordefaultvalue, idashboardqueryidforoptions, vcdashboardfilterdisplayname) VALUES (26, 1, 'score', 13, 'Input', 37, null, 'Score');

INSERT INTO ui.dashboardfilters (idashboardfilterid, ifilterorder, vcdashboardfiltername, idashboardid, vcdashboardfiltertype,
idashboardqueryidfordefaultvalue, idashboardqueryidforoptions, vcdashboardfilterdisplayname) VALUES (27, 2, 'class', 13, 'Select', null, 34, 'Class');

INSERT INTO ui.dashboardfilters (idashboardfilterid, ifilterorder, vcdashboardfiltername, idashboardid, vcdashboardfiltertype,
idashboardqueryidfordefaultvalue, idashboardqueryidforoptions, vcdashboardfilterdisplayname) VALUES (28, 3, 'decision', 13, 'Select', null, 35, 'Decision');

INSERT INTO ui.dashboardfilters (idashboardfilterid, ifilterorder, vcdashboardfiltername, idashboardid, vcdashboardfiltertype,
idashboardqueryidfordefaultvalue, idashboardqueryidforoptions, vcdashboardfilterdisplayname) VALUES (29, 3, 'rule', 13, 'Select', null, 36, 'Rule');

INSERT INTO ui.dashboardqueryparameters (idashboardparameterid, vcparametername, vcparametertype, idashboardqueryid, iorder) VALUES (31, 'class', 'JsonPath', 33, 0);

INSERT INTO ui.dashboardqueryparameters (idashboardparameterid, vcparametername, vcparametertype, idashboardqueryid, iorder) VALUES (32, 'decision', 'JsonPath', 33, 1);

INSERT INTO ui.dashboardqueryparameters (idashboardparameterid, vcparametername, vcparametertype, idashboardqueryid, iorder) VALUES (33, 'rule', 'JsonPath', 33, 2);

INSERT INTO ui.dashboardqueryparameters (idashboardparameterid, vcparametername, vcparametertype, idashboardqueryid, iorder) VALUES (34, 'DateRange', 'DateRange', 33, null);

INSERT INTO ui.dashboardqueryparameters (idashboardparameterid, vcparametername, vcparametertype, idashboardqueryid, iorder) VALUES (35, 'score', 'Integer', 33, null);

INSERT INTO ui.dashboardresultset (idashboardresultsetid, iresultsetorder, vcdashboardresultsetcolumnjson, vcdashboardresultsetlayout, vcdashboardresultsetname, idashboardqueryid, idashboardid, vcdashboardresultsetschema)
VALUES (13, NULL, NULL, '{
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
            "Txn Date Time",
            "Txn ID",
            "Payer Customer ID",
            "Payer Account ID",
            "Payer VPA ID",
            "Payee Customer ID",
            "Payee Account ID",
            "Payee VPA ID",
			"Txn Class",
		    "Txn Amount",
		    "Decision Name",
			"Rule ID",
			"Rule Name",
			"Score"
         ],
         "master":true,
         "name":"Rule Efficiency Report",
         "table":"ruleefficiencyreport",
         "linked":false
      }
   }
}', 'ruleefficiencyreport', 33, 13, '{
  			"Txn Date Time" : "datetime",
            "Txn ID" : "string" ,
            "Payer Customer ID" : "string",
            "Payer Account ID" : "string",
            "Payer VPA ID" : "string",
            "Payee Customer ID" : "string",
            "Payee Account ID" : "string",
            "Payee VPA ID" : "string",
			"Txn Class" : "string",
		    "Txn Amount" : "integer",
		    "Decision Name" : "string",
			"Rule ID" : "integer",
			"Rule Name" : "string" ,
			"Score" : "integer"
}');
