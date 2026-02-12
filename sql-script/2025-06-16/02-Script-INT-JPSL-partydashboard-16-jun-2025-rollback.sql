
DELETE FROM ui.dashboardqueryparameters 
WHERE idashboardqueryid = '172'::integer AND itenantid = '14'::integer;

DELETE FROM ui.dashboardfilters 
WHERE idashboardid = '80'::integer AND itenantid = '14'::integer;

DELETE FROM ui.dashboardresultset 
WHERE idashboardid = '80'::integer AND itenantid = '14'::integer;

DELETE FROM ui.dashboardquery 
WHERE idashboardqueryid = '172'::integer AND itenantid = '14'::integer;

DELETE FROM ui.dashboard 
WHERE idashboardid = '80'::integer AND itenantid = '14'::integer;
