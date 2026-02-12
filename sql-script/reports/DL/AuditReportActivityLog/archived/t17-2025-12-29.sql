
UPDATE ui.dashboardquery SET
vcdashboardquery = 'SELECT makeruser.vcusername as "User Name", r.dtactivity  as  "Time stamp", r.vcactivity as "UI", r.vcparameters as "Query Parameter" FROM t17refined.ui.activitylog r left join postgresql.ui.webuser makeruser on makeruser.iuserid = r.iuserid where makeruser.iuserid in (select webuserid from postgresql.ui.webusermapping where mappingid = :tenantid and mappingtype = ''Tenant'') and r.dtactivity between :StartDate and :EndDate  limit 50000'::text WHERE
itenantid = 17 AND idashboardqueryid = 175;