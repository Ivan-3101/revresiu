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
		   Return query select L.iLiveMessageID as "ID", L.vcmsgid  as "Unique ID", L.dtTrxnTime at time zone 'utc' at time zone timezone as "Time", Payer.vcAddress as "Payer VPA",
                               Payer.vcvpaname as "Payer Name", Payee.vcAddress as "Payee VPA", payee.vcvpaname as "Payee Name", L.dTransAmount as "Amount", L.bFRMPassed as "FRM Pass", L.score as "Score",
                               L.vcrulename as "Rule" from transactions.vw_LiveTrans L, masters.VPA Payer, masters.VPA Payee where
                                  L.iLiveMessageID < ilivemsgid
                                                                                                                               and Payee.vcaddress=vpaaddress and L.iPayeeVPAID =Payee.iVPAID and Payer.iVPAID = ipayervpaid limit maxrecord;

Elseif(vpatype='Payer') Then
		 Return query select L.iLiveMessageID as "ID", L.vcmsgid  as "Unique ID", L.dtTrxnTime at time zone 'utc' at time zone timezone as "Time", Payer.vcAddress as "Payer VPA",
                             Payer.vcvpaname as "Payer Name", Payee.vcAddress as "Payee VPA", payee.vcvpaname as "Payee Name", L.dTransAmount as "Amount", L.bFRMPassed as "FRM Pass", L.score as "Score",
                             L.vcrulename as "Rule" from transactions.vw_LiveTrans L, masters.VPA Payer, masters.VPA Payee where
                                    L.iLiveMessageID < ilivemsgid
                                                                                                                             and Payer.vcaddress=vpaaddress and L.iPayerVPAID =Payer.iVPAID and Payee.iVPAID = ipayeevpaid limit maxrecord;
End If;
Elseif(txntype='subsequent')Then
	If(vpatype='Payee') Then
		   Return query select L.iLiveMessageID as "ID", L.vcmsgid  as "Unique ID", L.dtTrxnTime at time zone 'utc' at time zone timezone as "Time", Payer.vcAddress as "Payer VPA",
                               Payer.vcvpaname as "Payer Name", Payee.vcAddress as "Payee VPA", payee.vcvpaname as "Payee Name", L.dTransAmount as "Amount", L.bFRMPassed as "FRM Pass", L.score as "Score",
                               L.vcrulename as "Rule" from transactions.vw_LiveTrans L, masters.VPA Payer, masters.VPA Payee where
                                      L.iLiveMessageID > ilivemsgid and Payee.vcaddress=vpaaddress and L.iPayeeVPAID =Payee.iVPAID and Payer.iVPAID = ipayervpaid limit maxrecord;

Elseif(vpatype='Payer') Then
		 Return query select L.iLiveMessageID as "ID", L.vcmsgid  as "Unique ID", L.dtTrxnTime at time zone 'utc' at time zone timezone as "Time", Payer.vcAddress as "Payer VPA",
                             Payer.vcvpaname as "Payer Name", Payee.vcAddress as "Payee VPA", payee.vcvpaname as "Payee Name", L.dTransAmount as "Amount", L.bFRMPassed as "FRM Pass", L.score as "Score",
                             L.vcrulename as "Rule" from transactions.vw_LiveTrans L, masters.VPA Payer, masters.VPA Payee where
                                    L.iLiveMessageID > ilivemsgid and Payer.vcaddress=vpaaddress and L.iPayerVPAID =Payer.iVPAID and Payee.iVPAID = ipayeevpaid limit maxrecord;
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
		   Return query select L.iLiveMessageID as "ID", L.vcmsgid  as "Unique ID", L.dtTrxnTime at time zone 'utc' at time zone timezone as "Time", Payer.vcAddress as "Payer VPA",
                               Payer.vcvpaname as "Payer Name", Payee.vcAddress as "Payee VPA", payee.vcvpaname as "Payee Name", L.dTransAmount as "Amount", L.bFRMPassed as "FRM Pass", L.score as "Score",
                               L.vcrulename as "Rule" from transactions.vw_LiveTrans L, masters.VPA Payer, masters.VPA Payee where
                                  L.iLiveMessageID < ilivemsgid
                                                                                                                               and L.txnclass=txnclassinput and Payee.vcaddress=vpaaddress and L.iPayeeVPAID =Payee.iVPAID and Payer.iVPAID = ipayervpaid limit maxrecord;

Elseif(vpatype='Payer') Then
		 Return query select L.iLiveMessageID as "ID", L.vcmsgid  as "Unique ID", L.dtTrxnTime at time zone 'utc' at time zone timezone as "Time", Payer.vcAddress as "Payer VPA",
                             Payer.vcvpaname as "Payer Name", Payee.vcAddress as "Payee VPA", payee.vcvpaname as "Payee Name", L.dTransAmount as "Amount", L.bFRMPassed as "FRM Pass", L.score as "Score",
                             L.vcrulename as "Rule" from transactions.vw_LiveTrans L, masters.VPA Payer, masters.VPA Payee where
                                    L.iLiveMessageID < ilivemsgid
                                                                                                                             and L.txnclass=txnclassinput and Payer.vcaddress=vpaaddress and L.iPayerVPAID =Payer.iVPAID and Payee.iVPAID = ipayeevpaid limit maxrecord;
End If;
Elseif(txntype='subsequent')Then
	If(vpatype='Payee') Then
		   Return query select L.iLiveMessageID as "ID", L.vcmsgid  as "Unique ID", L.dtTrxnTime at time zone 'utc' at time zone timezone as "Time", Payer.vcAddress as "Payer VPA",
                               Payer.vcvpaname as "Payer Name", Payee.vcAddress as "Payee VPA", payee.vcvpaname as "Payee Name", L.dTransAmount as "Amount", L.bFRMPassed as "FRM Pass", L.score as "Score",
                               L.vcrulename as "Rule" from transactions.vw_LiveTrans L, masters.VPA Payer, masters.VPA Payee where
                                      L.iLiveMessageID > ilivemsgid
                                                                                                                               and L.txnclass=txnclassinput and Payee.vcaddress=vpaaddress and L.iPayeeVPAID =Payee.iVPAID and Payer.iVPAID = ipayervpaid limit maxrecord;

Elseif(vpatype='Payer') Then
		 Return query select L.iLiveMessageID as "ID", L.vcmsgid  as "Unique ID", L.dtTrxnTime at time zone 'utc' at time zone timezone as "Time", Payer.vcAddress as "Payer VPA",
                             Payer.vcvpaname as "Payer Name", Payee.vcAddress as "Payee VPA", payee.vcvpaname as "Payee Name", L.dTransAmount as "Amount", L.bFRMPassed as "FRM Pass", L.score as "Score",
                             L.vcrulename as "Rule" from transactions.vw_LiveTrans L, masters.VPA Payer, masters.VPA Payee where
                                    L.iLiveMessageID > ilivemsgid
                                                                                                                             and L.txnclass=txnclassinput and Payer.vcaddress=vpaaddress and L.iPayerVPAID =Payer.iVPAID and Payee.iVPAID = ipayeevpaid limit maxrecord;
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
                               Payer.vcAddress as "Payer VPA", Payer.vcvpaname as "Payer Name", Payee.vcAddress as "Payee VPA", Payee.vcvpaname as "Payee Name",
                               L.dTransAmount as "Amount", L.bFRMPassed as "FRM Pass", L.score as "Score", vcrulename as "Rule" from transactions.vw_LiveTrans L,
                                                                                                                                     masters.VPA Payer, masters.VPA Payee where vcmsgid=msgid and Payee.vcaddress=vpaaddress and
                                      cast(L.dtTrxnTime at time zone 'utc' at time zone timezone as date)=txndate and Payee.iVPAID = L.iPayeeVPAID and Payer.iVPAID = ipayervpaid;
Elseif(vpatype='Payer') Then
		 Return query select L.iLiveMessageID as "ID", L.vcmsgid  as "Unique ID", L.dtTrxnTime at time zone 'utc' at time zone timezone as "Time",
                             Payer.vcAddress as "Payer VPA", Payer.vcvpaname as "Payer Name", Payee.vcAddress as "Payee VPA", Payee.vcvpaname as "Payee Name",
                             L.dTransAmount as "Amount", L.bFRMPassed as "FRM Pass", L.score as "Score", vcrulename as "Rule" from transactions.vw_LiveTrans L,
                                                                                                                                   masters.VPA Payer, masters.VPA Payee where vcmsgid=msgid and Payer.vcaddress=vpaaddress
                                                                                                                                                                          and cast(L.dtTrxnTime at time zone 'utc' at time zone timezone as date)=txndate
                                                                                                                                                                          and Payee.iVPAID = L.iPayeeVPAID and Payer.iVPAID = ipayervpaid;
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
                               Payer.vcAddress as "Payer VPA", Payer.vcvpaname as "Payer Name", Payee.vcAddress as "Payee VPA", Payee.vcvpaname as "Payee Name",
                               L.dTransAmount as "Amount", L.bFRMPassed as "FRM Pass", L.score as "Score", vcrulename as "Rule" from transactions.vw_LiveTrans L,
                                                                                                                                     masters.VPA Payer, masters.VPA Payee where vcmsgid=msgid and Payee.vcaddress=vpaaddress and L.txnclass=txnclassinput
                                                                                                                                                                            and cast(L.dtTrxnTime at time zone 'utc' at time zone timezone as date)=txndate and Payee.iVPAID = L.iPayeeVPAID and Payer.iVPAID = ipayervpaid;
Elseif(vpatype='Payer') Then
		 Return query select L.iLiveMessageID as "ID", L.vcmsgid  as "Unique ID", L.dtTrxnTime at time zone 'utc' at time zone timezone as "Time",
                             Payer.vcAddress as "Payer VPA", Payer.vcvpaname as "Payer Name", Payee.vcAddress as "Payee VPA", Payee.vcvpaname as "Payee Name",
                             L.dTransAmount as "Amount", L.bFRMPassed as "FRM Pass", L.score as "Score", vcrulename as "Rule" from transactions.vw_LiveTrans L,
                                                                                                                                   masters.VPA Payer, masters.VPA Payee where vcmsgid=msgid and Payer.vcaddress=vpaaddress and L.txnclass=txnclassinput
                                                                                                                                                                          and cast(L.dtTrxnTime at time zone 'utc' at time zone timezone as date)=txndate and Payee.iVPAID = L.iPayeeVPAID and Payer.iVPAID = ipayervpaid;
End If;
End;

$BODY$;