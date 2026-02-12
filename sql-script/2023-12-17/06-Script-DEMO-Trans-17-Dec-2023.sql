---------Case management Set up for JPB SIT tenant----------

--risk supervisor group for jpb workflow
INSERT into ui.groupdesc(igroupid, vcgroupid, vcgroupname, vcgrouptype, istatus, itenantid) VALUES (
'2057'::integer, 'risksupervisor'::character varying, 'Risk Supervisor'::character varying, 'WORKFLOW'::character varying, '1'::integer, '12'::integer)
 returning igroupid;

---panel access map for jpb workflow
insert into ui.panelaccessmap (panelaccessmap, panelid, groupid, workflowid) VALUES ((select max(panelaccessmap)+1 from ui.panelaccessmap), 1, 2040, 19);
insert into ui.panelaccessmap (panelaccessmap, panelid, groupid, workflowid) VALUES ((select max(panelaccessmap)+1 from ui.panelaccessmap), 2, 2040, 19);
insert into ui.panelaccessmap (panelaccessmap, panelid, groupid, workflowid) VALUES ((select max(panelaccessmap)+1 from ui.panelaccessmap), 3, 2040, 19);
insert into ui.panelaccessmap (panelaccessmap, panelid, groupid, workflowid) VALUES ((select max(panelaccessmap)+1 from ui.panelaccessmap), 4, 2040, 19);
insert into ui.panelaccessmap (panelaccessmap, panelid, groupid, workflowid) VALUES ((select max(panelaccessmap)+1 from ui.panelaccessmap), 5, 2040, 19);

insert into ui.panelaccessmap (panelaccessmap, panelid, groupid, workflowid) VALUES ((select max(panelaccessmap)+1 from ui.panelaccessmap), 1, 2057, 19);
insert into ui.panelaccessmap (panelaccessmap, panelid, groupid, workflowid) VALUES ((select max(panelaccessmap)+1 from ui.panelaccessmap), 2, 2057, 19);
insert into ui.panelaccessmap (panelaccessmap, panelid, groupid, workflowid) VALUES ((select max(panelaccessmap)+1 from ui.panelaccessmap), 3, 2057, 19);
insert into ui.panelaccessmap (panelaccessmap, panelid, groupid, workflowid) VALUES ((select max(panelaccessmap)+1 from ui.panelaccessmap), 4, 2057, 19);
insert into ui.panelaccessmap (panelaccessmap, panelid, groupid, workflowid) VALUES ((select max(panelaccessmap)+1 from ui.panelaccessmap), 5, 2057, 19);

----group to task filter map
INSERT INTO ui.grouptotaskfiltermap( iposition, igroupid, itaskfilterid)
 SELECT 1, igroupid, 1
 FROM ui.groupdesc where itenantid=12;

INSERT INTO ui.grouptotaskfiltermap( iposition, igroupid, itaskfilterid)
 SELECT 2, igroupid, 2
 FROM ui.groupdesc where itenantid=12;

INSERT INTO ui.grouptotaskfiltermap( iposition, igroupid, itaskfilterid)
 SELECT 3, igroupid, 3
 FROM ui.groupdesc where itenantid=12;

INSERT INTO ui.grouptotaskfiltermap( iposition, igroupid, itaskfilterid)
 SELECT 4, igroupid, 4
 FROM ui.groupdesc where itenantid=12;

INSERT INTO ui.grouptotaskfiltermap( iposition, igroupid, itaskfilterid)
 SELECT 5, igroupid, 5
 FROM ui.groupdesc where itenantid=12;

 INSERT INTO ui.grouptotaskfiltermap( iposition, igroupid, itaskfilterid)
 SELECT 6, igroupid, 6
 FROM ui.groupdesc  where itenantid=12;

 INSERT INTO ui.grouptotaskfiltermap( iposition, igroupid, itaskfilterid)
 SELECT 7, igroupid, 7
 FROM ui.groupdesc  where itenantid=12;

 INSERT INTO ui.grouptotaskfiltermap( iposition, igroupid, itaskfilterid)
 SELECT 8, igroupid, 8
 FROM ui.groupdesc  where itenantid=12;

 INSERT INTO ui.grouptotaskfiltermap( iposition, igroupid, itaskfilterid)
 SELECT 9, igroupid,9
 FROM ui.groupdesc where itenantid=12;

 ---map users to group
 INSERT INTO ui.webusermapping (mappingid, mappingtype, webuserid) VALUES (2057,
'Group', (select iuserid from ui.webuser where vcusername='cadmin@jfs-jpb.com'));

INSERT INTO ui.webusermapping (mappingid, mappingtype, webuserid) VALUES (2057,
'Group', (select iuserid from ui.webuser where vcusername='madmin@jfs-jpb.com'));

--case management access
insert into ui.rolemenuaccessmap 
(badd, bapprove, bdelete, bedit, bpublish, bview, istatus, imenuid, iroleid)
select true, true, true, true, true, true, true, imenuid, 26 from
ui.menustructuredesc where imenuid = (select imenuid from ui.menustructuredesc
where vcmenuname='Case Management');

insert into ui.rolemenuaccessmap 
(badd, bapprove, bdelete, bedit, bpublish, bview, istatus, imenuid, iroleid)
select true, true, true, true, true, true, true, imenuid, 26 from
ui.menustructuredesc where iparentmenu = (select imenuid from ui.menustructuredesc
where vcmenuname='Case Management') and vcmenuname != 'Upload Chargeback' and vcmenuname !='Create Manual Ticket';

--associate jpb workflow with tenant
update ui.workflowmasters set itenantid = 12 where workflowid=19;

--------Case management setup for JPSL workflows
--risk supervisor group for jpsl workflows
INSERT into ui.groupdesc(igroupid, vcgroupid, vcgroupname, vcgrouptype, istatus, itenantid) VALUES (
'2058'::integer, 'risksupervisor'::character varying, 'Risk Supervisor'::character varying, 'WORKFLOW'::character varying, '1'::integer, '14'::integer)
 returning igroupid;

INSERT into ui.groupdesc(igroupid, vcgroupid, vcgroupname, vcgrouptype, istatus, itenantid) VALUES (
'2059'::integer, 'level1'::character varying, 'L1'::character varying, 'WORKFLOW'::character varying, '1'::integer, '14'::integer)
 returning igroupid;

 INSERT into ui.groupdesc(igroupid, vcgroupid, vcgroupname, vcgrouptype, istatus, itenantid) VALUES (
'2060'::integer, 'level2'::character varying, 'L2'::character varying, 'WORKFLOW'::character varying, '1'::integer, '14'::integer)
 returning igroupid;

 INSERT into ui.groupdesc(igroupid, vcgroupid, vcgroupname, vcgrouptype, istatus, itenantid) VALUES (
'2061'::integer, 'level3'::character varying, 'L3'::character varying, 'WORKFLOW'::character varying, '1'::integer, '14'::integer)
 returning igroupid;

---panel access map for jpslrisky workflow
insert into ui.panelaccessmap (panelaccessmap, panelid, groupid, workflowid) VALUES ((select max(panelaccessmap)+1 from ui.panelaccessmap), 1, 2042, 18);
insert into ui.panelaccessmap (panelaccessmap, panelid, groupid, workflowid) VALUES ((select max(panelaccessmap)+1 from ui.panelaccessmap), 2, 2042, 18);
insert into ui.panelaccessmap (panelaccessmap, panelid, groupid, workflowid) VALUES ((select max(panelaccessmap)+1 from ui.panelaccessmap), 3, 2042, 18);
insert into ui.panelaccessmap (panelaccessmap, panelid, groupid, workflowid) VALUES ((select max(panelaccessmap)+1 from ui.panelaccessmap), 4, 2042, 18);
insert into ui.panelaccessmap (panelaccessmap, panelid, groupid, workflowid) VALUES ((select max(panelaccessmap)+1 from ui.panelaccessmap), 5, 2042, 18);
insert into ui.panelaccessmap (panelaccessmap, panelid, groupid, workflowid) VALUES ((select max(panelaccessmap)+1 from ui.panelaccessmap), 1, 2058, 18);
insert into ui.panelaccessmap (panelaccessmap, panelid, groupid, workflowid) VALUES ((select max(panelaccessmap)+1 from ui.panelaccessmap), 2, 2058, 18);
insert into ui.panelaccessmap (panelaccessmap, panelid, groupid, workflowid) VALUES ((select max(panelaccessmap)+1 from ui.panelaccessmap), 3, 2058, 18);
insert into ui.panelaccessmap (panelaccessmap, panelid, groupid, workflowid) VALUES ((select max(panelaccessmap)+1 from ui.panelaccessmap), 4, 2058, 18);
insert into ui.panelaccessmap (panelaccessmap, panelid, groupid, workflowid) VALUES ((select max(panelaccessmap)+1 from ui.panelaccessmap), 5, 2058, 18);

insert into ui.panelaccessmap (panelaccessmap, panelid, groupid, workflowid) VALUES ((select max(panelaccessmap)+1 from ui.panelaccessmap), 1, 2059, 20);
insert into ui.panelaccessmap (panelaccessmap, panelid, groupid, workflowid) VALUES ((select max(panelaccessmap)+1 from ui.panelaccessmap), 3, 2059, 20);
insert into ui.panelaccessmap (panelaccessmap, panelid, groupid, workflowid) VALUES ((select max(panelaccessmap)+1 from ui.panelaccessmap), 5, 2059, 20);
insert into ui.panelaccessmap (panelaccessmap, panelid, groupid, workflowid) VALUES ((select max(panelaccessmap)+1 from ui.panelaccessmap), 1, 2060, 20);
insert into ui.panelaccessmap (panelaccessmap, panelid, groupid, workflowid) VALUES ((select max(panelaccessmap)+1 from ui.panelaccessmap), 3, 2060, 20);
insert into ui.panelaccessmap (panelaccessmap, panelid, groupid, workflowid) VALUES ((select max(panelaccessmap)+1 from ui.panelaccessmap), 5, 2060, 20);
insert into ui.panelaccessmap (panelaccessmap, panelid, groupid, workflowid) VALUES ((select max(panelaccessmap)+1 from ui.panelaccessmap), 1, 2061, 20);
insert into ui.panelaccessmap (panelaccessmap, panelid, groupid, workflowid) VALUES ((select max(panelaccessmap)+1 from ui.panelaccessmap), 3, 2061, 20);
insert into ui.panelaccessmap (panelaccessmap, panelid, groupid, workflowid) VALUES ((select max(panelaccessmap)+1 from ui.panelaccessmap), 5, 2061, 20);

----group to task filter map
INSERT INTO ui.grouptotaskfiltermap( iposition, igroupid, itaskfilterid)
 SELECT 1, igroupid, 1
 FROM ui.groupdesc where itenantid=14;

INSERT INTO ui.grouptotaskfiltermap( iposition, igroupid, itaskfilterid)
 SELECT 2, igroupid, 2
 FROM ui.groupdesc where itenantid=14;

INSERT INTO ui.grouptotaskfiltermap( iposition, igroupid, itaskfilterid)
 SELECT 3, igroupid, 3
 FROM ui.groupdesc where itenantid=14;

INSERT INTO ui.grouptotaskfiltermap( iposition, igroupid, itaskfilterid)
 SELECT 4, igroupid, 4
 FROM ui.groupdesc where itenantid=14;

INSERT INTO ui.grouptotaskfiltermap( iposition, igroupid, itaskfilterid)
 SELECT 5, igroupid, 5
 FROM ui.groupdesc where itenantid=14;

 INSERT INTO ui.grouptotaskfiltermap( iposition, igroupid, itaskfilterid)
 SELECT 6, igroupid, 6
 FROM ui.groupdesc  where itenantid=14;

 INSERT INTO ui.grouptotaskfiltermap( iposition, igroupid, itaskfilterid)
 SELECT 7, igroupid, 7
 FROM ui.groupdesc  where itenantid=14;

 INSERT INTO ui.grouptotaskfiltermap( iposition, igroupid, itaskfilterid)
 SELECT 8, igroupid, 8
 FROM ui.groupdesc  where itenantid=14;

 INSERT INTO ui.grouptotaskfiltermap( iposition, igroupid, itaskfilterid)
 SELECT 9, igroupid,9
 FROM ui.groupdesc where itenantid=14;

 ---map users to group
 INSERT INTO ui.webusermapping (mappingid, mappingtype, webuserid) VALUES (2058,
'Group', (select iuserid from ui.webuser where vcusername='cadmin@jfs-jpsl.com'));

 INSERT INTO ui.webusermapping (mappingid, mappingtype, webuserid) VALUES (2059,
'Group', (select iuserid from ui.webuser where vcusername='cadmin@jfs-jpsl.com'));

 INSERT INTO ui.webusermapping (mappingid, mappingtype, webuserid) VALUES (2060,
'Group', (select iuserid from ui.webuser where vcusername='cadmin@jfs-jpsl.com'));

 INSERT INTO ui.webusermapping (mappingid, mappingtype, webuserid) VALUES (2061,
'Group', (select iuserid from ui.webuser where vcusername='cadmin@jfs-jpsl.com'));

INSERT INTO ui.webusermapping (mappingid, mappingtype, webuserid) VALUES (2058,
'Group', (select iuserid from ui.webuser where vcusername='madmin@jfs-jpsl.com'));

 INSERT INTO ui.webusermapping (mappingid, mappingtype, webuserid) VALUES (2059,
'Group', (select iuserid from ui.webuser where vcusername='madmin@jfs-jpsl.com'));

 INSERT INTO ui.webusermapping (mappingid, mappingtype, webuserid) VALUES (2060,
'Group', (select iuserid from ui.webuser where vcusername='madmin@jfs-jpsl.com'));

 INSERT INTO ui.webusermapping (mappingid, mappingtype, webuserid) VALUES (2061,
'Group', (select iuserid from ui.webuser where vcusername='madmin@jfs-jpsl.com'));

--case management access
insert into ui.rolemenuaccessmap 
(badd, bapprove, bdelete, bedit, bpublish, bview, istatus, imenuid, iroleid)
select true, true, true, true, true, true, true, imenuid, 28 from
ui.menustructuredesc where imenuid = (select imenuid from ui.menustructuredesc
where vcmenuname='Case Management');

insert into ui.rolemenuaccessmap 
(badd, bapprove, bdelete, bedit, bpublish, bview, istatus, imenuid, iroleid)
select true, true, true, true, true, true, true, imenuid, 28 from
ui.menustructuredesc where iparentmenu = (select imenuid from ui.menustructuredesc
where vcmenuname='Case Management') and vcmenuname != 'Upload Chargeback' and vcmenuname !='Create Manual Ticket';

--associate jpb workflow with tenant
update ui.workflowmasters set itenantid = 14 where workflowid=18 or workflowid=20;

---map user to workflows
INSERT INTO ui.webusermapping (mappingid, mappingtype, webuserid) VALUES (-1,
'Workflow', (select iuserid from ui.webuser where vcusername='madmin@jfs-jpsl.com'));
INSERT INTO ui.webusermapping (mappingid, mappingtype, webuserid) VALUES (-1,
'Workflow', (select iuserid from ui.webuser where vcusername='cadmin@jfs-jpsl.com'));
INSERT INTO ui.webusermapping (mappingid, mappingtype, webuserid) VALUES (-1,
'Workflow', (select iuserid from ui.webuser where vcusername='cadmin@jfs-jpb.com'));
INSERT INTO ui.webusermapping (mappingid, mappingtype, webuserid) VALUES (-1,
'Workflow', (select iuserid from ui.webuser where vcusername='madmin@jfs-jpb.com'));





