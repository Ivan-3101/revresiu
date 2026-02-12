-- DELETE SCRIPTS
DELETE FROM ui.dashboardresultset WHERE idashboardqueryid = 171 AND itenantid = 12;

DELETE FROM ui.dashboardqueryparameters WHERE idashboardqueryid = 171 AND itenantid = 12;

DELETE FROM ui.dashboardfilters WHERE idashboardid = 79 AND itenantid = 12;

DELETE FROM ui.dashboardquery WHERE idashboardqueryid = 171 AND itenantid = 12;

DELETE FROM ui.dashboard WHERE idashboardid = 79 AND itenantid = 12;

-- INSERT SCRIPTS


INSERT INTO ui.dashboard (
idashboardid, bactive, bdelete, vcdashboardname, iorder, irowcount, imenustructuredesc, itenantid, bdynamic) VALUES (
'79'::integer, true::boolean, false::boolean, 'Closed Cases Report - DL'::character varying, '23'::integer, '1'::integer, '536'::integer, '12'::integer, true::boolean)
 returning idashboardid,itenantid;

INSERT INTO ui.dashboardquery (
idashboardqueryid, bparametersrequired, vcfilterparametersjson, vcdashboardquery, formattingrequiered, runonanalytics, transposerequired, imenustructuredesc, itenantid, dbtype) VALUES (
'171'::integer, true::boolean, '{"Basis":null,"DateRange":null,"CaseType":null,"CountLimit":null}'::text,  E'{
  "ClosedOn": "WITH ProcessInstances AS ( SELECT pinst.root_proc_inst_id_, pinst.start_time_ AS case_creation_time, pinst.end_time_ AS closed_on, pinst.state_, pinst.proc_def_key_ FROM t12refined.camunda.act_hi_procinst pinst WHERE pinst.end_time_ >= CAST(:StartDate AS DATE) AND pinst.end_time_ < CAST(:EndDate AS DATE) AND pinst.proc_def_key_ = :CaseType ORDER BY pinst.end_time_ DESC LIMIT :CountLimit ), RankedTasks AS ( SELECT task.root_proc_inst_id_, task.id_ AS task_id, task.end_time_ AS task_end_time, task.assignee_ AS assignee, ROW_NUMBER() OVER ( PARTITION BY task.root_proc_inst_id_ ORDER BY task.end_time_ DESC ) AS rn_latest FROM t12refined.camunda.act_hi_taskinst task WHERE task.root_proc_inst_id_ IN ( SELECT root_proc_inst_id_ FROM ProcessInstances ) AND task.end_time_ >= CAST(:StartDate AS DATE) AND task.end_time_ < CAST(:EndDate AS DATE) ), LatestTask AS ( SELECT root_proc_inst_id_, MAX( CASE WHEN rn_latest = 1 THEN task_id END ) AS task_id, MAX( CASE WHEN rn_latest = 1 THEN task_end_time END ) AS task_end_time, MAX( CASE WHEN rn_latest = 1 THEN assignee END ) AS latest_task_assignee FROM RankedTasks GROUP BY root_proc_inst_id_ ), AlertAmountData AS ( SELECT pinst.root_proc_inst_id_, MAX( CASE WHEN var.name_ = ''Alert'' THEN var.text_ END ) AS alert_text, MAX( CASE WHEN var.name_ = ''TransactionAmount'' THEN var.double_ / 100.0 END ) AS amount, MAX( CASE WHEN var.name_ = ''TicketID'' THEN var.long_ END ) AS \\"Case ID\\", MAX( CASE WHEN var.name_ = ''Transaction'' THEN var.bytearray_id_ END ) AS bytearray_id_ FROM ProcessInstances pinst LEFT JOIN t12refined.camunda.act_hi_varinst var ON var.root_proc_inst_id_ = pinst.root_proc_inst_id_ WHERE var.name_ IN ( ''Alert'', ''TransactionAmount'', ''TicketID'', ''Transaction'' ) GROUP BY pinst.root_proc_inst_id_ ), TransactionData AS ( SELECT Txn.root_proc_inst_id_, json_parse(from_utf8(Txnorg.bytes_)) AS transaction_json FROM t12refined.camunda.act_hi_varinst Txn LEFT JOIN t12refined.camunda.act_ge_bytearray Txnorg ON Txnorg.id_ = Txn.bytearray_id_ WHERE Txn.root_proc_inst_id_ IN ( SELECT root_proc_inst_id_ FROM ProcessInstances ) AND Txn.name_ = ''Transaction'' AND Txn.var_type_ = ''json'' ) SELECT AlertAmountData.\\"Case ID\\", pinst.case_creation_time AS \\"Case creation time\\", AlertAmountData.alert_text AS \\"Alert\\", json_extract_scalar( TransactionData.transaction_json, ''$.observations.payerVPA.externalId'' ) AS \\"Payer\\", json_extract_scalar( TransactionData.transaction_json, ''$.observations.payeeVPA.externalId'' ) AS \\"Payee\\", AlertAmountData.amount AS \\"Amount\\", COALESCE(assigneeuser.vcemailid, ''Auto Closed'') AS \\"Closed By\\", pinst.closed_on AS \\"Closed On\\" FROM ProcessInstances pinst LEFT JOIN LatestTask t ON t.root_proc_inst_id_ = pinst.root_proc_inst_id_ LEFT JOIN AlertAmountData ON AlertAmountData.root_proc_inst_id_ = pinst.root_proc_inst_id_ LEFT JOIN TransactionData ON TransactionData.root_proc_inst_id_ = pinst.root_proc_inst_id_ LEFT JOIN postgresql.ui.webuser assigneeuser ON assigneeuser.iuserid = CAST(t.latest_task_assignee AS INTEGER) ORDER BY pinst.closed_on DESC",
  "CreatedOn": "WITH ProcessInstances AS ( SELECT pinst.root_proc_inst_id_, pinst.start_time_ AS case_creation_time, pinst.end_time_ AS closed_on, pinst.state_, pinst.proc_def_key_ FROM t12refined.camunda.act_hi_procinst pinst WHERE pinst.start_time_ >= CAST(:StartDate AS DATE) AND pinst.start_time_ < CAST(:EndDate AS DATE) AND pinst.proc_def_key_ = :CaseType ORDER BY pinst.end_time_ DESC LIMIT :CountLimit ), RankedTasks AS ( SELECT task.root_proc_inst_id_, task.id_ AS task_id, task.end_time_ AS task_end_time, task.assignee_ AS assignee, ROW_NUMBER() OVER ( PARTITION BY task.root_proc_inst_id_ ORDER BY task.end_time_ DESC ) AS rn_latest FROM t12refined.camunda.act_hi_taskinst task WHERE task.root_proc_inst_id_ IN ( SELECT root_proc_inst_id_ FROM ProcessInstances ) AND task.start_time_ >= CAST(:StartDate AS DATE) AND task.start_time_ < CAST(:EndDate AS DATE) ), LatestTask AS ( SELECT root_proc_inst_id_, MAX( CASE WHEN rn_latest = 1 THEN task_id END ) AS task_id, MAX( CASE WHEN rn_latest = 1 THEN task_end_time END ) AS task_end_time, MAX( CASE WHEN rn_latest = 1 THEN assignee END ) AS latest_task_assignee FROM RankedTasks GROUP BY root_proc_inst_id_ ), AlertAmountData AS ( SELECT pinst.root_proc_inst_id_, MAX( CASE WHEN var.name_ = ''Alert'' THEN var.text_ END ) AS alert_text, MAX( CASE WHEN var.name_ = ''TransactionAmount'' THEN var.double_ / 100.0 END ) AS amount, MAX( CASE WHEN var.name_ = ''TicketID'' THEN var.long_ END ) AS \\"Case ID\\", MAX( CASE WHEN var.name_ = ''Transaction'' THEN var.bytearray_id_ END ) AS bytearray_id_ FROM ProcessInstances pinst LEFT JOIN t12refined.camunda.act_hi_varinst var ON var.root_proc_inst_id_ = pinst.root_proc_inst_id_ WHERE var.name_ IN ( ''Alert'', ''TransactionAmount'', ''TicketID'', ''Transaction'' ) GROUP BY pinst.root_proc_inst_id_ ), TransactionData AS ( SELECT Txn.root_proc_inst_id_, json_parse(from_utf8(Txnorg.bytes_)) AS transaction_json FROM t12refined.camunda.act_hi_varinst Txn LEFT JOIN t12refined.camunda.act_ge_bytearray Txnorg ON Txnorg.id_ = Txn.bytearray_id_ WHERE Txn.root_proc_inst_id_ IN ( SELECT root_proc_inst_id_ FROM ProcessInstances ) AND Txn.name_ = ''Transaction'' AND Txn.var_type_ = ''json'' ) SELECT AlertAmountData.\\"Case ID\\", pinst.case_creation_time AS \\"Case creation time\\", AlertAmountData.alert_text AS \\"Alert\\", json_extract_scalar( TransactionData.transaction_json, ''$.observations.payerVPA.externalId'' ) AS \\"Payer\\", json_extract_scalar( TransactionData.transaction_json, ''$.observations.payeeVPA.externalId'' ) AS \\"Payee\\", AlertAmountData.amount AS \\"Amount\\", COALESCE(assigneeuser.vcemailid, ''Auto Closed'') AS \\"Closed By\\", pinst.closed_on AS \\"Closed On\\" FROM ProcessInstances pinst LEFT JOIN LatestTask t ON t.root_proc_inst_id_ = pinst.root_proc_inst_id_ LEFT JOIN AlertAmountData ON AlertAmountData.root_proc_inst_id_ = pinst.root_proc_inst_id_ LEFT JOIN TransactionData ON TransactionData.root_proc_inst_id_ = pinst.root_proc_inst_id_ LEFT JOIN postgresql.ui.webuser assigneeuser ON assigneeuser.iuserid = CAST(t.latest_task_assignee AS INTEGER) ORDER BY pinst.closed_on DESC"
}'::text, false::boolean, false::boolean, false::boolean, '536'::integer, '12'::integer, '3'::integer)
 returning idashboardqueryid,itenantid;

INSERT INTO ui.dashboardresultset (
idashboardresultsetid, vcdashboardresultsetlayout, vcdashboardresultsetname, idashboardqueryid, idashboardid, vcdashboardresultsetschema, irowno, itenantid) VALUES (
(SELECT max(idashboardresultsetid)+1 FROM ui.dashboardresultset), '{"sizes":[1],"detail":{"main":{"type":"tab-area","widgets":["PERSPECTIVE_GENERATED_ID_1"],"currentIndex":0}},"mode":"globalFilters","viewers":{"PERSPECTIVE_GENERATED_ID_1":{"plugin":"Datagrid","plugin_config":{"columns":{},"editable":false,"scroll_lock":false},"settings":false,"theme":"Pro Dark","title":"Closed Cases Report","group_by":[],"split_by":[],"columns":["Case ID","Case Type","Alert","Payer","Amount","Payee","Closed By","Closed On","Ticket Created Date"],"filter":[],"sort":[],"expressions":[],"aggregates":{},"master":false,"table":"closedcases","linked":false}}}
'::text, 'closedcases'::character varying, '171'::integer, '79'::integer, '{ 
    "Case ID":"integer",
    "Case creation time":"datetime",
    "Alert":"string",
    "Payer":"string",
    "Payee":"string",
    "Amount":"float",
"Closed By":"string",
"Closed On":"datetime"
  }'::text, '1'::integer, '12'::integer)
 returning idashboardresultsetid,itenantid;

WITH max_filter_id AS (
    SELECT COALESCE(MAX(idashboardfilterid), 0) AS current_max 
    FROM ui.dashboardfilters  
)
INSERT INTO ui.dashboardfilters (  
    idashboardfilterid, 
    ifilterorder, 
    vcdashboardfiltername, 
    idashboardid, 
    vcdashboardfiltertype, 
    idashboardqueryidfordefaultvalue, 
    idashboardqueryidforoptions, 
    itenantid, 
    vcdashboardfilterdisplayname, 
    validation
) VALUES 
    ((SELECT current_max + 1 FROM max_filter_id), 1, 'Basis', 79, 'Select', NULL, 71, 12, 'Basis', NULL),
    ((SELECT current_max + 2 FROM max_filter_id), 2, 'DateRange', 79, 'DateRangePicker', 72, NULL, 12, 'Date Range', '{
  "limitDays": {
    "limit": true,
    "daysAllowed": 30
  },
  "addDayDateRange": {
    "value": 1
  }
}'),
    ((SELECT current_max + 3 FROM max_filter_id), 3, 'CountLimit', 79, 'Select', NULL, 143, 12, 'Limit', NULL),
    ((SELECT current_max + 4 FROM max_filter_id), 0, 'CaseType', 79, 'Select', NULL, 144, 12, 'Case Type', NULL);


WITH max_param_id AS (
    SELECT COALESCE(MAX(idashboardparameterid), 0) AS current_max 
    FROM ui.dashboardqueryparameters
)
INSERT INTO ui.dashboardqueryparameters (
    idashboardparameterid,
    vcparametername,
    vcparametertype,
    idashboardqueryid,
    iorder,
    itenantid,
    validation
) VALUES 
    ((SELECT current_max + 1 FROM max_param_id), 'CaseType', 'String', 171, NULL, 12, NULL),
    ((SELECT current_max + 2 FROM max_param_id), 'DateRange', 'DateRange', 171, NULL,12, NULL),
    ((SELECT current_max + 3 FROM max_param_id), 'Basis', 'JsonPath', 171, 0,12, NULL),
    ((SELECT current_max + 4 FROM max_param_id), 'CountLimit', 'Integer', 171, NULL,12, NULL);
