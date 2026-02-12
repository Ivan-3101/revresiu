INSERT INTO ui.dashboardquery (idashboardqueryid, bparametersrequired, vcfilterparametersjson, vcdashboardquery) VALUES (29, false, NULL, 'select cast(dtcreateddatetime as date) from transactions.livedecisiondetails order by dtcreateddatetime desc limit 1');


UPDATE ui.dashboardfilters
SET  idashboardqueryidfordefaultvalue=29
WHERE idashboardfilterid=19;