CREATE OR REPLACE FUNCTION masters.getlivedata(
	vpatype character varying,
	startdate timestamp without time zone,
	enddate timestamp without time zone,
	vpaaddress character varying,
	timezone character varying,
	maxrecord integer)
    RETURNS TABLE(ilivemessageid bigint, vcmsgid character varying, vcuniquetransid character varying, dttrxntime timestamp without time zone, dsettledamount numeric, dtransamount numeric, dfailedamount numeric, bnewpayer boolean, bnewpayeeforpayer boolean, bfrmpassed boolean, dtupdatedtime timestamp without time zone, observations text, txnclass text, mcc text, device text, ip text, location text, deviceid text, os text, vcrulename character varying, score text, status text, decisiondetails text, payervcaddress character varying, payeevcaddress character varying)
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE PARALLEL UNSAFE
    ROWS 1000

AS $BODY$
DECLARE num integer;
BEGIN
			  If(vpatype='Payee') Then
				num =(select count(vld.ilivemessageid) from transactions.vw_livetrans_dashboard vld, masters.vpa where
					  vld.dttrxntime at time zone 'utc' at time zone timeZone >= startdate and vld.dttrxntime
					  at time zone 'utc' at time zone timeZone <= enddate and ipayeevpaid=ivpaid and vcaddress = vpaaddress);

			 if(maxrecord > num)
			 Then
			   Return query  SELECT vld.ilivemessageid, vld.vcmsgid, vld.vcuniquetransid, vld.dttrxntime at time zone 'utc' at time zone timeZone,
                                    vld.dsettledamount, vld.dtransamount, vld.dfailedamount, vld.bnewpayer, vld.bnewpayeeforpayer,
                                    vld.bfrmpassed, vld.dtupdatedtime, vld.observations::text, vld.txnclass, vld.mcc, vld.device, vld.ip, vld.location, vld.deviceid, vld.os, vld.vcrulename, vld.score, vld.status, vld.decisiondetails, payervpa.vcaddress,payeevpa.vcaddress
                             FROM transactions.vw_livetrans_dashboard vld, masters.vpa payervpa, masters.vpa payeevpa where vld.dttrxntime at time zone 'utc' at time zone timeZone >= startdate and vld.dttrxntime at time zone 'utc' at time zone timeZone <=enddate and vld.ipayeevpaid=payeevpa.ivpaid
    and payeevpa.vcaddress=vpaaddress and payervpa.ivpaid=vld.ipayervpaid;
Else
				 RAISE EXCEPTION 'Too Many Records For...' USING HINT = 'Please check different account/address';
End If;

	Elseif(vpatype='Payer') Then

	 num =(select count(vld.ilivemessageid) from transactions.vw_livetrans_dashboard vld, masters.vpa where  vld.dttrxntime at time zone 'utc' at
		   time zone timeZone >= startdate and vld.dttrxntime at time zone 'utc' at time zone timeZone <= enddate and ipayervpaid=ivpaid and vcaddress = vpaaddress);

	 if(maxrecord > num )Then

	Return query SELECT vld.ilivemessageid, vld.vcmsgid, vld.vcuniquetransid, vld.dttrxntime at time zone 'utc' at time zone timeZone,
                        vld.dsettledamount, vld.dtransamount, vld.dfailedamount, vld.bnewpayer, vld.bnewpayeeforpayer, vld.bfrmpassed, vld.dtupdatedtime, vld.observations::text,
                                          vld.txnclass, vld.mcc, vld.device, vld.ip, vld.location, vld.deviceid, vld.os, vld.vcrulename, vld.score, vld.status, vld.decisiondetails, payervpa.vcaddress,
                        payeevpa.vcaddress FROM transactions.vw_livetrans_dashboard vld, masters.vpa payervpa, masters.vpa payeevpa where vld.dttrxntime at time zone 'utc' at time zone timeZone >= startdate and vld.dttrxntime at time zone 'utc' at time zone timeZone <=enddate and vld.ipayervpaid=payervpa.ivpaid
    and payeevpa.ivpaid=vld.ipayeevpaid and payervpa.vcaddress=vpaaddress;

Else

	RAISE EXCEPTION 'Too Many Records For...' USING HINT = 'Please check different account/address';

End If;

Elseif(vpatype='Both') Then

 num =(select count(vld.ilivemessageid)  FROM transactions.vw_livetrans_dashboard vld, masters.vpa payervpa, masters.vpa payeevpa where vld.dttrxntime at time zone 'utc' at time zone timeZone >= startdate
         and vld.dttrxntime at time zone 'utc' at time zone timeZone <= enddate and payeevpa.ivpaid=vld.ipayeevpaid and payervpa.ivpaid=vld.ipayervpaid
          and  (payervpa.vcaddress=vpaaddress or payeevpa.vcaddress=vpaaddress));
	 if(maxrecord > num )
	 	Then
		Return query SELECT vld.ilivemessageid, vld.vcmsgid, vld.vcuniquetransid, vld.dttrxntime at time zone 'utc' at time zone timeZone,
                            vld.dsettledamount, vld.dtransamount, vld.dfailedamount, vld.bnewpayer, vld.bnewpayeeforpayer,
                            vld.bfrmpassed, vld.dtupdatedtime, vld.observations::text, vld.txnclass, vld.mcc, vld.device, vld.ip,
                            vld.location, vld.deviceid, vld.os, vld.vcrulename, vld.score, vld.status, vld.decisiondetails, payervpa.vcaddress, payeevpa.vcaddress
                     FROM transactions.vw_livetrans_dashboard vld, masters.vpa payervpa, masters.vpa payeevpa where vld.dttrxntime at time zone 'utc' at time zone timeZone >=startdate
    and vld.dttrxntime at time zone 'utc' at time zone timeZone <=enddate and payeevpa.ivpaid=vld.ipayeevpaid and payervpa.ivpaid=vld.ipayervpaid
        and  (payervpa.vcaddress=vpaaddress or payeevpa.vcaddress=vpaaddress);

Else
			RAISE EXCEPTION 'Too Many Records... ' USING HINT = 'Please check different account/address';
End If;
End If;
End;

$BODY$;

