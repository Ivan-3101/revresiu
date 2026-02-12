

INSERT INTO ui.webuser (dtapproverstamp, dtentrystamp, dtlastlogindate, vcaddress, vccontact, vcdesignation, vcemailid, vcfirstname, vclastname, vcmobile, vcpassword, vcprofileimg, vcusername, iapproveruserid, ientryuserid, istatus, timezones, resetpasswordtoken, dtlastpasswordupdate, loginattempts, iorgid) VALUES ('2023-06-10 13:47:12.625', '2023-03-22 11:17:35.851', '2023-10-30 15:19:06.481', NULL, '9988', 'CEO', 'cadmin@yesbank.com', 'cadmin', 'cadmin', '7219024345', '$2a$10$EoTv5mhWPRxMbRTBYJ0V4ucuG761Lb7Cp8T/pJZOc8/szTepMVNm.', '', 'cadmin@yesbank.com', 2, 1, 1, 'Asia/Kolkata', '6HTThBznzAaZtr52O9YcsSEQ6ZaslB', '2023-10-09 19:46:14.746', 0, 3);
INSERT INTO ui.webuser (dtapproverstamp, dtentrystamp, dtlastlogindate, vcaddress, vccontact, vcdesignation, vcemailid, vcfirstname, vclastname, vcmobile, vcpassword, vcprofileimg, vcusername, iapproveruserid, ientryuserid, istatus, timezones, resetpasswordtoken, dtlastpasswordupdate, loginattempts, iorgid) VALUES ('2023-06-10 13:47:12.625', '2023-03-22 11:17:35.851', '2023-10-30 15:19:06.481', NULL, '9988', 'CEO', 'madmin@yesbank.com', 'madmin', 'madmin', '7219024345', '$2a$10$EoTv5mhWPRxMbRTBYJ0V4ucuG761Lb7Cp8T/pJZOc8/szTepMVNm.', '', 'madmin@yesbank.com', 2, 1, 1, 'Asia/Kolkata', '6HTThBznzAaZtr52O9YcsSEQ6ZaslB', '2023-10-09 19:46:14.746', 0, 3);
INSERT INTO ui.webuser (dtapproverstamp, dtentrystamp, dtlastlogindate, vcaddress, vccontact, vcdesignation, vcemailid, vcfirstname, vclastname, vcmobile, vcpassword, vcprofileimg, vcusername, iapproveruserid, ientryuserid, istatus, timezones, resetpasswordtoken, dtlastpasswordupdate, loginattempts, iorgid) VALUES ('2023-06-10 13:47:12.625', '2023-03-22 11:17:35.851', '2023-10-30 15:19:06.481', NULL, '9988', 'CEO', 'cadmin@42c.com', 'cadmin', 'cadmin', '7219024345', '$2a$10$EoTv5mhWPRxMbRTBYJ0V4ucuG761Lb7Cp8T/pJZOc8/szTepMVNm.', '', 'cadmin@42c.com', 2, 1, 1, 'Asia/Kolkata', '6HTThBznzAaZtr52O9YcsSEQ6ZaslB', '2023-10-09 19:46:14.746', 0, 4);
INSERT INTO ui.webuser (dtapproverstamp, dtentrystamp, dtlastlogindate, vcaddress, vccontact, vcdesignation, vcemailid, vcfirstname, vclastname, vcmobile, vcpassword, vcprofileimg, vcusername, iapproveruserid, ientryuserid, istatus, timezones, resetpasswordtoken, dtlastpasswordupdate, loginattempts, iorgid) VALUES ('2023-06-10 13:47:12.625', '2023-03-22 11:17:35.851', '2023-10-30 15:19:06.481', NULL, '9988', 'CEO', 'madmin@42c.com', 'madmin', 'madmin', '7219024345', '$2a$10$EoTv5mhWPRxMbRTBYJ0V4ucuG761Lb7Cp8T/pJZOc8/szTepMVNm.', '', 'madmin@42c.com', 2, 1, 1, 'Asia/Kolkata', '6HTThBznzAaZtr52O9YcsSEQ6ZaslB', '2023-10-09 19:46:14.746', 0, 4);

INSERT INTO ui.roledesc (
iroleid, vcrolename, istatus, itenantid) VALUES (
'14'::integer, 'God-FRM'::character varying, '1'::integer, '3'::integer)
 returning iroleid;
 INSERT INTO ui.roledesc (
iroleid, vcrolename, istatus, itenantid) VALUES (
'15'::integer, 'God-AML'::character varying, '1'::integer, '4'::integer)
 returning iroleid;
  INSERT INTO ui.roledesc (
iroleid, vcrolename, istatus, itenantid) VALUES (
'16'::integer, 'Risk Analyst-FRM'::character varying, '1'::integer, '3'::integer)
 returning iroleid;
INSERT INTO ui.roledesc (
iroleid, vcrolename, istatus, itenantid) VALUES (
'17'::integer, 'Risk Analyst-AML'::character varying, '1'::integer, '4'::integer)
 returning iroleid;
INSERT INTO ui.roledesc (
iroleid, vcrolename, istatus, itenantid) VALUES (
'18'::integer, 'God-FRM'::character varying, '1'::integer, '5'::integer)
 returning iroleid;
INSERT INTO ui.roledesc (
iroleid, vcrolename, istatus, itenantid) VALUES (
'19'::integer, 'Risk Analyst-FRM'::character varying, '1'::integer, '5'::integer)
 returning iroleid;

INSERT INTO ui.groupdesc (
igroupid, vcgroupid, vcgroupname, vcgrouptype, istatus, itenantid) VALUES (
'2000'::integer, 'riskanalyst'::character varying, 'Risk Analyst FRM'::character varying, 'WORKFLOW'::character varying, '1'::integer, '3'::integer)
 returning igroupid;
INSERT INTO ui.groupdesc (
igroupid, vcgroupid, vcgroupname, vcgrouptype, istatus, itenantid) VALUES (
'2001'::integer, 'risksupervisor'::character varying, 'Risk Supervisor FRM'::character varying, 'WORKFLOW'::character varying, '1'::integer, '3'::integer)
 returning igroupid;
INSERT INTO ui.groupdesc (
igroupid, vcgroupid, vcgroupname, vcgrouptype, istatus, itenantid) VALUES (
'2002'::integer, 'level1'::character varying, 'L1 AML'::character varying, 'WORKFLOW'::character varying, '1'::integer, '4'::integer)
 returning igroupid;
INSERT INTO ui.groupdesc (
igroupid, vcgroupid, vcgroupname, vcgrouptype, istatus, itenantid) VALUES (
'2003'::integer, 'level2'::character varying, 'L2 AML'::character varying, 'WORKFLOW'::character varying, '1'::integer, '4'::integer)
 returning igroupid;
 INSERT INTO ui.groupdesc (
igroupid, vcgroupid, vcgroupname, vcgrouptype, istatus, itenantid) VALUES (
'2004'::integer, 'riskanalyst'::character varying, 'Risk Analyst FRM'::character varying, 'WORKFLOW'::character varying, '1'::integer, '5'::integer)
 returning igroupid;

insert into ui.webusermapping (mappingid, mappingtype, webuserid) VALUES (14,
'Role', (select iuserid from ui.webuser where vcusername='cadmin@yesbank.com'));

insert into ui.webusermapping (mappingid, mappingtype, webuserid) VALUES (14,
'Role', (select iuserid from ui.webuser where vcusername='madmin@yesbank.com'));

insert into ui.webusermapping (mappingid, mappingtype, webuserid) VALUES (-1,
'TransactionClass', (select iuserid from ui.webuser where vcusername='madmin@yesbank.com'));

insert into ui.webusermapping (mappingid, mappingtype, webuserid) VALUES (-1,
'TransactionClass', (select iuserid from ui.webuser where vcusername='cadmin@yesbank.com'));

insert into ui.webusermapping (mappingid, mappingtype, webuserid) VALUES (-1,
'Workflow', (select iuserid from ui.webuser where vcusername='madmin@yesbank.com'));

insert into ui.webusermapping (mappingid, mappingtype, webuserid) VALUES (-1,
'Workflow', (select iuserid from ui.webuser where vcusername='cadmin@yesbank.com'));

insert into ui.webusermapping (mappingid, mappingtype, webuserid) VALUES (3,
'Tenant', (select iuserid from ui.webuser where vcusername='cadmin@yesbank.com'));
insert into ui.webusermapping (mappingid, mappingtype, webuserid) VALUES (4,
'Tenant', (select iuserid from ui.webuser where vcusername='cadmin@yesbank.com'));

insert into ui.webusermapping (mappingid, mappingtype, webuserid) VALUES (3,
'Tenant', (select iuserid from ui.webuser where vcusername='madmin@yesbank.com'));
insert into ui.webusermapping (mappingid, mappingtype, webuserid) VALUES (4,
'Tenant', (select iuserid from ui.webuser where vcusername='madmin@yesbank.com'));

insert into ui.webusermapping (mappingid, mappingtype, webuserid) VALUES (18,
'Role', (select iuserid from ui.webuser where vcusername='cadmin@42c.com'));

insert into ui.webusermapping (mappingid, mappingtype, webuserid) VALUES (18,
'Role', (select iuserid from ui.webuser where vcusername='madmin@42c.com'));

insert into ui.webusermapping (mappingid, mappingtype, webuserid) VALUES (-1,
'TransactionClass', (select iuserid from ui.webuser where vcusername='madmin@42c.com'));

insert into ui.webusermapping (mappingid, mappingtype, webuserid) VALUES (-1,
'TransactionClass', (select iuserid from ui.webuser where vcusername='cadmin@42c.com'));

insert into ui.webusermapping (mappingid, mappingtype, webuserid) VALUES (-1,
'Workflow', (select iuserid from ui.webuser where vcusername='madmin@42c.com'));

insert into ui.webusermapping (mappingid, mappingtype, webuserid) VALUES (-1,
'Workflow', (select iuserid from ui.webuser where vcusername='cadmin@42c.com'));

insert into ui.webusermapping (mappingid, mappingtype, webuserid) VALUES (5,
'Tenant', (select iuserid from ui.webuser where vcusername='cadmin@42c.com'));
insert into ui.webusermapping (mappingid, mappingtype, webuserid) VALUES (5,
'Tenant', (select iuserid from ui.webuser where vcusername='madmin@42c.com'));

---god role 14 configuration starts
INSERT INTO ui.rolemenuaccessmap (
badd, bapprove, bdelete, bedit, bpublish, bview, istatus, imenuid, iroleid) VALUES (
true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, '482'::integer, '14'::integer)
 returning irolemenumapid;

INSERT INTO ui.rolemenuaccessmap (
badd, bapprove, bdelete, bedit, bpublish, bview, istatus, imenuid, iroleid) VALUES (
true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, '501'::integer, '14'::integer)
 returning irolemenumapid;
INSERT INTO ui.rolemenuaccessmap (
badd, bapprove, bdelete, bedit, bpublish, bview, istatus, imenuid, iroleid) VALUES (
true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, '513'::integer, '14'::integer)
 returning irolemenumapid;

INSERT INTO ui.rolemenuaccessmap (
badd, bapprove, bdelete, bedit, bpublish, bview, istatus, imenuid, iroleid) VALUES (
true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, '514'::integer, '14'::integer)
 returning irolemenumapid;

INSERT INTO ui.rolemenuaccessmap (
badd, bapprove, bdelete, bedit, bpublish, bview, istatus, imenuid, iroleid) VALUES (
true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, '518'::integer, '14'::integer)
 returning irolemenumapid;

INSERT INTO ui.rolemenuaccessmap (
badd, bapprove, bdelete, bedit, bpublish, bview, istatus, imenuid, iroleid) VALUES (
true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, '519'::integer, '14'::integer)
 returning irolemenumapid;

INSERT INTO ui.rolemenuaccessmap (
badd, bapprove, bdelete, bedit, bpublish, bview, istatus, imenuid, iroleid) VALUES (
true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, '520'::integer, '14'::integer)
 returning irolemenumapid;

 INSERT INTO ui.rolemenuaccessmap (
badd, bapprove, bdelete, bedit, bpublish, bview, istatus, imenuid, iroleid) VALUES (
true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, '481'::integer, '14'::integer)
 returning irolemenumapid;

INSERT INTO ui.rolemenuaccessmap (
badd, bapprove, bdelete, bedit, bpublish, bview, istatus, imenuid, iroleid) VALUES (
true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, '521'::integer, '14'::integer)
 returning irolemenumapid;

INSERT INTO ui.rolemenuaccessmap (
badd, bapprove, bdelete, bedit, bpublish, bview, istatus, imenuid, iroleid) VALUES (
true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, '522'::integer, '14'::integer)
 returning irolemenumapid;

INSERT INTO ui.rolemenuaccessmap (
badd, bapprove, bdelete, bedit, bpublish, bview, istatus, imenuid, iroleid) VALUES (
true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, '528'::integer, '14'::integer)
 returning irolemenumapid;

INSERT INTO ui.rolemenuaccessmap (
badd, bapprove, bdelete, bedit, bpublish, bview, istatus, imenuid, iroleid) VALUES (
true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, '529'::integer, '14'::integer)
 returning irolemenumapid;


INSERT INTO ui.rolemenuaccessmap (
badd, bapprove, bdelete, bedit, bpublish, bview, istatus, imenuid, iroleid) VALUES (
true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, '530'::integer, '14'::integer)
 returning irolemenumapid;

INSERT INTO ui.rolemenuaccessmap (
badd, bapprove, bdelete, bedit, bpublish, bview, istatus, imenuid, iroleid) VALUES (
true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, '499'::integer, '14'::integer)
 returning irolemenumapid;

INSERT INTO ui.rolemenuaccessmap (
badd, bapprove, bdelete, bedit, bpublish, bview, istatus, imenuid, iroleid) VALUES (
true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, '511'::integer, '14'::integer)
 returning irolemenumapid;

INSERT INTO ui.rolemenuaccessmap (
badd, bapprove, bdelete, bedit, bpublish, bview, istatus, imenuid, iroleid) VALUES (
true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, '515'::integer, '14'::integer)
 returning irolemenumapid;
INSERT INTO ui.rolemenuaccessmap (
badd, bapprove, bdelete, bedit, bpublish, bview, istatus, imenuid, iroleid) VALUES (
true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, '524'::integer, '14'::integer)
 returning irolemenumapid;

INSERT INTO ui.rolemenuaccessmap (
badd, bapprove, bdelete, bedit, bpublish, bview, istatus, imenuid, iroleid) VALUES (
true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, '525'::integer, '14'::integer)
 returning irolemenumapid;

INSERT INTO ui.rolemenuaccessmap (
badd, bapprove, bdelete, bedit, bpublish, bview, istatus, imenuid, iroleid) VALUES (
true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, '526'::integer, '14'::integer)
 returning irolemenumapid;
INSERT INTO ui.rolemenuaccessmap (
badd, bapprove, bdelete, bedit, bpublish, bview, istatus, imenuid, iroleid) VALUES (
true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, '527'::integer, '14'::integer)
 returning irolemenumapid;
INSERT INTO ui.rolemenuaccessmap (
badd, bapprove, bdelete, bedit, bpublish, bview, istatus, imenuid, iroleid) VALUES (
true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, '563'::integer, '14'::integer)
 returning irolemenumapid;
INSERT INTO ui.rolemenuaccessmap (
badd, bapprove, bdelete, bedit, bpublish, bview, istatus, imenuid, iroleid) VALUES (
true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, '564'::integer, '14'::integer)
 returning irolemenumapid;
INSERT INTO ui.rolemenuaccessmap (
badd, bapprove, bdelete, bedit, bpublish, bview, istatus, imenuid, iroleid) VALUES (
true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, '565'::integer, '14'::integer)
 returning irolemenumapid;
INSERT INTO ui.rolemenuaccessmap (
badd, bapprove, bdelete, bedit, bpublish, bview, istatus, imenuid, iroleid) VALUES (
true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, '566'::integer, '14'::integer)
 returning irolemenumapid;
INSERT INTO ui.rolemenuaccessmap (
badd, bapprove, bdelete, bedit, bpublish, bview, istatus, imenuid, iroleid) VALUES (
true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, '567'::integer, '14'::integer)
 returning irolemenumapid;
INSERT INTO ui.rolemenuaccessmap (
badd, bapprove, bdelete, bedit, bpublish, bview, istatus, imenuid, iroleid) VALUES (
true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, '568'::integer, '14'::integer)
 returning irolemenumapid;
INSERT INTO ui.rolemenuaccessmap (
badd, bapprove, bdelete, bedit, bpublish, bview, istatus, imenuid, iroleid) VALUES (
true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, '569'::integer, '14'::integer)
 returning irolemenumapid;
INSERT INTO ui.rolemenuaccessmap (
badd, bapprove, bdelete, bedit, bpublish, bview, istatus, imenuid, iroleid) VALUES (
true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, '570'::integer, '14'::integer)
 returning irolemenumapid;
INSERT INTO ui.rolemenuaccessmap (
badd, bapprove, bdelete, bedit, bpublish, bview, istatus, imenuid, iroleid) VALUES (
true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, '571'::integer, '14'::integer)
 returning irolemenumapid;

INSERT INTO ui.rolemenuaccessmap (
badd, bapprove, bdelete, bedit, bpublish, bview, istatus, imenuid, iroleid) VALUES (
true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, '547'::integer, '14'::integer)
 returning irolemenumapid;
INSERT INTO ui.rolemenuaccessmap (
badd, bapprove, bdelete, bedit, bpublish, bview, istatus, imenuid, iroleid) VALUES (
true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, '548'::integer, '14'::integer)
 returning irolemenumapid;
INSERT INTO ui.rolemenuaccessmap (
badd, bapprove, bdelete, bedit, bpublish, bview, istatus, imenuid, iroleid) VALUES (
true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, '549'::integer, '14'::integer)
 returning irolemenumapid;
INSERT INTO ui.rolemenuaccessmap (
badd, bapprove, bdelete, bedit, bpublish, bview, istatus, imenuid, iroleid) VALUES (
true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, '550'::integer, '14'::integer)
 returning irolemenumapid; 
INSERT INTO ui.rolemenuaccessmap (
badd, bapprove, bdelete, bedit, bpublish, bview, istatus, imenuid, iroleid) VALUES (
true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, '551'::integer, '14'::integer)
 returning irolemenumapid;

INSERT INTO ui.rolemenuaccessmap (
badd, bapprove, bdelete, bedit, bpublish, bview, istatus, imenuid, iroleid) VALUES (
true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, '552'::integer, '14'::integer)
 returning irolemenumapid;

INSERT INTO ui.rolemenuaccessmap (
badd, bapprove, bdelete, bedit, bpublish, bview, istatus, imenuid, iroleid) VALUES (
true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, '553'::integer, '14'::integer)
 returning irolemenumapid;

INSERT INTO ui.rolemenuaccessmap (
badd, bapprove, bdelete, bedit, bpublish, bview, istatus, imenuid, iroleid) VALUES (
true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, '554'::integer, '14'::integer)
 returning irolemenumapid;

 INSERT INTO ui.rolemenuaccessmap (
badd, bapprove, bdelete, bedit, bpublish, bview, istatus, imenuid, iroleid) VALUES (
true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, '555'::integer, '14'::integer)
 returning irolemenumapid;

 INSERT INTO ui.rolemenuaccessmap (
badd, bapprove, bdelete, bedit, bpublish, bview, istatus, imenuid, iroleid) VALUES (
true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, '556'::integer, '14'::integer)
 returning irolemenumapid;


 INSERT INTO ui.rolemenuaccessmap (
badd, bapprove, bdelete, bedit, bpublish, bview, istatus, imenuid, iroleid) VALUES (
true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, '557'::integer, '14'::integer)
 returning irolemenumapid;

INSERT INTO ui.rolemenuaccessmap (
badd, bapprove, bdelete, bedit, bpublish, bview, istatus, imenuid, iroleid) VALUES (
true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, '558'::integer, '14'::integer)
 returning irolemenumapid;

INSERT INTO ui.rolemenuaccessmap (
badd, bapprove, bdelete, bedit, bpublish, bview, istatus, imenuid, iroleid) VALUES (
true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, '559'::integer, '14'::integer)
 returning irolemenumapid;

INSERT INTO ui.rolemenuaccessmap (
badd, bapprove, bdelete, bedit, bpublish, bview, istatus, imenuid, iroleid) VALUES (
true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, '560'::integer, '14'::integer)
 returning irolemenumapid;

INSERT INTO ui.rolemenuaccessmap (
badd, bapprove, bdelete, bedit, bpublish, bview, istatus, imenuid, iroleid) VALUES (
true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, '561'::integer, '14'::integer)
 returning irolemenumapid;

--god role 14 configuration ends

---god role 15 configuration starts
INSERT INTO ui.rolemenuaccessmap (
badd, bapprove, bdelete, bedit, bpublish, bview, istatus, imenuid, iroleid) VALUES (
true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, '482'::integer, '15'::integer)
 returning irolemenumapid;

INSERT INTO ui.rolemenuaccessmap (
badd, bapprove, bdelete, bedit, bpublish, bview, istatus, imenuid, iroleid) VALUES (
true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, '501'::integer, '15'::integer)
 returning irolemenumapid;
INSERT INTO ui.rolemenuaccessmap (
badd, bapprove, bdelete, bedit, bpublish, bview, istatus, imenuid, iroleid) VALUES (
true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, '513'::integer, '15'::integer)
 returning irolemenumapid;

INSERT INTO ui.rolemenuaccessmap (
badd, bapprove, bdelete, bedit, bpublish, bview, istatus, imenuid, iroleid) VALUES (
true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, '514'::integer, '15'::integer)
 returning irolemenumapid;

INSERT INTO ui.rolemenuaccessmap (
badd, bapprove, bdelete, bedit, bpublish, bview, istatus, imenuid, iroleid) VALUES (
true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, '518'::integer, '15'::integer)
 returning irolemenumapid;

INSERT INTO ui.rolemenuaccessmap (
badd, bapprove, bdelete, bedit, bpublish, bview, istatus, imenuid, iroleid) VALUES (
true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, '519'::integer, '15'::integer)
 returning irolemenumapid;

INSERT INTO ui.rolemenuaccessmap (
badd, bapprove, bdelete, bedit, bpublish, bview, istatus, imenuid, iroleid) VALUES (
true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, '520'::integer, '15'::integer)
 returning irolemenumapid;

 INSERT INTO ui.rolemenuaccessmap (
badd, bapprove, bdelete, bedit, bpublish, bview, istatus, imenuid, iroleid) VALUES (
true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, '481'::integer, '15'::integer)
 returning irolemenumapid;

INSERT INTO ui.rolemenuaccessmap (
badd, bapprove, bdelete, bedit, bpublish, bview, istatus, imenuid, iroleid) VALUES (
true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, '521'::integer, '15'::integer)
 returning irolemenumapid;

INSERT INTO ui.rolemenuaccessmap (
badd, bapprove, bdelete, bedit, bpublish, bview, istatus, imenuid, iroleid) VALUES (
true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, '522'::integer, '15'::integer)
 returning irolemenumapid;

INSERT INTO ui.rolemenuaccessmap (
badd, bapprove, bdelete, bedit, bpublish, bview, istatus, imenuid, iroleid) VALUES (
true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, '528'::integer, '15'::integer)
 returning irolemenumapid;

INSERT INTO ui.rolemenuaccessmap (
badd, bapprove, bdelete, bedit, bpublish, bview, istatus, imenuid, iroleid) VALUES (
true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, '529'::integer, '15'::integer)
 returning irolemenumapid;


INSERT INTO ui.rolemenuaccessmap (
badd, bapprove, bdelete, bedit, bpublish, bview, istatus, imenuid, iroleid) VALUES (
true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, '530'::integer, '15'::integer)
 returning irolemenumapid;

INSERT INTO ui.rolemenuaccessmap (
badd, bapprove, bdelete, bedit, bpublish, bview, istatus, imenuid, iroleid) VALUES (
true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, '499'::integer, '15'::integer)
 returning irolemenumapid;

INSERT INTO ui.rolemenuaccessmap (
badd, bapprove, bdelete, bedit, bpublish, bview, istatus, imenuid, iroleid) VALUES (
true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, '511'::integer, '15'::integer)
 returning irolemenumapid;

INSERT INTO ui.rolemenuaccessmap (
badd, bapprove, bdelete, bedit, bpublish, bview, istatus, imenuid, iroleid) VALUES (
true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, '515'::integer, '15'::integer)
 returning irolemenumapid;
INSERT INTO ui.rolemenuaccessmap (
badd, bapprove, bdelete, bedit, bpublish, bview, istatus, imenuid, iroleid) VALUES (
true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, '524'::integer, '15'::integer)
 returning irolemenumapid;

INSERT INTO ui.rolemenuaccessmap (
badd, bapprove, bdelete, bedit, bpublish, bview, istatus, imenuid, iroleid) VALUES (
true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, '525'::integer, '15'::integer)
 returning irolemenumapid;

INSERT INTO ui.rolemenuaccessmap (
badd, bapprove, bdelete, bedit, bpublish, bview, istatus, imenuid, iroleid) VALUES (
true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, '526'::integer, '15'::integer)
 returning irolemenumapid;
INSERT INTO ui.rolemenuaccessmap (
badd, bapprove, bdelete, bedit, bpublish, bview, istatus, imenuid, iroleid) VALUES (
true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, '527'::integer, '15'::integer)
 returning irolemenumapid;
INSERT INTO ui.rolemenuaccessmap (
badd, bapprove, bdelete, bedit, bpublish, bview, istatus, imenuid, iroleid) VALUES (
true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, '563'::integer, '15'::integer)
 returning irolemenumapid;
INSERT INTO ui.rolemenuaccessmap (
badd, bapprove, bdelete, bedit, bpublish, bview, istatus, imenuid, iroleid) VALUES (
true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, '564'::integer, '15'::integer)
 returning irolemenumapid;
INSERT INTO ui.rolemenuaccessmap (
badd, bapprove, bdelete, bedit, bpublish, bview, istatus, imenuid, iroleid) VALUES (
true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, '565'::integer, '15'::integer)
 returning irolemenumapid;
INSERT INTO ui.rolemenuaccessmap (
badd, bapprove, bdelete, bedit, bpublish, bview, istatus, imenuid, iroleid) VALUES (
true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, '566'::integer, '15'::integer)
 returning irolemenumapid;
INSERT INTO ui.rolemenuaccessmap (
badd, bapprove, bdelete, bedit, bpublish, bview, istatus, imenuid, iroleid) VALUES (
true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, '567'::integer, '15'::integer)
 returning irolemenumapid;
INSERT INTO ui.rolemenuaccessmap (
badd, bapprove, bdelete, bedit, bpublish, bview, istatus, imenuid, iroleid) VALUES (
true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, '568'::integer, '15'::integer)
 returning irolemenumapid;
INSERT INTO ui.rolemenuaccessmap (
badd, bapprove, bdelete, bedit, bpublish, bview, istatus, imenuid, iroleid) VALUES (
true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, '569'::integer, '15'::integer)
 returning irolemenumapid;
INSERT INTO ui.rolemenuaccessmap (
badd, bapprove, bdelete, bedit, bpublish, bview, istatus, imenuid, iroleid) VALUES (
true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, '570'::integer, '15'::integer)
 returning irolemenumapid;
INSERT INTO ui.rolemenuaccessmap (
badd, bapprove, bdelete, bedit, bpublish, bview, istatus, imenuid, iroleid) VALUES (
true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, '571'::integer, '15'::integer)
 returning irolemenumapid;

INSERT INTO ui.rolemenuaccessmap (
badd, bapprove, bdelete, bedit, bpublish, bview, istatus, imenuid, iroleid) VALUES (
true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, '547'::integer, '15'::integer)
 returning irolemenumapid;
INSERT INTO ui.rolemenuaccessmap (
badd, bapprove, bdelete, bedit, bpublish, bview, istatus, imenuid, iroleid) VALUES (
true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, '548'::integer, '15'::integer)
 returning irolemenumapid;
INSERT INTO ui.rolemenuaccessmap (
badd, bapprove, bdelete, bedit, bpublish, bview, istatus, imenuid, iroleid) VALUES (
true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, '549'::integer, '15'::integer)
 returning irolemenumapid;
INSERT INTO ui.rolemenuaccessmap (
badd, bapprove, bdelete, bedit, bpublish, bview, istatus, imenuid, iroleid) VALUES (
true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, '550'::integer, '15'::integer)
 returning irolemenumapid; 
INSERT INTO ui.rolemenuaccessmap (
badd, bapprove, bdelete, bedit, bpublish, bview, istatus, imenuid, iroleid) VALUES (
true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, '551'::integer, '15'::integer)
 returning irolemenumapid;

INSERT INTO ui.rolemenuaccessmap (
badd, bapprove, bdelete, bedit, bpublish, bview, istatus, imenuid, iroleid) VALUES (
true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, '552'::integer, '15'::integer)
 returning irolemenumapid;

INSERT INTO ui.rolemenuaccessmap (
badd, bapprove, bdelete, bedit, bpublish, bview, istatus, imenuid, iroleid) VALUES (
true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, '553'::integer, '15'::integer)
 returning irolemenumapid;

INSERT INTO ui.rolemenuaccessmap (
badd, bapprove, bdelete, bedit, bpublish, bview, istatus, imenuid, iroleid) VALUES (
true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, '554'::integer, '15'::integer)
 returning irolemenumapid;

 INSERT INTO ui.rolemenuaccessmap (
badd, bapprove, bdelete, bedit, bpublish, bview, istatus, imenuid, iroleid) VALUES (
true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, '555'::integer, '15'::integer)
 returning irolemenumapid;

 INSERT INTO ui.rolemenuaccessmap (
badd, bapprove, bdelete, bedit, bpublish, bview, istatus, imenuid, iroleid) VALUES (
true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, '556'::integer, '15'::integer)
 returning irolemenumapid;


 INSERT INTO ui.rolemenuaccessmap (
badd, bapprove, bdelete, bedit, bpublish, bview, istatus, imenuid, iroleid) VALUES (
true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, '557'::integer, '15'::integer)
 returning irolemenumapid;

INSERT INTO ui.rolemenuaccessmap (
badd, bapprove, bdelete, bedit, bpublish, bview, istatus, imenuid, iroleid) VALUES (
true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, '558'::integer, '15'::integer)
 returning irolemenumapid;

INSERT INTO ui.rolemenuaccessmap (
badd, bapprove, bdelete, bedit, bpublish, bview, istatus, imenuid, iroleid) VALUES (
true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, '559'::integer, '15'::integer)
 returning irolemenumapid;

INSERT INTO ui.rolemenuaccessmap (
badd, bapprove, bdelete, bedit, bpublish, bview, istatus, imenuid, iroleid) VALUES (
true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, '560'::integer, '15'::integer)
 returning irolemenumapid;

INSERT INTO ui.rolemenuaccessmap (
badd, bapprove, bdelete, bedit, bpublish, bview, istatus, imenuid, iroleid) VALUES (
true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, '561'::integer, '15'::integer)
 returning irolemenumapid;

--god role 15 configuration ends

---god role 18 configuration starts
INSERT INTO ui.rolemenuaccessmap (
badd, bapprove, bdelete, bedit, bpublish, bview, istatus, imenuid, iroleid) VALUES (
true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, '482'::integer, '18'::integer)
 returning irolemenumapid;

INSERT INTO ui.rolemenuaccessmap (
badd, bapprove, bdelete, bedit, bpublish, bview, istatus, imenuid, iroleid) VALUES (
true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, '501'::integer, '18'::integer)
 returning irolemenumapid;
INSERT INTO ui.rolemenuaccessmap (
badd, bapprove, bdelete, bedit, bpublish, bview, istatus, imenuid, iroleid) VALUES (
true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, '513'::integer, '18'::integer)
 returning irolemenumapid;

INSERT INTO ui.rolemenuaccessmap (
badd, bapprove, bdelete, bedit, bpublish, bview, istatus, imenuid, iroleid) VALUES (
true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, '514'::integer, '18'::integer)
 returning irolemenumapid;

INSERT INTO ui.rolemenuaccessmap (
badd, bapprove, bdelete, bedit, bpublish, bview, istatus, imenuid, iroleid) VALUES (
true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, '518'::integer, '18'::integer)
 returning irolemenumapid;

INSERT INTO ui.rolemenuaccessmap (
badd, bapprove, bdelete, bedit, bpublish, bview, istatus, imenuid, iroleid) VALUES (
true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, '519'::integer, '18'::integer)
 returning irolemenumapid;

INSERT INTO ui.rolemenuaccessmap (
badd, bapprove, bdelete, bedit, bpublish, bview, istatus, imenuid, iroleid) VALUES (
true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, '520'::integer, '18'::integer)
 returning irolemenumapid;

 INSERT INTO ui.rolemenuaccessmap (
badd, bapprove, bdelete, bedit, bpublish, bview, istatus, imenuid, iroleid) VALUES (
true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, '481'::integer, '18'::integer)
 returning irolemenumapid;

INSERT INTO ui.rolemenuaccessmap (
badd, bapprove, bdelete, bedit, bpublish, bview, istatus, imenuid, iroleid) VALUES (
true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, '521'::integer, '18'::integer)
 returning irolemenumapid;

INSERT INTO ui.rolemenuaccessmap (
badd, bapprove, bdelete, bedit, bpublish, bview, istatus, imenuid, iroleid) VALUES (
true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, '522'::integer, '18'::integer)
 returning irolemenumapid;

INSERT INTO ui.rolemenuaccessmap (
badd, bapprove, bdelete, bedit, bpublish, bview, istatus, imenuid, iroleid) VALUES (
true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, '528'::integer, '18'::integer)
 returning irolemenumapid;

INSERT INTO ui.rolemenuaccessmap (
badd, bapprove, bdelete, bedit, bpublish, bview, istatus, imenuid, iroleid) VALUES (
true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, '529'::integer, '18'::integer)
 returning irolemenumapid;


INSERT INTO ui.rolemenuaccessmap (
badd, bapprove, bdelete, bedit, bpublish, bview, istatus, imenuid, iroleid) VALUES (
true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, '530'::integer, '18'::integer)
 returning irolemenumapid;

INSERT INTO ui.rolemenuaccessmap (
badd, bapprove, bdelete, bedit, bpublish, bview, istatus, imenuid, iroleid) VALUES (
true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, '499'::integer, '18'::integer)
 returning irolemenumapid;

INSERT INTO ui.rolemenuaccessmap (
badd, bapprove, bdelete, bedit, bpublish, bview, istatus, imenuid, iroleid) VALUES (
true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, '511'::integer, '18'::integer)
 returning irolemenumapid;

INSERT INTO ui.rolemenuaccessmap (
badd, bapprove, bdelete, bedit, bpublish, bview, istatus, imenuid, iroleid) VALUES (
true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, '515'::integer, '18'::integer)
 returning irolemenumapid;
INSERT INTO ui.rolemenuaccessmap (
badd, bapprove, bdelete, bedit, bpublish, bview, istatus, imenuid, iroleid) VALUES (
true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, '524'::integer, '18'::integer)
 returning irolemenumapid;

INSERT INTO ui.rolemenuaccessmap (
badd, bapprove, bdelete, bedit, bpublish, bview, istatus, imenuid, iroleid) VALUES (
true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, '525'::integer, '18'::integer)
 returning irolemenumapid;

INSERT INTO ui.rolemenuaccessmap (
badd, bapprove, bdelete, bedit, bpublish, bview, istatus, imenuid, iroleid) VALUES (
true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, '526'::integer, '18'::integer)
 returning irolemenumapid;
INSERT INTO ui.rolemenuaccessmap (
badd, bapprove, bdelete, bedit, bpublish, bview, istatus, imenuid, iroleid) VALUES (
true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, '527'::integer, '18'::integer)
 returning irolemenumapid;
INSERT INTO ui.rolemenuaccessmap (
badd, bapprove, bdelete, bedit, bpublish, bview, istatus, imenuid, iroleid) VALUES (
true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, '563'::integer, '18'::integer)
 returning irolemenumapid;
INSERT INTO ui.rolemenuaccessmap (
badd, bapprove, bdelete, bedit, bpublish, bview, istatus, imenuid, iroleid) VALUES (
true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, '564'::integer, '18'::integer)
 returning irolemenumapid;
INSERT INTO ui.rolemenuaccessmap (
badd, bapprove, bdelete, bedit, bpublish, bview, istatus, imenuid, iroleid) VALUES (
true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, '565'::integer, '18'::integer)
 returning irolemenumapid;
INSERT INTO ui.rolemenuaccessmap (
badd, bapprove, bdelete, bedit, bpublish, bview, istatus, imenuid, iroleid) VALUES (
true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, '566'::integer, '18'::integer)
 returning irolemenumapid;
INSERT INTO ui.rolemenuaccessmap (
badd, bapprove, bdelete, bedit, bpublish, bview, istatus, imenuid, iroleid) VALUES (
true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, '567'::integer, '18'::integer)
 returning irolemenumapid;
INSERT INTO ui.rolemenuaccessmap (
badd, bapprove, bdelete, bedit, bpublish, bview, istatus, imenuid, iroleid) VALUES (
true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, '568'::integer, '18'::integer)
 returning irolemenumapid;
INSERT INTO ui.rolemenuaccessmap (
badd, bapprove, bdelete, bedit, bpublish, bview, istatus, imenuid, iroleid) VALUES (
true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, '569'::integer, '18'::integer)
 returning irolemenumapid;
INSERT INTO ui.rolemenuaccessmap (
badd, bapprove, bdelete, bedit, bpublish, bview, istatus, imenuid, iroleid) VALUES (
true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, '570'::integer, '18'::integer)
 returning irolemenumapid;
INSERT INTO ui.rolemenuaccessmap (
badd, bapprove, bdelete, bedit, bpublish, bview, istatus, imenuid, iroleid) VALUES (
true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, '571'::integer, '18'::integer)
 returning irolemenumapid;

INSERT INTO ui.rolemenuaccessmap (
badd, bapprove, bdelete, bedit, bpublish, bview, istatus, imenuid, iroleid) VALUES (
true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, '547'::integer, '18'::integer)
 returning irolemenumapid;
INSERT INTO ui.rolemenuaccessmap (
badd, bapprove, bdelete, bedit, bpublish, bview, istatus, imenuid, iroleid) VALUES (
true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, '548'::integer, '18'::integer)
 returning irolemenumapid;
INSERT INTO ui.rolemenuaccessmap (
badd, bapprove, bdelete, bedit, bpublish, bview, istatus, imenuid, iroleid) VALUES (
true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, '549'::integer, '18'::integer)
 returning irolemenumapid;
INSERT INTO ui.rolemenuaccessmap (
badd, bapprove, bdelete, bedit, bpublish, bview, istatus, imenuid, iroleid) VALUES (
true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, '550'::integer, '18'::integer)
 returning irolemenumapid; 
INSERT INTO ui.rolemenuaccessmap (
badd, bapprove, bdelete, bedit, bpublish, bview, istatus, imenuid, iroleid) VALUES (
true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, '551'::integer, '18'::integer)
 returning irolemenumapid;

INSERT INTO ui.rolemenuaccessmap (
badd, bapprove, bdelete, bedit, bpublish, bview, istatus, imenuid, iroleid) VALUES (
true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, '552'::integer, '18'::integer)
 returning irolemenumapid;

INSERT INTO ui.rolemenuaccessmap (
badd, bapprove, bdelete, bedit, bpublish, bview, istatus, imenuid, iroleid) VALUES (
true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, '553'::integer, '18'::integer)
 returning irolemenumapid;

INSERT INTO ui.rolemenuaccessmap (
badd, bapprove, bdelete, bedit, bpublish, bview, istatus, imenuid, iroleid) VALUES (
true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, '554'::integer, '18'::integer)
 returning irolemenumapid;

 INSERT INTO ui.rolemenuaccessmap (
badd, bapprove, bdelete, bedit, bpublish, bview, istatus, imenuid, iroleid) VALUES (
true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, '555'::integer, '18'::integer)
 returning irolemenumapid;

 INSERT INTO ui.rolemenuaccessmap (
badd, bapprove, bdelete, bedit, bpublish, bview, istatus, imenuid, iroleid) VALUES (
true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, '556'::integer, '18'::integer)
 returning irolemenumapid;


 INSERT INTO ui.rolemenuaccessmap (
badd, bapprove, bdelete, bedit, bpublish, bview, istatus, imenuid, iroleid) VALUES (
true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, '557'::integer, '18'::integer)
 returning irolemenumapid;

INSERT INTO ui.rolemenuaccessmap (
badd, bapprove, bdelete, bedit, bpublish, bview, istatus, imenuid, iroleid) VALUES (
true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, '558'::integer, '18'::integer)
 returning irolemenumapid;

INSERT INTO ui.rolemenuaccessmap (
badd, bapprove, bdelete, bedit, bpublish, bview, istatus, imenuid, iroleid) VALUES (
true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, '559'::integer, '18'::integer)
 returning irolemenumapid;

INSERT INTO ui.rolemenuaccessmap (
badd, bapprove, bdelete, bedit, bpublish, bview, istatus, imenuid, iroleid) VALUES (
true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, '560'::integer, '18'::integer)
 returning irolemenumapid;

INSERT INTO ui.rolemenuaccessmap (
badd, bapprove, bdelete, bedit, bpublish, bview, istatus, imenuid, iroleid) VALUES (
true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, '561'::integer, '18'::integer)
 returning irolemenumapid;

--god role 18 configuration ends

--risk analyst 16 configuration starts
INSERT INTO ui.rolemenuaccessmap (
badd, bapprove, bdelete, bedit, bpublish, bview, istatus, imenuid, iroleid) VALUES (
true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, '482'::integer, '16'::integer)
 returning irolemenumapid;

INSERT INTO ui.rolemenuaccessmap (
badd, bapprove, bdelete, bedit, bpublish, bview, istatus, imenuid, iroleid) VALUES (
false::boolean, false::boolean, false::boolean, false::boolean, false::boolean, true::boolean, true::boolean, '501'::integer, '16'::integer)
 returning irolemenumapid;
INSERT INTO ui.rolemenuaccessmap (
badd, bapprove, bdelete, bedit, bpublish, bview, istatus, imenuid, iroleid) VALUES (
true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, '514'::integer, '16'::integer)
 returning irolemenumapid;

 INSERT INTO ui.rolemenuaccessmap (
badd, bapprove, bdelete, bedit, bpublish, bview, istatus, imenuid, iroleid) VALUES (
true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, '481'::integer, '16'::integer)
 returning irolemenumapid;

INSERT INTO ui.rolemenuaccessmap (
badd, bapprove, bdelete, bedit, bpublish, bview, istatus, imenuid, iroleid) VALUES (
true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, '521'::integer, '16'::integer)
 returning irolemenumapid;

INSERT INTO ui.rolemenuaccessmap (
badd, bapprove, bdelete, bedit, bpublish, bview, istatus, imenuid, iroleid) VALUES (
true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, '522'::integer, '16'::integer)
 returning irolemenumapid;

INSERT INTO ui.rolemenuaccessmap (
badd, bapprove, bdelete, bedit, bpublish, bview, istatus, imenuid, iroleid) VALUES (
true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, '528'::integer, '16'::integer)
 returning irolemenumapid;

INSERT INTO ui.rolemenuaccessmap (
badd, bapprove, bdelete, bedit, bpublish, bview, istatus, imenuid, iroleid) VALUES (
true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, '529'::integer, '16'::integer)
 returning irolemenumapid;


INSERT INTO ui.rolemenuaccessmap (
badd, bapprove, bdelete, bedit, bpublish, bview, istatus, imenuid, iroleid) VALUES (
true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, '530'::integer, '16'::integer)
 returning irolemenumapid;

INSERT INTO ui.rolemenuaccessmap (
badd, bapprove, bdelete, bedit, bpublish, bview, istatus, imenuid, iroleid) VALUES (
true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, '499'::integer, '16'::integer)
 returning irolemenumapid;

INSERT INTO ui.rolemenuaccessmap (
badd, bapprove, bdelete, bedit, bpublish, bview, istatus, imenuid, iroleid) VALUES (
true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, '511'::integer, '16'::integer)
 returning irolemenumapid;

INSERT INTO ui.rolemenuaccessmap (
badd, bapprove, bdelete, bedit, bpublish, bview, istatus, imenuid, iroleid) VALUES (
true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, '515'::integer, '16'::integer)
 returning irolemenumapid;
INSERT INTO ui.rolemenuaccessmap (
badd, bapprove, bdelete, bedit, bpublish, bview, istatus, imenuid, iroleid) VALUES (
true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, '524'::integer, '16'::integer)
 returning irolemenumapid;

INSERT INTO ui.rolemenuaccessmap (
badd, bapprove, bdelete, bedit, bpublish, bview, istatus, imenuid, iroleid) VALUES (
true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, '525'::integer, '16'::integer)
 returning irolemenumapid;

INSERT INTO ui.rolemenuaccessmap (
badd, bapprove, bdelete, bedit, bpublish, bview, istatus, imenuid, iroleid) VALUES (
true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, '526'::integer, '16'::integer)
 returning irolemenumapid;
INSERT INTO ui.rolemenuaccessmap (
badd, bapprove, bdelete, bedit, bpublish, bview, istatus, imenuid, iroleid) VALUES (
true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, '527'::integer, '16'::integer)
 returning irolemenumapid;
INSERT INTO ui.rolemenuaccessmap (
badd, bapprove, bdelete, bedit, bpublish, bview, istatus, imenuid, iroleid) VALUES (
true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, '563'::integer, '16'::integer)
 returning irolemenumapid;
INSERT INTO ui.rolemenuaccessmap (
badd, bapprove, bdelete, bedit, bpublish, bview, istatus, imenuid, iroleid) VALUES (
true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, '564'::integer, '16'::integer)
 returning irolemenumapid;
INSERT INTO ui.rolemenuaccessmap (
badd, bapprove, bdelete, bedit, bpublish, bview, istatus, imenuid, iroleid) VALUES (
true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, '565'::integer, '16'::integer)
 returning irolemenumapid;
INSERT INTO ui.rolemenuaccessmap (
badd, bapprove, bdelete, bedit, bpublish, bview, istatus, imenuid, iroleid) VALUES (
true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, '566'::integer, '16'::integer)
 returning irolemenumapid;
INSERT INTO ui.rolemenuaccessmap (
badd, bapprove, bdelete, bedit, bpublish, bview, istatus, imenuid, iroleid) VALUES (
true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, '567'::integer, '16'::integer)
 returning irolemenumapid;
INSERT INTO ui.rolemenuaccessmap (
badd, bapprove, bdelete, bedit, bpublish, bview, istatus, imenuid, iroleid) VALUES (
true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, '568'::integer, '16'::integer)
 returning irolemenumapid;
INSERT INTO ui.rolemenuaccessmap (
badd, bapprove, bdelete, bedit, bpublish, bview, istatus, imenuid, iroleid) VALUES (
true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, '569'::integer, '16'::integer)
 returning irolemenumapid;
INSERT INTO ui.rolemenuaccessmap (
badd, bapprove, bdelete, bedit, bpublish, bview, istatus, imenuid, iroleid) VALUES (
true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, '570'::integer, '16'::integer)
 returning irolemenumapid;
INSERT INTO ui.rolemenuaccessmap (
badd, bapprove, bdelete, bedit, bpublish, bview, istatus, imenuid, iroleid) VALUES (
true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, '571'::integer, '16'::integer)
 returning irolemenumapid;

INSERT INTO ui.rolemenuaccessmap (
badd, bapprove, bdelete, bedit, bpublish, bview, istatus, imenuid, iroleid) VALUES (
true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, '547'::integer, '16'::integer)
 returning irolemenumapid;
INSERT INTO ui.rolemenuaccessmap (
badd, bapprove, bdelete, bedit, bpublish, bview, istatus, imenuid, iroleid) VALUES (
true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, '548'::integer, '16'::integer)
 returning irolemenumapid;
INSERT INTO ui.rolemenuaccessmap (
badd, bapprove, bdelete, bedit, bpublish, bview, istatus, imenuid, iroleid) VALUES (
true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, '549'::integer, '16'::integer)
 returning irolemenumapid;
INSERT INTO ui.rolemenuaccessmap (
badd, bapprove, bdelete, bedit, bpublish, bview, istatus, imenuid, iroleid) VALUES (
true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, '550'::integer, '16'::integer)
 returning irolemenumapid; 
INSERT INTO ui.rolemenuaccessmap (
badd, bapprove, bdelete, bedit, bpublish, bview, istatus, imenuid, iroleid) VALUES (
true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, '551'::integer, '16'::integer)
 returning irolemenumapid;

INSERT INTO ui.rolemenuaccessmap (
badd, bapprove, bdelete, bedit, bpublish, bview, istatus, imenuid, iroleid) VALUES (
true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, '552'::integer, '16'::integer)
 returning irolemenumapid;

INSERT INTO ui.rolemenuaccessmap (
badd, bapprove, bdelete, bedit, bpublish, bview, istatus, imenuid, iroleid) VALUES (
true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, '553'::integer, '16'::integer)
 returning irolemenumapid;

INSERT INTO ui.rolemenuaccessmap (
badd, bapprove, bdelete, bedit, bpublish, bview, istatus, imenuid, iroleid) VALUES (
true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, '554'::integer, '16'::integer)
 returning irolemenumapid;

 INSERT INTO ui.rolemenuaccessmap (
badd, bapprove, bdelete, bedit, bpublish, bview, istatus, imenuid, iroleid) VALUES (
true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, '555'::integer, '16'::integer)
 returning irolemenumapid;

 INSERT INTO ui.rolemenuaccessmap (
badd, bapprove, bdelete, bedit, bpublish, bview, istatus, imenuid, iroleid) VALUES (
true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, '556'::integer, '16'::integer)
 returning irolemenumapid;


 INSERT INTO ui.rolemenuaccessmap (
badd, bapprove, bdelete, bedit, bpublish, bview, istatus, imenuid, iroleid) VALUES (
true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, '557'::integer, '16'::integer)
 returning irolemenumapid;

INSERT INTO ui.rolemenuaccessmap (
badd, bapprove, bdelete, bedit, bpublish, bview, istatus, imenuid, iroleid) VALUES (
true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, '558'::integer, '16'::integer)
 returning irolemenumapid;

INSERT INTO ui.rolemenuaccessmap (
badd, bapprove, bdelete, bedit, bpublish, bview, istatus, imenuid, iroleid) VALUES (
true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, '559'::integer, '16'::integer)
 returning irolemenumapid;

INSERT INTO ui.rolemenuaccessmap (
badd, bapprove, bdelete, bedit, bpublish, bview, istatus, imenuid, iroleid) VALUES (
true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, '560'::integer, '16'::integer)
 returning irolemenumapid;

INSERT INTO ui.rolemenuaccessmap (
badd, bapprove, bdelete, bedit, bpublish, bview, istatus, imenuid, iroleid) VALUES (
true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, '561'::integer, '16'::integer)
 returning irolemenumapid;
--risk analyst 16 configuration ends

--risk analyst 17 configuration starts
INSERT INTO ui.rolemenuaccessmap (
badd, bapprove, bdelete, bedit, bpublish, bview, istatus, imenuid, iroleid) VALUES (
true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, '482'::integer, '17'::integer)
 returning irolemenumapid;

INSERT INTO ui.rolemenuaccessmap (
badd, bapprove, bdelete, bedit, bpublish, bview, istatus, imenuid, iroleid) VALUES (
false::boolean, false::boolean, false::boolean, false::boolean, false::boolean, true::boolean, true::boolean, '501'::integer, '17'::integer)
 returning irolemenumapid;
INSERT INTO ui.rolemenuaccessmap (
badd, bapprove, bdelete, bedit, bpublish, bview, istatus, imenuid, iroleid) VALUES (
true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, '514'::integer, '17'::integer)
 returning irolemenumapid;

 INSERT INTO ui.rolemenuaccessmap (
badd, bapprove, bdelete, bedit, bpublish, bview, istatus, imenuid, iroleid) VALUES (
true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, '481'::integer, '17'::integer)
 returning irolemenumapid;

INSERT INTO ui.rolemenuaccessmap (
badd, bapprove, bdelete, bedit, bpublish, bview, istatus, imenuid, iroleid) VALUES (
true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, '521'::integer, '17'::integer)
 returning irolemenumapid;

INSERT INTO ui.rolemenuaccessmap (
badd, bapprove, bdelete, bedit, bpublish, bview, istatus, imenuid, iroleid) VALUES (
true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, '522'::integer, '17'::integer)
 returning irolemenumapid;

INSERT INTO ui.rolemenuaccessmap (
badd, bapprove, bdelete, bedit, bpublish, bview, istatus, imenuid, iroleid) VALUES (
true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, '528'::integer, '17'::integer)
 returning irolemenumapid;

INSERT INTO ui.rolemenuaccessmap (
badd, bapprove, bdelete, bedit, bpublish, bview, istatus, imenuid, iroleid) VALUES (
true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, '529'::integer, '17'::integer)
 returning irolemenumapid;


INSERT INTO ui.rolemenuaccessmap (
badd, bapprove, bdelete, bedit, bpublish, bview, istatus, imenuid, iroleid) VALUES (
true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, '530'::integer, '17'::integer)
 returning irolemenumapid;

INSERT INTO ui.rolemenuaccessmap (
badd, bapprove, bdelete, bedit, bpublish, bview, istatus, imenuid, iroleid) VALUES (
true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, '499'::integer, '17'::integer)
 returning irolemenumapid;

INSERT INTO ui.rolemenuaccessmap (
badd, bapprove, bdelete, bedit, bpublish, bview, istatus, imenuid, iroleid) VALUES (
true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, '511'::integer, '17'::integer)
 returning irolemenumapid;

INSERT INTO ui.rolemenuaccessmap (
badd, bapprove, bdelete, bedit, bpublish, bview, istatus, imenuid, iroleid) VALUES (
true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, '515'::integer, '17'::integer)
 returning irolemenumapid;
INSERT INTO ui.rolemenuaccessmap (
badd, bapprove, bdelete, bedit, bpublish, bview, istatus, imenuid, iroleid) VALUES (
true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, '524'::integer, '17'::integer)
 returning irolemenumapid;

INSERT INTO ui.rolemenuaccessmap (
badd, bapprove, bdelete, bedit, bpublish, bview, istatus, imenuid, iroleid) VALUES (
true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, '525'::integer, '17'::integer)
 returning irolemenumapid;

INSERT INTO ui.rolemenuaccessmap (
badd, bapprove, bdelete, bedit, bpublish, bview, istatus, imenuid, iroleid) VALUES (
true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, '526'::integer, '17'::integer)
 returning irolemenumapid;
INSERT INTO ui.rolemenuaccessmap (
badd, bapprove, bdelete, bedit, bpublish, bview, istatus, imenuid, iroleid) VALUES (
true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, '527'::integer, '17'::integer)
 returning irolemenumapid;
INSERT INTO ui.rolemenuaccessmap (
badd, bapprove, bdelete, bedit, bpublish, bview, istatus, imenuid, iroleid) VALUES (
true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, '563'::integer, '17'::integer)
 returning irolemenumapid;
INSERT INTO ui.rolemenuaccessmap (
badd, bapprove, bdelete, bedit, bpublish, bview, istatus, imenuid, iroleid) VALUES (
true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, '564'::integer, '17'::integer)
 returning irolemenumapid;
INSERT INTO ui.rolemenuaccessmap (
badd, bapprove, bdelete, bedit, bpublish, bview, istatus, imenuid, iroleid) VALUES (
true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, '565'::integer, '17'::integer)
 returning irolemenumapid;
INSERT INTO ui.rolemenuaccessmap (
badd, bapprove, bdelete, bedit, bpublish, bview, istatus, imenuid, iroleid) VALUES (
true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, '566'::integer, '17'::integer)
 returning irolemenumapid;
INSERT INTO ui.rolemenuaccessmap (
badd, bapprove, bdelete, bedit, bpublish, bview, istatus, imenuid, iroleid) VALUES (
true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, '567'::integer, '17'::integer)
 returning irolemenumapid;
INSERT INTO ui.rolemenuaccessmap (
badd, bapprove, bdelete, bedit, bpublish, bview, istatus, imenuid, iroleid) VALUES (
true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, '568'::integer, '17'::integer)
 returning irolemenumapid;
INSERT INTO ui.rolemenuaccessmap (
badd, bapprove, bdelete, bedit, bpublish, bview, istatus, imenuid, iroleid) VALUES (
true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, '569'::integer, '17'::integer)
 returning irolemenumapid;
INSERT INTO ui.rolemenuaccessmap (
badd, bapprove, bdelete, bedit, bpublish, bview, istatus, imenuid, iroleid) VALUES (
true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, '570'::integer, '17'::integer)
 returning irolemenumapid;
INSERT INTO ui.rolemenuaccessmap (
badd, bapprove, bdelete, bedit, bpublish, bview, istatus, imenuid, iroleid) VALUES (
true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, '571'::integer, '17'::integer)
 returning irolemenumapid;

INSERT INTO ui.rolemenuaccessmap (
badd, bapprove, bdelete, bedit, bpublish, bview, istatus, imenuid, iroleid) VALUES (
true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, '547'::integer, '17'::integer)
 returning irolemenumapid;
INSERT INTO ui.rolemenuaccessmap (
badd, bapprove, bdelete, bedit, bpublish, bview, istatus, imenuid, iroleid) VALUES (
true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, '548'::integer, '17'::integer)
 returning irolemenumapid;
INSERT INTO ui.rolemenuaccessmap (
badd, bapprove, bdelete, bedit, bpublish, bview, istatus, imenuid, iroleid) VALUES (
true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, '549'::integer, '17'::integer)
 returning irolemenumapid;
INSERT INTO ui.rolemenuaccessmap (
badd, bapprove, bdelete, bedit, bpublish, bview, istatus, imenuid, iroleid) VALUES (
true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, '550'::integer, '17'::integer)
 returning irolemenumapid; 
INSERT INTO ui.rolemenuaccessmap (
badd, bapprove, bdelete, bedit, bpublish, bview, istatus, imenuid, iroleid) VALUES (
true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, '551'::integer, '17'::integer)
 returning irolemenumapid;

INSERT INTO ui.rolemenuaccessmap (
badd, bapprove, bdelete, bedit, bpublish, bview, istatus, imenuid, iroleid) VALUES (
true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, '552'::integer, '17'::integer)
 returning irolemenumapid;

INSERT INTO ui.rolemenuaccessmap (
badd, bapprove, bdelete, bedit, bpublish, bview, istatus, imenuid, iroleid) VALUES (
true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, '553'::integer, '17'::integer)
 returning irolemenumapid;

INSERT INTO ui.rolemenuaccessmap (
badd, bapprove, bdelete, bedit, bpublish, bview, istatus, imenuid, iroleid) VALUES (
true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, '554'::integer, '17'::integer)
 returning irolemenumapid;

 INSERT INTO ui.rolemenuaccessmap (
badd, bapprove, bdelete, bedit, bpublish, bview, istatus, imenuid, iroleid) VALUES (
true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, '555'::integer, '17'::integer)
 returning irolemenumapid;

 INSERT INTO ui.rolemenuaccessmap (
badd, bapprove, bdelete, bedit, bpublish, bview, istatus, imenuid, iroleid) VALUES (
true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, '556'::integer, '17'::integer)
 returning irolemenumapid;


 INSERT INTO ui.rolemenuaccessmap (
badd, bapprove, bdelete, bedit, bpublish, bview, istatus, imenuid, iroleid) VALUES (
true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, '557'::integer, '17'::integer)
 returning irolemenumapid;

INSERT INTO ui.rolemenuaccessmap (
badd, bapprove, bdelete, bedit, bpublish, bview, istatus, imenuid, iroleid) VALUES (
true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, '558'::integer, '17'::integer)
 returning irolemenumapid;

INSERT INTO ui.rolemenuaccessmap (
badd, bapprove, bdelete, bedit, bpublish, bview, istatus, imenuid, iroleid) VALUES (
true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, '559'::integer, '17'::integer)
 returning irolemenumapid;

INSERT INTO ui.rolemenuaccessmap (
badd, bapprove, bdelete, bedit, bpublish, bview, istatus, imenuid, iroleid) VALUES (
true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, '560'::integer, '17'::integer)
 returning irolemenumapid;

INSERT INTO ui.rolemenuaccessmap (
badd, bapprove, bdelete, bedit, bpublish, bview, istatus, imenuid, iroleid) VALUES (
true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, '561'::integer, '17'::integer)
 returning irolemenumapid;
--risk analyst 17 configuration ends

--risk analyst 19 configuration starts
INSERT INTO ui.rolemenuaccessmap (
badd, bapprove, bdelete, bedit, bpublish, bview, istatus, imenuid, iroleid) VALUES (
true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, '482'::integer, '19'::integer)
 returning irolemenumapid;

INSERT INTO ui.rolemenuaccessmap (
badd, bapprove, bdelete, bedit, bpublish, bview, istatus, imenuid, iroleid) VALUES (
false::boolean, false::boolean, false::boolean, false::boolean, false::boolean, true::boolean, true::boolean, '501'::integer, '19'::integer)
 returning irolemenumapid;
INSERT INTO ui.rolemenuaccessmap (
badd, bapprove, bdelete, bedit, bpublish, bview, istatus, imenuid, iroleid) VALUES (
true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, '514'::integer, '19'::integer)
 returning irolemenumapid;

 INSERT INTO ui.rolemenuaccessmap (
badd, bapprove, bdelete, bedit, bpublish, bview, istatus, imenuid, iroleid) VALUES (
true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, '481'::integer, '19'::integer)
 returning irolemenumapid;

INSERT INTO ui.rolemenuaccessmap (
badd, bapprove, bdelete, bedit, bpublish, bview, istatus, imenuid, iroleid) VALUES (
true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, '521'::integer, '19'::integer)
 returning irolemenumapid;

INSERT INTO ui.rolemenuaccessmap (
badd, bapprove, bdelete, bedit, bpublish, bview, istatus, imenuid, iroleid) VALUES (
true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, '522'::integer, '19'::integer)
 returning irolemenumapid;

INSERT INTO ui.rolemenuaccessmap (
badd, bapprove, bdelete, bedit, bpublish, bview, istatus, imenuid, iroleid) VALUES (
true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, '528'::integer, '19'::integer)
 returning irolemenumapid;

INSERT INTO ui.rolemenuaccessmap (
badd, bapprove, bdelete, bedit, bpublish, bview, istatus, imenuid, iroleid) VALUES (
true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, '529'::integer, '19'::integer)
 returning irolemenumapid;


INSERT INTO ui.rolemenuaccessmap (
badd, bapprove, bdelete, bedit, bpublish, bview, istatus, imenuid, iroleid) VALUES (
true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, '530'::integer, '19'::integer)
 returning irolemenumapid;

INSERT INTO ui.rolemenuaccessmap (
badd, bapprove, bdelete, bedit, bpublish, bview, istatus, imenuid, iroleid) VALUES (
true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, '499'::integer, '19'::integer)
 returning irolemenumapid;

INSERT INTO ui.rolemenuaccessmap (
badd, bapprove, bdelete, bedit, bpublish, bview, istatus, imenuid, iroleid) VALUES (
true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, '511'::integer, '19'::integer)
 returning irolemenumapid;

INSERT INTO ui.rolemenuaccessmap (
badd, bapprove, bdelete, bedit, bpublish, bview, istatus, imenuid, iroleid) VALUES (
true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, '515'::integer, '19'::integer)
 returning irolemenumapid;
INSERT INTO ui.rolemenuaccessmap (
badd, bapprove, bdelete, bedit, bpublish, bview, istatus, imenuid, iroleid) VALUES (
true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, '524'::integer, '19'::integer)
 returning irolemenumapid;

INSERT INTO ui.rolemenuaccessmap (
badd, bapprove, bdelete, bedit, bpublish, bview, istatus, imenuid, iroleid) VALUES (
true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, '525'::integer, '19'::integer)
 returning irolemenumapid;

INSERT INTO ui.rolemenuaccessmap (
badd, bapprove, bdelete, bedit, bpublish, bview, istatus, imenuid, iroleid) VALUES (
true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, '526'::integer, '19'::integer)
 returning irolemenumapid;
INSERT INTO ui.rolemenuaccessmap (
badd, bapprove, bdelete, bedit, bpublish, bview, istatus, imenuid, iroleid) VALUES (
true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, '527'::integer, '19'::integer)
 returning irolemenumapid;
INSERT INTO ui.rolemenuaccessmap (
badd, bapprove, bdelete, bedit, bpublish, bview, istatus, imenuid, iroleid) VALUES (
true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, '563'::integer, '19'::integer)
 returning irolemenumapid;
INSERT INTO ui.rolemenuaccessmap (
badd, bapprove, bdelete, bedit, bpublish, bview, istatus, imenuid, iroleid) VALUES (
true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, '564'::integer, '19'::integer)
 returning irolemenumapid;
INSERT INTO ui.rolemenuaccessmap (
badd, bapprove, bdelete, bedit, bpublish, bview, istatus, imenuid, iroleid) VALUES (
true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, '565'::integer, '19'::integer)
 returning irolemenumapid;
INSERT INTO ui.rolemenuaccessmap (
badd, bapprove, bdelete, bedit, bpublish, bview, istatus, imenuid, iroleid) VALUES (
true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, '566'::integer, '19'::integer)
 returning irolemenumapid;
INSERT INTO ui.rolemenuaccessmap (
badd, bapprove, bdelete, bedit, bpublish, bview, istatus, imenuid, iroleid) VALUES (
true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, '567'::integer, '19'::integer)
 returning irolemenumapid;
INSERT INTO ui.rolemenuaccessmap (
badd, bapprove, bdelete, bedit, bpublish, bview, istatus, imenuid, iroleid) VALUES (
true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, '568'::integer, '19'::integer)
 returning irolemenumapid;
INSERT INTO ui.rolemenuaccessmap (
badd, bapprove, bdelete, bedit, bpublish, bview, istatus, imenuid, iroleid) VALUES (
true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, '569'::integer, '19'::integer)
 returning irolemenumapid;
INSERT INTO ui.rolemenuaccessmap (
badd, bapprove, bdelete, bedit, bpublish, bview, istatus, imenuid, iroleid) VALUES (
true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, '570'::integer, '19'::integer)
 returning irolemenumapid;
INSERT INTO ui.rolemenuaccessmap (
badd, bapprove, bdelete, bedit, bpublish, bview, istatus, imenuid, iroleid) VALUES (
true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, '571'::integer, '19'::integer)
 returning irolemenumapid;

INSERT INTO ui.rolemenuaccessmap (
badd, bapprove, bdelete, bedit, bpublish, bview, istatus, imenuid, iroleid) VALUES (
true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, '547'::integer, '19'::integer)
 returning irolemenumapid;
INSERT INTO ui.rolemenuaccessmap (
badd, bapprove, bdelete, bedit, bpublish, bview, istatus, imenuid, iroleid) VALUES (
true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, '548'::integer, '19'::integer)
 returning irolemenumapid;
INSERT INTO ui.rolemenuaccessmap (
badd, bapprove, bdelete, bedit, bpublish, bview, istatus, imenuid, iroleid) VALUES (
true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, '549'::integer, '19'::integer)
 returning irolemenumapid;
INSERT INTO ui.rolemenuaccessmap (
badd, bapprove, bdelete, bedit, bpublish, bview, istatus, imenuid, iroleid) VALUES (
true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, '550'::integer, '19'::integer)
 returning irolemenumapid; 
INSERT INTO ui.rolemenuaccessmap (
badd, bapprove, bdelete, bedit, bpublish, bview, istatus, imenuid, iroleid) VALUES (
true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, '551'::integer, '19'::integer)
 returning irolemenumapid;

INSERT INTO ui.rolemenuaccessmap (
badd, bapprove, bdelete, bedit, bpublish, bview, istatus, imenuid, iroleid) VALUES (
true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, '552'::integer, '19'::integer)
 returning irolemenumapid;

INSERT INTO ui.rolemenuaccessmap (
badd, bapprove, bdelete, bedit, bpublish, bview, istatus, imenuid, iroleid) VALUES (
true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, '553'::integer, '19'::integer)
 returning irolemenumapid;

INSERT INTO ui.rolemenuaccessmap (
badd, bapprove, bdelete, bedit, bpublish, bview, istatus, imenuid, iroleid) VALUES (
true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, '554'::integer, '19'::integer)
 returning irolemenumapid;

 INSERT INTO ui.rolemenuaccessmap (
badd, bapprove, bdelete, bedit, bpublish, bview, istatus, imenuid, iroleid) VALUES (
true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, '555'::integer, '19'::integer)
 returning irolemenumapid;

 INSERT INTO ui.rolemenuaccessmap (
badd, bapprove, bdelete, bedit, bpublish, bview, istatus, imenuid, iroleid) VALUES (
true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, '556'::integer, '19'::integer)
 returning irolemenumapid;


 INSERT INTO ui.rolemenuaccessmap (
badd, bapprove, bdelete, bedit, bpublish, bview, istatus, imenuid, iroleid) VALUES (
true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, '557'::integer, '19'::integer)
 returning irolemenumapid;

INSERT INTO ui.rolemenuaccessmap (
badd, bapprove, bdelete, bedit, bpublish, bview, istatus, imenuid, iroleid) VALUES (
true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, '558'::integer, '19'::integer)
 returning irolemenumapid;

INSERT INTO ui.rolemenuaccessmap (
badd, bapprove, bdelete, bedit, bpublish, bview, istatus, imenuid, iroleid) VALUES (
true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, '559'::integer, '19'::integer)
 returning irolemenumapid;

INSERT INTO ui.rolemenuaccessmap (
badd, bapprove, bdelete, bedit, bpublish, bview, istatus, imenuid, iroleid) VALUES (
true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, '560'::integer, '19'::integer)
 returning irolemenumapid;

INSERT INTO ui.rolemenuaccessmap (
badd, bapprove, bdelete, bedit, bpublish, bview, istatus, imenuid, iroleid) VALUES (
true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, '561'::integer, '19'::integer)
 returning irolemenumapid;
--risk analyst 19 configuration ends

update ui.workflowmasters set itenantid=3 where workflowid=6 or workflowid=12;
update ui.workflowmasters set itenantid=4 where workflowid=4 or workflowid=5;
update ui.workflowmasters set itenantid=5 where workflowid=13 or workflowid=14;









