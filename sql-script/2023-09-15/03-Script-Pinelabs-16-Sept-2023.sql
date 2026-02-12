UPDATE ui.dashboardquery SET vcdashboardquery='{
	"Account":"select iaccountid, icustomerid, vcexternalaccountid, iaccounttypeid, vcifsc, vcaccountproviderid, vcaccountname, dtonboardingdate, dtexpirydate, imcc, bmerchant, bverified, irecordstatus, dtentrydatetime from masters.accounts order by dtentrydatetime desc limit 50000",
	"VPA": "select ivpaid, iaccountid, vcexternaladdressid, vcaddress, iproductid, vcvpaname, bverified, imcc, dtonboardingdate, dtexpirydate, bmerchant, ivpaproviderid, bprofiled, dtfirsttransaction, dtlasttransaction, irecordstatus, dtentrydatetime from masters.vpa order by dtentrydatetime desc limit 50000",
	"Customer": "SELECT icustomerid, vcexternalcustid, vccustomername, vccustomertype, vcsalutation, vcverifiedname, vcgender, dtdoidob, dtonboardingdate, vcpostalcode, vcemail, vcregisteredmobile, imcc, vcidentitytype1, vcidentitydetails1, vcidentitytype2, vcidentitydetails2, vcregisteredaddressgeolocation, iadm3, iadm2, iadm1, vccountrycode, vcattribs->>''accountaddress'' as \"accountaddress\", vcattribs->>''accountnumber'' as \"accountnumber\", vcattribs->>''ifsccode'' as \"ifscode\", vcattribs->>''bankname'' as \"bankname\", vcattribs->>''settlementmode'' as \"settlementmode\", vcattribs->>''accountonboardingdate'' as \"accountonboardingdate\", vcattribs->>''address'' as \"address\", vcattribs->>''email'' as \"email\", vcattribs->>''postalcode'' as \"postalcode\", vcattribs->>''annualturnover'' as \"annualturnover\", vcattribs->>''registeredmobile'' as \"registeredmobile\", vcattribs->>''merchanttype'' as \"merchanttype\", vcattribs->>''risk'' as \"risk\", irecordstatus, dtentrydatetime FROM masters.customers :AttribsForm order by dtentrydatetime desc limit 50000;"
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
INSERT INTO ui.masterextractattribs (attribpath, level, datatype, displayname) VALUES ('vcattribs->>''risk'' ', 'Customer', 'String', 'risk');











