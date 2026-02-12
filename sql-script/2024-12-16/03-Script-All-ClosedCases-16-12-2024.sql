---40043 40056
UPDATE ui.dashboardquery SET
vcdashboardquery = 'with d1 as (select mappingid from ui.webusermapping where webuserid = :loggedinuser and mappingtype = ''Workflow'')
(select workflowname as "label", workflowkey as "value" FROM ui.workflowmasters where
(workflowid in (select mappingid from d1) or -1 
in (select mappingid from d1)) and itenantid=:tenantid
and is_filter_display=true) ORDER BY label
'::text WHERE
idashboardqueryid = 144;