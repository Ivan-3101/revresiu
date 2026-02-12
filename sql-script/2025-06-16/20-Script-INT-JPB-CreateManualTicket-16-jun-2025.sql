UPDATE ui.dashboardquery SET
vcdashboardquery =  E'
{
       "Account":"WITH _filtered_data AS ( SELECT iaccountid FROM t12refined.masters.accounts WHERE vcexternalaccountid = :address AND itenantid = :tenantid ) SELECT iaccountid FROM _filtered_data",
        "VPA":   "WITH _filtered_data AS ( SELECT ivpaid FROM t12refined.masters.vpa WHERE vcexternaladdressid = :address AND itenantid = :tenantid ) SELECT ivpaid FROM _filtered_data"
    }'::text,dbtype = 3 WHERE
idashboardqueryid = 169 AND itenantid = 12;

UPDATE ui.dashboardquery SET
vcdashboardquery =  E'
{
    "Account":"WITH _filtered_data AS ( SELECT CAST(observations AS VARCHAR) AS \\"observations\\", CAST(result AS VARCHAR) AS \\"result\\", vcpayeeaddr, vcpayeraddr, vcpayeeaccountexternalid, vcpayeraccountexternalid, risk_override, json_extract_scalar(risk_context, ''$.caseId'') AS \\"caseId\\" FROM t12refined.analytics.trans WHERE (ipayeeaccountid = :address OR ipayeraccountid = :address) AND vcuniquetransid = :transid AND tdate BETWEEN :StartDate AND :EndDate AND itenantid = :tenantid ) SELECT * FROM _filtered_data",
    "VPA":    "WITH _filtered_data AS ( SELECT CAST(observations AS VARCHAR) AS \\"observations\\", CAST(result AS VARCHAR) AS \\"result\\", vcpayeeaddr, vcpayeraddr, vcpayeeaccountexternalid, vcpayeraccountexternalid, risk_override, json_extract_scalar(risk_context, ''$.caseId'') AS \\"caseId\\" FROM t12refined.analytics.trans WHERE (ipayeevpaid = :address OR ipayervpaid = :address) AND vcuniquetransid = :transid AND tdate BETWEEN :StartDate AND :EndDate AND itenantid = :tenantid ) SELECT * FROM _filtered_data"
}'::text, dbtype = 3 WHERE
idashboardqueryid = 170 AND itenantid = 12;
