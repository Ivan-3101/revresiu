delete from ui.dashboardqueryparameters where idashboardqueryid in (170,169,168,145);

delete from ui.dashboardquery where idashboardqueryid in (170,169,168,145);

INSERT INTO ui.dashboardquery (
    idashboardqueryid, bparametersrequired, vcfilterparametersjson, 
    vcdashboardquery, formattingrequiered, runonanalytics, transposerequired, 
    imenustructuredesc, itenantid, dbtype
)
SELECT 
    145, TRUE,
    '{"placeholders": null, "workflowkey": null}',
    'SELECT proinst.business_key_ AS txnid, proinst.id_ AS processid, task.task_def_key_ AS taskdefkey, task.id_ AS taskid, ticketid.long_ AS ticketid FROM camunda.act_hi_procinst proinst INNER JOIN camunda.act_ru_task task ON task.proc_inst_id_ = proinst.id_ INNER JOIN camunda.act_ru_variable ticketid ON ticketid.proc_inst_id_ = proinst.id_ AND ticketid.name_ = ''TicketID'' WHERE proinst.business_key_ IN (:placeholders) AND proinst.state_ = ''ACTIVE'' AND proinst.proc_def_key_ = :workflowkey;',
    FALSE, FALSE, FALSE,
    479, t.itenantid, 1
FROM ui.tenants t
WHERE t.itenantid in (5,6,7,9,10,12,13,14,15,16,17,19,20,21,22,23,24,25)
RETURNING idashboardqueryid, itenantid;


INSERT INTO ui.dashboardquery (
    idashboardqueryid, bparametersrequired, vcfilterparametersjson, 
    vcdashboardquery, formattingrequiered, runonanalytics, transposerequired, 
    imenustructuredesc, itenantid, dbtype
)
SELECT 
    168, TRUE,
    '{"QueryType": null, "Role": null, "address": null, "date": null, "limit": null, "vcuniquetransid": null}',
  '{
  "Multiple":{
    "Payer": "SELECT vcmsgid, observations->''txn''->>''id'' as \"transactionid\", observations->''txn''->''attribs''->>''txn_type'' as \"txn_type\", observations->''txn''->''attribs''->>''acquirer_name'' as \"acquirer_name\", observations->''txn''->>''class'' as \"class\", observations->''txn''->>''ts'' as \"transaction_timestamp\", round(cast(observations->''payee''->>''amount'' as integer)/100, 2) as \"transaction_amount\", observations->''payee''->>''addr'' as \"payee_vpa\", observations->''payer''->>''addr'' as \"payer_vpa\", risk_override as \"statuscode\", risk_context as \"statusinfo\", observations->''observations''->''payerVPA''->>''vpaName'' as \"payer_name\", score FROM analytics.trans WHERE itenantid = :tenantid and vcpayeraddr = :address AND dttrxntime BETWEEN cast(cast(:date as date) as timestamp) AND cast((cast(:date as date) +1) as timestamp) AND risk_override != 1 and vcuniquetransid != :vcuniquetransid order by dttrxntime limit :limit",
    "Payee": "SELECT vcmsgid, observations->''txn''->>''id'' as \"transactionid\", observations->''txn''->''attribs''->>''txn_type'' as \"txn_type\", observations->''txn''->''attribs''->>''acquirer_name'' as \"acquirer_name\", observations->''txn''->>''class'' as \"class\", observations->''txn''->>''ts'' as \"transaction_timestamp\", round(cast(observations->''payee''->>''amount'' as integer)/100, 2) as \"transaction_amount\", observations->''payee''->>''addr'' as \"payee_vpa\", observations->''payer''->>''addr'' as \"payer_vpa\", risk_override as \"statuscode\", risk_context as \"statusinfo\", observations->''observations''->''payerVPA''->>''vpaName'' as \"payer_name\", score FROM analytics.trans WHERE itenantid = :tenantid and vcpayeeaddr = :address AND dttrxntime BETWEEN cast(cast(:date as date) as timestamp) AND cast((cast(:date as date) +1) as timestamp) AND risk_override != 1 and vcuniquetransid != :vcuniquetransid order by dttrxntime limit :limit"
  },
  "Single":{
    "Payer": "SELECT vcmsgid, observations->''txn''->>''id'' as \"transactionid\", observations->''txn''->''attribs''->>''txn_type'' as \"txn_type\", observations->''txn''->''attribs''->>''acquirer_name'' as \"acquirer_name\", observations->''txn''->>''class'' as \"class\", observations->''txn''->>''ts'' as \"transaction_timestamp\", round(cast(observations->''payee''->>''amount'' as integer)/100, 2) as \"transaction_amount\", observations->''payee''->>''addr'' as \"payee_vpa\", observations->''payer''->>''addr'' as \"payer_vpa\", risk_override as \"statuscode\", risk_context as \"statusinfo\", observations->''observations''->''payerVPA''->>''vpaName'' as \"payer_name\", score FROM analytics.trans WHERE itenantid = :tenantid and vcpayeraddr = :address AND dttrxntime BETWEEN cast(cast(:date as date) as timestamp) AND cast((cast(:date as date) +1) as timestamp) AND risk_override != 1 and vcuniquetransid = :vcuniquetransid",
    "Payee": "SELECT vcmsgid, observations->''txn''->>''id'' as \"transactionid\", observations->''txn''->''attribs''->>''txn_type'' as \"txn_type\", observations->''txn''->''attribs''->>''acquirer_name'' as \"acquirer_name\", observations->''txn''->>''class'' as \"class\", observations->''txn''->>''ts'' as \"transaction_timestamp\", round(cast(observations->''payee''->>''amount'' as integer)/100, 2) as \"transaction_amount\", observations->''payee''->>''addr'' as \"payee_vpa\", observations->''payer''->>''addr'' as \"payer_vpa\", risk_override as \"statuscode\", risk_context as \"statusinfo\", observations->''observations''->''payerVPA''->>''vpaName'' as \"payer_name\", score FROM analytics.trans WHERE itenantid = :tenantid and vcpayeeaddr = :address AND dttrxntime BETWEEN cast(cast(:date as date) as timestamp) AND cast((cast(:date as date) +1) as timestamp) AND risk_override != 1 and vcuniquetransid = :vcuniquetransid"
  }
}',
    FALSE, FALSE, FALSE,
    479, t.itenantid, 1
FROM ui.tenants t
WHERE t.itenantid in (5,6,7,9,10,12,13,14,15,16,17,19,20,21,22,23,24,25)
RETURNING idashboardqueryid, itenantid;


INSERT INTO ui.dashboardquery (
    idashboardqueryid, bparametersrequired, vcfilterparametersjson, 
    vcdashboardquery, formattingrequiered, runonanalytics, transposerequired, 
    imenustructuredesc, itenantid, dbtype
)
SELECT 
    169, TRUE,
    '{"Party": null, "address": null}',
    '{
        "Account":"SELECT iaccountid FROM masters.accounts WHERE vcexternalaccountid = :address and itenantid = :tenantid",
        "VPA": "SELECT ivpaid FROM masters.vpa WHERE vcexternaladdressid = :address and itenantid = :tenantid"
    }',
    FALSE, TRUE, FALSE,
    578, t.itenantid, 2
FROM ui.tenants t
WHERE t.itenantid in (5,6,7,9,10,12,13,14,15,16,17,19,20,21,22,23,24,25)
RETURNING idashboardqueryid, itenantid;

INSERT INTO ui.dashboardquery (
    idashboardqueryid, bparametersrequired, vcfilterparametersjson, 
    vcdashboardquery, formattingrequiered, runonanalytics, transposerequired, 
    imenustructuredesc, itenantid, dbtype
)
SELECT 
    170, TRUE,
    '{"Party": null, "address": null, "transid": null}',
    '{
    "Account":"SELECT cast(observations as text), cast(result as text), vcpayeeaddr, vcpayeraddr, vcpayeeaccountexternalid, vcpayeraccountexternalid, risk_override, risk_context->>''caseId'' as \"caseId\" FROM analytics.trans WHERE (vcpayeeaccountexternalid = :address OR vcpayeraccountexternalid = :address) AND vcuniquetransid = :transid and itenantid = :tenantid",
    "VPA": "SELECT cast(observations as text), cast(result as text), vcpayeeaddr, vcpayeraddr, vcpayeeaccountexternalid, vcpayeraccountexternalid, risk_override, risk_context->>''caseId'' as \"caseId\" FROM analytics.trans WHERE (vcpayeeaddr = :address OR vcpayeraddr = :address) AND vcuniquetransid = :transid and itenantid = :tenantid"
     }',
    FALSE, TRUE, FALSE,
    578, t.itenantid, 2
FROM ui.tenants t
WHERE t.itenantid in (5,6,7,9,10,12,13,14,15,16,17,19,20,21,22,23,24,25)
RETURNING idashboardqueryid, itenantid;


--------------
INSERT INTO ui.dashboardqueryparameters (
    idashboardparameterid, vcparametername, vcparametertype, idashboardqueryid, itenantid
)
SELECT 
    (SELECT max(idashboardparameterid) + 1 FROM ui.dashboardqueryparameters)::integer,
    'placeholders', 'List<String>', 145, t.itenantid
FROM ui.tenants t
WHERE t.itenantid in (5,6,7,9,10,12,13,14,15,16,17,19,20,21,22,23,24,25)
RETURNING idashboardparameterid, itenantid;

INSERT INTO ui.dashboardqueryparameters (
    idashboardparameterid, vcparametername, vcparametertype, idashboardqueryid, itenantid
)
SELECT 
    (SELECT max(idashboardparameterid) + 1 FROM ui.dashboardqueryparameters)::integer,
    'workflowkey', 'String', 145, t.itenantid
FROM ui.tenants t
WHERE t.itenantid in (5,6,7,9,10,12,13,14,15,16,17,19,20,21,22,23,24,25)
RETURNING idashboardparameterid, itenantid;

INSERT INTO ui.dashboardqueryparameters (
    idashboardparameterid, vcparametername, vcparametertype, idashboardqueryid, iorder, itenantid
)
SELECT 
    (SELECT max(idashboardparameterid) + 1 FROM ui.dashboardqueryparameters)::integer,
    'QueryType', 'JsonPath', 168, 0, t.itenantid
FROM ui.tenants t
WHERE t.itenantid in (5,6,7,9,10,12,13,14,15,16,17,19,20,21,22,23,24,25)
RETURNING idashboardparameterid, itenantid;

INSERT INTO ui.dashboardqueryparameters (
    idashboardparameterid, vcparametername, vcparametertype, idashboardqueryid, iorder, itenantid
)
SELECT 
    (SELECT max(idashboardparameterid) + 1 FROM ui.dashboardqueryparameters)::integer,
    'Role', 'JsonPath', 168, 1, t.itenantid
FROM ui.tenants t
WHERE t.itenantid in (5,6,7,9,10,12,13,14,15,16,17,19,20,21,22,23,24,25)
RETURNING idashboardparameterid, itenantid;

INSERT INTO ui.dashboardqueryparameters (
    idashboardparameterid, vcparametername, vcparametertype, idashboardqueryid, itenantid
)
SELECT 
    (SELECT max(idashboardparameterid) + 1 FROM ui.dashboardqueryparameters)::integer,
    'address', 'String', 168, t.itenantid
FROM ui.tenants t
WHERE t.itenantid in (5,6,7,9,10,12,13,14,15,16,17,19,20,21,22,23,24,25)
RETURNING idashboardparameterid, itenantid;

INSERT INTO ui.dashboardqueryparameters (
    idashboardparameterid, vcparametername, vcparametertype, idashboardqueryid, itenantid
)
SELECT 
    (SELECT max(idashboardparameterid) + 1 FROM ui.dashboardqueryparameters)::integer,
    'date', 'String', 168, t.itenantid
FROM ui.tenants t
WHERE t.itenantid in (5,6,7,9,10,12,13,14,15,16,17,19,20,21,22,23,24,25)
RETURNING idashboardparameterid, itenantid;

INSERT INTO ui.dashboardqueryparameters (
    idashboardparameterid, vcparametername, vcparametertype, idashboardqueryid, itenantid
)
SELECT 
    (SELECT max(idashboardparameterid) + 1 FROM ui.dashboardqueryparameters)::integer,
    'limit', 'Integer', 168, t.itenantid
FROM ui.tenants t
WHERE t.itenantid in (5,6,7,9,10,12,13,14,15,16,17,19,20,21,22,23,24,25)
RETURNING idashboardparameterid, itenantid;

INSERT INTO ui.dashboardqueryparameters (
    idashboardparameterid, vcparametername, vcparametertype, idashboardqueryid, itenantid
)
SELECT 
    (SELECT max(idashboardparameterid) + 1 FROM ui.dashboardqueryparameters)::integer,
    'vcuniquetransid', 'String', 168, t.itenantid
FROM ui.tenants t
WHERE t.itenantid in (5,6,7,9,10,12,13,14,15,16,17,19,20,21,22,23,24,25)
RETURNING idashboardparameterid, itenantid;

INSERT INTO ui.dashboardqueryparameters (
    idashboardparameterid, vcparametername, vcparametertype, idashboardqueryid, iorder, itenantid
)
SELECT 
    (SELECT max(idashboardparameterid) + 1 FROM ui.dashboardqueryparameters)::integer,
    'Party', 'JsonPath', 169, 0, t.itenantid
FROM ui.tenants t
WHERE t.itenantid in (5,6,7,9,10,12,13,14,15,16,17,19,20,21,22,23,24,25)
RETURNING idashboardparameterid, itenantid;

INSERT INTO ui.dashboardqueryparameters (
    idashboardparameterid, vcparametername, vcparametertype, idashboardqueryid, itenantid
)
SELECT 
    (SELECT max(idashboardparameterid) + 1 FROM ui.dashboardqueryparameters)::integer,
    'address', 'String', 169, t.itenantid
FROM ui.tenants t
WHERE t.itenantid in (5,6,7,9,10,12,13,14,15,16,17,19,20,21,22,23,24,25)
RETURNING idashboardparameterid, itenantid;

INSERT INTO ui.dashboardqueryparameters (
    idashboardparameterid, vcparametername, vcparametertype, idashboardqueryid, iorder, itenantid
)
SELECT 
    (SELECT max(idashboardparameterid) + 1 FROM ui.dashboardqueryparameters)::integer,
    'Party', 'JsonPath', 170, 0, t.itenantid
FROM ui.tenants t
WHERE t.itenantid in (5,6,7,9,10,12,13,14,15,16,17,19,20,21,22,23,24,25)
RETURNING idashboardparameterid, itenantid;

INSERT INTO ui.dashboardqueryparameters (
    idashboardparameterid, vcparametername, vcparametertype, idashboardqueryid, itenantid
)
SELECT 
    (SELECT max(idashboardparameterid) + 1 FROM ui.dashboardqueryparameters)::integer,
    'address', 'String', 170, t.itenantid
FROM ui.tenants t
WHERE t.itenantid in (5,6,7,9,10,12,13,14,15,16,17,19,20,21,22,23,24,25)
RETURNING idashboardparameterid, itenantid;

INSERT INTO ui.dashboardqueryparameters (
    idashboardparameterid, vcparametername, vcparametertype, idashboardqueryid, itenantid
)
SELECT 
    (SELECT max(idashboardparameterid) + 1 FROM ui.dashboardqueryparameters)::integer,
    'transid', 'String', 170, t.itenantid
FROM ui.tenants t
WHERE t.itenantid in (5,6,7,9,10,12,13,14,15,16,17,19,20,21,22,23,24,25)
RETURNING idashboardparameterid, itenantid;
