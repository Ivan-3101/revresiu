INSERT INTO ui.menustructuredesc (imenuid, bcollapse, dtapproverstamp, dtentrystamp, isortorder, vcaction, vccontroller, vchelptip, vcicon, vclayout, vcmenuname, vcmini, vcpath, vcrtlmini, vcrtlname, vcstate, ispproveruserid, ientryuserid, iparentmenu, istatus) VALUES (521, false, NULL, NULL, 0, 'Transaction To Decision', 'TransactionToDecision', NULL, NULL, '/user', 'Transaction To Decision', 'TD', '/masters/transaction-to-decision', NULL, NULL, NULL, NULL, NULL, 481, 1);
INSERT INTO ui.menustructuredesc (imenuid, bcollapse, dtapproverstamp, dtentrystamp, isortorder, vcaction, vccontroller, vchelptip, vcicon, vclayout, vcmenuname, vcmini, vcpath, vcrtlmini, vcrtlname, vcstate, ispproveruserid, ientryuserid, iparentmenu, istatus) VALUES (522, false, NULL, NULL, 4, 'Decision To Workflow', 'DecisionToWorkflow', NULL, NULL, '/user', 'Decision To Workflow', 'DW', '/masters/decision-to-workflow', NULL, NULL, NULL, NULL, NULL, 481, 1);

UPDATE ui.menustructuredesc SET isortorder=1 WHERE imenuid=499;
UPDATE ui.menustructuredesc SET isortorder=2 WHERE imenuid=500;
UPDATE ui.menustructuredesc SET isortorder=3 WHERE imenuid=504;

INSERT INTO ui.rolemenuaccessmap (irolemenumapid, badd, bapprove, bdelete, bedit, bpublish, bview, dtapproverstamp, dtentrystamp, istatus, iapproveruserid, ientryuserid, imenuid, iroleid) VALUES (630, true, true, true, true, true, true, NULL, NULL, true, NULL, NULL, 521, 1);
INSERT INTO ui.rolemenuaccessmap (irolemenumapid, badd, bapprove, bdelete, bedit, bpublish, bview, dtapproverstamp, dtentrystamp, istatus, iapproveruserid, ientryuserid, imenuid, iroleid) VALUES (631, true, true, true, true, true, true, NULL, NULL, true, NULL, NULL, 522, 1);
