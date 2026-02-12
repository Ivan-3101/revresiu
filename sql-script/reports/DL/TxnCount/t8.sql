UPDATE ui.dashboardquery SET
vcdashboardquery = '
WITH optimized_scorerequests AS (
    SELECT 
        DATE(sr.dtentrydatetime) AS date_val,
        JSON_EXTRACT_SCALAR(sr.vcrequestdata, ''$.txn.class'') AS class_val,
        COUNT(CASE WHEN sr.vcrequestid IS NULL THEN 1 END) AS failed_count,
        COUNT(CASE WHEN sr.vcrequestid IS NOT NULL THEN 1 END) AS success_count
    FROM postgresql.analytics.scorerequests sr
    WHERE sr.dtentrydatetime >= CAST(:StartDate AS DATE) 
      AND sr.dtentrydatetime < CAST(:EndDate AS DATE)
      AND sr.itenantid = :tenantid
    GROUP BY 
        DATE(sr.dtentrydatetime),
        JSON_EXTRACT_SCALAR(sr.vcrequestdata, ''$.txn.class'')
),
optimized_trans AS (
    SELECT 
        DATE(tx.tdate) AS date_val,
        tx.vcclassname AS class_val,
        COUNT(CASE WHEN tx.vcmsgid IS NULL THEN 1 END) AS failed_count,
        COUNT(CASE WHEN tx.vcmsgid IS NOT NULL THEN 1 END) AS success_count
    FROM t8refined.analytics.trans tx
    WHERE tx.tdate >= CAST(:StartDate AS DATE) 
      AND tx.tdate < CAST(:EndDate AS DATE)
    GROUP BY 
        DATE(tx.tdate),
        tx.vcclassname
)
SELECT 
    date_val AS "Date",
    class_val AS "Class",
    SUM(failed_count) AS "Txns Failed to Process",
    SUM(success_count) AS "Txns Processed Successfully",
    SUM(failed_count + success_count) AS "Txn Requests Received"
FROM (
    SELECT * FROM optimized_scorerequests
    UNION ALL
    SELECT * FROM optimized_trans
) T
GROUP BY date_val, class_val
ORDER BY date_val, class_val
LIMIT 10000'::text WHERE
idashboardqueryid = 174 AND itenantid = 8;