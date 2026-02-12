----bapa

INSERT INTO ui.dashboard VALUES (75, true, false, 'Rule Efficiency Report - DL', 6, 1, 510, 12, true);


INSERT INTO ui.dashboardfilters VALUES ((SELECT max(idashboardfilterid)+1 FROM ui.dashboardfilters), 0, 'DateRange', 75, 'DateRangePicker', 32, NULL, 12, 'Date Range');


 INSERT INTO ui.dashboardquery VALUES (161, true, '{"DateRange" : null}', 'SELECT 
    rp.tdate AS "Date", 
    d.vcdecisionname AS "Decision", 
    rp.vcclassname AS "Class", 
    rp.iruleid AS "Rule ID",  
    r.vcrulename AS "Rule Name",
    rp.score AS "Score", 
    rp.scoretxncount AS "Rule Triggered Count", 
    rp.totaltxncount AS "Total Txn Count",
    ROUND(CAST((CAST(rp.scoretxncount AS DOUBLE) * 100) / rp.totaltxncount AS DECIMAL), 2) AS "Rule Efficiency (%)",
    ROUND(CAST((CAST(rp.override_txncount AS DOUBLE) * 100) / NULLIF(rp.scoretxncount, 0) AS DECIMAL), 2) AS "False Alert %",
    rp.scoretxnvalue / NULLIF(rp.scoretxncount, 0) AS "Avg Value (Rules Triggered)",
    rp.totaltxnvalue / NULLIF(rp.totaltxncount, 0) AS "Avg Value (Total Txns)",
    rp.accounts_affected AS "Unique Accounts Triggered",
    rp.vpas_affected AS "Unique VPAs Affected"
FROM landing.analytics.rule_performance rp
LEFT JOIN landing.masters.rules r ON r.iruleid = rp.iruleid
LEFT JOIN landing.masters.decisions d ON d.idecisionid = rp.idecisionid 
WHERE rp.tdate BETWEEN CAST(:StartDate AS DATE) AND CAST(:EndDate AS DATE) 
AND rp.score > 0 
AND rp.itenantid = :tenantid 
LIMIT 10000', false, true, NULL, 510, 12, 3);

INSERT INTO ui.dashboardqueryparameters VALUES ((SELECT max(idashboardparameterid)+1 FROM ui.dashboardqueryparameters), 'DateRange', 'DateRange', 161, NULL, 12);

INSERT INTO ui.dashboardresultset VALUES ((SELECT max(idashboardresultsetid)+1 FROM ui.dashboardresultset), NULL, NULL, '{"sizes":[1],"detail":{"main":{"type":"tab-area","widgets":["PERSPECTIVE_GENERATED_ID_1"],"currentIndex":0}},"mode":"globalFilters","viewers":{"PERSPECTIVE_GENERATED_ID_1":{"plugin":"Datagrid","plugin_config":{"columns":{},"editable":false,"scroll_lock":true},"settings":false,"theme":"Pro Dark","title":"Rule Efficiency Report","group_by":[],"split_by":[],"columns":["Date","Decision","Class","Rule Name","Score","Rule Triggered Count","Total Txn Count","Rule Efficiency (%)","False Alert %","Unique Accounts Triggered","Avg Value (Total Txns)","Avg Value (Rules Triggered)","Rule ID"],"filter":[],"sort":[["Unique Accounts Triggered","desc"]],"expressions":[],"aggregates":{},"master":false,"table":"ruleefficiencyreport","linked":false}}} ', 'ruleefficiencyreport', 161, 75, '{
"Date":"date",
"Decision":"string",
"Class":"string",
"Rule ID":"integer",
"Rule Name":"string",
"Score":"integer",
"Rule Triggered Count":"integer",
"Total Txn Count":"integer",
"Rule Efficiency (%)":"float",
"Avg Value (Rules Triggered)":"float",
"Avg Value (Total Txns)":"float",
"False Alert %":"float",
"Unique Accounts Triggered":"integer",
"Unique VPAs Affected":"integer"
}', NULL, 1, NULL, NULL, 510, 12, 5);

--------
UPDATE ui.dashboardquery SET
vcdashboardquery = 'SELECT
    rp.tdate AS "Date", 
    d.vcdecisionname AS "Decision", 
    rp.vcclassname AS "Class", 
    rp.iruleid AS "Rule ID",  
    r.vcrulename AS "Rule Name",
    rp.score AS "Score", 
    rp.scoretxncount AS "Rule Triggered Count", 
    rp.totaltxncount AS "Total Txn Count",
    ROUND(CAST((CAST(rp.scoretxncount AS DOUBLE) * 100) / rp.totaltxncount AS DECIMAL), 2) AS "Rule Efficiency (%)",
    ROUND(CAST((CAST(rp.override_txncount AS DOUBLE) * 100) / NULLIF(rp.scoretxncount, 0) AS DECIMAL), 2) AS "False Alert %",
    rp.scoretxnvalue / NULLIF(rp.scoretxncount, 0) AS "Avg Value (Rules Triggered)",
    rp.totaltxnvalue / NULLIF(rp.totaltxncount, 0) AS "Avg Value (Total Txns)",
    rp.accounts_affected AS "Unique Accounts Triggered",
    rp.vpas_affected AS "Unique VPAs Affected"
FROM t12refined.analytics.rule_performance rp
LEFT JOIN postgresql.masters.rules r ON r.iruleid = rp.iruleid
LEFT JOIN postgresql.masters.decisions d ON d.idecisionid = rp.idecisionid 
WHERE rp.tdate BETWEEN CAST(:StartDate AS DATE) AND CAST(:EndDate AS DATE) 
AND rp.score > 0 
AND rp.itenantid = :tenantid 
LIMIT 10000'::text WHERE
idashboardqueryid = 161 AND itenantid in (12);


UPDATE ui.dashboardquery SET
vcdashboardquery = 'SELECT
    rp.tdate AS "Date",
    d.vcdecisionname AS "Decision",
    rp.vcclassname AS "Class",
    rp.iruleid AS "Rule ID",
    r.vcrulename AS "Rule Name",
    rp.score AS "Score",
    rp.scoretxncount AS "Rule Triggered Count",
    rp.totaltxncount AS "Total Txn Count",
    ROUND(CAST((CAST(rp.scoretxncount AS DOUBLE) * 100) / rp.totaltxncount AS DECIMAL), 2) AS "Rule Efficiency (%)",
    ROUND(CAST((CAST(rp.override_txncount AS DOUBLE) * 100) / NULLIF(rp.scoretxncount, 0) AS DECIMAL), 2) AS "False Alert %",
    rp.scoretxnvalue / NULLIF(rp.scoretxncount, 0) AS "Avg Value (Rules Triggered)",
    rp.totaltxnvalue / NULLIF(rp.totaltxncount, 0) AS "Avg Value (Total Txns)",
    rp.accounts_affected AS "Unique Accounts Triggered",
    rp.vpas_affected AS "Unique VPAs Affected"
FROM t12refined.analytics.rule_performance rp
LEFT JOIN postgresql.masters.rules r ON r.iruleid = rp.iruleid
LEFT JOIN postgresql.masters.decisions d ON d.idecisionid = rp.idecisionid
WHERE rp.tdate BETWEEN CAST(:StartDate AS DATE) AND CAST(:EndDate AS DATE)
AND rp.score > 0
AND rp.itenantid = :tenantid
LIMIT 10000'::text WHERE
idashboardqueryid = 161 AND itenantid in (12);