UPDATE ui.dashboardquery SET
vcdashboardquery = 'with d1 as (select case when vcrolename = ''CUB Analyst'' then ''CUB_RiskNotification'' when vcrolename =
			''USFB Analyst'' then ''USFB_RiskNotification'' else ''ALL'' end 
			as role from ui.webuser wu left join ui.userrolemap urm on urm.iuserid = wu.iuserid left
			join ui.roledesc rd on rd.iroleid = urm.iroleid where wu.iuserid = :loggedinuser )
			SELECT ''All Cases'' AS "label", ''All'' AS "value" union all 
			(select workflowname as "label", workflowkey as "value" FROM ui.workflowmasters pdef where 
			 (''ALL'' = (select role from d1) or workflowkey  = (select role from d1)) and is_filter_display=true group by workflowkey, workflowname order by workflowname )'::text WHERE
idashboardqueryid = 61;

