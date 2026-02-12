
UPDATE ui.dashboardfilters SET vcdashboardfilterdisplayname = 'Score ( >= )' WHERE idashboardfilterid = 26;


UPDATE
ui.dashboardquery
SET
vcdashboardquery = 'select vcclassname as "label", vcclassname as "value" FROM masters.transactionclasses where bactive=true ORDER BY label'
WHERE
idashboardqueryid = 34;


UPDATE
ui.dashboardquery
SET
vcdashboardquery = 'select vcdecisionname as "label", vcdecisionname as "value" FROM masters.decisions where bactive=true ORDER BY label'
WHERE
idashboardqueryid = 35;


UPDATE
ui.dashboardquery
SET
vcdashboardquery = 'select vcrulename as "label", vcrulename as "value" FROM masters.rules where bactive=true ORDER BY label'
WHERE
idashboardqueryid = 36;