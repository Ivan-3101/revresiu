delete FROM ui.masterextractattribs where itenantid = 14;

ALTER TABLE ui.masterextractattribs
ADD COLUMN attribs JSONB;

INSERT INTO ui.masterextractattribs (
attribpath, level, datatype, displayname, itenantid, attribs) VALUES (
'vcexternalaccountid'::text, 'Account'::character varying, 'String'::character varying, 'External Account ID'::character varying, '14'::integer, '{
  "mandatoryTransposeField": true,
  "validations": []
}'::jsonb);

INSERT INTO ui.masterextractattribs (
attribpath, level, datatype, displayname, itenantid) VALUES (
'imcc'::text, 'Account'::character varying, 'String'::character varying, 'MCC'::character varying, '14'::integer
);

INSERT INTO ui.masterextractattribs (
attribpath, level, datatype, displayname, itenantid, attribs) VALUES (
'vcexternaladdressid'::text, 'VPA'::character varying, 'String'::character varying, 'External Address ID'::character varying, '14'::integer, '{
  "mandatoryTransposeField": true,
  "validations": []
}'::jsonb);


INSERT INTO ui.masterextractattribs (
attribpath, level, datatype, displayname, itenantid) VALUES (
'imcc'::text, 'VPA'::character varying, 'String'::character varying, 'MCC'::character varying, '14'::integer
);

INSERT INTO ui.masterextractattribs (
attribpath, level, datatype, displayname, itenantid, attribs) VALUES (
'vcexternalcustid'::text, 'Customer'::character varying, 'String'::character varying, 'External Customer ID'::character varying, '14'::integer, '{
  "mandatoryTransposeField": true,
  "validations": []
}'::jsonb);

INSERT INTO ui.masterextractattribs (
attribpath, level, datatype, displayname, itenantid) VALUES (
'vccustomername'::text, 'Customer'::character varying, 'String'::character varying, 'Name'::character varying, '14'::integer
);

INSERT INTO ui.masterextractattribs (
attribpath, level, datatype, displayname, itenantid) VALUES (
'vcattribs->>''subGroupId'''::text, 'Customer'::character varying, 'String'::character varying, 'Sub-Group ID'::character varying, '14'::integer
);


INSERT INTO ui.masterextractattribs (
attribpath, level, datatype, displayname, itenantid) VALUES (
'vcattribs->>''postalcode'''::text, 'Customer'::character varying, 'String'::character varying, 'Postal Code'::character varying, '14'::integer
);

INSERT INTO ui.masterextractattribs (
attribpath, level, datatype, displayname, itenantid) VALUES (
'vcattribs->>''longitude'''::text, 'Customer'::character varying, 'String'::character varying, 'Longitude'::character varying, '14'::integer
);


INSERT INTO ui.masterextractattribs (
attribpath, level, datatype, displayname, itenantid) VALUES (
'vcattribs->>''latitude'''::text, 'Customer'::character varying, 'String'::character varying, 'Latitude'::character varying, '14'::integer
);

INSERT INTO ui.masterextractattribs (
attribpath, level, datatype, displayname, itenantid) VALUES (
'vcattribs->>''internationalAcceptance'''::text, 'Customer'::character varying, 'String'::character varying, 'International Acceptance'::character varying, '14'::integer
);

INSERT INTO ui.masterextractattribs (
attribpath, level, datatype, displayname, itenantid) VALUES (
'vcattribs->>''groupId'''::text, 'Customer'::character varying, 'String'::character varying, 'Group ID'::character varying, '14'::integer
);

INSERT INTO ui.masterextractattribs (
attribpath, level, datatype, displayname, itenantid) VALUES (
'vcattribs->>''date_of_incorporation'''::text, 'Customer'::character varying, 'String'::character varying, 'Date of Incorporation'::character varying, '14'::integer
);


INSERT INTO ui.masterextractattribs (
attribpath, level, datatype, displayname, itenantid) VALUES (
'vcattribs->>''cumulativeDailyTransactionVolume'''::text, 'Customer'::character varying, 'String'::character varying, 'Cumulative Daily Transaction Volume'::character varying, '14'::integer
);


INSERT INTO ui.masterextractattribs (
attribpath, level, datatype, displayname, itenantid) VALUES (
'vcattribs->>''cumulativeDailyTransactionExitVolume'''::text, 'Customer'::character varying, 'String'::character varying, 'Cumulative Daily Transaction Exit Volume'::character varying, '14'::integer
);


INSERT INTO ui.masterextractattribs (
attribpath, level, datatype, displayname, itenantid) VALUES (
'vcattribs->>''cumulativeDailyTransactionExitCount'''::text, 'Customer'::character varying, 'String'::character varying, 'Cumulative Daily Transaction Exit Count'::character varying, '14'::integer
);

INSERT INTO ui.masterextractattribs (
attribpath, level, datatype, displayname, itenantid) VALUES (
'vcattribs->>''cumulativeDailyTransactionCount'''::text, 'Customer'::character varying, 'String'::character varying, 'Cumulative Daily Transaction Count'::character varying, '14'::integer
);


INSERT INTO ui.masterextractattribs (
attribpath, level, datatype, displayname, itenantid) VALUES (
'vcattribs->>''cumulativeDailyRefundVolume'''::text, 'Customer'::character varying, 'String'::character varying, 'Cumulative Daily Refund Volume'::character varying, '14'::integer
);


INSERT INTO ui.masterextractattribs (
attribpath, level, datatype, displayname, itenantid) VALUES (
'vcattribs->>''cumulativeDailyRefundExitVolume'''::text, 'Customer'::character varying, 'String'::character varying, 'Cumulative Daily Refund Exit Volume'::character varying, '14'::integer
);


INSERT INTO ui.masterextractattribs (
attribpath, level, datatype, displayname, itenantid) VALUES (
'vcattribs->>''cumulativeDailyRefundExitCount'''::text, 'Customer'::character varying, 'String'::character varying, 'Cumulative Daily Refund Exit Count'::character varying, '14'::integer
);

INSERT INTO ui.masterextractattribs (
attribpath, level, datatype, displayname, itenantid) VALUES (
'vcattribs->>''cumulativeDailyRefundCount'''::text, 'Customer'::character varying, 'String'::character varying, 'Cumulative Daily Refund Count'::character varying, '14'::integer
);


INSERT INTO ui.masterextractattribs (
attribpath, level, datatype, displayname, itenantid) VALUES (
'vcattribs->>''business_division'''::text, 'Customer'::character varying, 'String'::character varying, 'GST Business Division'::character varying, '14'::integer
);

INSERT INTO ui.masterextractattribs (
attribpath, level, datatype, displayname, itenantid) VALUES (
'vcattribs->>''businessChannel'''::text, 'Customer'::character varying, 'String'::character varying, 'Business Channel'::character varying, '14'::integer
);




INSERT INTO ui.dashboardfilters (
idashboardfilterid, ifilterorder, vcdashboardfiltername, idashboardid, vcdashboardfiltertype, itenantid, vcdashboardfilterdisplayname) VALUES (
'179'::integer, '1'::integer, 'Transpose'::character varying, '16'::integer, 'Transpose'::character varying, '14'::integer, 'Transpose'::character varying)
;


UPDATE ui.dashboardquery SET
vcdashboardquery =  E'{ 
    "Transpose":{
        "Account":"SELECT attribute, data FROM masters.accounts, LATERAL (VALUES (''icustomerid'', icustomerid::VARCHAR), (''iaccountid'', iaccountid::VARCHAR), (''vcexternalaccountid'', vcexternalaccountid), (''vcaccountproviderid'', vcaccountproviderid), (''vcaccountname'', vcaccountname), (''iaccounttypeid'', iaccounttypeid::VARCHAR), (''vcifsc'', vcifsc), (''bverified'', bverified::VARCHAR), (''imcc'', imcc::VARCHAR), (''dtonboardingdate'', dtonboardingdate::VARCHAR), (''dtexpirydate'', dtexpirydate::VARCHAR), (''bmerchant'', bmerchant::VARCHAR), (''irecordstatus'', irecordstatus::VARCHAR), (''dtentrydatetime'', dtentrydatetime::VARCHAR)) AS t(attribute, data) WHERE itenantid = :tenantid :AttribsForm ORDER BY iaccountid DESC ;",
        "VPA":"SELECT attribute, data FROM masters.vpa, LATERAL (VALUES (''ivpaid'', ivpaid::VARCHAR), (''iaccountid'', iaccountid::VARCHAR), (''vcexternaladdressid'', vcexternaladdressid), (''vcaddress'', vcaddress), (''iproductid'', iproductid::VARCHAR), (''vcvpaname'', vcvpaname), (''bverified'', bverified::VARCHAR), (''imcc'', imcc::VARCHAR), (''dtonboardingdate'', dtonboardingdate::VARCHAR), (''dtexpirydate'', dtexpirydate::VARCHAR), (''bmerchant'', bmerchant::VARCHAR), (''ivpaproviderid'', ivpaproviderid::VARCHAR), (''bprofiled'', bprofiled::VARCHAR), (''dtfirsttransaction'', dtfirsttransaction::VARCHAR), (''dtlasttransaction'', dtlasttransaction::VARCHAR), (''vcattribs'', vcattribs::TEXT), (''irecordstatus'', irecordstatus::VARCHAR), (''dtentrydatetime'', dtentrydatetime::VARCHAR)) AS t(attribute, data)  where itenantid = :tenantid :AttribsForm ORDER BY ivpaid DESC;",
        "Customer": "SELECT attribute, data FROM masters.customers, LATERAL (VALUES (''icustomerid'', icustomerid::VARCHAR), (''vcexternalcustid'', vcexternalcustid), (''vccustomername'', vccustomername), (''vccustomertype'', vccustomertype), (''vcsalutation'', vcsalutation), (''vcverifiedname'', vcverifiedname), (''vcgender'', vcgender), (''dtdoidob'', dtdoidob::VARCHAR), (''dtonboardingdate'', dtonboardingdate::VARCHAR), (''vcpostalcode'', vcpostalcode), (''vcemail'', vcemail), (''vcregisteredmobile'', vcregisteredmobile), (''imcc'', imcc::VARCHAR), (''vcidentitytype1'', vcidentitytype1), (''vcidentitydetails1'', vcidentitydetails1), (''vcidentitytype2'', vcidentitytype2), (''vcidentitydetails2'', vcidentitydetails2), (''vcregisteredaddressgeolocation'', vcregisteredaddressgeolocation), (''iadm3'', iadm3::VARCHAR), (''iadm2'', iadm2::VARCHAR), (''iadm1'', iadm1::VARCHAR), (''vccountrycode'', vccountrycode), (''irecordstatus'', irecordstatus::VARCHAR), (''dtentrydatetime'', dtentrydatetime::VARCHAR), (''vcpostalcode'', vcattribs->>''postalcode''), (''date_of_incorporation'', vcattribs->>''date_of_incorporation''), (''latitude'', vcattribs->>''latitude''), (''longitude'', vcattribs->>''longitude''), (''business_division'', vcattribs->>''business_division''), (''internationalFlagUpdate'', vcattribs->>''internationalFlagUpdate''), (''mcc_description'', vcattribs->>''mcc_description''), (''cumulativeDailyTransactionVolume'', vcattribs->>''cumulativeDailyTransactionVolume''), (''cumulativeDailyTransactionCount'', vcattribs->>''cumulativeDailyTransactionCount''), (''cumulativeDailyTransactionExitCount'', vcattribs->>''cumulativeDailyTransactionExitCount''), (''cumulativeDailyTransactionExitVolume'', vcattribs->>''cumulativeDailyTransactionExitVolume''), (''cumulativeDailyRefundVolume'', vcattribs->>''cumulativeDailyRefundVolume''), (''cumulativeDailyRefundCount'', vcattribs->>''cumulativeDailyRefundCount''), (''merchantType'', vcattribs->>''merchantType''), (''businessChannel'', vcattribs->>''businessChannel''), (''groupId'', vcattribs->>''groupId''), (''subGroupId'', vcattribs->>''subGroupId''), (''kyc_status'', vcattribs->>''kyc_status''), (''documentNumber'', vcattribs->>''documentNumber''), (''ip'', vcattribs->>''ip'')) AS t(attribute, data) WHERE itenantid = :tenantid :AttribsForm ORDER BY icustomerid DESC;"
    },
    "Normal":{
        "Account":"select iaccountid, icustomerid, vcexternalaccountid, iaccounttypeid, vcifsc, vcaccountproviderid, vcaccountname, dtonboardingdate, dtexpirydate, imcc, bmerchant, bverified, irecordstatus, dtentrydatetime from masters.accounts where itenantid = :tenantid :AttribsForm order by iaccountid desc limit 50000",
        "VPA":"select ivpaid, iaccountid, vcexternaladdressid, vcaddress, iproductid, vcvpaname, bverified, imcc, dtonboardingdate, dtexpirydate, bmerchant, ivpaproviderid, bprofiled, dtfirsttransaction, dtlasttransaction, irecordstatus, dtentrydatetime from masters.vpa where itenantid = :tenantid :AttribsForm order by ivpaid desc limit 50000",
        "Customer": "SELECT icustomerid, vcexternalcustid, vccustomername, vccustomertype, vcsalutation, vcverifiedname, vcgender, dtdoidob, dtonboardingdate, vcpostalcode, vcemail, vcregisteredmobile, imcc, vcidentitytype1, vcidentitydetails1, vcidentitytype2, vcidentitydetails2, vcregisteredaddressgeolocation, iadm3, iadm2, iadm1, vccountrycode, irecordstatus, dtentrydatetime, vcattribs->>''postalcode'' as \\"vcpostalcode\\", vcattribs->>''date_of_incorporation'' as \\"date_of_incorporation\\", vcattribs->>''latitude'' as \\"latitude\\", vcattribs->>''longitude'' as \\"longitude\\", vcattribs->>''business_division'' as \\"business_division\\", vcattribs->>''internationalFlagUpdate'' as \\"internationalFlagUpdate\\", vcattribs->>''mcc_description'' as \\"mcc_description\\",  vcattribs->>''cumulativeDailyTransactionVolume'' as \\"cumulativeDailyTransactionVolume\\", vcattribs->>''cumulativeDailyTransactionCount'' as \\"cumulativeDailyTransactionCount\\", vcattribs->>''cumulativeDailyTransactionExitCount'' as \\"cumulativeDailyTransactionExitCount\\", vcattribs->>''cumulativeDailyTransactionExitVolume'' as \\"cumulativeDailyTransactionExitVolume\\", vcattribs->>''cumulativeDailyRefundVolume'' as \\"cumulativeDailyRefundVolume\\", vcattribs->>''cumulativeDailyRefundCount'' as \\"cumulativeDailyRefundCount\\", vcattribs->>''merchantType'' as \\"merchantType\\", vcattribs->>''businessChannel'' as \\"businessChannel\\", vcattribs->>''groupId'' as \\"groupId\\", vcattribs->>''subGroupId'' as \\"subGroupId\\", vcattribs->>''kyc_status'' as \\"kyc_status\\", vcattribs->>''documentNumber'' as \\"documentNumber\\", vcattribs->>''ip'' as \\"ip\\" FROM masters.customers where itenantid = :tenantid :AttribsForm order by icustomerid desc limit 50000;"
    }
}'::text, vcfilterparametersjson = '{"Party": null, "AttribsForm":null, "Transpose":"Normal"}'::text WHERE
idashboardqueryid = 48 AND itenantid = 14;

INSERT INTO ui.dashboardqueryparameters (
idashboardparameterid, vcparametername, vcparametertype, idashboardqueryid, iorder, itenantid) VALUES (
'276'::integer, 'Transpose'::character varying, 'JsonPath'::character varying, '48'::integer, '0'::integer, '14'::integer)
;


UPDATE ui.dashboardqueryparameters SET
iorder = '1'::integer WHERE
idashboardqueryid = 48 and itenantid = 14 and vcparametername = 'Party';

UPDATE ui.masterextractattribs SET
datatype = 'Integer'::character varying WHERE
attribpath = 'imcc' AND level = 'VPA' AND itenantid = 14;

UPDATE ui.masterextractattribs SET
datatype = 'Integer'::character varying WHERE
attribpath = 'imcc' AND level = 'Account' AND itenantid = 14;

UPDATE ui.dashboardquery SET
vcdashboardquery = 'select displayname as "displayName" , attribpath as "whereEntry", datatype as "dataType", cast(attribs as text) as "attribs" from ui.masterextractattribs where level = :Party and itenantid=:tenantid '::text WHERE
idashboardqueryid = 74 AND itenantid = 14;