UPDATE
ui.dashboardquery
SET
vcdashboardquery = 'SELECT ''All'' AS "label", ''All'' AS "value" union all (select DISTINCT vcclassname as "label", vcclassname as "value" FROM masters.transactionclasses where bactive=true  ORDER BY label)'
WHERE
idashboardqueryid = 34;


UPDATE
ui.dashboardquery
SET
vcdashboardquery = 'SELECT ''All'' AS "label", ''All'' AS "value" union all (select DISTINCT vcdecisionname as "label", vcdecisionname as "value" FROM masters.decisions where bactive=true  ORDER BY label)'
WHERE
idashboardqueryid = 35;


UPDATE
ui.dashboardquery
SET
vcdashboardquery = 'SELECT ''All'' AS "label", ''All'' AS "value" union all (select DISTINCT vcrulename as "label", vcrulename as "value" FROM masters.rules where bactive=true  ORDER BY label)'
WHERE
idashboardqueryid = 36;