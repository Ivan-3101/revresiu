DELETE  FROM ui.panelaccessmap;
DELETE FROM ui.workflowmasters;

INSERT INTO ui.workflowmasters (workflowid, workflowname, workflowkey) VALUES (1, 'Risk Alert', 'RiskAlert');
INSERT INTO ui.workflowmasters (workflowid, workflowname, workflowkey) VALUES (2, 'Decline Transaction', 'DeclineTransaction');



INSERT INTO ui.panelaccessmap (panelaccessmap, panelid, groupid, workflowid) VALUES (31, 1, 1020, 2);
INSERT INTO ui.panelaccessmap (panelaccessmap, panelid, groupid, workflowid) VALUES (32, 2, 1020, 2);
INSERT INTO ui.panelaccessmap (panelaccessmap, panelid, groupid, workflowid) VALUES (33, 3, 1020, 2);
INSERT INTO ui.panelaccessmap (panelaccessmap, panelid, groupid, workflowid) VALUES (34, 4, 1020, 2);
INSERT INTO ui.panelaccessmap (panelaccessmap, panelid, groupid, workflowid) VALUES (35, 5, 1020, 2);

INSERT INTO ui.panelaccessmap (panelaccessmap, panelid, groupid, workflowid) VALUES (36, 1, 1020, 1);
INSERT INTO ui.panelaccessmap (panelaccessmap, panelid, groupid, workflowid) VALUES (37, 2, 1020, 1);
INSERT INTO ui.panelaccessmap (panelaccessmap, panelid, groupid, workflowid) VALUES (38, 3, 1020, 1);
INSERT INTO ui.panelaccessmap (panelaccessmap, panelid, groupid, workflowid) VALUES (39, 4, 1020, 1);
INSERT INTO ui.panelaccessmap (panelaccessmap, panelid, groupid, workflowid) VALUES (40, 5, 1020, 1);
INSERT INTO ui.panelaccessmap (panelaccessmap, panelid, groupid, workflowid) VALUES (91, 1, 1020, 1);
INSERT INTO ui.panelaccessmap (panelaccessmap, panelid, groupid, workflowid) VALUES (92, 2, 1020, 1);
INSERT INTO ui.panelaccessmap (panelaccessmap, panelid, groupid, workflowid) VALUES (93, 3, 1020, 1);
INSERT INTO ui.panelaccessmap (panelaccessmap, panelid, groupid, workflowid) VALUES (94, 4, 1020, 1);
INSERT INTO ui.panelaccessmap (panelaccessmap, panelid, groupid, workflowid) VALUES (95, 5, 1020, 1);
INSERT INTO ui.panelaccessmap (panelaccessmap, panelid, groupid, workflowid) VALUES (96, 1, 1021, 1);
INSERT INTO ui.panelaccessmap (panelaccessmap, panelid, groupid, workflowid) VALUES (97, 2, 1021, 1);
INSERT INTO ui.panelaccessmap (panelaccessmap, panelid, groupid, workflowid) VALUES (98, 3, 1021, 1);
INSERT INTO ui.panelaccessmap (panelaccessmap, panelid, groupid, workflowid) VALUES (99, 4, 1021, 1);
INSERT INTO ui.panelaccessmap (panelaccessmap, panelid, groupid, workflowid) VALUES (100, 5, 1021, 1);