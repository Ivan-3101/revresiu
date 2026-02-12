ALTER TABLE IF EXISTS analytics.trans
    ADD COLUMN vctxnfield3 character varying(100);

ALTER TABLE IF EXISTS analytics.trans
    ADD COLUMN vctxnfield4 character varying(100);

CREATE INDEX IF NOT EXISTS ix_trans_l1_vctxnfield3_itenant
    ON analytics.trans USING btree
    (itenantid ASC NULLS LAST, vctxnfield3 ASC NULLS LAST)
;

CREATE INDEX IF NOT EXISTS ix_trans_l1_vctxnfield4_itenant
    ON analytics.trans USING btree
    (itenantid ASC NULLS LAST, vctxnfield4 ASC NULLS LAST)
;


UPDATE ui.dashboardquery SET
vcdashboardquery
='{
     "Txn":"SELECT X.* FROM   (VALUES (''Txn ID'', ''Txn ID''),(''RRN'', ''RRN''), (''Auth Code'', ''Auth Code''), (''Invoice'', ''Invoice''), (''Processor Transaction ID'', ''Processor Transaction ID'')) AS X (\"label\", \"value\")",
     "Other":"SELECT X.* FROM   (VALUES (''Payer'', ''Payer''),(''Payee'', ''Payee''), (''Both'', ''Both'')) AS X (\"label\", \"value\")"
 }' WHERE itenantid in (14, 15) AND idashboardqueryid = 127;

UPDATE ui.dashboardquery SET
vcdashboardquery =  E'{
    "Account": {
        "Payer": "SELECT observations -> ''txn'' ->> ''id'' AS \\"Txn id\\", observations -> ''txn'' -> ''attribs'' -> ''initator'' ->> ''customerId'' AS \\"Initiator User ID\\", observations -> ''txn'' -> ''attribs'' ->> ''captureMethod'' AS \\"Capture Method\\", observations -> ''txn'' -> ''attribs'' ->> ''mode'' AS \\"Mode\\", observations -> ''txn'' -> ''attribs'' -> ''method'' ->> ''type'' AS \\"Type\\", observations -> ''txn'' -> ''attribs'' -> ''method'' ->> ''subtype'' AS \\"Subtype\\", observations -> ''txn'' -> ''attribs'' ->> ''application'' AS \\"Application\\", observations -> ''txn'' -> ''attribs'' -> ''initatingEntity'' ->> ''entityId'' AS \\"Initiating entity ID\\", observations -> ''txn'' -> ''attribs'' ->> ''processingEntity'' AS  \\"processingEntity\\", observations -> ''txn'' -> ''attribs'' ->> ''invoice'' AS \\"Invoice\\", observations -> ''txn'' -> ''attribs'' ->> ''idempotentKey'' AS \\"Idempotent Key\\", CASE WHEN observations -> ''payer''  ->> ''amount'' = ''null'' THEN NULL ELSE CAST(NULLIF(observations -> ''payer''  ->> ''amount'', '''') AS float) END AS \\"Txn amount\\", CASE WHEN observations -> ''payer'' -> ''attribs'' ->> ''grossAmount'' = ''null'' THEN NULL ELSE CAST(NULLIF(observations -> ''payer'' -> ''attribs'' ->> ''grossAmount'', '''') AS float) END AS \\"Gross Amt\\", observations -> ''payer'' -> ''attribs'' ->> ''capturedAmount''  AS \\"Captured Amount\\", observations -> ''payer'' ->> ''type''  AS \\"Payer type\\", observations -> ''payer'' -> ''attribs'' -> ''identity'' ->> ''email'' AS \\"Payer email\\", observations -> ''payer'' ->> ''vpa''  AS \\"Payer addr\\", observations -> ''payer'' -> ''attribs'' ->> ''userID''  AS \\"Payer user ID\\", observations -> ''payee'' -> ''attribs'' ->> ''merchantID''  AS \\"Payee Merchant ID\\", observations -> ''payee'' -> ''attribs'' ->> ''terminalID''  AS \\"Payee Terminal ID\\", CASE WHEN observations -> ''payee'' ->> ''mcc'' = ''null'' THEN NULL ELSE CAST(NULLIF(observations -> ''payee'' ->> ''mcc'', '''') AS int) END AS \\"Payee MCC\\", observations -> ''payer'' ->> ''name''  AS \\"Payer name\\", observations -> ''payer'' -> ''attribs'' -> ''device'' ->> ''countryCode'' AS \\"Country Code\\", observations -> ''payer'' -> ''attribs'' -> ''device'' ->> ''mobilenum'' AS \\"Payer Mobile Number\\", observations -> ''payer'' -> ''attribs'' -> ''account_detail'' ->> ''accountType''  AS \\"Payer Account Type\\", observations -> ''payer'' -> ''attribs'' ->> ''cardType''  AS \\"Payer Card Type\\", observations -> ''payer'' -> ''attribs'' -> ''card'' ->> ''scheme'' AS \\"Payer Card Scheme\\", observations -> ''payer'' -> ''attribs'' -> ''card'' ->> ''cardType'' AS \\"Payer Card Type\\", observations -> ''payer'' -> ''attribs'' -> ''card'' ->> ''cardNumber'' AS \\"Payer Card Number\\", observations -> ''payer'' -> ''attribs'' -> ''card'' ->> ''cardName'' AS \\"Payer Card Name\\", observations -> ''payer'' -> ''attribs'' -> ''card'' ->> ''cardExpiryMM'' AS \\"Payer Card Expiry Month\\", observations -> ''payer'' -> ''attribs'' -> ''card'' ->> ''cardExpiryYY'' AS \\"Payer Card Expiry Year\\", observations -> ''payer'' -> ''attribs'' -> ''card'' ->> ''cvv'' AS \\"Payer Card cvv\\", observations -> ''payee'' ->> ''type''  AS \\"Payee Type\\", observations -> ''payee'' -> ''attribs'' ->> ''terminalID''  AS \\"Payee Terminal ID\\", observations -> ''payee'' -> ''attribs'' ->> ''merchantID''  AS \\"Payee Merchant ID\\", observations -> ''payee'' ->> ''mcc'' AS \\"Payee MCC\\", observations -> ''payee'' -> ''attribs'' -> ''identity'' ->>''name''  AS \\"Payee Name\\", observations -> ''payee'' -> ''attribs'' -> ''identity'' ->>''email''  AS \\"Payee Email\\", observations -> ''payee'' -> ''attribs'' -> ''identity'' -> ''mobile'' ->> ''countryCode''  AS \\"Country Code\\", observations -> ''payee'' -> ''attribs'' -> ''identity'' -> ''mobile'' ->> ''number''   AS \\"Payee Mobile Number\\", observations -> ''payee'' ->> ''vpa''  AS \\"Payee Addr\\", observations -> ''payee'' -> ''attribs'' -> ''card'' ->> ''cardNumber'' AS \\"Payee Card Number\\", observations -> ''payee'' -> ''attribs'' -> ''card'' ->> ''scheme'' AS \\"Payee Card Scheme\\", observations -> ''payee'' -> ''attribs'' -> ''card'' ->> ''cardType'' AS \\"Payee Card Type\\", observations -> ''payee'' -> ''attribs'' -> ''card'' ->> ''product'' AS \\"Payee Card Product\\", observations -> ''payee'' -> ''attribs'' -> ''card'' ->> ''name'' AS \\"Payee Card Name\\", observations -> ''payee'' -> ''attribs'' -> ''account_detail'' ->> ''bankName'' AS \\"Payee Bank Name\\", observations -> ''payee'' -> ''attribs'' -> ''account_detail'' ->> ''accountType'' AS \\"Payee Account Type\\", observations -> ''payee'' -> ''attribs'' -> ''address'' ->> ''pinCode'' AS \\"Payee Address Pincode\\", observations -> ''payee'' -> ''attribs'' -> ''address'' ->> ''stateCode'' AS \\"Payee Address State Code\\", observations -> ''payee'' -> ''attribs'' -> ''address'' ->> ''countryCode'' AS \\"Payee Address Country COde\\", observations -> ''payee'' -> ''attribs'' -> ''address'' ->> ''city'' AS \\"Payee Address City\\", observations -> ''payee'' -> ''attribs'' -> ''address'' ->> ''line1'' AS \\"Payee Address Line1\\", observations -> ''payee'' -> ''attribs'' -> ''address'' ->> ''stateCode'' AS \\"Payee Address Line2\\", observations -> ''txn'' -> ''attribs'' -> ''device'' ->> ''geocode'' AS \\"Geocode\\", observations -> ''txn'' -> ''attribs'' -> ''device'' ->> ''location'' AS \\"Location\\", observations -> ''txn'' -> ''attribs'' -> ''device'' ->> ''ip'' AS \\"IP\\", observations -> ''txn'' -> ''attribs'' -> ''device'' ->> ''type'' AS \\"Device Type\\", observations -> ''txn'' -> ''attribs'' -> ''device'' ->> ''id'' AS \\"Device ID\\", observations -> ''txn'' -> ''attribs'' -> ''device'' ->> ''os'' AS \\"Device OS\\", observations -> ''txn'' -> ''attribs'' -> ''device'' ->> ''appName'' AS \\"Device App\\", observations -> ''txn'' -> ''attribs'' -> ''device'' ->> ''capability'' AS \\"Device Capability\\", observations -> ''observations'' ->> ''payer_card_d01_txn_count'' AS \\"payer_card_d01_txn_count\\", observations -> ''observations'' ->> ''payee_account_open_refund_d01_txn_value'' AS \\"payee_account_open_refund_d01_txn_value\\", observations -> ''observations'' ->> ''payee_account_open_d01_txn_value'' AS \\"payee_account_open_d01_txn_value\\", observations -> ''observations'' ->> ''payee_account_p1d_txn_value'' AS \\"payee_account_p1d_txn_value\\" FROM analytics.trans l where  l.vcpayeraccountexternalid = :VpaAddress  and  dttrxntime between :StartDate  and :EndDate and itenantid = :tenantid  order by dttrxntime desc limit 50000",
        "Payee": "SELECT observations -> ''txn'' ->> ''id'' AS \\"Txn id\\", observations -> ''txn'' -> ''attribs'' -> ''initator'' ->> ''customerId'' AS \\"Initiator User ID\\", observations -> ''txn'' -> ''attribs'' ->> ''captureMethod'' AS \\"Capture Method\\", observations -> ''txn'' -> ''attribs'' ->> ''mode'' AS \\"Mode\\", observations -> ''txn'' -> ''attribs'' -> ''method'' ->> ''type'' AS \\"Type\\", observations -> ''txn'' -> ''attribs'' -> ''method'' ->> ''subtype'' AS \\"Subtype\\", observations -> ''txn'' -> ''attribs'' ->> ''application'' AS \\"Application\\", observations -> ''txn'' -> ''attribs'' -> ''initatingEntity'' ->> ''entityId'' AS \\"Initiating entity ID\\", observations -> ''txn'' -> ''attribs'' ->> ''processingEntity'' AS  \\"processingEntity\\", observations -> ''txn'' -> ''attribs'' ->> ''invoice'' AS \\"Invoice\\", observations -> ''txn'' -> ''attribs'' ->> ''idempotentKey'' AS \\"Idempotent Key\\", CASE WHEN observations -> ''payer''  ->> ''amount'' = ''null'' THEN NULL ELSE CAST(NULLIF(observations -> ''payer''  ->> ''amount'', '''') AS float) END AS \\"Txn amount\\", CASE WHEN observations -> ''payer'' -> ''attribs'' ->> ''grossAmount'' = ''null'' THEN NULL ELSE CAST(NULLIF(observations -> ''payer'' -> ''attribs'' ->> ''grossAmount'', '''') AS float) END AS \\"Gross Amt\\", observations -> ''payer'' -> ''attribs'' ->> ''capturedAmount''  AS \\"Captured Amount\\", observations -> ''payer'' ->> ''type''  AS \\"Payer type\\", observations -> ''payer'' -> ''attribs'' -> ''identity'' ->> ''email'' AS \\"Payer email\\", observations -> ''payer'' ->> ''vpa''  AS \\"Payer addr\\", observations -> ''payer'' -> ''attribs'' ->> ''userID''  AS \\"Payer user ID\\", observations -> ''payee'' -> ''attribs'' ->> ''merchantID''  AS \\"Payee Merchant ID\\", observations -> ''payee'' -> ''attribs'' ->> ''terminalID''  AS \\"Payee Terminal ID\\", CASE WHEN observations -> ''payee'' ->> ''mcc'' = ''null'' THEN NULL ELSE CAST(NULLIF(observations -> ''payee'' ->> ''mcc'', '''') AS int) END AS \\"Payee MCC\\", observations -> ''payer'' ->> ''name''  AS \\"Payer name\\", observations -> ''payer'' -> ''attribs'' -> ''device'' ->> ''countryCode'' AS \\"Country Code\\", observations -> ''payer'' -> ''attribs'' -> ''device'' ->> ''mobilenum'' AS \\"Payer Mobile Number\\", observations -> ''payer'' -> ''attribs'' -> ''account_detail'' ->> ''accountType''  AS \\"Payer Account Type\\", observations -> ''payer'' -> ''attribs'' ->> ''cardType''  AS \\"Payer Card Type\\", observations -> ''payer'' -> ''attribs'' -> ''card'' ->> ''scheme'' AS \\"Payer Card Scheme\\", observations -> ''payer'' -> ''attribs'' -> ''card'' ->> ''cardType'' AS \\"Payer Card Type\\", observations -> ''payer'' -> ''attribs'' -> ''card'' ->> ''cardNumber'' AS \\"Payer Card Number\\", observations -> ''payer'' -> ''attribs'' -> ''card'' ->> ''cardName'' AS \\"Payer Card Name\\", observations -> ''payer'' -> ''attribs'' -> ''card'' ->> ''cardExpiryMM'' AS \\"Payer Card Expiry Month\\", observations -> ''payer'' -> ''attribs'' -> ''card'' ->> ''cardExpiryYY'' AS \\"Payer Card Expiry Year\\", observations -> ''payer'' -> ''attribs'' -> ''card'' ->> ''cvv'' AS \\"Payer Card cvv\\", observations -> ''payee'' ->> ''type''  AS \\"Payee Type\\", observations -> ''payee'' -> ''attribs'' ->> ''terminalID''  AS \\"Payee Terminal ID\\", observations -> ''payee'' -> ''attribs'' ->> ''merchantID''  AS \\"Payee Merchant ID\\", observations -> ''payee'' ->> ''mcc'' AS \\"Payee MCC\\", observations -> ''payee'' -> ''attribs'' -> ''identity'' ->>''name''  AS \\"Payee Name\\", observations -> ''payee'' -> ''attribs'' -> ''identity'' ->>''email''  AS \\"Payee Email\\", observations -> ''payee'' -> ''attribs'' -> ''identity'' -> ''mobile'' ->> ''countryCode''  AS \\"Country Code\\", observations -> ''payee'' -> ''attribs'' -> ''identity'' -> ''mobile'' ->> ''number''   AS \\"Payee Mobile Number\\", observations -> ''payee'' ->> ''vpa''  AS \\"Payee Addr\\", observations -> ''payee'' -> ''attribs'' -> ''card'' ->> ''cardNumber'' AS \\"Payee Card Number\\", observations -> ''payee'' -> ''attribs'' -> ''card'' ->> ''scheme'' AS \\"Payee Card Scheme\\", observations -> ''payee'' -> ''attribs'' -> ''card'' ->> ''cardType'' AS \\"Payee Card Type\\", observations -> ''payee'' -> ''attribs'' -> ''card'' ->> ''product'' AS \\"Payee Card Product\\", observations -> ''payee'' -> ''attribs'' -> ''card'' ->> ''name'' AS \\"Payee Card Name\\", observations -> ''payee'' -> ''attribs'' -> ''account_detail'' ->> ''bankName'' AS \\"Payee Bank Name\\", observations -> ''payee'' -> ''attribs'' -> ''account_detail'' ->> ''accountType'' AS \\"Payee Account Type\\", observations -> ''payee'' -> ''attribs'' -> ''address'' ->> ''pinCode'' AS \\"Payee Address Pincode\\", observations -> ''payee'' -> ''attribs'' -> ''address'' ->> ''stateCode'' AS \\"Payee Address State Code\\", observations -> ''payee'' -> ''attribs'' -> ''address'' ->> ''countryCode'' AS \\"Payee Address Country COde\\", observations -> ''payee'' -> ''attribs'' -> ''address'' ->> ''city'' AS \\"Payee Address City\\", observations -> ''payee'' -> ''attribs'' -> ''address'' ->> ''line1'' AS \\"Payee Address Line1\\", observations -> ''payee'' -> ''attribs'' -> ''address'' ->> ''stateCode'' AS \\"Payee Address Line2\\", observations -> ''txn'' -> ''attribs'' -> ''device'' ->> ''geocode'' AS \\"Geocode\\", observations -> ''txn'' -> ''attribs'' -> ''device'' ->> ''location'' AS \\"Location\\", observations -> ''txn'' -> ''attribs'' -> ''device'' ->> ''ip'' AS \\"IP\\", observations -> ''txn'' -> ''attribs'' -> ''device'' ->> ''type'' AS \\"Device Type\\", observations -> ''txn'' -> ''attribs'' -> ''device'' ->> ''id'' AS \\"Device ID\\", observations -> ''txn'' -> ''attribs'' -> ''device'' ->> ''os'' AS \\"Device OS\\", observations -> ''txn'' -> ''attribs'' -> ''device'' ->> ''appName'' AS \\"Device App\\", observations -> ''txn'' -> ''attribs'' -> ''device'' ->> ''capability'' AS \\"Device Capability\\", observations -> ''observations'' ->> ''payer_card_d01_txn_count'' AS \\"payer_card_d01_txn_count\\", observations -> ''observations'' ->> ''payee_account_open_refund_d01_txn_value'' AS \\"payee_account_open_refund_d01_txn_value\\", observations -> ''observations'' ->> ''payee_account_open_d01_txn_value'' AS \\"payee_account_open_d01_txn_value\\", observations -> ''observations'' ->> ''payee_account_p1d_txn_value'' AS \\"payee_account_p1d_txn_value\\" FROM analytics.trans l where l.vcpayeeaccountexternalid = :VpaAddress  and dttrxntime between :StartDate and  :EndDate and itenantid = :tenantid  order by dttrxntime desc limit 50000",
        "Both": "SELECT observations -> ''txn'' ->> ''id'' AS \\"Txn id\\", observations -> ''txn'' -> ''attribs'' -> ''initator'' ->> ''customerId'' AS \\"Initiator User ID\\", observations -> ''txn'' -> ''attribs'' ->> ''captureMethod'' AS \\"Capture Method\\", observations -> ''txn'' -> ''attribs'' ->> ''mode'' AS \\"Mode\\", observations -> ''txn'' -> ''attribs'' -> ''method'' ->> ''type'' AS \\"Type\\", observations -> ''txn'' -> ''attribs'' -> ''method'' ->> ''subtype'' AS \\"Subtype\\", observations -> ''txn'' -> ''attribs'' ->> ''application'' AS \\"Application\\", observations -> ''txn'' -> ''attribs'' -> ''initatingEntity'' ->> ''entityId'' AS \\"Initiating entity ID\\", observations -> ''txn'' -> ''attribs'' ->> ''processingEntity'' AS  \\"processingEntity\\", observations -> ''txn'' -> ''attribs'' ->> ''invoice'' AS \\"Invoice\\", observations -> ''txn'' -> ''attribs'' ->> ''idempotentKey'' AS \\"Idempotent Key\\", CASE WHEN observations -> ''payer''  ->> ''amount'' = ''null'' THEN NULL ELSE CAST(NULLIF(observations -> ''payer''  ->> ''amount'', '''') AS float) END AS \\"Txn amount\\", CASE WHEN observations -> ''payer'' -> ''attribs'' ->> ''grossAmount'' = ''null'' THEN NULL ELSE CAST(NULLIF(observations -> ''payer'' -> ''attribs'' ->> ''grossAmount'', '''') AS float) END AS \\"Gross Amt\\", observations -> ''payer'' -> ''attribs'' ->> ''capturedAmount''  AS \\"Captured Amount\\", observations -> ''payer'' ->> ''type''  AS \\"Payer type\\", observations -> ''payer'' -> ''attribs'' -> ''identity'' ->> ''email'' AS \\"Payer email\\", observations -> ''payer'' ->> ''vpa''  AS \\"Payer addr\\", observations -> ''payer'' -> ''attribs'' ->> ''userID''  AS \\"Payer user ID\\", observations -> ''payee'' -> ''attribs'' ->> ''merchantID''  AS \\"Payee Merchant ID\\", observations -> ''payee'' -> ''attribs'' ->> ''terminalID''  AS \\"Payee Terminal ID\\", CASE WHEN observations -> ''payee'' ->> ''mcc'' = ''null'' THEN NULL ELSE CAST(NULLIF(observations -> ''payee'' ->> ''mcc'', '''') AS int) END AS \\"Payee MCC\\", observations -> ''payer'' ->> ''name''  AS \\"Payer name\\", observations -> ''payer'' -> ''attribs'' -> ''device'' ->> ''countryCode'' AS \\"Country Code\\", observations -> ''payer'' -> ''attribs'' -> ''device'' ->> ''mobilenum'' AS \\"Payer Mobile Number\\", observations -> ''payer'' -> ''attribs'' -> ''account_detail'' ->> ''accountType''  AS \\"Payer Account Type\\", observations -> ''payer'' -> ''attribs'' ->> ''cardType''  AS \\"Payer Card Type\\", observations -> ''payer'' -> ''attribs'' -> ''card'' ->> ''scheme'' AS \\"Payer Card Scheme\\", observations -> ''payer'' -> ''attribs'' -> ''card'' ->> ''cardType'' AS \\"Payer Card Type\\", observations -> ''payer'' -> ''attribs'' -> ''card'' ->> ''cardNumber'' AS \\"Payer Card Number\\", observations -> ''payer'' -> ''attribs'' -> ''card'' ->> ''cardName'' AS \\"Payer Card Name\\", observations -> ''payer'' -> ''attribs'' -> ''card'' ->> ''cardExpiryMM'' AS \\"Payer Card Expiry Month\\", observations -> ''payer'' -> ''attribs'' -> ''card'' ->> ''cardExpiryYY'' AS \\"Payer Card Expiry Year\\", observations -> ''payer'' -> ''attribs'' -> ''card'' ->> ''cvv'' AS \\"Payer Card cvv\\", observations -> ''payee'' ->> ''type''  AS \\"Payee Type\\", observations -> ''payee'' -> ''attribs'' ->> ''terminalID''  AS \\"Payee Terminal ID\\", observations -> ''payee'' -> ''attribs'' ->> ''merchantID''  AS \\"Payee Merchant ID\\", observations -> ''payee'' ->> ''mcc'' AS \\"Payee MCC\\", observations -> ''payee'' -> ''attribs'' -> ''identity'' ->>''name''  AS \\"Payee Name\\", observations -> ''payee'' -> ''attribs'' -> ''identity'' ->>''email''  AS \\"Payee Email\\", observations -> ''payee'' -> ''attribs'' -> ''identity'' -> ''mobile'' ->> ''countryCode''  AS \\"Country Code\\", observations -> ''payee'' -> ''attribs'' -> ''identity'' -> ''mobile'' ->> ''number''   AS \\"Payee Mobile Number\\", observations -> ''payee'' ->> ''vpa''  AS \\"Payee Addr\\", observations -> ''payee'' -> ''attribs'' -> ''card'' ->> ''cardNumber'' AS \\"Payee Card Number\\", observations -> ''payee'' -> ''attribs'' -> ''card'' ->> ''scheme'' AS \\"Payee Card Scheme\\", observations -> ''payee'' -> ''attribs'' -> ''card'' ->> ''cardType'' AS \\"Payee Card Type\\", observations -> ''payee'' -> ''attribs'' -> ''card'' ->> ''product'' AS \\"Payee Card Product\\", observations -> ''payee'' -> ''attribs'' -> ''card'' ->> ''name'' AS \\"Payee Card Name\\", observations -> ''payee'' -> ''attribs'' -> ''account_detail'' ->> ''bankName'' AS \\"Payee Bank Name\\", observations -> ''payee'' -> ''attribs'' -> ''account_detail'' ->> ''accountType'' AS \\"Payee Account Type\\", observations -> ''payee'' -> ''attribs'' -> ''address'' ->> ''pinCode'' AS \\"Payee Address Pincode\\", observations -> ''payee'' -> ''attribs'' -> ''address'' ->> ''stateCode'' AS \\"Payee Address State Code\\", observations -> ''payee'' -> ''attribs'' -> ''address'' ->> ''countryCode'' AS \\"Payee Address Country COde\\", observations -> ''payee'' -> ''attribs'' -> ''address'' ->> ''city'' AS \\"Payee Address City\\", observations -> ''payee'' -> ''attribs'' -> ''address'' ->> ''line1'' AS \\"Payee Address Line1\\", observations -> ''payee'' -> ''attribs'' -> ''address'' ->> ''stateCode'' AS \\"Payee Address Line2\\", observations -> ''txn'' -> ''attribs'' -> ''device'' ->> ''geocode'' AS \\"Geocode\\", observations -> ''txn'' -> ''attribs'' -> ''device'' ->> ''location'' AS \\"Location\\", observations -> ''txn'' -> ''attribs'' -> ''device'' ->> ''ip'' AS \\"IP\\", observations -> ''txn'' -> ''attribs'' -> ''device'' ->> ''type'' AS \\"Device Type\\", observations -> ''txn'' -> ''attribs'' -> ''device'' ->> ''id'' AS \\"Device ID\\", observations -> ''txn'' -> ''attribs'' -> ''device'' ->> ''os'' AS \\"Device OS\\", observations -> ''txn'' -> ''attribs'' -> ''device'' ->> ''appName'' AS \\"Device App\\", observations -> ''txn'' -> ''attribs'' -> ''device'' ->> ''capability'' AS \\"Device Capability\\", observations -> ''observations'' ->> ''payer_card_d01_txn_count'' AS \\"payer_card_d01_txn_count\\", observations -> ''observations'' ->> ''payee_account_open_refund_d01_txn_value'' AS \\"payee_account_open_refund_d01_txn_value\\", observations -> ''observations'' ->> ''payee_account_open_d01_txn_value'' AS \\"payee_account_open_d01_txn_value\\", observations -> ''observations'' ->> ''payee_account_p1d_txn_value'' AS \\"payee_account_p1d_txn_value\\" FROM analytics.trans l where (l.vcpayeraccountexternalid = :VpaAddress or l.vcpayeeaccountexternalid=:VpaAddress ) and  dttrxntime  between :StartDate  and  :EndDate and itenantid = :tenantid   order by dttrxntime desc limit 50000"
    },
    "VPA": {
        "Payer": "SELECT observations -> ''txn'' ->> ''id'' AS \\"Txn id\\", observations -> ''txn'' -> ''attribs'' -> ''initator'' ->> ''customerId'' AS \\"Initiator User ID\\", observations -> ''txn'' -> ''attribs'' ->> ''captureMethod'' AS \\"Capture Method\\", observations -> ''txn'' -> ''attribs'' ->> ''mode'' AS \\"Mode\\", observations -> ''txn'' -> ''attribs'' -> ''method'' ->> ''type'' AS \\"Type\\", observations -> ''txn'' -> ''attribs'' -> ''method'' ->> ''subtype'' AS \\"Subtype\\", observations -> ''txn'' -> ''attribs'' ->> ''application'' AS \\"Application\\", observations -> ''txn'' -> ''attribs'' -> ''initatingEntity'' ->> ''entityId'' AS \\"Initiating entity ID\\", observations -> ''txn'' -> ''attribs'' ->> ''processingEntity'' AS  \\"processingEntity\\", observations -> ''txn'' -> ''attribs'' ->> ''invoice'' AS \\"Invoice\\", observations -> ''txn'' -> ''attribs'' ->> ''idempotentKey'' AS \\"Idempotent Key\\", CASE WHEN observations -> ''payer''  ->> ''amount'' = ''null'' THEN NULL ELSE CAST(NULLIF(observations -> ''payer''  ->> ''amount'', '''') AS float) END AS \\"Txn amount\\", CASE WHEN observations -> ''payer'' -> ''attribs'' ->> ''grossAmount'' = ''null'' THEN NULL ELSE CAST(NULLIF(observations -> ''payer'' -> ''attribs'' ->> ''grossAmount'', '''') AS float) END AS \\"Gross Amt\\", observations -> ''payer'' -> ''attribs'' ->> ''capturedAmount''  AS \\"Captured Amount\\", observations -> ''payer'' ->> ''type''  AS \\"Payer type\\", observations -> ''payer'' -> ''attribs'' -> ''identity'' ->> ''email'' AS \\"Payer email\\", observations -> ''payer'' ->> ''vpa''  AS \\"Payer addr\\", observations -> ''payer'' -> ''attribs'' ->> ''userID''  AS \\"Payer user ID\\", observations -> ''payee'' -> ''attribs'' ->> ''merchantID''  AS \\"Payee Merchant ID\\", observations -> ''payee'' -> ''attribs'' ->> ''terminalID''  AS \\"Payee Terminal ID\\", CASE WHEN observations -> ''payee'' ->> ''mcc'' = ''null'' THEN NULL ELSE CAST(NULLIF(observations -> ''payee'' ->> ''mcc'', '''') AS int) END AS \\"Payee MCC\\", observations -> ''payer'' ->> ''name''  AS \\"Payer name\\", observations -> ''payer'' -> ''attribs'' -> ''device'' ->> ''countryCode'' AS \\"Country Code\\", observations -> ''payer'' -> ''attribs'' -> ''device'' ->> ''mobilenum'' AS \\"Payer Mobile Number\\", observations -> ''payer'' -> ''attribs'' -> ''account_detail'' ->> ''accountType''  AS \\"Payer Account Type\\", observations -> ''payer'' -> ''attribs'' ->> ''cardType''  AS \\"Payer Card Type\\", observations -> ''payer'' -> ''attribs'' -> ''card'' ->> ''scheme'' AS \\"Payer Card Scheme\\", observations -> ''payer'' -> ''attribs'' -> ''card'' ->> ''cardType'' AS \\"Payer Card Type\\", observations -> ''payer'' -> ''attribs'' -> ''card'' ->> ''cardNumber'' AS \\"Payer Card Number\\", observations -> ''payer'' -> ''attribs'' -> ''card'' ->> ''cardName'' AS \\"Payer Card Name\\", observations -> ''payer'' -> ''attribs'' -> ''card'' ->> ''cardExpiryMM'' AS \\"Payer Card Expiry Month\\", observations -> ''payer'' -> ''attribs'' -> ''card'' ->> ''cardExpiryYY'' AS \\"Payer Card Expiry Year\\", observations -> ''payer'' -> ''attribs'' -> ''card'' ->> ''cvv'' AS \\"Payer Card cvv\\", observations -> ''payee'' ->> ''type''  AS \\"Payee Type\\", observations -> ''payee'' -> ''attribs'' ->> ''terminalID''  AS \\"Payee Terminal ID\\", observations -> ''payee'' -> ''attribs'' ->> ''merchantID''  AS \\"Payee Merchant ID\\", observations -> ''payee'' ->> ''mcc'' AS \\"Payee MCC\\", observations -> ''payee'' -> ''attribs'' -> ''identity'' ->>''name''  AS \\"Payee Name\\", observations -> ''payee'' -> ''attribs'' -> ''identity'' ->>''email''  AS \\"Payee Email\\", observations -> ''payee'' -> ''attribs'' -> ''identity'' -> ''mobile'' ->> ''countryCode''  AS \\"Country Code\\", observations -> ''payee'' -> ''attribs'' -> ''identity'' -> ''mobile'' ->> ''number''   AS \\"Payee Mobile Number\\", observations -> ''payee'' ->> ''vpa''  AS \\"Payee Addr\\", observations -> ''payee'' -> ''attribs'' -> ''card'' ->> ''cardNumber'' AS \\"Payee Card Number\\", observations -> ''payee'' -> ''attribs'' -> ''card'' ->> ''scheme'' AS \\"Payee Card Scheme\\", observations -> ''payee'' -> ''attribs'' -> ''card'' ->> ''cardType'' AS \\"Payee Card Type\\", observations -> ''payee'' -> ''attribs'' -> ''card'' ->> ''product'' AS \\"Payee Card Product\\", observations -> ''payee'' -> ''attribs'' -> ''card'' ->> ''name'' AS \\"Payee Card Name\\", observations -> ''payee'' -> ''attribs'' -> ''account_detail'' ->> ''bankName'' AS \\"Payee Bank Name\\", observations -> ''payee'' -> ''attribs'' -> ''account_detail'' ->> ''accountType'' AS \\"Payee Account Type\\", observations -> ''payee'' -> ''attribs'' -> ''address'' ->> ''pinCode'' AS \\"Payee Address Pincode\\", observations -> ''payee'' -> ''attribs'' -> ''address'' ->> ''stateCode'' AS \\"Payee Address State Code\\", observations -> ''payee'' -> ''attribs'' -> ''address'' ->> ''countryCode'' AS \\"Payee Address Country COde\\", observations -> ''payee'' -> ''attribs'' -> ''address'' ->> ''city'' AS \\"Payee Address City\\", observations -> ''payee'' -> ''attribs'' -> ''address'' ->> ''line1'' AS \\"Payee Address Line1\\", observations -> ''payee'' -> ''attribs'' -> ''address'' ->> ''stateCode'' AS \\"Payee Address Line2\\", observations -> ''txn'' -> ''attribs'' -> ''device'' ->> ''geocode'' AS \\"Geocode\\", observations -> ''txn'' -> ''attribs'' -> ''device'' ->> ''location'' AS \\"Location\\", observations -> ''txn'' -> ''attribs'' -> ''device'' ->> ''ip'' AS \\"IP\\", observations -> ''txn'' -> ''attribs'' -> ''device'' ->> ''type'' AS \\"Device Type\\", observations -> ''txn'' -> ''attribs'' -> ''device'' ->> ''id'' AS \\"Device ID\\", observations -> ''txn'' -> ''attribs'' -> ''device'' ->> ''os'' AS \\"Device OS\\", observations -> ''txn'' -> ''attribs'' -> ''device'' ->> ''appName'' AS \\"Device App\\", observations -> ''txn'' -> ''attribs'' -> ''device'' ->> ''capability'' AS \\"Device Capability\\", observations -> ''observations'' ->> ''payer_card_d01_txn_count'' AS \\"payer_card_d01_txn_count\\", observations -> ''observations'' ->> ''payee_account_open_refund_d01_txn_value'' AS \\"payee_account_open_refund_d01_txn_value\\", observations -> ''observations'' ->> ''payee_account_open_d01_txn_value'' AS \\"payee_account_open_d01_txn_value\\", observations -> ''observations'' ->> ''payee_account_p1d_txn_value'' AS \\"payee_account_p1d_txn_value\\" FROM analytics.trans l where l.vcpayeraddr = :VpaAddress  and  dttrxntime  between :StartDate and :EndDate and itenantid = :tenantid  order by dttrxntime desc limit 50000",
        "Payee": "SELECT observations -> ''txn'' ->> ''id'' AS \\"Txn id\\", observations -> ''txn'' -> ''attribs'' -> ''initator'' ->> ''customerId'' AS \\"Initiator User ID\\", observations -> ''txn'' -> ''attribs'' ->> ''captureMethod'' AS \\"Capture Method\\", observations -> ''txn'' -> ''attribs'' ->> ''mode'' AS \\"Mode\\", observations -> ''txn'' -> ''attribs'' -> ''method'' ->> ''type'' AS \\"Type\\", observations -> ''txn'' -> ''attribs'' -> ''method'' ->> ''subtype'' AS \\"Subtype\\", observations -> ''txn'' -> ''attribs'' ->> ''application'' AS \\"Application\\", observations -> ''txn'' -> ''attribs'' -> ''initatingEntity'' ->> ''entityId'' AS \\"Initiating entity ID\\", observations -> ''txn'' -> ''attribs'' ->> ''processingEntity'' AS  \\"processingEntity\\", observations -> ''txn'' -> ''attribs'' ->> ''invoice'' AS \\"Invoice\\", observations -> ''txn'' -> ''attribs'' ->> ''idempotentKey'' AS \\"Idempotent Key\\", CASE WHEN observations -> ''payer''  ->> ''amount'' = ''null'' THEN NULL ELSE CAST(NULLIF(observations -> ''payer''  ->> ''amount'', '''') AS float) END AS \\"Txn amount\\", CASE WHEN observations -> ''payer'' -> ''attribs'' ->> ''grossAmount'' = ''null'' THEN NULL ELSE CAST(NULLIF(observations -> ''payer'' -> ''attribs'' ->> ''grossAmount'', '''') AS float) END AS \\"Gross Amt\\", observations -> ''payer'' -> ''attribs'' ->> ''capturedAmount''  AS \\"Captured Amount\\", observations -> ''payer'' ->> ''type''  AS \\"Payer type\\", observations -> ''payer'' -> ''attribs'' -> ''identity'' ->> ''email'' AS \\"Payer email\\", observations -> ''payer'' ->> ''vpa''  AS \\"Payer addr\\", observations -> ''payer'' -> ''attribs'' ->> ''userID''  AS \\"Payer user ID\\", observations -> ''payee'' -> ''attribs'' ->> ''merchantID''  AS \\"Payee Merchant ID\\", observations -> ''payee'' -> ''attribs'' ->> ''terminalID''  AS \\"Payee Terminal ID\\", CASE WHEN observations -> ''payee'' ->> ''mcc'' = ''null'' THEN NULL ELSE CAST(NULLIF(observations -> ''payee'' ->> ''mcc'', '''') AS int) END AS \\"Payee MCC\\", observations -> ''payer'' ->> ''name''  AS \\"Payer name\\", observations -> ''payer'' -> ''attribs'' -> ''device'' ->> ''countryCode'' AS \\"Country Code\\", observations -> ''payer'' -> ''attribs'' -> ''device'' ->> ''mobilenum'' AS \\"Payer Mobile Number\\", observations -> ''payer'' -> ''attribs'' -> ''account_detail'' ->> ''accountType''  AS \\"Payer Account Type\\", observations -> ''payer'' -> ''attribs'' ->> ''cardType''  AS \\"Payer Card Type\\", observations -> ''payer'' -> ''attribs'' -> ''card'' ->> ''scheme'' AS \\"Payer Card Scheme\\", observations -> ''payer'' -> ''attribs'' -> ''card'' ->> ''cardType'' AS \\"Payer Card Type\\", observations -> ''payer'' -> ''attribs'' -> ''card'' ->> ''cardNumber'' AS \\"Payer Card Number\\", observations -> ''payer'' -> ''attribs'' -> ''card'' ->> ''cardName'' AS \\"Payer Card Name\\", observations -> ''payer'' -> ''attribs'' -> ''card'' ->> ''cardExpiryMM'' AS \\"Payer Card Expiry Month\\", observations -> ''payer'' -> ''attribs'' -> ''card'' ->> ''cardExpiryYY'' AS \\"Payer Card Expiry Year\\", observations -> ''payer'' -> ''attribs'' -> ''card'' ->> ''cvv'' AS \\"Payer Card cvv\\", observations -> ''payee'' ->> ''type''  AS \\"Payee Type\\", observations -> ''payee'' -> ''attribs'' ->> ''terminalID''  AS \\"Payee Terminal ID\\", observations -> ''payee'' -> ''attribs'' ->> ''merchantID''  AS \\"Payee Merchant ID\\", observations -> ''payee'' ->> ''mcc'' AS \\"Payee MCC\\", observations -> ''payee'' -> ''attribs'' -> ''identity'' ->>''name''  AS \\"Payee Name\\", observations -> ''payee'' -> ''attribs'' -> ''identity'' ->>''email''  AS \\"Payee Email\\", observations -> ''payee'' -> ''attribs'' -> ''identity'' -> ''mobile'' ->> ''countryCode''  AS \\"Country Code\\", observations -> ''payee'' -> ''attribs'' -> ''identity'' -> ''mobile'' ->> ''number''   AS \\"Payee Mobile Number\\", observations -> ''payee'' ->> ''vpa''  AS \\"Payee Addr\\", observations -> ''payee'' -> ''attribs'' -> ''card'' ->> ''cardNumber'' AS \\"Payee Card Number\\", observations -> ''payee'' -> ''attribs'' -> ''card'' ->> ''scheme'' AS \\"Payee Card Scheme\\", observations -> ''payee'' -> ''attribs'' -> ''card'' ->> ''cardType'' AS \\"Payee Card Type\\", observations -> ''payee'' -> ''attribs'' -> ''card'' ->> ''product'' AS \\"Payee Card Product\\", observations -> ''payee'' -> ''attribs'' -> ''card'' ->> ''name'' AS \\"Payee Card Name\\", observations -> ''payee'' -> ''attribs'' -> ''account_detail'' ->> ''bankName'' AS \\"Payee Bank Name\\", observations -> ''payee'' -> ''attribs'' -> ''account_detail'' ->> ''accountType'' AS \\"Payee Account Type\\", observations -> ''payee'' -> ''attribs'' -> ''address'' ->> ''pinCode'' AS \\"Payee Address Pincode\\", observations -> ''payee'' -> ''attribs'' -> ''address'' ->> ''stateCode'' AS \\"Payee Address State Code\\", observations -> ''payee'' -> ''attribs'' -> ''address'' ->> ''countryCode'' AS \\"Payee Address Country COde\\", observations -> ''payee'' -> ''attribs'' -> ''address'' ->> ''city'' AS \\"Payee Address City\\", observations -> ''payee'' -> ''attribs'' -> ''address'' ->> ''line1'' AS \\"Payee Address Line1\\", observations -> ''payee'' -> ''attribs'' -> ''address'' ->> ''stateCode'' AS \\"Payee Address Line2\\", observations -> ''txn'' -> ''attribs'' -> ''device'' ->> ''geocode'' AS \\"Geocode\\", observations -> ''txn'' -> ''attribs'' -> ''device'' ->> ''location'' AS \\"Location\\", observations -> ''txn'' -> ''attribs'' -> ''device'' ->> ''ip'' AS \\"IP\\", observations -> ''txn'' -> ''attribs'' -> ''device'' ->> ''type'' AS \\"Device Type\\", observations -> ''txn'' -> ''attribs'' -> ''device'' ->> ''id'' AS \\"Device ID\\", observations -> ''txn'' -> ''attribs'' -> ''device'' ->> ''os'' AS \\"Device OS\\", observations -> ''txn'' -> ''attribs'' -> ''device'' ->> ''appName'' AS \\"Device App\\", observations -> ''txn'' -> ''attribs'' -> ''device'' ->> ''capability'' AS \\"Device Capability\\", observations -> ''observations'' ->> ''payer_card_d01_txn_count'' AS \\"payer_card_d01_txn_count\\", observations -> ''observations'' ->> ''payee_account_open_refund_d01_txn_value'' AS \\"payee_account_open_refund_d01_txn_value\\", observations -> ''observations'' ->> ''payee_account_open_d01_txn_value'' AS \\"payee_account_open_d01_txn_value\\", observations -> ''observations'' ->> ''payee_account_p1d_txn_value'' AS \\"payee_account_p1d_txn_value\\" FROM analytics.trans l where l.vcpayeeaddr = :VpaAddress  and dttrxntime between :StartDate  and :EndDate and itenantid = :tenantid  order by dttrxntime desc limit 50000",
        "Both": "SELECT observations -> ''txn'' ->> ''id'' AS \\"Txn id\\", observations -> ''txn'' -> ''attribs'' -> ''initator'' ->> ''customerId'' AS \\"Initiator User ID\\", observations -> ''txn'' -> ''attribs'' ->> ''captureMethod'' AS \\"Capture Method\\", observations -> ''txn'' -> ''attribs'' ->> ''mode'' AS \\"Mode\\", observations -> ''txn'' -> ''attribs'' -> ''method'' ->> ''type'' AS \\"Type\\", observations -> ''txn'' -> ''attribs'' -> ''method'' ->> ''subtype'' AS \\"Subtype\\", observations -> ''txn'' -> ''attribs'' ->> ''application'' AS \\"Application\\", observations -> ''txn'' -> ''attribs'' -> ''initatingEntity'' ->> ''entityId'' AS \\"Initiating entity ID\\", observations -> ''txn'' -> ''attribs'' ->> ''processingEntity'' AS  \\"processingEntity\\", observations -> ''txn'' -> ''attribs'' ->> ''invoice'' AS \\"Invoice\\", observations -> ''txn'' -> ''attribs'' ->> ''idempotentKey'' AS \\"Idempotent Key\\", CASE WHEN observations -> ''payer''  ->> ''amount'' = ''null'' THEN NULL ELSE CAST(NULLIF(observations -> ''payer''  ->> ''amount'', '''') AS float) END AS \\"Txn amount\\", CASE WHEN observations -> ''payer'' -> ''attribs'' ->> ''grossAmount'' = ''null'' THEN NULL ELSE CAST(NULLIF(observations -> ''payer'' -> ''attribs'' ->> ''grossAmount'', '''') AS float) END AS \\"Gross Amt\\", observations -> ''payer'' -> ''attribs'' ->> ''capturedAmount''  AS \\"Captured Amount\\", observations -> ''payer'' ->> ''type''  AS \\"Payer type\\", observations -> ''payer'' -> ''attribs'' -> ''identity'' ->> ''email'' AS \\"Payer email\\", observations -> ''payer'' ->> ''vpa''  AS \\"Payer addr\\", observations -> ''payer'' -> ''attribs'' ->> ''userID''  AS \\"Payer user ID\\", observations -> ''payee'' -> ''attribs'' ->> ''merchantID''  AS \\"Payee Merchant ID\\", observations -> ''payee'' -> ''attribs'' ->> ''terminalID''  AS \\"Payee Terminal ID\\", CASE WHEN observations -> ''payee'' ->> ''mcc'' = ''null'' THEN NULL ELSE CAST(NULLIF(observations -> ''payee'' ->> ''mcc'', '''') AS int) END AS \\"Payee MCC\\", observations -> ''payer'' ->> ''name''  AS \\"Payer name\\", observations -> ''payer'' -> ''attribs'' -> ''device'' ->> ''countryCode'' AS \\"Country Code\\", observations -> ''payer'' -> ''attribs'' -> ''device'' ->> ''mobilenum'' AS \\"Payer Mobile Number\\", observations -> ''payer'' -> ''attribs'' -> ''account_detail'' ->> ''accountType''  AS \\"Payer Account Type\\", observations -> ''payer'' -> ''attribs'' ->> ''cardType''  AS \\"Payer Card Type\\", observations -> ''payer'' -> ''attribs'' -> ''card'' ->> ''scheme'' AS \\"Payer Card Scheme\\", observations -> ''payer'' -> ''attribs'' -> ''card'' ->> ''cardType'' AS \\"Payer Card Type\\", observations -> ''payer'' -> ''attribs'' -> ''card'' ->> ''cardNumber'' AS \\"Payer Card Number\\", observations -> ''payer'' -> ''attribs'' -> ''card'' ->> ''cardName'' AS \\"Payer Card Name\\", observations -> ''payer'' -> ''attribs'' -> ''card'' ->> ''cardExpiryMM'' AS \\"Payer Card Expiry Month\\", observations -> ''payer'' -> ''attribs'' -> ''card'' ->> ''cardExpiryYY'' AS \\"Payer Card Expiry Year\\", observations -> ''payer'' -> ''attribs'' -> ''card'' ->> ''cvv'' AS \\"Payer Card cvv\\", observations -> ''payee'' ->> ''type''  AS \\"Payee Type\\", observations -> ''payee'' -> ''attribs'' ->> ''terminalID''  AS \\"Payee Terminal ID\\", observations -> ''payee'' -> ''attribs'' ->> ''merchantID''  AS \\"Payee Merchant ID\\", observations -> ''payee'' ->> ''mcc'' AS \\"Payee MCC\\", observations -> ''payee'' -> ''attribs'' -> ''identity'' ->>''name''  AS \\"Payee Name\\", observations -> ''payee'' -> ''attribs'' -> ''identity'' ->>''email''  AS \\"Payee Email\\", observations -> ''payee'' -> ''attribs'' -> ''identity'' -> ''mobile'' ->> ''countryCode''  AS \\"Country Code\\", observations -> ''payee'' -> ''attribs'' -> ''identity'' -> ''mobile'' ->> ''number''   AS \\"Payee Mobile Number\\", observations -> ''payee'' ->> ''vpa''  AS \\"Payee Addr\\", observations -> ''payee'' -> ''attribs'' -> ''card'' ->> ''cardNumber'' AS \\"Payee Card Number\\", observations -> ''payee'' -> ''attribs'' -> ''card'' ->> ''scheme'' AS \\"Payee Card Scheme\\", observations -> ''payee'' -> ''attribs'' -> ''card'' ->> ''cardType'' AS \\"Payee Card Type\\", observations -> ''payee'' -> ''attribs'' -> ''card'' ->> ''product'' AS \\"Payee Card Product\\", observations -> ''payee'' -> ''attribs'' -> ''card'' ->> ''name'' AS \\"Payee Card Name\\", observations -> ''payee'' -> ''attribs'' -> ''account_detail'' ->> ''bankName'' AS \\"Payee Bank Name\\", observations -> ''payee'' -> ''attribs'' -> ''account_detail'' ->> ''accountType'' AS \\"Payee Account Type\\", observations -> ''payee'' -> ''attribs'' -> ''address'' ->> ''pinCode'' AS \\"Payee Address Pincode\\", observations -> ''payee'' -> ''attribs'' -> ''address'' ->> ''stateCode'' AS \\"Payee Address State Code\\", observations -> ''payee'' -> ''attribs'' -> ''address'' ->> ''countryCode'' AS \\"Payee Address Country COde\\", observations -> ''payee'' -> ''attribs'' -> ''address'' ->> ''city'' AS \\"Payee Address City\\", observations -> ''payee'' -> ''attribs'' -> ''address'' ->> ''line1'' AS \\"Payee Address Line1\\", observations -> ''payee'' -> ''attribs'' -> ''address'' ->> ''stateCode'' AS \\"Payee Address Line2\\", observations -> ''txn'' -> ''attribs'' -> ''device'' ->> ''geocode'' AS \\"Geocode\\", observations -> ''txn'' -> ''attribs'' -> ''device'' ->> ''location'' AS \\"Location\\", observations -> ''txn'' -> ''attribs'' -> ''device'' ->> ''ip'' AS \\"IP\\", observations -> ''txn'' -> ''attribs'' -> ''device'' ->> ''type'' AS \\"Device Type\\", observations -> ''txn'' -> ''attribs'' -> ''device'' ->> ''id'' AS \\"Device ID\\", observations -> ''txn'' -> ''attribs'' -> ''device'' ->> ''os'' AS \\"Device OS\\", observations -> ''txn'' -> ''attribs'' -> ''device'' ->> ''appName'' AS \\"Device App\\", observations -> ''txn'' -> ''attribs'' -> ''device'' ->> ''capability'' AS \\"Device Capability\\", observations -> ''observations'' ->> ''payer_card_d01_txn_count'' AS \\"payer_card_d01_txn_count\\", observations -> ''observations'' ->> ''payee_account_open_refund_d01_txn_value'' AS \\"payee_account_open_refund_d01_txn_value\\", observations -> ''observations'' ->> ''payee_account_open_d01_txn_value'' AS \\"payee_account_open_d01_txn_value\\", observations -> ''observations'' ->> ''payee_account_p1d_txn_value'' AS \\"payee_account_p1d_txn_value\\" FROM analytics.trans l where (l.vcpayeeaddr = :VpaAddress or l.vcpayeraddr = :VpaAddress) and  dttrxntime between :StartDate  and :EndDate and itenantid = :tenantid  order by dttrxntime desc limit 50000 "
    },
    "Txn": {
        "Txn ID": "SELECT observations -> ''txn'' ->> ''id'' AS \\"Txn id\\", observations -> ''txn'' -> ''attribs'' -> ''initator'' ->> ''customerId'' AS \\"Initiator User ID\\", observations -> ''txn'' -> ''attribs'' ->> ''captureMethod'' AS \\"Capture Method\\", observations -> ''txn'' -> ''attribs'' ->> ''mode'' AS \\"Mode\\", observations -> ''txn'' -> ''attribs'' -> ''method'' ->> ''type'' AS \\"Type\\", observations -> ''txn'' -> ''attribs'' -> ''method'' ->> ''subtype'' AS \\"Subtype\\", observations -> ''txn'' -> ''attribs'' ->> ''application'' AS \\"Application\\", observations -> ''txn'' -> ''attribs'' -> ''initatingEntity'' ->> ''entityId'' AS \\"Initiating entity ID\\", observations -> ''txn'' -> ''attribs'' ->> ''processingEntity'' AS  \\"processingEntity\\", observations -> ''txn'' -> ''attribs'' ->> ''invoice'' AS \\"Invoice\\", observations -> ''txn'' -> ''attribs'' ->> ''idempotentKey'' AS \\"Idempotent Key\\", CASE WHEN observations -> ''payer''  ->> ''amount'' = ''null'' THEN NULL ELSE CAST(NULLIF(observations -> ''payer''  ->> ''amount'', '''') AS float) END AS \\"Txn amount\\", CASE WHEN observations -> ''payer'' -> ''attribs'' ->> ''grossAmount'' = ''null'' THEN NULL ELSE CAST(NULLIF(observations -> ''payer'' -> ''attribs'' ->> ''grossAmount'', '''') AS float) END AS \\"Gross Amt\\", observations -> ''payer'' -> ''attribs'' ->> ''capturedAmount''  AS \\"Captured Amount\\", observations -> ''payer'' ->> ''type''  AS \\"Payer type\\", observations -> ''payer'' -> ''attribs'' -> ''identity'' ->> ''email'' AS \\"Payer email\\", observations -> ''payer'' ->> ''vpa''  AS \\"Payer addr\\", observations -> ''payer'' -> ''attribs'' ->> ''userID''  AS \\"Payer user ID\\", observations -> ''payee'' -> ''attribs'' ->> ''merchantID''  AS \\"Payee Merchant ID\\", observations -> ''payee'' -> ''attribs'' ->> ''terminalID''  AS \\"Payee Terminal ID\\", CASE WHEN observations -> ''payee'' ->> ''mcc'' = ''null'' THEN NULL ELSE CAST(NULLIF(observations -> ''payee'' ->> ''mcc'', '''') AS int) END AS \\"Payee MCC\\", observations -> ''payer'' ->> ''name''  AS \\"Payer name\\", observations -> ''payer'' -> ''attribs'' -> ''device'' ->> ''countryCode'' AS \\"Country Code\\", observations -> ''payer'' -> ''attribs'' -> ''device'' ->> ''mobilenum'' AS \\"Payer Mobile Number\\", observations -> ''payer'' -> ''attribs'' -> ''account_detail'' ->> ''accountType''  AS \\"Payer Account Type\\", observations -> ''payer'' -> ''attribs'' ->> ''cardType''  AS \\"Payer Card Type\\", observations -> ''payer'' -> ''attribs'' -> ''card'' ->> ''scheme'' AS \\"Payer Card Scheme\\", observations -> ''payer'' -> ''attribs'' -> ''card'' ->> ''cardType'' AS \\"Payer Card Type\\", observations -> ''payer'' -> ''attribs'' -> ''card'' ->> ''cardNumber'' AS \\"Payer Card Number\\", observations -> ''payer'' -> ''attribs'' -> ''card'' ->> ''cardName'' AS \\"Payer Card Name\\", observations -> ''payer'' -> ''attribs'' -> ''card'' ->> ''cardExpiryMM'' AS \\"Payer Card Expiry Month\\", observations -> ''payer'' -> ''attribs'' -> ''card'' ->> ''cardExpiryYY'' AS \\"Payer Card Expiry Year\\", observations -> ''payer'' -> ''attribs'' -> ''card'' ->> ''cvv'' AS \\"Payer Card cvv\\", observations -> ''payee'' ->> ''type''  AS \\"Payee Type\\", observations -> ''payee'' -> ''attribs'' ->> ''terminalID''  AS \\"Payee Terminal ID\\", observations -> ''payee'' -> ''attribs'' ->> ''merchantID''  AS \\"Payee Merchant ID\\", observations -> ''payee'' ->> ''mcc'' AS \\"Payee MCC\\", observations -> ''payee'' -> ''attribs'' -> ''identity'' ->>''name''  AS \\"Payee Name\\", observations -> ''payee'' -> ''attribs'' -> ''identity'' ->>''email''  AS \\"Payee Email\\", observations -> ''payee'' -> ''attribs'' -> ''identity'' -> ''mobile'' ->> ''countryCode''  AS \\"Country Code\\", observations -> ''payee'' -> ''attribs'' -> ''identity'' -> ''mobile'' ->> ''number''   AS \\"Payee Mobile Number\\", observations -> ''payee'' ->> ''vpa''  AS \\"Payee Addr\\", observations -> ''payee'' -> ''attribs'' -> ''card'' ->> ''cardNumber'' AS \\"Payee Card Number\\", observations -> ''payee'' -> ''attribs'' -> ''card'' ->> ''scheme'' AS \\"Payee Card Scheme\\", observations -> ''payee'' -> ''attribs'' -> ''card'' ->> ''cardType'' AS \\"Payee Card Type\\", observations -> ''payee'' -> ''attribs'' -> ''card'' ->> ''product'' AS \\"Payee Card Product\\", observations -> ''payee'' -> ''attribs'' -> ''card'' ->> ''name'' AS \\"Payee Card Name\\", observations -> ''payee'' -> ''attribs'' -> ''account_detail'' ->> ''bankName'' AS \\"Payee Bank Name\\", observations -> ''payee'' -> ''attribs'' -> ''account_detail'' ->> ''accountType'' AS \\"Payee Account Type\\", observations -> ''payee'' -> ''attribs'' -> ''address'' ->> ''pinCode'' AS \\"Payee Address Pincode\\", observations -> ''payee'' -> ''attribs'' -> ''address'' ->> ''stateCode'' AS \\"Payee Address State Code\\", observations -> ''payee'' -> ''attribs'' -> ''address'' ->> ''countryCode'' AS \\"Payee Address Country COde\\", observations -> ''payee'' -> ''attribs'' -> ''address'' ->> ''city'' AS \\"Payee Address City\\", observations -> ''payee'' -> ''attribs'' -> ''address'' ->> ''line1'' AS \\"Payee Address Line1\\", observations -> ''payee'' -> ''attribs'' -> ''address'' ->> ''stateCode'' AS \\"Payee Address Line2\\", observations -> ''txn'' -> ''attribs'' -> ''device'' ->> ''geocode'' AS \\"Geocode\\", observations -> ''txn'' -> ''attribs'' -> ''device'' ->> ''location'' AS \\"Location\\", observations -> ''txn'' -> ''attribs'' -> ''device'' ->> ''ip'' AS \\"IP\\", observations -> ''txn'' -> ''attribs'' -> ''device'' ->> ''type'' AS \\"Device Type\\", observations -> ''txn'' -> ''attribs'' -> ''device'' ->> ''id'' AS \\"Device ID\\", observations -> ''txn'' -> ''attribs'' -> ''device'' ->> ''os'' AS \\"Device OS\\", observations -> ''txn'' -> ''attribs'' -> ''device'' ->> ''appName'' AS \\"Device App\\", observations -> ''txn'' -> ''attribs'' -> ''device'' ->> ''capability'' AS \\"Device Capability\\", observations -> ''observations'' ->> ''payer_card_d01_txn_count'' AS \\"payer_card_d01_txn_count\\", observations -> ''observations'' ->> ''payee_account_open_refund_d01_txn_value'' AS \\"payee_account_open_refund_d01_txn_value\\", observations -> ''observations'' ->> ''payee_account_open_d01_txn_value'' AS \\"payee_account_open_d01_txn_value\\", observations -> ''observations'' ->> ''payee_account_p1d_txn_value'' AS \\"payee_account_p1d_txn_value\\" FROM analytics.trans l where l.vcuniquetransid = :VpaAddress  and  dttrxntime  between :StartDate and :EndDate and itenantid = :tenantid  order by dttrxntime desc limit 50000",
        "RRN": "SELECT observations -> ''txn'' ->> ''id'' AS \\"Txn id\\", observations -> ''txn'' -> ''attribs'' -> ''initator'' ->> ''customerId'' AS \\"Initiator User ID\\", observations -> ''txn'' -> ''attribs'' ->> ''captureMethod'' AS \\"Capture Method\\", observations -> ''txn'' -> ''attribs'' ->> ''mode'' AS \\"Mode\\", observations -> ''txn'' -> ''attribs'' -> ''method'' ->> ''type'' AS \\"Type\\", observations -> ''txn'' -> ''attribs'' -> ''method'' ->> ''subtype'' AS \\"Subtype\\", observations -> ''txn'' -> ''attribs'' ->> ''application'' AS \\"Application\\", observations -> ''txn'' -> ''attribs'' -> ''initatingEntity'' ->> ''entityId'' AS \\"Initiating entity ID\\", observations -> ''txn'' -> ''attribs'' ->> ''processingEntity'' AS  \\"processingEntity\\", observations -> ''txn'' -> ''attribs'' ->> ''invoice'' AS \\"Invoice\\", observations -> ''txn'' -> ''attribs'' ->> ''idempotentKey'' AS \\"Idempotent Key\\", CASE WHEN observations -> ''payer''  ->> ''amount'' = ''null'' THEN NULL ELSE CAST(NULLIF(observations -> ''payer''  ->> ''amount'', '''') AS float) END AS \\"Txn amount\\", CASE WHEN observations -> ''payer'' -> ''attribs'' ->> ''grossAmount'' = ''null'' THEN NULL ELSE CAST(NULLIF(observations -> ''payer'' -> ''attribs'' ->> ''grossAmount'', '''') AS float) END AS \\"Gross Amt\\", observations -> ''payer'' -> ''attribs'' ->> ''capturedAmount''  AS \\"Captured Amount\\", observations -> ''payer'' ->> ''type''  AS \\"Payer type\\", observations -> ''payer'' -> ''attribs'' -> ''identity'' ->> ''email'' AS \\"Payer email\\", observations -> ''payer'' ->> ''vpa''  AS \\"Payer addr\\", observations -> ''payer'' -> ''attribs'' ->> ''userID''  AS \\"Payer user ID\\", observations -> ''payee'' -> ''attribs'' ->> ''merchantID''  AS \\"Payee Merchant ID\\", observations -> ''payee'' -> ''attribs'' ->> ''terminalID''  AS \\"Payee Terminal ID\\", CASE WHEN observations -> ''payee'' ->> ''mcc'' = ''null'' THEN NULL ELSE CAST(NULLIF(observations -> ''payee'' ->> ''mcc'', '''') AS int) END AS \\"Payee MCC\\", observations -> ''payer'' ->> ''name''  AS \\"Payer name\\", observations -> ''payer'' -> ''attribs'' -> ''device'' ->> ''countryCode'' AS \\"Country Code\\", observations -> ''payer'' -> ''attribs'' -> ''device'' ->> ''mobilenum'' AS \\"Payer Mobile Number\\", observations -> ''payer'' -> ''attribs'' -> ''account_detail'' ->> ''accountType''  AS \\"Payer Account Type\\", observations -> ''payer'' -> ''attribs'' ->> ''cardType''  AS \\"Payer Card Type\\", observations -> ''payer'' -> ''attribs'' -> ''card'' ->> ''scheme'' AS \\"Payer Card Scheme\\", observations -> ''payer'' -> ''attribs'' -> ''card'' ->> ''cardType'' AS \\"Payer Card Type\\", observations -> ''payer'' -> ''attribs'' -> ''card'' ->> ''cardNumber'' AS \\"Payer Card Number\\", observations -> ''payer'' -> ''attribs'' -> ''card'' ->> ''cardName'' AS \\"Payer Card Name\\", observations -> ''payer'' -> ''attribs'' -> ''card'' ->> ''cardExpiryMM'' AS \\"Payer Card Expiry Month\\", observations -> ''payer'' -> ''attribs'' -> ''card'' ->> ''cardExpiryYY'' AS \\"Payer Card Expiry Year\\", observations -> ''payer'' -> ''attribs'' -> ''card'' ->> ''cvv'' AS \\"Payer Card cvv\\", observations -> ''payee'' ->> ''type''  AS \\"Payee Type\\", observations -> ''payee'' -> ''attribs'' ->> ''terminalID''  AS \\"Payee Terminal ID\\", observations -> ''payee'' -> ''attribs'' ->> ''merchantID''  AS \\"Payee Merchant ID\\", observations -> ''payee'' ->> ''mcc'' AS \\"Payee MCC\\", observations -> ''payee'' -> ''attribs'' -> ''identity'' ->>''name''  AS \\"Payee Name\\", observations -> ''payee'' -> ''attribs'' -> ''identity'' ->>''email''  AS \\"Payee Email\\", observations -> ''payee'' -> ''attribs'' -> ''identity'' -> ''mobile'' ->> ''countryCode''  AS \\"Country Code\\", observations -> ''payee'' -> ''attribs'' -> ''identity'' -> ''mobile'' ->> ''number''   AS \\"Payee Mobile Number\\", observations -> ''payee'' ->> ''vpa''  AS \\"Payee Addr\\", observations -> ''payee'' -> ''attribs'' -> ''card'' ->> ''cardNumber'' AS \\"Payee Card Number\\", observations -> ''payee'' -> ''attribs'' -> ''card'' ->> ''scheme'' AS \\"Payee Card Scheme\\", observations -> ''payee'' -> ''attribs'' -> ''card'' ->> ''cardType'' AS \\"Payee Card Type\\", observations -> ''payee'' -> ''attribs'' -> ''card'' ->> ''product'' AS \\"Payee Card Product\\", observations -> ''payee'' -> ''attribs'' -> ''card'' ->> ''name'' AS \\"Payee Card Name\\", observations -> ''payee'' -> ''attribs'' -> ''account_detail'' ->> ''bankName'' AS \\"Payee Bank Name\\", observations -> ''payee'' -> ''attribs'' -> ''account_detail'' ->> ''accountType'' AS \\"Payee Account Type\\", observations -> ''payee'' -> ''attribs'' -> ''address'' ->> ''pinCode'' AS \\"Payee Address Pincode\\", observations -> ''payee'' -> ''attribs'' -> ''address'' ->> ''stateCode'' AS \\"Payee Address State Code\\", observations -> ''payee'' -> ''attribs'' -> ''address'' ->> ''countryCode'' AS \\"Payee Address Country COde\\", observations -> ''payee'' -> ''attribs'' -> ''address'' ->> ''city'' AS \\"Payee Address City\\", observations -> ''payee'' -> ''attribs'' -> ''address'' ->> ''line1'' AS \\"Payee Address Line1\\", observations -> ''payee'' -> ''attribs'' -> ''address'' ->> ''stateCode'' AS \\"Payee Address Line2\\", observations -> ''txn'' -> ''attribs'' -> ''device'' ->> ''geocode'' AS \\"Geocode\\", observations -> ''txn'' -> ''attribs'' -> ''device'' ->> ''location'' AS \\"Location\\", observations -> ''txn'' -> ''attribs'' -> ''device'' ->> ''ip'' AS \\"IP\\", observations -> ''txn'' -> ''attribs'' -> ''device'' ->> ''type'' AS \\"Device Type\\", observations -> ''txn'' -> ''attribs'' -> ''device'' ->> ''id'' AS \\"Device ID\\", observations -> ''txn'' -> ''attribs'' -> ''device'' ->> ''os'' AS \\"Device OS\\", observations -> ''txn'' -> ''attribs'' -> ''device'' ->> ''appName'' AS \\"Device App\\", observations -> ''txn'' -> ''attribs'' -> ''device'' ->> ''capability'' AS \\"Device Capability\\", observations -> ''observations'' ->> ''payer_card_d01_txn_count'' AS \\"payer_card_d01_txn_count\\", observations -> ''observations'' ->> ''payee_account_open_refund_d01_txn_value'' AS \\"payee_account_open_refund_d01_txn_value\\", observations -> ''observations'' ->> ''payee_account_open_d01_txn_value'' AS \\"payee_account_open_d01_txn_value\\", observations -> ''observations'' ->> ''payee_account_p1d_txn_value'' AS \\"payee_account_p1d_txn_value\\" FROM analytics.trans l where l.vctxnfield1 = :VpaAddress  and dttrxntime between :StartDate  and :EndDate and itenantid = :tenantid  order by dttrxntime desc limit 50000",
        "Auth Code": "SELECT observations -> ''txn'' ->> ''id'' AS \\"Txn id\\", observations -> ''txn'' -> ''attribs'' -> ''initator'' ->> ''customerId'' AS \\"Initiator User ID\\", observations -> ''txn'' -> ''attribs'' ->> ''captureMethod'' AS \\"Capture Method\\", observations -> ''txn'' -> ''attribs'' ->> ''mode'' AS \\"Mode\\", observations -> ''txn'' -> ''attribs'' -> ''method'' ->> ''type'' AS \\"Type\\", observations -> ''txn'' -> ''attribs'' -> ''method'' ->> ''subtype'' AS \\"Subtype\\", observations -> ''txn'' -> ''attribs'' ->> ''application'' AS \\"Application\\", observations -> ''txn'' -> ''attribs'' -> ''initatingEntity'' ->> ''entityId'' AS \\"Initiating entity ID\\", observations -> ''txn'' -> ''attribs'' ->> ''processingEntity'' AS  \\"processingEntity\\", observations -> ''txn'' -> ''attribs'' ->> ''invoice'' AS \\"Invoice\\", observations -> ''txn'' -> ''attribs'' ->> ''idempotentKey'' AS \\"Idempotent Key\\", CASE WHEN observations -> ''payer''  ->> ''amount'' = ''null'' THEN NULL ELSE CAST(NULLIF(observations -> ''payer''  ->> ''amount'', '''') AS float) END AS \\"Txn amount\\", CASE WHEN observations -> ''payer'' -> ''attribs'' ->> ''grossAmount'' = ''null'' THEN NULL ELSE CAST(NULLIF(observations -> ''payer'' -> ''attribs'' ->> ''grossAmount'', '''') AS float) END AS \\"Gross Amt\\", observations -> ''payer'' -> ''attribs'' ->> ''capturedAmount''  AS \\"Captured Amount\\", observations -> ''payer'' ->> ''type''  AS \\"Payer type\\", observations -> ''payer'' -> ''attribs'' -> ''identity'' ->> ''email'' AS \\"Payer email\\", observations -> ''payer'' ->> ''vpa''  AS \\"Payer addr\\", observations -> ''payer'' -> ''attribs'' ->> ''userID''  AS \\"Payer user ID\\", observations -> ''payee'' -> ''attribs'' ->> ''merchantID''  AS \\"Payee Merchant ID\\", observations -> ''payee'' -> ''attribs'' ->> ''terminalID''  AS \\"Payee Terminal ID\\", CASE WHEN observations -> ''payee'' ->> ''mcc'' = ''null'' THEN NULL ELSE CAST(NULLIF(observations -> ''payee'' ->> ''mcc'', '''') AS int) END AS \\"Payee MCC\\", observations -> ''payer'' ->> ''name''  AS \\"Payer name\\", observations -> ''payer'' -> ''attribs'' -> ''device'' ->> ''countryCode'' AS \\"Country Code\\", observations -> ''payer'' -> ''attribs'' -> ''device'' ->> ''mobilenum'' AS \\"Payer Mobile Number\\", observations -> ''payer'' -> ''attribs'' -> ''account_detail'' ->> ''accountType''  AS \\"Payer Account Type\\", observations -> ''payer'' -> ''attribs'' ->> ''cardType''  AS \\"Payer Card Type\\", observations -> ''payer'' -> ''attribs'' -> ''card'' ->> ''scheme'' AS \\"Payer Card Scheme\\", observations -> ''payer'' -> ''attribs'' -> ''card'' ->> ''cardType'' AS \\"Payer Card Type\\", observations -> ''payer'' -> ''attribs'' -> ''card'' ->> ''cardNumber'' AS \\"Payer Card Number\\", observations -> ''payer'' -> ''attribs'' -> ''card'' ->> ''cardName'' AS \\"Payer Card Name\\", observations -> ''payer'' -> ''attribs'' -> ''card'' ->> ''cardExpiryMM'' AS \\"Payer Card Expiry Month\\", observations -> ''payer'' -> ''attribs'' -> ''card'' ->> ''cardExpiryYY'' AS \\"Payer Card Expiry Year\\", observations -> ''payer'' -> ''attribs'' -> ''card'' ->> ''cvv'' AS \\"Payer Card cvv\\", observations -> ''payee'' ->> ''type''  AS \\"Payee Type\\", observations -> ''payee'' -> ''attribs'' ->> ''terminalID''  AS \\"Payee Terminal ID\\", observations -> ''payee'' -> ''attribs'' ->> ''merchantID''  AS \\"Payee Merchant ID\\", observations -> ''payee'' ->> ''mcc'' AS \\"Payee MCC\\", observations -> ''payee'' -> ''attribs'' -> ''identity'' ->>''name''  AS \\"Payee Name\\", observations -> ''payee'' -> ''attribs'' -> ''identity'' ->>''email''  AS \\"Payee Email\\", observations -> ''payee'' -> ''attribs'' -> ''identity'' -> ''mobile'' ->> ''countryCode''  AS \\"Country Code\\", observations -> ''payee'' -> ''attribs'' -> ''identity'' -> ''mobile'' ->> ''number''   AS \\"Payee Mobile Number\\", observations -> ''payee'' ->> ''vpa''  AS \\"Payee Addr\\", observations -> ''payee'' -> ''attribs'' -> ''card'' ->> ''cardNumber'' AS \\"Payee Card Number\\", observations -> ''payee'' -> ''attribs'' -> ''card'' ->> ''scheme'' AS \\"Payee Card Scheme\\", observations -> ''payee'' -> ''attribs'' -> ''card'' ->> ''cardType'' AS \\"Payee Card Type\\", observations -> ''payee'' -> ''attribs'' -> ''card'' ->> ''product'' AS \\"Payee Card Product\\", observations -> ''payee'' -> ''attribs'' -> ''card'' ->> ''name'' AS \\"Payee Card Name\\", observations -> ''payee'' -> ''attribs'' -> ''account_detail'' ->> ''bankName'' AS \\"Payee Bank Name\\", observations -> ''payee'' -> ''attribs'' -> ''account_detail'' ->> ''accountType'' AS \\"Payee Account Type\\", observations -> ''payee'' -> ''attribs'' -> ''address'' ->> ''pinCode'' AS \\"Payee Address Pincode\\", observations -> ''payee'' -> ''attribs'' -> ''address'' ->> ''stateCode'' AS \\"Payee Address State Code\\", observations -> ''payee'' -> ''attribs'' -> ''address'' ->> ''countryCode'' AS \\"Payee Address Country COde\\", observations -> ''payee'' -> ''attribs'' -> ''address'' ->> ''city'' AS \\"Payee Address City\\", observations -> ''payee'' -> ''attribs'' -> ''address'' ->> ''line1'' AS \\"Payee Address Line1\\", observations -> ''payee'' -> ''attribs'' -> ''address'' ->> ''stateCode'' AS \\"Payee Address Line2\\", observations -> ''txn'' -> ''attribs'' -> ''device'' ->> ''geocode'' AS \\"Geocode\\", observations -> ''txn'' -> ''attribs'' -> ''device'' ->> ''location'' AS \\"Location\\", observations -> ''txn'' -> ''attribs'' -> ''device'' ->> ''ip'' AS \\"IP\\", observations -> ''txn'' -> ''attribs'' -> ''device'' ->> ''type'' AS \\"Device Type\\", observations -> ''txn'' -> ''attribs'' -> ''device'' ->> ''id'' AS \\"Device ID\\", observations -> ''txn'' -> ''attribs'' -> ''device'' ->> ''os'' AS \\"Device OS\\", observations -> ''txn'' -> ''attribs'' -> ''device'' ->> ''appName'' AS \\"Device App\\", observations -> ''txn'' -> ''attribs'' -> ''device'' ->> ''capability'' AS \\"Device Capability\\", observations -> ''observations'' ->> ''payer_card_d01_txn_count'' AS \\"payer_card_d01_txn_count\\", observations -> ''observations'' ->> ''payee_account_open_refund_d01_txn_value'' AS \\"payee_account_open_refund_d01_txn_value\\", observations -> ''observations'' ->> ''payee_account_open_d01_txn_value'' AS \\"payee_account_open_d01_txn_value\\", observations -> ''observations'' ->> ''payee_account_p1d_txn_value'' AS \\"payee_account_p1d_txn_value\\" FROM analytics.trans l where l.vctxnfield2 = :VpaAddress and  dttrxntime between :StartDate  and :EndDate and itenantid = :tenantid  order by dttrxntime desc limit 50000 ",
        "Invoice": "SELECT observations -> ''txn'' ->> ''id'' AS \\"Txn id\\", observations -> ''txn'' -> ''attribs'' -> ''initator'' ->> ''customerId'' AS \\"Initiator User ID\\", observations -> ''txn'' -> ''attribs'' ->> ''captureMethod'' AS \\"Capture Method\\", observations -> ''txn'' -> ''attribs'' ->> ''mode'' AS \\"Mode\\", observations -> ''txn'' -> ''attribs'' -> ''method'' ->> ''type'' AS \\"Type\\", observations -> ''txn'' -> ''attribs'' -> ''method'' ->> ''subtype'' AS \\"Subtype\\", observations -> ''txn'' -> ''attribs'' ->> ''application'' AS \\"Application\\", observations -> ''txn'' -> ''attribs'' -> ''initatingEntity'' ->> ''entityId'' AS \\"Initiating entity ID\\", observations -> ''txn'' -> ''attribs'' ->> ''processingEntity'' AS  \\"processingEntity\\", observations -> ''txn'' -> ''attribs'' ->> ''invoice'' AS \\"Invoice\\", observations -> ''txn'' -> ''attribs'' ->> ''idempotentKey'' AS \\"Idempotent Key\\", CASE WHEN observations -> ''payer''  ->> ''amount'' = ''null'' THEN NULL ELSE CAST(NULLIF(observations -> ''payer''  ->> ''amount'', '''') AS float) END AS \\"Txn amount\\", CASE WHEN observations -> ''payer'' -> ''attribs'' ->> ''grossAmount'' = ''null'' THEN NULL ELSE CAST(NULLIF(observations -> ''payer'' -> ''attribs'' ->> ''grossAmount'', '''') AS float) END AS \\"Gross Amt\\", observations -> ''payer'' -> ''attribs'' ->> ''capturedAmount''  AS \\"Captured Amount\\", observations -> ''payer'' ->> ''type''  AS \\"Payer type\\", observations -> ''payer'' -> ''attribs'' -> ''identity'' ->> ''email'' AS \\"Payer email\\", observations -> ''payer'' ->> ''vpa''  AS \\"Payer addr\\", observations -> ''payer'' -> ''attribs'' ->> ''userID''  AS \\"Payer user ID\\", observations -> ''payee'' -> ''attribs'' ->> ''merchantID''  AS \\"Payee Merchant ID\\", observations -> ''payee'' -> ''attribs'' ->> ''terminalID''  AS \\"Payee Terminal ID\\", CASE WHEN observations -> ''payee'' ->> ''mcc'' = ''null'' THEN NULL ELSE CAST(NULLIF(observations -> ''payee'' ->> ''mcc'', '''') AS int) END AS \\"Payee MCC\\", observations -> ''payer'' ->> ''name''  AS \\"Payer name\\", observations -> ''payer'' -> ''attribs'' -> ''device'' ->> ''countryCode'' AS \\"Country Code\\", observations -> ''payer'' -> ''attribs'' -> ''device'' ->> ''mobilenum'' AS \\"Payer Mobile Number\\", observations -> ''payer'' -> ''attribs'' -> ''account_detail'' ->> ''accountType''  AS \\"Payer Account Type\\", observations -> ''payer'' -> ''attribs'' ->> ''cardType''  AS \\"Payer Card Type\\", observations -> ''payer'' -> ''attribs'' -> ''card'' ->> ''scheme'' AS \\"Payer Card Scheme\\", observations -> ''payer'' -> ''attribs'' -> ''card'' ->> ''cardType'' AS \\"Payer Card Type\\", observations -> ''payer'' -> ''attribs'' -> ''card'' ->> ''cardNumber'' AS \\"Payer Card Number\\", observations -> ''payer'' -> ''attribs'' -> ''card'' ->> ''cardName'' AS \\"Payer Card Name\\", observations -> ''payer'' -> ''attribs'' -> ''card'' ->> ''cardExpiryMM'' AS \\"Payer Card Expiry Month\\", observations -> ''payer'' -> ''attribs'' -> ''card'' ->> ''cardExpiryYY'' AS \\"Payer Card Expiry Year\\", observations -> ''payer'' -> ''attribs'' -> ''card'' ->> ''cvv'' AS \\"Payer Card cvv\\", observations -> ''payee'' ->> ''type''  AS \\"Payee Type\\", observations -> ''payee'' -> ''attribs'' ->> ''terminalID''  AS \\"Payee Terminal ID\\", observations -> ''payee'' -> ''attribs'' ->> ''merchantID''  AS \\"Payee Merchant ID\\", observations -> ''payee'' ->> ''mcc'' AS \\"Payee MCC\\", observations -> ''payee'' -> ''attribs'' -> ''identity'' ->>''name''  AS \\"Payee Name\\", observations -> ''payee'' -> ''attribs'' -> ''identity'' ->>''email''  AS \\"Payee Email\\", observations -> ''payee'' -> ''attribs'' -> ''identity'' -> ''mobile'' ->> ''countryCode''  AS \\"Country Code\\", observations -> ''payee'' -> ''attribs'' -> ''identity'' -> ''mobile'' ->> ''number''   AS \\"Payee Mobile Number\\", observations -> ''payee'' ->> ''vpa''  AS \\"Payee Addr\\", observations -> ''payee'' -> ''attribs'' -> ''card'' ->> ''cardNumber'' AS \\"Payee Card Number\\", observations -> ''payee'' -> ''attribs'' -> ''card'' ->> ''scheme'' AS \\"Payee Card Scheme\\", observations -> ''payee'' -> ''attribs'' -> ''card'' ->> ''cardType'' AS \\"Payee Card Type\\", observations -> ''payee'' -> ''attribs'' -> ''card'' ->> ''product'' AS \\"Payee Card Product\\", observations -> ''payee'' -> ''attribs'' -> ''card'' ->> ''name'' AS \\"Payee Card Name\\", observations -> ''payee'' -> ''attribs'' -> ''account_detail'' ->> ''bankName'' AS \\"Payee Bank Name\\", observations -> ''payee'' -> ''attribs'' -> ''account_detail'' ->> ''accountType'' AS \\"Payee Account Type\\", observations -> ''payee'' -> ''attribs'' -> ''address'' ->> ''pinCode'' AS \\"Payee Address Pincode\\", observations -> ''payee'' -> ''attribs'' -> ''address'' ->> ''stateCode'' AS \\"Payee Address State Code\\", observations -> ''payee'' -> ''attribs'' -> ''address'' ->> ''countryCode'' AS \\"Payee Address Country COde\\", observations -> ''payee'' -> ''attribs'' -> ''address'' ->> ''city'' AS \\"Payee Address City\\", observations -> ''payee'' -> ''attribs'' -> ''address'' ->> ''line1'' AS \\"Payee Address Line1\\", observations -> ''payee'' -> ''attribs'' -> ''address'' ->> ''stateCode'' AS \\"Payee Address Line2\\", observations -> ''txn'' -> ''attribs'' -> ''device'' ->> ''geocode'' AS \\"Geocode\\", observations -> ''txn'' -> ''attribs'' -> ''device'' ->> ''location'' AS \\"Location\\", observations -> ''txn'' -> ''attribs'' -> ''device'' ->> ''ip'' AS \\"IP\\", observations -> ''txn'' -> ''attribs'' -> ''device'' ->> ''type'' AS \\"Device Type\\", observations -> ''txn'' -> ''attribs'' -> ''device'' ->> ''id'' AS \\"Device ID\\", observations -> ''txn'' -> ''attribs'' -> ''device'' ->> ''os'' AS \\"Device OS\\", observations -> ''txn'' -> ''attribs'' -> ''device'' ->> ''appName'' AS \\"Device App\\", observations -> ''txn'' -> ''attribs'' -> ''device'' ->> ''capability'' AS \\"Device Capability\\", observations -> ''observations'' ->> ''payer_card_d01_txn_count'' AS \\"payer_card_d01_txn_count\\", observations -> ''observations'' ->> ''payee_account_open_refund_d01_txn_value'' AS \\"payee_account_open_refund_d01_txn_value\\", observations -> ''observations'' ->> ''payee_account_open_d01_txn_value'' AS \\"payee_account_open_d01_txn_value\\", observations -> ''observations'' ->> ''payee_account_p1d_txn_value'' AS \\"payee_account_p1d_txn_value\\" FROM analytics.trans l where l.vctxnfield3 = :VpaAddress and  dttrxntime between :StartDate  and :EndDate and itenantid = :tenantid  order by dttrxntime desc limit 50000 ",
        "Processor Transaction ID": "SELECT observations -> ''txn'' ->> ''id'' AS \\"Txn id\\", observations -> ''txn'' -> ''attribs'' -> ''initator'' ->> ''customerId'' AS \\"Initiator User ID\\", observations -> ''txn'' -> ''attribs'' ->> ''captureMethod'' AS \\"Capture Method\\", observations -> ''txn'' -> ''attribs'' ->> ''mode'' AS \\"Mode\\", observations -> ''txn'' -> ''attribs'' -> ''method'' ->> ''type'' AS \\"Type\\", observations -> ''txn'' -> ''attribs'' -> ''method'' ->> ''subtype'' AS \\"Subtype\\", observations -> ''txn'' -> ''attribs'' ->> ''application'' AS \\"Application\\", observations -> ''txn'' -> ''attribs'' -> ''initatingEntity'' ->> ''entityId'' AS \\"Initiating entity ID\\", observations -> ''txn'' -> ''attribs'' ->> ''processingEntity'' AS  \\"processingEntity\\", observations -> ''txn'' -> ''attribs'' ->> ''invoice'' AS \\"Invoice\\", observations -> ''txn'' -> ''attribs'' ->> ''idempotentKey'' AS \\"Idempotent Key\\", CASE WHEN observations -> ''payer''  ->> ''amount'' = ''null'' THEN NULL ELSE CAST(NULLIF(observations -> ''payer''  ->> ''amount'', '''') AS float) END AS \\"Txn amount\\", CASE WHEN observations -> ''payer'' -> ''attribs'' ->> ''grossAmount'' = ''null'' THEN NULL ELSE CAST(NULLIF(observations -> ''payer'' -> ''attribs'' ->> ''grossAmount'', '''') AS float) END AS \\"Gross Amt\\", observations -> ''payer'' -> ''attribs'' ->> ''capturedAmount''  AS \\"Captured Amount\\", observations -> ''payer'' ->> ''type''  AS \\"Payer type\\", observations -> ''payer'' -> ''attribs'' -> ''identity'' ->> ''email'' AS \\"Payer email\\", observations -> ''payer'' ->> ''vpa''  AS \\"Payer addr\\", observations -> ''payer'' -> ''attribs'' ->> ''userID''  AS \\"Payer user ID\\", observations -> ''payee'' -> ''attribs'' ->> ''merchantID''  AS \\"Payee Merchant ID\\", observations -> ''payee'' -> ''attribs'' ->> ''terminalID''  AS \\"Payee Terminal ID\\", CASE WHEN observations -> ''payee'' ->> ''mcc'' = ''null'' THEN NULL ELSE CAST(NULLIF(observations -> ''payee'' ->> ''mcc'', '''') AS int) END AS \\"Payee MCC\\", observations -> ''payer'' ->> ''name''  AS \\"Payer name\\", observations -> ''payer'' -> ''attribs'' -> ''device'' ->> ''countryCode'' AS \\"Country Code\\", observations -> ''payer'' -> ''attribs'' -> ''device'' ->> ''mobilenum'' AS \\"Payer Mobile Number\\", observations -> ''payer'' -> ''attribs'' -> ''account_detail'' ->> ''accountType''  AS \\"Payer Account Type\\", observations -> ''payer'' -> ''attribs'' ->> ''cardType''  AS \\"Payer Card Type\\", observations -> ''payer'' -> ''attribs'' -> ''card'' ->> ''scheme'' AS \\"Payer Card Scheme\\", observations -> ''payer'' -> ''attribs'' -> ''card'' ->> ''cardType'' AS \\"Payer Card Type\\", observations -> ''payer'' -> ''attribs'' -> ''card'' ->> ''cardNumber'' AS \\"Payer Card Number\\", observations -> ''payer'' -> ''attribs'' -> ''card'' ->> ''cardName'' AS \\"Payer Card Name\\", observations -> ''payer'' -> ''attribs'' -> ''card'' ->> ''cardExpiryMM'' AS \\"Payer Card Expiry Month\\", observations -> ''payer'' -> ''attribs'' -> ''card'' ->> ''cardExpiryYY'' AS \\"Payer Card Expiry Year\\", observations -> ''payer'' -> ''attribs'' -> ''card'' ->> ''cvv'' AS \\"Payer Card cvv\\", observations -> ''payee'' ->> ''type''  AS \\"Payee Type\\", observations -> ''payee'' -> ''attribs'' ->> ''terminalID''  AS \\"Payee Terminal ID\\", observations -> ''payee'' -> ''attribs'' ->> ''merchantID''  AS \\"Payee Merchant ID\\", observations -> ''payee'' ->> ''mcc'' AS \\"Payee MCC\\", observations -> ''payee'' -> ''attribs'' -> ''identity'' ->>''name''  AS \\"Payee Name\\", observations -> ''payee'' -> ''attribs'' -> ''identity'' ->>''email''  AS \\"Payee Email\\", observations -> ''payee'' -> ''attribs'' -> ''identity'' -> ''mobile'' ->> ''countryCode''  AS \\"Country Code\\", observations -> ''payee'' -> ''attribs'' -> ''identity'' -> ''mobile'' ->> ''number''   AS \\"Payee Mobile Number\\", observations -> ''payee'' ->> ''vpa''  AS \\"Payee Addr\\", observations -> ''payee'' -> ''attribs'' -> ''card'' ->> ''cardNumber'' AS \\"Payee Card Number\\", observations -> ''payee'' -> ''attribs'' -> ''card'' ->> ''scheme'' AS \\"Payee Card Scheme\\", observations -> ''payee'' -> ''attribs'' -> ''card'' ->> ''cardType'' AS \\"Payee Card Type\\", observations -> ''payee'' -> ''attribs'' -> ''card'' ->> ''product'' AS \\"Payee Card Product\\", observations -> ''payee'' -> ''attribs'' -> ''card'' ->> ''name'' AS \\"Payee Card Name\\", observations -> ''payee'' -> ''attribs'' -> ''account_detail'' ->> ''bankName'' AS \\"Payee Bank Name\\", observations -> ''payee'' -> ''attribs'' -> ''account_detail'' ->> ''accountType'' AS \\"Payee Account Type\\", observations -> ''payee'' -> ''attribs'' -> ''address'' ->> ''pinCode'' AS \\"Payee Address Pincode\\", observations -> ''payee'' -> ''attribs'' -> ''address'' ->> ''stateCode'' AS \\"Payee Address State Code\\", observations -> ''payee'' -> ''attribs'' -> ''address'' ->> ''countryCode'' AS \\"Payee Address Country COde\\", observations -> ''payee'' -> ''attribs'' -> ''address'' ->> ''city'' AS \\"Payee Address City\\", observations -> ''payee'' -> ''attribs'' -> ''address'' ->> ''line1'' AS \\"Payee Address Line1\\", observations -> ''payee'' -> ''attribs'' -> ''address'' ->> ''stateCode'' AS \\"Payee Address Line2\\", observations -> ''txn'' -> ''attribs'' -> ''device'' ->> ''geocode'' AS \\"Geocode\\", observations -> ''txn'' -> ''attribs'' -> ''device'' ->> ''location'' AS \\"Location\\", observations -> ''txn'' -> ''attribs'' -> ''device'' ->> ''ip'' AS \\"IP\\", observations -> ''txn'' -> ''attribs'' -> ''device'' ->> ''type'' AS \\"Device Type\\", observations -> ''txn'' -> ''attribs'' -> ''device'' ->> ''id'' AS \\"Device ID\\", observations -> ''txn'' -> ''attribs'' -> ''device'' ->> ''os'' AS \\"Device OS\\", observations -> ''txn'' -> ''attribs'' -> ''device'' ->> ''appName'' AS \\"Device App\\", observations -> ''txn'' -> ''attribs'' -> ''device'' ->> ''capability'' AS \\"Device Capability\\", observations -> ''observations'' ->> ''payer_card_d01_txn_count'' AS \\"payer_card_d01_txn_count\\", observations -> ''observations'' ->> ''payee_account_open_refund_d01_txn_value'' AS \\"payee_account_open_refund_d01_txn_value\\", observations -> ''observations'' ->> ''payee_account_open_d01_txn_value'' AS \\"payee_account_open_d01_txn_value\\", observations -> ''observations'' ->> ''payee_account_p1d_txn_value'' AS \\"payee_account_p1d_txn_value\\" FROM analytics.trans l where l.vctxnfield4 = :VpaAddress and  dttrxntime between :StartDate  and :EndDate and itenantid = :tenantid  order by dttrxntime desc limit 50000 "
    }
}'::text WHERE
idashboardqueryid = 116 AND itenantid in  (14, 15);


UPDATE analytics.trans SET vctxnfield3 = observations->'txn'->'attribs'->>'invoice';
UPDATE analytics.trans SET vctxnfield4 = observations->'txn'->'attribs'->>'processorTransactionId';

UPDATE ui.orgs SET attribs = jsonb_set(attribs, '{vclogourl}', '"JIO-JPSL.png"', true) WHERE iorgid = 10;
UPDATE ui.orgs SET attribs = jsonb_set(attribs, '{logoStyle, login, width}', '"250px"', true) WHERE iorgid = 10;
UPDATE ui.orgs SET attribs = jsonb_set(attribs, '{logoStyle, login, minWidth}', '"220px"', true) WHERE iorgid = 10;
UPDATE ui.orgs SET attribs = jsonb_set(attribs, '{logoStyle, navbar, width}', '"110px"', true) WHERE iorgid = 10;


UPDATE ui.workflowmasters SET
displayconfig = '[ 
  {
    "type": "sortingOptions",
    "render": false,
    "options": [
      {
        "key": "parameters.sorting[]",
        "value": "Created Date",
        "bodyValue": {
          "my": {
            "key": "sortBy",
            "value": "starttime"
          },
          "open": {
            "key": "sortBy",
            "value": "starttime"
          },
          "closed": {
            "key": "sortBy",
            "value": "starttime"
          },
          "myclosed": {
            "key": "sortBy",
            "value": "starttime"
          }
        },
        "compareValue": {
          "value": {
            "jsonLogic": {
              "var": "data.leftPanelLogic.sortBy.value"
            }
          }
        },
        "finalbodyvalue": {
          "keysToSet": [
            {
              "name": "sortBy",
              "value": "created",
              "setKeyIf": {
                "or": [
                  {
                    "if": [
                      {
                        "==": [
                          {
                            "var": "data.indexLogic.taskSelect.label"
                          },
                          "Open"
                        ]
                      },
                      true,
                      false
                    ]
                  },
                  {
                    "if": [
                      {
                        "==": [
                          {
                            "var": "data.indexLogic.taskSelect.label"
                          },
                          "My"
                        ]
                      },
                      true,
                      false
                    ]
                  }
                ]
              }
            },
            {
              "name": "sortBy",
              "value": "startTime",
              "setKeyIf": {
                "or": [
                  {
                    "if": [
                      {
                        "==": [
                          {
                            "var": "data.indexLogic.taskSelect.label"
                          },
                          "Closed"
                        ]
                      },
                      true,
                      false
                    ]
                  },
                  {
                    "if": [
                      {
                        "==": [
                          {
                            "var": "data.indexLogic.taskSelect.label"
                          },
                          "My Closed"
                        ]
                      },
                      true,
                      false
                    ]
                  }
                ]
              }
            },
            {
              "name": "sortOrder",
              "value": {
                "jsonLogic": {
                  "var": "data.leftPanelLogic.filterSortDir"
                }
              }
            }
          ]
        }
      },
      {
        "key": "parameters.sorting[]",
        "value": "Risk Score",
        "bodyValue": {
          "key": "sortBy",
          "value": "riskscore"
        },
        "compareValue": {
          "value": {
            "jsonLogic": {
              "var": "data.leftPanelLogic.sortBy.value"
            }
          }
        },
        "finalbodyvalue": {
          "keysToSet": [
            {
              "name": "sortBy",
              "value": "processVariable",
              "setKeyIf": {
                "and": [
                  {
                    "if": [
                      {
                        "!=": [
                          {
                            "var": "data.indexLogic.taskSelect.label"
                          },
                          "Closed"
                        ]
                      },
                      true,
                      false
                    ]
                  },
                  {
                    "if": [
                      {
                        "!=": [
                          {
                            "var": "data.indexLogic.taskSelect.label"
                          },
                          "My Closed"
                        ]
                      },
                      true,
                      false
                    ]
                  }
                ]
              }
            },
            {
              "name": "sortOrder",
              "value": {
                "jsonLogic": {
                  "var": "data.leftPanelLogic.filterSortDir"
                }
              },
              "setKeyIf": {
                "and": [
                  {
                    "if": [
                      {
                        "!=": [
                          {
                            "var": "data.indexLogic.taskSelect.label"
                          },
                          "Closed"
                        ]
                      },
                      true,
                      false
                    ]
                  },
                  {
                    "if": [
                      {
                        "!=": [
                          {
                            "var": "data.indexLogic.taskSelect.label"
                          },
                          "My Closed"
                        ]
                      },
                      true,
                      false
                    ]
                  }
                ]
              }
            },
            {
              "name": "parameters",
              "value": {
                "type": "long",
                "variable": "RiskScore"
              },
              "setKeyIf": {
                "and": [
                  {
                    "if": [
                      {
                        "!=": [
                          {
                            "var": "data.indexLogic.taskSelect.label"
                          },
                          "Closed"
                        ]
                      },
                      true,
                      false
                    ]
                  },
                  {
                    "if": [
                      {
                        "!=": [
                          {
                            "var": "data.indexLogic.taskSelect.label"
                          },
                          "My Closed"
                        ]
                      },
                      true,
                      false
                    ]
                  }
                ]
              }
            }
          ]
        }
      },
      {
        "key": "parameters.sorting[]",
        "value": "Transaction Amount",
        "bodyValue": {
          "key": "sortBy",
          "value": "amount"
        },
        "compareValue": {
          "value": {
            "jsonLogic": {
              "var": "data.leftPanelLogic.sortBy.value"
            }
          }
        },
        "finalbodyvalue": {
          "keysToSet": [
            {
              "name": "sortBy",
              "value": "processVariable",
              "setKeyIf": {
                "and": [
                  {
                    "if": [
                      {
                        "!=": [
                          {
                            "var": "data.indexLogic.taskSelect.label"
                          },
                          "Closed"
                        ]
                      },
                      true,
                      false
                    ]
                  },
                  {
                    "if": [
                      {
                        "!=": [
                          {
                            "var": "data.indexLogic.taskSelect.label"
                          },
                          "My Closed"
                        ]
                      },
                      true,
                      false
                    ]
                  }
                ]
              }
            },
            {
              "name": "sortOrder",
              "value": {
                "jsonLogic": {
                  "var": "data.leftPanelLogic.filterSortDir"
                }
              },
              "setKeyIf": {
                "and": [
                  {
                    "if": [
                      {
                        "!=": [
                          {
                            "var": "data.indexLogic.taskSelect.label"
                          },
                          "Closed"
                        ]
                      },
                      true,
                      false
                    ]
                  },
                  {
                    "if": [
                      {
                        "!=": [
                          {
                            "var": "data.indexLogic.taskSelect.label"
                          },
                          "My Closed"
                        ]
                      },
                      true,
                      false
                    ]
                  }
                ]
              }
            },
            {
              "name": "parameters",
              "value": {
                "type": "double",
                "variable": "TransactionAmount"
              },
              "setKeyIf": {
                "and": [
                  {
                    "if": [
                      {
                        "!=": [
                          {
                            "var": "data.indexLogic.taskSelect.label"
                          },
                          "Closed"
                        ]
                      },
                      true,
                      false
                    ]
                  },
                  {
                    "if": [
                      {
                        "!=": [
                          {
                            "var": "data.indexLogic.taskSelect.label"
                          },
                          "My Closed"
                        ]
                      },
                      true,
                      false
                    ]
                  }
                ]
              }
            }
          ]
        }
      }
    ],
    "compareValue": true
  },
  {
    "key": "parameters.tenantIdIn",
    "name": "TenantId",
    "type": "multiSelect",
    "label": "Tenant",
    "value": {
      "jsonLogic": {
        "var": "data.formData.TenantId"
      }
    },
    "keyType": "array",
    "options": {
      "jsonLogic": {
        "var": "data.indexHttpData.tenantOptions"
      }
    },
    "defaultValue": {
      "setDefaultValueIf": [
        {
          "key": "data.formData.TenantId",
          "TRUE": {
            "key": "data.formData.TenantId",
            "type": "array"
          },
          "gteq": 1,
          "FALSE": {
            "key": "data.indexHttpData.tenantOptions",
            "map": "itenantId",
            "type": "array"
          },
          "action": "checkLength"
        }
      ]
    },
    "keyToExtract": "itenantId",
    "maxSelectable": 1,
    "onChangeAction": [
      {
        "key": "callApi",
        "body": [
          {
            "PARSEINT": true,
            "lodashKey": "data.formData.TenantId",
            "bodyKeyName": "tenants"
          }
        ],
        "route": "/api/v1/admin/app-users/get-all-workflows/${menuName}",
        "RequestType": "POST",
        "paramValues": [
          {
            "value": "Tasks"
          }
        ],
        "onApiSuccess": [
          {
            "key": "setIndexHttpData",
            "keyToSet": "workFlowNamesDrop"
          }
        ],
        "beforeCallAction": [
          {
            "key": "resetFormDataAll"
          },
          {
            "key": "resetIndexHttpDataKey",
            "keyToReset": "filter.inputJson"
          },
          {
            "key": "resetIndexHttpDataKey",
            "keyToReset": "apiOptions"
          }
        ]
      }
    ]
  },
  {
    "key": {
      "value": "parameters.processDefinitionKeyIn",
      "closed": {
        "key": "parameters.orQueries",
        "outputFormat": {
          "keys": {
            "items": [
              {
                "key": "name",
                "value": "WorkflowName"
              },
              {
                "key": "value",
                "value": {
                  "key": "value",
                  "keyToExtract": "label"
                }
              },
              {
                "key": "operator",
                "value": "eq"
              }
            ]
          },
          "type": "arrayofobjects",
          "value": {
            "jsonLogic": {
              "var": "data.indexHttpData.workFlowNamesDrop"
            },
            "keyToCheck": "workflowKey",
            "compareWith": "data.newValue",
            "keyToExtract": "label"
          }
        }
      },
      "myclosed": {
        "key": "parameters.orQueries[].processVariables",
        "outputFormat": {
          "keys": {
            "items": [
              {
                "key": "name",
                "value": "WorkflowName"
              },
              {
                "key": "value",
                "value": {
                  "key": "value",
                  "keyToExtract": "label"
                }
              },
              {
                "key": "operator",
                "value": "eq"
              }
            ]
          },
          "type": "arrayofobjects",
          "value": {
            "jsonLogic": {
              "var": "data.indexHttpData.workFlowNamesDrop"
            },
            "keyToCheck": "workflowKey",
            "compareWith": "data.newValue",
            "keyToExtract": "label"
          }
        }
      }
    },
    "name": "CaseType",
    "type": "multiSelect",
    "label": "Case Type",
    "value": {
      "jsonLogic": {
        "var": "data.formData.CaseType"
      }
    },
    "keyType": "array",
    "options": {
      "jsonLogic": {
        "var": "data.indexHttpData.workFlowNamesDrop"
      }
    },
    "bodyValue": {
      "key": "defKey",
      "jsonLogic": {
        "var": "data.formData.CaseType"
      }
    },
    "defaultValue": {
      "setDefaultValueIf": [
        {
          "key": "data.formData.CaseType",
          "TRUE": {
            "key": "data.formData.CaseType",
            "type": "array"
          },
          "gteq": 1,
          "FALSE": {
            "key": "data.indexHttpData.workFlowNamesDrop",
            "map": "workflowKey",
            "type": "array"
          },
          "action": "checkLength"
        }
      ]
    },
    "keyToExtract": "workflowKey",
    "maxSelectable": 1,
    "onChangeAction": [
      {
        "key": "callApi",
        "route": "/api/v1/task/filter/config/${paramOne}/${paramTwo}",
        "RequestType": "GET",
        "paramValues": [
          {
            "key": "data.formData.TenantId[0]"
          },
          {
            "key": "data.formData.CaseType[0]",
            "paramValueHardCode": "workflowid"
          }
        ],
        "onApiSuccess": [
          {
            "key": "setIndexHttpData",
            "keyToSet": "filter.inputJson"
          }
        ],
        "beforeCallAction": [
          {
            "key": "resetFormDataWorkflow"
          },
          {
            "key": "resetIndexHttpDataKey",
            "keyToReset": "filter.inputJson"
          },
          {
            "key": "resetIndexHttpDataKey",
            "keyToReset": "apiOptions"
          }
        ]
      }
    ]
  },
  {
    "key": {
      "my": {
        "key": "parameters.createdAfter,parameters.createdBefore",
        "lodashKey": "data.formData.startDate,data.formData.endDate"
      },
      "open": {
        "key": "parameters.createdAfter,parameters.createdBefore",
        "lodashKey": "data.formData.startDate,data.formData.endDate"
      },
      "closed": {
        "key": "parameters.startedAfter,parameters.finsihedBefore",
        "lodashKey": "data.formData.startDate,data.formData.endDate"
      },
      "myclosed": {
        "key": "parameters.startedAfter,parameters.finsihedBefore",
        "lodashKey": "data.formData.startDate,data.formData.endDate"
      }
    },
    "name": "startDate,endDate,startedAfter,finsihedBefore",
    "type": "dateRange",
    "label": "Date Range",
    "valueKey": "dataRangeValueKey",
    "bodyValue": {
      "key": "startDate,endDate,startedAfter,finsihedBefore",
      "lodashKey": "data.formData.startDate,data.formData.endDate,data.formData.startDate,data.formData.endDate"
    },
    "multipleKeyName": "[0],[1],[0],[1]"
  },
  {
    "key": {
      "value": "parameters.taskDefinitionKeyIn",
      "lodashKey": "data.formData.Status"
    },
    "name": "Status",
    "type": "multiSelect",
    "label": "Status",
    "options": {
      "jsonLogic": {
        "var": "data.indexHttpData.apiOptions.statusOptions"
      }
    },
    "apiOptions": {
      "url": "/api/v1/case-management/tasks/get-status/tenant-id/${tenantid}/workflow-key/${workflowKey}",
      "body": {
        "keys": [
          {
            "key": "maxResult",
            "valueKey": "indexLogic.maximumResult.value"
          },
          {
            "key": "parameters",
            "valueKey": "indexLogic?.taskSelect?.value"
          }
        ]
      },
      "RequestType": "POST",
      "paramValues": [
        {
          "key": "data.formData.TenantId[0]"
        },
        {
          "key": "data.formData.CaseType[0]"
        }
      ],
      "responseKey": "statusOptions"
    },
    "isClearable": true,
    "keyToExtract": "value"
  },
  {
    "key": {
      "my": {
        "key": "parameters.processVariables[]",
        "lodashKey": "data.formData.TransactionAmount",
        "outputFormat": {
          "keys": {
            "items": [
              {
                "key": "name",
                "value": "TransactionAmount"
              },
              {
                "key": "value",
                "value": {
                  "key": "data.formData.TransactionAmount",
                  "finalbodyMultiplier": 100
                }
              },
              {
                "key": "operator",
                "value": {
                  "key": "data.formData.TransactionAmountCompareOperator"
                }
              }
            ],
            "setKeyIf": {
              "and": [
                {
                  "if": [
                    {
                      "!=": [
                        {
                          "var": "data.formData.TransactionAmountCompareOperator"
                        },
                        null
                      ]
                    },
                    true,
                    false
                  ]
                }
              ]
            }
          },
          "type": "object"
        }
      },
      "open": {
        "key": "parameters.processVariables[]",
        "lodashKey": "data.formData.TransactionAmount",
        "outputFormat": {
          "keys": {
            "items": [
              {
                "key": "name",
                "value": "TransactionAmount"
              },
              {
                "key": "value",
                "value": {
                  "key": "data.formData.TransactionAmount",
                  "finalbodyMultiplier": 100
                }
              },
              {
                "key": "operator",
                "value": {
                  "key": "data.formData.TransactionAmountCompareOperator"
                }
              }
            ],
            "setKeyIf": {
              "and": [
                {
                  "if": [
                    {
                      "!=": [
                        {
                          "var": "data.formData.TransactionAmountCompareOperator"
                        },
                        null
                      ]
                    },
                    true,
                    false
                  ]
                }
              ]
            }
          },
          "type": "object"
        }
      },
      "closed": {
        "key": "parameters.variables[]",
        "lodashKey": "data.formData.TransactionAmount",
        "outputFormat": {
          "keys": {
            "items": [
              {
                "key": "name",
                "value": "TransactionAmount"
              },
              {
                "key": "value",
                "value": {
                  "key": "data.formData.TransactionAmount",
                  "finalbodyMultiplier": 100
                }
              },
              {
                "key": "operator",
                "value": {
                  "key": "data.formData.TransactionAmountCompareOperator"
                }
              }
            ],
            "setKeyIf": {
              "and": [
                {
                  "if": [
                    {
                      "!=": [
                        {
                          "var": "data.formData.TransactionAmountCompareOperator"
                        },
                        null
                      ]
                    },
                    true,
                    false
                  ]
                }
              ]
            }
          },
          "type": "object"
        }
      },
      "myclosed": {
        "key": "parameters.processVariables[]",
        "lodashKey": "data.formData.TransactionAmount",
        "outputFormat": {
          "keys": {
            "items": [
              {
                "key": "name",
                "value": "TransactionAmount"
              },
              {
                "key": "value",
                "value": {
                  "key": "data.formData.TransactionAmount",
                  "finalbodyMultiplier": 100
                }
              },
              {
                "key": "operator",
                "value": {
                  "key": "data.formData.TransactionAmountCompareOperator"
                }
              }
            ],
            "setKeyIf": {
              "and": [
                {
                  "if": [
                    {
                      "!=": [
                        {
                          "var": "data.formData.TransactionAmountCompareOperator"
                        },
                        null
                      ]
                    },
                    true,
                    false
                  ]
                }
              ]
            }
          },
          "type": "object"
        }
      }
    },
    "min": 0,
    "name": "TransactionAmount",
    "type": "number",
    "label": "Transaction Amount",
    "compareOperator": {
      "name": "TransactionAmountCompareOperator",
      "type": "select",
      "options": [
        {
          "label": "=",
          "value": "eq"
        },
        {
          "label": "<",
          "value": "lt"
        },
        {
          "label": ">",
          "value": "gt"
        }
      ]
    }
  },
  {
    "key": {
      "my": {
        "key": "parameters.processVariables[]",
        "lodashKey": "data.formData.LevelType",
        "outputFormat": {
          "keys": {
            "items": [
              {
                "key": "name",
                "value": {
                  "key": "data.formData.LevelType"
                }
              },
              {
                "key": "value",
                "value": {
                  "key": "data.formData.Address"
                }
              },
              {
                "key": "operator",
                "value": "eq"
              }
            ],
            "setKeyIf": {
              "and": [
                {
                  "if": [
                    {
                      "!=": [
                        {
                          "var": "data.formData.Address"
                        },
                        null
                      ]
                    },
                    {
                      "!=": [
                        {
                          "var": "data.formData.Address"
                        },
                        ""
                      ]
                    },
                    true,
                    false
                  ]
                }
              ]
            }
          },
          "type": "object",
          "keys2": {
            "items": [
              {
                "key": "name",
                "value": "basedon"
              },
              {
                "key": "value",
                "value": {
                  "jsonLogic": {
                    "if": [
                      {
                        "and": [
                          {
                            "==": [
                              {
                                "var": "data.formData.levelSelectMain"
                              },
                              "Account"
                            ]
                          }
                        ]
                      },
                      "account",
                      {
                        "and": [
                          {
                            "==": [
                              {
                                "var": "data.formData.levelSelectMain"
                              },
                              "VPA"
                            ]
                          }
                        ]
                      },
                      "vpa",
                      "Invalid input"
                    ]
                  }
                }
              },
              {
                "key": "operator",
                "value": "eq"
              }
            ],
            "setKeyIf": {
              "and": [
                {
                  "if": [
                    {
                      "==": [
                        {
                          "var": "data.formData.typeSelectMain"
                        },
                        "address"
                      ]
                    },
                    true,
                    false
                  ]
                }
              ]
            }
          }
        }
      },
      "open": {
        "key": "parameters.processVariables[]",
        "lodashKey": "data.formData.LevelType",
        "outputFormat": {
          "keys": {
            "items": [
              {
                "key": "name",
                "value": {
                  "key": "data.formData.LevelType"
                }
              },
              {
                "key": "value",
                "value": {
                  "key": "data.formData.Address"
                }
              },
              {
                "key": "operator",
                "value": "eq"
              }
            ],
            "setKeyIf": {
              "and": [
                {
                  "if": [
                    {
                      "!=": [
                        {
                          "var": "data.formData.Address"
                        },
                        null
                      ]
                    },
                    {
                      "!=": [
                        {
                          "var": "data.formData.Address"
                        },
                        ""
                      ]
                    },
                    true,
                    false
                  ]
                }
              ]
            }
          },
          "type": "object",
          "keys2": {
            "items": [
              {
                "key": "name",
                "value": "basedon"
              },
              {
                "key": "value",
                "value": {
                  "jsonLogic": {
                    "if": [
                      {
                        "and": [
                          {
                            "==": [
                              {
                                "var": "data.formData.levelSelectMain"
                              },
                              "Account"
                            ]
                          }
                        ]
                      },
                      "account",
                      {
                        "and": [
                          {
                            "==": [
                              {
                                "var": "data.formData.levelSelectMain"
                              },
                              "VPA"
                            ]
                          }
                        ]
                      },
                      "vpa",
                      "Invalid input"
                    ]
                  }
                }
              },
              {
                "key": "operator",
                "value": "eq"
              }
            ],
            "setKeyIf": {
              "and": [
                {
                  "if": [
                    {
                      "==": [
                        {
                          "var": "data.formData.typeSelectMain"
                        },
                        "address"
                      ]
                    },
                    true,
                    false
                  ]
                }
              ]
            }
          }
        }
      },
      "closed": {
        "key": "parameters.variables[]",
        "lodashKey": "data.formData.LevelType",
        "outputFormat": {
          "keys": {
            "items": [
              {
                "key": "name",
                "value": {
                  "key": "data.formData.LevelType"
                }
              },
              {
                "key": "value",
                "value": {
                  "key": "data.formData.Address"
                }
              },
              {
                "key": "operator",
                "value": "eq"
              }
            ]
          },
          "type": "object",
          "keys2": {
            "items": [
              {
                "key": "name",
                "value": "basedon"
              },
              {
                "key": "value",
                "value": {
                  "jsonLogic": {
                    "if": [
                      {
                        "and": [
                          {
                            "==": [
                              {
                                "var": "data.formData.levelSelectMain"
                              },
                              "Account"
                            ]
                          }
                        ]
                      },
                      "account",
                      {
                        "and": [
                          {
                            "==": [
                              {
                                "var": "data.formData.levelSelectMain"
                              },
                              "VPA"
                            ]
                          }
                        ]
                      },
                      "vpa",
                      "Invalid input"
                    ]
                  }
                }
              },
              {
                "key": "operator",
                "value": "eq"
              }
            ],
            "setKeyIf": {
              "and": [
                {
                  "if": [
                    {
                      "==": [
                        {
                          "var": "data.formData.typeSelectMain"
                        },
                        "address"
                      ]
                    },
                    true,
                    false
                  ]
                }
              ]
            }
          },
          "setKeyIf": {
            "and": [
              {
                "if": [
                  {
                    "!=": [
                      {
                        "var": "data.formData.Address"
                      },
                      null
                    ]
                  },
                  {
                    "!=": [
                      {
                        "var": "data.formData.Address"
                      },
                      ""
                    ]
                  },
                  true,
                  false
                ]
              }
            ]
          }
        }
      },
      "myclosed": {
        "key": "parameters.processVariables[]",
        "lodashKey": "data.formData.LevelType",
        "outputFormat": {
          "keys": {
            "items": [
              {
                "key": "name",
                "value": {
                  "key": "data.formData.LevelType"
                }
              },
              {
                "key": "value",
                "value": {
                  "key": "data.formData.Address"
                }
              },
              {
                "key": "operator",
                "value": "eq"
              }
            ],
            "setKeyIf": {
              "and": [
                {
                  "if": [
                    {
                      "!=": [
                        {
                          "var": "data.formData.Address"
                        },
                        null
                      ]
                    },
                    {
                      "!=": [
                        {
                          "var": "data.formData.Address"
                        },
                        ""
                      ]
                    },
                    true,
                    false
                  ]
                }
              ]
            }
          },
          "type": "object",
          "keys2": {
            "items": [
              {
                "key": "name",
                "value": "basedon"
              },
              {
                "key": "value",
                "value": {
                  "jsonLogic": {
                    "if": [
                      {
                        "and": [
                          {
                            "==": [
                              {
                                "var": "data.formData.levelSelectMain"
                              },
                              "Account"
                            ]
                          }
                        ]
                      },
                      "account",
                      {
                        "and": [
                          {
                            "==": [
                              {
                                "var": "data.formData.levelSelectMain"
                              },
                              "VPA"
                            ]
                          }
                        ]
                      },
                      "vpa",
                      "Invalid input"
                    ]
                  }
                }
              },
              {
                "key": "operator",
                "value": "eq"
              }
            ],
            "setKeyIf": {
              "and": [
                {
                  "if": [
                    {
                      "==": [
                        {
                          "var": "data.formData.typeSelectMain"
                        },
                        "address"
                      ]
                    },
                    true,
                    false
                  ]
                }
              ]
            }
          }
        }
      }
    },
    "name": "LevelType",
    "type": "object",
    "fields": [
      {
        "name": "levelSelectMain",
        "type": "select",
        "label": "Level",
        "options": [
          {
            "label": "Account",
            "value": "Account"
          },
          {
            "label": "VPA",
            "value": "VPA"
          }
        ],
        "onChangeAction": [
          {
            "key": "setOtherKey",
            "keyToSet": "LevelType",
            "keyValue": {
              "jsonLogic": {
                "if": [
                  {
                    "and": [
                      {
                        "==": [
                          {
                            "var": "data.formData.levelSelectMain"
                          },
                          "Account"
                        ]
                      },
                      {
                        "==": [
                          {
                            "var": "data.formData.typeSelectMain"
                          },
                          "Payer"
                        ]
                      }
                    ]
                  },
                  "payerAccount",
                  {
                    "and": [
                      {
                        "==": [
                          {
                            "var": "data.formData.levelSelectMain"
                          },
                          "Account"
                        ]
                      },
                      {
                        "==": [
                          {
                            "var": "data.formData.typeSelectMain"
                          },
                          "Payee"
                        ]
                      }
                    ]
                  },
                  "payeeAccount",
                  {
                    "and": [
                      {
                        "==": [
                          {
                            "var": "data.formData.levelSelectMain"
                          },
                          "VPA"
                        ]
                      },
                      {
                        "==": [
                          {
                            "var": "data.formData.typeSelectMain"
                          },
                          "Payer"
                        ]
                      }
                    ]
                  },
                  "payer",
                  {
                    "and": [
                      {
                        "==": [
                          {
                            "var": "data.formData.levelSelectMain"
                          },
                          "VPA"
                        ]
                      },
                      {
                        "==": [
                          {
                            "var": "data.formData.typeSelectMain"
                          },
                          "Payee"
                        ]
                      }
                    ]
                  },
                  "payee",
                  "address"
                ]
              }
            }
          }
        ]
      },
      {
        "name": "typeSelectMain",
        "type": "select",
        "label": "Type",
        "options": [
          {
            "label": "Payer",
            "value": "Payer"
          },
          {
            "label": "Payee",
            "value": "Payee"
          },
          {
            "label": "Profile",
            "value": "address"
          }
        ],
        "onChangeAction": [
          {
            "key": "setOtherKey",
            "keyToSet": "LevelType",
            "keyValue": {
              "jsonLogic": {
                "if": [
                  {
                    "and": [
                      {
                        "==": [
                          {
                            "var": "data.formData.levelSelectMain"
                          },
                          "Account"
                        ]
                      },
                      {
                        "==": [
                          {
                            "var": "data.formData.typeSelectMain"
                          },
                          "Payer"
                        ]
                      }
                    ]
                  },
                  "payerAccount",
                  {
                    "and": [
                      {
                        "==": [
                          {
                            "var": "data.formData.levelSelectMain"
                          },
                          "Account"
                        ]
                      },
                      {
                        "==": [
                          {
                            "var": "data.formData.typeSelectMain"
                          },
                          "Payee"
                        ]
                      }
                    ]
                  },
                  "payeeAccount",
                  {
                    "and": [
                      {
                        "==": [
                          {
                            "var": "data.formData.levelSelectMain"
                          },
                          "VPA"
                        ]
                      },
                      {
                        "==": [
                          {
                            "var": "data.formData.typeSelectMain"
                          },
                          "Payer"
                        ]
                      }
                    ]
                  },
                  "payer",
                  {
                    "and": [
                      {
                        "==": [
                          {
                            "var": "data.formData.levelSelectMain"
                          },
                          "VPA"
                        ]
                      },
                      {
                        "==": [
                          {
                            "var": "data.formData.typeSelectMain"
                          },
                          "Payee"
                        ]
                      }
                    ]
                  },
                  "payee",
                  "address"
                ]
              }
            }
          }
        ]
      }
    ]
  },
  {
    "name": "Address",
    "type": "text",
    "label": "Address"
  },
  {
    "name": "NoOfCases",
    "type": "select",
    "label": "No Of Cases",
    "options": [
      {
        "label": "20",
        "value": 20
      },
      {
        "label": "30",
        "value": 30
      },
      {
        "label": "50",
        "value": 50
      }
    ],
    "bodyValue": {
      "key": "maxResult",
      "lodashKey": "data.formData.NoOfCases"
    }
  },
  {
    "key": {
      "my": {
        "key": "parameters.processVariables[]",
        "lodashKey": "data.formData.RiskScore",
        "outputFormat": {
          "keys": {
            "items": [
              {
                "key": "name",
                "value": "RiskScore"
              },
              {
                "key": "value",
                "value": {
                  "key": "data.formData.RiskScore"
                }
              },
              {
                "key": "operator",
                "value": "eq"
              }
            ]
          },
          "type": "object"
        }
      },
      "open": {
        "key": "parameters.processVariables[]",
        "lodashKey": "data.formData.RiskScore",
        "outputFormat": {
          "keys": {
            "items": [
              {
                "key": "name",
                "value": "RiskScore"
              },
              {
                "key": "value",
                "value": {
                  "key": "data.formData.RiskScore"
                }
              },
              {
                "key": "operator",
                "value": "gteq"
              }
            ]
          },
          "type": "object"
        }
      },
      "closed": {
        "key": "parameters.variables[]",
        "lodashKey": "data.formData.RiskScore",
        "outputFormat": {
          "keys": {
            "items": [
              {
                "key": "name",
                "value": "RiskScore"
              },
              {
                "key": "value",
                "value": {
                  "key": "data.formData.RiskScore"
                }
              },
              {
                "key": "operator",
                "value": "eq"
              }
            ]
          },
          "type": "object"
        }
      },
      "myclosed": {
        "key": "parameters.processVariables[]",
        "lodashKey": "data.formData.RiskScore",
        "outputFormat": {
          "keys": {
            "items": [
              {
                "key": "name",
                "value": "RiskScore"
              },
              {
                "key": "value",
                "value": {
                  "key": "data.formData.RiskScore"
                }
              },
              {
                "key": "operator",
                "value": "eq"
              }
            ]
          },
          "type": "object"
        }
      }
    },
    "max": 100,
    "min": 0,
    "name": "RiskScore",
    "type": "number",
    "label": "Risk Score ( >= )"
  },
  {
    "key": {
      "my": {
        "key": "parameters.processVariables[]",
        "lodashKey": "data.formData.Rule",
        "outputFormat": {
          "keys": {
            "items": [
              {
                "key": "name",
                "value": {
                  "key": "data.formData.Rule"
                }
              },
              {
                "key": "value",
                "value": {
                  "key": "data.formData.Rule"
                }
              },
              {
                "key": "operator",
                "value": "eq"
              }
            ]
          },
          "type": "object",
          "arrayKey": true
        }
      },
      "open": {
        "key": "parameters.processVariables[]",
        "lodashKey": "data.formData.Rule",
        "outputFormat": {
          "keys": {
            "items": [
              {
                "key": "name",
                "value": {
                  "key": "data.formData.Rule"
                }
              },
              {
                "key": "value",
                "value": {
                  "key": "data.formData.Rule"
                }
              },
              {
                "key": "operator",
                "value": "eq"
              }
            ]
          },
          "type": "arrayofobjects",
          "arrayKey": true
        }
      },
      "closed": {
        "key": "parameters.variables[]",
        "lodashKey": "data.formData.Rule",
        "outputFormat": {
          "keys": {
            "items": [
              {
                "key": "name",
                "value": {
                  "key": "data.formData.Rule"
                }
              },
              {
                "key": "value",
                "value": {
                  "key": "data.formData.Rule"
                }
              },
              {
                "key": "operator",
                "value": "eq"
              }
            ]
          },
          "type": "object",
          "arrayKey": true
        }
      },
      "myclosed": {
        "key": "parameters.processVariables[]",
        "lodashKey": "data.formData.Rule",
        "outputFormat": {
          "keys": {
            "items": [
              {
                "key": "name",
                "value": {
                  "key": "data.formData.Rule"
                }
              },
              {
                "key": "value",
                "value": {
                  "key": "data.formData.Rule"
                }
              },
              {
                "key": "operator",
                "value": "eq"
              }
            ]
          },
          "type": "object",
          "arrayKey": true
        }
      }
    },
    "name": "Rule",
    "type": "multiSelect",
    "label": "Rule",
    "options": {
      "jsonLogic": {
        "var": "data.indexHttpData.apiOptions.ruleOptions"
      }
    },
    "apiOptions": {
      "url": "/api/v1/case-management/tasks/get-rules-dropdown/Tasks/tenant-id/${tenantId}",
      "body": {
        "keys": [
          {
            "key": "maxResult",
            "valueKey": "indexLogic.maximumResult.value"
          },
          {
            "key": "parameters",
            "valueKey": "indexLogic?.taskSelect?.value"
          }
        ]
      },
      "RequestType": "GET",
      "paramValues": [
        {
          "key": "data.formData.TenantId[0]"
        }
      ],
      "responseKey": "ruleOptions"
    },
    "keyToExtract": "value"
  },
  {
    "key": {
      "my": {
        "key": "parameters.processVariables[]",
        "lodashKey": "data.formData.TransactionClass",
        "outputFormat": {
          "keys": {
            "items": [
              {
                "key": "name",
                "value": "TransactionClass"
              },
              {
                "key": "value",
                "value": {
                  "key": "data.formData.TransactionClass"
                }
              },
              {
                "key": "operator",
                "value": "eq"
              }
            ]
          },
          "type": "object"
        }
      },
      "open": {
        "key": "parameters.processVariables[]",
        "lodashKey": "data.formData.TransactionClass",
        "outputFormat": {
          "keys": {
            "items": [
              {
                "key": "name",
                "value": "TransactionClass"
              },
              {
                "key": "value",
                "value": {
                  "key": "data.formData.TransactionClass"
                }
              },
              {
                "key": "operator",
                "value": "eq"
              }
            ]
          },
          "type": "object"
        }
      },
      "closed": {
        "key": "parameters.variables[]",
        "lodashKey": "data.formData.TransactionClass",
        "outputFormat": {
          "keys": {
            "items": [
              {
                "key": "name",
                "value": "TransactionClass"
              },
              {
                "key": "value",
                "value": {
                  "key": "data.formData.TransactionClass"
                }
              },
              {
                "key": "operator",
                "value": "eq"
              }
            ]
          },
          "type": "object"
        }
      },
      "myclosed": {
        "key": "parameters.processVariables[]",
        "lodashKey": "data.formData.TransactionClass",
        "outputFormat": {
          "keys": {
            "items": [
              {
                "key": "name",
                "value": "TransactionClass"
              },
              {
                "key": "value",
                "value": {
                  "key": "data.formData.TransactionClass"
                }
              },
              {
                "key": "operator",
                "value": "eq"
              }
            ]
          },
          "type": "object"
        }
      }
    },
    "name": "TransactionClass",
    "type": "select",
    "label": "Transaction Class",
    "options": {
      "jsonLogic": {
        "var": "data.indexHttpData.apiOptions.classDropDownOption.dropDownOptions"
      }
    },
    "apiOptions": {
      "url": "/api/v1/generic-dashboard/get-transaction-classes/Tasks/tenant-id/${tenant}",
      "RequestType": "GET",
      "paramValues": [
        {
          "key": "data.formData.TenantId[0]"
        }
      ],
      "responseKey": "classDropDownOption"
    },
    "isClearable": true
  }
]'::jsonb WHERE
workflowid = 18 AND itenantid in (14, 15);


UPDATE ui.workflowmasters SET
displayconfig = '[ 
  {
    "type": "sortingOptions",
    "render": false,
    "options": [
      {
        "key": "parameters.sorting[]",
        "value": "Created Date",
        "bodyValue": {
          "my": {
            "key": "sortBy",
            "value": "starttime"
          },
          "open": {
            "key": "sortBy",
            "value": "starttime"
          },
          "closed": {
            "key": "sortBy",
            "value": "starttime"
          },
          "myclosed": {
            "key": "sortBy",
            "value": "starttime"
          }
        },
        "compareValue": {
          "value": {
            "jsonLogic": {
              "var": "data.leftPanelLogic.sortBy.value"
            }
          }
        },
        "finalbodyvalue": {
          "keysToSet": [
            {
              "name": "sortBy",
              "value": "created",
              "setKeyIf": {
                "or": [
                  {
                    "if": [
                      {
                        "==": [
                          {
                            "var": "data.indexLogic.taskSelect.label"
                          },
                          "Open"
                        ]
                      },
                      true,
                      false
                    ]
                  },
                  {
                    "if": [
                      {
                        "==": [
                          {
                            "var": "data.indexLogic.taskSelect.label"
                          },
                          "My"
                        ]
                      },
                      true,
                      false
                    ]
                  }
                ]
              }
            },
            {
              "name": "sortBy",
              "value": "startTime",
              "setKeyIf": {
                "or": [
                  {
                    "if": [
                      {
                        "==": [
                          {
                            "var": "data.indexLogic.taskSelect.label"
                          },
                          "Closed"
                        ]
                      },
                      true,
                      false
                    ]
                  },
                  {
                    "if": [
                      {
                        "==": [
                          {
                            "var": "data.indexLogic.taskSelect.label"
                          },
                          "My Closed"
                        ]
                      },
                      true,
                      false
                    ]
                  }
                ]
              }
            },
            {
              "name": "sortOrder",
              "value": {
                "jsonLogic": {
                  "var": "data.leftPanelLogic.filterSortDir"
                }
              }
            }
          ]
        }
      },
      {
        "key": "parameters.sorting[]",
        "value": "Risk Score",
        "bodyValue": {
          "key": "sortBy",
          "value": "riskscore"
        },
        "compareValue": {
          "value": {
            "jsonLogic": {
              "var": "data.leftPanelLogic.sortBy.value"
            }
          }
        },
        "finalbodyvalue": {
          "keysToSet": [
            {
              "name": "sortBy",
              "value": "processVariable",
              "setKeyIf": {
                "and": [
                  {
                    "if": [
                      {
                        "!=": [
                          {
                            "var": "data.indexLogic.taskSelect.label"
                          },
                          "Closed"
                        ]
                      },
                      true,
                      false
                    ]
                  },
                  {
                    "if": [
                      {
                        "!=": [
                          {
                            "var": "data.indexLogic.taskSelect.label"
                          },
                          "My Closed"
                        ]
                      },
                      true,
                      false
                    ]
                  }
                ]
              }
            },
            {
              "name": "sortOrder",
              "value": {
                "jsonLogic": {
                  "var": "data.leftPanelLogic.filterSortDir"
                }
              },
              "setKeyIf": {
                "and": [
                  {
                    "if": [
                      {
                        "!=": [
                          {
                            "var": "data.indexLogic.taskSelect.label"
                          },
                          "Closed"
                        ]
                      },
                      true,
                      false
                    ]
                  },
                  {
                    "if": [
                      {
                        "!=": [
                          {
                            "var": "data.indexLogic.taskSelect.label"
                          },
                          "My Closed"
                        ]
                      },
                      true,
                      false
                    ]
                  }
                ]
              }
            },
            {
              "name": "parameters",
              "value": {
                "type": "long",
                "variable": "RiskScore"
              },
              "setKeyIf": {
                "and": [
                  {
                    "if": [
                      {
                        "!=": [
                          {
                            "var": "data.indexLogic.taskSelect.label"
                          },
                          "Closed"
                        ]
                      },
                      true,
                      false
                    ]
                  },
                  {
                    "if": [
                      {
                        "!=": [
                          {
                            "var": "data.indexLogic.taskSelect.label"
                          },
                          "My Closed"
                        ]
                      },
                      true,
                      false
                    ]
                  }
                ]
              }
            }
          ]
        }
      },
      {
        "key": "parameters.sorting[]",
        "value": "Transaction Amount",
        "bodyValue": {
          "key": "sortBy",
          "value": "amount"
        },
        "compareValue": {
          "value": {
            "jsonLogic": {
              "var": "data.leftPanelLogic.sortBy.value"
            }
          }
        },
        "finalbodyvalue": {
          "keysToSet": [
            {
              "name": "sortBy",
              "value": "processVariable",
              "setKeyIf": {
                "and": [
                  {
                    "if": [
                      {
                        "!=": [
                          {
                            "var": "data.indexLogic.taskSelect.label"
                          },
                          "Closed"
                        ]
                      },
                      true,
                      false
                    ]
                  },
                  {
                    "if": [
                      {
                        "!=": [
                          {
                            "var": "data.indexLogic.taskSelect.label"
                          },
                          "My Closed"
                        ]
                      },
                      true,
                      false
                    ]
                  }
                ]
              }
            },
            {
              "name": "sortOrder",
              "value": {
                "jsonLogic": {
                  "var": "data.leftPanelLogic.filterSortDir"
                }
              },
              "setKeyIf": {
                "and": [
                  {
                    "if": [
                      {
                        "!=": [
                          {
                            "var": "data.indexLogic.taskSelect.label"
                          },
                          "Closed"
                        ]
                      },
                      true,
                      false
                    ]
                  },
                  {
                    "if": [
                      {
                        "!=": [
                          {
                            "var": "data.indexLogic.taskSelect.label"
                          },
                          "My Closed"
                        ]
                      },
                      true,
                      false
                    ]
                  }
                ]
              }
            },
            {
              "name": "parameters",
              "value": {
                "type": "double",
                "variable": "TransactionAmount"
              },
              "setKeyIf": {
                "and": [
                  {
                    "if": [
                      {
                        "!=": [
                          {
                            "var": "data.indexLogic.taskSelect.label"
                          },
                          "Closed"
                        ]
                      },
                      true,
                      false
                    ]
                  },
                  {
                    "if": [
                      {
                        "!=": [
                          {
                            "var": "data.indexLogic.taskSelect.label"
                          },
                          "My Closed"
                        ]
                      },
                      true,
                      false
                    ]
                  }
                ]
              }
            }
          ]
        }
      }
    ],
    "compareValue": true
  },
  {
    "key": "parameters.tenantIdIn",
    "name": "TenantId",
    "type": "multiSelect",
    "label": "Tenant",
    "value": {
      "jsonLogic": {
        "var": "data.formData.TenantId"
      }
    },
    "keyType": "array",
    "options": {
      "jsonLogic": {
        "var": "data.indexHttpData.tenantOptions"
      }
    },
    "defaultValue": {
      "setDefaultValueIf": [
        {
          "key": "data.formData.TenantId",
          "TRUE": {
            "key": "data.formData.TenantId",
            "type": "array"
          },
          "gteq": 1,
          "FALSE": {
            "key": "data.indexHttpData.tenantOptions",
            "map": "itenantId",
            "type": "array"
          },
          "action": "checkLength"
        }
      ]
    },
    "keyToExtract": "itenantId",
    "maxSelectable": 1,
    "onChangeAction": [
      {
        "key": "callApi",
        "body": [
          {
            "PARSEINT": true,
            "lodashKey": "data.formData.TenantId",
            "bodyKeyName": "tenants"
          }
        ],
        "route": "/api/v1/admin/app-users/get-all-workflows/${menuName}",
        "RequestType": "POST",
        "paramValues": [
          {
            "value": "Tasks"
          }
        ],
        "onApiSuccess": [
          {
            "key": "setIndexHttpData",
            "keyToSet": "workFlowNamesDrop"
          }
        ],
        "beforeCallAction": [
          {
            "key": "resetFormDataAll"
          },
          {
            "key": "resetIndexHttpDataKey",
            "keyToReset": "filter.inputJson"
          },
          {
            "key": "resetIndexHttpDataKey",
            "keyToReset": "apiOptions"
          }
        ]
      }
    ]
  },
  {
    "key": {
      "value": "parameters.processDefinitionKeyIn",
      "closed": {
        "key": "parameters.orQueries",
        "outputFormat": {
          "keys": {
            "items": [
              {
                "key": "name",
                "value": "WorkflowName"
              },
              {
                "key": "value",
                "value": {
                  "key": "value",
                  "keyToExtract": "label"
                }
              },
              {
                "key": "operator",
                "value": "eq"
              }
            ]
          },
          "type": "arrayofobjects",
          "value": {
            "jsonLogic": {
              "var": "data.indexHttpData.workFlowNamesDrop"
            },
            "keyToCheck": "workflowKey",
            "compareWith": "data.newValue",
            "keyToExtract": "label"
          }
        }
      },
      "myclosed": {
        "key": "parameters.orQueries[].processVariables",
        "outputFormat": {
          "keys": {
            "items": [
              {
                "key": "name",
                "value": "WorkflowName"
              },
              {
                "key": "value",
                "value": {
                  "key": "value",
                  "keyToExtract": "label"
                }
              },
              {
                "key": "operator",
                "value": "eq"
              }
            ]
          },
          "type": "arrayofobjects",
          "value": {
            "jsonLogic": {
              "var": "data.indexHttpData.workFlowNamesDrop"
            },
            "keyToCheck": "workflowKey",
            "compareWith": "data.newValue",
            "keyToExtract": "label"
          }
        }
      }
    },
    "name": "CaseType",
    "type": "multiSelect",
    "label": "Case Type",
    "value": {
      "jsonLogic": {
        "var": "data.formData.CaseType"
      }
    },
    "keyType": "array",
    "options": {
      "jsonLogic": {
        "var": "data.indexHttpData.workFlowNamesDrop"
      }
    },
    "bodyValue": {
      "key": "defKey",
      "jsonLogic": {
        "var": "data.formData.CaseType"
      }
    },
    "defaultValue": {
      "setDefaultValueIf": [
        {
          "key": "data.formData.CaseType",
          "TRUE": {
            "key": "data.formData.CaseType",
            "type": "array"
          },
          "gteq": 1,
          "FALSE": {
            "key": "data.indexHttpData.workFlowNamesDrop",
            "map": "workflowKey",
            "type": "array"
          },
          "action": "checkLength"
        }
      ]
    },
    "keyToExtract": "workflowKey",
    "maxSelectable": 1,
    "onChangeAction": [
      {
        "key": "callApi",
        "route": "/api/v1/task/filter/config/${paramOne}/${paramTwo}",
        "RequestType": "GET",
        "paramValues": [
          {
            "key": "data.formData.TenantId[0]"
          },
          {
            "key": "data.formData.CaseType[0]",
            "paramValueHardCode": "workflowid"
          }
        ],
        "onApiSuccess": [
          {
            "key": "setIndexHttpData",
            "keyToSet": "filter.inputJson"
          }
        ],
        "beforeCallAction": [
          {
            "key": "resetFormDataWorkflow"
          },
          {
            "key": "resetIndexHttpDataKey",
            "keyToReset": "filter.inputJson"
          },
          {
            "key": "resetIndexHttpDataKey",
            "keyToReset": "apiOptions"
          }
        ]
      }
    ]
  },
  {
    "key": {
      "my": {
        "key": "parameters.createdAfter,parameters.createdBefore",
        "lodashKey": "data.formData.startDate,data.formData.endDate"
      },
      "open": {
        "key": "parameters.createdAfter,parameters.createdBefore",
        "lodashKey": "data.formData.startDate,data.formData.endDate"
      },
      "closed": {
        "key": "parameters.startedAfter,parameters.finsihedBefore",
        "lodashKey": "data.formData.startDate,data.formData.endDate"
      },
      "myclosed": {
        "key": "parameters.startedAfter,parameters.finsihedBefore",
        "lodashKey": "data.formData.startDate,data.formData.endDate"
      }
    },
    "name": "startDate,endDate,startedAfter,finsihedBefore",
    "type": "dateRange",
    "label": "Date Range",
    "valueKey": "dataRangeValueKey",
    "bodyValue": {
      "key": "startDate,endDate,startedAfter,finsihedBefore",
      "lodashKey": "data.formData.startDate,data.formData.endDate,data.formData.startDate,data.formData.endDate"
    },
    "multipleKeyName": "[0],[1],[0],[1]"
  },
  {
    "key": {
      "value": "parameters.taskDefinitionKeyIn",
      "lodashKey": "data.formData.Status"
    },
    "name": "Status",
    "type": "multiSelect",
    "label": "Status",
    "options": {
      "jsonLogic": {
        "var": "data.indexHttpData.apiOptions.statusOptions"
      }
    },
    "apiOptions": {
      "url": "/api/v1/case-management/tasks/get-status/tenant-id/${tenantid}/workflow-key/${workflowKey}",
      "body": {
        "keys": [
          {
            "key": "maxResult",
            "valueKey": "indexLogic.maximumResult.value"
          },
          {
            "key": "parameters",
            "valueKey": "indexLogic?.taskSelect?.value"
          }
        ]
      },
      "RequestType": "POST",
      "paramValues": [
        {
          "key": "data.formData.TenantId[0]"
        },
        {
          "key": "data.formData.CaseType[0]"
        }
      ],
      "responseKey": "statusOptions"
    },
    "isClearable": true,
    "keyToExtract": "value"
  },
  {
    "key": {
      "my": {
        "key": "parameters.processVariables[]",
        "lodashKey": "data.formData.TransactionAmount",
        "outputFormat": {
          "keys": {
            "items": [
              {
                "key": "name",
                "value": "TransactionAmount"
              },
              {
                "key": "value",
                "value": {
                  "key": "data.formData.TransactionAmount",
                  "finalbodyMultiplier": 100
                }
              },
              {
                "key": "operator",
                "value": {
                  "key": "data.formData.TransactionAmountCompareOperator"
                }
              }
            ],
            "setKeyIf": {
              "and": [
                {
                  "if": [
                    {
                      "!=": [
                        {
                          "var": "data.formData.TransactionAmountCompareOperator"
                        },
                        null
                      ]
                    },
                    true,
                    false
                  ]
                }
              ]
            }
          },
          "type": "object"
        }
      },
      "open": {
        "key": "parameters.processVariables[]",
        "lodashKey": "data.formData.TransactionAmount",
        "outputFormat": {
          "keys": {
            "items": [
              {
                "key": "name",
                "value": "TransactionAmount"
              },
              {
                "key": "value",
                "value": {
                  "key": "data.formData.TransactionAmount",
                  "finalbodyMultiplier": 100
                }
              },
              {
                "key": "operator",
                "value": {
                  "key": "data.formData.TransactionAmountCompareOperator"
                }
              }
            ],
            "setKeyIf": {
              "and": [
                {
                  "if": [
                    {
                      "!=": [
                        {
                          "var": "data.formData.TransactionAmountCompareOperator"
                        },
                        null
                      ]
                    },
                    true,
                    false
                  ]
                }
              ]
            }
          },
          "type": "object"
        }
      },
      "closed": {
        "key": "parameters.variables[]",
        "lodashKey": "data.formData.TransactionAmount",
        "outputFormat": {
          "keys": {
            "items": [
              {
                "key": "name",
                "value": "TransactionAmount"
              },
              {
                "key": "value",
                "value": {
                  "key": "data.formData.TransactionAmount",
                  "finalbodyMultiplier": 100
                }
              },
              {
                "key": "operator",
                "value": {
                  "key": "data.formData.TransactionAmountCompareOperator"
                }
              }
            ],
            "setKeyIf": {
              "and": [
                {
                  "if": [
                    {
                      "!=": [
                        {
                          "var": "data.formData.TransactionAmountCompareOperator"
                        },
                        null
                      ]
                    },
                    true,
                    false
                  ]
                }
              ]
            }
          },
          "type": "object"
        }
      },
      "myclosed": {
        "key": "parameters.processVariables[]",
        "lodashKey": "data.formData.TransactionAmount",
        "outputFormat": {
          "keys": {
            "items": [
              {
                "key": "name",
                "value": "TransactionAmount"
              },
              {
                "key": "value",
                "value": {
                  "key": "data.formData.TransactionAmount",
                  "finalbodyMultiplier": 100
                }
              },
              {
                "key": "operator",
                "value": {
                  "key": "data.formData.TransactionAmountCompareOperator"
                }
              }
            ],
            "setKeyIf": {
              "and": [
                {
                  "if": [
                    {
                      "!=": [
                        {
                          "var": "data.formData.TransactionAmountCompareOperator"
                        },
                        null
                      ]
                    },
                    true,
                    false
                  ]
                }
              ]
            }
          },
          "type": "object"
        }
      }
    },
    "min": 0,
    "name": "TransactionAmount",
    "type": "number",
    "label": "Transaction Amount",
    "compareOperator": {
      "name": "TransactionAmountCompareOperator",
      "type": "select",
      "options": [
        {
          "label": "=",
          "value": "eq"
        },
        {
          "label": "<",
          "value": "lt"
        },
        {
          "label": ">",
          "value": "gt"
        }
      ]
    }
  },
  {
    "key": {
      "my": {
        "key": "parameters.processVariables[]",
        "lodashKey": "data.formData.LevelType",
        "outputFormat": {
          "keys": {
            "items": [
              {
                "key": "name",
                "value": {
                  "key": "data.formData.LevelType"
                }
              },
              {
                "key": "value",
                "value": {
                  "key": "data.formData.Address"
                }
              },
              {
                "key": "operator",
                "value": "eq"
              }
            ],
            "setKeyIf": {
              "and": [
                {
                  "if": [
                    {
                      "!=": [
                        {
                          "var": "data.formData.Address"
                        },
                        null
                      ]
                    },
                    {
                      "!=": [
                        {
                          "var": "data.formData.Address"
                        },
                        ""
                      ]
                    },
                    true,
                    false
                  ]
                }
              ]
            }
          },
          "type": "object",
          "keys2": {
            "items": [
              {
                "key": "name",
                "value": "basedon"
              },
              {
                "key": "value",
                "value": {
                  "jsonLogic": {
                    "if": [
                      {
                        "and": [
                          {
                            "==": [
                              {
                                "var": "data.formData.levelSelectMain"
                              },
                              "Account"
                            ]
                          }
                        ]
                      },
                      "account",
                      {
                        "and": [
                          {
                            "==": [
                              {
                                "var": "data.formData.levelSelectMain"
                              },
                              "VPA"
                            ]
                          }
                        ]
                      },
                      "vpa",
                      "Invalid input"
                    ]
                  }
                }
              },
              {
                "key": "operator",
                "value": "eq"
              }
            ],
            "setKeyIf": {
              "and": [
                {
                  "if": [
                    {
                      "==": [
                        {
                          "var": "data.formData.typeSelectMain"
                        },
                        "address"
                      ]
                    },
                    true,
                    false
                  ]
                }
              ]
            }
          }
        }
      },
      "open": {
        "key": "parameters.processVariables[]",
        "lodashKey": "data.formData.LevelType",
        "outputFormat": {
          "keys": {
            "items": [
              {
                "key": "name",
                "value": {
                  "key": "data.formData.LevelType"
                }
              },
              {
                "key": "value",
                "value": {
                  "key": "data.formData.Address"
                }
              },
              {
                "key": "operator",
                "value": "eq"
              }
            ],
            "setKeyIf": {
              "and": [
                {
                  "if": [
                    {
                      "!=": [
                        {
                          "var": "data.formData.Address"
                        },
                        null
                      ]
                    },
                    {
                      "!=": [
                        {
                          "var": "data.formData.Address"
                        },
                        ""
                      ]
                    },
                    true,
                    false
                  ]
                }
              ]
            }
          },
          "type": "object",
          "keys2": {
            "items": [
              {
                "key": "name",
                "value": "basedon"
              },
              {
                "key": "value",
                "value": {
                  "jsonLogic": {
                    "if": [
                      {
                        "and": [
                          {
                            "==": [
                              {
                                "var": "data.formData.levelSelectMain"
                              },
                              "Account"
                            ]
                          }
                        ]
                      },
                      "account",
                      {
                        "and": [
                          {
                            "==": [
                              {
                                "var": "data.formData.levelSelectMain"
                              },
                              "VPA"
                            ]
                          }
                        ]
                      },
                      "vpa",
                      "Invalid input"
                    ]
                  }
                }
              },
              {
                "key": "operator",
                "value": "eq"
              }
            ],
            "setKeyIf": {
              "and": [
                {
                  "if": [
                    {
                      "==": [
                        {
                          "var": "data.formData.typeSelectMain"
                        },
                        "address"
                      ]
                    },
                    true,
                    false
                  ]
                }
              ]
            }
          }
        }
      },
      "closed": {
        "key": "parameters.variables[]",
        "lodashKey": "data.formData.LevelType",
        "outputFormat": {
          "keys": {
            "items": [
              {
                "key": "name",
                "value": {
                  "key": "data.formData.LevelType"
                }
              },
              {
                "key": "value",
                "value": {
                  "key": "data.formData.Address"
                }
              },
              {
                "key": "operator",
                "value": "eq"
              }
            ]
          },
          "type": "object",
          "keys2": {
            "items": [
              {
                "key": "name",
                "value": "basedon"
              },
              {
                "key": "value",
                "value": {
                  "jsonLogic": {
                    "if": [
                      {
                        "and": [
                          {
                            "==": [
                              {
                                "var": "data.formData.levelSelectMain"
                              },
                              "Account"
                            ]
                          }
                        ]
                      },
                      "account",
                      {
                        "and": [
                          {
                            "==": [
                              {
                                "var": "data.formData.levelSelectMain"
                              },
                              "VPA"
                            ]
                          }
                        ]
                      },
                      "vpa",
                      "Invalid input"
                    ]
                  }
                }
              },
              {
                "key": "operator",
                "value": "eq"
              }
            ],
            "setKeyIf": {
              "and": [
                {
                  "if": [
                    {
                      "==": [
                        {
                          "var": "data.formData.typeSelectMain"
                        },
                        "address"
                      ]
                    },
                    true,
                    false
                  ]
                }
              ]
            }
          },
          "setKeyIf": {
            "and": [
              {
                "if": [
                  {
                    "!=": [
                      {
                        "var": "data.formData.Address"
                      },
                      null
                    ]
                  },
                  {
                    "!=": [
                      {
                        "var": "data.formData.Address"
                      },
                      ""
                    ]
                  },
                  true,
                  false
                ]
              }
            ]
          }
        }
      },
      "myclosed": {
        "key": "parameters.processVariables[]",
        "lodashKey": "data.formData.LevelType",
        "outputFormat": {
          "keys": {
            "items": [
              {
                "key": "name",
                "value": {
                  "key": "data.formData.LevelType"
                }
              },
              {
                "key": "value",
                "value": {
                  "key": "data.formData.Address"
                }
              },
              {
                "key": "operator",
                "value": "eq"
              }
            ],
            "setKeyIf": {
              "and": [
                {
                  "if": [
                    {
                      "!=": [
                        {
                          "var": "data.formData.Address"
                        },
                        null
                      ]
                    },
                    {
                      "!=": [
                        {
                          "var": "data.formData.Address"
                        },
                        ""
                      ]
                    },
                    true,
                    false
                  ]
                }
              ]
            }
          },
          "type": "object",
          "keys2": {
            "items": [
              {
                "key": "name",
                "value": "basedon"
              },
              {
                "key": "value",
                "value": {
                  "jsonLogic": {
                    "if": [
                      {
                        "and": [
                          {
                            "==": [
                              {
                                "var": "data.formData.levelSelectMain"
                              },
                              "Account"
                            ]
                          }
                        ]
                      },
                      "account",
                      {
                        "and": [
                          {
                            "==": [
                              {
                                "var": "data.formData.levelSelectMain"
                              },
                              "VPA"
                            ]
                          }
                        ]
                      },
                      "vpa",
                      "Invalid input"
                    ]
                  }
                }
              },
              {
                "key": "operator",
                "value": "eq"
              }
            ],
            "setKeyIf": {
              "and": [
                {
                  "if": [
                    {
                      "==": [
                        {
                          "var": "data.formData.typeSelectMain"
                        },
                        "address"
                      ]
                    },
                    true,
                    false
                  ]
                }
              ]
            }
          }
        }
      }
    },
    "name": "LevelType",
    "type": "object",
    "fields": [
      {
        "name": "levelSelectMain",
        "type": "select",
        "label": "Level",
        "options": [
          {
            "label": "Account",
            "value": "Account"
          },
          {
            "label": "VPA",
            "value": "VPA"
          }
        ],
        "onChangeAction": [
          {
            "key": "setOtherKey",
            "keyToSet": "LevelType",
            "keyValue": {
              "jsonLogic": {
                "if": [
                  {
                    "and": [
                      {
                        "==": [
                          {
                            "var": "data.formData.levelSelectMain"
                          },
                          "Account"
                        ]
                      },
                      {
                        "==": [
                          {
                            "var": "data.formData.typeSelectMain"
                          },
                          "Payer"
                        ]
                      }
                    ]
                  },
                  "payerAccount",
                  {
                    "and": [
                      {
                        "==": [
                          {
                            "var": "data.formData.levelSelectMain"
                          },
                          "Account"
                        ]
                      },
                      {
                        "==": [
                          {
                            "var": "data.formData.typeSelectMain"
                          },
                          "Payee"
                        ]
                      }
                    ]
                  },
                  "payeeAccount",
                  {
                    "and": [
                      {
                        "==": [
                          {
                            "var": "data.formData.levelSelectMain"
                          },
                          "VPA"
                        ]
                      },
                      {
                        "==": [
                          {
                            "var": "data.formData.typeSelectMain"
                          },
                          "Payer"
                        ]
                      }
                    ]
                  },
                  "payer",
                  {
                    "and": [
                      {
                        "==": [
                          {
                            "var": "data.formData.levelSelectMain"
                          },
                          "VPA"
                        ]
                      },
                      {
                        "==": [
                          {
                            "var": "data.formData.typeSelectMain"
                          },
                          "Payee"
                        ]
                      }
                    ]
                  },
                  "payee",
                  "address"
                ]
              }
            }
          }
        ]
      },
      {
        "name": "typeSelectMain",
        "type": "select",
        "label": "Type",
        "options": [
          {
            "label": "Payer",
            "value": "Payer"
          },
          {
            "label": "Payee",
            "value": "Payee"
          },
          {
            "label": "Profile",
            "value": "address"
          }
        ],
        "onChangeAction": [
          {
            "key": "setOtherKey",
            "keyToSet": "LevelType",
            "keyValue": {
              "jsonLogic": {
                "if": [
                  {
                    "and": [
                      {
                        "==": [
                          {
                            "var": "data.formData.levelSelectMain"
                          },
                          "Account"
                        ]
                      },
                      {
                        "==": [
                          {
                            "var": "data.formData.typeSelectMain"
                          },
                          "Payer"
                        ]
                      }
                    ]
                  },
                  "payerAccount",
                  {
                    "and": [
                      {
                        "==": [
                          {
                            "var": "data.formData.levelSelectMain"
                          },
                          "Account"
                        ]
                      },
                      {
                        "==": [
                          {
                            "var": "data.formData.typeSelectMain"
                          },
                          "Payee"
                        ]
                      }
                    ]
                  },
                  "payeeAccount",
                  {
                    "and": [
                      {
                        "==": [
                          {
                            "var": "data.formData.levelSelectMain"
                          },
                          "VPA"
                        ]
                      },
                      {
                        "==": [
                          {
                            "var": "data.formData.typeSelectMain"
                          },
                          "Payer"
                        ]
                      }
                    ]
                  },
                  "payer",
                  {
                    "and": [
                      {
                        "==": [
                          {
                            "var": "data.formData.levelSelectMain"
                          },
                          "VPA"
                        ]
                      },
                      {
                        "==": [
                          {
                            "var": "data.formData.typeSelectMain"
                          },
                          "Payee"
                        ]
                      }
                    ]
                  },
                  "payee",
                  "address"
                ]
              }
            }
          }
        ]
      }
    ]
  },
  {
    "name": "Address",
    "type": "text",
    "label": "Address"
  },
  {
    "name": "NoOfCases",
    "type": "select",
    "label": "No Of Cases",
    "options": [
      {
        "label": "20",
        "value": 20
      },
      {
        "label": "30",
        "value": 30
      },
      {
        "label": "50",
        "value": 50
      }
    ],
    "bodyValue": {
      "key": "maxResult",
      "lodashKey": "data.formData.NoOfCases"
    }
  },
  {
    "key": {
      "my": {
        "key": "parameters.processVariables[]",
        "lodashKey": "data.formData.RiskScore",
        "outputFormat": {
          "keys": {
            "items": [
              {
                "key": "name",
                "value": "RiskScore"
              },
              {
                "key": "value",
                "value": {
                  "key": "data.formData.RiskScore"
                }
              },
              {
                "key": "operator",
                "value": "eq"
              }
            ]
          },
          "type": "object"
        }
      },
      "open": {
        "key": "parameters.processVariables[]",
        "lodashKey": "data.formData.RiskScore",
        "outputFormat": {
          "keys": {
            "items": [
              {
                "key": "name",
                "value": "RiskScore"
              },
              {
                "key": "value",
                "value": {
                  "key": "data.formData.RiskScore"
                }
              },
              {
                "key": "operator",
                "value": "gteq"
              }
            ]
          },
          "type": "object"
        }
      },
      "closed": {
        "key": "parameters.variables[]",
        "lodashKey": "data.formData.RiskScore",
        "outputFormat": {
          "keys": {
            "items": [
              {
                "key": "name",
                "value": "RiskScore"
              },
              {
                "key": "value",
                "value": {
                  "key": "data.formData.RiskScore"
                }
              },
              {
                "key": "operator",
                "value": "eq"
              }
            ]
          },
          "type": "object"
        }
      },
      "myclosed": {
        "key": "parameters.processVariables[]",
        "lodashKey": "data.formData.RiskScore",
        "outputFormat": {
          "keys": {
            "items": [
              {
                "key": "name",
                "value": "RiskScore"
              },
              {
                "key": "value",
                "value": {
                  "key": "data.formData.RiskScore"
                }
              },
              {
                "key": "operator",
                "value": "eq"
              }
            ]
          },
          "type": "object"
        }
      }
    },
    "max": 100,
    "min": 0,
    "name": "RiskScore",
    "type": "number",
    "label": "Risk Score ( >= )"
  },
  {
    "key": {
      "my": {
        "key": "parameters.processVariables[]",
        "lodashKey": "data.formData.Rule",
        "outputFormat": {
          "keys": {
            "items": [
              {
                "key": "name",
                "value": {
                  "key": "data.formData.Rule"
                }
              },
              {
                "key": "value",
                "value": {
                  "key": "data.formData.Rule"
                }
              },
              {
                "key": "operator",
                "value": "eq"
              }
            ]
          },
          "type": "object",
          "arrayKey": true
        }
      },
      "open": {
        "key": "parameters.processVariables[]",
        "lodashKey": "data.formData.Rule",
        "outputFormat": {
          "keys": {
            "items": [
              {
                "key": "name",
                "value": {
                  "key": "data.formData.Rule"
                }
              },
              {
                "key": "value",
                "value": {
                  "key": "data.formData.Rule"
                }
              },
              {
                "key": "operator",
                "value": "eq"
              }
            ]
          },
          "type": "arrayofobjects",
          "arrayKey": true
        }
      },
      "closed": {
        "key": "parameters.variables[]",
        "lodashKey": "data.formData.Rule",
        "outputFormat": {
          "keys": {
            "items": [
              {
                "key": "name",
                "value": {
                  "key": "data.formData.Rule"
                }
              },
              {
                "key": "value",
                "value": {
                  "key": "data.formData.Rule"
                }
              },
              {
                "key": "operator",
                "value": "eq"
              }
            ]
          },
          "type": "object",
          "arrayKey": true
        }
      },
      "myclosed": {
        "key": "parameters.processVariables[]",
        "lodashKey": "data.formData.Rule",
        "outputFormat": {
          "keys": {
            "items": [
              {
                "key": "name",
                "value": {
                  "key": "data.formData.Rule"
                }
              },
              {
                "key": "value",
                "value": {
                  "key": "data.formData.Rule"
                }
              },
              {
                "key": "operator",
                "value": "eq"
              }
            ]
          },
          "type": "object",
          "arrayKey": true
        }
      }
    },
    "name": "Rule",
    "type": "multiSelect",
    "label": "Rule",
    "options": {
      "jsonLogic": {
        "var": "data.indexHttpData.apiOptions.ruleOptions"
      }
    },
    "apiOptions": {
      "url": "/api/v1/case-management/tasks/get-rules-dropdown/Tasks/tenant-id/${tenantId}",
      "body": {
        "keys": [
          {
            "key": "maxResult",
            "valueKey": "indexLogic.maximumResult.value"
          },
          {
            "key": "parameters",
            "valueKey": "indexLogic?.taskSelect?.value"
          }
        ]
      },
      "RequestType": "GET",
      "paramValues": [
        {
          "key": "data.formData.TenantId[0]"
        }
      ],
      "responseKey": "ruleOptions"
    },
    "keyToExtract": "value"
  },
  {
    "key": {
      "my": {
        "key": "parameters.processVariables[]",
        "lodashKey": "data.formData.TransactionClass",
        "outputFormat": {
          "keys": {
            "items": [
              {
                "key": "name",
                "value": "TransactionClass"
              },
              {
                "key": "value",
                "value": {
                  "key": "data.formData.TransactionClass"
                }
              },
              {
                "key": "operator",
                "value": "eq"
              }
            ]
          },
          "type": "object"
        }
      },
      "open": {
        "key": "parameters.processVariables[]",
        "lodashKey": "data.formData.TransactionClass",
        "outputFormat": {
          "keys": {
            "items": [
              {
                "key": "name",
                "value": "TransactionClass"
              },
              {
                "key": "value",
                "value": {
                  "key": "data.formData.TransactionClass"
                }
              },
              {
                "key": "operator",
                "value": "eq"
              }
            ]
          },
          "type": "object"
        }
      },
      "closed": {
        "key": "parameters.variables[]",
        "lodashKey": "data.formData.TransactionClass",
        "outputFormat": {
          "keys": {
            "items": [
              {
                "key": "name",
                "value": "TransactionClass"
              },
              {
                "key": "value",
                "value": {
                  "key": "data.formData.TransactionClass"
                }
              },
              {
                "key": "operator",
                "value": "eq"
              }
            ]
          },
          "type": "object"
        }
      },
      "myclosed": {
        "key": "parameters.processVariables[]",
        "lodashKey": "data.formData.TransactionClass",
        "outputFormat": {
          "keys": {
            "items": [
              {
                "key": "name",
                "value": "TransactionClass"
              },
              {
                "key": "value",
                "value": {
                  "key": "data.formData.TransactionClass"
                }
              },
              {
                "key": "operator",
                "value": "eq"
              }
            ]
          },
          "type": "object"
        }
      }
    },
    "name": "TransactionClass",
    "type": "select",
    "label": "Transaction Class",
    "options": {
      "jsonLogic": {
        "var": "data.indexHttpData.apiOptions.classDropDownOption.dropDownOptions"
      }
    },
    "apiOptions": {
      "url": "/api/v1/generic-dashboard/get-transaction-classes/Tasks/tenant-id/${tenant}",
      "RequestType": "GET",
      "paramValues": [
        {
          "key": "data.formData.TenantId[0]"
        }
      ],
      "responseKey": "classDropDownOption"
    },
    "isClearable": true
  }
]'::jsonb WHERE
workflowid = 20 AND itenantid in (14, 15);  