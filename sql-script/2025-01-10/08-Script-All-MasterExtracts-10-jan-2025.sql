ALTER TABLE ui.masterextractattribs
ADD COLUMN attribs JSONB;

INSERT INTO ui.dashboardfilters (
    idashboardfilterid, ifilterorder, vcdashboardfiltername, 
    idashboardid, vcdashboardfiltertype, idashboardqueryidfordefaultvalue, 
    itenantid, vcdashboardfilterdisplayname
)
SELECT 
    (select max(idashboardfilterid) + 1 from ui.dashboardfilters) AS idashboardfilterid,
    1 AS ifilterorder,
    'DateRange' AS vcdashboardfiltername,
    16 AS idashboardid,
    'DateRangePicker' AS vcdashboardfiltertype,
    16 AS idashboardqueryidfordefaultvalue,
    t.itenantid,
    'Date Range' AS vcdashboardfilterdisplayname
FROM 
    ui.tenants t
WHERE 
    itenantid in (5,6,7,8,9,10,12,13,14,15,16,17,19,20,21,22,23,24);

INSERT INTO ui.dashboardfilters (
    idashboardfilterid, ifilterorder, vcdashboardfiltername, 
    idashboardid, vcdashboardfiltertype, idashboardqueryidforoptions, 
    itenantid, vcdashboardfilterdisplayname
)
SELECT 
    (select max(idashboardfilterid) + 1 from ui.dashboardfilters) AS idashboardfilterid,
    2 AS ifilterorder,
    'Load' AS vcdashboardfiltername,
    16 AS idashboardid,
    'Select' AS vcdashboardfiltertype,
    91 AS idashboardqueryidforoptions,
    t.itenantid,
    'Load' AS vcdashboardfilterdisplayname
FROM 
    ui.tenants t
WHERE itenantid in (5,6,7,8,9,10,12,13,14,15,16,17,19,20,21,22,23,24);

INSERT INTO ui.dashboardfilters (
    idashboardfilterid, ifilterorder, vcdashboardfiltername, 
    idashboardid, vcdashboardfiltertype, itenantid, vcdashboardfilterdisplayname
)
SELECT 
     (select max(idashboardfilterid) + 1 from ui.dashboardfilters) AS idashboardfilterid,
    1 AS ifilterorder,
    'Transpose' AS vcdashboardfiltername,
    16 AS idashboardid,
    'Transpose' AS vcdashboardfiltertype,
    t.itenantid,
    'Transpose' AS vcdashboardfilterdisplayname
FROM 
    ui.tenants t
WHERE itenantid in (5,6,7,8,9,10,12,13,16,17,19,20,21,22,23,24);


UPDATE ui.dashboardfilters SET
ifilterorder = '3'::integer WHERE idashboardid=16 and
vcdashboardfiltername = 'AttribsForm';

INSERT INTO ui.dashboardqueryparameters (
    idashboardparameterid, vcparametername, vcparametertype, 
    idashboardqueryid, iorder, itenantid
)
SELECT 
     (select max(idashboardparameterid) + 1 from ui.dashboardqueryparameters) AS idashboardparameterid,
    'Transpose' AS vcparametername,
    'JsonPath' AS vcparametertype,
    48 AS idashboardqueryid,
    0 AS iorder,
    t.itenantid
FROM 
    ui.tenants t
WHERE itenantid in (5,6,7,8,9,10,12,13,16,17,19,20,21,22,23,24);

INSERT INTO ui.dashboardqueryparameters (
    idashboardparameterid, vcparametername, vcparametertype, 
    idashboardqueryid, itenantid
)
SELECT 
     (select max(idashboardparameterid) + 1 from ui.dashboardqueryparameters) AS idashboardparameterid,
    'Load' AS vcparametername,
    'Integer' AS vcparametertype,
    48 AS idashboardqueryid,
    t.itenantid
FROM 
    ui.tenants t
WHERE t.itenantid in (5,6,7,8,9,10,12,13,14,15,16,17,19,20,21,22,23,24);

INSERT INTO ui.dashboardqueryparameters (
    idashboardparameterid, vcparametername, vcparametertype, 
    idashboardqueryid, itenantid
)
SELECT 
     (select max(idashboardparameterid) + 1 from ui.dashboardqueryparameters) AS idashboardparameterid,
    'DateRange' AS vcparametername,
    'DateRange' AS vcparametertype,
    48 AS idashboardqueryid,
    t.itenantid
FROM 
    ui.tenants t
WHERE t.itenantid in (5,6,7,8,9,10,12,13,14,15,16,17,19,20,21,22,23,24);

UPDATE ui.dashboardqueryparameters SET
iorder = '1'::integer WHERE
idashboardqueryid = 48  and vcparametername = 'Party';

UPDATE ui.dashboardqueryparameters SET
iorder = NULL::integer 
where idashboardqueryid=48 and vcparametername='AttribsForm';

UPDATE ui.dashboardquery SET vcfilterparametersjson = '{"Party": null, "DateRange": null, "AttribsForm":null, "Transpose":"Normal", "Load":null}'::text WHERE
idashboardqueryid = 48;

UPDATE ui.dashboardquery SET
vcdashboardquery =  E'{ 
    "Transpose": {
        "Customer": "SELECT attribute, data FROM masters.customers, LATERAL (VALUES (''customer id'', CAST(icustomerid AS VARCHAR)), (''externalcustid'', vcexternalcustid), (''customer name'', vccustomername), (''customer type'', vccustomertype), (''verified name'', vcverifiedname), (''onboarding date'', CAST(dtonboardingdate AS VARCHAR)), (''email'', vcemail), (''registered mobile'', vcregisteredmobile), (''MCC'', CAST(imcc AS VARCHAR)), (''record status'', CAST(irecordstatus AS VARCHAR)), (''vcidentitytype1'', vcidentitytype1), (''vcidentitydetails1'', vcidentitydetails1), (''vcidentitytype2'', vcidentitytype2), (''vcidentitydetails2'', vcidentitydetails2), (''kyc_type'', vcattribs->>''kyc_type''), (''registered address geolocation'', vcregisteredaddressgeolocation), (''declared_salary_max'', vcattribs->>''declared_salary_max''), (''city'', vcattribs->>''city''), (''state'', vcattribs->>''state'')) AS t(attribute, data) WHERE itenantid = :tenantid :AttribsForm AND dtentrydatetime BETWEEN :StartDate AND :EndDate ORDER BY icustomerid DESC LIMIT :Load;",
        "Account": "SELECT attribute, data FROM masters.accounts, LATERAL (VALUES (''account id'', CAST(iaccountid AS VARCHAR)), (''customer id'', CAST(icustomerid AS VARCHAR)), (''external accountid'', vcexternalaccountid), (''account name'', vcaccountname), (''onboarding date'', CAST(onboarding date AS VARCHAR)), (''MCC'', CAST(imcc AS VARCHAR)), (''bmerchant'', CAST(bmerchant AS VARCHAR)), (''record status'', CAST(irecordstatus AS VARCHAR)), (''entry datetime'', CAST(dtentrydatetime AS VARCHAR)), (''account_categories'', vcattribs->>''account_categories''), (''vcifsc'', vcifsc)) AS t(attribute, data) WHERE itenantid = :tenantid :AttribsForm AND dtentrydatetime BETWEEN :StartDate AND :EndDate ORDER BY iaccountid DESC LIMIT :Load;",
        "VPA": "SELECT attribute, data FROM masters.vpa, LATERAL (VALUES (''vpa id'', CAST(ivpaid AS VARCHAR)), (''account id'', CAST(iaccountid AS VARCHAR)), (''external addressid'', vcexternaladdressid), (''address'', vcaddress), (''vpa name'', vcvpaname), (''MCC'', CAST(imcc AS VARCHAR)), (''bmerchant'', CAST(bmerchant AS VARCHAR)), (''entry datetime'', CAST(dtentrydatetime AS VARCHAR)), (''record status'', CAST(irecordstatus AS VARCHAR)), (''merchant type'', vcattribs->>''merchanttype''), (''bverified'', CAST(bverified AS VARCHAR)), (''vpa_categories'', vcattribs->>''vpa_categories''), (''dtexpirydate'', CAST(dtexpirydate AS VARCHAR))) AS t(attribute, data) WHERE itenantid = :tenantid :AttribsForm AND dtentrydatetime BETWEEN :StartDate AND :EndDate ORDER BY ivpaid DESC LIMIT :Load;"
    },
    "Normal": {
        "Customer": "SELECT icustomerid AS \\"Customer ID\\", vcexternalcustid AS \\"MID\\", vccustomername AS \\"Customer Name\\", vccustomertype AS \\"Customer Type\\", vcverifiedname AS \\"Verified Name\\", dtonboardingdate AS \\"Onboarded On\\", vcemail AS \\"Email\\", vcregisteredmobile AS \\"Registered Mobile\\", imcc AS \\"MCC\\", irecordstatus AS \\"Record Status\\", vcidentitytype1 AS \\"Identity Type 1\\", vcidentitydetails1 AS \\"Identity Detail 1\\", vcidentitytype2 AS \\"Identity Type 2\\", vcidentitydetails2 AS \\"Identity Detail 2\\", vcattribs->>''kyc_type'' AS \\"KYC Type\\", vcregisteredaddressgeolocation AS \\"Geolocation\\", vcattribs->>''declared_salary_max'' AS \\"Max Declared Salary\\", vcattribs->>''city'' AS \\"City\\", vcattribs->>''state'' AS \\"State\\" FROM masters.customers WHERE itenantid = :tenantid AND dtentrydatetime BETWEEN :StartDate AND :EndDate ORDER BY icustomerid DESC LIMIT :Load;",
        "Account": "SELECT iaccountid AS \\"Account ID\\", icustomerid AS \\"Customer ID\\", vcexternalaccountid AS \\"External Account ID\\", vcaccountname AS \\"Account Name\\", dtonboardingdate AS \\"Onboarded On\\", imcc AS \\"MCC\\", bmerchant AS \\"Merchant\\", irecordstatus AS \\"Record Status\\", dtentrydatetime AS \\"Entry Date Time\\", vcattribs->>''account_categories'' AS \\"Account Category\\", vcifsc AS \\"IFSC\\" FROM masters.accounts WHERE itenantid = :tenantid AND dtentrydatetime BETWEEN :StartDate AND :EndDate ORDER BY iaccountid DESC LIMIT :Load;",
        "VPA": "SELECT ivpaid AS \\"VPA ID\\", iaccountid AS \\"Account ID\\", vcexternaladdressid AS \\"External Address\\", vcaddress AS \\"Payment Address\\", vcvpaname AS \\"VPA Name\\", imcc AS \\"MCC\\", bmerchant AS \\"Merchant\\", dtentrydatetime AS \\"Entry Date Time\\", irecordstatus AS \\"Record Status\\", vcattribs->>''merchanttype'' AS \\"Merchant Type\\", bverified AS \\"Verified\\", vcattribs->>''vpa_categories'' AS \\"VPA Category\\", dtexpirydate AS \\"Expiry Date\\" FROM masters.vpa WHERE itenantid = :tenantid AND dtentrydatetime BETWEEN :StartDate AND :EndDate ORDER BY ivpaid DESC LIMIT :Load;"
    }
}'::text WHERE
idashboardqueryid = 48 AND itenantid = 5;

UPDATE ui.dashboardquery SET
vcdashboardquery =  E'{ 
    "Transpose": {
        "Customer": "SELECT attribute, data FROM masters.customers, LATERAL (VALUES (''Customer ID'', CAST(icustomerid AS VARCHAR)), (''MID'', vcexternalcustid), (''Customer Name'', vccustomername), (''Customer Type'', vccustomertype), (''Verified Name'', vcverifiedname), (''Onboarded On'', CAST(dtonboardingdate AS VARCHAR)), (''Email'', vcemail), (''MCC'', vcattribs->>''mcc''), (''Category'', vcattribs->>''category''), (''Record Status'', CAST(irecordstatus AS VARCHAR)), (''Entry Date Time'', CAST(dtentrydatetime AS VARCHAR)), (''Ownershiptype'', vcattribs->>''ownershiptype''), (''Account Type'', vcattribs->>''accounttype''), (''Risk Limit'', vcattribs->>''riskLimit''), (''Turnover'', vcattribs->>''turnover''), (''Merchant Type'', vcattribs->>''merchanttype''), (''Account Address'', vcattribs->>''accountaddress''), (''Account Onboarding Date'', vcattribs->>''accountonboardingdate''), (''Last Turnover Update'', vcattribs->>''lastTurnoverUpdate''), (''KYC'', vcattribs->>''kyc_status'')) AS t(attribute, data) WHERE itenantid = :tenantid AND dtentrydatetime BETWEEN :StartDate AND :EndDate ORDER BY icustomerid DESC LIMIT :Load;",
        "Account": "SELECT attribute, data FROM masters.accounts, LATERAL (VALUES (''Account ID'', CAST(iaccountid AS VARCHAR)), (''Customer ID'', CAST(icustomerid AS VARCHAR)), (''Store ID'', vcexternalaccountid), (''Account Name'', vcaccountname), (''Onboarded On'', CAST(dtonboardingdate AS VARCHAR)), (''MCC'', CAST(imcc AS VARCHAR)), (''Merchant'', CAST(bmerchant AS VARCHAR)), (''Record Status'', CAST(irecordstatus AS VARCHAR)), (''Entry Date Time'', CAST(dtentrydatetime AS VARCHAR)), (''Contact'', vcattribs->>''contact''), (''Postal Code'', vcattribs->>''postalcode''), (''Merchant Type'', vcattribs->>''merchanttype'')) AS t(attribute, data) WHERE itenantid = :tenantid AND dtentrydatetime BETWEEN :StartDate AND :EndDate ORDER BY iaccountid DESC LIMIT :Load;",
        "VPA": "SELECT attribute, data FROM masters.vpa, LATERAL (VALUES (''VPA ID'', CAST(ivpaid AS VARCHAR)), (''Account ID'', CAST(iaccountid AS VARCHAR)), (''POS ID'', vcexternaladdressid), (''Payment Address'', vcaddress), (''VPA Name'', vcvpaname), (''MCC'', CAST(imcc AS VARCHAR)), (''Merchant'', CAST(bmerchant AS VARCHAR)), (''Entry Date Time'', CAST(dtentrydatetime AS VARCHAR)), (''Record Status'', CAST(irecordstatus AS VARCHAR)), (''Merchant Type'', vcattribs->>''merchanttype'')) AS t(attribute, data) WHERE itenantid = :tenantid AND dtentrydatetime BETWEEN :StartDate AND :EndDate ORDER BY ivpaid DESC LIMIT :Load;"
    },
    "Normal": {
        "Customer": "SELECT icustomerid AS \\"Customer ID\\", vcexternalcustid AS \\"MID\\", vccustomername AS \\"Customer Name\\", vccustomertype AS \\"Customer Type\\", vcverifiedname AS \\"Verified Name\\", dtonboardingdate AS \\"Onboarded On\\", vcemail AS \\"Email\\", vcattribs->>''mcc'' AS \\"MCC\\", vcattribs->>''category'' AS \\"Category\\", irecordstatus AS \\"Record Status\\", dtentrydatetime AS \\"Entry Date Time\\", vcattribs->>''ownershiptype'' AS \\"Ownershiptype\\", vcattribs->>''accounttype'' AS \\"Account Type\\", vcattribs->>''riskLimit'' AS \\"Risk Limit\\", vcattribs->>''turnover'' AS \\"Turnover\\", vcattribs->>''merchanttype'' AS \\"Merchant Type\\", vcattribs->>''accountaddress'' AS \\"Account Address\\", vcattribs->>''accountonboardingdate'' AS \\"Account Onboarding Date\\", vcattribs->>''lastTurnoverUpdate'' AS \\"Last Turnover Update\\", vcattribs->>''kyc_status'' AS \\"KYC\\" FROM masters.customers WHERE itenantid = :tenantid AND dtentrydatetime BETWEEN :StartDate AND :EndDate ORDER BY icustomerid DESC LIMIT :Load;",
        "Account": "SELECT iaccountid AS \\"Account ID\\", icustomerid AS \\"Customer ID\\", vcexternalaccountid AS \\"Store ID\\", vcaccountname AS \\"Account Name\\", dtonboardingdate AS \\"Onboarded On\\", imcc AS \\"MCC\\", bmerchant AS \\"Merchant\\", irecordstatus AS \\"Record Status\\", dtentrydatetime AS \\"Entry Date Time\\", vcattribs->>''contact'' AS \\"Contact\\", vcattribs->>''postalcode'' AS \\"Postal Code\\", vcattribs->>''merchanttype'' AS \\"Merchant Type\\" FROM masters.accounts WHERE itenantid = :tenantid AND dtentrydatetime BETWEEN :StartDate AND :EndDate ORDER BY iaccountid DESC LIMIT :Load;",
        "VPA": "SELECT ivpaid AS \\"VPA ID\\", iaccountid AS \\"Account ID\\", vcexternaladdressid AS \\"POS ID\\", vcaddress AS \\"Payment Address\\", vcvpaname AS \\"VPA Name\\", imcc AS \\"MCC\\", bmerchant AS \\"Merchant\\", dtentrydatetime AS \\"Entry Date Time\\", irecordstatus AS \\"Record Status\\", vcattribs->>''merchanttype'' AS \\"Merchant Type\\" FROM masters.vpa WHERE itenantid = :tenantid AND dtentrydatetime BETWEEN :StartDate AND :EndDate ORDER BY ivpaid DESC LIMIT :Load;"
    }
}
'::text WHERE
idashboardqueryid = 48 AND itenantid = 10;

UPDATE ui.dashboardquery SET
vcdashboardquery =  E'{
    "Transpose": { 
        "Customer": "SELECT attribute, data FROM masters.customers, LATERAL (VALUES (''Customer ID'', CAST(icustomerid AS VARCHAR)), (''External Cust ID'', vcexternalcustid), (''Customer Name'', vccustomername), (''Onboarded On'', CAST(dtonboardingdate AS VARCHAR)), (''MCC'', CAST(imcc AS VARCHAR)), (''PAN'', vcattribs->''yb_raw''->>''pan''), (''City'', vcattribs->''yb_raw''->>''city''), (''GSTN'', vcattribs->''yb_raw''->>''gstn''), (''LLPIN'', vcattribs->''yb_raw''->>''llpIn''), (''State'', vcattribs->''yb_raw''->>''state''), (''Status'', vcattribs->''yb_raw''->>''status''), (''Channel'', vcattribs->''yb_raw''->>''channel''), (''Country'', vcattribs->''yb_raw''->>''country''), (''Pin Code'', vcattribs->''yb_raw''->>''pinCode''), (''District'', vcattribs->''yb_raw''->>''district''), (''Latitude'', vcattribs->''yb_raw''->>''latitude''), (''Longitude'', vcattribs->''yb_raw''->>''longitude''), (''Partner Name'', vcattribs->''yb_raw''->>''partnerName''), (''Business Name'', vcattribs->''yb_raw''->>''businessName''), (''Merchant Type'', vcattribs->''yb_raw''->>''merchantType''), (''Mobile Number'', vcattribs->''yb_raw''->>''mobileNumber''), (''Turn Over Type'', vcattribs->''yb_raw''->>''turnOverType''), (''Ownership Type'', vcattribs->''yb_raw''->>''ownershipType''), (''Acceptance Type'', vcattribs->''yb_raw''->>''acceptanceType''), (''Verified Account Name'', vcattribs->''yb_raw''->>''sellerVerifiedAccountName''), (''Record Status'', CAST(irecordstatus AS VARCHAR))) AS t(attribute, data) WHERE itenantid = :tenantid AND dtentrydatetime BETWEEN :StartDate AND :EndDate ORDER BY icustomerid DESC LIMIT :Load;",
        "Account": "SELECT attribute, data FROM masters.accounts, LATERAL (VALUES (''Account ID'', CAST(iaccountid AS VARCHAR)), (''Customer ID'', CAST(icustomerid AS VARCHAR)), (''External Account ID'', vcexternalaccountid), (''Merchant'', CAST(bmerchant AS VARCHAR)), (''Record Status'', CAST(irecordstatus AS VARCHAR)), (''Entry Date Time'', CAST(dtentrydatetime AS VARCHAR))) AS t(attribute, data) WHERE itenantid = :tenantid AND dtentrydatetime BETWEEN :StartDate AND :EndDate ORDER BY iaccountid DESC LIMIT :Load;",
        "VPA": "SELECT attribute, data FROM masters.vpa, LATERAL (VALUES (''VPA ID'', CAST(ivpaid AS VARCHAR)), (''Account ID'', CAST(iaccountid AS VARCHAR)), (''External Address ID'', vcexternaladdressid), (''Payment Address'', vcaddress), (''VPA Name'', vcvpaname), (''MCC'', CAST(imcc AS VARCHAR)), (''Merchant'', CAST(bmerchant AS VARCHAR)), (''Entry Date Time'', CAST(dtentrydatetime AS VARCHAR)), (''Record Status'', CAST(irecordstatus AS VARCHAR))) AS t(attribute, data) WHERE itenantid = :tenantid AND dtentrydatetime BETWEEN :StartDate AND :EndDate ORDER BY ivpaid DESC LIMIT :Load;"
    },
    "Normal": {
        "Customer": "SELECT icustomerid AS \\"Customer ID\\", vcexternalcustid AS \\"External Cust ID\\", vccustomername AS \\"Customer Name\\", dtonboardingdate AS \\"Onboarded On\\", imcc AS \\"MCC\\", vcattribs->''yb_raw''->>''pan'' AS \\"PAN\\", vcattribs->''yb_raw''->>''city'' AS \\"City\\", vcattribs->''yb_raw''->>''gstn'' AS \\"GSTN\\", vcattribs->''yb_raw''->>''llpIn'' AS \\"LLPIN\\", vcattribs->''yb_raw''->>''state'' AS \\"State\\", vcattribs->''yb_raw''->>''status'' AS \\"Status\\", vcattribs->''yb_raw''->>''channel'' AS \\"Channel\\", vcattribs->''yb_raw''->>''country'' AS \\"Country\\", vcattribs->''yb_raw''->>''pinCode'' AS \\"Pin Code\\", vcattribs->''yb_raw''->>''district'' AS \\"District\\", vcattribs->''yb_raw''->>''latitude'' AS \\"Latitude\\", vcattribs->''yb_raw''->>''longitude'' AS \\"Longitude\\", vcattribs->''yb_raw''->>''partnerName'' AS \\"Partner Name\\", vcattribs->''yb_raw''->>''businessName'' AS \\"Business Name\\", vcattribs->''yb_raw''->>''merchantType'' AS \\"Merchant Type\\", vcattribs->''yb_raw''->>''mobileNumber'' AS \\"Mobile Number\\", vcattribs->''yb_raw''->>''turnOverType'' AS \\"Turn Over Type\\", vcattribs->''yb_raw''->>''ownershipType'' AS \\"Ownership Type\\", vcattribs->''yb_raw''->>''acceptanceType'' AS \\"Acceptance Type\\", vcattribs->''yb_raw''->>''sellerVerifiedAccountName'' AS \\"Verified Account Name\\", irecordstatus AS \\"Record Status\\" FROM masters.customers WHERE itenantid = :tenantid AND dtentrydatetime BETWEEN :StartDate AND :EndDate ORDER BY icustomerid DESC LIMIT :Load;",
        "Account": "SELECT iaccountid AS \\"Account ID\\", icustomerid AS \\"Customer ID\\", vcexternalaccountid AS \\"External Account ID\\", bmerchant AS \\"Merchant\\", irecordstatus AS \\"Record Status\\", dtentrydatetime AS \\"Entry Date Time\\" FROM masters.accounts WHERE itenantid = :tenantid  AND dtentrydatetime BETWEEN :StartDate AND :EndDate ORDER BY iaccountid DESC LIMIT :Load;",
        "VPA": "SELECT ivpaid AS \\"VPA ID\\", iaccountid AS \\"Account ID\\", vcexternaladdressid AS \\"External Address ID\\", vcaddress AS \\"Payment Address\\", vcvpaname AS \\"VPA Name\\", imcc AS \\"MCC\\", bmerchant AS \\"Merchant\\", dtentrydatetime AS \\"Entry Date Time\\", irecordstatus AS \\"Record Status\\" FROM masters.vpa WHERE itenantid = :tenantid  AND dtentrydatetime BETWEEN :StartDate AND :EndDate ORDER BY ivpaid DESC LIMIT :Load;"
    }
}'::text WHERE
idashboardqueryid = 48 AND itenantid = 8;

UPDATE ui.dashboardquery SET
vcdashboardquery =  E'{
    "Transpose": {
        "Account": "SELECT attribute, data FROM masters.accounts, LATERAL (VALUES (''account id'', CAST(iaccountid AS VARCHAR)), (''customer id'', CAST(icustomerid AS VARCHAR)), (''external account id'', vcexternalaccountid), (''bmerchant'', CAST(bmerchant AS VARCHAR)), (''record status'', CAST(irecordstatus AS VARCHAR)), (''entry date time'', CAST(dtentrydatetime AS VARCHAR))) AS t(attribute, data) WHERE itenantid = :tenantid :AttribsForm AND dtentrydatetime BETWEEN :StartDate AND :EndDate ORDER BY iaccountid DESC LIMIT :Load;",
        "VPA": "SELECT attribute, data FROM masters.vpa, LATERAL (VALUES (''vpa id'', CAST(ivpaid AS VARCHAR)), (''account id'', CAST(iaccountid AS VARCHAR)), (''external address id'', vcexternaladdressid), (''address'', vcaddress), (''vpaname'', vcvpaname), (''MCC'', CAST(imcc AS VARCHAR)), (''bmerchant'', CAST(bmerchant AS VARCHAR)), (''entry date time'', CAST(dtentrydatetime AS VARCHAR)), (''irecordstatus'', CAST(irecordstatus AS VARCHAR))) AS t(attribute, data) WHERE itenantid = :tenantid :AttribsForm AND dtentrydatetime BETWEEN :StartDate AND :EndDate ORDER BY ivpaid DESC LIMIT :Load;",
        "Customer": "SELECT attribute, data FROM masters.customers, LATERAL (VALUES (''Customer ID'', CAST(icustomerid AS VARCHAR)), (''External Cust ID'', vcexternalcustid), (''Customer Name'', vccustomername), (''Onboarded On'', CAST(dtonboardingdate AS VARCHAR)), (''MCC'', CAST(imcc AS VARCHAR)), (''PAN'', vcattribs->>''pan''), (''City'', vcattribs->>''city''), (''GSTN'', vcattribs->>''gstn''), (''LLPIN'', vcattribs->>''llpin''), (''State'', vcattribs->>''state''), (''Status'', vcattribs->>''status''), (''Country'', vcattribs->>''country''), (''Pincode'', vcattribs->>''pincode''), (''District'', vcattribs->>''district''), (''Latitude'', vcattribs->>''latitude''), (''Longitude'', vcattribs->>''longitude''), (''Partner Name'', vcattribs->>''partnerName''), (''Business Name'', vcattribs->>''businessName''), (''Merchant Type'', vcattribs->>''merchantType''), (''Registered mobile'', vcregisteredmobile), (''Turnover Type'', vcattribs->>''turnoverType''), (''Ownership Type'', vcattribs->>''ownershipType''), (''Acceptance Type'', vcattribs->>''acceptanceType''), (''Verified AccountName'', vcattribs->>''sellerVerifiedAccountName''), (''record status'', CAST(irecordstatus AS VARCHAR))) AS t(attribute, data) WHERE itenantid = :tenantid :AttribsForm AND dtentrydatetime BETWEEN :StartDate AND :EndDate ORDER BY icustomerid DESC LIMIT :Load;"
    },
    "Normal": {
        "Account": "SELECT iaccountid AS \\"Account ID\\", icustomerid AS \\"Customer ID\\", vcexternalaccountid AS \\"External Account ID\\", bmerchant AS \\"Merchant\\", irecordstatus AS \\"Record Status\\", dtentrydatetime AS \\"Entry Date Time\\" FROM masters.accounts WHERE itenantid = :tenantid AND dtentrydatetime BETWEEN :StartDate AND :EndDate ORDER BY iaccountid DESC LIMIT :Load;",
        "VPA": "SELECT ivpaid AS \\"VPA ID\\", iaccountid AS \\"Account ID\\", vcexternaladdressid AS \\"External Address ID\\", vcaddress AS \\"Payment Address\\", vcvpaname AS \\"VPA Name\\", imcc AS \\"MCC\\", bmerchant AS \\"Merchant\\", dtentrydatetime AS \\"Entry Date Time\\", irecordstatus AS \\"Record Status\\" FROM masters.vpa WHERE itenantid = :tenantid AND dtentrydatetime BETWEEN :StartDate AND :EndDate ORDER BY ivpaid DESC LIMIT :Load;",
        "Customer": "SELECT icustomerid AS \\"Customer ID\\", vcexternalcustid AS \\"External Cust ID\\", vccustomername AS \\"Customer Name\\", dtonboardingdate AS \\"Onboarded On\\", imcc AS \\"MCC\\", vcattribs->>''pan'' AS \\"PAN\\", vcattribs->>''city'' AS \\"City\\", vcattribs->>''gstn'' AS \\"GSTN\\", vcattribs->>''llpin'' AS \\"LLPIN\\", vcattribs->>''state'' AS \\"State\\", vcattribs->>''status'' AS \\"Status\\", vcattribs->>''country'' AS \\"Country\\", vcattribs->>''pincode'' AS \\"Pin Code\\", vcattribs->>''district'' AS \\"District\\", vcattribs->>''latitude'' AS \\"Latitude\\", vcattribs->>''longitude'' AS \\"Longitude\\", vcattribs->>''partnerName'' AS \\"Partner Name\\", vcattribs->>''businessName'' AS \\"Business Name\\", vcattribs->>''merchantType'' AS \\"Merchant Type\\", vcregisteredmobile AS \\"Mobile Number\\", vcattribs->>''turnoverType'' AS \\"Turn Over Type\\", vcattribs->>''ownershipType'' AS \\"Ownership Type\\", vcattribs->>''acceptanceType'' AS \\"Acceptance Type\\", vcattribs->>''sellerVerifiedAccountName'' AS \\"Verified Account Name\\", irecordstatus AS \\"Record Status\\" FROM masters.customers WHERE itenantid = :tenantid AND dtentrydatetime BETWEEN :StartDate AND :EndDate ORDER BY icustomerid DESC LIMIT :Load;"
    }
}
'::text WHERE
idashboardqueryid = 48 AND itenantid = 17;

UPDATE ui.dashboardquery SET
vcdashboardquery =  E'{
    "Transpose": {
        "Account": "SELECT attribute, data FROM masters.accounts, LATERAL (VALUES (''account id'', CAST(iaccountid AS VARCHAR)), (''customer id'', CAST(icustomerid AS VARCHAR)), (''external account id'', vcexternalaccountid), (''account name'', vcaccountname), (''Onboarded On'', CAST(dtonboardingdate AS VARCHAR)), (''MCC'', CAST(imcc AS VARCHAR)), (''bmerchant'', CAST(bmerchant AS VARCHAR)), (''record status'', CAST(irecordstatus AS VARCHAR))) AS t(attribute, data) WHERE itenantid = :tenantid :AttribsForm AND dtentrydatetime BETWEEN :StartDate AND :EndDate ORDER BY iaccountid DESC LIMIT :Load;",
        "VPA": "SELECT attribute, data FROM masters.vpa, LATERAL (VALUES (''vpa id'', CAST(ivpaid AS VARCHAR)), (''account id'', CAST(iaccountid AS VARCHAR)), (''external addressid'', vcexternaladdressid), (''vcaddress'', vcaddress), (''vpa name'', vcvpaname), (''MCC'', CAST(imcc AS VARCHAR)), (''bmerchant'', CAST(bmerchant AS VARCHAR)), (''entry date time'', CAST(dtentrydatetime AS VARCHAR)), (''record status'', CAST(irecordstatus AS VARCHAR))) AS t(attribute, data) WHERE itenantid = :tenantid :AttribsForm AND dtentrydatetime BETWEEN :StartDate AND :EndDate ORDER BY ivpaid DESC LIMIT :Load;",
        "Customer": "SELECT attribute, data FROM masters.customers, LATERAL (VALUES (''customer id'', CAST(icustomerid AS VARCHAR)), (''external custid'', vcexternalcustid), (''customer name'', vccustomername), (''customer type'', vccustomertype), (''verified name'', vcverifiedname), (''onboarding date'', CAST(dtonboardingdate AS VARCHAR)), (''email'', vcemail), (''registered mobile'', vcregisteredmobile), (''MCC'', CAST(imcc AS VARCHAR)), (''record status'', CAST(irecordstatus AS VARCHAR)), (''entry date time'', CAST(dtentrydatetime AS VARCHAR)), (''pan_number'', vcattribs->>''panNo''), (''purpose'', vcattribs->>''purpose''), (''partner_id'', vcattribs->>''partnerID''), (''partner_name'', vcattribs->>''partnerName''), (''merchant_no'', vcattribs->>''ecollectAccNo''), (''merchant_type'', vcattribs->>''merchant_type''), (''type_of_company'', vcattribs->>''typeOfCompany''), (''client_identifier'', vcattribs->>''clientIdentifier''), (''registered_address'', vcattribs->>''registeredAddress''), (''date_of_registration'', vcattribs->>''dateOfRegistration''), (''due_diligence_status'', vcattribs->>''dueDiligenceStatus''), (''last_turnover_update'', vcattribs->>''lastTurnoverUpdate'')) AS t(attribute, data) WHERE itenantid = :tenantid :AttribsForm AND dtentrydatetime BETWEEN :StartDate AND :EndDate ORDER BY icustomerid DESC LIMIT :Load;"
    },
    "Normal": {
        "Account": "SELECT iaccountid AS \\"Account ID\\", icustomerid AS \\"Customer ID\\", vcexternalaccountid AS \\"External Account ID\\", vcaccountname AS \\"Account Name\\", dtonboardingdate AS \\"Onboarded On\\", imcc AS \\"MCC\\", bmerchant AS \\"Merchant\\", irecordstatus AS \\"Record Status\\" FROM masters.accounts WHERE itenantid = :tenantid AND dtentrydatetime BETWEEN :StartDate AND :EndDate ORDER BY iaccountid DESC LIMIT :Load;",
        "VPA": "SELECT ivpaid AS \\"VPA ID\\", iaccountid AS \\"Account ID\\", vcexternaladdressid AS \\"External Address ID\\", vcaddress AS \\"Payment Address\\", vcvpaname AS \\"VPA Name\\", imcc AS \\"MCC\\", bmerchant AS \\"Merchant\\", dtentrydatetime AS \\"Entry Date Time\\", irecordstatus AS \\"Record Status\\" FROM masters.vpa WHERE itenantid = :tenantid AND dtentrydatetime BETWEEN :StartDate AND :EndDate ORDER BY ivpaid DESC LIMIT :Load;",
        "Customer": "SELECT icustomerid AS \\"Customer ID\\", vcexternalcustid AS \\"Client External ID\\", vccustomername AS \\"Customer Name\\", vccustomertype AS \\"Customer Type\\", vcverifiedname AS \\"Verified Name\\", dtonboardingdate AS \\"Onboarded On\\", vcemail AS \\"Email\\", vcregisteredmobile AS \\"Registered Mobile\\", imcc AS \\"MCC\\", irecordstatus AS \\"Record Status\\", dtentrydatetime AS \\"Entry Date Time\\", vcattribs->>''panNo'' AS \\"Pan Number\\", vcattribs->>''purpose'' AS \\"Purpose\\", vcattribs->>''partnerID'' AS \\"Partner ID\\", vcattribs->>''partnerName'' AS \\"Partner Name\\", vcattribs->>''ecollectAccNo'' AS \\"Merchant No\\", vcattribs->>''merchant_type'' AS \\"Merchant Type\\", vcattribs->>''typeOfCompany'' AS \\"Type Of Company\\", vcattribs->>''clientIdentifier'' AS \\"Client Identifier\\", vcattribs->>''registeredAddress'' AS \\"Registered Address\\", vcattribs->>''dateOfRegistration'' AS \\"Date Of Registration\\", vcattribs->>''dueDiligenceStatus'' AS \\"Due Diligence Status\\", vcattribs->>''lastTurnoverUpdate'' AS \\"Last Turnover Update\\" FROM masters.customers WHERE itenantid = :tenantid AND dtentrydatetime BETWEEN :StartDate AND :EndDate ORDER BY icustomerid DESC LIMIT :Load;"
    }
}
'::text WHERE
idashboardqueryid = 48 AND itenantid = 16;

UPDATE ui.dashboardquery SET
vcdashboardquery =  E'{
    "Transpose": { 
        "Customer": "SELECT attribute, data FROM masters.customers, LATERAL (VALUES (''Customer ID'', CAST(icustomerid AS VARCHAR)), (''External Cust ID'', vcexternalcustid), (''Customer Name'', vccustomername), (''Onboarded On'', CAST(dtonboardingdate AS VARCHAR)), (''MCC'', CAST(imcc AS VARCHAR)), (''PAN'', vcattribs->''yb_raw''->>''pan''), (''City'', vcattribs->''yb_raw''->>''city''), (''GSTN'', vcattribs->''yb_raw''->>''gstn''), (''LLPIN'', vcattribs->''yb_raw''->>''llpIn''), (''State'', vcattribs->''yb_raw''->>''state''), (''Status'', vcattribs->''yb_raw''->>''status''), (''Channel'', vcattribs->''yb_raw''->>''channel''), (''Country'', vcattribs->''yb_raw''->>''country''), (''Pin Code'', vcattribs->''yb_raw''->>''pinCode''), (''District'', vcattribs->''yb_raw''->>''district''), (''Latitude'', vcattribs->''yb_raw''->>''latitude''), (''Longitude'', vcattribs->''yb_raw''->>''longitude''), (''Partner Name'', vcattribs->''yb_raw''->>''partnerName''), (''Business Name'', vcattribs->''yb_raw''->>''businessName''), (''Merchant Type'', vcattribs->''yb_raw''->>''merchantType''), (''Mobile Number'', vcattribs->''yb_raw''->>''mobileNumber''), (''Turn Over Type'', vcattribs->''yb_raw''->>''turnOverType''), (''Ownership Type'', vcattribs->''yb_raw''->>''ownershipType''), (''Acceptance Type'', vcattribs->''yb_raw''->>''acceptanceType''), (''Verified Account Name'', vcattribs->''yb_raw''->>''sellerVerifiedAccountName''), (''Record Status'', CAST(irecordstatus AS VARCHAR)), (''Entry Date Time'', CAST(dtentrydatetime AS VARCHAR))) AS t(attribute, data) WHERE itenantid = :tenantid AND dtentrydatetime BETWEEN :StartDate AND :EndDate ORDER BY icustomerid DESC LIMIT :Load;",
        "Account": "SELECT attribute, data FROM masters.accounts, LATERAL (VALUES (''Account ID'', CAST(iaccountid AS VARCHAR)), (''Customer ID'', CAST(icustomerid AS VARCHAR)), (''External Account ID'', vcexternalaccountid), (''Merchant'', CAST(bmerchant AS VARCHAR)), (''Record Status'', CAST(irecordstatus AS VARCHAR)), (''Entry Date Time'', CAST(dtentrydatetime AS VARCHAR))) AS t(attribute, data) WHERE itenantid = :tenantid AND dtentrydatetime BETWEEN :StartDate AND :EndDate ORDER BY iaccountid DESC LIMIT :Load;",
        "VPA": "SELECT attribute, data FROM masters.vpa, LATERAL (VALUES (''VPA ID'', CAST(ivpaid AS VARCHAR)), (''Account ID'', CAST(iaccountid AS VARCHAR)), (''External Address ID'', vcexternaladdressid), (''Payment Address'', vcaddress), (''VPA Name'', vcvpaname), (''MCC'', CAST(imcc AS VARCHAR)), (''Merchant'', CAST(bmerchant AS VARCHAR)), (''Entry Date Time'', CAST(dtentrydatetime AS VARCHAR)), (''Record Status'', CAST(irecordstatus AS VARCHAR)), (''Verified'', CAST(bverified AS VARCHAR))) AS t(attribute, data) WHERE itenantid = :tenantid AND dtentrydatetime BETWEEN :StartDate AND :EndDate ORDER BY ivpaid DESC LIMIT :Load;"
    },
    "Normal": {
        "Customer": "SELECT icustomerid AS \\"Customer ID\\", vcexternalcustid AS \\"External Cust ID\\", vccustomername AS \\"Customer Name\\", dtonboardingdate AS \\"Onboarded On\\", imcc AS \\"MCC\\", vcattribs->''yb_raw''->>''pan'' AS \\"PAN\\", vcattribs->''yb_raw''->>''city'' AS \\"City\\", vcattribs->''yb_raw''->>''gstn'' AS \\"GSTN\\", vcattribs->''yb_raw''->>''llpIn'' AS \\"LLPIN\\", vcattribs->''yb_raw''->>''state'' AS \\"State\\", vcattribs->''yb_raw''->>''status'' AS \\"Status\\", vcattribs->''yb_raw''->>''channel'' AS \\"Channel\\", vcattribs->''yb_raw''->>''country'' AS \\"Country\\", vcattribs->''yb_raw''->>''pinCode'' AS \\"Pin Code\\", vcattribs->''yb_raw''->>''district'' AS \\"District\\", vcattribs->''yb_raw''->>''latitude'' AS \\"Latitude\\", vcattribs->''yb_raw''->>''longitude'' AS \\"Longitude\\", vcattribs->''yb_raw''->>''partnerName'' AS \\"Partner Name\\", vcattribs->''yb_raw''->>''businessName'' AS \\"Business Name\\", vcattribs->''yb_raw''->>''merchantType'' AS \\"Merchant Type\\", vcattribs->''yb_raw''->>''mobileNumber'' AS \\"Mobile Number\\", vcattribs->''yb_raw''->>''turnOverType'' AS \\"Turn Over Type\\", vcattribs->''yb_raw''->>''ownershipType'' AS \\"Ownership Type\\", vcattribs->''yb_raw''->>''acceptanceType'' AS \\"Acceptance Type\\", vcattribs->''yb_raw''->>''sellerVerifiedAccountName'' AS \\"Verified Account Name\\", irecordstatus AS \\"Record Status\\", dtentrydatetime AS \\"Entry Date Time\\" FROM masters.customers WHERE itenantid = :tenantid AND dtentrydatetime BETWEEN :StartDate AND :EndDate ORDER BY icustomerid DESC LIMIT :Load;",
        "Account": "SELECT iaccountid AS \\"Account ID\\", icustomerid AS \\"Customer ID\\", vcexternalaccountid AS \\"External Account ID\\", bmerchant AS \\"Merchant\\", irecordstatus AS \\"Record Status\\", dtentrydatetime AS \\"Entry Date Time\\" FROM masters.accounts WHERE itenantid = :tenantid AND dtentrydatetime BETWEEN :StartDate AND :EndDate ORDER BY iaccountid DESC LIMIT :Load;",
        "VPA": "SELECT ivpaid AS \\"VPA ID\\", iaccountid AS \\"Account ID\\", vcexternaladdressid AS \\"External Address ID\\", vcaddress AS \\"Payment Address\\", vcvpaname AS \\"VPA Name\\", imcc AS \\"MCC\\", bmerchant AS \\"Merchant\\", dtentrydatetime AS \\"Entry Date Time\\", irecordstatus AS \\"Record Status\\", bverified AS \\"Verified\\" FROM masters.vpa WHERE itenantid = :tenantid AND dtentrydatetime BETWEEN :StartDate AND :EndDate ORDER BY ivpaid DESC LIMIT :Load;"
    }
}
'::text WHERE
idashboardqueryid = 48 AND itenantid in (9,19);



UPDATE ui.dashboardquery SET
vcdashboardquery =  E'{
    "Transpose": {
        "Customer": "SELECT attribute, data FROM masters.customers, LATERAL (VALUES (''Customer ID'', CAST(icustomerid AS VARCHAR)), (''MID'', vcexternalcustid), (''Customer Name'', vccustomername), (''Customer Type'', vccustomertype), (''Verified Name'', vcverifiedname), (''Onboarded On'', CAST(dtonboardingdate AS VARCHAR)), (''Email'', vcemail), (''Registered Mobile'', vcregisteredmobile), (''MCC'', CAST(imcc AS VARCHAR)), (''Record Status'', CAST(irecordstatus AS VARCHAR)), (''Identity Type 1'', vcidentitytype1), (''Identity Type 2'', vcidentitytype2), (''Identity Detail 2'', vcidentitydetails2), (''KYC Type'', vcattribs->>''kyc_type''), (''Geolocation'', vcregisteredaddressgeolocation), (''Max Declared Salary'', vcattribs->>''declared_salary_max''), (''State'', vcattribs->>''state''), (''Program ID'', vcattribs->>''programId'')) AS t(attribute, data) WHERE itenantid = :tenantid :AttribsForm AND dtentrydatetime BETWEEN :StartDate AND :EndDate ORDER BY icustomerid DESC LIMIT :Load;",
        "Account": "SELECT attribute, data FROM masters.accounts, LATERAL (VALUES (''Account ID'', CAST(iaccountid AS VARCHAR)), (''Customer ID'', CAST(icustomerid AS VARCHAR)), (''External Account ID'', vcexternalaccountid), (''Account Name'', vcaccountname), (''Onboarded On'', CAST(dtonboardingdate AS VARCHAR)), (''MCC'', CAST(imcc AS VARCHAR)), (''Merchant'', CAST(bmerchant AS VARCHAR)), (''Record Status'', CAST(irecordstatus AS VARCHAR)), (''Entry Date Time'', CAST(dtentrydatetime AS VARCHAR)), (''IFSC'', vcifsc)) AS t(attribute, data) WHERE itenantid = :tenantid :AttribsForm AND dtentrydatetime BETWEEN :StartDate AND :EndDate ORDER BY iaccountid DESC LIMIT :Load;",
        "VPA": "SELECT attribute, data FROM masters.vpa, LATERAL (VALUES (''VPA ID'', CAST(ivpaid AS VARCHAR)), (''Account ID'', CAST(iaccountid AS VARCHAR)), (''External Address'', vcexternaladdressid), (''Payment Address'', vcaddress), (''VPA Name'', vcvpaname), (''MCC'', CAST(imcc AS VARCHAR)), (''Merchant'', CAST(bmerchant AS VARCHAR)), (''Entry Date Time'', CAST(dtentrydatetime AS VARCHAR)), (''Record Status'', CAST(irecordstatus AS VARCHAR)), (''Merchant Type'', vcattribs->>''merchanttype''), (''Verified'', CAST(bverified AS VARCHAR)), (''Expiry Date'', CAST(dtexpirydate AS VARCHAR)), (''Program ID'', vcattribs->>''programId''), (''Card Brand'', vcattribs->>''card_brand'')) AS t(attribute, data) WHERE itenantid = :tenantid :AttribsForm AND dtentrydatetime BETWEEN :StartDate AND :EndDate ORDER BY ivpaid DESC LIMIT :Load;"
    },
    "Normal": {
        "Customer": "SELECT icustomerid AS \\"Customer ID\\", vcexternalcustid AS \\"MID\\", vccustomername AS \\"Customer Name\\", vccustomertype AS \\"Customer Type\\", vcverifiedname AS \\"Verified Name\\", dtonboardingdate AS \\"Onboarded On\\", vcemail AS \\"Email\\", vcregisteredmobile AS \\"Registered Mobile\\", imcc AS \\"MCC\\", irecordstatus AS \\"Record Status\\", vcidentitytype1 AS \\"Identity Type 1\\", vcidentitytype2 AS \\"Identity Type 2\\", vcidentitydetails2 AS \\"Identity Detail 2\\", vcattribs->>''kyc_type'' AS \\"KYC Type\\", vcregisteredaddressgeolocation AS \\"Geolocation\\", vcattribs->>''declared_salary_max'' AS \\"Max Declared Salary\\", vcattribs->>''state'' AS \\"State\\", vcattribs->>''programId'' AS \\"Program ID\\" FROM masters.customers WHERE itenantid = :tenantid AND dtentrydatetime BETWEEN :StartDate AND :EndDate ORDER BY icustomerid DESC LIMIT :Load;",
        "Account": "SELECT iaccountid AS \\"Account ID\\", icustomerid AS \\"Customer ID\\", vcexternalaccountid AS \\"External Account ID\\", vcaccountname AS \\"Account Name\\", dtonboardingdate AS \\"Onboarded On\\", imcc AS \\"MCC\\", bmerchant AS \\"Merchant\\", irecordstatus AS \\"Record Status\\", dtentrydatetime AS \\"Entry Date Time\\", vcifsc AS \\"IFSC\\" FROM masters.accounts WHERE itenantid = :tenantid AND dtentrydatetime BETWEEN :StartDate AND :EndDate ORDER BY iaccountid DESC LIMIT :Load;",
        "VPA": "SELECT ivpaid AS \\"VPA ID\\", iaccountid AS \\"Account ID\\", vcexternaladdressid AS \\"External Address\\", vcaddress AS \\"Payment Address\\", vcvpaname AS \\"VPA Name\\", imcc AS \\"MCC\\", bmerchant AS \\"Merchant\\", dtentrydatetime AS \\"Entry Date Time\\", irecordstatus AS \\"Record Status\\", vcattribs->>''merchanttype'' AS \\"Merchant Type\\", bverified AS \\"Verified\\", dtexpirydate AS \\"Expiry Date\\", vcattribs->>''programId'' AS \\"Program ID\\", vcattribs->>''card_brand'' AS \\"Card Brand\\" FROM masters.vpa WHERE itenantid = :tenantid AND dtentrydatetime BETWEEN :StartDate AND :EndDate ORDER BY ivpaid DESC LIMIT :Load;"
    }
}
'::text WHERE
idashboardqueryid = 48 AND itenantid in (20, 24,7,6);

UPDATE ui.dashboardquery SET
vcdashboardquery =  E'{
    "Transpose": {
        "Customer": "SELECT attribute, data FROM masters.customers, LATERAL (VALUES (''Customer ID'', CAST(icustomerid AS VARCHAR)), (''External Cust ID'', vcexternalcustid), (''Customer Name'', vccustomername), (''Customer Type'', vccustomertype), (''Verified Name'', vcverifiedname), (''Onboarding Date'', CAST(dtonboardingdate AS VARCHAR)), (''Email ID'', vcemail), (''Registered Mobile Number'', vcregisteredmobile), (''MCC'', CAST(imcc AS VARCHAR)), (''Country Code'', vccountrycode), (''Record Status'', CAST(irecordstatus AS VARCHAR)), (''Entry Date Time'', CAST(dtentrydatetime AS VARCHAR)), (''Last Modified'', CAST(lastmodified AS VARCHAR)), (''KYC'', vcattribs->>''kyc''), (''Risk'', vcattribs->>''risk''), (''Dealer ID'', vcattribs->>''dealer_id''), (''Gross Income'', vcattribs->>''gross_income''), (''Source Of Income'', vcattribs->>''source_of_income''), (''Termination Status'', vcattribs->>''termination_status''), (''Customer Onboarding Type'', vcattribs->>''customer_onboard_type''), (''Occupation'', vcattribs->>''occupation''), (''City'', vcattribs->>''city''), (''State'', vcattribs->>''state''), (''Account Type'', vcattribs->>''accountType''), (''Gender'', vcattribs->>''gender''), (''Account Sub Type'', vcattribs->>''accountSubType''), (''DOB'', vcattribs->>''doi_dob''), (''Mobile Num Update Time'', vcattribs->>''Mobile_no_UpdateTime''), (''Postal Code'', vcpostalcode), (''UCIC ID'', vcattribs->>''ucic_id''), (''Salutation'', vcsalutation), (''VC Gender'', vcgender), (''Birth Date'', CAST(dtdoidob AS VARCHAR)), (''Identity Type 1'', vcidentitytype1), (''Identity Detail 1'', vcidentitydetails1), (''Identity Type 2'', vcidentitytype2), (''Identity Detail 2'', vcidentitydetails2), (''Registered Address Geolocation'', vcregisteredaddressgeolocation)) AS t(attribute, data) WHERE itenantid = :tenantid :AttribsForm AND dtentrydatetime BETWEEN :StartDate AND :EndDate ORDER BY icustomerid DESC LIMIT :Load;",
        "Account": "SELECT attribute, data FROM masters.accounts, LATERAL (VALUES (''Account ID'', CAST(iaccountid AS VARCHAR)), (''Customer ID'', CAST(icustomerid AS VARCHAR)), (''External Account ID'', vcexternalaccountid), (''Account Name'', vcaccountname), (''Account Type'',  CAST(iaccounttypeid AS VARCHAR)), (''IFSC'', vcifsc), (''Account Number'', vcaccount),(''Verified'', CAST(bverified AS VARCHAR)), (''MCC'', CAST(imcc AS VARCHAR)), (''Merchant'', CAST(bmerchant AS VARCHAR)), (''Record Status'', CAST(irecordstatus AS VARCHAR)), (''Entry Date Time'', CAST(dtentrydatetime AS VARCHAR)), (''Onboarding Date'', CAST(dtonboardingdate AS VARCHAR)),(''Last Modified'', CAST(lastmodified AS VARCHAR))) AS t(attribute, data) WHERE itenantid = :tenantid :AttribsForm AND dtentrydatetime BETWEEN :StartDate AND :EndDate ORDER BY iaccountid DESC LIMIT :Load;",
        "VPA": "SELECT attribute, data FROM masters.vpa, LATERAL (VALUES (''VPA ID'', CAST(ivpaid AS VARCHAR)), (''Account ID'', CAST(iaccountid AS VARCHAR)), (''External VPA ID'', vcexternaladdressid), (''VPA'', vcaddress), (''Customer Name'', vcvpaname), (''Verified'', CAST(bverified AS VARCHAR)), (''MCC'', CAST(imcc AS VARCHAR)), (''Merchant'', CAST(bmerchant AS VARCHAR)), (''Record Status'', CAST(irecordstatus AS VARCHAR)), (''Entry Date Time'', CAST(dtentrydatetime AS VARCHAR)), (''Onboarding Date'', CAST(dtonboardingdate AS VARCHAR)), (''Product ID'', CAST(iproductid AS VARCHAR)), (''Expires On'', CAST(dtexpirydate AS VARCHAR)), (''Last Modified On'', CAST(lastmodified AS VARCHAR))) AS t(attribute, data) WHERE itenantid = :tenantid :AttribsForm AND dtentrydatetime BETWEEN :StartDate AND :EndDate ORDER BY ivpaid DESC LIMIT :Load;"
    },
    "Normal": {
        "Customer": "SELECT icustomerid AS \\"Customer ID\\", vcexternalcustid AS \\"External Cust ID\\", vccustomername AS \\"Customer Name\\", vccustomertype AS \\"Customer Type\\", vcverifiedname AS \\"Verified Name\\", dtonboardingdate AS \\"Onboarding Date\\", vcemail AS \\"Email ID\\", vcregisteredmobile AS \\"Registered Mobile Number\\", imcc AS \\"MCC\\", vccountrycode AS \\"Country Code\\", irecordstatus AS \\"Record Status\\", dtentrydatetime AS \\"Entry Date Time\\", lastmodified AS \\"Last Modified\\", vcattribs->>''kyc'' AS \\"KYC\\", vcattribs->>''risk'' AS \\"Risk\\", vcattribs->>''dealer_id'' AS \\"Dealer ID\\", vcattribs->>''gross_income'' AS \\"Gross Income\\", vcattribs->>''source_of_income'' AS \\"Source Of Income\\", vcattribs->>''termination_status'' AS \\"Termination Status\\", vcattribs->>''customer_onboard_type'' AS \\"Customer Onboarding Type\\", vcattribs->>''occupation'' AS \\"Occupation\\", vcattribs->>''city'' AS \\"City\\", vcattribs->>''state'' AS \\"State\\", vcattribs->>''accountType'' AS \\"Account Type\\", vcattribs->>''gender'' AS \\"Gender\\", vcattribs->>''accountSubType'' AS \\"Account Sub Type\\", vcattribs->>''doi_dob'' AS \\"DOB\\", vcattribs->>''Mobile_no_UpdateTime'' AS \\"Mobile Num Update Time\\", vcpostalcode AS \\"Postal Code\\", vcattribs->>''ucic_id'' AS \\"UCIC ID\\", vcsalutation AS \\"Salutation\\", vcgender AS \\"VC Gender\\", dtdoidob AS \\"Birth Date\\", vcidentitytype1 AS \\"Identity Type 1\\", vcidentitydetails1 AS \\"Identity Detail 1\\", vcidentitytype2 AS \\"Identity Type 2\\", vcidentitydetails2 AS \\"Identity Detail 2\\", vcregisteredaddressgeolocation AS \\"Registered Address Geolocation\\" FROM masters.customers WHERE itenantid = :tenantid :AttribsForm AND dtentrydatetime BETWEEN :StartDate AND :EndDate ORDER BY icustomerid DESC LIMIT :Load;",
        "Account": "SELECT iaccountid AS \\"Account ID\\", icustomerid AS \\"Customer ID\\", vcexternalaccountid AS \\"External Account ID\\", vcaccountname AS \\"Account Name\\", iaccounttypeid AS \\"Account Type\\", bverified AS \\"Verified\\",  dtonboardingdate AS \\"Onboarding Date\\", vcifsc AS \\"IFSC\\", vcaccount AS \\"Account Number\\", imcc AS \\"MCC\\", bmerchant AS \\"Merchant\\", irecordstatus AS \\"Record Status\\", dtentrydatetime AS \\"Entry Date Time\\", lastmodified AS \\"Last Modified\\" FROM masters.accounts WHERE itenantid = :tenantid :AttribsForm AND dtentrydatetime BETWEEN :StartDate AND :EndDate ORDER BY iaccountid DESC LIMIT :Load;",
        "VPA": "SELECT ivpaid AS \\"VPA ID\\", iaccountid AS \\"Account ID\\", vcexternaladdressid AS \\"External VPA ID\\", vcaddress AS \\"VPA\\", vcvpaname AS \\"Customer Name\\", bverified AS \\"Verified\\", imcc AS \\"MCC\\", bmerchant AS \\"Merchant\\", irecordstatus AS \\"Record Status\\", dtentrydatetime AS \\"Entry Date Time\\", dtonboardingdate AS \\"Onboarding Date\\", iproductid AS \\"Product ID\\", dtexpirydate AS \\"Expires On\\", lastmodified AS \\"Last Modified On\\" FROM masters.vpa WHERE itenantid = :tenantid :AttribsForm AND dtentrydatetime BETWEEN :StartDate AND :EndDate ORDER BY ivpaid DESC LIMIT :Load;"
    }
}
'::text WHERE
idashboardqueryid = 48 AND itenantid in (12,13);

UPDATE ui.dashboardquery SET
vcdashboardquery =  E'
{
    "Transpose": {
        "Customer": "SELECT attribute, data FROM masters.customers, LATERAL (VALUES (''Customer ID'', CAST(icustomerid AS VARCHAR)), (''External Cust ID'', vcexternalcustid), (''Customer Name'', vccustomername), (''Customer Type'', vccustomertype), (''Verified Name'', vcverifiedname), (''Onboarding Date'', CAST(dtonboardingdate AS VARCHAR)), (''Email ID'', vcemail), (''Registered Mobile'', vcregisteredmobile), (''MCC'', CAST(imcc AS VARCHAR)), (''Country Code'', vccountrycode), (''Record Status'', CAST(irecordstatus AS VARCHAR)), (''Entry Timestamp'', CAST(dtentrydatetime AS VARCHAR)), (''Latitude'', vcattribs->>''latitude''), (''Longitude'', vcattribs->>''longitude''), (''Daily Transaction Value'', vcattribs->>''dailyTransactionValue''), (''Daily Transaction Volume'', vcattribs->>''dailyTransactionVolume''), (''Cumulative Daily Transaction Volume'', vcattribs->>''cumulativeDailyTransactionVolume''), (''Cumulative Daily Transaction Count'', vcattribs->>''cumulativeDailyTransactionCount''), (''Cumulative Daily Transaction Exit Volume'', vcattribs->>''cumulativeDailyTransactionExitVolume''), (''Cumulative Daily Refund Volume'', vcattribs->>''cumulativeDailyRefundVolume''), (''Merchant Type'', vcattribs->>''merchantType''), (''Business Channel'', vcattribs->>''businessChannel''), (''Group ID'', vcattribs->>''groupId''), (''Sub-Group ID'', vcattribs->>''subGroupId''), (''Cumulative Daily Refund Count'', vcattribs->>''cumulativeDailyRefundCount''), (''Cumulative Daily Refund Exit Volume'', vcattribs->>''cumulativeDailyRefundExitVolume''), (''Cumulative Daily Refund Exit Count'', vcattribs->>''cumulativeDailyRefundExitCount''), (''Business Legal Name'', vcattribs->>''business_legal_name''), (''Date of Incorporation'', vcattribs->>''date_of_incorporation''), (''Status'', vcattribs->>''status''), (''GST Business Type'', vcattribs->>''business_type''), (''GST Business Division'', vcattribs->>''business_division''), (''Merchant Category'', vcattribs->>''merchantCategory''), (''Web Address'', vcattribs->>''web_address''), (''Address Line 1'', vcattribs->>''address_line1''), (''Address Line 2'', vcattribs->>''address_line2''), (''City'', vcattribs->>''city''), (''State'', vcattribs->>''state''), (''Country'', vcattribs->>''country''), (''Postal Code'', vcattribs->>''postal_code''), (''Gender'', vcattribs->>''gender''), (''Date of Birth'', vcattribs->>''date_of_birth''), (''Actual Start Date'', vcattribs->>''kyc_ApprovalDate''), (''KYC Creation Date'', vcattribs->>''kyc_CreationDate''), (''International Acceptance'', vcattribs->>''internationalAcceptance''), (''Acceptance Type'', vcattribs->>''acceptanceType''), (''Delivery Period'', vcattribs->>''deliveryPeriod''), (''POI Number'', vcattribs->>''poi_number''), (''POI Type'', vcattribs->>''poi_type''), (''POI Expiry Date'', vcattribs->>''poi_expiry_date''), (''POA Number'', vcattribs->>''poa_number''), (''POA Type'', vcattribs->>''poa_type''), (''POA Expiry Date'', vcattribs->>''poa_expiry_date''), (''POB Number'', vcattribs->>''pob_number''), (''POB Type'', vcattribs->>''pob_type''), (''POB Expiry Date'', vcattribs->>''pob_expiry_date''), (''First Name - Authorized Signatory'', vcattribs->>''auth_sign_firstName''), (''Middle Name - Authorized Signatory'', vcattribs->>''auth_sign_middleName''), (''Last Name - Authorized Signatory'', vcattribs->>''auth_sign_lastName''), (''Registered Mobile - Authorized Signatory'', vcattribs->>''auth_sign_registered_mobile''), (''Email - Authorized Signatory'', vcattribs->>''auth_sign_email''), (''Address Line 1 - Authorized Signatory'', vcattribs->>''auth_sign_address_line1''), (''Address Line 2 - Authorized Signatory'', vcattribs->>''auth_sign_address_line2''), (''State - Authorized Signatory'', vcattribs->>''auth_sign_state''), (''City - Authorized Signatory'', vcattribs->>''auth_sign_city''), (''Country - Authorized Signatory'', vcattribs->>''auth_sign_country''), (''Postal Code - Authorized Signatory'', vcattribs->>''auth_sign_postal_code''), (''Program Category'', vcattribs->>''program_category''), (''Program Reference ID'', vcattribs->>''program_referenceID''), (''Merchant Bank Name'', vcattribs->>''merchantBankName''), (''Business Category'', vcattribs->>''businessCategory''), (''Business Line'', vcattribs->>''businessLine''), (''Settlement Frequency'', vcattribs->>''settlementFrequency''), (''MID Blocked Date'', vcattribs->>''mid_BlockedDate''), (''MID Blocked By'', vcattribs->>''mid_BlockedBy'')) AS t(attribute, data) WHERE itenantid = :tenantid :AttribsForm ORDER BY icustomerid DESC LIMIT :Load;",
        "Account": "SELECT attribute, data FROM masters.accounts, LATERAL (VALUES (''Account ID'', CAST(iaccountid AS VARCHAR)), (''Customer ID'', CAST(icustomerid AS VARCHAR)), (''External Account ID'', vcexternalaccountid), (''IFSC'', vcifsc), (''Account Name'', vcaccountname), (''Account Type'', CAST(iaccounttypeid AS VARCHAR)), (''MCC'', CAST(imcc AS VARCHAR)), (''Merchant'', CAST(bmerchant AS VARCHAR)), (''Record Status'', CAST(irecordstatus AS VARCHAR)), (''Entry Timestamp'', CAST(dtentrydatetime AS VARCHAR)), (''Onboarding Date'', CAST(dtonboardingdate AS VARCHAR)), (''Expiry Date'', CAST(dtexpirydate AS VARCHAR))) AS t(attribute, data) WHERE itenantid = :tenantid :AttribsForm ORDER BY iaccountid DESC LIMIT :Load;",
        "VPA": "SELECT attribute, data FROM masters.vpa, LATERAL (VALUES (''VPA ID'', CAST(ivpaid AS VARCHAR)), (''Account ID'', CAST(iaccountid AS VARCHAR)), (''External VPA ID'', vcexternaladdressid), (''VPA Address'', vcaddress), (''VPA Name'', vcvpaname), (''MCC'', CAST(imcc AS VARCHAR)), (''Merchant'', CAST(bmerchant AS VARCHAR)), (''Record Status'', CAST(irecordstatus AS VARCHAR)), (''Entry Timestamp'', CAST(dtentrydatetime AS VARCHAR)), (''Onboarding Date'', CAST(dtonboardingdate AS VARCHAR)), (''Product ID'', CAST(iproductid AS VARCHAR))) AS t(attribute, data) WHERE itenantid = :tenantid :AttribsForm ORDER BY ivpaid DESC LIMIT :Load;"
    },
    "Normal": {
        "Customer": "SELECT icustomerid AS \\"Customer ID\\", vcexternalcustid AS \\"External Cust ID\\", vccustomername AS \\"Customer Name\\", vccustomertype AS \\"Customer Type\\", vcverifiedname AS \\"Verified Name\\", dtonboardingdate AS \\"Onboarding Date\\", vcemail AS \\"Email ID\\", vcregisteredmobile AS \\"Registered Mobile\\", imcc AS \\"MCC\\", vccountrycode AS \\"Country Code\\", irecordstatus AS \\"Record Status\\", dtentrydatetime AS \\"Entry Timestamp\\", vcattribs->>''latitude'' AS \\"Latitude\\", vcattribs->>''longitude'' AS \\"Longitude\\", vcattribs->>''dailyTransactionValue'' AS \\"Daily Transaction Value\\", vcattribs->>''dailyTransactionVolume'' AS \\"Daily Transaction Volume\\", vcattribs->>''cumulativeDailyTransactionVolume'' AS \\"Cumulative Daily Transaction Volume\\", vcattribs->>''cumulativeDailyTransactionCount'' AS \\"Cumulative Daily Transaction Count\\", vcattribs->>''cumulativeDailyTransactionExitVolume'' AS \\"Cumulative Daily Transaction Exit Volume\\", vcattribs->>''cumulativeDailyRefundVolume'' AS \\"Cumulative Daily Refund Volume\\", vcattribs->>''merchantType'' AS \\"Merchant Type\\", vcattribs->>''businessChannel'' AS \\"Business Channel\\", vcattribs->>''groupId'' AS \\"Group ID\\", vcattribs->>''subGroupId'' AS \\"Sub-Group ID\\", vcattribs->>''cumulativeDailyRefundCount'' AS \\"Cumulative Daily Refund Count\\", vcattribs->>''cumulativeDailyRefundExitVolume'' AS \\"Cumulative Daily Refund Exit Volume\\", vcattribs->>''cumulativeDailyRefundExitCount'' AS \\"Cumulative Daily Refund Exit Count\\", vcattribs->>''business_legal_name'' AS \\"Business Legal Name\\", vcattribs->>''date_of_incorporation'' AS \\"Date of Incorporation\\", vcattribs->>''status'' AS \\"Status\\", vcattribs->>''business_type'' AS \\"GST Business Type\\", vcattribs->>''business_division'' AS \\"GST Business Division\\", vcattribs->>''merchantCategory'' AS \\"Merchant Category\\", vcattribs->>''web_address'' AS \\"Web Address\\", vcattribs->>''address_line1'' AS \\"Address Line 1\\", vcattribs->>''address_line2'' AS \\"Address Line 2\\", vcattribs->>''city'' AS \\"City\\", vcattribs->>''state'' AS \\"State\\", vcattribs->>''country'' AS \\"Country\\", vcattribs->>''postal_code'' AS \\"Postal Code\\", vcattribs->>''gender'' AS \\"Gender\\", vcattribs->>''date_of_birth'' AS \\"Date of Birth\\", vcattribs->>''kyc_ApprovalDate'' AS \\"Actual Start Date\\", vcattribs->>''kyc_CreationDate'' AS \\"KYC Creation Date\\", vcattribs->>''internationalAcceptance'' AS \\"International Acceptance\\", vcattribs->>''acceptanceType'' AS \\"Acceptance Type\\", vcattribs->>''deliveryPeriod'' AS \\"Delivery Period\\", vcattribs->>''poi_number'' AS \\"POI Number\\", vcattribs->>''poi_type'' AS \\"POI Type\\", vcattribs->>''poi_expiry_date'' AS \\"POI Expiry Date\\", vcattribs->>''poa_number'' AS \\"POA Number\\", vcattribs->>''poa_type'' AS \\"POA Type\\", vcattribs->>''poa_expiry_date'' AS \\"POA Expiry Date\\", vcattribs->>''pob_number'' AS \\"POB Number\\", vcattribs->>''pob_type'' AS \\"POB Type\\", vcattribs->>''pob_expiry_date'' AS \\"POB Expiry Date\\", vcattribs->>''auth_sign_firstName'' AS \\"First Name - Authorized Signatory\\", vcattribs->>''auth_sign_middleName'' AS \\"Middle Name - Authorized Signatory\\", vcattribs->>''auth_sign_lastName'' AS \\"Last Name - Authorized Signatory\\", vcattribs->>''auth_sign_registered_mobile'' AS \\"Registered Mobile - Authorized Signatory\\", vcattribs->>''auth_sign_email'' AS \\"Email - Authorized Signatory\\", vcattribs->>''auth_sign_address_line1'' AS \\"Address Line 1 - Authorized Signatory\\", vcattribs->>''auth_sign_address_line2'' AS \\"Address Line 2 - Authorized Signatory\\", vcattribs->>''auth_sign_state'' AS \\"State - Authorized Signatory\\", vcattribs->>''auth_sign_city'' AS \\"City - Authorized Signatory\\", vcattribs->>''auth_sign_country'' AS \\"Country - Authorized Signatory\\", vcattribs->>''auth_sign_postal_code'' AS \\"Postal Code - Authorized Signatory\\", vcattribs->>''program_category'' AS \\"Program Category\\", vcattribs->>''program_referenceID'' AS \\"Program Reference ID\\", vcattribs->>''merchantBankName'' AS \\"Merchant Bank Name\\", vcattribs->>''businessCategory'' AS \\"Business Category\\", vcattribs->>''businessLine'' AS \\"Business Line\\", vcattribs->>''settlementFrequency'' AS \\"Settlement Frequency\\", vcattribs->>''mid_BlockedDate'' AS \\"MID Blocked Date\\", vcattribs->>''mid_BlockedBy'' AS \\"MID Blocked By\\" FROM masters.customers WHERE itenantid = :tenantid :AttribsForm ORDER BY icustomerid DESC LIMIT :Load;",
        "Account": "SELECT iaccountid AS \\"Account ID\\", icustomerid AS \\"Customer ID\\", vcexternalaccountid AS \\"External Account ID\\", vcifsc AS \\"IFSC\\", vcaccountname AS \\"Account Name\\", iaccounttypeid AS \\"Account Type\\", imcc AS \\"MCC\\", bmerchant AS \\"Merchant\\", irecordstatus AS \\"Record Status\\", dtentrydatetime AS \\"Entry Timestamp\\", dtonboardingdate AS \\"Onboarding Date\\", dtexpirydate AS \\"Expiry Date\\" FROM masters.accounts WHERE itenantid = :tenantid :AttribsForm ORDER BY iaccountid DESC LIMIT :Load;",
        "VPA": "SELECT ivpaid AS \\"VPA ID\\", iaccountid AS \\"Account ID\\", vcexternaladdressid AS \\"External VPA ID\\", vcaddress AS \\"VPA Address\\", vcvpaname AS \\"VPA Name\\", imcc AS \\"MCC\\", bmerchant AS \\"Merchant\\", irecordstatus AS \\"Record Status\\", dtentrydatetime AS \\"Entry Timestamp\\", dtonboardingdate AS \\"Onboarding Date\\", iproductid AS \\"Product ID\\" FROM masters.vpa WHERE itenantid = :tenantid :AttribsForm ORDER BY ivpaid DESC LIMIT :Load;"
    }
}
'::text WHERE
idashboardqueryid = 48 AND itenantid in (14, 15);


UPDATE ui.dashboardquery SET
vcdashboardquery =  E'
{
    "Transpose": {
        "Customer": "SELECT attribute, data FROM masters.customers, LATERAL (VALUES (''Customer ID'', CAST(icustomerid AS VARCHAR)), (''External Cust ID'', vcexternalcustid), (''Customer Name'', vccustomername), (''Onboarded On'', CAST(dtonboardingdate AS VARCHAR)), (''MCC'', CAST(imcc AS VARCHAR)), (''Mobile Number'', vcregisteredmobile), (''Record Status'', CAST(irecordstatus AS VARCHAR)), (''Customer Type'', vccustomertype), (''Country Code'', vccountrycode), (''Entry Date Time'', CAST(dtentrydatetime AS VARCHAR)), (''Email Id'', vcemail)) AS t(attribute, data) WHERE itenantid = :tenantid :AttribsForm AND dtentrydatetime BETWEEN :StartDate AND :EndDate ORDER BY icustomerid DESC LIMIT :Load;",
        "Account": "SELECT attribute, data FROM masters.accounts, LATERAL (VALUES (''Account ID'', CAST(iaccountid AS VARCHAR)), (''Customer ID'', CAST(icustomerid AS VARCHAR)), (''External Account ID'', vcexternalaccountid), (''Merchant'', CAST(bmerchant AS VARCHAR)), (''Record Status'', CAST(irecordstatus AS VARCHAR)), (''Entry Date Time'', CAST(dtentrydatetime AS VARCHAR)), (''IFSC'', vcifsc), (''Account Name'', vcaccountname), (''Onboarded On'', CAST(dtonboardingdate AS VARCHAR)), (''MCC'', CAST(imcc AS VARCHAR))) AS t(attribute, data) WHERE itenantid = :tenantid :AttribsForm AND dtentrydatetime BETWEEN :StartDate AND :EndDate ORDER BY iaccountid DESC LIMIT :Load;",
        "VPA": "SELECT attribute, data FROM masters.vpa, LATERAL (VALUES (''VPA ID'', CAST(ivpaid AS VARCHAR)), (''Account ID'', CAST(iaccountid AS VARCHAR)), (''External Address ID'', vcexternaladdressid), (''Payment Address'', vcaddress), (''VPA Name'', vcvpaname), (''MCC'', CAST(imcc AS VARCHAR)), (''Merchant'', CAST(bmerchant AS VARCHAR)), (''Entry Date Time'', CAST(dtentrydatetime AS VARCHAR)), (''Record Status'', CAST(irecordstatus AS VARCHAR)), (''Onboarded On'', CAST(dtonboardingdate AS VARCHAR)), (''Verified'', CAST(bverified AS VARCHAR))) AS t(attribute, data) WHERE itenantid = :tenantid :AttribsForm AND dtentrydatetime BETWEEN :StartDate AND :EndDate ORDER BY ivpaid DESC LIMIT :Load;"
    },
    "Normal": {
        "Customer": "SELECT icustomerid AS \\"Customer ID\\", vcexternalcustid AS \\"External Cust ID\\", vccustomername AS \\"Customer Name\\", dtonboardingdate AS \\"Onboarded On\\", imcc AS \\"MCC\\", vcregisteredmobile AS \\"Mobile Number\\", irecordstatus AS \\"Record Status\\", vccustomertype AS \\"Customer Type\\", vccountrycode AS \\"Country Code\\", dtentrydatetime AS \\"Entry Date Time\\", vcemail AS \\"Email Id\\" FROM masters.customers WHERE itenantid = :tenantid :AttribsForm AND dtentrydatetime BETWEEN :StartDate AND :EndDate  ORDER BY icustomerid DESC LIMIT :Load;",
        "Account": "SELECT iaccountid AS \\"Account ID\\", icustomerid AS \\"Customer ID\\", vcexternalaccountid AS \\"External Account ID\\", bmerchant AS \\"Merchant\\", irecordstatus AS \\"Record Status\\", dtentrydatetime AS \\"Entry Date Time\\", vcifsc AS \\"IFSC\\", vcaccountname AS \\"Account Name\\", dtonboardingdate AS \\"Onboarded On\\", imcc AS \\"MCC\\" FROM masters.accounts WHERE itenantid = :tenantid :AttribsForm AND dtentrydatetime BETWEEN :StartDate AND :EndDate  ORDER BY iaccountid DESC LIMIT :Load;",
        "VPA": "SELECT ivpaid AS \\"VPA ID\\", iaccountid AS \\"Account ID\\", vcexternaladdressid AS \\"External Address ID\\", vcaddress AS \\"Payment Address\\", vcvpaname AS \\"VPA Name\\", imcc AS \\"MCC\\", bmerchant AS \\"Merchant\\", dtentrydatetime AS \\"Entry Date Time\\", irecordstatus AS \\"Record Status\\", dtonboardingdate AS \\"Onboarded On\\", bverified AS \\"Verified\\" FROM masters.vpa WHERE itenantid = :tenantid :AttribsForm AND dtentrydatetime BETWEEN :StartDate AND :EndDate  ORDER BY ivpaid DESC LIMIT :Load;"
    }
}
'::text WHERE
idashboardqueryid = 48 AND itenantid = 21;

UPDATE ui.dashboardquery SET
vcdashboardquery =  E'{
    "Transpose": {
        "Customer": "SELECT attribute, data FROM masters.customers, LATERAL (VALUES (''Customer ID'', CAST(icustomerid AS VARCHAR)), (''External Cust ID'', vcexternalcustid), (''Customer Name'', vccustomername), (''Onboarded On'', CAST(dtonboardingdate AS VARCHAR)), (''MCC'', CAST(imcc AS VARCHAR)), (''Mobile Number'', vcregisteredmobile), (''Record Status'', CAST(irecordstatus AS VARCHAR)), (''Entry Date Time'', CAST(dtentrydatetime AS VARCHAR)), (''Email Id'', vcemail)) AS t(attribute, data) WHERE itenantid = :tenantid :AttribsForm ORDER BY icustomerid DESC LIMIT :Load;",
        "Account": "SELECT attribute, data FROM masters.accounts, LATERAL (VALUES (''Account ID'', CAST(iaccountid AS VARCHAR)), (''Customer ID'', CAST(icustomerid AS VARCHAR)), (''External Account ID'', vcexternalaccountid), (''Merchant'', CAST(bmerchant AS VARCHAR)), (''Record Status'', CAST(irecordstatus AS VARCHAR)), (''Entry Date Time'', CAST(dtentrydatetime AS VARCHAR)), (''Account Name'', vcaccountname), (''Onboarded On'', CAST(dtonboardingdate AS VARCHAR)), (''MCC'', CAST(imcc AS VARCHAR))) AS t(attribute, data) WHERE itenantid = :tenantid :AttribsForm ORDER BY iaccountid DESC LIMIT :Load;",
        "VPA": "SELECT attribute, data FROM masters.vpa, LATERAL (VALUES (''VPA ID'', CAST(ivpaid AS VARCHAR)), (''Account ID'', CAST(iaccountid AS VARCHAR)), (''External Address ID'', vcexternaladdressid), (''Payment Address'', vcaddress), (''VPA Name'', vcvpaname), (''MCC'', CAST(imcc AS VARCHAR)), (''Merchant'', CAST(bmerchant AS VARCHAR)), (''Entry Date Time'', CAST(dtentrydatetime AS VARCHAR)), (''Record Status'', CAST(irecordstatus AS VARCHAR)), (''Onboarded On'', CAST(dtonboardingdate AS VARCHAR)), (''Verified'', CAST(bverified AS VARCHAR))) AS t(attribute, data) WHERE itenantid = :tenantid :AttribsForm ORDER BY ivpaid DESC LIMIT :Load;"
    },
    "Normal": {
        "Customer": "SELECT icustomerid AS \\"Customer ID\\", vcexternalcustid AS \\"External Cust ID\\", vccustomername AS \\"Customer Name\\", dtonboardingdate AS \\"Onboarded On\\", imcc AS \\"MCC\\", vcregisteredmobile AS \\"Mobile Number\\", irecordstatus AS \\"Record Status\\", dtentrydatetime AS \\"Entry Date Time\\", vcemail AS \\"Email Id\\" FROM masters.customers WHERE itenantid = :tenantid :AttribsForm ORDER BY icustomerid DESC LIMIT :Load;",
        "Account": "SELECT iaccountid AS \\"Account ID\\", icustomerid AS \\"Customer ID\\", vcexternalaccountid AS \\"External Account ID\\", bmerchant AS \\"Merchant\\", irecordstatus AS \\"Record Status\\", dtentrydatetime AS \\"Entry Date Time\\", vcaccountname AS \\"Account Name\\", dtonboardingdate AS \\"Onboarded On\\", imcc AS \\"MCC\\" FROM masters.accounts WHERE itenantid = :tenantid :AttribsForm ORDER BY iaccountid DESC LIMIT :Load;",
        "VPA": "SELECT ivpaid AS \\"VPA ID\\", iaccountid AS \\"Account ID\\", vcexternaladdressid AS \\"External Address ID\\", vcaddress AS \\"Payment Address\\", vcvpaname AS \\"VPA Name\\", imcc AS \\"MCC\\", bmerchant AS \\"Merchant\\", dtentrydatetime AS \\"Entry Date Time\\", irecordstatus AS \\"Record Status\\", dtonboardingdate AS \\"Onboarded On\\", bverified AS \\"Verified\\" FROM masters.vpa WHERE itenantid = :tenantid :AttribsForm ORDER BY ivpaid DESC LIMIT :Load;"
    }
}
'::text WHERE
idashboardqueryid = 48 AND itenantid in (22,23);

------master extract Attributes
delete FROM ui.masterextractattribs where itenantid = 12;

	INSERT INTO ui.masterextractattribs (
    attribpath, level, datatype, displayname, itenantid, attribs
)
VALUES 
    ('vcattribs->>''kyc''', 'Customer', 'String', 'KYC', 12, NULL),
    ('vcattribs->>''risk''', 'Customer', 'String', 'Risk', 12, NULL),
    ('vcattribs->>''dealer_id''', 'Customer', 'String', 'Dealer ID', 12, NULL),
    ('vcattribs->>''gross_income''', 'Customer', 'String', 'Gross Income', 12, NULL),
    ('vcattribs->>''source_of_income''', 'Customer', 'String', 'Income', 12, NULL),
    ('vcattribs->>''termination_status''', 'Customer', 'String', 'Termination Status', 12, NULL),
    ('vcattribs->>''customer_onboard_type''', 'Customer', 'String', 'Customer Onboard Type', 12, NULL),
    ('vcattribs->>''occupation''', 'Customer', 'String', 'Occupation', 12, NULL),
    ('vcattribs->>''city''', 'Customer', 'String', 'City', 12, NULL),
    ('vcattribs->>''state''', 'Customer', 'String', 'State', 12, NULL),
    ('vcattribs->>''accountType''', 'Customer', 'String', 'Account Type', 12, NULL),
    ('vcattribs->>''doi_dob''', 'Customer', 'String', 'Date of Birth', 12, NULL),
    ('vcattribs->>''gender''', 'Customer', 'String', 'Gender', 12, NULL),
    ('vcattribs->>''ucic_id''', 'Customer', 'String', 'UCIC ID', 12, NULL),
    ('vcattribs->>''Mobile_no_UpdateTime''', 'Customer', 'String', 'Mobile no UpdateTime', 12, null),
    ('Vcregisteredmobile', 'Customer', 'String', 'Mobile Number', 12, NULL),
    ('vcexternalcustid', 'Customer', 'String', 'Customer ID', 12, '{
  "validations": [],
  "mandatoryTransposeField": true
}'),
    ('vcexternalaccountid', 'Account', 'String', 'Account ID', 12, '{
  "validations": [],
  "mandatoryTransposeField": true
}'),
    ('vcaccount', 'Account', 'String', 'Account Number', 12, NULL),
    ('vcexternaladdressid', 'VPA', 'String', 'Address ID', 12, '{
  "validations": [],
  "mandatoryTransposeField": true
}');

UPDATE ui.masterextractattribs SET
attribs = '{
  "validations": [],
  "mandatoryTransposeField": true
}'::jsonb WHERE
attribpath = 'Vcregisteredmobile' AND level = 'Customer' AND itenantid = 12;

---epifi
delete FROM ui.masterextractattribs where itenantid = 5;

INSERT INTO ui.masterextractattribs (
    attribpath, level, datatype, displayname, itenantid, attribs
)
VALUES 
    ('attrib.kyc_type', 'Customer', 'String', 'Kyc Type', 5, NULL),
    ('attrib.phone_number', 'Customer', 'String', 'Phone Number', 5, NULL),
    ('attrib.employment_type', 'Customer', 'String', 'Employement Type', 5, NULL),
    ('attrib.onboarding_state', 'Customer', 'String', 'Onboarding State', 5, NULL),
    ('attrib.declared_salary_max', 'Customer', 'String', 'declared salary_max', 5, NULL),
    ('attrib.declared_salary_min', 'Customer', 'String', 'declared salary_min', 5, NULL),
    ('attrib.liveness_geolocation', 'Customer', 'String', 'liveness geolocation', 5, NULL),
    ('attrib.internal_liveness_score', 'Customer', 'String', 'internal liveness_score', 5, NULL),
    ('attrib.shipping_address_state', 'Customer', 'String', 'shipping address_state', 5, NULL),
    ('attrib.mailing_address_postalcode', 'Customer', 'String', 'mailing address_postalcode', 5, NULL),
    ('attrib.shipping_address_postalcode', 'Customer', 'String', 'shipping address_postalcode', 5, NULL),
    ('icustomerid', 'Customer', 'Integer', 'Customer ID', 5, NULL),
    ('vcexternalcustid', 'Customer', 'String', 'Customer External ID', 5, NULL),
    ('vcattribs->> ''account_categories''', 'Account', 'String', 'Account Category', 5, NULL),
    ('vcexternalaccountid', 'Account', 'String', 'Account External ID', 5, NULL),
    ('vcattribs->> ''vpa_categories''', 'VPA', 'String', 'VPA Category', 5, NULL);


--jpsl
delete FROM ui.masterextractattribs where itenantid = 14;

INSERT INTO ui.masterextractattribs (
    attribpath, level, datatype, displayname, itenantid, attribs
)
VALUES 
    -- Customer Level Attributes
    ('vcexternalcustid', 'Customer', 'String', 'External Customer ID', 14, '{
  "validations": [],
  "mandatoryTransposeField": true
}'),
    ('vccustomername', 'Customer', 'String', 'Name', 14, NULL),
    ('vcattribs->>''subGroupId''', 'Customer', 'String', 'Sub-Group ID', 14, NULL),
    ('vcattribs->>''postalcode''', 'Customer', 'String', 'Postal Code', 14, NULL),
    ('vcattribs->>''merchantType''', 'Customer', 'String', 'Merchant Type', 14, NULL),
    ('imcc', 'Customer', 'Integer', 'MCC', 14, NULL),
    ('vcattribs->>''longitude''', 'Customer', 'String', 'Longitude', 14, NULL),
    ('vcattribs->>''latitude''', 'Customer', 'String', 'Latitude', 14, NULL),
    ('vcattribs->>''internationalAcceptance''', 'Customer', 'String', 'International Acceptance', 14, NULL),
    ('vcattribs->>''groupId''', 'Customer', 'String', 'Group ID', 14, NULL),
    ('vcattribs->>''date_of_incorporation''', 'Customer', 'String', 'Date of Incorporation', 14, NULL),
    ('vcattribs->>''cumulativeDailyTransactionVolume''', 'Customer', 'String', 'Cumulative Daily Transaction Volume', 14, NULL),
    ('vcattribs->>''cumulativeDailyTransactionExitVolume''', 'Customer', 'String', 'Cumulative Daily Transaction Exit Volume', 14, NULL),
    ('vcattribs->>''cumulativeDailyTransactionExitCount''', 'Customer', 'String', 'Cumulative Daily Transaction Exit Count', 14, NULL),
    ('vcattribs->>''cumulativeDailyTransactionCount''', 'Customer', 'String', 'Cumulative Daily Transaction Count', 14, NULL),
    ('vcattribs->>''cumulativeDailyRefundVolume''', 'Customer', 'String', 'Cumulative Daily Refund Volume', 14, NULL),
    ('vcattribs->>''cumulativeDailyRefundExitVolume''', 'Customer', 'String', 'Cumulative Daily Refund Exit Volume', 14, NULL),
    ('vcattribs->>''cumulativeDailyRefundExitCount''', 'Customer', 'String', 'Cumulative Daily Refund Exit Count', 14, NULL),
    ('vcattribs->>''cumulativeDailyRefundCount''', 'Customer', 'String', 'Cumulative Daily Refund Count', 14, NULL),
    ('vcattribs->>''business_division''', 'Customer', 'String', 'GST Business Division', 14, NULL),
    ('vcattribs->>''businessChannel''', 'Customer', 'String', 'Business Channel', 14, NULL),

    -- Account Level Attributes
    ('vcexternalaccountid', 'Account', 'String', 'External Account ID', 14, '{
  "validations": [],
  "mandatoryTransposeField": true
}'),
    ('imcc', 'Account', 'Integer', 'MCC', 14, NULL),

    -- VPA Level Attributes
    ('vcexternaladdressid', 'VPA', 'String', 'External Address ID', 14, '{
  "validations": [],
  "mandatoryTransposeField": true
}'),
    ('imcc', 'VPA', 'Integer', 'MCC', 14, NULL);


--pinelabs
delete FROM ui.masterextractattribs where itenantid = 10;

INSERT INTO ui.masterextractattribs (
    attribpath, level, datatype, displayname, itenantid, attribs
)
VALUES 
    -- Account Level Attributes
    ('vcexternalaccountid', 'Account', 'String', 'Store ID', 10, '{
  "validations": [],
  "mandatoryTransposeField": true
}'),
    ('vcattribs->>''reg_address''', 'Account', 'String', 'reg_address', 10, NULL),
    ('vcattribs->>''postal_code''', 'Account', 'String', 'postal_code', 10, NULL),
    ('vcattribs->>''merchant_type''', 'Account', 'String', 'merchant_type', 10, NULL),
    ('vcattribs->>''registered_mobile''', 'Account', 'String', 'registered_mobile', 10, NULL),
    ('vcemail', 'Account', 'String', 'email', 10, NULL),

    -- Customer Level Attributes
    ('dtonboardingdate', 'Customer', 'String', 'Onboarded on', 10, NULL),
    ('vcexternalcustid', 'Customer', 'String', 'MID', 10, NULL),
    ('vcattribs->>''accountaddress''', 'Customer', 'String', 'accountaddress', 10, NULL),
    ('vcattribs->>''accountnumber''', 'Customer', 'String', 'accountnumber', 10, NULL),
    ('vcattribs->>''ifsccode''', 'Customer', 'String', 'ifsccode', 10, NULL),
    ('vcattribs->>''bankname''', 'Customer', 'String', 'bankname', 10, NULL),
    ('vcattribs->>''settlementmode''', 'Customer', 'String', 'settlementmode', 10, NULL),
    ('vcattribs->>''accountonboardingdate''', 'Customer', 'String', 'accountonboardingdate', 10, NULL),
    ('vcattribs->>''address''', 'Customer', 'String', 'address', 10, NULL),
    ('vcattribs->>''email''', 'Customer', 'String', 'email', 10, NULL),
    ('vcattribs->>''postalcode''', 'Customer', 'String', 'postalcode', 10, NULL),
    ('vcattribs->>''annualturnover''', 'Customer', 'String', 'annualturnover', 10, NULL),
    ('vcattribs->>''registeredmobile''', 'Customer', 'String', 'registeredmobile', 10, NULL),
    ('vcattribs->>''merchanttype''', 'Customer', 'String', 'merchanttype', 10, NULL),
    ('vcattribs->>''attribs_merchanttype''', 'Customer', 'String', 'attribs_merchanttype', 10, NULL),
    ('vcattribs->>''merchant_type''', 'Customer', 'String', 'merchant_type', 10, NULL),
    ('vcattribs->>''category''', 'Customer', 'String', 'category', 10, NULL),
    ('vccustomername', 'Customer', 'String', 'name', 10, NULL),
    ('vcattribs->>''accounttype''', 'Customer', 'String', 'Account type', 10, NULL),
    ('vcattribs->>''Ownershiptype''', 'Customer', 'String', 'Ownership type', 10, NULL),

    -- VPA Level Attributes
    ('vcexternaladdressid', 'VPA', 'String', 'MDP POS ID', 10, NULL),
    ('vcattribs->>''merchant_type''', 'VPA', 'String', 'merchant_type', 10, NULL);

---yb pobo 

delete FROM ui.masterextractattribs where itenantid = 16;

INSERT INTO ui.masterextractattribs (
    attribpath, level, datatype, displayname, itenantid, attribs
)
VALUES 
    -- Customer Level Attributes
    ('icustomerid', 'Customer', 'Integer', 'Customer ID', 16, NULL),
    ('vcexternalcustid', 'Customer', 'String', 'Client External ID', 16, '{
  "validations": [],
  "mandatoryTransposeField": true
}'),
    ('vccustomername', 'Customer', 'String', 'Customer Name', 16, NULL),
    ('vccustomertype', 'Customer', 'String', 'Customer Type', 16, NULL),
    ('vcverifiedname', 'Customer', 'String', 'Verified Name', 16, NULL),
    ('dtonboardingdate', 'Customer', 'String', 'Onboarded On', 16, NULL),
    ('vcemail', 'Customer', 'String', 'Email', 16, NULL),
    ('vcregisteredmobile', 'Customer', 'String', 'Registered Mobile', 16, NULL),
    ('imcc', 'Customer', 'String', 'MCC', 16, NULL),
    ('irecordstatus', 'Customer', 'Integer', 'Record Status', 16, NULL),
    ('dtentrydatetime', 'Customer', 'String', 'Entry Date Time', 16, NULL),
    ('vcattribs->>''panNo''', 'Customer', 'String', 'Pan Number', 16, NULL),
    ('vcattribs->>''purpose''', 'Customer', 'String', 'Purpose', 16, NULL),
    ('vcattribs->>''partnerID''', 'Customer', 'String', 'Partner ID', 16, NULL),
    ('vcattribs->>''partnerName''', 'Customer', 'String', 'Partner Name', 16, NULL),
    ('vcattribs->>''ecollectAccNo''', 'Customer', 'String', 'Merchant No', 16, NULL),
    ('vcattribs->>''merchant_type''', 'Customer', 'String', 'Merchant type', 16, NULL),
    ('vcattribs->>''typeOfCompany''', 'Customer', 'String', 'Type Of Company', 16, NULL),
    ('vcattribs->>''clientIdentifier''', 'Customer', 'String', 'Client Identifier', 16, NULL),
    ('vcattribs->>''registeredAddress''', 'Customer', 'String', 'Registered Address', 16, NULL),
    ('vcattribs->>''dateOfRegistration''', 'Customer', 'String', 'Date Of Registration', 16, NULL),
    ('vcattribs->>''dueDiligenceStatus''', 'Customer', 'String', 'Due Diligence Status', 16, NULL),
    ('vcattribs->>''lastTurnoverUpdate''', 'Customer', 'String', 'Last Turnover Update', 16, NULL),

    -- Account Level Attributes
    ('iaccountid', 'Account', 'Integer', 'Account ID', 16, NULL),
    ('icustomerid', 'Account', 'Integer', 'Customer ID', 16, NULL),
    ('vcexternalaccountid', 'Account', 'String', 'External Account ID', 16, NULL),
    ('vcaccountname', 'Account', 'String', 'Account Name', 16, NULL),
    ('dtonboardingdate', 'Account', 'String', 'Onboarded On', 16, NULL),
    ('imcc', 'Account', 'String', 'MCC', 16, NULL),
    ('bmerchant', 'Account', 'Boolean', 'Merchant', 16, NULL),
    ('irecordstatus', 'Account', 'Integer', 'Record Status', 16, NULL),

    -- VPA Level Attributes
    ('ivpaid', 'VPA', 'Integer', 'VPA ID', 16, NULL),
    ('iaccountid', 'VPA', 'Integer', 'Account ID', 16, NULL),
    ('vcexternaladdressid', 'VPA', 'String', 'External Address ID', 16, NULL),
    ('vcaddress', 'VPA', 'String', 'Payment Address', 16, NULL),
    ('vcvpaname', 'VPA', 'String', 'VPA Name', 16, NULL),
    ('imcc', 'VPA', 'String', 'MCC', 16, NULL),
    ('bmerchant', 'VPA', 'Boolean', 'Merchant', 16, NULL),
    ('dtentrydatetime', 'VPA', 'String', 'Entry Date Time', 16, NULL),
    ('irecordstatus', 'VPA', 'Integer', 'Record Status', 16, NULL);


--yb bapa
delete FROM ui.masterextractattribs where itenantid = 8;

INSERT INTO ui.masterextractattribs (
    attribpath, level, datatype, displayname, itenantid, attribs
)
VALUES 
    -- Customer Level Attributes
    ('vcattribs->''yb_raw''->>''pan''', 'Customer', 'String', 'PAN', 8, NULL),
    ('vcattribs->''yb_raw''->>''city''', 'Customer', 'String', 'City', 8, NULL),
    ('vcattribs->''yb_raw''->>''gstn''', 'Customer', 'String', 'GSTN', 8, NULL),
    ('vcattribs->''yb_raw''->>''state''', 'Customer', 'String', 'State', 8, NULL),
    ('vcattribs->''yb_raw''->>''pinCode''', 'Customer', 'String', 'Pin Code', 8, NULL),
    ('vcattribs->''yb_raw''->>''district''', 'Customer', 'String', 'District', 8, NULL),
    ('vcattribs->''yb_raw''->>''latitude''', 'Customer', 'String', 'Latitude', 8, NULL),
    ('vcattribs->''yb_raw''->>''longitude''', 'Customer', 'String', 'Longitude', 8, NULL),
    ('vcattribs->''yb_raw''->>''partnerName''', 'Customer', 'String', 'Partner Name', 8, NULL),
    ('vcattribs->''yb_raw''->>''businessName''', 'Customer', 'String', 'Business Name', 8, NULL),
    ('vcattribs->''yb_raw''->>''mobileNumber''', 'Customer', 'String', 'Mobile Number', 8, NULL),
    ('vcattribs->''yb_raw''->>''sellerVerifiedAccountName''', 'Customer', 'String', 'Verified Account Name', 8, NULL),
    ('vcattribs->''yb_raw''->>''turnOverType''', 'Customer', 'String', 'Turnover Type', 8, NULL),
    ('vcexternalcustid', 'Customer', 'String', 'Customer ID', 8, '{
      "validations": [],
      "mandatoryTransposeField": true
    }'),
    -- Account Level Attributes
    ('vcexternalaccountid', 'Account', 'String', 'Account ID', 8, '{
  "validations": [],
  "mandatoryTransposeField": true
}'),
    -- VPA Level Attributes
    ('vcexternaladdressid', 'VPA', 'String', 'Address ID', 8, '{
  "validations": [],
  "mandatoryTransposeField": true
}');


--yb paytm
delete FROM ui.masterextractattribs where itenantid = 17;

INSERT INTO ui.masterextractattribs (
    attribpath, level, datatype, displayname, itenantid, attribs
)
VALUES 
    -- Customer Level Attributes
    ('vcattribs->>''pan''', 'Customer', 'String', 'PAN', 17, NULL),
    ('vcattribs->>''city''', 'Customer', 'String', 'City', 17, NULL),
    ('vcattribs->>''gstn''', 'Customer', 'String', 'GSTN', 17, NULL),
    ('vcattribs->>''state''', 'Customer', 'String', 'State', 17, NULL),
    ('vcattribs->>''pinCode''', 'Customer', 'String', 'Pin Code', 17, NULL),
    ('vcattribs->>''district''', 'Customer', 'String', 'District', 17, NULL),
    ('vcattribs->>''latitude''', 'Customer', 'String', 'Latitude', 17, NULL),
    ('vcattribs->>''longitude''', 'Customer', 'String', 'Longitude', 17, NULL),
    ('vcattribs->>''partnerName''', 'Customer', 'String', 'Partner Name', 17, NULL),
    ('vcverifiedname', 'Customer', 'String', 'Business Name', 17, NULL),
    ('vcregisteredmobile', 'Customer', 'String', 'Mobile Number', 17, NULL),
    ('vccustomername', 'Customer', 'String', 'Verified Account Name', 17, NULL),
    ('vcattribs->>''turnoverType''', 'Customer', 'String', 'Turnover Type', 17, NULL),
    ('vcexternalcustid', 'Customer', 'String', 'Customer ID', 17, '{
  "validations": [],
  "mandatoryTransposeField": true
}'),

    -- Account Level Attributes
    ('vcexternalaccountid', 'Account', 'String', 'Account ID', 17, '{
  "validations": [],
  "mandatoryTransposeField": true
}'),

    -- VPA Level Attributes
    ('vcexternaladdressid', 'VPA', 'String', 'Address ID', 17, '{
  "validations": [],
  "mandatoryTransposeField": true
}');

--yb pmtagg
delete FROM ui.masterextractattribs where itenantid = 21;

INSERT INTO ui.masterextractattribs (
    attribpath, level, datatype, displayname, itenantid, attribs
)
VALUES 
    -- Customer Level Attributes
    ('vcattribs->>''pan''', 'Customer', 'String', 'PAN', 21, NULL),
    ('imcc', 'Customer', 'String', 'MCC', 21, NULL),
    ('vcattribs->>''gst''', 'Customer', 'String', 'GSTN', 21, NULL),
    ('vcemail', 'Customer', 'String', 'Email Id', 21, NULL),
    ('vcattribs->>''partnerName''', 'Customer', 'String', 'Partner Name', 21, NULL),
    ('vcregisteredmobile', 'Customer', 'String', 'Mobile Number', 21, NULL),
    ('vccustomername', 'Customer', 'String', 'Verified Account Name', 21, NULL),
    ('vcexternalcustid', 'Customer', 'String', 'Customer ID', 21, '{
      "validations": [],
      "mandatoryTransposeField": true
    }'),
    ('vcattribs->>''merchantIdentifier''', 'Customer', 'String', 'Merchant Identifier', 21, NULL),
    ('vcattribs->>''settlementAccountId''', 'Customer', 'String', 'Settlement Account ID', 21, NULL),
    
    -- Account Level Attributes
    ('vcexternalaccountid', 'Account', 'String', 'Account ID', 21, '{
      "validations": [],
      "mandatoryTransposeField": true
    }'),
    
    -- VPA Level Attributes
    ('vcexternaladdressid', 'VPA', 'String', 'Address ID', 21, '{
      "validations": [],
      "mandatoryTransposeField": true
    }');

--yb giftcard
delete FROM ui.masterextractattribs where itenantid = 22;

INSERT INTO ui.masterextractattribs (
    attribpath, level, datatype, displayname, itenantid, attribs
)
VALUES 
    -- Customer Level Attributes
    ('vcattribs->>''pan''', 'Customer', 'String', 'PAN', 22, NULL),
    ('imcc', 'Customer', 'String', 'MCC', 22, NULL),
    ('vcattribs->>''gstn''', 'Customer', 'String', 'GSTN', 22, NULL),
    ('vcemail', 'Customer', 'String', 'Email Id', 22, NULL),
    ('vcattribs->>''partnerName''', 'Customer', 'String', 'Partner Name', 22, NULL),
    ('vcregisteredmobile', 'Customer', 'String', 'Mobile Number', 22, NULL),
    ('vccustomername', 'Customer', 'String', 'Verified Account Name', 22, NULL),
    ('vcexternalcustid', 'Customer', 'String', 'Customer ID', 22, '{
      "validations": [],
      "mandatoryTransposeField": true
    }'),
    ('vcattribs->>''giftCardPurchaserId''', 'Customer', 'String', 'Purchaser ID', 22, NULL),
    
    -- Account Level Attributes
    ('vcexternalaccountid', 'Account', 'String', 'Account ID', 22, '{
      "validations": [],
      "mandatoryTransposeField": true
    }'),
    
    -- VPA Level Attributes
    ('vcexternaladdressid', 'VPA', 'String', 'Address ID', 22, '{
      "validations": [],
      "mandatoryTransposeField": true
    }');

--ybfrm
DELETE FROM ui.masterextractattribs WHERE itenantid = 9;

INSERT INTO ui.masterextractattribs (
    attribpath, level, datatype, displayname, itenantid, attribs
)
VALUES 
    -- Customer Level Attributes
    ('vcattribs->''yb_raw''->>''pan''', 'Customer', 'String', 'PAN', 9, NULL),
    ('vcattribs->''yb_raw''->>''city''', 'Customer', 'String', 'City', 9, NULL),
    ('vcattribs->''yb_raw''->>''gstn''', 'Customer', 'String', 'GSTN', 9, NULL),
    ('vcattribs->''yb_raw''->>''state''', 'Customer', 'String', 'State', 9, NULL),
    ('vcattribs->''yb_raw''->>''pinCode''', 'Customer', 'String', 'Pin Code', 9, NULL),
    ('vcattribs->''yb_raw''->>''district''', 'Customer', 'String', 'District', 9, NULL),
    ('vcattribs->''yb_raw''->>''latitude''', 'Customer', 'String', 'Latitude', 9, NULL),
    ('vcattribs->''yb_raw''->>''longitude''', 'Customer', 'String', 'Longitude', 9, NULL),
    ('vcattribs->''yb_raw''->>''partnerName''', 'Customer', 'String', 'Partner Name', 9, NULL),
    ('vcattribs->''yb_raw''->>''businessName''', 'Customer', 'String', 'Business Name', 9, NULL),
    ('vcattribs->''yb_raw''->>''mobileNumber''', 'Customer', 'String', 'Mobile Number', 9, NULL),
    ('vcattribs->''yb_raw''->>''sellerVerifiedAccountName''', 'Customer', 'String', 'Verified Account Name', 9, NULL),
    ('vcattribs->''yb_raw''->>''turnOverType''', 'Customer', 'String', 'Turnover Type', 9, NULL),
    ('vcexternalcustid', 'Customer', 'String', 'Customer ID', 9, '{
      "validations": [],
      "mandatoryTransposeField": true
    }'),

    -- Account Level Attributes
    ('vcexternalaccountid', 'Account', 'String', 'Account ID', 9, '{
      "validations": [],
      "mandatoryTransposeField": true
    }'),

    -- VPA Level Attributes
    ('vcexternaladdressid', 'VPA', 'String', 'Address ID', 9, '{
      "validations": [],
      "mandatoryTransposeField": true
    }');

--42c
delete FROM ui.masterextractattribs where itenantid in (7,6,20,24);

INSERT INTO ui.masterextractattribs (
    attribpath, level, datatype, displayname, itenantid, attribs
)
VALUES 
    -- Customer Level Attributes
    ('program_id', 'Customer', 'Integer', 'Program ID', 7, NULL),
    ('vcexternalcustid', 'Customer', 'String', 'Customer ID', 7, '{
  "validations": [],
  "mandatoryTransposeField": true
}'),
    ('program_id', 'Customer', 'Integer', 'Program ID', 6, NULL),
    ('vcexternalcustid', 'Customer', 'String', 'Customer ID', 6, '{
  "validations": [],
  "mandatoryTransposeField": true
}'),
    ('program_id', 'Customer', 'Integer', 'Program ID', 20, NULL),
    ('vcexternalcustid', 'Customer', 'String', 'Customer ID', 20, '{
  "validations": [],
  "mandatoryTransposeField": true
}'),
    ('program_id', 'Customer', 'Integer', 'Program ID', 24, NULL),
    ('vcexternalcustid', 'Customer', 'String', 'Customer ID', 24, '{
  "validations": [],
  "mandatoryTransposeField": true
}'),

    -- Account Level Attributes
    ('vcattribs->>''account_categories''', 'Account', 'String', 'Account Category', 7, NULL),
    ('vcexternalaccountid', 'Account', 'String', 'Account ID', 7, '{
  "validations": [],
  "mandatoryTransposeField": true
}'),
    ('vcaccount', 'Account', 'String', 'Account Number', 7, NULL),
    ('vcattribs->>''account_categories''', 'Account', 'String', 'Account Category', 6, NULL),
    ('vcexternalaccountid', 'Account', 'String', 'Account ID', 6, '{
  "validations": [],
  "mandatoryTransposeField": true
}'),
    ('vcaccount', 'Account', 'String', 'Account Number', 6, NULL),
    ('vcattribs->>''account_categories''', 'Account', 'String', 'Account Category', 20, NULL),
    ('vcexternalaccountid', 'Account', 'String', 'Account ID', 20, '{
  "validations": [],
  "mandatoryTransposeField": true
}'),
    ('vcaccount', 'Account', 'String', 'Account Number', 20, NULL),
    ('vcattribs->>''account_categories''', 'Account', 'String', 'Account Category', 24, NULL),
    ('vcexternalaccountid', 'Account', 'String', 'Account ID', 24, '{
  "validations": [],
  "mandatoryTransposeField": true
}'),
    ('vcaccount', 'Account', 'String', 'Account Number', 24, NULL),

    -- VPA Level Attributes
    ('vcattribs->>''card_brand''', 'VPA', 'String', 'Card Brand', 7, NULL),
    ('vcattribs->>''programId''', 'VPA', 'String', 'Program ID', 7, NULL),
    ('vcattribs->>''card_brand''', 'VPA', 'String', 'Card Brand', 6, NULL),
    ('vcattribs->>''programId''', 'VPA', 'String', 'Program ID', 6, NULL),
    ('vcattribs->>''card_brand''', 'VPA', 'String', 'Card Brand', 20, NULL),
    ('vcattribs->>''programId''', 'VPA', 'String', 'Program ID', 20, NULL),
    ('vcattribs->>''card_brand''', 'VPA', 'String', 'Card Brand', 24, NULL),
    ('vcattribs->>''programId''', 'VPA', 'String', 'Program ID', 24, NULL);

