
UPDATE ui.dashboardquery SET
vcdashboardquery = '
{
    "All":
    {
        "All" : {
            "All" : "SELECT \"Txn Date Time\", \"Txn ID\", \"Payer Customer ID\", \"Payer Account ID\", \"Payer VPA ID\", \"Payee Customer ID\", \"Payee Account ID\", \"Payee VPA ID\", \"Txn Class\", \"Txn Amount\", \"Decision Name\", \"Rule ID\", \"Rule Name\", \"Score\" FROM transactions.combined_rule_triggered WHERE ( \"Payer Customer ID\" = :address or \"Payer Account ID\" = :address or \"Payer VPA ID\" = :address or \"Payee Customer ID\" = :address or \"Payee Account ID\" = :address or \"Payee VPA ID\" = :address ) AND cast(\"Txn Date Time\" as date) BETWEEN :StartDate AND :EndDate",
            "Other": "SELECT \"Txn Date Time\", \"Txn ID\", \"Payer Customer ID\", \"Payer Account ID\", \"Payer VPA ID\", \"Payee Customer ID\", \"Payee Account ID\", \"Payee VPA ID\", \"Txn Class\", \"Txn Amount\", \"Decision Name\", \"Rule ID\", \"Rule Name\", \"Score\" FROM transactions.combined_rule_triggered WHERE ( \"Payer Customer ID\" = :address or \"Payer Account ID\" = :address or \"Payer VPA ID\" = :address or \"Payee Customer ID\" = :address or \"Payee Account ID\" = :address or \"Payee VPA ID\" = :address ) AND cast(\"Txn Date Time\" as date) BETWEEN :StartDate AND :EndDate and RT.vcrulename = :rule"
        },
        "Other": {
            "All" : "SELECT \"Txn Date Time\", \"Txn ID\", \"Payer Customer ID\", \"Payer Account ID\", \"Payer VPA ID\", \"Payee Customer ID\", \"Payee Account ID\", \"Payee VPA ID\", \"Txn Class\", \"Txn Amount\", \"Decision Name\", \"Rule ID\", \"Rule Name\", \"Score\" FROM transactions.combined_rule_triggered WHERE ( \"Payer Customer ID\" = :address or \"Payer Account ID\" = :address or \"Payer VPA ID\" = :address or \"Payee Customer ID\" = :address or \"Payee Account ID\" = :address or \"Payee VPA ID\" = :address ) AND cast(\"Txn Date Time\" as date) BETWEEN :StartDate AND :EndDate  and RT.VCDECISIONNAME = :decision ",
            "Other": "SELECT \"Txn Date Time\", \"Txn ID\", \"Payer Customer ID\", \"Payer Account ID\", \"Payer VPA ID\", \"Payee Customer ID\", \"Payee Account ID\", \"Payee VPA ID\", \"Txn Class\", \"Txn Amount\", \"Decision Name\", \"Rule ID\", \"Rule Name\", \"Score\" FROM transactions.combined_rule_triggered WHERE ( \"Payer Customer ID\" = :address or \"Payer Account ID\" = :address or \"Payer VPA ID\" = :address or \"Payee Customer ID\" = :address or \"Payee Account ID\" = :address or \"Payee VPA ID\" = :address ) AND cast(\"Txn Date Time\" as date) BETWEEN :StartDate AND :EndDate and RT.VCDECISIONNAME = :decision and RT.vcrulename = :rule"
        }
    },
    "Other":
    {
        "All" : {
            "All" : "SELECT \"Txn Date Time\", \"Txn ID\", \"Payer Customer ID\", \"Payer Account ID\", \"Payer VPA ID\", \"Payee Customer ID\", \"Payee Account ID\", \"Payee VPA ID\", \"Txn Class\", \"Txn Amount\", \"Decision Name\", \"Rule ID\", \"Rule Name\", \"Score\" FROM transactions.combined_rule_triggered WHERE ( \"Payer Customer ID\" = :address or \"Payer Account ID\" = :address or \"Payer VPA ID\" = :address or \"Payee Customer ID\" = :address or \"Payee Account ID\" = :address or \"Payee VPA ID\" = :address ) AND cast(\"Txn Date Time\" as date) BETWEEN :StartDate AND :EndDate and RT.VCCLASSNAME = :class ",
            "Other": "SELECT \"Txn Date Time\", \"Txn ID\", \"Payer Customer ID\", \"Payer Account ID\", \"Payer VPA ID\", \"Payee Customer ID\", \"Payee Account ID\", \"Payee VPA ID\", \"Txn Class\", \"Txn Amount\", \"Decision Name\", \"Rule ID\", \"Rule Name\", \"Score\" FROM transactions.combined_rule_triggered WHERE ( \"Payer Customer ID\" = :address or \"Payer Account ID\" = :address or \"Payer VPA ID\" = :address or \"Payee Customer ID\" = :address or \"Payee Account ID\" = :address or \"Payee VPA ID\" = :address ) AND cast(\"Txn Date Time\" as date) BETWEEN :StartDate AND :EndDate and RT.vcrulename = :rule and RT.VCCLASSNAME = :class"
        },
        "Other": {
            "All" : "SELECT \"Txn Date Time\", \"Txn ID\", \"Payer Customer ID\", \"Payer Account ID\", \"Payer VPA ID\", \"Payee Customer ID\", \"Payee Account ID\", \"Payee VPA ID\", \"Txn Class\", \"Txn Amount\", \"Decision Name\", \"Rule ID\", \"Rule Name\", \"Score\" FROM transactions.combined_rule_triggered WHERE ( \"Payer Customer ID\" = :address or \"Payer Account ID\" = :address or \"Payer VPA ID\" = :address or \"Payee Customer ID\" = :address or \"Payee Account ID\" = :address or \"Payee VPA ID\" = :address ) AND cast(\"Txn Date Time\" as date) BETWEEN :StartDate AND :EndDate  and RT.VCDECISIONNAME = :decision and RT.VCCLASSNAME = :class",
            "Other": "SELECT \"Txn Date Time\", \"Txn ID\", \"Payer Customer ID\", \"Payer Account ID\", \"Payer VPA ID\", \"Payee Customer ID\", \"Payee Account ID\", \"Payee VPA ID\", \"Txn Class\", \"Txn Amount\", \"Decision Name\", \"Rule ID\", \"Rule Name\", \"Score\" FROM transactions.combined_rule_triggered WHERE ( \"Payer Customer ID\" = :address or \"Payer Account ID\" = :address or \"Payer VPA ID\" = :address or \"Payee Customer ID\" = :address or \"Payee Account ID\" = :address or \"Payee VPA ID\" = :address ) AND cast(\"Txn Date Time\" as date) BETWEEN :StartDate AND :EndDate and RT.VCDECISIONNAME = :decision and RT.vcrulename = :rule and RT.VCCLASSNAME = :class"
        }
    }
}'::text, vcfilterparametersjson = '{"class" : null, "decision" : null, "rule" : null, "DateRange" : null, "address" : null}'::text WHERE
idashboardqueryid = 33;


UPDATE ui.dashboardfilters SET
vcdashboardfiltername = 'address'::character varying, idashboardqueryidfordefaultvalue = NULL::integer, vcdashboardfilterdisplayname = 'Address'::character varying WHERE
idashboardfilterid = 26;


UPDATE ui.dashboardqueryparameters SET
vcparametertype = 'String'::character varying, vcparametername = 'address'::character varying WHERE
idashboardparameterid = 35;





UPDATE ui.dashboardquery SET
vcdashboardquery = '
{
    "All":
    {
        "All" : {
            "All" : "SELECT \"Txn Date Time\", \"Txn ID\", \"Payer Customer ID\", \"Payer Account ID\", \"Payer VPA ID\",\"Customer ID\", \"Account ID\", \"VPA ID\", \"Payee Customer ID\", \"Payee Account ID\", \"Payee VPA ID\", \"Txn Class\", \"Txn Amount\", \"Decision Name\", \"Rule ID\", \"Rule Name\", \"Score\" FROM transactions.combined_rule_triggered WHERE ( \"Payer Customer ID\" = :address or \"Payer Account ID\" = :address or \"Payer VPA ID\" = :address or \"Payee Customer ID\" = :address or \"Payee Account ID\" = :address or \"Payee VPA ID\" = :address or \"Customer ID\" = :address or \"Account ID\" = :address or \"VPA ID\" = :address ) AND cast(\"Txn Date Time\" as date) BETWEEN :StartDate AND :EndDate",
            "Other": "SELECT \"Txn Date Time\", \"Txn ID\", \"Payer Customer ID\", \"Payer Account ID\", \"Payer VPA ID\",\"Customer ID\", \"Account ID\", \"VPA ID\", \"Payee Customer ID\", \"Payee Account ID\", \"Payee VPA ID\", \"Txn Class\", \"Txn Amount\", \"Decision Name\", \"Rule ID\", \"Rule Name\", \"Score\" FROM transactions.combined_rule_triggered WHERE ( \"Payer Customer ID\" = :address or \"Payer Account ID\" = :address or \"Payer VPA ID\" = :address or \"Payee Customer ID\" = :address or \"Payee Account ID\" = :address or \"Payee VPA ID\" = :address or \"Customer ID\" = :address or \"Account ID\" = :address or \"VPA ID\" = :address ) AND cast(\"Txn Date Time\" as date) BETWEEN :StartDate AND :EndDate and \"Rule Name\" = :rule"
        },
        "Other": {
            "All" : "SELECT \"Txn Date Time\", \"Txn ID\", \"Payer Customer ID\", \"Payer Account ID\", \"Payer VPA ID\",\"Customer ID\", \"Account ID\", \"VPA ID\", \"Payee Customer ID\", \"Payee Account ID\", \"Payee VPA ID\", \"Txn Class\", \"Txn Amount\", \"Decision Name\", \"Rule ID\", \"Rule Name\", \"Score\" FROM transactions.combined_rule_triggered WHERE ( \"Payer Customer ID\" = :address or \"Payer Account ID\" = :address or \"Payer VPA ID\" = :address or \"Payee Customer ID\" = :address or \"Payee Account ID\" = :address or \"Payee VPA ID\" = :address or \"Customer ID\" = :address or \"Account ID\" = :address or \"VPA ID\" = :address ) AND cast(\"Txn Date Time\" as date) BETWEEN :StartDate AND :EndDate  and \"Decision Name\" = :decision ",
            "Other": "SELECT \"Txn Date Time\", \"Txn ID\", \"Payer Customer ID\", \"Payer Account ID\", \"Payer VPA ID\",\"Customer ID\", \"Account ID\", \"VPA ID\", \"Payee Customer ID\", \"Payee Account ID\", \"Payee VPA ID\", \"Txn Class\", \"Txn Amount\", \"Decision Name\", \"Rule ID\", \"Rule Name\", \"Score\" FROM transactions.combined_rule_triggered WHERE ( \"Payer Customer ID\" = :address or \"Payer Account ID\" = :address or \"Payer VPA ID\" = :address or \"Payee Customer ID\" = :address or \"Payee Account ID\" = :address or \"Payee VPA ID\" = :address or \"Customer ID\" = :address or \"Account ID\" = :address or \"VPA ID\" = :address ) AND cast(\"Txn Date Time\" as date) BETWEEN :StartDate AND :EndDate and \"Decision Name\" = :decision and \"Rule Name\" = :rule"
        }
    },
    "Other":
    {
        "All" : {
            "All" : "SELECT \"Txn Date Time\", \"Txn ID\", \"Payer Customer ID\", \"Payer Account ID\", \"Payer VPA ID\",\"Customer ID\", \"Account ID\", \"VPA ID\", \"Payee Customer ID\", \"Payee Account ID\", \"Payee VPA ID\", \"Txn Class\", \"Txn Amount\", \"Decision Name\", \"Rule ID\", \"Rule Name\", \"Score\" FROM transactions.combined_rule_triggered WHERE ( \"Payer Customer ID\" = :address or \"Payer Account ID\" = :address or \"Payer VPA ID\" = :address or \"Payee Customer ID\" = :address or \"Payee Account ID\" = :address or \"Payee VPA ID\" = :address or \"Customer ID\" = :address or \"Account ID\" = :address or \"VPA ID\" = :address ) AND cast(\"Txn Date Time\" as date) BETWEEN :StartDate AND :EndDate and \"Txn Class\" = :class ",
            "Other": "SELECT \"Txn Date Time\", \"Txn ID\", \"Payer Customer ID\", \"Payer Account ID\", \"Payer VPA ID\",\"Customer ID\", \"Account ID\", \"VPA ID\", \"Payee Customer ID\", \"Payee Account ID\", \"Payee VPA ID\", \"Txn Class\", \"Txn Amount\", \"Decision Name\", \"Rule ID\", \"Rule Name\", \"Score\" FROM transactions.combined_rule_triggered WHERE ( \"Payer Customer ID\" = :address or \"Payer Account ID\" = :address or \"Payer VPA ID\" = :address or \"Payee Customer ID\" = :address or \"Payee Account ID\" = :address or \"Payee VPA ID\" = :address or \"Customer ID\" = :address or \"Account ID\" = :address or \"VPA ID\" = :address ) AND cast(\"Txn Date Time\" as date) BETWEEN :StartDate AND :EndDate and \"Rule Name\" = :rule and \"Txn Class\" = :class"
        },
        "Other": {
            "All" : "SELECT \"Txn Date Time\", \"Txn ID\", \"Payer Customer ID\", \"Payer Account ID\", \"Payer VPA ID\",\"Customer ID\", \"Account ID\", \"VPA ID\", \"Payee Customer ID\", \"Payee Account ID\", \"Payee VPA ID\", \"Txn Class\", \"Txn Amount\", \"Decision Name\", \"Rule ID\", \"Rule Name\", \"Score\" FROM transactions.combined_rule_triggered WHERE ( \"Payer Customer ID\" = :address or \"Payer Account ID\" = :address or \"Payer VPA ID\" = :address or \"Payee Customer ID\" = :address or \"Payee Account ID\" = :address or \"Payee VPA ID\" = :address or \"Customer ID\" = :address or \"Account ID\" = :address or \"VPA ID\" = :address ) AND cast(\"Txn Date Time\" as date) BETWEEN :StartDate AND :EndDate  and \"Decision Name\" = :decision and \"Txn Class\" = :class",
            "Other": "SELECT \"Txn Date Time\", \"Txn ID\", \"Payer Customer ID\", \"Payer Account ID\", \"Payer VPA ID\",\"Customer ID\", \"Account ID\", \"VPA ID\", \"Payee Customer ID\", \"Payee Account ID\", \"Payee VPA ID\", \"Txn Class\", \"Txn Amount\", \"Decision Name\", \"Rule ID\", \"Rule Name\", \"Score\" FROM transactions.combined_rule_triggered WHERE ( \"Payer Customer ID\" = :address or \"Payer Account ID\" = :address or \"Payer VPA ID\" = :address or \"Payee Customer ID\" = :address or \"Payee Account ID\" = :address or \"Payee VPA ID\" = :address or \"Customer ID\" = :address or \"Account ID\" = :address or \"VPA ID\" = :address ) AND cast(\"Txn Date Time\" as date) BETWEEN :StartDate AND :EndDate and \"Decision Name\" = :decision and \"Rule Name\" = :rule and \"Txn Class\" = :class"
        }
    }
}'::text WHERE
idashboardqueryid = 33;


UPDATE ui.dashboardresultset SET
vcdashboardresultsetschema = '{
"Txn Date Time" : "datetime",
"Txn ID" : "string" ,
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
"Score" : "integer"
}'::text WHERE
idashboardresultsetid = 13;
