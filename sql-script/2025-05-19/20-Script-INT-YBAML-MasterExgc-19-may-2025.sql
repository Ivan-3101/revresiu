
-----------------gc
---master extracts
INSERT INTO ui.dashboard (
idashboardid, bactive, bdelete, vcdashboardname, iorder, irowcount, imenustructuredesc, itenantid, bdynamic) VALUES (
'78'::integer, true::boolean, false::boolean, 'Master Extracts-DL'::character varying, '22'::integer, '1'::integer, '510'::integer, '22'::integer, true::boolean)
returning idashboardid,itenantid;

INSERT INTO ui.dashboardquery (
idashboardqueryid, bparametersrequired, vcfilterparametersjson, vcdashboardquery, formattingrequiered, runonanalytics, transposerequired, imenustructuredesc, itenantid, dbtype) VALUES (
'164'::integer, true::boolean, '{"Party": null, "DateRange": null, "AttribsForm":null, "Transpose":"Normal", "Load":null}'::text,  E'{
   "Transpose": {
       "Account": "SELECT attribute, data FROM landing.masters.accounts, UNNEST(ARRAY[ROW(''account id'', CAST(iaccountid AS VARCHAR)), ROW(''customer id'', CAST(icustomerid AS VARCHAR)), ROW(''external account id'', vcexternalaccountid), ROW(''bmerchant'', CAST(bmerchant AS VARCHAR)), ROW(''record status'', CAST(irecordstatus AS VARCHAR)), ROW(''entry date time'', CAST(dtentrydatetime AS VARCHAR))]) AS t(attribute, data) WHERE itenantid = :tenantid :AttribsForm AND dtentrydatetime BETWEEN CAST(:StartDate AS TIMESTAMP(6)) AND CAST(:EndDate AS TIMESTAMP(6)) ORDER BY iaccountid DESC LIMIT :Load ",
       "VPA": "SELECT attribute, data FROM landing.masters.vpa, UNNEST(ARRAY[ROW(''vpa id'', CAST(ivpaid AS VARCHAR)), ROW(''account id'', CAST(iaccountid AS VARCHAR)), ROW(''external address id'', vcexternaladdressid), ROW(''address'', vcaddress), ROW(''vpaname'', vcvpaname), ROW(''MCC'', CAST(imcc AS VARCHAR)), ROW(''bmerchant'', CAST(bmerchant AS VARCHAR)), ROW(''entry date time'', CAST(dtentrydatetime AS VARCHAR)), ROW(''irecordstatus'', CAST(irecordstatus AS VARCHAR))]) AS t(attribute, data) WHERE itenantid = :tenantid :AttribsForm AND dtentrydatetime BETWEEN CAST(:StartDate AS TIMESTAMP(6)) AND CAST(:EndDate AS TIMESTAMP(6)) ORDER BY ivpaid DESC LIMIT :Load ",
       "Customer": "SELECT attribute, data FROM landing.masters.customers, UNNEST(ARRAY[ROW(''Customer ID'', CAST(icustomerid AS VARCHAR)), ROW(''External Cust ID'', vcexternalcustid), ROW(''Customer Name'', vccustomername), ROW(''Onboarded On'', CAST(dtonboardingdate AS VARCHAR)), ROW(''MCC'', CAST(imcc AS VARCHAR)), ROW(''PAN'', json_extract_scalar(vcattribs, ''$.pan'')), ROW(''City'', json_extract_scalar(vcattribs, ''$.city'')), ROW(''GSTN'', json_extract_scalar(vcattribs, ''$.gstn'')), ROW(''LLPIN'', json_extract_scalar(vcattribs, ''$.llpin'')), ROW(''State'', json_extract_scalar(vcattribs, ''$.state'')), ROW(''Status'', json_extract_scalar(vcattribs, ''$.status'')), ROW(''Country'', json_extract_scalar(vcattribs, ''$.country'')), ROW(''Pincode'', json_extract_scalar(vcattribs, ''$.pincode'')), ROW(''District'', json_extract_scalar(vcattribs, ''$.district'')), ROW(''Latitude'', json_extract_scalar(vcattribs, ''$.latitude'')), ROW(''Longitude'', json_extract_scalar(vcattribs, ''$.longitude'')), ROW(''Partner Name'', json_extract_scalar(vcattribs, ''$.partnerName'')), ROW(''Business Name'', json_extract_scalar(vcattribs, ''$.businessName'')), ROW(''Merchant Type'', json_extract_scalar(vcattribs, ''$.merchantType'')), ROW(''Registered mobile'', vcregisteredmobile), ROW(''Turnover Type'', json_extract_scalar(vcattribs, ''$.turnoverType'')), ROW(''Ownership Type'', json_extract_scalar(vcattribs, ''$.ownershipType'')), ROW(''Acceptance Type'', json_extract_scalar(vcattribs, ''$.acceptanceType'')), ROW(''Verified AccountName'', json_extract_scalar(vcattribs, ''$.sellerVerifiedAccountName'')), ROW(''record status'', CAST(irecordstatus AS VARCHAR))]) AS t(attribute, data) WHERE itenantid = :tenantid :AttribsForm AND dtentrydatetime BETWEEN CAST(:StartDate AS TIMESTAMP(6)) AND CAST(:EndDate AS TIMESTAMP(6)) ORDER BY icustomerid DESC LIMIT :Load "
   },
   "Normal": {
       "Account": "SELECT iaccountid AS \\"Account ID\\", icustomerid AS \\"Customer ID\\", vcexternalaccountid AS \\"External Account ID\\", bmerchant AS \\"Merchant\\", irecordstatus AS \\"Record Status\\", dtentrydatetime AS \\"Entry Date Time\\" FROM landing.masters.accounts WHERE itenantid = :tenantid :AttribsForm AND dtentrydatetime BETWEEN CAST(:StartDate AS TIMESTAMP(6)) AND CAST(:EndDate AS TIMESTAMP(6)) ORDER BY iaccountid DESC LIMIT :Load ",
       "VPA": "SELECT ivpaid AS \\"VPA ID\\", iaccountid AS \\"Account ID\\", vcexternaladdressid AS \\"External Address ID\\", vcaddress AS \\"Payment Address\\", vcvpaname AS \\"VPA Name\\", imcc AS \\"MCC\\", bmerchant AS \\"Merchant\\", dtentrydatetime AS \\"Entry Date Time\\", irecordstatus AS \\"Record Status\\" FROM landing.masters.vpa WHERE itenantid = :tenantid :AttribsForm AND dtentrydatetime BETWEEN CAST(:StartDate AS TIMESTAMP(6)) AND CAST(:EndDate AS TIMESTAMP(6)) ORDER BY ivpaid DESC LIMIT :Load ",
       "Customer": "SELECT icustomerid AS \\"Customer ID\\", vcexternalcustid AS \\"External Cust ID\\", vccustomername AS \\"Customer Name\\", dtonboardingdate AS \\"Onboarded On\\", imcc AS \\"MCC\\", json_extract_scalar(vcattribs, ''$.pan'') AS \\"PAN\\", json_extract_scalar(vcattribs, ''$.city'') AS \\"City\\", json_extract_scalar(vcattribs, ''$.gstn'') AS \\"GSTN\\", json_extract_scalar(vcattribs, ''$.llpin'') AS \\"LLPIN\\", json_extract_scalar(vcattribs, ''$.state'') AS \\"State\\", json_extract_scalar(vcattribs, ''$.status'') AS \\"Status\\", json_extract_scalar(vcattribs, ''$.country'') AS \\"Country\\", json_extract_scalar(vcattribs, ''$.pincode'') AS \\"Pin Code\\", json_extract_scalar(vcattribs, ''$.district'') AS \\"District\\", json_extract_scalar(vcattribs, ''$.latitude'') AS \\"Latitude\\", json_extract_scalar(vcattribs, ''$.longitude'') AS \\"Longitude\\", json_extract_scalar(vcattribs, ''$.partnerName'') AS \\"Partner Name\\", json_extract_scalar(vcattribs, ''$.businessName'') AS \\"Business Name\\", json_extract_scalar(vcattribs, ''$.merchantType'') AS \\"Merchant Type\\", vcregisteredmobile AS \\"Mobile Number\\", json_extract_scalar(vcattribs, ''$.turnoverType'') AS \\"Turn Over Type\\", json_extract_scalar(vcattribs, ''$.ownershipType'') AS \\"Ownership Type\\", json_extract_scalar(vcattribs, ''$.acceptanceType'') AS \\"Acceptance Type\\", json_extract_scalar(vcattribs, ''$.sellerVerifiedAccountName'') AS \\"Verified Account Name\\", irecordstatus AS \\"Record Status\\" FROM landing.masters.customers WHERE itenantid = :tenantid :AttribsForm AND dtentrydatetime BETWEEN CAST(:StartDate AS TIMESTAMP(6)) AND CAST(:EndDate AS TIMESTAMP(6)) ORDER BY icustomerid DESC LIMIT :Load "
   }
}'::text, false::boolean, false::boolean, false::boolean, '510'::integer, '22'::integer, '3'::integer)
returning idashboardqueryid,itenantid;

INSERT INTO ui.dashboardresultset (
idashboardresultsetid, vcdashboardresultsetlayout, vcdashboardresultsetname, idashboardqueryid, idashboardid, irowno, imenustructuredesc, itenantid, iorgid) VALUES (
(SELECT max(idashboardresultsetid)+1 FROM ui.dashboardresultset), '{"sizes":[1],"detail":{"main":{"type":"tab-area","widgets":["PERSPECTIVE_GENERATED_ID_1"],
"currentIndex":0}},"mode":"globalFilters","viewers":{"PERSPECTIVE_GENERATED_ID_1":{"plugin":"Datagrid",
"plugin_config":{"columns":{},"editable":false,"scroll_lock":true},"settings":false,"theme":"Pro Dark"
,"title":"Master Extracts","group_by":[],"split_by":[],"columns":["imcc","vcifsc","bmerchant","bverified",
"vcaccount","iaccountid","icustomerid","dtexpirydate","irecordstatus","vcaccountname","iaccounttypeid",
"dtentrydatetime","attrib.CORPORATE","dtonboardingdate","vcaccountproviderid","vcexternalaccountid"],
"filter":[],"sort":[],"expressions":[],"aggregates":{},"master":false,"table":"masterextracts","linked":false}}}'::text, 'masterextracts'::character varying, '164'::integer, '78'::integer, '1'::integer, '510'::integer, '22'::integer, '5'::integer)
returning idashboardresultsetid,itenantid;

INSERT INTO ui.dashboardfilters (
idashboardfilterid, ifilterorder, vcdashboardfiltername, idashboardid, vcdashboardfiltertype, idashboardqueryidforoptions, itenantid, vcdashboardfilterdisplayname) VALUES (
(SELECT max(idashboardfilterid)+1 FROM ui.dashboardfilters), '4'::integer, 'AttribsForm'::character varying, '78'::integer, 'FormFilter'::character varying, '74'::integer, '22'::integer, 'Attribs Form Filter'::character varying)
returning idashboardfilterid,itenantid;
INSERT INTO ui.dashboardfilters (
idashboardfilterid, ifilterorder, vcdashboardfiltername, idashboardid, vcdashboardfiltertype, itenantid, vcdashboardfilterdisplayname) VALUES (
(SELECT max(idashboardfilterid)+1 FROM ui.dashboardfilters), '3'::integer, 'Transpose'::character varying, '78'::integer, 'Transpose'::character varying, '22'::integer, 'Transpose'::character varying)
returning idashboardfilterid,itenantid;
INSERT INTO ui.dashboardfilters (
idashboardfilterid, ifilterorder, vcdashboardfiltername, idashboardid, vcdashboardfiltertype, idashboardqueryidforoptions, itenantid, vcdashboardfilterdisplayname) VALUES (
(SELECT max(idashboardfilterid)+1 FROM ui.dashboardfilters), '2'::integer, 'Load'::character varying, '78'::integer, 'Select'::character varying, '91'::integer, '22'::integer, 'Load'::character varying)
returning idashboardfilterid,itenantid;
INSERT INTO ui.dashboardfilters (
idashboardfilterid, ifilterorder, vcdashboardfiltername, idashboardid, vcdashboardfiltertype, idashboardqueryidfordefaultvalue, itenantid, vcdashboardfilterdisplayname) VALUES (
(SELECT max(idashboardfilterid)+1 FROM ui.dashboardfilters), '1'::integer, 'DateRange'::character varying, '78'::integer, 'DateRangePicker'::character varying, '16'::integer, '22'::integer, 'Date Range'::character varying)
returning idashboardfilterid,itenantid;
INSERT INTO ui.dashboardfilters (
idashboardfilterid, ifilterorder, vcdashboardfiltername, idashboardid, vcdashboardfiltertype, idashboardqueryidforoptions, itenantid, vcdashboardfilterdisplayname) VALUES (
(SELECT max(idashboardfilterid)+1 FROM ui.dashboardfilters), '0'::integer, 'Party'::character varying, '78'::integer, 'Select'::character varying, '67'::integer, '22'::integer, 'Level'::character varying)
returning idashboardfilterid,itenantid;

INSERT INTO ui.dashboardqueryparameters (
idashboardparameterid, vcparametername, vcparametertype, idashboardqueryid, itenantid) VALUES (
(SELECT max(idashboardparameterid)+1 FROM ui.dashboardqueryparameters), 'DateRange'::character varying, 'DateRange'::character varying, '164'::integer, '22'::integer)
returning idashboardparameterid,itenantid;
INSERT INTO ui.dashboardqueryparameters (
idashboardparameterid, vcparametername, vcparametertype, idashboardqueryid, itenantid) VALUES (
(SELECT max(idashboardparameterid)+1 FROM ui.dashboardqueryparameters), 'Load'::character varying, 'Integer'::character varying, '164'::integer, '22'::integer)
returning idashboardparameterid,itenantid;
INSERT INTO ui.dashboardqueryparameters (
idashboardparameterid, vcparametername, vcparametertype, idashboardqueryid, iorder, itenantid) VALUES (
(SELECT max(idashboardparameterid)+1 FROM ui.dashboardqueryparameters), 'Party'::character varying, 'JsonPath'::character varying, '164'::integer, '1'::integer, '22'::integer)
returning idashboardparameterid,itenantid;
INSERT INTO ui.dashboardqueryparameters (
idashboardparameterid, vcparametername, vcparametertype, idashboardqueryid, iorder, itenantid) VALUES (
(SELECT max(idashboardparameterid)+1 FROM ui.dashboardqueryparameters), 'Transpose'::character varying, 'JsonPath'::character varying, '164'::integer, '0'::integer, '22'::integer)
returning idashboardparameterid,itenantid;
INSERT INTO ui.dashboardqueryparameters (
idashboardparameterid, vcparametername, vcparametertype, idashboardqueryid, itenantid) VALUES (
(SELECT max(idashboardparameterid)+1 FROM ui.dashboardqueryparameters), 'AttribsForm'::character varying, 'WhereStatement'::character varying, '164'::integer, '22'::integer)
returning idashboardparameterid,itenantid;

UPDATE ui.dashboardquery SET
vcdashboardquery =  E'
{
    "Transpose": {
        "Customer": "SELECT attribute, data FROM t22refined.masters.customers, UNNEST(ARRAY[ROW(''Customer ID'', CAST(icustomerid AS VARCHAR)), ROW(''External Cust ID'', vcexternalcustid), ROW(''Customer Name'', vccustomername), ROW(''Onboarded On'', CAST(dtonboardingdate AS VARCHAR)), ROW(''MCC'', CAST(imcc AS VARCHAR)), ROW(''Registered mobile'', vcregisteredmobile), ROW(''Entry Date Time'', CAST(dtentrydatetime AS VARCHAR)), ROW(''Email Id'', CAST(vcemail AS VARCHAR)), ROW(''record status'', CAST(irecordstatus AS VARCHAR))]) AS t(attribute, data) WHERE itenantid = :tenantid :AttribsForm AND dtentrydatetime BETWEEN CAST(:StartDate AS TIMESTAMP(6)) AND CAST(:EndDate AS TIMESTAMP(6)) ORDER BY icustomerid DESC LIMIT :Load ",
        "Account": "SELECT attribute, data FROM t22refined.masters.accounts, UNNEST(ARRAY[ROW(''Account ID'', CAST(iaccountid AS VARCHAR)), ROW(''Customer ID'', CAST(icustomerid AS VARCHAR)), ROW(''external account id'', vcexternalaccountid), ROW(''bmerchant'', CAST(bmerchant AS VARCHAR)), ROW(''record status'', CAST(irecordstatus AS VARCHAR)), ROW(''MCC'', CAST(imcc AS VARCHAR)), ROW(''Onboarded On'', CAST(dtonboardingdate AS VARCHAR)),  ROW(''entry date time'', CAST(dtentrydatetime AS VARCHAR))]) AS t(attribute, data) WHERE itenantid = :tenantid :AttribsForm AND dtentrydatetime BETWEEN CAST(:StartDate AS TIMESTAMP(6)) AND CAST(:EndDate AS TIMESTAMP(6)) ORDER BY iaccountid DESC LIMIT :Load ",
        "VPA": "SELECT attribute, data FROM t22refined.masters.vpa, UNNEST(ARRAY[ROW(''VPA Id'', CAST(ivpaid AS VARCHAR)), ROW(''account id'', CAST(iaccountid AS VARCHAR)), ROW(''external address id'', vcexternaladdressid), ROW(''Payment Address'', vcaddress), ROW(''VPA Name'', vcvpaname), ROW(''MCC'', CAST(imcc AS VARCHAR)), ROW(''Merchant'', CAST(bmerchant AS VARCHAR)), ROW(''entry date time'', CAST(dtentrydatetime AS VARCHAR)), ROW(''Verified'', CAST(bverified AS VARCHAR)), ROW(''Onboarded On'', CAST(dtonboardingdate AS VARCHAR)), ROW(''record status'', CAST(irecordstatus AS VARCHAR))]) AS t(attribute, data) WHERE itenantid = :tenantid :AttribsForm AND dtentrydatetime BETWEEN CAST(:StartDate AS TIMESTAMP(6)) AND CAST(:EndDate AS TIMESTAMP(6)) ORDER BY ivpaid DESC LIMIT :Load "
    },
    "Normal": {
        "Customer": "SELECT icustomerid AS \\"Customer ID\\", vcexternalcustid AS \\"External Cust ID\\", vccustomername AS \\"Customer Name\\", dtonboardingdate AS \\"Onboarded On\\", imcc AS \\"MCC\\", vcregisteredmobile AS \\"Mobile Number\\", irecordstatus AS \\"Record Status\\", dtentrydatetime AS \\"Entry Date Time\\", vcemail AS \\"Email Id\\" FROM t22refined.masters.customers WHERE itenantid = :tenantid :AttribsForm AND dtentrydatetime BETWEEN CAST(:StartDate AS TIMESTAMP(6)) AND CAST(:EndDate AS TIMESTAMP(6))  ORDER BY icustomerid DESC LIMIT :Load",
        "Account": "SELECT iaccountid AS \\"Account ID\\", icustomerid AS \\"Customer ID\\", vcexternalaccountid AS \\"External Account ID\\", bmerchant AS \\"Merchant\\", irecordstatus AS \\"Record Status\\", dtentrydatetime AS \\"Entry Date Time\\", vcaccountname AS \\"Account Name\\", dtonboardingdate AS \\"Onboarded On\\", imcc AS \\"MCC\\" FROM t22refined.masters.accounts WHERE itenantid = :tenantid :AttribsForm AND dtentrydatetime BETWEEN CAST(:StartDate AS TIMESTAMP(6)) AND CAST(:EndDate AS TIMESTAMP(6)) ORDER BY iaccountid DESC LIMIT :Load",
        "VPA": "SELECT ivpaid AS \\"VPA ID\\", iaccountid AS \\"Account ID\\", vcexternaladdressid AS \\"External Address ID\\", vcaddress AS \\"Payment Address\\", vcvpaname AS \\"VPA Name\\", imcc AS \\"MCC\\", bmerchant AS \\"Merchant\\", dtentrydatetime AS \\"Entry Date Time\\", irecordstatus AS \\"Record Status\\", dtonboardingdate AS \\"Onboarded On\\", bverified AS \\"Verified\\" FROM t22refined.masters.vpa WHERE itenantid = :tenantid :AttribsForm AND dtentrydatetime BETWEEN CAST(:StartDate AS TIMESTAMP(6)) AND CAST(:EndDate AS TIMESTAMP(6))  ORDER BY ivpaid DESC LIMIT :Load"
    }
}
'::text WHERE
idashboardqueryid = 164 AND itenantid = 22;