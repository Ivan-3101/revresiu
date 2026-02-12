
---Organizations
UPDATE masters.orgs SET
attribs = '{
  "ssoConfig": {  
    "uiserver.sso": false,
    "drona.ui.scope": "openid",
    "drona.ui.clientid": "dronauidit",
    "uiserver.sso.type": "openid",
    "drona.ui.authorize": "http://localhost:8081/realms/dronaui/protocol/openid-connect/auth",
    "drona.ui.token.url": "http://localhost:8081/realms/dronaui/protocol/openid-connect/token",
    "drona.ui.logout.url": "http://localhost:8081/realms/dronaui/protocol/openid-connect/logout?post_logout_redirect_uri=http://localhost:8085/dronaui/auth/login",
    "drona.ui.redirect.url": "http://localhost:3001/dronaui/SIT/auth/login",
    "drona.ui.client.secret": "QDG8Q~~Aryb8W~9VVcsSLqGdH6PQZAGtkBj.VbfV",
    "spring.security.oauth2.resourceserver.jwt.issuer-uri": "http://localhost:8081/realms/dronaui",
    "spring.security.oauth2.resourceserver.jwt.jwk-set-uri": "http://localhost:8081/realms/dronaui/protocol/openid-connect/certs",
    "spring.security.oauth2.resourceserver.jwt.user-name-attribute": "preferred_username"
  },
  "vclogourl": "",
  "pismo.processing.enabled": true
}'::jsonb WHERE
iorgid = 4;

UPDATE masters.orgs SET
attribs = '{
  "ssoConfig": {  
    "uiserver.sso": false,
    "drona.ui.scope": "openid",
    "drona.ui.clientid": "dronauidit",
    "uiserver.sso.type": "openid",
    "drona.ui.authorize": "http://localhost:8081/realms/dronaui/protocol/openid-connect/auth",
    "drona.ui.token.url": "http://localhost:8081/realms/dronaui/protocol/openid-connect/token",
    "drona.ui.logout.url": "http://localhost:8081/realms/dronaui/protocol/openid-connect/logout?post_logout_redirect_uri=http://localhost:8085/dronaui/auth/login",
    "drona.ui.redirect.url": "http://localhost:3001/dronaui/SIT/auth/login",
    "drona.ui.client.secret": "QDG8Q~~Aryb8W~9VVcsSLqGdH6PQZAGtkBj.VbfV",
    "spring.security.oauth2.resourceserver.jwt.issuer-uri": "http://localhost:8081/realms/dronaui",
    "spring.security.oauth2.resourceserver.jwt.jwk-set-uri": "http://localhost:8081/realms/dronaui/protocol/openid-connect/certs",
    "spring.security.oauth2.resourceserver.jwt.user-name-attribute": "preferred_username"
  },
  "vclogourl": "",
  "pismo.processing.enabled": false
}'::jsonb WHERE
iorgid > 2 and iorgid != 4;

insert into ui.organizations(iorgid, attribs, vcorgid, irecordstatus, config) 
select iorgid, attribs, vcorgid, irecordstatus, config from masters.orgs where iorgid>2;



--Tenants
UPDATE masters.tenants SET
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
itenantid > 4;

insert into ui.tenants(itenantid, vctenantid, irecordstatus, iorg_id, config, attribs)
select itenantid, vctenantid, irecordstatus, iorgid, config, attribs from masters.tenants where itenantid>4;
--Roles
INSERT INTO ui.roledesc (
iroleid, dtentrystamp, vcrolename, istatus, itenantid) VALUES (
'19'::integer, now(), 'Risk Supervisor'::character varying, '1'::integer, '5'::integer)
 returning iroleid;

INSERT INTO ui.roledesc (
iroleid, dtentrystamp, vcrolename, istatus, itenantid) VALUES (
'20'::integer, now(), 'Risk Supervisor'::character varying, '1'::integer, '6'::integer)
 returning iroleid;

 INSERT INTO ui.roledesc (
iroleid, dtentrystamp, vcrolename, istatus, itenantid) VALUES (
'21'::integer, now(), 'Risk Supervisor'::character varying, '1'::integer, '7'::integer)
 returning iroleid;

 INSERT INTO ui.roledesc (
iroleid, dtentrystamp, vcrolename, istatus, itenantid) VALUES (
'22'::integer, now(), 'Risk Supervisor'::character varying, '1'::integer, '8'::integer)
 returning iroleid;

 INSERT INTO ui.roledesc (
iroleid, dtentrystamp, vcrolename, istatus, itenantid) VALUES (
'23'::integer, now(), 'Risk Supervisor'::character varying, '1'::integer, '9'::integer)
 returning iroleid;

 INSERT INTO ui.roledesc (
iroleid, dtentrystamp, vcrolename, istatus, itenantid) VALUES (
'24'::integer, now(), 'Risk Supervisor'::character varying, '1'::integer, '10'::integer)
 returning iroleid;

 INSERT INTO ui.roledesc (
iroleid, dtentrystamp, vcrolename, istatus, itenantid) VALUES (
'25'::integer, now(), 'Risk Supervisor'::character varying, '1'::integer, '11'::integer)
 returning iroleid;

INSERT INTO ui.roledesc (
iroleid, dtentrystamp, vcrolename, istatus, itenantid) VALUES (
'26'::integer, now(), 'Risk Supervisor'::character varying, '1'::integer, '12'::integer)
 returning iroleid;

INSERT INTO ui.roledesc (
iroleid, dtentrystamp, vcrolename, istatus, itenantid) VALUES (
'27'::integer, now(), 'Risk Supervisor'::character varying, '1'::integer, '13'::integer)
 returning iroleid;

INSERT INTO ui.roledesc (
iroleid, dtentrystamp, vcrolename, istatus, itenantid) VALUES (
'28'::integer, now(), 'Risk Supervisor'::character varying, '1'::integer, '14'::integer)
 returning iroleid;

INSERT INTO ui.roledesc (
iroleid, dtentrystamp, vcrolename, istatus, itenantid) VALUES (
'29'::integer, now(), 'Risk Supervisor'::character varying, '1'::integer, '15'::integer)
 returning iroleid;

--RoleMenuAccessMap

insert into ui.rolemenuaccessmap 
(badd, bapprove, bdelete, bedit, bpublish, bview, istatus, imenuid, iroleid)
select true, true, true, true, true, true, true, imenuid, 19 from
ui.menustructuredesc where imenuid = (select imenuid from ui.menustructuredesc
where vcmenuname='Admin');

insert into ui.rolemenuaccessmap 
(badd, bapprove, bdelete, bedit, bpublish, bview, istatus, imenuid, iroleid)
select true, true, true, true, true, true, true, imenuid, 19 from
ui.menustructuredesc where imenuid = (select imenuid from ui.menustructuredesc
where vcmenuname='User Management');

insert into ui.rolemenuaccessmap 
(badd, bapprove, bdelete, bedit, bpublish, bview, istatus, imenuid, iroleid)
select true, true, true, true, true, true, true, imenuid, 19 from
ui.menustructuredesc where iparentmenu = (select imenuid from ui.menustructuredesc
where vcmenuname='User Management');

insert into ui.rolemenuaccessmap 
(badd, bapprove, bdelete, bedit, bpublish, bview, istatus, imenuid, iroleid)
select true, true, true, true, true, true, true, imenuid, 19 from
ui.menustructuredesc where imenuid = (select imenuid from ui.menustructuredesc
where vcmenuname='Masters');

 insert into ui.rolemenuaccessmap 
(badd, bapprove, bdelete, bedit, bpublish, bview, istatus, imenuid, iroleid)
select true, true, true, true, true, true, true, imenuid, 19 from
ui.menustructuredesc where iparentmenu = (select imenuid from ui.menustructuredesc
where vcmenuname='Masters');

 insert into ui.rolemenuaccessmap 
(badd, bapprove, bdelete, bedit, bpublish, bview, istatus, imenuid, iroleid)
select true, true, true, true, true, true, true, imenuid, 19 from
ui.menustructuredesc where iparentmenu = (select imenuid from ui.menustructuredesc
where vcmenuname='Class');

insert into ui.rolemenuaccessmap 
(badd, bapprove, bdelete, bedit, bpublish, bview, istatus, imenuid, iroleid)
select true, true, true, true, true, true, true, imenuid, 19 from
ui.menustructuredesc where iparentmenu = (select imenuid from ui.menustructuredesc
where vcmenuname='Decision');

insert into ui.rolemenuaccessmap 
(badd, bapprove, bdelete, bedit, bpublish, bview, istatus, imenuid, iroleid)
select true, true, true, true, true, true, true, imenuid, 19 from
ui.menustructuredesc where iparentmenu = (select imenuid from ui.menustructuredesc
where vcmenuname='Rules');

insert into ui.rolemenuaccessmap 
(badd, bapprove, bdelete, bedit, bpublish, bview, istatus, imenuid, iroleid)
select true, true, true, true, true, true, true, imenuid, 19 from
ui.menustructuredesc where iparentmenu = (select imenuid from ui.menustructuredesc
where vcmenuname='List');

insert into ui.rolemenuaccessmap 
(badd, bapprove, bdelete, bedit, bpublish, bview, istatus, imenuid, iroleid)
select true, true, true, true, true, true, true, imenuid, 19 from
ui.menustructuredesc where iparentmenu = (select imenuid from ui.menustructuredesc
where vcmenuname='RT Window');

insert into ui.rolemenuaccessmap 
(badd, bapprove, bdelete, bedit, bpublish, bview, istatus, imenuid, iroleid)
select true, true, true, true, true, true, true, imenuid, 19 from
ui.menustructuredesc where iparentmenu = (select imenuid from ui.menustructuredesc
where vcmenuname='RT Observation');

insert into ui.rolemenuaccessmap 
(badd, bapprove, bdelete, bedit, bpublish, bview, istatus, imenuid, iroleid)
select true, true, true, true, true, true, true, imenuid, 19 from
ui.menustructuredesc where iparentmenu = (select imenuid from ui.menustructuredesc
where vcmenuname='Historic Profile');



-- role 19 ended here


insert into ui.rolemenuaccessmap 
(badd, bapprove, bdelete, bedit, bpublish, bview, istatus, imenuid, iroleid)
select true, true, true, true, true, true, true, imenuid, 20 from
ui.menustructuredesc where imenuid = (select imenuid from ui.menustructuredesc
where vcmenuname='Admin');

insert into ui.rolemenuaccessmap 
(badd, bapprove, bdelete, bedit, bpublish, bview, istatus, imenuid, iroleid)
select true, true, true, true, true, true, true, imenuid, 20 from
ui.menustructuredesc where imenuid = (select imenuid from ui.menustructuredesc
where vcmenuname='User Management');

insert into ui.rolemenuaccessmap 
(badd, bapprove, bdelete, bedit, bpublish, bview, istatus, imenuid, iroleid)
select true, true, true, true, true, true, true, imenuid, 20 from
ui.menustructuredesc where iparentmenu = (select imenuid from ui.menustructuredesc
where vcmenuname='User Management');

insert into ui.rolemenuaccessmap 
(badd, bapprove, bdelete, bedit, bpublish, bview, istatus, imenuid, iroleid)
select true, true, true, true, true, true, true, imenuid, 20 from
ui.menustructuredesc where imenuid = (select imenuid from ui.menustructuredesc
where vcmenuname='Masters');

 insert into ui.rolemenuaccessmap 
(badd, bapprove, bdelete, bedit, bpublish, bview, istatus, imenuid, iroleid)
select true, true, true, true, true, true, true, imenuid, 20 from
ui.menustructuredesc where iparentmenu = (select imenuid from ui.menustructuredesc
where vcmenuname='Masters');

 insert into ui.rolemenuaccessmap 
(badd, bapprove, bdelete, bedit, bpublish, bview, istatus, imenuid, iroleid)
select true, true, true, true, true, true, true, imenuid, 20 from
ui.menustructuredesc where iparentmenu = (select imenuid from ui.menustructuredesc
where vcmenuname='Class');

insert into ui.rolemenuaccessmap 
(badd, bapprove, bdelete, bedit, bpublish, bview, istatus, imenuid, iroleid)
select true, true, true, true, true, true, true, imenuid, 20 from
ui.menustructuredesc where iparentmenu = (select imenuid from ui.menustructuredesc
where vcmenuname='Decision');

insert into ui.rolemenuaccessmap 
(badd, bapprove, bdelete, bedit, bpublish, bview, istatus, imenuid, iroleid)
select true, true, true, true, true, true, true, imenuid, 20 from
ui.menustructuredesc where iparentmenu = (select imenuid from ui.menustructuredesc
where vcmenuname='Rules');

insert into ui.rolemenuaccessmap 
(badd, bapprove, bdelete, bedit, bpublish, bview, istatus, imenuid, iroleid)
select true, true, true, true, true, true, true, imenuid, 20 from
ui.menustructuredesc where iparentmenu = (select imenuid from ui.menustructuredesc
where vcmenuname='List');

insert into ui.rolemenuaccessmap 
(badd, bapprove, bdelete, bedit, bpublish, bview, istatus, imenuid, iroleid)
select true, true, true, true, true, true, true, imenuid, 20 from
ui.menustructuredesc where iparentmenu = (select imenuid from ui.menustructuredesc
where vcmenuname='RT Window');

insert into ui.rolemenuaccessmap 
(badd, bapprove, bdelete, bedit, bpublish, bview, istatus, imenuid, iroleid)
select true, true, true, true, true, true, true, imenuid, 20 from
ui.menustructuredesc where iparentmenu = (select imenuid from ui.menustructuredesc
where vcmenuname='RT Observation');

insert into ui.rolemenuaccessmap 
(badd, bapprove, bdelete, bedit, bpublish, bview, istatus, imenuid, iroleid)
select true, true, true, true, true, true, true, imenuid, 20 from
ui.menustructuredesc where iparentmenu = (select imenuid from ui.menustructuredesc
where vcmenuname='Historic Profile');

----- role 20 ended here 

insert into ui.rolemenuaccessmap 
(badd, bapprove, bdelete, bedit, bpublish, bview, istatus, imenuid, iroleid)
select true, true, true, true, true, true, true, imenuid, 21 from
ui.menustructuredesc where imenuid = (select imenuid from ui.menustructuredesc
where vcmenuname='Admin');

insert into ui.rolemenuaccessmap 
(badd, bapprove, bdelete, bedit, bpublish, bview, istatus, imenuid, iroleid)
select true, true, true, true, true, true, true, imenuid, 21 from
ui.menustructuredesc where imenuid = (select imenuid from ui.menustructuredesc
where vcmenuname='User Management');

insert into ui.rolemenuaccessmap 
(badd, bapprove, bdelete, bedit, bpublish, bview, istatus, imenuid, iroleid)
select true, true, true, true, true, true, true, imenuid, 21 from
ui.menustructuredesc where iparentmenu = (select imenuid from ui.menustructuredesc
where vcmenuname='User Management');

insert into ui.rolemenuaccessmap 
(badd, bapprove, bdelete, bedit, bpublish, bview, istatus, imenuid, iroleid)
select true, true, true, true, true, true, true, imenuid, 21 from
ui.menustructuredesc where imenuid = (select imenuid from ui.menustructuredesc
where vcmenuname='Masters');

 insert into ui.rolemenuaccessmap 
(badd, bapprove, bdelete, bedit, bpublish, bview, istatus, imenuid, iroleid)
select true, true, true, true, true, true, true, imenuid, 21 from
ui.menustructuredesc where iparentmenu = (select imenuid from ui.menustructuredesc
where vcmenuname='Masters');

 insert into ui.rolemenuaccessmap 
(badd, bapprove, bdelete, bedit, bpublish, bview, istatus, imenuid, iroleid)
select true, true, true, true, true, true, true, imenuid, 21 from
ui.menustructuredesc where iparentmenu = (select imenuid from ui.menustructuredesc
where vcmenuname='Class');

insert into ui.rolemenuaccessmap 
(badd, bapprove, bdelete, bedit, bpublish, bview, istatus, imenuid, iroleid)
select true, true, true, true, true, true, true, imenuid, 21 from
ui.menustructuredesc where iparentmenu = (select imenuid from ui.menustructuredesc
where vcmenuname='Decision');

insert into ui.rolemenuaccessmap 
(badd, bapprove, bdelete, bedit, bpublish, bview, istatus, imenuid, iroleid)
select true, true, true, true, true, true, true, imenuid, 21 from
ui.menustructuredesc where iparentmenu = (select imenuid from ui.menustructuredesc
where vcmenuname='Rules');

insert into ui.rolemenuaccessmap 
(badd, bapprove, bdelete, bedit, bpublish, bview, istatus, imenuid, iroleid)
select true, true, true, true, true, true, true, imenuid, 21 from
ui.menustructuredesc where iparentmenu = (select imenuid from ui.menustructuredesc
where vcmenuname='List');

insert into ui.rolemenuaccessmap 
(badd, bapprove, bdelete, bedit, bpublish, bview, istatus, imenuid, iroleid)
select true, true, true, true, true, true, true, imenuid, 21 from
ui.menustructuredesc where iparentmenu = (select imenuid from ui.menustructuredesc
where vcmenuname='RT Window');

insert into ui.rolemenuaccessmap 
(badd, bapprove, bdelete, bedit, bpublish, bview, istatus, imenuid, iroleid)
select true, true, true, true, true, true, true, imenuid, 21 from
ui.menustructuredesc where iparentmenu = (select imenuid from ui.menustructuredesc
where vcmenuname='RT Observation');

insert into ui.rolemenuaccessmap 
(badd, bapprove, bdelete, bedit, bpublish, bview, istatus, imenuid, iroleid)
select true, true, true, true, true, true, true, imenuid, 21 from
ui.menustructuredesc where iparentmenu = (select imenuid from ui.menustructuredesc
where vcmenuname='Historic Profile');

-- role 21 ended here 


insert into ui.rolemenuaccessmap 
(badd, bapprove, bdelete, bedit, bpublish, bview, istatus, imenuid, iroleid)
select true, true, true, true, true, true, true, imenuid, 22 from
ui.menustructuredesc where imenuid = (select imenuid from ui.menustructuredesc
where vcmenuname='Admin');

insert into ui.rolemenuaccessmap 
(badd, bapprove, bdelete, bedit, bpublish, bview, istatus, imenuid, iroleid)
select true, true, true, true, true, true, true, imenuid, 22 from
ui.menustructuredesc where imenuid = (select imenuid from ui.menustructuredesc
where vcmenuname='User Management');

insert into ui.rolemenuaccessmap 
(badd, bapprove, bdelete, bedit, bpublish, bview, istatus, imenuid, iroleid)
select true, true, true, true, true, true, true, imenuid, 22 from
ui.menustructuredesc where iparentmenu = (select imenuid from ui.menustructuredesc
where vcmenuname='User Management');

insert into ui.rolemenuaccessmap 
(badd, bapprove, bdelete, bedit, bpublish, bview, istatus, imenuid, iroleid)
select true, true, true, true, true, true, true, imenuid, 22 from
ui.menustructuredesc where imenuid = (select imenuid from ui.menustructuredesc
where vcmenuname='Masters');

 insert into ui.rolemenuaccessmap 
(badd, bapprove, bdelete, bedit, bpublish, bview, istatus, imenuid, iroleid)
select true, true, true, true, true, true, true, imenuid, 22 from
ui.menustructuredesc where iparentmenu = (select imenuid from ui.menustructuredesc
where vcmenuname='Masters');

 insert into ui.rolemenuaccessmap 
(badd, bapprove, bdelete, bedit, bpublish, bview, istatus, imenuid, iroleid)
select true, true, true, true, true, true, true, imenuid, 22 from
ui.menustructuredesc where iparentmenu = (select imenuid from ui.menustructuredesc
where vcmenuname='Class');

insert into ui.rolemenuaccessmap 
(badd, bapprove, bdelete, bedit, bpublish, bview, istatus, imenuid, iroleid)
select true, true, true, true, true, true, true, imenuid, 22 from
ui.menustructuredesc where iparentmenu = (select imenuid from ui.menustructuredesc
where vcmenuname='Decision');

insert into ui.rolemenuaccessmap 
(badd, bapprove, bdelete, bedit, bpublish, bview, istatus, imenuid, iroleid)
select true, true, true, true, true, true, true, imenuid, 22 from
ui.menustructuredesc where iparentmenu = (select imenuid from ui.menustructuredesc
where vcmenuname='Rules');

insert into ui.rolemenuaccessmap 
(badd, bapprove, bdelete, bedit, bpublish, bview, istatus, imenuid, iroleid)
select true, true, true, true, true, true, true, imenuid, 22 from
ui.menustructuredesc where iparentmenu = (select imenuid from ui.menustructuredesc
where vcmenuname='List');

insert into ui.rolemenuaccessmap 
(badd, bapprove, bdelete, bedit, bpublish, bview, istatus, imenuid, iroleid)
select true, true, true, true, true, true, true, imenuid, 22 from
ui.menustructuredesc where iparentmenu = (select imenuid from ui.menustructuredesc
where vcmenuname='RT Window');

insert into ui.rolemenuaccessmap 
(badd, bapprove, bdelete, bedit, bpublish, bview, istatus, imenuid, iroleid)
select true, true, true, true, true, true, true, imenuid, 22 from
ui.menustructuredesc where iparentmenu = (select imenuid from ui.menustructuredesc
where vcmenuname='RT Observation');

insert into ui.rolemenuaccessmap 
(badd, bapprove, bdelete, bedit, bpublish, bview, istatus, imenuid, iroleid)
select true, true, true, true, true, true, true, imenuid, 22 from
ui.menustructuredesc where iparentmenu = (select imenuid from ui.menustructuredesc
where vcmenuname='Historic Profile');

-- role 22 ended here 

insert into ui.rolemenuaccessmap 
(badd, bapprove, bdelete, bedit, bpublish, bview, istatus, imenuid, iroleid)
select true, true, true, true, true, true, true, imenuid, 23 from
ui.menustructuredesc where imenuid = (select imenuid from ui.menustructuredesc
where vcmenuname='Admin');

insert into ui.rolemenuaccessmap 
(badd, bapprove, bdelete, bedit, bpublish, bview, istatus, imenuid, iroleid)
select true, true, true, true, true, true, true, imenuid, 23 from
ui.menustructuredesc where imenuid = (select imenuid from ui.menustructuredesc
where vcmenuname='User Management');

insert into ui.rolemenuaccessmap 
(badd, bapprove, bdelete, bedit, bpublish, bview, istatus, imenuid, iroleid)
select true, true, true, true, true, true, true, imenuid, 23 from
ui.menustructuredesc where iparentmenu = (select imenuid from ui.menustructuredesc
where vcmenuname='User Management');

insert into ui.rolemenuaccessmap 
(badd, bapprove, bdelete, bedit, bpublish, bview, istatus, imenuid, iroleid)
select true, true, true, true, true, true, true, imenuid, 23 from
ui.menustructuredesc where imenuid = (select imenuid from ui.menustructuredesc
where vcmenuname='Masters');

 insert into ui.rolemenuaccessmap 
(badd, bapprove, bdelete, bedit, bpublish, bview, istatus, imenuid, iroleid)
select true, true, true, true, true, true, true, imenuid, 23 from
ui.menustructuredesc where iparentmenu = (select imenuid from ui.menustructuredesc
where vcmenuname='Masters');

 insert into ui.rolemenuaccessmap 
(badd, bapprove, bdelete, bedit, bpublish, bview, istatus, imenuid, iroleid)
select true, true, true, true, true, true, true, imenuid, 23 from
ui.menustructuredesc where iparentmenu = (select imenuid from ui.menustructuredesc
where vcmenuname='Class');

insert into ui.rolemenuaccessmap 
(badd, bapprove, bdelete, bedit, bpublish, bview, istatus, imenuid, iroleid)
select true, true, true, true, true, true, true, imenuid, 23 from
ui.menustructuredesc where iparentmenu = (select imenuid from ui.menustructuredesc
where vcmenuname='Decision');

insert into ui.rolemenuaccessmap 
(badd, bapprove, bdelete, bedit, bpublish, bview, istatus, imenuid, iroleid)
select true, true, true, true, true, true, true, imenuid, 23 from
ui.menustructuredesc where iparentmenu = (select imenuid from ui.menustructuredesc
where vcmenuname='Rules');

insert into ui.rolemenuaccessmap 
(badd, bapprove, bdelete, bedit, bpublish, bview, istatus, imenuid, iroleid)
select true, true, true, true, true, true, true, imenuid, 23 from
ui.menustructuredesc where iparentmenu = (select imenuid from ui.menustructuredesc
where vcmenuname='List');

insert into ui.rolemenuaccessmap 
(badd, bapprove, bdelete, bedit, bpublish, bview, istatus, imenuid, iroleid)
select true, true, true, true, true, true, true, imenuid, 23 from
ui.menustructuredesc where iparentmenu = (select imenuid from ui.menustructuredesc
where vcmenuname='RT Window');

insert into ui.rolemenuaccessmap 
(badd, bapprove, bdelete, bedit, bpublish, bview, istatus, imenuid, iroleid)
select true, true, true, true, true, true, true, imenuid, 23 from
ui.menustructuredesc where iparentmenu = (select imenuid from ui.menustructuredesc
where vcmenuname='RT Observation');

insert into ui.rolemenuaccessmap 
(badd, bapprove, bdelete, bedit, bpublish, bview, istatus, imenuid, iroleid)
select true, true, true, true, true, true, true, imenuid, 23 from
ui.menustructuredesc where iparentmenu = (select imenuid from ui.menustructuredesc
where vcmenuname='Historic Profile');


-- role 23 ended here 
insert into ui.rolemenuaccessmap 
(badd, bapprove, bdelete, bedit, bpublish, bview, istatus, imenuid, iroleid)
select true, true, true, true, true, true, true, imenuid, 24 from
ui.menustructuredesc where imenuid = (select imenuid from ui.menustructuredesc
where vcmenuname='Admin');

insert into ui.rolemenuaccessmap 
(badd, bapprove, bdelete, bedit, bpublish, bview, istatus, imenuid, iroleid)
select true, true, true, true, true, true, true, imenuid, 24 from
ui.menustructuredesc where imenuid = (select imenuid from ui.menustructuredesc
where vcmenuname='User Management');

insert into ui.rolemenuaccessmap 
(badd, bapprove, bdelete, bedit, bpublish, bview, istatus, imenuid, iroleid)
select true, true, true, true, true, true, true, imenuid, 24 from
ui.menustructuredesc where iparentmenu = (select imenuid from ui.menustructuredesc
where vcmenuname='User Management');

insert into ui.rolemenuaccessmap 
(badd, bapprove, bdelete, bedit, bpublish, bview, istatus, imenuid, iroleid)
select true, true, true, true, true, true, true, imenuid, 24 from
ui.menustructuredesc where imenuid = (select imenuid from ui.menustructuredesc
where vcmenuname='Masters');

 insert into ui.rolemenuaccessmap 
(badd, bapprove, bdelete, bedit, bpublish, bview, istatus, imenuid, iroleid)
select true, true, true, true, true, true, true, imenuid, 24 from
ui.menustructuredesc where iparentmenu = (select imenuid from ui.menustructuredesc
where vcmenuname='Masters');

 insert into ui.rolemenuaccessmap 
(badd, bapprove, bdelete, bedit, bpublish, bview, istatus, imenuid, iroleid)
select true, true, true, true, true, true, true, imenuid, 24 from
ui.menustructuredesc where iparentmenu = (select imenuid from ui.menustructuredesc
where vcmenuname='Class');

insert into ui.rolemenuaccessmap 
(badd, bapprove, bdelete, bedit, bpublish, bview, istatus, imenuid, iroleid)
select true, true, true, true, true, true, true, imenuid, 24 from
ui.menustructuredesc where iparentmenu = (select imenuid from ui.menustructuredesc
where vcmenuname='Decision');

insert into ui.rolemenuaccessmap 
(badd, bapprove, bdelete, bedit, bpublish, bview, istatus, imenuid, iroleid)
select true, true, true, true, true, true, true, imenuid, 24 from
ui.menustructuredesc where iparentmenu = (select imenuid from ui.menustructuredesc
where vcmenuname='Rules');

insert into ui.rolemenuaccessmap 
(badd, bapprove, bdelete, bedit, bpublish, bview, istatus, imenuid, iroleid)
select true, true, true, true, true, true, true, imenuid, 24 from
ui.menustructuredesc where iparentmenu = (select imenuid from ui.menustructuredesc
where vcmenuname='List');

insert into ui.rolemenuaccessmap 
(badd, bapprove, bdelete, bedit, bpublish, bview, istatus, imenuid, iroleid)
select true, true, true, true, true, true, true, imenuid, 24 from
ui.menustructuredesc where iparentmenu = (select imenuid from ui.menustructuredesc
where vcmenuname='RT Window');

insert into ui.rolemenuaccessmap 
(badd, bapprove, bdelete, bedit, bpublish, bview, istatus, imenuid, iroleid)
select true, true, true, true, true, true, true, imenuid, 24 from
ui.menustructuredesc where iparentmenu = (select imenuid from ui.menustructuredesc
where vcmenuname='RT Observation');

insert into ui.rolemenuaccessmap 
(badd, bapprove, bdelete, bedit, bpublish, bview, istatus, imenuid, iroleid)
select true, true, true, true, true, true, true, imenuid, 24 from
ui.menustructuredesc where iparentmenu = (select imenuid from ui.menustructuredesc
where vcmenuname='Historic Profile');


-- role 24 ended here 

insert into ui.rolemenuaccessmap 
(badd, bapprove, bdelete, bedit, bpublish, bview, istatus, imenuid, iroleid)
select true, true, true, true, true, true, true, imenuid, 25 from
ui.menustructuredesc where imenuid = (select imenuid from ui.menustructuredesc
where vcmenuname='Admin');

insert into ui.rolemenuaccessmap 
(badd, bapprove, bdelete, bedit, bpublish, bview, istatus, imenuid, iroleid)
select true, true, true, true, true, true, true, imenuid, 25 from
ui.menustructuredesc where imenuid = (select imenuid from ui.menustructuredesc
where vcmenuname='User Management');

insert into ui.rolemenuaccessmap 
(badd, bapprove, bdelete, bedit, bpublish, bview, istatus, imenuid, iroleid)
select true, true, true, true, true, true, true, imenuid, 25 from
ui.menustructuredesc where iparentmenu = (select imenuid from ui.menustructuredesc
where vcmenuname='User Management');

insert into ui.rolemenuaccessmap 
(badd, bapprove, bdelete, bedit, bpublish, bview, istatus, imenuid, iroleid)
select true, true, true, true, true, true, true, imenuid, 25 from
ui.menustructuredesc where imenuid = (select imenuid from ui.menustructuredesc
where vcmenuname='Masters');

 insert into ui.rolemenuaccessmap 
(badd, bapprove, bdelete, bedit, bpublish, bview, istatus, imenuid, iroleid)
select true, true, true, true, true, true, true, imenuid, 25 from
ui.menustructuredesc where iparentmenu = (select imenuid from ui.menustructuredesc
where vcmenuname='Masters');

 insert into ui.rolemenuaccessmap 
(badd, bapprove, bdelete, bedit, bpublish, bview, istatus, imenuid, iroleid)
select true, true, true, true, true, true, true, imenuid, 25 from
ui.menustructuredesc where iparentmenu = (select imenuid from ui.menustructuredesc
where vcmenuname='Class');

insert into ui.rolemenuaccessmap 
(badd, bapprove, bdelete, bedit, bpublish, bview, istatus, imenuid, iroleid)
select true, true, true, true, true, true, true, imenuid, 25 from
ui.menustructuredesc where iparentmenu = (select imenuid from ui.menustructuredesc
where vcmenuname='Decision');

insert into ui.rolemenuaccessmap 
(badd, bapprove, bdelete, bedit, bpublish, bview, istatus, imenuid, iroleid)
select true, true, true, true, true, true, true, imenuid, 25 from
ui.menustructuredesc where iparentmenu = (select imenuid from ui.menustructuredesc
where vcmenuname='Rules');

insert into ui.rolemenuaccessmap 
(badd, bapprove, bdelete, bedit, bpublish, bview, istatus, imenuid, iroleid)
select true, true, true, true, true, true, true, imenuid, 25 from
ui.menustructuredesc where iparentmenu = (select imenuid from ui.menustructuredesc
where vcmenuname='List');

insert into ui.rolemenuaccessmap 
(badd, bapprove, bdelete, bedit, bpublish, bview, istatus, imenuid, iroleid)
select true, true, true, true, true, true, true, imenuid, 25 from
ui.menustructuredesc where iparentmenu = (select imenuid from ui.menustructuredesc
where vcmenuname='RT Window');

insert into ui.rolemenuaccessmap 
(badd, bapprove, bdelete, bedit, bpublish, bview, istatus, imenuid, iroleid)
select true, true, true, true, true, true, true, imenuid, 25 from
ui.menustructuredesc where iparentmenu = (select imenuid from ui.menustructuredesc
where vcmenuname='RT Observation');

insert into ui.rolemenuaccessmap 
(badd, bapprove, bdelete, bedit, bpublish, bview, istatus, imenuid, iroleid)
select true, true, true, true, true, true, true, imenuid, 25 from
ui.menustructuredesc where iparentmenu = (select imenuid from ui.menustructuredesc
where vcmenuname='Historic Profile');


-- role 25 ended here 

insert into ui.rolemenuaccessmap 
(badd, bapprove, bdelete, bedit, bpublish, bview, istatus, imenuid, iroleid)
select true, true, true, true, true, true, true, imenuid, 26 from
ui.menustructuredesc where imenuid = (select imenuid from ui.menustructuredesc
where vcmenuname='Admin');

insert into ui.rolemenuaccessmap 
(badd, bapprove, bdelete, bedit, bpublish, bview, istatus, imenuid, iroleid)
select true, true, true, true, true, true, true, imenuid, 26 from
ui.menustructuredesc where imenuid = (select imenuid from ui.menustructuredesc
where vcmenuname='User Management');

insert into ui.rolemenuaccessmap 
(badd, bapprove, bdelete, bedit, bpublish, bview, istatus, imenuid, iroleid)
select true, true, true, true, true, true, true, imenuid, 26 from
ui.menustructuredesc where iparentmenu = (select imenuid from ui.menustructuredesc
where vcmenuname='User Management');

insert into ui.rolemenuaccessmap 
(badd, bapprove, bdelete, bedit, bpublish, bview, istatus, imenuid, iroleid)
select true, true, true, true, true, true, true, imenuid, 26 from
ui.menustructuredesc where imenuid = (select imenuid from ui.menustructuredesc
where vcmenuname='Masters');

 insert into ui.rolemenuaccessmap 
(badd, bapprove, bdelete, bedit, bpublish, bview, istatus, imenuid, iroleid)
select true, true, true, true, true, true, true, imenuid, 26 from
ui.menustructuredesc where iparentmenu = (select imenuid from ui.menustructuredesc
where vcmenuname='Masters');

 insert into ui.rolemenuaccessmap 
(badd, bapprove, bdelete, bedit, bpublish, bview, istatus, imenuid, iroleid)
select true, true, true, true, true, true, true, imenuid, 26 from
ui.menustructuredesc where iparentmenu = (select imenuid from ui.menustructuredesc
where vcmenuname='Class');

insert into ui.rolemenuaccessmap 
(badd, bapprove, bdelete, bedit, bpublish, bview, istatus, imenuid, iroleid)
select true, true, true, true, true, true, true, imenuid, 26 from
ui.menustructuredesc where iparentmenu = (select imenuid from ui.menustructuredesc
where vcmenuname='Decision');

insert into ui.rolemenuaccessmap 
(badd, bapprove, bdelete, bedit, bpublish, bview, istatus, imenuid, iroleid)
select true, true, true, true, true, true, true, imenuid, 26 from
ui.menustructuredesc where iparentmenu = (select imenuid from ui.menustructuredesc
where vcmenuname='Rules');

insert into ui.rolemenuaccessmap 
(badd, bapprove, bdelete, bedit, bpublish, bview, istatus, imenuid, iroleid)
select true, true, true, true, true, true, true, imenuid, 26 from
ui.menustructuredesc where iparentmenu = (select imenuid from ui.menustructuredesc
where vcmenuname='List');

insert into ui.rolemenuaccessmap 
(badd, bapprove, bdelete, bedit, bpublish, bview, istatus, imenuid, iroleid)
select true, true, true, true, true, true, true, imenuid, 26 from
ui.menustructuredesc where iparentmenu = (select imenuid from ui.menustructuredesc
where vcmenuname='RT Window');

insert into ui.rolemenuaccessmap 
(badd, bapprove, bdelete, bedit, bpublish, bview, istatus, imenuid, iroleid)
select true, true, true, true, true, true, true, imenuid, 26 from
ui.menustructuredesc where iparentmenu = (select imenuid from ui.menustructuredesc
where vcmenuname='RT Observation');

insert into ui.rolemenuaccessmap 
(badd, bapprove, bdelete, bedit, bpublish, bview, istatus, imenuid, iroleid)
select true, true, true, true, true, true, true, imenuid, 26 from
ui.menustructuredesc where iparentmenu = (select imenuid from ui.menustructuredesc
where vcmenuname='Historic Profile');

-- role 26 ended here

insert into ui.rolemenuaccessmap 
(badd, bapprove, bdelete, bedit, bpublish, bview, istatus, imenuid, iroleid)
select true, true, true, true, true, true, true, imenuid, 27 from
ui.menustructuredesc where imenuid = (select imenuid from ui.menustructuredesc
where vcmenuname='Admin');

insert into ui.rolemenuaccessmap 
(badd, bapprove, bdelete, bedit, bpublish, bview, istatus, imenuid, iroleid)
select true, true, true, true, true, true, true, imenuid, 27 from
ui.menustructuredesc where imenuid = (select imenuid from ui.menustructuredesc
where vcmenuname='User Management');

insert into ui.rolemenuaccessmap 
(badd, bapprove, bdelete, bedit, bpublish, bview, istatus, imenuid, iroleid)
select true, true, true, true, true, true, true, imenuid, 27 from
ui.menustructuredesc where iparentmenu = (select imenuid from ui.menustructuredesc
where vcmenuname='User Management');

insert into ui.rolemenuaccessmap 
(badd, bapprove, bdelete, bedit, bpublish, bview, istatus, imenuid, iroleid)
select true, true, true, true, true, true, true, imenuid, 27 from
ui.menustructuredesc where imenuid = (select imenuid from ui.menustructuredesc
where vcmenuname='Masters');

 insert into ui.rolemenuaccessmap 
(badd, bapprove, bdelete, bedit, bpublish, bview, istatus, imenuid, iroleid)
select true, true, true, true, true, true, true, imenuid, 27 from
ui.menustructuredesc where iparentmenu = (select imenuid from ui.menustructuredesc
where vcmenuname='Masters');

 insert into ui.rolemenuaccessmap 
(badd, bapprove, bdelete, bedit, bpublish, bview, istatus, imenuid, iroleid)
select true, true, true, true, true, true, true, imenuid, 27 from
ui.menustructuredesc where iparentmenu = (select imenuid from ui.menustructuredesc
where vcmenuname='Class');

insert into ui.rolemenuaccessmap 
(badd, bapprove, bdelete, bedit, bpublish, bview, istatus, imenuid, iroleid)
select true, true, true, true, true, true, true, imenuid, 27 from
ui.menustructuredesc where iparentmenu = (select imenuid from ui.menustructuredesc
where vcmenuname='Decision');

insert into ui.rolemenuaccessmap 
(badd, bapprove, bdelete, bedit, bpublish, bview, istatus, imenuid, iroleid)
select true, true, true, true, true, true, true, imenuid, 27 from
ui.menustructuredesc where iparentmenu = (select imenuid from ui.menustructuredesc
where vcmenuname='Rules');

insert into ui.rolemenuaccessmap 
(badd, bapprove, bdelete, bedit, bpublish, bview, istatus, imenuid, iroleid)
select true, true, true, true, true, true, true, imenuid, 27 from
ui.menustructuredesc where iparentmenu = (select imenuid from ui.menustructuredesc
where vcmenuname='List');

insert into ui.rolemenuaccessmap 
(badd, bapprove, bdelete, bedit, bpublish, bview, istatus, imenuid, iroleid)
select true, true, true, true, true, true, true, imenuid, 27 from
ui.menustructuredesc where iparentmenu = (select imenuid from ui.menustructuredesc
where vcmenuname='RT Window');

insert into ui.rolemenuaccessmap 
(badd, bapprove, bdelete, bedit, bpublish, bview, istatus, imenuid, iroleid)
select true, true, true, true, true, true, true, imenuid, 27 from
ui.menustructuredesc where iparentmenu = (select imenuid from ui.menustructuredesc
where vcmenuname='RT Observation');

insert into ui.rolemenuaccessmap 
(badd, bapprove, bdelete, bedit, bpublish, bview, istatus, imenuid, iroleid)
select true, true, true, true, true, true, true, imenuid, 27 from
ui.menustructuredesc where iparentmenu = (select imenuid from ui.menustructuredesc
where vcmenuname='Historic Profile');


-- role 27 ended here 

insert into ui.rolemenuaccessmap 
(badd, bapprove, bdelete, bedit, bpublish, bview, istatus, imenuid, iroleid)
select true, true, true, true, true, true, true, imenuid, 28 from
ui.menustructuredesc where imenuid = (select imenuid from ui.menustructuredesc
where vcmenuname='Admin');

insert into ui.rolemenuaccessmap 
(badd, bapprove, bdelete, bedit, bpublish, bview, istatus, imenuid, iroleid)
select true, true, true, true, true, true, true, imenuid, 28 from
ui.menustructuredesc where imenuid = (select imenuid from ui.menustructuredesc
where vcmenuname='User Management');

insert into ui.rolemenuaccessmap 
(badd, bapprove, bdelete, bedit, bpublish, bview, istatus, imenuid, iroleid)
select true, true, true, true, true, true, true, imenuid, 28 from
ui.menustructuredesc where iparentmenu = (select imenuid from ui.menustructuredesc
where vcmenuname='User Management');

insert into ui.rolemenuaccessmap 
(badd, bapprove, bdelete, bedit, bpublish, bview, istatus, imenuid, iroleid)
select true, true, true, true, true, true, true, imenuid, 28 from
ui.menustructuredesc where imenuid = (select imenuid from ui.menustructuredesc
where vcmenuname='Masters');

 insert into ui.rolemenuaccessmap 
(badd, bapprove, bdelete, bedit, bpublish, bview, istatus, imenuid, iroleid)
select true, true, true, true, true, true, true, imenuid, 28 from
ui.menustructuredesc where iparentmenu = (select imenuid from ui.menustructuredesc
where vcmenuname='Masters');

 insert into ui.rolemenuaccessmap 
(badd, bapprove, bdelete, bedit, bpublish, bview, istatus, imenuid, iroleid)
select true, true, true, true, true, true, true, imenuid, 28 from
ui.menustructuredesc where iparentmenu = (select imenuid from ui.menustructuredesc
where vcmenuname='Class');

insert into ui.rolemenuaccessmap 
(badd, bapprove, bdelete, bedit, bpublish, bview, istatus, imenuid, iroleid)
select true, true, true, true, true, true, true, imenuid, 28 from
ui.menustructuredesc where iparentmenu = (select imenuid from ui.menustructuredesc
where vcmenuname='Decision');

insert into ui.rolemenuaccessmap 
(badd, bapprove, bdelete, bedit, bpublish, bview, istatus, imenuid, iroleid)
select true, true, true, true, true, true, true, imenuid, 28 from
ui.menustructuredesc where iparentmenu = (select imenuid from ui.menustructuredesc
where vcmenuname='Rules');

insert into ui.rolemenuaccessmap 
(badd, bapprove, bdelete, bedit, bpublish, bview, istatus, imenuid, iroleid)
select true, true, true, true, true, true, true, imenuid, 28 from
ui.menustructuredesc where iparentmenu = (select imenuid from ui.menustructuredesc
where vcmenuname='List');

insert into ui.rolemenuaccessmap 
(badd, bapprove, bdelete, bedit, bpublish, bview, istatus, imenuid, iroleid)
select true, true, true, true, true, true, true, imenuid, 28 from
ui.menustructuredesc where iparentmenu = (select imenuid from ui.menustructuredesc
where vcmenuname='RT Window');

insert into ui.rolemenuaccessmap 
(badd, bapprove, bdelete, bedit, bpublish, bview, istatus, imenuid, iroleid)
select true, true, true, true, true, true, true, imenuid, 28 from
ui.menustructuredesc where iparentmenu = (select imenuid from ui.menustructuredesc
where vcmenuname='RT Observation');

insert into ui.rolemenuaccessmap 
(badd, bapprove, bdelete, bedit, bpublish, bview, istatus, imenuid, iroleid)
select true, true, true, true, true, true, true, imenuid, 28 from
ui.menustructuredesc where iparentmenu = (select imenuid from ui.menustructuredesc
where vcmenuname='Historic Profile');


-- role 28 ended here 


insert into ui.rolemenuaccessmap 
(badd, bapprove, bdelete, bedit, bpublish, bview, istatus, imenuid, iroleid)
select true, true, true, true, true, true, true, imenuid, 29 from
ui.menustructuredesc where imenuid = (select imenuid from ui.menustructuredesc
where vcmenuname='Admin');

insert into ui.rolemenuaccessmap 
(badd, bapprove, bdelete, bedit, bpublish, bview, istatus, imenuid, iroleid)
select true, true, true, true, true, true, true, imenuid, 29 from
ui.menustructuredesc where imenuid = (select imenuid from ui.menustructuredesc
where vcmenuname='User Management');

insert into ui.rolemenuaccessmap 
(badd, bapprove, bdelete, bedit, bpublish, bview, istatus, imenuid, iroleid)
select true, true, true, true, true, true, true, imenuid, 29 from
ui.menustructuredesc where iparentmenu = (select imenuid from ui.menustructuredesc
where vcmenuname='User Management');

insert into ui.rolemenuaccessmap 
(badd, bapprove, bdelete, bedit, bpublish, bview, istatus, imenuid, iroleid)
select true, true, true, true, true, true, true, imenuid, 29 from
ui.menustructuredesc where imenuid = (select imenuid from ui.menustructuredesc
where vcmenuname='Masters');

 insert into ui.rolemenuaccessmap 
(badd, bapprove, bdelete, bedit, bpublish, bview, istatus, imenuid, iroleid)
select true, true, true, true, true, true, true, imenuid, 29 from
ui.menustructuredesc where iparentmenu = (select imenuid from ui.menustructuredesc
where vcmenuname='Masters');

 insert into ui.rolemenuaccessmap 
(badd, bapprove, bdelete, bedit, bpublish, bview, istatus, imenuid, iroleid)
select true, true, true, true, true, true, true, imenuid, 29 from
ui.menustructuredesc where iparentmenu = (select imenuid from ui.menustructuredesc
where vcmenuname='Class');

insert into ui.rolemenuaccessmap 
(badd, bapprove, bdelete, bedit, bpublish, bview, istatus, imenuid, iroleid)
select true, true, true, true, true, true, true, imenuid, 29 from
ui.menustructuredesc where iparentmenu = (select imenuid from ui.menustructuredesc
where vcmenuname='Decision');

insert into ui.rolemenuaccessmap 
(badd, bapprove, bdelete, bedit, bpublish, bview, istatus, imenuid, iroleid)
select true, true, true, true, true, true, true, imenuid, 29 from
ui.menustructuredesc where iparentmenu = (select imenuid from ui.menustructuredesc
where vcmenuname='Rules');

insert into ui.rolemenuaccessmap 
(badd, bapprove, bdelete, bedit, bpublish, bview, istatus, imenuid, iroleid)
select true, true, true, true, true, true, true, imenuid, 29 from
ui.menustructuredesc where iparentmenu = (select imenuid from ui.menustructuredesc
where vcmenuname='List');

insert into ui.rolemenuaccessmap 
(badd, bapprove, bdelete, bedit, bpublish, bview, istatus, imenuid, iroleid)
select true, true, true, true, true, true, true, imenuid, 29 from
ui.menustructuredesc where iparentmenu = (select imenuid from ui.menustructuredesc
where vcmenuname='RT Window');

insert into ui.rolemenuaccessmap 
(badd, bapprove, bdelete, bedit, bpublish, bview, istatus, imenuid, iroleid)
select true, true, true, true, true, true, true, imenuid, 29 from
ui.menustructuredesc where iparentmenu = (select imenuid from ui.menustructuredesc
where vcmenuname='RT Observation');

insert into ui.rolemenuaccessmap 
(badd, bapprove, bdelete, bedit, bpublish, bview, istatus, imenuid, iroleid)
select true, true, true, true, true, true, true, imenuid, 29 from
ui.menustructuredesc where iparentmenu = (select imenuid from ui.menustructuredesc
where vcmenuname='Historic Profile');

-- role 29 ended here 

--Groups
INSERT INTO ui.groupdesc (
igroupid, vcgroupid, vcgroupname, vcgrouptype, istatus, itenantid) VALUES (
'2033'::integer, 'riskanalyst'::character varying, 'Risk Analyst'::character varying, 'WORKFLOW'::character varying, '1'::integer, '5'::integer)
 returning igroupid;


 INSERT INTO ui.groupdesc (
igroupid, vcgroupid, vcgroupname, vcgrouptype, istatus, itenantid) VALUES (
'2034'::integer, 'riskanalyst'::character varying, 'Risk Analyst'::character varying, 'WORKFLOW'::character varying, '1'::integer, '6'::integer)
 returning igroupid;

 INSERT INTO ui.groupdesc (
igroupid, vcgroupid, vcgroupname, vcgrouptype, istatus, itenantid) VALUES (
'2035'::integer, 'riskanalyst'::character varying, 'Risk Analyst'::character varying, 'WORKFLOW'::character varying, '1'::integer, '7'::integer)
 returning igroupid;


 INSERT INTO ui.groupdesc (
igroupid, vcgroupid, vcgroupname, vcgrouptype, istatus, itenantid) VALUES (
'2036'::integer, 'riskanalyst'::character varying, 'Risk Analyst'::character varying, 'WORKFLOW'::character varying, '1'::integer, '8'::integer)
 returning igroupid;

 INSERT INTO ui.groupdesc (
igroupid, vcgroupid, vcgroupname, vcgrouptype, istatus, itenantid) VALUES (
'2037'::integer, 'riskanalyst'::character varying, 'Risk Analyst'::character varying, 'WORKFLOW'::character varying, '1'::integer, '9'::integer)
 returning igroupid;


 INSERT INTO ui.groupdesc (
igroupid, vcgroupid, vcgroupname, vcgrouptype, istatus, itenantid) VALUES (
'2038'::integer, 'riskanalyst'::character varying, 'Risk Analyst'::character varying, 'WORKFLOW'::character varying, '1'::integer, '10'::integer)
 returning igroupid;


 INSERT INTO ui.groupdesc (
igroupid, vcgroupid, vcgroupname, vcgrouptype, istatus, itenantid) VALUES (
'2039'::integer, 'riskanalyst'::character varying, 'Risk Analyst'::character varying, 'WORKFLOW'::character varying, '1'::integer, '11'::integer)
 returning igroupid;


 INSERT INTO ui.groupdesc (
igroupid, vcgroupid, vcgroupname, vcgrouptype, istatus, itenantid) VALUES (
'2040'::integer, 'riskanalyst'::character varying, 'Risk Analyst'::character varying, 'WORKFLOW'::character varying, '1'::integer, '12'::integer)
 returning igroupid;


INSERT INTO ui.groupdesc (
igroupid, vcgroupid, vcgroupname, vcgrouptype, istatus, itenantid) VALUES (
'2041'::integer, 'riskanalyst'::character varying, 'Risk Analyst'::character varying, 'WORKFLOW'::character varying, '1'::integer, '13'::integer)
 returning igroupid;



INSERT INTO ui.groupdesc (
igroupid, vcgroupid, vcgroupname, vcgrouptype, istatus, itenantid) VALUES (
'2042'::integer, 'riskanalyst'::character varying, 'Risk Analyst'::character varying, 'WORKFLOW'::character varying, '1'::integer, '14'::integer)
 returning igroupid;


INSERT INTO ui.groupdesc (
igroupid, vcgroupid, vcgroupname, vcgrouptype, istatus, itenantid) VALUES (
'2043'::integer, 'riskanalyst'::character varying, 'Risk Analyst'::character varying, 'WORKFLOW'::character varying, '1'::integer, '15'::integer)
 returning igroupid;

--RoleMenuAccessMap


--Users 
INSERT INTO ui.webuser (dtapproverstamp, dtentrystamp, dtlastlogindate, vcaddress, vccontact, vcdesignation, vcemailid, vcfirstname, vclastname, vcmobile, vcpassword, vcprofileimg, vcusername, iapproveruserid, ientryuserid, istatus, timezones, resetpasswordtoken, dtlastpasswordupdate, loginattempts, iorgid) 
VALUES ('2023-06-10 13:47:12.625', '2023-03-22 11:17:35.851', '2023-10-30 15:19:06.481', NULL, '9988', 'CEO', 'cadmin@epifi.com', 'cadmin', 'cadmin', '7219024345', '$2a$10$EoTv5mhWPRxMbRTBYJ0V4ucuG761Lb7Cp8T/pJZOc8/szTepMVNm.', '', 'cadmin@epifi.com', 2, 1, 1, 'Asia/Kolkata', '6HTThBznzAaZtr52O9YcsSEQ6ZaslB', '2023-10-09 19:46:14.746', 0, 3);
INSERT INTO ui.webuser (dtapproverstamp, dtentrystamp, dtlastlogindate, vcaddress, vccontact, vcdesignation, vcemailid, vcfirstname, vclastname, vcmobile, vcpassword, vcprofileimg, vcusername, iapproveruserid, ientryuserid, istatus, timezones, resetpasswordtoken, dtlastpasswordupdate, loginattempts, iorgid) 
VALUES ('2023-06-10 13:47:12.625', '2023-03-22 11:17:35.851', '2023-10-30 15:19:06.481', NULL, '9988', 'CEO', 'madmin@epifi.com', 'madmin', 'madmin', '7219024345', '$2a$10$EoTv5mhWPRxMbRTBYJ0V4ucuG761Lb7Cp8T/pJZOc8/szTepMVNm.', '', 'madmin@epifi.com', 2, 1, 1, 'Asia/Kolkata', '6HTThBznzAaZtr52O9YcsSEQ6ZaslB', '2023-10-09 19:46:14.746', 0, 3);

INSERT INTO ui.webuser (dtapproverstamp, dtentrystamp, dtlastlogindate, vcaddress, vccontact, vcdesignation, vcemailid, vcfirstname, vclastname, vcmobile, vcpassword, vcprofileimg, vcusername, iapproveruserid, ientryuserid, istatus, timezones, resetpasswordtoken, dtlastpasswordupdate, loginattempts, iorgid) 
VALUES ('2023-06-10 13:47:12.625', '2023-03-22 11:17:35.851', '2023-10-30 15:19:06.481', NULL, '9988', 'CEO', 'cadmin@42c.com', 'cadmin', 'cadmin', '7219024345', '$2a$10$EoTv5mhWPRxMbRTBYJ0V4ucuG761Lb7Cp8T/pJZOc8/szTepMVNm.', '', 'cadmin@42c.com', 2, 1, 1, 'Asia/Kolkata', '6HTThBznzAaZtr52O9YcsSEQ6ZaslB', '2023-10-09 19:46:14.746', 0, 4);
INSERT INTO ui.webuser (dtapproverstamp, dtentrystamp, dtlastlogindate, vcaddress, vccontact, vcdesignation, vcemailid, vcfirstname, vclastname, vcmobile, vcpassword, vcprofileimg, vcusername, iapproveruserid, ientryuserid, istatus, timezones, resetpasswordtoken, dtlastpasswordupdate, loginattempts, iorgid) 
VALUES ('2023-06-10 13:47:12.625', '2023-03-22 11:17:35.851', '2023-10-30 15:19:06.481', NULL, '9988', 'CEO', 'madmin@42c.com', 'madmin', 'madmin', '7219024345', '$2a$10$EoTv5mhWPRxMbRTBYJ0V4ucuG761Lb7Cp8T/pJZOc8/szTepMVNm.', '', 'madmin@42c.com', 2, 1, 1, 'Asia/Kolkata', '6HTThBznzAaZtr52O9YcsSEQ6ZaslB', '2023-10-09 19:46:14.746', 0, 4);

INSERT INTO ui.webuser (dtapproverstamp, dtentrystamp, dtlastlogindate, vcaddress, vccontact, vcdesignation, vcemailid, vcfirstname, vclastname, vcmobile, vcpassword, vcprofileimg, vcusername, iapproveruserid, ientryuserid, istatus, timezones, resetpasswordtoken, dtlastpasswordupdate, loginattempts, iorgid) 
VALUES ('2023-06-10 13:47:12.625', '2023-03-22 11:17:35.851', '2023-10-30 15:19:06.481', NULL, '9988', 'CEO', 'cadmin@ybaml.com', 'cadmin', 'cadmin', '7219024345', '$2a$10$EoTv5mhWPRxMbRTBYJ0V4ucuG761Lb7Cp8T/pJZOc8/szTepMVNm.', '', 'cadmin@ybaml.com', 2, 1, 1, 'Asia/Kolkata', '6HTThBznzAaZtr52O9YcsSEQ6ZaslB', '2023-10-09 19:46:14.746', 0, 5);
INSERT INTO ui.webuser (dtapproverstamp, dtentrystamp, dtlastlogindate, vcaddress, vccontact, vcdesignation, vcemailid, vcfirstname, vclastname, vcmobile, vcpassword, vcprofileimg, vcusername, iapproveruserid, ientryuserid, istatus, timezones, resetpasswordtoken, dtlastpasswordupdate, loginattempts, iorgid) 
VALUES ('2023-06-10 13:47:12.625', '2023-03-22 11:17:35.851', '2023-10-30 15:19:06.481', NULL, '9988', 'CEO', 'madmin@ybaml.com', 'madmin', 'madmin', '7219024345', '$2a$10$EoTv5mhWPRxMbRTBYJ0V4ucuG761Lb7Cp8T/pJZOc8/szTepMVNm.', '', 'madmin@ybaml.com', 2, 1, 1, 'Asia/Kolkata', '6HTThBznzAaZtr52O9YcsSEQ6ZaslB', '2023-10-09 19:46:14.746', 0, 5);

INSERT INTO ui.webuser (dtapproverstamp, dtentrystamp, dtlastlogindate, vcaddress, vccontact, vcdesignation, vcemailid, vcfirstname, vclastname, vcmobile, vcpassword, vcprofileimg, vcusername, iapproveruserid, ientryuserid, istatus, timezones, resetpasswordtoken, dtlastpasswordupdate, loginattempts, iorgid) 
VALUES ('2023-06-10 13:47:12.625', '2023-03-22 11:17:35.851', '2023-10-30 15:19:06.481', NULL, '9988', 'CEO', 'cadmin@ybfrm.com', 'cadmin', 'cadmin', '7219024345', '$2a$10$EoTv5mhWPRxMbRTBYJ0V4ucuG761Lb7Cp8T/pJZOc8/szTepMVNm.', '', 'cadmin@ybfrm.com', 2, 1, 1, 'Asia/Kolkata', '6HTThBznzAaZtr52O9YcsSEQ6ZaslB', '2023-10-09 19:46:14.746', 0, 6);
INSERT INTO ui.webuser (dtapproverstamp, dtentrystamp, dtlastlogindate, vcaddress, vccontact, vcdesignation, vcemailid, vcfirstname, vclastname, vcmobile, vcpassword, vcprofileimg, vcusername, iapproveruserid, ientryuserid, istatus, timezones, resetpasswordtoken, dtlastpasswordupdate, loginattempts, iorgid) 
VALUES ('2023-06-10 13:47:12.625', '2023-03-22 11:17:35.851', '2023-10-30 15:19:06.481', NULL, '9988', 'CEO', 'madmin@ybfrm.com', 'madmin', 'madmin', '7219024345', '$2a$10$EoTv5mhWPRxMbRTBYJ0V4ucuG761Lb7Cp8T/pJZOc8/szTepMVNm.', '', 'madmin@ybfrm.com', 2, 1, 1, 'Asia/Kolkata', '6HTThBznzAaZtr52O9YcsSEQ6ZaslB', '2023-10-09 19:46:14.746', 0, 6);

INSERT INTO ui.webuser (dtapproverstamp, dtentrystamp, dtlastlogindate, vcaddress, vccontact, vcdesignation, vcemailid, vcfirstname, vclastname, vcmobile, vcpassword, vcprofileimg, vcusername, iapproveruserid, ientryuserid, istatus, timezones, resetpasswordtoken, dtlastpasswordupdate, loginattempts, iorgid) 
VALUES ('2023-06-10 13:47:12.625', '2023-03-22 11:17:35.851', '2023-10-30 15:19:06.481', NULL, '9988', 'CEO', 'cadmin@pinelabs.com', 'cadmin', 'cadmin', '7219024345', '$2a$10$EoTv5mhWPRxMbRTBYJ0V4ucuG761Lb7Cp8T/pJZOc8/szTepMVNm.', '', 'cadmin@pinelabs.com', 2, 1, 1, 'Asia/Kolkata', '6HTThBznzAaZtr52O9YcsSEQ6ZaslB', '2023-10-09 19:46:14.746', 0, 7);
INSERT INTO ui.webuser (dtapproverstamp, dtentrystamp, dtlastlogindate, vcaddress, vccontact, vcdesignation, vcemailid, vcfirstname, vclastname, vcmobile, vcpassword, vcprofileimg, vcusername, iapproveruserid, ientryuserid, istatus, timezones, resetpasswordtoken, dtlastpasswordupdate, loginattempts, iorgid) 
VALUES ('2023-06-10 13:47:12.625', '2023-03-22 11:17:35.851', '2023-10-30 15:19:06.481', NULL, '9988', 'CEO', 'madmin@pinelabs.com', 'madmin', 'madmin', '7219024345', '$2a$10$EoTv5mhWPRxMbRTBYJ0V4ucuG761Lb7Cp8T/pJZOc8/szTepMVNm.', '', 'madmin@pinelabs.com', 2, 1, 1, 'Asia/Kolkata', '6HTThBznzAaZtr52O9YcsSEQ6ZaslB', '2023-10-09 19:46:14.746', 0, 7);

INSERT INTO ui.webuser (dtapproverstamp, dtentrystamp, dtlastlogindate, vcaddress, vccontact, vcdesignation, vcemailid, vcfirstname, vclastname, vcmobile, vcpassword, vcprofileimg, vcusername, iapproveruserid, ientryuserid, istatus, timezones, resetpasswordtoken, dtlastpasswordupdate, loginattempts, iorgid) 
VALUES ('2023-06-10 13:47:12.625', '2023-03-22 11:17:35.851', '2023-10-30 15:19:06.481', NULL, '9988', 'CEO', 'cadmin@groww.com', 'cadmin', 'cadmin', '7219024345', '$2a$10$EoTv5mhWPRxMbRTBYJ0V4ucuG761Lb7Cp8T/pJZOc8/szTepMVNm.', '', 'cadmin@groww.com', 2, 1, 1, 'Asia/Kolkata', '6HTThBznzAaZtr52O9YcsSEQ6ZaslB', '2023-10-09 19:46:14.746', 0, 8);
INSERT INTO ui.webuser (dtapproverstamp, dtentrystamp, dtlastlogindate, vcaddress, vccontact, vcdesignation, vcemailid, vcfirstname, vclastname, vcmobile, vcpassword, vcprofileimg, vcusername, iapproveruserid, ientryuserid, istatus, timezones, resetpasswordtoken, dtlastpasswordupdate, loginattempts, iorgid) 
VALUES ('2023-06-10 13:47:12.625', '2023-03-22 11:17:35.851', '2023-10-30 15:19:06.481', NULL, '9988', 'CEO', 'madmin@groww.com', 'madmin', 'madmin', '7219024345', '$2a$10$EoTv5mhWPRxMbRTBYJ0V4ucuG761Lb7Cp8T/pJZOc8/szTepMVNm.', '', 'madmin@groww.com', 2, 1, 1, 'Asia/Kolkata', '6HTThBznzAaZtr52O9YcsSEQ6ZaslB', '2023-10-09 19:46:14.746', 0, 8);

INSERT INTO ui.webuser (dtapproverstamp, dtentrystamp, dtlastlogindate, vcaddress, vccontact, vcdesignation, vcemailid, vcfirstname, vclastname, vcmobile, vcpassword, vcprofileimg, vcusername, iapproveruserid, ientryuserid, istatus, timezones, resetpasswordtoken, dtlastpasswordupdate, loginattempts, iorgid) 
VALUES ('2023-06-10 13:47:12.625', '2023-03-22 11:17:35.851', '2023-10-30 15:19:06.481', NULL, '9988', 'CEO', 'cadmin@jfs-jpb.com', 'cadmin', 'cadmin', '7219024345', '$2a$10$EoTv5mhWPRxMbRTBYJ0V4ucuG761Lb7Cp8T/pJZOc8/szTepMVNm.', '', 'cadmin@jfs-jpb.com', 2, 1, 1, 'Asia/Kolkata', '6HTThBznzAaZtr52O9YcsSEQ6ZaslB', '2023-10-09 19:46:14.746', 0, 9);
INSERT INTO ui.webuser (dtapproverstamp, dtentrystamp, dtlastlogindate, vcaddress, vccontact, vcdesignation, vcemailid, vcfirstname, vclastname, vcmobile, vcpassword, vcprofileimg, vcusername, iapproveruserid, ientryuserid, istatus, timezones, resetpasswordtoken, dtlastpasswordupdate, loginattempts, iorgid) 
VALUES ('2023-06-10 13:47:12.625', '2023-03-22 11:17:35.851', '2023-10-30 15:19:06.481', NULL, '9988', 'CEO', 'madmin@jfs-jpb.com', 'madmin', 'madmin', '7219024345', '$2a$10$EoTv5mhWPRxMbRTBYJ0V4ucuG761Lb7Cp8T/pJZOc8/szTepMVNm.', '', 'madmin@jfs-jpb.com', 2, 1, 1, 'Asia/Kolkata', '6HTThBznzAaZtr52O9YcsSEQ6ZaslB', '2023-10-09 19:46:14.746', 0, 9);

INSERT INTO ui.webuser (dtapproverstamp, dtentrystamp, dtlastlogindate, vcaddress, vccontact, vcdesignation, vcemailid, vcfirstname, vclastname, vcmobile, vcpassword, vcprofileimg, vcusername, iapproveruserid, ientryuserid, istatus, timezones, resetpasswordtoken, dtlastpasswordupdate, loginattempts, iorgid) 
VALUES ('2023-06-10 13:47:12.625', '2023-03-22 11:17:35.851', '2023-10-30 15:19:06.481', NULL, '9988', 'CEO', 'cadmin@jfs-jpsl.com', 'cadmin', 'cadmin', '7219024345', '$2a$10$EoTv5mhWPRxMbRTBYJ0V4ucuG761Lb7Cp8T/pJZOc8/szTepMVNm.', '', 'cadmin@jfs-jpsl.com', 2, 1, 1, 'Asia/Kolkata', '6HTThBznzAaZtr52O9YcsSEQ6ZaslB', '2023-10-09 19:46:14.746', 0, 10);
INSERT INTO ui.webuser (dtapproverstamp, dtentrystamp, dtlastlogindate, vcaddress, vccontact, vcdesignation, vcemailid, vcfirstname, vclastname, vcmobile, vcpassword, vcprofileimg, vcusername, iapproveruserid, ientryuserid, istatus, timezones, resetpasswordtoken, dtlastpasswordupdate, loginattempts, iorgid) 
VALUES ('2023-06-10 13:47:12.625', '2023-03-22 11:17:35.851', '2023-10-30 15:19:06.481', NULL, '9988', 'CEO', 'madmin@jfs-jpsl.com', 'madmin', 'madmin', '7219024345', '$2a$10$EoTv5mhWPRxMbRTBYJ0V4ucuG761Lb7Cp8T/pJZOc8/szTepMVNm.', '', 'madmin@jfs-jpsl.com', 2, 1, 1, 'Asia/Kolkata', '6HTThBznzAaZtr52O9YcsSEQ6ZaslB', '2023-10-09 19:46:14.746', 0, 10);

-----EPIFI user access
INSERT INTO ui.webusermapping (mappingid, mappingtype, webuserid) VALUES (5,
'Tenant', (select iuserid from ui.webuser where vcusername='cadmin@epifi.com'));

INSERT INTO ui.webusermapping (mappingid, mappingtype, webuserid) VALUES (5,
'Tenant', (select iuserid from ui.webuser where vcusername='madmin@epifi.com'));


INSERT INTO ui.webusermapping (mappingid, mappingtype, webuserid) VALUES (19,
'Role', (select iuserid from ui.webuser where vcusername='cadmin@epifi.com'));

INSERT INTO ui.webusermapping (mappingid, mappingtype, webuserid) VALUES (19,
'Role', (select iuserid from ui.webuser where vcusername='madmin@epifi.com'));

INSERT INTO ui.webusermapping (mappingid, mappingtype, webuserid) VALUES (2033,
'Group', (select iuserid from ui.webuser where vcusername='cadmin@epifi.com'));

INSERT INTO ui.webusermapping (mappingid, mappingtype, webuserid) VALUES (2033,
'Group', (select iuserid from ui.webuser where vcusername='madmin@epifi.com'));


-----42C user access
INSERT INTO ui.webusermapping (mappingid, mappingtype, webuserid) VALUES (6,
'Tenant', (select iuserid from ui.webuser where vcusername='cadmin@42c.com'));

INSERT INTO ui.webusermapping (mappingid, mappingtype, webuserid) VALUES (6,
'Tenant', (select iuserid from ui.webuser where vcusername='madmin@42c.com'));

INSERT INTO ui.webusermapping (mappingid, mappingtype, webuserid) VALUES (7,
'Tenant', (select iuserid from ui.webuser where vcusername='cadmin@42c.com'));

INSERT INTO ui.webusermapping (mappingid, mappingtype, webuserid) VALUES (7,
'Tenant', (select iuserid from ui.webuser where vcusername='madmin@42c.com'));

INSERT INTO ui.webusermapping (mappingid, mappingtype, webuserid) VALUES (20,
'Role', (select iuserid from ui.webuser where vcusername='cadmin@42c.com'));

INSERT INTO ui.webusermapping (mappingid, mappingtype, webuserid) VALUES (20,
'Role', (select iuserid from ui.webuser where vcusername='madmin@42c.com'));

INSERT INTO ui.webusermapping (mappingid, mappingtype, webuserid) VALUES (2034,
'Group', (select iuserid from ui.webuser where vcusername='cadmin@42c.com'));

INSERT INTO ui.webusermapping (mappingid, mappingtype, webuserid) VALUES (2034,
'Group', (select iuserid from ui.webuser where vcusername='madmin@42c.com'));



-----YBAML user mapping
INSERT INTO ui.webusermapping (mappingid, mappingtype, webuserid) VALUES (8,
'Tenant', (select iuserid from ui.webuser where vcusername='cadmin@ybaml.com'));

INSERT INTO ui.webusermapping (mappingid, mappingtype, webuserid) VALUES (8,
'Tenant', (select iuserid from ui.webuser where vcusername='madmin@ybaml.com'));

INSERT INTO ui.webusermapping (mappingid, mappingtype, webuserid) VALUES (22,
'Role', (select iuserid from ui.webuser where vcusername='cadmin@ybaml.com'));

INSERT INTO ui.webusermapping (mappingid, mappingtype, webuserid) VALUES (22,
'Role', (select iuserid from ui.webuser where vcusername='madmin@ybaml.com'));

INSERT INTO ui.webusermapping (mappingid, mappingtype, webuserid) VALUES (2036,
'Group', (select iuserid from ui.webuser where vcusername='cadmin@ybaml.com'));

INSERT INTO ui.webusermapping (mappingid, mappingtype, webuserid) VALUES (2036,
'Group', (select iuserid from ui.webuser where vcusername='madmin@ybaml.com'));

--YBFRM user mapping

INSERT INTO ui.webusermapping (mappingid, mappingtype, webuserid) VALUES (9,
'Tenant', (select iuserid from ui.webuser where vcusername='cadmin@ybfrm.com'));

INSERT INTO ui.webusermapping (mappingid, mappingtype, webuserid) VALUES (9,
'Tenant', (select iuserid from ui.webuser where vcusername='madmin@ybfrm.com'));

INSERT INTO ui.webusermapping (mappingid, mappingtype, webuserid) VALUES (23,
'Role', (select iuserid from ui.webuser where vcusername='cadmin@ybfrm.com'));

INSERT INTO ui.webusermapping (mappingid, mappingtype, webuserid) VALUES (23,
'Role', (select iuserid from ui.webuser where vcusername='madmin@ybfrm.com'));

INSERT INTO ui.webusermapping (mappingid, mappingtype, webuserid) VALUES (2037,
'Group', (select iuserid from ui.webuser where vcusername='cadmin@ybfrm.com'));

INSERT INTO ui.webusermapping (mappingid, mappingtype, webuserid) VALUES (2037,
'Group', (select iuserid from ui.webuser where vcusername='madmin@ybfrm.com'));

--Pinelabs user mapping

INSERT INTO ui.webusermapping (mappingid, mappingtype, webuserid) VALUES (10,
'Tenant', (select iuserid from ui.webuser where vcusername='cadmin@pinelabs.com'));

INSERT INTO ui.webusermapping (mappingid, mappingtype, webuserid) VALUES (10,
'Tenant', (select iuserid from ui.webuser where vcusername='madmin@pinelabs.com'));

INSERT INTO ui.webusermapping (mappingid, mappingtype, webuserid) VALUES (24,
'Role', (select iuserid from ui.webuser where vcusername='cadmin@pinelabs.com'));

INSERT INTO ui.webusermapping (mappingid, mappingtype, webuserid) VALUES (24,
'Role', (select iuserid from ui.webuser where vcusername='madmin@pinelabs.com'));

INSERT INTO ui.webusermapping (mappingid, mappingtype, webuserid) VALUES (2038,
'Group', (select iuserid from ui.webuser where vcusername='cadmin@pinelabs.com'));

INSERT INTO ui.webusermapping (mappingid, mappingtype, webuserid) VALUES (2038,
'Group', (select iuserid from ui.webuser where vcusername='madmin@pinelabs.com'));

--Groww user mapping

INSERT INTO ui.webusermapping (mappingid, mappingtype, webuserid) VALUES (11,
'Tenant', (select iuserid from ui.webuser where vcusername='cadmin@groww.com'));

INSERT INTO ui.webusermapping (mappingid, mappingtype, webuserid) VALUES (11,
'Tenant', (select iuserid from ui.webuser where vcusername='madmingroww.com'));

INSERT INTO ui.webusermapping (mappingid, mappingtype, webuserid) VALUES (25,
'Role', (select iuserid from ui.webuser where vcusername='cadmin@groww.com'));

INSERT INTO ui.webusermapping (mappingid, mappingtype, webuserid) VALUES (25,
'Role', (select iuserid from ui.webuser where vcusername='madmin@groww.com'));

INSERT INTO ui.webusermapping (mappingid, mappingtype, webuserid) VALUES (2039,
'Group', (select iuserid from ui.webuser where vcusername='cadmin@groww.com'));

INSERT INTO ui.webusermapping (mappingid, mappingtype, webuserid) VALUES (2039,
'Group', (select iuserid from ui.webuser where vcusername='madmin@groww.com'));

--JSF-JPB user mapping

INSERT INTO ui.webusermapping (mappingid, mappingtype, webuserid) VALUES (12,
'Tenant', (select iuserid from ui.webuser where vcusername='cadmin@jsf-jpb.com'));

INSERT INTO ui.webusermapping (mappingid, mappingtype, webuserid) VALUES (12,
'Tenant', (select iuserid from ui.webuser where vcusername='madmin@jsf-jpb.com'));

INSERT INTO ui.webusermapping (mappingid, mappingtype, webuserid) VALUES (13,
'Tenant', (select iuserid from ui.webuser where vcusername='cadmin@jsf-jpb.com'));

INSERT INTO ui.webusermapping (mappingid, mappingtype, webuserid) VALUES (13,
'Tenant', (select iuserid from ui.webuser where vcusername='madmin@jsf-jpb.com'));

INSERT INTO ui.webusermapping (mappingid, mappingtype, webuserid) VALUES (26,
'Role', (select iuserid from ui.webuser where vcusername='cadmin@jsf-jpb.com'));

INSERT INTO ui.webusermapping (mappingid, mappingtype, webuserid) VALUES (26,
'Role', (select iuserid from ui.webuser where vcusername='madmin@jsf-jpb.com'));

INSERT INTO ui.webusermapping (mappingid, mappingtype, webuserid) VALUES (2040,
'Group', (select iuserid from ui.webuser where vcusername='cadmin@jsf-jpb.com'));

INSERT INTO ui.webusermapping (mappingid, mappingtype, webuserid) VALUES (2040,
'Group', (select iuserid from ui.webuser where vcusername='madmin@jsf-jpb.com'));

--JSF-JPSL user mapping

INSERT INTO ui.webusermapping (mappingid, mappingtype, webuserid) VALUES (14,
'Tenant', (select iuserid from ui.webuser where vcusername='cadmin@jsf-jpsl.com'));

INSERT INTO ui.webusermapping (mappingid, mappingtype, webuserid) VALUES (14,
'Tenant', (select iuserid from ui.webuser where vcusername='madmin@jsf-jpsl.com'));

INSERT INTO ui.webusermapping (mappingid, mappingtype, webuserid) VALUES (15,
'Tenant', (select iuserid from ui.webuser where vcusername='cadmin@jsf-jpsl.com'));

INSERT INTO ui.webusermapping (mappingid, mappingtype, webuserid) VALUES (15,
'Tenant', (select iuserid from ui.webuser where vcusername='madmin@jsf-jpsl.com'));

INSERT INTO ui.webusermapping (mappingid, mappingtype, webuserid) VALUES (28,
'Role', (select iuserid from ui.webuser where vcusername='cadmin@jsf-jpsl.com'));

INSERT INTO ui.webusermapping (mappingid, mappingtype, webuserid) VALUES (28,
'Role', (select iuserid from ui.webuser where vcusername='madmin@jsf-jpsl.com'));

INSERT INTO ui.webusermapping (mappingid, mappingtype, webuserid) VALUES (2042,
'Group', (select iuserid from ui.webuser where vcusername='cadmin@jsf-jpsl.com'));

INSERT INTO ui.webusermapping (mappingid, mappingtype, webuserid) VALUES (2042,
'Group', (select iuserid from ui.webuser where vcusername='madmin@jsf-jpsl.com'));
