delete from ui.dashboardqueryparameters where idashboardqueryid in (160,161,162,164) and itenantid in (8,17,21,22);

delete from ui.dashboardfilters where idashboardid in (74,75,76,78) and itenantid in (8,17,21,22);

delete from ui.dashboardresultset where idashboardqueryid in (160,161,162,164) and itenantid in (8,17,21,22);

delete from ui.dashboardquery where idashboardqueryid in (160,161,162,164) and itenantid in (8,17,21,22);


delete from ui.dashboard where idashboardid in (74,75,76,78) and itenantid in (8,17,21,22);


------------txn db

delete from ui.dashboardqueryparameters where idashboardqueryid = 159 and itenantid in (8,21,22);

delete from ui.dashboardfilters where idashboardid = 73 and itenantid in (8,21,22);

delete from ui.dashboardresultset where idashboardqueryid = 159 and itenantid in (8,21,22);

delete from ui.dashboardquery where idashboardqueryid = 159 and itenantid in (8,21,22);


delete from ui.dashboard where idashboardid = 73 and itenantid in (8,21,22);

------------closed cases repo

delete from ui.dashboardqueryparameters where idashboardqueryid = 171 and itenantid in (17,8,21,22);

delete from ui.dashboardfilters where idashboardid = 79 and itenantid in (17,8,21,22);

delete from ui.dashboardresultset where idashboardqueryid = 171 and itenantid in (17,8,21,22);

delete from ui.dashboardquery where idashboardqueryid = 171 and itenantid in (17,8,21,22);


delete from ui.dashboard where idashboardid = 79 and itenantid in (17,8,21,22);