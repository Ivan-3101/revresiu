---52964
--all
INSERT INTO ui.dashboardquery (
    idashboardqueryid, bparametersrequired, vcdashboardquery, itenantid, dbtype
)
SELECT 
    165 AS idashboardqueryid,
    false AS bparametersrequired,
    'SELECT X.* FROM   (VALUES (''Account'', ''Account''),(''VPA'', ''VPA'')) AS X ("label", "value");'::text AS vcdashboardquery,
    t.itenantid,
    1 AS dbtype
FROM 
    ui.tenants t where itenantid != 0;

update ui.dashboardfilters set idashboardqueryidforoptions=165 
where idashboardid in (15,21,17) and vcdashboardfiltername in ('Party', 'Level' );


