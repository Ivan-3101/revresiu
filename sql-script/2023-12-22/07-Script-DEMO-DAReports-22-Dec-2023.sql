-------------Master extract EPIFI, tenantid=5
INSERT INTO ui.masterextractattribs (attribpath, level, datatype,
displayname, itenantid) VALUES ('vcattribs->>''kyc_type'' ',
'Customer', 'String', 'kyc type', 5);
INSERT INTO ui.masterextractattribs (attribpath, level, datatype,
displayname, itenantid) VALUES ('vcattribs->>''phone_number''',
'Customer', 'String', 'phone number', 5);
INSERT INTO ui.masterextractattribs (attribpath, level, datatype,
displayname, itenantid) VALUES ('vcattribs->>''employment_type''',
'Customer', 'String', 'employment type', 5);
INSERT INTO ui.masterextractattribs (attribpath, level, datatype,
displayname, itenantid) VALUES ('vcattribs->>''declared_salary_max''',
'Customer', 'String', 'declared salary_max', 5);
INSERT INTO ui.masterextractattribs (attribpath, level, datatype,
displayname, itenantid) VALUES ('vcattribs->>''onboarding_state''',
'Customer', 'String', 'onboarding state', 5);
INSERT INTO ui.masterextractattribs (attribpath, level, datatype,
displayname, itenantid) VALUES ('vcattribs->>''declared_salary_min''',
'Customer', 'String', 'declared salary_min', 5);
INSERT INTO ui.masterextractattribs (attribpath, level, datatype,
displayname, itenantid) VALUES
('vcattribs->>''liveness_geolocation''', 'Customer', 'String',
'liveness geolocation', 5);
INSERT INTO ui.masterextractattribs (attribpath, level, datatype,
displayname, itenantid) VALUES
('vcattribs->>''internal_liveness_score''', 'Customer', 'String',
'internal liveness_score', 5);
INSERT INTO ui.masterextractattribs (attribpath, level, datatype,
displayname, itenantid) VALUES
('vcattribs->>''shipping_address_state''', 'Customer', 'String',
'shipping address_state', 5);
INSERT INTO ui.masterextractattribs (attribpath, level, datatype,
displayname, itenantid) VALUES
('vcattribs->>''mailing_address_postalcode''', 'Customer', 'String',
'mailing address_postalcode', 5);
INSERT INTO ui.masterextractattribs (attribpath, level, datatype,
displayname, itenantid) VALUES
('vcattribs->>''shipping_address_postalcode''', 'Customer', 'String',
'shipping address_postalcode', 5);

INSERT INTO ui.dashboard (
idashboardid, bactive, bdelete, vcdashboardname, iorder, irowcount,
imenustructuredesc, itenantid, bdynamic) VALUES (
'53'::integer, true::boolean, false::boolean, 'Master
Extracts'::character varying, '16'::integer, '1'::integer,
'510'::integer, '5'::integer, true::boolean)
 returning idashboardid;

--dashboard filter entries
INSERT INTO ui.dashboardfilters (
idashboardfilterid, ifilterorder, vcdashboardfiltername, idashboardid,
vcdashboardfiltertype, vcdashboardfilterdisplayname,
idashboardqueryidforoptions) VALUES (
(select max(idashboardfilterid)+1 from ui.dashboardfilters),
'0'::integer, 'Party'::character varying, '53'::integer,
'Select'::character varying, 'Level'::character varying,
'67'::integer)
 returning idashboardfilterid;
INSERT INTO ui.dashboardfilters (
idashboardfilterid, ifilterorder, vcdashboardfiltername, idashboardid,
vcdashboardfiltertype, vcdashboardfilterdisplayname,
idashboardqueryidforoptions) VALUES (
(select max(idashboardfilterid)+1 from ui.dashboardfilters),
'0'::integer, 'AttribsForm'::character varying, '53'::integer,
'FormFilter'::character varying, 'Attribs Form Filter'::character
varying, '74'::integer)
 returning idashboardfilterid;

--main query
INSERT INTO ui.dashboardquery (
idashboardqueryid, bparametersrequired, vcfilterparametersjson,
vcdashboardquery, formattingrequiered, runonanalytics,
transposerequired, imenustructuredesc) VALUES (
'106'::integer, true::boolean, '{"Party": null, "AttribsForm":null}'::text, '{
"Account":"select iaccountid, icustomerid, vcexternalaccountid,
iaccounttypeid, vcifsc, vcaccountproviderid, vcaccountname,
dtonboardingdate, dtexpirydate, imcc, bmerchant, bverified,
irecordstatus, dtentrydatetime from masters.accounts where itenantid =
:tenantid order by iaccountid desc limit 50000",
"VPA": "select ivpaid, iaccountid, vcexternaladdressid, vcaddress,
iproductid, vcvpaname, bverified, imcc, dtonboardingdate,
dtexpirydate, bmerchant, ivpaproviderid, bprofiled,
dtfirsttransaction, dtlasttransaction, irecordstatus, dtentrydatetime
from masters.vpa where itenantid = :tenantid order by ivpaid desc
limit 50000",
"Customer": "SELECT icustomerid, vcexternalcustid, vccustomername,
vccustomertype, vcsalutation, vcverifiedname, vcgender, dtdoidob,
dtonboardingdate, vcpostalcode, vcemail, vcregisteredmobile, imcc,
vcidentitytype1, vcidentitydetails1, vcidentitytype2,
vcidentitydetails2, vcregisteredaddressgeolocation, iadm3, iadm2,
iadm1, vccountrycode, vcattribs->>''kyc_type'' as \"kyc type\",
vcattribs->>''phone_number'' as \"phone number\",
vcattribs->>''employment_type'' as \"employment type\",
vcattribs->>''onboarding_state'' as \"onboarding state\",
vcattribs->>''declared_salary_max'' as \"declared salary_max\",
vcattribs->>''declared_salary_min'' as \"declared salary_min\",
vcattribs->>''liveness_geolocation'' as \"liveness geolocation\",
vcattribs->>''internal_liveness_score'' as \"internal livness_score\",
vcattribs->>''shipping_address_state'' as \"shipping address_state\",
vcattribs->>''mailing_address_postalcode'' as \"mailing
address_postalcode\", vcattribs->>''shipping_address_postalcode'' as
\"shipping address_postalcode\", irecordstatus, dtentrydatetime FROM
masters.customers where itenantid = :tenantid :AttribsForm order by
icustomerid desc limit 50000;"
}'::text, false::boolean, false::boolean, false::boolean, '510'::integer)
 returning idashboardqueryid;

--query params for main query
INSERT INTO ui.dashboardqueryparameters (
 idashboardparameterid, vcparametername, vcparametertype,
idashboardqueryid, iorder) VALUES (
 (select max(idashboardparameterid)+1 from
ui.dashboardqueryparameters), 'Party'::character varying,
'JsonPath'::character varying, '106'::integer, '1'::integer)
  returning idashboardparameterid;

INSERT INTO ui.dashboardqueryparameters (
 idashboardparameterid, vcparametername, vcparametertype,
idashboardqueryid, iorder) VALUES (
 (select max(idashboardparameterid)+1 from
ui.dashboardqueryparameters), 'AttribsForm'::character varying,
'WhereStatement'::character varying, '106'::integer, '1'::integer)
  returning idashboardparameterid;

--resultset
INSERT INTO ui.dashboardresultset (
idashboardresultsetid, vcdashboardresultsetlayout,
vcdashboardresultsetname, idashboardqueryid, idashboardid, irowno,
imenustructuredesc) VALUES
((select max(idashboardresultsetid)+1 from ui.dashboardresultset),
'{"sizes":[1],"detail":{"main":{"type":"tab-area","widgets":["PERSPECTIVE_GENERATED_ID_1"],"currentIndex":0}},"mode":"globalFilters","viewers":{"PERSPECTIVE_GENERATED_ID_1":{"plugin":"Datagrid","plugin_config":{"columns":{},"editable":false,"scroll_lock":true},"settings":false,"theme":"Pro
Dark","title":"Master
Extracts","group_by":[],"split_by":[],"columns":["imcc","vcifsc","bmerchant","bverified","vcaccount","iaccountid","icustomerid","dtexpirydate","irecordstatus","vcaccountname","iaccounttypeid","dtentrydatetime","attrib.CORPORATE","dtonboardingdate","vcaccountproviderid","vcexternalaccountid"],"filter":[],"sort":[],"expressions":[],"aggregates":{},"master":false,"table":"masterextracts","linked":false}}}'::text,
'masterextracts', '106'::integer, '53'::integer, '1'::integer, '510'::integer);


---------Master Extract for 42c tenantid=6
INSERT INTO ui.masterextractattribs (attribpath, level, datatype,
displayname, itenantid) VALUES ('cast(vcattribs->>''program_id'' as
integer) ', 'Customer', 'Integer', 'Program ID', 6);
INSERT INTO ui.dashboard (
idashboardid, bactive, bdelete, vcdashboardname, iorder, irowcount,
imenustructuredesc, itenantid, bdynamic) VALUES (
'54'::integer, true::boolean, false::boolean, 'Master
Extracts'::character varying, '16'::integer, '1'::integer,
'510'::integer, '6'::integer, true::boolean)
 returning idashboardid;

--dashboard filter entries
INSERT INTO ui.dashboardfilters (
idashboardfilterid, ifilterorder, vcdashboardfiltername, idashboardid,
vcdashboardfiltertype, vcdashboardfilterdisplayname,
idashboardqueryidforoptions) VALUES (
(select max(idashboardfilterid)+1 from ui.dashboardfilters),
'0'::integer, 'Party'::character varying, '54'::integer,
'Select'::character varying, 'Level'::character varying,
'67'::integer)
 returning idashboardfilterid;
INSERT INTO ui.dashboardfilters (
idashboardfilterid, ifilterorder, vcdashboardfiltername, idashboardid,
vcdashboardfiltertype, vcdashboardfilterdisplayname,
idashboardqueryidforoptions) VALUES (
(select max(idashboardfilterid)+1 from ui.dashboardfilters),
'0'::integer, 'AttribsForm'::character varying, '54'::integer,
'FormFilter'::character varying, 'Attribs Form Filter'::character
varying, '74'::integer)
 returning idashboardfilterid;

--main query
INSERT INTO ui.dashboardquery (
idashboardqueryid, bparametersrequired, vcfilterparametersjson,
vcdashboardquery, formattingrequiered, runonanalytics,
transposerequired, imenustructuredesc) VALUES (
'107'::integer, true::boolean, '{"Party": null, "AttribsForm":null}'::text, '{
"Account":"select iaccountid, icustomerid, vcexternalaccountid,
iaccounttypeid, vcifsc, vcaccountproviderid, vcaccountname,
dtonboardingdate, dtexpirydate, imcc, bmerchant, bverified,
irecordstatus, dtentrydatetime from masters.accounts where itenantid =
:tenantid order by iaccountid desc limit 50000",
"VPA": "select ivpaid, iaccountid, vcexternaladdressid, vcaddress,
iproductid, vcvpaname, bverified, imcc, dtonboardingdate,
dtexpirydate, bmerchant, ivpaproviderid, bprofiled,
dtfirsttransaction, dtlasttransaction, irecordstatus, dtentrydatetime
from masters.vpa where itenantid = :tenantid order by ivpaid desc
limit 50000",
"Customer": "SELECT icustomerid, vcexternalcustid, vccustomername,
vccustomertype, vcsalutation, vcverifiedname, vcgender, dtdoidob,
dtonboardingdate, vcpostalcode, vcemail, vcregisteredmobile, imcc,
vcidentitytype1, vcidentitydetails1, vcidentitytype2,
vcidentitydetails2, vcregisteredaddressgeolocation, iadm3, iadm2,
iadm1, vccountrycode, cast(vcattribs->>''program_id'' as integer) as
\"Program ID\", irecordstatus, dtentrydatetime FROM masters.customers
where itenantid = :tenantid :AttribsForm order by icustomerid desc
limit 50000;"
}'::text, false::boolean, false::boolean, false::boolean, '510'::integer)
 returning idashboardqueryid;

--query params for main query
INSERT INTO ui.dashboardqueryparameters (
 idashboardparameterid, vcparametername, vcparametertype,
idashboardqueryid, iorder) VALUES (
 (select max(idashboardparameterid)+1 from
ui.dashboardqueryparameters), 'Party'::character varying,
'JsonPath'::character varying, '107'::integer, '1'::integer)
  returning idashboardparameterid;

INSERT INTO ui.dashboardqueryparameters (
 idashboardparameterid, vcparametername, vcparametertype,
idashboardqueryid, iorder) VALUES (
 (select max(idashboardparameterid)+1 from
ui.dashboardqueryparameters), 'AttribsForm'::character varying,
'WhereStatement'::character varying, '107'::integer, '1'::integer)
  returning idashboardparameterid;

--resultset
INSERT INTO ui.dashboardresultset (
idashboardresultsetid, vcdashboardresultsetlayout,
vcdashboardresultsetname, idashboardqueryid, idashboardid, irowno,
imenustructuredesc) VALUES
((select max(idashboardresultsetid)+1 from ui.dashboardresultset),
'{"sizes":[1],"detail":{"main":{"type":"tab-area","widgets":["PERSPECTIVE_GENERATED_ID_1"],"currentIndex":0}},"mode":"globalFilters","viewers":{"PERSPECTIVE_GENERATED_ID_1":{"plugin":"Datagrid","plugin_config":{"columns":{},"editable":false,"scroll_lock":true},"settings":false,"theme":"Pro
Dark","title":"Master
Extracts","group_by":[],"split_by":[],"columns":["imcc","vcifsc","bmerchant","bverified","vcaccount","iaccountid","icustomerid","dtexpirydate","irecordstatus","vcaccountname","iaccounttypeid","dtentrydatetime","attrib.CORPORATE","dtonboardingdate","vcaccountproviderid","vcexternalaccountid"],"filter":[],"sort":[],"expressions":[],"aggregates":{},"master":false,"table":"masterextracts","linked":false}}}'::text,
'masterextracts', '107'::integer, '54'::integer, '1'::integer, '510'::integer);

---------Master Extract for 42c tenantid=7
INSERT INTO ui.masterextractattribs (attribpath, level, datatype,
displayname, itenantid) VALUES ('cast(vcattribs->>''program_id'' as
integer) ', 'Customer', 'Integer', 'Program ID', 7);
INSERT INTO ui.dashboard (
idashboardid, bactive, bdelete, vcdashboardname, iorder, irowcount,
imenustructuredesc, itenantid, bdynamic) VALUES (
'55'::integer, true::boolean, false::boolean, 'Master
Extracts'::character varying, '16'::integer, '1'::integer,
'510'::integer, '7'::integer, true::boolean)
 returning idashboardid;

--dashboard filter entries
INSERT INTO ui.dashboardfilters (
idashboardfilterid, ifilterorder, vcdashboardfiltername, idashboardid,
vcdashboardfiltertype, vcdashboardfilterdisplayname,
idashboardqueryidforoptions) VALUES (
(select max(idashboardfilterid)+1 from ui.dashboardfilters),
'0'::integer, 'Party'::character varying, '55'::integer,
'Select'::character varying, 'Level'::character varying,
'67'::integer)
 returning idashboardfilterid;
INSERT INTO ui.dashboardfilters (
idashboardfilterid, ifilterorder, vcdashboardfiltername, idashboardid,
vcdashboardfiltertype, vcdashboardfilterdisplayname,
idashboardqueryidforoptions) VALUES (
(select max(idashboardfilterid)+1 from ui.dashboardfilters),
'0'::integer, 'AttribsForm'::character varying, '55'::integer,
'FormFilter'::character varying, 'Attribs Form Filter'::character
varying, '74'::integer)
 returning idashboardfilterid;

--main query
INSERT INTO ui.dashboardquery (
idashboardqueryid, bparametersrequired, vcfilterparametersjson,
vcdashboardquery, formattingrequiered, runonanalytics,
transposerequired, imenustructuredesc) VALUES (
'108'::integer, true::boolean, '{"Party": null, "AttribsForm":null}'::text, '{
"Account":"select iaccountid, icustomerid, vcexternalaccountid,
iaccounttypeid, vcifsc, vcaccountproviderid, vcaccountname,
dtonboardingdate, dtexpirydate, imcc, bmerchant, bverified,
irecordstatus, dtentrydatetime from masters.accounts where itenantid =
:tenantid order by iaccountid desc limit 50000",
"VPA": "select ivpaid, iaccountid, vcexternaladdressid, vcaddress,
iproductid, vcvpaname, bverified, imcc, dtonboardingdate,
dtexpirydate, bmerchant, ivpaproviderid, bprofiled,
dtfirsttransaction, dtlasttransaction, irecordstatus, dtentrydatetime
from masters.vpa where itenantid = :tenantid order by ivpaid desc
limit 50000",
"Customer": "SELECT icustomerid, vcexternalcustid, vccustomername,
vccustomertype, vcsalutation, vcverifiedname, vcgender, dtdoidob,
dtonboardingdate, vcpostalcode, vcemail, vcregisteredmobile, imcc,
vcidentitytype1, vcidentitydetails1, vcidentitytype2,
vcidentitydetails2, vcregisteredaddressgeolocation, iadm3, iadm2,
iadm1, vccountrycode, cast(vcattribs->>''program_id'' as integer) as
\"Program ID\", irecordstatus, dtentrydatetime FROM masters.customers
where itenantid = :tenantid :AttribsForm order by icustomerid desc
limit 50000;"
}'::text, false::boolean, false::boolean, false::boolean, '510'::integer)
 returning idashboardqueryid;

--query params for main query
INSERT INTO ui.dashboardqueryparameters (
 idashboardparameterid, vcparametername, vcparametertype,
idashboardqueryid, iorder) VALUES (
 (select max(idashboardparameterid)+1 from
ui.dashboardqueryparameters), 'Party'::character varying,
'JsonPath'::character varying, '108'::integer, '1'::integer)
  returning idashboardparameterid;

INSERT INTO ui.dashboardqueryparameters (
 idashboardparameterid, vcparametername, vcparametertype,
idashboardqueryid, iorder) VALUES (
 (select max(idashboardparameterid)+1 from
ui.dashboardqueryparameters), 'AttribsForm'::character varying,
'WhereStatement'::character varying, '108'::integer, '1'::integer)
  returning idashboardparameterid;

--resultset
INSERT INTO ui.dashboardresultset (
idashboardresultsetid, vcdashboardresultsetlayout,
vcdashboardresultsetname, idashboardqueryid, idashboardid, irowno,
imenustructuredesc) VALUES
((select max(idashboardresultsetid)+1 from ui.dashboardresultset),
'{"sizes":[1],"detail":{"main":{"type":"tab-area","widgets":["PERSPECTIVE_GENERATED_ID_1"],"currentIndex":0}},"mode":"globalFilters","viewers":{"PERSPECTIVE_GENERATED_ID_1":{"plugin":"Datagrid","plugin_config":{"columns":{},"editable":false,"scroll_lock":true},"settings":false,"theme":"Pro
Dark","title":"Master
Extracts","group_by":[],"split_by":[],"columns":["imcc","vcifsc","bmerchant","bverified","vcaccount","iaccountid","icustomerid","dtexpirydate","irecordstatus","vcaccountname","iaccounttypeid","dtentrydatetime","attrib.CORPORATE","dtonboardingdate","vcaccountproviderid","vcexternalaccountid"],"filter":[],"sort":[],"expressions":[],"aggregates":{},"master":false,"table":"masterextracts","linked":false}}}'::text,
'masterextracts', '108'::integer, '55'::integer, '1'::integer, '510'::integer);


---------Master Extract for YBAML tenantid=8
INSERT INTO ui.masterextractattribs (attribpath, level, datatype,
displayname, itenantid) VALUES ('vcattribs->''yb_raw''->>''pan'' ',
'Customer', 'String', 'PAN', 8);
INSERT INTO ui.masterextractattribs (attribpath, level, datatype,
displayname, itenantid) VALUES ('vcattribs->''yb_raw''->>''city'' ',
'Customer', 'String', 'City', 8);
INSERT INTO ui.masterextractattribs (attribpath, level, datatype,
displayname, itenantid) VALUES ('vcattribs->''yb_raw''->>''gstn'' ',
'Customer', 'String', 'GSTN', 8);
INSERT INTO ui.masterextractattribs (attribpath, level, datatype,
displayname, itenantid) VALUES ('vcattribs->''yb_raw''->>''pinCode''
', 'Customer', 'String', 'Pin Code', 8);
INSERT INTO ui.masterextractattribs (attribpath, level, datatype,
displayname, itenantid) VALUES ('vcattribs->''yb_raw''->>''district''
', 'Customer', 'String', 'District', 8);
INSERT INTO ui.masterextractattribs (attribpath, level, datatype,
displayname, itenantid) VALUES ('vcattribs->''yb_raw''->>''latitude''
', 'Customer', 'String', 'Latitude', 8);
INSERT INTO ui.masterextractattribs (attribpath, level, datatype,
displayname, itenantid) VALUES ('vcattribs->''yb_raw''->>''longitude''
', 'Customer', 'String', 'Longitude', 8);
INSERT INTO ui.masterextractattribs (attribpath, level, datatype,
displayname, itenantid) VALUES
('vcattribs->''yb_raw''->>''partnerName'' ', 'Customer', 'String',
'Partner Name', 8);
INSERT INTO ui.masterextractattribs (attribpath, level, datatype,
displayname, itenantid) VALUES
('vcattribs->''yb_raw''->>''businessName'' ', 'Customer', 'String',
'Business Name', 8);
INSERT INTO ui.masterextractattribs (attribpath, level, datatype,
displayname, itenantid) VALUES
('vcattribs->''yb_raw''->>''mobileNumber'' ', 'Customer', 'String',
'Mobile No.', 8);
INSERT INTO ui.masterextractattribs (attribpath, level, datatype,
displayname, itenantid) VALUES
('vcattribs->''yb_raw''->>''sellerVerifiedAccountName'' ', 'Customer',
'String', 'Verified Acc. Name', 8);
INSERT INTO ui.masterextractattribs (attribpath, level, datatype,
displayname, itenantid) VALUES
('vcattribs->''yb_raw''->>''turnOverType'' ', 'Customer', 'String',
'Turnover Type', 8);

INSERT INTO ui.dashboard (
idashboardid, bactive, bdelete, vcdashboardname, iorder, irowcount,
imenustructuredesc, itenantid, bdynamic) VALUES (
'56'::integer, true::boolean, false::boolean, 'Master
Extracts'::character varying, '16'::integer, '1'::integer,
'510'::integer, '8'::integer, true::boolean)
 returning idashboardid;

--dashboard filter entries
INSERT INTO ui.dashboardfilters (
idashboardfilterid, ifilterorder, vcdashboardfiltername, idashboardid,
vcdashboardfiltertype, vcdashboardfilterdisplayname,
idashboardqueryidforoptions) VALUES (
(select max(idashboardfilterid)+1 from ui.dashboardfilters),
'0'::integer, 'Party'::character varying, '56'::integer,
'Select'::character varying, 'Level'::character varying,
'67'::integer)
 returning idashboardfilterid;
INSERT INTO ui.dashboardfilters (
idashboardfilterid, ifilterorder, vcdashboardfiltername, idashboardid,
vcdashboardfiltertype, vcdashboardfilterdisplayname,
idashboardqueryidforoptions) VALUES (
(select max(idashboardfilterid)+1 from ui.dashboardfilters),
'0'::integer, 'AttribsForm'::character varying, '56'::integer,
'FormFilter'::character varying, 'Attribs Form Filter'::character
varying, '74'::integer)
 returning idashboardfilterid;

--main query
INSERT INTO ui.dashboardquery (
idashboardqueryid, bparametersrequired, vcfilterparametersjson,
vcdashboardquery, formattingrequiered, runonanalytics,
transposerequired, imenustructuredesc) VALUES (
'109'::integer, true::boolean, '{"Party": null, "AttribsForm":null}'::text, '{
"Account":"select iaccountid, icustomerid, vcexternalaccountid,
iaccounttypeid, vcifsc, vcaccountproviderid, vcaccountname,
dtonboardingdate, dtexpirydate, imcc, bmerchant, bverified,
irecordstatus, dtentrydatetime from masters.accounts where itenantid =
:tenantid order by iaccountid desc limit 50000",
"VPA": "select ivpaid, iaccountid, vcexternaladdressid, vcaddress,
iproductid, vcvpaname, bverified, imcc, dtonboardingdate,
dtexpirydate, bmerchant, ivpaproviderid, bprofiled,
dtfirsttransaction, dtlasttransaction, irecordstatus, dtentrydatetime
from masters.vpa where itenantid = :tenantid order by ivpaid desc
limit 50000",
"Customer": "SELECT icustomerid, vcexternalcustid, vccustomername,
vccustomertype, vcsalutation, vcverifiedname, vcgender, dtdoidob,
dtonboardingdate, vcpostalcode, vcemail, vcregisteredmobile, imcc,
vcidentitytype1, vcidentitydetails1, vcidentitytype2,
vcidentitydetails2, vcregisteredaddressgeolocation, iadm3, iadm2,
iadm1, vccountrycode, vcattribs->''yb_raw''->>''pan'' as \"PAN\",
vcattribs->''yb_raw''->>''city'' as \"City\",
vcattribs->''yb_raw''->>''gstn'' as \"GSTN\",
vcattribs->''yb_raw''->>''state'' as \"State\",
vcattribs->''yb_raw''->>''pinCode'' as \"Pin Code\",
vcattribs->''yb_raw''->>''district'' as \"District\",
vcattribs->''yb_raw''->>''latitude'' as \"Latitude\",
vcattribs->''yb_raw''->>''longitude'' as \"Longitude\",
vcattribs->''yb_raw''->>''partnerName'' as \"Partner Name\",
vcattribs->''yb_raw''->>''businessName'' as \"Business Name\",
vcattribs->''yb_raw''->>''mobileNumber'' as \"Mobile No.\",
vcattribs->''yb_raw''->>''sellerVerifiedAccountName'' as \"Verified
Acc. Name\", vcattribs->''yb_raw''->>''turnOverType'' as \"Turnover
Type\", irecordstatus, dtentrydatetime FROM masters.customers where
itenantid = :tenantid :AttribsForm order by icustomerid desc limit
50000;"
}'::text, false::boolean, false::boolean, false::boolean, '510'::integer)
 returning idashboardqueryid;

--query params for main query
INSERT INTO ui.dashboardqueryparameters (
 idashboardparameterid, vcparametername, vcparametertype,
idashboardqueryid, iorder) VALUES (
 (select max(idashboardparameterid)+1 from
ui.dashboardqueryparameters), 'Party'::character varying,
'JsonPath'::character varying, '109'::integer, '1'::integer)
  returning idashboardparameterid;

INSERT INTO ui.dashboardqueryparameters (
 idashboardparameterid, vcparametername, vcparametertype,
idashboardqueryid, iorder) VALUES (
 (select max(idashboardparameterid)+1 from
ui.dashboardqueryparameters), 'AttribsForm'::character varying,
'WhereStatement'::character varying, '109'::integer, '1'::integer)
  returning idashboardparameterid;

--resultset
INSERT INTO ui.dashboardresultset (
idashboardresultsetid, vcdashboardresultsetlayout,
vcdashboardresultsetname, idashboardqueryid, idashboardid, irowno,
imenustructuredesc) VALUES
((select max(idashboardresultsetid)+1 from ui.dashboardresultset),
'{"sizes":[1],"detail":{"main":{"type":"tab-area","widgets":["PERSPECTIVE_GENERATED_ID_1"],"currentIndex":0}},"mode":"globalFilters","viewers":{"PERSPECTIVE_GENERATED_ID_1":{"plugin":"Datagrid","plugin_config":{"columns":{},"editable":false,"scroll_lock":true},"settings":false,"theme":"Pro
Dark","title":"Master
Extracts","group_by":[],"split_by":[],"columns":["imcc","vcifsc","bmerchant","bverified","vcaccount","iaccountid","icustomerid","dtexpirydate","irecordstatus","vcaccountname","iaccounttypeid","dtentrydatetime","attrib.CORPORATE","dtonboardingdate","vcaccountproviderid","vcexternalaccountid"],"filter":[],"sort":[],"expressions":[],"aggregates":{},"master":false,"table":"masterextracts","linked":false}}}'::text,
'masterextracts', '109'::integer, '56'::integer, '1'::integer, '510'::integer);

---------Master Extract for YBFRM tenantid=9
INSERT INTO ui.masterextractattribs (attribpath, level, datatype,
displayname, itenantid) VALUES ('vcattribs->''yb_raw''->>''pan'' ',
'Customer', 'String', 'PAN', 9);
INSERT INTO ui.masterextractattribs (attribpath, level, datatype,
displayname, itenantid) VALUES ('vcattribs->''yb_raw''->>''city'' ',
'Customer', 'String', 'City', 9);
INSERT INTO ui.masterextractattribs (attribpath, level, datatype,
displayname, itenantid) VALUES ('vcattribs->''yb_raw''->>''gstn'' ',
'Customer', 'String', 'GSTN', 9);
INSERT INTO ui.masterextractattribs (attribpath, level, datatype,
displayname, itenantid) VALUES ('vcattribs->''yb_raw''->>''pinCode''
', 'Customer', 'String', 'Pin Code', 9);
INSERT INTO ui.masterextractattribs (attribpath, level, datatype,
displayname, itenantid) VALUES ('vcattribs->''yb_raw''->>''district''
', 'Customer', 'String', 'District', 9);
INSERT INTO ui.masterextractattribs (attribpath, level, datatype,
displayname, itenantid) VALUES ('vcattribs->''yb_raw''->>''latitude''
', 'Customer', 'String', 'Latitude', 9);
INSERT INTO ui.masterextractattribs (attribpath, level, datatype,
displayname, itenantid) VALUES ('vcattribs->''yb_raw''->>''longitude''
', 'Customer', 'String', 'Longitude', 9);
INSERT INTO ui.masterextractattribs (attribpath, level, datatype,
displayname, itenantid) VALUES
('vcattribs->''yb_raw''->>''partnerName'' ', 'Customer', 'String',
'Partner Name', 9);
INSERT INTO ui.masterextractattribs (attribpath, level, datatype,
displayname, itenantid) VALUES
('vcattribs->''yb_raw''->>''businessName'' ', 'Customer', 'String',
'Business Name', 9);
INSERT INTO ui.masterextractattribs (attribpath, level, datatype,
displayname, itenantid) VALUES
('vcattribs->''yb_raw''->>''mobileNumber'' ', 'Customer', 'String',
'Mobile No.', 9);
INSERT INTO ui.masterextractattribs (attribpath, level, datatype,
displayname, itenantid) VALUES
('vcattribs->''yb_raw''->>''sellerVerifiedAccountName'' ', 'Customer',
'String', 'Verified Acc. Name', 9);
INSERT INTO ui.masterextractattribs (attribpath, level, datatype,
displayname, itenantid) VALUES
('vcattribs->''yb_raw''->>''turnOverType'' ', 'Customer', 'String',
'Turnover Type', 9);

INSERT INTO ui.dashboard (
idashboardid, bactive, bdelete, vcdashboardname, iorder, irowcount,
imenustructuredesc, itenantid, bdynamic) VALUES (
'57'::integer, true::boolean, false::boolean, 'Master
Extracts'::character varying, '16'::integer, '1'::integer,
'510'::integer, '9'::integer, true::boolean)
 returning idashboardid;

--dashboard filter entries
INSERT INTO ui.dashboardfilters (
idashboardfilterid, ifilterorder, vcdashboardfiltername, idashboardid,
vcdashboardfiltertype, vcdashboardfilterdisplayname,
idashboardqueryidforoptions) VALUES (
(select max(idashboardfilterid)+1 from ui.dashboardfilters),
'0'::integer, 'Party'::character varying, '57'::integer,
'Select'::character varying, 'Level'::character varying,
'67'::integer)
 returning idashboardfilterid;
INSERT INTO ui.dashboardfilters (
idashboardfilterid, ifilterorder, vcdashboardfiltername, idashboardid,
vcdashboardfiltertype, vcdashboardfilterdisplayname,
idashboardqueryidforoptions) VALUES (
(select max(idashboardfilterid)+1 from ui.dashboardfilters),
'0'::integer, 'AttribsForm'::character varying, '57'::integer,
'FormFilter'::character varying, 'Attribs Form Filter'::character
varying, '74'::integer)
 returning idashboardfilterid;

--main query
INSERT INTO ui.dashboardquery (
idashboardqueryid, bparametersrequired, vcfilterparametersjson,
vcdashboardquery, formattingrequiered, runonanalytics,
transposerequired, imenustructuredesc) VALUES (
'110'::integer, true::boolean, '{"Party": null, "AttribsForm":null}'::text, '{
"Account":"select iaccountid, icustomerid, vcexternalaccountid,
iaccounttypeid, vcifsc, vcaccountproviderid, vcaccountname,
dtonboardingdate, dtexpirydate, imcc, bmerchant, bverified,
irecordstatus, dtentrydatetime from masters.accounts where itenantid =
:tenantid order by iaccountid desc limit 50000",
"VPA": "select ivpaid, iaccountid, vcexternaladdressid, vcaddress,
iproductid, vcvpaname, bverified, imcc, dtonboardingdate,
dtexpirydate, bmerchant, ivpaproviderid, bprofiled,
dtfirsttransaction, dtlasttransaction, irecordstatus, dtentrydatetime
from masters.vpa where itenantid = :tenantid order by ivpaid desc
limit 50000",
"Customer": "SELECT icustomerid, vcexternalcustid, vccustomername,
vccustomertype, vcsalutation, vcverifiedname, vcgender, dtdoidob,
dtonboardingdate, vcpostalcode, vcemail, vcregisteredmobile, imcc,
vcidentitytype1, vcidentitydetails1, vcidentitytype2,
vcidentitydetails2, vcregisteredaddressgeolocation, iadm3, iadm2,
iadm1, vccountrycode, vcattribs->''yb_raw''->>''pan'' as \"PAN\",
vcattribs->''yb_raw''->>''city'' as \"City\",
vcattribs->''yb_raw''->>''gstn'' as \"GSTN\",
vcattribs->''yb_raw''->>''state'' as \"State\",
vcattribs->''yb_raw''->>''pinCode'' as \"Pin Code\",
vcattribs->''yb_raw''->>''district'' as \"District\",
vcattribs->''yb_raw''->>''latitude'' as \"Latitude\",
vcattribs->''yb_raw''->>''longitude'' as \"Longitude\",
vcattribs->''yb_raw''->>''partnerName'' as \"Partner Name\",
vcattribs->''yb_raw''->>''businessName'' as \"Business Name\",
vcattribs->''yb_raw''->>''mobileNumber'' as \"Mobile No.\",
vcattribs->''yb_raw''->>''sellerVerifiedAccountName'' as \"Verified
Acc. Name\", vcattribs->''yb_raw''->>''turnOverType'' as \"Turnover
Type\", irecordstatus, dtentrydatetime FROM masters.customers where
itenantid = :tenantid :AttribsForm order by icustomerid desc limit
50000;"
}'::text, false::boolean, false::boolean, false::boolean, '510'::integer)
 returning idashboardqueryid;

--query params for main query
INSERT INTO ui.dashboardqueryparameters (
 idashboardparameterid, vcparametername, vcparametertype,
idashboardqueryid, iorder) VALUES (
 (select max(idashboardparameterid)+1 from
ui.dashboardqueryparameters), 'Party'::character varying,
'JsonPath'::character varying, '110'::integer, '1'::integer)
  returning idashboardparameterid;

INSERT INTO ui.dashboardqueryparameters (
 idashboardparameterid, vcparametername, vcparametertype,
idashboardqueryid, iorder) VALUES (
 (select max(idashboardparameterid)+1 from
ui.dashboardqueryparameters), 'AttribsForm'::character varying,
'WhereStatement'::character varying, '110'::integer, '1'::integer)
  returning idashboardparameterid;

--resultset
INSERT INTO ui.dashboardresultset (
idashboardresultsetid, vcdashboardresultsetlayout,
vcdashboardresultsetname, idashboardqueryid, idashboardid, irowno,
imenustructuredesc) VALUES
((select max(idashboardresultsetid)+1 from ui.dashboardresultset),
'{"sizes":[1],"detail":{"main":{"type":"tab-area","widgets":["PERSPECTIVE_GENERATED_ID_1"],"currentIndex":0}},"mode":"globalFilters","viewers":{"PERSPECTIVE_GENERATED_ID_1":{"plugin":"Datagrid","plugin_config":{"columns":{},"editable":false,"scroll_lock":true},"settings":false,"theme":"Pro
Dark","title":"Master
Extracts","group_by":[],"split_by":[],"columns":["imcc","vcifsc","bmerchant","bverified","vcaccount","iaccountid","icustomerid","dtexpirydate","irecordstatus","vcaccountname","iaccounttypeid","dtentrydatetime","attrib.CORPORATE","dtonboardingdate","vcaccountproviderid","vcexternalaccountid"],"filter":[],"sort":[],"expressions":[],"aggregates":{},"master":false,"table":"masterextracts","linked":false}}}'::text,
'masterextracts', '110'::integer, '57'::integer, '1'::integer, '510'::integer);

-----Master extract for Pinelabs tenantid=10
INSERT INTO ui.masterextractattribs (attribpath, level, datatype,
displayname, itenantid) VALUES ('vcattribs->>''accountaddress'' ',
'Customer', 'String', 'accountaddress', 10);
INSERT INTO ui.masterextractattribs (attribpath, level, datatype,
displayname, itenantid) VALUES ('vcattribs->>''accountnumber'' ',
'Customer', 'String', 'accountnumber', 10);
INSERT INTO ui.masterextractattribs (attribpath, level, datatype,
displayname, itenantid) VALUES ('vcattribs->>''ifsccode'' ',
'Customer', 'String', 'ifsccode', 10);
INSERT INTO ui.masterextractattribs (attribpath, level, datatype,
displayname, itenantid) VALUES ('vcattribs->>''bankname'' ',
'Customer', 'String', 'bankname', 10);
INSERT INTO ui.masterextractattribs (attribpath, level, datatype,
displayname, itenantid) VALUES ('vcattribs->>''settlementmode'' ',
'Customer', 'String', 'settlementmode', 10);
INSERT INTO ui.masterextractattribs (attribpath, level, datatype,
displayname, itenantid) VALUES ('vcattribs->>''accountonboardingdate''
', 'Customer', 'String', 'accountonboardingdate', 10);
INSERT INTO ui.masterextractattribs (attribpath, level, datatype,
displayname, itenantid) VALUES ('vcattribs->>''address'' ',
'Customer', 'String', 'address', 10);
INSERT INTO ui.masterextractattribs (attribpath, level, datatype,
displayname, itenantid) VALUES ('vcattribs->>''email'' ', 'Customer',
'String', 'email', 10);
INSERT INTO ui.masterextractattribs (attribpath, level, datatype,
displayname, itenantid) VALUES ('vcattribs->>''postalcode'' ',
'Customer', 'String', 'postalcode', 10);
INSERT INTO ui.masterextractattribs (attribpath, level, datatype,
displayname, itenantid) VALUES ('vcattribs->>''annualturnover'' ',
'Customer', 'String', 'annualturnover', 10);
INSERT INTO ui.masterextractattribs (attribpath, level, datatype,
displayname, itenantid) VALUES ('vcattribs->>''registeredmobile'' ',
'Customer', 'String', 'registeredmobile', 10);
INSERT INTO ui.masterextractattribs (attribpath, level, datatype,
displayname, itenantid) VALUES ('vcattribs->>''merchanttype'' ',
'Customer', 'String', 'merchanttype',10);

INSERT INTO ui.masterextractattribs (attribpath, level, datatype,
displayname, itenantid) VALUES ('vcattribs->>''reg_address'' ',
'Account', 'String', 'reg_address', 10);
INSERT INTO ui.masterextractattribs (attribpath, level, datatype,
displayname, itenantid) VALUES ('vcattribs->>''postal_code'' ',
'Account', 'String', 'postal_code', 10);
INSERT INTO ui.masterextractattribs (attribpath, level, datatype,
displayname, itenantid) VALUES ('vcattribs->>''merchant_type'' ',
'Account', 'String', 'merchant_type', 10);
INSERT INTO ui.masterextractattribs (attribpath, level, datatype,
displayname, itenantid) VALUES ('vcattribs->>''registered_mobile'' ',
'Account', 'String', 'registered_mobile', 10);
INSERT INTO ui.masterextractattribs (attribpath, level, datatype,
displayname, itenantid) VALUES ('vcattribs->>''email'' ', 'Account',
'String', 'email', 10);

INSERT INTO ui.dashboard (
idashboardid, bactive, bdelete, vcdashboardname, iorder, irowcount,
imenustructuredesc, itenantid, bdynamic) VALUES (
'58'::integer, true::boolean, false::boolean, 'Master
Extracts'::character varying, '16'::integer, '1'::integer,
'510'::integer, '10'::integer, true::boolean)
 returning idashboardid;

--dashboard filter entries
INSERT INTO ui.dashboardfilters (
idashboardfilterid, ifilterorder, vcdashboardfiltername, idashboardid,
vcdashboardfiltertype, vcdashboardfilterdisplayname,
idashboardqueryidforoptions) VALUES (
(select max(idashboardfilterid)+1 from ui.dashboardfilters),
'0'::integer, 'Party'::character varying, '58'::integer,
'Select'::character varying, 'Level'::character varying,
'67'::integer)
 returning idashboardfilterid;
INSERT INTO ui.dashboardfilters (
idashboardfilterid, ifilterorder, vcdashboardfiltername, idashboardid,
vcdashboardfiltertype, vcdashboardfilterdisplayname,
idashboardqueryidforoptions) VALUES (
(select max(idashboardfilterid)+1 from ui.dashboardfilters),
'0'::integer, 'AttribsForm'::character varying, '58'::integer,
'FormFilter'::character varying, 'Attribs Form Filter'::character
varying, '74'::integer)
 returning idashboardfilterid;

--main query
INSERT INTO ui.dashboardquery (
idashboardqueryid, bparametersrequired, vcfilterparametersjson,
vcdashboardquery, formattingrequiered, runonanalytics,
transposerequired, imenustructuredesc) VALUES (
'111'::integer, true::boolean, '{"Party": null, "AttribsForm":null}'::text, '{
"Account":"select iaccountid, icustomerid, vcexternalaccountid,
iaccounttypeid, vcifsc, vcaccountproviderid, vcaccountname,
dtonboardingdate, dtexpirydate, imcc, bmerchant, bverified,
irecordstatus, dtentrydatetime, vcattribs->>''reg_address'' as
\"reg_address\", vcattribs->>''postal_code'' as \"postal_code\",
vcattribs->>''merchant_type'' as \"merchant_type\",
vcattribs->>''registered_mobile'' as \"registered_mobile\",
vcattribs->>''email'' as \"email\" from masters.accounts where
itenantid = :tenantid :AttribsForm order by iaccountid desc limit
50000",
"VPA": "select ivpaid, iaccountid, vcexternaladdressid, vcaddress,
iproductid, vcvpaname, bverified, imcc, dtonboardingdate,
dtexpirydate, bmerchant, ivpaproviderid, bprofiled,
dtfirsttransaction, dtlasttransaction, irecordstatus, dtentrydatetime
from masters.vpa where itenantid = :tenantid order by ivpaid desc
limit 50000",
"Customer": "SELECT icustomerid, vcexternalcustid, vccustomername,
vccustomertype, vcsalutation, vcverifiedname, vcgender, dtdoidob,
dtonboardingdate, vcpostalcode, vcemail, vcregisteredmobile, imcc,
vcidentitytype1, vcidentitydetails1, vcidentitytype2,
vcidentitydetails2, vcregisteredaddressgeolocation, iadm3, iadm2,
iadm1, vccountrycode, vcattribs->>''accountaddress'' as
\"accountaddress\", vcattribs->>''accountnumber'' as
\"accountnumber\", vcattribs->>''ifsccode'' as \"ifscode\",
vcattribs->>''bankname'' as \"bankname\",
vcattribs->>''settlementmode'' as \"settlementmode\",
vcattribs->>''accountonboardingdate'' as \"accountonboardingdate\",
vcattribs->>''address'' as \"address\", vcattribs->>''email'' as
\"email\", vcattribs->>''postalcode'' as \"postalcode\",
vcattribs->>''annualturnover'' as \"annualturnover\",
vcattribs->>''registeredmobile'' as \"registeredmobile\",
vcattribs->>''merchanttype'' as \"merchanttype\", vcattribs->>''risk''
as \"risk\", irecordstatus, dtentrydatetime FROM masters.customers
where itenantid = :tenantid :AttribsForm order by icustomerid desc
limit 50000;"}'::text, false::boolean, false::boolean, false::boolean, '510'::integer)
 returning idashboardqueryid;

--query params for main query
INSERT INTO ui.dashboardqueryparameters (
 idashboardparameterid, vcparametername, vcparametertype,
idashboardqueryid, iorder) VALUES (
 (select max(idashboardparameterid)+1 from
ui.dashboardqueryparameters), 'Party'::character varying,
'JsonPath'::character varying, '111'::integer, '1'::integer)
  returning idashboardparameterid;

INSERT INTO ui.dashboardqueryparameters (
 idashboardparameterid, vcparametername, vcparametertype,
idashboardqueryid, iorder) VALUES (
 (select max(idashboardparameterid)+1 from
ui.dashboardqueryparameters), 'AttribsForm'::character varying,
'WhereStatement'::character varying, '111'::integer, '1'::integer)
  returning idashboardparameterid;

--resultset
INSERT INTO ui.dashboardresultset (
idashboardresultsetid, vcdashboardresultsetlayout,
vcdashboardresultsetname, idashboardqueryid, idashboardid, irowno,
imenustructuredesc) VALUES
((select max(idashboardresultsetid)+1 from ui.dashboardresultset),
'{"sizes":[1],"detail":{"main":{"type":"tab-area","widgets":["PERSPECTIVE_GENERATED_ID_1"],"currentIndex":0}},"mode":"globalFilters","viewers":{"PERSPECTIVE_GENERATED_ID_1":{"plugin":"Datagrid","plugin_config":{"columns":{},"editable":false,"scroll_lock":true},"settings":false,"theme":"Pro
Dark","title":"Master
Extracts","group_by":[],"split_by":[],"columns":["imcc","vcifsc","bmerchant","bverified","vcaccount","iaccountid","icustomerid","dtexpirydate","irecordstatus","vcaccountname","iaccounttypeid","dtentrydatetime","attrib.CORPORATE","dtonboardingdate","vcaccountproviderid","vcexternalaccountid"],"filter":[],"sort":[],"expressions":[],"aggregates":{},"master":false,"table":"masterextracts","linked":false}}}'::text,
'masterextracts', '111'::integer, '58'::integer, '1'::integer, '510'::integer);

---Master extract update query for tenantid = null
UPDATE ui.dashboardquery SET vcdashboardquery='{
"Account":"select iaccountid, icustomerid, vcexternalaccountid,
iaccounttypeid, vcifsc, vcaccountproviderid, vcaccountname,
dtonboardingdate, dtexpirydate, imcc, bmerchant, bverified,
irecordstatus, dtentrydatetime from masters.accounts where itenantid =
:tenantid order by iaccountid desc limit 50000",
"VPA": "select ivpaid, iaccountid, vcexternaladdressid, vcaddress,
iproductid, vcvpaname, bverified, imcc, dtonboardingdate,
dtexpirydate, bmerchant, ivpaproviderid, bprofiled,
dtfirsttransaction, dtlasttransaction, irecordstatus, dtentrydatetime
from masters.vpa where itenantid = :tenantid order by ivpaid desc
limit 50000",
"Customer": "SELECT icustomerid, vcexternalcustid, vccustomername,
vccustomertype, vcsalutation, vcverifiedname, vcgender, dtdoidob,
dtonboardingdate, vcpostalcode, vcemail, vcregisteredmobile, imcc,
vcidentitytype1, vcidentitydetails1, vcidentitytype2,
vcidentitydetails2, vcregisteredaddressgeolocation, iadm3, iadm2,
iadm1, vccountrycode, irecordstatus, dtentrydatetime FROM
masters.customers where itenantid = :tenantid order by icustomerid
desc limit 50000;"}'::TEXT, formattingrequiered=false WHERE idashboardqueryid=48;