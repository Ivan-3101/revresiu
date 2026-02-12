UPDATE ui.dashboardquery
	SET  vcdashboardquery='{
    "Account": {
        "Payer": "SELECT cast(jsonb_agg(longevity) as text) as  \"json_agg\" FROM profiles.account pv left join masters.accounts v on v.iaccountid = pv.iaccountid where tdate between cast(:StartDate as date) and cast(:EndDate as date)-1 and v.vcexternalaccountid = :VpaAddress and bside = false",
        "Payee": "SELECT cast(jsonb_agg(longevity) as text) as  \"json_agg\" FROM profiles.account pv left join masters.accounts v on v.iaccountid = pv.iaccountid where tdate between cast(:StartDate as date) and cast(:EndDate as date)-1 and v.vcexternalaccountid = :VpaAddress and bside = true",
        "Both": "SELECT cast(jsonb_agg(longevity) as text) as  \"json_agg\"  FROM profiles.account pv left join masters.accounts v on v.iaccountid = pv.iaccountid where tdate between cast(:StartDate as date) and cast(:EndDate as date)-1 and v.vcexternalaccountid = :VpaAddress "
    },
    "VPA": {
        "Payer": "SELECT cast(jsonb_agg(longevity) as text)  as  \"json_agg\" FROM profiles.vpa pv left join masters.vpa v on v.ivpaid = pv.ivpaid where tdate between cast(:StartDate as date) and cast(:EndDate as date)-1 and v.vcexternaladdressid = :VpaAddress and bside = false",
        "Payee": "SELECT cast(jsonb_agg(longevity) as text)  as  \"json_agg\" FROM profiles.vpa pv left join masters.vpa v on v.ivpaid = pv.ivpaid where tdate between cast(:StartDate as date) and cast(:EndDate as date)-1 and v.vcexternaladdressid = :VpaAddress and bside = true",
        "Both": "SELECT cast(jsonb_agg(longevity) as text)  as  \"json_agg\" FROM profiles.vpa pv left join masters.vpa v on v.ivpaid = pv.ivpaid where tdate between cast(:StartDate as date) and cast(:EndDate as date)-1 and v.vcexternaladdressid = :VpaAddress"
    }
}'
	WHERE idashboardqueryid=39;


   UPDATE ui.dashboardquery
	SET  vcdashboardquery='{
    "Account": {
        "Payer": "SELECT cast(jsonb_agg(frequency) as text) as   \"json_agg\" FROM profiles.account pv left join masters.accounts v on v.iaccountid = pv.iaccountid where tdate between cast(:StartDate as date) and cast(:EndDate as date)-1 and v.vcexternalaccountid = :VpaAddress and bside = false",
        "Payee": "SELECT cast(jsonb_agg(frequency) as text) as  \"json_agg\" FROM profiles.account pv left join masters.accounts v on v.iaccountid = pv.iaccountid where tdate between cast(:StartDate as date) and cast(:EndDate as date)-1 and v.vcexternalaccountid = :VpaAddress and bside = true",
        "Both": "SELECT cast(jsonb_agg(frequency) as text) as  \"json_agg\"  FROM profiles.account pv left join masters.accounts v on v.iaccountid = pv.iaccountid where tdate between cast(:StartDate as date) and cast(:EndDate as date)-1 and v.vcexternalaccountid = :VpaAddress "
    },
    "VPA": {
        "Payer": "SELECT cast(jsonb_agg(frequency) as text) as  \"json_agg\" FROM profiles.vpa pv left join masters.vpa v on v.ivpaid = pv.ivpaid where tdate between cast(:StartDate as date) and cast(:EndDate as date)-1 and v.vcexternaladdressid = :VpaAddress and bside = false",
        "Payee": "SELECT cast(jsonb_agg(frequency) as text) as  \"json_agg\" FROM profiles.vpa pv left join masters.vpa v on v.ivpaid = pv.ivpaid where tdate between cast(:StartDate as date) and cast(:EndDate as date)-1 and v.vcexternaladdressid = :VpaAddress and bside = true",
        "Both": "SELECT cast(jsonb_agg(frequency) as text) as  \"json_agg\" FROM profiles.vpa pv left join masters.vpa v on v.ivpaid = pv.ivpaid where tdate between cast(:StartDate as date) and cast(:EndDate as date)-1 and v.vcexternaladdressid = :VpaAddress"
    }
}'
	WHERE idashboardqueryid=40;


      UPDATE ui.dashboardquery
	SET  vcdashboardquery='{
    "Account": {
        "Payer": "SELECT cast(jsonb_agg(velocity) as text) as   \"json_agg\" FROM profiles.account pv left join masters.accounts v on v.iaccountid = pv.iaccountid where tdate between cast(:StartDate as date) and cast(:EndDate as date)-1 and v.vcexternalaccountid = :VpaAddress and bside = false",
        "Payee": "SELECT cast(jsonb_agg(velocity) as text) as  \"json_agg\" FROM profiles.account pv left join masters.accounts v on v.iaccountid = pv.iaccountid where tdate between cast(:StartDate as date) and cast(:EndDate as date)-1 and v.vcexternalaccountid = :VpaAddress and bside = true",
        "Both": "SELECT cast(jsonb_agg(velocity) as text) as  \"json_agg\"  FROM profiles.account pv left join masters.accounts v on v.iaccountid = pv.iaccountid where tdate between cast(:StartDate as date) and cast(:EndDate as date)-1 and v.vcexternalaccountid = :VpaAddress "
    },
    "VPA": {
        "Payer": "SELECT cast(jsonb_agg(velocity) as text) as  \"json_agg\" FROM profiles.vpa pv left join masters.vpa v on v.ivpaid = pv.ivpaid where tdate between cast(:StartDate as date) and cast(:EndDate as date)-1 and v.vcexternaladdressid = :VpaAddress and bside = false",
        "Payee": "SELECT cast(jsonb_agg(velocity) as text) as  \"json_agg\" FROM profiles.vpa pv left join masters.vpa v on v.ivpaid = pv.ivpaid where tdate between cast(:StartDate as date) and cast(:EndDate as date)-1 and v.vcexternaladdressid = :VpaAddress and bside = true",
        "Both": "SELECT cast(jsonb_agg(velocity) as text) as  \"json_agg\" FROM profiles.vpa pv left join masters.vpa v on v.ivpaid = pv.ivpaid where tdate between cast(:StartDate as date) and cast(:EndDate as date)-1 and v.vcexternaladdressid = :VpaAddress"
    }
}'
	WHERE idashboardqueryid=41;


      UPDATE ui.dashboardquery
	SET  vcdashboardquery='{
    "Account": {
        "Payer": "SELECT cast(jsonb_agg(engagement) as text) as  \"json_agg\" FROM profiles.account pv left join masters.accounts v on v.iaccountid = pv.iaccountid where tdate between cast(:StartDate as date) and cast(:EndDate as date)-1 and v.vcexternalaccountid = :VpaAddress and bside = false",
        "Payee": "SELECT cast(jsonb_agg(engagement) as text) as  \"json_agg\" FROM profiles.account pv left join masters.accounts v on v.iaccountid = pv.iaccountid where tdate between cast(:StartDate as date) and cast(:EndDate as date)-1 and v.vcexternalaccountid = :VpaAddress and bside = true",
        "Both": "SELECT cast(jsonb_agg(engagement) as text) as  \"json_agg\"  FROM profiles.account pv left join masters.accounts v on v.iaccountid = pv.iaccountid where tdate between cast(:StartDate as date) and cast(:EndDate as date)-1 and v.vcexternalaccountid = :VpaAddress "
    },
    "VPA": {
        "Payer": "SELECT cast(jsonb_agg(engagement) as text) as  \"json_agg\" FROM profiles.vpa pv left join masters.vpa v on v.ivpaid = pv.ivpaid where tdate between cast(:StartDate as date) and cast(:EndDate as date)-1 and v.vcexternaladdressid = :VpaAddress and bside = false",
        "Payee": "SELECT cast(jsonb_agg(engagement) as text) as  \"json_agg\" FROM profiles.vpa pv left join masters.vpa v on v.ivpaid = pv.ivpaid where tdate between cast(:StartDate as date) and cast(:EndDate as date)-1 and v.vcexternaladdressid = :VpaAddress and bside = true",
        "Both": "SELECT cast(jsonb_agg(engagement) as text) as  \"json_agg\" FROM profiles.vpa pv left join masters.vpa v on v.ivpaid = pv.ivpaid where tdate between cast(:StartDate as date) and cast(:EndDate as date)-1 and v.vcexternaladdressid = :VpaAddress"
    }
}'
	WHERE idashboardqueryid=42;

       UPDATE ui.dashboardquery
	SET  vcdashboardquery='{
    "Account": {
        "Payer": "SELECT cast(jsonb_agg(geospatial) as text) as \"json_agg\" FROM profiles.account pv left join masters.accounts v on v.iaccountid = pv.iaccountid where tdate between cast(:StartDate as date) and cast(:EndDate as date)-1 and v.vcexternalaccountid = :VpaAddress and bside = false",
        "Payee": "SELECT cast(jsonb_agg(geospatial) as text) as \"json_agg\" FROM profiles.account pv left join masters.accounts v on v.iaccountid = pv.iaccountid where tdate between cast(:StartDate as date) and cast(:EndDate as date)-1 and v.vcexternalaccountid = :VpaAddress and bside = true",
        "Both": "SELECT cast(jsonb_agg(geospatial) as text) as \"json_agg\"  FROM profiles.account pv left join masters.accounts v on v.iaccountid = pv.iaccountid where tdate between cast(:StartDate as date) and cast(:EndDate as date)-1 and v.vcexternalaccountid = :VpaAddress "
    },
    "VPA": {
        "Payer": "SELECT cast(jsonb_agg(geospatial) as text) as \"json_agg\" FROM profiles.vpa pv left join masters.vpa v on v.ivpaid = pv.ivpaid where tdate between cast(:StartDate as date) and cast(:EndDate as date)-1 and v.vcexternaladdressid = :VpaAddress and bside = false",
        "Payee": "SELECT cast(jsonb_agg(geospatial) as text) as \"json_agg\" FROM profiles.vpa pv left join masters.vpa v on v.ivpaid = pv.ivpaid where tdate between cast(:StartDate as date) and cast(:EndDate as date)-1 and v.vcexternaladdressid = :VpaAddress and bside = true",
        "Both": "SELECT cast(jsonb_agg(geospatial) as text) as \"json_agg\" FROM profiles.vpa pv left join masters.vpa v on v.ivpaid = pv.ivpaid where tdate between cast(:StartDate as date) and cast(:EndDate as date)-1 and v.vcexternaladdressid = :VpaAddress"
    }
}'
	WHERE idashboardqueryid=43;

          UPDATE ui.dashboardquery
	SET  vcdashboardquery='{
    "Account": {
        "Payer": "SELECT cast(jsonb_agg(events) as text) as  \"json_agg\" FROM profiles.account pv left join masters.accounts v on v.iaccountid = pv.iaccountid where tdate between cast(:StartDate as date) and cast(:EndDate as date)-1 and v.vcexternalaccountid = :VpaAddress and bside = false",
        "Payee": "SELECT cast(jsonb_agg(events) as text) as   \"json_agg\" FROM profiles.account pv left join masters.accounts v on v.iaccountid = pv.iaccountid where tdate between cast(:StartDate as date) and cast(:EndDate as date)-1 and v.vcexternalaccountid = :VpaAddress and bside = true",
        "Both": "SELECT cast(jsonb_agg(events) as text) as   \"json_agg\"  FROM profiles.account pv left join masters.accounts v on v.iaccountid = pv.iaccountid where tdate between cast(:StartDate as date) and cast(:EndDate as date)-1 and v.vcexternalaccountid = :VpaAddress "
    },
    "VPA": {
        "Payer": "SELECT cast(jsonb_agg(events) as text) as   \"json_agg\" FROM profiles.vpa pv left join masters.vpa v on v.ivpaid = pv.ivpaid where tdate between cast(:StartDate as date) and cast(:EndDate as date)-1 and v.vcexternaladdressid = :VpaAddress and bside = false",
        "Payee": "SELECT cast(jsonb_agg(events) as text) as   \"json_agg\" FROM profiles.vpa pv left join masters.vpa v on v.ivpaid = pv.ivpaid where tdate between cast(:StartDate as date) and cast(:EndDate as date)-1 and v.vcexternaladdressid = :VpaAddress and bside = true",
        "Both": "SELECT cast(jsonb_agg(events) as text) as   \"json_agg\" FROM profiles.vpa pv left join masters.vpa v on v.ivpaid = pv.ivpaid where tdate between cast(:StartDate as date) and cast(:EndDate as date)-1 and v.vcexternaladdressid = :VpaAddress"
    }
}'
	WHERE idashboardqueryid=44;


           UPDATE ui.dashboardquery
	SET  vcdashboardquery= '{
    "Account": {
        "Payer": "SELECT v.vcexternalaccountid as \"Address\", CASE WHEN bside = true THEN ''Payee'' WHEN bside = false THEN ''Payer'' ELSE null END as \"Type\", last_updated as \"Last Updated\", tdate as \"Date\" FROM profiles.account pv left join masters.accounts v on v.iaccountid = pv.iaccountid where tdate between cast(:StartDate as date) and cast(:EndDate as date)-1 and v.vcexternalaccountid = :VpaAddress and bside = false",
        "Payee": "SELECT v.vcexternalaccountid as \"Address\", CASE WHEN bside = true THEN ''Payee'' WHEN bside = false THEN ''Payer'' ELSE null END as \"Type\", last_updated as \"Last Updated\", tdate as \"Date\" FROM profiles.account pv left join masters.accounts v on v.iaccountid = pv.iaccountid where tdate between cast(:StartDate as date) and cast(:EndDate as date)-1 and v.vcexternalaccountid = :VpaAddress and bside = true",
        "Both": "SELECT v.vcexternalaccountid as \"Address\", CASE WHEN bside = true THEN ''Payee'' WHEN bside = false THEN ''Payer'' ELSE null END as \"Type\", last_updated as \"Last Updated\", tdate as \"Date\" FROM profiles.account pv left join masters.accounts v on v.iaccountid = pv.iaccountid where tdate between cast(:StartDate as date) and cast(:EndDate as date)-1 and v.vcexternalaccountid = :VpaAddress "
    },
    "VPA": {
        "Payer": "SELECT v.vcexternaladdressid as \"Address\", CASE WHEN bside = true THEN ''Payee'' WHEN bside = false THEN ''Payer'' ELSE null END as \"Type\", last_updated as \"Last Updated\", tdate as \"Date\" FROM profiles.vpa pv left join masters.vpa v on v.ivpaid = pv.ivpaid where tdate between cast(:StartDate as date) and cast(:EndDate as date)-1 and v.vcexternaladdressid = :VpaAddress and bside = false",
        "Payee": "SELECT v.vcexternaladdressid as \"Address\", CASE WHEN bside = true THEN ''Payee'' WHEN bside = false THEN ''Payer'' ELSE null END as \"Type\", last_updated as \"Last Updated\", tdate as \"Date\" FROM profiles.vpa pv left join masters.vpa v on v.ivpaid = pv.ivpaid where tdate between cast(:StartDate as date) and cast(:EndDate as date)-1 and v.vcexternaladdressid = :VpaAddress and bside = true",
        "Both": "SELECT v.vcexternaladdressid as \"Address\", CASE WHEN bside = true THEN ''Payee'' WHEN bside = false THEN ''Payer'' ELSE null END as \"Type\", last_updated as \"Last Updated\", tdate as \"Date\" FROM profiles.vpa pv left join masters.vpa v on v.ivpaid = pv.ivpaid where tdate between cast(:StartDate as date) and cast(:EndDate as date)-1 and v.vcexternaladdressid = :VpaAddress"
    }
}'
	WHERE idashboardqueryid=38;


UPDATE ui.dashboard SET  bactive=true WHERE idashboardid=14;
