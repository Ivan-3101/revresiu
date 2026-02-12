CREATE OR REPLACE VIEW transactions.vw_livetrans_dashboard
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
    ((l.result -> 'score'::text) -> 'decisiondetails'::text)::text AS decisiondetails
FROM transactions.livetrans l
    LEFT JOIN masters.rules r ON r.iruleid = l.ifailedruleid;


