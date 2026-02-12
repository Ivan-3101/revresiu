

CREATE OR REPLACE FUNCTION ui.gettxnprofilebyclass_new(
	party character varying,
	vpatype character varying,
	txntype character varying,
	timezone character varying,
	ilivemsgid integer,
	vpaaddress character varying,
	txnclassinput character varying,
	maxrecord integer)
    RETURNS TABLE("ID" bigint, "Unique ID" character varying, "Time" timestamp with time zone, "Payer VPA" character varying, "Payer Name" character varying, "Payee VPA" character varying, "Payee Name" character varying, amount numeric, "FRM Pass" boolean, score integer, "Rule" character varying, "Payer Account" character varying, "Payee Account" character varying)
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE PARALLEL UNSAFE
    ROWS 1000

AS $BODY$
DECLARE num integer;
BEGIN
if(party = 'VPA')then
If(txntype='previous') Then
	If(vpatype='Payee') Then
		   Return query select L.iLiveMessageID as "ID", L.vcmsgid  as "Unique ID", L.dtTrxnTime at time zone 'Asia/Kolkata' at time zone timezone as "Time",
                               payervpa,
                               payername,
                               payeevpa,
                               payeename,
                               L.dTransAmount as "Amount", L.bFRMPassed as "FRM Pass", L.score as "Score",
                               L.vcrulename as "Rule", L.vcpayeraccount, L.vcpayeeaccount from transactions.vw_livetrans_with_vpa_and_account_from_joins L where L.iLiveMessageID < ilivemsgid
                                                                                                                                                             and L.txnclass = txnclassinput and payeevpa = vpaaddress limit maxrecord;

Elseif(vpatype='Payer') Then
		 Return query select L.iLiveMessageID as "ID", L.vcmsgid  as "Unique ID", L.dtTrxnTime at time zone 'Asia/Kolkata' at time zone timezone as "Time",
                             payervpa,
                             payername,
                             payeevpa,
                             payeename,
                             L.dTransAmount as "Amount", L.bFRMPassed as "FRM Pass", L.score as "Score", L.vcrulename as "Rule" , L.vcpayeraccount, L.vcpayeeaccount from
                                transactions.vw_livetrans_with_vpa_and_account_from_joins L where L.iLiveMessageID < ilivemsgid
                                                                                              and L.txnclass=txnclassinput and payervpa = vpaaddress limit maxrecord;

Elseif(vpatype='Both') Then
		 Return query select L.iLiveMessageID as "ID", L.vcmsgid  as "Unique ID", L.dtTrxnTime at time zone 'Asia/Kolkata' at time zone timezone as "Time",
                             payervpa,
                             payername,
                             payeevpa,
                             payeename,
                             L.dTransAmount as "Amount", L.bFRMPassed as "FRM Pass", L.score as "Score", L.vcrulename as "Rule" , L.vcpayeraccount, L.vcpayeeaccount from
                                transactions.vw_livetrans_with_vpa_and_account_from_joins L where L.iLiveMessageID < ilivemsgid
                                                                                              and L.txnclass=txnclassinput and ( payervpa = vpaaddress or payeevpa = vpaaddress)  limit maxrecord;


End If;
Elseif(txntype='subsequent')Then
	If(vpatype='Payee') Then
		   Return query select L.iLiveMessageID as "ID", L.vcmsgid  as "Unique ID", L.dtTrxnTime at time zone 'Asia/Kolkata' at time zone timezone as "Time",
                               payervpa,
                               payername,
                               payeevpa,
                               payeename,
                               L.dTransAmount as "Amount", L.bFRMPassed as "FRM Pass", L.score as "Score", L.vcrulename as "Rule", L.vcpayeraccount, L.vcpayeeaccount
                        from transactions.vw_livetrans_with_vpa_and_account_from_joins L where L.iLiveMessageID > ilivemsgid
                                                                                           and L.txnclass=txnclassinput and payeevpa=vpaaddress limit maxrecord;

Elseif(vpatype='Payer') Then
		 Return query select L.iLiveMessageID as "ID", L.vcmsgid  as "Unique ID", L.dtTrxnTime at time zone 'Asia/Kolkata' at time zone timezone as "Time",
                             payervpa,
                             payername,
                             payeevpa,
                             payeename,
                             L.dTransAmount as "Amount", L.bFRMPassed as "FRM Pass", L.score as "Score", L.vcrulename as "Rule",
                             L.vcpayeraccount, L.vcpayeeaccount
                      from transactions.vw_livetrans_with_vpa_and_account_from_joins L where L.iLiveMessageID > ilivemsgid and L.txnclass=txnclassinput
                                                                                         and payervpa = vpaaddress limit maxrecord;

Elseif(vpatype='Both') Then
		 Return query select L.iLiveMessageID as "ID", L.vcmsgid  as "Unique ID", L.dtTrxnTime at time zone 'Asia/Kolkata' at time zone timezone as "Time",
                             payervpa,
                             payername,
                             payeevpa,
                             payeename,
                             L.dTransAmount as "Amount", L.bFRMPassed as "FRM Pass", L.score as "Score", L.vcrulename as "Rule",
                             L.vcpayeraccount, L.vcpayeeaccount
                      from transactions.vw_livetrans_with_vpa_and_account_from_joins L where L.iLiveMessageID > ilivemsgid and L.txnclass=txnclassinput
                                                                                         and ( payervpa = vpaaddress or payeevpa = vpaaddress) limit maxrecord;
End If;
End If;
elseif(party = 'Account')then
If(txntype='previous') Then
	If(vpatype='Payee') Then
		   Return query select L.iLiveMessageID as "ID", L.vcmsgid  as "Unique ID", L.dtTrxnTime at time zone 'Asia/Kolkata' at time zone timezone as "Time",
                               payervpa,
                               payername,
                               payeevpa,
                               payeename,
                               L.dTransAmount as "Amount", L.bFRMPassed as "FRM Pass", L.score as "Score",
                               L.vcrulename as "Rule" ,L.vcpayeraccount, L.vcpayeeaccount from transactions.vw_livetrans_with_vpa_and_account_from_joins L where L.iLiveMessageID < ilivemsgid
                                                                                                                                                             and L.txnclass=txnclassinput and vcpayeeaccount = vpaaddress limit maxrecord;

Elseif(vpatype='Payer') Then
		 Return query select L.iLiveMessageID as "ID", L.vcmsgid  as "Unique ID", L.dtTrxnTime at time zone 'Asia/Kolkata' at time zone timezone as "Time",
                             payervpa,
                             payername,
                             payeevpa,
                             payeename,
                             L.dTransAmount as "Amount", L.bFRMPassed as "FRM Pass", L.score as "Score", L.vcrulename as "Rule", L.vcpayeraccount, L.vcpayeeaccount from
                                transactions.vw_livetrans_with_vpa_and_account_from_joins L where L.iLiveMessageID < ilivemsgid
                                                                                              and L.txnclass=txnclassinput and vcpayeraccount = vpaaddress limit maxrecord;

Elseif(vpatype='Both') Then
		 Return query select L.iLiveMessageID as "ID", L.vcmsgid  as "Unique ID", L.dtTrxnTime at time zone 'Asia/Kolkata' at time zone timezone as "Time",
                             payervpa,
                             payername,
                             payeevpa,
                             payeename,
                             L.dTransAmount as "Amount", L.bFRMPassed as "FRM Pass", L.score as "Score", L.vcrulename as "Rule", L.vcpayeraccount, L.vcpayeeaccount from
                                transactions.vw_livetrans_with_vpa_and_account_from_joins L where L.iLiveMessageID < ilivemsgid
                                                                                              and L.txnclass=txnclassinput and ( vcpayeraccount = vpaaddress or vcpayeeaccount = vpaaddress) limit maxrecord;


End If;
Elseif(txntype='subsequent')Then
	If(vpatype='Payee') Then
		   Return query select L.iLiveMessageID as "ID", L.vcmsgid  as "Unique ID", L.dtTrxnTime at time zone 'Asia/Kolkata' at time zone timezone as "Time",
                               payervpa,
                               payername,
                               payeevpa,
                               payeename,
                               L.dTransAmount as "Amount", L.bFRMPassed as "FRM Pass", L.score as "Score", L.vcrulename as "Rule", L.vcpayeraccount, L.vcpayeeaccount
                        from transactions.vw_livetrans_with_vpa_and_account_from_joins L where L.iLiveMessageID > ilivemsgid
                                                                                           and L.txnclass=txnclassinput and vcpayeeaccount=vpaaddress limit maxrecord;

Elseif(vpatype='Payer') Then
		 Return query select L.iLiveMessageID as "ID", L.vcmsgid  as "Unique ID", L.dtTrxnTime at time zone 'Asia/Kolkata' at time zone timezone as "Time",
                             payervpa,
                             payername,
                             payeevpa,
                             payeename,
                             L.dTransAmount as "Amount", L.bFRMPassed as "FRM Pass", L.score as "Score", L.vcrulename as "Rule", L.vcpayeraccount, L.vcpayeeaccount
                      from transactions.vw_livetrans_with_vpa_and_account_from_joins L where L.iLiveMessageID > ilivemsgid and L.txnclass=txnclassinput
                                                                                         and vcpayeraccount = vpaaddress limit maxrecord;

Elseif(vpatype='Both') Then
		 Return query select L.iLiveMessageID as "ID", L.vcmsgid  as "Unique ID", L.dtTrxnTime at time zone 'Asia/Kolkata' at time zone timezone as "Time",
                             payervpa,
                             payername,
                             payeevpa,
                             payeename,
                             L.dTransAmount as "Amount", L.bFRMPassed as "FRM Pass", L.score as "Score", L.vcrulename as "Rule", L.vcpayeraccount, L.vcpayeeaccount
                      from transactions.vw_livetrans_with_vpa_and_account_from_joins L where L.iLiveMessageID > ilivemsgid and L.txnclass=txnclassinput
                                                                                         and (vcpayeraccount = vpaaddress or vcpayeeaccount = vpaaddress)limit maxrecord;

End If;
End If;
end if;
End;

$BODY$;



CREATE OR REPLACE FUNCTION ui.gettxnprofile_new(
	party character varying,
	vpatype character varying,
	txntype character varying,
	timezone character varying,
	ilivemsgid integer,
	vpaaddress character varying,
	maxrecord integer)
    RETURNS TABLE("ID" bigint, "Unique ID" character varying, "Time" timestamp with time zone, "Payer VPA" character varying, "Payer Name" character varying, "Payee VPA" character varying, "Payee Name" character varying, amount numeric, "FRM Pass" boolean, score integer, "Rule" character varying, "Payer Account" character varying, "Payee Account" character varying)
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE PARALLEL UNSAFE
    ROWS 1000

AS $BODY$
DECLARE num integer;
BEGIN
if(party = 'VPA')then
If(txntype='previous') Then
	If(vpatype='Payee') Then
		   Return query select L.iLiveMessageID as "ID", L.vcmsgid  as "Unique ID", L.dtTrxnTime at time zone 'Asia/Kolkata' at time zone timezone as "Time",
                               payervpa,
                               payername,
                               payeevpa,
                               payeename,
                               L.dTransAmount as "Amount", L.bFRMPassed as "FRM Pass", L.score as "Score", L.vcrulename as "Rule", L.vcpayeraccount, L.vcpayeeaccount
                        from transactions.vw_livetrans_with_vpa_and_account_from_joins L where
                                  L.iLiveMessageID < ilivemsgid and payeevpa = vpaaddress limit maxrecord;

Elseif(vpatype='Payer') Then
		 Return query select L.iLiveMessageID as "ID", L.vcmsgid  as "Unique ID", L.dtTrxnTime at time zone 'Asia/Kolkata' at time zone timezone as "Time",
                             payervpa,
                             payername,
                             payeevpa,
                             payeename,
                             L.dTransAmount as "Amount", L.bFRMPassed as "FRM Pass", L.score as "Score", L.vcrulename as "Rule", L.vcpayeraccount, L.vcpayeeaccount
                      from transactions.vw_livetrans_with_vpa_and_account_from_joins L where L.iLiveMessageID < ilivemsgid and
                                    payervpa = vpaaddress limit maxrecord;
Elseif(vpatype='Both') Then
		 Return query select L.iLiveMessageID as "ID", L.vcmsgid  as "Unique ID", L.dtTrxnTime at time zone 'Asia/Kolkata' at time zone timezone as "Time",
                             payervpa,
                             payername,
                             payeevpa,
                             payeename,
                             L.dTransAmount as "Amount", L.bFRMPassed as "FRM Pass", L.score as "Score", L.vcrulename as "Rule", L.vcpayeraccount, L.vcpayeeaccount
                      from transactions.vw_livetrans_with_vpa_and_account_from_joins L where L.iLiveMessageID < ilivemsgid and
                                ( payervpa = vpaaddress or payeevpa = vpaaddress ) limit maxrecord;
End If;
Elseif(txntype='subsequent')Then
	If(vpatype='Payee') Then
		   Return query select L.iLiveMessageID as "ID", L.vcmsgid  as "Unique ID", L.dtTrxnTime at time zone 'Asia/Kolkata' at time zone timezone as "Time",
                               payervpa,
                               payername,
                               payeevpa,
                               payeename,
                               L.dTransAmount as "Amount", L.bFRMPassed as "FRM Pass", L.score as "Score", L.vcrulename as "Rule", L.vcpayeraccount, L.vcpayeeaccount
                        from transactions.vw_livetrans_with_vpa_and_account_from_joins L where
                                      L.iLiveMessageID > ilivemsgid and payeevpa = vpaaddress limit maxrecord;

Elseif(vpatype='Payer') Then
		 Return query select L.iLiveMessageID as "ID", L.vcmsgid  as "Unique ID", L.dtTrxnTime at time zone 'Asia/Kolkata' at time zone timezone as "Time",
                             payervpa,
                             payername,
                             payeevpa,
                             payeename,
                             L.dTransAmount as "Amount", L.bFRMPassed as "FRM Pass", L.score as "Score", L.vcrulename as "Rule", L.vcpayeraccount, L.vcpayeeaccount from
                                transactions.vw_livetrans_with_vpa_and_account_from_joins L where
                                    L.iLiveMessageID > ilivemsgid and payervpa = vpaaddress limit maxrecord;
Elseif(vpatype='Both') Then
		 Return query select L.iLiveMessageID as "ID", L.vcmsgid  as "Unique ID", L.dtTrxnTime at time zone 'Asia/Kolkata' at time zone timezone as "Time",
                             payervpa,
                             payername,
                             payeevpa,
                             payeename,
                             L.dTransAmount as "Amount", L.bFRMPassed as "FRM Pass", L.score as "Score", L.vcrulename as "Rule", L.vcpayeraccount, L.vcpayeeaccount from
                                transactions.vw_livetrans_with_vpa_and_account_from_joins L where
                                    L.iLiveMessageID > ilivemsgid and  ( payervpa = vpaaddress or payeevpa = vpaaddress ) limit maxrecord;
End If;
End If;
elseif(party = 'Account')then
If(txntype='previous') Then
	If(vpatype='Payee') Then
		   Return query select L.iLiveMessageID as "ID", L.vcmsgid  as "Unique ID", L.dtTrxnTime at time zone 'Asia/Kolkata' at time zone timezone as "Time",
                               payervpa,
                               payername,
                               payeevpa,
                               payeename,
                               L.dTransAmount as "Amount", L.bFRMPassed as "FRM Pass", L.score as "Score", L.vcrulename as "Rule", L.vcpayeraccount, L.vcpayeeaccount
                        from transactions.vw_livetrans_with_vpa_and_account_from_joins L where
                                      L.iLiveMessageID < ilivemsgid and vcpayeeaccount = vpaaddress limit maxrecord;

Elseif(vpatype='Payer') Then
		 Return query select L.iLiveMessageID as "ID", L.vcmsgid  as "Unique ID", L.dtTrxnTime at time zone 'Asia/Kolkata' at time zone timezone as "Time",
                             payervpa,
                             payername,
                             payeevpa,
                             payeename,
                             L.dTransAmount as "Amount", L.bFRMPassed as "FRM Pass", L.score as "Score", L.vcrulename as "Rule", L.vcpayeraccount, L.vcpayeeaccount
                      from transactions.vw_livetrans_with_vpa_and_account_from_joins L where L.iLiveMessageID < ilivemsgid and
                                    vcpayeraccount = vpaaddress limit maxrecord;

Elseif(vpatype='Both') Then
		 Return query select L.iLiveMessageID as "ID", L.vcmsgid  as "Unique ID", L.dtTrxnTime at time zone 'Asia/Kolkata' at time zone timezone as "Time",
                             payervpa,
                             payername,
                             payeevpa,
                             payeename,
                             L.dTransAmount as "Amount", L.bFRMPassed as "FRM Pass", L.score as "Score", L.vcrulename as "Rule", L.vcpayeraccount, L.vcpayeeaccount
                      from transactions.vw_livetrans_with_vpa_and_account_from_joins L where L.iLiveMessageID < ilivemsgid and
                                ( vcpayeraccount = vpaaddress  or vcpayeeaccount = vpaaddress ) limit maxrecord;

End If;
Elseif(txntype='subsequent')Then
	If(vpatype='Payee') Then
		   Return query select L.iLiveMessageID as "ID", L.vcmsgid  as "Unique ID", L.dtTrxnTime at time zone 'Asia/Kolkata' at time zone timezone as "Time",
                               payervpa,
                               payername,
                               payeevpa,
                               payeename,
                               L.dTransAmount as "Amount", L.bFRMPassed as "FRM Pass", L.score as "Score", L.vcrulename as "Rule", L.vcpayeraccount, L.vcpayeeaccount
                        from transactions.vw_livetrans_with_vpa_and_account_from_joins L where
                                      L.iLiveMessageID > ilivemsgid and vcpayeeaccount = vpaaddress limit maxrecord;

Elseif(vpatype='Payer') Then
		 Return query select L.iLiveMessageID as "ID", L.vcmsgid  as "Unique ID", L.dtTrxnTime at time zone 'Asia/Kolkata' at time zone timezone as "Time",
                             payervpa,
                             payername,
                             payeevpa,
                             payeename,
                             L.dTransAmount as "Amount", L.bFRMPassed as "FRM Pass", L.score as "Score", L.vcrulename as "Rule", L.vcpayeraccount, L.vcpayeeaccount from
                                transactions.vw_livetrans_with_vpa_and_account_from_joins L where
                                    L.iLiveMessageID > ilivemsgid and vcpayeraccount = vpaaddress limit maxrecord;

Elseif(vpatype='Both') Then
		 Return query select L.iLiveMessageID as "ID", L.vcmsgid  as "Unique ID", L.dtTrxnTime at time zone 'Asia/Kolkata' at time zone timezone as "Time",
                             payervpa,
                             payername,
                             payeevpa,
                             payeename,
                             L.dTransAmount as "Amount", L.bFRMPassed as "FRM Pass", L.score as "Score", L.vcrulename as "Rule", L.vcpayeraccount, L.vcpayeeaccount from
                                transactions.vw_livetrans_with_vpa_and_account_from_joins L where
                                    L.iLiveMessageID > ilivemsgid and ( vcpayeraccount = vpaaddress  or vcpayeeaccount = vpaaddress ) limit maxrecord;
End If;
End If;
end if;
End;

$BODY$;




CREATE OR REPLACE FUNCTION ui.gettxnprofileselectedtxn_new(
	party character varying,
	vpatype character varying,
	timezone character varying,
	msgid character varying,
	vpaaddress character varying,
	txndate date)
    RETURNS TABLE("ID" bigint, "Unique ID" character varying, "Time" timestamp with time zone, "Payer VPA" character varying, "Payer Name" character varying, "Payee VPA" character varying, "Payee Name" character varying, amount numeric, "FRM Pass" boolean, score integer, "Rule" character varying, "Payer Account" character varying, "Payee Account" character varying)
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE PARALLEL UNSAFE
    ROWS 1000

AS $BODY$
DECLARE num integer;
BEGIN
if(party = 'VPA')then
	If(vpatype='Payee') Then
		   Return query select L.iLiveMessageID as "ID", L.vcmsgid  as "Unique ID", L.dtTrxnTime at time zone 'Asia/Kolkata' at time zone timezone as "Time",
                               payervpa,
                               payername,
                               payeevpa,
                               payeename,
                               L.dTransAmount as "Amount", L.bFRMPassed as "FRM Pass", L.score as "Score", vcrulename as "Rule", L.vcpayeraccount, L.vcpayeeaccount
                        from transactions.vw_livetrans_with_vpa_and_account_from_joins L
                        where vcmsgid=msgid and payeevpa = vpaaddress and cast(L.dtTrxnTime at time zone 'Asia/Kolkata' at time zone timezone as date)=txndate;

Elseif(vpatype='Payer') Then
		 Return query select L.iLiveMessageID as "ID", L.vcmsgid  as "Unique ID", L.dtTrxnTime at time zone 'Asia/Kolkata' at time zone timezone as "Time",
                             payervpa,
                             payername,
                             payeevpa,
                             payeename,
                             L.dTransAmount as "Amount", L.bFRMPassed as "FRM Pass", L.score as "Score", vcrulename as "Rule", L.vcpayeraccount, L.vcpayeeaccount  from
                                transactions.vw_livetrans_with_vpa_and_account_from_joins L where vcmsgid = msgid and payervpa = vpaaddress and
                                    cast(L.dtTrxnTime at time zone 'Asia/Kolkata' at time zone timezone as date) = txndate;
Elseif(vpatype='Both') Then
		 Return query select L.iLiveMessageID as "ID", L.vcmsgid  as "Unique ID", L.dtTrxnTime at time zone 'Asia/Kolkata' at time zone timezone as "Time",
                             payervpa,
                             payername,
                             payeevpa,
                             payeename,
                             L.dTransAmount as "Amount", L.bFRMPassed as "FRM Pass", L.score as "Score", vcrulename as "Rule", L.vcpayeraccount, L.vcpayeeaccount  from
                                transactions.vw_livetrans_with_vpa_and_account_from_joins L where vcmsgid = msgid and (payervpa = vpaaddress or payeevpa = vpaaddress) and
                                    cast(L.dtTrxnTime at time zone 'Asia/Kolkata' at time zone timezone as date) = txndate;

End If;
elseif(party = 'Account' )then
	If(vpatype='Payee') Then
		   Return query select L.iLiveMessageID as "ID", L.vcmsgid  as "Unique ID", L.dtTrxnTime at time zone 'Asia/Kolkata' at time zone timezone as "Time",
                               payervpa,
                               payername,
                               payeevpa,
                               payeename,
                               L.dTransAmount as "Amount", L.bFRMPassed as "FRM Pass", L.score as "Score", vcrulename as "Rule", L.vcpayeraccount, L.vcpayeeaccount  from
                                  transactions.vw_livetrans_with_vpa_and_account_from_joins L
                        where vcmsgid=msgid and vcpayeeaccount = vpaaddress and cast(L.dtTrxnTime at time zone 'Asia/Kolkata' at time zone timezone as date)=txndate;

Elseif(vpatype='Payer') Then
		 Return query select L.iLiveMessageID as "ID", L.vcmsgid  as "Unique ID", L.dtTrxnTime at time zone 'Asia/Kolkata' at time zone timezone as "Time",
                             payervpa,
                             payername,
                             payeevpa,
                             payeename,
                             L.dTransAmount as "Amount", L.bFRMPassed as "FRM Pass", L.score as "Score", vcrulename as "Rule", L.vcpayeraccount, L.vcpayeeaccount  from
                                transactions.vw_livetrans_with_vpa_and_account_from_joins L where vcmsgid = msgid and vcpayeraccount = vpaaddress and
                                    cast(L.dtTrxnTime at time zone 'Asia/Kolkata' at time zone timezone as date) = txndate;

Elseif(vpatype='Both') Then
		 Return query select L.iLiveMessageID as "ID", L.vcmsgid  as "Unique ID", L.dtTrxnTime at time zone 'Asia/Kolkata' at time zone timezone as "Time",
                             payervpa,
                             payername,
                             payeevpa,
                             payeename,
                             L.dTransAmount as "Amount", L.bFRMPassed as "FRM Pass", L.score as "Score", vcrulename as "Rule", L.vcpayeraccount, L.vcpayeeaccount  from
                                transactions.vw_livetrans_with_vpa_and_account_from_joins L where vcmsgid = msgid and (vcpayeraccount = vpaaddress or vcpayeeaccount = vpaaddress) and
                                    cast(L.dtTrxnTime at time zone 'Asia/Kolkata' at time zone timezone as date) = txndate;

End If;
end if;

End;

$BODY$;



CREATE OR REPLACE FUNCTION ui.gettxnprofileselectedtxnbyclass_new(
	party character varying,
	vpatype character varying,
	timezone character varying,
	msgid character varying,
	vpaaddress character varying,
	txnclassinput character varying,
	txndate date)
    RETURNS TABLE("ID" bigint, "Unique ID" character varying, "Time" timestamp with time zone, "Payer VPA" character varying, "Payer Name" character varying, "Payee VPA" character varying, "Payee Name" character varying, amount numeric, "FRM Pass" boolean, score integer, "Rule" character varying, "Payer Account" character varying, "Payee Account" character varying)
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE PARALLEL UNSAFE
    ROWS 1000

AS $BODY$
DECLARE num integer;
BEGIN
if(party = 'VPA')then
	If(vpatype='Payee') Then
		   Return query select L.iLiveMessageID as "ID", L.vcmsgid  as "Unique ID", L.dtTrxnTime at time zone 'Asia/Kolkata' at time zone timezone as "Time",
                               payervpa,
                               payername,
                               payeevpa,
                               payeename,
                               L.dTransAmount as "Amount", L.bFRMPassed as "FRM Pass", L.score as "Score", vcrulename as "Rule", L.vcpayeraccount, L.vcpayeeaccount from transactions.vw_livetrans_with_vpa_and_account_from_joins L
                        where vcmsgid=msgid and payeevpa = vpaaddress and L.txnclass=txnclassinput
                          and cast(L.dtTrxnTime at time zone 'Asia/Kolkata' at time zone timezone as date)=txndate;

Elseif(vpatype='Payer') Then
		 Return query select L.iLiveMessageID as "ID", L.vcmsgid  as "Unique ID", L.dtTrxnTime at time zone 'Asia/Kolkata' at time zone timezone as "Time",
                             payervpa,
                             payername,
                             payeevpa,
                             payeename,
                             L.dTransAmount as "Amount", L.bFRMPassed as "FRM Pass", L.score as "Score", vcrulename as "Rule", L.vcpayeraccount, L.vcpayeeaccount from transactions.vw_livetrans_with_vpa_and_account_from_joins L
                      where vcmsgid=msgid and payervpa = vpaaddress and L.txnclass=txnclassinput
                        and cast(L.dtTrxnTime at time zone 'Asia/Kolkata' at time zone timezone as date)=txndate;

Elseif(vpatype='Both') Then
		 Return query select L.iLiveMessageID as "ID", L.vcmsgid  as "Unique ID", L.dtTrxnTime at time zone 'Asia/Kolkata' at time zone timezone as "Time",
                             payervpa,
                             payername,
                             payeevpa,
                             payeename,
                             L.dTransAmount as "Amount", L.bFRMPassed as "FRM Pass", L.score as "Score", vcrulename as "Rule", L.vcpayeraccount, L.vcpayeeaccount from transactions.vw_livetrans_with_vpa_and_account_from_joins L
                      where vcmsgid=msgid and (payervpa = vpaaddress or payeevpa = vpaaddress) and L.txnclass=txnclassinput
                        and cast(L.dtTrxnTime at time zone 'Asia/Kolkata' at time zone timezone as date)=txndate;
End If;
elseif(party = 'Account')then
If(vpatype='Payee') Then
		   Return query select L.iLiveMessageID as "ID", L.vcmsgid  as "Unique ID", L.dtTrxnTime at time zone 'Asia/Kolkata' at time zone timezone as "Time",
                               payervpa,
                               payername,
                               payeevpa,
                               payeename,
                               L.dTransAmount as "Amount", L.bFRMPassed as "FRM Pass", L.score as "Score", vcrulename as "Rule", L.vcpayeraccount, L.vcpayeeaccount from transactions.vw_livetrans_with_vpa_and_account_from_joins L
                        where vcmsgid=msgid and vcpayeeaccount = vpaaddress and L.txnclass=txnclassinput
                          and cast(L.dtTrxnTime at time zone 'Asia/Kolkata' at time zone timezone as date)=txndate;

Elseif(vpatype='Payer') Then
		 Return query select L.iLiveMessageID as "ID", L.vcmsgid  as "Unique ID", L.dtTrxnTime at time zone 'Asia/Kolkata' at time zone timezone as "Time",
                             payervpa,
                             payername,
                             payeevpa,
                             payeename,
                             L.dTransAmount as "Amount", L.bFRMPassed as "FRM Pass", L.score as "Score", vcrulename as "Rule", L.vcpayeraccount, L.vcpayeeaccount from transactions.vw_livetrans_with_vpa_and_account_from_joins L
                      where vcmsgid=msgid and vcpayeraccount = vpaaddress and L.txnclass=txnclassinput
                        and cast(L.dtTrxnTime at time zone 'Asia/Kolkata' at time zone timezone as date)=txndate;

Elseif(vpatype='Both') Then
		 Return query select L.iLiveMessageID as "ID", L.vcmsgid  as "Unique ID", L.dtTrxnTime at time zone 'Asia/Kolkata' at time zone timezone as "Time",
                             payervpa,
                             payername,
                             payeevpa,
                             payeename,
                             L.dTransAmount as "Amount", L.bFRMPassed as "FRM Pass", L.score as "Score", vcrulename as "Rule", L.vcpayeraccount, L.vcpayeeaccount from transactions.vw_livetrans_with_vpa_and_account_from_joins L
                      where vcmsgid=msgid and (vcpayeraccount = vpaaddress or vcpayeeaccount = vpaaddress ) and L.txnclass=txnclassinput
                        and cast(L.dtTrxnTime at time zone 'Asia/Kolkata' at time zone timezone as date)=txndate;
End If;
end if;
End;

$BODY$;
