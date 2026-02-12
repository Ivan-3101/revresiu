DELETE FROM ui.rulestempaudit;
DELETE FROM ui.transactionclassesaudit;
DELETE FROM ui.decisionsworkflowaudit;
DELETE FROM ui.decisionsaudit;
DELETE FROM ui.rules;
DELETE FROM ui.transactionclasses;
DELETE FROM ui.decisions;
DELETE FROM masters.rules where iruleid>=1000;
Alter Table ui.decisions Add masterdecisionid integer;
Alter Sequence ui.rules_iruleid_seq Restart with 1;
Alter Sequence ui.transactionclasses_iclassid_seq Restart with 1;
Alter Sequence ui.decisions_seq Restart with 1;
Alter Table ui.decisionsaudit Add Column isapproved boolean;
Alter Table ui.transactionclassesaudit Add Column idecisionauditid integer,Add Constraint fkc5e2mw444dubtfowgcb47jojc Foreign Key (idecisionauditid) REFERENCES ui.decisionsaudit (idecisionauditid) MATCH SIMPLE ON UPDATE NO ACTION ON DELETE NO ACTION;
UPDATE ui.decisionsaudit SET isapproved=true;
Alter Table ui.transactionclassesaudit alter idecisionid drop not null;
Alter Table ui.rules Drop Constraint fkh2s3a76gcpgau4tlan4sohwm8;
Alter Table ui.rules Add Constraint fkh2s3a76gcpgau4tlan4sohwm8 Foreign Key (idecisionid) REFERENCES ui.decisions (idecisionid) MATCH SIMPLE ON UPDATE NO ACTION ON DELETE NO ACTION;

INSERT INTO ui.decisions(
	idecisionid,dtentrydatetime, irecordstatus, vcdecisiondetail, vcdecisionmapinfo, vcdecisionname, vcresultparams, iproductid, iuserid,bactive,masterdecisionid)
	Select idecisionid,dtentrydatetime, irecordstatus, vcdecisiondetail, vcdecisionmapinfo, vcdecisionname, vcresultparams, iproductid, iuserid,bactive,idecisionid from masters.decisions order by idecisionid asc;
	
INSERT INTO ui.transactionclasses(
	iclassid,vcclassname, iproductid, ichannelid, idecisionid, bpayermandatory, bpayeemandatory, bactive, irecordstatus, dtentrydatetime, vcdecisionparams)
	Select iclassid,vcclassname, iproductid, ichannelid, idecisionid, bpayermandatory, bpayeemandatory, bactive, irecordstatus, dtentrydatetime, vcdecisionparams
 from masters.transactionclasses order by iclassid asc;


UPDATE ui.decisions SET  dtapproverstamp=current_timestamp,  istatus=1, laststatus='Approved', latestremark='All Correct';

UPDATE ui.transactionclasses SET  dtapproverstamp=current_timestamp,  istatus=1, laststatus='Approved', latestremark='All Correct';

INSERT INTO ui.rules(iruleid,idecisionid, vcrulename, vcruledescription, vcruledetail, iversion, dtstartdate, vcrulemapinfo, vcbpmnfilelocation, bactive, dtentrydatetime, iuserid, vcruleparams, vcruleorder, bcustom, bdelete)
	Select iruleid,idecisionid, vcrulename, vcruledescription, vcruledetail, iversion, dtstartdate, vcrulemapinfo, vcbpmnfilelocation, bactive, dtentrydatetime, iuserid, vcruleparams, vcruleorder, bcustom, bdelete from masters.rules order by iruleid asc;

UPDATE ui.rules as uirules SET  iruleavailableid= mastersrules.iruleavailableid,vclabel=mastersrules.vclabel,ruledimension=mastersrules.ruledimension,rulestate=mastersrules.rulestate,vcruletype=mastersrules.vcruletype from masters.rulesavailable as mastersrules where mastersrules.vcrulename=uirules.vcrulename;

UPDATE ui.rules	SET iinstance=0, dtapproverstamp=current_timestamp, dtentrystamp=current_timestamp;

UPDATE ui.transactionclasses SET  idecisionid=decision.idecisionid From ui.transactionclasses as tc,ui.decisions as decision WHERE tc.idecisionid=decision.masterdecisionid;
Update ui.rules SET idecisionid=decision.idecisionid From ui.rules as tc,ui.decisions as decision WHERE tc.idecisionid=decision.masterdecisionid;

INSERT INTO ui.menustructuredesc (imenuid, bcollapse, dtapproverstamp, dtentrystamp, isortorder, vcaction, vccontroller, vchelptip, vcicon, vclayout, vcmenuname, vcmini, vcpath, vcrtlmini, vcrtlname, vcstate, ispproveruserid, ientryuserid, iparentmenu, istatus) VALUES (537, false, NULL, NULL, 4, 'Delete Transaction Class', 'DeleteTransactionClass', NULL, NULL, '/user', 'Delete Transaction Class', 'DTC', '/masters/class-to-decision-configurator/delete-class', NULL, NULL, NULL, NULL, NULL, 521, 1);
INSERT INTO ui.menustructuredesc (imenuid, bcollapse, dtapproverstamp, dtentrystamp, isortorder, vcaction, vccontroller, vchelptip, vcicon, vclayout, vcmenuname, vcmini, vcpath, vcrtlmini, vcrtlname, vcstate, ispproveruserid, ientryuserid, iparentmenu, istatus) VALUES (538, false, NULL, NULL, 5, 'Approve Delete Transaction Class', 'ApproveDeleteTransactionClass', NULL, NULL, '/user', 'Approve Delete Transaction Class', 'ADTC', '/masters/class-to-decision-configurator/approve-delete-class', NULL, NULL, NULL, NULL, NULL, 521, 1);
INSERT INTO ui.menustructuredesc (imenuid, bcollapse, dtapproverstamp, dtentrystamp, isortorder, vcaction, vccontroller, vchelptip, vcicon, vclayout, vcmenuname, vcmini, vcpath, vcrtlmini, vcrtlname, vcstate, ispproveruserid, ientryuserid, iparentmenu, istatus) VALUES (539, false, NULL, NULL, 6, 'Approve Edit Transaction Class', 'ApproveEditTransactionClass', NULL, NULL, '/user', 'Approve Edit Transaction Class', 'AETC', '/masters/class-to-decision-configurator/approve-edit-class', NULL, NULL, NULL, NULL, NULL, 521, 1);
INSERT INTO ui.menustructuredesc (imenuid, bcollapse, dtapproverstamp, dtentrystamp, isortorder, vcaction, vccontroller, vchelptip, vcicon, vclayout, vcmenuname, vcmini, vcpath, vcrtlmini, vcrtlname, vcstate, ispproveruserid, ientryuserid, iparentmenu, istatus) VALUES (540, false, NULL, NULL, 3, 'Approve Delete Decision', 'ApproveEditDecision', NULL, NULL, '/user', 'Approve Delete Decision', 'ADD', '/masters/decision-levels-and-workflow/approve-delete-decision', NULL, NULL, NULL, NULL, NULL, 522, 1);
INSERT INTO ui.menustructuredesc (imenuid, bcollapse, dtapproverstamp, dtentrystamp, isortorder, vcaction, vccontroller, vchelptip, vcicon, vclayout, vcmenuname, vcmini, vcpath, vcrtlmini, vcrtlname, vcstate, ispproveruserid, ientryuserid, iparentmenu, istatus) VALUES (541, false, NULL, NULL, 4, 'Delete Decision', 'DeleteDecision', NULL, NULL, '/user', 'Delete Decision', 'DD', '/masters/decision-levels-and-workflow/delete-decision', NULL, NULL, NULL, NULL, NULL, 522, 1);

INSERT INTO ui.rolemenuaccessmap (irolemenumapid, badd, bapprove, bdelete, bedit, bpublish, bview, dtapproverstamp, dtentrystamp, istatus, iapproveruserid, ientryuserid, imenuid, iroleid) VALUES (649, true, true, true, true, true, true, NULL, NULL, true, NULL, NULL, 537, 1);
INSERT INTO ui.rolemenuaccessmap (irolemenumapid, badd, bapprove, bdelete, bedit, bpublish, bview, dtapproverstamp, dtentrystamp, istatus, iapproveruserid, ientryuserid, imenuid, iroleid) VALUES (650, true, true, true, true, true, true, NULL, NULL, true, NULL, NULL, 538, 1);
INSERT INTO ui.rolemenuaccessmap (irolemenumapid, badd, bapprove, bdelete, bedit, bpublish, bview, dtapproverstamp, dtentrystamp, istatus, iapproveruserid, ientryuserid, imenuid, iroleid) VALUES (651, true, true, true, true, true, true, NULL, NULL, true, NULL, NULL, 539, 1);
INSERT INTO ui.rolemenuaccessmap (irolemenumapid, badd, bapprove, bdelete, bedit, bpublish, bview, dtapproverstamp, dtentrystamp, istatus, iapproveruserid, ientryuserid, imenuid, iroleid) VALUES (652, true, true, true, true, true, true, NULL, NULL, true, NULL, NULL, 540, 1);
INSERT INTO ui.rolemenuaccessmap (irolemenumapid, badd, bapprove, bdelete, bedit, bpublish, bview, dtapproverstamp, dtentrystamp, istatus, iapproveruserid, ientryuserid, imenuid, iroleid) VALUES (653, true, true, true, true, true, true, NULL, NULL, true, NULL, NULL, 541, 1);

UPDATE ui.menustructuredesc SET  vcaction='Approve Add Transaction Class', vccontroller='ApproveAddTransactionClass', vcmenuname='Approve Add Transaction Class', vcmini='AATC', vcpath='/masters/class-to-decision-configurator/approve-add-class'	WHERE vcmenuname='Approve Transaction Class';

UPDATE ui.menustructuredesc SET  vcaction='Approve Edit Decision', vccontroller='ApproveEditDecision', vcmenuname='Approve Edit Decision', vcmini='AED', vcpath='/masters/decision-levels-and-workflow/approve-edit-decision'WHERE vcmenuname='Approve Decision';

SELECT setval('ui."rules_iruleid_seq"', (SELECT MAX(iruleid) FROM masters.rules));
SELECT setval('ui."transactionclasses_iclassid_seq"', (SELECT MAX(iclassid) FROM masters.transactionclasses));
SELECT setval('ui."decisions_seq"', (SELECT MAX(idecisionid) FROM masters.decisions));