UPDATE ui.dashboardqueryparameters SET
validation =  E'{
  "pattern": "^[a-zA-Z0-9 ,~_@#%''/\\\\\\\\&.-]*$",
  "errorMessage": "Search Value can only contain alphabets, numbers, hyphen (-), comma (,), underscore (_), at (@), space, asterisk (*), hash (#), percentage (%), single quotation (''), forward and backward slash (/ , \\\\), ampersand (&), tilde (~) and dot (.)" 
}'::jsonb WHERE
idashboardparameterid = 296;

UPDATE ui.dashboardqueryparameters SET
validation =  E'{
  "pattern": "^[a-zA-Z0-9 ,_@#%''/\\\\\\\\&.-]$",
  "errorMessage": "Unique ID can only contain alphabets, numbers, hyphen (-), comma (,), underscore (_), at (@), space, asterisk (*), hash (#), percentage (%), single quotation (''), forward and backward slash (/ , \\\\), ampersand (&) and dot (.)" 
}'::jsonb WHERE
idashboardparameterid = 120;

UPDATE ui.dashboardqueryparameters SET
validation =  E'{
  "pattern": "^[a-zA-Z0-9 ,_@#%''/\\\\\\\\&.-]$",
  "errorMessage": "Address can only contain alphabets, numbers, hyphen (-), comma (,), underscore (_), at (@), space, asterisk (*), hash (#), percentage (%), single quotation (''), forward and backward slash (/ , \\\\), ampersand (&) and dot (.)" 
}'::jsonb WHERE
 idashboardparameterid IN (203, 124, 109);
