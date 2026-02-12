

--ui.dashboardfilters

ALTER TABLE IF EXISTS ui.dashboardfilters
    ADD COLUMN validation jsonb;

UPDATE ui.dashboardfilters SET
validation =  E'{
  "pattern": "^[a-zA-Z0-9 ,_@*#%''/\\\\\\\\&.-]*$",
  "errorMessage": "Invalid Address. Contains unsupported characters." 
}'::jsonb WHERE
idashboardid = 17 AND vcdashboardfilterdisplayname ='Address';

UPDATE ui.dashboardfilters SET
validation =  E'{
  "pattern": "^[a-zA-Z0-9 ,_@*#%''/\\\\\\\\&.-]*$",
  "errorMessage": "Invalid Address. Contains unsupported characters." 
}'::jsonb WHERE
idashboardid = 11 AND vcdashboardfilterdisplayname ='Address';

UPDATE ui.dashboardfilters SET
validation =  E'{
  "pattern": "^[a-zA-Z0-9 ,_@*#%''/\\\\\\\\&.-]*$",
  "errorMessage": "Invalid Address. Contains unsupported characters." 
}'::jsonb WHERE
idashboardid = 21 AND vcdashboardfilterdisplayname ='Address';

UPDATE ui.dashboardfilters SET
validation =  E'{
  "pattern": "^[a-zA-Z0-9 ,_@*#%''/\\\\\\\\&.-]*$",
  "errorMessage": "Invalid Search Value. Contains unsupported characters." 
}'::jsonb WHERE
idashboardid = 71 AND vcdashboardfilterdisplayname ='Search Value';

UPDATE ui.dashboardfilters SET
validation =  E'{
  "pattern": "^[a-zA-Z0-9 ,_@*#%''/\\\\\\\\&.-]*$",
  "errorMessage": "Invalid Search Value. Contains unsupported characters." 
}'::jsonb WHERE
idashboardid = 59 AND vcdashboardfilterdisplayname ='Search Value';


----
ALTER TABLE IF EXISTS ui.dashboardqueryparameters
    ADD COLUMN validation jsonb;


UPDATE ui.dashboardqueryparameters SET
validation =  E'{
  "pattern": "^[a-zA-Z0-9 ,_@*#%''/\\\\\\\\&.-]*$",
  "errorMessage": "Address can only contain alphabets, numbers, hyphen (-), comma (,), underscore (_), at (@), space, asterisk (*), hash (#), percentage (%), single quotation (''), forward and backward slash (/ , \\\\), ampersand (&) and dot (.)" 
}'::jsonb WHERE
idashboardqueryid = 100 AND vcparametername='VpaAddress';

UPDATE ui.dashboardqueryparameters SET
validation =  E'{
  "pattern": "^[a-zA-Z0-9 ,_@*#%''/\\\\\\\\&.-]*$",
  "errorMessage": "Address can only contain alphabets, numbers, hyphen (-), comma (,), underscore (_), at (@), space, asterisk (*), hash (#), percentage (%), single quotation (''), forward and backward slash (/ , \\\\), ampersand (&) and dot (.)" 
}'::jsonb WHERE
idashboardqueryid = 69 AND vcparametername='useraddress';

UPDATE ui.dashboardqueryparameters SET
validation =  E'{
  "pattern": "^[a-zA-Z0-9 ,_@*#%''/\\\\\\\\&.-]*$",
  "errorMessage": "Address can only contain alphabets, numbers, hyphen (-), comma (,), underscore (_), at (@), space, asterisk (*), hash (#), percentage (%), single quotation (''), forward and backward slash (/ , \\\\), ampersand (&) and dot (.)" 
}'::jsonb WHERE
idashboardqueryid = 77 AND vcparametername='vpaAddress';

UPDATE ui.dashboardqueryparameters SET
validation =  E'{
  "pattern": "^[a-zA-Z0-9 ,_@*#%''/\\\\\\\\&.-]*$",
  "errorMessage": "Unique ID can only contain alphabets, numbers, hyphen (-), comma (,), underscore (_), at (@), space, asterisk (*), hash (#), percentage (%), single quotation (''), forward and backward slash (/ , \\\\), ampersand (&) and dot (.)" 
}'::jsonb WHERE
idashboardqueryid = 77 AND vcparametername='msgid';

UPDATE ui.dashboardqueryparameters SET
validation =  E'{
  "pattern": "^[a-zA-Z0-9 ,_@*#%''/\\\\\\\\&.-]*$",
  "errorMessage": "Address can only contain alphabets, numbers, hyphen (-), comma (,), underscore (_), at (@), space, asterisk (*), hash (#), percentage (%), single quotation (''), forward and backward slash (/ , \\\\), ampersand (&) and dot (.)" 
}'::jsonb WHERE
idashboardqueryid = 65 AND vcparametername='Address';

UPDATE ui.dashboardqueryparameters SET
validation =  E'{
  "pattern": "^[a-zA-Z0-9 ,_@*#%''/\\\\\\\\&.-]*$",
  "errorMessage": "Search Value can only contain alphabets, numbers, hyphen (-), comma (,), underscore (_), at (@), space, asterisk (*), hash (#), percentage (%), single quotation (''), forward and backward slash (/ , \\\\), ampersand (&) and dot (.)" 
}'::jsonb WHERE
idashboardqueryid = 120 AND vcparametername='VpaAddress';

UPDATE ui.dashboardqueryparameters SET
validation =  E'{
  "pattern": "^[a-zA-Z0-9 ,_@*#%''/\\\\\\\\&.-]*$",
  "errorMessage": "Search Value can only contain alphabets, numbers, hyphen (-), comma (,), underscore (_), at (@), space, asterisk (*), hash (#), percentage (%), single quotation (''), forward and backward slash (/ , \\\\), ampersand (&) and dot (.)" 
}'::jsonb WHERE
idashboardqueryid = 148 AND vcparametername='VpaAddress';

UPDATE ui.dashboardqueryparameters SET
validation =  E'{
  "pattern": "^[a-zA-Z0-9 ,_@*#%''/\\\\\\\\&.-]*$",
  "errorMessage": "Address can only contain alphabets, numbers, hyphen (-), comma (,), underscore (_), at (@), space, asterisk (*), hash (#), percentage (%), single quotation (''), forward and backward slash (/ , \\\\), ampersand (&) and dot (.)" 
}'::jsonb WHERE
idashboardqueryid = 57 AND vcparametername='VpaAddress';