--Data Analyzer, Party Dashboard, Transaction Profile - Address:
UPDATE ui.dashboardqueryparameters 
SET validation = E'{
  "pattern": "^[a-zA-Z0-9 ,_@*#%''/\\\\\\\\&.\\\\-()+~!=:\\\\$`\\\\?\\"}]*$",
  "errorMessage": "Address can only contain alphabets, numbers, hyphen (-), comma (,), underscore (_), at (@), space, asterisk (*), hash (#), percentage (%), single quotation (''), forward and backward slash (/ , \\\\), ampersand (&), dot (.), parentheses (( )), plus (+), tilde (~), exclamation (!), equals (=), colon (:), dollar ($), backtick (`), question mark (?), double quote (\\") and right curly brace (})"
}'::jsonb
WHERE idashboardparameterid IN (203, 124, 109);



--Graph Analyzer - Search Value:
UPDATE ui.dashboardqueryparameters SET
validation =  E'{
  "pattern": "^[a-zA-Z0-9 ,~_@#%*''/\\\\\\\\&.:-]*$",
  "errorMessage": "Search Value can only contain alphabets, numbers, hyphen (-), comma (,), underscore (_), at (@), space, asterisk (*), hash (#), percentage (%), single quotation (''), forward and backward slash (/ , \\\\), ampersand (&), tilde (~), colon (:) and dot (.)"
}
'::jsonb WHERE
idashboardparameterid = 296





--Transaction Profile - Unique ID:
UPDATE ui.dashboardqueryparameters SET
validation =  E'{
  "pattern": "^[a-zA-Z0-9 ,_@*#%''/\\\\\\\\&.+:~ -]*$",
  "errorMessage": "Unique ID can only contain alphabets, numbers, hyphen (-), comma (,), underscore (_), at (@), space, asterisk (*), hash (#), percentage (%), single quotation (''), forward and backward slash (/ , \\\\), ampersand (&), dot (.), tilde (~), colon (:) and plus sign (+)"
}'::jsonb WHERE
idashboardparameterid = 120;