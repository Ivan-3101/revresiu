INSERT INTO ui.dashboard (idashboardid, bactive, bdelete, vcdashboardname, iorder, irowcount, imenustructuredesc, itenantid, bdynamic) 
select 19, true, false, 'Daily Productivity Report', 19, 1, 536, itenantid, true from ui.tenants where itenantid not in (select itenantid from ui.tenants where iorgid = 5 or iorgid = 0);

INSERT INTO ui.dashboardquery(idashboardqueryid, bparametersrequired, vcfilterparametersjson, vcdashboardquery, formattingrequiered, runonanalytics, transposerequired, imenustructuredesc, itenantid) SELECT 60,TRUE,'{"Date" : null, "CaseType" : null}','
{
    "All":"WITH raw AS ( SELECT hiproc.proc_inst_id_ AS \"procid\", hitask.end_time_ AS \"endtime\", hitask.id_ AS \"taskid\", hiproc.state_ AS \"state\", assignee.email_ AS \"assignee\", hitask.name_ AS \"taskname\", grup.vcgroupname AS \"groupname\", workflow.workflowname as \"workflowname\" FROM camunda.act_hi_taskinst hitask LEFT JOIN camunda.act_hi_procinst hiproc ON hiproc.proc_inst_id_ = hitask.proc_inst_id_ LEFT JOIN camunda.act_hi_detail hidetail ON hidetail.name_ = ''userActivity'' AND hitask.assignee_ IS NOT NULL AND hitask.end_time_ IS NULL AND hidetail.proc_inst_id_ = hiproc.proc_inst_id_ LEFT JOIN camunda.act_id_user assignee ON assignee.id_ = hitask.assignee_ LEFT JOIN ui.webusermapping groupmembership ON cast(groupmembership.webuserid as text) = assignee.id_ and groupmembership.mappingtype = ''Group'' and groupmembership.mappingid != 1 and groupmembership.itenantid = :tenantid LEFT JOIN ui.groupdesc grup ON grup.igroupid = groupmembership.mappingid LEFT JOIN ui.workflowmasters workflow on workflow.workflowkey = hiproc.proc_def_key_ and workflow.itenantid = :tenantid WHERE (CAST(hitask.end_time_ AS date) = :Date OR CAST(hidetail.time_ AS date) = :Date ) AND hitask.proc_def_key_ in (with d1 as (select mappingid from ui.webusermapping where webuserid = :loggedinuser and mappingtype = ''Workflow'') (select workflowkey FROM ui.workflowmasters where (workflowid in (select mappingid from d1) or -1 in (select mappingid from d1)) and itenantid=:tenantid and is_filter_display=true)) AND hiproc.state_ != ''EXTERNALLY_TERMINATED'' AND hitask.assignee_ IS NOT NULL ) SELECT org.assignee AS \"Analyst\", STRING_AGG(distinct org.groupname, '', '') AS \"User Group\", org.taskname as \"Stage Name\", count(distinct case when org.endtime is not null then org.taskid else null end) as \"Cases Submitted\", count(distinct case when org.endtime is null then org.taskid else null end) as \"Claimed\", count(distinct closedby.taskid) as \"Total Cases - Closed\", org.workflowname as \"Workflow Name\" FROM raw org LEFT JOIN raw closedby ON closedby.taskid = ( SELECT taskid FROM raw WHERE procid = org.procid AND state = ''COMPLETED'' ORDER BY endtime DESC LIMIT 1 ) and closedby.taskid = org.taskid AND closedby.state = ''COMPLETED'' GROUP BY org.assignee, org.taskname, org.workflowname;",
    "Other":"WITH raw AS ( SELECT hiproc.proc_inst_id_ AS \"procid\", hitask.end_time_ AS \"endtime\", hitask.id_ AS \"taskid\", hiproc.state_ AS \"state\", assignee.email_ AS \"assignee\", hitask.name_ AS \"taskname\", grup.vcgroupname AS \"groupname\", workflow.workflowname as \"workflowname\" FROM camunda.act_hi_taskinst hitask LEFT JOIN camunda.act_hi_procinst hiproc ON hiproc.proc_inst_id_ = hitask.proc_inst_id_ LEFT JOIN camunda.act_hi_detail hidetail ON hidetail.name_ = ''userActivity'' AND hitask.assignee_ IS NOT NULL AND hitask.end_time_ IS NULL AND hidetail.proc_inst_id_ = hiproc.proc_inst_id_ LEFT JOIN camunda.act_id_user assignee ON assignee.id_ = hitask.assignee_ LEFT JOIN ui.webusermapping groupmembership ON cast(groupmembership.webuserid as text) = assignee.id_ and groupmembership.mappingtype = ''Group'' and groupmembership.mappingid != 1 and groupmembership.itenantid = :tenantid LEFT JOIN ui.groupdesc grup ON grup.igroupid = groupmembership.mappingid LEFT JOIN ui.workflowmasters workflow on workflow.workflowkey = hiproc.proc_def_key_ and workflow.itenantid = :tenantid WHERE (CAST(hitask.end_time_ AS date) = :Date OR CAST(hidetail.time_ AS date) = :Date ) AND hitask.proc_def_key_ = :CaseType AND hiproc.state_ != ''EXTERNALLY_TERMINATED'' AND hitask.assignee_ IS NOT NULL ) SELECT org.assignee AS \"Analyst\", STRING_AGG(distinct org.groupname, '', '') AS \"User Group\", org.taskname as \"Stage Name\", count(distinct case when org.endtime is not null then org.taskid else null end) as \"Cases Submitted\", count(distinct case when org.endtime is null then org.taskid else null end) as \"Claimed\", count(distinct closedby.taskid) as \"Total Cases - Closed\", org.workflowname as \"Workflow Name\" FROM raw org LEFT JOIN raw closedby ON closedby.taskid = ( SELECT taskid FROM raw WHERE procid = org.procid AND state = ''COMPLETED'' ORDER BY endtime DESC LIMIT 1 ) and closedby.taskid = org.taskid AND closedby.state = ''COMPLETED'' GROUP BY org.assignee, org.taskname, org.workflowname;"

}',FALSE,FALSE,FALSE,536, t.itenantid FROM ui.tenants t WHERE itenantid not in (select itenantid from ui.tenants where iorgid = 5 or iorgid = 0);

INSERT INTO ui.dashboardresultset (idashboardresultsetid, iresultsetorder, vcdashboardresultsetcolumnjson, vcdashboardresultsetlayout, vcdashboardresultsetname, idashboardqueryid, idashboardid, vcdashboardresultsetschema, icolsize, irowno, dtlastupdatedtimestamp, iuserid, imenustructuredesc, itenantid, iorgid) 
select 28, NULL, NULL, '{"sizes":[1],"detail":{"main":{"type":"tab-area","widgets":["PERSPECTIVE_GENERATED_ID_1"],"currentIndex":0}},"mode":"globalFilters","viewers":{"PERSPECTIVE_GENERATED_ID_1":{"plugin":"Datagrid","plugin_config":{"columns":{},"editable":false,"scroll_lock":false},"settings":false,"theme":"Pro Dark","title":"Daily Productivity Report","group_by":[],"split_by":[],"columns":["Analyst Name",
"Workflow Name",
"#Closed Cases",
"#Cases Referred to DB",
"#Cases Referred to Branch",
"#Cases Escalated",
"Total Cases"],"filter":[],"sort":[],"expressions":[],"aggregates":{},"master":false,"table":"dailyproductivityreport","linked":false}}} ', 'dailyproductivityreport', 60, 19, '{
"Analyst":"string",
"User Group":"string",
"Stage Name":"string",
"Cases Submitted":"integer",
"Claimed":"integer",
"Total Cases - Closed":"integer",
"Workflow Name":"string"
}
', NULL, 1, NULL, NULL, 536, itenantid, 5
from ui.tenants where itenantid not in (select itenantid from ui.tenants where iorgid = 5 or iorgid = 0);

INSERT INTO ui.dashboardfilters (idashboardfilterid, ifilterorder, vcdashboardfiltername, idashboardid, vcdashboardfiltertype, idashboardqueryidfordefaultvalue,  idashboardqueryidforoptions, itenantid, vcdashboardfilterdisplayname) SELECT 42, 1,'Date',19,'DatePicker',1,NULL, itenantid,'Date' FROM ui.tenants WHERE itenantid not in (select itenantid from ui.tenants where iorgid = 5 or iorgid = 0);

INSERT INTO ui.dashboardfilters (idashboardfilterid, ifilterorder, vcdashboardfiltername, idashboardid, vcdashboardfiltertype, idashboardqueryidfordefaultvalue,  idashboardqueryidforoptions, itenantid, vcdashboardfilterdisplayname) SELECT (select max(idashboardfilterid) + 1  from ui.dashboardfilters), 0,'CaseType',19,'Select',NULL, 61, itenantid,'Case Type' FROM ui.tenants WHERE itenantid not in (select itenantid from ui.tenants where iorgid = 5 or iorgid = 0);

INSERT INTO ui.dashboardqueryparameters(idashboardparameterid, vcparametername, vcparametertype, idashboardqueryid, iorder, itenantid) SELECT (select max(idashboardparameterid) + 1 from ui.dashboardqueryparameters),'CaseType','JsonPath', 60, 0, t.itenantid FROM ui.tenants t where itenantid not in (select itenantid from ui.tenants where iorgid = 5 or iorgid = 0);

INSERT INTO ui.dashboardqueryparameters(idashboardparameterid, vcparametername, vcparametertype, idashboardqueryid, iorder, itenantid) SELECT 98,'Date','Date', 60, 1, t.itenantid FROM ui.tenants t WHERE itenantid not in (select itenantid from ui.tenants where iorgid = 5 or iorgid = 0);





