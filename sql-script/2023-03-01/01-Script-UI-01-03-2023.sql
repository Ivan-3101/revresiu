UPDATE ui.dashboardquery SET
vcdashboardquery = '{
    "All":
    {
        "All" : {
            "All" : "SELECT \"Txn Date Time\", \"Txn ID\", \"Payer Customer ID\", \"Payer Account ID\", \"Payer VPA ID\",\"Customer ID\", \"Account ID\", \"VPA ID\", \"Payee Customer ID\", \"Payee Account ID\", \"Payee VPA ID\", \"Txn Class\", \"Txn Amount\", \"Decision Name\", \"Rule ID\", \"Rule Name\", \"Score\" FROM transactions.combined_rule_triggered WHERE \"Score\" >= :score AND cast(\"Txn Date Time\" as date) BETWEEN :StartDate AND :EndDate",
            "Other": "SELECT \"Txn Date Time\", \"Txn ID\", \"Payer Customer ID\", \"Payer Account ID\", \"Payer VPA ID\",\"Customer ID\", \"Account ID\", \"VPA ID\", \"Payee Customer ID\", \"Payee Account ID\", \"Payee VPA ID\", \"Txn Class\", \"Txn Amount\", \"Decision Name\", \"Rule ID\", \"Rule Name\", \"Score\" FROM transactions.combined_rule_triggered WHERE \"Score\" >= :score AND cast(\"Txn Date Time\" as date) BETWEEN :StartDate AND :EndDate and \"Rule Name\" = :rule"
        },
        "Other": {
            "All" : "SELECT \"Txn Date Time\", \"Txn ID\", \"Payer Customer ID\", \"Payer Account ID\", \"Payer VPA ID\",\"Customer ID\", \"Account ID\", \"VPA ID\", \"Payee Customer ID\", \"Payee Account ID\", \"Payee VPA ID\", \"Txn Class\", \"Txn Amount\", \"Decision Name\", \"Rule ID\", \"Rule Name\", \"Score\" FROM transactions.combined_rule_triggered WHERE \"Score\" >= :score AND cast(\"Txn Date Time\" as date) BETWEEN :StartDate AND :EndDate  and \"Decision Name\" = :decision ",
            "Other": "SELECT \"Txn Date Time\", \"Txn ID\", \"Payer Customer ID\", \"Payer Account ID\", \"Payer VPA ID\",\"Customer ID\", \"Account ID\", \"VPA ID\", \"Payee Customer ID\", \"Payee Account ID\", \"Payee VPA ID\", \"Txn Class\", \"Txn Amount\", \"Decision Name\", \"Rule ID\", \"Rule Name\", \"Score\" FROM transactions.combined_rule_triggered WHERE \"Score\" >= :score AND cast(\"Txn Date Time\" as date) BETWEEN :StartDate AND :EndDate and \"Decision Name\" = :decision and \"Rule Name\" = :rule"
        }
    },
    "Other":
    {
        "All" : {
            "All" : "SELECT \"Txn Date Time\", \"Txn ID\", \"Payer Customer ID\", \"Payer Account ID\", \"Payer VPA ID\",\"Customer ID\", \"Account ID\", \"VPA ID\", \"Payee Customer ID\", \"Payee Account ID\", \"Payee VPA ID\", \"Txn Class\", \"Txn Amount\", \"Decision Name\", \"Rule ID\", \"Rule Name\", \"Score\" FROM transactions.combined_rule_triggered WHERE \"Score\" >= :score AND cast(\"Txn Date Time\" as date) BETWEEN :StartDate AND :EndDate and \"Txn Class\" = :class ",
            "Other": "SELECT \"Txn Date Time\", \"Txn ID\", \"Payer Customer ID\", \"Payer Account ID\", \"Payer VPA ID\",\"Customer ID\", \"Account ID\", \"VPA ID\", \"Payee Customer ID\", \"Payee Account ID\", \"Payee VPA ID\", \"Txn Class\", \"Txn Amount\", \"Decision Name\", \"Rule ID\", \"Rule Name\", \"Score\" FROM transactions.combined_rule_triggered WHERE \"Score\" >= :score AND cast(\"Txn Date Time\" as date) BETWEEN :StartDate AND :EndDate and \"Rule Name\" = :rule and \"Txn Class\" = :class"
        },
        "Other": {
            "All" : "SELECT \"Txn Date Time\", \"Txn ID\", \"Payer Customer ID\", \"Payer Account ID\", \"Payer VPA ID\",\"Customer ID\", \"Account ID\", \"VPA ID\", \"Payee Customer ID\", \"Payee Account ID\", \"Payee VPA ID\", \"Txn Class\", \"Txn Amount\", \"Decision Name\", \"Rule ID\", \"Rule Name\", \"Score\" FROM transactions.combined_rule_triggered WHERE \"Score\" >= :score AND cast(\"Txn Date Time\" as date) BETWEEN :StartDate AND :EndDate  and \"Decision Name\" = :decision and \"Txn Class\" = :class",
            "Other": "SELECT \"Txn Date Time\", \"Txn ID\", \"Payer Customer ID\", \"Payer Account ID\", \"Payer VPA ID\",\"Customer ID\", \"Account ID\", \"VPA ID\", \"Payee Customer ID\", \"Payee Account ID\", \"Payee VPA ID\", \"Txn Class\", \"Txn Amount\", \"Decision Name\", \"Rule ID\", \"Rule Name\", \"Score\" FROM transactions.combined_rule_triggered WHERE \"Score\" >= :score AND cast(\"Txn Date Time\" as date) BETWEEN :StartDate AND :EndDate and \"Decision Name\" = :decision and \"Rule Name\" = :rule and \"Txn Class\" = :class"
        }
    }
}'::text, vcfilterparametersjson = '{"class" : null, "decision" : null, "rule" : null, "DateRange" : null, "score" : null} '::text WHERE
idashboardqueryid = 33;


UPDATE ui.dashboardfilters SET
vcdashboardfiltername = 'score'::character varying, idashboardqueryidfordefaultvalue = '37'::integer, vcdashboardfilterdisplayname = 'Score ( >= )'::character varying WHERE
idashboardfilterid = 26;


UPDATE ui.dashboardqueryparameters SET
vcparametername = 'score'::character varying, vcparametertype = 'Integer'::character varying WHERE
idashboardparameterid = 35;

