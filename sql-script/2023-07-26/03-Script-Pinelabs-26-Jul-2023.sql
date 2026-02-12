UPDATE ui.dashboardquery SET vcdashboardquery='{
	"Account":"select iaccountid, icustomerid, vcexternalaccountid, iaccounttypeid, vcifsc, vcaccountproviderid, vcaccountname, dtonboardingdate, dtexpirydate, imcc, bmerchant, bverified, irecordstatus, dtentrydatetime from masters.accounts order by dtentrydatetime desc limit 50000",
	"VPA": "select ivpaid, iaccountid, vcexternaladdressid, vcaddress, iproductid, vcvpaname, bverified, imcc, dtonboardingdate, dtexpirydate, bmerchant, ivpaproviderid, bprofiled, dtfirsttransaction, dtlasttransaction, irecordstatus, dtentrydatetime from masters.vpa order by dtentrydatetime desc limit 50000",
	"Customer": "SELECT icustomerid, vcexternalcustid, vccustomername, vccustomertype, vcsalutation, vcverifiedname, vcgender, dtdoidob, dtonboardingdate, vcpostalcode, vcemail, vcregisteredmobile, imcc, vcidentitytype1, vcidentitydetails1, vcidentitytype2, vcidentitydetails2, vcregisteredaddressgeolocation, iadm3, iadm2, iadm1, vccountrycode, irecordstatus, dtentrydatetime FROM masters.customers :AttribsForm order by dtentrydatetime desc limit 50000;"
}'::TEXT, formattingrequiered=false WHERE idashboardqueryid=48;

DELETE FROM ui.masterextractattribs;