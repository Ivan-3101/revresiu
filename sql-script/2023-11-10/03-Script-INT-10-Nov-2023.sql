delete from masters.tenants;
delete from masters.orgs;

INSERT INTO masters.orgs (iorgid, attribs,
vcorgid, irecordstatus, config) VALUES ('3'::integer, '{
  "ssoConfig": {
    "uiserver.sso": false,
    "drona.ui.scope": "api://a9bac42e-4ccd-4a4b-942c-62638b6e90bc/app",
    "uiserver.sso.type": "openid",
    "drona.ui.authorize": "https://login.microsoftonline.com/d3b68a64-18d1-4938-b5ff-47acb471191c/oauth2/v2.0/authorize",
    "drona.ui.logout.url": "https://login.microsoftonline.com/d3b68a64-18d1-4938-b5ff-47acb471191c/oauth2/logout",
    "drona.ui.redirect.url": "http://localhost:3001"
  },
  "vclogourl": "",
  "pismo.processing.enabled": false
}'::jsonb,
'yesbank'::character varying, '0'::integer, '{}'::jsonb);

INSERT INTO masters.orgs (iorgid, attribs,
vcorgid, irecordstatus, config) VALUES ('4'::integer, '{
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
}'::jsonb,
'42c'::character varying, '0'::integer, '{}'::jsonb);

INSERT INTO masters.tenants (itenantid, vctenantid, irecordstatus, iorgid, config, attribs) VALUES
('3'::integer, 'Yesbank-FRM'::character varying, '0'::integer, '3'::integer, '{"api-key":"7f8d67ba-dfb1-41dd-8e9f-7bd24d934275"}'::jsonb, '{}'::jsonb);

INSERT INTO masters.tenants (itenantid, vctenantid, irecordstatus, iorgid, config, attribs) VALUES
('4'::integer, 'Yesbank-AML'::character varying, '0'::integer, '3'::integer, '{"api-key":"985f051e-02c2-4187-8929-e4d67bfa36ad"}'::jsonb, '{}'::jsonb);

INSERT INTO masters.tenants (itenantid, vctenantid, irecordstatus, iorgid, config, attribs) VALUES
('5'::integer, '42c-FRM'::character varying, '0'::integer, '4'::integer, '{"api-key":"fd982956-a075-46b1-9eed-fd6bceff6728"}'::jsonb, '{}'::jsonb);

insert into ui.organizations(iorgid, attribs, vcorgid, irecordstatus, config) 
select iorgid, attribs, vcorgid, irecordstatus, config from masters.orgs;

insert into ui.tenants(itenantid, vctenantid, irecordstatus, iorg_id, config, attribs)
select itenantid, vctenantid, irecordstatus, iorgid, config, attribs from masters.tenants;

