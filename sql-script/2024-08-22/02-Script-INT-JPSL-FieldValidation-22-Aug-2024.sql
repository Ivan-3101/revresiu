UPDATE ui.validationfieldslist SET
vcvalidation = '{
    "regexp": "/^[1-9]\\d{9}$/",
    "regexpmessage": "Mobile number has to be a valid number with 10 digits",
    "maxLength": 10
}
'::character varying WHERE
itenantid = 14 and vcfielddisplayname like '%Mobile%';
