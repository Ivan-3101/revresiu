UPDATE ui.dashboardquery SET
vcdashboardquery = '{
	"Account":"select iaccountid, icustomerid, vcexternalaccountid, iaccounttypeid, vcifsc, vcaccountproviderid, vcaccountname, dtonboardingdate, dtexpirydate, imcc, bmerchant, bverified, irecordstatus, dtentrydatetime from masters.accounts where itenantid = :tenantid order by iaccountid desc limit 50000",
	"VPA":"select ivpaid, iaccountid, vcexternaladdressid, vcaddress, iproductid, vcvpaname, bverified, imcc, dtonboardingdate, dtexpirydate, bmerchant, ivpaproviderid, bprofiled, dtfirsttransaction, dtlasttransaction, irecordstatus, dtentrydatetime from masters.vpa where itenantid = :tenantid order by ivpaid desc limit 50000",
	"Customer": "SELECT icustomerid, vcexternalcustid, vccustomername, vccustomertype, vcsalutation, vcverifiedname, vcgender, dtdoidob, dtonboardingdate, vcpostalcode, vcemail, vcregisteredmobile, imcc, vcidentitytype1, vcidentitydetails1, vcidentitytype2, vcidentitydetails2, vcregisteredaddressgeolocation, iadm3, iadm2, iadm1, vccountrycode, irecordstatus, dtentrydatetime, vcattribs->>''postalcode'' as \"vcpostalcode\", vcattribs->>''date_of_incorporation'' as \"date_of_incorporation\", vcattribs->>''latitude'' as \"latitude\", vcattribs->>''longitude'' as \"longitude\", vcattribs->>''business_division'' as \"business_division\", vcattribs->>''internationalFlagUpdate'' as \"internationalFlagUpdate\", vcattribs->>''mcc_description'' as \"mcc_description\",  vcattribs->>''cumulativeDailyTransactionVolume'' as \"cumulativeDailyTransactionVolume\", vcattribs->>''cumulativeDailyTransactionCount'' as \"cumulativeDailyTransactionCount\", vcattribs->>''cumulativeDailyTransactionExitCount'' as \"cumulativeDailyTransactionExitCount\", vcattribs->>''cumulativeDailyTransactionExitVolume'' as \"cumulativeDailyTransactionExitVolume\", vcattribs->>''cumulativeDailyRefundVolume'' as \"cumulativeDailyRefundVolume\", vcattribs->>''cumulativeDailyRefundCount'' as \"cumulativeDailyRefundCount\", vcattribs->>''merchantType'' as \"merchantType\", vcattribs->>''businessChannel'' as \"businessChannel\", vcattribs->>''groupId'' as \"groupId\", vcattribs->>''subGroupId'' as \"subGroupId\", vcattribs->>''kyc_status'' as \"kyc_status\", vcattribs->>''documentNumber'' as \"documentNumber\", vcattribs->>''ip'' as \"ip\" FROM masters.customers where itenantid = :tenantid :AttribsForm order by icustomerid desc limit 50000;"
}'::text WHERE
idashboardqueryid = 48 AND itenantid = 14;

INSERT INTO ui.masterextractattribs (attribpath, level, datatype, displayname, itenantid) VALUES ('vcattribs->>''postalcode'' ', 'Customer', 'String', 'vcpostalcode', 14);
INSERT INTO ui.masterextractattribs (attribpath, level, datatype, displayname, itenantid) VALUES ('vcattribs->>''date_of_incorporation'' ', 'Customer', 'String', 'date_of_incorporation', 14);
INSERT INTO ui.masterextractattribs (attribpath, level, datatype, displayname, itenantid) VALUES ('vcattribs->>''latitude'' ', 'Customer', 'String', 'latitude', 14);
INSERT INTO ui.masterextractattribs (attribpath, level, datatype, displayname, itenantid) VALUES ('vcattribs->>''longitude'' ', 'Customer', 'String', 'longitude', 14);
INSERT INTO ui.masterextractattribs (attribpath, level, datatype, displayname, itenantid) VALUES ('vcattribs->>''business_division'' ', 'Customer', 'String', 'business_division', 14);
INSERT INTO ui.masterextractattribs (attribpath, level, datatype, displayname, itenantid) VALUES ('vcattribs->>''internationalFlagUpdate'' ', 'Customer', 'String', 'internationalFlagUpdate', 14);
INSERT INTO ui.masterextractattribs (attribpath, level, datatype, displayname, itenantid) VALUES ('vcattribs->>''mcc_description'' ', 'Customer', 'String', 'mcc_description', 14);
INSERT INTO ui.masterextractattribs (attribpath, level, datatype, displayname, itenantid) VALUES ('vcattribs->>''cumulativeDailyTransactionVolume'' ', 'Customer', 'String', 'cumulativeDailyTransactionVolume', 14);
INSERT INTO ui.masterextractattribs (attribpath, level, datatype, displayname, itenantid) VALUES ('vcattribs->>''cumulativeDailyTransactionCount'' ', 'Customer', 'String', 'cumulativeDailyTransactionCount', 14);
INSERT INTO ui.masterextractattribs (attribpath, level, datatype, displayname, itenantid) VALUES ('vcattribs->>''cumulativeDailyTransactionExitCount'' ', 'Customer', 'String', 'cumulativeDailyTransactionExitCount', 14);
INSERT INTO ui.masterextractattribs (attribpath, level, datatype, displayname, itenantid) VALUES ('vcattribs->>''cumulativeDailyTransactionExitVolume'' ', 'Customer', 'String', 'cumulativeDailyTransactionExitVolume', 14);
INSERT INTO ui.masterextractattribs (attribpath, level, datatype, displayname, itenantid) VALUES ('vcattribs->>''cumulativeDailyRefundVolume'' ', 'Customer', 'String', 'cumulativeDailyRefundVolume', 14);
INSERT INTO ui.masterextractattribs (attribpath, level, datatype, displayname, itenantid) VALUES ('vcattribs->>''cumulativeDailyRefundCount'' ', 'Customer', 'String', 'cumulativeDailyRefundCount', 14);
INSERT INTO ui.masterextractattribs (attribpath, level, datatype, displayname, itenantid) VALUES ('vcattribs->>''cumulativeDailyRefundExitVolume'' ', 'Customer', 'String', 'cumulativeDailyRefundExitVolume', 14);
INSERT INTO ui.masterextractattribs (attribpath, level, datatype, displayname, itenantid) VALUES ('vcattribs->>''cumulativeDailyRefundExitCount'' ', 'Customer', 'String', 'cumulativeDailyRefundExitCount', 14);
INSERT INTO ui.masterextractattribs (attribpath, level, datatype, displayname, itenantid) VALUES ('vcattribs->>''merchantType'' ', 'Customer', 'String', 'merchantType', 14);
INSERT INTO ui.masterextractattribs (attribpath, level, datatype, displayname, itenantid) VALUES ('vcattribs->>''businessChannel'' ', 'Customer', 'String', 'businessChannel', 14);
INSERT INTO ui.masterextractattribs (attribpath, level, datatype, displayname, itenantid) VALUES ('vcattribs->>''groupId'' ', 'Customer', 'String', 'groupId', 14);
INSERT INTO ui.masterextractattribs (attribpath, level, datatype, displayname, itenantid) VALUES ('vcattribs->>''subGroupId'' ', 'Customer', 'String', 'subGroupId', 14);
INSERT INTO ui.masterextractattribs (attribpath, level, datatype, displayname, itenantid) VALUES ('vcattribs->>''kyc_status'' ', 'Customer', 'String', 'kyc_status', 14);
INSERT INTO ui.masterextractattribs (attribpath, level, datatype, displayname, itenantid) VALUES ('vcattribs->>''documentNumber'' ', 'Customer', 'String', 'documentNumber', 14);
INSERT INTO ui.masterextractattribs (attribpath, level, datatype, displayname, itenantid) VALUES ('vcattribs->>''ip'' ', 'Customer', 'String', 'ip', 14);






