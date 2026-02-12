ALTER TABLE ui.dashboard 
ALTER COLUMN imenustructuredesc DROP NOT NULL;

ALTER TABLE ui.dashboardresultset
ADD COLUMN imenustructuredesc INTEGER;

update ui.dashboard set imenustructuredesc= null
where (bactive=false or bdelete = true) and imenustructuredesc =510;

UPDATE ui.dashboardresultset d
SET imenustructuredesc = r.imenustructuredesc 
FROM ui.dashboard r 
WHERE d.idashboardid = r.idashboardid and d.itenantid = r.itenantid;