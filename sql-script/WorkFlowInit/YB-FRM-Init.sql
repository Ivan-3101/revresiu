DELETE  FROM ui.panelaccessmap;
DELETE FROM ui.workflowmasters;

INSERT INTO ui.workflowmasters (workflowid, workflowname, workflowkey) VALUES (6, 'Blocked Settlements', 'YbFrmBlockSettlement');
INSERT INTO ui.workflowmasters (workflowid, workflowname, workflowkey) VALUES (12, 'Risk Alert', 'YbFrmAlert');


INSERT INTO ui.panelaccessmap (panelaccessmap, panelid, groupid, workflowid) VALUES (81, 1, 1020, 6);
INSERT INTO ui.panelaccessmap (panelaccessmap, panelid, groupid, workflowid) VALUES (82, 2, 1020, 6);
INSERT INTO ui.panelaccessmap (panelaccessmap, panelid, groupid, workflowid) VALUES (83, 3, 1020, 6);
INSERT INTO ui.panelaccessmap (panelaccessmap, panelid, groupid, workflowid) VALUES (84, 4, 1020, 6);
INSERT INTO ui.panelaccessmap (panelaccessmap, panelid, groupid, workflowid) VALUES (85, 5, 1020, 6);
INSERT INTO ui.panelaccessmap (panelaccessmap, panelid, groupid, workflowid) VALUES (86, 1, 1021, 6);
INSERT INTO ui.panelaccessmap (panelaccessmap, panelid, groupid, workflowid) VALUES (87, 2, 1021, 6);
INSERT INTO ui.panelaccessmap (panelaccessmap, panelid, groupid, workflowid) VALUES (88, 3, 1021, 6);
INSERT INTO ui.panelaccessmap (panelaccessmap, panelid, groupid, workflowid) VALUES (89, 4, 1021, 6);
INSERT INTO ui.panelaccessmap (panelaccessmap, panelid, groupid, workflowid) VALUES (90, 5, 1021, 6);


INSERT INTO ui.panelaccessmap (panelaccessmap, panelid, groupid, workflowid) VALUES (134, 1, 1020, 12);
INSERT INTO ui.panelaccessmap (panelaccessmap, panelid, groupid, workflowid) VALUES (135, 2, 1020, 12);
INSERT INTO ui.panelaccessmap (panelaccessmap, panelid, groupid, workflowid) VALUES (136, 3, 1020, 12);
INSERT INTO ui.panelaccessmap (panelaccessmap, panelid, groupid, workflowid) VALUES (137, 4, 1020, 12);
INSERT INTO ui.panelaccessmap (panelaccessmap, panelid, groupid, workflowid) VALUES (138, 5, 1020, 12);
INSERT INTO ui.panelaccessmap (panelaccessmap, panelid, groupid, workflowid) VALUES (139, 1, 1021, 12);
INSERT INTO ui.panelaccessmap (panelaccessmap, panelid, groupid, workflowid) VALUES (140, 2, 1021, 12);
INSERT INTO ui.panelaccessmap (panelaccessmap, panelid, groupid, workflowid) VALUES (141, 3, 1021, 12);
INSERT INTO ui.panelaccessmap (panelaccessmap, panelid, groupid, workflowid) VALUES (142, 4, 1021, 12);
INSERT INTO ui.panelaccessmap (panelaccessmap, panelid, groupid, workflowid) VALUES (143, 5, 1021, 12);