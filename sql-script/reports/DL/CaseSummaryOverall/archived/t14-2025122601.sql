-- DELETE SCRIPTS

DELETE FROM ui.dashboardresultset WHERE idashboardqueryid = 177 AND itenantid = 14;

DELETE FROM ui.dashboardqueryparameters WHERE idashboardqueryid = 177 AND itenantid = 14;

DELETE FROM ui.dashboardfilters WHERE idashboardid = 84 AND itenantid = 14;

DELETE FROM ui.dashboardquery WHERE idashboardqueryid = 177 AND itenantid = 14;

DELETE FROM ui.dashboard WHERE idashboardid = 84 AND itenantid = 14;