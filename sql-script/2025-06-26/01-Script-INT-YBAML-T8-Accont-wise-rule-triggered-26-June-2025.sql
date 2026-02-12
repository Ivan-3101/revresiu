CREATE view t8refined.analytics.combined_rule_triggered  AS
SELECT
    t.dttrxntime AS "Txn Date Time",
    t.vcmsgid AS "Unique ID",
    CAST(NULL AS VARCHAR) AS "Txn ID",
    CAST(NULL AS VARCHAR) AS "Payer Customer ID",
    CAST(NULL AS VARCHAR) AS "Payer Account ID",
    CAST(NULL AS VARCHAR) AS "Payer VPA ID",
    CAST(NULL AS VARCHAR) AS "Payee Customer ID",
    CAST(NULL AS VARCHAR) AS "Payee Account ID",
    CAST(NULL AS VARCHAR) AS "Payee VPA ID",
    t.vccustomerexternalid AS "Customer ID",
    t.vcaccountexternalid AS "Account ID",
    t.vcaddr AS "VPA ID",
    t.vcclassname AS "Txn Class",
    CAST(NULL AS DOUBLE) AS "Txn Amount",
    t.vcdecisionname AS "Decision Name",
    t.iruleid AS "Rule ID",
    t.vcrulename AS "Rule Name",
    t.rule_score AS "Score",
    t.vcremark AS "Side",
    t.itenantid AS "Tenant ID"
FROM
    t8refined.analytics.batch_rule_triggered t
UNION ALL
SELECT
    rt.dttrxntime AS "Txn Date Time",
    rt.vcmsgid AS "Unique ID",
    rt.vcuniquetransid AS "Txn ID",
    rt.vcpayercustomerexternalid AS "Payer Customer ID",
    rt.vcpayeraccountexternalid AS "Payer Account ID",
    rt.vcpayeraddr AS "Payer VPA ID",
    rt.vcpayeecustomerexternalid AS "Payee Customer ID",
    rt.vcpayeeaccountexternalid AS "Payee Account ID",
    rt.vcpayeeaddr AS "Payee VPA ID",
    CAST(NULL AS VARCHAR) AS "Customer ID",
    CAST(NULL AS VARCHAR) AS "Account ID",
    CAST(NULL AS VARCHAR) AS "VPA ID",
    rt.vcclassname AS "Txn Class",
    rt.dobservationamount AS "Txn Amount",
    rt.vcdecisionname AS "Decision Name",
    rt.iruleid AS "Rule ID",
    rt.vcrulename AS "Rule Name",
    rt.rule_score AS "Score",
    rt.vcremark AS "Side",
    rt.itenantid AS "Tenant ID"
FROM
    t8refined.analytics.rule_triggered rt;