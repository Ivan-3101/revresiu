UPDATE ui.dashboardquery SET
vcdashboardquery = 'select displayname as "displayName" , attribpath as "whereEntry", datatype as "dataType", cast(attribs as text) as  "attribs" from ui.masterextractattribs where level = :Party and itenantid=:tenantid '::text WHERE
idashboardqueryid = 74;

