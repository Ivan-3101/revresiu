--56568
UPDATE ui.dashboardquery SET
vcdashboardquery = '
WITH d1 AS (
    SELECT mappingid
    FROM ui.webusermapping
    WHERE webuserid = :loggedinuser AND mappingtype = ''Workflow'' and iorgid= :orgid
)
SELECT
    CASE
        WHEN task.name_ = ''Review Case'' THEN
            CASE
                WHEN act.text_ = ''Value_Close'' THEN ''Mark as false positive & Close''
                WHEN act.text_ = ''Value_Fraud'' THEN ''Mark as confirmed Fraud''
                WHEN act.text_ = ''Value_Update_Whitelist'' THEN ''Update Whitelist''
                WHEN act.text_ = ''Suspected_Fraud'' THEN ''Mark as suspected fraud''
            END
        WHEN task.name_ = ''Checker Approval'' THEN act2.text_
        ELSE NULL
    END AS "Action",
    CASE
        WHEN task.name_ = ''Review Case'' THEN act.time_
        WHEN task.name_ = ''Checker Approval'' THEN act2.time_
        ELSE NULL
    END AS "DateTime",
    wu.vcusername AS "User",
    task.name_ AS "Stage",
    payer.text_ AS "Payer",
    payee.text_ AS "Payee",
    TransactionAmount.double_ / 100 AS "Amount",
    TicketID.long_ AS "Case ID",
    MerchantName.text_ AS "Merchant Name",
    payee.text_ AS "TID",
    payeeAccount.text_ AS "MID"
FROM
    camunda.act_hi_procinst hiproinst
 JOIN camunda.act_re_procdef pdef ON pdef.id_ = hiproinst.proc_def_id_
 JOIN camunda.act_hi_taskinst task ON task.proc_inst_id_ = hiproinst.proc_inst_id_
left JOIN camunda.act_id_user cuser ON cuser.id_ = task.assignee_
LEFT JOIN camunda.act_hi_varinst payer ON payer.proc_inst_id_ = hiproinst.proc_inst_id_ AND payer.name_ = ''payer''
LEFT JOIN camunda.act_hi_varinst payee ON payee.proc_inst_id_ = hiproinst.proc_inst_id_ AND payee.name_ = ''payee''
LEFT JOIN camunda.act_hi_varinst TransactionAmount ON TransactionAmount.proc_inst_id_ = hiproinst.proc_inst_id_ AND TransactionAmount.name_ = ''TransactionAmount''
LEFT JOIN camunda.act_hi_varinst TicketID ON TicketID.proc_inst_id_ = hiproinst.proc_inst_id_ AND TicketID.name_ = ''TicketID''
LEFT JOIN camunda.act_hi_varinst MerchantName ON MerchantName.proc_inst_id_ = hiproinst.proc_inst_id_ AND MerchantName.name_ = ''merchantname''
LEFT JOIN ui.webuser wu ON wu.iuserid = CAST(task.assignee_ AS INTEGER) and wu.iorgid= :orgid
LEFT JOIN camunda.act_hi_detail act ON act.task_id_ = task.id_ AND act.name_ = ''Action''
LEFT JOIN camunda.act_hi_detail act2 ON act2.proc_inst_id_ = hiproinst.proc_inst_id_ AND act2.name_ = ''checker_action_whitelist''
LEFT JOIN camunda.act_hi_varinst payeeaccount ON payeeaccount.proc_inst_id_ = hiproinst.proc_inst_id_ AND payeeaccount.name_ = ''payeeAccount''
WHERE
    date(hiproinst.start_time_) BETWEEN :StartDate AND :EndDate
    AND hiproinst.state_ != ''EXTERNALLY_TERMINATED''
    AND hiproinst.proc_def_key_ = ''JPB_RiskNotification''
    AND task.name_ = :Stage
    AND hiproinst.tenant_id_ = :tenantidstr
    AND hiproinst.proc_def_key_ IN (
        SELECT workflowkey
        FROM ui.workflowmasters
        WHERE (
            workflowid IN (SELECT mappingid FROM d1)
            OR -1 IN (SELECT mappingid FROM d1)
        )
        AND itenantid = :tenantid
        AND is_filter_display = TRUE
    ) limit 15000;'::text WHERE
idashboardqueryid = 125 AND itenantid in ( 12, 13);