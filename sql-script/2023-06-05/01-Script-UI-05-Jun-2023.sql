ALTER TABLE ui.webuser
    ALTER COLUMN vcusername TYPE character varying(100) COLLATE pg_catalog."default";

	ALTER TABLE ui.webuseraudit
    ALTER COLUMN vcusername TYPE character varying(100) COLLATE pg_catalog."default";


ALTER TABLE IF EXISTS ui.webuseraudit
    ALTER COLUMN vcpassword DROP NOT NULL;

	ALTER TABLE IF EXISTS ui.webuser
    ALTER COLUMN vcpassword DROP NOT NULL;


alter table if exists ui.activelogintokens
       add column dtexpirydatetime timestamp(6) with time zone;


alter table if exists ui.activelogintokens
       add column refreshtoken TEXT;



INSERT INTO ui.dashboard (idashboardid, bactive, bdelete, vcdashboardname, iorder, irowcount) VALUES (22, true, false, 'Closed Cases Report', 22, 1);

INSERT INTO ui.dashboardquery (idashboardqueryid, bparametersrequired, vcfilterparametersjson, vcdashboardquery, formattingrequiered, runonanalytics, transposerequired) VALUES (71, false, NULL, 'SELECT X.* FROM   (VALUES (''Closed On'', ''ClosedOn''),(''Created On'', ''CreatedOn'')) AS X ("label", "value")', NULL, NULL, NULL);
INSERT INTO ui.dashboardquery (idashboardqueryid, bparametersrequired, vcfilterparametersjson, vcdashboardquery, formattingrequiered, runonanalytics, transposerequired) VALUES (72, false, NULL, 'SELECT (NOW()) as "startdate", (NOW() - interval ''2 day'') as "enddate";', NULL, NULL, NULL);
INSERT INTO ui.dashboardquery (idashboardqueryid, bparametersrequired, vcfilterparametersjson, vcdashboardquery, formattingrequiered, runonanalytics, transposerequired) VALUES (73, true, '{"Basis":null,"DateRange":null,"CaseType":null}', '{
    "All" :{
      "ClosedOn":"select pdef.name_ as \"Case Type\", TicketID.long_ as \"Case ID\", task.assignee_ as \"Closed By\", pinst.end_time_ as \"Closed On\", Alert.text_ as \"Alert\", pinst.start_time_ as \"Ticket Created Date\", Payer.text_ as \"Payer\", Payee.text_ as \"Payee\", Amount.double_/100 as \"Amount\" from camunda.act_re_procdef pdef inner join camunda.act_hi_procinst pinst on pinst.proc_def_id_ = pdef.id_ and pinst.state_=''COMPLETED'' inner join camunda.act_hi_taskinst task on task.id_ = (select id_ from camunda.act_hi_taskinst where proc_inst_id_ = pinst.proc_inst_id_ order by end_time_ desc limit 1) left outer join camunda.act_hi_detail TicketID on TicketID.proc_inst_id_ = pinst.proc_inst_id_ and TicketID.name_=''TicketID'' left outer join camunda.act_hi_detail Alert on Alert.id_ = (select id_ from camunda.act_hi_detail  where proc_inst_id_ = pinst.proc_inst_id_ and name_=''Alert'' order by time_ desc limit 1) left outer join camunda.act_hi_detail Payer on Payer.proc_inst_id_ = pinst.proc_inst_id_ and Payer.name_=''payer'' left outer join camunda.act_hi_detail Payee on Payee.proc_inst_id_ = pinst.proc_inst_id_ and Payee.name_=''payee'' left outer join camunda.act_hi_detail Amount on Amount.proc_inst_id_ = pinst.proc_inst_id_ and Amount.name_=''TransactionAmount'' where cast(pinst.end_time_ as date) between cast(:StartDate as date) and cast(:EndDate as date)-1 ",
      "CreatedOn":"select pdef.name_ as \"Case Type\", TicketID.long_ as \"Case ID\", task.assignee_ as \"Closed By\", pinst.end_time_ as \"Closed On\", Alert.text_ as \"Alert\", pinst.start_time_ as \"Ticket Created Date\", Payer.text_ as \"Payer\", Payee.text_ as \"Payee\", Amount.double_/100 as \"Amount\" from camunda.act_re_procdef pdef inner join camunda.act_hi_procinst pinst on pinst.proc_def_id_ = pdef.id_ and pinst.state_=''COMPLETED'' inner join camunda.act_hi_taskinst task on task.id_ = (select id_ from camunda.act_hi_taskinst where proc_inst_id_ = pinst.proc_inst_id_ order by end_time_ desc limit 1) left outer join camunda.act_hi_detail TicketID on TicketID.proc_inst_id_ = pinst.proc_inst_id_ and TicketID.name_=''TicketID'' left outer join camunda.act_hi_detail Alert on Alert.id_ = (select id_ from camunda.act_hi_detail  where proc_inst_id_ = pinst.proc_inst_id_ and name_=''Alert'' order by time_ desc limit 1) left outer join camunda.act_hi_detail Payer on Payer.proc_inst_id_ = pinst.proc_inst_id_ and Payer.name_=''payer'' left outer join camunda.act_hi_detail Payee on Payee.proc_inst_id_ = pinst.proc_inst_id_ and Payee.name_=''payee'' left outer join camunda.act_hi_detail Amount on Amount.proc_inst_id_ = pinst.proc_inst_id_ and Amount.name_=''TransactionAmount'' where cast(pinst.start_time_ as date) between cast(:StartDate as date) and cast(:EndDate as date)-1 "
    },
    "Other":{
      "ClosedOn":"select pdef.name_ as \"Case Type\", TicketID.long_ as \"Case ID\", task.assignee_ as \"Closed By\", pinst.end_time_ as \"Closed On\", Alert.text_ as \"Alert\", pinst.start_time_ as \"Ticket Created Date\", Payer.text_ as \"Payer\", Payee.text_ as \"Payee\", Amount.double_/100 as \"Amount\" from camunda.act_re_procdef pdef inner join camunda.act_hi_procinst pinst on pinst.proc_def_id_ = pdef.id_ and pinst.state_=''COMPLETED'' inner join camunda.act_hi_taskinst task on task.id_ = (select id_ from camunda.act_hi_taskinst where proc_inst_id_ = pinst.proc_inst_id_ order by end_time_ desc limit 1) left outer join camunda.act_hi_detail TicketID on TicketID.proc_inst_id_ = pinst.proc_inst_id_ and TicketID.name_=''TicketID'' left outer join camunda.act_hi_detail Alert on Alert.id_ = (select id_ from camunda.act_hi_detail  where proc_inst_id_ = pinst.proc_inst_id_ and name_=''Alert'' order by time_ desc limit 1) left outer join camunda.act_hi_detail Payer on Payer.proc_inst_id_ = pinst.proc_inst_id_ and Payer.name_=''payer'' left outer join camunda.act_hi_detail Payee on Payee.proc_inst_id_ = pinst.proc_inst_id_ and Payee.name_=''payee'' left outer join camunda.act_hi_detail Amount on Amount.proc_inst_id_ = pinst.proc_inst_id_ and Amount.name_=''TransactionAmount'' where cast(pinst.end_time_ as date) between cast(:StartDate as date) and cast(:EndDate as date)-1 and pdef.key_ = :CaseType",
      "CreatedOn":"select pdef.name_ as \"Case Type\", TicketID.long_ as \"Case ID\", task.assignee_ as \"Closed By\", pinst.end_time_ as \"Closed On\", Alert.text_ as \"Alert\", pinst.start_time_ as \"Ticket Created Date\", Payer.text_ as \"Payer\", Payee.text_ as \"Payee\", Amount.double_/100 as \"Amount\" from camunda.act_re_procdef pdef inner join camunda.act_hi_procinst pinst on pinst.proc_def_id_ = pdef.id_ and pinst.state_=''COMPLETED'' inner join camunda.act_hi_taskinst task on task.id_ = (select id_ from camunda.act_hi_taskinst where proc_inst_id_ = pinst.proc_inst_id_ order by end_time_ desc limit 1) left outer join camunda.act_hi_detail TicketID on TicketID.proc_inst_id_ = pinst.proc_inst_id_ and TicketID.name_=''TicketID'' left outer join camunda.act_hi_detail Alert on Alert.id_ = (select id_ from camunda.act_hi_detail  where proc_inst_id_ = pinst.proc_inst_id_ and name_=''Alert'' order by time_ desc limit 1) left outer join camunda.act_hi_detail Payer on Payer.proc_inst_id_ = pinst.proc_inst_id_ and Payer.name_=''payer'' left outer join camunda.act_hi_detail Payee on Payee.proc_inst_id_ = pinst.proc_inst_id_ and Payee.name_=''payee'' left outer join camunda.act_hi_detail Amount on Amount.proc_inst_id_ = pinst.proc_inst_id_ and Amount.name_=''TransactionAmount'' where cast(pinst.start_time_ as date) between cast(:StartDate as date) and cast(:EndDate as date)-1 and pdef.key_ = :CaseType"
    }
  }', false, false, false);



INSERT INTO ui.dashboardfilters (idashboardfilterid, ifilterorder, vcdashboardfiltername, idashboardid, vcdashboardfiltertype, idashboardqueryidfordefaultvalue, idashboardqueryidforoptions, vcdashboardfilterdisplayname) VALUES (50, 0, 'CaseType', 22, 'Select', NULL, 61, 'Case Type');
INSERT INTO ui.dashboardfilters (idashboardfilterid, ifilterorder, vcdashboardfiltername, idashboardid, vcdashboardfiltertype, idashboardqueryidfordefaultvalue, idashboardqueryidforoptions, vcdashboardfilterdisplayname) VALUES (51, 1, 'Basis', 22, 'Select', NULL, 71, 'Basis');
INSERT INTO ui.dashboardfilters (idashboardfilterid, ifilterorder, vcdashboardfiltername, idashboardid, vcdashboardfiltertype, idashboardqueryidfordefaultvalue, idashboardqueryidforoptions, vcdashboardfilterdisplayname) VALUES (52, 2, 'DateRange', 22, 'DateRangePicker', 72, NULL, 'Date Range');

INSERT INTO ui.dashboardqueryparameters (idashboardparameterid, vcparametername, vcparametertype, idashboardqueryid, iorder) VALUES (113, 'CaseType', 'JsonPath', 73, 0);
INSERT INTO ui.dashboardqueryparameters (idashboardparameterid, vcparametername, vcparametertype, idashboardqueryid, iorder) VALUES (114, 'Basis', 'JsonPath', 73, 1);
INSERT INTO ui.dashboardqueryparameters (idashboardparameterid, vcparametername, vcparametertype, idashboardqueryid, iorder) VALUES (115, 'DateRange', 'DateRange', 73, 2);

INSERT INTO ui.dashboardresultset (idashboardresultsetid, iresultsetorder, vcdashboardresultsetcolumnjson, vcdashboardresultsetlayout, vcdashboardresultsetname, idashboardqueryid, idashboardid, vcdashboardresultsetschema, icolsize, irowno, dtlastupdatedtimestamp, iuserid) VALUES (33, NULL, NULL, '{
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
          "Alert",
          "Payer",
          "Amount",
          "Payee",
          "Closed By",
          "Closed On",
          "Ticket Created Date"
        ],
        "filter": [],
        "sort": [],
        "expressions": [],
        "aggregates": {},
        "master": true,
        "name": "Closed cases report",
        "table": "closedcases",
        "linked": false,
        "selectable": ""
      }
    }
  }', 'closedcases', 73, 22, '{
"Case ID":"integer",
  "Case Type":"string",
  "Alert":"string",
  "Payer":"string",
  "Amount":"float",
  "Payee":"string",
  "Closed By":"string",
  "Closed On":"datetime",
  "Ticket Created Date":"datetime"
}', NULL, 1, NULL, NULL);