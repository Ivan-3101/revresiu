--ybaml bapa report
UPDATE ui.dashboardquery SET
vcdashboardquery = 'select  cuser.email_ as "Analyst Name", ''AML Cases'' as  "Workflow Name",
sum(case when ActionV.text_=''notsuspicious'' then 1 else 0 end) as "#Closed Cases",
sum(case when ActionV.text_=''suspicioussendtodb'' then 1 else 0 end) as "#Cases Referred to DB",
sum(case when ActionV.text_=''suspicioussendtobranch'' then 1 else 0 end) as "#Cases Referred to Branch",
sum (case when ActionV.text_=''suspicious'' then 1 else 0 end) as "#Cases Escalated", 
sum(case when ActionV.text_ is not null then 1 else 0 end) as "Total Cases"
FROM (SELECT * FROM CAMUNDA.ACT_HI_PROCINST WHERE PROC_DEF_KEY_=''AMLCases'' and tenant_id_= :tenantidstr) AS PROC
INNER JOIN (SELECT distinct on (proc_inst_id_) * FROM CAMUNDA.ACT_HI_TASKINST WHERE NAME_ = ''Review Case By L1/ L2'' and assignee_ is not null order by proc_inst_id_, start_time_ desc) AS TASKL1L2
ON PROC.PROC_INST_ID_=TASKL1L2.PROC_INST_ID_
LEFT JOIN camunda.act_hi_varinst as ActionV
ON taskl1l2.proc_inst_id_=ActionV.proc_inst_id_ and ActionV.name_=''Action'' and date(ActionV.create_time_) = :Date
JOIN camunda.act_id_user cuser on taskl1l2.assignee_ = cuser.id_
group by cuser.email_'::text WHERE
idashboardqueryid = 60 AND itenantid = 8;

--ybaml pobo report
UPDATE ui.dashboardquery SET
vcdashboardquery = 'select  cuser.email_ as "Analyst Name", ''AML Cases'' as  "Workflow Name",
sum(case when ActionV.text_=''notsuspicious'' then 1 else 0 end) as "#Closed Cases",
sum(case when ActionV.text_=''suspicioussendtodb'' then 1 else 0 end) as "#Cases Referred to DB",
sum(case when ActionV.text_=''suspicioussendtobranch'' then 1 else 0 end) as "#Cases Referred to Branch",
sum (case when ActionV.text_=''suspicious'' then 1 else 0 end) as "#Cases Escalated", 
sum(case when ActionV.text_ is not null then 1 else 0 end) as "Total Cases"
FROM (SELECT * FROM CAMUNDA.ACT_HI_PROCINST WHERE PROC_DEF_KEY_=''AMLCasesPOBO'' and tenant_id_= :tenantidstr) AS PROC
INNER JOIN (SELECT distinct on (proc_inst_id_) * FROM CAMUNDA.ACT_HI_TASKINST WHERE NAME_ = ''Review Case By L1/ L2 POBO'' and assignee_ is not null order by proc_inst_id_, start_time_ desc) AS TASKL1L2
ON PROC.PROC_INST_ID_=TASKL1L2.PROC_INST_ID_
LEFT JOIN camunda.act_hi_varinst as ActionV
ON taskl1l2.proc_inst_id_=ActionV.proc_inst_id_ and ActionV.name_=''Action'' and date(ActionV.create_time_) = :Date
JOIN camunda.act_id_user cuser on taskl1l2.assignee_ = cuser.id_
group by cuser.email_'::text WHERE
idashboardqueryid = 60 AND itenantid = 16;