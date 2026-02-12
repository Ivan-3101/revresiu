----jpsl user access----
 INSERT INTO ui.roledesc(
iroleid, dtapproverstamp, dtentrystamp, vcrolename, iapproveruserid, ientryuserid, istatus, imenustructuredesc, itenantid, iorgid)
VALUES (13,null, CURRENT_TIMESTAMP,'Risk Analyst' ,null ,null ,1 ,null ,14 ,10 );

INSERT INTO ui.roledesc(
iroleid, dtapproverstamp, dtentrystamp, vcrolename, iapproveruserid, ientryuserid, istatus, imenustructuredesc, itenantid, iorgid)
VALUES (14,null, CURRENT_TIMESTAMP,'Risk Supervisor' ,null ,null ,1 ,null ,14 ,10 );

INSERT INTO ui.roledesc(
iroleid, dtapproverstamp, dtentrystamp, vcrolename, iapproveruserid, ientryuserid, istatus, imenustructuredesc, itenantid, iorgid)
VALUES (15,null, CURRENT_TIMESTAMP,'Operation Analyst' ,null ,null ,1 ,null ,14 ,10 );

INSERT INTO ui.roledesc(
iroleid, dtapproverstamp, dtentrystamp, vcrolename, iapproveruserid, ientryuserid, istatus, imenustructuredesc, itenantid, iorgid)
VALUES (16,null, CURRENT_TIMESTAMP,'User Access Manager - Checker' ,null ,null ,1 ,null ,14 ,10 );



---risk analyst

INSERT INTO ui.rolemenuaccessmap (
irolemenumapid, badd, bapprove, bdelete, bedit, bpublish, bview, istatus, imenuid, iroleid, itenantid, iorgid) VALUES (
( select max(irolemenumapid) + 1 from ui.rolemenuaccessmap )::integer, true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, 
( select imenuid from ui.menustructuredesc where  vcaction ='Analytics')::integer, '13'::integer, '14'::integer, '10'::integer)
 returning irolemenumapid,itenantid;

INSERT INTO ui.rolemenuaccessmap (
irolemenumapid, badd, bapprove, bdelete, bedit, bpublish, bview, istatus, imenuid, iroleid, itenantid, iorgid) VALUES (
( select max(irolemenumapid) + 1 from ui.rolemenuaccessmap )::integer, true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, 
( select imenuid from ui.menustructuredesc where  vcaction ='TransactionDB')::integer, '13'::integer, '14'::integer, '10'::integer)
 returning irolemenumapid,itenantid;

INSERT INTO ui.rolemenuaccessmap (
irolemenumapid, badd, bapprove, bdelete, bedit, bpublish, bview, istatus, imenuid, iroleid, itenantid, iorgid) VALUES (
( select max(irolemenumapid) + 1 from ui.rolemenuaccessmap )::integer, true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, 
( select imenuid from ui.menustructuredesc where  vcaction ='PartyDashboard')::integer, '13'::integer, '14'::integer, '10'::integer)
 returning irolemenumapid,itenantid;

INSERT INTO ui.rolemenuaccessmap (
irolemenumapid, badd, bapprove, bdelete, bedit, bpublish, bview, istatus, imenuid, iroleid, itenantid, iorgid) VALUES (
( select max(irolemenumapid) + 1 from ui.rolemenuaccessmap )::integer, true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, 
( select imenuid from ui.menustructuredesc where  vcaction ='TransactionProfile')::integer, '13'::integer, '14'::integer, '10'::integer)
 returning irolemenumapid,itenantid;

INSERT INTO ui.rolemenuaccessmap (
irolemenumapid, badd, bapprove, bdelete, bedit, bpublish, bview, istatus, imenuid, iroleid, itenantid, iorgid) VALUES (
( select max(irolemenumapid) + 1 from ui.rolemenuaccessmap )::integer, true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, 
( select imenuid from ui.menustructuredesc where  vcaction ='DataAnalyzer')::integer, '13'::integer, '14'::integer, '10'::integer)
 returning irolemenumapid,itenantid;


INSERT INTO ui.rolemenuaccessmap (
irolemenumapid, badd, bapprove, bdelete, bedit, bpublish, bview, istatus, imenuid, iroleid, itenantid, iorgid) VALUES (
( select max(irolemenumapid) + 1 from ui.rolemenuaccessmap )::integer, false::boolean, false::boolean, false::boolean, true::boolean, true::boolean, true::boolean, true::boolean, 
( select imenuid from ui.menustructuredesc where  vcaction ='Case')::integer, '13'::integer, '14'::integer, '10'::integer)
 returning irolemenumapid,itenantid;

INSERT INTO ui.rolemenuaccessmap (
irolemenumapid, badd, bapprove, bdelete, bedit, bpublish, bview, istatus, imenuid, iroleid, itenantid, iorgid) VALUES (
( select max(irolemenumapid) + 1 from ui.rolemenuaccessmap )::integer, false::boolean, false::boolean, false::boolean, true::boolean, true::boolean, true::boolean, true::boolean, 
( select imenuid from ui.menustructuredesc where  vcaction ='Tasks')::integer, '13'::integer, '14'::integer, '10'::integer)
 returning irolemenumapid,itenantid;

INSERT INTO ui.rolemenuaccessmap (
irolemenumapid, badd, bapprove, bdelete, bedit, bpublish, bview, istatus, imenuid, iroleid, itenantid, iorgid) VALUES (
( select max(irolemenumapid) + 1 from ui.rolemenuaccessmap )::integer, false::boolean, false::boolean, false::boolean, true::boolean, true::boolean, true::boolean, true::boolean, 
( select imenuid from ui.menustructuredesc where  vcaction ='CreateManualTicket')::integer, '13'::integer, '14'::integer, '10'::integer)
 returning irolemenumapid,itenantid;

INSERT INTO ui.rolemenuaccessmap (
irolemenumapid, badd, bapprove, bdelete, bedit, bpublish, bview, istatus, imenuid, iroleid, itenantid, iorgid) VALUES (
( select max(irolemenumapid) + 1 from ui.rolemenuaccessmap )::integer, false::boolean, false::boolean, false::boolean, true::boolean, true::boolean, true::boolean, true::boolean, 
( select imenuid from ui.menustructuredesc where  vcaction ='ProcessBulkTickets')::integer, '13'::integer, '14'::integer, '10'::integer)
 returning irolemenumapid,itenantid;

INSERT INTO ui.rolemenuaccessmap (
irolemenumapid, badd, bapprove, bdelete, bedit, bpublish, bview, istatus, imenuid, iroleid, itenantid, iorgid) VALUES (
( select max(irolemenumapid) + 1 from ui.rolemenuaccessmap )::integer, false::boolean, false::boolean, false::boolean, true::boolean, true::boolean, true::boolean, true::boolean, 
( select imenuid from ui.menustructuredesc where  vcaction ='CaseSummary')::integer, '13'::integer, '14'::integer, '10'::integer)
 returning irolemenumapid,itenantid;

INSERT INTO ui.rolemenuaccessmap (
irolemenumapid, badd, bapprove, bdelete, bedit, bpublish, bview, istatus, imenuid, iroleid, itenantid, iorgid) VALUES (
( select max(irolemenumapid) + 1 from ui.rolemenuaccessmap )::integer, false::boolean, false::boolean, false::boolean, true::boolean, true::boolean, true::boolean, true::boolean, 
( select imenuid from ui.menustructuredesc where  vcaction ='Reports')::integer, '13'::integer, '14'::integer, '10'::integer)
 returning irolemenumapid,itenantid;

INSERT INTO ui.rolemenuaccessmap (
irolemenumapid, badd, bapprove, bdelete, bedit, bpublish, bview, istatus, imenuid, iroleid, itenantid, iorgid) VALUES (
( select max(irolemenumapid) + 1 from ui.rolemenuaccessmap )::integer, false::boolean, false::boolean, false::boolean, true::boolean, true::boolean, true::boolean, true::boolean, 
( select imenuid from ui.menustructuredesc where  vcaction ='AutoAllocationUserMapping')::integer, '13'::integer, '14'::integer, '10'::integer)
 returning irolemenumapid,itenantid;


INSERT INTO ui.rolemenuaccessmap (
irolemenumapid, badd, bapprove, bdelete, bedit, bpublish, bview, istatus, imenuid, iroleid, itenantid, iorgid) VALUES (
( select max(irolemenumapid) + 1 from ui.rolemenuaccessmap )::integer, false::boolean, false::boolean, false::boolean, false::boolean, true::boolean, true::boolean, true::boolean, 
( select imenuid from ui.menustructuredesc where  vcaction ='try out')::integer, '13'::integer, '14'::integer, '10'::integer)
 returning irolemenumapid,itenantid;

INSERT INTO ui.rolemenuaccessmap (
irolemenumapid, badd, bapprove, bdelete, bedit, bpublish, bview, istatus, imenuid, iroleid, itenantid, iorgid) VALUES (
( select max(irolemenumapid) + 1 from ui.rolemenuaccessmap )::integer, false::boolean, false::boolean, false::boolean, false::boolean, true::boolean, true::boolean, true::boolean, 
( select imenuid from ui.menustructuredesc where  vcaction ='RunSimulation')::integer, '13'::integer, '14'::integer, '10'::integer)
 returning irolemenumapid,itenantid;

INSERT INTO ui.rolemenuaccessmap (
irolemenumapid, badd, bapprove, bdelete, bedit, bpublish, bview, istatus, imenuid, iroleid, itenantid, iorgid) VALUES (
( select max(irolemenumapid) + 1 from ui.rolemenuaccessmap )::integer, false::boolean, false::boolean, false::boolean, false::boolean, true::boolean, true::boolean, true::boolean, 
( select imenuid from ui.menustructuredesc where  vcaction ='AnalyzeSimulation')::integer, '13'::integer, '14'::integer, '10'::integer)
 returning irolemenumapid,itenantid;

INSERT INTO ui.rolemenuaccessmap (
irolemenumapid, badd, bapprove, bdelete, bedit, bpublish, bview, istatus, imenuid, iroleid, itenantid, iorgid) VALUES (
( select max(irolemenumapid) + 1 from ui.rolemenuaccessmap )::integer, false::boolean, false::boolean, false::boolean, false::boolean, true::boolean, true::boolean, true::boolean, 
( select imenuid from ui.menustructuredesc where  vcaction ='RuleBuilder')::integer, '13'::integer, '14'::integer, '10'::integer)
 returning irolemenumapid,itenantid;


INSERT INTO ui.rolemenuaccessmap (
irolemenumapid, badd, bapprove, bdelete, bedit, bpublish, bview, istatus, imenuid, iroleid, itenantid, iorgid) VALUES (
( select max(irolemenumapid) + 1 from ui.rolemenuaccessmap )::integer, false::boolean, false::boolean, false::boolean, false::boolean, true::boolean, true::boolean, true::boolean, 
( select imenuid from ui.menustructuredesc where  vcaction ='Admin')::integer, '13'::integer, '14'::integer, '10'::integer)
 returning irolemenumapid,itenantid;

INSERT INTO ui.rolemenuaccessmap (
irolemenumapid, badd, bapprove, bdelete, bedit, bpublish, bview, istatus, imenuid, iroleid, itenantid, iorgid) VALUES (
( select max(irolemenumapid) + 1 from ui.rolemenuaccessmap )::integer, false::boolean, false::boolean, false::boolean, false::boolean, true::boolean, true::boolean, true::boolean, 
( select imenuid from ui.menustructuredesc where  vcaction ='userManagement')::integer, '13'::integer, '14'::integer, '10'::integer)
 returning irolemenumapid,itenantid;

INSERT INTO ui.rolemenuaccessmap (
irolemenumapid, badd, bapprove, bdelete, bedit, bpublish, bview, istatus, imenuid, iroleid, itenantid, iorgid) VALUES (
( select max(irolemenumapid) + 1 from ui.rolemenuaccessmap )::integer, false::boolean, false::boolean, false::boolean, false::boolean, true::boolean, true::boolean, true::boolean, 
( select imenuid from ui.menustructuredesc where  vcaction ='EmailScheduler')::integer, '13'::integer, '14'::integer, '10'::integer)
 returning irolemenumapid,itenantid;

INSERT INTO ui.rolemenuaccessmap (
irolemenumapid, badd, bapprove, bdelete, bedit, bpublish, bview, istatus, imenuid, iroleid, itenantid, iorgid) VALUES (
( select max(irolemenumapid) + 1 from ui.rolemenuaccessmap )::integer, false::boolean, false::boolean, false::boolean, false::boolean, true::boolean, true::boolean, true::boolean, 
( select imenuid from ui.menustructuredesc where  vcaction ='FileUpload')::integer, '13'::integer, '14'::integer, '10'::integer)
 returning irolemenumapid,itenantid;

INSERT INTO ui.rolemenuaccessmap (
irolemenumapid, badd, bapprove, bdelete, bedit, bpublish, bview, istatus, imenuid, iroleid, itenantid, iorgid) VALUES (
( select max(irolemenumapid) + 1 from ui.rolemenuaccessmap )::integer, false::boolean, false::boolean, false::boolean, false::boolean, true::boolean, true::boolean, true::boolean, 
( select imenuid from ui.menustructuredesc where  vcaction ='AdminReports')::integer, '13'::integer, '14'::integer, '10'::integer)
 returning irolemenumapid,itenantid;


INSERT INTO ui.rolemenuaccessmap (
irolemenumapid, badd, bapprove, bdelete, bedit, bpublish, bview, istatus, imenuid, iroleid, itenantid, iorgid) VALUES (
( select max(irolemenumapid) + 1 from ui.rolemenuaccessmap )::integer, false::boolean, false::boolean, false::boolean, true::boolean, true::boolean, true::boolean, true::boolean, 
( select imenuid from ui.menustructuredesc where  vcaction ='Masters')::integer, '13'::integer, '14'::integer, '10'::integer)
 returning irolemenumapid,itenantid;

INSERT INTO ui.rolemenuaccessmap (
irolemenumapid, badd, bapprove, bdelete, bedit, bpublish, bview, istatus, imenuid, iroleid, itenantid, iorgid) VALUES (
( select max(irolemenumapid) + 1 from ui.rolemenuaccessmap )::integer, false::boolean, false::boolean, false::boolean, false::boolean, true::boolean, true::boolean, true::boolean, 
( select imenuid from ui.menustructuredesc where  vcaction ='Class')::integer, '13'::integer, '14'::integer, '10'::integer)
 returning irolemenumapid,itenantid;

INSERT INTO ui.rolemenuaccessmap (
irolemenumapid, badd, bapprove, bdelete, bedit, bpublish, bview, istatus, imenuid, iroleid, itenantid, iorgid) VALUES (
( select max(irolemenumapid) + 1 from ui.rolemenuaccessmap )::integer, false::boolean, false::boolean, false::boolean, false::boolean, true::boolean, true::boolean, true::boolean, 
( select imenuid from ui.menustructuredesc where  vcaction ='Decision')::integer, '13'::integer, '14'::integer, '10'::integer)
 returning irolemenumapid,itenantid;

INSERT INTO ui.rolemenuaccessmap (
irolemenumapid, badd, bapprove, bdelete, bedit, bpublish, bview, istatus, imenuid, iroleid, itenantid, iorgid) VALUES (
( select max(irolemenumapid) + 1 from ui.rolemenuaccessmap )::integer, false::boolean, false::boolean, false::boolean, false::boolean, true::boolean, true::boolean, true::boolean, 
( select imenuid from ui.menustructuredesc where  vcaction ='Rules')::integer, '13'::integer, '14'::integer, '10'::integer)
 returning irolemenumapid,itenantid;

INSERT INTO ui.rolemenuaccessmap (
irolemenumapid, badd, bapprove, bdelete, bedit, bpublish, bview, istatus, imenuid, iroleid, itenantid, iorgid) VALUES (
( select max(irolemenumapid) + 1 from ui.rolemenuaccessmap )::integer, false::boolean, false::boolean, false::boolean, false::boolean, true::boolean, true::boolean, true::boolean, 
( select imenuid from ui.menustructuredesc where  vcaction ='RT Window')::integer, '13'::integer, '14'::integer, '10'::integer)
 returning irolemenumapid,itenantid;

INSERT INTO ui.rolemenuaccessmap (
irolemenumapid, badd, bapprove, bdelete, bedit, bpublish, bview, istatus, imenuid, iroleid, itenantid, iorgid) VALUES (
( select max(irolemenumapid) + 1 from ui.rolemenuaccessmap )::integer, false::boolean, false::boolean, false::boolean, false::boolean, true::boolean, true::boolean, true::boolean, 
( select imenuid from ui.menustructuredesc where  vcaction ='RT Observation')::integer, '13'::integer, '14'::integer, '10'::integer)
 returning irolemenumapid,itenantid;

INSERT INTO ui.rolemenuaccessmap (
irolemenumapid, badd, bapprove, bdelete, bedit, bpublish, bview, istatus, imenuid, iroleid, itenantid, iorgid) VALUES (
( select max(irolemenumapid) + 1 from ui.rolemenuaccessmap )::integer, false::boolean, false::boolean, false::boolean, false::boolean, true::boolean, true::boolean, true::boolean, 
( select imenuid from ui.menustructuredesc where  vcaction ='Historic Profile')::integer, '13'::integer, '14'::integer, '10'::integer)
 returning irolemenumapid,itenantid;

INSERT INTO ui.rolemenuaccessmap (
irolemenumapid, badd, bapprove, bdelete, bedit, bpublish, bview, istatus, imenuid, iroleid, itenantid, iorgid) VALUES (
( select max(irolemenumapid) + 1 from ui.rolemenuaccessmap )::integer, false::boolean, false::boolean, false::boolean, false::boolean, true::boolean, true::boolean, true::boolean, 
( select imenuid from ui.menustructuredesc where  vcaction ='List')::integer, '13'::integer, '14'::integer, '10'::integer)
 returning irolemenumapid,itenantid;

INSERT INTO ui.rolemenuaccessmap (
irolemenumapid, badd, bapprove, bdelete, bedit, bpublish, bview, istatus, imenuid, iroleid, itenantid, iorgid) VALUES (
( select max(irolemenumapid) + 1 from ui.rolemenuaccessmap )::integer, false::boolean, false::boolean, false::boolean, false::boolean, true::boolean, true::boolean, true::boolean, 
( select imenuid from ui.menustructuredesc where  vcaction ='Edit List')::integer, '13'::integer, '14'::integer, '10'::integer)
 returning irolemenumapid,itenantid;




 ---risk supervisor
INSERT INTO ui.rolemenuaccessmap (
irolemenumapid, badd, bapprove, bdelete, bedit, bpublish, bview, istatus, imenuid, iroleid, itenantid, iorgid) VALUES (
( select max(irolemenumapid) + 1 from ui.rolemenuaccessmap )::integer, true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, 
( select imenuid from ui.menustructuredesc where  vcaction ='Analytics')::integer, '14'::integer, '14'::integer, '10'::integer)
 returning irolemenumapid,itenantid;

INSERT INTO ui.rolemenuaccessmap (
irolemenumapid, badd, bapprove, bdelete, bedit, bpublish, bview, istatus, imenuid, iroleid, itenantid, iorgid) VALUES (
( select max(irolemenumapid) + 1 from ui.rolemenuaccessmap )::integer, true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, 
( select imenuid from ui.menustructuredesc where  vcaction ='TransactionDB')::integer, '14'::integer, '14'::integer, '10'::integer)
 returning irolemenumapid,itenantid;

INSERT INTO ui.rolemenuaccessmap (
irolemenumapid, badd, bapprove, bdelete, bedit, bpublish, bview, istatus, imenuid, iroleid, itenantid, iorgid) VALUES (
( select max(irolemenumapid) + 1 from ui.rolemenuaccessmap )::integer, true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, 
( select imenuid from ui.menustructuredesc where  vcaction ='PartyDashboard')::integer, '14'::integer, '14'::integer, '10'::integer)
 returning irolemenumapid,itenantid;

INSERT INTO ui.rolemenuaccessmap (
irolemenumapid, badd, bapprove, bdelete, bedit, bpublish, bview, istatus, imenuid, iroleid, itenantid, iorgid) VALUES (
( select max(irolemenumapid) + 1 from ui.rolemenuaccessmap )::integer, true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, 
( select imenuid from ui.menustructuredesc where  vcaction ='TransactionProfile')::integer, '14'::integer, '14'::integer, '10'::integer)
 returning irolemenumapid,itenantid;

INSERT INTO ui.rolemenuaccessmap (
irolemenumapid, badd, bapprove, bdelete, bedit, bpublish, bview, istatus, imenuid, iroleid, itenantid, iorgid) VALUES (
( select max(irolemenumapid) + 1 from ui.rolemenuaccessmap )::integer, true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, 
( select imenuid from ui.menustructuredesc where  vcaction ='DataAnalyzer')::integer, '14'::integer, '14'::integer, '10'::integer)
 returning irolemenumapid,itenantid;

INSERT INTO ui.rolemenuaccessmap (
irolemenumapid, badd, bapprove, bdelete, bedit, bpublish, bview, istatus, imenuid, iroleid, itenantid, iorgid) VALUES (
( select max(irolemenumapid) + 1 from ui.rolemenuaccessmap )::integer, true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, 
( select imenuid from ui.menustructuredesc where  vcaction ='Case')::integer, '14'::integer, '14'::integer, '10'::integer)
 returning irolemenumapid,itenantid;

INSERT INTO ui.rolemenuaccessmap (
irolemenumapid, badd, bapprove, bdelete, bedit, bpublish, bview, istatus, imenuid, iroleid, itenantid, iorgid) VALUES (
( select max(irolemenumapid) + 1 from ui.rolemenuaccessmap )::integer, true::boolean, true::boolean, false::boolean, true::boolean, true::boolean, true::boolean, true::boolean, 
( select imenuid from ui.menustructuredesc where  vcaction ='Tasks')::integer, '14'::integer, '14'::integer, '10'::integer)
 returning irolemenumapid,itenantid;

INSERT INTO ui.rolemenuaccessmap (
irolemenumapid, badd, bapprove, bdelete, bedit, bpublish, bview, istatus, imenuid, iroleid, itenantid, iorgid) VALUES (
( select max(irolemenumapid) + 1 from ui.rolemenuaccessmap )::integer, true::boolean, true::boolean, false::boolean, true::boolean, true::boolean, true::boolean, true::boolean, 
( select imenuid from ui.menustructuredesc where  vcaction ='CreateManualTicket')::integer, '14'::integer, '14'::integer, '10'::integer)
 returning irolemenumapid,itenantid;

INSERT INTO ui.rolemenuaccessmap (
irolemenumapid, badd, bapprove, bdelete, bedit, bpublish, bview, istatus, imenuid, iroleid, itenantid, iorgid) VALUES (
( select max(irolemenumapid) + 1 from ui.rolemenuaccessmap )::integer, true::boolean, true::boolean, false::boolean, true::boolean, true::boolean, true::boolean, true::boolean, 
( select imenuid from ui.menustructuredesc where  vcaction ='ProcessBulkTickets')::integer, '14'::integer, '14'::integer, '10'::integer)
 returning irolemenumapid,itenantid;

INSERT INTO ui.rolemenuaccessmap (
irolemenumapid, badd, bapprove, bdelete, bedit, bpublish, bview, istatus, imenuid, iroleid, itenantid, iorgid) VALUES (
( select max(irolemenumapid) + 1 from ui.rolemenuaccessmap )::integer, true::boolean, true::boolean, false::boolean, true::boolean, true::boolean, true::boolean, true::boolean, 
( select imenuid from ui.menustructuredesc where  vcaction ='CaseSummary')::integer, '14'::integer, '14'::integer, '10'::integer)
 returning irolemenumapid,itenantid;

INSERT INTO ui.rolemenuaccessmap (
irolemenumapid, badd, bapprove, bdelete, bedit, bpublish, bview, istatus, imenuid, iroleid, itenantid, iorgid) VALUES (
( select max(irolemenumapid) + 1 from ui.rolemenuaccessmap )::integer, true::boolean, true::boolean, false::boolean, true::boolean, true::boolean, true::boolean, true::boolean, 
( select imenuid from ui.menustructuredesc where  vcaction ='Reports')::integer, '14'::integer, '14'::integer, '10'::integer)
 returning irolemenumapid,itenantid;

INSERT INTO ui.rolemenuaccessmap (
irolemenumapid, badd, bapprove, bdelete, bedit, bpublish, bview, istatus, imenuid, iroleid, itenantid, iorgid) VALUES (
( select max(irolemenumapid) + 1 from ui.rolemenuaccessmap )::integer, true::boolean, true::boolean, false::boolean, true::boolean, true::boolean, true::boolean, true::boolean, 
( select imenuid from ui.menustructuredesc where  vcaction ='AutoAllocationUserMapping')::integer, '14'::integer, '14'::integer, '10'::integer)
 returning irolemenumapid,itenantid;

INSERT INTO ui.rolemenuaccessmap (
irolemenumapid, badd, bapprove, bdelete, bedit, bpublish, bview, istatus, imenuid, iroleid, itenantid, iorgid) VALUES (
( select max(irolemenumapid) + 1 from ui.rolemenuaccessmap )::integer, true::boolean, false::boolean, true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, 
( select imenuid from ui.menustructuredesc where  vcaction ='try out')::integer, '14'::integer, '14'::integer, '10'::integer)
 returning irolemenumapid,itenantid;

INSERT INTO ui.rolemenuaccessmap (
irolemenumapid, badd, bapprove, bdelete, bedit, bpublish, bview, istatus, imenuid, iroleid, itenantid, iorgid) VALUES (
( select max(irolemenumapid) + 1 from ui.rolemenuaccessmap )::integer, true::boolean, false::boolean, true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, 
( select imenuid from ui.menustructuredesc where  vcaction ='RunSimulation')::integer, '14'::integer, '14'::integer, '10'::integer)
 returning irolemenumapid,itenantid;

INSERT INTO ui.rolemenuaccessmap (
irolemenumapid, badd, bapprove, bdelete, bedit, bpublish, bview, istatus, imenuid, iroleid, itenantid, iorgid) VALUES (
( select max(irolemenumapid) + 1 from ui.rolemenuaccessmap )::integer, true::boolean, false::boolean, true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, 
( select imenuid from ui.menustructuredesc where  vcaction ='AnalyzeSimulation')::integer, '14'::integer, '14'::integer, '10'::integer)
 returning irolemenumapid,itenantid;

INSERT INTO ui.rolemenuaccessmap (
irolemenumapid, badd, bapprove, bdelete, bedit, bpublish, bview, istatus, imenuid, iroleid, itenantid, iorgid) VALUES (
( select max(irolemenumapid) + 1 from ui.rolemenuaccessmap )::integer, true::boolean, false::boolean, true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, 
( select imenuid from ui.menustructuredesc where  vcaction ='RuleBuilder')::integer, '14'::integer, '14'::integer, '10'::integer)
 returning irolemenumapid,itenantid;


INSERT INTO ui.rolemenuaccessmap (
irolemenumapid, badd, bapprove, bdelete, bedit, bpublish, bview, istatus, imenuid, iroleid, itenantid, iorgid) VALUES (
( select max(irolemenumapid) + 1 from ui.rolemenuaccessmap )::integer, false::boolean, false::boolean, false::boolean, true::boolean, true::boolean, true::boolean, true::boolean, 
( select imenuid from ui.menustructuredesc where  vcaction ='Admin')::integer, '14'::integer, '14'::integer, '10'::integer)
 returning irolemenumapid,itenantid;

INSERT INTO ui.rolemenuaccessmap (
irolemenumapid, badd, bapprove, bdelete, bedit, bpublish, bview, istatus, imenuid, iroleid, itenantid, iorgid) VALUES (
( select max(irolemenumapid) + 1 from ui.rolemenuaccessmap )::integer, false::boolean, false::boolean, false::boolean, true::boolean, true::boolean, true::boolean, true::boolean, 
( select imenuid from ui.menustructuredesc where  vcaction ='userManagement')::integer, '14'::integer, '14'::integer, '10'::integer)
 returning irolemenumapid,itenantid;

INSERT INTO ui.rolemenuaccessmap (
irolemenumapid, badd, bapprove, bdelete, bedit, bpublish, bview, istatus, imenuid, iroleid, itenantid, iorgid) VALUES (
( select max(irolemenumapid) + 1 from ui.rolemenuaccessmap )::integer, false::boolean, false::boolean, false::boolean, true::boolean, true::boolean, true::boolean, true::boolean, 
( select imenuid from ui.menustructuredesc where  vcaction ='EmailScheduler')::integer, '14'::integer, '14'::integer, '10'::integer)
 returning irolemenumapid,itenantid;

INSERT INTO ui.rolemenuaccessmap (
irolemenumapid, badd, bapprove, bdelete, bedit, bpublish, bview, istatus, imenuid, iroleid, itenantid, iorgid) VALUES (
( select max(irolemenumapid) + 1 from ui.rolemenuaccessmap )::integer, false::boolean, false::boolean, false::boolean, true::boolean, true::boolean, true::boolean, true::boolean, 
( select imenuid from ui.menustructuredesc where  vcaction ='FileUpload')::integer, '14'::integer, '14'::integer, '10'::integer)
 returning irolemenumapid,itenantid;

INSERT INTO ui.rolemenuaccessmap (
irolemenumapid, badd, bapprove, bdelete, bedit, bpublish, bview, istatus, imenuid, iroleid, itenantid, iorgid) VALUES (
( select max(irolemenumapid) + 1 from ui.rolemenuaccessmap )::integer, false::boolean, false::boolean, false::boolean, true::boolean, true::boolean, true::boolean, true::boolean, 
( select imenuid from ui.menustructuredesc where  vcaction ='AdminReports')::integer, '14'::integer, '14'::integer, '10'::integer)
 returning irolemenumapid,itenantid;


INSERT INTO ui.rolemenuaccessmap (
irolemenumapid, badd, bapprove, bdelete, bedit, bpublish, bview, istatus, imenuid, iroleid, itenantid, iorgid) VALUES (
( select max(irolemenumapid) + 1 from ui.rolemenuaccessmap )::integer, true::boolean, false::boolean, true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, 
( select imenuid from ui.menustructuredesc where  vcaction ='Masters')::integer, '14'::integer, '14'::integer, '10'::integer)
 returning irolemenumapid,itenantid;

INSERT INTO ui.rolemenuaccessmap (
irolemenumapid, badd, bapprove, bdelete, bedit, bpublish, bview, istatus, imenuid, iroleid, itenantid, iorgid) VALUES (
( select max(irolemenumapid) + 1 from ui.rolemenuaccessmap )::integer, true::boolean, false::boolean, true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, 
( select imenuid from ui.menustructuredesc where  vcaction ='Class')::integer, '14'::integer, '14'::integer, '10'::integer)
 returning irolemenumapid,itenantid;

INSERT INTO ui.rolemenuaccessmap (
irolemenumapid, badd, bapprove, bdelete, bedit, bpublish, bview, istatus, imenuid, iroleid, itenantid, iorgid) VALUES (
( select max(irolemenumapid) + 1 from ui.rolemenuaccessmap )::integer, true::boolean, false::boolean, true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, 
( select imenuid from ui.menustructuredesc where  vcaction ='Decision')::integer, '14'::integer, '14'::integer, '10'::integer)
 returning irolemenumapid,itenantid;

INSERT INTO ui.rolemenuaccessmap (
irolemenumapid, badd, bapprove, bdelete, bedit, bpublish, bview, istatus, imenuid, iroleid, itenantid, iorgid) VALUES (
( select max(irolemenumapid) + 1 from ui.rolemenuaccessmap )::integer, true::boolean, false::boolean, true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, 
( select imenuid from ui.menustructuredesc where  vcaction ='Rules')::integer, '14'::integer, '14'::integer, '10'::integer)
 returning irolemenumapid,itenantid;

INSERT INTO ui.rolemenuaccessmap (
irolemenumapid, badd, bapprove, bdelete, bedit, bpublish, bview, istatus, imenuid, iroleid, itenantid, iorgid) VALUES (
( select max(irolemenumapid) + 1 from ui.rolemenuaccessmap )::integer, true::boolean, false::boolean, true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, 
( select imenuid from ui.menustructuredesc where  vcaction ='RT Window')::integer, '14'::integer, '14'::integer, '10'::integer)
 returning irolemenumapid,itenantid;

INSERT INTO ui.rolemenuaccessmap (
irolemenumapid, badd, bapprove, bdelete, bedit, bpublish, bview, istatus, imenuid, iroleid, itenantid, iorgid) VALUES (
( select max(irolemenumapid) + 1 from ui.rolemenuaccessmap )::integer, true::boolean, false::boolean, true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, 
( select imenuid from ui.menustructuredesc where  vcaction ='RT Observation')::integer, '14'::integer, '14'::integer, '10'::integer)
 returning irolemenumapid,itenantid;

INSERT INTO ui.rolemenuaccessmap (
irolemenumapid, badd, bapprove, bdelete, bedit, bpublish, bview, istatus, imenuid, iroleid, itenantid, iorgid) VALUES (
( select max(irolemenumapid) + 1 from ui.rolemenuaccessmap )::integer, true::boolean, false::boolean, true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, 
( select imenuid from ui.menustructuredesc where  vcaction ='Historic Profile')::integer, '14'::integer, '14'::integer, '10'::integer)
 returning irolemenumapid,itenantid;

INSERT INTO ui.rolemenuaccessmap (
irolemenumapid, badd, bapprove, bdelete, bedit, bpublish, bview, istatus, imenuid, iroleid, itenantid, iorgid) VALUES (
( select max(irolemenumapid) + 1 from ui.rolemenuaccessmap )::integer, true::boolean, false::boolean,true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, 
( select imenuid from ui.menustructuredesc where  vcaction ='List')::integer, '14'::integer, '14'::integer, '10'::integer)
 returning irolemenumapid,itenantid;

INSERT INTO ui.rolemenuaccessmap (
irolemenumapid, badd, bapprove, bdelete, bedit, bpublish, bview, istatus, imenuid, iroleid, itenantid, iorgid) VALUES (
( select max(irolemenumapid) + 1 from ui.rolemenuaccessmap )::integer, true::boolean, false::boolean, true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, 
( select imenuid from ui.menustructuredesc where  vcaction ='Edit List')::integer, '14'::integer, '14'::integer, '10'::integer)
 returning irolemenumapid,itenantid;



 ---Operation Analyst

INSERT INTO ui.rolemenuaccessmap (
irolemenumapid, badd, bapprove, bdelete, bedit, bpublish, bview, istatus, imenuid, iroleid, itenantid, iorgid) VALUES (
( select max(irolemenumapid) + 1 from ui.rolemenuaccessmap )::integer, true::boolean, false::boolean, false::boolean, true::boolean, true::boolean, true::boolean, true::boolean, 
( select imenuid from ui.menustructuredesc where  vcaction ='Admin')::integer, '15'::integer, '14'::integer, '10'::integer)
 returning irolemenumapid,itenantid;

INSERT INTO ui.rolemenuaccessmap (
irolemenumapid, badd, bapprove, bdelete, bedit, bpublish, bview, istatus, imenuid, iroleid, itenantid, iorgid) VALUES (
( select max(irolemenumapid) + 1 from ui.rolemenuaccessmap )::integer, true::boolean, false::boolean, false::boolean, true::boolean, true::boolean, true::boolean, true::boolean, 
( select imenuid from ui.menustructuredesc where  vcaction ='FileUpload')::integer, '15'::integer, '14'::integer, '10'::integer)
 returning irolemenumapid,itenantid;



----User Access Manager - Checker

INSERT INTO ui.rolemenuaccessmap (
irolemenumapid, badd, bapprove, bdelete, bedit, bpublish, bview, istatus, imenuid, iroleid, itenantid, iorgid) VALUES (
( select max(irolemenumapid) + 1 from ui.rolemenuaccessmap )::integer, true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, 
( select imenuid from ui.menustructuredesc where  vcaction ='Analytics')::integer, '16'::integer, '14'::integer, '10'::integer)
 returning irolemenumapid,itenantid;

INSERT INTO ui.rolemenuaccessmap (
irolemenumapid, badd, bapprove, bdelete, bedit, bpublish, bview, istatus, imenuid, iroleid, itenantid, iorgid) VALUES (
( select max(irolemenumapid) + 1 from ui.rolemenuaccessmap )::integer, true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, 
( select imenuid from ui.menustructuredesc where  vcaction ='TransactionDB')::integer, '16'::integer, '14'::integer, '10'::integer)
 returning irolemenumapid,itenantid;

INSERT INTO ui.rolemenuaccessmap (
irolemenumapid, badd, bapprove, bdelete, bedit, bpublish, bview, istatus, imenuid, iroleid, itenantid, iorgid) VALUES (
( select max(irolemenumapid) + 1 from ui.rolemenuaccessmap )::integer, true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, 
( select imenuid from ui.menustructuredesc where  vcaction ='PartyDashboard')::integer, '16'::integer, '14'::integer, '10'::integer)
 returning irolemenumapid,itenantid;

INSERT INTO ui.rolemenuaccessmap (
irolemenumapid, badd, bapprove, bdelete, bedit, bpublish, bview, istatus, imenuid, iroleid, itenantid, iorgid) VALUES (
( select max(irolemenumapid) + 1 from ui.rolemenuaccessmap )::integer, true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, 
( select imenuid from ui.menustructuredesc where  vcaction ='TransactionProfile')::integer, '16'::integer, '14'::integer, '10'::integer)
 returning irolemenumapid,itenantid;

INSERT INTO ui.rolemenuaccessmap (
irolemenumapid, badd, bapprove, bdelete, bedit, bpublish, bview, istatus, imenuid, iroleid, itenantid, iorgid) VALUES (
( select max(irolemenumapid) + 1 from ui.rolemenuaccessmap )::integer, true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, true::boolean, 
( select imenuid from ui.menustructuredesc where  vcaction ='DataAnalyzer')::integer, '16'::integer, '14'::integer, '10'::integer)
 returning irolemenumapid,itenantid;

INSERT INTO ui.rolemenuaccessmap (
irolemenumapid, badd, bapprove, bdelete, bedit, bpublish, bview, istatus, imenuid, iroleid, itenantid, iorgid) VALUES (
( select max(irolemenumapid) + 1 from ui.rolemenuaccessmap )::integer, false::boolean, true::boolean, false::boolean, false::boolean, true::boolean, true::boolean, true::boolean, 
( select imenuid from ui.menustructuredesc where  vcaction ='Case')::integer, '16'::integer, '14'::integer, '10'::integer)
 returning irolemenumapid,itenantid;

INSERT INTO ui.rolemenuaccessmap (
irolemenumapid, badd, bapprove, bdelete, bedit, bpublish, bview, istatus, imenuid, iroleid, itenantid, iorgid) VALUES (
( select max(irolemenumapid) + 1 from ui.rolemenuaccessmap )::integer, false::boolean, true::boolean, false::boolean, false::boolean, true::boolean, true::boolean, true::boolean, 
( select imenuid from ui.menustructuredesc where  vcaction ='Tasks')::integer, '16'::integer, '14'::integer, '10'::integer)
 returning irolemenumapid,itenantid;

INSERT INTO ui.rolemenuaccessmap (
irolemenumapid, badd, bapprove, bdelete, bedit, bpublish, bview, istatus, imenuid, iroleid, itenantid, iorgid) VALUES (
( select max(irolemenumapid) + 1 from ui.rolemenuaccessmap )::integer, false::boolean, true::boolean, false::boolean, false::boolean, true::boolean, true::boolean, true::boolean, 
( select imenuid from ui.menustructuredesc where  vcaction ='CreateManualTicket')::integer, '16'::integer, '14'::integer, '10'::integer)
 returning irolemenumapid,itenantid;

INSERT INTO ui.rolemenuaccessmap (
irolemenumapid, badd, bapprove, bdelete, bedit, bpublish, bview, istatus, imenuid, iroleid, itenantid, iorgid) VALUES (
( select max(irolemenumapid) + 1 from ui.rolemenuaccessmap )::integer, false::boolean, true::boolean, false::boolean, false::boolean, true::boolean, true::boolean, true::boolean, 
( select imenuid from ui.menustructuredesc where  vcaction ='ProcessBulkTickets')::integer, '16'::integer, '14'::integer, '10'::integer)
 returning irolemenumapid,itenantid;

INSERT INTO ui.rolemenuaccessmap (
irolemenumapid, badd, bapprove, bdelete, bedit, bpublish, bview, istatus, imenuid, iroleid, itenantid, iorgid) VALUES (
( select max(irolemenumapid) + 1 from ui.rolemenuaccessmap )::integer, false::boolean, true::boolean, false::boolean, false::boolean, true::boolean, true::boolean, true::boolean, 
( select imenuid from ui.menustructuredesc where  vcaction ='CaseSummary')::integer, '16'::integer, '14'::integer, '10'::integer)
 returning irolemenumapid,itenantid;

INSERT INTO ui.rolemenuaccessmap (
irolemenumapid, badd, bapprove, bdelete, bedit, bpublish, bview, istatus, imenuid, iroleid, itenantid, iorgid) VALUES (
( select max(irolemenumapid) + 1 from ui.rolemenuaccessmap )::integer, false::boolean, true::boolean, false::boolean, false::boolean, true::boolean, true::boolean, true::boolean, 
( select imenuid from ui.menustructuredesc where  vcaction ='Reports')::integer, '16'::integer, '14'::integer, '10'::integer)
 returning irolemenumapid,itenantid;

INSERT INTO ui.rolemenuaccessmap (
irolemenumapid, badd, bapprove, bdelete, bedit, bpublish, bview, istatus, imenuid, iroleid, itenantid, iorgid) VALUES (
( select max(irolemenumapid) + 1 from ui.rolemenuaccessmap )::integer, false::boolean, true::boolean, false::boolean, false::boolean, true::boolean, true::boolean, true::boolean, 
( select imenuid from ui.menustructuredesc where  vcaction ='AutoAllocationUserMapping')::integer, '16'::integer, '14'::integer, '10'::integer)
 returning irolemenumapid,itenantid;

INSERT INTO ui.rolemenuaccessmap (
irolemenumapid, badd, bapprove, bdelete, bedit, bpublish, bview, istatus, imenuid, iroleid, itenantid, iorgid) VALUES (
( select max(irolemenumapid) + 1 from ui.rolemenuaccessmap )::integer, false::boolean, true::boolean, false::boolean, true::boolean, true::boolean, true::boolean, true::boolean, 
( select imenuid from ui.menustructuredesc where  vcaction ='try out')::integer, '16'::integer, '14'::integer, '10'::integer)
 returning irolemenumapid,itenantid;

INSERT INTO ui.rolemenuaccessmap (
irolemenumapid, badd, bapprove, bdelete, bedit, bpublish, bview, istatus, imenuid, iroleid, itenantid, iorgid) VALUES (
( select max(irolemenumapid) + 1 from ui.rolemenuaccessmap )::integer, false::boolean, true::boolean, false::boolean, true::boolean, true::boolean, true::boolean, true::boolean, 
( select imenuid from ui.menustructuredesc where  vcaction ='RunSimulation')::integer, '16'::integer, '14'::integer, '10'::integer)
 returning irolemenumapid,itenantid;

INSERT INTO ui.rolemenuaccessmap (
irolemenumapid, badd, bapprove, bdelete, bedit, bpublish, bview, istatus, imenuid, iroleid, itenantid, iorgid) VALUES (
( select max(irolemenumapid) + 1 from ui.rolemenuaccessmap )::integer, false::boolean, true::boolean, false::boolean, true::boolean, true::boolean, true::boolean, true::boolean, 
( select imenuid from ui.menustructuredesc where  vcaction ='AnalyzeSimulation')::integer, '16'::integer, '14'::integer, '10'::integer)
 returning irolemenumapid,itenantid;

INSERT INTO ui.rolemenuaccessmap (
irolemenumapid, badd, bapprove, bdelete, bedit, bpublish, bview, istatus, imenuid, iroleid, itenantid, iorgid) VALUES (
( select max(irolemenumapid) + 1 from ui.rolemenuaccessmap )::integer, false::boolean, true::boolean, false::boolean, true::boolean, true::boolean, true::boolean, true::boolean, 
( select imenuid from ui.menustructuredesc where  vcaction ='RuleBuilder')::integer, '16'::integer, '14'::integer, '10'::integer)
 returning irolemenumapid,itenantid;


INSERT INTO ui.rolemenuaccessmap (
irolemenumapid, badd, bapprove, bdelete, bedit, bpublish, bview, istatus, imenuid, iroleid, itenantid, iorgid) VALUES (
( select max(irolemenumapid) + 1 from ui.rolemenuaccessmap )::integer, false::boolean, true::boolean, false::boolean, true::boolean, true::boolean, true::boolean, true::boolean, 
( select imenuid from ui.menustructuredesc where  vcaction ='Admin')::integer, '16'::integer, '14'::integer, '10'::integer)
 returning irolemenumapid,itenantid;

INSERT INTO ui.rolemenuaccessmap (
irolemenumapid, badd, bapprove, bdelete, bedit, bpublish, bview, istatus, imenuid, iroleid, itenantid, iorgid) VALUES (
( select max(irolemenumapid) + 1 from ui.rolemenuaccessmap )::integer, false::boolean, true::boolean, false::boolean, true::boolean, true::boolean, true::boolean, true::boolean, 
( select imenuid from ui.menustructuredesc where  vcaction ='userManagement')::integer, '16'::integer, '14'::integer, '10'::integer)
 returning irolemenumapid,itenantid;

INSERT INTO ui.rolemenuaccessmap (
irolemenumapid, badd, bapprove, bdelete, bedit, bpublish, bview, istatus, imenuid, iroleid, itenantid, iorgid) VALUES (
( select max(irolemenumapid) + 1 from ui.rolemenuaccessmap )::integer, false::boolean, true::boolean, false::boolean, true::boolean, true::boolean, true::boolean, true::boolean, 
( select imenuid from ui.menustructuredesc where  vcaction ='EmailScheduler')::integer, '16'::integer, '14'::integer, '10'::integer)
 returning irolemenumapid,itenantid;

INSERT INTO ui.rolemenuaccessmap (
irolemenumapid, badd, bapprove, bdelete, bedit, bpublish, bview, istatus, imenuid, iroleid, itenantid, iorgid) VALUES (
( select max(irolemenumapid) + 1 from ui.rolemenuaccessmap )::integer, false::boolean, true::boolean, false::boolean, true::boolean, true::boolean, true::boolean, true::boolean, 
( select imenuid from ui.menustructuredesc where  vcaction ='FileUpload')::integer, '16'::integer, '14'::integer, '10'::integer)
 returning irolemenumapid,itenantid;

INSERT INTO ui.rolemenuaccessmap (
irolemenumapid, badd, bapprove, bdelete, bedit, bpublish, bview, istatus, imenuid, iroleid, itenantid, iorgid) VALUES (
( select max(irolemenumapid) + 1 from ui.rolemenuaccessmap )::integer, false::boolean, true::boolean, false::boolean, true::boolean, true::boolean, true::boolean, true::boolean, 
( select imenuid from ui.menustructuredesc where  vcaction ='AdminReports')::integer, '16'::integer, '14'::integer, '10'::integer)
 returning irolemenumapid,itenantid;


INSERT INTO ui.rolemenuaccessmap (
irolemenumapid, badd, bapprove, bdelete, bedit, bpublish, bview, istatus, imenuid, iroleid, itenantid, iorgid) VALUES (
( select max(irolemenumapid) + 1 from ui.rolemenuaccessmap )::integer, false::boolean,true::boolean, false::boolean, true::boolean, true::boolean, true::boolean, true::boolean, 
( select imenuid from ui.menustructuredesc where  vcaction ='Masters')::integer, '16'::integer, '14'::integer, '10'::integer)
 returning irolemenumapid,itenantid;

INSERT INTO ui.rolemenuaccessmap (
irolemenumapid, badd, bapprove, bdelete, bedit, bpublish, bview, istatus, imenuid, iroleid, itenantid, iorgid) VALUES (
( select max(irolemenumapid) + 1 from ui.rolemenuaccessmap )::integer, false::boolean, true::boolean, false::boolean, true::boolean, true::boolean, true::boolean, true::boolean, 
( select imenuid from ui.menustructuredesc where  vcaction ='Class')::integer, '16'::integer, '14'::integer, '10'::integer)
 returning irolemenumapid,itenantid;

INSERT INTO ui.rolemenuaccessmap (
irolemenumapid, badd, bapprove, bdelete, bedit, bpublish, bview, istatus, imenuid, iroleid, itenantid, iorgid) VALUES (
( select max(irolemenumapid) + 1 from ui.rolemenuaccessmap )::integer, false::boolean, true::boolean, false::boolean, true::boolean, true::boolean, true::boolean, true::boolean, 
( select imenuid from ui.menustructuredesc where  vcaction ='Decision')::integer, '16'::integer, '14'::integer, '10'::integer)
 returning irolemenumapid,itenantid;

INSERT INTO ui.rolemenuaccessmap (
irolemenumapid, badd, bapprove, bdelete, bedit, bpublish, bview, istatus, imenuid, iroleid, itenantid, iorgid) VALUES (
( select max(irolemenumapid) + 1 from ui.rolemenuaccessmap )::integer, false::boolean, true::boolean, false::boolean, true::boolean, true::boolean, true::boolean, true::boolean, 
( select imenuid from ui.menustructuredesc where  vcaction ='Rules')::integer, '16'::integer, '14'::integer, '10'::integer)
 returning irolemenumapid,itenantid;

INSERT INTO ui.rolemenuaccessmap (
irolemenumapid, badd, bapprove, bdelete, bedit, bpublish, bview, istatus, imenuid, iroleid, itenantid, iorgid) VALUES (
( select max(irolemenumapid) + 1 from ui.rolemenuaccessmap )::integer, false::boolean, true::boolean, false::boolean, true::boolean, true::boolean, true::boolean, true::boolean, 
( select imenuid from ui.menustructuredesc where  vcaction ='RT Window')::integer, '16'::integer, '14'::integer, '10'::integer)
 returning irolemenumapid,itenantid;

INSERT INTO ui.rolemenuaccessmap (
irolemenumapid, badd, bapprove, bdelete, bedit, bpublish, bview, istatus, imenuid, iroleid, itenantid, iorgid) VALUES (
( select max(irolemenumapid) + 1 from ui.rolemenuaccessmap )::integer, false::boolean, true::boolean, false::boolean, true::boolean, true::boolean, true::boolean, true::boolean, 
( select imenuid from ui.menustructuredesc where  vcaction ='RT Observation')::integer, '16'::integer, '14'::integer, '10'::integer)
 returning irolemenumapid,itenantid;

INSERT INTO ui.rolemenuaccessmap (
irolemenumapid, badd, bapprove, bdelete, bedit, bpublish, bview, istatus, imenuid, iroleid, itenantid, iorgid) VALUES (
( select max(irolemenumapid) + 1 from ui.rolemenuaccessmap )::integer, false::boolean, true::boolean, false::boolean, true::boolean, true::boolean, true::boolean, true::boolean, 
( select imenuid from ui.menustructuredesc where  vcaction ='Historic Profile')::integer, '16'::integer, '14'::integer, '10'::integer)
 returning irolemenumapid,itenantid;

INSERT INTO ui.rolemenuaccessmap (
irolemenumapid, badd, bapprove, bdelete, bedit, bpublish, bview, istatus, imenuid, iroleid, itenantid, iorgid) VALUES (
( select max(irolemenumapid) + 1 from ui.rolemenuaccessmap )::integer, false::boolean, true::boolean, false::boolean, true::boolean, true::boolean, true::boolean, true::boolean, 
( select imenuid from ui.menustructuredesc where  vcaction ='List')::integer, '16'::integer, '14'::integer, '10'::integer)
 returning irolemenumapid,itenantid;

INSERT INTO ui.rolemenuaccessmap (
irolemenumapid, badd, bapprove, bdelete, bedit, bpublish, bview, istatus, imenuid, iroleid, itenantid, iorgid) VALUES (
( select max(irolemenumapid) + 1 from ui.rolemenuaccessmap )::integer, false::boolean, true::boolean, false::boolean, true::boolean, true::boolean, true::boolean, true::boolean, 
( select imenuid from ui.menustructuredesc where  vcaction ='Edit List')::integer, '16'::integer, '14'::integer, '10'::integer)
 returning irolemenumapid,itenantid;

