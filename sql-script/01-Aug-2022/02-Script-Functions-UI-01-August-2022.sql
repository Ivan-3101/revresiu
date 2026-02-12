CREATE OR REPLACE FUNCTION ui.getpartydtxn(
	party character varying,
	vpatype character varying,
	timezone character varying,
	useraddress character varying,
	maxrecord integer)
    RETURNS TABLE("ID" bigint, "Unique ID" character varying, "Time" timestamp without time zone, "Payer VPA" character varying, "Payer Name" character varying, "Payee VPA" character varying, "Payee Name" character varying, amount numeric, "FRM Pass" boolean, score integer, "Rule" character varying, "Payer Account" character varying, "Payee Account" character varying)
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE PARALLEL UNSAFE
    ROWS 1000

AS $BODY$
BEGIN
If(party='VPA') Then
		If(vpatype='Payer') Then
		Return query select L.iLiveMessageID as "ID", L.vcmsgid  as "Unique ID", L.dtTrxnTime at time zone 'utc' at time zone timezone as "Time",
                            cast(L.observations  ->  'payer' ->> 'addr'  as character varying) as "Payer VPA",
                            cast(L.observations  ->  'payer' -> 'attribs' -> 'identity' ->> 'verified_name'as character varying) as "Payer Name",
                            cast(L.observations  ->  'payee' ->> 'addr'  as character varying) as "Payee VPA",
                            cast(L.observations  ->  'payee' -> 'attribs' -> 'identity' ->> 'verified_name' as character varying) as "Payee Name",
                            L.dTransAmount as "Amount", L.bFRMPassed as "FRM Pass", L.score as "Score", vcrulename as "Rule",
                            cast(observations  ->  'observations' -> 'payerVPA' -> 'account' ->> 'accountNumber'  as character varying) as "Payer Account",
                            cast(observations  ->  'observations' -> 'payeeVPA' -> 'account' ->> 'accountNumber' as character varying) as "Payee Account"
                     from transactions.vw_LiveTrans L where
                               cast(L.observations  ->  'payer' ->> 'addr'  as text) = useraddress
                                                        and (CAST(dtTrxnTime AS date) = CURRENT_DATE-1 or CAST(dtTrxnTime AS date) = CURRENT_DATE) limit maxrecord;

Elseif(vpatype='Payee') Then
		 Return query select L.iLiveMessageID as "ID", vcmsgid  as "Unique ID", L.dtTrxnTime at time zone 'utc' at time zone timezone as "Time",
                             cast(L.observations  ->  'payer' ->> 'addr'  as character varying) as "Payer VPA",
                             cast(L.observations  ->  'payer' -> 'attribs' -> 'identity' ->> 'verified_name'as character varying) as "Payer Name",
                             cast(L.observations  ->  'payee' ->> 'addr'  as character varying) as "Payee VPA",
                             cast(L.observations  ->  'payee' -> 'attribs' -> 'identity' ->> 'verified_name' as character varying) as "Payee Name",
                             L.dTransAmount as "Amount", L.bFRMPassed as "FRM Pass", L.score as "Score", L.vcrulename as "Rule",
                             cast(observations  ->  'observations' -> 'payerVPA' -> 'account' ->> 'accountNumber'  as character varying) as "Payer Account",
                             cast(observations  ->  'observations' -> 'payeeVPA' -> 'account' ->> 'accountNumber' as character varying) as "Payee Account"
                      from transactions.vw_LiveTrans L where
                                    cast(L.observations  ->  'payee' ->> 'addr'  as text) = useraddress
                                                         and (CAST(dtTrxnTime AS date) = CURRENT_DATE-1 or CAST(dtTrxnTime AS date) = CURRENT_DATE) limit maxrecord;

Elseif(vpatype='Both') Then
		 Return query select L.iLiveMessageID as "ID", vcmsgid  as "Unique ID", L.dtTrxnTime at time zone 'utc' at time zone timezone as "Time",
                             cast(L.observations  ->  'payer' ->> 'addr'  as character varying) as "Payer VPA",
                             cast(L.observations  ->  'payer' -> 'attribs' -> 'identity' ->> 'verified_name'as character varying) as "Payer Name",
                             cast(L.observations  ->  'payee' ->> 'addr'  as character varying) as "Payee VPA",
                             cast(L.observations  ->  'payee' -> 'attribs' -> 'identity' ->> 'verified_name' as character varying) as "Payee Name",
                             L.dTransAmount as "Amount", L.bFRMPassed as "FRM Pass", L.score as "Score", L.vcrulename as "Rule",
                             cast(observations  ->  'observations' -> 'payerVPA' -> 'account' ->> 'accountNumber'  as character varying) as "Payer Account",
                             cast(observations  ->  'observations' -> 'payeeVPA' -> 'account' ->> 'accountNumber' as character varying) as "Payee Account"
                      from transactions.vw_LiveTrans L where cast(L.observations  ->  'payee' ->> 'addr'  as text) = useraddress or
                                        cast(L.observations  ->  'payer' ->> 'addr'  as text) = useraddress
                                    and (CAST(dtTrxnTime AS date) = CURRENT_DATE-1 or CAST(dtTrxnTime AS date) = CURRENT_DATE) limit maxrecord;

End If;
Elseif(party='Account')Then
	If(vpatype='Payer') Then
		Return query select L.iLiveMessageID as "ID", L.vcmsgid  as "Unique ID", L.dtTrxnTime at time zone 'utc' at time zone timezone as "Time",
                            cast(L.observations  ->  'payer' ->> 'addr'  as character varying) as "Payer VPA",
                            cast(L.observations  ->  'payer' -> 'attribs' -> 'identity' ->> 'verified_name'as character varying) as "Payer Name",
                            cast(L.observations  ->  'payee' ->> 'addr'  as character varying) as "Payee VPA",
                            cast(L.observations  ->  'payee' -> 'attribs' -> 'identity' ->> 'verified_name' as character varying) as "Payee Name",
                            L.dTransAmount as "Amount", L.bFRMPassed as "FRM Pass", L.score as "Score", L.vcrulename as "Rule",
                            cast(observations  ->  'observations' -> 'payerVPA' -> 'account' ->> 'accountNumber'  as character varying) as "Payer Account",
                            cast(observations  ->  'observations' -> 'payeeVPA' -> 'account' ->> 'accountNumber' as character varying) as "Payee Account"
                     from transactions.vw_LiveTrans L where cast(L.observations  ->  'observations' -> 'payerVPA' -> 'account' ->> 'accountNumber'  as text) = useraddress
                                                        and (CAST(dtTrxnTime AS date) = CURRENT_DATE-1 or CAST(dtTrxnTime AS date) = CURRENT_DATE) limit maxrecord;

Elseif(vpatype='Payee') Then
		Return query select L.iLiveMessageID as "ID", vcmsgid  as "Unique ID", L.dtTrxnTime at time zone 'utc' at time zone timezone as "Time",
                            cast(L.observations  ->  'payer' ->> 'addr'  as character varying) as "Payer VPA",
                            cast(L.observations  ->  'payer' -> 'attribs' -> 'identity' ->> 'verified_name'as character varying) as "Payer Name",
                            cast(L.observations  ->  'payee' ->> 'addr'  as character varying) as "Payee VPA",
                            cast(L.observations  ->  'payee' -> 'attribs' -> 'identity' ->> 'verified_name' as character varying) as "Payee Name",
                            L.dTransAmount as "Amount", L.bFRMPassed as "FRM Pass", L.score as "Score", L.vcrulename as "Rule",
                            cast(observations  ->  'observations' -> 'payerVPA' -> 'account' ->> 'accountNumber'  as character varying) as "Payer Account",
                            cast(observations  ->  'observations' -> 'payeeVPA' -> 'account' ->> 'accountNumber' as character varying) as "Payee Account"
                     from transactions.vw_LiveTrans L where
                                   cast(observations  ->  'observations' -> 'payeeVPA' -> 'account' ->> 'accountNumber'  as text) = useraddress
                                                        and (CAST(dtTrxnTime AS date) = CURRENT_DATE-1 or CAST(dtTrxnTime AS date) = CURRENT_DATE) limit maxrecord;

Elseif(vpatype='Both') Then
			Return query select L.iLiveMessageID as "ID", vcmsgid  as "Unique ID", L.dtTrxnTime at time zone 'utc' at time zone timezone as "Time",
                                cast(L.observations  ->  'payer' ->> 'addr'  as character varying) as "Payer VPA",
                                cast(L.observations  ->  'payer' -> 'attribs' -> 'identity' ->> 'verified_name'as character varying) as "Payer Name",
                                cast(L.observations  ->  'payee' ->> 'addr'  as character varying) as "Payee VPA",
                                cast(L.observations  ->  'payee' -> 'attribs' -> 'identity' ->> 'verified_name' as character varying) as "Payee Name",
                                L.dTransAmount as "Amount", L.bFRMPassed as "FRM Pass", L.score as "Score", L.vcrulename as "Rule",
                                cast(observations  ->  'observations' -> 'payerVPA' -> 'account' ->> 'accountNumber'  as character varying) as "Payer Account",
                                cast(observations  ->  'observations' -> 'payeeVPA' -> 'account' ->> 'accountNumber' as character varying) as "Payee Account"

                         from transactions.vw_LiveTrans L where
                                       cast(L.observations  ->  'observations' -> 'payeeVPA' -> 'account' ->> 'accountNumber'  as text) = useraddress or
                                           cast(L.observations  ->  'observations' -> 'payerVPA' -> 'account' ->> 'accountNumber'  as text) = useraddress
                                       and (CAST(dtTrxnTime as date) = CURRENT_DATE-1 or CAST(dtTrxnTime as date) = CURRENT_DATE) limit maxrecord;

End If;
End If;
End;

$BODY$;



CREATE OR REPLACE FUNCTION ui.getpartydtxnbyclass(
	party character varying,
	vpatype character varying,
	timezone character varying,
	txnclassinput character varying,
	useraddress character varying,
	maxrecord integer)
    RETURNS TABLE("ID" bigint, "Unique ID" character varying, "Time" timestamp without time zone, "Payer VPA" character varying, "Payer Name" character varying, "Payee VPA" character varying, "Payee Name" character varying, amount numeric, "FRM Pass" boolean, score integer, "Rule" character varying, "Payer Account" character varying, "Payee Account" character varying)
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE PARALLEL UNSAFE
    ROWS 1000

AS $BODY$
BEGIN
If(party='VPA') Then
	If(vpatype='Payer') Then
		Return query select L.iLiveMessageID as "ID", L.vcmsgid  as "Unique ID", L.dtTrxnTime at time zone 'utc' at time zone timezone as "Time",
                            cast(L.observations  ->  'payer' ->> 'addr'  as character varying) as "Payer VPA",
                            cast(L.observations  ->  'payer' -> 'attribs' -> 'identity' ->> 'verified_name'as character varying) as "Payer Name",
                            cast(L.observations  ->  'payee' ->> 'addr'  as character varying) as "Payee VPA",
                            cast(L.observations  ->  'payee' -> 'attribs' -> 'identity' ->> 'verified_name' as character varying) as "Payee Name",
                            L.dTransAmount as "Amount", L.bFRMPassed as "FRM Pass", L.score as "Score", vcrulename as "Rule",
                            cast(observations  ->  'observations' -> 'payerVPA' -> 'account' ->> 'accountNumber'  as character varying) as "Payer Account",
                            cast(observations  ->  'observations' -> 'payeeVPA' -> 'account' ->> 'accountNumber' as character varying) as "Payee Account"
                     from transactions.vw_LiveTrans L where
                               cast(L.observations  ->  'payer' ->> 'addr'  as text) = useraddress  and txnclass = txnclassinput
                                                        and (CAST(dtTrxnTime AS date) = CURRENT_DATE-1 or CAST(dtTrxnTime AS date) = CURRENT_DATE) limit maxrecord;

Elseif(vpatype='Payee') Then
		 Return query select L.iLiveMessageID as "ID", vcmsgid  as "Unique ID", L.dtTrxnTime at time zone 'utc' at time zone timezone as "Time",
                             cast(L.observations  ->  'payer' ->> 'addr'  as character varying) as "Payer VPA",
                             cast(L.observations  ->  'payer' -> 'attribs' -> 'identity' ->> 'verified_name'as character varying) as "Payer Name",
                             cast(L.observations  ->  'payee' ->> 'addr'  as character varying) as "Payee VPA",
                             cast(L.observations  ->  'payee' -> 'attribs' -> 'identity' ->> 'verified_name' as character varying) as "Payee Name",
                             L.dTransAmount as "Amount", L.bFRMPassed as "FRM Pass", L.score as "Score", L.vcrulename as "Rule",
                             cast(observations  ->  'observations' -> 'payerVPA' -> 'account' ->> 'accountNumber'  as character varying) as "Payer Account",
                             cast(observations  ->  'observations' -> 'payeeVPA' -> 'account' ->> 'accountNumber' as character varying) as "Payee Account"
                      from transactions.vw_LiveTrans L where
                                    cast(L.observations  ->  'payee' ->> 'addr'  as text) = useraddress and txnclass = txnclassinput
                                                         and (CAST(dtTrxnTime AS date) = CURRENT_DATE-1 or CAST(dtTrxnTime AS date) = CURRENT_DATE) limit maxrecord;

Elseif(vpatype='Both') Then
		 Return query select L.iLiveMessageID as "ID", vcmsgid  as "Unique ID", L.dtTrxnTime at time zone 'utc' at time zone timezone as "Time",
                             cast(L.observations  ->  'payer' ->> 'addr'  as character varying) as "Payer VPA",
                             cast(L.observations  ->  'payer' -> 'attribs' -> 'identity' ->> 'verified_name'as character varying) as "Payer Name",
                             cast(L.observations  ->  'payee' ->> 'addr'  as character varying) as "Payee VPA",
                             cast(L.observations  ->  'payee' -> 'attribs' -> 'identity' ->> 'verified_name' as character varying) as "Payee Name",
                             L.dTransAmount as "Amount", L.bFRMPassed as "FRM Pass", L.score as "Score", L.vcrulename as "Rule",
                             cast(observations  ->  'observations' -> 'payerVPA' -> 'account' ->> 'accountNumber'  as character varying) as "Payer Account",
                             cast(observations  ->  'observations' -> 'payeeVPA' -> 'account' ->> 'accountNumber' as character varying) as "Payee Account"
                      from transactions.vw_LiveTrans L where cast(L.observations  ->  'payee' ->> 'addr'  as text) = useraddress or
                                        cast(L.observations  ->  'payer' ->> 'addr'  as text) = useraddress and txnclass = txnclassinput
                                    and (CAST(dtTrxnTime AS date) = CURRENT_DATE-1 or CAST(dtTrxnTime AS date) = CURRENT_DATE) limit maxrecord;

End If;
Elseif(party='Account')Then
	If(vpatype='Payer') Then
		Return query select L.iLiveMessageID as "ID", L.vcmsgid  as "Unique ID", L.dtTrxnTime at time zone 'utc' at time zone timezone as "Time",
                            cast(L.observations  ->  'payer' ->> 'addr'  as character varying) as "Payer VPA",
                            cast(L.observations  ->  'payer' -> 'attribs' -> 'identity' ->> 'verified_name'as character varying) as "Payer Name",
                            cast(L.observations  ->  'payee' ->> 'addr'  as character varying) as "Payee VPA",
                            cast(L.observations  ->  'payee' -> 'attribs' -> 'identity' ->> 'verified_name' as character varying) as "Payee Name",
                            L.dTransAmount as "Amount", L.bFRMPassed as "FRM Pass", L.score as "Score", L.vcrulename as "Rule",
                            cast(observations  ->  'observations' -> 'payerVPA' -> 'account' ->> 'accountNumber'  as character varying) as "Payer Account",
                            cast(observations  ->  'observations' -> 'payeeVPA' -> 'account' ->> 'accountNumber' as character varying) as "Payee Account"
                     from transactions.vw_LiveTrans L where cast(L.observations  ->  'observations' -> 'payerVPA' -> 'account' ->> 'accountNumber'  as text) = useraddress
                                                        and L.txnclass = txnclassinput
                                                        and (CAST(dtTrxnTime AS date) = CURRENT_DATE-1 or CAST(dtTrxnTime AS date) = CURRENT_DATE) limit maxrecord;

Elseif(vpatype='Payee') Then
		Return query select L.iLiveMessageID as "ID", vcmsgid  as "Unique ID", L.dtTrxnTime at time zone 'utc' at time zone timezone as "Time",
                            cast(L.observations  ->  'payer' ->> 'addr'  as character varying) as "Payer VPA",
                            cast(L.observations  ->  'payer' -> 'attribs' -> 'identity' ->> 'verified_name'as character varying) as "Payer Name",
                            cast(L.observations  ->  'payee' ->> 'addr'  as character varying) as "Payee VPA",
                            cast(L.observations  ->  'payee' -> 'attribs' -> 'identity' ->> 'verified_name' as character varying) as "Payee Name",
                            L.dTransAmount as "Amount", L.bFRMPassed as "FRM Pass", L.score as "Score", L.vcrulename as "Rule",
                            cast(observations  ->  'observations' -> 'payerVPA' -> 'account' ->> 'accountNumber'  as character varying) as "Payer Account",
                            cast(observations  ->  'observations' -> 'payeeVPA' -> 'account' ->> 'accountNumber' as character varying) as "Payee Account"
                     from transactions.vw_LiveTrans L where
                                   cast(observations  ->  'observations' -> 'payeeVPA' -> 'account' ->> 'accountNumber'  as text) = useraddress
                                                        and L.txnclass = txnclassinput
                                                        and (CAST(dtTrxnTime AS date) = CURRENT_DATE-1 or CAST(dtTrxnTime AS date) = CURRENT_DATE) limit maxrecord;

Elseif(vpatype='Both') Then
			Return query select L.iLiveMessageID as "ID", vcmsgid  as "Unique ID", L.dtTrxnTime at time zone 'utc' at time zone timezone as "Time",
                                cast(L.observations  ->  'payer' ->> 'addr'  as character varying) as "Payer VPA",
                                cast(L.observations  ->  'payer' -> 'attribs' -> 'identity' ->> 'verified_name'as character varying) as "Payer Name",
                                cast(L.observations  ->  'payee' ->> 'addr'  as character varying) as "Payee VPA",
                                cast(L.observations  ->  'payee' -> 'attribs' -> 'identity' ->> 'verified_name' as character varying) as "Payee Name",
                                L.dTransAmount as "Amount", L.bFRMPassed as "FRM Pass", L.score as "Score", L.vcrulename as "Rule",
                                cast(observations  ->  'observations' -> 'payerVPA' -> 'account' ->> 'accountNumber'  as character varying) as "Payer Account",
                                cast(observations  ->  'observations' -> 'payeeVPA' -> 'account' ->> 'accountNumber' as character varying) as "Payee Account"
                         from transactions.vw_LiveTrans L where
                                       cast(L.observations  ->  'observations' -> 'payeeVPA' -> 'account' ->> 'accountNumber'  as text) = useraddress or
                                           cast(L.observations  ->  'observations' -> 'payerVPA' -> 'account' ->> 'accountNumber'  as text) = useraddress
                                       and L.txnclass = txnclassinput
                                       and (CAST(dtTrxnTime as date) = CURRENT_DATE-1 or CAST(dtTrxnTime as date) = CURRENT_DATE) limit maxrecord;

End If;
End If;
End;

$BODY$;


