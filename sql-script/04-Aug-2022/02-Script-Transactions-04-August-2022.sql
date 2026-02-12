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
    r.vcrulename,
	l.result
FROM transactions.livetrans l
    LEFT JOIN masters.rules r ON r.iruleid = l.ifailedruleid;