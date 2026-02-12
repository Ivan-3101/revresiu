---validation fields ssfb
delete from ui.validationfieldslist where itenantid=24;



INSERT INTO ui.validationfieldslist (
ifieldid, bfirst, vcdatatype, vcfielddisplayname, vcinternalfield, vcscoreapipath, vcvalidation, itenantid) VALUES (
(select max(ifieldid)+1 from ui.validationfieldslist)::integer, 
	false::boolean, 
	'string'::character varying, 
	'Country Code'::character varying, 
	'country'::character varying, 
	'observations.geolocation.country'::character varying, '{
    "regexp": "/^[a-zA-Z]{2}$/",
    "maxLength": 2,
    "minLength": 2
 }'::character varying, '24'::integer)
 returning ifieldid;

INSERT INTO ui.validationfieldslist (
ifieldid, bfirst, vcdatatype, vcfielddisplayname, vcinternalfield, vcscoreapipath, vcvalidation, itenantid) VALUES (
(select max(ifieldid)+1 from ui.validationfieldslist)::integer, 
	false::boolean, 
	'string'::character varying, 
	'Merchant Category Code'::character varying, 
	'payee_mcc'::character varying, 
	'payee.mcc'::character varying, 
	'{
    "regexp": "/^[1-9]\\d{0,3}$/",
    "maxLength": 4,
    "regexpmessage":"MCC has to be a 4 digit number"
 }'::character varying, 
	'24'::integer)
 returning ifieldid;

INSERT INTO ui.validationfieldslist (
ifieldid, bfirst, vcdatatype, vcfielddisplayname, vcinternalfield, vcscoreapipath, vcvalidation, itenantid) VALUES (
(select max(ifieldid)+1 from ui.validationfieldslist)::integer, 
	false::boolean, 
	'integer'::character varying, 
	'Transaction Amount'::character varying, 
	'instructed_amount'::character varying, 
	'observations.instructed_amount'::character varying, 
	'{
     "regexp": "/^\\d{1,13}$/",
     "maxLength": 13,
     "minLength": 1,
     "regexpmessage":"Amount has to be non decimal number in lowest currency denomination"
  }'::character varying, 
	'24'::integer)
 returning ifieldid;

INSERT INTO ui.validationfieldslist (
ifieldid, bfirst, vcdatatype, vcfielddisplayname, vcinternalfield, vcscoreapipath, vcvalidation, itenantid) VALUES (
(select max(ifieldid)+1 from ui.validationfieldslist)::integer, 
true::boolean,  
	'string'::character varying, 
	'Payee Address'::character varying, 
	'payee_addr'::character varying, 
	'payee.addr '::character varying, 
	'{ "maxLength": 255 }'::character varying, 
	'24'::integer)
 returning ifieldid;

INSERT INTO ui.validationfieldslist (
ifieldid, bfirst, vcdatatype, vcfielddisplayname, vcinternalfield, vcscoreapipath, vcvalidation, itenantid) VALUES (
(select max(ifieldid)+1 from ui.validationfieldslist)::integer, 
true::boolean,  
	'string'::character varying, 
	'Payer Address'::character varying, 
	'payer_addr'::character varying, 
	'payer.addr '::character varying, 
	'{ "maxLength": 255 }'::character varying, 
	'24'::integer)
 returning ifieldid;


 UPDATE ui.validationfieldslist SET
vcvalidation = '{
    "regexp": "/^[a-zA-Z]{2,3}$/",
    "maxLength": 3,
    "minLength": 2
 }'::character varying WHERE
itenantid in (6,7,20,24) and vcinternalfield='country';