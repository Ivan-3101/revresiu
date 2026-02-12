UPDATE ui.dashboardfilters SET
validation =  E'{
  "pattern": "^[a-zA-Z0-9 ,_@#%''/\\\\\\\\&.-]*$",
  "errorMessage": "Invalid Search Value. Contains unsupported characters."
}'::jsonb 
where vcdashboardfilterdisplayname = 'Search Value';



UPDATE ui.dashboardqueryparameters SET
validation =  E'{
  "pattern": "^[a-zA-Z0-9 ,_@#%''/\\\\\\\\&.-]*$",
  "errorMessage": "Search Value can only contain alphabets, numbers, hyphen (-), comma (,), underscore (_), at (@), space, asterisk (*), hash (#), percentage (%), single quotation (''), forward and backward slash (/ , \\\\), ampersand (&), tilde (~) and dot (.)"
}'::jsonb WHERE
idashboardqueryid in (120, 148) and vcparametername = 'VpaAddress';

