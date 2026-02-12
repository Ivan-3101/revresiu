UPDATE ui.dashboardquery SET
vcdashboardquery
='{
     "Txn":"SELECT X.* FROM   (VALUES (''Txn ID'', ''Txn ID''),(''RRN'', ''RRN''), (''Auth Code'', ''Auth Code'')) AS X (\"label\", \"value\")",
     "Other":"SELECT X.* FROM   (VALUES (''Payer'', ''Payer''),(''Payee'', ''Payee''), (''Both'', ''Both'')) AS X (\"label\", \"value\")"
 }' WHERE itenantid in (14, 15) AND idashboardqueryid = 127;