UPDATE ui.dashboardquery SET
vcdashboardquery = 'SELECT 
  i.ilistitemauditid as "List item id", 
  i.ilisttype as "List Type",  
  makeruser.vcusername as "Maker User", 
  i.dtentrystamp as "Maker Time Stamp", 
  i.vcremark as "Remarks", 
  checkeruser.vcusername as "Checker User", 
  i.dtapproverstamp as "Checker Time Stamp", 
  i.vcfield as "Field",
  i.vcvalue as "Value",
 cast(i.attribs as text) as "Attributes",
  i.vcnote as  "Note",
	i.vcsource as "Source",
	i.dteffectivefrom as "Effective From",
	i.dtexpiresat as "Expires At",
	i.irecordstatus as "Record Status"
FROM 
	ui.listaudit i 
  left join ui.webuser makeruser on makeruser.iuserid = i.ientryuserid 
  left join ui.webuser checkeruser on checkeruser.iuserid = i.iapproveruserid 
where 
  i.itenantid = :tenantid 
  and cast(i.dtentrystamp as date) between cast(:StartDate as date) 
  and cast(:EndDate as date) limit 10000;'::text WHERE
idashboardqueryid = 146 AND itenantid = 9;