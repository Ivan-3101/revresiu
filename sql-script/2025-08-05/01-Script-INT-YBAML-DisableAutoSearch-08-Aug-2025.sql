UPDATE ui.orgs SET attribs = jsonb_set(attribs, '{dashboardAutoSearch}', '{}'::jsonb, true) WHERE iorgid = 5;
UPDATE ui.orgs SET attribs = jsonb_set(attribs, '{dashboardAutoSearch, dataAnalyzer}', 'false'::jsonb, true) WHERE iorgid = 5;
UPDATE ui.orgs SET attribs = jsonb_set(attribs, '{dashboardAutoSearch, adminReports}', 'false'::jsonb, true) WHERE iorgid = 5;
UPDATE ui.orgs SET attribs = jsonb_set(attribs, '{dashboardAutoSearch, caseManagementReport}', 'false'::jsonb, true) WHERE iorgid = 5;
UPDATE ui.orgs SET attribs = jsonb_set(attribs, '{dashboardAutoSearch, transactionProfile}', 'false'::jsonb, true) WHERE iorgid = 5;
UPDATE ui.orgs SET attribs = jsonb_set(attribs, '{dashboardAutoSearch, partyDashboard}', 'false'::jsonb, true) WHERE iorgid = 5;