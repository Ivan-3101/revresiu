--42c master extracts
delete FROM ui.dashboardcustomlayoutaudit where iresultsetid in (select idashboardresultsetid from ui.dashboardresultset where itenantid in (6,7,20) and  idashboardid in (16,54,55)) and itenantid in (6,7,20);

delete FROM ui.dashboardcustomlayout where iresultsetid in (select idashboardresultsetid from ui.dashboardresultset where itenantid in (6,7,20) and  idashboardid in (16,54,55)) and itenantid in (6,7,20);

delete from ui.dashboardresultset where itenantid in (6,7,20) and  idashboardid in (16,54,55);

delete from ui.dashboardfilters where itenantid in (6,7,20) and  idashboardid in (16,54,55); 
	
delete from ui.dashboard where idashboardid in (16,54,55) and itenantid in (6,7,20);

delete from ui.dashboardqueryparameters where itenantid in (6,7,20) and idashboardqueryid in (48,107,108);

delete from ui.dashboardquery where itenantid in (6,7,20) and idashboardqueryid in (48,107,108);

INSERT INTO ui.dashboard (
idashboardid, bactive, bdelete, vcdashboardname, iorder, irowcount, imenustructuredesc, itenantid, bdynamic) VALUES (
'16'::integer, true::boolean, false::boolean, 'Master Extracts'::character varying, '16'::integer, '1'::integer, '510'::integer, '6'::integer, true::boolean)
 returning idashboardid,itenantid;
 INSERT INTO ui.dashboard (
idashboardid, bactive, bdelete, vcdashboardname, iorder, irowcount, imenustructuredesc, itenantid, bdynamic) VALUES (
'16'::integer, true::boolean, false::boolean, 'Master Extracts'::character varying, '16'::integer, '1'::integer, '510'::integer, '7'::integer, true::boolean)
 returning idashboardid,itenantid;
 INSERT INTO ui.dashboard (
idashboardid, bactive, bdelete, vcdashboardname, iorder, irowcount, imenustructuredesc, itenantid, bdynamic) VALUES (
'16'::integer, true::boolean, false::boolean, 'Master Extracts'::character varying, '16'::integer, '1'::integer, '510'::integer, '20'::integer, true::boolean)
 returning idashboardid,itenantid;

INSERT INTO ui.dashboardquery (
idashboardqueryid, bparametersrequired, vcfilterparametersjson, vcdashboardquery, formattingrequiered, runonanalytics, transposerequired, imenustructuredesc, itenantid) VALUES (
'48'::integer, true::boolean, '{"Party": null, "AttribsForm":null}'::text, '{
	"Account":"select iaccountid, icustomerid, vcexternalaccountid, iaccounttypeid, vcifsc, vcaccountproviderid, vcaccountname, dtonboardingdate, dtexpirydate, imcc, bmerchant, bverified, irecordstatus, dtentrydatetime from masters.accounts where itenantid = :tenantid order by iaccountid desc limit 50000",
	"VPA": "select ivpaid, iaccountid, vcexternaladdressid, vcaddress, iproductid, vcvpaname, bverified, imcc, dtonboardingdate, dtexpirydate, bmerchant, ivpaproviderid, bprofiled, dtfirsttransaction, dtlasttransaction, irecordstatus, dtentrydatetime from masters.vpa where itenantid = :tenantid order by ivpaid desc limit 50000",
	"Customer": "SELECT icustomerid, vcexternalcustid, vccustomername, vccustomertype, vcsalutation, vcverifiedname, vcgender, dtdoidob, dtonboardingdate, vcpostalcode, vcemail, vcregisteredmobile, imcc, vcidentitytype1, vcidentitydetails1, vcidentitytype2, vcidentitydetails2, vcregisteredaddressgeolocation, iadm3, iadm2, iadm1, vccountrycode, irecordstatus, dtentrydatetime FROM masters.customers where itenantid = :tenantid :AttribsForm order by icustomerid desc limit 50000;"
}'::text, false::boolean, false::boolean, false::boolean, '510'::integer, '6'::integer)
 returning idashboardqueryid,itenantid;
 INSERT INTO ui.dashboardquery (
idashboardqueryid, bparametersrequired, vcfilterparametersjson, vcdashboardquery, formattingrequiered, runonanalytics, transposerequired, imenustructuredesc, itenantid) VALUES (
'48'::integer, true::boolean, '{"Party": null, "AttribsForm":null}'::text, '{
	"Account":"select iaccountid, icustomerid, vcexternalaccountid, iaccounttypeid, vcifsc, vcaccountproviderid, vcaccountname, dtonboardingdate, dtexpirydate, imcc, bmerchant, bverified, irecordstatus, dtentrydatetime from masters.accounts where itenantid = :tenantid order by iaccountid desc limit 50000",
	"VPA": "select ivpaid, iaccountid, vcexternaladdressid, vcaddress, iproductid, vcvpaname, bverified, imcc, dtonboardingdate, dtexpirydate, bmerchant, ivpaproviderid, bprofiled, dtfirsttransaction, dtlasttransaction, irecordstatus, dtentrydatetime from masters.vpa where itenantid = :tenantid order by ivpaid desc limit 50000",
	"Customer": "SELECT icustomerid, vcexternalcustid, vccustomername, vccustomertype, vcsalutation, vcverifiedname, vcgender, dtdoidob, dtonboardingdate, vcpostalcode, vcemail, vcregisteredmobile, imcc, vcidentitytype1, vcidentitydetails1, vcidentitytype2, vcidentitydetails2, vcregisteredaddressgeolocation, iadm3, iadm2, iadm1, vccountrycode, irecordstatus, dtentrydatetime FROM masters.customers where itenantid = :tenantid :AttribsForm order by icustomerid desc limit 50000;"
}'::text, false::boolean, false::boolean, false::boolean, '510'::integer, '7'::integer)
 returning idashboardqueryid,itenantid;
 INSERT INTO ui.dashboardquery (
idashboardqueryid, bparametersrequired, vcfilterparametersjson, vcdashboardquery, formattingrequiered, runonanalytics, transposerequired, imenustructuredesc, itenantid) VALUES (
'48'::integer, true::boolean, '{"Party": null, "AttribsForm":null}'::text,  E'{
"Account":"select iaccountid, icustomerid, vcexternalaccountid,iaccounttypeid, vcifsc, vcaccountproviderid, vcaccountname,dtonboardingdate, dtexpirydate, imcc, bmerchant, bverified,irecordstatus, dtentrydatetime from masters.accounts where itenantid =:tenantid order by iaccountid desc limit 50000",
"VPA": "select ivpaid, iaccountid, vcexternaladdressid, vcaddress, iproductid, vcvpaname, bverified, imcc, dtonboardingdate, dtexpirydate, bmerchant, ivpaproviderid, bprofiled, dtfirsttransaction, dtlasttransaction, irecordstatus, dtentrydatetime from masters.vpa where itenantid = :tenantid order by ivpaid desc limit 50000",
"Customer": "SELECT icustomerid, vcexternalcustid, vccustomername, vccustomertype, vcsalutation, vcverifiedname, vcgender, dtdoidob, dtonboardingdate, vcpostalcode, vcemail, vcregisteredmobile, imcc, vcidentitytype1, vcidentitydetails1, vcidentitytype2, vcidentitydetails2, vcregisteredaddressgeolocation, iadm3, iadm2, iadm1, vccountrycode, vcattribs->''yb_raw''->>''pan'' as \\"PAN\\", vcattribs->''yb_raw''->>''city'' as \\"City\\", vcattribs->''yb_raw''->>''gstn'' as \\"GSTN\\", vcattribs->''yb_raw''->>''state'' as \\"State\\", vcattribs->''yb_raw''->>''pinCode'' as \\"Pin Code\\", vcattribs->''yb_raw''->>''district'' as \\"District\\", vcattribs->''yb_raw''->>''latitude'' as \\"Latitude\\", vcattribs->''yb_raw''->>''longitude'' as \\"Longitude\\", vcattribs->''yb_raw''->>''partnerName'' as \\"Partner Name\\", vcattribs->''yb_raw''->>''businessName'' as \\"Business Name\\", vcattribs->''yb_raw''->>''mobileNumber'' as \\"Mobile No.\\", vcattribs->''yb_raw''->>''sellerVerifiedAccountName'' as \\"Verified Acc. Name\\", vcattribs->''yb_raw''->>''turnOverType'' as \\"Turnover Type\\", irecordstatus, dtentrydatetime FROM masters.customers where itenantid = :tenantid :AttribsForm order by icustomerid desc limit 50000;"
}'::text, false::boolean, false::boolean, false::boolean, '510'::integer, '20'::integer)
 returning idashboardqueryid,itenantid;

INSERT INTO ui.dashboardresultset (
idashboardresultsetid, vcdashboardresultsetlayout, vcdashboardresultsetname, idashboardqueryid, idashboardid, irowno, imenustructuredesc, itenantid, iorgid) VALUES (
(select max(idashboardresultsetid) + 1 from ui.dashboardresultset), '{"sizes":[1],"detail":{"main":{"type":"tab-area","widgets":["PERSPECTIVE_GENERATED_ID_1"],"currentIndex":0}},"mode":"globalFilters","viewers":{"PERSPECTIVE_GENERATED_ID_1":{"plugin":"Datagrid","plugin_config":{"columns":{},"editable":false,"scroll_lock":true},"settings":false,"theme":"Pro Dark","title":"Master Extracts","group_by":[],"split_by":[],"columns":["imcc","vcifsc","bmerchant","bverified","vcaccount","iaccountid","icustomerid","dtexpirydate","irecordstatus","vcaccountname","iaccounttypeid","dtentrydatetime","attrib.CORPORATE","dtonboardingdate","vcaccountproviderid","vcexternalaccountid"],"filter":[],"sort":[],"expressions":[],"aggregates":{},"master":false,"table":"masterextracts","linked":false}}}'::text, 'masterextracts'::character varying, '48'::integer, '16'::integer, '1'::integer, '510'::integer, '6'::integer, '4'::integer)
 returning idashboardresultsetid,itenantid;
 INSERT INTO ui.dashboardresultset (
idashboardresultsetid, vcdashboardresultsetlayout, vcdashboardresultsetname, idashboardqueryid, idashboardid, irowno, imenustructuredesc, itenantid, iorgid) VALUES (
(select max(idashboardresultsetid) + 1 from ui.dashboardresultset), '{"sizes":[1],"detail":{"main":{"type":"tab-area","widgets":["PERSPECTIVE_GENERATED_ID_1"],"currentIndex":0}},"mode":"globalFilters","viewers":{"PERSPECTIVE_GENERATED_ID_1":{"plugin":"Datagrid","plugin_config":{"columns":{},"editable":false,"scroll_lock":true},"settings":false,"theme":"Pro Dark","title":"Master Extracts","group_by":[],"split_by":[],"columns":["imcc","vcifsc","bmerchant","bverified","vcaccount","iaccountid","icustomerid","dtexpirydate","irecordstatus","vcaccountname","iaccounttypeid","dtentrydatetime","attrib.CORPORATE","dtonboardingdate","vcaccountproviderid","vcexternalaccountid"],"filter":[],"sort":[],"expressions":[],"aggregates":{},"master":false,"table":"masterextracts","linked":false}}}'::text, 'masterextracts'::character varying, '48'::integer, '16'::integer, '1'::integer, '510'::integer, '20'::integer, '4'::integer)
 returning idashboardresultsetid,itenantid;
INSERT INTO ui.dashboardresultset (
idashboardresultsetid, vcdashboardresultsetlayout, vcdashboardresultsetname, idashboardqueryid, idashboardid, irowno, imenustructuredesc, itenantid, iorgid) VALUES (
(select max(idashboardresultsetid) + 1 from ui.dashboardresultset), '{"sizes":[1],"detail":{"main":{"type":"tab-area","widgets":["PERSPECTIVE_GENERATED_ID_1"],"currentIndex":0}},"mode":"globalFilters","viewers":{"PERSPECTIVE_GENERATED_ID_1":{"plugin":"Datagrid","plugin_config":{"columns":{},"editable":false,"scroll_lock":true},"settings":false,"theme":"Pro Dark","title":"Master Extracts","group_by":[],"split_by":[],"columns":["imcc","vcifsc","bmerchant","bverified","vcaccount","iaccountid","icustomerid","dtexpirydate","irecordstatus","vcaccountname","iaccounttypeid","dtentrydatetime","attrib.CORPORATE","dtonboardingdate","vcaccountproviderid","vcexternalaccountid"],"filter":[],"sort":[],"expressions":[],"aggregates":{},"master":false,"table":"masterextracts","linked":false}}}'::text, 'masterextracts'::character varying, '48'::integer, '16'::integer, '1'::integer, '510'::integer, '7'::integer, '4'::integer)
 returning idashboardresultsetid,itenantid;

INSERT INTO ui.dashboardfilters (
idashboardfilterid, ifilterorder, vcdashboardfiltername, idashboardid, vcdashboardfiltertype, idashboardqueryidforoptions, itenantid, vcdashboardfilterdisplayname) VALUES (
 (select max(idashboardfilterid) + 1 from ui.dashboardfilters), '2'::integer, 'AttribsForm'::character varying, '16'::integer, 'FormFilter'::character varying, 74, '6'::integer, 'Attribs Form Filter'::character varying)
 returning idashboardfilterid,itenantid;
INSERT INTO ui.dashboardfilters (
idashboardfilterid, ifilterorder, vcdashboardfiltername, idashboardid, vcdashboardfiltertype, idashboardqueryidforoptions, itenantid, vcdashboardfilterdisplayname) VALUES (
 (select max(idashboardfilterid) + 1 from ui.dashboardfilters), '2'::integer, 'AttribsForm'::character varying, '16'::integer, 'FormFilter'::character varying, 74, '7'::integer, 'Attribs Form Filter'::character varying)
 returning idashboardfilterid,itenantid;
 INSERT INTO ui.dashboardfilters (
idashboardfilterid, ifilterorder, vcdashboardfiltername, idashboardid, vcdashboardfiltertype, idashboardqueryidforoptions, itenantid, vcdashboardfilterdisplayname) VALUES (
 (select max(idashboardfilterid) + 1 from ui.dashboardfilters), '2'::integer, 'AttribsForm'::character varying, '16'::integer, 'FormFilter'::character varying, 74, '20'::integer, 'Attribs Form Filter'::character varying)
 returning idashboardfilterid,itenantid;
 INSERT INTO ui.dashboardfilters (
idashboardfilterid, ifilterorder, vcdashboardfiltername, idashboardid, vcdashboardfiltertype, idashboardqueryidforoptions, itenantid, vcdashboardfilterdisplayname) VALUES (
 (select max(idashboardfilterid) + 1 from ui.dashboardfilters), '0'::integer, 'Party'::character varying, '16'::integer, 'Select'::character varying, '67'::integer, '6'::integer, 'Level'::character varying)
 returning idashboardfilterid,itenantid;
 INSERT INTO ui.dashboardfilters (
idashboardfilterid, ifilterorder, vcdashboardfiltername, idashboardid, vcdashboardfiltertype, idashboardqueryidforoptions, itenantid, vcdashboardfilterdisplayname) VALUES (
 (select max(idashboardfilterid) + 1 from ui.dashboardfilters), '0'::integer, 'Party'::character varying, '16'::integer, 'Select'::character varying, '67'::integer, '7'::integer, 'Level'::character varying)
 returning idashboardfilterid,itenantid;
 INSERT INTO ui.dashboardfilters (
idashboardfilterid, ifilterorder, vcdashboardfiltername, idashboardid, vcdashboardfiltertype, idashboardqueryidforoptions, itenantid, vcdashboardfilterdisplayname) VALUES (
 (select max(idashboardfilterid) + 1 from ui.dashboardfilters), '0'::integer, 'Party'::character varying, '16'::integer, 'Select'::character varying, '67'::integer, '20'::integer, 'Level'::character varying)
 returning idashboardfilterid,itenantid;

INSERT INTO ui.dashboardqueryparameters (
idashboardparameterid, vcparametername, vcparametertype, idashboardqueryid, iorder, itenantid) VALUES (
(select max(idashboardparameterid) + 1 from ui.dashboardqueryparameters), 'Party'::character varying, 'JsonPath'::character varying, '48'::integer, '0'::integer, '6'::integer)
 returning idashboardparameterid,itenantid;
 INSERT INTO ui.dashboardqueryparameters (
idashboardparameterid, vcparametername, vcparametertype, idashboardqueryid, iorder, itenantid) VALUES (
(select max(idashboardparameterid) + 1 from ui.dashboardqueryparameters), 'Party'::character varying, 'JsonPath'::character varying, '48'::integer, '0'::integer, '7'::integer)
 returning idashboardparameterid,itenantid;
 INSERT INTO ui.dashboardqueryparameters (
idashboardparameterid, vcparametername, vcparametertype, idashboardqueryid, iorder, itenantid) VALUES (
(select max(idashboardparameterid) + 1 from ui.dashboardqueryparameters), 'Party'::character varying, 'JsonPath'::character varying, '48'::integer, '0'::integer, '20'::integer)
 returning idashboardparameterid,itenantid;
 INSERT INTO ui.dashboardqueryparameters (
idashboardparameterid, vcparametername, vcparametertype, idashboardqueryid, iorder, itenantid) VALUES (
(select max(idashboardparameterid) + 1 from ui.dashboardqueryparameters), 'AttribsForm'::character varying, 'WhereStatement'::character varying, '48'::integer, null, '6'::integer)
 returning idashboardparameterid,itenantid;
 INSERT INTO ui.dashboardqueryparameters (
idashboardparameterid, vcparametername, vcparametertype, idashboardqueryid, iorder, itenantid) VALUES (
(select max(idashboardparameterid) + 1 from ui.dashboardqueryparameters), 'AttribsForm'::character varying, 'WhereStatement'::character varying, '48'::integer, null, '7'::integer)
 returning idashboardparameterid,itenantid;
 INSERT INTO ui.dashboardqueryparameters (
idashboardparameterid, vcparametername, vcparametertype, idashboardqueryid, iorder, itenantid) VALUES (
(select max(idashboardparameterid) + 1 from ui.dashboardqueryparameters), 'AttribsForm'::character varying, 'WhereStatement'::character varying, '48'::integer, null, '20'::integer)
 returning idashboardparameterid,itenantid;
