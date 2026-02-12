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
    WHERE sr.dtentrydatetime between :StartDate and :EndDate and sr.itenantid = :tenantid

    UNION ALL

    SELECT
        DATE(tx.dttrxntime) AS "Date",
        tx.vcclassname AS "Class",
        0 AS "Txns Failed to Process",
        1 AS "Txns Processed Successfully"
    FROM analytics.trans tx
    WHERE tx.dttrxntime between :StartDate and :EndDate and tx.itenantid = :tenantid
) T
GROUP BY
    "Date",
    "Class"
LIMIT 10000;'::text WHERE
itenantid = 10 AND idashboardqueryid = 80;
