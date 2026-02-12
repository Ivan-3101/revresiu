   UPDATE ui.dashboardresultset SET
   vcdashboardresultsetschema = '{
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
   }'::text WHERE
   idashboardresultsetid = 13;



   UPDATE ui.dashboardquery SET
   vcdashboardquery = '{
       "All":
       {
           "All" : {
               "All" : "SELECT \"Txn Date Time\", \"Txn ID\", \"Unique ID\", \"Payer Customer ID\", \"Payer Account ID\", \"Payer VPA ID\",\"Customer ID\", \"Account ID\", \"VPA ID\", \"Payee Customer ID\", \"Payee Account ID\", \"Payee VPA ID\", \"Txn Class\", \"Txn Amount\", \"Decision Name\", \"Rule ID\", \"Rule Name\", \"Score\", \"Side\" FROM transactions.combined_rule_triggered WHERE \"Score\" >= :score AND \"Txn Date Time\" BETWEEN :StartDate AND :EndDate",
               "Other": "SELECT \"Txn Date Time\", \"Txn ID\", \"Unique ID\", \"Payer Customer ID\", \"Payer Account ID\", \"Payer VPA ID\",\"Customer ID\", \"Account ID\", \"VPA ID\", \"Payee Customer ID\", \"Payee Account ID\", \"Payee VPA ID\", \"Txn Class\", \"Txn Amount\", \"Decision Name\", \"Rule ID\", \"Rule Name\", \"Score\", \"Side\" FROM transactions.combined_rule_triggered WHERE \"Score\" >= :score AND \"Txn Date Time\" BETWEEN :StartDate AND :EndDate and \"Rule Name\" = :rule"
           },
           "Other": {
               "All" : "SELECT \"Txn Date Time\", \"Txn ID\", \"Unique ID\", \"Payer Customer ID\", \"Payer Account ID\", \"Payer VPA ID\",\"Customer ID\", \"Account ID\", \"VPA ID\", \"Payee Customer ID\", \"Payee Account ID\", \"Payee VPA ID\", \"Txn Class\", \"Txn Amount\", \"Decision Name\", \"Rule ID\", \"Rule Name\", \"Score\", \"Side\" FROM transactions.combined_rule_triggered WHERE \"Score\" >= :score AND \"Txn Date Time\" BETWEEN :StartDate AND :EndDate  and \"Decision Name\" = :decision ",
               "Other": "SELECT \"Txn Date Time\", \"Txn ID\", \"Unique ID\", \"Payer Customer ID\", \"Payer Account ID\", \"Payer VPA ID\",\"Customer ID\", \"Account ID\", \"VPA ID\", \"Payee Customer ID\", \"Payee Account ID\", \"Payee VPA ID\", \"Txn Class\", \"Txn Amount\", \"Decision Name\", \"Rule ID\", \"Rule Name\", \"Score\", \"Side\" FROM transactions.combined_rule_triggered WHERE \"Score\" >= :score AND \"Txn Date Time\" BETWEEN :StartDate AND :EndDate and \"Decision Name\" = :decision and \"Rule Name\" = :rule"
           }
       },
       "Other":
       {
           "All" : {
               "All" : "SELECT \"Txn Date Time\", \"Txn ID\", \"Unique ID\", \"Payer Customer ID\", \"Payer Account ID\", \"Payer VPA ID\",\"Customer ID\", \"Account ID\", \"VPA ID\", \"Payee Customer ID\", \"Payee Account ID\", \"Payee VPA ID\", \"Txn Class\", \"Txn Amount\", \"Decision Name\", \"Rule ID\", \"Rule Name\", \"Score\", \"Side\" FROM transactions.combined_rule_triggered WHERE \"Score\" >= :score AND \"Txn Date Time\" BETWEEN :StartDate AND :EndDate and \"Txn Class\" = :class ",
               "Other": "SELECT \"Txn Date Time\", \"Txn ID\", \"Unique ID\", \"Payer Customer ID\", \"Payer Account ID\", \"Payer VPA ID\",\"Customer ID\", \"Account ID\", \"VPA ID\", \"Payee Customer ID\", \"Payee Account ID\", \"Payee VPA ID\", \"Txn Class\", \"Txn Amount\", \"Decision Name\", \"Rule ID\", \"Rule Name\", \"Score\", \"Side\" FROM transactions.combined_rule_triggered WHERE \"Score\" >= :score AND \"Txn Date Time\" BETWEEN :StartDate AND :EndDate and \"Rule Name\" = :rule and \"Txn Class\" = :class"
           },
           "Other": {
               "All" : "SELECT \"Txn Date Time\", \"Txn ID\", \"Unique ID\", \"Payer Customer ID\", \"Payer Account ID\", \"Payer VPA ID\",\"Customer ID\", \"Account ID\", \"VPA ID\", \"Payee Customer ID\", \"Payee Account ID\", \"Payee VPA ID\", \"Txn Class\", \"Txn Amount\", \"Decision Name\", \"Rule ID\", \"Rule Name\", \"Score\", \"Side\" FROM transactions.combined_rule_triggered WHERE \"Score\" >= :score AND \"Txn Date Time\" BETWEEN :StartDate AND :EndDate  and \"Decision Name\" = :decision and \"Txn Class\" = :class",
               "Other": "SELECT \"Txn Date Time\", \"Txn ID\", \"Unique ID\", \"Payer Customer ID\", \"Payer Account ID\", \"Payer VPA ID\",\"Customer ID\", \"Account ID\", \"VPA ID\", \"Payee Customer ID\", \"Payee Account ID\", \"Payee VPA ID\", \"Txn Class\", \"Txn Amount\", \"Decision Name\", \"Rule ID\", \"Rule Name\", \"Score\", \"Side\" FROM transactions.combined_rule_triggered WHERE \"Score\" >= :score AND \"Txn Date Time\" BETWEEN :StartDate AND :EndDate and \"Decision Name\" = :decision and \"Rule Name\" = :rule and \"Txn Class\" = :class"
           }
       }
   }'::text WHERE
   idashboardqueryid = 33;