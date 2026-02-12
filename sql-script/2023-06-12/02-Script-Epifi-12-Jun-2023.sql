UPDATE ui.dashboardresultset SET
vcdashboardresultsetschema = '{
    "TRANSACTION_ID":"integer",
    "ORDER_CREATED_AT_IST":"datetime",
    "ACTOR_FROM_ACC_ID":"integer",
    "ACTOR_TO_ACC_ID":"integer",
    "ACTOR_FROM_VPA_ID":"integer",
    "ACTOR_TO_VPA_ID":"integer",
    "Risk Score":"integer",
    "TRANSACTION_AMOUNT":"float",
    "CREDIT_DEBIT":"string",
    "TRANSACTION_REMARKS":"string",
    "PAYMENT_PROTOCOL":"string",
    "PROVENANCE":"string",
    "MCC":"string",
    "P2P_P2M":"string",
    "REMARKS":"string"
}'::text WHERE
idashboardresultsetid = 11;


UPDATE ui.dashboardquery SET
vcdashboardquery = '{
    "Account": {
        "Payer": "select ilivemessageid as \"TRANSACTION_ID\", dttrxntime at time zone ''Asia/Kolkata'' at time zone :timeZone as \"ORDER_CREATED_AT_IST\", ipayeraccountid as \"ACTOR_FROM_ACC_ID\", ipayeeaccountid as \"ACTOR_TO_ACC_ID\", ipayervpaid as \"ACTOR_FROM_VPA_ID\", ipayeevpaid as \"ACTOR_TO_VPA_ID\", score as \"Risk Score\", round(cast(observations->''payee''->>''amount'' as bigint)/100, 2) as \"TRANSACTION_AMOUNT\", CASE WHEN ipayeraccountid is not null and ipayeeaccountid is not null THEN ''A2A'' WHEN ipayeraccountid is not null THEN ''A2P'' WHEN ipayeeaccountid is not null THEN ''P2A'' ELSE ''-'' END as \"CREDIT_DEBIT\", observations->''txn''->>''note'' as \"TRANSACTION_REMARKS\", observations->''txn''->>''type'' as \"PAYMENT_PROTOCOL\", observations->''txn''->''attribs''->>''provenance'' as \"PROVENANCE\", observations->''payee''->>''mcc'' as \"MCC\", observations->''txn''->''attribs''->>''p2p_p2m'' as \"P2P_P2M\", result->>''msg'' as \"REMARKS\" from transactions.trans l where l.vcpayeraccountexternalid = :VpaAddress and dttrxntime between :StartDate and :EndDate",
        "Payee": "select ilivemessageid as \"TRANSACTION_ID\", dttrxntime at time zone ''Asia/Kolkata'' at time zone :timeZone as \"ORDER_CREATED_AT_IST\", ipayeraccountid as \"ACTOR_FROM_ACC_ID\", ipayeeaccountid as \"ACTOR_TO_ACC_ID\", ipayervpaid as \"ACTOR_FROM_VPA_ID\", ipayeevpaid as \"ACTOR_TO_VPA_ID\", score as \"Risk Score\", round(cast(observations->''payee''->>''amount'' as bigint)/100, 2) as \"TRANSACTION_AMOUNT\", CASE WHEN ipayeraccountid is not null and ipayeeaccountid is not null THEN ''A2A'' WHEN ipayeraccountid is not null THEN ''A2P'' WHEN ipayeeaccountid is not null THEN ''P2A'' ELSE ''-'' END as \"CREDIT_DEBIT\", observations->''txn''->>''note'' as \"TRANSACTION_REMARKS\", observations->''txn''->>''type'' as \"PAYMENT_PROTOCOL\", observations->''txn''->''attribs''->>''provenance'' as \"PROVENANCE\", observations->''payee''->>''mcc'' as \"MCC\", observations->''txn''->''attribs''->>''p2p_p2m'' as \"P2P_P2M\", result->>''msg'' as \"REMARKS\" from transactions.trans l where l.vcpayeeaccountexternalid = :VpaAddress and dttrxntime between :StartDate and :EndDate",
        "Both": "select ilivemessageid as \"TRANSACTION_ID\", dttrxntime at time zone ''Asia/Kolkata'' at time zone :timeZone as \"ORDER_CREATED_AT_IST\", ipayeraccountid as \"ACTOR_FROM_ACC_ID\", ipayeeaccountid as \"ACTOR_TO_ACC_ID\", ipayervpaid as \"ACTOR_FROM_VPA_ID\", ipayeevpaid as \"ACTOR_TO_VPA_ID\", score as \"Risk Score\", round(cast(observations->''payee''->>''amount'' as bigint)/100, 2) as \"TRANSACTION_AMOUNT\", CASE WHEN ipayeraccountid is not null and ipayeeaccountid is not null THEN ''A2A'' WHEN ipayeraccountid is not null THEN ''A2P'' WHEN ipayeeaccountid is not null THEN ''P2A'' ELSE ''-'' END as \"CREDIT_DEBIT\", observations->''txn''->>''note'' as \"TRANSACTION_REMARKS\", observations->''txn''->>''type'' as \"PAYMENT_PROTOCOL\", observations->''txn''->''attribs''->>''provenance'' as \"PROVENANCE\", observations->''payee''->>''mcc'' as \"MCC\", observations->''txn''->''attribs''->>''p2p_p2m'' as \"P2P_P2M\", result->>''msg'' as \"REMARKS\" from transactions.trans l where (l.vcpayeraccountexternalid = :VpaAddress or l.vcpayeeaccountexternalid=:VpaAddress) and  dttrxntime between :StartDate  and :EndDate"
    },
    "VPA": {
        "Payer": "select ilivemessageid as \"TRANSACTION_ID\", dttrxntime at time zone ''Asia/Kolkata'' at time zone :timeZone as \"ORDER_CREATED_AT_IST\", ipayeraccountid as \"ACTOR_FROM_ACC_ID\", ipayeeaccountid as \"ACTOR_TO_ACC_ID\", ipayervpaid as \"ACTOR_FROM_VPA_ID\", ipayeevpaid as \"ACTOR_TO_VPA_ID\", score as \"Risk Score\", round(cast(observations->''payee''->>''amount'' as bigint)/100, 2) as \"TRANSACTION_AMOUNT\", CASE WHEN ipayeraccountid is not null and ipayeeaccountid is not null THEN ''A2A'' WHEN ipayeraccountid is not null THEN ''A2P'' WHEN ipayeeaccountid is not null THEN ''P2A'' ELSE ''-'' END as \"CREDIT_DEBIT\", observations->''txn''->>''note'' as \"TRANSACTION_REMARKS\", observations->''txn''->>''type'' as \"PAYMENT_PROTOCOL\", observations->''txn''->''attribs''->>''provenance'' as \"PROVENANCE\", observations->''payee''->>''mcc'' as \"MCC\", observations->''txn''->''attribs''->>''p2p_p2m'' as \"P2P_P2M\", result->>''msg'' as \"REMARKS\" from transactions.trans l where l.vcpayeraddr = :VpaAddress and dttrxntime  between :StartDate and :EndDate",
        "Payee": "select ilivemessageid as \"TRANSACTION_ID\", dttrxntime at time zone ''Asia/Kolkata'' at time zone :timeZone as \"ORDER_CREATED_AT_IST\", ipayeraccountid as \"ACTOR_FROM_ACC_ID\", ipayeeaccountid as \"ACTOR_TO_ACC_ID\", ipayervpaid as \"ACTOR_FROM_VPA_ID\", ipayeevpaid as \"ACTOR_TO_VPA_ID\", score as \"Risk Score\", round(cast(observations->''payee''->>''amount'' as bigint)/100, 2) as \"TRANSACTION_AMOUNT\", CASE WHEN ipayeraccountid is not null and ipayeeaccountid is not null THEN ''A2A'' WHEN ipayeraccountid is not null THEN ''A2P'' WHEN ipayeeaccountid is not null THEN ''P2A'' ELSE ''-'' END as \"CREDIT_DEBIT\", observations->''txn''->>''note'' as \"TRANSACTION_REMARKS\", observations->''txn''->>''type'' as \"PAYMENT_PROTOCOL\", observations->''txn''->''attribs''->>''provenance'' as \"PROVENANCE\", observations->''payee''->>''mcc'' as \"MCC\", observations->''txn''->''attribs''->>''p2p_p2m'' as \"P2P_P2M\", result->>''msg'' as \"REMARKS\" from transactions.trans l where l.vcpayeeaddr = :VpaAddress  and dttrxntime between :StartDate  and :EndDate",
        "Both": "select ilivemessageid as \"TRANSACTION_ID\", dttrxntime at time zone ''Asia/Kolkata'' at time zone :timeZone as \"ORDER_CREATED_AT_IST\", ipayeraccountid as \"ACTOR_FROM_ACC_ID\", ipayeeaccountid as \"ACTOR_TO_ACC_ID\", ipayervpaid as \"ACTOR_FROM_VPA_ID\", ipayeevpaid as \"ACTOR_TO_VPA_ID\", score as \"Risk Score\", round(cast(observations->''payee''->>''amount'' as bigint)/100, 2) as \"TRANSACTION_AMOUNT\", CASE WHEN ipayeraccountid is not null and ipayeeaccountid is not null THEN ''A2A'' WHEN ipayeraccountid is not null THEN ''A2P'' WHEN ipayeeaccountid is not null THEN ''P2A'' ELSE ''-'' END as \"CREDIT_DEBIT\", observations->''txn''->>''note'' as \"TRANSACTION_REMARKS\", observations->''txn''->>''type'' as \"PAYMENT_PROTOCOL\", observations->''txn''->''attribs''->>''provenance'' as \"PROVENANCE\", observations->''payee''->>''mcc'' as \"MCC\", observations->''txn''->''attribs''->>''p2p_p2m'' as \"P2P_P2M\", result->>''msg'' as \"REMARKS\" from transactions.trans l where (l.vcpayeeaddr = :VpaAddress or l.vcpayeraddr = :VpaAddress) and  dttrxntime between :StartDate  and :EndDate"
    }
}'::text WHERE
idashboardqueryid = 30;


UPDATE ui.dashboardresultset SET
vcdashboardresultsetlayout = '{"sizes":[1],"detail":{"main":{"type":"tab-area","widgets":["PERSPECTIVE_GENERATED_ID_1"],"currentIndex":0}},"mode":"globalFilters","viewers":{"PERSPECTIVE_GENERATED_ID_1":{"plugin":"Datagrid","plugin_config":{"columns":{},"editable":false,"scroll_lock":true},"settings":false,"theme":"Pro Dark","title":"Transactions","group_by":[],"split_by":[],"columns":["TRANSACTION_ID","ORDER_CREATED_AT_IST","ACTOR_FROM_ACC_ID","ACTOR_TO_ACC_ID","ACTOR_FROM_VPA_ID","ACTOR_TO_VPA_ID","Risk Score","TRANSACTION_AMOUNT","CREDIT_DEBIT","TRANSACTION_REMARKS","PAYMENT_PROTOCOL","PROVENANCE","MCC","P2P_P2M","REMARKS"],"filter":[],"sort":[],"expressions":[],"aggregates":{},"master":false,"table":"testing","linked":false}}} '::text WHERE
idashboardresultsetid = 11;


