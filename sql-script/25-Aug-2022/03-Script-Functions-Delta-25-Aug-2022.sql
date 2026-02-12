


DROP FUNCTION IF EXISTS masters.getlivedata(character varying, timestamp without time zone, timestamp without time zone, character varying, character varying, character varying, integer);


CREATE OR REPLACE FUNCTION masters.getlivedata(
	vpatype character varying,
	startdate timestamp without time zone,
	enddate timestamp without time zone,
	vpaaddress character varying,
	timezone character varying,
	party character varying,
	maxrecord integer)
    RETURNS TABLE("Live Message ID" bigint, vcmsgid character varying, "Transaction ID" character varying, "Transaction time" timestamp with time zone, "Settled Amount" numeric, "Transaction Amount" numeric, "Failed Amount" numeric, "New Payer Flag" boolean, "Is New payee for Payer" boolean, "FRM Passed" boolean, "Observations" text, "Class" text, "MCC" text, "Device" text, "IP" text, "Location" text, "Device ID" text, "OS" text, "Rule Name" character varying, "Score" text, "Status" text, "Decision Details" text, "Payer VPA" character varying, "Payee VPA" character varying)
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE PARALLEL UNSAFE
    ROWS 1000

AS $BODY$
DECLARE num integer;
BEGIN
 If(party='Account') Then
			  If(vpatype='Payee') Then

num =(select count(ilivemessageid) from transactions.livetrans l, (
   	select ivpaid from masters.vpa a,masters.accounts b where a.iaccountid=b.iaccountid
   	and b.vcexternalaccountid=vpaaddress) m
   	where (l.ipayeevpaid =m.ivpaid ) and  cast(dttrxntime at time zone 'Asia/Kolkata' at time zone timezone as date)
      between  cast(startdate at time zone 'Asia/Kolkata' at time zone timeZone as date) and cast(enddate at time zone 'Asia/Kolkata' at time zone timeZone as date));

			 if(maxrecord > num)
			 Then
			   Return query select l.ilivemessageid, l.vcmsgid, l.vcuniquetransid, l.dttrxntime at time zone 'Asia/Kolkata' at time zone timezone,
        l.dsettledamount, l.dtransamount, l.dfailedamount, l.bnewpayer, l.bnewpayeeforpayer,
        l.bfrmpassed, l.observations::text,
       ((l.observations -> 'txn'::text) -> 'class'::text)::text AS txnclass,
   	 ((l.observations -> 'payee'::text) -> 'mcc'::text)::text AS mcc,
       (((l.observations -> 'payer'::text) -> 'attribs'::text) -> 'device'::text)::text AS device,
       ((((l.observations -> 'payer'::text) -> 'attribs'::text) -> 'device'::text) -> 'ip'::text)::text AS ip,
       ((((l.observations -> 'payer'::text) -> 'attribs'::text) -> 'device'::text) -> 'location'::text)::text AS location,
       ((((l.observations -> 'payer'::text) -> 'attribs'::text) -> 'device'::text) -> 'id'::text)::text AS deviceid,
       ((((l.observations -> 'payer'::text) -> 'attribs'::text) -> 'device'::text) -> 'os'::text)::text AS os,
       ''::character varying as vcrulename,
       ((l.result -> 'score'::text) -> 'score'::text)::text AS score,
       (l.result -> 'status'::text)::text AS status,
       ((l.result -> 'score'::text) -> 'decisiondetails'::text)::text AS decisiondetails,
   	(((l.observations -> 'observations'::text) -> 'payerVPA'::text) -> 'externalId'::text)::character varying AS payervpa,
        (((l.observations -> 'observations'::text) -> 'payerVPA'::text) -> 'externalId'::text)::character varying AS payeevpa
   	 from transactions.livetrans l, (
   	select ivpaid from masters.vpa a,masters.accounts b where a.iaccountid=b.iaccountid
   	and b.vcexternalaccountid=vpaaddress) m
   	where (l.ipayeevpaid =m.ivpaid ) and  cast(dttrxntime at time zone 'Asia/Kolkata' at time zone timezone as date)
      between  cast(startdate at time zone 'Asia/Kolkata' at time zone timeZone as date) and cast(enddate at time zone 'Asia/Kolkata' at time zone timeZone as date);

			  Else
				 RAISE EXCEPTION 'Too Many Records For...' USING HINT = 'Please check different account/address';
End If;

	Elseif(vpatype='Payer') Then

	 num =(select count(ilivemessageid) from transactions.livetrans l, (
   	select ivpaid from masters.vpa a,masters.accounts b where a.iaccountid=b.iaccountid
   	and b.vcexternalaccountid = vpaaddress) m
   	where (l.ipayervpaid =m.ivpaid ) and  cast(dttrxntime at time zone 'Asia/Kolkata' at time zone timezone as date)
      between  cast(startdate at time zone 'Asia/Kolkata' at time zone timeZone as date) and cast(enddate at time zone 'Asia/Kolkata' at time zone timeZone as date));

	 if(maxrecord > num )Then

	Return query select l.ilivemessageid, l.vcmsgid, l.vcuniquetransid, l.dttrxntime at time zone 'Asia/Kolkata' at time zone timezone,
        l.dsettledamount, l.dtransamount, l.dfailedamount, l.bnewpayer, l.bnewpayeeforpayer,
        l.bfrmpassed, l.observations::text,
       ((l.observations -> 'txn'::text) -> 'class'::text)::text AS txnclass,
   	 ((l.observations -> 'payee'::text) -> 'mcc'::text)::text AS mcc,
       (((l.observations -> 'payer'::text) -> 'attribs'::text) -> 'device'::text)::text AS device,
       ((((l.observations -> 'payer'::text) -> 'attribs'::text) -> 'device'::text) -> 'ip'::text)::text AS ip,
       ((((l.observations -> 'payer'::text) -> 'attribs'::text) -> 'device'::text) -> 'location'::text)::text AS location,
       ((((l.observations -> 'payer'::text) -> 'attribs'::text) -> 'device'::text) -> 'id'::text)::text AS deviceid,
       ((((l.observations -> 'payer'::text) -> 'attribs'::text) -> 'device'::text) -> 'os'::text)::text AS os,
       ''::character varying as vcrulename,
       ((l.result -> 'score'::text) -> 'score'::text)::text AS score,
       (l.result -> 'status'::text)::text AS status,
       ((l.result -> 'score'::text) -> 'decisiondetails'::text)::text AS decisiondetails,
   	(((l.observations -> 'observations'::text) -> 'payerVPA'::text) -> 'externalId'::text)::character varying AS payervpa,
        (((l.observations -> 'observations'::text) -> 'payerVPA'::text) -> 'externalId'::text)::character varying AS payeevpa
   	 from transactions.livetrans l, (
   	select ivpaid from masters.vpa a,masters.accounts b where a.iaccountid=b.iaccountid
   	and b.vcexternalaccountid=vpaaddress) m
   	where (l.ipayervpaid =m.ivpaid ) and  cast(dttrxntime at time zone 'Asia/Kolkata' at time zone timezone as date)
      between  cast(startdate at time zone 'Asia/Kolkata' at time zone timeZone as date) and cast(enddate at time zone 'Asia/Kolkata' at time zone timeZone as date);


Else

	RAISE EXCEPTION 'Too Many Records For...' USING HINT = 'Please check different account/address';

End If;

Elseif(vpatype='Both') Then

 num =(select count(ilivemessageid) from transactions.livetrans l, (
   	select ivpaid from masters.vpa a,masters.accounts b where a.iaccountid=b.iaccountid
   	and b.vcexternalaccountid=vpaaddress) m
   	where (l.ipayervpaid = m.ivpaid or l.ipayeevpaid =m.ivpaid ) and  cast(dttrxntime at time zone 'Asia/Kolkata' at time zone timezone as date)
      between cast(startdate at time zone 'Asia/Kolkata' at time zone timeZone as date) and cast(enddate at time zone 'Asia/Kolkata' at time zone timeZone as date));

	 if(maxrecord > num )
	 	Then
		Return query

			   select l.ilivemessageid, l.vcmsgid, l.vcuniquetransid, l.dttrxntime at time zone 'Asia/Kolkata' at time zone timezone,
        l.dsettledamount, l.dtransamount, l.dfailedamount, l.bnewpayer, l.bnewpayeeforpayer,
        l.bfrmpassed, l.observations::text,
       ((l.observations -> 'txn'::text) -> 'class'::text)::text AS txnclass,
   	 ((l.observations -> 'payee'::text) -> 'mcc'::text)::text AS mcc,
       (((l.observations -> 'payer'::text) -> 'attribs'::text) -> 'device'::text)::text AS device,
       ((((l.observations -> 'payer'::text) -> 'attribs'::text) -> 'device'::text) -> 'ip'::text)::text AS ip,
       ((((l.observations -> 'payer'::text) -> 'attribs'::text) -> 'device'::text) -> 'location'::text)::text AS location,
       ((((l.observations -> 'payer'::text) -> 'attribs'::text) -> 'device'::text) -> 'id'::text)::text AS deviceid,
       ((((l.observations -> 'payer'::text) -> 'attribs'::text) -> 'device'::text) -> 'os'::text)::text AS os,
       ''::character varying as vcrulename,
       ((l.result -> 'score'::text) -> 'score'::text)::text AS score,
       (l.result -> 'status'::text)::text AS status,
       ((l.result -> 'score'::text) -> 'decisiondetails'::text)::text AS decisiondetails,
   	(((l.observations -> 'observations'::text) -> 'payerVPA'::text) -> 'externalId'::text)::character varying AS payervpa,
        (((l.observations -> 'observations'::text) -> 'payerVPA'::text) -> 'externalId'::text)::character varying AS payeevpa
   	 from transactions.livetrans l, (
   	select ivpaid from masters.vpa a,masters.accounts b where a.iaccountid=b.iaccountid
   	and b.vcexternalaccountid=vpaaddress) m
   	where (l.ipayervpaid = m.ivpaid or l.ipayeevpaid =m.ivpaid ) and  cast(dttrxntime at time zone 'Asia/Kolkata' at time zone timezone as date)
      between cast(startdate at time zone 'Asia/Kolkata' at time zone timeZone as date) and cast(enddate at time zone 'Asia/Kolkata' at time zone timeZone as date);

Else
			RAISE EXCEPTION 'Too Many Records... ' USING HINT = 'Please check different account/address';
End If;
End If;

elseif(party='VPA') then
  If(vpatype='Payee') Then

 num =(select count(ilivemessageid) from transactions.livetrans l, (
   	select ivpaid from masters.vpa a where a.vcaddress=vpaaddress) m
   	where ( l.ipayeevpaid =m.ivpaid ) and  cast(dttrxntime at time zone 'Asia/Kolkata' at time zone timezone as date)
      between cast(startdate at time zone 'Asia/Kolkata' at time zone timeZone as date) and cast(enddate at time zone 'Asia/Kolkata' at time zone timeZone as date));

			 if(maxrecord > num)
			 Then
			   Return query select l.ilivemessageid, l.vcmsgid, l.vcuniquetransid, l.dttrxntime at time zone 'Asia/Kolkata' at time zone timezone,
        l.dsettledamount, l.dtransamount, l.dfailedamount, l.bnewpayer, l.bnewpayeeforpayer,
        l.bfrmpassed, l.observations::text,
       ((l.observations -> 'txn'::text) -> 'class'::text)::text AS txnclass,
   	 ((l.observations -> 'payee'::text) -> 'mcc'::text)::text AS mcc,
       (((l.observations -> 'payer'::text) -> 'attribs'::text) -> 'device'::text)::text AS device,
       ((((l.observations -> 'payer'::text) -> 'attribs'::text) -> 'device'::text) -> 'ip'::text)::text AS ip,
       ((((l.observations -> 'payer'::text) -> 'attribs'::text) -> 'device'::text) -> 'location'::text)::text AS location,
       ((((l.observations -> 'payer'::text) -> 'attribs'::text) -> 'device'::text) -> 'id'::text)::text AS deviceid,
       ((((l.observations -> 'payer'::text) -> 'attribs'::text) -> 'device'::text) -> 'os'::text)::text AS os,
       ''::character varying as vcrulename,
       ((l.result -> 'score'::text) -> 'score'::text)::text AS score,
       (l.result -> 'status'::text)::text AS status,
       ((l.result -> 'score'::text) -> 'decisiondetails'::text)::text AS decisiondetails,
   	(((l.observations -> 'observations'::text) -> 'payerVPA'::text) -> 'externalId'::text)::character varying AS payervpa,
        (((l.observations -> 'observations'::text) -> 'payerVPA'::text) -> 'externalId'::text)::character varying AS payeevpa
   	 from transactions.livetrans l,
	 (select ivpaid from masters.vpa a where a.vcaddress=vpaaddress) m
   	where (l.ipayeevpaid =m.ivpaid ) and  cast(dttrxntime at time zone 'Asia/Kolkata' at time zone timezone as date)
      between cast(startdate at time zone 'Asia/Kolkata' at time zone timeZone as date) and cast(enddate at time zone 'Asia/Kolkata' at time zone timeZone as date);

Else
				 RAISE EXCEPTION 'Too Many Records For...' USING HINT = 'Please check different account/address';
End If;

	Elseif(vpatype='Payer') Then

	 num =(select count(ilivemessageid) from transactions.livetrans l, (
   	select ivpaid from masters.vpa a where a.vcaddress=vpaaddress) m
   	where ( l.ipayervpaid = m.ivpaid ) and  cast(dttrxntime at time zone 'Asia/Kolkata' at time zone timezone as date)
      between cast(startdate at time zone 'Asia/Kolkata' at time zone timeZone as date) and cast(enddate at time zone 'Asia/Kolkata' at time zone timeZone as date));

	 if(maxrecord > num )Then
	Return query select l.ilivemessageid, l.vcmsgid, l.vcuniquetransid, l.dttrxntime at time zone 'Asia/Kolkata' at time zone timezone,
        l.dsettledamount, l.dtransamount, l.dfailedamount, l.bnewpayer, l.bnewpayeeforpayer,
        l.bfrmpassed, l.observations::text,
       ((l.observations -> 'txn'::text) -> 'class'::text)::text AS txnclass,
   	 ((l.observations -> 'payee'::text) -> 'mcc'::text)::text AS mcc,
       (((l.observations -> 'payer'::text) -> 'attribs'::text) -> 'device'::text)::text AS device,
       ((((l.observations -> 'payer'::text) -> 'attribs'::text) -> 'device'::text) -> 'ip'::text)::text AS ip,
       ((((l.observations -> 'payer'::text) -> 'attribs'::text) -> 'device'::text) -> 'location'::text)::text AS location,
       ((((l.observations -> 'payer'::text) -> 'attribs'::text) -> 'device'::text) -> 'id'::text)::text AS deviceid,
       ((((l.observations -> 'payer'::text) -> 'attribs'::text) -> 'device'::text) -> 'os'::text)::text AS os,
       ''::character varying as vcrulename,
       ((l.result -> 'score'::text) -> 'score'::text)::text AS score,
       (l.result -> 'status'::text)::text AS status,
       ((l.result -> 'score'::text) -> 'decisiondetails'::text)::text AS decisiondetails,
   	(((l.observations -> 'observations'::text) -> 'payerVPA'::text) -> 'externalId'::text)::character varying AS payervpa,
        (((l.observations -> 'observations'::text) -> 'payerVPA'::text) -> 'externalId'::text)::character varying AS payeevpa
   	 from transactions.livetrans l,
	 (select ivpaid from masters.vpa a where a.vcaddress=vpaaddress) m
   	where (l.ipayervpaid =m.ivpaid ) and  cast(dttrxntime at time zone 'Asia/Kolkata' at time zone timezone as date)
      between cast(startdate at time zone 'Asia/Kolkata' at time zone timeZone as date) and cast(enddate at time zone 'Asia/Kolkata' at time zone timeZone as date);


Else

	RAISE EXCEPTION 'Too Many Records For...' USING HINT = 'Please check different account/address';

End If;

Elseif(vpatype='Both') Then

 num =(select count(ilivemessageid) from transactions.livetrans l, (
   	select ivpaid from masters.vpa a where a.vcaddress=vpaaddress) m
   	where ( l.ipayervpaid = m.ivpaid or l.ipayeevpaid = m.ivpaid) and  cast(dttrxntime at time zone 'Asia/Kolkata' at time zone timezone as date)
      between cast(startdate at time zone 'Asia/Kolkata' at time zone timeZone as date) and cast(enddate at time zone 'Asia/Kolkata' at time zone timeZone as date));

	 if(maxrecord > num )
	 	Then
		Return query  select l.ilivemessageid, l.vcmsgid, l.vcuniquetransid, l.dttrxntime at time zone 'Asia/Kolkata' at time zone timezone,
        l.dsettledamount, l.dtransamount, l.dfailedamount, l.bnewpayer, l.bnewpayeeforpayer,
        l.bfrmpassed, l.observations::text,
       ((l.observations -> 'txn'::text) -> 'class'::text)::text AS txnclass,
   	 ((l.observations -> 'payee'::text) -> 'mcc'::text)::text AS mcc,
       (((l.observations -> 'payer'::text) -> 'attribs'::text) -> 'device'::text)::text AS device,
       ((((l.observations -> 'payer'::text) -> 'attribs'::text) -> 'device'::text) -> 'ip'::text)::text AS ip,
       ((((l.observations -> 'payer'::text) -> 'attribs'::text) -> 'device'::text) -> 'location'::text)::text AS location,
       ((((l.observations -> 'payer'::text) -> 'attribs'::text) -> 'device'::text) -> 'id'::text)::text AS deviceid,
       ((((l.observations -> 'payer'::text) -> 'attribs'::text) -> 'device'::text) -> 'os'::text)::text AS os,
       ''::character varying as vcrulename,
       ((l.result -> 'score'::text) -> 'score'::text)::text AS score,
       (l.result -> 'status'::text)::text AS status,
       ((l.result -> 'score'::text) -> 'decisiondetails'::text)::text AS decisiondetails,
   	(((l.observations -> 'observations'::text) -> 'payerVPA'::text) -> 'externalId'::text)::character varying AS payervpa,
        (((l.observations -> 'observations'::text) -> 'payerVPA'::text) -> 'externalId'::text)::character varying AS payeevpa
   	 from transactions.livetrans l,
	 (select ivpaid from masters.vpa a where a.vcaddress=vpaaddress) m
   	where ( l.ipayervpaid = m.ivpaid or l.ipayeevpaid = m.ivpaid ) and  cast(dttrxntime at time zone 'Asia/Kolkata' at time zone timezone as date)
      between cast(startdate at time zone 'Asia/Kolkata' at time zone timeZone as date) and cast(enddate at time zone 'Asia/Kolkata' at time zone timeZone as date);

Else
			RAISE EXCEPTION 'Too Many Records... ' USING HINT = 'Please check different account/address';
End If;
End If;
End if;
End;

$BODY$;
