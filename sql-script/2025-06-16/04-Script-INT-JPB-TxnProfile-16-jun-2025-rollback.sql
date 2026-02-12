
DELETE FROM ui.dashboardqueryparameters 
WHERE idashboardqueryid = '173'::integer AND itenantid = '12'::integer;

DELETE FROM ui.dashboardfilters 
WHERE idashboardid = '81'::integer AND itenantid = '12'::integer;

DELETE FROM ui.dashboardresultset 
WHERE idashboardid = '81'::integer AND itenantid = '12'::integer;

DELETE FROM ui.dashboardquery 
WHERE idashboardqueryid = '173'::integer AND itenantid = '12'::integer;

DELETE FROM ui.dashboard 
WHERE idashboardid = '81'::integer AND itenantid = '12'::integer;
