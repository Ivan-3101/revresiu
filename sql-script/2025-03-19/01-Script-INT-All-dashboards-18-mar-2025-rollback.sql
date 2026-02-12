update ui.dashboardfilters set idashboardqueryidforoptions=27
where idashboardid in (15,21,17) and vcdashboardfiltername in ('Party', 'Level' );


delete from ui.dashboardquery where  idashboardqueryid = 165;

