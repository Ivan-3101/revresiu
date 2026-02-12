UPDATE ui.tenants SET
attribs = '{
  "outboundEmailSettings": {
    "email.provider": "smtp",
    "email.provider.properties": {
      "mail.sender": "Risk Team",
      "mail.password": "lmcyvxrcwzluytkt",
      "mail.username": "dronapay@gmail.com",
      "mail.smtp.auth": "true",
      "mail.smtp.host": "smtp.gmail.com",
      "mail.smtp.port": "587",
      "mail.smtp.timeout": "5000",
      "mail.smtp.writetimeout": "5000",
      "mail.smtp.starttls.enable": "true",
      "mail.smtp.connectiontimeout": "5000"
    }
  }
}'::jsonb WHERE
itenantid = 1 or itenantid = 2 or itenantid = 3 or itenantid = 4;

UPDATE ui.workflowmasters SET
workflowname = 'QC'::character varying, workflowkey = 'Qc'::character varying WHERE
workflowid = 19;
UPDATE ui.workflowmasters SET
workflowname = 'QC'::character varying, workflowkey = 'Qc'::character varying WHERE
workflowid = 25;
UPDATE ui.workflowmasters SET
workflowname = 'QC'::character varying, workflowkey = 'Qc'::character varying WHERE
workflowid = 22;

insert into ui.workflowmasters (workflowid, workflowname, workflowkey, is_filter_display, itenantid) VALUES
(27, 'Orchestration', 'Orchestrator', false, 2);

insert into ui.workflowmasters (workflowid, workflowname, workflowkey, is_filter_display, itenantid) VALUES
(28, 'Orchestration', 'Orchestrator', false, 3);

insert into ui.workflowmasters (workflowid, workflowname, workflowkey, is_filter_display, itenantid) VALUES
(29, 'Orchestration', 'Orchestrator', false, 4);

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

---task panel access map for tenantid=2 and Risk Alert
insert into ui.panelaccessmap (panelaccessmap, panelid, groupid, workflowid) VALUES ((select max(panelaccessmap)+1 from ui.panelaccessmap), 1, 2015, 18);
insert into ui.panelaccessmap (panelaccessmap, panelid, groupid, workflowid) VALUES ((select max(panelaccessmap)+1 from ui.panelaccessmap), 2, 2015, 18);
insert into ui.panelaccessmap (panelaccessmap, panelid, groupid, workflowid) VALUES ((select max(panelaccessmap)+1 from ui.panelaccessmap), 3, 2015, 18);
insert into ui.panelaccessmap (panelaccessmap, panelid, groupid, workflowid) VALUES ((select max(panelaccessmap)+1 from ui.panelaccessmap), 4, 2015, 18);
insert into ui.panelaccessmap (panelaccessmap, panelid, groupid, workflowid) VALUES ((select max(panelaccessmap)+1 from ui.panelaccessmap), 5, 2015, 18);

insert into ui.panelaccessmap (panelaccessmap, panelid, groupid, workflowid) VALUES ((select max(panelaccessmap)+1 from ui.panelaccessmap), 1, 2016, 18);
insert into ui.panelaccessmap (panelaccessmap, panelid, groupid, workflowid) VALUES ((select max(panelaccessmap)+1 from ui.panelaccessmap), 2, 2016, 18);
insert into ui.panelaccessmap (panelaccessmap, panelid, groupid, workflowid) VALUES ((select max(panelaccessmap)+1 from ui.panelaccessmap), 3, 2016, 18);
insert into ui.panelaccessmap (panelaccessmap, panelid, groupid, workflowid) VALUES ((select max(panelaccessmap)+1 from ui.panelaccessmap), 4, 2016, 18);
insert into ui.panelaccessmap (panelaccessmap, panelid, groupid, workflowid) VALUES ((select max(panelaccessmap)+1 from ui.panelaccessmap), 5, 2016, 18);

---task panel access map for tenantid=3 and Risk Alert
insert into ui.panelaccessmap (panelaccessmap, panelid, groupid, workflowid) VALUES ((select max(panelaccessmap)+1 from ui.panelaccessmap), 1, 2021, 21);
insert into ui.panelaccessmap (panelaccessmap, panelid, groupid, workflowid) VALUES ((select max(panelaccessmap)+1 from ui.panelaccessmap), 2, 2021, 21);
insert into ui.panelaccessmap (panelaccessmap, panelid, groupid, workflowid) VALUES ((select max(panelaccessmap)+1 from ui.panelaccessmap), 3, 2021, 21);
insert into ui.panelaccessmap (panelaccessmap, panelid, groupid, workflowid) VALUES ((select max(panelaccessmap)+1 from ui.panelaccessmap), 4, 2021, 21);
insert into ui.panelaccessmap (panelaccessmap, panelid, groupid, workflowid) VALUES ((select max(panelaccessmap)+1 from ui.panelaccessmap), 5, 2021, 21);

insert into ui.panelaccessmap (panelaccessmap, panelid, groupid, workflowid) VALUES ((select max(panelaccessmap)+1 from ui.panelaccessmap), 1, 2022, 21);
insert into ui.panelaccessmap (panelaccessmap, panelid, groupid, workflowid) VALUES ((select max(panelaccessmap)+1 from ui.panelaccessmap), 2, 2022, 21);
insert into ui.panelaccessmap (panelaccessmap, panelid, groupid, workflowid) VALUES ((select max(panelaccessmap)+1 from ui.panelaccessmap), 3, 2022, 21);
insert into ui.panelaccessmap (panelaccessmap, panelid, groupid, workflowid) VALUES ((select max(panelaccessmap)+1 from ui.panelaccessmap), 4, 2022, 21);
insert into ui.panelaccessmap (panelaccessmap, panelid, groupid, workflowid) VALUES ((select max(panelaccessmap)+1 from ui.panelaccessmap), 5, 2022, 21);

---task panel access map for tenantid=4 and Risk Alert
insert into ui.panelaccessmap (panelaccessmap, panelid, groupid, workflowid) VALUES ((select max(panelaccessmap)+1 from ui.panelaccessmap), 1, 2027, 24);
insert into ui.panelaccessmap (panelaccessmap, panelid, groupid, workflowid) VALUES ((select max(panelaccessmap)+1 from ui.panelaccessmap), 2, 2027, 24);
insert into ui.panelaccessmap (panelaccessmap, panelid, groupid, workflowid) VALUES ((select max(panelaccessmap)+1 from ui.panelaccessmap), 3, 2027, 24);
insert into ui.panelaccessmap (panelaccessmap, panelid, groupid, workflowid) VALUES ((select max(panelaccessmap)+1 from ui.panelaccessmap), 4, 2027, 24);
insert into ui.panelaccessmap (panelaccessmap, panelid, groupid, workflowid) VALUES ((select max(panelaccessmap)+1 from ui.panelaccessmap), 5, 2027, 24);

insert into ui.panelaccessmap (panelaccessmap, panelid, groupid, workflowid) VALUES ((select max(panelaccessmap)+1 from ui.panelaccessmap), 1, 2028, 24);
insert into ui.panelaccessmap (panelaccessmap, panelid, groupid, workflowid) VALUES ((select max(panelaccessmap)+1 from ui.panelaccessmap), 2, 2028, 24);
insert into ui.panelaccessmap (panelaccessmap, panelid, groupid, workflowid) VALUES ((select max(panelaccessmap)+1 from ui.panelaccessmap), 3, 2028, 24);
insert into ui.panelaccessmap (panelaccessmap, panelid, groupid, workflowid) VALUES ((select max(panelaccessmap)+1 from ui.panelaccessmap), 4, 2028, 24);
insert into ui.panelaccessmap (panelaccessmap, panelid, groupid, workflowid) VALUES ((select max(panelaccessmap)+1 from ui.panelaccessmap), 5, 2028, 24);

--task panel access map for tenantid=2 and YBAML,QC
insert into ui.panelaccessmap (panelaccessmap, panelid, groupid, workflowid) VALUES ((select max(panelaccessmap)+1 from ui.panelaccessmap), 1, 2000, 19);
insert into ui.panelaccessmap (panelaccessmap, panelid, groupid, workflowid) VALUES ((select max(panelaccessmap)+1 from ui.panelaccessmap), 3, 2000, 19);
insert into ui.panelaccessmap (panelaccessmap, panelid, groupid, workflowid) VALUES ((select max(panelaccessmap)+1 from ui.panelaccessmap), 4, 2000, 19);
insert into ui.panelaccessmap (panelaccessmap, panelid, groupid, workflowid) VALUES ((select max(panelaccessmap)+1 from ui.panelaccessmap), 5, 2000, 19);
insert into ui.panelaccessmap (panelaccessmap, panelid, groupid, workflowid) VALUES ((select max(panelaccessmap)+1 from ui.panelaccessmap), 1, 2001, 19);
insert into ui.panelaccessmap (panelaccessmap, panelid, groupid, workflowid) VALUES ((select max(panelaccessmap)+1 from ui.panelaccessmap), 3, 2001, 19);
insert into ui.panelaccessmap (panelaccessmap, panelid, groupid, workflowid) VALUES ((select max(panelaccessmap)+1 from ui.panelaccessmap), 4, 2001, 19);
insert into ui.panelaccessmap (panelaccessmap, panelid, groupid, workflowid) VALUES ((select max(panelaccessmap)+1 from ui.panelaccessmap), 5, 2001, 19);
insert into ui.panelaccessmap (panelaccessmap, panelid, groupid, workflowid) VALUES ((select max(panelaccessmap)+1 from ui.panelaccessmap), 1, 2002, 19);
insert into ui.panelaccessmap (panelaccessmap, panelid, groupid, workflowid) VALUES ((select max(panelaccessmap)+1 from ui.panelaccessmap), 3, 2002, 19);
insert into ui.panelaccessmap (panelaccessmap, panelid, groupid, workflowid) VALUES ((select max(panelaccessmap)+1 from ui.panelaccessmap), 4, 2002, 19);
insert into ui.panelaccessmap (panelaccessmap, panelid, groupid, workflowid) VALUES ((select max(panelaccessmap)+1 from ui.panelaccessmap), 5, 2002, 19);
insert into ui.panelaccessmap (panelaccessmap, panelid, groupid, workflowid) VALUES ((select max(panelaccessmap)+1 from ui.panelaccessmap), 1, 2003, 19);
insert into ui.panelaccessmap (panelaccessmap, panelid, groupid, workflowid) VALUES ((select max(panelaccessmap)+1 from ui.panelaccessmap), 3, 2003, 19);
insert into ui.panelaccessmap (panelaccessmap, panelid, groupid, workflowid) VALUES ((select max(panelaccessmap)+1 from ui.panelaccessmap), 4, 2003, 19);
insert into ui.panelaccessmap (panelaccessmap, panelid, groupid, workflowid) VALUES ((select max(panelaccessmap)+1 from ui.panelaccessmap), 5, 2003, 19);
insert into ui.panelaccessmap (panelaccessmap, panelid, groupid, workflowid) VALUES ((select max(panelaccessmap)+1 from ui.panelaccessmap), 1, 2004, 19);
insert into ui.panelaccessmap (panelaccessmap, panelid, groupid, workflowid) VALUES ((select max(panelaccessmap)+1 from ui.panelaccessmap), 3, 2004, 19);
insert into ui.panelaccessmap (panelaccessmap, panelid, groupid, workflowid) VALUES ((select max(panelaccessmap)+1 from ui.panelaccessmap), 4, 2004, 19);
insert into ui.panelaccessmap (panelaccessmap, panelid, groupid, workflowid) VALUES ((select max(panelaccessmap)+1 from ui.panelaccessmap), 5, 2004, 19);
insert into ui.panelaccessmap (panelaccessmap, panelid, groupid, workflowid) VALUES ((select max(panelaccessmap)+1 from ui.panelaccessmap), 1, 2017, 19);
insert into ui.panelaccessmap (panelaccessmap, panelid, groupid, workflowid) VALUES ((select max(panelaccessmap)+1 from ui.panelaccessmap), 3, 2017, 19);
insert into ui.panelaccessmap (panelaccessmap, panelid, groupid, workflowid) VALUES ((select max(panelaccessmap)+1 from ui.panelaccessmap), 4, 2017, 19);
insert into ui.panelaccessmap (panelaccessmap, panelid, groupid, workflowid) VALUES ((select max(panelaccessmap)+1 from ui.panelaccessmap), 5, 2017, 19);
insert into ui.panelaccessmap (panelaccessmap, panelid, groupid, workflowid) VALUES ((select max(panelaccessmap)+1 from ui.panelaccessmap), 1, 2018, 19);
insert into ui.panelaccessmap (panelaccessmap, panelid, groupid, workflowid) VALUES ((select max(panelaccessmap)+1 from ui.panelaccessmap), 3, 2018, 19);
insert into ui.panelaccessmap (panelaccessmap, panelid, groupid, workflowid) VALUES ((select max(panelaccessmap)+1 from ui.panelaccessmap), 4, 2018, 19);
insert into ui.panelaccessmap (panelaccessmap, panelid, groupid, workflowid) VALUES ((select max(panelaccessmap)+1 from ui.panelaccessmap), 5, 2018, 19);
insert into ui.panelaccessmap (panelaccessmap, panelid, groupid, workflowid) VALUES ((select max(panelaccessmap)+1 from ui.panelaccessmap), 1, 2019, 19);
insert into ui.panelaccessmap (panelaccessmap, panelid, groupid, workflowid) VALUES ((select max(panelaccessmap)+1 from ui.panelaccessmap), 3, 2019, 19);
insert into ui.panelaccessmap (panelaccessmap, panelid, groupid, workflowid) VALUES ((select max(panelaccessmap)+1 from ui.panelaccessmap), 4, 2019, 19);
insert into ui.panelaccessmap (panelaccessmap, panelid, groupid, workflowid) VALUES ((select max(panelaccessmap)+1 from ui.panelaccessmap), 5, 2019, 19);
insert into ui.panelaccessmap (panelaccessmap, panelid, groupid, workflowid) VALUES ((select max(panelaccessmap)+1 from ui.panelaccessmap), 1, 2020, 19);
insert into ui.panelaccessmap (panelaccessmap, panelid, groupid, workflowid) VALUES ((select max(panelaccessmap)+1 from ui.panelaccessmap), 3, 2020, 19);
insert into ui.panelaccessmap (panelaccessmap, panelid, groupid, workflowid) VALUES ((select max(panelaccessmap)+1 from ui.panelaccessmap), 4, 2020, 19);
insert into ui.panelaccessmap (panelaccessmap, panelid, groupid, workflowid) VALUES ((select max(panelaccessmap)+1 from ui.panelaccessmap), 5, 2020, 19);

insert into ui.panelaccessmap (panelaccessmap, panelid, groupid, workflowid) VALUES ((select max(panelaccessmap)+1 from ui.panelaccessmap), 1, 2000, 20);
insert into ui.panelaccessmap (panelaccessmap, panelid, groupid, workflowid) VALUES ((select max(panelaccessmap)+1 from ui.panelaccessmap), 3, 2000, 20);
insert into ui.panelaccessmap (panelaccessmap, panelid, groupid, workflowid) VALUES ((select max(panelaccessmap)+1 from ui.panelaccessmap), 4, 2000, 20);
insert into ui.panelaccessmap (panelaccessmap, panelid, groupid, workflowid) VALUES ((select max(panelaccessmap)+1 from ui.panelaccessmap), 5, 2000, 20);
insert into ui.panelaccessmap (panelaccessmap, panelid, groupid, workflowid) VALUES ((select max(panelaccessmap)+1 from ui.panelaccessmap), 1, 2001, 20);
insert into ui.panelaccessmap (panelaccessmap, panelid, groupid, workflowid) VALUES ((select max(panelaccessmap)+1 from ui.panelaccessmap), 3, 2001, 20);
insert into ui.panelaccessmap (panelaccessmap, panelid, groupid, workflowid) VALUES ((select max(panelaccessmap)+1 from ui.panelaccessmap), 4, 2001, 20);
insert into ui.panelaccessmap (panelaccessmap, panelid, groupid, workflowid) VALUES ((select max(panelaccessmap)+1 from ui.panelaccessmap), 5, 2001, 20);
insert into ui.panelaccessmap (panelaccessmap, panelid, groupid, workflowid) VALUES ((select max(panelaccessmap)+1 from ui.panelaccessmap), 1, 2002, 20);
insert into ui.panelaccessmap (panelaccessmap, panelid, groupid, workflowid) VALUES ((select max(panelaccessmap)+1 from ui.panelaccessmap), 3, 2002, 20);
insert into ui.panelaccessmap (panelaccessmap, panelid, groupid, workflowid) VALUES ((select max(panelaccessmap)+1 from ui.panelaccessmap), 4, 2002, 20);
insert into ui.panelaccessmap (panelaccessmap, panelid, groupid, workflowid) VALUES ((select max(panelaccessmap)+1 from ui.panelaccessmap), 5, 2002, 20);
insert into ui.panelaccessmap (panelaccessmap, panelid, groupid, workflowid) VALUES ((select max(panelaccessmap)+1 from ui.panelaccessmap), 1, 2003, 20);
insert into ui.panelaccessmap (panelaccessmap, panelid, groupid, workflowid) VALUES ((select max(panelaccessmap)+1 from ui.panelaccessmap), 3, 2003, 20);
insert into ui.panelaccessmap (panelaccessmap, panelid, groupid, workflowid) VALUES ((select max(panelaccessmap)+1 from ui.panelaccessmap), 4, 2003, 20);
insert into ui.panelaccessmap (panelaccessmap, panelid, groupid, workflowid) VALUES ((select max(panelaccessmap)+1 from ui.panelaccessmap), 5, 2003, 20);
insert into ui.panelaccessmap (panelaccessmap, panelid, groupid, workflowid) VALUES ((select max(panelaccessmap)+1 from ui.panelaccessmap), 1, 2004, 20);
insert into ui.panelaccessmap (panelaccessmap, panelid, groupid, workflowid) VALUES ((select max(panelaccessmap)+1 from ui.panelaccessmap), 3, 2004, 20);
insert into ui.panelaccessmap (panelaccessmap, panelid, groupid, workflowid) VALUES ((select max(panelaccessmap)+1 from ui.panelaccessmap), 4, 2004, 20);
insert into ui.panelaccessmap (panelaccessmap, panelid, groupid, workflowid) VALUES ((select max(panelaccessmap)+1 from ui.panelaccessmap), 5, 2004, 20);
insert into ui.panelaccessmap (panelaccessmap, panelid, groupid, workflowid) VALUES ((select max(panelaccessmap)+1 from ui.panelaccessmap), 1, 2017, 20);
insert into ui.panelaccessmap (panelaccessmap, panelid, groupid, workflowid) VALUES ((select max(panelaccessmap)+1 from ui.panelaccessmap), 3, 2017, 20);
insert into ui.panelaccessmap (panelaccessmap, panelid, groupid, workflowid) VALUES ((select max(panelaccessmap)+1 from ui.panelaccessmap), 4, 2017, 20);
insert into ui.panelaccessmap (panelaccessmap, panelid, groupid, workflowid) VALUES ((select max(panelaccessmap)+1 from ui.panelaccessmap), 5, 2017, 20);
insert into ui.panelaccessmap (panelaccessmap, panelid, groupid, workflowid) VALUES ((select max(panelaccessmap)+1 from ui.panelaccessmap), 1, 2018, 20);
insert into ui.panelaccessmap (panelaccessmap, panelid, groupid, workflowid) VALUES ((select max(panelaccessmap)+1 from ui.panelaccessmap), 3, 2018, 20);
insert into ui.panelaccessmap (panelaccessmap, panelid, groupid, workflowid) VALUES ((select max(panelaccessmap)+1 from ui.panelaccessmap), 4, 2018, 20);
insert into ui.panelaccessmap (panelaccessmap, panelid, groupid, workflowid) VALUES ((select max(panelaccessmap)+1 from ui.panelaccessmap), 5, 2018, 20);
insert into ui.panelaccessmap (panelaccessmap, panelid, groupid, workflowid) VALUES ((select max(panelaccessmap)+1 from ui.panelaccessmap), 1, 2019, 20);
insert into ui.panelaccessmap (panelaccessmap, panelid, groupid, workflowid) VALUES ((select max(panelaccessmap)+1 from ui.panelaccessmap), 3, 2019, 20);
insert into ui.panelaccessmap (panelaccessmap, panelid, groupid, workflowid) VALUES ((select max(panelaccessmap)+1 from ui.panelaccessmap), 4, 2019, 20);
insert into ui.panelaccessmap (panelaccessmap, panelid, groupid, workflowid) VALUES ((select max(panelaccessmap)+1 from ui.panelaccessmap), 5, 2019, 20);
insert into ui.panelaccessmap (panelaccessmap, panelid, groupid, workflowid) VALUES ((select max(panelaccessmap)+1 from ui.panelaccessmap), 1, 2020, 20);
insert into ui.panelaccessmap (panelaccessmap, panelid, groupid, workflowid) VALUES ((select max(panelaccessmap)+1 from ui.panelaccessmap), 3, 2020, 20);
insert into ui.panelaccessmap (panelaccessmap, panelid, groupid, workflowid) VALUES ((select max(panelaccessmap)+1 from ui.panelaccessmap), 4, 2020, 20);
insert into ui.panelaccessmap (panelaccessmap, panelid, groupid, workflowid) VALUES ((select max(panelaccessmap)+1 from ui.panelaccessmap), 5, 2020, 20);

--task panel access map for tenantid=3 and YBAML,QC
insert into ui.panelaccessmap (panelaccessmap, panelid, groupid, workflowid) VALUES ((select max(panelaccessmap)+1 from ui.panelaccessmap), 1, 2005, 22);
insert into ui.panelaccessmap (panelaccessmap, panelid, groupid, workflowid) VALUES ((select max(panelaccessmap)+1 from ui.panelaccessmap), 3, 2005, 22);
insert into ui.panelaccessmap (panelaccessmap, panelid, groupid, workflowid) VALUES ((select max(panelaccessmap)+1 from ui.panelaccessmap), 4, 2005, 22);
insert into ui.panelaccessmap (panelaccessmap, panelid, groupid, workflowid) VALUES ((select max(panelaccessmap)+1 from ui.panelaccessmap), 5, 2005, 22);
insert into ui.panelaccessmap (panelaccessmap, panelid, groupid, workflowid) VALUES ((select max(panelaccessmap)+1 from ui.panelaccessmap), 1, 2006, 22);
insert into ui.panelaccessmap (panelaccessmap, panelid, groupid, workflowid) VALUES ((select max(panelaccessmap)+1 from ui.panelaccessmap), 3, 2006, 22);
insert into ui.panelaccessmap (panelaccessmap, panelid, groupid, workflowid) VALUES ((select max(panelaccessmap)+1 from ui.panelaccessmap), 4, 2006, 22);
insert into ui.panelaccessmap (panelaccessmap, panelid, groupid, workflowid) VALUES ((select max(panelaccessmap)+1 from ui.panelaccessmap), 5, 2006, 22);
insert into ui.panelaccessmap (panelaccessmap, panelid, groupid, workflowid) VALUES ((select max(panelaccessmap)+1 from ui.panelaccessmap), 1, 2007, 22);
insert into ui.panelaccessmap (panelaccessmap, panelid, groupid, workflowid) VALUES ((select max(panelaccessmap)+1 from ui.panelaccessmap), 3, 2007, 22);
insert into ui.panelaccessmap (panelaccessmap, panelid, groupid, workflowid) VALUES ((select max(panelaccessmap)+1 from ui.panelaccessmap), 4, 2007, 22);
insert into ui.panelaccessmap (panelaccessmap, panelid, groupid, workflowid) VALUES ((select max(panelaccessmap)+1 from ui.panelaccessmap), 5, 2007, 22);
insert into ui.panelaccessmap (panelaccessmap, panelid, groupid, workflowid) VALUES ((select max(panelaccessmap)+1 from ui.panelaccessmap), 1, 2008, 22);
insert into ui.panelaccessmap (panelaccessmap, panelid, groupid, workflowid) VALUES ((select max(panelaccessmap)+1 from ui.panelaccessmap), 3, 2008, 22);
insert into ui.panelaccessmap (panelaccessmap, panelid, groupid, workflowid) VALUES ((select max(panelaccessmap)+1 from ui.panelaccessmap), 4, 2008, 22);
insert into ui.panelaccessmap (panelaccessmap, panelid, groupid, workflowid) VALUES ((select max(panelaccessmap)+1 from ui.panelaccessmap), 5, 2008, 22);
insert into ui.panelaccessmap (panelaccessmap, panelid, groupid, workflowid) VALUES ((select max(panelaccessmap)+1 from ui.panelaccessmap), 1, 2009, 22);
insert into ui.panelaccessmap (panelaccessmap, panelid, groupid, workflowid) VALUES ((select max(panelaccessmap)+1 from ui.panelaccessmap), 3, 2009, 22);
insert into ui.panelaccessmap (panelaccessmap, panelid, groupid, workflowid) VALUES ((select max(panelaccessmap)+1 from ui.panelaccessmap), 4, 2009, 22);
insert into ui.panelaccessmap (panelaccessmap, panelid, groupid, workflowid) VALUES ((select max(panelaccessmap)+1 from ui.panelaccessmap), 5, 2009, 22);
insert into ui.panelaccessmap (panelaccessmap, panelid, groupid, workflowid) VALUES ((select max(panelaccessmap)+1 from ui.panelaccessmap), 1, 2023, 22);
insert into ui.panelaccessmap (panelaccessmap, panelid, groupid, workflowid) VALUES ((select max(panelaccessmap)+1 from ui.panelaccessmap), 3, 2023, 22);
insert into ui.panelaccessmap (panelaccessmap, panelid, groupid, workflowid) VALUES ((select max(panelaccessmap)+1 from ui.panelaccessmap), 4, 2023, 22);
insert into ui.panelaccessmap (panelaccessmap, panelid, groupid, workflowid) VALUES ((select max(panelaccessmap)+1 from ui.panelaccessmap), 5, 2023, 22);
insert into ui.panelaccessmap (panelaccessmap, panelid, groupid, workflowid) VALUES ((select max(panelaccessmap)+1 from ui.panelaccessmap), 1, 2024, 22);
insert into ui.panelaccessmap (panelaccessmap, panelid, groupid, workflowid) VALUES ((select max(panelaccessmap)+1 from ui.panelaccessmap), 3, 2024, 22);
insert into ui.panelaccessmap (panelaccessmap, panelid, groupid, workflowid) VALUES ((select max(panelaccessmap)+1 from ui.panelaccessmap), 4, 2024, 22);
insert into ui.panelaccessmap (panelaccessmap, panelid, groupid, workflowid) VALUES ((select max(panelaccessmap)+1 from ui.panelaccessmap), 5, 2024, 22);
insert into ui.panelaccessmap (panelaccessmap, panelid, groupid, workflowid) VALUES ((select max(panelaccessmap)+1 from ui.panelaccessmap), 1, 2025, 22);
insert into ui.panelaccessmap (panelaccessmap, panelid, groupid, workflowid) VALUES ((select max(panelaccessmap)+1 from ui.panelaccessmap), 3, 2025, 22);
insert into ui.panelaccessmap (panelaccessmap, panelid, groupid, workflowid) VALUES ((select max(panelaccessmap)+1 from ui.panelaccessmap), 4, 2025, 22);
insert into ui.panelaccessmap (panelaccessmap, panelid, groupid, workflowid) VALUES ((select max(panelaccessmap)+1 from ui.panelaccessmap), 5, 2025, 22);
insert into ui.panelaccessmap (panelaccessmap, panelid, groupid, workflowid) VALUES ((select max(panelaccessmap)+1 from ui.panelaccessmap), 1, 2026, 22);
insert into ui.panelaccessmap (panelaccessmap, panelid, groupid, workflowid) VALUES ((select max(panelaccessmap)+1 from ui.panelaccessmap), 3, 2026, 22);
insert into ui.panelaccessmap (panelaccessmap, panelid, groupid, workflowid) VALUES ((select max(panelaccessmap)+1 from ui.panelaccessmap), 4, 2026, 22);
insert into ui.panelaccessmap (panelaccessmap, panelid, groupid, workflowid) VALUES ((select max(panelaccessmap)+1 from ui.panelaccessmap), 5, 2026, 22);

insert into ui.panelaccessmap (panelaccessmap, panelid, groupid, workflowid) VALUES ((select max(panelaccessmap)+1 from ui.panelaccessmap), 1, 2005, 23);
insert into ui.panelaccessmap (panelaccessmap, panelid, groupid, workflowid) VALUES ((select max(panelaccessmap)+1 from ui.panelaccessmap), 3, 2005, 23);
insert into ui.panelaccessmap (panelaccessmap, panelid, groupid, workflowid) VALUES ((select max(panelaccessmap)+1 from ui.panelaccessmap), 4, 2005, 23);
insert into ui.panelaccessmap (panelaccessmap, panelid, groupid, workflowid) VALUES ((select max(panelaccessmap)+1 from ui.panelaccessmap), 5, 2005, 23);
insert into ui.panelaccessmap (panelaccessmap, panelid, groupid, workflowid) VALUES ((select max(panelaccessmap)+1 from ui.panelaccessmap), 1, 2006, 23);
insert into ui.panelaccessmap (panelaccessmap, panelid, groupid, workflowid) VALUES ((select max(panelaccessmap)+1 from ui.panelaccessmap), 3, 2006, 23);
insert into ui.panelaccessmap (panelaccessmap, panelid, groupid, workflowid) VALUES ((select max(panelaccessmap)+1 from ui.panelaccessmap), 4, 2006, 23);
insert into ui.panelaccessmap (panelaccessmap, panelid, groupid, workflowid) VALUES ((select max(panelaccessmap)+1 from ui.panelaccessmap), 5, 2006, 23);
insert into ui.panelaccessmap (panelaccessmap, panelid, groupid, workflowid) VALUES ((select max(panelaccessmap)+1 from ui.panelaccessmap), 1, 2007, 23);
insert into ui.panelaccessmap (panelaccessmap, panelid, groupid, workflowid) VALUES ((select max(panelaccessmap)+1 from ui.panelaccessmap), 3, 2007, 23);
insert into ui.panelaccessmap (panelaccessmap, panelid, groupid, workflowid) VALUES ((select max(panelaccessmap)+1 from ui.panelaccessmap), 4, 2007, 23);
insert into ui.panelaccessmap (panelaccessmap, panelid, groupid, workflowid) VALUES ((select max(panelaccessmap)+1 from ui.panelaccessmap), 5, 2007, 23);
insert into ui.panelaccessmap (panelaccessmap, panelid, groupid, workflowid) VALUES ((select max(panelaccessmap)+1 from ui.panelaccessmap), 1, 2008, 23);
insert into ui.panelaccessmap (panelaccessmap, panelid, groupid, workflowid) VALUES ((select max(panelaccessmap)+1 from ui.panelaccessmap), 3, 2008, 23);
insert into ui.panelaccessmap (panelaccessmap, panelid, groupid, workflowid) VALUES ((select max(panelaccessmap)+1 from ui.panelaccessmap), 4, 2008, 23);
insert into ui.panelaccessmap (panelaccessmap, panelid, groupid, workflowid) VALUES ((select max(panelaccessmap)+1 from ui.panelaccessmap), 5, 2008, 23);
insert into ui.panelaccessmap (panelaccessmap, panelid, groupid, workflowid) VALUES ((select max(panelaccessmap)+1 from ui.panelaccessmap), 1, 2009, 23);
insert into ui.panelaccessmap (panelaccessmap, panelid, groupid, workflowid) VALUES ((select max(panelaccessmap)+1 from ui.panelaccessmap), 3, 2009, 23);
insert into ui.panelaccessmap (panelaccessmap, panelid, groupid, workflowid) VALUES ((select max(panelaccessmap)+1 from ui.panelaccessmap), 4, 2009, 23);
insert into ui.panelaccessmap (panelaccessmap, panelid, groupid, workflowid) VALUES ((select max(panelaccessmap)+1 from ui.panelaccessmap), 5, 2009, 23);
insert into ui.panelaccessmap (panelaccessmap, panelid, groupid, workflowid) VALUES ((select max(panelaccessmap)+1 from ui.panelaccessmap), 1, 2023, 23);
insert into ui.panelaccessmap (panelaccessmap, panelid, groupid, workflowid) VALUES ((select max(panelaccessmap)+1 from ui.panelaccessmap), 3, 2023, 23);
insert into ui.panelaccessmap (panelaccessmap, panelid, groupid, workflowid) VALUES ((select max(panelaccessmap)+1 from ui.panelaccessmap), 4, 2023, 23);
insert into ui.panelaccessmap (panelaccessmap, panelid, groupid, workflowid) VALUES ((select max(panelaccessmap)+1 from ui.panelaccessmap), 5, 2023, 23);
insert into ui.panelaccessmap (panelaccessmap, panelid, groupid, workflowid) VALUES ((select max(panelaccessmap)+1 from ui.panelaccessmap), 1, 2024, 23);
insert into ui.panelaccessmap (panelaccessmap, panelid, groupid, workflowid) VALUES ((select max(panelaccessmap)+1 from ui.panelaccessmap), 3, 2024, 23);
insert into ui.panelaccessmap (panelaccessmap, panelid, groupid, workflowid) VALUES ((select max(panelaccessmap)+1 from ui.panelaccessmap), 4, 2024, 23);
insert into ui.panelaccessmap (panelaccessmap, panelid, groupid, workflowid) VALUES ((select max(panelaccessmap)+1 from ui.panelaccessmap), 5, 2024, 23);
insert into ui.panelaccessmap (panelaccessmap, panelid, groupid, workflowid) VALUES ((select max(panelaccessmap)+1 from ui.panelaccessmap), 1, 2025, 23);
insert into ui.panelaccessmap (panelaccessmap, panelid, groupid, workflowid) VALUES ((select max(panelaccessmap)+1 from ui.panelaccessmap), 3, 2025, 23);
insert into ui.panelaccessmap (panelaccessmap, panelid, groupid, workflowid) VALUES ((select max(panelaccessmap)+1 from ui.panelaccessmap), 4, 2025, 23);
insert into ui.panelaccessmap (panelaccessmap, panelid, groupid, workflowid) VALUES ((select max(panelaccessmap)+1 from ui.panelaccessmap), 5, 2025, 23);
insert into ui.panelaccessmap (panelaccessmap, panelid, groupid, workflowid) VALUES ((select max(panelaccessmap)+1 from ui.panelaccessmap), 1, 2026, 23);
insert into ui.panelaccessmap (panelaccessmap, panelid, groupid, workflowid) VALUES ((select max(panelaccessmap)+1 from ui.panelaccessmap), 3, 2026, 23);
insert into ui.panelaccessmap (panelaccessmap, panelid, groupid, workflowid) VALUES ((select max(panelaccessmap)+1 from ui.panelaccessmap), 4, 2026, 23);
insert into ui.panelaccessmap (panelaccessmap, panelid, groupid, workflowid) VALUES ((select max(panelaccessmap)+1 from ui.panelaccessmap), 5, 2026, 23);

--task panel access map for tenantid=4 and YBAML,QC
insert into ui.panelaccessmap (panelaccessmap, panelid, groupid, workflowid) VALUES ((select max(panelaccessmap)+1 from ui.panelaccessmap), 1, 2010, 25);
insert into ui.panelaccessmap (panelaccessmap, panelid, groupid, workflowid) VALUES ((select max(panelaccessmap)+1 from ui.panelaccessmap), 3, 2010, 25);
insert into ui.panelaccessmap (panelaccessmap, panelid, groupid, workflowid) VALUES ((select max(panelaccessmap)+1 from ui.panelaccessmap), 4, 2010, 25);
insert into ui.panelaccessmap (panelaccessmap, panelid, groupid, workflowid) VALUES ((select max(panelaccessmap)+1 from ui.panelaccessmap), 5, 2010, 25);
insert into ui.panelaccessmap (panelaccessmap, panelid, groupid, workflowid) VALUES ((select max(panelaccessmap)+1 from ui.panelaccessmap), 1, 2011, 25);
insert into ui.panelaccessmap (panelaccessmap, panelid, groupid, workflowid) VALUES ((select max(panelaccessmap)+1 from ui.panelaccessmap), 3, 2011, 25);
insert into ui.panelaccessmap (panelaccessmap, panelid, groupid, workflowid) VALUES ((select max(panelaccessmap)+1 from ui.panelaccessmap), 4, 2011, 25);
insert into ui.panelaccessmap (panelaccessmap, panelid, groupid, workflowid) VALUES ((select max(panelaccessmap)+1 from ui.panelaccessmap), 5, 2011, 25);
insert into ui.panelaccessmap (panelaccessmap, panelid, groupid, workflowid) VALUES ((select max(panelaccessmap)+1 from ui.panelaccessmap), 1, 2012, 25);
insert into ui.panelaccessmap (panelaccessmap, panelid, groupid, workflowid) VALUES ((select max(panelaccessmap)+1 from ui.panelaccessmap), 3, 2012, 25);
insert into ui.panelaccessmap (panelaccessmap, panelid, groupid, workflowid) VALUES ((select max(panelaccessmap)+1 from ui.panelaccessmap), 4, 2012, 25);
insert into ui.panelaccessmap (panelaccessmap, panelid, groupid, workflowid) VALUES ((select max(panelaccessmap)+1 from ui.panelaccessmap), 5, 2012, 25);
insert into ui.panelaccessmap (panelaccessmap, panelid, groupid, workflowid) VALUES ((select max(panelaccessmap)+1 from ui.panelaccessmap), 1, 2013, 25);
insert into ui.panelaccessmap (panelaccessmap, panelid, groupid, workflowid) VALUES ((select max(panelaccessmap)+1 from ui.panelaccessmap), 3, 2013, 25);
insert into ui.panelaccessmap (panelaccessmap, panelid, groupid, workflowid) VALUES ((select max(panelaccessmap)+1 from ui.panelaccessmap), 4, 2013, 25);
insert into ui.panelaccessmap (panelaccessmap, panelid, groupid, workflowid) VALUES ((select max(panelaccessmap)+1 from ui.panelaccessmap), 5, 2013, 25);
insert into ui.panelaccessmap (panelaccessmap, panelid, groupid, workflowid) VALUES ((select max(panelaccessmap)+1 from ui.panelaccessmap), 1, 2014, 25);
insert into ui.panelaccessmap (panelaccessmap, panelid, groupid, workflowid) VALUES ((select max(panelaccessmap)+1 from ui.panelaccessmap), 3, 2014, 25);
insert into ui.panelaccessmap (panelaccessmap, panelid, groupid, workflowid) VALUES ((select max(panelaccessmap)+1 from ui.panelaccessmap), 4, 2014, 25);
insert into ui.panelaccessmap (panelaccessmap, panelid, groupid, workflowid) VALUES ((select max(panelaccessmap)+1 from ui.panelaccessmap), 5, 2014, 25);
insert into ui.panelaccessmap (panelaccessmap, panelid, groupid, workflowid) VALUES ((select max(panelaccessmap)+1 from ui.panelaccessmap), 1, 2029, 25);
insert into ui.panelaccessmap (panelaccessmap, panelid, groupid, workflowid) VALUES ((select max(panelaccessmap)+1 from ui.panelaccessmap), 3, 2029, 25);
insert into ui.panelaccessmap (panelaccessmap, panelid, groupid, workflowid) VALUES ((select max(panelaccessmap)+1 from ui.panelaccessmap), 4, 2029, 25);
insert into ui.panelaccessmap (panelaccessmap, panelid, groupid, workflowid) VALUES ((select max(panelaccessmap)+1 from ui.panelaccessmap), 5, 2029, 25);
insert into ui.panelaccessmap (panelaccessmap, panelid, groupid, workflowid) VALUES ((select max(panelaccessmap)+1 from ui.panelaccessmap), 1, 2030, 25);
insert into ui.panelaccessmap (panelaccessmap, panelid, groupid, workflowid) VALUES ((select max(panelaccessmap)+1 from ui.panelaccessmap), 3, 2030, 25);
insert into ui.panelaccessmap (panelaccessmap, panelid, groupid, workflowid) VALUES ((select max(panelaccessmap)+1 from ui.panelaccessmap), 4, 2030, 25);
insert into ui.panelaccessmap (panelaccessmap, panelid, groupid, workflowid) VALUES ((select max(panelaccessmap)+1 from ui.panelaccessmap), 5, 2030, 25);
insert into ui.panelaccessmap (panelaccessmap, panelid, groupid, workflowid) VALUES ((select max(panelaccessmap)+1 from ui.panelaccessmap), 1, 2031, 25);
insert into ui.panelaccessmap (panelaccessmap, panelid, groupid, workflowid) VALUES ((select max(panelaccessmap)+1 from ui.panelaccessmap), 3, 2031, 25);
insert into ui.panelaccessmap (panelaccessmap, panelid, groupid, workflowid) VALUES ((select max(panelaccessmap)+1 from ui.panelaccessmap), 4, 2031, 25);
insert into ui.panelaccessmap (panelaccessmap, panelid, groupid, workflowid) VALUES ((select max(panelaccessmap)+1 from ui.panelaccessmap), 5, 2031, 25);
insert into ui.panelaccessmap (panelaccessmap, panelid, groupid, workflowid) VALUES ((select max(panelaccessmap)+1 from ui.panelaccessmap), 1, 2032, 25);
insert into ui.panelaccessmap (panelaccessmap, panelid, groupid, workflowid) VALUES ((select max(panelaccessmap)+1 from ui.panelaccessmap), 3, 2032, 25);
insert into ui.panelaccessmap (panelaccessmap, panelid, groupid, workflowid) VALUES ((select max(panelaccessmap)+1 from ui.panelaccessmap), 4, 2032, 25);
insert into ui.panelaccessmap (panelaccessmap, panelid, groupid, workflowid) VALUES ((select max(panelaccessmap)+1 from ui.panelaccessmap), 5, 2032, 25);

insert into ui.panelaccessmap (panelaccessmap, panelid, groupid, workflowid) VALUES ((select max(panelaccessmap)+1 from ui.panelaccessmap), 1, 2010, 26);
insert into ui.panelaccessmap (panelaccessmap, panelid, groupid, workflowid) VALUES ((select max(panelaccessmap)+1 from ui.panelaccessmap), 3, 2010, 26);
insert into ui.panelaccessmap (panelaccessmap, panelid, groupid, workflowid) VALUES ((select max(panelaccessmap)+1 from ui.panelaccessmap), 4, 2010, 26);
insert into ui.panelaccessmap (panelaccessmap, panelid, groupid, workflowid) VALUES ((select max(panelaccessmap)+1 from ui.panelaccessmap), 5, 2010, 26);
insert into ui.panelaccessmap (panelaccessmap, panelid, groupid, workflowid) VALUES ((select max(panelaccessmap)+1 from ui.panelaccessmap), 1, 2011, 26);
insert into ui.panelaccessmap (panelaccessmap, panelid, groupid, workflowid) VALUES ((select max(panelaccessmap)+1 from ui.panelaccessmap), 3, 2011, 26);
insert into ui.panelaccessmap (panelaccessmap, panelid, groupid, workflowid) VALUES ((select max(panelaccessmap)+1 from ui.panelaccessmap), 4, 2011, 26);
insert into ui.panelaccessmap (panelaccessmap, panelid, groupid, workflowid) VALUES ((select max(panelaccessmap)+1 from ui.panelaccessmap), 5, 2011, 26);
insert into ui.panelaccessmap (panelaccessmap, panelid, groupid, workflowid) VALUES ((select max(panelaccessmap)+1 from ui.panelaccessmap), 1, 2012, 26);
insert into ui.panelaccessmap (panelaccessmap, panelid, groupid, workflowid) VALUES ((select max(panelaccessmap)+1 from ui.panelaccessmap), 3, 2012, 26);
insert into ui.panelaccessmap (panelaccessmap, panelid, groupid, workflowid) VALUES ((select max(panelaccessmap)+1 from ui.panelaccessmap), 4, 2012, 26);
insert into ui.panelaccessmap (panelaccessmap, panelid, groupid, workflowid) VALUES ((select max(panelaccessmap)+1 from ui.panelaccessmap), 5, 2012, 26);
insert into ui.panelaccessmap (panelaccessmap, panelid, groupid, workflowid) VALUES ((select max(panelaccessmap)+1 from ui.panelaccessmap), 1, 2013, 26);
insert into ui.panelaccessmap (panelaccessmap, panelid, groupid, workflowid) VALUES ((select max(panelaccessmap)+1 from ui.panelaccessmap), 3, 2013, 26);
insert into ui.panelaccessmap (panelaccessmap, panelid, groupid, workflowid) VALUES ((select max(panelaccessmap)+1 from ui.panelaccessmap), 4, 2013, 26);
insert into ui.panelaccessmap (panelaccessmap, panelid, groupid, workflowid) VALUES ((select max(panelaccessmap)+1 from ui.panelaccessmap), 5, 2013, 26);
insert into ui.panelaccessmap (panelaccessmap, panelid, groupid, workflowid) VALUES ((select max(panelaccessmap)+1 from ui.panelaccessmap), 1, 2014, 26);
insert into ui.panelaccessmap (panelaccessmap, panelid, groupid, workflowid) VALUES ((select max(panelaccessmap)+1 from ui.panelaccessmap), 3, 2014, 26);
insert into ui.panelaccessmap (panelaccessmap, panelid, groupid, workflowid) VALUES ((select max(panelaccessmap)+1 from ui.panelaccessmap), 4, 2014, 26);
insert into ui.panelaccessmap (panelaccessmap, panelid, groupid, workflowid) VALUES ((select max(panelaccessmap)+1 from ui.panelaccessmap), 5, 2014, 26);
insert into ui.panelaccessmap (panelaccessmap, panelid, groupid, workflowid) VALUES ((select max(panelaccessmap)+1 from ui.panelaccessmap), 1, 2029, 26);
insert into ui.panelaccessmap (panelaccessmap, panelid, groupid, workflowid) VALUES ((select max(panelaccessmap)+1 from ui.panelaccessmap), 3, 2029, 26);
insert into ui.panelaccessmap (panelaccessmap, panelid, groupid, workflowid) VALUES ((select max(panelaccessmap)+1 from ui.panelaccessmap), 4, 2029, 26);
insert into ui.panelaccessmap (panelaccessmap, panelid, groupid, workflowid) VALUES ((select max(panelaccessmap)+1 from ui.panelaccessmap), 5, 2029, 26);
insert into ui.panelaccessmap (panelaccessmap, panelid, groupid, workflowid) VALUES ((select max(panelaccessmap)+1 from ui.panelaccessmap), 1, 2030, 26);
insert into ui.panelaccessmap (panelaccessmap, panelid, groupid, workflowid) VALUES ((select max(panelaccessmap)+1 from ui.panelaccessmap), 3, 2030, 26);
insert into ui.panelaccessmap (panelaccessmap, panelid, groupid, workflowid) VALUES ((select max(panelaccessmap)+1 from ui.panelaccessmap), 4, 2030, 26);
insert into ui.panelaccessmap (panelaccessmap, panelid, groupid, workflowid) VALUES ((select max(panelaccessmap)+1 from ui.panelaccessmap), 5, 2030, 26);
insert into ui.panelaccessmap (panelaccessmap, panelid, groupid, workflowid) VALUES ((select max(panelaccessmap)+1 from ui.panelaccessmap), 1, 2031, 26);
insert into ui.panelaccessmap (panelaccessmap, panelid, groupid, workflowid) VALUES ((select max(panelaccessmap)+1 from ui.panelaccessmap), 3, 2031, 26);
insert into ui.panelaccessmap (panelaccessmap, panelid, groupid, workflowid) VALUES ((select max(panelaccessmap)+1 from ui.panelaccessmap), 4, 2031, 26);
insert into ui.panelaccessmap (panelaccessmap, panelid, groupid, workflowid) VALUES ((select max(panelaccessmap)+1 from ui.panelaccessmap), 5, 2031, 26);
insert into ui.panelaccessmap (panelaccessmap, panelid, groupid, workflowid) VALUES ((select max(panelaccessmap)+1 from ui.panelaccessmap), 1, 2032, 26);
insert into ui.panelaccessmap (panelaccessmap, panelid, groupid, workflowid) VALUES ((select max(panelaccessmap)+1 from ui.panelaccessmap), 3, 2032, 26);
insert into ui.panelaccessmap (panelaccessmap, panelid, groupid, workflowid) VALUES ((select max(panelaccessmap)+1 from ui.panelaccessmap), 4, 2032, 26);
insert into ui.panelaccessmap (panelaccessmap, panelid, groupid, workflowid) VALUES ((select max(panelaccessmap)+1 from ui.panelaccessmap), 5, 2032, 26);

--groupfilteracccess for tenantid=2, 3 and 4
INSERT INTO ui.grouptotaskfiltermap( iposition, igroupid, itaskfilterid)
 SELECT 1, igroupid, 1
 FROM
 ui.groupdesc where itenantid=2 or itenantid=3 or itenantid=4;


 INSERT INTO ui.grouptotaskfiltermap( iposition, igroupid, itaskfilterid)
 SELECT 2, igroupid, 2
 FROM
 ui.groupdesc where itenantid=2 or itenantid=3 or itenantid=4;


 INSERT INTO ui.grouptotaskfiltermap(iposition, igroupid, itaskfilterid)
 SELECT 3, igroupid, 3
 FROM
 ui.groupdesc where vcgroupid in ('riskanalyst', 'risksupervisor') and (itenantid=2 or itenantid=3 or itenantid=4);


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

 INSERT INTO ui.grouptotaskfiltermap( iposition, igroupid, itaskfilterid)
 SELECT 10, igroupid, 10
 FROM ui.groupdesc
 where vcgroupid in ('level1', 'level2',
 				   'level3', 'level4', 'level5'
 				  , 'db','branch','it') and (itenantid=2 or itenantid=3 or itenantid=4);

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
where vcmenuname='Case Management') and vcmenuname != 'Reports' and vcmenuname != 'Upload Chargeback' and vcmenuname != 'Dashboards' and vcmenuname != 'Process Bulk Tickets';

insert into ui.rolemenuaccessmap 
(badd, bapprove, bdelete, bedit, bpublish, bview, istatus, imenuid, iroleid)
select true, true, true, true, true, true, true, imenuid, 14 from
ui.menustructuredesc where imenuid = (select imenuid from ui.menustructuredesc
where vcmenuname='Case Management');

insert into ui.rolemenuaccessmap 
(badd, bapprove, bdelete, bedit, bpublish, bview, istatus, imenuid, iroleid)
select true, true, true, true, true, true, true, imenuid, 14 from
ui.menustructuredesc where iparentmenu = (select imenuid from ui.menustructuredesc
where vcmenuname='Case Management') and vcmenuname != 'Reports' and vcmenuname != 'Upload Chargeback' and vcmenuname != 'Dashboards' and vcmenuname != 'Process Bulk Tickets';

insert into ui.rolemenuaccessmap 
(badd, bapprove, bdelete, bedit, bpublish, bview, istatus, imenuid, iroleid)
select true, true, true, true, true, true, true, imenuid, 15 from
ui.menustructuredesc where imenuid = (select imenuid from ui.menustructuredesc
where vcmenuname='Case Management');

insert into ui.rolemenuaccessmap 
(badd, bapprove, bdelete, bedit, bpublish, bview, istatus, imenuid, iroleid)
select true, true, true, true, true, true, true, imenuid, 15 from
ui.menustructuredesc where iparentmenu = (select imenuid from ui.menustructuredesc
where vcmenuname='Case Management') and vcmenuname != 'Reports' and vcmenuname != 'Upload Chargeback' and vcmenuname != 'Dashboards' and vcmenuname != 'Process Bulk Tickets';

insert into ui.rolemenuaccessmap 
(badd, bapprove, bdelete, bedit, bpublish, bview, istatus, imenuid, iroleid)
select true, true, true, true, true, true, true, imenuid, 16 from
ui.menustructuredesc where imenuid = (select imenuid from ui.menustructuredesc
where vcmenuname='Case Management');

insert into ui.rolemenuaccessmap 
(badd, bapprove, bdelete, bedit, bpublish, bview, istatus, imenuid, iroleid)
select true, true, true, true, true, true, true, imenuid, 16 from
ui.menustructuredesc where iparentmenu = (select imenuid from ui.menustructuredesc
where vcmenuname='Case Management') and vcmenuname != 'Reports' and vcmenuname != 'Upload Chargeback' and vcmenuname != 'Dashboards' and vcmenuname != 'Process Bulk Tickets';

insert into ui.rolemenuaccessmap 
(badd, bapprove, bdelete, bedit, bpublish, bview, istatus, imenuid, iroleid)
select true, true, true, true, true, true, true, imenuid, 17 from
ui.menustructuredesc where imenuid = (select imenuid from ui.menustructuredesc
where vcmenuname='Case Management');

insert into ui.rolemenuaccessmap 
(badd, bapprove, bdelete, bedit, bpublish, bview, istatus, imenuid, iroleid)
select true, true, true, true, true, true, true, imenuid, 17 from
ui.menustructuredesc where iparentmenu = (select imenuid from ui.menustructuredesc
where vcmenuname='Case Management') and vcmenuname != 'Reports' and vcmenuname != 'Upload Chargeback' and vcmenuname != 'Dashboards' and vcmenuname != 'Process Bulk Tickets';

insert into ui.rolemenuaccessmap 
(badd, bapprove, bdelete, bedit, bpublish, bview, istatus, imenuid, iroleid)
select true, true, true, true, true, true, true, imenuid, 18 from
ui.menustructuredesc where imenuid = (select imenuid from ui.menustructuredesc
where vcmenuname='Case Management');

insert into ui.rolemenuaccessmap 
(badd, bapprove, bdelete, bedit, bpublish, bview, istatus, imenuid, iroleid)
select true, true, true, true, true, true, true, imenuid, 18 from
ui.menustructuredesc where iparentmenu = (select imenuid from ui.menustructuredesc
where vcmenuname='Case Management') and vcmenuname != 'Reports' and vcmenuname != 'Upload Chargeback' and vcmenuname != 'Dashboards' and vcmenuname != 'Process Bulk Tickets';

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