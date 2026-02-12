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
        DATE(tx.dttrxntime) AS "Date",  
        tx.vcclassname AS "Class",
        CASE 
            WHEN tx.vcmsgid IS NULL THEN 1 
            ELSE 0 
        END AS "Txns Failed to Process",
        CASE 
            WHEN tx.vcmsgid IS NULL THEN 0 
            ELSE 1 
        END AS "Txns Processed Successfully"
    FROM t22refined.analytics.trans tx
    WHERE tx.dttrxntime BETWEEN :StartDate AND :EndDate
      AND tx.itenantid = :tenantid
),
optimized_transaction_scorerequests AS (
    SELECT 
        DATE(tsr.dtentrydatetime) AS "Date",
        JSON_EXTRACT_SCALAR(tsr.vcrequestdata, ''$.txn.class'') AS "Class",
        CASE 
            WHEN tsr.vcrequestid IS NULL THEN 0 
            ELSE 1 
        END AS "Txns Failed to Process",
        CASE 
            WHEN tsr.vcrequestid IS NULL THEN 1 
            ELSE 0 
        END AS "Txns Processed Successfully"
    FROM postgresql.transactions.scorerequests tsr
    WHERE tsr.dtentrydatetime BETWEEN :StartDate AND :EndDate
      AND tsr.itenantid = :tenantid
      AND NOT EXISTS (
           SELECT 1 
    FROM postgresql.analytics.scorerequests sr 
    WHERE sr.vcrequestid = tsr.vcrequestid 
      AND sr.itenantid = tsr.itenantid
      )
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
    UNION ALL
    SELECT * FROM optimized_transaction_scorerequests
) T
GROUP BY "Date", "Class"
LIMIT 10000'::text WHERE
idashboardqueryid = 174 AND itenantid = 22;