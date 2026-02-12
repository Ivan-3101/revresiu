UPDATE ui.dashboardquery
SET   vcdashboardquery='Select * from masters.getlivedata(:Type, :StartDate, :EndDate, :VpaAddress, :timeZone, 1000);'
WHERE idashboardqueryid=7;