CREATE OR REPLACE FUNCTION ui.getlivetrans_last_testdb_2(
	party character varying,
	vpatype character varying,
	timezone character varying,
	txnclassinput character varying,
	useraddress character varying,
	maxrecord integer)
    RETURNS TABLE("ID" bigint, "Unique ID" character varying, "Time" timestamp with time zone, "Payer VPA" character varying, "Payer Name" character varying, "Payee VPA" character varying, "Payee Name" character varying, amount numeric, "FRM Pass" boolean, score integer, "Rule" character varying, "Payer Account" character varying, "Payee Account" character varying)
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE PARALLEL UNSAFE
    ROWS 1000

AS $BODY$
BEGIN
If(txnclassinput ='"All"') Then
If(party='VPA') Then
		If(vpatype='Payer') Then
		Return query select L.iLiveMessageID as "ID", L.vcmsgid  as "Unique ID", L.dtTrxnTime at time zone 'Asia/Kolkata' at time zone timezone as "Time",
                            payervpa,
                            payername,
                            payeevpa,
                            payeename,
                            L.dTransAmount as "Amount", L.bFRMPassed as "FRM Pass", L.score as "Score", vcrulename as "Rule",
                            vcpayeraccount,
                            vcpayeeaccount
                     from transactions.vw_livetrans_with_vpa_and_account_from_joins L where
                               payervpa = useraddress and cast(L.dtTrxnTime as date) between current_date - 1 and current_date order by  L.dtTrxnTime desc limit maxrecord;

Elseif(vpatype='Payee') Then
		 Return query select L.iLiveMessageID as "ID", vcmsgid  as "Unique ID", L.dtTrxnTime at time zone 'Asia/Kolkata' at time zone timezone as "Time",
                             payervpa,
                             payername,
                             payeevpa,
                             payeename,
                             L.dTransAmount as "Amount", L.bFRMPassed as "FRM Pass", L.score as "Score", L.vcrulename as "Rule",
                             vcpayeraccount,
                             vcpayeeaccount
                      from transactions.vw_livetrans_with_vpa_and_account_from_joins L where
                                    payeevpa = useraddress and cast(L.dtTrxnTime as date) between current_date - 1 and current_date order by  L.dtTrxnTime desc limit maxrecord;

Elseif(vpatype='Both') Then
		 Return query select L.iLiveMessageID as "ID", vcmsgid  as "Unique ID", L.dtTrxnTime at time zone 'Asia/Kolkata' at time zone timezone as "Time",
                             payervpa,
                             payername,
                             payeevpa,
                             payeename,
                             L.dTransAmount as "Amount", L.bFRMPassed as "FRM Pass", L.score as "Score", L.vcrulename as "Rule",
                             vcpayeraccount,
                             vcpayeeaccount
                      from transactions.vw_livetrans_with_vpa_and_account_from_joins L where
                                (payeevpa = useraddress or payervpa = useraddress) and cast(L.dtTrxnTime as date) between current_date - 1 and current_date order by  L.dtTrxnTime desc limit maxrecord;

End If;
Elseif(party='Account')Then
	If(vpatype='Payer') Then
		Return query select L.iLiveMessageID as "ID", L.vcmsgid  as "Unique ID", L.dtTrxnTime at time zone 'Asia/Kolkata' at time zone timezone as "Time",
                            payervpa,
                            payername,
                            payeevpa,
                            payeename,
                            L.dTransAmount as "Amount", L.bFRMPassed as "FRM Pass", L.score as "Score", L.vcrulename as "Rule",
                            vcpayeraccount,
                            vcpayeeaccount
                     from transactions.vw_livetrans_with_vpa_and_account_from_joins L where
                     vcpayeraccount = useraddress and cast(L.dtTrxnTime as date) between current_date - 1 and current_date order by L.dtTrxnTime desc limit maxrecord;

Elseif(vpatype='Payee') Then
		Return query select L.iLiveMessageID as "ID", vcmsgid  as "Unique ID", L.dtTrxnTime at time zone 'Asia/Kolkata' at time zone timezone as "Time",
                            payervpa,
                            payername,
                            payeevpa,
                            payeename,
                            L.dTransAmount as "Amount", L.bFRMPassed as "FRM Pass", L.score as "Score", L.vcrulename as "Rule",
                            vcpayeraccount,
                            vcpayeeaccount
                     from transactions.vw_livetrans_with_vpa_and_account_from_joins L
					 where vcpayeeaccount = useraddress and cast(L.dtTrxnTime as date) between current_date - 1 and current_date order by  L.dtTrxnTime desc limit maxrecord;

Elseif(vpatype='Both') Then
			Return query select L.iLiveMessageID as "ID", vcmsgid  as "Unique ID", L.dtTrxnTime at time zone 'Asia/Kolkata' at time zone timezone as "Time",
                                payervpa,
                                payername,
                                payeevpa,
                                payeename,
                                L.dTransAmount as "Amount", L.bFRMPassed as "FRM Pass", L.score as "Score", L.vcrulename as "Rule",
                                vcpayeraccount,
                                vcpayeeaccount
                         from transactions.vw_livetrans_with_vpa_and_account_from_joins L where
                                   (vcpayeeaccount = useraddress or vcpayeraccount = useraddress) and cast(L.dtTrxnTime as date) between current_date - 1 and current_date order by  L.dtTrxnTime desc limit maxrecord;

End If;
End If;
else
If(party='VPA') Then
	If(vpatype='Payer') Then
		Return query select L.iLiveMessageID as "ID", L.vcmsgid  as "Unique ID", L.dtTrxnTime at time zone 'Asia/Kolkata' at time zone timezone as "Time",
                            payervpa,
                            payername,
                            payeevpa,
                            payeename,
                            L.dTransAmount as "Amount", L.bFRMPassed as "FRM Pass", L.score as "Score", vcrulename as "Rule",
                            vcpayeraccount,
                            vcpayeeaccount
                     from transactions.vw_livetrans_with_vpa_and_account_from_joins L where
                               payervpa = useraddress  and txnclass = txnclassinput and cast(L.dtTrxnTime as date) between current_date - 1 and current_date order by  L.dtTrxnTime desc limit maxrecord;

Elseif(vpatype='Payee') Then
		 Return query select L.iLiveMessageID as "ID", vcmsgid  as "Unique ID", L.dtTrxnTime at time zone 'Asia/Kolkata' at time zone timezone as "Time",
                             payervpa,
                             payername,
                             payeevpa,
                             payeename,
                             L.dTransAmount as "Amount", L.bFRMPassed as "FRM Pass", L.score as "Score", L.vcrulename as "Rule",
                             vcpayeraccount,
                             vcpayeeaccount
                      from transactions.vw_livetrans_with_vpa_and_account_from_joins L where
                                    payeevpa = useraddress and txnclass = txnclassinput and cast(L.dtTrxnTime as date) between current_date - 1 and current_date order by  L.dtTrxnTime desc limit maxrecord;

Elseif(vpatype='Both') Then
		 Return query select L.iLiveMessageID as "ID", vcmsgid  as "Unique ID", L.dtTrxnTime at time zone 'Asia/Kolkata' at time zone timezone as "Time",
                             payervpa,
                             payername,
                             payeevpa,
                             payeename,
                             L.dTransAmount as "Amount", L.bFRMPassed as "FRM Pass", L.score as "Score", L.vcrulename as "Rule",
                             vcpayeraccount,
                             vcpayeeaccount
                      from transactions.vw_livetrans_with_vpa_and_account_from_joins L where
					  (payeevpa = useraddress or payervpa = useraddress) and txnclass = txnclassinput
                       and cast(L.dtTrxnTime as date) between current_date - 1 and current_date order by  L.dtTrxnTime desc limit maxrecord;

End If;
Elseif(party='Account')Then
	If(vpatype='Payer') Then
		Return query select L.iLiveMessageID as "ID", L.vcmsgid  as "Unique ID", L.dtTrxnTime at time zone 'Asia/Kolkata' at time zone timezone as "Time",
                            payervpa,
                            payername,
                            payeevpa,
                            payeename,
                            L.dTransAmount as "Amount", L.bFRMPassed as "FRM Pass", L.score as "Score", L.vcrulename as "Rule",
                            vcpayeraccount,
                            vcpayeeaccount
                     from transactions.vw_livetrans_with_vpa_and_account_from_joins L where
					 vcpayeraccount = useraddress and L.txnclass = txnclassinput and cast(L.dtTrxnTime as date) between current_date - 1 and current_date
                     order by  L.dtTrxnTime desc limit maxrecord;

Elseif(vpatype='Payee') Then
		Return query select L.iLiveMessageID as "ID", vcmsgid  as "Unique ID", L.dtTrxnTime at time zone 'Asia/Kolkata' at time zone timezone as "Time",
                            payervpa,
                            payername,
                            payeevpa,
                            payeename,
                            L.dTransAmount as "Amount", L.bFRMPassed as "FRM Pass", L.score as "Score", L.vcrulename as "Rule",
                            vcpayeraccount,
                            vcpayeeaccount
                     from transactions.vw_livetrans_with_vpa_and_account_from_joins L
					 where vcpayeeaccount = useraddress and L.txnclass = txnclassinput and cast(L.dtTrxnTime as date) between current_date - 1 and current_date order by  L.dtTrxnTime desc limit maxrecord;

Elseif(vpatype='Both') Then
			Return query select L.iLiveMessageID as "ID", vcmsgid  as "Unique ID", L.dtTrxnTime at time zone 'Asia/Kolkata' at time zone timezone as "Time",
                                payervpa,
                                payername,
                                payeevpa,
                                payeename,
                                L.dTransAmount as "Amount", L.bFRMPassed as "FRM Pass", L.score as "Score", L.vcrulename as "Rule",
                                vcpayeraccount,
                                vcpayeeaccount
                         from transactions.vw_livetrans_with_vpa_and_account_from_joins L where (vcpayeeaccount = useraddress or vcpayeraccount = useraddress)
                                                                                            and L.txnclass = txnclassinput and cast(L.dtTrxnTime as date) between current_date - 1 and current_date order by  L.dtTrxnTime desc limit maxrecord;

End If;
End If;
End if;
End;

$BODY$;

