UPDATE ui.dashboardquery SET
vcdashboardquery = '   SELECT DATE_TRUNC(''month'', cast(tdate as timestamp)) as  "startdate", cast(tdate as timestamp) as "enddate"  FROM profiles.account_monthly
ORDER BY tdate  DESC LIMIT 1'::text WHERE
idashboardqueryid = 66;

UPDATE ui.dashboardquery SET
vcdashboardquery = '{
	"Account":"with recursive profile as ( SELECT * FROM masters.accounts limit 1000), flat ( iaccountid, key, value) as ( select iaccountid,'''', cast(format(''{\"iaccountid\":\"%s\",\"icustomerid\":\"%s\",\"vcexternalaccountid\":\"%s\",\"iaccounttypeid\":\"%s\" ,\"vcaccount\":\"%s\" ,\"vcifsc\":\"%s\",\"vcaccountproviderid\":\"%s\",\"vcaccountname\":\"%s\",\"dtonboardingdate\":\"%s\",\"dtexpirydate\":\"%s\" ,\"bmerchant\":\"%s\",\"irecordstatus\":\"%s\",\"dtentrydatetime\":\"%s\",\"imcc\":\"%s\",\"bverified\":\"%s\"}'',cast(iaccountid as text),cast(icustomerid as text),vcexternalaccountid, cast(iaccounttypeid as text),vcaccount, vcifsc, vcaccountproviderid, vcaccountname, dtonboardingdate, dtexpirydate, cast(bmerchant as text), irecordstatus,dtentrydatetime, cast(imcc as text), cast(bverified as text)) as jsonb) as value from profile \n union select  iaccountid,concat( ''attrib.'', key), value from profile, jsonb_each(vcattribs) \n union select  iaccountid,concat(f.key, '''', j.key), j.value from flat f, jsonb_each(f.value) j where jsonb_typeof(f.value) = ''object'' ) \n select cast(json_agg(data) as text) from ( select iaccountid,jsonb_object_agg(key, value  ) as data from flat where jsonb_typeof(value)<>''object'' group by iaccountid)a;",
	"VPA": "with recursive profile as ( SELECT * FROM masters.vpa limit 1000), flat ( ivpaid, key, value) as ( select ivpaid,'''', cast(format(''{\"ivpaid\":\"%s\",\"iaccountid\":\"%s\",\"vcexternaladdressid\":\"%s\",\"vcaddress\":\"%s\" ,\"iproductid\":\"%s\" ,\"vcvpaname\":\"%s\",\"bverified\":\"%s\",\"imcc\":\"%s\",\"dtonboardingdate\":\"%s\",\"dtexpirydate\":\"%s\" ,\"bmerchant\":\"%s\",\"irecordstatus\":\"%s\",\"dtentrydatetime\":\"%s\",\"ivpaproviderid\":\"%s\",\"bprofiled\":\"%s\",\"dtfirsttransaction\":\"%s\" ,\"dtlasttransaction\":\"%s\"}'', cast(ivpaid as text),cast(iaccountid as text), vcexternaladdressid,vcaddress, cast(iproductid as text), vcvpaname,cast(bverified as text), cast(imcc as text),dtonboardingdate, dtexpirydate,  cast(bmerchant as text), irecordstatus, dtentrydatetime,ivpaproviderid, cast(bprofiled as text) ,  dtfirsttransaction,dtlasttransaction) as jsonb) as value from profile \n union select  ivpaid,concat( ''attrib.'', key), value from profile, jsonb_each(vcattribs) \n union select  ivpaid,concat(f.key, '''', j.key), j.value from flat f, jsonb_each(f.value) j where jsonb_typeof(f.value) = ''object'' ) \n select cast(json_agg(data) as text) from ( select ivpaid,jsonb_object_agg(key, value  ) as data from flat where jsonb_typeof(value)<>''object'' group by ivpaid) a;",
	"Customer": "with recursive profile as ( SELECT *, icustomerid as \"custid\" FROM masters.customers order by dtentrydatetime limit 1000), flat ( icustomerid, key, value) as ( select icustomerid,'''',cast(format(''{\"icustomerid\":\"%s\",\"vcexternalcustid\":\"%s\",\"vccustomertype\":\"%s\" , \"vccustomername\":\"%s\" ,\"dtonboardingdate\":\"%s\",\"irecordstatus\":\"%s\", \"dtentrydatetime\":\"%s\",\"imcc\":\"%s\", \"vcsalutation\":\"%s\", \"vcverifiedname\":\"%s\", \"vcgender\":\"%s\", \"dtdoidob\":\"%s\", \"dtonboardingdate\":\"%s\", \"vcpostalcode\":\"%s\", \"vcemail\":\"%s\", \"vcregisteredmobile\":\"%s\", \"imcc\":\"%s\", \"vcidentitytype1\":\"%s\", \"vcidentitydetails1\":\"%s\", \"vcidentitytype2\":\"%s\", \"vcidentitydetails2\":\"%s\", \"vcregisteredaddressgeolocation\":\"%s\", \"iadm3\":\"%s\", \"iadm2\":\"%s\", \"iadm1\":\"%s\", \"vccountrycode\":\"%s\", \"irecordstatus\":\"%s\", \"dtentrydatetime\":\"%s\"}'',cast(icustomerid as text),vcexternalcustid, cast(vccustomertype as text),vccustomername, dtonboardingdate, irecordstatus,dtentrydatetime, cast(imcc as text),  vcsalutation, vcverifiedname , vcgender, cast(dtdoidob as text), cast(dtonboardingdate as text), vcpostalcode, vcemail, vcregisteredmobile, cast(imcc as text), vcidentitytype1, vcidentitydetails1, vcidentitytype2, vcidentitydetails2, vcregisteredaddressgeolocation, iadm3, iadm2, iadm1, vccountrycode, irecordstatus, dtentrydatetime) as jsonb) as value from profile \n union select  icustomerid,concat( ''attrib.'', key), value from profile, jsonb_each(vcattribs) \n union select  icustomerid,concat(f.key, '''', j.key), j.value from flat f, jsonb_each(f.value) j where jsonb_typeof(f.value) = ''object'' ) \n select cast(json_agg(data) as text) from ( select icustomerid,jsonb_object_agg(key, value  ) as data from flat where jsonb_typeof(value)<>''object'' group by icustomerid)a;"
}'::text WHERE
idashboardqueryid = 48;

INSERT INTO ui.dashboardquery (
idashboardqueryid, bparametersrequired, vcdashboardquery) VALUES (
'67'::integer, false::boolean, 'SELECT X.* FROM   (VALUES (''Account'', ''Account''),(''VPA'', ''VPA''),(''Customer'', ''Customer'')) AS X ("label", "value");'::text)
 returning idashboardqueryid;

 CREATE TABLE ui.taskfiltermaster (
     itaskfilterid integer NOT NULL,
     render boolean,
     brequired boolean,
     vcerrorname character varying(255),
     vcfiltername character varying(255),
     vckeyname character varying(255)
 );



INSERT INTO ui.taskfiltermaster (itaskfilterid, render, brequired, vcerrorname, vcfiltername, vckeyname) VALUES (1, true, true, 'Workflow', 'CaseType', 'selectWorkflowName');
INSERT INTO ui.taskfiltermaster (itaskfilterid, render, brequired, vcerrorname, vcfiltername, vckeyname) VALUES (2, true, true, 'Start Date, End Date', 'DateRange', 'startDate,endDate');
INSERT INTO ui.taskfiltermaster (itaskfilterid, render, brequired, vcerrorname, vcfiltername, vckeyname) VALUES (3, true, true, 'Status', 'Status', 'statusSelect');
INSERT INTO ui.taskfiltermaster (itaskfilterid, render, brequired, vcerrorname, vcfiltername, vckeyname) VALUES (4, true, true, 'Min amount,Max Amount', 'TransactionAmount', 'minAmount,maxAmount');
INSERT INTO ui.taskfiltermaster (itaskfilterid, render, brequired, vcerrorname, vcfiltername, vckeyname) VALUES (5, true, true, 'Level,Type', 'LevelType', 'levelSelectMain,typeSelectMain');
INSERT INTO ui.taskfiltermaster (itaskfilterid, render, brequired, vcerrorname, vcfiltername, vckeyname) VALUES (6, true, true, 'Address', 'Address', 'address');
INSERT INTO ui.taskfiltermaster (itaskfilterid, render, brequired, vcerrorname, vcfiltername, vckeyname) VALUES (7, true, true, 'No of cases', 'NoOfCases', 'dropDownMaximunResult');
INSERT INTO ui.taskfiltermaster (itaskfilterid, render, brequired, vcerrorname, vcfiltername, vckeyname) VALUES (8, true, true, 'Risk Score', 'RiskScore', 'riskScore');
INSERT INTO ui.taskfiltermaster (itaskfilterid, render, brequired, vcerrorname, vcfiltername, vckeyname) VALUES (9, true, true, 'Rule', 'Rule', 'ruleSelect');
INSERT INTO ui.taskfiltermaster (itaskfilterid, render, brequired, vcerrorname, vcfiltername, vckeyname) VALUES (10, true, true, 'Aml Status', 'AmlStatus', 'amlStatusSelect');

ALTER TABLE ONLY ui.taskfiltermaster
    ADD CONSTRAINT taskfiltermaster_pkey PRIMARY KEY (itaskfilterid);



CREATE TABLE ui.grouptotaskfiltermap (
    igrouptotaskfilterid integer NOT NULL,
    iposition integer,
    igroupid integer,
    itasfilterid integer
);

ALTER TABLE ONLY ui.grouptotaskfiltermap
    ADD CONSTRAINT grouptotaskfiltermap_pkey PRIMARY KEY (igrouptotaskfilterid);

ALTER TABLE ONLY ui.grouptotaskfiltermap
    ADD CONSTRAINT fk9ake59q4vntf4hnxxrwim4obd FOREIGN KEY (igroupid) REFERENCES ui.groupdesc(igroupid);

ALTER TABLE ONLY ui.grouptotaskfiltermap
    ADD CONSTRAINT fkhckg0xt4w8o509k6sb9gbjt8d FOREIGN KEY (itasfilterid) REFERENCES ui.taskfiltermaster(itaskfilterid);
