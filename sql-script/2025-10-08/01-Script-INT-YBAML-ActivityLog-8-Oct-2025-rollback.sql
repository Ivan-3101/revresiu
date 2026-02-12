UPDATE ui.dashboardquery SET
vcdashboardquery = 'SELECT makeruser.vcusername as "User Name", r.dtactivity  as  "Time stamp", r.vcactivity as "UI", r.vcparameters as "Query Parameter" FROM ui.activitylog r left join ui.webuser makeruser on makeruser.iuserid = r.iuserid where makeruser.iuserid in (select webuserid from ui.webusermapping where mappingid = :tenantid and mappingtype = ''Tenant'') and cast(r.dtactivity at time zone :timeZone as date) between cast(:StartDate as date) and cast(:EndDate as date) limit 50000;'::text
WHERE idashboardqueryid = 89 AND itenantid in (8, 17, 16, 21, 22, 23);


UPDATE ui.dashboardresultset SET
vcdashboardresultsetlayout = '{"sizes":[1],"detail":{"main":{"type":"tab-area","widgets":["PERSPECTIVE_GENERATED_ID_1"],"currentIndex":0}},"mode":"globalFilters","viewers":{"PERSPECTIVE_GENERATED_ID_1":{"plugin":"Datagrid","plugin_config":{"columns":{},"editable":false,"scroll_lock":false},"settings":false,"theme":"Pro Dark","title":"Audit Report - Activity Log","group_by":[],"split_by":[],"columns":[],"filter":[],"sort":[],"expressions":[],"aggregates":{},"master":false,"table":"auditreportactivitylog","linked":false}}} '::text, vcdashboardresultsetschema = '{
    "User Name":"string",
    "Time stamp":"datetime",
    "UI":"string",
    "Query Parameter":"string"
} '::text WHERE
idashboardqueryid = 89 AND itenantid in (8, 17, 16, 21, 22, 23);
