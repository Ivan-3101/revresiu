
DROP FUNCTION IF EXISTS masters.getlivedata(character varying, timestamp without time zone, timestamp without time zone, character varying);
DROP FUNCTION IF EXISTS masters.getlivedata(character varying, timestamp without time zone, timestamp without time zone, character varying, integer);
DROP FUNCTION IF EXISTS masters.getlivedata(character varying, timestamp without time zone, timestamp without time zone, character varying, character varying, integer);
DROP FUNCTION IF EXISTS masters.getlivedata(character varying, timestamp without time zone, timestamp without time zone, character varying, character varying, character varying, integer);

CREATE OR REPLACE FUNCTION masters.getlivedata(
	vpatype character varying,
	startdate timestamp without time zone,
	enddate timestamp without time zone,
	vpaaddress character varying,
	timezone character varying,
	party character varying,
	maxrecord integer)
    RETURNS TABLE(ilivemessageid bigint, vcmsgid character varying, vcuniquetransid character varying, dttrxntime timestamp without time zone, dsettledamount numeric, dtransamount numeric, dfailedamount numeric, bnewpayer boolean, bnewpayeeforpayer boolean, bfrmpassed boolean, dtupdatedtime timestamp without time zone, observations text, txnclass text, mcc text, device text, ip text, location text, deviceid text, os text, vcrulename character varying, score text, status text, decisiondetails text, payervcaddress character varying, payeevcaddress character varying)
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE PARALLEL UNSAFE
    ROWS 1000

AS $BODY$
DECLARE num integer;
BEGIN
 If(party='Account') Then
			  If(vpatype='Payee') Then
				num =(select count(vld.ilivemessageid) from transactions.vw_livetrans_dashboard vld where
					  vld.dttrxntime at time zone 'utc' at time zone timeZone >= startdate and vld.dttrxntime
					  at time zone 'utc' at time zone timeZone <= enddate and cast(vld.observations  ->  'observations' -> 'payeeVPA' -> 'account' ->> 'accountNumber'  as text) = vpaaddress);

			 if(maxrecord > num)
			 Then
			   Return query  SELECT vld.ilivemessageid, vld.vcmsgid, vld.vcuniquetransid, vld.dttrxntime at time zone 'utc' at time zone timeZone,
                                    vld.dsettledamount, vld.dtransamount, vld.dfailedamount, vld.bnewpayer, vld.bnewpayeeforpayer,
                                    vld.bfrmpassed, vld.dtupdatedtime, vld.observations::text, vld.txnclass, vld.mcc, vld.device, vld.ip, vld.location, vld.deviceid, vld.os, vld.vcrulename, vld.score, vld.status, vld.decisiondetails,
                                    cast(vld.observations  ->  'payer' ->> 'addr'  as character varying) as "Payer VPA",
                                    cast(vld.observations  ->  'payee' ->> 'addr'  as character varying) as "Payee VPA"
                             FROM transactions.vw_livetrans_dashboard vld where vld.dttrxntime at time zone 'utc' at time zone timeZone >= startdate and vld.dttrxntime at time zone 'utc' at time zone timeZone <=enddate
    and cast(vld.observations  ->  'observations' -> 'payeeVPA' -> 'account' ->> 'accountNumber'  as text) =vpaaddress ;
Else
				 RAISE EXCEPTION 'Too Many Records For...' USING HINT = 'Please check different account/address';
End If;

	Elseif(vpatype='Payer') Then

	 num =(select count(vld.ilivemessageid) from transactions.vw_livetrans_dashboard vld where  vld.dttrxntime at time zone 'utc' at
		   time zone timeZone >= startdate and vld.dttrxntime at time zone 'utc' at time zone timeZone <= enddate
		   and cast(vld.observations  ->  'observations' -> 'payerVPA' -> 'account' ->> 'accountNumber'  as text) = vpaaddress);

	 if(maxrecord > num )Then

	Return query SELECT vld.ilivemessageid, vld.vcmsgid, vld.vcuniquetransid, vld.dttrxntime at time zone 'utc' at time zone timeZone,
                        vld.dsettledamount, vld.dtransamount, vld.dfailedamount, vld.bnewpayer, vld.bnewpayeeforpayer, vld.bfrmpassed, vld.dtupdatedtime, vld.observations::text,
                                          vld.txnclass, vld.mcc, vld.device, vld.ip, vld.location, vld.deviceid, vld.os, vld.vcrulename, vld.score, vld.status, vld.decisiondetails,
                        cast(vld.observations  ->  'payer' ->> 'addr'  as character varying) as "Payer VPA",
                        cast(vld.observations  ->  'payee' ->> 'addr'  as character varying) as "Payee VPA"
                 FROM transactions.vw_livetrans_dashboard vld where vld.dttrxntime at time zone 'utc' at time zone timeZone >= startdate and vld.dttrxntime at time zone 'utc' at time zone timeZone <=enddate
    and cast(vld.observations  ->  'observations' -> 'payerVPA' -> 'account' ->> 'accountNumber'  as text) =vpaaddress;

Else

	RAISE EXCEPTION 'Too Many Records For...' USING HINT = 'Please check different account/address';

End If;

Elseif(vpatype='Both') Then

 num =(select count(vld.ilivemessageid)  FROM transactions.vw_livetrans_dashboard vld where vld.dttrxntime at time zone 'utc' at time zone timeZone >= startdate
         and vld.dttrxntime at time zone 'utc' at time zone timeZone <= enddate and
	   (cast(vld.observations  ->  'observations' -> 'payerVPA' -> 'account' ->> 'accountNumber'  as text) = vpaaddress or cast(vld.observations  ->  'observations' -> 'payeeVPA' -> 'account' ->> 'accountNumber'  as text) =vpaaddress));
	 if(maxrecord > num )
	 	Then
		Return query SELECT vld.ilivemessageid, vld.vcmsgid, vld.vcuniquetransid, vld.dttrxntime at time zone 'utc' at time zone timeZone,
                            vld.dsettledamount, vld.dtransamount, vld.dfailedamount, vld.bnewpayer, vld.bnewpayeeforpayer,
                            vld.bfrmpassed, vld.dtupdatedtime, vld.observations::text, vld.txnclass, vld.mcc, vld.device, vld.ip,
                            vld.location, vld.deviceid, vld.os, vld.vcrulename, vld.score, vld.status, vld.decisiondetails,
                            cast(vld.observations  ->  'payer' ->> 'addr'  as character varying) as "Payer VPA",
                            cast(vld.observations  ->  'payee' ->> 'addr'  as character varying) as "Payee VPA"
                     FROM transactions.vw_livetrans_dashboard vld where vld.dttrxntime at time zone 'utc' at time zone timeZone >=startdate
    and vld.dttrxntime at time zone 'utc' at time zone timeZone <=enddate
        and  (cast(vld.observations  ->  'observations' -> 'payerVPA' -> 'account' ->> 'accountNumber'  as text) = vpaaddress or cast(vld.observations  ->  'observations' -> 'payeeVPA' -> 'account' ->> 'accountNumber'  as text) =vpaaddress);

Else
			RAISE EXCEPTION 'Too Many Records... ' USING HINT = 'Please check different account/address';
End If;
End If;

elseif(party='VPA') then
  If(vpatype='Payee') Then
				num =(select count(vld.ilivemessageid) from transactions.vw_livetrans_dashboard vld where
					  vld.dttrxntime at time zone 'utc' at time zone timeZone >= startdate and vld.dttrxntime
					  at time zone 'utc' at time zone timeZone <= enddate and cast(vld.observations  ->  'payee' ->> 'addr'  as  character varying) = vpaaddress);

			 if(maxrecord > num)
			 Then
			   Return query  SELECT vld.ilivemessageid, vld.vcmsgid, vld.vcuniquetransid, vld.dttrxntime at time zone 'utc' at time zone timeZone,
                                    vld.dsettledamount, vld.dtransamount, vld.dfailedamount, vld.bnewpayer, vld.bnewpayeeforpayer,
                                    vld.bfrmpassed, vld.dtupdatedtime, vld.observations::text, vld.txnclass, vld.mcc, vld.device, vld.ip, vld.location, vld.deviceid, vld.os, vld.vcrulename, vld.score, vld.status, vld.decisiondetails,
                                    cast(vld.observations  ->  'payer' ->> 'addr'  as character varying) as "Payer VPA",
                                    cast(vld.observations  ->  'payee' ->> 'addr'  as character varying) as "Payee VPA"
                             FROM transactions.vw_livetrans_dashboard vld where vld.dttrxntime at time zone 'utc' at time zone timeZone >= startdate and vld.dttrxntime at time zone 'utc' at time zone timeZone <=enddate
    and cast(vld.observations  ->  'payee' ->> 'addr'  as  character varying) =vpaaddress ;
Else
				 RAISE EXCEPTION 'Too Many Records For...' USING HINT = 'Please check different account/address';
End If;

	Elseif(vpatype='Payer') Then

	 num =(select count(vld.ilivemessageid) from transactions.vw_livetrans_dashboard vld where  vld.dttrxntime at time zone 'utc' at
		   time zone timeZone >= startdate and vld.dttrxntime at time zone 'utc' at time zone timeZone <= enddate
		   and cast(vld.observations  ->  'payer' ->> 'addr'  as  character varying) = vpaaddress);

	 if(maxrecord > num )Then

	Return query SELECT vld.ilivemessageid, vld.vcmsgid, vld.vcuniquetransid, vld.dttrxntime at time zone 'utc' at time zone timeZone,
                        vld.dsettledamount, vld.dtransamount, vld.dfailedamount, vld.bnewpayer, vld.bnewpayeeforpayer, vld.bfrmpassed, vld.dtupdatedtime, vld.observations::text,
                                          vld.txnclass, vld.mcc, vld.device, vld.ip, vld.location, vld.deviceid, vld.os, vld.vcrulename, vld.score, vld.status, vld.decisiondetails,
                        cast(vld.observations  ->  'payer' ->> 'addr'  as character varying) as "Payer VPA",
                        cast(vld.observations  ->  'payee' ->> 'addr'  as character varying) as "Payee VPA"
                 FROM transactions.vw_livetrans_dashboard vld where vld.dttrxntime at time zone 'utc' at time zone timeZone >= startdate and vld.dttrxntime at time zone 'utc' at time zone timeZone <=enddate
    and cast(vld.observations  ->  'payer' ->> 'addr'  as  character varying) =vpaaddress;

Else

	RAISE EXCEPTION 'Too Many Records For...' USING HINT = 'Please check different account/address';

End If;

Elseif(vpatype='Both') Then

 num =(select count(vld.ilivemessageid)  FROM transactions.vw_livetrans_dashboard vld where vld.dttrxntime at time zone 'utc' at time zone timeZone >= startdate
         and vld.dttrxntime at time zone 'utc' at time zone timeZone <= enddate and
	   (cast(vld.observations  ->  'payer' ->> 'addr'  as character varying) = vpaaddress or cast(vld.observations  ->  'payee' ->> 'addr'  as character varying) =vpaaddress));
	 if(maxrecord > num )
	 	Then
		Return query SELECT vld.ilivemessageid, vld.vcmsgid, vld.vcuniquetransid, vld.dttrxntime at time zone 'utc' at time zone timeZone,
                            vld.dsettledamount, vld.dtransamount, vld.dfailedamount, vld.bnewpayer, vld.bnewpayeeforpayer,
                            vld.bfrmpassed, vld.dtupdatedtime, vld.observations::text, vld.txnclass, vld.mcc, vld.device, vld.ip,
                            vld.location, vld.deviceid, vld.os, vld.vcrulename, vld.score, vld.status, vld.decisiondetails,
                            cast(vld.observations  ->  'payer' ->> 'addr'  as character varying) as "Payer VPA",
                            cast(vld.observations  ->  'payee' ->> 'addr'  as character varying) as "Payee VPA"
                     FROM transactions.vw_livetrans_dashboard vld where vld.dttrxntime at time zone 'utc' at time zone timeZone >=startdate
    and vld.dttrxntime at time zone 'utc' at time zone timeZone <=enddate
        and  (cast(vld.observations  ->  'payer' ->> 'addr'  as character varying) = vpaaddress or cast(vld.observations  ->  'payee' ->> 'addr'  as character varying) =vpaaddress);

Else
			RAISE EXCEPTION 'Too Many Records... ' USING HINT = 'Please check different account/address';
End If;
End If;
End if;
End;

$BODY$;


DROP FUNCTION IF EXISTS ui.getpartydtxn(character varying, character varying, character varying, character varying, integer);
DROP FUNCTION IF EXISTS ui.getpartydtxnbyclass(character varying, character varying, character varying, character varying, character varying, integer);
DROP FUNCTION IF EXISTS ui.gettxnprofile(character varying, character varying, character varying, integer, character varying, integer);
DROP FUNCTION IF EXISTS ui.gettxnprofile(character varying, character varying, character varying, timestamp without time zone, character varying, character varying, integer);
DROP FUNCTION IF EXISTS ui.gettxnprofilebyclass(character varying, character varying, character varying, integer, character varying, character varying, integer);
DROP FUNCTION IF EXISTS ui.gettxnprofilebyclass(character varying, character varying, character varying, timestamp without time zone, character varying, character varying, character varying, integer);
DROP FUNCTION IF EXISTS ui.gettxnprofileselectedtxn(character varying, character varying, character varying, character varying, date);
DROP FUNCTION IF EXISTS ui.gettxnprofileselectedtxnbyclass(character varying, character varying, character varying, character varying, character varying, date);


CREATE OR REPLACE FUNCTION ui.getalerttrxn(
	timezone character varying,
	riskscore integer,
	lasttime character varying,
	maxrecord integer)
    RETURNS TABLE("Unique ID" character varying, "Time" timestamp without time zone, "Payer VPA" character varying, "Payee VPA" character varying, amount numeric, "Remark" character varying, score integer)
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE PARALLEL UNSAFE
    ROWS 1000

AS $BODY$
BEGIN
Return query select vcmsgid as "Unique ID", dtTrxnTime at time zone 'utc' at time zone timeZone as "Time", Payer.vcAddress as "Payer VPA",
		Payee.vcAddress as "Payee VPA", dTransAmount as "Amount", ld.vcremark as "Remark", ld.dscore as  "Rule Score" from transactions.livetrans L,
		masters.VPA Payer, masters.VPA Payee, transactions.LiveDecisionDetails ld where Payer.iVPAID = L.iPayerVPAID and Payee.iVPAID = L.iPayeeVPAID
		and ld.ilivemessageid= L.ilivemessageid and L.score= RiskScore and ld.dscore > 0 and dtTrxnTime >now() - lastTime::interval
		order by dtTrxnTime desc limit maxrecord;
End;
$BODY$;


CREATE TYPE ui.decisiondetails AS
    (
    score numeric,
    ruleno numeric,
    remarks text,
    rulename text
    );

CREATE OR REPLACE FUNCTION ui.getdecisiondetails(
	vcmsgidinput character varying)
    RETURNS SETOF ui.decisiondetails
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE PARALLEL UNSAFE
    ROWS 1000

AS $BODY$
DECLARE
tempresult text;
qtemp text;
BEGIN
tempresult = (select l.result  ->  'score' ->> 'decisiondetails' from transactions.vw_LiveTrans l where vcmsgid=vcmsgidinput);
if(tempresult is not null)then
	qtemp:= 'select * from json_populate_recordset(null::ui.decisiondetails, '''||tempresult||''')';
else
	qtemp:= 'select * from json_populate_recordset(null::ui.decisiondetails, ''[]'')';
end if;
RETURN QUERY execute qtemp;
END
$BODY$;


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

CREATE OR REPLACE FUNCTION ui.gettxnprofile(
	vpatype character varying,
	txntype character varying,
	timezone character varying,
	ilivemsgid integer,
	vpaaddress character varying,
	maxrecord integer)
    RETURNS TABLE("ID" bigint, "Unique ID" character varying, "Time" timestamp without time zone, "Payer VPA" character varying, "Payer Name" character varying, "Payee VPA" character varying, "Payee Name" character varying, amount numeric, "FRM Pass" boolean, score integer, "Rule" character varying)
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE PARALLEL UNSAFE
    ROWS 1000

AS $BODY$
DECLARE num integer;
BEGIN
If(txntype='previous') Then
	If(vpatype='Payee') Then
		   Return query select L.iLiveMessageID as "ID", L.vcmsgid  as "Unique ID", L.dtTrxnTime at time zone 'utc' at time zone timezone as "Time",
                               cast(L.observations  ->  'payer' ->> 'addr'  as character varying) as "Payer VPA",
                               cast(L.observations  ->  'payer' -> 'attribs' -> 'identity' ->> 'verified_name'as character varying) as "Payer Name",
                               cast(L.observations  ->  'payee' ->> 'addr'  as character varying) as "Payee VPA",
                               cast(L.observations  ->  'payee' -> 'attribs' -> 'identity' ->> 'verified_name' as character varying) as "Payee Name",
                               L.dTransAmount as "Amount", L.bFRMPassed as "FRM Pass", L.score as "Score", L.vcrulename as "Rule" from transactions.vw_LiveTrans L where
                                  L.iLiveMessageID < ilivemsgid and cast(L.observations  ->  'payee' ->> 'addr'  as  character varying) = vpaaddress limit maxrecord;

Elseif(vpatype='Payer') Then
		 Return query select L.iLiveMessageID as "ID", L.vcmsgid  as "Unique ID", L.dtTrxnTime at time zone 'utc' at time zone timezone as "Time",
                             cast(L.observations  ->  'payer' ->> 'addr'  as character varying) as "Payer VPA",
                             cast(L.observations  ->  'payer' -> 'attribs' -> 'identity' ->> 'verified_name'as character varying) as "Payer Name",
                             cast(L.observations  ->  'payee' ->> 'addr'  as character varying) as "Payee VPA",
                             cast(L.observations  ->  'payee' -> 'attribs' -> 'identity' ->> 'verified_name' as character varying) as "Payee Name",
                             L.dTransAmount as "Amount", L.bFRMPassed as "FRM Pass", L.score as "Score", L.vcrulename as "Rule"
                      from transactions.vw_LiveTrans L where L.iLiveMessageID < ilivemsgid and cast(L.observations  ->  'payer' ->> 'addr'  as  character varying)= vpaaddress limit maxrecord;
End If;
Elseif(txntype='subsequent')Then
	If(vpatype='Payee') Then
		   Return query select L.iLiveMessageID as "ID", L.vcmsgid  as "Unique ID", L.dtTrxnTime at time zone 'utc' at time zone timezone as "Time",
                               cast(L.observations  ->  'payer' ->> 'addr'  as character varying) as "Payer VPA",
                               cast(L.observations  ->  'payer' -> 'attribs' -> 'identity' ->> 'verified_name'as character varying) as "Payer Name",
                               cast(L.observations  ->  'payee' ->> 'addr'  as character varying) as "Payee VPA",
                               cast(L.observations  ->  'payee' -> 'attribs' -> 'identity' ->> 'verified_name' as character varying) as "Payee Name",
                               L.dTransAmount as "Amount", L.bFRMPassed as "FRM Pass", L.score as "Score", L.vcrulename as "Rule" from transactions.vw_LiveTrans L where
                                      L.iLiveMessageID > ilivemsgid and cast(L.observations  ->  'payee' ->> 'addr'  as  character varying) =vpaaddress limit maxrecord;

Elseif(vpatype='Payer') Then
		 Return query select L.iLiveMessageID as "ID", L.vcmsgid  as "Unique ID", L.dtTrxnTime at time zone 'utc' at time zone timezone as "Time",
                             cast(L.observations  ->  'payer' ->> 'addr'  as character varying) as "Payer VPA",
                             cast(L.observations  ->  'payer' -> 'attribs' -> 'identity' ->> 'verified_name'as character varying) as "Payer Name",
                             cast(L.observations  ->  'payee' ->> 'addr'  as character varying) as "Payee VPA",
                             cast(L.observations  ->  'payee' -> 'attribs' -> 'identity' ->> 'verified_name' as character varying) as "Payee Name",
                             L.dTransAmount as "Amount", L.bFRMPassed as "FRM Pass", L.score as "Score", L.vcrulename as "Rule" from transactions.vw_LiveTrans L where
                                    L.iLiveMessageID > ilivemsgid and cast(L.observations  ->  'payer' ->> 'addr'  as  character varying) = vpaaddress limit maxrecord;
End If;
End If;
End;

$BODY$;

CREATE OR REPLACE FUNCTION ui.gettxnprofilebyclass(
	vpatype character varying,
	txntype character varying,
	timezone character varying,
	ilivemsgid integer,
	vpaaddress character varying,
	txnclassinput character varying,
	maxrecord integer)
    RETURNS TABLE("ID" bigint, "Unique ID" character varying, "Time" timestamp without time zone, "Payer VPA" character varying, "Payer Name" character varying, "Payee VPA" character varying, "Payee Name" character varying, amount numeric, "FRM Pass" boolean, score integer, "Rule" character varying)
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE PARALLEL UNSAFE
    ROWS 1000

AS $BODY$
DECLARE num integer;
BEGIN
If(txntype='previous') Then
	If(vpatype='Payee') Then
		   Return query select L.iLiveMessageID as "ID", L.vcmsgid  as "Unique ID", L.dtTrxnTime at time zone 'utc' at time zone timezone as "Time",
                               cast(L.observations  ->  'payer' ->> 'addr'  as character varying) as "Payer VPA",
                               cast(L.observations  ->  'payer' -> 'attribs' -> 'identity' ->> 'verified_name'as character varying) as "Payer Name",
                               cast(L.observations  ->  'payee' ->> 'addr'  as character varying) as "Payee VPA",
                               cast(L.observations  ->  'payee' -> 'attribs' -> 'identity' ->> 'verified_name' as character varying) as "Payee Name",
                               L.dTransAmount as "Amount", L.bFRMPassed as "FRM Pass", L.score as "Score",
                               L.vcrulename as "Rule" from transactions.vw_LiveTrans L where L.iLiveMessageID < ilivemsgid
                                                                                         and L.txnclass=txnclassinput and cast(L.observations  ->  'payee' ->> 'addr'  as  character varying)=vpaaddress limit maxrecord;

Elseif(vpatype='Payer') Then
		 Return query select L.iLiveMessageID as "ID", L.vcmsgid  as "Unique ID", L.dtTrxnTime at time zone 'utc' at time zone timezone as "Time",
                             cast(L.observations  ->  'payer' ->> 'addr'  as character varying) as "Payer VPA",
                             cast(L.observations  ->  'payer' -> 'attribs' -> 'identity' ->> 'verified_name'as character varying) as "Payer Name",
                             cast(L.observations  ->  'payee' ->> 'addr'  as character varying) as "Payee VPA",
                             cast(L.observations  ->  'payee' -> 'attribs' -> 'identity' ->> 'verified_name' as character varying) as "Payee Name",
                             L.dTransAmount as "Amount", L.bFRMPassed as "FRM Pass", L.score as "Score", L.vcrulename as "Rule" from
                                transactions.vw_LiveTrans L where L.iLiveMessageID < ilivemsgid
                                                              and L.txnclass=txnclassinput and cast(L.observations  ->  'payer' ->> 'addr'  as  character varying)=vpaaddress limit maxrecord;
End If;
Elseif(txntype='subsequent')Then
	If(vpatype='Payee') Then
		   Return query select L.iLiveMessageID as "ID", L.vcmsgid  as "Unique ID", L.dtTrxnTime at time zone 'utc' at time zone timezone as "Time",
                               cast(L.observations  ->  'payer' ->> 'addr'  as character varying) as "Payer VPA",
                               cast(L.observations  ->  'payer' -> 'attribs' -> 'identity' ->> 'verified_name'as character varying) as "Payer Name",
                               cast(L.observations  ->  'payee' ->> 'addr'  as character varying) as "Payee VPA",
                               cast(L.observations  ->  'payee' -> 'attribs' -> 'identity' ->> 'verified_name' as character varying) as "Payee Name",
                               L.dTransAmount as "Amount", L.bFRMPassed as "FRM Pass", L.score as "Score", L.vcrulename as "Rule" from transactions.vw_LiveTrans L where L.iLiveMessageID > ilivemsgid
                                                                                                                                                                     and L.txnclass=txnclassinput and cast(L.observations  ->  'payee' ->> 'addr'  as  character varying)=vpaaddress limit maxrecord;

Elseif(vpatype='Payer') Then
		 Return query select L.iLiveMessageID as "ID", L.vcmsgid  as "Unique ID", L.dtTrxnTime at time zone 'utc' at time zone timezone as "Time",
                             cast(L.observations  ->  'payer' ->> 'addr'  as character varying) as "Payer VPA",
                             cast(L.observations  ->  'payer' -> 'attribs' -> 'identity' ->> 'verified_name'as character varying) as "Payer Name",
                             cast(L.observations  ->  'payee' ->> 'addr'  as character varying) as "Payee VPA",
                             cast(L.observations  ->  'payee' -> 'attribs' -> 'identity' ->> 'verified_name' as character varying) as "Payee Name",
                             L.dTransAmount as "Amount", L.bFRMPassed as "FRM Pass", L.score as "Score", L.vcrulename as "Rule"
                      from transactions.vw_LiveTrans L where L.iLiveMessageID > ilivemsgid and L.txnclass=txnclassinput
                                                         and cast(L.observations  ->  'payer' ->> 'addr'  as  character varying)=vpaaddress limit maxrecord;
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


CREATE OR REPLACE FUNCTION ui.gettxnprofileselectedtxn(
	vpatype character varying,
	timezone character varying,
	msgid character varying,
	vpaaddress character varying,
	txndate date)
    RETURNS TABLE("ID" bigint, "Unique ID" character varying, "Time" timestamp without time zone, "Payer VPA" character varying, "Payer Name" character varying, "Payee VPA" character varying, "Payee Name" character varying, amount numeric, "FRM Pass" boolean, score integer, "Rule" character varying)
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE PARALLEL UNSAFE
    ROWS 1000

AS $BODY$
DECLARE num integer;
BEGIN

	If(vpatype='Payee') Then
		   Return query select L.iLiveMessageID as "ID", L.vcmsgid  as "Unique ID", L.dtTrxnTime at time zone 'utc' at time zone timezone as "Time",
                               cast(L.observations  ->  'payer' ->> 'addr'  as character varying) as "Payer VPA",
                               cast(L.observations  ->  'payer' -> 'attribs' -> 'identity' ->> 'verified_name'as character varying) as "Payer Name",
                               cast(L.observations  ->  'payee' ->> 'addr'  as character varying) as "Payee VPA",
                               cast(L.observations  ->  'payee' -> 'attribs' -> 'identity' ->> 'verified_name' as character varying) as "Payee Name",
                               L.dTransAmount as "Amount", L.bFRMPassed as "FRM Pass", L.score as "Score", vcrulename as "Rule" from transactions.vw_LiveTrans L
                        where vcmsgid=msgid and cast(L.observations  ->  'payee' ->> 'addr'  as  character varying) = vpaaddress and
                                      cast(L.dtTrxnTime at time zone 'utc' at time zone timezone as date)=txndate;

Elseif(vpatype='Payer') Then
		 Return query select L.iLiveMessageID as "ID", L.vcmsgid  as "Unique ID", L.dtTrxnTime at time zone 'utc' at time zone timezone as "Time",
                             cast(L.observations  ->  'payer' ->> 'addr'  as character varying) as "Payer VPA",
                             cast(L.observations  ->  'payer' -> 'attribs' -> 'identity' ->> 'verified_name'as character varying) as "Payer Name",
                             cast(L.observations  ->  'payee' ->> 'addr'  as character varying) as "Payee VPA",
                             cast(L.observations  ->  'payee' -> 'attribs' -> 'identity' ->> 'verified_name' as character varying) as "Payee Name",
                             L.dTransAmount as "Amount", L.bFRMPassed as "FRM Pass", L.score as "Score", vcrulename as "Rule" from transactions.vw_LiveTrans L where
                                    vcmsgid=msgid and cast(L.observations  ->  'payer' ->> 'addr'  as  character varying) = vpaaddress and cast(L.dtTrxnTime at time zone 'utc' at time zone timezone as date) = txndate;

End If;
End;

$BODY$;


CREATE OR REPLACE FUNCTION ui.gettxnprofileselectedtxnbyclass(
	vpatype character varying,
	timezone character varying,
	msgid character varying,
	vpaaddress character varying,
	txnclassinput character varying,
	txndate date)
    RETURNS TABLE("ID" bigint, "Unique ID" character varying, "Time" timestamp without time zone, "Payer VPA" character varying, "Payer Name" character varying, "Payee VPA" character varying, "Payee Name" character varying, amount numeric, "FRM Pass" boolean, score integer, "Rule" character varying)
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE PARALLEL UNSAFE
    ROWS 1000

AS $BODY$
DECLARE num integer;
BEGIN

	If(vpatype='Payee') Then
		   Return query select L.iLiveMessageID as "ID", L.vcmsgid  as "Unique ID", L.dtTrxnTime at time zone 'utc' at time zone timezone as "Time",
                               cast(L.observations  ->  'payer' ->> 'addr'  as character varying) as "Payer VPA",
                               cast(L.observations  ->  'payer' -> 'attribs' -> 'identity' ->> 'verified_name'as character varying) as "Payer Name",
                               cast(L.observations  ->  'payee' ->> 'addr'  as character varying) as "Payee VPA",
                               cast(L.observations  ->  'payee' -> 'attribs' -> 'identity' ->> 'verified_name' as character varying) as "Payee Name",
                               L.dTransAmount as "Amount", L.bFRMPassed as "FRM Pass", L.score as "Score", vcrulename as "Rule" from transactions.vw_LiveTrans L
                        where vcmsgid=msgid and cast(L.observations  ->  'payee' ->> 'addr'  as  character varying) =vpaaddress and L.txnclass=txnclassinput
                          and cast(L.dtTrxnTime at time zone 'utc' at time zone timezone as date)=txndate;
Elseif(vpatype='Payer') Then
		 Return query select L.iLiveMessageID as "ID", L.vcmsgid  as "Unique ID", L.dtTrxnTime at time zone 'utc' at time zone timezone as "Time",
                             cast(L.observations  ->  'payer' ->> 'addr'  as character varying) as "Payer VPA",
                             cast(L.observations  ->  'payer' -> 'attribs' -> 'identity' ->> 'verified_name'as character varying) as "Payer Name",
                             cast(L.observations  ->  'payee' ->> 'addr'  as character varying) as "Payee VPA",
                             cast(L.observations  ->  'payee' -> 'attribs' -> 'identity' ->> 'verified_name' as character varying) as "Payee Name",
                             L.dTransAmount as "Amount", L.bFRMPassed as "FRM Pass", L.score as "Score", vcrulename as "Rule" from transactions.vw_LiveTrans L
                      where vcmsgid=msgid and cast(L.observations  ->  'payer' ->> 'addr'  as  character varying)= vpaaddress and L.txnclass=txnclassinput
                        and cast(L.dtTrxnTime at time zone 'utc' at time zone timezone as date)=txndate;
End If;
End;

$BODY$;


CREATE OR REPLACE FUNCTION ui.gettypeoptions(
	typeinput character varying)
    RETURNS TABLE(label text, value text)
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE PARALLEL UNSAFE
    ROWS 1000

AS $BODY$
DECLARE
BEGIN
if(typeinput ='Account')then
	return query SELECT X.* FROM   (VALUES ('Payer', 'Payer'),('Payee', 'Payee'), ('Both', 'Both')) AS X ("label", "value");
elseif(typeinput ='VPA') then
	return query SELECT X.* FROM   (VALUES ('Payer', 'Payer'),('Payee', 'Payee')) AS X ("label", "value");
end if;
END
$BODY$;
