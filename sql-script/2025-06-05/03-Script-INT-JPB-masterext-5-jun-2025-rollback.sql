
DELETE FROM ui.dashboardqueryparameters 
WHERE idashboardqueryid = '164'::integer AND itenantid = '12'::integer;

DELETE FROM ui.dashboardfilters 
WHERE idashboardid = '78'::integer AND itenantid = '12'::integer;

DELETE FROM ui.dashboardresultset 
WHERE idashboardid = '78'::integer AND itenantid = '12'::integer;

DELETE FROM ui.dashboardquery 
WHERE idashboardqueryid = '164'::integer AND itenantid = '12'::integer;

DELETE FROM ui.dashboard 
WHERE idashboardid = '78'::integer AND itenantid = '12'::integer;
