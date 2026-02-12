update ui.dashboard set bdynamic=true where idashboardid=24;

UPDATE ui.dashboardquery SET
vcdashboardquery = 'select cast(dttrxntime as date) as "Date", vcclassname as "Class", count(*) as "Txn Count" from analytics.trans where dttrxntime between :StartDate and :EndDate and itenantid=:tenantid and vcclassname in (with d1 as (select mappingid from ui.webusermapping where webuserid = :loggedinuser and mappingtype = ''TransactionClass'') (select vcclassname FROM ui.transactionclasses where (iclassid in (select mappingid from d1) or -1 in (select mappingid from d1)) and itenantid=:tenantid)) group by cast(dttrxntime as date), vcclassname;'::text WHERE
idashboardqueryid = 80;