UPDATE ui.rules SET
vcquery = 'Select vcpayeeaccountexternalid, vcpayeeaddr, vcpayeecustomerexternalid from analytics.trans where itenantid =:tenantid and ipayeraccountid =  :iaccountid and dobservationamount >= :txn_threshold  and dttrxntime >= :tdate_min
and dttrxntime <=CURRENT_DATE;'::text WHERE
iruleid = 10162;