
DELETE FROM ui.dashboardresultset
WHERE idashboardqueryid = 161 AND idashboardid = 75 AND itenantid = 12;

DELETE FROM ui.dashboardqueryparameters
WHERE idashboardqueryid = 161 AND itenantid = 12;

DELETE FROM ui.dashboardquery
WHERE idashboardqueryid = 161 AND itenantid = 12;

DELETE FROM ui.dashboardfilters
WHERE idashboardid = 75 AND itenantid = 12;

DELETE FROM ui.dashboard
WHERE idashboardid = 75 AND itenantid = 12;
