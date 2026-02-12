
Delete from ui.validationfieldslist where itenantid = 25;

INSERT INTO ui.validationfieldslist ( bfirst, vcdatatype, vcfielddisplayname, vcinternalfield, vcscoreapipath, vcvalidation, itenantid) VALUES ( true, 'string', 'Payer Address', 'payer_addr', 'payer.addr', '{ "maxLength": 255 }', 25);
INSERT INTO ui.validationfieldslist ( bfirst, vcdatatype, vcfielddisplayname, vcinternalfield, vcscoreapipath, vcvalidation, itenantid) VALUES ( true, 'string', 'Payee Address', 'payee_addr', 'payee.addr ', '{ "maxLength": 255 }', 25);
INSERT INTO ui.validationfieldslist ( bfirst, vcdatatype, vcfielddisplayname, vcinternalfield, vcscoreapipath, vcvalidation, itenantid) VALUES ( false, 'string', 'Payer Account', 'payer_account_external_id', 'observations.payerVPA.account.externalId', NULL, 25);
INSERT INTO ui.validationfieldslist ( bfirst, vcdatatype, vcfielddisplayname, vcinternalfield, vcscoreapipath, vcvalidation, itenantid) VALUES ( false, 'string', 'Payee Account', 'payee_account_external_id', 'observations.payeeVPA.account.externalId', NULL, 25);
INSERT INTO ui.validationfieldslist ( bfirst, vcdatatype, vcfielddisplayname, vcinternalfield, vcscoreapipath, vcvalidation, itenantid) VALUES ( false, 'string', 'Merchant Category Code', 'payee_mcc', 'payee.mcc', '{
    "regexp": "/^[1-9]\\d{0,3}$/",
    "maxLength": 4,
    "regexpmessage":"MCC has to be a 4 digit number"
 }', 25);
INSERT INTO ui.validationfieldslist ( bfirst, vcdatatype, vcfielddisplayname, vcinternalfield, vcscoreapipath, vcvalidation, itenantid) VALUES ( false, 'integer', 'Transaction Amount', 'instructed_amount', 'observations.instructed_amount', '{
    "regexp": "/^\\d{1,13}$/",
    "maxLength": 13,
    "minLength": 1,
    "regexpmessage":"Amount has to be non decimal number in lowest currency denomination"
 }', 25);
INSERT INTO ui.validationfieldslist ( bfirst, vcdatatype, vcfielddisplayname, vcinternalfield, vcscoreapipath, vcvalidation, itenantid) VALUES ( false, 'string', 'Payer Email', 'identity_emailID', 'payer.attribs.identity.email', '{
    "regexp": "/^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\\.[a-zA-Z]{2,}$/",
    "maxLength": 50,
    "regexpmessage": "Email has to be a valid email address"
}', 25);
INSERT INTO ui.validationfieldslist ( bfirst, vcdatatype, vcfielddisplayname, vcinternalfield, vcscoreapipath, vcvalidation, itenantid) VALUES ( false, 'string', 'Payer Mobile number', 'mobile_num', 'payer.attribs.device.mobilenum', '{
    "regexp": "/^\\+\\d{1,12}$/",
    "regexpmessage": "Mobile number has to be a valid number starting with +Country code followed by number",
    "maxLength": 13
}', 25);
INSERT INTO ui.validationfieldslist ( bfirst, vcdatatype, vcfielddisplayname, vcinternalfield, vcscoreapipath, vcvalidation, itenantid) VALUES ( false, 'string', 'Payee Email', 'identity_emailID', 'payee.attribs.identity.email', '{
    "regexp": "/^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\\.[a-zA-Z]{2,}$/",
    "maxLength": 50,
    "regexpmessage": "Email has to be a valid email address"
}', 25);
INSERT INTO ui.validationfieldslist ( bfirst, vcdatatype, vcfielddisplayname, vcinternalfield, vcscoreapipath, vcvalidation, itenantid) VALUES ( false, 'string', 'Payee Mobile number', 'mobile_num', 'payee.attribs.device.mobilenum', '{
    "regexp": "/^\\+\\d{1,12}$/",
    "regexpmessage": "Mobile number has to be a valid number starting with +Country code followed by number",
    "maxLength": 13
}', 25);
INSERT INTO ui.validationfieldslist ( bfirst, vcdatatype, vcfielddisplayname, vcinternalfield, vcscoreapipath, vcvalidation, itenantid) VALUES ( false, 'string', 'Merchant Category Code (Monthly)', 'default_mcc_monthly', 'observations.payeeVPA.account.default_mcc', '{
    "regexp": "/^[1-9]\\d{0,3}$/",
    "maxLength": 4,
    "regexpmessage":"MCC has to be a 4 digit number"
 }', 25);
INSERT INTO ui.validationfieldslist ( bfirst, vcdatatype, vcfielddisplayname, vcinternalfield, vcscoreapipath, vcvalidation, itenantid) VALUES ( false, 'string', 'Risky Merchant Category Code', 'risky_mcc_daily', 'observations.payeeVPA.account.default_mcc', '{
    "regexp": "/^[1-9]\\d{0,3}$/",
    "maxLength": 4,
    "regexpmessage":"MCC has to be a 4 digit number"
 }', 25);
INSERT INTO ui.validationfieldslist ( bfirst, vcdatatype, vcfielddisplayname, vcinternalfield, vcscoreapipath, vcvalidation, itenantid) VALUES ( false, 'string', 'Payer Device IP', 'payer_device_ip', 'payer.attribs.device.ip', '{
    "regexp": "/^((25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\\.){3}(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)$/",
    "regexpmessage": "IP has to be a valid IPv4 address that is comma separated with 4 octets"
}', 25);
INSERT INTO ui.validationfieldslist ( bfirst, vcdatatype, vcfielddisplayname, vcinternalfield, vcscoreapipath, vcvalidation, itenantid) VALUES ( false, 'string', 'Payee Device IP', 'payee_device_ip', 'payee.attribs.device.ip', '{
    "regexp": "/^((25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\\.){3}(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)$/",
    "regexpmessage": "IP has to be a valid IPv4 address that is comma separated with 4 octets"
}', 25);
INSERT INTO ui.validationfieldslist ( bfirst, vcdatatype, vcfielddisplayname, vcinternalfield, vcscoreapipath, vcvalidation, itenantid) VALUES ( false, 'string', 'Payer Device ID', 'payer_device_id', 'payer.attribs.device.id', '{
    "maxLength": 255
 }', 25);
INSERT INTO ui.validationfieldslist ( bfirst, vcdatatype, vcfielddisplayname, vcinternalfield, vcscoreapipath, vcvalidation, itenantid) VALUES ( false, 'string', 'Payee Device ID', 'payee_device_id', 'payee.attribs.device.id', '{
    "maxLength": 255
 }', 25);
INSERT INTO ui.validationfieldslist ( bfirst, vcdatatype, vcfielddisplayname, vcinternalfield, vcscoreapipath, vcvalidation, itenantid) VALUES ( false, 'string', 'Payer Geocode', 'payer_attribs_device_geocode', 'payer.attribs.device.geocode', '{
    "regexp": "/^[-+]?([1-8]?\\d(\\.\\d{1,6})?|90(\\.0{1,6})?)\\s*,\\s*[-+]?(180(\\.0{1,6})?|((1[0-7]\\d)|([1-9]?\\d))(\\.\\d{1,6})?)$/",
    "regexpmessage": "Geo code has to be a valid lat long upto resolution of 6 decimals"
}', 25);