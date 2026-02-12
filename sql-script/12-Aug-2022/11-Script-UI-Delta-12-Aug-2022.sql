UPDATE ui.dashboardqueryparameters
SET vcparametername='Date', vcparametertype='Date'
WHERE idashboardparameterid=6;

UPDATE ui.dashboardfilters
SET  vcdashboardfiltername='Date', vcdashboardfiltertype='DatePicker', vcdashboardfilterdisplayname='Date'
WHERE idashboardfilterid=1;

UPDATE ui.dashboardquery
SET  vcfilterparametersjson='{"Date" : null, "VpaAddress":null, "Type":null, "Party": null}', vcdashboardquery='Select * from masters.getlivedata(:Type, :Date, :VpaAddress, :timeZone, :Party, 1000);'
WHERE idashboardqueryid=7;

UPDATE ui.dashboardquery
SET  vcdashboardquery='select cast(dtTrxnTime as date) as "Time" from transactions.vw_LiveTrans order by dtTrxnTime desc limit 1'
WHERE idashboardqueryid=16;