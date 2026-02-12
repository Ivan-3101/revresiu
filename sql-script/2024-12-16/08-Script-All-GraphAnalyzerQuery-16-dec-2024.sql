---
delete from  ui.dashboardfilters where idashboardid=60 and itenantid=6;
	
delete from  ui.dashboardresultset where idashboardid=60 and itenantid=6;
	
delete from  ui.dashboard where idashboardid=60 and itenantid=6;

---risk analyst
INSERT INTO ui.rolemenuaccessmap 
    (irolemenumapid, badd, bapprove, bdelete, bedit, bpublish, bview, 
     dtapproverstamp, dtentrystamp, istatus, iapproveruserid, ientryuserid, 
     imenuid, iroleid, itenantid, iorgid)
SELECT 
    (select max(irolemenumapid) + 1 from ui.rolemenuaccessmap) AS irolemenumapid,  
    true AS badd, 
    true AS bapprove, 
    true AS bdelete, 
    true AS bedit, 
    true AS bpublish, 
    true AS bview, 
    NULL AS dtapproverstamp, 
    NULL AS dtentrystamp, 
    true AS istatus, 
    NULL AS iapproveruserid, 
    NULL AS ientryuserid, 
    579 AS imenuid, 
    5 AS iroleid, 
    t.itenantid, 
    o.iorgid
FROM 
    ui.tenants t 
JOIN 
    ui.orgs o 
ON 
    t.iorgid = o.iorgid
WHERE 
    t.itenantid > 4 and t.itenantid not in (11,14,15,18,25);


--risk admin

INSERT INTO ui.rolemenuaccessmap 
    (irolemenumapid, badd, bapprove, bdelete, bedit, bpublish, bview, 
     dtapproverstamp, dtentrystamp, istatus, iapproveruserid, ientryuserid, 
     imenuid, iroleid, itenantid, iorgid)
SELECT 
    (select max(irolemenumapid) + 1 from ui.rolemenuaccessmap) AS irolemenumapid,  
    true AS badd, 
    true AS bapprove, 
    true AS bdelete, 
    true AS bedit, 
    true AS bpublish, 
    true AS bview, 
    NULL AS dtapproverstamp, 
    NULL AS dtentrystamp, 
    true AS istatus, 
    NULL AS iapproveruserid, 
    NULL AS ientryuserid, 
    579 AS imenuid, 
    10 AS iroleid, 
    t.itenantid, 
    o.iorgid
FROM 
    ui.tenants t 
JOIN 
    ui.orgs o 
ON 
    t.iorgid = o.iorgid
WHERE 
    t.itenantid  in (5,6,7,8,9,10,16,17,19,20,21,22,23,24);


--risk super
INSERT INTO ui.rolemenuaccessmap 
    (irolemenumapid, badd, bapprove, bdelete, bedit, bpublish, bview, 
     dtapproverstamp, dtentrystamp, istatus, iapproveruserid, ientryuserid, 
     imenuid, iroleid, itenantid, iorgid)
SELECT 
    (select max(irolemenumapid) + 1 from ui.rolemenuaccessmap) AS irolemenumapid,  
    true AS badd, 
    true AS bapprove, 
    true AS bdelete, 
    true AS bedit, 
    true AS bpublish, 
    true AS bview, 
    NULL AS dtapproverstamp, 
    NULL AS dtentrystamp, 
    true AS istatus, 
    NULL AS iapproveruserid, 
    NULL AS ientryuserid, 
    579 AS imenuid, 
    14 AS iroleid, 
    t.itenantid, 
    o.iorgid
FROM 
    ui.tenants t 
JOIN 
    ui.orgs o 
ON 
    t.iorgid = o.iorgid
WHERE 
    t.itenantid  in (14, 15);

INSERT INTO ui.rolemenuaccessmap 
    (irolemenumapid, badd, bapprove, bdelete, bedit, bpublish, bview, 
     dtapproverstamp, dtentrystamp, istatus, iapproveruserid, ientryuserid, 
     imenuid, iroleid, itenantid, iorgid)
SELECT 
    (select max(irolemenumapid) + 1 from ui.rolemenuaccessmap) AS irolemenumapid,  
    true AS badd, 
    true AS bapprove, 
    true AS bdelete, 
    true AS bedit, 
    true AS bpublish, 
    true AS bview, 
    NULL AS dtapproverstamp, 
    NULL AS dtentrystamp, 
    true AS istatus, 
    NULL AS iapproveruserid, 
    NULL AS ientryuserid, 
    579 AS imenuid, 
    1 AS iroleid, 
    t.itenantid, 
    o.iorgid
FROM 
    ui.tenants t 
JOIN 
    ui.orgs o 
ON 
    t.iorgid = o.iorgid
WHERE 
    t.itenantid  in (12,13);

------------------

INSERT INTO ui.dashboard (
    idashboardid, bactive, bdelete, vcdashboardname,
    iorder, irowcount, imenustructuredesc, itenantid, bdynamic
)
SELECT 
    59 AS idashboardid,  
    true AS bactive,
    false AS bdelete,
    'Master Data' AS vcdashboardname,
    43 AS iorder,
    1 AS irowcount,
    579 AS imenustructuredesc,
    t.itenantid,  
    true AS bdynamic
FROM 
    ui.tenants t where  t.itenantid in (5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25);


INSERT INTO ui.dashboardquery (
    idashboardqueryid, bparametersrequired, vcfilterparametersjson, 
    vcdashboardquery, formattingrequiered, runonanalytics, transposerequired, 
    imenustructuredesc, itenantid
)
SELECT 
    120 AS idashboardqueryid,
    true AS bparametersrequired,
    '{
        "VpaAddress":null,
        "Party":null,
        "Fields":null
    }'::jsonb AS vcfilterparametersjson,
    'SELECT * FROM masters.get_nodewithvcattribs(:Party, ARRAY[:FieldsValue], :VpaAddress)
    AS (node VARCHAR(100), :FieldsReturnType)' AS vcdashboardquery,
    false AS formattingrequiered,
    false AS runonanalytics,
    false AS transposerequired,
    579 AS imenustructuredesc,
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
    119 AS idashboardqueryid,
    false AS bparametersrequired,
    NULL AS vcfilterparametersjson,
    'SELECT X.* FROM  
    (VALUES (''Mobile Number'', ''vcregisteredmobile'', ''vcregisteredmobile VARCHAR(255)'' ), 
             (''Email ID'', ''vcemail'', ''vcemail VARCHAR(255)'')) AS X ("label", "value", "returntype")' AS vcdashboardquery,
    false AS formattingrequiered,
    false AS runonanalytics,
    false AS transposerequired,
    579 AS imenustructuredesc,
    t.itenantid
FROM 
    ui.tenants t
WHERE  t.itenantid in (5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25);

INSERT INTO ui.dashboardquery (
    idashboardqueryid, bparametersrequired, vcfilterparametersjson, 
    vcdashboardquery, formattingrequiered, runonanalytics, transposerequired, 
    imenustructuredesc, itenantid
)
SELECT 
    122 AS idashboardqueryid,
    false AS bparametersrequired,
    NULL AS vcfilterparametersjson,
    'SELECT X.* FROM (VALUES (''Customer'', ''masters.customers'')) AS X ("label", "value")' AS vcdashboardquery,
    false AS formattingrequiered,
    false AS runonanalytics,
    false AS transposerequired,
    579 AS imenustructuredesc,
    t.itenantid
FROM 
    ui.tenants t
WHERE  t.itenantid in (5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25);

INSERT INTO ui.dashboardresultset (
    idashboardresultsetid, iresultsetorder, vcdashboardresultsetcolumnjson, 
    vcdashboardresultsetlayout, vcdashboardresultsetname, idashboardqueryid, 
    idashboardid, vcdashboardresultsetschema, icolsize, irowno, 
    dtlastupdatedtimestamp, iuserid, imenustructuredesc, itenantid, iorgid
)
SELECT 
    219 AS idashboardresultsetid,
    NULL AS iresultsetorder,
    NULL AS vcdashboardresultsetcolumnjson,
    '{}' AS vcdashboardresultsetlayout,
    'graphanalyzer' AS vcdashboardresultsetname,
    120 AS idashboardqueryid,
    59 AS idashboardid,
    '{}' AS vcdashboardresultsetschema,
    NULL AS icolsize,
    1 AS irowno,
    NULL AS dtlastupdatedtimestamp,
    NULL AS iuserid,
    579 AS imenustructuredesc,
    t.itenantid,
    o.iorgid
FROM 
    ui.tenants t
JOIN 
    ui.orgs o 
ON 
    t.iorgid = o.iorgid
WHERE 
  t.itenantid in (5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25);

INSERT INTO ui.dashboardqueryparameters (
    idashboardparameterid, vcparametername, vcparametertype, 
    idashboardqueryid, iorder, itenantid
)
SELECT 
    257 AS idashboardparameterid,
    'Party' AS vcparametername,
    'String' AS vcparametertype,
    120 AS idashboardqueryid,
    1 AS iorder,
    t.itenantid
FROM 
    ui.tenants t
WHERE t.itenantid in (5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25);

INSERT INTO ui.dashboardqueryparameters (
    idashboardparameterid, vcparametername, vcparametertype, 
    idashboardqueryid, iorder, itenantid
)
SELECT 
    258 AS idashboardparameterid,
    'VpaAddress' AS vcparametername,
    'String' AS vcparametertype,
    120 AS idashboardqueryid,
    2 AS iorder,
    t.itenantid
FROM 
    ui.tenants t
WHERE t.itenantid in (5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25);

INSERT INTO ui.dashboardqueryparameters (
    idashboardparameterid, vcparametername, vcparametertype, 
    idashboardqueryid, iorder, itenantid
)
SELECT 
    256 AS idashboardparameterid,
    'Fields' AS vcparametername,
    'List' AS vcparametertype,
    120 AS idashboardqueryid,
    0 AS iorder,
    t.itenantid
FROM 
    ui.tenants t
WHERE t.itenantid in (5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25);

INSERT INTO ui.dashboardfilters (
    idashboardfilterid, ifilterorder, vcdashboardfiltername, 
    idashboardid, vcdashboardfiltertype, idashboardqueryidfordefaultvalue, 
    idashboardqueryidforoptions, itenantid, vcdashboardfilterdisplayname
)
SELECT 
    163 AS idashboardfilterid,
    1 AS ifilterorder,
    'VpaAddress' AS vcdashboardfiltername,
    59 AS idashboardid,
    'Input' AS vcdashboardfiltertype,
    NULL AS idashboardqueryidfordefaultvalue,
    NULL AS idashboardqueryidforoptions,
    t.itenantid,
    'Address' AS vcdashboardfilterdisplayname
FROM 
    ui.tenants t
WHERE t.itenantid in (5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25);

INSERT INTO ui.dashboardfilters (
    idashboardfilterid, ifilterorder, vcdashboardfiltername, 
    idashboardid, vcdashboardfiltertype, idashboardqueryidfordefaultvalue, 
    idashboardqueryidforoptions, itenantid, vcdashboardfilterdisplayname
)
SELECT 
    162 AS idashboardfilterid,
    0 AS ifilterorder,
    'Party' AS vcdashboardfiltername,
    59 AS idashboardid,
    'Select' AS vcdashboardfiltertype,
    NULL AS idashboardqueryidfordefaultvalue,
    122 AS idashboardqueryidforoptions,
    t.itenantid,
    'Level' AS vcdashboardfilterdisplayname
FROM 
    ui.tenants t
WHERE t.itenantid in (5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25);

INSERT INTO ui.dashboardfilters (
    idashboardfilterid, ifilterorder, vcdashboardfiltername, 
    idashboardid, vcdashboardfiltertype, idashboardqueryidfordefaultvalue, 
    idashboardqueryidforoptions, itenantid, vcdashboardfilterdisplayname
)
SELECT 
    164 AS idashboardfilterid,
    3 AS ifilterorder,
    'Fields' AS vcdashboardfiltername,
    59 AS idashboardid,
    'MultiSelect' AS vcdashboardfiltertype,
    NULL AS idashboardqueryidfordefaultvalue,
    119 AS idashboardqueryidforoptions,
    t.itenantid,
    'Fields' AS vcdashboardfilterdisplayname
FROM 
    ui.tenants t
WHERE t.itenantid in (5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25);

------
UPDATE ui.dashboardfilters SET
vcdashboardfiltername = 'DisplayField'::character varying, vcdashboardfiltertype = 'Select'::character varying, vcdashboardfilterdisplayname = 'Display Field'::character varying WHERE
idashboardfilterid = 164;

---do for 12,13
INSERT INTO ui.dashboardfilters (
    idashboardfilterid, ifilterorder, vcdashboardfiltername, 
    idashboardid, vcdashboardfiltertype, idashboardqueryidfordefaultvalue, 
    idashboardqueryidforoptions, itenantid, vcdashboardfilterdisplayname
)
SELECT 
    (select max(idashboardfilterid) + 1 from ui.dashboardfilters) AS idashboardfilterid,
    1 AS ifilterorder,
    'SearchField' AS vcdashboardfiltername,
    59 AS idashboardid,
    'Select' AS vcdashboardfiltertype,
    NULL AS idashboardqueryidfordefaultvalue,
    119 AS idashboardqueryidforoptions,
    t.itenantid,
    'Search Field' AS vcdashboardfilterdisplayname
FROM 
    ui.tenants t
WHERE  t.itenantid in (5,6,7,8,9,10,11,14,15,16,17,18,19,20,21,22,23,24,25);



INSERT INTO ui.dashboardfilters (
    idashboardfilterid, ifilterorder, vcdashboardfiltername, 
    idashboardid, vcdashboardfiltertype, idashboardqueryidfordefaultvalue, 
    idashboardqueryidforoptions, itenantid, vcdashboardfilterdisplayname
)
SELECT 
    189 AS idashboardfilterid,
    1 AS ifilterorder,
    'SearchField' AS vcdashboardfiltername,
    59 AS idashboardid,
    'Select' AS vcdashboardfiltertype,
    NULL AS idashboardqueryidfordefaultvalue,
    119 AS idashboardqueryidforoptions,
    t.itenantid,
    'Search Field' AS vcdashboardfilterdisplayname
FROM 
    ui.tenants t
WHERE  t.itenantid  in (12,13);

UPDATE ui.dashboardqueryparameters SET
vcparametername = 'SearchField'::character varying, vcparametertype = 'String'::character varying WHERE
idashboardparameterid = 256 ;

INSERT INTO ui.dashboardqueryparameters (
    idashboardparameterid, vcparametername, vcparametertype, 
    idashboardqueryid, iorder, itenantid
)
SELECT 
    298 AS idashboardparameterid,
    'DisplayField' AS vcparametername,
    'String' AS vcparametertype,
    120 AS idashboardqueryid,
    3 AS iorder,
    t.itenantid
FROM 
    ui.tenants t where t.itenantid in (5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25);

UPDATE ui.dashboardquery
SET vcdashboardquery = 
    'SELECT X.* 
     FROM (VALUES 
               (''Customer'', ''masters.customers''),
               (''Account'', ''masters.accounts''),
               (''VPA'', ''masters.vpa'')
          ) AS X ("label", "value")'
WHERE idashboardqueryid = 122;

UPDATE ui.dashboardfilters SET
ifilterorder = '2'::integer WHERE
idashboardfilterid = 163 ;

UPDATE ui.dashboardquery SET
vcfilterparametersjson = '{
    "VpaAddress":null,
    "Party":null,
    "SearchField":null,
    "DisplayField":null
}'::text WHERE
idashboardqueryid = 120;

---
INSERT INTO ui.dashboard (
    idashboardid, bactive, bdelete, vcdashboardname, 
    iorder, irowcount, imenustructuredesc, itenantid, bdynamic
)
SELECT 
    71 AS idashboardid,
    true AS bactive,
    false AS bdelete,
    'Transaction Data' AS vcdashboardname,
    2 AS iorder,
    1 AS irowcount,
    579 AS imenustructuredesc,
    t.itenantid,
    true AS bdynamic
FROM 
    ui.tenants t;

INSERT INTO ui.dashboardquery (
    idashboardqueryid, bparametersrequired, vcfilterparametersjson, 
    vcdashboardquery, formattingrequiered, runonanalytics, transposerequired, 
    imenustructuredesc, itenantid
)
SELECT 
    147 AS idashboardqueryid,
    false AS bparametersrequired,
    NULL AS vcfilterparametersjson,
    'SELECT X.* FROM   (VALUES (''Transaction'', ''transactions'')) AS X ("label", "value")' AS vcdashboardquery,
    false AS formattingrequiered,
    false AS runonanalytics,
    false AS transposerequired,
    579 AS imenustructuredesc,
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
    148 AS idashboardqueryid,
    true AS bparametersrequired,
    '{
        "VpaAddress": null,
        "Party": null,
        "SearchField": null,
        "DisplayField": null
    }'::jsonb AS vcfilterparametersjson,
    'SELECT * FROM masters.get_nodewithvcattribs(:Party, ARRAY[:SearchField], :VpaAddress, :DisplayField)' AS vcdashboardquery,
    false AS formattingrequiered,
    false AS runonanalytics,
    false AS transposerequired,
    579 AS imenustructuredesc,
    t.itenantid
FROM 
    ui.tenants t
WHERE 
    t.itenantid in (5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25);

INSERT INTO ui.dashboardquery (
    idashboardqueryid, bparametersrequired, vcfilterparametersjson, 
    vcdashboardquery, formattingrequiered, runonanalytics, transposerequired, 
    imenustructuredesc, itenantid
)
SELECT 
    149 AS idashboardqueryid,
    false AS bparametersrequired,
    NULL AS vcfilterparametersjson,
    'SELECT X.* FROM  
    (VALUES 
        (''Payee Addr'', ''payee.addr'', ''payee.addr VARCHAR(255)''), 
        (''Payer Addr'', ''payer.addr'', ''payer.addr VARCHAR(255)''), 
        (''Txn ID'', ''txn.id'', ''txn.id VARCHAR(255)'')
    ) AS X ("label", "value", "returntype")' AS vcdashboardquery,
    false AS formattingrequiered,
    false AS runonanalytics,
    false AS transposerequired,
    579 AS imenustructuredesc,
    t.itenantid
FROM 
    ui.tenants t
WHERE 
    t.itenantid in (5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25) ;

INSERT INTO ui.dashboardresultset (
    idashboardresultsetid, iresultsetorder, vcdashboardresultsetcolumnjson, 
    vcdashboardresultsetlayout, vcdashboardresultsetname, idashboardqueryid, 
    idashboardid, vcdashboardresultsetschema, icolsize, irowno, 
    dtlastupdatedtimestamp, iuserid, imenustructuredesc, itenantid, iorgid
)
SELECT 
    230 AS idashboardresultsetid,
    NULL AS iresultsetorder,
    NULL AS vcdashboardresultsetcolumnjson,
    '{}' AS vcdashboardresultsetlayout,
    'graphanalyzer' AS vcdashboardresultsetname,
    148 AS idashboardqueryid,
    71 AS idashboardid,
    '{}' AS vcdashboardresultsetschema,
    NULL AS icolsize,
    1 AS irowno,
    NULL AS dtlastupdatedtimestamp,
    NULL AS iuserid,
    579 AS imenustructuredesc,
    t.itenantid,
    o.iorgid
FROM 
    ui.tenants t
JOIN 
    ui.orgs o 
ON 
    t.iorgid = o.iorgid
    where t.itenantid in (5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25);

INSERT INTO ui.dashboardfilters (
    idashboardfilterid, ifilterorder, vcdashboardfiltername, 
    idashboardid, vcdashboardfiltertype, idashboardqueryidfordefaultvalue, 
    idashboardqueryidforoptions, itenantid, vcdashboardfilterdisplayname
)
SELECT 
    (select max(idashboardfilterid) + 1 from ui.dashboardfilters) AS idashboardfilterid,
    0 AS ifilterorder,
    'Party' AS vcdashboardfiltername,
    71 AS idashboardid,
    'Select' AS vcdashboardfiltertype,
    NULL AS idashboardqueryidfordefaultvalue,
    147 AS idashboardqueryidforoptions,
    t.itenantid,
    'Level' AS vcdashboardfilterdisplayname
FROM 
    ui.tenants t where t.itenantid in (5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25);

INSERT INTO ui.dashboardfilters (
    idashboardfilterid, ifilterorder, vcdashboardfiltername, 
    idashboardid, vcdashboardfiltertype, idashboardqueryidfordefaultvalue, 
    idashboardqueryidforoptions, itenantid, vcdashboardfilterdisplayname
)
SELECT 
     (select max(idashboardfilterid) + 1 from ui.dashboardfilters) AS idashboardfilterid,
    2 AS ifilterorder,
    'VpaAddress' AS vcdashboardfiltername,
    71 AS idashboardid,
    'Input' AS vcdashboardfiltertype,
    NULL AS idashboardqueryidfordefaultvalue,
    NULL AS idashboardqueryidforoptions,
    t.itenantid,
    'Search Value' AS vcdashboardfilterdisplayname
FROM 
    ui.tenants t where t.itenantid in (5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25);
    
INSERT INTO ui.dashboardfilters (
    idashboardfilterid, ifilterorder, vcdashboardfiltername, 
    idashboardid, vcdashboardfiltertype, idashboardqueryidfordefaultvalue, 
    idashboardqueryidforoptions, itenantid, vcdashboardfilterdisplayname
)
SELECT 
    (select max(idashboardfilterid) + 1 from ui.dashboardfilters) AS idashboardfilterid,
    3 AS ifilterorder,
    'DisplayField' AS vcdashboardfiltername,
    71 AS idashboardid,
    'Select' AS vcdashboardfiltertype,
    NULL AS idashboardqueryidfordefaultvalue,
    152 AS idashboardqueryidforoptions,
    t.itenantid,
    'Display Field' AS vcdashboardfilterdisplayname
FROM 
    ui.tenants t where t.itenantid in (5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25);


INSERT INTO ui.dashboardfilters (
    idashboardfilterid, ifilterorder, vcdashboardfiltername, 
    idashboardid, vcdashboardfiltertype, idashboardqueryidfordefaultvalue, 
    idashboardqueryidforoptions, itenantid, vcdashboardfilterdisplayname
)
SELECT 
     (select max(idashboardfilterid) + 1 from ui.dashboardfilters) AS idashboardfilterid,
    1 AS ifilterorder,
    'SearchField' AS vcdashboardfiltername,
    71 AS idashboardid,
    'Select' AS vcdashboardfiltertype,
    NULL AS idashboardqueryidfordefaultvalue,
    149 AS idashboardqueryidforoptions,
    t.itenantid,
    'Search Field' AS vcdashboardfilterdisplayname
FROM 
    ui.tenants t where t.itenantid in (5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25);

INSERT INTO ui.dashboardqueryparameters (
    idashboardparameterid, vcparametername, vcparametertype, 
    idashboardqueryid, iorder, itenantid
)
SELECT 
    (select max(idashboardparameterid) + 1 from ui.dashboardqueryparameters) AS idashboardparameterid,
    'Party' AS vcparametername,
    'String' AS vcparametertype,
    148 AS idashboardqueryid,
    1 AS iorder,
    t.itenantid
FROM 
    ui.tenants t
WHERE t.itenantid in (5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25);

INSERT INTO ui.dashboardqueryparameters (
    idashboardparameterid, vcparametername, vcparametertype, 
    idashboardqueryid, iorder, itenantid
)
SELECT 
    (select max(idashboardparameterid) + 1 from ui.dashboardqueryparameters) AS idashboardparameterid,
    'VpaAddress' AS vcparametername,
    'String' AS vcparametertype,
    148 AS idashboardqueryid,
    2 AS iorder,
    t.itenantid
FROM 
    ui.tenants t
WHERE t.itenantid in (5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25);

INSERT INTO ui.dashboardqueryparameters (
    idashboardparameterid, vcparametername, vcparametertype, 
    idashboardqueryid, iorder, itenantid
)
SELECT 
    (select max(idashboardparameterid) + 1 from ui.dashboardqueryparameters) AS idashboardparameterid,
    'SearchField' AS vcparametername,
    'String' AS vcparametertype,
    148 AS idashboardqueryid,
    0 AS iorder,
    t.itenantid
FROM 
    ui.tenants t
WHERE t.itenantid in (5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25);

INSERT INTO ui.dashboardqueryparameters (
    idashboardparameterid, vcparametername, vcparametertype, 
    idashboardqueryid, iorder, itenantid
)
SELECT 
    (select max(idashboardparameterid) + 1 from ui.dashboardqueryparameters) AS idashboardparameterid,
    'DisplayField' AS vcparametername,
    'String' AS vcparametertype,
    148 AS idashboardqueryid,
    3 AS iorder,
    t.itenantid
FROM 
    ui.tenants t
WHERE t.itenantid in (5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25);

UPDATE ui.dashboardquery SET
vcdashboardquery =  E'{
    "masters.customers":"SELECT X.* FROM   (VALUES (''Mobile Number'', ''customers.vcregisteredmobile''),(''Email ID'', ''customers.vcemail''),(''GSTN'', ''customer.vcattribs'')) AS X (\\"label\\", \\"value\\")",
    "masters.accounts":"SELECT X.* FROM   (VALUES (''Account Number'', ''accounts.vcaccount''),(''IFSC'', ''accounts.vcifsc'')) AS X (\\"label\\", \\"value\\")",
	"masters.vpa":"SELECT X.* FROM   (VALUES (''vpaname'', ''vpa.vcvpaname''),(''vcaddress'', ''vpa.vcaddress''), (''mcc'', ''vpa.imcc'')) AS X (\\"label\\", \\"value\\")"
}'::text WHERE
idashboardqueryid = 119 ;

UPDATE ui.dashboardquery SET
bparametersrequired = true::boolean WHERE
idashboardqueryid = 119 ;

UPDATE ui.dashboardquery SET
vcfilterparametersjson = '{
	"Party":null
}'::text WHERE
idashboardqueryid = 119;

INSERT INTO ui.dashboardqueryparameters (
    idashboardparameterid, vcparametername, vcparametertype, 
    idashboardqueryid, iorder, itenantid
)
SELECT 
    (select max(idashboardparameterid) + 1 from ui.dashboardqueryparameters) AS idashboardparameterid,
    'Party' AS vcparametername,
    'JsonPath' AS vcparametertype,
    119 AS idashboardqueryid,
    0 AS iorder,
    t.itenantid
FROM 
    ui.tenants t
WHERE 
    t.itenantid in (5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25);

INSERT INTO ui.dashboardquery (
    idashboardqueryid, bparametersrequired, vcfilterparametersjson, 
    vcdashboardquery, formattingrequiered, runonanalytics, transposerequired, 
    imenustructuredesc, itenantid
)
SELECT 
    151 AS idashboardqueryid,
    true AS bparametersrequired,
    '{"Party":null, "SearchField":null}'::jsonb AS vcfilterparametersjson,
    NULL AS vcdashboardquery,
    false AS formattingrequiered,
    false AS runonanalytics,
    false AS transposerequired,
    579 AS imenustructuredesc,
    t.itenantid
FROM 
    ui.tenants t
WHERE  t.itenantid in (5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25);

UPDATE ui.dashboardquery SET
vcdashboardquery =  E'{
    "masters.customers":"SELECT X.* FROM   (VALUES (''Mobile Number'', ''customers.vcregisteredmobile''),(''Email ID'', ''customers.vcemail''),(''GSTN'', ''customer.vcattribs''))  AS X (\\"label\\", \\"value\\") where value != :SearchField",
    "masters.accounts":"SELECT X.* FROM   (VALUES (''Account Number'', ''accounts.vcaccount''),(''IFSC'', ''accounts.vcifsc'')) AS X (\\"label\\", \\"value\\") where value != :SearchField",
	"masters.vpa":"SELECT X.* FROM   (VALUES (''vpaname'', ''vpa.vcvpaname''),(''vcaddress'', ''vpa.vcaddress''), (''mcc'', ''vpa.imcc'')) AS X (\\"label\\", \\"value\\") where value != :SearchField"
}'::text WHERE
idashboardqueryid = 151;

UPDATE ui.dashboardfilters SET
idashboardqueryidforoptions = '151'::integer WHERE
idashboardfilterid = 164;

INSERT INTO ui.dashboardqueryparameters (
    idashboardparameterid, vcparametername, vcparametertype, 
    idashboardqueryid, iorder, itenantid
)
SELECT 
    (select max(idashboardparameterid) + 1 from ui.dashboardqueryparameters) AS idashboardparameterid,
    'Party' AS vcparametername,
    'JsonPath' AS vcparametertype,
    151 AS idashboardqueryid,
    0 AS iorder,
    t.itenantid
FROM 
    ui.tenants t
WHERE  t.itenantid in (5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25);

INSERT INTO ui.dashboardqueryparameters (
    idashboardparameterid, vcparametername, vcparametertype, 
    idashboardqueryid, iorder, itenantid
)
SELECT 
    (select max(idashboardparameterid) + 1 from ui.dashboardqueryparameters) AS idashboardparameterid,
    'SearchField' AS vcparametername,
    'String' AS vcparametertype,
    151 AS idashboardqueryid,
    0 AS iorder,
    t.itenantid
FROM 
    ui.tenants t
WHERE t.itenantid in (5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25);

UPDATE ui.dashboardquery SET
bparametersrequired = true::boolean, vcfilterparametersjson = '{
	"Party":null
}'::text WHERE
idashboardqueryid = 149 ;


INSERT INTO ui.dashboardqueryparameters (
    idashboardparameterid, vcparametername, vcparametertype, 
    idashboardqueryid, iorder, itenantid
)
SELECT 
    (select max(idashboardparameterid) + 1 from ui.dashboardqueryparameters) AS idashboardparameterid,
    'Party' AS vcparametername,
    'JsonPath' AS vcparametertype,
    149 AS idashboardqueryid,
    0 AS iorder,
    t.itenantid
FROM 
    ui.tenants t
WHERE 
    t.itenantid in (5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25);

INSERT INTO ui.dashboardquery (
    idashboardqueryid, bparametersrequired, vcfilterparametersjson, 
    vcdashboardquery, formattingrequiered, runonanalytics, transposerequired, 
    imenustructuredesc, itenantid
)
SELECT 
    152 AS idashboardqueryid,
    true AS bparametersrequired,
    '{"Party":null, "SearchField":null}'::jsonb AS vcfilterparametersjson,
    NULL AS vcdashboardquery,
    false AS formattingrequiered,
    false AS runonanalytics,
    false AS transposerequired,
    579 AS imenustructuredesc,
    t.itenantid
FROM 
    ui.tenants t
WHERE 
    t.itenantid in (5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25);

UPDATE ui.dashboardquery SET
vcdashboardquery =  E'{
    "transactions":"SELECT X.* FROM   (VALUES (''Payee Addr'', ''payee.addr''),(''Payer Addr'', ''payer.addr''),(''Txn ID'', ''txn.id''))  AS X (\\"label\\", \\"value\\") where value != :SearchField"
  }'::text WHERE
idashboardqueryid = 152 ;

INSERT INTO ui.dashboardqueryparameters (
    idashboardparameterid, vcparametername, vcparametertype, 
    idashboardqueryid, iorder, itenantid
)
SELECT 
    (select max(idashboardparameterid) + 1 from ui.dashboardqueryparameters) AS idashboardparameterid,
    'Party' AS vcparametername,
    'JsonPath' AS vcparametertype,
    152 AS idashboardqueryid,
    0 AS iorder,
    t.itenantid
FROM 
    ui.tenants t
WHERE t.itenantid in (5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25);

INSERT INTO ui.dashboardqueryparameters (
    idashboardparameterid, vcparametername, vcparametertype, 
    idashboardqueryid, iorder, itenantid
)
SELECT 
    (select max(idashboardparameterid) + 1 from ui.dashboardqueryparameters) AS idashboardparameterid,
    'SearchField' AS vcparametername,
    'String' AS vcparametertype,
    152 AS idashboardqueryid,
    0 AS iorder,
    t.itenantid
FROM 
    ui.tenants t
WHERE  t.itenantid in (5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25);

UPDATE ui.dashboardquery SET
vcdashboardquery = 'SELECT * FROM masters.get_nodewithvcattribs(:Party, ARRAY[:SearchField], :VpaAddress, :DisplayField);
'::text WHERE
idashboardqueryid = 120;

UPDATE ui.dashboardfilters SET
vcdashboardfilterdisplayname = 'Search Value'::character varying WHERE
idashboardfilterid = 163 ;