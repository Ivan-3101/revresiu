
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
}'::jsonb where iorgid = 1;


insert into ui.organizations(iorgid, attribs, vcorgid, irecordstatus, config) 
select iorgid, attribs, vcorgid, irecordstatus, config from masters.orgs;

insert into ui.tenants(itenantid, vctenantid, irecordstatus, iorg_id, config, attribs)
select itenantid, vctenantid, irecordstatus, iorgid, config, attribs from masters.tenants;

update ui.webuser set iorgid=1 where iorgid is null;
update ui.webuseraudit set iorgid=1 where iorgid is null;

insert into ui.webusermapping
select -1 as mappingid,'Workflow' as mappingtype,iuserid as webuserid from ui.webuser where iorgid=1;

insert into ui.webusermapping
select -1 as mappingid,'TransactionClass' as mappingtype,iuserid as webuserid from ui.webuser where iorgid=1;

insert into ui.webusermapping
select 1 as mappingid,'Tenant' as mappingtype,iuserid as webuserid from ui.webuser where iorgid=1;

insert into ui.webusermapping
select iroleid as mappingid,'Role' as mappingtype,iuserid as webuserid from ui.userrolemap;

insert into ui.webusermapping
select igroupid as mappingid,'Group' as mappingtype,iuserid as webuserid  from ui.usergroupmap;


insert into ui.webusermappingaudit
select -1 as mappingid,'Workflow' as mappingtype,iuserauditid as webuserauditid from ui.webuseraudit where iorgid=1;

insert into ui.webusermappingaudit
select -1 as mappingid,'TransactionClass' as mappingtype,iuserauditid as webuserauditid from ui.webuseraudit where iorgid=1;

insert into ui.webusermappingaudit
select 1 as mappingid,'Tenant' as mappingtype,iuserauditid as webuserauditid from ui.webuseraudit where iorgid=1;

insert into ui.webusermappingaudit
select user_permissions_iroleid as mappingid,'Role' as mappingtype,web_user_audit_iuserauditid as webuserauditid from ui.userrolemapaudit;

insert into ui.webusermappingaudit
select igroupid as mappingid,'Group' as mappingtype,iuserauditid as webuserauditid  from ui.usergroupmapaudit;

update ui.listmaster set itenantid=1 where ilistmasterid>2;
update ui.workflowmasters set itenantid=1 where itenantid is null;
update ui.roledesc set itenantid=1 where itenantid is null;
update ui.metadata set itenantid=1 where itenantid is null;
update ui.decisions set itenantid=1 where itenantid is null;
update ui.groupdesc set itenantid=1 where itenantid is null and vcgrouptype!='INTERNAL';
update ui.decisionsworkflowaudit set itenantid=1 where itenantid is null;
update ui.decisionsaudit set itenantid=1 where itenantid is null;
update ui.list set itenantid=1 where itenantid is null;
update ui.observationwindowsuiaudit set itenantid=1 where itenantid is null;
update ui.observationwindowsui set itenantid=1 where itenantid is null;
update ui.metadataaudit set itenantid=1 where itenantid is null;
update ui.transactionclasses set itenantid=1 where itenantid is null;
update ui.transactionclassesaudit set itenantid=1 where itenantid is null;
update ui.listaudit set itenantid=1 where itenantid is null;