
INSERT INTO ui.workflowmasters (workflowid, workflowname) VALUES (5, 'QC');

INSERT INTO ui.panelaccessmap (panelaccessmap, panelid, groupid, workflowid) VALUES (41, 1, 1023, 5);
INSERT INTO ui.panelaccessmap (panelaccessmap, panelid, groupid, workflowid) VALUES (42, 2, 1023, 5);
INSERT INTO ui.panelaccessmap (panelaccessmap, panelid, groupid, workflowid) VALUES (43, 3, 1023, 5);
INSERT INTO ui.panelaccessmap (panelaccessmap, panelid, groupid, workflowid) VALUES (44, 4, 1023, 5);
INSERT INTO ui.panelaccessmap (panelaccessmap, panelid, groupid, workflowid) VALUES (45, 5, 1023, 5);
INSERT INTO ui.panelaccessmap (panelaccessmap, panelid, groupid, workflowid) VALUES (46, 1, 1024, 5);
INSERT INTO ui.panelaccessmap (panelaccessmap, panelid, groupid, workflowid) VALUES (47, 2, 1024, 5);
INSERT INTO ui.panelaccessmap (panelaccessmap, panelid, groupid, workflowid) VALUES (48, 3, 1024, 5);
INSERT INTO ui.panelaccessmap (panelaccessmap, panelid, groupid, workflowid) VALUES (49, 4, 1024, 5);
INSERT INTO ui.panelaccessmap (panelaccessmap, panelid, groupid, workflowid) VALUES (50, 5, 1025, 5);
INSERT INTO ui.panelaccessmap (panelaccessmap, panelid, groupid, workflowid) VALUES (51, 1, 1025, 5);
INSERT INTO ui.panelaccessmap (panelaccessmap, panelid, groupid, workflowid) VALUES (52, 2, 1025, 5);
INSERT INTO ui.panelaccessmap (panelaccessmap, panelid, groupid, workflowid) VALUES (53, 3, 1025, 5);
INSERT INTO ui.panelaccessmap (panelaccessmap, panelid, groupid, workflowid) VALUES (54, 4, 1025, 5);
INSERT INTO ui.panelaccessmap (panelaccessmap, panelid, groupid, workflowid) VALUES (55, 5, 1025, 5);
INSERT INTO ui.panelaccessmap (panelaccessmap, panelid, groupid, workflowid) VALUES (56, 1, 1026, 5);
INSERT INTO ui.panelaccessmap (panelaccessmap, panelid, groupid, workflowid) VALUES (57, 2, 1026, 5);
INSERT INTO ui.panelaccessmap (panelaccessmap, panelid, groupid, workflowid) VALUES (58, 3, 1026, 5);
INSERT INTO ui.panelaccessmap (panelaccessmap, panelid, groupid, workflowid) VALUES (59, 4, 1026, 5);
INSERT INTO ui.panelaccessmap (panelaccessmap, panelid, groupid, workflowid) VALUES (60, 5, 1026, 5);
INSERT INTO ui.panelaccessmap (panelaccessmap, panelid, groupid, workflowid) VALUES (61, 1, 1022, 5);
INSERT INTO ui.panelaccessmap (panelaccessmap, panelid, groupid, workflowid) VALUES (62, 2, 1022, 5);
INSERT INTO ui.panelaccessmap (panelaccessmap, panelid, groupid, workflowid) VALUES (63, 3, 1022, 5);
INSERT INTO ui.panelaccessmap (panelaccessmap, panelid, groupid, workflowid) VALUES (64, 4, 1022, 5);
INSERT INTO ui.panelaccessmap (panelaccessmap, panelid, groupid, workflowid) VALUES (65, 5, 1022, 5);
INSERT INTO ui.panelaccessmap (panelaccessmap, panelid, groupid, workflowid) VALUES (66, 3, 1026, 4);
INSERT INTO ui.panelaccessmap (panelaccessmap, panelid, groupid, workflowid) VALUES (67, 4, 1026, 4);
INSERT INTO ui.panelaccessmap (panelaccessmap, panelid, groupid, workflowid) VALUES (68, 5, 1026, 4);
INSERT INTO ui.panelaccessmap (panelaccessmap, panelid, groupid, workflowid) VALUES (69, 1, 1028, 4);
INSERT INTO ui.panelaccessmap (panelaccessmap, panelid, groupid, workflowid) VALUES (70, 2, 1028, 4);



  UPDATE ui.dashboardquery
  	SET   vcdashboardquery =  '{
      "Account":"with recursive profile as ( SELECT * FROM masters.accounts  order by iaccountid desc limit 1000), flat ( iaccountid, key, value) as ( select iaccountid,'''', cast(format(''{\"iaccountid\":\"%s\",\"icustomerid\":\"%s\",\"vcexternalaccountid\":\"%s\",\"iaccounttypeid\":\"%s\" ,\"vcaccount\":\"%s\" ,\"vcifsc\":\"%s\",\"vcaccountproviderid\":\"%s\",\"vcaccountname\":\"%s\",\"dtonboardingdate\":\"%s\",\"dtexpirydate\":\"%s\" ,\"imcc\":\"%s\",\"bverified\":\"%s\"}'',cast(iaccountid as text),cast(icustomerid as text),vcexternalaccountid, cast(iaccounttypeid as text),vcaccount, vcifsc, vcaccountproviderid, vcaccountname, dtonboardingdate, dtexpirydate, cast(imcc as text), cast(bverified as text)) as jsonb) as value from profile \n union select  iaccountid,concat( ''attrib.'', key), value from profile, jsonb_each(vcattribs) \n union select  iaccountid,concat(f.key, '''', j.key), j.value from flat f, jsonb_each(f.value) j where jsonb_typeof(f.value) = ''object'' ) \n select cast(json_agg(data) as text) from ( select iaccountid,jsonb_object_agg(key, value  ) as data from flat where jsonb_typeof(value)<>''object'' group by iaccountid) a;",
      "VPA": "with recursive profile as ( SELECT * FROM masters.vpa order by ivpaid desc limit 1000 ), flat ( ivpaid, key, value) as ( select ivpaid,'''', cast(format(''{\"ivpaid\":\"%s\",\"iaccountid\":\"%s\",\"vcexternaladdressid\":\"%s\",\"vcaddress\":\"%s\" ,\"iproductid\":\"%s\" ,\"vcvpaname\":\"%s\",\"bverified\":\"%s\",\"imcc\":\"%s\",\"dtonboardingdate\":\"%s\",\"dtexpirydate\":\"%s\" ,\"bmerchant\":\"%s\",\"ivpaproviderid\":\"%s\",\"bprofiled\":\"%s\",\"dtfirsttransaction\":\"%s\" ,\"dtlasttransaction\":\"%s\"}'', cast(ivpaid as text),cast(iaccountid as text), vcexternaladdressid,vcaddress, cast(iproductid as text), vcvpaname,bverified, cast(imcc as text),dtonboardingdate, dtexpirydate,  bmerchant, ivpaproviderid, bprofiled,  dtfirsttransaction,dtlasttransaction) as jsonb) as value from profile \n union select  ivpaid,concat( ''attrib.'', key), value from profile, jsonb_each(vcattribs) \n union select  ivpaid,concat(f.key, '''', j.key), j.value from flat f, jsonb_each(f.value) j where jsonb_typeof(f.value) = ''object'' ) \n select cast(json_agg(data) as text) from ( select ivpaid,jsonb_object_agg(key, value  ) as data from flat where jsonb_typeof(value)<>''object'' group by ivpaid) a;"
  }' where idashboardqueryid=48;

UPDATE masters.accounts SET   vcattribs='{}' WHERE vcattribs='null';
UPDATE masters.vpa SET   vcattribs='{}' WHERE vcattribs='null';