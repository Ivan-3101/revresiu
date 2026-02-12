DELETE  FROM ui.panelaccessmap;
DELETE FROM ui.workflowmasters;

INSERT INTO ui.workflowmasters (workflowid, workflowname, workflowkey) VALUES (13, 'CUB-Risk Notification', 'CUB_RiskNotification');
INSERT INTO ui.workflowmasters (workflowid, workflowname, workflowkey) VALUES (14, 'USFB-Risk Notification', 'USFB_RiskNotification');

INSERT INTO ui.panelaccessmap (panelaccessmap, panelid, groupid, workflowid) VALUES (106, 5, 1020, 14);
INSERT INTO ui.panelaccessmap (panelaccessmap, panelid, groupid, workflowid) VALUES (107, 4, 1020, 14);
INSERT INTO ui.panelaccessmap (panelaccessmap, panelid, groupid, workflowid) VALUES (108, 3, 1020, 14);
INSERT INTO ui.panelaccessmap (panelaccessmap, panelid, groupid, workflowid) VALUES (109, 2, 1020, 14);
INSERT INTO ui.panelaccessmap (panelaccessmap, panelid, groupid, workflowid) VALUES (110, 1, 1020, 14);
INSERT INTO ui.panelaccessmap (panelaccessmap, panelid, groupid, workflowid) VALUES (111, 5, 1020, 13);
INSERT INTO ui.panelaccessmap (panelaccessmap, panelid, groupid, workflowid) VALUES (112, 4, 1020, 13);
INSERT INTO ui.panelaccessmap (panelaccessmap, panelid, groupid, workflowid) VALUES (113, 3, 1020, 13);
INSERT INTO ui.panelaccessmap (panelaccessmap, panelid, groupid, workflowid) VALUES (114, 2, 1020, 13);
INSERT INTO ui.panelaccessmap (panelaccessmap, panelid, groupid, workflowid) VALUES (115, 1, 1020, 13);

INSERT INTO ui.panelaccessmap (panelaccessmap, panelid, groupid, workflowid) VALUES (128, 5, 1021, 14);
INSERT INTO ui.panelaccessmap (panelaccessmap, panelid, groupid, workflowid) VALUES (129, 4, 1021, 14);
INSERT INTO ui.panelaccessmap (panelaccessmap, panelid, groupid, workflowid) VALUES (130, 3, 1021, 14);
INSERT INTO ui.panelaccessmap (panelaccessmap, panelid, groupid, workflowid) VALUES (131, 2, 1021, 14);
INSERT INTO ui.panelaccessmap (panelaccessmap, panelid, groupid, workflowid) VALUES (132, 1, 1021, 14);
INSERT INTO ui.panelaccessmap (panelaccessmap, panelid, groupid, workflowid) VALUES (133, 5, 1021, 13);
INSERT INTO ui.panelaccessmap (panelaccessmap, panelid, groupid, workflowid) VALUES (134, 4, 1021, 13);
INSERT INTO ui.panelaccessmap (panelaccessmap, panelid, groupid, workflowid) VALUES (135, 3, 1021, 13);
INSERT INTO ui.panelaccessmap (panelaccessmap, panelid, groupid, workflowid) VALUES (136, 2, 1021, 13);
INSERT INTO ui.panelaccessmap (panelaccessmap, panelid, groupid, workflowid) VALUES (137, 1, 1021, 13);
