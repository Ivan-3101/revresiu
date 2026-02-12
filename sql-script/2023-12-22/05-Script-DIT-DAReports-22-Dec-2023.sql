
---setting up for PL attribs in DIT for tenantid 1

INSERT INTO ui.masterextractattribs (attribpath, level, datatype, displayname, itenantid) VALUES ('vcattribs->>''accountaddress'' ', 'Customer', 'String', 'accountaddress', 1);
INSERT INTO ui.masterextractattribs (attribpath, level, datatype, displayname, itenantid) VALUES ('vcattribs->>''accountnumber'' ', 'Customer', 'String', 'accountnumber', 1);
INSERT INTO ui.masterextractattribs (attribpath, level, datatype, displayname, itenantid) VALUES ('vcattribs->>''ifsccode'' ', 'Customer', 'String', 'ifsccode', 1);
INSERT INTO ui.masterextractattribs (attribpath, level, datatype, displayname, itenantid) VALUES ('vcattribs->>''bankname'' ', 'Customer', 'String', 'bankname', 1);
INSERT INTO ui.masterextractattribs (attribpath, level, datatype, displayname, itenantid) VALUES ('vcattribs->>''settlementmode'' ', 'Customer', 'String', 'settlementmode', 1);
INSERT INTO ui.masterextractattribs (attribpath, level, datatype, displayname, itenantid) VALUES ('vcattribs->>''accountonboardingdate'' ', 'Customer', 'String', 'accountonboardingdate', 1);
INSERT INTO ui.masterextractattribs (attribpath, level, datatype, displayname, itenantid) VALUES ('vcattribs->>''address'' ', 'Customer', 'String', 'address', 1);
INSERT INTO ui.masterextractattribs (attribpath, level, datatype, displayname, itenantid) VALUES ('vcattribs->>''email'' ', 'Customer', 'String', 'email', 1);
INSERT INTO ui.masterextractattribs (attribpath, level, datatype, displayname, itenantid) VALUES ('vcattribs->>''postalcode'' ', 'Customer', 'String', 'postalcode', 1);
INSERT INTO ui.masterextractattribs (attribpath, level, datatype, displayname, itenantid) VALUES ('vcattribs->>''annualturnover'' ', 'Customer', 'String', 'annualturnover', 1);
INSERT INTO ui.masterextractattribs (attribpath, level, datatype, displayname, itenantid) VALUES ('vcattribs->>''registeredmobile'' ', 'Customer', 'String', 'registeredmobile', 1);
INSERT INTO ui.masterextractattribs (attribpath, level, datatype, displayname, itenantid) VALUES ('vcattribs->>''merchanttype'' ', 'Customer', 'String', 'merchanttype', 1);

INSERT INTO ui.masterextractattribs (attribpath, level, datatype, displayname, itenantid) VALUES ('vcattribs->>''reg_address'' ', 'Account', 'String', 'reg_address', 1);
INSERT INTO ui.masterextractattribs (attribpath, level, datatype, displayname, itenantid) VALUES ('vcattribs->>''postal_code'' ', 'Account', 'String', 'postal_code', 1);
INSERT INTO ui.masterextractattribs (attribpath, level, datatype, displayname, itenantid) VALUES ('vcattribs->>''merchant_type'' ', 'Account', 'String', 'merchant_type', 1);
INSERT INTO ui.masterextractattribs (attribpath, level, datatype, displayname, itenantid) VALUES ('vcattribs->>''registered_mobile'' ', 'Account', 'String', 'registered_mobile', 1);
INSERT INTO ui.masterextractattribs (attribpath, level, datatype, displayname, itenantid) VALUES ('vcattribs->>''email'' ', 'Account', 'String', 'email', 1);

---dashboard entry
INSERT INTO ui.dashboard (
idashboardid, bactive, bdelete, vcdashboardname, iorder, irowcount, imenustructuredesc, itenantid, bdynamic) VALUES (
'53'::integer, true::boolean, false::boolean, 'Master Extracts'::character varying, '16'::integer, '1'::integer, '510'::integer, '1'::integer, true::boolean)
 returning idashboardid;

--dashboard filter entries
INSERT INTO ui.dashboardfilters (
idashboardfilterid, ifilterorder, vcdashboardfiltername, idashboardid, vcdashboardfiltertype, vcdashboardfilterdisplayname, idashboardqueryidforoptions) VALUES (
(select max(idashboardfilterid)+1 from ui.dashboardfilters), '0'::integer, 'Party'::character varying, '53'::integer, 'Select'::character varying, 'Level'::character varying, '67'::integer)
 returning idashboardfilterid;
INSERT INTO ui.dashboardfilters (
idashboardfilterid, ifilterorder, vcdashboardfiltername, idashboardid, vcdashboardfiltertype, vcdashboardfilterdisplayname, idashboardqueryidforoptions) VALUES (
(select max(idashboardfilterid)+1 from ui.dashboardfilters), '0'::integer, 'AttribsForm'::character varying, '53'::integer, 'FormFilter'::character varying, 'Attribs Form Filter'::character varying, '74'::integer)
 returning idashboardfilterid;

--main query
INSERT INTO ui.dashboardquery (
idashboardqueryid, bparametersrequired, vcfilterparametersjson, vcdashboardquery, formattingrequiered, runonanalytics, transposerequired, imenustructuredesc) VALUES (
'106'::integer, true::boolean, '{"Party": null, "AttribsForm":null}'::text, '{
	"Account":"select iaccountid, icustomerid, vcexternalaccountid, iaccounttypeid, vcifsc, vcaccountproviderid, vcaccountname, dtonboardingdate, dtexpirydate, imcc, bmerchant, bverified, irecordstatus, dtentrydatetime, vcattribs->>''reg_address'' as \"reg_address\", vcattribs->>''postal_code'' as \"postal_code\", vcattribs->>''merchant_type'' as \"merchant_type\", vcattribs->>''registered_mobile'' as \"registered_mobile\", vcattribs->>''email'' as \"email\" from masters.accounts :AttribsForm order by iaccountid desc limit 50000",
	"VPA": "select ivpaid, iaccountid, vcexternaladdressid, vcaddress, iproductid, vcvpaname, bverified, imcc, dtonboardingdate, dtexpirydate, bmerchant, ivpaproviderid, bprofiled, dtfirsttransaction, dtlasttransaction, irecordstatus, dtentrydatetime from masters.vpa order by ivpaid desc limit 50000",
	"Customer": "SELECT icustomerid, vcexternalcustid, vccustomername, vccustomertype, vcsalutation, vcverifiedname, vcgender, dtdoidob, dtonboardingdate, vcpostalcode, vcemail, vcregisteredmobile, imcc, vcidentitytype1, vcidentitydetails1, vcidentitytype2, vcidentitydetails2, vcregisteredaddressgeolocation, iadm3, iadm2, iadm1, vccountrycode, vcattribs->>''accountaddress'' as \"accountaddress\", vcattribs->>''accountnumber'' as \"accountnumber\", vcattribs->>''ifsccode'' as \"ifscode\", vcattribs->>''bankname'' as \"bankname\", vcattribs->>''settlementmode'' as \"settlementmode\", vcattribs->>''accountonboardingdate'' as \"accountonboardingdate\", vcattribs->>''address'' as \"address\", vcattribs->>''email'' as \"email\", vcattribs->>''postalcode'' as \"postalcode\", vcattribs->>''annualturnover'' as \"annualturnover\", vcattribs->>''registeredmobile'' as \"registeredmobile\", vcattribs->>''merchanttype'' as \"merchanttype\", vcattribs->>''risk'' as \"risk\", irecordstatus, dtentrydatetime FROM masters.customers :AttribsForm order by icustomerid desc limit 50000;"
}'::text, false::boolean, false::boolean, false::boolean, '510'::integer)
 returning idashboardqueryid;

--query params for main query
INSERT INTO ui.dashboardqueryparameters (
 idashboardparameterid, vcparametername, vcparametertype, idashboardqueryid, iorder) VALUES (
 (select max(idashboardparameterid)+1 from ui.dashboardqueryparameters), 'Party'::character varying, 'JsonPath'::character varying, '106'::integer, '1'::integer)
  returning idashboardparameterid;

INSERT INTO ui.dashboardqueryparameters (
 idashboardparameterid, vcparametername, vcparametertype, idashboardqueryid, iorder) VALUES (
 (select max(idashboardparameterid)+1 from ui.dashboardqueryparameters), 'AttribsForm'::character varying, 'WhereStatement'::character varying, '106'::integer, '1'::integer)
  returning idashboardparameterid;

--resultset
INSERT INTO ui.dashboardresultset (
idashboardresultsetid, vcdashboardresultsetlayout, vcdashboardresultsetname, idashboardqueryid, idashboardid, irowno, imenustructuredesc) VALUES
((select max(idashboardfilterid)+1 from ui.dashboardfilters), '{"sizes":[1],"detail":{"main":{"type":"tab-area","widgets":["PERSPECTIVE_GENERATED_ID_1"],"currentIndex":0}},"mode":"globalFilters","viewers":{"PERSPECTIVE_GENERATED_ID_1":{"plugin":"Datagrid","plugin_config":{"columns":{},"editable":false,"scroll_lock":true},"settings":false,"theme":"Pro Dark","title":"Master Extracts","group_by":[],"split_by":[],"columns":["imcc","vcifsc","bmerchant","bverified","vcaccount","iaccountid","icustomerid","dtexpirydate","irecordstatus","vcaccountname","iaccounttypeid","dtentrydatetime","attrib.CORPORATE","dtonboardingdate","vcaccountproviderid","vcexternalaccountid"],"filter":[],"sort":[],"expressions":[],"aggregates":{},"master":false,"table":"masterextracts","linked":false}}}'::text,
'masterextracts', '106'::integer, '53'::integer, '1'::integer, '510'::integer);

---Master extract update query for tenantid = null
UPDATE ui.dashboardquery SET vcdashboardquery='{
	"Account":"select iaccountid, icustomerid, vcexternalaccountid, iaccounttypeid, vcifsc, vcaccountproviderid, vcaccountname, dtonboardingdate, dtexpirydate, imcc, bmerchant, bverified, irecordstatus, dtentrydatetime from masters.accounts order by iaccountid desc limit 50000",
	"VPA": "select ivpaid, iaccountid, vcexternaladdressid, vcaddress, iproductid, vcvpaname, bverified, imcc, dtonboardingdate, dtexpirydate, bmerchant, ivpaproviderid, bprofiled, dtfirsttransaction, dtlasttransaction, irecordstatus, dtentrydatetime from masters.vpa order by ivpaid desc limit 50000",
	"Customer": "SELECT icustomerid, vcexternalcustid, vccustomername, vccustomertype, vcsalutation, vcverifiedname, vcgender, dtdoidob, dtonboardingdate, vcpostalcode, vcemail, vcregisteredmobile, imcc, vcidentitytype1, vcidentitydetails1, vcidentitytype2, vcidentitydetails2, vcregisteredaddressgeolocation, iadm3, iadm2, iadm1, vccountrycode, irecordstatus, dtentrydatetime FROM masters.customers order by icustomerid desc limit 50000;"
}'::TEXT, formattingrequiered=false WHERE idashboardqueryid=48;



