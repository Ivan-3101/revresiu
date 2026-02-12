---2

UPDATE ui.rolemenuaccessmap
SET badd = true
WHERE imenuid = (SELECT imenuid FROM ui.menustructuredesc WHERE vcaction = 'Admin')
AND iroleid = 14
AND itenantid IN (14)
AND iorgid = 10;


UPDATE ui.rolemenuaccessmap
SET badd = true
WHERE imenuid = (SELECT imenuid FROM ui.menustructuredesc WHERE vcaction = 'userManagement')
AND iroleid = 14
AND itenantid IN (14)
AND iorgid = 10;


UPDATE ui.rolemenuaccessmap
SET badd = true
WHERE imenuid = (SELECT imenuid FROM ui.menustructuredesc WHERE vcaction = 'EmailScheduler')
AND iroleid = 14
AND itenantid IN (14)
AND iorgid = 10;


UPDATE ui.rolemenuaccessmap
SET badd = true
WHERE imenuid = (SELECT imenuid FROM ui.menustructuredesc WHERE vcaction = 'FileUpload')
AND iroleid = 14
AND itenantid IN (14)
AND iorgid = 10;


UPDATE ui.rolemenuaccessmap
SET badd = true
WHERE imenuid = (SELECT imenuid FROM ui.menustructuredesc WHERE vcaction = 'AdminReports')
AND iroleid = 14
AND itenantid IN (14)
AND iorgid = 10;


---4

UPDATE ui.rolemenuaccessmap
SET badd = true, bdelete = true, bedit = true
WHERE imenuid = (SELECT imenuid FROM ui.menustructuredesc WHERE vcaction = 'List')
AND iroleid = 13
AND itenantid IN (14)
AND iorgid = 10;

UPDATE ui.rolemenuaccessmap
SET badd = true, bdelete = true, bedit = true
WHERE imenuid = (SELECT imenuid FROM ui.menustructuredesc WHERE vcaction = 'Edit List')
AND iroleid = 13
AND itenantid IN (14)
AND iorgid = 10;


---10

-- Update for 'Analytics' action
UPDATE ui.rolemenuaccessmap
SET badd = false, bdelete = false, bedit = false
WHERE imenuid = (SELECT imenuid FROM ui.menustructuredesc WHERE vcaction = 'Analytics')
AND iroleid = 16
AND itenantid IN (14)
AND iorgid = 10;

-- Update for 'TransactionDB' action
UPDATE ui.rolemenuaccessmap
SET badd = false, bdelete = false, bedit = false
WHERE imenuid = (SELECT imenuid FROM ui.menustructuredesc WHERE vcaction = 'TransactionDB')
AND iroleid = 16
AND itenantid IN (14)
AND iorgid = 10;

-- Update for 'PartyDashboard' action
UPDATE ui.rolemenuaccessmap
SET badd = false, bdelete = false, bedit = false
WHERE imenuid = (SELECT imenuid FROM ui.menustructuredesc WHERE vcaction = 'PartyDashboard')
AND iroleid = 16
AND itenantid IN (14)
AND iorgid = 10;

-- Update for 'TransactionProfile' action
UPDATE ui.rolemenuaccessmap
SET badd = false, bdelete = false, bedit = false
WHERE imenuid = (SELECT imenuid FROM ui.menustructuredesc WHERE vcaction = 'TransactionProfile')
AND iroleid = 16
AND itenantid IN (14)
AND iorgid = 10;

-- Update for 'DataAnalyzer' action
UPDATE ui.rolemenuaccessmap
SET badd = false, bdelete = false, bedit = false
WHERE imenuid = (SELECT imenuid FROM ui.menustructuredesc WHERE vcaction = 'DataAnalyzer')
AND iroleid = 16
AND itenantid IN (14)
AND iorgid = 10;



--createmanualticket
UPDATE ui.rolemenuaccessmap
SET badd = true
WHERE imenuid = (SELECT imenuid FROM ui.menustructuredesc WHERE vcaction = 'CreateManualTicket')
AND iroleid = 13
AND itenantid IN (14)
AND iorgid = 10;

UPDATE ui.rolemenuaccessmap
SET badd = true
WHERE imenuid = (SELECT imenuid FROM ui.menustructuredesc WHERE vcaction = 'CreateManualTicket')
AND iroleid = 14
AND itenantid IN (14)
AND iorgid = 10;

UPDATE ui.rolemenuaccessmap
SET badd = true
WHERE imenuid = (SELECT imenuid FROM ui.menustructuredesc WHERE vcaction = 'CreateManualTicket')
AND iroleid = 16
AND itenantid IN (14)
AND iorgid = 10;


---add user--risk supervisor
INSERT INTO ui.rolemenuaccessmap (
irolemenumapid, badd, bapprove, bdelete, bedit, bpublish, bview, istatus, imenuid, iroleid, itenantid, iorgid) VALUES (
( select max(irolemenumapid) + 1 from ui.rolemenuaccessmap )::integer, true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, 
( select imenuid from ui.menustructuredesc where  vcaction ='Add User')::integer, '14'::integer, '14'::integer, '10'::integer)
 returning irolemenumapid,itenantid;


  INSERT INTO ui.rolemenuaccessmap (
irolemenumapid, badd, bapprove, bdelete, bedit, bpublish, bview, istatus, imenuid, iroleid, itenantid, iorgid) VALUES (
( select max(irolemenumapid) + 1 from ui.rolemenuaccessmap )::integer, true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, 
( select imenuid from ui.menustructuredesc where  vcaction ='Edit User')::integer, '14'::integer, '14'::integer, '10'::integer)
 returning irolemenumapid,itenantid;


 --approve user--uam
 INSERT INTO ui.rolemenuaccessmap (
irolemenumapid, badd, bapprove, bdelete, bedit, bpublish, bview, istatus, imenuid, iroleid, itenantid, iorgid) VALUES (
( select max(irolemenumapid) + 1 from ui.rolemenuaccessmap )::integer, true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, 
( select imenuid from ui.menustructuredesc where  vcaction ='Approve Edit User')::integer, '16'::integer, '14'::integer, '10'::integer)
 returning irolemenumapid,itenantid;


 INSERT INTO ui.rolemenuaccessmap (
irolemenumapid, badd, bapprove, bdelete, bedit, bpublish, bview, istatus, imenuid, iroleid, itenantid, iorgid) VALUES (
( select max(irolemenumapid) + 1 from ui.rolemenuaccessmap )::integer, true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, 
( select imenuid from ui.menustructuredesc where  vcaction ='Edit User')::integer, '16'::integer, '14'::integer, '10'::integer)
 returning irolemenumapid,itenantid;
