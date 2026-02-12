update ui.dashboard set imenustructuredesc= 510
where (bactive=false or bdelete = true) and imenustructuredesc is null;

ALTER TABLE ui.dashboard 
ALTER COLUMN imenustructuredesc SET NOT NULL;

ALTER TABLE ui.dashboardresultset
DROP COLUMN imenustructuredesc;