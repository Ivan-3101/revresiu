---Workflow Masters setup

--42C
update ui.workflowmasters  set itenantid=6 where workflowid=13;
update ui.workflowmasters  set itenantid=7 where workflowid=14;

--YBAML
update ui.workflowmasters  set itenantid=8 where workflowid=4 or workflowid=5 or workflowid=17;

--YBFRM
update ui.workflowmasters  set itenantid=9 where workflowid=6 or workflowid=12;

--Pinelabs
update ui.workflowmasters  set itenantid=10 where workflowid=16;

---Groups for Workflows
--42c
INSERT INTO ui.groupdesc (
igroupid, vcgroupid, vcgroupname, vcgrouptype, istatus, itenantid) VALUES (
'2044'::integer, 'CUBAnalyst'::character varying, 'CUB Analyst'::character varying, 'WORKFLOW'::character varying, '1'::integer, '6'::integer)
 returning igroupid;

INSERT INTO ui.groupdesc (
igroupid, vcgroupid, vcgroupname, vcgrouptype, istatus, itenantid) VALUES (
'2045'::integer, 'USFBAnalyst'::character varying, 'USFB Analyst'::character varying, 'WORKFLOW'::character varying, '1'::integer, '7'::integer)
 returning igroupid;

--ybaml
UPDATE ui.groupdesc set vcgroupname='L1', vcgroupid='level1' where igroupid=2036;
INSERT INTO ui.groupdesc (
igroupid, vcgroupid, vcgroupname, vcgrouptype, istatus, itenantid) VALUES (
'2046'::integer, 'level2'::character varying, 'L2'::character varying, 'WORKFLOW'::character varying, '1'::integer, '8'::integer)
 returning igroupid;
 INSERT INTO ui.groupdesc (
igroupid, vcgroupid, vcgroupname, vcgrouptype, istatus, itenantid) VALUES (
'2047'::integer, 'level3'::character varying, 'L3'::character varying, 'WORKFLOW'::character varying, '1'::integer, '8'::integer)
 returning igroupid;
 INSERT INTO ui.groupdesc (
igroupid, vcgroupid, vcgroupname, vcgrouptype, istatus, itenantid) VALUES (
'2048'::integer, 'level4'::character varying, 'L4'::character varying, 'WORKFLOW'::character varying, '1'::integer, '8'::integer)
 returning igroupid;
 INSERT INTO ui.groupdesc (
igroupid, vcgroupid, vcgroupname, vcgrouptype, istatus, itenantid) VALUES (
'2049'::integer, 'level5'::character varying, 'L5'::character varying, 'WORKFLOW'::character varying, '1'::integer, '8'::integer)
 returning igroupid;
 INSERT INTO ui.groupdesc (
igroupid, vcgroupid, vcgroupname, vcgrouptype, istatus, itenantid) VALUES (
'2050'::integer, 'it'::character varying, 'IT'::character varying, 'WORKFLOW'::character varying, '1'::integer, '8'::integer)
 returning igroupid;
 INSERT INTO ui.groupdesc (
igroupid, vcgroupid, vcgroupname, vcgrouptype, istatus, itenantid) VALUES (
'2051'::integer, 'qc'::character varying, 'QC'::character varying, 'WORKFLOW'::character varying, '1'::integer, '8'::integer)
 returning igroupid;
 INSERT INTO ui.groupdesc (
igroupid, vcgroupid, vcgroupname, vcgrouptype, istatus, itenantid) VALUES (
'2052'::integer, 'branch'::character varying, 'Branch'::character varying, 'WORKFLOW'::character varying, '1'::integer, '8'::integer)
 returning igroupid;
 INSERT INTO ui.groupdesc (
igroupid, vcgroupid, vcgroupname, vcgrouptype, istatus, itenantid) VALUES (
'2053'::integer, 'db'::character varying, 'DB'::character varying, 'WORKFLOW'::character varying, '1'::integer, '8'::integer)
 returning igroupid;

 --ybfrm
 INSERT INTO ui.groupdesc (
igroupid, vcgroupid, vcgroupname, vcgrouptype, istatus, itenantid) VALUES (
'2054'::integer, 'risksupervisor'::character varying, 'Risk Supervisor'::character varying, 'WORKFLOW'::character varying, '1'::integer, '9'::integer)
 returning igroupid;

--pinelabs
UPDATE ui.groupdesc set vcgroupname='L1', vcgroupid='level1' where igroupid=2038;
INSERT into ui.groupdesc(igroupid, vcgroupid, vcgroupname, vcgrouptype, istatus, itenantid) VALUES (
'2055'::integer, 'level2'::character varying, 'L2'::character varying, 'WORKFLOW'::character varying, '1'::integer, '10'::integer)
 returning igroupid;
 INSERT into ui.groupdesc(igroupid, vcgroupid, vcgroupname, vcgrouptype, istatus, itenantid) VALUES (
'2056'::integer, 'level3'::character varying, 'L3'::character varying, 'WORKFLOW'::character varying, '1'::integer, '10'::integer)
 returning igroupid;

-----Panel access map
--setup panel access map for 42c
insert into ui.panelaccessmap (panelaccessmap, panelid, groupid, workflowid) VALUES ((select max(panelaccessmap)+1 from ui.panelaccessmap), 1, 2034, 13);
insert into ui.panelaccessmap (panelaccessmap, panelid, groupid, workflowid) VALUES ((select max(panelaccessmap)+1 from ui.panelaccessmap), 2, 2034, 13);
insert into ui.panelaccessmap (panelaccessmap, panelid, groupid, workflowid) VALUES ((select max(panelaccessmap)+1 from ui.panelaccessmap), 3, 2034, 13);
insert into ui.panelaccessmap (panelaccessmap, panelid, groupid, workflowid) VALUES ((select max(panelaccessmap)+1 from ui.panelaccessmap), 4, 2034, 13);
insert into ui.panelaccessmap (panelaccessmap, panelid, groupid, workflowid) VALUES ((select max(panelaccessmap)+1 from ui.panelaccessmap), 5, 2034, 13);

insert into ui.panelaccessmap (panelaccessmap, panelid, groupid, workflowid) VALUES ((select max(panelaccessmap)+1 from ui.panelaccessmap), 1, 2044, 13);
insert into ui.panelaccessmap (panelaccessmap, panelid, groupid, workflowid) VALUES ((select max(panelaccessmap)+1 from ui.panelaccessmap), 2, 2044, 13);
insert into ui.panelaccessmap (panelaccessmap, panelid, groupid, workflowid) VALUES ((select max(panelaccessmap)+1 from ui.panelaccessmap), 3, 2044, 13);
insert into ui.panelaccessmap (panelaccessmap, panelid, groupid, workflowid) VALUES ((select max(panelaccessmap)+1 from ui.panelaccessmap), 4, 2044, 13);
insert into ui.panelaccessmap (panelaccessmap, panelid, groupid, workflowid) VALUES ((select max(panelaccessmap)+1 from ui.panelaccessmap), 5, 2044, 13);

insert into ui.panelaccessmap (panelaccessmap, panelid, groupid, workflowid) VALUES ((select max(panelaccessmap)+1 from ui.panelaccessmap), 1, 2035, 14);
insert into ui.panelaccessmap (panelaccessmap, panelid, groupid, workflowid) VALUES ((select max(panelaccessmap)+1 from ui.panelaccessmap), 2, 2035, 14);
insert into ui.panelaccessmap (panelaccessmap, panelid, groupid, workflowid) VALUES ((select max(panelaccessmap)+1 from ui.panelaccessmap), 3, 2035, 14);
insert into ui.panelaccessmap (panelaccessmap, panelid, groupid, workflowid) VALUES ((select max(panelaccessmap)+1 from ui.panelaccessmap), 4, 2035, 14);
insert into ui.panelaccessmap (panelaccessmap, panelid, groupid, workflowid) VALUES ((select max(panelaccessmap)+1 from ui.panelaccessmap), 5, 2035, 14);

insert into ui.panelaccessmap (panelaccessmap, panelid, groupid, workflowid) VALUES ((select max(panelaccessmap)+1 from ui.panelaccessmap), 1, 2045, 14);
insert into ui.panelaccessmap (panelaccessmap, panelid, groupid, workflowid) VALUES ((select max(panelaccessmap)+1 from ui.panelaccessmap), 2, 2045, 14);
insert into ui.panelaccessmap (panelaccessmap, panelid, groupid, workflowid) VALUES ((select max(panelaccessmap)+1 from ui.panelaccessmap), 3, 2045, 14);
insert into ui.panelaccessmap (panelaccessmap, panelid, groupid, workflowid) VALUES ((select max(panelaccessmap)+1 from ui.panelaccessmap), 4, 2045, 14);
insert into ui.panelaccessmap (panelaccessmap, panelid, groupid, workflowid) VALUES ((select max(panelaccessmap)+1 from ui.panelaccessmap), 5, 2045, 14);

---setup panel access map for ybaml
insert into ui.panelaccessmap (panelaccessmap, panelid, groupid, workflowid) VALUES ((select max(panelaccessmap)+1 from ui.panelaccessmap), 1, 2036, 4);
insert into ui.panelaccessmap (panelaccessmap, panelid, groupid, workflowid) VALUES ((select max(panelaccessmap)+1 from ui.panelaccessmap), 3, 2036, 4);
insert into ui.panelaccessmap (panelaccessmap, panelid, groupid, workflowid) VALUES ((select max(panelaccessmap)+1 from ui.panelaccessmap), 4, 2036, 4);
insert into ui.panelaccessmap (panelaccessmap, panelid, groupid, workflowid) VALUES ((select max(panelaccessmap)+1 from ui.panelaccessmap), 5, 2036, 4);

insert into ui.panelaccessmap (panelaccessmap, panelid, groupid, workflowid) VALUES ((select max(panelaccessmap)+1 from ui.panelaccessmap), 1, 2046, 4);
insert into ui.panelaccessmap (panelaccessmap, panelid, groupid, workflowid) VALUES ((select max(panelaccessmap)+1 from ui.panelaccessmap), 3, 2046, 4);
insert into ui.panelaccessmap (panelaccessmap, panelid, groupid, workflowid) VALUES ((select max(panelaccessmap)+1 from ui.panelaccessmap), 4, 2046, 4);
insert into ui.panelaccessmap (panelaccessmap, panelid, groupid, workflowid) VALUES ((select max(panelaccessmap)+1 from ui.panelaccessmap), 5, 2046, 4);

insert into ui.panelaccessmap (panelaccessmap, panelid, groupid, workflowid) VALUES ((select max(panelaccessmap)+1 from ui.panelaccessmap), 1, 2047, 4);
insert into ui.panelaccessmap (panelaccessmap, panelid, groupid, workflowid) VALUES ((select max(panelaccessmap)+1 from ui.panelaccessmap), 3, 2047, 4);
insert into ui.panelaccessmap (panelaccessmap, panelid, groupid, workflowid) VALUES ((select max(panelaccessmap)+1 from ui.panelaccessmap), 4, 2047, 4);
insert into ui.panelaccessmap (panelaccessmap, panelid, groupid, workflowid) VALUES ((select max(panelaccessmap)+1 from ui.panelaccessmap), 5, 2047, 4);

insert into ui.panelaccessmap (panelaccessmap, panelid, groupid, workflowid) VALUES ((select max(panelaccessmap)+1 from ui.panelaccessmap), 1, 2048, 4);
insert into ui.panelaccessmap (panelaccessmap, panelid, groupid, workflowid) VALUES ((select max(panelaccessmap)+1 from ui.panelaccessmap), 3, 2048, 4);
insert into ui.panelaccessmap (panelaccessmap, panelid, groupid, workflowid) VALUES ((select max(panelaccessmap)+1 from ui.panelaccessmap), 4, 2048, 4);
insert into ui.panelaccessmap (panelaccessmap, panelid, groupid, workflowid) VALUES ((select max(panelaccessmap)+1 from ui.panelaccessmap), 5, 2048, 4);

insert into ui.panelaccessmap (panelaccessmap, panelid, groupid, workflowid) VALUES ((select max(panelaccessmap)+1 from ui.panelaccessmap), 1, 2049, 4);
insert into ui.panelaccessmap (panelaccessmap, panelid, groupid, workflowid) VALUES ((select max(panelaccessmap)+1 from ui.panelaccessmap), 3, 2049, 4);
insert into ui.panelaccessmap (panelaccessmap, panelid, groupid, workflowid) VALUES ((select max(panelaccessmap)+1 from ui.panelaccessmap), 4, 2049, 4);
insert into ui.panelaccessmap (panelaccessmap, panelid, groupid, workflowid) VALUES ((select max(panelaccessmap)+1 from ui.panelaccessmap), 5, 2049, 4);

insert into ui.panelaccessmap (panelaccessmap, panelid, groupid, workflowid) VALUES ((select max(panelaccessmap)+1 from ui.panelaccessmap), 1, 2050, 4);
insert into ui.panelaccessmap (panelaccessmap, panelid, groupid, workflowid) VALUES ((select max(panelaccessmap)+1 from ui.panelaccessmap), 3, 2050, 4);
insert into ui.panelaccessmap (panelaccessmap, panelid, groupid, workflowid) VALUES ((select max(panelaccessmap)+1 from ui.panelaccessmap), 4, 2050, 4);
insert into ui.panelaccessmap (panelaccessmap, panelid, groupid, workflowid) VALUES ((select max(panelaccessmap)+1 from ui.panelaccessmap), 5, 2050, 4);

insert into ui.panelaccessmap (panelaccessmap, panelid, groupid, workflowid) VALUES ((select max(panelaccessmap)+1 from ui.panelaccessmap), 1, 2052, 4);
insert into ui.panelaccessmap (panelaccessmap, panelid, groupid, workflowid) VALUES ((select max(panelaccessmap)+1 from ui.panelaccessmap), 3, 2052, 4);
insert into ui.panelaccessmap (panelaccessmap, panelid, groupid, workflowid) VALUES ((select max(panelaccessmap)+1 from ui.panelaccessmap), 4, 2052, 4);
insert into ui.panelaccessmap (panelaccessmap, panelid, groupid, workflowid) VALUES ((select max(panelaccessmap)+1 from ui.panelaccessmap), 5, 2052, 4);

insert into ui.panelaccessmap (panelaccessmap, panelid, groupid, workflowid) VALUES ((select max(panelaccessmap)+1 from ui.panelaccessmap), 1, 2053, 4);
insert into ui.panelaccessmap (panelaccessmap, panelid, groupid, workflowid) VALUES ((select max(panelaccessmap)+1 from ui.panelaccessmap), 3, 2053, 4);
insert into ui.panelaccessmap (panelaccessmap, panelid, groupid, workflowid) VALUES ((select max(panelaccessmap)+1 from ui.panelaccessmap), 4, 2053, 4);
insert into ui.panelaccessmap (panelaccessmap, panelid, groupid, workflowid) VALUES ((select max(panelaccessmap)+1 from ui.panelaccessmap), 5, 2053, 4);

insert into ui.panelaccessmap (panelaccessmap, panelid, groupid, workflowid) VALUES ((select max(panelaccessmap)+1 from ui.panelaccessmap), 1, 2051, 5);
insert into ui.panelaccessmap (panelaccessmap, panelid, groupid, workflowid) VALUES ((select max(panelaccessmap)+1 from ui.panelaccessmap), 3, 2051, 5);
insert into ui.panelaccessmap (panelaccessmap, panelid, groupid, workflowid) VALUES ((select max(panelaccessmap)+1 from ui.panelaccessmap), 4, 2051, 5);
insert into ui.panelaccessmap (panelaccessmap, panelid, groupid, workflowid) VALUES ((select max(panelaccessmap)+1 from ui.panelaccessmap), 5, 2051, 5);

---setup panel access map for ybfrm
insert into ui.panelaccessmap (panelaccessmap, panelid, groupid, workflowid) VALUES ((select max(panelaccessmap)+1 from ui.panelaccessmap), 1, 2037, 6);
insert into ui.panelaccessmap (panelaccessmap, panelid, groupid, workflowid) VALUES ((select max(panelaccessmap)+1 from ui.panelaccessmap), 2, 2037, 6);
insert into ui.panelaccessmap (panelaccessmap, panelid, groupid, workflowid) VALUES ((select max(panelaccessmap)+1 from ui.panelaccessmap), 3, 2037, 6);
insert into ui.panelaccessmap (panelaccessmap, panelid, groupid, workflowid) VALUES ((select max(panelaccessmap)+1 from ui.panelaccessmap), 4, 2037, 6);
insert into ui.panelaccessmap (panelaccessmap, panelid, groupid, workflowid) VALUES ((select max(panelaccessmap)+1 from ui.panelaccessmap), 5, 2037, 6);

insert into ui.panelaccessmap (panelaccessmap, panelid, groupid, workflowid) VALUES ((select max(panelaccessmap)+1 from ui.panelaccessmap), 1, 2054, 12);
insert into ui.panelaccessmap (panelaccessmap, panelid, groupid, workflowid) VALUES ((select max(panelaccessmap)+1 from ui.panelaccessmap), 2, 2054, 12);
insert into ui.panelaccessmap (panelaccessmap, panelid, groupid, workflowid) VALUES ((select max(panelaccessmap)+1 from ui.panelaccessmap), 3, 2054, 12);
insert into ui.panelaccessmap (panelaccessmap, panelid, groupid, workflowid) VALUES ((select max(panelaccessmap)+1 from ui.panelaccessmap), 4, 2054, 12);
insert into ui.panelaccessmap (panelaccessmap, panelid, groupid, workflowid) VALUES ((select max(panelaccessmap)+1 from ui.panelaccessmap), 5, 2054, 12);

--setup panel access map for pinelabs
insert into ui.panelaccessmap (panelaccessmap, panelid, groupid, workflowid) VALUES ((select max(panelaccessmap)+1 from ui.panelaccessmap), 1, 2038, 16);
insert into ui.panelaccessmap (panelaccessmap, panelid, groupid, workflowid) VALUES ((select max(panelaccessmap)+1 from ui.panelaccessmap), 2, 2038, 16);
insert into ui.panelaccessmap (panelaccessmap, panelid, groupid, workflowid) VALUES ((select max(panelaccessmap)+1 from ui.panelaccessmap), 3, 2038, 16);
insert into ui.panelaccessmap (panelaccessmap, panelid, groupid, workflowid) VALUES ((select max(panelaccessmap)+1 from ui.panelaccessmap), 4, 2038, 16);
insert into ui.panelaccessmap (panelaccessmap, panelid, groupid, workflowid) VALUES ((select max(panelaccessmap)+1 from ui.panelaccessmap), 5, 2038, 16);
insert into ui.panelaccessmap (panelaccessmap, panelid, groupid, workflowid) VALUES ((select max(panelaccessmap)+1 from ui.panelaccessmap), 6, 2038, 16);

insert into ui.panelaccessmap (panelaccessmap, panelid, groupid, workflowid) VALUES ((select max(panelaccessmap)+1 from ui.panelaccessmap), 1, 2055, 16);
insert into ui.panelaccessmap (panelaccessmap, panelid, groupid, workflowid) VALUES ((select max(panelaccessmap)+1 from ui.panelaccessmap), 2, 2055, 16);
insert into ui.panelaccessmap (panelaccessmap, panelid, groupid, workflowid) VALUES ((select max(panelaccessmap)+1 from ui.panelaccessmap), 3, 2055, 16);
insert into ui.panelaccessmap (panelaccessmap, panelid, groupid, workflowid) VALUES ((select max(panelaccessmap)+1 from ui.panelaccessmap), 4, 2055, 16);
insert into ui.panelaccessmap (panelaccessmap, panelid, groupid, workflowid) VALUES ((select max(panelaccessmap)+1 from ui.panelaccessmap), 5, 2055, 16);
insert into ui.panelaccessmap (panelaccessmap, panelid, groupid, workflowid) VALUES ((select max(panelaccessmap)+1 from ui.panelaccessmap), 6, 2055, 16);

--setup group to task filter map
---group access for 42c, ybaml, ybfrm, pinelabs
INSERT INTO ui.grouptotaskfiltermap( iposition, igroupid, itaskfilterid)
 SELECT 1, igroupid, 1
 FROM ui.groupdesc where itenantid >= 6 and itenantid <=10;

INSERT INTO ui.grouptotaskfiltermap( iposition, igroupid, itaskfilterid)
 SELECT 2, igroupid, 2
 FROM ui.groupdesc where itenantid >= 6 and itenantid <=10;

INSERT INTO ui.grouptotaskfiltermap( iposition, igroupid, itaskfilterid)
 SELECT 3, igroupid, 3
 FROM ui.groupdesc where itenantid >= 6 and itenantid <=10;

INSERT INTO ui.grouptotaskfiltermap( iposition, igroupid, itaskfilterid)
 SELECT 4, igroupid, 4
 FROM ui.groupdesc where itenantid >= 6 and itenantid <=10;

INSERT INTO ui.grouptotaskfiltermap( iposition, igroupid, itaskfilterid)
 SELECT 5, igroupid, 5
 FROM ui.groupdesc where itenantid >= 6 and itenantid <=10;

 INSERT INTO ui.grouptotaskfiltermap( iposition, igroupid, itaskfilterid)
 SELECT 6, igroupid, 6
 FROM ui.groupdesc  where itenantid >= 6 and itenantid <=10;

 INSERT INTO ui.grouptotaskfiltermap( iposition, igroupid, itaskfilterid)
 SELECT 7, igroupid, 7
 FROM ui.groupdesc  where itenantid >= 6 and itenantid <=10;

 INSERT INTO ui.grouptotaskfiltermap( iposition, igroupid, itaskfilterid)
 SELECT 8, igroupid, 8
 FROM ui.groupdesc  where itenantid >= 6 and itenantid <=10;

 INSERT INTO ui.grouptotaskfiltermap( iposition, igroupid, itaskfilterid)
 SELECT 9, igroupid,9
 FROM ui.groupdesc where itenantid >= 6 and itenantid <=10;

 INSERT INTO ui.grouptotaskfiltermap( iposition, igroupid, itaskfilterid)
 SELECT 10, igroupid, 10
 FROM ui.groupdesc
 where vcgroupid in ('level1', 'level2',
 				   'level3', 'level4', 'level5'
 				  , 'db','branch','it') and itenantid=8;

---Role menu access map for case management 

insert into ui.rolemenuaccessmap 
(badd, bapprove, bdelete, bedit, bpublish, bview, istatus, imenuid, iroleid)
select true, true, true, true, true, true, true, imenuid, 20 from
ui.menustructuredesc where imenuid = (select imenuid from ui.menustructuredesc
where vcmenuname='Case Management');

insert into ui.rolemenuaccessmap 
(badd, bapprove, bdelete, bedit, bpublish, bview, istatus, imenuid, iroleid)
select true, true, true, true, true, true, true, imenuid, 20 from
ui.menustructuredesc where iparentmenu = (select imenuid from ui.menustructuredesc
where vcmenuname='Case Management') and vcmenuname != 'Upload Chargeback' and vcmenuname !='Create Manual Ticket';

insert into ui.rolemenuaccessmap 
(badd, bapprove, bdelete, bedit, bpublish, bview, istatus, imenuid, iroleid)
select true, true, true, true, true, true, true, imenuid, 21 from
ui.menustructuredesc where imenuid = (select imenuid from ui.menustructuredesc
where vcmenuname='Case Management');

insert into ui.rolemenuaccessmap 
(badd, bapprove, bdelete, bedit, bpublish, bview, istatus, imenuid, iroleid)
select true, true, true, true, true, true, true, imenuid, 21 from
ui.menustructuredesc where iparentmenu = (select imenuid from ui.menustructuredesc
where vcmenuname='Case Management') and vcmenuname != 'Upload Chargeback' and vcmenuname !='Create Manual Ticket';

insert into ui.rolemenuaccessmap 
(badd, bapprove, bdelete, bedit, bpublish, bview, istatus, imenuid, iroleid)
select true, true, true, true, true, true, true, imenuid, 22 from
ui.menustructuredesc where imenuid = (select imenuid from ui.menustructuredesc
where vcmenuname='Case Management');

insert into ui.rolemenuaccessmap 
(badd, bapprove, bdelete, bedit, bpublish, bview, istatus, imenuid, iroleid)
select true, true, true, true, true, true, true, imenuid, 22 from
ui.menustructuredesc where iparentmenu = (select imenuid from ui.menustructuredesc
where vcmenuname='Case Management') and vcmenuname !='Upload Chargeback';

insert into ui.rolemenuaccessmap 
(badd, bapprove, bdelete, bedit, bpublish, bview, istatus, imenuid, iroleid)
select true, true, true, true, true, true, true, imenuid, 23 from
ui.menustructuredesc where imenuid = (select imenuid from ui.menustructuredesc
where vcmenuname='Case Management');

insert into ui.rolemenuaccessmap 
(badd, bapprove, bdelete, bedit, bpublish, bview, istatus, imenuid, iroleid)
select true, true, true, true, true, true, true, imenuid, 23 from
ui.menustructuredesc where iparentmenu = (select imenuid from ui.menustructuredesc
where vcmenuname='Case Management') and vcmenuname != 'Upload Chargeback' and vcmenuname !='Create Manual Ticket';

insert into ui.rolemenuaccessmap 
(badd, bapprove, bdelete, bedit, bpublish, bview, istatus, imenuid, iroleid)
select true, true, true, true, true, true, true, imenuid, 24 from
ui.menustructuredesc where imenuid = (select imenuid from ui.menustructuredesc
where vcmenuname='Case Management');

insert into ui.rolemenuaccessmap 
(badd, bapprove, bdelete, bedit, bpublish, bview, istatus, imenuid, iroleid)
select true, true, true, true, true, true, true, imenuid, 24 from
ui.menustructuredesc where iparentmenu = (select imenuid from ui.menustructuredesc
where vcmenuname='Case Management') and vcmenuname != 'Upload Chargeback';

----delete from rolemenuaccessp Dashboard menu
delete from ui.rolemenuaccessmap where imenuid=493;

---give access for users to workflows
INSERT INTO ui.webusermapping (mappingid, mappingtype, webuserid) VALUES (-1,
'Workflow', (select iuserid from ui.webuser where vcusername='cadmin@42c.com'));

INSERT INTO ui.webusermapping (mappingid, mappingtype, webuserid) VALUES (-1,
'Workflow', (select iuserid from ui.webuser where vcusername='madmin@42c.com'));

INSERT INTO ui.webusermapping (mappingid, mappingtype, webuserid) VALUES (-1,
'Workflow', (select iuserid from ui.webuser where vcusername='cadmin@ybfrm.com'));

INSERT INTO ui.webusermapping (mappingid, mappingtype, webuserid) VALUES (-1,
'Workflow', (select iuserid from ui.webuser where vcusername='madmin@ybfrm.com'));

INSERT INTO ui.webusermapping (mappingid, mappingtype, webuserid) VALUES (-1,
'Workflow', (select iuserid from ui.webuser where vcusername='cadmin@ybaml.com'));

INSERT INTO ui.webusermapping (mappingid, mappingtype, webuserid) VALUES (-1,
'Workflow', (select iuserid from ui.webuser where vcusername='madmin@ybaml.com'));


INSERT INTO ui.webusermapping (mappingid, mappingtype, webuserid) VALUES (-1,
'Workflow', (select iuserid from ui.webuser where vcusername='cadmin@pinelabs.com'));

INSERT INTO ui.webusermapping (mappingid, mappingtype, webuserid) VALUES (-1,
'Workflow', (select iuserid from ui.webuser where vcusername='madmin@pinelabs.com'));

---give access for user to groups other than riskanalyst
INSERT INTO ui.webusermapping (mappingid, mappingtype, webuserid) VALUES (2044,
'Group', (select iuserid from ui.webuser where vcusername='cadmin@42c.com'));

INSERT INTO ui.webusermapping (mappingid, mappingtype, webuserid) VALUES (2035,
'Group', (select iuserid from ui.webuser where vcusername='cadmin@42c.com'));

INSERT INTO ui.webusermapping (mappingid, mappingtype, webuserid) VALUES (2045,
'Group', (select iuserid from ui.webuser where vcusername='cadmin@42c.com'));

INSERT INTO ui.webusermapping (mappingid, mappingtype, webuserid) VALUES (2044,
'Group', (select iuserid from ui.webuser where vcusername='madmin@42c.com'));

INSERT INTO ui.webusermapping (mappingid, mappingtype, webuserid) VALUES (2035,
'Group', (select iuserid from ui.webuser where vcusername='madmin@42c.com'));

INSERT INTO ui.webusermapping (mappingid, mappingtype, webuserid) VALUES (2045,
'Group', (select iuserid from ui.webuser where vcusername='madmin@42c.com'));


INSERT INTO ui.webusermapping (mappingid, mappingtype, webuserid) VALUES (2046,
'Group', (select iuserid from ui.webuser where vcusername='madmin@ybaml.com'));
INSERT INTO ui.webusermapping (mappingid, mappingtype, webuserid) VALUES (2047,
'Group', (select iuserid from ui.webuser where vcusername='madmin@ybaml.com'));
INSERT INTO ui.webusermapping (mappingid, mappingtype, webuserid) VALUES (2048,
'Group', (select iuserid from ui.webuser where vcusername='madmin@ybaml.com'));
INSERT INTO ui.webusermapping (mappingid, mappingtype, webuserid) VALUES (2049,
'Group', (select iuserid from ui.webuser where vcusername='madmin@ybaml.com'));
INSERT INTO ui.webusermapping (mappingid, mappingtype, webuserid) VALUES (2050,
'Group', (select iuserid from ui.webuser where vcusername='madmin@ybaml.com'));
INSERT INTO ui.webusermapping (mappingid, mappingtype, webuserid) VALUES (2051,
'Group', (select iuserid from ui.webuser where vcusername='madmin@ybaml.com'));
INSERT INTO ui.webusermapping (mappingid, mappingtype, webuserid) VALUES (2052,
'Group', (select iuserid from ui.webuser where vcusername='madmin@ybaml.com'));
INSERT INTO ui.webusermapping (mappingid, mappingtype, webuserid) VALUES (2053,
'Group', (select iuserid from ui.webuser where vcusername='madmin@ybaml.com'));


INSERT INTO ui.webusermapping (mappingid, mappingtype, webuserid) VALUES (2046,
'Group', (select iuserid from ui.webuser where vcusername='cadmin@ybaml.com'));
INSERT INTO ui.webusermapping (mappingid, mappingtype, webuserid) VALUES (2047,
'Group', (select iuserid from ui.webuser where vcusername='cadmin@ybaml.com'));
INSERT INTO ui.webusermapping (mappingid, mappingtype, webuserid) VALUES (2048,
'Group', (select iuserid from ui.webuser where vcusername='cadmin@ybaml.com'));
INSERT INTO ui.webusermapping (mappingid, mappingtype, webuserid) VALUES (2049,
'Group', (select iuserid from ui.webuser where vcusername='cadmin@ybaml.com'));
INSERT INTO ui.webusermapping (mappingid, mappingtype, webuserid) VALUES (2050,
'Group', (select iuserid from ui.webuser where vcusername='cadmin@ybaml.com'));
INSERT INTO ui.webusermapping (mappingid, mappingtype, webuserid) VALUES (2051,
'Group', (select iuserid from ui.webuser where vcusername='cadmin@ybaml.com'));
INSERT INTO ui.webusermapping (mappingid, mappingtype, webuserid) VALUES (2052,
'Group', (select iuserid from ui.webuser where vcusername='cadmin@ybaml.com'));
INSERT INTO ui.webusermapping (mappingid, mappingtype, webuserid) VALUES (2053,
'Group', (select iuserid from ui.webuser where vcusername='cadmin@ybaml.com'));


INSERT INTO ui.webusermapping (mappingid, mappingtype, webuserid) VALUES (2054,
'Group', (select iuserid from ui.webuser where vcusername='madmin@ybfrm.com'));
INSERT INTO ui.webusermapping (mappingid, mappingtype, webuserid) VALUES (2054,
'Group', (select iuserid from ui.webuser where vcusername='cadmin@ybfrm.com'));


INSERT INTO ui.webusermapping (mappingid, mappingtype, webuserid) VALUES (2055,
'Group', (select iuserid from ui.webuser where vcusername='madmin@pinelabs.com'));

INSERT INTO ui.webusermapping (mappingid, mappingtype, webuserid) VALUES (2056,
'Group', (select iuserid from ui.webuser where vcusername='madmin@pinelabs.com'));


INSERT INTO ui.webusermapping (mappingid, mappingtype, webuserid) VALUES (2055,
'Group', (select iuserid from ui.webuser where vcusername='cadmin@pinelabs.com'));

INSERT INTO ui.webusermapping (mappingid, mappingtype, webuserid) VALUES (2056,
'Group', (select iuserid from ui.webuser where vcusername='cadmin@pinelabs.com'));

---give access to transaction classes

INSERT INTO ui.webusermapping (mappingid, mappingtype, webuserid) VALUES (-1,
'TransactionClass', (select iuserid from ui.webuser where vcusername='cadmin@epifi.com'));

INSERT INTO ui.webusermapping (mappingid, mappingtype, webuserid) VALUES (-1,
'TransactionClass', (select iuserid from ui.webuser where vcusername='madmin@epifi.com'));

INSERT INTO ui.webusermapping (mappingid, mappingtype, webuserid) VALUES (-1,
'TransactionClass', (select iuserid from ui.webuser where vcusername='cadmin@42c.com'));

INSERT INTO ui.webusermapping (mappingid, mappingtype, webuserid) VALUES (-1,
'TransactionClass', (select iuserid from ui.webuser where vcusername='madmin@42c.com'));

INSERT INTO ui.webusermapping (mappingid, mappingtype, webuserid) VALUES (-1,
'TransactionClass', (select iuserid from ui.webuser where vcusername='cadmin@ybaml.com'));

INSERT INTO ui.webusermapping (mappingid, mappingtype, webuserid) VALUES (-1,
'TransactionClass', (select iuserid from ui.webuser where vcusername='madmin@ybaml.com'));

INSERT INTO ui.webusermapping (mappingid, mappingtype, webuserid) VALUES (-1,
'TransactionClass', (select iuserid from ui.webuser where vcusername='cadmin@ybfrm.com'));

INSERT INTO ui.webusermapping (mappingid, mappingtype, webuserid) VALUES (-1,
'TransactionClass', (select iuserid from ui.webuser where vcusername='madmin@ybfrm.com'));

INSERT INTO ui.webusermapping (mappingid, mappingtype, webuserid) VALUES (-1,
'TransactionClass', (select iuserid from ui.webuser where vcusername='cadmin@pinelabs.com'));

INSERT INTO ui.webusermapping (mappingid, mappingtype, webuserid) VALUES (-1,
'TransactionClass', (select iuserid from ui.webuser where vcusername='madmin@pinelabs.com'));

INSERT INTO ui.webusermapping (mappingid, mappingtype, webuserid) VALUES (-1,
'TransactionClass', (select iuserid from ui.webuser where vcusername='cadmin@groww.com'));

INSERT INTO ui.webusermapping (mappingid, mappingtype, webuserid) VALUES (-1,
'TransactionClass', (select iuserid from ui.webuser where vcusername='madmin@groww.com'));

INSERT INTO ui.webusermapping (mappingid, mappingtype, webuserid) VALUES (-1,
'TransactionClass', (select iuserid from ui.webuser where vcusername='cadmin@jfs-jpb.com'));

INSERT INTO ui.webusermapping (mappingid, mappingtype, webuserid) VALUES (-1,
'TransactionClass', (select iuserid from ui.webuser where vcusername='madmin@jfs-jpb.com'));

INSERT INTO ui.webusermapping (mappingid, mappingtype, webuserid) VALUES (-1,
'TransactionClass', (select iuserid from ui.webuser where vcusername='cadmin@jfs-jpsl.com'));

INSERT INTO ui.webusermapping (mappingid, mappingtype, webuserid) VALUES (-1,
'TransactionClass', (select iuserid from ui.webuser where vcusername='madmin@jfs-jpsl.com'));