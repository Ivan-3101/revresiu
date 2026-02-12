
DELETE FROM ui.dashboardfilters
WHERE idashboardid = '73' AND itenantid = '14';

DELETE FROM ui.dashboardqueryparameters 
WHERE idashboardqueryid = '159' AND itenantid = '14';


DELETE FROM ui.dashboardresultset
WHERE idashboardqueryid = '159' AND idashboardid = '73' AND itenantid = '14';

DELETE FROM ui.dashboardquery
WHERE idashboardqueryid = '159' AND itenantid = '14';

DELETE FROM ui.dashboard
WHERE idashboardid = '73' AND itenantid = '14';
