INSERT INTO ui.dashboardquery (
    idashboardqueryid, bparametersrequired, vcfilterparametersjson, 
    vcdashboardquery, formattingrequiered, runonanalytics, transposerequired, 
    imenustructuredesc, itenantid
)
SELECT 
    153 AS idashboardqueryid,
    true AS bparametersrequired,
    '{"Level": null, "address": null}'::text AS vcfilterparametersjson,
    '{
        "Account": "SELECT iaccountid FROM masters.accounts WHERE vcexternalaccountid = :address and itenantid = :tenantid",
        "VPA": "SELECT ivpaid FROM masters.vpa WHERE vcexternaladdressid = :address and itenantid = :tenantid"
    }'::text AS vcdashboardquery,
    false AS formattingrequiered,
    false AS runonanalytics,
    false AS transposerequired,
    578 AS imenustructuredesc,
    t.itenantid
FROM 
    ui.tenants t
WHERE 
   t.itenantid in (5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25) ;

INSERT INTO ui.dashboardquery (
    idashboardqueryid, bparametersrequired, vcfilterparametersjson, 
    vcdashboardquery, formattingrequiered, runonanalytics, transposerequired, 
    imenustructuredesc, itenantid
)
SELECT 
    154 AS idashboardqueryid,
    true AS bparametersrequired,
    '{"Level": null, "tablename": null, "id":null}'::text AS vcfilterparametersjson,
    '{
        "Account": "SELECT tdate from profiles.:tablename WHERE iaccountid = :id and itenantid = :tenantid order by tdate desc limit 6",
        "VPA": "SELECT tdate from profiles.:tablename WHERE ivpaid = :id and itenantid = :tenantid order by tdate desc limit 6"
    }'::text AS vcdashboardquery,
    false AS formattingrequiered,
    false AS runonanalytics,
    false AS transposerequired,
    578 AS imenustructuredesc,
    t.itenantid
FROM 
    ui.tenants t
WHERE 
    t.itenantid in (5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25) ;


INSERT INTO ui.dashboardqueryparameters (
    idashboardparameterid, vcparametername, vcparametertype, idashboardqueryid, iorder, itenantid
)
SELECT 
   (select max(idashboardparameterid) + 1 from ui.dashboardqueryparameters) AS idashboardparameterid,
    'Level' AS vcparametername,
    'JsonPath' AS vcparametertype,
    153 AS idashboardqueryid,
    0 AS iorder,
    t.itenantid
FROM 
    ui.tenants t
WHERE 
    t.itenantid in (5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25) ;

INSERT INTO ui.dashboardqueryparameters (
    idashboardparameterid, vcparametername, vcparametertype, idashboardqueryid, iorder, itenantid
)
SELECT 
    (select max(idashboardparameterid) + 1 from ui.dashboardqueryparameters) AS idashboardparameterid,
    'address' AS vcparametername,
    'String' AS vcparametertype,
    153 AS idashboardqueryid,
    NULL AS iorder,
    t.itenantid
FROM 
    ui.tenants t
WHERE 
    t.itenantid in (5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25) ;

INSERT INTO ui.dashboardqueryparameters (
    idashboardparameterid, vcparametername, vcparametertype, idashboardqueryid, iorder, itenantid
)
SELECT 
   (select max(idashboardparameterid) + 1 from ui.dashboardqueryparameters) AS idashboardparameterid,
    'Level' AS vcparametername,
    'JsonPath' AS vcparametertype,
    154 AS idashboardqueryid,
    0 AS iorder,
    t.itenantid
FROM 
    ui.tenants t WHERE 
    t.itenantid in (5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25) ;

INSERT INTO ui.dashboardqueryparameters (
    idashboardparameterid, vcparametername, vcparametertype, idashboardqueryid, iorder, itenantid
)
SELECT 
    (select max(idashboardparameterid) + 1 from ui.dashboardqueryparameters) AS idashboardparameterid,
    'tablename' AS vcparametername,
    'TableName' AS vcparametertype,
    154 AS idashboardqueryid,
    NULL AS iorder,
    t.itenantid
FROM 
    ui.tenants t WHERE 
    t.itenantid in (5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25) ;

INSERT INTO ui.dashboardqueryparameters (
    idashboardparameterid, vcparametername, vcparametertype, idashboardqueryid, iorder, itenantid
)
SELECT 
    (select max(idashboardparameterid) + 1 from ui.dashboardqueryparameters) AS idashboardparameterid,
    'id' AS vcparametername,
    'Integer' AS vcparametertype,
    154 AS idashboardqueryid,
    NULL AS iorder,
    t.itenantid
FROM 
    ui.tenants t WHERE 
    t.itenantid in (5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25) ;