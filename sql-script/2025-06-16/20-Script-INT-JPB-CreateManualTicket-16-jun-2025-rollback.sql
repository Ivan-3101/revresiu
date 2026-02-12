UPDATE ui.dashboardquery SET
vcdashboardquery =  E'{ 
    "Account":"SELECT cast(observations as text), cast(result as text), vcpayeeaddr, vcpayeraddr, vcpayeeaccountexternalid, vcpayeraccountexternalid, risk_override, risk_context->>''caseId'' as \\"caseId\\" FROM analytics.trans WHERE (ipayeeaccountid = :address OR ipayeraccountid = :address) AND vcuniquetransid = :transid and dttrxntime between :StartDate and :EndDate and itenantid = :tenantid",
    "VPA": "SELECT cast(observations as text), cast(result as text), vcpayeeaddr, vcpayeraddr, vcpayeeaccountexternalid, vcpayeraccountexternalid, risk_override, risk_context->>''caseId'' as \\"caseId\\" FROM analytics.trans WHERE (ipayeevpaid = :address OR ipayervpaid = :address) AND vcuniquetransid = :transid and dttrxntime between :StartDate and :EndDate and itenantid = :tenantid"
}'::text,dbtype = 1 WHERE
idashboardqueryid = 170 AND itenantid = 12;

UPDATE ui.dashboardquery SET
vcdashboardquery = '{ 
        "Account":"SELECT iaccountid FROM masters.accounts WHERE vcexternalaccountid = :address and itenantid = :tenantid",
        "VPA": "SELECT ivpaid FROM masters.vpa WHERE vcexternaladdressid = :address and itenantid = :tenantid"
    }'::text,dbtype = 1 WHERE
idashboardqueryid = 169 AND itenantid = 12;