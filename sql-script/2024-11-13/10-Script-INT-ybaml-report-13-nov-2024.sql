UPDATE ui.dashboardquery SET
vcdashboardquery = 'SELECT 
    cuser.email_ AS "Analyst Name", 
    ''AML Cases'' AS "Workflow Name", 
    SUM(CASE WHEN ActionV.text_ = ''notsuspicious'' THEN 1 ELSE 0 END) AS "#Closed Cases", 
    SUM(CASE WHEN ActionV.text_ = ''suspicioussendtodb'' THEN 1 ELSE 0 END) AS "#Cases Referred to DB", 
    SUM(CASE WHEN ActionV.text_ = ''suspicioussendtobranch'' THEN 1 ELSE 0 END) AS "#Cases Referred to Branch", 
    SUM(CASE WHEN ActionV.text_ = ''suspicious'' THEN 1 ELSE 0 END) AS "#Cases Escalated", 
    SUM(CASE WHEN ActionV.text_ IS NOT NULL THEN 1 ELSE 0 END) AS "Total Cases"
FROM 
    CAMUNDA.ACT_HI_TASKINST TASKL1L2 
LEFT JOIN 
    camunda.act_hi_varinst AS ActionV 
    ON TASKL1L2.proc_inst_id_ = ActionV.proc_inst_id_
    AND ActionV.name_ = ''Action''
     and actionv.var_type_=''string'' AND ActionV.create_time_ = :Date
JOIN 
    camunda.act_id_user cuser 
    ON TASKL1L2.assignee_ = cuser.id_
WHERE 
TASKL1L2.NAME_ = ''Review Case By L1/ L2''
    AND TASKL1L2.assignee_ IS NOT NULL and
    taskl1l2.PROC_DEF_KEY_ = ''AMLCases''
    AND taskl1l2.tenant_id_ = :tenantidstr
GROUP BY 
    cuser.email_;'::text WHERE
idashboardqueryid = 60 AND itenantid = 17;