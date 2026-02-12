TRUNCATE TABLE ui.validationfieldslist;

ALTER TABLE ui.validationfieldslist
ADD COLUMN itenantid integer ;

ALTER TABLE ui.validationfieldslist
ADD CONSTRAINT fk5s15xeosqyc32b431klvbhi9g FOREIGN KEY (itenantid)
REFERENCES ui.tenants (itenantid) MATCH SIMPLE
ON UPDATE NO ACTION
ON DELETE NO ACTION;


INSERT INTO ui.validationfieldslist 
( bfirst, vcdatatype, vcfielddisplayname, vcinternalfield, vcscoreapipath, vcvalidation, itenantid)
select true, 'string', 'Payer Address', 'payer_addr', 'payer.addr', '{ "maxLength": 255 }',
t.itenantid FROM ui.orgs o
left join ui.tenants t on  o.iorgid = t.iorgid 
WHERE o.iorgid in (7,9,6,4,10);

INSERT INTO ui.validationfieldslist 
( bfirst, vcdatatype, vcfielddisplayname, vcinternalfield, vcscoreapipath, vcvalidation, itenantid)
select true , 'string' , 'Payee Address', 'payee_addr', 'payee.addr ', '{ "maxLength": 255 }',
t.itenantid FROM ui.orgs o
left join ui.tenants t on  o.iorgid = t.iorgid 
WHERE o.iorgid in (7,9,6,4,10);

INSERT INTO ui.validationfieldslist 
( bfirst, vcdatatype, vcfielddisplayname, vcinternalfield, vcscoreapipath, vcvalidation, itenantid)
select false , 'string' , 'Payer Account', 'payer_account_external_id', 'observations.payerVPA.account.externalId', null ,
t.itenantid FROM ui.orgs o
left join ui.tenants t on  o.iorgid = t.iorgid 
WHERE o.iorgid in (7,9,10);


INSERT INTO ui.validationfieldslist 
( bfirst, vcdatatype, vcfielddisplayname, vcinternalfield, vcscoreapipath, vcvalidation, itenantid)
select false ,'string' , 'Payee Account', 'payee_account_external_id', 'observations.payeeVPA.account.externalId', null ,
t.itenantid FROM ui.orgs o
left join ui.tenants t on  o.iorgid = t.iorgid 
WHERE o.iorgid in (7,9,10);


INSERT INTO ui.validationfieldslist 
( bfirst, vcdatatype, vcfielddisplayname, vcinternalfield, vcscoreapipath, vcvalidation, itenantid)
select false, 'string', 'Country Code', 'country', 'observations.geolocation.country', '{
    "regexp": "/^[a-zA-Z]{2}$/",
    "maxLength": 2,
    "minLength": 2
 }',
t.itenantid FROM ui.orgs o
left join ui.tenants t on  o.iorgid = t.iorgid 
WHERE o.iorgid in (7,9,4,10);


INSERT INTO ui.validationfieldslist 
( bfirst, vcdatatype, vcfielddisplayname, vcinternalfield, vcscoreapipath, vcvalidation, itenantid)
select false , 'integer' , 'Merchant Category Code', 'default_mcc', 'payee.mcc', '{
    "regexp": "/^[1-9]\\d{0,3}$/",
    "maxLength": 4,
    "regexpmessage":"MCC has to be a 4 digit number"
 }',
t.itenantid FROM ui.orgs o
left join ui.tenants t on  o.iorgid = t.iorgid 
WHERE o.iorgid in (4,7,10);

INSERT INTO ui.validationfieldslist 
( bfirst, vcdatatype, vcfielddisplayname, vcinternalfield, vcscoreapipath, vcvalidation, itenantid)
select false , 'integer' , 'Transaction Amount', 'instructed_amount', 'observations.instructed_amount','{
    "regexp": "/^\\d{1,13}$/",
    "maxLength": 13,
    "minLength": 1,
    "regexpmessage":"Amount has to be non decimal number in lowest currency denomination"
 }',
t.itenantid FROM ui.orgs o
left join ui.tenants t on  o.iorgid = t.iorgid 
WHERE o.iorgid in (7,9,4,10);

INSERT INTO ui.validationfieldslist 
( bfirst, vcdatatype, vcfielddisplayname, vcinternalfield, vcscoreapipath, vcvalidation, itenantid)
select false , 'string', 'Payer Email', 'identity_emailID', 'payer.attribs.emailid', '{
    "regexp": "/^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\\.[a-zA-Z]{2,}$/",
    "maxLength": 50,
    "regexpmessage": "Email has to be a valid email address"
}',
t.itenantid FROM ui.orgs o
left join ui.tenants t on  o.iorgid = t.iorgid 
WHERE o.iorgid in (7,9,10);

INSERT INTO ui.validationfieldslist 
( bfirst, vcdatatype, vcfielddisplayname, vcinternalfield, vcscoreapipath, vcvalidation, itenantid)
select false, 'string', 'Payer Mobile number', 'mobile_num', 'txn.attribs.device.mobilenum', '{
    "regexp": "/^\\+\\d{1,12}$/",
    "regexpmessage": "Mobile number has to be a valid number starting with +Country code followed by number",
    "maxLength": 13
}',
t.itenantid FROM ui.orgs o
left join ui.tenants t on  o.iorgid = t.iorgid 
WHERE o.iorgid in (7,9,10);

INSERT INTO ui.validationfieldslist 
( bfirst, vcdatatype, vcfielddisplayname, vcinternalfield, vcscoreapipath, vcvalidation, itenantid)
select false , 'string', 'Payer Pincode', 'pin_code','payer.attribs.pincode','{
    "regexp": "/^\\d{4,12}$/",
    "minLength": 4,
    "maxLength": 12,
    "regexpmessage":"Pincode has to be between 4-12 digits"
 }',
t.itenantid FROM ui.orgs o
left join ui.tenants t on  o.iorgid = t.iorgid 
WHERE o.iorgid in (7,9,10);

INSERT INTO ui.validationfieldslist 
( bfirst, vcdatatype, vcfielddisplayname, vcinternalfield, vcscoreapipath, vcvalidation, itenantid)
select false ,'string', 'Payee Email', 'identity_emailID', 'payee.attribs.email', '{
    "regexp": "/^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\\.[a-zA-Z]{2,}$/",
    "maxLength": 50,
    "regexpmessage": "Email has to be a valid email address"
}',
t.itenantid FROM ui.orgs o
left join ui.tenants t on  o.iorgid = t.iorgid 
WHERE o.iorgid in (7,10);

INSERT INTO ui.validationfieldslist 
( bfirst, vcdatatype, vcfielddisplayname, vcinternalfield, vcscoreapipath, vcvalidation, itenantid)
select false, 'string' , 'Payee Mobile number', 'mobile_num', 'txn.attribs.device.mobilenum', '{
    "regexp": "/^\\+\\d{1,12}$/",
    "regexpmessage": "Mobile number has to be a valid number starting with +Country code followed by number",
    "maxLength": 13
}',
t.itenantid FROM ui.orgs o
left join ui.tenants t on  o.iorgid = t.iorgid 
WHERE o.iorgid in (7,9,10);

INSERT INTO ui.validationfieldslist 
( bfirst, vcdatatype, vcfielddisplayname, vcinternalfield, vcscoreapipath, vcvalidation, itenantid)
select false, 'string', 'Payee Pincode', 'pin_code', 'payee.attribs.pincode', '{
    "regexp": "/^\\d{4,12}$/",
    "minLength": 4,
    "maxLength": 12,
    "regexpmessage":"Pincode has to be between 4-12 digits"
 }',
t.itenantid FROM ui.orgs o
left join ui.tenants t on  o.iorgid = t.iorgid 
WHERE o.iorgid in (7,9,10);

INSERT INTO ui.validationfieldslist 
( bfirst, vcdatatype, vcfielddisplayname, vcinternalfield, vcscoreapipath, vcvalidation, itenantid)
select false , 'string', 'Payer Card', 'card_number', 'payer.attribs.card.cardReference', NULL,
t.itenantid FROM ui.orgs o
left join ui.tenants t on  o.iorgid = t.iorgid 
WHERE o.iorgid in (7,9,10);

INSERT INTO ui.validationfieldslist 
( bfirst, vcdatatype, vcfielddisplayname, vcinternalfield, vcscoreapipath, vcvalidation, itenantid)
select false , 'string' , 'Payee Card', 'card_number','payer.attribs.card.cardReference', NULL,
t.itenantid FROM ui.orgs o
left join ui.tenants t on  o.iorgid = t.iorgid 
WHERE o.iorgid in (7,10);

INSERT INTO ui.validationfieldslist 
( bfirst, vcdatatype, vcfielddisplayname, vcinternalfield, vcscoreapipath, vcvalidation, itenantid)
select false , 'string', 'Payer Address Watch List', 'payer_addr_watch', 'payer.addr' ,'{
    "maxLength": 255
 }',
t.itenantid FROM ui.orgs o
left join ui.tenants t on  o.iorgid = t.iorgid 
WHERE o.iorgid in (7,9,10);

INSERT INTO ui.validationfieldslist 
( bfirst, vcdatatype, vcfielddisplayname, vcinternalfield, vcscoreapipath, vcvalidation, itenantid)
select false , 'string', 'Payer Address Suspicious', 'payer_addr_suspicious', 'payer.addr', '{
    "maxLength": 255
 }',
t.itenantid FROM ui.orgs o
left join ui.tenants t on  o.iorgid = t.iorgid 
WHERE o.iorgid in (7,9,10);

INSERT INTO ui.validationfieldslist 
( bfirst, vcdatatype, vcfielddisplayname, vcinternalfield, vcscoreapipath, vcvalidation, itenantid)
select false, 'string', 'Device IP', 'device_ip', 'txn.attribs.device.ip', '{
    "regexp": "/^((25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\\.){3}(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)$/",
    "regexpmessage": "IP has to be a valid IPv4 address that is comma separated with 4 octets"
}',
t.itenantid FROM ui.orgs o
left join ui.tenants t on  o.iorgid = t.iorgid 
WHERE o.iorgid in (7,9,10);


INSERT INTO ui.validationfieldslist 
( bfirst, vcdatatype, vcfielddisplayname, vcinternalfield, vcscoreapipath, vcvalidation, itenantid)
select false , 'string', 'Device Location', 'location', 'txn.attribs.device.location', '{
    "regexp": "/^[-+]?([1-8]?\\d(\\.\\d{1,6})?|90(\\.0{1,6})?)\\s*,\\s*[-+]?(180(\\.0{1,6})?|((1[0-7]\\d)|([1-9]?\\d))(\\.\\d{1,6})?)$/",
    "regexpmessage": "Location has to be a valid lat long upto resolution of 6 decimals"
}',
t.itenantid FROM ui.orgs o
left join ui.tenants t on  o.iorgid = t.iorgid 
WHERE o.iorgid in (7,9,10);

INSERT INTO ui.validationfieldslist 
( bfirst, vcdatatype, vcfielddisplayname, vcinternalfield, vcscoreapipath, vcvalidation, itenantid)
select false , 'string', 'Merchant Category Code (Monthly)', 'default_mcc_monthly', 'observations.payeeVPA.account.default_mcc', '{
  "maxLength": 20,
  "regexp": "/^\\+[0-9]+$/"
  }',
t.itenantid FROM ui.orgs o
left join ui.tenants t on  o.iorgid = t.iorgid 
WHERE o.iorgid in (7,10);

INSERT INTO ui.validationfieldslist 
( bfirst, vcdatatype, vcfielddisplayname, vcinternalfield, vcscoreapipath, vcvalidation, itenantid)
select false, 'string', 'Risky Merchant Category Code', 'risky_mcc_daily', 'observations.payeeVPA.account.default_mcc', '{
  "maxLength": 20,
  "regexp": "/^\\+[0-9]+$/"
  }',
t.itenantid FROM ui.orgs o
left join ui.tenants t on  o.iorgid = t.iorgid 
WHERE o.iorgid in (7,10);

INSERT INTO ui.validationfieldslist 
( bfirst, vcdatatype, vcfielddisplayname, vcinternalfield, vcscoreapipath, vcvalidation, itenantid)
select false, 'string', 'Payer Geocode', 'payer_attribs_device_geocode', 'txn.attribs.device.geocode', '{
    "regexp": "/^[-+]?([1-8]?\\d(\\.\\d{1,6})?|90(\\.0{1,6})?)\\s*,\\s*[-+]?(180(\\.0{1,6})?|((1[0-7]\\d)|([1-9]?\\d))(\\.\\d{1,6})?)$/",
    "regexpmessage": "Geo code has to be a valid lat long upto resolution of 6 decimals"
}',
t.itenantid FROM ui.orgs o
left join ui.tenants t on  o.iorgid = t.iorgid 
WHERE o.iorgid in (7,9);

INSERT INTO ui.validationfieldslist 
( bfirst, vcdatatype, vcfielddisplayname, vcinternalfield, vcscoreapipath, vcvalidation, itenantid)
select  false, 'string', 'Payee Geocode', 'payee_attribs_device_geocode', 'txn.attribs.device.geocode', '{
    "regexp": "/^[-+]?([1-8]?\\d(\\.\\d{1,6})?|90(\\.0{1,6})?)\\s*,\\s*[-+]?(180(\\.0{1,6})?|((1[0-7]\\d)|([1-9]?\\d))(\\.\\d{1,6})?)$/",
    "regexpmessage": "Geo code has to be a valid lat long upto resolution of 6 decimals"
}',
t.itenantid FROM ui.orgs o
left join ui.tenants t on  o.iorgid = t.iorgid 
WHERE o.iorgid in (7,9);

INSERT INTO ui.validationfieldslist 
( bfirst, vcdatatype, vcfielddisplayname, vcinternalfield, vcscoreapipath, vcvalidation, itenantid)
select false , 'string', 'Payer BIN', 'bin', 'payer.attribs.card', '{
    "regexp": "/^\\d{6,8}$/",
    "regexpmessage": "BIN has to be a valid number with 6-8 digits",
    "maxLength": 8
}',
t.itenantid FROM ui.orgs o
left join ui.tenants t on  o.iorgid = t.iorgid 
WHERE o.iorgid in (7,9);

INSERT INTO ui.validationfieldslist 
( bfirst, vcdatatype, vcfielddisplayname, vcinternalfield, vcscoreapipath, vcvalidation, itenantid)
select false, 'string', 'Device ID', 'device_id', 'txn.attribs.device.id', '{
    "maxLength": 255
 }',
t.itenantid FROM ui.orgs o
left join ui.tenants t on  o.iorgid = t.iorgid 
WHERE o.iorgid in (7,9);

INSERT INTO ui.validationfieldslist 
( bfirst, vcdatatype, vcfielddisplayname, vcinternalfield, vcscoreapipath, vcvalidation, itenantid)
select false, 'string', 'Merchant Category Code', 'payee_mcc', 'payee.mcc', '{
    "regexp": "/^[1-9]\\d{0,3}$/",
    "maxLength": 4,
    "regexpmessage":"MCC has to be a 4 digit number"
 }',
t.itenantid FROM ui.orgs o
left join ui.tenants t on  o.iorgid = t.iorgid 
WHERE o.iorgid in (9,6,4);