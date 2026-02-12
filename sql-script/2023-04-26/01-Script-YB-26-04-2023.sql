

INSERT INTO ui.workflowmasters (
workflowid, workflowname, workflowkey) VALUES (
'15'::integer, 'Sanctions'::character varying, 'Sanctions'::character varying)
 returning workflowid;


INSERT INTO ui.panelaccessmap (
panelaccessmap, panelid, groupid, workflowid) VALUES (
(select max(panelaccessmap)+1 from ui.panelaccessmap), '1'::integer, '1023'::integer, '15'::integer)
 returning panelaccessmap;


INSERT INTO ui.panelaccessmap (
panelaccessmap, panelid, groupid, workflowid) VALUES (
(select max(panelaccessmap)+1 from ui.panelaccessmap), '1'::integer, '1022'::integer, '15'::integer)
 returning panelaccessmap;


INSERT INTO ui.panelaccessmap (
panelaccessmap, panelid, groupid, workflowid) VALUES (
(select max(panelaccessmap)+1 from ui.panelaccessmap), '5'::integer, '1023'::integer, '15'::integer)
 returning panelaccessmap;


INSERT INTO ui.panelaccessmap (
panelaccessmap, panelid, groupid, workflowid) VALUES (
(select max(panelaccessmap)+1 from ui.panelaccessmap), '5'::integer, '1022'::integer, '15'::integer)
 returning panelaccessmap;


INSERT INTO ui.panelaccessmap (
panelaccessmap, panelid, groupid, workflowid) VALUES (
(select max(panelaccessmap)+1 from ui.panelaccessmap), '3'::integer, '1023'::integer, '15'::integer)
 returning panelaccessmap;


INSERT INTO ui.panelaccessmap (
panelaccessmap, panelid, groupid, workflowid) VALUES (
(select max(panelaccessmap)+1 from ui.panelaccessmap), '3'::integer, '1022'::integer, '15'::integer)
 returning panelaccessmap;