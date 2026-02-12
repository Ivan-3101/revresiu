UPDATE ui.masterconfig SET
configjson =  E'[
    {
        "sql": "select iaccountid, array_agg(distinct ipayeemccid)\\nfrom purview group by iaccountid",
        "description": "Distinct MCCs transacting with Account",
        "tooltip": "Distinct MCCs transacting with Account"
    },
    {
        "sql": "SELECT iaccountid, sum(dobservationamount)\\nFROM purview WHERE bside = false GROUP BY iaccountid",
        "description": "Total Value",
        "tooltip": "Total Value"
    },
    {
        "sql": "SELECT iaccountid, count(ilivemessageid)\\nFROM purview WHERE bside = true GROUP BY iaccountid",
        "description": "Total count",
        "tooltip": "Total count"
    },
    {
        "sql": "SELECT iaccountid, map_from_entries(array_agg(struct(`txn.class`, `count(ilivemessageid)`)))\\nas byclass\\nFROM (SELECT iaccountid, `txn.class`, count(ilivemessageid)\\nFROM purview GROUP BY iaccountid, `txn.class`)\\nGROUP BY iaccountid",
        "description": "Total Value by Class",
        "tooltip": "Total Value by Class"
    },
    {
        "sql": "select iaccountid, map_from_entries(collect_list(struct(ovpaid, count))) as relationshipCount\\nfrom ( select iaccountid, ovpaid, count(ilivemessageid) as count\\nfrom purview where `txn.type` = ''PAY'' and bside = true group by iaccountid, ovpaid )\\nas a group by iaccountid",
        "description": "Payer wise total Count with an Account as Payee",
        "tooltip": "Payer wise total Count with an Account as Payee"
    },
    {
        "sql": "select iaccountid, map_from_entries(collect_list(struct(ovpaid, value))) as relationshipValue\\nfrom ( select iaccountid, ovpaid, sum(dobservationamount) as value\\nfrom purview where `txn.type` = ''PAY'' and bside = false group by iaccountid, ovpaid )\\nas a group by iaccountid",
        "description": "Payee wise total Value  with an Account",
        "tooltip": "Payee wise total Value  with an Account"
    },
    {
        "sql": "select iaccountid,count(distinct ovpaid)\\nfrom purview where dobservationamount > 5000 and `txn.attribs.p2p_p2m`=''P2P'' and bside=true\\ngroup by iaccountid",
        "description": "Distinct count of payers transacting with Account",
        "tooltip": "Distinct count of payers transacting with Account"
    },
    {
        "sql": "\\nWITH history AS (\\n    SELECT iaccountid, SUM(dobservationamount) AS volume\\n    FROM purview\\n    WHERE tdate < to_date(''{adjusted_tdate}'') and bside=true\\n    GROUP BY iaccountid\\n),\\nrecent AS (\\n    SELECT iaccountid, SUM(dobservationamount) AS volume\\n    FROM purview\\n    WHERE tdate >= to_date(''{adjusted_tdate}'') - interval ''1'' month and bside=true\\n    GROUP BY iaccountid\\n)\\nSELECT recent.iaccountid, history.volume/3 AS avg_history\\nFROM recent LEFT JOIN history on recent.iaccountid = history.iaccountid",
        "description": "Avg Monthly Value",
        "tooltip": "Avg Monthly Value"
    },
    {
        "description":"Identical payment transactions for an account",
        "tooltip":"Identical payment transactions for an account",
        "sql": "WITH sim AS ( SELECT iaccountid, dobservationamount, SUM(dobservationamount)\\nAS volume FROM purview GROUP BY iaccountid, dobservationamount\\nHAVING COUNT(1) > 1 ),\\nsim_totals AS\\n( SELECT iaccountid, SUM(volume) as volume\\nFROM sim GROUP BY iaccountid HAVING SUM(volume) > 100000 ),\\ntotals AS ( SELECT p.iaccountid, sum(p.dobservationamount) AS volume\\nFROM purview p GROUP BY p.iaccountid )\\nSELECT st.iaccountid, st.volume AS sim_volume, t.volume,\\n(st.volume/t.volume)*100 AS per, st.volume > t.volume * 0.3 AS gt30per\\nFROM sim_totals st LEFT JOIN totals t ON st.iaccountid = t.iaccountid"
    },
    {
        "description":"Aggr value for  account with risky onboardings",
        "tooltip":"Aggr value for  account with risky onboardings",
        "sql":"SELECT iaccountid, sum(dobservationamount) FROM\\npurview WHERE bside = true\\n`observations.payerVPA.account.customer.attribs.isOnbLocRisky` = ''true''\\nAND GROUP BY iaccountid\\n"
    },
    {
        "sql":"select iaccountid, map_from_entries(collect_list(struct(country, count))) as \\ncountryWiseCount from (\\nselect iaccountid, get_json_object(`observations.geolocation`, ''$.country'') as country, count(1) as count\\nfrom purview\\nwhere bside = false\\nand get_json_object(`observations.geolocation`, ''$.country'') != ''-1''\\ngroup by iaccountid, get_json_object(`observations.geolocation`, ''$.country'')\\norder by iaccountid, country\\n)\\ngroup by iaccountid",
        "description":"Country wise split of txns for account as payer",
        "tooltip":"Country wise split of txns for account as payer"
    }
]'::jsonb WHERE
iconfigid = 4;

UPDATE ui.dashboardquery SET imenustructuredesc = 494 WHERE idashboardqueryid=46;


UPDATE ui.dashboardfilters
	SET idashboardqueryidfordefaultvalue=32
	WHERE  vcdashboardfiltertype = 'DateRangePicker'  and idashboardid in (14, 17);


UPDATE ui.dashboardfilters
    SET idashboardqueryidfordefaultvalue=16
    WHERE  vcdashboardfiltertype = 'DateRangePicker'  and idashboardid in (11, 13, 20);


UPDATE ui.dashboardquery SET
vcdashboardquery = 'SELECT NOW() as "startdate", NOW() as "enddate";'::text WHERE
idashboardqueryid = 16;