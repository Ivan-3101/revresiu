
UPDATE ui.validationfieldslist SET
vcvalidation = '{
    "regexp": "/^[a-zA-Z]{2,3}$/",
    "maxLength": 3,
    "minLength": 2
 }'::character varying WHERE
itenantid in (6,7,20,24) and vcinternalfield='country';