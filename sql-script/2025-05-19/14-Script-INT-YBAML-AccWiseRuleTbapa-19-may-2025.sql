-----bapa
-- Account wise rules triggered
INSERT INTO ui.dashboard VALUES (76, true, false, 'Account Wise Rules Triggered - DL', 7, 1, 510,8, true);


INSERT INTO ui.dashboardfilters VALUES ((SELECT max(idashboardfilterid)+1 FROM ui.dashboardfilters), 1, 'score', 76, 'Input', 37, NULL,8, 'Score ( >= )');
INSERT INTO ui.dashboardfilters VALUES ((SELECT max(idashboardfilterid)+1 FROM ui.dashboardfilters), 3, 'rule', 76, 'Select', NULL, 36,8, 'Rule');
INSERT INTO ui.dashboardfilters VALUES ((SELECT max(idashboardfilterid)+1 FROM ui.dashboardfilters), 3, 'decision', 76, 'Select', NULL, 35,8, 'Decision');
INSERT INTO ui.dashboardfilters VALUES ((SELECT max(idashboardfilterid)+1 FROM ui.dashboardfilters), 2, 'class', 76, 'Select', NULL, 34,8, 'Class');
INSERT INTO ui.dashboardfilters VALUES ((SELECT max(idashboardfilterid)+1 FROM ui.dashboardfilters), 0, 'DateRange', 76, 'DateRangePicker', 16, NULL,8, 'Date Range');


INSERT INTO ui.dashboardquery VALUES (162, true, '{"class" : null, "decision" : null, "rule" : null, "DateRange" : null, "score" : null} ', '{
    "All":
    {
        "All" : { 
            "All" : "SELECT \"Txn Date Time\", \"Txn ID\", \"Unique ID\", \"Payer Customer ID\", \"Payer Account ID\", \"Payer VPA ID\",\"Customer ID\", \"Account ID\", \"VPA ID\", \"Payee Customer ID\", \"Payee Account ID\", \"Payee VPA ID\", \"Txn Class\", \"Txn Amount\", \"Decision Name\", \"Rule ID\", \"Rule Name\", \"Score\", \"Side\" FROM t8refined.analytics.combined_rule_triggered WHERE \"Tenant ID\" = :tenantid AND \"Txn Class\" IN ( :allClasses ) AND \"Score\" >= :score AND \"Txn Date Time\" BETWEEN :StartDate AND :EndDate limit 50000",
            "Other": "SELECT \"Txn Date Time\", \"Txn ID\", \"Unique ID\", \"Payer Customer ID\", \"Payer Account ID\", \"Payer VPA ID\",\"Customer ID\", \"Account ID\", \"VPA ID\", \"Payee Customer ID\", \"Payee Account ID\", \"Payee VPA ID\", \"Txn Class\", \"Txn Amount\", \"Decision Name\", \"Rule ID\", \"Rule Name\", \"Score\", \"Side\" FROM t8refined.analytics.combined_rule_triggered WHERE \"Tenant ID\" = :tenantid AND \"Txn Class\" IN ( :allClasses )  AND \"Score\" >= :score AND \"Txn Date Time\" BETWEEN :StartDate AND :EndDate and \"Rule Name\" = :rule limit 50000"
        },
        "Other": {
            "All" : "SELECT \"Txn Date Time\", \"Txn ID\", \"Unique ID\", \"Payer Customer ID\", \"Payer Account ID\", \"Payer VPA ID\",\"Customer ID\", \"Account ID\", \"VPA ID\", \"Payee Customer ID\", \"Payee Account ID\", \"Payee VPA ID\", \"Txn Class\", \"Txn Amount\", \"Decision Name\", \"Rule ID\", \"Rule Name\", \"Score\", \"Side\" FROM t8refined.analytics.combined_rule_triggered WHERE \"Tenant ID\" = :tenantid AND \"Txn Class\" IN ( :allClasses ) AND \"Score\" >= :score AND \"Txn Date Time\" BETWEEN :StartDate AND :EndDate  and \"Decision Name\" = :decision limit 50000",
            "Other": "SELECT \"Txn Date Time\", \"Txn ID\", \"Unique ID\", \"Payer Customer ID\", \"Payer Account ID\", \"Payer VPA ID\",\"Customer ID\", \"Account ID\", \"VPA ID\", \"Payee Customer ID\", \"Payee Account ID\", \"Payee VPA ID\", \"Txn Class\", \"Txn Amount\", \"Decision Name\", \"Rule ID\", \"Rule Name\", \"Score\", \"Side\" FROM t8refined.analytics.combined_rule_triggered WHERE \"Tenant ID\" = :tenantid AND \"Txn Class\" IN ( :allClasses )  AND \"Score\" >= :score AND \"Txn Date Time\" BETWEEN :StartDate AND :EndDate and \"Decision Name\" = :decision and \"Rule Name\" = :rule limit 50000"
        }
    },
    "Other":
    {
        "All" : {
            "All" : "SELECT \"Txn Date Time\", \"Txn ID\", \"Unique ID\", \"Payer Customer ID\", \"Payer Account ID\", \"Payer VPA ID\",\"Customer ID\", \"Account ID\", \"VPA ID\", \"Payee Customer ID\", \"Payee Account ID\", \"Payee VPA ID\", \"Txn Class\", \"Txn Amount\", \"Decision Name\", \"Rule ID\", \"Rule Name\", \"Score\", \"Side\" FROM t8refined.analytics.combined_rule_triggered WHERE \"Tenant ID\" = :tenantid AND \"Score\" >= :score AND \"Txn Date Time\" BETWEEN :StartDate AND :EndDate and \"Txn Class\" = :class limit 50000",
            "Other": "SELECT \"Txn Date Time\", \"Txn ID\", \"Unique ID\", \"Payer Customer ID\", \"Payer Account ID\", \"Payer VPA ID\",\"Customer ID\", \"Account ID\", \"VPA ID\", \"Payee Customer ID\", \"Payee Account ID\", \"Payee VPA ID\", \"Txn Class\", \"Txn Amount\", \"Decision Name\", \"Rule ID\", \"Rule Name\", \"Score\", \"Side\" FROM t8refined.analytics.combined_rule_triggered WHERE \"Tenant ID\" = :tenantid AND \"Score\" >= :score AND \"Txn Date Time\" BETWEEN :StartDate AND :EndDate and \"Rule Name\" = :rule and \"Txn Class\" = :class limit 50000"
        },
        "Other": {
            "All" : "SELECT \"Txn Date Time\", \"Txn ID\", \"Unique ID\", \"Payer Customer ID\", \"Payer Account ID\", \"Payer VPA ID\",\"Customer ID\", \"Account ID\", \"VPA ID\", \"Payee Customer ID\", \"Payee Account ID\", \"Payee VPA ID\", \"Txn Class\", \"Txn Amount\", \"Decision Name\", \"Rule ID\", \"Rule Name\", \"Score\", \"Side\" FROM t8refined.analytics.combined_rule_triggered WHERE \"Score\" >= :score AND \"Txn Date Time\" BETWEEN :StartDate AND :EndDate  and \"Decision Name\" = :decision and \"Txn Class\" = :class limit 50000",
            "Other": "SELECT \"Txn Date Time\", \"Txn ID\", \"Unique ID\", \"Payer Customer ID\", \"Payer Account ID\", \"Payer VPA ID\",\"Customer ID\", \"Account ID\", \"VPA ID\", \"Payee Customer ID\", \"Payee Account ID\", \"Payee VPA ID\", \"Txn Class\", \"Txn Amount\", \"Decision Name\", \"Rule ID\", \"Rule Name\", \"Score\", \"Side\" FROM t8refined.analytics.combined_rule_triggered WHERE \"Tenant ID\" = :tenantid AND \"Score\" >= :score AND \"Txn Date Time\" BETWEEN :StartDate AND :EndDate and \"Decision Name\" = :decision and \"Rule Name\" = :rule and \"Txn Class\" = :class limit 50000"
        }
    }
} 
', false, true, NULL, 510,8, 3);

---------------------------
INSERT INTO ui.dashboardqueryparameters VALUES ((SELECT max(idashboardparameterid)+1 FROM ui.dashboardqueryparameters), 'score', 'Integer', 162, NULL,8);
INSERT INTO ui.dashboardqueryparameters VALUES ((SELECT max(idashboardparameterid)+1 FROM ui.dashboardqueryparameters), 'DateRange', 'DateRange', 162, NULL,8);
INSERT INTO ui.dashboardqueryparameters VALUES ((SELECT max(idashboardparameterid)+1 FROM ui.dashboardqueryparameters), 'rule', 'JsonPath', 162, 2,8);
INSERT INTO ui.dashboardqueryparameters VALUES ((SELECT max(idashboardparameterid)+1 FROM ui.dashboardqueryparameters), 'decision', 'JsonPath', 162, 1,8);
INSERT INTO ui.dashboardqueryparameters VALUES ((SELECT max(idashboardparameterid)+1 FROM ui.dashboardqueryparameters), 'class', 'JsonPath', 162, 0,8);

INSERT INTO ui.dashboardresultset VALUES ((SELECT max(idashboardresultsetid)+1 FROM ui.dashboardresultset), NULL, NULL, '{"sizes":[1],"detail":{"main":{"type":"tab-area","widgets":["PERSPECTIVE_GENERATED_ID_1"],"currentIndex":0}},"mode":"globalFilters","viewers":{"PERSPECTIVE_GENERATED_ID_1":{"plugin":"Datagrid","plugin_config":{"columns":{},"editable":false,"scroll_lock":true},"settings":false,"theme":"Pro Dark","title":"Account Wise Rule Triggered","group_by":[],"split_by":[],"columns":["Txn Date","Txn Class","Decision Name","Rule ID","Rule Name","Score","Txn Amount","Payee Account ID","Payee Customer ID","Payee VPA ID","Payer Account ID","Payer Customer ID","Payer VPA ID","Txn ID"],"filter":[],"sort":[],"expressions":["// Txn Date\ndate(integer(substring(string(\"Txn Date Time\"), 0, 4)), integer(substring(string(\"Txn Date Time\"), 5, 2)), integer(substring(string(\"Txn Date Time\"), 8, 2)))"],"aggregates":{},"master":false,"table":"ruleefficiencyreport","linked":false}}} ', 'ruleefficiencyreport', 162, 76, '{
   "Txn Date Time" : "datetime",
   "Txn ID" : "string" ,
   "Unique ID" : "string" ,
   "Payer Customer ID" : "string",
   "Payer Account ID" : "string",
   "Payer VPA ID" : "string",
   "Customer ID" : "string",
   "Account ID" : "string",
   "VPA ID" : "string",
   "Payee Customer ID" : "string",
   "Payee Account ID" : "string",
   "Payee VPA ID" : "string",
   "Txn Class" : "string",
   "Txn Amount" : "float",
   "Decision Name" : "string",
   "Rule ID" : "integer",
   "Rule Name" : "string" ,
   "Score" : "integer",
   "Side": "string"
   }', NULL, 1, NULL, NULL, 510,8, 5);

--------------------------
UPDATE ui.dashboardquery SET
vcdashboardquery =  E'{
    "All":
    {
        "All" : { 
            "All" : "SELECT \\"Txn Date Time\\", \\"Txn ID\\", \\"Unique ID\\", \\"Payer Customer ID\\", \\"Payer Account ID\\", \\"Payer VPA ID\\",\\"Customer ID\\", \\"Account ID\\", \\"VPA ID\\", \\"Payee Customer ID\\", \\"Payee Account ID\\", \\"Payee VPA ID\\", \\"Txn Class\\", \\"Txn Amount\\", \\"Decision Name\\", \\"Rule ID\\", \\"Rule Name\\", \\"Score\\", \\"Side\\" FROM t8refined.analytics.combined_rule_triggered WHERE \\"Tenant ID\\" = :tenantid AND \\"Txn Class\\" IN ( :allClasses ) AND \\"Score\\" >= :score AND \\"Txn Date Time\\" BETWEEN :StartDate AND :EndDate limit 50000",
            "Other": "SELECT \\"Txn Date Time\\", \\"Txn ID\\", \\"Unique ID\\", \\"Payer Customer ID\\", \\"Payer Account ID\\", \\"Payer VPA ID\\",\\"Customer ID\\", \\"Account ID\\", \\"VPA ID\\", \\"Payee Customer ID\\", \\"Payee Account ID\\", \\"Payee VPA ID\\", \\"Txn Class\\", \\"Txn Amount\\", \\"Decision Name\\", \\"Rule ID\\", \\"Rule Name\\", \\"Score\\", \\"Side\\" FROM t8refined.analytics.combined_rule_triggered WHERE \\"Tenant ID\\" = :tenantid AND \\"Txn Class\\" IN ( :allClasses )  AND \\"Score\\" >= :score AND \\"Txn Date Time\\" BETWEEN :StartDate AND :EndDate and \\"Rule Name\\" = :rule limit 50000"
        },
        "Other": {
            "All" : "SELECT \\"Txn Date Time\\", \\"Txn ID\\", \\"Unique ID\\", \\"Payer Customer ID\\", \\"Payer Account ID\\", \\"Payer VPA ID\\",\\"Customer ID\\", \\"Account ID\\", \\"VPA ID\\", \\"Payee Customer ID\\", \\"Payee Account ID\\", \\"Payee VPA ID\\", \\"Txn Class\\", \\"Txn Amount\\", \\"Decision Name\\", \\"Rule ID\\", \\"Rule Name\\", \\"Score\\", \\"Side\\" FROM t8refined.analytics.combined_rule_triggered WHERE \\"Tenant ID\\" = :tenantid AND \\"Txn Class\\" IN ( :allClasses ) AND \\"Score\\" >= :score AND \\"Txn Date Time\\" BETWEEN :StartDate AND :EndDate  and \\"Decision Name\\" = :decision limit 50000",
            "Other": "SELECT \\"Txn Date Time\\", \\"Txn ID\\", \\"Unique ID\\", \\"Payer Customer ID\\", \\"Payer Account ID\\", \\"Payer VPA ID\\",\\"Customer ID\\", \\"Account ID\\", \\"VPA ID\\", \\"Payee Customer ID\\", \\"Payee Account ID\\", \\"Payee VPA ID\\", \\"Txn Class\\", \\"Txn Amount\\", \\"Decision Name\\", \\"Rule ID\\", \\"Rule Name\\", \\"Score\\", \\"Side\\" FROM t8refined.analytics.combined_rule_triggered WHERE \\"Tenant ID\\" = :tenantid AND \\"Txn Class\\" IN ( :allClasses )  AND \\"Score\\" >= :score AND \\"Txn Date Time\\" BETWEEN :StartDate AND :EndDate and \\"Decision Name\\" = :decision and \\"Rule Name\\" = :rule limit 50000"
        }
    },
    "Other":
    {
        "All" : {
            "All" : "SELECT \\"Txn Date Time\\", \\"Txn ID\\", \\"Unique ID\\", \\"Payer Customer ID\\", \\"Payer Account ID\\", \\"Payer VPA ID\\",\\"Customer ID\\", \\"Account ID\\", \\"VPA ID\\", \\"Payee Customer ID\\", \\"Payee Account ID\\", \\"Payee VPA ID\\", \\"Txn Class\\", \\"Txn Amount\\", \\"Decision Name\\", \\"Rule ID\\", \\"Rule Name\\", \\"Score\\", \\"Side\\" FROM t8refined.analytics.combined_rule_triggered WHERE \\"Tenant ID\\" = :tenantid AND \\"Score\\" >= :score AND \\"Txn Date Time\\" BETWEEN :StartDate AND :EndDate and \\"Txn Class\\" = :class limit 50000",
            "Other": "SELECT \\"Txn Date Time\\", \\"Txn ID\\", \\"Unique ID\\", \\"Payer Customer ID\\", \\"Payer Account ID\\", \\"Payer VPA ID\\",\\"Customer ID\\", \\"Account ID\\", \\"VPA ID\\", \\"Payee Customer ID\\", \\"Payee Account ID\\", \\"Payee VPA ID\\", \\"Txn Class\\", \\"Txn Amount\\", \\"Decision Name\\", \\"Rule ID\\", \\"Rule Name\\", \\"Score\\", \\"Side\\" FROM t8refined.analytics.combined_rule_triggered WHERE \\"Tenant ID\\" = :tenantid AND \\"Score\\" >= :score AND \\"Txn Date Time\\" BETWEEN :StartDate AND :EndDate and \\"Rule Name\\" = :rule and \\"Txn Class\\" = :class limit 50000"
        },
        "Other": {
            "All" : "SELECT \\"Txn Date Time\\", \\"Txn ID\\", \\"Unique ID\\", \\"Payer Customer ID\\", \\"Payer Account ID\\", \\"Payer VPA ID\\",\\"Customer ID\\", \\"Account ID\\", \\"VPA ID\\", \\"Payee Customer ID\\", \\"Payee Account ID\\", \\"Payee VPA ID\\", \\"Txn Class\\", \\"Txn Amount\\", \\"Decision Name\\", \\"Rule ID\\", \\"Rule Name\\", \\"Score\\", \\"Side\\" FROM t8refined.analytics.combined_rule_triggered WHERE \\"Tenant ID\\" = :tenantid AND \\"Score\\" >= :score AND \\"Txn Date Time\\" BETWEEN :StartDate AND :EndDate  and \\"Decision Name\\" = :decision and \\"Txn Class\\" = :class limit 50000",
            "Other": "SELECT \\"Txn Date Time\\", \\"Txn ID\\", \\"Unique ID\\", \\"Payer Customer ID\\", \\"Payer Account ID\\", \\"Payer VPA ID\\",\\"Customer ID\\", \\"Account ID\\", \\"VPA ID\\", \\"Payee Customer ID\\", \\"Payee Account ID\\", \\"Payee VPA ID\\", \\"Txn Class\\", \\"Txn Amount\\", \\"Decision Name\\", \\"Rule ID\\", \\"Rule Name\\", \\"Score\\", \\"Side\\" FROM t8refined.analytics.combined_rule_triggered WHERE \\"Tenant ID\\" = :tenantid AND \\"Score\\" >= :score AND \\"Txn Date Time\\" BETWEEN :StartDate AND :EndDate and \\"Decision Name\\" = :decision and \\"Rule Name\\" = :rule and \\"Txn Class\\" = :class limit 50000"
        }
    }
} '::text WHERE
idashboardqueryid = 162 AND itenantid in (8);
