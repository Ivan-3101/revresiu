---groups for tenantid 2
INSERT INTO ui.groupdesc (
igroupid, vcgroupid, vcgroupname, vcgrouptype, istatus, itenantid) VALUES (
'2015'::integer, 'riskanalyst'::character varying, 'Risk Analyst'::character varying, 'WORKFLOW'::character varying, '1'::integer, '2'::integer)
 returning igroupid;
INSERT INTO ui.groupdesc (
igroupid, vcgroupid, vcgroupname, vcgrouptype, istatus, itenantid) VALUES (
'2016'::integer, 'risksupervisor'::character varying, 'Risk Supervisor'::character varying, 'WORKFLOW'::character varying, '1'::integer, '2'::integer)
 returning igroupid;
INSERT INTO ui.groupdesc (
igroupid, vcgroupid, vcgroupname, vcgrouptype, istatus, itenantid) VALUES (
'2017'::integer, 'db'::character varying, 'DB'::character varying, 'WORKFLOW'::character varying, '1'::integer, '2'::integer)
 returning igroupid;
INSERT INTO ui.groupdesc (
igroupid, vcgroupid, vcgroupname, vcgrouptype, istatus, itenantid) VALUES (
'2018'::integer, 'branch'::character varying, 'Branch'::character varying, 'WORKFLOW'::character varying, '1'::integer, '2'::integer)
 returning igroupid;
INSERT INTO ui.groupdesc (
igroupid, vcgroupid, vcgroupname, vcgrouptype, istatus, itenantid) VALUES (
'2019'::integer, 'qc'::character varying, 'QC'::character varying, 'WORKFLOW'::character varying, '1'::integer, '2'::integer)
 returning igroupid;
INSERT INTO ui.groupdesc (
igroupid, vcgroupid, vcgroupname, vcgrouptype, istatus, itenantid) VALUES (
'2020'::integer, 'it'::character varying, 'IT'::character varying, 'WORKFLOW'::character varying, '1'::integer, '2'::integer)
 returning igroupid;
 --group ends

 ---groups for tenantid 3
 INSERT INTO ui.groupdesc (
igroupid, vcgroupid, vcgroupname, vcgrouptype, istatus, itenantid) VALUES (
'2021'::integer, 'riskanalyst'::character varying, 'Risk Analyst'::character varying, 'WORKFLOW'::character varying, '1'::integer, '3'::integer)
 returning igroupid;
INSERT INTO ui.groupdesc (
igroupid, vcgroupid, vcgroupname, vcgrouptype, istatus, itenantid) VALUES (
'2022'::integer, 'risksupervisor'::character varying, 'Risk Supervisor'::character varying, 'WORKFLOW'::character varying, '1'::integer, '3'::integer)
 returning igroupid;
INSERT INTO ui.groupdesc (
igroupid, vcgroupid, vcgroupname, vcgrouptype, istatus, itenantid) VALUES (
'2023'::integer, 'db'::character varying, 'DB'::character varying, 'WORKFLOW'::character varying, '1'::integer, '3'::integer)
 returning igroupid;
INSERT INTO ui.groupdesc (
igroupid, vcgroupid, vcgroupname, vcgrouptype, istatus, itenantid) VALUES (
'2024'::integer, 'branch'::character varying, 'Branch'::character varying, 'WORKFLOW'::character varying, '1'::integer, '3'::integer)
 returning igroupid;
INSERT INTO ui.groupdesc (
igroupid, vcgroupid, vcgroupname, vcgrouptype, istatus, itenantid) VALUES (
'2025'::integer, 'qc'::character varying, 'QC'::character varying, 'WORKFLOW'::character varying, '1'::integer, '3'::integer)
 returning igroupid;
INSERT INTO ui.groupdesc (
igroupid, vcgroupid, vcgroupname, vcgrouptype, istatus, itenantid) VALUES (
'2026'::integer, 'it'::character varying, 'IT'::character varying, 'WORKFLOW'::character varying, '1'::integer, '3'::integer)
 returning igroupid;
 --group end

 ---groups for tenantid 4
 INSERT INTO ui.groupdesc (
igroupid, vcgroupid, vcgroupname, vcgrouptype, istatus, itenantid) VALUES (
'2027'::integer, 'riskanalyst'::character varying, 'Risk Analyst'::character varying, 'WORKFLOW'::character varying, '1'::integer, '4'::integer)
 returning igroupid;
INSERT INTO ui.groupdesc (
igroupid, vcgroupid, vcgroupname, vcgrouptype, istatus, itenantid) VALUES (
'2028'::integer, 'risksupervisor'::character varying, 'Risk Supervisor'::character varying, 'WORKFLOW'::character varying, '1'::integer, '4'::integer)
 returning igroupid;
INSERT INTO ui.groupdesc (
igroupid, vcgroupid, vcgroupname, vcgrouptype, istatus, itenantid) VALUES (
'2029'::integer, 'db'::character varying, 'DB'::character varying, 'WORKFLOW'::character varying, '1'::integer, '4'::integer)
 returning igroupid;
INSERT INTO ui.groupdesc (
igroupid, vcgroupid, vcgroupname, vcgrouptype, istatus, itenantid) VALUES (
'2030'::integer, 'branch'::character varying, 'Branch'::character varying, 'WORKFLOW'::character varying, '1'::integer, '4'::integer)
 returning igroupid;
INSERT INTO ui.groupdesc (
igroupid, vcgroupid, vcgroupname, vcgrouptype, istatus, itenantid) VALUES (
'2031'::integer, 'qc'::character varying, 'QC'::character varying, 'WORKFLOW'::character varying, '1'::integer, '4'::integer)
 returning igroupid;
INSERT INTO ui.groupdesc (
igroupid, vcgroupid, vcgroupname, vcgrouptype, istatus, itenantid) VALUES (
'2032'::integer, 'it'::character varying, 'IT'::character varying, 'WORKFLOW'::character varying, '1'::integer, '4'::integer)
 returning igroupid;
 --group end

SELECT setval(pg_get_serial_sequence('ui.rolemenuaccessmap', 'irolemenumapid'), coalesce(MAX(irolemenumapid), 1))
from ui.rolemenuaccessmap;
SELECT setval(pg_get_serial_sequence('ui.grouptotaskfiltermap', 'igrouptotaskfilterid'), coalesce(MAX(igrouptotaskfilterid), 1))
from ui.grouptotaskfiltermap;

--configure rolemenuaccessmap
---configure menu access for roles 13 to 18
insert into ui.rolemenuaccessmap 
(badd, bapprove, bdelete, bedit, bpublish, bview, istatus, imenuid, iroleid)
select true, true, true, true, true, true, true, imenuid, 13 from
ui.menustructuredesc where imenuid = (select imenuid from ui.menustructuredesc
where vcmenuname='Case Management');

insert into ui.rolemenuaccessmap 
(badd, bapprove, bdelete, bedit, bpublish, bview, istatus, imenuid, iroleid)
select true, true, true, true, true, true, true, imenuid, 13 from
ui.menustructuredesc where iparentmenu = (select imenuid from ui.menustructuredesc
where vcmenuname='Case Management') and vcmenuname != 'Reports' and vcmenuname != 'Upload Chargeback' and vcmenuname != 'Dashboards' and vcmenuname !='Create Manual Ticket';

insert into ui.rolemenuaccessmap 
(badd, bapprove, bdelete, bedit, bpublish, bview, istatus, imenuid, iroleid)
select true, true, true, true, true, true, true, imenuid, 14 from
ui.menustructuredesc where imenuid = (select imenuid from ui.menustructuredesc
where vcmenuname='Case Management');

insert into ui.rolemenuaccessmap 
(badd, bapprove, bdelete, bedit, bpublish, bview, istatus, imenuid, iroleid)
select true, true, true, true, true, true, true, imenuid, 14 from
ui.menustructuredesc where iparentmenu = (select imenuid from ui.menustructuredesc
where vcmenuname='Case Management') and vcmenuname != 'Reports' and vcmenuname != 'Upload Chargeback' and vcmenuname != 'Dashboards' and vcmenuname !='Create Manual Ticket';

insert into ui.rolemenuaccessmap 
(badd, bapprove, bdelete, bedit, bpublish, bview, istatus, imenuid, iroleid)
select true, true, true, true, true, true, true, imenuid, 15 from
ui.menustructuredesc where imenuid = (select imenuid from ui.menustructuredesc
where vcmenuname='Case Management');

insert into ui.rolemenuaccessmap 
(badd, bapprove, bdelete, bedit, bpublish, bview, istatus, imenuid, iroleid)
select true, true, true, true, true, true, true, imenuid, 15 from
ui.menustructuredesc where iparentmenu = (select imenuid from ui.menustructuredesc
where vcmenuname='Case Management') and vcmenuname != 'Reports' and vcmenuname != 'Upload Chargeback' and vcmenuname != 'Dashboards';

insert into ui.rolemenuaccessmap 
(badd, bapprove, bdelete, bedit, bpublish, bview, istatus, imenuid, iroleid)
select true, true, true, true, true, true, true, imenuid, 16 from
ui.menustructuredesc where imenuid = (select imenuid from ui.menustructuredesc
where vcmenuname='Case Management');

insert into ui.rolemenuaccessmap 
(badd, bapprove, bdelete, bedit, bpublish, bview, istatus, imenuid, iroleid)
select true, true, true, true, true, true, true, imenuid, 16 from
ui.menustructuredesc where iparentmenu = (select imenuid from ui.menustructuredesc
where vcmenuname='Case Management') and vcmenuname != 'Reports' and vcmenuname != 'Upload Chargeback' and vcmenuname != 'Dashboards';

insert into ui.rolemenuaccessmap 
(badd, bapprove, bdelete, bedit, bpublish, bview, istatus, imenuid, iroleid)
select true, true, true, true, true, true, true, imenuid, 17 from
ui.menustructuredesc where imenuid = (select imenuid from ui.menustructuredesc
where vcmenuname='Case Management');

insert into ui.rolemenuaccessmap 
(badd, bapprove, bdelete, bedit, bpublish, bview, istatus, imenuid, iroleid)
select true, true, true, true, true, true, true, imenuid, 17 from
ui.menustructuredesc where iparentmenu = (select imenuid from ui.menustructuredesc
where vcmenuname='Case Management') and vcmenuname != 'Reports' and vcmenuname != 'Upload Chargeback' and vcmenuname != 'Dashboards' and vcmenuname !='Create Manual Ticket';

insert into ui.rolemenuaccessmap 
(badd, bapprove, bdelete, bedit, bpublish, bview, istatus, imenuid, iroleid)
select true, true, true, true, true, true, true, imenuid, 18 from
ui.menustructuredesc where imenuid = (select imenuid from ui.menustructuredesc
where vcmenuname='Case Management');

insert into ui.rolemenuaccessmap 
(badd, bapprove, bdelete, bedit, bpublish, bview, istatus, imenuid, iroleid)
select true, true, true, true, true, true, true, imenuid, 18 from
ui.menustructuredesc where iparentmenu = (select imenuid from ui.menustructuredesc
where vcmenuname='Case Management') and vcmenuname != 'Reports' and vcmenuname != 'Upload Chargeback' and vcmenuname != 'Dashboards' and vcmenuname !='Create Manual Ticket';


---cadmin@solo.com group mapping
insert into ui.webusermapping (mappingid, mappingtype, webuserid) VALUES ((select igroupid from ui.groupdesc where itenantid=4 and vcgroupid='riskanalyst'),
'Group', (select iuserid from ui.webuser where vcusername='cadmin@solo.com'));

insert into ui.webusermapping (mappingid, mappingtype, webuserid) VALUES ((select igroupid from ui.groupdesc where itenantid=4 and vcgroupid='risksupervisor'),
'Group', (select iuserid from ui.webuser where vcusername='cadmin@solo.com'));

insert into ui.webusermapping (mappingid, mappingtype, webuserid) VALUES ((select igroupid from ui.groupdesc where itenantid=4 and vcgroupid='level1'),
'Group', (select iuserid from ui.webuser where vcusername='cadmin@solo.com'));

insert into ui.webusermapping (mappingid, mappingtype, webuserid) VALUES ((select igroupid from ui.groupdesc where itenantid=4 and vcgroupid='level2'),
'Group', (select iuserid from ui.webuser where vcusername='cadmin@solo.com'));

insert into ui.webusermapping (mappingid, mappingtype, webuserid) VALUES ((select igroupid from ui.groupdesc where itenantid=4 and vcgroupid='level3'),
'Group', (select iuserid from ui.webuser where vcusername='cadmin@solo.com'));

insert into ui.webusermapping (mappingid, mappingtype, webuserid) VALUES ((select igroupid from ui.groupdesc where itenantid=4 and vcgroupid='level4'),
'Group', (select iuserid from ui.webuser where vcusername='cadmin@solo.com'));

insert into ui.webusermapping (mappingid, mappingtype, webuserid) VALUES ((select igroupid from ui.groupdesc where itenantid=4 and vcgroupid='level5'),
'Group', (select iuserid from ui.webuser where vcusername='cadmin@solo.com'));

insert into ui.webusermapping (mappingid, mappingtype, webuserid) VALUES ((select igroupid from ui.groupdesc where itenantid=4 and vcgroupid='qc'),
'Group', (select iuserid from ui.webuser where vcusername='cadmin@solo.com'));

insert into ui.webusermapping (mappingid, mappingtype, webuserid) VALUES ((select igroupid from ui.groupdesc where itenantid=4 and vcgroupid='it'),
'Group', (select iuserid from ui.webuser where vcusername='cadmin@solo.com'));

insert into ui.webusermapping (mappingid, mappingtype, webuserid) VALUES ((select igroupid from ui.groupdesc where itenantid=4 and vcgroupid='db'),
'Group', (select iuserid from ui.webuser where vcusername='cadmin@solo.com'));

insert into ui.webusermapping (mappingid, mappingtype, webuserid) VALUES ((select igroupid from ui.groupdesc where itenantid=4 and vcgroupid='branch'),
'Group', (select iuserid from ui.webuser where vcusername='cadmin@solo.com'));

----madmin@solo.com group mapping
insert into ui.webusermapping (mappingid, mappingtype, webuserid) VALUES ((select igroupid from ui.groupdesc where itenantid=4 and vcgroupid='riskanalyst'),
'Group', (select iuserid from ui.webuser where vcusername='madmin@solo.com'));

insert into ui.webusermapping (mappingid, mappingtype, webuserid) VALUES ((select igroupid from ui.groupdesc where itenantid=4 and vcgroupid='risksupervisor'),
'Group', (select iuserid from ui.webuser where vcusername='madmin@solo.com'));

insert into ui.webusermapping (mappingid, mappingtype, webuserid) VALUES ((select igroupid from ui.groupdesc where itenantid=4 and vcgroupid='level1'),
'Group', (select iuserid from ui.webuser where vcusername='madmin@solo.com'));

insert into ui.webusermapping (mappingid, mappingtype, webuserid) VALUES ((select igroupid from ui.groupdesc where itenantid=4 and vcgroupid='level2'),
'Group', (select iuserid from ui.webuser where vcusername='madmin@solo.com'));

insert into ui.webusermapping (mappingid, mappingtype, webuserid) VALUES ((select igroupid from ui.groupdesc where itenantid=4 and vcgroupid='level3'),
'Group', (select iuserid from ui.webuser where vcusername='madmin@solo.com'));

insert into ui.webusermapping (mappingid, mappingtype, webuserid) VALUES ((select igroupid from ui.groupdesc where itenantid=4 and vcgroupid='level4'),
'Group', (select iuserid from ui.webuser where vcusername='madmin@solo.com'));

insert into ui.webusermapping (mappingid, mappingtype, webuserid) VALUES ((select igroupid from ui.groupdesc where itenantid=4 and vcgroupid='level5'),
'Group', (select iuserid from ui.webuser where vcusername='madmin@solo.com'));

insert into ui.webusermapping (mappingid, mappingtype, webuserid) VALUES ((select igroupid from ui.groupdesc where itenantid=4 and vcgroupid='qc'),
'Group', (select iuserid from ui.webuser where vcusername='madmin@solo.com'));

insert into ui.webusermapping (mappingid, mappingtype, webuserid) VALUES ((select igroupid from ui.groupdesc where itenantid=4 and vcgroupid='it'),
'Group', (select iuserid from ui.webuser where vcusername='madmin@solo.com'));

insert into ui.webusermapping (mappingid, mappingtype, webuserid) VALUES ((select igroupid from ui.groupdesc where itenantid=4 and vcgroupid='db'),
'Group', (select iuserid from ui.webuser where vcusername='madmin@solo.com'));

insert into ui.webusermapping (mappingid, mappingtype, webuserid) VALUES ((select igroupid from ui.groupdesc where itenantid=4 and vcgroupid='branch'),
'Group', (select iuserid from ui.webuser where vcusername='madmin@solo.com'));

---move cub analyst and usfb analyst, to tenantid 2 for 42c workflows
update ui.groupdesc set itenantid=2 where igroupid=1031 or igroupid=1032;
update ui.roledesc set itenantid=2 where iroleid=11 or iroleid=12;

--setup panel access map for tenantid=2, igroupid=2015(vcgroupid=riskanalyst)
insert into ui.panelaccessmap (panelaccessmap, panelid, groupid, workflowid) VALUES ((select max(panelaccessmap)+1 from ui.panelaccessmap), 1, 2015, 13);
insert into ui.panelaccessmap (panelaccessmap, panelid, groupid, workflowid) VALUES ((select max(panelaccessmap)+1 from ui.panelaccessmap), 2, 2015, 13);
insert into ui.panelaccessmap (panelaccessmap, panelid, groupid, workflowid) VALUES ((select max(panelaccessmap)+1 from ui.panelaccessmap), 3, 2015, 13);
insert into ui.panelaccessmap (panelaccessmap, panelid, groupid, workflowid) VALUES ((select max(panelaccessmap)+1 from ui.panelaccessmap), 4, 2015, 13);
insert into ui.panelaccessmap (panelaccessmap, panelid, groupid, workflowid) VALUES ((select max(panelaccessmap)+1 from ui.panelaccessmap), 5, 2015, 13);

insert into ui.panelaccessmap (panelaccessmap, panelid, groupid, workflowid) VALUES ((select max(panelaccessmap)+1 from ui.panelaccessmap), 1, 2015, 14);
insert into ui.panelaccessmap (panelaccessmap, panelid, groupid, workflowid) VALUES ((select max(panelaccessmap)+1 from ui.panelaccessmap), 2, 2015, 14);
insert into ui.panelaccessmap (panelaccessmap, panelid, groupid, workflowid) VALUES ((select max(panelaccessmap)+1 from ui.panelaccessmap), 3, 2015, 14);
insert into ui.panelaccessmap (panelaccessmap, panelid, groupid, workflowid) VALUES ((select max(panelaccessmap)+1 from ui.panelaccessmap), 4, 2015, 14);
insert into ui.panelaccessmap (panelaccessmap, panelid, groupid, workflowid) VALUES ((select max(panelaccessmap)+1 from ui.panelaccessmap), 5, 2015, 14);


--setup panel access map for tenantid=3, igroupid=2005,2006,2007(vcgroupid=level1,level2,level3)
insert into ui.panelaccessmap (panelaccessmap, panelid, groupid, workflowid) VALUES ((select max(panelaccessmap)+1 from ui.panelaccessmap), 1, 2005, 16);
insert into ui.panelaccessmap (panelaccessmap, panelid, groupid, workflowid) VALUES ((select max(panelaccessmap)+1 from ui.panelaccessmap), 2, 2005, 16);
insert into ui.panelaccessmap (panelaccessmap, panelid, groupid, workflowid) VALUES ((select max(panelaccessmap)+1 from ui.panelaccessmap), 3, 2005, 16);
insert into ui.panelaccessmap (panelaccessmap, panelid, groupid, workflowid) VALUES ((select max(panelaccessmap)+1 from ui.panelaccessmap), 4, 2005, 16);
insert into ui.panelaccessmap (panelaccessmap, panelid, groupid, workflowid) VALUES ((select max(panelaccessmap)+1 from ui.panelaccessmap), 5, 2005, 16);
insert into ui.panelaccessmap (panelaccessmap, panelid, groupid, workflowid) VALUES ((select max(panelaccessmap)+1 from ui.panelaccessmap), 6, 2005, 16);

insert into ui.panelaccessmap (panelaccessmap, panelid, groupid, workflowid) VALUES ((select max(panelaccessmap)+1 from ui.panelaccessmap), 1, 2006, 16);
insert into ui.panelaccessmap (panelaccessmap, panelid, groupid, workflowid) VALUES ((select max(panelaccessmap)+1 from ui.panelaccessmap), 2, 2006, 16);
insert into ui.panelaccessmap (panelaccessmap, panelid, groupid, workflowid) VALUES ((select max(panelaccessmap)+1 from ui.panelaccessmap), 3, 2006, 16);
insert into ui.panelaccessmap (panelaccessmap, panelid, groupid, workflowid) VALUES ((select max(panelaccessmap)+1 from ui.panelaccessmap), 4, 2006, 16);
insert into ui.panelaccessmap (panelaccessmap, panelid, groupid, workflowid) VALUES ((select max(panelaccessmap)+1 from ui.panelaccessmap), 5, 2006, 16);
insert into ui.panelaccessmap (panelaccessmap, panelid, groupid, workflowid) VALUES ((select max(panelaccessmap)+1 from ui.panelaccessmap), 6, 2006, 16);

insert into ui.panelaccessmap (panelaccessmap, panelid, groupid, workflowid) VALUES ((select max(panelaccessmap)+1 from ui.panelaccessmap), 1, 2007, 16);
insert into ui.panelaccessmap (panelaccessmap, panelid, groupid, workflowid) VALUES ((select max(panelaccessmap)+1 from ui.panelaccessmap), 2, 2007, 16);
insert into ui.panelaccessmap (panelaccessmap, panelid, groupid, workflowid) VALUES ((select max(panelaccessmap)+1 from ui.panelaccessmap), 3, 2007, 16);
insert into ui.panelaccessmap (panelaccessmap, panelid, groupid, workflowid) VALUES ((select max(panelaccessmap)+1 from ui.panelaccessmap), 4, 2007, 16);
insert into ui.panelaccessmap (panelaccessmap, panelid, groupid, workflowid) VALUES ((select max(panelaccessmap)+1 from ui.panelaccessmap), 5, 2007, 16);
insert into ui.panelaccessmap (panelaccessmap, panelid, groupid, workflowid) VALUES ((select max(panelaccessmap)+1 from ui.panelaccessmap), 6, 2007, 16);


--setup panel access map for tenantid=4, igroupid=2027,2028(vcgroupid=riskanalyst,risksupervisor)
insert into ui.panelaccessmap (panelaccessmap, panelid, groupid, workflowid) VALUES ((select max(panelaccessmap)+1 from ui.panelaccessmap), 1, 2027, 6);
insert into ui.panelaccessmap (panelaccessmap, panelid, groupid, workflowid) VALUES ((select max(panelaccessmap)+1 from ui.panelaccessmap), 2, 2027, 6);
insert into ui.panelaccessmap (panelaccessmap, panelid, groupid, workflowid) VALUES ((select max(panelaccessmap)+1 from ui.panelaccessmap), 3, 2027, 6);
insert into ui.panelaccessmap (panelaccessmap, panelid, groupid, workflowid) VALUES ((select max(panelaccessmap)+1 from ui.panelaccessmap), 4, 2027, 6);
insert into ui.panelaccessmap (panelaccessmap, panelid, groupid, workflowid) VALUES ((select max(panelaccessmap)+1 from ui.panelaccessmap), 5, 2027, 6);
insert into ui.panelaccessmap (panelaccessmap, panelid, groupid, workflowid) VALUES ((select max(panelaccessmap)+1 from ui.panelaccessmap), 1, 2028, 6);
insert into ui.panelaccessmap (panelaccessmap, panelid, groupid, workflowid) VALUES ((select max(panelaccessmap)+1 from ui.panelaccessmap), 2, 2028, 6);
insert into ui.panelaccessmap (panelaccessmap, panelid, groupid, workflowid) VALUES ((select max(panelaccessmap)+1 from ui.panelaccessmap), 3, 2028, 6);
insert into ui.panelaccessmap (panelaccessmap, panelid, groupid, workflowid) VALUES ((select max(panelaccessmap)+1 from ui.panelaccessmap), 4, 2028, 6);
insert into ui.panelaccessmap (panelaccessmap, panelid, groupid, workflowid) VALUES ((select max(panelaccessmap)+1 from ui.panelaccessmap), 5, 2028, 6);
insert into ui.panelaccessmap (panelaccessmap, panelid, groupid, workflowid) VALUES ((select max(panelaccessmap)+1 from ui.panelaccessmap), 1, 2027, 12);
insert into ui.panelaccessmap (panelaccessmap, panelid, groupid, workflowid) VALUES ((select max(panelaccessmap)+1 from ui.panelaccessmap), 2, 2027, 12);
insert into ui.panelaccessmap (panelaccessmap, panelid, groupid, workflowid) VALUES ((select max(panelaccessmap)+1 from ui.panelaccessmap), 3, 2027, 12);
insert into ui.panelaccessmap (panelaccessmap, panelid, groupid, workflowid) VALUES ((select max(panelaccessmap)+1 from ui.panelaccessmap), 4, 2027, 12);
insert into ui.panelaccessmap (panelaccessmap, panelid, groupid, workflowid) VALUES ((select max(panelaccessmap)+1 from ui.panelaccessmap), 5, 2027, 12);
insert into ui.panelaccessmap (panelaccessmap, panelid, groupid, workflowid) VALUES ((select max(panelaccessmap)+1 from ui.panelaccessmap), 1, 2028, 12);
insert into ui.panelaccessmap (panelaccessmap, panelid, groupid, workflowid) VALUES ((select max(panelaccessmap)+1 from ui.panelaccessmap), 2, 2028, 12);
insert into ui.panelaccessmap (panelaccessmap, panelid, groupid, workflowid) VALUES ((select max(panelaccessmap)+1 from ui.panelaccessmap), 3, 2028, 12);
insert into ui.panelaccessmap (panelaccessmap, panelid, groupid, workflowid) VALUES ((select max(panelaccessmap)+1 from ui.panelaccessmap), 4, 2028, 12);
insert into ui.panelaccessmap (panelaccessmap, panelid, groupid, workflowid) VALUES ((select max(panelaccessmap)+1 from ui.panelaccessmap), 5, 2028, 12);

---group access for tenantid2,3,4
INSERT INTO ui.grouptotaskfiltermap( iposition, igroupid, itaskfilterid)
 SELECT 1, igroupid, 1
 FROM ui.groupdesc where itenantid=2 or itenantid=3 or itenantid=4;

INSERT INTO ui.grouptotaskfiltermap( iposition, igroupid, itaskfilterid)
 SELECT 2, igroupid, 2
 FROM ui.groupdesc where itenantid=2 or itenantid=3 or itenantid=4;

INSERT INTO ui.grouptotaskfiltermap( iposition, igroupid, itaskfilterid)
 SELECT 3, igroupid, 3
 FROM ui.groupdesc where itenantid=2 or itenantid=3 or itenantid=4;

INSERT INTO ui.grouptotaskfiltermap( iposition, igroupid, itaskfilterid)
 SELECT 4, igroupid, 4
 FROM ui.groupdesc where itenantid=2 or itenantid=3 or itenantid=4;

INSERT INTO ui.grouptotaskfiltermap( iposition, igroupid, itaskfilterid)
 SELECT 5, igroupid, 5
 FROM ui.groupdesc where itenantid=2 or itenantid=3 or itenantid=4;

 INSERT INTO ui.grouptotaskfiltermap( iposition, igroupid, itaskfilterid)
 SELECT 6, igroupid, 6
 FROM ui.groupdesc where itenantid=2 or itenantid=3 or itenantid=4;

 INSERT INTO ui.grouptotaskfiltermap( iposition, igroupid, itaskfilterid)
 SELECT 7, igroupid, 7
 FROM ui.groupdesc where itenantid=2 or itenantid=3 or itenantid=4;

 INSERT INTO ui.grouptotaskfiltermap( iposition, igroupid, itaskfilterid)
 SELECT 8, igroupid, 8
 FROM ui.groupdesc where itenantid=2 or itenantid=3 or itenantid=4;

 INSERT INTO ui.grouptotaskfiltermap( iposition, igroupid, itaskfilterid)
 SELECT 9, igroupid,9
 FROM ui.groupdesc where itenantid=2 or itenantid=3 or itenantid=4;

delete from ui.workflowmasters where workflowid>17;
update ui.workflowmasters  set itenantid=2 where workflowid=13 or workflowid=14;
update ui.workflowmasters  set itenantid=3 where workflowid=16;
update ui.workflowmasters  set itenantid=4 where workflowid=6 or workflowid=12;