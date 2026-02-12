DELETE FROM ui.dashboardfilters where idashboardid = 79 and itenantid = 12 and vcdashboardfiltername in ('StartStage', 'EndStage');

DELETE FROM ui.dashboardqueryparameters where idashboardqueryid = 171 and itenantid = 12 and vcparametername in ('StartStage', 'EndStage');

UPDATE ui.dashboardqueryparameters SET
iorder = '0'::integer WHERE
idashboardqueryid = 171 AND vcparametername = 'Basis' AND itenantid = 12;

UPDATE ui.dashboardresultset SET
vcdashboardresultsetschema = ' { 
    "Case ID":"integer",
    "Case creation time":"datetime",
    "Alert":"string",
    "Payer":"string",
    "Payee":"string",
    "Amount":"float",
"Closed By":"string",
"Closed On":"datetime"
  }'::text WHERE
idashboardqueryid = 171 AND itenantid = 12;


UPDATE ui.dashboardquery SET
vcfilterparametersjson = '{"Basis":null,"DateRange":null,"CaseType":null,"CountLimit":null}'::text WHERE
idashboardqueryid = 171 AND itenantid = 12;


UPDATE ui.dashboardquery SET
vcdashboardquery = E'{
  "ClosedOn": "WITH ProcessInstances AS ( SELECT pinst.root_proc_inst_id_, pinst.start_time_ AS case_creation_time, pinst.end_time_ AS closed_on, pinst.state_, pinst.proc_def_key_ FROM t12refined.camunda.act_hi_procinst pinst WHERE pinst.end_time_ >= CAST(:StartDate AS DATE) AND pinst.end_time_ < CAST(:EndDate AS DATE) AND pinst.proc_def_key_ = :CaseType ORDER BY pinst.end_time_ DESC LIMIT :CountLimit ), RankedTasks AS ( SELECT task.root_proc_inst_id_, task.id_ AS task_id, task.end_time_ AS task_end_time, task.assignee_ AS assignee, ROW_NUMBER() OVER ( PARTITION BY task.root_proc_inst_id_ ORDER BY task.end_time_ DESC ) AS rn_latest FROM t12refined.camunda.act_hi_taskinst task WHERE task.root_proc_inst_id_ IN ( SELECT root_proc_inst_id_ FROM ProcessInstances ) AND task.end_time_ >= CAST(:StartDate AS DATE) AND task.end_time_ < CAST(:EndDate AS DATE) ), LatestTask AS ( SELECT root_proc_inst_id_, MAX( CASE WHEN rn_latest = 1 THEN task_id END ) AS task_id, MAX( CASE WHEN rn_latest = 1 THEN task_end_time END ) AS task_end_time, MAX( CASE WHEN rn_latest = 1 THEN assignee END ) AS latest_task_assignee FROM RankedTasks GROUP BY root_proc_inst_id_ ), AlertAmountData AS ( SELECT pinst.root_proc_inst_id_, MAX( CASE WHEN var.name_ = ''Alert'' THEN var.text_ END ) AS alert_text, MAX( CASE WHEN var.name_ = ''TransactionAmount'' THEN var.double_ / 100.0 END ) AS amount, MAX( CASE WHEN var.name_ = ''TicketID'' THEN var.long_ END ) AS \\"Case ID\\", MAX( CASE WHEN var.name_ = ''Transaction'' THEN var.bytearray_id_ END ) AS bytearray_id_ FROM ProcessInstances pinst LEFT JOIN t12refined.camunda.act_hi_varinst var ON var.root_proc_inst_id_ = pinst.root_proc_inst_id_ WHERE var.name_ IN ( ''Alert'', ''TransactionAmount'', ''TicketID'', ''Transaction'' ) GROUP BY pinst.root_proc_inst_id_ ), TransactionData AS ( SELECT Txn.root_proc_inst_id_, json_parse(from_utf8(Txnorg.bytes_)) AS transaction_json FROM t12refined.camunda.act_hi_varinst Txn LEFT JOIN t12refined.camunda.act_ge_bytearray Txnorg ON Txnorg.id_ = Txn.bytearray_id_ WHERE Txn.root_proc_inst_id_ IN ( SELECT root_proc_inst_id_ FROM ProcessInstances ) AND Txn.name_ = ''Transaction'' AND Txn.var_type_ = ''json'' ) SELECT AlertAmountData.\\"Case ID\\", pinst.case_creation_time AS \\"Case creation time\\", AlertAmountData.alert_text AS \\"Alert\\", json_extract_scalar( TransactionData.transaction_json, ''$.observations.payerVPA.externalId'' ) AS \\"Payer\\", json_extract_scalar( TransactionData.transaction_json, ''$.observations.payeeVPA.externalId'' ) AS \\"Payee\\", AlertAmountData.amount AS \\"Amount\\", COALESCE(assigneeuser.vcemailid, ''Auto Closed'') AS \\"Closed By\\", pinst.closed_on AS \\"Closed On\\" FROM ProcessInstances pinst LEFT JOIN LatestTask t ON t.root_proc_inst_id_ = pinst.root_proc_inst_id_ LEFT JOIN AlertAmountData ON AlertAmountData.root_proc_inst_id_ = pinst.root_proc_inst_id_ LEFT JOIN TransactionData ON TransactionData.root_proc_inst_id_ = pinst.root_proc_inst_id_ LEFT JOIN postgresql.ui.webuser assigneeuser ON assigneeuser.iuserid = CAST(t.latest_task_assignee AS INTEGER) ORDER BY pinst.closed_on DESC",
  "CreatedOn": "WITH ProcessInstances AS ( SELECT pinst.root_proc_inst_id_, pinst.start_time_ AS case_creation_time, pinst.end_time_ AS closed_on, pinst.state_, pinst.proc_def_key_ FROM t12refined.camunda.act_hi_procinst pinst WHERE pinst.start_time_ >= CAST(:StartDate AS DATE) AND pinst.start_time_ < CAST(:EndDate AS DATE) AND pinst.proc_def_key_ = :CaseType ORDER BY pinst.end_time_ DESC LIMIT :CountLimit ), RankedTasks AS ( SELECT task.root_proc_inst_id_, task.id_ AS task_id, task.end_time_ AS task_end_time, task.assignee_ AS assignee, ROW_NUMBER() OVER ( PARTITION BY task.root_proc_inst_id_ ORDER BY task.end_time_ DESC ) AS rn_latest FROM t12refined.camunda.act_hi_taskinst task WHERE task.root_proc_inst_id_ IN ( SELECT root_proc_inst_id_ FROM ProcessInstances ) AND task.start_time_ >= CAST(:StartDate AS DATE) AND task.start_time_ < CAST(:EndDate AS DATE) ), LatestTask AS ( SELECT root_proc_inst_id_, MAX( CASE WHEN rn_latest = 1 THEN task_id END ) AS task_id, MAX( CASE WHEN rn_latest = 1 THEN task_end_time END ) AS task_end_time, MAX( CASE WHEN rn_latest = 1 THEN assignee END ) AS latest_task_assignee FROM RankedTasks GROUP BY root_proc_inst_id_ ), AlertAmountData AS ( SELECT pinst.root_proc_inst_id_, MAX( CASE WHEN var.name_ = ''Alert'' THEN var.text_ END ) AS alert_text, MAX( CASE WHEN var.name_ = ''TransactionAmount'' THEN var.double_ / 100.0 END ) AS amount, MAX( CASE WHEN var.name_ = ''TicketID'' THEN var.long_ END ) AS \\"Case ID\\", MAX( CASE WHEN var.name_ = ''Transaction'' THEN var.bytearray_id_ END ) AS bytearray_id_ FROM ProcessInstances pinst LEFT JOIN t12refined.camunda.act_hi_varinst var ON var.root_proc_inst_id_ = pinst.root_proc_inst_id_ WHERE var.name_ IN ( ''Alert'', ''TransactionAmount'', ''TicketID'', ''Transaction'' ) GROUP BY pinst.root_proc_inst_id_ ), TransactionData AS ( SELECT Txn.root_proc_inst_id_, json_parse(from_utf8(Txnorg.bytes_)) AS transaction_json FROM t12refined.camunda.act_hi_varinst Txn LEFT JOIN t12refined.camunda.act_ge_bytearray Txnorg ON Txnorg.id_ = Txn.bytearray_id_ WHERE Txn.root_proc_inst_id_ IN ( SELECT root_proc_inst_id_ FROM ProcessInstances ) AND Txn.name_ = ''Transaction'' AND Txn.var_type_ = ''json'' ) SELECT AlertAmountData.\\"Case ID\\", pinst.case_creation_time AS \\"Case creation time\\", AlertAmountData.alert_text AS \\"Alert\\", json_extract_scalar( TransactionData.transaction_json, ''$.observations.payerVPA.externalId'' ) AS \\"Payer\\", json_extract_scalar( TransactionData.transaction_json, ''$.observations.payeeVPA.externalId'' ) AS \\"Payee\\", AlertAmountData.amount AS \\"Amount\\", COALESCE(assigneeuser.vcemailid, ''Auto Closed'') AS \\"Closed By\\", pinst.closed_on AS \\"Closed On\\" FROM ProcessInstances pinst LEFT JOIN LatestTask t ON t.root_proc_inst_id_ = pinst.root_proc_inst_id_ LEFT JOIN AlertAmountData ON AlertAmountData.root_proc_inst_id_ = pinst.root_proc_inst_id_ LEFT JOIN TransactionData ON TransactionData.root_proc_inst_id_ = pinst.root_proc_inst_id_ LEFT JOIN postgresql.ui.webuser assigneeuser ON assigneeuser.iuserid = CAST(t.latest_task_assignee AS INTEGER) ORDER BY pinst.closed_on DESC"
}'::text 
WHERE idashboardqueryid = 171 AND itenantid = 12;

UPDATE ui.dashboardfilters SET
validation = '{
  "limitDays": {
    "limit": true,
    "daysAllowed": 30
  },
  "addDayDateRange": {
    "value": 1
  }
}'::jsonb WHERE
idashboardid = 79 AND itenantid = 12 and vcdashboardfiltername = 'DateRange';
