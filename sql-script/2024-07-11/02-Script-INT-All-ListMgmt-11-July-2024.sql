INSERT INTO ui.validationfieldslist (
ifieldid, bfirst, vcdatatype, vcfielddisplayname, vcinternalfield, vcscoreapipath, vcvalidation) VALUES (
(select max(ifieldid) + 1 from ui.validationfieldslist)::integer, false::boolean, 'string'::character varying, 'Merchant Category Code (Monthly)'::character varying, 'default_mcc_monthly'::character varying, 'observations.payeeVPA.account.default_mcc'::character varying, '{
  "maxLength": 20,
  "regexp": "/^\\+[0-9]+$/"
  }'::character varying)
 returning ifieldid;

INSERT INTO ui.validationfieldslist (
ifieldid, bfirst, vcdatatype, vcfielddisplayname, vcinternalfield, vcscoreapipath, vcvalidation) VALUES (
(select max(ifieldid) + 1 from ui.validationfieldslist)::integer, false::boolean, 'string'::character varying, 'Risky Merchant Category Code'::character varying, 'risky_mcc_daily'::character varying, 'observations.payeeVPA.account.default_mcc'::character varying, '{
  "maxLength": 20,
  "regexp": "/^\\+[0-9]+$/"
  }'::character varying)
 returning ifieldid;


UPDATE ui.validationfieldslist SET
vcvalidation = '{
    "regexp": "/^[1-9]\\d{0,3}$/",
    "maxLength": 4,
    "regexpmessage":"MCC has to be a 4 digit number"
 }'::character varying WHERE
vcfielddisplayname = 'Merchant Category Code';

UPDATE ui.validationfieldslist SET
vcvalidation = '{
    "regexp": "/^\\d{1,13}$/",
    "maxLength": 13,
    "minLength": 1,
    "regexpmessage":"Amount has to be non decimal number in lowest currency denomination"
 }'::character varying WHERE
vcfielddisplayname = 'Transaction Amount';

UPDATE ui.validationfieldslist SET
vcvalidation = '{
    "regexp": "/^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\\.[a-zA-Z]{2,}$/",
    "maxLength": 50,
    "regexpmessage": "Email has to be a valid email address"
}':: character varying WHERE
vcfielddisplayname like '%Email%';


UPDATE ui.validationfieldslist SET
vcvalidation = '{
    "regexp": "/^\\d{4,12}$/",
    "minLength": 4,
    "maxLength": 12,
    "regexpmessage":"Pincode has to be between 4-12 digits""
 }':: character varying WHERE
vcfielddisplayname like '%Pincode%';


UPDATE ui.validationfieldslist SET
vcvalidation = '{
    "regexp": "/^[-+]?([1-8]?\\d(\\.\\d{1,6})?|90(\\.0{1,6})?)\\s*,\\s*[-+]?(180(\\.0{1,6})?|((1[0-7]\\d)|([1-9]?\\d))(\\.\\d{1,6})?)$/",
    "regexpmessage": "Geo code has to be a valid lat long upto resolution of 6 decimals"
}':: character varying WHERE
vcfielddisplayname like '%Geocode%';

UPDATE ui.validationfieldslist SET
vcvalidation = '{
    "regexp": "/^\\+\\d{1,12}$/",
    "regexpmessage": "Mobile number has to be a valid number starting with +Country code followed by number",
    "maxLength": 13
}':: character varying WHERE
vcfielddisplayname like '%Mobile%';

UPDATE ui.validationfieldslist SET
vcvalidation = '{
    "regexp": "/^\\d{6,8}$/",
    "regexpmessage": "BIN has to be a valid number with 6-8 digits",
    "maxLength": 8
}':: character varying WHERE
vcfielddisplayname like '%Mobile%';


UPDATE ui.validationfieldslist SET
vcvalidation = '{
    "regexp": "/^((25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\\.){3}(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)$/",
    "regexpmessage": "IP has to be a valid IPv4 address that is comma separated with 4 octets"
}':: character varying WHERE
vcfielddisplayname like '%IP%';


UPDATE ui.validationfieldslist SET
vcvalidation = '{
    "regexp": "/^[-+]?([1-8]?\\d(\\.\\d{1,6})?|90(\\.0{1,6})?)\\s*,\\s*[-+]?(180(\\.0{1,6})?|((1[0-7]\\d)|([1-9]?\\d))(\\.\\d{1,6})?)$/",
    "regexpmessage": "Location has to be a valid lat long upto resolution of 6 decimals"
}':: character varying WHERE
vcfielddisplayname like '%Location%';
