
DELETE FROM ui.dashboardresultset
WHERE idashboardqueryid = 162 AND itenantid = 14;

DELETE FROM ui.dashboardqueryparameters
WHERE idashboardqueryid = 162 AND itenantid = 14;

DELETE FROM ui.dashboardquery
WHERE idashboardqueryid = 162 AND itenantid = 14;

DELETE FROM ui.dashboardfilters
WHERE idashboardid = 76 AND itenantid = 14;

DELETE FROM ui.dashboard
WHERE idashboardid = 76 AND itenantid = 14;
