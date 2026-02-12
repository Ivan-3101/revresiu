-- ui.listmaster

UPDATE ui.listmaster SET
vcname = 'Custom'::character varying WHERE
ilistmasterid = 3 AND itenantid = 14;

INSERT INTO ui.listmaster (
ilistmasterid, ifordays, vcname, itenantid) VALUES (
'3'::integer, '75'::integer, 'Custom'::character varying, '5'::integer)
 returning ilistmasterid,itenantid;

INSERT INTO ui.listmaster (
ilistmasterid, ifordays, vcname, itenantid) VALUES (
'3'::integer, '75'::integer, 'Custom'::character varying, '13'::integer)
 returning ilistmasterid,itenantid;

INSERT INTO ui.listmaster (
ilistmasterid, ifordays, vcname, itenantid) VALUES (
'3'::integer, '75'::integer, 'Custom'::character varying, '12'::integer)
 returning ilistmasterid,itenantid;

INSERT INTO ui.listmaster (
ilistmasterid, ifordays, vcname, itenantid) VALUES (
'3'::integer, '75'::integer, 'Custom'::character varying, '10'::integer)
 returning ilistmasterid,itenantid;

INSERT INTO ui.listmaster (
ilistmasterid, ifordays, vcname, itenantid) VALUES (
'3'::integer, '75'::integer, 'Custom'::character varying, '24'::integer)
 returning ilistmasterid,itenantid;

INSERT INTO ui.listmaster (
ilistmasterid, ifordays, vcname, itenantid) VALUES (
'3'::integer, '75'::integer, 'Custom'::character varying, '20'::integer)
 returning ilistmasterid,itenantid;

INSERT INTO ui.listmaster (
ilistmasterid, ifordays, vcname, itenantid) VALUES (
'3'::integer, '75'::integer, 'Custom'::character varying, '7'::integer)
 returning ilistmasterid,itenantid;

INSERT INTO ui.listmaster (
ilistmasterid, ifordays, vcname, itenantid) VALUES (
'3'::integer, '75'::integer, 'Custom'::character varying, '6'::integer)
 returning ilistmasterid,itenantid;

INSERT INTO ui.listmaster (
ilistmasterid, ifordays, vcname, itenantid) VALUES (
'3'::integer, '75'::integer, 'Custom'::character varying, '19'::integer)
 returning ilistmasterid,itenantid;

INSERT INTO ui.listmaster (
ilistmasterid, ifordays, vcname, itenantid) VALUES (
'3'::integer, '75'::integer, 'Custom'::character varying, '9'::integer)
 returning ilistmasterid,itenantid;

INSERT INTO ui.listmaster (
ilistmasterid, ifordays, vcname, itenantid) VALUES (
'3'::integer, '75'::integer, 'Custom'::character varying, '15'::integer)
 returning ilistmasterid,itenantid;

-- ui.validationfieldslist

--JPSL

UPDATE ui.validationfieldslist SET
vcscoreapipath = 'observations.payeeVPA.account.customer.default_mcc'::character varying, vcfielddisplayname = 'Default Merchant Category Code'::character varying WHERE
itenantid = 14 and vcinternalfield='default_mcc';

UPDATE ui.validationfieldslist SET
vcscoreapipath = 'observations.payeeVPA.account.customer.default_mcc'::character varying, vcfielddisplayname = 'Default Merchant Category Code'::character varying WHERE
itenantid = 15 and vcinternalfield='default_mcc';

--JPB

INSERT INTO ui.validationfieldslist (
ifieldid, bfirst, vcdatatype, vcfielddisplayname, vcinternalfield, vcscoreapipath, vcvalidation, itenantid) VALUES (
'1642'::integer, false::boolean, 'integer'::character varying, 'Default Merchant Category Code'::character varying, 'default_mcc'::character varying, 'observations.payeeVPA.account.customer.default_mcc'::character varying,  E'{
    "regexp": "/^[1-9]\\\\d{0,3}$/",
    "maxLength": 4,
    "regexpmessage":"MCC has to be a 4 digit number"
 }'::character varying, '12'::integer)
 returning ifieldid;

INSERT INTO ui.validationfieldslist (
ifieldid, bfirst, vcdatatype, vcfielddisplayname, vcinternalfield, vcscoreapipath, vcvalidation, itenantid) VALUES (
'1643'::integer, false::boolean, 'integer'::character varying, 'Default Merchant Category Code'::character varying, 'default_mcc'::character varying, 'observations.payeeVPA.account.customer.default_mcc'::character varying,  E'{
    "regexp": "/^[1-9]\\\\d{0,3}$/",
    "maxLength": 4,
    "regexpmessage":"MCC has to be a 4 digit number"
 }'::character varying, '13'::integer)
 returning ifieldid;

--Pinelabs

INSERT INTO ui.validationfieldslist (
ifieldid, bfirst, vcdatatype, vcfielddisplayname, vcinternalfield, vcscoreapipath, vcvalidation, itenantid) VALUES (
'1644'::integer, false::boolean, 'string'::character varying, 'Payee Country Code'::character varying, 'device_location'::character varying, 'payee.attribs.address.countryCode'::character varying, '{
    "regexp": "/^[a-zA-Z]{2}$/",
    "maxLength": 2,
    "minLength": 2
 }'::character varying, '10'::integer)
 returning ifieldid;

INSERT INTO ui.validationfieldslist (
ifieldid, bfirst, vcdatatype, vcfielddisplayname, vcinternalfield, vcscoreapipath, vcvalidation, itenantid) VALUES (
'1645'::integer, false::boolean, 'integer'::character varying, 'Payee MCC'::character varying, 'default_mcc'::character varying, 'observations.payeeVPA.account.customer.default_mcc'::character varying,  E'{
    "regexp": "/^[1-9]\\\\d{0,3}$/",
    "maxLength": 4,
    "regexpmessage":"MCC has to be a 4 digit number"
 }'::character varying, '10'::integer)
 returning ifieldid;

--42C

INSERT INTO ui.validationfieldslist (
ifieldid, bfirst, vcdatatype, vcfielddisplayname, vcinternalfield, vcscoreapipath, vcvalidation, itenantid) VALUES (
'1646'::integer, false::boolean, 'string'::character varying, 'Country Code'::character varying, 'country'::character varying, 'observations.geolocation.country'::character varying, '{
    "regexp": "/^[a-zA-Z]{2}$/",
    "maxLength": 2,
    "minLength": 2
 }'::character varying, '6'::integer)
 returning ifieldid;

INSERT INTO ui.validationfieldslist (
ifieldid, bfirst, vcdatatype, vcfielddisplayname, vcinternalfield, vcscoreapipath, vcvalidation, itenantid) VALUES (
'1647'::integer, false::boolean, 'string'::character varying, 'Country Code'::character varying, 'country'::character varying, 'observations.geolocation.country'::character varying, '{
    "regexp": "/^[a-zA-Z]{2}$/",
    "maxLength": 2,
    "minLength": 2
 }'::character varying, '7'::integer)
 returning ifieldid;

INSERT INTO ui.validationfieldslist (
ifieldid, bfirst, vcdatatype, vcfielddisplayname, vcinternalfield, vcscoreapipath, vcvalidation, itenantid) VALUES (
'1648'::integer, false::boolean, 'string'::character varying, 'Country Code'::character varying, 'country'::character varying, 'observations.geolocation.country'::character varying, '{
    "regexp": "/^[a-zA-Z]{2}$/",
    "maxLength": 2,
    "minLength": 2
 }'::character varying, '20'::integer)
 returning ifieldid;

INSERT INTO ui.validationfieldslist (
ifieldid, bfirst, vcdatatype, vcfielddisplayname, vcinternalfield, vcscoreapipath, vcvalidation, itenantid) VALUES (
'1649'::integer, false::boolean, 'string'::character varying, 'Country Code'::character varying, 'country'::character varying, 'observations.geolocation.country'::character varying, '{
    "regexp": "/^[a-zA-Z]{2}$/",
    "maxLength": 2,
    "minLength": 2
 }'::character varying, '24'::integer)
 returning ifieldid;