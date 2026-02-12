UPDATE ui.dashboardfilters SET
vcdashboardfiltertype = 'DateRangePicker'::character varying, vcdashboardfiltername = 'Date Range'::character varying, idashboardqueryidfordefaultvalue = '16'::integer WHERE
idashboardfilterid = 44;


UPDATE ui.dashboardquery SET
vcdashboardquery = '{
    "All" : {
      "Claimed" : "SELECT pdef.name_ as \"Case Type\", task.name_ as \"Stage\", task.assignee_ as \"Claimed By\", CASE WHEN  task.assignee_ is not null THEN hdetail.time_ ELSE null END as \"Claimed On\", task.create_time_ \"Created Date\", CASE WHEN  task.assignee_ is not null THEN ''Claimed'' ELSE ''Unclaimed'' END as \"Status\", payer.text_ as \"Payer\", payee.text_ as \"Payee\", TransactionAmount.double_ / 100 as \"Amount\", TicketID.long_ as \"Case ID\", Alert.text_ as \"Alert\" FROM camunda.act_ru_task task left join camunda.act_re_procdef pdef on pdef.id_ = task.proc_def_id_ left join camunda.act_hi_detail hdetail on hdetail.proc_inst_id_ = task.proc_inst_id_ and hdetail.name_ = ''userActivity'' left join camunda.act_hi_detail payer on payer.proc_inst_id_ = task.proc_inst_id_ and payer.name_ = ''payer'' left join camunda.act_hi_detail payee on payee.proc_inst_id_ = task.proc_inst_id_ and payee.name_ = ''payee'' left join camunda.act_hi_detail TransactionAmount on TransactionAmount.proc_inst_id_ = task.proc_inst_id_ and TransactionAmount.name_ = ''TransactionAmount'' left join camunda.act_hi_detail TicketID on TicketID.proc_inst_id_ = task.proc_inst_id_ and TicketID.name_ = ''TicketID'' left join camunda.act_hi_detail Alert on Alert.proc_inst_id_ = task.proc_inst_id_ and Alert.name_ = ''Alert'' where cast(task.create_time_ as date)  between cast(:StartDate as date) and cast(:EndDate as date)-1   and task.assignee_ is not null",
      "Unclaimed" : "SELECT pdef.name_ as \"Case Type\", task.name_ as \"Stage\", task.assignee_ as \"Claimed By\", CASE WHEN  task.assignee_ is not null THEN hdetail.time_ ELSE null END as \"Claimed On\", task.create_time_ \"Created Date\", CASE WHEN  task.assignee_ is not null THEN ''Claimed'' ELSE ''Unclaimed'' END as \"Status\", payer.text_ as \"Payer\", payee.text_ as \"Payee\", TransactionAmount.double_ / 100 as \"Amount\", TicketID.long_ as \"Case ID\", Alert.text_ as \"Alert\" FROM camunda.act_ru_task task left join camunda.act_re_procdef pdef on pdef.id_ = task.proc_def_id_ left join camunda.act_hi_detail hdetail on hdetail.proc_inst_id_ = task.proc_inst_id_ and hdetail.name_ = ''userActivity'' left join camunda.act_hi_detail payer on payer.proc_inst_id_ = task.proc_inst_id_ and payer.name_ = ''payer'' left join camunda.act_hi_detail payee on payee.proc_inst_id_ = task.proc_inst_id_ and payee.name_ = ''payee'' left join camunda.act_hi_detail TransactionAmount on TransactionAmount.proc_inst_id_ = task.proc_inst_id_ and TransactionAmount.name_ = ''TransactionAmount'' left join camunda.act_hi_detail TicketID on TicketID.proc_inst_id_ = task.proc_inst_id_ and TicketID.name_ = ''TicketID'' left join camunda.act_hi_detail Alert on Alert.proc_inst_id_ = task.proc_inst_id_ and Alert.name_ = ''Alert'' where cast(task.create_time_ as date)  between cast(:StartDate as date) and cast(:EndDate as date)-1  and task.assignee_ is null",
      "All" : "SELECT pdef.name_ as \"Case Type\", task.name_ as \"Stage\", task.assignee_ as \"Claimed By\", CASE WHEN  task.assignee_ is not null THEN hdetail.time_ ELSE null END as \"Claimed On\", task.create_time_ \"Created Date\", CASE WHEN  task.assignee_ is not null THEN ''Claimed'' ELSE ''Unclaimed'' END as \"Status\", payer.text_ as \"Payer\", payee.text_ as \"Payee\", TransactionAmount.double_ / 100 as \"Amount\", TicketID.long_ as \"Case ID\", Alert.text_ as \"Alert\" FROM camunda.act_ru_task task left join camunda.act_re_procdef pdef on pdef.id_ = task.proc_def_id_ left join camunda.act_hi_detail hdetail on hdetail.proc_inst_id_ = task.proc_inst_id_ and hdetail.name_ = ''userActivity'' left join camunda.act_hi_detail payer on payer.proc_inst_id_ = task.proc_inst_id_ and payer.name_ = ''payer'' left join camunda.act_hi_detail payee on payee.proc_inst_id_ = task.proc_inst_id_ and payee.name_ = ''payee'' left join camunda.act_hi_detail TransactionAmount on TransactionAmount.proc_inst_id_ = task.proc_inst_id_ and TransactionAmount.name_ = ''TransactionAmount'' left join camunda.act_hi_detail TicketID on TicketID.proc_inst_id_ = task.proc_inst_id_ and TicketID.name_ = ''TicketID'' left join camunda.act_hi_detail Alert on Alert.proc_inst_id_ = task.proc_inst_id_ and Alert.name_ = ''Alert'' where cast(task.create_time_ as date)  between cast(:StartDate as date) and cast(:EndDate as date)-1 "
    },
    "Other":{
      "Claimed" : "SELECT pdef.name_ as \"Case Type\", task.name_ as \"Stage\", task.assignee_ as \"Claimed By\", CASE WHEN  task.assignee_ is not null THEN hdetail.time_ ELSE null END as \"Claimed On\", task.create_time_ \"Created Date\", CASE WHEN  task.assignee_ is not null THEN ''Claimed'' ELSE ''Unclaimed'' END as \"Status\", payer.text_ as \"Payer\", payee.text_ as \"Payee\", TransactionAmount.double_ / 100 as \"Amount\", TicketID.long_ as \"Case ID\", Alert.text_ as \"Alert\" FROM camunda.act_ru_task task left join camunda.act_re_procdef pdef on pdef.id_ = task.proc_def_id_ left join camunda.act_hi_detail hdetail on hdetail.proc_inst_id_ = task.proc_inst_id_ and hdetail.name_ = ''userActivity'' left join camunda.act_hi_detail payer on payer.proc_inst_id_ = task.proc_inst_id_ and payer.name_ = ''payer'' left join camunda.act_hi_detail payee on payee.proc_inst_id_ = task.proc_inst_id_ and payee.name_ = ''payee'' left join camunda.act_hi_detail TransactionAmount on TransactionAmount.proc_inst_id_ = task.proc_inst_id_ and TransactionAmount.name_ = ''TransactionAmount'' left join camunda.act_hi_detail TicketID on TicketID.proc_inst_id_ = task.proc_inst_id_ and TicketID.name_ = ''TicketID'' left join camunda.act_hi_detail Alert on Alert.proc_inst_id_ = task.proc_inst_id_ and Alert.name_ = ''Alert'' where cast(task.create_time_ as date)  between cast(:StartDate as date) and cast(:EndDate as date)-1 and task.proc_def_id_ in (SELECT id_ FROM camunda.act_re_procdef where key_ = :CaseType ) and task.assignee_ is not null",
      "Unclaimed" : "SELECT pdef.name_ as \"Case Type\", task.name_ as \"Stage\", task.assignee_ as \"Claimed By\", CASE WHEN  task.assignee_ is not null THEN hdetail.time_ ELSE null END as \"Claimed On\", task.create_time_ \"Created Date\", CASE WHEN  task.assignee_ is not null THEN ''Claimed'' ELSE ''Unclaimed'' END as \"Status\", payer.text_ as \"Payer\", payee.text_ as \"Payee\", TransactionAmount.double_ / 100 as \"Amount\", TicketID.long_ as \"Case ID\", Alert.text_ as \"Alert\" FROM camunda.act_ru_task task left join camunda.act_re_procdef pdef on pdef.id_ = task.proc_def_id_ left join camunda.act_hi_detail hdetail on hdetail.proc_inst_id_ = task.proc_inst_id_ and hdetail.name_ = ''userActivity'' left join camunda.act_hi_detail payer on payer.proc_inst_id_ = task.proc_inst_id_ and payer.name_ = ''payer'' left join camunda.act_hi_detail payee on payee.proc_inst_id_ = task.proc_inst_id_ and payee.name_ = ''payee'' left join camunda.act_hi_detail TransactionAmount on TransactionAmount.proc_inst_id_ = task.proc_inst_id_ and TransactionAmount.name_ = ''TransactionAmount'' left join camunda.act_hi_detail TicketID on TicketID.proc_inst_id_ = task.proc_inst_id_ and TicketID.name_ = ''TicketID'' left join camunda.act_hi_detail Alert on Alert.proc_inst_id_ = task.proc_inst_id_ and Alert.name_ = ''Alert'' where cast(task.create_time_ as date)  between cast(:StartDate as date) and cast(:EndDate as date)-1 and task.proc_def_id_ in (SELECT id_ FROM camunda.act_re_procdef where key_ = :CaseType ) and task.assignee_ is null",
      "All" : "SELECT pdef.name_ as \"Case Type\", task.name_ as \"Stage\", task.assignee_ as \"Claimed By\", CASE WHEN  task.assignee_ is not null THEN hdetail.time_ ELSE null END as \"Claimed On\", task.create_time_ \"Created Date\", CASE WHEN  task.assignee_ is not null THEN ''Claimed'' ELSE ''Unclaimed'' END as \"Status\", payer.text_ as \"Payer\", payee.text_ as \"Payee\", TransactionAmount.double_ / 100 as \"Amount\", TicketID.long_ as \"Case ID\", Alert.text_ as \"Alert\" FROM camunda.act_ru_task task left join camunda.act_re_procdef pdef on pdef.id_ = task.proc_def_id_ left join camunda.act_hi_detail hdetail on hdetail.proc_inst_id_ = task.proc_inst_id_ and hdetail.name_ = ''userActivity'' left join camunda.act_hi_detail payer on payer.proc_inst_id_ = task.proc_inst_id_ and payer.name_ = ''payer'' left join camunda.act_hi_detail payee on payee.proc_inst_id_ = task.proc_inst_id_ and payee.name_ = ''payee'' left join camunda.act_hi_detail TransactionAmount on TransactionAmount.proc_inst_id_ = task.proc_inst_id_ and TransactionAmount.name_ = ''TransactionAmount'' left join camunda.act_hi_detail TicketID on TicketID.proc_inst_id_ = task.proc_inst_id_ and TicketID.name_ = ''TicketID'' left join camunda.act_hi_detail Alert on Alert.proc_inst_id_ = task.proc_inst_id_ and Alert.name_ = ''Alert'' where cast(task.create_time_ as date)  between cast(:StartDate as date) and cast(:EndDate as date)-1 and task.proc_def_id_ in (SELECT id_ FROM camunda.act_re_procdef where key_ = :CaseType ) "
    }
  } '::text, vcfilterparametersjson = '{"DateRange" : null, "CaseType" : null, "Status" : null } '::text WHERE
idashboardqueryid = 62;


UPDATE ui.dashboardqueryparameters SET
vcparametertype = 'DateRange'::character varying, vcparametername = 'DateRange'::character varying WHERE
idashboardparameterid = 100;


UPDATE ui.dashboardfilters SET
vcdashboardfiltername = 'DateRange'::character varying, vcdashboardfilterdisplayname = 'Date Range'::character varying, idashboardqueryidfordefaultvalue = '16'::integer WHERE
idashboardfilterid = 44;


UPDATE ui.dashboardresultset SET
vcdashboardresultsetschema = '{
           "Case ID": "integer",
           "Case Type": "string",
           "Stage": "string",
           "Alert":  "string",
           "Payer" :  "string",
           "Amount":  "float",
           "Payee": "string",
           "Claimed By": "string",
           "Claimed On":  "datetime",
           "Created Date":  "datetime",
           "Status": "string"
         }'::text WHERE
idashboardresultsetid = 29;




DROP TABLE ui.grouptotaskfiltermap;

CREATE TABLE ui.grouptotaskfiltermap (
    igrouptotaskfilterid integer NOT NULL,
    iposition integer,
    igroupid integer,
    itaskfilterid integer
);



ALTER TABLE ui.grouptotaskfiltermap ALTER COLUMN igrouptotaskfilterid ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME ui.grouptotaskfiltermap_igrouptotaskfilterid_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


ALTER TABLE ONLY ui.grouptotaskfiltermap
    ADD CONSTRAINT grouptotaskfiltermap_pkey PRIMARY KEY (igrouptotaskfilterid);


ALTER TABLE ONLY ui.grouptotaskfiltermap
    ADD CONSTRAINT fk9ake59q4vntf4hnxxrwim4obd FOREIGN KEY (igroupid) REFERENCES ui.groupdesc(igroupid);


ALTER TABLE ONLY ui.grouptotaskfiltermap
    ADD CONSTRAINT fkednd4ha1gdiqbmxm545mnt94u FOREIGN KEY (itaskfilterid) REFERENCES ui.taskfiltermaster(itaskfilterid);





 INSERT INTO ui.grouptotaskfiltermap( iposition, igroupid, itaskfilterid)
 SELECT 1, igroupid, 1
 FROM
 ui.groupdesc;


 INSERT INTO ui.grouptotaskfiltermap( iposition, igroupid, itaskfilterid)
 SELECT 2, igroupid, 2
 FROM
 ui.groupdesc;


 INSERT INTO ui.grouptotaskfiltermap( iposition, igroupid, itaskfilterid)
 SELECT 3, igroupid, 3
 FROM
 ui.groupdesc where vcgroupid in ('riskanalyst', 'risksupervisor');


 INSERT INTO ui.grouptotaskfiltermap( iposition, igroupid, itaskfilterid)
 SELECT 4, igroupid, 4
 FROM ui.groupdesc;

 INSERT INTO ui.grouptotaskfiltermap( iposition, igroupid, itaskfilterid)
 SELECT 5, igroupid, 5
 FROM ui.groupdesc;

 INSERT INTO ui.grouptotaskfiltermap( iposition, igroupid, itaskfilterid)
 SELECT 6, igroupid, 6
 FROM ui.groupdesc;

 INSERT INTO ui.grouptotaskfiltermap( iposition, igroupid, itaskfilterid)
 SELECT 7, igroupid, 7
 FROM ui.groupdesc;

 INSERT INTO ui.grouptotaskfiltermap( iposition, igroupid, itaskfilterid)
 SELECT 8, igroupid, 8
 FROM ui.groupdesc;

 INSERT INTO ui.grouptotaskfiltermap( iposition, igroupid, itaskfilterid)
 SELECT 9, igroupid,9
 FROM ui.groupdesc;

 INSERT INTO ui.grouptotaskfiltermap( iposition, igroupid, itaskfilterid)
 SELECT 10, igroupid, 10
 FROM ui.groupdesc
 where vcgroupid in ('level1', 'level2',
 				   'level3', 'level4', 'level5'
 				  , 'db','branch','it');

UPDATE ui.dashboardresultset SET
vcdashboardresultsetlayout = '{"sizes":[1],"detail":{"main":{"type":"split-area","orientation":"horizontal","children":[{"type":"tab-area","widgets":["PERSPECTIVE_GENERATED_ID_2"],"currentIndex":0},{"type":"tab-area","widgets":["PERSPECTIVE_GENERATED_ID_6"],"currentIndex":0}],"sizes":[0.822380106571936,0.17761989342806395]}},"mode":"globalFilters","viewers":{"PERSPECTIVE_GENERATED_ID_2":{"plugin":"Custom Datagrid","plugin_config":{"columns":{},"editable":false,"scroll_lock":true},"settings":false,"theme":"Material Dark","group_by":[],"split_by":[],"columns":["ILiveMessageID","UniqueID","Class","Type","Time","Amount","Score","FRMPass","Payer Account","PayerVPA","Payee Account","PayeeVPA","PayerName","PayeeName","decisiondetails"],"filter":[],"sort":[["Time","desc"]],"expressions":["//Type\n    if (is_not_null(\"Payer Account\") and   is_not_null(\"Payee Account\")) {\n        ''A2A''\n    } else if (is_not_null(\"Payer Account\")) {\n        ''A2P''\n    } else if (is_not_null(\"Payee Account\")) {\n        ''P2A''\n    }else\n    {\n        ''-''\n    }"],"aggregates":{},"master":false,"name":"Live Transaction","table":"livetransaction","linked":false,"selectable":"true"},"PERSPECTIVE_GENERATED_ID_6":{"plugin":"Custom Datagrid","plugin_config":{"columns":{},"editable":false,"scroll_lock":true},"settings":false,"theme":"Material Dark","group_by":[],"split_by":[],"columns":["Rule Name","Score","Order","Remarks"],"filter":[],"sort":[],"expressions":[],"aggregates":{},"master":false,"name":"Decision Details","table":"decisiondetailslive","linked":false}}} '::text WHERE
idashboardresultsetid = 25;