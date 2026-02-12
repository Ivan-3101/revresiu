DELETE FROM ui.dashboardqueryparameters 
WHERE idashboardqueryid = '175'::integer AND itenantid = '14'::integer;

DELETE FROM ui.dashboardfilters 
WHERE idashboardid = '83'::integer AND itenantid = '14'::integer;

DELETE FROM ui.dashboardresultset 
WHERE idashboardid = '83'::integer AND itenantid = '14'::integer;

DELETE FROM ui.dashboardquery 
WHERE idashboardqueryid = '175'::integer AND itenantid = '14'::integer;

DELETE FROM ui.dashboard 
WHERE idashboardid = '83'::integer AND itenantid = '14'::integer;
