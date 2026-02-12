UPDATE ui.dashboardquery
SET  vcdashboardquery='Select * from masters.getlivedata(:Type, :StartDate, :EndDate, :VpaAddress, 1000);'
WHERE idashboardqueryid=7;