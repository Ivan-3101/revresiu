
DELETE FROM ui.dashboardresultset
WHERE idashboardqueryid = 171 AND itenantid = 14;

DELETE FROM ui.dashboardfilters
WHERE idashboardid = 79 AND itenantid = 14;

DELETE FROM ui.dashboardqueryparameters
WHERE idashboardqueryid = 171 AND itenantid = 14;

DELETE FROM ui.dashboardquery
WHERE idashboardqueryid = 171 AND itenantid = 14;

DELETE FROM ui.dashboard
WHERE idashboardid = 79 AND itenantid = 14;
