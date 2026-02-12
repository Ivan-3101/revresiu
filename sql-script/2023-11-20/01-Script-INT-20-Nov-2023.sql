UPDATE masters.orgs set attribs = '{
  "ssoConfig": {
    "uiserver.sso": false,
    "drona.ui.scope": "api://a9bac42e-4ccd-4a4b-942c-62638b6e90bc/app",
    "uiserver.sso.type": "openid",
    "drona.ui.authorize": "https://login.microsoftonline.com/d3b68a64-18d1-4938-b5ff-47acb471191c/oauth2/v2.0/authorize",
    "drona.ui.logout.url": "https://login.microsoftonline.com/d3b68a64-18d1-4938-b5ff-47acb471191c/oauth2/logout",
    "drona.ui.redirect.url": "http://localhost:3001"
  },
  "vclogourl": "",
  "pismo.processing.enabled": true
}'::jsonb where iorgid = 2;

insert into ui.organizations(iorgid, attribs, vcorgid, irecordstatus, config) 
select iorgid, attribs, vcorgid, irecordstatus, config from masters.orgs where iorgid=2;

insert into ui.tenants(itenantid, vctenantid, irecordstatus, iorg_id, config, attribs)
select itenantid, vctenantid, irecordstatus, iorgid, config, attribs from masters.tenants where iorgid=2;

update ui.webusermapping set mappingid = 1 where (webuserid=1 or webuserid=2) and mappingtype='Role';

insert into ui.webusermapping 
select 2 as mappingid,'Tenant' as mappingtype,iuserid as webuserid from ui.webuser where iuserid=1 or iuserid=2;

insert into ui.webusermapping 
select 3 as mappingid,'Tenant' as mappingtype,iuserid as webuserid from ui.webuser where iuserid=1 or iuserid=2;

INSERT INTO ui.roledesc (
iroleid, dtentrystamp, vcrolename, istatus, itenantid) VALUES (
'13'::integer, now(), 'Risk Analyst'::character varying, '1'::integer, '2'::integer)
 returning iroleid;

INSERT INTO ui.roledesc (
iroleid, dtentrystamp, vcrolename, istatus, itenantid) VALUES (
'14'::integer, now(), 'Risk Supervisor'::character varying, '1'::integer, '2'::integer)
 returning iroleid;

INSERT INTO ui.roledesc (
iroleid, dtentrystamp, vcrolename, istatus, itenantid) VALUES (
'15'::integer, now(), 'Risk Analyst'::character varying, '1'::integer, '3'::integer)
 returning iroleid;

INSERT INTO ui.roledesc (
iroleid, dtentrystamp, vcrolename, istatus, itenantid) VALUES (
'16'::integer, now(), 'Risk Supervisor'::character varying, '1'::integer, '3'::integer)
 returning iroleid;

 INSERT INTO ui.roledesc (
iroleid, dtentrystamp, vcrolename, istatus, itenantid) VALUES (
'17'::integer, now(), 'Risk Analyst'::character varying, '1'::integer, '4'::integer)
 returning iroleid;

INSERT INTO ui.roledesc (
iroleid, dtentrystamp, vcrolename, istatus, itenantid) VALUES (
'18'::integer, now(), 'Risk Supervisor'::character varying, '1'::integer, '4'::integer)
 returning iroleid;
---------------------risk analyst 13 configuration starts--------

insert into ui.rolemenuaccessmap 
(badd, bapprove, bdelete, bedit, bpublish, bview, istatus, imenuid, iroleid)
select true, true, true, true, true, true, true, imenuid, 13 from
ui.menustructuredesc where imenuid = (select imenuid from ui.menustructuredesc
where vcmenuname='Masters');

 insert into ui.rolemenuaccessmap 
(badd, bapprove, bdelete, bedit, bpublish, bview, istatus, imenuid, iroleid)
select true, true, true, true, true, true, true, imenuid, 13 from
ui.menustructuredesc where iparentmenu = (select imenuid from ui.menustructuredesc
where vcmenuname='Masters');

 insert into ui.rolemenuaccessmap 
(badd, bapprove, bdelete, bedit, bpublish, bview, istatus, imenuid, iroleid)
select true, true, true, true, true, true, true, imenuid, 13 from
ui.menustructuredesc where iparentmenu = (select imenuid from ui.menustructuredesc
where vcmenuname='Class');


insert into ui.rolemenuaccessmap 
(badd, bapprove, bdelete, bedit, bpublish, bview, istatus, imenuid, iroleid)
select true, true, true, true, true, true, true, imenuid, 13 from
ui.menustructuredesc where iparentmenu = (select imenuid from ui.menustructuredesc
where vcmenuname='Decision');

insert into ui.rolemenuaccessmap 
(badd, bapprove, bdelete, bedit, bpublish, bview, istatus, imenuid, iroleid)
select true, true, true, true, true, true, true, imenuid, 13 from
ui.menustructuredesc where iparentmenu = (select imenuid from ui.menustructuredesc
where vcmenuname='Rules');

insert into ui.rolemenuaccessmap 
(badd, bapprove, bdelete, bedit, bpublish, bview, istatus, imenuid, iroleid)
select true, true, true, true, true, true, true, imenuid, 13 from
ui.menustructuredesc where iparentmenu = (select imenuid from ui.menustructuredesc
where vcmenuname='List');

insert into ui.rolemenuaccessmap 
(badd, bapprove, bdelete, bedit, bpublish, bview, istatus, imenuid, iroleid)
select true, true, true, true, true, true, true, imenuid, 13 from
ui.menustructuredesc where iparentmenu = (select imenuid from ui.menustructuredesc
where vcmenuname='RT Window');

insert into ui.rolemenuaccessmap 
(badd, bapprove, bdelete, bedit, bpublish, bview, istatus, imenuid, iroleid)
select true, true, true, true, true, true, true, imenuid, 13 from
ui.menustructuredesc where iparentmenu = (select imenuid from ui.menustructuredesc
where vcmenuname='RT Observation');

insert into ui.rolemenuaccessmap 
(badd, bapprove, bdelete, bedit, bpublish, bview, istatus, imenuid, iroleid)
select true, true, true, true, true, true, true, imenuid, 13 from
ui.menustructuredesc where iparentmenu = (select imenuid from ui.menustructuredesc
where vcmenuname='Historic Profile');

----------risk analyst 13 configuration ends------

---------------------risk supervisor 14 configuration starts--------

insert into ui.rolemenuaccessmap 
(badd, bapprove, bdelete, bedit, bpublish, bview, istatus, imenuid, iroleid)
select true, true, true, true, true, true, true, imenuid, 14 from
ui.menustructuredesc where imenuid = (select imenuid from ui.menustructuredesc
where vcmenuname='Admin');

insert into ui.rolemenuaccessmap 
(badd, bapprove, bdelete, bedit, bpublish, bview, istatus, imenuid, iroleid)
select true, true, true, true, true, true, true, imenuid, 14 from
ui.menustructuredesc where imenuid = (select imenuid from ui.menustructuredesc
where vcmenuname='User Management');

insert into ui.rolemenuaccessmap 
(badd, bapprove, bdelete, bedit, bpublish, bview, istatus, imenuid, iroleid)
select true, true, true, true, true, true, true, imenuid, 14 from
ui.menustructuredesc where iparentmenu = (select imenuid from ui.menustructuredesc
where vcmenuname='User Management');

insert into ui.rolemenuaccessmap 
(badd, bapprove, bdelete, bedit, bpublish, bview, istatus, imenuid, iroleid)
select true, true, true, true, true, true, true, imenuid, 14 from
ui.menustructuredesc where imenuid = (select imenuid from ui.menustructuredesc
where vcmenuname='Masters');

 insert into ui.rolemenuaccessmap 
(badd, bapprove, bdelete, bedit, bpublish, bview, istatus, imenuid, iroleid)
select true, true, true, true, true, true, true, imenuid, 14 from
ui.menustructuredesc where iparentmenu = (select imenuid from ui.menustructuredesc
where vcmenuname='Masters');

 insert into ui.rolemenuaccessmap 
(badd, bapprove, bdelete, bedit, bpublish, bview, istatus, imenuid, iroleid)
select true, true, true, true, true, true, true, imenuid, 14 from
ui.menustructuredesc where iparentmenu = (select imenuid from ui.menustructuredesc
where vcmenuname='Class');

insert into ui.rolemenuaccessmap 
(badd, bapprove, bdelete, bedit, bpublish, bview, istatus, imenuid, iroleid)
select true, true, true, true, true, true, true, imenuid, 14 from
ui.menustructuredesc where iparentmenu = (select imenuid from ui.menustructuredesc
where vcmenuname='Decision');

insert into ui.rolemenuaccessmap 
(badd, bapprove, bdelete, bedit, bpublish, bview, istatus, imenuid, iroleid)
select true, true, true, true, true, true, true, imenuid, 14 from
ui.menustructuredesc where iparentmenu = (select imenuid from ui.menustructuredesc
where vcmenuname='Rules');

insert into ui.rolemenuaccessmap 
(badd, bapprove, bdelete, bedit, bpublish, bview, istatus, imenuid, iroleid)
select true, true, true, true, true, true, true, imenuid, 14 from
ui.menustructuredesc where iparentmenu = (select imenuid from ui.menustructuredesc
where vcmenuname='List');

insert into ui.rolemenuaccessmap 
(badd, bapprove, bdelete, bedit, bpublish, bview, istatus, imenuid, iroleid)
select true, true, true, true, true, true, true, imenuid, 14 from
ui.menustructuredesc where iparentmenu = (select imenuid from ui.menustructuredesc
where vcmenuname='RT Window');

insert into ui.rolemenuaccessmap 
(badd, bapprove, bdelete, bedit, bpublish, bview, istatus, imenuid, iroleid)
select true, true, true, true, true, true, true, imenuid, 14 from
ui.menustructuredesc where iparentmenu = (select imenuid from ui.menustructuredesc
where vcmenuname='RT Observation');

insert into ui.rolemenuaccessmap 
(badd, bapprove, bdelete, bedit, bpublish, bview, istatus, imenuid, iroleid)
select true, true, true, true, true, true, true, imenuid, 14 from
ui.menustructuredesc where iparentmenu = (select imenuid from ui.menustructuredesc
where vcmenuname='Historic Profile');

----------risk supervisor 14 configuration ends------

---------------------risk analyst 15 configuration starts--------

insert into ui.rolemenuaccessmap 
(badd, bapprove, bdelete, bedit, bpublish, bview, istatus, imenuid, iroleid)
select true, true, true, true, true, true, true, imenuid, 15 from
ui.menustructuredesc where imenuid = (select imenuid from ui.menustructuredesc
where vcmenuname='Masters');

 insert into ui.rolemenuaccessmap 
(badd, bapprove, bdelete, bedit, bpublish, bview, istatus, imenuid, iroleid)
select true, true, true, true, true, true, true, imenuid, 15 from
ui.menustructuredesc where iparentmenu = (select imenuid from ui.menustructuredesc
where vcmenuname='Masters');

 insert into ui.rolemenuaccessmap 
(badd, bapprove, bdelete, bedit, bpublish, bview, istatus, imenuid, iroleid)
select true, true, true, true, true, true, true, imenuid, 15 from
ui.menustructuredesc where iparentmenu = (select imenuid from ui.menustructuredesc
where vcmenuname='Class');


insert into ui.rolemenuaccessmap 
(badd, bapprove, bdelete, bedit, bpublish, bview, istatus, imenuid, iroleid)
select true, true, true, true, true, true, true, imenuid, 15 from
ui.menustructuredesc where iparentmenu = (select imenuid from ui.menustructuredesc
where vcmenuname='Decision');

insert into ui.rolemenuaccessmap 
(badd, bapprove, bdelete, bedit, bpublish, bview, istatus, imenuid, iroleid)
select true, true, true, true, true, true, true, imenuid, 15 from
ui.menustructuredesc where iparentmenu = (select imenuid from ui.menustructuredesc
where vcmenuname='Rules');

insert into ui.rolemenuaccessmap 
(badd, bapprove, bdelete, bedit, bpublish, bview, istatus, imenuid, iroleid)
select true, true, true, true, true, true, true, imenuid, 15 from
ui.menustructuredesc where iparentmenu = (select imenuid from ui.menustructuredesc
where vcmenuname='List');

insert into ui.rolemenuaccessmap 
(badd, bapprove, bdelete, bedit, bpublish, bview, istatus, imenuid, iroleid)
select true, true, true, true, true, true, true, imenuid, 15 from
ui.menustructuredesc where iparentmenu = (select imenuid from ui.menustructuredesc
where vcmenuname='RT Window');

insert into ui.rolemenuaccessmap 
(badd, bapprove, bdelete, bedit, bpublish, bview, istatus, imenuid, iroleid)
select true, true, true, true, true, true, true, imenuid, 15 from
ui.menustructuredesc where iparentmenu = (select imenuid from ui.menustructuredesc
where vcmenuname='RT Observation');

insert into ui.rolemenuaccessmap 
(badd, bapprove, bdelete, bedit, bpublish, bview, istatus, imenuid, iroleid)
select true, true, true, true, true, true, true, imenuid, 15 from
ui.menustructuredesc where iparentmenu = (select imenuid from ui.menustructuredesc
where vcmenuname='Historic Profile');

----------risk analyst 15 configuration ends------

---------------------risk supervisor 16 configuration starts--------

insert into ui.rolemenuaccessmap 
(badd, bapprove, bdelete, bedit, bpublish, bview, istatus, imenuid, iroleid)
select true, true, true, true, true, true, true, imenuid, 16 from
ui.menustructuredesc where imenuid = (select imenuid from ui.menustructuredesc
where vcmenuname='Admin');

insert into ui.rolemenuaccessmap 
(badd, bapprove, bdelete, bedit, bpublish, bview, istatus, imenuid, iroleid)
select true, true, true, true, true, true, true, imenuid, 16 from
ui.menustructuredesc where imenuid = (select imenuid from ui.menustructuredesc
where vcmenuname='User Management');

insert into ui.rolemenuaccessmap 
(badd, bapprove, bdelete, bedit, bpublish, bview, istatus, imenuid, iroleid)
select true, true, true, true, true, true, true, imenuid, 16 from
ui.menustructuredesc where iparentmenu = (select imenuid from ui.menustructuredesc
where vcmenuname='User Management');

insert into ui.rolemenuaccessmap 
(badd, bapprove, bdelete, bedit, bpublish, bview, istatus, imenuid, iroleid)
select true, true, true, true, true, true, true, imenuid, 16 from
ui.menustructuredesc where imenuid = (select imenuid from ui.menustructuredesc
where vcmenuname='Masters');

 insert into ui.rolemenuaccessmap 
(badd, bapprove, bdelete, bedit, bpublish, bview, istatus, imenuid, iroleid)
select true, true, true, true, true, true, true, imenuid, 16 from
ui.menustructuredesc where iparentmenu = (select imenuid from ui.menustructuredesc
where vcmenuname='Masters');

 insert into ui.rolemenuaccessmap 
(badd, bapprove, bdelete, bedit, bpublish, bview, istatus, imenuid, iroleid)
select true, true, true, true, true, true, true, imenuid, 16 from
ui.menustructuredesc where iparentmenu = (select imenuid from ui.menustructuredesc
where vcmenuname='Class');

insert into ui.rolemenuaccessmap 
(badd, bapprove, bdelete, bedit, bpublish, bview, istatus, imenuid, iroleid)
select true, true, true, true, true, true, true, imenuid, 16 from
ui.menustructuredesc where iparentmenu = (select imenuid from ui.menustructuredesc
where vcmenuname='Decision');

insert into ui.rolemenuaccessmap 
(badd, bapprove, bdelete, bedit, bpublish, bview, istatus, imenuid, iroleid)
select true, true, true, true, true, true, true, imenuid, 16 from
ui.menustructuredesc where iparentmenu = (select imenuid from ui.menustructuredesc
where vcmenuname='Rules');

insert into ui.rolemenuaccessmap 
(badd, bapprove, bdelete, bedit, bpublish, bview, istatus, imenuid, iroleid)
select true, true, true, true, true, true, true, imenuid, 16 from
ui.menustructuredesc where iparentmenu = (select imenuid from ui.menustructuredesc
where vcmenuname='List');

insert into ui.rolemenuaccessmap 
(badd, bapprove, bdelete, bedit, bpublish, bview, istatus, imenuid, iroleid)
select true, true, true, true, true, true, true, imenuid, 16 from
ui.menustructuredesc where iparentmenu = (select imenuid from ui.menustructuredesc
where vcmenuname='RT Window');

insert into ui.rolemenuaccessmap 
(badd, bapprove, bdelete, bedit, bpublish, bview, istatus, imenuid, iroleid)
select true, true, true, true, true, true, true, imenuid, 16 from
ui.menustructuredesc where iparentmenu = (select imenuid from ui.menustructuredesc
where vcmenuname='RT Observation');

insert into ui.rolemenuaccessmap 
(badd, bapprove, bdelete, bedit, bpublish, bview, istatus, imenuid, iroleid)
select true, true, true, true, true, true, true, imenuid, 16 from
ui.menustructuredesc where iparentmenu = (select imenuid from ui.menustructuredesc
where vcmenuname='Historic Profile');

----------risk supervisor 16 configuration ends------

---------------------risk analyst 17 configuration starts--------

insert into ui.rolemenuaccessmap 
(badd, bapprove, bdelete, bedit, bpublish, bview, istatus, imenuid, iroleid)
select true, true, true, true, true, true, true, imenuid, 17 from
ui.menustructuredesc where imenuid = (select imenuid from ui.menustructuredesc
where vcmenuname='Masters');

 insert into ui.rolemenuaccessmap 
(badd, bapprove, bdelete, bedit, bpublish, bview, istatus, imenuid, iroleid)
select true, true, true, true, true, true, true, imenuid, 17 from
ui.menustructuredesc where iparentmenu = (select imenuid from ui.menustructuredesc
where vcmenuname='Masters');

 insert into ui.rolemenuaccessmap 
(badd, bapprove, bdelete, bedit, bpublish, bview, istatus, imenuid, iroleid)
select true, true, true, true, true, true, true, imenuid, 17 from
ui.menustructuredesc where iparentmenu = (select imenuid from ui.menustructuredesc
where vcmenuname='Class');


insert into ui.rolemenuaccessmap 
(badd, bapprove, bdelete, bedit, bpublish, bview, istatus, imenuid, iroleid)
select true, true, true, true, true, true, true, imenuid, 17 from
ui.menustructuredesc where iparentmenu = (select imenuid from ui.menustructuredesc
where vcmenuname='Decision');

insert into ui.rolemenuaccessmap 
(badd, bapprove, bdelete, bedit, bpublish, bview, istatus, imenuid, iroleid)
select true, true, true, true, true, true, true, imenuid, 17 from
ui.menustructuredesc where iparentmenu = (select imenuid from ui.menustructuredesc
where vcmenuname='Rules');

insert into ui.rolemenuaccessmap 
(badd, bapprove, bdelete, bedit, bpublish, bview, istatus, imenuid, iroleid)
select true, true, true, true, true, true, true, imenuid, 17 from
ui.menustructuredesc where iparentmenu = (select imenuid from ui.menustructuredesc
where vcmenuname='List');

insert into ui.rolemenuaccessmap 
(badd, bapprove, bdelete, bedit, bpublish, bview, istatus, imenuid, iroleid)
select true, true, true, true, true, true, true, imenuid, 17 from
ui.menustructuredesc where iparentmenu = (select imenuid from ui.menustructuredesc
where vcmenuname='RT Window');

insert into ui.rolemenuaccessmap 
(badd, bapprove, bdelete, bedit, bpublish, bview, istatus, imenuid, iroleid)
select true, true, true, true, true, true, true, imenuid, 17 from
ui.menustructuredesc where iparentmenu = (select imenuid from ui.menustructuredesc
where vcmenuname='RT Observation');

insert into ui.rolemenuaccessmap 
(badd, bapprove, bdelete, bedit, bpublish, bview, istatus, imenuid, iroleid)
select true, true, true, true, true, true, true, imenuid, 17 from
ui.menustructuredesc where iparentmenu = (select imenuid from ui.menustructuredesc
where vcmenuname='Historic Profile');

----------risk analyst 17 configuration ends------

---------------------risk supervisor 18 configuration starts--------

insert into ui.rolemenuaccessmap 
(badd, bapprove, bdelete, bedit, bpublish, bview, istatus, imenuid, iroleid)
select true, true, true, true, true, true, true, imenuid, 18 from
ui.menustructuredesc where imenuid = (select imenuid from ui.menustructuredesc
where vcmenuname='Admin');

insert into ui.rolemenuaccessmap 
(badd, bapprove, bdelete, bedit, bpublish, bview, istatus, imenuid, iroleid)
select true, true, true, true, true, true, true, imenuid, 18 from
ui.menustructuredesc where imenuid = (select imenuid from ui.menustructuredesc
where vcmenuname='User Management');

insert into ui.rolemenuaccessmap 
(badd, bapprove, bdelete, bedit, bpublish, bview, istatus, imenuid, iroleid)
select true, true, true, true, true, true, true, imenuid, 18 from
ui.menustructuredesc where iparentmenu = (select imenuid from ui.menustructuredesc
where vcmenuname='User Management');

insert into ui.rolemenuaccessmap 
(badd, bapprove, bdelete, bedit, bpublish, bview, istatus, imenuid, iroleid)
select true, true, true, true, true, true, true, imenuid, 18 from
ui.menustructuredesc where imenuid = (select imenuid from ui.menustructuredesc
where vcmenuname='Masters');

 insert into ui.rolemenuaccessmap 
(badd, bapprove, bdelete, bedit, bpublish, bview, istatus, imenuid, iroleid)
select true, true, true, true, true, true, true, imenuid, 18 from
ui.menustructuredesc where iparentmenu = (select imenuid from ui.menustructuredesc
where vcmenuname='Masters');

 insert into ui.rolemenuaccessmap 
(badd, bapprove, bdelete, bedit, bpublish, bview, istatus, imenuid, iroleid)
select true, true, true, true, true, true, true, imenuid, 18 from
ui.menustructuredesc where iparentmenu = (select imenuid from ui.menustructuredesc
where vcmenuname='Class');

insert into ui.rolemenuaccessmap 
(badd, bapprove, bdelete, bedit, bpublish, bview, istatus, imenuid, iroleid)
select true, true, true, true, true, true, true, imenuid, 18 from
ui.menustructuredesc where iparentmenu = (select imenuid from ui.menustructuredesc
where vcmenuname='Decision');

insert into ui.rolemenuaccessmap 
(badd, bapprove, bdelete, bedit, bpublish, bview, istatus, imenuid, iroleid)
select true, true, true, true, true, true, true, imenuid, 18 from
ui.menustructuredesc where iparentmenu = (select imenuid from ui.menustructuredesc
where vcmenuname='Rules');

insert into ui.rolemenuaccessmap 
(badd, bapprove, bdelete, bedit, bpublish, bview, istatus, imenuid, iroleid)
select true, true, true, true, true, true, true, imenuid, 18 from
ui.menustructuredesc where iparentmenu = (select imenuid from ui.menustructuredesc
where vcmenuname='List');

insert into ui.rolemenuaccessmap 
(badd, bapprove, bdelete, bedit, bpublish, bview, istatus, imenuid, iroleid)
select true, true, true, true, true, true, true, imenuid, 18 from
ui.menustructuredesc where iparentmenu = (select imenuid from ui.menustructuredesc
where vcmenuname='RT Window');

insert into ui.rolemenuaccessmap 
(badd, bapprove, bdelete, bedit, bpublish, bview, istatus, imenuid, iroleid)
select true, true, true, true, true, true, true, imenuid, 18 from
ui.menustructuredesc where iparentmenu = (select imenuid from ui.menustructuredesc
where vcmenuname='RT Observation');

insert into ui.rolemenuaccessmap 
(badd, bapprove, bdelete, bedit, bpublish, bview, istatus, imenuid, iroleid)
select true, true, true, true, true, true, true, imenuid, 18 from
ui.menustructuredesc where iparentmenu = (select imenuid from ui.menustructuredesc
where vcmenuname='Historic Profile');

----------risk supervisor 18 configuration ends------


-----workflow configuration starts
insert into ui.workflowmasters (workflowid, workflowname, workflowkey, is_filter_display, itenantid) VALUES
(18, 'Risk Alert', 'YbFrmAlert', true, 2);

insert into ui.workflowmasters (workflowid, workflowname, workflowkey, is_filter_display, itenantid) VALUES
(19, 'Blocked Settlements', 'YbFrmBlockSettlement', true, 2);

insert into ui.workflowmasters (workflowid, workflowname, workflowkey, is_filter_display, itenantid) VALUES
(20, 'AML Cases', 'AMLCases', true, 2);

insert into ui.workflowmasters (workflowid, workflowname, workflowkey, is_filter_display, itenantid) VALUES
(21, 'Risk Alert', 'YbFrmAlert', true, 3);

insert into ui.workflowmasters (workflowid, workflowname, workflowkey, is_filter_display, itenantid) VALUES
(22, 'Blocked Settlements', 'YbFrmBlockSettlement', true, 3);

insert into ui.workflowmasters (workflowid, workflowname, workflowkey, is_filter_display, itenantid) VALUES
(23, 'AML Cases', 'AMLCases', true, 3);

insert into ui.workflowmasters (workflowid, workflowname, workflowkey, is_filter_display, itenantid) VALUES
(24, 'Risk Alert', 'YbFrmAlert', true, 4);

insert into ui.workflowmasters (workflowid, workflowname, workflowkey, is_filter_display, itenantid) VALUES
(25, 'Blocked Settlements', 'YbFrmBlockSettlement', true, 4);

insert into ui.workflowmasters (workflowid, workflowname, workflowkey, is_filter_display, itenantid) VALUES
(26, 'AML Cases', 'AMLCases', true, 4);
----workflow configuration ends

--org 2 solo users--
INSERT INTO ui.webuser (dtapproverstamp, dtentrystamp, dtlastlogindate, vcaddress, vccontact, vcdesignation, vcemailid, vcfirstname, vclastname, vcmobile, vcpassword, vcprofileimg, vcusername, iapproveruserid, ientryuserid, istatus, timezones, resetpasswordtoken, dtlastpasswordupdate, loginattempts, iorgid) VALUES ('2023-06-10 13:47:12.625', '2023-03-22 11:17:35.851', '2023-10-30 15:19:06.481', NULL, '9988', 'CEO', 'cadmin@solo.com', 'cadmin', 'cadmin', '7219024345', '$2a$10$EoTv5mhWPRxMbRTBYJ0V4ucuG761Lb7Cp8T/pJZOc8/szTepMVNm.', '', 'cadmin@solo.com', 2, 1, 1, 'Asia/Kolkata', '6HTThBznzAaZtr52O9YcsSEQ6ZaslB', '2023-10-09 19:46:14.746', 0, 2);
INSERT INTO ui.webuser (dtapproverstamp, dtentrystamp, dtlastlogindate, vcaddress, vccontact, vcdesignation, vcemailid, vcfirstname, vclastname, vcmobile, vcpassword, vcprofileimg, vcusername, iapproveruserid, ientryuserid, istatus, timezones, resetpasswordtoken, dtlastpasswordupdate, loginattempts, iorgid) VALUES ('2023-06-10 13:47:12.625', '2023-03-22 11:17:35.851', '2023-10-30 15:19:06.481', NULL, '9988', 'CEO', 'madmin@solo.com', 'madmin', 'madmin', '7219024345', '$2a$10$EoTv5mhWPRxMbRTBYJ0V4ucuG761Lb7Cp8T/pJZOc8/szTepMVNm.', '', 'madmin@solo.com', 2, 1, 1, 'Asia/Kolkata', '6HTThBznzAaZtr52O9YcsSEQ6ZaslB', '2023-10-09 19:46:14.746', 0, 2);

insert into ui.webusermapping (mappingid, mappingtype, webuserid) VALUES (4,
'Tenant', (select iuserid from ui.webuser where vcusername='cadmin@solo.com'));

insert into ui.webusermapping (mappingid, mappingtype, webuserid) VALUES (18,
'Role', (select iuserid from ui.webuser where vcusername='cadmin@solo.com'));

insert into ui.webusermapping (mappingid, mappingtype, webuserid) VALUES (-1,
'TransactionClass', (select iuserid from ui.webuser where vcusername='cadmin@solo.com'));

insert into ui.webusermapping (mappingid, mappingtype, webuserid) VALUES (-1,
'Workflow', (select iuserid from ui.webuser where vcusername='cadmin@solo.com'));

insert into ui.webusermapping (mappingid, mappingtype, webuserid) VALUES (4,
'Tenant', (select iuserid from ui.webuser where vcusername='madmin@solo.com'));

insert into ui.webusermapping (mappingid, mappingtype, webuserid) VALUES (18,
'Role', (select iuserid from ui.webuser where vcusername='madmin@solo.com'));

insert into ui.webusermapping (mappingid, mappingtype, webuserid) VALUES (-1,
'TransactionClass', (select iuserid from ui.webuser where vcusername='madmin@solo.com'));

insert into ui.webusermapping (mappingid, mappingtype, webuserid) VALUES (-1,
'Workflow', (select iuserid from ui.webuser where vcusername='madmin@solo.com'));

---groups configuration

--tenant 2 starts--
INSERT INTO ui.groupdesc (
igroupid, vcgroupid, vcgroupname, vcgrouptype, istatus, itenantid) VALUES (
'2000'::integer, 'level1'::character varying, 'L1'::character varying, 'WORKFLOW'::character varying, '1'::integer, '2'::integer)
 returning igroupid;

 INSERT INTO ui.groupdesc (
igroupid, vcgroupid, vcgroupname, vcgrouptype, istatus, itenantid) VALUES (
'2001'::integer, 'level2'::character varying, 'L2'::character varying, 'WORKFLOW'::character varying, '1'::integer, '2'::integer)
 returning igroupid;

 INSERT INTO ui.groupdesc (
igroupid, vcgroupid, vcgroupname, vcgrouptype, istatus, itenantid) VALUES (
'2002'::integer, 'level3'::character varying, 'L3'::character varying, 'WORKFLOW'::character varying, '1'::integer, '2'::integer)
 returning igroupid;

 INSERT INTO ui.groupdesc (
igroupid, vcgroupid, vcgroupname, vcgrouptype, istatus, itenantid) VALUES (
'2003'::integer, 'level4'::character varying, 'L4'::character varying, 'WORKFLOW'::character varying, '1'::integer, '2'::integer)
 returning igroupid;

 INSERT INTO ui.groupdesc (
igroupid, vcgroupid, vcgroupname, vcgrouptype, istatus, itenantid) VALUES (
'2004'::integer, 'level5'::character varying, 'L5'::character varying, 'WORKFLOW'::character varying, '1'::integer, '2'::integer)
 returning igroupid;
 --tenant 2 ends

--tenant 3 starts--
INSERT INTO ui.groupdesc (
igroupid, vcgroupid, vcgroupname, vcgrouptype, istatus, itenantid) VALUES (
'2005'::integer, 'level1'::character varying, 'L1'::character varying, 'WORKFLOW'::character varying, '1'::integer, '3'::integer)
 returning igroupid;

 INSERT INTO ui.groupdesc (
igroupid, vcgroupid, vcgroupname, vcgrouptype, istatus, itenantid) VALUES (
'2006'::integer, 'level2'::character varying, 'L2'::character varying, 'WORKFLOW'::character varying, '1'::integer, '3'::integer)
 returning igroupid;

 INSERT INTO ui.groupdesc (
igroupid, vcgroupid, vcgroupname, vcgrouptype, istatus, itenantid) VALUES (
'2007'::integer, 'level3'::character varying, 'L3'::character varying, 'WORKFLOW'::character varying, '1'::integer, '3'::integer)
 returning igroupid;

 INSERT INTO ui.groupdesc (
igroupid, vcgroupid, vcgroupname, vcgrouptype, istatus, itenantid) VALUES (
'2008'::integer, 'level4'::character varying, 'L4'::character varying, 'WORKFLOW'::character varying, '1'::integer, '3'::integer)
 returning igroupid;

 INSERT INTO ui.groupdesc (
igroupid, vcgroupid, vcgroupname, vcgrouptype, istatus, itenantid) VALUES (
'2009'::integer, 'level5'::character varying, 'L5'::character varying, 'WORKFLOW'::character varying, '1'::integer, '3'::integer)
 returning igroupid;
 --tenant 3 ends

 --tenant 4 starts--
INSERT INTO ui.groupdesc (
igroupid, vcgroupid, vcgroupname, vcgrouptype, istatus, itenantid) VALUES (
'2010'::integer, 'level1'::character varying, 'L1'::character varying, 'WORKFLOW'::character varying, '1'::integer, '4'::integer)
 returning igroupid;

 INSERT INTO ui.groupdesc (
igroupid, vcgroupid, vcgroupname, vcgrouptype, istatus, itenantid) VALUES (
'2011'::integer, 'level2'::character varying, 'L2'::character varying, 'WORKFLOW'::character varying, '1'::integer, '4'::integer)
 returning igroupid;

 INSERT INTO ui.groupdesc (
igroupid, vcgroupid, vcgroupname, vcgrouptype, istatus, itenantid) VALUES (
'2012'::integer, 'level3'::character varying, 'L3'::character varying, 'WORKFLOW'::character varying, '1'::integer, '4'::integer)
 returning igroupid;

 INSERT INTO ui.groupdesc (
igroupid, vcgroupid, vcgroupname, vcgrouptype, istatus, itenantid) VALUES (
'2013'::integer, 'level4'::character varying, 'L4'::character varying, 'WORKFLOW'::character varying, '1'::integer, '4'::integer)
 returning igroupid;

 INSERT INTO ui.groupdesc (
igroupid, vcgroupid, vcgroupname, vcgrouptype, istatus, itenantid) VALUES (
'2014'::integer, 'level5'::character varying, 'L5'::character varying, 'WORKFLOW'::character varying, '1'::integer, '4'::integer)
 returning igroupid;
 --tenant 4 ends