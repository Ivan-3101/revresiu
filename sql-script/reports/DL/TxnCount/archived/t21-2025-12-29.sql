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
    FROM t21refined.analytics.trans tx
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
idashboardqueryid = 174 AND itenantid = 21;