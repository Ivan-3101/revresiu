
INSERT INTO ui.dashboard (
idashboardid, bactive, bdelete, vcdashboardname, iorder, irowcount, imenustructuredesc, itenantid, bdynamic) VALUES (
'82'::integer, true::boolean, false::boolean, 'Txn Count Report - DL'::character varying, '10'::integer, '1'::integer, '577'::integer, '14'::integer, true::boolean)
 returning idashboardid,itenantid;

INSERT INTO ui.dashboardquery (
idashboardqueryid, bparametersrequired, vcfilterparametersjson, vcdashboardquery, formattingrequiered, runonanalytics, transposerequired, imenustructuredesc, itenantid, dbtype) VALUES (
'174'::integer, true::boolean, '{"DateRange":null}'::text, 'SELECT "Date",
"Class",
SUM ("Txns Failed to Process") AS "Txns Failed to Process",
SUM("Txns Processed Successfully") AS "Txns Processed Successfully" ,
SUM("Txns Failed to Process") + SUM("Txns Processed Successfully") AS "Txn Requests Received"
FROM
(select
date(sr.dtentrydatetime) as "Date",
cast(vcrequestdata as json)->''txn''->>''class'' as "Class",
case when sr.vcrequestid is null then 0 else 1 end  as "Txns Failed to Process",
case when sr.vcrequestid is null then 1 else 0 end  as "Txns Processed Successfully"
from
analytics.scorerequests sr
WHERE sr.dtentrydatetime between :StartDate and :EndDate and sr.itenantid = :tenantid
UNION ALL
select
date(tx.dttrxntime) as "Date",
tx.vcclassname as "Class",
case when tx.vcmsgid is null then 1 else 0 end  as "Txns Failed to Process",
case when tx.vcmsgid is null then 0 else 1 end  as "Txns Processed Successfully"
from
analytics.trans tx
WHERE tx.dttrxntime between :StartDate and :EndDate and tx.itenantid = :tenantid
 ) T GROUP BY "Date",
"Class" limit 10000;'::text, false::boolean, true::boolean, false::boolean, '577'::integer, '14'::integer, '3'::integer)
 returning idashboardqueryid,itenantid;

INSERT INTO ui.dashboardresultset (
idashboardresultsetid, vcdashboardresultsetlayout, vcdashboardresultsetname, idashboardqueryid, idashboardid, vcdashboardresultsetschema, irowno, imenustructuredesc, itenantid, iorgid) VALUES (
(SELECT max(idashboardresultsetid)+1 FROM ui.dashboardresultset), '{"sizes":[1],"detail":{"main":{"type":"tab-area","widgets":["PERSPECTIVE_GENERATED_ID_1"],"currentIndex":0}},"mode":"globalFilters","viewers":{"PERSPECTIVE_GENERATED_ID_1":{"plugin":"Datagrid","plugin_config":{"columns":{},"editable":false,"scroll_lock":false},"settings":false,"theme":"Pro Dark","title":"Txn Count Report","group_by":[],"split_by":[],"columns":["Date", "Class", "Txn Count"],"filter":[],"sort":[],"expressions":[],"aggregates":{},"master":false,"table":"transaction","linked":false}}}
'::text, 'transaction'::character varying, '174'::integer, '82'::integer, '{"Date":"date", "Class":"string", "Txn Requests Received":"integer","Txns Failed to Process":"integer","Txns Processed Successfully":"integer" }'::text, '1'::integer, '577'::integer, '14'::integer, '5'::integer)
 returning idashboardresultsetid,itenantid;

 INSERT INTO ui.dashboardqueryparameters (
idashboardparameterid, vcparametername, vcparametertype, idashboardqueryid, itenantid) VALUES (
( SELECT max(idashboardparameterid) + 1 FROM ui.dashboardqueryparameters), 'DateRange'::character varying, 'DateRange'::character varying, '174'::integer, '14'::integer)
 returning idashboardparameterid,itenantid;

 INSERT INTO ui.dashboardfilters (
idashboardfilterid, ifilterorder, vcdashboardfiltername, idashboardid, vcdashboardfiltertype, idashboardqueryidfordefaultvalue, itenantid, vcdashboardfilterdisplayname) VALUES (
(SELECT max(idashboardfilterid)+1 FROM ui.dashboardfilters), '0'::integer, 'DateRange'::character varying, '82'::integer, 'DateRangePicker'::character varying, '79'::integer, '14'::integer, 'Date Range'::character varying)
 returning idashboardfilterid,itenantid;

UPDATE ui.dashboardquery SET
vcdashboardquery = '
WITH optimized_scorerequests AS (
    SELECT 
        DATE(sr.dtentrydatetime) AS "Date",
        JSON_EXTRACT_SCALAR(sr.vcrequestdata, ''$.txn.class'') AS "Class",
        CASE 
            WHEN sr.vcrequestid IS NULL THEN 0 
            ELSE 1 
        END AS "Txns Failed to Process",
        CASE 
            WHEN sr.vcrequestid IS NULL THEN 1 
            ELSE 0 
        END AS "Txns Processed Successfully"
    FROM postgresql.analytics.scorerequests sr
    WHERE sr.dtentrydatetime BETWEEN :StartDate AND :EndDate
      AND sr.itenantid = :tenantid
),
optimized_trans AS (
    SELECT 
        DATE(tx.tdate) AS "Date",  
        tx.vcclassname AS "Class",
        CASE 
            WHEN tx.vcmsgid IS NULL THEN 1 
            ELSE 0 
        END AS "Txns Failed to Process",
        CASE 
            WHEN tx.vcmsgid IS NULL THEN 0 
            ELSE 1 
        END AS "Txns Processed Successfully"
    FROM t14refined.analytics.trans tx
    WHERE tx.tdate BETWEEN :StartDate AND :EndDate 
      AND tx.itenantid = :tenantid
     
)
SELECT 
    "Date", 
    "Class", 
    SUM("Txns Failed to Process") AS "Txns Failed to Process", 
    SUM("Txns Processed Successfully") AS "Txns Processed Successfully",
    SUM("Txns Failed to Process") + SUM("Txns Processed Successfully") AS "Txn Requests Received"
FROM (
    SELECT * FROM optimized_scorerequests
    UNION ALL
    SELECT * FROM optimized_trans
) T
GROUP BY "Date", "Class"
limit 10000'::text WHERE
idashboardqueryid = 174 AND itenantid = 14;



