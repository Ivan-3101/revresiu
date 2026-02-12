UPDATE ui.dashboardquery SET
vcdashboardquery =  E'{
    "masters.customers": "SELECT X.* FROM   (SELECT vccolumnname, vcpath FROM ui.metadata WHERE vcprefix = ''[{\\"Path\\": \\"\\"}]'' AND bui = true and vcroot =''customer'' and itenantid=:tenantid and irecordstatus=0) AS X (\\"label\\", \\"value\\")",

    "masters.accounts": "SELECT X.* FROM   (SELECT vccolumnname, vcpath FROM ui.metadata WHERE vcprefix = ''[{\\"Path\\": \\"\\"}]'' AND bui = true and vcroot =''account'' and itenantid=:tenantid and irecordstatus=0) AS X (\\"label\\", \\"value\\")",

    "masters.vpa": "SELECT X.* FROM   (SELECT vccolumnname, vcpath FROM ui.metadata WHERE vcprefix = ''[{\\"Path\\": \\"\\"}]'' AND bui = true and vcroot =''vpa'' and itenantid=:tenantid and irecordstatus=0) AS X (\\"label\\", \\"value\\")"
}'::text WHERE
idashboardqueryid = 119;

UPDATE ui.dashboardquery SET
vcdashboardquery =  E'{
   "masters.customers": "SELECT X.* FROM   (SELECT vccolumnname, vcpath FROM ui.metadata WHERE vcprefix = ''[{\\"Path\\": \\"\\"}]''  AND bui = true and vcroot =''customer'' and itenantid=:tenantid and irecordstatus=0) AS X (\\"label\\", \\"value\\") WHERE X.value != :SearchField",

    "masters.accounts": "SELECT X.* FROM   (SELECT vccolumnname, vcpath FROM ui.metadata WHERE vcprefix = ''[{\\"Path\\": \\"\\"}]''  AND bui = true and vcroot =''account'' and itenantid=:tenantid and irecordstatus=0) AS X (\\"label\\", \\"value\\") WHERE X.value != :SearchField",

    "masters.vpa": "SELECT X.* FROM   (SELECT vccolumnname, vcpath FROM ui.metadata WHERE vcprefix = ''[{\\"Path\\": \\"\\"}]''  AND bui = true and vcroot =''vpa'' and itenantid=:tenantid and irecordstatus=0) AS X (\\"label\\", \\"value\\") WHERE X.value != :SearchField"
}
'::text WHERE
idashboardqueryid = 151;


UPDATE ui.dashboardquery SET
vcdashboardquery =  E'{ 
  "analytics.trans":"SELECT X.* FROM  (SELECT vccolumnname, vcpath FROM ui.metadata WHERE vcprefix = ''[{\\"Path\\": \\"\\"}]'' AND bui = true and vcroot =''trans'' and itenantid=:tenantid and irecordstatus=0)  AS X (\\"label\\", \\"value\\") where value != :SearchField"
}'::text WHERE
idashboardqueryid = 152;

UPDATE ui.dashboardquery SET
vcdashboardquery = 'SELECT X.* FROM  (SELECT vccolumnname , vcpath FROM ui.metadata WHERE vcprefix = ''[{"Path": ""}]'' AND bui = true and vcroot =''trans'' and itenantid=:tenantid and irecordstatus=0 ) AS X ("label", "value")
'::text WHERE
idashboardqueryid = 149;

