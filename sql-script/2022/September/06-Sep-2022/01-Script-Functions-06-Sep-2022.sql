CREATE OR REPLACE FUNCTION ui.getlivetrans_last_testdb(
	classname character varying,
	riskscore integer,
	timezone character varying,
	maxrecord integer)
    RETURNS TABLE("ID" bigint, "Unique ID" character varying, "Time" timestamp with time zone, "Payer VPA" character varying, "Payer Name" character varying, "Payee VPA" character varying, "Payee Name" character varying, amount numeric, "FRM Pass" boolean, score integer, "Rule" character varying, vcpayeraccount character varying, vcpayeeaccount character varying)
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE PARALLEL UNSAFE
    ROWS 1000

AS $BODY$
BEGIN
Return query select l.iLiveMessageID as "ID", l.vcmsgid as "Unique ID", l.dtTrxnTime at time zone 'Asia/Kolkata' at time zone timezone as "Time",
                    l.payervpa, l.payername, l.payeevpa, l.payeename, l.dTransAmount as "Amount", l.bFRMPassed as "FRM Pass", l.score as "Score", l.vcrulename as "Rule",
                    l.vcpayeraccount, l.vcpayeeaccount from transactions.vw_livetrans_with_vpa_and_account_from_joins l
					where l.vcpayeraccount=classname order by dtTrxnTime desc limit maxrecord;

End;
$BODY$;
