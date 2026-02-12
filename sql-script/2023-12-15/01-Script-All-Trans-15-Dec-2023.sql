---Txn count query
UPDATE ui.dashboardquery SET
vcdashboardquery = 'select cast(dttrxntime as date) as "Date", vcclassname as "Class", count(*) as "Txn Count" from transactions.trans where dttrxntime between :StartDate and :EndDate group by cast(dttrxntime as date), vcclassname;'::text WHERE
idashboardqueryid = 80;

---Party Profile
UPDATE ui.dashboardquery SET
vcdashboardquery =  E'{
    "Account": "WITH RECURSIVE profile AS ( SELECT pv.iaccountid, pv.tdate, pv.val || cast( format( ''{\\"Address\\":\\"%s\\",\\"Name\\":\\"%s\\", \\"Last Update\\":\\"%s\\"}'', vcexternalaccountid, vcaccountname, last_updated ) as jsonb ) as val FROM profiles.account pv LEFT JOIN masters.accounts v ON v.iaccountid = pv.iaccountid WHERE tdate BETWEEN cast(:StartDate as date) AND cast(:EndDate as date) - 1 AND v.vcexternalaccountid = :VpaAddress ), flat (iaccountid, tdate, key, value) AS ( SELECT iaccountid, tdate, concat('''', key), value FROM profile, jsonb_each(val) UNION SELECT iaccountid, tdate, concat(f.key, ''.'', j.key), j.value FROM flat f, jsonb_each(f.value) j WHERE jsonb_typeof(f.value) = ''object'' ) SELECT cast(json_agg(data) as text) FROM ( SELECT iaccountid, tdate, jsonb_object_agg( COALESCE(metadata.vccolumnname, flat.key), value ) AS data FROM flat LEFT JOIN profiles.metadata ON metadata.vcpath = flat.key AND metadata.vcroot = ''account'' WHERE jsonb_typeof(value) <> ''object'' GROUP BY iaccountid, tdate ) a;",
    "VPA": "WITH RECURSIVE profile AS ( SELECT pv.ivpaid, pv.tdate, pv.val || cast( format( ''{\\"Address\\":\\"%s\\",\\"Name\\":\\"%s\\", \\"Last Update\\":\\"%s\\"}'', vcexternaladdressid, vcvpaname, last_updated ) as jsonb ) as val FROM profiles.vpa pv LEFT JOIN masters.vpa v ON v.ivpaid = pv.ivpaid WHERE tdate BETWEEN cast(:StartDate as date) AND cast(:EndDate as date) - 1 AND v.vcexternaladdressid = :VpaAddress ), flat (ivpaid, tdate, key, value) AS ( SELECT ivpaid, tdate, concat('''', key), value FROM profile, jsonb_each(val) UNION SELECT ivpaid, tdate, concat(f.key, ''.'', j.key), j.value FROM flat f, jsonb_each(f.value) j WHERE jsonb_typeof(f.value) = ''object'' ) SELECT cast(json_agg(data) as text) FROM ( SELECT ivpaid, tdate, jsonb_object_agg( COALESCE(metadata.vccolumnname, flat.key), value ) AS data FROM flat LEFT JOIN profiles.metadata ON metadata.vcpath = flat.key AND metadata.vcroot = ''vpa'' WHERE jsonb_typeof(value) <> ''object'' GROUP BY ivpaid, tdate ) a;"
}'::text WHERE
idashboardqueryid = 57;

--Batch Party Profile
UPDATE ui.dashboardquery SET
vcdashboardquery =  E'  {
 	"Account": {
 		"Monthly": "WITH RECURSIVE profile AS ( SELECT pv.iaccountid, pv.tdate, pv.val || cast( format( ''{\\"Address\\":\\"%s\\",\\"Name\\":\\"%s\\", \\"Last Update\\":\\"%s\\"}'', vcexternalaccountid, vcaccountname, last_updated ) as jsonb ) as val FROM profiles.account_monthly pv LEFT JOIN masters.accounts v ON v.iaccountid = pv.iaccountid WHERE tdate BETWEEN cast(:StartDate as date) AND cast(:EndDate as date) - 1 AND v.vcexternalaccountid = :Address ), flat (iaccountid, tdate, key, value) AS ( SELECT iaccountid, tdate, concat('''', key), value FROM profile, jsonb_each(val) UNION SELECT iaccountid, tdate, concat(f.key, ''.'', j.key), j.value FROM flat f, jsonb_each(f.value) j WHERE jsonb_typeof(f.value) = ''object'' ) SELECT cast(json_agg(data) as text) FROM ( SELECT iaccountid, tdate, jsonb_object_agg( COALESCE(metadata.vccolumnname, flat.key), value ) AS data FROM flat LEFT JOIN profiles.metadata ON metadata.vcpath = flat.key AND metadata.vcroot = ''account_monthly'' WHERE jsonb_typeof(value) <> ''object'' GROUP BY iaccountid, tdate ) a;"
 	},
 	"VPA": {
 		"Monthly": "WITH RECURSIVE profile AS ( SELECT pv.ivpaid, pv.tdate, pv.val || cast( format( ''{\\"Address\\":\\"%s\\",\\"Name\\":\\"%s\\", \\"Last Update\\":\\"%s\\"}'', vcexternaladdressid, vcvpaname, last_updated ) as jsonb ) as val FROM profiles.vpa_monthly pv LEFT JOIN masters.vpa v ON v.ivpaid = pv.ivpaid WHERE tdate BETWEEN cast(:StartDate as date) AND cast(:EndDate as date) - 1 AND v.vcexternaladdressid = :Address ), flat (ivpaid, tdate, key, value) AS ( SELECT ivpaid, tdate, concat('''', key), value FROM profile, jsonb_each(val) UNION SELECT ivpaid, tdate, concat(f.key, ''.'', j.key), j.value FROM flat f, jsonb_each(f.value) j WHERE jsonb_typeof(f.value) = ''object'' ) SELECT cast(json_agg(data) as text) FROM ( SELECT ivpaid, tdate, jsonb_object_agg( COALESCE(metadata.vccolumnname, flat.key), value ) AS data FROM flat LEFT JOIN profiles.metadata ON metadata.vcpath = flat.key AND metadata.vcroot = ''vpa_monthly'' WHERE jsonb_typeof(value) <> ''object'' GROUP BY ivpaid, tdate ) a;"
 	}
 }'::text WHERE
idashboardqueryid = 65;




