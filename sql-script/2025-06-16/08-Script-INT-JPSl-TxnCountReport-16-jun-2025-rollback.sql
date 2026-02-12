
DELETE FROM ui.dashboardqueryparameters 
WHERE idashboardqueryid = '174'::integer AND itenantid = '14'::integer;

DELETE FROM ui.dashboardfilters 
WHERE idashboardid = '82'::integer AND itenantid = '14'::integer;

DELETE FROM ui.dashboardresultset 
WHERE idashboardid = '82'::integer AND itenantid = '14'::integer;

DELETE FROM ui.dashboardquery 
WHERE idashboardqueryid = '174'::integer AND itenantid = '14'::integer;

DELETE FROM ui.dashboard 
WHERE idashboardid = '82'::integer AND itenantid = '14'::integer;
