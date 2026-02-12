
DROP FUNCTION IF EXISTS ui.get_account_wise_rules_triggered(date);


CREATE OR REPLACE FUNCTION ui.get_account_wise_rules_triggered(
	inputdate date)
    RETURNS TABLE("Account External ID" character varying, "Type" text, "Rule Name" character varying, "Count" bigint, "Score" numeric(15,2) )
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE PARALLEL UNSAFE
    ROWS 1000

AS $BODY$
BEGIN
Return query  select ac.vcexternalaccountid,'Payer' as type,r.vcrulename, count(d.iruleid), d.dscore from transactions.livedecisiondetails d
left join masters.rules r on r.iruleid = d.iruleid,
 transactions.livetrans l join masters.vpa v on v.ivpaid=l.ipayervpaid
 left join masters.accounts ac on ac.iaccountid = v.iaccountid
 where d.ilivemessageid=l.ilivemessageid and cast(dtcreateddatetime as date)=inputdate and bpassed is false
 group by v.iaccountid,d.iruleid,r.vcrulename,ac.vcexternalaccountid, d.dscore
 union
select ac.vcexternalaccountid,'Payee' as type, r.vcrulename, count(d.iruleid), d.dscore from transactions.livedecisiondetails d
                                                                                                 left join masters.rules r on r.iruleid = d.iruleid, transactions.livetrans l join masters.vpa v on v.ivpaid=l.ipayeevpaid
                                                                                                                                                                              left join masters.accounts ac on ac.iaccountid = v.iaccountid
where d.ilivemessageid=l.ilivemessageid and cast(dtcreateddatetime as date)=inputdate and bpassed is false
group by v.iaccountid,d.iruleid,r.vcrulename,ac.vcexternalaccountid, d.dscore;
End;
$BODY$;
