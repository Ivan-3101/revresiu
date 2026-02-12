
    UPDATE ui.rolemenuaccessmap 
SET badd = false, 
    bapprove = false, 
    bdelete = false, 
    bedit = false, 
    bpublish = false, 
    bview = true, 
    istatus = false
WHERE imenuid = (SELECT imenuid FROM ui.menustructuredesc WHERE vcaction = 'Analytics') 
AND iroleid = '13'::integer 
AND itenantid = '14'::integer 
AND iorgid = '10'::integer;

UPDATE ui.rolemenuaccessmap 
SET badd = false, 
    bapprove = false, 
    bdelete = false, 
    bedit = false, 
    bpublish = false, 
    bview = true, 
    istatus = false
WHERE imenuid = (SELECT imenuid FROM ui.menustructuredesc WHERE vcaction = 'TransactionDB') 
AND iroleid = '13'::integer 
AND itenantid = '14'::integer 
AND iorgid = '10'::integer;

UPDATE ui.rolemenuaccessmap 
SET badd = false, 
    bapprove = false, 
    bdelete = false, 
    bedit = false, 
    bpublish = false, 
    bview = true, 
    istatus = false
WHERE imenuid = (SELECT imenuid FROM ui.menustructuredesc WHERE vcaction = 'PartyDashboard') 
AND iroleid = '13'::integer 
AND itenantid = '14'::integer 
AND iorgid = '10'::integer;

UPDATE ui.rolemenuaccessmap 
SET badd = false, 
    bapprove = false, 
    bdelete = false, 
    bedit = false, 
    bpublish = false, 
    bview = true, 
    istatus = false
WHERE imenuid = (SELECT imenuid FROM ui.menustructuredesc WHERE vcaction = 'TransactionProfile') 
AND iroleid = '13'::integer 
AND itenantid = '14'::integer 
AND iorgid = '10'::integer;

UPDATE ui.rolemenuaccessmap 
SET badd = false, 
    bapprove = false, 
    bdelete = false, 
    bedit = false, 
    bpublish = false, 
    bview = true, 
    istatus = false
WHERE imenuid = (SELECT imenuid FROM ui.menustructuredesc WHERE vcaction = 'DataAnalyzer') 
AND iroleid = '13'::integer 
AND itenantid = '14'::integer 
AND iorgid = '10'::integer;


DELETE FROM ui.rolemenuaccessmap 
WHERE imenuid = (SELECT imenuid FROM ui.menustructuredesc WHERE vcaction = 'try out') 
AND iroleid = '13'::integer 
AND itenantid = '14'::integer 
AND iorgid = '10'::integer;

DELETE FROM ui.rolemenuaccessmap 
WHERE imenuid = (SELECT imenuid FROM ui.menustructuredesc WHERE vcaction = 'RunSimulation') 
AND iroleid = '13'::integer 
AND itenantid = '14'::integer 
AND iorgid = '10'::integer;

DELETE FROM ui.rolemenuaccessmap 
WHERE imenuid = (SELECT imenuid FROM ui.menustructuredesc WHERE vcaction = 'AnalyzeSimulation') 
AND iroleid = '13'::integer 
AND itenantid = '14'::integer 
AND iorgid = '10'::integer;

DELETE FROM ui.rolemenuaccessmap 
WHERE imenuid = (SELECT imenuid FROM ui.menustructuredesc WHERE vcaction = 'RuleBuilder') 
AND iroleid = '13'::integer 
AND itenantid = '14'::integer 
AND iorgid = '10'::integer;



UPDATE ui.rolemenuaccessmap 
SET badd = false, 
    bapprove = false, 
    bdelete = false, 
    bedit = false, 
    bpublish = false, 
    bview = true, 
    istatus = false
WHERE imenuid = (SELECT imenuid FROM ui.menustructuredesc WHERE vcaction = 'Case') 
AND iroleid = '16'::integer 
AND itenantid = '14'::integer 
AND iorgid = '10'::integer;

UPDATE ui.rolemenuaccessmap 
SET badd = false, 
    bapprove = false, 
    bdelete = false, 
    bedit = false, 
    bpublish = false, 
    bview = true, 
    istatus = false
WHERE imenuid = (SELECT imenuid FROM ui.menustructuredesc WHERE vcaction = 'Tasks') 
AND iroleid = '16'::integer 
AND itenantid = '14'::integer 
AND iorgid = '10'::integer;

UPDATE ui.rolemenuaccessmap 
SET badd = false, 
    bapprove = false, 
    bdelete = false, 
    bedit = false, 
    bpublish = false, 
    bview = true, 
    istatus = false
WHERE imenuid = (SELECT imenuid FROM ui.menustructuredesc WHERE vcaction = 'CreateManualTicket') 
AND iroleid = '16'::integer 
AND itenantid = '14'::integer 
AND iorgid = '10'::integer;

UPDATE ui.rolemenuaccessmap 
SET badd = false, 
    bapprove = false, 
    bdelete = false, 
    bedit = false, 
    bpublish = false, 
    bview = true, 
    istatus = false
WHERE imenuid = (SELECT imenuid FROM ui.menustructuredesc WHERE vcaction = 'ProcessBulkTickets') 
AND iroleid = '16'::integer 
AND itenantid = '14'::integer 
AND iorgid = '10'::integer;

UPDATE ui.rolemenuaccessmap 
SET badd = false, 
    bapprove = false, 
    bdelete = false, 
    bedit = false, 
    bpublish = false, 
    bview = true, 
    istatus = false
WHERE imenuid = (SELECT imenuid FROM ui.menustructuredesc WHERE vcaction = 'CaseSummary') 
AND iroleid = '16'::integer 
AND itenantid = '14'::integer 
AND iorgid = '10'::integer;

UPDATE ui.rolemenuaccessmap 
SET badd = false, 
    bapprove = false, 
    bdelete = false, 
    bedit = false, 
    bpublish = false, 
    bview = true, 
    istatus = false
WHERE imenuid = (SELECT imenuid FROM ui.menustructuredesc WHERE vcaction = 'Reports') 
AND iroleid = '16'::integer 
AND itenantid = '14'::integer 
AND iorgid = '10'::integer;

UPDATE ui.rolemenuaccessmap 
SET badd = false, 
    bapprove = false, 
    bdelete = false, 
    bedit = false, 
    bpublish = false, 
    bview = true, 
    istatus = false
WHERE imenuid = (SELECT imenuid FROM ui.menustructuredesc WHERE vcaction = 'AutoAllocationUserMapping') 
AND iroleid = '16'::integer 
AND itenantid = '14'::integer 
AND iorgid = '10'::integer;
