UPDATE ui.dashboardquery SET
vcdashboardquery = 'SELECT X.*  
FROM (VALUES
       (''Exception Cases :- Hold Intiation'', ''Exception Cases :- Hold Intiation''),
       (''Release Response Not Received'', ''Release Response Not Received''),
       (''Hold Settlement Down'', ''Hold Settlement Down''),
       (''Review Case Checker by L+1'', ''Review Case Checker by L+1''),
       (''Exception Cases :- Hold Status Failed'', ''Exception Cases :- Hold Status Failed''),
       (''Review Response Checker L+1'', ''Review Response Checker L+1''),
       (''Hold Response Not Received'', ''Hold Response Not Received''),
       (''Exception Cases'', ''Exception Cases''),
       (''Review Confirm Frauds'', ''Review Confirm Frauds''),
       (''Review Response by RA'', ''Review Response by RA''),
       (''Review Response By RA L+1'', ''Review Response By RA L+1''),
       (''Review Case By RA L+1'', ''Review Case By RA L+1''),
       (''Review Case By RA'', ''Review Case By RA'')
     ) AS X ("label", "value");'::text WHERE
idashboardqueryid = 124 AND itenantid = 27;




UPDATE ui.dashboardquery SET
vcdashboardquery = 'SELECT 
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
    payeeAccount.text_ as "MID"
FROM 
    camunda.act_hi_procinst hiproinst 
    FULL OUTER JOIN camunda.act_re_procdef pdef ON pdef.id_ = hiproinst.proc_def_id_
    FULL OUTER JOIN camunda.act_hi_taskinst task ON task.proc_inst_id_ = hiproinst.proc_inst_id_ 
    LEFT JOIN camunda.act_id_user cuser ON cuser.id_ = task.assignee_ 
    FULL OUTER JOIN camunda.act_hi_varinst payer ON payer.proc_inst_id_ = hiproinst.proc_inst_id_ 
        AND payer.name_ = ''payer''
    FULL OUTER JOIN camunda.act_hi_varinst payee ON payee.proc_inst_id_ = hiproinst.proc_inst_id_ 
        AND payee.name_ = ''payee''
    FULL OUTER JOIN camunda.act_hi_varinst TransactionAmount ON TransactionAmount.proc_inst_id_ = hiproinst.proc_inst_id_ 
        AND TransactionAmount.name_ = ''TransactionAmount''
    FULL OUTER JOIN camunda.act_hi_varinst TicketID ON TicketID.proc_inst_id_ = hiproinst.proc_inst_id_ 
        AND TicketID.name_ = ''TicketID'' 
    FULL OUTER JOIN camunda.act_hi_varinst MerchantName ON MerchantName.proc_inst_id_ = hiproinst.proc_inst_id_ 
        AND MerchantName.name_ = ''merchantname''
    LEFT JOIN ui.webuser wu ON wu.iuserid = CAST(task.assignee_ AS INTEGER)
    LEFT JOIN camunda.act_hi_detail act ON act.task_id_ = task.id_ AND act.name_ = ''Action''
    LEFT JOIN camunda.act_hi_detail act2 ON act2.proc_inst_id_ = hiproinst.proc_inst_id_ AND act2.name_ = ''checker_action_whitelist''
    FULL OUTER JOIN camunda.act_hi_varinst payeeAccount ON payeeAccount.proc_inst_id_ = hiproinst.proc_inst_id_ 
            AND payeeAccount.name_ = ''payeeAccount''
WHERE 
    CAST(hiproinst.start_time_ AS DATE) BETWEEN CAST(:StartDate AS DATE) AND CAST(:EndDate AS DATE)
    AND hiproinst.state_ != ''EXTERNALLY_TERMINATED'' 
    AND hiproinst.proc_def_key_ IN (
        WITH d1 AS (
            SELECT mappingid 
            FROM ui.webusermapping 
            WHERE webuserid = :loggedinuser AND mappingtype = ''Workflow''
        )
        SELECT workflowkey 
        FROM ui.workflowmasters 
        WHERE (
            workflowid IN (SELECT mappingid FROM d1)
            OR -1 IN (SELECT mappingid FROM d1)
        ) 
        AND itenantid = :tenantid
        AND is_filter_display = TRUE
    )
    AND hiproinst.tenant_id_ = :tenantidstr
    AND hiproinst.proc_def_key_ = ''RiskyMerchantSettlements''
    AND task.name_ = :Stage limit 10000'::text WHERE
idashboardqueryid = 125 AND itenantid = 10;