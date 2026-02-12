CREATE OR REPLACE FUNCTION masters.getlivedata(
	vpatype character varying,
	startdate timestamp without time zone,
	enddate timestamp without time zone,
	vpaaddress character varying)
    RETURNS TABLE(ilivemessageid bigint, vcmsgid character varying, vcuniquetransid character varying, dttrxntime timestamp without time zone, dsettledamount numeric, dtransamount numeric, dfailedamount numeric, bnewpayer boolean, bnewpayeeforpayer boolean, bfrmpassed boolean, dtupdatedtime timestamp without time zone, observations text, txnclass text, mcc text, device text, ip text, location text, deviceid text, os text, vcrulename character varying, score text, status text, decisiondetails text, payervcaddress character varying, payeevcaddress character varying)
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE PARALLEL UNSAFE
    ROWS 1000

AS $BODY$
BEGIN
			  If(vpatype='Payee') Then
			  Return query  SELECT vld.ilivemessageid, vld.vcmsgid, vld.vcuniquetransid, vld.dttrxntime,
                                   vld.dsettledamount, vld.dtransamount, vld.dfailedamount, vld.bnewpayer, vld.bnewpayeeforpayer,
                                   vld.bfrmpassed, vld.dtupdatedtime, vld.observations::text, vld.txnclass, vld.mcc, vld.device, vld.ip, vld.location, vld.deviceid, vld.os, vld.vcrulename, vld.score, vld.status, vld.decisiondetails, payervpa.vcaddress,payeevpa.vcaddress
                            FROM transactions.vw_livetrans_dashboard vld, masters.vpa payervpa, masters.vpa payeevpa where vld.dttrxntime>=startdate and vld.dttrxntime<=enddate and vld.ipayeevpaid=payeevpa.ivpaid
                                                                                                                       and payeevpa.vcaddress=vpaaddress and payervpa.ivpaid=vld.ipayervpaid;

Elseif(vpatype='Payer') Then
	Return query SELECT vld.ilivemessageid, vld.vcmsgid, vld.vcuniquetransid, vld.dttrxntime,
                        vld.dsettledamount, vld.dtransamount, vld.dfailedamount, vld.bnewpayer, vld.bnewpayeeforpayer,
                        vld.bfrmpassed, vld.dtupdatedtime, vld.observations::text, vld.txnclass, vld.mcc, vld.device, vld.ip, vld.location, vld.deviceid, vld.os, vld.vcrulename, vld.score, vld.status, vld.decisiondetails, payervpa.vcaddress,payeevpa.vcaddress
                 FROM transactions.vw_livetrans_dashboard vld, masters.vpa payervpa, masters.vpa payeevpa where vld.dttrxntime>=startdate and vld.dttrxntime<=enddate and vld.ipayervpaid=payervpa.ivpaid
                                                                                                            and payeevpa.ivpaid=vld.ipayeevpaid and payervpa.vcaddress=vpaaddress;

Elseif(vpatype='Both') Then
	Return query SELECT vld.ilivemessageid, vld.vcmsgid, vld.vcuniquetransid, vld.dttrxntime,
                        vld.dsettledamount, vld.dtransamount, vld.dfailedamount, vld.bnewpayer, vld.bnewpayeeforpayer,
                        vld.bfrmpassed, vld.dtupdatedtime, vld.observations::text, vld.txnclass, vld.mcc, vld.device, vld.ip,
                        vld.location, vld.deviceid, vld.os, vld.vcrulename, vld.score, vld.status, vld.decisiondetails, payervpa.vcaddress, payeevpa.vcaddress
                 FROM transactions.vw_livetrans_dashboard vld, masters.vpa payervpa, masters.vpa payeevpa where vld.dttrxntime>=startdate
                                                                                                            and vld.dttrxntime<=enddate and
                               payeevpa.ivpaid=vld.ipayeevpaid and payervpa.ivpaid=vld.ipayervpaid
                                                                                                            and
                           (payervpa.vcaddress=vpaaddress or payeevpa.vcaddress=vpaaddress);

End If;
End;

$BODY$;