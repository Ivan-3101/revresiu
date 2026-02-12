delete from ui.dashboardqueryparameters where idashboardqueryid in (170,169,168);

delete from ui.dashboardquery where idashboardqueryid in (170,169,168);

delete from ui.dashboardqueryparameters where idashboardqueryid in (145) and itenantid != 10;

delete from ui.dashboardquery where idashboardqueryid in (145) and itenantid != 10;