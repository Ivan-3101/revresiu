INSERT INTO ui.dashboard(
	idashboardid, bactive, bdelete, vcdashboardname, iorder, irowcount, imenustructuredesc, itenantid, bdynamic)
	VALUES (61, true, false,'All Auth Report',61,1,510,6, true);

INSERT INTO ui.dashboardquery (
    idashboardqueryid, bparametersrequired, vcfilterparametersjson, vcdashboardquery, 
    formattingrequiered, runonanalytics, transposerequired, imenustructuredesc, itenantid
) 
VALUES (
    123, true, '{"DateRange" : null}', 
    'SELECT 
        observations->''txn''->>''class'' AS "Class (CUB or USFB)", 
        observations->''txn''->''attribs''->''pismo_raw''->''fields''->>''account_id'' AS "Account ID", 
        observations->''observations''->''payerVPA''->>''externalId'' AS "Document Number", 
        observations->''txn''->''attribs''->''pismo_raw''->''fields''->>''last_four_digits'' AS "Last 4 digits of card", 
        observations->''observations''->''payerVPA''->>''vpaName'' AS "Customer Name", 
        dobservationamount AS "Transaction Amount", 
        CAST(observations->''txn''->>''ts'' AS timestamp with time zone) AS "Authorization Date", 
        CAST(observations->''txn''->>''ts'' AS timestamp with time zone) AS "Authorization Timestamp", 
        score AS "FRM Score", 
        observations->''txn''->''attribs''->''pismo_raw''->''fields''->>''network_score'' AS "Network Score", 
        NULL AS "Authorization Response Code", 
        triggeredtype.text_ AS "Approved/Declined", 
        observations->''txn''->''attribs''->>''pos_entry_mode'' AS "POS Entry Mode", 
        observations->''txn''->''payee''->>''mcc'' AS "Merchant Category Code (MCC)", 
        observations->''observations''->''payeeVPA''->>''vpaName'' AS "Merchant Name", 
        observations->''txn''->''attribs''->''pismo_raw''->''fields''->>''merchant_state_or_country_code'' AS "Merchant Location", 
        observations->''txn''->''attribs''->''pismo_raw''->''fields''->>''merchant_state_or_country_code'' AS "Card Acceptor Country Code", 
        NULL AS "Acquirer Country Code", 
        observations->''txn''->''attribs''->>''moto_eci_recurring'' AS "MOTO/ECI/Recurring", 
        observations->''payer''->>''currency'' AS "Issuer Currency Code", 
        observations->''txn''->''attribs''->''pismo_raw''->''fields''->''original_network_data''->>''f61_retrieval_reference_number'' AS "Retrieval Reference Number", 
        vcuniquetransid AS "Transaction ID", 
        observations->''txn''->''attribs''->''pismo_raw''->''fields''->>''terminal_capability'' AS "Terminal Capability", 
        observations->''txn''->''attribs''->''pismo_raw''->''fields''->>''transaction_type'' AS "Transaction Type", 
        observations->''txn''->''attribs''->>''card_holder_id_method'' AS "Cardholder ID Method", 
        observations->''txn''->''attribs''->>''pin_entry_mode'' AS "PIN Entry Capability Code", 
        NULL AS "Terminal Capability Profile", 
        observations->''txn''->''attribs''->>''terminal_type'' AS "Terminal Type", 
        observations->''txn''->''attribs''->''pismo_raw''->''fields''->>''tvr_results'' AS "Terminal Verification Results", 
        CASE 
            WHEN closedby.assignee_ IS NOT NULL AND hiproinst.state_ = ''COMPLETED'' THEN closedby.assignee_ 
            WHEN hiproinst.state_ = ''COMPLETED'' THEN ''Auto Closed'' 
            WHEN hiproinst.proc_inst_id_ IS NOT NULL THEN ''Open'' 
        END AS "Statused By User ID (42 CS Agent)", 
        CASE 
            WHEN closedby.assignee_ IS NOT NULL AND hiproinst.state_ = ''COMPLETED'' THEN userinfo.first_ || '' '' || userinfo.last_ 
            WHEN hiproinst.state_ = ''COMPLETED'' THEN ''Auto Closed'' 
            WHEN hiproinst.proc_inst_id_ IS NOT NULL THEN ''Open'' 
        END AS "Agent Name (42 CS Agent)", 
        hiproinst.end_time_ AS "Alert closed date and time (42 CS Agent)", 
        triggeredtype.text_ AS "Rule type", 
        REPLACE(REPLACE(REPLACE(rulename.text_, ''['', ''''), '']'', ''''), ''"'', '''') AS "Rule Name" 
    FROM analytics.trans txn 
    LEFT JOIN camunda.act_hi_procinst hiproinst ON hiproinst.business_key_ = txn.vcuniquetransid 
    LEFT JOIN camunda.act_hi_varinst triggeredtype ON triggeredtype.proc_inst_id_ = hiproinst.proc_inst_id_ AND triggeredtype.name_ = ''triggeredtype'' 
    LEFT JOIN camunda.act_hi_taskinst closedby ON closedby.id_ = (SELECT id_ FROM camunda.act_hi_taskinst WHERE proc_inst_id_ = hiproinst.proc_inst_id_ ORDER BY end_time_ DESC LIMIT 1) 
    LEFT JOIN camunda.act_id_user userinfo ON userinfo.id_ = closedby.assignee_ 
    LEFT JOIN camunda.act_hi_varinst rulename ON rulename.proc_inst_id_ = hiproinst.proc_inst_id_ AND rulename.name_ = ''failedRules'' 
    WHERE dttrxntime BETWEEN :StartDate AND :EndDate AND itenantid = :tenantid', 
    false, true, false, 510, 6
);



INSERT INTO ui.dashboardresultset(
	idashboardresultsetid, iresultsetorder, vcdashboardresultsetcolumnjson, vcdashboardresultsetlayout, vcdashboardresultsetname, idashboardqueryid, idashboardid, vcdashboardresultsetschema, icolsize, irowno, dtlastupdatedtimestamp, iuserid, imenustructuredesc, itenantid, iorgid)
	VALUES (221,null ,null ,'{
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
                "scroll_lock": true
            },
            "settings": false,
            "theme": "Pro Dark",
            "title": "All Auth Report",
            "group_by": [],
            "split_by": [],
            "columns": [],
            "filter": [],
            "sort": [],
            "expressions": [],
            "aggregates": {},
            "master": false,
            "table": "allauthreport",
            "linked": false
        }
    }
}' ,'allauthreport' ,123 ,61 ,'{
                                                                       	"Class (CUB or USFB)": "string",
                                                                       	"Account ID":"integer",
                                                                       	"Document Number":"string",
                                                                       	"Last 4 digits of card":"integer",
                                                                       	"Customer Name":"string",
                                                                       	"Transaction Amount": "float",
                                                                       	"Authorization Date":"date",
                                                                       	"Authorization Timestamp":"datetime",
                                                                       	"FRM Score":"integer",
                                                                       	"Netwrok Score":"integer",
                                                                       	"Authorization Response Code": "integer",
                                                                       	"Approved/Declined":"string",
                                                                       	"POS Entry Mode":"string",
                                                                       	"Merchant Category Code (MCC)":"integer",
                                                                       	"Merchant Name":"string",
                                                                       	"Merchant Location":"string",
                                                                       	"Card Acceptor Country Code":"string",
                                                                       	"Acquirer Country Code"	:"integer",
                                                                       	"MOTO/ECI/Recurring":"string",
                                                                       	"Issuer Currency Code":"string",
                                                                           "Retrieval Reference Number":"string",
                                                                           "Transaction ID":"string",
                                                                           "Terminal Capability":"integer",
                                                                           "Transaction Type":"integer",
                                                                           "Cardholder ID Method":"integer",
                                                                           "PIN Entry Capability Code":"integer",
                                                                           "Terminal Capability Profile":"string",
                                                                           "Terminal Type":"integer",
                                                                           "Terminal Verification Results":"string",
                                                                           "Statused By User ID (42 CS Agent)":"string",
                                                                           "Agent Name (42 CS Agent)":"string",
                                                                           "Alert closed date and time (42 CS Agent)":"datetime",
                                                                           "Rule type":"string",
                                                                           "Rule Name":"string"
                                                                       }' ,null ,1 ,null ,null ,510 ,6 ,null );


INSERT INTO ui.dashboardqueryparameters(
	idashboardparameterid, vcparametername, vcparametertype, idashboardqueryid, iorder, itenantid)
	VALUES (260,'DateRange' ,'DateRange' ,123 ,null ,6 );

INSERT INTO ui.dashboardfilters(
	idashboardfilterid, ifilterorder, vcdashboardfiltername, idashboardid, vcdashboardfiltertype, idashboardqueryidfordefaultvalue, idashboardqueryidforoptions, itenantid, vcdashboardfilterdisplayname)
	VALUES (166,0 ,'DateRange' ,61 ,'DateRangePicker' ,16 ,null ,6 ,'Date Range' );


INSERT INTO ui.dashboard(
	idashboardid, bactive, bdelete, vcdashboardname, iorder, irowcount, imenustructuredesc, itenantid, bdynamic)
	VALUES (61, true, false,'All Auth Report',61,1,510,7, true);


INSERT INTO ui.dashboardquery (
    idashboardqueryid, bparametersrequired, vcfilterparametersjson, vcdashboardquery, formattingrequiered, runonanalytics, transposerequired, imenustructuredesc, itenantid
)
VALUES (
    123, true, '{"DateRange" : null}',
    'select 
        observations->''txn''->>''class'' as "Class (CUB or USFB)", 
        observations->''txn''->''attribs''->''pismo_raw''->''fields''->>''account_id'' as "Account ID", 
        observations->''observations''->''payerVPA''->>''externalId'' as "Document Number", 
        observations->''txn''->''attribs''->''pismo_raw''->''fields''->>''last_four_digits'' as "Last 4 digits of card", 
        observations->''observations''->''payerVPA''->>''vpaName'' as "Customer Name", 
        dobservationamount as "Transaction Amount", 
        cast(observations->''txn''->>''ts'' as timestamp with time zone) as "Authorization Date", 
        cast(observations->''txn''->>''ts'' as timestamp with time zone) as "Authorization Timestamp", 
        score as "FRM Score", 
        observations->''txn''->''attribs''->''pismo_raw''->''fields''->>''network_score'' as "Network Score", 
        null as "Authorization Response Code", 
        triggeredtype.text_ as "Approved/Declined", 
        observations->''txn''->''attribs''->>''pos_entry_mode'' as "POS Entry Mode", 
        observations->''txn''->''payee''->>''mcc'' as "Merchant Category Code (MCC)", 
        observations->''observations''->''payeeVPA''->>''vpaName'' as "Merchant Name", 
        observations->''txn''->''attribs''->''pismo_raw''->''fields''->>''merchant_state_or_country_code'' as "Merchant Location", 
        observations->''txn''->''attribs''->''pismo_raw''->''fields''->>''merchant_state_or_country_code'' as "Card Acceptor Country Code", 
        null as "Acquirer Country Code", 
        observations->''txn''->''attribs''->>''moto_eci_recurring'' as "MOTO/ECI/Recurring", 
        observations->''payer''->>''currency'' as "Issuer Currency Code", 
        observations->''txn''->''attribs''->''pismo_row''->''fields''->''original_network_data''->>''f61_retrieval_reference_number'' as "Retrieval Reference Number", 
        vcuniquetransid as "Transaction ID", 
        observations->''txn''->''attribs''->''pismo_raw''->''fields''->>''terminal_capability'' as "Terminal Capability", 
        observations->''txn''->''attribs''->''pismo_raw''->''fields''->>''transaction_type'' as "Transaction Type", 
        observations->''txn''->''attribs''->>''card_holder_id_method'' as "Cardholder ID Method", 
        observations->''txn''->''attribs''->>''pin_entry_mode'' as "PIN Entry Capability Code", 
        null as "Terminal Capability Profile", 
        observations->''txn''->''attribs''->>''terminal_type'' as "Terminal Type", 
        observations->''txn''->''attribs''->''pismo_row''->''fields''->>''tvr_results'' as "Terminal Verification Results", 
        case when closedby.assignee_ is not null and hiproinst.state_ = ''COMPLETED'' THEN closedby.assignee_ 
             when hiproinst.state_ = ''COMPLETED'' then ''Auto Closed'' 
             when hiproinst.proc_inst_id_ is not null then ''Open'' END as "Statused By User ID (42 CS Agent)", 
        case when closedby.assignee_ is not null and hiproinst.state_ = ''COMPLETED'' THEN userinfo.first_ || '' '' || userinfo.last_ 
             when hiproinst.state_ = ''COMPLETED'' then ''Auto Closed'' 
             when hiproinst.proc_inst_id_ is not null then ''Open'' END as "Agent Name (42 CS Agent)", 
        hiproinst.end_time_ as "Alert closed date and time (42 CS Agent)", 
        triggeredtype.text_ as "Rule type", 
        replace(replace(replace(rulename.text_, ''['', ''''), '']'', ''''), ''"'', '''') as "Rule Name" 
    from analytics.trans txn 
    left join camunda.act_hi_procinst hiproinst on hiproinst.business_key_ = txn.vcuniquetransid 
    left join camunda.act_hi_varinst triggeredtype on triggeredtype.proc_inst_id_ = hiproinst.proc_inst_id_ and triggeredtype.name_ = ''triggeredtype'' 
    left join camunda.act_hi_taskinst closedby on closedby.id_ = (select id_ from camunda.act_hi_taskinst where proc_inst_id_ = hiproinst.proc_inst_id_ order by end_time_ desc limit 1) 
    left join camunda.act_id_user userinfo on userinfo.id_ = closedby.assignee_ 
    left join camunda.act_hi_varinst rulename on rulename.proc_inst_id_ = hiproinst.proc_inst_id_ and rulename.name_ = ''failedRules'' 
    where dttrxntime between :StartDate and :EndDate and itenantid = :tenantid',
    false, true, false, 510, 7
);


INSERT INTO ui.dashboardresultset(
	idashboardresultsetid, iresultsetorder, vcdashboardresultsetcolumnjson, vcdashboardresultsetlayout, vcdashboardresultsetname, idashboardqueryid, idashboardid, vcdashboardresultsetschema, icolsize, irowno, dtlastupdatedtimestamp, iuserid, imenustructuredesc, itenantid, iorgid)
	VALUES (221,null ,null ,'{
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
                "scroll_lock": true
            },
            "settings": false,
            "theme": "Pro Dark",
            "title": "All Auth Report",
            "group_by": [],
            "split_by": [],
            "columns": [],
            "filter": [],
            "sort": [],
            "expressions": [],
            "aggregates": {},
            "master": false,
            "table": "allauthreport",
            "linked": false
        }
    }
}' ,'allauthreport' ,123 ,61 ,'{
                                                                       	"Class (CUB or USFB)": "string",
                                                                       	"Account ID":"integer",
                                                                       	"Document Number":"string",
                                                                       	"Last 4 digits of card":"integer",
                                                                       	"Customer Name":"string",
                                                                       	"Transaction Amount": "float",
                                                                       	"Authorization Date":"date",
                                                                       	"Authorization Timestamp":"datetime",
                                                                       	"FRM Score":"integer",
                                                                       	"Netwrok Score":"integer",
                                                                       	"Authorization Response Code": "integer",
                                                                       	"Approved/Declined":"string",
                                                                       	"POS Entry Mode":"string",
                                                                       	"Merchant Category Code (MCC)":"integer",
                                                                       	"Merchant Name":"string",
                                                                       	"Merchant Location":"string",
                                                                       	"Card Acceptor Country Code":"string",
                                                                       	"Acquirer Country Code"	:"integer",
                                                                       	"MOTO/ECI/Recurring":"string",
                                                                       	"Issuer Currency Code":"string",
                                                                           "Retrieval Reference Number":"string",
                                                                           "Transaction ID":"string",
                                                                           "Terminal Capability":"integer",
                                                                           "Transaction Type":"integer",
                                                                           "Cardholder ID Method":"integer",
                                                                           "PIN Entry Capability Code":"integer",
                                                                           "Terminal Capability Profile":"string",
                                                                           "Terminal Type":"integer",
                                                                           "Terminal Verification Results":"string",
                                                                           "Statused By User ID (42 CS Agent)":"string",
                                                                           "Agent Name (42 CS Agent)":"string",
                                                                           "Alert closed date and time (42 CS Agent)":"datetime",
                                                                           "Rule type":"string",
                                                                           "Rule Name":"string"
                                                                       }' ,null ,1 ,null ,null ,510 ,7 ,null );




INSERT INTO ui.dashboardqueryparameters(
	idashboardparameterid, vcparametername, vcparametertype, idashboardqueryid, iorder, itenantid)
	VALUES (260,'DateRange' ,'DateRange' ,123 ,null ,7 );

INSERT INTO ui.dashboardfilters(
	idashboardfilterid, ifilterorder, vcdashboardfiltername, idashboardid, vcdashboardfiltertype, idashboardqueryidfordefaultvalue, idashboardqueryidforoptions, itenantid, vcdashboardfilterdisplayname)
	VALUES (166,0 ,'DateRange' ,61 ,'DateRangePicker' ,16 ,null ,7 ,'Date Range' );


