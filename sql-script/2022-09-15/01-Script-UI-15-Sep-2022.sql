UPDATE ui.perspectivequery
	SET vcquery='select ilivemessageid as "ILiveMessageID", vcmsgid as "UniqueID", vcclassname as "Class", dttrxntime at time zone ''Asia/Kolkata'' at time zone :timeZone as "Time",
dobservationamount as "Amount", score as "Score",  cast(result->''score''->>''bpass'' as text)as "FRMPass", vcpayeraccountexternalid as "Payer Account", vcpayeraddr as "PayerVPA",
vcpayeeaccountexternalid as "Payee Account", vcpayeeaddr as "PayeeVPA", null as "FailedRule", cast(observations->''observations''->''payerVPA''->>''vpaName'' as text) as "PayerName",  cast(observations->''observations''->''payeeVPA''->>''vpaName'' as text) as "PayeeName" from transactions.trans
 order by dttrxntime desc limit 1;'
	WHERE iperspectivequeryid=38;


UPDATE ui.menustructuredesc SET
vcaction='TransactionDB', vccontroller='TransactionDB', vcmenuname='Transaction DB', vcmini='TD',
vcpath='/analytics/transaction-dashboard', isortorder=0 WHERE imenuid=507;

UPDATE ui.menustructuredesc SET
vcaction='PartyDashboard', vccontroller='PartyDashboard',
vcmenuname='Party Dashboard', vcmini='PDO',
vcpath='/analytics/party-dashboard', isortorder=1 WHERE imenuid=508;

UPDATE ui.menustructuredesc SET
vcaction='TransactionProfile', vccontroller='TransactionProfile',
vcmenuname='Transaction Profile', vcmini='TP',
vcpath='/analytics/transaction-profile-dashboard', isortorder=2 WHERE imenuid=509;

UPDATE ui.menustructuredesc SET
vcaction='TransactionDBOld', vccontroller='TransactionDBOld', vcmenuname='Transaction DB Old', vcmini='TDO',
vcpath='/analytics/transaction-dashboard-old', isortorder=6 WHERE imenuid=544;

UPDATE ui.menustructuredesc SET
vcaction='PartyDashboardOld', vccontroller='PartyDashboardOld',
vcmenuname='Party Dashboard Old', vcmini='PDO',
vcpath='/analytics/party-dashboard-Old', isortorder=7 WHERE imenuid=545;

UPDATE ui.menustructuredesc SET
vcaction='TransactionProfileOld', vccontroller='TransactionProfileOld',
vcmenuname='Transaction Profile-old', vcmini='TP',
vcpath='/analytics/transaction-profile-dashboard-old', isortorder=8 WHERE imenuid=546;

UPDATE ui.dashboard
	SET vcdashboardname='Transaction Old'
	WHERE idashboardid=1;

UPDATE ui.dashboard
	SET vcdashboardname='Transaction'
	WHERE idashboardid=11;