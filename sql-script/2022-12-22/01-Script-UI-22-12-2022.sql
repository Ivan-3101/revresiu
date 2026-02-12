INSERT INTO ui.dashboard (
idashboardid, bactive, bdelete, vcdashboardname, iorder, irowcount) VALUES (
'20'::integer, true::boolean, false::boolean, 'Case Summary'::character varying, '20'::integer, '1'::integer)
 returning idashboardid;

 UPDATE ui.dashboardquery SET
 vcdashboardquery = 'SELECT pdef.name_ as "Workflow Name",
 taskinst.assignee_ as "Username",
 count(hiproc.proc_inst_id_) as "Cases Closed",
 array_length(string_to_array(STRING_AGG(trim(both ''[]'' from hvar.text_), '',''),'',''),1) as "Alerts Closed"
 FROM camunda.act_hi_procinst hiproc
 right join camunda.act_re_procdef pdef on hiproc.proc_def_id_ = pdef.id_
 right join camunda.act_hi_varinst hvar on hvar.proc_inst_id_ = hiproc.proc_inst_id_ and hvar.name_ = ''failedRules''
 left join camunda.act_hi_taskinst taskinst on taskinst.proc_inst_id_ = hiproc.proc_inst_id_  and taskinst.delete_reason_ =''completed''
 and taskinst.id_ = (select id_  from camunda.act_hi_taskinst where proc_inst_id_ = hiproc.proc_inst_id_ and delete_reason_ =''completed''
 					order by end_time_ desc limit 1)
 WHERE hiproc.state_ = ''COMPLETED'' and hvar.text_ != ''''
  and cast(hiproc.end_time_ as date) = :Date
  group by  pdef.name_,  taskinst.assignee_'::text WHERE
 idashboardqueryid = 60;

 UPDATE ui.dashboardquery SET
 vcdashboardquery = 'SELECT pdef.name_ as "Workflow Name",
 task.assignee_ as "Username",
 task.name_ as "User task / status",
 grp.name_ as "Group Name",
 count(distinct CASE
     WHEN DATE_PART(''day'', current_timestamp - hdetail.time_) = 0 THEN task.proc_inst_id_
     ELSE null
 END) as "Day 0",
 count(distinct CASE
     WHEN DATE_PART(''day'', current_timestamp - hdetail.time_) = 1 THEN task.proc_inst_id_
     ELSE null
 END) as "Day 1",
 count(distinct CASE
     WHEN DATE_PART(''day'', current_timestamp - hdetail.time_) = 2 THEN task.proc_inst_id_
     ELSE null
 END) as "Day 2",
 count(distinct CASE
     WHEN DATE_PART(''day'', current_timestamp - hdetail.time_) = 3 THEN task.proc_inst_id_
     ELSE null
 END) as "Day 3",
 count(distinct CASE
     WHEN DATE_PART(''day'', current_timestamp - hdetail.time_) = 4 THEN task.proc_inst_id_
     ELSE null
 END) as "Day 4",
 count(distinct CASE
     WHEN DATE_PART(''day'', current_timestamp - hdetail.time_) = 5 THEN task.proc_inst_id_
     ELSE null
 END) as "Day 5",
 count(distinct CASE
     WHEN DATE_PART(''day'', current_timestamp - hdetail.time_) = 6 THEN task.proc_inst_id_
     ELSE null
 END) as "Day 6",
 count(distinct CASE
     WHEN DATE_PART(''day'', current_timestamp - hdetail.time_) = 7 THEN task.proc_inst_id_
     ELSE null
 END) as "Day 7"
 FROM camunda.act_re_procdef pdef
 right join camunda.act_ru_task task on task.proc_def_id_ = pdef.id_
 inner join camunda.act_hi_detail hdetail on hdetail.proc_inst_id_ = task.proc_inst_id_
 and hdetail.name_ = ''userActivity''
 right join camunda.act_id_membership memb on task.assignee_ = memb.user_id_

 right join camunda.act_hi_identitylink idl on idl.id_ = (SELECT id_ FROM camunda.act_hi_identitylink
 														 where task_id_ = task.id_
 and type_= ''candidate''
 order by timestamp_ desc
  limit 1)
  right join camunda.act_id_group grp on grp.id_ = idl.group_id_
 where task.assignee_ is not null  and DATE_PART(''day'', current_timestamp - hdetail.time_) between 0 and 7 group by
 pdef.name_, task.assignee_, task.name_, grp.name_'::text WHERE
 idashboardqueryid = 59;



INSERT INTO ui.dashboardquery (
idashboardqueryid, bparametersrequired, vcdashboardquery, formattingrequiered, runonanalytics, transposerequired) VALUES (
'61'::integer, false::boolean, 'select name_ as "label", key_ as "value" FROM camunda.act_re_procdef pdef group by key_, name_;'::text, false::boolean, false::boolean, false::boolean)
 returning idashboardqueryid;


 INSERT INTO ui.dashboardquery (
 idashboardqueryid, bparametersrequired, vcfilterparametersjson, vcdashboardquery, formattingrequiered, runonanalytics, transposerequired) VALUES (
 '62'::integer, true::boolean, '{"Date" : null, "CaseType" : null, "Status" : null }'::text, '{
   "Claimed" : "SELECT pdef.name_ as \"Case Type\", task.name_ as \"Stage\", task.assignee_ as \"Claimed By\", CASE WHEN  task.assignee_ is not null THEN hdetail.time_ ELSE null END as \"Claimed On\", task.create_time_ \"Created Date\", CASE WHEN  task.assignee_ is not null THEN ''Claimed'' ELSE ''Unclaimed'' END as \"Status\", payer.text_ as \"Payer\", payee.text_ as \"Payee\", TransactionAmount.double_ as \"Amount\" FROM camunda.act_ru_task task left join camunda.act_re_procdef pdef on pdef.id_ = task.proc_def_id_ left join camunda.act_hi_detail hdetail on hdetail.proc_inst_id_ = task.proc_inst_id_ and hdetail.name_ = ''userActivity'' left join camunda.act_hi_detail payer on payer.proc_inst_id_ = task.proc_inst_id_ and payer.name_ = ''payer'' left join camunda.act_hi_detail payee on payee.proc_inst_id_ = task.proc_inst_id_ and payee.name_ = ''payee'' left join camunda.act_hi_detail TransactionAmount on TransactionAmount.proc_inst_id_ = task.proc_inst_id_ and TransactionAmount.name_ = ''TransactionAmount'' where cast(task.create_time_ as date) = :Date and task.proc_def_id_ in (SELECT id_ FROM camunda.act_re_procdef where key_ = :CaseType ) and task.assignee_ is not null",
   "Unclaimed" : "SELECT pdef.name_ as \"Case Type\", task.name_ as \"Stage\", task.assignee_ as \"Claimed By\", CASE WHEN  task.assignee_ is not null THEN hdetail.time_ ELSE null END as \"Claimed On\", task.create_time_ \"Created Date\", CASE WHEN  task.assignee_ is not null THEN ''Claimed'' ELSE ''Unclaimed'' END as \"Status\", payer.text_ as \"Payer\", payee.text_ as \"Payee\", TransactionAmount.double_ as \"Amount\" FROM camunda.act_ru_task task left join camunda.act_re_procdef pdef on pdef.id_ = task.proc_def_id_ left join camunda.act_hi_detail hdetail on hdetail.proc_inst_id_ = task.proc_inst_id_ and hdetail.name_ = ''userActivity'' left join camunda.act_hi_detail payer on payer.proc_inst_id_ = task.proc_inst_id_ and payer.name_ = ''payer'' left join camunda.act_hi_detail payee on payee.proc_inst_id_ = task.proc_inst_id_ and payee.name_ = ''payee'' left join camunda.act_hi_detail TransactionAmount on TransactionAmount.proc_inst_id_ = task.proc_inst_id_ and TransactionAmount.name_ = ''TransactionAmount'' where cast(task.create_time_ as date) = :Date and task.proc_def_id_ in (SELECT id_ FROM camunda.act_re_procdef where key_ = :CaseType ) and task.assignee_ is null",
   "All" : "SELECT pdef.name_ as \"Case Type\", task.name_ as \"Stage\", task.assignee_ as \"Claimed By\", CASE WHEN  task.assignee_ is not null THEN hdetail.time_ ELSE null END as \"Claimed On\", task.create_time_ \"Created Date\", CASE WHEN  task.assignee_ is not null THEN ''Claimed'' ELSE ''Unclaimed'' END as \"Status\", payer.text_ as \"Payer\", payee.text_ as \"Payee\", TransactionAmount.double_ as \"Amount\" FROM camunda.act_ru_task task left join camunda.act_re_procdef pdef on pdef.id_ = task.proc_def_id_ left join camunda.act_hi_detail hdetail on hdetail.proc_inst_id_ = task.proc_inst_id_ and hdetail.name_ = ''userActivity'' left join camunda.act_hi_detail payer on payer.proc_inst_id_ = task.proc_inst_id_ and payer.name_ = ''payer'' left join camunda.act_hi_detail payee on payee.proc_inst_id_ = task.proc_inst_id_ and payee.name_ = ''payee'' left join camunda.act_hi_detail TransactionAmount on TransactionAmount.proc_inst_id_ = task.proc_inst_id_ and TransactionAmount.name_ = ''TransactionAmount'' where cast(task.create_time_ as date) = :Date and task.proc_def_id_ in (SELECT id_ FROM camunda.act_re_procdef where key_ = :CaseType ) "
 }'::text, false::boolean, false::boolean, false::boolean)
  returning idashboardqueryid;


  INSERT INTO ui.dashboardquery (
  idashboardqueryid, bparametersrequired, vcdashboardquery, formattingrequiered, runonanalytics, transposerequired) VALUES (
  '63'::integer, false::boolean, 'SELECT X.* FROM   (VALUES (''All'', ''All''),(''Claimed'', ''Claimed''), (''Unclaimed'', ''Unclaimed'')) AS X ("label", "value")'::text, false::boolean, false::boolean, false::boolean)
   returning idashboardqueryid;


   INSERT INTO ui.dashboardfilters (
   idashboardfilterid, ifilterorder, vcdashboardfiltername, idashboardid, vcdashboardfiltertype, idashboardqueryidforoptions, vcdashboardfilterdisplayname) VALUES (
   '43'::integer, '0'::integer, 'CaseType'::character varying, '20'::integer, 'Select'::character varying, '61'::integer, 'Case Type'::character varying)
    returning idashboardfilterid;


    INSERT INTO ui.dashboardfilters (
    idashboardfilterid, ifilterorder, vcdashboardfiltername, idashboardid, vcdashboardfiltertype, idashboardqueryidfordefaultvalue, vcdashboardfilterdisplayname) VALUES (
    '44'::integer, '1'::integer, 'Date'::character varying, '20'::integer, 'DatePicker'::character varying, '1'::integer, 'Date'::character varying)
     returning idashboardfilterid;

     INSERT INTO ui.dashboardfilters (
     idashboardfilterid, ifilterorder, vcdashboardfiltername, idashboardid, vcdashboardfiltertype, idashboardqueryidforoptions, vcdashboardfilterdisplayname) VALUES (
     '45'::integer, '2'::integer, 'Status'::character varying, '20'::integer, 'Select'::character varying, '63'::integer, 'Status'::character varying)
      returning idashboardfilterid;


      INSERT INTO ui.dashboardqueryparameters (
      idashboardparameterid, vcparametername, vcparametertype, idashboardqueryid, iorder) VALUES (
      '99'::integer, 'Status'::character varying, 'JsonPath'::character varying, '62'::integer, '0'::integer)
       returning idashboardparameterid;

       INSERT INTO ui.dashboardqueryparameters (
       idashboardparameterid, vcparametername, vcparametertype, idashboardqueryid) VALUES (
       '100'::integer, 'Date'::character varying, 'Date'::character varying, '62'::integer)
        returning idashboardparameterid;


        INSERT INTO ui.dashboardqueryparameters (
        idashboardparameterid, vcparametername, vcparametertype, idashboardqueryid) VALUES (
        '101'::integer, 'CaseType'::character varying, 'String'::character varying, '62'::integer)
         returning idashboardparameterid;

         UPDATE ui.dashboardquery SET
         vcdashboardquery = 'SELECT ''All Cases'' AS "label", ''All'' AS "value" union all
         (select name_ as "label", key_ as "value" FROM camunda.act_re_procdef pdef group by key_, name_ order by name_ )'::text WHERE
         idashboardqueryid = 61;


         UPDATE ui.dashboardquery SET
         vcdashboardquery = '{
           "All" : {
             "Claimed" : "SELECT pdef.name_ as \"Case Type\", task.name_ as \"Stage\", task.assignee_ as \"Claimed By\", CASE WHEN  task.assignee_ is not null THEN hdetail.time_ ELSE null END as \"Claimed On\", task.create_time_ \"Created Date\", CASE WHEN  task.assignee_ is not null THEN ''Claimed'' ELSE ''Unclaimed'' END as \"Status\", payer.text_ as \"Payer\", payee.text_ as \"Payee\", TransactionAmount.double_ as \"Amount\" FROM camunda.act_ru_task task left join camunda.act_re_procdef pdef on pdef.id_ = task.proc_def_id_ left join camunda.act_hi_detail hdetail on hdetail.proc_inst_id_ = task.proc_inst_id_ and hdetail.name_ = ''userActivity'' left join camunda.act_hi_detail payer on payer.proc_inst_id_ = task.proc_inst_id_ and payer.name_ = ''payer'' left join camunda.act_hi_detail payee on payee.proc_inst_id_ = task.proc_inst_id_ and payee.name_ = ''payee'' left join camunda.act_hi_detail TransactionAmount on TransactionAmount.proc_inst_id_ = task.proc_inst_id_ and TransactionAmount.name_ = ''TransactionAmount'' where cast(task.create_time_ as date) = :Date   and task.assignee_ is not null",
             "Unclaimed" : "SELECT pdef.name_ as \"Case Type\", task.name_ as \"Stage\", task.assignee_ as \"Claimed By\", CASE WHEN  task.assignee_ is not null THEN hdetail.time_ ELSE null END as \"Claimed On\", task.create_time_ \"Created Date\", CASE WHEN  task.assignee_ is not null THEN ''Claimed'' ELSE ''Unclaimed'' END as \"Status\", payer.text_ as \"Payer\", payee.text_ as \"Payee\", TransactionAmount.double_ as \"Amount\" FROM camunda.act_ru_task task left join camunda.act_re_procdef pdef on pdef.id_ = task.proc_def_id_ left join camunda.act_hi_detail hdetail on hdetail.proc_inst_id_ = task.proc_inst_id_ and hdetail.name_ = ''userActivity'' left join camunda.act_hi_detail payer on payer.proc_inst_id_ = task.proc_inst_id_ and payer.name_ = ''payer'' left join camunda.act_hi_detail payee on payee.proc_inst_id_ = task.proc_inst_id_ and payee.name_ = ''payee'' left join camunda.act_hi_detail TransactionAmount on TransactionAmount.proc_inst_id_ = task.proc_inst_id_ and TransactionAmount.name_ = ''TransactionAmount'' where cast(task.create_time_ as date) = :Date  and task.assignee_ is null",
             "All" : "SELECT pdef.name_ as \"Case Type\", task.name_ as \"Stage\", task.assignee_ as \"Claimed By\", CASE WHEN  task.assignee_ is not null THEN hdetail.time_ ELSE null END as \"Claimed On\", task.create_time_ \"Created Date\", CASE WHEN  task.assignee_ is not null THEN ''Claimed'' ELSE ''Unclaimed'' END as \"Status\", payer.text_ as \"Payer\", payee.text_ as \"Payee\", TransactionAmount.double_ as \"Amount\" FROM camunda.act_ru_task task left join camunda.act_re_procdef pdef on pdef.id_ = task.proc_def_id_ left join camunda.act_hi_detail hdetail on hdetail.proc_inst_id_ = task.proc_inst_id_ and hdetail.name_ = ''userActivity'' left join camunda.act_hi_detail payer on payer.proc_inst_id_ = task.proc_inst_id_ and payer.name_ = ''payer'' left join camunda.act_hi_detail payee on payee.proc_inst_id_ = task.proc_inst_id_ and payee.name_ = ''payee'' left join camunda.act_hi_detail TransactionAmount on TransactionAmount.proc_inst_id_ = task.proc_inst_id_ and TransactionAmount.name_ = ''TransactionAmount'' where cast(task.create_time_ as date) = :Date "
           },
           "Other":{
             "Claimed" : "SELECT pdef.name_ as \"Case Type\", task.name_ as \"Stage\", task.assignee_ as \"Claimed By\", CASE WHEN  task.assignee_ is not null THEN hdetail.time_ ELSE null END as \"Claimed On\", task.create_time_ \"Created Date\", CASE WHEN  task.assignee_ is not null THEN ''Claimed'' ELSE ''Unclaimed'' END as \"Status\", payer.text_ as \"Payer\", payee.text_ as \"Payee\", TransactionAmount.double_ as \"Amount\" FROM camunda.act_ru_task task left join camunda.act_re_procdef pdef on pdef.id_ = task.proc_def_id_ left join camunda.act_hi_detail hdetail on hdetail.proc_inst_id_ = task.proc_inst_id_ and hdetail.name_ = ''userActivity'' left join camunda.act_hi_detail payer on payer.proc_inst_id_ = task.proc_inst_id_ and payer.name_ = ''payer'' left join camunda.act_hi_detail payee on payee.proc_inst_id_ = task.proc_inst_id_ and payee.name_ = ''payee'' left join camunda.act_hi_detail TransactionAmount on TransactionAmount.proc_inst_id_ = task.proc_inst_id_ and TransactionAmount.name_ = ''TransactionAmount'' where cast(task.create_time_ as date) = :Date and task.proc_def_id_ in (SELECT id_ FROM camunda.act_re_procdef where key_ = :CaseType ) and task.assignee_ is not null",
             "Unclaimed" : "SELECT pdef.name_ as \"Case Type\", task.name_ as \"Stage\", task.assignee_ as \"Claimed By\", CASE WHEN  task.assignee_ is not null THEN hdetail.time_ ELSE null END as \"Claimed On\", task.create_time_ \"Created Date\", CASE WHEN  task.assignee_ is not null THEN ''Claimed'' ELSE ''Unclaimed'' END as \"Status\", payer.text_ as \"Payer\", payee.text_ as \"Payee\", TransactionAmount.double_ as \"Amount\" FROM camunda.act_ru_task task left join camunda.act_re_procdef pdef on pdef.id_ = task.proc_def_id_ left join camunda.act_hi_detail hdetail on hdetail.proc_inst_id_ = task.proc_inst_id_ and hdetail.name_ = ''userActivity'' left join camunda.act_hi_detail payer on payer.proc_inst_id_ = task.proc_inst_id_ and payer.name_ = ''payer'' left join camunda.act_hi_detail payee on payee.proc_inst_id_ = task.proc_inst_id_ and payee.name_ = ''payee'' left join camunda.act_hi_detail TransactionAmount on TransactionAmount.proc_inst_id_ = task.proc_inst_id_ and TransactionAmount.name_ = ''TransactionAmount'' where cast(task.create_time_ as date) = :Date and task.proc_def_id_ in (SELECT id_ FROM camunda.act_re_procdef where key_ = :CaseType ) and task.assignee_ is null",
             "All" : "SELECT pdef.name_ as \"Case Type\", task.name_ as \"Stage\", task.assignee_ as \"Claimed By\", CASE WHEN  task.assignee_ is not null THEN hdetail.time_ ELSE null END as \"Claimed On\", task.create_time_ \"Created Date\", CASE WHEN  task.assignee_ is not null THEN ''Claimed'' ELSE ''Unclaimed'' END as \"Status\", payer.text_ as \"Payer\", payee.text_ as \"Payee\", TransactionAmount.double_ as \"Amount\" FROM camunda.act_ru_task task left join camunda.act_re_procdef pdef on pdef.id_ = task.proc_def_id_ left join camunda.act_hi_detail hdetail on hdetail.proc_inst_id_ = task.proc_inst_id_ and hdetail.name_ = ''userActivity'' left join camunda.act_hi_detail payer on payer.proc_inst_id_ = task.proc_inst_id_ and payer.name_ = ''payer'' left join camunda.act_hi_detail payee on payee.proc_inst_id_ = task.proc_inst_id_ and payee.name_ = ''payee'' left join camunda.act_hi_detail TransactionAmount on TransactionAmount.proc_inst_id_ = task.proc_inst_id_ and TransactionAmount.name_ = ''TransactionAmount'' where cast(task.create_time_ as date) = :Date and task.proc_def_id_ in (SELECT id_ FROM camunda.act_re_procdef where key_ = :CaseType ) "
           }
         }
         '::text WHERE
         idashboardqueryid = 62;


         UPDATE ui.dashboardqueryparameters SET
         iorder = '0'::integer WHERE
         idashboardparameterid = 101;


         UPDATE ui.dashboardqueryparameters SET
         iorder = '1'::integer WHERE
         idashboardparameterid = 99;




         INSERT INTO ui.dashboardresultset (
         idashboardresultsetid, vcdashboardresultsetlayout, vcdashboardresultsetname, idashboardqueryid, idashboardid, vcdashboardresultsetschema, irowno) VALUES (
         '29'::integer, '{
           "sizes": [
             1,
             0
           ],
           "detail": {
             "main": null
           },
           "mode": "globalFilters",
           "master": {
             "widgets": [
               "PERSPECTIVE_GENERATED_ID_1"
             ],
             "sizes": [
               1
             ]
           },
           "viewers": {
             "PERSPECTIVE_GENERATED_ID_1": {
               "plugin": "Custom Datagrid",
               "plugin_config": {
                 "columns": {},
                 "editable": false,
                 "scroll_lock": true
               },
               "settings": false,
               "theme": "Material Dark",
               "group_by": [],
               "split_by": [],
               "columns": [
                 "Case ID",
                 "Case Type",
                 "Stage",
                 "Alert",
                 "Payer",
                 "Amount",
                 "Payee",
                 "Claimed By",
                 "Claimed On",
                 "Created Date",
                 "Status"
               ],
               "filter": [],
               "sort": [],
               "expressions": [],
               "aggregates": {},
               "master": true,
               "name": "Case Summary",
               "table": "casesummary",
               "linked": false,
               "selectable": ""
             }
           }
         }'::text, 'casesummary'::character varying, '62'::integer, '20'::integer, '{
           "Case ID": "integer",
           "Case Type": "string",
           "Stage": "string",
           "Alert":  "string",
           "Payer" :  "string",
           "Amount":  "string",
           "Payee": "string",
           "Claimed By": "string",
           "Claimed On":  "datetime",
           "Created Date":  "datetime",
           "Status": "string"
         }'::text, '1'::integer)
          returning idashboardresultsetid;




          UPDATE ui.dashboardquery SET
          vcdashboardquery = '{
            "All" : {
              "Claimed" : "SELECT pdef.name_ as \"Case Type\", task.name_ as \"Stage\", task.assignee_ as \"Claimed By\", CASE WHEN  task.assignee_ is not null THEN hdetail.time_ ELSE null END as \"Claimed On\", task.create_time_ \"Created Date\", CASE WHEN  task.assignee_ is not null THEN ''Claimed'' ELSE ''Unclaimed'' END as \"Status\", payer.text_ as \"Payer\", payee.text_ as \"Payee\", TransactionAmount.double_ as \"Amount\", TicketID.long_ as \"Case ID\", Alert.text_ as \"Alert\" FROM camunda.act_ru_task task left join camunda.act_re_procdef pdef on pdef.id_ = task.proc_def_id_ left join camunda.act_hi_detail hdetail on hdetail.proc_inst_id_ = task.proc_inst_id_ and hdetail.name_ = ''userActivity'' left join camunda.act_hi_detail payer on payer.proc_inst_id_ = task.proc_inst_id_ and payer.name_ = ''payer'' left join camunda.act_hi_detail payee on payee.proc_inst_id_ = task.proc_inst_id_ and payee.name_ = ''payee'' left join camunda.act_hi_detail TransactionAmount on TransactionAmount.proc_inst_id_ = task.proc_inst_id_ and TransactionAmount.name_ = ''TransactionAmount'' left join camunda.act_hi_detail TicketID on TicketID.proc_inst_id_ = task.proc_inst_id_ and TicketID.name_ = ''TickeetID'' left join camunda.act_hi_detail Alert on Alert.proc_inst_id_ = task.proc_inst_id_ and Alert.name_ = ''Alert'' where cast(task.create_time_ as date) = :Date   and task.assignee_ is not null",
              "Unclaimed" : "SELECT pdef.name_ as \"Case Type\", task.name_ as \"Stage\", task.assignee_ as \"Claimed By\", CASE WHEN  task.assignee_ is not null THEN hdetail.time_ ELSE null END as \"Claimed On\", task.create_time_ \"Created Date\", CASE WHEN  task.assignee_ is not null THEN ''Claimed'' ELSE ''Unclaimed'' END as \"Status\", payer.text_ as \"Payer\", payee.text_ as \"Payee\", TransactionAmount.double_ as \"Amount\", TicketID.long_ as \"Case ID\", Alert.text_ as \"Alert\" FROM camunda.act_ru_task task left join camunda.act_re_procdef pdef on pdef.id_ = task.proc_def_id_ left join camunda.act_hi_detail hdetail on hdetail.proc_inst_id_ = task.proc_inst_id_ and hdetail.name_ = ''userActivity'' left join camunda.act_hi_detail payer on payer.proc_inst_id_ = task.proc_inst_id_ and payer.name_ = ''payer'' left join camunda.act_hi_detail payee on payee.proc_inst_id_ = task.proc_inst_id_ and payee.name_ = ''payee'' left join camunda.act_hi_detail TransactionAmount on TransactionAmount.proc_inst_id_ = task.proc_inst_id_ and TransactionAmount.name_ = ''TransactionAmount'' left join camunda.act_hi_detail TicketID on TicketID.proc_inst_id_ = task.proc_inst_id_ and TicketID.name_ = ''TickeetID'' left join camunda.act_hi_detail Alert on Alert.proc_inst_id_ = task.proc_inst_id_ and Alert.name_ = ''Alert'' where cast(task.create_time_ as date) = :Date  and task.assignee_ is null",
              "All" : "SELECT pdef.name_ as \"Case Type\", task.name_ as \"Stage\", task.assignee_ as \"Claimed By\", CASE WHEN  task.assignee_ is not null THEN hdetail.time_ ELSE null END as \"Claimed On\", task.create_time_ \"Created Date\", CASE WHEN  task.assignee_ is not null THEN ''Claimed'' ELSE ''Unclaimed'' END as \"Status\", payer.text_ as \"Payer\", payee.text_ as \"Payee\", TransactionAmount.double_ as \"Amount\", TicketID.long_ as \"Case ID\", Alert.text_ as \"Alert\" FROM camunda.act_ru_task task left join camunda.act_re_procdef pdef on pdef.id_ = task.proc_def_id_ left join camunda.act_hi_detail hdetail on hdetail.proc_inst_id_ = task.proc_inst_id_ and hdetail.name_ = ''userActivity'' left join camunda.act_hi_detail payer on payer.proc_inst_id_ = task.proc_inst_id_ and payer.name_ = ''payer'' left join camunda.act_hi_detail payee on payee.proc_inst_id_ = task.proc_inst_id_ and payee.name_ = ''payee'' left join camunda.act_hi_detail TransactionAmount on TransactionAmount.proc_inst_id_ = task.proc_inst_id_ and TransactionAmount.name_ = ''TransactionAmount'' left join camunda.act_hi_detail TicketID on TicketID.proc_inst_id_ = task.proc_inst_id_ and TicketID.name_ = ''TickeetID'' left join camunda.act_hi_detail Alert on Alert.proc_inst_id_ = task.proc_inst_id_ and Alert.name_ = ''Alert'' where cast(task.create_time_ as date) = :Date "
            },
            "Other":{
              "Claimed" : "SELECT pdef.name_ as \"Case Type\", task.name_ as \"Stage\", task.assignee_ as \"Claimed By\", CASE WHEN  task.assignee_ is not null THEN hdetail.time_ ELSE null END as \"Claimed On\", task.create_time_ \"Created Date\", CASE WHEN  task.assignee_ is not null THEN ''Claimed'' ELSE ''Unclaimed'' END as \"Status\", payer.text_ as \"Payer\", payee.text_ as \"Payee\", TransactionAmount.double_ as \"Amount\", TicketID.long_ as \"Case ID\", Alert.text_ as \"Alert\" FROM camunda.act_ru_task task left join camunda.act_re_procdef pdef on pdef.id_ = task.proc_def_id_ left join camunda.act_hi_detail hdetail on hdetail.proc_inst_id_ = task.proc_inst_id_ and hdetail.name_ = ''userActivity'' left join camunda.act_hi_detail payer on payer.proc_inst_id_ = task.proc_inst_id_ and payer.name_ = ''payer'' left join camunda.act_hi_detail payee on payee.proc_inst_id_ = task.proc_inst_id_ and payee.name_ = ''payee'' left join camunda.act_hi_detail TransactionAmount on TransactionAmount.proc_inst_id_ = task.proc_inst_id_ and TransactionAmount.name_ = ''TransactionAmount'' left join camunda.act_hi_detail TicketID on TicketID.proc_inst_id_ = task.proc_inst_id_ and TicketID.name_ = ''TickeetID'' left join camunda.act_hi_detail Alert on Alert.proc_inst_id_ = task.proc_inst_id_ and Alert.name_ = ''Alert'' where cast(task.create_time_ as date) = :Date and task.proc_def_id_ in (SELECT id_ FROM camunda.act_re_procdef where key_ = :CaseType ) and task.assignee_ is not null",
              "Unclaimed" : "SELECT pdef.name_ as \"Case Type\", task.name_ as \"Stage\", task.assignee_ as \"Claimed By\", CASE WHEN  task.assignee_ is not null THEN hdetail.time_ ELSE null END as \"Claimed On\", task.create_time_ \"Created Date\", CASE WHEN  task.assignee_ is not null THEN ''Claimed'' ELSE ''Unclaimed'' END as \"Status\", payer.text_ as \"Payer\", payee.text_ as \"Payee\", TransactionAmount.double_ as \"Amount\", TicketID.long_ as \"Case ID\", Alert.text_ as \"Alert\" FROM camunda.act_ru_task task left join camunda.act_re_procdef pdef on pdef.id_ = task.proc_def_id_ left join camunda.act_hi_detail hdetail on hdetail.proc_inst_id_ = task.proc_inst_id_ and hdetail.name_ = ''userActivity'' left join camunda.act_hi_detail payer on payer.proc_inst_id_ = task.proc_inst_id_ and payer.name_ = ''payer'' left join camunda.act_hi_detail payee on payee.proc_inst_id_ = task.proc_inst_id_ and payee.name_ = ''payee'' left join camunda.act_hi_detail TransactionAmount on TransactionAmount.proc_inst_id_ = task.proc_inst_id_ and TransactionAmount.name_ = ''TransactionAmount'' left join camunda.act_hi_detail TicketID on TicketID.proc_inst_id_ = task.proc_inst_id_ and TicketID.name_ = ''TickeetID'' left join camunda.act_hi_detail Alert on Alert.proc_inst_id_ = task.proc_inst_id_ and Alert.name_ = ''Alert'' where cast(task.create_time_ as date) = :Date and task.proc_def_id_ in (SELECT id_ FROM camunda.act_re_procdef where key_ = :CaseType ) and task.assignee_ is null",
              "All" : "SELECT pdef.name_ as \"Case Type\", task.name_ as \"Stage\", task.assignee_ as \"Claimed By\", CASE WHEN  task.assignee_ is not null THEN hdetail.time_ ELSE null END as \"Claimed On\", task.create_time_ \"Created Date\", CASE WHEN  task.assignee_ is not null THEN ''Claimed'' ELSE ''Unclaimed'' END as \"Status\", payer.text_ as \"Payer\", payee.text_ as \"Payee\", TransactionAmount.double_ as \"Amount\", TicketID.long_ as \"Case ID\", Alert.text_ as \"Alert\" FROM camunda.act_ru_task task left join camunda.act_re_procdef pdef on pdef.id_ = task.proc_def_id_ left join camunda.act_hi_detail hdetail on hdetail.proc_inst_id_ = task.proc_inst_id_ and hdetail.name_ = ''userActivity'' left join camunda.act_hi_detail payer on payer.proc_inst_id_ = task.proc_inst_id_ and payer.name_ = ''payer'' left join camunda.act_hi_detail payee on payee.proc_inst_id_ = task.proc_inst_id_ and payee.name_ = ''payee'' left join camunda.act_hi_detail TransactionAmount on TransactionAmount.proc_inst_id_ = task.proc_inst_id_ and TransactionAmount.name_ = ''TransactionAmount'' left join camunda.act_hi_detail TicketID on TicketID.proc_inst_id_ = task.proc_inst_id_ and TicketID.name_ = ''TickeetID'' left join camunda.act_hi_detail Alert on Alert.proc_inst_id_ = task.proc_inst_id_ and Alert.name_ = ''Alert'' where cast(task.create_time_ as date) = :Date and task.proc_def_id_ in (SELECT id_ FROM camunda.act_re_procdef where key_ = :CaseType ) "
            }
          }'::text WHERE
          idashboardqueryid = 62;


          UPDATE ui.dashboardqueryparameters SET
          vcparametertype = 'JsonPath'::character varying WHERE
          idashboardparameterid = 101;


INSERT INTO ui.panelaccessmap (panelaccessmap, panelid, groupid, workflowid) VALUES (101, 1, 1029, 4);
INSERT INTO ui.panelaccessmap (panelaccessmap, panelid, groupid, workflowid) VALUES (102, 2, 1029, 4);
INSERT INTO ui.panelaccessmap (panelaccessmap, panelid, groupid, workflowid) VALUES (103, 3, 1029, 4);
INSERT INTO ui.panelaccessmap (panelaccessmap, panelid, groupid, workflowid) VALUES (104, 4, 1029, 4);
INSERT INTO ui.panelaccessmap (panelaccessmap, panelid, groupid, workflowid) VALUES (105, 5, 1029, 4);
