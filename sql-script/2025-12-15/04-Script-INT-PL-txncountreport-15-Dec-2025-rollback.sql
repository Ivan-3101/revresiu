UPDATE ui.dashboardquery SET
vcdashboardquery = 'SELECT
    "Date",
    "Class",
    SUM("Txns Failed to Process") AS "Txns Failed to Process",
    SUM("Txns Processed Successfully") AS "Txns Processed Successfully",
    SUM("Txns Failed to Process")
        + SUM("Txns Processed Successfully") AS "Txn Requests Received"
FROM (
    SELECT
        DATE(sr.dtentrydatetime) AS "Date",
        CAST(vcrequestdata AS JSON)->''txn''->>''class'' AS "Class",
        CASE
            WHEN sr.vcrequestid IS NULL THEN 0
            ELSE 1
        END AS "Txns Failed to Process",
        CASE
            WHEN sr.vcrequestid IS NULL THEN 1
            ELSE 0
        END AS "Txns Processed Successfully"
    FROM analytics.scorerequests sr
    WHERE sr.dtentrydatetime BETWEEN :StartDate AND :EndDate
      AND sr.itenantid = :tenantid

    UNION ALL

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
    FROM analytics.trans tx
    WHERE tx.dttrxntime BETWEEN :StartDate AND :EndDate
      AND tx.itenantid = :tenantid
) T
GROUP BY
    "Date",
    "Class"
LIMIT 10000; '::text WHERE
itenantid = 10 AND idashboardqueryid = 80;