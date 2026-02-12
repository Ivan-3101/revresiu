UPDATE ui.dashboardquery SET
vcdashboardquery = 'WITH raw AS (
    SELECT
        makeruser.vcusername as "User Name",
        r.dtactivity as "Time stamp",
        r.vcactivity as "UI",
        r.vcparameters as "Query Parameter"
    FROM
        ui.activitylog r
        left join ui.webuser makeruser on makeruser.iuserid = r.iuserid
    where
        makeruser.iuserid in (
            select
                webuserid
            from
                ui.webusermapping
            where
                mappingid = :tenantid
                and mappingtype = ''Tenant''
        )
        and cast(r.dtactivity at time zone :timeZone as date) between cast(:StartDate as date)
        and cast(:EndDate as date)
    limit
        50000
), convertjson AS (
    SELECT
        CASE
            WHEN "UI" LIKE ''dashboard data requested for Dashboard%''
            OR "UI" LIKE ''dashboard data accessed successfully for dashboard%'' THEN "Query Parameter" :: jsonb
            ELSE NULL
        END AS json_param,
        "User Name",
        "Time stamp",
        "UI",
        "Query Parameter"
    FROM
        raw
)
SELECT
    "User Name",
    "Time stamp",
    cast(json_param ->> ''ExecutionStarted'' as timestamp with time zone) as "Execution Started",
    cast(json_param ->> ''ExecutionEnded'' as timestamp with time zone) as "Execution Ended",
    "UI",
    "Query Parameter",
    json_param ->> ''dashboardName'' as "Dashboard Name",
    json_param ->> ''TotalExecutionTime'' as "Total Execution Time"
FROM
    convertjson;'::text WHERE
idashboardqueryid = 89 AND itenantid in (8, 17, 16, 21, 22, 23);


UPDATE ui.dashboardresultset SET
vcdashboardresultsetschema = '{
    "User Name":"string",
    "Time stamp":"datetime",
    "UI":"string",
    "Query Parameter":"string",
    "Execution Started":"datetime",
    "Execution Ended":"datetime",
    "Dashboard Name":"string",
    "Total Execution Time":"string"
}'::text,
vcdashboardresultsetlayout = '{"sizes":[1],"detail":{"main":{"type":"tab-area","widgets":["PERSPECTIVE_GENERATED_ID_1"],"currentIndex":0}},"mode":"globalFilters","viewers":{"PERSPECTIVE_GENERATED_ID_1":{"version":"3.3.4","plugin":"Datagrid","plugin_config":{"columns":{},"edit_mode":"SELECT_ROW","scroll_lock":false},"columns_config":{},"settings":false,"theme":"Pro Dark","title":"Audit Report - Activity Log","group_by":[],"split_by":[],"columns":["User Name","Time stamp","UI","Dashboard Name","Execution Started","Execution Ended","Total Execution Time","Query Parameter"],"filter":[],"sort":[["Time stamp","desc"]],"expressions":{},"aggregates":{}}}}'::text
WHERE
idashboardqueryid = 89 AND itenantid in (8, 17, 16, 21, 22, 23);
