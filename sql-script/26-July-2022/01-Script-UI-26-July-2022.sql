DELETE FROM ui.perspectivequeryparameters
WHERE iperspectiveparameterid=38;
DELETE FROM ui.perspectivequeryparameters
WHERE iperspectiveparameterid=32;

UPDATE ui.perspectivequeryparameters
SET iposition=4, vcparametername='iLiveMsgID', vcparametertype='Integer'
WHERE iperspectiveparameterid=27;

UPDATE ui.perspectivequeryparameters
SET iposition=4, vcparametername='iLiveMsgID', vcparametertype='Integer'
WHERE iperspectiveparameterid=33;

UPDATE ui.perspectivequery
SET  vcquery='SELECT * from ui.gettxnprofilebyclass(
	:vpaType,
	:txnType,
	:timeZone,
	:iLiveMsgID,
	:vpaAddress,
	:txnClass,
	20
)'
WHERE iperspectivequeryid=22;

UPDATE ui.perspectivequery
SET  vcquery='SELECT * from ui.gettxnprofile(
	:vpaType,
	:txnType,
	:timeZone,
	:iLiveMsgID,
	:vpaAddress,
	20
)'
WHERE iperspectivequeryid=23;

INSERT INTO ui.menustructuredesc ( bcollapse, dtapproverstamp, dtentrystamp, isortorder, vcaction, vccontroller, vchelptip, vcicon, vclayout, vcmenuname, vcmini, vcpath, vcrtlmini, vcrtlname, vcstate, ispproveruserid, ientryuserid, iparentmenu, istatus) VALUES ( false, NULL, NULL, 4, 'Alert Dashboard', 'AlertDashboard', NULL, NULL, '/user', 'Alert Dashboard', 'AD', '/analytics/alert-dashboard', NULL, NULL, NULL, NULL, NULL, 478, 1);
INSERT INTO ui.rolemenuaccessmap ( badd, bapprove, bdelete, bedit, bpublish, bview, dtapproverstamp, dtentrystamp, istatus, iapproveruserid, ientryuserid, imenuid, iroleid) VALUES ( true, true, true, true, true, true, NULL, NULL, true, NULL, NULL, (select imenuid from ui.menustructuredesc where vccontroller='AlertDashboard'), 1);


update ui.perspectivequery set vctablename='selectedTransactionbymsgid' where iperspectivequeryid=24;

INSERT INTO ui.perspectivequery (iperspectivequeryid, vcquery, vctablename) VALUES (25, 'SELECT * from ui.gettxnprofileselectedtxn(
	:vpaType,
	:timeZone,
	:msgid,
	:vpaAddress,
	:txnDate
)', 'selectedTransaction');

INSERT INTO ui.perspectivequery (iperspectivequeryid, vcquery, vctablename) VALUES (26, 'SELECT * from ui.gettxnprofileselectedtxnbyclass(
	:vpaType,
	:timeZone,
	:msgid,
	:vpaAddress,
	:txnClass,
	:txnDate
)', 'selectedTransactionbyclass');


INSERT INTO ui.perspectivequeryparameters(iperspectiveparameterid, iposition, vcparametername, vcparametertype, iperspectivequeryid)VALUES (34, 1, 'vpaType', 'String', 25);
INSERT INTO ui.perspectivequeryparameters(iperspectiveparameterid, iposition, vcparametername, vcparametertype, iperspectivequeryid)VALUES (35, 3, 'msgid', 'String', 25);
INSERT INTO ui.perspectivequeryparameters(iperspectiveparameterid, iposition, vcparametername, vcparametertype, iperspectivequeryid)VALUES (36, 4, 'vpaAddress', 'String', 25);
INSERT INTO ui.perspectivequeryparameters(iperspectiveparameterid, iposition, vcparametername, vcparametertype, iperspectivequeryid)VALUES (37, 5, 'txnDate', 'Date', 25);

INSERT INTO ui.perspectivequeryparameters(iperspectiveparameterid, iposition, vcparametername, vcparametertype, iperspectivequeryid)VALUES (38, 1, 'vpaType', 'String', 26);
INSERT INTO ui.perspectivequeryparameters(iperspectiveparameterid, iposition, vcparametername, vcparametertype, iperspectivequeryid)VALUES (39, 3, 'msgid', 'String', 26);
INSERT INTO ui.perspectivequeryparameters(iperspectiveparameterid, iposition, vcparametername, vcparametertype, iperspectivequeryid)VALUES (40, 4, 'vpaAddress', 'String', 26);
INSERT INTO ui.perspectivequeryparameters(iperspectiveparameterid, iposition, vcparametername, vcparametertype, iperspectivequeryid)VALUES (41, 5, 'txnClass', 'String', 26);
INSERT INTO ui.perspectivequeryparameters(iperspectiveparameterid, iposition, vcparametername, vcparametertype, iperspectivequeryid)VALUES (42, 6, 'txnDate', 'Date', 26);


