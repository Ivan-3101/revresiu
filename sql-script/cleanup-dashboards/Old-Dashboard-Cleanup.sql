DELETE FROM ui.dashboardresultset WHERE idashboardid = 1;
DELETE FROM ui.dashboardfilters WHERE idashboardid = 1;
DELETE FROM ui.dashboard WHERE idashboardid = 1;

DELETE FROM ui.dashboardresultset WHERE idashboardid = 6;
DELETE FROM ui.dashboardfilters WHERE idashboardid = 6;
DELETE FROM ui.dashboard WHERE idashboardid = 6;

DELETE FROM ui.dashboardresultset WHERE idashboardid = 10;
DELETE FROM ui.dashboardfilters WHERE idashboardid = 10;
DELETE FROM ui.dashboard WHERE idashboardid = 10;


DELETE FROM ui.dashboardqueryparameters WHERE idashboardqueryid
not in (select idashboardqueryid as "t" from ui.dashboardresultset where idashboardqueryid is not null
union
select idashboardqueryidfordefaultvalue as "t" from ui.dashboardfilters where idashboardqueryidfordefaultvalue is not null
union
select idashboardqueryidforoptions from ui.dashboardfilters where idashboardqueryidforoptions is not null);

DELETE FROM ui.dashboardquery WHERE idashboardqueryid
not in (select idashboardqueryid as "t" from ui.dashboardresultset where idashboardqueryid is not null
union
select idashboardqueryidfordefaultvalue as "t" from ui.dashboardfilters where idashboardqueryidfordefaultvalue is not null
union
select idashboardqueryidforoptions from ui.dashboardfilters where idashboardqueryidforoptions is not null);


DELETE FROM ui.rolemenuaccessmap WHERE imenuid = (SELECT imenuid FROM ui.menustructuredesc WHERE vcmenuname = 'Transaction DB Old');
DELETE FROM ui.rolemenuaccessmap WHERE imenuid = (SELECT imenuid FROM ui.menustructuredesc WHERE vcmenuname = 'Party Dashboard Old');
DELETE FROM ui.rolemenuaccessmap WHERE imenuid = (SELECT imenuid FROM ui.menustructuredesc WHERE vcmenuname = 'Transaction Profile-old');
DELETE FROM ui.rolemenuaccessmap WHERE imenuid = (SELECT imenuid FROM ui.menustructuredesc WHERE vcmenuname = 'Test DB 1');
DELETE FROM ui.rolemenuaccessmap WHERE imenuid = (SELECT imenuid FROM ui.menustructuredesc WHERE vcmenuname = 'Test DB 2');

DELETE FROM ui.menustructuredesc WHERE vcmenuname = 'Transaction DB Old';
DELETE FROM ui.menustructuredesc WHERE vcmenuname = 'Party Dashboard Old';
DELETE FROM ui.menustructuredesc WHERE vcmenuname = 'Transaction Profile-old';
DELETE FROM ui.menustructuredesc WHERE vcmenuname = 'Test DB 1';
DELETE FROM ui.menustructuredesc WHERE vcmenuname = 'Test DB 2';