INSERT INTO ui.roledesc (iroleid, dtapproverstamp, dtentrystamp, vcrolename, iapproveruserid, ientryuserid, istatus, imenustructuredesc) VALUES (11, NULL, '2023-10-16 21:02:14.426', 'CUB Analyst', NULL, NULL, 1, NULL);
INSERT INTO ui.roledesc (iroleid, dtapproverstamp, dtentrystamp, vcrolename, iapproveruserid, ientryuserid, istatus, imenustructuredesc) VALUES (12, NULL, '2023-10-16 21:02:14.426', 'USFB Analyst', NULL, NULL, 1, NULL);


INSERT INTO ui.groupdesc (igroupid, dtapproverstamp, dtentrystamp, vcgroupid, vcgroupname, vcgrouptype, iapproveruserid, ientryuserid, istatus) VALUES (1031, NULL, NULL, 'CUBAnalyst', 'CUB Analyst', 'WORKFLOW', NULL, NULL, 1);

INSERT INTO ui.groupdesc (igroupid, dtapproverstamp, dtentrystamp, vcgroupid, vcgroupname, vcgrouptype, iapproveruserid, ientryuserid, istatus) VALUES (1032, NULL, NULL, 'USFBAnalyst', 'USFB Analyst', 'WORKFLOW', NULL, NULL, 1);


INSERT INTO ui.grouptotaskfiltermap(igrouptotaskfilterid, iposition, igroupid, itaskfilterid) VALUES (99, 1, 1031, 1);
INSERT INTO ui.grouptotaskfiltermap(igrouptotaskfilterid, iposition, igroupid, itaskfilterid) VALUES (100, 2, 1031, 2);
INSERT INTO ui.grouptotaskfiltermap(igrouptotaskfilterid, iposition, igroupid, itaskfilterid) VALUES (101, 3, 1031, 3);
INSERT INTO ui.grouptotaskfiltermap(igrouptotaskfilterid, iposition, igroupid, itaskfilterid) VALUES (102, 4, 1031, 4);
INSERT INTO ui.grouptotaskfiltermap(igrouptotaskfilterid, iposition, igroupid, itaskfilterid) VALUES (103, 5, 1031, 5);
INSERT INTO ui.grouptotaskfiltermap(igrouptotaskfilterid, iposition, igroupid, itaskfilterid) VALUES (104, 6, 1031, 6);
INSERT INTO ui.grouptotaskfiltermap(igrouptotaskfilterid, iposition, igroupid, itaskfilterid) VALUES (105, 7, 1031, 7);
INSERT INTO ui.grouptotaskfiltermap(igrouptotaskfilterid, iposition, igroupid, itaskfilterid) VALUES (106, 8, 1031, 8);
INSERT INTO ui.grouptotaskfiltermap(igrouptotaskfilterid, iposition, igroupid, itaskfilterid) VALUES (107, 9, 1031, 9);

INSERT INTO ui.grouptotaskfiltermap(igrouptotaskfilterid, iposition, igroupid, itaskfilterid) VALUES (109, 1, 1032, 1);
INSERT INTO ui.grouptotaskfiltermap(igrouptotaskfilterid, iposition, igroupid, itaskfilterid) VALUES (110, 2, 1032, 2);
INSERT INTO ui.grouptotaskfiltermap(igrouptotaskfilterid, iposition, igroupid, itaskfilterid) VALUES (111, 3, 1032, 3);
INSERT INTO ui.grouptotaskfiltermap(igrouptotaskfilterid, iposition, igroupid, itaskfilterid) VALUES (112, 4, 1032, 4);
INSERT INTO ui.grouptotaskfiltermap(igrouptotaskfilterid, iposition, igroupid, itaskfilterid) VALUES (113, 5, 1032, 5);
INSERT INTO ui.grouptotaskfiltermap(igrouptotaskfilterid, iposition, igroupid, itaskfilterid) VALUES (114, 6, 1032, 6);
INSERT INTO ui.grouptotaskfiltermap(igrouptotaskfilterid, iposition, igroupid, itaskfilterid) VALUES (115, 7, 1032, 7);
INSERT INTO ui.grouptotaskfiltermap(igrouptotaskfilterid, iposition, igroupid, itaskfilterid) VALUES (116, 8, 1032, 8);
INSERT INTO ui.grouptotaskfiltermap(igrouptotaskfilterid, iposition, igroupid, itaskfilterid) VALUES (117, 9, 1032, 9);



INSERT INTO ui.panelaccessmap(panelaccessmap, panelid, groupid, workflowid)	VALUES (162, 1, 1031, 13);
INSERT INTO ui.panelaccessmap(panelaccessmap, panelid, groupid, workflowid)	VALUES (163, 2, 1031, 13);
INSERT INTO ui.panelaccessmap(panelaccessmap, panelid, groupid, workflowid)	VALUES (164, 3, 1031, 13);
INSERT INTO ui.panelaccessmap(panelaccessmap, panelid, groupid, workflowid)	VALUES (165, 4, 1031, 13);
INSERT INTO ui.panelaccessmap(panelaccessmap, panelid, groupid, workflowid)	VALUES (166, 5, 1031, 13);

INSERT INTO ui.panelaccessmap(panelaccessmap, panelid, groupid, workflowid)	VALUES (167, 1, 1032, 13);
INSERT INTO ui.panelaccessmap(panelaccessmap, panelid, groupid, workflowid)	VALUES (168, 2, 1032, 13);
INSERT INTO ui.panelaccessmap(panelaccessmap, panelid, groupid, workflowid)	VALUES (169, 3, 1032, 13);
INSERT INTO ui.panelaccessmap(panelaccessmap, panelid, groupid, workflowid)	VALUES (170, 4, 1032, 13);
INSERT INTO ui.panelaccessmap(panelaccessmap, panelid, groupid, workflowid)	VALUES (171, 5, 1032, 13);

INSERT INTO ui.panelaccessmap(panelaccessmap, panelid, groupid, workflowid)	VALUES (172, 1, 1032, 14);
INSERT INTO ui.panelaccessmap(panelaccessmap, panelid, groupid, workflowid)	VALUES (173, 2, 1032, 14);
INSERT INTO ui.panelaccessmap(panelaccessmap, panelid, groupid, workflowid)	VALUES (174, 3, 1032, 14);
INSERT INTO ui.panelaccessmap(panelaccessmap, panelid, groupid, workflowid)	VALUES (175, 4, 1032, 14);
INSERT INTO ui.panelaccessmap(panelaccessmap, panelid, groupid, workflowid)	VALUES (176, 5, 1032, 14);

INSERT INTO ui.panelaccessmap(panelaccessmap, panelid, groupid, workflowid)	VALUES (177, 1, 1031, 14);
INSERT INTO ui.panelaccessmap(panelaccessmap, panelid, groupid, workflowid)	VALUES (178, 2, 1031, 14);
INSERT INTO ui.panelaccessmap(panelaccessmap, panelid, groupid, workflowid)	VALUES (180, 3, 1031, 14);
INSERT INTO ui.panelaccessmap(panelaccessmap, panelid, groupid, workflowid)	VALUES (181, 4, 1031, 14);
INSERT INTO ui.panelaccessmap(panelaccessmap, panelid, groupid, workflowid)	VALUES (182, 5, 1031, 14);

INSERT INTO ui.rolemenuaccessmap (badd, bapprove, bdelete, bedit, bpublish, bview, dtapproverstamp, dtentrystamp, istatus, iapproveruserid, ientryuserid, imenuid, iroleid) VALUES (true, true, true, true, true, true, NULL, NULL, true, NULL, NULL, 479, 11);
INSERT INTO ui.rolemenuaccessmap (badd, bapprove, bdelete, bedit, bpublish, bview, dtapproverstamp, dtentrystamp, istatus, iapproveruserid, ientryuserid, imenuid, iroleid) VALUES (true, true, true, true, true, true, NULL, NULL, true, NULL, NULL, 494, 11);

INSERT INTO ui.rolemenuaccessmap (badd, bapprove, bdelete, bedit, bpublish, bview, dtapproverstamp, dtentrystamp, istatus, iapproveruserid, ientryuserid, imenuid, iroleid) VALUES (true, true, true, true, true, true, NULL, NULL, true, NULL, NULL, 479, 12);
INSERT INTO ui.rolemenuaccessmap (badd, bapprove, bdelete, bedit, bpublish, bview, dtapproverstamp, dtentrystamp, istatus, iapproveruserid, ientryuserid, imenuid, iroleid) VALUES (true, true, true, true, true, true, NULL, NULL, true, NULL, NULL, 494, 12);

UPDATE ui.dashboardquery SET imenustructuredesc = 494 WHERE idashboardqueryid=46;