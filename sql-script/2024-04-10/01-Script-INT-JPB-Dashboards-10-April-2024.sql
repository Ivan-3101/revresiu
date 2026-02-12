INSERT INTO ui.dashboard(idashboardid, bactive, bdelete, vcdashboardname, iorder, irowcount, imenustructuredesc, itenantid, bdynamic) select 62, true, false, 'Alert Disposition Report', 62, 1, 536,itenantid, true  FROM 
ui.tenants where iorgid = 9;



INSERT INTO ui.dashboardfilters(idashboardfilterid, ifilterorder, vcdashboardfiltername, idashboardid, vcdashboardfiltertype,
 idashboardqueryidfordefaultvalue, idashboardqueryidforoptions, itenantid, vcdashboardfilterdisplayname) 
 SELECT 167,0,'DateRange',62,'DateRangePicker',79,NULL,t.itenantid, 'Date Range' FROM ui.tenants t WHERE 
 t.iorgid = 9;


INSERT INTO ui.dashboardquery(idashboardqueryid, bparametersrequired, vcfilterparametersjson, vcdashboardquery,
 formattingrequiered, runonanalytics, transposerequired, imenustructuredesc, itenantid)
  SELECT 124,FALSE,NULL,'SELECT X.* FROM   (VALUES
				   (''Review Case'', ''Review Case''),
				   (''Checker Approval'', ''Checker Approval'')
				  ) AS X ("label", "value")',FALSE,FALSE,FALSE,536, t.itenantid FROM ui.tenants t WHERE itenantid != 0 AND t.iorgid = 9;



 INSERT INTO ui.dashboardfilters(idashboardfilterid, ifilterorder, vcdashboardfiltername, idashboardid, vcdashboardfiltertype,
 idashboardqueryidfordefaultvalue, idashboardqueryidforoptions, itenantid, vcdashboardfilterdisplayname) 
 SELECT 168,1,'Stage',62,'Select',null,124,t.itenantid, 'Stage' FROM ui.tenants t WHERE 
 t.iorgid = 9;


 



INSERT INTO ui.dashboardquery(idashboardqueryid, bparametersrequired, vcfilterparametersjson, vcdashboardquery,
 formattingrequiered, runonanalytics, transposerequired, imenustructuredesc, itenantid)
  SELECT 125,FALSE,'{
    "Stage":null, 
    "DateRange": null
}','select 
case
	when task.name_ = ''Review Case'' then 
	case 
		when act.text_ = ''Value_Close'' then ''Mark as false positive & Close''
		when act.text_ = ''Value_Fraud'' then ''Mark as confirmed Fraud''
		when act.text_ = ''Value_Update_Whitelist'' then ''Update Whitelist''
	end
	when task.name_ = ''Checker Approval'' then act2.text_
	else null
end 
 
 as "Action[Previous disposition]",
 case
	when task.name_ = ''Review Case'' then act.time_
	when task.name_ = ''Checker Approval'' then act2.time_
	else null
end as "DateTime",
  wu.vcusername as "User",
  task.name_ as "Stage",
  payer.text_ as "Payer", 
  payee.text_ as "Payee", 
  TransactionAmount.double_ / 100 as "Amount", 
  TicketID.long_ as "Case ID"

from 
  camunda.act_hi_procinst hiproinst full 
  outer join camunda.act_re_procdef pdef on pdef.id_ = hiproinst.proc_def_id_ full 
  outer join camunda.act_hi_taskinst task on task.proc_inst_id_ = hiproinst.proc_inst_id_ 
  left join camunda.act_id_user cuser on cuser.id_ = task.assignee_ 
  
  full outer join camunda.act_hi_varinst payer on payer.proc_inst_id_ = hiproinst.proc_inst_id_ 
  and payer.name_ = ''payer'' full 
  outer join camunda.act_hi_varinst payee on payee.proc_inst_id_ = hiproinst.proc_inst_id_ 
  and payee.name_ = ''payee'' full 
  outer join camunda.act_hi_varinst TransactionAmount on TransactionAmount.proc_inst_id_ = hiproinst.proc_inst_id_ 
  and TransactionAmount.name_ = ''TransactionAmount'' full 
  outer join camunda.act_hi_varinst TicketID on TicketID.proc_inst_id_ = hiproinst.proc_inst_id_ 
  and TicketID.name_ = ''TicketID'' 
  left join ui.webuser wu on wu.iuserid = cast(task.assignee_ as integer)
  left join camunda.act_hi_detail act on act.task_id_ = task.id_ and    act.name_ = ''Action''
  left join camunda.act_hi_detail act2 on act2.task_id_ = task.id_ and   act2.name_ = ''checker_action_whitelist''
where 
  cast(hiproinst.start_time_ as date) between cast( :StartDate as date) 
  and cast( :EndDate as date)   and 
  hiproinst.state_ != ''EXTERNALLY_TERMINATED'' 
  and hiproinst.proc_def_key_ in (
    with d1 as (
      select 
        mappingid 
      from 
        ui.webusermapping 
      where 
        webuserid = :loggedinuser 
        and mappingtype = ''Workflow''
    ) (
      select 
        workflowkey 
      FROM 
        ui.workflowmasters 
      where 
        (
          workflowid in (
            select 
              mappingid 
            from 
              d1
          ) 
          or -1 in (
            select 
              mappingid 
            from 
              d1
          )
        ) 
        and itenantid = :tenantid
        and is_filter_display = true
    )
  ) 
  and hiproinst.tenant_id_ = :tenantidstr
  and hiproinst.proc_def_key_ = ''JPB_RiskNotification''
  and task.name_ = :Stage
',FALSE,FALSE,FALSE,536, t.itenantid FROM ui.tenants t WHERE t.iorgid = 9;

INSERT INTO ui.dashboardqueryparameters(idashboardparameterid, vcparametername, vcparametertype, idashboardqueryid,
 iorder, itenantid) SELECT 261,'DateRange','DateRange',125,NULL, t.itenantid FROM ui.tenants t WHERE t.iorgid = 9;


INSERT INTO ui.dashboardqueryparameters(idashboardparameterid, vcparametername, vcparametertype, idashboardqueryid,
 iorder, itenantid) SELECT 262,'Stage','String',125,NULL, t.itenantid FROM ui.tenants t WHERE t.iorgid = 9;



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
    "Case ID":"integer"
}',NULL,1,NULL,NULL,536,t.itenantid,iorgid FROM ui.tenants t WHERE 
 t.iorgid = 9;


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
idashboardresultsetid = 58 AND itenantid in (12, 13);



UPDATE ui.dashboardresultset SET
vcdashboardresultsetschema = '{
    "Txn Date Time": "datetime",
    "Txn ID": "string",
    "Payer Customer ID": "string",
    "Payer Account ID": "string",
    "Payer VPA ID": "string",
    "Payee Customer ID": "string",
    "Payee Account ID": "string",
    "Payee VPA ID": "string",
    "Txn Class": "string",
    "Txn Amount": "float",
    "Decision Name": "string",
    "Rule ID": "integer",
    "Rule Name": "string",
    "Score": "integer",
    "Side": "string",

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
idashboardresultsetid = 48 AND itenantid in (12, 13);

update ui.dashboardquery set 
vcdashboardquery = 'select 
case
	when task.name_ = ''Review Case'' then 
	case 
		when act.text_ = ''Value_Close'' then ''Mark as false positive & Close''
		when act.text_ = ''Value_Fraud'' then ''Mark as confirmed Fraud''
		when act.text_ = ''Value_Update_Whitelist'' then ''Update Whitelist''
		when act.text_ = ''Suspected_Fraud'' then ''Mark as suspected fraud''
	end
	when task.name_ = ''Checker Approval'' then act2.text_
	else null
end 
 
 as "Action",
 case
	when task.name_ = ''Review Case'' then act.time_
	when task.name_ = ''Checker Approval'' then act2.time_
	else null
end as "DateTime",
  wu.vcusername as "User",
  task.name_ as "Stage",
  payer.text_ as "Payer", 
  payee.text_ as "Payee", 
  TransactionAmount.double_ / 100 as "Amount", 
  TicketID.long_ as "Case ID"

from 
  camunda.act_hi_procinst hiproinst full 
  outer join camunda.act_re_procdef pdef on pdef.id_ = hiproinst.proc_def_id_ full 
  outer join camunda.act_hi_taskinst task on task.proc_inst_id_ = hiproinst.proc_inst_id_ 
  left join camunda.act_id_user cuser on cuser.id_ = task.assignee_ 
  
  full outer join camunda.act_hi_varinst payer on payer.proc_inst_id_ = hiproinst.proc_inst_id_ 
  and payer.name_ = ''payer'' full 
  outer join camunda.act_hi_varinst payee on payee.proc_inst_id_ = hiproinst.proc_inst_id_ 
  and payee.name_ = ''payee'' full 
  outer join camunda.act_hi_varinst TransactionAmount on TransactionAmount.proc_inst_id_ = hiproinst.proc_inst_id_ 
  and TransactionAmount.name_ = ''TransactionAmount'' full 
  outer join camunda.act_hi_varinst TicketID on TicketID.proc_inst_id_ = hiproinst.proc_inst_id_ 
  and TicketID.name_ = ''TicketID'' 
  left join ui.webuser wu on wu.iuserid = cast(task.assignee_ as integer)
  left join camunda.act_hi_detail act on act.task_id_ = task.id_ and    act.name_ = ''Action''
  left join camunda.act_hi_detail act2 on act2.proc_inst_id_ = hiproinst.proc_inst_id_ and   act2.name_ = ''checker_action_whitelist''
where 
  cast(hiproinst.start_time_ as date) between cast( :StartDate as date) 
  and cast( :EndDate as date)   and 
  hiproinst.state_ != ''EXTERNALLY_TERMINATED'' 
  and hiproinst.proc_def_key_ in (
    with d1 as (
      select 
        mappingid 
      from 
        ui.webusermapping 
      where 
        webuserid = :loggedinuser 
        and mappingtype = ''Workflow''
    ) (
      select 
        workflowkey 
      FROM 
        ui.workflowmasters 
      where 
        (
          workflowid in (
            select 
              mappingid 
            from 
              d1
          ) 
          or -1 in (
            select 
              mappingid 
            from 
              d1
          )
        ) 
        and itenantid = :tenantid
        and is_filter_display = true
    )
  ) 
  and hiproinst.tenant_id_ = :tenantidstr
  and hiproinst.proc_def_key_ = ''JPB_RiskNotification''
  and task.name_ = :Stage
' 
where idashboardqueryid =125

update ui.dashboardresultset set 
vcdashboardresultsetschema = '{
    "Action":"string", 
    "DateTime":"datetime",
    "User":"string",
    "Stage":"string",
    "Payer":"string",
    "Payee":"string",
    "Case ID":"integer"
}'
where idashboardresultsetid =222