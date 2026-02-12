DROP FUNCTION IF EXISTS masters.getlivedata(character varying, date, character varying, character varying, character varying, integer);

DROP FUNCTION IF EXISTS masters.getlivedata(character varying, timestamp without time zone, timestamp without time zone, character varying, character varying, character varying, integer);

CREATE OR REPLACE FUNCTION masters.getlivedata(
	vpatype character varying,
	dateinput date,
	vpaaddress character varying,
	timezone character varying,
	party character varying,
	maxrecord integer)
    RETURNS TABLE("Live Message ID" bigint, vcmsgid character varying, "Transaction ID" character varying  , "Transaction time" timestamp with time zone ,
				  "Settled Amount" numeric , "Transaction Amount" numeric, "Failed Amount" numeric,
				  "New Payer Flag" boolean, "Is New payee for Payer" boolean , "FRM Passed" boolean, "Observations" text , "Class" text , "MCC" text , "Device" text , "IP" text,
				  "Location" text , "Device ID" text , "OS" text, "Rule Name" character varying, "Score" text, "Status" text, "Decision Details" text,
				  "Payer VPA" character varying , "Payee VPA" character varying )
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE PARALLEL UNSAFE
    ROWS 1000

AS $BODY$
DECLARE num integer;
BEGIN
 If(party='Account') Then
			  If(vpatype='Payee') Then
				num =(select count(vld.ilivemessageid) from transactions.vw_livetrans_dashboard_with_joins vld where
					  cast(vld.dttrxntime at time zone 'Asia/Kolkata' at time zone timeZone as date)= dateinput and vcpayeeaccount = vpaaddress);

			 if(maxrecord > num)
			 Then
			   Return query  SELECT vld.ilivemessageid, vld.vcmsgid, vld.vcuniquetransid, vld.dttrxntime at time zone 'Asia/Kolkata' at time zone timeZone,
                                    vld.dsettledamount, vld.dtransamount, vld.dfailedamount, vld.bnewpayer, vld.bnewpayeeforpayer,
                                    vld.bfrmpassed, vld.observations::text, vld.txnclass, vld.mcc, vld.device, vld.ip, vld.location, vld.deviceid, vld.os, vld.vcrulename, vld.score, vld.status, vld.decisiondetails,
                                    payervpa,
                                    payeevpa
                             FROM transactions.vw_livetrans_dashboard_with_joins vld where
                                                       cast(vld.dttrxntime at time zone 'Asia/Kolkata' at time zone timeZone as date)= dateinput and vcpayeeaccount = vpaaddress ;
Else
				 RAISE EXCEPTION 'Too Many Records For...' USING HINT = 'Please check different account/address';
End If;

	Elseif(vpatype='Payer') Then

	 num =(select count(vld.ilivemessageid) from transactions.vw_livetrans_dashboard_with_joins vld where   cast(vld.dttrxntime at time zone 'Asia/Kolkata' at time zone timeZone as date)= dateinput
		   and vcpayeraccount = vpaaddress);

	 if(maxrecord > num )Then

	Return query SELECT vld.ilivemessageid, vld.vcmsgid, vld.vcuniquetransid, vld.dttrxntime at time zone 'Asia/Kolkata' at time zone timeZone,
                        vld.dsettledamount, vld.dtransamount, vld.dfailedamount, vld.bnewpayer, vld.bnewpayeeforpayer, vld.bfrmpassed, vld.observations::text,
                                          vld.txnclass, vld.mcc, vld.device, vld.ip, vld.location, vld.deviceid, vld.os, vld.vcrulename, vld.score, vld.status, vld.decisiondetails,
                        payervpa,
                        payeevpa
                 FROM transactions.vw_livetrans_dashboard_with_joins vld where  cast(vld.dttrxntime at time zone 'Asia/Kolkata' at time zone timeZone as date)= dateinput
                                                                           and vcpayeraccount = vpaaddress;

Else

	RAISE EXCEPTION 'Too Many Records For...' USING HINT = 'Please check different account/address';

End If;

Elseif(vpatype='Both') Then

 num =(select count(vld.ilivemessageid)  FROM transactions.vw_livetrans_dashboard_with_joins vld where
	    cast(vld.dttrxntime at time zone 'Asia/Kolkata' at time zone timeZone as date)= dateinput and
	   (vcpayeraccount = vpaaddress or vcpayeeaccount = vpaaddress));
	 if(maxrecord > num )
	 	Then
		Return query SELECT vld.ilivemessageid, vld.vcmsgid, vld.vcuniquetransid, vld.dttrxntime at time zone 'Asia/Kolkata' at time zone timeZone,
                            vld.dsettledamount, vld.dtransamount, vld.dfailedamount, vld.bnewpayer, vld.bnewpayeeforpayer,
                            vld.bfrmpassed, vld.observations::text, vld.txnclass, vld.mcc, vld.device, vld.ip,
                            vld.location, vld.deviceid, vld.os, vld.vcrulename, vld.score, vld.status, vld.decisiondetails,
                            payervpa,
                            payeevpa
                     FROM transactions.vw_livetrans_dashboard_with_joins vld where  cast(vld.dttrxntime at time zone 'Asia/Kolkata' at time zone timeZone as date)= dateinput
                                                                               and  ( vcpayeraccount = vpaaddress or vcpayeeaccount = vpaaddress);

Else
			RAISE EXCEPTION 'Too Many Records... ' USING HINT = 'Please check different account/address';
End If;
End If;

elseif(party='VPA') then
  If(vpatype='Payee') Then
				num =(select count(vld.ilivemessageid) from transactions.vw_livetrans_dashboard_with_joins vld where
					   cast(vld.dttrxntime at time zone 'Asia/Kolkata' at time zone timeZone as date)= dateinput and payeevpa = vpaaddress);

			 if(maxrecord > num)
			 Then
			   Return query  SELECT vld.ilivemessageid, vld.vcmsgid, vld.vcuniquetransid, vld.dttrxntime at time zone 'Asia/Kolkata' at time zone timeZone,
                                    vld.dsettledamount, vld.dtransamount, vld.dfailedamount, vld.bnewpayer, vld.bnewpayeeforpayer,
                                    vld.bfrmpassed, vld.observations::text, vld.txnclass, vld.mcc, vld.device, vld.ip, vld.location, vld.deviceid, vld.os, vld.vcrulename, vld.score, vld.status, vld.decisiondetails,
                                    payervpa,
                                    payeevpa
                             FROM transactions.vw_livetrans_dashboard_with_joins vld where
                                                          cast(vld.dttrxntime at time zone 'Asia/Kolkata' at time zone timeZone as date)= dateinput and payeevpa = vpaaddress;
Else
				 RAISE EXCEPTION 'Too Many Records For...' USING HINT = 'Please check different account/address';
End If;

	Elseif(vpatype='Payer') Then

	 num =(select count(vld.ilivemessageid) from transactions.vw_livetrans_dashboard_with_joins vld where
		   cast(vld.dttrxntime at time zone 'Asia/Kolkata' at time zone timeZone as date)= dateinput and payervpa = vpaaddress);
	 if(maxrecord > num )Then
	Return query SELECT vld.ilivemessageid, vld.vcmsgid, vld.vcuniquetransid, vld.dttrxntime at time zone 'Asia/Kolkata' at time zone timeZone,
                        vld.dsettledamount, vld.dtransamount, vld.dfailedamount, vld.bnewpayer, vld.bnewpayeeforpayer, vld.bfrmpassed, vld.observations::text,
                                          vld.txnclass, vld.mcc, vld.device, vld.ip, vld.location, vld.deviceid, vld.os, vld.vcrulename, vld.score, vld.status, vld.decisiondetails,
                        payervpa,
                        payeevpa
                 FROM transactions.vw_livetrans_dashboard_with_joins vld where  cast(vld.dttrxntime at time zone 'Asia/Kolkata' at time zone timeZone as date)= dateinput and payervpa = vpaaddress;

Else

	RAISE EXCEPTION 'Too Many Records For...' USING HINT = 'Please check different account/address';

End If;

Elseif(vpatype='Both') Then

 num =(select count(vld.ilivemessageid)  FROM transactions.vw_livetrans_dashboard_with_joins vld where
	    cast(vld.dttrxntime at time zone 'Asia/Kolkata' at time zone timeZone as date)= dateinput and
	   (payervpa = vpaaddress or payeevpa =vpaaddress));
	 if(maxrecord > num )
	 	Then
		Return query SELECT vld.ilivemessageid, vld.vcmsgid, vld.vcuniquetransid, vld.dttrxntime at time zone 'Asia/Kolkata' at time zone timeZone,
                            vld.dsettledamount, vld.dtransamount, vld.dfailedamount, vld.bnewpayer, vld.bnewpayeeforpayer,
                            vld.bfrmpassed, vld.observations::text, vld.txnclass, vld.mcc, vld.device, vld.ip,
                            vld.location, vld.deviceid, vld.os, vld.vcrulename, vld.score, vld.status, vld.decisiondetails,
                            payervpa,
                            payeevpa
                     FROM transactions.vw_livetrans_dashboard_with_joins vld where  cast(vld.dttrxntime at time zone 'Asia/Kolkata' at time zone timeZone as date)= dateinput
                                                                               and  (payervpa = vpaaddress or payeevpa = vpaaddress);
Else
			RAISE EXCEPTION 'Too Many Records... ' USING HINT = 'Please check different account/address';
End If;
End If;
End if;
End;

$BODY$;


DROP FUNCTION IF EXISTS ui.get_account_wise_rules_triggered(date);

CREATE OR REPLACE FUNCTION ui.get_account_wise_rules_triggered(
	inputdate date)
    RETURNS TABLE("Acc. External ID" character varying, "Type" text, "Rule Name" character varying, "Count" bigint, "Score" numeric)
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
