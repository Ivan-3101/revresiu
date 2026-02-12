INSERT INTO ui.roledesc (iroleid, dtapproverstamp, dtentrystamp, vcrolename, iapproveruserid, ientryuserid, istatus) VALUES (8, NULL, '2022-11-22 12:30:14.445', 'QC', NULL, NULL, 1);
INSERT INTO ui.roledesc (iroleid, dtapproverstamp, dtentrystamp, vcrolename, iapproveruserid, ientryuserid, istatus) VALUES (9, NULL, '2022-11-22 12:30:14.445', 'IT', NULL, NULL, 1);

INSERT INTO ui.groupdesc (igroupid, dtapproverstamp, dtentrystamp, vcgroupid, vcgroupname, vcgrouptype, iapproveruserid, ientryuserid, istatus) VALUES (1029, NULL, NULL, 'qc', 'QC', 'WORKFLOW', NULL, NULL, 1);
INSERT INTO ui.groupdesc (igroupid, dtapproverstamp, dtentrystamp, vcgroupid, vcgroupname, vcgrouptype, iapproveruserid, ientryuserid, istatus) VALUES (1030, NULL, NULL, 'it', 'IT', 'WORKFLOW', NULL, NULL, 1);

INSERT INTO ui.rolemenuaccessmap (irolemenumapid, badd, bapprove, bdelete, bedit, bpublish, bview, dtapproverstamp, dtentrystamp, istatus, iapproveruserid, ientryuserid, imenuid, iroleid) VALUES (685, true, true, true, true, true, false, NULL, NULL, true, NULL, NULL, 482, 8);
INSERT INTO ui.rolemenuaccessmap (irolemenumapid, badd, bapprove, bdelete, bedit, bpublish, bview, dtapproverstamp, dtentrystamp, istatus, iapproveruserid, ientryuserid, imenuid, iroleid) VALUES (686, true, true, true, true, true, false, NULL, NULL, true, NULL, NULL, 501, 8);
INSERT INTO ui.rolemenuaccessmap (irolemenumapid, badd, bapprove, bdelete, bedit, bpublish, bview, dtapproverstamp, dtentrystamp, istatus, iapproveruserid, ientryuserid, imenuid, iroleid) VALUES (687, true, true, true, true, true, true, NULL, NULL, true, NULL, NULL, 514, 8);

INSERT INTO ui.rolemenuaccessmap (irolemenumapid, badd, bapprove, bdelete, bedit, bpublish, bview, dtapproverstamp, dtentrystamp, istatus, iapproveruserid, ientryuserid, imenuid, iroleid) VALUES (688, true, true, true, true, true, false, NULL, NULL, true, NULL, NULL, 482, 9);
INSERT INTO ui.rolemenuaccessmap (irolemenumapid, badd, bapprove, bdelete, bedit, bpublish, bview, dtapproverstamp, dtentrystamp, istatus, iapproveruserid, ientryuserid, imenuid, iroleid) VALUES (689, true, true, true, true, true, false, NULL, NULL, true, NULL, NULL, 501, 9);
INSERT INTO ui.rolemenuaccessmap (irolemenumapid, badd, bapprove, bdelete, bedit, bpublish, bview, dtapproverstamp, dtentrystamp, istatus, iapproveruserid, ientryuserid, imenuid, iroleid) VALUES (690, true, true, true, true, true, true, NULL, NULL, true, NULL, NULL, 514, 9);

INSERT INTO ui.panelaccessmap (panelaccessmap, panelid, groupid, workflowid) VALUES (71, 1, 1029, 5);
INSERT INTO ui.panelaccessmap (panelaccessmap, panelid, groupid, workflowid) VALUES (72, 2, 1029, 5);
INSERT INTO ui.panelaccessmap (panelaccessmap, panelid, groupid, workflowid) VALUES (73, 3, 1029, 5);
INSERT INTO ui.panelaccessmap (panelaccessmap, panelid, groupid, workflowid) VALUES (74, 4, 1029, 5);
INSERT INTO ui.panelaccessmap (panelaccessmap, panelid, groupid, workflowid) VALUES (75, 5, 1029, 5);

INSERT INTO ui.panelaccessmap (panelaccessmap, panelid, groupid, workflowid) VALUES (76, 1, 1030, 4);
INSERT INTO ui.panelaccessmap (panelaccessmap, panelid, groupid, workflowid) VALUES (77, 2, 1030, 4);
INSERT INTO ui.panelaccessmap (panelaccessmap, panelid, groupid, workflowid) VALUES (78, 3, 1030, 4);
INSERT INTO ui.panelaccessmap (panelaccessmap, panelid, groupid, workflowid) VALUES (79, 4, 1030, 4);
INSERT INTO ui.panelaccessmap (panelaccessmap, panelid, groupid, workflowid) VALUES (80, 5, 1030, 4);