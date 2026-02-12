UPDATE ui.dashboardquery SET
vcdashboardquery = 'SELECT NOW() as "startdate", NOW() as "enddate";'::text WHERE
idashboardqueryid = 16;

UPDATE ui.dashboardfilters
	SET idashboardqueryidfordefaultvalue=32
	WHERE  vcdashboardfiltertype = 'DateRangePicker'  and idashboardid in (14, 17);
