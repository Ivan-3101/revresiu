CREATE OR REPLACE FUNCTION ui.getpartydtxnsummarybyclass(
	party character varying,
	vpatype character varying,
	timezone character varying,
	txnclassinput character varying,
	useraddress character varying)
    RETURNS TABLE("Date" date, "Total Txn" bigint, "Failed Txn" bigint, "Passed Txn" bigint, amount numeric)
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE PARALLEL UNSAFE
    ROWS 1000

AS $BODY$
BEGIN
If(party='VPA') Then
	If(vpatype='Payer') Then
		Return query select cast(L.dtTrxnTime at time zone 'utc' at time zone timezone as date) as "Time",
                            count(ilivemessageid),
                            sum(case when bfrmpassed = false then 1 else 0 end),
                            sum(case when bfrmpassed = true then 1 else 0 end),
                            sum(dtransamount)
                     from transactions.vw_livetrans_with_vpa_and_account_from_joins L where payervpa = useraddress and txnclass = txnclassinput
                                                                                        and (CAST(dtTrxnTime AS date) = CURRENT_DATE-1 or CAST(dtTrxnTime AS date) = CURRENT_DATE) group by "Time";

Elseif(vpatype='Payee') Then
		 Return query select cast(L.dtTrxnTime at time zone 'utc' at time zone timezone as date) as "Time",
                             count(ilivemessageid),
                             sum(case when bfrmpassed = false then 1 else 0 end),
                             sum(case when bfrmpassed = true then 1 else 0 end),
                             sum(dtransamount)
                      from transactions.vw_livetrans_with_vpa_and_account_from_joins L where payeevpa = useraddress and txnclass = txnclassinput
                                                                                         and (CAST(dtTrxnTime AS date) = CURRENT_DATE-1 or CAST(dtTrxnTime AS date) = CURRENT_DATE) group by "Time";

Elseif(vpatype='Both') Then
		 Return query select cast(L.dtTrxnTime at time zone 'utc' at time zone timezone as date) as "Time",
                             count(ilivemessageid),
                             sum(case when bfrmpassed = false then 1 else 0 end),
                             sum(case when bfrmpassed = true then 1 else 0 end),
                             sum(dtransamount)
                      from transactions.vw_livetrans_with_vpa_and_account_from_joins L where payeevpa = useraddress or
                                        payervpa = useraddress and txnclass = txnclassinput and (CAST(dtTrxnTime AS date) = CURRENT_DATE-1 or CAST(dtTrxnTime AS date) = CURRENT_DATE) group by "Time";

End If;
Elseif(party='Account')Then
	If(vpatype='Payer') Then
		Return query select cast(L.dtTrxnTime at time zone 'utc' at time zone timezone as date) as "Time",
                            count(ilivemessageid),
                            sum(case when bfrmpassed = false then 1 else 0 end),
                            sum(case when bfrmpassed = true then 1 else 0 end),
                            sum(dtransamount)
                     from transactions.vw_livetrans_with_vpa_and_account_from_joins L where vcpayeraccount = useraddress and L.txnclass = txnclassinput
                                                                                        and (CAST(dtTrxnTime AS date) = CURRENT_DATE-1 or CAST(dtTrxnTime AS date) = CURRENT_DATE) group by "Time";

Elseif(vpatype='Payee') Then
		Return query select cast(L.dtTrxnTime at time zone 'utc' at time zone timezone as date) as "Time",
                            count(ilivemessageid),
                            sum(case when bfrmpassed = false then 1 else 0 end),
                            sum(case when bfrmpassed = true then 1 else 0 end),
                            sum(dtransamount)
                     from transactions.vw_livetrans_with_vpa_and_account_from_joins L where vcpayeeaccount = useraddress
                                                                                        and L.txnclass = txnclassinput and (CAST(dtTrxnTime AS date) = CURRENT_DATE-1 or CAST(dtTrxnTime AS date) = CURRENT_DATE) group by "Time";

Elseif(vpatype='Both') Then
			Return query select cast(L.dtTrxnTime at time zone 'utc' at time zone timezone as date) as "Time",
                                count(ilivemessageid),
                                sum(case when bfrmpassed = false then 1 else 0 end),
                                sum(case when bfrmpassed = true then 1 else 0 end),
                                sum(dtransamount)
                         from transactions.vw_livetrans_with_vpa_and_account_from_joins L where vcpayeeaccount = useraddress or vcpayeraccount = useraddress
    and L.txnclass = txnclassinput and (CAST(dtTrxnTime as date) = CURRENT_DATE-1 or CAST(dtTrxnTime as date) = CURRENT_DATE) group by "Time";

End If;
End If;
End;

$BODY$;


CREATE OR REPLACE FUNCTION ui.getpartytxnsummary(
	party character varying,
	vpatype character varying,
	timezone character varying,
	useraddress character varying)
    RETURNS TABLE("Date" date, "Total Txn" bigint, "Failed Txn" bigint, "Passed Txn" bigint, amount numeric)
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE PARALLEL UNSAFE
    ROWS 1000

AS $BODY$
BEGIN
If(party='VPA') Then
		If(vpatype='Payer') Then
		Return query select cast(L.dtTrxnTime at time zone 'utc' at time zone timezone as date) as "Time",
                            count(ilivemessageid),
                            sum(case when bfrmpassed = false then 1 else 0 end),
                            sum(case when bfrmpassed = true then 1 else 0 end),
                            sum(dtransamount)
                     from transactions.vw_livetrans_with_vpa_and_account_from_joins L where payervpa = useraddress
                                                                                        and (CAST(dtTrxnTime AS date) = CURRENT_DATE-1 or CAST(dtTrxnTime AS date) = CURRENT_DATE) group by "Time";

Elseif(vpatype='Payee') Then
		 Return query select cast(L.dtTrxnTime at time zone 'utc' at time zone timezone as date) as "Time",
                             count(ilivemessageid),
                             sum(case when bfrmpassed = false then 1 else 0 end),
                             sum(case when bfrmpassed = true then 1 else 0 end),
                             sum(dtransamount)
                      from transactions.vw_livetrans_with_vpa_and_account_from_joins L where payeevpa = useraddress
                                                                                         and (CAST(dtTrxnTime AS date) = CURRENT_DATE-1 or CAST(dtTrxnTime AS date) = CURRENT_DATE) group by "Time";

Elseif(vpatype='Both') Then
		 Return query select cast(L.dtTrxnTime at time zone 'utc' at time zone timezone as date) as "Time",
                             count(ilivemessageid),
                             sum(case when bfrmpassed = false then 1 else 0 end),
                             sum(case when bfrmpassed = true then 1 else 0 end),
                             sum(dtransamount)
                      from transactions.vw_livetrans_with_vpa_and_account_from_joins L where payeevpa = useraddress or payervpa = useraddress
    and (CAST(dtTrxnTime AS date) = CURRENT_DATE-1 or CAST(dtTrxnTime AS date) = CURRENT_DATE) group by "Time";

End If;
Elseif(party='Account')Then
	If(vpatype='Payer') Then
		Return query select cast(L.dtTrxnTime at time zone 'utc' at time zone timezone as date) as "Time",
                            count(ilivemessageid),
                            sum(case when bfrmpassed = false then 1 else 0 end),
                            sum(case when bfrmpassed = true then 1 else 0 end),
                            sum(dtransamount)
                     from transactions.vw_livetrans_with_vpa_and_account_from_joins L where vcpayeraccount = useraddress
                                                                                        and (CAST(dtTrxnTime AS date) = CURRENT_DATE-1 or CAST(dtTrxnTime AS date) = CURRENT_DATE) group by "Time";

Elseif(vpatype='Payee') Then
		Return query  select cast(L.dtTrxnTime at time zone 'utc' at time zone timezone as date) as "Time",
                             count(ilivemessageid),
                             sum(case when bfrmpassed = false then 1 else 0 end),
                             sum(case when bfrmpassed = true then 1 else 0 end),
                             sum(dtransamount)
                      from transactions.vw_livetrans_with_vpa_and_account_from_joins L where vcpayeeaccount = useraddress
                                                                                         and (CAST(dtTrxnTime AS date) = CURRENT_DATE-1 or CAST(dtTrxnTime AS date) = CURRENT_DATE) group by "Time";

Elseif(vpatype='Both') Then
			Return query select cast(L.dtTrxnTime at time zone 'utc' at time zone timezone as date) as "Time",
                                count(ilivemessageid),
                                sum(case when bfrmpassed = false then 1 else 0 end),
                                sum(case when bfrmpassed = true then 1 else 0 end),
                                sum(dtransamount)
                         from transactions.vw_livetrans_with_vpa_and_account_from_joins L where
                                       vcpayeeaccount = useraddress or vcpayeraccount = useraddress
        and (CAST(dtTrxnTime as date) = CURRENT_DATE-1 or CAST(dtTrxnTime as date) = CURRENT_DATE) group by "Time";

End If;
End If;
End;

$BODY$;