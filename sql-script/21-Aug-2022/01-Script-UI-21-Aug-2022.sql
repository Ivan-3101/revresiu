UPDATE ui.dashboardquery
	SET  vcfilterparametersjson='{"DateRange" : null, "VpaAddress":null, "Type":null, "Party": null}', vcdashboardquery='Select * from masters.getlivedata(:Type, :StartDate, :EndDate, :VpaAddress, :timeZone, :Party, 1000);'
	WHERE idashboardqueryid=7;


UPDATE ui.dashboardfilters
SET  vcdashboardfiltername='DateRange', vcdashboardfiltertype='DateRangePicker', vcdashboardfilterdisplayname='Date Range'
WHERE idashboardfilterid=1;

UPDATE ui.dashboardquery
SET  vcdashboardquery='select dtTrxnTime as "Time" from transactions.vw_LiveTrans order by dtTrxnTime desc limit 1'
WHERE idashboardqueryid=16;

UPDATE ui.dashboardqueryparameters
SET vcparametername='DateRange', vcparametertype='DateRange'
WHERE idashboardparameterid=6;