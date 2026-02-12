INSERT INTO ui.dashboardquery (
idashboardqueryid, bparametersrequired, vcdashboardquery, formattingrequiered, runonanalytics, transposerequired) VALUES (
'66'::integer, false::boolean, 'SELECT cast(tdate as timestamp) as  "startdate", cast(tdate as timestamp) as "enddate"  FROM profiles.account_monthly ORDER BY tdate  DESC LIMIT 1'::text, false::boolean, true::boolean, false::boolean)
 returning idashboardqueryid;



UPDATE ui.dashboardquery SET
vcdashboardquery = '{
	"Account": {
		"Monthly": "with recursive profile as ( SELECT pv.iaccountid, pv.val|| cast(format(''{\"Address\":\"%s\",\"Name\":\"%s\", \"Last Update\":\"%s\"}'' , vcexternalaccountid,  vcaccountname, last_updated) as jsonb) as val FROM profiles.account_monthly pv left join masters.accounts v on v.iaccountid = pv.iaccountid where tdate between cast(:StartDate as date) and cast(:EndDate as date)-1 and v.vcexternalaccountid =:Address ), flat ( iaccountid, key, value) as ( select  iaccountid,concat( '''', key), value from profile, jsonb_each(val) \n union select  iaccountid,concat(f.key, ''.'', j.key), j.value from flat f, jsonb_each(f.value) j where jsonb_typeof(f.value) = ''object'' ) \n select cast(json_agg(data) as text) from ( select iaccountid,jsonb_object_agg((select CASE WHEN (select vccolumnname from profiles.metadata where vcpath = key and vcroot = ''account'') IS NULL THEN key ELSE (select vccolumnname from profiles.metadata where vcpath = key and vcroot = ''account'') END AS  vccolumnname ), value  ) as data from flat where jsonb_typeof(value)<>''object'' group by iaccountid) a;"
	},
	"VPA": {
		"Monthly": "with recursive profile as ( SELECT pv.ivpaid, pv.val|| cast(format(''{\"Address\":\"%s\",\"Name\":\"%s\", \"Last Update\":\"%s\"}'' , vcexternaladdressid,  vcvpaname, last_updated) as jsonb) as val FROM profiles.vpa_monthly pv left join masters.vpa v on v.ivpaid = pv.ivpaid where tdate between cast(:StartDate as date) and cast(:EndDate as date)-1 and v.vcexternaladdressid = :Address ), flat (ivpaid, key, value) as ( select  ivpaid,concat( '''', key), value from profile, jsonb_each(val) \n union select  ivpaid,concat(f.key, ''.'', j.key), j.value from flat f, jsonb_each(f.value) j where jsonb_typeof(f.value) = ''object'' ) \n select cast(json_agg(data) as text) from ( select ivpaid,jsonb_object_agg((select CASE WHEN (select vccolumnname from profiles.metadata where vcpath = key and vcroot = ''vpa'') IS NULL THEN key ELSE (select vccolumnname from profiles.metadata where vcpath = key and vcroot = ''vpa'') END AS  vccolumnname ), value  ) as data from flat where jsonb_typeof(value)<>''object'' group by ivpaid) a;"
	}
}
'::text WHERE
idashboardqueryid = 65;


UPDATE ui.dashboardfilters SET
idashboardqueryidfordefaultvalue = '66'::integer WHERE
idashboardfilterid = 46;

UPDATE ui.dashboardquery SET
vcdashboardquery = 'SELECT dttrxntime "startdate", dttrxntime as "enddate"  FROM transactions.batchtrans
ORDER BY dttrxntime  DESC LIMIT 1'::text WHERE
idashboardqueryid = 66;


UPDATE ui.dashboardquery SET
vcdashboardquery = 'select dtTrxnTime as "startdate", dtTrxnTime as "enddate" from transactions.vw_LiveTrans order by dtTrxnTime desc limit 1'::text WHERE
idashboardqueryid = 16;



UPDATE ui.dashboardquery SET
vcdashboardquery = 'SELECT (NOW() - interval ''1 day'') as "startdate", (NOW() - interval ''1 day'') as "enddate";'::text WHERE
idashboardqueryid = 32;


UPDATE ui.dashboardquery SET
vcdashboardquery = '{
    "Account":"with recursive profile as ( SELECT pv.iaccountid, pv.val|| cast(format(''{\"Address\":\"%s\",\"Name\":\"%s\", \"Last Update\":\"%s\"}'' , vcexternalaccountid,  vcaccountname, last_updated) as jsonb) as val FROM profiles.account pv left join masters.accounts v on v.iaccountid = pv.iaccountid where tdate between cast(:StartDate as date) and cast(:EndDate as date)-1 and v.vcexternalaccountid =:VpaAddress ), flat ( iaccountid, key, value) as ( select  iaccountid,concat( '''', key), value from profile, jsonb_each(val) \n union select  iaccountid,concat(f.key, ''.'', j.key), j.value from flat f, jsonb_each(f.value) j where jsonb_typeof(f.value) = ''object'' ) \n select cast(json_agg(data) as text) from ( select iaccountid,jsonb_object_agg((select CASE WHEN (select vccolumnname from profiles.metadata where vcpath = key and vcroot = ''account'') IS NULL THEN key ELSE (select vccolumnname from profiles.metadata where vcpath = key and vcroot = ''account'') END AS  vccolumnname ), value  ) as data from flat where jsonb_typeof(value)<>''object'' group by iaccountid) a;",
    "VPA": "with recursive profile as ( SELECT pv.ivpaid, pv.val|| cast(format(''{\"Address\":\"%s\",\"Name\":\"%s\", \"Last Update\":\"%s\"}'' , vcexternaladdressid,  vcvpaname, last_updated) as jsonb) as val FROM profiles.vpa pv left join masters.vpa v on v.ivpaid = pv.ivpaid where tdate between cast(:StartDate as date) and cast(:EndDate as date)-1 and v.vcexternaladdressid = :VpaAddress ), flat (ivpaid, key, value) as ( select  ivpaid,concat( '''', key), value from profile, jsonb_each(val) \n union select  ivpaid,concat(f.key, ''.'', j.key), j.value from flat f, jsonb_each(f.value) j where jsonb_typeof(f.value) = ''object'' ) \n select cast(json_agg(data) as text) from ( select ivpaid,jsonb_object_agg((select CASE WHEN (select vccolumnname from profiles.metadata where vcpath = key and vcroot = ''vpa'') IS NULL THEN key ELSE (select vccolumnname from profiles.metadata where vcpath = key and vcroot = ''vpa'') END AS  vccolumnname ), value  ) as data from flat where jsonb_typeof(value)<>''object'' group by ivpaid) a;"
}'::text WHERE
idashboardqueryid = 57;

