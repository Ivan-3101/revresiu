----tenant master (for all tenants) observation audit report schema
UPDATE ui.dashboardresultset SET
vcdashboardresultsetschema = '{
    "Observation Name":"string",
    "Observation Description":"string",
    "Observation ID":"integer",
    "Window Name":"string",
    "Maker User":"string",
    "Maker Time Stamp":"datetime",
    "Maker & Checker Remarks":"string",
    "Checker User":"string",
    "Checker Time Stamp": "datetime",
    "Action": "string",
    "Where": "string",
    "Group By":"string",
    "Aggregation":"string",
    "Duration":"string",
    "Observation Count":"integer"
}
'::text WHERE
idashboardresultsetid = 41;

---batch party profile query changes for all tenants
UPDATE ui.dashboardquery SET
vcdashboardquery =  E'  {
 	"Account": {
 		"Monthly": "WITH  RECURSIVE profile AS ( SELECT pv.iaccountid, pv.tdate, pv.val || cast( format( ''{\\"Address\\":\\"%s\\",\\"Name\\":\\"%s\\", \\"Last Update\\":\\"%s\\"}'', vcexternalaccountid, vcaccountname, last_updated ) as jsonb ) as val FROM profiles.account_monthly pv LEFT JOIN masters.accounts v ON v.iaccountid = pv.iaccountid and v.itenantid=:tenantid WHERE tdate BETWEEN cast(:StartDate as date) AND cast(:EndDate as date) - 1 AND v.vcexternalaccountid = :Address ), flat (iaccountid, tdate, key, value) AS ( SELECT iaccountid, tdate, concat('''', key), value FROM profile, jsonb_each(val) UNION SELECT iaccountid, tdate, concat(f.key, ''.'', j.key), j.value FROM flat f, jsonb_each(f.value) j WHERE jsonb_typeof(f.value) = ''object'' ) SELECT cast(json_agg(data) as text) FROM ( SELECT iaccountid, tdate, jsonb_object_agg( COALESCE(metadata.vccolumnname, flat.key), value ) AS data FROM flat LEFT JOIN profiles.metadata ON metadata.vcpath = flat.key AND metadata.vcroot = ''account_monthly'' AND metadata.itenantid=:tenantid WHERE jsonb_typeof(value) <> ''object'' GROUP BY iaccountid, tdate ) a;",
		"Weekly": "WITH  RECURSIVE profile AS ( SELECT pv.iaccountid, pv.tdate, pv.val || cast( format( ''{\\"Address\\":\\"%s\\",\\"Name\\":\\"%s\\", \\"Last Update\\":\\"%s\\"}'', vcexternalaccountid, vcaccountname, last_updated ) as jsonb ) as val FROM profiles.account_weekly pv LEFT JOIN masters.accounts v ON v.iaccountid = pv.iaccountid and v.itenantid=:tenantid WHERE tdate BETWEEN cast(:StartDate as date) AND cast(:EndDate as date) - 1 AND v.vcexternalaccountid = :Address ), flat (iaccountid, tdate, key, value) AS ( SELECT iaccountid, tdate, concat('''', key), value FROM profile, jsonb_each(val) UNION SELECT iaccountid, tdate, concat(f.key, ''.'', j.key), j.value FROM flat f, jsonb_each(f.value) j WHERE jsonb_typeof(f.value) = ''object'' ) SELECT cast(json_agg(data) as text) FROM ( SELECT iaccountid, tdate, jsonb_object_agg( COALESCE(metadata.vccolumnname, flat.key), value ) AS data FROM flat LEFT JOIN profiles.metadata ON metadata.vcpath = flat.key AND metadata.vcroot = ''account_weekly'' AND metadata.itenantid=:tenantid WHERE jsonb_typeof(value) <> ''object'' GROUP BY iaccountid, tdate ) a;"
 	},
 	"VPA": {
 		"Monthly": "WITH RECURSIVE profile AS ( SELECT pv.ivpaid, pv.tdate, pv.val || cast( format( ''{\\"Address\\":\\"%s\\",\\"Name\\":\\"%s\\", \\"Last Update\\":\\"%s\\"}'', vcexternaladdressid, vcvpaname, last_updated ) as jsonb ) as val FROM profiles.vpa_monthly pv LEFT JOIN masters.vpa v ON v.ivpaid = pv.ivpaid and v.itenantid=:tenantid WHERE tdate BETWEEN cast(:StartDate as date) AND cast(:EndDate as date) - 1 AND v.vcexternaladdressid = :Address ), flat (ivpaid, tdate, key, value) AS ( SELECT ivpaid, tdate, concat('''', key), value FROM profile, jsonb_each(val) UNION SELECT ivpaid, tdate, concat(f.key, ''.'', j.key), j.value FROM flat f, jsonb_each(f.value) j WHERE jsonb_typeof(f.value) = ''object'' ) SELECT cast(json_agg(data) as text) FROM ( SELECT ivpaid, tdate, jsonb_object_agg( COALESCE(metadata.vccolumnname, flat.key), value ) AS data FROM flat LEFT JOIN profiles.metadata ON metadata.vcpath = flat.key AND metadata.vcroot = ''vpa_monthly'' AND metadata.itenantid=:tenantid WHERE jsonb_typeof(value) <> ''object'' GROUP BY ivpaid, tdate ) a;",
		"Weekly": "WITH RECURSIVE profile AS ( SELECT pv.ivpaid, pv.tdate, pv.val || cast( format( ''{\\"Address\\":\\"%s\\",\\"Name\\":\\"%s\\", \\"Last Update\\":\\"%s\\"}'', vcexternaladdressid, vcvpaname, last_updated ) as jsonb ) as val FROM profiles.vpa_weekly pv LEFT JOIN masters.vpa v ON v.ivpaid = pv.ivpaid and v.itenantid=:tenantid WHERE tdate BETWEEN cast(:StartDate as date) AND cast(:EndDate as date) - 1 AND v.vcexternaladdressid = :Address ), flat (ivpaid, tdate, key, value) AS ( SELECT ivpaid, tdate, concat('''', key), value FROM profile, jsonb_each(val) UNION SELECT ivpaid, tdate, concat(f.key, ''.'', j.key), j.value FROM flat f, jsonb_each(f.value) j WHERE jsonb_typeof(f.value) = ''object'' ) SELECT cast(json_agg(data) as text) FROM ( SELECT ivpaid, tdate, jsonb_object_agg( COALESCE(metadata.vccolumnname, flat.key), value ) AS data FROM flat LEFT JOIN profiles.metadata ON metadata.vcpath = flat.key AND metadata.vcroot = ''vpa_weekly'' AND metadata.itenantid=:tenantid WHERE jsonb_typeof(value) <> ''object'' GROUP BY ivpaid, tdate ) a;"
 	}
 }'::text WHERE
idashboardqueryid = 65;

UPDATE ui.dashboardquery SET
vcdashboardquery = 'SELECT X.* FROM   (VALUES (''Monthly'', ''Monthly''), (''Weekly'', ''Weekly'')) AS X ("label", "value");'::text WHERE
idashboardqueryid = 64;