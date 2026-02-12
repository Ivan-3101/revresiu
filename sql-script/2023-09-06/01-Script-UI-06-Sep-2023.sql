INSERT INTO ui.dashboardquery (
vcdashboardquery, runonanalytics, formattingrequiered, imenustructuredesc, vcfilterparametersjson, idashboardqueryid, bparametersrequired) VALUES (
'select ilivemessageid as "ILiveMessageID", vcmsgid as "UniqueID", vcclassname as "Class", dttrxntime at time zone ''Asia/Kolkata'' at time zone :timeZone as "Time",
dobservationamount as "Amount", score as "Score",  cast(result->''score''->>''bpass'' as text)as "FRMPass", vcpayeraccountexternalid as "Payer Account", vcpayeraddr as "PayerVPA",
vcpayeeaccountexternalid as "Payee Account", vcpayeeaddr as "PayeeVPA", null as "FailedRule", cast(observations->''observations''->''payerVPA''->>''vpaName'' as text) as "PayerName",
cast(observations->''observations''->''payeeVPA''->>''vpaName'' as text) as "PayeeName" from transactions.trans where vcmsgid = :msgid ;'::text, true::boolean, NULL::boolean, '509'::integer, '{"msgid":null}'::text, '78'::integer, true::boolean)
 returning idashboardqueryid;

 INSERT INTO ui.dashboardqueryparameters (
 idashboardparameterid, vcparametername, vcparametertype, idashboardqueryid) VALUES (
 '125'::integer, 'msgid'::character varying, 'String'::character varying, '78'::integer)
  returning idashboardparameterid;