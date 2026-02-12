
INSERT INTO ui.dashboard(idashboardid, bactive, bdelete, vcdashboardname, iorder, irowcount, imenustructuredesc, itenantid, bdynamic) 
	select 62, true, false, 'Alert Disposition Report', 62, 1, 536,itenantid, true  FROM 
ui.tenants where iorgid = 7;

INSERT INTO ui.dashboardfilters(idashboardfilterid, ifilterorder, vcdashboardfiltername, idashboardid, vcdashboardfiltertype,
 idashboardqueryidfordefaultvalue, idashboardqueryidforoptions, itenantid, vcdashboardfilterdisplayname) 
 SELECT 167,0,'DateRange',62,'DateRangePicker',79,NULL,t.itenantid, 'Date Range' FROM ui.tenants t WHERE 
 t.iorgid = 7;


INSERT INTO ui.dashboardquery(idashboardqueryid, bparametersrequired, vcfilterparametersjson, vcdashboardquery,
 formattingrequiered, runonanalytics, transposerequired, imenustructuredesc, itenantid)
  SELECT 124,FALSE,NULL,'SELECT X.* FROM   (VALUES
				   (''Review Case'', ''Review Case''),
				   (''Checker Approval'', ''Checker Approval'')
				  ) AS X ("label", "value")',FALSE,FALSE,FALSE,536, t.itenantid FROM ui.tenants t WHERE itenantid != 0 AND t.iorgid = 7;



 INSERT INTO ui.dashboardfilters(idashboardfilterid, ifilterorder, vcdashboardfiltername, idashboardid, vcdashboardfiltertype,
 idashboardqueryidfordefaultvalue, idashboardqueryidforoptions, itenantid, vcdashboardfilterdisplayname) 
 SELECT 168,1,'Stage',62,'Select',null,124,t.itenantid, 'Stage' FROM ui.tenants t WHERE 
 t.iorgid = 7;


 


INSERT INTO ui.dashboardquery(
    idashboardqueryid, 
    bparametersrequired, 
    vcfilterparametersjson, 
    vcdashboardquery, 
    formattingrequiered, 
    runonanalytics, 
    transposerequired, 
    imenustructuredesc, 
    itenantid
)
 SELECT 
    125,
    FALSE,
    '{
        "Stage": null, 
        "DateRange": null
    }',
    'SELECT 
        CASE
            WHEN task.name_ = ''Review Case'' THEN 
                CASE 
                    WHEN act.text_ = ''Value_Close'' THEN ''Mark as false positive & Close''
                    WHEN act.text_ = ''Value_Fraud'' THEN ''Mark as confirmed Fraud''
                    WHEN act.text_ = ''Value_Update_Whitelist'' THEN ''Update Whitelist''
                END
            WHEN task.name_ = ''Checker Approval'' THEN act2.text_
            ELSE NULL
        END AS "Action[Previous disposition]",
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
        LEFT JOIN camunda.act_hi_detail act2 ON act2.task_id_ = task.id_ AND act2.name_ = ''checker_action_whitelist''
        FULL OUTER JOIN camunda.act_hi_varinst payeeaccount ON payeeaccount.proc_inst_id_ = hiproinst.proc_inst_id_ 
            AND TicketID.name_ = ''payeeAccount''
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
        AND hiproinst.proc_def_key_ = ''JPB_RiskNotification''
        AND task.name_ = :Stage',
    FALSE,
    FALSE,
    FALSE,
    536,
    t.itenantid 
FROM ui.tenants t 
WHERE t.iorgid = 7;


INSERT INTO ui.dashboardqueryparameters(idashboardparameterid, vcparametername, vcparametertype, idashboardqueryid,
 iorder, itenantid) SELECT 261,'DateRange','DateRange',125,NULL, t.itenantid FROM ui.tenants t WHERE t.iorgid = 7;


INSERT INTO ui.dashboardqueryparameters(idashboardparameterid, vcparametername, vcparametertype, idashboardqueryid,
 iorder, itenantid) SELECT 262,'Stage','String',125,NULL, t.itenantid FROM ui.tenants t WHERE t.iorgid = 7;



INSERT INTO ui.dashboardresultset(idashboardresultsetid, iresultsetorder, vcdashboardresultsetcolumnjson, 
vcdashboardresultsetlayout, vcdashboardresultsetname, idashboardqueryid, idashboardid, vcdashboardresultsetschema, 
icolsize, irowno, dtlastupdatedtimestamp, iuserid, imenustructuredesc, itenantid, iorgid)
 SELECT 222,NULL,NULL,'{"sizes":[1],"detail":{"main":{"type":"tab-area","widgets":["PERSPECTIVE_GENERATED_ID_1"],
 "currentIndex":0}},"mode":"globalFilters","viewers":{"PERSPECTIVE_GENERATED_ID_1":{"plugin":"Datagrid",
 "plugin_config":{"columns":{},"editable":false,"scroll_lock":true},"settings":false,"theme":"Pro Dark"
 ,"title":"Alert Disposition Report","group_by":[],"split_by":[],"columns":[],
 "filter":[],"sort":[],"expressions":[],"aggregates":{},"master":false,"table":"alertdispositionreport","linked":false}}} ',
 'alertdispositionreport',125,62,'{
    "Action[Previous disposition]":"string", 
    "DateTime":"datetime",
    "User":"string",
    "Stage":"string",
    "Payer":"string",
    "Payee":"string",
	"Merchant Name":"string",
    "MID":"string",
  "TID":"string",
    "Case ID":"integer"
}',NULL,1,NULL,NULL,536,t.itenantid,iorgid FROM ui.tenants t WHERE 
 t.iorgid = 7;


UPDATE ui.dashboardresultset SET
vcdashboardresultsetschema = '{
    "Timestamp": "datetime",
    "Txn id": "string",
    "Original Txn ID": "string",
    "Capture Method": "string",
    "Note": "string",
    "Application": "string",
    "Status": "string",
    "Mode": "string",
    "Class": "string",
    "Type": "string",
    "Subtype": "string",
    "Initiating entity ID": "string",
    "Processing entity ID": "string",
    "Invoice": "string",
    "Remarks": "string",
    "Reference Number": "string",
    "Processor Txn ID": "string",
    "Idempotent Key": "string",
    "Currency": "string",
    "Service Type": "string",
    "Service Category": "string",
    "Payee Narration": "string",
    "agent Id": "string",
    "Agent User Id": "string",
    "Live Mode": "string",
    "Payment Gateway": "string",
    "Txn amount": "float",
    "Gross Amt": "float",
    "Initiator User ID": "string",
    "Initiator Customer ID": "string",
    "Initiator Type": "string",
    "Initiator VPA": "string",
    "Initiator Country code": "string",
    "Initiator Mobile Number": "string",
    "Initiated By": "string",
    "Payer user ID": "string",
    "Payer user ID": "string",
    "Payer type": "string",
    "Payer name": "string",
    "Payer addr": "string",
    "Country Code": "string",
    "Payer Mobile Number": "string",
    "Payer Account Number": "string",
    "Payer IFSC": "string",
    "Payer Bank Name": "string",
    "Payer Account Type": "string",
    "Payer MMID": "string",
    "Payer Card": "string",
    "Payer Aadhar": "string",
    "Payee UserId": "string",
    "Payee Type": "string",
    "Payee MMID": "string",
    "Payee MCC": "integer",
    "Payee Terminal ID": "string",
    "Payee Merchant ID": "string",
    "Payee Name": "string",
    "Country Code": "string",
    "Payee Mobile Number": "string",
    "Payee Addr": "string",
    "Payee Account Number": "string",
    "Payee Account Type": "string",
    "Payee IFSC": "string",
    "Payee Bank Name": "string",
    "Payee card": "string",
    "Payee Aadhar": "string",
    "Geocode": "string",
    "Location": "string",
    "IP": "string",
    "Device Type": "string",
    "Device ID": "string",
    "Device OS": "string",
    "OS Version": "float",
    "Device App": "string",
    "Device Capability": "string",
    "Sdk Version": "string",
    "Device Mobile": "string",
    "payee_account_PT10M_txn_count": "integer",
    "payee_account_PT10M_txn_value": "float",
    "payer_account_d01_txn_value": "float",
    "payer_account_allchannels_d01_txn_value": "float",
    "same_payer_account_payee_d01_txn_count": "integer",
    "payee_account_loadmoney_creditcard_p1d_txn_count": "integer",
    "payee_account_loadmoney_creditcard_p1d_txn_value": "float",
    "same_ifsc_neft_rtgs_payee_acc_unique_d01_count": "integer",
    "payer_account_UPI_d01_txn_value": "float",
    "payee_account_loadmoney_p1d_txn_count": "integer",
    "payee_account_loadmoney_p1d_txn_value": "float",
    "payee_account_loadmoney_99_pt12h_txn_count": "integer",
    "payer_account_imps_p1d_txn_count": "float",
    "payer_unique_payee_acc_d01_txn_count": "integer",
    "payer_account_imps_p1d_txn_value": "float",
    "same_payer_account_p2m_pt1m_txn_count": "integer",
    "payee_account_UPI_d01_txn_value": "float",
    "payee_account_UPI_d01_txn_count": "integer",
    "payee_account_neft_p1d_txn_count": "integer",
    "payee_account_neft_p1d_txn_value": "float",
    "same_ifsc_neft_rtgs_d01_txn_count": "integer",
    "same_ifsc_neft_rtgs_d01_txn_value": "float",
    "payer_account_rtgs_p1d_txn_count": "integer"
}'::text WHERE
idashboardresultsetid = 58 AND itenantid = 10;


UPDATE ui.dashboardresultset SET
vcdashboardresultsetschema = '{
    "Txn Date Time" : "datetime",
    "Txn ID" : "string",
    "Merchant Name":"string",
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
    }'::text WHERE
idashboardresultsetid = 48 AND itenantid = 10;

UPDATE ui.dashboardquery 
SET vcdashboardquery = 
'SELECT 
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
    FULL OUTER JOIN camunda.act_hi_varinst payeeaccount ON payeeaccount.proc_inst_id_ = hiproinst.proc_inst_id_ 
            AND TicketID.name_ = ''payeeAccount''
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
    AND hiproinst.proc_def_key_ = ''JPB_RiskNotification''
    AND task.name_ = :Stage'
WHERE idashboardqueryid = 125;


update ui.dashboardresultset set 
vcdashboardresultsetschema = '{
    "Action":"string", 
    "DateTime":"datetime",
    "User":"string",
    "Stage":"string",
    "Payer":"string",
    "Payee":"string",
	"Merchant Name":"string",
  "TID":"string",
    "Case ID":"integer"	
}'
where idashboardresultsetid =222



UPDATE ui.dashboardquery SET
vcdashboardquery = 'with callbackbyte as (
select jsonb_array_elements(convert_from(callBackResponsebyte.bytes_, ''UTF8'')::jsonb->''riskTransactions'')->>''status'' as status ,  
jsonb_array_elements(convert_from(callBackResponsebyte.bytes_, ''UTF8'')::jsonb->''riskTransactions'')->''error''->>''message'' as error
from camunda.act_hi_varinst callBackResponse
left join camunda.act_ge_bytearray callBackResponsebyte on callBackResponsebyte.id_ = callBackResponse.bytearray_id_
where callBackResponse.name_ = ''callBackResponse''
and  callBackResponse.var_type_ = ''json''
and callBackResponse.create_time_ between cast((current_date - 1) as timestamp) and cast(current_date  as timestamp)
and callBackResponse.tenant_id_ = :tenantidstr
), callback as (
select  case 
    when error = ''Transaction already released to merchant''
    then ''Transaction already released to merchant''
    else status 
    end as status from callbackbyte
)
select status as "Status", count(1) as "Count" from callback group by status'::text WHERE
idashboardqueryid = 130 AND itenantid = 10;


UPDATE ui.dashboardquery SET
vcdashboardquery =  E'{
    "All":
    {
        "All" : {
            "All" : "select l.ilivemessageid as \\"id\\", observations->>''reqid'' as \\"Request ID\\", cast(observations->>''ts'' as timestamp with time zone) \\"Timestamp\\", result->>''msg'' as \\"Remarks\\", observations->>''org'' as \\"Org\\", result->>''status'' as \\"Status\\", observations->''txn''->>''id'' as \\"Txn ID\\", cast(observations->''txn''->>''ts'' as timestamp with time zone) as \\"Txn Timestamp\\", observations->''txn''->>''note'' as \\"Note\\", observations->''txn''->>''type'' as \\"Type\\", observations->''txn''->>''class'' as \\"Class\\", observations->''payee''->>''addr'' as \\"Merchant addr\\", observations->''payee''->''attribs''->''identity''->>''verified_name'' as \\"Payee Name\\", observations->''observations''->''payeeVPA''->>''payment_address'' as \\"Payee VPA\\", observations->''observations''->''payeeVPA''->''account''->''customer''->>''customerName'' as \\"Merchant Name\\", observations->''observations''->''payeeVPA''->''account''->>''default_mcc'' as \\"Default MCC\\", observations->''payee''->>''mcc'' as \\"MCC\\", observations->''observations''->''payeeVPA''->''account''->''customer''->>''email'' as \\"Payee email\\", observations->''payer''->>''addr'' as \\"Payer\\", observations->''observations''->''payerVPA''->>''payment_address'' as \\"Payer VPA\\", observations->''observations''->''payerVPA''->>''vpaName'' as \\"Payer Name\\", observations->''payer''->''attribs''->''device''->>''ip'' as \\"Payer IP\\", result->''score''->>''score'' as \\"Txn Score\\", round(cast(observations->''payee''->>''amount'' as numeric)/100, 2) as \\"Txn Amount\\", observations->''txn''->''attribs''->>''card_country_code'' as \\"Card Country Code\\", observations->''txn''->>''orgTxnId'' as \\"Original Txn ID\\", observations->''txn''->''attribs''->>''acquirer_name'' as \\"Acquirer Name\\", observations->''payee''->>''currency'' as \\"Currency\\", result->''score''->>''workflow'' as \\"Workflow Type\\", observations->''observations''->''decisionclass''->>''decisionName'' as \\"Decision Name\\", result->''score''->>''decisiondetails'' as \\"Decision Detail\\", observations->''observations''->>''new_payee'' as \\"Is_New_Merchant\\", observations->''observations''->>''new_payer'' as \\"Is_New_Payer\\", observations->''txn''->''attribs''->>''skip_processing'' as \\"Skip Processing\\", observations->''observations''->''ip_details''->>''country'' as \\"ip_details.Country\\", observations->''observations''->''ip_details''->''details''->>''postal_code'' as \\"ip_details.PostalCode\\", observations->''observations''->''ip_details''->''details''->>''adm3-city-town'' as \\"ip_details.City\\", observations->''observations''->''payeeVPA''->''account''->''customer''->''attribs''->>''city'' as \\"observations.payeeVPA.account.customer.attribs.city\\", observations->''observations''->>''same_payer_payee_acc_d01_txn_count'' as \\"observations.same_payer_payee_acc_d01_txn_count\\", observations->''observations''->>''same_payer_payee_acc_d01_txn_value'' as \\"observations.same_payer_payee_acc_d01_txn_value\\", observations->''observations''->>''payer_unique_payee_acc_online_d01_txn_count'' as \\"observations.payer_unique_payee_acc_online_d01_txn_count\\", observations->''observations''->>''payee_online_intl_card_m30_txn_count'' as \\"observations.payee_online_intl_card_m30_txn_count\\", observations->''observations''->>''same_payee_same_amt_online_m15_txn_count'' as \\"observations.same_payee_same_amt_online_m15_txn_count\\", observations->''observations''->>''same_payee_online_m10_gteq250_txn_count'' as \\"observations.same_payee_online_m10_gteq250_txn_count\\", observations->''observations''->>''payee_account_d01_txn_value'' as \\"observations.payee_account_d01_txn_value\\", observations->''observations''->>''same_payee_acc_PT48H_txn_value'' as \\"observations.same_payee_acc_PT48H_txn_value\\", observations->''observations''->>''payee_acc_decline_less5k_m30_txn_count'' as \\"observations.payee_acc_decline_less5k_m30_txn_count\\", observations->''observations''->>''same_payee_online_PT24H_txn_value'' as \\"observations.same_payee_online_PT24H_txn_value\\", observations->''observations''->>''same_payer_payee_online_PT5M_txnPay_count'' as \\"observations.same_payer_payee_online_PT5M_txnPay_count\\", observations->''observations''->>''payer_decline_m30_txn_count'' as \\"observations.payer_decline_m30_txn_count\\", observations->''observations''->>''same_payer_payee_online_d01_txn_count'' as \\"observations.same_payer_payee_online_d01_txn_count\\", observations->''observations''->>''same_payer_payee_online_d01_txn_value'' as \\"observations.same_payer_payee_online_d01_txn_value\\" , rt.dttrxntime AS \\"Txn Date Time\\", rt.vcmsgid AS \\"Txn ID\\", rt.vcpayercustomerexternalid AS \\"Payer Customer ID\\", rt.vcpayeraccountexternalid AS \\"Payer Account ID\\", rt.vcpayeraddr AS \\"Payer VPA ID\\", rt.vcpayeecustomerexternalid AS \\"Payee Customer ID\\", rt.vcpayeeaccountexternalid AS \\"Payee Account ID\\", rt.vcpayeeaddr AS \\"Payee VPA ID\\", rt.vcclassname AS \\"Txn Class\\", rt.dobservationamount AS \\"Txn Amount\\", rt.vcdecisionname AS \\"Decision Name\\", rt.iruleid AS \\"Rule ID\\", rt.vcrulename AS \\"Rule Name\\", rt.rule_score AS \\"Score\\", rt.vcremark AS \\"Side\\" FROM analytics.rule_triggered rt left join analytics.trans l on l.ilivemessageid = rt.ilivemessageid and l.dttrxntime BETWEEN :StartDate AND :EndDate and l.itenantid = :tenantid WHERE rt.rule_score >= :RiskScore AND rt.dttrxntime BETWEEN :StartDate AND :EndDate and rt.itenantid = :tenantid order by rt.dttrxntime desc limit :Load",
            "Other": "select l.ilivemessageid as \\"id\\", observations->>''reqid'' as \\"Request ID\\", cast(observations->>''ts'' as timestamp with time zone) \\"Timestamp\\", result->>''msg'' as \\"Remarks\\", observations->>''org'' as \\"Org\\", result->>''status'' as \\"Status\\", observations->''txn''->>''id'' as \\"Txn ID\\", cast(observations->''txn''->>''ts'' as timestamp with time zone) as \\"Txn Timestamp\\", observations->''txn''->>''note'' as \\"Note\\", observations->''txn''->>''type'' as \\"Type\\", observations->''txn''->>''class'' as \\"Class\\", observations->''payee''->>''addr'' as \\"Merchant addr\\", observations->''payee''->''attribs''->''identity''->>''verified_name'' as \\"Payee Name\\", observations->''observations''->''payeeVPA''->>''payment_address'' as \\"Payee VPA\\", observations->''observations''->''payeeVPA''->''account''->''customer''->>''customerName'' as \\"Merchant Name\\", observations->''observations''->''payeeVPA''->''account''->>''default_mcc'' as \\"Default MCC\\", observations->''payee''->>''mcc'' as \\"MCC\\", observations->''observations''->''payeeVPA''->''account''->''customer''->>''email'' as \\"Payee email\\", observations->''payer''->>''addr'' as \\"Payer\\", observations->''observations''->''payerVPA''->>''payment_address'' as \\"Payer VPA\\", observations->''observations''->''payerVPA''->>''vpaName'' as \\"Payer Name\\", observations->''payer''->''attribs''->''device''->>''ip'' as \\"Payer IP\\", result->''score''->>''score'' as \\"Txn Score\\", round(cast(observations->''payee''->>''amount'' as numeric)/100, 2) as \\"Txn Amount\\", observations->''txn''->''attribs''->>''card_country_code'' as \\"Card Country Code\\", observations->''txn''->>''orgTxnId'' as \\"Original Txn ID\\", observations->''txn''->''attribs''->>''acquirer_name'' as \\"Acquirer Name\\", observations->''payee''->>''currency'' as \\"Currency\\", result->''score''->>''workflow'' as \\"Workflow Type\\", observations->''observations''->''decisionclass''->>''decisionName'' as \\"Decision Name\\", result->''score''->>''decisiondetails'' as \\"Decision Detail\\", observations->''observations''->>''new_payee'' as \\"Is_New_Merchant\\", observations->''observations''->>''new_payer'' as \\"Is_New_Payer\\", observations->''txn''->''attribs''->>''skip_processing'' as \\"Skip Processing\\", observations->''observations''->''ip_details''->>''country'' as \\"ip_details.Country\\", observations->''observations''->''ip_details''->''details''->>''postal_code'' as \\"ip_details.PostalCode\\", observations->''observations''->''ip_details''->''details''->>''adm3-city-town'' as \\"ip_details.City\\", observations->''observations''->''payeeVPA''->''account''->''customer''->''attribs''->>''city'' as \\"observations.payeeVPA.account.customer.attribs.city\\", observations->''observations''->>''same_payer_payee_acc_d01_txn_count'' as \\"observations.same_payer_payee_acc_d01_txn_count\\", observations->''observations''->>''same_payer_payee_acc_d01_txn_value'' as \\"observations.same_payer_payee_acc_d01_txn_value\\", observations->''observations''->>''payer_unique_payee_acc_online_d01_txn_count'' as \\"observations.payer_unique_payee_acc_online_d01_txn_count\\", observations->''observations''->>''payee_online_intl_card_m30_txn_count'' as \\"observations.payee_online_intl_card_m30_txn_count\\", observations->''observations''->>''same_payee_same_amt_online_m15_txn_count'' as \\"observations.same_payee_same_amt_online_m15_txn_count\\", observations->''observations''->>''same_payee_online_m10_gteq250_txn_count'' as \\"observations.same_payee_online_m10_gteq250_txn_count\\", observations->''observations''->>''payee_account_d01_txn_value'' as \\"observations.payee_account_d01_txn_value\\", observations->''observations''->>''same_payee_acc_PT48H_txn_value'' as \\"observations.same_payee_acc_PT48H_txn_value\\", observations->''observations''->>''payee_acc_decline_less5k_m30_txn_count'' as \\"observations.payee_acc_decline_less5k_m30_txn_count\\", observations->''observations''->>''same_payee_online_PT24H_txn_value'' as \\"observations.same_payee_online_PT24H_txn_value\\", observations->''observations''->>''same_payer_payee_online_PT5M_txnPay_count'' as \\"observations.same_payer_payee_online_PT5M_txnPay_count\\", observations->''observations''->>''payer_decline_m30_txn_count'' as \\"observations.payer_decline_m30_txn_count\\", observations->''observations''->>''same_payer_payee_online_d01_txn_count'' as \\"observations.same_payer_payee_online_d01_txn_count\\", observations->''observations''->>''same_payer_payee_online_d01_txn_value'' as \\"observations.same_payer_payee_online_d01_txn_value\\" , rt.dttrxntime AS \\"Txn Date Time\\", rt.vcmsgid AS \\"Txn ID\\", rt.vcpayercustomerexternalid AS \\"Payer Customer ID\\", rt.vcpayeraccountexternalid AS \\"Payer Account ID\\", rt.vcpayeraddr AS \\"Payer VPA ID\\", rt.vcpayeecustomerexternalid AS \\"Payee Customer ID\\", rt.vcpayeeaccountexternalid AS \\"Payee Account ID\\", rt.vcpayeeaddr AS \\"Payee VPA ID\\", rt.vcclassname AS \\"Txn Class\\", rt.dobservationamount AS \\"Txn Amount\\", rt.vcdecisionname AS \\"Decision Name\\", rt.iruleid AS \\"Rule ID\\", rt.vcrulename AS \\"Rule Name\\", rt.rule_score AS \\"Score\\", rt.vcremark AS \\"Side\\" FROM analytics.rule_triggered rt left join analytics.trans l on l.ilivemessageid = rt.ilivemessageid and l.dttrxntime BETWEEN :StartDate AND :EndDate and l.itenantid = :tenantid WHERE rt.rule_score >= :RiskScore AND rt.dttrxntime BETWEEN :StartDate AND :EndDate and rt.itenantid = :tenantid and rt.vcrulename = :Rule order by rt.dttrxntime desc limit :Load"
        },
        "Other": {
            "All" : "select l.ilivemessageid as \\"id\\", observations->>''reqid'' as \\"Request ID\\", cast(observations->>''ts'' as timestamp with time zone) \\"Timestamp\\", result->>''msg'' as \\"Remarks\\", observations->>''org'' as \\"Org\\", result->>''status'' as \\"Status\\", observations->''txn''->>''id'' as \\"Txn ID\\", cast(observations->''txn''->>''ts'' as timestamp with time zone) as \\"Txn Timestamp\\", observations->''txn''->>''note'' as \\"Note\\", observations->''txn''->>''type'' as \\"Type\\", observations->''txn''->>''class'' as \\"Class\\", observations->''payee''->>''addr'' as \\"Merchant addr\\", observations->''payee''->''attribs''->''identity''->>''verified_name'' as \\"Payee Name\\", observations->''observations''->''payeeVPA''->>''payment_address'' as \\"Payee VPA\\", observations->''observations''->''payeeVPA''->''account''->''customer''->>''customerName'' as \\"Merchant Name\\", observations->''observations''->''payeeVPA''->''account''->>''default_mcc'' as \\"Default MCC\\", observations->''payee''->>''mcc'' as \\"MCC\\", observations->''observations''->''payeeVPA''->''account''->''customer''->>''email'' as \\"Payee email\\", observations->''payer''->>''addr'' as \\"Payer\\", observations->''observations''->''payerVPA''->>''payment_address'' as \\"Payer VPA\\", observations->''observations''->''payerVPA''->>''vpaName'' as \\"Payer Name\\", observations->''payer''->''attribs''->''device''->>''ip'' as \\"Payer IP\\", result->''score''->>''score'' as \\"Txn Score\\", round(cast(observations->''payee''->>''amount'' as numeric)/100, 2) as \\"Txn Amount\\", observations->''txn''->''attribs''->>''card_country_code'' as \\"Card Country Code\\", observations->''txn''->>''orgTxnId'' as \\"Original Txn ID\\", observations->''txn''->''attribs''->>''acquirer_name'' as \\"Acquirer Name\\", observations->''payee''->>''currency'' as \\"Currency\\", result->''score''->>''workflow'' as \\"Workflow Type\\", observations->''observations''->''decisionclass''->>''decisionName'' as \\"Decision Name\\", result->''score''->>''decisiondetails'' as \\"Decision Detail\\", observations->''observations''->>''new_payee'' as \\"Is_New_Merchant\\", observations->''observations''->>''new_payer'' as \\"Is_New_Payer\\", observations->''txn''->''attribs''->>''skip_processing'' as \\"Skip Processing\\", observations->''observations''->''ip_details''->>''country'' as \\"ip_details.Country\\", observations->''observations''->''ip_details''->''details''->>''postal_code'' as \\"ip_details.PostalCode\\", observations->''observations''->''ip_details''->''details''->>''adm3-city-town'' as \\"ip_details.City\\", observations->''observations''->''payeeVPA''->''account''->''customer''->''attribs''->>''city'' as \\"observations.payeeVPA.account.customer.attribs.city\\", observations->''observations''->>''same_payer_payee_acc_d01_txn_count'' as \\"observations.same_payer_payee_acc_d01_txn_count\\", observations->''observations''->>''same_payer_payee_acc_d01_txn_value'' as \\"observations.same_payer_payee_acc_d01_txn_value\\", observations->''observations''->>''payer_unique_payee_acc_online_d01_txn_count'' as \\"observations.payer_unique_payee_acc_online_d01_txn_count\\", observations->''observations''->>''payee_online_intl_card_m30_txn_count'' as \\"observations.payee_online_intl_card_m30_txn_count\\", observations->''observations''->>''same_payee_same_amt_online_m15_txn_count'' as \\"observations.same_payee_same_amt_online_m15_txn_count\\", observations->''observations''->>''same_payee_online_m10_gteq250_txn_count'' as \\"observations.same_payee_online_m10_gteq250_txn_count\\", observations->''observations''->>''payee_account_d01_txn_value'' as \\"observations.payee_account_d01_txn_value\\", observations->''observations''->>''same_payee_acc_PT48H_txn_value'' as \\"observations.same_payee_acc_PT48H_txn_value\\", observations->''observations''->>''payee_acc_decline_less5k_m30_txn_count'' as \\"observations.payee_acc_decline_less5k_m30_txn_count\\", observations->''observations''->>''same_payee_online_PT24H_txn_value'' as \\"observations.same_payee_online_PT24H_txn_value\\", observations->''observations''->>''same_payer_payee_online_PT5M_txnPay_count'' as \\"observations.same_payer_payee_online_PT5M_txnPay_count\\", observations->''observations''->>''payer_decline_m30_txn_count'' as \\"observations.payer_decline_m30_txn_count\\", observations->''observations''->>''same_payer_payee_online_d01_txn_count'' as \\"observations.same_payer_payee_online_d01_txn_count\\", observations->''observations''->>''same_payer_payee_online_d01_txn_value'' as \\"observations.same_payer_payee_online_d01_txn_value\\" , rt.dttrxntime AS \\"Txn Date Time\\", rt.vcmsgid AS \\"Txn ID\\", rt.vcpayercustomerexternalid AS \\"Payer Customer ID\\", rt.vcpayeraccountexternalid AS \\"Payer Account ID\\", rt.vcpayeraddr AS \\"Payer VPA ID\\", rt.vcpayeecustomerexternalid AS \\"Payee Customer ID\\", rt.vcpayeeaccountexternalid AS \\"Payee Account ID\\", rt.vcpayeeaddr AS \\"Payee VPA ID\\", rt.vcclassname AS \\"Txn Class\\", rt.dobservationamount AS \\"Txn Amount\\", rt.vcdecisionname AS \\"Decision Name\\", rt.iruleid AS \\"Rule ID\\", rt.vcrulename AS \\"Rule Name\\", rt.rule_score AS \\"Score\\", rt.vcremark AS \\"Side\\" FROM analytics.rule_triggered rt left join analytics.trans l on l.ilivemessageid = rt.ilivemessageid and l.dttrxntime BETWEEN :StartDate AND :EndDate and l.itenantid = :tenantid WHERE rt.rule_score >= :RiskScore AND rt.dttrxntime BETWEEN :StartDate AND :EndDate and rt.itenantid = :tenantid  and rt.vcdecisionname = :Decision order by rt.dttrxntime desc limit :Load",
            "Other": "select l.ilivemessageid as \\"id\\", observations->>''reqid'' as \\"Request ID\\", cast(observations->>''ts'' as timestamp with time zone) \\"Timestamp\\", result->>''msg'' as \\"Remarks\\", observations->>''org'' as \\"Org\\", result->>''status'' as \\"Status\\", observations->''txn''->>''id'' as \\"Txn ID\\", cast(observations->''txn''->>''ts'' as timestamp with time zone) as \\"Txn Timestamp\\", observations->''txn''->>''note'' as \\"Note\\", observations->''txn''->>''type'' as \\"Type\\", observations->''txn''->>''class'' as \\"Class\\", observations->''payee''->>''addr'' as \\"Merchant addr\\", observations->''payee''->''attribs''->''identity''->>''verified_name'' as \\"Payee Name\\", observations->''observations''->''payeeVPA''->>''payment_address'' as \\"Payee VPA\\", observations->''observations''->''payeeVPA''->''account''->''customer''->>''customerName'' as \\"Merchant Name\\", observations->''observations''->''payeeVPA''->''account''->>''default_mcc'' as \\"Default MCC\\", observations->''payee''->>''mcc'' as \\"MCC\\", observations->''observations''->''payeeVPA''->''account''->''customer''->>''email'' as \\"Payee email\\", observations->''payer''->>''addr'' as \\"Payer\\", observations->''observations''->''payerVPA''->>''payment_address'' as \\"Payer VPA\\", observations->''observations''->''payerVPA''->>''vpaName'' as \\"Payer Name\\", observations->''payer''->''attribs''->''device''->>''ip'' as \\"Payer IP\\", result->''score''->>''score'' as \\"Txn Score\\", round(cast(observations->''payee''->>''amount'' as numeric)/100, 2) as \\"Txn Amount\\", observations->''txn''->''attribs''->>''card_country_code'' as \\"Card Country Code\\", observations->''txn''->>''orgTxnId'' as \\"Original Txn ID\\", observations->''txn''->''attribs''->>''acquirer_name'' as \\"Acquirer Name\\", observations->''payee''->>''currency'' as \\"Currency\\", result->''score''->>''workflow'' as \\"Workflow Type\\", observations->''observations''->''decisionclass''->>''decisionName'' as \\"Decision Name\\", result->''score''->>''decisiondetails'' as \\"Decision Detail\\", observations->''observations''->>''new_payee'' as \\"Is_New_Merchant\\", observations->''observations''->>''new_payer'' as \\"Is_New_Payer\\", observations->''txn''->''attribs''->>''skip_processing'' as \\"Skip Processing\\", observations->''observations''->''ip_details''->>''country'' as \\"ip_details.Country\\", observations->''observations''->''ip_details''->''details''->>''postal_code'' as \\"ip_details.PostalCode\\", observations->''observations''->''ip_details''->''details''->>''adm3-city-town'' as \\"ip_details.City\\", observations->''observations''->''payeeVPA''->''account''->''customer''->''attribs''->>''city'' as \\"observations.payeeVPA.account.customer.attribs.city\\", observations->''observations''->>''same_payer_payee_acc_d01_txn_count'' as \\"observations.same_payer_payee_acc_d01_txn_count\\", observations->''observations''->>''same_payer_payee_acc_d01_txn_value'' as \\"observations.same_payer_payee_acc_d01_txn_value\\", observations->''observations''->>''payer_unique_payee_acc_online_d01_txn_count'' as \\"observations.payer_unique_payee_acc_online_d01_txn_count\\", observations->''observations''->>''payee_online_intl_card_m30_txn_count'' as \\"observations.payee_online_intl_card_m30_txn_count\\", observations->''observations''->>''same_payee_same_amt_online_m15_txn_count'' as \\"observations.same_payee_same_amt_online_m15_txn_count\\", observations->''observations''->>''same_payee_online_m10_gteq250_txn_count'' as \\"observations.same_payee_online_m10_gteq250_txn_count\\", observations->''observations''->>''payee_account_d01_txn_value'' as \\"observations.payee_account_d01_txn_value\\", observations->''observations''->>''same_payee_acc_PT48H_txn_value'' as \\"observations.same_payee_acc_PT48H_txn_value\\", observations->''observations''->>''payee_acc_decline_less5k_m30_txn_count'' as \\"observations.payee_acc_decline_less5k_m30_txn_count\\", observations->''observations''->>''same_payee_online_PT24H_txn_value'' as \\"observations.same_payee_online_PT24H_txn_value\\", observations->''observations''->>''same_payer_payee_online_PT5M_txnPay_count'' as \\"observations.same_payer_payee_online_PT5M_txnPay_count\\", observations->''observations''->>''payer_decline_m30_txn_count'' as \\"observations.payer_decline_m30_txn_count\\", observations->''observations''->>''same_payer_payee_online_d01_txn_count'' as \\"observations.same_payer_payee_online_d01_txn_count\\", observations->''observations''->>''same_payer_payee_online_d01_txn_value'' as \\"observations.same_payer_payee_online_d01_txn_value\\" , rt.dttrxntime AS \\"Txn Date Time\\", rt.vcmsgid AS \\"Txn ID\\", rt.vcpayercustomerexternalid AS \\"Payer Customer ID\\", rt.vcpayeraccountexternalid AS \\"Payer Account ID\\", rt.vcpayeraddr AS \\"Payer VPA ID\\", rt.vcpayeecustomerexternalid AS \\"Payee Customer ID\\", rt.vcpayeeaccountexternalid AS \\"Payee Account ID\\", rt.vcpayeeaddr AS \\"Payee VPA ID\\", rt.vcclassname AS \\"Txn Class\\", rt.dobservationamount AS \\"Txn Amount\\", rt.vcdecisionname AS \\"Decision Name\\", rt.iruleid AS \\"Rule ID\\", rt.vcrulename AS \\"Rule Name\\", rt.rule_score AS \\"Score\\", rt.vcremark AS \\"Side\\" FROM analytics.rule_triggered rt left join analytics.trans l on l.ilivemessageid = rt.ilivemessageid and l.dttrxntime BETWEEN :StartDate AND :EndDate and l.itenantid = :tenantid WHERE rt.rule_score >= :RiskScore AND rt.dttrxntime BETWEEN :StartDate AND :EndDate and rt.itenantid = :tenantid and rt.vcdecisionname = :Decision and rt.vcrulename = :Rule order by rt.dttrxntime desc limit :Load"
        }
    },
    "Other":
    {
        "All" : {
            "All" : "select l.ilivemessageid as \\"id\\", observations->>''reqid'' as \\"Request ID\\", cast(observations->>''ts'' as timestamp with time zone) \\"Timestamp\\", result->>''msg'' as \\"Remarks\\", observations->>''org'' as \\"Org\\", result->>''status'' as \\"Status\\", observations->''txn''->>''id'' as \\"Txn ID\\", cast(observations->''txn''->>''ts'' as timestamp with time zone) as \\"Txn Timestamp\\", observations->''txn''->>''note'' as \\"Note\\", observations->''txn''->>''type'' as \\"Type\\", observations->''txn''->>''class'' as \\"Class\\", observations->''payee''->>''addr'' as \\"Merchant addr\\", observations->''payee''->''attribs''->''identity''->>''verified_name'' as \\"Payee Name\\", observations->''observations''->''payeeVPA''->>''payment_address'' as \\"Payee VPA\\", observations->''observations''->''payeeVPA''->''account''->''customer''->>''customerName'' as \\"Merchant Name\\", observations->''observations''->''payeeVPA''->''account''->>''default_mcc'' as \\"Default MCC\\", observations->''payee''->>''mcc'' as \\"MCC\\", observations->''observations''->''payeeVPA''->''account''->''customer''->>''email'' as \\"Payee email\\", observations->''payer''->>''addr'' as \\"Payer\\", observations->''observations''->''payerVPA''->>''payment_address'' as \\"Payer VPA\\", observations->''observations''->''payerVPA''->>''vpaName'' as \\"Payer Name\\", observations->''payer''->''attribs''->''device''->>''ip'' as \\"Payer IP\\", result->''score''->>''score'' as \\"Txn Score\\", round(cast(observations->''payee''->>''amount'' as numeric)/100, 2) as \\"Txn Amount\\", observations->''txn''->''attribs''->>''card_country_code'' as \\"Card Country Code\\", observations->''txn''->>''orgTxnId'' as \\"Original Txn ID\\", observations->''txn''->''attribs''->>''acquirer_name'' as \\"Acquirer Name\\", observations->''payee''->>''currency'' as \\"Currency\\", result->''score''->>''workflow'' as \\"Workflow Type\\", observations->''observations''->''decisionclass''->>''decisionName'' as \\"Decision Name\\", result->''score''->>''decisiondetails'' as \\"Decision Detail\\", observations->''observations''->>''new_payee'' as \\"Is_New_Merchant\\", observations->''observations''->>''new_payer'' as \\"Is_New_Payer\\", observations->''txn''->''attribs''->>''skip_processing'' as \\"Skip Processing\\", observations->''observations''->''ip_details''->>''country'' as \\"ip_details.Country\\", observations->''observations''->''ip_details''->''details''->>''postal_code'' as \\"ip_details.PostalCode\\", observations->''observations''->''ip_details''->''details''->>''adm3-city-town'' as \\"ip_details.City\\", observations->''observations''->''payeeVPA''->''account''->''customer''->''attribs''->>''city'' as \\"observations.payeeVPA.account.customer.attribs.city\\", observations->''observations''->>''same_payer_payee_acc_d01_txn_count'' as \\"observations.same_payer_payee_acc_d01_txn_count\\", observations->''observations''->>''same_payer_payee_acc_d01_txn_value'' as \\"observations.same_payer_payee_acc_d01_txn_value\\", observations->''observations''->>''payer_unique_payee_acc_online_d01_txn_count'' as \\"observations.payer_unique_payee_acc_online_d01_txn_count\\", observations->''observations''->>''payee_online_intl_card_m30_txn_count'' as \\"observations.payee_online_intl_card_m30_txn_count\\", observations->''observations''->>''same_payee_same_amt_online_m15_txn_count'' as \\"observations.same_payee_same_amt_online_m15_txn_count\\", observations->''observations''->>''same_payee_online_m10_gteq250_txn_count'' as \\"observations.same_payee_online_m10_gteq250_txn_count\\", observations->''observations''->>''payee_account_d01_txn_value'' as \\"observations.payee_account_d01_txn_value\\", observations->''observations''->>''same_payee_acc_PT48H_txn_value'' as \\"observations.same_payee_acc_PT48H_txn_value\\", observations->''observations''->>''payee_acc_decline_less5k_m30_txn_count'' as \\"observations.payee_acc_decline_less5k_m30_txn_count\\", observations->''observations''->>''same_payee_online_PT24H_txn_value'' as \\"observations.same_payee_online_PT24H_txn_value\\", observations->''observations''->>''same_payer_payee_online_PT5M_txnPay_count'' as \\"observations.same_payer_payee_online_PT5M_txnPay_count\\", observations->''observations''->>''payer_decline_m30_txn_count'' as \\"observations.payer_decline_m30_txn_count\\", observations->''observations''->>''same_payer_payee_online_d01_txn_count'' as \\"observations.same_payer_payee_online_d01_txn_count\\", observations->''observations''->>''same_payer_payee_online_d01_txn_value'' as \\"observations.same_payer_payee_online_d01_txn_value\\" , rt.dttrxntime AS \\"Txn Date Time\\", rt.vcmsgid AS \\"Txn ID\\", rt.vcpayercustomerexternalid AS \\"Payer Customer ID\\", rt.vcpayeraccountexternalid AS \\"Payer Account ID\\", rt.vcpayeraddr AS \\"Payer VPA ID\\", rt.vcpayeecustomerexternalid AS \\"Payee Customer ID\\", rt.vcpayeeaccountexternalid AS \\"Payee Account ID\\", rt.vcpayeeaddr AS \\"Payee VPA ID\\", rt.vcclassname AS \\"Txn Class\\", rt.dobservationamount AS \\"Txn Amount\\", rt.vcdecisionname AS \\"Decision Name\\", rt.iruleid AS \\"Rule ID\\", rt.vcrulename AS \\"Rule Name\\", rt.rule_score AS \\"Score\\", rt.vcremark AS \\"Side\\" FROM analytics.rule_triggered rt left join analytics.trans l on l.ilivemessageid = rt.ilivemessageid and l.dttrxntime BETWEEN :StartDate AND :EndDate and l.itenantid = :tenantid WHERE rt.rule_score >= :RiskScore AND rt.dttrxntime BETWEEN :StartDate AND :EndDate and rt.itenantid = :tenantid and rt.vcclassname = :Class order by rt.dttrxntime desc limit :Load",
            "Other": "select l.ilivemessageid as \\"id\\", observations->>''reqid'' as \\"Request ID\\", cast(observations->>''ts'' as timestamp with time zone) \\"Timestamp\\", result->>''msg'' as \\"Remarks\\", observations->>''org'' as \\"Org\\", result->>''status'' as \\"Status\\", observations->''txn''->>''id'' as \\"Txn ID\\", cast(observations->''txn''->>''ts'' as timestamp with time zone) as \\"Txn Timestamp\\", observations->''txn''->>''note'' as \\"Note\\", observations->''txn''->>''type'' as \\"Type\\", observations->''txn''->>''class'' as \\"Class\\", observations->''payee''->>''addr'' as \\"Merchant addr\\", observations->''payee''->''attribs''->''identity''->>''verified_name'' as \\"Payee Name\\", observations->''observations''->''payeeVPA''->>''payment_address'' as \\"Payee VPA\\", observations->''observations''->''payeeVPA''->''account''->''customer''->>''customerName'' as \\"Merchant Name\\", observations->''observations''->''payeeVPA''->''account''->>''default_mcc'' as \\"Default MCC\\", observations->''payee''->>''mcc'' as \\"MCC\\", observations->''observations''->''payeeVPA''->''account''->''customer''->>''email'' as \\"Payee email\\", observations->''payer''->>''addr'' as \\"Payer\\", observations->''observations''->''payerVPA''->>''payment_address'' as \\"Payer VPA\\", observations->''observations''->''payerVPA''->>''vpaName'' as \\"Payer Name\\", observations->''payer''->''attribs''->''device''->>''ip'' as \\"Payer IP\\", result->''score''->>''score'' as \\"Txn Score\\", round(cast(observations->''payee''->>''amount'' as numeric)/100, 2) as \\"Txn Amount\\", observations->''txn''->''attribs''->>''card_country_code'' as \\"Card Country Code\\", observations->''txn''->>''orgTxnId'' as \\"Original Txn ID\\", observations->''txn''->''attribs''->>''acquirer_name'' as \\"Acquirer Name\\", observations->''payee''->>''currency'' as \\"Currency\\", result->''score''->>''workflow'' as \\"Workflow Type\\", observations->''observations''->''decisionclass''->>''decisionName'' as \\"Decision Name\\", result->''score''->>''decisiondetails'' as \\"Decision Detail\\", observations->''observations''->>''new_payee'' as \\"Is_New_Merchant\\", observations->''observations''->>''new_payer'' as \\"Is_New_Payer\\", observations->''txn''->''attribs''->>''skip_processing'' as \\"Skip Processing\\", observations->''observations''->''ip_details''->>''country'' as \\"ip_details.Country\\", observations->''observations''->''ip_details''->''details''->>''postal_code'' as \\"ip_details.PostalCode\\", observations->''observations''->''ip_details''->''details''->>''adm3-city-town'' as \\"ip_details.City\\", observations->''observations''->''payeeVPA''->''account''->''customer''->''attribs''->>''city'' as \\"observations.payeeVPA.account.customer.attribs.city\\", observations->''observations''->>''same_payer_payee_acc_d01_txn_count'' as \\"observations.same_payer_payee_acc_d01_txn_count\\", observations->''observations''->>''same_payer_payee_acc_d01_txn_value'' as \\"observations.same_payer_payee_acc_d01_txn_value\\", observations->''observations''->>''payer_unique_payee_acc_online_d01_txn_count'' as \\"observations.payer_unique_payee_acc_online_d01_txn_count\\", observations->''observations''->>''payee_online_intl_card_m30_txn_count'' as \\"observations.payee_online_intl_card_m30_txn_count\\", observations->''observations''->>''same_payee_same_amt_online_m15_txn_count'' as \\"observations.same_payee_same_amt_online_m15_txn_count\\", observations->''observations''->>''same_payee_online_m10_gteq250_txn_count'' as \\"observations.same_payee_online_m10_gteq250_txn_count\\", observations->''observations''->>''payee_account_d01_txn_value'' as \\"observations.payee_account_d01_txn_value\\", observations->''observations''->>''same_payee_acc_PT48H_txn_value'' as \\"observations.same_payee_acc_PT48H_txn_value\\", observations->''observations''->>''payee_acc_decline_less5k_m30_txn_count'' as \\"observations.payee_acc_decline_less5k_m30_txn_count\\", observations->''observations''->>''same_payee_online_PT24H_txn_value'' as \\"observations.same_payee_online_PT24H_txn_value\\", observations->''observations''->>''same_payer_payee_online_PT5M_txnPay_count'' as \\"observations.same_payer_payee_online_PT5M_txnPay_count\\", observations->''observations''->>''payer_decline_m30_txn_count'' as \\"observations.payer_decline_m30_txn_count\\", observations->''observations''->>''same_payer_payee_online_d01_txn_count'' as \\"observations.same_payer_payee_online_d01_txn_count\\", observations->''observations''->>''same_payer_payee_online_d01_txn_value'' as \\"observations.same_payer_payee_online_d01_txn_value\\" , rt.dttrxntime AS \\"Txn Date Time\\", rt.vcmsgid AS \\"Txn ID\\", rt.vcpayercustomerexternalid AS \\"Payer Customer ID\\", rt.vcpayeraccountexternalid AS \\"Payer Account ID\\", rt.vcpayeraddr AS \\"Payer VPA ID\\", rt.vcpayeecustomerexternalid AS \\"Payee Customer ID\\", rt.vcpayeeaccountexternalid AS \\"Payee Account ID\\", rt.vcpayeeaddr AS \\"Payee VPA ID\\", rt.vcclassname AS \\"Txn Class\\", rt.dobservationamount AS \\"Txn Amount\\", rt.vcdecisionname AS \\"Decision Name\\", rt.iruleid AS \\"Rule ID\\", rt.vcrulename AS \\"Rule Name\\", rt.rule_score AS \\"Score\\", rt.vcremark AS \\"Side\\" FROM analytics.rule_triggered rt left join analytics.trans l on l.ilivemessageid = rt.ilivemessageid and l.dttrxntime BETWEEN :StartDate AND :EndDate and l.itenantid = :tenantid WHERE rt.rule_score >= :RiskScore AND rt.dttrxntime BETWEEN :StartDate AND :EndDate and rt.itenantid = :tenantid and rt.vcrulename = :Rule and rt.vcclassname = :Class order by rt.dttrxntime desc limit :Load"
        },
        "Other": {
            "All" : "select l.ilivemessageid as \\"id\\", observations->>''reqid'' as \\"Request ID\\", cast(observations->>''ts'' as timestamp with time zone) \\"Timestamp\\", result->>''msg'' as \\"Remarks\\", observations->>''org'' as \\"Org\\", result->>''status'' as \\"Status\\", observations->''txn''->>''id'' as \\"Txn ID\\", cast(observations->''txn''->>''ts'' as timestamp with time zone) as \\"Txn Timestamp\\", observations->''txn''->>''note'' as \\"Note\\", observations->''txn''->>''type'' as \\"Type\\", observations->''txn''->>''class'' as \\"Class\\", observations->''payee''->>''addr'' as \\"Merchant addr\\", observations->''payee''->''attribs''->''identity''->>''verified_name'' as \\"Payee Name\\", observations->''observations''->''payeeVPA''->>''payment_address'' as \\"Payee VPA\\", observations->''observations''->''payeeVPA''->''account''->''customer''->>''customerName'' as \\"Merchant Name\\", observations->''observations''->''payeeVPA''->''account''->>''default_mcc'' as \\"Default MCC\\", observations->''payee''->>''mcc'' as \\"MCC\\", observations->''observations''->''payeeVPA''->''account''->''customer''->>''email'' as \\"Payee email\\", observations->''payer''->>''addr'' as \\"Payer\\", observations->''observations''->''payerVPA''->>''payment_address'' as \\"Payer VPA\\", observations->''observations''->''payerVPA''->>''vpaName'' as \\"Payer Name\\", observations->''payer''->''attribs''->''device''->>''ip'' as \\"Payer IP\\", result->''score''->>''score'' as \\"Txn Score\\", round(cast(observations->''payee''->>''amount'' as numeric)/100, 2) as \\"Txn Amount\\", observations->''txn''->''attribs''->>''card_country_code'' as \\"Card Country Code\\", observations->''txn''->>''orgTxnId'' as \\"Original Txn ID\\", observations->''txn''->''attribs''->>''acquirer_name'' as \\"Acquirer Name\\", observations->''payee''->>''currency'' as \\"Currency\\", result->''score''->>''workflow'' as \\"Workflow Type\\", observations->''observations''->''decisionclass''->>''decisionName'' as \\"Decision Name\\", result->''score''->>''decisiondetails'' as \\"Decision Detail\\", observations->''observations''->>''new_payee'' as \\"Is_New_Merchant\\", observations->''observations''->>''new_payer'' as \\"Is_New_Payer\\", observations->''txn''->''attribs''->>''skip_processing'' as \\"Skip Processing\\", observations->''observations''->''ip_details''->>''country'' as \\"ip_details.Country\\", observations->''observations''->''ip_details''->''details''->>''postal_code'' as \\"ip_details.PostalCode\\", observations->''observations''->''ip_details''->''details''->>''adm3-city-town'' as \\"ip_details.City\\", observations->''observations''->''payeeVPA''->''account''->''customer''->''attribs''->>''city'' as \\"observations.payeeVPA.account.customer.attribs.city\\", observations->''observations''->>''same_payer_payee_acc_d01_txn_count'' as \\"observations.same_payer_payee_acc_d01_txn_count\\", observations->''observations''->>''same_payer_payee_acc_d01_txn_value'' as \\"observations.same_payer_payee_acc_d01_txn_value\\", observations->''observations''->>''payer_unique_payee_acc_online_d01_txn_count'' as \\"observations.payer_unique_payee_acc_online_d01_txn_count\\", observations->''observations''->>''payee_online_intl_card_m30_txn_count'' as \\"observations.payee_online_intl_card_m30_txn_count\\", observations->''observations''->>''same_payee_same_amt_online_m15_txn_count'' as \\"observations.same_payee_same_amt_online_m15_txn_count\\", observations->''observations''->>''same_payee_online_m10_gteq250_txn_count'' as \\"observations.same_payee_online_m10_gteq250_txn_count\\", observations->''observations''->>''payee_account_d01_txn_value'' as \\"observations.payee_account_d01_txn_value\\", observations->''observations''->>''same_payee_acc_PT48H_txn_value'' as \\"observations.same_payee_acc_PT48H_txn_value\\", observations->''observations''->>''payee_acc_decline_less5k_m30_txn_count'' as \\"observations.payee_acc_decline_less5k_m30_txn_count\\", observations->''observations''->>''same_payee_online_PT24H_txn_value'' as \\"observations.same_payee_online_PT24H_txn_value\\", observations->''observations''->>''same_payer_payee_online_PT5M_txnPay_count'' as \\"observations.same_payer_payee_online_PT5M_txnPay_count\\", observations->''observations''->>''payer_decline_m30_txn_count'' as \\"observations.payer_decline_m30_txn_count\\", observations->''observations''->>''same_payer_payee_online_d01_txn_count'' as \\"observations.same_payer_payee_online_d01_txn_count\\", observations->''observations''->>''same_payer_payee_online_d01_txn_value'' as \\"observations.same_payer_payee_online_d01_txn_value\\" , rt.dttrxntime AS \\"Txn Date Time\\", rt.vcmsgid AS \\"Txn ID\\", rt.vcpayercustomerexternalid AS \\"Payer Customer ID\\", rt.vcpayeraccountexternalid AS \\"Payer Account ID\\", rt.vcpayeraddr AS \\"Payer VPA ID\\", rt.vcpayeecustomerexternalid AS \\"Payee Customer ID\\", rt.vcpayeeaccountexternalid AS \\"Payee Account ID\\", rt.vcpayeeaddr AS \\"Payee VPA ID\\", rt.vcclassname AS \\"Txn Class\\", rt.dobservationamount AS \\"Txn Amount\\", rt.vcdecisionname AS \\"Decision Name\\", rt.iruleid AS \\"Rule ID\\", rt.vcrulename AS \\"Rule Name\\", rt.rule_score AS \\"Score\\", rt.vcremark AS \\"Side\\" FROM analytics.rule_triggered rt left join analytics.trans l on l.ilivemessageid = rt.ilivemessageid and l.dttrxntime BETWEEN :StartDate AND :EndDate and l.itenantid = :tenantid WHERE rt.rule_score >= :RiskScore AND rt.dttrxntime BETWEEN :StartDate AND :EndDate and rt.itenantid = :tenantid  and rt.vcdecisionname = :Decision and rt.vcclassname = :Class order by rt.dttrxntime desc limit :Load",
            "Other": "select l.ilivemessageid as \\"id\\", observations->>''reqid'' as \\"Request ID\\", cast(observations->>''ts'' as timestamp with time zone) \\"Timestamp\\", result->>''msg'' as \\"Remarks\\", observations->>''org'' as \\"Org\\", result->>''status'' as \\"Status\\", observations->''txn''->>''id'' as \\"Txn ID\\", cast(observations->''txn''->>''ts'' as timestamp with time zone) as \\"Txn Timestamp\\", observations->''txn''->>''note'' as \\"Note\\", observations->''txn''->>''type'' as \\"Type\\", observations->''txn''->>''class'' as \\"Class\\", observations->''payee''->>''addr'' as \\"Merchant addr\\", observations->''payee''->''attribs''->''identity''->>''verified_name'' as \\"Payee Name\\", observations->''observations''->''payeeVPA''->>''payment_address'' as \\"Payee VPA\\",observations->''observations''->''payeeVPA''->''account''->''customer''->>''customerName'' as \\"Merchant Name\\", observations->''observations''->''payeeVPA''->''account''->>''default_mcc'' as \\"Default MCC\\", observations->''payee''->>''mcc'' as \\"MCC\\", observations->''observations''->''payeeVPA''->''account''->''customer''->>''email'' as \\"Payee email\\", observations->''payer''->>''addr'' as \\"Payer\\", observations->''observations''->''payerVPA''->>''payment_address'' as \\"Payer VPA\\", observations->''observations''->''payerVPA''->>''vpaName'' as \\"Payer Name\\", observations->''payer''->''attribs''->''device''->>''ip'' as \\"Payer IP\\", result->''score''->>''score'' as \\"Txn Score\\", round(cast(observations->''payee''->>''amount'' as numeric)/100, 2) as \\"Txn Amount\\", observations->''txn''->''attribs''->>''card_country_code'' as \\"Card Country Code\\", observations->''txn''->>''orgTxnId'' as \\"Original Txn ID\\", observations->''txn''->''attribs''->>''acquirer_name'' as \\"Acquirer Name\\", observations->''payee''->>''currency'' as \\"Currency\\", result->''score''->>''workflow'' as \\"Workflow Type\\", observations->''observations''->''decisionclass''->>''decisionName'' as \\"Decision Name\\", result->''score''->>''decisiondetails'' as \\"Decision Detail\\", observations->''observations''->>''new_payee'' as \\"Is_New_Merchant\\", observations->''observations''->>''new_payer'' as \\"Is_New_Payer\\", observations->''txn''->''attribs''->>''skip_processing'' as \\"Skip Processing\\", observations->''observations''->''ip_details''->>''country'' as \\"ip_details.Country\\", observations->''observations''->''ip_details''->''details''->>''postal_code'' as \\"ip_details.PostalCode\\", observations->''observations''->''ip_details''->''details''->>''adm3-city-town'' as \\"ip_details.City\\", observations->''observations''->''payeeVPA''->''account''->''customer''->''attribs''->>''city'' as \\"observations.payeeVPA.account.customer.attribs.city\\", observations->''observations''->>''same_payer_payee_acc_d01_txn_count'' as \\"observations.same_payer_payee_acc_d01_txn_count\\", observations->''observations''->>''same_payer_payee_acc_d01_txn_value'' as \\"observations.same_payer_payee_acc_d01_txn_value\\", observations->''observations''->>''payer_unique_payee_acc_online_d01_txn_count'' as \\"observations.payer_unique_payee_acc_online_d01_txn_count\\", observations->''observations''->>''payee_online_intl_card_m30_txn_count'' as \\"observations.payee_online_intl_card_m30_txn_count\\", observations->''observations''->>''same_payee_same_amt_online_m15_txn_count'' as \\"observations.same_payee_same_amt_online_m15_txn_count\\", observations->''observations''->>''same_payee_online_m10_gteq250_txn_count'' as \\"observations.same_payee_online_m10_gteq250_txn_count\\", observations->''observations''->>''payee_account_d01_txn_value'' as \\"observations.payee_account_d01_txn_value\\", observations->''observations''->>''same_payee_acc_PT48H_txn_value'' as \\"observations.same_payee_acc_PT48H_txn_value\\", observations->''observations''->>''payee_acc_decline_less5k_m30_txn_count'' as \\"observations.payee_acc_decline_less5k_m30_txn_count\\", observations->''observations''->>''same_payee_online_PT24H_txn_value'' as \\"observations.same_payee_online_PT24H_txn_value\\", observations->''observations''->>''same_payer_payee_online_PT5M_txnPay_count'' as \\"observations.same_payer_payee_online_PT5M_txnPay_count\\", observations->''observations''->>''payer_decline_m30_txn_count'' as \\"observations.payer_decline_m30_txn_count\\", observations->''observations''->>''same_payer_payee_online_d01_txn_count'' as \\"observations.same_payer_payee_online_d01_txn_count\\", observations->''observations''->>''same_payer_payee_online_d01_txn_value'' as \\"observations.same_payer_payee_online_d01_txn_value\\" , rt.dttrxntime AS \\"Txn Date Time\\", rt.vcmsgid AS \\"Txn ID\\", rt.vcpayercustomerexternalid AS \\"Payer Customer ID\\", rt.vcpayeraccountexternalid AS \\"Payer Account ID\\", rt.vcpayeraddr AS \\"Payer VPA ID\\", rt.vcpayeecustomerexternalid AS \\"Payee Customer ID\\", rt.vcpayeeaccountexternalid AS \\"Payee Account ID\\", rt.vcpayeeaddr AS \\"Payee VPA ID\\", rt.vcclassname AS \\"Txn Class\\", rt.dobservationamount AS \\"Txn Amount\\", rt.vcdecisionname AS \\"Decision Name\\", rt.iruleid AS \\"Rule ID\\", rt.vcrulename AS \\"Rule Name\\", rt.rule_score AS \\"Score\\", rt.vcremark AS \\"Side\\" FROM analytics.rule_triggered rt left join analytics.trans l on l.ilivemessageid = rt.ilivemessageid and l.dttrxntime BETWEEN :StartDate AND :EndDate and l.itenantid = :tenantid WHERE rt.rule_score >= :RiskScore AND rt.dttrxntime BETWEEN :StartDate AND :EndDate and rt.itenantid = :tenantid and rt.vcdecisionname = :Decision and rt.vcrulename = :Rule and rt.vcclassname = :Class order by rt.dttrxntime desc limit :Load"
        }
    }
}'::text WHERE
idashboardqueryid = 112 AND itenantid = 10;