UPDATE ui.dashboardquery SET vcdashboardquery='{
	"Account":"select iaccountid, icustomerid, vcexternalaccountid, iaccounttypeid, vcifsc, vcaccountproviderid, vcaccountname, dtonboardingdate, dtexpirydate, imcc, bmerchant, bverified, irecordstatus, dtentrydatetime, vcattribs->>''reg_address'' as \"reg_address\", vcattribs->>''postal_code'' as \"postal_code\", vcattribs->>''merchant_type'' as \"merchant_type\", vcattribs->>''registered_mobile'' as \"registered_mobile\", vcattribs->>''email'' as \"email\" from masters.accounts :AttribsForm order by iaccountid desc limit 50000",
	"VPA": "select ivpaid, iaccountid, vcexternaladdressid, vcaddress, iproductid, vcvpaname, bverified, imcc, dtonboardingdate, dtexpirydate, bmerchant, ivpaproviderid, bprofiled, dtfirsttransaction, dtlasttransaction, irecordstatus, dtentrydatetime from masters.vpa order by ivpaid desc limit 50000",
	"Customer": "SELECT icustomerid, vcexternalcustid, vccustomername, vccustomertype, vcsalutation, vcverifiedname, vcgender, dtdoidob, dtonboardingdate, vcpostalcode, vcemail, vcregisteredmobile, imcc, vcidentitytype1, vcidentitydetails1, vcidentitytype2, vcidentitydetails2, vcregisteredaddressgeolocation, iadm3, iadm2, iadm1, vccountrycode, vcattribs->>''accountaddress'' as \"accountaddress\", vcattribs->>''accountnumber'' as \"accountnumber\", vcattribs->>''ifsccode'' as \"ifscode\", vcattribs->>''bankname'' as \"bankname\", vcattribs->>''settlementmode'' as \"settlementmode\", vcattribs->>''accountonboardingdate'' as \"accountonboardingdate\", vcattribs->>''address'' as \"address\", vcattribs->>''email'' as \"email\", vcattribs->>''postalcode'' as \"postalcode\", vcattribs->>''annualturnover'' as \"annualturnover\", vcattribs->>''registeredmobile'' as \"registeredmobile\", vcattribs->>''merchanttype'' as \"merchanttype\", vcattribs->>''risk'' as \"risk\", irecordstatus, dtentrydatetime FROM masters.customers :AttribsForm order by icustomerid desc limit 50000;"
}'::TEXT, formattingrequiered=false WHERE idashboardqueryid=48;

DELETE FROM ui.masterextractattribs;
INSERT INTO ui.masterextractattribs (attribpath, level, datatype, displayname) VALUES ('vcattribs->>''accountaddress'' ', 'Customer', 'String', 'accountaddress');
INSERT INTO ui.masterextractattribs (attribpath, level, datatype, displayname) VALUES ('vcattribs->>''accountnumber'' ', 'Customer', 'String', 'accountnumber');
INSERT INTO ui.masterextractattribs (attribpath, level, datatype, displayname) VALUES ('vcattribs->>''ifsccode'' ', 'Customer', 'String', 'ifsccode');
INSERT INTO ui.masterextractattribs (attribpath, level, datatype, displayname) VALUES ('vcattribs->>''bankname'' ', 'Customer', 'String', 'bankname');
INSERT INTO ui.masterextractattribs (attribpath, level, datatype, displayname) VALUES ('vcattribs->>''settlementmode'' ', 'Customer', 'String', 'settlementmode');
INSERT INTO ui.masterextractattribs (attribpath, level, datatype, displayname) VALUES ('vcattribs->>''accountonboardingdate'' ', 'Customer', 'String', 'accountonboardingdate');
INSERT INTO ui.masterextractattribs (attribpath, level, datatype, displayname) VALUES ('vcattribs->>''address'' ', 'Customer', 'String', 'address');
INSERT INTO ui.masterextractattribs (attribpath, level, datatype, displayname) VALUES ('vcattribs->>''email'' ', 'Customer', 'String', 'email');
INSERT INTO ui.masterextractattribs (attribpath, level, datatype, displayname) VALUES ('vcattribs->>''postalcode'' ', 'Customer', 'String', 'postalcode');
INSERT INTO ui.masterextractattribs (attribpath, level, datatype, displayname) VALUES ('vcattribs->>''annualturnover'' ', 'Customer', 'String', 'annualturnover');
INSERT INTO ui.masterextractattribs (attribpath, level, datatype, displayname) VALUES ('vcattribs->>''registeredmobile'' ', 'Customer', 'String', 'registeredmobile');
INSERT INTO ui.masterextractattribs (attribpath, level, datatype, displayname) VALUES ('vcattribs->>''merchanttype'' ', 'Customer', 'String', 'merchanttype');

INSERT INTO ui.masterextractattribs (attribpath, level, datatype, displayname) VALUES ('vcattribs->>''reg_address'' ', 'Account', 'String', 'reg_address');
INSERT INTO ui.masterextractattribs (attribpath, level, datatype, displayname) VALUES ('vcattribs->>''postal_code'' ', 'Account', 'String', 'postal_code');
INSERT INTO ui.masterextractattribs (attribpath, level, datatype, displayname) VALUES ('vcattribs->>''merchant_type'' ', 'Account', 'String', 'merchant_type');
INSERT INTO ui.masterextractattribs (attribpath, level, datatype, displayname) VALUES ('vcattribs->>''registered_mobile'' ', 'Account', 'String', 'registered_mobile');
INSERT INTO ui.masterextractattribs (attribpath, level, datatype, displayname) VALUES ('vcattribs->>''email'' ', 'Account', 'String', 'email');



UPDATE ui.dashboardresultset SET
vcdashboardresultsetschema = '{
    "id": "integer",
    "Request ID": "string",
    "Timestamp": "datetime",
    "Remarks": "string",
    "Org": "string",
    "Status": "string",
    "Txn ID": "string",
    "Txn Timestamp": "datetime",
    "Note": "string",
    "Type": "string",
    "Class": "string",
    "Merchant addr": "string",
    "Payee Name": "string",
    "Payee VPA": "string",
    "Account Name": "string",
    "Default MCC": "integer",
    "MCC": "integer",
    "Payee email": "string",
    "Payer": "string",
    "Payer VPA": "string",
    "Payer Name": "string",
    "Payer IP": "string",
    "Txn Score": "string",
    "Txn Amount": "float",
    "Card Country Code": "string",
    "Original Txn ID": "string",
    "Acquirer Name": "string",
    "Currency": "string",
    "Workflow Type": "string",
    "Decision Name": "string",
    "Decision Detail": "string",
    "Is_New_Merchant": "string",
    "Is_New_Payer": "string",
    "Skip Processing": "integer",
    "ip_details.Country": "string",
    "ip_details.PostalCode": "integer",
    "ip_details.City": "string",
    "observations.same_ip_addr_unique_payer_d01_txn_count": "integer",
    "observations.payeeVPA.account.customer.attribs.city": "string",
    "observations.same_payer_payee_acc_d01_txn_count": "integer",
    "observations.same_payer_payee_acc_d01_txn_value": "integer",
    "observations.payer_unique_payee_acc_online_d01_txn_count": "integer",
    "observations.payee_online_intl_card_m30_txn_count": "integer",
    "observations.same_payee_same_amt_online_m15_txn_count": "integer",
    "observations.same_payee_online_m10_gteq250_txn_count": "integer",
    "observations.payee_account_d01_txn_value": "integer",
    "observations.same_payee_acc_PT48H_txn_value": "integer",
    "observations.payee_acc_decline_less5k_m30_txn_count": "integer",
    "observations.same_payee_online_PT24H_txn_value": "integer",
    "observations.same_payer_payee_online_PT5M_txnPay_count": "integer",
    "observations.payer_decline_m30_txn_count": "integer",
    "observations.same_payer_payee_online_d01_txn_count": "integer",
    "observations.same_payer_payee_online_d01_txn_value": "integer"
  }'::text WHERE
idashboardresultsetid = 11;