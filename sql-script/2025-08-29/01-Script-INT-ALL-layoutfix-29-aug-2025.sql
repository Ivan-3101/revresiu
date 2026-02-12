delete FROM ui.dashboardcustomlayoutaudit where iresultsetid in (select idashboardresultsetid  FROM ui.dashboardresultset
where idashboardqueryid= 62 and   itenantid not in (10, 27)) and itenantid not in (10, 27);

delete FROM ui.dashboardcustomlayout where iresultsetid in (select idashboardresultsetid  FROM ui.dashboardresultset
where idashboardqueryid= 62 and   itenantid not in (10, 27)) and itenantid not in (10, 27);
