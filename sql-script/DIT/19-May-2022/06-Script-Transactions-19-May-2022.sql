CREATE OR REPLACE VIEW transactions.reqtrans
 AS
SELECT livetrans.vcmsgid AS reqid,
       (livetrans.observations - 'observations'::text)::text AS txn,
        (((((livetrans.observations -> 'observations'::text) -> 'payeeVPA'::text) -> 'account'::text) -> 'customer'::text) -> 'registered_mobile'::text)::text AS phone
FROM transactions.livetrans;



CREATE OR REPLACE VIEW transactions.vw_livetrans
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
    r.vcrulename
FROM transactions.livetrans l
    LEFT JOIN masters.rules r ON r.iruleid = l.ifailedruleid;
