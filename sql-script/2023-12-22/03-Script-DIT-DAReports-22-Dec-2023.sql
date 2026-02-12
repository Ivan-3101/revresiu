INSERT INTO ui.dashboard (
idashboardid, bactive, bdelete, vcdashboardname, iorder, irowcount, imenustructuredesc) VALUES (
'40'::integer, true::boolean, false::boolean, 'Alerted Transactions'::character varying, '40'::integer, '1'::integer, '510'::integer)
 returning idashboardid;


INSERT INTO ui.dashboardquery (
idashboardqueryid, bparametersrequired, vcfilterparametersjson, vcdashboardquery, formattingrequiered, runonanalytics, transposerequired, imenustructuredesc) VALUES (
'90'::integer, true::boolean, '{
    "DateRange": null,
    "Class": null,
    "Decision": null,
    "RiskScore": null,
    "Rule": null,
    "Load":null
}'::text, '{
    "All":
    {
        "All" : {
            "All" : "select l.ilivemessageid as \"id\", observations->>''reqid'' as \"Request ID\", cast(observations->>''ts'' as timestamp with time zone) \"Timestamp\", result->>''msg'' as \"Remarks\", observations->>''org'' as \"Org\", result->>''status'' as \"Status\", observations->''txn''->>''id'' as \"Txn ID\", cast(observations->''txn''->>''ts'' as timestamp with time zone) as \"Txn Timestamp\", observations->''txn''->>''note'' as \"Note\", observations->''txn''->>''type'' as \"Type\", observations->''txn''->>''class'' as \"Class\", observations->''payee''->>''addr'' as \"Merchant addr\", observations->''payee''->''attribs''->''identity''->>''verified_name'' as \"Payee Name\", observations->''observations''->''payeeVPA''->>''payment_address'' as \"Payee VPA\", observations->''observations''->''payeeVPA''->''account''->>''accountName'' as \"Account Name\", observations->''observations''->''payeeVPA''->''account''->>''default_mcc'' as \"Default MCC\", observations->''payee''->>''mcc'' as \"MCC\", observations->''observations''->''payeeVPA''->''account''->''customer''->>''email'' as \"Payee email\", observations->''payer''->>''addr'' as \"Payer\", observations->''observations''->''payerVPA''->>''payment_address'' as \"Payer VPA\", observations->''observations''->''payerVPA''->>''vpaName'' as \"Payer Name\", observations->''payer''->''attribs''->''device''->>''ip'' as \"Payer IP\", result->''score''->>''score'' as \"Txn Score\", round(cast(observations->''payee''->>''amount'' as integer)/100, 2) as \"Txn Amount\", observations->''txn''->''attribs''->>''card_country_code'' as \"Card Country Code\", observations->''txn''->>''orgTxnId'' as \"Original Txn ID\", observations->''txn''->''attribs''->>''acquirer_name'' as \"Acquirer Name\", observations->''payee''->>''currency'' as \"Currency\", result->''score''->>''workflow'' as \"Workflow Type\", observations->''observations''->''decisionclass''->>''decisionName'' as \"Decision Name\", result->''score''->>''decisiondetails'' as \"Decision Detail\", observations->''observations''->>''new_payee'' as \"Is_New_Merchant\", observations->''observations''->>''new_payer'' as \"Is_New_Payer\", observations->''txn''->''attribs''->>''skip_processing'' as \"Skip Processing\", observations->''observations''->''ip_details''->>''country'' as \"ip_details.Country\", observations->''observations''->''ip_details''->''details''->>''postal_code'' as \"ip_details.PostalCode\", observations->''observations''->''ip_details''->''details''->>''adm3-city-town'' as \"ip_details.City\", observations->''observations''->''payeeVPA''->''account''->''customer''->''attribs''->>''city'' as \"observations.payeeVPA.account.customer.attribs.city\", observations->''observations''->>''same_payer_payee_acc_d01_txn_count'' as \"observations.same_payer_payee_acc_d01_txn_count\", observations->''observations''->>''same_payer_payee_acc_d01_txn_value'' as \"observations.same_payer_payee_acc_d01_txn_value\", observations->''observations''->>''payer_unique_payee_acc_online_d01_txn_count'' as \"observations.payer_unique_payee_acc_online_d01_txn_count\", observations->''observations''->>''payee_online_intl_card_m30_txn_count'' as \"observations.payee_online_intl_card_m30_txn_count\", observations->''observations''->>''same_payee_same_amt_online_m15_txn_count'' as \"observations.same_payee_same_amt_online_m15_txn_count\", observations->''observations''->>''same_payee_online_m10_gteq250_txn_count'' as \"observations.same_payee_online_m10_gteq250_txn_count\", observations->''observations''->>''payee_account_d01_txn_value'' as \"observations.payee_account_d01_txn_value\", observations->''observations''->>''same_payee_acc_PT48H_txn_value'' as \"observations.same_payee_acc_PT48H_txn_value\", observations->''observations''->>''payee_acc_decline_less5k_m30_txn_count'' as \"observations.payee_acc_decline_less5k_m30_txn_count\", observations->''observations''->>''same_payee_online_PT24H_txn_value'' as \"observations.same_payee_online_PT24H_txn_value\", observations->''observations''->>''same_payer_payee_online_PT5M_txnPay_count'' as \"observations.same_payer_payee_online_PT5M_txnPay_count\", observations->''observations''->>''payer_decline_m30_txn_count'' as \"observations.payer_decline_m30_txn_count\", observations->''observations''->>''same_payer_payee_online_d01_txn_count'' as \"observations.same_payer_payee_online_d01_txn_count\", observations->''observations''->>''same_payer_payee_online_d01_txn_value'' as \"observations.same_payer_payee_online_d01_txn_value\" , rt.dttrxntime AS \"Txn Date Time\", rt.vcmsgid AS \"Txn ID\", rt.vcpayercustomerexternalid AS \"Payer Customer ID\", rt.vcpayeraccountexternalid AS \"Payer Account ID\", rt.vcpayeraddr AS \"Payer VPA ID\", rt.vcpayeecustomerexternalid AS \"Payee Customer ID\", rt.vcpayeeaccountexternalid AS \"Payee Account ID\", rt.vcpayeeaddr AS \"Payee VPA ID\", rt.vcclassname AS \"Txn Class\", rt.dobservationamount AS \"Txn Amount\", rt.vcdecisionname AS \"Decision Name\", rt.iruleid AS \"Rule ID\", rt.vcrulename AS \"Rule Name\", rt.rule_score AS \"Score\", rt.vcremark AS \"Side\" FROM transactions.rule_triggered rt left join analytics.trans l on l.ilivemessageid = rt.ilivemessageid WHERE rt.rule_score >= :RiskScore AND rt.dttrxntime BETWEEN :StartDate AND :EndDate and itenantid = :tenantid order by rt.dttrxntime desc limit :Load",
            "Other": "select l.ilivemessageid as \"id\", observations->>''reqid'' as \"Request ID\", cast(observations->>''ts'' as timestamp with time zone) \"Timestamp\", result->>''msg'' as \"Remarks\", observations->>''org'' as \"Org\", result->>''status'' as \"Status\", observations->''txn''->>''id'' as \"Txn ID\", cast(observations->''txn''->>''ts'' as timestamp with time zone) as \"Txn Timestamp\", observations->''txn''->>''note'' as \"Note\", observations->''txn''->>''type'' as \"Type\", observations->''txn''->>''class'' as \"Class\", observations->''payee''->>''addr'' as \"Merchant addr\", observations->''payee''->''attribs''->''identity''->>''verified_name'' as \"Payee Name\", observations->''observations''->''payeeVPA''->>''payment_address'' as \"Payee VPA\", observations->''observations''->''payeeVPA''->''account''->>''accountName'' as \"Account Name\", observations->''observations''->''payeeVPA''->''account''->>''default_mcc'' as \"Default MCC\", observations->''payee''->>''mcc'' as \"MCC\", observations->''observations''->''payeeVPA''->''account''->''customer''->>''email'' as \"Payee email\", observations->''payer''->>''addr'' as \"Payer\", observations->''observations''->''payerVPA''->>''payment_address'' as \"Payer VPA\", observations->''observations''->''payerVPA''->>''vpaName'' as \"Payer Name\", observations->''payer''->''attribs''->''device''->>''ip'' as \"Payer IP\", result->''score''->>''score'' as \"Txn Score\", round(cast(observations->''payee''->>''amount'' as integer)/100, 2) as \"Txn Amount\", observations->''txn''->''attribs''->>''card_country_code'' as \"Card Country Code\", observations->''txn''->>''orgTxnId'' as \"Original Txn ID\", observations->''txn''->''attribs''->>''acquirer_name'' as \"Acquirer Name\", observations->''payee''->>''currency'' as \"Currency\", result->''score''->>''workflow'' as \"Workflow Type\", observations->''observations''->''decisionclass''->>''decisionName'' as \"Decision Name\", result->''score''->>''decisiondetails'' as \"Decision Detail\", observations->''observations''->>''new_payee'' as \"Is_New_Merchant\", observations->''observations''->>''new_payer'' as \"Is_New_Payer\", observations->''txn''->''attribs''->>''skip_processing'' as \"Skip Processing\", observations->''observations''->''ip_details''->>''country'' as \"ip_details.Country\", observations->''observations''->''ip_details''->''details''->>''postal_code'' as \"ip_details.PostalCode\", observations->''observations''->''ip_details''->''details''->>''adm3-city-town'' as \"ip_details.City\", observations->''observations''->''payeeVPA''->''account''->''customer''->''attribs''->>''city'' as \"observations.payeeVPA.account.customer.attribs.city\", observations->''observations''->>''same_payer_payee_acc_d01_txn_count'' as \"observations.same_payer_payee_acc_d01_txn_count\", observations->''observations''->>''same_payer_payee_acc_d01_txn_value'' as \"observations.same_payer_payee_acc_d01_txn_value\", observations->''observations''->>''payer_unique_payee_acc_online_d01_txn_count'' as \"observations.payer_unique_payee_acc_online_d01_txn_count\", observations->''observations''->>''payee_online_intl_card_m30_txn_count'' as \"observations.payee_online_intl_card_m30_txn_count\", observations->''observations''->>''same_payee_same_amt_online_m15_txn_count'' as \"observations.same_payee_same_amt_online_m15_txn_count\", observations->''observations''->>''same_payee_online_m10_gteq250_txn_count'' as \"observations.same_payee_online_m10_gteq250_txn_count\", observations->''observations''->>''payee_account_d01_txn_value'' as \"observations.payee_account_d01_txn_value\", observations->''observations''->>''same_payee_acc_PT48H_txn_value'' as \"observations.same_payee_acc_PT48H_txn_value\", observations->''observations''->>''payee_acc_decline_less5k_m30_txn_count'' as \"observations.payee_acc_decline_less5k_m30_txn_count\", observations->''observations''->>''same_payee_online_PT24H_txn_value'' as \"observations.same_payee_online_PT24H_txn_value\", observations->''observations''->>''same_payer_payee_online_PT5M_txnPay_count'' as \"observations.same_payer_payee_online_PT5M_txnPay_count\", observations->''observations''->>''payer_decline_m30_txn_count'' as \"observations.payer_decline_m30_txn_count\", observations->''observations''->>''same_payer_payee_online_d01_txn_count'' as \"observations.same_payer_payee_online_d01_txn_count\", observations->''observations''->>''same_payer_payee_online_d01_txn_value'' as \"observations.same_payer_payee_online_d01_txn_value\" , rt.dttrxntime AS \"Txn Date Time\", rt.vcmsgid AS \"Txn ID\", rt.vcpayercustomerexternalid AS \"Payer Customer ID\", rt.vcpayeraccountexternalid AS \"Payer Account ID\", rt.vcpayeraddr AS \"Payer VPA ID\", rt.vcpayeecustomerexternalid AS \"Payee Customer ID\", rt.vcpayeeaccountexternalid AS \"Payee Account ID\", rt.vcpayeeaddr AS \"Payee VPA ID\", rt.vcclassname AS \"Txn Class\", rt.dobservationamount AS \"Txn Amount\", rt.vcdecisionname AS \"Decision Name\", rt.iruleid AS \"Rule ID\", rt.vcrulename AS \"Rule Name\", rt.rule_score AS \"Score\", rt.vcremark AS \"Side\" FROM transactions.rule_triggered rt left join analytics.trans l on l.ilivemessageid = rt.ilivemessageid WHERE rt.rule_score >= :RiskScore AND rt.dttrxntime BETWEEN :StartDate AND :EndDate and itenantid = :tenantid and rt.vcrulename = :Rule order by rt.dttrxntime desc limit :Load"
        },
        "Other": {
            "All" : "select l.ilivemessageid as \"id\", observations->>''reqid'' as \"Request ID\", cast(observations->>''ts'' as timestamp with time zone) \"Timestamp\", result->>''msg'' as \"Remarks\", observations->>''org'' as \"Org\", result->>''status'' as \"Status\", observations->''txn''->>''id'' as \"Txn ID\", cast(observations->''txn''->>''ts'' as timestamp with time zone) as \"Txn Timestamp\", observations->''txn''->>''note'' as \"Note\", observations->''txn''->>''type'' as \"Type\", observations->''txn''->>''class'' as \"Class\", observations->''payee''->>''addr'' as \"Merchant addr\", observations->''payee''->''attribs''->''identity''->>''verified_name'' as \"Payee Name\", observations->''observations''->''payeeVPA''->>''payment_address'' as \"Payee VPA\", observations->''observations''->''payeeVPA''->''account''->>''accountName'' as \"Account Name\", observations->''observations''->''payeeVPA''->''account''->>''default_mcc'' as \"Default MCC\", observations->''payee''->>''mcc'' as \"MCC\", observations->''observations''->''payeeVPA''->''account''->''customer''->>''email'' as \"Payee email\", observations->''payer''->>''addr'' as \"Payer\", observations->''observations''->''payerVPA''->>''payment_address'' as \"Payer VPA\", observations->''observations''->''payerVPA''->>''vpaName'' as \"Payer Name\", observations->''payer''->''attribs''->''device''->>''ip'' as \"Payer IP\", result->''score''->>''score'' as \"Txn Score\", round(cast(observations->''payee''->>''amount'' as integer)/100, 2) as \"Txn Amount\", observations->''txn''->''attribs''->>''card_country_code'' as \"Card Country Code\", observations->''txn''->>''orgTxnId'' as \"Original Txn ID\", observations->''txn''->''attribs''->>''acquirer_name'' as \"Acquirer Name\", observations->''payee''->>''currency'' as \"Currency\", result->''score''->>''workflow'' as \"Workflow Type\", observations->''observations''->''decisionclass''->>''decisionName'' as \"Decision Name\", result->''score''->>''decisiondetails'' as \"Decision Detail\", observations->''observations''->>''new_payee'' as \"Is_New_Merchant\", observations->''observations''->>''new_payer'' as \"Is_New_Payer\", observations->''txn''->''attribs''->>''skip_processing'' as \"Skip Processing\", observations->''observations''->''ip_details''->>''country'' as \"ip_details.Country\", observations->''observations''->''ip_details''->''details''->>''postal_code'' as \"ip_details.PostalCode\", observations->''observations''->''ip_details''->''details''->>''adm3-city-town'' as \"ip_details.City\", observations->''observations''->''payeeVPA''->''account''->''customer''->''attribs''->>''city'' as \"observations.payeeVPA.account.customer.attribs.city\", observations->''observations''->>''same_payer_payee_acc_d01_txn_count'' as \"observations.same_payer_payee_acc_d01_txn_count\", observations->''observations''->>''same_payer_payee_acc_d01_txn_value'' as \"observations.same_payer_payee_acc_d01_txn_value\", observations->''observations''->>''payer_unique_payee_acc_online_d01_txn_count'' as \"observations.payer_unique_payee_acc_online_d01_txn_count\", observations->''observations''->>''payee_online_intl_card_m30_txn_count'' as \"observations.payee_online_intl_card_m30_txn_count\", observations->''observations''->>''same_payee_same_amt_online_m15_txn_count'' as \"observations.same_payee_same_amt_online_m15_txn_count\", observations->''observations''->>''same_payee_online_m10_gteq250_txn_count'' as \"observations.same_payee_online_m10_gteq250_txn_count\", observations->''observations''->>''payee_account_d01_txn_value'' as \"observations.payee_account_d01_txn_value\", observations->''observations''->>''same_payee_acc_PT48H_txn_value'' as \"observations.same_payee_acc_PT48H_txn_value\", observations->''observations''->>''payee_acc_decline_less5k_m30_txn_count'' as \"observations.payee_acc_decline_less5k_m30_txn_count\", observations->''observations''->>''same_payee_online_PT24H_txn_value'' as \"observations.same_payee_online_PT24H_txn_value\", observations->''observations''->>''same_payer_payee_online_PT5M_txnPay_count'' as \"observations.same_payer_payee_online_PT5M_txnPay_count\", observations->''observations''->>''payer_decline_m30_txn_count'' as \"observations.payer_decline_m30_txn_count\", observations->''observations''->>''same_payer_payee_online_d01_txn_count'' as \"observations.same_payer_payee_online_d01_txn_count\", observations->''observations''->>''same_payer_payee_online_d01_txn_value'' as \"observations.same_payer_payee_online_d01_txn_value\" , rt.dttrxntime AS \"Txn Date Time\", rt.vcmsgid AS \"Txn ID\", rt.vcpayercustomerexternalid AS \"Payer Customer ID\", rt.vcpayeraccountexternalid AS \"Payer Account ID\", rt.vcpayeraddr AS \"Payer VPA ID\", rt.vcpayeecustomerexternalid AS \"Payee Customer ID\", rt.vcpayeeaccountexternalid AS \"Payee Account ID\", rt.vcpayeeaddr AS \"Payee VPA ID\", rt.vcclassname AS \"Txn Class\", rt.dobservationamount AS \"Txn Amount\", rt.vcdecisionname AS \"Decision Name\", rt.iruleid AS \"Rule ID\", rt.vcrulename AS \"Rule Name\", rt.rule_score AS \"Score\", rt.vcremark AS \"Side\" FROM transactions.rule_triggered rt left join analytics.trans l on l.ilivemessageid = rt.ilivemessageid WHERE rt.rule_score >= :RiskScore AND rt.dttrxntime BETWEEN :StartDate AND :EndDate and itenantid = :tenantid  and rt.vcdecisionname = :Decision order by rt.dttrxntime desc limit :Load",
            "Other": "select l.ilivemessageid as \"id\", observations->>''reqid'' as \"Request ID\", cast(observations->>''ts'' as timestamp with time zone) \"Timestamp\", result->>''msg'' as \"Remarks\", observations->>''org'' as \"Org\", result->>''status'' as \"Status\", observations->''txn''->>''id'' as \"Txn ID\", cast(observations->''txn''->>''ts'' as timestamp with time zone) as \"Txn Timestamp\", observations->''txn''->>''note'' as \"Note\", observations->''txn''->>''type'' as \"Type\", observations->''txn''->>''class'' as \"Class\", observations->''payee''->>''addr'' as \"Merchant addr\", observations->''payee''->''attribs''->''identity''->>''verified_name'' as \"Payee Name\", observations->''observations''->''payeeVPA''->>''payment_address'' as \"Payee VPA\", observations->''observations''->''payeeVPA''->''account''->>''accountName'' as \"Account Name\", observations->''observations''->''payeeVPA''->''account''->>''default_mcc'' as \"Default MCC\", observations->''payee''->>''mcc'' as \"MCC\", observations->''observations''->''payeeVPA''->''account''->''customer''->>''email'' as \"Payee email\", observations->''payer''->>''addr'' as \"Payer\", observations->''observations''->''payerVPA''->>''payment_address'' as \"Payer VPA\", observations->''observations''->''payerVPA''->>''vpaName'' as \"Payer Name\", observations->''payer''->''attribs''->''device''->>''ip'' as \"Payer IP\", result->''score''->>''score'' as \"Txn Score\", round(cast(observations->''payee''->>''amount'' as integer)/100, 2) as \"Txn Amount\", observations->''txn''->''attribs''->>''card_country_code'' as \"Card Country Code\", observations->''txn''->>''orgTxnId'' as \"Original Txn ID\", observations->''txn''->''attribs''->>''acquirer_name'' as \"Acquirer Name\", observations->''payee''->>''currency'' as \"Currency\", result->''score''->>''workflow'' as \"Workflow Type\", observations->''observations''->''decisionclass''->>''decisionName'' as \"Decision Name\", result->''score''->>''decisiondetails'' as \"Decision Detail\", observations->''observations''->>''new_payee'' as \"Is_New_Merchant\", observations->''observations''->>''new_payer'' as \"Is_New_Payer\", observations->''txn''->''attribs''->>''skip_processing'' as \"Skip Processing\", observations->''observations''->''ip_details''->>''country'' as \"ip_details.Country\", observations->''observations''->''ip_details''->''details''->>''postal_code'' as \"ip_details.PostalCode\", observations->''observations''->''ip_details''->''details''->>''adm3-city-town'' as \"ip_details.City\", observations->''observations''->''payeeVPA''->''account''->''customer''->''attribs''->>''city'' as \"observations.payeeVPA.account.customer.attribs.city\", observations->''observations''->>''same_payer_payee_acc_d01_txn_count'' as \"observations.same_payer_payee_acc_d01_txn_count\", observations->''observations''->>''same_payer_payee_acc_d01_txn_value'' as \"observations.same_payer_payee_acc_d01_txn_value\", observations->''observations''->>''payer_unique_payee_acc_online_d01_txn_count'' as \"observations.payer_unique_payee_acc_online_d01_txn_count\", observations->''observations''->>''payee_online_intl_card_m30_txn_count'' as \"observations.payee_online_intl_card_m30_txn_count\", observations->''observations''->>''same_payee_same_amt_online_m15_txn_count'' as \"observations.same_payee_same_amt_online_m15_txn_count\", observations->''observations''->>''same_payee_online_m10_gteq250_txn_count'' as \"observations.same_payee_online_m10_gteq250_txn_count\", observations->''observations''->>''payee_account_d01_txn_value'' as \"observations.payee_account_d01_txn_value\", observations->''observations''->>''same_payee_acc_PT48H_txn_value'' as \"observations.same_payee_acc_PT48H_txn_value\", observations->''observations''->>''payee_acc_decline_less5k_m30_txn_count'' as \"observations.payee_acc_decline_less5k_m30_txn_count\", observations->''observations''->>''same_payee_online_PT24H_txn_value'' as \"observations.same_payee_online_PT24H_txn_value\", observations->''observations''->>''same_payer_payee_online_PT5M_txnPay_count'' as \"observations.same_payer_payee_online_PT5M_txnPay_count\", observations->''observations''->>''payer_decline_m30_txn_count'' as \"observations.payer_decline_m30_txn_count\", observations->''observations''->>''same_payer_payee_online_d01_txn_count'' as \"observations.same_payer_payee_online_d01_txn_count\", observations->''observations''->>''same_payer_payee_online_d01_txn_value'' as \"observations.same_payer_payee_online_d01_txn_value\" , rt.dttrxntime AS \"Txn Date Time\", rt.vcmsgid AS \"Txn ID\", rt.vcpayercustomerexternalid AS \"Payer Customer ID\", rt.vcpayeraccountexternalid AS \"Payer Account ID\", rt.vcpayeraddr AS \"Payer VPA ID\", rt.vcpayeecustomerexternalid AS \"Payee Customer ID\", rt.vcpayeeaccountexternalid AS \"Payee Account ID\", rt.vcpayeeaddr AS \"Payee VPA ID\", rt.vcclassname AS \"Txn Class\", rt.dobservationamount AS \"Txn Amount\", rt.vcdecisionname AS \"Decision Name\", rt.iruleid AS \"Rule ID\", rt.vcrulename AS \"Rule Name\", rt.rule_score AS \"Score\", rt.vcremark AS \"Side\" FROM transactions.rule_triggered rt left join analytics.trans l on l.ilivemessageid = rt.ilivemessageid WHERE rt.rule_score >= :RiskScore AND rt.dttrxntime BETWEEN :StartDate AND :EndDate and itenantid = :tenantid and rt.vcdecisionname = :Decision and rt.vcrulename = :Rule order by rt.dttrxntime desc limit :Load"
        }
    },
    "Other":
    {
        "All" : {
            "All" : "select l.ilivemessageid as \"id\", observations->>''reqid'' as \"Request ID\", cast(observations->>''ts'' as timestamp with time zone) \"Timestamp\", result->>''msg'' as \"Remarks\", observations->>''org'' as \"Org\", result->>''status'' as \"Status\", observations->''txn''->>''id'' as \"Txn ID\", cast(observations->''txn''->>''ts'' as timestamp with time zone) as \"Txn Timestamp\", observations->''txn''->>''note'' as \"Note\", observations->''txn''->>''type'' as \"Type\", observations->''txn''->>''class'' as \"Class\", observations->''payee''->>''addr'' as \"Merchant addr\", observations->''payee''->''attribs''->''identity''->>''verified_name'' as \"Payee Name\", observations->''observations''->''payeeVPA''->>''payment_address'' as \"Payee VPA\", observations->''observations''->''payeeVPA''->''account''->>''accountName'' as \"Account Name\", observations->''observations''->''payeeVPA''->''account''->>''default_mcc'' as \"Default MCC\", observations->''payee''->>''mcc'' as \"MCC\", observations->''observations''->''payeeVPA''->''account''->''customer''->>''email'' as \"Payee email\", observations->''payer''->>''addr'' as \"Payer\", observations->''observations''->''payerVPA''->>''payment_address'' as \"Payer VPA\", observations->''observations''->''payerVPA''->>''vpaName'' as \"Payer Name\", observations->''payer''->''attribs''->''device''->>''ip'' as \"Payer IP\", result->''score''->>''score'' as \"Txn Score\", round(cast(observations->''payee''->>''amount'' as integer)/100, 2) as \"Txn Amount\", observations->''txn''->''attribs''->>''card_country_code'' as \"Card Country Code\", observations->''txn''->>''orgTxnId'' as \"Original Txn ID\", observations->''txn''->''attribs''->>''acquirer_name'' as \"Acquirer Name\", observations->''payee''->>''currency'' as \"Currency\", result->''score''->>''workflow'' as \"Workflow Type\", observations->''observations''->''decisionclass''->>''decisionName'' as \"Decision Name\", result->''score''->>''decisiondetails'' as \"Decision Detail\", observations->''observations''->>''new_payee'' as \"Is_New_Merchant\", observations->''observations''->>''new_payer'' as \"Is_New_Payer\", observations->''txn''->''attribs''->>''skip_processing'' as \"Skip Processing\", observations->''observations''->''ip_details''->>''country'' as \"ip_details.Country\", observations->''observations''->''ip_details''->''details''->>''postal_code'' as \"ip_details.PostalCode\", observations->''observations''->''ip_details''->''details''->>''adm3-city-town'' as \"ip_details.City\", observations->''observations''->''payeeVPA''->''account''->''customer''->''attribs''->>''city'' as \"observations.payeeVPA.account.customer.attribs.city\", observations->''observations''->>''same_payer_payee_acc_d01_txn_count'' as \"observations.same_payer_payee_acc_d01_txn_count\", observations->''observations''->>''same_payer_payee_acc_d01_txn_value'' as \"observations.same_payer_payee_acc_d01_txn_value\", observations->''observations''->>''payer_unique_payee_acc_online_d01_txn_count'' as \"observations.payer_unique_payee_acc_online_d01_txn_count\", observations->''observations''->>''payee_online_intl_card_m30_txn_count'' as \"observations.payee_online_intl_card_m30_txn_count\", observations->''observations''->>''same_payee_same_amt_online_m15_txn_count'' as \"observations.same_payee_same_amt_online_m15_txn_count\", observations->''observations''->>''same_payee_online_m10_gteq250_txn_count'' as \"observations.same_payee_online_m10_gteq250_txn_count\", observations->''observations''->>''payee_account_d01_txn_value'' as \"observations.payee_account_d01_txn_value\", observations->''observations''->>''same_payee_acc_PT48H_txn_value'' as \"observations.same_payee_acc_PT48H_txn_value\", observations->''observations''->>''payee_acc_decline_less5k_m30_txn_count'' as \"observations.payee_acc_decline_less5k_m30_txn_count\", observations->''observations''->>''same_payee_online_PT24H_txn_value'' as \"observations.same_payee_online_PT24H_txn_value\", observations->''observations''->>''same_payer_payee_online_PT5M_txnPay_count'' as \"observations.same_payer_payee_online_PT5M_txnPay_count\", observations->''observations''->>''payer_decline_m30_txn_count'' as \"observations.payer_decline_m30_txn_count\", observations->''observations''->>''same_payer_payee_online_d01_txn_count'' as \"observations.same_payer_payee_online_d01_txn_count\", observations->''observations''->>''same_payer_payee_online_d01_txn_value'' as \"observations.same_payer_payee_online_d01_txn_value\" , rt.dttrxntime AS \"Txn Date Time\", rt.vcmsgid AS \"Txn ID\", rt.vcpayercustomerexternalid AS \"Payer Customer ID\", rt.vcpayeraccountexternalid AS \"Payer Account ID\", rt.vcpayeraddr AS \"Payer VPA ID\", rt.vcpayeecustomerexternalid AS \"Payee Customer ID\", rt.vcpayeeaccountexternalid AS \"Payee Account ID\", rt.vcpayeeaddr AS \"Payee VPA ID\", rt.vcclassname AS \"Txn Class\", rt.dobservationamount AS \"Txn Amount\", rt.vcdecisionname AS \"Decision Name\", rt.iruleid AS \"Rule ID\", rt.vcrulename AS \"Rule Name\", rt.rule_score AS \"Score\", rt.vcremark AS \"Side\" FROM transactions.rule_triggered rt left join analytics.trans l on l.ilivemessageid = rt.ilivemessageid WHERE rt.rule_score >= :RiskScore AND rt.dttrxntime BETWEEN :StartDate AND :EndDate and itenantid = :tenantid and rt.vcclassname = :Class order by rt.dttrxntime desc limit :Load",
            "Other": "select l.ilivemessageid as \"id\", observations->>''reqid'' as \"Request ID\", cast(observations->>''ts'' as timestamp with time zone) \"Timestamp\", result->>''msg'' as \"Remarks\", observations->>''org'' as \"Org\", result->>''status'' as \"Status\", observations->''txn''->>''id'' as \"Txn ID\", cast(observations->''txn''->>''ts'' as timestamp with time zone) as \"Txn Timestamp\", observations->''txn''->>''note'' as \"Note\", observations->''txn''->>''type'' as \"Type\", observations->''txn''->>''class'' as \"Class\", observations->''payee''->>''addr'' as \"Merchant addr\", observations->''payee''->''attribs''->''identity''->>''verified_name'' as \"Payee Name\", observations->''observations''->''payeeVPA''->>''payment_address'' as \"Payee VPA\", observations->''observations''->''payeeVPA''->''account''->>''accountName'' as \"Account Name\", observations->''observations''->''payeeVPA''->''account''->>''default_mcc'' as \"Default MCC\", observations->''payee''->>''mcc'' as \"MCC\", observations->''observations''->''payeeVPA''->''account''->''customer''->>''email'' as \"Payee email\", observations->''payer''->>''addr'' as \"Payer\", observations->''observations''->''payerVPA''->>''payment_address'' as \"Payer VPA\", observations->''observations''->''payerVPA''->>''vpaName'' as \"Payer Name\", observations->''payer''->''attribs''->''device''->>''ip'' as \"Payer IP\", result->''score''->>''score'' as \"Txn Score\", round(cast(observations->''payee''->>''amount'' as integer)/100, 2) as \"Txn Amount\", observations->''txn''->''attribs''->>''card_country_code'' as \"Card Country Code\", observations->''txn''->>''orgTxnId'' as \"Original Txn ID\", observations->''txn''->''attribs''->>''acquirer_name'' as \"Acquirer Name\", observations->''payee''->>''currency'' as \"Currency\", result->''score''->>''workflow'' as \"Workflow Type\", observations->''observations''->''decisionclass''->>''decisionName'' as \"Decision Name\", result->''score''->>''decisiondetails'' as \"Decision Detail\", observations->''observations''->>''new_payee'' as \"Is_New_Merchant\", observations->''observations''->>''new_payer'' as \"Is_New_Payer\", observations->''txn''->''attribs''->>''skip_processing'' as \"Skip Processing\", observations->''observations''->''ip_details''->>''country'' as \"ip_details.Country\", observations->''observations''->''ip_details''->''details''->>''postal_code'' as \"ip_details.PostalCode\", observations->''observations''->''ip_details''->''details''->>''adm3-city-town'' as \"ip_details.City\", observations->''observations''->''payeeVPA''->''account''->''customer''->''attribs''->>''city'' as \"observations.payeeVPA.account.customer.attribs.city\", observations->''observations''->>''same_payer_payee_acc_d01_txn_count'' as \"observations.same_payer_payee_acc_d01_txn_count\", observations->''observations''->>''same_payer_payee_acc_d01_txn_value'' as \"observations.same_payer_payee_acc_d01_txn_value\", observations->''observations''->>''payer_unique_payee_acc_online_d01_txn_count'' as \"observations.payer_unique_payee_acc_online_d01_txn_count\", observations->''observations''->>''payee_online_intl_card_m30_txn_count'' as \"observations.payee_online_intl_card_m30_txn_count\", observations->''observations''->>''same_payee_same_amt_online_m15_txn_count'' as \"observations.same_payee_same_amt_online_m15_txn_count\", observations->''observations''->>''same_payee_online_m10_gteq250_txn_count'' as \"observations.same_payee_online_m10_gteq250_txn_count\", observations->''observations''->>''payee_account_d01_txn_value'' as \"observations.payee_account_d01_txn_value\", observations->''observations''->>''same_payee_acc_PT48H_txn_value'' as \"observations.same_payee_acc_PT48H_txn_value\", observations->''observations''->>''payee_acc_decline_less5k_m30_txn_count'' as \"observations.payee_acc_decline_less5k_m30_txn_count\", observations->''observations''->>''same_payee_online_PT24H_txn_value'' as \"observations.same_payee_online_PT24H_txn_value\", observations->''observations''->>''same_payer_payee_online_PT5M_txnPay_count'' as \"observations.same_payer_payee_online_PT5M_txnPay_count\", observations->''observations''->>''payer_decline_m30_txn_count'' as \"observations.payer_decline_m30_txn_count\", observations->''observations''->>''same_payer_payee_online_d01_txn_count'' as \"observations.same_payer_payee_online_d01_txn_count\", observations->''observations''->>''same_payer_payee_online_d01_txn_value'' as \"observations.same_payer_payee_online_d01_txn_value\" , rt.dttrxntime AS \"Txn Date Time\", rt.vcmsgid AS \"Txn ID\", rt.vcpayercustomerexternalid AS \"Payer Customer ID\", rt.vcpayeraccountexternalid AS \"Payer Account ID\", rt.vcpayeraddr AS \"Payer VPA ID\", rt.vcpayeecustomerexternalid AS \"Payee Customer ID\", rt.vcpayeeaccountexternalid AS \"Payee Account ID\", rt.vcpayeeaddr AS \"Payee VPA ID\", rt.vcclassname AS \"Txn Class\", rt.dobservationamount AS \"Txn Amount\", rt.vcdecisionname AS \"Decision Name\", rt.iruleid AS \"Rule ID\", rt.vcrulename AS \"Rule Name\", rt.rule_score AS \"Score\", rt.vcremark AS \"Side\" FROM transactions.rule_triggered rt left join analytics.trans l on l.ilivemessageid = rt.ilivemessageid WHERE rt.rule_score >= :RiskScore AND rt.dttrxntime BETWEEN :StartDate AND :EndDate and itenantid = :tenantid and rt.vcrulename = :Rule and rt.vcclassname = :Class order by rt.dttrxntime desc limit :Load"
        },
        "Other": {
            "All" : "select l.ilivemessageid as \"id\", observations->>''reqid'' as \"Request ID\", cast(observations->>''ts'' as timestamp with time zone) \"Timestamp\", result->>''msg'' as \"Remarks\", observations->>''org'' as \"Org\", result->>''status'' as \"Status\", observations->''txn''->>''id'' as \"Txn ID\", cast(observations->''txn''->>''ts'' as timestamp with time zone) as \"Txn Timestamp\", observations->''txn''->>''note'' as \"Note\", observations->''txn''->>''type'' as \"Type\", observations->''txn''->>''class'' as \"Class\", observations->''payee''->>''addr'' as \"Merchant addr\", observations->''payee''->''attribs''->''identity''->>''verified_name'' as \"Payee Name\", observations->''observations''->''payeeVPA''->>''payment_address'' as \"Payee VPA\", observations->''observations''->''payeeVPA''->''account''->>''accountName'' as \"Account Name\", observations->''observations''->''payeeVPA''->''account''->>''default_mcc'' as \"Default MCC\", observations->''payee''->>''mcc'' as \"MCC\", observations->''observations''->''payeeVPA''->''account''->''customer''->>''email'' as \"Payee email\", observations->''payer''->>''addr'' as \"Payer\", observations->''observations''->''payerVPA''->>''payment_address'' as \"Payer VPA\", observations->''observations''->''payerVPA''->>''vpaName'' as \"Payer Name\", observations->''payer''->''attribs''->''device''->>''ip'' as \"Payer IP\", result->''score''->>''score'' as \"Txn Score\", round(cast(observations->''payee''->>''amount'' as integer)/100, 2) as \"Txn Amount\", observations->''txn''->''attribs''->>''card_country_code'' as \"Card Country Code\", observations->''txn''->>''orgTxnId'' as \"Original Txn ID\", observations->''txn''->''attribs''->>''acquirer_name'' as \"Acquirer Name\", observations->''payee''->>''currency'' as \"Currency\", result->''score''->>''workflow'' as \"Workflow Type\", observations->''observations''->''decisionclass''->>''decisionName'' as \"Decision Name\", result->''score''->>''decisiondetails'' as \"Decision Detail\", observations->''observations''->>''new_payee'' as \"Is_New_Merchant\", observations->''observations''->>''new_payer'' as \"Is_New_Payer\", observations->''txn''->''attribs''->>''skip_processing'' as \"Skip Processing\", observations->''observations''->''ip_details''->>''country'' as \"ip_details.Country\", observations->''observations''->''ip_details''->''details''->>''postal_code'' as \"ip_details.PostalCode\", observations->''observations''->''ip_details''->''details''->>''adm3-city-town'' as \"ip_details.City\", observations->''observations''->''payeeVPA''->''account''->''customer''->''attribs''->>''city'' as \"observations.payeeVPA.account.customer.attribs.city\", observations->''observations''->>''same_payer_payee_acc_d01_txn_count'' as \"observations.same_payer_payee_acc_d01_txn_count\", observations->''observations''->>''same_payer_payee_acc_d01_txn_value'' as \"observations.same_payer_payee_acc_d01_txn_value\", observations->''observations''->>''payer_unique_payee_acc_online_d01_txn_count'' as \"observations.payer_unique_payee_acc_online_d01_txn_count\", observations->''observations''->>''payee_online_intl_card_m30_txn_count'' as \"observations.payee_online_intl_card_m30_txn_count\", observations->''observations''->>''same_payee_same_amt_online_m15_txn_count'' as \"observations.same_payee_same_amt_online_m15_txn_count\", observations->''observations''->>''same_payee_online_m10_gteq250_txn_count'' as \"observations.same_payee_online_m10_gteq250_txn_count\", observations->''observations''->>''payee_account_d01_txn_value'' as \"observations.payee_account_d01_txn_value\", observations->''observations''->>''same_payee_acc_PT48H_txn_value'' as \"observations.same_payee_acc_PT48H_txn_value\", observations->''observations''->>''payee_acc_decline_less5k_m30_txn_count'' as \"observations.payee_acc_decline_less5k_m30_txn_count\", observations->''observations''->>''same_payee_online_PT24H_txn_value'' as \"observations.same_payee_online_PT24H_txn_value\", observations->''observations''->>''same_payer_payee_online_PT5M_txnPay_count'' as \"observations.same_payer_payee_online_PT5M_txnPay_count\", observations->''observations''->>''payer_decline_m30_txn_count'' as \"observations.payer_decline_m30_txn_count\", observations->''observations''->>''same_payer_payee_online_d01_txn_count'' as \"observations.same_payer_payee_online_d01_txn_count\", observations->''observations''->>''same_payer_payee_online_d01_txn_value'' as \"observations.same_payer_payee_online_d01_txn_value\" , rt.dttrxntime AS \"Txn Date Time\", rt.vcmsgid AS \"Txn ID\", rt.vcpayercustomerexternalid AS \"Payer Customer ID\", rt.vcpayeraccountexternalid AS \"Payer Account ID\", rt.vcpayeraddr AS \"Payer VPA ID\", rt.vcpayeecustomerexternalid AS \"Payee Customer ID\", rt.vcpayeeaccountexternalid AS \"Payee Account ID\", rt.vcpayeeaddr AS \"Payee VPA ID\", rt.vcclassname AS \"Txn Class\", rt.dobservationamount AS \"Txn Amount\", rt.vcdecisionname AS \"Decision Name\", rt.iruleid AS \"Rule ID\", rt.vcrulename AS \"Rule Name\", rt.rule_score AS \"Score\", rt.vcremark AS \"Side\" FROM transactions.rule_triggered rt left join analytics.trans l on l.ilivemessageid = rt.ilivemessageid WHERE rt.rule_score >= :RiskScore AND rt.dttrxntime BETWEEN :StartDate AND :EndDate and itenantid = :tenantid  and rt.vcdecisionname = :Decision and rt.vcclassname = :Class order by rt.dttrxntime desc limit :Load",
            "Other": "select l.ilivemessageid as \"id\", observations->>''reqid'' as \"Request ID\", cast(observations->>''ts'' as timestamp with time zone) \"Timestamp\", result->>''msg'' as \"Remarks\", observations->>''org'' as \"Org\", result->>''status'' as \"Status\", observations->''txn''->>''id'' as \"Txn ID\", cast(observations->''txn''->>''ts'' as timestamp with time zone) as \"Txn Timestamp\", observations->''txn''->>''note'' as \"Note\", observations->''txn''->>''type'' as \"Type\", observations->''txn''->>''class'' as \"Class\", observations->''payee''->>''addr'' as \"Merchant addr\", observations->''payee''->''attribs''->''identity''->>''verified_name'' as \"Payee Name\", observations->''observations''->''payeeVPA''->>''payment_address'' as \"Payee VPA\", observations->''observations''->''payeeVPA''->''account''->>''accountName'' as \"Account Name\", observations->''observations''->''payeeVPA''->''account''->>''default_mcc'' as \"Default MCC\", observations->''payee''->>''mcc'' as \"MCC\", observations->''observations''->''payeeVPA''->''account''->''customer''->>''email'' as \"Payee email\", observations->''payer''->>''addr'' as \"Payer\", observations->''observations''->''payerVPA''->>''payment_address'' as \"Payer VPA\", observations->''observations''->''payerVPA''->>''vpaName'' as \"Payer Name\", observations->''payer''->''attribs''->''device''->>''ip'' as \"Payer IP\", result->''score''->>''score'' as \"Txn Score\", round(cast(observations->''payee''->>''amount'' as integer)/100, 2) as \"Txn Amount\", observations->''txn''->''attribs''->>''card_country_code'' as \"Card Country Code\", observations->''txn''->>''orgTxnId'' as \"Original Txn ID\", observations->''txn''->''attribs''->>''acquirer_name'' as \"Acquirer Name\", observations->''payee''->>''currency'' as \"Currency\", result->''score''->>''workflow'' as \"Workflow Type\", observations->''observations''->''decisionclass''->>''decisionName'' as \"Decision Name\", result->''score''->>''decisiondetails'' as \"Decision Detail\", observations->''observations''->>''new_payee'' as \"Is_New_Merchant\", observations->''observations''->>''new_payer'' as \"Is_New_Payer\", observations->''txn''->''attribs''->>''skip_processing'' as \"Skip Processing\", observations->''observations''->''ip_details''->>''country'' as \"ip_details.Country\", observations->''observations''->''ip_details''->''details''->>''postal_code'' as \"ip_details.PostalCode\", observations->''observations''->''ip_details''->''details''->>''adm3-city-town'' as \"ip_details.City\", observations->''observations''->''payeeVPA''->''account''->''customer''->''attribs''->>''city'' as \"observations.payeeVPA.account.customer.attribs.city\", observations->''observations''->>''same_payer_payee_acc_d01_txn_count'' as \"observations.same_payer_payee_acc_d01_txn_count\", observations->''observations''->>''same_payer_payee_acc_d01_txn_value'' as \"observations.same_payer_payee_acc_d01_txn_value\", observations->''observations''->>''payer_unique_payee_acc_online_d01_txn_count'' as \"observations.payer_unique_payee_acc_online_d01_txn_count\", observations->''observations''->>''payee_online_intl_card_m30_txn_count'' as \"observations.payee_online_intl_card_m30_txn_count\", observations->''observations''->>''same_payee_same_amt_online_m15_txn_count'' as \"observations.same_payee_same_amt_online_m15_txn_count\", observations->''observations''->>''same_payee_online_m10_gteq250_txn_count'' as \"observations.same_payee_online_m10_gteq250_txn_count\", observations->''observations''->>''payee_account_d01_txn_value'' as \"observations.payee_account_d01_txn_value\", observations->''observations''->>''same_payee_acc_PT48H_txn_value'' as \"observations.same_payee_acc_PT48H_txn_value\", observations->''observations''->>''payee_acc_decline_less5k_m30_txn_count'' as \"observations.payee_acc_decline_less5k_m30_txn_count\", observations->''observations''->>''same_payee_online_PT24H_txn_value'' as \"observations.same_payee_online_PT24H_txn_value\", observations->''observations''->>''same_payer_payee_online_PT5M_txnPay_count'' as \"observations.same_payer_payee_online_PT5M_txnPay_count\", observations->''observations''->>''payer_decline_m30_txn_count'' as \"observations.payer_decline_m30_txn_count\", observations->''observations''->>''same_payer_payee_online_d01_txn_count'' as \"observations.same_payer_payee_online_d01_txn_count\", observations->''observations''->>''same_payer_payee_online_d01_txn_value'' as \"observations.same_payer_payee_online_d01_txn_value\" , rt.dttrxntime AS \"Txn Date Time\", rt.vcmsgid AS \"Txn ID\", rt.vcpayercustomerexternalid AS \"Payer Customer ID\", rt.vcpayeraccountexternalid AS \"Payer Account ID\", rt.vcpayeraddr AS \"Payer VPA ID\", rt.vcpayeecustomerexternalid AS \"Payee Customer ID\", rt.vcpayeeaccountexternalid AS \"Payee Account ID\", rt.vcpayeeaddr AS \"Payee VPA ID\", rt.vcclassname AS \"Txn Class\", rt.dobservationamount AS \"Txn Amount\", rt.vcdecisionname AS \"Decision Name\", rt.iruleid AS \"Rule ID\", rt.vcrulename AS \"Rule Name\", rt.rule_score AS \"Score\", rt.vcremark AS \"Side\" FROM transactions.rule_triggered rt left join analytics.trans l on l.ilivemessageid = rt.ilivemessageid WHERE rt.rule_score >= :RiskScore AND rt.dttrxntime BETWEEN :StartDate AND :EndDate and itenantid = :tenantid and rt.vcdecisionname = :Decision and rt.vcrulename = :Rule and rt.vcclassname = :Class order by rt.dttrxntime desc limit :Load"
        }
    }
}
'::text, false::boolean, true::boolean, false::boolean, '510'::integer)
 returning idashboardqueryid;


  INSERT INTO ui.dashboardquery (
  idashboardqueryid, bparametersrequired, vcdashboardquery, formattingrequiered, runonanalytics, transposerequired) VALUES (
  '91'::integer, false::boolean, 'SELECT X.* FROM   (VALUES (''up to 10'', 10), (''up to 100'', 100), (''up to 1000'', 1000), (''up to 10000'', 10000), (''up to 25000'', 25000)) AS X ("label", "value")'::text, false::boolean, false::boolean, false::boolean)
   returning idashboardqueryid;


 INSERT INTO ui.dashboardresultset (
 idashboardresultsetid, vcdashboardresultsetlayout, vcdashboardresultsetname, idashboardqueryid, idashboardid, vcdashboardresultsetschema, irowno, imenustructuredesc) VALUES (
 '48'::integer, '{
     "sizes": [
         1
     ],
     "detail": {
         "main": {
             "type": "tab-area",
             "widgets": [
                 "PERSPECTIVE_GENERATED_ID_1"
             ],
             "currentIndex": 0
         }
     },
     "mode": "globalFilters",
     "viewers": {
         "PERSPECTIVE_GENERATED_ID_1": {
             "plugin": "Datagrid",
             "plugin_config": {
                 "columns": {},
                 "editable": false,
                 "scroll_lock": false
             },
             "settings": false,
             "theme": "Pro Dark",
             "title": "Alerted Transactions",
             "group_by": [],
             "split_by": [],
             "columns": [],
             "filter": [],
             "sort": [],
             "expressions": [],
             "aggregates": {},
             "master": false,
             "table": "alertedtransactions",
             "linked": false
         }
     }
 }'::text, 'alertedtransactions'::character varying, '90'::integer, '40'::integer, '{
    "Txn Date Time" : "datetime",
    "Txn ID" : "string" ,
    "Payer Customer ID" : "string",
    "Payer Account ID" : "string",
    "Payer VPA ID" : "string",
    "Payee Customer ID" : "string",
    "Payee Account ID" : "string",
    "Payee VPA ID" : "string",
    "Txn Class" : "string",
    "Txn Amount" : "float",
    "Decision Name" : "string",
    "Rule ID" : "integer",
    "Rule Name" : "string" ,
    "Score" : "integer",
    "Side": "string",
    "id": "integer",
    "Request ID": "string",
    "Timestamp": "datetime",
    "Remarks": "string",
    "Org": "string",
    "Status": "string",
    "Txn ID": "string",
    "Txn Timestamp": "datetime",
    "Note": "string",
    "Type": "string",
    "Class": "string",
    "Merchant addr": "string",
    "Payee Name": "string",
    "Payee VPA": "string",
    "Account Name": "string",
    "Default MCC": "integer",
    "MCC": "integer",
    "Payee email": "string",
    "Payer": "string",
    "Payer VPA": "string",
    "Payer Name": "string",
    "Payer IP": "string",
    "Txn Score": "string",
    "Txn Amount": "float",
    "Card Country Code": "string",
    "Original Txn ID": "string",
    "Acquirer Name": "string",
    "Currency": "string",
    "Workflow Type": "string",
    "Decision Name": "string",
    "Decision Detail": "string",
    "Is_New_Merchant": "string",
    "Is_New_Payer": "string",
    "Skip Processing": "integer",
    "ip_details.Country": "string",
    "ip_details.PostalCode": "integer",
    "ip_details.City": "string",
    "observations.same_ip_addr_unique_payer_d01_txn_count": "integer",
    "observations.payeeVPA.account.customer.attribs.city": "integer",
    "observations.same_payer_payee_acc_d01_txn_count": "integer",
    "observations.same_payer_payee_acc_d01_txn_value": "integer",
    "observations.payer_unique_payee_acc_online_d01_txn_count": "integer",
    "observations.payee_online_intl_card_m30_txn_count": "integer",
    "observations.same_payee_same_amt_online_m15_txn_count": "integer",
    "observations.same_payee_online_m10_gteq250_txn_count": "integer",
    "observations.payee_account_d01_txn_value": "integer",
    "observations.same_payee_acc_PT48H_txn_value": "integer",
    "observations.payee_acc_decline_less5k_m30_txn_count": "integer",
    "observations.same_payee_online_PT24H_txn_value": "integer",
    "observations.same_payer_payee_online_PT5M_txnPay_count": "integer",
    "observations.payer_decline_m30_txn_count": "integer",
    "observations.same_payer_payee_online_d01_txn_count": "integer",
    "observations.same_payer_payee_online_d01_txn_value": "integer"
    }'::text, '1'::integer, '510'::integer)
  returning idashboardresultsetid;


INSERT INTO ui.dashboardfilters (
idashboardfilterid, ifilterorder, vcdashboardfiltername, idashboardid, vcdashboardfiltertype, vcdashboardfilterdisplayname, idashboardqueryidforoptions) VALUES (
'72'::integer, '5'::integer, 'Load'::character varying, '40'::integer, 'Select'::character varying, 'Load'::character varying, '91'::integer)
 returning idashboardfilterid;


 INSERT INTO ui.dashboardfilters (
 idashboardfilterid, ifilterorder, vcdashboardfiltername, idashboardid, vcdashboardfiltertype, vcdashboardfilterdisplayname) VALUES (
 '73'::integer, '3'::integer, 'RiskScore'::character varying, '40'::integer, 'Input'::character varying, 'Rule score (=>0)'::character varying)
  returning idashboardfilterid;

  INSERT INTO ui.dashboardfilters (
  idashboardfilterid, ifilterorder, vcdashboardfiltername, idashboardid, vcdashboardfiltertype, idashboardqueryidforoptions, vcdashboardfilterdisplayname) VALUES (
  '74'::integer, '4'::integer, 'Rule'::character varying, '40'::integer, 'Select'::character varying, '36'::integer, 'Rule'::character varying)
   returning idashboardfilterid;



   INSERT INTO ui.dashboardfilters (
   idashboardfilterid, ifilterorder, vcdashboardfiltername, idashboardid, vcdashboardfiltertype, idashboardqueryidforoptions, vcdashboardfilterdisplayname) VALUES (
   '75'::integer, '2'::integer, 'Decision'::character varying, '40'::integer, 'Select'::character varying, '35'::integer, 'Decision'::character varying)
    returning idashboardfilterid;

    INSERT INTO ui.dashboardfilters (
    idashboardfilterid, ifilterorder, vcdashboardfiltername, idashboardid, vcdashboardfiltertype, idashboardqueryidforoptions, vcdashboardfilterdisplayname) VALUES (
    '76'::integer, '1'::integer, 'Class'::character varying, '40'::integer, 'Select'::character varying, '34'::integer, 'Class'::character varying)
     returning idashboardfilterid;


     INSERT INTO ui.dashboardfilters (
     idashboardfilterid, ifilterorder, vcdashboardfiltername, idashboardid, vcdashboardfiltertype, idashboardqueryidfordefaultvalue, vcdashboardfilterdisplayname) VALUES (
     '77'::integer, '0'::integer, 'DateRange'::character varying, '40'::integer, 'DateRangePicker'::character varying, '79'::integer, 'Date Range'::character varying)
      returning idashboardfilterid;


INSERT INTO ui.dashboardqueryparameters (
idashboardparameterid, vcparametername, vcparametertype, idashboardqueryid) VALUES (
'146'::integer, 'Load'::character varying, 'Integer'::character varying, '90'::integer)
 returning idashboardparameterid;


INSERT INTO ui.dashboardqueryparameters (
idashboardparameterid, vcparametername, vcparametertype, idashboardqueryid) VALUES (
'147'::integer, 'RiskScore'::character varying, 'Integer'::character varying, '90'::integer)
 returning idashboardparameterid;


 INSERT INTO ui.dashboardqueryparameters (
 idashboardparameterid, vcparametername, vcparametertype, idashboardqueryid) VALUES (
 '148'::integer, 'DateRange'::character varying, 'DateRange'::character varying, '90'::integer)
  returning idashboardparameterid;

INSERT INTO ui.dashboardqueryparameters (
idashboardparameterid, vcparametername, vcparametertype, idashboardqueryid, iorder) VALUES (
'149'::integer, 'Rule'::character varying, 'JsonPath'::character varying, '90'::integer, '2'::integer)
 returning idashboardparameterid;


 INSERT INTO ui.dashboardqueryparameters (
 idashboardparameterid, vcparametername, vcparametertype, idashboardqueryid, iorder) VALUES (
 '150'::integer, 'Decision'::character varying, 'JsonPath'::character varying, '90'::integer, '1'::integer)
  returning idashboardparameterid;

 INSERT INTO ui.dashboardqueryparameters (
 idashboardparameterid, vcparametername, vcparametertype, idashboardqueryid, iorder) VALUES (
 '151'::integer, 'Class'::character varying, 'JsonPath'::character varying, '90'::integer, '0'::integer)
  returning idashboardparameterid;



 INSERT INTO ui.dashboard (
  idashboardid, bactive, bdelete, vcdashboardname, iorder, irowcount, imenustructuredesc) VALUES (
  '38'::integer, true::boolean, false::boolean, 'Daily Merchants Onboarded'::character varying, '38'::integer, '1'::integer, '577'::integer)
   returning idashboardid;

   INSERT INTO ui.dashboard (
   idashboardid, bactive, bdelete, vcdashboardname, iorder, irowcount, imenustructuredesc) VALUES (
   '39'::integer, true::boolean, false::boolean, 'Failed Transactions'::character varying, '39'::integer, '1'::integer, '577'::integer)
    returning idashboardid;


  INSERT INTO ui.dashboardquery (
  vcdashboardquery, vcfilterparametersjson, idashboardqueryid, bparametersrequired, formattingrequiered, runonanalytics, transposerequired, imenustructuredesc) VALUES (
  'SELECT  date(dtentrydatetime) as "Date",   count(1) as "Customers Onboarded"
  	FROM masters.customers where dtentrydatetime between :StartDate and :EndDate and itenantid = :tenantid GROUP BY date(dtentrydatetime);'::text, '{  "DateRange": null }'::text, '92'::integer, true::boolean, false::boolean, false::boolean, false::boolean, '577'::integer)
   returning idashboardqueryid;


    INSERT INTO ui.dashboardquery (
    idashboardqueryid, bparametersrequired, vcfilterparametersjson, vcdashboardquery, formattingrequiered, runonanalytics, transposerequired, imenustructuredesc) VALUES (
    '93'::integer, true::boolean, '{  "DateRange": null }'::text, 'select date(dtentrydatetime) as "Date", vcrequestid as "ReqID Failed to Process" from
    transactions.scorerequests
    left join analytics.trans on vcmsgid = vcrequestid
    WHERE vcrequestid not like ''pismo:%'' and vcrequestid not like ''unknown:%''
    and vcmsgid is null and itenantid = :tenantid
    and dtentrydatetime between :StartDate and :EndDate '::text, false::boolean, true::boolean, false::boolean, '577'::integer)
     returning idashboardqueryid;


     INSERT INTO ui.dashboardfilters (
     idashboardfilterid, ifilterorder, vcdashboardfiltername, idashboardid, vcdashboardfiltertype, idashboardqueryidfordefaultvalue, vcdashboardfilterdisplayname) VALUES (
     '71'::integer, '0'::integer, 'DateRange'::character varying, '38'::integer, 'DateRangePicker'::character varying, '79'::integer, 'Date Range'::character varying)
      returning idashboardfilterid;



      INSERT INTO ui.dashboardfilters (
      idashboardfilterid, ifilterorder, vcdashboardfiltername, idashboardid, vcdashboardfiltertype, idashboardqueryidfordefaultvalue, vcdashboardfilterdisplayname) VALUES (
      '70'::integer, '0'::integer, 'DateRange'::character varying, '39'::integer, 'DateRangePicker'::character varying, '79'::integer, 'Date Range'::character varying)
       returning idashboardfilterid;



INSERT INTO ui.dashboardqueryparameters (
idashboardparameterid, vcparametername, vcparametertype, idashboardqueryid) VALUES (
'145'::integer, 'DateRange'::character varying, 'DateRange'::character varying, '93'::integer)
 returning idashboardparameterid;

INSERT INTO ui.dashboardqueryparameters (
idashboardparameterid, vcparametername, vcparametertype, idashboardqueryid) VALUES (
'144'::integer, 'DateRange'::character varying, 'DateRange'::character varying, '92'::integer)
 returning idashboardparameterid;




 INSERT INTO ui.dashboardresultset (
 idashboardresultsetid, vcdashboardresultsetname, vcdashboardresultsetlayout, idashboardqueryid, idashboardid, vcdashboardresultsetschema, irowno, imenustructuredesc) VALUES (
 '47'::integer, 'dailymerchantsonboarded'::character varying, '{
     "sizes": [
         1
     ],
     "detail": {
         "main": {
             "type": "tab-area",
             "widgets": [
                 "PERSPECTIVE_GENERATED_ID_1"
             ],
             "currentIndex": 0
         }
     },
     "mode": "globalFilters",
     "viewers": {
         "PERSPECTIVE_GENERATED_ID_1": {
             "plugin": "Datagrid",
             "plugin_config": {
                 "columns": {},
                 "editable": false,
                 "scroll_lock": false
             },
             "settings": false,
             "theme": "Pro Dark",
             "title": "Daily Merchants Onboarded",
             "group_by": [],
             "split_by": [],
             "columns": [],
             "filter": [],
             "sort": [],
             "expressions": [],
             "aggregates": {},
             "master": false,
             "table": "dailymerchantsonboarded",
             "linked": false
         }
     }
 }
 {
     "sizes": [
         1
     ],
     "detail": {
         "main": {
             "type": "tab-area",
             "widgets": [
                 "PERSPECTIVE_GENERATED_ID_1"
             ],
             "currentIndex": 0
         }
     },
     "mode": "globalFilters",
     "viewers": {
         "PERSPECTIVE_GENERATED_ID_1": {
             "plugin": "Datagrid",
             "plugin_config": {
                 "columns": {},
                 "editable": false,
                 "scroll_lock": false
             },
             "settings": false,
             "theme": "Pro Dark",
             "title": "Daily Merchants Onboarded",
             "group_by": [],
             "split_by": [],
             "columns": [],
             "filter": [],
             "sort": [],
             "expressions": [],
             "aggregates": {},
             "master": false,
             "table": "dailymerchantsonboarded",
             "linked": false
         }
     }
 }
 '::text, '92'::integer, '38'::integer, '{
     "Date":"date",
     "Customers Onboarded":"integer"
 }
 '::text, '1'::integer, '577'::integer)
  returning idashboardresultsetid;



  INSERT INTO ui.dashboardresultset (
  idashboardresultsetid, vcdashboardresultsetlayout, vcdashboardresultsetname, idashboardqueryid, idashboardid, vcdashboardresultsetschema, irowno, imenustructuredesc) VALUES (
  '46'::integer, '{
      "sizes": [
          1
      ],
      "detail": {
          "main": {
              "type": "tab-area",
              "widgets": [
                  "PERSPECTIVE_GENERATED_ID_1"
              ],
              "currentIndex": 0
          }
      },
      "mode": "globalFilters",
      "viewers": {
          "PERSPECTIVE_GENERATED_ID_1": {
              "plugin": "Datagrid",
              "plugin_config": {
                  "columns": {},
                  "editable": false,
                  "scroll_lock": false
              },
              "settings": false,
              "theme": "Pro Dark",
              "title": "Failed Transactions",
              "group_by": [],
              "split_by": [],
              "columns": [],
              "filter": [],
              "sort": [],
              "expressions": [],
              "aggregates": {},
              "master": false,
              "table": "failedtransactions",
              "linked": false
          }
      }
  }'::text, 'failedtransactions'::character varying, '93'::integer, '39'::integer, '
  {
      "Date":"date",
      "ReqID Failed to Process":"string"
  }'::text, '1'::integer, '577'::integer)
   returning idashboardresultsetid;



   UPDATE ui.dashboardquery SET
   vcdashboardquery = 'select date(dtentrydatetime) as "Date", vcrequestid as "ReqID Failed to Process" from
   transactions.scorerequests
   left join analytics.trans on vcmsgid = vcrequestid
   WHERE vcrequestid not like ''pismo:%'' and vcrequestid not like ''unknown:%''
   and vcmsgid is null and itenantid = :tenantid
   and dtentrydatetime between :StartDate and :EndDate '::text WHERE
   idashboardqueryid = 93;



   UPDATE ui.dashboardquery SET
   vcdashboardquery = 'SELECT  date(dtentrydatetime) as "Date",   count(1) as "Customers Onboarded"
   	FROM masters.customers where dtentrydatetime between :StartDate and :EndDate and itenantid = :tenantid GROUP BY date(dtentrydatetime);'::text WHERE
   idashboardqueryid = 92;


   UPDATE ui.dashboardresultset SET
   vcdashboardresultsetlayout = '{
       "sizes": [
           1
       ],
       "detail": {
           "main": {
               "type": "tab-area",
               "widgets": [
                   "PERSPECTIVE_GENERATED_ID_1"
               ],
               "currentIndex": 0
           }
       },
       "mode": "globalFilters",
       "viewers": {
           "PERSPECTIVE_GENERATED_ID_1": {
               "plugin": "Datagrid",
               "plugin_config": {
                   "columns": {},
                   "editable": false,
                   "scroll_lock": false
               },
               "settings": false,
               "theme": "Pro Dark",=
               "title": "Daily Merchants Onboarded",
               "group_by": [],
               "split_by": [],
               "columns": [],
               "filter": [],
               "sort": [],
               "expressions": [],
               "aggregates": {},
               "master": false,
               "table": "dailymerchantsonboarded",
               "linked": false
           }
       }
   }'::text WHERE
   idashboardresultsetid = 47;



UPDATE ui.dashboardquery SET
vcdashboardquery = 'select
date(sr.dtentrydatetime) as "Date",
cast(vcrequestdata as json)->''txn''->>''class'' as "Class",
count(1) as "Txn Requests Received" ,
sum(case when tx.vcmsgid is null then 1 else 0 end ) as "Txns Failed to Process",
sum(case when tx.vcmsgid is null then 0 else 1 end ) as "Txns Processed Successfully"
from
transactions.scorerequests sr
left join analytics.trans tx on tx.vcmsgid = sr.vcrequestid
WHERE vcrequestid not like ''pismo:%'' and vcrequestid not like ''unknown:%'' and sr.dtentrydatetime between :StartDate and :EndDate and itenantid = :tenantid
group by cast(sr.dtentrydatetime as date), cast(vcrequestdata as json)->''txn''->>''class'';'::text WHERE
idashboardqueryid = 80;

UPDATE ui.dashboardresultset SET
vcdashboardresultsetschema = '{"Date":"date", "Class":"string", "Txn Requests Received":"integer","Txns Failed to Process":"integer","Txns Processed Successfully":"integer" }'::text WHERE
idashboardresultsetid = 35;



----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------



INSERT INTO ui.dashboard (
idashboardid, bactive, bdelete, vcdashboardname, iorder, irowcount, imenustructuredesc, itenantid) VALUES (
'47'::integer, true::boolean, false::boolean, 'Transaction'::character varying, '1'::integer, '1'::integer, '510'::integer, '4'::integer)
 returning idashboardid;



INSERT INTO ui.dashboardfilters (
idashboardfilterid, ifilterorder, vcdashboardfiltername, idashboardid, vcdashboardfiltertype, vcdashboardfilterdisplayname, idashboardqueryidforoptions) VALUES (
(select max(idashboardfilterid)+1 from ui.dashboardfilters), '2'::integer, 'Type'::character varying, '47'::integer, 'Select'::character varying, 'Type'::character varying, '25'::integer)
 returning idashboardfilterid;


 INSERT INTO ui.dashboardfilters (
idashboardfilterid, ifilterorder, vcdashboardfiltername, idashboardid, vcdashboardfiltertype, vcdashboardfilterdisplayname, idashboardqueryidforoptions) VALUES (
(select max(idashboardfilterid)+1 from ui.dashboardfilters), '1'::integer, 'Party'::character varying, '47'::integer, 'Select'::character varying, 'Level'::character varying, '27'::integer)
 returning idashboardfilterid;


 INSERT INTO ui.dashboardfilters (
idashboardfilterid, ifilterorder, vcdashboardfiltername, idashboardid, vcdashboardfiltertype, vcdashboardfilterdisplayname) VALUES (
(select max(idashboardfilterid)+1 from ui.dashboardfilters), '3'::integer, 'VpaAddress'::character varying, '47'::integer, 'Input'::character varying, 'Address'::character varying)
 returning idashboardfilterid;

     INSERT INTO ui.dashboardfilters (
     idashboardfilterid, ifilterorder, vcdashboardfiltername, idashboardid, vcdashboardfiltertype, idashboardqueryidfordefaultvalue, vcdashboardfilterdisplayname) VALUES (
     (select max(idashboardfilterid)+1 from ui.dashboardfilters), '0'::integer, 'DateRange'::character varying, '47'::integer, 'DateRangePicker'::character varying, '16'::integer, 'Date Range'::character varying)
      returning idashboardfilterid;


INSERT INTO ui.dashboardquery (
idashboardqueryid, bparametersrequired, vcfilterparametersjson, vcdashboardquery, formattingrequiered, runonanalytics, transposerequired, imenustructuredesc) VALUES (
'100'::integer, true::boolean, '{"DateRange" : null, "VpaAddress":null, "Type":null, "Party": null}'::text, '{
    "Account": {
        "Payer": "select ilivemessageid as \"id\", observations->>''reqid'' as \"Request ID\", cast(observations->>''ts'' as timestamp with time zone) \"Timestamp\", result->>''msg'' as \"Remarks\", observations->>''org'' as \"Org\", result->>''status'' as \"Status\", observations->''txn''->>''id'' as \"Txn ID\", cast(observations->''txn''->>''ts'' as timestamp with time zone) as \"Txn Timestamp\", observations->''txn''->>''note'' as \"Note\", observations->''txn''->>''type'' as \"Type\", observations->''txn''->>''class'' as \"Class\", observations->''payee''->>''addr'' as \"Merchant addr\", observations->''payee''->''attribs''->''identity''->>''verified_name'' as \"Payee Name\", observations->''observations''->''payeeVPA''->>''payment_address'' as \"Payee VPA\", observations->''observations''->''payeeVPA''->''account''->>''accountName'' as \"Account Name\", observations->''observations''->''payeeVPA''->''account''->>''default_mcc'' as \"Default MCC\", observations->''payee''->>''mcc'' as \"MCC\", observations->''observations''->''payeeVPA''->''account''->''customer''->>''email'' as \"Payee email\", observations->''payer''->>''addr'' as \"Payer\", observations->''observations''->''payerVPA''->>''payment_address'' as \"Payer VPA\", observations->''observations''->''payerVPA''->>''vpaName'' as \"Payer Name\", observations->''payer''->''attribs''->''device''->>''ip'' as \"Payer IP\", result->''score''->>''score'' as \"Txn Score\", round(cast(observations->''payee''->>''amount'' as integer)/100, 2) as \"Txn Amount\", observations->''txn''->''attribs''->>''card_country_code'' as \"Card Country Code\", observations->''txn''->>''orgTxnId'' as \"Original Txn ID\", observations->''txn''->''attribs''->>''acquirer_name'' as \"Acquirer Name\", observations->''payee''->>''currency'' as \"Currency\", result->''score''->>''workflow'' as \"Workflow Type\", observations->''observations''->''decisionclass''->>''decisionName'' as \"Decision Name\", result->''score''->>''decisiondetails'' as \"Decision Detail\", observations->''observations''->>''new_payee'' as \"Is_New_Merchant\", observations->''observations''->>''new_payer'' as \"Is_New_Payer\", observations->''txn''->''attribs''->>''skip_processing'' as \"Skip Processing\", observations->''observations''->''ip_details''->>''country'' as \"ip_details.Country\", observations->''observations''->''ip_details''->''details''->>''postal_code'' as \"ip_details.PostalCode\", observations->''observations''->''ip_details''->''details''->>''adm3-city-town'' as \"ip_details.City\", observations->''observations''->''payeeVPA''->''account''->''customer''->''attribs''->>''city'' as \"observations.payeeVPA.account.customer.attribs.city\", observations->''observations''->>''same_payer_payee_acc_d01_txn_count'' as \"observations.same_payer_payee_acc_d01_txn_count\", observations->''observations''->>''same_payer_payee_acc_d01_txn_value'' as \"observations.same_payer_payee_acc_d01_txn_value\", observations->''observations''->>''payer_unique_payee_acc_online_d01_txn_count'' as \"observations.payer_unique_payee_acc_online_d01_txn_count\", observations->''observations''->>''payee_online_intl_card_m30_txn_count'' as \"observations.payee_online_intl_card_m30_txn_count\", observations->''observations''->>''same_payee_same_amt_online_m15_txn_count'' as \"observations.same_payee_same_amt_online_m15_txn_count\", observations->''observations''->>''same_payee_online_m10_gteq250_txn_count'' as \"observations.same_payee_online_m10_gteq250_txn_count\", observations->''observations''->>''payee_account_d01_txn_value'' as \"observations.payee_account_d01_txn_value\", observations->''observations''->>''same_payee_acc_PT48H_txn_value'' as \"observations.same_payee_acc_PT48H_txn_value\", observations->''observations''->>''payee_acc_decline_less5k_m30_txn_count'' as \"observations.payee_acc_decline_less5k_m30_txn_count\", observations->''observations''->>''same_payee_online_PT24H_txn_value'' as \"observations.same_payee_online_PT24H_txn_value\", observations->''observations''->>''same_payer_payee_online_PT5M_txnPay_count'' as \"observations.same_payer_payee_online_PT5M_txnPay_count\", observations->''observations''->>''payer_decline_m30_txn_count'' as \"observations.payer_decline_m30_txn_count\", observations->''observations''->>''same_payer_payee_online_d01_txn_count'' as \"observations.same_payer_payee_online_d01_txn_count\", observations->''observations''->>''same_payer_payee_online_d01_txn_value'' as \"observations.same_payer_payee_online_d01_txn_value\" from analytics.trans l where  l.vcpayeraccountexternalid = :VpaAddress  and  dttrxntime between :StartDate  and :EndDate and itenantid = :tenantid  order by dttrxntime desc limit 50000",
        "Payee": "select ilivemessageid as \"id\", observations->>''reqid'' as \"Request ID\", cast(observations->>''ts'' as timestamp with time zone) \"Timestamp\", result->>''msg'' as \"Remarks\", observations->>''org'' as \"Org\", result->>''status'' as \"Status\", observations->''txn''->>''id'' as \"Txn ID\", cast(observations->''txn''->>''ts'' as timestamp with time zone) as \"Txn Timestamp\", observations->''txn''->>''note'' as \"Note\", observations->''txn''->>''type'' as \"Type\", observations->''txn''->>''class'' as \"Class\", observations->''payee''->>''addr'' as \"Merchant addr\", observations->''payee''->''attribs''->''identity''->>''verified_name'' as \"Payee Name\", observations->''observations''->''payeeVPA''->>''payment_address'' as \"Payee VPA\", observations->''observations''->''payeeVPA''->''account''->>''accountName'' as \"Account Name\", observations->''observations''->''payeeVPA''->''account''->>''default_mcc'' as \"Default MCC\", observations->''payee''->>''mcc'' as \"MCC\", observations->''observations''->''payeeVPA''->''account''->''customer''->>''email'' as \"Payee email\", observations->''payer''->>''addr'' as \"Payer\", observations->''observations''->''payerVPA''->>''payment_address'' as \"Payer VPA\", observations->''observations''->''payerVPA''->>''vpaName'' as \"Payer Name\", observations->''payer''->''attribs''->''device''->>''ip'' as \"Payer IP\", result->''score''->>''score'' as \"Txn Score\", round(cast(observations->''payee''->>''amount'' as integer)/100, 2) as \"Txn Amount\", observations->''txn''->''attribs''->>''card_country_code'' as \"Card Country Code\", observations->''txn''->>''orgTxnId'' as \"Original Txn ID\", observations->''txn''->''attribs''->>''acquirer_name'' as \"Acquirer Name\", observations->''payee''->>''currency'' as \"Currency\", result->''score''->>''workflow'' as \"Workflow Type\", observations->''observations''->''decisionclass''->>''decisionName'' as \"Decision Name\", result->''score''->>''decisiondetails'' as \"Decision Detail\", observations->''observations''->>''new_payee'' as \"Is_New_Merchant\", observations->''observations''->>''new_payer'' as \"Is_New_Payer\", observations->''txn''->''attribs''->>''skip_processing'' as \"Skip Processing\", observations->''observations''->''ip_details''->>''country'' as \"ip_details.Country\", observations->''observations''->''ip_details''->''details''->>''postal_code'' as \"ip_details.PostalCode\", observations->''observations''->''ip_details''->''details''->>''adm3-city-town'' as \"ip_details.City\", observations->''observations''->''payeeVPA''->''account''->''customer''->''attribs''->>''city'' as \"observations.payeeVPA.account.customer.attribs.city\", observations->''observations''->>''same_payer_payee_acc_d01_txn_count'' as \"observations.same_payer_payee_acc_d01_txn_count\", observations->''observations''->>''same_payer_payee_acc_d01_txn_value'' as \"observations.same_payer_payee_acc_d01_txn_value\", observations->''observations''->>''payer_unique_payee_acc_online_d01_txn_count'' as \"observations.payer_unique_payee_acc_online_d01_txn_count\", observations->''observations''->>''payee_online_intl_card_m30_txn_count'' as \"observations.payee_online_intl_card_m30_txn_count\", observations->''observations''->>''same_payee_same_amt_online_m15_txn_count'' as \"observations.same_payee_same_amt_online_m15_txn_count\", observations->''observations''->>''same_payee_online_m10_gteq250_txn_count'' as \"observations.same_payee_online_m10_gteq250_txn_count\", observations->''observations''->>''payee_account_d01_txn_value'' as \"observations.payee_account_d01_txn_value\", observations->''observations''->>''same_payee_acc_PT48H_txn_value'' as \"observations.same_payee_acc_PT48H_txn_value\", observations->''observations''->>''payee_acc_decline_less5k_m30_txn_count'' as \"observations.payee_acc_decline_less5k_m30_txn_count\", observations->''observations''->>''same_payee_online_PT24H_txn_value'' as \"observations.same_payee_online_PT24H_txn_value\", observations->''observations''->>''same_payer_payee_online_PT5M_txnPay_count'' as \"observations.same_payer_payee_online_PT5M_txnPay_count\", observations->''observations''->>''payer_decline_m30_txn_count'' as \"observations.payer_decline_m30_txn_count\", observations->''observations''->>''same_payer_payee_online_d01_txn_count'' as \"observations.same_payer_payee_online_d01_txn_count\", observations->''observations''->>''same_payer_payee_online_d01_txn_value'' as \"observations.same_payer_payee_online_d01_txn_value\" from analytics.trans l where l.vcpayeeaccountexternalid = :VpaAddress  and dttrxntime between :StartDate and  :EndDate and itenantid = :tenantid  order by dttrxntime desc limit 50000",
        "Both": "select ilivemessageid as \"id\", observations->>''reqid'' as \"Request ID\", cast(observations->>''ts'' as timestamp with time zone) \"Timestamp\", result->>''msg'' as \"Remarks\", observations->>''org'' as \"Org\", result->>''status'' as \"Status\", observations->''txn''->>''id'' as \"Txn ID\", cast(observations->''txn''->>''ts'' as timestamp with time zone) as \"Txn Timestamp\", observations->''txn''->>''note'' as \"Note\", observations->''txn''->>''type'' as \"Type\", observations->''txn''->>''class'' as \"Class\", observations->''payee''->>''addr'' as \"Merchant addr\", observations->''payee''->''attribs''->''identity''->>''verified_name'' as \"Payee Name\", observations->''observations''->''payeeVPA''->>''payment_address'' as \"Payee VPA\", observations->''observations''->''payeeVPA''->''account''->>''accountName'' as \"Account Name\", observations->''observations''->''payeeVPA''->''account''->>''default_mcc'' as \"Default MCC\", observations->''payee''->>''mcc'' as \"MCC\", observations->''observations''->''payeeVPA''->''account''->''customer''->>''email'' as \"Payee email\", observations->''payer''->>''addr'' as \"Payer\", observations->''observations''->''payerVPA''->>''payment_address'' as \"Payer VPA\", observations->''observations''->''payerVPA''->>''vpaName'' as \"Payer Name\", observations->''payer''->''attribs''->''device''->>''ip'' as \"Payer IP\", result->''score''->>''score'' as \"Txn Score\", round(cast(observations->''payee''->>''amount'' as integer)/100, 2) as \"Txn Amount\", observations->''txn''->''attribs''->>''card_country_code'' as \"Card Country Code\", observations->''txn''->>''orgTxnId'' as \"Original Txn ID\", observations->''txn''->''attribs''->>''acquirer_name'' as \"Acquirer Name\", observations->''payee''->>''currency'' as \"Currency\", result->''score''->>''workflow'' as \"Workflow Type\", observations->''observations''->''decisionclass''->>''decisionName'' as \"Decision Name\", result->''score''->>''decisiondetails'' as \"Decision Detail\", observations->''observations''->>''new_payee'' as \"Is_New_Merchant\", observations->''observations''->>''new_payer'' as \"Is_New_Payer\", observations->''txn''->''attribs''->>''skip_processing'' as \"Skip Processing\", observations->''observations''->''ip_details''->>''country'' as \"ip_details.Country\", observations->''observations''->''ip_details''->''details''->>''postal_code'' as \"ip_details.PostalCode\", observations->''observations''->''ip_details''->''details''->>''adm3-city-town'' as \"ip_details.City\", observations->''observations''->''payeeVPA''->''account''->''customer''->''attribs''->>''city'' as \"observations.payeeVPA.account.customer.attribs.city\", observations->''observations''->>''same_payer_payee_acc_d01_txn_count'' as \"observations.same_payer_payee_acc_d01_txn_count\", observations->''observations''->>''same_payer_payee_acc_d01_txn_value'' as \"observations.same_payer_payee_acc_d01_txn_value\", observations->''observations''->>''payer_unique_payee_acc_online_d01_txn_count'' as \"observations.payer_unique_payee_acc_online_d01_txn_count\", observations->''observations''->>''payee_online_intl_card_m30_txn_count'' as \"observations.payee_online_intl_card_m30_txn_count\", observations->''observations''->>''same_payee_same_amt_online_m15_txn_count'' as \"observations.same_payee_same_amt_online_m15_txn_count\", observations->''observations''->>''same_payee_online_m10_gteq250_txn_count'' as \"observations.same_payee_online_m10_gteq250_txn_count\", observations->''observations''->>''payee_account_d01_txn_value'' as \"observations.payee_account_d01_txn_value\", observations->''observations''->>''same_payee_acc_PT48H_txn_value'' as \"observations.same_payee_acc_PT48H_txn_value\", observations->''observations''->>''payee_acc_decline_less5k_m30_txn_count'' as \"observations.payee_acc_decline_less5k_m30_txn_count\", observations->''observations''->>''same_payee_online_PT24H_txn_value'' as \"observations.same_payee_online_PT24H_txn_value\", observations->''observations''->>''same_payer_payee_online_PT5M_txnPay_count'' as \"observations.same_payer_payee_online_PT5M_txnPay_count\", observations->''observations''->>''payer_decline_m30_txn_count'' as \"observations.payer_decline_m30_txn_count\", observations->''observations''->>''same_payer_payee_online_d01_txn_count'' as \"observations.same_payer_payee_online_d01_txn_count\", observations->''observations''->>''same_payer_payee_online_d01_txn_value'' as \"observations.same_payer_payee_online_d01_txn_value\" from analytics.trans l where (l.vcpayeraccountexternalid = :VpaAddress or l.vcpayeeaccountexternalid=:VpaAddress ) and  dttrxntime  between :StartDate  and  :EndDate and itenantid = :tenantid   order by dttrxntime desc limit 50000"
    },
    "VPA": {
        "Payer": "select ilivemessageid as \"id\", observations->>''reqid'' as \"Request ID\", cast(observations->>''ts'' as timestamp with time zone) \"Timestamp\", result->>''msg'' as \"Remarks\", observations->>''org'' as \"Org\", result->>''status'' as \"Status\", observations->''txn''->>''id'' as \"Txn ID\", cast(observations->''txn''->>''ts'' as timestamp with time zone) as \"Txn Timestamp\", observations->''txn''->>''note'' as \"Note\", observations->''txn''->>''type'' as \"Type\", observations->''txn''->>''class'' as \"Class\", observations->''payee''->>''addr'' as \"Merchant addr\", observations->''payee''->''attribs''->''identity''->>''verified_name'' as \"Payee Name\", observations->''observations''->''payeeVPA''->>''payment_address'' as \"Payee VPA\", observations->''observations''->''payeeVPA''->''account''->>''accountName'' as \"Account Name\", observations->''observations''->''payeeVPA''->''account''->>''default_mcc'' as \"Default MCC\", observations->''payee''->>''mcc'' as \"MCC\", observations->''observations''->''payeeVPA''->''account''->''customer''->>''email'' as \"Payee email\", observations->''payer''->>''addr'' as \"Payer\", observations->''observations''->''payerVPA''->>''payment_address'' as \"Payer VPA\", observations->''observations''->''payerVPA''->>''vpaName'' as \"Payer Name\", observations->''payer''->''attribs''->''device''->>''ip'' as \"Payer IP\", result->''score''->>''score'' as \"Txn Score\", round(cast(observations->''payee''->>''amount'' as integer)/100, 2) as \"Txn Amount\", observations->''txn''->''attribs''->>''card_country_code'' as \"Card Country Code\", observations->''txn''->>''orgTxnId'' as \"Original Txn ID\", observations->''txn''->''attribs''->>''acquirer_name'' as \"Acquirer Name\", observations->''payee''->>''currency'' as \"Currency\", result->''score''->>''workflow'' as \"Workflow Type\", observations->''observations''->''decisionclass''->>''decisionName'' as \"Decision Name\", result->''score''->>''decisiondetails'' as \"Decision Detail\", observations->''observations''->>''new_payee'' as \"Is_New_Merchant\", observations->''observations''->>''new_payer'' as \"Is_New_Payer\", observations->''txn''->''attribs''->>''skip_processing'' as \"Skip Processing\", observations->''observations''->''ip_details''->>''country'' as \"ip_details.Country\", observations->''observations''->''ip_details''->''details''->>''postal_code'' as \"ip_details.PostalCode\", observations->''observations''->''ip_details''->''details''->>''adm3-city-town'' as \"ip_details.City\", observations->''observations''->''payeeVPA''->''account''->''customer''->''attribs''->>''city'' as \"observations.payeeVPA.account.customer.attribs.city\", observations->''observations''->>''same_payer_payee_acc_d01_txn_count'' as \"observations.same_payer_payee_acc_d01_txn_count\", observations->''observations''->>''same_payer_payee_acc_d01_txn_value'' as \"observations.same_payer_payee_acc_d01_txn_value\", observations->''observations''->>''payer_unique_payee_acc_online_d01_txn_count'' as \"observations.payer_unique_payee_acc_online_d01_txn_count\", observations->''observations''->>''payee_online_intl_card_m30_txn_count'' as \"observations.payee_online_intl_card_m30_txn_count\", observations->''observations''->>''same_payee_same_amt_online_m15_txn_count'' as \"observations.same_payee_same_amt_online_m15_txn_count\", observations->''observations''->>''same_payee_online_m10_gteq250_txn_count'' as \"observations.same_payee_online_m10_gteq250_txn_count\", observations->''observations''->>''payee_account_d01_txn_value'' as \"observations.payee_account_d01_txn_value\", observations->''observations''->>''same_payee_acc_PT48H_txn_value'' as \"observations.same_payee_acc_PT48H_txn_value\", observations->''observations''->>''payee_acc_decline_less5k_m30_txn_count'' as \"observations.payee_acc_decline_less5k_m30_txn_count\", observations->''observations''->>''same_payee_online_PT24H_txn_value'' as \"observations.same_payee_online_PT24H_txn_value\", observations->''observations''->>''same_payer_payee_online_PT5M_txnPay_count'' as \"observations.same_payer_payee_online_PT5M_txnPay_count\", observations->''observations''->>''payer_decline_m30_txn_count'' as \"observations.payer_decline_m30_txn_count\", observations->''observations''->>''same_payer_payee_online_d01_txn_count'' as \"observations.same_payer_payee_online_d01_txn_count\", observations->''observations''->>''same_payer_payee_online_d01_txn_value'' as \"observations.same_payer_payee_online_d01_txn_value\" from analytics.trans l where l.vcpayeraddr = :VpaAddress  and  dttrxntime  between :StartDate and :EndDate and itenantid = :tenantid  order by dttrxntime desc limit 50000",
        "Payee": "select ilivemessageid as \"id\", observations->>''reqid'' as \"Request ID\", cast(observations->>''ts'' as timestamp with time zone) \"Timestamp\", result->>''msg'' as \"Remarks\", observations->>''org'' as \"Org\", result->>''status'' as \"Status\", observations->''txn''->>''id'' as \"Txn ID\", cast(observations->''txn''->>''ts'' as timestamp with time zone) as \"Txn Timestamp\", observations->''txn''->>''note'' as \"Note\", observations->''txn''->>''type'' as \"Type\", observations->''txn''->>''class'' as \"Class\", observations->''payee''->>''addr'' as \"Merchant addr\", observations->''payee''->''attribs''->''identity''->>''verified_name'' as \"Payee Name\", observations->''observations''->''payeeVPA''->>''payment_address'' as \"Payee VPA\", observations->''observations''->''payeeVPA''->''account''->>''accountName'' as \"Account Name\", observations->''observations''->''payeeVPA''->''account''->>''default_mcc'' as \"Default MCC\", observations->''payee''->>''mcc'' as \"MCC\", observations->''observations''->''payeeVPA''->''account''->''customer''->>''email'' as \"Payee email\", observations->''payer''->>''addr'' as \"Payer\", observations->''observations''->''payerVPA''->>''payment_address'' as \"Payer VPA\", observations->''observations''->''payerVPA''->>''vpaName'' as \"Payer Name\", observations->''payer''->''attribs''->''device''->>''ip'' as \"Payer IP\", result->''score''->>''score'' as \"Txn Score\", round(cast(observations->''payee''->>''amount'' as integer)/100, 2) as \"Txn Amount\", observations->''txn''->''attribs''->>''card_country_code'' as \"Card Country Code\", observations->''txn''->>''orgTxnId'' as \"Original Txn ID\", observations->''txn''->''attribs''->>''acquirer_name'' as \"Acquirer Name\", observations->''payee''->>''currency'' as \"Currency\", result->''score''->>''workflow'' as \"Workflow Type\", observations->''observations''->''decisionclass''->>''decisionName'' as \"Decision Name\", result->''score''->>''decisiondetails'' as \"Decision Detail\", observations->''observations''->>''new_payee'' as \"Is_New_Merchant\", observations->''observations''->>''new_payer'' as \"Is_New_Payer\", observations->''txn''->''attribs''->>''skip_processing'' as \"Skip Processing\", observations->''observations''->''ip_details''->>''country'' as \"ip_details.Country\", observations->''observations''->''ip_details''->''details''->>''postal_code'' as \"ip_details.PostalCode\", observations->''observations''->''ip_details''->''details''->>''adm3-city-town'' as \"ip_details.City\", observations->''observations''->''payeeVPA''->''account''->''customer''->''attribs''->>''city'' as \"observations.payeeVPA.account.customer.attribs.city\", observations->''observations''->>''same_payer_payee_acc_d01_txn_count'' as \"observations.same_payer_payee_acc_d01_txn_count\", observations->''observations''->>''same_payer_payee_acc_d01_txn_value'' as \"observations.same_payer_payee_acc_d01_txn_value\", observations->''observations''->>''payer_unique_payee_acc_online_d01_txn_count'' as \"observations.payer_unique_payee_acc_online_d01_txn_count\", observations->''observations''->>''payee_online_intl_card_m30_txn_count'' as \"observations.payee_online_intl_card_m30_txn_count\", observations->''observations''->>''same_payee_same_amt_online_m15_txn_count'' as \"observations.same_payee_same_amt_online_m15_txn_count\", observations->''observations''->>''same_payee_online_m10_gteq250_txn_count'' as \"observations.same_payee_online_m10_gteq250_txn_count\", observations->''observations''->>''payee_account_d01_txn_value'' as \"observations.payee_account_d01_txn_value\", observations->''observations''->>''same_payee_acc_PT48H_txn_value'' as \"observations.same_payee_acc_PT48H_txn_value\", observations->''observations''->>''payee_acc_decline_less5k_m30_txn_count'' as \"observations.payee_acc_decline_less5k_m30_txn_count\", observations->''observations''->>''same_payee_online_PT24H_txn_value'' as \"observations.same_payee_online_PT24H_txn_value\", observations->''observations''->>''same_payer_payee_online_PT5M_txnPay_count'' as \"observations.same_payer_payee_online_PT5M_txnPay_count\", observations->''observations''->>''payer_decline_m30_txn_count'' as \"observations.payer_decline_m30_txn_count\", observations->''observations''->>''same_payer_payee_online_d01_txn_count'' as \"observations.same_payer_payee_online_d01_txn_count\", observations->''observations''->>''same_payer_payee_online_d01_txn_value'' as \"observations.same_payer_payee_online_d01_txn_value\" from analytics.trans l where l.vcpayeeaddr = :VpaAddress  and dttrxntime between :StartDate  and :EndDate and itenantid = :tenantid  order by dttrxntime desc limit 50000",
        "Both": "select ilivemessageid as \"id\", observations->>''reqid'' as \"Request ID\", cast(observations->>''ts'' as timestamp with time zone) \"Timestamp\", result->>''msg'' as \"Remarks\", observations->>''org'' as \"Org\", result->>''status'' as \"Status\", observations->''txn''->>''id'' as \"Txn ID\", cast(observations->''txn''->>''ts'' as timestamp with time zone) as \"Txn Timestamp\", observations->''txn''->>''note'' as \"Note\", observations->''txn''->>''type'' as \"Type\", observations->''txn''->>''class'' as \"Class\", observations->''payee''->>''addr'' as \"Merchant addr\", observations->''payee''->''attribs''->''identity''->>''verified_name'' as \"Payee Name\", observations->''observations''->''payeeVPA''->>''payment_address'' as \"Payee VPA\", observations->''observations''->''payeeVPA''->''account''->>''accountName'' as \"Account Name\", observations->''observations''->''payeeVPA''->''account''->>''default_mcc'' as \"Default MCC\", observations->''payee''->>''mcc'' as \"MCC\", observations->''observations''->''payeeVPA''->''account''->''customer''->>''email'' as \"Payee email\", observations->''payer''->>''addr'' as \"Payer\", observations->''observations''->''payerVPA''->>''payment_address'' as \"Payer VPA\", observations->''observations''->''payerVPA''->>''vpaName'' as \"Payer Name\", observations->''payer''->''attribs''->''device''->>''ip'' as \"Payer IP\", result->''score''->>''score'' as \"Txn Score\", round(cast(observations->''payee''->>''amount'' as integer)/100, 2) as \"Txn Amount\", observations->''txn''->''attribs''->>''card_country_code'' as \"Card Country Code\", observations->''txn''->>''orgTxnId'' as \"Original Txn ID\", observations->''txn''->''attribs''->>''acquirer_name'' as \"Acquirer Name\", observations->''payee''->>''currency'' as \"Currency\", result->''score''->>''workflow'' as \"Workflow Type\", observations->''observations''->''decisionclass''->>''decisionName'' as \"Decision Name\", result->''score''->>''decisiondetails'' as \"Decision Detail\", observations->''observations''->>''new_payee'' as \"Is_New_Merchant\", observations->''observations''->>''new_payer'' as \"Is_New_Payer\", observations->''txn''->''attribs''->>''skip_processing'' as \"Skip Processing\", observations->''observations''->''ip_details''->>''country'' as \"ip_details.Country\", observations->''observations''->''ip_details''->''details''->>''postal_code'' as \"ip_details.PostalCode\", observations->''observations''->''ip_details''->''details''->>''adm3-city-town'' as \"ip_details.City\", observations->''observations''->''payeeVPA''->''account''->''customer''->''attribs''->>''city'' as \"observations.payeeVPA.account.customer.attribs.city\", observations->''observations''->>''same_payer_payee_acc_d01_txn_count'' as \"observations.same_payer_payee_acc_d01_txn_count\", observations->''observations''->>''same_payer_payee_acc_d01_txn_value'' as \"observations.same_payer_payee_acc_d01_txn_value\", observations->''observations''->>''payer_unique_payee_acc_online_d01_txn_count'' as \"observations.payer_unique_payee_acc_online_d01_txn_count\", observations->''observations''->>''payee_online_intl_card_m30_txn_count'' as \"observations.payee_online_intl_card_m30_txn_count\", observations->''observations''->>''same_payee_same_amt_online_m15_txn_count'' as \"observations.same_payee_same_amt_online_m15_txn_count\", observations->''observations''->>''same_payee_online_m10_gteq250_txn_count'' as \"observations.same_payee_online_m10_gteq250_txn_count\", observations->''observations''->>''payee_account_d01_txn_value'' as \"observations.payee_account_d01_txn_value\", observations->''observations''->>''same_payee_acc_PT48H_txn_value'' as \"observations.same_payee_acc_PT48H_txn_value\", observations->''observations''->>''payee_acc_decline_less5k_m30_txn_count'' as \"observations.payee_acc_decline_less5k_m30_txn_count\", observations->''observations''->>''same_payee_online_PT24H_txn_value'' as \"observations.same_payee_online_PT24H_txn_value\", observations->''observations''->>''same_payer_payee_online_PT5M_txnPay_count'' as \"observations.same_payer_payee_online_PT5M_txnPay_count\", observations->''observations''->>''payer_decline_m30_txn_count'' as \"observations.payer_decline_m30_txn_count\", observations->''observations''->>''same_payer_payee_online_d01_txn_count'' as \"observations.same_payer_payee_online_d01_txn_count\", observations->''observations''->>''same_payer_payee_online_d01_txn_value'' as \"observations.same_payer_payee_online_d01_txn_value\" from analytics.trans l where (l.vcpayeeaddr = :VpaAddress or l.vcpayeraddr = :VpaAddress) and  dttrxntime between :StartDate  and :EndDate and itenantid = :tenantid  order by dttrxntime desc limit 50000 "
    }
}'::text, false::boolean, true::boolean, false::boolean, '510'::integer)
 returning idashboardqueryid;



      INSERT INTO ui.dashboardresultset (
 idashboardresultsetid, vcdashboardresultsetlayout, vcdashboardresultsetname, idashboardqueryid, idashboardid, vcdashboardresultsetschema, irowno, imenustructuredesc) VALUES (
 (select max(idashboardresultsetid)+1 from ui.dashboardresultset), '{
     "sizes": [
         1
     ],
     "detail": {
         "main": {
             "type": "tab-area",
             "widgets": [
                 "PERSPECTIVE_GENERATED_ID_1"
             ],
             "currentIndex": 0
         }
     },
     "mode": "globalFilters",
     "viewers": {
         "PERSPECTIVE_GENERATED_ID_1": {
             "plugin": "Datagrid",
             "plugin_config": {
                 "columns": {},
                 "editable": false,
                 "scroll_lock": false
             },
             "settings": false,
             "theme": "Pro Dark",
             "title": "Transactions",
             "group_by": [],
             "split_by": [],
             "columns": [],
             "filter": [],
             "sort": [],
             "expressions": [],
             "aggregates": {},
             "master": false,
             "table": "transactions",
             "linked": false
         }
     }
 }'::text, 'transactions'::character varying, '100'::integer, '47'::integer, '{
    "id": "integer",
    "Request ID": "string",
    "Timestamp": "datetime",
    "Remarks": "string",
    "Org": "string",
    "Status": "string",
    "Txn ID": "string",
    "Txn Timestamp": "datetime",
    "Note": "string",
    "Type": "string",
    "Class": "string",
    "Merchant addr": "string",
    "Payee Name": "string",
    "Payee VPA": "string",
    "Account Name": "string",
    "Default MCC": "integer",
    "MCC": "integer",
    "Payee email": "string",
    "Payer": "string",
    "Payer VPA": "string",
    "Payer Name": "string",
    "Payer IP": "string",
    "Txn Score": "string",
    "Txn Amount": "float",
    "Card Country Code": "string",
    "Original Txn ID": "string",
    "Acquirer Name": "string",
    "Currency": "string",
    "Workflow Type": "string",
    "Decision Name": "string",
    "Decision Detail": "string",
    "Is_New_Merchant": "string",
    "Is_New_Payer": "string",
    "Skip Processing": "integer",
    "ip_details.Country": "string",
    "ip_details.PostalCode": "integer",
    "ip_details.City": "string",
    "observations.same_ip_addr_unique_payer_d01_txn_count": "integer",
    "observations.payeeVPA.account.customer.attribs.city": "integer",
    "observations.same_payer_payee_acc_d01_txn_count": "integer",
    "observations.same_payer_payee_acc_d01_txn_value": "integer",
    "observations.payer_unique_payee_acc_online_d01_txn_count": "integer",
    "observations.payee_online_intl_card_m30_txn_count": "integer",
    "observations.same_payee_same_amt_online_m15_txn_count": "integer",
    "observations.same_payee_online_m10_gteq250_txn_count": "integer",
    "observations.payee_account_d01_txn_value": "integer",
    "observations.same_payee_acc_PT48H_txn_value": "integer",
    "observations.payee_acc_decline_less5k_m30_txn_count": "integer",
    "observations.same_payee_online_PT24H_txn_value": "integer",
    "observations.same_payer_payee_online_PT5M_txnPay_count": "integer",
    "observations.payer_decline_m30_txn_count": "integer",
    "observations.same_payer_payee_online_d01_txn_count": "integer",
    "observations.same_payer_payee_online_d01_txn_value": "integer"
  }'::text, '1'::integer, '510'::integer)
  returning idashboardresultsetid;



 INSERT INTO ui.dashboardqueryparameters (
 idashboardparameterid, vcparametername, vcparametertype, idashboardqueryid, iorder) VALUES (
 (select max(idashboardparameterid)+1 from ui.dashboardqueryparameters), 'Type'::character varying, 'JsonPath'::character varying, '100'::integer, '1'::integer)
  returning idashboardparameterid;

 INSERT INTO ui.dashboardqueryparameters (
 idashboardparameterid, vcparametername, vcparametertype, idashboardqueryid, iorder) VALUES (
 (select max(idashboardparameterid)+1 from ui.dashboardqueryparameters), 'Party'::character varying, 'JsonPath'::character varying, '100'::integer, '0'::integer)
  returning idashboardparameterid;


   INSERT INTO ui.dashboardqueryparameters (
 idashboardparameterid, vcparametername, vcparametertype, idashboardqueryid) VALUES (
 (select max(idashboardparameterid)+1 from ui.dashboardqueryparameters), 'DateRange'::character varying, 'DateRange'::character varying, '100'::integer)
  returning idashboardparameterid;



   INSERT INTO ui.dashboardqueryparameters (
 idashboardparameterid, vcparametername, vcparametertype, idashboardqueryid) VALUES (
 (select max(idashboardparameterid)+1 from ui.dashboardqueryparameters), 'VpaAddress'::character varying, 'String'::character varying, '100'::integer)
  returning idashboardparameterid;


----------------------------------------------------------------




INSERT INTO ui.dashboard (
idashboardid, bactive, bdelete, vcdashboardname, iorder, irowcount, imenustructuredesc, itenantid) VALUES (
'41'::integer, true::boolean, false::boolean, 'Alerted Transactions'::character varying, '40'::integer, '1'::integer, '510'::integer, '4'::integer)
 returning idashboardid;


INSERT INTO ui.dashboardquery (
idashboardqueryid, bparametersrequired, vcfilterparametersjson, vcdashboardquery, formattingrequiered, runonanalytics, transposerequired, imenustructuredesc) VALUES (
'94'::integer, true::boolean, '{
    "DateRange": null,
    "Class": null,
    "Decision": null,
    "RiskScore": null,
    "Rule": null,
    "Load":null
}'::text, '{
    "All":
    {
        "All" : {
            "All" : "select l.ilivemessageid as \"id\", observations->>''reqid'' as \"Request ID\", cast(observations->>''ts'' as timestamp with time zone) \"Timestamp\", result->>''msg'' as \"Remarks\", observations->>''org'' as \"Org\", result->>''status'' as \"Status\", observations->''txn''->>''id'' as \"Txn ID\", cast(observations->''txn''->>''ts'' as timestamp with time zone) as \"Txn Timestamp\", observations->''txn''->>''note'' as \"Note\", observations->''txn''->>''type'' as \"Type\", observations->''txn''->>''class'' as \"Class\", observations->''payee''->>''addr'' as \"Merchant addr\", observations->''payee''->''attribs''->''identity''->>''verified_name'' as \"Payee Name\", observations->''observations''->''payeeVPA''->>''payment_address'' as \"Payee VPA\", observations->''observations''->''payeeVPA''->''account''->>''accountName'' as \"Account Name\", observations->''observations''->''payeeVPA''->''account''->>''default_mcc'' as \"Default MCC\", observations->''payee''->>''mcc'' as \"MCC\", observations->''observations''->''payeeVPA''->''account''->''customer''->>''email'' as \"Payee email\", observations->''payer''->>''addr'' as \"Payer\", observations->''observations''->''payerVPA''->>''payment_address'' as \"Payer VPA\", observations->''observations''->''payerVPA''->>''vpaName'' as \"Payer Name\", observations->''payer''->''attribs''->''device''->>''ip'' as \"Payer IP\", result->''score''->>''score'' as \"Txn Score\", round(cast(observations->''payee''->>''amount'' as integer)/100, 2) as \"Txn Amount\", observations->''txn''->''attribs''->>''card_country_code'' as \"Card Country Code\", observations->''txn''->>''orgTxnId'' as \"Original Txn ID\", observations->''txn''->''attribs''->>''acquirer_name'' as \"Acquirer Name\", observations->''payee''->>''currency'' as \"Currency\", result->''score''->>''workflow'' as \"Workflow Type\", observations->''observations''->''decisionclass''->>''decisionName'' as \"Decision Name\", result->''score''->>''decisiondetails'' as \"Decision Detail\", observations->''observations''->>''new_payee'' as \"Is_New_Merchant\", observations->''observations''->>''new_payer'' as \"Is_New_Payer\", observations->''txn''->''attribs''->>''skip_processing'' as \"Skip Processing\", observations->''observations''->''ip_details''->>''country'' as \"ip_details.Country\", observations->''observations''->''ip_details''->''details''->>''postal_code'' as \"ip_details.PostalCode\", observations->''observations''->''ip_details''->''details''->>''adm3-city-town'' as \"ip_details.City\", observations->''observations''->''payeeVPA''->''account''->''customer''->''attribs''->>''city'' as \"observations.payeeVPA.account.customer.attribs.city\", observations->''observations''->>''same_payer_payee_acc_d01_txn_count'' as \"observations.same_payer_payee_acc_d01_txn_count\", observations->''observations''->>''same_payer_payee_acc_d01_txn_value'' as \"observations.same_payer_payee_acc_d01_txn_value\", observations->''observations''->>''payer_unique_payee_acc_online_d01_txn_count'' as \"observations.payer_unique_payee_acc_online_d01_txn_count\", observations->''observations''->>''payee_online_intl_card_m30_txn_count'' as \"observations.payee_online_intl_card_m30_txn_count\", observations->''observations''->>''same_payee_same_amt_online_m15_txn_count'' as \"observations.same_payee_same_amt_online_m15_txn_count\", observations->''observations''->>''same_payee_online_m10_gteq250_txn_count'' as \"observations.same_payee_online_m10_gteq250_txn_count\", observations->''observations''->>''payee_account_d01_txn_value'' as \"observations.payee_account_d01_txn_value\", observations->''observations''->>''same_payee_acc_PT48H_txn_value'' as \"observations.same_payee_acc_PT48H_txn_value\", observations->''observations''->>''payee_acc_decline_less5k_m30_txn_count'' as \"observations.payee_acc_decline_less5k_m30_txn_count\", observations->''observations''->>''same_payee_online_PT24H_txn_value'' as \"observations.same_payee_online_PT24H_txn_value\", observations->''observations''->>''same_payer_payee_online_PT5M_txnPay_count'' as \"observations.same_payer_payee_online_PT5M_txnPay_count\", observations->''observations''->>''payer_decline_m30_txn_count'' as \"observations.payer_decline_m30_txn_count\", observations->''observations''->>''same_payer_payee_online_d01_txn_count'' as \"observations.same_payer_payee_online_d01_txn_count\", observations->''observations''->>''same_payer_payee_online_d01_txn_value'' as \"observations.same_payer_payee_online_d01_txn_value\" , rt.dttrxntime AS \"Txn Date Time\", rt.vcmsgid AS \"Txn ID\", rt.vcpayercustomerexternalid AS \"Payer Customer ID\", rt.vcpayeraccountexternalid AS \"Payer Account ID\", rt.vcpayeraddr AS \"Payer VPA ID\", rt.vcpayeecustomerexternalid AS \"Payee Customer ID\", rt.vcpayeeaccountexternalid AS \"Payee Account ID\", rt.vcpayeeaddr AS \"Payee VPA ID\", rt.vcclassname AS \"Txn Class\", rt.dobservationamount AS \"Txn Amount\", rt.vcdecisionname AS \"Decision Name\", rt.iruleid AS \"Rule ID\", rt.vcrulename AS \"Rule Name\", rt.rule_score AS \"Score\", rt.vcremark AS \"Side\" FROM transactions.rule_triggered rt left join analytics.trans l on l.ilivemessageid = rt.ilivemessageid WHERE rt.rule_score >= :RiskScore AND rt.dttrxntime BETWEEN :StartDate AND :EndDate and itenantid = :tenantid order by rt.dttrxntime desc limit :Load",
            "Other": "select l.ilivemessageid as \"id\", observations->>''reqid'' as \"Request ID\", cast(observations->>''ts'' as timestamp with time zone) \"Timestamp\", result->>''msg'' as \"Remarks\", observations->>''org'' as \"Org\", result->>''status'' as \"Status\", observations->''txn''->>''id'' as \"Txn ID\", cast(observations->''txn''->>''ts'' as timestamp with time zone) as \"Txn Timestamp\", observations->''txn''->>''note'' as \"Note\", observations->''txn''->>''type'' as \"Type\", observations->''txn''->>''class'' as \"Class\", observations->''payee''->>''addr'' as \"Merchant addr\", observations->''payee''->''attribs''->''identity''->>''verified_name'' as \"Payee Name\", observations->''observations''->''payeeVPA''->>''payment_address'' as \"Payee VPA\", observations->''observations''->''payeeVPA''->''account''->>''accountName'' as \"Account Name\", observations->''observations''->''payeeVPA''->''account''->>''default_mcc'' as \"Default MCC\", observations->''payee''->>''mcc'' as \"MCC\", observations->''observations''->''payeeVPA''->''account''->''customer''->>''email'' as \"Payee email\", observations->''payer''->>''addr'' as \"Payer\", observations->''observations''->''payerVPA''->>''payment_address'' as \"Payer VPA\", observations->''observations''->''payerVPA''->>''vpaName'' as \"Payer Name\", observations->''payer''->''attribs''->''device''->>''ip'' as \"Payer IP\", result->''score''->>''score'' as \"Txn Score\", round(cast(observations->''payee''->>''amount'' as integer)/100, 2) as \"Txn Amount\", observations->''txn''->''attribs''->>''card_country_code'' as \"Card Country Code\", observations->''txn''->>''orgTxnId'' as \"Original Txn ID\", observations->''txn''->''attribs''->>''acquirer_name'' as \"Acquirer Name\", observations->''payee''->>''currency'' as \"Currency\", result->''score''->>''workflow'' as \"Workflow Type\", observations->''observations''->''decisionclass''->>''decisionName'' as \"Decision Name\", result->''score''->>''decisiondetails'' as \"Decision Detail\", observations->''observations''->>''new_payee'' as \"Is_New_Merchant\", observations->''observations''->>''new_payer'' as \"Is_New_Payer\", observations->''txn''->''attribs''->>''skip_processing'' as \"Skip Processing\", observations->''observations''->''ip_details''->>''country'' as \"ip_details.Country\", observations->''observations''->''ip_details''->''details''->>''postal_code'' as \"ip_details.PostalCode\", observations->''observations''->''ip_details''->''details''->>''adm3-city-town'' as \"ip_details.City\", observations->''observations''->''payeeVPA''->''account''->''customer''->''attribs''->>''city'' as \"observations.payeeVPA.account.customer.attribs.city\", observations->''observations''->>''same_payer_payee_acc_d01_txn_count'' as \"observations.same_payer_payee_acc_d01_txn_count\", observations->''observations''->>''same_payer_payee_acc_d01_txn_value'' as \"observations.same_payer_payee_acc_d01_txn_value\", observations->''observations''->>''payer_unique_payee_acc_online_d01_txn_count'' as \"observations.payer_unique_payee_acc_online_d01_txn_count\", observations->''observations''->>''payee_online_intl_card_m30_txn_count'' as \"observations.payee_online_intl_card_m30_txn_count\", observations->''observations''->>''same_payee_same_amt_online_m15_txn_count'' as \"observations.same_payee_same_amt_online_m15_txn_count\", observations->''observations''->>''same_payee_online_m10_gteq250_txn_count'' as \"observations.same_payee_online_m10_gteq250_txn_count\", observations->''observations''->>''payee_account_d01_txn_value'' as \"observations.payee_account_d01_txn_value\", observations->''observations''->>''same_payee_acc_PT48H_txn_value'' as \"observations.same_payee_acc_PT48H_txn_value\", observations->''observations''->>''payee_acc_decline_less5k_m30_txn_count'' as \"observations.payee_acc_decline_less5k_m30_txn_count\", observations->''observations''->>''same_payee_online_PT24H_txn_value'' as \"observations.same_payee_online_PT24H_txn_value\", observations->''observations''->>''same_payer_payee_online_PT5M_txnPay_count'' as \"observations.same_payer_payee_online_PT5M_txnPay_count\", observations->''observations''->>''payer_decline_m30_txn_count'' as \"observations.payer_decline_m30_txn_count\", observations->''observations''->>''same_payer_payee_online_d01_txn_count'' as \"observations.same_payer_payee_online_d01_txn_count\", observations->''observations''->>''same_payer_payee_online_d01_txn_value'' as \"observations.same_payer_payee_online_d01_txn_value\" , rt.dttrxntime AS \"Txn Date Time\", rt.vcmsgid AS \"Txn ID\", rt.vcpayercustomerexternalid AS \"Payer Customer ID\", rt.vcpayeraccountexternalid AS \"Payer Account ID\", rt.vcpayeraddr AS \"Payer VPA ID\", rt.vcpayeecustomerexternalid AS \"Payee Customer ID\", rt.vcpayeeaccountexternalid AS \"Payee Account ID\", rt.vcpayeeaddr AS \"Payee VPA ID\", rt.vcclassname AS \"Txn Class\", rt.dobservationamount AS \"Txn Amount\", rt.vcdecisionname AS \"Decision Name\", rt.iruleid AS \"Rule ID\", rt.vcrulename AS \"Rule Name\", rt.rule_score AS \"Score\", rt.vcremark AS \"Side\" FROM transactions.rule_triggered rt left join analytics.trans l on l.ilivemessageid = rt.ilivemessageid WHERE rt.rule_score >= :RiskScore AND rt.dttrxntime BETWEEN :StartDate AND :EndDate and itenantid = :tenantid and rt.vcrulename = :Rule order by rt.dttrxntime desc limit :Load"
        },
        "Other": {
            "All" : "select l.ilivemessageid as \"id\", observations->>''reqid'' as \"Request ID\", cast(observations->>''ts'' as timestamp with time zone) \"Timestamp\", result->>''msg'' as \"Remarks\", observations->>''org'' as \"Org\", result->>''status'' as \"Status\", observations->''txn''->>''id'' as \"Txn ID\", cast(observations->''txn''->>''ts'' as timestamp with time zone) as \"Txn Timestamp\", observations->''txn''->>''note'' as \"Note\", observations->''txn''->>''type'' as \"Type\", observations->''txn''->>''class'' as \"Class\", observations->''payee''->>''addr'' as \"Merchant addr\", observations->''payee''->''attribs''->''identity''->>''verified_name'' as \"Payee Name\", observations->''observations''->''payeeVPA''->>''payment_address'' as \"Payee VPA\", observations->''observations''->''payeeVPA''->''account''->>''accountName'' as \"Account Name\", observations->''observations''->''payeeVPA''->''account''->>''default_mcc'' as \"Default MCC\", observations->''payee''->>''mcc'' as \"MCC\", observations->''observations''->''payeeVPA''->''account''->''customer''->>''email'' as \"Payee email\", observations->''payer''->>''addr'' as \"Payer\", observations->''observations''->''payerVPA''->>''payment_address'' as \"Payer VPA\", observations->''observations''->''payerVPA''->>''vpaName'' as \"Payer Name\", observations->''payer''->''attribs''->''device''->>''ip'' as \"Payer IP\", result->''score''->>''score'' as \"Txn Score\", round(cast(observations->''payee''->>''amount'' as integer)/100, 2) as \"Txn Amount\", observations->''txn''->''attribs''->>''card_country_code'' as \"Card Country Code\", observations->''txn''->>''orgTxnId'' as \"Original Txn ID\", observations->''txn''->''attribs''->>''acquirer_name'' as \"Acquirer Name\", observations->''payee''->>''currency'' as \"Currency\", result->''score''->>''workflow'' as \"Workflow Type\", observations->''observations''->''decisionclass''->>''decisionName'' as \"Decision Name\", result->''score''->>''decisiondetails'' as \"Decision Detail\", observations->''observations''->>''new_payee'' as \"Is_New_Merchant\", observations->''observations''->>''new_payer'' as \"Is_New_Payer\", observations->''txn''->''attribs''->>''skip_processing'' as \"Skip Processing\", observations->''observations''->''ip_details''->>''country'' as \"ip_details.Country\", observations->''observations''->''ip_details''->''details''->>''postal_code'' as \"ip_details.PostalCode\", observations->''observations''->''ip_details''->''details''->>''adm3-city-town'' as \"ip_details.City\", observations->''observations''->''payeeVPA''->''account''->''customer''->''attribs''->>''city'' as \"observations.payeeVPA.account.customer.attribs.city\", observations->''observations''->>''same_payer_payee_acc_d01_txn_count'' as \"observations.same_payer_payee_acc_d01_txn_count\", observations->''observations''->>''same_payer_payee_acc_d01_txn_value'' as \"observations.same_payer_payee_acc_d01_txn_value\", observations->''observations''->>''payer_unique_payee_acc_online_d01_txn_count'' as \"observations.payer_unique_payee_acc_online_d01_txn_count\", observations->''observations''->>''payee_online_intl_card_m30_txn_count'' as \"observations.payee_online_intl_card_m30_txn_count\", observations->''observations''->>''same_payee_same_amt_online_m15_txn_count'' as \"observations.same_payee_same_amt_online_m15_txn_count\", observations->''observations''->>''same_payee_online_m10_gteq250_txn_count'' as \"observations.same_payee_online_m10_gteq250_txn_count\", observations->''observations''->>''payee_account_d01_txn_value'' as \"observations.payee_account_d01_txn_value\", observations->''observations''->>''same_payee_acc_PT48H_txn_value'' as \"observations.same_payee_acc_PT48H_txn_value\", observations->''observations''->>''payee_acc_decline_less5k_m30_txn_count'' as \"observations.payee_acc_decline_less5k_m30_txn_count\", observations->''observations''->>''same_payee_online_PT24H_txn_value'' as \"observations.same_payee_online_PT24H_txn_value\", observations->''observations''->>''same_payer_payee_online_PT5M_txnPay_count'' as \"observations.same_payer_payee_online_PT5M_txnPay_count\", observations->''observations''->>''payer_decline_m30_txn_count'' as \"observations.payer_decline_m30_txn_count\", observations->''observations''->>''same_payer_payee_online_d01_txn_count'' as \"observations.same_payer_payee_online_d01_txn_count\", observations->''observations''->>''same_payer_payee_online_d01_txn_value'' as \"observations.same_payer_payee_online_d01_txn_value\" , rt.dttrxntime AS \"Txn Date Time\", rt.vcmsgid AS \"Txn ID\", rt.vcpayercustomerexternalid AS \"Payer Customer ID\", rt.vcpayeraccountexternalid AS \"Payer Account ID\", rt.vcpayeraddr AS \"Payer VPA ID\", rt.vcpayeecustomerexternalid AS \"Payee Customer ID\", rt.vcpayeeaccountexternalid AS \"Payee Account ID\", rt.vcpayeeaddr AS \"Payee VPA ID\", rt.vcclassname AS \"Txn Class\", rt.dobservationamount AS \"Txn Amount\", rt.vcdecisionname AS \"Decision Name\", rt.iruleid AS \"Rule ID\", rt.vcrulename AS \"Rule Name\", rt.rule_score AS \"Score\", rt.vcremark AS \"Side\" FROM transactions.rule_triggered rt left join analytics.trans l on l.ilivemessageid = rt.ilivemessageid WHERE rt.rule_score >= :RiskScore AND rt.dttrxntime BETWEEN :StartDate AND :EndDate and itenantid = :tenantid  and rt.vcdecisionname = :Decision order by rt.dttrxntime desc limit :Load",
            "Other": "select l.ilivemessageid as \"id\", observations->>''reqid'' as \"Request ID\", cast(observations->>''ts'' as timestamp with time zone) \"Timestamp\", result->>''msg'' as \"Remarks\", observations->>''org'' as \"Org\", result->>''status'' as \"Status\", observations->''txn''->>''id'' as \"Txn ID\", cast(observations->''txn''->>''ts'' as timestamp with time zone) as \"Txn Timestamp\", observations->''txn''->>''note'' as \"Note\", observations->''txn''->>''type'' as \"Type\", observations->''txn''->>''class'' as \"Class\", observations->''payee''->>''addr'' as \"Merchant addr\", observations->''payee''->''attribs''->''identity''->>''verified_name'' as \"Payee Name\", observations->''observations''->''payeeVPA''->>''payment_address'' as \"Payee VPA\", observations->''observations''->''payeeVPA''->''account''->>''accountName'' as \"Account Name\", observations->''observations''->''payeeVPA''->''account''->>''default_mcc'' as \"Default MCC\", observations->''payee''->>''mcc'' as \"MCC\", observations->''observations''->''payeeVPA''->''account''->''customer''->>''email'' as \"Payee email\", observations->''payer''->>''addr'' as \"Payer\", observations->''observations''->''payerVPA''->>''payment_address'' as \"Payer VPA\", observations->''observations''->''payerVPA''->>''vpaName'' as \"Payer Name\", observations->''payer''->''attribs''->''device''->>''ip'' as \"Payer IP\", result->''score''->>''score'' as \"Txn Score\", round(cast(observations->''payee''->>''amount'' as integer)/100, 2) as \"Txn Amount\", observations->''txn''->''attribs''->>''card_country_code'' as \"Card Country Code\", observations->''txn''->>''orgTxnId'' as \"Original Txn ID\", observations->''txn''->''attribs''->>''acquirer_name'' as \"Acquirer Name\", observations->''payee''->>''currency'' as \"Currency\", result->''score''->>''workflow'' as \"Workflow Type\", observations->''observations''->''decisionclass''->>''decisionName'' as \"Decision Name\", result->''score''->>''decisiondetails'' as \"Decision Detail\", observations->''observations''->>''new_payee'' as \"Is_New_Merchant\", observations->''observations''->>''new_payer'' as \"Is_New_Payer\", observations->''txn''->''attribs''->>''skip_processing'' as \"Skip Processing\", observations->''observations''->''ip_details''->>''country'' as \"ip_details.Country\", observations->''observations''->''ip_details''->''details''->>''postal_code'' as \"ip_details.PostalCode\", observations->''observations''->''ip_details''->''details''->>''adm3-city-town'' as \"ip_details.City\", observations->''observations''->''payeeVPA''->''account''->''customer''->''attribs''->>''city'' as \"observations.payeeVPA.account.customer.attribs.city\", observations->''observations''->>''same_payer_payee_acc_d01_txn_count'' as \"observations.same_payer_payee_acc_d01_txn_count\", observations->''observations''->>''same_payer_payee_acc_d01_txn_value'' as \"observations.same_payer_payee_acc_d01_txn_value\", observations->''observations''->>''payer_unique_payee_acc_online_d01_txn_count'' as \"observations.payer_unique_payee_acc_online_d01_txn_count\", observations->''observations''->>''payee_online_intl_card_m30_txn_count'' as \"observations.payee_online_intl_card_m30_txn_count\", observations->''observations''->>''same_payee_same_amt_online_m15_txn_count'' as \"observations.same_payee_same_amt_online_m15_txn_count\", observations->''observations''->>''same_payee_online_m10_gteq250_txn_count'' as \"observations.same_payee_online_m10_gteq250_txn_count\", observations->''observations''->>''payee_account_d01_txn_value'' as \"observations.payee_account_d01_txn_value\", observations->''observations''->>''same_payee_acc_PT48H_txn_value'' as \"observations.same_payee_acc_PT48H_txn_value\", observations->''observations''->>''payee_acc_decline_less5k_m30_txn_count'' as \"observations.payee_acc_decline_less5k_m30_txn_count\", observations->''observations''->>''same_payee_online_PT24H_txn_value'' as \"observations.same_payee_online_PT24H_txn_value\", observations->''observations''->>''same_payer_payee_online_PT5M_txnPay_count'' as \"observations.same_payer_payee_online_PT5M_txnPay_count\", observations->''observations''->>''payer_decline_m30_txn_count'' as \"observations.payer_decline_m30_txn_count\", observations->''observations''->>''same_payer_payee_online_d01_txn_count'' as \"observations.same_payer_payee_online_d01_txn_count\", observations->''observations''->>''same_payer_payee_online_d01_txn_value'' as \"observations.same_payer_payee_online_d01_txn_value\" , rt.dttrxntime AS \"Txn Date Time\", rt.vcmsgid AS \"Txn ID\", rt.vcpayercustomerexternalid AS \"Payer Customer ID\", rt.vcpayeraccountexternalid AS \"Payer Account ID\", rt.vcpayeraddr AS \"Payer VPA ID\", rt.vcpayeecustomerexternalid AS \"Payee Customer ID\", rt.vcpayeeaccountexternalid AS \"Payee Account ID\", rt.vcpayeeaddr AS \"Payee VPA ID\", rt.vcclassname AS \"Txn Class\", rt.dobservationamount AS \"Txn Amount\", rt.vcdecisionname AS \"Decision Name\", rt.iruleid AS \"Rule ID\", rt.vcrulename AS \"Rule Name\", rt.rule_score AS \"Score\", rt.vcremark AS \"Side\" FROM transactions.rule_triggered rt left join analytics.trans l on l.ilivemessageid = rt.ilivemessageid WHERE rt.rule_score >= :RiskScore AND rt.dttrxntime BETWEEN :StartDate AND :EndDate and itenantid = :tenantid and rt.vcdecisionname = :Decision and rt.vcrulename = :Rule order by rt.dttrxntime desc limit :Load"
        }
    },
    "Other":
    {
        "All" : {
            "All" : "select l.ilivemessageid as \"id\", observations->>''reqid'' as \"Request ID\", cast(observations->>''ts'' as timestamp with time zone) \"Timestamp\", result->>''msg'' as \"Remarks\", observations->>''org'' as \"Org\", result->>''status'' as \"Status\", observations->''txn''->>''id'' as \"Txn ID\", cast(observations->''txn''->>''ts'' as timestamp with time zone) as \"Txn Timestamp\", observations->''txn''->>''note'' as \"Note\", observations->''txn''->>''type'' as \"Type\", observations->''txn''->>''class'' as \"Class\", observations->''payee''->>''addr'' as \"Merchant addr\", observations->''payee''->''attribs''->''identity''->>''verified_name'' as \"Payee Name\", observations->''observations''->''payeeVPA''->>''payment_address'' as \"Payee VPA\", observations->''observations''->''payeeVPA''->''account''->>''accountName'' as \"Account Name\", observations->''observations''->''payeeVPA''->''account''->>''default_mcc'' as \"Default MCC\", observations->''payee''->>''mcc'' as \"MCC\", observations->''observations''->''payeeVPA''->''account''->''customer''->>''email'' as \"Payee email\", observations->''payer''->>''addr'' as \"Payer\", observations->''observations''->''payerVPA''->>''payment_address'' as \"Payer VPA\", observations->''observations''->''payerVPA''->>''vpaName'' as \"Payer Name\", observations->''payer''->''attribs''->''device''->>''ip'' as \"Payer IP\", result->''score''->>''score'' as \"Txn Score\", round(cast(observations->''payee''->>''amount'' as integer)/100, 2) as \"Txn Amount\", observations->''txn''->''attribs''->>''card_country_code'' as \"Card Country Code\", observations->''txn''->>''orgTxnId'' as \"Original Txn ID\", observations->''txn''->''attribs''->>''acquirer_name'' as \"Acquirer Name\", observations->''payee''->>''currency'' as \"Currency\", result->''score''->>''workflow'' as \"Workflow Type\", observations->''observations''->''decisionclass''->>''decisionName'' as \"Decision Name\", result->''score''->>''decisiondetails'' as \"Decision Detail\", observations->''observations''->>''new_payee'' as \"Is_New_Merchant\", observations->''observations''->>''new_payer'' as \"Is_New_Payer\", observations->''txn''->''attribs''->>''skip_processing'' as \"Skip Processing\", observations->''observations''->''ip_details''->>''country'' as \"ip_details.Country\", observations->''observations''->''ip_details''->''details''->>''postal_code'' as \"ip_details.PostalCode\", observations->''observations''->''ip_details''->''details''->>''adm3-city-town'' as \"ip_details.City\", observations->''observations''->''payeeVPA''->''account''->''customer''->''attribs''->>''city'' as \"observations.payeeVPA.account.customer.attribs.city\", observations->''observations''->>''same_payer_payee_acc_d01_txn_count'' as \"observations.same_payer_payee_acc_d01_txn_count\", observations->''observations''->>''same_payer_payee_acc_d01_txn_value'' as \"observations.same_payer_payee_acc_d01_txn_value\", observations->''observations''->>''payer_unique_payee_acc_online_d01_txn_count'' as \"observations.payer_unique_payee_acc_online_d01_txn_count\", observations->''observations''->>''payee_online_intl_card_m30_txn_count'' as \"observations.payee_online_intl_card_m30_txn_count\", observations->''observations''->>''same_payee_same_amt_online_m15_txn_count'' as \"observations.same_payee_same_amt_online_m15_txn_count\", observations->''observations''->>''same_payee_online_m10_gteq250_txn_count'' as \"observations.same_payee_online_m10_gteq250_txn_count\", observations->''observations''->>''payee_account_d01_txn_value'' as \"observations.payee_account_d01_txn_value\", observations->''observations''->>''same_payee_acc_PT48H_txn_value'' as \"observations.same_payee_acc_PT48H_txn_value\", observations->''observations''->>''payee_acc_decline_less5k_m30_txn_count'' as \"observations.payee_acc_decline_less5k_m30_txn_count\", observations->''observations''->>''same_payee_online_PT24H_txn_value'' as \"observations.same_payee_online_PT24H_txn_value\", observations->''observations''->>''same_payer_payee_online_PT5M_txnPay_count'' as \"observations.same_payer_payee_online_PT5M_txnPay_count\", observations->''observations''->>''payer_decline_m30_txn_count'' as \"observations.payer_decline_m30_txn_count\", observations->''observations''->>''same_payer_payee_online_d01_txn_count'' as \"observations.same_payer_payee_online_d01_txn_count\", observations->''observations''->>''same_payer_payee_online_d01_txn_value'' as \"observations.same_payer_payee_online_d01_txn_value\" , rt.dttrxntime AS \"Txn Date Time\", rt.vcmsgid AS \"Txn ID\", rt.vcpayercustomerexternalid AS \"Payer Customer ID\", rt.vcpayeraccountexternalid AS \"Payer Account ID\", rt.vcpayeraddr AS \"Payer VPA ID\", rt.vcpayeecustomerexternalid AS \"Payee Customer ID\", rt.vcpayeeaccountexternalid AS \"Payee Account ID\", rt.vcpayeeaddr AS \"Payee VPA ID\", rt.vcclassname AS \"Txn Class\", rt.dobservationamount AS \"Txn Amount\", rt.vcdecisionname AS \"Decision Name\", rt.iruleid AS \"Rule ID\", rt.vcrulename AS \"Rule Name\", rt.rule_score AS \"Score\", rt.vcremark AS \"Side\" FROM transactions.rule_triggered rt left join analytics.trans l on l.ilivemessageid = rt.ilivemessageid WHERE rt.rule_score >= :RiskScore AND rt.dttrxntime BETWEEN :StartDate AND :EndDate and itenantid = :tenantid and rt.vcclassname = :Class order by rt.dttrxntime desc limit :Load",
            "Other": "select l.ilivemessageid as \"id\", observations->>''reqid'' as \"Request ID\", cast(observations->>''ts'' as timestamp with time zone) \"Timestamp\", result->>''msg'' as \"Remarks\", observations->>''org'' as \"Org\", result->>''status'' as \"Status\", observations->''txn''->>''id'' as \"Txn ID\", cast(observations->''txn''->>''ts'' as timestamp with time zone) as \"Txn Timestamp\", observations->''txn''->>''note'' as \"Note\", observations->''txn''->>''type'' as \"Type\", observations->''txn''->>''class'' as \"Class\", observations->''payee''->>''addr'' as \"Merchant addr\", observations->''payee''->''attribs''->''identity''->>''verified_name'' as \"Payee Name\", observations->''observations''->''payeeVPA''->>''payment_address'' as \"Payee VPA\", observations->''observations''->''payeeVPA''->''account''->>''accountName'' as \"Account Name\", observations->''observations''->''payeeVPA''->''account''->>''default_mcc'' as \"Default MCC\", observations->''payee''->>''mcc'' as \"MCC\", observations->''observations''->''payeeVPA''->''account''->''customer''->>''email'' as \"Payee email\", observations->''payer''->>''addr'' as \"Payer\", observations->''observations''->''payerVPA''->>''payment_address'' as \"Payer VPA\", observations->''observations''->''payerVPA''->>''vpaName'' as \"Payer Name\", observations->''payer''->''attribs''->''device''->>''ip'' as \"Payer IP\", result->''score''->>''score'' as \"Txn Score\", round(cast(observations->''payee''->>''amount'' as integer)/100, 2) as \"Txn Amount\", observations->''txn''->''attribs''->>''card_country_code'' as \"Card Country Code\", observations->''txn''->>''orgTxnId'' as \"Original Txn ID\", observations->''txn''->''attribs''->>''acquirer_name'' as \"Acquirer Name\", observations->''payee''->>''currency'' as \"Currency\", result->''score''->>''workflow'' as \"Workflow Type\", observations->''observations''->''decisionclass''->>''decisionName'' as \"Decision Name\", result->''score''->>''decisiondetails'' as \"Decision Detail\", observations->''observations''->>''new_payee'' as \"Is_New_Merchant\", observations->''observations''->>''new_payer'' as \"Is_New_Payer\", observations->''txn''->''attribs''->>''skip_processing'' as \"Skip Processing\", observations->''observations''->''ip_details''->>''country'' as \"ip_details.Country\", observations->''observations''->''ip_details''->''details''->>''postal_code'' as \"ip_details.PostalCode\", observations->''observations''->''ip_details''->''details''->>''adm3-city-town'' as \"ip_details.City\", observations->''observations''->''payeeVPA''->''account''->''customer''->''attribs''->>''city'' as \"observations.payeeVPA.account.customer.attribs.city\", observations->''observations''->>''same_payer_payee_acc_d01_txn_count'' as \"observations.same_payer_payee_acc_d01_txn_count\", observations->''observations''->>''same_payer_payee_acc_d01_txn_value'' as \"observations.same_payer_payee_acc_d01_txn_value\", observations->''observations''->>''payer_unique_payee_acc_online_d01_txn_count'' as \"observations.payer_unique_payee_acc_online_d01_txn_count\", observations->''observations''->>''payee_online_intl_card_m30_txn_count'' as \"observations.payee_online_intl_card_m30_txn_count\", observations->''observations''->>''same_payee_same_amt_online_m15_txn_count'' as \"observations.same_payee_same_amt_online_m15_txn_count\", observations->''observations''->>''same_payee_online_m10_gteq250_txn_count'' as \"observations.same_payee_online_m10_gteq250_txn_count\", observations->''observations''->>''payee_account_d01_txn_value'' as \"observations.payee_account_d01_txn_value\", observations->''observations''->>''same_payee_acc_PT48H_txn_value'' as \"observations.same_payee_acc_PT48H_txn_value\", observations->''observations''->>''payee_acc_decline_less5k_m30_txn_count'' as \"observations.payee_acc_decline_less5k_m30_txn_count\", observations->''observations''->>''same_payee_online_PT24H_txn_value'' as \"observations.same_payee_online_PT24H_txn_value\", observations->''observations''->>''same_payer_payee_online_PT5M_txnPay_count'' as \"observations.same_payer_payee_online_PT5M_txnPay_count\", observations->''observations''->>''payer_decline_m30_txn_count'' as \"observations.payer_decline_m30_txn_count\", observations->''observations''->>''same_payer_payee_online_d01_txn_count'' as \"observations.same_payer_payee_online_d01_txn_count\", observations->''observations''->>''same_payer_payee_online_d01_txn_value'' as \"observations.same_payer_payee_online_d01_txn_value\" , rt.dttrxntime AS \"Txn Date Time\", rt.vcmsgid AS \"Txn ID\", rt.vcpayercustomerexternalid AS \"Payer Customer ID\", rt.vcpayeraccountexternalid AS \"Payer Account ID\", rt.vcpayeraddr AS \"Payer VPA ID\", rt.vcpayeecustomerexternalid AS \"Payee Customer ID\", rt.vcpayeeaccountexternalid AS \"Payee Account ID\", rt.vcpayeeaddr AS \"Payee VPA ID\", rt.vcclassname AS \"Txn Class\", rt.dobservationamount AS \"Txn Amount\", rt.vcdecisionname AS \"Decision Name\", rt.iruleid AS \"Rule ID\", rt.vcrulename AS \"Rule Name\", rt.rule_score AS \"Score\", rt.vcremark AS \"Side\" FROM transactions.rule_triggered rt left join analytics.trans l on l.ilivemessageid = rt.ilivemessageid WHERE rt.rule_score >= :RiskScore AND rt.dttrxntime BETWEEN :StartDate AND :EndDate and itenantid = :tenantid and rt.vcrulename = :Rule and rt.vcclassname = :Class order by rt.dttrxntime desc limit :Load"
        },
        "Other": {
            "All" : "select l.ilivemessageid as \"id\", observations->>''reqid'' as \"Request ID\", cast(observations->>''ts'' as timestamp with time zone) \"Timestamp\", result->>''msg'' as \"Remarks\", observations->>''org'' as \"Org\", result->>''status'' as \"Status\", observations->''txn''->>''id'' as \"Txn ID\", cast(observations->''txn''->>''ts'' as timestamp with time zone) as \"Txn Timestamp\", observations->''txn''->>''note'' as \"Note\", observations->''txn''->>''type'' as \"Type\", observations->''txn''->>''class'' as \"Class\", observations->''payee''->>''addr'' as \"Merchant addr\", observations->''payee''->''attribs''->''identity''->>''verified_name'' as \"Payee Name\", observations->''observations''->''payeeVPA''->>''payment_address'' as \"Payee VPA\", observations->''observations''->''payeeVPA''->''account''->>''accountName'' as \"Account Name\", observations->''observations''->''payeeVPA''->''account''->>''default_mcc'' as \"Default MCC\", observations->''payee''->>''mcc'' as \"MCC\", observations->''observations''->''payeeVPA''->''account''->''customer''->>''email'' as \"Payee email\", observations->''payer''->>''addr'' as \"Payer\", observations->''observations''->''payerVPA''->>''payment_address'' as \"Payer VPA\", observations->''observations''->''payerVPA''->>''vpaName'' as \"Payer Name\", observations->''payer''->''attribs''->''device''->>''ip'' as \"Payer IP\", result->''score''->>''score'' as \"Txn Score\", round(cast(observations->''payee''->>''amount'' as integer)/100, 2) as \"Txn Amount\", observations->''txn''->''attribs''->>''card_country_code'' as \"Card Country Code\", observations->''txn''->>''orgTxnId'' as \"Original Txn ID\", observations->''txn''->''attribs''->>''acquirer_name'' as \"Acquirer Name\", observations->''payee''->>''currency'' as \"Currency\", result->''score''->>''workflow'' as \"Workflow Type\", observations->''observations''->''decisionclass''->>''decisionName'' as \"Decision Name\", result->''score''->>''decisiondetails'' as \"Decision Detail\", observations->''observations''->>''new_payee'' as \"Is_New_Merchant\", observations->''observations''->>''new_payer'' as \"Is_New_Payer\", observations->''txn''->''attribs''->>''skip_processing'' as \"Skip Processing\", observations->''observations''->''ip_details''->>''country'' as \"ip_details.Country\", observations->''observations''->''ip_details''->''details''->>''postal_code'' as \"ip_details.PostalCode\", observations->''observations''->''ip_details''->''details''->>''adm3-city-town'' as \"ip_details.City\", observations->''observations''->''payeeVPA''->''account''->''customer''->''attribs''->>''city'' as \"observations.payeeVPA.account.customer.attribs.city\", observations->''observations''->>''same_payer_payee_acc_d01_txn_count'' as \"observations.same_payer_payee_acc_d01_txn_count\", observations->''observations''->>''same_payer_payee_acc_d01_txn_value'' as \"observations.same_payer_payee_acc_d01_txn_value\", observations->''observations''->>''payer_unique_payee_acc_online_d01_txn_count'' as \"observations.payer_unique_payee_acc_online_d01_txn_count\", observations->''observations''->>''payee_online_intl_card_m30_txn_count'' as \"observations.payee_online_intl_card_m30_txn_count\", observations->''observations''->>''same_payee_same_amt_online_m15_txn_count'' as \"observations.same_payee_same_amt_online_m15_txn_count\", observations->''observations''->>''same_payee_online_m10_gteq250_txn_count'' as \"observations.same_payee_online_m10_gteq250_txn_count\", observations->''observations''->>''payee_account_d01_txn_value'' as \"observations.payee_account_d01_txn_value\", observations->''observations''->>''same_payee_acc_PT48H_txn_value'' as \"observations.same_payee_acc_PT48H_txn_value\", observations->''observations''->>''payee_acc_decline_less5k_m30_txn_count'' as \"observations.payee_acc_decline_less5k_m30_txn_count\", observations->''observations''->>''same_payee_online_PT24H_txn_value'' as \"observations.same_payee_online_PT24H_txn_value\", observations->''observations''->>''same_payer_payee_online_PT5M_txnPay_count'' as \"observations.same_payer_payee_online_PT5M_txnPay_count\", observations->''observations''->>''payer_decline_m30_txn_count'' as \"observations.payer_decline_m30_txn_count\", observations->''observations''->>''same_payer_payee_online_d01_txn_count'' as \"observations.same_payer_payee_online_d01_txn_count\", observations->''observations''->>''same_payer_payee_online_d01_txn_value'' as \"observations.same_payer_payee_online_d01_txn_value\" , rt.dttrxntime AS \"Txn Date Time\", rt.vcmsgid AS \"Txn ID\", rt.vcpayercustomerexternalid AS \"Payer Customer ID\", rt.vcpayeraccountexternalid AS \"Payer Account ID\", rt.vcpayeraddr AS \"Payer VPA ID\", rt.vcpayeecustomerexternalid AS \"Payee Customer ID\", rt.vcpayeeaccountexternalid AS \"Payee Account ID\", rt.vcpayeeaddr AS \"Payee VPA ID\", rt.vcclassname AS \"Txn Class\", rt.dobservationamount AS \"Txn Amount\", rt.vcdecisionname AS \"Decision Name\", rt.iruleid AS \"Rule ID\", rt.vcrulename AS \"Rule Name\", rt.rule_score AS \"Score\", rt.vcremark AS \"Side\" FROM transactions.rule_triggered rt left join analytics.trans l on l.ilivemessageid = rt.ilivemessageid WHERE rt.rule_score >= :RiskScore AND rt.dttrxntime BETWEEN :StartDate AND :EndDate and itenantid = :tenantid  and rt.vcdecisionname = :Decision and rt.vcclassname = :Class order by rt.dttrxntime desc limit :Load",
            "Other": "select l.ilivemessageid as \"id\", observations->>''reqid'' as \"Request ID\", cast(observations->>''ts'' as timestamp with time zone) \"Timestamp\", result->>''msg'' as \"Remarks\", observations->>''org'' as \"Org\", result->>''status'' as \"Status\", observations->''txn''->>''id'' as \"Txn ID\", cast(observations->''txn''->>''ts'' as timestamp with time zone) as \"Txn Timestamp\", observations->''txn''->>''note'' as \"Note\", observations->''txn''->>''type'' as \"Type\", observations->''txn''->>''class'' as \"Class\", observations->''payee''->>''addr'' as \"Merchant addr\", observations->''payee''->''attribs''->''identity''->>''verified_name'' as \"Payee Name\", observations->''observations''->''payeeVPA''->>''payment_address'' as \"Payee VPA\", observations->''observations''->''payeeVPA''->''account''->>''accountName'' as \"Account Name\", observations->''observations''->''payeeVPA''->''account''->>''default_mcc'' as \"Default MCC\", observations->''payee''->>''mcc'' as \"MCC\", observations->''observations''->''payeeVPA''->''account''->''customer''->>''email'' as \"Payee email\", observations->''payer''->>''addr'' as \"Payer\", observations->''observations''->''payerVPA''->>''payment_address'' as \"Payer VPA\", observations->''observations''->''payerVPA''->>''vpaName'' as \"Payer Name\", observations->''payer''->''attribs''->''device''->>''ip'' as \"Payer IP\", result->''score''->>''score'' as \"Txn Score\", round(cast(observations->''payee''->>''amount'' as integer)/100, 2) as \"Txn Amount\", observations->''txn''->''attribs''->>''card_country_code'' as \"Card Country Code\", observations->''txn''->>''orgTxnId'' as \"Original Txn ID\", observations->''txn''->''attribs''->>''acquirer_name'' as \"Acquirer Name\", observations->''payee''->>''currency'' as \"Currency\", result->''score''->>''workflow'' as \"Workflow Type\", observations->''observations''->''decisionclass''->>''decisionName'' as \"Decision Name\", result->''score''->>''decisiondetails'' as \"Decision Detail\", observations->''observations''->>''new_payee'' as \"Is_New_Merchant\", observations->''observations''->>''new_payer'' as \"Is_New_Payer\", observations->''txn''->''attribs''->>''skip_processing'' as \"Skip Processing\", observations->''observations''->''ip_details''->>''country'' as \"ip_details.Country\", observations->''observations''->''ip_details''->''details''->>''postal_code'' as \"ip_details.PostalCode\", observations->''observations''->''ip_details''->''details''->>''adm3-city-town'' as \"ip_details.City\", observations->''observations''->''payeeVPA''->''account''->''customer''->''attribs''->>''city'' as \"observations.payeeVPA.account.customer.attribs.city\", observations->''observations''->>''same_payer_payee_acc_d01_txn_count'' as \"observations.same_payer_payee_acc_d01_txn_count\", observations->''observations''->>''same_payer_payee_acc_d01_txn_value'' as \"observations.same_payer_payee_acc_d01_txn_value\", observations->''observations''->>''payer_unique_payee_acc_online_d01_txn_count'' as \"observations.payer_unique_payee_acc_online_d01_txn_count\", observations->''observations''->>''payee_online_intl_card_m30_txn_count'' as \"observations.payee_online_intl_card_m30_txn_count\", observations->''observations''->>''same_payee_same_amt_online_m15_txn_count'' as \"observations.same_payee_same_amt_online_m15_txn_count\", observations->''observations''->>''same_payee_online_m10_gteq250_txn_count'' as \"observations.same_payee_online_m10_gteq250_txn_count\", observations->''observations''->>''payee_account_d01_txn_value'' as \"observations.payee_account_d01_txn_value\", observations->''observations''->>''same_payee_acc_PT48H_txn_value'' as \"observations.same_payee_acc_PT48H_txn_value\", observations->''observations''->>''payee_acc_decline_less5k_m30_txn_count'' as \"observations.payee_acc_decline_less5k_m30_txn_count\", observations->''observations''->>''same_payee_online_PT24H_txn_value'' as \"observations.same_payee_online_PT24H_txn_value\", observations->''observations''->>''same_payer_payee_online_PT5M_txnPay_count'' as \"observations.same_payer_payee_online_PT5M_txnPay_count\", observations->''observations''->>''payer_decline_m30_txn_count'' as \"observations.payer_decline_m30_txn_count\", observations->''observations''->>''same_payer_payee_online_d01_txn_count'' as \"observations.same_payer_payee_online_d01_txn_count\", observations->''observations''->>''same_payer_payee_online_d01_txn_value'' as \"observations.same_payer_payee_online_d01_txn_value\" , rt.dttrxntime AS \"Txn Date Time\", rt.vcmsgid AS \"Txn ID\", rt.vcpayercustomerexternalid AS \"Payer Customer ID\", rt.vcpayeraccountexternalid AS \"Payer Account ID\", rt.vcpayeraddr AS \"Payer VPA ID\", rt.vcpayeecustomerexternalid AS \"Payee Customer ID\", rt.vcpayeeaccountexternalid AS \"Payee Account ID\", rt.vcpayeeaddr AS \"Payee VPA ID\", rt.vcclassname AS \"Txn Class\", rt.dobservationamount AS \"Txn Amount\", rt.vcdecisionname AS \"Decision Name\", rt.iruleid AS \"Rule ID\", rt.vcrulename AS \"Rule Name\", rt.rule_score AS \"Score\", rt.vcremark AS \"Side\" FROM transactions.rule_triggered rt left join analytics.trans l on l.ilivemessageid = rt.ilivemessageid WHERE rt.rule_score >= :RiskScore AND rt.dttrxntime BETWEEN :StartDate AND :EndDate and itenantid = :tenantid and rt.vcdecisionname = :Decision and rt.vcrulename = :Rule and rt.vcclassname = :Class order by rt.dttrxntime desc limit :Load"
        }
    }
}
'::text, false::boolean, true::boolean, false::boolean, '510'::integer)
 returning idashboardqueryid;



 INSERT INTO ui.dashboardresultset (
 idashboardresultsetid, vcdashboardresultsetlayout, vcdashboardresultsetname, idashboardqueryid, idashboardid, vcdashboardresultsetschema, irowno, imenustructuredesc) VALUES (
 (select max(idashboardresultsetid)+1 from ui.dashboardresultset), '{
     "sizes": [
         1
     ],
     "detail": {
         "main": {
             "type": "tab-area",
             "widgets": [
                 "PERSPECTIVE_GENERATED_ID_1"
             ],
             "currentIndex": 0
         }
     },
     "mode": "globalFilters",
     "viewers": {
         "PERSPECTIVE_GENERATED_ID_1": {
             "plugin": "Datagrid",
             "plugin_config": {
                 "columns": {},
                 "editable": false,
                 "scroll_lock": false
             },
             "settings": false,
             "theme": "Pro Dark",
             "title": "Alerted Transactions",
             "group_by": [],
             "split_by": [],
             "columns": [],
             "filter": [],
             "sort": [],
             "expressions": [],
             "aggregates": {},
             "master": false,
             "table": "alertedtransactions",
             "linked": false
         }
     }
 }'::text, 'alertedtransactions'::character varying, '94'::integer, '41'::integer, '{
    "Txn Date Time" : "datetime",
    "Txn ID" : "string" ,
    "Payer Customer ID" : "string",
    "Payer Account ID" : "string",
    "Payer VPA ID" : "string",
    "Payee Customer ID" : "string",
    "Payee Account ID" : "string",
    "Payee VPA ID" : "string",
    "Txn Class" : "string",
    "Txn Amount" : "float",
    "Decision Name" : "string",
    "Rule ID" : "integer",
    "Rule Name" : "string" ,
    "Score" : "integer",
    "Side": "string",
    "id": "integer",
    "Request ID": "string",
    "Timestamp": "datetime",
    "Remarks": "string",
    "Org": "string",
    "Status": "string",
    "Txn ID": "string",
    "Txn Timestamp": "datetime",
    "Note": "string",
    "Type": "string",
    "Class": "string",
    "Merchant addr": "string",
    "Payee Name": "string",
    "Payee VPA": "string",
    "Account Name": "string",
    "Default MCC": "integer",
    "MCC": "integer",
    "Payee email": "string",
    "Payer": "string",
    "Payer VPA": "string",
    "Payer Name": "string",
    "Payer IP": "string",
    "Txn Score": "string",
    "Txn Amount": "float",
    "Card Country Code": "string",
    "Original Txn ID": "string",
    "Acquirer Name": "string",
    "Currency": "string",
    "Workflow Type": "string",
    "Decision Name": "string",
    "Decision Detail": "string",
    "Is_New_Merchant": "string",
    "Is_New_Payer": "string",
    "Skip Processing": "integer",
    "ip_details.Country": "string",
    "ip_details.PostalCode": "integer",
    "ip_details.City": "string",
    "observations.same_ip_addr_unique_payer_d01_txn_count": "integer",
    "observations.payeeVPA.account.customer.attribs.city": "integer",
    "observations.same_payer_payee_acc_d01_txn_count": "integer",
    "observations.same_payer_payee_acc_d01_txn_value": "integer",
    "observations.payer_unique_payee_acc_online_d01_txn_count": "integer",
    "observations.payee_online_intl_card_m30_txn_count": "integer",
    "observations.same_payee_same_amt_online_m15_txn_count": "integer",
    "observations.same_payee_online_m10_gteq250_txn_count": "integer",
    "observations.payee_account_d01_txn_value": "integer",
    "observations.same_payee_acc_PT48H_txn_value": "integer",
    "observations.payee_acc_decline_less5k_m30_txn_count": "integer",
    "observations.same_payee_online_PT24H_txn_value": "integer",
    "observations.same_payer_payee_online_PT5M_txnPay_count": "integer",
    "observations.payer_decline_m30_txn_count": "integer",
    "observations.same_payer_payee_online_d01_txn_count": "integer",
    "observations.same_payer_payee_online_d01_txn_value": "integer"
    }'::text, '1'::integer, '510'::integer)
  returning idashboardresultsetid;


INSERT INTO ui.dashboardfilters (
idashboardfilterid, ifilterorder, vcdashboardfiltername, idashboardid, vcdashboardfiltertype, vcdashboardfilterdisplayname, idashboardqueryidforoptions) VALUES (
(select max(idashboardfilterid)+1 from ui.dashboardfilters), '5'::integer, 'Load'::character varying, '41'::integer, 'Select'::character varying, 'Load'::character varying, '91'::integer)
 returning idashboardfilterid;


 INSERT INTO ui.dashboardfilters (
 idashboardfilterid, ifilterorder, vcdashboardfiltername, idashboardid, vcdashboardfiltertype, vcdashboardfilterdisplayname) VALUES (
 (select max(idashboardfilterid)+1 from ui.dashboardfilters), '3'::integer, 'RiskScore'::character varying, '41'::integer, 'Input'::character varying, 'Rule score (=>0)'::character varying)
  returning idashboardfilterid;

  INSERT INTO ui.dashboardfilters (
  idashboardfilterid, ifilterorder, vcdashboardfiltername, idashboardid, vcdashboardfiltertype, idashboardqueryidforoptions, vcdashboardfilterdisplayname) VALUES (
  (select max(idashboardfilterid)+1 from ui.dashboardfilters), '4'::integer, 'Rule'::character varying, '41'::integer, 'Select'::character varying, '36'::integer, 'Rule'::character varying)
   returning idashboardfilterid;



   INSERT INTO ui.dashboardfilters (
   idashboardfilterid, ifilterorder, vcdashboardfiltername, idashboardid, vcdashboardfiltertype, idashboardqueryidforoptions, vcdashboardfilterdisplayname) VALUES (
   (select max(idashboardfilterid)+1 from ui.dashboardfilters), '2'::integer, 'Decision'::character varying, '41'::integer, 'Select'::character varying, '35'::integer, 'Decision'::character varying)
    returning idashboardfilterid;

    INSERT INTO ui.dashboardfilters (
    idashboardfilterid, ifilterorder, vcdashboardfiltername, idashboardid, vcdashboardfiltertype, idashboardqueryidforoptions, vcdashboardfilterdisplayname) VALUES (
    (select max(idashboardfilterid)+1 from ui.dashboardfilters), '1'::integer, 'Class'::character varying, '41'::integer, 'Select'::character varying, '34'::integer, 'Class'::character varying)
     returning idashboardfilterid;


     INSERT INTO ui.dashboardfilters (
     idashboardfilterid, ifilterorder, vcdashboardfiltername, idashboardid, vcdashboardfiltertype, idashboardqueryidfordefaultvalue, vcdashboardfilterdisplayname) VALUES (
     (select max(idashboardfilterid)+1 from ui.dashboardfilters), '0'::integer, 'DateRange'::character varying, '41'::integer, 'DateRangePicker'::character varying, '79'::integer, 'Date Range'::character varying)
      returning idashboardfilterid;


INSERT INTO ui.dashboardqueryparameters (
idashboardparameterid, vcparametername, vcparametertype, idashboardqueryid) VALUES (
(select max(idashboardparameterid)+1 from ui.dashboardqueryparameters), 'Load'::character varying, 'Integer'::character varying, '94'::integer)
 returning idashboardparameterid;


INSERT INTO ui.dashboardqueryparameters (
idashboardparameterid, vcparametername, vcparametertype, idashboardqueryid) VALUES (
(select max(idashboardparameterid)+1 from ui.dashboardqueryparameters), 'RiskScore'::character varying, 'Integer'::character varying, '94'::integer)
 returning idashboardparameterid;


 INSERT INTO ui.dashboardqueryparameters (
 idashboardparameterid, vcparametername, vcparametertype, idashboardqueryid) VALUES (
 (select max(idashboardparameterid)+1 from ui.dashboardqueryparameters), 'DateRange'::character varying, 'DateRange'::character varying, '94'::integer)
  returning idashboardparameterid;

INSERT INTO ui.dashboardqueryparameters (
idashboardparameterid, vcparametername, vcparametertype, idashboardqueryid, iorder) VALUES (
(select max(idashboardparameterid)+1 from ui.dashboardqueryparameters), 'Rule'::character varying, 'JsonPath'::character varying, '94'::integer, '2'::integer)
 returning idashboardparameterid;


 INSERT INTO ui.dashboardqueryparameters (
 idashboardparameterid, vcparametername, vcparametertype, idashboardqueryid, iorder) VALUES (
 (select max(idashboardparameterid)+1 from ui.dashboardqueryparameters), 'Decision'::character varying, 'JsonPath'::character varying, '94'::integer, '1'::integer)
  returning idashboardparameterid;

 INSERT INTO ui.dashboardqueryparameters (
 idashboardparameterid, vcparametername, vcparametertype, idashboardqueryid, iorder) VALUES (
 (select max(idashboardparameterid)+1 from ui.dashboardqueryparameters), 'Class'::character varying, 'JsonPath'::character varying, '94'::integer, '0'::integer)
  returning idashboardparameterid;

UPDATE ui.dashboard SET
bdynamic = true::boolean WHERE
idashboardid > 37;

UPDATE ui.dashboardresultset SET
vcdashboardresultsetlayout = '{
       "sizes": [
           1
       ],
       "detail": {
           "main": {
               "type": "tab-area",
               "widgets": [
                   "PERSPECTIVE_GENERATED_ID_1"
               ],
               "currentIndex": 0
           }
       },
       "mode": "globalFilters",
       "viewers": {
           "PERSPECTIVE_GENERATED_ID_1": {
               "plugin": "Datagrid",
               "plugin_config": {
                   "columns": {},
                   "editable": false,
                   "scroll_lock": false
               },
               "settings": false,
               "theme": "Pro Dark",
               "title": "Daily Merchants Onboarded",
               "group_by": [],
               "split_by": [],
               "columns": [],
               "filter": [],
               "sort": [],
               "expressions": [],
               "aggregates": {},
               "master": false,
               "table": "dailymerchantsonboarded",
               "linked": false
           }
       }
   }'::text WHERE
idashboardresultsetid = 47;
