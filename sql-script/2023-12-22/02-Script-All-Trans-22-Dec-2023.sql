--update the generic formfilter queryid 74
UPDATE ui.dashboardquery SET
vcdashboardquery = 'select displayname as "displayName" , attribpath as "whereEntry", datatype as "dataType" from ui.masterextractattribs where level = :Party and itenantid=:tenantid'::text WHERE
idashboardqueryid = 74;