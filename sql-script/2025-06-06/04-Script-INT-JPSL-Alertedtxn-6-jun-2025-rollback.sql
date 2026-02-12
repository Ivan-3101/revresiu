
DELETE FROM ui.dashboardqueryparameters 
WHERE idashboardqueryid = '160' AND itenantid = '14';

DELETE FROM ui.dashboardfilters 
WHERE idashboardid = '74' AND itenantid = '14';

DELETE FROM ui.dashboardresultset 
WHERE idashboardid = '74' AND itenantid = '14';

DELETE FROM ui.dashboardquery 
WHERE idashboardqueryid = '160' AND itenantid = '14';

DELETE FROM ui.dashboard 
WHERE idashboardid = '74' AND itenantid = '14';
