
CREATE OR REPLACE FUNCTION ui.get_account_wise_rules_triggered(
	inputdate date)
    RETURNS TABLE("Account ID" bigint, "Type" text, "Rule Name" character varying, "Count" bigint)
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE PARALLEL UNSAFE
    ROWS 1000

AS $BODY$
BEGIN
Return query select iaccountid ,'Payer' as type,r.vcrulename, count(d.iruleid) from transactions.livedecisiondetails d
left join masters.rules r on r.iruleid = d.iruleid,
 transactions.livetrans l join masters.vpa v on v.ivpaid=l.ipayervpaid
 where d.ilivemessageid=l.ilivemessageid and cast(dtcreateddatetime as date)=inputdate and bpassed is false
 group by iaccountid,d.iruleid,r.vcrulename
 union
select iaccountid ,'Payee' as type, r.vcrulename, count(d.iruleid) from transactions.livedecisiondetails d
                                                                            left join masters.rules r on r.iruleid = d.iruleid,
                                                                        transactions.livetrans l
                                                                            join masters.vpa v on v.ivpaid=l.ipayeevpaid
where d.ilivemessageid=l.ilivemessageid and cast(dtcreateddatetime as date)=inputdate and bpassed is false
group by iaccountid,d.iruleid,r.vcrulename;
End;
$BODY$;

