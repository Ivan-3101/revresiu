CREATE OR REPLACE VIEW transactions.vw_livetrans_with_vpa_and_account_from_joins
 AS
SELECT l.ilivemessageid,
       l.vcmsgid,
       l.vcuniquetransid,
       l.dttrxntime,
       l.ipayervpaid,
       l.ipayervpaproviderid,
       l.ipayeevpaid,
       l.ipayeevpaproviderid,
       l.dsettledamount,
       l.dtransamount,
       l.dfailedamount,
       l.bnewpayer,
       l.bnewpayeeforpayer,
       l.bfrmpassed,
       l.btransfailed,
       l.dtupdatedtime,
       l.observations,
       l.ifailedruleid,
       l.score,
       ((l.observations -> 'txn'::text) -> 'class'::text)::text AS txnclass,
    r.vcrulename,
    l.result,
    payervpa.vcaddress AS payervpa,
    payervpa.vcvpaname AS payername,
    payeevpa.vcaddress AS payeevpa,
    payeevpa.vcvpaname AS payeename,
    payeraccount.vcaccount AS vcpayeraccount,
    payeeaccount.vcaccount AS vcpayeeaccount,
    payercustomers.vccustomername AS payercustomersname,
    payeecustomers.vccustomername AS payeecustomersname
FROM transactions.livetrans l
    LEFT JOIN masters.rules r ON r.iruleid = l.ifailedruleid
    LEFT JOIN masters.vpa payervpa ON payervpa.ivpaid = l.ipayervpaid
    LEFT JOIN masters.accounts payeraccount ON payeraccount.iaccountid = payervpa.iaccountid
    LEFT JOIN masters.customers payercustomers ON payercustomers.icustomerid = payeraccount.icustomerid
    LEFT JOIN masters.vpa payeevpa ON payeevpa.ivpaid = l.ipayeevpaid
    LEFT JOIN masters.accounts payeeaccount ON payeeaccount.iaccountid = payeevpa.iaccountid
    LEFT JOIN masters.customers payeecustomers ON payeecustomers.icustomerid = payeeaccount.icustomerid;



CREATE OR REPLACE VIEW transactions.vw_livetrans_dashboard_with_joins
 AS
SELECT l.ilivemessageid,
       l.vcmsgid,
       l.vcuniquetransid,
       l.dttrxntime,
       l.ipayervpaid,
       l.ipayervpaproviderid,
       l.ipayeevpaid,
       l.ipayeevpaproviderid,
       l.dsettledamount,
       l.dtransamount,
       l.dfailedamount,
       l.bnewpayer,
       l.bnewpayeeforpayer,
       l.bfrmpassed,
       l.btransfailed,
       l.dtupdatedtime,
       l.observations,
       l.ifailedruleid,
       (l.observations -> 'org'::text)::text AS org,
        ((l.observations -> 'txn'::text) -> 'class'::text)::text AS txnclass,
    ((l.observations -> 'payee'::text) -> 'mcc'::text)::text AS mcc,
    (((l.observations -> 'payer'::text) -> 'attribs'::text) -> 'device'::text)::text AS device,
    ((((l.observations -> 'payer'::text) -> 'attribs'::text) -> 'device'::text) -> 'ip'::text)::text AS ip,
    ((((l.observations -> 'payer'::text) -> 'attribs'::text) -> 'device'::text) -> 'location'::text)::text AS location,
    ((((l.observations -> 'payer'::text) -> 'attribs'::text) -> 'device'::text) -> 'id'::text)::text AS deviceid,
    ((((l.observations -> 'payer'::text) -> 'attribs'::text) -> 'device'::text) -> 'os'::text)::text AS os,
    r.vcrulename,
    ((l.result -> 'score'::text) -> 'score'::text)::text AS score,
    (l.result -> 'status'::text)::text AS status,
    ((l.result -> 'score'::text) -> 'decisiondetails'::text)::text AS decisiondetails,
	payervpa.vcaddress AS payervpa,
    payervpa.vcvpaname AS payername,
    payeevpa.vcaddress AS payeevpa,
    payeevpa.vcvpaname AS payeename,
    payeraccount.vcaccount AS vcpayeraccount,
    payeeaccount.vcaccount AS vcpayeeaccount,
    payercustomers.vccustomername AS payercustomersname,
    payeecustomers.vccustomername AS payeecustomersname
FROM transactions.livetrans l
    LEFT JOIN masters.rules r ON r.iruleid = l.ifailedruleid
    LEFT JOIN masters.vpa payervpa ON payervpa.ivpaid = l.ipayervpaid
    LEFT JOIN masters.accounts payeraccount ON payeraccount.iaccountid = payervpa.iaccountid
    LEFT JOIN masters.customers payercustomers ON payercustomers.icustomerid = payeraccount.icustomerid
    LEFT JOIN masters.vpa payeevpa ON payeevpa.ivpaid = l.ipayeevpaid
    LEFT JOIN masters.accounts payeeaccount ON payeeaccount.iaccountid = payeevpa.iaccountid
    LEFT JOIN masters.customers payeecustomers ON payeecustomers.icustomerid = payeeaccount.icustomerid;

