UPDATE ui.rolemenuaccessmap AS rma
SET bedit = false
WHERE rma.imenuid IN
		(SELECT imenuid
			FROM ui.menustructuredesc AS msd
			WHERE msd.vcmenuname = 'Rules');

UPDATE ui.dashboard SET  bactive=false WHERE idashboardid=14;
